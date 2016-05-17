#include "llvm_gen.hpp"

struct OnceCode : public mcl::Generator {
	uint32_t unit2;
	Function gen_mulUU()
	{
		resetGlobalIdx();
		Operand z(Int, unit2);
		Operand x(Int, unit);
		Operand y(Int, unit);
		Function mulUU("mulUU", z, x, y);
		beginFunc(mulUU);

		x = zext(x, unit2);
		y = zext(y, unit2);
		z= mul(x, y);
		ret(z);
		endFunc();
		return mulUU;
	}
	Function gen_extractHigh()
	{
		resetGlobalIdx();
		Operand z(Int, unit);
		Operand x(Int, unit2);
		Function extractHigh("extractHigh", z, x);
		extractHigh.setPrivate();
		beginFunc(extractHigh);

		x = lshr(x, unit);
		z = trunc(x, unit);
		ret(z);
		endFunc();
		return extractHigh;
	}
	Function gen_mulPv(int bu)
	{
		Operand z(Int, bu);
		Operand px(Pointer, unit);
		Operand y(Int, unit);
		Function mulPv("mulPv", z, px, y);
		beginFunc(mulPv);
		endFunc();
		return mulPv;
	}
	void gen(uint32_t unit, uint32_t bit)
	{
		set(unit, bit);
		unit2 = unit * 2;
		Function mulUU = gen_mulUU();
		Function extractHigh = gen_extractHigh();
//		Function mulPv = gen_mulPv(bu);
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
