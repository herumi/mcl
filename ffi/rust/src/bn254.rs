//! Safe Rust wrappers for BN254 curve operations.
//!
//! Provides types and functions for G1/G2 point arithmetic and pairings,
//! with serialization matching the Ethereum precompile format (big-endian).

use crate::ffi;
use std::ops::{Add, Mul, Neg, Sub};
use std::sync::OnceLock;

/// MCL_BN_SNARK1 curve type constant (a.k.a. alt_bn128 / bn256 / BN254 in Ethereum).
const MCL_BN_SNARK1: i32 = 4;

/// Compiled-time variable: FR_UNIT_SIZE(4) * 10 + FP_UNIT_SIZE(4) = 44.
const MCLBN_COMPILED_TIME_VAR: i32 = 44;

/// Size of a field element in bytes (256 bits).
const FP_SIZE: usize = 32;

static INIT: OnceLock<bool> = OnceLock::new();

/// Initialize the BN254 curve.
///
/// Must be called before any other operations in this module.
/// Safe to call multiple times; initialization happens only once.
/// Returns `true` if initialization succeeded.
pub fn init() -> bool {
    *INIT.get_or_init(|| unsafe { ffi::mclBn_init(MCL_BN_SNARK1, MCLBN_COMPILED_TIME_VAR) == 0 })
}

/// Returns the mcl library version.
pub fn get_version() -> u32 {
    unsafe { ffi::mclBn_getVersion() }
}

// ── Helper ───────────────────────────────────────────────────────────────────

/// Reverse a byte slice in place (big-endian <-> little-endian).
#[inline]
fn reverse_32(bytes: &[u8; FP_SIZE]) -> [u8; FP_SIZE] {
    let mut out = *bytes;
    out.reverse();
    out
}

// ── Fp (base field element) ──────────────────────────────────────────────────

/// Base field element of BN254.
#[derive(Clone, Copy)]
#[repr(transparent)]
pub struct Fp(pub(crate) ffi::MclBnFp);

impl Fp {
    /// The additive identity (zero).
    pub fn zero() -> Self {
        let mut fp = Self(ffi::MclBnFp { d: [0u64; 4] });
        unsafe { ffi::mclBnFp_clear(&mut fp.0) };
        fp
    }

    /// The multiplicative identity (one).
    pub fn one() -> Self {
        let mut fp = Self(ffi::MclBnFp { d: [0u64; 4] });
        unsafe { ffi::mclBnFp_setInt32(&mut fp.0, 1) };
        fp
    }

    pub fn is_zero(&self) -> bool {
        unsafe { ffi::mclBnFp_isZero(&self.0) == 1 }
    }

    /// Deserialize from 32-byte big-endian representation.
    /// Returns `None` if the value is not a valid field element (>= modulus).
    pub fn from_be_bytes(bytes: &[u8; FP_SIZE]) -> Option<Self> {
        let le = reverse_32(bytes);
        let mut fp = Self(ffi::MclBnFp { d: [0u64; 4] });
        let n = unsafe { ffi::mclBnFp_deserialize(&mut fp.0, le.as_ptr(), FP_SIZE) };
        if n == 0 {
            None
        } else {
            Some(fp)
        }
    }

    /// Serialize to 32-byte big-endian representation.
    pub fn to_be_bytes(&self) -> [u8; FP_SIZE] {
        let mut buf = [0u8; FP_SIZE];
        let n = unsafe { ffi::mclBnFp_serialize(buf.as_mut_ptr(), FP_SIZE, &self.0) };
        assert_eq!(n, FP_SIZE);
        buf.reverse();
        buf
    }
}

impl PartialEq for Fp {
    fn eq(&self, other: &Self) -> bool {
        unsafe { ffi::mclBnFp_isEqual(&self.0, &other.0) == 1 }
    }
}

impl Eq for Fp {}

// ── Fr (scalar field element) ────────────────────────────────────────────────

/// Scalar field element of the BN254 curve.
#[derive(Clone, Copy)]
#[repr(transparent)]
pub struct Fr(pub(crate) ffi::MclBnFr);

impl Fr {
    /// The additive identity (zero).
    pub fn zero() -> Self {
        let mut fr = Self(ffi::MclBnFr { d: [0u64; 4] });
        unsafe { ffi::mclBnFr_clear(&mut fr.0) };
        fr
    }

