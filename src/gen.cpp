#include "llvm_gen.hpp"

struct OnceCode : public mcl::Generator {
	uint32_t unit;
	uint32_t bit;
	uint32_t N;
	uint32_t unit2;
	Function mulUU;
	Function extractHigh;
	Function mulPos;

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
	void gen(uint32_t unit, uint32_t bit)
	{
		this->unit = unit;
		this->bit = bit;
		N = bit / unit;
		unit2 = unit * 2;
		gen_mulUU();
		gen_extractHigh();
		gen_mulPos();
	}
};


int main()
	try
{
	OnceCode c;
	c.gen(64, 256);
} catch (std::exception& e) {
	printf("ERR %s\n", e.what());
	return 1;
}
