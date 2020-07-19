þ½Ž¿using System;
using System.Text;
using System.Runtime.InteropServices;

namespace mcl {
    public class MCL {
        public const int BN254 = 0;
        public const int BN_SNARK = 4;
        public const int BLS12_381 = 5;
        public const int FR_UNIT_SIZE = 4;
        public const int FP_UNIT_SIZE = 6; // 4 if mclbn256.dll is used

        public const int G1_UNIT_SIZE = FP_UNIT_SIZE * 3;
        public const int G2_UNIT_SIZE = FP_UNIT_SIZE * 2 * 3;
        public const int GT_UNIT_SIZE = FP_UNIT_SIZE * 12;

        public const string dllName = "mclbn384_256";
        [DllImport(dllName)] public static extern int mclBn_init(int curve, int compiledTimeVar);
        [DllImport(dllName)] public static extern void mclBnFr_clear(ref Fr x);
        [DllImport(dllName)] public static extern void mclBnFr_setInt(ref Fr y, int x);
        [DllImport(dllName)] public static extern int mclBnFr_setStr(ref Fr x, [In][MarshalAs(UnmanagedType.LPStr)] string buf, long bufSize, int ioMode);
        [DllImport(dllName)] public static extern int mclBnFr_isValid(ref Fr x);
        [DllImport(dllName)] public static extern int mclBnFr_isEqual(ref Fr x, ref Fr y);
        [DllImport(dllName)] public static extern int mclBnFr_isZero(ref Fr x);
        [DllImport(dllName)] public static extern int mclBnFr_isOne(ref Fr x);
        [DllImport(dllName)] public static extern void mclBnFr_setByCSPRNG(ref Fr x);

        [DllImport(dllName)] public static extern int mclBnFr_setHashOf(ref Fr x, [In][MarshalAs(UnmanagedType.LPStr)] string buf, long bufSize);
        [DllImport(dllName)] public static extern int mclBnFr_getStr([Out] StringBuilder buf, long maxBufSize, ref Fr x, int ioMode);

        [DllImport(dllName)] public static extern void mclBnFr_neg(ref Fr y, ref Fr x);
        [DllImport(dllName)] public static extern void mclBnFr_inv(ref Fr y, ref Fr x);
        [DllImport(dllName)] public static extern void mclBnFr_add(ref Fr z, ref Fr x, ref Fr y);
        [DllImport(dllName)] public static extern void mclBnFr_sub(ref Fr z, ref Fr x, ref Fr y);
        [DllImport(dllName)] public static extern void mclBnFr_mul(ref Fr z, ref Fr x, ref Fr y);
        [DllImport(dllName)] public static extern void mclBnFr_div(ref Fr z, ref Fr x, ref Fr y);

        [DllImport(dllName)] public static extern void mclBnFp_clear(ref Fp x);
        [DllImport(dllName)] public static extern void mclBnFp_setInt(ref Fp y, int x);
        [DllImport(dllName)] public static extern int mclBnFp_setStr(ref Fp x, [In][MarshalAs(UnmanagedType.LPStr)] string buf, long bufSize, int ioMode);
        [DllImport(dllName)] public static extern int mclBnFp_isValid(ref Fp x);
        [DllImport(dllName)] public static extern int mclBnFp_isEqual(ref Fp x, ref Fp y);
        [DllImport(dllName)] public static extern int mclBnFp_isZero(ref Fp x);
        [DllImport(dllName)] public static extern int mclBnFp_isOne(ref Fp x);
        [DllImport(dllName)] public static extern void mclBnFp_setByCSPRNG(ref Fp x);

        [DllImport(dllName)] public static extern int mclBnFp_setHashOf(ref Fp x, [In][MarshalAs(UnmanagedType.LPStr)] string buf, long bufSize);
        [DllImport(dllName)] public static extern int mclBnFp_getStr([Out] StringBuilder buf, long maxBufSize, ref Fp x, int ioMode);

