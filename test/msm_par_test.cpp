/*
	the parallel mulVec and millerLoopVecMT by the parallel-for registered by mcl::ec::setParallelFor (the windows and the point chunks are the tasks)
	the results must not depend on the number of threads nor on the implementation of the parallel-for
	(a sequential one, a pthread one of this test and mcl::ec::parallelForThread of the library)
*/
#include <cybozu/test.hpp>
#include <cybozu/benchmark.hpp>
#include <cybozu/xorshift.hpp>
#include <mcl/bn.hpp>
#include <vector>
#include <stdio.h>
#ifndef _WIN32
#include <pthread.h>
#endif

using namespace mcl::bn;

// the number of the parts of the test parallel-for
static size_t g_parts = 1;
// the number of the calls of parallelForSeq
static size_t g_seqCalls = 0;

// a sequential parallel-for : task(begin, end, tid) for g_parts parts in the order of tid
static void parallelForSeq(mcl::ec::ParallelForTask task, void *arg, size_t n)
{
	g_seqCalls++;
	size_t nt = g_parts;
	if (nt > n) nt = n;
	if (nt == 0) nt = 1;
	const size_t q = n / nt;
	const size_t r = n % nt;
	for (size_t t = 0; t < nt; t++) {
		const size_t begin = q * t + (t < r ? t : r);
		const size_t end = begin + q + (t < r ? 1 : 0);
		task(begin, end, t, arg);
	}
}

#ifndef _WIN32
struct ThreadArg {
	mcl::ec::ParallelForTask task;
	void *arg;
	size_t begin, end, tid;
};
static void* threadEntry(void *p)
{
	const ThreadArg& a = *(const ThreadArg*)p;
	a.task(a.begin, a.end, a.tid, a.arg);
	return 0;
}
// a parallel-for by pthread : the parts 0, ..., nt - 2 run on new threads and the last one on the caller
static void parallelForThread(mcl::ec::ParallelForTask task, void *arg, size_t n)
{
	size_t nt = g_parts;
	if (nt > n) nt = n;
	if (nt == 0) nt = 1;
	const size_t q = n / nt;
	const size_t r = n % nt;
	std::vector<ThreadArg> args(nt);
	std::vector<pthread_t> th(nt);
	for (size_t t = 0; t < nt; t++) {
		ThreadArg& a = args[t];
		a.task = task;
		a.arg = arg;
		a.begin = q * t + (t < r ? t : r);
		a.end = a.begin + q + (t < r ? 1 : 0);
		a.tid = t;
		if (t + 1 < nt) {
			int ret = pthread_create(&th[t], 0, threadEntry, &a);
			CYBOZU_TEST_EQUAL(ret, 0);
		} else {
			threadEntry(&a);
		}
	}
	for (size_t t = 0; t + 1 < nt; t++) pthread_join(th[t], 0);
}
#endif

CYBOZU_TEST_AUTO(init)
{
#if MCL_FP_BIT >= 384
	initPairing(mcl::BLS12_381);
#else
	initPairing(mcl::BN_SNARK1);
#endif
	CYBOZU_TEST_ASSERT(mcl::ec::getParallelFor() == 0);
	size_t maxThreads = 0;
	CYBOZU_TEST_ASSERT(mcl::ec::getParallelFor(&maxThreads) == 0);
	CYBOZU_TEST_EQUAL(maxThreads, 1u);
	mcl::ec::setParallelFor(parallelForSeq, 5);
	CYBOZU_TEST_ASSERT(mcl::ec::getParallelFor(&maxThreads) == parallelForSeq);
	CYBOZU_TEST_EQUAL(maxThreads, 5u);
	mcl::ec::setParallelFor(0, 5);
	CYBOZU_TEST_ASSERT(mcl::ec::getParallelFor(&maxThreads) == 0);
	CYBOZU_TEST_EQUAL(maxThreads, 1u);
}

// the points and the scalars with zero points, duplicate points, small and zero scalars and cancellations
template<class G>
void setVec(std::vector<G>& xVec, std::vector<Fr>& yVec, const G& P, size_t n, cybozu::XorShift& rg)
{
	xVec.resize(n);
	yVec.resize(n);
	G Q = P;
	for (size_t i = 0; i < n; i++) {
		G::add(Q, Q, P);
		xVec[i] = Q;
		yVec[i].setByCSPRNG(rg);
		switch (i % 31) {
		case 3: xVec[i].clear(); break;
		case 5: yVec[i].clear(); break;
		case 7: yVec[i] = 1; break;
		case 11: yVec[i] = -1; break;
		case 13: xVec[i] = xVec[i - 1]; yVec[i] = -yVec[i - 1]; break; // cancel
		case 17: xVec[i] = xVec[i - 1]; break; // the same point
		case 19: G::dbl(xVec[i], xVec[i]); xVec[i] += P; break; // not normalized (z != 1)
		case 23: yVec[i] = 0x12345; break;
		default: break;
		}
	}
}

