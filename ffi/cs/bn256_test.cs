using System;

namespace mcl {
	using static BN256;
	class BN256Test {
		static void Main(string[] args)
		{
			try {
				Console.WriteLine("64bit = {0}", System.Environment.Is64BitProcess);
				int ret;
				ret = BN256_init();
				Console.WriteLine("ret= {0}", ret);
				ret = BN256_setErrFile("c:/tmp/abc.txt");
				Console.WriteLine("ret= {0}", ret);
				TestFr();
				TestG1();
				TestG2();
				TestPairing();
			} catch (Exception e) {
				Console.WriteLine("ERR={0}", e);
			}
		}
		static void TestFr()
		{
			Console.WriteLine("TestFr");
			Fr x = new Fr();
			x.Clear();
			Console.WriteLine("x = {0}, isZero = {1}, isOne = {2}", x, x.IsZero(), x.IsOne());
			x.SetInt(1);
			Console.WriteLine("x = {0}, isZero = {1}, isOne = {2}", x, x.IsZero(), x.IsOne());
			x.SetInt(3);
			Console.WriteLine("x = {0}, isZero = {1}, isOne = {2}", x, x.IsZero(), x.IsOne());
			x.SetInt(-5);
			Console.WriteLine("x = {0}", x);
			x = -x;
			Console.WriteLine("x = {0}", x);
			x.SetInt(4);
			x = x * x;
			Console.WriteLine("x = {0}", x);
			Fr y;// = new Fr();
				 //			y = x;
			y = x.Clone();
			Console.WriteLine("y = {0}", y);
			Console.WriteLine("x == y {0}", x.Equals(y));
			x.SetInt(123);
			Console.WriteLine("y = {0}", y);
			Console.WriteLine("x == y {0}", x.Equals(y));
			try {
				x.SetStr("1234567891234x");
				Console.WriteLine("x = {0}", x);
			} catch (Exception e) {
				Console.WriteLine("exception test {0}", e);
			}
			x.SetStr("1234567891234");
			Console.WriteLine("x = {0}", x);
		}
		static void TestG1()
		{
			Console.WriteLine("TestG1");
			G1 P = new G1();
			P.Clear();
			Console.WriteLine("P = {0}", P);
			Console.WriteLine("P is valid {0}", P.IsValid());
			Console.WriteLine("P is zero {0}", P.IsZero());
			P.HashAndMapTo("abc");
			Console.WriteLine("P = {0}", P);
			Console.WriteLine("P is valid {0}", P.IsValid());
			Console.WriteLine("P is zero {0}", P.IsZero());
			G1 Q = new G1();
			G1.Neg(Q, P);
			Console.WriteLine("Q = {0}", Q);
			G1.Add(Q, Q, P);
			Console.WriteLine("Q = {0}", Q);
			G1.Dbl(Q, P);
			G1 R = new G1();
			G1.Add(R, P, P);
			Console.WriteLine("P == R {0}", P.Equals(P));
			Console.WriteLine("P == R {0}", P.Equals(R));
			Console.WriteLine("Q == R {0}", Q.Equals(R));
			Console.WriteLine("Q = {0}", Q);
			Console.WriteLine("R = {0}", R);
			Fr x = new Fr();
			x.SetInt(3);
			G1.Add(R, R, P);
			G1.Mul(Q, P, x);
			Console.WriteLine("Q == R {0}", Q.Equals(R));
		}
		static void TestG2()
		{
			Console.WriteLine("TestG2");
			G2 P = new G2();
			P.Clear();
			Console.WriteLine("P = {0}", P);
			Console.WriteLine("P is valid {0}", P.IsValid());
			Console.WriteLine("P is zero {0}", P.IsZero());
			P.HashAndMapTo("abc");
			Console.WriteLine("P = {0}", P);
			Console.WriteLine("P is valid {0}", P.IsValid());
			Console.WriteLine("P is zero {0}", P.IsZero());
			G2 Q = new G2();
			G2.Neg(Q, P);
			Console.WriteLine("Q = {0}", Q);
			G2.Add(Q, Q, P);
			Console.WriteLine("Q = {0}", Q);
			G2.Dbl(Q, P);
			G2 R = new G2();
			G2.Add(R, P, P);
			Console.WriteLine("P == R {0}", P.Equals(P));
			Console.WriteLine("P == R {0}", P.Equals(R));
			Console.WriteLine("Q == R {0}", Q.Equals(R));
			Console.WriteLine("Q = {0}", Q);
			Console.WriteLine("R = {0}", R);
			Fr x = new Fr();
			x.SetInt(3);
			G2.Add(R, R, P);
			G2.Mul(Q, P, x);
			Console.WriteLine("Q == R {0}", Q.Equals(R));
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
			Console.WriteLine("e2.Equals(e3) {0}", e2.Equals(e3));
			Pairing(e2, P, bQ);
			GT.Pow(e3, e1, b);
			Console.WriteLine("e2.Equals(e3) {0}", e2.Equals(e3));
		}
	}
}
