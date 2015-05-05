#pragma once
/**
	@file
	@brief Fp generator
	@author MITSUNARI Shigeo(@herumi)
	@license modified new BSD license
	http://opensource.org/licenses/BSD-3-Clause
*/
#include <stdio.h>
#include <assert.h>
#include <cybozu/exception.hpp>

namespace mcl {

namespace montgomery {

/*
	get pp such that p * pp = -1 mod M,
	where p is prime and M = 1 << 64(or 32).
	@param pLow [in] p mod M
	T is uint32_t or uint64_t
*/
template<class T>
T getCoff(T pLow)
{
	T ret = 0;
	T t = 0;
	T x = 1;

	for (size_t i = 0; i < sizeof(T) * 8; i++) {
		if ((t & 1) == 0) {
			t += pLow;
			ret += x;
		}
		t >>= 1;
		x <<= 1;
	}
	return ret;
}

} } // mcl::montgomery

#if (CYBOZU_HOST == CYBOZU_HOST_INTEL) && (CYBOZU_OS_BIT == 64)

#ifndef XBYAK_NO_OP_NAMES
	#define XBYAK_NO_OP_NAMES
#endif
#include <xbyak/xbyak.h>
#include <xbyak/xbyak_util.h>

namespace mcl {

namespace fp_gen_local {

class MemReg {
	const Xbyak::Reg64 *r_;
	const Xbyak::RegExp *m_;
	size_t offset_;
public:
	MemReg(const Xbyak::Reg64 *r, const Xbyak::RegExp *m, size_t offset) : r_(r), m_(m), offset_(offset) {}
	bool isReg() const { return r_ != 0; }
	const Xbyak::Reg64& getReg() const { return *r_; }
	Xbyak::RegExp getMem() const { return *m_ + offset_ * sizeof(size_t); }
};

struct MixPack {
	static const size_t useAll = 100;
	Xbyak::util::Pack p;
	Xbyak::RegExp m;
	size_t mn;
	MixPack() : mn(0) {}
	MixPack(Xbyak::util::Pack& remain, size_t& rspPos, size_t n, size_t useRegNum = useAll)
	{
		init(remain, rspPos, n, useRegNum);
	}
	void init(Xbyak::util::Pack& remain, size_t& rspPos, size_t n, size_t useRegNum = useAll)
	{
		size_t pn = std::min(remain.size(), n);
		if (useRegNum != useAll && useRegNum < pn) pn = useRegNum;
		this->mn = n - pn;
		this->m = Xbyak::util::rsp + rspPos;
		this->p = remain.sub(0, pn);
		remain = remain.sub(pn);
		rspPos += mn * 8;
	}
	size_t size() const { return p.size() + mn; }
	bool isReg(size_t n) const { return n < p.size(); }
	const Xbyak::Reg64& getReg(size_t n) const
	{
		assert(n < p.size());
		return p[n];
	}
	Xbyak::RegExp getMem(size_t n) const
	{
		const size_t pn = p.size();
		assert(pn <= n && n < size());
		return m + (int)((n - pn) * sizeof(size_t));
	}
	MemReg operator[](size_t n) const
	{
		const size_t pn = p.size();
		return MemReg((n < pn) ? &p[n] : 0, (n < pn) ? 0 : &m, n - pn);
	}
	void removeLast()
	{
		if (!size()) throw cybozu::Exception("MixPack:removeLast:empty");
		if (mn > 0) {
			mn--;
		} else {
			p = p.sub(0, p.size() - 1);
		}
	}
	/*
		replace Mem with r if possible
	*/
	bool replaceMemWith(Xbyak::CodeGenerator *code, const Xbyak::Reg64& r)
	{
		if (mn == 0) return false;
		p.append(r);
		code->mov(r, code->ptr [m]);
		m = m + 8;
		mn--;
		return true;
	}
};

} // fp_gen_local

/*
	op(r, rm);
	r  : reg
	rm : Reg/Mem
*/
#define MCL_FP_GEN_OP_RM(op, r, rm) \
if (rm.isReg()) { \
	op(r, rm.getReg()); \
} else { \
	op(r, qword [rm.getMem()]); \
}

/*
	op(rm, r);
	rm : Reg/Mem
	r  : reg
*/
#define MCL_FP_GEN_OP_MR(op, rm, r) \
if (rm.isReg()) { \
	op(rm.getReg(), r); \
} else { \
	op(qword [rm.getMem()], r); \
}

struct FpGenerator : Xbyak::CodeGenerator {
	typedef Xbyak::RegExp RegExp;
	typedef Xbyak::Reg64 Reg64;
	typedef Xbyak::Xmm Xmm;
	typedef Xbyak::Operand Operand;
	typedef Xbyak::util::StackFrame StackFrame;
	typedef Xbyak::util::Pack Pack;
	typedef fp_gen_local::MixPack MixPack;
	typedef fp_gen_local::MemReg MemReg;
	static const int UseRDX = Xbyak::util::UseRDX;
	static const int UseRCX = Xbyak::util::UseRCX;
	Xbyak::util::Cpu cpu_;
	bool useMulx_;
	const uint64_t *p_;
	uint64_t pp_;
	int pn_;
	bool isFullBit_;
	// add/sub without carry. return true if overflow
	typedef bool (*bool3op)(uint64_t*, const uint64_t*, const uint64_t*);

	// add/sub with mod
	typedef void (*void3op)(uint64_t*, const uint64_t*, const uint64_t*);

	// mul without carry. return top of z
	typedef uint64_t (*uint3opI)(uint64_t*, const uint64_t*, uint64_t);

	// neg
	typedef void (*void2op)(uint64_t*, const uint64_t*);