template<class G>
void testPar(const char *name, const G& P, const size_t *nTbl, size_t nTblN)
{
	cybozu::XorShift rg;
	std::vector<G> xVec, yDummy;
	std::vector<Fr> yVec;
	for (size_t ni = 0; ni < nTblN; ni++) {
		const size_t n = nTbl[ni];
		setVec(xVec, yVec, P, n, rg);
		mcl::ec::setParallelFor(0, 0);
		G Q0;
		G::mulVecConstRef(Q0, xVec.data(), yVec.data(), n);
		const size_t partsTbl[] = { 1, 2, 3, 7, 64 };
		for (size_t pi = 0; pi < CYBOZU_NUM_OF_ARRAY(partsTbl); pi++) {
			g_parts = partsTbl[pi];
			for (int mode = 0; mode < 3; mode++) {
				if (mode == 0) {
					mcl::ec::setParallelFor(parallelForSeq, g_parts);
				} else if (mode == 1) {
#ifdef _WIN32
					continue;
#else
					mcl::ec::setParallelFor(parallelForThread, g_parts);
#endif
				} else {
					mcl::ec::setParallelFor(mcl::ec::parallelForThread, g_parts);
				}
				G Q1;
				G::mulVecConstRef(Q1, xVec.data(), yVec.data(), n);
				CYBOZU_TEST_EQUAL(Q0, Q1);
				std::vector<G> xVec2 = xVec;
				G::mulVec(Q1, xVec2.data(), yVec.data(), n);
				CYBOZU_TEST_EQUAL(Q0, Q1);
				G::mulVecMT(Q1, xVec2.data(), yVec.data(), n, 7); // the registered one is used (cpuN is ignored)
				CYBOZU_TEST_EQUAL(Q0, Q1);
				// the bucket size of the argument
				G::mulVecConstRef(Q1, xVec.data(), yVec.data(), n, 7);
				CYBOZU_TEST_EQUAL(Q0, Q1);
			}
		}
		mcl::ec::setParallelFor(0, 0);
		printf("%s n=%zd ok\n", name, n);
	}
}

CYBOZU_TEST_AUTO(G1)
{
	G1 P;
	hashAndMapToG1(P, "abc", 3);
	const size_t nTbl[] = { 100, 1000, 2048, 4097, 5000, 20000, 70000 };
	testPar("G1", P, nTbl, CYBOZU_NUM_OF_ARRAY(nTbl));
}

CYBOZU_TEST_AUTO(G2)
{
	G2 Q;
	hashAndMapToG2(Q, "abc", 3);
	const size_t nTbl[] = { 100, 1000, 2048, 5000, 20000 };
	testPar("G2", Q, nTbl, CYBOZU_NUM_OF_ARRAY(nTbl));
}

// GT (GroupMtoA) : the generic path without the batch affine addition
CYBOZU_TEST_AUTO(GT)
{
	G1 P;
	G2 Q;
	hashAndMapToG1(P, "abc", 3);
	hashAndMapToG2(Q, "abc", 3);
	GT e;
	pairing(e, P, Q);
	const size_t n = 1100; // n * splitN (4) >= 2 * MCL_MSM_PAR_MIN_CHUNK
	std::vector<GT> xVec(n);
	std::vector<Fr> yVec(n);
	cybozu::XorShift rg;
	xVec[0] = e;
	for (size_t i = 1; i < n; i++) {
		GT::mul(xVec[i], xVec[i - 1], e);
		yVec[i].setByCSPRNG(rg);
	}
	yVec[0] = 3;
	mcl::ec::setParallelFor(0, 0);
	GT z0, z1;
	GT::powVec(z0, xVec.data(), yVec.data(), n);
	const size_t partsTbl[] = { 1, 3, 8 };
	for (size_t pi = 0; pi < CYBOZU_NUM_OF_ARRAY(partsTbl); pi++) {
		g_parts = partsTbl[pi];
		mcl::ec::setParallelFor(parallelForSeq, g_parts);
		GT::powVec(z1, xVec.data(), yVec.data(), n);
		CYBOZU_TEST_EQUAL(z0, z1);
#ifndef _WIN32
		mcl::ec::setParallelFor(parallelForThread, g_parts);
		GT::powVec(z1, xVec.data(), yVec.data(), n);
		CYBOZU_TEST_EQUAL(z0, z1);
#endif
		mcl::ec::setParallelFor(mcl::ec::parallelForThread, g_parts);
		GT::powVec(z1, xVec.data(), yVec.data(), n);
		CYBOZU_TEST_EQUAL(z0, z1);
	}
	mcl::ec::setParallelFor(0, 0);
}

