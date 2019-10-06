use libc::{c_int, size_t};
use std::ffi::CString;
use std::os::raw::{c_char, c_void};

const BN254: i32 = 0;
const BLS12_381: i32 = 5;
const MCLBN_FR_UNIT_SIZE: i32 = 4;
const MCLBN_FP_UNIT_SIZE: i32 = 6;

const FR_SIZE: i32 = MCLBN_FR_UNIT_SIZE;
const G1_SIZE: i32 = MCLBN_FP_UNIT_SIZE * 3;
const G2_SIZE: i32 = MCLBN_FP_UNIT_SIZE * 6;
const GT_SIZE: i32 = MCLBN_FP_UNIT_SIZE * 12;

const SEC_SIZE: i32 = FR_SIZE * 2;
const PUB_SIZE: i32 = G1_SIZE + G2_SIZE;
const G1_CIPHER_SIZE: i32 = G1_SIZE * 2;
const G2_CIPHER_SIZE: i32 = G2_SIZE * 2;
const GT_CIPHER_SIZE: i32 = GT_SIZE * 4;

const MCLBN_COMPILED_TIME_VAR: i32 = (MCLBN_FR_UNIT_SIZE * 10) + MCLBN_FP_UNIT_SIZE;

macro_rules! mul_impl {
    ($($t:ty)*, $($fn:ident)*) => ($(
        impl std::ops::Mul for $t {
            type Output = $t;

            #[inline]
            fn mul(self, other: $t) -> $t {
                let mut result = <$t>::default();
                unsafe { $fn(&mut result, &self, &other); }
                result
            }
        }
    )*)
}

macro_rules! mul_point_impl {
    ($($t:ty)*, $($fn:ident)*) => ($(
        impl $t {
            pub fn mul_point(&self, y: &MclBnFr) -> $t {
                let mut result = <$t>::default();
                unsafe { $fn(&mut result as *mut $t, self as *const Self, y as *const MclBnFr) };
                result
            }
        }
    )*)
}

macro_rules! hash_and_map_impl {
    ($($t:ty)*, $($fn:ident)*) => ($(
        impl $t {
            pub fn hash_and_map(buf: &[u8]) -> Result<$t, i32> {
                let mut result = <$t>::default();
                let err = unsafe {
                    $fn(&mut result as *mut Self, buf.as_ptr() as *const c_void, buf.len())
                };
                match err {
                    0 => Ok(result),
                    n => Err(n)
                }
            }
        }
    )*)
}

macro_rules! str_conversions_impl {
    ($($t:ty)*, $($get_fn:ident)*, $($set_fn:ident)*) => ($(
        impl $t {
            pub fn from_str(buffer: &str, io_mode: IoMode) -> Self {
                let mut result = Self::default();
                result.set_str_radix(buffer, io_mode);
                result
            }
            
            pub fn set_str_radix(&mut self, buffer: &str, io_mode: IoMode) {
                let err = unsafe {
                    $set_fn(
                        self as *mut Self,
                        buffer.as_ptr() as *const c_char,
                        buffer.len() as size_t,
                        io_mode as c_int,
                    )
                };
                assert_eq!(err, 0);
            }

            pub fn get_str_radix(&self, io_mode: IoMode) -> String {
                let len = 2048;
                let mut buf = vec![0u8; len];
                let bytes = unsafe {
                    $get_fn(
                        buf.as_mut_ptr() as *mut c_char,
                        len as size_t,
                        self as *const Self,
                        io_mode as c_int,
                    )
                };
                assert_ne!(bytes, 0);
                String::from_utf8_lossy(&buf[..bytes]).into_owned()
            }
        }
    )*)
}

macro_rules! is_equal_impl {
    ($($t:ty)*, $($fn:ident)*) => ($(
        impl PartialEq for $t {
            fn eq(&self, other: &Self) -> bool {
                unsafe { $fn(self as *const Self, other as *const Self) == 1 }
            }
        }
    )*)
}

