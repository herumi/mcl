#define PUT(x) std::cout << #x "=" << (x) << std::endl;
#include <cybozu/test.hpp>
#include <cybozu/sha2.hpp>
#include <mcl/bls12_381.hpp>
#include <iostream>
#include <fstream>
#include <cybozu/atoi.hpp>
#include <cybozu/file.hpp>
#include <cybozu/benchmark.hpp>

using namespace mcl;
using namespace mcl::bn;

typedef mcl::MapTo_WB19<Fp, G1, Fp2, G2> MapTo;
typedef MapTo::E2 E2;

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

template<class E2>
void set(E2& P, const PointStr& s)
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

/*
	z = sqrt(u/v) = (uv^7) (uv^15)^((p^2-9)/16) * root4
	return true if found
*/
bool sqr_div(const MapTo& mapto, Fp2& z, const Fp2& u, const Fp2& v)
{
	Fp2 gamma, t1, t2;
	Fp2::sqr(gamma, v); // v^2
	Fp2::sqr(t2, gamma); // v^4
	Fp2::mul(t1, u, v); // uv
	t1 *= gamma; // uv^3
	t1 *= t2; // uv^7
	Fp2::sqr(t2, t2); // v^8
	t2 *= t1;
	Fp2::pow(gamma, t2, mapto.sqrtConst);
	gamma *= t1;
	Fp2 candi;
	for (size_t i = 0; i < CYBOZU_NUM_OF_ARRAY(mapto.root4); i++) {
		Fp2::mul(candi, gamma, mapto.root4[i]);
		Fp2::sqr(t1, candi);
		t1 *= v;
		if (t1 == u) {
			z = candi;
			return true;
		}
	}
	z = gamma;
	return false;
}

// Proj
void py_ecc_iso_map_G2(const MapTo& mapto, G2& Q, const E2& P)
{
	Fp2 zpows[3];
	zpows[0] = P.z;
	Fp2::sqr(zpows[1], zpows[0]);
	Fp2::mul(zpows[2], zpows[1], zpows[0]);
	Fp2 mapvals[4];
	mapto.evalPoly(mapvals[0], P.x, zpows, mapto.xnum);
	mapto.evalPoly(mapvals[1], P.x, zpows, mapto.xden);
	mapto.evalPoly(mapvals[2], P.x, zpows, mapto.ynum);
	mapto.evalPoly(mapvals[3], P.x, zpows, mapto.yden);
	mapvals[1] *= P.z;
	mapvals[2] *= P.y;
	mapvals[3] *= P.z;
	Fp2::mul(Q.z, mapvals[1], mapvals[3]);
	Fp2::mul(Q.x, mapvals[0], mapvals[3]);
	Fp2::mul(Q.y, mapvals[1], mapvals[2]);
}

