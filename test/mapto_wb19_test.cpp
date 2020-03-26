#define PUT(x) std::cout << #x "=" << (x) << std::endl;
#include <cybozu/test.hpp>
#include <cybozu/sha2.hpp>
#include <mcl/bls12_381.hpp>
#include <iostream>
#include <fstream>
#include <cybozu/atoi.hpp>
#include <cybozu/file.hpp>

using namespace mcl;
using namespace mcl::bn;

typedef mcl::MapToG2_WB19<Fp, Fp2, G2> MapTo;
typedef MapTo::Point Point;

void dump(const void *msg, size_t msgSize)
{
	const uint8_t *p = (const uint8_t *)msg;
	for (size_t i = 0; i < msgSize; i++) {
		printf("%02x", p[i]);
	}
	printf("\n");
}

void dump(const std::string& s)
{
	dump(s.c_str(), s.size());
}

std::string toHexStr(const void *_buf, size_t n)
{
	const uint8_t *buf = (const uint8_t*)_buf;
	std::string out;
	out.resize(n * 2);
	for (size_t i = 0; i < n; i++) {
		cybozu::itohex(&out[i * 2], 2, buf[i], false);
	}
	return out;
}

std::string toHexStr(const std::string& s)
{
	return toHexStr(s.c_str(), s.size());
}

typedef std::vector<uint8_t> Uint8Vec;

Uint8Vec fromHexStr(const std::string& s)
{
	Uint8Vec ret(s.size() / 2);
	for (size_t i = 0; i < s.size(); i += 2) {
		ret[i / 2] = cybozu::hextoi(&s[i], 2);
	}
	return ret;
}

struct Fp2Str {
	const char *a;
	const char *b;
};

struct PointStr {
	Fp2Str x;
	Fp2Str y;
	Fp2Str z;
};

void set(Fp2& x, const Fp2Str& s)
{
	x.a.setStr(s.a);
	x.b.setStr(s.b);
}

template<class Point>
void set(Point& P, const PointStr& s)
{
	set(P.x, s.x);
	set(P.y, s.y);
	set(P.z, s.z);
}

std::string toHexStr(const Fp2& x)
{
	uint8_t buf1[96];
	uint8_t buf2[96];
	size_t n1 = x.a.serialize(buf1, sizeof(buf1));
	size_t n2 = x.b.serialize(buf2, sizeof(buf2));
	return toHexStr(buf1, n1) + " " + toHexStr(buf2, n2);
}

std::string toHexStr(const G2& P)
{
	uint8_t xy[96];
	size_t n = P.serialize(xy, 96);
	CYBOZU_TEST_EQUAL(n, 96);
	return toHexStr(xy, 96);
}

void ethMsgToG2test(const std::string& fileName)
{
	const char *dst = "\x02";
	printf("name=%s\n", fileName.c_str());
	std::ifstream ifs(fileName.c_str());
	Uint8Vec buf;
	G2 out;
	for (;;) {
		std::string msg, zero, ret;
		ifs >> msg >> zero >> ret;
		if (zero != "00") break;
		buf = fromHexStr(msg);
		ethMsgToG2(out, buf.data(), buf.size(), dst, strlen(dst));
		std::string s = toHexStr(out);
		CYBOZU_TEST_EQUAL(s, ret);
	}
}

void ethMsgToG2testAll(const std::string& dir)
	try
{
	cybozu::FileList list = cybozu::GetFileList(dir);
	for (size_t i = 0; i < list.size(); i++) {
		const cybozu::FileInfo& info = list[i];
		ethMsgToG2test(dir + "/" + info.name);
	}
} catch (...) {
	printf("skip test because `%s` is not found\n", dir.c_str());
}

void testHMAC()
{
	const char *key = "\x0b\x0b\x0b\x0b\x0b\x0b\x0b\x0b\x0b\x0b\x0b\x0b\x0b\x0b\x0b\x0b\x0b\x0b\x0b\x0b";
	const char *msg = "Hi There";
	uint8_t hmac[32];
	const char *expect = "b0344c61d8db38535ca8afceaf0bf12b881dc200c9833da726e9376c2e32cff7";
	cybozu::hmac256(hmac, key, strlen(key), msg, strlen(msg));
	std::string out = toHexStr(hmac, 32);
	CYBOZU_TEST_EQUAL(out, expect);
}

void testHashToFp2()
{
	const char *msg = "the message to be signed";
	const char *dst = "\x02";
	const char *outS = "0xe54bc0f2e26071a79ba5fe7ae5307d39cf5519e581e03b43f39a431eccc258fa1477c517b1268b22986601ee5caa5ea 0x17e8397d5e687ff7f915c23f27fe1ca2c397a7df91de8c88dc82d34c9188a3ef719f9f20436ea8a5fe7d509fbc79214d";
	Fp2 out, ok;
	ok.setStr(outS);
	ethMsgToFp2(out, msg, strlen(msg), 0, dst, strlen(dst));
	CYBOZU_TEST_EQUAL(out, ok);
}