        [DllImport(dllName)] public static extern void mclBnFp_neg(ref Fp y, ref Fp x);
        [DllImport(dllName)] public static extern void mclBnFp_inv(ref Fp y, ref Fp x);
        [DllImport(dllName)] public static extern void mclBnFp_add(ref Fp z, ref Fp x, ref Fp y);
        [DllImport(dllName)] public static extern void mclBnFp_sub(ref Fp z, ref Fp x, ref Fp y);
        [DllImport(dllName)] public static extern void mclBnFp_mul(ref Fp z, ref Fp x, ref Fp y);
        [DllImport(dllName)] public static extern void mclBnFp_div(ref Fp z, ref Fp x, ref Fp y);
        [DllImport(dllName)] public static extern void mclBnG1_clear(ref G1 x);
        [DllImport(dllName)] public static extern int mclBnG1_setStr(ref G1 x, [In][MarshalAs(UnmanagedType.LPStr)] string buf, long bufSize, int ioMode);
        [DllImport(dllName)] public static extern int mclBnG1_isValid(ref G1 x);
        [DllImport(dllName)] public static extern int mclBnG1_isEqual(ref G1 x, ref G1 y);
        [DllImport(dllName)] public static extern int mclBnG1_isZero(ref G1 x);
        [DllImport(dllName)] public static extern int mclBnG1_hashAndMapTo(ref G1 x, [In][MarshalAs(UnmanagedType.LPStr)] string buf, long bufSize);
        [DllImport(dllName)] public static extern long mclBnG1_getStr([Out] StringBuilder buf, long maxBufSize, ref G1 x, int ioMode);
        [DllImport(dllName)] public static extern void mclBnG1_neg(ref G1 y, ref G1 x);
        [DllImport(dllName)] public static extern void mclBnG1_dbl(ref G1 y, ref G1 x);
        [DllImport(dllName)] public static extern void mclBnG1_add(ref G1 z, ref G1 x, ref G1 y);
        [DllImport(dllName)] public static extern void mclBnG1_sub(ref G1 z, ref G1 x, ref G1 y);
        [DllImport(dllName)] public static extern void mclBnG1_mul(ref G1 z, ref G1 x, ref Fr y);
        [DllImport(dllName)] public static extern void mclBnG2_clear(ref G2 x);
        [DllImport(dllName)] public static extern int mclBnG2_setStr(ref G2 x, [In][MarshalAs(UnmanagedType.LPStr)] string buf, long bufSize, int ioMode);
        [DllImport(dllName)] public static extern int mclBnG2_isValid(ref G2 x);
        [DllImport(dllName)] public static extern int mclBnG2_isEqual(ref G2 x, ref G2 y);
        [DllImport(dllName)] public static extern int mclBnG2_isZero(ref G2 x);
        [DllImport(dllName)] public static extern int mclBnG2_hashAndMapTo(ref G2 x, [In][MarshalAs(UnmanagedType.LPStr)] string buf, long bufSize);
        [DllImport(dllName)] public static extern long mclBnG2_getStr([Out] StringBuilder buf, long maxBufSize, ref G2 x, int ioMode);
        [DllImport(dllName)] public static extern void mclBnG2_neg(ref G2 y, ref G2 x);
        [DllImport(dllName)] public static extern void mclBnG2_dbl(ref G2 y, ref G2 x);
        [DllImport(dllName)] public static extern void mclBnG2_add(ref G2 z, ref G2 x, ref G2 y);
        [DllImport(dllName)] public static extern void mclBnG2_sub(ref G2 z, ref G2 x, ref G2 y);
        [DllImport(dllName)] public static extern void mclBnG2_mul(ref G2 z, ref G2 x, ref Fr y);

