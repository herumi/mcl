package mcl

import "testing"

func testPairing(t *testing.T) {
	err := Init(CurveFp254BNb)
	if err != nil {
		t.Error(err)
	}
	var a, b, ab Fr
	a.SetString("12345678901", 10)
	b.SetString("abcdef0abcd", 16)
	FrMul(&ab, &a, &b)
	var P, aP G1
	var Q, bQ G2
	P.HashAndMapTo([]byte("this"))
	G1Mul(&aP, &P, &a)
	Q.HashAndMapTo([]byte("that"))
	G2Mul(&bQ, &Q, &b)
	var e1, e2 GT
	Pairing(&e1, &P, &Q)
	Pairing(&e2, &aP, &bQ)
	GTPow(&e2, &e2, &ab)
	if !e1.IsEqual(&e2) {
		t.Error("not equal pairing")
	}
}