void ethMsgToG2test()
{
	const char *msg = "the message to be signed";
	const char *dst = "\x02";
	const PointStr outS = {
		{
			"0x29670bca15e948605ae32ac737b719f926bc8cb99e980bf0542cada47f71a9f299f4d8c332776da38c8768ea719911",
			"0x111b35c14e065f0af7bb2697cba31bd21f629c0d42f75411340ae608df3bc2572b746935a788caa6ef10014ee02a0bf0",
		},
		{
			"0xe99fd88ee5bd8272483b498245a59b34a22d4820cdd564fc044510210e6d8da62752ac467dac6421b330b2f62385305",
			"0x199c95bcff2d9ae3486d12892740a35904deddc63d33d1080d498fbe1ce468a8efeb9d62e183c71f0a3bf58422e2f1a2",
		},
		{
			"0x147428ea49f35d9864bfc6685e0651f340f1201082c9dce4b99c72d45bf2d4deda4dcb151cefdfd1dd224c8bb85c8a71",
			"0x7a14a1a0a8a27423e5d912879fec8054ae95f035642e3806fa514b9f1dbbb2bc1144dac067c52305e60e8bc421ad5b4",
		},
	};
	G2 out, ok;
	set(ok, outS);
	ethMsgToG2(out, msg, strlen(msg), dst, strlen(dst));
	CYBOZU_TEST_EQUAL(out, ok);
}