	// preInv
	typedef int (*int2op)(uint64_t*, const uint64_t*);
	bool3op addNc_;
	bool3op subNc_;
	void3op add_;
	void3op sub_;
	void3op mul_;
	uint3opI mulI_;
	void2op sqr_;
	void2op neg_;
	void2op shr1_;
	int2op preInv_;
	FpGenerator()
		: CodeGenerator(4096 * 8)
		, p_(0)
		, pp_(0)
		, pn_(0)
		, isFullBit_(0)
		, addNc_(0)
		, subNc_(0)
		, add_(0)
		, sub_(0)
		, mul_(0)
		, mulI_(0)
		, neg_(0)
		, shr1_(0)
		, preInv_(0)
	{
		useMulx_ = cpu_.has(Xbyak::util::Cpu::tBMI2);
	}
	/*
		@param p [in] pointer to prime
		@param pn [in] length of prime
	*/
	void init(const uint64_t *p, int pn)
	{
		if (pn < 2) throw cybozu::Exception("mcl:FpGenerator:small pn") << pn;
		p_ = p;
		pp_ = montgomery::getCoff(p[0]);
		pn_ = pn;
		isFullBit_ = (p_[pn_ - 1] >> 63) != 0;
//		printf("p=%p, pn_=%d, isFullBit_=%d\n", p_, pn_, isFullBit_);

		setSize(0); // reset code
		align(16);
		addNc_ = getCurr<bool3op>();
		gen_addSubNc(true);
		align(16);
		subNc_ = getCurr<bool3op>();
		gen_addSubNc(false);
		align(16);
		add_ = getCurr<void3op>();
		gen_addMod();
		align(16);
		sub_ = getCurr<void3op>();
		gen_sub();
		align(16);
		neg_ = getCurr<void2op>();
		gen_neg();
		align(16);
		mulI_ = getCurr<uint3opI>();
		gen_mulI();
		align(16);
		mul_ = getCurr<void3op>();
		gen_mul();
		align(16);
		sqr_ = getCurr<void2op>();
		if (!gen_sqr()) {
			sqr_ = 0;
		}
		align(16);
		shr1_ = getCurr<void2op>();
		gen_shr1();
		preInv_ = getCurr<int2op>();
		gen_preInv();
	}
	void gen_addSubNc(bool isAdd)
	{
		StackFrame sf(this, 3);
		if (isAdd) {
			gen_raw_add(sf.p[0], sf.p[1], sf.p[2], rax);
		} else {
			gen_raw_sub(sf.p[0], sf.p[1], sf.p[2], rax);
		}
		setc(al);
		movzx(eax, al);
	}
	/*
		pz[] = px[] + py[]
	*/
	void gen_raw_add(const RegExp& pz, const RegExp& px, const RegExp& py, const Reg64& t)
	{
		mov(t, ptr [px]);
		add(t, ptr [py]);
		mov(ptr [pz], t);
		for (int i = 1; i < pn_; i++) {
			mov(t, ptr [px + i * 8]);
			adc(t, ptr [py + i * 8]);
			mov(ptr [pz + i * 8], t);
		}
	}
	/*
		pz[] = px[] - py[]
	*/
	void gen_raw_sub(const RegExp& pz, const RegExp& px, const RegExp& py, const Reg64& t)
	{
		mov(t, ptr [px]);
		sub(t, ptr [py]);
		mov(ptr [pz], t);
		for (int i = 1; i < pn_; i++) {
			mov(t, ptr [px + i * 8]);
			sbb(t, ptr [py + i * 8]);
			mov(ptr [pz + i * 8], t);
		}
	}
	/*
		pz[] = -px[]
	*/
	void gen_raw_neg(const RegExp& pz, const RegExp& px, const Reg64& t0, const Reg64& t1)
	{
		inLocalLabel();
		mov(t0, ptr [px]);
		test(t0, t0);
		jnz(".neg");
		if (pn_ > 1) {
			for (int i = 1; i < pn_; i++) {
				or_(t0, ptr [px + i * 8]);
			}
			jnz(".neg");
		}
		// zero
		for (int i = 0; i < pn_; i++) {
			mov(ptr [pz + i * 8], t0);
		}
		jmp(".exit");
	L(".neg");
		mov(t1, (size_t)p_);
		gen_raw_sub(pz, t1, px, t0);
	L(".exit");
		outLocalLabel();
	}
	/*
		(rdx:pz[0..n-1]) = px[0..n-1] * y
		use t, rax, rdx
		if n > 2
		use
		wk[0] if useMulx_
		wk[0..n-2] otherwise
	*/
	void gen_raw_mulI(const RegExp& pz, const RegExp& px, const Reg64& y, const MixPack& wk, const Reg64& t, size_t n)
	{
		assert(n >= 2);
		if (n == 2) {
			mov(rax, ptr [px]);
			mul(y);
			mov(ptr [pz], rax);
			mov(t, rdx);
			mov(rax, ptr [px + 8]);
			mul(y);
			add(rax, t);
			adc(rdx, 0);
			mov(ptr [pz + 8], rax);
			return;
		}
		if (useMulx_) {
			assert(wk.size() > 0 && wk.isReg(0));
			const Reg64& t1 = wk.getReg(0);
			// mulx(H, L, x) = [H:L] = x * rdx
			mov(rdx, y);
			mulx(t1, rax, ptr [px]); // [y:rax] = px * y
			mov(ptr [pz], rax);
			const Reg64 *pt0 = &t;
			const Reg64 *pt1 = &t1;
			for (size_t i = 1; i < n - 1; i++) {
				mulx(*pt0, rax, ptr [px + i * 8]);
				if (i == 1) {
					add(rax, *pt1);
				} else {
					adc(rax, *pt1);
				}
				mov(ptr [pz + i * 8], rax);
				std::swap(pt0, pt1);
			}
			mulx(rdx, rax, ptr [px + (n - 1) * 8]);
			adc(rax, *pt1);
			mov(ptr [pz + (n - 1) * 8], rax);
			adc(rdx, 0);
			return;
		}
		assert(wk.size() >= n - 1);
		for (size_t i = 0; i < n; i++) {
			mov(rax, ptr [px + i * 8]);
			mul(y);
			if (i < n - 1) {
				mov(ptr [pz + i * 8], rax);
				g_mov(wk[i], rdx);
			}
		}
		for (size_t i = 1; i < n - 1; i++) {
			mov(t, ptr [pz + i * 8]);
			if (i == 1) {
				g_add(t, wk[i - 1]);
			} else {
				g_adc(t, wk[i - 1]);
			}
			mov(ptr [pz + i * 8], t);
		}
		g_adc(rax, wk[n - 2]);
		mov(ptr [pz + (n - 1) * 8], rax);
		adc(rdx, 0);
	}
	void gen_mulI()
	{
		assert(pn_ >= 2);
		const int regNum = useMulx_ ? 2 : (1 + std::min(pn_ - 1, 8));
		const int stackSize = useMulx_ ? 0 : (pn_ - 1) * 8;
		StackFrame sf(this, 3, regNum | UseRDX, stackSize);
		const Reg64& pz = sf.p[0];
		const Reg64& px = sf.p[1];
		const Reg64& y = sf.p[2];
		size_t rspPos = 0;
		Pack remain = sf.t.sub(1);
		MixPack wk(remain, rspPos, pn_ - 1);
		gen_raw_mulI(pz, px, y, wk, sf.t[0], pn_);
		mov(rax, rdx);
	}
	/*
		pz[] = px[]
	*/
	void gen_mov(const RegExp& pz, const RegExp& px, const Reg64& t, int n)
	{
		for (int i = 0; i < n; i++) {
			mov(t, ptr [px + i * 8]);
			mov(ptr [pz + i * 8], t);
		}
	}
	void gen_addMod3()
	{
		StackFrame sf(this, 3, 7);
		const Reg64& pz = sf.p[0];
		const Reg64& px = sf.p[1];
		const Reg64& py = sf.p[2];

		const Reg64& t0 = sf.t[0];
		const Reg64& t1 = sf.t[1];
		const Reg64& t2 = sf.t[2];
		const Reg64& t3 = sf.t[3];
		const Reg64& t4 = sf.t[4];
		const Reg64& t5 = sf.t[5];
		const Reg64& t6 = sf.t[6];

		xor_(t6, t6);
		load_rm(Pack(t2, t1, t0), px);
		add_rm(Pack(t2, t1, t0), py);
		mov_rr(Pack(t5, t4, t3), Pack(t2, t1, t0));
		adc(t6, 0);
		mov(rax, (size_t)p_);
		sub_rm(Pack(t5, t4, t3), rax);
		sbb(t6, 0);
		cmovc(t5, t2);
		cmovc(t4, t1);
		cmovc(t3, t0);
		store_mr(pz, Pack(t5, t4, t3));
	}
	void gen_subMod_le4(int n)
	{
		assert(2 <= n && n <= 4);
		StackFrame sf(this, 3, (n - 1) * 2);
		const Reg64& pz = sf.p[0];
		const Reg64& px = sf.p[1];
		const Reg64& py = sf.p[2];

		Pack rx = sf.t.sub(0, n - 1);
		rx.append(px); // rx = [px, t1, t0]
		Pack ry = sf.t.sub(n - 1, n - 1);
		ry.append(rax); // ry = [rax, t3, t2]

		load_rm(rx, px); // destroy px
		sub_rm(rx, py);
#if 0
		sbb(ry[0], ry[0]); // rx[0] = (x > y) ? 0 : -1
		for (int i = 1; i < n; i++) mov(ry[i], ry[0]);
		mov(py, (size_t)p_);
		for (int i = 0; i < n; i++) and_(ry[i], qword [py + 8 * i]);
		add_rr(rx, ry);
#else
		// a little faster
		sbb(py, py); // py = (x > y) ? 0 : -1
		mov(rax, (size_t)p_);
		load_rm(ry, rax); // destroy rax
		for (size_t i = 0; i < ry.size(); i++) {
			and_(ry[i], py);
		}
		add_rr(rx, ry);
#endif
		store_mr(pz, rx);
	}
	void gen_addMod()
	{
		if (pn_ == 3) {
			gen_addMod3();
			return;
		}
		StackFrame sf(this, 3, 0, pn_ * 8);
		const Reg64& pz = sf.p[0];
		const Reg64& px = sf.p[1];
		const Reg64& py = sf.p[2];
		const Xbyak::CodeGenerator::LabelType jmpMode = pn_ < 5 ? T_AUTO : T_NEAR;

		inLocalLabel();
		gen_raw_add(pz, px, py, rax);
		mov(px, (size_t)p_); // destroy px
		if (isFullBit_) {
			jc(".over", jmpMode);
		}
#ifdef MCL_USE_JMP
		for (int i = 0; i < pn_; i++) {
			mov(py, ptr [pz + (pn_ - 1 - i) * 8]); // destroy py
			cmp(py, ptr [px + (pn_ - 1 - i) * 8]);
			jc(".exit", jmpMode);
			jnz(".over", jmpMode);
		}
		L(".over");
			gen_raw_sub(pz, pz, px, rax);
		L(".exit");
#else
		gen_raw_sub(rsp, pz, px, rax);
		jc(".exit", jmpMode);
		gen_mov(pz, rsp, rax, pn_);
		if (isFullBit_) {
			jmp(".exit", jmpMode);
			L(".over");
			gen_raw_sub(pz, pz, px, rax);
		}
		L(".exit");
#endif
		outLocalLabel();
	}
	void gen_sub()
	{
		if (pn_ <= 4) {
			gen_subMod_le4(pn_);
			return;
		}
		StackFrame sf(this, 3);
		const Reg64& pz = sf.p[0];
		const Reg64& px = sf.p[1];
		const Reg64& py = sf.p[2];
		const Xbyak::CodeGenerator::LabelType jmpMode = pn_ < 5 ? T_AUTO : T_NEAR;

		inLocalLabel();
		gen_raw_sub(pz, px, py, rax);
		jnc(".exit", jmpMode);
		mov(px, (size_t)p_);
		gen_raw_add(pz, pz, px, rax);
	L(".exit");
		outLocalLabel();
	}
	void gen_neg()
	{
		StackFrame sf(this, 2, 2);
		const Reg64& pz = sf.p[0];
		const Reg64& px = sf.p[1];
		gen_raw_neg(pz, px, sf.t[0], sf.t[1]);
	}
	void gen_shr1()
	{
		const int c = 1;
		StackFrame sf(this, 2, 1);
		const Reg64 *t0 = &rax;
		const Reg64 *t1 = &sf.t[0];
		const Reg64& pz = sf.p[0];
		const Reg64& px = sf.p[1];
		mov(*t0, ptr [px]);
		for (int i = 0; i < pn_ - 1; i++) {
			mov(*t1, ptr [px + 8 * (i + 1)]);
			shrd(*t0, *t1, c);
			mov(ptr [pz + i * 8], *t0);
			std::swap(t0, t1);
		}
		shr(*t0, c);
		mov(ptr [pz + (pn_ - 1) * 8], *t0);
	}
	void gen_mul()
	{
		if (pn_ == 3) {
			gen_montMul3(p_, pp_);
		} else if (pn_ == 4) {
			gen_montMul4(p_, pp_);
		} else if (pn_ <= 9) {
			gen_montMulN(p_, pp_, pn_);
		} else {
			throw cybozu::Exception("mcl:FpGenerator:gen_mul:not implemented for") << pn_;
		}
	}
	bool gen_sqr()
	{
		if (pn_ == 3) {
			gen_montSqr3(p_, pp_);
			return true;
		}
		return false;
	}
	/*
		input (pz[], px[], py[])
		z[] <- montgomery(x[], y[])
	*/
	void gen_montMulN(const uint64_t *p, uint64_t pp, int n)
	{
		assert(2 <= pn_ && pn_ <= 9);
		const int regNum = useMulx_ ? 4 : 3 + std::min(n - 1, 7);
		const int stackSize = (n * 3 + (isFullBit_ ? 2 : 1)) * 8;
		StackFrame sf(this, 3, regNum | UseRDX, stackSize);
		const Reg64& pz = sf.p[0];
		const Reg64& px = sf.p[1];
		const Reg64& py = sf.p[2];
		const Reg64& y = sf.t[0];
		const Reg64& pAddr = sf.t[1];
		const Reg64& t = sf.t[2];
		Pack remain = sf.t.sub(3);
		size_t rspPos = 0;

		MixPack pw1(remain, rspPos, n - 1);
		const RegExp pw2 = rsp + rspPos; // pw2[0..n-1]
		const RegExp pc = pw2 + n * 8; // pc[0..n+1]
		mov(pAddr, (size_t)p);

		for (int i = 0; i < n; i++) {
			mov(y, ptr [py + i * 8]);
			montgomeryN_1(pp, n, pc, px, y, pAddr, t, pw1, pw2, i == 0);
		}
		// pz[] = pc[] - p[]
		gen_raw_sub(pz, pc, pAddr, t);
		if (isFullBit_) sbb(qword[pc + n * 8], 0);
		jnc("@f");
		for (int i = 0; i < n; i++) {
			mov(t, ptr [pc + i * 8]);
			mov(ptr [pz + i * 8], t);
		}
	L("@@");
	}
	/*
		input (z, x, y) = (p0, p1, p2)
		z[0..3] <- montgomery(x[0..3], y[0..3])
		destroy gt0, ..., gt9, xm0, xm1, p2
	*/
	void gen_montMul4(const uint64_t *p, uint64_t pp)
	{
		StackFrame sf(this, 3, 10 | UseRDX);
		const Reg64& p0 = sf.p[0];
		const Reg64& p1 = sf.p[1];
		const Reg64& p2 = sf.p[2];

		const Reg64& t0 = sf.t[0];
		const Reg64& t1 = sf.t[1];
		const Reg64& t2 = sf.t[2];
		const Reg64& t3 = sf.t[3];
		const Reg64& t4 = sf.t[4];
		const Reg64& t5 = sf.t[5];
		const Reg64& t6 = sf.t[6];
		const Reg64& t7 = sf.t[7];
		const Reg64& t8 = sf.t[8];
		const Reg64& t9 = sf.t[9];

		movq(xm0, p0); // save p0
		mov(p0, (uint64_t)p);
		movq(xm1, p2);
		mov(p2, ptr [p2]);
		montgomery4_1(pp, t0, t7, t3, t2, t1, p1, p2, p0, t4, t5, t6, t8, t9, true, xm2);

		movq(p2, xm1);
		mov(p2, ptr [p2 + 8]);
		montgomery4_1(pp, t1, t0, t7, t3, t2, p1, p2, p0, t4, t5, t6, t8, t9, false, xm2);

		movq(p2, xm1);
		mov(p2, ptr [p2 + 16]);
		montgomery4_1(pp, t2, t1, t0, t7, t3, p1, p2, p0, t4, t5, t6, t8, t9, false, xm2);

		movq(p2, xm1);
		mov(p2, ptr [p2 + 24]);
		montgomery4_1(pp, t3, t2, t1, t0, t7, p1, p2, p0, t4, t5, t6, t8, t9, false, xm2);
		// [t7:t3:t2:t1:t0]

		mov(t4, t0);
		mov(t5, t1);
		mov(t6, t2);
		mov(rdx, t3);
		sub_rm(Pack(t3, t2, t1, t0), p0);
		if (isFullBit_) sbb(t7, 0);
		cmovc(t0, t4);
		cmovc(t1, t5);
		cmovc(t2, t6);
		cmovc(t3, rdx);

		movq(p0, xm0); // load p0
		store_mr(p0, Pack(t3, t2, t1, t0));
	}
	/*
		input (z, x, y) = (p0, p1, p2)
		z[0..2] <- montgomery(x[0..2], y[0..2])
		destroy gt0, ..., gt9, xm0, xm1, p2
	*/
	void gen_montMul3(const uint64_t *p, uint64_t pp)
	{
		StackFrame sf(this, 3, 10 | UseRDX);
		const Reg64& p0 = sf.p[0];
		const Reg64& p1 = sf.p[1];
		const Reg64& p2 = sf.p[2];

		const Reg64& t0 = sf.t[0];
		const Reg64& t1 = sf.t[1];
		const Reg64& t2 = sf.t[2];
		const Reg64& t3 = sf.t[3];
		const Reg64& t4 = sf.t[4];
		const Reg64& t5 = sf.t[5];
		const Reg64& t6 = sf.t[6];
		const Reg64& t7 = sf.t[7];
		const Reg64& t8 = sf.t[8];
		const Reg64& t9 = sf.t[9];

		movq(xm0, p0); // save p0
		mov(t7, (uint64_t)p);
		mov(t9, ptr [p2]);
		//                c3, c2, c1, c0, px, y,  p,
		montgomery3_1(pp, t0, t3, t2, t1, p1, t9, t7, t4, t5, t6, t8, p0, true);
		mov(t9, ptr [p2 + 8]);
		montgomery3_1(pp, t1, t0, t3, t2, p1, t9, t7, t4, t5, t6, t8, p0, false);

		mov(t9, ptr [p2 + 16]);
		montgomery3_1(pp, t2, t1, t0, t3, p1, t9, t7, t4, t5, t6, t8, p0, false);

		// [(t3):t2:t1:t0]
		mov(t4, t0);
		mov(t5, t1);
		mov(t6, t2);
		sub_rm(Pack(t2, t1, t0), t7);
		if (isFullBit_) sbb(t3, 0);
		cmovc(t0, t4);
		cmovc(t1, t5);
		cmovc(t2, t6);
		movq(p0, xm0);
		store_mr(p0, Pack(t2, t1, t0));
	}
	/*
		input (pz, px)
		z[0..2] <- montgomery(px[0..2], px[0..2])
		destroy gt0, ..., gt9, xm0, xm1, p2
	*/
	void gen_montSqr3(const uint64_t *p, uint64_t pp)
	{
		StackFrame sf(this, 3, 10 | UseRDX, 16 * 3);
		const Reg64& pz = sf.p[0];
		const Reg64& px = sf.p[1];
//		const Reg64& py = sf.p[2]; // not used

		const Reg64& t0 = sf.t[0];
		const Reg64& t1 = sf.t[1];
		const Reg64& t2 = sf.t[2];
		const Reg64& t3 = sf.t[3];
		const Reg64& t4 = sf.t[4];
		const Reg64& t5 = sf.t[5];
		const Reg64& t6 = sf.t[6];
		const Reg64& t7 = sf.t[7];
		const Reg64& t8 = sf.t[8];
		const Reg64& t9 = sf.t[9];

		movq(xm0, pz); // save pz
		mov(t7, (uint64_t)p);
		mov(t9, ptr [px]);
		mul3x1_sqr1(px, t9, t3, t2, t1, t0);
		mov(t0, rdx);
		montgomery3_sub(pp, t0, t9, t2, t1, px, t3, t7, t4, t5, t6, t8, pz, true);

		mov(t3, ptr [px + 8]);
		mul3x1_sqr2(px, t3, t6, t5, t4);
		add_rr(Pack(t1, t0, t9, t2), Pack(rdx, rax, t5, t4));
		if (isFullBit_) setc(pz.cvt8());
		montgomery3_sub(pp, t1, t3, t9, t2, px, t0, t7, t4, t5, t6, t8, pz, false);

		mov(t0, ptr [px + 16]);
		mul3x1_sqr3(t0, t5, t4);
		add_rr(Pack(t2, t1, t3, t9), Pack(rdx, rax, t5, t4));
		if (isFullBit_) setc(pz.cvt8());
		montgomery3_sub(pp, t2, t0, t3, t9, px, t1, t7, t4, t5, t6, t8, pz, false);

		// [t9:t2:t0:t3]
		mov(t4, t3);
		mov(t5, t0);
		mov(t6, t2);
		sub_rm(Pack(t2, t0, t3), t7);
		if (isFullBit_) sbb(t9, 0);
		cmovc(t3, t4);
		cmovc(t0, t5);
		cmovc(t2, t6);
		movq(pz, xm0);
		store_mr(pz, Pack(t2, t0, t3));
	}
	static inline void debug_put_inner(const uint64_t *ptr, int n)
	{
		printf("debug ");
		for (int i = 0; i < n; i++) {
			printf("%016llx", (long long)ptr[n - 1 - i]);
		}
		printf("\n");
	}
#ifdef _MSC_VER
	void debug_put(const RegExp& m, int n)
	{
		assert(n <= 8);
		static uint64_t regBuf[7];

		push(rax);
		mov(rax, (size_t)regBuf);
		mov(ptr [rax + 8 * 0], rcx);
		mov(ptr [rax + 8 * 1], rdx);
		mov(ptr [rax + 8 * 2], r8);
		mov(ptr [rax + 8 * 3], r9);
		mov(ptr [rax + 8 * 4], r10);
		mov(ptr [rax + 8 * 5], r11);
		mov(rcx, ptr [rsp + 8]); // org rax
		mov(ptr [rax + 8 * 6], rcx); // save
		mov(rcx, ptr [rax + 8 * 0]); // org rcx
		pop(rax);

		lea(rcx, ptr [m]);
		mov(rdx, n);
		mov(rax, (size_t)debug_put_inner);
		sub(rsp, 32);
		call(rax);
		add(rsp, 32);

		push(rax);
		mov(rax, (size_t)regBuf);
		mov(rcx, ptr [rax + 8 * 0]);
		mov(rdx, ptr [rax + 8 * 1]);
		mov(r8, ptr [rax + 8 * 2]);
		mov(r9, ptr [rax + 8 * 3]);
		mov(r10, ptr [rax + 8 * 4]);
		mov(r11, ptr [rax + 8 * 5]);
		mov(rax, ptr [rax + 8 * 6]);
		add(rsp, 8);
	}
#endif
	/*
		z >>= c
		@note shrd(r/m, r, imm)
	*/
	void shr_mp(const MixPack& z, uint8_t c, const Reg64& t)
	{
		const size_t n = z.size();
		for (size_t i = 0; i < n - 1; i++) {
			const Reg64 *p;
			if (z.isReg(i + 1)) {
				p = &z.getReg(i + 1);
			} else {
				mov(t, ptr [z.getMem(i + 1)]);
				p = &t;
			}
			if (z.isReg(i)) {
				shrd(z.getReg(i), *p, c);
			} else {
				shrd(qword [z.getMem(i)], *p, c);
			}
		}
		if (z.isReg(n - 1)) {
			shr(z.getReg(n - 1), c);
		} else {
			shr(qword [z.getMem(n - 1)], c);
		}
	}
	/*
		z *= 2
	*/
	void twice_mp(const MixPack& z, const Reg64& t)
	{
		g_add(z[0], z[0], t);
		for (size_t i = 1, n = z.size(); i < n; i++) {
			g_adc(z[i], z[i], t);
		}
	}
	/*
		z += x
	*/
	void add_mp(const MixPack& z, const MixPack& x, const Reg64& t)
	{
		assert(z.size() == x.size());
		g_add(z[0], x[0], t);
		for (size_t i = 1, n = z.size(); i < n; i++) {
			g_adc(z[i], x[i], t);
		}
	}
	void add_m_m(const RegExp& mz, const RegExp& mx, const Reg64& t, int n)
	{
		for (int i = 0; i < n; i++) {
			mov(t, ptr [mx + i * 8]);
			if (i == 0) {
				add(ptr [mz + i * 8], t);
			} else {
				adc(ptr [mz + i * 8], t);
			}
		}
	}
	/*
		mz[] = mx[] - y
	*/
	void sub_m_mp_m(const RegExp& mz, const RegExp& mx, const MixPack& y, const Reg64& t)
	{
		for (size_t i = 0; i < y.size(); i++) {
			mov(t, ptr [mx + i * 8]);
			if (i == 0) {
				if (y.isReg(i)) {
					sub(t, y.getReg(i));
				} else {
					sub(t, ptr [y.getMem(i)]);
				}
			} else {
				if (y.isReg(i)) {
					sbb(t, y.getReg(i));
				} else {
					sbb(t, ptr [y.getMem(i)]);
				}
			}
			mov(ptr [mz + i * 8], t);
		}
	}
	/*
		z -= x
	*/
	void sub_mp(const MixPack& z, const MixPack& x, const Reg64& t)
	{
		assert(z.size() == x.size());
		g_sub(z[0], x[0], t);
		for (size_t i = 1, n = z.size(); i < n; i++) {
			g_sbb(z[i], x[i], t);
		}
	}
	/*
		z -= px[]
	*/
	void sub_mp_m(const MixPack& z, const RegExp& px, const Reg64& t)
	{
		if (z.isReg(0)) {
			sub(z.getReg(0), ptr [px]);
		} else {
			mov(t, ptr [px]);
			sub(ptr [z.getMem(0)], t);
		}
		for (size_t i = 1, n = z.size(); i < n; i++) {
			if (z.isReg(i)) {
				sbb(z.getReg(i), ptr [px + i * 8]);
			} else {
				mov(t, ptr [px + i * 8]);
				sbb(ptr [z.getMem(i)], t);
			}
		}
	}
	void store_mp(const RegExp& m, const MixPack& z, const Reg64& t)
	{
		for (size_t i = 0, n = z.size(); i < n; i++) {
			if (z.isReg(i)) {
				mov(ptr [m + i * 8], z.getReg(i));
			} else {
				mov(t, ptr [z.getMem(i)]);
				mov(ptr [m + i * 8], t);
			}
		}
	}
	void load_mp(const MixPack& z, const RegExp& m, const Reg64& t)
	{
		for (size_t i = 0, n = z.size(); i < n; i++) {
			if (z.isReg(i)) {
				mov(z.getReg(i), ptr [m + i * 8]);
			} else {
				mov(t, ptr [m + i * 8]);
				mov(ptr [z.getMem(i)], t);
			}
		}
	}
	void set_mp(const MixPack& z, const Reg64& t)
	{
		for (size_t i = 0, n = z.size(); i < n; i++) {
			MCL_FP_GEN_OP_MR(mov, z[i], t)
		}
	}
	void mov_mp(const MixPack& z, const MixPack& x, const Reg64& t)
	{
		for (size_t i = 0, n = z.size(); i < n; i++) {
			const MemReg zi = z[i], xi = x[i];
			if (z.isReg(i)) {
				MCL_FP_GEN_OP_RM(mov, zi.getReg(), xi)
			} else {
				if (x.isReg(i)) {
					mov(ptr [z.getMem(i)], x.getReg(i));
				} else {
					mov(t, ptr [x.getMem(i)]);
					mov(ptr [z.getMem(i)], t);
				}
			}
		}
	}
#ifdef _MSC_VER
	void debug_put_mp(const MixPack& mp, int n, const Reg64& t)
	{
		if (n >= 10) exit(1);
		static uint64_t buf[10];
		movq(xm0, rax);
		mov(rax, (size_t)buf);
		store_mp(rax, mp, t);
		movq(rax, xm0);
		push(rax);
		mov(rax, (size_t)buf);
		debug_put(rax, n);
		pop(rax);
	}
#endif

