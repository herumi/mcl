using System;
using System.Linq;
using System.Security.Cryptography;

namespace mcl {
    using static MCL;
    class MCLTest {
        static int err = 0;
        static void assert(string msg, bool b)
        {
            if (b) return;
            Console.WriteLine("ERR {0}", msg);
            err++;
        }
        static void Main()
        {
            err = 0;
            try {
                Console.WriteLine("BN254");
                TestCurve(BN254);
                Console.WriteLine("BN_SNARK");
                TestCurve(BN_SNARK);
                Console.WriteLine("BLS12_381");
                TestCurve(BLS12_381);
                Console.WriteLine("BLS12_381 eth");
                ETHmode();
                TestETH();
                TestDFINITY();
                TestDRAND();
                if (err == 0) {
                    Console.WriteLine("all tests succeed");
                } else {
                    Console.WriteLine("err={0}", err);
                }
            } catch (Exception e) {
                Console.WriteLine("ERR={0}", e);
            }
        }

        static void TestCurve(int curveType)
        {
            Init(curveType);
            TestFr();
            TestFp();
            TestG1();
            TestG2();
            TestPairing();
            TestSS();
        }
        static void TestFr()
        {
            Console.WriteLine("TestFr");
            Fr x = new Fr();
            assert("x.isZero", x.IsZero());
            x.Clear();
            assert("0", x.GetStr(10) == "0");
            assert("0.IzZero", x.IsZero());
            assert("!0.IzOne", !x.IsOne());
            x.SetInt(1);
            assert("1", x.GetStr(10) == "1");
            assert("!1.IzZero", !x.IsZero());
            assert("1.IzOne", x.IsOne());
            x.SetInt(3);
            assert("3", x.GetStr(10) == "3");
            assert("!3.IzZero", !x.IsZero());
            assert("!3.IzOne", !x.IsOne());
            x.SetInt(-5);
            x = -x;
            assert("5", x.GetStr(10) == "5");
            x.SetInt(4);
            x = x * x;
            assert("16", x.GetStr(10) == "16");
            assert("10", x.GetStr(16) == "10");
            Fr y;
            y = x;
            assert("x == y", x.Equals(y));
            x.SetInt(123);
            assert("123", x.GetStr(10) == "123");
            assert("7b", x.GetStr(16) == "7b");
            assert("y != x", !x.Equals(y));
            Console.WriteLine("exception test");
            try {
                x.SetStr("1234567891234x", 10);
                Console.WriteLine("ERR ; not here");
            } catch (Exception e) {
                Console.WriteLine("OK ; expected exception: {0}", e);
            }
            x.SetStr("1234567891234", 10);
            assert("1234567891234", x.GetStr(10) == "1234567891234");
            {
                byte[] buf = x.Serialize();
                y.Deserialize(buf);
                assert("x == y", x.Equals(y));
            }
        }
        static void TestFp()
        {
            Console.WriteLine("TestFp");
            Fp x = new Fp();
            assert("x.isZero", x.IsZero());
            x.Clear();
            assert("0", x.GetStr(10) == "0");
            assert("0.IzZero", x.IsZero());
            assert("!0.IzOne", !x.IsOne());
            x.SetInt(1);
            assert("1", x.GetStr(10) == "1");
            assert("!1.IzZero", !x.IsZero());
            assert("1.IzOne", x.IsOne());
            x.SetInt(3);
            assert("3", x.GetStr(10) == "3");
            assert("!3.IzZero", !x.IsZero());
            assert("!3.IzOne", !x.IsOne());
            x.SetInt(-5);
            x = -x;
            assert("5", x.GetStr(10) == "5");
            x.SetInt(4);
            x = x * x;
            assert("16", x.GetStr(10) == "16");
            assert("10", x.GetStr(16) == "10");
            Fp y;
            y = x;
            assert("x == y", x.Equals(y));
            x.SetInt(123);
            assert("123", x.GetStr(10) == "123");
            assert("7b", x.GetStr(16) == "7b");
            assert("y != x", !x.Equals(y));
            Console.WriteLine("exception test");
            try {
                x.SetStr("1234567891234x", 10);
                Console.WriteLine("ERR ; not here");
            } catch (Exception e) {
                Console.WriteLine("OK ; expected exception: {0}", e);
            }
            x.SetStr("1234567891234", 10);
            assert("1234567891234", x.GetStr(10) == "1234567891234");
            {
                byte[] buf = x.Serialize();
                y.Deserialize(buf);
                assert("x == y", x.Equals(y));
            }
        }
        static void TestG1()
        {
            Console.WriteLine("TestG1");
            G1 P = new G1();
            assert("P.isZero", P.IsZero());
            P.Clear();
            assert("P.IsValid", P.IsValid());
            assert("P.IsZero", P.IsZero());
            P.HashAndMapTo("abc");
            assert("P.IsValid", P.IsValid());
            assert("!P.IsZero", !P.IsZero());
            G1 Q = new G1();
            Q = P;
            assert("P == Q", Q.Equals(P));
            Q.Neg(P);
            Q.Add(Q, P);
            assert("P = Q", Q.IsZero());
            Q.Dbl(P);
            G1 R = new G1();
            R.Add(P, P);
            assert("Q == R", Q.Equals(R));
            Fr x = new Fr();
            x.SetInt(3);
            R.Add(R, P);
            Q.Mul(P, x);
            assert("Q == R", Q.Equals(R));
            {
                byte[] buf = P.Serialize();
                Q.Clear();
                Q.Deserialize(buf);
                assert("P == Q", P.Equals(Q));
            }
            {
                const int n = 5;
                G1[] xVec = new G1[n];
                Fr[] yVec = new Fr[n];
                P.Clear();
                for (int i = 0; i < n; i++) {
                    xVec[i].HashAndMapTo(i.ToString());
                    yVec[i].SetByCSPRNG();
                    Q.Mul(xVec[i], yVec[i]);
                    P.Add(P, Q);
                }
                MulVec(ref Q, xVec, yVec);
                assert("mulVecG1", P.Equals(Q));
            }
            G1 W = G1.Zero();
            assert("W.IsZero", W.IsZero());
        }
        static void TestG2()
        {
            Console.WriteLine("TestG2");
            G2 P = new G2();
            assert("P.isZero", P.IsZero());
            P.Clear();
            assert("P is valid", P.IsValid());
            assert("P is zero", P.IsZero());
            P.HashAndMapTo("abc");
            assert("P is valid", P.IsValid());
            assert("P is not zero", !P.IsZero());
            G2 Q = new G2();
            Q = P;
            assert("P == Q", Q.Equals(P));
            Q.Neg(P);
            Q.Add(Q, P);
            assert("Q is zero", Q.IsZero());
            Q.Dbl(P);
            G2 R = new G2();
            R.Add(P, P);
            assert("Q == R", Q.Equals(R));
            Fr x = new Fr();
            x.SetInt(3);
            R.Add(R, P);
            Q.Mul(P, x);
            assert("Q == R", Q.Equals(R));
            {
                byte[] buf = P.Serialize();
                Q.Clear();
                Q.Deserialize(buf);
                assert("P == Q", P.Equals(Q));
            }
            {
                const int n = 5;
                G2[] xVec = new G2[n];
                Fr[] yVec = new Fr[n];
                P.Clear();
                for (int i = 0; i < n; i++) {
                    xVec[i].HashAndMapTo(i.ToString());
                    yVec[i].SetByCSPRNG();
                    Q.Mul(xVec[i], yVec[i]);
                    P.Add(P, Q);
                }
                MulVec(ref Q, xVec, yVec);
                assert("mulVecG2", P.Equals(Q));
            }
            G2 W = G2.Zero();
            assert("W.IsZero", W.IsZero());
        }
        static void TestPairing()
        {
            Console.WriteLine("TestG2");
            G1 P = new G1();
            P.HashAndMapTo("123");
            G2 Q = new G2();
            Q.HashAndMapTo("1");
            Fr a = new Fr();
            Fr b = new Fr();
            a.SetStr("12345678912345673453", 10);
            b.SetStr("230498230982394243424", 10);
            G1 aP = new G1();
            G2 bQ = new G2();
            aP.Mul(P, a);
            bQ.Mul(Q, b);
            GT e1 = new GT();
            GT e2 = new GT();
            GT e3 = new GT();
            e1.Pairing(P, Q);
            e2.Pairing(aP, Q);
            e3.Pow(e1, a);
            assert("e2.Equals(e3)", e2.Equals(e3));
            e2.Pairing(P, bQ);
            e3.Pow(e1, b);
            assert("e2.Equals(e3)", e2.Equals(e3));
            {
                byte[] buf = e1.Serialize();
                e2.Clear();
                e2.Deserialize(buf);
                assert("e1 == e2", e1.Equals(e2));
            }
        }
        static void TestETH_mapToG1()
        {
            var tbl = new[] {
                new {
                    msg = "asdf",
                    x = "a72df17570d0eb81260042edbea415ad49bdb94a1bc1ce9d1bf147d0d48268170764bb513a3b994d662e1faba137106",
                    y = "122b77eca1ed58795b7cd456576362f4f7bd7a572a29334b4817898a42414d31e9c0267f2dc481a4daf8bcf4a460322",
                },
           };
            G1 P = new G1();
            Fp x = new Fp();
            Fp y = new Fp();
            foreach (var v in tbl) {
                P.HashAndMapTo(v.msg);
                x.SetStr(v.x, 16);
                y.SetStr(v.y, 16);
                Normalize(ref P, P);
                Console.WriteLine("x={0}", P.x.GetStr(16));
                Console.WriteLine("y={0}", P.y.GetStr(16));
                assert("P.x", P.x.Equals(x));
                assert("P.y", P.y.Equals(y));
            }
        }
        static void TestETH()
        {
            TestETH_mapToG1();
        }
        static void TestSS_Fr()
        {
            const int n = 5;
            const int k = 3; // can't change because the following loop
            Fr[] cVec = new Fr[k];
            // init polynomial coefficient
            for (int i = 0; i < k; i++) {
                cVec[i].SetByCSPRNG();
            }

            Fr[] xVec = new Fr[n];
            Fr[] yVec = new Fr[n];
            // share cVec[0] with yVec[0], ..., yVec[n-1]
            for (int i = 0; i < n; i++) {
                xVec[i].SetHashOf(i.ToString());
                MCL.Share(ref yVec[i], cVec, xVec[i]);
            }
            // recover cVec[0] from xVecSubset and yVecSubset
            Fr[] xVecSubset = new Fr[k];
            Fr[] yVecSubset = new Fr[k];
            for (int i0 = 0; i0 < n; i0++) {
                xVecSubset[0] = xVec[i0];
                yVecSubset[0] = yVec[i0];
                for (int i1 = i0 + 1; i1 < n; i1++) {
                    xVecSubset[1] = xVec[i1];
                    yVecSubset[1] = yVec[i1];
                    for (int i2 = i1 + 1; i2 < n; i2++) {
                        xVecSubset[2] = xVec[i2];
                        yVecSubset[2] = yVec[i2];
                        Fr s = new Fr();
                        MCL.Recover(ref s, xVecSubset, yVecSubset);
                        assert("Recover", s.Equals(cVec[0]));
                    }
                }
            }
        }
        static void TestSS_G1()
        {
            const int n = 5;
            const int k = 3; // can't change because the following loop
            G1[] cVec = new G1[k];
            // init polynomial coefficient
            for (int i = 0; i < k; i++) {
                Fr x = new Fr();
                x.SetByCSPRNG();
                cVec[i].SetHashOf(x.GetStr(16));
            }

            Fr[] xVec = new Fr[n];
            G1[] yVec = new G1[n];
            // share cVec[0] with yVec[0], ..., yVec[n-1]
            for (int i = 0; i < n; i++) {
                xVec[i].SetHashOf(i.ToString());
                MCL.Share(ref yVec[i], cVec, xVec[i]);
            }
            // recover cVec[0] from xVecSubset and yVecSubset
            Fr[] xVecSubset = new Fr[k];
            G1[] yVecSubset = new G1[k];
            for (int i0 = 0; i0 < n; i0++) {
                xVecSubset[0] = xVec[i0];
                yVecSubset[0] = yVec[i0];
                for (int i1 = i0 + 1; i1 < n; i1++) {
                    xVecSubset[1] = xVec[i1];
                    yVecSubset[1] = yVec[i1];
                    for (int i2 = i1 + 1; i2 < n; i2++) {
                        xVecSubset[2] = xVec[i2];
                        yVecSubset[2] = yVec[i2];
                        G1 s = new G1();
                        MCL.Recover(ref s, xVecSubset, yVecSubset);
                        assert("Recover", s.Equals(cVec[0]));
                    }
                }
            }
        }
        static void TestSS_G2()
        {
            const int n = 5;
            const int k = 3; // can't change because the following loop
            G2[] cVec = new G2[k];
            // init polynomial coefficient
            for (int i = 0; i < k; i++) {
                Fr x = new Fr();
                x.SetByCSPRNG();
                cVec[i].SetHashOf(x.GetStr(16));
            }

            Fr[] xVec = new Fr[n];
            G2[] yVec = new G2[n];
            // share cVec[0] with yVec[0], ..., yVec[n-1]
            for (int i = 0; i < n; i++) {
                xVec[i].SetHashOf(i.ToString());
                MCL.Share(ref yVec[i], cVec, xVec[i]);
            }
            // recover cVec[0] from xVecSubset and yVecSubset
            Fr[] xVecSubset = new Fr[k];
            G2[] yVecSubset = new G2[k];
            for (int i0 = 0; i0 < n; i0++) {
                xVecSubset[0] = xVec[i0];
                yVecSubset[0] = yVec[i0];
                for (int i1 = i0 + 1; i1 < n; i1++) {
                    xVecSubset[1] = xVec[i1];
                    yVecSubset[1] = yVec[i1];
                    for (int i2 = i1 + 1; i2 < n; i2++) {
                        xVecSubset[2] = xVec[i2];
                        yVecSubset[2] = yVec[i2];
                        G2 s = new G2();
                        MCL.Recover(ref s, xVecSubset, yVecSubset);
                        assert("Recover", s.Equals(cVec[0]));
                    }
                }
            }
        }
        static void TestSS()
        {
            TestSS_Fr();
            TestSS_G1();
            TestSS_G2();
        }
        public static byte[] FromHexStr(string s)
        {
            if (s.Length % 2 == 1) {
                throw new ArgumentException("s.Length is odd." + s.Length);
            }
            int n = s.Length / 2;
            var buf = new byte[n];
            for (int i = 0; i < n; i++) {
                buf[i] = Convert.ToByte(s.Substring(i * 2, 2), 16);
            }
            return buf;
        }
        public static Boolean Verify(G2 gen, G2 pub, G1 sig, byte[] msg)
        {
            GT e1 = new GT();
            GT e2 = new GT();
            G1 g1 = new G1();
            g1.HashAndMapTo(msg);
            /*
                        e1.Pairing(g1, pub);
                        e2.Pairing(sig, gen);
                        return e1.Equals(e2);
            */
            e1.MillerLoop(g1, pub);
            e2.MillerLoop(sig, gen);
            e1.Inv(e1);
            e1.Mul(e1, e2);
            e1.FinalExp(e1);
            return e1.IsOne();
        }
        public static void TestDFINITY()
        {
            // This sample is how to use mcl. https://github.com/herumi/bls/tree/master/ffi/cs is better.
            Console.WriteLine("TestDFINITY");
            // it is alread called in Main
            // Init(BLS12_381);
            // ETHmode();
            G1setDst("BLS_SIG_BLS12381G1_XMD:SHA-256_SSWU_RO_NUL_");
            G2 gen = new G2();
            gen.SetStr("1 0x24aa2b2f08f0a91260805272dc51051c6e47ad4fa403b02b4510b647ae3d1770bac0326a805bbefd48056c8c121bdb8 0x13e02b6052719f607dacd3a088274f65596bd0d09920b61ab5da61bbdc7f5049334cf11213945d57e5ac7d055d042b7e 0x0ce5d527727d6e118cc9cdc6da2e351aadfd9baa8cbdd3a76d429a695160d12c923ac9cc3baca289e193548608b82801 0x0606c4a02ea734cc32acd2b02bc28b99cb3e287e85a763af267492ab572e99ab3f370d275cec1da1aaa9075ff05f79be", 16);


            // test of https://github.com/dfinity/agent-js/blob/5214dc1fc4b9b41f023a88b1228f04d2f2536987/packages/bls-verify/src/index.test.ts#L101
            String pubStr = "a7623a93cdb56c4d23d99c14216afaab3dfd6d4f9eb3db23d038280b6d5cb2caaee2a19dd92c9df7001dede23bf036bc0f33982dfb41e8fa9b8e96b5dc3e83d55ca4dd146c7eb2e8b6859cb5a5db815db86810b8d12cee1588b5dbf34a4dc9a5";
            String sigStr = "b89e13a212c830586eaa9ad53946cd968718ebecc27eda849d9232673dcd4f440e8b5df39bf14a88048c15e16cbcaabe";
            G2 pub = new G2();
            G1 sig = new G1();
            pub.Deserialize(FromHexStr(pubStr));
            sig.Deserialize(FromHexStr(sigStr));
            assert("verify", Verify(gen, pub, sig, System.Text.Encoding.ASCII.GetBytes("hello")));
            assert("verify", !Verify(gen, pub, sig, System.Text.Encoding.ASCII.GetBytes("hallo")));
        }
        public static Boolean Verify(G1 gen, G1 pub, G2 sig, byte[] msg)
        {
            GT e1 = new GT();
            GT e2 = new GT();
            G2 g2 = new G2();
            g2.HashAndMapTo(msg);
            if (false) {
                e1.Pairing(pub, g2);
                e2.Pairing(gen, sig);
                return e1.Equals(e2);
            } else {
                e1.MillerLoop(pub, g2);
                e2.MillerLoop(gen, sig);
                e1.Inv(e1);
                e1.Mul(e1, e2);
                e1.FinalExp(e1);
                return e1.IsOne();
            }
        }
        public static void PutByte(String msg, byte[] b)
        {
            Console.WriteLine("{0} = {1}", msg, BitConverter.ToString(b).Replace("-", " "));
        }
        public static void TestDRAND()
        {
            Console.WriteLine("TestDRAND");
            // it is alread called in Main
            // Init(BLS12_381);
            // ETHmode();
            // https://drand.love/docs/specification/#cryptographic-specification
            G2setDst("BLS_SIG_BLS12381G2_XMD:SHA-256_SSWU_RO_NUL_");
            G2 gen = new G2();
            // https://docs.rs/ark-bls12-381/latest/ark_bls12_381/g2/index.html
            gen.SetStr("1 0x24aa2b2f08f0a91260805272dc51051c6e47ad4fa403b02b4510b647ae3d1770bac0326a805bbefd48056c8c121bdb8 0x13e02b6052719f607dacd3a088274f65596bd0d09920b61ab5da61bbdc7f5049334cf11213945d57e5ac7d055d042b7e 0x0ce5d527727d6e118cc9cdc6da2e351aadfd9baa8cbdd3a76d429a695160d12c923ac9cc3baca289e193548608b82801 0x0606c4a02ea734cc32acd2b02bc28b99cb3e287e85a763af267492ab572e99ab3f370d275cec1da1aaa9075ff05f79be", 16);

            G2 pub = new G2();
            G1 sig = new G1();
            ulong round = 5928395;
            // https://api.drand.sh/52db9ba70e0cc0f6eaf7803dd07447a1f5477735fd3f661792ba94600c84e971/info
            String pubStr = "83cf0f2896adee7eb8b5f01fcad3912212c437e0073e911fb90022d3e760183c8c4b450b6a0a6c3ac6a5776a2d1064510d1fec758c921cc22b0e17e63aaf4bcb5ed66304de9cf809bd274ca73bab4af5a6e9c76a4bc09e76eae8991ef5ece45a";
            // https://api.drand.sh/52db9ba70e0cc0f6eaf7803dd07447a1f5477735fd3f661792ba94600c84e971/public/5928395
            String sigStr = "a5d07c0071b4e386b3ae09206522253c68fefe8490ad59ecc44a7dd0d0745be91da5779e2247a82403fbc0cb9a34cb61";

            pub.Deserialize(FromHexStr(pubStr));
            sig.Deserialize(FromHexStr(sigStr));
            // convert round to 8 bytes big endian
            byte[] roundByte = BitConverter.GetBytes(round).Reverse().ToArray();
            PutByte("round", roundByte);

            byte[] md = SHA256.Create().ComputeHash(roundByte);
            PutByte("md", md);
            assert("verify", Verify(gen, pub, sig, md));
            md[0]++;
            assert("not verify", !Verify(gen, pub, sig, md));
        }
    }
}
