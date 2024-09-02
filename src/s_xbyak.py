# s_xbyak : ASM generation tool for GAS/NASM/MASM with Xbyak-like syntax in Python
# This file provides a Xbyak-like DSL to generate a asm code for nasm/yasm/gas .
# i.e., static version of xbyak
# Author : MITSUNARI Shigeo(@herumi)
# License : modified new BSD license (http://opensource.org/licenses/BSD-3-Clause)
import struct
import re
import argparse

VERSION="0.9.5"

def getDefaultParser(description='s_xbyak'):
  parser = argparse.ArgumentParser(description=description)
  parser.add_argument('-win', '--win', help='Win64 ABI(default:Amd64 ABI)', action='store_true')
  parser.add_argument('-m', '--mode', help='asm mode(nasm|masm|gas)', default='nasm')
  return parser

RE_HEX_STR=r'\b0x([0-9a-f]+)\b'

RAX = 0
RCX = 1
RDX = 2
RBX = 3
RSP = 4
RBP = 5
RSI = 6
RDI = 7
R8 = 8
R9 = 9
R10 = 10
R11 = 11
R12 = 12
R13 = 13
R14 = 14
R15 = 15

g_nasm = False # nasm syntax
g_gas = False # gas syntax
g_masm = False # masm syntax
g_text = []
g_undefLabel = {}
g_defLabelN = 1
g_undefLabelN = 1

def getLine():
  return len(g_text)

T_REG = 0
T_FPU = 1
T_SSE = 2
T_XMM = 3 # contains ymm, zmm
T_YMM = 4
T_ZMM = 5
T_MASK = 6 # k1, k2, ...
T_ATTR = 7
T_MMX = 8

# attr
# one of (sae, rn, rd, ru, rz) or zero
T_ZERO = 1
T_SAE = (1<<1)
T_RN =  (2<<1)
T_RD =  (3<<1)
T_RU =  (4<<1)
T_RZ =  (5<<1)

masmSizePrefixTbl = { 8 : 'byte', 16 : 'word', 32 : 'dword', 64 : 'qword', 128 : 'xmmword', 256 : 'ymmword', 512 : 'zmmword' }

def mergeAttr(attr1, attr2):
  if (attr1>>1) and (attr2>>1):
    raise Exception("can't merge attr", attr1, attr2)
  return attr1 | attr2

class Operand:
  def __init__(self, idx=0, bit=0, kind=T_REG, attr=0):
    self.idx = idx
    self.bit = bit
    self.kind = kind
    self.attr = attr
  def copy(self):
    r = Operand()
    r.idx = self.idx
    r.bit = self.bit
    r.kind = self.kind
    r.attr = self.attr
    if hasattr(self, 'k'):
      r.k = self.k
    return r

  def getTypeStr(self):
    if self.kind == T_REG: return f'r{self.bit}'
    if self.kind == T_FPU: return f'f{self.bit}'
    if self.kind == T_MMX: return 'mm'
    if self.kind == T_SSE: return 'xmm'
    if self.kind == T_XMM: return 'xmm'
    if self.kind == T_YMM: return 'ymm'
    if self.kind == T_ZMM: return 'zmm'
    if self.kind == T_MASK: return 'k'
    raise Exception('not supported type', self)

  def __str__(self):
    if self.kind == T_REG:
      if self.bit == 64:
        tbl = ['rax', 'rcx', 'rdx', 'rbx', 'rsp', 'rbp', 'rsi', 'rdi', 'r8', 'r9', 'r10',  'r11', 'r12', 'r13', 'r14', 'r15']
      elif self.bit == 32:
        tbl = ['eax', 'ecx', 'edx', 'ebx', 'esp', 'ebp', 'esi', 'edi', 'r8d', 'r9d', 'r10d',  'r11d', 'r12d', 'r13d', 'r14d', 'r15d']
      elif self.bit == 8:
        tbl = ['al', 'cl', 'dl', 'bl', 'ah', 'ch', 'dh', 'bh', 'r8b', 'r9b', 'r10b',  'r11b', 'r12b', 'r13b', 'r14b', 'r15b']
      else:
        raise Exception('bad bit', self.bit)
      s = '%' if g_gas else ''
      return s + tbl[self.idx]

    # xmm4|k3, k1|k2
    s = '%' if g_gas else ''
    if self.bit >= 128:
      if self.bit == 128:
        s += 'x'
      elif self.bit == 256:
        s += 'y'
      elif self.bit == 512:
        s += 'z'
      s += f'mm{self.idx}'
    elif self.kind == T_MASK:
      s += f'k{self.idx}'
    elif self.kind == T_ATTR:
      tbl = {
        T_SAE : 'sae',
        T_RN : 'rn-sae',
        T_RD : 'rd-sae',
        T_RU : 'ru-sae',
        T_RZ : 'rz-sae',
      }
      # no % even if g_gas
      # ignore T_z
      s = '{' + tbl[self.attr & ~1] + '}'
      return s
    else:
      raise Exception('bad kind', self.kind)
    if hasattr(self, 'k') and self.k.idx > 0:
      s += f'{{{self.k}}}'
    if (self.attr & T_ZERO) != 0:
      s += '{z}'
    return s

  def __mul__(self, scale):
    if isinstance(scale, int) and scale in [1, 2, 4, 8]:
      return RegExp(None, self, scale)
    raise Exception('bad scale', scale)

  def __add__(self, rhs):
    if isinstance(rhs, int):
      return RegExp(self, None, 1, rhs)
    if isinstance(rhs, RegExp):
      return RegExp(self, rhs.index, rhs.scale, rhs.offset)
    if rhs.kind == T_REG:
      return RegExp(self, rhs)
    raise Exception('bad add type', rhs)

  def __sub__(self, rhs):
    if not isinstance(rhs, int):
      raise Exception('bad sub type', rhs)
    return RegExp(self, None, 1, -rhs)

  def __or__(self, rhs):
    if rhs.kind == T_MASK:
      r = self.copy()
      r.k = rhs
      return r
    elif rhs.kind == T_ATTR:
      r = self.copy()
      r.attr = mergeAttr(r.attr, rhs.attr)
      if hasattr(rhs, 'k'):
        r.k = rhs.k
      return r
    else:
      raise Exception('bad arg', k)

class Reg(Operand):
  def __init__(self, idx, bit):
    super().__init__(idx, bit, T_REG)

class Xmm(Reg):
  def __init__(self, idx):
    super().__init__(idx, 128)
    self.kind = T_XMM

class Ymm(Reg):
  def __init__(self, idx):
    super().__init__(idx, 256)
    self.kind = T_YMM

class Zmm(Reg):
  def __init__(self, idx):
    super().__init__(idx, 512)
    self.kind = T_ZMM

class MaskReg(Reg):
  def __init__(self, idx):
    super().__init__(idx, 64)
    self.kind = T_MASK

class Attribute(Operand):
  def __init__(self, attr):
    super().__init__(0, 0, T_ATTR, attr)

T_z = Attribute(T_ZERO)
T_sae = Attribute(T_SAE)
T_rn_sae = Attribute(T_RN)
T_rd_sae = Attribute(T_RD)
T_ru_sae = Attribute(T_RU)
T_rz_sae = Attribute(T_RZ)

class PreferredEncoding:
  def __init__(self, v):
    self.v = v
  def __str__(self):
    s = ''
    if self.v == 0:
      return ''
    if self.v == 1:
      s = 'vex' # nasm does not support it?
    elif self.v == 2:
      s = 'evex'
    if g_masm:
      return s + ' '
    if g_gas or g_nasm:
      return f'{{{s}}} '

DefaultEncoding = PreferredEncoding(0)
VexEncoding = PreferredEncoding(1)
EvexEncoding = PreferredEncoding(2)

class RegExp:
  def __init__(self, reg, index = None, scale = 1, offset = 0):
    self.base = reg
    self.index = index
    self.scale = scale
    self.offset = offset
  def __add__(self, rhs):
    if type(rhs) == int:
      return RegExp(self.base, self.index, self.scale, self.offset + rhs)
    if type(rhs) == Reg:
      if self.index:
        raise Exception('already index exists', self.index, rhs)
      return RegExp(self.base, rhs.base, rhs.scale, self.offset + rhs.offset)
    raise Exception(f'bad add self={self} rhs={rhs}')
  def __sub__(self, rhs):
    if type(rhs) == int:
      return RegExp(self.base, self.index, self.scale, self.offset - rhs)
    raise Exception(f'bad sub self={self} rhs={rhs}')
  def __str__(self):
    if g_gas:
      s = '('
      if self.offset:
        s = f'{self.offset}('
      if self.base:
        s += str(self.base)
      if self.index:
        s += f',{self.index},{self.scale}'
      return s + ')'
    s = ''
    if self.base:
      s += str(self.base)
    if self.index:
      if s:
        s += '+'
      s += str(self.index)
      if self.scale > 1:
        s += '*' + str(self.scale)
    if self.offset:
      if self.offset > 0:
        s += '+'
      s += str(self.offset)
    return s

class Address:
  def __init__(self, exp=None, bit=0, broadcast=False):
    self.exp = exp
    self.bit = bit
    self.broadcast = broadcast
    self.broadcastRate = 0
  def getTypeStr(self):
    return f'm{self.bit}'
  def copy(self):
    r = Address()
    r.exp = self.exp
    r.bit = self.bit
    r.broadcast = self.broadcast
    r.broadcastRate = self.broadcastRate
    if hasattr(self, 'k'):
      r.k = self.k
    return r

  # compute X of {1toX} by bitSize and T_B64, T_B32.
  def setBroadcastRage(self, name, bitSize):
    if self.bit > 0:
      bitSize = self.bit
    if name in avx512broadcastTbl:
      self.broadcastRate = bitSize // avx512broadcastTbl[name]
      self.bit = bitSize // self.broadcastRate
  def getBroadcastStr(self):
    if self.broadcast and self.broadcastRate > 0:
      return f'{{1to{self.broadcastRate}}}'
    return ''
  def __str__(self):
    maskStr = ''
    if hasattr(self, 'k') and self.k.idx > 0:
      maskStr = f'{{{self.k}}}'
    if g_gas:
      if type(self.exp) == Reg:
        s = '(' + str(self.exp) + ')'
      else:
        s = str(self.exp)
      s += self.getBroadcastStr() + maskStr
      return s
    if isinstance(self.exp, RipReg):
      s = str(self.exp)
    else:
      s = '[' + str(self.exp) + ']'
    if g_nasm:
      tbl = {
        8 : 'byte',
        16 : 'word',
        32 : 'dword',
        64 : 'qword',
        128 : 'oword',
        256 : 'yword',
        512 : 'zword'
      }
      if self.bit > 0 and not self.broadcast:
        s = tbl[self.bit] + ' ' + s
      return s + self.getBroadcastStr() + maskStr
    # g_masm
    if self.broadcast:
      # To distinguish vcvtpd2dq(xmm0, ptr_b(rax)) and vcvtpd2dq(xmm0, yword_b(rax)) on masm, but that doesn't seem to affect NASM (bug?).
      # https://developercommunity.visualstudio.com/t/ml64exe-cant-deal-with-vcvtpd2dq-xmm0/10352105
      if hasattr(self, 'bitForAddress'):
        s = f'{masmSizePrefixTbl[self.bitForAddress]} ptr ' + s
      s = f'{masmSizePrefixTbl[self.bit]} bcst ' + s
    else:
      if self.bit > 0:
        s = f'{masmSizePrefixTbl[self.bit]} ptr ' + s
    return s + maskStr

  def __or__(self, rhs):
    if rhs.kind == T_MASK:
      r = self.copy()
      r.k = rhs
      return r
    else:
      raise Exception('bad arg', k)

  def __add__(self, v):
    if not isinstance(v, int):
      raise Exception('not int', v)
    r = self.copy()
    r.exp = r.exp + v
    return r

class RipReg:
  def __init__(self, v=0):
    if isinstance(v, int):
      self.label = None
      self.offset = v
    else:
      self.label = v
      self.offset = 0
  def getTypeStr(self):
    return 'm0'

  def __str__(self):
    if self.label:
      if g_gas and isinstance(self.label, str):
        s = f'PRE({self.label})'
      else:
        s = str(self.label)
    else:
      s = ''
    if self.offset > 0:
      if s != '':
        s += '+'
      s += str(self.offset)
    elif self.offset < 0:
      s += str(self.offset)
    if s == '':
      s = '0'
    if g_gas:
      return f'{s}(%rip)'
    if g_masm:
      return f'{s}'
    # g_nasm
    return f'[rel {s}]'

  def __add__(self, v):
    r = RipReg(self.label)
    if isinstance(v, int):
      r.offset = self.offset + v
    elif r.label == None:
      r.label = v
    else:
      raise Exception('label is already set', r.label, v)
    return r


def ptr(exp):
  return Address(exp)

def byte(exp):
  return Address(exp, bit=8)

def word(exp):
  return Address(exp, bit=16)

def dword(exp):
  return Address(exp, bit=32)

def qword(exp):
  return Address(exp, bit=64)

def xword(exp):
  return Address(exp, bit=128)

def yword(exp):
  return Address(exp, bit=256)

def zword(exp):
  return Address(exp, bit=512)

def ptr_b(exp):
  return Address(exp, broadcast=True)

def xword_b(exp):
  return Address(exp, bit=128, broadcast=True)

def yword_b(exp):
  return Address(exp, bit=256, broadcast=True)

def zword_b(exp):
  return Address(exp, bit=512, broadcast=True)

"""
ptr(rip + label + offset)
"""
rip = RipReg()

rax = Reg(RAX, 64)
rcx = Reg(RCX, 64)
rdx = Reg(RDX, 64)
rbx = Reg(RBX, 64)
rsp = Reg(RSP, 64)
rbp = Reg(RBP, 64)
rsi = Reg(RSI, 64)
rdi = Reg(RDI, 64)
r8 = Reg(R8, 64)
r9 = Reg(R9, 64)
r10 = Reg(R10, 64)
r11 = Reg(R11, 64)
r12 = Reg(R12, 64)
r13 = Reg(R13, 64)
r14 = Reg(R14, 64)
r15 = Reg(R15, 64)

eax = Reg(RAX, 32)
ecx = Reg(RCX, 32)
edx = Reg(RDX, 32)
ebx = Reg(RBX, 32)
esp = Reg(RSP, 32)
ebp = Reg(RBP, 32)
esi = Reg(RSI, 32)
edi = Reg(RDI, 32)
r8d = Reg(R8, 32)
r9d = Reg(R9, 32)
r10d = Reg(R10, 32)
r11d = Reg(R11, 32)
r12d = Reg(R12, 32)
r13d = Reg(R13, 32)
r14d = Reg(R14, 32)
r15d = Reg(R15, 32)

al = Reg(RAX, 8)
cl = Reg(RCX, 8)
dl = Reg(RDX, 8)
bl = Reg(RBX, 8)
ah = Reg(RSP, 8)
ch = Reg(RBP, 8)
dh = Reg(RSI, 8)
bh = Reg(RDI, 8)
r8d = Reg(R8, 8)
r9d = Reg(R9, 8)
r10b = Reg(R10, 8)
r11b = Reg(R11, 8)
r12b = Reg(R12, 8)
r13b = Reg(R13, 8)
r14b = Reg(R14, 8)
r15b = Reg(R15, 8)

# define xmm, ymm, zmm registers
for (p, cstr) in [('x', Xmm), ('y', Ymm), ('z', Zmm)]:
  for idx in range(32):
    globals()[f'{p}mm{idx}'] = cstr(idx)
    globals()[f'{p}m{idx}'] = cstr(idx)

# define mask registers k0, ..., k7
for i in range(8):
  globals()[f'k{i}'] = MaskReg(i)

win64ABI = False

def setWin64ABI(win64):
  global win64ABI
  win64ABI = win64

win64Regs = [rcx, rdx, r8, r9, r10, r11, rdi, rsi, rbx, rbp, r12, r13, r14, r15]
linuxRegs = [rdi, rsi, rdx, rcx, r8, r9, r10, r11, rbx, rbp, r12, r13, r14, r15]

def getRegTbl():
  if win64ABI:
    return win64Regs
  else:
    return linuxRegs

def getReg(pos):
  return getRegTbl()[pos]

def getRcxPos():
  return 0 if win64ABI else 3

def getRdxPos():
  return 1 if win64ABI else 2

def getNoSaveNum():
  return 6 if win64ABI else 8

XMM_BYTE_SIZE = 16
def getSimdSize(vType):
  if vType == 0: return 0
  if vType == T_SSE: return 16
  if vType == T_XMM: return 16
  if vType == T_YMM: return 32
  if vType == T_ZMM: return 64
  raise Exception('bad vType', vType)

class StackFrame:
  def __init__(self, pNum, tNum=0, useRDX=False, useRCX=False, stackSizeByte=0, callRet=True, vNum=0, vType=0):
    """
      make a stackframe of a generated function
      pNum : # of function arguments assigned to self.p[pNum]
      tNum : # of temporary registers asigned to self.t[tNum]
      useRDX : set True if you want to use rdx
      useRCX : set True if you want to use rcx
      stackSizeByte : stack for local variables assigned to rsp[stackSizeByte]
      callRet : automatically restore registers and call ret()
      vNum : # of SIMD registers
      vType : SIMD type (T_SSE, T_XMM, T_YMM, T_ZMM)
    """
    self.pos = 0
    self.useRDX = useRDX
    self.useRCX = useRCX
    self.callRet = callRet
    self.p = []
    self.t = []
    self.v = []
    self.isCalledClose = False
    allRegNum = pNum + tNum + (1 if useRDX else 0) + (1 if useRCX else 0)
    noSaveNum = getNoSaveNum()
    self.saveNum = max(0, allRegNum - noSaveNum)
    tbl = getRegTbl()[noSaveNum:]
    for i in range(self.saveNum):
      push(tbl[i])

    # restore SIMD registers
    if vNum > 0 and vType == 0:
      raise Exception('specify vType')
    self.vType = vType

    maxFreeN = 5 if win64ABI else 32
    self.maxFreeN = maxFreeN
    saveSimdN = max(vNum - maxFreeN, 0)
    if win64ABI:
      saveSimdN = min(saveSimdN, 11) # save only xmm6-xmm15
    self.saveSimdN = saveSimdN
    simdSize = getSimdSize(vType)
    self.simdSize = simdSize
    for i in range(vNum):
      if vType in [T_SSE, T_XMM]:
        self.v.append(Xmm(i))
      elif vType == T_YMM:
        self.v.append(Ymm(i))
      elif vType == T_ZMM:
        self.v.append(Zmm(i))

    self.P = (stackSizeByte + 7) // 8
    if saveSimdN > 0:
      if self.P & 1 > 0:
        self.P += 1
      self.P += (saveSimdN * XMM_BYTE_SIZE) // 8
      self.saveTop = (stackSizeByte + 15) & ~15
    # 16 byte alignment
    if self.P > 0 and (self.P & 1) == (self.saveNum & 1):
      self.P += 1
    self.P *= 8
    if self.P > 0:
      sub(rsp, self.P)

    # store SIMD registers
    for i in range(saveSimdN):
      if vType == T_SSE:
        movups(ptr(rsp + self.saveTop + i * XMM_BYTE_SIZE), Xmm(maxFreeN+i))
      else:
        vmovups(ptr(rsp + self.saveTop + i * XMM_BYTE_SIZE), Xmm(maxFreeN+i))
    for i in range(pNum):
      self.p.append(self.getRegIdx())
    for i in range(tNum):
      self.t.append(self.getRegIdx())
    if self.useRCX and getRcxPos() < pNum:
      mov(r10, rcx)
    if self.useRDX and getRdxPos() < pNum:
      mov(r11, rdx)
  def close(self, callRet=True):
    if self.isCalledClose:
      return
    self.isCalledClose = True
    # restore SIMD registers
    saveSimdN = self.saveSimdN
    maxFreeN = self.maxFreeN
    vType = self.vType
    for i in range(saveSimdN):
      if vType == T_SSE:
        movups(Xmm(maxFreeN+i), ptr(rsp + self.saveTop + i * XMM_BYTE_SIZE))
      else:
        vmovups(Xmm(maxFreeN+i), ptr(rsp + self.saveTop + i * XMM_BYTE_SIZE))
    if vType > 0:
      vzeroupper()

    if self.P > 0:
      add(rsp, self.P)
    noSaveNum = getNoSaveNum()
    tbl = getRegTbl()[noSaveNum:]
    for i in range(self.saveNum-1,-1,-1):
      pop(tbl[i])
    if callRet:
      ret()
  def __enter__(self):
    return self
  def __exit__(self, ex_type, ex_value, trace):
    self.close(self.callRet)

  def getRegIdx(self):
    r = getReg(self.pos)
    self.pos += 1
    if self.useRCX:
      if r == rcx:
        return r10
      if r == r10:
        r = getReg(self.pos)
        self.pos += 1
    if self.useRDX:
      if r == rdx:
        return r11
      if r == r11:
        r = getReg(self.pos)
        self.pos += 1
        return r
    return r

# return n-times pop
def pops(x, n):
  r = []
  for i in range(n):
    r.append(x.pop())
  return r

# expand args
# Unroll(2, op, [xm0, xm1], [xm2, xm3], xm4)
# -> op(xm0, xm2, xm4)
#    op(xm1, xm3, xm4)
def Unroll(op, *args, addrOffset, simdByte):
  xs = list(args)
  n = 100
  for e in xs:
    if isinstance(e, list):
      n = min(n, len(e))

  for i in range(n):
    ys = []
    for e in xs:
      if isinstance(e, list):
        ys.append(e[i])
      elif isinstance(e, Address):
        if addrOffset == None:
          if e.broadcast:
            addrOffset = 0
          else:
            addrOffset = simdByte
        ys.append(e + addrOffset*i)
      else:
        ys.append(e)
    op(*ys)

SIMD_BYTE = 64
def genUnrollFunc(addrOffset=None):
  """
    return a function takes op and outputs a function that takes *args and outputs n unrolled op
  """
  def fn(op):
    def gn(*args):
      Unroll(op, *args, addrOffset=addrOffset, simdByte=SIMD_BYTE)
    return gn
  return fn

def init(param):
  """
    initialize s_xbyak
    param.win : use Win64 ABI
    param.mode : asm mode (nasm|masm|gas)
  """
  mode = param.mode
  if mode == 'masm':
    param.win = True
  setWin64ABI(param.win)
  global g_nasm, g_gas, g_masm, g_text
  g_nasm = mode == 'nasm'
  g_gas = mode == 'gas'
  g_masm = mode == 'masm'
  g_text = []
  if g_gas:
    output('''# for gas
#ifdef __linux__
  #define PRE(x) x
  #define TYPE(x) .type x, @function
  #define SIZE(x) .size x, .-x
.section .note.GNU-stack,"",%progbits
#else
  #ifdef _WIN32
    #define PRE(x) x
  #else
    #define PRE(x) _ ## x
  #endif
  #define TYPE(x)
  #define SIZE(x)
#endif''')
  elif g_masm:
    output('; for masm (ml64.exe)')
  else:
    output('''; for nasm
%ifidn __OUTPUT_FORMAT__,macho64
%imacro _global 1
  global _%1
  %1:
  _%1:
%endmacro
%else
%imacro _global 1
  global %1
  %1:
%endmacro
%endif
%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif
''')

def addPRE(s):
  if g_gas and isinstance(s, str):
    return f'PRE({s})'
  else:
    return s

def output(s):
  g_text.append(s)

g_segment_data = False

MASM_SEG_SUF='$x'
def segment(mode):
  if g_masm:
    global g_segment_data
    if mode == 'data':
      g_segment_data = True
    if mode == 'text':
      if g_segment_data:
        output(f'_data{MASM_SEG_SUF} ends')
        g_segment_data = False
  if g_gas:
    output(f'.{mode}')
  elif g_masm:
    if MASM_SEG_SUF:
      # use MASM_SEG_SUF for align(64). it will be merged ot {mode}.
      attr = ' execute' if mode == 'text' else ''
      output(f'_{mode}{MASM_SEG_SUF} segment align(64){attr}')
    else:
      output(f'_{mode} segment')
  else:
    output(f'segment .{mode}')

def iterableToStr(a):
  if isinstance(a, str):
    return a
  if hasattr(a, '__iter__'):
    return ','.join(map(str, a))
  return a

def db_(s):
  s = iterableToStr(s)
  if g_gas:
    output(f'.byte {s}')
  else:
    output(f'db {s}')
def dd_(s):
  s = iterableToStr(s)
  if g_gas:
    output(f'.long {s}')
  else:
    output(f'dd {s}')
