using System;
using System.Text;
using System.Runtime.InteropServices;

namespace mcl {
	class BN256 {
		[DllImport("mclbn256.dll")]
		public static extern int mbn_setErrFile([In][MarshalAs(UnmanagedType.LPStr)] string name);
		[DllImport("mclbn256.dll")]
		public static extern int mbn_init(int curve, int maxUnitSize);
		[DllImport("mclbn256.dll")]
		public static extern void mbnFr_clear(ref Fr x);
		[DllImport("mclbn256.dll")]
		public static extern void mbnFr_setInt(ref Fr y, int x);
		[DllImport("mclbn256.dll")]
		public static extern int mbnFr_setStr(ref Fr x, [In][MarshalAs(UnmanagedType.LPStr)] string buf, long bufSize, int ioMode);
		[DllImport("mclbn256.dll")]
		public static extern int mbnFr_isValid(ref Fr x);
		[DllImport("mclbn256.dll")]
		public static extern int mbnFr_isEqual(ref Fr x, ref Fr y);
		[DllImport("mclbn256.dll")]
		public static extern int mbnFr_isZero(ref Fr x);
		[DllImport("mclbn256.dll")]
		public static extern int mbnFr_isOne(ref Fr x);
		[DllImport("mclbn256.dll")]
		public static extern void mbnFr_setByCSPRNG(ref Fr x);

		[DllImport("mclbn256.dll")]
		public static extern int mbnFr_setHashOf(ref Fr x, [In][MarshalAs(UnmanagedType.LPStr)] string buf, long bufSize);
		[DllImport("mclbn256.dll")]
		public static extern int mbnFr_getStr([Out]StringBuilder buf, long maxBufSize, ref Fr x, int ioMode);

		[DllImport("mclbn256.dll")]
		public static extern void mbnFr_neg(ref Fr y, ref Fr x);
		[DllImport("mclbn256.dll")]
		public static extern void mbnFr_inv(ref Fr y, ref Fr x);
		[DllImport("mclbn256.dll")]
		public static extern void mbnFr_add(ref Fr z, ref Fr x, ref Fr y);
		[DllImport("mclbn256.dll")]
		public static extern void mbnFr_sub(ref Fr z, ref Fr x, ref Fr y);
		[DllImport("mclbn256.dll")]
		public static extern void mbnFr_mul(ref Fr z, ref Fr x, ref Fr y);
		[DllImport("mclbn256.dll")]
		public static extern void mbnFr_div(ref Fr z, ref Fr x, ref Fr y);

		[DllImport("mclbn256.dll")]
		public static extern void mbnG1_clear(ref G1 x);
		[DllImport("mclbn256.dll")]
		public static extern int mbnG1_setStr(ref G1 x, [In][MarshalAs(UnmanagedType.LPStr)] string buf, long bufSize, int ioMode);
		[DllImport("mclbn256.dll")]
		public static extern int mbnG1_isValid(ref G1 x);
		[DllImport("mclbn256.dll")]
		public static extern int mbnG1_isEqual(ref G1 x, ref G1 y);
		[DllImport("mclbn256.dll")]
		public static extern int mbnG1_isZero(ref G1 x);
		[DllImport("mclbn256.dll")]
		public static extern int mbnG1_hashAndMapTo(ref G1 x, [In][MarshalAs(UnmanagedType.LPStr)] string buf, long bufSize);
		[DllImport("mclbn256.dll")]
		public static extern long mbnG1_getStr([Out]StringBuilder buf, long maxBufSize, ref G1 x, int ioMode);
		[DllImport("mclbn256.dll")]
		public static extern void mbnG1_neg(ref G1 y, ref G1 x);
		[DllImport("mclbn256.dll")]
		public static extern void mbnG1_dbl(ref G1 y, ref G1 x);
		[DllImport("mclbn256.dll")]
		public static extern void mbnG1_add(ref G1 z, ref G1 x, ref G1 y);
		[DllImport("mclbn256.dll")]
		public static extern void mbnG1_sub(ref G1 z, ref G1 x, ref G1 y);
		[DllImport("mclbn256.dll")]
		public static extern void mbnG1_mul(ref G1 z, ref G1 x, ref Fr y);

