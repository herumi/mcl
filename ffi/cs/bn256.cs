using System;
using System.Text;
using System.Runtime.InteropServices;

namespace mcl {
	class BN256 {
        [DllImport("mclbn256.dll")]
		public static extern int MBN_setErrFile([In][MarshalAs(UnmanagedType.LPStr)] string name);
		[DllImport("mclbn256.dll")]
		public static extern int MBN_init(int curve, int maxUnitSize);
		[DllImport("mclbn256.dll")]
		public static extern void MBN_Fr_clear(ref Fr x);
		[DllImport("mclbn256.dll")]
		public static extern void MBN_Fr_setInt(ref Fr y, int x);
		[DllImport("mclbn256.dll")]
		public static extern int MBN_Fr_setDecStr(ref Fr x, [In][MarshalAs(UnmanagedType.LPStr)] string buf, long bufSize);
		[DllImport("mclbn256.dll")]
		public static extern int MBN_Fr_setHexStr(ref Fr x, [In][MarshalAs(UnmanagedType.LPStr)] string buf, long bufSize);
		[DllImport("mclbn256.dll")]
		public static extern int MBN_Fr_isValid(ref Fr x);
		[DllImport("mclbn256.dll")]
		public static extern int MBN_Fr_isEqual(ref Fr x, ref Fr y);
		[DllImport("mclbn256.dll")]
		public static extern int MBN_Fr_isZero(ref Fr x);
		[DllImport("mclbn256.dll")]
		public static extern int MBN_Fr_isOne(ref Fr x);
		[DllImport("mclbn256.dll")]
		public static extern void MBN_Fr_setByCSPRNG(ref Fr x);

		[DllImport("mclbn256.dll")]
		public static extern int MBN_hashToFr(ref Fr x, [In][MarshalAs(UnmanagedType.LPStr)] string buf, long bufSize);
		[DllImport("mclbn256.dll")]
		public static extern int MBN_Fr_getHexStr([Out]StringBuilder buf, long maxBufSize, ref Fr x);
		[DllImport("mclbn256.dll")]
		public static extern int MBN_Fr_getDecStr([Out]StringBuilder buf, long maxBufSize, ref Fr x);

		[DllImport("mclbn256.dll")]
		public static extern void MBN_Fr_neg(ref Fr y, ref Fr x);
		[DllImport("mclbn256.dll")]
		public static extern void MBN_Fr_inv(ref Fr y, ref Fr x);
		[DllImport("mclbn256.dll")]
		public static extern void MBN_Fr_add(ref Fr z, ref Fr x, ref Fr y);
		[DllImport("mclbn256.dll")]
		public static extern void MBN_Fr_sub(ref Fr z, ref Fr x, ref Fr y);
		[DllImport("mclbn256.dll")]
		public static extern void MBN_Fr_mul(ref Fr z, ref Fr x, ref Fr y);
		[DllImport("mclbn256.dll")]
		public static extern void MBN_Fr_div(ref Fr z, ref Fr x, ref Fr y);

		[DllImport("mclbn256.dll")]
		public static extern void MBN_G1_clear(ref G1 x);
		[DllImport("mclbn256.dll")]
		public static extern int MBN_G1_setHexStr(ref G1 x, [In][MarshalAs(UnmanagedType.LPStr)] string buf, long bufSize);
		[DllImport("mclbn256.dll")]
		public static extern int MBN_G1_isValid(ref G1 x);
		[DllImport("mclbn256.dll")]
		public static extern int MBN_G1_isEqual(ref G1 x, ref G1 y);
		[DllImport("mclbn256.dll")]
		public static extern int MBN_G1_isZero(ref G1 x);
		[DllImport("mclbn256.dll")]
		public static extern int MBN_hashAndMapToG1(ref G1 x, [In][MarshalAs(UnmanagedType.LPStr)] string buf, long bufSize);
		[DllImport("mclbn256.dll")]
		public static extern long MBN_G1_getHexStr([Out]StringBuilder buf, long maxBufSize, ref G1 x);
		[DllImport("mclbn256.dll")]
		public static extern void MBN_G1_neg(ref G1 y, ref G1 x);
		[DllImport("mclbn256.dll")]
		public static extern void MBN_G1_dbl(ref G1 y, ref G1 x);
		[DllImport("mclbn256.dll")]
		public static extern void MBN_G1_add(ref G1 z, ref G1 x, ref G1 y);
		[DllImport("mclbn256.dll")]
		public static extern void MBN_G1_sub(ref G1 z, ref G1 x, ref G1 y);
		[DllImport("mclbn256.dll")]
		public static extern void MBN_G1_mul(ref G1 z, ref G1 x, ref Fr y);