    /// The multiplicative identity (one).
    pub fn one() -> Self {
        let mut fr = Self(ffi::MclBnFr { d: [0u64; 4] });
        unsafe { ffi::mclBnFr_setInt32(&mut fr.0, 1) };
        fr
    }

    pub fn is_zero(&self) -> bool {
        unsafe { ffi::mclBnFr_isZero(&self.0) == 1 }
    }

    pub fn is_one(&self) -> bool {
        unsafe { ffi::mclBnFr_isOne(&self.0) == 1 }
    }

    /// Deserialize from 32-byte big-endian representation.
    /// The value is reduced modulo the scalar field order.
    pub fn from_be_bytes(bytes: &[u8; 32]) -> Self {
        let le = reverse_32(bytes);
        let mut fr = Self(ffi::MclBnFr { d: [0u64; 4] });
        unsafe { ffi::mclBnFr_setLittleEndianMod(&mut fr.0, le.as_ptr(), 32) };
        fr
    }

    /// Serialize to 32-byte big-endian representation.
    pub fn to_be_bytes(&self) -> [u8; 32] {
        let mut buf = [0u8; 32];
        let n = unsafe { ffi::mclBnFr_serialize(buf.as_mut_ptr(), 32, &self.0) };
        assert_eq!(n, 32);
        buf.reverse();
        buf
    }

    /// Generate a random scalar using a CSPRNG.
    pub fn random() -> Self {
        let mut fr = Self(ffi::MclBnFr { d: [0u64; 4] });
        let ret = unsafe { ffi::mclBnFr_setByCSPRNG(&mut fr.0) };
        assert_eq!(ret, 0, "CSPRNG failed");
        fr
    }

    /// Multiplicative inverse. Panics if self is zero.
    pub fn inv(&self) -> Self {
        let mut result = Self(ffi::MclBnFr { d: [0u64; 4] });
        unsafe { ffi::mclBnFr_inv(&mut result.0, &self.0) };
        result
    }
}

impl PartialEq for Fr {
    fn eq(&self, other: &Self) -> bool {
        unsafe { ffi::mclBnFr_isEqual(&self.0, &other.0) == 1 }
    }
}

impl Eq for Fr {}

impl Add for Fr {
    type Output = Fr;
    fn add(self, rhs: Fr) -> Fr {
        let mut z = Fr(ffi::MclBnFr { d: [0u64; 4] });
        unsafe { ffi::mclBnFr_add(&mut z.0, &self.0, &rhs.0) };
        z
    }
}

impl Sub for Fr {
    type Output = Fr;
    fn sub(self, rhs: Fr) -> Fr {
        let mut z = Fr(ffi::MclBnFr { d: [0u64; 4] });
        unsafe { ffi::mclBnFr_sub(&mut z.0, &self.0, &rhs.0) };
        z
    }
}

impl Mul for Fr {
    type Output = Fr;
    fn mul(self, rhs: Fr) -> Fr {
        let mut z = Fr(ffi::MclBnFr { d: [0u64; 4] });
        unsafe { ffi::mclBnFr_mul(&mut z.0, &self.0, &rhs.0) };
        z
    }
}

impl Neg for Fr {
    type Output = Fr;
    fn neg(self) -> Fr {
        let mut z = Fr(ffi::MclBnFr { d: [0u64; 4] });
        unsafe { ffi::mclBnFr_neg(&mut z.0, &self.0) };
        z
    }
}

// ── G1 (curve point over Fp) ─────────────────────────────────────────────────

/// A point on the BN254 G1 curve (over Fp).
#[derive(Clone, Copy)]
#[repr(transparent)]
pub struct G1(pub(crate) ffi::MclBnG1);

impl G1 {
    /// The point at infinity (identity element).
    pub fn zero() -> Self {
        let mut g1 = Self(ffi::MclBnG1 {
            x: ffi::MclBnFp { d: [0u64; 4] },
            y: ffi::MclBnFp { d: [0u64; 4] },
            z: ffi::MclBnFp { d: [0u64; 4] },
        });
        unsafe { ffi::mclBnG1_clear(&mut g1.0) };
        g1
    }

    pub fn is_zero(&self) -> bool {
        unsafe { ffi::mclBnG1_isZero(&self.0) == 1 }
    }

