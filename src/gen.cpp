#include "llvm_gen.hpp"
#include <cybozu/option.hpp>
#include <mcl/op.hpp>
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
	const StrSet *privateFuncList;
	std::string unitStr;
	Function mulUU;
	Function extractHigh;
	Function mulPos;
	Function makeNIST_P192;
	Function mcl_fpDbl_mod_NIST_P192;
	Function mcl_fp_sqr_NIST_P192;
	FunctionMap mcl_fp_addNCM;
	FunctionMap mcl_fp_subNCM;
	FunctionMap mcl_fp_addM;
	FunctionMap mcl_fp_subM;
	FunctionMap mulPvM;
	FunctionMap mcl_fp_mul_UnitPreM;
	FunctionMap mcl_fpDbl_mulPreM;
	FunctionMap mcl_fpDbl_sqrPreM;
	FunctionMap mcl_fp_montM;
	FunctionMap mcl_fp_montRedM;
	Code() : unit(0), unit2(0), bit(0), N(0), privateFuncList(0) { }
	void verifyAndSetPrivate(Function& f)
	{
		if (privateFuncList && privateFuncList->find(f.name) != privateFuncList->end()) {
			f.setPrivate();
		}
	}

	void gen_mulUU()
	{
		resetGlobalIdx();
		Operand z(Int, unit2);
		Operand x(Int, unit);
		Operand y(Int, unit);
		std::string name = "mul";
		name += unitStr + "x" + unitStr;
		mulUU = Function(name, z, x, y);
		verifyAndSetPrivate(mulUU);
		beginFunc(mulUU);

		x = zext(x, unit2);
		y = zext(y, unit2);
		z = mul(x, y);
		ret(z);
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

		px = getelementptr(px, i);
		Operand x = load(px);
		xy = call(mulUU, x, y);
		ret(xy);
		endFunc();
	}
	Operand extract192to64(const Operand& x, uint32_t shift)
	{
		Operand y = lshr(x, shift);
		y = trunc(y, 64);
		return y;
	}
	void gen_makeNIST_P192()
	{
		resetGlobalIdx();
		Operand p(Int, 192);
		Operand p0(Int, 64);
		Operand p1(Int, 64);
		Operand p2(Int, 64);
		Operand _0 = makeImm(64, 0);
		Operand _1 = makeImm(64, 1);
		Operand _2 = makeImm(64, 2);
		makeNIST_P192 = Function("makeNIST_P192", p);
		verifyAndSetPrivate(makeNIST_P192);
		beginFunc(makeNIST_P192);
		p0 = sub(_0, _1);
		p1 = sub(_0, _2);
		p2 = sub(_0, _1);
		p0 = zext(p0, 192);
		p1 = zext(p1, 192);
		p2 = zext(p2, 192);
		p1 = shl(p1, 64);
		p2 = shl(p2, 128);
		p = add(p0, p1);
		p = add(p, p2);
		ret(p);
		endFunc();
	}
	/*
		NIST_P192
		p = 0xfffffffffffffffffffffffffffffffeffffffffffffffff
		      0                1                2
		ffffffffffffffff fffffffffffffffe ffffffffffffffff

		p = (1 << 192) - (1 << 64) - 1
		(1 << 192) % p = (1 << 64) + 1
		L : 192bit
		Hi: 64bit
		x = [H:L] = [H2:H1:H0:L]
		mod p
		x = L + H + (H << 64)
		  = L + H + [H1:H0:0] + H2 + (H2 << 64)
		[e:t] = L + H + [H1:H0:H2] + [H2:0] ; 2bit(e) over
		y = t + e + (e << 64)
		if (y >= p) y -= p
	*/
	void gen_mcl_fpDbl_mod_NIST_P192()
	{
		resetGlobalIdx();
		Operand out(IntPtr, 192);
		Operand px(IntPtr, 192);
		mcl_fpDbl_mod_NIST_P192 = Function("mcl_fpDbl_mod_NIST_P192", Void, out, px);
		verifyAndSetPrivate(mcl_fpDbl_mod_NIST_P192);
		beginFunc(mcl_fpDbl_mod_NIST_P192);

		Operand L = load(px);
		L = zext(L, 256);

		Operand pH = getelementptr(px, makeImm(32, 1));
		Operand H192 = load(pH);
		Operand H = zext(H192, 256);

		Operand H10 = shl(H192, 64);
		H10 = zext(H10, 256);

		Operand H2 = extract192to64(H192, 128);
		H2 = zext(H2, 256);
		Operand H102 = _or(H10, H2);

		H2 = shl(H2, 64);

		Operand t = add(L, H);
		t = add(t, H102);
		t = add(t, H2);

		Operand e = lshr(t, 192);
		e = trunc(e, 64);
		e = zext(e, 256);
		Operand e2 = shl(e, 64);
		e = _or(e, e2);

		t = trunc(t, 192);
		t = zext(t, 256);

		Operand z = add(t, e);
		Operand p = call(makeNIST_P192);
		p = zext(p, 256);
		Operand zp = sub(z, p);
		Operand c = trunc(lshr(zp, 192), 1);
		z = trunc(select(c, z, zp), 192);
		store(z, out);
		ret(Void);
		endFunc();
	}
	/*
		NIST_P521
		p = (1 << 521) - 1
		x = [H:L]
		x % p = (L + H) % p
	*/
	void gen_mcl_fpDbl_mod_NIST_P521()
	{
		resetGlobalIdx();
		const uint32_t len = 521;
		const uint32_t n = len / unit;
		const uint32_t round = unit * (n + 1);
		const uint32_t round2 = unit * (n * 2 + 1);
		const uint32_t rem = len - n * unit;
		const size_t mask = -(1 << rem);
		const Operand py(IntPtr, round);
		const Operand px(IntPtr, round2);
		Function f("mcl_fpDbl_mod_NIST_P521", Void, py, px);
		verifyAndSetPrivate(f);
		beginFunc(f);
		Operand x = load(px);
		Operand L = trunc(x, len);
		L = zext(L, round);
		Operand H = lshr(x, len);
		H = trunc(H, round); // x = [H:L]
		Operand t = add(L, H);
		Operand t0 = lshr(t, len);
		t0 = _and(t0, makeImm(round, 1));
		t = add(t, t0);
		t = trunc(t, len);
		Operand z0 = zext(t, round);
		t = extract(z0, n * unit);
		Operand m = _or(t, makeImm(unit, mask));
		for (uint32_t i = 0; i < n; i++) {
			Operand s = extract(z0, unit * i);
			m = _and(m, s);
		}
		Operand c = icmp(eq, m, makeImm(unit, -1));
		Label zero("zero");
		Label nonzero("nonzero");
		br(c, zero, nonzero);
	putLabel(zero);
		store(makeImm(round, 0), py);
		ret(Void);
	putLabel(nonzero);
		store(z0, py);
		ret(Void);
		endFunc();
	}
	void gen_mcl_fp_sqr_NIST_P192()
	{
		resetGlobalIdx();
		Operand py(IntPtr, 192);
		Operand px(IntPtr, unit);
		mcl_fp_sqr_NIST_P192 = Function("mcl_fp_sqr_NIST_P192", Void, py, px);
		verifyAndSetPrivate(mcl_fp_sqr_NIST_P192);
		beginFunc(mcl_fp_sqr_NIST_P192);
		Operand buf = _alloca(192, 2);
		Operand p = bitcast(buf, Operand(IntPtr, unit)); // QQQ : use makeType()
		// QQQ define later
		Function mcl_fpDbl_sqrPre192("mcl_fpDbl_sqrPre192", Void, p, px);
		call(mcl_fpDbl_sqrPre192, p, px);
		call(mcl_fpDbl_mod_NIST_P192, py, buf);
		ret(Void);
		endFunc();
	}
	void gen_mcl_fp_mul_NIST_P192()
	{
		resetGlobalIdx();
		Operand pz(IntPtr, 192);
		Operand px(IntPtr, unit);
		Operand py(IntPtr, unit);
		Function f("mcl_fp_mul_NIST_P192", Void, pz, px, py);
		verifyAndSetPrivate(f);
		beginFunc(f);
		Operand buf = _alloca(192, 2);
		Operand p = bitcast(buf, Operand(IntPtr, unit)); // QQQ : use makeType()
		// QQQ define later
		Function mcl_fpDbl_mulPre192("mcl_fpDbl_mulPre192", Void, p, px, py);
		call(mcl_fpDbl_mulPre192, p, px, py);
		call(mcl_fpDbl_mod_NIST_P192, pz, buf);
		ret(Void);
		endFunc();
	}
	void gen_once()
	{
		gen_mulUU();
		gen_extractHigh();
		gen_mulPos();
		gen_makeNIST_P192();
		gen_mcl_fpDbl_mod_NIST_P192();
		gen_mcl_fp_sqr_NIST_P192();
		gen_mcl_fp_mul_NIST_P192();
		gen_mcl_fpDbl_mod_NIST_P521();
	}
	Operand extract(const Operand& x, uint32_t shift)
	{
		Operand t = lshr(x, shift);
		t = trunc(t, unit);
		return t;
	}
	void gen_mcl_fp_addsubNC(bool isAdd)
	{
		resetGlobalIdx();
		Operand pz(IntPtr, bit);
		Operand px(IntPtr, bit);
		Operand py(IntPtr, bit);
		std::string name;
		if (isAdd) {
			name = "mcl_fp_addNC" + cybozu::itoa(bit);
			mcl_fp_addNCM[bit] = Function(name, Void, pz, px, py);
			verifyAndSetPrivate(mcl_fp_addNCM[bit]);
			beginFunc(mcl_fp_addNCM[bit]);
		} else {
			name = "mcl_fp_subNC" + cybozu::itoa(bit);
			mcl_fp_subNCM[bit] = Function(name, Void, pz, px, py);
			verifyAndSetPrivate(mcl_fp_subNCM[bit]);
			beginFunc(mcl_fp_subNCM[bit]);
		}
		Operand x = load(px);
		Operand y = load(py);
		Operand z;
		if (isAdd) {
			z = add(x, y);
		} else {
			z = sub(x, y);
		}
		store(z, pz);
		ret(Void);
		endFunc();
	}
