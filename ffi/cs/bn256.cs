using System;
using System.Text;
using System.Runtime.InteropServices;

namespace mcl {
	class BN256 {
		[DllImport("bn256.dll")]
		public static extern int BN256_setErrFile([In][MarshalAs(UnmanagedType.LPStr)] string name);
		[DllImport("bn256.dll")]
		public static extern int BN256_init();
		[DllImport("bn256.dll")]
		public static extern void BN256_Fr_clear(ref Fr x);
		[DllImport("bn256.dll")]
		public static extern void BN256_Fr_setInt(ref Fr y, int x);
		[DllImport("bn256.dll")]
		public static extern int BN256_Fr_setStr(ref Fr x, [In][MarshalAs(UnmanagedType.LPStr)] string s);
		[DllImport("bn256.dll")]
		public static extern int BN256_Fr_isValid(ref Fr x);
		[DllImport("bn256.dll")]
		public static extern int BN256_Fr_isSame(ref Fr x, ref Fr y);
		[DllImport("bn256.dll")]
		public static extern int BN256_Fr_isZero(ref Fr x);
		[DllImport("bn256.dll")]
		public static extern int BN256_Fr_isOne(ref Fr x);
		[DllImport("bn256.dll")]
		public static extern void BN256_Fr_setRand(ref Fr x);

		[DllImport("bn256.dll")]
		public static extern void BN256_Fr_setMsg(ref Fr x, [In][MarshalAs(UnmanagedType.LPStr)] string s);
		[DllImport("bn256.dll")]
		public static extern int BN256_Fr_getStr([Out]StringBuilder buf, int maxBufSize, ref Fr x);

		[DllImport("bn256.dll")]
		public static extern void BN256_Fr_neg(ref Fr y, ref Fr x);
		[DllImport("bn256.dll")]
		public static extern void BN256_Fr_inv(ref Fr y, ref Fr x);
		[DllImport("bn256.dll")]
		public static extern void BN256_Fr_add(ref Fr z, ref Fr x, ref Fr y);
		[DllImport("bn256.dll")]
		public static extern void BN256_Fr_sub(ref Fr z, ref Fr x, ref Fr y);
		[DllImport("bn256.dll")]
		public static extern void BN256_Fr_mul(ref Fr z, ref Fr x, ref Fr y);
		[DllImport("bn256.dll")]
		public static extern void BN256_Fr_div(ref Fr z, ref Fr x, ref Fr y);

		[DllImport("bn256.dll")]
		public static extern void BN256_G1_clear(ref G1 x);
		[DllImport("bn256.dll")]
		public static extern int BN256_G1_setStr(ref G1 x, [In][MarshalAs(UnmanagedType.LPStr)] string s);
		[DllImport("bn256.dll")]
		public static extern int BN256_G1_isValid(ref G1 x);
		[DllImport("bn256.dll")]
		public static extern int BN256_G1_isSame(ref G1 x, ref G1 y);
		[DllImport("bn256.dll")]
		public static extern int BN256_G1_isZero(ref G1 x);
		[DllImport("bn256.dll")]
		public static extern int BN256_G1_hashAndMapTo(ref G1 x, [In][MarshalAs(UnmanagedType.LPStr)] string s);
		[DllImport("bn256.dll")]
		public static extern int BN256_G1_getStr([Out]StringBuilder buf, int maxBufSize, ref G1 x);
		[DllImport("bn256.dll")]
		public static extern void BN256_G1_neg(ref G1 y, ref G1 x);
		[DllImport("bn256.dll")]
		public static extern void BN256_G1_dbl(ref G1 y, ref G1 x);
		[DllImport("bn256.dll")]
		public static extern void BN256_G1_add(ref G1 z, ref G1 x, ref G1 y);
		[DllImport("bn256.dll")]
		public static extern void BN256_G1_sub(ref G1 z, ref G1 x, ref G1 y);
		[DllImport("bn256.dll")]
		public static extern void BN256_G1_mul(ref G1 z, ref G1 x, ref Fr y);