		[DllImport("mclbn256.dll")]
		public static extern void mbnG2_clear(ref G2 x);
		[DllImport("mclbn256.dll")]
		public static extern int mbnG2_setStr(ref G2 x, [In][MarshalAs(UnmanagedType.LPStr)] string buf, long bufSize, int ioMode);
		[DllImport("mclbn256.dll")]
		public static extern int mbnG2_isValid(ref G2 x);
		[DllImport("mclbn256.dll")]
		public static extern int mbnG2_isEqual(ref G2 x, ref G2 y);
		[DllImport("mclbn256.dll")]
		public static extern int mbnG2_isZero(ref G2 x);
		[DllImport("mclbn256.dll")]
		public static extern int mbnG2_hashAndMapTo(ref G2 x, [In][MarshalAs(UnmanagedType.LPStr)] string buf, long bufSize);
		[DllImport("mclbn256.dll")]
		public static extern long mbnG2_getStr([Out]StringBuilder buf, long maxBufSize, ref G2 x, int ioMode);
		[DllImport("mclbn256.dll")]
		public static extern void mbnG2_neg(ref G2 y, ref G2 x);
		[DllImport("mclbn256.dll")]
		public static extern void mbnG2_dbl(ref G2 y, ref G2 x);
		[DllImport("mclbn256.dll")]
		public static extern void mbnG2_add(ref G2 z, ref G2 x, ref G2 y);
		[DllImport("mclbn256.dll")]
		public static extern void mbnG2_sub(ref G2 z, ref G2 x, ref G2 y);
		[DllImport("mclbn256.dll")]
		public static extern void mbnG2_mul(ref G2 z, ref G2 x, ref Fr y);

		[DllImport("mclbn256.dll")]
		public static extern void mbnGT_clear(ref GT x);
		[DllImport("mclbn256.dll")]
		public static extern int mbnGT_setStr(ref GT x, [In][MarshalAs(UnmanagedType.LPStr)] string buf, long bufSize, int ioMode);
		[DllImport("mclbn256.dll")]
		public static extern int mbnGT_isEqual(ref GT x, ref GT y);
		[DllImport("mclbn256.dll")]
		public static extern int mbnGT_isZero(ref GT x);
		[DllImport("mclbn256.dll")]
		public static extern int mbnGT_isOne(ref GT x);
		[DllImport("mclbn256.dll")]
		public static extern long mbnGT_getStr([Out]StringBuilder buf, long maxBufSize, ref GT x, int ioMode);
		[DllImport("mclbn256.dll")]
		public static extern void mbnGT_neg(ref GT y, ref GT x);
		[DllImport("mclbn256.dll")]
		public static extern void mbnGT_inv(ref GT y, ref GT x);
		[DllImport("mclbn256.dll")]
		public static extern void mbnGT_add(ref GT z, ref GT x, ref GT y);
		[DllImport("mclbn256.dll")]
		public static extern void mbnGT_sub(ref GT z, ref GT x, ref GT y);
		[DllImport("mclbn256.dll")]
		public static extern void mbnGT_mul(ref GT z, ref GT x, ref GT y);
		[DllImport("mclbn256.dll")]
		public static extern void mbnGT_div(ref GT z, ref GT x, ref GT y);

		[DllImport("mclbn256.dll")]
		public static extern void mbnGT_pow(ref GT z, ref GT x, ref Fr y);
		[DllImport("mclbn256.dll")]
		public static extern void mbn_pairing(ref GT z, ref G1 x, ref G2 y);
		[DllImport("mclbn256.dll")]
		public static extern void mbn_finalExp(ref GT y, ref GT x);
		[DllImport("mclbn256.dll")]
		public static extern void mbn_millerLoop(ref GT z, ref G1 x, ref G2 y);

