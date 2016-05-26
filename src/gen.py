import sys, re

# @for <var>, <begin>, <end>
RE_FOR = re.compile(r'@for\s+(\w+)\s*,\s*([^,]+)\s*,\s*([^,]+)')
# $(<exp>)
RE_VAL = re.compile(r'\$\(([^)]+)\)')
# @define <var>=<exp>
RE_DEFINE = re.compile(r'@define\s+(\w+)\s*=(.*)')
# @if <exp>
RE_IF = re.compile(r'@if\s+(.*)')
# @elif <exp>
RE_ELIF = re.compile(r'@elif\s+(.*)')

def evalStr(s, envG, envL={}):
	def eval2str(x):
		s = x.group(1)
		v = eval(s, envG, envL)
		return str(v)
	s = RE_VAL.sub(eval2str, s)
	return s

def parseDefine(s, envG, envL):
	"""
	if s is @define statement, then update envL and return True
	otherwise return False
	"""
	p = RE_DEFINE.match(s)
	if not p:
		return False
	lhs = p.group(1).strip()
	rhs = p.group(2).strip()
	envL[lhs] = eval(rhs, envG, envL)
	return True

def parseFor(s, envG):
	"""
	@for i, 0, 3
	<exp>
	@endif

	|
	v
	@define i = 0
	<exp>
	@define i = 1
	<exp>
	@define i = 2
	<exp>

	"""
	out = ""
	inFor = False
	envL = {}
	for line in s.split('\n'):
		stripped = line.strip()
		# save @define for parseIf
		parseDefine(stripped, envG, envL)
		if inFor:
			if line.strip() == '@endfor':
				inFor = False
				for i in xrange(b, e):
					out += "@define %s = %d\n" % (v, i)
					out += sub
			else:
				sub += line + '\n'
		else:
			p = RE_FOR.search(stripped)
			if p:
				v = p.group(1).strip()
				b = eval(p.group(2), envG, envL)
				e = eval(p.group(3), envG, envL)
				sub = ""
				inFor = True
			else:
				out += line + '\n'
	return out

def parseIf(s, envG):
	out = ""
	IF_INIT = 0
	IF_IF = 1
	IF_ELSE = 2
	ifState = IF_INIT
	ifVar = False
	# available variables in @(<expr>)
	envL = {}
	def evalIntLoc(s):
		return eval(s, envG, envL)
	for line in s.split('\n'):
		stripped = line.strip()
		# remove @define
		if parseDefine(stripped, envG, envL):
			continue
		if ifState == IF_INIT:
			p = RE_IF.match(stripped)
			if p:
				ifState = IF_IF
				ifVar = evalIntLoc(p.group(1))
				continue
		elif ifState == IF_IF:
			if stripped == '@endif':
				ifState = IF_INIT
				continue
			elif stripped == '@else':
				ifState = IF_ELSE
				ifVar = not ifVar
				continue
			p = RE_ELIF.match(stripped)
			if p:
				ifVar = evalIntLoc(p.group(1))
				continue
			if not ifVar:
				continue
		elif ifState == IF_ELSE:
			if stripped == '@endif':
				ifState = IF_INIT
				continue
			if not ifVar:
				continue
		else:
			raise Exception('bad state', ifState)
		out += evalStr(line, envG, envL) + '\n'
	return out

def parse(s, unitL, bitL):
	"""
		eval "@(<expr>)" to integer

		@for <var>, <begin>, <end>
		...
		@endfor

		REMARK : @for is not nestable

		@define <var> = <exp>
		REMARK : var is global

		@if <exp>
		@elif <exp>
		@endif

		REMARK : @if is not nestable
	"""
	# available variables in @(<expr>)
	envG = {
		'unit' : unitL,
		'bit' : bitL,
		'N' : bitL / unitL,
	}
	s = parseFor(s, envG)
	s = parseIf(s, envG)
	return s

def gen(fo, inLame, unitL, bitLL):
	fi = open(inLame, 'r')
	s = fi.read()
	fi.close()
	for bitL in bitLL:
		t = parse(s, unitL, bitL)
		fo.write(t)

def main():
	argv = sys.argv
	args = len(argv)
	unitL = 64
	if args < 3:
		print "gen.py inFile [32, 64]"
		return 1
	inFile = argv[1]
	if args == 3:
		unitL = int(argv[2])
	if unitL not in [32, 64]:
		print "bad unitL", unitL
		exit(1)

	outLame = 'base%d.ll' % unitL
	fo = open(outLame, 'w')
	fi = open(inFile, 'r')
	a = fi.read()
	fi.close()
	fo.write(a)

	bitLL = range(unitL, 576 + 1, unitL)
	gen(fo, 'mul.txt', unitL, bitLL[1:])
	fo.close()

if __name__ == "__main__":
    main()
