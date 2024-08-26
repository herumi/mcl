from s_xbyak import *
import argparse
from montgomery import *

# c5 means curve param=5 (BLS12_381)
MSM_PRE='mcl_c5_'
C_p='p'

def gen_vaddPre(mont, vN=1):
  SUF = 'A' if vN == 2 else ''
  with FuncProc(MSM_PRE+'vaddPre'+SUF):
    with StackFrame(3, 0, vNum=1+vN*2, vType=T_ZMM) as sf:
      un = genUnrollFunc()
      W = mont.W
      z = sf.p[0]
      x = sf.p[1]
      y = sf.p[2]
      vmask = zmm0
      c = sf.v[1:1+vN]
      t = sf.v[1+vN:1+vN*2]
      mov(rax, mont.mask)
      vpbroadcastq(vmask, rax)

      for i in range(0, mont.N):
        un(vmovdqa64)(t, ptr(x+i*64*vN))
        un(vpaddq)(t, t, ptr(y+i*64*vN))
        if i > 0:
          un(vpaddq)(t, t, c);
        if i == mont.N-1:
          un(vmovdqa64)(ptr(z+i*64*vN), t)
          return
        un(vpsrlq)(c, t, W)
        un(vpandq)(t, t, vmask)
        un(vmovdqa64)(ptr(z+i*64*vN), t)

def gen_vsubPre(mont, vN=1):
  SUF = 'A' if vN == 2 else ''
  with FuncProc(MSM_PRE+'vsubPre'+SUF):
    with StackFrame(3, 0, vNum=1+vN*2, vType=T_ZMM) as sf:
      un = genUnrollFunc()
      S = 63
      z = sf.p[0]
      x = sf.p[1]
      y = sf.p[2]
      vmask = zmm0
      c = sf.v[1:1+vN]
      t = sf.v[1+vN:1+vN*2]
      mov(rax, mont.mask)
      vpbroadcastq(vmask, rax)

      for i in range(0, mont.N):
        un(vmovdqa64)(t, ptr(x+i*64*vN))
        un(vpsubq)(t, t, ptr(y+i*64*vN))
        if i > 0:
          un(vpsubq)(t, t, c);
        un(vpsrlq)(c, t, S)
        un(vpandq)(t, t, vmask)
        un(vmovdqa64)(ptr(z+i*64*vN), t)

      vpxorq(t[0], t[0], t[0])
      un(vpcmpgtq)([k1, k2], c, t[0])

def gen_vadd(mont, vN=1):
  SUF = 'A' if vN == 2 else ''
  with FuncProc(MSM_PRE+'vadd'+SUF):
    with StackFrame(3, 0, useRCX=True, vNum=mont.N*2+3, vType=T_ZMM) as sf:
      regs = list(reversed(sf.v))
      W = mont.W
      N = mont.N
      S = 63
      z = sf.p[0]
      x = sf.p[1]
      y = sf.p[2]
      s = pops(regs, N)
      t = pops(regs, N)
      vmask = pops(regs, 1)[0]
      c = pops(regs, 1)[0]
      zero = pops(regs, 1)[0]

      mov(rax, mont.mask)
      vpbroadcastq(vmask, rax)

      # s = x+y
      # t = s-p
      # s = x+y

      un = genUnrollFunc()

      if vN == 2:
        mov(ecx, 2)
        lpL = Label()
        L(lpL)

      if False:
        unb = genUnrollFunc(addrOffset=8)
        un(vmovdqa64)(s, ptr(x))
        un(vpaddq)(s, s, ptr(y))
        for i in range(N-1):
          vpsrlq(c, s[i], W)
          vpaddq(s[i+1], s[i+1], c)
        un(vpandq)(s, s, vmask)
        lea(rax, ptr(rip+C_p))
        unb(vpsubq)(t, s, ptr_b(rax))
        for i in range(0, N):
          if i > 0:
            vpsubq(t[i], t[i], c)
          vpsrlq(c, t[i], S)
      else:
        # a little faster
        # s = x+y
        for i in range(0, N):
          vmovdqa64(s[i], ptr(x+i*64))
          vpaddq(s[i], s[i], ptr(y+i*64))
          if i > 0:
            vpaddq(s[i], s[i], c);
          if i == mont.N-1:
            break
          vpsrlq(c, s[i], W)
          vpandq(s[i], s[i], vmask)
        # t = s-p
        lea(rax, ptr(rip+C_p))
        for i in range(0, N):
          vpsubq(t[i], s[i], ptr_b(rax+i*8))
          if i > 0:
            vpsubq(t[i], t[i], c);
          vpsrlq(c, t[i], S)

      vpxorq(zero, zero, zero)
      vpcmpeqq(k1, c, zero) # k1 = t>=0
      # z = select(k1, s, t)
      for i in range(N):
        vpandq(s[i]|k1, t[i], vmask)
      un(vmovdqa64)(ptr(z), s)

      if vN == 2:
        add(x, 64)
        add(y, 64)
        add(z, 64)
        sub(ecx, 1)
        jnz(lpL)