	std::string mkLabel(const char *label, int n) const
	{
		return std::string(label) + Xbyak::Label::toStr(n);
	}
	/*
		int k = preInvC(pr, px)
	*/
	void gen_preInv()
	{
		assert(pn_ >= 2);
		const int freeRegNum = 13;
		if (pn_ > 9) {
			throw cybozu::Exception("mcl:FpGenerator:gen_preInv:large pn_") << pn_;
		}
		StackFrame sf(this, 2, 10 | UseRDX | UseRCX, (std::max<int>(0, pn_ * 5 - freeRegNum) + 1 + (isFullBit_ ? 1 : 0)) * 8);
		const Reg64& pr = sf.p[0];
		const Reg64& px = sf.p[1];
		const Reg64& t = rcx;
		/*
			k = rax, t = rcx : temporary
			use rdx, pr, px in main loop, so we can use 13 registers
			v = t[0, pn_) : all registers
		*/
		size_t rspPos = 0;

		assert(sf.t.size() >= (size_t)pn_);
		Pack remain = sf.t;

		const MixPack rr(remain, rspPos, pn_);
		remain.append(rdx);
		const MixPack ss(remain, rspPos, pn_);
		remain.append(px);
		const int rSize = (int)remain.size();
		MixPack vv(remain, rspPos, pn_, rSize > 0 ? rSize / 2 : -1);
		remain.append(pr);
		MixPack uu(remain, rspPos, pn_);

		const RegExp keep_pr = rsp + rspPos;
		rspPos += 8;
		const RegExp rTop = rsp + rspPos; // used if isFullBit_

		inLocalLabel();
		mov(ptr [keep_pr], pr);
		mov(rax, px);
		// px is free frome here
		load_mp(vv, rax, t); // v = x
		mov(rax, (size_t)p_);
		load_mp(uu, rax, t); // u = p_
		// k = 0
		xor_(rax, rax);
		// rTop = 0
		if (isFullBit_) {
			mov(ptr [rTop], rax);
		}
		// r = 0;
		set_mp(rr, rax);
		// s = 1
		set_mp(ss, rax);
		if (ss.isReg(0)) {
			mov(ss.getReg(0), 1);
		} else {
			mov(qword [ss.getMem(0)], 1);
		}
#if 0
	L(".lp");
		or_mp(vv, t);
		jz(".exit", T_NEAR);

		g_test(uu[0], 1);
		jz(".u_even", T_NEAR);
		g_test(vv[0], 1);
		jz(".v_even", T_NEAR);
		for (int i = pn_ - 1; i >= 0; i--) {
			g_cmp(vv[i], uu[i], t);
			jc(".v_lt_u", T_NEAR);
			if (i > 0) jnz(".v_ge_u", T_NEAR);
		}

	L(".v_ge_u");
		sub_mp(vv, uu, t);
		add_mp(ss, rr, t);
	L(".v_even");
		shr_mp(vv, 1, t);
		twice_mp(rr, t);
		if (isFullBit_) {
			sbb(t, t);
			mov(ptr [rTop], t);
		}
		inc(rax);
		jmp(".lp", T_NEAR);
	L(".v_lt_u");
		sub_mp(uu, vv, t);
		add_mp(rr, ss, t);
		if (isFullBit_) {
			sbb(t, t);
			mov(ptr [rTop], t);
		}
	L(".u_even");
		shr_mp(uu, 1, t);
		twice_mp(ss, t);
		inc(rax);
		jmp(".lp", T_NEAR);
#else
		for (int cn = pn_; cn > 0; cn--) {
			const std::string _lp = mkLabel(".lp", cn);
			const std::string _u_v_odd = mkLabel(".u_v_odd", cn);
			const std::string _u_even = mkLabel(".u_even", cn);
			const std::string _v_even = mkLabel(".v_even", cn);
			const std::string _v_ge_u = mkLabel(".v_ge_u", cn);
			const std::string _v_lt_u = mkLabel(".v_lt_u", cn);
		L(_lp);
			or_mp(vv, t);
			jz(".exit", T_NEAR);

			g_test(uu[0], 1);
			jz(_u_even, T_NEAR);
			g_test(vv[0], 1);
			jz(_v_even, T_NEAR);
		L(_u_v_odd);
			if (cn > 1) {
				isBothZero(vv[cn - 1], uu[cn - 1], t);
				jz(mkLabel(".u_v_odd", cn - 1), T_NEAR);
			}
			for (int i = cn - 1; i >= 0; i--) {
				g_cmp(vv[i], uu[i], t);
				jc(_v_lt_u, T_NEAR);
				if (i > 0) jnz(_v_ge_u, T_NEAR);
			}

		L(_v_ge_u);
			sub_mp(vv, uu, t);
			add_mp(ss, rr, t);
		L(_v_even);
			shr_mp(vv, 1, t);
			twice_mp(rr, t);
			if (isFullBit_) {
				sbb(t, t);
				mov(ptr [rTop], t);
			}
			inc(rax);
			jmp(_lp, T_NEAR);
		L(_v_lt_u);
			sub_mp(uu, vv, t);
			add_mp(rr, ss, t);
			if (isFullBit_) {
				sbb(t, t);
				mov(ptr [rTop], t);
			}
		L(_u_even);
			shr_mp(uu, 1, t);
			twice_mp(ss, t);
			inc(rax);
			jmp(_lp, T_NEAR);

			if (cn > 0) {
				vv.removeLast();
				uu.removeLast();
			}
		}
#endif
	L(".exit");
		assert(ss.isReg(0) && ss.isReg(1));
		const Reg64& t2 = ss.getReg(0);
		const Reg64& t3 = ss.getReg(1);

		mov(t2, (size_t)p_);
		if (isFullBit_) {
			mov(t, ptr [rTop]);
			test(t, t);
			jz("@f");
			sub_mp_m(rr, t2, t);
		L("@@");
		}
		mov(t3, ptr [keep_pr]);
		// pr[] = p[] - rr
		sub_m_mp_m(t3, t2, rr, t);
		jnc("@f");
		// pr[] += p[]
		add_m_m(t3, t2, t, pn_);
	L("@@");
		outLocalLabel();
	}
	void mov32c(const Reg64& r, uint64_t c)
	{
		if (c & 0xffffffff00000000ULL) {
			mov(r, c);
		} else {
			mov(Xbyak::Reg32(r.getIdx()), (uint32_t)c);
		}
	}
private:
	FpGenerator(const FpGenerator&);
	void operator=(const FpGenerator&);
	void make_op_rm(void (Xbyak::CodeGenerator::*op)(const Xbyak::Operand&, const Xbyak::Operand&), const Reg64& op1, const MemReg& op2)
	{
		if (op2.isReg()) {
			(this->*op)(op1, op2.getReg());
		} else {
			(this->*op)(op1, qword [op2.getMem()]);
		}
	}
	void make_op_mr(void (Xbyak::CodeGenerator::*op)(const Xbyak::Operand&, const Xbyak::Operand&), const MemReg& op1, const Reg64& op2)
	{
		if (op1.isReg()) {
			(this->*op)(op1.getReg(), op2);
		} else {
			(this->*op)(qword [op1.getMem()], op2);
		}
	}
	void make_op(void (Xbyak::CodeGenerator::*op)(const Xbyak::Operand&, const Xbyak::Operand&), const MemReg& op1, const MemReg& op2, const Reg64& t)
	{
		if (op1.isReg()) {
			make_op_rm(op, op1.getReg(), op2);
		} else if (op2.isReg()) {
			(this->*op)(ptr [op1.getMem()], op2.getReg());
		} else {
			mov(t, ptr [op2.getMem()]);
			(this->*op)(ptr [op1.getMem()], t);
		}
	}
	void g_add(const MemReg& op1, const MemReg& op2, const Reg64& t) { make_op(&Xbyak::CodeGenerator::add, op1, op2, t); }
	void g_adc(const MemReg& op1, const MemReg& op2, const Reg64& t) { make_op(&Xbyak::CodeGenerator::adc, op1, op2, t); }
	void g_sub(const MemReg& op1, const MemReg& op2, const Reg64& t) { make_op(&Xbyak::CodeGenerator::sub, op1, op2, t); }
	void g_sbb(const MemReg& op1, const MemReg& op2, const Reg64& t) { make_op(&Xbyak::CodeGenerator::sbb, op1, op2, t); }
	void g_cmp(const MemReg& op1, const MemReg& op2, const Reg64& t) { make_op(&Xbyak::CodeGenerator::cmp, op1, op2, t); }
	void g_or(const Reg64& r, const MemReg& op) { make_op_rm(&Xbyak::CodeGenerator::or_, r, op); }
	void g_test(const MemReg& op1, const MemReg& op2, const Reg64& t)
	{
		const MemReg *pop1 = &op1;
		const MemReg *pop2 = &op2;
		if (!pop1->isReg()) {
			std::swap(pop1, pop2);
		}
		// (M, M), (R, M), (R, R)
		if (pop1->isReg()) {
			MCL_FP_GEN_OP_MR(test, (*pop2), pop1->getReg())
		} else {
			mov(t, ptr [pop1->getMem()]);
			test(ptr [pop2->getMem()], t);
		}
	}
	void g_mov(const MemReg& op, const Reg64& r)
	{
		make_op_mr(&Xbyak::CodeGenerator::mov, op, r);
	}
	void g_mov(const Reg64& r, const MemReg& op)
	{
		make_op_rm(&Xbyak::CodeGenerator::mov, r, op);
	}
	void g_add(const Reg64& r, const MemReg& mr) { MCL_FP_GEN_OP_RM(add, r, mr) }
	void g_adc(const Reg64& r, const MemReg& mr) { MCL_FP_GEN_OP_RM(adc, r, mr) }
	void isBothZero(const MemReg& op1, const MemReg& op2, const Reg64& t)
	{
		g_mov(t, op1);
		g_or(t, op2);
	}
	void g_test(const MemReg& op, int imm)
	{
		MCL_FP_GEN_OP_MR(test, op, imm)
	}
	/*
		z[] = x[]
	*/
	void mov_rr(const Pack& z, const Pack& x)
	{
		assert(z.size() == x.size());
		for (int i = 0, n = (int)x.size(); i < n; i++) {
			mov(z[i], x[i]);
		}
	}
	/*
		m[] = x[]
	*/
	void store_mr(const RegExp& m, const Pack& x)
	{
		for (int i = 0, n = (int)x.size(); i < n; i++) {
			mov(ptr [m + 8 * i], x[i]);
		}
	}
	/*
		x[] = m[]
	*/
	void load_rm(const Pack& z, const RegExp& m)
	{
		for (int i = 0, n = (int)z.size(); i < n; i++) {
			mov(z[i], ptr [m + 8 * i]);
		}
	}
	/*
		z[] += x[]
	*/
	void add_rr(const Pack& z, const Pack& x)
	{
		add(z[0], x[0]);
		assert(z.size() == x.size());
		for (size_t i = 1, n = z.size(); i < n; i++) {
			adc(z[i], x[i]);
		}
	}
	/*
		z[] -= x[]
	*/
	void sub_rr(const Pack& z, const Pack& x)
	{
		sub(z[0], x[0]);
		assert(z.size() == x.size());
		for (size_t i = 1, n = z.size(); i < n; i++) {
			sbb(z[i], x[i]);
		}
	}
	/*
		z[] += m[]
	*/
	void add_rm(const Pack& z, const RegExp& m)
	{
		add(z[0], ptr [m + 8 * 0]);
		for (int i = 1, n = (int)z.size(); i < n; i++) {
			adc(z[i], ptr [m + 8 * i]);
		}
	}
	/*
		z[] -= m[]
	*/
	void sub_rm(const Pack& z, const RegExp& m)
	{
		sub(z[0], ptr [m + 8 * 0]);
		for (int i = 1, n = (int)z.size(); i < n; i++) {
			sbb(z[i], ptr [m + 8 * i]);
		}
	}
	/*
		t = all or z[i]
		ZF = z is zero
	*/
	void or_mp(const MixPack& z, const Reg64& t)
	{
		const size_t n = z.size();
		if (n == 1) {
			if (z.isReg(0)) {
				test(z.getReg(0), z.getReg(0));
			} else {
				mov(t, ptr [z.getMem(0)]);
				test(t, t);
			}
		} else {
			g_mov(t, z[0]);
			for (size_t i = 1; i < n; i++) {
				g_or(t, z[i]);
			}
		}
	}
	/*
		[rdx:x:t1:t0] <- py[2:1:0] * x
		destroy x, t
	*/
	void mul3x1(const RegExp& py, const Reg64& x, const Reg64& t2, const Reg64& t1, const Reg64& t0, const Reg64& t)
	{
		if (useMulx_) {
			// mulx(H, L, x) = [H:L] = x * rdx
			/*
				rdx:x
				    t:t1
				      rax:t0
			*/
			mov(rdx, x);
			mulx(rax, t0, ptr [py]); // [rax:t0] = py[0] * x
			mulx(t, t1, ptr [py + 8]); // [t:t1] = py[1] * x
			add(t1, rax);
			mulx(rdx, x, ptr [py + 8 * 2]);
			adc(x, t);
			adc(rdx, 0);
		} else {
			mov(rax, ptr [py]);
			mul(x);
			mov(t0, rax);
			mov(t1, rdx);
			mov(rax, ptr [py + 8]);
			mul(x);
			mov(t, rax);
			mov(t2, rdx);
			mov(rax, ptr [py + 8 * 2]);
			mul(x);
			/*
				rdx:rax
				     t2:t
				        t1:t0
			*/
			add(t1, t);
			adc(rax, t2);
			adc(rdx, 0);
			mov(x, rax);
		}
	}
	/*
		[x2:x1:x0] * x0
	*/
	void mul3x1_sqr1(const RegExp& px, const Reg64& x0, const Reg64& t2, const Reg64& t1, const Reg64& t0, const Reg64& t)
	{
		mov(rax, x0);
		mul(x0);
		mov(t0, rax);
		mov(t1, rdx);
		mov(rax, ptr [px + 8]);
		mul(x0);
		mov(ptr [rsp + 0 * 8], rax); // (x0 * x1)_L
		mov(ptr [rsp + 1 * 8], rdx); // (x0 * x1)_H
		mov(t, rax);
		mov(t2, rdx);
		mov(rax, ptr [px + 8 * 2]);
		mul(x0);
		mov(ptr [rsp + 2 * 8], rax); // (x0 * x2)_L
		mov(ptr [rsp + 3 * 8], rdx); // (x0 * x2)_H
		/*
			rdx:rax
			     t2:t
			        t1:t0
		*/
		add(t1, t);
		adc(t2, rax);
		adc(rdx, 0);
	}
	/*
		[x2:x1:x0] * x1
	*/
	void mul3x1_sqr2(const RegExp& px, const Reg64& x1, const Reg64& t2, const Reg64& t1, const Reg64& t0)
	{
		mov(t0, ptr [rsp + 0 * 8]);// (x0 * x1)_L
		mov(rax, x1);
		mul(x1);
		mov(t1, rax);
		mov(t2, rdx);
		mov(rax, ptr [px + 8 * 2]);
		mul(x1);
		mov(ptr [rsp + 4 * 8], rax); // (x1 * x2)_L
		mov(ptr [rsp + 5 * 8], rdx); // (x1 * x2)_H
		/*
			rdx:rax
			     t2:t1
			         t:t0
		*/
		add(t1, ptr [rsp + 1 * 8]); // (x0 * x1)_H
		adc(rax, t2);
		adc(rdx, 0);
	}
	/*
		[rdx:rax:t1:t0] = [x2:x1:x0] * x2
	*/
	void mul3x1_sqr3(const Reg64& x2, const Reg64& t1, const Reg64& t0)
	{
		mov(rax, x2);
		mul(x2);
		/*
			rdx:rax
			     t2:t
			        t1:t0
		*/
		mov(t0, ptr [rsp + 2 * 8]); // (x0 * x2)_L
		mov(t1, ptr [rsp + 3 * 8]); // (x0 * x2)_H
		add(t1, ptr [rsp + 4 * 8]); // (x1 * x2)_L
		adc(rax, ptr [rsp + 5 * 8]); // (x1 * x2)_H
		adc(rdx, 0);
	}

