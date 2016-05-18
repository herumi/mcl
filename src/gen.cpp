#include "llvm_gen.hpp"

struct OnceCode : public mcl::Generator {
	uint32_t unit;
	uint32_t bit;
	uint32_t N;
	uint32_t unit2;
	Function mulUU;
	Function extractHigh;
	Function mulPos;
	Function makeNIST_P192;

	void gen_mulUU()
	{
		resetGlobalIdx();
		Operand z(Int, unit2);
		Operand x(Int, unit);
		Operand y(Int, unit);
		mulUU = Function("mulUU", z, x, y);
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
		extractHigh = Function("extractHigh", z, x);
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
		mulPos = Function("mulPos", xy, px, y, i);
		mulPos.setPrivate();
		beginFunc(mulPos);

		px = getelementptr(px, i);
		Operand x = load(px);
		xy = call(mulUU, x, y);
		ret(xy);
		endFunc();
	}
	void gen_makeNIST_P192()
	{
		resetGlobalIdx();
		Operand p0(Int, 64);
		Operand p1(Int, 64);
		Operand p2(Int, 64);
		Operand _0 = makeImm(64, 0);
		Operand _1 = makeImm(64, 1);
		Operand _2 = makeImm(64, 2);
		makeNIST_P192 = Function("makeNIST_P192", Operand());
		beginFunc(makeNIST_P192);
		p0 = sub(_0, _1);
		p1 = sub(_0, _2);
		p2 = sub(_0, _1);
		p0 = zext(p0, 192);
		p1 = zext(p1, 192);
		p2 = zext(p2, 192);
		p1 = shl(p1, 64);
		p2 = shl(p2, 128);
		p0 = add(p0, p1);
		p0 = add(p0, p2);
		ret(p0);
		endFunc();
	}
	void run(uint32_t unit, uint32_t bit)
	{
		this->unit = unit;
		this->bit = bit;
		N = bit / unit;
		unit2 = unit * 2;
		gen_mulUU();
		gen_extractHigh();
		gen_mulPos();
		gen_makeNIST_P192();
	}
};


int main()
	try
{
	OnceCode c;
	c.run(64, 256);
} catch (std::exception& e) {
	printf("ERR %s\n", e.what());
	return 1;
}