#ifdef NDEBUG
// a parallel-for violating the contract (tid >= maxThreads, end > n, begin == end) : the library must fall back to the sequential one
// (the violation is an assert in the debug build)
static int g_badMode = 0;
static void parallelForBad(mcl::ec::ParallelForTask task, void *arg, size_t n)
{
	switch (g_badMode) {
	case 0: task(0, n, 100, arg); break; // tid >= maxThreads
	case 1: task(0, n + 1, 0, arg); break; // end > n
	case 2: task(0, 0, 0, arg); break; // empty
	default: task(0, n, 0, arg); if (n > 1) task(0, n, 1, arg); break; // the same points twice
	}
}
CYBOZU_TEST_AUTO(badParallelFor)
{
	G1 P;
	hashAndMapToG1(P, "abc", 3);
	const size_t n = 5000;
	cybozu::XorShift rg;
	std::vector<G1> xVec;
	std::vector<Fr> yVec;
	setVec(xVec, yVec, P, n, rg);
	std::vector<G2> Qvec(64);
	for (size_t i = 0; i < Qvec.size(); i++) hashAndMapToG2(Qvec[i], &i, sizeof(i));
	mcl::ec::setParallelFor(0, 0);
	G1 Q0, Q1;
	G1::mulVecConstRef(Q0, xVec.data(), yVec.data(), n);
	Fp12 f0, f1;
	millerLoopVec(f0, xVec.data(), Qvec.data(), Qvec.size());
	for (g_badMode = 0; g_badMode < 4; g_badMode++) {
		mcl::ec::setParallelFor(parallelForBad, 4);
		G1::mulVecConstRef(Q1, xVec.data(), yVec.data(), n);
		CYBOZU_TEST_EQUAL(Q0, Q1);
		millerLoopVec(f1, xVec.data(), Qvec.data(), Qvec.size());
		CYBOZU_TEST_EQUAL(f0, f1);
	}
	mcl::ec::setParallelFor(0, 0);
}
#endif

// the library parallel-for : the parts cover [0, n) exactly once with tid < min(maxThreads, n)
struct CoverCtx {
	size_t n;
	size_t maxThreads;
	std::vector<size_t> count; // [n] how many times i is done
	std::vector<size_t> tidOfPart; // [maxThreads] 1 + the number of the parts of tid
};
static void coverTask(size_t begin, size_t end, size_t tid, void *arg)
{
	CoverCtx& ctx = *(CoverCtx*)arg;
	CYBOZU_TEST_ASSERT(begin < end);
	CYBOZU_TEST_ASSERT(end <= ctx.n);
	CYBOZU_TEST_ASSERT(tid < ctx.maxThreads);
	for (size_t i = begin; i < end; i++) ctx.count[i]++;
	ctx.tidOfPart[tid]++;
}
CYBOZU_TEST_AUTO(parallelForThread)
{
	const size_t maxThreadsTbl[] = { 1, 2, 3, 7, 16 };
	const size_t nTbl[] = { 0, 1, 2, 5, 16, 17, 100 };
	for (size_t ti = 0; ti < CYBOZU_NUM_OF_ARRAY(maxThreadsTbl); ti++) {
		const size_t maxThreads = maxThreadsTbl[ti];
		mcl::ec::setParallelFor(mcl::ec::parallelForThread, maxThreads);
		for (size_t ni = 0; ni < CYBOZU_NUM_OF_ARRAY(nTbl); ni++) {
			CoverCtx ctx;
			ctx.n = nTbl[ni];
			ctx.maxThreads = maxThreads;
			ctx.count.resize(ctx.n);
			ctx.tidOfPart.resize(maxThreads);
			mcl::ec::parallelForThread(coverTask, &ctx, ctx.n);
			for (size_t i = 0; i < ctx.n; i++) CYBOZU_TEST_EQUAL(ctx.count[i], 1u);
			size_t parts = 0;
			for (size_t i = 0; i < maxThreads; i++) {
				CYBOZU_TEST_ASSERT(ctx.tidOfPart[i] <= 1); // each tid has one part
				parts += ctx.tidOfPart[i];
			}
			const size_t expected = ctx.n < maxThreads ? ctx.n : maxThreads;
			CYBOZU_TEST_EQUAL(parts, expected);
		}
	}
	mcl::ec::setParallelFor(0, 0);
}

