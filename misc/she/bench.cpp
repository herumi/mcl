/*
	For secp384r1
	define this macro if using secp384r1
*/

#include <mcl/she.hpp>
#include <cybozu/option.hpp>
#include <cybozu/benchmark.hpp>
#include <sstream>
#include <vector>
#include <omp.h>

using namespace mcl::she;

const int maxMsg = 10000;

typedef std::vector<CipherTextG1> CipherTextG1Vec;

template<class T>
void loadSaveTest(const char *msg, const T& x, bool compress)
{
	std::string s;
	// save
	{
		std::ostringstream oss; // you can use std::fstream
		if (compress) {
			x.save(oss);
		} else {
			oss.write((const char*)&x, sizeof(x));
		}
		s = oss.str();
		printf("size=%zd\n", s.size());
	}
	// load
	{
		std::istringstream iss(s);
		T y;
		if (compress) {
			y.load(iss);
		} else {
			iss.read((char*)&y, sizeof(y));
		}
		printf("save and load %s %s\n", msg, (x == y) ? "ok" : "err");
	}
}

void loadSave(const SecretKey& sec, const PublicKey& pub, bool compress)
{
	printf("loadSave compress=%d\n", compress);
	int m = 123;
	CipherTextG1 c;
	pub.enc(c, m);
	loadSaveTest("sec", sec, compress);
	loadSaveTest("pub", pub, compress);
	loadSaveTest("ciphertext", c, compress);
}

void benchEnc(const PrecomputedPublicKey& ppub, int vecN)
{
	cybozu::CpuClock clk;
	CipherTextG1Vec cv;
	cv.resize(vecN);
	const int C = 10;
	for (int k = 0; k < C; k++) {
		clk.begin();
		#pragma omp parallel for
		for (int i = 0; i < vecN; i++) {
			ppub.enc(cv[i], i);
		}
		clk.end();
	}
	clk.put("enc");
}

// encrypt and normalize each ciphertext to Affine
void benchEncAffine(const PrecomputedPublicKey& ppub, int vecN)
{
	cybozu::CpuClock clk;
	CipherTextG1Vec cv;
	cv.resize(vecN);
	const int C = 10;
	for (int k = 0; k < C; k++) {
		clk.begin();
		#pragma omp parallel for
		for (int i = 0; i < vecN; i++) {
			ppub.enc(cv[i], i);
			cv[i].normalize();
		}
		clk.end();
	}
	clk.put("enc");
}

// encrypt and normalize all ciphertext to Affine
void benchEncAffineVec(const PrecomputedPublicKey& ppub, int vecN)
{
	cybozu::CpuClock clk;
	CipherTextG1Vec cv;
	cv.resize(vecN);
	const int C = 10;
	for (int k = 0; k < C; k++) {
		clk.begin();
		#pragma omp parallel for
		for (int i = 0; i < vecN; i++) {
			ppub.enc(cv[i], i);
		}
		normalizeVec(&cv[0], vecN);
		clk.end();
	}
	clk.put("enc");
}

void benchAdd(const PrecomputedPublicKey& ppub, int addN, int vecN)
{
	cybozu::CpuClock clk;
	CipherTextG1Vec sumv, cv;
	sumv.resize(vecN);
	cv.resize(addN);
	for (int i = 0; i < addN; i++) {
		ppub.enc(cv[i], i);
	}
	const int C = 10;
	for (int k = 0; k < C; k++) {
		clk.begin();
		#pragma omp parallel for
		for (int j = 0; j < vecN; j++) {
			sumv[j] = cv[0];
			for (int i = 1; i < addN; i++) {
				sumv[j].add(cv[i]);
			}
		}
		clk.end();
	}
	clk.put("add");
}

void benchAddAffine(const PrecomputedPublicKey& ppub, int addN, int vecN)
{
	cybozu::CpuClock clk;
	CipherTextG1Vec sumv, cv;
	sumv.resize(vecN);
	cv.resize(addN);
	for (int i = 0; i < addN; i++) {
		ppub.enc(cv[i], i);
	}
	normalizeVec(&cv[0], addN);
	const int C = 10;
	for (int k = 0; k < C; k++) {
		clk.begin();
		#pragma omp parallel for
		for (int j = 0; j < vecN; j++) {
			sumv[j] = cv[0];
			for (int i = 1; i < addN; i++) {
				sumv[j].add(cv[i]);
			}
		}
		clk.end();
	}
	clk.put("add-affine");
}

