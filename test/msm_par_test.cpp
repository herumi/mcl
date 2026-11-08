/*
	the parallel mulVec by the parallel-for registered by mcl::ec::setParallelFor (the windows and the point chunks are the tasks)
	the results must not depend on the number of threads nor on the implementation of the parallel-for
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

// a sequential parallel-for : task(begin, end, tid) for g_parts parts in the order of tid
static void parallelForSeq(mcl::ec::ParallelForTask task, void *arg, size_t n)
{
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
			for (int mode = 0; mode < 2; mode++) {
				if (mode == 0) {
					mcl::ec::setParallelFor(parallelForSeq, g_parts);
				} else {
#ifdef _WIN32
					continue;
#else
					mcl::ec::setParallelFor(parallelForThread, g_parts);
#endif
				}
				G Q1;
				G::mulVecConstRef(Q1, xVec.data(), yVec.data(), n);
				CYBOZU_TEST_EQUAL(Q0, Q1);
				std::vector<G> xVec2 = xVec;
				G::mulVec(Q1, xVec2.data(), yVec.data(), n);
				CYBOZU_TEST_EQUAL(Q0, Q1);
				G::mulVecMT(Q1, xVec2.data(), yVec.data(), n);
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
	}
	mcl::ec::setParallelFor(0, 0);
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
	}
	mcl::ec::setParallelFor(0, 0);
}
#endif
