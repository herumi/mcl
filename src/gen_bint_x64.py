from s_xbyak import *
import argparse

# byte in .data of the bint asm: 1 if the mulx/adx (fast) bodies are selected by the mclb_* stubs
# (set by mclb_enable_fast(), called from mcl::bint::getCpuType())
FLAG='mclb_fast_flag'

param=None

# p : pack of registers
# r : a register
# m : memory

# op x[], y[]
def vec_pp(op, x, y):
  for i in range(len(x)):
    op(x[i], y[i])

# op x[], [addr]
def vec_pm(op, x, addr):
  for i in range(len(x)):
    op(x[i], ptr(addr + 8 * i))

# op [addr], x[]
def vec_mp(op, addr, x):
  for i in range(len(x)):
    op(ptr(addr + 8 * i), x[i])

def mov_pp(x, y):
  vec_pp(mov, x, y)

def cmovc_pp(x, y):
  vec_pp(cmovc, x, y)

def cmovnc_pp(x, y):
  vec_pp(cmovnc, x, y)

def load_pm(x, m):
  vec_pm(mov, x, m)

def store_mp(m, x):
  vec_mp(mov, m, x)

# add(x, y) if noCF is True
# adc(x, y) if noCF is False
def add_ex(x, y, noCF):
  if noCF:
    add(x, y)
  else:
    adc(x, y)

# sub(x, y) if noCF is True
# sbb(x, y) if noCF is False
def sub_ex(x, y, noCF):
  if noCF:
    sub(x, y)
  else:
    sbb(x, y)

def add_pm(t, px, withCF=False):
  for i in range(len(t)):
    add_ex(t[i], ptr(px + i*8), not withCF and i == 0)

def sub_pm(t, px, withCF=False):
  for i in range(len(t)):
    sub_ex(t[i], ptr(px + i*8), not withCF and i == 0)

def add_pp(t, x, withCF=False):
  for i in range(len(t)):
    add_ex(t[i], x[i], not withCF and i == 0)

def gen_add(N, NF=False):
  align(16)
  name = 'mclb_add'
  if NF:
    name += 'NF'
  with FuncProc(f'{name}{N}'):
    if N == 0:
      raise Exception('N = 0')
    with StackFrame(3) as sf:
      z = sf.p[0]
      x = sf.p[1]
      y = sf.p[2]
      for i in range(N):
        mov(rax, ptr(x + 8 * i))
        add_ex(rax, ptr(y + 8 * i), i == 0)
        mov(ptr(z + 8 * i), rax)
      if NF:
        return
      setc(al)
      movzx(eax, al)

def gen_sub(N, NF=False):
  align(16)
  name = 'mclb_sub'
  if NF:
    name += 'NF'
  with FuncProc(f'{name}{N}'):
    if N == 0:
      raise Exception('N = 0')
    with StackFrame(3) as sf:
      z = sf.p[0]
      x = sf.p[1]
      y = sf.p[2]
      for i in range(N):
        mov(rax, ptr(x + 8 * i))
        sub_ex(rax, ptr(y + 8 * i), i == 0)
        mov(ptr(z + 8 * i), rax)
      setc(al)
      movzx(eax, al)

# [rax:z[N]] = x[N] * y with plain mul (rdx:rax); the partial products are spilled to
# [rsp, rsp + (N-1)*2*8); y is a register; clobbers rax, rdx
def mulUnit_slow_body(z, x, y, N):
  if N == 1:
    mov(rax, ptr(x))
    mul(y)
    mov(ptr(z), rax)
    mov(rax, rdx)
    return
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
    add_ex(rax, ptr(rsp + i * 8), i == 0)
    mov(ptr(z + (i + 1) * 8), rax)
  adc(rdx, 0)
  mov(rax, rdx)

