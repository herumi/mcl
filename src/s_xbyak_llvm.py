# s_xbyak_llvm : LLVM-IR generation tool with Xbyak-like syntax in Python
# This file provides a Xbyak-like DSL to generate a asm code for LLVM-IR.
# Author : MITSUNARI Shigeo(@herumi)
# License : modified new BSD license (http://opensource.org/licenses/BSD-3-Clause)

VERSION="0.9.4"

VOID_TYPE = 0
INT_TYPE = 1
IMM_TYPE = 2
INT_PTR_TYPE = 3
VAR_TYPE = 4
STR_VAR_TYPE = 5

eq = 'eq'
neq = 'neq'
ugt = 'ugt'
uge = 'uge'
ult = 'ult'
ule = 'ule'
sgt = 'sgt'
sge = 'sge'
slt = 'slt'
sle = 'sle'

g_showPrototype = False
g_text = []
g_undefLabel = {}
g_defLabelN = 1
g_undefLabelN = 1
g_globalIdx = 0
g_labelIdx = 0
g_phiIdx = 0

def output(s):
  g_text.append(s)

def appendOutput(line, s):
  g_text[line] += s

def getLine():
  return len(g_text)

def getDefLabel(n):
  return f'L{n}'

def getUndefLabel(n):
  return f'L{n}_undef'

def init():
  global g_text
  g_text = []

def showPrototype():
  global g_showPrototype
  g_showPrototype = True

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

class Function:
  def __init__(self, name, ret, *args, private=False, noalias=True):
    self.name = name
    self.ret = ret
    self.args = args
    self.private = private
    self.noalias = noalias
    if g_showPrototype and not private:
      s = f'{ret.getCtype()} {name}('
      for i in range(len(args)):
        if i > 0:
          s += ', '
        s += args[i].getCtype(addConst=i > 0)
      s += ');'
      print(s)
      return

    s = 'define '
    if private:
      s += 'private '
    s += f'{ret.getType()} @{name}('
    for i in range(len(args)):
      if i > 0:
        s += ', '
      s += args[i].getFullName(noalias, isArg=True)
    s += ')'
    output(s)
    output('{')

  def getName(self):
    return f'{self.ret.getType()} @{self.name}'

  def close(self):
    output('}')

  def __enter__(self):
    return self

  def __exit__(self, ex_type, ex_value, trace):
    self.close()

def genFunc(name):
  def f(*args):
    if not args:
      return output(name)
    s = ''
    for arg in args:
      if s != '':
        s += ', '
      if g_gas:
        if type(arg) == int:
          s += str(arg)
        else:
          s += str(arg)
      else:
        s += str(arg)
    return output(name + ' ' + s)
  return f

def getGlobalIdx():
  global g_globalIdx
  g_globalIdx += 1
  return g_globalIdx

def resetGlobalIdx():
  global g_globalIdx
  g_globalIdx = 0

