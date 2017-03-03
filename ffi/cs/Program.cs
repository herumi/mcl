using System;
using System.Text;
using System.Runtime.InteropServices;

namespace bn256 {
	class X {
		[DllImport("bn256_if.dll")] public static extern int BN256_setErrFile([In][MarshalAs(UnmanagedType.LPStr)] string name);
		[DllImport("bn256_if.dll")] public static extern int BN256_init();
		[DllImport("bn256_if.dll")] public static extern void BN256_Fr_clear([Out] Fr x);
		[DllImport("bn256_if.dll")] public static extern void BN256_Fr_setInt([Out] Fr y, int x);
		[DllImport("bn256_if.dll")] public static extern int BN256_Fr_setStr([Out] Fr x, [In][MarshalAs(UnmanagedType.LPStr)] string s);
		[DllImport("bn256_if.dll")] public static extern int BN256_Fr_isValid([In] Fr x);
		[DllImport("bn256_if.dll")] public static extern int BN256_Fr_isSame([In] Fr x, [In] Fr y);
		[DllImport("bn256_if.dll")] public static extern int BN256_Fr_isZero([In] Fr x);
		[DllImport("bn256_if.dll")] public static extern int BN256_Fr_isOne([In] Fr x);
		[DllImport("bn256_if.dll")] public static extern void BN256_Fr_setRand([Out] Fr x);

		[DllImport("bn256_if.dll")] public static extern void BN256_Fr_setMsg([Out] Fr x, [In][MarshalAs(UnmanagedType.LPStr)] string s);
		[DllImport("bn256_if.dll")] public static extern int BN256_Fr_getStr([Out]StringBuilder buf, long maxBufSize, [In] Fr x);

		[DllImport("bn256_if.dll")] public static extern void BN256_Fr_neg([Out] Fr y, [In] Fr x);
		[DllImport("bn256_if.dll")] public static extern void BN256_Fr_inv([Out] Fr y, [In] Fr x);
		[DllImport("bn256_if.dll")] public static extern void BN256_Fr_add([Out] Fr z, [In] Fr x, [In] Fr y);
		[DllImport("bn256_if.dll")] public static extern void BN256_Fr_sub([Out] Fr z, [In] Fr x, [In] Fr y);
		[DllImport("bn256_if.dll")] public static extern void BN256_Fr_mul([Out] Fr z, [In] Fr x, [In] Fr y);
		[DllImport("bn256_if.dll")] public static extern void BN256_Fr_div([Out] Fr z, [In] Fr x, [In] Fr y);

		[DllImport("bn256_if.dll")] public static extern void BN256_G1_clear([Out] G1 x);
		[DllImport("bn256_if.dll")] public static extern int BN256_G1_setStr([Out] G1 x, [In][MarshalAs(UnmanagedType.LPStr)] string s);
		[DllImport("bn256_if.dll")] public static extern int BN256_G1_isValid([In] G1 x);
		[DllImport("bn256_if.dll")] public static extern int BN256_G1_isSame([In] G1 x, [In] G1 y);
		[DllImport("bn256_if.dll")] public static extern int BN256_G1_isZero([In] G1 x);
		[DllImport("bn256_if.dll")] public static extern int BN256_G1_hashAndMapTo([Out] G1 x, [In][MarshalAs(UnmanagedType.LPStr)] string s);
		[DllImport("bn256_if.dll")] public static extern int BN256_G1_getStr([Out]StringBuilder buf, long maxBufSize, [In] G1 x);
		[DllImport("bn256_if.dll")] public static extern void BN256_G1_neg([Out] G1 y, [In] G1 x);
		[DllImport("bn256_if.dll")] public static extern void BN256_G1_dbl([Out] G1 y, [In] G1 x);
		[DllImport("bn256_if.dll")] public static extern void BN256_G1_add([Out] G1 z, [In] G1 x, [In] G1 y);
		[DllImport("bn256_if.dll")] public static extern void BN256_G1_sub([Out] G1 z, [In] G1 x, [In] G1 y);
		[DllImport("bn256_if.dll")] public static extern void BN256_G1_mul([Out] G1 z, [In] G1 x, [In] Fr y);

