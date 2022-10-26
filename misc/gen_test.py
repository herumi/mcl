import sys
sys.path.append('../src/')

from s_xbyak import *
from gen_bint_x64 import *
import argparse

# t[] = [px] + [py]
def add_pmm(t, px, py):
  for i in range(len(t)):
    mov(t[i], ptr(px + 8 * i))
    if i == 0:
      add(t[i], ptr(py + 8 * i))
    else:
      adc(t[i], ptr(py + 8 * i))

def gen_fp_add(N):
  align(16)
  with FuncProc(f'mclb_fp_add{N}'):
    with StackFrame(4, N*2-2) as sf:
      pz = sf.p[0]
      px = sf.p[1]
      py = sf.p[2]
      pp = sf.p[3]
      X = sf.t[0:N]
      T = sf.t[N:]
      xor_(eax, eax)   # CF = 0
      load_pm(X, px)   # X = px[]
      add_pm(X, py)    # X = px[] + py[]
      setc(al)         # set CF
      T.append(px)
      T.append(py)
      mov_pp(T, X)     # T = X
      sub_pm(T, pp)    # T -= pp[]
      sbb(eax, 0)      # check CF
      cmovc_pp(T, X)   # T = X if T < 0
      store_mp(pz, T)

def gen_fp_addNF(N):
  align(16)
  with FuncProc(f'mclb_fp_addNF{N}'):
    with StackFrame(4, N*2-3) as sf:
      pz = sf.p[0]
      px = sf.p[1]
      py = sf.p[2]
      pp = sf.p[3]
      X = sf.t[0:N]
      T = sf.t[N:]
      load_pm(X, px)   # X = px[]
      add_pm(X, py)    # X = px[] + py[]
      T.append(px)
      T.append(py)
      T.append(rax)
      mov_pp(T, X)     # T = X
      sub_pm(T, pp)    # T -= pp[]
      cmovc_pp(T, X)   # T = X if T < 0
      store_mp(pz, T)

# This is almost the same speed as fp_sub, but it requires more registers.
def gen_fp_subB(N):
  align(16)
  with FuncProc(f'mclb_fp_subB{N}'):
    with StackFrame(4, N*2-3) as sf:
      pz = sf.p[0]
      px = sf.p[1]
      py = sf.p[2]
      pp = sf.p[3]
      X = sf.t[0:N]
      T = sf.t[N:]
      load_pm(X, px)   # X = px[]
      sub_pm(X, py)    # X = px[] - py[]
      T.append(px)
      T.append(py)
      T.append(pp)
      load_pm(T, pp)   # pp is destroyed
      sbb(rax, rax)
      and_re(T, rax)   # T = X < 0 ? p : 0
      add_pp(X, T)
      store_mp(pz, X)

def gen_fp_sub(N):
  align(16)
  with FuncProc(f'mclb_fp_sub{N}'):
    with StackFrame(4, N-1) as sf:
      pz = sf.p[0]
      px = sf.p[1]
      py = sf.p[2]
      pp = sf.p[3]
      X = sf.t
      X.append(px)
      load_pm(X, px)   # X = px[], px is destroyed
      sub_pm(X, py)    # X = px[] - py[]
      lea(rax, rip('ZERO'))
      cmovc(rax, pp)   # X < 0 ? pp : 0
      add_pm(X, rax)
      store_mp(pz, X)

def gen_mulPreLowN(pz, px, py, pk, H, N):
  mov(rdx, ptr(px + 8 * 0))
  a = rax
  # [pz[0]:pk[0:N-1]] = px[] * py[0]
  mulx(pk[0], a, ptr(py + 8 * 0))
  mov(ptr(pz), a)
  for i in range(1, N):
    if i < N-1:
      mulx(pk[i], a, ptr(py + 8 * i))
    else:
      mulx(H, a, ptr(py + 8 * i)) ## H is not used
    if i == 1:
      add(pk[i - 1], a)
    elif i < N:
      adc(pk[i - 1], a)

  for i in range(1, N):
    mov(rdx, ptr(px + 8 * i))
    xor_(a, a)
    for j in range(0, N-i):
      mulx(H, a, ptr(py + j * 8))
      adox(pk[j], a)
      if j == 0:
        mov(ptr(pz + 8 * i), pk[0])
      if j == N-i-1:
        break
      adcx(pk[j + 1], H)
    pk = pk[1:]
#  mov(ptr(pz + 8 * (N-1)), pk[0])

# z[N] = the bottom half of (x[N] * y[N])
def gen_mulPreLow_fast(N):
  align(16)
  with FuncProc(f'mclb_mulPreLow_fast{N}'):
    if N <= 9:
      with StackFrame(3, N, useRDX=True) as sf:
        pz = sf.p[0]
        px = sf.p[1]
        py = sf.p[2]
        pk = sf.t[0:N-1]
        gen_mulPreLowN(pz, px, py, pk, sf.t[N-1], N)
    else:
      jmp(f'mclb_mulPreLow_slow{N}')

parser = argparse.ArgumentParser()
parser.add_argument('-win', '--win', help='output win64 abi', action='store_true')
parser.add_argument('-m', '--mode', help='output asm syntax', default='nasm')
param = parser.parse_args()

setWin64ABI(param.win)
#init(param.mode)

segment('text')
output('ZERO:')
dq_('0,'*8)

for N in [4, 6]:
  gen_fp_add(N)
  gen_fp_addNF(N)
  gen_fp_sub(N)
  gen_mulPreLow_fast(N)

term()