    pub fn is_valid(&self) -> bool {
        unsafe { ffi::mclBnG1_isValid(&self.0) == 1 }
    }

    /// Deserialize from Ethereum format: `x (32 bytes BE) || y (32 bytes BE)`.
    /// Returns `None` if coordinates are invalid or the point is not on the curve.
    pub fn from_eth(bytes: &[u8; 64]) -> Option<Self> {
        let x = Fp::from_be_bytes(bytes[0..32].try_into().unwrap())?;
        let y = Fp::from_be_bytes(bytes[32..64].try_into().unwrap())?;

        if x.is_zero() && y.is_zero() {
            return Some(G1::zero());
        }

        let g1 = Self(ffi::MclBnG1 {
            x: x.0,
            y: y.0,
            z: Fp::one().0,
        });

        if !g1.is_valid() {
            return None;
        }

        Some(g1)
    }

    /// Serialize to Ethereum format: `x (32 bytes BE) || y (32 bytes BE)`.
    pub fn to_eth(&self) -> [u8; 64] {
        if self.is_zero() {
            return [0u8; 64];
        }

        let mut normalized = *self;
        unsafe { ffi::mclBnG1_normalize(&mut normalized.0, &self.0) };

        let x = Fp(normalized.0.x);
        let y = Fp(normalized.0.y);

        let mut result = [0u8; 64];
        result[0..32].copy_from_slice(&x.to_be_bytes());
        result[32..64].copy_from_slice(&y.to_be_bytes());
        result
    }

    /// Point addition.
    pub fn add(&self, other: &G1) -> G1 {
        let mut z = G1::zero();
        unsafe { ffi::mclBnG1_add(&mut z.0, &self.0, &other.0) };
        z
    }

    /// Point subtraction.
    pub fn sub(&self, other: &G1) -> G1 {
        let mut z = G1::zero();
        unsafe { ffi::mclBnG1_sub(&mut z.0, &self.0, &other.0) };
        z
    }

    /// Point negation.
    pub fn neg(&self) -> G1 {
        let mut z = G1::zero();
        unsafe { ffi::mclBnG1_neg(&mut z.0, &self.0) };
        z
    }

    /// Point doubling.
    pub fn dbl(&self) -> G1 {
        let mut z = G1::zero();
        unsafe { ffi::mclBnG1_dbl(&mut z.0, &self.0) };
        z
    }

    /// Scalar multiplication.
    pub fn mul(&self, scalar: &Fr) -> G1 {
        let mut z = G1::zero();
        unsafe { ffi::mclBnG1_mul(&mut z.0, &self.0, &scalar.0) };
        z
    }

    /// Constant-time scalar multiplication (resistant to timing side-channels).
    pub fn mul_ct(&self, scalar: &Fr) -> G1 {
        let mut z = G1::zero();
        unsafe { ffi::mclBnG1_mulCT(&mut z.0, &self.0, &scalar.0) };
        z
    }

    /// Hash arbitrary data to a G1 point.
    pub fn hash_and_map_to(msg: &[u8]) -> Option<Self> {
        let mut g1 = G1::zero();
        let ret = unsafe { ffi::mclBnG1_hashAndMapTo(&mut g1.0, msg.as_ptr(), msg.len()) };
        if ret == 0 {
            Some(g1)
        } else {
            None
        }
    }
}

impl PartialEq for G1 {
    fn eq(&self, other: &Self) -> bool {
        unsafe { ffi::mclBnG1_isEqual(&self.0, &other.0) == 1 }
    }
}

impl Eq for G1 {}

impl Add for G1 {
    type Output = G1;
    fn add(self, rhs: G1) -> G1 {
        G1::add(&self, &rhs)
    }
}

impl Sub for G1 {
    type Output = G1;
    fn sub(self, rhs: G1) -> G1 {
        G1::sub(&self, &rhs)
    }
}

impl Neg for G1 {
    type Output = G1;
    fn neg(self) -> G1 {
        G1::neg(&self)
    }
}

impl Mul<Fr> for G1 {
    type Output = G1;
    fn mul(self, rhs: Fr) -> G1 {
        G1::mul(&self, &rhs)
    }
}

// ── G2 (curve point over Fp2) ────────────────────────────────────────────────

/// A point on the BN254 G2 curve (over Fp2).
#[derive(Clone, Copy)]
#[repr(transparent)]
pub struct G2(pub(crate) ffi::MclBnG2);