		[DllImport("bn256_if.dll")] public static extern void BN256_G2_clear([Out] G2 x);
		[DllImport("bn256_if.dll")] public static extern int BN256_G2_setStr([Out] G2 x, [In][MarshalAs(UnmanagedType.LPStr)] string s);
		[DllImport("bn256_if.dll")] public static extern int BN256_G2_isValid([In] G2 x);
		[DllImport("bn256_if.dll")] public static extern int BN256_G2_isSame([In] G2 x, [In] G2 y);
		[DllImport("bn256_if.dll")] public static extern int BN256_G2_isZero([In] G2 x);
		[DllImport("bn256_if.dll")] public static extern int BN256_G2_hashAndMapTo([Out] G2 x, [In][MarshalAs(UnmanagedType.LPStr)] string s);
		[DllImport("bn256_if.dll")] public static extern int BN256_G2_getStr([Out]StringBuilder buf, long maxBufSize, [In] G2 x);
		[DllImport("bn256_if.dll")] public static extern void BN256_G2_neg([Out] G2 y, [In] G2 x);
		[DllImport("bn256_if.dll")] public static extern void BN256_G2_dbl([Out] G2 y, [In] G2 x);
		[DllImport("bn256_if.dll")] public static extern void BN256_G2_add([Out] G2 z, [In] G2 x, [In] G2 y);
		[DllImport("bn256_if.dll")] public static extern void BN256_G2_sub([Out] G2 z, [In] G2 x, [In] G2 y);
		[DllImport("bn256_if.dll")] public static extern void BN256_G2_mul([Out] G2 z, [In] G2 x, [In] Fr y);

