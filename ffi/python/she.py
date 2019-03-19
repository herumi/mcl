import os
import platform
from ctypes import *

MCL_BN254 = 0
MCLBN_FR_UNIT_SIZE = 4
MCLBN_FP_UNIT_SIZE = 4

FR_SIZE = MCLBN_FR_UNIT_SIZE
G1_SIZE = MCLBN_FP_UNIT_SIZE * 3
G2_SIZE = MCLBN_FP_UNIT_SIZE * 6
GT_SIZE = MCLBN_FP_UNIT_SIZE * 12

SEC_SIZE = FR_SIZE * 2
PUB_SIZE = G1_SIZE + G2_SIZE
G1_CIPHER_SIZE = G1_SIZE * 2
G2_CIPHER_SIZE = G2_SIZE * 2
GT_CIPHER_SIZE = GT_SIZE * 4

MCLBN_COMPILED_TIME_VAR = (MCLBN_FR_UNIT_SIZE * 10) + MCLBN_FP_UNIT_SIZE

Buffer = c_ubyte * 1536
lib = None

def init(curveType=MCL_BN254):
	global lib
	name = platform.system()
	if name == 'Linux':
		suf = 'so'
	elif name == 'Darwin':
		suf = 'dylib'
	else:
		raise RuntimeError("not support yet", name)
	libname = "libmclshe256." + suf
	lib = cdll.LoadLibrary(libname)
	ret = lib.sheInit(MCL_BN254, MCLBN_COMPILED_TIME_VAR)
	if ret != 0:
		raise RuntimeError("sheInit", ret)
	# custom setup for a function which returns pointer
	lib.shePrecomputedPublicKeyCreate.restype = c_void_p

def setRangeForDLP(hashSize):
	ret = lib.sheSetRangeForDLP(hashSize)
	if ret != 0:
		raise RuntimeError("setRangeForDLP", ret)

def setTryNum(tryNum):
	ret = lib.sheSetTryNum(tryNum)
	if ret != 0:
		raise RuntimeError("setTryNum", ret)

def hexStr(v):
	s = ""
	for x in v:
		s += format(x, '02x')
	return s

class CipherTextG1(Structure):
	_fields_ = [("v", c_ulonglong * G1_CIPHER_SIZE)]
	def serialize(self):
		buf = Buffer()
		ret = lib.sheCipherTextG1Serialize(byref(buf), len(buf), byref(self.v))
		if ret == 0:
			raise RuntimeError("serialize")
		return buf[0:ret]
	def serializeToHexStr(self):
		return hexStr(self.serialize())

class CipherTextG2(Structure):
	_fields_ = [("v", c_ulonglong * G2_CIPHER_SIZE)]
	def serialize(self):
		buf = Buffer()
		ret = lib.sheCipherTextG2Serialize(byref(buf), len(buf), byref(self.v))
		if ret == 0:
			raise RuntimeError("serialize")
		return buf[0:ret]
	def serializeToHexStr(self):
		return hexStr(self.serialize())

class CipherTextGT(Structure):
	_fields_ = [("v", c_ulonglong * GT_CIPHER_SIZE)]
	def serialize(self):
		buf = Buffer()
		ret = lib.sheCipherTextGTSerialize(byref(buf), len(buf), byref(self.v))
		if ret == 0:
			raise RuntimeError("serialize")
		return buf[0:ret]
	def serializeToHexStr(self):
		return hexStr(self.serialize())

class PrecomputedPublicKey(Structure):
	def __init__(self):
		self.p = 0
	def create(self):
		if not self.p:
			self.p = c_void_p(lib.shePrecomputedPublicKeyCreate())
			if self.p == 0:
				raise RuntimeError("PrecomputedPublicKey::create")
	def destroy(self):
		lib.shePrecomputedPublicKeyDestroy(self.p)
	def encG1(self, m):
		c = CipherTextG1()
		ret = lib.shePrecomputedPublicKeyEncG1(byref(c.v), self.p, m)
		if ret != 0:
			raise RuntimeError("encG1", m)
		return c
	def encG2(self, m):
		c = CipherTextG2()
		ret = lib.shePrecomputedPublicKeyEncG2(byref(c.v), self.p, m)
		if ret != 0:
			raise RuntimeError("encG2", m)
		return c
	def encGT(self, m):
		c = CipherTextGT()
		ret = lib.shePrecomputedPublicKeyEncGT(byref(c.v), self.p, m)
		if ret != 0:
			raise RuntimeError("encGT", m)
		return c