#[link(name = "mclbn384_256")]
extern "C" {
    fn mclBn_init(curve: c_int, compiledTimeVar: c_int) -> c_int;
    fn mclBnFr_setStr(x: *mut MclBnFr, buf: *const c_char, bufSize: size_t, ioMode: c_int)
        -> c_int;
    fn mclBnG1_setStr(x: *mut MclBnG1, buf: *const c_char, bufSize: size_t, ioMode: c_int)
        -> c_int;
    fn mclBnG2_setStr(x: *mut MclBnG2, buf: *const c_char, bufSize: size_t, ioMode: c_int)
        -> c_int;
    fn mclBnGT_setStr(x: *mut MclBnGT, buf: *const c_char, bufSize: size_t, ioMode: c_int)
        -> c_int;
    fn mclBnFr_getStr(
        buf: *mut c_char,
        maxBufSize: size_t,
        x: *const MclBnFr,
        ioMode: c_int,
    ) -> size_t;
    fn mclBnG1_getStr(
        buf: *mut c_char,
        maxBufSize: size_t,
        x: *const MclBnG1,
        ioMode: c_int,
    ) -> size_t;
    fn mclBnG2_getStr(
        buf: *mut c_char,
        maxBufSize: size_t,
        x: *const MclBnG2,
        ioMode: c_int,
    ) -> size_t;
    fn mclBnGT_getStr(
        buf: *mut c_char,
        maxBufSize: size_t,
        x: *const MclBnGT,
        ioMode: c_int,
    ) -> size_t;

    // Hash and map
    fn mclBnG1_hashAndMapTo(x: *mut MclBnG1, buf: *const c_void, bufSize: size_t) -> c_int;
    fn mclBnG2_hashAndMapTo(x: *mut MclBnG2, buf: *const c_void, bufSize: size_t) -> c_int;

    // Arithmetic operations
    // Multiplication
    fn mclBnFr_mul(z: *mut MclBnFr, x: *const MclBnFr, y: *const MclBnFr);
    fn mclBnGT_mul(z: *mut MclBnGT, x: *const MclBnGT, y: *const MclBnGT);

    // Point multiplication
    fn mclBnG1_mul(z: *mut MclBnG1, x: *const MclBnG1, y: *const MclBnFr);
    fn mclBnG2_mul(z: *mut MclBnG2, x: *const MclBnG2, y: *const MclBnFr);

    // Point exponentiation
    fn mclBnGT_pow(z: *mut MclBnGT, x: *const MclBnGT, y: *const MclBnFr);

    fn mclBnG1_isEqual(x: *const MclBnG1, y: *const MclBnG1) -> c_int;
    fn mclBnG2_isEqual(x: *const MclBnG2, y: *const MclBnG2) -> c_int;
    fn mclBnGT_isEqual(x: *const MclBnGT, y: *const MclBnGT) -> c_int;
    fn mclBnFp_isEqual(x: *const MclBnFp, y: *const MclBnFp) -> c_int;
    fn mclBnFr_isEqual(x: *const MclBnFr, y: *const MclBnFr) -> c_int;
    fn mclBnFp2_isEqual(x: *const MclBnFp2, y: *const MclBnFp2) -> c_int;

    fn mclBn_pairing(z: *mut MclBnGT, x: *const MclBnG1, y: *const MclBnG2);
}

pub fn mcl_bn_init(curve: i32, compiled_time_var: i32) -> i32 {
    use std::sync::Once;
    static INIT: Once = Once::new();
    static mut VAL: i32 = 0;
    unsafe {
        INIT.call_once(|| { VAL = mclBn_init(curve, compiled_time_var); });
        VAL
    }
}

#[derive(Default, Debug)]
#[repr(C)]
pub struct MclBnFp {
    d: [u64; MCLBN_FP_UNIT_SIZE as usize],
}
is_equal_impl![MclBnFp, mclBnFp_isEqual];

#[derive(Default, Debug)]
#[repr(C)]
pub struct MclBnFp2 {
    d: [MclBnFp; 2],
}
is_equal_impl![MclBnFp2, mclBnFp2_isEqual];

