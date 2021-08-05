#include <mcl/she.hpp>
#include <cybozu/option.hpp>
#include <sstream>

using namespace mcl::she;

void loadSave(bool compress)
{
	printf("loadSave compress=%d\n", compress);
	SecretKey sec;
	sec.setByCSPRNG();

	PublicKey pub;
	sec.getPublicKey(pub);

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

int main(int argc, char *argv[])
	try
{
	// initialize system
	const size_t hashSize = 1024;
#if 1
	const mcl::EcParam& param = mcl::ecparam::secp256k1;
	initG1only(param, hashSize);
#else
	init();
	setRangeForDLP(hashSize);
#endif
	loadSave(true);
	loadSave(false);
} catch (std::exception& e) {
	printf("ERR %s\n", e.what());
	return 1;
}