def gen_vsub(mont):
  with FuncProc(MSM_PRE+'vsub'):
    with StackFrame(3, 0, vNum=mont.N*2+2, vType=T_ZMM) as sf:
      regs = list(reversed(sf.v))
      W = mont.W
      N = mont.N
      S = 63
      z = sf.p[0]
      x = sf.p[1]
      y = sf.p[2]
      s = pops(regs, N)
      t = pops(regs, N)
      vmask = pops(regs, 1)[0]
      c = pops(regs, 1)[0]

      mov(rax, mont.mask)
      vpbroadcastq(vmask, rax)

      un = genUnrollFunc()

      # s = x-y
      for i in range(0, N):
        vmovdqa64(s[i], ptr(x+i*64))
        vpsubq(s[i], s[i], ptr(y+i*64))
        if i > 0:
          vpsubq(s[i], s[i], c);
        vpsrlq(c, s[i], S)
        vpandq(s[i], s[i], vmask)

      vpxorq(t[0], t[0], t[0])
      vpcmpgtq(k1, c, t[0]) # k1 = x<y

      # t = s+p
      lea(rax, ptr(rip+C_p));
      for i in range(0, N):
        vpaddq(t[i], s[i], ptr_b(rax+i*8))
        if i > 0:
          vpaddq(t[i], t[i], c);
        if i < N-1:
          vpsrlq(c, t[i], W)
        # z = select(k1, t, s)
        vpandq(s[i]|k1, t[i], vmask)

      un(vmovdqa64)(ptr(z), s)

def vmulL(z, x, y):
  vpmadd52luq(z, x, y)

def vmulH(z, x, y):
  vpmadd52huq(z, x, y)

# z[0:N+1] = x[0:N] * y
def vmulUnit(z, px, y, N, H, t):
  vpxorq(z[0], z[0], z[0])
  vmovdqa64(t, ptr(px))
  vmulL(z[0], t, y)
  vpxorq(H, H, H)
  vmulH(H, t, y)
  for i in range(1, N):
    vmovdqa64(z[i], H)
    vmovdqa64(t, ptr(px+i*64))
    vmulL(z[i], t, y)
    if i < N-1:
      vpxorq(H, H, H)
      vmulH(H, t, y)
    else:
      vpxorq(z[N], z[N], z[N])
      vmulH(z[N], t, y)

# [H]:z[0:N] = z[0:N] + x[] * y
def vmulUnitAdd(z, px, y, N, H, t):
  vmovdqa64(t, ptr(px))
  vmulL(z[0], t, y)
  vpxorq(H, H, H)
  vmulH(H, t, y)
  for i in range(1, N):
    vmovdqa64(t, ptr(px+i*64))
    vmulL(z[i], t, y)
    vpaddq(z[i], z[i], H)
    if i < N-1:
      vpxorq(H, H, H)
      vmulH(H, t, y)
    else:
      vpxorq(z[N], z[N], z[N])
      vmulH(z[N], t, y)

def gen_vmul(mont):
  with FuncProc(MSM_PRE+'vmul'):
    with StackFrame(3, 0, vNum=mont.N*2+4, vType=T_ZMM) as sf:
      regs = list(reversed(sf.v))
      W = mont.W
      N = mont.N
      pz = sf.p[0]
      px = sf.p[1]
      py = sf.p[2]

      t = pops(regs, N*2)
      vmask = pops(regs, 1)[0]
      c = pops(regs, 1)[0]
      y = pops(regs, 1)[0]
      H = pops(regs, 1)[0]

      mov(rax, mont.mask)
      vpbroadcastq(vmask, rax)

      un = genUnrollFunc()

      vmovdqa64(y, ptr(py))
      un(vmovdqa64)(t[0:N], ptr(pz))
      vmulUnitAdd(t, px, y, N, H, c)
      un(vmovdqa64)(ptr(pz), t[0:N+1])

