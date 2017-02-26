using System;
using System.Text;
using System.Runtime.InteropServices;

namespace bn256 {
	class X {
		[DllImport("bn256_if.dll")] public static extern int BN256_setErrFile([In][MarshalAs(UnmanagedType.LPStr)] string name);

		[DllImport("bn256_if.dll")] public static extern int BN256_init();

		[DllImport("bn256_if.dll")] public static extern void BN256_Fr_clear([Out] Fr x);
		[DllImport("bn256_if.dll")] public static extern void BN256_Fr_setInt([Out] Fr y, int x);
		[DllImport("bn256_if.dll")] public static extern void BN256_Fr_copy([Out] Fr y, [In] Fr x);
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

		[StructLayout(LayoutKind.Sequential)]
		public class Fr {
			private ulong v0;
			private ulong v1;
			private ulong v2;
			private ulong v3;
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

		static void Main(string[] args)
		{
			Console.WriteLine("64bit = {0}", System.Environment.Is64BitProcess);
			int ret;
			ret = BN256_init();
			Console.WriteLine("ret= {0}", ret);
			ret = BN256_setErrFile("c:/tmp/abc.txt");
			Console.WriteLine("ret= {0}", ret);

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
			x.SetInt(123);
			Console.WriteLine("y = {0}", y);
		}
	}
}