// https://github.com/ethereum/py_ecc
void py_ecc_optimized_swu_G2(const MapTo& mapto, E2& P, const Fp2& t)
{
	Fp2 t2, t2xi, t2xi2;
	Fp2::sqr(t2, t);
	mapto.mul_xi(t2xi, t2);
	Fp2::sqr(t2xi2, t2xi);
	Fp2 nume, deno;
	// (t^2 * xi)^2 + (t^2 * xi)
	Fp2::add(deno, t2xi2, t2xi);
	Fp2::add(nume, deno, 1);
	nume *= mapto.g2B;
	if (deno.isZero()) {
		mapto.mul_xi(deno, mapto.g2A);
	} else {
		deno *= -mapto.g2A;
	}
	Fp2 u, v;
	{
		Fp2 deno2, tmp, tmp1, tmp2;
		Fp2::sqr(deno2, deno);
		Fp2::mul(v, deno2, deno);

		Fp2::mul(u, mapto.g2B, v);
		Fp2::mul(tmp, mapto.g2A, nume);
		tmp *= deno2;
		u += tmp;
		Fp2::sqr(tmp, nume);
		tmp *= nume;
		u += tmp;
	}
	Fp2 candi;
	bool success = sqr_div(mapto, candi, u, v);
	P.y = candi;
	candi *= t2;
	candi *= t;
	u *= t2xi2;
	u *= t2xi;
	bool success2 = false;
	for (size_t i = 0; i < CYBOZU_NUM_OF_ARRAY(mapto.etas); i++) {
		Fp2 t1;
		Fp2::mul(t1, mapto.etas[i], candi);
		Fp2::sqr(t2, t1);
		t2 *= v;
		if (t2 == u && !success && !success2) {
			P.y = t1;
			success2 = true;
		}
	}
	assert(success || success2);
	if (!success) {
		nume *= t2xi;
	}
	if (mapto.isNegSign(t) != mapto.isNegSign(P.y)) {
		Fp2::neg(P.y, P.y);
	}
	P.y *= deno;
	P.x = nume;
	P.z = deno;
}
// Proj
void py_ecc_map_to_curve_G2(const MapTo& mapto, G2& out, const Fp2& t)
{
	E2 P;
	py_ecc_optimized_swu_G2(mapto, P, t);
	py_ecc_iso_map_G2(mapto, out, P);
}
/*
	in : Proj [X:Y:Z]
	out : Jacobi [A:B:C]
	[X:Y:Z] as Proj
	= (X/Z, Y/Z) as Affine
	= [X/Z:Y/Z:1] as Jacobi
	= [XZ:YZ^2:Z] as Jacobi
*/
void toJacobi(G2& out, const G2& in)
{
	Fp2 z2;
	Fp2::sqr(z2, in.z);
	Fp2::mul(out.x, in.x, in.z);
	Fp2::mul(out.y, in.y, z2);
	out.z = in.z;
}

void py_ecc_hash_to_G2(const MapTo& mapto, G2& out, const void *msg, size_t msgSize, const void *dst, size_t dstSize)
{
	Fp2 t1, t2;
	hashToFp2old(t1, msg, msgSize, 0, dst, dstSize);
	hashToFp2old(t2, msg, msgSize, 1, dst, dstSize);
	G2 P1, P2;
	py_ecc_map_to_curve_G2(mapto, P1, t1);
	py_ecc_map_to_curve_G2(mapto, P2, t2);
	toJacobi(P1, P1);
	toJacobi(P2, P2);
	P1 += P2;
	mapto.clear_h2(out, P1);
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
		py_ecc_map_to_curve_G2(mapto, P1, t1);
		py_ecc_map_to_curve_G2(mapto, P2, t2);
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
		toJacobi(P1, P1);
		toJacobi(P2, P2);
		P1 += P2;
		G2 P11;
		set(P11, ss);
		toJacobi(P11, P11);
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
		toJacobi(P11, P11);
		CYBOZU_TEST_EQUAL(P1, P11);
		py_ecc_hash_to_G2(mapto, P1, msg, msgSize, dst, dstSize);
		CYBOZU_BENCH_C("py_ecc_hash_to_G2", 1000, py_ecc_hash_to_G2, mapto, P1, msg, msgSize, dst, dstSize);
		CYBOZU_TEST_EQUAL(P1, P11);
		ethMsgToG2(P1, msg, msgSize, dst, dstSize);
		CYBOZU_TEST_EQUAL(P1, P11);
		set(P11, sigs);
		toJacobi(P11, P11);
		P1 *= sec;
		CYBOZU_TEST_EQUAL(P1, P11);
		CYBOZU_TEST_EQUAL(P1.serializeToHexStr(), expect);
	}
}

template<class T>
void testSign(const T& mapto)
{
	Fp H = -1;
	H /= 2;
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
		E2 P;
		set(t, tbl[i].t);
		set(x, tbl[i].x);
		set(y, tbl[i].y);
		set(z, tbl[i].z);
		mapto.osswu2_help(P, t);
		CYBOZU_TEST_EQUAL(P.x, x);
		CYBOZU_TEST_EQUAL(P.y, y);
		CYBOZU_TEST_EQUAL(P.z, z);
//		CYBOZU_TEST_ASSERT(P.isValid());
	}
}