		[DllImport("mclbn256.dll")]
		public static extern void MBN_G2_clear(ref G2 x);
		[DllImport("mclbn256.dll")]
		public static extern int MBN_G2_setHexStr(ref G2 x, [In][MarshalAs(UnmanagedType.LPStr)] string buf, long bufSize);
		[DllImport("mclbn256.dll")]
		public static extern int MBN_G2_isValid(ref G2 x);
		[DllImport("mclbn256.dll")]
		public static extern int MBN_G2_isEqual(ref G2 x, ref G2 y);
		[DllImport("mclbn256.dll")]
		public static extern int MBN_G2_isZero(ref G2 x);
		[DllImport("mclbn256.dll")]
		public static extern int MBN_hashAndMapToG2(ref G2 x, [In][MarshalAs(UnmanagedType.LPStr)] string buf, long bufSize);
		[DllImport("mclbn256.dll")]
		public static extern long MBN_G2_getHexStr([Out]StringBuilder buf, long maxBufSize, ref G2 x);
		[DllImport("mclbn256.dll")]
		public static extern void MBN_G2_neg(ref G2 y, ref G2 x);
		[DllImport("mclbn256.dll")]
		public static extern void MBN_G2_dbl(ref G2 y, ref G2 x);
		[DllImport("mclbn256.dll")]
		public static extern void MBN_G2_add(ref G2 z, ref G2 x, ref G2 y);
		[DllImport("mclbn256.dll")]
		public static extern void MBN_G2_sub(ref G2 z, ref G2 x, ref G2 y);
		[DllImport("mclbn256.dll")]
		public static extern void MBN_G2_mul(ref G2 z, ref G2 x, ref Fr y);

		[DllImport("mclbn256.dll")]
		public static extern void MBN_GT_clear(ref GT x);
        [DllImport("mclbn256.dll")]
        public static extern int MBN_GT_setDecStr(ref GT x, [In][MarshalAs(UnmanagedType.LPStr)] string buf, long bufSize);
        [DllImport("mclbn256.dll")]
		public static extern int MBN_GT_setHexStr(ref GT x, [In][MarshalAs(UnmanagedType.LPStr)] string buf, long bufSize);
		[DllImport("mclbn256.dll")]
		public static extern int MBN_GT_isEqual(ref GT x, ref GT y);
		[DllImport("mclbn256.dll")]
		public static extern int MBN_GT_isZero(ref GT x);
		[DllImport("mclbn256.dll")]
		public static extern int MBN_GT_isOne(ref GT x);
        [DllImport("mclbn256.dll")]
        public static extern long MBN_GT_getDecStr([Out]StringBuilder buf, long maxBufSize, ref GT x);
        [DllImport("mclbn256.dll")]
		public static extern long MBN_GT_getHexStr([Out]StringBuilder buf, long maxBufSize, ref GT x);
		[DllImport("mclbn256.dll")]
		public static extern void MBN_GT_neg(ref GT y, ref GT x);
		[DllImport("mclbn256.dll")]
		public static extern void MBN_GT_inv(ref GT y, ref GT x);
		[DllImport("mclbn256.dll")]
		public static extern void MBN_GT_add(ref GT z, ref GT x, ref GT y);
		[DllImport("mclbn256.dll")]
		public static extern void MBN_GT_sub(ref GT z, ref GT x, ref GT y);
		[DllImport("mclbn256.dll")]
		public static extern void MBN_GT_mul(ref GT z, ref GT x, ref GT y);
		[DllImport("mclbn256.dll")]
		public static extern void MBN_GT_div(ref GT z, ref GT x, ref GT y);

		[DllImport("mclbn256.dll")]
		public static extern void MBN_GT_pow(ref GT z, ref GT x, ref Fr y);
		[DllImport("mclbn256.dll")]
		public static extern void MBN_pairing(ref GT z, ref G1 x, ref G2 y);
		[DllImport("mclbn256.dll")]
		public static extern void MBN_finalExp(ref GT y, ref GT x);
		[DllImport("mclbn256.dll")]
		public static extern void MBN_millerLoop(ref GT z, ref G1 x, ref G2 y);

