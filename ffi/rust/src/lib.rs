//! Rust FFI bindings for [herumi/mcl](https://github.com/herumi/mcl) BN254 curve operations.
//!
//! Provides safe wrappers for G1/G2 point arithmetic and optimal ate pairings
//! on the BN254 curve, with serialization matching Ethereum's precompile format.
//!
//! # Quick Start
//!
//! ```no_run
//! use mcl_bn254::{init, G1, G2, Fr, pairing};
//!
//! // Must initialize before use
//! assert!(init());
//!
//! // Parse points from Ethereum-format bytes
//! let g1 = G1::from_eth(&[0u8; 64]).unwrap(); // point at infinity
//! let g2 = G2::from_eth(&[0u8; 128]).unwrap();
//!
//! // Compute pairing
//! let gt = pairing(&g1, &g2);
//! ```

pub mod bn254;
pub mod ffi;

pub use bn254::{
    final_exp, init, miller_loop, multi_miller_loop, pairing, pairing_check, Fp, Fr, G1, G2, GT,
};
