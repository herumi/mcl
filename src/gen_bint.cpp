#include "llvm_gen.hpp" // in mcl/src
#include <cybozu/option.hpp>
#include <mcl/config.hpp>
#include <map>
#include <set>
#include <fstream>

typedef std::set<std::string> StrSet;

struct Code : public mcl::Generator {
	typedef std::map<int, Function> FunctionMap;
	typedef std::vector<Operand> OperandVec;
	Operand Void;
	uint32_t unit;
	uint32_t unit2;
	uint32_t bit;
	uint32_t N;
	std::string suf;
	std::string unitStr;
	Function mulUU;
	Function extractHigh;
	Function mulPos;
	FunctionMap mclb_addM;
	FunctionMap mclb_subM;
	FunctionMap mclb_mulUnitM;
	FunctionMap mclb_mulUnitAddM;
	FunctionMap mulUnit_innerM;
	FunctionMap mulUnit2_innerM; // the N-unit bottom of (x[N] * y)
	FunctionMap mul_innerM;
	FunctionMap mclb_mulM;
	FunctionMap mclb_mulLowM;
	FunctionMap mclb_sqrM;
	FunctionMap mclb_addNFM;
	FunctionMap mclb_subNFM;

	Function makeNIST_P192;
	Function mcl_fpDbl_mod_NIST_P192;
	Function mcl_fp_sqr_NIST_P192;
	FunctionMap mcl_fp_shr1_M;
	FunctionMap mcl_fp_addM;
	FunctionMap mcl_fp_subM;
	FunctionMap mcl_fp_mulUnitPreM;
	FunctionMap mcl_fp_montM;
	FunctionMap mcl_fp_montRedM;
	Code() : unit(0), unit2(0), bit(0), N(0) { }