	/*
		c = [c3:y:c1:c0] = c + x[2..0] * y
		q = uint64_t(c0 * pp)
		c = (c + q * p) >> 64
		input  [c3:c2:c1:c0], px, y, p
		output [c0:c3:c2:c1] ; c0 == 0 unless isFullBit_

		@note use rax, rdx, destroy y
	*/
	void montgomery3_sub(uint64_t pp, const Reg64& c3, const Reg64& c2, const Reg64& c1, const Reg64& c0,
		const Reg64& /*px*/, const Reg64& y, const Reg64& p,
		const Reg64& t0, const Reg64& t1, const Reg64& t2, const Reg64& t3, const Reg64& t4, bool isFirst)
	{
		// input [c3:y:c1:0]
		// [t4:c3:y:c1:c0]
		// t4 = 0 or 1 if isFullBit_, = 0 otherwise
		mov(rax, pp);
		mul(c0); // q = rax
		mov(c2, rax);
		mul3x1(p, c2, t2, t1, t0, t3);
		// [rdx:c2:t1:t0] = p * q
		add(c0, t0); // always c0 is zero
		adc(c1, t1);
		adc(c2, y);
		adc(c3, rdx);
		if (isFullBit_) {
			if (isFirst) {
				setc(c0.cvt8());
			} else {
				adc(c0.cvt8(), t4.cvt8());
			}
		}
	}
	/*
		c = [c3:c2:c1:c0]
		c += x[2..0] * y
		q = uint64_t(c0 * pp)
		c = (c + q * p) >> 64
		input  [c3:c2:c1:c0], px, y, p
		output [c0:c3:c2:c1] ; c0 == 0 unless isFullBit_

		@note use rax, rdx, destroy y
	*/
	void montgomery3_1(uint64_t pp, const Reg64& c3, const Reg64& c2, const Reg64& c1, const Reg64& c0,
		const Reg64& px, const Reg64& y, const Reg64& p,
		const Reg64& t0, const Reg64& t1, const Reg64& t2, const Reg64& t3, const Reg64& t4, bool isFirst)
	{
		if (isFirst) {
			mul3x1(px, y, c2, c1, c0, c3);
			mov(c3, rdx);
			// [c3:y:c1:c0] = px[2..0] * y
		} else {
			mul3x1(px, y, t2, t1, t0, t3);
			// [rdx:y:t1:t0] = px[2..0] * y
			add_rr(Pack(c3, y, c1, c0), Pack(rdx, c2, t1, t0));
			if (isFullBit_) setc(t4.cvt8());
		}
		montgomery3_sub(pp, c3, c2, c1, c0, px, y, p, t0, t1, t2, t3, t4, isFirst);
	}
	/*
		pc[0..n] += x[0..n-1] * y ; pc[] = 0 if isFirst
		pc[n + 1] is temporary used if isFullBit_
		q = uint64_t(pc[0] * pp)
		pc[] = (pc[] + q * p) >> 64
		input : pc[], px[], y, p[], pw1[], pw2[]
		output : pc[0..n]   ; if isFullBit_
		         pc[0..n-1] ; if !isFullBit_
		destroy y
		use
		pw1[0] if useMulx_
		pw1[0..n-2] otherwise
		pw2[0..n-1]
	*/
	void montgomeryN_1(uint64_t pp, int n, const RegExp& pc, const RegExp& px, const Reg64& y, const Reg64& p, const Reg64& t, const MixPack& pw1, const RegExp& pw2, bool isFirst)
	{
		// pc[] += x[] * y
		if (isFirst) {
			gen_raw_mulI(pc, px, y, pw1, t, n);
			mov(ptr [pc + n * 8], rdx);
		} else {
			gen_raw_mulI(pw2, px, y, pw1, t, n);
			mov(t, ptr [pw2 + 0 * 8]);
			add(ptr [pc + 0 * 8], t);
			for (int i = 1; i < n; i++) {
				mov(t, ptr [pw2 + i * 8]);
				adc(ptr [pc + i * 8], t);
			}
			adc(ptr [pc + n * 8], rdx);
			if (isFullBit_) {
				mov(t, 0);
				adc(t, 0);
				mov(qword [pc + (n + 1) * 8], t);
			}
		}
		mov(rax, pp);
		mul(qword [pc]);
		mov(y, rax); // y = q
		gen_raw_mulI(pw2, p, y, pw1, t, n);
		// c[] = (c[] + pw2[]) >> 64
		mov(t, ptr [pw2 + 0 * 8]);
		add(t, ptr [pc + 0 * 8]);
		for (int i = 1; i < n; i++) {
			mov(t, ptr [pw2 + i * 8]);
			adc(t, ptr [pc + i * 8]);
			mov(ptr [pc + (i - 1) * 8], t);
		}
		adc(rdx, ptr [pc + n * 8]);
		mov(ptr [pc + (n - 1) * 8], rdx);
		if (isFullBit_) {
			if (isFirst) {
				mov(t, 0);
			} else {
				mov(t, ptr [pc + (n + 1) * 8]);
			}
			adc(t, 0);
			mov(qword [pc + n * 8], t);
		} else {
			xor_(eax, eax);
			mov(ptr [pc + n * 8], rax);
		}
	}
	/*
		[rdx:x:t2:t1:t0] <- py[3:2:1:0] * x
		destroy x, t
	*/
	void mul4x1(const RegExp& py, const Reg64& x, const Reg64& t3, const Reg64& t2, const Reg64& t1, const Reg64& t0, const Reg64& t)
	{
		if (useMulx_) {
			mov(rdx, x);
			mulx(t1, t0, ptr [py + 8 * 0]);
			mulx(t2, rax, ptr [py + 8 * 1]);
			add(t1, rax);
			mulx(x, rax, ptr [py + 8 * 2]);
			adc(t2, rax);
			mulx(rdx, rax, ptr [py + 8 * 3]);
			adc(x, rax);
			adc(rdx, 0);
		} else {
			mov(rax, ptr [py]);
			mul(x);
			mov(t0, rax);
			mov(t1, rdx);
			mov(rax, ptr [py + 8]);
			mul(x);
			mov(t, rax);
			mov(t2, rdx);
			mov(rax, ptr [py + 8 * 2]);
			mul(x);
			mov(t3, rax);
			mov(rax, x);
			mov(x, rdx);
			mul(qword [py + 8 * 3]);
			add(t1, t);
			adc(t2, t3);
			adc(x, rax);
			adc(rdx, 0);
		}
	}