# [rax:z[N]] = z[N] + x[N] * y with plain mul; stack [rsp, rsp + (N*2-1)*8)
def mulUnitAdd_slow_body(z, x, y, N):
  posH = N * 8
  for i in range(N):
    mov(rax, ptr(x + i * 8))
    mul(y)
    mov(ptr(rsp + i * 8), rax)
    if i < N-1:
      mov(ptr(rsp + posH + i * 8), rdx) # don't write the last rdx
  for i in range(N - 1):
    mov(rax, ptr(rsp + (i + 1) * 8))
    add_ex(rax, ptr(rsp + posH + i * 8), i == 0)
    mov(ptr(rsp + (i + 1) * 8), rax)
  if N > 1:
    adc(rdx, 0)
  for i in range(N):
    mov(rax, ptr(rsp + i * 8))
    add_ex(ptr(z + i * 8), rax, i == 0)
  adc(rdx, 0)
  mov(rax, rdx)

# mode = 'fast' (mulx/adox/adcx) or 'slow' (mul/adc); the plain mclb_* names are the stubs (gen_stub)
# [ret:z[N]] = x[N] * y
def gen_mulUnit(N, mode):
  align(16)
  with FuncProc(f'mclb_mulUnit_{mode}{N}'):
    if N == 0:
      raise Exception('N = 0')
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
    elif mode == 'slow':
      with StackFrame(3, 0, useRDX=True, stackSizeByte=(N - 1) * 2 * 8) as sf:
        mulUnit_slow_body(sf.p[0], sf.p[1], sf.p[2], N)
    else:
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
          add_ex(rax, t1, i == 1)
          mov(ptr(z + i * 8), rax)
          t0, t1 = t1, t0
        mulx(rax, rdx, ptr(x + (N - 1) * 8))
        adc(rdx, t1)
        mov(ptr(z + (N - 1) * 8), rdx)
        adc(rax, 0)

# [ret:z[N]] = z[N] + x[N] * y
def gen_mulUnitAdd(N, mode):
  align(16)
  with FuncProc(f'mclb_mulUnitAdd_{mode}{N}'):
    if N == 0:
      raise Exception('N = 0')
    if mode == 'slow':
      with StackFrame(3, 0, useRDX=True, stackSizeByte=(N * 2 - 1) * 8) as sf:
        mulUnitAdd_slow_body(sf.p[0], sf.p[1], sf.p[2], N)
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

def mulPack(pz, offset, py, pd):
  a = rax
  mulx(pd[0], a, ptr(py + 8 * 0))
  mov(ptr(pz + offset), a)
  n = len(pd)
  for i in range(1, n):
    mulx(pd[i], a, ptr(py + 8 * i))
    add_ex(pd[i - 1], a, i == 1)
  adc(pd[n - 1], 0)

def mulPackAdd(pz, offset, py, hi, pd):
  a = rax
  xor_(a, a)
  n = len(pd)
  for i in range(0, n):
    mulx(hi, a, ptr(py + i * 8))
    adox(pd[i], a)
    if i == 0:
      mov(ptr(pz + offset), pd[0])
    if i == n - 1:
      break
    adcx(pd[i + 1], hi)
  mov(a, 0)
  adox(hi, a)
  adc(hi, a)

def gen_mulPreN(pz, px, py, pk, t, N):
  assert len(pk) == N
  mov(rdx, ptr(px + 8 * 0))
  mulPack(pz, 8 * 0, py, pk)
  for i in range(1, N):
    mov(rdx, ptr(px + 8 * i))
    mulPackAdd(pz, 8 * i, py, t, pk)
    s = pk[0]
    pk = pk[1:]
    pk.append(t)
    t = s
  store_mp(pz + 8 * N, pk)