impl G2 {
    /// The point at infinity (identity element).
    pub fn zero() -> Self {
        let mut g2 = Self(ffi::MclBnG2 {
            x: ffi::MclBnFp2 {
                d: [ffi::MclBnFp { d: [0u64; 4] }; 2],
            },
            y: ffi::MclBnFp2 {
                d: [ffi::MclBnFp { d: [0u64; 4] }; 2],
            },
            z: ffi::MclBnFp2 {
                d: [ffi::MclBnFp { d: [0u64; 4] }; 2],
            },
        });
        unsafe { ffi::mclBnG2_clear(&mut g2.0) };
        g2
    }

    pub fn is_zero(&self) -> bool {
        unsafe { ffi::mclBnG2_isZero(&self.0) == 1 }
    }

    pub fn is_valid(&self) -> bool {
        unsafe { ffi::mclBnG2_isValid(&self.0) == 1 }
    }

    /// Deserialize from Ethereum format (128 bytes):
    /// `x_im (32B) || x_re (32B) || y_im (32B) || y_re (32B)`, all big-endian.
    ///
    /// Returns `None` if coordinates are invalid or the point is not on the curve.
    pub fn from_eth(bytes: &[u8; 128]) -> Option<Self> {
        let x_im = Fp::from_be_bytes(bytes[0..32].try_into().unwrap())?;
        let x_re = Fp::from_be_bytes(bytes[32..64].try_into().unwrap())?;
        let y_im = Fp::from_be_bytes(bytes[64..96].try_into().unwrap())?;
        let y_re = Fp::from_be_bytes(bytes[96..128].try_into().unwrap())?;

        if x_im.is_zero() && x_re.is_zero() && y_im.is_zero() && y_re.is_zero() {
            return Some(G2::zero());
        }

        // Fp2: d[0] = real, d[1] = imaginary
        let g2 = Self(ffi::MclBnG2 {
            x: ffi::MclBnFp2 {
                d: [x_re.0, x_im.0],
            },
            y: ffi::MclBnFp2 {
                d: [y_re.0, y_im.0],
            },
            z: ffi::MclBnFp2 {
                d: [Fp::one().0, Fp::zero().0],
            },
        });

        if !g2.is_valid() {
            return None;
        }

        Some(g2)
    }

    /// Serialize to Ethereum format (128 bytes):
    /// `x_im (32B) || x_re (32B) || y_im (32B) || y_re (32B)`, all big-endian.
    pub fn to_eth(&self) -> [u8; 128] {
        if self.is_zero() {
            return [0u8; 128];
        }

        let mut normalized = *self;
        unsafe { ffi::mclBnG2_normalize(&mut normalized.0, &self.0) };

        let x_re = Fp(normalized.0.x.d[0]);
        let x_im = Fp(normalized.0.x.d[1]);
        let y_re = Fp(normalized.0.y.d[0]);
        let y_im = Fp(normalized.0.y.d[1]);

        let mut result = [0u8; 128];
        result[0..32].copy_from_slice(&x_im.to_be_bytes());
        result[32..64].copy_from_slice(&x_re.to_be_bytes());
        result[64..96].copy_from_slice(&y_im.to_be_bytes());
        result[96..128].copy_from_slice(&y_re.to_be_bytes());
        result
    }

    /// Point addition.
    pub fn add(&self, other: &G2) -> G2 {
        let mut z = G2::zero();
        unsafe { ffi::mclBnG2_add(&mut z.0, &self.0, &other.0) };
        z
    }

    /// Point negation.
    pub fn neg(&self) -> G2 {
        let mut z = G2::zero();
        unsafe { ffi::mclBnG2_neg(&mut z.0, &self.0) };
        z
    }

    /// Scalar multiplication.
    pub fn mul(&self, scalar: &Fr) -> G2 {
        let mut z = G2::zero();
        unsafe { ffi::mclBnG2_mul(&mut z.0, &self.0, &scalar.0) };
        z
    }

    /// Hash arbitrary data to a G2 point.
    pub fn hash_and_map_to(msg: &[u8]) -> Option<Self> {
        let mut g2 = G2::zero();
        let ret = unsafe { ffi::mclBnG2_hashAndMapTo(&mut g2.0, msg.as_ptr(), msg.len()) };
        if ret == 0 {
            Some(g2)
        } else {
            None
        }
    }
}

