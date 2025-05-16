# for gas
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
#endif
.data
.balign 64
PRE(p):
.quad 0xeffffffffaaab, 0xfeb153ffffb9f, 0x6b0f6241eabff, 0x12bf6730d2a0f, 0x764774b84f385, 0x1ba7b6434bacd, 0x1ea397fe69a4b, 0x1a011
PRE(ap):
.quad 0xeffffffffaaab, 0xeffffffffaaab, 0xeffffffffaaab, 0xeffffffffaaab, 0xeffffffffaaab, 0xeffffffffaaab, 0xeffffffffaaab, 0xeffffffffaaab
.quad 0xfeb153ffffb9f, 0xfeb153ffffb9f, 0xfeb153ffffb9f, 0xfeb153ffffb9f, 0xfeb153ffffb9f, 0xfeb153ffffb9f, 0xfeb153ffffb9f, 0xfeb153ffffb9f
.quad 0x6b0f6241eabff, 0x6b0f6241eabff, 0x6b0f6241eabff, 0x6b0f6241eabff, 0x6b0f6241eabff, 0x6b0f6241eabff, 0x6b0f6241eabff, 0x6b0f6241eabff
.quad 0x12bf6730d2a0f, 0x12bf6730d2a0f, 0x12bf6730d2a0f, 0x12bf6730d2a0f, 0x12bf6730d2a0f, 0x12bf6730d2a0f, 0x12bf6730d2a0f, 0x12bf6730d2a0f
.quad 0x764774b84f385, 0x764774b84f385, 0x764774b84f385, 0x764774b84f385, 0x764774b84f385, 0x764774b84f385, 0x764774b84f385, 0x764774b84f385
.quad 0x1ba7b6434bacd, 0x1ba7b6434bacd, 0x1ba7b6434bacd, 0x1ba7b6434bacd, 0x1ba7b6434bacd, 0x1ba7b6434bacd, 0x1ba7b6434bacd, 0x1ba7b6434bacd
.quad 0x1ea397fe69a4b, 0x1ea397fe69a4b, 0x1ea397fe69a4b, 0x1ea397fe69a4b, 0x1ea397fe69a4b, 0x1ea397fe69a4b, 0x1ea397fe69a4b, 0x1ea397fe69a4b
.quad 0x1a011, 0x1a011, 0x1a011, 0x1a011, 0x1a011, 0x1a011, 0x1a011, 0x1a011
PRE(apA):
.quad 0xeffffffffaaab, 0xeffffffffaaab, 0xeffffffffaaab, 0xeffffffffaaab, 0xeffffffffaaab, 0xeffffffffaaab, 0xeffffffffaaab, 0xeffffffffaaab, 0xeffffffffaaab, 0xeffffffffaaab, 0xeffffffffaaab, 0xeffffffffaaab, 0xeffffffffaaab, 0xeffffffffaaab, 0xeffffffffaaab, 0xeffffffffaaab
.quad 0xfeb153ffffb9f, 0xfeb153ffffb9f, 0xfeb153ffffb9f, 0xfeb153ffffb9f, 0xfeb153ffffb9f, 0xfeb153ffffb9f, 0xfeb153ffffb9f, 0xfeb153ffffb9f, 0xfeb153ffffb9f, 0xfeb153ffffb9f, 0xfeb153ffffb9f, 0xfeb153ffffb9f, 0xfeb153ffffb9f, 0xfeb153ffffb9f, 0xfeb153ffffb9f, 0xfeb153ffffb9f
.quad 0x6b0f6241eabff, 0x6b0f6241eabff, 0x6b0f6241eabff, 0x6b0f6241eabff, 0x6b0f6241eabff, 0x6b0f6241eabff, 0x6b0f6241eabff, 0x6b0f6241eabff, 0x6b0f6241eabff, 0x6b0f6241eabff, 0x6b0f6241eabff, 0x6b0f6241eabff, 0x6b0f6241eabff, 0x6b0f6241eabff, 0x6b0f6241eabff, 0x6b0f6241eabff
.quad 0x12bf6730d2a0f, 0x12bf6730d2a0f, 0x12bf6730d2a0f, 0x12bf6730d2a0f, 0x12bf6730d2a0f, 0x12bf6730d2a0f, 0x12bf6730d2a0f, 0x12bf6730d2a0f, 0x12bf6730d2a0f, 0x12bf6730d2a0f, 0x12bf6730d2a0f, 0x12bf6730d2a0f, 0x12bf6730d2a0f, 0x12bf6730d2a0f, 0x12bf6730d2a0f, 0x12bf6730d2a0f
.quad 0x764774b84f385, 0x764774b84f385, 0x764774b84f385, 0x764774b84f385, 0x764774b84f385, 0x764774b84f385, 0x764774b84f385, 0x764774b84f385, 0x764774b84f385, 0x764774b84f385, 0x764774b84f385, 0x764774b84f385, 0x764774b84f385, 0x764774b84f385, 0x764774b84f385, 0x764774b84f385
.quad 0x1ba7b6434bacd, 0x1ba7b6434bacd, 0x1ba7b6434bacd, 0x1ba7b6434bacd, 0x1ba7b6434bacd, 0x1ba7b6434bacd, 0x1ba7b6434bacd, 0x1ba7b6434bacd, 0x1ba7b6434bacd, 0x1ba7b6434bacd, 0x1ba7b6434bacd, 0x1ba7b6434bacd, 0x1ba7b6434bacd, 0x1ba7b6434bacd, 0x1ba7b6434bacd, 0x1ba7b6434bacd
.quad 0x1ea397fe69a4b, 0x1ea397fe69a4b, 0x1ea397fe69a4b, 0x1ea397fe69a4b, 0x1ea397fe69a4b, 0x1ea397fe69a4b, 0x1ea397fe69a4b, 0x1ea397fe69a4b, 0x1ea397fe69a4b, 0x1ea397fe69a4b, 0x1ea397fe69a4b, 0x1ea397fe69a4b, 0x1ea397fe69a4b, 0x1ea397fe69a4b, 0x1ea397fe69a4b, 0x1ea397fe69a4b
.quad 0x1a011, 0x1a011, 0x1a011, 0x1a011, 0x1a011, 0x1a011, 0x1a011, 0x1a011, 0x1a011, 0x1a011, 0x1a011, 0x1a011, 0x1a011, 0x1a011, 0x1a011, 0x1a011
PRE(rp):
.quad 1125887021744125
.text
.global PRE(mcl_c5_vaddPre)
PRE(mcl_c5_vaddPre):
TYPE(mcl_c5_vaddPre)
mov $4503599627370495, %rax
vpbroadcastq %rax, %zmm0
vmovdqa64 (%rdx), %zmm2
vpaddq (%r8), %zmm2, %zmm2
vpsrlq $52, %zmm2, %zmm1
vpandq %zmm0, %zmm2, %zmm2
vmovdqa64 %zmm2, (%rcx)
vmovdqa64 64(%rdx), %zmm2
vpaddq 64(%r8), %zmm2, %zmm2
vpaddq %zmm1, %zmm2, %zmm2
vpsrlq $52, %zmm2, %zmm1
vpandq %zmm0, %zmm2, %zmm2
vmovdqa64 %zmm2, 64(%rcx)
vmovdqa64 128(%rdx), %zmm2
vpaddq 128(%r8), %zmm2, %zmm2
vpaddq %zmm1, %zmm2, %zmm2
vpsrlq $52, %zmm2, %zmm1
vpandq %zmm0, %zmm2, %zmm2
vmovdqa64 %zmm2, 128(%rcx)
vmovdqa64 192(%rdx), %zmm2
vpaddq 192(%r8), %zmm2, %zmm2
vpaddq %zmm1, %zmm2, %zmm2
vpsrlq $52, %zmm2, %zmm1
vpandq %zmm0, %zmm2, %zmm2
vmovdqa64 %zmm2, 192(%rcx)
vmovdqa64 256(%rdx), %zmm2
vpaddq 256(%r8), %zmm2, %zmm2
vpaddq %zmm1, %zmm2, %zmm2
vpsrlq $52, %zmm2, %zmm1
vpandq %zmm0, %zmm2, %zmm2
vmovdqa64 %zmm2, 256(%rcx)
vmovdqa64 320(%rdx), %zmm2
vpaddq 320(%r8), %zmm2, %zmm2
vpaddq %zmm1, %zmm2, %zmm2
vpsrlq $52, %zmm2, %zmm1
vpandq %zmm0, %zmm2, %zmm2
vmovdqa64 %zmm2, 320(%rcx)
vmovdqa64 384(%rdx), %zmm2
vpaddq 384(%r8), %zmm2, %zmm2
vpaddq %zmm1, %zmm2, %zmm2
vpsrlq $52, %zmm2, %zmm1
vpandq %zmm0, %zmm2, %zmm2
vmovdqa64 %zmm2, 384(%rcx)
vmovdqa64 448(%rdx), %zmm2
vpaddq 448(%r8), %zmm2, %zmm2
vpaddq %zmm1, %zmm2, %zmm2
vmovdqa64 %zmm2, 448(%rcx)
vzeroupper
ret
SIZE(mcl_c5_vaddPre)
.global PRE(mcl_c5_vsubPre)
PRE(mcl_c5_vsubPre):
TYPE(mcl_c5_vsubPre)
mov $4503599627370495, %rax
vpbroadcastq %rax, %zmm0
vmovdqa64 (%rdx), %zmm2
vpsubq (%r8), %zmm2, %zmm2
vpsrlq $63, %zmm2, %zmm1
vpandq %zmm0, %zmm2, %zmm2
vmovdqa64 %zmm2, (%rcx)
vmovdqa64 64(%rdx), %zmm2
vpsubq 64(%r8), %zmm2, %zmm2
vpsubq %zmm1, %zmm2, %zmm2
vpsrlq $63, %zmm2, %zmm1
vpandq %zmm0, %zmm2, %zmm2
vmovdqa64 %zmm2, 64(%rcx)
vmovdqa64 128(%rdx), %zmm2
vpsubq 128(%r8), %zmm2, %zmm2
vpsubq %zmm1, %zmm2, %zmm2
vpsrlq $63, %zmm2, %zmm1
vpandq %zmm0, %zmm2, %zmm2
vmovdqa64 %zmm2, 128(%rcx)
vmovdqa64 192(%rdx), %zmm2
vpsubq 192(%r8), %zmm2, %zmm2
vpsubq %zmm1, %zmm2, %zmm2
vpsrlq $63, %zmm2, %zmm1
vpandq %zmm0, %zmm2, %zmm2
vmovdqa64 %zmm2, 192(%rcx)
vmovdqa64 256(%rdx), %zmm2
vpsubq 256(%r8), %zmm2, %zmm2
vpsubq %zmm1, %zmm2, %zmm2
vpsrlq $63, %zmm2, %zmm1
vpandq %zmm0, %zmm2, %zmm2
vmovdqa64 %zmm2, 256(%rcx)
vmovdqa64 320(%rdx), %zmm2
vpsubq 320(%r8), %zmm2, %zmm2
vpsubq %zmm1, %zmm2, %zmm2
vpsrlq $63, %zmm2, %zmm1
vpandq %zmm0, %zmm2, %zmm2
vmovdqa64 %zmm2, 320(%rcx)
vmovdqa64 384(%rdx), %zmm2
vpsubq 384(%r8), %zmm2, %zmm2
vpsubq %zmm1, %zmm2, %zmm2
vpsrlq $63, %zmm2, %zmm1
vpandq %zmm0, %zmm2, %zmm2
vmovdqa64 %zmm2, 384(%rcx)
vmovdqa64 448(%rdx), %zmm2
vpsubq 448(%r8), %zmm2, %zmm2
vpsubq %zmm1, %zmm2, %zmm2
vpsrlq $63, %zmm2, %zmm1
vpandq %zmm0, %zmm2, %zmm2
vmovdqa64 %zmm2, 448(%rcx)
vpxorq %zmm2, %zmm2, %zmm2
vpcmpgtq %zmm2, %zmm1, %k1
vzeroupper
ret
SIZE(mcl_c5_vsubPre)
.global PRE(mcl_c5_vaddPreA)
PRE(mcl_c5_vaddPreA):
TYPE(mcl_c5_vaddPreA)
mov $4503599627370495, %rax
vpbroadcastq %rax, %zmm0
vmovdqa64 (%rdx), %zmm3
vmovdqa64 64(%rdx), %zmm4
vpaddq (%r8), %zmm3, %zmm3
vpaddq 64(%r8), %zmm4, %zmm4
vpsrlq $52, %zmm3, %zmm1
vpsrlq $52, %zmm4, %zmm2
vpandq %zmm0, %zmm3, %zmm3
vpandq %zmm0, %zmm4, %zmm4
vmovdqa64 %zmm3, (%rcx)
vmovdqa64 %zmm4, 64(%rcx)
vmovdqa64 128(%rdx), %zmm3
vmovdqa64 192(%rdx), %zmm4
vpaddq 128(%r8), %zmm3, %zmm3
vpaddq 192(%r8), %zmm4, %zmm4
vpaddq %zmm1, %zmm3, %zmm3
vpaddq %zmm2, %zmm4, %zmm4
vpsrlq $52, %zmm3, %zmm1
vpsrlq $52, %zmm4, %zmm2
vpandq %zmm0, %zmm3, %zmm3
vpandq %zmm0, %zmm4, %zmm4
vmovdqa64 %zmm3, 128(%rcx)
vmovdqa64 %zmm4, 192(%rcx)
vmovdqa64 256(%rdx), %zmm3
vmovdqa64 320(%rdx), %zmm4
vpaddq 256(%r8), %zmm3, %zmm3
vpaddq 320(%r8), %zmm4, %zmm4
vpaddq %zmm1, %zmm3, %zmm3
vpaddq %zmm2, %zmm4, %zmm4
vpsrlq $52, %zmm3, %zmm1
vpsrlq $52, %zmm4, %zmm2
vpandq %zmm0, %zmm3, %zmm3
vpandq %zmm0, %zmm4, %zmm4
vmovdqa64 %zmm3, 256(%rcx)
vmovdqa64 %zmm4, 320(%rcx)
vmovdqa64 384(%rdx), %zmm3
vmovdqa64 448(%rdx), %zmm4
vpaddq 384(%r8), %zmm3, %zmm3
vpaddq 448(%r8), %zmm4, %zmm4
vpaddq %zmm1, %zmm3, %zmm3
vpaddq %zmm2, %zmm4, %zmm4
vpsrlq $52, %zmm3, %zmm1
vpsrlq $52, %zmm4, %zmm2
vpandq %zmm0, %zmm3, %zmm3
vpandq %zmm0, %zmm4, %zmm4
vmovdqa64 %zmm3, 384(%rcx)
vmovdqa64 %zmm4, 448(%rcx)
vmovdqa64 512(%rdx), %zmm3
vmovdqa64 576(%rdx), %zmm4
vpaddq 512(%r8), %zmm3, %zmm3
vpaddq 576(%r8), %zmm4, %zmm4
vpaddq %zmm1, %zmm3, %zmm3
vpaddq %zmm2, %zmm4, %zmm4
vpsrlq $52, %zmm3, %zmm1
vpsrlq $52, %zmm4, %zmm2
vpandq %zmm0, %zmm3, %zmm3
vpandq %zmm0, %zmm4, %zmm4
vmovdqa64 %zmm3, 512(%rcx)
vmovdqa64 %zmm4, 576(%rcx)
vmovdqa64 640(%rdx), %zmm3
vmovdqa64 704(%rdx), %zmm4
vpaddq 640(%r8), %zmm3, %zmm3
vpaddq 704(%r8), %zmm4, %zmm4
vpaddq %zmm1, %zmm3, %zmm3
vpaddq %zmm2, %zmm4, %zmm4
vpsrlq $52, %zmm3, %zmm1
vpsrlq $52, %zmm4, %zmm2
vpandq %zmm0, %zmm3, %zmm3
vpandq %zmm0, %zmm4, %zmm4
vmovdqa64 %zmm3, 640(%rcx)
vmovdqa64 %zmm4, 704(%rcx)
vmovdqa64 768(%rdx), %zmm3
vmovdqa64 832(%rdx), %zmm4
vpaddq 768(%r8), %zmm3, %zmm3
vpaddq 832(%r8), %zmm4, %zmm4
vpaddq %zmm1, %zmm3, %zmm3
vpaddq %zmm2, %zmm4, %zmm4
vpsrlq $52, %zmm3, %zmm1
vpsrlq $52, %zmm4, %zmm2
vpandq %zmm0, %zmm3, %zmm3
vpandq %zmm0, %zmm4, %zmm4
vmovdqa64 %zmm3, 768(%rcx)
vmovdqa64 %zmm4, 832(%rcx)
vmovdqa64 896(%rdx), %zmm3
vmovdqa64 960(%rdx), %zmm4
vpaddq 896(%r8), %zmm3, %zmm3
vpaddq 960(%r8), %zmm4, %zmm4
vpaddq %zmm1, %zmm3, %zmm3
vpaddq %zmm2, %zmm4, %zmm4
vmovdqa64 %zmm3, 896(%rcx)
vmovdqa64 %zmm4, 960(%rcx)
vzeroupper
ret
SIZE(mcl_c5_vaddPreA)
.global PRE(mcl_c5_vsubPreA)
PRE(mcl_c5_vsubPreA):
TYPE(mcl_c5_vsubPreA)
mov $4503599627370495, %rax
vpbroadcastq %rax, %zmm0
vmovdqa64 (%rdx), %zmm3
vmovdqa64 64(%rdx), %zmm4
vpsubq (%r8), %zmm3, %zmm3
vpsubq 64(%r8), %zmm4, %zmm4
vpsrlq $63, %zmm3, %zmm1
vpsrlq $63, %zmm4, %zmm2
vpandq %zmm0, %zmm3, %zmm3
vpandq %zmm0, %zmm4, %zmm4
vmovdqa64 %zmm3, (%rcx)
vmovdqa64 %zmm4, 64(%rcx)
vmovdqa64 128(%rdx), %zmm3
vmovdqa64 192(%rdx), %zmm4
vpsubq 128(%r8), %zmm3, %zmm3
vpsubq 192(%r8), %zmm4, %zmm4
vpsubq %zmm1, %zmm3, %zmm3
vpsubq %zmm2, %zmm4, %zmm4
vpsrlq $63, %zmm3, %zmm1
vpsrlq $63, %zmm4, %zmm2
vpandq %zmm0, %zmm3, %zmm3
vpandq %zmm0, %zmm4, %zmm4
vmovdqa64 %zmm3, 128(%rcx)
vmovdqa64 %zmm4, 192(%rcx)
vmovdqa64 256(%rdx), %zmm3
vmovdqa64 320(%rdx), %zmm4
vpsubq 256(%r8), %zmm3, %zmm3
vpsubq 320(%r8), %zmm4, %zmm4
vpsubq %zmm1, %zmm3, %zmm3
vpsubq %zmm2, %zmm4, %zmm4
vpsrlq $63, %zmm3, %zmm1
vpsrlq $63, %zmm4, %zmm2
vpandq %zmm0, %zmm3, %zmm3
vpandq %zmm0, %zmm4, %zmm4
vmovdqa64 %zmm3, 256(%rcx)
vmovdqa64 %zmm4, 320(%rcx)
vmovdqa64 384(%rdx), %zmm3
vmovdqa64 448(%rdx), %zmm4
vpsubq 384(%r8), %zmm3, %zmm3
vpsubq 448(%r8), %zmm4, %zmm4
vpsubq %zmm1, %zmm3, %zmm3
vpsubq %zmm2, %zmm4, %zmm4
vpsrlq $63, %zmm3, %zmm1
vpsrlq $63, %zmm4, %zmm2
vpandq %zmm0, %zmm3, %zmm3
vpandq %zmm0, %zmm4, %zmm4
vmovdqa64 %zmm3, 384(%rcx)
vmovdqa64 %zmm4, 448(%rcx)
vmovdqa64 512(%rdx), %zmm3
vmovdqa64 576(%rdx), %zmm4
vpsubq 512(%r8), %zmm3, %zmm3
vpsubq 576(%r8), %zmm4, %zmm4
vpsubq %zmm1, %zmm3, %zmm3
vpsubq %zmm2, %zmm4, %zmm4
vpsrlq $63, %zmm3, %zmm1
vpsrlq $63, %zmm4, %zmm2
vpandq %zmm0, %zmm3, %zmm3
vpandq %zmm0, %zmm4, %zmm4
vmovdqa64 %zmm3, 512(%rcx)
vmovdqa64 %zmm4, 576(%rcx)
vmovdqa64 640(%rdx), %zmm3
vmovdqa64 704(%rdx), %zmm4
vpsubq 640(%r8), %zmm3, %zmm3
vpsubq 704(%r8), %zmm4, %zmm4
vpsubq %zmm1, %zmm3, %zmm3
vpsubq %zmm2, %zmm4, %zmm4
vpsrlq $63, %zmm3, %zmm1
vpsrlq $63, %zmm4, %zmm2
vpandq %zmm0, %zmm3, %zmm3
vpandq %zmm0, %zmm4, %zmm4
vmovdqa64 %zmm3, 640(%rcx)
vmovdqa64 %zmm4, 704(%rcx)
vmovdqa64 768(%rdx), %zmm3
vmovdqa64 832(%rdx), %zmm4
vpsubq 768(%r8), %zmm3, %zmm3
vpsubq 832(%r8), %zmm4, %zmm4
vpsubq %zmm1, %zmm3, %zmm3
vpsubq %zmm2, %zmm4, %zmm4
vpsrlq $63, %zmm3, %zmm1
vpsrlq $63, %zmm4, %zmm2
vpandq %zmm0, %zmm3, %zmm3
vpandq %zmm0, %zmm4, %zmm4
vmovdqa64 %zmm3, 768(%rcx)
vmovdqa64 %zmm4, 832(%rcx)
vmovdqa64 896(%rdx), %zmm3
vmovdqa64 960(%rdx), %zmm4
vpsubq 896(%r8), %zmm3, %zmm3
vpsubq 960(%r8), %zmm4, %zmm4
vpsubq %zmm1, %zmm3, %zmm3
vpsubq %zmm2, %zmm4, %zmm4
vpsrlq $63, %zmm3, %zmm1
vpsrlq $63, %zmm4, %zmm2
vpandq %zmm0, %zmm3, %zmm3
vpandq %zmm0, %zmm4, %zmm4
vmovdqa64 %zmm3, 896(%rcx)
vmovdqa64 %zmm4, 960(%rcx)
vpxorq %zmm3, %zmm3, %zmm3
vpcmpgtq %zmm3, %zmm1, %k1
vpcmpgtq %zmm3, %zmm2, %k2
vzeroupper
ret
SIZE(mcl_c5_vsubPreA)
.global PRE(mcl_c5_vadd)
PRE(mcl_c5_vadd):
TYPE(mcl_c5_vadd)
sub $184, %rsp
vmovups %xmm5, (%rsp)
vmovups %xmm6, 16(%rsp)
vmovups %xmm7, 32(%rsp)
vmovups %xmm8, 48(%rsp)
vmovups %xmm9, 64(%rsp)
vmovups %xmm10, 80(%rsp)
vmovups %xmm11, 96(%rsp)
vmovups %xmm12, 112(%rsp)
vmovups %xmm13, 128(%rsp)
vmovups %xmm14, 144(%rsp)
vmovups %xmm15, 160(%rsp)
mov %rcx, %r10
mov $4503599627370495, %rax
vpbroadcastq %rax, %zmm16
lea PRE(p)(%rip), %rax
vmovdqa64 (%rdx), %zmm0
vpaddq (%r8), %zmm0, %zmm0
vpsrlq $52, %zmm0, %zmm17
vpandq %zmm16, %zmm0, %zmm0
vmovdqa64 64(%rdx), %zmm1
vpaddq 64(%r8), %zmm1, %zmm1
vpaddq %zmm17, %zmm1, %zmm1
vpsrlq $52, %zmm1, %zmm17
vpandq %zmm16, %zmm1, %zmm1
vmovdqa64 128(%rdx), %zmm2
vpaddq 128(%r8), %zmm2, %zmm2
vpaddq %zmm17, %zmm2, %zmm2
vpsrlq $52, %zmm2, %zmm17
vpandq %zmm16, %zmm2, %zmm2
vmovdqa64 192(%rdx), %zmm3
vpaddq 192(%r8), %zmm3, %zmm3
vpaddq %zmm17, %zmm3, %zmm3
vpsrlq $52, %zmm3, %zmm17
vpandq %zmm16, %zmm3, %zmm3
vmovdqa64 256(%rdx), %zmm4
vpaddq 256(%r8), %zmm4, %zmm4
vpaddq %zmm17, %zmm4, %zmm4
vpsrlq $52, %zmm4, %zmm17
vpandq %zmm16, %zmm4, %zmm4
vmovdqa64 320(%rdx), %zmm5
vpaddq 320(%r8), %zmm5, %zmm5
vpaddq %zmm17, %zmm5, %zmm5
vpsrlq $52, %zmm5, %zmm17
vpandq %zmm16, %zmm5, %zmm5
vmovdqa64 384(%rdx), %zmm6
vpaddq 384(%r8), %zmm6, %zmm6
vpaddq %zmm17, %zmm6, %zmm6
vpsrlq $52, %zmm6, %zmm17
vpandq %zmm16, %zmm6, %zmm6
vmovdqa64 448(%rdx), %zmm7
vpaddq 448(%r8), %zmm7, %zmm7
vpaddq %zmm17, %zmm7, %zmm7
vpxorq %zmm18, %zmm18, %zmm18
vpsubq (%rax){1to8}, %zmm0, %zmm8
vpsrlq $63, %zmm8, %zmm17
vpsubq 8(%rax){1to8}, %zmm1, %zmm9
vpsubq %zmm17, %zmm9, %zmm9
vpsrlq $63, %zmm9, %zmm17
vpsubq 16(%rax){1to8}, %zmm2, %zmm10
vpsubq %zmm17, %zmm10, %zmm10
vpsrlq $63, %zmm10, %zmm17
vpsubq 24(%rax){1to8}, %zmm3, %zmm11
vpsubq %zmm17, %zmm11, %zmm11
vpsrlq $63, %zmm11, %zmm17
vpsubq 32(%rax){1to8}, %zmm4, %zmm12
vpsubq %zmm17, %zmm12, %zmm12
vpsrlq $63, %zmm12, %zmm17
vpsubq 40(%rax){1to8}, %zmm5, %zmm13
vpsubq %zmm17, %zmm13, %zmm13
vpsrlq $63, %zmm13, %zmm17
vpsubq 48(%rax){1to8}, %zmm6, %zmm14
vpsubq %zmm17, %zmm14, %zmm14
vpsrlq $63, %zmm14, %zmm17
vpsubq 56(%rax){1to8}, %zmm7, %zmm15
vpsubq %zmm17, %zmm15, %zmm15
vpsrlq $63, %zmm15, %zmm17
vpcmpeqq %zmm18, %zmm17, %k1
vpandq %zmm16, %zmm8, %zmm0{%k1}
vpandq %zmm16, %zmm9, %zmm1{%k1}
vpandq %zmm16, %zmm10, %zmm2{%k1}
vpandq %zmm16, %zmm11, %zmm3{%k1}
vpandq %zmm16, %zmm12, %zmm4{%k1}
vpandq %zmm16, %zmm13, %zmm5{%k1}
vpandq %zmm16, %zmm14, %zmm6{%k1}
vpandq %zmm16, %zmm15, %zmm7{%k1}
vmovdqa64 %zmm0, (%r10)
vmovdqa64 %zmm1, 64(%r10)
vmovdqa64 %zmm2, 128(%r10)
vmovdqa64 %zmm3, 192(%r10)
vmovdqa64 %zmm4, 256(%r10)
vmovdqa64 %zmm5, 320(%r10)
vmovdqa64 %zmm6, 384(%r10)
vmovdqa64 %zmm7, 448(%r10)
vmovups (%rsp), %xmm5
vmovups 16(%rsp), %xmm6
vmovups 32(%rsp), %xmm7
vmovups 48(%rsp), %xmm8
vmovups 64(%rsp), %xmm9
vmovups 80(%rsp), %xmm10
vmovups 96(%rsp), %xmm11
vmovups 112(%rsp), %xmm12
vmovups 128(%rsp), %xmm13
vmovups 144(%rsp), %xmm14
vmovups 160(%rsp), %xmm15
vzeroupper
add $184, %rsp
ret
SIZE(mcl_c5_vadd)
.global PRE(mcl_c5_vsub)
PRE(mcl_c5_vsub):
TYPE(mcl_c5_vsub)
sub $184, %rsp
vmovups %xmm5, (%rsp)
vmovups %xmm6, 16(%rsp)
vmovups %xmm7, 32(%rsp)
vmovups %xmm8, 48(%rsp)
vmovups %xmm9, 64(%rsp)
vmovups %xmm10, 80(%rsp)
vmovups %xmm11, 96(%rsp)
vmovups %xmm12, 112(%rsp)
vmovups %xmm13, 128(%rsp)
vmovups %xmm14, 144(%rsp)
vmovups %xmm15, 160(%rsp)
mov $4503599627370495, %rax
vpbroadcastq %rax, %zmm16
lea PRE(p)(%rip), %rax
vmovdqa64 (%rdx), %zmm0
vpsubq (%r8), %zmm0, %zmm0
vpsrlq $63, %zmm0, %zmm17
vpandq %zmm16, %zmm0, %zmm0
vmovdqa64 64(%rdx), %zmm1
vpsubq 64(%r8), %zmm1, %zmm1
vpsubq %zmm17, %zmm1, %zmm1
vpsrlq $63, %zmm1, %zmm17
vpandq %zmm16, %zmm1, %zmm1
vmovdqa64 128(%rdx), %zmm2
vpsubq 128(%r8), %zmm2, %zmm2
vpsubq %zmm17, %zmm2, %zmm2
vpsrlq $63, %zmm2, %zmm17
vpandq %zmm16, %zmm2, %zmm2
vmovdqa64 192(%rdx), %zmm3
vpsubq 192(%r8), %zmm3, %zmm3
vpsubq %zmm17, %zmm3, %zmm3
vpsrlq $63, %zmm3, %zmm17
vpandq %zmm16, %zmm3, %zmm3
vmovdqa64 256(%rdx), %zmm4
vpsubq 256(%r8), %zmm4, %zmm4
vpsubq %zmm17, %zmm4, %zmm4
vpsrlq $63, %zmm4, %zmm17
vpandq %zmm16, %zmm4, %zmm4
vmovdqa64 320(%rdx), %zmm5
vpsubq 320(%r8), %zmm5, %zmm5
vpsubq %zmm17, %zmm5, %zmm5
vpsrlq $63, %zmm5, %zmm17
vpandq %zmm16, %zmm5, %zmm5
vmovdqa64 384(%rdx), %zmm6
vpsubq 384(%r8), %zmm6, %zmm6
vpsubq %zmm17, %zmm6, %zmm6
vpsrlq $63, %zmm6, %zmm17
vpandq %zmm16, %zmm6, %zmm6
vmovdqa64 448(%rdx), %zmm7
vpsubq 448(%r8), %zmm7, %zmm7
vpsubq %zmm17, %zmm7, %zmm7
vpsrlq $63, %zmm7, %zmm17
vpandq %zmm16, %zmm7, %zmm7
vpxorq %zmm8, %zmm8, %zmm8
vpcmpgtq %zmm8, %zmm17, %k1
vpaddq (%rax){1to8}, %zmm0, %zmm8
vpsrlq $52, %zmm8, %zmm17
vpandq %zmm16, %zmm8, %zmm0{%k1}
vpaddq 8(%rax){1to8}, %zmm1, %zmm9
vpaddq %zmm17, %zmm9, %zmm9
vpsrlq $52, %zmm9, %zmm17
vpandq %zmm16, %zmm9, %zmm1{%k1}
vpaddq 16(%rax){1to8}, %zmm2, %zmm10
vpaddq %zmm17, %zmm10, %zmm10
vpsrlq $52, %zmm10, %zmm17
vpandq %zmm16, %zmm10, %zmm2{%k1}
vpaddq 24(%rax){1to8}, %zmm3, %zmm11
vpaddq %zmm17, %zmm11, %zmm11
vpsrlq $52, %zmm11, %zmm17
vpandq %zmm16, %zmm11, %zmm3{%k1}
vpaddq 32(%rax){1to8}, %zmm4, %zmm12
vpaddq %zmm17, %zmm12, %zmm12
vpsrlq $52, %zmm12, %zmm17
vpandq %zmm16, %zmm12, %zmm4{%k1}
vpaddq 40(%rax){1to8}, %zmm5, %zmm13
vpaddq %zmm17, %zmm13, %zmm13
vpsrlq $52, %zmm13, %zmm17
vpandq %zmm16, %zmm13, %zmm5{%k1}
vpaddq 48(%rax){1to8}, %zmm6, %zmm14
vpaddq %zmm17, %zmm14, %zmm14
vpsrlq $52, %zmm14, %zmm17
vpandq %zmm16, %zmm14, %zmm6{%k1}
vpaddq 56(%rax){1to8}, %zmm7, %zmm15
vpaddq %zmm17, %zmm15, %zmm15
vpandq %zmm16, %zmm15, %zmm7{%k1}
vmovdqa64 %zmm0, (%rcx)
vmovdqa64 %zmm1, 64(%rcx)
vmovdqa64 %zmm2, 128(%rcx)
vmovdqa64 %zmm3, 192(%rcx)
vmovdqa64 %zmm4, 256(%rcx)
vmovdqa64 %zmm5, 320(%rcx)
vmovdqa64 %zmm6, 384(%rcx)
vmovdqa64 %zmm7, 448(%rcx)
vmovups (%rsp), %xmm5
vmovups 16(%rsp), %xmm6
vmovups 32(%rsp), %xmm7
vmovups 48(%rsp), %xmm8
vmovups 64(%rsp), %xmm9
vmovups 80(%rsp), %xmm10
vmovups 96(%rsp), %xmm11
vmovups 112(%rsp), %xmm12
vmovups 128(%rsp), %xmm13
vmovups 144(%rsp), %xmm14
vmovups 160(%rsp), %xmm15
vzeroupper
add $184, %rsp
ret
SIZE(mcl_c5_vsub)
.global PRE(mcl_c5_vmul)
PRE(mcl_c5_vmul):
TYPE(mcl_c5_vmul)
sub $184, %rsp
vmovups %xmm5, (%rsp)
vmovups %xmm6, 16(%rsp)
vmovups %xmm7, 32(%rsp)
vmovups %xmm8, 48(%rsp)
vmovups %xmm9, 64(%rsp)
vmovups %xmm10, 80(%rsp)
vmovups %xmm11, 96(%rsp)
vmovups %xmm12, 112(%rsp)
vmovups %xmm13, 128(%rsp)
vmovups %xmm14, 144(%rsp)
vmovups %xmm15, 160(%rsp)
mov %rcx, %r10
lea PRE(ap)(%rip), %rax
vmovdqa64 (%rax), %zmm20
vmovdqa64 64(%rax), %zmm21
vmovdqa64 128(%rax), %zmm22
vmovdqa64 192(%rax), %zmm23
vmovdqa64 256(%rax), %zmm24
vmovdqa64 320(%rax), %zmm25
vmovdqa64 384(%rax), %zmm26
vmovdqa64 448(%rax), %zmm27
mov $4503599627370495, %rax
vpbroadcastq %rax, %zmm9
lea PRE(rp)(%rip), %r9
vmovdqa64 (%r8), %zmm11
add $64, %r8
vpxorq %zmm0, %zmm0, %zmm0
vpmadd52luq (%rdx), %zmm11, %zmm0
vpxorq %zmm10, %zmm10, %zmm10
vpmadd52huq (%rdx), %zmm11, %zmm10
vmovdqa64 %zmm10, %zmm1
vpmadd52luq 64(%rdx), %zmm11, %zmm1
vpxorq %zmm10, %zmm10, %zmm10
vpmadd52huq 64(%rdx), %zmm11, %zmm10
vmovdqa64 %zmm10, %zmm2
vpmadd52luq 128(%rdx), %zmm11, %zmm2
vpxorq %zmm10, %zmm10, %zmm10
vpmadd52huq 128(%rdx), %zmm11, %zmm10
vmovdqa64 %zmm10, %zmm3
vpmadd52luq 192(%rdx), %zmm11, %zmm3
vpxorq %zmm10, %zmm10, %zmm10
vpmadd52huq 192(%rdx), %zmm11, %zmm10
vmovdqa64 %zmm10, %zmm4
vpmadd52luq 256(%rdx), %zmm11, %zmm4
vpxorq %zmm10, %zmm10, %zmm10
vpmadd52huq 256(%rdx), %zmm11, %zmm10
vmovdqa64 %zmm10, %zmm5
vpmadd52luq 320(%rdx), %zmm11, %zmm5
vpxorq %zmm10, %zmm10, %zmm10
vpmadd52huq 320(%rdx), %zmm11, %zmm10
vmovdqa64 %zmm10, %zmm6
vpmadd52luq 384(%rdx), %zmm11, %zmm6
vpxorq %zmm10, %zmm10, %zmm10
vpmadd52huq 384(%rdx), %zmm11, %zmm10
vmovdqa64 %zmm10, %zmm7
vpmadd52luq 448(%rdx), %zmm11, %zmm7
vpxorq %zmm8, %zmm8, %zmm8
vpmadd52huq 448(%rdx), %zmm11, %zmm8
vpxorq %zmm11, %zmm11, %zmm11
vpmadd52luq (%r9){1to8}, %zmm0, %zmm11
vpmadd52luq %zmm20, %zmm11, %zmm0
vpmadd52huq %zmm20, %zmm11, %zmm1
vpmadd52luq %zmm21, %zmm11, %zmm1
vpmadd52huq %zmm21, %zmm11, %zmm2
vpmadd52luq %zmm22, %zmm11, %zmm2
vpmadd52huq %zmm22, %zmm11, %zmm3
vpmadd52luq %zmm23, %zmm11, %zmm3
vpmadd52huq %zmm23, %zmm11, %zmm4
vpmadd52luq %zmm24, %zmm11, %zmm4
vpmadd52huq %zmm24, %zmm11, %zmm5
vpmadd52luq %zmm25, %zmm11, %zmm5
vpmadd52huq %zmm25, %zmm11, %zmm6
vpmadd52luq %zmm26, %zmm11, %zmm6
vpmadd52huq %zmm26, %zmm11, %zmm7
vpmadd52luq %zmm27, %zmm11, %zmm7
vpmadd52huq %zmm27, %zmm11, %zmm8
mov $7, %ecx
.balign 32
.L1:
mov %rdx, %rax
vmovdqa64 (%r8), %zmm11
add $64, %r8
vmovdqa64 %zmm0, %zmm10
vmovdqa64 %zmm1, %zmm0
vmovdqa64 %zmm2, %zmm1
vmovdqa64 %zmm3, %zmm2
vmovdqa64 %zmm4, %zmm3
vmovdqa64 %zmm5, %zmm4
vmovdqa64 %zmm6, %zmm5
vmovdqa64 %zmm7, %zmm6
vmovdqa64 %zmm8, %zmm7
vpxorq %zmm8, %zmm8, %zmm8
vpmadd52luq (%rax), %zmm11, %zmm0
vpmadd52huq (%rax), %zmm11, %zmm1
vpmadd52luq 64(%rax), %zmm11, %zmm1
vpmadd52huq 64(%rax), %zmm11, %zmm2
vpmadd52luq 128(%rax), %zmm11, %zmm2
vpmadd52huq 128(%rax), %zmm11, %zmm3
vpmadd52luq 192(%rax), %zmm11, %zmm3
vpmadd52huq 192(%rax), %zmm11, %zmm4
vpmadd52luq 256(%rax), %zmm11, %zmm4
vpmadd52huq 256(%rax), %zmm11, %zmm5
vpmadd52luq 320(%rax), %zmm11, %zmm5
vpmadd52huq 320(%rax), %zmm11, %zmm6
vpmadd52luq 384(%rax), %zmm11, %zmm6
vpmadd52huq 384(%rax), %zmm11, %zmm7
vpmadd52luq 448(%rax), %zmm11, %zmm7
vpmadd52huq 448(%rax), %zmm11, %zmm8
vpsrlq $52, %zmm10, %zmm11
vpaddq %zmm11, %zmm0, %zmm0
vpxorq %zmm11, %zmm11, %zmm11
vpmadd52luq (%r9){1to8}, %zmm0, %zmm11
vpmadd52luq %zmm20, %zmm11, %zmm0
vpmadd52huq %zmm20, %zmm11, %zmm1
vpmadd52luq %zmm21, %zmm11, %zmm1
vpmadd52huq %zmm21, %zmm11, %zmm2
vpmadd52luq %zmm22, %zmm11, %zmm2
vpmadd52huq %zmm22, %zmm11, %zmm3
vpmadd52luq %zmm23, %zmm11, %zmm3
vpmadd52huq %zmm23, %zmm11, %zmm4
vpmadd52luq %zmm24, %zmm11, %zmm4
vpmadd52huq %zmm24, %zmm11, %zmm5
vpmadd52luq %zmm25, %zmm11, %zmm5
vpmadd52huq %zmm25, %zmm11, %zmm6
vpmadd52luq %zmm26, %zmm11, %zmm6
vpmadd52huq %zmm26, %zmm11, %zmm7
vpmadd52luq %zmm27, %zmm11, %zmm7
vpmadd52huq %zmm27, %zmm11, %zmm8
dec %ecx
jnz .L1
vpsrlq $52, %zmm0, %zmm11
vpaddq %zmm11, %zmm1, %zmm1
vpandq %zmm9, %zmm0, %zmm0
vpsrlq $52, %zmm1, %zmm11
vpaddq %zmm11, %zmm2, %zmm2
vpandq %zmm9, %zmm1, %zmm1
vpsrlq $52, %zmm2, %zmm11
vpaddq %zmm11, %zmm3, %zmm3
vpandq %zmm9, %zmm2, %zmm2
vpsrlq $52, %zmm3, %zmm11
vpaddq %zmm11, %zmm4, %zmm4
vpandq %zmm9, %zmm3, %zmm3
vpsrlq $52, %zmm4, %zmm11
vpaddq %zmm11, %zmm5, %zmm5
vpandq %zmm9, %zmm4, %zmm4
vpsrlq $52, %zmm5, %zmm11
vpaddq %zmm11, %zmm6, %zmm6
vpandq %zmm9, %zmm5, %zmm5
vpsrlq $52, %zmm6, %zmm11
vpaddq %zmm11, %zmm7, %zmm7
vpandq %zmm9, %zmm6, %zmm6
vpsrlq $52, %zmm7, %zmm11
vpaddq %zmm11, %zmm8, %zmm8
vpandq %zmm9, %zmm7, %zmm7
vpxorq %zmm10, %zmm10, %zmm10
vpsubq %zmm20, %zmm1, %zmm12
vpsrlq $63, %zmm12, %zmm11
vpsubq %zmm21, %zmm2, %zmm13
vpsubq %zmm11, %zmm13, %zmm13
vpsrlq $63, %zmm13, %zmm11
vpsubq %zmm22, %zmm3, %zmm14
vpsubq %zmm11, %zmm14, %zmm14
vpsrlq $63, %zmm14, %zmm11
vpsubq %zmm23, %zmm4, %zmm15
vpsubq %zmm11, %zmm15, %zmm15
vpsrlq $63, %zmm15, %zmm11
vpsubq %zmm24, %zmm5, %zmm16
vpsubq %zmm11, %zmm16, %zmm16
vpsrlq $63, %zmm16, %zmm11
vpsubq %zmm25, %zmm6, %zmm17
vpsubq %zmm11, %zmm17, %zmm17
vpsrlq $63, %zmm17, %zmm11
vpsubq %zmm26, %zmm7, %zmm18
vpsubq %zmm11, %zmm18, %zmm18
vpsrlq $63, %zmm18, %zmm11
vpsubq %zmm27, %zmm8, %zmm19
vpsubq %zmm11, %zmm19, %zmm19
vpsrlq $63, %zmm19, %zmm11
vpcmpeqq %zmm10, %zmm11, %k1
vpandq %zmm9, %zmm12, %zmm1{%k1}
vpandq %zmm9, %zmm13, %zmm2{%k1}
vpandq %zmm9, %zmm14, %zmm3{%k1}
vpandq %zmm9, %zmm15, %zmm4{%k1}
vpandq %zmm9, %zmm16, %zmm5{%k1}
vpandq %zmm9, %zmm17, %zmm6{%k1}
vpandq %zmm9, %zmm18, %zmm7{%k1}
vpandq %zmm9, %zmm19, %zmm8{%k1}
vmovdqa64 %zmm1, (%r10)
vmovdqa64 %zmm2, 64(%r10)
vmovdqa64 %zmm3, 128(%r10)
vmovdqa64 %zmm4, 192(%r10)
vmovdqa64 %zmm5, 256(%r10)
vmovdqa64 %zmm6, 320(%r10)
vmovdqa64 %zmm7, 384(%r10)
vmovdqa64 %zmm8, 448(%r10)
vmovups (%rsp), %xmm5
vmovups 16(%rsp), %xmm6
vmovups 32(%rsp), %xmm7
vmovups 48(%rsp), %xmm8
vmovups 64(%rsp), %xmm9
vmovups 80(%rsp), %xmm10
vmovups 96(%rsp), %xmm11
vmovups 112(%rsp), %xmm12
vmovups 128(%rsp), %xmm13
vmovups 144(%rsp), %xmm14
vmovups 160(%rsp), %xmm15
vzeroupper
add $184, %rsp
ret
SIZE(mcl_c5_vmul)
.global PRE(mcl_c5_vsqr)
PRE(mcl_c5_vsqr):
TYPE(mcl_c5_vsqr)
sub $184, %rsp
vmovups %xmm5, (%rsp)
vmovups %xmm6, 16(%rsp)
vmovups %xmm7, 32(%rsp)
vmovups %xmm8, 48(%rsp)
vmovups %xmm9, 64(%rsp)
vmovups %xmm10, 80(%rsp)
vmovups %xmm11, 96(%rsp)
vmovups %xmm12, 112(%rsp)
vmovups %xmm13, 128(%rsp)
vmovups %xmm14, 144(%rsp)
vmovups %xmm15, 160(%rsp)
mov %rcx, %r10
vmovdqa64 (%rdx), %zmm19
vmovdqa64 64(%rdx), %zmm20
vmovdqa64 128(%rdx), %zmm21
vmovdqa64 192(%rdx), %zmm22
vmovdqa64 256(%rdx), %zmm23
vmovdqa64 320(%rdx), %zmm24
vmovdqa64 384(%rdx), %zmm25
vmovdqa64 448(%rdx), %zmm26
vpxorq %zmm0, %zmm0, %zmm0
vpmadd52luq %zmm19, %zmm19, %zmm0
vpxorq %zmm1, %zmm1, %zmm1
vpxorq %zmm2, %zmm2, %zmm2
vpmadd52luq %zmm19, %zmm20, %zmm1
vpmadd52huq %zmm19, %zmm20, %zmm2
vpxorq %zmm3, %zmm3, %zmm3
vpxorq %zmm4, %zmm4, %zmm4
vpmadd52luq %zmm20, %zmm21, %zmm3
vpmadd52huq %zmm20, %zmm21, %zmm4
vpxorq %zmm5, %zmm5, %zmm5
vpxorq %zmm6, %zmm6, %zmm6
vpmadd52luq %zmm21, %zmm22, %zmm5
vpmadd52huq %zmm21, %zmm22, %zmm6
vpxorq %zmm7, %zmm7, %zmm7
vpxorq %zmm8, %zmm8, %zmm8
vpmadd52luq %zmm22, %zmm23, %zmm7
vpmadd52huq %zmm22, %zmm23, %zmm8
vpxorq %zmm9, %zmm9, %zmm9
vpxorq %zmm10, %zmm10, %zmm10
vpmadd52luq %zmm23, %zmm24, %zmm9
vpmadd52huq %zmm23, %zmm24, %zmm10
vpxorq %zmm11, %zmm11, %zmm11
vpxorq %zmm12, %zmm12, %zmm12
vpmadd52luq %zmm24, %zmm25, %zmm11
vpmadd52huq %zmm24, %zmm25, %zmm12
vpxorq %zmm13, %zmm13, %zmm13
vpxorq %zmm14, %zmm14, %zmm14
vpmadd52luq %zmm25, %zmm26, %zmm13
vpmadd52huq %zmm25, %zmm26, %zmm14
vpmadd52luq %zmm19, %zmm21, %zmm2
vpmadd52huq %zmm19, %zmm21, %zmm3
vpmadd52luq %zmm20, %zmm22, %zmm4
vpmadd52huq %zmm20, %zmm22, %zmm5
vpmadd52luq %zmm21, %zmm23, %zmm6
vpmadd52huq %zmm21, %zmm23, %zmm7
vpmadd52luq %zmm22, %zmm24, %zmm8
vpmadd52huq %zmm22, %zmm24, %zmm9
vpmadd52luq %zmm23, %zmm25, %zmm10
vpmadd52huq %zmm23, %zmm25, %zmm11
vpmadd52luq %zmm24, %zmm26, %zmm12
vpmadd52huq %zmm24, %zmm26, %zmm13
vpmadd52luq %zmm19, %zmm22, %zmm3
vpmadd52huq %zmm19, %zmm22, %zmm4
vpmadd52luq %zmm20, %zmm23, %zmm5
vpmadd52huq %zmm20, %zmm23, %zmm6
vpmadd52luq %zmm21, %zmm24, %zmm7
vpmadd52huq %zmm21, %zmm24, %zmm8
vpmadd52luq %zmm22, %zmm25, %zmm9
vpmadd52huq %zmm22, %zmm25, %zmm10
vpmadd52luq %zmm23, %zmm26, %zmm11
vpmadd52huq %zmm23, %zmm26, %zmm12
vpmadd52luq %zmm19, %zmm23, %zmm4
vpmadd52huq %zmm19, %zmm23, %zmm5
vpmadd52luq %zmm20, %zmm24, %zmm6
vpmadd52huq %zmm20, %zmm24, %zmm7
vpmadd52luq %zmm21, %zmm25, %zmm8
vpmadd52huq %zmm21, %zmm25, %zmm9
vpmadd52luq %zmm22, %zmm26, %zmm10
vpmadd52huq %zmm22, %zmm26, %zmm11
vpmadd52luq %zmm19, %zmm24, %zmm5
vpmadd52huq %zmm19, %zmm24, %zmm6
vpmadd52luq %zmm20, %zmm25, %zmm7
vpmadd52huq %zmm20, %zmm25, %zmm8
vpmadd52luq %zmm21, %zmm26, %zmm9
vpmadd52huq %zmm21, %zmm26, %zmm10
vpmadd52luq %zmm19, %zmm25, %zmm6
vpmadd52huq %zmm19, %zmm25, %zmm7
vpmadd52luq %zmm20, %zmm26, %zmm8
vpmadd52huq %zmm20, %zmm26, %zmm9
vpmadd52luq %zmm19, %zmm26, %zmm7
vpmadd52huq %zmm19, %zmm26, %zmm8
vpaddq %zmm1, %zmm1, %zmm1
vpaddq %zmm2, %zmm2, %zmm2
vpaddq %zmm3, %zmm3, %zmm3
vpaddq %zmm4, %zmm4, %zmm4
vpaddq %zmm5, %zmm5, %zmm5
vpaddq %zmm6, %zmm6, %zmm6
vpaddq %zmm7, %zmm7, %zmm7
vpaddq %zmm8, %zmm8, %zmm8
vpaddq %zmm9, %zmm9, %zmm9
vpaddq %zmm10, %zmm10, %zmm10
vpaddq %zmm11, %zmm11, %zmm11
vpaddq %zmm12, %zmm12, %zmm12
vpaddq %zmm13, %zmm13, %zmm13
vpaddq %zmm14, %zmm14, %zmm14
vpmadd52huq %zmm19, %zmm19, %zmm1
vpmadd52luq %zmm20, %zmm20, %zmm2
vpmadd52huq %zmm20, %zmm20, %zmm3
vpmadd52luq %zmm21, %zmm21, %zmm4
vpmadd52huq %zmm21, %zmm21, %zmm5
vpmadd52luq %zmm22, %zmm22, %zmm6
vpmadd52huq %zmm22, %zmm22, %zmm7
vpmadd52luq %zmm23, %zmm23, %zmm8
vpmadd52huq %zmm23, %zmm23, %zmm9
vpmadd52luq %zmm24, %zmm24, %zmm10
vpmadd52huq %zmm24, %zmm24, %zmm11
vpmadd52luq %zmm25, %zmm25, %zmm12
vpmadd52huq %zmm25, %zmm25, %zmm13
vpmadd52luq %zmm26, %zmm26, %zmm14
vpxorq %zmm15, %zmm15, %zmm15
vpmadd52huq %zmm26, %zmm26, %zmm15
lea PRE(ap)(%rip), %rax
vmovdqa64 (%rax), %zmm19
vmovdqa64 64(%rax), %zmm20
vmovdqa64 128(%rax), %zmm21
vmovdqa64 192(%rax), %zmm22
vmovdqa64 256(%rax), %zmm23
vmovdqa64 320(%rax), %zmm24
vmovdqa64 384(%rax), %zmm25
vmovdqa64 448(%rax), %zmm26
mov $4503599627370495, %rax
vpbroadcastq %rax, %zmm18
vpbroadcastq PRE(rp)(%rip), %zmm27
vpxorq %zmm16, %zmm16, %zmm16
vpmadd52luq %zmm27, %zmm0, %zmm16
vpmadd52luq %zmm19, %zmm16, %zmm0
vpmadd52huq %zmm19, %zmm16, %zmm1
vpmadd52luq %zmm20, %zmm16, %zmm1
vpmadd52huq %zmm20, %zmm16, %zmm2
vpmadd52luq %zmm21, %zmm16, %zmm2
vpmadd52huq %zmm21, %zmm16, %zmm3
vpmadd52luq %zmm22, %zmm16, %zmm3
vpmadd52huq %zmm22, %zmm16, %zmm4
vpmadd52luq %zmm23, %zmm16, %zmm4
vpmadd52huq %zmm23, %zmm16, %zmm5
vpmadd52luq %zmm24, %zmm16, %zmm5
vpmadd52huq %zmm24, %zmm16, %zmm6
vpmadd52luq %zmm25, %zmm16, %zmm6
vpmadd52huq %zmm25, %zmm16, %zmm7
vpmadd52luq %zmm26, %zmm16, %zmm7
vpmadd52huq %zmm26, %zmm16, %zmm8
vpsrlq $52, %zmm0, %zmm16
vpaddq %zmm16, %zmm1, %zmm1
vpxorq %zmm16, %zmm16, %zmm16
vpmadd52luq %zmm27, %zmm1, %zmm16
vpmadd52luq %zmm19, %zmm16, %zmm1
vpmadd52huq %zmm19, %zmm16, %zmm2
vpmadd52luq %zmm20, %zmm16, %zmm2
vpmadd52huq %zmm20, %zmm16, %zmm3
vpmadd52luq %zmm21, %zmm16, %zmm3
vpmadd52huq %zmm21, %zmm16, %zmm4
vpmadd52luq %zmm22, %zmm16, %zmm4
vpmadd52huq %zmm22, %zmm16, %zmm5
vpmadd52luq %zmm23, %zmm16, %zmm5
vpmadd52huq %zmm23, %zmm16, %zmm6
vpmadd52luq %zmm24, %zmm16, %zmm6
vpmadd52huq %zmm24, %zmm16, %zmm7
vpmadd52luq %zmm25, %zmm16, %zmm7
vpmadd52huq %zmm25, %zmm16, %zmm8
vpmadd52luq %zmm26, %zmm16, %zmm8
vpmadd52huq %zmm26, %zmm16, %zmm9
vpsrlq $52, %zmm1, %zmm16
vpaddq %zmm16, %zmm2, %zmm2
vpxorq %zmm16, %zmm16, %zmm16
vpmadd52luq %zmm27, %zmm2, %zmm16
vpmadd52luq %zmm19, %zmm16, %zmm2
vpmadd52huq %zmm19, %zmm16, %zmm3
vpmadd52luq %zmm20, %zmm16, %zmm3
vpmadd52huq %zmm20, %zmm16, %zmm4
vpmadd52luq %zmm21, %zmm16, %zmm4
vpmadd52huq %zmm21, %zmm16, %zmm5
vpmadd52luq %zmm22, %zmm16, %zmm5
vpmadd52huq %zmm22, %zmm16, %zmm6
vpmadd52luq %zmm23, %zmm16, %zmm6
vpmadd52huq %zmm23, %zmm16, %zmm7
vpmadd52luq %zmm24, %zmm16, %zmm7
vpmadd52huq %zmm24, %zmm16, %zmm8
vpmadd52luq %zmm25, %zmm16, %zmm8
vpmadd52huq %zmm25, %zmm16, %zmm9
vpmadd52luq %zmm26, %zmm16, %zmm9
vpmadd52huq %zmm26, %zmm16, %zmm10
vpsrlq $52, %zmm2, %zmm16
vpaddq %zmm16, %zmm3, %zmm3
vpxorq %zmm16, %zmm16, %zmm16
vpmadd52luq %zmm27, %zmm3, %zmm16
vpmadd52luq %zmm19, %zmm16, %zmm3
vpmadd52huq %zmm19, %zmm16, %zmm4
vpmadd52luq %zmm20, %zmm16, %zmm4
vpmadd52huq %zmm20, %zmm16, %zmm5
vpmadd52luq %zmm21, %zmm16, %zmm5
vpmadd52huq %zmm21, %zmm16, %zmm6
vpmadd52luq %zmm22, %zmm16, %zmm6
vpmadd52huq %zmm22, %zmm16, %zmm7
vpmadd52luq %zmm23, %zmm16, %zmm7
vpmadd52huq %zmm23, %zmm16, %zmm8
vpmadd52luq %zmm24, %zmm16, %zmm8
vpmadd52huq %zmm24, %zmm16, %zmm9
vpmadd52luq %zmm25, %zmm16, %zmm9
vpmadd52huq %zmm25, %zmm16, %zmm10
vpmadd52luq %zmm26, %zmm16, %zmm10
vpmadd52huq %zmm26, %zmm16, %zmm11
vpsrlq $52, %zmm3, %zmm16
vpaddq %zmm16, %zmm4, %zmm4
vpxorq %zmm16, %zmm16, %zmm16
vpmadd52luq %zmm27, %zmm4, %zmm16
vpmadd52luq %zmm19, %zmm16, %zmm4
vpmadd52huq %zmm19, %zmm16, %zmm5
vpmadd52luq %zmm20, %zmm16, %zmm5
vpmadd52huq %zmm20, %zmm16, %zmm6
vpmadd52luq %zmm21, %zmm16, %zmm6
vpmadd52huq %zmm21, %zmm16, %zmm7
vpmadd52luq %zmm22, %zmm16, %zmm7
vpmadd52huq %zmm22, %zmm16, %zmm8
vpmadd52luq %zmm23, %zmm16, %zmm8
vpmadd52huq %zmm23, %zmm16, %zmm9
vpmadd52luq %zmm24, %zmm16, %zmm9
vpmadd52huq %zmm24, %zmm16, %zmm10
vpmadd52luq %zmm25, %zmm16, %zmm10
vpmadd52huq %zmm25, %zmm16, %zmm11
vpmadd52luq %zmm26, %zmm16, %zmm11
vpmadd52huq %zmm26, %zmm16, %zmm12
vpsrlq $52, %zmm4, %zmm16
vpaddq %zmm16, %zmm5, %zmm5
vpxorq %zmm16, %zmm16, %zmm16
vpmadd52luq %zmm27, %zmm5, %zmm16
vpmadd52luq %zmm19, %zmm16, %zmm5
vpmadd52huq %zmm19, %zmm16, %zmm6
vpmadd52luq %zmm20, %zmm16, %zmm6
vpmadd52huq %zmm20, %zmm16, %zmm7
vpmadd52luq %zmm21, %zmm16, %zmm7
vpmadd52huq %zmm21, %zmm16, %zmm8
vpmadd52luq %zmm22, %zmm16, %zmm8
vpmadd52huq %zmm22, %zmm16, %zmm9
vpmadd52luq %zmm23, %zmm16, %zmm9
vpmadd52huq %zmm23, %zmm16, %zmm10
vpmadd52luq %zmm24, %zmm16, %zmm10
vpmadd52huq %zmm24, %zmm16, %zmm11
vpmadd52luq %zmm25, %zmm16, %zmm11
vpmadd52huq %zmm25, %zmm16, %zmm12
vpmadd52luq %zmm26, %zmm16, %zmm12
vpmadd52huq %zmm26, %zmm16, %zmm13
vpsrlq $52, %zmm5, %zmm16
vpaddq %zmm16, %zmm6, %zmm6
vpxorq %zmm16, %zmm16, %zmm16
vpmadd52luq %zmm27, %zmm6, %zmm16
vpmadd52luq %zmm19, %zmm16, %zmm6
vpmadd52huq %zmm19, %zmm16, %zmm7
vpmadd52luq %zmm20, %zmm16, %zmm7
vpmadd52huq %zmm20, %zmm16, %zmm8
vpmadd52luq %zmm21, %zmm16, %zmm8
vpmadd52huq %zmm21, %zmm16, %zmm9
vpmadd52luq %zmm22, %zmm16, %zmm9
vpmadd52huq %zmm22, %zmm16, %zmm10
vpmadd52luq %zmm23, %zmm16, %zmm10
vpmadd52huq %zmm23, %zmm16, %zmm11
vpmadd52luq %zmm24, %zmm16, %zmm11
vpmadd52huq %zmm24, %zmm16, %zmm12
vpmadd52luq %zmm25, %zmm16, %zmm12
vpmadd52huq %zmm25, %zmm16, %zmm13
vpmadd52luq %zmm26, %zmm16, %zmm13
vpmadd52huq %zmm26, %zmm16, %zmm14
vpsrlq $52, %zmm6, %zmm16
vpaddq %zmm16, %zmm7, %zmm7
vpxorq %zmm16, %zmm16, %zmm16
vpmadd52luq %zmm27, %zmm7, %zmm16
vpmadd52luq %zmm19, %zmm16, %zmm7
vpmadd52huq %zmm19, %zmm16, %zmm8
vpmadd52luq %zmm20, %zmm16, %zmm8
vpmadd52huq %zmm20, %zmm16, %zmm9
vpmadd52luq %zmm21, %zmm16, %zmm9
vpmadd52huq %zmm21, %zmm16, %zmm10
vpmadd52luq %zmm22, %zmm16, %zmm10
vpmadd52huq %zmm22, %zmm16, %zmm11
vpmadd52luq %zmm23, %zmm16, %zmm11
vpmadd52huq %zmm23, %zmm16, %zmm12
vpmadd52luq %zmm24, %zmm16, %zmm12
vpmadd52huq %zmm24, %zmm16, %zmm13
vpmadd52luq %zmm25, %zmm16, %zmm13
vpmadd52huq %zmm25, %zmm16, %zmm14
vpmadd52luq %zmm26, %zmm16, %zmm14
vpmadd52huq %zmm26, %zmm16, %zmm15
vpsrlq $52, %zmm7, %zmm16
vpaddq %zmm16, %zmm8, %zmm8
vpandq %zmm18, %zmm7, %zmm7
vpsrlq $52, %zmm8, %zmm16
vpaddq %zmm16, %zmm9, %zmm9
vpandq %zmm18, %zmm8, %zmm8
vpsrlq $52, %zmm9, %zmm16
vpaddq %zmm16, %zmm10, %zmm10
vpandq %zmm18, %zmm9, %zmm9
vpsrlq $52, %zmm10, %zmm16
vpaddq %zmm16, %zmm11, %zmm11
vpandq %zmm18, %zmm10, %zmm10
vpsrlq $52, %zmm11, %zmm16
vpaddq %zmm16, %zmm12, %zmm12
vpandq %zmm18, %zmm11, %zmm11
vpsrlq $52, %zmm12, %zmm16
vpaddq %zmm16, %zmm13, %zmm13
vpandq %zmm18, %zmm12, %zmm12
vpsrlq $52, %zmm13, %zmm16
vpaddq %zmm16, %zmm14, %zmm14
vpandq %zmm18, %zmm13, %zmm13
vpsrlq $52, %zmm14, %zmm16
vpaddq %zmm16, %zmm15, %zmm15
vpandq %zmm18, %zmm14, %zmm14
vpxorq %zmm27, %zmm27, %zmm27
vpsubq %zmm19, %zmm8, %zmm0
vpsrlq $63, %zmm0, %zmm16
vpsubq %zmm20, %zmm9, %zmm1
vpsubq %zmm16, %zmm1, %zmm1
vpsrlq $63, %zmm1, %zmm16
vpsubq %zmm21, %zmm10, %zmm2
vpsubq %zmm16, %zmm2, %zmm2
vpsrlq $63, %zmm2, %zmm16
vpsubq %zmm22, %zmm11, %zmm3
vpsubq %zmm16, %zmm3, %zmm3
vpsrlq $63, %zmm3, %zmm16
vpsubq %zmm23, %zmm12, %zmm4
vpsubq %zmm16, %zmm4, %zmm4
vpsrlq $63, %zmm4, %zmm16
vpsubq %zmm24, %zmm13, %zmm5
vpsubq %zmm16, %zmm5, %zmm5
vpsrlq $63, %zmm5, %zmm16
vpsubq %zmm25, %zmm14, %zmm6
vpsubq %zmm16, %zmm6, %zmm6
vpsrlq $63, %zmm6, %zmm16
vpsubq %zmm26, %zmm15, %zmm7
vpsubq %zmm16, %zmm7, %zmm7
vpsrlq $63, %zmm7, %zmm16
vpcmpeqq %zmm27, %zmm16, %k1
vpandq %zmm18, %zmm0, %zmm8{%k1}
vpandq %zmm18, %zmm1, %zmm9{%k1}
vpandq %zmm18, %zmm2, %zmm10{%k1}
vpandq %zmm18, %zmm3, %zmm11{%k1}
vpandq %zmm18, %zmm4, %zmm12{%k1}
vpandq %zmm18, %zmm5, %zmm13{%k1}
vpandq %zmm18, %zmm6, %zmm14{%k1}
vpandq %zmm18, %zmm7, %zmm15{%k1}
vmovdqa64 %zmm8, (%r10)
vmovdqa64 %zmm9, 64(%r10)
vmovdqa64 %zmm10, 128(%r10)
vmovdqa64 %zmm11, 192(%r10)
vmovdqa64 %zmm12, 256(%r10)
vmovdqa64 %zmm13, 320(%r10)
vmovdqa64 %zmm14, 384(%r10)
vmovdqa64 %zmm15, 448(%r10)
vmovups (%rsp), %xmm5
vmovups 16(%rsp), %xmm6
vmovups 32(%rsp), %xmm7
vmovups 48(%rsp), %xmm8
vmovups 64(%rsp), %xmm9
vmovups 80(%rsp), %xmm10
vmovups 96(%rsp), %xmm11
vmovups 112(%rsp), %xmm12
vmovups 128(%rsp), %xmm13
vmovups 144(%rsp), %xmm14
vmovups 160(%rsp), %xmm15
vzeroupper
add $184, %rsp
ret
SIZE(mcl_c5_vsqr)
.global PRE(mcl_c5_vaddA)
PRE(mcl_c5_vaddA):
TYPE(mcl_c5_vaddA)
sub $184, %rsp
vmovups %xmm5, (%rsp)
vmovups %xmm6, 16(%rsp)
vmovups %xmm7, 32(%rsp)
vmovups %xmm8, 48(%rsp)
vmovups %xmm9, 64(%rsp)
vmovups %xmm10, 80(%rsp)
vmovups %xmm11, 96(%rsp)
vmovups %xmm12, 112(%rsp)
vmovups %xmm13, 128(%rsp)
vmovups %xmm14, 144(%rsp)
vmovups %xmm15, 160(%rsp)
mov %rcx, %r10
mov $4503599627370495, %rax
vpbroadcastq %rax, %zmm16
lea PRE(p)(%rip), %rax
mov $2, %r9
.L2:
vmovdqa64 (%rdx), %zmm0
vpaddq (%r8), %zmm0, %zmm0
vpsrlq $52, %zmm0, %zmm17
vpandq %zmm16, %zmm0, %zmm0
vmovdqa64 128(%rdx), %zmm1
vpaddq 128(%r8), %zmm1, %zmm1
vpaddq %zmm17, %zmm1, %zmm1
vpsrlq $52, %zmm1, %zmm17
vpandq %zmm16, %zmm1, %zmm1
vmovdqa64 256(%rdx), %zmm2
vpaddq 256(%r8), %zmm2, %zmm2
vpaddq %zmm17, %zmm2, %zmm2
vpsrlq $52, %zmm2, %zmm17
vpandq %zmm16, %zmm2, %zmm2
vmovdqa64 384(%rdx), %zmm3
vpaddq 384(%r8), %zmm3, %zmm3
vpaddq %zmm17, %zmm3, %zmm3
vpsrlq $52, %zmm3, %zmm17
vpandq %zmm16, %zmm3, %zmm3
vmovdqa64 512(%rdx), %zmm4
vpaddq 512(%r8), %zmm4, %zmm4
vpaddq %zmm17, %zmm4, %zmm4
vpsrlq $52, %zmm4, %zmm17
vpandq %zmm16, %zmm4, %zmm4
vmovdqa64 640(%rdx), %zmm5
vpaddq 640(%r8), %zmm5, %zmm5
vpaddq %zmm17, %zmm5, %zmm5
vpsrlq $52, %zmm5, %zmm17
vpandq %zmm16, %zmm5, %zmm5
vmovdqa64 768(%rdx), %zmm6
vpaddq 768(%r8), %zmm6, %zmm6
vpaddq %zmm17, %zmm6, %zmm6
vpsrlq $52, %zmm6, %zmm17
vpandq %zmm16, %zmm6, %zmm6
vmovdqa64 896(%rdx), %zmm7
vpaddq 896(%r8), %zmm7, %zmm7
vpaddq %zmm17, %zmm7, %zmm7
vpxorq %zmm18, %zmm18, %zmm18
vpsubq (%rax){1to8}, %zmm0, %zmm8
vpsrlq $63, %zmm8, %zmm17
vpsubq 8(%rax){1to8}, %zmm1, %zmm9
vpsubq %zmm17, %zmm9, %zmm9
vpsrlq $63, %zmm9, %zmm17
vpsubq 16(%rax){1to8}, %zmm2, %zmm10
vpsubq %zmm17, %zmm10, %zmm10
vpsrlq $63, %zmm10, %zmm17
vpsubq 24(%rax){1to8}, %zmm3, %zmm11
vpsubq %zmm17, %zmm11, %zmm11
vpsrlq $63, %zmm11, %zmm17
vpsubq 32(%rax){1to8}, %zmm4, %zmm12
vpsubq %zmm17, %zmm12, %zmm12
vpsrlq $63, %zmm12, %zmm17
vpsubq 40(%rax){1to8}, %zmm5, %zmm13
vpsubq %zmm17, %zmm13, %zmm13
vpsrlq $63, %zmm13, %zmm17
vpsubq 48(%rax){1to8}, %zmm6, %zmm14
vpsubq %zmm17, %zmm14, %zmm14
vpsrlq $63, %zmm14, %zmm17
vpsubq 56(%rax){1to8}, %zmm7, %zmm15
vpsubq %zmm17, %zmm15, %zmm15
vpsrlq $63, %zmm15, %zmm17
vpcmpeqq %zmm18, %zmm17, %k1
vpandq %zmm16, %zmm8, %zmm0{%k1}
vpandq %zmm16, %zmm9, %zmm1{%k1}
vpandq %zmm16, %zmm10, %zmm2{%k1}
vpandq %zmm16, %zmm11, %zmm3{%k1}
vpandq %zmm16, %zmm12, %zmm4{%k1}
vpandq %zmm16, %zmm13, %zmm5{%k1}
vpandq %zmm16, %zmm14, %zmm6{%k1}
vpandq %zmm16, %zmm15, %zmm7{%k1}
vmovdqa64 %zmm0, (%r10)
vmovdqa64 %zmm1, 128(%r10)
vmovdqa64 %zmm2, 256(%r10)
vmovdqa64 %zmm3, 384(%r10)
vmovdqa64 %zmm4, 512(%r10)
vmovdqa64 %zmm5, 640(%r10)
vmovdqa64 %zmm6, 768(%r10)
vmovdqa64 %zmm7, 896(%r10)
add $64, %rdx
add $64, %r8
add $64, %r10
sub $1, %r9
jnz .L2
vmovups (%rsp), %xmm5
vmovups 16(%rsp), %xmm6
vmovups 32(%rsp), %xmm7
vmovups 48(%rsp), %xmm8
vmovups 64(%rsp), %xmm9
vmovups 80(%rsp), %xmm10
vmovups 96(%rsp), %xmm11
vmovups 112(%rsp), %xmm12
vmovups 128(%rsp), %xmm13
vmovups 144(%rsp), %xmm14
vmovups 160(%rsp), %xmm15
vzeroupper
add $184, %rsp
ret
SIZE(mcl_c5_vaddA)
.global PRE(mcl_c5_vsubA)
PRE(mcl_c5_vsubA):
TYPE(mcl_c5_vsubA)
sub $184, %rsp
vmovups %xmm5, (%rsp)
vmovups %xmm6, 16(%rsp)
vmovups %xmm7, 32(%rsp)
vmovups %xmm8, 48(%rsp)
vmovups %xmm9, 64(%rsp)
vmovups %xmm10, 80(%rsp)
vmovups %xmm11, 96(%rsp)
vmovups %xmm12, 112(%rsp)
vmovups %xmm13, 128(%rsp)
vmovups %xmm14, 144(%rsp)
vmovups %xmm15, 160(%rsp)
mov $4503599627370495, %rax
vpbroadcastq %rax, %zmm24
lea PRE(p)(%rip), %rax
vmovdqa64 (%rdx), %zmm0
vmovdqa64 64(%rdx), %zmm1
vpsubq (%r8), %zmm0, %zmm0
vpsubq 64(%r8), %zmm1, %zmm1
vpsrlq $63, %zmm0, %zmm25
vpsrlq $63, %zmm1, %zmm26
vpandq %zmm24, %zmm0, %zmm0
vpandq %zmm24, %zmm1, %zmm1
vmovdqa64 128(%rdx), %zmm2
vmovdqa64 192(%rdx), %zmm3
vpsubq 128(%r8), %zmm2, %zmm2
vpsubq 192(%r8), %zmm3, %zmm3
vpsubq %zmm25, %zmm2, %zmm2
vpsubq %zmm26, %zmm3, %zmm3
vpsrlq $63, %zmm2, %zmm25
vpsrlq $63, %zmm3, %zmm26
vpandq %zmm24, %zmm2, %zmm2
vpandq %zmm24, %zmm3, %zmm3
vmovdqa64 256(%rdx), %zmm4
vmovdqa64 320(%rdx), %zmm5
vpsubq 256(%r8), %zmm4, %zmm4
vpsubq 320(%r8), %zmm5, %zmm5
vpsubq %zmm25, %zmm4, %zmm4
vpsubq %zmm26, %zmm5, %zmm5
vpsrlq $63, %zmm4, %zmm25
vpsrlq $63, %zmm5, %zmm26
vpandq %zmm24, %zmm4, %zmm4
vpandq %zmm24, %zmm5, %zmm5
vmovdqa64 384(%rdx), %zmm6
vmovdqa64 448(%rdx), %zmm7
vpsubq 384(%r8), %zmm6, %zmm6
vpsubq 448(%r8), %zmm7, %zmm7
vpsubq %zmm25, %zmm6, %zmm6
vpsubq %zmm26, %zmm7, %zmm7
vpsrlq $63, %zmm6, %zmm25
vpsrlq $63, %zmm7, %zmm26
vpandq %zmm24, %zmm6, %zmm6
vpandq %zmm24, %zmm7, %zmm7
vmovdqa64 512(%rdx), %zmm8
vmovdqa64 576(%rdx), %zmm9
vpsubq 512(%r8), %zmm8, %zmm8
vpsubq 576(%r8), %zmm9, %zmm9
vpsubq %zmm25, %zmm8, %zmm8
vpsubq %zmm26, %zmm9, %zmm9
vpsrlq $63, %zmm8, %zmm25
vpsrlq $63, %zmm9, %zmm26
vpandq %zmm24, %zmm8, %zmm8
vpandq %zmm24, %zmm9, %zmm9
vmovdqa64 640(%rdx), %zmm10
vmovdqa64 704(%rdx), %zmm11
vpsubq 640(%r8), %zmm10, %zmm10
vpsubq 704(%r8), %zmm11, %zmm11
vpsubq %zmm25, %zmm10, %zmm10
vpsubq %zmm26, %zmm11, %zmm11
vpsrlq $63, %zmm10, %zmm25
vpsrlq $63, %zmm11, %zmm26
vpandq %zmm24, %zmm10, %zmm10
vpandq %zmm24, %zmm11, %zmm11
vmovdqa64 768(%rdx), %zmm12
vmovdqa64 832(%rdx), %zmm13
vpsubq 768(%r8), %zmm12, %zmm12
vpsubq 832(%r8), %zmm13, %zmm13
vpsubq %zmm25, %zmm12, %zmm12
vpsubq %zmm26, %zmm13, %zmm13
vpsrlq $63, %zmm12, %zmm25
vpsrlq $63, %zmm13, %zmm26
vpandq %zmm24, %zmm12, %zmm12
vpandq %zmm24, %zmm13, %zmm13
vmovdqa64 896(%rdx), %zmm14
vmovdqa64 960(%rdx), %zmm15
vpsubq 896(%r8), %zmm14, %zmm14
vpsubq 960(%r8), %zmm15, %zmm15
vpsubq %zmm25, %zmm14, %zmm14
vpsubq %zmm26, %zmm15, %zmm15
vpsrlq $63, %zmm14, %zmm25
vpsrlq $63, %zmm15, %zmm26
vpandq %zmm24, %zmm14, %zmm14
vpandq %zmm24, %zmm15, %zmm15
vpxorq %zmm16, %zmm16, %zmm16
vpcmpgtq %zmm16, %zmm25, %k1
vpcmpgtq %zmm16, %zmm26, %k2
vpaddq (%rax){1to8}, %zmm0, %zmm16
vpsrlq $52, %zmm16, %zmm25
vpandq %zmm24, %zmm16, %zmm0{%k1}
vpaddq 8(%rax){1to8}, %zmm2, %zmm17
vpaddq %zmm25, %zmm17, %zmm17
vpsrlq $52, %zmm17, %zmm25
vpandq %zmm24, %zmm17, %zmm2{%k1}
vpaddq 16(%rax){1to8}, %zmm4, %zmm18
vpaddq %zmm25, %zmm18, %zmm18
vpsrlq $52, %zmm18, %zmm25
vpandq %zmm24, %zmm18, %zmm4{%k1}
vpaddq 24(%rax){1to8}, %zmm6, %zmm19
vpaddq %zmm25, %zmm19, %zmm19
vpsrlq $52, %zmm19, %zmm25
vpandq %zmm24, %zmm19, %zmm6{%k1}
vpaddq 32(%rax){1to8}, %zmm8, %zmm20
vpaddq %zmm25, %zmm20, %zmm20
vpsrlq $52, %zmm20, %zmm25
vpandq %zmm24, %zmm20, %zmm8{%k1}
vpaddq 40(%rax){1to8}, %zmm10, %zmm21
vpaddq %zmm25, %zmm21, %zmm21
vpsrlq $52, %zmm21, %zmm25
vpandq %zmm24, %zmm21, %zmm10{%k1}
vpaddq 48(%rax){1to8}, %zmm12, %zmm22
vpaddq %zmm25, %zmm22, %zmm22
vpsrlq $52, %zmm22, %zmm25
vpandq %zmm24, %zmm22, %zmm12{%k1}
vpaddq 56(%rax){1to8}, %zmm14, %zmm23
vpaddq %zmm25, %zmm23, %zmm23
vpandq %zmm24, %zmm23, %zmm14{%k1}
vpaddq (%rax){1to8}, %zmm1, %zmm16
vpsrlq $52, %zmm16, %zmm25
vpandq %zmm24, %zmm16, %zmm1{%k2}
vpaddq 8(%rax){1to8}, %zmm3, %zmm17
vpaddq %zmm25, %zmm17, %zmm17
vpsrlq $52, %zmm17, %zmm25
vpandq %zmm24, %zmm17, %zmm3{%k2}
vpaddq 16(%rax){1to8}, %zmm5, %zmm18
vpaddq %zmm25, %zmm18, %zmm18
vpsrlq $52, %zmm18, %zmm25
vpandq %zmm24, %zmm18, %zmm5{%k2}
vpaddq 24(%rax){1to8}, %zmm7, %zmm19
vpaddq %zmm25, %zmm19, %zmm19
vpsrlq $52, %zmm19, %zmm25
vpandq %zmm24, %zmm19, %zmm7{%k2}
vpaddq 32(%rax){1to8}, %zmm9, %zmm20
vpaddq %zmm25, %zmm20, %zmm20
vpsrlq $52, %zmm20, %zmm25
vpandq %zmm24, %zmm20, %zmm9{%k2}
vpaddq 40(%rax){1to8}, %zmm11, %zmm21
vpaddq %zmm25, %zmm21, %zmm21
vpsrlq $52, %zmm21, %zmm25
vpandq %zmm24, %zmm21, %zmm11{%k2}
vpaddq 48(%rax){1to8}, %zmm13, %zmm22
vpaddq %zmm25, %zmm22, %zmm22
vpsrlq $52, %zmm22, %zmm25
vpandq %zmm24, %zmm22, %zmm13{%k2}
vpaddq 56(%rax){1to8}, %zmm15, %zmm23
vpaddq %zmm25, %zmm23, %zmm23
vpandq %zmm24, %zmm23, %zmm15{%k2}
vmovdqa64 %zmm0, (%rcx)
vmovdqa64 %zmm1, 64(%rcx)
vmovdqa64 %zmm2, 128(%rcx)
vmovdqa64 %zmm3, 192(%rcx)
vmovdqa64 %zmm4, 256(%rcx)
vmovdqa64 %zmm5, 320(%rcx)
vmovdqa64 %zmm6, 384(%rcx)
vmovdqa64 %zmm7, 448(%rcx)
vmovdqa64 %zmm8, 512(%rcx)
vmovdqa64 %zmm9, 576(%rcx)
vmovdqa64 %zmm10, 640(%rcx)
vmovdqa64 %zmm11, 704(%rcx)
vmovdqa64 %zmm12, 768(%rcx)
vmovdqa64 %zmm13, 832(%rcx)
vmovdqa64 %zmm14, 896(%rcx)
vmovdqa64 %zmm15, 960(%rcx)
vmovups (%rsp), %xmm5
vmovups 16(%rsp), %xmm6
vmovups 32(%rsp), %xmm7
vmovups 48(%rsp), %xmm8
vmovups 64(%rsp), %xmm9
vmovups 80(%rsp), %xmm10
vmovups 96(%rsp), %xmm11
vmovups 112(%rsp), %xmm12
vmovups 128(%rsp), %xmm13
vmovups 144(%rsp), %xmm14
vmovups 160(%rsp), %xmm15
vzeroupper
add $184, %rsp
ret
SIZE(mcl_c5_vsubA)
.global PRE(mcl_c5_vmulA)
PRE(mcl_c5_vmulA):
TYPE(mcl_c5_vmulA)
sub $184, %rsp
vmovups %xmm5, (%rsp)
vmovups %xmm6, 16(%rsp)
vmovups %xmm7, 32(%rsp)
vmovups %xmm8, 48(%rsp)
vmovups %xmm9, 64(%rsp)
vmovups %xmm10, 80(%rsp)
vmovups %xmm11, 96(%rsp)
vmovups %xmm12, 112(%rsp)
vmovups %xmm13, 128(%rsp)
vmovups %xmm14, 144(%rsp)
vmovups %xmm15, 160(%rsp)
lea PRE(ap)(%rip), %rax
vmovdqa64 (%rax), %zmm23
vmovdqa64 64(%rax), %zmm24
vmovdqa64 128(%rax), %zmm25
vmovdqa64 192(%rax), %zmm26
vmovdqa64 256(%rax), %zmm27
vmovdqa64 320(%rax), %zmm28
vmovdqa64 384(%rax), %zmm29
vmovdqa64 448(%rax), %zmm30
mov $4503599627370495, %rax
vpbroadcastq %rax, %zmm18
lea PRE(rp)(%rip), %r9
vmovdqa64 (%r8), %zmm21
vmovdqa64 64(%r8), %zmm22
add $128, %r8
vpxorq %zmm0, %zmm0, %zmm0
vpxorq %zmm1, %zmm1, %zmm1
vpmadd52luq (%rdx), %zmm21, %zmm0
vpmadd52luq 64(%rdx), %zmm22, %zmm1
vpxorq %zmm19, %zmm19, %zmm19
vpxorq %zmm20, %zmm20, %zmm20
vpmadd52huq (%rdx), %zmm21, %zmm19
vpmadd52huq 64(%rdx), %zmm22, %zmm20
vmovdqa64 %zmm19, %zmm2
vmovdqa64 %zmm20, %zmm3
vpmadd52luq 128(%rdx), %zmm21, %zmm2
vpmadd52luq 192(%rdx), %zmm22, %zmm3
vpxorq %zmm19, %zmm19, %zmm19
vpxorq %zmm20, %zmm20, %zmm20
vpmadd52huq 128(%rdx), %zmm21, %zmm19
vpmadd52huq 192(%rdx), %zmm22, %zmm20
vmovdqa64 %zmm19, %zmm4
vmovdqa64 %zmm20, %zmm5
vpmadd52luq 256(%rdx), %zmm21, %zmm4
vpmadd52luq 320(%rdx), %zmm22, %zmm5
vpxorq %zmm19, %zmm19, %zmm19
vpxorq %zmm20, %zmm20, %zmm20
vpmadd52huq 256(%rdx), %zmm21, %zmm19
vpmadd52huq 320(%rdx), %zmm22, %zmm20
vmovdqa64 %zmm19, %zmm6
vmovdqa64 %zmm20, %zmm7
vpmadd52luq 384(%rdx), %zmm21, %zmm6
vpmadd52luq 448(%rdx), %zmm22, %zmm7
vpxorq %zmm19, %zmm19, %zmm19
vpxorq %zmm20, %zmm20, %zmm20
vpmadd52huq 384(%rdx), %zmm21, %zmm19
vpmadd52huq 448(%rdx), %zmm22, %zmm20
vmovdqa64 %zmm19, %zmm8
vmovdqa64 %zmm20, %zmm9
vpmadd52luq 512(%rdx), %zmm21, %zmm8
vpmadd52luq 576(%rdx), %zmm22, %zmm9
vpxorq %zmm19, %zmm19, %zmm19
vpxorq %zmm20, %zmm20, %zmm20
vpmadd52huq 512(%rdx), %zmm21, %zmm19
vpmadd52huq 576(%rdx), %zmm22, %zmm20
vmovdqa64 %zmm19, %zmm10
vmovdqa64 %zmm20, %zmm11
vpmadd52luq 640(%rdx), %zmm21, %zmm10
vpmadd52luq 704(%rdx), %zmm22, %zmm11
vpxorq %zmm19, %zmm19, %zmm19
vpxorq %zmm20, %zmm20, %zmm20
vpmadd52huq 640(%rdx), %zmm21, %zmm19
vpmadd52huq 704(%rdx), %zmm22, %zmm20
vmovdqa64 %zmm19, %zmm12
vmovdqa64 %zmm20, %zmm13
vpmadd52luq 768(%rdx), %zmm21, %zmm12
vpmadd52luq 832(%rdx), %zmm22, %zmm13
vpxorq %zmm19, %zmm19, %zmm19
vpxorq %zmm20, %zmm20, %zmm20
vpmadd52huq 768(%rdx), %zmm21, %zmm19
vpmadd52huq 832(%rdx), %zmm22, %zmm20
vmovdqa64 %zmm19, %zmm14
vmovdqa64 %zmm20, %zmm15
vpmadd52luq 896(%rdx), %zmm21, %zmm14
vpmadd52luq 960(%rdx), %zmm22, %zmm15
vpxorq %zmm16, %zmm16, %zmm16
vpxorq %zmm17, %zmm17, %zmm17
vpmadd52huq 896(%rdx), %zmm21, %zmm16
vpmadd52huq 960(%rdx), %zmm22, %zmm17
vpxorq %zmm21, %zmm21, %zmm21
vpxorq %zmm22, %zmm22, %zmm22
vpmadd52luq (%r9){1to8}, %zmm0, %zmm21
vpmadd52luq (%r9){1to8}, %zmm1, %zmm22
vpmadd52luq %zmm23, %zmm21, %zmm0
vpmadd52luq %zmm23, %zmm22, %zmm1
vpmadd52huq %zmm23, %zmm21, %zmm2
vpmadd52huq %zmm23, %zmm22, %zmm3
vpmadd52luq %zmm24, %zmm21, %zmm2
vpmadd52luq %zmm24, %zmm22, %zmm3
vpmadd52huq %zmm24, %zmm21, %zmm4
vpmadd52huq %zmm24, %zmm22, %zmm5
vpmadd52luq %zmm25, %zmm21, %zmm4
vpmadd52luq %zmm25, %zmm22, %zmm5
vpmadd52huq %zmm25, %zmm21, %zmm6
vpmadd52huq %zmm25, %zmm22, %zmm7
vpmadd52luq %zmm26, %zmm21, %zmm6
vpmadd52luq %zmm26, %zmm22, %zmm7
vpmadd52huq %zmm26, %zmm21, %zmm8
vpmadd52huq %zmm26, %zmm22, %zmm9
vpmadd52luq %zmm27, %zmm21, %zmm8
vpmadd52luq %zmm27, %zmm22, %zmm9
vpmadd52huq %zmm27, %zmm21, %zmm10
vpmadd52huq %zmm27, %zmm22, %zmm11
vpmadd52luq %zmm28, %zmm21, %zmm10
vpmadd52luq %zmm28, %zmm22, %zmm11
vpmadd52huq %zmm28, %zmm21, %zmm12
vpmadd52huq %zmm28, %zmm22, %zmm13
vpmadd52luq %zmm29, %zmm21, %zmm12
vpmadd52luq %zmm29, %zmm22, %zmm13
vpmadd52huq %zmm29, %zmm21, %zmm14
vpmadd52huq %zmm29, %zmm22, %zmm15
vpmadd52luq %zmm30, %zmm21, %zmm14
vpmadd52luq %zmm30, %zmm22, %zmm15
vpmadd52huq %zmm30, %zmm21, %zmm16
vpmadd52huq %zmm30, %zmm22, %zmm17
mov $7, %r10
.balign 32
.L3:
mov %rdx, %rax
vmovdqa64 (%r8), %zmm21
vmovdqa64 64(%r8), %zmm22
add $128, %r8
vmovdqa64 %zmm0, %zmm19
vmovdqa64 %zmm1, %zmm20
vmovdqa64 %zmm2, %zmm0
vmovdqa64 %zmm3, %zmm1
vmovdqa64 %zmm4, %zmm2
vmovdqa64 %zmm5, %zmm3
vmovdqa64 %zmm6, %zmm4
vmovdqa64 %zmm7, %zmm5
vmovdqa64 %zmm8, %zmm6
vmovdqa64 %zmm9, %zmm7
vmovdqa64 %zmm10, %zmm8
vmovdqa64 %zmm11, %zmm9
vmovdqa64 %zmm12, %zmm10
vmovdqa64 %zmm13, %zmm11
vmovdqa64 %zmm14, %zmm12
vmovdqa64 %zmm15, %zmm13
vmovdqa64 %zmm16, %zmm14
vmovdqa64 %zmm17, %zmm15
vpxorq %zmm16, %zmm16, %zmm16
vpxorq %zmm17, %zmm17, %zmm17
vpmadd52luq (%rax), %zmm21, %zmm0
vpmadd52luq 64(%rax), %zmm22, %zmm1
vpmadd52huq (%rax), %zmm21, %zmm2
vpmadd52huq 64(%rax), %zmm22, %zmm3
vpmadd52luq 128(%rax), %zmm21, %zmm2
vpmadd52luq 192(%rax), %zmm22, %zmm3
vpmadd52huq 128(%rax), %zmm21, %zmm4
vpmadd52huq 192(%rax), %zmm22, %zmm5
vpmadd52luq 256(%rax), %zmm21, %zmm4
vpmadd52luq 320(%rax), %zmm22, %zmm5
vpmadd52huq 256(%rax), %zmm21, %zmm6
vpmadd52huq 320(%rax), %zmm22, %zmm7
vpmadd52luq 384(%rax), %zmm21, %zmm6
vpmadd52luq 448(%rax), %zmm22, %zmm7
vpmadd52huq 384(%rax), %zmm21, %zmm8
vpmadd52huq 448(%rax), %zmm22, %zmm9
vpmadd52luq 512(%rax), %zmm21, %zmm8
vpmadd52luq 576(%rax), %zmm22, %zmm9
vpmadd52huq 512(%rax), %zmm21, %zmm10
vpmadd52huq 576(%rax), %zmm22, %zmm11
vpmadd52luq 640(%rax), %zmm21, %zmm10
vpmadd52luq 704(%rax), %zmm22, %zmm11
vpmadd52huq 640(%rax), %zmm21, %zmm12
vpmadd52huq 704(%rax), %zmm22, %zmm13
vpmadd52luq 768(%rax), %zmm21, %zmm12
vpmadd52luq 832(%rax), %zmm22, %zmm13
vpmadd52huq 768(%rax), %zmm21, %zmm14
vpmadd52huq 832(%rax), %zmm22, %zmm15
vpmadd52luq 896(%rax), %zmm21, %zmm14
vpmadd52luq 960(%rax), %zmm22, %zmm15
vpmadd52huq 896(%rax), %zmm21, %zmm16
vpmadd52huq 960(%rax), %zmm22, %zmm17
vpsrlq $52, %zmm19, %zmm21
vpsrlq $52, %zmm20, %zmm22
vpaddq %zmm21, %zmm0, %zmm0
vpaddq %zmm22, %zmm1, %zmm1
vpxorq %zmm21, %zmm21, %zmm21
vpxorq %zmm22, %zmm22, %zmm22
vpmadd52luq (%r9){1to8}, %zmm0, %zmm21
vpmadd52luq (%r9){1to8}, %zmm1, %zmm22
vpmadd52luq %zmm23, %zmm21, %zmm0
vpmadd52luq %zmm23, %zmm22, %zmm1
vpmadd52huq %zmm23, %zmm21, %zmm2
vpmadd52huq %zmm23, %zmm22, %zmm3
vpmadd52luq %zmm24, %zmm21, %zmm2
vpmadd52luq %zmm24, %zmm22, %zmm3
vpmadd52huq %zmm24, %zmm21, %zmm4
vpmadd52huq %zmm24, %zmm22, %zmm5
vpmadd52luq %zmm25, %zmm21, %zmm4
vpmadd52luq %zmm25, %zmm22, %zmm5
vpmadd52huq %zmm25, %zmm21, %zmm6
vpmadd52huq %zmm25, %zmm22, %zmm7
vpmadd52luq %zmm26, %zmm21, %zmm6
vpmadd52luq %zmm26, %zmm22, %zmm7
vpmadd52huq %zmm26, %zmm21, %zmm8
vpmadd52huq %zmm26, %zmm22, %zmm9
vpmadd52luq %zmm27, %zmm21, %zmm8
vpmadd52luq %zmm27, %zmm22, %zmm9
vpmadd52huq %zmm27, %zmm21, %zmm10
vpmadd52huq %zmm27, %zmm22, %zmm11
vpmadd52luq %zmm28, %zmm21, %zmm10
vpmadd52luq %zmm28, %zmm22, %zmm11
vpmadd52huq %zmm28, %zmm21, %zmm12
vpmadd52huq %zmm28, %zmm22, %zmm13
vpmadd52luq %zmm29, %zmm21, %zmm12
vpmadd52luq %zmm29, %zmm22, %zmm13
vpmadd52huq %zmm29, %zmm21, %zmm14
vpmadd52huq %zmm29, %zmm22, %zmm15
vpmadd52luq %zmm30, %zmm21, %zmm14
vpmadd52luq %zmm30, %zmm22, %zmm15
vpmadd52huq %zmm30, %zmm21, %zmm16
vpmadd52huq %zmm30, %zmm22, %zmm17
dec %r10
jnz .L3
vpsrlq $52, %zmm0, %zmm21
vpsrlq $52, %zmm1, %zmm22
vpaddq %zmm21, %zmm2, %zmm2
vpaddq %zmm22, %zmm3, %zmm3
vpandq %zmm18, %zmm0, %zmm0
vpandq %zmm18, %zmm1, %zmm1
vpsrlq $52, %zmm2, %zmm21
vpsrlq $52, %zmm3, %zmm22
vpaddq %zmm21, %zmm4, %zmm4
vpaddq %zmm22, %zmm5, %zmm5
vpandq %zmm18, %zmm2, %zmm2
vpandq %zmm18, %zmm3, %zmm3
vpsrlq $52, %zmm4, %zmm21
vpsrlq $52, %zmm5, %zmm22
vpaddq %zmm21, %zmm6, %zmm6
vpaddq %zmm22, %zmm7, %zmm7
vpandq %zmm18, %zmm4, %zmm4
vpandq %zmm18, %zmm5, %zmm5
vpsrlq $52, %zmm6, %zmm21
vpsrlq $52, %zmm7, %zmm22
vpaddq %zmm21, %zmm8, %zmm8
vpaddq %zmm22, %zmm9, %zmm9
vpandq %zmm18, %zmm6, %zmm6
vpandq %zmm18, %zmm7, %zmm7
vpsrlq $52, %zmm8, %zmm21
vpsrlq $52, %zmm9, %zmm22
vpaddq %zmm21, %zmm10, %zmm10
vpaddq %zmm22, %zmm11, %zmm11
vpandq %zmm18, %zmm8, %zmm8
vpandq %zmm18, %zmm9, %zmm9
vpsrlq $52, %zmm10, %zmm21
vpsrlq $52, %zmm11, %zmm22
vpaddq %zmm21, %zmm12, %zmm12
vpaddq %zmm22, %zmm13, %zmm13
vpandq %zmm18, %zmm10, %zmm10
vpandq %zmm18, %zmm11, %zmm11
vpsrlq $52, %zmm12, %zmm21
vpsrlq $52, %zmm13, %zmm22
vpaddq %zmm21, %zmm14, %zmm14
vpaddq %zmm22, %zmm15, %zmm15
vpandq %zmm18, %zmm12, %zmm12
vpandq %zmm18, %zmm13, %zmm13
vpsrlq $52, %zmm14, %zmm21
vpsrlq $52, %zmm15, %zmm22
vpaddq %zmm21, %zmm16, %zmm16
vpaddq %zmm22, %zmm17, %zmm17
vpandq %zmm18, %zmm14, %zmm14
vpandq %zmm18, %zmm15, %zmm15
lea PRE(p)(%rip), %rax
vpxorq %zmm19, %zmm19, %zmm19
vpsubq %zmm23, %zmm2, %zmm23
vpsrlq $63, %zmm23, %zmm21
vpsubq %zmm24, %zmm4, %zmm24
vpsubq %zmm21, %zmm24, %zmm24
vpsrlq $63, %zmm24, %zmm21
vpsubq %zmm25, %zmm6, %zmm25
vpsubq %zmm21, %zmm25, %zmm25
vpsrlq $63, %zmm25, %zmm21
vpsubq %zmm26, %zmm8, %zmm26
vpsubq %zmm21, %zmm26, %zmm26
vpsrlq $63, %zmm26, %zmm21
vpsubq %zmm27, %zmm10, %zmm27
vpsubq %zmm21, %zmm27, %zmm27
vpsrlq $63, %zmm27, %zmm21
vpsubq %zmm28, %zmm12, %zmm28
vpsubq %zmm21, %zmm28, %zmm28
vpsrlq $63, %zmm28, %zmm21
vpsubq %zmm29, %zmm14, %zmm29
vpsubq %zmm21, %zmm29, %zmm29
vpsrlq $63, %zmm29, %zmm21
vpsubq %zmm30, %zmm16, %zmm30
vpsubq %zmm21, %zmm30, %zmm30
vpsrlq $63, %zmm30, %zmm21
vpcmpeqq %zmm19, %zmm21, %k1
vpandq %zmm18, %zmm23, %zmm2{%k1}
vpandq %zmm18, %zmm24, %zmm4{%k1}
vpandq %zmm18, %zmm25, %zmm6{%k1}
vpandq %zmm18, %zmm26, %zmm8{%k1}
vpandq %zmm18, %zmm27, %zmm10{%k1}
vpandq %zmm18, %zmm28, %zmm12{%k1}
vpandq %zmm18, %zmm29, %zmm14{%k1}
vpandq %zmm18, %zmm30, %zmm16{%k1}
vmovdqa64 %zmm2, (%rcx)
vmovdqa64 %zmm3, 64(%rcx)
vmovdqa64 %zmm4, 128(%rcx)
vmovdqa64 %zmm5, 192(%rcx)
vmovdqa64 %zmm6, 256(%rcx)
vmovdqa64 %zmm7, 320(%rcx)
vmovdqa64 %zmm8, 384(%rcx)
vmovdqa64 %zmm9, 448(%rcx)
vmovdqa64 %zmm10, 512(%rcx)
vmovdqa64 %zmm11, 576(%rcx)
vmovdqa64 %zmm12, 640(%rcx)
vmovdqa64 %zmm13, 704(%rcx)
vmovdqa64 %zmm14, 768(%rcx)
vmovdqa64 %zmm15, 832(%rcx)
vmovdqa64 %zmm16, 896(%rcx)
vmovdqa64 %zmm17, 960(%rcx)
vpsubq (%rax){1to8}, %zmm3, %zmm23
vpsrlq $63, %zmm23, %zmm21
vpsubq 8(%rax){1to8}, %zmm5, %zmm24
vpsubq %zmm21, %zmm24, %zmm24
vpsrlq $63, %zmm24, %zmm21
vpsubq 16(%rax){1to8}, %zmm7, %zmm25
vpsubq %zmm21, %zmm25, %zmm25
vpsrlq $63, %zmm25, %zmm21
vpsubq 24(%rax){1to8}, %zmm9, %zmm26
vpsubq %zmm21, %zmm26, %zmm26
vpsrlq $63, %zmm26, %zmm21
vpsubq 32(%rax){1to8}, %zmm11, %zmm27
vpsubq %zmm21, %zmm27, %zmm27
vpsrlq $63, %zmm27, %zmm21
vpsubq 40(%rax){1to8}, %zmm13, %zmm28
vpsubq %zmm21, %zmm28, %zmm28
vpsrlq $63, %zmm28, %zmm21
vpsubq 48(%rax){1to8}, %zmm15, %zmm29
vpsubq %zmm21, %zmm29, %zmm29
vpsrlq $63, %zmm29, %zmm21
vpsubq 56(%rax){1to8}, %zmm17, %zmm30
vpsubq %zmm21, %zmm30, %zmm30
vpsrlq $63, %zmm30, %zmm21
vpcmpeqq %zmm19, %zmm21, %k1
vpandq %zmm18, %zmm23, %zmm3{%k1}
vpandq %zmm18, %zmm24, %zmm5{%k1}
vpandq %zmm18, %zmm25, %zmm7{%k1}
vpandq %zmm18, %zmm26, %zmm9{%k1}
vpandq %zmm18, %zmm27, %zmm11{%k1}
vpandq %zmm18, %zmm28, %zmm13{%k1}
vpandq %zmm18, %zmm29, %zmm15{%k1}
vpandq %zmm18, %zmm30, %zmm17{%k1}
vmovdqa64 %zmm10, 512(%rcx)
vmovdqa64 %zmm11, 576(%rcx)
vmovdqa64 %zmm12, 640(%rcx)
vmovdqa64 %zmm13, 704(%rcx)
vmovdqa64 %zmm14, 768(%rcx)
vmovdqa64 %zmm15, 832(%rcx)
vmovdqa64 %zmm16, 896(%rcx)
vmovdqa64 %zmm17, 960(%rcx)
vmovups (%rsp), %xmm5
vmovups 16(%rsp), %xmm6
vmovups 32(%rsp), %xmm7
vmovups 48(%rsp), %xmm8
vmovups 64(%rsp), %xmm9
vmovups 80(%rsp), %xmm10
vmovups 96(%rsp), %xmm11
vmovups 112(%rsp), %xmm12
vmovups 128(%rsp), %xmm13
vmovups 144(%rsp), %xmm14
vmovups 160(%rsp), %xmm15
vzeroupper
add $184, %rsp
ret
SIZE(mcl_c5_vmulA)
.balign 16
.global PRE(mclb_add1)
PRE(mclb_add1):
TYPE(mclb_add1)
mov (%rdx), %rax
add (%r8), %rax
mov %rax, (%rcx)
setc %al
movzx %al, %eax
ret
SIZE(mclb_add1)
.balign 16
.global PRE(mclb_add2)
PRE(mclb_add2):
TYPE(mclb_add2)
mov (%rdx), %rax
add (%r8), %rax
mov %rax, (%rcx)
mov 8(%rdx), %rax
adc 8(%r8), %rax
mov %rax, 8(%rcx)
setc %al
movzx %al, %eax
ret
SIZE(mclb_add2)
.balign 16
.global PRE(mclb_add3)
PRE(mclb_add3):
TYPE(mclb_add3)
mov (%rdx), %rax
add (%r8), %rax
mov %rax, (%rcx)
mov 8(%rdx), %rax
adc 8(%r8), %rax
mov %rax, 8(%rcx)
mov 16(%rdx), %rax
adc 16(%r8), %rax
mov %rax, 16(%rcx)
setc %al
movzx %al, %eax
ret
SIZE(mclb_add3)
.balign 16
.global PRE(mclb_add4)
PRE(mclb_add4):
TYPE(mclb_add4)
mov (%rdx), %rax
add (%r8), %rax
mov %rax, (%rcx)
mov 8(%rdx), %rax
adc 8(%r8), %rax
mov %rax, 8(%rcx)
mov 16(%rdx), %rax
adc 16(%r8), %rax
mov %rax, 16(%rcx)
mov 24(%rdx), %rax
adc 24(%r8), %rax
mov %rax, 24(%rcx)
setc %al
movzx %al, %eax
ret
SIZE(mclb_add4)
.balign 16
.global PRE(mclb_add5)
PRE(mclb_add5):
TYPE(mclb_add5)
mov (%rdx), %rax
add (%r8), %rax
mov %rax, (%rcx)
mov 8(%rdx), %rax
adc 8(%r8), %rax
mov %rax, 8(%rcx)
mov 16(%rdx), %rax
adc 16(%r8), %rax
mov %rax, 16(%rcx)
mov 24(%rdx), %rax
adc 24(%r8), %rax
mov %rax, 24(%rcx)
mov 32(%rdx), %rax
adc 32(%r8), %rax
mov %rax, 32(%rcx)
setc %al
movzx %al, %eax
ret
SIZE(mclb_add5)
.balign 16
.global PRE(mclb_add6)
PRE(mclb_add6):
TYPE(mclb_add6)
mov (%rdx), %rax
add (%r8), %rax
mov %rax, (%rcx)
mov 8(%rdx), %rax
adc 8(%r8), %rax
mov %rax, 8(%rcx)
mov 16(%rdx), %rax
adc 16(%r8), %rax
mov %rax, 16(%rcx)
mov 24(%rdx), %rax
adc 24(%r8), %rax
mov %rax, 24(%rcx)
mov 32(%rdx), %rax
adc 32(%r8), %rax
mov %rax, 32(%rcx)
mov 40(%rdx), %rax
adc 40(%r8), %rax
mov %rax, 40(%rcx)
setc %al
movzx %al, %eax
ret
SIZE(mclb_add6)
.balign 16
.global PRE(mclb_add7)
PRE(mclb_add7):
TYPE(mclb_add7)
mov (%rdx), %rax
add (%r8), %rax
mov %rax, (%rcx)
mov 8(%rdx), %rax
adc 8(%r8), %rax
mov %rax, 8(%rcx)
mov 16(%rdx), %rax
adc 16(%r8), %rax
mov %rax, 16(%rcx)
mov 24(%rdx), %rax
adc 24(%r8), %rax
mov %rax, 24(%rcx)
mov 32(%rdx), %rax
adc 32(%r8), %rax
mov %rax, 32(%rcx)
mov 40(%rdx), %rax
adc 40(%r8), %rax
mov %rax, 40(%rcx)
mov 48(%rdx), %rax
adc 48(%r8), %rax
mov %rax, 48(%rcx)
setc %al
movzx %al, %eax
ret
SIZE(mclb_add7)
.balign 16
.global PRE(mclb_add8)
PRE(mclb_add8):
TYPE(mclb_add8)
mov (%rdx), %rax
add (%r8), %rax
mov %rax, (%rcx)
mov 8(%rdx), %rax
adc 8(%r8), %rax
mov %rax, 8(%rcx)
mov 16(%rdx), %rax
adc 16(%r8), %rax
mov %rax, 16(%rcx)
mov 24(%rdx), %rax
adc 24(%r8), %rax
mov %rax, 24(%rcx)
mov 32(%rdx), %rax
adc 32(%r8), %rax
mov %rax, 32(%rcx)
mov 40(%rdx), %rax
adc 40(%r8), %rax
mov %rax, 40(%rcx)
mov 48(%rdx), %rax
adc 48(%r8), %rax
mov %rax, 48(%rcx)
mov 56(%rdx), %rax
adc 56(%r8), %rax
mov %rax, 56(%rcx)
setc %al
movzx %al, %eax
ret
SIZE(mclb_add8)
.balign 16
.global PRE(mclb_add9)
PRE(mclb_add9):
TYPE(mclb_add9)
mov (%rdx), %rax
add (%r8), %rax
mov %rax, (%rcx)
mov 8(%rdx), %rax
adc 8(%r8), %rax
mov %rax, 8(%rcx)
mov 16(%rdx), %rax
adc 16(%r8), %rax
mov %rax, 16(%rcx)
mov 24(%rdx), %rax
adc 24(%r8), %rax
mov %rax, 24(%rcx)
mov 32(%rdx), %rax
adc 32(%r8), %rax
mov %rax, 32(%rcx)
mov 40(%rdx), %rax
adc 40(%r8), %rax
mov %rax, 40(%rcx)
mov 48(%rdx), %rax
adc 48(%r8), %rax
mov %rax, 48(%rcx)
mov 56(%rdx), %rax
adc 56(%r8), %rax
mov %rax, 56(%rcx)
mov 64(%rdx), %rax
adc 64(%r8), %rax
mov %rax, 64(%rcx)
setc %al
movzx %al, %eax
ret
SIZE(mclb_add9)
.balign 16
.global PRE(mclb_add10)
PRE(mclb_add10):
TYPE(mclb_add10)
mov (%rdx), %rax
add (%r8), %rax
mov %rax, (%rcx)
mov 8(%rdx), %rax
adc 8(%r8), %rax
mov %rax, 8(%rcx)
mov 16(%rdx), %rax
adc 16(%r8), %rax
mov %rax, 16(%rcx)
mov 24(%rdx), %rax
adc 24(%r8), %rax
mov %rax, 24(%rcx)
mov 32(%rdx), %rax
adc 32(%r8), %rax
mov %rax, 32(%rcx)
mov 40(%rdx), %rax
adc 40(%r8), %rax
mov %rax, 40(%rcx)
mov 48(%rdx), %rax
adc 48(%r8), %rax
mov %rax, 48(%rcx)
mov 56(%rdx), %rax
adc 56(%r8), %rax
mov %rax, 56(%rcx)
mov 64(%rdx), %rax
adc 64(%r8), %rax
mov %rax, 64(%rcx)
mov 72(%rdx), %rax
adc 72(%r8), %rax
mov %rax, 72(%rcx)
setc %al
movzx %al, %eax
ret
SIZE(mclb_add10)
.balign 16
.global PRE(mclb_add11)
PRE(mclb_add11):
TYPE(mclb_add11)
mov (%rdx), %rax
add (%r8), %rax
mov %rax, (%rcx)
mov 8(%rdx), %rax
adc 8(%r8), %rax
mov %rax, 8(%rcx)
mov 16(%rdx), %rax
adc 16(%r8), %rax
mov %rax, 16(%rcx)
mov 24(%rdx), %rax
adc 24(%r8), %rax
mov %rax, 24(%rcx)
mov 32(%rdx), %rax
adc 32(%r8), %rax
mov %rax, 32(%rcx)
mov 40(%rdx), %rax
adc 40(%r8), %rax
mov %rax, 40(%rcx)
mov 48(%rdx), %rax
adc 48(%r8), %rax
mov %rax, 48(%rcx)
mov 56(%rdx), %rax
adc 56(%r8), %rax
mov %rax, 56(%rcx)
mov 64(%rdx), %rax
adc 64(%r8), %rax
mov %rax, 64(%rcx)
mov 72(%rdx), %rax
adc 72(%r8), %rax
mov %rax, 72(%rcx)
mov 80(%rdx), %rax
adc 80(%r8), %rax
mov %rax, 80(%rcx)
setc %al
movzx %al, %eax
ret
SIZE(mclb_add11)
.balign 16
.global PRE(mclb_add12)
PRE(mclb_add12):
TYPE(mclb_add12)
mov (%rdx), %rax
add (%r8), %rax
mov %rax, (%rcx)
mov 8(%rdx), %rax
adc 8(%r8), %rax
mov %rax, 8(%rcx)
mov 16(%rdx), %rax
adc 16(%r8), %rax
mov %rax, 16(%rcx)
mov 24(%rdx), %rax
adc 24(%r8), %rax
mov %rax, 24(%rcx)
mov 32(%rdx), %rax
adc 32(%r8), %rax
mov %rax, 32(%rcx)
mov 40(%rdx), %rax
adc 40(%r8), %rax
mov %rax, 40(%rcx)
mov 48(%rdx), %rax
adc 48(%r8), %rax
mov %rax, 48(%rcx)
mov 56(%rdx), %rax
adc 56(%r8), %rax
mov %rax, 56(%rcx)
mov 64(%rdx), %rax
adc 64(%r8), %rax
mov %rax, 64(%rcx)
mov 72(%rdx), %rax
adc 72(%r8), %rax
mov %rax, 72(%rcx)
mov 80(%rdx), %rax
adc 80(%r8), %rax
mov %rax, 80(%rcx)
mov 88(%rdx), %rax
adc 88(%r8), %rax
mov %rax, 88(%rcx)
setc %al
movzx %al, %eax
ret
SIZE(mclb_add12)
.balign 16
.global PRE(mclb_add13)
PRE(mclb_add13):
TYPE(mclb_add13)
mov (%rdx), %rax
add (%r8), %rax
mov %rax, (%rcx)
mov 8(%rdx), %rax
adc 8(%r8), %rax
mov %rax, 8(%rcx)
mov 16(%rdx), %rax
adc 16(%r8), %rax
mov %rax, 16(%rcx)
mov 24(%rdx), %rax
adc 24(%r8), %rax
mov %rax, 24(%rcx)
mov 32(%rdx), %rax
adc 32(%r8), %rax
mov %rax, 32(%rcx)
mov 40(%rdx), %rax
adc 40(%r8), %rax
mov %rax, 40(%rcx)
mov 48(%rdx), %rax
adc 48(%r8), %rax
mov %rax, 48(%rcx)
mov 56(%rdx), %rax
adc 56(%r8), %rax
mov %rax, 56(%rcx)
mov 64(%rdx), %rax
adc 64(%r8), %rax
mov %rax, 64(%rcx)
mov 72(%rdx), %rax
adc 72(%r8), %rax
mov %rax, 72(%rcx)
mov 80(%rdx), %rax
adc 80(%r8), %rax
mov %rax, 80(%rcx)
mov 88(%rdx), %rax
adc 88(%r8), %rax
mov %rax, 88(%rcx)
mov 96(%rdx), %rax
adc 96(%r8), %rax
mov %rax, 96(%rcx)
setc %al
movzx %al, %eax
ret
SIZE(mclb_add13)
.balign 16
.global PRE(mclb_add14)
PRE(mclb_add14):
TYPE(mclb_add14)
mov (%rdx), %rax
add (%r8), %rax
mov %rax, (%rcx)
mov 8(%rdx), %rax
adc 8(%r8), %rax
mov %rax, 8(%rcx)
mov 16(%rdx), %rax
adc 16(%r8), %rax
mov %rax, 16(%rcx)
mov 24(%rdx), %rax
adc 24(%r8), %rax
mov %rax, 24(%rcx)
mov 32(%rdx), %rax
adc 32(%r8), %rax
mov %rax, 32(%rcx)
mov 40(%rdx), %rax
adc 40(%r8), %rax
mov %rax, 40(%rcx)
mov 48(%rdx), %rax
adc 48(%r8), %rax
mov %rax, 48(%rcx)
mov 56(%rdx), %rax
adc 56(%r8), %rax
mov %rax, 56(%rcx)
mov 64(%rdx), %rax
adc 64(%r8), %rax
mov %rax, 64(%rcx)
mov 72(%rdx), %rax
adc 72(%r8), %rax
mov %rax, 72(%rcx)
mov 80(%rdx), %rax
adc 80(%r8), %rax
mov %rax, 80(%rcx)
mov 88(%rdx), %rax
adc 88(%r8), %rax
mov %rax, 88(%rcx)
mov 96(%rdx), %rax
adc 96(%r8), %rax
mov %rax, 96(%rcx)
mov 104(%rdx), %rax
adc 104(%r8), %rax
mov %rax, 104(%rcx)
setc %al
movzx %al, %eax
ret
SIZE(mclb_add14)
.balign 16
.global PRE(mclb_add15)
PRE(mclb_add15):
TYPE(mclb_add15)
mov (%rdx), %rax
add (%r8), %rax
mov %rax, (%rcx)
mov 8(%rdx), %rax
adc 8(%r8), %rax
mov %rax, 8(%rcx)
mov 16(%rdx), %rax
adc 16(%r8), %rax
mov %rax, 16(%rcx)
mov 24(%rdx), %rax
adc 24(%r8), %rax
mov %rax, 24(%rcx)
mov 32(%rdx), %rax
adc 32(%r8), %rax
mov %rax, 32(%rcx)
mov 40(%rdx), %rax
adc 40(%r8), %rax
mov %rax, 40(%rcx)
mov 48(%rdx), %rax
adc 48(%r8), %rax
mov %rax, 48(%rcx)
mov 56(%rdx), %rax
adc 56(%r8), %rax
mov %rax, 56(%rcx)
mov 64(%rdx), %rax
adc 64(%r8), %rax
mov %rax, 64(%rcx)
mov 72(%rdx), %rax
adc 72(%r8), %rax
mov %rax, 72(%rcx)
mov 80(%rdx), %rax
adc 80(%r8), %rax
mov %rax, 80(%rcx)
mov 88(%rdx), %rax
adc 88(%r8), %rax
mov %rax, 88(%rcx)
mov 96(%rdx), %rax
adc 96(%r8), %rax
mov %rax, 96(%rcx)
mov 104(%rdx), %rax
adc 104(%r8), %rax
mov %rax, 104(%rcx)
mov 112(%rdx), %rax
adc 112(%r8), %rax
mov %rax, 112(%rcx)
setc %al
movzx %al, %eax
ret
SIZE(mclb_add15)
.balign 16
.global PRE(mclb_add16)
PRE(mclb_add16):
TYPE(mclb_add16)
mov (%rdx), %rax
add (%r8), %rax
mov %rax, (%rcx)
mov 8(%rdx), %rax
adc 8(%r8), %rax
mov %rax, 8(%rcx)
mov 16(%rdx), %rax
adc 16(%r8), %rax
mov %rax, 16(%rcx)
mov 24(%rdx), %rax
adc 24(%r8), %rax
mov %rax, 24(%rcx)
mov 32(%rdx), %rax
adc 32(%r8), %rax
mov %rax, 32(%rcx)
mov 40(%rdx), %rax
adc 40(%r8), %rax
mov %rax, 40(%rcx)
mov 48(%rdx), %rax
adc 48(%r8), %rax
mov %rax, 48(%rcx)
mov 56(%rdx), %rax
adc 56(%r8), %rax
mov %rax, 56(%rcx)
mov 64(%rdx), %rax
adc 64(%r8), %rax
mov %rax, 64(%rcx)
mov 72(%rdx), %rax
adc 72(%r8), %rax
mov %rax, 72(%rcx)
mov 80(%rdx), %rax
adc 80(%r8), %rax
mov %rax, 80(%rcx)
mov 88(%rdx), %rax
adc 88(%r8), %rax
mov %rax, 88(%rcx)
mov 96(%rdx), %rax
adc 96(%r8), %rax
mov %rax, 96(%rcx)
mov 104(%rdx), %rax
adc 104(%r8), %rax
mov %rax, 104(%rcx)
mov 112(%rdx), %rax
adc 112(%r8), %rax
mov %rax, 112(%rcx)
mov 120(%rdx), %rax
adc 120(%r8), %rax
mov %rax, 120(%rcx)
setc %al
movzx %al, %eax
ret
SIZE(mclb_add16)
.balign 16
.global PRE(mclb_sub1)
PRE(mclb_sub1):
TYPE(mclb_sub1)
mov (%rdx), %rax
sub (%r8), %rax
mov %rax, (%rcx)
setc %al
movzx %al, %eax
ret
SIZE(mclb_sub1)
.balign 16
.global PRE(mclb_sub2)
PRE(mclb_sub2):
TYPE(mclb_sub2)
mov (%rdx), %rax
sub (%r8), %rax
mov %rax, (%rcx)
mov 8(%rdx), %rax
sbb 8(%r8), %rax
mov %rax, 8(%rcx)
setc %al
movzx %al, %eax
ret
SIZE(mclb_sub2)
.balign 16
.global PRE(mclb_sub3)
PRE(mclb_sub3):
TYPE(mclb_sub3)
mov (%rdx), %rax
sub (%r8), %rax
mov %rax, (%rcx)
mov 8(%rdx), %rax
sbb 8(%r8), %rax
mov %rax, 8(%rcx)
mov 16(%rdx), %rax
sbb 16(%r8), %rax
mov %rax, 16(%rcx)
setc %al
movzx %al, %eax
ret
SIZE(mclb_sub3)
.balign 16
.global PRE(mclb_sub4)
PRE(mclb_sub4):
TYPE(mclb_sub4)
mov (%rdx), %rax
sub (%r8), %rax
mov %rax, (%rcx)
mov 8(%rdx), %rax
sbb 8(%r8), %rax
mov %rax, 8(%rcx)
mov 16(%rdx), %rax
sbb 16(%r8), %rax
mov %rax, 16(%rcx)
mov 24(%rdx), %rax
sbb 24(%r8), %rax
mov %rax, 24(%rcx)
setc %al
movzx %al, %eax
ret
SIZE(mclb_sub4)
.balign 16
.global PRE(mclb_sub5)
PRE(mclb_sub5):
TYPE(mclb_sub5)
mov (%rdx), %rax
sub (%r8), %rax
mov %rax, (%rcx)
mov 8(%rdx), %rax
sbb 8(%r8), %rax
mov %rax, 8(%rcx)
mov 16(%rdx), %rax
sbb 16(%r8), %rax
mov %rax, 16(%rcx)
mov 24(%rdx), %rax
sbb 24(%r8), %rax
mov %rax, 24(%rcx)
mov 32(%rdx), %rax
sbb 32(%r8), %rax
mov %rax, 32(%rcx)
setc %al
movzx %al, %eax
ret
SIZE(mclb_sub5)
.balign 16
.global PRE(mclb_sub6)
PRE(mclb_sub6):
TYPE(mclb_sub6)
mov (%rdx), %rax
sub (%r8), %rax
mov %rax, (%rcx)
mov 8(%rdx), %rax
sbb 8(%r8), %rax
mov %rax, 8(%rcx)
mov 16(%rdx), %rax
sbb 16(%r8), %rax
mov %rax, 16(%rcx)
mov 24(%rdx), %rax
sbb 24(%r8), %rax
mov %rax, 24(%rcx)
mov 32(%rdx), %rax
sbb 32(%r8), %rax
mov %rax, 32(%rcx)
mov 40(%rdx), %rax
sbb 40(%r8), %rax
mov %rax, 40(%rcx)
setc %al
movzx %al, %eax
ret
SIZE(mclb_sub6)
.balign 16
.global PRE(mclb_sub7)
PRE(mclb_sub7):
TYPE(mclb_sub7)
mov (%rdx), %rax
sub (%r8), %rax
mov %rax, (%rcx)
mov 8(%rdx), %rax
sbb 8(%r8), %rax
mov %rax, 8(%rcx)
mov 16(%rdx), %rax
sbb 16(%r8), %rax
mov %rax, 16(%rcx)
mov 24(%rdx), %rax
sbb 24(%r8), %rax
mov %rax, 24(%rcx)
mov 32(%rdx), %rax
sbb 32(%r8), %rax
mov %rax, 32(%rcx)
mov 40(%rdx), %rax
sbb 40(%r8), %rax
mov %rax, 40(%rcx)
mov 48(%rdx), %rax
sbb 48(%r8), %rax
mov %rax, 48(%rcx)
setc %al
movzx %al, %eax
ret
SIZE(mclb_sub7)
.balign 16
.global PRE(mclb_sub8)
PRE(mclb_sub8):
TYPE(mclb_sub8)
mov (%rdx), %rax
sub (%r8), %rax
mov %rax, (%rcx)
mov 8(%rdx), %rax
sbb 8(%r8), %rax
mov %rax, 8(%rcx)
mov 16(%rdx), %rax
sbb 16(%r8), %rax
mov %rax, 16(%rcx)
mov 24(%rdx), %rax
sbb 24(%r8), %rax
mov %rax, 24(%rcx)
mov 32(%rdx), %rax
sbb 32(%r8), %rax
mov %rax, 32(%rcx)
mov 40(%rdx), %rax
sbb 40(%r8), %rax
mov %rax, 40(%rcx)
mov 48(%rdx), %rax
sbb 48(%r8), %rax
mov %rax, 48(%rcx)
mov 56(%rdx), %rax
sbb 56(%r8), %rax
mov %rax, 56(%rcx)
setc %al
movzx %al, %eax
ret
SIZE(mclb_sub8)
.balign 16
.global PRE(mclb_sub9)
PRE(mclb_sub9):
TYPE(mclb_sub9)
mov (%rdx), %rax
sub (%r8), %rax
mov %rax, (%rcx)
mov 8(%rdx), %rax
sbb 8(%r8), %rax
mov %rax, 8(%rcx)
mov 16(%rdx), %rax
sbb 16(%r8), %rax
mov %rax, 16(%rcx)
mov 24(%rdx), %rax
sbb 24(%r8), %rax
mov %rax, 24(%rcx)
mov 32(%rdx), %rax
sbb 32(%r8), %rax
mov %rax, 32(%rcx)
mov 40(%rdx), %rax
sbb 40(%r8), %rax
mov %rax, 40(%rcx)
mov 48(%rdx), %rax
sbb 48(%r8), %rax
mov %rax, 48(%rcx)
mov 56(%rdx), %rax
sbb 56(%r8), %rax
mov %rax, 56(%rcx)
mov 64(%rdx), %rax
sbb 64(%r8), %rax
mov %rax, 64(%rcx)
setc %al
movzx %al, %eax
ret
SIZE(mclb_sub9)
.balign 16
.global PRE(mclb_sub10)
PRE(mclb_sub10):
TYPE(mclb_sub10)
mov (%rdx), %rax
sub (%r8), %rax
mov %rax, (%rcx)
mov 8(%rdx), %rax
sbb 8(%r8), %rax
mov %rax, 8(%rcx)
mov 16(%rdx), %rax
sbb 16(%r8), %rax
mov %rax, 16(%rcx)
mov 24(%rdx), %rax
sbb 24(%r8), %rax
mov %rax, 24(%rcx)
mov 32(%rdx), %rax
sbb 32(%r8), %rax
mov %rax, 32(%rcx)
mov 40(%rdx), %rax
sbb 40(%r8), %rax
mov %rax, 40(%rcx)
mov 48(%rdx), %rax
sbb 48(%r8), %rax
mov %rax, 48(%rcx)
mov 56(%rdx), %rax
sbb 56(%r8), %rax
mov %rax, 56(%rcx)
mov 64(%rdx), %rax
sbb 64(%r8), %rax
mov %rax, 64(%rcx)
mov 72(%rdx), %rax
sbb 72(%r8), %rax
mov %rax, 72(%rcx)
setc %al
movzx %al, %eax
ret
SIZE(mclb_sub10)
.balign 16
.global PRE(mclb_sub11)
PRE(mclb_sub11):
TYPE(mclb_sub11)
mov (%rdx), %rax
sub (%r8), %rax
mov %rax, (%rcx)
mov 8(%rdx), %rax
sbb 8(%r8), %rax
mov %rax, 8(%rcx)
mov 16(%rdx), %rax
sbb 16(%r8), %rax
mov %rax, 16(%rcx)
mov 24(%rdx), %rax
sbb 24(%r8), %rax
mov %rax, 24(%rcx)
mov 32(%rdx), %rax
sbb 32(%r8), %rax
mov %rax, 32(%rcx)
mov 40(%rdx), %rax
sbb 40(%r8), %rax
mov %rax, 40(%rcx)
mov 48(%rdx), %rax
sbb 48(%r8), %rax
mov %rax, 48(%rcx)
mov 56(%rdx), %rax
sbb 56(%r8), %rax
mov %rax, 56(%rcx)
mov 64(%rdx), %rax
sbb 64(%r8), %rax
mov %rax, 64(%rcx)
mov 72(%rdx), %rax
sbb 72(%r8), %rax
mov %rax, 72(%rcx)
mov 80(%rdx), %rax
sbb 80(%r8), %rax
mov %rax, 80(%rcx)
setc %al
movzx %al, %eax
ret
SIZE(mclb_sub11)
.balign 16
.global PRE(mclb_sub12)
PRE(mclb_sub12):
TYPE(mclb_sub12)
mov (%rdx), %rax
sub (%r8), %rax
mov %rax, (%rcx)
mov 8(%rdx), %rax
sbb 8(%r8), %rax
mov %rax, 8(%rcx)
mov 16(%rdx), %rax
sbb 16(%r8), %rax
mov %rax, 16(%rcx)
mov 24(%rdx), %rax
sbb 24(%r8), %rax
mov %rax, 24(%rcx)
mov 32(%rdx), %rax
sbb 32(%r8), %rax
mov %rax, 32(%rcx)
mov 40(%rdx), %rax
sbb 40(%r8), %rax
mov %rax, 40(%rcx)
mov 48(%rdx), %rax
sbb 48(%r8), %rax
mov %rax, 48(%rcx)
mov 56(%rdx), %rax
sbb 56(%r8), %rax
mov %rax, 56(%rcx)
mov 64(%rdx), %rax
sbb 64(%r8), %rax
mov %rax, 64(%rcx)
mov 72(%rdx), %rax
sbb 72(%r8), %rax
mov %rax, 72(%rcx)
mov 80(%rdx), %rax
sbb 80(%r8), %rax
mov %rax, 80(%rcx)
mov 88(%rdx), %rax
sbb 88(%r8), %rax
mov %rax, 88(%rcx)
setc %al
movzx %al, %eax
ret
SIZE(mclb_sub12)
.balign 16
.global PRE(mclb_sub13)
PRE(mclb_sub13):
TYPE(mclb_sub13)
mov (%rdx), %rax
sub (%r8), %rax
mov %rax, (%rcx)
mov 8(%rdx), %rax
sbb 8(%r8), %rax
mov %rax, 8(%rcx)
mov 16(%rdx), %rax
sbb 16(%r8), %rax
mov %rax, 16(%rcx)
mov 24(%rdx), %rax
sbb 24(%r8), %rax
mov %rax, 24(%rcx)
mov 32(%rdx), %rax
sbb 32(%r8), %rax
mov %rax, 32(%rcx)
mov 40(%rdx), %rax
sbb 40(%r8), %rax
mov %rax, 40(%rcx)
mov 48(%rdx), %rax
sbb 48(%r8), %rax
mov %rax, 48(%rcx)
mov 56(%rdx), %rax
sbb 56(%r8), %rax
mov %rax, 56(%rcx)
mov 64(%rdx), %rax
sbb 64(%r8), %rax
mov %rax, 64(%rcx)
mov 72(%rdx), %rax
sbb 72(%r8), %rax
mov %rax, 72(%rcx)
mov 80(%rdx), %rax
sbb 80(%r8), %rax
mov %rax, 80(%rcx)
mov 88(%rdx), %rax
sbb 88(%r8), %rax
mov %rax, 88(%rcx)
mov 96(%rdx), %rax
sbb 96(%r8), %rax
mov %rax, 96(%rcx)
setc %al
movzx %al, %eax
ret
SIZE(mclb_sub13)
.balign 16
.global PRE(mclb_sub14)
PRE(mclb_sub14):
TYPE(mclb_sub14)
mov (%rdx), %rax
sub (%r8), %rax
mov %rax, (%rcx)
mov 8(%rdx), %rax
sbb 8(%r8), %rax
mov %rax, 8(%rcx)
mov 16(%rdx), %rax
sbb 16(%r8), %rax
mov %rax, 16(%rcx)
mov 24(%rdx), %rax
sbb 24(%r8), %rax
mov %rax, 24(%rcx)
mov 32(%rdx), %rax
sbb 32(%r8), %rax
mov %rax, 32(%rcx)
mov 40(%rdx), %rax
sbb 40(%r8), %rax
mov %rax, 40(%rcx)
mov 48(%rdx), %rax
sbb 48(%r8), %rax
mov %rax, 48(%rcx)
mov 56(%rdx), %rax
sbb 56(%r8), %rax
mov %rax, 56(%rcx)
mov 64(%rdx), %rax
sbb 64(%r8), %rax
mov %rax, 64(%rcx)
mov 72(%rdx), %rax
sbb 72(%r8), %rax
mov %rax, 72(%rcx)
mov 80(%rdx), %rax
sbb 80(%r8), %rax
mov %rax, 80(%rcx)
mov 88(%rdx), %rax
sbb 88(%r8), %rax
mov %rax, 88(%rcx)
mov 96(%rdx), %rax
sbb 96(%r8), %rax
mov %rax, 96(%rcx)
mov 104(%rdx), %rax
sbb 104(%r8), %rax
mov %rax, 104(%rcx)
setc %al
movzx %al, %eax
ret
SIZE(mclb_sub14)
.balign 16
.global PRE(mclb_sub15)
PRE(mclb_sub15):
TYPE(mclb_sub15)
mov (%rdx), %rax
sub (%r8), %rax
mov %rax, (%rcx)
mov 8(%rdx), %rax
sbb 8(%r8), %rax
mov %rax, 8(%rcx)
mov 16(%rdx), %rax
sbb 16(%r8), %rax
mov %rax, 16(%rcx)
mov 24(%rdx), %rax
sbb 24(%r8), %rax
mov %rax, 24(%rcx)
mov 32(%rdx), %rax
sbb 32(%r8), %rax
mov %rax, 32(%rcx)
mov 40(%rdx), %rax
sbb 40(%r8), %rax
mov %rax, 40(%rcx)
mov 48(%rdx), %rax
sbb 48(%r8), %rax
mov %rax, 48(%rcx)
mov 56(%rdx), %rax
sbb 56(%r8), %rax
mov %rax, 56(%rcx)
mov 64(%rdx), %rax
sbb 64(%r8), %rax
mov %rax, 64(%rcx)
mov 72(%rdx), %rax
sbb 72(%r8), %rax
mov %rax, 72(%rcx)
mov 80(%rdx), %rax
sbb 80(%r8), %rax
mov %rax, 80(%rcx)
mov 88(%rdx), %rax
sbb 88(%r8), %rax
mov %rax, 88(%rcx)
mov 96(%rdx), %rax
sbb 96(%r8), %rax
mov %rax, 96(%rcx)
mov 104(%rdx), %rax
sbb 104(%r8), %rax
mov %rax, 104(%rcx)
mov 112(%rdx), %rax
sbb 112(%r8), %rax
mov %rax, 112(%rcx)
setc %al
movzx %al, %eax
ret
SIZE(mclb_sub15)
.balign 16
.global PRE(mclb_sub16)
PRE(mclb_sub16):
TYPE(mclb_sub16)
mov (%rdx), %rax
sub (%r8), %rax
mov %rax, (%rcx)
mov 8(%rdx), %rax
sbb 8(%r8), %rax
mov %rax, 8(%rcx)
mov 16(%rdx), %rax
sbb 16(%r8), %rax
mov %rax, 16(%rcx)
mov 24(%rdx), %rax
sbb 24(%r8), %rax
mov %rax, 24(%rcx)
mov 32(%rdx), %rax
sbb 32(%r8), %rax
mov %rax, 32(%rcx)
mov 40(%rdx), %rax
sbb 40(%r8), %rax
mov %rax, 40(%rcx)
mov 48(%rdx), %rax
sbb 48(%r8), %rax
mov %rax, 48(%rcx)
mov 56(%rdx), %rax
sbb 56(%r8), %rax
mov %rax, 56(%rcx)
mov 64(%rdx), %rax
sbb 64(%r8), %rax
mov %rax, 64(%rcx)
mov 72(%rdx), %rax
sbb 72(%r8), %rax
mov %rax, 72(%rcx)
mov 80(%rdx), %rax
sbb 80(%r8), %rax
mov %rax, 80(%rcx)
mov 88(%rdx), %rax
sbb 88(%r8), %rax
mov %rax, 88(%rcx)
mov 96(%rdx), %rax
sbb 96(%r8), %rax
mov %rax, 96(%rcx)
mov 104(%rdx), %rax
sbb 104(%r8), %rax
mov %rax, 104(%rcx)
mov 112(%rdx), %rax
sbb 112(%r8), %rax
mov %rax, 112(%rcx)
mov 120(%rdx), %rax
sbb 120(%r8), %rax
mov %rax, 120(%rcx)
setc %al
movzx %al, %eax
ret
SIZE(mclb_sub16)
.balign 16
.global PRE(mclb_addNF1)
PRE(mclb_addNF1):
TYPE(mclb_addNF1)
mov (%rdx), %rax
add (%r8), %rax
mov %rax, (%rcx)
ret
SIZE(mclb_addNF1)
.balign 16
.global PRE(mclb_addNF2)
PRE(mclb_addNF2):
TYPE(mclb_addNF2)
mov (%rdx), %rax
add (%r8), %rax
mov %rax, (%rcx)
mov 8(%rdx), %rax
adc 8(%r8), %rax
mov %rax, 8(%rcx)
ret
SIZE(mclb_addNF2)
.balign 16
.global PRE(mclb_addNF3)
PRE(mclb_addNF3):
TYPE(mclb_addNF3)
mov (%rdx), %rax
add (%r8), %rax
mov %rax, (%rcx)
mov 8(%rdx), %rax
adc 8(%r8), %rax
mov %rax, 8(%rcx)
mov 16(%rdx), %rax
adc 16(%r8), %rax
mov %rax, 16(%rcx)
ret
SIZE(mclb_addNF3)
.balign 16
.global PRE(mclb_addNF4)
PRE(mclb_addNF4):
TYPE(mclb_addNF4)
mov (%rdx), %rax
add (%r8), %rax
mov %rax, (%rcx)
mov 8(%rdx), %rax
adc 8(%r8), %rax
mov %rax, 8(%rcx)
mov 16(%rdx), %rax
adc 16(%r8), %rax
mov %rax, 16(%rcx)
mov 24(%rdx), %rax
adc 24(%r8), %rax
mov %rax, 24(%rcx)
ret
SIZE(mclb_addNF4)
.balign 16
.global PRE(mclb_addNF5)
PRE(mclb_addNF5):
TYPE(mclb_addNF5)
mov (%rdx), %rax
add (%r8), %rax
mov %rax, (%rcx)
mov 8(%rdx), %rax
adc 8(%r8), %rax
mov %rax, 8(%rcx)
mov 16(%rdx), %rax
adc 16(%r8), %rax
mov %rax, 16(%rcx)
mov 24(%rdx), %rax
adc 24(%r8), %rax
mov %rax, 24(%rcx)
mov 32(%rdx), %rax
adc 32(%r8), %rax
mov %rax, 32(%rcx)
ret
SIZE(mclb_addNF5)
.balign 16
.global PRE(mclb_addNF6)
PRE(mclb_addNF6):
TYPE(mclb_addNF6)
mov (%rdx), %rax
add (%r8), %rax
mov %rax, (%rcx)
mov 8(%rdx), %rax
adc 8(%r8), %rax
mov %rax, 8(%rcx)
mov 16(%rdx), %rax
adc 16(%r8), %rax
mov %rax, 16(%rcx)
mov 24(%rdx), %rax
adc 24(%r8), %rax
mov %rax, 24(%rcx)
mov 32(%rdx), %rax
adc 32(%r8), %rax
mov %rax, 32(%rcx)
mov 40(%rdx), %rax
adc 40(%r8), %rax
mov %rax, 40(%rcx)
ret
SIZE(mclb_addNF6)
.balign 16
.global PRE(mclb_addNF7)
PRE(mclb_addNF7):
TYPE(mclb_addNF7)
mov (%rdx), %rax
add (%r8), %rax
mov %rax, (%rcx)
mov 8(%rdx), %rax
adc 8(%r8), %rax
mov %rax, 8(%rcx)
mov 16(%rdx), %rax
adc 16(%r8), %rax
mov %rax, 16(%rcx)
mov 24(%rdx), %rax
adc 24(%r8), %rax
mov %rax, 24(%rcx)
mov 32(%rdx), %rax
adc 32(%r8), %rax
mov %rax, 32(%rcx)
mov 40(%rdx), %rax
adc 40(%r8), %rax
mov %rax, 40(%rcx)
mov 48(%rdx), %rax
adc 48(%r8), %rax
mov %rax, 48(%rcx)
ret
SIZE(mclb_addNF7)
.balign 16
.global PRE(mclb_addNF8)
PRE(mclb_addNF8):
TYPE(mclb_addNF8)
mov (%rdx), %rax
add (%r8), %rax
mov %rax, (%rcx)
mov 8(%rdx), %rax
adc 8(%r8), %rax
mov %rax, 8(%rcx)
mov 16(%rdx), %rax
adc 16(%r8), %rax
mov %rax, 16(%rcx)
mov 24(%rdx), %rax
adc 24(%r8), %rax
mov %rax, 24(%rcx)
mov 32(%rdx), %rax
adc 32(%r8), %rax
mov %rax, 32(%rcx)
mov 40(%rdx), %rax
adc 40(%r8), %rax
mov %rax, 40(%rcx)
mov 48(%rdx), %rax
adc 48(%r8), %rax
mov %rax, 48(%rcx)
mov 56(%rdx), %rax
adc 56(%r8), %rax
mov %rax, 56(%rcx)
ret
SIZE(mclb_addNF8)
.balign 16
.global PRE(mclb_addNF9)
PRE(mclb_addNF9):
TYPE(mclb_addNF9)
mov (%rdx), %rax
add (%r8), %rax
mov %rax, (%rcx)
mov 8(%rdx), %rax
adc 8(%r8), %rax
mov %rax, 8(%rcx)
mov 16(%rdx), %rax
adc 16(%r8), %rax
mov %rax, 16(%rcx)
mov 24(%rdx), %rax
adc 24(%r8), %rax
mov %rax, 24(%rcx)
mov 32(%rdx), %rax
adc 32(%r8), %rax
mov %rax, 32(%rcx)
mov 40(%rdx), %rax
adc 40(%r8), %rax
mov %rax, 40(%rcx)
mov 48(%rdx), %rax
adc 48(%r8), %rax
mov %rax, 48(%rcx)
mov 56(%rdx), %rax
adc 56(%r8), %rax
mov %rax, 56(%rcx)
mov 64(%rdx), %rax
adc 64(%r8), %rax
mov %rax, 64(%rcx)
ret
SIZE(mclb_addNF9)
.balign 16
.global PRE(mclb_addNF10)
PRE(mclb_addNF10):
TYPE(mclb_addNF10)
mov (%rdx), %rax
add (%r8), %rax
mov %rax, (%rcx)
mov 8(%rdx), %rax
adc 8(%r8), %rax
mov %rax, 8(%rcx)
mov 16(%rdx), %rax
adc 16(%r8), %rax
mov %rax, 16(%rcx)
mov 24(%rdx), %rax
adc 24(%r8), %rax
mov %rax, 24(%rcx)
mov 32(%rdx), %rax
adc 32(%r8), %rax
mov %rax, 32(%rcx)
mov 40(%rdx), %rax
adc 40(%r8), %rax
mov %rax, 40(%rcx)
mov 48(%rdx), %rax
adc 48(%r8), %rax
mov %rax, 48(%rcx)
mov 56(%rdx), %rax
adc 56(%r8), %rax
mov %rax, 56(%rcx)
mov 64(%rdx), %rax
adc 64(%r8), %rax
mov %rax, 64(%rcx)
mov 72(%rdx), %rax
adc 72(%r8), %rax
mov %rax, 72(%rcx)
ret
SIZE(mclb_addNF10)
.balign 16
.global PRE(mclb_addNF11)
PRE(mclb_addNF11):
TYPE(mclb_addNF11)
mov (%rdx), %rax
add (%r8), %rax
mov %rax, (%rcx)
mov 8(%rdx), %rax
adc 8(%r8), %rax
mov %rax, 8(%rcx)
mov 16(%rdx), %rax
adc 16(%r8), %rax
mov %rax, 16(%rcx)
mov 24(%rdx), %rax
adc 24(%r8), %rax
mov %rax, 24(%rcx)
mov 32(%rdx), %rax
adc 32(%r8), %rax
mov %rax, 32(%rcx)
mov 40(%rdx), %rax
adc 40(%r8), %rax
mov %rax, 40(%rcx)
mov 48(%rdx), %rax
adc 48(%r8), %rax
mov %rax, 48(%rcx)
mov 56(%rdx), %rax
adc 56(%r8), %rax
mov %rax, 56(%rcx)
mov 64(%rdx), %rax
adc 64(%r8), %rax
mov %rax, 64(%rcx)
mov 72(%rdx), %rax
adc 72(%r8), %rax
mov %rax, 72(%rcx)
mov 80(%rdx), %rax
adc 80(%r8), %rax
mov %rax, 80(%rcx)
ret
SIZE(mclb_addNF11)
.balign 16
.global PRE(mclb_addNF12)
PRE(mclb_addNF12):
TYPE(mclb_addNF12)
mov (%rdx), %rax
add (%r8), %rax
mov %rax, (%rcx)
mov 8(%rdx), %rax
adc 8(%r8), %rax
mov %rax, 8(%rcx)
mov 16(%rdx), %rax
adc 16(%r8), %rax
mov %rax, 16(%rcx)
mov 24(%rdx), %rax
adc 24(%r8), %rax
mov %rax, 24(%rcx)
mov 32(%rdx), %rax
adc 32(%r8), %rax
mov %rax, 32(%rcx)
mov 40(%rdx), %rax
adc 40(%r8), %rax
mov %rax, 40(%rcx)
mov 48(%rdx), %rax
adc 48(%r8), %rax
mov %rax, 48(%rcx)
mov 56(%rdx), %rax
adc 56(%r8), %rax
mov %rax, 56(%rcx)
mov 64(%rdx), %rax
adc 64(%r8), %rax
mov %rax, 64(%rcx)
mov 72(%rdx), %rax
adc 72(%r8), %rax
mov %rax, 72(%rcx)
mov 80(%rdx), %rax
adc 80(%r8), %rax
mov %rax, 80(%rcx)
mov 88(%rdx), %rax
adc 88(%r8), %rax
mov %rax, 88(%rcx)
ret
SIZE(mclb_addNF12)
.balign 16
.global PRE(mclb_addNF13)
PRE(mclb_addNF13):
TYPE(mclb_addNF13)
mov (%rdx), %rax
add (%r8), %rax
mov %rax, (%rcx)
mov 8(%rdx), %rax
adc 8(%r8), %rax
mov %rax, 8(%rcx)
mov 16(%rdx), %rax
adc 16(%r8), %rax
mov %rax, 16(%rcx)
mov 24(%rdx), %rax
adc 24(%r8), %rax
mov %rax, 24(%rcx)
mov 32(%rdx), %rax
adc 32(%r8), %rax
mov %rax, 32(%rcx)
mov 40(%rdx), %rax
adc 40(%r8), %rax
mov %rax, 40(%rcx)
mov 48(%rdx), %rax
adc 48(%r8), %rax
mov %rax, 48(%rcx)
mov 56(%rdx), %rax
adc 56(%r8), %rax
mov %rax, 56(%rcx)
mov 64(%rdx), %rax
adc 64(%r8), %rax
mov %rax, 64(%rcx)
mov 72(%rdx), %rax
adc 72(%r8), %rax
mov %rax, 72(%rcx)
mov 80(%rdx), %rax
adc 80(%r8), %rax
mov %rax, 80(%rcx)
mov 88(%rdx), %rax
adc 88(%r8), %rax
mov %rax, 88(%rcx)
mov 96(%rdx), %rax
adc 96(%r8), %rax
mov %rax, 96(%rcx)
ret
SIZE(mclb_addNF13)
.balign 16
.global PRE(mclb_addNF14)
PRE(mclb_addNF14):
TYPE(mclb_addNF14)
mov (%rdx), %rax
add (%r8), %rax
mov %rax, (%rcx)
mov 8(%rdx), %rax
adc 8(%r8), %rax
mov %rax, 8(%rcx)
mov 16(%rdx), %rax
adc 16(%r8), %rax
mov %rax, 16(%rcx)
mov 24(%rdx), %rax
adc 24(%r8), %rax
mov %rax, 24(%rcx)
mov 32(%rdx), %rax
adc 32(%r8), %rax
mov %rax, 32(%rcx)
mov 40(%rdx), %rax
adc 40(%r8), %rax
mov %rax, 40(%rcx)
mov 48(%rdx), %rax
adc 48(%r8), %rax
mov %rax, 48(%rcx)
mov 56(%rdx), %rax
adc 56(%r8), %rax
mov %rax, 56(%rcx)
mov 64(%rdx), %rax
adc 64(%r8), %rax
mov %rax, 64(%rcx)
mov 72(%rdx), %rax
adc 72(%r8), %rax
mov %rax, 72(%rcx)
mov 80(%rdx), %rax
adc 80(%r8), %rax
mov %rax, 80(%rcx)
mov 88(%rdx), %rax
adc 88(%r8), %rax
mov %rax, 88(%rcx)
mov 96(%rdx), %rax
adc 96(%r8), %rax
mov %rax, 96(%rcx)
mov 104(%rdx), %rax
adc 104(%r8), %rax
mov %rax, 104(%rcx)
ret
SIZE(mclb_addNF14)
.balign 16
.global PRE(mclb_addNF15)
PRE(mclb_addNF15):
TYPE(mclb_addNF15)
mov (%rdx), %rax
add (%r8), %rax
mov %rax, (%rcx)
mov 8(%rdx), %rax
adc 8(%r8), %rax
mov %rax, 8(%rcx)
mov 16(%rdx), %rax
adc 16(%r8), %rax
mov %rax, 16(%rcx)
mov 24(%rdx), %rax
adc 24(%r8), %rax
mov %rax, 24(%rcx)
mov 32(%rdx), %rax
adc 32(%r8), %rax
mov %rax, 32(%rcx)
mov 40(%rdx), %rax
adc 40(%r8), %rax
mov %rax, 40(%rcx)
mov 48(%rdx), %rax
adc 48(%r8), %rax
mov %rax, 48(%rcx)
mov 56(%rdx), %rax
adc 56(%r8), %rax
mov %rax, 56(%rcx)
mov 64(%rdx), %rax
adc 64(%r8), %rax
mov %rax, 64(%rcx)
mov 72(%rdx), %rax
adc 72(%r8), %rax
mov %rax, 72(%rcx)
mov 80(%rdx), %rax
adc 80(%r8), %rax
mov %rax, 80(%rcx)
mov 88(%rdx), %rax
adc 88(%r8), %rax
mov %rax, 88(%rcx)
mov 96(%rdx), %rax
adc 96(%r8), %rax
mov %rax, 96(%rcx)
mov 104(%rdx), %rax
adc 104(%r8), %rax
mov %rax, 104(%rcx)
mov 112(%rdx), %rax
adc 112(%r8), %rax
mov %rax, 112(%rcx)
ret
SIZE(mclb_addNF15)
.balign 16
.global PRE(mclb_addNF16)
PRE(mclb_addNF16):
TYPE(mclb_addNF16)
mov (%rdx), %rax
add (%r8), %rax
mov %rax, (%rcx)
mov 8(%rdx), %rax
adc 8(%r8), %rax
mov %rax, 8(%rcx)
mov 16(%rdx), %rax
adc 16(%r8), %rax
mov %rax, 16(%rcx)
mov 24(%rdx), %rax
adc 24(%r8), %rax
mov %rax, 24(%rcx)
mov 32(%rdx), %rax
adc 32(%r8), %rax
mov %rax, 32(%rcx)
mov 40(%rdx), %rax
adc 40(%r8), %rax
mov %rax, 40(%rcx)
mov 48(%rdx), %rax
adc 48(%r8), %rax
mov %rax, 48(%rcx)
mov 56(%rdx), %rax
adc 56(%r8), %rax
mov %rax, 56(%rcx)
mov 64(%rdx), %rax
adc 64(%r8), %rax
mov %rax, 64(%rcx)
mov 72(%rdx), %rax
adc 72(%r8), %rax
mov %rax, 72(%rcx)
mov 80(%rdx), %rax
adc 80(%r8), %rax
mov %rax, 80(%rcx)
mov 88(%rdx), %rax
adc 88(%r8), %rax
mov %rax, 88(%rcx)
mov 96(%rdx), %rax
adc 96(%r8), %rax
mov %rax, 96(%rcx)
mov 104(%rdx), %rax
adc 104(%r8), %rax
mov %rax, 104(%rcx)
mov 112(%rdx), %rax
adc 112(%r8), %rax
mov %rax, 112(%rcx)
mov 120(%rdx), %rax
adc 120(%r8), %rax
mov %rax, 120(%rcx)
ret
SIZE(mclb_addNF16)
.balign 16
.global PRE(mclb_subNF1)
PRE(mclb_subNF1):
TYPE(mclb_subNF1)
mov (%rdx), %rax
sub (%r8), %rax
mov %rax, (%rcx)
setc %al
movzx %al, %eax
ret
SIZE(mclb_subNF1)
.balign 16
.global PRE(mclb_subNF2)
PRE(mclb_subNF2):
TYPE(mclb_subNF2)
mov (%rdx), %rax
sub (%r8), %rax
mov %rax, (%rcx)
mov 8(%rdx), %rax
sbb 8(%r8), %rax
mov %rax, 8(%rcx)
setc %al
movzx %al, %eax
ret
SIZE(mclb_subNF2)
.balign 16
.global PRE(mclb_subNF3)
PRE(mclb_subNF3):
TYPE(mclb_subNF3)
mov (%rdx), %rax
sub (%r8), %rax
mov %rax, (%rcx)
mov 8(%rdx), %rax
sbb 8(%r8), %rax
mov %rax, 8(%rcx)
mov 16(%rdx), %rax
sbb 16(%r8), %rax
mov %rax, 16(%rcx)
setc %al
movzx %al, %eax
ret
SIZE(mclb_subNF3)
.balign 16
.global PRE(mclb_subNF4)
PRE(mclb_subNF4):
TYPE(mclb_subNF4)
mov (%rdx), %rax
sub (%r8), %rax
mov %rax, (%rcx)
mov 8(%rdx), %rax
sbb 8(%r8), %rax
mov %rax, 8(%rcx)
mov 16(%rdx), %rax
sbb 16(%r8), %rax
mov %rax, 16(%rcx)
mov 24(%rdx), %rax
sbb 24(%r8), %rax
mov %rax, 24(%rcx)
setc %al
movzx %al, %eax
ret
SIZE(mclb_subNF4)
.balign 16
.global PRE(mclb_subNF5)
PRE(mclb_subNF5):
TYPE(mclb_subNF5)
mov (%rdx), %rax
sub (%r8), %rax
mov %rax, (%rcx)
mov 8(%rdx), %rax
sbb 8(%r8), %rax
mov %rax, 8(%rcx)
mov 16(%rdx), %rax
sbb 16(%r8), %rax
mov %rax, 16(%rcx)
mov 24(%rdx), %rax
sbb 24(%r8), %rax
mov %rax, 24(%rcx)
mov 32(%rdx), %rax
sbb 32(%r8), %rax
mov %rax, 32(%rcx)
setc %al
movzx %al, %eax
ret
SIZE(mclb_subNF5)
.balign 16
.global PRE(mclb_subNF6)
PRE(mclb_subNF6):
TYPE(mclb_subNF6)
mov (%rdx), %rax
sub (%r8), %rax
mov %rax, (%rcx)
mov 8(%rdx), %rax
sbb 8(%r8), %rax
mov %rax, 8(%rcx)
mov 16(%rdx), %rax
sbb 16(%r8), %rax
mov %rax, 16(%rcx)
mov 24(%rdx), %rax
sbb 24(%r8), %rax
mov %rax, 24(%rcx)
mov 32(%rdx), %rax
sbb 32(%r8), %rax
mov %rax, 32(%rcx)
mov 40(%rdx), %rax
sbb 40(%r8), %rax
mov %rax, 40(%rcx)
setc %al
movzx %al, %eax
ret
SIZE(mclb_subNF6)
.balign 16
.global PRE(mclb_subNF7)
PRE(mclb_subNF7):
TYPE(mclb_subNF7)
mov (%rdx), %rax
sub (%r8), %rax
mov %rax, (%rcx)
mov 8(%rdx), %rax
sbb 8(%r8), %rax
mov %rax, 8(%rcx)
mov 16(%rdx), %rax
sbb 16(%r8), %rax
mov %rax, 16(%rcx)
mov 24(%rdx), %rax
sbb 24(%r8), %rax
mov %rax, 24(%rcx)
mov 32(%rdx), %rax
sbb 32(%r8), %rax
mov %rax, 32(%rcx)
mov 40(%rdx), %rax
sbb 40(%r8), %rax
mov %rax, 40(%rcx)
mov 48(%rdx), %rax
sbb 48(%r8), %rax
mov %rax, 48(%rcx)
setc %al
movzx %al, %eax
ret
SIZE(mclb_subNF7)
.balign 16
.global PRE(mclb_subNF8)
PRE(mclb_subNF8):
TYPE(mclb_subNF8)
mov (%rdx), %rax
sub (%r8), %rax
mov %rax, (%rcx)
mov 8(%rdx), %rax
sbb 8(%r8), %rax
mov %rax, 8(%rcx)
mov 16(%rdx), %rax
sbb 16(%r8), %rax
mov %rax, 16(%rcx)
mov 24(%rdx), %rax
sbb 24(%r8), %rax
mov %rax, 24(%rcx)
mov 32(%rdx), %rax
sbb 32(%r8), %rax
mov %rax, 32(%rcx)
mov 40(%rdx), %rax
sbb 40(%r8), %rax
mov %rax, 40(%rcx)
mov 48(%rdx), %rax
sbb 48(%r8), %rax
mov %rax, 48(%rcx)
mov 56(%rdx), %rax
sbb 56(%r8), %rax
mov %rax, 56(%rcx)
setc %al
movzx %al, %eax
ret
SIZE(mclb_subNF8)
.balign 16
.global PRE(mclb_subNF9)
PRE(mclb_subNF9):
TYPE(mclb_subNF9)
mov (%rdx), %rax
sub (%r8), %rax
mov %rax, (%rcx)
mov 8(%rdx), %rax
sbb 8(%r8), %rax
mov %rax, 8(%rcx)
mov 16(%rdx), %rax
sbb 16(%r8), %rax
mov %rax, 16(%rcx)
mov 24(%rdx), %rax
sbb 24(%r8), %rax
mov %rax, 24(%rcx)
mov 32(%rdx), %rax
sbb 32(%r8), %rax
mov %rax, 32(%rcx)
mov 40(%rdx), %rax
sbb 40(%r8), %rax
mov %rax, 40(%rcx)
mov 48(%rdx), %rax
sbb 48(%r8), %rax
mov %rax, 48(%rcx)
mov 56(%rdx), %rax
sbb 56(%r8), %rax
mov %rax, 56(%rcx)
mov 64(%rdx), %rax
sbb 64(%r8), %rax
mov %rax, 64(%rcx)
setc %al
movzx %al, %eax
ret
SIZE(mclb_subNF9)
.balign 16
.global PRE(mclb_subNF10)
PRE(mclb_subNF10):
TYPE(mclb_subNF10)
mov (%rdx), %rax
sub (%r8), %rax
mov %rax, (%rcx)
mov 8(%rdx), %rax
sbb 8(%r8), %rax
mov %rax, 8(%rcx)
mov 16(%rdx), %rax
sbb 16(%r8), %rax
mov %rax, 16(%rcx)
mov 24(%rdx), %rax
sbb 24(%r8), %rax
mov %rax, 24(%rcx)
mov 32(%rdx), %rax
sbb 32(%r8), %rax
mov %rax, 32(%rcx)
mov 40(%rdx), %rax
sbb 40(%r8), %rax
mov %rax, 40(%rcx)
mov 48(%rdx), %rax
sbb 48(%r8), %rax
mov %rax, 48(%rcx)
mov 56(%rdx), %rax
sbb 56(%r8), %rax
mov %rax, 56(%rcx)
mov 64(%rdx), %rax
sbb 64(%r8), %rax
mov %rax, 64(%rcx)
mov 72(%rdx), %rax
sbb 72(%r8), %rax
mov %rax, 72(%rcx)
setc %al
movzx %al, %eax
ret
SIZE(mclb_subNF10)
.balign 16
.global PRE(mclb_subNF11)
PRE(mclb_subNF11):
TYPE(mclb_subNF11)
mov (%rdx), %rax
sub (%r8), %rax
mov %rax, (%rcx)
mov 8(%rdx), %rax
sbb 8(%r8), %rax
mov %rax, 8(%rcx)
mov 16(%rdx), %rax
sbb 16(%r8), %rax
mov %rax, 16(%rcx)
mov 24(%rdx), %rax
sbb 24(%r8), %rax
mov %rax, 24(%rcx)
mov 32(%rdx), %rax
sbb 32(%r8), %rax
mov %rax, 32(%rcx)
mov 40(%rdx), %rax
sbb 40(%r8), %rax
mov %rax, 40(%rcx)
mov 48(%rdx), %rax
sbb 48(%r8), %rax
mov %rax, 48(%rcx)
mov 56(%rdx), %rax
sbb 56(%r8), %rax
mov %rax, 56(%rcx)
mov 64(%rdx), %rax
sbb 64(%r8), %rax
mov %rax, 64(%rcx)
mov 72(%rdx), %rax
sbb 72(%r8), %rax
mov %rax, 72(%rcx)
mov 80(%rdx), %rax
sbb 80(%r8), %rax
mov %rax, 80(%rcx)
setc %al
movzx %al, %eax
ret
SIZE(mclb_subNF11)
.balign 16
.global PRE(mclb_subNF12)
PRE(mclb_subNF12):
TYPE(mclb_subNF12)
mov (%rdx), %rax
sub (%r8), %rax
mov %rax, (%rcx)
mov 8(%rdx), %rax
sbb 8(%r8), %rax
mov %rax, 8(%rcx)
mov 16(%rdx), %rax
sbb 16(%r8), %rax
mov %rax, 16(%rcx)
mov 24(%rdx), %rax
sbb 24(%r8), %rax
mov %rax, 24(%rcx)
mov 32(%rdx), %rax
sbb 32(%r8), %rax
mov %rax, 32(%rcx)
mov 40(%rdx), %rax
sbb 40(%r8), %rax
mov %rax, 40(%rcx)
mov 48(%rdx), %rax
sbb 48(%r8), %rax
mov %rax, 48(%rcx)
mov 56(%rdx), %rax
sbb 56(%r8), %rax
mov %rax, 56(%rcx)
mov 64(%rdx), %rax
sbb 64(%r8), %rax
mov %rax, 64(%rcx)
mov 72(%rdx), %rax
sbb 72(%r8), %rax
mov %rax, 72(%rcx)
mov 80(%rdx), %rax
sbb 80(%r8), %rax
mov %rax, 80(%rcx)
mov 88(%rdx), %rax
sbb 88(%r8), %rax
mov %rax, 88(%rcx)
setc %al
movzx %al, %eax
ret
SIZE(mclb_subNF12)
.balign 16
.global PRE(mclb_subNF13)
PRE(mclb_subNF13):
TYPE(mclb_subNF13)
mov (%rdx), %rax
sub (%r8), %rax
mov %rax, (%rcx)
mov 8(%rdx), %rax
sbb 8(%r8), %rax
mov %rax, 8(%rcx)
mov 16(%rdx), %rax
sbb 16(%r8), %rax
mov %rax, 16(%rcx)
mov 24(%rdx), %rax
sbb 24(%r8), %rax
mov %rax, 24(%rcx)
mov 32(%rdx), %rax
sbb 32(%r8), %rax
mov %rax, 32(%rcx)
mov 40(%rdx), %rax
sbb 40(%r8), %rax
mov %rax, 40(%rcx)
mov 48(%rdx), %rax
sbb 48(%r8), %rax
mov %rax, 48(%rcx)
mov 56(%rdx), %rax
sbb 56(%r8), %rax
mov %rax, 56(%rcx)
mov 64(%rdx), %rax
sbb 64(%r8), %rax
mov %rax, 64(%rcx)
mov 72(%rdx), %rax
sbb 72(%r8), %rax
mov %rax, 72(%rcx)
mov 80(%rdx), %rax
sbb 80(%r8), %rax
mov %rax, 80(%rcx)
mov 88(%rdx), %rax
sbb 88(%r8), %rax
mov %rax, 88(%rcx)
mov 96(%rdx), %rax
sbb 96(%r8), %rax
mov %rax, 96(%rcx)
setc %al
movzx %al, %eax
ret
SIZE(mclb_subNF13)
.balign 16
.global PRE(mclb_subNF14)
PRE(mclb_subNF14):
TYPE(mclb_subNF14)
mov (%rdx), %rax
sub (%r8), %rax
mov %rax, (%rcx)
mov 8(%rdx), %rax
sbb 8(%r8), %rax
mov %rax, 8(%rcx)
mov 16(%rdx), %rax
sbb 16(%r8), %rax
mov %rax, 16(%rcx)
mov 24(%rdx), %rax
sbb 24(%r8), %rax
mov %rax, 24(%rcx)
mov 32(%rdx), %rax
sbb 32(%r8), %rax
mov %rax, 32(%rcx)
mov 40(%rdx), %rax
sbb 40(%r8), %rax
mov %rax, 40(%rcx)
mov 48(%rdx), %rax
sbb 48(%r8), %rax
mov %rax, 48(%rcx)
mov 56(%rdx), %rax
sbb 56(%r8), %rax
mov %rax, 56(%rcx)
mov 64(%rdx), %rax
sbb 64(%r8), %rax
mov %rax, 64(%rcx)
mov 72(%rdx), %rax
sbb 72(%r8), %rax
mov %rax, 72(%rcx)
mov 80(%rdx), %rax
sbb 80(%r8), %rax
mov %rax, 80(%rcx)
mov 88(%rdx), %rax
sbb 88(%r8), %rax
mov %rax, 88(%rcx)
mov 96(%rdx), %rax
sbb 96(%r8), %rax
mov %rax, 96(%rcx)
mov 104(%rdx), %rax
sbb 104(%r8), %rax
mov %rax, 104(%rcx)
setc %al
movzx %al, %eax
ret
SIZE(mclb_subNF14)
.balign 16
.global PRE(mclb_subNF15)
PRE(mclb_subNF15):
TYPE(mclb_subNF15)
mov (%rdx), %rax
sub (%r8), %rax
mov %rax, (%rcx)
mov 8(%rdx), %rax
sbb 8(%r8), %rax
mov %rax, 8(%rcx)
mov 16(%rdx), %rax
sbb 16(%r8), %rax
mov %rax, 16(%rcx)
mov 24(%rdx), %rax
sbb 24(%r8), %rax
mov %rax, 24(%rcx)
mov 32(%rdx), %rax
sbb 32(%r8), %rax
mov %rax, 32(%rcx)
mov 40(%rdx), %rax
sbb 40(%r8), %rax
mov %rax, 40(%rcx)
mov 48(%rdx), %rax
sbb 48(%r8), %rax
mov %rax, 48(%rcx)
mov 56(%rdx), %rax
sbb 56(%r8), %rax
mov %rax, 56(%rcx)
mov 64(%rdx), %rax
sbb 64(%r8), %rax
mov %rax, 64(%rcx)
mov 72(%rdx), %rax
sbb 72(%r8), %rax
mov %rax, 72(%rcx)
mov 80(%rdx), %rax
sbb 80(%r8), %rax
mov %rax, 80(%rcx)
mov 88(%rdx), %rax
sbb 88(%r8), %rax
mov %rax, 88(%rcx)
mov 96(%rdx), %rax
sbb 96(%r8), %rax
mov %rax, 96(%rcx)
mov 104(%rdx), %rax
sbb 104(%r8), %rax
mov %rax, 104(%rcx)
mov 112(%rdx), %rax
sbb 112(%r8), %rax
mov %rax, 112(%rcx)
setc %al
movzx %al, %eax
ret
SIZE(mclb_subNF15)
.balign 16
.global PRE(mclb_subNF16)
PRE(mclb_subNF16):
TYPE(mclb_subNF16)
mov (%rdx), %rax
sub (%r8), %rax
mov %rax, (%rcx)
mov 8(%rdx), %rax
sbb 8(%r8), %rax
mov %rax, 8(%rcx)
mov 16(%rdx), %rax
sbb 16(%r8), %rax
mov %rax, 16(%rcx)
mov 24(%rdx), %rax
sbb 24(%r8), %rax
mov %rax, 24(%rcx)
mov 32(%rdx), %rax
sbb 32(%r8), %rax
mov %rax, 32(%rcx)
mov 40(%rdx), %rax
sbb 40(%r8), %rax
mov %rax, 40(%rcx)
mov 48(%rdx), %rax
sbb 48(%r8), %rax
mov %rax, 48(%rcx)
mov 56(%rdx), %rax
sbb 56(%r8), %rax
mov %rax, 56(%rcx)
mov 64(%rdx), %rax
sbb 64(%r8), %rax
mov %rax, 64(%rcx)
mov 72(%rdx), %rax
sbb 72(%r8), %rax
mov %rax, 72(%rcx)
mov 80(%rdx), %rax
sbb 80(%r8), %rax
mov %rax, 80(%rcx)
mov 88(%rdx), %rax
sbb 88(%r8), %rax
mov %rax, 88(%rcx)
mov 96(%rdx), %rax
sbb 96(%r8), %rax
mov %rax, 96(%rcx)
mov 104(%rdx), %rax
sbb 104(%r8), %rax
mov %rax, 104(%rcx)
mov 112(%rdx), %rax
sbb 112(%r8), %rax
mov %rax, 112(%rcx)
mov 120(%rdx), %rax
sbb 120(%r8), %rax
mov %rax, 120(%rcx)
setc %al
movzx %al, %eax
ret
SIZE(mclb_subNF16)
.balign 16
.global PRE(mclb_mulUnit_fast1)
PRE(mclb_mulUnit_fast1):
TYPE(mclb_mulUnit_fast1)
mov (%rdx), %rax
mul %r8
mov %rax, (%rcx)
mov %rdx, %rax
ret
SIZE(mclb_mulUnit_fast1)
.balign 16
.global PRE(mclb_mulUnit_fast2)
PRE(mclb_mulUnit_fast2):
TYPE(mclb_mulUnit_fast2)
mov %rdx, %r11
mov (%r11), %rax
mul %r8
mov %rax, (%rcx)
mov %rdx, %r9
mov 8(%r11), %rax
mul %r8
add %r9, %rax
adc $0, %rdx
mov %rax, 8(%rcx)
mov %rdx, %rax
ret
SIZE(mclb_mulUnit_fast2)
.balign 16
.global PRE(mclb_mulUnit_fast3)
PRE(mclb_mulUnit_fast3):
TYPE(mclb_mulUnit_fast3)
mov %rdx, %r11
mov %r8, %rdx
mulx (%r11), %rax, %r10
mov %rax, (%rcx)
mulx 8(%r11), %rax, %r9
add %r10, %rax
mov %rax, 8(%rcx)
mulx 16(%r11), %rdx, %rax
adc %r9, %rdx
mov %rdx, 16(%rcx)
adc $0, %rax
ret
SIZE(mclb_mulUnit_fast3)
.balign 16
.global PRE(mclb_mulUnit_fast4)
PRE(mclb_mulUnit_fast4):
TYPE(mclb_mulUnit_fast4)
mov %rdx, %r11
mov %r8, %rdx
mulx (%r11), %rax, %r10
mov %rax, (%rcx)
mulx 8(%r11), %rax, %r9
add %r10, %rax
mov %rax, 8(%rcx)
mulx 16(%r11), %rax, %r10
adc %r9, %rax
mov %rax, 16(%rcx)
mulx 24(%r11), %rdx, %rax
adc %r10, %rdx
mov %rdx, 24(%rcx)
adc $0, %rax
ret
SIZE(mclb_mulUnit_fast4)
.balign 16
.global PRE(mclb_mulUnit_fast5)
PRE(mclb_mulUnit_fast5):
TYPE(mclb_mulUnit_fast5)
mov %rdx, %r11
mov %r8, %rdx
mulx (%r11), %rax, %r10
mov %rax, (%rcx)
mulx 8(%r11), %rax, %r9
add %r10, %rax
mov %rax, 8(%rcx)
mulx 16(%r11), %rax, %r10
adc %r9, %rax
mov %rax, 16(%rcx)
mulx 24(%r11), %rax, %r9
adc %r10, %rax
mov %rax, 24(%rcx)
mulx 32(%r11), %rdx, %rax
adc %r9, %rdx
mov %rdx, 32(%rcx)
adc $0, %rax
ret
SIZE(mclb_mulUnit_fast5)
.balign 16
.global PRE(mclb_mulUnit_fast6)
PRE(mclb_mulUnit_fast6):
TYPE(mclb_mulUnit_fast6)
mov %rdx, %r11
mov %r8, %rdx
mulx (%r11), %rax, %r10
mov %rax, (%rcx)
mulx 8(%r11), %rax, %r9
add %r10, %rax
mov %rax, 8(%rcx)
mulx 16(%r11), %rax, %r10
adc %r9, %rax
mov %rax, 16(%rcx)
mulx 24(%r11), %rax, %r9
adc %r10, %rax
mov %rax, 24(%rcx)
mulx 32(%r11), %rax, %r10
adc %r9, %rax
mov %rax, 32(%rcx)
mulx 40(%r11), %rdx, %rax
adc %r10, %rdx
mov %rdx, 40(%rcx)
adc $0, %rax
ret
SIZE(mclb_mulUnit_fast6)
.balign 16
.global PRE(mclb_mulUnit_fast7)
PRE(mclb_mulUnit_fast7):
TYPE(mclb_mulUnit_fast7)
mov %rdx, %r11
mov %r8, %rdx
mulx (%r11), %rax, %r10
mov %rax, (%rcx)
mulx 8(%r11), %rax, %r9
add %r10, %rax
mov %rax, 8(%rcx)
mulx 16(%r11), %rax, %r10
adc %r9, %rax
mov %rax, 16(%rcx)
mulx 24(%r11), %rax, %r9
adc %r10, %rax
mov %rax, 24(%rcx)
mulx 32(%r11), %rax, %r10
adc %r9, %rax
mov %rax, 32(%rcx)
mulx 40(%r11), %rax, %r9
adc %r10, %rax
mov %rax, 40(%rcx)
mulx 48(%r11), %rdx, %rax
adc %r9, %rdx
mov %rdx, 48(%rcx)
adc $0, %rax
ret
SIZE(mclb_mulUnit_fast7)
.balign 16
.global PRE(mclb_mulUnit_fast8)
PRE(mclb_mulUnit_fast8):
TYPE(mclb_mulUnit_fast8)
mov %rdx, %r11
mov %r8, %rdx
mulx (%r11), %rax, %r10
mov %rax, (%rcx)
mulx 8(%r11), %rax, %r9
add %r10, %rax
mov %rax, 8(%rcx)
mulx 16(%r11), %rax, %r10
adc %r9, %rax
mov %rax, 16(%rcx)
mulx 24(%r11), %rax, %r9
adc %r10, %rax
mov %rax, 24(%rcx)
mulx 32(%r11), %rax, %r10
adc %r9, %rax
mov %rax, 32(%rcx)
mulx 40(%r11), %rax, %r9
adc %r10, %rax
mov %rax, 40(%rcx)
mulx 48(%r11), %rax, %r10
adc %r9, %rax
mov %rax, 48(%rcx)
mulx 56(%r11), %rdx, %rax
adc %r10, %rdx
mov %rdx, 56(%rcx)
adc $0, %rax
ret
SIZE(mclb_mulUnit_fast8)
.balign 16
.global PRE(mclb_mulUnit_fast9)
PRE(mclb_mulUnit_fast9):
TYPE(mclb_mulUnit_fast9)
mov %rdx, %r11
mov %r8, %rdx
mulx (%r11), %rax, %r10
mov %rax, (%rcx)
mulx 8(%r11), %rax, %r9
add %r10, %rax
mov %rax, 8(%rcx)
mulx 16(%r11), %rax, %r10
adc %r9, %rax
mov %rax, 16(%rcx)
mulx 24(%r11), %rax, %r9
adc %r10, %rax
mov %rax, 24(%rcx)
mulx 32(%r11), %rax, %r10
adc %r9, %rax
mov %rax, 32(%rcx)
mulx 40(%r11), %rax, %r9
adc %r10, %rax
mov %rax, 40(%rcx)
mulx 48(%r11), %rax, %r10
adc %r9, %rax
mov %rax, 48(%rcx)
mulx 56(%r11), %rax, %r9
adc %r10, %rax
mov %rax, 56(%rcx)
mulx 64(%r11), %rdx, %rax
adc %r9, %rdx
mov %rdx, 64(%rcx)
adc $0, %rax
ret
SIZE(mclb_mulUnit_fast9)
.balign 16
.global PRE(mclb_mulUnitAdd_fast1)
PRE(mclb_mulUnitAdd_fast1):
TYPE(mclb_mulUnitAdd_fast1)
mov %rdx, %r11
mov %r8, %rdx
xor %eax, %eax
mov (%rcx), %r9
mulx (%r11), %r10, %rax
adox %r10, %r9
mov %r9, (%rcx)
mov $0, %r9
adcx %r9, %rax
adox %r9, %rax
ret
SIZE(mclb_mulUnitAdd_fast1)
.balign 16
.global PRE(mclb_mulUnitAdd_fast2)
PRE(mclb_mulUnitAdd_fast2):
TYPE(mclb_mulUnitAdd_fast2)
mov %rdx, %r11
mov %r8, %rdx
xor %eax, %eax
mov (%rcx), %r9
mulx (%r11), %r10, %rax
adox %r10, %r9
mov %r9, (%rcx)
mov 8(%rcx), %r9
adcx %rax, %r9
mulx 8(%r11), %r10, %rax
adox %r10, %r9
mov %r9, 8(%rcx)
mov $0, %r9
adcx %r9, %rax
adox %r9, %rax
ret
SIZE(mclb_mulUnitAdd_fast2)
.balign 16
.global PRE(mclb_mulUnitAdd_fast3)
PRE(mclb_mulUnitAdd_fast3):
TYPE(mclb_mulUnitAdd_fast3)
mov %rdx, %r11
mov %r8, %rdx
xor %eax, %eax
mov (%rcx), %r9
mulx (%r11), %r10, %rax
adox %r10, %r9
mov %r9, (%rcx)
mov 8(%rcx), %r9
adcx %rax, %r9
mulx 8(%r11), %r10, %rax
adox %r10, %r9
mov %r9, 8(%rcx)
mov 16(%rcx), %r9
adcx %rax, %r9
mulx 16(%r11), %r10, %rax
adox %r10, %r9
mov %r9, 16(%rcx)
mov $0, %r9
adcx %r9, %rax
adox %r9, %rax
ret
SIZE(mclb_mulUnitAdd_fast3)
.balign 16
.global PRE(mclb_mulUnitAdd_fast4)
PRE(mclb_mulUnitAdd_fast4):
TYPE(mclb_mulUnitAdd_fast4)
mov %rdx, %r11
mov %r8, %rdx
xor %eax, %eax
mov (%rcx), %r9
mulx (%r11), %r10, %rax
adox %r10, %r9
mov %r9, (%rcx)
mov 8(%rcx), %r9
adcx %rax, %r9
mulx 8(%r11), %r10, %rax
adox %r10, %r9
mov %r9, 8(%rcx)
mov 16(%rcx), %r9
adcx %rax, %r9
mulx 16(%r11), %r10, %rax
adox %r10, %r9
mov %r9, 16(%rcx)
mov 24(%rcx), %r9
adcx %rax, %r9
mulx 24(%r11), %r10, %rax
adox %r10, %r9
mov %r9, 24(%rcx)
mov $0, %r9
adcx %r9, %rax
adox %r9, %rax
ret
SIZE(mclb_mulUnitAdd_fast4)
.balign 16
.global PRE(mclb_mulUnitAdd_fast5)
PRE(mclb_mulUnitAdd_fast5):
TYPE(mclb_mulUnitAdd_fast5)
mov %rdx, %r11
mov %r8, %rdx
xor %eax, %eax
mov (%rcx), %r9
mulx (%r11), %r10, %rax
adox %r10, %r9
mov %r9, (%rcx)
mov 8(%rcx), %r9
adcx %rax, %r9
mulx 8(%r11), %r10, %rax
adox %r10, %r9
mov %r9, 8(%rcx)
mov 16(%rcx), %r9
adcx %rax, %r9
mulx 16(%r11), %r10, %rax
adox %r10, %r9
mov %r9, 16(%rcx)
mov 24(%rcx), %r9
adcx %rax, %r9
mulx 24(%r11), %r10, %rax
adox %r10, %r9
mov %r9, 24(%rcx)
mov 32(%rcx), %r9
adcx %rax, %r9
mulx 32(%r11), %r10, %rax
adox %r10, %r9
mov %r9, 32(%rcx)
mov $0, %r9
adcx %r9, %rax
adox %r9, %rax
ret
SIZE(mclb_mulUnitAdd_fast5)
.balign 16
.global PRE(mclb_mulUnitAdd_fast6)
PRE(mclb_mulUnitAdd_fast6):
TYPE(mclb_mulUnitAdd_fast6)
mov %rdx, %r11
mov %r8, %rdx
xor %eax, %eax
mov (%rcx), %r9
mulx (%r11), %r10, %rax
adox %r10, %r9
mov %r9, (%rcx)
mov 8(%rcx), %r9
adcx %rax, %r9
mulx 8(%r11), %r10, %rax
adox %r10, %r9
mov %r9, 8(%rcx)
mov 16(%rcx), %r9
adcx %rax, %r9
mulx 16(%r11), %r10, %rax
adox %r10, %r9
mov %r9, 16(%rcx)
mov 24(%rcx), %r9
adcx %rax, %r9
mulx 24(%r11), %r10, %rax
adox %r10, %r9
mov %r9, 24(%rcx)
mov 32(%rcx), %r9
adcx %rax, %r9
mulx 32(%r11), %r10, %rax
adox %r10, %r9
mov %r9, 32(%rcx)
mov 40(%rcx), %r9
adcx %rax, %r9
mulx 40(%r11), %r10, %rax
adox %r10, %r9
mov %r9, 40(%rcx)
mov $0, %r9
adcx %r9, %rax
adox %r9, %rax
ret
SIZE(mclb_mulUnitAdd_fast6)
.balign 16
.global PRE(mclb_mulUnitAdd_fast7)
PRE(mclb_mulUnitAdd_fast7):
TYPE(mclb_mulUnitAdd_fast7)
mov %rdx, %r11
mov %r8, %rdx
xor %eax, %eax
mov (%rcx), %r9
mulx (%r11), %r10, %rax
adox %r10, %r9
mov %r9, (%rcx)
mov 8(%rcx), %r9
adcx %rax, %r9
mulx 8(%r11), %r10, %rax
adox %r10, %r9
mov %r9, 8(%rcx)
mov 16(%rcx), %r9
adcx %rax, %r9
mulx 16(%r11), %r10, %rax
adox %r10, %r9
mov %r9, 16(%rcx)
mov 24(%rcx), %r9
adcx %rax, %r9
mulx 24(%r11), %r10, %rax
adox %r10, %r9
mov %r9, 24(%rcx)
mov 32(%rcx), %r9
adcx %rax, %r9
mulx 32(%r11), %r10, %rax
adox %r10, %r9
mov %r9, 32(%rcx)
mov 40(%rcx), %r9
adcx %rax, %r9
mulx 40(%r11), %r10, %rax
adox %r10, %r9
mov %r9, 40(%rcx)
mov 48(%rcx), %r9
adcx %rax, %r9
mulx 48(%r11), %r10, %rax
adox %r10, %r9
mov %r9, 48(%rcx)
mov $0, %r9
adcx %r9, %rax
adox %r9, %rax
ret
SIZE(mclb_mulUnitAdd_fast7)
.balign 16
.global PRE(mclb_mulUnitAdd_fast8)
PRE(mclb_mulUnitAdd_fast8):
TYPE(mclb_mulUnitAdd_fast8)
mov %rdx, %r11
mov %r8, %rdx
xor %eax, %eax
mov (%rcx), %r9
mulx (%r11), %r10, %rax
adox %r10, %r9
mov %r9, (%rcx)
mov 8(%rcx), %r9
adcx %rax, %r9
mulx 8(%r11), %r10, %rax
adox %r10, %r9
mov %r9, 8(%rcx)
mov 16(%rcx), %r9
adcx %rax, %r9
mulx 16(%r11), %r10, %rax
adox %r10, %r9
mov %r9, 16(%rcx)
mov 24(%rcx), %r9
adcx %rax, %r9
mulx 24(%r11), %r10, %rax
adox %r10, %r9
mov %r9, 24(%rcx)
mov 32(%rcx), %r9
adcx %rax, %r9
mulx 32(%r11), %r10, %rax
adox %r10, %r9
mov %r9, 32(%rcx)
mov 40(%rcx), %r9
adcx %rax, %r9
mulx 40(%r11), %r10, %rax
adox %r10, %r9
mov %r9, 40(%rcx)
mov 48(%rcx), %r9
adcx %rax, %r9
mulx 48(%r11), %r10, %rax
adox %r10, %r9
mov %r9, 48(%rcx)
mov 56(%rcx), %r9
adcx %rax, %r9
mulx 56(%r11), %r10, %rax
adox %r10, %r9
mov %r9, 56(%rcx)
mov $0, %r9
adcx %r9, %rax
adox %r9, %rax
ret
SIZE(mclb_mulUnitAdd_fast8)
.balign 16
.global PRE(mclb_mulUnitAdd_fast9)
PRE(mclb_mulUnitAdd_fast9):
TYPE(mclb_mulUnitAdd_fast9)
mov %rdx, %r11
mov %r8, %rdx
xor %eax, %eax
mov (%rcx), %r9
mulx (%r11), %r10, %rax
adox %r10, %r9
mov %r9, (%rcx)
mov 8(%rcx), %r9
adcx %rax, %r9
mulx 8(%r11), %r10, %rax
adox %r10, %r9
mov %r9, 8(%rcx)
mov 16(%rcx), %r9
adcx %rax, %r9
mulx 16(%r11), %r10, %rax
adox %r10, %r9
mov %r9, 16(%rcx)
mov 24(%rcx), %r9
adcx %rax, %r9
mulx 24(%r11), %r10, %rax
adox %r10, %r9
mov %r9, 24(%rcx)
mov 32(%rcx), %r9
adcx %rax, %r9
mulx 32(%r11), %r10, %rax
adox %r10, %r9
mov %r9, 32(%rcx)
mov 40(%rcx), %r9
adcx %rax, %r9
mulx 40(%r11), %r10, %rax
adox %r10, %r9
mov %r9, 40(%rcx)
mov 48(%rcx), %r9
adcx %rax, %r9
mulx 48(%r11), %r10, %rax
adox %r10, %r9
mov %r9, 48(%rcx)
mov 56(%rcx), %r9
adcx %rax, %r9
mulx 56(%r11), %r10, %rax
adox %r10, %r9
mov %r9, 56(%rcx)
mov 64(%rcx), %r9
adcx %rax, %r9
mulx 64(%r11), %r10, %rax
adox %r10, %r9
mov %r9, 64(%rcx)
mov $0, %r9
adcx %r9, %rax
adox %r9, %rax
ret
SIZE(mclb_mulUnitAdd_fast9)
.balign 16
.global PRE(mclb_mulUnit_slow1)
PRE(mclb_mulUnit_slow1):
TYPE(mclb_mulUnit_slow1)
mov (%rdx), %rax
mul %r8
mov %rax, (%rcx)
mov %rdx, %rax
ret
SIZE(mclb_mulUnit_slow1)
.balign 16
.global PRE(mclb_mulUnit_slow2)
PRE(mclb_mulUnit_slow2):
TYPE(mclb_mulUnit_slow2)
mov %rdx, %r11
mov (%r11), %rax
mul %r8
mov %rax, (%rcx)
mov %rdx, %r9
mov 8(%r11), %rax
mul %r8
add %r9, %rax
adc $0, %rdx
mov %rax, 8(%rcx)
mov %rdx, %rax
ret
SIZE(mclb_mulUnit_slow2)
.balign 16
.global PRE(mclb_mulUnit_slow3)
PRE(mclb_mulUnit_slow3):
TYPE(mclb_mulUnit_slow3)
sub $40, %rsp
mov %rdx, %r11
mov (%r11), %rax
mul %r8
mov %rax, (%rcx)
mov %rdx, 16(%rsp)
mov 8(%r11), %rax
mul %r8
mov %rax, (%rsp)
mov %rdx, 24(%rsp)
mov 16(%r11), %rax
mul %r8
mov %rax, 8(%rsp)
mov 16(%rsp), %rax
add (%rsp), %rax
mov %rax, 8(%rcx)
mov 24(%rsp), %rax
adc 8(%rsp), %rax
mov %rax, 16(%rcx)
adc $0, %rdx
mov %rdx, %rax
add $40, %rsp
ret
SIZE(mclb_mulUnit_slow3)
.balign 16
.global PRE(mclb_mulUnit_slow4)
PRE(mclb_mulUnit_slow4):
TYPE(mclb_mulUnit_slow4)
sub $56, %rsp
mov %rdx, %r11
mov (%r11), %rax
mul %r8
mov %rax, (%rcx)
mov %rdx, 24(%rsp)
mov 8(%r11), %rax
mul %r8
mov %rax, (%rsp)
mov %rdx, 32(%rsp)
mov 16(%r11), %rax
mul %r8
mov %rax, 8(%rsp)
mov %rdx, 40(%rsp)
mov 24(%r11), %rax
mul %r8
mov %rax, 16(%rsp)
mov 24(%rsp), %rax
add (%rsp), %rax
mov %rax, 8(%rcx)
mov 32(%rsp), %rax
adc 8(%rsp), %rax
mov %rax, 16(%rcx)
mov 40(%rsp), %rax
adc 16(%rsp), %rax
mov %rax, 24(%rcx)
adc $0, %rdx
mov %rdx, %rax
add $56, %rsp
ret
SIZE(mclb_mulUnit_slow4)
.balign 16
.global PRE(mclb_mulUnit_slow5)
PRE(mclb_mulUnit_slow5):
TYPE(mclb_mulUnit_slow5)
sub $72, %rsp
mov %rdx, %r11
mov (%r11), %rax
mul %r8
mov %rax, (%rcx)
mov %rdx, 32(%rsp)
mov 8(%r11), %rax
mul %r8
mov %rax, (%rsp)
mov %rdx, 40(%rsp)
mov 16(%r11), %rax
mul %r8
mov %rax, 8(%rsp)
mov %rdx, 48(%rsp)
mov 24(%r11), %rax
mul %r8
mov %rax, 16(%rsp)
mov %rdx, 56(%rsp)
mov 32(%r11), %rax
mul %r8
mov %rax, 24(%rsp)
mov 32(%rsp), %rax
add (%rsp), %rax
mov %rax, 8(%rcx)
mov 40(%rsp), %rax
adc 8(%rsp), %rax
mov %rax, 16(%rcx)
mov 48(%rsp), %rax
adc 16(%rsp), %rax
mov %rax, 24(%rcx)
mov 56(%rsp), %rax
adc 24(%rsp), %rax
mov %rax, 32(%rcx)
adc $0, %rdx
mov %rdx, %rax
add $72, %rsp
ret
SIZE(mclb_mulUnit_slow5)
.balign 16
.global PRE(mclb_mulUnit_slow6)
PRE(mclb_mulUnit_slow6):
TYPE(mclb_mulUnit_slow6)
sub $88, %rsp
mov %rdx, %r11
mov (%r11), %rax
mul %r8
mov %rax, (%rcx)
mov %rdx, 40(%rsp)
mov 8(%r11), %rax
mul %r8
mov %rax, (%rsp)
mov %rdx, 48(%rsp)
mov 16(%r11), %rax
mul %r8
mov %rax, 8(%rsp)
mov %rdx, 56(%rsp)
mov 24(%r11), %rax
mul %r8
mov %rax, 16(%rsp)
mov %rdx, 64(%rsp)
mov 32(%r11), %rax
mul %r8
mov %rax, 24(%rsp)
mov %rdx, 72(%rsp)
mov 40(%r11), %rax
mul %r8
mov %rax, 32(%rsp)
mov 40(%rsp), %rax
add (%rsp), %rax
mov %rax, 8(%rcx)
mov 48(%rsp), %rax
adc 8(%rsp), %rax
mov %rax, 16(%rcx)
mov 56(%rsp), %rax
adc 16(%rsp), %rax
mov %rax, 24(%rcx)
mov 64(%rsp), %rax
adc 24(%rsp), %rax
mov %rax, 32(%rcx)
mov 72(%rsp), %rax
adc 32(%rsp), %rax
mov %rax, 40(%rcx)
adc $0, %rdx
mov %rdx, %rax
add $88, %rsp
ret
SIZE(mclb_mulUnit_slow6)
.balign 16
.global PRE(mclb_mulUnit_slow7)
PRE(mclb_mulUnit_slow7):
TYPE(mclb_mulUnit_slow7)
sub $104, %rsp
mov %rdx, %r11
mov (%r11), %rax
mul %r8
mov %rax, (%rcx)
mov %rdx, 48(%rsp)
mov 8(%r11), %rax
mul %r8
mov %rax, (%rsp)
mov %rdx, 56(%rsp)
mov 16(%r11), %rax
mul %r8
mov %rax, 8(%rsp)
mov %rdx, 64(%rsp)
mov 24(%r11), %rax
mul %r8
mov %rax, 16(%rsp)
mov %rdx, 72(%rsp)
mov 32(%r11), %rax
mul %r8
mov %rax, 24(%rsp)
mov %rdx, 80(%rsp)
mov 40(%r11), %rax
mul %r8
mov %rax, 32(%rsp)
mov %rdx, 88(%rsp)
mov 48(%r11), %rax
mul %r8
mov %rax, 40(%rsp)
mov 48(%rsp), %rax
add (%rsp), %rax
mov %rax, 8(%rcx)
mov 56(%rsp), %rax
adc 8(%rsp), %rax
mov %rax, 16(%rcx)
mov 64(%rsp), %rax
adc 16(%rsp), %rax
mov %rax, 24(%rcx)
mov 72(%rsp), %rax
adc 24(%rsp), %rax
mov %rax, 32(%rcx)
mov 80(%rsp), %rax
adc 32(%rsp), %rax
mov %rax, 40(%rcx)
mov 88(%rsp), %rax
adc 40(%rsp), %rax
mov %rax, 48(%rcx)
adc $0, %rdx
mov %rdx, %rax
add $104, %rsp
ret
SIZE(mclb_mulUnit_slow7)
.balign 16
.global PRE(mclb_mulUnit_slow8)
PRE(mclb_mulUnit_slow8):
TYPE(mclb_mulUnit_slow8)
sub $120, %rsp
mov %rdx, %r11
mov (%r11), %rax
mul %r8
mov %rax, (%rcx)
mov %rdx, 56(%rsp)
mov 8(%r11), %rax
mul %r8
mov %rax, (%rsp)
mov %rdx, 64(%rsp)
mov 16(%r11), %rax
mul %r8
mov %rax, 8(%rsp)
mov %rdx, 72(%rsp)
mov 24(%r11), %rax
mul %r8
mov %rax, 16(%rsp)
mov %rdx, 80(%rsp)
mov 32(%r11), %rax
mul %r8
mov %rax, 24(%rsp)
mov %rdx, 88(%rsp)
mov 40(%r11), %rax
mul %r8
mov %rax, 32(%rsp)
mov %rdx, 96(%rsp)
mov 48(%r11), %rax
mul %r8
mov %rax, 40(%rsp)
mov %rdx, 104(%rsp)
mov 56(%r11), %rax
mul %r8
mov %rax, 48(%rsp)
mov 56(%rsp), %rax
add (%rsp), %rax
mov %rax, 8(%rcx)
mov 64(%rsp), %rax
adc 8(%rsp), %rax
mov %rax, 16(%rcx)
mov 72(%rsp), %rax
adc 16(%rsp), %rax
mov %rax, 24(%rcx)
mov 80(%rsp), %rax
adc 24(%rsp), %rax
mov %rax, 32(%rcx)
mov 88(%rsp), %rax
adc 32(%rsp), %rax
mov %rax, 40(%rcx)
mov 96(%rsp), %rax
adc 40(%rsp), %rax
mov %rax, 48(%rcx)
mov 104(%rsp), %rax
adc 48(%rsp), %rax
mov %rax, 56(%rcx)
adc $0, %rdx
mov %rdx, %rax
add $120, %rsp
ret
SIZE(mclb_mulUnit_slow8)
.balign 16
.global PRE(mclb_mulUnit_slow9)
PRE(mclb_mulUnit_slow9):
TYPE(mclb_mulUnit_slow9)
sub $136, %rsp
mov %rdx, %r11
mov (%r11), %rax
mul %r8
mov %rax, (%rcx)
mov %rdx, 64(%rsp)
mov 8(%r11), %rax
mul %r8
mov %rax, (%rsp)
mov %rdx, 72(%rsp)
mov 16(%r11), %rax
mul %r8
mov %rax, 8(%rsp)
mov %rdx, 80(%rsp)
mov 24(%r11), %rax
mul %r8
mov %rax, 16(%rsp)
mov %rdx, 88(%rsp)
mov 32(%r11), %rax
mul %r8
mov %rax, 24(%rsp)
mov %rdx, 96(%rsp)
mov 40(%r11), %rax
mul %r8
mov %rax, 32(%rsp)
mov %rdx, 104(%rsp)
mov 48(%r11), %rax
mul %r8
mov %rax, 40(%rsp)
mov %rdx, 112(%rsp)
mov 56(%r11), %rax
mul %r8
mov %rax, 48(%rsp)
mov %rdx, 120(%rsp)
mov 64(%r11), %rax
mul %r8
mov %rax, 56(%rsp)
mov 64(%rsp), %rax
add (%rsp), %rax
mov %rax, 8(%rcx)
mov 72(%rsp), %rax
adc 8(%rsp), %rax
mov %rax, 16(%rcx)
mov 80(%rsp), %rax
adc 16(%rsp), %rax
mov %rax, 24(%rcx)
mov 88(%rsp), %rax
adc 24(%rsp), %rax
mov %rax, 32(%rcx)
mov 96(%rsp), %rax
adc 32(%rsp), %rax
mov %rax, 40(%rcx)
mov 104(%rsp), %rax
adc 40(%rsp), %rax
mov %rax, 48(%rcx)
mov 112(%rsp), %rax
adc 48(%rsp), %rax
mov %rax, 56(%rcx)
mov 120(%rsp), %rax
adc 56(%rsp), %rax
mov %rax, 64(%rcx)
adc $0, %rdx
mov %rdx, %rax
add $136, %rsp
ret
SIZE(mclb_mulUnit_slow9)
.balign 16
.global PRE(mclb_mulUnitAdd_slow1)
PRE(mclb_mulUnitAdd_slow1):
TYPE(mclb_mulUnitAdd_slow1)
sub $8, %rsp
mov %rdx, %r11
mov (%r11), %rax
mul %r8
mov %rax, (%rsp)
mov (%rsp), %rax
add %rax, (%rcx)
adc $0, %rdx
mov %rdx, %rax
add $8, %rsp
ret
SIZE(mclb_mulUnitAdd_slow1)
.balign 16
.global PRE(mclb_mulUnitAdd_slow2)
PRE(mclb_mulUnitAdd_slow2):
TYPE(mclb_mulUnitAdd_slow2)
sub $24, %rsp
mov %rdx, %r11
mov (%r11), %rax
mul %r8
mov %rax, (%rsp)
mov %rdx, 16(%rsp)
mov 8(%r11), %rax
mul %r8
mov %rax, 8(%rsp)
mov 8(%rsp), %rax
add 16(%rsp), %rax
mov %rax, 8(%rsp)
adc $0, %rdx
mov (%rsp), %rax
add %rax, (%rcx)
mov 8(%rsp), %rax
adc %rax, 8(%rcx)
adc $0, %rdx
mov %rdx, %rax
add $24, %rsp
ret
SIZE(mclb_mulUnitAdd_slow2)
.balign 16
.global PRE(mclb_mulUnitAdd_slow3)
PRE(mclb_mulUnitAdd_slow3):
TYPE(mclb_mulUnitAdd_slow3)
sub $40, %rsp
mov %rdx, %r11
mov (%r11), %rax
mul %r8
mov %rax, (%rsp)
mov %rdx, 24(%rsp)
mov 8(%r11), %rax
mul %r8
mov %rax, 8(%rsp)
mov %rdx, 32(%rsp)
mov 16(%r11), %rax
mul %r8
mov %rax, 16(%rsp)
mov 8(%rsp), %rax
add 24(%rsp), %rax
mov %rax, 8(%rsp)
mov 16(%rsp), %rax
adc 32(%rsp), %rax
mov %rax, 16(%rsp)
adc $0, %rdx
mov (%rsp), %rax
add %rax, (%rcx)
mov 8(%rsp), %rax
adc %rax, 8(%rcx)
mov 16(%rsp), %rax
adc %rax, 16(%rcx)
adc $0, %rdx
mov %rdx, %rax
add $40, %rsp
ret
SIZE(mclb_mulUnitAdd_slow3)
.balign 16
.global PRE(mclb_mulUnitAdd_slow4)
PRE(mclb_mulUnitAdd_slow4):
TYPE(mclb_mulUnitAdd_slow4)
sub $56, %rsp
mov %rdx, %r11
mov (%r11), %rax
mul %r8
mov %rax, (%rsp)
mov %rdx, 32(%rsp)
mov 8(%r11), %rax
mul %r8
mov %rax, 8(%rsp)
mov %rdx, 40(%rsp)
mov 16(%r11), %rax
mul %r8
mov %rax, 16(%rsp)
mov %rdx, 48(%rsp)
mov 24(%r11), %rax
mul %r8
mov %rax, 24(%rsp)
mov 8(%rsp), %rax
add 32(%rsp), %rax
mov %rax, 8(%rsp)
mov 16(%rsp), %rax
adc 40(%rsp), %rax
mov %rax, 16(%rsp)
mov 24(%rsp), %rax
adc 48(%rsp), %rax
mov %rax, 24(%rsp)
adc $0, %rdx
mov (%rsp), %rax
add %rax, (%rcx)
mov 8(%rsp), %rax
adc %rax, 8(%rcx)
mov 16(%rsp), %rax
adc %rax, 16(%rcx)
mov 24(%rsp), %rax
adc %rax, 24(%rcx)
adc $0, %rdx
mov %rdx, %rax
add $56, %rsp
ret
SIZE(mclb_mulUnitAdd_slow4)
.balign 16
.global PRE(mclb_mulUnitAdd_slow5)
PRE(mclb_mulUnitAdd_slow5):
TYPE(mclb_mulUnitAdd_slow5)
sub $72, %rsp
mov %rdx, %r11
mov (%r11), %rax
mul %r8
mov %rax, (%rsp)
mov %rdx, 40(%rsp)
mov 8(%r11), %rax
mul %r8
mov %rax, 8(%rsp)
mov %rdx, 48(%rsp)
mov 16(%r11), %rax
mul %r8
mov %rax, 16(%rsp)
mov %rdx, 56(%rsp)
mov 24(%r11), %rax
mul %r8
mov %rax, 24(%rsp)
mov %rdx, 64(%rsp)
mov 32(%r11), %rax
mul %r8
mov %rax, 32(%rsp)
mov 8(%rsp), %rax
add 40(%rsp), %rax
mov %rax, 8(%rsp)
mov 16(%rsp), %rax
adc 48(%rsp), %rax
mov %rax, 16(%rsp)
mov 24(%rsp), %rax
adc 56(%rsp), %rax
mov %rax, 24(%rsp)
mov 32(%rsp), %rax
adc 64(%rsp), %rax
mov %rax, 32(%rsp)
adc $0, %rdx
mov (%rsp), %rax
add %rax, (%rcx)
mov 8(%rsp), %rax
adc %rax, 8(%rcx)
mov 16(%rsp), %rax
adc %rax, 16(%rcx)
mov 24(%rsp), %rax
adc %rax, 24(%rcx)
mov 32(%rsp), %rax
adc %rax, 32(%rcx)
adc $0, %rdx
mov %rdx, %rax
add $72, %rsp
ret
SIZE(mclb_mulUnitAdd_slow5)
.balign 16
.global PRE(mclb_mulUnitAdd_slow6)
PRE(mclb_mulUnitAdd_slow6):
TYPE(mclb_mulUnitAdd_slow6)
sub $88, %rsp
mov %rdx, %r11
mov (%r11), %rax
mul %r8
mov %rax, (%rsp)
mov %rdx, 48(%rsp)
mov 8(%r11), %rax
mul %r8
mov %rax, 8(%rsp)
mov %rdx, 56(%rsp)
mov 16(%r11), %rax
mul %r8
mov %rax, 16(%rsp)
mov %rdx, 64(%rsp)
mov 24(%r11), %rax
mul %r8
mov %rax, 24(%rsp)
mov %rdx, 72(%rsp)
mov 32(%r11), %rax
mul %r8
mov %rax, 32(%rsp)
mov %rdx, 80(%rsp)
mov 40(%r11), %rax
mul %r8
mov %rax, 40(%rsp)
mov 8(%rsp), %rax
add 48(%rsp), %rax
mov %rax, 8(%rsp)
mov 16(%rsp), %rax
adc 56(%rsp), %rax
mov %rax, 16(%rsp)
mov 24(%rsp), %rax
adc 64(%rsp), %rax
mov %rax, 24(%rsp)
mov 32(%rsp), %rax
adc 72(%rsp), %rax
mov %rax, 32(%rsp)
mov 40(%rsp), %rax
adc 80(%rsp), %rax
mov %rax, 40(%rsp)
adc $0, %rdx
mov (%rsp), %rax
add %rax, (%rcx)
mov 8(%rsp), %rax
adc %rax, 8(%rcx)
mov 16(%rsp), %rax
adc %rax, 16(%rcx)
mov 24(%rsp), %rax
adc %rax, 24(%rcx)
mov 32(%rsp), %rax
adc %rax, 32(%rcx)
mov 40(%rsp), %rax
adc %rax, 40(%rcx)
adc $0, %rdx
mov %rdx, %rax
add $88, %rsp
ret
SIZE(mclb_mulUnitAdd_slow6)
.balign 16
.global PRE(mclb_mulUnitAdd_slow7)
PRE(mclb_mulUnitAdd_slow7):
TYPE(mclb_mulUnitAdd_slow7)
sub $104, %rsp
mov %rdx, %r11
mov (%r11), %rax
mul %r8
mov %rax, (%rsp)
mov %rdx, 56(%rsp)
mov 8(%r11), %rax
mul %r8
mov %rax, 8(%rsp)
mov %rdx, 64(%rsp)
mov 16(%r11), %rax
mul %r8
mov %rax, 16(%rsp)
mov %rdx, 72(%rsp)
mov 24(%r11), %rax
mul %r8
mov %rax, 24(%rsp)
mov %rdx, 80(%rsp)
mov 32(%r11), %rax
mul %r8
mov %rax, 32(%rsp)
mov %rdx, 88(%rsp)
mov 40(%r11), %rax
mul %r8
mov %rax, 40(%rsp)
mov %rdx, 96(%rsp)
mov 48(%r11), %rax
mul %r8
mov %rax, 48(%rsp)
mov 8(%rsp), %rax
add 56(%rsp), %rax
mov %rax, 8(%rsp)
mov 16(%rsp), %rax
adc 64(%rsp), %rax
mov %rax, 16(%rsp)
mov 24(%rsp), %rax
adc 72(%rsp), %rax
mov %rax, 24(%rsp)
mov 32(%rsp), %rax
adc 80(%rsp), %rax
mov %rax, 32(%rsp)
mov 40(%rsp), %rax
adc 88(%rsp), %rax
mov %rax, 40(%rsp)
mov 48(%rsp), %rax
adc 96(%rsp), %rax
mov %rax, 48(%rsp)
adc $0, %rdx
mov (%rsp), %rax
add %rax, (%rcx)
mov 8(%rsp), %rax
adc %rax, 8(%rcx)
mov 16(%rsp), %rax
adc %rax, 16(%rcx)
mov 24(%rsp), %rax
adc %rax, 24(%rcx)
mov 32(%rsp), %rax
adc %rax, 32(%rcx)
mov 40(%rsp), %rax
adc %rax, 40(%rcx)
mov 48(%rsp), %rax
adc %rax, 48(%rcx)
adc $0, %rdx
mov %rdx, %rax
add $104, %rsp
ret
SIZE(mclb_mulUnitAdd_slow7)
.balign 16
.global PRE(mclb_mulUnitAdd_slow8)
PRE(mclb_mulUnitAdd_slow8):
TYPE(mclb_mulUnitAdd_slow8)
sub $120, %rsp
mov %rdx, %r11
mov (%r11), %rax
mul %r8
mov %rax, (%rsp)
mov %rdx, 64(%rsp)
mov 8(%r11), %rax
mul %r8
mov %rax, 8(%rsp)
mov %rdx, 72(%rsp)
mov 16(%r11), %rax
mul %r8
mov %rax, 16(%rsp)
mov %rdx, 80(%rsp)
mov 24(%r11), %rax
mul %r8
mov %rax, 24(%rsp)
mov %rdx, 88(%rsp)
mov 32(%r11), %rax
mul %r8
mov %rax, 32(%rsp)
mov %rdx, 96(%rsp)
mov 40(%r11), %rax
mul %r8
mov %rax, 40(%rsp)
mov %rdx, 104(%rsp)
mov 48(%r11), %rax
mul %r8
mov %rax, 48(%rsp)
mov %rdx, 112(%rsp)
mov 56(%r11), %rax
mul %r8
mov %rax, 56(%rsp)
mov 8(%rsp), %rax
add 64(%rsp), %rax
mov %rax, 8(%rsp)
mov 16(%rsp), %rax
adc 72(%rsp), %rax
mov %rax, 16(%rsp)
mov 24(%rsp), %rax
adc 80(%rsp), %rax
mov %rax, 24(%rsp)
mov 32(%rsp), %rax
adc 88(%rsp), %rax
mov %rax, 32(%rsp)
mov 40(%rsp), %rax
adc 96(%rsp), %rax
mov %rax, 40(%rsp)
mov 48(%rsp), %rax
adc 104(%rsp), %rax
mov %rax, 48(%rsp)
mov 56(%rsp), %rax
adc 112(%rsp), %rax
mov %rax, 56(%rsp)
adc $0, %rdx
mov (%rsp), %rax
add %rax, (%rcx)
mov 8(%rsp), %rax
adc %rax, 8(%rcx)
mov 16(%rsp), %rax
adc %rax, 16(%rcx)
mov 24(%rsp), %rax
adc %rax, 24(%rcx)
mov 32(%rsp), %rax
adc %rax, 32(%rcx)
mov 40(%rsp), %rax
adc %rax, 40(%rcx)
mov 48(%rsp), %rax
adc %rax, 48(%rcx)
mov 56(%rsp), %rax
adc %rax, 56(%rcx)
adc $0, %rdx
mov %rdx, %rax
add $120, %rsp
ret
SIZE(mclb_mulUnitAdd_slow8)
.balign 16
.global PRE(mclb_mulUnitAdd_slow9)
PRE(mclb_mulUnitAdd_slow9):
TYPE(mclb_mulUnitAdd_slow9)
sub $136, %rsp
mov %rdx, %r11
mov (%r11), %rax
mul %r8
mov %rax, (%rsp)
mov %rdx, 72(%rsp)
mov 8(%r11), %rax
mul %r8
mov %rax, 8(%rsp)
mov %rdx, 80(%rsp)
mov 16(%r11), %rax
mul %r8
mov %rax, 16(%rsp)
mov %rdx, 88(%rsp)
mov 24(%r11), %rax
mul %r8
mov %rax, 24(%rsp)
mov %rdx, 96(%rsp)
mov 32(%r11), %rax
mul %r8
mov %rax, 32(%rsp)
mov %rdx, 104(%rsp)
mov 40(%r11), %rax
mul %r8
mov %rax, 40(%rsp)
mov %rdx, 112(%rsp)
mov 48(%r11), %rax
mul %r8
mov %rax, 48(%rsp)
mov %rdx, 120(%rsp)
mov 56(%r11), %rax
mul %r8
mov %rax, 56(%rsp)
mov %rdx, 128(%rsp)
mov 64(%r11), %rax
mul %r8
mov %rax, 64(%rsp)
mov 8(%rsp), %rax
add 72(%rsp), %rax
mov %rax, 8(%rsp)
mov 16(%rsp), %rax
adc 80(%rsp), %rax
mov %rax, 16(%rsp)
mov 24(%rsp), %rax
adc 88(%rsp), %rax
mov %rax, 24(%rsp)
mov 32(%rsp), %rax
adc 96(%rsp), %rax
mov %rax, 32(%rsp)
mov 40(%rsp), %rax
adc 104(%rsp), %rax
mov %rax, 40(%rsp)
mov 48(%rsp), %rax
adc 112(%rsp), %rax
mov %rax, 48(%rsp)
mov 56(%rsp), %rax
adc 120(%rsp), %rax
mov %rax, 56(%rsp)
mov 64(%rsp), %rax
adc 128(%rsp), %rax
mov %rax, 64(%rsp)
adc $0, %rdx
mov (%rsp), %rax
add %rax, (%rcx)
mov 8(%rsp), %rax
adc %rax, 8(%rcx)
mov 16(%rsp), %rax
adc %rax, 16(%rcx)
mov 24(%rsp), %rax
adc %rax, 24(%rcx)
mov 32(%rsp), %rax
adc %rax, 32(%rcx)
mov 40(%rsp), %rax
adc %rax, 40(%rcx)
mov 48(%rsp), %rax
adc %rax, 48(%rcx)
mov 56(%rsp), %rax
adc %rax, 56(%rcx)
mov 64(%rsp), %rax
adc %rax, 64(%rcx)
adc $0, %rdx
mov %rdx, %rax
add $136, %rsp
ret
SIZE(mclb_mulUnitAdd_slow9)
.balign 16
.global PRE(mclb_mul_fast1)
PRE(mclb_mul_fast1):
TYPE(mclb_mul_fast1)
mov %rdx, %r11
mov (%r11), %rax
mov (%r8), %rdx
mul %rdx
mov %rax, (%rcx)
mov %rdx, 8(%rcx)
ret
SIZE(mclb_mul_fast1)
.balign 16
.global PRE(mclb_mul_fast2)
PRE(mclb_mul_fast2):
TYPE(mclb_mul_fast2)
push %rdi
mov %rdx, %r11
mov (%r11), %rdx
mulx (%r8), %rax, %r9
mov %rax, (%rcx)
mulx 8(%r8), %rax, %r10
add %rax, %r9
adc $0, %r10
mov 8(%r11), %rdx
xor %rax, %rax
mulx (%r8), %rax, %rdi
adox %rax, %r9
mov %r9, 8(%rcx)
adcx %rdi, %r10
mulx 8(%r8), %rax, %rdi
adox %rax, %r10
mov $0, %rax
adox %rax, %rdi
adc %rax, %rdi
mov %r10, 16(%rcx)
mov %rdi, 24(%rcx)
pop %rdi
ret
SIZE(mclb_mul_fast2)
.balign 16
.global PRE(mclb_mul_fast3)
PRE(mclb_mul_fast3):
TYPE(mclb_mul_fast3)
push %rdi
push %rsi
mov %rdx, %r11
mov (%r11), %rdx
mulx (%r8), %rax, %r9
mov %rax, (%rcx)
mulx 8(%r8), %rax, %r10
add %rax, %r9
mulx 16(%r8), %rax, %rdi
adc %rax, %r10
adc $0, %rdi
mov 8(%r11), %rdx
xor %rax, %rax
mulx (%r8), %rax, %rsi
adox %rax, %r9
mov %r9, 8(%rcx)
adcx %rsi, %r10
mulx 8(%r8), %rax, %rsi
adox %rax, %r10
adcx %rsi, %rdi
mulx 16(%r8), %rax, %rsi
adox %rax, %rdi
mov $0, %rax
adox %rax, %rsi
adc %rax, %rsi
mov 16(%r11), %rdx
xor %rax, %rax
mulx (%r8), %rax, %r9
adox %rax, %r10
mov %r10, 16(%rcx)
adcx %r9, %rdi
mulx 8(%r8), %rax, %r9
adox %rax, %rdi
adcx %r9, %rsi
mulx 16(%r8), %rax, %r9
adox %rax, %rsi
mov $0, %rax
adox %rax, %r9
adc %rax, %r9
mov %rdi, 24(%rcx)
mov %rsi, 32(%rcx)
mov %r9, 40(%rcx)
pop %rsi
pop %rdi
ret
SIZE(mclb_mul_fast3)
.balign 16
.global PRE(mclb_mul_fast4)
PRE(mclb_mul_fast4):
TYPE(mclb_mul_fast4)
push %rdi
push %rsi
push %rbx
mov %rdx, %r11
mov (%r11), %rdx
mulx (%r8), %rax, %r9
mov %rax, (%rcx)
mulx 8(%r8), %rax, %r10
add %rax, %r9
mulx 16(%r8), %rax, %rdi
adc %rax, %r10
mulx 24(%r8), %rax, %rsi
adc %rax, %rdi
adc $0, %rsi
mov 8(%r11), %rdx
xor %rax, %rax
mulx (%r8), %rax, %rbx
adox %rax, %r9
mov %r9, 8(%rcx)
adcx %rbx, %r10
mulx 8(%r8), %rax, %rbx
adox %rax, %r10
adcx %rbx, %rdi
mulx 16(%r8), %rax, %rbx
adox %rax, %rdi
adcx %rbx, %rsi
mulx 24(%r8), %rax, %rbx
adox %rax, %rsi
mov $0, %rax
adox %rax, %rbx
adc %rax, %rbx
mov 16(%r11), %rdx
xor %rax, %rax
mulx (%r8), %rax, %r9
adox %rax, %r10
mov %r10, 16(%rcx)
adcx %r9, %rdi
mulx 8(%r8), %rax, %r9
adox %rax, %rdi
adcx %r9, %rsi
mulx 16(%r8), %rax, %r9
adox %rax, %rsi
adcx %r9, %rbx
mulx 24(%r8), %rax, %r9
adox %rax, %rbx
mov $0, %rax
adox %rax, %r9
adc %rax, %r9
mov 24(%r11), %rdx
xor %rax, %rax
mulx (%r8), %rax, %r10
adox %rax, %rdi
mov %rdi, 24(%rcx)
adcx %r10, %rsi
mulx 8(%r8), %rax, %r10
adox %rax, %rsi
adcx %r10, %rbx
mulx 16(%r8), %rax, %r10
adox %rax, %rbx
adcx %r10, %r9
mulx 24(%r8), %rax, %r10
adox %rax, %r9
mov $0, %rax
adox %rax, %r10
adc %rax, %r10
mov %rsi, 32(%rcx)
mov %rbx, 40(%rcx)
mov %r9, 48(%rcx)
mov %r10, 56(%rcx)
pop %rbx
pop %rsi
pop %rdi
ret
SIZE(mclb_mul_fast4)
.balign 16
.global PRE(mclb_mul_fast5)
PRE(mclb_mul_fast5):
TYPE(mclb_mul_fast5)
push %rdi
push %rsi
push %rbx
push %rbp
mov %rdx, %r11
mov (%r11), %rdx
mulx (%r8), %rax, %r9
mov %rax, (%rcx)
mulx 8(%r8), %rax, %r10
add %rax, %r9
mulx 16(%r8), %rax, %rdi
adc %rax, %r10
mulx 24(%r8), %rax, %rsi
adc %rax, %rdi
mulx 32(%r8), %rax, %rbx
adc %rax, %rsi
adc $0, %rbx
mov 8(%r11), %rdx
xor %rax, %rax
mulx (%r8), %rax, %rbp
adox %rax, %r9
mov %r9, 8(%rcx)
adcx %rbp, %r10
mulx 8(%r8), %rax, %rbp
adox %rax, %r10
adcx %rbp, %rdi
mulx 16(%r8), %rax, %rbp
adox %rax, %rdi
adcx %rbp, %rsi
mulx 24(%r8), %rax, %rbp
adox %rax, %rsi
adcx %rbp, %rbx
mulx 32(%r8), %rax, %rbp
adox %rax, %rbx
mov $0, %rax
adox %rax, %rbp
adc %rax, %rbp
mov 16(%r11), %rdx
xor %rax, %rax
mulx (%r8), %rax, %r9
adox %rax, %r10
mov %r10, 16(%rcx)
adcx %r9, %rdi
mulx 8(%r8), %rax, %r9
adox %rax, %rdi
adcx %r9, %rsi
mulx 16(%r8), %rax, %r9
adox %rax, %rsi
adcx %r9, %rbx
mulx 24(%r8), %rax, %r9
adox %rax, %rbx
adcx %r9, %rbp
mulx 32(%r8), %rax, %r9
adox %rax, %rbp
mov $0, %rax
adox %rax, %r9
adc %rax, %r9
mov 24(%r11), %rdx
xor %rax, %rax
mulx (%r8), %rax, %r10
adox %rax, %rdi
mov %rdi, 24(%rcx)
adcx %r10, %rsi
mulx 8(%r8), %rax, %r10
adox %rax, %rsi
adcx %r10, %rbx
mulx 16(%r8), %rax, %r10
adox %rax, %rbx
adcx %r10, %rbp
mulx 24(%r8), %rax, %r10
adox %rax, %rbp
adcx %r10, %r9
mulx 32(%r8), %rax, %r10
adox %rax, %r9
mov $0, %rax
adox %rax, %r10
adc %rax, %r10
mov 32(%r11), %rdx
xor %rax, %rax
mulx (%r8), %rax, %rdi
adox %rax, %rsi
mov %rsi, 32(%rcx)
adcx %rdi, %rbx
mulx 8(%r8), %rax, %rdi
adox %rax, %rbx
adcx %rdi, %rbp
mulx 16(%r8), %rax, %rdi
adox %rax, %rbp
adcx %rdi, %r9
mulx 24(%r8), %rax, %rdi
adox %rax, %r9
adcx %rdi, %r10
mulx 32(%r8), %rax, %rdi
adox %rax, %r10
mov $0, %rax
adox %rax, %rdi
adc %rax, %rdi
mov %rbx, 40(%rcx)
mov %rbp, 48(%rcx)
mov %r9, 56(%rcx)
mov %r10, 64(%rcx)
mov %rdi, 72(%rcx)
pop %rbp
pop %rbx
pop %rsi
pop %rdi
ret
SIZE(mclb_mul_fast5)
.balign 16
.global PRE(mclb_mul_fast6)
PRE(mclb_mul_fast6):
TYPE(mclb_mul_fast6)
push %rdi
push %rsi
push %rbx
push %rbp
push %r12
mov %rdx, %r11
mov (%r11), %rdx
mulx (%r8), %rax, %r9
mov %rax, (%rcx)
mulx 8(%r8), %rax, %r10
add %rax, %r9
mulx 16(%r8), %rax, %rdi
adc %rax, %r10
mulx 24(%r8), %rax, %rsi
adc %rax, %rdi
mulx 32(%r8), %rax, %rbx
adc %rax, %rsi
mulx 40(%r8), %rax, %rbp
adc %rax, %rbx
adc $0, %rbp
mov 8(%r11), %rdx
xor %rax, %rax
mulx (%r8), %rax, %r12
adox %rax, %r9
mov %r9, 8(%rcx)
adcx %r12, %r10
mulx 8(%r8), %rax, %r12
adox %rax, %r10
adcx %r12, %rdi
mulx 16(%r8), %rax, %r12
adox %rax, %rdi
adcx %r12, %rsi
mulx 24(%r8), %rax, %r12
adox %rax, %rsi
adcx %r12, %rbx
mulx 32(%r8), %rax, %r12
adox %rax, %rbx
adcx %r12, %rbp
mulx 40(%r8), %rax, %r12
adox %rax, %rbp
mov $0, %rax
adox %rax, %r12
adc %rax, %r12
mov 16(%r11), %rdx
xor %rax, %rax
mulx (%r8), %rax, %r9
adox %rax, %r10
mov %r10, 16(%rcx)
adcx %r9, %rdi
mulx 8(%r8), %rax, %r9
adox %rax, %rdi
adcx %r9, %rsi
mulx 16(%r8), %rax, %r9
adox %rax, %rsi
adcx %r9, %rbx
mulx 24(%r8), %rax, %r9
adox %rax, %rbx
adcx %r9, %rbp
mulx 32(%r8), %rax, %r9
adox %rax, %rbp
adcx %r9, %r12
mulx 40(%r8), %rax, %r9
adox %rax, %r12
mov $0, %rax
adox %rax, %r9
adc %rax, %r9
mov 24(%r11), %rdx
xor %rax, %rax
mulx (%r8), %rax, %r10
adox %rax, %rdi
mov %rdi, 24(%rcx)
adcx %r10, %rsi
mulx 8(%r8), %rax, %r10
adox %rax, %rsi
adcx %r10, %rbx
mulx 16(%r8), %rax, %r10
adox %rax, %rbx
adcx %r10, %rbp
mulx 24(%r8), %rax, %r10
adox %rax, %rbp
adcx %r10, %r12
mulx 32(%r8), %rax, %r10
adox %rax, %r12
adcx %r10, %r9
mulx 40(%r8), %rax, %r10
adox %rax, %r9
mov $0, %rax
adox %rax, %r10
adc %rax, %r10
mov 32(%r11), %rdx
xor %rax, %rax
mulx (%r8), %rax, %rdi
adox %rax, %rsi
mov %rsi, 32(%rcx)
adcx %rdi, %rbx
mulx 8(%r8), %rax, %rdi
adox %rax, %rbx
adcx %rdi, %rbp
mulx 16(%r8), %rax, %rdi
adox %rax, %rbp
adcx %rdi, %r12
mulx 24(%r8), %rax, %rdi
adox %rax, %r12
adcx %rdi, %r9
mulx 32(%r8), %rax, %rdi
adox %rax, %r9
adcx %rdi, %r10
mulx 40(%r8), %rax, %rdi
adox %rax, %r10
mov $0, %rax
adox %rax, %rdi
adc %rax, %rdi
mov 40(%r11), %rdx
xor %rax, %rax
mulx (%r8), %rax, %rsi
adox %rax, %rbx
mov %rbx, 40(%rcx)
adcx %rsi, %rbp
mulx 8(%r8), %rax, %rsi
adox %rax, %rbp
adcx %rsi, %r12
mulx 16(%r8), %rax, %rsi
adox %rax, %r12
adcx %rsi, %r9
mulx 24(%r8), %rax, %rsi
adox %rax, %r9
adcx %rsi, %r10
mulx 32(%r8), %rax, %rsi
adox %rax, %r10
adcx %rsi, %rdi
mulx 40(%r8), %rax, %rsi
adox %rax, %rdi
mov $0, %rax
adox %rax, %rsi
adc %rax, %rsi
mov %rbp, 48(%rcx)
mov %r12, 56(%rcx)
mov %r9, 64(%rcx)
mov %r10, 72(%rcx)
mov %rdi, 80(%rcx)
mov %rsi, 88(%rcx)
pop %r12
pop %rbp
pop %rbx
pop %rsi
pop %rdi
ret
SIZE(mclb_mul_fast6)
.balign 16
.global PRE(mclb_mul_fast7)
PRE(mclb_mul_fast7):
TYPE(mclb_mul_fast7)
push %rdi
push %rsi
push %rbx
push %rbp
push %r12
push %r13
mov %rdx, %r11
mov (%r11), %rdx
mulx (%r8), %rax, %r9
mov %rax, (%rcx)
mulx 8(%r8), %rax, %r10
add %rax, %r9
mulx 16(%r8), %rax, %rdi
adc %rax, %r10
mulx 24(%r8), %rax, %rsi
adc %rax, %rdi
mulx 32(%r8), %rax, %rbx
adc %rax, %rsi
mulx 40(%r8), %rax, %rbp
adc %rax, %rbx
mulx 48(%r8), %rax, %r12
adc %rax, %rbp
adc $0, %r12
mov 8(%r11), %rdx
xor %rax, %rax
mulx (%r8), %rax, %r13
adox %rax, %r9
mov %r9, 8(%rcx)
adcx %r13, %r10
mulx 8(%r8), %rax, %r13
adox %rax, %r10
adcx %r13, %rdi
mulx 16(%r8), %rax, %r13
adox %rax, %rdi
adcx %r13, %rsi
mulx 24(%r8), %rax, %r13
adox %rax, %rsi
adcx %r13, %rbx
mulx 32(%r8), %rax, %r13
adox %rax, %rbx
adcx %r13, %rbp
mulx 40(%r8), %rax, %r13
adox %rax, %rbp
adcx %r13, %r12
mulx 48(%r8), %rax, %r13
adox %rax, %r12
mov $0, %rax
adox %rax, %r13
adc %rax, %r13
mov 16(%r11), %rdx
xor %rax, %rax
mulx (%r8), %rax, %r9
adox %rax, %r10
mov %r10, 16(%rcx)
adcx %r9, %rdi
mulx 8(%r8), %rax, %r9
adox %rax, %rdi
adcx %r9, %rsi
mulx 16(%r8), %rax, %r9
adox %rax, %rsi
adcx %r9, %rbx
mulx 24(%r8), %rax, %r9
adox %rax, %rbx
adcx %r9, %rbp
mulx 32(%r8), %rax, %r9
adox %rax, %rbp
adcx %r9, %r12
mulx 40(%r8), %rax, %r9
adox %rax, %r12
adcx %r9, %r13
mulx 48(%r8), %rax, %r9
adox %rax, %r13
mov $0, %rax
adox %rax, %r9
adc %rax, %r9
mov 24(%r11), %rdx
xor %rax, %rax
mulx (%r8), %rax, %r10
adox %rax, %rdi
mov %rdi, 24(%rcx)
adcx %r10, %rsi
mulx 8(%r8), %rax, %r10
adox %rax, %rsi
adcx %r10, %rbx
mulx 16(%r8), %rax, %r10
adox %rax, %rbx
adcx %r10, %rbp
mulx 24(%r8), %rax, %r10
adox %rax, %rbp
adcx %r10, %r12
mulx 32(%r8), %rax, %r10
adox %rax, %r12
adcx %r10, %r13
mulx 40(%r8), %rax, %r10
adox %rax, %r13
adcx %r10, %r9
mulx 48(%r8), %rax, %r10
adox %rax, %r9
mov $0, %rax
adox %rax, %r10
adc %rax, %r10
mov 32(%r11), %rdx
xor %rax, %rax
mulx (%r8), %rax, %rdi
adox %rax, %rsi
mov %rsi, 32(%rcx)
adcx %rdi, %rbx
mulx 8(%r8), %rax, %rdi
adox %rax, %rbx
adcx %rdi, %rbp
mulx 16(%r8), %rax, %rdi
adox %rax, %rbp
adcx %rdi, %r12
mulx 24(%r8), %rax, %rdi
adox %rax, %r12
adcx %rdi, %r13
mulx 32(%r8), %rax, %rdi
adox %rax, %r13
adcx %rdi, %r9
mulx 40(%r8), %rax, %rdi
adox %rax, %r9
adcx %rdi, %r10
mulx 48(%r8), %rax, %rdi
adox %rax, %r10
mov $0, %rax
adox %rax, %rdi
adc %rax, %rdi
mov 40(%r11), %rdx
xor %rax, %rax
mulx (%r8), %rax, %rsi
adox %rax, %rbx
mov %rbx, 40(%rcx)
adcx %rsi, %rbp
mulx 8(%r8), %rax, %rsi
adox %rax, %rbp
adcx %rsi, %r12
mulx 16(%r8), %rax, %rsi
adox %rax, %r12
adcx %rsi, %r13
mulx 24(%r8), %rax, %rsi
adox %rax, %r13
adcx %rsi, %r9
mulx 32(%r8), %rax, %rsi
adox %rax, %r9
adcx %rsi, %r10
mulx 40(%r8), %rax, %rsi
adox %rax, %r10
adcx %rsi, %rdi
mulx 48(%r8), %rax, %rsi
adox %rax, %rdi
mov $0, %rax
adox %rax, %rsi
adc %rax, %rsi
mov 48(%r11), %rdx
xor %rax, %rax
mulx (%r8), %rax, %rbx
adox %rax, %rbp
mov %rbp, 48(%rcx)
adcx %rbx, %r12
mulx 8(%r8), %rax, %rbx
adox %rax, %r12
adcx %rbx, %r13
mulx 16(%r8), %rax, %rbx
adox %rax, %r13
adcx %rbx, %r9
mulx 24(%r8), %rax, %rbx
adox %rax, %r9
adcx %rbx, %r10
mulx 32(%r8), %rax, %rbx
adox %rax, %r10
adcx %rbx, %rdi
mulx 40(%r8), %rax, %rbx
adox %rax, %rdi
adcx %rbx, %rsi
mulx 48(%r8), %rax, %rbx
adox %rax, %rsi
mov $0, %rax
adox %rax, %rbx
adc %rax, %rbx
mov %r12, 56(%rcx)
mov %r13, 64(%rcx)
mov %r9, 72(%rcx)
mov %r10, 80(%rcx)
mov %rdi, 88(%rcx)
mov %rsi, 96(%rcx)
mov %rbx, 104(%rcx)
pop %r13
pop %r12
pop %rbp
pop %rbx
pop %rsi
pop %rdi
ret
SIZE(mclb_mul_fast7)
.balign 16
.global PRE(mclb_mul_fast8)
PRE(mclb_mul_fast8):
TYPE(mclb_mul_fast8)
push %rdi
push %rsi
push %rbx
push %rbp
push %r12
push %r13
push %r14
mov %rdx, %r11
mov (%r11), %rdx
mulx (%r8), %rax, %r9
mov %rax, (%rcx)
mulx 8(%r8), %rax, %r10
add %rax, %r9
mulx 16(%r8), %rax, %rdi
adc %rax, %r10
mulx 24(%r8), %rax, %rsi
adc %rax, %rdi
mulx 32(%r8), %rax, %rbx
adc %rax, %rsi
mulx 40(%r8), %rax, %rbp
adc %rax, %rbx
mulx 48(%r8), %rax, %r12
adc %rax, %rbp
mulx 56(%r8), %rax, %r13
adc %rax, %r12
adc $0, %r13
mov 8(%r11), %rdx
xor %rax, %rax
mulx (%r8), %rax, %r14
adox %rax, %r9
mov %r9, 8(%rcx)
adcx %r14, %r10
mulx 8(%r8), %rax, %r14
adox %rax, %r10
adcx %r14, %rdi
mulx 16(%r8), %rax, %r14
adox %rax, %rdi
adcx %r14, %rsi
mulx 24(%r8), %rax, %r14
adox %rax, %rsi
adcx %r14, %rbx
mulx 32(%r8), %rax, %r14
adox %rax, %rbx
adcx %r14, %rbp
mulx 40(%r8), %rax, %r14
adox %rax, %rbp
adcx %r14, %r12
mulx 48(%r8), %rax, %r14
adox %rax, %r12
adcx %r14, %r13
mulx 56(%r8), %rax, %r14
adox %rax, %r13
mov $0, %rax
adox %rax, %r14
adc %rax, %r14
mov 16(%r11), %rdx
xor %rax, %rax
mulx (%r8), %rax, %r9
adox %rax, %r10
mov %r10, 16(%rcx)
adcx %r9, %rdi
mulx 8(%r8), %rax, %r9
adox %rax, %rdi
adcx %r9, %rsi
mulx 16(%r8), %rax, %r9
adox %rax, %rsi
adcx %r9, %rbx
mulx 24(%r8), %rax, %r9
adox %rax, %rbx
adcx %r9, %rbp
mulx 32(%r8), %rax, %r9
adox %rax, %rbp
adcx %r9, %r12
mulx 40(%r8), %rax, %r9
adox %rax, %r12
adcx %r9, %r13
mulx 48(%r8), %rax, %r9
adox %rax, %r13
adcx %r9, %r14
mulx 56(%r8), %rax, %r9
adox %rax, %r14
mov $0, %rax
adox %rax, %r9
adc %rax, %r9
mov 24(%r11), %rdx
xor %rax, %rax
mulx (%r8), %rax, %r10
adox %rax, %rdi
mov %rdi, 24(%rcx)
adcx %r10, %rsi
mulx 8(%r8), %rax, %r10
adox %rax, %rsi
adcx %r10, %rbx
mulx 16(%r8), %rax, %r10
adox %rax, %rbx
adcx %r10, %rbp
mulx 24(%r8), %rax, %r10
adox %rax, %rbp
adcx %r10, %r12
mulx 32(%r8), %rax, %r10
adox %rax, %r12
adcx %r10, %r13
mulx 40(%r8), %rax, %r10
adox %rax, %r13
adcx %r10, %r14
mulx 48(%r8), %rax, %r10
adox %rax, %r14
adcx %r10, %r9
mulx 56(%r8), %rax, %r10
adox %rax, %r9
mov $0, %rax
adox %rax, %r10
adc %rax, %r10
mov 32(%r11), %rdx
xor %rax, %rax
mulx (%r8), %rax, %rdi
adox %rax, %rsi
mov %rsi, 32(%rcx)
adcx %rdi, %rbx
mulx 8(%r8), %rax, %rdi
adox %rax, %rbx
adcx %rdi, %rbp
mulx 16(%r8), %rax, %rdi
adox %rax, %rbp
adcx %rdi, %r12
mulx 24(%r8), %rax, %rdi
adox %rax, %r12
adcx %rdi, %r13
mulx 32(%r8), %rax, %rdi
adox %rax, %r13
adcx %rdi, %r14
mulx 40(%r8), %rax, %rdi
adox %rax, %r14
adcx %rdi, %r9
mulx 48(%r8), %rax, %rdi
adox %rax, %r9
adcx %rdi, %r10
mulx 56(%r8), %rax, %rdi
adox %rax, %r10
mov $0, %rax
adox %rax, %rdi
adc %rax, %rdi
mov 40(%r11), %rdx
xor %rax, %rax
mulx (%r8), %rax, %rsi
adox %rax, %rbx
mov %rbx, 40(%rcx)
adcx %rsi, %rbp
mulx 8(%r8), %rax, %rsi
adox %rax, %rbp
adcx %rsi, %r12
mulx 16(%r8), %rax, %rsi
adox %rax, %r12
adcx %rsi, %r13
mulx 24(%r8), %rax, %rsi
adox %rax, %r13
adcx %rsi, %r14
mulx 32(%r8), %rax, %rsi
adox %rax, %r14
adcx %rsi, %r9
mulx 40(%r8), %rax, %rsi
adox %rax, %r9
adcx %rsi, %r10
mulx 48(%r8), %rax, %rsi
adox %rax, %r10
adcx %rsi, %rdi
mulx 56(%r8), %rax, %rsi
adox %rax, %rdi
mov $0, %rax
adox %rax, %rsi
adc %rax, %rsi
mov 48(%r11), %rdx
xor %rax, %rax
mulx (%r8), %rax, %rbx
adox %rax, %rbp
mov %rbp, 48(%rcx)
adcx %rbx, %r12
mulx 8(%r8), %rax, %rbx
adox %rax, %r12
adcx %rbx, %r13
mulx 16(%r8), %rax, %rbx
adox %rax, %r13
adcx %rbx, %r14
mulx 24(%r8), %rax, %rbx
adox %rax, %r14
adcx %rbx, %r9
mulx 32(%r8), %rax, %rbx
adox %rax, %r9
adcx %rbx, %r10
mulx 40(%r8), %rax, %rbx
adox %rax, %r10
adcx %rbx, %rdi
mulx 48(%r8), %rax, %rbx
adox %rax, %rdi
adcx %rbx, %rsi
mulx 56(%r8), %rax, %rbx
adox %rax, %rsi
mov $0, %rax
adox %rax, %rbx
adc %rax, %rbx
mov 56(%r11), %rdx
xor %rax, %rax
mulx (%r8), %rax, %rbp
adox %rax, %r12
mov %r12, 56(%rcx)
adcx %rbp, %r13
mulx 8(%r8), %rax, %rbp
adox %rax, %r13
adcx %rbp, %r14
mulx 16(%r8), %rax, %rbp
adox %rax, %r14
adcx %rbp, %r9
mulx 24(%r8), %rax, %rbp
adox %rax, %r9
adcx %rbp, %r10
mulx 32(%r8), %rax, %rbp
adox %rax, %r10
adcx %rbp, %rdi
mulx 40(%r8), %rax, %rbp
adox %rax, %rdi
adcx %rbp, %rsi
mulx 48(%r8), %rax, %rbp
adox %rax, %rsi
adcx %rbp, %rbx
mulx 56(%r8), %rax, %rbp
adox %rax, %rbx
mov $0, %rax
adox %rax, %rbp
adc %rax, %rbp
mov %r13, 64(%rcx)
mov %r14, 72(%rcx)
mov %r9, 80(%rcx)
mov %r10, 88(%rcx)
mov %rdi, 96(%rcx)
mov %rsi, 104(%rcx)
mov %rbx, 112(%rcx)
mov %rbp, 120(%rcx)
pop %r14
pop %r13
pop %r12
pop %rbp
pop %rbx
pop %rsi
pop %rdi
ret
SIZE(mclb_mul_fast8)
.balign 16
.global PRE(mclb_mul_fast9)
PRE(mclb_mul_fast9):
TYPE(mclb_mul_fast9)
push %rdi
push %rsi
push %rbx
push %rbp
push %r12
push %r13
push %r14
push %r15
mov %rdx, %r11
mov (%r11), %rdx
mulx (%r8), %rax, %r9
mov %rax, (%rcx)
mulx 8(%r8), %rax, %r10
add %rax, %r9
mulx 16(%r8), %rax, %rdi
adc %rax, %r10
mulx 24(%r8), %rax, %rsi
adc %rax, %rdi
mulx 32(%r8), %rax, %rbx
adc %rax, %rsi
mulx 40(%r8), %rax, %rbp
adc %rax, %rbx
mulx 48(%r8), %rax, %r12
adc %rax, %rbp
mulx 56(%r8), %rax, %r13
adc %rax, %r12
mulx 64(%r8), %rax, %r14
adc %rax, %r13
adc $0, %r14
mov 8(%r11), %rdx
xor %rax, %rax
mulx (%r8), %rax, %r15
adox %rax, %r9
mov %r9, 8(%rcx)
adcx %r15, %r10
mulx 8(%r8), %rax, %r15
adox %rax, %r10
adcx %r15, %rdi
mulx 16(%r8), %rax, %r15
adox %rax, %rdi
adcx %r15, %rsi
mulx 24(%r8), %rax, %r15
adox %rax, %rsi
adcx %r15, %rbx
mulx 32(%r8), %rax, %r15
adox %rax, %rbx
adcx %r15, %rbp
mulx 40(%r8), %rax, %r15
adox %rax, %rbp
adcx %r15, %r12
mulx 48(%r8), %rax, %r15
adox %rax, %r12
adcx %r15, %r13
mulx 56(%r8), %rax, %r15
adox %rax, %r13
adcx %r15, %r14
mulx 64(%r8), %rax, %r15
adox %rax, %r14
mov $0, %rax
adox %rax, %r15
adc %rax, %r15
mov 16(%r11), %rdx
xor %rax, %rax
mulx (%r8), %rax, %r9
adox %rax, %r10
mov %r10, 16(%rcx)
adcx %r9, %rdi
mulx 8(%r8), %rax, %r9
adox %rax, %rdi
adcx %r9, %rsi
mulx 16(%r8), %rax, %r9
adox %rax, %rsi
adcx %r9, %rbx
mulx 24(%r8), %rax, %r9
adox %rax, %rbx
adcx %r9, %rbp
mulx 32(%r8), %rax, %r9
adox %rax, %rbp
adcx %r9, %r12
mulx 40(%r8), %rax, %r9
adox %rax, %r12
adcx %r9, %r13
mulx 48(%r8), %rax, %r9
adox %rax, %r13
adcx %r9, %r14
mulx 56(%r8), %rax, %r9
adox %rax, %r14
adcx %r9, %r15
mulx 64(%r8), %rax, %r9
adox %rax, %r15
mov $0, %rax
adox %rax, %r9
adc %rax, %r9
mov 24(%r11), %rdx
xor %rax, %rax
mulx (%r8), %rax, %r10
adox %rax, %rdi
mov %rdi, 24(%rcx)
adcx %r10, %rsi
mulx 8(%r8), %rax, %r10
adox %rax, %rsi
adcx %r10, %rbx
mulx 16(%r8), %rax, %r10
adox %rax, %rbx
adcx %r10, %rbp
mulx 24(%r8), %rax, %r10
adox %rax, %rbp
adcx %r10, %r12
mulx 32(%r8), %rax, %r10
adox %rax, %r12
adcx %r10, %r13
mulx 40(%r8), %rax, %r10
adox %rax, %r13
adcx %r10, %r14
mulx 48(%r8), %rax, %r10
adox %rax, %r14
adcx %r10, %r15
mulx 56(%r8), %rax, %r10
adox %rax, %r15
adcx %r10, %r9
mulx 64(%r8), %rax, %r10
adox %rax, %r9
mov $0, %rax
adox %rax, %r10
adc %rax, %r10
mov 32(%r11), %rdx
xor %rax, %rax
mulx (%r8), %rax, %rdi
adox %rax, %rsi
mov %rsi, 32(%rcx)
adcx %rdi, %rbx
mulx 8(%r8), %rax, %rdi
adox %rax, %rbx
adcx %rdi, %rbp
mulx 16(%r8), %rax, %rdi
adox %rax, %rbp
adcx %rdi, %r12
mulx 24(%r8), %rax, %rdi
adox %rax, %r12
adcx %rdi, %r13
mulx 32(%r8), %rax, %rdi
adox %rax, %r13
adcx %rdi, %r14
mulx 40(%r8), %rax, %rdi
adox %rax, %r14
adcx %rdi, %r15
mulx 48(%r8), %rax, %rdi
adox %rax, %r15
adcx %rdi, %r9
mulx 56(%r8), %rax, %rdi
adox %rax, %r9
adcx %rdi, %r10
mulx 64(%r8), %rax, %rdi
adox %rax, %r10
mov $0, %rax
adox %rax, %rdi
adc %rax, %rdi
mov 40(%r11), %rdx
xor %rax, %rax
mulx (%r8), %rax, %rsi
adox %rax, %rbx
mov %rbx, 40(%rcx)
adcx %rsi, %rbp
mulx 8(%r8), %rax, %rsi
adox %rax, %rbp
adcx %rsi, %r12
mulx 16(%r8), %rax, %rsi
adox %rax, %r12
adcx %rsi, %r13
mulx 24(%r8), %rax, %rsi
adox %rax, %r13
adcx %rsi, %r14
mulx 32(%r8), %rax, %rsi
adox %rax, %r14
adcx %rsi, %r15
mulx 40(%r8), %rax, %rsi
adox %rax, %r15
adcx %rsi, %r9
mulx 48(%r8), %rax, %rsi
adox %rax, %r9
adcx %rsi, %r10
mulx 56(%r8), %rax, %rsi
adox %rax, %r10
adcx %rsi, %rdi
mulx 64(%r8), %rax, %rsi
adox %rax, %rdi
mov $0, %rax
adox %rax, %rsi
adc %rax, %rsi
mov 48(%r11), %rdx
xor %rax, %rax
mulx (%r8), %rax, %rbx
adox %rax, %rbp
mov %rbp, 48(%rcx)
adcx %rbx, %r12
mulx 8(%r8), %rax, %rbx
adox %rax, %r12
adcx %rbx, %r13
mulx 16(%r8), %rax, %rbx
adox %rax, %r13
adcx %rbx, %r14
mulx 24(%r8), %rax, %rbx
adox %rax, %r14
adcx %rbx, %r15
mulx 32(%r8), %rax, %rbx
adox %rax, %r15
adcx %rbx, %r9
mulx 40(%r8), %rax, %rbx
adox %rax, %r9
adcx %rbx, %r10
mulx 48(%r8), %rax, %rbx
adox %rax, %r10
adcx %rbx, %rdi
mulx 56(%r8), %rax, %rbx
adox %rax, %rdi
adcx %rbx, %rsi
mulx 64(%r8), %rax, %rbx
adox %rax, %rsi
mov $0, %rax
adox %rax, %rbx
adc %rax, %rbx
mov 56(%r11), %rdx
xor %rax, %rax
mulx (%r8), %rax, %rbp
adox %rax, %r12
mov %r12, 56(%rcx)
adcx %rbp, %r13
mulx 8(%r8), %rax, %rbp
adox %rax, %r13
adcx %rbp, %r14
mulx 16(%r8), %rax, %rbp
adox %rax, %r14
adcx %rbp, %r15
mulx 24(%r8), %rax, %rbp
adox %rax, %r15
adcx %rbp, %r9
mulx 32(%r8), %rax, %rbp
adox %rax, %r9
adcx %rbp, %r10
mulx 40(%r8), %rax, %rbp
adox %rax, %r10
adcx %rbp, %rdi
mulx 48(%r8), %rax, %rbp
adox %rax, %rdi
adcx %rbp, %rsi
mulx 56(%r8), %rax, %rbp
adox %rax, %rsi
adcx %rbp, %rbx
mulx 64(%r8), %rax, %rbp
adox %rax, %rbx
mov $0, %rax
adox %rax, %rbp
adc %rax, %rbp
mov 64(%r11), %rdx
xor %rax, %rax
mulx (%r8), %rax, %r12
adox %rax, %r13
mov %r13, 64(%rcx)
adcx %r12, %r14
mulx 8(%r8), %rax, %r12
adox %rax, %r14
adcx %r12, %r15
mulx 16(%r8), %rax, %r12
adox %rax, %r15
adcx %r12, %r9
mulx 24(%r8), %rax, %r12
adox %rax, %r9
adcx %r12, %r10
mulx 32(%r8), %rax, %r12
adox %rax, %r10
adcx %r12, %rdi
mulx 40(%r8), %rax, %r12
adox %rax, %rdi
adcx %r12, %rsi
mulx 48(%r8), %rax, %r12
adox %rax, %rsi
adcx %r12, %rbx
mulx 56(%r8), %rax, %r12
adox %rax, %rbx
adcx %r12, %rbp
mulx 64(%r8), %rax, %r12
adox %rax, %rbp
mov $0, %rax
adox %rax, %r12
adc %rax, %r12
mov %r14, 72(%rcx)
mov %r15, 80(%rcx)
mov %r9, 88(%rcx)
mov %r10, 96(%rcx)
mov %rdi, 104(%rcx)
mov %rsi, 112(%rcx)
mov %rbx, 120(%rcx)
mov %rbp, 128(%rcx)
mov %r12, 136(%rcx)
pop %r15
pop %r14
pop %r13
pop %r12
pop %rbp
pop %rbx
pop %rsi
pop %rdi
ret
SIZE(mclb_mul_fast9)
.balign 16
.global PRE(mclb_sqr_fast1)
PRE(mclb_sqr_fast1):
TYPE(mclb_sqr_fast1)
mov %rdx, %r11
mov (%r11), %rax
mul %rax
mov %rax, (%rcx)
mov %rdx, 8(%rcx)
ret
SIZE(mclb_sqr_fast1)
.balign 16
.global PRE(mclb_sqr_fast2)
PRE(mclb_sqr_fast2):
TYPE(mclb_sqr_fast2)
mov %rdx, %r8
jmp PRE(mclb_mul_fast2)
SIZE(mclb_sqr_fast2)
.balign 16
.global PRE(mclb_sqr_fast3)
PRE(mclb_sqr_fast3):
TYPE(mclb_sqr_fast3)
mov %rdx, %r8
jmp PRE(mclb_mul_fast3)
SIZE(mclb_sqr_fast3)
.balign 16
.global PRE(mclb_sqr_fast4)
PRE(mclb_sqr_fast4):
TYPE(mclb_sqr_fast4)
mov %rdx, %r8
jmp PRE(mclb_mul_fast4)
SIZE(mclb_sqr_fast4)
.balign 16
.global PRE(mclb_sqr_fast5)
PRE(mclb_sqr_fast5):
TYPE(mclb_sqr_fast5)
mov %rdx, %r8
jmp PRE(mclb_mul_fast5)
SIZE(mclb_sqr_fast5)
.balign 16
.global PRE(mclb_sqr_fast6)
PRE(mclb_sqr_fast6):
TYPE(mclb_sqr_fast6)
mov %rdx, %r8
jmp PRE(mclb_mul_fast6)
SIZE(mclb_sqr_fast6)
.balign 16
.global PRE(mclb_sqr_fast7)
PRE(mclb_sqr_fast7):
TYPE(mclb_sqr_fast7)
mov %rdx, %r8
jmp PRE(mclb_mul_fast7)
SIZE(mclb_sqr_fast7)
.balign 16
.global PRE(mclb_sqr_fast8)
PRE(mclb_sqr_fast8):
TYPE(mclb_sqr_fast8)
mov %rdx, %r8
jmp PRE(mclb_mul_fast8)
SIZE(mclb_sqr_fast8)
.balign 16
.global PRE(mclb_sqr_fast9)
PRE(mclb_sqr_fast9):
TYPE(mclb_sqr_fast9)
mov %rdx, %r8
jmp PRE(mclb_mul_fast9)
SIZE(mclb_sqr_fast9)
.balign 16
.global PRE(mclb_udiv128)
PRE(mclb_udiv128):
TYPE(mclb_udiv128)
mov %rdx, %rax
mov %rcx, %rdx
div %r8
mov %rdx, (%r9)
ret
SIZE(mclb_udiv128)