# z[2N] = x[N] * y[N]
# optimize this later
def gen_mul(N, mode):
  align(16)
  with FuncProc(f'mclb_mul_{mode}{N}'):
    if N == 1:
      with StackFrame(3, 0, useRDX=True) as sf:
        mov(rax, ptr(sf.p[1]))
        mov(rdx, ptr(sf.p[2]))
        mul(rdx)
        store_mp(sf.p[0], Pack(rdx, rax))
        return
    if mode == 'slow':
      # column-wise (comba) with plain mul: z[k] = low 64 bits of sum_{i+j=k} x[i] y[j] + carry,
      # accumulated in the 3-unit register [c2:c1:c0]; mul takes y[j] from memory, so no spill
      with StackFrame(3, 3, useRDX=True) as sf:
        pz = sf.p[0]
        px = sf.p[1]
        py = sf.p[2]
        c0 = sf.t[0]
        c1 = sf.t[1]
        c2 = sf.t[2]
        first = True
        for k in range(2 * N - 1):
          for i in range(max(0, k - (N - 1)), min(k, N - 1) + 1):
            j = k - i
            mov(rax, ptr(px + i * 8))
            mul(qword(py + j * 8)) # [rdx:rax] = x[i] * y[j]
            if first:
              mov(c0, rax)
              mov(c1, rdx)
              xor_(c2, c2)
              first = False
            else:
              add(c0, rax)
              adc(c1, rdx)
              adc(c2, 0)
          mov(ptr(pz + k * 8), c0)
          # the next column starts from [0:c2:c1]
          c0, c1, c2 = c1, c2, c0
          if k < 2 * N - 2:
            xor_(c2, c2)
        mov(ptr(pz + (2 * N - 1) * 8), c0)
      return
    if N > 9:
      raise Exception(f'N = {N} is too large')
    with StackFrame(3, N+1, useRDX=True) as sf:
      pz = sf.p[0]
      px = sf.p[1]
      py = sf.p[2]
      pk = sf.t[0:N]
      gen_mulPreN(pz, px, py, pk, sf.t[N], N)

# y[2N] = x[N]^2
# optimize this later
def gen_sqr(N, mode):
  align(16)
  with FuncProc(f'mclb_sqr_{mode}{N}'):
    if N == 1:
      with StackFrame(2, 0, useRDX=True) as sf:
        py = sf.p[0]
        px = sf.p[1]
        mov(rax, ptr(px))
        mul(rax)
        store_mp(py, Pack(rdx, rax))
        return
    if param.win:
      mov(r8, rdx)
    else:
      mov(rdx, rsi)
    jmp(addPRE(f'mclb_mul_{mode}{N}'))

# the plain mclb_* names stay real functions (src/asm/x86-64.S calls mclb_mul3 / mclb_sqr3 and
# src/bint64.ll defines the same names on the other targets): test the flag and jump to the body.
# The C++ side (get_mul(n) etc. in src/bint_switch.hpp) selects the body directly.
def gen_stub(name, N):
  align(16)
  with FuncProc(f'{name}{N}'):
    cmp(byte(rip + FLAG), 0)
    jne(addPRE(f'{name}_fast{N}'))
    jmp(addPRE(f'{name}_slow{N}'))

# void mclb_enable_fast(): select the mulx/adx bodies in the mclb_* stubs
def gen_enable_fast():
  align(16)
  with FuncProc('mclb_enable_fast'):
    mov(byte(rip + FLAG), 1)
    ret()

def bint_data():
  makeLabel(FLAG)
  db_(0)

def gen_udiv128():
  align(16)
  with FuncProc('mclb_udiv128'):
    mov(rax, rdx)
    mov(rdx, rcx)
    div(r8)
    mov(ptr(r9), rdx)
    ret()

