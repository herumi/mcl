#include "llvm_gen.hpp"

struct Code : public mcl::Generator {
	Function gen_mulUU()
	{
		Operand z(Int, unit * 2);
		Operand x(Int, unit);
		Operand y(Int, unit);
		Function mulUU("mulUU", z, x, y);
		beginFunc(mulUU);

		x = zext(x, unit * 2);
		y = zext(y, unit * 2);
		z= mul(x, y);
		ret(z);
		endFunc();
		return mulUU;
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
	Code()
	{
		using namespace mcl;
		const int bu = unit + bit;
		Function mulUU = gen_mulUU();
		Function mulPv = gen_mulPv(bu);
	}
};


int main()
	try
{
	Code c;
} catch (std::exception& e) {
	printf("ERR %s\n", e.what());
	return 1;
}
