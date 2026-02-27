//! Raw FFI bindings to herumi/mcl's C API (bn.h) for BN254.
//!
//! All types use `MCL_FP_BIT=256`, `MCL_FR_BIT=256`:
//! - `MCLBN_FP_UNIT_SIZE = 4`
//! - `MCLBN_FR_UNIT_SIZE = 4`
//! - `MCLBN_COMPILED_TIME_VAR = 44`

use std::os::raw::c_int;

// ── Struct definitions matching the C types in bn.h ──────────────────────────

/// Scalar field element (Fr). 4 × u64 = 32 bytes.
#[derive(Clone, Copy)]
#[repr(C)]
pub struct MclBnFr {
    pub d: [u64; 4],
}

/// Base field element (Fp). 4 × u64 = 32 bytes.
#[derive(Clone, Copy)]
#[repr(C)]
pub struct MclBnFp {
    pub d: [u64; 4],
}

/// Quadratic extension field element (Fp2 = Fp + Fp·i).
/// `d[0]` = real part, `d[1]` = imaginary part.
#[derive(Clone, Copy)]
#[repr(C)]
pub struct MclBnFp2 {
    pub d: [MclBnFp; 2],
}

/// G1 point in projective coordinates over Fp.
#[derive(Clone, Copy)]
#[repr(C)]
pub struct MclBnG1 {
    pub x: MclBnFp,
    pub y: MclBnFp,
    pub z: MclBnFp,
}

/// G2 point in projective coordinates over Fp2.
#[derive(Clone, Copy)]
#[repr(C)]
pub struct MclBnG2 {
    pub x: MclBnFp2,
    pub y: MclBnFp2,
    pub z: MclBnFp2,
}

/// Target group element (GT ⊂ Fp12). 12 × Fp = 384 bytes.
#[derive(Clone, Copy)]
#[repr(C)]
pub struct MclBnGT {
    pub d: [MclBnFp; 12],
}

// ── Extern "C" function declarations ─────────────────────────────────────────