void addTest()
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
		E2 P, Q, R;
		set(P, tbl[i].P);
		set(Q, tbl[i].Q);
		set(R, tbl[i].R);
		E2 E;
		ec::addJacobi(E, P, Q);
		CYBOZU_TEST_ASSERT(R.isEqual(E));
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
	typename T::E2 P;
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
	E2 p, q;
	py_ecc_optimized_swu_G2(mapto, p, t);
	set(q, out1s);
	CYBOZU_TEST_EQUAL(p.x, q.x);
	CYBOZU_TEST_EQUAL(p.y, q.y);
	CYBOZU_TEST_EQUAL(p.z, q.z);
	G2 P, Q;
	set(P, out2s);
	py_ecc_map_to_curve_G2(mapto, Q, t);
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
		mapto.hashToFp2(out, msg, strlen(msg), dst, strlen(dst));
		Fp2 expect[2];
		for (int j = 0; j < 2; j++) {
			set(expect[j], expectStr[j]);
			CYBOZU_TEST_EQUAL(out[j], expect[j]);
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
	G2 P;
	mcl::bn::hashAndMapToG2(P, "asdf", 4);
	CYBOZU_BENCH_C("draft06 hashAndMapToG2", 1000, mcl::bn::hashAndMapToG2, P, "asdf", 4);
	P.normalize();
//	printf("P=%s %s\n", P.x.getStr(10).c_str(), P.y.getStr(10).c_str());
}