impl PartialEq for G2 {
    fn eq(&self, other: &Self) -> bool {
        unsafe { ffi::mclBnG2_isEqual(&self.0, &other.0) == 1 }
    }
}

impl Eq for G2 {}

impl Add for G2 {
    type Output = G2;
    fn add(self, rhs: G2) -> G2 {
        G2::add(&self, &rhs)
    }
}

impl Neg for G2 {
    type Output = G2;
    fn neg(self) -> G2 {
        G2::neg(&self)
    }
}

// ── GT (target group element in Fp12) ────────────────────────────────────────

/// An element of the target group GT (a subgroup of Fp12).
#[derive(Clone, Copy)]
#[repr(transparent)]
pub struct GT(pub(crate) ffi::MclBnGT);

impl GT {
    /// Returns `true` if this is the identity element of GT.
    pub fn is_one(&self) -> bool {
        unsafe { ffi::mclBnGT_isOne(&self.0) == 1 }
    }

    /// Group multiplication in GT.
    pub fn mul(&self, other: &GT) -> GT {
        let mut z = Self::default();
        unsafe { ffi::mclBnGT_mul(&mut z.0, &self.0, &other.0) };
        z
    }

    /// Exponentiation in GT.
    pub fn pow(&self, exp: &Fr) -> GT {
        let mut z = Self::default();
        unsafe { ffi::mclBnGT_pow(&mut z.0, &self.0, &exp.0) };
        z
    }

    /// Inverse in GT.
    pub fn inv(&self) -> GT {
        let mut z = Self::default();
        unsafe { ffi::mclBnGT_inv(&mut z.0, &self.0) };
        z
    }
}

impl Default for GT {
    fn default() -> Self {
        Self(ffi::MclBnGT {
            d: [ffi::MclBnFp { d: [0u64; 4] }; 12],
        })
    }
}

impl PartialEq for GT {
    fn eq(&self, other: &Self) -> bool {
        unsafe { ffi::mclBnGT_isEqual(&self.0, &other.0) == 1 }
    }
}

impl Eq for GT {}

// ── Pairing operations ───────────────────────────────────────────────────────

/// Compute the optimal ate pairing: `e(g1, g2)`.
pub fn pairing(g1: &G1, g2: &G2) -> GT {
    let mut z = GT::default();
    unsafe { ffi::mclBn_pairing(&mut z.0, &g1.0, &g2.0) };
    z
}

/// Compute the Miller loop for a single pair.
pub fn miller_loop(g1: &G1, g2: &G2) -> GT {
    let mut z = GT::default();
    unsafe { ffi::mclBn_millerLoop(&mut z.0, &g1.0, &g2.0) };
    z
}

/// Compute the product of Miller loops: `prod_i millerLoop(g1s[i], g2s[i])`.
///
/// This is more efficient than computing individual Miller loops and multiplying.
/// Panics if `g1s` and `g2s` have different lengths.
pub fn multi_miller_loop(g1s: &[G1], g2s: &[G2]) -> GT {
    assert_eq!(g1s.len(), g2s.len());

    if g1s.is_empty() {
        let mut z = GT::default();
        unsafe { ffi::mclBnGT_setInt32(&mut z.0, 1) };
        return z;
    }

    let mut z = GT::default();
    unsafe {
        ffi::mclBn_millerLoopVec(
            &mut z.0,
            g1s.as_ptr() as *const ffi::MclBnG1,
            g2s.as_ptr() as *const ffi::MclBnG2,
            g1s.len(),
        );
    }
    z
}

/// Compute the final exponentiation step of the pairing.
pub fn final_exp(gt: &GT) -> GT {
    let mut z = GT::default();
    unsafe { ffi::mclBn_finalExp(&mut z.0, &gt.0) };
    z
}

/// Check that `e(g1s[0], g2s[0]) * ... * e(g1s[n-1], g2s[n-1]) == 1` in GT.
///
/// This is the standard pairing check used by Ethereum's ecPairing precompile.
/// Returns `true` if the pairing product equals the identity element.
pub fn pairing_check(g1s: &[G1], g2s: &[G2]) -> bool {
    let ml = multi_miller_loop(g1s, g2s);
    let result = final_exp(&ml);
    result.is_one()
}