        public static void init()
        {
            const int curveFp254BNb = 0;
            const int maxUnitSize = 4;
            if (MBN_init(curveFp254BNb, maxUnitSize) != 0) {
                throw new InvalidOperationException("MBN_init");
            }
        }
        [StructLayout(LayoutKind.Sequential)]
		public struct Fr {
			private ulong v0, v1, v2, v3;
			public void Clear()
			{
				MBN_Fr_clear(ref this);
			}
			public void SetInt(int x)
			{
				MBN_Fr_setInt(ref this, x);
			}
			public void SetDecStr(string s)
			{
				if (MBN_Fr_setDecStr(ref this, s, s.Length) != 0) {
					throw new ArgumentException("MBN_Fr_setDecStr", s);
				}
			}
            public void SetHexStr(string s)
            {
                if (MBN_Fr_setHexStr(ref this, s, s.Length) != 0) {
                    throw new ArgumentException("MBN_Fr_setHexStr", s);
                }
            }
            public bool IsValid()
			{
				return MBN_Fr_isValid(ref this) == 1;
			}
			public bool Equals(Fr rhs)
			{
				return MBN_Fr_isEqual(ref this, ref rhs) == 1;
			}
			public bool IsZero()
			{
				return MBN_Fr_isZero(ref this) == 1;
			}
			public bool IsOne()
			{
				return MBN_Fr_isOne(ref this) == 1;
			}
			public void SetByCSPRNG()
			{
				MBN_Fr_setByCSPRNG(ref this);
			}
			public void SetHashOf(String s)
			{
                if (MBN_hashToFr(ref this, s, s.Length) != 0) {
                    throw new InvalidOperationException("MBN_hashToFr:" + s);
                }
			}
			public string GetDecStr()
			{
				StringBuilder sb = new StringBuilder(1024);
                long size = MBN_Fr_getDecStr(sb, sb.Capacity, ref this);
                if (size == 0) {
                    throw new InvalidOperationException("MBN_Fr_getDecStr:");
                }
                return sb.ToString();
			}
            public string GetHexStr()
            {
                StringBuilder sb = new StringBuilder(1024);
                long size = MBN_Fr_getHexStr(sb, sb.Capacity, ref this);
                if (size == 0) {
                    throw new InvalidOperationException("MBN_Fr_getHexStr:");
                }
                return sb.ToString();
            }
            public void Neg(Fr x)
			{
				MBN_Fr_neg(ref this, ref x);
			}
			public void Inv(Fr x)
			{
				MBN_Fr_inv(ref this, ref x);
			}
			public void Add(Fr x, Fr y)
			{
				MBN_Fr_add(ref this, ref x, ref y);
			}
			public  void Sub(Fr x, Fr y)
			{
				MBN_Fr_sub(ref this, ref x, ref y);
			}
			public  void Mul(Fr x, Fr y)
			{
				MBN_Fr_mul(ref this, ref x, ref y);
			}
			public  void Div(Fr x, Fr y)
			{
				MBN_Fr_div(ref this, ref x, ref y);
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
				MBN_G1_clear(ref this);
			}
			public void setHexStr(String s)
			{
				if (MBN_G1_setHexStr(ref this, s, s.Length) != 0) {
					throw new ArgumentException("MBN_G1_setStr:" + s);
				}
			}
			public bool IsValid()
			{
				return MBN_G1_isValid(ref this) == 1;
			}
			public bool Equals(G1 rhs)
			{
				return MBN_G1_isEqual(ref this, ref rhs) == 1;
			}
			public bool IsZero()
			{
				return MBN_G1_isZero(ref this) == 1;
			}
			public void HashAndMapTo(String s)
			{
				if (MBN_hashAndMapToG1(ref this, s, s.Length) != 0) {
					throw new ArgumentException("MBN_hashAndMapToG1:" + s);
				}
			}
			public string GetHexStr()
			{
				StringBuilder sb = new StringBuilder(1024);
                long size = MBN_G1_getHexStr(sb, sb.Capacity, ref this);
                if (size == 0) {
                    throw new InvalidOperationException("MBN_G1_getHexStr:");
                }
                return sb.ToString();
			}
			public void Neg(G1 x)
			{
				MBN_G1_neg(ref this, ref x);
			}
			public void Dbl(G1 x)
			{
				MBN_G1_dbl(ref this, ref x);
			}
			public void Add(G1 x, G1 y)
			{
				MBN_G1_add(ref this, ref x, ref y);
			}
			public void Sub(G1 x, G1 y)
			{
				MBN_G1_sub(ref this, ref x, ref y);
			}
			public void Mul(G1 x, Fr y)
			{
				MBN_G1_mul(ref this, ref x, ref y);
			}
		}
		[StructLayout(LayoutKind.Sequential)]
		public struct G2 {
			private ulong v00, v01, v02, v03, v04, v05, v06, v07, v08, v09, v10, v11;
			private ulong v12, v13, v14, v15, v16, v17, v18, v19, v20, v21, v22, v23;
			public void Clear()
			{
				MBN_G2_clear(ref this);
			}
			public void setStr(String s)
			{
				if (MBN_G2_setHexStr(ref this, s, s.Length) != 0) {
					throw new ArgumentException("MBN_G2_setHexStr:" + s);
				}
			}
			public bool IsValid()
			{
				return MBN_G2_isValid(ref this) == 1;
			}
			public bool Equals(G2 rhs)
			{
				return MBN_G2_isEqual(ref this, ref rhs) == 1;
			}
			public bool IsZero()
			{
				return MBN_G2_isZero(ref this) == 1;
			}
			public void HashAndMapTo(String s)
			{
				if (MBN_hashAndMapToG2(ref this, s, s.Length) != 0) {
					throw new ArgumentException("MBN_hashAndMapToG2:" + s);
				}
			}
            public string GetHexStr()
            {
                StringBuilder sb = new StringBuilder(1024);
                long size = MBN_G2_getHexStr(sb, sb.Capacity, ref this);
                if (size == 0) {
                    throw new InvalidOperationException("MBN_G2_getHexStr:");
                }
                return sb.ToString();
            }
            public void Neg(G2 x)
			{
				MBN_G2_neg(ref this, ref x);
			}
			public void Dbl(G2 x)
			{
				MBN_G2_dbl(ref this, ref x);
			}
			public void Add(G2 x, G2 y)
			{
				MBN_G2_add(ref this, ref x, ref y);
			}
			public void Sub(G2 x, G2 y)
			{
				MBN_G2_sub(ref this, ref x, ref y);
			}
			public void Mul(G2 x, Fr y)
			{
				MBN_G2_mul(ref this, ref x, ref y);
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
				MBN_GT_clear(ref this);
			}
            public void setDecStr(String s)
            {
                if (MBN_GT_setDecStr(ref this, s, s.Length) != 0) {
                    throw new ArgumentException("MBN_GT_setDecStr:" + s);
                }
            }
            public void setHexStr(String s)
			{
				if (MBN_GT_setHexStr(ref this, s, s.Length) != 0) {
					throw new ArgumentException("MBN_GT_setHexStr:" + s);
				}
			}
			public bool Equals(GT rhs)
			{
				return MBN_GT_isEqual(ref this, ref rhs) == 1;
			}
			public bool IsZero()
			{
				return MBN_GT_isZero(ref this) == 1;
			}
			public bool IsOne()
			{
				return MBN_GT_isOne(ref this) == 1;
			}
            public string GetDecStr()
            {
                StringBuilder sb = new StringBuilder(1024);
                long size = MBN_GT_getDecStr(sb, sb.Capacity, ref this);
                if (size == 0) {
                    throw new InvalidOperationException("MBN_GT_getDecStr:");
                }
                return sb.ToString();
            }
            public string GetHexStr()
            {
                StringBuilder sb = new StringBuilder(1024);
                long size = MBN_GT_getHexStr(sb, sb.Capacity, ref this);
                if (size == 0) {
                    throw new InvalidOperationException("MBN_GT_getHexStr:");
                }
                return sb.ToString();
            }
            public void Neg(GT x)
			{
				MBN_GT_neg(ref this, ref x);
			}
			public void Inv(GT x)
			{
				MBN_GT_inv(ref this, ref x);
			}
			public void Add(GT x, GT y)
			{
				MBN_GT_add(ref this, ref x, ref this);
			}
			public void Sub(GT x, GT y)
			{
				MBN_GT_sub(ref this, ref x, ref this);
			}
			public void Mul(GT x, GT y)
			{
				MBN_GT_mul(ref this, ref x, ref this);
			}
			public void Div(GT x, GT y)
			{
				MBN_GT_div(ref this, ref x, ref this);
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
				MBN_GT_pow(ref this, ref x, ref y);
			}
			public void Pairing(G1 x, G2 y)
			{
				MBN_pairing(ref this, ref x, ref y);
			}
            public void FinalExp(GT x)
            {
                MBN_finalExp(ref this, ref x);
            }
            public void MillerLoop(G1 x, G2 y)
			{
				MBN_millerLoop(ref this, ref x, ref y);
			}
		}
	}
}
