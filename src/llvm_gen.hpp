#pragma once
/**
	@file
	@brief LLVM IR generator
	@author MITSUNARI Shigeo(@herumi)
	@license modified new BSD license
	http://opensource.org/licenses/BSD-3-Clause
*/
#include <string>
#include <vector>
#include <cybozu/exception.hpp>
#include <cybozu/itoa.hpp>
#include <stdio.h>
#ifdef _MSC_VER
//	#pragma warning(push)
	#pragma warning(disable : 4458)
#endif

namespace mcl {

namespace impl {

struct File {
	FILE *fp;
	File() : fp(stdout) {}
	~File() { if (fp != stdout) fclose(fp); }
	void open(const std::string& file)
	{
#ifdef _MSC_VER
		bool isOK = fopen_s(&fp, file.c_str(), "wb") != 0;
#else
		fp = fopen(file.c_str(), "wb");
		bool isOK = fp != NULL;
#endif
		if (!isOK) throw cybozu::Exception("File:open") << file;
	}
	void write(const std::string& str)
	{
		int ret = fprintf(fp, "%s\n", str.c_str());
		if (ret < 0) {
			throw cybozu::Exception("File:write") << str;
		}
	}
};
template<size_t dummy=0>
struct Param {
	static File f;
};

template<size_t dummy>
File Param<dummy>::f;

} // mcl::impl

struct Generator {
	static const uint8_t Void = 0;
	static const uint8_t Int = 1;
	static const uint8_t Imm = 2;
	static const uint8_t Ptr = 1 << 7;
	static const uint8_t IntPtr = Int | Ptr;
	struct Type {
		uint8_t type;
		bool isPtr;
		Type(int type = 0)
			: type(static_cast<uint8_t>(type & ~Ptr))
			, isPtr((type & Ptr) != 0)
		{
		}
		static inline friend std::ostream& operator<<(std::ostream& os, const Type& self)
		{
			return os << (self.type | (self.isPtr ? Ptr : 0));
		}
	};
	Type type;
	uint32_t unit;
	uint32_t bit;
	uint32_t N;
	Generator() : unit(0), bit(0), N(0) {}
	void set(uint32_t unit, uint32_t bit)
	{
		this->unit = unit;
		this->bit = bit;
		this->N = bit / unit;
	}
	void open(const std::string& file)
	{
		impl::Param<>::f.open(file);
	}
	struct Operand;
	struct Function;
	struct Eval;
	static inline int& getGlobalIdx()
	{
		static int globalIdx = 0;
		return globalIdx;
	}
	static inline void resetGlobalIdx()
	{
		getGlobalIdx() = 0;
	}
	static inline std::string getGlobalName()
	{
		int& idx = getGlobalIdx();
		return std::string("reg") + cybozu::itoa(idx++);
	}
	static inline void put(const std::string& str)
	{
		impl::Param<>::f.write(str);
	}
	void beginFunc(const Function& f);
	void endFunc()
	{
		put("}");
	}
	Eval zext(const Operand& x, uint32_t size);
	Eval mul(const Operand& x, const Operand& y);
	void ret(const Operand& r);
	Eval lshr(const Operand& x, uint32_t size);
	Eval trunc(const Operand& x, uint32_t size);
	Eval getelementptr(const Operand& p, const Operand& i);
	Eval load(const Operand& p);
	Eval call(const Function& f, const Operand& op1);
	Eval call(const Function& f, const Operand& op1, const Operand& op2);
	Eval call(const Function& f, const Operand& op1, const Operand& op2, const Operand& op3);
	Eval call(const Function& f, const Operand& op1, const Operand& op2, const Operand& op3, const Operand& op4);
};

struct Generator::Operand {
	Type type;
	uint32_t bit;
	uint64_t imm;
	uint32_t idx;
	std::string name;
	Operand() : type(Void), bit(0), imm(0), idx(0) {}
	Operand(Type type, uint32_t bit, const std::string& name = "")
		: type(type), bit(bit), imm(0), idx(0), name(name)
	{
		if (name.empty()) {
			this->name = getGlobalName();
		}
	}
	Operand(const Eval& e);
	void operator=(const Eval& e);

