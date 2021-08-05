#include <mcl/she.hpp>
#include <cybozu/option.hpp>
#include <cybozu/benchmark.hpp>
#include <sstream>
#include <vector>
#include <omp.h>

using namespace mcl::she;

const int maxMsg = 10000;

typedef std::vector<CipherTextG1> CipherTextG1Vec;

void loadSave(const SecretKey& sec, const PublicKey& pub, bool compress)
{
	printf("loadSave compress=%d\n", compress);
	int m = 123;
	std::string s;
	{
		CipherTextG1 c;
		pub.enc(c, m);
		std::ostringstream oss;
		if (compress) {
			cybozu::save(oss, c);
		} else {
			oss.write((const char*)&c, sizeof(c));
		}
		s = oss.str();
		printf("s.size()=%zd\n", s.size());
	}
	{
		std::istringstream iss(s);
		CipherTextG1 c;
		if (compress) {
			cybozu::load(c, iss);
		} else {
			iss.read((char*)&c, sizeof(c));
		}
		int m2 = sec.dec(c);
		printf("m2=%d\n", m2);
	}
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
	if (mode == "add") {
		benchAdd(ppub, addN, vecN);
		return;
	}
	if (mode == "dec") {
		benchDec(ppub, sec, vecN);
		return;
	}
	if (mode == "loadsave") {
		loadSave(sec, pub, false);
		loadSave(sec, pub, true);
	}
	printf("not supported mode=%s\n", mode.c_str());
}

int main(int argc, char *argv[])
	try
{
	// initialize system
	const size_t hashSize = maxMsg;
#if 1
	const mcl::EcParam& param = mcl::ecparam::secp256k1;
	initG1only(param, hashSize);
#else
	init();
	setRangeForDLP(hashSize);
#endif

	cybozu::Option opt;
	int cpuN;
	int addN;
	int vecN;
	std::string mode;
	opt.appendOpt(&cpuN, 1, "cpu", "# of cpus");
	opt.appendOpt(&addN, 128, "add", "# of add");
	opt.appendOpt(&vecN, 1024, "n", "# of elements");
	opt.appendParam(&mode, "mode", "enc|add|dec|loadsave");
	opt.appendHelp("h");
	if (opt.parse(argc, argv)) {
		opt.put();
	} else {
		opt.usage();
		return 1;
	}
	omp_set_num_threads(cpuN);
	exec(mode, addN, vecN);
} catch (std::exception& e) {
	printf("ERR %s\n", e.what());
	return 1;
}