def dq_(s):
  s = iterableToStr(s)
  if g_gas:
    output(f'.quad {s}')
  else:
    output(f'dq {s}')
def global_(s):
  if g_gas:
    output(f'.global PRE({s})')
    output(f'PRE({s}):')
  elif g_masm:
    output(f'public {s}')
    output(f'{s}:')
  elif g_nasm:
    output(f'_global {s}')
    if not win64ABI:
      output(f'{s}:')
def extern_(s, size):
  if g_gas:
    output(f'.extern PRE({s})')
  elif g_masm:
    output(f'extern {s}:{size}')
  else:
    output(f'extern {s}')
def makeLabel(s):
  output(addPRE(s) + ':')
def align(n):
  if g_gas:
    output(f'.balign {n}')
  else:
    output(f'align {n}')

def getDefLabel(n):
  if g_gas:
    return f'.L{n}'
  else:
    return f'@L{n}'

def getUndefLabel(n):
  return f'@L{n}_undef'

class Label:
  def __init__(self):
    self.n = 0
  def __str__(self):
    if self.n > 0:
      return getDefLabel(self.n)
    global g_undefLabel
    global g_undefLabelN
    if -self.n in g_undefLabel:
      g_undefLabel[-self.n].append(getLine())
    else:
      self.n = -g_undefLabelN
      g_undefLabelN += 1
      g_undefLabel.setdefault(-self.n, []).append(getLine())
    return getUndefLabel(-self.n)

def L(label):
  if type(label) != Label:
    raise Exception(f'bad type {label}')
  if label.n > 0:
    raise Exception(f'already defined {label}')
  lines = []
  if label.n < 0:
    global g_undefLabelN
    n = -label.n
    if n in g_undefLabel:
      lines = g_undefLabel[n]
      oldStr = getUndefLabel(n)
      del g_undefLabel[n]
  global g_defLabelN
  label.n = g_defLabelN
  g_defLabelN += 1
  if lines:
    newStr = getDefLabel(label.n)
    global g_text
    for line in lines:
      g_text[line] = g_text[line].replace(oldStr, newStr)
  output(f'{getDefLabel(label.n)}:')

def term():
  if g_masm:
    output(f'_text{MASM_SEG_SUF} ends')
    output('end')

  n = len(g_text)
  i = 0
  while i < n:
    s = g_text[i]
    # QQQ (bad knowhow) remove unnecessary pattern
    if g_gas and s == 'mov %rdx, %r11' and g_text[i+1] == 'mov %r11, %rdx':
      i += 2
      continue
    if not g_gas and s == 'mov r11, rdx' and g_text[i+1] == 'mov rdx, r11':
      i += 2
      continue
    if g_masm:
      ## convert 0x123a => 123ah, 0xab => 0abh
      def f(m):
        s = m.group(1)
        if not s[0].isdigit():
          s = '0' + s
        return s + 'h'
      s = re.sub(RE_HEX_STR, f, s)
    print(s)
    i += 1

def defineName(name):
  global_(name)
  makeLabel(name)

# reverse [a, b, c] to [c, b, a] like as Xbyak::util::Pack
def Pack(*args):
  a = list(args)
  a.reverse()
  return a

class FuncProc:
  def __init__(self, name):
    self.name = name
    if g_masm:
      output(f'{self.name} proc export')
      return
    if g_nasm:
      if win64ABI:
        output(f'export {name}')
      global_(name)
      return
    if g_gas:
      global_(name)
      output(f'TYPE({self.name})')
      return
  def close(self):
    if g_masm:
      output(f'{self.name} endp')
    if g_gas:
      output(f'SIZE({self.name})')
  def __enter__(self):
    return self
  def __exit__(self, ex_type, ex_value, trace):
    self.close()

def float2uint(v):
  return int(struct.pack('>f', v).hex(),16)

def double2uint(v):
  return int(struct.pack('>d', v).hex(),16)

def uint2float(v):
  return struct.unpack('>f', v.to_bytes(4,byteorder='big'))[0]

def uint2double(v):
  return struct.unpack('>d', v.to_bytes(8,byteorder='big'))[0]

def makeVar(name, bit, v, const=False, static=False, base=10):
  if not static:
    global_(name)
  makeLabel(name)
  L = 64
  mask = (1<<L)-1
  n = (bit + L-1) // L
  if n == 0:
    n = 1
  if g_gas:
    s = '.quad '
  else:
    s = 'dq '
  for i in range(n):
    if i > 0:
      s += ', '
    if base == 10:
      s += str(v & mask)
    elif base == 16:
      s += hex(v & mask)
    else:
      raise Exception('bad base', base)
    v >>= L
  output(s)

def getNameSuffix(bit):
  tbl = {
    8 : 'b',
    16 : 'w',
    32 : 'l',
    64 : 'q',
    128 : 'x',
    256 : 'y',
    512 : 'z',
  }
  return tbl.get(bit, '')

def getMemSizeIfMatch(argsType, t):
  if len(argsType) != len(t):
    return 0
  memPos = -1
  for i in range(len(argsType)):
    if argsType[i][0] == 'm' and t[i][0] == 'm':
      memPos = i
    elif argsType[i] == t[i]:
      continue
    else:
      return 0
  if memPos == -1:
    return 0
  return int(t[memPos][1:])

def detectMemSize(name, args):
  if len(args) < 2:
    return 0
  argsType = []
  for arg in args:
    if isinstance(arg, int):
      argsType.append('imm')
    elif isinstance(arg, str) or isinstance(arg, Label):
      argsType.append('m')
    else:
      argsType.append(arg.getTypeStr())

#  print('argsType', argsType)

  if argsType[0][0] == 'm':
    tbl = MemRegTbl
  else:
    tbl = RegMemTbl
  v = tbl.get(name, None)
  if v == None:
    return 0

  # search minimum matched size
  NOT_FOUND = 1000
  minS = NOT_FOUND
  for t in v:
    s = getMemSizeIfMatch(argsType, t)
    if s > 0:
      minS = min(minS, s)
  if minS == NOT_FOUND:
    return 0
  return minS

# detect encoding by the last args
def checkEncoding(*args):
  encoding = DefaultEncoding
  if len(args) == 0:
    return (args, encoding)
  last = args[-1]
  if last == VexEncoding or last == EvexEncoding:
    encoding = last
    return (args[:-1], encoding)
  return (args, encoding)

def genFunc(name):
  def f(*args):
    (args, encoding) = checkEncoding(*args)
    # special case (mov reg, label)
    if name == 'mov' and isinstance(args[0], Reg):
      reg = args[0]
      addr = args[1]
      if g_gas and (isinstance(addr, str) or isinstance(addr, Label)):
        output(f'movabs {addPRE(addr)}, {reg}')
        return
      if g_masm and isinstance(addr, Address) and (isinstance(addr.exp, str) or isinstance(addr.exp, Label) or isinstance(addr.exp, RipReg)):
        s = masmSizePrefixTbl[args[0].bit]
        output(f'mov {args[0]}, {s} ptr {addr}')
        return
    if name in ['jmp', 'call']:
      if g_gas and (isinstance(args[0], Reg) or isinstance(args[0], Address)):
        output(f'{name} *{args[0]}')
        return
      if g_masm and isinstance(args[0], Address):
        output(f'{name} qword ptr {args[0]}')
        return

    if not args:
      return output(name)

    # set memory size for masm
    bitSize = detectMemSize(name, args)

    # check attributes
    sae = 0
    for arg in args:
      if isinstance(arg, Operand):
        if arg.attr > 1:
          sae = arg.attr

    # mnemonic requiring size for Address
    # bitForAddress is used to detect a suffix of a mnemonic in specialNameTbl for gas and masm
    bitForAddress = 0
    specialNameTbl = ['vcvtpd2dq', 'vcvtpd2ps', 'vcvttpd2dq', 'vcvtqq2ps', 'vcvtuqq2ps', 'vcvtpd2udq', 'vcvttpd2udq', 'vfpclasspd', 'vfpclassps']

    param = []
    # set bit size to Address
    for arg_ in args:
      if isinstance(arg_, Address):
        arg = arg_.copy()
        if arg.broadcast:
          if g_masm and arg.bit > 64:
            arg.bitForAddress = arg.bit
          arg.setBroadcastRage(name, bitSize)
        elif name in specialNameTbl:
          if arg.bit == 0:
            arg.bit = 128 # default size
          bitForAddress = arg.bit
        elif arg.bit > 0:
          bitForAddress = arg.bit
        if g_masm and arg.bit == 0 and bitSize > 0:
          arg.bit = bitSize
      else:
        arg = arg_
      param.append(arg)

    # insert sae at the end of arguments.
    # if the last argument is immediate, insert sae at the front of it.
    # masm requires sae at the end of arguments without a comma.
    if not g_masm and sae > 0:
      if isinstance(args[-1], Operand) and args[-1].kind != T_ATTR:
        param.append(Attribute(sae))
      elif isinstance(args[-1], int):
        param.insert(-1, Attribute(sae))

    s = ''
    if g_gas:
      param.reverse()
    for arg in param:
      if s != '':
        s += ', '
      if g_gas and isinstance(arg, int):
        s += '$' + str(arg)
      else:
        s += str(arg)
    if g_masm and sae > 0:
      s += str(Attribute(sae))

    suffix = ''
    if g_gas and bitForAddress > 0:
      suffix = getNameSuffix(bitForAddress)
    return output(str(encoding) + name + suffix + ' ' + s)
  return f

def genAllFunc():
  tbl = [
    'push', 'mov', 'pop', 'jmp', 'call', 'test',
    'aaa','aad','aadd','aam','aand','aas','adc','adcx',
    'add','addpd','addps','addsd','addss','addsubpd','addsubps','adox',
    'aesdec','aesdeclast','aesenc','aesenclast','aesimc','aeskeygenassist','and_','andn',
    'andnpd','andnps','andpd','andps','aor','axor','bextr','blendpd',
    'blendps','blendvpd','blendvps','blsi','blsmsk','blsr','bnd','bndcl',
    'bndcn','bndcu','bndldx','bndmk','bndmov','bndstx','bsf','bsr',
    'bswap','bt','btc','btr','bts','bzhi','cbw','cdq',
    'cdqe','char','clc','cld','cldemote','clflush','clflushopt','cli',
    'clui','clwb','clzero','cmc','cmova','cmovae','cmovb','cmovbe',
    'cmovc','cmove','cmovg','cmovge','cmovl','cmovle','cmovna','cmovnae',
    'cmovnb','cmovnbe','cmovnc','cmovne','cmovng','cmovnge','cmovnl','cmovnle',
    'cmovno','cmovnp','cmovns','cmovnz','cmovo','cmovp','cmovpe','cmovpo',
    'cmovs','cmovz','cmp','cmpbexadd','cmpbxadd','cmpeqpd','cmpeqps','cmpeqsd',
    'cmpeqss','cmplepd','cmpleps','cmplesd','cmpless','cmplexadd','cmpltpd','cmpltps',
    'cmpltsd','cmpltss','cmplxadd','cmpnbexadd','cmpnbxadd','cmpneqpd','cmpneqps','cmpneqsd',
    'cmpneqss','cmpnlepd','cmpnleps','cmpnlesd','cmpnless','cmpnlexadd','cmpnltpd','cmpnltps',
    'cmpnltsd','cmpnltss','cmpnlxadd','cmpnoxadd','cmpnpxadd','cmpnsxadd','cmpnzxadd','cmpordpd',
    'cmpordps','cmpordsd','cmpordss','cmpoxadd','cmppd','cmpps','cmppxadd','cmpsb',
    'cmpsd','cmpsq','cmpss','cmpsw','cmpsxadd','cmpunordpd','cmpunordps','cmpunordsd',
    'cmpunordss','cmpxchg','cmpxchg16b','cmpxchg8b','cmpzxadd','comisd','comiss','cpuid',
    'cqo','crc32','cvtdq2pd','cvtdq2ps','cvtpd2dq','cvtpd2pi','cvtpd2ps','cvtpi2pd',
    'cvtpi2ps','cvtps2dq','cvtps2pd','cvtps2pi','cvtsd2si','cvtsd2ss','cvtsi2sd','cvtsi2ss',
    'cvtss2sd','cvtss2si','cvttpd2dq','cvttpd2pi','cvttps2dq','cvttps2pi','cvttsd2si','cvttss2si',
    'cwd','cwde','daa','das','dec','div','divpd','divps',
    'divsd','divss','dppd','dpps','emms','endbr32','endbr64','enter',
    'extractps','f2xm1','fabs','fadd','faddp','fbld','fbstp','fchs',
    'fclex','fcmovb','fcmovbe','fcmove','fcmovnb','fcmovnbe','fcmovne','fcmovnu',
    'fcmovu','fcom','fcomi','fcomip','fcomp','fcompp','fcos','fdecstp',
    'fdiv','fdivp','fdivr','fdivrp','ffree','fiadd','ficom','ficomp',
    'fidiv','fidivr','fild','fimul','fincstp','finit','fist','fistp',
    'fisttp','fisub','fisubr','fld','fld1','fldcw','fldenv','fldl2e',
    'fldl2t','fldlg2','fldln2','fldpi','fldz','fmul','fmulp','fnclex',
    'fninit','fnop','fnsave','fnstcw','fnstenv','fnstsw','fpatan','fprem',
    'fprem1','fptan','frndint','frstor','fsave','fscale','fsin','fsincos',
    'fsqrt','fst','fstcw','fstenv','fstp','fstsw','fsub','fsubp',
    'fsubr','fsubrp','ftst','fucom','fucomi','fucomip','fucomp','fucompp',
    'fwait','fxam','fxch','fxrstor','fxrstor64','fxtract','fyl2x','fyl2xp1',
    'gf2p8affineinvqb','gf2p8affineqb','gf2p8mulb','haddpd','haddps','hlt','hsubpd','hsubps',
    'idiv','imul','in_','inc','insertps','int3','int_','into',
    'ja','jae','jb','jbe','jc','jcxz','je','jecxz',
    'jg','jge','jl','jle','jna','jnae','jnb','jnbe',
    'jnc','jne','jng','jnge','jnl','jnle','jno','jnp',
    'jns','jnz','jo','jp','jpe','jpo','jrcxz','js',
    'jz','kaddb','kaddd','kaddq','kaddw','kandb','kandd','kandnb',
    'kandnd','kandnq','kandnw','kandq','kandw','kmovb','kmovd','kmovq',
    'kmovw','knotb','knotd','knotq','knotw','korb','kord','korq',
    'kortestb','kortestd','kortestq','kortestw','korw','kshiftlb','kshiftld','kshiftlq',
    'kshiftlw','kshiftrb','kshiftrd','kshiftrq','kshiftrw','ktestb','ktestd','ktestq',
    'ktestw','kunpckbw','kunpckdq','kunpckwd','kxnorb','kxnord','kxnorq','kxnorw',
    'kxorb','kxord','kxorq','kxorw','lahf','lddqu','ldmxcsr','lds',
    'ldtilecfg','lea','leave','les','lfence','lfs','lgs','lock',
    'lodsb','lodsd','lodsq','lodsw','loop','loope','loopne','lss',
    'lzcnt','maskmovdqu','maskmovq','maxpd','maxps','maxsd','maxss','mfence',
    'minpd','minps','minsd','minss','monitor','monitorx','movapd','movaps',
    'movbe','movd','movddup','movdir64b','movdiri','movdq2q','movdqa','movdqu',
    'movhlps','movhpd','movhps','movlhps','movlpd','movlps','movmskpd','movmskps',
    'movntdq','movntdqa','movnti','movntpd','movntps','movntq','movq','movq2dq',
    'movsb','movsd','movshdup','movsldup','movsq','movss','movsw','movsx',
    'movsxd','movupd','movups','movzx','mpsadbw','mul','mulpd','mulps',
    'mulsd','mulss','mulx','mwait','mwaitx','neg','not_','or_',
    'nop', 'rep',
    'orpd','orps','out_','outsb','outsd','outsw','pabsb','pabsd',
    'pabsw','packssdw','packsswb','packusdw','packuswb','paddb','paddd','paddq',
    'paddsb','paddsw','paddusb','paddusw','paddw','palignr','pand','pandn',
    'pause','pavgb','pavgw','pblendvb','pblendw','pclmulhqhdq','pclmulhqlqdq','pclmullqhdq',
    'pclmullqlqdq','pclmulqdq','pcmpeqb','pcmpeqd','pcmpeqq','pcmpeqw','pcmpestri','pcmpestrm',
    'pcmpgtb','pcmpgtd','pcmpgtq','pcmpgtw','pcmpistri','pcmpistrm','pdep','pext',
    'pextrb','pextrd','pextrq','pextrw','phaddd','phaddsw','phaddw','phminposuw',
    'phsubd','phsubsw','phsubw','pinsrb','pinsrd','pinsrq','pinsrw','pmaddubsw',
    'pmaddwd','pmaxsb','pmaxsd','pmaxsw','pmaxub','pmaxud','pmaxuw','pminsb',
    'pminsd','pminsw','pminub','pminud','pminuw','pmovmskb','pmovsxbd','pmovsxbq',
    'pmovsxbw','pmovsxdq','pmovsxwd','pmovsxwq','pmovzxbd','pmovzxbq','pmovzxbw','pmovzxdq',
    'pmovzxwd','pmovzxwq','pmuldq','pmulhrsw','pmulhuw','pmulhw','pmulld','pmullw',
    'pmuludq','popa','popad','popcnt','popf','popfd','popfq','por',
    'prefetchit0','prefetchit1','prefetchnta','prefetcht0','prefetcht1','prefetcht2','prefetchw','prefetchwt1',
    'psadbw','pshufb','pshufd','pshufhw','pshuflw','pshufw','psignb','psignd',
    'psignw','pslld','pslldq','psllq','psllw','psrad','psraw','psrld',
    'psrldq','psrlq','psrlw','psubb','psubd','psubq','psubsb','psubsw',
    'psubusb','psubusw','psubw','ptest','punpckhbw','punpckhdq','punpckhqdq','punpckhwd',
    'punpcklbw','punpckldq','punpcklqdq','punpcklwd','pusha','pushad','pushf','pushfd',
    'pushfq','pxor','rcl','rcpps','rcpss','rcr','rdmsr','rdpmc',
    'rdrand','rdseed','rdtsc','rdtscp','rep','repe','repne','repnz',
    'repz','ret','retf','rol','ror','rorx','roundpd','roundps',
    'roundsd','roundss','rsqrtps','rsqrtss','sahf','sal','sar','sarx',
    'sbb','scasb','scasd','scasq','scasw','senduipi','serialize','seta',
    'setae','setb','setbe','setc','sete','setg','setge','setl',
    'setle','setna','setnae','setnb','setnbe','setnc','setne','setng',
    'setnge','setnl','setnle','setno','setnp','setns','setnz','seto',
    'setp','setpe','setpo','sets','setz','sfence','sha1msg1','sha1msg2',
    'sha1nexte','sha1rnds4','sha256msg1','sha256msg2','sha256rnds2','shl','shld','shlx',
    'shr','shrd','shrx','shufpd','shufps','sqrtpd','sqrtps','sqrtsd',
    'sqrtss','stac','stc','std','sti','stmxcsr','stosb','stosd',
    'stosq','stosw','sttilecfg','stui','sub','subpd','subps','subsd',
    'subss','syscall','sysenter','sysexit','sysret','tdpbf16ps','tdpbssd','tdpbsud',
    'tdpbusd','tdpbuud','tdpfp16ps','testui','tileloadd','tileloaddt1','tilerelease','tilestored',
    'tilezero','tpause','tzcnt','ucomisd','ucomiss','ud2','uiret','umonitor',
    'umwait','unpckhpd','unpckhps','unpcklpd','unpcklps','v4fmaddps','v4fmaddss','v4fnmaddps',
    'v4fnmaddss','vaddpd','vaddph','vaddps','vaddsd','vaddsh','vaddss','vaddsubpd',
    'vaddsubps','vaesdec','vaesdeclast','vaesenc','vaesenclast','vaesimc','vaeskeygenassist','valignd',
    'valignq','vandnpd','vandnps','vandpd','vandps','vbcstnebf162ps','vbcstnesh2ps','vblendmpd',
    'vblendmps','vblendpd','vblendps','vblendvpd','vblendvps','vbroadcastf128','vbroadcastf32x2','vbroadcastf32x4',
    'vbroadcastf32x8','vbroadcastf64x2','vbroadcastf64x4','vbroadcasti128','vbroadcasti32x2','vbroadcasti32x4','vbroadcasti32x8','vbroadcasti64x2',
    'vbroadcasti64x4','vbroadcastsd','vbroadcastss','vcmpeq_ospd','vcmpeq_osps','vcmpeq_ossd','vcmpeq_osss','vcmpeq_uqpd',
    'vcmpeq_uqps','vcmpeq_uqsd','vcmpeq_uqss','vcmpeq_uspd','vcmpeq_usps','vcmpeq_ussd','vcmpeq_usss','vcmpeqpd',
    'vcmpeqps','vcmpeqsd','vcmpeqss','vcmpfalse_ospd','vcmpfalse_osps','vcmpfalse_ossd','vcmpfalse_osss','vcmpfalsepd',
    'vcmpfalseps','vcmpfalsesd','vcmpfalsess','vcmpge_oqpd','vcmpge_oqps','vcmpge_oqsd','vcmpge_oqss','vcmpgepd',
    'vcmpgeps','vcmpgesd','vcmpgess','vcmpgt_oqpd','vcmpgt_oqps','vcmpgt_oqsd','vcmpgt_oqss','vcmpgtpd',
    'vcmpgtps','vcmpgtsd','vcmpgtss','vcmple_oqpd','vcmple_oqps','vcmple_oqsd','vcmple_oqss','vcmplepd',
    'vcmpleps','vcmplesd','vcmpless','vcmplt_oqpd','vcmplt_oqps','vcmplt_oqsd','vcmplt_oqss','vcmpltpd',
    'vcmpltps','vcmpltsd','vcmpltss','vcmpneq_oqpd','vcmpneq_oqps','vcmpneq_oqsd','vcmpneq_oqss','vcmpneq_ospd',
    'vcmpneq_osps','vcmpneq_ossd','vcmpneq_osss','vcmpneq_uspd','vcmpneq_usps','vcmpneq_ussd','vcmpneq_usss','vcmpneqpd',
    'vcmpneqps','vcmpneqsd','vcmpneqss','vcmpnge_uqpd','vcmpnge_uqps','vcmpnge_uqsd','vcmpnge_uqss','vcmpngepd',
    'vcmpngeps','vcmpngesd','vcmpngess','vcmpngt_uqpd','vcmpngt_uqps','vcmpngt_uqsd','vcmpngt_uqss','vcmpngtpd',
    'vcmpngtps','vcmpngtsd','vcmpngtss','vcmpnle_uqpd','vcmpnle_uqps','vcmpnle_uqsd','vcmpnle_uqss','vcmpnlepd',
    'vcmpnleps','vcmpnlesd','vcmpnless','vcmpnlt_uqpd','vcmpnlt_uqps','vcmpnlt_uqsd','vcmpnlt_uqss','vcmpnltpd',
    'vcmpnltps','vcmpnltsd','vcmpnltss','vcmpord_spd','vcmpord_sps','vcmpord_ssd','vcmpord_sss','vcmpordpd',
    'vcmpordps','vcmpordsd','vcmpordss','vcmppd','vcmpph','vcmpps','vcmpsd','vcmpsh',
    'vcmpss','vcmptrue_uspd','vcmptrue_usps','vcmptrue_ussd','vcmptrue_usss','vcmptruepd','vcmptrueps','vcmptruesd',
    'vcmptruess','vcmpunord_spd','vcmpunord_sps','vcmpunord_ssd','vcmpunord_sss','vcmpunordpd','vcmpunordps','vcmpunordsd',
    'vcmpunordss','vcomisd','vcomish','vcomiss','vcompressb','vcompresspd','vcompressps','vcompressw',
    'vcvtdq2pd','vcvtdq2ph','vcvtdq2ps','vcvtne2ps2bf16','vcvtneebf162ps','vcvtneeph2ps','vcvtneobf162ps','vcvtneoph2ps',
    'vcvtneps2bf16','vcvtpd2dq','vcvtpd2ph','vcvtpd2ps','vcvtpd2qq','vcvtpd2udq','vcvtpd2uqq','vcvtph2dq',
    'vcvtph2pd','vcvtph2ps','vcvtph2psx','vcvtph2qq','vcvtph2udq','vcvtph2uqq','vcvtph2uw','vcvtph2w',
    'vcvtps2dq','vcvtps2pd','vcvtps2ph','vcvtps2phx','vcvtps2qq','vcvtps2udq','vcvtps2uqq','vcvtqq2pd',
    'vcvtqq2ph','vcvtqq2ps','vcvtsd2sh','vcvtsd2si','vcvtsd2ss','vcvtsd2usi','vcvtsh2sd','vcvtsh2si',
    'vcvtsh2ss','vcvtsh2usi','vcvtsi2sd','vcvtsi2sh','vcvtsi2ss','vcvtss2sd','vcvtss2sh','vcvtss2si',
    'vcvtss2usi','vcvttpd2dq','vcvttpd2qq','vcvttpd2udq','vcvttpd2uqq','vcvttph2dq','vcvttph2qq','vcvttph2udq',
    'vcvttph2uqq','vcvttph2uw','vcvttph2w','vcvttps2dq','vcvttps2qq','vcvttps2udq','vcvttps2uqq','vcvttsd2si',
    'vcvttsd2usi','vcvttsh2si','vcvttsh2usi','vcvttss2si','vcvttss2usi','vcvtudq2pd','vcvtudq2ph','vcvtudq2ps',
    'vcvtuqq2pd','vcvtuqq2ph','vcvtuqq2ps','vcvtusi2sd','vcvtusi2sh','vcvtusi2ss','vcvtuw2ph','vcvtw2ph',
    'vdbpsadbw','vdivpd','vdivph','vdivps','vdivsd','vdivsh','vdivss','vdpbf16ps',
    'vdppd','vdpps','vexp2pd','vexp2ps','vexpandpd','vexpandps','vextractf128','vextractf32x4',
    'vextractf32x8','vextractf64x2','vextractf64x4','vextracti128','vextracti32x4','vextracti32x8','vextracti64x2','vextracti64x4',
    'vextractps','vfcmaddcph','vfcmulcph','vfixupimmpd','vfixupimmps','vfixupimmsd','vfixupimmss','vfmadd132pd',
    'vfmadd132ph','vfmadd132ps','vfmadd132sd','vfmadd132sh','vfmadd132ss','vfmadd213pd','vfmadd213ph','vfmadd213ps',
    'vfmadd213sd','vfmadd213sh','vfmadd213ss','vfmadd231pd','vfmadd231ph','vfmadd231ps','vfmadd231sd','vfmadd231sh',
    'vfmadd231ss','vfmaddcph','vfmaddsub132pd','vfmaddsub132ph','vfmaddsub132ps','vfmaddsub213pd','vfmaddsub213ph','vfmaddsub213ps',
    'vfmaddsub231pd','vfmaddsub231ph','vfmaddsub231ps','vfmsub132pd','vfmsub132ph','vfmsub132ps','vfmsub132sd','vfmsub132sh',
    'vfmsub132ss','vfmsub213pd','vfmsub213ph','vfmsub213ps','vfmsub213sd','vfmsub213sh','vfmsub213ss','vfmsub231pd',
    'vfmsub231ph','vfmsub231ps','vfmsub231sd','vfmsub231sh','vfmsub231ss','vfmsubadd132pd','vfmsubadd132ph','vfmsubadd132ps',
    'vfmsubadd213pd','vfmsubadd213ph','vfmsubadd213ps','vfmsubadd231pd','vfmsubadd231ph','vfmsubadd231ps','vfmulcph','vfnmadd132pd',
    'vfnmadd132ph','vfnmadd132ps','vfnmadd132sd','vfnmadd132sh','vfnmadd132ss','vfnmadd213pd','vfnmadd213ph','vfnmadd213ps',
    'vfnmadd213sd','vfnmadd213sh','vfnmadd213ss','vfnmadd231pd','vfnmadd231ph','vfnmadd231ps','vfnmadd231sd','vfnmadd231sh',
    'vfnmadd231ss','vfnmsub132pd','vfnmsub132ph','vfnmsub132ps','vfnmsub132sd','vfnmsub132sh','vfnmsub132ss','vfnmsub213pd',
    'vfnmsub213ph','vfnmsub213ps','vfnmsub213sd','vfnmsub213sh','vfnmsub213ss','vfnmsub231pd','vfnmsub231ph','vfnmsub231ps',
    'vfnmsub231sd','vfnmsub231sh','vfnmsub231ss','vfpclasspd','vfpclassph','vfpclassps','vfpclasssd','vfpclasssh',
    'vfpclassss','vgatherdpd','vgatherdps','vgatherpf0dpd','vgatherpf0dps','vgatherpf0qpd','vgatherpf0qps','vgatherpf1dpd',
    'vgatherpf1dps','vgatherpf1qpd','vgatherpf1qps','vgatherqpd','vgatherqps','vgetexppd','vgetexpph','vgetexpps',
    'vgetexpsd','vgetexpsh','vgetexpss','vgetmantpd','vgetmantph','vgetmantps','vgetmantsd','vgetmantsh',
    'vgetmantss','vgf2p8affineinvqb','vgf2p8affineqb','vgf2p8mulb','vhaddpd','vhaddps','vhsubpd','vhsubps',
    'vinsertf128','vinsertf32x4','vinsertf32x8','vinsertf64x2','vinsertf64x4','vinserti128','vinserti32x4','vinserti32x8',
    'vinserti64x2','vinserti64x4','vinsertps','vlddqu','vldmxcsr','vmaskmovdqu','vmaskmovpd','vmaskmovps',
    'vmaxpd','vmaxph','vmaxps','vmaxsd','vmaxsh','vmaxss','vminpd','vminph',
    'vminps','vminsd','vminsh','vminss','vmovapd','vmovaps','vmovd','vmovddup',
    'vmovdqa','vmovdqa32','vmovdqa64','vmovdqu','vmovdqu16','vmovdqu32','vmovdqu64','vmovdqu8',
    'vmovhlps','vmovhpd','vmovhps','vmovlhps','vmovlpd','vmovlps','vmovmskpd','vmovmskps',
    'vmovntdq','vmovntdqa','vmovntpd','vmovntps','vmovq','vmovsd','vmovsh','vmovshdup',
    'vmovsldup','vmovss','vmovupd','vmovups','vmovw','vmpsadbw','vmulpd','vmulph',
    'vmulps','vmulsd','vmulsh','vmulss','vorpd','vorps','vp2intersectd','vp2intersectq',
    'vp4dpwssd','vp4dpwssds','vpabsb','vpabsd','vpabsq','vpabsw','vpackssdw','vpacksswb',
    'vpackusdw','vpackuswb','vpaddb','vpaddd','vpaddq','vpaddsb','vpaddsw','vpaddusb',
    'vpaddusw','vpaddw','vpalignr','vpand','vpandd','vpandn','vpandnd','vpandnq',
    'vpandq','vpavgb','vpavgw','vpblendd','vpblendmb','vpblendmd','vpblendmq','vpblendmw',
    'vpblendvb','vpblendw','vpbroadcastb','vpbroadcastd','vpbroadcastmb2q','vpbroadcastmw2d','vpbroadcastq','vpbroadcastw',
    'vpclmulqdq','vpcmpb','vpcmpd','vpcmpeqb','vpcmpeqd','vpcmpeqq','vpcmpeqw','vpcmpestri',
    'vpcmpestrm','vpcmpgtb','vpcmpgtd','vpcmpgtq','vpcmpgtw','vpcmpistri','vpcmpistrm','vpcmpq',
    'vpcmpub','vpcmpud','vpcmpuq','vpcmpuw','vpcmpw','vpcompressd','vpcompressq','vpconflictd',
    'vpconflictq','vpdpbssd','vpdpbssds','vpdpbsud','vpdpbsuds','vpdpbusd','vpdpbusds','vpdpbuud',
    'vpdpbuuds','vpdpwssd','vpdpwssds','vperm2f128','vperm2i128','vpermb','vpermd','vpermi2b',
    'vpermi2d','vpermi2pd','vpermi2ps','vpermi2q','vpermi2w','vpermilpd','vpermilps','vpermpd',
    'vpermps','vpermq','vpermt2b','vpermt2d','vpermt2pd','vpermt2ps','vpermt2q','vpermt2w',
    'vpermw','vpexpandb','vpexpandd','vpexpandq','vpexpandw','vpextrb','vpextrd','vpextrq',
    'vpextrw','vpgatherdd','vpgatherdq','vpgatherqd','vpgatherqq','vphaddd','vphaddsw','vphaddw',
    'vphminposuw','vphsubd','vphsubsw','vphsubw','vpinsrb','vpinsrd','vpinsrq','vpinsrw',
    'vplzcntd','vplzcntq','vpmadd52huq','vpmadd52luq','vpmaddubsw','vpmaddwd','vpmaskmovd','vpmaskmovq',
    'vpmaxsb','vpmaxsd','vpmaxsq','vpmaxsw','vpmaxub','vpmaxud','vpmaxuq','vpmaxuw',
    'vpminsb','vpminsd','vpminsq','vpminsw','vpminub','vpminud','vpminuq','vpminuw',
    'vpmovb2m','vpmovd2m','vpmovdb','vpmovdw','vpmovm2b','vpmovm2d','vpmovm2q','vpmovm2w',
    'vpmovmskb','vpmovq2m','vpmovqb','vpmovqd','vpmovqw','vpmovsdb','vpmovsdw','vpmovsqb',
    'vpmovsqd','vpmovsqw','vpmovswb','vpmovsxbd','vpmovsxbq','vpmovsxbw','vpmovsxdq','vpmovsxwd',
    'vpmovsxwq','vpmovusdb','vpmovusdw','vpmovusqb','vpmovusqd','vpmovusqw','vpmovuswb','vpmovw2m',
    'vpmovwb','vpmovzxbd','vpmovzxbq','vpmovzxbw','vpmovzxdq','vpmovzxwd','vpmovzxwq','vpmuldq',
    'vpmulhrsw','vpmulhuw','vpmulhw','vpmulld','vpmullq','vpmullw','vpmultishiftqb','vpmuludq',
    'vpopcntb','vpopcntd','vpopcntq','vpopcntw','vpor','vpord','vporq','vprold',
    'vprolq','vprolvd','vprolvq','vprord','vprorq','vprorvd','vprorvq','vpsadbw',
    'vpscatterdd','vpscatterdq','vpscatterqd','vpscatterqq','vpshldd','vpshldq','vpshldvd','vpshldvq',
    'vpshldvw','vpshldw','vpshrdd','vpshrdq','vpshrdvd','vpshrdvq','vpshrdvw','vpshrdw',
    'vpshufb','vpshufbitqmb','vpshufd','vpshufhw','vpshuflw','vpsignb','vpsignd','vpsignw',
    'vpslld','vpslldq','vpsllq','vpsllvd','vpsllvq','vpsllvw','vpsllw','vpsrad',
    'vpsraq','vpsravd','vpsravq','vpsravw','vpsraw','vpsrld','vpsrldq','vpsrlq',
    'vpsrlvd','vpsrlvq','vpsrlvw','vpsrlw','vpsubb','vpsubd','vpsubq','vpsubsb',
    'vpsubsw','vpsubusb','vpsubusw','vpsubw','vpternlogd','vpternlogq','vptest','vptestmb',
    'vptestmd','vptestmq','vptestmw','vptestnmb','vptestnmd','vptestnmq','vptestnmw','vpunpckhbw',
    'vpunpckhdq','vpunpckhqdq','vpunpckhwd','vpunpcklbw','vpunpckldq','vpunpcklqdq','vpunpcklwd','vpxor',
    'vpxord','vpxorq','vrangepd','vrangeps','vrangesd','vrangess','vrcp14pd','vrcp14ps',
    'vrcp14sd','vrcp14ss','vrcp28pd','vrcp28ps','vrcp28sd','vrcp28ss','vrcpph','vrcpps',
    'vrcpsh','vrcpss','vreducepd','vreduceph','vreduceps','vreducesd','vreducesh','vreducess',
    'vrndscalepd','vrndscaleph','vrndscaleps','vrndscalesd','vrndscalesh','vrndscaless','vroundpd','vroundps',
    'vroundsd','vroundss','vrsqrt14pd','vrsqrt14ps','vrsqrt14sd','vrsqrt14ss','vrsqrt28pd','vrsqrt28ps',
    'vrsqrt28sd','vrsqrt28ss','vrsqrtph','vrsqrtps','vrsqrtsh','vrsqrtss','vscalefpd','vscalefph',
    'vscalefps','vscalefsd','vscalefsh','vscalefss','vscatterdpd','vscatterdps','vscatterpf0dpd','vscatterpf0dps',
    'vscatterpf0qpd','vscatterpf0qps','vscatterpf1dpd','vscatterpf1dps','vscatterpf1qpd','vscatterpf1qps','vscatterqpd','vscatterqps',
    'vshuff32x4','vshuff64x2','vshufi32x4','vshufi64x2','vshufpd','vshufps','vsqrtpd','vsqrtph',
    'vsqrtps','vsqrtsd','vsqrtsh','vsqrtss','vstmxcsr','vsubpd','vsubph','vsubps',
    'vsubsd','vsubsh','vsubss','vtestpd','vtestps','vucomisd','vucomish','vucomiss',
    'vunpckhpd','vunpckhps','vunpcklpd','vunpcklps','vxorpd','vxorps','vzeroall','vzeroupper',
    'wait','wbinvd','wrmsr','xadd','xgetbv','xlatb','xor_','xorpd',
    'xorps',
    'vpclmullqlqdq', 'vpclmulhqlqdq', 'vpclmullqhqdq', 'vpclmulhqhqdq',
  ]
  for name in tbl:
    asmName = name.strip('_')
    globals()[name] = genFunc(asmName)

