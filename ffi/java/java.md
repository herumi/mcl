# JNI for mcl (experimental)
This library provides functionality to compute the optimal ate pairing
over Barreto-Naehrig (BN) curves.

# Initialization
Load the library `mcl_bn256`.
```
import com.herumi.mcl.*;

System.loadLibrary("mcl_bn256");
```

# Classes
* `G1` ; The cyclic group instantiated as E(Fp)[r] where where r = p + 1 - t.
* `G2` ; The cyclic group instantiated as the inverse image of E'(Fp^2)[r].
* `GT` ; The cyclic group in the image of the optimal ate pairing.
    * `e : G1 x G2 -> GT`
* `Fr` ; The finite field with characteristic r.

# Methods and Functions
## Fr
* `Fr::setInt(int x)` ; set by x
* `Fr::setStr(String str)` ; set by str such as "123", "0xfff", etc.
* `Fr::setRand()` ; randomly set
* `Bn256.neg(Fr y, Fr x)` ; `y = -x`
* `Bn256.add(Fr z, Fr x, Fr y)` ; `z = x + y`
* `Bn256.sub(Fr z, Fr x, Fr y)` ; `z = x - y`
* `Bn256.mul(Fr z, Fr x, Fr y)` ; `z = x * y`
* `Bn256.div(Fr z, Fr x, Fr y)` ; `z = x / y`

## G1

* `G1::set(String x, String y)` ; set by (x, y)
* `G1::hashAndMapToG1(String m)` ; take SHA-256 of m and map it to an element of G1
* `G1::setStr(String str)` ; set by the result of `toString()` method
* `Bn256.neg(G1 y, G1 x)` ; `y = -x`
* `Bn256.dbl(G1 y, G1 x)` ; `y = 2x`
* `Bn256.add(G1 z, G1 x, G1 y)` ; `z = x + y`
* `Bn256.sub(G1 z, G1 x, G1 y)` ; `z = x - y`
* `Bn256.mul(G1 z, G1 x, Fr y)` ; `z = x * y`

## G2

* `G2::set(String xa, String xb, String ya, String yb)` ; set by ((xa, xb), (ya, yb))
* `G2::setStr(String str)` ; set by the result of `toString()` method
* `Bn256.neg(G2 y, G2 x)` ; `y = -x`
* `Bn256.dbl(G2 y, G2 x)` ; `y = 2x`
* `Bn256.add(G2 z, G2 x, G2 y)` ; `z = x + y`
* `Bn256.sub(G2 z, G2 x, G2 y)` ; `z = x - y`
* `Bn256.mul(G2 z, G2 x, Fr y)` ; `z = x * y`

## GT

* `GT::setStr(String str)` ; set by the result of `toString()` method
* `Bn256.mul(GT z, GT x, GT y)` ; `z = x * y`
* `Bn256.pow(GT z, GT x, Fr y)` ; `z = x ^ y`

## pairing
* `Bn256.pairing(GT e, G1 P, G2 Q)` ; e = e(P, Q)

# BLS signature sample
```
String xa = "12723517038133731887338407189719511622662176727675373276651903807414909099441";
String xb = "4168783608814932154536427934509895782246573715297911553964171371032945126671";
String ya = "13891744915211034074451795021214165905772212241412891944830863846330766296736";
String yb = "7937318970632701341203597196594272556916396164729705624521405069090520231616";

G2 Q = new G2(xa, xb, ya, yb); // fixed point of G2

Fr s = new Fr();
s.setRand(); // secret key
G2 pub = new G2();
Bn256.mul(pub, Q, s); // public key = sQ

String m = "signature test";
G1 H = new G1();
H.hashAndMapToG1(m); // H = Hash(m)
G1 sign = new G1();
Bn256.mul(sign, H, s); // signature of m = s H

GT e1 = new GT();
GT e2 = new GT();
Bn256.pairing(e1, H, pub); // e1 = e(H, s Q)
Bn256.pairing(e2, sign, Q); // e2 = e(s H, Q);
assertBool("verify signature", e1.equals(e2));
```

# Make test
```
cd java
make test_bn256
```

# Sample code
[Bn256Test.java](https://github.com/herumi/mcl/blob/master/ffi/java/Bn256Test.java)
