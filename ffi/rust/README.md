# mcl-bn254

Rust FFI bindings for [herumi/mcl](https://github.com/herumi/mcl) BN254 curve operations.

Provides safe wrappers for G1/G2 point arithmetic and optimal ate pairings on the BN254 curve, with serialization matching Ethereum's precompile format (big-endian).

## Features

- **G1 operations**: addition, scalar multiplication, negation, doubling
- **G2 operations**: addition, scalar multiplication, negation
- **Pairing**: optimal ate pairing, Miller loop, final exponentiation
- **Ethereum format**: big-endian serialization matching EIP-196/197
- **Operator overloads**: `+`, `-`, `*`, `-` (unary) for ergonomic arithmetic
- **No runtime dependencies**: pure FFI to the mcl C++ library

## Requirements

- **CMake** (for building the mcl C++ library)
- **Clang** (required by mcl on most platforms)

## Usage

```rust
use mcl_bn254::{init, G1, G2, Fr, pairing, pairing_check};

// Initialize (must be called once before any operations)
assert!(init());

// Parse G1/G2 points from Ethereum-format bytes (big-endian)
let g1 = G1::from_eth(&g1_bytes).expect("valid G1 point");
let g2 = G2::from_eth(&g2_bytes).expect("valid G2 point");

// Point arithmetic
let sum = g1.add(&other_g1);      // or: g1 + other_g1
let product = g1.mul(&scalar);     // or: g1 * scalar

// Pairing check (Ethereum ecPairing precompile)
let result = pairing_check(&[g1_a, g1_b], &[g2_a, g2_b]);
```

## Building

```bash
cd ffi/rust
cargo build
cargo test
cargo run --example pairing
```

## Serialization Format

All serialization follows the Ethereum precompile format:

| Type | Size | Format |
|------|------|--------|
| Fp   | 32 bytes | big-endian |
| Fr   | 32 bytes | big-endian |
| G1   | 64 bytes | `x (32B) \|\| y (32B)` |
| G2   | 128 bytes | `x_im (32B) \|\| x_re (32B) \|\| y_im (32B) \|\| y_re (32B)` |

Point at infinity is represented as all zeros.

## License

BSD-3-Clause (same as herumi/mcl)