def msm_data(mont):
  makeLabel(C_p)
  dq_(', '.join(map(hex, mont.toArray(mont.p))))

def msm_code(mont):
  for vN in [1, 2]:
    gen_vaddPre(mont, vN)
    gen_vsubPre(mont, vN)
    gen_vadd(mont, vN)

  gen_vsub(mont)
  gen_vmul(mont)

SUF='_fast'
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

def gen_mulUnit(N, mode='fast'):
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
            add_ex(rax, t1, i == 1)
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
            add_ex(rax, ptr(rsp + i * 8), i == 0)
            mov(ptr(z + (i + 1) * 8), rax)
          adc(rdx, 0)
          mov(rax, rdx)

# [ret:z[N]] = z[N] + x[N] * y
def gen_mulUnitAdd(N, mode='fast'):
  align(16)
  with FuncProc(f'mclb_mulUnitAdd_{mode}{N}'):
    if N == 0:
      raise Exception('N = 0')
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
          add_ex(rax, ptr(rsp + posH + i * 8), i == 0)
          mov(ptr(rsp + (i + 1) * 8), rax)
        if N > 1:
          adc(rdx, 0)
        for i in range(N):
          mov(rax, ptr(rsp + i * 8))
          add_ex(ptr(z + i * 8), rax, i == 0)
        adc(rdx, 0)
        mov(rax, rdx)

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

# optimize this later
def gen_mul_fast(N):
  align(16)
  with FuncProc(f'mclb_mul_fast{N}'):
    if N <= 9:
      with StackFrame(3, N+1, useRDX=True) as sf:
        pz = sf.p[0]
        px = sf.p[1]
        py = sf.p[2]
        pk = sf.t[0:N]
        gen_mulPreN(pz, px, py, pk, sf.t[N], N)
    else:
      jmp(addPRE(f'mclb_mul_slow{N}'))

# optimize this later
def gen_sqr_fast(N):
  align(16)
  with FuncProc(f'mclb_sqr_fast{N}'):
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
    jmp(addPRE(f'mclb_mul_fast{N}'))

"""
def gen_enable_fast(N):
  align(16)
  with FuncProc('mclb_disable_fast'):
    for i in range(1, N):
      lea(rdx, ptr(rip+f'mclb_mulUnit{i}'))
      lea(rax, ptr(rip+f'mclb_mulUnit_slow{i}'))
      mov(ptr(rdx), rax)
    for i in range(1, N):
      lea(rdx, ptr(rip+f'mclb_mulUnitAdd{i}'))
      lea(rax, ptr(rip+f'mclb_mulUnitAdd_slow{i}'))
      mov(ptr(rdx), rax)
    ret()
"""

def gen_udiv128():
  align(16)
  with FuncProc('mclb_udiv128'):
    mov(rax, rdx)
    mov(rdx, rcx)
    div(r8)
    mov(ptr(r9), rdx)
    ret()

def main():
  parser = getDefaultParser()
  parser.add_argument('-n', '--num', help='max size of Unit', type=int, default=9)
  parser.add_argument('-addn', '--addn', help='max size of add/sub', type=int, default=16)
  global param
  param = parser.parse_args()

  N = param.num
  addN = param.addn

  init(param)
  curve = BLS12()
  mont = Montgomery(curve.p)
  segment('data')
  msm_data(mont)
  segment('text')
  msm_code(mont)

  for i in range(1,addN+1):
    gen_add(i)

  for i in range(1,addN+1):
    gen_sub(i)

  for i in range(1,addN+1):
    gen_add(i, True)

  for i in range(1,addN+1):
    gen_sub(i, True)

  for i in range(1,N+1):
    gen_mulUnit(i, 'fast')

  for i in range(1,N+1):
    gen_mulUnitAdd(i, 'fast')

  for i in range(1,N+1):
    gen_mulUnit(i, 'slow')

  for i in range(1,N+1):
    gen_mulUnitAdd(i, 'slow')

  for i in range(1,N+1):
    gen_mul_fast(i)

  for i in range(1,N+1):
    gen_sqr_fast(i)

  if param.win:
    gen_udiv128()

  term()

if __name__ == '__main__':
  main()