template<class T>
void testHashToFp2v7(const T& mapto)
{
	{
		const char *msg = "asdf";
		PointStr s = {
			{
				"2525875563870715639912451285996878827057943937903727288399283574780255586622124951113038778168766058972461529282986",
				"3132482115871619853374334004070359337604487429071253737901486558733107203612153024147084489564256619439711974285977",
			},
			{
				"2106640002084734620850657217129389007976098691731730501862206029008913488613958311385644530040820978748080676977912",
				"2882649322619140307052211460282445786973517746532934590265600680988689024512167659295505342688129634612479405019290",
			},
			{
				"1",
				"0",
			}
		};
		G2 P1, P2;
		mapto.msgToG2(P1, msg, strlen(msg));
		set(P2, s);
		CYBOZU_TEST_EQUAL(P1, P2);
	}
	{
		char msg[] = "asdf";
		char dst[] = "BLS_SIG_BLS12381G2_XMD:SHA-256_SSWU_RO_POP_";
		/*
			https://github.com:cfrg/draft-irtf-cfrg-hash-to-curve
			tag: draft-irtf-cfrg-hash-to-curve-07
			the return value of expand_message_xmd in hash_to_field.py
		*/
		char expect[] = "ca53fcd6f140590d19138f38819eb13330c014a1670e40f0f8e991de7b35e21a1fca52a14486c8e8acc9d865718cd41fe3638c2fb50fdc75b95690dc58f86494005fb37fc330366a7fef5f6e26bb631f4a5462affab2b9a9630c3b1c63621875baf782dd435500fda05ba7a9e86a766eeffe259128dc6e43c1852c58034856c4c4e2158c3414a881c17b727be5400432bf5c0cd02066a3b763e25e3ca32f19ca69a807bbc14c7c8c7988915fb1df523c536f744aa8b9bd0bbcea9800a236355690a4765491cd8969ca2f8cac8b021d97306e6ce6a2126b2868cf57f59f5fc416385bc1c2ae396c62608adc6b9174bbdb981a4601c3bd81bbe086e385d9a909aa";
		size_t msgSize = strlen(msg);
		size_t dstSize = strlen(dst);
		uint8_t md[256];
		mcl::fp::expand_message_xmd(md, sizeof(md), msg, msgSize, dst, dstSize);
		CYBOZU_TEST_EQUAL(toHexStr(md, sizeof(md)), expect);
	}
	{
		char msg[] = "asdf";
		char dst[] = "QUUX-V01-CS02-with-BLS12381G1_XMD:SHA-256_SSWU_RO_";
		char expect[] = "ecc25edef8f6b277e27a88cf5ca0cdd4c4a49e8ba273d6069a4f0c9db05d37b78e700a875f4bb5972bfce49a867172ec1cb8c5524b1853994bb8af52a8ad2338d2cf688cf788b732372c10013445cd2c16a08a462028ae8ffff3082c8e47e8437dee5a58801e03ee8320980ae7c071ab022473231789d543d56defe9ff53bdba";
		size_t msgSize = strlen(msg);
		size_t dstSize = strlen(dst);
		uint8_t md[128];
		mcl::fp::expand_message_xmd(md, sizeof(md), msg, msgSize, dst, dstSize);
		CYBOZU_TEST_EQUAL(toHexStr(md, sizeof(md)), expect);
	}
	{
		const struct {
			const char *msg;
			const char *dst;
			Fp2Str x;
			Fp2Str y;
		} tbl[] = {
			// https://datatracker.ietf.org/doc/html/draft-irtf-cfrg-hash-to-curve-07#appendix-G.10.1
			{
				"", // msg
				"BLS12381G2_XMD:SHA-256_SSWU_RO_TESTGEN",
				{ // P.x
					"0x0a650bd36ae7455cb3fe5d8bb1310594551456f5c6593aec9ee0c03d2f6cb693bd2c5e99d4e23cbaec767609314f51d3",
					"0x0fbdae26f9f9586a46d4b0b70390d09064ef2afe5c99348438a3c7d9756471e015cb534204c1b6824617a85024c772dc",
				},
				{ // P.y
					"0x0d8d49e7737d8f9fc5cef7c4b8817633103faf2613016cb86a1f3fc29968fe2413e232d9208d2d74a89bf7a48ac36f83",
					"0x02e5cf8f9b7348428cc9e66b9a9b36fe45ba0b0a146290c3a68d92895b1af0e1f2d9f889fb412670ae8478d8abd4c5aa",
				}
			},
			{
				"abc",
				"BLS12381G2_XMD:SHA-256_SSWU_RO_TESTGEN",
				{
					"0x1953ce6d4267939c7360756d9cca8eb34aac4633ef35369a7dc249445069888e7d1b3f9d2e75fbd468fbcbba7110ea02",
					"0x03578447618463deb106b60e609c6f7cc446dc6035f84a72801ba17c94cd800583b493b948eff0033f09086fdd7f6175",
				},
				{
					"0x0882ab045b8fe4d7d557ebb59a63a35ac9f3d312581b509af0f8eaa2960cbc5e1e36bb969b6e22980b5cbdd0787fcf4e",
					"0x0184d26779ae9d4670aca9b267dbd4d3b30443ad05b8546d36a195686e1ccc3a59194aea05ed5bce7c3144a29ec047c4",
				},
			},
			{
				"abcdef0123456789",
				"BLS12381G2_XMD:SHA-256_SSWU_RO_TESTGEN",
				{
					"0x17b461fc3b96a30c2408958cbfa5f5927b6063a8ad199d5ebf2d7cdeffa9c20c85487204804fab53f950b2f87db365aa",
					"0x195fad48982e186ce3c5c82133aefc9b26d55979b6f530992a8849d4263ec5d57f7a181553c8799bcc83da44847bdc8d",
				},
				{
					"0x174a3473a3af2d0302b9065e895ca4adba4ece6ce0b41148ba597001abb152f852dd9a96fb45c9de0a43d944746f833e",
					"0x005cdf3d984e3391e7e969276fb4bc02323c5924a4449af167030d855acc2600cf3d4fab025432c6d868c79571a95bef",
				},
			},
			{
				"a512_aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa",
				"BLS12381G2_XMD:SHA-256_SSWU_RO_TESTGEN",
				{
					"0x0a162306f3b0f2bb326f0c4fb0e1fea020019c3af796dcd1d7264f50ddae94cacf3cade74603834d44b9ab3d5d0a6c98",
					"0x123b6bd9feeba26dd4ad00f8bfda2718c9700dc093ea5287d7711844644eb981848316d3f3f57d5d3a652c6cdc816aca",
				},
				{
					"0x15c1d4f1a685bb63ee67ca1fd96155e3d091e852a684b78d085fd34f6091e5249ddddbdcf2e7ec82ce6c04c63647eeb7",
					"0x05483f3b96d9252dd4fc0868344dfaf3c9d145e3387db23fa8e449304fab6a7b6ec9c15f05c0a1ea66ff0efcc03e001a",
				},
			},
			// https://www.ietf.org/id/draft-irtf-cfrg-hash-to-curve-08.html#name-bls12381g2_xmdsha-256_sswu_
			{
				"", // msg
				"QUUX-V01-CS02-with-BLS12381G2_XMD:SHA-256_SSWU_RO_",
				{ // P.x
					"0x0141ebfbdca40eb85b87142e130ab689c673cf60f1a3e98d69335266f30d9b8d4ac44c1038e9dcdd5393faf5c41fb78a",
					"0x05cb8437535e20ecffaef7752baddf98034139c38452458baeefab379ba13dff5bf5dd71b72418717047f5b0f37da03d",
				},
				{ // P.y
					"0x0503921d7f6a12805e72940b963c0cf3471c7b2a524950ca195d11062ee75ec076daf2d4bc358c4b190c0c98064fdd92",
					"0x12424ac32561493f3fe3c260708a12b7c620e7be00099a974e259ddc7d1f6395c3c811cdd19f1e8dbf3e9ecfdcbab8d6",
				}
			},
		};
		for (size_t i = 0; i < CYBOZU_NUM_OF_ARRAY(tbl); i++) {
			const char *msg = tbl[i].msg;
			size_t msgSize = strlen(msg);
			const char *dst = tbl[i].dst;
			size_t dstSize = strlen(dst);
			G2 P1, P2;
			set(P1.x, tbl[i].x);
			set(P1.y, tbl[i].y);
			P1.z = 1;
			mapto.map2curve_osswu2(P2, msg, msgSize, dst, dstSize);
			CYBOZU_TEST_EQUAL(P1, P2);
		}
		{
			G2 P;
			mcl::bn::hashAndMapToG2(P, "asdf", 4);
			CYBOZU_BENCH_C("draft07 hashAndMapToG2", 1000, mcl::bn::hashAndMapToG2, P, "asdf", 4);
			P.normalize();
			printf("P=%s %s\n", P.x.getStr(10).c_str(), P.y.getStr(10).c_str());
		}
	}
}