genAllFunc()

# used in Address.setBroadcastRage()
T_B16 = 16
T_B32 = 32
T_B64 = 64
avx512broadcastTbl = {
  'vaddpd' : T_B64,
  'vaddps' : T_B32,
  'vandnpd' : T_B64,
  'vandnps' : T_B32,
  'vandpd' : T_B64,
  'vandps' : T_B32,
  'vbcstnebf162ps' : T_B16,
  'vbcstnesh2ps' : T_B16,
  'vcvtdq2pd' : T_B32,
  'vcvtdq2ps' : T_B32,
  'vcvtneps2bf16' : T_B32,
  'vcvtpd2dq' : T_B64,
  'vcvtpd2ps' : T_B64,
  'vcvtps2dq' : T_B32,
  'vcvtps2pd' : T_B32,
  'vcvttpd2dq' : T_B64,
  'vcvttps2dq' : T_B32,
  'vdivpd' : T_B64,
  'vdivps' : T_B32,
  'vfmadd132pd' : T_B64,
  'vfmadd132ps' : T_B32,
  'vfmadd213pd' : T_B64,
  'vfmadd213ps' : T_B32,
  'vfmadd231pd' : T_B64,
  'vfmadd231ps' : T_B32,
  'vfmaddsub132pd' : T_B64,
  'vfmaddsub132ps' : T_B32,
  'vfmaddsub213pd' : T_B64,
  'vfmaddsub213ps' : T_B32,
  'vfmaddsub231pd' : T_B64,
  'vfmaddsub231ps' : T_B32,
  'vfmsub132pd' : T_B64,
  'vfmsub132ps' : T_B32,
  'vfmsub213pd' : T_B64,
  'vfmsub213ps' : T_B32,
  'vfmsub231pd' : T_B64,
  'vfmsub231ps' : T_B32,
  'vfmsubadd132pd' : T_B64,
  'vfmsubadd132ps' : T_B32,
  'vfmsubadd213pd' : T_B64,
  'vfmsubadd213ps' : T_B32,
  'vfmsubadd231pd' : T_B64,
  'vfmsubadd231ps' : T_B32,
  'vfnmadd132pd' : T_B64,
  'vfnmadd132ps' : T_B32,
  'vfnmadd213pd' : T_B64,
  'vfnmadd213ps' : T_B32,
  'vfnmadd231pd' : T_B64,
  'vfnmadd231ps' : T_B32,
  'vfnmsub132pd' : T_B64,
  'vfnmsub132ps' : T_B32,
  'vfnmsub213pd' : T_B64,
  'vfnmsub213ps' : T_B32,
  'vfnmsub231pd' : T_B64,
  'vfnmsub231ps' : T_B32,
  'vgf2p8affineinvqb' : T_B64,
  'vgf2p8affineqb' : T_B64,
  'vmaxpd' : T_B64,
  'vmaxps' : T_B32,
  'vminpd' : T_B64,
  'vminps' : T_B32,
  'vmulpd' : T_B64,
  'vmulps' : T_B32,
  'vorpd' : T_B64,
  'vorps' : T_B32,
  'vpabsd' : T_B32,
  'vpackssdw' : T_B32,
  'vpackusdw' : T_B32,
  'vpaddd' : T_B32,
  'vpaddq' : T_B64,
  'vpdpbusd' : T_B32,
  'vpdpbusds' : T_B32,
  'vpdpwssd' : T_B32,
  'vpdpwssds' : T_B32,
  'vpermd' : T_B32,
  'vpermilpd' : T_B64,
  'vpermilpd' : T_B64,
  'vpermilps' : T_B32,
  'vpermilps' : T_B32,
  'vpermpd' : T_B64,
  'vpermpd' : T_B64,
  'vpermps' : T_B32,
  'vpermq' : T_B64,
  'vpermq' : T_B64,
  'vpmadd52huq' : T_B64,
  'vpmadd52luq' : T_B64,
  'vpmaxsd' : T_B32,
  'vpmaxud' : T_B32,
  'vpminsd' : T_B32,
  'vpminud' : T_B32,
  'vpmuldq' : T_B64,
  'vpmulld' : T_B32,
  'vpmuludq' : T_B64,
  'vpshufd' : T_B32,
  'vpslld' : T_B32,
  'vpsllq' : T_B64,
  'vpsllvd' : T_B32,
  'vpsllvq' : T_B64,
  'vpsrad' : T_B32,
  'vpsravd' : T_B32,
  'vpsrld' : T_B32,
  'vpsrlq' : T_B64,
  'vpsrlvd' : T_B32,
  'vpsrlvq' : T_B64,
  'vpsubd' : T_B32,
  'vpsubq' : T_B64,
  'vpunpckhdq' : T_B32,
  'vpunpckhqdq' : T_B64,
  'vpunpckldq' : T_B32,
  'vpunpcklqdq' : T_B64,
  'vshufpd' : T_B64,
  'vshufps' : T_B32,
  'vsqrtpd' : T_B64,
  'vsqrtps' : T_B32,
  'vsubpd' : T_B64,
  'vsubps' : T_B32,
  'vunpckhpd' : T_B64,
  'vunpckhps' : T_B32,
  'vunpcklpd' : T_B64,
  'vunpcklps' : T_B32,
  'vxorpd' : T_B64,
  'vxorps' : T_B32,
  'vaddph' : T_B16,
  'vblendmpd' : T_B64,
  'vblendmps' : T_B32,
  'vcmppd' : T_B64,
  'vcmpph' : T_B16,
  'vcmpps' : T_B32,
  'vcmpeqpd' : T_B64,
  'vcmpltpd' : T_B64,
  'vcmplepd' : T_B64,
  'vcmpunordpd' : T_B64,
  'vcmpneqpd' : T_B64,
  'vcmpnltpd' : T_B64,
  'vcmpnlepd' : T_B64,
  'vcmpordpd' : T_B64,
  'vcmpeq_uqpd' : T_B64,
  'vcmpngepd' : T_B64,
  'vcmpngtpd' : T_B64,
  'vcmpfalsepd' : T_B64,
  'vcmpneq_oqpd' : T_B64,
  'vcmpgepd' : T_B64,
  'vcmpgtpd' : T_B64,
  'vcmptruepd' : T_B64,
  'vcmpeq_ospd' : T_B64,
  'vcmplt_oqpd' : T_B64,
  'vcmple_oqpd' : T_B64,
  'vcmpunord_spd' : T_B64,
  'vcmpneq_uspd' : T_B64,
  'vcmpnlt_uqpd' : T_B64,
  'vcmpnle_uqpd' : T_B64,
  'vcmpord_spd' : T_B64,
  'vcmpeq_uspd' : T_B64,
  'vcmpnge_uqpd' : T_B64,
  'vcmpngt_uqpd' : T_B64,
  'vcmpfalse_ospd' : T_B64,
  'vcmpneq_ospd' : T_B64,
  'vcmpge_oqpd' : T_B64,
  'vcmpgt_oqpd' : T_B64,
  'vcmptrue_uspd' : T_B64,
  'vcmpeqps' : T_B32,
  'vcmpltps' : T_B32,
  'vcmpleps' : T_B32,
  'vcmpunordps' : T_B32,
  'vcmpneqps' : T_B32,
  'vcmpnltps' : T_B32,
  'vcmpnleps' : T_B32,
  'vcmpordps' : T_B32,
  'vcmpeq_uqps' : T_B32,
  'vcmpngeps' : T_B32,
  'vcmpngtps' : T_B32,
  'vcmpfalseps' : T_B32,
  'vcmpneq_oqps' : T_B32,
  'vcmpgeps' : T_B32,
  'vcmpgtps' : T_B32,
  'vcmptrueps' : T_B32,
  'vcmpeq_osps' : T_B32,
  'vcmplt_oqps' : T_B32,
  'vcmple_oqps' : T_B32,
  'vcmpunord_sps' : T_B32,
  'vcmpneq_usps' : T_B32,
  'vcmpnlt_uqps' : T_B32,
  'vcmpnle_uqps' : T_B32,
  'vcmpord_sps' : T_B32,
  'vcmpeq_usps' : T_B32,
  'vcmpnge_uqps' : T_B32,
  'vcmpngt_uqps' : T_B32,
  'vcmpfalse_osps' : T_B32,
  'vcmpneq_osps' : T_B32,
  'vcmpge_oqps' : T_B32,
  'vcmpgt_oqps' : T_B32,
  'vcmptrue_usps' : T_B32,
  'vcvtdq2ph' : T_B32,
  'vcvtne2ps2bf16' : T_B32,
  'vcvtpd2ph' : T_B64,
  'vcvtpd2qq' : T_B64,
  'vcvtpd2udq' : T_B64,
  'vcvtpd2uqq' : T_B64,
  'vcvtph2dq' : T_B16,
  'vcvtph2pd' : T_B16,
  'vcvtph2psx' : T_B16,
  'vcvtph2qq' : T_B16,
  'vcvtph2udq' : T_B16,
  'vcvtph2uqq' : T_B16,
  'vcvtph2uw' : T_B16,
  'vcvtph2w' : T_B16,
  'vcvtps2phx' : T_B32,
  'vcvtps2qq' : T_B32,
  'vcvtps2udq' : T_B32,
  'vcvtps2uqq' : T_B32,
  'vcvtqq2pd' : T_B64,
  'vcvtqq2ph' : T_B64,
  'vcvtqq2ps' : T_B64,
  'vcvttpd2qq' : T_B64,
  'vcvttpd2udq' : T_B64,
  'vcvttpd2uqq' : T_B64,
  'vcvttph2dq' : T_B16,
  'vcvttph2qq' : T_B16,
  'vcvttph2udq' : T_B16,
  'vcvttph2uqq' : T_B16,
  'vcvttph2uw' : T_B16,
  'vcvttph2w' : T_B16,
  'vcvttps2qq' : T_B32,
  'vcvttps2udq' : T_B32,
  'vcvttps2uqq' : T_B32,
  'vcvtudq2pd' : T_B32,
  'vcvtudq2ph' : T_B32,
  'vcvtudq2ps' : T_B32,
  'vcvtuqq2pd' : T_B64,
  'vcvtuqq2ph' : T_B64,
  'vcvtuqq2ps' : T_B64,
  'vcvtuw2ph' : T_B16,
  'vcvtw2ph' : T_B16,
  'vdivph' : T_B16,
  'vdpbf16ps' : T_B32,
  'vexp2pd' : T_B64,
  'vexp2ps' : T_B32,
  'vfcmaddcph' : T_B32,
  'vfcmulcph' : T_B32,
  'vfixupimmpd' : T_B64,
  'vfixupimmps' : T_B32,
  'vfmadd132ph' : T_B16,
  'vfmadd213ph' : T_B16,
  'vfmadd231ph' : T_B16,
  'vfmaddcph' : T_B32,
  'vfmaddsub132ph' : T_B16,
  'vfmaddsub213ph' : T_B16,
  'vfmaddsub231ph' : T_B16,
  'vfmsub132ph' : T_B16,
  'vfmsub213ph' : T_B16,
  'vfmsub231ph' : T_B16,
  'vfmsubadd132ph' : T_B16,
  'vfmsubadd213ph' : T_B16,
  'vfmsubadd231ph' : T_B16,
  'vfmulcph' : T_B32,
  'vfnmadd132ph' : T_B16,
  'vfnmadd213ph' : T_B16,
  'vfnmadd231ph' : T_B16,
  'vfnmsub132ph' : T_B16,
  'vfnmsub213ph' : T_B16,
  'vfnmsub231ph' : T_B16,
  'vfpclasspd' : T_B64,
  'vfpclassph' : T_B16,
  'vfpclassps' : T_B32,
  'vgetexppd' : T_B64,
  'vgetexpph' : T_B16,
  'vgetexpps' : T_B32,
  'vgetmantpd' : T_B64,
  'vgetmantph' : T_B16,
  'vgetmantps' : T_B32,
  'vmaxph' : T_B16,
  'vminph' : T_B16,
  'vmulph' : T_B16,
  'vp2intersectd' : T_B32,
  'vp2intersectq' : T_B64,
  'vpabsq' : T_B64,
  'vpandd' : T_B32,
  'vpandnd' : T_B32,
  'vpandnq' : T_B64,
  'vpandq' : T_B64,
  'vpblendmd' : T_B32,
  'vpblendmq' : T_B64,
  'vpcmpd' : T_B32,
  'vpcmpeqd' : T_B32,
  'vpcmpeqq' : T_B64,
  'vpcmpgtd' : T_B32,
  'vpcmpgtq' : T_B64,
  'vpcmpq' : T_B64,
  'vpcmpud' : T_B32,
  'vpcmpuq' : T_B64,
  'vpconflictd' : T_B32,
  'vpconflictq' : T_B64,
  'vpermi2d' : T_B32,
  'vpermi2pd' : T_B64,
  'vpermi2ps' : T_B32,
  'vpermi2q' : T_B64,
  'vpermt2d' : T_B32,
  'vpermt2pd' : T_B64,
  'vpermt2ps' : T_B32,
  'vpermt2q' : T_B64,
  'vplzcntd' : T_B32,
  'vplzcntq' : T_B64,
  'vpmaxsq' : T_B64,
  'vpmaxuq' : T_B64,
  'vpminsq' : T_B64,
  'vpminuq' : T_B64,
  'vpmullq' : T_B64,
  'vpmultishiftqb' : T_B64,
  'vpopcntd' : T_B32,
  'vpopcntq' : T_B64,
  'vpord' : T_B32,
  'vporq' : T_B64,
  'vprold' : T_B32,
  'vprolq' : T_B64,
  'vprolvd' : T_B32,
  'vprolvq' : T_B64,
  'vprord' : T_B32,
  'vprorq' : T_B64,
  'vprorvd' : T_B32,
  'vprorvq' : T_B64,
  'vpshldd' : T_B32,
  'vpshldq' : T_B64,
  'vpshldvd' : T_B32,
  'vpshldvq' : T_B64,
  'vpshrdd' : T_B32,
  'vpshrdq' : T_B64,
  'vpshrdvd' : T_B32,
  'vpshrdvq' : T_B64,
  'vpsraq' : T_B64,
  'vpsravq' : T_B64,
  'vpternlogd' : T_B32,
  'vpternlogq' : T_B64,
  'vptestmd' : T_B32,
  'vptestmq' : T_B64,
  'vptestnmd' : T_B32,
  'vptestnmq' : T_B64,
  'vpxord' : T_B32,
  'vpxorq' : T_B64,
  'vrangepd' : T_B64,
  'vrangeps' : T_B32,
  'vrcp14pd' : T_B64,
  'vrcp14ps' : T_B32,
  'vrcp28pd' : T_B64,
  'vrcp28ps' : T_B32,
  'vrcpph' : T_B16,
  'vreducepd' : T_B64,
  'vreduceph' : T_B16,
  'vreduceps' : T_B32,
  'vrndscalepd' : T_B64,
  'vrndscaleph' : T_B16,
  'vrndscaleps' : T_B32,
  'vrsqrt14pd' : T_B64,
  'vrsqrt14ps' : T_B32,
  'vrsqrt28pd' : T_B64,
  'vrsqrt28ps' : T_B32,
  'vrsqrtph' : T_B16,
  'vscalefpd' : T_B64,
  'vscalefph' : T_B16,
  'vscalefps' : T_B32,
  'vshuff32x4' : T_B32,
  'vshuff64x2' : T_B64,
  'vshufi32x4' : T_B32,
  'vshufi64x2' : T_B64,
  'vsqrtph' : T_B16,
  'vsubph' : T_B16,
}

