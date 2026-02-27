//! Integration tests using Ethereum BN254 precompile test vectors.

use mcl_bn254::{init, pairing_check, Fr, G1, G2};

fn hex_to_bytes(s: &str) -> Vec<u8> {
    (0..s.len())
        .step_by(2)
        .map(|i| u8::from_str_radix(&s[i..i + 2], 16).unwrap())
        .collect()
}

fn hex_to_array<const N: usize>(s: &str) -> [u8; N] {
    let bytes = hex_to_bytes(s);
    assert_eq!(bytes.len(), N, "expected {} bytes, got {}", N, bytes.len());
    let mut arr = [0u8; N];
    arr.copy_from_slice(&bytes);
    arr
}

fn bytes_to_hex(bytes: &[u8]) -> String {
    bytes.iter().map(|b| format!("{:02x}", b)).collect()
}

fn setup() {
    assert!(init(), "mcl BN254 initialization failed");
}

// ── ecAdd tests ──────────────────────────────────────────────────────────────

#[test]
fn test_g1_add_valid_points() {
    setup();

    let p1 = G1::from_eth(&hex_to_array::<64>(
        "18b18acfb4c2c30276db5411368e7185b311dd124691610c5d3b74034e093dc9\
         063c909c4720840cb5134cb9f59fa749755796819658d32efc0d288198f37266",
    ))
    .unwrap();

    let p2 = G1::from_eth(&hex_to_array::<64>(
        "07c2b7f58a84bd6145f00c9c2bc0bb1a187f20ff2c92963a88019e7c6a014eed\
         06614e20c147e940f2d70da3f74c9a17df361706a4485c742bd6788478fa17d7",
    ))
    .unwrap();

    let result = p1.add(&p2);
    let result_bytes = result.to_eth();

    let expected = hex_to_bytes(
        "2243525c5efd4b9c3d3c45ac0ca3fe4dd85e830a4ce6b65fa1eeaee202839703\
         301d1d33be6da8e509df21cc35964723180eed7532537db9ae5e7d48f195c915",
    );

    assert_eq!(
        bytes_to_hex(&result_bytes),
        bytes_to_hex(&expected),
        "G1 add result mismatch"
    );
}

#[test]
fn test_g1_add_identity() {
    setup();

    let zero = G1::from_eth(&[0u8; 64]).unwrap();
    let result = zero.add(&zero);
    assert!(result.is_zero(), "0 + 0 should be point at infinity");
    assert_eq!(result.to_eth(), [0u8; 64]);
}

#[test]
fn test_g1_add_with_identity() {
    setup();

    let p = G1::from_eth(&hex_to_array::<64>(
        "18b18acfb4c2c30276db5411368e7185b311dd124691610c5d3b74034e093dc9\
         063c909c4720840cb5134cb9f59fa749755796819658d32efc0d288198f37266",
    ))
    .unwrap();

    let zero = G1::zero();
    let result = p.add(&zero);
    assert_eq!(
        bytes_to_hex(&result.to_eth()),
        bytes_to_hex(&p.to_eth()),
        "P + 0 should equal P"
    );
}

#[test]
fn test_g1_add_invalid_point() {
    setup();

    let result = G1::from_eth(&hex_to_array::<64>(
        "1111111111111111111111111111111111111111111111111111111111111111\
         1111111111111111111111111111111111111111111111111111111111111111",
    ));
    assert!(result.is_none(), "invalid point should fail");
}

// ── ecMul tests ──────────────────────────────────────────────────────────────

#[test]
fn test_g1_scalar_mul() {
    setup();

    let p = G1::from_eth(&hex_to_array::<64>(
        "2bd3e6d0f3b142924f5ca7b49ce5b9d54c4703d7ae5648e61d02268b1a0a9fb7\
         21611ce0a6af85915e2f1d70300909ce2e49dfad4a4619c8390cae66cefdb204",
    ))
    .unwrap();

    let scalar = Fr::from_be_bytes(&hex_to_array::<32>(
        "00000000000000000000000000000000000000000000000011138ce750fa15c2",
    ));

    let result = p.mul(&scalar);
    let result_bytes = result.to_eth();

    let expected = hex_to_bytes(
        "070a8d6a982153cae4be29d434e8faef8a47b274a053f5a4ee2a6c9c13c31e5c\
         031b8ce914eba3a9ffb989f9cdd5b0f01943074bf4f0f315690ec3cec6981afc",
    );

    assert_eq!(
        bytes_to_hex(&result_bytes),
        bytes_to_hex(&expected),
        "G1 scalar mul result mismatch"
    );
}