void testEth2phase0()
{
	const struct {
		const char *sec;
		const char *msg;
		const char *out;
	} tbl[] = {
		{
			"328388aff0d4a5b7dc9205abd374e7e98f3cd9f3418edb4eafda5fb16473d216",
			"abababababababababababababababababababababababababababababababab",
			"ae82747ddeefe4fd64cf9cedb9b04ae3e8a43420cd255e3c7cd06a8d88b7c7f8638543719981c5d16fa3527c468c25f0026704a6951bde891360c7e8d12ddee0559004ccdbe6046b55bae1b257ee97f7cdb955773d7cf29adf3ccbb9975e4eb9",
		},
		{
			"47b8192d77bf871b62e87859d653922725724a5c031afeabc60bcef5ff665138",
			"abababababababababababababababababababababababababababababababab",
			"9674e2228034527f4c083206032b020310face156d4a4685e2fcaec2f6f3665aa635d90347b6ce124eb879266b1e801d185de36a0a289b85e9039662634f2eea1e02e670bc7ab849d006a70b2f93b84597558a05b879c8d445f387a5d5b653df",
		},
		{
			"328388aff0d4a5b7dc9205abd374e7e98f3cd9f3418edb4eafda5fb16473d216",
			"5656565656565656565656565656565656565656565656565656565656565656",
			"a4efa926610b8bd1c8330c918b7a5e9bf374e53435ef8b7ec186abf62e1b1f65aeaaeb365677ac1d1172a1f5b44b4e6d022c252c58486c0a759fbdc7de15a756acc4d343064035667a594b4c2a6f0b0b421975977f297dba63ee2f63ffe47bb6",
		},
		{
			"47b8192d77bf871b62e87859d653922725724a5c031afeabc60bcef5ff665138",
			"5656565656565656565656565656565656565656565656565656565656565656",
			"af1390c3c47acdb37131a51216da683c509fce0e954328a59f93aebda7e4ff974ba208d9a4a2a2389f892a9d418d618418dd7f7a6bc7aa0da999a9d3a5b815bc085e14fd001f6a1948768a3f4afefc8b8240dda329f984cb345c6363272ba4fe",
		},
		{
			"263dbd792f5b1be47ed85f8938c0f29586af0d3ac7b977f21c278fe1462040e3",
			"0000000000000000000000000000000000000000000000000000000000000000",
			"b6ed936746e01f8ecf281f020953fbf1f01debd5657c4a383940b020b26507f6076334f91e2366c96e9ab279fb5158090352ea1c5b0c9274504f4f0e7053af24802e51e4568d164fe986834f41e55c8e850ce1f98458c0cfc9ab380b55285a55",
		},
		{
			"47b8192d77bf871b62e87859d653922725724a5c031afeabc60bcef5ff665138",
			"0000000000000000000000000000000000000000000000000000000000000000",
			"b23c46be3a001c63ca711f87a005c200cc550b9429d5f4eb38d74322144f1b63926da3388979e5321012fb1a0526bcd100b5ef5fe72628ce4cd5e904aeaa3279527843fae5ca9ca675f4f51ed8f83bbf7155da9ecc9663100a885d5dc6df96d9",
		},
		{
			"328388aff0d4a5b7dc9205abd374e7e98f3cd9f3418edb4eafda5fb16473d216",
			"0000000000000000000000000000000000000000000000000000000000000000",
			"948a7cb99f76d616c2c564ce9bf4a519f1bea6b0a624a02276443c245854219fabb8d4ce061d255af5330b078d5380681751aa7053da2c98bae898edc218c75f07e24d8802a17cd1f6833b71e58f5eb5b94208b4d0bb3848cecb075ea21be115",
		},
		{
			"263dbd792f5b1be47ed85f8938c0f29586af0d3ac7b977f21c278fe1462040e3",
			"abababababababababababababababababababababababababababababababab",
			"91347bccf740d859038fcdcaf233eeceb2a436bcaaee9b2aa3bfb70efe29dfb2677562ccbea1c8e061fb9971b0753c240622fab78489ce96768259fc01360346da5b9f579e5da0d941e4c6ba18a0e64906082375394f337fa1af2b7127b0d121",
		},
		{
			"263dbd792f5b1be47ed85f8938c0f29586af0d3ac7b977f21c278fe1462040e3",
			"5656565656565656565656565656565656565656565656565656565656565656",
			"882730e5d03f6b42c3abc26d3372625034e1d871b65a8a6b900a56dae22da98abbe1b68f85e49fe7652a55ec3d0591c20767677e33e5cbb1207315c41a9ac03be39c2e7668edc043d6cb1d9fd93033caa8a1c5b0e84bedaeb6c64972503a43eb",
		},
	};
	for (size_t i = 0; i < CYBOZU_NUM_OF_ARRAY(tbl); i++) {
		const Uint8Vec msg = fromHexStr(tbl[i].msg);
		const Uint8Vec out = fromHexStr(tbl[i].out);
		Fr r;
		r.setStr(tbl[i].sec, 16);
		G2 P;
		mcl::bn::hashAndMapToG2(P, msg.data(), msg.size());
		P *= r;
		P.normalize();
		uint8_t buf[256];
		size_t n = P.serialize(buf, sizeof(buf));
		CYBOZU_TEST_EQUAL_ARRAY(out.data(), buf, n);
	}
}