#from tbl import RegMemTbl, MemRegTbl
MemRegTbl={'adc': {('m64', 'm32'), ('m64', 'imm'), ('m32', 'imm'), ('m32', 'm32')},
 'add': {('m64', 'm32'), ('m64', 'imm'), ('m32', 'imm'), ('m32', 'm32')},
 'and': {('m64', 'm32'), ('m64', 'imm'), ('m32', 'imm'), ('m32', 'm32')},
 'bt': {('m64', 'imm'), ('m32', 'imm')},
 'btc': {('m64', 'imm'), ('m32', 'imm')},
 'btr': {('m64', 'imm'), ('m32', 'imm')},
 'bts': {('m64', 'imm'), ('m32', 'imm')},
 'call': {('m64',), ('m32',)},
 'clrssbsy': {('m64',)},
 'cmp': {('m64', 'm32'), ('m64', 'imm'), ('m32', 'imm'), ('m32', 'm32')},
 'cmps': {('m64', 'm64'), ('m32', 'm32')},
 'cmpxchg8b': {('m64',)},
 'cmpxchg16b': {('m128',)},
 'dec': {('m64',), ('m32',)},
 'div': {('m64',), ('m32',)},
 'fadd': {('m64',), ('m32',)},
 'fiadd': {('m32',)},
 'fcom': {('m64',), ('m32',)},
 'fcomp': {('m64',), ('m32',)},
 'fdiv': {('m64',), ('m32',)},
 'fidiv': {('m32',)},
 'fdivr': {('m64',), ('m32',)},
 'fidivr': {('m32',)},
 'ficom': {('m32',)},
 'ficomp': {('m32',)},
 'fild': {('m64',), ('m32',)},
 'fist': {('m32',)},
 'fistp': {('m64',), ('m32',)},
 'fisttp': {('m64',), ('m32',)},
 'fld': {('m64',), ('m32',)},
 'fmul': {('m64',), ('m32',)},
 'fimul': {('m32',)},
 'fst': {('m64',), ('m32',)},
 'fstp': {('m64',), ('m32',)},
 'fsub': {('m64',), ('m32',)},
 'fisub': {('m32',)},
 'fsubr': {('m64',), ('m32',)},
 'fisubr': {('m32',)},
 'fxrstor': {('m512',)},
 'fxrstor64': {('m512',)},
 'fxsave': {('m512',)},
 'fxsave64': {('m512',)},
 'idiv': {('m64',), ('m32',)},
 'imul': {('m64',), ('m32',)},
 'inc': {('m64',), ('m32',)},
 'jmp': {('m64',), ('m32',)},
 'kmovq': {('m64', 'k')},
 'kmovd': {('m32', 'k')},
 'ldmxcsr': {('m32',)},
 'vldmxcsr': {('m32',)},
 'lods': {('m64',), ('m32',)},
 'mov': {('m64', 'm32'), ('m32', 'm32')},
 'movapd': {('m128', 'xmm')},
 'vmovapd': {('m128', 'xmm'), ('m256', 'ymm'), ('m512', 'zmm')},
 'movaps': {('m128', 'xmm')},
 'vmovaps': {('m128', 'xmm'), ('m256', 'ymm'), ('m512', 'zmm')},
 'vmovd': {('m32', 'xmm')},
 'vmovq': {('m64', 'xmm')},
 'movd': {('m32', 'xmm')},
 'movq': {('m64', 'xmm')},
 'movdqa': {('m128', 'xmm')},
 'vmovdqa': {('m128', 'xmm'), ('m256', 'ymm')},
 'vmovdqa32': {('m128', 'xmm'), ('m256', 'ymm'), ('m512', 'zmm')},
 'vmovdqa64': {('m128', 'xmm'), ('m256', 'ymm'), ('m512', 'zmm')},
 'movdqu': {('m128', 'xmm')},
 'vmovdqu': {('m128', 'xmm'), ('m256', 'ymm')},
 'vmovdqu8': {('m128', 'xmm'), ('m256', 'ymm'), ('m512', 'zmm')},
 'vmovdqu16': {('m128', 'xmm'), ('m256', 'ymm'), ('m512', 'zmm')},
 'vmovdqu32': {('m128', 'xmm'), ('m256', 'ymm'), ('m512', 'zmm')},
 'vmovdqu64': {('m128', 'xmm'), ('m256', 'ymm'), ('m512', 'zmm')},
 'movhpd': {('m64', 'xmm')},
 'vmovhpd': {('m64', 'xmm')},
 'movhps': {('m64', 'xmm')},
 'vmovhps': {('m64', 'xmm')},
 'movlpd': {('m64', 'xmm')},
 'vmovlpd': {('m64', 'xmm')},
 'movlps': {('m64', 'xmm')},
 'vmovlps': {('m64', 'xmm')},
 'movntdq': {('m128', 'xmm')},
 'vmovntdq': {('m128', 'xmm'), ('m256', 'ymm'), ('m512', 'zmm')},
 'movntpd': {('m128', 'xmm')},
 'vmovntpd': {('m128', 'xmm'), ('m256', 'ymm'), ('m512', 'zmm')},
 'movntps': {('m128', 'xmm')},
 'vmovntps': {('m128', 'xmm'), ('m256', 'ymm'), ('m512', 'zmm')},
 'movs': {('m64', 'm64'), ('m32', 'm32')},
 'movsd': {('m64', 'xmm')},
 'vmovsd': {('m64', 'xmm')},
 'movss': {('m32', 'xmm')},
 'vmovss': {('m32', 'xmm')},
 'movupd': {('m128', 'xmm')},
 'vmovupd': {('m128', 'xmm'), ('m256', 'ymm'), ('m512', 'zmm')},
 'movups': {('m128', 'xmm')},
 'vmovups': {('m128', 'xmm'), ('m256', 'ymm'), ('m512', 'zmm')},
 'mul': {('m64',), ('m32',)},
 'neg': {('m64',), ('m32',)},
 'nop': {('m32',)},
 'not': {('m64',), ('m32',)},
 'or': {('m64', 'm32'), ('m64', 'imm'), ('m32', 'imm'), ('m32', 'm32')},
 'pextrd': {('m32', 'xmm', 'imm')},
 'pextrq': {('m64', 'xmm', 'imm')},
 'vpextrd': {('m32', 'xmm', 'imm')},
 'vpextrq': {('m64', 'xmm', 'imm')},
 'pop': {('m64',), ('m32',)},
 'ptwrite': {('m64',), ('m32',)},
 'push': {('m64',), ('m32',)},
 'rcl': {('m64', 'imm'), ('m32', 'imm')},
 'rcr': {('m64', 'imm'), ('m32', 'imm')},
 'rol': {('m64', 'imm'), ('m32', 'imm')},
 'ror': {('m64', 'imm'), ('m32', 'imm')},
 'rstorssp': {('m64',)},
 'sal': {('m64', 'imm'), ('m32', 'imm')},
 'sar': {('m64', 'imm'), ('m32', 'imm')},
 'shl': {('m64', 'imm'), ('m32', 'imm')},
 'shr': {('m64', 'imm'), ('m32', 'imm')},
 'sbb': {('m64', 'm32'), ('m64', 'imm'), ('m32', 'imm'), ('m32', 'm32')},
 'scas': {('m64',), ('m32',)},
 'stmxcsr': {('m32',)},
 'vstmxcsr': {('m32',)},
 'stos': {('m64',), ('m32',)},
 'sub': {('m64', 'm32'), ('m64', 'imm'), ('m32', 'imm'), ('m32', 'm32')},
 'test': {('m64', 'm32'), ('m32', 'm32')},
 'vcompresspd': {('m128', 'xmm'), ('m256', 'ymm'), ('m512', 'zmm')},
 'vcompressps': {('m128', 'xmm'), ('m256', 'ymm'), ('m512', 'zmm')},
 'vcvtps2ph': {('m128', 'ymm', 'imm'),
               ('m256', 'zmm', 'imm'),
               ('m64', 'xmm', 'imm')},
 'vextractf128': {('m128', 'ymm', 'imm')},
 'vextractf32x4': {('m128', 'ymm', 'imm')},
 'vextractf64x2': {('m128', 'ymm', 'imm'), ('m128', 'zmm', 'imm')},
 'vextractf32x8': {('m256', 'zmm', 'imm')},
 'vextracti128': {('m128', 'ymm', 'imm')},
 'vextracti32x4': {('m128', 'ymm', 'imm')},
 'vextracti64x2': {('m128', 'ymm', 'imm'), ('m128', 'zmm', 'imm')},
 'vextracti32x8': {('m256', 'zmm', 'imm')},
 'vmaskmovps': {('m128', 'xmm', 'xmm'), ('m256', 'ymm', 'ymm')},
 'vmaskmovpd': {('m128', 'xmm', 'xmm'), ('m256', 'ymm', 'ymm')},
 'vpcompressb': {('m128', 'xmm'), ('m256', 'ymm'), ('m512', 'zmm')},
 'vpcompressw': {('m128', 'xmm'), ('m256', 'ymm'), ('m512', 'zmm')},
 'vpcompressd': {('m128', 'xmm'), ('m256', 'ymm'), ('m512', 'zmm')},
 'vpcompressq': {('m128', 'xmm'), ('m256', 'ymm'), ('m512', 'zmm')},
 'vpmaskmovd': {('m128', 'xmm', 'xmm'), ('m256', 'ymm', 'ymm')},
 'vpmaskmovq': {('m128', 'xmm', 'xmm'), ('m256', 'ymm', 'ymm')},
 'vpmovdb': {('m32', 'xmm'), ('m128', 'zmm'), ('m64', 'ymm')},
 'vpmovsdb': {('m32', 'xmm'), ('m128', 'zmm'), ('m64', 'ymm')},
 'vpmovusdb': {('m32', 'xmm'), ('m128', 'zmm'), ('m64', 'ymm')},
 'vpmovdw': {('m64', 'xmm'), ('m256', 'zmm'), ('m128', 'ymm')},
 'vpmovsdw': {('m64', 'xmm'), ('m256', 'zmm'), ('m128', 'ymm')},
 'vpmovusdw': {('m64', 'xmm'), ('m256', 'zmm'), ('m128', 'ymm')},
 'vpmovqb': {('m64', 'zmm'), ('m32', 'ymm')},
 'vpmovsqb': {('m64', 'zmm'), ('m32', 'ymm')},
 'vpmovusqb': {('m64', 'zmm'), ('m32', 'ymm')},
 'vpmovqd': {('m128', 'xmm'), ('m256', 'zmm'), ('m128', 'ymm')},
 'vpmovsqd': {('m64', 'xmm'), ('m256', 'zmm'), ('m128', 'ymm')},
 'vpmovusqd': {('m64', 'xmm'), ('m256', 'zmm'), ('m128', 'ymm')},
 'vpmovqw': {('m32', 'xmm'), ('m128', 'zmm'), ('m64', 'ymm')},
 'vpmovsqw': {('m32', 'xmm'), ('m128', 'zmm'), ('m64', 'ymm')},
 'vpmovusqw': {('m32', 'xmm'), ('m128', 'zmm'), ('m64', 'ymm')},
 'vpmovwb': {('m64', 'xmm'), ('m256', 'zmm'), ('m128', 'ymm')},
 'vpmovswb': {('m64', 'xmm'), ('m256', 'zmm'), ('m128', 'ymm')},
 'vpmovuswb': {('m64', 'xmm'), ('m256', 'zmm'), ('m128', 'ymm')},
 'vpscatterdd': {('m32', 'xmm'), ('m32', 'ymm'), ('m32', 'zmm')},
 'vpscatterdq': {('m32', 'xmm'), ('m32', 'ymm'), ('m32', 'zmm')},
 'vpscatterqd': {('m64', 'xmm'), ('m64', 'ymm')},
 'vpscatterqq': {('m64', 'zmm'), ('m64', 'xmm'), ('m64', 'ymm')},
 'vscatterdps': {('m32', 'xmm'), ('m32', 'ymm'), ('m32', 'zmm')},
 'vscatterdpd': {('m32', 'xmm'), ('m32', 'ymm'), ('m32', 'zmm')},
 'vscatterqps': {('m64', 'xmm'), ('m64', 'ymm')},
 'vscatterqpd': {('m64', 'zmm'), ('m64', 'xmm'), ('m64', 'ymm')},
 'xor': {('m64', 'm32'), ('m64', 'imm'), ('m32', 'imm'), ('m32', 'm32')}}