template<class T>
void py_eccTest(const T& mapto)
{
	/*
		testHashToBaseFP2
		https://github.com/status-im/nim-blscurve/blob/de64516a5933a6e8ebb01a346430e61a201b5775/blscurve/hash_to_curve.nim#L492
	*/
	{
		const char *msg = "msg";
		uint8_t ctr = 0;
		const char *dst = "BLS_SIG_BLS12381G2-SHA256-SSWU-RO_POP_";
		const char *expect = "18df4dc51885b18ca0082a4966b0def46287930b8f1c0b673b11ac48d19c8899bc150d83fd3a7a1430b0de541742c1d4 14eef8ca34b82d065d187a3904cb313dbb44558917cc5091574d9999b5ecfdd5af2fa3aea6e02fb253bf4ae670e72d55";
		Fp2 x;
		ethMsgToFp2(x, msg, strlen(msg), ctr, dst, strlen(dst));
		CYBOZU_TEST_EQUAL(toHexStr(x), expect);
	}
	{
		const Fp2Str u0s = {
			"0x004ad233c619209060e40059b81e4c1f92796b05aa1bc6358d65e53dc0d657dfbc713d4030b0b6d9234a6634fd1944e7",
			"0x0e2386c82713441bc3b06a460bd81850f4bf376ea89c80b18c0881e855c58dc8e83b2fd23af983f4786508e30c42af01",
		};
		const Fp2Str u1s = {
			"0x08a6a75e0a8d32f1e096f29047ea879dd34a5504218d7ce92c32c244786822fb73fbf708d167ad86537468249ec6df48",
			"0x07016d0e5e13cd65780042c6f7b4c74ae1c58da438c99582696818b5c229895b893318dcb87d2a65e557d4ebeb408b70",
		};
		// return value of opt_swu2_map in bls_sigs_ref/python-impl/opt_swu_g2.py
		const Fp2Str xs = {
			"0x4861c41efcc5fc56e62273692b48da25d950d2a0aaffb34eff80e8dbdc2d41ca38555ceb8554368436aea47d16056b5",
			"0x9db5217528c55d982cf05fc54242bdcd25f1ebb73372e00e16d8e0f19dc3aeabdeef2d42d693405a04c37d60961526a",
		};
		const Fp2Str ys = {
			"0x177d05b95e7879a7ddbd83c15114b5a4e9846fde72b2263072dc9e60db548ccbadaacb92cc4952d4f47425fe3c5e0172",
			"0xfc82c99b928ed9df12a74f9215c3df8ae1e9a3fa54c00897889296890b23a0edcbb9653f9170bf715f882b35c0b4647",
		};
		Fp2 u0, u1, x, y;
		set(u0, u0s);
		set(u1, u1s);
		set(x, xs);
		set(y, ys);
		G2 P;
		ethFp2ToG2(P, u0, &u1);
		P.normalize();
		CYBOZU_TEST_EQUAL(P.x, x);
		CYBOZU_TEST_EQUAL(P.y, y);
	}
	{
		// https://media.githubusercontent.com/media/ethereum/eth2.0-spec-tests/v0.10.1/tests/general/phase0/bls/sign/small/sign_case_11b8c7cad5238946/data.yaml
		const char *secs = "47b8192d77bf871b62e87859d653922725724a5c031afeabc60bcef5ff665138";
		const char msg[33] = {};
		const PointStr sigs = {
			{
				"2293012529822761631014706649736058250445440108079005633865844964288531978383212702502746862140143627562812967825888",
				"1475696770777687381853347234154288535008294218073605500048435508284141334771039537063168112498702685312150787094910",
			},
			{
				"1469299105114671507318396580458717074245984116935623233990667855919962974356517750849608590897738614199799891365360",
				"2030012464923141446228430710552804525466499055365665031199510204412192520245701820596000835423160058948948207746066",
			},
			{
				"3767430478723640173773019527754919617225964135305264831468522226308636862085707682484234512649553124965049251340541",
				"1620434249170283311052688271749383011546709139865619017626863134580828776106815964830529695055765742705622363756158",
			}
		};
		const char *expect = "b2deb7c656c86cb18c43dae94b21b107595486438e0b906f3bdb29fa316d0fc3cab1fc04c6ec9879c773849f2564d39317bfa948b4a35fc8509beafd3a2575c25c077ba8bca4df06cb547fe7ca3b107d49794b7132ef3b5493a6ffb2aad2a441";
		Fr sec;
		sec.setStr(secs, 16);
		G2 P1, P2, Q;
		set(Q, sigs);
		Q.deserializeHexStr(expect);
		const char *dst = "BLS_SIG_BLS12381G2-SHA256-SSWU-RO-_POP_";
		const size_t dstSize = strlen(dst);
		const size_t msgSize = 32;
		Fp2 t1, t2;
		ethMsgToFp2(t1, msg, msgSize, 0, dst, dstSize);
		ethMsgToFp2(t2, msg, msgSize, 1, dst, dstSize);
		mapto.py_ecc_map_to_curve_G2(P1, t1);
		mapto.py_ecc_map_to_curve_G2(P2, t2);
		const PointStr ss = {
			{
				"1972340536407012813644167184956896760015950618902823780657111692209122974250648595689834944711427684709284318183285",
				"2952312506825835541808570850755873891927945826649651965587037814445801597710562388482713867284483531575836668891717",
			},
			{
				"2802951456840474233717338518518040462806475389210379447165158098937491293557221993219251045678976553989024259770721",
				"2695848095528813794114709219550802586214789808214026789183854152760661360110019071654047951530688159586363471282307",
			},
			{
				"1480478729322062079370070638002133449414477155913782123147952976030053267833796311564176542916706247537348236105579",
				"3253481872910728113595595353980041952789112074899014850028493351493155577726278005524067083458491999010934020984031",
			}
		};
		mapto.toJacobi(P1, P1);
		mapto.toJacobi(P2, P2);
		P1 += P2;
		G2 P11;
		set(P11, ss);
		mapto.toJacobi(P11, P11);
		CYBOZU_TEST_EQUAL(P1, P11);
		const PointStr clears = {
			{
				"1957332172874233660214089655571851577083897125827848734477574606688306573833007308344920242234605652569670194263389",
				"1116411061540418343539740639798030171984762250397980084002067231825141620343376868772345493606425790045780405764984",
			},
			{
				"1009600579479639236035097803661439342927513547544039095581093451111718225564873663970283187908867141796447259993680",
				"1036550257360332982249682819433119008785814033355112815293516573225867246356464383591412294871954385805192773093413",
			},
			{
				"1455356692682887406712747484663891805342757123109829795478648571883713143907445859929832639473694165616164972254859",
				"625703068888812559481386371501827420717093467297957594257224036896125014497486535098535016737064365426613580045089",
			},
		};
		set(P11, clears);
		mapto.clear_h2(P1, P1);
		mapto.toJacobi(P11, P11);
		CYBOZU_TEST_EQUAL(P1, P11);
		mapto.py_ecc_hash_to_G2(P1, msg, msgSize, dst, dstSize);
		CYBOZU_TEST_EQUAL(P1, P11);
		ethMsgToG2(P1, msg, msgSize, dst, dstSize);
		CYBOZU_TEST_EQUAL(P1, P11);
		set(P11, sigs);
		mapto.toJacobi(P11, P11);
		P1 *= sec;
		CYBOZU_TEST_EQUAL(P1, P11);
		CYBOZU_TEST_EQUAL(P1.serializeToHexStr(), expect);
	}
}