// millerLoopVecMT with the registered parallel-for and with the automatic registration of the library one
CYBOZU_TEST_AUTO(millerLoopVecMT)
{
	const size_t maxN = 100;
	std::vector<G1> Pvec(maxN);
	std::vector<G2> Qvec(maxN);
	std::vector<Fp12> prod(maxN + 1); // prod[m] = prod_{i<m} millerLoop(P[i], Q[i])
	prod[0] = 1;
	for (size_t i = 0; i < maxN; i++) {
		char c = char('a' + (i % 26));
		char buf[2] = { c, char('0' + (i / 26)) };
		hashAndMapToG1(Pvec[i], buf, 2);
		hashAndMapToG2(Qvec[i], buf, 2);
		Fp12 e;
		millerLoop(e, Pvec[i], Qvec[i]);
		Fp12::mul(prod[i + 1], prod[i], e);
	}
	const size_t nTbl[] = { 0, 1, 15, 16, 31, 32, 33, 50, 100 };
	const size_t partsTbl[] = { 1, 2, 3, 5, 7, 16 };
	for (size_t pi = 0; pi < CYBOZU_NUM_OF_ARRAY(partsTbl); pi++) {
		g_parts = partsTbl[pi];
		for (int mode = 0; mode < 3; mode++) {
			if (mode == 0) {
				mcl::ec::setParallelFor(parallelForSeq, g_parts);
			} else if (mode == 1) {
#ifdef _WIN32
				continue;
#else
				mcl::ec::setParallelFor(parallelForThread, g_parts);
#endif
			} else {
				mcl::ec::setParallelFor(mcl::ec::parallelForThread, g_parts);
			}
			for (size_t ni = 0; ni < CYBOZU_NUM_OF_ARRAY(nTbl); ni++) {
				const size_t n = nTbl[ni];
				Fp12 f;
				f.clear();
				millerLoopVecMT(f, Pvec.data(), Qvec.data(), n, 123); // cpuN is ignored
				CYBOZU_TEST_EQUAL(f, prod[n]);
			}
		}
	}
	// the non-MT millerLoopVec uses the registered parallel-for (initF = true / false)
	for (size_t pi = 0; pi < CYBOZU_NUM_OF_ARRAY(partsTbl); pi++) {
		g_parts = partsTbl[pi];
		mcl::ec::setParallelFor(parallelForSeq, g_parts);
		for (size_t ni = 0; ni < CYBOZU_NUM_OF_ARRAY(nTbl); ni++) {
			const size_t n = nTbl[ni];
			Fp12 f;
			f.clear();
			millerLoopVec(f, Pvec.data(), Qvec.data(), n);
			CYBOZU_TEST_EQUAL(f, prod[n]);
			f = prod[1];
			millerLoopVec(f, Pvec.data(), Qvec.data(), n, false);
			CYBOZU_TEST_EQUAL(f, prod[1] * prod[n]);
		}
	}
	// the MT functions with cpuN threads of the library without registration : the registration is not changed
	for (size_t cpuN = 0; cpuN < 4; cpuN++) {
		mcl::ec::setParallelFor(0, 0);
		for (size_t ni = 0; ni < CYBOZU_NUM_OF_ARRAY(nTbl); ni++) {
			const size_t n = nTbl[ni];
			Fp12 f;
			f.clear();
			millerLoopVecMT(f, Pvec.data(), Qvec.data(), n, cpuN);
			CYBOZU_TEST_EQUAL(f, prod[n]);
			CYBOZU_TEST_ASSERT(mcl::ec::getParallelFor() == 0);
		}
	}
	mcl::ec::setParallelFor(0, 0);
}

