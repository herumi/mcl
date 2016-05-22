#include "llvm_gen.hpp"
#include <map>
#include <cybozu/option.hpp>

struct Code : public mcl::Generator {
	typedef std::map<int, Function> FunctionMap;
	Operand Void;
	uint32_t unit;
	uint32_t unit2;
	uint32_t bit;
	uint32_t N;
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
	Code() : unit(0), unit2(0), bit(0), N(0) { }

	void gen_mulUU()
	{
		resetGlobalIdx();
		Operand z(Int, unit2);
		Operand x(Int, unit);
		Operand y(Int, unit);
		std::string name = "mul";
		name += unitStr + "x" + unitStr;
		mulUU = Function(name, z, x, y);
		beginFunc(mulUU);

		x = zext(x, unit2);
		y = zext(y, unit2);
		z= mul(x, y);
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
	void gen_mcl_fp_sqr_NIST_P192()
	{
		resetGlobalIdx();
		Operand py(IntPtr, 192);
		Operand px(IntPtr, unit);
		mcl_fp_sqr_NIST_P192 = Function("mcl_fp_sqr_NIST_P192", Void, py, px);
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
			beginFunc(mcl_fp_addNCM[bit]);
		} else {
			name = "mcl_fp_subNC" + cybozu::itoa(bit);
			mcl_fp_subNCM[bit] = Function(name, Void, pz, px, py);
			beginFunc(mcl_fp_subNCM[bit]);
		}
		Operand x = load(px);
		Operand y = load(py);
		Operand z;
		if (isAdd) {
			add(x, y);
		} else {
			sub(x, y);
		}
		store(z, pz);
		ret(Void);
		endFunc();
	}
	void gen_mcl_fp_add()
	{
		resetGlobalIdx();
		Operand pz(IntPtr, bit);
		Operand px(IntPtr, bit);
		Operand py(IntPtr, bit);
		Operand pp(IntPtr, bit);
		std::string name = "mcl_fp_add" + cybozu::itoa(bit);
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
	void gen_mcl_fp_sub()
	{
		resetGlobalIdx();
		Operand pz(IntPtr, bit);
		Operand px(IntPtr, bit);
		Operand py(IntPtr, bit);
		Operand pp(IntPtr, bit);
		std::string name = "mcl_fp_sub" + cybozu::itoa(bit);
		mcl_fp_subM[bit] = Function(name, Void, pz, px, py, pp);
		beginFunc(mcl_fp_subM[bit]);
		Operand x = load(px);
		Operand y = load(py);
		x = zext(x, bit + unit);
		y = zext(y, bit + unit);
		Operand vc = sub(x, y);
		Operand v = trunc(vc, bit); // v = x - y
		Operand c = lshr(vc, bit + unit - 1);
		c = trunc(c, 1);
		Operand p = load(pp);
		Operand z = select(c, p, makeImm(bit, 0));
		v = add(v, z);
		store(v, pz);
		ret(Void);
		endFunc();
	}
	void gen_all()
	{
		gen_mcl_fp_addsubNC(true);
		gen_mcl_fp_addsubNC(false);
	}
	void gen_short()
	{
		gen_mcl_fp_add();
		gen_mcl_fp_sub();
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
	void gen()
	{
		gen_once();
		for (int i = 128; i < 256; i += unit) {
//			gen_all();
//			gen_short();
		}
	}
};

int main(int argc, char *argv[])
	try
{
	uint32_t unit;
	cybozu::Option opt;
	opt.appendOpt(&unit, uint32_t(sizeof(void*)) * 8, "u", "unit");
	opt.appendHelp("h");
	if (!opt.parse(argc, argv)) {
		opt.usage();
		return 1;
	}
	Code c;
	c.setUnit(unit);
	c.gen();
} catch (std::exception& e) {
	printf("ERR %s\n", e.what());
	return 1;
}