	/*
		c = [c4:c3:c2:c1:c0]
		c += x[3..0] * y
		q = uint64_t(c0 * pp)
		c = (c + q * p) >> 64
		input  [c4:c3:c2:c1:c0], px, y, p
		output [c0:c4:c3:c2:c1]

		@note use rax, rdx, destroy y
		use xt if isFullBit_
	*/
	void montgomery4_1(uint64_t pp, const Reg64& c4, const Reg64& c3, const Reg64& c2, const Reg64& c1, const Reg64& c0,
		const Reg64& px, const Reg64& y, const Reg64& p,
		const Reg64& t0, const Reg64& t1, const Reg64& t2, const Reg64& t3, const Reg64& t4, bool isFirst, const Xmm& xt)
	{
		if (isFirst) {
			mul4x1(px, y, c3, c2, c1, c0, c4);
			mov(c4, rdx);
			// [c4:y:c2:c1:c0] = px[3..0] * y
		} else {
			mul4x1(px, y, t3, t2, t1, t0, t4);
			// [rdx:y:t2:t1:t0] = px[3..0] * y
			if (isFullBit_) {
				movq(xt, px);
				xor_(px, px);
			}
			add_rr(Pack(c4, y, c2, c1, c0), Pack(rdx, c3, t2, t1, t0));
			if (isFullBit_) {
				adc(px, 0);
			}
		}
		// [px:c4:y:c2:c1:c0]
		// px = 0 or 1 if isFullBit_, = 0 otherwise
		mov(rax, pp);
		mul(c0); // q = rax
		mov(c3, rax);
		mul4x1(p, c3, t3, t2, t1, t0, t4);
		add(c0, t0); // always c0 is zero
		adc(c1, t1);
		adc(c2, t2);
		adc(c3, y);
		adc(c4, rdx);
		if (isFullBit_) {
			if (isFirst) {
				adc(c0, 0);
			} else {
				adc(c0, px);
				movq(px, xt);
			}
		}
	}
};

} // mcl

#endif
