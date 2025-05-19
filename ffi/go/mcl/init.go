package mcl

/*
#cgo LDFLAGS:-lmcl
#include <mcl/bn_c384_256.h>
*/
import "C"
import "fmt"

// Init --
// call this function before calling all the other operations
// this function is not thread safe
func Init(curve int) error {
	err := C.mclBn_init(C.int(curve), C.MCLBN_COMPILED_TIME_VAR)
	if err != 0 {
		return fmt.Errorf("ERR mclBn_init curve=%d", curve)
	}
	return nil
}
