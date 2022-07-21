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

g_gas = False # gas syntax if True else nasm syntax
g_masm = False # masm syntax
g_text = []
g_undefLabel = {}
g_defLabelN = 1
g_undefLabelN = 1

def getLine():
	return len(g_text)

class Reg:
	def __init__(self, idx, bit):
		self.idx = idx
		self.bit = bit
	def __str__(self):
		if self.bit == 64:
			tbl = ['rax', 'rcx', 'rdx', 'rbx', 'rsp', 'rbp', 'rsi', 'rdi', 'r8', 'r9', 'r10',  'r11', 'r12', 'r13', 'r14', 'r15']
		elif self.bit == 32:
			tbl = ['eax', 'ecx', 'edx', 'ebx', 'esp', 'ebp', 'esi', 'edi', 'r8d', 'r9d', 'r10d',  'r11d', 'r12d', 'r13d', 'r14d', 'r15d']
		elif self.bit == 8:
			tbl = ['al', 'cl', 'dl', 'bl', 'ah', 'ch', 'dh', 'bh', 'r8b', 'r9b', 'r10b',  'r11b', 'r12b', 'r13b', 'r14b', 'r15b']
		else:
			raise Exception('bad bit', self.bit)
		if g_gas:
			return '%' + tbl[self.idx]
		return tbl[self.idx]
	def __mul__(self, scale):
		if type(scale) == int:
			if scale not in [1, 2, 4, 8]:
				raise Exception('bad scale', scale)
			return RegExp(None, self, scale)
		raise Exception('bad scale type', scale)
	def __add__(self, rhs):
		if type(rhs) == Reg:
			return RegExp(self, rhs)
		if type(rhs) == int:
			return RegExp(self, None, 1, rhs)
		if type(rhs) == RegExp:
			return RegExp(self, rhs.index, rhs.scale, rhs.offset)
		raise Exception('bad add type', rhs)
	def __sub__(self, rhs):
		if type(rhs) == int:
			return RegExp(self, None, 1, -rhs)
		raise Exception('bad sub type', rhs)

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
	def __init__(self, exp=None, bit=0):
		self.exp = exp
		self.bit = bit
		self.ripLabel = None
	def setRip(self, label):
		self.ripLabel = label
	def __str__(self):
		if self.ripLabel:
			if g_gas:
				return f'{self.ripLabel}(%rip)'
			if g_masm:
				return f'offset {self.ripLabel}'
			return f'[rel {self.ripLabel}]'
		if g_gas:
			if type(self.exp) == Reg:
				return '(' + str(self.exp) + ')'
			return str(self.exp)
		return '[' + str(self.exp) + ']'

def ptr(exp):
	return Address(exp)

def rip(label):
	addr = Address()
	addr.setRip(label)
	return addr

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

class StackFrame:
	def __init__(self, pNum, tNum = 0, useRDX=False, useRCX=False, stackSizeByte=0):
		self.pos = 0
		self.useRDX = useRDX
		self.useRCX = useRCX
		self.p = []
		self.t = []
		allRegNum = pNum + tNum + (1 if useRDX else 0) + (1 if useRCX else 0)
		noSaveNum = getNoSaveNum()
		self.saveNum = max(0, allRegNum - noSaveNum)
		tbl = getRegTbl()[noSaveNum:]
		for i in range(self.saveNum):
			push(tbl[i])
		self.P = (stackSizeByte + 7) // 8
		# 16 byte alignment
		if self.P > 0 and (self.P & 1) == (self.saveNum & 1):
			self.P += 1
		self.P *= 8
		if self.P > 0:
			sub(rsp, self.P)
		for i in range(pNum):
			self.p.append(self.getRegIdx())
		for i in range(tNum):
			self.t.append(self.getRegIdx())
		if self.useRCX and getRcxPos() < pNum:
			mov(r10, rcx)
		if self.useRDX and getRdxPos() < pNum:
			mov(r11, rdx)
	def close(self, callRet = True):
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
		self.close()

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