void benchDec(const PrecomputedPublicKey& ppub, const SecretKey& sec, int vecN)
{
	cybozu::CpuClock clk;
	CipherTextG1Vec cv;
	cv.resize(vecN);
	for (int i = 0; i < vecN; i++) {
		ppub.enc(cv[i], i % maxMsg);
	}
	const int C = 10;
	for (int k = 0; k < C; k++) {
		clk.begin();
		#pragma omp parallel for
		for (int i = 0; i < vecN; i++) {
			sec.dec(cv[i]);
		}
		clk.end();
	}
	clk.put("dec");
}

void affineSerializeTest(const SecretKey& sec, const PrecomputedPublicKey& ppub)
{
	const int N = 4096;
	size_t FpSize = 256 / 8;
	// * 2 : affine coordinate x, y
	// * 2 : group elements of ElGamal ciphertext
	std::vector<uint8_t> buf(FpSize * 2 * 2 * N);
	{
		CipherTextG1Vec cv;
		cv.resize(N);
		for (int i = 0; i < N; i++) {
			ppub.enc(cv[i], i % maxMsg);
		}
		// serialize and write {cv[i]} to buf
		cybozu::MemoryOutputStream os(buf.data(), buf.size());
		serializeVecToAffine(os, cv.data(), N);
	}
	{
		CipherTextG1Vec cv;
		cv.resize(N);
		// deserialize buf to {cv[i]}
		cybozu::MemoryInputStream is(buf.data(), buf.size());
		deserializeVecFromAffine(cv.data(), N, is);

		// check values
		for (int i = 0; i < N; i++) {
			int x = sec.dec(cv[i]);
			int y = i % maxMsg;
			if (x != y) {
				printf("err i=%d x=%d y=%d\n", i, x, y);
				exit(1);
			}
		}
		puts("serialize deserialize ok");
	}
}

void exec(const std::string& mode, int addN, int vecN)
{
	SecretKey sec;
	sec.setByCSPRNG();

	PublicKey pub;
	sec.getPublicKey(pub);
	PrecomputedPublicKey ppub;
	ppub.init(pub);

	if (mode == "enc") {
		benchEnc(ppub, vecN);
		return;
	}
	if (mode == "enc-affine") {
		benchEncAffine(ppub, vecN);
		return;
	}
	if (mode == "enc-affine-vec") {
		benchEncAffineVec(ppub, vecN);
		return;
	}
	if (mode == "add") {
		benchAdd(ppub, addN, vecN);
		return;
	}
	if (mode == "add-affine") {
		benchAddAffine(ppub, addN, vecN);
		return;
	}
	if (mode == "dec") {
		benchDec(ppub, sec, vecN);
		return;
	}
	if (mode == "loadsave") {
		loadSave(sec, pub, false);
		loadSave(sec, pub, true);
		affineSerializeTest(sec, ppub);
		return;
	}
	printf("not supported mode=%s\n", mode.c_str());
}

int main(int argc, char *argv[])
	try
{
	cybozu::Option opt;
	int cpuN;
	int addN;
	int vecN;
	std::string mode;
	opt.appendOpt(&cpuN, 1, "cpu", "# of cpus");
	opt.appendOpt(&addN, 128, "add", "# of add");
	opt.appendOpt(&vecN, 1024, "n", "# of elements");
	opt.appendParam(&mode, "mode", "enc|enc-affine|enc-affine-vec|add|add-affine|dec|loadsave");
	opt.appendHelp("h");
	if (opt.parse(argc, argv)) {
		opt.put();
	} else {
		opt.usage();
		return 1;
	}
	omp_set_num_threads(cpuN);

	// initialize system
	const size_t hashSize = maxMsg;
	printf("MCL_FP_BIT=%d\n", MCL_FP_BIT);
	const mcl::EcParam& param = mcl::ecparam::secp256k1;
	puts("secp256k1");
	initG1only(param, hashSize);

	exec(mode, addN, vecN);
} catch (std::exception& e) {
	printf("ERR %s\n", e.what());
	return 1;
}