# one step of modp (x64 version of common.modp_step): the constants come
# from the parameter block para (the layout of common.modp_param: Qt = Q 2^s
# as two limbs q0, q1, then np[N]), so the code depends only on N.
# The quotient estimate is y = (W Qt) >> 129 with W = [X_{N-1}, X_N], the top
# two limbs of xx as they are (see the comment in common.py): a
# 2x2-limb product (4 mulx) of which only the limbs 2, 3 are kept, and the
# shift is an immediate shrd. The extraction of xx >> (L-2) with a variable
# shift (shrd/shr by cl or shrx/shlx) costs about 2 cycles per step on
# Sapphire Rapids, which is why the shift is folded into Qt instead.
# The conditional subtraction is done as r + np: the carry out means r >= p
# and the sum is r - p mod 2^(64N), so cmovnc restores the kept r (no p
# constant); np is addressed from para. rdx (y, dead after the row) and rcx
# are the last keep registers, so no register is needed beyond
# tmp = [T0, T1, T2, T3] (T3 may be rax); rcx and rdx are clobbered.
def modp_step_x64(pk, pw, para, tmp):
  N = len(pk)
  T0, T1, T2, T3 = tmp
  a0 = pk[N - 2]
  a1 = pk[N - 1]
  # [T1, T3, T2] = limbs 1, 2, 3 of [a0, a1] * [q0, q1] (limb 0 is not needed)
  mov(rdx, ptr(para))  # q0
  mulx(T2, T3, a0)   # T2 = hi(a0 q0)
  mulx(T3, T1, a1)   # [T1, T3] = a1 q0
  add(T1, T2)
  adc(T3, 0)
  mov(rdx, ptr(para + 8))  # q1
  mulx(T2, T0, a0)   # [T0, T2] = a0 q1
  add(T1, T0)
  adc(T3, T2)
  mulx(T2, T0, a1)   # [T0, T2] = a1 q1
  adc(T2, 0)
  add(T3, T0)
  adc(T2, 0)
  # X_N is consumed; its register takes w
  mov(pk[N - 1], pw)
  shrd(T3, T2, 1)    # y = [limb 2, limb 3] >> 1
  mov(rdx, T3)
  # xx = [w, r] in registers: rotate so that pk[0] = w
  pk = [pk[N - 1]] + pk[0:N - 1]
  # r = (xx + y np) mod 2^(64N)
  pnp = para + 8 * 2
  xor_(T0, T0)  # clear CF and OF
  for i in range(N):
    mulx(T0, T1, ptr(pnp + i * 8))
    adox(pk[i], T1)
    if i < N - 1:
      adcx(pk[i + 1], T0)
  # r -= p if r >= p : r + np carries out
  keep = [T0, T1, T2, T3, rcx, rdx][0:N]
  mov_pp(keep, pk)
  add_pm(pk, pnp)
  cmovnc_pp(pk, keep)
  return pk

