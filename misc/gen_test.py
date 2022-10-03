from gen_x86asm import *
from gen_bint_x64 import *
import argparse

# t[] = [px] + [py]
def add_rmm(t, px, py):
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
      load_rm(X, px)   # X = px[]
      add_rm(X, py)    # X = px[] + py[]
      setc(al)         # set CF
      T.append(px)
      T.append(py)
      mov_rr(T, X)     # T = X
      sub_rm(T, pp)    # T -= pp[]
      sbb(eax, 0)      # check CF
      cmovc_rr(T, X)   # T = X if T < 0
      store_mr(pz, T)

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
      load_rm(X, px)   # X = px[]
      add_rm(X, py)    # X = px[] + py[]
      T.append(px)
      T.append(py)
      T.append(rax)
      mov_rr(T, X)     # T = X
      sub_rm(T, pp)    # T -= pp[]
      cmovc_rr(T, X)   # T = X if T < 0
      store_mr(pz, T)

parser = argparse.ArgumentParser()
parser.add_argument('-win', '--win', help='output win64 abi', action='store_true')
parser.add_argument('-m', '--mode', help='output asm syntax', default='nasm')
param = parser.parse_args()

setWin64ABI(param.win)
#init(param.mode)

segment('text')
for N in [4, 6]:
  gen_fp_add(N)
  gen_fp_addNF(N)

term()