template<class T>
void testSign(const T& mapto)
{
	const Fp& H = mapto.half;
	const size_t N = 4;
	const Fp tbl[N] = { 0, 1, H, H + 1 };
	const int expect[N][N] = {
		{  1, 1, 1, -1 },
		{  1, 1, 1, -1 },
		{  1, 1, 1, -1 },
		{ -1, 1, 1, -1 },
	};
	Fp2 t;
	for (size_t i = 0; i < N; i++) {
		t.a = tbl[i];
		for (size_t j = 0; j < N; j++) {
			t.b = tbl[j];
			CYBOZU_TEST_EQUAL(mapto.isNegSign(t), (expect[i][j] < 0));
		}
	}
}

template<class T>
void osswu2_helpTest(const T& mapto)
{
	const struct {
		Fp2Str t;
		Fp2Str x;
		Fp2Str y;
		Fp2Str z;
	} tbl[] = {
		{
			{
				"0xe54bc0f2e26071a79ba5fe7ae5307d39cf5519e581e03b43f39a431eccc258fa1477c517b1268b22986601ee5caa5ea",
				"0x17e8397d5e687ff7f915c23f27fe1ca2c397a7df91de8c88dc82d34c9188a3ef719f9f20436ea8a5fe7d509fbc79214d",
			},
			{
				"0x11d568058220b1826cacde2e367beef98ea1edfde5fbf0491231b7ffdfc867e5269f9cfe65347c32ead182ba6b8c3ba1",
				"0x19f2778213e671ac444b1b579bfdf4e7fabeed9626dc909ce243b60397a6b5f65af0fbbe02a43c1e289f28c927012da1",
			},
			{
				"0xfe17bc695a84ec060b6287a4e77a50f65ba8f2c6c433f8131036ddfe34e3071d1cb71c0000f6bcfada947b19d8588df",
				"0xb76abd285945f787721e7e306895149523941586ac44f25a294c406a70ed570020992025aa307777cfe6c590567dfbe",
			},
			{
				"0x1910249ae63241608e013eb13578b9b3d96774d35e5732fc75efd17c212dd310d7f4016d6f212f62f33d34f10252e3e3",
				"0xdcd076cea67c76a6d0594c8f30c8cd8e9ead24f90870f723228f2203a55e04a5517c426ea2c4bae9d37a11c3d0f1912",
			},
		},
		{
			{
				"0x2a8663422cc279aa8591819195a62cfd57357b7bcb6f4a9174275c2e2e754fb23e2f8a444d0d164990dc03dcb95a129",
				"0x15cf611083511955a70fdcc80cb08c6e22b8043a3038065251d4d3f82c6051bac4933e41d589514c42fba13f78f297ef",
			},
			{
				"0x74ee12dce0c9a8836017172b562ebe491273964dd63df71dea6eb778cd9040e8c9a7136e745013c1def93cc57ef0dae",
				"0xedce8fa83a2435a796d207943b14ea4d1a9850e10a6c2035912f1c5bd579e9cabc54027b87a779af28f380cc5edc8a6",
			},
			{
				"0x11367627461d742b4afac12bd789f1437787f2dc675cf2c7896f004ab8480c06cd06589748d8b9791b4969763962f73c",
				"0x101d8e4c1598e72d943dad4695cfa74236d5065345f1e62e62c75ca30cb0c41c3f6197d7c57d46e8cdd07845d77e1e34",
			},
			{
				"0x3952479e45a0826275c1481fbd78a2b4c5076b6a5cd4ad7e132c1ec460dcaef504943e2c6a969ba182e230da3850b4",
				"0x13b8e64e2e233d1dc4506360c3bff93535642c2d3115c53c049e287e35c03212be882f0618cc50557e55b42be53e4893",
			},
		},
	};
	for (size_t i = 0; i < CYBOZU_NUM_OF_ARRAY(tbl); i++) {
		Fp2 t, x, y, z;
		Point P;
		set(t, tbl[i].t);
		set(x, tbl[i].x);
		set(y, tbl[i].y);
		set(z, tbl[i].z);
		mapto.osswu2_help(P, t);
		CYBOZU_TEST_EQUAL(P.x, x);
		CYBOZU_TEST_EQUAL(P.y, y);
		CYBOZU_TEST_EQUAL(P.z, z);
		CYBOZU_TEST_ASSERT(mapto.isValidPoint(P));
	}
}

