use libc::{c_int, size_t};
use std::ffi::CString;
use std::os::raw::c_char;

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

#[link(name = "mclbn384_256")]
extern "C" {
    fn mclBn_init(curve: c_int, compiledTimeVar: c_int) -> c_int;
    fn mclBnFr_setStr(x: *mut MclBnFr, buf: *const c_char, bufSize: size_t, ioMode: c_int)
        -> c_int;
    fn mclBnFr_getStr(
        buf: *mut c_char,
        maxBufSize: size_t,
        x: *const MclBnFr,
        ioMode: c_int,
    ) -> size_t;
}

pub fn mcl_bn_init(curve: i32, compiled_time_var: i32) -> i32 {
    unsafe { mclBn_init(curve, compiled_time_var) }
}

#[derive(Default)]
#[repr(C)]
pub struct MclBnFp {
    d: [u64; MCLBN_FP_UNIT_SIZE as usize],
}

#[derive(Default)]
#[repr(C)]
pub struct MclBnFp2 {
    d: [MclBnFp; 2],
}

#[derive(Default)]
#[repr(C)]
pub struct MclBnFr {
    d: [u64; MCLBN_FR_UNIT_SIZE as usize],
}

#[derive(Default)]
#[repr(C)]
pub struct MclBnG1 {
    x: MclBnFp,
    y: MclBnFp,
    z: MclBnFp,
}

#[derive(Default)]
#[repr(C)]
pub struct MclBnG2 {
    x: MclBnFp2,
    y: MclBnFp2,
    z: MclBnFp2,
}

#[derive(Default)]
#[repr(C)]
pub struct MclBnGT {
    d: [MclBnFp; 12],
}

impl MclBnFr {
    pub fn set_str_radix(&mut self, buffer: &str, radix: usize) {
        let buf = buffer.as_ptr();
        let err = unsafe {
            mclBnFr_setStr(
                self as *mut Self,
                buf as *const c_char,
                buffer.len() as size_t,
                radix as c_int,
            )
        };
        assert_eq!(err, 0);
    }

    pub fn get_str_radix(&self, radix: usize) -> String {
        let len = 2048;
        let mut buf = vec![0u8; len];
        let bytes = unsafe {
            let self_ptr = self as *const Self;
            mclBnFr_getStr(
                buf.as_mut_ptr() as *mut c_char,
                len as size_t,
                self_ptr,
                radix as c_int,
            )
        };
        assert_ne!(bytes, 0);
        String::from_utf8_lossy(&buf[..bytes]).into_owned()
    }
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn it_works() {
        assert_eq!(mcl_bn_init(BLS12_381, MCLBN_COMPILED_TIME_VAR), 0);
    }

    #[test]
    fn test_mcl_bn_fp_str() {
        let mut fr = MclBnFr::default();
        fr.set_str_radix("123", 10);
        assert_eq!(fr.get_str_radix(10), "123".to_string());
    }
}