#[test]
fn test_g1_mul_by_zero() {
    setup();

    let p = G1::from_eth(&hex_to_array::<64>(
        "2bd3e6d0f3b142924f5ca7b49ce5b9d54c4703d7ae5648e61d02268b1a0a9fb7\
         21611ce0a6af85915e2f1d70300909ce2e49dfad4a4619c8390cae66cefdb204",
    ))
    .unwrap();

    let zero_scalar = Fr::zero();
    let result = p.mul(&zero_scalar);
    assert!(result.is_zero(), "P * 0 should be point at infinity");
}

#[test]
fn test_g1_mul_identity_scalar() {
    setup();

    let p = G1::from_eth(&hex_to_array::<64>(
        "2bd3e6d0f3b142924f5ca7b49ce5b9d54c4703d7ae5648e61d02268b1a0a9fb7\
         21611ce0a6af85915e2f1d70300909ce2e49dfad4a4619c8390cae66cefdb204",
    ))
    .unwrap();

    let one_scalar = Fr::one();
    let result = p.mul(&one_scalar);
    assert_eq!(
        bytes_to_hex(&result.to_eth()),
        bytes_to_hex(&p.to_eth()),
        "P * 1 should equal P"
    );
}

#[test]
fn test_g1_mul_invalid_point() {
    setup();

    let result = G1::from_eth(&hex_to_array::<64>(
        "1111111111111111111111111111111111111111111111111111111111111111\
         1111111111111111111111111111111111111111111111111111111111111111",
    ));
    assert!(result.is_none(), "invalid point should fail");
}

// ── ecPairing tests ──────────────────────────────────────────────────────────

#[test]
fn test_pairing_two_pairs() {
    setup();

    // Two pairs that satisfy e(P1,Q1) * e(P2,Q2) = 1
    let input = hex_to_bytes(
        "1c76476f4def4bb94541d57ebba1193381ffa7aa76ada664dd31c16024c43f59\
         3034dd2920f673e204fee2811c678745fc819b55d3e9d294e45c9b03a76aef41\
         209dd15ebff5d46c4bd888e51a93cf99a7329636c63514396b4a452003a35bf7\
         04bf11ca01483bfa8b34b43561848d28905960114c8ac04049af4b6315a41678\
         2bb8324af6cfc93537a2ad1a445cfd0ca2a71acd7ac41fadbf933c2a51be344d\
         120a2a4cf30c1bf9845f20c6fe39e07ea2cce61f0c9bb048165fe5e4de877550\
         111e129f1cf1097710d41c4ac70fcdfa5ba2023c6ff1cbeac322de49d1b6df7c\
         2032c61a830e3c17286de9462bf242fca2883585b93870a73853face6a6bf411\
         198e9393920d483a7260bfb731fb5d25f1aa493335a9e71297e485b7aef312c2\
         1800deef121f1e76426a00665e5c4479674322d4f75edadd46debd5cd992f6ed\
         090689d0585ff075ec9e99ad690c3395bc4b313370b38ef355acdadcd122975b\
         12c85ea5db8c6deb4aab71808dcb408fe3d1e7690c43d37b4ce6cc0166fa7daa",
    );

    assert_eq!(input.len(), 384, "pairing input should be 384 bytes");

    let g1_a = G1::from_eth(input[0..64].try_into().unwrap()).unwrap();
    let g2_a = G2::from_eth(input[64..192].try_into().unwrap()).unwrap();
    let g1_b = G1::from_eth(input[192..256].try_into().unwrap()).unwrap();
    let g2_b = G2::from_eth(input[256..384].try_into().unwrap()).unwrap();

    assert!(
        pairing_check(&[g1_a, g1_b], &[g2_a, g2_b]),
        "pairing check should return true"
    );
}

#[test]
fn test_pairing_empty_input() {
    setup();

    // Empty pairing = product of zero pairings = 1 in GT
    assert!(
        pairing_check(&[], &[]),
        "empty pairing should return true"
    );
}

#[test]
fn test_pairing_g1_infinity() {
    setup();

    // G1 = (0,0) (infinity), valid G2 → pairing should return true
    let g1 = G1::from_eth(&[0u8; 64]).unwrap();
    let g2_bytes = hex_to_array::<128>(
        "209dd15ebff5d46c4bd888e51a93cf99a7329636c63514396b4a452003a35bf7\
         04bf11ca01483bfa8b34b43561848d28905960114c8ac04049af4b6315a41678\
         2bb8324af6cfc93537a2ad1a445cfd0ca2a71acd7ac41fadbf933c2a51be344d\
         120a2a4cf30c1bf9845f20c6fe39e07ea2cce61f0c9bb048165fe5e4de877550",
    );
    let g2 = G2::from_eth(&g2_bytes).unwrap();

    assert!(
        pairing_check(&[g1], &[g2]),
        "pairing with G1 infinity should return true"
    );
}

