//! Simple BN254 pairing example.
//!
//! Demonstrates:
//! - Initializing the library
//! - Parsing G1/G2 points from Ethereum-format hex
//! - Computing a pairing check

use mcl_bn254::{init, pairing, pairing_check, Fr, G1, G2};

fn hex_to_array<const N: usize>(s: &str) -> [u8; N] {
    let bytes: Vec<u8> = (0..s.len())
        .step_by(2)
        .map(|i| u8::from_str_radix(&s[i..i + 2], 16).unwrap())
        .collect();
    let mut arr = [0u8; N];
    arr.copy_from_slice(&bytes);
    arr
}

fn main() {
    // Initialize BN254 curve
    assert!(init(), "mcl initialization failed");
    println!("mcl BN254 initialized (version: {})", mcl_bn254::bn254::get_version());

    // --- G1 point addition ---
    let p1 = G1::from_eth(&hex_to_array::<64>(
        "18b18acfb4c2c30276db5411368e7185b311dd124691610c5d3b74034e093dc9\
         063c909c4720840cb5134cb9f59fa749755796819658d32efc0d288198f37266",
    ))
    .expect("valid G1 point");

    let p2 = G1::from_eth(&hex_to_array::<64>(
        "07c2b7f58a84bd6145f00c9c2bc0bb1a187f20ff2c92963a88019e7c6a014eed\
         06614e20c147e940f2d70da3f74c9a17df361706a4485c742bd6788478fa17d7",
    ))
    .expect("valid G1 point");

    let sum = p1.add(&p2);
    println!("G1 addition: OK (result is_zero={})", sum.is_zero());

    // --- Scalar multiplication ---
    let scalar = Fr::from_be_bytes(&hex_to_array::<32>(
        "00000000000000000000000000000000000000000000000011138ce750fa15c2",
    ));
    let product = p1.mul(&scalar);
    println!("G1 scalar mul: OK (result is_zero={})", product.is_zero());

    // --- Pairing ---
    let g1 = G1::from_eth(&hex_to_array::<64>(
        "1c76476f4def4bb94541d57ebba1193381ffa7aa76ada664dd31c16024c43f59\
         3034dd2920f673e204fee2811c678745fc819b55d3e9d294e45c9b03a76aef41",
    ))
    .expect("valid G1 point");

    let g2 = G2::from_eth(&hex_to_array::<128>(
        "209dd15ebff5d46c4bd888e51a93cf99a7329636c63514396b4a452003a35bf7\
         04bf11ca01483bfa8b34b43561848d28905960114c8ac04049af4b6315a41678\
         2bb8324af6cfc93537a2ad1a445cfd0ca2a71acd7ac41fadbf933c2a51be344d\
         120a2a4cf30c1bf9845f20c6fe39e07ea2cce61f0c9bb048165fe5e4de877550",
    ))
    .expect("valid G2 point");

    let gt = pairing(&g1, &g2);
    println!("Pairing computed: is_one={}", gt.is_one());

    // --- Pairing check (Ethereum ecPairing precompile) ---
    let input = hex_to_array::<384>(
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

    let g1_a = G1::from_eth(input[0..64].try_into().unwrap()).unwrap();
    let g2_a = G2::from_eth(input[64..192].try_into().unwrap()).unwrap();
    let g1_b = G1::from_eth(input[192..256].try_into().unwrap()).unwrap();
    let g2_b = G2::from_eth(input[256..384].try_into().unwrap()).unwrap();

    let check = pairing_check(&[g1_a, g1_b], &[g2_a, g2_b]);
    println!("Pairing check (2 pairs): {}", check);

    // Empty pairing check
    let empty_check = pairing_check(&[], &[]);
    println!("Empty pairing check: {}", empty_check);

    println!("\nAll operations completed successfully!");
}