		[StructLayout(LayoutKind.Sequential)]
		public class Fr {
			private ulong v0, v1, v2, v3;
			public void Clear()
			{
				BN256_Fr_clear(this);
			}
			public void SetInt(int x)
			{
				BN256_Fr_setInt(this, x);
			}
			public Fr Clone()
			{
				return (Fr)MemberwiseClone();
			}
			public void SetStr(string s)
			{
				if (BN256_Fr_setStr(this, s) != 0) {
					throw new ArgumentException("BN256_Fr_setStr", s);
				}
			}
			public bool IsValid()
			{
				return BN256_Fr_isValid(this) == 1;
			}
			public bool Equals(Fr rhs)
			{
				return BN256_Fr_isSame(this, rhs) == 1;
			}
			public bool IsZero()
			{
				return BN256_Fr_isZero(this) == 1;
			}
			public bool IsOne()
			{
				return BN256_Fr_isZero(this) == 1;
			}
			public void SetRand()
			{
				BN256_Fr_setRand(this);
			}
			public void SsetMsg(String s)
			{
				BN256_Fr_setMsg(this, s);
			}
			public override string ToString()
			{
				StringBuilder sb = new StringBuilder(1024);
				if (BN256_Fr_getStr(sb, sb.Capacity + 1, this) != 0) {
					throw new ArgumentException("BN256_Fr_getStr");
				}
				return sb.ToString();
			}
			public static void Neg(Fr y, Fr x)
			{
				BN256_Fr_neg(y, x);
			}
			public static void Inv(Fr y, Fr x)
			{
				BN256_Fr_inv(y, x);
			}
			public static void Add(Fr z, Fr y, Fr x)
			{
				BN256_Fr_add(z, y, x);
			}
			public static void Sub(Fr z, Fr y, Fr x)
			{
				BN256_Fr_sub(z, y, x);
			}
			public static void Mul(Fr z, Fr y, Fr x)
			{
				BN256_Fr_mul(z, y, x);
			}
			public static void Div(Fr z, Fr y, Fr x)
			{
				BN256_Fr_div(z, y, x);
			}
			public static Fr operator -(Fr x)
			{
				Fr y = new Fr();
				Neg(y, x);
				return y;
			}
			public static Fr operator +(Fr x, Fr y)
			{
				Fr z = new Fr();
				Add(z, x, y);
				return z;
			}
			public static Fr operator -(Fr x, Fr y)
			{
				Fr z = new Fr();
				Sub(z, x, y);
				return z;
			}
			public static Fr operator *(Fr x, Fr y)
			{
				Fr z = new Fr();
				Mul(z, x, y);
				return z;
			}
			public static Fr operator /(Fr x, Fr y)
			{
				Fr z = new Fr();
				Div(z, x, y);
				return z;
			}
		}
		[StructLayout(LayoutKind.Sequential)]
		public class G1 {
			private ulong v00, v01, v02, v03, v04, v05, v06, v07, v08, v09, v10, v11;
			public void Clear()
			{
				BN256_G1_clear(this);
			}
			public void setStr(String s)
			{
				if (BN256_G1_setStr(this, s) != 0) {
					throw new ArgumentException("BN256_G1_setStr", s);
				}
			}
			public bool IsValid()
			{
				return BN256_G1_isValid(this) == 1;
			}
			public bool Equals(G1 rhs)
			{
				return BN256_G1_isSame(this, rhs) == 1;
			}
			public bool IsZero()
			{
				return BN256_G1_isZero(this) == 1;
			}
			public void HashAndMapTo(String s)
			{
				if (BN256_G1_hashAndMapTo(this, s) != 0) {
					throw new ArgumentException("BN256_G1_hashAndMapTo", s);
				}
			}
			public override string ToString()
			{
				StringBuilder sb = new StringBuilder(1024);
				if (BN256_G1_getStr(sb, sb.Capacity + 1, this) != 0) {
					throw new ArgumentException("BN256_G1_getStr");
				}
				return sb.ToString();
			}
			public static void Neg(G1 y, G1 x)
			{
				BN256_G1_neg(y, x);
			}
			public static void Dbl(G1 y, G1 x)
			{
				BN256_G1_dbl(y, x);
			}
			public static void Add(G1 z, G1 y, G1 x)
			{
				BN256_G1_add(z, y, x);
			}
			public static void Sub(G1 z, G1 y, G1 x)
			{
				BN256_G1_sub(z, y, x);
			}
			public static void Mul(G1 z, G1 y, Fr x)
			{
				BN256_G1_mul(z, y, x);
			}
		}
		[StructLayout(LayoutKind.Sequential)]
		public class G2 {
			private ulong v00, v01, v02, v03, v04, v05, v06, v07, v08, v09, v10, v11;
			private ulong v12, v13, v14, v15, v16, v17, v18, v19, v20, v21, v22, v23;
			public void Clear()
			{
				BN256_G2_clear(this);
			}
			public void setStr(String s)
			{
				if (BN256_G2_setStr(this, s) != 0) {
					throw new ArgumentException("BN256_G2_setStr", s);
				}
			}
			public bool IsValid()
			{
				return BN256_G2_isValid(this) == 1;
			}
			public bool Equals(G2 rhs)
			{
				return BN256_G2_isSame(this, rhs) == 1;
			}
			public bool IsZero()
			{
				return BN256_G2_isZero(this) == 1;
			}
			public void HashAndMapTo(String s)
			{
				if (BN256_G2_hashAndMapTo(this, s) != 0) {
					throw new ArgumentException("BN256_G2_hashAndMapTo", s);
				}
			}
			public override string ToString()
			{
				StringBuilder sb = new StringBuilder(1024);
				if (BN256_G2_getStr(sb, sb.Capacity + 1, this) != 0) {
					throw new ArgumentException("BN256_G2_getStr");
				}
				return sb.ToString();
			}
			public static void Neg(G2 y, G2 x)
			{
				BN256_G2_neg(y, x);
			}
			public static void Dbl(G2 y, G2 x)
			{
				BN256_G2_dbl(y, x);
			}
			public static void Add(G2 z, G2 y, G2 x)
			{
				BN256_G2_add(z, y, x);
			}
			public static void Sub(G2 z, G2 y, G2 x)
			{
				BN256_G2_sub(z, y, x);
			}
			public static void Mul(G2 z, G2 y, Fr x)
			{
				BN256_G2_mul(z, y, x);
			}
		}

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
			} catch (Exception e) {
				Console.WriteLine("ERR={0}", e);
			}
		}
		static void TestFr()
		{
			Console.WriteLine("TestFr");
			Fr x = new Fr();
			x.Clear();
			Console.WriteLine("x = {0}", x);
			x.SetInt(3);
			Console.WriteLine("x = {0}", x);
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
	}
}