class Operand:
  def __init__(self, t, bit, imm=0, name=None):
    self.t = t
    self.bit = bit
    self.imm = imm
    self.name = name
    self.const = False
    if t in [INT_TYPE, INT_PTR_TYPE]:
      self.idx = getGlobalIdx()
    if t == STR_VAR_TYPE:
      self.bit = len(self.imm) + 1

  def getFullName(self, noalias=False, isArg=False):
    return f'{self.getType(noalias, isArg)} {self.getName()}'.strip()

  # noalias/readonly are parameter attributes, so they are emitted only when
  # the operand is rendered as a function argument (isArg=True). LLVM-IR has no
  # readonly return-value attribute, so a const pointer return type drops it.
  def getType(self, noalias=False, isArg=False):
    if self.t == INT_TYPE or self.t == IMM_TYPE:
      return f'i{self.bit}'
    if self.t == INT_PTR_TYPE:
      s = f'i{self.bit}*'
      if noalias:
        s += ' noalias'
      if isArg and self.const:
        s += ' readonly'
      return s
    if self.t == VOID_TYPE:
      return 'void'
    if self.t == VAR_TYPE:
      if type(self.imm) == int:
        return f'i{self.bit}'
      else:
        return f'[{len(self.imm)} x i{self.bit}]'
    if self.t == STR_VAR_TYPE:
        return f'[{self.bit} x i8]'
    raise Exception('no type')

  # get prototype declaration
  def getCtype(self, addConst=False):
    if self.t == INT_TYPE:
      return f'uint{self.bit}_t'
    if self.t == INT_PTR_TYPE:
      s = ''
      if addConst or self.const:
        s += 'const '
      s += f'uint{self.bit}_t*'
      return s
    if self.t == VOID_TYPE:
      return 'void'
    raise Exception('no C type')

  def getName(self):
    if self.t == INT_TYPE or self.t == INT_PTR_TYPE:
      return f'%r{self.idx}'
    if self.t == IMM_TYPE:
      return str(self.imm)
    if self.t == VAR_TYPE:
      return f'*@{self.name}'
    if self.t == STR_VAR_TYPE:
      return f'*@{self.name}'
    return ''

  def getVarStr(self):
    if self.t == STR_VAR_TYPE:
      return f'c"{self.imm}\\00"'
    if self.t != VAR_TYPE:
      raise Exception('bad type', self.t)
    if type(self.imm) == int:
      return str(self.imm)
    s = '['
    for i in range(len(self.imm)):
      if i > 0:
        s += ', '
      s += f'i{self.bit} {self.imm[i]}'
    s += ']'
    return s

  # phi
  def link(self, v, label):
    assert self.line != None
    appendOutput(self.line, f', [{v.getName()}, %{label}]')

class Int(Operand):
  def __init__(self, bit):
    self = Operand.__init__(self, INT_TYPE, bit)

class IntPtr(Operand):
  def __init__(self, bit, const=False):
    Operand.__init__(self, INT_PTR_TYPE, bit)
    self.const = const