	void verifyAndSetPrivate(Function&) {}
	void storeN(Operand r, Operand p, int offset = 0)
	{
		if (p.bit != unit) {
			throw cybozu::Exception("bad IntPtr size") << p.bit;
		}
		if (offset > 0) {
			p = getelementptr(p, offset);
		}
#if 1
		const size_t n = r.bit / unit;
		if (n > 1) {
			p = bitcast(p, Operand(IntPtr, unit * n));
		}
		store(r, p);
#else
		if (r.bit == unit) {
			store(r, p);
			return;
		}
		const size_t n = r.bit / unit;
		for (uint32_t i = 0; i < n; i++) {
			Operand pp = getelementptr(p, i);
			Operand t = trunc(r, unit);
			store(t, pp);
			if (i < n - 1) {
				r = lshr(r, unit);
			}
		}
#endif
	}
	Operand loadN(Operand p, size_t n, int offset = 0)
	{
		if (p.bit != unit) {
			throw cybozu::Exception("bad IntPtr size") << p.bit;
		}
		if (offset > 0) {
			p = getelementptr(p, offset);
		}
		if (n > 1) {
			p = bitcast(p, Operand(IntPtr, unit * n));
		}
		return load(p);
	}
	void gen_mulUU()
	{
		resetGlobalIdx();
		Operand z(Int, unit2);
		Operand x(Int, unit);
		Operand y(Int, unit);
		std::string name = "mul";
		name += unitStr + "x" + unitStr + "L";
		mulUU = Function(name, z, x, y);
		mulUU.setPrivate();
		verifyAndSetPrivate(mulUU);
		beginFunc(mulUU);

		x = zext(x, unit2);
		y = zext(y, unit2);
		z = mul(x, y);
		ret(z);
		endFunc();
	}
	void gen_mulPos()
	{
		resetGlobalIdx();
		Operand xy(Int, unit2);
		Operand px(IntPtr, unit);
		Operand y(Int, unit);
		Operand i(Int, unit);
		std::string name = "mulPos";
		name += unitStr + "x" + unitStr;
		mulPos = Function(name, xy, px, y, i);
		mulPos.setPrivate();
		beginFunc(mulPos);

		Operand x = load(getelementptr(px, i));
		xy = call(mulUU, x, y);
		ret(xy);
		endFunc();
	}
	void gen_extractHigh()
	{
		resetGlobalIdx();
		Operand z(Int, unit);
		Operand x(Int, unit2);
		std::string name = "extractHigh";
		name += unitStr;
		extractHigh = Function(name, z, x);
		extractHigh.setPrivate();
		beginFunc(extractHigh);

		x = lshr(x, unit);
		z = trunc(x, unit);
		ret(z);
		endFunc();
	}
	void gen_once()
	{
		gen_mulUU();
		gen_extractHigh();
		gen_mulPos();
	}
	Operand extract(const Operand& x, uint32_t shift)
	{
		Operand t = lshr(x, shift);
		t = trunc(t, unit);
		return t;
	}
	void gen_mclb_addsub(bool isAdd)
	{
		resetGlobalIdx();
		Operand r(Int, unit);
		Operand pz(IntPtr, unit);
		Operand px(IntPtr, unit);
		Operand py(IntPtr, unit);
		std::string name;
		if (isAdd) {
			name = "mclb_add" + cybozu::itoa(N);
			mclb_addM[N] = Function(name, r, pz, px, py);
			verifyAndSetPrivate(mclb_addM[N]);
			beginFunc(mclb_addM[N]);
		} else {
			name = "mclb_sub" + cybozu::itoa(N);
			mclb_subM[N] = Function(name, r, pz, px, py);
			verifyAndSetPrivate(mclb_subM[N]);
			beginFunc(mclb_subM[N]);
		}
		Operand x = zext(loadN(px, N), bit + unit);
		Operand y = zext(loadN(py, N), bit + unit);
		Operand z;
		if (isAdd) {
			z = add(x, y);
			storeN(trunc(z, bit), pz);
			r = trunc(lshr(z, bit), unit);
		} else {
			z = sub(x, y);
			storeN(trunc(z, bit), pz);
			z = trunc(lshr(z, bit), unit);
			r = _and(z, makeImm(unit, 1));
		}
		ret(r);
		endFunc();
	}
	void gen_mclb_addNF()
	{
		resetGlobalIdx();
		Operand pz(IntPtr, unit);
		Operand px(IntPtr, unit);
		Operand py(IntPtr, unit);
		std::string name = "mclb_addNF" + cybozu::itoa(N);
		mclb_addNFM[N] = Function(name, Void, pz, px, py);
		verifyAndSetPrivate(mclb_addNFM[N]);
		beginFunc(mclb_addNFM[N]);
		Operand x = loadN(px, N);
		Operand y = loadN(py, N);
		Operand z = add(x, y);
		storeN(z, pz);
		ret(Void);
		endFunc();
	}
	void gen_mclb_subNF()
	{
		resetGlobalIdx();
		Operand r(Int, unit);
		Operand pz(IntPtr, unit);
		Operand px(IntPtr, unit);
		Operand py(IntPtr, unit);
		std::string name = "mclb_subNF" + cybozu::itoa(N);
		mclb_subNFM[N] = Function(name, r, pz, px, py);
		verifyAndSetPrivate(mclb_subNFM[N]);
		beginFunc(mclb_subNFM[N]);
		Operand x = loadN(px, N);
		Operand y = loadN(py, N);
		Operand z;
		z = sub(x, y);
		storeN(z, pz);
		r = lshr(z, bit - 1);
		if (bit != unit) r = trunc(r, unit);
		r = _and(r, makeImm(unit, 1));
		ret(r);
		endFunc();
	}
	// [r:z[]] = x[] * y
	void gen_mclb_mulUnit()
	{
		resetGlobalIdx();
		Operand r(Int, unit);
		Operand pz(IntPtr, unit);
		Operand px(IntPtr, unit);
		Operand y(Int, unit);
		std::string name = "mclb_mulUnit" + cybozu::itoa(N);
		mclb_mulUnitM[N] = Function(name, r, pz, px, y);
		verifyAndSetPrivate(mclb_mulUnitM[N]);
		beginFunc(mclb_mulUnitM[N]);
#if 1
		Operand z = call(mulUnit_innerM[bit], px, y);
		storeN(trunc(z, bit), pz);
		r = trunc(lshr(z, bit), unit);
		ret(r);
#else

		OperandVec L(N), H(N);
		for (uint32_t i = 0; i < N; i++) {
			Operand xy = call(mulPos, px, y, makeImm(unit, i));
			L[i] = trunc(xy, unit);
			H[i] = call(extractHigh, xy);
		}
		Operand LL = pack(&L[0], N);
		Operand HH = pack(&H[0], N);
		LL = zext(LL, bit + unit);
		HH = zext(HH, bit + unit);
		HH = shl(HH, unit);
		Operand z = add(LL, HH);
		storeN(trunc(z, bit), pz);
		r = trunc(lshr(z, bit), unit);
		ret(r);
#endif
		endFunc();
	}
	// [r:z[]] = z[] + x[] * y
	void gen_mclb_mulUnitAdd()
	{
		resetGlobalIdx();
		Operand r(Int, unit);
		Operand pz(IntPtr, unit);
		Operand px(IntPtr, unit);
		Operand y(Int, unit);
		std::string name = "mclb_mulUnitAdd" + cybozu::itoa(N);
		mclb_mulUnitAddM[N] = Function(name, r, pz, px, y);
		verifyAndSetPrivate(mclb_mulUnitAddM[N]);
		beginFunc(mclb_mulUnitAddM[N]);

		OperandVec L(N), H(N);
		for (uint32_t i = 0; i < N; i++) {
			Operand xy = call(mulPos, px, y, makeImm(unit, i));
			L[i] = trunc(xy, unit);
			H[i] = call(extractHigh, xy);
		}
		Operand LL = pack(&L[0], N);
		Operand HH = pack(&H[0], N);
		LL = zext(LL, bit + unit);
		HH = zext(HH, bit + unit);
		HH = shl(HH, unit);
		Operand z = add(LL, HH);
		z = add(z, zext(loadN(pz, N), bit + unit));
		storeN(trunc(z, bit), pz);
		r = trunc(lshr(z, bit), unit);
		ret(r);
		endFunc();
	}
#if 0
	// this bitcode does not effective asm code
	void gen_mclb_shrRestrected()
	{
		resetGlobalIdx();
		Operand pz(IntPtr, unit);
		Operand px(IntPtr, unit);
		Operand y(Int, unit);
		std::string name = "mclb_shrRestrected" + cybozu::itoa(N);
		mclb_shrRestrectedM[N] = Function(name, Void, pz, px, y);
		verifyAndSetPrivate(mclb_shrRestrectedM[N]);
		beginFunc(mclb_shrRestrectedM[N]);
		Operand x = loadN(px, N);
		y = _and(y, makeImm(unit, unit - 1));
		if (unit != bit) y = zext(y, bit);
		x = lshr(x, y);
		storeN(x, pz);
		ret(Void);
		endFunc();
	}
#endif
	void gen_mcl_fp_shr1()
	{
		resetGlobalIdx();
		Operand py(IntPtr, unit);
		Operand px(IntPtr, unit);
		std::string name = "mcl_fp_shr1_" + cybozu::itoa(N) + "L" + suf;
		mcl_fp_shr1_M[N] = Function(name, Void, py, px);
		verifyAndSetPrivate(mcl_fp_shr1_M[N]);
		beginFunc(mcl_fp_shr1_M[N]);
		Operand x = loadN(px, N);
		x = lshr(x, 1);
		storeN(x, py);
		ret(Void);
		endFunc();
	}
	void gen_mcl_fp_add()
	{
		resetGlobalIdx();
		Operand pz(IntPtr, unit);
		Operand px(IntPtr, unit);
		Operand py(IntPtr, unit);
		Operand pp(IntPtr, unit);
		std::string name = "mcl_fp_add";
		name += cybozu::itoa(N) + "L" + suf;
		mcl_fp_addM[N] = Function(name, Void, pz, px, py, pp);
		verifyAndSetPrivate(mcl_fp_addM[N]);
		beginFunc(mcl_fp_addM[N]);
		Operand x = loadN(px, N);
		Operand y = loadN(py, N);
		x = add(x, y);
		Operand p = loadN(pp, N);
		y = sub(x, p);
		Operand c = trunc(lshr(y, bit - 1), 1);
		x = select(c, x, y);
		storeN(x, pz);
		ret(Void);
		endFunc();
	}
	void gen_mcl_fp_sub()
	{
		resetGlobalIdx();
		Operand pz(IntPtr, unit);
		Operand px(IntPtr, unit);
		Operand py(IntPtr, unit);
		Operand pp(IntPtr, unit);
		std::string name = "mcl_fp_sub";
		name += cybozu::itoa(N) + "L" + suf;
		mcl_fp_subM[N] = Function(name, Void, pz, px, py, pp);
		verifyAndSetPrivate(mcl_fp_subM[N]);
		beginFunc(mcl_fp_subM[N]);
		Operand x = loadN(px, N);
		Operand y = loadN(py, N);
		Operand v = sub(x, y);
		Operand c;
		c = trunc(lshr(v, bit - 1), 1);
		Operand p = loadN(pp, N);
		c = select(c, p, makeImm(bit, 0));
		Operand t = add(v, c);
		storeN(t, pz);
		ret(Void);
		endFunc();
	}
	void gen_mcl_fpDbl_add()
	{
		// QQQ : generate unnecessary memory copy for large bit
		const int bu = bit + unit;
		const int b2 = bit * 2;
		const int b2u = b2 + unit;
		resetGlobalIdx();
		Operand pz(IntPtr, unit);
		Operand px(IntPtr, unit);
		Operand py(IntPtr, unit);
		Operand pp(IntPtr, unit);
		std::string name = "mcl_fpDbl_add" + cybozu::itoa(N) + "L" + suf;
		Function f(name, Void, pz, px, py, pp);
		verifyAndSetPrivate(f);
		beginFunc(f);
		Operand x = loadN(px, N * 2);
		Operand y = loadN(py, N * 2);
		x = zext(x, b2u);
		y = zext(y, b2u);
		Operand t = add(x, y); // x + y = [H:L]
		Operand L = trunc(t, bit);
		storeN(L, pz);

		Operand H = lshr(t, bit);
		H = trunc(H, bu);
		Operand p = loadN(pp, N);
		p = zext(p, bu);
		Operand Hp = sub(H, p);
		t = lshr(Hp, bit);
		t = trunc(t, 1);
		t = select(t, H, Hp);
		t = trunc(t, bit);
		storeN(t, pz, N);
		ret(Void);
		endFunc();
	}
	void gen_mcl_fpDbl_sub()
	{
		// QQQ : rol is used?
		const int b2 = bit * 2;
		const int b2u = b2 + unit;
		resetGlobalIdx();
		std::string name = "mcl_fpDbl_sub" + cybozu::itoa(N) + "L" + suf;
		Operand pz(IntPtr, unit);
		Operand px(IntPtr, unit);
		Operand py(IntPtr, unit);
		Operand pp(IntPtr, unit);
		Function f(name, Void, pz, px, py, pp);
		verifyAndSetPrivate(f);
		beginFunc(f);
		Operand x = loadN(px, N * 2);
		Operand y = loadN(py, N * 2);
		x = zext(x, b2u);
		y = zext(y, b2u);
		Operand vc = sub(x, y); // x - y = [H:L]
		Operand L = trunc(vc, bit);
		storeN(L, pz);

		Operand H = lshr(vc, bit);
		H = trunc(H, bit);
		Operand c = lshr(vc, b2);
		c = trunc(c, 1);
		Operand p = loadN(pp, N);
		c = select(c, p, makeImm(bit, 0));
		Operand t = add(H, c);
		storeN(t, pz, N);
		ret(Void);
		endFunc();
	}
	/*
		return [px[n-1]:px[n-2]:...:px[0]]
	*/
	Operand pack(const Operand *px, size_t n)
	{
		Operand x = px[0];
		for (size_t i = 1; i < n; i++) {
			Operand y = px[i];
			uint32_t shift = x.bit;
			uint32_t size = x.bit + y.bit;
			x = zext(x, size);
			y = zext(y, size);
			y = shl(y, shift);
			x = _or(x, y);
		}
		return x;
	}
	/*
		z = px[0..N] * y
	*/
	void gen_mulUnit_inner()
	{
		const int bu = bit + unit;
		resetGlobalIdx();
		Operand z(Int, bu);
		Operand px(IntPtr, unit);
		Operand y(Int, unit);
		std::string name = "mulUnit_inner" + cybozu::itoa(bit);
		mulUnit_innerM[bit] = Function(name, z, px, y);
		// workaround at https://github.com/herumi/mcl/pull/82
//		mulUnit_innerM[bit].setPrivate();
		verifyAndSetPrivate(mulUnit_innerM[bit]);
		beginFunc(mulUnit_innerM[bit]);
		OperandVec L(N), H(N);
		for (uint32_t i = 0; i < N; i++) {
			Operand xy = call(mulPos, px, y, makeImm(unit, i));
			L[i] = trunc(xy, unit);
			H[i] = call(extractHigh, xy);
		}
		Operand LL = pack(&L[0], N);
		Operand HH = pack(&H[0], N);
		LL = zext(LL, bu);
		HH = zext(HH, bu);
		HH = shl(HH, unit);
		z = add(LL, HH);
		ret(z);
		endFunc();
	}
	void gen_mcl_fp_mulUnitPre()
	{
		resetGlobalIdx();
		Operand pz(IntPtr, unit);
		Operand px(IntPtr, unit);
		Operand y(Int, unit);
		std::string name = "mcl_fp_mulUnitPre" + cybozu::itoa(N) + "L" + suf;
		mcl_fp_mulUnitPreM[N] = Function(name, Void, pz, px, y);
		verifyAndSetPrivate(mcl_fp_mulUnitPreM[N]);
		beginFunc(mcl_fp_mulUnitPreM[N]);
		Operand z = call(mulUnit_innerM[bit], px, y);
		storeN(z, pz);
		ret(Void);
		endFunc();
	}
	void gen_mul_inner(const Operand& pz, const Operand& px, const Operand& py)
	{
		if (N == 1) {
			Operand x = load(px);
			Operand y = load(py);
			x = zext(x, unit * 2);
			y = zext(y, unit * 2);
			Operand z = mul(x, y);
			storeN(z, pz);
			ret(Void);
		} else if (N > 8 && (N % 2) == 0) {
			/*
				W = 1 << half
				(aW + b)(cW + d) = acW^2 + (ad + bc)W + bd
				ad + bc = (a + b)(c + d) - ac - bd
				@note Karatsuba is slower for N = 8
			*/
			const int H = N / 2;
			const int half = bit / 2;
			Operand pxW = getelementptr(px, H);
			Operand pyW = getelementptr(py, H);
			Operand pzWW = getelementptr(pz, N);
			call(mclb_mulM[H], pz, px, py); // bd
			call(mclb_mulM[H], pzWW, pxW, pyW); // ac

			Operand a = zext(loadN(pxW, H), half + unit);
			Operand b = zext(loadN(px, H), half + unit);
			Operand c = zext(loadN(pyW, H), half + unit);
			Operand d = zext(loadN(py, H), half + unit);
			Operand t1 = add(a, b);
			Operand t2 = add(c, d);
			Operand buf = alloca_(unit, N);
			Operand t1L = trunc(t1, half);
			Operand t2L = trunc(t2, half);
			Operand c1 = trunc(lshr(t1, half), 1);
			Operand c2 = trunc(lshr(t2, half), 1);
			Operand c0 = _and(c1, c2);
			c1 = select(c1, t2L, makeImm(half, 0));
			c2 = select(c2, t1L, makeImm(half, 0));
			Operand buf1 = alloca_(unit, half / unit);
			Operand buf2 = alloca_(unit, half / unit);
			storeN(t1L, buf1);
			storeN(t2L, buf2);
			call(mclb_mulM[N / 2], buf, buf1, buf2);
			Operand t = loadN(buf, N);
			t = zext(t, bit + unit);
			c0 = zext(c0, bit + unit);
			c0 = shl(c0, bit);
			t = _or(t, c0);
			c1 = zext(c1, bit + unit);
			c2 = zext(c2, bit + unit);
			c1 = shl(c1, half);
			c2 = shl(c2, half);
			t = add(t, c1);
			t = add(t, c2);
			t = sub(t, zext(loadN(pz, N), bit + unit));
			t = sub(t, zext(loadN(pz, N, N), bit + unit));
			if (bit + half > t.bit) {
				t = zext(t, bit + half);
			}
			t = add(t, loadN(pz, N + H, H));
			storeN(t, pz, H);
			ret(Void);
		} else {
			Operand y = load(py);
			Operand xy = call(mulUnit_innerM[bit], px, y);
			store(trunc(xy, unit), pz);
			Operand t = lshr(xy, unit);
			for (uint32_t i = 1; i < N; i++) {
				y = loadN(py, 1, i);
				xy = call(mulUnit_innerM[bit], px, y);
				t = add(t, xy);
				if (i < N - 1) {
					storeN(trunc(t, unit), pz, i);
					t = lshr(t, unit);
				}
			}
			storeN(t, pz, N - 1);
			ret(Void);
		}
	}
	void gen_sqr_inner(const Operand& py, const Operand& px)
	{
		if (N == 1) {
			Operand x = load(px);
			x = zext(x, unit * 2);
			Operand y = mul(x, x);
			storeN(y, py);
			ret(Void);
		// slower for N = 8
		} else if (N > 8 && (N % 2) == 0) {
			/*
				W = 1 << half
				(aW + b)^2 = a^2W^2 + 2abW + b^2
				@note Karatsuba is slower for N = 8
			*/
			const int H = N / 2;
			const int half = bit / 2;
			Operand pxW = getelementptr(px, H);
			Operand pyWW = getelementptr(py, N);
			Operand abBuf = alloca_(unit, N);
			call(mclb_mulM[H], abBuf, px, pxW);
			call(mclb_sqrM[H], py, px); // b^2
			call(mclb_sqrM[H], pyWW, pxW); // a^2

			Operand ab = loadN(abBuf, N);
			ab = zext(ab, ab.bit + unit);
			ab = add(ab, ab);
			ab = zext(ab, bit + half);
			Operand pyH = getelementptr(py, H);
			Operand t = loadN(pyH, N + H);
			t = add(t, ab);
			storeN(t, pyH);
			ret(Void);
		} else {
			Operand t1, t2, tt;
			t1 = load(px);
			tt = call(mulUU, t1, t1);
			store(trunc(tt, unit), py);
			tt = lshr(tt, unit);
			t2 = load(getelementptr(px, N - 1));
			Operand sum = call(mulUU, t1, t2);
			for (uint32_t i = 2; i < N; i++) {
				t1 = load(px);
				t2 = load(getelementptr(px, N - i));
				Operand line = call(mulUU, t1, t2);
				for (uint32_t j = 1; j < i; j++) {
					t1 = load(getelementptr(px, j));
					t2 = load(getelementptr(px, N - i + j));
					t1 = call(mulUU, t1, t2);
					line = zext(line, line.bit + unit * 2);
					t1 = zext(t1, line.bit);
					t1 = shl(t1, unit * 2 * j);
					line = _or(line, t1);
				}
				// line = ...[N-1+i 1][N-i 0]
				if (sum.bit < line.bit) sum = zext(sum, line.bit);
				sum = shl(sum, unit);
				sum = add(sum, line);
			}
			uint32_t bit2 = unit * (N * 2 - 1);
			tt = zext(tt, bit2);
			for (uint32_t i = 1; i < N; i++) {
				t1 = load(getelementptr(px, i));
				t1 = call(mulUU, t1, t1);
				t1 = zext(t1, bit2);
				t1 = shl(t1, unit * (i * 2 - 1));
				tt = _or(tt, t1);
			}
			sum = zext(sum, bit2);
			sum = add(sum, sum);
			tt = add(tt, sum);
			storeN(tt, py, 1);
			ret(Void);
		}
	}
	void gen_mclb_mul()
	{
		resetGlobalIdx();
		Operand pz(IntPtr, unit);
		Operand px(IntPtr, unit);
		Operand py(IntPtr, unit);
		std::string name = "mclb_mul" + cybozu::itoa(N);
		mclb_mulM[N] = Function(name, Void, pz, px, py);
		verifyAndSetPrivate(mclb_mulM[N]);
		beginFunc(mclb_mulM[N]);
		gen_mul_inner(pz, px, py);
		endFunc();
	}
	void gen_mclb_sqr()
	{
		resetGlobalIdx();
		Operand py(IntPtr, unit);
		Operand px(IntPtr, unit);
		std::string name = "mclb_sqr" + cybozu::itoa(N);
		mclb_sqrM[N] = Function(name, Void, py, px);
		verifyAndSetPrivate(mclb_sqrM[N]);
		beginFunc(mclb_sqrM[N]);
		// on M1, mul is faster than sqr for N <= 6
		// on A64FX, mul is faster than sqr for N <= 4
		if (N <= 6) {
			gen_mul_inner(py, px, px);
		} else {
			gen_sqr_inner(py, px);
		}
		endFunc();
	}
	void gen_mcl_fp_mont(bool isFullBit = true)
	{
		const int bu = bit + unit;
		const int bu2 = bit + unit * 2;
		resetGlobalIdx();
		Operand pz(IntPtr, unit);
		Operand px(IntPtr, unit);
		Operand py(IntPtr, unit);
		Operand pp(IntPtr, unit);
		std::string name = "mcl_fp_mont";
		if (!isFullBit) {
			name += "NF";
		}
		name += cybozu::itoa(N) + "L" + suf;
		mcl_fp_montM[N] = Function(name, Void, pz, px, py, pp);
		mcl_fp_montM[N].setAlias();
		verifyAndSetPrivate(mcl_fp_montM[N]);
		beginFunc(mcl_fp_montM[N]);
		Operand rp = load(getelementptr(pp, -1));
		Operand z, s, a;
		if (isFullBit) {
			for (uint32_t i = 0; i < N; i++) {
				Operand y = load(getelementptr(py, i));
				Operand xy = call(mulUnit_innerM[bit], px, y);
				Operand at;
				if (i == 0) {
					a = zext(xy, bu2);
					at = trunc(xy, unit);
				} else {
					xy = zext(xy, bu2);
					a = add(s, xy);
					at = trunc(a, unit);
				}
				Operand q = mul(at, rp);
				Operand pq = call(mulUnit_innerM[bit], pp, q);
				pq = zext(pq, bu2);
				Operand t = add(a, pq);
				s = lshr(t, unit);
			}
			s = trunc(s, bu);
			Operand p = zext(loadN(pp, N), bu);
			Operand vc = sub(s, p);
			Operand c = trunc(lshr(vc, bit), 1);
			z = select(c, s, vc);
			z = trunc(z, bit);
			storeN(z, pz);
		} else {
			Operand y = load(py);
			Operand xy = call(mulUnit_innerM[bit], px, y);
			Operand c0 = trunc(xy, unit);
			Operand q = mul(c0, rp);
			Operand pq = call(mulUnit_innerM[bit], pp, q);
			Operand t = add(xy, pq);
			t = lshr(t, unit); // bu-bit
			for (uint32_t i = 1; i < N; i++) {
				y = load(getelementptr(py, i));
				xy = call(mulUnit_innerM[bit], px, y);
				t = add(t, xy);
				c0 = trunc(t, unit);
				q = mul(c0, rp);
				pq = call(mulUnit_innerM[bit], pp, q);
				t = add(t, pq);
				t = lshr(t, unit);
			}
			t = trunc(t, bit);
			Operand vc = sub(t, loadN(pp, N));
			Operand c = trunc(lshr(vc, bit - 1), 1);
			z = select(c, t, vc);
			storeN(z, pz);
		}
		ret(Void);
		endFunc();
	}
	// return [H:L]
	Operand pack(Operand H, Operand L)
	{
		int size = H.bit + L.bit;
		H = zext(H, size);
		H = shl(H, L.bit);
		L = zext(L, size);
		H = _or(H, L);
		return H;
	}
	// split x to [ret:L] s.t. size of L = sizeL
	Operand split(Operand *L, const Operand& x, int sizeL)
	{
		Operand ret = lshr(x, sizeL);
		ret = trunc(ret, ret.bit - sizeL);
		*L = trunc(x, sizeL);
		return ret;
	}
	void gen_mul()
	{
		gen_mcl_fp_mulUnitPre();
	}
	void setBit(uint32_t bit)
	{
		this->bit = bit;
		N = bit / unit;
	}
	void setUnit(uint32_t unit)
	{
		this->unit = unit;
		unit2 = unit * 2;
		unitStr = cybozu::itoa(unit);
	}
	void gen(uint32_t N, uint32_t addN, const std::string& suf)
	{
		this->suf = suf;
		gen_once();

		for (uint32_t n = 1; n <= addN; n++) {
			setBit(n * unit);
			gen_mclb_addsub(true);
			gen_mclb_addsub(false);
			gen_mclb_addNF();
			gen_mclb_subNF();
		}
		for (uint32_t n = 1; n <= N; n++) {
			setBit(n * unit);
			gen_mulUnit_inner();
			gen_mclb_mulUnit();
			gen_mclb_mulUnitAdd();
			gen_mclb_mul();
			gen_mclb_sqr();
		}
	}
};

int main(int argc, char *argv[])
	try
{
	uint32_t unit;
	uint32_t N, addN;
	int llvmVer;
	std::string suf;
	cybozu::Option opt;
	opt.appendOpt(&unit, uint32_t(sizeof(void*)) * 8, "u", ": unit");
	opt.appendOpt(&llvmVer, 0x70, "ver", ": llvm version");
	opt.appendOpt(&suf, "", "s", ": suffix of function name");
	opt.appendOpt(&N, 0, "n", ": max size of Unit");
	opt.appendOpt(&addN, 0, "addn", ": max size of add/sub");
	opt.appendHelp("h");
	if (!opt.parse(argc, argv)) {
		opt.usage();
		return 1;
	}
	if (N == 0) {
		N = unit == 64 ? 9 : 17;
		addN = unit == 64 ? 16 : 32;
	}
	Code c;
	c.setLlvmVer(llvmVer);
	c.setUnit(unit);
	fprintf(stderr, "llvmVer=0x%02x unit=%d N=%d addN=%d\n", llvmVer, unit, N, addN);
	c.gen(N, addN, suf);
} catch (std::exception& e) {
	printf("ERR %s\n", e.what());
	return 1;
}
