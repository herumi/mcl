from gen_x86asm import *
import argparse

SUF='_fast'

def gen_add(N):
	align(16)
	defineName(f'mclb_add{N}')
	if N == 0:
		xor_(eax, eax)
		ret()
		return
	with StackFrame(3) as sf:
		z = sf.p[0]
		x = sf.p[1]
		y = sf.p[2]
		for i in range(N):
			mov(rax, ptr(x + 8 * i))
			if i == 0:
				add(rax, ptr(y + 8 * i))
			else:
				adc(rax, ptr(y + 8 * i))
			mov(ptr(z + 8 * i), rax)
		setc(al)
		movzx(eax, al)

def gen_sub(N):
	align(16)
	defineName(f'mclb_sub{N}')
	if N == 0:
		xor_(eax, eax)
		ret()
		return
	with StackFrame(3) as sf:
		z = sf.p[0]
		x = sf.p[1]
		y = sf.p[2]
		for i in range(N):
			mov(rax, ptr(x + 8 * i))
			if i == 0:
				sub(rax, ptr(y + 8 * i))
			else:
				sbb(rax, ptr(y + 8 * i))
			mov(ptr(z + 8 * i), rax)
		setc(al)
		movzx(eax, al)

def gen_mulUnit(N, mode='fast'):
	align(16)
	defineName(f'mclb_mulUnit_{mode}{N}')
	if N == 0:
		xor_(eax, eax)
		ret()
		return
	if N == 1:
		with StackFrame(3) as sf:
			z = sf.p[0]
			x = sf.p[1]
			y = sf.p[2]
			mov(rax, ptr(x))
			mul(y) # [rdx:rax] = x * y
			mov(ptr(z), rax)
			mov(rax, rdx)
			return
	elif N == 2:
		with StackFrame(3, 1, useRDX=True) as sf:
			z = sf.p[0]
			x = sf.p[1]
			y = sf.p[2]
			t = sf.t[0]
			mov(rax, ptr(x))
			mul(y) # [rdx:rax] = x[0] * y
			mov(ptr(z), rax)
			mov(t, rdx)
			mov(rax, ptr(x + 8))
			mul(y) # [rdx:rax] = x[1] * y
			add(rax, t)
			adc(rdx, 0)
			mov(ptr(z + 8), rax)
			mov(rax, rdx)
			return
	else:
		if mode == 'fast':
			with StackFrame(3, 2, useRDX=True) as sf:
				z = sf.p[0]
				x = sf.p[1]
				y = sf.p[2]
				t0 = sf.t[0]
				t1 = sf.t[1]
				mov(rdx, y)
				mulx(t1, rax, ptr(x)) # [y:rax] = x * y
				mov(ptr(z), rax)
				for i in range(1, N-1):
					mulx(t0, rax, ptr(x + i * 8))
					if i == 1:
						add(rax, t1)
					else:
						adc(rax, t1)
					mov(ptr(z + i * 8), rax)
					t0, t1 = t1, t0
				mulx(rax, rdx, ptr(x + (N - 1) * 8))
				adc(rdx, t1)
				mov(ptr(z + (N - 1) * 8), rdx)
				adc(rax, 0)
		else:
			with StackFrame(3, 0, useRDX=True, stackSizeByte=(N - 1) * 2 * 8) as sf:
				z = sf.p[0]
				x = sf.p[1]
				y = sf.p[2]
				posH = (N - 1) * 8
				for i in range(N):
					mov(rax, ptr(x + i * 8))
					mul(y)
					if i == 0: # bypass
						mov(ptr(z), rax)
					else:
						mov(ptr(rsp + (i - 1) * 8), rax)
					if i < N-1:
						mov(ptr(rsp + posH + i * 8), rdx) # don't write the last rdx
				for i in range(N - 1):
					mov(rax, ptr(rsp + posH + i * 8))
					if i == 0:
						add(rax, ptr(rsp + i * 8))
					else:
						adc(rax, ptr(rsp + i * 8))
					mov(ptr(z + (i + 1) * 8), rax)
				adc(rdx, 0)
				mov(rax, rdx)