def getBitSize(v):
  bit = int(v).bit_length()
  bit = ((bit + 31) // 32) * 32
  if bit == 0:
    bit = 32
  return bit

class Imm(Operand):
  def __init__(self, imm, bit=0):
    if bit == 0:
      bit = getBitSize(imm)
    self = Operand.__init__(self, IMM_TYPE, bit, imm)

class Var(Operand):
  """
    bit : 32 or 64
    imm : a value or an array of values
  """
  def __init__(self, name, bit, imm):
    self = Operand.__init__(self, VAR_TYPE, bit, imm, name=name)

class StrVar(Operand):
  def __init__(self, name, v):
    self = Operand.__init__(self, STR_VAR_TYPE, 0, v, name=name)


Void = Operand(VOID_TYPE, 0)

def term():
  if g_showPrototype:
    return
  n = len(g_text)
  i = 0
  while i < n:
    s = g_text[i]
    print(s)
    i += 1

# r = op x, v

def genOp_r_x_v(name):
  def f(x, v):
    if type(v) == int:
      v = Imm(v)
    r = Int(x.bit)
    output(f'{r.getName()} = {name} {x.getFullName()}, {v.getName()}')
    return r
  return f

tbl = ['lshr', 'ashr', 'shl', 'add', 'sub', 'mul', 'and_', 'or_']
for name in tbl:
  llvmName = name.strip('_')
  globals()[name] = genOp_r_x_v(llvmName)

def select(cond, x, y):
  r = Int(x.bit)
  output(f'{r.getName()} = select {cond.getFullName()}, {x.getFullName()}, {y.getFullName()}')
  return r

# r = op x to y
def zext(x, bit):
  r = Int(bit)
  output(f'{r.getName()} = zext {x.getFullName()} to {r.getType()}')
  return r

def trunc(x, bit):
  r = Int(bit)
  output(f'{r.getName()} = trunc {x.getFullName()} to {r.getType()}')
  return r

def bitcast(x, bit):
  r = IntPtr(bit)
  output(f'{r.getName()} = bitcast {x.getFullName()} to {r.getType()}')
  return r

# r = alloca i{bit}, i32 n ; returns i{bit}* pointer to n elements
def alloca_(bit, n):
  r = IntPtr(bit)
  output(f'{r.getName()} = alloca i{bit}, i32 {n}')
  return r

# op x
def ret(x):
  output(f'ret {x.getFullName()}')

# op x, v
def store(x, v):
  output(f'store {x.getFullName()}, {v.getFullName()}')

# r = op x
# volatile forces a standalone load (not folded into an ALU memory operand),
# which avoids the slower store-to-load forwarding of a folded load on x64.
def load(x, volatile=False):
  r = Int(x.bit)
  v = 'volatile ' if volatile else ''
  output(f'{r.getName()} = load {v}{r.getType()}, {x.getFullName()}')
  return r

def getelementptr(x, v):
  if type(v) == int:
    v = Imm(v)
  r = IntPtr(x.bit)
  if type(x) == Var:
    output(f'{r.getName()} = getelementptr inbounds {x.getType()}, {x.getFullName()}, i32 0, {v.getFullName()}')
  else:
    output(f'{r.getName()} = getelementptr i{x.bit}, {x.getFullName()}, {v.getFullName()}')
  return r

def call(func, *args):
  s = ''
  if func.ret.t != VOID_TYPE:
    r = Operand(func.ret.t, func.ret.bit)
    s = f'{r.getName()} = '
  s += f'call {func.getName()}('
  for i in range(len(args)):
    if i > 0:
      s += ', '
    s += args[i].getFullName()
  s += ')'
  output(s)
  if func.ret.t != VOID_TYPE:
    return r

def br(p1, p2=None, p3=None):
  if p2 is None:
    output(f'br label %{p1}')
    return
  output(f'br i1 {p1.getName()}, label %{p2}, label %{p3}')

# args is (v, label)[, (v2, label2), ...]
def phi(*args):
  assert type(args) is tuple
  if isinstance(args[0], Operand) and type(args[1]) == Label:
    ls = ((args[0], args[1]),)
  elif isinstance(args[0][0], Operand) and type(args[0][1]) == Label:
    ls = args
  else:
    raise Exception('phi : bad args')
  v = ls[0][0]
  t = v.t
  if t == IMM_TYPE:
    t = INT_TYPE
  r = Operand(t, v.bit)
  r.line = getLine()
  s = f'{r.getName()} = phi {r.getType()}'
  for i in range(len(ls)):
    if i > 0:
      s += ', '
    (v, label) = ls[i]
    s += f'[{v.getName()}, %{label}]'
  output(s)
  return r

def icmp(cond, v1, v2):
  v = Int(1)
  if isinstance(v2, int):
    v2 = Imm(v2, v.bit)
  output(f'{v.getName()} = icmp {cond} i{v1.bit} {v1.getName()}, {v2.getName()}')
  return v


"""
uint{bit}_t name = v; v is imm or array of imm
static variable if static=True
const variable if const=True
"""
def makeVar(name, bit, v, static=False, const=False):
  r = Var(name, bit, v)
  if static:
    attr = 'internal unnamed_addr'
  else:
    attr = 'dso_local local_unnamed_addr'
  if const:
    attr += ' constant'
  else:
    attr += ' global'
  output(f'@{name} = {attr} {r.getType()} {r.getVarStr()}')
  return r

def makeStrVar(name, v):
  r = StrVar(name, v)
  attr = 'private unnamed_addr constant'
  output(f'@{name} = {attr} {r.getType()} {r.getVarStr()}')
  return r
####

def loadN(p, n, offset=0, volatile=False):
  if offset != 0:
    p = getelementptr(p, offset)
  if n > 1:
    p = bitcast(p, p.bit * n)
  return load(p, volatile)

def storeN(r, p, offset=0):
  if offset != 0:
    p = getelementptr(p, offset)
  if r.bit > p.bit:
    p = bitcast(p, r.bit)
  store(r, p)

# return [xs[n-1]:...:xs[0]]
def pack(xs):
  x = xs[0]
  for y in xs[1:]:
    shift = x.bit
    size = x.bit + y.bit
    x = zext(x, size)
    y = zext(y, size)
    y = shl(y, shift)
    x = or_(x, y)
  return x