// mulVecMT / millerLoopVecMT : the registered parallel-for is used (cpuN is ignored) if any, the registration is never changed
CYBOZU_TEST_AUTO(mulVecMT)
{
	G1 P;
	hashAndMapToG1(P, "abc", 3);
	const size_t n = 5000; // >= 2 * MCL_MSM_PAR_MIN_CHUNK (the parallel path)
	cybozu::XorShift rg;
	std::vector<G1> xVec, xVec2;
	std::vector<Fr> yVec;
	setVec(xVec, yVec, P, n, rg);
	mcl::ec::setParallelFor(0, 0);
	G1 Q0, Q1;
	G1::mulVecConstRef(Q0, xVec.data(), yVec.data(), n);
	// without registration : mulVecMT with cpuN threads of the library, the registration stays empty
	const size_t cpuNTbl[] = { 0, 1, 2, 3, 16 };
	for (size_t i = 0; i < CYBOZU_NUM_OF_ARRAY(cpuNTbl); i++) {
		xVec2 = xVec;
		G1::mulVecMT(Q1, xVec2.data(), yVec.data(), n, cpuNTbl[i]);
		CYBOZU_TEST_EQUAL(Q0, Q1);
		CYBOZU_TEST_ASSERT(mcl::ec::getParallelFor() == 0);
	}
	// with registration : the registered one is used and cpuN is ignored
	g_parts = 3;
	mcl::ec::setParallelFor(parallelForSeq, g_parts);
	g_seqCalls = 0;
	xVec2 = xVec;
	G1::mulVecMT(Q1, xVec2.data(), yVec.data(), n, 7);
	CYBOZU_TEST_EQUAL(Q0, Q1);
	CYBOZU_TEST_ASSERT(g_seqCalls > 0);
	size_t calls = g_seqCalls;
	G1::mulVec(Q1, xVec2.data(), yVec.data(), n); // mulVec uses it too
	CYBOZU_TEST_EQUAL(Q0, Q1);
	CYBOZU_TEST_ASSERT(g_seqCalls > calls);
	calls = g_seqCalls;
	{
		const size_t m = 64;
		std::vector<G2> Qvec(m);
		for (size_t i = 0; i < m; i++) hashAndMapToG2(Qvec[i], &i, sizeof(i));
		Fp12 f1, f2;
		millerLoopVecMT(f1, xVec.data(), Qvec.data(), m, 7);
		CYBOZU_TEST_ASSERT(g_seqCalls > calls);
		mcl::ec::setParallelFor(0, 0);
		millerLoopVec(f2, xVec.data(), Qvec.data(), m);
		CYBOZU_TEST_EQUAL(f1, f2);
	}
	// without registration : mulVec and millerLoopVec do not call any parallel-for
	mcl::ec::setParallelFor(0, 0);
	calls = g_seqCalls;
	G1::mulVec(Q1, xVec2.data(), yVec.data(), n);
	CYBOZU_TEST_EQUAL(Q0, Q1);
	CYBOZU_TEST_EQUAL(g_seqCalls, calls);
	CYBOZU_TEST_ASSERT(mcl::ec::getParallelFor() == 0);
}

#ifndef _WIN32
CYBOZU_TEST_AUTO(bench)
{
	G1 P;
	hashAndMapToG1(P, "abc", 3);
	const size_t n = 1 << 16;
	cybozu::XorShift rg;
	std::vector<G1> xVec(n);
	std::vector<Fr> yVec(n);
	G1 Q = P;
	for (size_t i = 0; i < n; i++) {
		G1::add(Q, Q, P);
		xVec[i] = Q;
		yVec[i].setByCSPRNG(rg);
	}
	G1::normalizeVec(xVec.data(), xVec.data(), n);
	G1 z;
	const int C = 3;
	mcl::ec::setParallelFor(0, 0);
	CYBOZU_BENCH_C("mulVec 1 thread ", C, G1::mulVecConstRef, z, xVec.data(), yVec.data(), n);
	const size_t partsTbl[] = { 2, 4, 8, 16 };
	for (size_t pi = 0; pi < CYBOZU_NUM_OF_ARRAY(partsTbl); pi++) {
		g_parts = partsTbl[pi];
		mcl::ec::setParallelFor(parallelForThread, g_parts);
		char buf[64];
		snprintf(buf, sizeof(buf), "mulVec %2zd threads", g_parts);
		CYBOZU_BENCH_C(buf, C, G1::mulVecConstRef, z, xVec.data(), yVec.data(), n);
		mcl::ec::setParallelFor(mcl::ec::parallelForThread, g_parts);
		snprintf(buf, sizeof(buf), "   lib %2zd threads", g_parts);
		CYBOZU_BENCH_C(buf, C, G1::mulVecConstRef, z, xVec.data(), yVec.data(), n);
	}
	mcl::ec::setParallelFor(0, 0);
}
#endif