def init(mode):
	global g_gas, g_masm, g_text
	g_gas = mode == 'gas'
	g_masm = mode == 'masm'
	g_text = []
	if g_gas:
		output('# for gas')
	elif g_masm:
		output('; for masm (ml64.exe)')
	else:
		output('; for nasm')

def output(s):
	g_text.append(s)

def segment(mode):
	if g_gas:
		output(f'.{mode}')
	elif g_masm:
		output(f'_{mode} segment')
	else:
		output(f'segment .{mode}')

def db_(s):
	if g_gas:
		output(f'.byte ${s}')
	else:
		output(f'db {s}')
def dd_(s):
	if g_gas:
		output(f'.long ${s}')
	else:
		output(f'dd {s}')
def dq_(s):
	if g_gas:
		output(f'.quad {s}')
	else:
		output(f'dq {s}')
def global_(s):
	if g_gas:
		output(f'.global {s}')
		output(f'.global _{s}')
	elif g_masm:
		output(f'public {s}')
	else:
		output(f'global {s}')
		output(f'global _{s}')
def makeLabel(s):
	output(f'{s}:')
	if g_masm:
		return
	output(f'_{s}:')
def align(n):
	if g_gas:
		output(f'.align {n}')
	else:
		output(f'align {n}')

def getDefLabel(n):
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

def termOutput():
	if g_masm:
		output('_text ends')
		output('end')

	n = len(g_text)
	i = 0
	while i < n:
		s = g_text[i]
		# QQQ (bad knowhow) remove unnecessary pattern
		if g_gas and s == 'mov %rdx, %r11' and g_text[i+1] == 'mov %r11, %rdx':
			i += 2
		elif not g_gas and s == 'mov r11, rdx' and g_text[i+1] == 'mov rdx, r11':
			i += 2
		else:
			print(s)
			i += 1

def defineName(name):
	global_(name)
	makeLabel(name)

class FuncProc:
	def __init__(self, name):
		if g_masm:
			self.name = name
			output(f'{self.name} proc')
		else:
			defineName(name)
	def close(self):
		if g_masm:
			output(f'{self.name} endp')
	def __enter__(self):
		return self
	def __exit__(self, ex_type, ex_value, trace):
		self.close()

def genFunc(name):
	def f(*args):
		# special case (mov label, reg)
		if g_gas and name == 'mov' and type(args[1]) == str:
			output(f'movabs ${args[1]}, {args[0]}')
			return
		if not args:
			return output(name)
		s = ''
		param = reversed(args) if g_gas else args
		for arg in param:
			if s != '':
				s += ', '
			if g_gas:
				if type(arg) == int:
					s += '$' + str(arg)
				else:
					s += str(arg)
			else:
				s += str(arg)
		return output(name + ' ' + s)
	return f

def genAllFunc():
	tbl = [
		'ret',
		'inc', 'dec', 'setc', 'push', 'pop',
		'mov', 'add', 'adc', 'sub', 'sbb', 'adox', 'adcx', 'mul', 'xor_', 'and_', 'movzx', 'lea',
		'mulx', 'div',
		'cmp', 'test', 'or_',
		'cmova', 'cmovae', 'cmovb', 'cmovbe', 'cmovc', 'cmove', 'cmovg', 'cmovge', 'cmovl', 'cmovle',
		'cmovna', 'cmovnae', 'cmovnb', 'cmovnbe', 'cmovnc', 'cmovne', 'cmovng', 'cmovnge',
		'cmovnl', 'cmovnle', 'cmovno', 'cmovnp', 'cmovns', 'cmovnz', 'cmovo', 'cmovp', 'cmovpe',
		'cmovpo', 'cmovs', 'cmovz',
		'ja','jae','jb','jbe','jc','je','jg','jge','jl','jle','jna','jnae','jnb','jnbe','jnc','jne','jng',
		'jnge','jnl','jnle','jno','jnp','jns','jnz','jo','jp','jpe','jpo','js','jz',
		'jmp',
	]
	for name in tbl:
		asmName = name.strip('_')
		globals()[name] = genFunc(asmName)

genAllFunc()