template<class T>
void testSswuG1(const T& mapto)
{
	const struct {
		const char *u;
		const char *xn;
		const char *xd;
		const char *y;
	} tbl[] = {
		{
			"0",
			"2906670324641927570491258158026293881577086121416628140204402091718288198173574630967936031029026176254968826637280",
			"134093699507829814821517650980559345626771735832728306571853989028117161444712301203928819168120125800913069360447",
			"883926319761702754759909536142450234040420493353017578303105057331414514426056372828799438842649753623273850162620",
		},
		{
			"1",
			"1899737305729263819017890260937734483867440857300594896394519620134021106669873067956151260450660652775675911846846",
			"2393285161127709615559578013969192009035621989946268206469810267786625713154290249995541799111574154426937440234423",
			"930707443353688021592152842018127582116075842630002779852379799673382026358889394936840703051493045692645732041175",
		},
		{
			"2445954111132780748727614926881625117054159133000189976501123519233969822355358926084559381412726536178576396564099",
			"1380948948858039589493865757655255282539355225819860723137103295095584615993188368169864518071716731687572756871254",
			"3943815976847699234459109633672806041428347164453405394564656059649800794974863796342327007702642595444543195342842",
			"2822129059347872230939996033946474192520362213555773694753196763199812747558444338256205967106315253391997542043187",
		},
	};
	for (size_t i = 0; i < CYBOZU_NUM_OF_ARRAY(tbl); i++) {
		Fp u;
		u.setStr(tbl[i].u);
		Fp xn, xd, y;
		mapto.sswuG1(xn, xd, y, u);
		CYBOZU_TEST_EQUAL(xn.getStr(), tbl[i].xn);
		CYBOZU_TEST_EQUAL(xd.getStr(), tbl[i].xd);
		CYBOZU_TEST_EQUAL(y.getStr(), tbl[i].y);
	}
}

