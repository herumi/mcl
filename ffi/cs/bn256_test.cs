using System;

namespace mcl {
	using static BN256;
	class BN256Test {
		static int err = 0;
		static void assert(string msg, bool b)
		{
			if (b) return;
			Console.WriteLine("ERR {0}", msg);
			err++;
		}
		static void Main(string[] args)
		{
			try {
				assert("64bit system", System.Environment.Is64BitProcess);
				int ret;
				ret = BN256_init();
				assert("BN256_init", ret == 0);
				ret = BN256_setErrFile("bn256_test.txt");
				assert("BN256_setErrFile", ret == 0);
				TestFr();
				TestG1();
				TestG2();
				TestPairing();
				if (err == 0) {
					Console.WriteLine("all tests succeed");
				} else {
					Console.WriteLine("err={0}", err);
				}
			} catch (Exception e) {
				Console.WriteLine("ERR={0}", e);
			}
		}
		static void TestFr()
		{
			Console.WriteLine("TestFr");
			Fr x = new Fr();
			x.Clear();
			assert("0", x.ToString() == "0");
			assert("0.IzZero", x.IsZero());
			assert("!0.IzOne", !x.IsOne());
			x.SetInt(1);
			assert("1", x.ToString() == "1");
			assert("!1.IzZero", !x.IsZero());
			assert("1.IzOne", x.IsOne());
			x.SetInt(3);
			assert("3", x.ToString() == "3");
			assert("!3.IzZero", !x.IsZero());
			assert("!3.IzOne", !x.IsOne());
			x.SetInt(-5);
			x = -x;
			assert("5", x.ToString() == "5");
			x.SetInt(4);
			x = x * x;
			assert("16", x.ToString() == "16");
			Fr y;
			y = x.Clone();
			assert("x == y", x.Equals(y));
			x.SetInt(123);
			assert("123", x.ToString() == "123");
			assert("y != x", !x.Equals(y));
			try {
				x.SetStr("1234567891234x");
				Console.WriteLine("x = {0}", x);
			} catch (Exception e) {
				Console.WriteLine("exception test OK\n'{0}'", e);
			}
			x.SetStr("1234567891234");
			assert("1234567891234", x.ToString() == "1234567891234");
		}
		static void TestG1()
		{
			Console.WriteLine("TestG1");
			G1 P = new G1();
			P.Clear();
			assert("P = 0", P.ToString() == "0");
			assert("P.IsValid", P.IsValid());
			assert("P.IsZero", P.IsZero());
			P.HashAndMapTo("abc");
			assert("P.IsValid", P.IsValid());
			assert("!P.IsZero", !P.IsZero());
			G1 Q = new G1();
			Q = P.Clone();
			assert("P == Q", Q.Equals(P));
			G1.Neg(Q, P);
			G1.Add(Q, Q, P);
			assert("P = Q", Q.IsZero());
			G1.Dbl(Q, P);
			G1 R = new G1();
			G1.Add(R, P, P);
			assert("Q == R", Q.Equals(R));
			Fr x = new Fr();
			x.SetInt(3);
			G1.Add(R, R, P);
			G1.Mul(Q, P, x);
			assert("Q == R", Q.Equals(R));
		}
		static void TestG2()
		{
			Console.WriteLine("TestG2");
			G2 P = new G2();
			P.Clear();
			assert("P = 0", P.ToString() == "0");
			assert("P is valid", P.IsValid());
			assert("P is zero", P.IsZero());
			P.HashAndMapTo("abc");
			assert("P is valid", P.IsValid());
			assert("P is not zero", !P.IsZero());
			G2 Q = new G2();
			Q = P.Clone();
			assert("P == Q", Q.Equals(P));
			G2.Neg(Q, P);
			G2.Add(Q, Q, P);
			assert("Q is zero", Q.IsZero());
			G2.Dbl(Q, P);
			G2 R = new G2();
			G2.Add(R, P, P);
			assert("Q == R", Q.Equals(R));
			Fr x = new Fr();
			x.SetInt(3);
			G2.Add(R, R, P);
			G2.Mul(Q, P, x);
			assert("Q == R", Q.Equals(R));
		}
		static void TestPairing()
		{
			Console.WriteLine("TestG2");
			G1 P = new G1();
			P.setStr("1 -1 1");
			G2 Q = new G2();
			Q.HashAndMapTo("1");
			Fr a = new Fr();
			Fr b = new Fr();
			a.SetStr("12345678912345673453");
			b.SetStr("230498230982394243424");
			G1 aP = new G1();
			G2 bQ = new G2();
			G1.Mul(aP, P, a);
			G2.Mul(bQ, Q, b);
			GT e1 = new GT();
			GT e2 = new GT();
			GT e3 = new GT();
			Pairing(e1, P, Q);
			Pairing(e2, aP, Q);
			GT.Pow(e3, e1, a);
			assert("e2.Equals(e3)", e2.Equals(e3));
			Pairing(e2, P, bQ);
			GT.Pow(e3, e1, b);
			assert("e2.Equals(e3)", e2.Equals(e3));
		}
	}
}