        [DllImport(dllName)] public static extern void mclBnGT_clear(ref GT x);
        [DllImport(dllName)] public static extern int mclBnGT_setStr(ref GT x, [In][MarshalAs(UnmanagedType.LPStr)] string buf, long bufSize, int ioMode);
        [DllImport(dllName)] public static extern int mclBnGT_isEqual(ref GT x, ref GT y);
        [DllImport(dllName)] public static extern int mclBnGT_isZero(ref GT x);
        [DllImport(dllName)] public static extern int mclBnGT_isOne(ref GT x);
        [DllImport(dllName)] public static extern long mclBnGT_getStr([Out] StringBuilder buf, long maxBufSize, ref GT x, int ioMode);
        [DllImport(dllName)] public static extern void mclBnGT_neg(ref GT y, ref GT x);
        [DllImport(dllName)] public static extern void mclBnGT_inv(ref GT y, ref GT x);
        [DllImport(dllName)] public static extern void mclBnGT_add(ref GT z, ref GT x, ref GT y);
        [DllImport(dllName)] public static extern void mclBnGT_sub(ref GT z, ref GT x, ref GT y);
        [DllImport(dllName)] public static extern void mclBnGT_mul(ref GT z, ref GT x, ref GT y);
        [DllImport(dllName)] public static extern void mclBnGT_div(ref GT z, ref GT x, ref GT y);
        [DllImport(dllName)] public static extern void mclBnGT_pow(ref GT z, ref GT x, ref Fr y);
        [DllImport(dllName)] public static extern void mclBn_pairing(ref GT z, ref G1 x, ref G2 y);
        [DllImport(dllName)] public static extern void mclBn_finalExp(ref GT y, ref GT x);
        [DllImport(dllName)] public static extern void mclBn_millerLoop(ref GT z, ref G1 x, ref G2 y);
        [DllImport(dllName)] public static extern int mclBnFp_setLittleEndianMod(ref Fp y, [In][MarshalAs(UnmanagedType.LPStr)] string buf, long bufSize);
        [DllImport(dllName)] public static extern int mclBnFr_setLittleEndianMod(ref Fr y, [In][MarshalAs(UnmanagedType.LPStr)] string buf, long bufSize);
        [DllImport(dllName)] public static extern int mclBnFp_serialize([Out] StringBuilder buf, long maxBufSiz, ref Fr x);
        [DllImport(dllName)] public static extern int mclBnFr_serialize([Out] StringBuilder buf, long maxBufSiz, ref Fr x);
        [DllImport(dllName)] public static extern int mclBnG1_serialize([Out] StringBuilder buf, long maxBufSiz, ref G1 x);
        [DllImport(dllName)] public static extern int mclBnG2_serialize([Out] StringBuilder buf, long maxBufSiz, ref G2 x);
        [DllImport(dllName)] public static extern int mclBnGT_serialize([Out] StringBuilder buf, long maxBufSiz, ref GT x);
        [DllImport(dllName)] public static extern int mclBnFr_deserialize(ref Fr x, [In][MarshalAs(UnmanagedType.LPStr)] string buf, long bufSize);
        [DllImport(dllName)] public static extern int mclBnFp_deserialize(ref Fp x, [In][MarshalAs(UnmanagedType.LPStr)] string buf, long bufSize);
        [DllImport(dllName)] public static extern int mclBnG1_deserialize(ref G1 x, [In][MarshalAs(UnmanagedType.LPStr)] string buf, long bufSize);
        [DllImport(dllName)] public static extern int mclBnG2_deserialize(ref G2 x, [In][MarshalAs(UnmanagedType.LPStr)] string buf, long bufSize);
        [DllImport(dllName)] public static extern int mclBnGT_deserialize(ref GT x, [In][MarshalAs(UnmanagedType.LPStr)] string buf, long bufSize);

        public static void Init(int curveType = BN254)
        {
            if (!System.Environment.Is64BitProcess) {
                throw new PlatformNotSupportedException("not 64-bit system");
            }
            const int COMPILED_TIME_VAR = FR_UNIT_SIZE * 10 + FP_UNIT_SIZE;
            if (mclBn_init(curveType, COMPILED_TIME_VAR) != 0) {
                throw new ArgumentException("mclBn_init");
            }
        }
        [StructLayout(LayoutKind.Sequential)]
        struct U128 {
            private ulong v0, v1;
        }