#[link(name = "mcl", kind = "static")]
extern "C" {
    // ── Global ───────────────────────────────────────────────────────────────
    pub fn mclBn_init(curve: c_int, compiledTimeVar: c_int) -> c_int;
    pub fn mclBn_getVersion() -> u32;
    pub fn mclBn_pairing(z: *mut MclBnGT, x: *const MclBnG1, y: *const MclBnG2);
    pub fn mclBn_millerLoop(z: *mut MclBnGT, x: *const MclBnG1, y: *const MclBnG2);
    pub fn mclBn_millerLoopVec(
        z: *mut MclBnGT,
        x: *const MclBnG1,
        y: *const MclBnG2,
        n: usize,
    );
    pub fn mclBn_finalExp(y: *mut MclBnGT, x: *const MclBnGT);
    pub fn mclBn_verifyOrderG1(doVerify: c_int);
    pub fn mclBn_verifyOrderG2(doVerify: c_int);
    pub fn mclBn_getG1ByteSize() -> c_int;
    pub fn mclBn_getFrByteSize() -> c_int;
    pub fn mclBn_getFpByteSize() -> c_int;

    // ── Fr (scalar field) ────────────────────────────────────────────────────
    pub fn mclBnFr_clear(x: *mut MclBnFr);
    pub fn mclBnFr_setInt32(y: *mut MclBnFr, x: c_int);
    pub fn mclBnFr_serialize(buf: *mut u8, maxBufSize: usize, x: *const MclBnFr) -> usize;
    pub fn mclBnFr_deserialize(x: *mut MclBnFr, buf: *const u8, bufSize: usize) -> usize;
    pub fn mclBnFr_setLittleEndianMod(x: *mut MclBnFr, buf: *const u8, bufSize: usize) -> c_int;
    pub fn mclBnFr_isValid(x: *const MclBnFr) -> c_int;
    pub fn mclBnFr_isEqual(x: *const MclBnFr, y: *const MclBnFr) -> c_int;
    pub fn mclBnFr_isZero(x: *const MclBnFr) -> c_int;
    pub fn mclBnFr_isOne(x: *const MclBnFr) -> c_int;
    pub fn mclBnFr_add(z: *mut MclBnFr, x: *const MclBnFr, y: *const MclBnFr);
    pub fn mclBnFr_sub(z: *mut MclBnFr, x: *const MclBnFr, y: *const MclBnFr);
    pub fn mclBnFr_mul(z: *mut MclBnFr, x: *const MclBnFr, y: *const MclBnFr);
    pub fn mclBnFr_neg(y: *mut MclBnFr, x: *const MclBnFr);
    pub fn mclBnFr_inv(y: *mut MclBnFr, x: *const MclBnFr);
    pub fn mclBnFr_setByCSPRNG(x: *mut MclBnFr) -> c_int;

    // ── Fp (base field) ──────────────────────────────────────────────────────
    pub fn mclBnFp_clear(x: *mut MclBnFp);
    pub fn mclBnFp_setInt32(y: *mut MclBnFp, x: c_int);
    pub fn mclBnFp_serialize(buf: *mut u8, maxBufSize: usize, x: *const MclBnFp) -> usize;
    pub fn mclBnFp_deserialize(x: *mut MclBnFp, buf: *const u8, bufSize: usize) -> usize;
    pub fn mclBnFp_isZero(x: *const MclBnFp) -> c_int;
    pub fn mclBnFp_isValid(x: *const MclBnFp) -> c_int;
    pub fn mclBnFp_isEqual(x: *const MclBnFp, y: *const MclBnFp) -> c_int;

    // ── G1 ───────────────────────────────────────────────────────────────────
    pub fn mclBnG1_clear(x: *mut MclBnG1);
    pub fn mclBnG1_isValid(x: *const MclBnG1) -> c_int;
    pub fn mclBnG1_isEqual(x: *const MclBnG1, y: *const MclBnG1) -> c_int;
    pub fn mclBnG1_isZero(x: *const MclBnG1) -> c_int;
    pub fn mclBnG1_isValidOrder(x: *const MclBnG1) -> c_int;
    pub fn mclBnG1_add(z: *mut MclBnG1, x: *const MclBnG1, y: *const MclBnG1);
    pub fn mclBnG1_sub(z: *mut MclBnG1, x: *const MclBnG1, y: *const MclBnG1);
    pub fn mclBnG1_neg(y: *mut MclBnG1, x: *const MclBnG1);
    pub fn mclBnG1_dbl(y: *mut MclBnG1, x: *const MclBnG1);
    pub fn mclBnG1_mul(z: *mut MclBnG1, x: *const MclBnG1, y: *const MclBnFr);
    pub fn mclBnG1_mulCT(z: *mut MclBnG1, x: *const MclBnG1, y: *const MclBnFr);
    pub fn mclBnG1_normalize(y: *mut MclBnG1, x: *const MclBnG1);
    pub fn mclBnG1_serialize(buf: *mut u8, maxBufSize: usize, x: *const MclBnG1) -> usize;
    pub fn mclBnG1_deserialize(x: *mut MclBnG1, buf: *const u8, bufSize: usize) -> usize;
    pub fn mclBnG1_hashAndMapTo(x: *mut MclBnG1, buf: *const u8, bufSize: usize) -> c_int;

    // ── G2 ───────────────────────────────────────────────────────────────────
    pub fn mclBnG2_clear(x: *mut MclBnG2);
    pub fn mclBnG2_isValid(x: *const MclBnG2) -> c_int;
    pub fn mclBnG2_isEqual(x: *const MclBnG2, y: *const MclBnG2) -> c_int;
    pub fn mclBnG2_isZero(x: *const MclBnG2) -> c_int;
    pub fn mclBnG2_isValidOrder(x: *const MclBnG2) -> c_int;
    pub fn mclBnG2_add(z: *mut MclBnG2, x: *const MclBnG2, y: *const MclBnG2);
    pub fn mclBnG2_sub(z: *mut MclBnG2, x: *const MclBnG2, y: *const MclBnG2);
    pub fn mclBnG2_neg(y: *mut MclBnG2, x: *const MclBnG2);
    pub fn mclBnG2_dbl(y: *mut MclBnG2, x: *const MclBnG2);
    pub fn mclBnG2_mul(z: *mut MclBnG2, x: *const MclBnG2, y: *const MclBnFr);
    pub fn mclBnG2_normalize(y: *mut MclBnG2, x: *const MclBnG2);
    pub fn mclBnG2_serialize(buf: *mut u8, maxBufSize: usize, x: *const MclBnG2) -> usize;
    pub fn mclBnG2_deserialize(x: *mut MclBnG2, buf: *const u8, bufSize: usize) -> usize;
    pub fn mclBnG2_hashAndMapTo(x: *mut MclBnG2, buf: *const u8, bufSize: usize) -> c_int;

    // ── GT ───────────────────────────────────────────────────────────────────
    pub fn mclBnGT_clear(x: *mut MclBnGT);
    pub fn mclBnGT_setInt32(y: *mut MclBnGT, x: c_int);
    pub fn mclBnGT_isEqual(x: *const MclBnGT, y: *const MclBnGT) -> c_int;
    pub fn mclBnGT_isOne(x: *const MclBnGT) -> c_int;
    pub fn mclBnGT_isZero(x: *const MclBnGT) -> c_int;
    pub fn mclBnGT_mul(z: *mut MclBnGT, x: *const MclBnGT, y: *const MclBnGT);
    pub fn mclBnGT_pow(z: *mut MclBnGT, x: *const MclBnGT, y: *const MclBnFr);
    pub fn mclBnGT_inv(y: *mut MclBnGT, x: *const MclBnGT);
    pub fn mclBnGT_serialize(buf: *mut u8, maxBufSize: usize, x: *const MclBnGT) -> usize;
    pub fn mclBnGT_deserialize(x: *mut MclBnGT, buf: *const u8, bufSize: usize) -> usize;
}