#if 0
	void gen_mcl_fp_addS()
	{
		resetGlobalIdx();
		Operand pz(IntPtr, bit);
		Operand px(IntPtr, bit);
		Operand py(IntPtr, bit);
		Operand pp(IntPtr, bit);
		std::string name = "mcl_fp_add" + cybozu::itoa(bit) + "S";
		mcl_fp_addM[bit] = Function(name, Void, pz, px, py, pp);
		beginFunc(mcl_fp_addM[bit]);
		Operand x = load(px);
		Operand y = load(py);
		Operand p = load(pp);
		x = zext(x, bit + unit);
		y = zext(y, bit + unit);
		p = zext(p, bit + unit);
		Operand t0 = add(x, y);
		Operand t1 = sub(t0, p);
		Operand t = lshr(t1, bit);
		t = trunc(t, 1);
		t = select(t, t0, t1);
		t = trunc(t, bit);
		store(t, pz);
		ret(Void);
		endFunc();
	}
#endif
	void gen_mcl_fp_add()
	{
		resetGlobalIdx();
		Operand pz(IntPtr, bit);
		Operand px(IntPtr, bit);
		Operand py(IntPtr, bit);
		Operand pp(IntPtr, bit);
		std::string name = "mcl_fp_add" + cybozu::itoa(bit);
		mcl_fp_addM[bit] = Function(name, Void, pz, px, py, pp);
		verifyAndSetPrivate(mcl_fp_addM[bit]);
		beginFunc(mcl_fp_addM[bit]);
		Operand x = load(px);
		Operand y = load(py);
		Operand p = load(pp);
		x = zext(x, bit + unit);
		y = zext(y, bit + unit);
		p = zext(p, bit + unit);
		Operand t0 = add(x, y);
		Operand t1 = trunc(t0, bit);
		store(t1, pz);
		Operand vc = sub(t0, p);
		Operand c = lshr(vc, bit);
		c = trunc(c, 1);
	Label carry("carry");
	Label nocarry("nocarry");
		br(c, carry, nocarry);
	putLabel(nocarry);
		Operand v = trunc(vc, bit);
		store(v, pz);
		ret(Void);
	putLabel(carry);
		ret(Void);
		endFunc();
	}