		public static void init()
		{
			const int curveFp254BNb = 0;
			const int maxUnitSize = 4;
			if (mbn_init(curveFp254BNb, maxUnitSize) != 0) {
				throw new InvalidOperationException("mbn_init");
			}
		}
		[StructLayout(LayoutKind.Sequential)]
		public struct Fr {
			private ulong v0, v1, v2, v3;
			public void Clear()
			{
				mbnFr_clear(ref this);
			}
			public void SetInt(int x)
			{
				mbnFr_setInt(ref this, x);
			}
			public void SetStr(string s, int ioMode)
			{
				if (mbnFr_setStr(ref this, s, s.Length, ioMode) != 0) {
					throw new ArgumentException("mbnFr_setStr" + s);
				}
			}
			public bool IsValid()
			{
				return mbnFr_isValid(ref this) == 1;
			}
			public bool Equals(Fr rhs)
			{
				return mbnFr_isEqual(ref this, ref rhs) == 1;
			}
			public bool IsZero()
			{
				return mbnFr_isZero(ref this) == 1;
			}
			public bool IsOne()
			{
				return mbnFr_isOne(ref this) == 1;
			}
			public void SetByCSPRNG()
			{
				mbnFr_setByCSPRNG(ref this);
			}
			public void SetHashOf(String s)
			{
				if (mbnFr_setHashOf(ref this, s, s.Length) != 0) {
					throw new InvalidOperationException("mbnFr_setHashOf:" + s);
				}
			}
			public string GetStr(int ioMode)
			{
				StringBuilder sb = new StringBuilder(1024);
				long size = mbnFr_getStr(sb, sb.Capacity, ref this, ioMode);
				if (size == 0) {
					throw new InvalidOperationException("mbnFr_getStr:");
				}
				return sb.ToString();
			}
			public void Neg(Fr x)
			{
				mbnFr_neg(ref this, ref x);
			}
			public void Inv(Fr x)
			{
				mbnFr_inv(ref this, ref x);
			}
			public void Add(Fr x, Fr y)
			{
				mbnFr_add(ref this, ref x, ref y);
			}
			public void Sub(Fr x, Fr y)
			{
				mbnFr_sub(ref this, ref x, ref y);
			}
			public void Mul(Fr x, Fr y)
			{
				mbnFr_mul(ref this, ref x, ref y);
			}
			public void Div(Fr x, Fr y)
			{
				mbnFr_div(ref this, ref x, ref y);
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
				mbnG1_clear(ref this);
			}
			public void setStr(String s, int ioMode)
			{
				if (mbnG1_setStr(ref this, s, s.Length, ioMode) != 0) {
					throw new ArgumentException("mbnG1_setStr:" + s);
				}
			}
			public bool IsValid()
			{
				return mbnG1_isValid(ref this) == 1;
			}
			public bool Equals(G1 rhs)
			{
				return mbnG1_isEqual(ref this, ref rhs) == 1;
			}
			public bool IsZero()
			{
				return mbnG1_isZero(ref this) == 1;
			}
			public void HashAndMapTo(String s)
			{
				if (mbnG1_hashAndMapTo(ref this, s, s.Length) != 0) {
					throw new ArgumentException("mbnG1_hashAndMapTo:" + s);
				}
			}
			public string GetStr(int ioMode)
			{
				StringBuilder sb = new StringBuilder(1024);
				long size = mbnG1_getStr(sb, sb.Capacity, ref this, ioMode);
				if (size == 0) {
					throw new InvalidOperationException("mbnG1_getStr:");
				}
				return sb.ToString();
			}
			public void Neg(G1 x)
			{
				mbnG1_neg(ref this, ref x);
			}
			public void Dbl(G1 x)
			{
				mbnG1_dbl(ref this, ref x);
			}
			public void Add(G1 x, G1 y)
			{
				mbnG1_add(ref this, ref x, ref y);
			}
			public void Sub(G1 x, G1 y)
			{
				mbnG1_sub(ref this, ref x, ref y);
			}
			public void Mul(G1 x, Fr y)
			{
				mbnG1_mul(ref this, ref x, ref y);
			}
		}
		[StructLayout(LayoutKind.Sequential)]
		public struct G2 {
			private ulong v00, v01, v02, v03, v04, v05, v06, v07, v08, v09, v10, v11;
			private ulong v12, v13, v14, v15, v16, v17, v18, v19, v20, v21, v22, v23;
			public void Clear()
			{
				mbnG2_clear(ref this);
			}
			public void setStr(String s, int ioMode)
			{
				if (mbnG2_setStr(ref this, s, s.Length, ioMode) != 0) {
					throw new ArgumentException("mbnG2_setStr:" + s);
				}
			}
			public bool IsValid()
			{
				return mbnG2_isValid(ref this) == 1;
			}
			public bool Equals(G2 rhs)
			{
				return mbnG2_isEqual(ref this, ref rhs) == 1;
			}
			public bool IsZero()
			{
				return mbnG2_isZero(ref this) == 1;
			}
			public void HashAndMapTo(String s)
			{
				if (mbnG2_hashAndMapTo(ref this, s, s.Length) != 0) {
					throw new ArgumentException("mbnG2_hashAndMapTo:" + s);
				}
			}
			public string GetStr(int ioMode)
			{
				StringBuilder sb = new StringBuilder(1024);
				long size = mbnG2_getStr(sb, sb.Capacity, ref this, ioMode);
				if (size == 0) {
					throw new InvalidOperationException("mbnG2_getStr:");
				}
				return sb.ToString();
			}
			public void Neg(G2 x)
			{
				mbnG2_neg(ref this, ref x);
			}
			public void Dbl(G2 x)
			{
				mbnG2_dbl(ref this, ref x);
			}
			public void Add(G2 x, G2 y)
			{
				mbnG2_add(ref this, ref x, ref y);
			}
			public void Sub(G2 x, G2 y)
			{
				mbnG2_sub(ref this, ref x, ref y);
			}
			public void Mul(G2 x, Fr y)
			{
				mbnG2_mul(ref this, ref x, ref y);
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
				mbnGT_clear(ref this);
			}
			public void setStr(String s, int ioMode)
			{
				if (mbnGT_setStr(ref this, s, s.Length, ioMode) != 0) {
					throw new ArgumentException("mbnGT_setStr:" + s);
				}
			}
			public bool Equals(GT rhs)
			{
				return mbnGT_isEqual(ref this, ref rhs) == 1;
			}
			public bool IsZero()
			{
				return mbnGT_isZero(ref this) == 1;
			}
			public bool IsOne()
			{
				return mbnGT_isOne(ref this) == 1;
			}
			public string GetStr(int ioMode)
			{
				StringBuilder sb = new StringBuilder(1024);
				long size = mbnGT_getStr(sb, sb.Capacity, ref this, ioMode);
				if (size == 0) {
					throw new InvalidOperationException("mbnGT_getStr:");
				}
				return sb.ToString();
			}
			public void Neg(GT x)
			{
				mbnGT_neg(ref this, ref x);
			}
			public void Inv(GT x)
			{
				mbnGT_inv(ref this, ref x);
			}
			public void Add(GT x, GT y)
			{
				mbnGT_add(ref this, ref x, ref this);
			}
			public void Sub(GT x, GT y)
			{
				mbnGT_sub(ref this, ref x, ref this);
			}
			public void Mul(GT x, GT y)
			{
				mbnGT_mul(ref this, ref x, ref this);
			}
			public void Div(GT x, GT y)
			{
				mbnGT_div(ref this, ref x, ref this);
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
			public void Pow(GT x, Fr y)
			{
				mbnGT_pow(ref this, ref x, ref y);
			}
			public void Pairing(G1 x, G2 y)
			{
				mbn_pairing(ref this, ref x, ref y);
			}
			public void FinalExp(GT x)
			{
				mbn_finalExp(ref this, ref x);
			}
			public void MillerLoop(G1 x, G2 y)
			{
				mbn_millerLoop(ref this, ref x, ref y);
			}
		}
	}
}
