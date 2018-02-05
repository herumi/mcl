#pragma once
/**
	@file
	@brief definition of Op
	@author MITSUNARI Shigeo(@herumi)
	@license modified new BSD license
	http://opensource.org/licenses/BSD-3-Clause
*/
#include <cybozu/random_generator.hpp>

namespace mcl { namespace fp {

namespace local {

template<class RG>
void readWrapper(void *self, void *buf, uint32_t bufSize)
{
	reinterpret_cast<RG*>(self)->read((uint8_t*)buf, bufSize);
}

#if CYBOZU_CPP_VERSION >= CYBOZU_CPP_VERSION_CPP11
template<>
void readWrapper<std::random_device>(void *self, void *buf, uint32_t bufSize)
{
	std::random_device& rg = *reinterpret_cast<std::random_device*>(self);
	uint8_t *p = reinterpret_cast<uint8_t*>(buf);
	uint32_t v;
	while (bufSize >= 4) {
		v = rg();
		memcpy(p, &v, 4);
		p += 4;
		bufSize -= 4;
	}
	if (bufSize > 0) {
		v = rg();
		memcpy(p, &v, bufSize);
	}
}
#endif
} // local
/*
	wrapper of cryptographically secure pseudo random number generator
*/
class RandGen {
	typedef void (*readFuncType)(void *self, void *buf, uint32_t bufSize);
	void *self_;
	readFuncType readFunc_;
public:
	RandGen() : self_(0), readFunc_(0) {}
	RandGen(void *self, readFuncType readFunc) : self_(self) , readFunc_(readFunc) {}
	RandGen(const RandGen& rhs) : self_(rhs.self_), readFunc_(rhs.readFunc_) {}
	RandGen(RandGen& rhs) : self_(rhs.self_), readFunc_(rhs.readFunc_) {}
	RandGen& operator=(const RandGen& rhs)
	{
		self_ = rhs.self_;
		readFunc_ = rhs.readFunc_;
		return *this;
	}
	template<class RG>
	RandGen(RG& rg)
		: self_(reinterpret_cast<void*>(&rg))
		, readFunc_(local::readWrapper<RG>)
	{
	}
	void read(void *out, size_t byteSize)
	{
		readFunc_(self_, out, byteSize);
	}
	bool isZero() const { return self_ == 0 && readFunc_ == 0; }
	static RandGen& get()
	{
		static cybozu::RandomGenerator rg;
		static RandGen wrg(rg);
		return wrg;
	}
	/*
		rg must be thread safe
		rg.read(void *buf, size_t bufSize);
	*/
	void setRandGen(RandGen& rg)
	{
		get() = rg;
	}
};

} } // mcl::fp
