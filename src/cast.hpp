#pragma once

#include <mcl/bn.h>
#include <mcl/bn.hpp>

namespace mcl {

inline Fr *cast(mclBnFr *p) { return reinterpret_cast<Fr*>(p); }
inline const Fr *cast(const mclBnFr *p) { return reinterpret_cast<const Fr*>(p); }

inline G1 *cast(mclBnG1 *p) { return reinterpret_cast<G1*>(p); }
inline const G1 *cast(const mclBnG1 *p) { return reinterpret_cast<const G1*>(p); }

inline G2 *cast(mclBnG2 *p) { return reinterpret_cast<G2*>(p); }
inline const G2 *cast(const mclBnG2 *p) { return reinterpret_cast<const G2*>(p); }

inline Fp12 *cast(mclBnGT *p) { return reinterpret_cast<Fp12*>(p); }
inline const Fp12 *cast(const mclBnGT *p) { return reinterpret_cast<const Fp12*>(p); }

inline Fp6 *cast(uint64_t *p) { return reinterpret_cast<Fp6*>(p); }
inline const Fp6 *cast(const uint64_t *p) { return reinterpret_cast<const Fp6*>(p); }

inline Fp2 *cast(mclBnFp2 *p) { return reinterpret_cast<Fp2*>(p); }
inline const Fp2 *cast(const mclBnFp2 *p) { return reinterpret_cast<const Fp2*>(p); }

inline Fp *cast(mclBnFp *p) { return reinterpret_cast<Fp*>(p); }
inline const Fp *cast(const mclBnFp *p) { return reinterpret_cast<const Fp*>(p); }

} // mcl
