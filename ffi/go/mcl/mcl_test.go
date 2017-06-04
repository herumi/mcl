package mcl

import "testing"

func testFr(t *testing.T) {
	err := Init(CurveFp254BNb)
	if err != nil {
		t.Error(err)
	}
}