# int name(Unit *dst, const Unit *src, size_t srcN, const Unit *para):
# x64 version of common.emit_modp (para is struct mcl::Modp): returns 0 if
# srcN > xN, otherwise dst[N] = src[srcN] mod p and returns 1 (dst is src
# zero-extended when srcN < N). The constants are read from para (see
# modp_step_x64), so the code depends only on N (one function per N as in
# the LLVM version); p must not be full bit (r < 2p has to fit in N limbs,
# i.e. p < 2^(64N-1)) and L >= 64(N-1) + 2. The xN - N + 1 steps are
# unrolled with an exit test (sub/jc on the step count) after each, so
# srcN - N + 1 steps run; each exit stores its own rotation of pk.
# Registers (N = 6 uses all 15): src, count, para, pk[N], T0, T1 in the
# frame, T2 = the register of dst (spilled to the stack until the exits),
# T3 = rax, rcx and rdx for the keep list and mulx.
def gen_modp_x64(name, xN, N):
  assert N <= 6
  align(16)
  with FuncProc(name):
    ret0L = Label()
    # srcN > xN: return 0 before the prologue (3rd argument register)
    cmp(getReg(2), xN)
    ja(ret0L)
    with StackFrame(4, N + 2, useRDX=True, useRCX=True, stackSizeByte=8) as sf:
      pz = sf.p[0]
      px = sf.p[1]
      n = sf.p[2]
      para = sf.p[3]
      pk = sf.t[0:N]
      mov(ptr(rsp), pz)
      tmp = sf.t[N:N + 2] + [pz, rax]
      smallL = Label()
      exitL = Label()
      cmp(n, N)
      jb(smallL)
      # r = top N-1 limbs of src = src[n - (N-1) .. n), X_N = 0
      lea(rax, ptr(px + n * 8))
      for i in range(N - 1):
        mov(pk[i], ptr(rax - (N - 1 - i) * 8))
      xor_(pk[N - 1], pk[N - 1])
      lea(px, ptr(rax - N * 8))  # &src[n - N]
      sub(n, N)                  # remaining steps - 1
      exits = []
      for j in range(xN - N + 1):
        pk = modp_step_x64(pk, ptr(px), para, tmp)
        if j < xN - N:
          doneL = Label()
          sub(n, 1)
          jc(doneL)
          exits.append((doneL, pk))
          sub(px, 8)
      # the last step: n == 0 here
      mov(rdx, ptr(rsp))
      store_mp(rdx, pk)
      jmp(exitL)
      for (doneL, pk) in exits:
        L(doneL)
        mov(rdx, ptr(rsp))
        store_mp(rdx, pk)
        jmp(exitL)
      # srcN < N (src < p): dst = src zero-extended
      L(smallL)
      mov(rdx, ptr(rsp))
      zeroL = [Label() for i in range(N)]
      for i in range(N - 1):
        cmp(n, i)
        je(zeroL[i])
        mov(rax, ptr(px + i * 8))
        mov(ptr(rdx + i * 8), rax)
      jmp(zeroL[N - 1])
      for i in range(N):
        L(zeroL[i])
        mov(qword(rdx + i * 8), 0)
      L(exitL)
      mov(eax, 1)
    L(ret0L)
    xor_(eax, eax)
    ret()

def main():
  parser = getDefaultParser()
  parser.add_argument('-n', '--num', help='max size of Unit for mul/sqr (see MCL_BINT_MUL_N in include/mcl/config.hpp)', type=int, default=6)
  parser.add_argument('-addn', '--addn', help='max size of Unit for mulUnit/add/sub (default 2n)', type=int, default=0)
  global param
  param = parser.parse_args()

  N = param.num
  addN = param.addn
  if addN == 0:
    addN = N * 2

  init(param)
  segment('data')
  bint_data()
  segment('text')

  for i in range(1,addN+1):
    gen_add(i)

  for i in range(1,addN+1):
    gen_sub(i)

  for i in range(1,addN+1):
    gen_add(i, True)

  for i in range(1,addN+1):
    gen_sub(i, True)

  # the mulx/adox/adcx (fast) and mul/adc (slow) bodies, selected at runtime by the CPU type
  for mode in ['fast', 'slow']:
    for i in range(1,addN+1):
      gen_mulUnit(i, mode)

    for i in range(1,addN+1):
      gen_mulUnitAdd(i, mode)

    for i in range(1,N+1):
      gen_mul(i, mode)

    for i in range(1,N+1):
      gen_sqr(i, mode)

  # the dispatch stubs with the plain names and the setter of the flag
  for i in range(1,addN+1):
    gen_stub('mclb_mulUnit', i)
    gen_stub('mclb_mulUnitAdd', i)
  for i in range(1,N+1):
    gen_stub('mclb_mul', i)
    gen_stub('mclb_sqr', i)
  gen_enable_fast()

  # dst[N] = src[srcN] mod p with the parameter block of struct mcl::Modp
  # (see common.modp_param), N = 4, 6 (256, 384 bit); selected by Modp::init
  gen_modp_x64('mclb_modp256_x64', 8, 4)
  gen_modp_x64('mclb_modp384_x64', 8, 6)

  if param.win:
    gen_udiv128()

  term()

if __name__ == '__main__':
  main()