class PublicKey(Structure):
	_fields_ = [("v", c_ulonglong * PUB_SIZE)]
	def serialize(self):
		buf = Buffer()
		ret = lib.shePublicKeySerialize(byref(buf), len(buf), byref(self.v))
		if ret == 0:
			raise RuntimeError("serialize")
		return buf[0:ret]
	def serializeToHexStr(self):
		return hexStr(self.serialize())
	def encG1(self, m):
		c = CipherTextG1()
		ret = lib.sheEncG1(byref(c.v), byref(self.v), m)
		if ret != 0:
			raise RuntimeError("encG1", m)
		return c
	def encG2(self, m):
		c = CipherTextG2()
		ret = lib.sheEncG2(byref(c.v), byref(self.v), m)
		if ret != 0:
			raise RuntimeError("encG2", m)
		return c
	def encGT(self, m):
		c = CipherTextGT()
		ret = lib.sheEncGT(byref(c.v), byref(self.v), m)
		if ret != 0:
			raise RuntimeError("encGT", m)
		return c
	def createPrecomputedPublicKey(self):
		ppub = PrecomputedPublicKey()
		ppub.create()
		ret = lib.shePrecomputedPublicKeyInit(ppub.p, byref(self.v))
		if ret != 0:
			raise RuntimeError("createPrecomputedPublicKey")
		return ppub

class SecretKey(Structure):
	_fields_ = [("v", c_ulonglong * SEC_SIZE)]
	def setByCSPRNG(self):
		ret = lib.sheSecretKeySetByCSPRNG(byref(self.v))
		if ret != 0:
			raise RuntimeError("setByCSPRNG", ret)
	def serialize(self):
		buf = Buffer()
		ret = lib.sheSecretKeySerialize(byref(buf), len(buf), byref(self.v))
		if ret == 0:
			raise RuntimeError("serialize")
		return buf[0:ret]
	def serializeToHexStr(self):
		return hexStr(self.serialize())
	def getPulicKey(self):
		pub = PublicKey()
		lib.sheGetPublicKey(byref(pub.v), byref(self.v))
		return pub
	def dec(self, c):
		m = c_longlong()
		if isinstance(c, CipherTextG1):
			ret = lib.sheDecG1(byref(m), byref(self.v), byref(c.v))
		elif isinstance(c, CipherTextG2):
			ret = lib.sheDecG2(byref(m), byref(self.v), byref(c.v))
		elif isinstance(c, CipherTextGT):
			ret = lib.sheDecGT(byref(m), byref(self.v), byref(c.v))
		if ret != 0:
			raise RuntimeError("dec")
		return m.value

def neg(c):
	ret = -1
	if isinstance(c, CipherTextG1):
		out = CipherTextG1()
		ret = lib.sheNegG1(byref(out.v), byref(c.v))
	elif isinstance(c, CipherTextG2):
		out = CipherTextG2()
		ret = lib.sheNegG2(byref(out.v), byref(c.v))
	elif isinstance(c, CipherTextGT):
		out = CipherTextGT()
		ret = lib.sheNegGT(byref(out.v), byref(c.v))
	if ret != 0:
		raise RuntimeError("neg")
	return out

