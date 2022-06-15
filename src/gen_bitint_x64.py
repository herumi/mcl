from gen_x86asm import *
import argparse

SUF='_fast'

def gen_add(N):
	proc(f'mclb_add{N}')
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
	proc(f'mclb_sub{N}')
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

def gen_mulUnit(N):
	proc(f'mclb_mulUnit_fast{N}')
	proc(f'mclb_mulUnit_slow{N}')
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
			mov(rax, ptr(x));
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
		with StackFrame(3, 2, useRDX=True) as sf:
			z = sf.p[0]
			x = sf.p[1]
			y = sf.p[2]
			t0 = sf.t[0]
			t1 = sf.t[1]
			mov(rdx, y);
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

# [ret:z[N]] = z[N] + x[N] * y
def gen_mulUnitAdd(N):
	proc(f'mclb_mulUnitAdd_fast{N}')
	proc(f'mclb_mulUnitAdd_slow{N}')
	if N == 0:
		xor_(eax, eax)
		ret()
		return
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


parser = argparse.ArgumentParser()
parser.add_argument("-win", "--win", help="output win64 abi", action="store_true")
parser.add_argument("-n", "--num", help="max size of Unit", type=int, default=9)
param = parser.parse_args()

setWin64ABI(param.win)
N = param.num

initOutput()
output('segment .data')
for i in range(N):
	output(f'global mclb_mulUnit{i}')
	output(f'global _mclb_mulUnit{i}')
	output(f'mclb_mulUnit{i}:')
	output(f'_mclb_mulUnit{i}:')
	output(f'dq mclb_mulUnit_slow{i}')
for i in range(N):
	output(f'global mclb_mulUnitAdd{i}')
	output(f'global _mclb_mulUnitAdd{i}')
	output(f'mclb_mulUnitAdd{i}:')
	output(f'_mclb_mulUnitAdd{i}:')
	output(f'dq mclb_mulUnitAdd_slow{i}')
output('segment .text')

for i in range(N):
	gen_add(i)

for i in range(N):
	gen_sub(i)

for i in range(N):
	gen_mulUnit(i)

for i in range(N):
	gen_mulUnitAdd(i)

termOutput()