template<class T>
void addTest(const T& mapto)
{
	const struct Tbl {
		PointStr P;
		PointStr Q;
		PointStr R;
	} tbl[] = {
		{
			{
				{
					"0x111fe4d895d4a8eb21b87f8717727a638cb3f79b91217ac2b47ea599513a5e9bff14cd85f91e5bef822160e0ad4f6726",
					"0x29180cfc2d6a6c717ad4b93725475117c959496d3163974cc08068c0319cb47ba7c8d49c0ebb1ed1a4659b91acab3f",
				},
				{
					"0x192e14063ab46786058c355387e4141921a2b0fd1bcecd6bbf6e3e25f972b2b88fe23b1fd6b14f8070c7ada0bbcfb8d7",
					"0x153bc38ad032b044e55f649b9b1e6384cfe0936b3be350e16a8cf847790bf718e9099b102fbdab5ad8f0acca6b0ac65a",
				},
				{
					"0x119f8d49f20b7a3ef00527779ef9326250a835a742770e9599b3be1939d5e00f8b329781bea38e725e1b0de76354b2ea",
					"0xd95d36844c2ef0678e3614c0d9698daf7d54cb41322fb6acf90a4fd61122c36213e6f811c81c573385110d98e49136",
				},
			},
			{
				{
					"0x738abc340e315a70a95d22c68e4beb8f8ce8cb17ec4d8104285b5770a63b2e9fdceaffb88df1fde2104d807bd0fb5df",
					"0x19edac9569a018b7a17ddd9554430318500e83e38c798d6f8e0a22e9e54ef2b0ec0cf4866013e3a43237eaf949c4548b",
				},
				{
					"0x12234a4947cf5c0a0fc04edadefa7c3766489d927ad3d7d7236af997b0e0fd7deaaf4ab78aad390c6a8f0088f21256af",
					"0x4a1cddb800e9fc6fb9f12e036bd0dae9a75c276f8007407cb9be46177e4338ac43d00f3dc413cab629d6305327ffbc",
				},
				{
					"0x187212ac7f7d68aa32dafe6c1c52dc0411ea11cffa4c6a10e0ba407c94b8663376f1642379451a09a4c7ce6e691a557f",
					"0x1381999b5cc68ae42d64d71ac99a20fb5874f3883a222a9e15c8211610481642b32b85da288872269480383b62696e5a",
				},
			},
			{
				{
					"0x1027d652690099dd3bea0c8ec2f8686c8db37444b08067a40780a264f2edd995d3a39941a302289ac8025007e7f08e35",
					"0xe4c1e12005a577f2a7487bd0bca91253bfff829258e7120716d70133dfc1c8f4aa80d2b4c076f267f3483ec1ca66cdc",
				},
				{
					"0x16bd53f43f8acfb29d3a451a274445ca87d43f0e1a6550c6107654516fda0b4cd1a346369ef0d44d4ee78904ce1b3e4b",
					"0xf0f67bbce56d7791c676b7af20f0d91382973c6c7b971a920525dbd58b13364ec226651308c8bc56e636d0458d46f50",
				},
				{
					"0x8027cefbfd3e7e7fdc88735eddd7e669520197227bd2a7014078f56489267256fdfb27d080515412d69f86770f3ce",
					"0x2470e1d8896cfe74ab01b68071b97d121333ebcec7a41cddd4581d736a25ba154ac94321a119906e3f41beec971d082",
				},
			},
		},
	};
	for (size_t i = 0; i < CYBOZU_NUM_OF_ARRAY(tbl); i++) {
		Point P, Q, R;
		set(P, tbl[i].P);
		set(Q, tbl[i].Q);
		set(R, tbl[i].R);
		Point E;
		mapto.add(E, P, Q);
		CYBOZU_TEST_EQUAL(R.x, E.x);
		CYBOZU_TEST_EQUAL(R.y, E.y);
		CYBOZU_TEST_EQUAL(R.z, E.z);
	}
}