# [ret:z[N]] = z[N] + x[N] * y
def gen_mulUnitAdd(N, mode='fast'):
	align(16)
	defineName(f'mclb_mulUnitAdd_{mode}{N}')
	if N == 0:
		xor_(eax, eax)
		ret()
		return
	if mode == 'fast':
		with StackFrame(3, 2, useRDX=True) as sf:
			z = sf.p[0]
			x = sf.p[1]
			y = sf.p[2]
			t = sf.t[0]
			L = sf.t[1]
			mov(rdx, y)
			xor_(eax, eax)
			mov(t, ptr(z))
			for i in range(N):
				mulx(rax, L, ptr(x + i * 8))
				adox(t, L)
				mov(ptr(z + i * 8), t)
				if i == N-1:
					break
				mov(t, ptr(z + (i+1) * 8))
				adcx(t, rax)
			mov(t, 0)
			adcx(rax, t)
			adox(rax, t)
	else:
			with StackFrame(3, 0, useRDX=True, stackSizeByte=(N * 2 - 1) * 8) as sf:
				z = sf.p[0]
				x = sf.p[1]
				y = sf.p[2]
				posH = N * 8
				for i in range(N):
					mov(rax, ptr(x + i * 8))
					mul(y)
					mov(ptr(rsp + i * 8), rax)
					if i < N-1:
						mov(ptr(rsp + posH + i * 8), rdx) # don't write the last rdx
				for i in range(N - 1):
					mov(rax, ptr(rsp + (i + 1) * 8))
					if i == 0:
						add(rax, ptr(rsp + posH + i * 8))
					else:
						adc(rax, ptr(rsp + posH + i * 8))
					mov(ptr(rsp + (i + 1) * 8), rax)
				if N > 1:
					adc(rdx, 0)
				for i in range(N):
					mov(rax, ptr(rsp + i * 8))
					if i == 0:
						add(ptr(z + i * 8), rax)
					else:
						adc(ptr(z + i * 8), rax)
				adc(rdx, 0)
				mov(rax, rdx)

def gen_enable_fast(N):
	align(16)
	defineName('mclb_disable_fast')
	for i in range(1, N):
		mov(rdx, f'mclb_mulUnit{i}')
		mov(rax, f'mclb_mulUnit_slow{i}')
		mov(ptr(rdx), rax)
	for i in range(1, N):
		mov(rdx, f'mclb_mulUnitAdd{i}')
		mov(rax, f'mclb_mulUnitAdd_slow{i}')
		mov(ptr(rdx), rax)
	ret()

def gen_get_func_ptr(funcName, N):
	align(16)
	defineName(f'mclb_get_{funcName}')
	with StackFrame(1) as sf:
		n = sf.p[0]
		xor_(eax, eax)
		cmp_(n, N)
		cmovae(n, rax)
		mov(rax, f'mclb_{funcName}0')
		mov(rax, ptr(rax + n * 8))

parser = argparse.ArgumentParser()
parser.add_argument("-win", "--win", help="output win64 abi", action="store_true")
parser.add_argument("-n", "--num", help="max size of Unit", type=int, default=9)
parser.add_argument("-addn", "--addn", help="max size of add/sub", type=int, default=16)
parser.add_argument("-gas", "--gas", help="output gas syntax", default=False, action="store_true")
param = parser.parse_args()

setWin64ABI(param.win)
N = param.num
addN = param.addn

initOutput(param.gas)
segment('data')
for i in range(N+1):
	defineName(f'mclb_mulUnit{i}')
	if i == 0:
		data_dq(0)
	else:
		data_dq(f'mclb_mulUnit_fast{i}')
for i in range(N+1):
	defineName(f'mclb_mulUnitAdd{i}')
	if i == 0:
		data_dq(0)
	else:
		data_dq(f'mclb_mulUnitAdd_fast{i}')
segment('text')

for i in range(addN+1):
	gen_add(i)

for i in range(addN+1):
	gen_sub(i)

for i in range(N+1):
	gen_mulUnit(i, 'fast')

for i in range(N+1):
	gen_mulUnitAdd(i, 'fast')

for i in range(N+1):
	gen_mulUnit(i, 'slow')

for i in range(N+1):
	gen_mulUnitAdd(i, 'slow')

gen_enable_fast(N)
gen_get_func_ptr('mulUnit', N)

termOutput()
