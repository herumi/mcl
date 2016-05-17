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
	enum Type {
		Void = 0,
		Int = 1,
		Pointer = 2,
		Imm = 3
	};
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
		switch (type) {
		default:
			return "void";
		case Int:
		case Pointer:
			return getType() + " " + getName();
		case Imm:
			return cybozu::itoa(imm);
		}
	}
	std::string getType() const
	{
		switch (type) {
		default:
			return "";
		case Int:
			return std::string("i") + cybozu::itoa(bit);
		case Pointer:
			return std::string("i") + cybozu::itoa(bit) + "*";
		}
	}
	std::string getName() const
	{
		switch (type) {
		default:
			return "";
		case Int:
		case Pointer:
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

inline void Generator::ret(const Generator::Operand& x)
{
	std::string s = "ret " + x.toStr();
	put(s);
}

#define MCL_GEN_FUNCTION(name, ...) Function name(#name, __VA_ARGS__)

} // mcl
