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
		public static extern void BN256_Fr_clear([Out] Fr x);
		[DllImport("bn256.dll")]
		public static extern void BN256_Fr_setInt([Out] Fr y, int x);
		[DllImport("bn256.dll")]
		public static extern int BN256_Fr_setStr([Out] Fr x, [In][MarshalAs(UnmanagedType.LPStr)] string s);
		[DllImport("bn256.dll")]
		public static extern int BN256_Fr_isValid([In] Fr x);
		[DllImport("bn256.dll")]
		public static extern int BN256_Fr_isSame([In] Fr x, [In] Fr y);
		[DllImport("bn256.dll")]
		public static extern int BN256_Fr_isZero([In] Fr x);
		[DllImport("bn256.dll")]
		public static extern int BN256_Fr_isOne([In] Fr x);
		[DllImport("bn256.dll")]
		public static extern void BN256_Fr_setRand([Out] Fr x);

		[DllImport("bn256.dll")]
		public static extern void BN256_Fr_setMsg([Out] Fr x, [In][MarshalAs(UnmanagedType.LPStr)] string s);
		[DllImport("bn256.dll")]
		public static extern int BN256_Fr_getStr([Out]StringBuilder buf, long maxBufSize, [In] Fr x);

		[DllImport("bn256.dll")]
		public static extern void BN256_Fr_neg([Out] Fr y, [In] Fr x);
		[DllImport("bn256.dll")]
		public static extern void BN256_Fr_inv([Out] Fr y, [In] Fr x);
		[DllImport("bn256.dll")]
		public static extern void BN256_Fr_add([Out] Fr z, [In] Fr x, [In] Fr y);
		[DllImport("bn256.dll")]
		public static extern void BN256_Fr_sub([Out] Fr z, [In] Fr x, [In] Fr y);
		[DllImport("bn256.dll")]
		public static extern void BN256_Fr_mul([Out] Fr z, [In] Fr x, [In] Fr y);
		[DllImport("bn256.dll")]
		public static extern void BN256_Fr_div([Out] Fr z, [In] Fr x, [In] Fr y);

		[DllImport("bn256.dll")]
		public static extern void BN256_G1_clear([Out] G1 x);
		[DllImport("bn256.dll")]
		public static extern int BN256_G1_setStr([Out] G1 x, [In][MarshalAs(UnmanagedType.LPStr)] string s);
		[DllImport("bn256.dll")]
		public static extern int BN256_G1_isValid([In] G1 x);
		[DllImport("bn256.dll")]
		public static extern int BN256_G1_isSame([In] G1 x, [In] G1 y);
		[DllImport("bn256.dll")]
		public static extern int BN256_G1_isZero([In] G1 x);
		[DllImport("bn256.dll")]
		public static extern int BN256_G1_hashAndMapTo([Out] G1 x, [In][MarshalAs(UnmanagedType.LPStr)] string s);
		[DllImport("bn256.dll")]
		public static extern int BN256_G1_getStr([Out]StringBuilder buf, long maxBufSize, [In] G1 x);
		[DllImport("bn256.dll")]
		public static extern void BN256_G1_neg([Out] G1 y, [In] G1 x);
		[DllImport("bn256.dll")]
		public static extern void BN256_G1_dbl([Out] G1 y, [In] G1 x);
		[DllImport("bn256.dll")]
		public static extern void BN256_G1_add([Out] G1 z, [In] G1 x, [In] G1 y);
		[DllImport("bn256.dll")]
		public static extern void BN256_G1_sub([Out] G1 z, [In] G1 x, [In] G1 y);
		[DllImport("bn256.dll")]
		public static extern void BN256_G1_mul([Out] G1 z, [In] G1 x, [In] Fr y);

		[DllImport("bn256.dll")]
		public static extern void BN256_G2_clear([Out] G2 x);
		[DllImport("bn256.dll")]
		public static extern int BN256_G2_setStr([Out] G2 x, [In][MarshalAs(UnmanagedType.LPStr)] string s);
		[DllImport("bn256.dll")]
		public static extern int BN256_G2_isValid([In] G2 x);
		[DllImport("bn256.dll")]
		public static extern int BN256_G2_isSame([In] G2 x, [In] G2 y);
		[DllImport("bn256.dll")]
		public static extern int BN256_G2_isZero([In] G2 x);
		[DllImport("bn256.dll")]
		public static extern int BN256_G2_hashAndMapTo([Out] G2 x, [In][MarshalAs(UnmanagedType.LPStr)] string s);
		[DllImport("bn256.dll")]
		public static extern int BN256_G2_getStr([Out]StringBuilder buf, long maxBufSize, [In] G2 x);
		[DllImport("bn256.dll")]
		public static extern void BN256_G2_neg([Out] G2 y, [In] G2 x);
		[DllImport("bn256.dll")]
		public static extern void BN256_G2_dbl([Out] G2 y, [In] G2 x);
		[DllImport("bn256.dll")]
		public static extern void BN256_G2_add([Out] G2 z, [In] G2 x, [In] G2 y);
		[DllImport("bn256.dll")]
		public static extern void BN256_G2_sub([Out] G2 z, [In] G2 x, [In] G2 y);
		[DllImport("bn256.dll")]
		public static extern void BN256_G2_mul([Out] G2 z, [In] G2 x, [In] Fr y);

		[DllImport("bn256.dll")]
		public static extern void BN256_GT_clear([Out] GT x);
		[DllImport("bn256.dll")]
		public static extern int BN256_GT_setStr([Out] GT x, [In][MarshalAs(UnmanagedType.LPStr)] string s);
		[DllImport("bn256.dll")]
		public static extern int BN256_GT_isSame([In] GT x, [In] GT y);
		[DllImport("bn256.dll")]
		public static extern int BN256_GT_isZero([In] GT x);
		[DllImport("bn256.dll")]
		public static extern int BN256_GT_isOne([In] GT x);
		[DllImport("bn256.dll")]
		public static extern int BN256_GT_getStr([Out]StringBuilder buf, long maxBufSize, [In] GT x);
		[DllImport("bn256.dll")]
		public static extern void BN256_GT_neg([Out] GT y, [In] GT x);
		[DllImport("bn256.dll")]
		public static extern void BN256_GT_inv([Out] GT y, [In] GT x);
		[DllImport("bn256.dll")]
		public static extern void BN256_GT_add([Out] GT z, [In] GT x, [In] GT y);
		[DllImport("bn256.dll")]
		public static extern void BN256_GT_sub([Out] GT z, [In] GT x, [In] GT y);
		[DllImport("bn256.dll")]
		public static extern void BN256_GT_mul([Out] GT z, [In] GT x, [In] GT y);
		[DllImport("bn256.dll")]
		public static extern void BN256_GT_div([Out] GT z, [In] GT x, [In] GT y);

		[DllImport("bn256.dll")]
		public static extern void BN256_GT_finalExp([Out] GT y, [In] GT x);
		[DllImport("bn256.dll")]
		public static extern void BN256_GT_pow([Out] GT z, [In] GT x, [In] Fr y);
		[DllImport("bn256.dll")]
		public static extern void BN256_pairing([Out] GT z, [In] G1 x, [In] G2 y);
		[DllImport("bn256.dll")]
		public static extern void BN256_millerLoop([Out] GT z, [In] G1 x, [In] G2 y);

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
				return BN256_Fr_isOne(this) == 1;
			}
			public void SetRand()
			{
				BN256_Fr_setRand(this);
			}
			public void SetMsg(String s)
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
			public G1 Clone()
			{
				return (G1)MemberwiseClone();
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
			public G2 Clone()
			{
				return (G2)MemberwiseClone();
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
		[StructLayout(LayoutKind.Sequential)]
		public class GT {
			private ulong v00, v01, v02, v03, v04, v05, v06, v07, v08, v09, v10, v11;
			private ulong v12, v13, v14, v15, v16, v17, v18, v19, v20, v21, v22, v23;
			private ulong v24, v25, v26, v27, v28, v29, v30, v31, v32, v33, v34, v35;
			private ulong v36, v37, v38, v39, v40, v41, v42, v43, v44, v45, v46, v47;
			public void Clear()
			{
				BN256_GT_clear(this);
			}
			public void setStr(String s)
			{
				if (BN256_GT_setStr(this, s) != 0) {
					throw new ArgumentException("BN256_GT_setStr", s);
				}
			}
			public GT Clone()
			{
				return (GT)MemberwiseClone();
			}
			public bool Equals(GT rhs)
			{
				return BN256_GT_isSame(this, rhs) == 1;
			}
			public bool IsZero()
			{
				return BN256_GT_isZero(this) == 1;
			}
			public bool IsOne()
			{
				return BN256_GT_isOne(this) == 1;
			}
			public override string ToString()
			{
				StringBuilder sb = new StringBuilder(1024);
				if (BN256_GT_getStr(sb, sb.Capacity + 1, this) != 0) {
					throw new ArgumentException("BN256_GT_getStr");
				}
				return sb.ToString();
			}
			public static void Neg(GT y, GT x)
			{
				BN256_GT_neg(y, x);
			}
			public static void Inv(GT y, GT x)
			{
				BN256_GT_inv(y, x);
			}
			public static void Add(GT z, GT y, GT x)
			{
				BN256_GT_add(z, y, x);
			}
			public static void Sub(GT z, GT y, GT x)
			{
				BN256_GT_sub(z, y, x);
			}
			public static void Mul(GT z, GT y, GT x)
			{
				BN256_GT_mul(z, y, x);
			}
			public static void Div(GT z, GT y, GT x)
			{
				BN256_GT_div(z, y, x);
			}
			public static GT operator -(GT x)
			{
				GT y = new GT();
				Neg(y, x);
				return y;
			}
			public static GT operator +(GT x, GT y)
			{
				GT z = new GT();
				Add(z, x, y);
				return z;
			}
			public static GT operator -(GT x, GT y)
			{
				GT z = new GT();
				Sub(z, x, y);
				return z;
			}
			public static GT operator *(GT x, GT y)
			{
				GT z = new GT();
				Mul(z, x, y);
				return z;
			}
			public static GT operator /(GT x, GT y)
			{
				GT z = new GT();
				Div(z, x, y);
				return z;
			}
			public static void FinalExp(GT y, GT x)
			{
				BN256_GT_finalExp(y, x);
			}
			public static void Pow(GT z, GT x, Fr y)
			{
				BN256_GT_pow(z, x, y);
			}
		}
		public static void Pairing(GT z, G1 x, G2 y)
		{
			BN256_pairing(z, x, y);
		}
		public static void MillerLoop(GT z, G1 x, G2 y)
		{
			BN256_millerLoop(z, x, y);
		}
	}
}
