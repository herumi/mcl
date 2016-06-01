#include "llvm_gen.hpp"

struct Code : public mcl::Generator {
	Operand Void;
	void gen1()
	{
		const int bit = 1024;
		resetGlobalIdx();
		Operand pz(IntPtr, bit);
		Operand px(IntPtr, bit);
		Operand py(IntPtr, bit);
		std::string name = "add" + cybozu::itoa(bit);
		Function f(name, Void, pz, px, py);
		beginFunc(f);
		Operand x = load(px);
		Operand y = load(py);
		x = add(x, y);
		store(x, pz);
		ret(Void);
		endFunc();
	}
};

int main()
{
	Code c;
	c.gen1();
}

