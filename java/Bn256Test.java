import java.io.*;
import com.herumi.mcl.*;

/*
	Bn256Test
*/
public class Bn256Test {
	static {
		String lib = "mcl_bn256";
		String libName = System.mapLibraryName(lib);
		System.out.println("libName : " + libName);
		System.loadLibrary(lib);
	}
	public static void assertEquals(String msg, String x, String y) {
		if (x.equals(y)) {
			System.out.println("OK : " + msg);
		} else {
			System.out.println("NG : " + msg + ", x = " + x + ", y = " + y);
		}
	}
	public static void assertBool(String msg, boolean b) {
		if (b) {
			System.out.println("OK : " + msg);
		} else {
			System.out.println("NG : " + msg);
		}
	}
	public static void main(String argv[]) {
		try {
			Bn256.SystemInit();
			Fr x = new Fr(5);
			Fr y = new Fr(-2);
			Fr z = new Fr(5);
			assertBool("x != y", !x.equals(y));
			assertBool("x == z", x.equals(z));
			assertEquals("x == 5", x.toString(), "5");
			Bn256.add(x, x, y);
			assertEquals("x == 3", x.toString(), "3");
			Bn256.mul(x, x, x);
			assertEquals("x == 9", x.toString(), "9");
			G1 P = new G1();
			System.out.println("P=" + P);
			P.set("-1", "1");
			System.out.println("P=" + P);
			Bn256.neg(P, P);
			System.out.println("P=" + P);

			String xa = "12723517038133731887338407189719511622662176727675373276651903807414909099441";
			String xb = "4168783608814932154536427934509895782246573715297911553964171371032945126671";
			String ya = "13891744915211034074451795021214165905772212241412891944830863846330766296736";
			String yb = "7937318970632701341203597196594272556916396164729705624521405069090520231616";

			G2 Q = new G2(xa, xb, ya, yb);

			P.hashAndMapToG1("This is a pen");
			{
				String s = P.toString();
				G1 P1 = new G1();
				P1.setStr(s);
				assertBool("P == P1", P1.equals(P));
			}

			GT e = new GT();
			Bn256.pairing(e, P, Q);
			GT e1 = new GT();
			GT e2 = new GT();
			Fr c = new Fr("1234567890123234928348230428394234");
			G2 cQ = new G2(Q);
			Bn256.mul(cQ, Q, c); // cQ = Q * c
			Bn256.pairing(e1, P, cQ);
			Bn256.pow(e2, e, c); // e2 = e^c
			assertBool("e1 == e2", e1.equals(e2));

			G1 cP = new G1(P);
			Bn256.mul(cP, P, c); // cP = P * c
			Bn256.pairing(e1, cP, Q);
			assertBool("e1 == e2", e1.equals(e2));

			BLSsignature(Q);
		} catch (RuntimeException e) {
			System.out.println("unknown exception :" + e);
		}
	}
	public static void BLSsignature(G2 Q)
	{
		Fr s = new Fr();
		s.setRand(); // secret key
		System.out.println("secret key " + s);
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
	}
}