		[DllImport("bn256.dll")]
		public static extern void BN256_G2_clear(ref G2 x);
		[DllImport("bn256.dll")]
		public static extern int BN256_G2_setStr(ref G2 x, [In][MarshalAs(UnmanagedType.LPStr)] string s);
		[DllImport("bn256.dll")]
		public static extern int BN256_G2_isValid(ref G2 x);
		[DllImport("bn256.dll")]
		public static extern int BN256_G2_isSame(ref G2 x, ref G2 y);
		[DllImport("bn256.dll")]
		public static extern int BN256_G2_isZero(ref G2 x);
		[DllImport("bn256.dll")]
		public static extern int BN256_G2_hashAndMapTo(ref G2 x, [In][MarshalAs(UnmanagedType.LPStr)] string s);
		[DllImport("bn256.dll")]
		public static extern int BN256_G2_getStr([Out]StringBuilder buf, int maxBufSize, ref G2 x);
		[DllImport("bn256.dll")]
		public static extern void BN256_G2_neg(ref G2 y, ref G2 x);
		[DllImport("bn256.dll")]
		public static extern void BN256_G2_dbl(ref G2 y, ref G2 x);
		[DllImport("bn256.dll")]
		public static extern void BN256_G2_add(ref G2 z, ref G2 x, ref G2 y);
		[DllImport("bn256.dll")]
		public static extern void BN256_G2_sub(ref G2 z, ref G2 x, ref G2 y);
		[DllImport("bn256.dll")]
		public static extern void BN256_G2_mul(ref G2 z, ref G2 x, ref Fr y);

		[DllImport("bn256.dll")]
		public static extern void BN256_GT_clear(ref GT x);
		[DllImport("bn256.dll")]
		public static extern int BN256_GT_setStr(ref GT x, [In][MarshalAs(UnmanagedType.LPStr)] string s);
		[DllImport("bn256.dll")]
		public static extern int BN256_GT_isSame(ref GT x, ref GT y);
		[DllImport("bn256.dll")]
		public static extern int BN256_GT_isZero(ref GT x);
		[DllImport("bn256.dll")]
		public static extern int BN256_GT_isOne(ref GT x);
		[DllImport("bn256.dll")]
		public static extern int BN256_GT_getStr([Out]StringBuilder buf, int maxBufSize, ref GT x);
		[DllImport("bn256.dll")]
		public static extern void BN256_GT_neg(ref GT y, ref GT x);
		[DllImport("bn256.dll")]
		public static extern void BN256_GT_inv(ref GT y, ref GT x);
		[DllImport("bn256.dll")]
		public static extern void BN256_GT_add(ref GT z, ref GT x, ref GT y);
		[DllImport("bn256.dll")]
		public static extern void BN256_GT_sub(ref GT z, ref GT x, ref GT y);
		[DllImport("bn256.dll")]
		public static extern void BN256_GT_mul(ref GT z, ref GT x, ref GT y);
		[DllImport("bn256.dll")]
		public static extern void BN256_GT_div(ref GT z, ref GT x, ref GT y);

		[DllImport("bn256.dll")]
		public static extern void BN256_GT_finalExp(ref GT y, ref GT x);
		[DllImport("bn256.dll")]
		public static extern void BN256_GT_pow(ref GT z, ref GT x, ref Fr y);
		[DllImport("bn256.dll")]
		public static extern void BN256_pairing(ref GT z, ref G1 x, ref G2 y);
		[DllImport("bn256.dll")]
		public static extern void BN256_millerLoop(ref GT z, ref G1 x, ref G2 y);