RegMemTbl={'aad': {('imm',)},
 'aam': {('imm',)},
 'addpd': {('xmm', 'm128')},
 'vaddpd': {('xmm', 'xmm', 'm128'),
            ('ymm', 'ymm', 'm256'),
            ('zmm', 'zmm', 'm512')},
 'addps': {('xmm', 'm128')},
 'vaddps': {('xmm', 'xmm', 'm128'),
            ('ymm', 'ymm', 'm256'),
            ('zmm', 'zmm', 'm512')},
 'addsd': {('xmm', 'm64')},
 'vaddsd': {('xmm', 'xmm', 'm64')},
 'addss': {('xmm', 'm32')},
 'vaddss': {('xmm', 'xmm', 'm32')},
 'addsubpd': {('xmm', 'm128')},
 'vaddsubpd': {('xmm', 'xmm', 'm128'), ('ymm', 'ymm', 'm256')},
 'addsubps': {('xmm', 'm128')},
 'vaddsubps': {('xmm', 'xmm', 'm128'), ('ymm', 'ymm', 'm256')},
 'aesdec': {('xmm', 'm128')},
 'vaesdec': {('xmm', 'xmm', 'm128'),
             ('ymm', 'ymm', 'm256'),
             ('zmm', 'zmm', 'm512')},
 'aesdec256kl': {('xmm', 'm512')},
 'aesdeclast': {('xmm', 'm128')},
 'vaesdeclast': {('xmm', 'xmm', 'm128'),
                 ('ymm', 'ymm', 'm256'),
                 ('zmm', 'zmm', 'm512')},
 'aesenc': {('xmm', 'm128')},
 'vaesenc': {('xmm', 'xmm', 'm128'),
             ('ymm', 'ymm', 'm256'),
             ('zmm', 'zmm', 'm512')},
 'aesenc256kl': {('xmm', 'm512')},
 'aesenclast': {('xmm', 'm128')},
 'vaesenclast': {('xmm', 'xmm', 'm128'),
                 ('ymm', 'ymm', 'm256'),
                 ('zmm', 'zmm', 'm512')},
 'aesimc': {('xmm', 'm128')},
 'vaesimc': {('xmm', 'm128')},
 'aeskeygenassist': {('xmm', 'm128', 'imm')},
 'vaeskeygenassist': {('xmm', 'm128', 'imm')},
 'andpd': {('xmm', 'm128')},
 'vandpd': {('xmm', 'xmm', 'm128'),
            ('ymm', 'ymm', 'm256'),
            ('zmm', 'zmm', 'm512')},
 'andps': {('xmm', 'm128')},
 'vandps': {('xmm', 'xmm', 'm128'),
            ('ymm', 'ymm', 'm256'),
            ('zmm', 'zmm', 'm512')},
 'andnpd': {('xmm', 'm128')},
 'vandnpd': {('xmm', 'xmm', 'm128'),
             ('ymm', 'ymm', 'm256'),
             ('zmm', 'zmm', 'm512')},
 'andnps': {('xmm', 'm128')},
 'vandnps': {('xmm', 'xmm', 'm128'),
             ('ymm', 'ymm', 'm256'),
             ('zmm', 'zmm', 'm512')},
 'blendpd': {('xmm', 'm128', 'imm')},
 'vblendpd': {('xmm', 'xmm', 'm128', 'imm'), ('ymm', 'ymm', 'm256', 'imm')},
 'blendps': {('xmm', 'm128', 'imm')},
 'vblendps': {('xmm', 'xmm', 'm128', 'imm'), ('ymm', 'ymm', 'm256', 'imm')},
 'blendvpd': {('xmm', 'm128', 'xmm')},
 'vblendvpd': {('ymm', 'ymm', 'm256', 'ymm'), ('xmm', 'xmm', 'm128', 'xmm')},
 'blendvps': {('xmm', 'm128', 'xmm')},
 'vblendvps': {('ymm', 'ymm', 'm256', 'ymm'), ('xmm', 'xmm', 'm128', 'xmm')},
 'cmppd': {('xmm', 'm128', 'imm'), ('xmm', 'xmm', 'imm')},
 'vcmppd': {('k', 'xmm', 'm128', 'imm'),
            ('k', 'ymm', 'm256', 'imm'),
            ('k', 'zmm', 'm512', 'imm'),
            ('xmm', 'xmm', 'm128', 'imm'),
            ('ymm', 'ymm', 'm256', 'imm')},
 'cmpeqpd': {('xmm', 'xmm')},
 'cmpltpd': {('xmm', 'xmm')},
 'cmplepd': {('xmm', 'xmm')},
 'cmpunordpd': {('xmm', 'xmm')},
 'cmpneqpd': {('xmm', 'xmm')},
 'cmpnltpd': {('xmm', 'xmm')},
 'cmpnlepd': {('xmm', 'xmm')},
 'cmpordpd': {('xmm', 'xmm')},
 'cmpps': {('xmm', 'm128', 'imm'), ('xmm', 'xmm', 'imm')},
 'vcmpps': {('k', 'xmm', 'm128', 'imm'),
            ('k', 'ymm', 'm256', 'imm'),
            ('k', 'zmm', 'm512', 'imm'),
            ('xmm', 'xmm', 'm128', 'imm'),
            ('ymm', 'ymm', 'm256', 'imm')},
 'cmpeqps': {('xmm', 'xmm')},
 'cmpltps': {('xmm', 'xmm')},
 'cmpleps': {('xmm', 'xmm')},
 'cmpunordps': {('xmm', 'xmm')},
 'cmpneqps': {('xmm', 'xmm')},
 'cmpnltps': {('xmm', 'xmm')},
 'cmpnleps': {('xmm', 'xmm')},
 'cmpordps': {('xmm', 'xmm')},
 'cmpsd': {('xmm', 'xmm', 'imm'), ('xmm', 'm64', 'imm')},
 'vcmpsd': {('k', 'xmm', 'm64', 'imm'), ('xmm', 'xmm', 'm64', 'imm')},
 'cmpeqsd': {('xmm', 'xmm')},
 'cmpltsd': {('xmm', 'xmm')},
 'cmplesd': {('xmm', 'xmm')},
 'cmpunordsd': {('xmm', 'xmm')},
 'cmpneqsd': {('xmm', 'xmm')},
 'cmpnltsd': {('xmm', 'xmm')},
 'cmpnlesd': {('xmm', 'xmm')},
 'cmpordsd': {('xmm', 'xmm')},
 'cmpss': {('xmm', 'm32', 'imm'), ('xmm', 'xmm', 'imm')},
 'vcmpss': {('k', 'xmm', 'm32', 'imm'), ('xmm', 'xmm', 'm32', 'imm')},
 'cmpeqss': {('xmm', 'xmm')},
 'cmpltss': {('xmm', 'xmm')},
 'cmpless': {('xmm', 'xmm')},
 'cmpunordss': {('xmm', 'xmm')},
 'cmpneqss': {('xmm', 'xmm')},
 'cmpnltss': {('xmm', 'xmm')},
 'cmpnless': {('xmm', 'xmm')},
 'cmpordss': {('xmm', 'xmm')},
 'comisd': {('xmm', 'm64')},
 'vcomisd': {('xmm', 'm64')},
 'comiss': {('xmm', 'm32')},
 'vcomiss': {('xmm', 'm32')},
 'cvtdq2pd': {('xmm', 'm64')},
 'vcvtdq2pd': {('xmm', 'm64'), ('ymm', 'm128'), ('zmm', 'm256')},
 'cvtdq2ps': {('xmm', 'm128')},
 'vcvtdq2ps': {('xmm', 'm128'), ('ymm', 'm256'), ('zmm', 'm512')},
 'cvtpd2dq': {('xmm', 'm128')},
 'vcvtpd2dq': {('xmm', 'm128'), ('xmm', 'm256'), ('ymm', 'm512')},
 'cvtpd2ps': {('xmm', 'm128')},
 'vcvtpd2ps': {('xmm', 'm128'), ('xmm', 'm256'), ('ymm', 'm512')},
 'cvtpi2pd': {('xmm', 'm64')},
 'cvtpi2ps': {('xmm', 'm64')},
 'cvtps2dq': {('xmm', 'm128')},
 'vcvtps2dq': {('xmm', 'm128'), ('ymm', 'm256'), ('zmm', 'm512')},
 'cvtps2pd': {('xmm', 'm64')},
 'vcvtps2pd': {('xmm', 'm64'), ('ymm', 'm128'), ('zmm', 'm256')},
 'cvtsd2ss': {('xmm', 'm64')},
 'vcvtsd2ss': {('xmm', 'xmm', 'm64')},
 'cvtsi2sd': {('xmm', 'm64'), ('xmm', 'm32')},
 'vcvtsi2sd': {('xmm', 'xmm', 'm64'), ('xmm', 'xmm', 'm32')},
 'cvtsi2ss': {('xmm', 'm64'), ('xmm', 'm32')},
 'vcvtsi2ss': {('xmm', 'xmm', 'm64'), ('xmm', 'xmm', 'm32')},
 'cvtss2sd': {('xmm', 'm32')},
 'vcvtss2sd': {('xmm', 'xmm', 'm32')},
 'cvttpd2dq': {('xmm', 'm128')},
 'vcvttpd2dq': {('xmm', 'm128'), ('xmm', 'm256'), ('ymm', 'm512')},
 'cvttps2dq': {('xmm', 'm128')},
 'vcvttps2dq': {('xmm', 'm128'), ('ymm', 'm256'), ('zmm', 'm512')},
 'divpd': {('xmm', 'm128')},
 'vdivpd': {('xmm', 'xmm', 'm128'),
            ('ymm', 'ymm', 'm256'),
            ('zmm', 'zmm', 'm512')},
 'divps': {('xmm', 'm128')},
 'vdivps': {('xmm', 'xmm', 'm128'),
            ('ymm', 'ymm', 'm256'),
            ('zmm', 'zmm', 'm512')},
 'divsd': {('xmm', 'm64')},
 'vdivsd': {('xmm', 'xmm', 'm64')},
 'divss': {('xmm', 'm32')},
 'vdivss': {('xmm', 'xmm', 'm32')},
 'dppd': {('xmm', 'm128', 'imm')},
 'vdppd': {('xmm', 'xmm', 'm128', 'imm')},
 'dpps': {('xmm', 'm128', 'imm')},
 'vdpps': {('xmm', 'xmm', 'm128', 'imm'), ('ymm', 'ymm', 'm256', 'imm')},
 'gf2p8affineinvqb': {('xmm', 'm128', 'imm')},
 'vgf2p8affineinvqb': {('xmm', 'xmm', 'm128', 'imm'),
                       ('ymm', 'ymm', 'm256', 'imm'),
                       ('zmm', 'zmm', 'm512', 'imm')},
 'gf2p8affineqb': {('xmm', 'm128', 'imm')},
 'vgf2p8affineqb': {('xmm', 'xmm', 'm128', 'imm'),
                    ('ymm', 'ymm', 'm256', 'imm'),
                    ('zmm', 'zmm', 'm512', 'imm')},
 'gf2p8mulb': {('xmm', 'm128')},
 'vgf2p8mulb': {('xmm', 'xmm', 'm128'),
                ('ymm', 'ymm', 'm256'),
                ('zmm', 'zmm', 'm512')},
 'haddpd': {('xmm', 'm128')},
 'vhaddpd': {('xmm', 'xmm', 'm128'), ('ymm', 'ymm', 'm256')},
 'haddps': {('xmm', 'm128')},
 'vhaddps': {('xmm', 'xmm', 'm128'), ('ymm', 'ymm', 'm256')},
 'vhsubpd': {('xmm', 'xmm', 'm128'), ('ymm', 'ymm', 'm256')},
 'hsubpd': {('xmm', 'm128')},
 'hsubps': {('xmm', 'm128')},
 'vhsubps': {('xmm', 'xmm', 'm128'), ('ymm', 'ymm', 'm256')},
 'insertps': {('xmm', 'm32', 'imm')},
 'vinsertps': {('xmm', 'xmm', 'm32', 'imm')},
 'int': {('imm',)},
 'kmovq': {('k', 'm64')},
 'kmovd': {('k', 'm32')},
 'vlddqu': {('xmm', 'm128'), ('ymm', 'm256')},
 'maskmovdqu': {('xmm', 'xmm')},
 'vmaskmovdqu': {('xmm', 'xmm')},
 'maxpd': {('xmm', 'm128')},
 'vmaxpd': {('xmm', 'xmm', 'm128'),
            ('ymm', 'ymm', 'm256'),
            ('zmm', 'zmm', 'm512')},
 'maxps': {('xmm', 'm128')},
 'vmaxps': {('xmm', 'xmm', 'm128'),
            ('ymm', 'ymm', 'm256'),
            ('zmm', 'zmm', 'm512')},
 'maxsd': {('xmm', 'm64')},
 'vmaxsd': {('xmm', 'xmm', 'm64')},
 'maxss': {('xmm', 'm32')},
 'vmaxss': {('xmm', 'xmm', 'm32')},
 'minpd': {('xmm', 'm128')},
 'vminpd': {('xmm', 'xmm', 'm128'),
            ('ymm', 'ymm', 'm256'),
            ('zmm', 'zmm', 'm512')},
 'minps': {('xmm', 'm128')},
 'vminps': {('xmm', 'xmm', 'm128'),
            ('ymm', 'ymm', 'm256'),
            ('zmm', 'zmm', 'm512')},
 'minsd': {('xmm', 'm64')},
 'vminsd': {('xmm', 'xmm', 'm64')},
 'minss': {('xmm', 'm32')},
 'vminss': {('xmm', 'xmm', 'm32')},
 'movapd': {('xmm', 'm128')},
 'vmovapd': {('xmm', 'm128'), ('ymm', 'm256'), ('zmm', 'm512')},
 'movaps': {('xmm', 'm128')},
 'vmovaps': {('xmm', 'm128'), ('ymm', 'm256'), ('zmm', 'm512')},
 'vmovd': {('xmm', 'm32')},
 'vmovq': {('xmm', 'm64')},
 'movd': {('xmm', 'm32')},
 'movq': {('xmm', 'm64')},
 'movddup': {('xmm', 'm64')},
 'vmovddup': {('xmm', 'm64'), ('ymm', 'm256'), ('zmm', 'm512')},
 'movdqa': {('xmm', 'm128')},
 'vmovdqa': {('xmm', 'm128'), ('ymm', 'm256')},
 'vmovdqa32': {('xmm', 'm128'), ('ymm', 'm256'), ('zmm', 'm512')},
 'vmovdqa64': {('xmm', 'm128'), ('ymm', 'm256'), ('zmm', 'm512')},
 'movdqu': {('xmm', 'm128')},
 'vmovdqu': {('xmm', 'm128'), ('ymm', 'm256')},
 'vmovdqu8': {('xmm', 'm128'), ('ymm', 'm256'), ('zmm', 'm512')},
 'vmovdqu16': {('xmm', 'm128'), ('ymm', 'm256'), ('zmm', 'm512')},
 'vmovdqu32': {('xmm', 'm128'), ('ymm', 'm256'), ('zmm', 'm512')},
 'vmovdqu64': {('xmm', 'm128'), ('ymm', 'm256'), ('zmm', 'm512')},
 'movhlps': {('xmm', 'xmm')},
 'vmovhlps': {('xmm', 'xmm', 'xmm')},
 'movhpd': {('xmm', 'm64')},
 'vmovhpd': {('xmm', 'xmm', 'm64')},
 'movhps': {('xmm', 'm64')},
 'vmovhps': {('xmm', 'xmm', 'm64')},
 'movlhps': {('xmm', 'xmm')},
 'vmovlhps': {('xmm', 'xmm', 'xmm')},
 'movlpd': {('xmm', 'm64')},
 'vmovlpd': {('xmm', 'xmm', 'm64')},
 'movlps': {('xmm', 'm64')},
 'vmovlps': {('xmm', 'xmm', 'm64')},
 'movntdqa': {('xmm', 'm128')},
 'vmovntdqa': {('xmm', 'm128'), ('ymm', 'm256'), ('zmm', 'm512')},
 'movsd': {('xmm', 'm64'), ('xmm', 'xmm')},
 'vmovsd': {('xmm', 'm64'), ('xmm', 'xmm', 'xmm')},
 'movshdup': {('xmm', 'm128')},
 'vmovshdup': {('xmm', 'm128'), ('ymm', 'm256'), ('zmm', 'm512')},
 'movsldup': {('xmm', 'm128')},
 'vmovsldup': {('xmm', 'm128'), ('ymm', 'm256'), ('zmm', 'm512')},
 'movss': {('xmm', 'm32'), ('xmm', 'xmm')},
 'vmovss': {('xmm', 'm32'), ('xmm', 'xmm', 'xmm')},
 'movupd': {('xmm', 'm128')},
 'vmovupd': {('xmm', 'm128'), ('ymm', 'm256'), ('zmm', 'm512')},
 'movups': {('xmm', 'm128')},
 'vmovups': {('xmm', 'm128'), ('ymm', 'm256'), ('zmm', 'm512')},
 'mpsadbw': {('xmm', 'm128', 'imm')},
 'vmpsadbw': {('xmm', 'xmm', 'm128', 'imm'), ('ymm', 'ymm', 'm256', 'imm')},
 'mulpd': {('xmm', 'm128')},
 'vmulpd': {('xmm', 'xmm', 'm128'),
            ('ymm', 'ymm', 'm256'),
            ('zmm', 'zmm', 'm512')},
 'mulps': {('xmm', 'm128')},
 'vmulps': {('xmm', 'xmm', 'm128'),
            ('ymm', 'ymm', 'm256'),
            ('zmm', 'zmm', 'm512')},
 'mulsd': {('xmm', 'm64')},
 'vmulsd': {('xmm', 'xmm', 'm64')},
 'mulss': {('xmm', 'm32')},
 'vmulss': {('xmm', 'xmm', 'm32')},
 'orpd': {('xmm', 'm128')},
 'vorpd': {('xmm', 'xmm', 'm128'),
           ('ymm', 'ymm', 'm256'),
           ('zmm', 'zmm', 'm512')},
 'orps': {('xmm', 'm128')},
 'vorps': {('xmm', 'xmm', 'm128'),
           ('ymm', 'ymm', 'm256'),
           ('zmm', 'zmm', 'm512')},
 'vpabsb': {('xmm', 'm128'), ('ymm', 'm256'), ('zmm', 'm512')},
 'vpabsw': {('xmm', 'm128'), ('ymm', 'm256'), ('zmm', 'm512')},
 'pabsb': {('xmm', 'm128')},
 'pabsw': {('xmm', 'm128')},
 'pabsd': {('xmm', 'm128')},
 'vpabsd': {('xmm', 'm128'), ('ymm', 'm256'), ('zmm', 'm512')},
 'vpabsq': {('xmm', 'm128'), ('ymm', 'm256'), ('zmm', 'm512')},
 'vpacksswb': {('xmm', 'xmm', 'm128'),
               ('ymm', 'ymm', 'm256'),
               ('zmm', 'zmm', 'm512')},
 'vpackssdw': {('xmm', 'xmm', 'm128'),
               ('ymm', 'ymm', 'm256'),
               ('zmm', 'zmm', 'm512')},
 'packsswb': {('xmm', 'm128')},
 'packssdw': {('xmm', 'm128')},
 'packusdw': {('xmm', 'm128')},
 'vpackusdw': {('xmm', 'xmm', 'm128'),
               ('ymm', 'ymm', 'm256'),
               ('zmm', 'zmm', 'm512')},
 'vpackuswb': {('xmm', 'xmm', 'm128'),
               ('ymm', 'ymm', 'm256'),
               ('zmm', 'zmm', 'm512')},
 'packuswb': {('xmm', 'm128')},
 'paddb': {('xmm', 'm128')},
 'paddw': {('xmm', 'm128')},
 'paddd': {('xmm', 'm128')},
 'paddq': {('xmm', 'm128')},
 'vpaddb': {('xmm', 'xmm', 'm128'),
            ('ymm', 'ymm', 'm256'),
            ('zmm', 'zmm', 'm512')},
 'vpaddw': {('xmm', 'xmm', 'm128'),
            ('ymm', 'ymm', 'm256'),
            ('zmm', 'zmm', 'm512')},
 'vpaddd': {('xmm', 'xmm', 'm128'),
            ('ymm', 'ymm', 'm256'),
            ('zmm', 'zmm', 'm512')},
 'vpaddq': {('xmm', 'xmm', 'm128'),
            ('ymm', 'ymm', 'm256'),
            ('zmm', 'zmm', 'm512')},
 'vpaddsb': {('xmm', 'xmm', 'm128'),
             ('ymm', 'ymm', 'm256'),
             ('zmm', 'zmm', 'm512')},
 'vpaddsw': {('xmm', 'xmm', 'm128'),
             ('ymm', 'ymm', 'm256'),
             ('zmm', 'zmm', 'm512')},
 'paddsb': {('xmm', 'm128')},
 'paddsw': {('xmm', 'm128')},
 'vpaddusb': {('xmm', 'xmm', 'm128'),
              ('ymm', 'ymm', 'm256'),
              ('zmm', 'zmm', 'm512')},
 'vpaddusw': {('xmm', 'xmm', 'm128'),
              ('ymm', 'ymm', 'm256'),
              ('zmm', 'zmm', 'm512')},
 'paddusb': {('xmm', 'm128')},
 'paddusw': {('xmm', 'm128')},
 'vpalignr': {('xmm', 'xmm', 'm128', 'imm'),
              ('ymm', 'ymm', 'm256', 'imm'),
              ('zmm', 'zmm', 'm512', 'imm')},
 'palignr': {('xmm', 'm128', 'imm')},
 'vpandd': {('xmm', 'xmm', 'm128'),
            ('ymm', 'ymm', 'm256'),
            ('zmm', 'zmm', 'm512')},
 'vpandq': {('xmm', 'xmm', 'm128'),
            ('ymm', 'ymm', 'm256'),
            ('zmm', 'zmm', 'm512')},
 'pand': {('xmm', 'm128')},
 'vpand': {('xmm', 'xmm', 'm128'), ('ymm', 'ymm', 'm256')},
 'vpandnd': {('xmm', 'xmm', 'm128'),
             ('ymm', 'ymm', 'm256'),
             ('zmm', 'zmm', 'm512')},
 'vpandnq': {('xmm', 'xmm', 'm128'),
             ('ymm', 'ymm', 'm256'),
             ('zmm', 'zmm', 'm512')},
 'pandn': {('xmm', 'm128')},
 'vpandn': {('xmm', 'xmm', 'm128'), ('ymm', 'ymm', 'm256')},
 'vpavgb': {('xmm', 'xmm', 'm128'),
            ('ymm', 'ymm', 'm256'),
            ('zmm', 'zmm', 'm512')},
 'vpavgw': {('xmm', 'xmm', 'm128'),
            ('ymm', 'ymm', 'm256'),
            ('zmm', 'zmm', 'm512')},
 'pavgb': {('xmm', 'm128')},
 'pavgw': {('xmm', 'm128')},
 'pblendvb': {('xmm', 'm128', 'xmm')},
 'vpblendvb': {('ymm', 'ymm', 'm256', 'ymm'), ('xmm', 'xmm', 'm128', 'xmm')},
 'pblendw': {('xmm', 'm128', 'imm')},
 'vpblendw': {('xmm', 'xmm', 'm128', 'imm'), ('ymm', 'ymm', 'm256', 'imm')},
 'pclmulqdq': {('xmm', 'm128', 'imm')},
 'vpclmulqdq': {('xmm', 'xmm', 'm128', 'imm'),
                ('ymm', 'ymm', 'm256', 'imm'),
                ('zmm', 'zmm', 'm512', 'imm')},
 'pclmullqlqdq': {('xmm', 'xmm')},
 'pclmulhqlqdq': {('xmm', 'xmm')},
 'pclmullqhqdq': {('xmm', 'xmm')},
 'pclmulhqhqdq': {('xmm', 'xmm')},
 'vpcmpeqd': {('k', 'xmm', 'm128'),
              ('k', 'ymm', 'm256'),
              ('k', 'zmm', 'm512'),
              ('xmm', 'xmm', 'm128')},
 'pcmpeqb': {('xmm', 'm128')},
 'pcmpeqw': {('xmm', 'm128')},
 'pcmpeqd': {('xmm', 'm128')},
 'vpcmpeqb': {('xmm', 'xmm', 'm128')},
 'vpcmpeqw': {('xmm', 'xmm', 'm128')},
 'pcmpeqq': {('xmm', 'm128')},
 'vpcmpeqq': {('k', 'xmm', 'm128'),
              ('k', 'ymm', 'm256'),
              ('k', 'zmm', 'm512'),
              ('xmm', 'xmm', 'm128')},
 'pcmpestri': {('xmm', 'm128', 'imm')},
 'vpcmpestri': {('xmm', 'm128', 'imm')},
 'pcmpestrm': {('xmm', 'm128', 'imm')},
 'vpcmpestrm': {('xmm', 'm128', 'imm')},
 'vpcmpgtd': {('k', 'xmm', 'm128'),
              ('k', 'ymm', 'm256'),
              ('k', 'zmm', 'm512'),
              ('xmm', 'xmm', 'm128'),
              ('ymm', 'ymm', 'm256')},
 'vpcmpgtb': {('k', 'xmm', 'm128'),
              ('k', 'ymm', 'm256'),
              ('k', 'zmm', 'm512'),
              ('xmm', 'xmm', 'm128'),
              ('ymm', 'ymm', 'm256')},
 'pcmpgtb': {('xmm', 'm128')},
 'pcmpgtw': {('xmm', 'm128')},
 'pcmpgtd': {('xmm', 'm128')},
 'vpcmpgtw': {('k', 'xmm', 'm128'),
              ('k', 'ymm', 'm256'),
              ('k', 'zmm', 'm512'),
              ('xmm', 'xmm', 'm128'),
              ('ymm', 'ymm', 'm256')},
 'pcmpgtq': {('xmm', 'm128')},
 'vpcmpgtq': {('k', 'xmm', 'm128'),
              ('k', 'ymm', 'm256'),
              ('k', 'zmm', 'm512'),
              ('xmm', 'xmm', 'm128'),
              ('ymm', 'ymm', 'm256')},
 'pcmpistri': {('xmm', 'm128', 'imm')},
 'vpcmpistri': {('xmm', 'm128', 'imm')},
 'pcmpistrm': {('xmm', 'm128', 'imm')},
 'vpcmpistrm': {('xmm', 'm128', 'imm')},
 'phaddw': {('xmm', 'm128')},
 'phaddd': {('xmm', 'm128')},
 'vphaddw': {('xmm', 'xmm', 'm128'), ('ymm', 'ymm', 'm256')},
 'vphaddd': {('xmm', 'xmm', 'm128'), ('ymm', 'ymm', 'm256')},
 'phaddsw': {('xmm', 'm128')},
 'vphaddsw': {('xmm', 'xmm', 'm128'), ('ymm', 'ymm', 'm256')},
 'phminposuw': {('xmm', 'm128')},
 'vphminposuw': {('xmm', 'm128')},
 'phsubw': {('xmm', 'm128')},
 'phsubd': {('xmm', 'm128')},
 'vphsubw': {('xmm', 'xmm', 'm128'), ('ymm', 'ymm', 'm256')},
 'vphsubd': {('xmm', 'xmm', 'm128'), ('ymm', 'ymm', 'm256')},
 'phsubsw': {('xmm', 'm128')},
 'vphsubsw': {('xmm', 'xmm', 'm128'), ('ymm', 'ymm', 'm256')},
 'pinsrd': {('xmm', 'm32', 'imm')},
 'pinsrq': {('xmm', 'm64', 'imm')},
 'vpinsrd': {('xmm', 'xmm', 'm32', 'imm')},
 'vpinsrq': {('xmm', 'xmm', 'm64', 'imm')},
 'vpmaddubsw': {('xmm', 'xmm', 'm128'),
                ('ymm', 'ymm', 'm256'),
                ('zmm', 'zmm', 'm512')},
 'pmaddubsw': {('xmm', 'm128')},
 'vpmaddwd': {('xmm', 'xmm', 'm128'),
              ('ymm', 'ymm', 'm256'),
              ('zmm', 'zmm', 'm512')},
 'pmaddwd': {('xmm', 'm128')},
 'pmaxsb': {('xmm', 'm128')},
 'pmaxsw': {('xmm', 'm128')},
 'pmaxsd': {('xmm', 'm128')},
 'vpmaxsb': {('xmm', 'xmm', 'm128'),
             ('ymm', 'ymm', 'm256'),
             ('zmm', 'zmm', 'm512')},
 'vpmaxsw': {('xmm', 'xmm', 'm128'),
             ('ymm', 'ymm', 'm256'),
             ('zmm', 'zmm', 'm512')},
 'vpmaxsd': {('xmm', 'xmm', 'm128'),
             ('ymm', 'ymm', 'm256'),
             ('zmm', 'zmm', 'm512')},
 'vpmaxsq': {('xmm', 'xmm', 'm128'),
             ('ymm', 'ymm', 'm256'),
             ('zmm', 'zmm', 'm512')},
 'pmaxub': {('xmm', 'm128')},
 'pmaxuw': {('xmm', 'm128')},
 'vpmaxub': {('xmm', 'xmm', 'm128'),
             ('ymm', 'ymm', 'm256'),
             ('zmm', 'zmm', 'm512')},
 'vpmaxuw': {('xmm', 'xmm', 'm128'),
             ('ymm', 'ymm', 'm256'),
             ('zmm', 'zmm', 'm512')},
 'pmaxud': {('xmm', 'm128')},
 'vpmaxud': {('xmm', 'xmm', 'm128'),
             ('ymm', 'ymm', 'm256'),
             ('zmm', 'zmm', 'm512')},
 'vpmaxuq': {('xmm', 'xmm', 'm128'),
             ('ymm', 'ymm', 'm256'),
             ('zmm', 'zmm', 'm512')},
 'pminsb': {('xmm', 'm128')},
 'pminsw': {('xmm', 'm128')},
 'vpminsb': {('xmm', 'xmm', 'm128'),
             ('ymm', 'ymm', 'm256'),
             ('zmm', 'zmm', 'm512')},
 'vpminsw': {('xmm', 'xmm', 'm128'),
             ('ymm', 'ymm', 'm256'),
             ('zmm', 'zmm', 'm512')},
 'pminsd': {('xmm', 'm128')},
 'vpminsd': {('xmm', 'xmm', 'm128'),
             ('ymm', 'ymm', 'm256'),
             ('zmm', 'zmm', 'm512')},
 'vpminsq': {('xmm', 'xmm', 'm128'),
             ('ymm', 'ymm', 'm256'),
             ('zmm', 'zmm', 'm512')},
 'pminub': {('xmm', 'm128')},
 'pminuw': {('xmm', 'm128')},
 'vpminub': {('xmm', 'xmm', 'm128'),
             ('ymm', 'ymm', 'm256'),
             ('zmm', 'zmm', 'm512')},
 'vpminuw': {('xmm', 'xmm', 'm128'),
             ('ymm', 'ymm', 'm256'),
             ('zmm', 'zmm', 'm512')},
 'pminud': {('xmm', 'm128')},
 'vpminud': {('xmm', 'xmm', 'm128'),
             ('ymm', 'ymm', 'm256'),
             ('zmm', 'zmm', 'm512')},
 'vpminuq': {('xmm', 'xmm', 'm128'),
             ('ymm', 'ymm', 'm256'),
             ('zmm', 'zmm', 'm512')},
 'pmovsxbw': {('xmm', 'm64')},
 'pmovsxbd': {('xmm', 'm32')},
 'pmovsxbq': {('xmm', 'xmm')},
 'pmovsxwd': {('xmm', 'm64')},
 'pmovsxwq': {('xmm', 'm32')},
 'pmovsxdq': {('xmm', 'm64')},
 'vpmovsxbw': {('xmm', 'm64'), ('ymm', 'm128'), ('zmm', 'm256')},
 'vpmovsxbd': {('ymm', 'm64'), ('zmm', 'm128'), ('xmm', 'm32')},
 'vpmovsxbq': {('zmm', 'm64'), ('ymm', 'm32'), ('xmm', 'xmm')},
 'vpmovsxwd': {('xmm', 'm64'), ('ymm', 'm128'), ('zmm', 'm256')},
 'vpmovsxwq': {('ymm', 'm64'), ('zmm', 'm128'), ('xmm', 'm32')},
 'vpmovsxdq': {('xmm', 'm64'), ('ymm', 'm128'), ('zmm', 'm256')},
 'pmovzxbw': {('xmm', 'm64')},
 'pmovzxbd': {('xmm', 'm32')},
 'pmovzxbq': {('xmm', 'xmm')},
 'pmovzxwd': {('xmm', 'm64')},
 'pmovzxwq': {('xmm', 'm32')},
 'pmovzxdq': {('xmm', 'm64')},
 'vpmovzxbw': {('xmm', 'm64'), ('ymm', 'm128'), ('zmm', 'm256')},
 'vpmovzxbd': {('ymm', 'm64'), ('zmm', 'm128'), ('xmm', 'm32')},
 'vpmovzxbq': {('zmm', 'm64'), ('ymm', 'm32'), ('xmm', 'xmm')},
 'vpmovzxwd': {('xmm', 'm64'), ('ymm', 'm128'), ('zmm', 'm256')},
 'vpmovzxwq': {('ymm', 'm64'), ('zmm', 'm128'), ('xmm', 'm32')},
 'vpmovzxdq': {('xmm', 'm64'), ('ymm', 'm128'), ('zmm', 'm256')},
 'pmuldq': {('xmm', 'm128')},
 'vpmuldq': {('xmm', 'xmm', 'm128'),
             ('ymm', 'ymm', 'm256'),
             ('zmm', 'zmm', 'm512')},
 'vpmulhrsw': {('xmm', 'xmm', 'm128'),
               ('ymm', 'ymm', 'm256'),
               ('zmm', 'zmm', 'm512')},
 'pmulhrsw': {('xmm', 'm128')},
 'vpmulhuw': {('xmm', 'xmm', 'm128'),
              ('ymm', 'ymm', 'm256'),
              ('zmm', 'zmm', 'm512')},
 'pmulhuw': {('xmm', 'm128')},
 'vpmulhw': {('xmm', 'xmm', 'm128'),
             ('ymm', 'ymm', 'm256'),
             ('zmm', 'zmm', 'm512')},
 'pmulhw': {('xmm', 'm128')},
 'pmulld': {('xmm', 'm128')},
 'vpmulld': {('xmm', 'xmm', 'm128'),
             ('ymm', 'ymm', 'm256'),
             ('zmm', 'zmm', 'm512')},
 'vpmullq': {('xmm', 'xmm', 'm128'),
             ('ymm', 'ymm', 'm256'),
             ('zmm', 'zmm', 'm512')},
 'vpmullw': {('xmm', 'xmm', 'm128'),
             ('ymm', 'ymm', 'm256'),
             ('zmm', 'zmm', 'm512')},
 'pmullw': {('xmm', 'm128')},
 'vpmuludq': {('xmm', 'xmm', 'm128'),
              ('ymm', 'ymm', 'm256'),
              ('zmm', 'zmm', 'm512')},
 'pmuludq': {('xmm', 'm128')},
 'vpord': {('xmm', 'xmm', 'm128'),
           ('ymm', 'ymm', 'm256'),
           ('zmm', 'zmm', 'm512')},
 'vporq': {('xmm', 'xmm', 'm128'),
           ('ymm', 'ymm', 'm256'),
           ('zmm', 'zmm', 'm512')},
 'por': {('xmm', 'm128')},
 'vpor': {('xmm', 'xmm', 'm128'), ('ymm', 'ymm', 'm256')},
 'vpsadbw': {('xmm', 'xmm', 'm128'),
             ('ymm', 'ymm', 'm256'),
             ('zmm', 'zmm', 'm512')},
 'psadbw': {('xmm', 'm128')},
 'vpshufb': {('xmm', 'xmm', 'm128'),
             ('ymm', 'ymm', 'm256'),
             ('zmm', 'zmm', 'm512')},
 'pshufb': {('xmm', 'm128')},
 'vpshufd': {('xmm', 'm128', 'imm'),
             ('ymm', 'm256', 'imm'),
             ('zmm', 'm512', 'imm')},
 'pshufd': {('xmm', 'm128', 'imm')},
 'vpshufhw': {('xmm', 'm128', 'imm'),
              ('ymm', 'm256', 'imm'),
              ('zmm', 'm512', 'imm')},
 'pshufhw': {('xmm', 'm128', 'imm')},
 'vpshuflw': {('xmm', 'm128', 'imm'),
              ('ymm', 'm256', 'imm'),
              ('zmm', 'm512', 'imm')},
 'pshuflw': {('xmm', 'm128', 'imm')},
 'psignb': {('xmm', 'm128')},
 'psignw': {('xmm', 'm128')},
 'psignd': {('xmm', 'm128')},
 'vpsignb': {('xmm', 'xmm', 'm128'), ('ymm', 'ymm', 'm256')},
 'vpsignw': {('xmm', 'xmm', 'm128'), ('ymm', 'ymm', 'm256')},
 'vpsignd': {('xmm', 'xmm', 'm128'), ('ymm', 'ymm', 'm256')},
 'vpslldq': {('xmm', 'm128', 'imm'),
             ('xmm', 'xmm', 'imm'),
             ('ymm', 'm256', 'imm'),
             ('ymm', 'ymm', 'imm'),
             ('zmm', 'm512', 'imm')},
 'pslldq': {('xmm', 'imm')},
 'psllw': {('xmm', 'm128'), ('xmm', 'imm')},
 'pslld': {('xmm', 'm128'), ('xmm', 'imm')},
 'psllq': {('xmm', 'm128'), ('xmm', 'imm')},
 'vpsllw': {('xmm', 'm128', 'imm'),
            ('xmm', 'xmm', 'imm'),
            ('xmm', 'xmm', 'm128'),
            ('ymm', 'm256', 'imm'),
            ('ymm', 'ymm', 'imm'),
            ('ymm', 'ymm', 'm128'),
            ('zmm', 'm512', 'imm'),
            ('zmm', 'zmm', 'm128')},
 'vpslld': {('xmm', 'm128', 'imm'),
            ('xmm', 'xmm', 'imm'),
            ('xmm', 'xmm', 'm128'),
            ('ymm', 'm256', 'imm'),
            ('ymm', 'ymm', 'imm'),
            ('ymm', 'ymm', 'm128'),
            ('zmm', 'm512', 'imm'),
            ('zmm', 'zmm', 'm128')},
 'vpsllq': {('xmm', 'm128', 'imm'),
            ('xmm', 'xmm', 'imm'),
            ('xmm', 'xmm', 'm128'),
            ('ymm', 'm256', 'imm'),
            ('ymm', 'ymm', 'imm'),
            ('ymm', 'ymm', 'm128'),
            ('zmm', 'm512', 'imm'),
            ('zmm', 'zmm', 'm128')},
 'vpsraw': {('xmm', 'm128', 'imm'),
            ('xmm', 'xmm', 'imm'),
            ('xmm', 'xmm', 'm128'),
            ('ymm', 'm256', 'imm'),
            ('ymm', 'ymm', 'imm'),
            ('ymm', 'ymm', 'm128'),
            ('zmm', 'm512', 'imm'),
            ('zmm', 'zmm', 'm128')},
 'psraw': {('xmm', 'm128'), ('xmm', 'imm')},
 'psrad': {('xmm', 'm128'), ('xmm', 'imm')},
 'vpsrad': {('xmm', 'm128', 'imm'),
            ('xmm', 'xmm', 'imm'),
            ('xmm', 'xmm', 'm128'),
            ('ymm', 'm256', 'imm'),
            ('ymm', 'ymm', 'imm'),
            ('ymm', 'ymm', 'm128'),
            ('zmm', 'm512', 'imm'),
            ('zmm', 'zmm', 'm128')},
 'vpsraq': {('xmm', 'm128', 'imm'),
            ('xmm', 'xmm', 'm128'),
            ('ymm', 'm256', 'imm'),
            ('ymm', 'ymm', 'm128'),
            ('zmm', 'm512', 'imm'),
            ('zmm', 'zmm', 'm128')},
 'vpsrldq': {('xmm', 'm128', 'imm'),
             ('xmm', 'xmm', 'imm'),
             ('ymm', 'm256', 'imm'),
             ('ymm', 'ymm', 'imm'),
             ('zmm', 'm512', 'imm')},
 'psrldq': {('xmm', 'imm')},
 'psrlw': {('xmm', 'm128'), ('xmm', 'imm')},
 'psrld': {('xmm', 'm128'), ('xmm', 'imm')},
 'psrlq': {('xmm', 'm128'), ('xmm', 'imm')},
 'vpsrlw': {('xmm', 'm128', 'imm'),
            ('xmm', 'xmm', 'imm'),
            ('xmm', 'xmm', 'm128'),
            ('ymm', 'm256', 'imm'),
            ('ymm', 'ymm', 'imm'),
            ('ymm', 'ymm', 'm128'),
            ('zmm', 'm512', 'imm'),
            ('zmm', 'zmm', 'm128')},
 'vpsrld': {('xmm', 'm128', 'imm'),
            ('xmm', 'xmm', 'imm'),
            ('xmm', 'xmm', 'm128'),
            ('ymm', 'm256', 'imm'),
            ('ymm', 'ymm', 'imm'),
            ('ymm', 'ymm', 'm128'),
            ('zmm', 'm512', 'imm'),
            ('zmm', 'zmm', 'm128')},
 'vpsrlq': {('xmm', 'm128', 'imm'),
            ('xmm', 'xmm', 'imm'),
            ('xmm', 'xmm', 'm128'),
            ('ymm', 'm256', 'imm'),
            ('ymm', 'ymm', 'imm'),
            ('ymm', 'ymm', 'm128'),
            ('zmm', 'm512', 'imm'),
            ('zmm', 'zmm', 'm128')},
 'vpsubb': {('xmm', 'xmm', 'm128'),
            ('ymm', 'ymm', 'm256'),
            ('zmm', 'zmm', 'm512')},
 'vpsubd': {('xmm', 'xmm', 'm128'),
            ('ymm', 'ymm', 'm256'),
            ('zmm', 'zmm', 'm512')},
 'vpsubw': {('xmm', 'xmm', 'm128'),
            ('ymm', 'ymm', 'm256'),
            ('zmm', 'zmm', 'm512')},
 'psubb': {('xmm', 'm128')},
 'psubw': {('xmm', 'm128')},
 'psubd': {('xmm', 'm128')},
 'vpsubq': {('xmm', 'xmm', 'm128'),
            ('ymm', 'ymm', 'm256'),
            ('zmm', 'zmm', 'm512')},
 'psubq': {('xmm', 'm128')},
 'vpsubsb': {('xmm', 'xmm', 'm128'),
             ('ymm', 'ymm', 'm256'),
             ('zmm', 'zmm', 'm512')},
 'vpsubsw': {('xmm', 'xmm', 'm128'),
             ('ymm', 'ymm', 'm256'),
             ('zmm', 'zmm', 'm512')},
 'psubsb': {('xmm', 'm128')},
 'psubsw': {('xmm', 'm128')},
 'vpsubusb': {('xmm', 'xmm', 'm128'),
              ('ymm', 'ymm', 'm256'),
              ('zmm', 'zmm', 'm512')},
 'vpsubusw': {('xmm', 'xmm', 'm128'),
              ('ymm', 'ymm', 'm256'),
              ('zmm', 'zmm', 'm512')},
 'psubusb': {('xmm', 'm128')},
 'psubusw': {('xmm', 'm128')},
 'ptest': {('xmm', 'm128')},
 'vptest': {('xmm', 'm128'), ('ymm', 'm256')},
 'vpunpckhqdq': {('xmm', 'xmm', 'm128'),
                 ('ymm', 'ymm', 'm256'),
                 ('zmm', 'zmm', 'm512')},
 'vpunpckhbw': {('xmm', 'xmm', 'm128'),
                ('ymm', 'ymm', 'm256'),
                ('zmm', 'zmm', 'm512')},
 'vpunpckhwd': {('xmm', 'xmm', 'm128'),
                ('ymm', 'ymm', 'm256'),
                ('zmm', 'zmm', 'm512')},
 'vpunpckhdq': {('xmm', 'xmm', 'm128'),
                ('ymm', 'ymm', 'm256'),
                ('zmm', 'zmm', 'm512')},
 'punpckhbw': {('xmm', 'm128')},
 'punpckhwd': {('xmm', 'm128')},
 'punpckhdq': {('xmm', 'm128')},
 'punpckhqdq': {('xmm', 'm128')},
 'vpunpcklbw': {('xmm', 'xmm', 'm128'),
                ('ymm', 'ymm', 'm256'),
                ('zmm', 'zmm', 'm512')},
 'vpunpcklwd': {('xmm', 'xmm', 'm128'),
                ('ymm', 'ymm', 'm256'),
                ('zmm', 'zmm', 'm512')},
 'vpunpckldq': {('xmm', 'xmm', 'm128'),
                ('ymm', 'ymm', 'm256'),
                ('zmm', 'zmm', 'm512')},
 'vpunpcklqdq': {('xmm', 'xmm', 'm128'),
                 ('ymm', 'ymm', 'm256'),
                 ('zmm', 'zmm', 'm512')},
 'punpcklbw': {('xmm', 'm128')},
 'punpcklwd': {('xmm', 'm128')},
 'punpckldq': {('xmm', 'm128')},
 'punpcklqdq': {('xmm', 'm128')},
 'push': {('imm',)},
 'vpxor': {('xmm', 'xmm', 'm128'), ('ymm', 'ymm', 'm256')},
 'vpxord': {('xmm', 'xmm', 'm128'),
            ('ymm', 'ymm', 'm256'),
            ('zmm', 'zmm', 'm512')},
 'vpxorq': {('xmm', 'xmm', 'm128'),
            ('ymm', 'ymm', 'm256'),
            ('zmm', 'zmm', 'm512')},
 'pxor': {('xmm', 'm128')},
 'rcpps': {('xmm', 'm128')},
 'vrcpps': {('xmm', 'm128'), ('ymm', 'm256')},
 'rcpss': {('xmm', 'm32')},
 'vrcpss': {('xmm', 'xmm', 'm32')},
 'roundpd': {('xmm', 'm128', 'imm')},
 'vroundpd': {('xmm', 'm128', 'imm'), ('ymm', 'm256', 'imm')},
 'roundps': {('xmm', 'm128', 'imm')},
 'vroundps': {('xmm', 'm128', 'imm'), ('ymm', 'm256', 'imm')},
 'roundsd': {('xmm', 'm64', 'imm')},
 'vroundsd': {('xmm', 'xmm', 'm64', 'imm')},
 'roundss': {('xmm', 'm32', 'imm')},
 'vroundss': {('xmm', 'xmm', 'm32', 'imm')},
 'rsqrtps': {('xmm', 'm128')},
 'vrsqrtps': {('xmm', 'm128'), ('ymm', 'm256')},
 'rsqrtss': {('xmm', 'm32')},
 'vrsqrtss': {('xmm', 'xmm', 'm32')},
 'sha1rnds4': {('xmm', 'm128', 'imm')},
 'sha1nexte': {('xmm', 'm128')},
 'sha1msg1': {('xmm', 'm128')},
 'sha1msg2': {('xmm', 'm128')},
 'sha256rnds2': {('xmm', 'm128', 'xmm')},
 'sha256msg1': {('xmm', 'm128')},
 'sha256msg2': {('xmm', 'm128')},
 'shufpd': {('xmm', 'm128', 'imm')},
 'vshufpd': {('xmm', 'xmm', 'm128', 'imm'),
             ('ymm', 'ymm', 'm256', 'imm'),
             ('zmm', 'zmm', 'm512', 'imm')},
 'shufps': {('xmm', 'm128', 'imm')},
 'vshufps': {('xmm', 'xmm', 'm128', 'imm'),
             ('ymm', 'ymm', 'm256', 'imm'),
             ('zmm', 'zmm', 'm512', 'imm')},
 'sqrtpd': {('xmm', 'm128')},
 'vsqrtpd': {('xmm', 'm128'), ('ymm', 'm256'), ('zmm', 'm512')},
 'sqrtps': {('xmm', 'm128')},
 'vsqrtps': {('xmm', 'm128'), ('ymm', 'm256'), ('zmm', 'm512')},
 'sqrtsd': {('xmm', 'm64')},
 'vsqrtsd': {('xmm', 'xmm', 'm64')},
 'sqrtss': {('xmm', 'm32')},
 'vsqrtss': {('xmm', 'xmm', 'm32')},
 'subpd': {('xmm', 'm128')},
 'vsubpd': {('xmm', 'xmm', 'm128'),
            ('ymm', 'ymm', 'm256'),
            ('zmm', 'zmm', 'm512')},
 'subps': {('xmm', 'm128')},
 'vsubps': {('xmm', 'xmm', 'm128'),
            ('ymm', 'ymm', 'm256'),
            ('zmm', 'zmm', 'm512')},
 'subsd': {('xmm', 'm64')},
 'vsubsd': {('xmm', 'xmm', 'm64')},
 'subss': {('xmm', 'm32')},
 'vsubss': {('xmm', 'xmm', 'm32')},
 'ucomisd': {('xmm', 'm64')},
 'vucomisd': {('xmm', 'm64')},
 'ucomiss': {('xmm', 'm32')},
 'vucomiss': {('xmm', 'm32')},
 'unpckhpd': {('xmm', 'm128')},
 'vunpckhpd': {('xmm', 'xmm', 'm128'),
               ('ymm', 'ymm', 'm256'),
               ('zmm', 'zmm', 'm512')},
 'unpckhps': {('xmm', 'm128')},
 'vunpckhps': {('xmm', 'xmm', 'm128'),
               ('ymm', 'ymm', 'm256'),
               ('zmm', 'zmm', 'm512')},
 'unpcklpd': {('xmm', 'm128')},
 'vunpcklpd': {('xmm', 'xmm', 'm128'),
               ('ymm', 'ymm', 'm256'),
               ('zmm', 'zmm', 'm512')},
 'unpcklps': {('xmm', 'm128')},
 'vunpcklps': {('xmm', 'xmm', 'm128'),
               ('ymm', 'ymm', 'm256'),
               ('zmm', 'zmm', 'm512')},
 'valignd': {('xmm', 'xmm', 'm128', 'imm'),
             ('ymm', 'ymm', 'm256', 'imm'),
             ('zmm', 'zmm', 'm512', 'imm')},
 'valignq': {('xmm', 'xmm', 'm128', 'imm'),
             ('ymm', 'ymm', 'm256', 'imm'),
             ('zmm', 'zmm', 'm512', 'imm')},
 'vblendmpd': {('xmm', 'xmm', 'm128'),
               ('ymm', 'ymm', 'm256'),
               ('zmm', 'zmm', 'm512')},
 'vblendmps': {('xmm', 'xmm', 'm128'),
               ('ymm', 'ymm', 'm256'),
               ('zmm', 'zmm', 'm512')},
 'vbroadcastss': {('xmm', 'm32'),
                  ('xmm', 'xmm'),
                  ('ymm', 'm32'),
                  ('ymm', 'xmm'),
                  ('zmm', 'm32')},
 'vbroadcastsd': {('ymm', 'm64'), ('zmm', 'm64'), ('ymm', 'xmm')},
 'vbroadcastf128': {('ymm', 'm128')},
 'vbroadcastf32x2': {('ymm', 'm64'), ('zmm', 'm64')},
 'vbroadcastf32x4': {('ymm', 'm128'), ('zmm', 'm128')},
 'vbroadcastf64x2': {('ymm', 'm128'), ('zmm', 'm128')},
 'vbroadcastf32x8': {('zmm', 'm256')},
 'vbroadcastf64x4': {('zmm', 'm256')},
 'vcvtne2ps2bf16': {('xmm', 'xmm', 'm128'),
                    ('ymm', 'ymm', 'm256'),
                    ('zmm', 'zmm', 'm512')},
 'vcvtneps2bf16': {('xmm', 'm128'), ('xmm', 'm256'), ('ymm', 'm512')},
 'vcvtpd2qq': {('xmm', 'm128'), ('ymm', 'm256'), ('zmm', 'm512')},
 'vcvtpd2udq': {('xmm', 'm128'), ('xmm', 'm256'), ('ymm', 'm512')},
 'vcvtpd2uqq': {('xmm', 'm128'), ('ymm', 'm256'), ('zmm', 'm512')},
 'vcvtph2ps': {('xmm', 'm64'),
               ('xmm', 'm64', 'imm'),
               ('ymm', 'm128'),
               ('zmm', 'm256')},
 'vcvtps2udq': {('xmm', 'm128'), ('ymm', 'm256'), ('zmm', 'm512')},
 'vcvtps2qq': {('xmm', 'm64'), ('ymm', 'm128'), ('zmm', 'm256')},
 'vcvtps2uqq': {('xmm', 'm64'), ('ymm', 'm128'), ('zmm', 'm256')},
 'vcvtqq2pd': {('xmm', 'm128'), ('ymm', 'm256'), ('zmm', 'm512')},
 'vcvtqq2ps': {('xmm', 'm128'), ('xmm', 'm256'), ('ymm', 'm512')},
 'vcvttpd2qq': {('xmm', 'm128'), ('ymm', 'm256'), ('zmm', 'm512')},
 'vcvttpd2udq': {('xmm', 'm128'), ('xmm', 'm256'), ('ymm', 'm512')},
 'vcvttpd2uqq': {('xmm', 'm128'), ('ymm', 'm256'), ('zmm', 'm512')},
 'vcvttps2udq': {('xmm', 'm128'), ('ymm', 'm256'), ('zmm', 'm512')},
 'vcvttps2qq': {('xmm', 'm64'), ('ymm', 'm128'), ('zmm', 'm256')},
 'vcvttps2uqq': {('xmm', 'm64'), ('ymm', 'm128'), ('zmm', 'm256')},
 'vcvtudq2pd': {('xmm', 'm64'), ('ymm', 'm128'), ('zmm', 'm256')},
 'vcvtudq2ps': {('xmm', 'm128'), ('ymm', 'm256'), ('zmm', 'm512')},
 'vcvtuqq2pd': {('xmm', 'm128'), ('ymm', 'm256'), ('zmm', 'm512')},
 'vcvtuqq2ps': {('xmm', 'm128'), ('xmm', 'm256'), ('ymm', 'm512')},
 'vcvtusi2sd': {('xmm', 'xmm', 'm64'), ('xmm', 'xmm', 'm32')},
 'vcvtusi2ss': {('xmm', 'xmm', 'm64'), ('xmm', 'xmm', 'm32')},
 'vdbpsadbw': {('xmm', 'xmm', 'm128', 'imm'),
               ('ymm', 'ymm', 'm256', 'imm'),
               ('zmm', 'zmm', 'm512', 'imm')},
 'vdpbf16ps': {('xmm', 'xmm', 'm128'),
               ('ymm', 'ymm', 'm256'),
               ('zmm', 'zmm', 'm512')},
 'vexpandpd': {('xmm', 'm128'), ('ymm', 'm256'), ('zmm', 'm512')},
 'vexpandps': {('xmm', 'm128'), ('ymm', 'm256'), ('zmm', 'm512')},
 'vfixupimmpd': {('xmm', 'xmm', 'm128', 'imm'),
                 ('ymm', 'ymm', 'm256', 'imm'),
                 ('zmm', 'zmm', 'm512', 'imm')},
 'vfixupimmps': {('xmm', 'xmm', 'm128', 'imm'),
                 ('ymm', 'ymm', 'm256', 'imm'),
                 ('zmm', 'zmm', 'm512', 'imm')},
 'vfixupimmsd': {('xmm', 'xmm', 'm64', 'imm')},
 'vfixupimmss': {('xmm', 'xmm', 'm32', 'imm')},
 'vfmadd132pd': {('xmm', 'xmm', 'm128'),
                 ('ymm', 'ymm', 'm256'),
                 ('zmm', 'zmm', 'm512')},
 'vfmadd213pd': {('xmm', 'xmm', 'm128'),
                 ('ymm', 'ymm', 'm256'),
                 ('zmm', 'zmm', 'm512')},
 'vfmadd231pd': {('xmm', 'xmm', 'm128'),
                 ('ymm', 'ymm', 'm256'),
                 ('zmm', 'zmm', 'm512')},
 'vfmadd132ps': {('xmm', 'xmm', 'm128'),
                 ('ymm', 'ymm', 'm256'),
                 ('zmm', 'zmm', 'm512')},
 'vfmadd213ps': {('xmm', 'xmm', 'm128'),
                 ('ymm', 'ymm', 'm256'),
                 ('zmm', 'zmm', 'm512')},
 'vfmadd231ps': {('xmm', 'xmm', 'm128'),
                 ('ymm', 'ymm', 'm256'),
                 ('zmm', 'zmm', 'm512')},
 'vfmadd132sd': {('xmm', 'xmm', 'm64')},
 'vfmadd213sd': {('xmm', 'xmm', 'm64')},
 'vfmadd231sd': {('xmm', 'xmm', 'm64')},
 'vfmadd132ss': {('xmm', 'xmm', 'm32')},
 'vfmadd213ss': {('xmm', 'xmm', 'm32')},
 'vfmadd231ss': {('xmm', 'xmm', 'm32')},
 'vfmaddsub132pd': {('xmm', 'xmm', 'm128'),
                    ('ymm', 'ymm', 'm256'),
                    ('zmm', 'zmm', 'm512')},
 'vfmaddsub213pd': {('xmm', 'xmm', 'm128'),
                    ('ymm', 'ymm', 'm256'),
                    ('zmm', 'zmm', 'm512')},
 'vfmaddsub231pd': {('xmm', 'xmm', 'm128'),
                    ('ymm', 'ymm', 'm256'),
                    ('zmm', 'zmm', 'm512')},
 'vfmaddsub132ps': {('xmm', 'xmm', 'm128'),
                    ('ymm', 'ymm', 'm256'),
                    ('zmm', 'zmm', 'm512')},
 'vfmaddsub213ps': {('xmm', 'xmm', 'm128'),
                    ('ymm', 'ymm', 'm256'),
                    ('zmm', 'zmm', 'm512')},
 'vfmaddsub231ps': {('xmm', 'xmm', 'm128'),
                    ('ymm', 'ymm', 'm256'),
                    ('zmm', 'zmm', 'm512')},
 'vfmsubadd132pd': {('xmm', 'xmm', 'm128'),
                    ('ymm', 'ymm', 'm256'),
                    ('zmm', 'zmm', 'm512')},
 'vfmsubadd213pd': {('xmm', 'xmm', 'm128'),
                    ('ymm', 'ymm', 'm256'),
                    ('zmm', 'zmm', 'm512')},
 'vfmsubadd231pd': {('xmm', 'xmm', 'm128'),
                    ('ymm', 'ymm', 'm256'),
                    ('zmm', 'zmm', 'm512')},
 'vfmsubadd132ps': {('xmm', 'xmm', 'm128'),
                    ('ymm', 'ymm', 'm256'),
                    ('zmm', 'zmm', 'm512')},
 'vfmsubadd213ps': {('xmm', 'xmm', 'm128'),
                    ('ymm', 'ymm', 'm256'),
                    ('zmm', 'zmm', 'm512')},
 'vfmsubadd231ps': {('xmm', 'xmm', 'm128'),
                    ('ymm', 'ymm', 'm256'),
                    ('zmm', 'zmm', 'm512')},
 'vfmsub132pd': {('xmm', 'xmm', 'm128'),
                 ('ymm', 'ymm', 'm256'),
                 ('zmm', 'zmm', 'm512')},
 'vfmsub213pd': {('xmm', 'xmm', 'm128'),
                 ('ymm', 'ymm', 'm256'),
                 ('zmm', 'zmm', 'm512')},
 'vfmsub231pd': {('xmm', 'xmm', 'm128'),
                 ('ymm', 'ymm', 'm256'),
                 ('zmm', 'zmm', 'm512')},
 'vfmsub132ps': {('xmm', 'xmm', 'm128'),
                 ('ymm', 'ymm', 'm256'),
                 ('zmm', 'zmm', 'm512')},
 'vfmsub213ps': {('xmm', 'xmm', 'm128'),
                 ('ymm', 'ymm', 'm256'),
                 ('zmm', 'zmm', 'm512')},
 'vfmsub231ps': {('xmm', 'xmm', 'm128'),
                 ('ymm', 'ymm', 'm256'),
                 ('zmm', 'zmm', 'm512')},
 'vfmsub132sd': {('xmm', 'xmm', 'm64')},
 'vfmsub213sd': {('xmm', 'xmm', 'm64')},
 'vfmsub231sd': {('xmm', 'xmm', 'm64')},
 'vfmsub132ss': {('xmm', 'xmm', 'm32')},
 'vfmsub213ss': {('xmm', 'xmm', 'm32')},
 'vfmsub231ss': {('xmm', 'xmm', 'm32')},
 'vfnmadd132pd': {('xmm', 'xmm', 'm128'),
                  ('ymm', 'ymm', 'm256'),
                  ('zmm', 'zmm', 'm512')},
 'vfnmadd213pd': {('xmm', 'xmm', 'm128'),
                  ('ymm', 'ymm', 'm256'),
                  ('zmm', 'zmm', 'm512')},
 'vfnmadd231pd': {('xmm', 'xmm', 'm128'),
                  ('ymm', 'ymm', 'm256'),
                  ('zmm', 'zmm', 'm512')},
 'vfnmadd132ps': {('xmm', 'xmm', 'm128'),
                  ('ymm', 'ymm', 'm256'),
                  ('zmm', 'zmm', 'm512')},
 'vfnmadd213ps': {('xmm', 'xmm', 'm128'),
                  ('ymm', 'ymm', 'm256'),
                  ('zmm', 'zmm', 'm512')},
 'vfnmadd231ps': {('xmm', 'xmm', 'm128'),
                  ('ymm', 'ymm', 'm256'),
                  ('zmm', 'zmm', 'm512')},
 'vfnmadd132sd': {('xmm', 'xmm', 'm64')},
 'vfnmadd213sd': {('xmm', 'xmm', 'm64')},
 'vfnmadd231sd': {('xmm', 'xmm', 'm64')},
 'vfnmadd132ss': {('xmm', 'xmm', 'm32')},
 'vfnmadd213ss': {('xmm', 'xmm', 'm32')},
 'vfnmadd231ss': {('xmm', 'xmm', 'm32')},
 'vfnmsub132pd': {('xmm', 'xmm', 'm128'),
                  ('ymm', 'ymm', 'm256'),
                  ('zmm', 'zmm', 'm512')},
 'vfnmsub213pd': {('xmm', 'xmm', 'm128'),
                  ('ymm', 'ymm', 'm256'),
                  ('zmm', 'zmm', 'm512')},
 'vfnmsub231pd': {('xmm', 'xmm', 'm128'),
                  ('ymm', 'ymm', 'm256'),
                  ('zmm', 'zmm', 'm512')},
 'vfnmsub132ps': {('xmm', 'xmm', 'm128'),
                  ('ymm', 'ymm', 'm256'),
                  ('zmm', 'zmm', 'm512')},
 'vfnmsub213ps': {('xmm', 'xmm', 'm128'),
                  ('ymm', 'ymm', 'm256'),
                  ('zmm', 'zmm', 'm512')},
 'vfnmsub231ps': {('xmm', 'xmm', 'm128'),
                  ('ymm', 'ymm', 'm256'),
                  ('zmm', 'zmm', 'm512')},
 'vfnmsub132sd': {('xmm', 'xmm', 'm64')},
 'vfnmsub213sd': {('xmm', 'xmm', 'm64')},
 'vfnmsub231sd': {('xmm', 'xmm', 'm64')},
 'vfnmsub132ss': {('xmm', 'xmm', 'm32')},
 'vfnmsub213ss': {('xmm', 'xmm', 'm32')},
 'vfnmsub231ss': {('xmm', 'xmm', 'm32')},
 'vgatherdpd': {('xmm', 'm32'),
                ('xmm', 'm32', 'xmm'),
                ('ymm', 'm32'),
                ('ymm', 'm32', 'ymm'),
                ('zmm', 'm32')},
 'vgatherqpd': {('xmm', 'm64'),
                ('xmm', 'm64', 'xmm'),
                ('ymm', 'm64'),
                ('ymm', 'm64', 'ymm'),
                ('zmm', 'm64')},
 'vgatherdps': {('xmm', 'm32'),
                ('xmm', 'm32', 'xmm'),
                ('ymm', 'm32'),
                ('ymm', 'm32', 'ymm'),
                ('zmm', 'm32')},
 'vgatherqps': {('xmm', 'm64'), ('ymm', 'm64'), ('xmm', 'm64', 'xmm')},
 'vgetexppd': {('xmm', 'm128'), ('ymm', 'm256'), ('zmm', 'm512')},
 'vgetexpps': {('xmm', 'm128'), ('ymm', 'm256'), ('zmm', 'm512')},
 'vgetexpsd': {('xmm', 'xmm', 'm64')},
 'vgetexpss': {('xmm', 'xmm', 'm32')},
 'vgetmantpd': {('xmm', 'm128', 'imm'), ('ymm', 'm256', 'imm')},
 'vgetmantps': {('xmm', 'm128', 'imm'), ('ymm', 'm256', 'imm')},
 'vgetmantsd': {('xmm', 'xmm', 'm64', 'imm')},
 'vgetmantss': {('xmm', 'xmm', 'm32', 'imm')},
 'vinsertf128': {('ymm', 'ymm', 'm128', 'imm')},
 'vinsertf32x4': {('zmm', 'zmm', 'm128', 'imm'), ('ymm', 'ymm', 'm128', 'imm')},
 'vinsertf64x2': {('zmm', 'zmm', 'm128', 'imm'), ('ymm', 'ymm', 'm128', 'imm')},
 'vinsertf32x8': {('zmm', 'zmm', 'm256', 'imm')},
 'vinsertf64x4': {('zmm', 'zmm', 'm256', 'imm')},
 'vinserti128': {('ymm', 'ymm', 'm128', 'imm')},
 'vinserti32x4': {('zmm', 'zmm', 'm128', 'imm'), ('ymm', 'ymm', 'm128', 'imm')},
 'vinserti64x2': {('zmm', 'zmm', 'm128', 'imm'), ('ymm', 'ymm', 'm128', 'imm')},
 'vinserti32x8': {('zmm', 'zmm', 'm256', 'imm')},
 'vinserti64x4': {('zmm', 'zmm', 'm256', 'imm')},
 'vmaskmovps': {('xmm', 'xmm', 'm128'), ('ymm', 'ymm', 'm256')},
 'vmaskmovpd': {('xmm', 'xmm', 'm128'), ('ymm', 'ymm', 'm256')},
 'vp2intersectd': {('k', 'xmm', 'm128'),
                   ('k', 'ymm', 'm256'),
                   ('k', 'zmm', 'm512')},
 'vp2intersectq': {('k', 'xmm', 'm128'),
                   ('k', 'ymm', 'm256'),
                   ('k', 'zmm', 'm512')},
 'vpblendd': {('xmm', 'xmm', 'm128', 'imm'), ('ymm', 'ymm', 'm256', 'imm')},
 'vpblendmb': {('xmm', 'xmm', 'm128'),
               ('ymm', 'ymm', 'm256'),
               ('zmm', 'zmm', 'm512')},
 'vpblendmw': {('xmm', 'xmm', 'm128'),
               ('ymm', 'ymm', 'm256'),
               ('zmm', 'zmm', 'm512')},
 'vpblendmd': {('xmm', 'xmm', 'm128'),
               ('ymm', 'ymm', 'm256'),
               ('zmm', 'zmm', 'm512')},
 'vpblendmq': {('xmm', 'xmm', 'm128'),
               ('ymm', 'ymm', 'm256'),
               ('zmm', 'zmm', 'm512')},
 'vpbroadcastb': {('zmm', 'xmm'), ('ymm', 'xmm'), ('xmm', 'xmm')},
 'vpbroadcastw': {('zmm', 'xmm'), ('xmm', 'xmm'), ('ymm', 'xmm')},
 'vpbroadcastd': {('zmm', 'm32'), ('xmm', 'm32'), ('ymm', 'm32')},
 'vpbroadcastq': {('xmm', 'm64'), ('ymm', 'm64'), ('zmm', 'm64')},
 'vbroadcasti128': {('ymm', 'm128')},
 'vbroadcasti32x4': {('ymm', 'm128'), ('zmm', 'm128')},
 'vbroadcasti64x2': {('ymm', 'm128'), ('zmm', 'm128')},
 'vbroadcasti32x8': {('zmm', 'm256')},
 'vbroadcasti64x4': {('zmm', 'm256')},
 'vpbroadcastmb2q': {('xmm', 'k'), ('ymm', 'k'), ('zmm', 'k')},
 'vpbroadcastmw2d': {('xmm', 'k'), ('ymm', 'k'), ('zmm', 'k')},
 'vpcmpb': {('k', 'xmm', 'm128', 'imm'),
            ('k', 'ymm', 'm256', 'imm'),
            ('k', 'zmm', 'm512', 'imm')},
 'vpcmpub': {('k', 'xmm', 'm128', 'imm'),
             ('k', 'ymm', 'm256', 'imm'),
             ('k', 'zmm', 'm512', 'imm')},
 'vpcmpd': {('k', 'xmm', 'm128', 'imm'),
            ('k', 'ymm', 'm256', 'imm'),
            ('k', 'zmm', 'm512', 'imm')},
 'vpcmpud': {('k', 'xmm', 'm128', 'imm'),
             ('k', 'ymm', 'm256', 'imm'),
             ('k', 'zmm', 'm512', 'imm')},
 'vpcmpq': {('k', 'xmm', 'm128', 'imm'),
            ('k', 'ymm', 'm256', 'imm'),
            ('k', 'zmm', 'm512', 'imm')},
 'vpcmpuq': {('k', 'xmm', 'm128', 'imm'),
             ('k', 'ymm', 'm256', 'imm'),
             ('k', 'zmm', 'm512', 'imm')},
 'vpcmpw': {('k', 'xmm', 'm128', 'imm'),
            ('k', 'ymm', 'm256', 'imm'),
            ('k', 'zmm', 'm512', 'imm')},
 'vpcmpuw': {('k', 'xmm', 'm128', 'imm'),
             ('k', 'ymm', 'm256', 'imm'),
             ('k', 'zmm', 'm512', 'imm')},
 'vpcompressb': {('zmm', 'zmm'), ('ymm', 'ymm'), ('xmm', 'xmm')},
 'vpcompressw': {('zmm', 'zmm'), ('ymm', 'ymm'), ('xmm', 'xmm')},
 'vpconflictd': {('xmm', 'm128'), ('ymm', 'm256'), ('zmm', 'm512')},
 'vpconflictq': {('xmm', 'm128'), ('ymm', 'm256'), ('zmm', 'm512')},
 'vpdpbusd': {('xmm', 'xmm', 'm128'),
              ('ymm', 'ymm', 'm256'),
              ('zmm', 'zmm', 'm512')},
 'vpdpbusds': {('xmm', 'xmm', 'm128'),
               ('ymm', 'ymm', 'm256'),
               ('zmm', 'zmm', 'm512')},
 'vpdpwssd': {('xmm', 'xmm', 'm128'),
              ('ymm', 'ymm', 'm256'),
              ('zmm', 'zmm', 'm512')},
 'vpdpwssds': {('xmm', 'xmm', 'm128'),
               ('ymm', 'ymm', 'm256'),
               ('zmm', 'zmm', 'm512')},
 'vperm2f128': {('ymm', 'ymm', 'm256', 'imm')},
 'vperm2i128': {('ymm', 'ymm', 'm256', 'imm')},
 'vpermb': {('xmm', 'xmm', 'm128'),
            ('ymm', 'ymm', 'm256'),
            ('zmm', 'zmm', 'm512')},
 'vpermd': {('ymm', 'ymm', 'm256'), ('zmm', 'zmm', 'm512')},
 'vpermw': {('xmm', 'xmm', 'm128'),
            ('ymm', 'ymm', 'm256'),
            ('zmm', 'zmm', 'm512')},
 'vpermi2b': {('xmm', 'xmm', 'm128'),
              ('ymm', 'ymm', 'm256'),
              ('zmm', 'zmm', 'm512')},
 'vpermi2w': {('xmm', 'xmm', 'm128'),
              ('ymm', 'ymm', 'm256'),
              ('zmm', 'zmm', 'm512')},
 'vpermi2d': {('xmm', 'xmm', 'm128'),
              ('ymm', 'ymm', 'm256'),
              ('zmm', 'zmm', 'm512')},
 'vpermi2q': {('xmm', 'xmm', 'm128'),
              ('ymm', 'ymm', 'm256'),
              ('zmm', 'zmm', 'm512')},
 'vpermi2ps': {('xmm', 'xmm', 'm128'),
               ('ymm', 'ymm', 'm256'),
               ('zmm', 'zmm', 'm512')},
 'vpermi2pd': {('xmm', 'xmm', 'm128'),
               ('ymm', 'ymm', 'm256'),
               ('zmm', 'zmm', 'm512')},
 'vpermilpd': {('xmm', 'm128', 'imm'),
               ('xmm', 'xmm', 'm128'),
               ('ymm', 'm256', 'imm'),
               ('ymm', 'ymm', 'm256'),
               ('zmm', 'm512', 'imm'),
               ('zmm', 'zmm', 'm512')},
 'vpermilps': {('xmm', 'm128', 'imm'),
               ('xmm', 'xmm', 'm128'),
               ('ymm', 'm256', 'imm'),
               ('ymm', 'ymm', 'm256'),
               ('zmm', 'zmm', 'm512')},
 'vpermpd': {('ymm', 'm256', 'imm'),
             ('ymm', 'ymm', 'm256'),
             ('zmm', 'm512', 'imm'),
             ('zmm', 'zmm', 'm512')},
 'vpermps': {('ymm', 'ymm', 'm256'), ('zmm', 'zmm', 'm512')},
 'vpermq': {('ymm', 'm256', 'imm'),
            ('ymm', 'ymm', 'm256'),
            ('zmm', 'm512', 'imm'),
            ('zmm', 'zmm', 'm512')},
 'vpermt2b': {('xmm', 'xmm', 'm128'),
              ('ymm', 'ymm', 'm256'),
              ('zmm', 'zmm', 'm512')},
 'vpermt2w': {('xmm', 'xmm', 'm128'),
              ('ymm', 'ymm', 'm256'),
              ('zmm', 'zmm', 'm512')},
 'vpermt2d': {('xmm', 'xmm', 'm128'),
              ('ymm', 'ymm', 'm256'),
              ('zmm', 'zmm', 'm512')},
 'vpermt2q': {('xmm', 'xmm', 'm128'),
              ('ymm', 'ymm', 'm256'),
              ('zmm', 'zmm', 'm512')},
 'vpermt2ps': {('xmm', 'xmm', 'm128'),
               ('ymm', 'ymm', 'm256'),
               ('zmm', 'zmm', 'm512')},
 'vpermt2pd': {('xmm', 'xmm', 'm128'),
               ('ymm', 'ymm', 'm256'),
               ('zmm', 'zmm', 'm512')},
 'vpexpandb': {('xmm', 'm128'),
               ('xmm', 'xmm'),
               ('ymm', 'm256'),
               ('ymm', 'ymm'),
               ('zmm', 'm512'),
               ('zmm', 'zmm')},
 'vpexpandw': {('xmm', 'm128'),
               ('xmm', 'xmm'),
               ('ymm', 'm256'),
               ('ymm', 'ymm'),
               ('zmm', 'm512'),
               ('zmm', 'zmm')},
 'vpexpandd': {('xmm', 'm128'), ('ymm', 'm256'), ('zmm', 'm512')},
 'vpexpandq': {('xmm', 'm128'), ('ymm', 'm256'), ('zmm', 'm512')},
 'vpgatherdd': {('xmm', 'm32'),
                ('xmm', 'm32', 'xmm'),
                ('ymm', 'm32'),
                ('ymm', 'm32', 'ymm'),
                ('zmm', 'm32')},
 'vpgatherqd': {('xmm', 'm64'), ('ymm', 'm64'), ('xmm', 'm64', 'xmm')},
 'vpgatherdq': {('xmm', 'm32'),
                ('xmm', 'm32', 'xmm'),
                ('ymm', 'm32'),
                ('ymm', 'm32', 'ymm'),
                ('zmm', 'm32')},
 'vpgatherqq': {('xmm', 'm64'),
                ('xmm', 'm64', 'xmm'),
                ('ymm', 'm64'),
                ('ymm', 'm64', 'ymm'),
                ('zmm', 'm64')},
 'vplzcntd': {('xmm', 'm128'), ('ymm', 'm256'), ('zmm', 'm512')},
 'vplzcntq': {('xmm', 'm128'), ('ymm', 'm256'), ('zmm', 'm512')},
 'vpmadd52huq': {('xmm', 'xmm', 'm128'),
                 ('ymm', 'ymm', 'm256'),
                 ('zmm', 'zmm', 'm512')},
 'vpmadd52luq': {('xmm', 'xmm', 'm128'),
                 ('ymm', 'ymm', 'm256'),
                 ('zmm', 'zmm', 'm512')},
 'vpmaskmovd': {('xmm', 'xmm', 'm128'), ('ymm', 'ymm', 'm256')},
 'vpmaskmovq': {('xmm', 'xmm', 'm128'), ('ymm', 'ymm', 'm256')},
 'vpmovb2m': {('k', 'ymm'), ('k', 'zmm'), ('k', 'xmm')},
 'vpmovw2m': {('k', 'ymm'), ('k', 'zmm'), ('k', 'xmm')},
 'vpmovd2m': {('k', 'ymm'), ('k', 'zmm'), ('k', 'xmm')},
 'vpmovq2m': {('k', 'ymm'), ('k', 'zmm'), ('k', 'xmm')},
 'vpmovm2b': {('xmm', 'k'), ('ymm', 'k'), ('zmm', 'k')},
 'vpmovm2w': {('xmm', 'k'), ('ymm', 'k'), ('zmm', 'k')},
 'vpmovm2d': {('xmm', 'k'), ('ymm', 'k'), ('zmm', 'k')},
 'vpmovm2q': {('xmm', 'k'), ('ymm', 'k'), ('zmm', 'k')},
 'vpmovqb': {('xmm', 'xmm')},
 'vpmovsqb': {('xmm', 'xmm')},
 'vpmovusqb': {('xmm', 'xmm')},
 'vpmultishiftqb': {('xmm', 'xmm', 'm128'),
                    ('ymm', 'ymm', 'm256'),
                    ('zmm', 'zmm', 'm512')},
 'vpopcntb': {('xmm', 'm128'), ('ymm', 'm256'), ('zmm', 'm512')},
 'vpopcntw': {('xmm', 'm128'), ('ymm', 'm256'), ('zmm', 'm512')},
 'vpopcntd': {('xmm', 'm128'), ('ymm', 'm256'), ('zmm', 'm512')},
 'vpopcntq': {('xmm', 'm128'), ('ymm', 'm256'), ('zmm', 'm512')},
 'vprolvd': {('xmm', 'xmm', 'm128'),
             ('ymm', 'ymm', 'm256'),
             ('zmm', 'zmm', 'm512')},
 'vprold': {('xmm', 'm128', 'imm'),
            ('ymm', 'm256', 'imm'),
            ('zmm', 'm512', 'imm')},
 'vprolvq': {('xmm', 'xmm', 'm128'),
             ('ymm', 'ymm', 'm256'),
             ('zmm', 'zmm', 'm512')},
 'vprolq': {('xmm', 'm128', 'imm'),
            ('ymm', 'm256', 'imm'),
            ('zmm', 'm512', 'imm')},
 'vprorvd': {('xmm', 'xmm', 'm128'),
             ('ymm', 'ymm', 'm256'),
             ('zmm', 'zmm', 'm512')},
 'vprord': {('xmm', 'm128', 'imm'),
            ('ymm', 'm256', 'imm'),
            ('zmm', 'm512', 'imm')},
 'vprorvq': {('xmm', 'xmm', 'm128'),
             ('ymm', 'ymm', 'm256'),
             ('zmm', 'zmm', 'm512')},
 'vprorq': {('xmm', 'm128', 'imm'),
            ('ymm', 'm256', 'imm'),
            ('zmm', 'm512', 'imm')},
 'vpshldw': {('xmm', 'xmm', 'm128', 'imm'),
             ('ymm', 'ymm', 'm256', 'imm'),
             ('zmm', 'zmm', 'm512', 'imm')},
 'vpshldd': {('xmm', 'xmm', 'm128', 'imm'),
             ('ymm', 'ymm', 'm256', 'imm'),
             ('zmm', 'zmm', 'm512', 'imm')},
 'vpshldq': {('xmm', 'xmm', 'm128', 'imm'),
             ('ymm', 'ymm', 'm256', 'imm'),
             ('zmm', 'zmm', 'm512', 'imm')},
 'vpshldvw': {('xmm', 'xmm', 'm128'),
              ('ymm', 'ymm', 'm256'),
              ('zmm', 'zmm', 'm512')},
 'vpshldvd': {('xmm', 'xmm', 'm128'),
              ('ymm', 'ymm', 'm256'),
              ('zmm', 'zmm', 'm512')},
 'vpshldvq': {('xmm', 'xmm', 'm128'),
              ('ymm', 'ymm', 'm256'),
              ('zmm', 'zmm', 'm512')},
 'vpshrdw': {('xmm', 'xmm', 'm128', 'imm'),
             ('ymm', 'ymm', 'm256', 'imm'),
             ('zmm', 'zmm', 'm512', 'imm')},
 'vpshrdd': {('xmm', 'xmm', 'm128', 'imm'),
             ('ymm', 'ymm', 'm256', 'imm'),
             ('zmm', 'zmm', 'm512', 'imm')},
 'vpshrdq': {('xmm', 'xmm', 'm128', 'imm'),
             ('ymm', 'ymm', 'm256', 'imm'),
             ('zmm', 'zmm', 'm512', 'imm')},
 'vpshrdvw': {('xmm', 'xmm', 'm128'),
              ('ymm', 'ymm', 'm256'),
              ('zmm', 'zmm', 'm512')},
 'vpshrdvd': {('xmm', 'xmm', 'm128'),
              ('ymm', 'ymm', 'm256'),
              ('zmm', 'zmm', 'm512')},
 'vpshrdvq': {('xmm', 'xmm', 'm128'),
              ('ymm', 'ymm', 'm256'),
              ('zmm', 'zmm', 'm512')},
 'vpshufbitqmb': {('k', 'xmm', 'm128'),
                  ('k', 'ymm', 'm256'),
                  ('k', 'zmm', 'm512')},
 'vpsllvd': {('xmm', 'xmm', 'm128'),
             ('ymm', 'ymm', 'm256'),
             ('zmm', 'zmm', 'm512')},
 'vpsllvq': {('xmm', 'xmm', 'm128'),
             ('ymm', 'ymm', 'm256'),
             ('zmm', 'zmm', 'm512')},
 'vpsllvw': {('xmm', 'xmm', 'm128'),
             ('ymm', 'ymm', 'm256'),
             ('zmm', 'zmm', 'm512')},
 'vpsravd': {('xmm', 'xmm', 'm128'),
             ('ymm', 'ymm', 'm256'),
             ('zmm', 'zmm', 'm512')},
 'vpsravw': {('xmm', 'xmm', 'm128'),
             ('ymm', 'ymm', 'm256'),
             ('zmm', 'zmm', 'm512')},
 'vpsravq': {('xmm', 'xmm', 'm128'),
             ('ymm', 'ymm', 'm256'),
             ('zmm', 'zmm', 'm512')},
 'vpsrlvd': {('xmm', 'xmm', 'm128'),
             ('ymm', 'ymm', 'm256'),
             ('zmm', 'zmm', 'm512')},
 'vpsrlvq': {('xmm', 'xmm', 'm128'),
             ('ymm', 'ymm', 'm256'),
             ('zmm', 'zmm', 'm512')},
 'vpsrlvw': {('xmm', 'xmm', 'm128'),
             ('ymm', 'ymm', 'm256'),
             ('zmm', 'zmm', 'm512')},
 'vpternlogd': {('xmm', 'xmm', 'm128', 'imm'),
                ('ymm', 'ymm', 'm256', 'imm'),
                ('zmm', 'zmm', 'm512', 'imm')},
 'vpternlogq': {('xmm', 'xmm', 'm128', 'imm'),
                ('ymm', 'ymm', 'm256', 'imm'),
                ('zmm', 'zmm', 'm512', 'imm')},
 'vrangepd': {('xmm', 'xmm', 'm128', 'imm'),
              ('ymm', 'ymm', 'm256', 'imm'),
              ('zmm', 'zmm', 'm512', 'imm')},
 'vrangeps': {('xmm', 'xmm', 'm128', 'imm'),
              ('ymm', 'ymm', 'm256', 'imm'),
              ('zmm', 'zmm', 'm512', 'imm')},
 'vrangesd': {('xmm', 'xmm', 'm64', 'imm')},
 'vrangess': {('xmm', 'xmm', 'm32', 'imm')},
 'vrcp14pd': {('xmm', 'm128'), ('ymm', 'm256'), ('zmm', 'm512')},
 'vrcp14sd': {('xmm', 'xmm', 'm64')},
 'vrcp14ps': {('xmm', 'm128'), ('ymm', 'm256'), ('zmm', 'm512')},
 'vrcp14ss': {('xmm', 'xmm', 'm32')},
 'vreducepd': {('xmm', 'm128', 'imm'), ('ymm', 'm256', 'imm')},
 'vreduceps': {('xmm', 'm128', 'imm'), ('ymm', 'm256', 'imm')},
 'vrndscalepd': {('xmm', 'm128', 'imm'),
                 ('ymm', 'm256', 'imm'),
                 ('zmm', 'm512', 'imm')},
 'vrndscalesd': {('xmm', 'xmm', 'm64', 'imm')},
 'vrndscaleps': {('xmm', 'm128', 'imm'),
                 ('ymm', 'm256', 'imm'),
                 ('zmm', 'm512', 'imm')},
 'vrndscaless': {('xmm', 'xmm', 'm32', 'imm')},
 'vrsqrt14pd': {('xmm', 'm128'), ('ymm', 'm256'), ('zmm', 'm512')},
 'vrsqrt14sd': {('xmm', 'xmm', 'm64')},
 'vrsqrt14ps': {('xmm', 'm128'), ('ymm', 'm256'), ('zmm', 'm512')},
 'vrsqrt14ss': {('xmm', 'xmm', 'm32')},
 'vscalefpd': {('xmm', 'xmm', 'm128'),
               ('ymm', 'ymm', 'm256'),
               ('zmm', 'zmm', 'm512')},
 'vscalefsd': {('xmm', 'xmm', 'm64')},
 'vscalefps': {('xmm', 'xmm', 'm128'),
               ('ymm', 'ymm', 'm256'),
               ('zmm', 'zmm', 'm512')},
 'vscalefss': {('xmm', 'xmm', 'm32')},
 'vshuff32x4': {('ymm', 'ymm', 'm256', 'imm')},
 'vshuff64x2': {('ymm', 'ymm', 'm256', 'imm')},
 'vshufi32x4': {('ymm', 'ymm', 'm256', 'imm')},
 'vshufi64x2': {('ymm', 'ymm', 'm256', 'imm')},
 'vtestps': {('xmm', 'm128'), ('ymm', 'm256')},
 'vtestpd': {('xmm', 'm128'), ('ymm', 'm256')},
 'xabort': {('imm',)},
 'xorpd': {('xmm', 'm128')},
 'vxorpd': {('xmm', 'xmm', 'm128'),
            ('ymm', 'ymm', 'm256'),
            ('zmm', 'zmm', 'm512')},
 'xorps': {('xmm', 'm128')},
 'vxorps': {('xmm', 'xmm', 'm128'),
            ('ymm', 'ymm', 'm256'),
            ('zmm', 'zmm', 'm512')},
 'vcmpeqpd': {('k', 'xmm', 'm128'),
              ('k', 'ymm', 'm256)'),
              ('k', 'zmm', 'm512'),
              ('xmm', 'xmm', 'm128'),
              ('ymm', 'ymm', 'm256')},
 'vcmpltpd': {('k', 'xmm', 'm128'),
              ('k', 'ymm', 'm256)'),
              ('k', 'zmm', 'm512'),
              ('xmm', 'xmm', 'm128'),
              ('ymm', 'ymm', 'm256')},
 'vcmplepd': {('k', 'xmm', 'm128'),
              ('k', 'ymm', 'm256)'),
              ('k', 'zmm', 'm512'),
              ('xmm', 'xmm', 'm128'),
              ('ymm', 'ymm', 'm256')},
 'vcmpunordpd': {('k', 'xmm', 'm128'),
                 ('k', 'ymm', 'm256)'),
                 ('k', 'zmm', 'm512'),
                 ('xmm', 'xmm', 'm128'),
                 ('ymm', 'ymm', 'm256')},
 'vcmpneqpd': {('k', 'xmm', 'm128'),
               ('k', 'ymm', 'm256)'),
               ('k', 'zmm', 'm512'),
               ('xmm', 'xmm', 'm128'),
               ('ymm', 'ymm', 'm256')},
 'vcmpnltpd': {('k', 'xmm', 'm128'),
               ('k', 'ymm', 'm256)'),
               ('k', 'zmm', 'm512'),
               ('xmm', 'xmm', 'm128'),
               ('ymm', 'ymm', 'm256')},
 'vcmpnlepd': {('k', 'xmm', 'm128'),
               ('k', 'ymm', 'm256)'),
               ('k', 'zmm', 'm512'),
               ('xmm', 'xmm', 'm128'),
               ('ymm', 'ymm', 'm256')},
 'vcmpordpd': {('k', 'xmm', 'm128'),
               ('k', 'ymm', 'm256)'),
               ('k', 'zmm', 'm512'),
               ('xmm', 'xmm', 'm128'),
               ('ymm', 'ymm', 'm256')},
 'vcmpeq_uqpd': {('k', 'xmm', 'm128'),
                 ('k', 'ymm', 'm256)'),
                 ('k', 'zmm', 'm512'),
                 ('xmm', 'xmm', 'm128'),
                 ('ymm', 'ymm', 'm256')},
 'vcmpngepd': {('k', 'xmm', 'm128'),
               ('k', 'ymm', 'm256)'),
               ('k', 'zmm', 'm512'),
               ('xmm', 'xmm', 'm128'),
               ('ymm', 'ymm', 'm256')},
 'vcmpngtpd': {('k', 'xmm', 'm128'),
               ('k', 'ymm', 'm256)'),
               ('k', 'zmm', 'm512'),
               ('xmm', 'xmm', 'm128'),
               ('ymm', 'ymm', 'm256')},
 'vcmpfalsepd': {('k', 'xmm', 'm128'),
                 ('k', 'ymm', 'm256)'),
                 ('k', 'zmm', 'm512'),
                 ('xmm', 'xmm', 'm128'),
                 ('ymm', 'ymm', 'm256')},
 'vcmpneq_oqpd': {('k', 'xmm', 'm128'),
                  ('k', 'ymm', 'm256)'),
                  ('k', 'zmm', 'm512'),
                  ('xmm', 'xmm', 'm128'),
                  ('ymm', 'ymm', 'm256')},
 'vcmpgepd': {('k', 'xmm', 'm128'),
              ('k', 'ymm', 'm256)'),
              ('k', 'zmm', 'm512'),
              ('xmm', 'xmm', 'm128'),
              ('ymm', 'ymm', 'm256')},
 'vcmpgtpd': {('k', 'xmm', 'm128'),
              ('k', 'ymm', 'm256)'),
              ('k', 'zmm', 'm512'),
              ('xmm', 'xmm', 'm128'),
              ('ymm', 'ymm', 'm256')},
 'vcmptruepd': {('k', 'xmm', 'm128'),
                ('k', 'ymm', 'm256)'),
                ('k', 'zmm', 'm512'),
                ('xmm', 'xmm', 'm128'),
                ('ymm', 'ymm', 'm256')},
 'vcmpeq_ospd': {('k', 'xmm', 'm128'),
                 ('k', 'ymm', 'm256)'),
                 ('k', 'zmm', 'm512'),
                 ('xmm', 'xmm', 'm128'),
                 ('ymm', 'ymm', 'm256')},
 'vcmplt_oqpd': {('k', 'xmm', 'm128'),
                 ('k', 'ymm', 'm256)'),
                 ('k', 'zmm', 'm512'),
                 ('xmm', 'xmm', 'm128'),
                 ('ymm', 'ymm', 'm256')},
 'vcmple_oqpd': {('k', 'xmm', 'm128'),
                 ('k', 'ymm', 'm256)'),
                 ('k', 'zmm', 'm512'),
                 ('xmm', 'xmm', 'm128'),
                 ('ymm', 'ymm', 'm256')},
 'vcmpunord_spd': {('k', 'xmm', 'm128'),
                   ('k', 'ymm', 'm256)'),
                   ('k', 'zmm', 'm512'),
                   ('xmm', 'xmm', 'm128'),
                   ('ymm', 'ymm', 'm256')},
 'vcmpneq_uspd': {('k', 'xmm', 'm128'),
                  ('k', 'ymm', 'm256)'),
                  ('k', 'zmm', 'm512'),
                  ('xmm', 'xmm', 'm128'),
                  ('ymm', 'ymm', 'm256')},
 'vcmpnlt_uqpd': {('k', 'xmm', 'm128'),
                  ('k', 'ymm', 'm256)'),
                  ('k', 'zmm', 'm512'),
                  ('xmm', 'xmm', 'm128'),
                  ('ymm', 'ymm', 'm256')},
 'vcmpnle_uqpd': {('k', 'xmm', 'm128'),
                  ('k', 'ymm', 'm256)'),
                  ('k', 'zmm', 'm512'),
                  ('xmm', 'xmm', 'm128'),
                  ('ymm', 'ymm', 'm256')},
 'vcmpord_spd': {('k', 'xmm', 'm128'),
                 ('k', 'ymm', 'm256)'),
                 ('k', 'zmm', 'm512'),
                 ('xmm', 'xmm', 'm128'),
                 ('ymm', 'ymm', 'm256')},
 'vcmpeq_uspd': {('k', 'xmm', 'm128'),
                 ('k', 'ymm', 'm256)'),
                 ('k', 'zmm', 'm512'),
                 ('xmm', 'xmm', 'm128'),
                 ('ymm', 'ymm', 'm256')},
 'vcmpnge_uqpd': {('k', 'xmm', 'm128'),
                  ('k', 'ymm', 'm256)'),
                  ('k', 'zmm', 'm512'),
                  ('xmm', 'xmm', 'm128'),
                  ('ymm', 'ymm', 'm256')},
 'vcmpngt_uqpd': {('k', 'xmm', 'm128'),
                  ('k', 'ymm', 'm256)'),
                  ('k', 'zmm', 'm512'),
                  ('xmm', 'xmm', 'm128'),
                  ('ymm', 'ymm', 'm256')},
 'vcmpfalse_ospd': {('k', 'xmm', 'm128'),
                    ('k', 'ymm', 'm256)'),
                    ('k', 'zmm', 'm512'),
                    ('xmm', 'xmm', 'm128'),
                    ('ymm', 'ymm', 'm256')},
 'vcmpneq_ospd': {('k', 'xmm', 'm128'),
                  ('k', 'ymm', 'm256)'),
                  ('k', 'zmm', 'm512'),
                  ('xmm', 'xmm', 'm128'),
                  ('ymm', 'ymm', 'm256')},
 'vcmpge_oqpd': {('k', 'xmm', 'm128'),
                 ('k', 'ymm', 'm256)'),
                 ('k', 'zmm', 'm512'),
                 ('xmm', 'xmm', 'm128'),
                 ('ymm', 'ymm', 'm256')},
 'vcmpgt_oqpd': {('k', 'xmm', 'm128'),
                 ('k', 'ymm', 'm256)'),
                 ('k', 'zmm', 'm512'),
                 ('xmm', 'xmm', 'm128'),
                 ('ymm', 'ymm', 'm256')},
 'vcmptrue_uspd': {('k', 'xmm', 'm128'),
                   ('k', 'ymm', 'm256)'),
                   ('k', 'zmm', 'm512'),
                   ('xmm', 'xmm', 'm128'),
                   ('ymm', 'ymm', 'm256')},
 'vcmpeqps': {('k', 'xmm', 'm128'),
              ('k', 'ymm', 'm256)'),
              ('k', 'zmm', 'm512'),
              ('xmm', 'xmm', 'm128'),
              ('ymm', 'ymm', 'm256')},
 'vcmpltps': {('k', 'xmm', 'm128'),
              ('k', 'ymm', 'm256)'),
              ('k', 'zmm', 'm512'),
              ('xmm', 'xmm', 'm128'),
              ('ymm', 'ymm', 'm256')},
 'vcmpleps': {('k', 'xmm', 'm128'),
              ('k', 'ymm', 'm256)'),
              ('k', 'zmm', 'm512'),
              ('xmm', 'xmm', 'm128'),
              ('ymm', 'ymm', 'm256')},
 'vcmpunordps': {('k', 'xmm', 'm128'),
                 ('k', 'ymm', 'm256)'),
                 ('k', 'zmm', 'm512'),
                 ('xmm', 'xmm', 'm128'),
                 ('ymm', 'ymm', 'm256')},
 'vcmpneqps': {('k', 'xmm', 'm128'),
               ('k', 'ymm', 'm256)'),
               ('k', 'zmm', 'm512'),
               ('xmm', 'xmm', 'm128'),
               ('ymm', 'ymm', 'm256')},
 'vcmpnltps': {('k', 'xmm', 'm128'),
               ('k', 'ymm', 'm256)'),
               ('k', 'zmm', 'm512'),
               ('xmm', 'xmm', 'm128'),
               ('ymm', 'ymm', 'm256')},
 'vcmpnleps': {('k', 'xmm', 'm128'),
               ('k', 'ymm', 'm256)'),
               ('k', 'zmm', 'm512'),
               ('xmm', 'xmm', 'm128'),
               ('ymm', 'ymm', 'm256')},
 'vcmpordps': {('k', 'xmm', 'm128'),
               ('k', 'ymm', 'm256)'),
               ('k', 'zmm', 'm512'),
               ('xmm', 'xmm', 'm128'),
               ('ymm', 'ymm', 'm256')},
 'vcmpeq_uqps': {('k', 'xmm', 'm128'),
                 ('k', 'ymm', 'm256)'),
                 ('k', 'zmm', 'm512'),
                 ('xmm', 'xmm', 'm128'),
                 ('ymm', 'ymm', 'm256')},
 'vcmpngeps': {('k', 'xmm', 'm128'),
               ('k', 'ymm', 'm256)'),
               ('k', 'zmm', 'm512'),
               ('xmm', 'xmm', 'm128'),
               ('ymm', 'ymm', 'm256')},
 'vcmpngtps': {('k', 'xmm', 'm128'),
               ('k', 'ymm', 'm256)'),
               ('k', 'zmm', 'm512'),
               ('xmm', 'xmm', 'm128'),
               ('ymm', 'ymm', 'm256')},
 'vcmpfalseps': {('k', 'xmm', 'm128'),
                 ('k', 'ymm', 'm256)'),
                 ('k', 'zmm', 'm512'),
                 ('xmm', 'xmm', 'm128'),
                 ('ymm', 'ymm', 'm256')},
 'vcmpneq_oqps': {('k', 'xmm', 'm128'),
                  ('k', 'ymm', 'm256)'),
                  ('k', 'zmm', 'm512'),
                  ('xmm', 'xmm', 'm128'),
                  ('ymm', 'ymm', 'm256')},
 'vcmpgeps': {('k', 'xmm', 'm128'),
              ('k', 'ymm', 'm256)'),
              ('k', 'zmm', 'm512'),
              ('xmm', 'xmm', 'm128'),
              ('ymm', 'ymm', 'm256')},
 'vcmpgtps': {('k', 'xmm', 'm128'),
              ('k', 'ymm', 'm256)'),
              ('k', 'zmm', 'm512'),
              ('xmm', 'xmm', 'm128'),
              ('ymm', 'ymm', 'm256')},
 'vcmptrueps': {('k', 'xmm', 'm128'),
                ('k', 'ymm', 'm256)'),
                ('k', 'zmm', 'm512'),
                ('xmm', 'xmm', 'm128'),
                ('ymm', 'ymm', 'm256')},
 'vcmpeq_osps': {('k', 'xmm', 'm128'),
                 ('k', 'ymm', 'm256)'),
                 ('k', 'zmm', 'm512'),
                 ('xmm', 'xmm', 'm128'),
                 ('ymm', 'ymm', 'm256')},
 'vcmplt_oqps': {('k', 'xmm', 'm128'),
                 ('k', 'ymm', 'm256)'),
                 ('k', 'zmm', 'm512'),
                 ('xmm', 'xmm', 'm128'),
                 ('ymm', 'ymm', 'm256')},
 'vcmple_oqps': {('k', 'xmm', 'm128'),
                 ('k', 'ymm', 'm256)'),
                 ('k', 'zmm', 'm512'),
                 ('xmm', 'xmm', 'm128'),
                 ('ymm', 'ymm', 'm256')},
 'vcmpunord_sps': {('k', 'xmm', 'm128'),
                   ('k', 'ymm', 'm256)'),
                   ('k', 'zmm', 'm512'),
                   ('xmm', 'xmm', 'm128'),
                   ('ymm', 'ymm', 'm256')},
 'vcmpneq_usps': {('k', 'xmm', 'm128'),
                  ('k', 'ymm', 'm256)'),
                  ('k', 'zmm', 'm512'),
                  ('xmm', 'xmm', 'm128'),
                  ('ymm', 'ymm', 'm256')},
 'vcmpnlt_uqps': {('k', 'xmm', 'm128'),
                  ('k', 'ymm', 'm256)'),
                  ('k', 'zmm', 'm512'),
                  ('xmm', 'xmm', 'm128'),
                  ('ymm', 'ymm', 'm256')},
 'vcmpnle_uqps': {('k', 'xmm', 'm128'),
                  ('k', 'ymm', 'm256)'),
                  ('k', 'zmm', 'm512'),
                  ('xmm', 'xmm', 'm128'),
                  ('ymm', 'ymm', 'm256')},
 'vcmpord_sps': {('k', 'xmm', 'm128'),
                 ('k', 'ymm', 'm256)'),
                 ('k', 'zmm', 'm512'),
                 ('xmm', 'xmm', 'm128'),
                 ('ymm', 'ymm', 'm256')},
 'vcmpeq_usps': {('k', 'xmm', 'm128'),
                 ('k', 'ymm', 'm256)'),
                 ('k', 'zmm', 'm512'),
                 ('xmm', 'xmm', 'm128'),
                 ('ymm', 'ymm', 'm256')},
 'vcmpnge_uqps': {('k', 'xmm', 'm128'),
                  ('k', 'ymm', 'm256)'),
                  ('k', 'zmm', 'm512'),
                  ('xmm', 'xmm', 'm128'),
                  ('ymm', 'ymm', 'm256')},
 'vcmpngt_uqps': {('k', 'xmm', 'm128'),
                  ('k', 'ymm', 'm256)'),
                  ('k', 'zmm', 'm512'),
                  ('xmm', 'xmm', 'm128'),
                  ('ymm', 'ymm', 'm256')},
 'vcmpfalse_osps': {('k', 'xmm', 'm128'),
                    ('k', 'ymm', 'm256)'),
                    ('k', 'zmm', 'm512'),
                    ('xmm', 'xmm', 'm128'),
                    ('ymm', 'ymm', 'm256')},
 'vcmpneq_osps': {('k', 'xmm', 'm128'),
                  ('k', 'ymm', 'm256)'),
                  ('k', 'zmm', 'm512'),
                  ('xmm', 'xmm', 'm128'),
                  ('ymm', 'ymm', 'm256')},
 'vcmpge_oqps': {('k', 'xmm', 'm128'),
                 ('k', 'ymm', 'm256)'),
                 ('k', 'zmm', 'm512'),
                 ('xmm', 'xmm', 'm128'),
                 ('ymm', 'ymm', 'm256')},
 'vcmpgt_oqps': {('k', 'xmm', 'm128'),
                 ('k', 'ymm', 'm256)'),
                 ('k', 'zmm', 'm512'),
                 ('xmm', 'xmm', 'm128'),
                 ('ymm', 'ymm', 'm256')},
 'vcmptrue_usps': {('k', 'xmm', 'm128'),
                   ('k', 'ymm', 'm256)'),
                   ('k', 'zmm', 'm512'),
                   ('xmm', 'xmm', 'm128'),
                   ('ymm', 'ymm', 'm256')},
 'vpclmulhqhqdq': {('xmm', 'xmm', 'm128'),
                   ('ymm', 'ymm', 'm256'),
                   ('zmm', 'zmm', 'm512')},
 'vpclmulhqlqdq': {('xmm', 'xmm', 'm128'),
                   ('ymm', 'ymm', 'm256'),
                   ('zmm', 'zmm', 'm512')},
 'vpclmullqhqdq': {('xmm', 'xmm', 'm128'),
                   ('ymm', 'ymm', 'm256'),
                   ('zmm', 'zmm', 'm512')},
 'vpclmullqlqdq': {('xmm', 'xmm', 'm128'),
                   ('ymm', 'ymm', 'm256'),
                   ('zmm', 'zmm', 'm512')}}
