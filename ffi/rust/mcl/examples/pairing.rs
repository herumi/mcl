use mcl::*;

fn main() {
    let a_str = "123";
    let b_str = "456";
    mcl_bn_init(BLS12_381, MCLBN_COMPILED_TIME_VAR);
    let a = MclBnFr::from_str(a_str, Base::Dec);
    let b = MclBnFr::from_str(b_str, Base::Dec);
    let ab = a * b;
    println!("{} x {} = {}", a_str, b_str, ab.get_str(Base::Dec));

    let P = MclBnG1::hash_and_map(b"this").unwrap();
    let Q = MclBnG2::hash_and_map(b"that").unwrap();
    println!("{}", P.get_str(Base::Hex));
    println!("{}", Q.get_str(Base::Hex));

    let aP = &P * a;
    let bQ = &Q * b;

    let e = MclBnGT::from_pairing(&P, &Q);
    println!("{}", e.get_str(Base::Hex));
    let e1 = e.pow(&a);
    let e2 = MclBnGT::from_pairing(&aP, &Q);
    assert_eq!(e1, e2);

    let e1 = e.pow(&b);
    let e2 = MclBnGT::from_pairing(&P, &bQ);
    assert_eq!(e1, e2);
}