template<class T>
void iso3Test(const T& mapto)
{
	const PointStr Ps = {
		{
			"0xf0d9554fa5b04dbc6b106727e987bd68fb8c0cc97226a3845b59cc9d09972f24ea5a0d93cd0eedd18318c0024bf3df0",
			"0x656650d143a2cf4a913821fa6a90ab6baa0bb063d1207b15108ea919258bfa4bdd1ba7247e8e65300d526801e43dca6",
		},
		{
			"0x13a4b7c833b2702dc6ac4f5ee6ee74923a24c28e5a9b8e3b5626f700489ea47f9b1c3aa8cc0f4b525ae56e1e89aba868",
			"0x16c0b9a89dcbe4e375f1e4d064013adff8e6e09866d38769c08ce355fbac9c823d52df971286b091b46d2cd49625c09",
		},
		{
			"0x176ce067d52f676d4f6778eda26f2e2e75f9f39712583e60e2b3f345e2b2a84df1ae9ffa241ce89b1a377e4286c85ccf",
			"0x822bc033cf0eec8bea9037ede74db0a73d932dc9b43f855e1862b747b0e53312dde5ed301e32551a11a5ef2dfe2dbf4",
		}
	};
	const PointStr Qs = {
		{
			"0x8d5483693b4cf3fd5c7a62dad4179503094a66a52f2498dcedb5c97a33697ba4110e2da42ddef98beeeab04619ec0fe",
			"0xd45728bb18737fb6abf8cc94ad37957f95855da867ca718708503fd072d3707ca6059fefb5c52b2745210cdd7991d10",
		},
		{
			"0x17027ae16e10908f87e79c70f96ba44b1b11fa40fb5ac5456162133860f14896ca363b58d81ef8cb068bdaca2e576ed7",
			"0xfb2d1655b00027d5580bbff8afa6eec6e6caacf5df4020c5255eafb51d50710193a8e39eac760745c45cc6ec556a820",
		},
		{
			"0x376b86a7d664dc080485c29a57618eee792396f154806f75c78599ee223103e77bee223037bb99354114201619ea06",
			"0xf0c64e52dbb8e2dca3c790993c8f101012c516b2884db16de4d857ae6bfb85e9101ab15906870b3e5a18268a57bfc99",
		}
	};
	const PointStr clearPs = {
		{
			"0x6f3d4cbd80011d9cbf0f0772502d1e6571d00bc24efc892659339fc8ae049e757c57d22368c33cfc6c64bc2df59b3da",
			"0x71e02679953af97ed57d9301d126c3243de7faa3bbebd40b46af880ba3ba608b8c09c0a876401545ce6f901950f192",
		},
		{
			"0x174d1e92bd85b0cf1dd2808bd96a25ed48ba1e8d15c1af5557f62719e9f425bd8df58c900cf036e57bce1b1c78efb859",
			"0x1cfc358b91d57bf6aa9fa6c688b0ef516fdac0c9bfd9ef310ea11e44aaf778cca99430594a8f5eb37d31c1b1f72c2f6",
		},
		{
			"0x17614e52aacf8804ed2e7509db5b72395e586e2edc92dba02da24e6f73d059226a6deb6e396bd39567cec952f3849a6c",
			"0xb7b36b9b1bbcf801d21ca5164aa9a0e71df2b4710c67dc0cd275b786800935fc29defbdf9c7e23dc84e26af13ba761d",
		}
	};
	typename T::Point P;
	G2 Q1, Q2;
	set(P, Ps);
	set(Q1, Qs);
	mapto.iso3(Q2, P);
	CYBOZU_TEST_EQUAL(Q1, Q2);
	set(Q1, clearPs);
	mapto.clear_h2(Q2, Q2);
	CYBOZU_TEST_EQUAL(Q1, Q2);
}

void ethFp2ToG2test()
{
	const Fp2Str t1s = {
		"0xafcfb20d836159f0cfb6f48c0ed808fd97a1cd1b9f1eb14451ff59e3884b1bf7665406cce673d434dde6933bdcf0ec9",
		"0x36714c33fa9c79b0bb9ac963f57b2d2b2659e211893e64292ee2a8c1259b1a834a769782bae17202b537a1fe901c55e",
	};
	const Fp2Str t2s = {
        "0xb9a2f39af0cc3264348ed00845545e2ccbed59ea541c726c8429871f9a0917fb4f7e049ac739065eea8354a2d1b2d21",
		"0xc8810a06deb536d70531352bd2a3aac7496e187a8fc102d800c5f8ed839bd64d7102197aeb2b6164d20ff920ff63afe",
	};
	const PointStr t1t1s = {
		{
			"0x13ea937301cfb2a071a265b08e176854034c2e2ae49898e89c042bff176a1be7bf02dfda06f67d38819ca334218b9ff4",
			"0x180ee537c06213034c842cad3b5a6d0053473e8bb92dd4c5826e59a45268cda3fe28814b1e9f3a58b9db657d9c24a0bd",
		},
		{
			"0x13f4530154b75ce311849e775242b5e791058fd8e1d7df292b8e936e8be05e1cd9fa6eed6280357393d54adf3af0eb9c",
			"0x10619dc087132cf699b02c905284c3449e80c295c8140345e45e21b7389c8f2cf7b5e223ef87f11f57eb1e689f6c141a",
		},
		{
			"0x40f98938abaece4e47427371b3b6c500f9cdacae9d8b4da79ba9107720bd038057a4cc8ec8427d651760fd795d2415",
			"0xac9cd43c4ba29f20ed5dd2aa4a634b39810e756313b4826f225efddfb1ae43185ac4f279e628731030e87405a965bf5",
		},
	};
	const PointStr t1t2s = {
		{
			"0x126b4982298792ed049850bb92b55d26c33a8e3139f9ca1a20821496c7396ce5ad9042b0da529e60ec9c3ff8e983befe",
			"0x11c1d2f6a6a81e1f82dee2278968326e23e6ae469252a51d86673bd8fb333b7bca615b63a068692ff419c5f3e388797b",
		},
		{
			"0x92468e5829b26cc976aff103403b4b5304dd206228c6eb84ecf7b45709307390bf29dced39f9aa037b014ad6fb5a6e4",
			"0x5bd54eef1fdade89c98ab5c27d3dd9e18868af4250ff3a49de71d060ab62b7be039a3b2a8ef0c870d9021f6eae22029",
		},
		{
			"0x154920adb9d857620c2835f4a5445bda35da53411710d559b18430f1b48c7cf2048cc275e0a9e01436d355f76fa0a9ec",
			"0xccc404e5d17aa51f7669402916cf86587ce7cd9c657e90b05d7c8860940f741e62628df420d92c659d159d4b7683cce",
		},
	};
	Fp2 t1, t2;
	set(t1, t1s);
	set(t2, t2s);
	G2 P1, P2;
	set(P1, t1t2s);
	ethFp2ToG2(P2, t1, &t2);
	CYBOZU_TEST_EQUAL(P1, P2);
	set(P1, t1t1s);
	ethFp2ToG2(P2, t1, &t1);
	CYBOZU_TEST_EQUAL(P1, P2);
}