#if 0
	void gen_mcl_fp_subS()
	{
		resetGlobalIdx();
		Operand pz(IntPtr, bit);
		Operand px(IntPtr, bit);
		Operand py(IntPtr, bit);
		Operand pp(IntPtr, bit);
		std::string name = "mcl_fp_sub" + cybozu::itoa(bit) + "S";
		mcl_fp_subM[bit] = Function(name, Void, pz, px, py, pp);
		beginFunc(mcl_fp_subM[bit]);
		Operand x = load(px);
		Operand y = load(py);
		x = zext(x, bit + unit);
		y = zext(y, bit + unit);
		Operand vc = sub(x, y);
		Operand v = trunc(vc, bit); // v = x - y
		Operand c = lshr(vc, bit);
		c = trunc(c, 1);
		Operand p = load(pp);
		Operand z = select(c, p, makeImm(bit, 0));
		v = add(v, z);
		store(v, pz);
		ret(Void);
		endFunc();
	}
#endif
	void gen_mcl_fp_sub()
	{
		resetGlobalIdx();
		Operand pz(IntPtr, bit);
		Operand px(IntPtr, bit);
		Operand py(IntPtr, bit);
		Operand pp(IntPtr, bit);
		std::string name = "mcl_fp_sub" + cybozu::itoa(bit);
		mcl_fp_subM[bit] = Function(name, Void, pz, px, py, pp);
		verifyAndSetPrivate(mcl_fp_subM[bit]);
		beginFunc(mcl_fp_subM[bit]);
		Operand x = load(px);
		Operand y = load(py);
		x = zext(x, bit + unit);
		y = zext(y, bit + unit);
		Operand vc = sub(x, y);
		Operand v = trunc(vc, bit);
		Operand c = lshr(vc, bit);
		c = trunc(c, 1);
		store(v, pz);
	Label carry("carry");
	Label nocarry("nocarry");
		br(c, carry, nocarry);
	putLabel(nocarry);
		ret(Void);
	putLabel(carry);
		Operand p = load(pp);
		Operand t = add(v, p);
		store(t, pz);
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
		Operand pz(IntPtr, bit);
		Operand px(IntPtr, b2);
		Operand py(IntPtr, b2);
		Operand pp(IntPtr, bit);
		std::string name = "mcl_fpDbl_add" + cybozu::itoa(bit);
		Function f(name, Void, pz, px, py, pp);
		verifyAndSetPrivate(f);
		beginFunc(f);
		Operand x = load(px);
		Operand y = load(py);
		x = zext(x, b2u);
		y = zext(y, b2u);
		Operand t = add(x, y); // x + y = [H:L]
		Operand L = trunc(t, bit);
		store(L, pz);

		Operand H = lshr(t, bit);
		H = trunc(H, bu);
		Operand p = load(pp);
		p = zext(p, bu);
		Operand Hp = sub(H, p);
		t = lshr(Hp, bit);
		t = trunc(t, 1);
		t = select(t, H, Hp);
		t = trunc(t, bit);
		pz = getelementptr(pz, makeImm(32, 1));
		store(t, pz);
		ret(Void);
		endFunc();
	}
	void gen_mcl_fpDbl_sub()
	{
		// QQQ : rol is used?
		const int b2 = bit * 2;
		const int b2u = b2 + unit;
		resetGlobalIdx();
		Operand pz(IntPtr, bit);
		Operand px(IntPtr, b2);
		Operand py(IntPtr, b2);
		Operand pp(IntPtr, bit);
		std::string name = "mcl_fpDbl_sub" + cybozu::itoa(bit);
		Function f(name, Void, pz, px, py, pp);
		verifyAndSetPrivate(f);
		beginFunc(f);
		Operand x = load(px);
		Operand y = load(py);
		x = zext(x, b2u);
		y = zext(y, b2u);
		Operand vc = sub(x, y); // x - y = [H:L]
		Operand L = trunc(vc, bit);
		store(L, pz);

		Operand H = lshr(vc, bit);
		H = trunc(H, bit);
		Operand c = lshr(vc, b2);
		c = trunc(c, 1);
		Operand p = load(pp);
		c = select(c, p, makeImm(bit, 0));
		Operand t = add(H, c);
		pz = getelementptr(pz, makeImm(32, 1));
		store(t, pz);
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
			size_t shift = x.bit;
			size_t size = x.bit + y.bit;
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
	void gen_mulPv()
	{
		const int bu = bit + unit;
		resetGlobalIdx();
		Operand z(Int, bu);
		Operand px(IntPtr, unit);
		Operand y(Int, unit);
		std::string name = "mulPv" + cybozu::itoa(bit) + "x" + cybozu::itoa(unit);
		mulPvM[bit] = Function(name, z, px, y);
		verifyAndSetPrivate(mulPvM[bit]);
		beginFunc(mulPvM[bit]);
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
	void gen_mcl_fp_mul_UnitPre()
	{
		const int bu = bit + unit;
		resetGlobalIdx();
		Operand pz(IntPtr, bu);
		Operand px(IntPtr, unit);
		Operand y(Int, unit);
		std::string name = "mcl_fp_mul_UnitPre" + cybozu::itoa(bit);
		mcl_fp_mul_UnitPreM[bit] = Function(name, Void, pz, px, y);
		verifyAndSetPrivate(mcl_fp_mul_UnitPreM[bit]);
		beginFunc(mcl_fp_mul_UnitPreM[bit]);
		Operand z = call(mulPvM[bit], px, y);
		store(z, pz);
		ret(Void);
		endFunc();
	}
	void generic_fpDbl_mul(const Operand& pz, const Operand& px, const Operand& py)
	{
		if (N == 1) {
			Operand x = load(px);
			Operand y = load(py);
			x = zext(x, unit * 2);
			y = zext(y, unit * 2);
			Operand z = mul(x, y);
			store(z, bitcast(pz, Operand(IntPtr, unit * 2)));
			ret(Void);
		} else if (N >= 32 && (N % 2) == 0) {
			/*
				W = 1 << half
				(aW + b)(cW + d) = acW^2 + (ad + bc)W + bd
				ad + bc = (a + b)(c + d) - ac - bd
			*/
			const int half = bit / 2;
			Operand pxW = getelementptr(px, makeImm(32, N / 2));
			Operand pyW = getelementptr(py, makeImm(32, N / 2));
			Operand pzWW = getelementptr(pz, makeImm(32, N));
			call(mcl_fpDbl_mulPreM[half], pz, px, py); // bd
			call(mcl_fpDbl_mulPreM[half], pzWW, pxW, pyW); // ac

			Operand pa = bitcast(pxW, Operand(IntPtr, half));
			Operand pb = bitcast(px, Operand(IntPtr, half));
			Operand pc = bitcast(pyW, Operand(IntPtr, half));
			Operand pd = bitcast(py, Operand(IntPtr, half));
			Operand a = zext(load(pa), half + unit);
			Operand b = zext(load(pb), half + unit);
			Operand c = zext(load(pc), half + unit);
			Operand d = zext(load(pd), half + unit);
			Operand t1 = add(a, b);
			Operand t2 = add(c, d);
			Operand buf = _alloca(unit, N);
			Operand t1L = trunc(t1, half);
			Operand t2L = trunc(t2, half);
			Operand c1 = trunc(lshr(t1, half), 1);
			Operand c2 = trunc(lshr(t2, half), 1);
			Operand c0 = _and(c1, c2);
			c1 = select(c1, t2L, makeImm(half, 0));
			c2 = select(c2, t1L, makeImm(half, 0));
			Operand buf1 = _alloca(half, 1);
			Operand buf2 = _alloca(half, 1);
			store(t1L, buf1);
			store(t2L, buf2);
			buf1 = bitcast(buf1, Operand(IntPtr, unit));
			buf2 = bitcast(buf2, Operand(IntPtr, unit));
			call(mcl_fpDbl_mulPreM[half], buf, buf1, buf2);
			buf = bitcast(buf, Operand(IntPtr, bit));
			Operand t = load(buf);
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
			Operand pzL = bitcast(pz, Operand(IntPtr, bit));
			Operand pzH = getelementptr(pzL, makeImm(32, 1));
			t = sub(t, zext(load(pzL), bit + unit));
			t = sub(t, zext(load(pzH), bit + unit));
			pzL = getelementptr(pz, makeImm(32, N / 2));
			pzL = bitcast(pzL, Operand(IntPtr, bit + half));
			if (bit + half > t.bit) {
				t = zext(t, bit + half);
			}
			t = add(t, load(pzL));
			store(t, pzL);
			ret(Void);
		} else {
			const int bu = bit + unit;
			Operand y = load(py);
			Operand xy = call(mulPvM[bit], px, y);
			store(trunc(xy, unit), pz);
			Operand t = lshr(xy, unit);
			Operand z, pzi;
			for (uint32_t i = 1; i < N; i++) {
				Operand pyi = getelementptr(py, makeImm(32, i));
				y = load(pyi);
				xy = call(mulPvM[bit], px, y);
				t = add(t, xy);
				z = trunc(t, unit);
				pzi = getelementptr(pz, makeImm(32, i));
				if (i < N - 1) {
					store(z, pzi);
					t = lshr(t, unit);
				}
			}
			pzi = bitcast(pzi, Operand(IntPtr, bu));
			store(t, pzi);
			ret(Void);
		}
	}
	void gen_mcl_fpDbl_mulPre()
	{
		resetGlobalIdx();
		Operand pz(IntPtr, unit);
		Operand px(IntPtr, unit);
		Operand py(IntPtr, unit);
		std::string name = "mcl_fpDbl_mulPre" + cybozu::itoa(bit);
		mcl_fpDbl_mulPreM[bit] = Function(name, Void, pz, px, py);
		verifyAndSetPrivate(mcl_fpDbl_mulPreM[bit]);
		beginFunc(mcl_fpDbl_mulPreM[bit]);
		generic_fpDbl_mul(pz, px, py);
		endFunc();
	}
	void gen_mcl_fpDbl_sqrPre()
	{
		resetGlobalIdx();
		Operand py(IntPtr, unit);
		Operand px(IntPtr, unit);
		std::string name = "mcl_fpDbl_sqrPre" + cybozu::itoa(bit);
		mcl_fpDbl_sqrPreM[bit] = Function(name, Void, py, px);
		verifyAndSetPrivate(mcl_fpDbl_sqrPreM[bit]);
		beginFunc(mcl_fpDbl_sqrPreM[bit]);
		generic_fpDbl_mul(py, px, px);
		endFunc();
	}
	void gen_mcl_fp_mont()
	{
		const int bu = bit + unit;
		const int bu2 = bit + unit * 2;
		resetGlobalIdx();
		Operand pz(IntPtr, bit);
		Operand px(IntPtr, unit);
		Operand py(IntPtr, unit);
		Operand pp(IntPtr, unit);
		std::string name = "mcl_fp_mont" + cybozu::itoa(bit);
		mcl_fp_montM[bit] = Function(name, Void, pz, px, py, pp);
		mcl_fp_montM[bit].setAlias();
		verifyAndSetPrivate(mcl_fp_montM[bit]);
		beginFunc(mcl_fp_montM[bit]);
		Operand rp = load(getelementptr(pp, makeImm(unit, -1)));
		Operand p = load(bitcast(pp, Operand(IntPtr, bit)));
		Operand z, s, a;
		for (uint32_t i = 0; i < N; i++) {
			Operand y = load(getelementptr(py, makeImm(unit, i)));
			Operand xy = call(mulPvM[bit], px, y);
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
			Operand pq = call(mulPvM[bit], pp, q);
			pq = zext(pq, bu2);
			Operand t = add(a, pq);
			s = lshr(t, unit);
		}
		s = trunc(s, bu);
		p = zext(p, bu);
		Operand vc = sub(s, p);
		Operand c = trunc(lshr(vc, bit), 1);
		z = select(c, s, vc);
		z = trunc(z, bit);
		store(z, pz);
		ret(Void);
		endFunc();
	}
	void gen_mcl_fp_montRed()
	{
		const int bu = bit + unit;
		const int b2 = bit * 2;
		const int b2u = b2 + unit;
		resetGlobalIdx();
		Operand pz(IntPtr, bit);
		Operand pxy(IntPtr, b2);
		Operand pp(IntPtr, unit);
		std::string name = "mcl_fp_montRed" + cybozu::itoa(bit);
		mcl_fp_montRedM[bit] = Function(name, Void, pz, pxy, pp);
		verifyAndSetPrivate(mcl_fp_montRedM[bit]);
		beginFunc(mcl_fp_montRedM[bit]);
		Operand rp = load(getelementptr(pp, makeImm(unit, -1)));
		Operand p = load(bitcast(pp, Operand(IntPtr, bit)));
		Operand xy = load(pxy);
		Operand t = zext(xy, b2 + unit);
		Operand z;
		for (uint32_t i = 0; i < N; i++) {
			Operand z = trunc(t, unit);
			Operand q = mul(z, rp);
			Operand pq = call(mulPvM[bit], pp, q);
			pq = zext(pq, b2u - unit * i);
			z = add(t, pq);
			z = lshr(z, unit);
			t = trunc(z, b2 - unit * i);
		}
		p = zext(p, bu);
		Operand vc = sub(t, p);
		Operand c = trunc(lshr(vc, bit), 1);
		z = select(c, t, vc);
		z = trunc(z, bit);
		store(z, pz);
		ret(Void);
		endFunc();
	}
	void gen_all()
	{
		gen_mcl_fp_addsubNC(true);
		gen_mcl_fp_addsubNC(false);
	}
	void gen_addsub()
	{
		gen_mcl_fp_add();
		gen_mcl_fp_sub();
		gen_mcl_fpDbl_add();
		gen_mcl_fpDbl_sub();
	}
	void gen_mul()
	{
		gen_mulPv();
		gen_mcl_fp_mul_UnitPre();
		gen_mcl_fpDbl_mulPre();
		gen_mcl_fpDbl_sqrPre();
		gen_mcl_fp_mont();
		gen_mcl_fp_montRed();
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
	void gen(const StrSet& privateFuncList, uint32_t maxBitSize)
	{
		this->privateFuncList = &privateFuncList;
		gen_once();
		uint32_t end = ((maxBitSize + unit - 1) / unit) * unit;
		for (uint32_t i = 64; i <= end; i += unit) {
			setBit(i);
			gen_all();
			gen_addsub();
			gen_mul();
		}
		if (unit == 64 && maxBitSize == 768) {
			for (uint32_t i = maxBitSize + unit * 2; i <= maxBitSize * 2; i += unit * 2) {
				setBit(i);
				gen_all();
			}
		}
	}
};

int main(int argc, char *argv[])
	try
{
	uint32_t unit;
	bool oldLLVM;
	std::string privateFile;
	cybozu::Option opt;
	opt.appendOpt(&unit, uint32_t(sizeof(void*)) * 8, "u", ": unit");
	opt.appendBoolOpt(&oldLLVM, "old", ": old LLVM(before 3.8)");
	opt.appendOpt(&privateFile, "", "f", ": private function list file");
	opt.appendHelp("h");
	if (!opt.parse(argc, argv)) {
		opt.usage();
		return 1;
	}
	StrSet privateFuncList;
	if (!privateFile.empty()) {
		std::ifstream ifs(privateFile.c_str(), std::ios::binary);
		std::string name;
		while (ifs >> name) {
			privateFuncList.insert(name);
		}
	}
	Code c;
	if (oldLLVM) {
		c.setOldLLVM();
	}
	c.setUnit(unit);
	uint32_t maxBitSize = MCL_MAX_OP_BIT_SIZE;
	c.gen(privateFuncList, maxBitSize);
} catch (std::exception& e) {
	printf("ERR %s\n", e.what());
	return 1;
}