	// set (bit, type, imm) by rhs
	void set(const Operand& rhs)
	{
		bit = rhs.bit;
		type = rhs.type;
		imm = rhs.imm;
	}
	void update() { idx++; }
	std::string toStr() const
	{
		if (type.isPtr) {
			return getType() + " " + getName();
		}
		switch (type.type) {
		default:
			return "void";
		case Int:
			return getType() + " " + getName();
		case Imm:
			return cybozu::itoa(imm);
		}
	}
	std::string getType() const
	{
		std::string s;
		switch (type.type) {
		default:
			return "";
		case Int:
			s = std::string("i") + cybozu::itoa(bit);
			break;
		}
		if (type.isPtr) {
			s += "*";
		}
		return s;
	}
	std::string getName() const
	{
		switch (type.type) {
		default:
			return "";
		case Int:
			std::string str("%");
			str += name;
			if (idx > 0) str += "_" + cybozu::itoa(idx);
			return str;
		}
	}
};

struct Generator::Eval {
	std::string s;
	Generator::Operand op;
	mutable bool used;
	Eval() : used(false) {}
	~Eval()
	{
		if (used) return;
		put(s);
	}
};

inline Generator::Operand::Operand(const Generator::Eval& e)
{
	*this = e.op;
	update();
	put(getName() + " = " + e.s);
	e.used = true;
}

inline void Generator::Operand::operator=(const Generator::Eval& e)
{
	type = e.op.type;
	bit = e.op.bit;
	imm = e.op.imm;
	if (name.empty()) name = e.op.name;
	update();
	put(getName() + " = " + e.s);
	e.used = true;
}

struct Generator::Function {
	typedef std::vector<Generator::Operand> OperandVec;
	std::string name;
	Generator::Operand ret;
	OperandVec opv;
	bool isPrivate;
	explicit Function(const std::string& name = "") : name(name), isPrivate(false) {}
	Function(const std::string& name, const Operand& ret, const Operand& op1)
		: name(name), ret(ret), isPrivate(false) {
			opv.push_back(op1);
	}
	Function(const std::string& name, const Operand& ret, const Operand& op1, const Operand& op2)
		: name(name), ret(ret), isPrivate(false) {
			opv.push_back(op1);
			opv.push_back(op2);
	}
	Function(const std::string& name, const Operand& ret, const Operand& op1, const Operand& op2, const Operand& op3)
		: name(name), ret(ret), isPrivate(false) {
			opv.push_back(op1);
			opv.push_back(op2);
			opv.push_back(op3);
	}
	Function(const std::string& name, const Operand& ret, const Operand& op1, const Operand& op2, const Operand& op3, const Operand& op4)
		: name(name), ret(ret), isPrivate(false) {
			opv.push_back(op1);
			opv.push_back(op2);
			opv.push_back(op3);
			opv.push_back(op4);
	}
	void setPrivate()
	{
		isPrivate = true;
	}
	std::string toStr() const
	{
		std::string str = std::string("define ");
		if (isPrivate) {
			str += "private ";
		}
		str += ret.getType();
		str += " @" + name + "(";
		for (size_t i = 0; i < opv.size(); i++) {
			if (i > 0) str += ", ";
			str += opv[i].toStr();
		}
		str += ")";
		return str;
	}
};

inline void Generator::beginFunc(const Generator::Function& f)
{
	put(f.toStr() + "\n{");
}

inline Generator::Eval Generator::zext(const Generator::Operand& x, uint32_t size)
{
	if (x.bit >= size) throw cybozu::Exception("Generator:zext:bad size") << x.bit << size;
	Eval e;
	e.op = x;
	e.op.bit = size;
	e.s = "zext ";
	e.s += x.toStr() + " to i" + cybozu::itoa(size);
	return e;
}

inline Generator::Eval Generator::mul(const Generator::Operand& x, const Generator::Operand& y)
{
	if (x.bit != y.bit) throw cybozu::Exception("Generator:mul:bad size") << x.bit << y.bit;
	Eval e;
	e.op = x;
	e.s = "mul ";
	e.s += x.toStr() + ", " + y.getName();
	return e;
}

inline void Generator::ret(const Generator::Operand& x)
{
	std::string s = "ret " + x.toStr();
	put(s);
}

inline Generator::Eval Generator::lshr(const Generator::Operand& x, uint32_t size)
{
	Eval e;
	e.op = x;
	e.s = "lshr ";
	e.s += x.toStr() + ", " + cybozu::itoa(size);
	return e;
}

inline Generator::Eval Generator::trunc(const Generator::Operand& x, uint32_t size)
{
	Eval e;
	e.op = x;
	e.op.bit = size;
	e.s = "trunc ";
	e.s += x.toStr() + " to i" + cybozu::itoa(size);
	return e;
}

inline Generator::Eval Generator::getelementptr(const Generator::Operand& p, const Generator::Operand& i)
{
	Eval e;
	e.op = p;
	e.s = "getelementptr ";
	e.s += p.toStr() + ", " + i.toStr();
	return e;
}

inline Generator::Eval Generator::load(const Generator::Operand& p)
{
	if (!p.type.isPtr) throw cybozu::Exception("Generator:load:not pointer") << p.type;
	Eval e;
	e.op = p;
	e.op.type.isPtr = false;
	e.s = "load ";
	e.s += p.toStr();
	return e;
}

namespace impl {

static inline Generator::Eval callSub(const Generator::Function& f, const Generator::Operand **opTbl, size_t opNum)
{
	if (f.opv.size() != opNum) throw cybozu::Exception("implcallSub:bad num of arg") << f.opv.size() << opNum;
	Generator::Eval e;
	e.op = f.ret;
	e.s = "call ";
	e.s += f.ret.getType();
	e.s += " @" + f.name + "(";
	for (size_t i = 0; i < opNum; i++) {
		if (i > 0) {
			e.s += ", ";
		}
		e.s += opTbl[i]->toStr();
	}
	e.s += ")";
	return e;
}

}

inline Generator::Eval Generator::call(const Generator::Function& f, const Generator::Operand& op1)
{
	const Operand *tbl[] = { &op1 };
	return impl::callSub(f, tbl, CYBOZU_NUM_OF_ARRAY(tbl));
}

inline Generator::Eval Generator::call(const Generator::Function& f, const Generator::Operand& op1, const Generator::Operand& op2)
{
	const Operand *tbl[] = { &op1, &op2 };
	return impl::callSub(f, tbl, CYBOZU_NUM_OF_ARRAY(tbl));
}

inline Generator::Eval Generator::call(const Generator::Function& f, const Generator::Operand& op1, const Generator::Operand& op2, const Generator::Operand& op3)
{
	const Operand *tbl[] = { &op1, &op2, &op3 };
	return impl::callSub(f, tbl, CYBOZU_NUM_OF_ARRAY(tbl));
}

inline Generator::Eval Generator::call(const Generator::Function& f, const Generator::Operand& op1, const Generator::Operand& op2, const Generator::Operand& op3, const Generator::Operand& op4)
{
	const Operand *tbl[] = { &op1, &op2, &op3, &op4 };
	return impl::callSub(f, tbl, CYBOZU_NUM_OF_ARRAY(tbl));
}

#define MCL_GEN_FUNCTION(name, ...) Function name(#name, __VA_ARGS__)

} // mcl

#ifdef _MSC_VER
//	#pragma warning(pop)
#endif