#[test]
fn test_pairing_g2_infinity() {
    setup();

    // valid G1, G2 = (0,0,0,0) (infinity) → pairing should return true
    let g1_bytes = hex_to_array::<64>(
        "1c76476f4def4bb94541d57ebba1193381ffa7aa76ada664dd31c16024c43f59\
         3034dd2920f673e204fee2811c678745fc819b55d3e9d294e45c9b03a76aef41",
    );
    let g1 = G1::from_eth(&g1_bytes).unwrap();
    let g2 = G2::from_eth(&[0u8; 128]).unwrap();

    assert!(
        pairing_check(&[g1], &[g2]),
        "pairing with G2 infinity should return true"
    );
}

// ── Fr / operator tests ──────────────────────────────────────────────────────

#[test]
fn test_fr_arithmetic() {
    setup();

    let a = Fr::one();
    let b = Fr::one();

    let sum = a + b;
    assert!(!sum.is_zero());
    assert!(!sum.is_one());

    let diff = sum - a;
    assert!(diff.is_one(), "2 - 1 should be 1");

    let product = a * b;
    assert!(product.is_one(), "1 * 1 should be 1");

    let neg_a = -a;
    let should_be_zero = a + neg_a;
    assert!(should_be_zero.is_zero(), "a + (-a) should be 0");
}

#[test]
fn test_fr_serialization_roundtrip() {
    setup();

    let bytes = hex_to_array::<32>(
        "00000000000000000000000000000000000000000000000011138ce750fa15c2",
    );
    let fr = Fr::from_be_bytes(&bytes);
    let roundtrip = fr.to_be_bytes();
    assert_eq!(bytes_to_hex(&roundtrip), bytes_to_hex(&bytes));
}

// ── G1 operator overload tests ───────────────────────────────────────────────

#[test]
fn test_g1_operator_add() {
    setup();

    let p1 = G1::from_eth(&hex_to_array::<64>(
        "18b18acfb4c2c30276db5411368e7185b311dd124691610c5d3b74034e093dc9\
         063c909c4720840cb5134cb9f59fa749755796819658d32efc0d288198f37266",
    ))
    .unwrap();

    let p2 = G1::from_eth(&hex_to_array::<64>(
        "07c2b7f58a84bd6145f00c9c2bc0bb1a187f20ff2c92963a88019e7c6a014eed\
         06614e20c147e940f2d70da3f74c9a17df361706a4485c742bd6788478fa17d7",
    ))
    .unwrap();

    // Using operator overload
    let result_op = p1 + p2;
    // Using method
    let result_method = p1.add(&p2);

    assert!(result_op == result_method, "operator + should match .add()");
}

#[test]
fn test_g1_scalar_mul_operator() {
    setup();

    let p = G1::from_eth(&hex_to_array::<64>(
        "2bd3e6d0f3b142924f5ca7b49ce5b9d54c4703d7ae5648e61d02268b1a0a9fb7\
         21611ce0a6af85915e2f1d70300909ce2e49dfad4a4619c8390cae66cefdb204",
    ))
    .unwrap();

    let scalar = Fr::from_be_bytes(&hex_to_array::<32>(
        "00000000000000000000000000000000000000000000000011138ce750fa15c2",
    ));

    let result_op = p * scalar;
    let result_method = p.mul(&scalar);

    assert!(
        result_op == result_method,
        "operator * should match .mul()"
    );
}

// ── G1 serialization roundtrip ───────────────────────────────────────────────

#[test]
fn test_g1_serialization_roundtrip() {
    setup();

    let original_bytes = hex_to_array::<64>(
        "18b18acfb4c2c30276db5411368e7185b311dd124691610c5d3b74034e093dc9\
         063c909c4720840cb5134cb9f59fa749755796819658d32efc0d288198f37266",
    );

    let p = G1::from_eth(&original_bytes).unwrap();
    let roundtrip = p.to_eth();
    assert_eq!(
        bytes_to_hex(&roundtrip),
        bytes_to_hex(&original_bytes),
        "G1 serialization roundtrip failed"
    );
}

#[test]
fn test_g2_serialization_roundtrip() {
    setup();

    let original_bytes = hex_to_array::<128>(
        "209dd15ebff5d46c4bd888e51a93cf99a7329636c63514396b4a452003a35bf7\
         04bf11ca01483bfa8b34b43561848d28905960114c8ac04049af4b6315a41678\
         2bb8324af6cfc93537a2ad1a445cfd0ca2a71acd7ac41fadbf933c2a51be344d\
         120a2a4cf30c1bf9845f20c6fe39e07ea2cce61f0c9bb048165fe5e4de877550",
    );

    let p = G2::from_eth(&original_bytes).unwrap();
    let roundtrip = p.to_eth();
    assert_eq!(
        bytes_to_hex(&roundtrip),
        bytes_to_hex(&original_bytes),
        "G2 serialization roundtrip failed"
    );
}