void testVec(const char *file)
{
	std::ifstream ifs(file);
	if (!ifs) {
		printf("skip testVec because `%s` is not found\n", file);
	}
	printf("testVec %s\n", file);
	Fp2 t1, t2;
	G2 out, P;
	std::string s;
	for (;;) {
		ifs >> s;
		if (s != "t1") break;
		ifs >> t1;
		ifs >> s;
		CYBOZU_TEST_EQUAL(s, "t2");
		ifs >> t2;
		ifs >> s;
		CYBOZU_TEST_EQUAL(s, "out");
		ifs >> out.x >> out.y >> out.z;
		ethFp2ToG2(P, t1, &t2);
		CYBOZU_TEST_EQUAL(P, out);
	}
}

template<class T>
void py_eccTest2(const T& mapto)
{
	Fp2Str ts = {
		"1918231859236664604157448091070531325862162392395253569013354101088957561890652491757605826252839368362075816084620",
		"1765592454498940438559713185757713516213027777891663285362602185795653989012303939547547418058658378320847225866857",
	};
	PointStr out1s = {
		{
			"3927184272261705576225284664838663573624313247854459615864888213007837227449093837336748448846489186151562481034580",
			"1903293468617299241460799312855927163610998535569367868293984916087966126786510088134190993502241498025510393259948",
		},
		{
			"3991322739214666504999201807778913642377537002372597995520099276113880862779909709825029178857593814896063515454176",
			"2999367925154329126226224834594837693635617675385117964685771461463180146028553717562548600391126160503718637741311",
		},
		{
			"2578853905647618145305524664579860566455691148296386065391659245709237478565628968511959291772795541098532647163712",
			"3910188857576114167072883940429120413632909260968721432280195359371907407125083761682822023489835923188989938783197",
		},
	};
	PointStr out2s = {
		{
			"3257676086538823567761244186080544403330427395946948635449582231233180442322077484215757257097813156392664917178234",
			"228537154970146118588036771068753907531432250550232803895899422656339347346840810590265440478956079727608969412311",
		},
		{
			"2211656311977487430400091470761449132135875543285725344573261083165139360734602590585740129428161178745780787382986",
			"40258781102313547933704047733645277081466097003572358028270922475602169023300010845551344432311507156784289541037",
		},
		{
			"3554635405737095173231135338330740471713348364117258010850826274365262386961694608537862757803628655357449929362973",
			"3305133470803621861948711123350198492693369595391902116552614265910644738630055172693143208260379598437272858586799",
		},
	};
	Fp2 t;
	set(t, ts);
	Point p, q;
	mapto.py_ecc_optimized_swu_G2(p, t);
	set(q, out1s);
	CYBOZU_TEST_EQUAL(p.x, q.x);
	CYBOZU_TEST_EQUAL(p.y, q.y);
	CYBOZU_TEST_EQUAL(p.z, q.z);
	G2 P, Q;
	set(P, out2s);
	mapto.py_ecc_map_to_curve_G2(Q, t);
	CYBOZU_TEST_EQUAL(P, Q);
}