template<class T>
void testMsgToG1(const T& mapto)
{
	const struct {
		const char *msg;
		const char *x;
		const char *y;
		const char *z;
	} tbl[] = {
		{
			"asdf",
			"14f99d14fa81bad3cc6232c0dee394235fb61287be4a262085604684a20790fbc7954ae6b2d545f05f967c9f624a116a",
			"acfaebe113b047b38d8eb3a37bbdf77ed0d392289f642e6e7b1611305ae537fa0a574a8235042672b49f44f54d00646",
			"1",
		},
	};
	for (size_t i = 0; i < CYBOZU_NUM_OF_ARRAY(tbl); i++) {
		const char *msg = tbl[i].msg;
		const size_t msgSize = strlen(msg);
		G1 P, Q;
		mapto.msgToG1(P, msg, msgSize);
		Q.x.setStr(tbl[i].x, 16);
		Q.y.setStr(tbl[i].y, 16);
		Q.z.setStr(tbl[i].z, 16);
		CYBOZU_TEST_EQUAL(P, Q);
	}
}

CYBOZU_TEST_AUTO(test)
{
	initPairing(mcl::BLS12_381);
	Fp::setETHserialization(true);
	bn::setMapToMode(MCL_MAP_TO_MODE_WB19);
	const MapTo& mapto = BN::param.mapTo.mapTo_WB19_;
	py_eccTest(mapto);
	py_eccTest2(mapto);
	osswu2_helpTest(mapto);
	addTest();
	iso3Test(mapto);
	testSign(mapto);
	ethFp2ToG2test();
	testHMAC();
	testHashToFp2();
	ethMsgToG2test();
	testVec("../misc/mapto/fips_186_3_B233.txt");
	testVec("../misc/mapto/misc.txt");
	ethMsgToG2testAll("../bls_sigs_ref/test-vectors/hash_g2/");
	bn::setMapToMode(MCL_MAP_TO_MODE_HASH_TO_CURVE_06);
	testHashToFp2v6(mapto);
	bn::setMapToMode(MCL_MAP_TO_MODE_HASH_TO_CURVE_07);
	testHashToFp2v7(mapto);
	testEth2phase0();
	testSswuG1(mapto);
	testMsgToG1(mapto);
}
