#include <mcl/bn256.hpp>
#include <stdint.h>
#include <sstream>

void SystemInit() throw(std::exception)
{
	mcl::bn256::bn256init();
}

class G1;
class G2;
class GT;
/*
	Fr = Z / rZ
*/
class Fr {
	mcl::bn256::Fr self_;
	friend class G1;
	friend class G2;
	friend class GT;
	friend void neg(Fr& y, const Fr& x);
	friend void add(Fr& z, const Fr& x, const Fr& y);
	friend void sub(Fr& z, const Fr& x, const Fr& y);
	friend void mul(Fr& z, const Fr& x, const Fr& y);
	friend void mul(G1& z, const G1& x, const Fr& y);
	friend void mul(G2& z, const G2& x, const Fr& y);
	friend void div(Fr& z, const Fr& x, const Fr& y);
	friend void pow(GT& z, const GT& x, const Fr& y);
public:
	Fr() {}
	Fr(const Fr& rhs) : self_(rhs.self_) {}
	Fr(int x) : self_(x) {}
	Fr(const std::string& str) throw(std::exception)
		: self_(str) {}
	bool equals(const Fr& rhs) const { return self_ == rhs.self_; }
	void setStr(const  std::string& str) throw(std::exception)
	{
		self_.setStr(str);
	}
	void setInt(int x)
	{
		self_ = x;
	}
	void clear()
	{
		self_.clear();
	}
	void setRand()
	{
		self_.setRand(Param::getParam().rg);
	}
	std::string toString() const throw(std::exception)
	{
		return self_.getStr();
	}
};

void neg(Fr& y, const Fr& x)
{
	mcl::bn256::Fr::neg(y.self_, x.self_);
}

void add(Fr& z, const Fr& x, const Fr& y)
{
	mcl::bn256::Fr::add(z.self_, x.self_, y.self_);
}

void sub(Fr& z, const Fr& x, const Fr& y)
{
	mcl::bn256::Fr::sub(z.self_, x.self_, y.self_);
}

void mul(Fr& z, const Fr& x, const Fr& y)
{
	mcl::bn256::Fr::mul(z.self_, x.self_, y.self_);
}

void div(Fr& z, const Fr& x, const Fr& y)
{
	mcl::bn256::Fr::div(z.self_, x.self_, y.self_);
}

/*
	#G1 = r
*/
class G1 {
	mcl::bn256::G1 self_;
	friend void neg(G1& y, const G1& x);
	friend void dbl(G1& y, const G1& x);
	friend void add(G1& z, const G1& x, const G1& y);
	friend void sub(G1& z, const G1& x, const G1& y);
	friend void mul(G1& z, const G1& x, const Fr& y);
	friend void pairing(GT& e, const G1& P, const G2& Q);
public:
	G1() {}
	G1(const G1& rhs) : self_(rhs.self_) {}
	G1(const std::string& x, const std::string& y) throw(std::exception)
		: self_(mcl::bn256::Fp(x), mcl::bn256::Fp(y))
	{
	}
	bool equals(const G1& rhs) const { return self_ == rhs.self_; }
	void set(const std::string& x, const std::string& y)
	{
		self_.set(mcl::bn256::Fp(x), mcl::bn256::Fp(y));
	}
	void hashAndMapToG1(const std::string& m) throw(std::exception)
	{
		HashAndMapToG1(self_, m);
	}
	void clear()
	{
		self_.clear();
	}
	/*
		compressed format
	*/
	void setStr(const std::string& str) throw(std::exception)
	{
		self_.setStr(str);
	}
	std::string toString() const throw(std::exception)
	{
		return self_.getStr();
	}
};

void neg(G1& y, const G1& x)
{
	mcl::bn256::G1::neg(y.self_, x.self_);
}
void dbl(G1& y, const G1& x)
{
	mcl::bn256::G1::dbl(y.self_, x.self_);
}
void add(G1& z, const G1& x, const G1& y)
{
	mcl::bn256::G1::add(z.self_, x.self_, y.self_);
}
void sub(G1& z, const G1& x, const G1& y)
{
	mcl::bn256::G1::sub(z.self_, x.self_, y.self_);
}
void mul(G1& z, const G1& x, const Fr& y)
{
	mcl::bn256::G1::mul(z.self_, x.self_, y.self_);
}

/*
	#G2 = r
*/
class G2 {
	mcl::bn256::G2 self_;
	friend void neg(G2& y, const G2& x);
	friend void dbl(G2& y, const G2& x);
	friend void add(G2& z, const G2& x, const G2& y);
	friend void sub(G2& z, const G2& x, const G2& y);
	friend void mul(G2& z, const G2& x, const Fr& y);
	friend void pairing(GT& e, const G1& P, const G2& Q);
public:
	G2() {}
	G2(const G2& rhs) : self_(rhs.self_) {}
	G2(const std::string& xa, const std::string& xb, const std::string& ya, const std::string& yb) throw(std::exception)
		: self_(mcl::bn256::Fp2(xa, xb), mcl::bn256::Fp2(ya, yb))
	{
	}
	bool equals(const G2& rhs) const { return self_ == rhs.self_; }
	void set(const std::string& xa, const std::string& xb, const std::string& ya, const std::string& yb)
	{
		self_.set(mcl::bn256::Fp2(xa, xb), mcl::bn256::Fp2(ya, yb));
	}
	void clear()
	{
		self_.clear();
	}
	/*
		compressed format
	*/
	void setStr(const std::string& str) throw(std::exception)
	{
		self_.setStr(str);
	}
	std::string toString() const throw(std::exception)
	{
		return self_.getStr();
	}
};

void neg(G2& y, const G2& x)
{
	mcl::bn256::G2::neg(y.self_, x.self_);
}
void dbl(G2& y, const G2& x)
{
	mcl::bn256::G2::dbl(y.self_, x.self_);
}
void add(G2& z, const G2& x, const G2& y)
{
	mcl::bn256::G2::add(z.self_, x.self_, y.self_);
}
void sub(G2& z, const G2& x, const G2& y)
{
	mcl::bn256::G2::sub(z.self_, x.self_, y.self_);
}
void mul(G2& z, const G2& x, const Fr& y)
{
	mcl::bn256::G2::mul(z.self_, x.self_, y.self_);
}

/*
	#GT = r
*/
class GT {
	mcl::bn256::Fp12 self_;
	friend void mul(GT& z, const GT& x, const GT& y);
	friend void pow(GT& z, const GT& x, const Fr& y);
	friend void pairing(GT& e, const G1& P, const G2& Q);
public:
	GT() {}
	GT(const GT& rhs) : self_(rhs.self_) {}
	bool equals(const GT& rhs) const { return self_ == rhs.self_; }
	void clear()
	{
		self_.clear();
	}
	void setStr(const std::string& str) throw(std::exception)
	{
		std::istringstream iss(str);
		iss >> self_;
	}
	std::string toString() const throw(std::exception)
	{
		std::ostringstream oss;
		oss << self_;
		return oss.str();
	}
};

void mul(GT& z, const GT& x, const GT& y)
{
	mcl::bn256::Fp12::mul(z.self_, x.self_, y.self_);
}
void pow(GT& z, const GT& x, const Fr& y)
{
	mcl::bn256::Fp12::pow(z.self_, x.self_, y.self_);
}
void pairing(GT& e, const G1& P, const G2& Q)
{
	mcl::bn256::BN::pairing(e.self_, P.self_, Q.self_);
}