        [StructLayout(LayoutKind.Sequential)]
        public struct Fr {
            private U128 v0, v1;
            public void Clear()
            {
                mclBnFr_clear(ref this);
            }
            public void SetInt(int x)
            {
                mclBnFr_setInt(ref this, x);
            }
            public void SetStr(string s, int ioMode)
            {
                if (mclBnFr_setStr(ref this, s, s.Length, ioMode) != 0) {
                    throw new ArgumentException("mclBnFr_setStr" + s);
                }
            }
            public bool IsValid()
            {
                return mclBnFr_isValid(ref this) == 1;
            }
            public bool Equals(Fr rhs)
            {
                return mclBnFr_isEqual(ref this, ref rhs) == 1;
            }
            public bool IsZero()
            {
                return mclBnFr_isZero(ref this) == 1;
            }
            public bool IsOne()
            {
                return mclBnFr_isOne(ref this) == 1;
            }
            public void SetByCSPRNG()
            {
                mclBnFr_setByCSPRNG(ref this);
            }
            public void SetHashOf(String s)
            {
                if (mclBnFr_setHashOf(ref this, s, s.Length) != 0) {
                    throw new InvalidOperationException("mclBnFr_setHashOf:" + s);
                }
            }
            public string GetStr(int ioMode)
            {
                StringBuilder sb = new StringBuilder(1024);
                long size = mclBnFr_getStr(sb, sb.Capacity, ref this, ioMode);
                if (size == 0) {
                    throw new InvalidOperationException("mclBnFr_getStr:");
                }
                return sb.ToString();
            }
            public void Neg(Fr x)
            {
                mclBnFr_neg(ref this, ref x);
            }
            public void Inv(Fr x)
            {
                mclBnFr_inv(ref this, ref x);
            }
            public void Add(Fr x, Fr y)
            {
                mclBnFr_add(ref this, ref x, ref y);
            }
            public void Sub(Fr x, Fr y)
            {
                mclBnFr_sub(ref this, ref x, ref y);
            }
            public void Mul(Fr x, Fr y)
            {
                mclBnFr_mul(ref this, ref x, ref y);
            }
            public void Div(Fr x, Fr y)
            {
                mclBnFr_div(ref this, ref x, ref y);
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
        public struct Fp {
            private U128 v0, v1, v2;
            public void Clear()
            {
                mclBnFp_clear(ref this);
            }
            public void SetInt(int x)
            {
                mclBnFp_setInt(ref this, x);
            }
            public void SetStr(string s, int ioMode)
            {
                if (mclBnFp_setStr(ref this, s, s.Length, ioMode) != 0) {
                    throw new ArgumentException("mclBnFp_setStr" + s);
                }
            }
            public bool IsValid()
            {
                return mclBnFp_isValid(ref this) == 1;
            }
            public bool Equals(Fp rhs)
            {
                return mclBnFp_isEqual(ref this, ref rhs) == 1;
            }
            public bool IsZero()
            {
                return mclBnFp_isZero(ref this) == 1;
            }
            public bool IsOne()
            {
                return mclBnFp_isOne(ref this) == 1;
            }
            public void SetByCSPRNG()
            {
                mclBnFp_setByCSPRNG(ref this);
            }
            public string GetStr(int ioMode)
            {
                StringBuilder sb = new StringBuilder(1024);
                long size = mclBnFp_getStr(sb, sb.Capacity, ref this, ioMode);
                if (size == 0) {
                    throw new InvalidOperationException("mclBnFp_getStr:");
                }
                return sb.ToString();
            }
            public void Neg(Fp x)
            {
                mclBnFp_neg(ref this, ref x);
            }
            public void Inv(Fp x)
            {
                mclBnFp_inv(ref this, ref x);
            }
            public void Add(Fp x, Fp y)
            {
                mclBnFp_add(ref this, ref x, ref y);
            }
            public void Sub(Fp x, Fp y)
            {
                mclBnFp_sub(ref this, ref x, ref y);
            }
            public void Mul(Fp x, Fp y)
            {
                mclBnFp_mul(ref this, ref x, ref y);
            }
            public void Div(Fp x, Fp y)
            {
                mclBnFp_div(ref this, ref x, ref y);
            }
            public static Fp operator -(Fp x)
            {
                Fp y = new Fp();
                y.Neg(x);
                return y;
            }
            public static Fp operator +(Fp x, Fp y)
            {
                Fp z = new Fp();
                z.Add(x, y);
                return z;
            }
            public static Fp operator -(Fp x, Fp y)
            {
                Fp z = new Fp();
                z.Sub(x, y);
                return z;
            }
            public static Fp operator *(Fp x, Fp y)
            {
                Fp z = new Fp();
                z.Mul(x, y);
                return z;
            }
            public static Fp operator /(Fp x, Fp y)
            {
                Fp z = new Fp();
                z.Div(x, y);
                return z;
            }
        }
        [StructLayout(LayoutKind.Sequential)]
        public struct Fp2 {
            private Fp a, b;
        }
        [StructLayout(LayoutKind.Sequential)]
        public struct G1 {
            private Fp x, y, z;
            public void Clear()
            {
                mclBnG1_clear(ref this);
            }
            public void SetStr(String s, int ioMode)
            {
                if (mclBnG1_setStr(ref this, s, s.Length, ioMode) != 0) {
                    throw new ArgumentException("mclBnG1_setStr:" + s);
                }
            }
            public bool IsValid()
            {
                return mclBnG1_isValid(ref this) == 1;
            }
            public bool Equals(G1 rhs)
            {
                return mclBnG1_isEqual(ref this, ref rhs) == 1;
            }
            public bool IsZero()
            {
                return mclBnG1_isZero(ref this) == 1;
            }
            public void HashAndMapTo(String s)
            {
                if (mclBnG1_hashAndMapTo(ref this, s, s.Length) != 0) {
                    throw new ArgumentException("mclBnG1_hashAndMapTo:" + s);
                }
            }
            public string GetStr(int ioMode)
            {
                StringBuilder sb = new StringBuilder(1024);
                long size = mclBnG1_getStr(sb, sb.Capacity, ref this, ioMode);
                if (size == 0) {
                    throw new InvalidOperationException("mclBnG1_getStr:");
                }
                return sb.ToString();
            }
            public void Neg(G1 x)
            {
                mclBnG1_neg(ref this, ref x);
            }
            public void Dbl(G1 x)
            {
                mclBnG1_dbl(ref this, ref x);
            }
            public void Add(G1 x, G1 y)
            {
                mclBnG1_add(ref this, ref x, ref y);
            }
            public void Sub(G1 x, G1 y)
            {
                mclBnG1_sub(ref this, ref x, ref y);
            }
            public void Mul(G1 x, Fr y)
            {
                mclBnG1_mul(ref this, ref x, ref y);
            }
        }
        [StructLayout(LayoutKind.Sequential)]
        public struct G2 {
            private Fp2 x, y, z;
            public void Clear()
            {
                mclBnG2_clear(ref this);
            }
            public void SetStr(String s, int ioMode)
            {
                if (mclBnG2_setStr(ref this, s, s.Length, ioMode) != 0) {
                    throw new ArgumentException("mclBnG2_setStr:" + s);
                }
            }
            public bool IsValid()
            {
                return mclBnG2_isValid(ref this) == 1;
            }
            public bool Equals(G2 rhs)
            {
                return mclBnG2_isEqual(ref this, ref rhs) == 1;
            }
            public bool IsZero()
            {
                return mclBnG2_isZero(ref this) == 1;
            }
            public void HashAndMapTo(String s)
            {
                if (mclBnG2_hashAndMapTo(ref this, s, s.Length) != 0) {
                    throw new ArgumentException("mclBnG2_hashAndMapTo:" + s);
                }
            }
            public string GetStr(int ioMode)
            {
                StringBuilder sb = new StringBuilder(1024);
                long size = mclBnG2_getStr(sb, sb.Capacity, ref this, ioMode);
                if (size == 0) {
                    throw new InvalidOperationException("mclBnG2_getStr:");
                }
                return sb.ToString();
            }
            public void Neg(G2 x)
            {
                mclBnG2_neg(ref this, ref x);
            }
            public void Dbl(G2 x)
            {
                mclBnG2_dbl(ref this, ref x);
            }
            public void Add(G2 x, G2 y)
            {
                mclBnG2_add(ref this, ref x, ref y);
            }
            public void Sub(G2 x, G2 y)
            {
                mclBnG2_sub(ref this, ref x, ref y);
            }
            public void Mul(G2 x, Fr y)
            {
                mclBnG2_mul(ref this, ref x, ref y);
            }
        }
        [StructLayout(LayoutKind.Sequential)]
        public struct GT {
            private Fp v00, v01, v02, v03, v04, v05, v06, v07, v08, v09, v10, v11;
            public void Clear()
            {
                mclBnGT_clear(ref this);
            }
            public void SetStr(String s, int ioMode)
            {
                if (mclBnGT_setStr(ref this, s, s.Length, ioMode) != 0) {
                    throw new ArgumentException("mclBnGT_setStr:" + s);
                }
            }
            public bool Equals(GT rhs)
            {
                return mclBnGT_isEqual(ref this, ref rhs) == 1;
            }
            public bool IsZero()
            {
                return mclBnGT_isZero(ref this) == 1;
            }
            public bool IsOne()
            {
                return mclBnGT_isOne(ref this) == 1;
            }
            public string GetStr(int ioMode)
            {
                StringBuilder sb = new StringBuilder(1024);
                long size = mclBnGT_getStr(sb, sb.Capacity, ref this, ioMode);
                if (size == 0) {
                    throw new InvalidOperationException("mclBnGT_getStr:");
                }
                return sb.ToString();
            }
            public void Neg(GT x)
            {
                mclBnGT_neg(ref this, ref x);
            }
            public void Inv(GT x)
            {
                mclBnGT_inv(ref this, ref x);
            }
            public void Add(GT x, GT y)
            {
                mclBnGT_add(ref this, ref x, ref y);
            }
            public void Sub(GT x, GT y)
            {
                mclBnGT_sub(ref this, ref x, ref y);
            }
            public void Mul(GT x, GT y)
            {
                mclBnGT_mul(ref this, ref x, ref y);
            }
            public void Div(GT x, GT y)
            {
                mclBnGT_div(ref this, ref x, ref y);
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
                mclBnGT_pow(ref this, ref x, ref y);
            }
            public void Pairing(G1 x, G2 y)
            {
                mclBn_pairing(ref this, ref x, ref y);
            }
            public void FinalExp(GT x)
            {
                mclBn_finalExp(ref this, ref x);
            }
            public void MillerLoop(G1 x, G2 y)
            {
                mclBn_millerLoop(ref this, ref x, ref y);
            }
        }
    }
}