#[derive(Default, Debug)]
#[repr(C)]
pub struct MclBnFr {
    d: [u64; MCLBN_FR_UNIT_SIZE as usize],
}
mul_impl![MclBnFr, mclBnFr_mul];
is_equal_impl![MclBnFr, mclBnFr_isEqual];
str_conversions_impl![MclBnFr, mclBnFr_getStr, mclBnFr_setStr];

#[derive(Default, Debug)]
#[repr(C)]
pub struct MclBnG1 {
    x: MclBnFp,
    y: MclBnFp,
    z: MclBnFp,
}
mul_point_impl![MclBnG1, mclBnG1_mul];
is_equal_impl![MclBnG1, mclBnG1_isEqual];
hash_and_map_impl![MclBnG1, mclBnG1_hashAndMapTo];
str_conversions_impl![MclBnG1, mclBnG1_getStr, mclBnG1_setStr];

#[derive(Default, Debug)]
#[repr(C)]
pub struct MclBnG2 {
    x: MclBnFp2,
    y: MclBnFp2,
    z: MclBnFp2,
}
mul_point_impl![MclBnG2, mclBnG2_mul];
is_equal_impl![MclBnG2, mclBnG2_isEqual];
hash_and_map_impl![MclBnG2, mclBnG2_hashAndMapTo];
str_conversions_impl![MclBnG2, mclBnG2_getStr, mclBnG2_setStr];

#[derive(Default, Debug)]
#[repr(C)]
pub struct MclBnGT {
    d: [MclBnFp; 12],
}
mul_impl![MclBnGT, mclBnGT_mul];
is_equal_impl![MclBnGT, mclBnGT_isEqual];
str_conversions_impl![MclBnGT, mclBnGT_getStr, mclBnGT_setStr];

impl MclBnGT {
    pub fn from_pairing(p: &MclBnG1, q: &MclBnG2) -> MclBnGT {
        let mut result = Self::default();
        unsafe {
            mclBn_pairing(&mut result as *mut Self, p as *const MclBnG1, q as *const MclBnG2);
        }
        result
    }

    pub fn pow(&self, a: &MclBnFr) -> Self {
        let mut result = Self::default();
        unsafe {
            mclBnGT_pow(&mut result as *mut Self, self as *const Self, a as *const MclBnFr);
        }
        result
    }
}

#[derive(Debug)]
pub enum IoMode {
    Dec = 10,
    Hex = 16,
}


#[cfg(test)]
mod tests {
    use super::*;

    fn initialize() {
        mcl_bn_init(BLS12_381, MCLBN_COMPILED_TIME_VAR);
    }

    fn run_test(inner: impl FnOnce() -> ()) {
        initialize();
        inner();
    }

    #[test]
    fn test_mcl_bn_fp_str() {
        run_test(|| {
            let mut fr = MclBnFr::default();
            fr.set_str_radix("123", IoMode::Dec);
            assert_eq!(fr.get_str_radix(IoMode::Dec), "123".to_string());
        });
    }

    #[test]
    fn test_fp_mul() {
        run_test(|| {
            let a = MclBnFr::from_str("12", IoMode::Dec);
            let b = MclBnFr::from_str("13", IoMode::Dec);
            let c = MclBnFr::from_str("156", IoMode::Dec);
            assert_eq!(a * b, c);
        });
    }

    #[test]
    fn test_g1_mul() {
        run_test(|| {
            let p = MclBnG1::hash_and_map(b"this").unwrap();
            let mut x = MclBnFr::default();
            x.set_str_radix("123", IoMode::Dec);
            let y = p.mul_point(&x);
            let mut expected = MclBnG1::default();
            expected.set_str_radix(
                "1 ea23afffe7e4eaeddbec067563e2387bac5c2354bd58f4346151db670e65c465f947789e5f82de9ba7567d0a289c658 cf01434515162c99815667f4a5515e20d407609702b9bc182155bcf23473960ec4de3b5b552285b3f1656948cfe3260",
                IoMode::Hex);
            assert_eq!(y, expected);
        });
    }
}