		[StructLayout(LayoutKind.Sequential)]
		public struct Fr {
			private ulong v0, v1, v2, v3;
			public void Clear()
			{
				BN256_Fr_clear(ref this);
			}
			public void SetInt(int x)
			{
				BN256_Fr_setInt(ref this, x);
			}
			public void SetStr(string s)
			{
				if (BN256_Fr_setStr(ref this, s) != 0) {
					throw new ArgumentException("BN256_Fr_setStr", s);
				}
			}
			public bool IsValid()
			{
				return BN256_Fr_isValid(ref this) == 1;
			}
			public bool Equals(Fr rhs)
			{
				return BN256_Fr_isSame(ref this, ref rhs) == 1;
			}
			public bool IsZero()
			{
				return BN256_Fr_isZero(ref this) == 1;
			}
			public bool IsOne()
			{
				return BN256_Fr_isOne(ref this) == 1;
			}
			public void SetRand()
			{
				BN256_Fr_setRand(ref this);
			}
			public void SetMsg(String s)
			{
				BN256_Fr_setMsg(ref this, s);
			}
			public override string ToString()
			{
				StringBuilder sb = new StringBuilder(1024);
				if (BN256_Fr_getStr(sb, sb.Capacity + 1, ref this) != 0) {
					return "ERR:BN256_Fr_getStr";
				}
				return sb.ToString();
			}
			public void Neg(Fr x)
			{
				BN256_Fr_neg(ref this, ref x);
			}
			public void Inv(Fr x)
			{
				BN256_Fr_inv(ref this, ref x);
			}
			public void Add(Fr x, Fr y)
			{
				BN256_Fr_add(ref this, ref x, ref y);
			}
			public  void Sub(Fr x, Fr y)
			{
				BN256_Fr_sub(ref this, ref x, ref y);
			}
			public  void Mul(Fr x, Fr y)
			{
				BN256_Fr_mul(ref this, ref x, ref y);
			}
			public  void Div(Fr x, Fr y)
			{
				BN256_Fr_div(ref this, ref x, ref y);
			}
			public static Fr operator -(Fr x)
			{
				Fr y = new Fr();
				y.Neg(x);
				return y;
			}
			public static Fr operator +(Fr x, Fr y)
			{
				Fr z = new Fr();
				z.Add(x, y);
				return z;
			}
			public static Fr operator -(Fr x, Fr y)
			{
				Fr z = new Fr();
				z.Sub(x, y);
				return z;
			}
			public static Fr operator *(Fr x, Fr y)
			{
				Fr z = new Fr();
				z.Mul(x, y);
				return z;
			}
			public static Fr operator /(Fr x, Fr y)
			{
				Fr z = new Fr();
				z.Div(x, y);
				return z;
			}
		}
		[StructLayout(LayoutKind.Sequential)]
		public struct G1 {
			private ulong v00, v01, v02, v03, v04, v05, v06, v07, v08, v09, v10, v11;
			public void Clear()
			{
				BN256_G1_clear(ref this);
			}
			public void setStr(String s)
			{
				if (BN256_G1_setStr(ref this, s) != 0) {
					throw new ArgumentException("BN256_G1_setStr", s);
				}
			}
			public bool IsValid()
			{
				return BN256_G1_isValid(ref this) == 1;
			}
			public bool Equals(G1 rhs)
			{
				return BN256_G1_isSame(ref this, ref rhs) == 1;
			}
			public bool IsZero()
			{
				return BN256_G1_isZero(ref this) == 1;
			}
			public void HashAndMapTo(String s)
			{
				if (BN256_G1_hashAndMapTo(ref this, s) != 0) {
					throw new ArgumentException("BN256_G1_hashAndMapTo", s);
				}
			}
			public override string ToString()
			{
				StringBuilder sb = new StringBuilder(1024);
				if (BN256_G1_getStr(sb, sb.Capacity + 1, ref this) != 0) {
					return "ERR:BN256_G1_getStr";
				}
				return sb.ToString();
			}
			public void Neg(G1 x)
			{
				BN256_G1_neg(ref this, ref x);
			}
			public void Dbl(G1 x)
			{
				BN256_G1_dbl(ref this, ref x);
			}
			public void Add(G1 x, G1 y)
			{
				BN256_G1_add(ref this, ref x, ref y);
			}
			public void Sub(G1 x, G1 y)
			{
				BN256_G1_sub(ref this, ref x, ref y);
			}
			public void Mul(G1 x, Fr y)
			{
				BN256_G1_mul(ref this, ref x, ref y);
			}
		}
		[StructLayout(LayoutKind.Sequential)]
		public struct G2 {
			private ulong v00, v01, v02, v03, v04, v05, v06, v07, v08, v09, v10, v11;
			private ulong v12, v13, v14, v15, v16, v17, v18, v19, v20, v21, v22, v23;
			public void Clear()
			{
				BN256_G2_clear(ref this);
			}
			public void setStr(String s)
			{
				if (BN256_G2_setStr(ref this, s) != 0) {
					throw new ArgumentException("BN256_G2_setStr", s);
				}
			}
			public bool IsValid()
			{
				return BN256_G2_isValid(ref this) == 1;
			}
			public bool Equals(G2 rhs)
			{
				return BN256_G2_isSame(ref this, ref rhs) == 1;
			}
			public bool IsZero()
			{
				return BN256_G2_isZero(ref this) == 1;
			}
			public void HashAndMapTo(String s)
			{
				if (BN256_G2_hashAndMapTo(ref this, s) != 0) {
					throw new ArgumentException("BN256_G2_hashAndMapTo", s);
				}
			}
			public override string ToString()
			{
				StringBuilder sb = new StringBuilder(1024);
				if (BN256_G2_getStr(sb, sb.Capacity + 1, ref this) != 0) {
					return "ERR:BN256_G2_getStr";
				}
				return sb.ToString();
			}
			public void Neg(G2 x)
			{
				BN256_G2_neg(ref this, ref x);
			}
			public void Dbl(G2 x)
			{
				BN256_G2_dbl(ref this, ref x);
			}
			public void Add(G2 x, G2 y)
			{
				BN256_G2_add(ref this, ref x, ref y);
			}
			public void Sub(G2 x, G2 y)
			{
				BN256_G2_sub(ref this, ref x, ref y);
			}
			public void Mul(G2 x, Fr y)
			{
				BN256_G2_mul(ref this, ref x, ref y);
			}
		}
		[StructLayout(LayoutKind.Sequential)]
		public struct GT {
			private ulong v00, v01, v02, v03, v04, v05, v06, v07, v08, v09, v10, v11;
			private ulong v12, v13, v14, v15, v16, v17, v18, v19, v20, v21, v22, v23;
			private ulong v24, v25, v26, v27, v28, v29, v30, v31, v32, v33, v34, v35;
			private ulong v36, v37, v38, v39, v40, v41, v42, v43, v44, v45, v46, v47;
			public void Clear()
			{
				BN256_GT_clear(ref this);
			}
			public void setStr(String s)
			{
				if (BN256_GT_setStr(ref this, s) != 0) {
					throw new ArgumentException("BN256_GT_setStr", s);
				}
			}
			public bool Equals(GT rhs)
			{
				return BN256_GT_isSame(ref this, ref rhs) == 1;
			}
			public bool IsZero()
			{
				return BN256_GT_isZero(ref this) == 1;
			}
			public bool IsOne()
			{
				return BN256_GT_isOne(ref this) == 1;
			}
			public override string ToString()
			{
				StringBuilder sb = new StringBuilder(1024);
				if (BN256_GT_getStr(sb, sb.Capacity + 1, ref this) != 0) {
					return "ERR:BN256_GT_getStr";
				}
				return sb.ToString();
			}
			public void Neg(GT x)
			{
				BN256_GT_neg(ref this, ref x);
			}
			public void Inv(GT x)
			{
				BN256_GT_inv(ref this, ref x);
			}
			public void Add(GT x, GT y)
			{
				BN256_GT_add(ref this, ref x, ref this);
			}
			public void Sub(GT x, GT y)
			{
				BN256_GT_sub(ref this, ref x, ref this);
			}
			public void Mul(GT x, GT y)
			{
				BN256_GT_mul(ref this, ref x, ref this);
			}
			public void Div(GT x, GT y)
			{
				BN256_GT_div(ref this, ref x, ref this);
			}
			public static GT operator -(GT x)
			{
				GT y = new GT();
				y.Neg(x);
				return y;
			}
			public static GT operator +(GT x, GT y)
			{
				GT z = new GT();
				z.Add(x, y);
				return z;
			}
			public static GT operator -(GT x, GT y)
			{
				GT z = new GT();
				z.Sub(x, y);
				return z;
			}
			public static GT operator *(GT x, GT y)
			{
				GT z = new GT();
				z.Mul(x, y);
				return z;
			}
			public static GT operator /(GT x, GT y)
			{
				GT z = new GT();
				z.Div(x, y);
				return z;
			}
			public void FinalExp(GT x)
			{
				BN256_GT_finalExp(ref this, ref x);
			}
			public void Pow(GT x, Fr y)
			{
				BN256_GT_pow(ref this, ref x, ref y);
			}
			public void Pairing(G1 x, G2 y)
			{
				BN256_pairing(ref this, ref x, ref y);
			}
			public void MillerLoop(G1 x, G2 y)
			{
				BN256_millerLoop(ref this, ref x, ref y);
			}
		}
	}
}
