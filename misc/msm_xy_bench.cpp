/*
	compare the layouts of a point of the generic kernel of mulVec (MsmXYKernel / MsmGenericKernel in src/glv.hpp)
	build the library and this file twice : the default (the layout (x, y)) and with -DMCL_MSM_NO_XY_KERNEL (the layout of G).
	on a CPU with AVX-512 IFMA, add MCL_MSM=0 to disable the SIMD kernel (otherwise the generic kernel is not used).

	make clean && make -j lib/libmcl.a MCL_FP_BIT=256 MCL_FR_BIT=256 [MCL_MSM=0]
	g++ -O3 -DNDEBUG -std=c++17 -DMCL_FP_BIT=256 -DMCL_FR_BIT=256 [-DMCL_MSM=0] -I include misc/msm_xy_bench.cpp lib/libmcl.a -o bin/msm_xy.exe -lpthread
	make clean && make -j lib/libmcl.a MCL_FP_BIT=256 MCL_FR_BIT=256 [MCL_MSM=0] CFLAGS_USER=-DMCL_MSM_NO_XY_KERNEL
	g++ ... -o bin/msm_g.exe

	usage : msm_xy.exe [mode] [threads] [minLog] [maxLog]
	mode : 0 = 254-bit random scalars, 1 = a quarter each of 0, 1, 63-bit and 254-bit scalars (like a witness)
	threads : 1 = mulVecConstRef (sequential), otherwise mulVecMT with this number of threads (0 : all the processors)
	the points are tau^i G of BN254 (BN_SNARK1) like a ptau. the points and the scalars are deterministic,
	so the head of x of the result must be the same for both builds.
*/
#include <mcl/bn.hpp>
#include <mcl/window_method.hpp>
#include <chrono>
#include <vector>
#include <algorithm>
#include <string>
#include <stdio.h>
#include <stdlib.h>

using namespace mcl;

int main(int argc, char **argv)
{
	const int mode = argc > 1 ? atoi(argv[1]) : 0;
	const size_t th = argc > 2 ? atoi(argv[2]) : 1;
	const int minLog = argc > 3 ? atoi(argv[3]) : 14;
	const int maxLog = argc > 4 ? atoi(argv[4]) : 20;
	if (minLog < 1 || maxLog < minLog || maxLog > 26) {
		printf("bad range\n");
		return 1;
	}
	initPairing(mcl::BN_SNARK1);
	const size_t maxN = size_t(1) << maxLog;
	std::vector<G1> P(maxN);
	{
		Fr tau;
		tau.setHashOf("tau", 3);
		G1 G;
		mapToG1(G, 1);
		std::vector<Fr> pw(maxN);
		pw[0] = 1;
		for (size_t i = 1; i < maxN; i++) pw[i] = pw[i - 1] * tau;
		fp::WindowMethod<G1> wm;
		wm.init(G, 254, 12);
		for (size_t i = 0; i < maxN; i++) wm.mul(P[i], pw[i]);
		G1::normalizeVec(P.data(), P.data(), maxN);
	}
	std::vector<Fr> s(maxN);
	for (size_t i = 0; i < maxN; i++) {
		const uint64_t v = i;
		s[i].setHashOf(&v, sizeof(v));
		if (mode == 1) {
			const uint32_t r = uint32_t(s[i].getUnit()[0]) & 3;
			if (r == 0) {
				s[i] = 0;
			} else if (r == 1) {
				s[i] = 1;
			} else if (r == 2) {
				s[i] = int64_t(s[i].getUnit()[1] >> 1);
			}
		}
	}
#ifdef MCL_MSM_NO_XY_KERNEL
	const char *layout = "G";
#else
	const char *layout = "xy";
#endif
	printf("layout=%s mode=%d threads=%d\n", layout, mode, int(th));
	for (int lg = minLog; lg <= maxLog; lg++) {
		const size_t n = size_t(1) << lg;
		G1 Q;
		double best = 1e30;
		const int C = lg >= 20 ? 7 : 15;
		for (int c = 0; c < C; c++) {
			const std::chrono::steady_clock::time_point t0 = std::chrono::steady_clock::now();
			if (th == 1) {
				G1::mulVecConstRef(Q, P.data(), s.data(), n);
			} else {
				G1::mulVecMT(Q, P.data(), s.data(), n, th);
			}
			const std::chrono::steady_clock::time_point t1 = std::chrono::steady_clock::now();
			best = std::min(best, std::chrono::duration<double, std::milli>(t1 - t0).count());
		}
		Q.normalize();
		printf("n=2^%d %9.3f ms %s\n", lg, best, Q.x.getStr(16).substr(0, 12).c_str());
	}
	return 0;
}