template<class T>
void testHashToFp2v6(const T& mapto)
{
	const struct {
		const char *msg;
		const char *dst;
		const Fp2Str s[2];
	} tbl[] = {
		{
			// from draft-irtf-cfrg-hash-to-curve/poc/vectors/BLS12381G2_XMD:SHA-256_SSWU_RO_.json.swp
			"abc",
			"BLS12381G2_XMD:SHA-256_SSWU_RO_TESTGEN",
			{
				{
					"0x0b7b2d371fc970671ddf7bc9ca4a70a1bd286af4487b497e460c0b44d405d73db576f8a08d59416cc976d4b1d0100775",
					"0x0e86d0eb2d34c34fe8b2a1f2d999fa3dabcd504fdb4beb57e79756b08fd75b0a82660abc6026ecc4ccf327a522587b38",
				},
				{
					"0x10376d048c060df1c5017a363144c482892fe2ce0061094327b8bbe49a713ce795726aa23b5402a271e9f1e7b9b6c7ba",
					"0x0117f2ea63015e192d759f11a658a002e06112147d90f00d7429722456b9a1c63fef2dbe8df13168e3bd40af2fb959f3",
				},
			}
		},
		{
			"asdf",
			"QUUX-V01-CS02",
			{
				{
					"2036684013374073670470642478097435082393965905216073159069132582313283074894808330704754509140183015844408257838394",
					"1442095344782436377607687657711937282361342321405422912347590889376773969332935605209326528060836557922932229521614",
				},
				{
					"712603160732423529538850938327197859251773848793464448294977148617985113767869616209273456982966659285651019780554",
					"3549454379036632156704729135192770954406411172309331582430747991672599371642148666322072960024366511631069032927782",
				},
			}
		},
		{
			"asdf",
			"BLS_SIG_BLS12381G2-SHA256-SSWU-RO-_POP_",
			{
				{
					"1184058645632270717238802026167521675640665254051621677891229161275546248273726163051942698406031256547695641333159",
					"2796840541941870488250990266864713579761728392052042558603386652320835698725612365412314296122895578014688997245820",
				},
				{
					"1432011693332698211658748968085869636612625272476301004513458304498234062483485462991424286092448663756703927705584",
					"3596297820733241889565943496970554637589864863833863117721478512486741539397910569381754340032782454436609027606827",
				},
			}
		},
	};
	for (size_t i = 0; i < CYBOZU_NUM_OF_ARRAY(tbl); i++) {
		const char *msg = tbl[i].msg;
		const char *dst = tbl[i].dst;
		const Fp2Str *expectStr = tbl[i].s;
		Fp2 out[2];
		mapto.hashToFp2v6(out, msg, strlen(msg), dst, strlen(dst));
		Fp2 expect[2];
		for (int i = 0; i < 2; i++) {
			set(expect[i], expectStr[i]);
			CYBOZU_TEST_EQUAL(out[i], expect[i]);
		}
		if (i == 0) {
			// from draft-irtf-cfrg-hash-to-curve/poc/vectors/BLS12381G2_XMD:SHA-256_SSWU_RO_.json.swp
			const Fp2Str xys[] = {
				{
					"0x0b6d276d0bfbddde617a9ab4c175b07c9c4aecad2cdd6cc9ca541b61334a69c58680ef5692bbad03d2f572838df32b66",
					"0x139e9d78ff6d9d163f979d14a64c5e57f82f1ef7e42ece338b571a9e92c0666f0f6bf1a5fc21e2d32bcb6432eab7037c",
				},
				{
					"0x022f9ee5d596d06c5f2f735c3c5f743978f79fd57bf7d4291e221227f490d3f276066de9f9edc89c57e048ef4cf0ef72",
					"0x14dd23517516a80d1d840e34f51dfb76946c7670fca0f36ad8ec9bde4ea82dfae119a21b076519bcc1c00152989a4d45",
				},
			};
			G2 P;
			mapto.opt_swu2_map(P, out[0], &out[1]);
			P.normalize();
			Fp2 t;
			set(t, xys[0]);
			CYBOZU_TEST_EQUAL(P.x, t);
			set(t, xys[1]);
			CYBOZU_TEST_EQUAL(P.y, t);
		}
	}
	bn::setMapToMode(MCL_MAP_TO_MODE_HASH_TO_CURVE_06);
	G2 P;
	mcl::bn::hashAndMapToG2(P, "asdf", 4);
	P.normalize();
	printf("P=%s %s\n", P.x.getStr(10).c_str(), P.y.getStr(10).c_str());
}

CYBOZU_TEST_AUTO(test)
{
	initPairing(mcl::BLS12_381);
	Fp::setETHserialization(true);
	bn::setMapToMode(MCL_MAP_TO_MODE_WB19);
	const MapTo& mapto = BN::param.mapTo.mapToG2_WB19_;
	py_eccTest(mapto);
	py_eccTest2(mapto);
	osswu2_helpTest(mapto);
	addTest(mapto);
	iso3Test(mapto);
	testSign(mapto);
	ethFp2ToG2test();
	testHMAC();
	testHashToFp2();
	ethMsgToG2test();
	testVec("../misc/mapto/fips_186_3_B233.txt");
	testVec("../misc/mapto/misc.txt");
	ethMsgToG2testAll("../bls_sigs_ref/test-vectors/hash_g2/");
	testHashToFp2v6(mapto);
}