def add(cx, cy):
	ret = -1
	if isinstance(cx, CipherTextG1) and isinstance(cy, CipherTextG1):
		out = CipherTextG1()
		ret = lib.sheAddG1(byref(out.v), byref(cx.v), byref(cy.v))
	elif isinstance(cx, CipherTextG2) and isinstance(cy, CipherTextG2):
		out = CipherTextG2()
		ret = lib.sheAddG2(byref(out.v), byref(cx.v), byref(cy.v))
	elif isinstance(cx, CipherTextGT) and isinstance(cy, CipherTextGT):
		out = CipherTextGT()
		ret = lib.sheAddGT(byref(out.v), byref(cx.v), byref(cy.v))
	if ret != 0:
		raise RuntimeError("add")
	return out

def sub(cx, cy):
	ret = -1
	if isinstance(cx, CipherTextG1) and isinstance(cy, CipherTextG1):
		out = CipherTextG1()
		ret = lib.sheSubG1(byref(out.v), byref(cx.v), byref(cy.v))
	elif isinstance(cx, CipherTextG2) and isinstance(cy, CipherTextG2):
		out = CipherTextG2()
		ret = lib.sheSubG2(byref(out.v), byref(cx.v), byref(cy.v))
	elif isinstance(cx, CipherTextGT) and isinstance(cy, CipherTextGT):
		out = CipherTextGT()
		ret = lib.sheSubGT(byref(out.v), byref(cx.v), byref(cy.v))
	if ret != 0:
		raise RuntimeError("sub")
	return out

def mul(cx, cy):
	ret = -1
	if isinstance(cx, CipherTextG1) and isinstance(cy, CipherTextG2):
		out = CipherTextGT()
		ret = lib.sheMul(byref(out.v), byref(cx.v), byref(cy.v))
	elif isinstance(cx, CipherTextG1) and isinstance(cy, int):
		out = CipherTextG1()
		ret = lib.sheMulG1(byref(out.v), byref(cx.v), cy)
	elif isinstance(cx, CipherTextG2) and isinstance(cy, int):
		out = CipherTextG2()
		ret = lib.sheMulG2(byref(out.v), byref(cx.v), cy)
	elif isinstance(cx, CipherTextGT) and isinstance(cy, int):
		out = CipherTextGT()
		ret = lib.sheMulGT(byref(out.v), byref(cx.v), cy)
	if ret != 0:
		raise RuntimeError("mul")
	return out

if __name__ == '__main__':
	init()
	sec = SecretKey()
	sec.setByCSPRNG()
	print("sec=", sec.serializeToHexStr())
	pub = sec.getPulicKey()
	print("pub=", pub.serializeToHexStr())

	m11 = 1
	m12 = 5
	m21 = 3
	m22 = -4
	c11 = pub.encG1(m11)
	c12 = pub.encG1(m12)
	# dec(enc) for G1
	if sec.dec(c11) != m11: print("err1")

	# add/sub for G1
	if sec.dec(add(c11, c12)) != m11 + m12: print("err2")
	if sec.dec(sub(c11, c12)) != m11 - m12: print("err3")

	# add/sub for G2
	c21 = pub.encG2(m21)
	c22 = pub.encG2(m22)
	if sec.dec(c21) != m21: print("err4")
	if sec.dec(add(c21, c22)) != m21 + m22: print("err5")
	if sec.dec(sub(c21, c22)) != m21 - m22: print("err6")

	mt = -56
	ct = pub.encGT(mt)
	if sec.dec(ct) != mt: print("err7")

	# mul G1 and G2
	if sec.dec(mul(c11, c21)) != m11 * m21: print("err8")

	# use precomputedPublicKey for performance
	ppub = pub.createPrecomputedPublicKey()
	c1 = ppub.encG1(m11)
	if sec.dec(c1) != m11: print("err9")

	import sys
	if sys.version_info.major >= 3:
		import timeit
		N = 100000
		print(str(timeit.timeit("pub.encG1(12)", number=N, globals=globals()) / float(N) * 1e3) + "msec")
		print(str(timeit.timeit("ppub.encG1(12)", number=N, globals=globals()) / float(N) * 1e3) + "msec")

	ppub.destroy() # necessary to avoid memory leak

