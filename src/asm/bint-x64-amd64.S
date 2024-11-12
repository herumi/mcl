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
vmovdqa64 (%rsi), %zmm2
vpaddq (%rdx), %zmm2, %zmm2
vpsrlq $52, %zmm2, %zmm1
vpandq %zmm0, %zmm2, %zmm2
vmovdqa64 %zmm2, (%rdi)
vmovdqa64 64(%rsi), %zmm2
vpaddq 64(%rdx), %zmm2, %zmm2
vpaddq %zmm1, %zmm2, %zmm2
vpsrlq $52, %zmm2, %zmm1
vpandq %zmm0, %zmm2, %zmm2
vmovdqa64 %zmm2, 64(%rdi)
vmovdqa64 128(%rsi), %zmm2
vpaddq 128(%rdx), %zmm2, %zmm2
vpaddq %zmm1, %zmm2, %zmm2
vpsrlq $52, %zmm2, %zmm1
vpandq %zmm0, %zmm2, %zmm2
vmovdqa64 %zmm2, 128(%rdi)
vmovdqa64 192(%rsi), %zmm2
vpaddq 192(%rdx), %zmm2, %zmm2
vpaddq %zmm1, %zmm2, %zmm2
vpsrlq $52, %zmm2, %zmm1
vpandq %zmm0, %zmm2, %zmm2
vmovdqa64 %zmm2, 192(%rdi)
vmovdqa64 256(%rsi), %zmm2
vpaddq 256(%rdx), %zmm2, %zmm2
vpaddq %zmm1, %zmm2, %zmm2
vpsrlq $52, %zmm2, %zmm1
vpandq %zmm0, %zmm2, %zmm2
vmovdqa64 %zmm2, 256(%rdi)
vmovdqa64 320(%rsi), %zmm2
vpaddq 320(%rdx), %zmm2, %zmm2
vpaddq %zmm1, %zmm2, %zmm2
vpsrlq $52, %zmm2, %zmm1
vpandq %zmm0, %zmm2, %zmm2
vmovdqa64 %zmm2, 320(%rdi)
vmovdqa64 384(%rsi), %zmm2
vpaddq 384(%rdx), %zmm2, %zmm2
vpaddq %zmm1, %zmm2, %zmm2
vpsrlq $52, %zmm2, %zmm1
vpandq %zmm0, %zmm2, %zmm2
vmovdqa64 %zmm2, 384(%rdi)
vmovdqa64 448(%rsi), %zmm2
vpaddq 448(%rdx), %zmm2, %zmm2
vpaddq %zmm1, %zmm2, %zmm2
vmovdqa64 %zmm2, 448(%rdi)
vzeroupper
ret
SIZE(mcl_c5_vaddPre)
.global PRE(mcl_c5_vsubPre)
PRE(mcl_c5_vsubPre):
TYPE(mcl_c5_vsubPre)
mov $4503599627370495, %rax
vpbroadcastq %rax, %zmm0
vmovdqa64 (%rsi), %zmm2
vpsubq (%rdx), %zmm2, %zmm2
vpsrlq $63, %zmm2, %zmm1
vpandq %zmm0, %zmm2, %zmm2
vmovdqa64 %zmm2, (%rdi)
vmovdqa64 64(%rsi), %zmm2
vpsubq 64(%rdx), %zmm2, %zmm2
vpsubq %zmm1, %zmm2, %zmm2
vpsrlq $63, %zmm2, %zmm1
vpandq %zmm0, %zmm2, %zmm2
vmovdqa64 %zmm2, 64(%rdi)
vmovdqa64 128(%rsi), %zmm2
vpsubq 128(%rdx), %zmm2, %zmm2
vpsubq %zmm1, %zmm2, %zmm2
vpsrlq $63, %zmm2, %zmm1
vpandq %zmm0, %zmm2, %zmm2
vmovdqa64 %zmm2, 128(%rdi)
vmovdqa64 192(%rsi), %zmm2
vpsubq 192(%rdx), %zmm2, %zmm2
vpsubq %zmm1, %zmm2, %zmm2
vpsrlq $63, %zmm2, %zmm1
vpandq %zmm0, %zmm2, %zmm2
vmovdqa64 %zmm2, 192(%rdi)
vmovdqa64 256(%rsi), %zmm2
vpsubq 256(%rdx), %zmm2, %zmm2
vpsubq %zmm1, %zmm2, %zmm2
vpsrlq $63, %zmm2, %zmm1
vpandq %zmm0, %zmm2, %zmm2
vmovdqa64 %zmm2, 256(%rdi)
vmovdqa64 320(%rsi), %zmm2
vpsubq 320(%rdx), %zmm2, %zmm2
vpsubq %zmm1, %zmm2, %zmm2
vpsrlq $63, %zmm2, %zmm1
vpandq %zmm0, %zmm2, %zmm2
vmovdqa64 %zmm2, 320(%rdi)
vmovdqa64 384(%rsi), %zmm2
vpsubq 384(%rdx), %zmm2, %zmm2
vpsubq %zmm1, %zmm2, %zmm2
vpsrlq $63, %zmm2, %zmm1
vpandq %zmm0, %zmm2, %zmm2
vmovdqa64 %zmm2, 384(%rdi)
vmovdqa64 448(%rsi), %zmm2
vpsubq 448(%rdx), %zmm2, %zmm2
vpsubq %zmm1, %zmm2, %zmm2
vpsrlq $63, %zmm2, %zmm1
vpandq %zmm0, %zmm2, %zmm2
vmovdqa64 %zmm2, 448(%rdi)
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
vmovdqa64 (%rsi), %zmm3
vmovdqa64 64(%rsi), %zmm4
vpaddq (%rdx), %zmm3, %zmm3
vpaddq 64(%rdx), %zmm4, %zmm4
vpsrlq $52, %zmm3, %zmm1
vpsrlq $52, %zmm4, %zmm2
vpandq %zmm0, %zmm3, %zmm3
vpandq %zmm0, %zmm4, %zmm4
vmovdqa64 %zmm3, (%rdi)
vmovdqa64 %zmm4, 64(%rdi)
vmovdqa64 128(%rsi), %zmm3
vmovdqa64 192(%rsi), %zmm4
vpaddq 128(%rdx), %zmm3, %zmm3
vpaddq 192(%rdx), %zmm4, %zmm4
vpaddq %zmm1, %zmm3, %zmm3
vpaddq %zmm2, %zmm4, %zmm4
vpsrlq $52, %zmm3, %zmm1
vpsrlq $52, %zmm4, %zmm2
vpandq %zmm0, %zmm3, %zmm3
vpandq %zmm0, %zmm4, %zmm4
vmovdqa64 %zmm3, 128(%rdi)
vmovdqa64 %zmm4, 192(%rdi)
vmovdqa64 256(%rsi), %zmm3
vmovdqa64 320(%rsi), %zmm4
vpaddq 256(%rdx), %zmm3, %zmm3
vpaddq 320(%rdx), %zmm4, %zmm4
vpaddq %zmm1, %zmm3, %zmm3
vpaddq %zmm2, %zmm4, %zmm4
vpsrlq $52, %zmm3, %zmm1
vpsrlq $52, %zmm4, %zmm2
vpandq %zmm0, %zmm3, %zmm3
vpandq %zmm0, %zmm4, %zmm4
vmovdqa64 %zmm3, 256(%rdi)
vmovdqa64 %zmm4, 320(%rdi)
vmovdqa64 384(%rsi), %zmm3
vmovdqa64 448(%rsi), %zmm4
vpaddq 384(%rdx), %zmm3, %zmm3
vpaddq 448(%rdx), %zmm4, %zmm4
vpaddq %zmm1, %zmm3, %zmm3
vpaddq %zmm2, %zmm4, %zmm4
vpsrlq $52, %zmm3, %zmm1
vpsrlq $52, %zmm4, %zmm2
vpandq %zmm0, %zmm3, %zmm3
vpandq %zmm0, %zmm4, %zmm4
vmovdqa64 %zmm3, 384(%rdi)
vmovdqa64 %zmm4, 448(%rdi)
vmovdqa64 512(%rsi), %zmm3
vmovdqa64 576(%rsi), %zmm4
vpaddq 512(%rdx), %zmm3, %zmm3
vpaddq 576(%rdx), %zmm4, %zmm4
vpaddq %zmm1, %zmm3, %zmm3
vpaddq %zmm2, %zmm4, %zmm4
vpsrlq $52, %zmm3, %zmm1
vpsrlq $52, %zmm4, %zmm2
vpandq %zmm0, %zmm3, %zmm3
vpandq %zmm0, %zmm4, %zmm4
vmovdqa64 %zmm3, 512(%rdi)
vmovdqa64 %zmm4, 576(%rdi)
vmovdqa64 640(%rsi), %zmm3
vmovdqa64 704(%rsi), %zmm4
vpaddq 640(%rdx), %zmm3, %zmm3
vpaddq 704(%rdx), %zmm4, %zmm4
vpaddq %zmm1, %zmm3, %zmm3
vpaddq %zmm2, %zmm4, %zmm4
vpsrlq $52, %zmm3, %zmm1
vpsrlq $52, %zmm4, %zmm2
vpandq %zmm0, %zmm3, %zmm3
vpandq %zmm0, %zmm4, %zmm4
vmovdqa64 %zmm3, 640(%rdi)
vmovdqa64 %zmm4, 704(%rdi)
vmovdqa64 768(%rsi), %zmm3
vmovdqa64 832(%rsi), %zmm4
vpaddq 768(%rdx), %zmm3, %zmm3
vpaddq 832(%rdx), %zmm4, %zmm4
vpaddq %zmm1, %zmm3, %zmm3
vpaddq %zmm2, %zmm4, %zmm4
vpsrlq $52, %zmm3, %zmm1
vpsrlq $52, %zmm4, %zmm2
vpandq %zmm0, %zmm3, %zmm3
vpandq %zmm0, %zmm4, %zmm4
vmovdqa64 %zmm3, 768(%rdi)
vmovdqa64 %zmm4, 832(%rdi)
vmovdqa64 896(%rsi), %zmm3
vmovdqa64 960(%rsi), %zmm4
vpaddq 896(%rdx), %zmm3, %zmm3
vpaddq 960(%rdx), %zmm4, %zmm4
vpaddq %zmm1, %zmm3, %zmm3
vpaddq %zmm2, %zmm4, %zmm4
vmovdqa64 %zmm3, 896(%rdi)
vmovdqa64 %zmm4, 960(%rdi)
vzeroupper
ret
SIZE(mcl_c5_vaddPreA)
.global PRE(mcl_c5_vsubPreA)
PRE(mcl_c5_vsubPreA):
TYPE(mcl_c5_vsubPreA)
mov $4503599627370495, %rax
vpbroadcastq %rax, %zmm0
vmovdqa64 (%rsi), %zmm3
vmovdqa64 64(%rsi), %zmm4
vpsubq (%rdx), %zmm3, %zmm3
vpsubq 64(%rdx), %zmm4, %zmm4
vpsrlq $63, %zmm3, %zmm1
vpsrlq $63, %zmm4, %zmm2
vpandq %zmm0, %zmm3, %zmm3
vpandq %zmm0, %zmm4, %zmm4
vmovdqa64 %zmm3, (%rdi)
vmovdqa64 %zmm4, 64(%rdi)
vmovdqa64 128(%rsi), %zmm3
vmovdqa64 192(%rsi), %zmm4
vpsubq 128(%rdx), %zmm3, %zmm3
vpsubq 192(%rdx), %zmm4, %zmm4
vpsubq %zmm1, %zmm3, %zmm3
vpsubq %zmm2, %zmm4, %zmm4
vpsrlq $63, %zmm3, %zmm1
vpsrlq $63, %zmm4, %zmm2
vpandq %zmm0, %zmm3, %zmm3
vpandq %zmm0, %zmm4, %zmm4
vmovdqa64 %zmm3, 128(%rdi)
vmovdqa64 %zmm4, 192(%rdi)
vmovdqa64 256(%rsi), %zmm3
vmovdqa64 320(%rsi), %zmm4
vpsubq 256(%rdx), %zmm3, %zmm3
vpsubq 320(%rdx), %zmm4, %zmm4
vpsubq %zmm1, %zmm3, %zmm3
vpsubq %zmm2, %zmm4, %zmm4
vpsrlq $63, %zmm3, %zmm1
vpsrlq $63, %zmm4, %zmm2
vpandq %zmm0, %zmm3, %zmm3
vpandq %zmm0, %zmm4, %zmm4
vmovdqa64 %zmm3, 256(%rdi)
vmovdqa64 %zmm4, 320(%rdi)
vmovdqa64 384(%rsi), %zmm3
vmovdqa64 448(%rsi), %zmm4
vpsubq 384(%rdx), %zmm3, %zmm3
vpsubq 448(%rdx), %zmm4, %zmm4
vpsubq %zmm1, %zmm3, %zmm3
vpsubq %zmm2, %zmm4, %zmm4
vpsrlq $63, %zmm3, %zmm1
vpsrlq $63, %zmm4, %zmm2
vpandq %zmm0, %zmm3, %zmm3
vpandq %zmm0, %zmm4, %zmm4
vmovdqa64 %zmm3, 384(%rdi)
vmovdqa64 %zmm4, 448(%rdi)
vmovdqa64 512(%rsi), %zmm3
vmovdqa64 576(%rsi), %zmm4
vpsubq 512(%rdx), %zmm3, %zmm3
vpsubq 576(%rdx), %zmm4, %zmm4
vpsubq %zmm1, %zmm3, %zmm3
vpsubq %zmm2, %zmm4, %zmm4
vpsrlq $63, %zmm3, %zmm1
vpsrlq $63, %zmm4, %zmm2
vpandq %zmm0, %zmm3, %zmm3
vpandq %zmm0, %zmm4, %zmm4
vmovdqa64 %zmm3, 512(%rdi)
vmovdqa64 %zmm4, 576(%rdi)
vmovdqa64 640(%rsi), %zmm3
vmovdqa64 704(%rsi), %zmm4
vpsubq 640(%rdx), %zmm3, %zmm3
vpsubq 704(%rdx), %zmm4, %zmm4
vpsubq %zmm1, %zmm3, %zmm3
vpsubq %zmm2, %zmm4, %zmm4
vpsrlq $63, %zmm3, %zmm1
vpsrlq $63, %zmm4, %zmm2
vpandq %zmm0, %zmm3, %zmm3
vpandq %zmm0, %zmm4, %zmm4
vmovdqa64 %zmm3, 640(%rdi)
vmovdqa64 %zmm4, 704(%rdi)
vmovdqa64 768(%rsi), %zmm3
vmovdqa64 832(%rsi), %zmm4
vpsubq 768(%rdx), %zmm3, %zmm3
vpsubq 832(%rdx), %zmm4, %zmm4
vpsubq %zmm1, %zmm3, %zmm3
vpsubq %zmm2, %zmm4, %zmm4
vpsrlq $63, %zmm3, %zmm1
vpsrlq $63, %zmm4, %zmm2
vpandq %zmm0, %zmm3, %zmm3
vpandq %zmm0, %zmm4, %zmm4
vmovdqa64 %zmm3, 768(%rdi)
vmovdqa64 %zmm4, 832(%rdi)
vmovdqa64 896(%rsi), %zmm3
vmovdqa64 960(%rsi), %zmm4
vpsubq 896(%rdx), %zmm3, %zmm3
vpsubq 960(%rdx), %zmm4, %zmm4
vpsubq %zmm1, %zmm3, %zmm3
vpsubq %zmm2, %zmm4, %zmm4
vpsrlq $63, %zmm3, %zmm1
vpsrlq $63, %zmm4, %zmm2
vpandq %zmm0, %zmm3, %zmm3
vpandq %zmm0, %zmm4, %zmm4
vmovdqa64 %zmm3, 896(%rdi)
vmovdqa64 %zmm4, 960(%rdi)
vpxorq %zmm3, %zmm3, %zmm3
vpcmpgtq %zmm3, %zmm1, %k1
vpcmpgtq %zmm3, %zmm2, %k2
vzeroupper
ret
SIZE(mcl_c5_vsubPreA)
.global PRE(mcl_c5_vadd)
PRE(mcl_c5_vadd):
TYPE(mcl_c5_vadd)
mov $4503599627370495, %rax
vpbroadcastq %rax, %zmm16
lea PRE(p)(%rip), %rax
vmovdqa64 (%rsi), %zmm0
vpaddq (%rdx), %zmm0, %zmm0
vpsrlq $52, %zmm0, %zmm17
vpandq %zmm16, %zmm0, %zmm0
vmovdqa64 64(%rsi), %zmm1
vpaddq 64(%rdx), %zmm1, %zmm1
vpaddq %zmm17, %zmm1, %zmm1
vpsrlq $52, %zmm1, %zmm17
vpandq %zmm16, %zmm1, %zmm1
vmovdqa64 128(%rsi), %zmm2
vpaddq 128(%rdx), %zmm2, %zmm2
vpaddq %zmm17, %zmm2, %zmm2
vpsrlq $52, %zmm2, %zmm17
vpandq %zmm16, %zmm2, %zmm2
vmovdqa64 192(%rsi), %zmm3
vpaddq 192(%rdx), %zmm3, %zmm3
vpaddq %zmm17, %zmm3, %zmm3
vpsrlq $52, %zmm3, %zmm17
vpandq %zmm16, %zmm3, %zmm3
vmovdqa64 256(%rsi), %zmm4
vpaddq 256(%rdx), %zmm4, %zmm4
vpaddq %zmm17, %zmm4, %zmm4
vpsrlq $52, %zmm4, %zmm17
vpandq %zmm16, %zmm4, %zmm4
vmovdqa64 320(%rsi), %zmm5
vpaddq 320(%rdx), %zmm5, %zmm5
vpaddq %zmm17, %zmm5, %zmm5
vpsrlq $52, %zmm5, %zmm17
vpandq %zmm16, %zmm5, %zmm5
vmovdqa64 384(%rsi), %zmm6
vpaddq 384(%rdx), %zmm6, %zmm6
vpaddq %zmm17, %zmm6, %zmm6
vpsrlq $52, %zmm6, %zmm17
vpandq %zmm16, %zmm6, %zmm6
vmovdqa64 448(%rsi), %zmm7
vpaddq 448(%rdx), %zmm7, %zmm7
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
vmovdqa64 %zmm0, (%rdi)
vmovdqa64 %zmm1, 64(%rdi)
vmovdqa64 %zmm2, 128(%rdi)
vmovdqa64 %zmm3, 192(%rdi)
vmovdqa64 %zmm4, 256(%rdi)
vmovdqa64 %zmm5, 320(%rdi)
vmovdqa64 %zmm6, 384(%rdi)
vmovdqa64 %zmm7, 448(%rdi)
vzeroupper
ret
SIZE(mcl_c5_vadd)
.global PRE(mcl_c5_vsub)
PRE(mcl_c5_vsub):
TYPE(mcl_c5_vsub)
mov $4503599627370495, %rax
vpbroadcastq %rax, %zmm16
lea PRE(p)(%rip), %rax
vmovdqa64 (%rsi), %zmm0
vpsubq (%rdx), %zmm0, %zmm0
vpsrlq $63, %zmm0, %zmm17
vpandq %zmm16, %zmm0, %zmm0
vmovdqa64 64(%rsi), %zmm1
vpsubq 64(%rdx), %zmm1, %zmm1
vpsubq %zmm17, %zmm1, %zmm1
vpsrlq $63, %zmm1, %zmm17
vpandq %zmm16, %zmm1, %zmm1
vmovdqa64 128(%rsi), %zmm2
vpsubq 128(%rdx), %zmm2, %zmm2
vpsubq %zmm17, %zmm2, %zmm2
vpsrlq $63, %zmm2, %zmm17
vpandq %zmm16, %zmm2, %zmm2
vmovdqa64 192(%rsi), %zmm3
vpsubq 192(%rdx), %zmm3, %zmm3
vpsubq %zmm17, %zmm3, %zmm3
vpsrlq $63, %zmm3, %zmm17
vpandq %zmm16, %zmm3, %zmm3
vmovdqa64 256(%rsi), %zmm4
vpsubq 256(%rdx), %zmm4, %zmm4
vpsubq %zmm17, %zmm4, %zmm4
vpsrlq $63, %zmm4, %zmm17
vpandq %zmm16, %zmm4, %zmm4
vmovdqa64 320(%rsi), %zmm5
vpsubq 320(%rdx), %zmm5, %zmm5
vpsubq %zmm17, %zmm5, %zmm5
vpsrlq $63, %zmm5, %zmm17
vpandq %zmm16, %zmm5, %zmm5
vmovdqa64 384(%rsi), %zmm6
vpsubq 384(%rdx), %zmm6, %zmm6
vpsubq %zmm17, %zmm6, %zmm6
vpsrlq $63, %zmm6, %zmm17
vpandq %zmm16, %zmm6, %zmm6
vmovdqa64 448(%rsi), %zmm7
vpsubq 448(%rdx), %zmm7, %zmm7
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
vmovdqa64 %zmm0, (%rdi)
vmovdqa64 %zmm1, 64(%rdi)
vmovdqa64 %zmm2, 128(%rdi)
vmovdqa64 %zmm3, 192(%rdi)
vmovdqa64 %zmm4, 256(%rdi)
vmovdqa64 %zmm5, 320(%rdi)
vmovdqa64 %zmm6, 384(%rdi)
vmovdqa64 %zmm7, 448(%rdi)
vzeroupper
ret
SIZE(mcl_c5_vsub)
.global PRE(mcl_c5_vmul)
PRE(mcl_c5_vmul):
TYPE(mcl_c5_vmul)
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
lea PRE(rp)(%rip), %r10
vmovdqa64 (%rdx), %zmm11
add $64, %rdx
vpxorq %zmm0, %zmm0, %zmm0
vpmadd52luq (%rsi), %zmm11, %zmm0
vpxorq %zmm10, %zmm10, %zmm10
vpmadd52huq (%rsi), %zmm11, %zmm10
vmovdqa64 %zmm10, %zmm1
vpmadd52luq 64(%rsi), %zmm11, %zmm1
vpxorq %zmm10, %zmm10, %zmm10
vpmadd52huq 64(%rsi), %zmm11, %zmm10
vmovdqa64 %zmm10, %zmm2
vpmadd52luq 128(%rsi), %zmm11, %zmm2
vpxorq %zmm10, %zmm10, %zmm10
vpmadd52huq 128(%rsi), %zmm11, %zmm10
vmovdqa64 %zmm10, %zmm3
vpmadd52luq 192(%rsi), %zmm11, %zmm3
vpxorq %zmm10, %zmm10, %zmm10
vpmadd52huq 192(%rsi), %zmm11, %zmm10
vmovdqa64 %zmm10, %zmm4
vpmadd52luq 256(%rsi), %zmm11, %zmm4
vpxorq %zmm10, %zmm10, %zmm10
vpmadd52huq 256(%rsi), %zmm11, %zmm10
vmovdqa64 %zmm10, %zmm5
vpmadd52luq 320(%rsi), %zmm11, %zmm5
vpxorq %zmm10, %zmm10, %zmm10
vpmadd52huq 320(%rsi), %zmm11, %zmm10
vmovdqa64 %zmm10, %zmm6
vpmadd52luq 384(%rsi), %zmm11, %zmm6
vpxorq %zmm10, %zmm10, %zmm10
vpmadd52huq 384(%rsi), %zmm11, %zmm10
vmovdqa64 %zmm10, %zmm7
vpmadd52luq 448(%rsi), %zmm11, %zmm7
vpxorq %zmm8, %zmm8, %zmm8
vpmadd52huq 448(%rsi), %zmm11, %zmm8
vpxorq %zmm11, %zmm11, %zmm11
vpmadd52luq (%r10){1to8}, %zmm0, %zmm11
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
mov %rsi, %rax
vmovdqa64 (%rdx), %zmm11
add $64, %rdx
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
vpmadd52luq (%r10){1to8}, %zmm0, %zmm11
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
vmovdqa64 %zmm1, (%rdi)
vmovdqa64 %zmm2, 64(%rdi)
vmovdqa64 %zmm3, 128(%rdi)
vmovdqa64 %zmm4, 192(%rdi)
vmovdqa64 %zmm5, 256(%rdi)
vmovdqa64 %zmm6, 320(%rdi)
vmovdqa64 %zmm7, 384(%rdi)
vmovdqa64 %zmm8, 448(%rdi)
vzeroupper
ret
SIZE(mcl_c5_vmul)
.global PRE(mcl_c5_vaddA)
PRE(mcl_c5_vaddA):
TYPE(mcl_c5_vaddA)
mov $4503599627370495, %rax
vpbroadcastq %rax, %zmm16
lea PRE(p)(%rip), %rax
mov $2, %r10
.L2:
vmovdqa64 (%rsi), %zmm0
vpaddq (%rdx), %zmm0, %zmm0
vpsrlq $52, %zmm0, %zmm17
vpandq %zmm16, %zmm0, %zmm0
vmovdqa64 128(%rsi), %zmm1
vpaddq 128(%rdx), %zmm1, %zmm1
vpaddq %zmm17, %zmm1, %zmm1
vpsrlq $52, %zmm1, %zmm17
vpandq %zmm16, %zmm1, %zmm1
vmovdqa64 256(%rsi), %zmm2
vpaddq 256(%rdx), %zmm2, %zmm2
vpaddq %zmm17, %zmm2, %zmm2
vpsrlq $52, %zmm2, %zmm17
vpandq %zmm16, %zmm2, %zmm2
vmovdqa64 384(%rsi), %zmm3
vpaddq 384(%rdx), %zmm3, %zmm3
vpaddq %zmm17, %zmm3, %zmm3
vpsrlq $52, %zmm3, %zmm17
vpandq %zmm16, %zmm3, %zmm3
vmovdqa64 512(%rsi), %zmm4
vpaddq 512(%rdx), %zmm4, %zmm4
vpaddq %zmm17, %zmm4, %zmm4
vpsrlq $52, %zmm4, %zmm17
vpandq %zmm16, %zmm4, %zmm4
vmovdqa64 640(%rsi), %zmm5
vpaddq 640(%rdx), %zmm5, %zmm5
vpaddq %zmm17, %zmm5, %zmm5
vpsrlq $52, %zmm5, %zmm17
vpandq %zmm16, %zmm5, %zmm5
vmovdqa64 768(%rsi), %zmm6
vpaddq 768(%rdx), %zmm6, %zmm6
vpaddq %zmm17, %zmm6, %zmm6
vpsrlq $52, %zmm6, %zmm17
vpandq %zmm16, %zmm6, %zmm6
vmovdqa64 896(%rsi), %zmm7
vpaddq 896(%rdx), %zmm7, %zmm7
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
vmovdqa64 %zmm0, (%rdi)
vmovdqa64 %zmm1, 128(%rdi)
vmovdqa64 %zmm2, 256(%rdi)
vmovdqa64 %zmm3, 384(%rdi)
vmovdqa64 %zmm4, 512(%rdi)
vmovdqa64 %zmm5, 640(%rdi)
vmovdqa64 %zmm6, 768(%rdi)
vmovdqa64 %zmm7, 896(%rdi)
add $64, %rsi
add $64, %rdx
add $64, %rdi
sub $1, %r10
jnz .L2
vzeroupper
ret
SIZE(mcl_c5_vaddA)
.global PRE(mcl_c5_vsubA)
PRE(mcl_c5_vsubA):
TYPE(mcl_c5_vsubA)
mov $4503599627370495, %rax
vpbroadcastq %rax, %zmm24
lea PRE(p)(%rip), %rax
vmovdqa64 (%rsi), %zmm0
vmovdqa64 64(%rsi), %zmm1
vpsubq (%rdx), %zmm0, %zmm0
vpsubq 64(%rdx), %zmm1, %zmm1
vpsrlq $63, %zmm0, %zmm25
vpsrlq $63, %zmm1, %zmm26
vpandq %zmm24, %zmm0, %zmm0
vpandq %zmm24, %zmm1, %zmm1
vmovdqa64 128(%rsi), %zmm2
vmovdqa64 192(%rsi), %zmm3
vpsubq 128(%rdx), %zmm2, %zmm2
vpsubq 192(%rdx), %zmm3, %zmm3
vpsubq %zmm25, %zmm2, %zmm2
vpsubq %zmm26, %zmm3, %zmm3
vpsrlq $63, %zmm2, %zmm25
vpsrlq $63, %zmm3, %zmm26
vpandq %zmm24, %zmm2, %zmm2
vpandq %zmm24, %zmm3, %zmm3
vmovdqa64 256(%rsi), %zmm4
vmovdqa64 320(%rsi), %zmm5
vpsubq 256(%rdx), %zmm4, %zmm4
vpsubq 320(%rdx), %zmm5, %zmm5
vpsubq %zmm25, %zmm4, %zmm4
vpsubq %zmm26, %zmm5, %zmm5
vpsrlq $63, %zmm4, %zmm25
vpsrlq $63, %zmm5, %zmm26
vpandq %zmm24, %zmm4, %zmm4
vpandq %zmm24, %zmm5, %zmm5
vmovdqa64 384(%rsi), %zmm6
vmovdqa64 448(%rsi), %zmm7
vpsubq 384(%rdx), %zmm6, %zmm6
vpsubq 448(%rdx), %zmm7, %zmm7
vpsubq %zmm25, %zmm6, %zmm6
vpsubq %zmm26, %zmm7, %zmm7
vpsrlq $63, %zmm6, %zmm25
vpsrlq $63, %zmm7, %zmm26
vpandq %zmm24, %zmm6, %zmm6
vpandq %zmm24, %zmm7, %zmm7
vmovdqa64 512(%rsi), %zmm8
vmovdqa64 576(%rsi), %zmm9
vpsubq 512(%rdx), %zmm8, %zmm8
vpsubq 576(%rdx), %zmm9, %zmm9
vpsubq %zmm25, %zmm8, %zmm8
vpsubq %zmm26, %zmm9, %zmm9
vpsrlq $63, %zmm8, %zmm25
vpsrlq $63, %zmm9, %zmm26
vpandq %zmm24, %zmm8, %zmm8
vpandq %zmm24, %zmm9, %zmm9
vmovdqa64 640(%rsi), %zmm10
vmovdqa64 704(%rsi), %zmm11
vpsubq 640(%rdx), %zmm10, %zmm10
vpsubq 704(%rdx), %zmm11, %zmm11
vpsubq %zmm25, %zmm10, %zmm10
vpsubq %zmm26, %zmm11, %zmm11
vpsrlq $63, %zmm10, %zmm25
vpsrlq $63, %zmm11, %zmm26
vpandq %zmm24, %zmm10, %zmm10
vpandq %zmm24, %zmm11, %zmm11
vmovdqa64 768(%rsi), %zmm12
vmovdqa64 832(%rsi), %zmm13
vpsubq 768(%rdx), %zmm12, %zmm12
vpsubq 832(%rdx), %zmm13, %zmm13
vpsubq %zmm25, %zmm12, %zmm12
vpsubq %zmm26, %zmm13, %zmm13
vpsrlq $63, %zmm12, %zmm25
vpsrlq $63, %zmm13, %zmm26
vpandq %zmm24, %zmm12, %zmm12
vpandq %zmm24, %zmm13, %zmm13
vmovdqa64 896(%rsi), %zmm14
vmovdqa64 960(%rsi), %zmm15
vpsubq 896(%rdx), %zmm14, %zmm14
vpsubq 960(%rdx), %zmm15, %zmm15
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
vmovdqa64 %zmm0, (%rdi)
vmovdqa64 %zmm1, 64(%rdi)
vmovdqa64 %zmm2, 128(%rdi)
vmovdqa64 %zmm3, 192(%rdi)
vmovdqa64 %zmm4, 256(%rdi)
vmovdqa64 %zmm5, 320(%rdi)
vmovdqa64 %zmm6, 384(%rdi)
vmovdqa64 %zmm7, 448(%rdi)
vmovdqa64 %zmm8, 512(%rdi)
vmovdqa64 %zmm9, 576(%rdi)
vmovdqa64 %zmm10, 640(%rdi)
vmovdqa64 %zmm11, 704(%rdi)
vmovdqa64 %zmm12, 768(%rdi)
vmovdqa64 %zmm13, 832(%rdi)
vmovdqa64 %zmm14, 896(%rdi)
vmovdqa64 %zmm15, 960(%rdi)
vzeroupper
ret
SIZE(mcl_c5_vsubA)
.global PRE(mcl_c5_vmulA)
PRE(mcl_c5_vmulA):
TYPE(mcl_c5_vmulA)
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
lea PRE(rp)(%rip), %rcx
vmovdqa64 (%rdx), %zmm21
vmovdqa64 64(%rdx), %zmm22
add $128, %rdx
vpxorq %zmm0, %zmm0, %zmm0
vpxorq %zmm1, %zmm1, %zmm1
vpmadd52luq (%rsi), %zmm21, %zmm0
vpmadd52luq 64(%rsi), %zmm22, %zmm1
vpxorq %zmm19, %zmm19, %zmm19
vpxorq %zmm20, %zmm20, %zmm20
vpmadd52huq (%rsi), %zmm21, %zmm19
vpmadd52huq 64(%rsi), %zmm22, %zmm20
vmovdqa64 %zmm19, %zmm2
vmovdqa64 %zmm20, %zmm3
vpmadd52luq 128(%rsi), %zmm21, %zmm2
vpmadd52luq 192(%rsi), %zmm22, %zmm3
vpxorq %zmm19, %zmm19, %zmm19
vpxorq %zmm20, %zmm20, %zmm20
vpmadd52huq 128(%rsi), %zmm21, %zmm19
vpmadd52huq 192(%rsi), %zmm22, %zmm20
vmovdqa64 %zmm19, %zmm4
vmovdqa64 %zmm20, %zmm5
vpmadd52luq 256(%rsi), %zmm21, %zmm4
vpmadd52luq 320(%rsi), %zmm22, %zmm5
vpxorq %zmm19, %zmm19, %zmm19
vpxorq %zmm20, %zmm20, %zmm20
vpmadd52huq 256(%rsi), %zmm21, %zmm19
vpmadd52huq 320(%rsi), %zmm22, %zmm20
vmovdqa64 %zmm19, %zmm6
vmovdqa64 %zmm20, %zmm7
vpmadd52luq 384(%rsi), %zmm21, %zmm6
vpmadd52luq 448(%rsi), %zmm22, %zmm7
vpxorq %zmm19, %zmm19, %zmm19
vpxorq %zmm20, %zmm20, %zmm20
vpmadd52huq 384(%rsi), %zmm21, %zmm19
vpmadd52huq 448(%rsi), %zmm22, %zmm20
vmovdqa64 %zmm19, %zmm8
vmovdqa64 %zmm20, %zmm9
vpmadd52luq 512(%rsi), %zmm21, %zmm8
vpmadd52luq 576(%rsi), %zmm22, %zmm9
vpxorq %zmm19, %zmm19, %zmm19
vpxorq %zmm20, %zmm20, %zmm20
vpmadd52huq 512(%rsi), %zmm21, %zmm19
vpmadd52huq 576(%rsi), %zmm22, %zmm20
vmovdqa64 %zmm19, %zmm10
vmovdqa64 %zmm20, %zmm11
vpmadd52luq 640(%rsi), %zmm21, %zmm10
vpmadd52luq 704(%rsi), %zmm22, %zmm11
vpxorq %zmm19, %zmm19, %zmm19
vpxorq %zmm20, %zmm20, %zmm20
vpmadd52huq 640(%rsi), %zmm21, %zmm19
vpmadd52huq 704(%rsi), %zmm22, %zmm20
vmovdqa64 %zmm19, %zmm12
vmovdqa64 %zmm20, %zmm13
vpmadd52luq 768(%rsi), %zmm21, %zmm12
vpmadd52luq 832(%rsi), %zmm22, %zmm13
vpxorq %zmm19, %zmm19, %zmm19
vpxorq %zmm20, %zmm20, %zmm20
vpmadd52huq 768(%rsi), %zmm21, %zmm19
vpmadd52huq 832(%rsi), %zmm22, %zmm20
vmovdqa64 %zmm19, %zmm14
vmovdqa64 %zmm20, %zmm15
vpmadd52luq 896(%rsi), %zmm21, %zmm14
vpmadd52luq 960(%rsi), %zmm22, %zmm15
vpxorq %zmm16, %zmm16, %zmm16
vpxorq %zmm17, %zmm17, %zmm17
vpmadd52huq 896(%rsi), %zmm21, %zmm16
vpmadd52huq 960(%rsi), %zmm22, %zmm17
vpxorq %zmm21, %zmm21, %zmm21
vpxorq %zmm22, %zmm22, %zmm22
vpmadd52luq (%rcx){1to8}, %zmm0, %zmm21
vpmadd52luq (%rcx){1to8}, %zmm1, %zmm22
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
mov $7, %r8
.balign 32
.L3:
mov %rsi, %rax
vmovdqa64 (%rdx), %zmm21
vmovdqa64 64(%rdx), %zmm22
add $128, %rdx
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
vpmadd52luq (%rcx){1to8}, %zmm0, %zmm21
vpmadd52luq (%rcx){1to8}, %zmm1, %zmm22
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
dec %r8
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
vmovdqa64 %zmm2, (%rdi)
vmovdqa64 %zmm3, 64(%rdi)
vmovdqa64 %zmm4, 128(%rdi)
vmovdqa64 %zmm5, 192(%rdi)
vmovdqa64 %zmm6, 256(%rdi)
vmovdqa64 %zmm7, 320(%rdi)
vmovdqa64 %zmm8, 384(%rdi)
vmovdqa64 %zmm9, 448(%rdi)
vmovdqa64 %zmm10, 512(%rdi)
vmovdqa64 %zmm11, 576(%rdi)
vmovdqa64 %zmm12, 640(%rdi)
vmovdqa64 %zmm13, 704(%rdi)
vmovdqa64 %zmm14, 768(%rdi)
vmovdqa64 %zmm15, 832(%rdi)
vmovdqa64 %zmm16, 896(%rdi)
vmovdqa64 %zmm17, 960(%rdi)
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
vmovdqa64 %zmm10, 512(%rdi)
vmovdqa64 %zmm11, 576(%rdi)
vmovdqa64 %zmm12, 640(%rdi)
vmovdqa64 %zmm13, 704(%rdi)
vmovdqa64 %zmm14, 768(%rdi)
vmovdqa64 %zmm15, 832(%rdi)
vmovdqa64 %zmm16, 896(%rdi)
vmovdqa64 %zmm17, 960(%rdi)
vzeroupper
ret
SIZE(mcl_c5_vmulA)
.balign 16
.global PRE(mclb_add1)
PRE(mclb_add1):
TYPE(mclb_add1)
mov (%rsi), %rax
add (%rdx), %rax
mov %rax, (%rdi)
setc %al
movzx %al, %eax
ret
SIZE(mclb_add1)
.balign 16
.global PRE(mclb_add2)
PRE(mclb_add2):
TYPE(mclb_add2)
mov (%rsi), %rax
add (%rdx), %rax
mov %rax, (%rdi)
mov 8(%rsi), %rax
adc 8(%rdx), %rax
mov %rax, 8(%rdi)
setc %al
movzx %al, %eax
ret
SIZE(mclb_add2)
.balign 16
.global PRE(mclb_add3)
PRE(mclb_add3):
TYPE(mclb_add3)
mov (%rsi), %rax
add (%rdx), %rax
mov %rax, (%rdi)
mov 8(%rsi), %rax
adc 8(%rdx), %rax
mov %rax, 8(%rdi)
mov 16(%rsi), %rax
adc 16(%rdx), %rax
mov %rax, 16(%rdi)
setc %al
movzx %al, %eax
ret
SIZE(mclb_add3)
.balign 16
.global PRE(mclb_add4)
PRE(mclb_add4):
TYPE(mclb_add4)
mov (%rsi), %rax
add (%rdx), %rax
mov %rax, (%rdi)
mov 8(%rsi), %rax
adc 8(%rdx), %rax
mov %rax, 8(%rdi)
mov 16(%rsi), %rax
adc 16(%rdx), %rax
mov %rax, 16(%rdi)
mov 24(%rsi), %rax
adc 24(%rdx), %rax
mov %rax, 24(%rdi)
setc %al
movzx %al, %eax
ret
SIZE(mclb_add4)
.balign 16
.global PRE(mclb_add5)
PRE(mclb_add5):
TYPE(mclb_add5)
mov (%rsi), %rax
add (%rdx), %rax
mov %rax, (%rdi)
mov 8(%rsi), %rax
adc 8(%rdx), %rax
mov %rax, 8(%rdi)
mov 16(%rsi), %rax
adc 16(%rdx), %rax
mov %rax, 16(%rdi)
mov 24(%rsi), %rax
adc 24(%rdx), %rax
mov %rax, 24(%rdi)
mov 32(%rsi), %rax
adc 32(%rdx), %rax
mov %rax, 32(%rdi)
setc %al
movzx %al, %eax
ret
SIZE(mclb_add5)
.balign 16
.global PRE(mclb_add6)
PRE(mclb_add6):
TYPE(mclb_add6)
mov (%rsi), %rax
add (%rdx), %rax
mov %rax, (%rdi)
mov 8(%rsi), %rax
adc 8(%rdx), %rax
mov %rax, 8(%rdi)
mov 16(%rsi), %rax
adc 16(%rdx), %rax
mov %rax, 16(%rdi)
mov 24(%rsi), %rax
adc 24(%rdx), %rax
mov %rax, 24(%rdi)
mov 32(%rsi), %rax
adc 32(%rdx), %rax
mov %rax, 32(%rdi)
mov 40(%rsi), %rax
adc 40(%rdx), %rax
mov %rax, 40(%rdi)
setc %al
movzx %al, %eax
ret
SIZE(mclb_add6)
.balign 16
.global PRE(mclb_add7)
PRE(mclb_add7):
TYPE(mclb_add7)
mov (%rsi), %rax
add (%rdx), %rax
mov %rax, (%rdi)
mov 8(%rsi), %rax
adc 8(%rdx), %rax
mov %rax, 8(%rdi)
mov 16(%rsi), %rax
adc 16(%rdx), %rax
mov %rax, 16(%rdi)
mov 24(%rsi), %rax
adc 24(%rdx), %rax
mov %rax, 24(%rdi)
mov 32(%rsi), %rax
adc 32(%rdx), %rax
mov %rax, 32(%rdi)
mov 40(%rsi), %rax
adc 40(%rdx), %rax
mov %rax, 40(%rdi)
mov 48(%rsi), %rax
adc 48(%rdx), %rax
mov %rax, 48(%rdi)
setc %al
movzx %al, %eax
ret
SIZE(mclb_add7)
.balign 16
.global PRE(mclb_add8)
PRE(mclb_add8):
TYPE(mclb_add8)
mov (%rsi), %rax
add (%rdx), %rax
mov %rax, (%rdi)
mov 8(%rsi), %rax
adc 8(%rdx), %rax
mov %rax, 8(%rdi)
mov 16(%rsi), %rax
adc 16(%rdx), %rax
mov %rax, 16(%rdi)
mov 24(%rsi), %rax
adc 24(%rdx), %rax
mov %rax, 24(%rdi)
mov 32(%rsi), %rax
adc 32(%rdx), %rax
mov %rax, 32(%rdi)
mov 40(%rsi), %rax
adc 40(%rdx), %rax
mov %rax, 40(%rdi)
mov 48(%rsi), %rax
adc 48(%rdx), %rax
mov %rax, 48(%rdi)
mov 56(%rsi), %rax
adc 56(%rdx), %rax
mov %rax, 56(%rdi)
setc %al
movzx %al, %eax
ret
SIZE(mclb_add8)
.balign 16
.global PRE(mclb_add9)
PRE(mclb_add9):
TYPE(mclb_add9)
mov (%rsi), %rax
add (%rdx), %rax
mov %rax, (%rdi)
mov 8(%rsi), %rax
adc 8(%rdx), %rax
mov %rax, 8(%rdi)
mov 16(%rsi), %rax
adc 16(%rdx), %rax
mov %rax, 16(%rdi)
mov 24(%rsi), %rax
adc 24(%rdx), %rax
mov %rax, 24(%rdi)
mov 32(%rsi), %rax
adc 32(%rdx), %rax
mov %rax, 32(%rdi)
mov 40(%rsi), %rax
adc 40(%rdx), %rax
mov %rax, 40(%rdi)
mov 48(%rsi), %rax
adc 48(%rdx), %rax
mov %rax, 48(%rdi)
mov 56(%rsi), %rax
adc 56(%rdx), %rax
mov %rax, 56(%rdi)
mov 64(%rsi), %rax
adc 64(%rdx), %rax
mov %rax, 64(%rdi)
setc %al
movzx %al, %eax
ret
SIZE(mclb_add9)
.balign 16
.global PRE(mclb_add10)
PRE(mclb_add10):
TYPE(mclb_add10)
mov (%rsi), %rax
add (%rdx), %rax
mov %rax, (%rdi)
mov 8(%rsi), %rax
adc 8(%rdx), %rax
mov %rax, 8(%rdi)
mov 16(%rsi), %rax
adc 16(%rdx), %rax
mov %rax, 16(%rdi)
mov 24(%rsi), %rax
adc 24(%rdx), %rax
mov %rax, 24(%rdi)
mov 32(%rsi), %rax
adc 32(%rdx), %rax
mov %rax, 32(%rdi)
mov 40(%rsi), %rax
adc 40(%rdx), %rax
mov %rax, 40(%rdi)
mov 48(%rsi), %rax
adc 48(%rdx), %rax
mov %rax, 48(%rdi)
mov 56(%rsi), %rax
adc 56(%rdx), %rax
mov %rax, 56(%rdi)
mov 64(%rsi), %rax
adc 64(%rdx), %rax
mov %rax, 64(%rdi)
mov 72(%rsi), %rax
adc 72(%rdx), %rax
mov %rax, 72(%rdi)
setc %al
movzx %al, %eax
ret
SIZE(mclb_add10)
.balign 16
.global PRE(mclb_add11)
PRE(mclb_add11):
TYPE(mclb_add11)
mov (%rsi), %rax
add (%rdx), %rax
mov %rax, (%rdi)
mov 8(%rsi), %rax
adc 8(%rdx), %rax
mov %rax, 8(%rdi)
mov 16(%rsi), %rax
adc 16(%rdx), %rax
mov %rax, 16(%rdi)
mov 24(%rsi), %rax
adc 24(%rdx), %rax
mov %rax, 24(%rdi)
mov 32(%rsi), %rax
adc 32(%rdx), %rax
mov %rax, 32(%rdi)
mov 40(%rsi), %rax
adc 40(%rdx), %rax
mov %rax, 40(%rdi)
mov 48(%rsi), %rax
adc 48(%rdx), %rax
mov %rax, 48(%rdi)
mov 56(%rsi), %rax
adc 56(%rdx), %rax
mov %rax, 56(%rdi)
mov 64(%rsi), %rax
adc 64(%rdx), %rax
mov %rax, 64(%rdi)
mov 72(%rsi), %rax
adc 72(%rdx), %rax
mov %rax, 72(%rdi)
mov 80(%rsi), %rax
adc 80(%rdx), %rax
mov %rax, 80(%rdi)
setc %al
movzx %al, %eax
ret
SIZE(mclb_add11)
.balign 16
.global PRE(mclb_add12)
PRE(mclb_add12):
TYPE(mclb_add12)
mov (%rsi), %rax
add (%rdx), %rax
mov %rax, (%rdi)
mov 8(%rsi), %rax
adc 8(%rdx), %rax
mov %rax, 8(%rdi)
mov 16(%rsi), %rax
adc 16(%rdx), %rax
mov %rax, 16(%rdi)
mov 24(%rsi), %rax
adc 24(%rdx), %rax
mov %rax, 24(%rdi)
mov 32(%rsi), %rax
adc 32(%rdx), %rax
mov %rax, 32(%rdi)
mov 40(%rsi), %rax
adc 40(%rdx), %rax
mov %rax, 40(%rdi)
mov 48(%rsi), %rax
adc 48(%rdx), %rax
mov %rax, 48(%rdi)
mov 56(%rsi), %rax
adc 56(%rdx), %rax
mov %rax, 56(%rdi)
mov 64(%rsi), %rax
adc 64(%rdx), %rax
mov %rax, 64(%rdi)
mov 72(%rsi), %rax
adc 72(%rdx), %rax
mov %rax, 72(%rdi)
mov 80(%rsi), %rax
adc 80(%rdx), %rax
mov %rax, 80(%rdi)
mov 88(%rsi), %rax
adc 88(%rdx), %rax
mov %rax, 88(%rdi)
setc %al
movzx %al, %eax
ret
SIZE(mclb_add12)
.balign 16
.global PRE(mclb_add13)
PRE(mclb_add13):
TYPE(mclb_add13)
mov (%rsi), %rax
add (%rdx), %rax
mov %rax, (%rdi)
mov 8(%rsi), %rax
adc 8(%rdx), %rax
mov %rax, 8(%rdi)
mov 16(%rsi), %rax
adc 16(%rdx), %rax
mov %rax, 16(%rdi)
mov 24(%rsi), %rax
adc 24(%rdx), %rax
mov %rax, 24(%rdi)
mov 32(%rsi), %rax
adc 32(%rdx), %rax
mov %rax, 32(%rdi)
mov 40(%rsi), %rax
adc 40(%rdx), %rax
mov %rax, 40(%rdi)
mov 48(%rsi), %rax
adc 48(%rdx), %rax
mov %rax, 48(%rdi)
mov 56(%rsi), %rax
adc 56(%rdx), %rax
mov %rax, 56(%rdi)
mov 64(%rsi), %rax
adc 64(%rdx), %rax
mov %rax, 64(%rdi)
mov 72(%rsi), %rax
adc 72(%rdx), %rax
mov %rax, 72(%rdi)
mov 80(%rsi), %rax
adc 80(%rdx), %rax
mov %rax, 80(%rdi)
mov 88(%rsi), %rax
adc 88(%rdx), %rax
mov %rax, 88(%rdi)
mov 96(%rsi), %rax
adc 96(%rdx), %rax
mov %rax, 96(%rdi)
setc %al
movzx %al, %eax
ret
SIZE(mclb_add13)
.balign 16
.global PRE(mclb_add14)
PRE(mclb_add14):
TYPE(mclb_add14)
mov (%rsi), %rax
add (%rdx), %rax
mov %rax, (%rdi)
mov 8(%rsi), %rax
adc 8(%rdx), %rax
mov %rax, 8(%rdi)
mov 16(%rsi), %rax
adc 16(%rdx), %rax
mov %rax, 16(%rdi)
mov 24(%rsi), %rax
adc 24(%rdx), %rax
mov %rax, 24(%rdi)
mov 32(%rsi), %rax
adc 32(%rdx), %rax
mov %rax, 32(%rdi)
mov 40(%rsi), %rax
adc 40(%rdx), %rax
mov %rax, 40(%rdi)
mov 48(%rsi), %rax
adc 48(%rdx), %rax
mov %rax, 48(%rdi)
mov 56(%rsi), %rax
adc 56(%rdx), %rax
mov %rax, 56(%rdi)
mov 64(%rsi), %rax
adc 64(%rdx), %rax
mov %rax, 64(%rdi)
mov 72(%rsi), %rax
adc 72(%rdx), %rax
mov %rax, 72(%rdi)
mov 80(%rsi), %rax
adc 80(%rdx), %rax
mov %rax, 80(%rdi)
mov 88(%rsi), %rax
adc 88(%rdx), %rax
mov %rax, 88(%rdi)
mov 96(%rsi), %rax
adc 96(%rdx), %rax
mov %rax, 96(%rdi)
mov 104(%rsi), %rax
adc 104(%rdx), %rax
mov %rax, 104(%rdi)
setc %al
movzx %al, %eax
ret
SIZE(mclb_add14)
.balign 16
.global PRE(mclb_add15)
PRE(mclb_add15):
TYPE(mclb_add15)
mov (%rsi), %rax
add (%rdx), %rax
mov %rax, (%rdi)
mov 8(%rsi), %rax
adc 8(%rdx), %rax
mov %rax, 8(%rdi)
mov 16(%rsi), %rax
adc 16(%rdx), %rax
mov %rax, 16(%rdi)
mov 24(%rsi), %rax
adc 24(%rdx), %rax
mov %rax, 24(%rdi)
mov 32(%rsi), %rax
adc 32(%rdx), %rax
mov %rax, 32(%rdi)
mov 40(%rsi), %rax
adc 40(%rdx), %rax
mov %rax, 40(%rdi)
mov 48(%rsi), %rax
adc 48(%rdx), %rax
mov %rax, 48(%rdi)
mov 56(%rsi), %rax
adc 56(%rdx), %rax
mov %rax, 56(%rdi)
mov 64(%rsi), %rax
adc 64(%rdx), %rax
mov %rax, 64(%rdi)
mov 72(%rsi), %rax
adc 72(%rdx), %rax
mov %rax, 72(%rdi)
mov 80(%rsi), %rax
adc 80(%rdx), %rax
mov %rax, 80(%rdi)
mov 88(%rsi), %rax
adc 88(%rdx), %rax
mov %rax, 88(%rdi)
mov 96(%rsi), %rax
adc 96(%rdx), %rax
mov %rax, 96(%rdi)
mov 104(%rsi), %rax
adc 104(%rdx), %rax
mov %rax, 104(%rdi)
mov 112(%rsi), %rax
adc 112(%rdx), %rax
mov %rax, 112(%rdi)
setc %al
movzx %al, %eax
ret
SIZE(mclb_add15)
.balign 16
.global PRE(mclb_add16)
PRE(mclb_add16):
TYPE(mclb_add16)
mov (%rsi), %rax
add (%rdx), %rax
mov %rax, (%rdi)
mov 8(%rsi), %rax
adc 8(%rdx), %rax
mov %rax, 8(%rdi)
mov 16(%rsi), %rax
adc 16(%rdx), %rax
mov %rax, 16(%rdi)
mov 24(%rsi), %rax
adc 24(%rdx), %rax
mov %rax, 24(%rdi)
mov 32(%rsi), %rax
adc 32(%rdx), %rax
mov %rax, 32(%rdi)
mov 40(%rsi), %rax
adc 40(%rdx), %rax
mov %rax, 40(%rdi)
mov 48(%rsi), %rax
adc 48(%rdx), %rax
mov %rax, 48(%rdi)
mov 56(%rsi), %rax
adc 56(%rdx), %rax
mov %rax, 56(%rdi)
mov 64(%rsi), %rax
adc 64(%rdx), %rax
mov %rax, 64(%rdi)
mov 72(%rsi), %rax
adc 72(%rdx), %rax
mov %rax, 72(%rdi)
mov 80(%rsi), %rax
adc 80(%rdx), %rax
mov %rax, 80(%rdi)
mov 88(%rsi), %rax
adc 88(%rdx), %rax
mov %rax, 88(%rdi)
mov 96(%rsi), %rax
adc 96(%rdx), %rax
mov %rax, 96(%rdi)
mov 104(%rsi), %rax
adc 104(%rdx), %rax
mov %rax, 104(%rdi)
mov 112(%rsi), %rax
adc 112(%rdx), %rax
mov %rax, 112(%rdi)
mov 120(%rsi), %rax
adc 120(%rdx), %rax
mov %rax, 120(%rdi)
setc %al
movzx %al, %eax
ret
SIZE(mclb_add16)
.balign 16
.global PRE(mclb_sub1)
PRE(mclb_sub1):
TYPE(mclb_sub1)
mov (%rsi), %rax
sub (%rdx), %rax
mov %rax, (%rdi)
setc %al
movzx %al, %eax
ret
SIZE(mclb_sub1)
.balign 16
.global PRE(mclb_sub2)
PRE(mclb_sub2):
TYPE(mclb_sub2)
mov (%rsi), %rax
sub (%rdx), %rax
mov %rax, (%rdi)
mov 8(%rsi), %rax
sbb 8(%rdx), %rax
mov %rax, 8(%rdi)
setc %al
movzx %al, %eax
ret
SIZE(mclb_sub2)
.balign 16
.global PRE(mclb_sub3)
PRE(mclb_sub3):
TYPE(mclb_sub3)
mov (%rsi), %rax
sub (%rdx), %rax
mov %rax, (%rdi)
mov 8(%rsi), %rax
sbb 8(%rdx), %rax
mov %rax, 8(%rdi)
mov 16(%rsi), %rax
sbb 16(%rdx), %rax
mov %rax, 16(%rdi)
setc %al
movzx %al, %eax
ret
SIZE(mclb_sub3)
.balign 16
.global PRE(mclb_sub4)
PRE(mclb_sub4):
TYPE(mclb_sub4)
mov (%rsi), %rax
sub (%rdx), %rax
mov %rax, (%rdi)
mov 8(%rsi), %rax
sbb 8(%rdx), %rax
mov %rax, 8(%rdi)
mov 16(%rsi), %rax
sbb 16(%rdx), %rax
mov %rax, 16(%rdi)
mov 24(%rsi), %rax
sbb 24(%rdx), %rax
mov %rax, 24(%rdi)
setc %al
movzx %al, %eax
ret
SIZE(mclb_sub4)
.balign 16
.global PRE(mclb_sub5)
PRE(mclb_sub5):
TYPE(mclb_sub5)
mov (%rsi), %rax
sub (%rdx), %rax
mov %rax, (%rdi)
mov 8(%rsi), %rax
sbb 8(%rdx), %rax
mov %rax, 8(%rdi)
mov 16(%rsi), %rax
sbb 16(%rdx), %rax
mov %rax, 16(%rdi)
mov 24(%rsi), %rax
sbb 24(%rdx), %rax
mov %rax, 24(%rdi)
mov 32(%rsi), %rax
sbb 32(%rdx), %rax
mov %rax, 32(%rdi)
setc %al
movzx %al, %eax
ret
SIZE(mclb_sub5)
.balign 16
.global PRE(mclb_sub6)
PRE(mclb_sub6):
TYPE(mclb_sub6)
mov (%rsi), %rax
sub (%rdx), %rax
mov %rax, (%rdi)
mov 8(%rsi), %rax
sbb 8(%rdx), %rax
mov %rax, 8(%rdi)
mov 16(%rsi), %rax
sbb 16(%rdx), %rax
mov %rax, 16(%rdi)
mov 24(%rsi), %rax
sbb 24(%rdx), %rax
mov %rax, 24(%rdi)
mov 32(%rsi), %rax
sbb 32(%rdx), %rax
mov %rax, 32(%rdi)
mov 40(%rsi), %rax
sbb 40(%rdx), %rax
mov %rax, 40(%rdi)
setc %al
movzx %al, %eax
ret
SIZE(mclb_sub6)
.balign 16
.global PRE(mclb_sub7)
PRE(mclb_sub7):
TYPE(mclb_sub7)
mov (%rsi), %rax
sub (%rdx), %rax
mov %rax, (%rdi)
mov 8(%rsi), %rax
sbb 8(%rdx), %rax
mov %rax, 8(%rdi)
mov 16(%rsi), %rax
sbb 16(%rdx), %rax
mov %rax, 16(%rdi)
mov 24(%rsi), %rax
sbb 24(%rdx), %rax
mov %rax, 24(%rdi)
mov 32(%rsi), %rax
sbb 32(%rdx), %rax
mov %rax, 32(%rdi)
mov 40(%rsi), %rax
sbb 40(%rdx), %rax
mov %rax, 40(%rdi)
mov 48(%rsi), %rax
sbb 48(%rdx), %rax
mov %rax, 48(%rdi)
setc %al
movzx %al, %eax
ret
SIZE(mclb_sub7)
.balign 16
.global PRE(mclb_sub8)
PRE(mclb_sub8):
TYPE(mclb_sub8)
mov (%rsi), %rax
sub (%rdx), %rax
mov %rax, (%rdi)
mov 8(%rsi), %rax
sbb 8(%rdx), %rax
mov %rax, 8(%rdi)
mov 16(%rsi), %rax
sbb 16(%rdx), %rax
mov %rax, 16(%rdi)
mov 24(%rsi), %rax
sbb 24(%rdx), %rax
mov %rax, 24(%rdi)
mov 32(%rsi), %rax
sbb 32(%rdx), %rax
mov %rax, 32(%rdi)
mov 40(%rsi), %rax
sbb 40(%rdx), %rax
mov %rax, 40(%rdi)
mov 48(%rsi), %rax
sbb 48(%rdx), %rax
mov %rax, 48(%rdi)
mov 56(%rsi), %rax
sbb 56(%rdx), %rax
mov %rax, 56(%rdi)
setc %al
movzx %al, %eax
ret
SIZE(mclb_sub8)
.balign 16
.global PRE(mclb_sub9)
PRE(mclb_sub9):
TYPE(mclb_sub9)
mov (%rsi), %rax
sub (%rdx), %rax
mov %rax, (%rdi)
mov 8(%rsi), %rax
sbb 8(%rdx), %rax
mov %rax, 8(%rdi)
mov 16(%rsi), %rax
sbb 16(%rdx), %rax
mov %rax, 16(%rdi)
mov 24(%rsi), %rax
sbb 24(%rdx), %rax
mov %rax, 24(%rdi)
mov 32(%rsi), %rax
sbb 32(%rdx), %rax
mov %rax, 32(%rdi)
mov 40(%rsi), %rax
sbb 40(%rdx), %rax
mov %rax, 40(%rdi)
mov 48(%rsi), %rax
sbb 48(%rdx), %rax
mov %rax, 48(%rdi)
mov 56(%rsi), %rax
sbb 56(%rdx), %rax
mov %rax, 56(%rdi)
mov 64(%rsi), %rax
sbb 64(%rdx), %rax
mov %rax, 64(%rdi)
setc %al
movzx %al, %eax
ret
SIZE(mclb_sub9)
.balign 16
.global PRE(mclb_sub10)
PRE(mclb_sub10):
TYPE(mclb_sub10)
mov (%rsi), %rax
sub (%rdx), %rax
mov %rax, (%rdi)
mov 8(%rsi), %rax
sbb 8(%rdx), %rax
mov %rax, 8(%rdi)
mov 16(%rsi), %rax
sbb 16(%rdx), %rax
mov %rax, 16(%rdi)
mov 24(%rsi), %rax
sbb 24(%rdx), %rax
mov %rax, 24(%rdi)
mov 32(%rsi), %rax
sbb 32(%rdx), %rax
mov %rax, 32(%rdi)
mov 40(%rsi), %rax
sbb 40(%rdx), %rax
mov %rax, 40(%rdi)
mov 48(%rsi), %rax
sbb 48(%rdx), %rax
mov %rax, 48(%rdi)
mov 56(%rsi), %rax
sbb 56(%rdx), %rax
mov %rax, 56(%rdi)
mov 64(%rsi), %rax
sbb 64(%rdx), %rax
mov %rax, 64(%rdi)
mov 72(%rsi), %rax
sbb 72(%rdx), %rax
mov %rax, 72(%rdi)
setc %al
movzx %al, %eax
ret
SIZE(mclb_sub10)
.balign 16
.global PRE(mclb_sub11)
PRE(mclb_sub11):
TYPE(mclb_sub11)
mov (%rsi), %rax
sub (%rdx), %rax
mov %rax, (%rdi)
mov 8(%rsi), %rax
sbb 8(%rdx), %rax
mov %rax, 8(%rdi)
mov 16(%rsi), %rax
sbb 16(%rdx), %rax
mov %rax, 16(%rdi)
mov 24(%rsi), %rax
sbb 24(%rdx), %rax
mov %rax, 24(%rdi)
mov 32(%rsi), %rax
sbb 32(%rdx), %rax
mov %rax, 32(%rdi)
mov 40(%rsi), %rax
sbb 40(%rdx), %rax
mov %rax, 40(%rdi)
mov 48(%rsi), %rax
sbb 48(%rdx), %rax
mov %rax, 48(%rdi)
mov 56(%rsi), %rax
sbb 56(%rdx), %rax
mov %rax, 56(%rdi)
mov 64(%rsi), %rax
sbb 64(%rdx), %rax
mov %rax, 64(%rdi)
mov 72(%rsi), %rax
sbb 72(%rdx), %rax
mov %rax, 72(%rdi)
mov 80(%rsi), %rax
sbb 80(%rdx), %rax
mov %rax, 80(%rdi)
setc %al
movzx %al, %eax
ret
SIZE(mclb_sub11)
.balign 16
.global PRE(mclb_sub12)
PRE(mclb_sub12):
TYPE(mclb_sub12)
mov (%rsi), %rax
sub (%rdx), %rax
mov %rax, (%rdi)
mov 8(%rsi), %rax
sbb 8(%rdx), %rax
mov %rax, 8(%rdi)
mov 16(%rsi), %rax
sbb 16(%rdx), %rax
mov %rax, 16(%rdi)
mov 24(%rsi), %rax
sbb 24(%rdx), %rax
mov %rax, 24(%rdi)
mov 32(%rsi), %rax
sbb 32(%rdx), %rax
mov %rax, 32(%rdi)
mov 40(%rsi), %rax
sbb 40(%rdx), %rax
mov %rax, 40(%rdi)
mov 48(%rsi), %rax
sbb 48(%rdx), %rax
mov %rax, 48(%rdi)
mov 56(%rsi), %rax
sbb 56(%rdx), %rax
mov %rax, 56(%rdi)
mov 64(%rsi), %rax
sbb 64(%rdx), %rax
mov %rax, 64(%rdi)
mov 72(%rsi), %rax
sbb 72(%rdx), %rax
mov %rax, 72(%rdi)
mov 80(%rsi), %rax
sbb 80(%rdx), %rax
mov %rax, 80(%rdi)
mov 88(%rsi), %rax
sbb 88(%rdx), %rax
mov %rax, 88(%rdi)
setc %al
movzx %al, %eax
ret
SIZE(mclb_sub12)
.balign 16
.global PRE(mclb_sub13)
PRE(mclb_sub13):
TYPE(mclb_sub13)
mov (%rsi), %rax
sub (%rdx), %rax
mov %rax, (%rdi)
mov 8(%rsi), %rax
sbb 8(%rdx), %rax
mov %rax, 8(%rdi)
mov 16(%rsi), %rax
sbb 16(%rdx), %rax
mov %rax, 16(%rdi)
mov 24(%rsi), %rax
sbb 24(%rdx), %rax
mov %rax, 24(%rdi)
mov 32(%rsi), %rax
sbb 32(%rdx), %rax
mov %rax, 32(%rdi)
mov 40(%rsi), %rax
sbb 40(%rdx), %rax
mov %rax, 40(%rdi)
mov 48(%rsi), %rax
sbb 48(%rdx), %rax
mov %rax, 48(%rdi)
mov 56(%rsi), %rax
sbb 56(%rdx), %rax
mov %rax, 56(%rdi)
mov 64(%rsi), %rax
sbb 64(%rdx), %rax
mov %rax, 64(%rdi)
mov 72(%rsi), %rax
sbb 72(%rdx), %rax
mov %rax, 72(%rdi)
mov 80(%rsi), %rax
sbb 80(%rdx), %rax
mov %rax, 80(%rdi)
mov 88(%rsi), %rax
sbb 88(%rdx), %rax
mov %rax, 88(%rdi)
mov 96(%rsi), %rax
sbb 96(%rdx), %rax
mov %rax, 96(%rdi)
setc %al
movzx %al, %eax
ret
SIZE(mclb_sub13)
.balign 16
.global PRE(mclb_sub14)
PRE(mclb_sub14):
TYPE(mclb_sub14)
mov (%rsi), %rax
sub (%rdx), %rax
mov %rax, (%rdi)
mov 8(%rsi), %rax
sbb 8(%rdx), %rax
mov %rax, 8(%rdi)
mov 16(%rsi), %rax
sbb 16(%rdx), %rax
mov %rax, 16(%rdi)
mov 24(%rsi), %rax
sbb 24(%rdx), %rax
mov %rax, 24(%rdi)
mov 32(%rsi), %rax
sbb 32(%rdx), %rax
mov %rax, 32(%rdi)
mov 40(%rsi), %rax
sbb 40(%rdx), %rax
mov %rax, 40(%rdi)
mov 48(%rsi), %rax
sbb 48(%rdx), %rax
mov %rax, 48(%rdi)
mov 56(%rsi), %rax
sbb 56(%rdx), %rax
mov %rax, 56(%rdi)
mov 64(%rsi), %rax
sbb 64(%rdx), %rax
mov %rax, 64(%rdi)
mov 72(%rsi), %rax
sbb 72(%rdx), %rax
mov %rax, 72(%rdi)
mov 80(%rsi), %rax
sbb 80(%rdx), %rax
mov %rax, 80(%rdi)
mov 88(%rsi), %rax
sbb 88(%rdx), %rax
mov %rax, 88(%rdi)
mov 96(%rsi), %rax
sbb 96(%rdx), %rax
mov %rax, 96(%rdi)
mov 104(%rsi), %rax
sbb 104(%rdx), %rax
mov %rax, 104(%rdi)
setc %al
movzx %al, %eax
ret
SIZE(mclb_sub14)
.balign 16
.global PRE(mclb_sub15)
PRE(mclb_sub15):
TYPE(mclb_sub15)
mov (%rsi), %rax
sub (%rdx), %rax
mov %rax, (%rdi)
mov 8(%rsi), %rax
sbb 8(%rdx), %rax
mov %rax, 8(%rdi)
mov 16(%rsi), %rax
sbb 16(%rdx), %rax
mov %rax, 16(%rdi)
mov 24(%rsi), %rax
sbb 24(%rdx), %rax
mov %rax, 24(%rdi)
mov 32(%rsi), %rax
sbb 32(%rdx), %rax
mov %rax, 32(%rdi)
mov 40(%rsi), %rax
sbb 40(%rdx), %rax
mov %rax, 40(%rdi)
mov 48(%rsi), %rax
sbb 48(%rdx), %rax
mov %rax, 48(%rdi)
mov 56(%rsi), %rax
sbb 56(%rdx), %rax
mov %rax, 56(%rdi)
mov 64(%rsi), %rax
sbb 64(%rdx), %rax
mov %rax, 64(%rdi)
mov 72(%rsi), %rax
sbb 72(%rdx), %rax
mov %rax, 72(%rdi)
mov 80(%rsi), %rax
sbb 80(%rdx), %rax
mov %rax, 80(%rdi)
mov 88(%rsi), %rax
sbb 88(%rdx), %rax
mov %rax, 88(%rdi)
mov 96(%rsi), %rax
sbb 96(%rdx), %rax
mov %rax, 96(%rdi)
mov 104(%rsi), %rax
sbb 104(%rdx), %rax
mov %rax, 104(%rdi)
mov 112(%rsi), %rax
sbb 112(%rdx), %rax
mov %rax, 112(%rdi)
setc %al
movzx %al, %eax
ret
SIZE(mclb_sub15)
.balign 16
.global PRE(mclb_sub16)
PRE(mclb_sub16):
TYPE(mclb_sub16)
mov (%rsi), %rax
sub (%rdx), %rax
mov %rax, (%rdi)
mov 8(%rsi), %rax
sbb 8(%rdx), %rax
mov %rax, 8(%rdi)
mov 16(%rsi), %rax
sbb 16(%rdx), %rax
mov %rax, 16(%rdi)
mov 24(%rsi), %rax
sbb 24(%rdx), %rax
mov %rax, 24(%rdi)
mov 32(%rsi), %rax
sbb 32(%rdx), %rax
mov %rax, 32(%rdi)
mov 40(%rsi), %rax
sbb 40(%rdx), %rax
mov %rax, 40(%rdi)
mov 48(%rsi), %rax
sbb 48(%rdx), %rax
mov %rax, 48(%rdi)
mov 56(%rsi), %rax
sbb 56(%rdx), %rax
mov %rax, 56(%rdi)
mov 64(%rsi), %rax
sbb 64(%rdx), %rax
mov %rax, 64(%rdi)
mov 72(%rsi), %rax
sbb 72(%rdx), %rax
mov %rax, 72(%rdi)
mov 80(%rsi), %rax
sbb 80(%rdx), %rax
mov %rax, 80(%rdi)
mov 88(%rsi), %rax
sbb 88(%rdx), %rax
mov %rax, 88(%rdi)
mov 96(%rsi), %rax
sbb 96(%rdx), %rax
mov %rax, 96(%rdi)
mov 104(%rsi), %rax
sbb 104(%rdx), %rax
mov %rax, 104(%rdi)
mov 112(%rsi), %rax
sbb 112(%rdx), %rax
mov %rax, 112(%rdi)
mov 120(%rsi), %rax
sbb 120(%rdx), %rax
mov %rax, 120(%rdi)
setc %al
movzx %al, %eax
ret
SIZE(mclb_sub16)
.balign 16
.global PRE(mclb_addNF1)
PRE(mclb_addNF1):
TYPE(mclb_addNF1)
mov (%rsi), %rax
add (%rdx), %rax
mov %rax, (%rdi)
ret
SIZE(mclb_addNF1)
.balign 16
.global PRE(mclb_addNF2)
PRE(mclb_addNF2):
TYPE(mclb_addNF2)
mov (%rsi), %rax
add (%rdx), %rax
mov %rax, (%rdi)
mov 8(%rsi), %rax
adc 8(%rdx), %rax
mov %rax, 8(%rdi)
ret
SIZE(mclb_addNF2)
.balign 16
.global PRE(mclb_addNF3)
PRE(mclb_addNF3):
TYPE(mclb_addNF3)
mov (%rsi), %rax
add (%rdx), %rax
mov %rax, (%rdi)
mov 8(%rsi), %rax
adc 8(%rdx), %rax
mov %rax, 8(%rdi)
mov 16(%rsi), %rax
adc 16(%rdx), %rax
mov %rax, 16(%rdi)
ret
SIZE(mclb_addNF3)
.balign 16
.global PRE(mclb_addNF4)
PRE(mclb_addNF4):
TYPE(mclb_addNF4)
mov (%rsi), %rax
add (%rdx), %rax
mov %rax, (%rdi)
mov 8(%rsi), %rax
adc 8(%rdx), %rax
mov %rax, 8(%rdi)
mov 16(%rsi), %rax
adc 16(%rdx), %rax
mov %rax, 16(%rdi)
mov 24(%rsi), %rax
adc 24(%rdx), %rax
mov %rax, 24(%rdi)
ret
SIZE(mclb_addNF4)
.balign 16
.global PRE(mclb_addNF5)
PRE(mclb_addNF5):
TYPE(mclb_addNF5)
mov (%rsi), %rax
add (%rdx), %rax
mov %rax, (%rdi)
mov 8(%rsi), %rax
adc 8(%rdx), %rax
mov %rax, 8(%rdi)
mov 16(%rsi), %rax
adc 16(%rdx), %rax
mov %rax, 16(%rdi)
mov 24(%rsi), %rax
adc 24(%rdx), %rax
mov %rax, 24(%rdi)
mov 32(%rsi), %rax
adc 32(%rdx), %rax
mov %rax, 32(%rdi)
ret
SIZE(mclb_addNF5)
.balign 16
.global PRE(mclb_addNF6)
PRE(mclb_addNF6):
TYPE(mclb_addNF6)
mov (%rsi), %rax
add (%rdx), %rax
mov %rax, (%rdi)
mov 8(%rsi), %rax
adc 8(%rdx), %rax
mov %rax, 8(%rdi)
mov 16(%rsi), %rax
adc 16(%rdx), %rax
mov %rax, 16(%rdi)
mov 24(%rsi), %rax
adc 24(%rdx), %rax
mov %rax, 24(%rdi)
mov 32(%rsi), %rax
adc 32(%rdx), %rax
mov %rax, 32(%rdi)
mov 40(%rsi), %rax
adc 40(%rdx), %rax
mov %rax, 40(%rdi)
ret
SIZE(mclb_addNF6)
.balign 16
.global PRE(mclb_addNF7)
PRE(mclb_addNF7):
TYPE(mclb_addNF7)
mov (%rsi), %rax
add (%rdx), %rax
mov %rax, (%rdi)
mov 8(%rsi), %rax
adc 8(%rdx), %rax
mov %rax, 8(%rdi)
mov 16(%rsi), %rax
adc 16(%rdx), %rax
mov %rax, 16(%rdi)
mov 24(%rsi), %rax
adc 24(%rdx), %rax
mov %rax, 24(%rdi)
mov 32(%rsi), %rax
adc 32(%rdx), %rax
mov %rax, 32(%rdi)
mov 40(%rsi), %rax
adc 40(%rdx), %rax
mov %rax, 40(%rdi)
mov 48(%rsi), %rax
adc 48(%rdx), %rax
mov %rax, 48(%rdi)
ret
SIZE(mclb_addNF7)
.balign 16
.global PRE(mclb_addNF8)
PRE(mclb_addNF8):
TYPE(mclb_addNF8)
mov (%rsi), %rax
add (%rdx), %rax
mov %rax, (%rdi)
mov 8(%rsi), %rax
adc 8(%rdx), %rax
mov %rax, 8(%rdi)
mov 16(%rsi), %rax
adc 16(%rdx), %rax
mov %rax, 16(%rdi)
mov 24(%rsi), %rax
adc 24(%rdx), %rax
mov %rax, 24(%rdi)
mov 32(%rsi), %rax
adc 32(%rdx), %rax
mov %rax, 32(%rdi)
mov 40(%rsi), %rax
adc 40(%rdx), %rax
mov %rax, 40(%rdi)
mov 48(%rsi), %rax
adc 48(%rdx), %rax
mov %rax, 48(%rdi)
mov 56(%rsi), %rax
adc 56(%rdx), %rax
mov %rax, 56(%rdi)
ret
SIZE(mclb_addNF8)
.balign 16
.global PRE(mclb_addNF9)
PRE(mclb_addNF9):
TYPE(mclb_addNF9)
mov (%rsi), %rax
add (%rdx), %rax
mov %rax, (%rdi)
mov 8(%rsi), %rax
adc 8(%rdx), %rax
mov %rax, 8(%rdi)
mov 16(%rsi), %rax
adc 16(%rdx), %rax
mov %rax, 16(%rdi)
mov 24(%rsi), %rax
adc 24(%rdx), %rax
mov %rax, 24(%rdi)
mov 32(%rsi), %rax
adc 32(%rdx), %rax
mov %rax, 32(%rdi)
mov 40(%rsi), %rax
adc 40(%rdx), %rax
mov %rax, 40(%rdi)
mov 48(%rsi), %rax
adc 48(%rdx), %rax
mov %rax, 48(%rdi)
mov 56(%rsi), %rax
adc 56(%rdx), %rax
mov %rax, 56(%rdi)
mov 64(%rsi), %rax
adc 64(%rdx), %rax
mov %rax, 64(%rdi)
ret
SIZE(mclb_addNF9)
.balign 16
.global PRE(mclb_addNF10)
PRE(mclb_addNF10):
TYPE(mclb_addNF10)
mov (%rsi), %rax
add (%rdx), %rax
mov %rax, (%rdi)
mov 8(%rsi), %rax
adc 8(%rdx), %rax
mov %rax, 8(%rdi)
mov 16(%rsi), %rax
adc 16(%rdx), %rax
mov %rax, 16(%rdi)
mov 24(%rsi), %rax
adc 24(%rdx), %rax
mov %rax, 24(%rdi)
mov 32(%rsi), %rax
adc 32(%rdx), %rax
mov %rax, 32(%rdi)
mov 40(%rsi), %rax
adc 40(%rdx), %rax
mov %rax, 40(%rdi)
mov 48(%rsi), %rax
adc 48(%rdx), %rax
mov %rax, 48(%rdi)
mov 56(%rsi), %rax
adc 56(%rdx), %rax
mov %rax, 56(%rdi)
mov 64(%rsi), %rax
adc 64(%rdx), %rax
mov %rax, 64(%rdi)
mov 72(%rsi), %rax
adc 72(%rdx), %rax
mov %rax, 72(%rdi)
ret
SIZE(mclb_addNF10)
.balign 16
.global PRE(mclb_addNF11)
PRE(mclb_addNF11):
TYPE(mclb_addNF11)
mov (%rsi), %rax
add (%rdx), %rax
mov %rax, (%rdi)
mov 8(%rsi), %rax
adc 8(%rdx), %rax
mov %rax, 8(%rdi)
mov 16(%rsi), %rax
adc 16(%rdx), %rax
mov %rax, 16(%rdi)
mov 24(%rsi), %rax
adc 24(%rdx), %rax
mov %rax, 24(%rdi)
mov 32(%rsi), %rax
adc 32(%rdx), %rax
mov %rax, 32(%rdi)
mov 40(%rsi), %rax
adc 40(%rdx), %rax
mov %rax, 40(%rdi)
mov 48(%rsi), %rax
adc 48(%rdx), %rax
mov %rax, 48(%rdi)
mov 56(%rsi), %rax
adc 56(%rdx), %rax
mov %rax, 56(%rdi)
mov 64(%rsi), %rax
adc 64(%rdx), %rax
mov %rax, 64(%rdi)
mov 72(%rsi), %rax
adc 72(%rdx), %rax
mov %rax, 72(%rdi)
mov 80(%rsi), %rax
adc 80(%rdx), %rax
mov %rax, 80(%rdi)
ret
SIZE(mclb_addNF11)
.balign 16
.global PRE(mclb_addNF12)
PRE(mclb_addNF12):
TYPE(mclb_addNF12)
mov (%rsi), %rax
add (%rdx), %rax
mov %rax, (%rdi)
mov 8(%rsi), %rax
adc 8(%rdx), %rax
mov %rax, 8(%rdi)
mov 16(%rsi), %rax
adc 16(%rdx), %rax
mov %rax, 16(%rdi)
mov 24(%rsi), %rax
adc 24(%rdx), %rax
mov %rax, 24(%rdi)
mov 32(%rsi), %rax
adc 32(%rdx), %rax
mov %rax, 32(%rdi)
mov 40(%rsi), %rax
adc 40(%rdx), %rax
mov %rax, 40(%rdi)
mov 48(%rsi), %rax
adc 48(%rdx), %rax
mov %rax, 48(%rdi)
mov 56(%rsi), %rax
adc 56(%rdx), %rax
mov %rax, 56(%rdi)
mov 64(%rsi), %rax
adc 64(%rdx), %rax
mov %rax, 64(%rdi)
mov 72(%rsi), %rax
adc 72(%rdx), %rax
mov %rax, 72(%rdi)
mov 80(%rsi), %rax
adc 80(%rdx), %rax
mov %rax, 80(%rdi)
mov 88(%rsi), %rax
adc 88(%rdx), %rax
mov %rax, 88(%rdi)
ret
SIZE(mclb_addNF12)
.balign 16
.global PRE(mclb_addNF13)
PRE(mclb_addNF13):
TYPE(mclb_addNF13)
mov (%rsi), %rax
add (%rdx), %rax
mov %rax, (%rdi)
mov 8(%rsi), %rax
adc 8(%rdx), %rax
mov %rax, 8(%rdi)
mov 16(%rsi), %rax
adc 16(%rdx), %rax
mov %rax, 16(%rdi)
mov 24(%rsi), %rax
adc 24(%rdx), %rax
mov %rax, 24(%rdi)
mov 32(%rsi), %rax
adc 32(%rdx), %rax
mov %rax, 32(%rdi)
mov 40(%rsi), %rax
adc 40(%rdx), %rax
mov %rax, 40(%rdi)
mov 48(%rsi), %rax
adc 48(%rdx), %rax
mov %rax, 48(%rdi)
mov 56(%rsi), %rax
adc 56(%rdx), %rax
mov %rax, 56(%rdi)
mov 64(%rsi), %rax
adc 64(%rdx), %rax
mov %rax, 64(%rdi)
mov 72(%rsi), %rax
adc 72(%rdx), %rax
mov %rax, 72(%rdi)
mov 80(%rsi), %rax
adc 80(%rdx), %rax
mov %rax, 80(%rdi)
mov 88(%rsi), %rax
adc 88(%rdx), %rax
mov %rax, 88(%rdi)
mov 96(%rsi), %rax
adc 96(%rdx), %rax
mov %rax, 96(%rdi)
ret
SIZE(mclb_addNF13)
.balign 16
.global PRE(mclb_addNF14)
PRE(mclb_addNF14):
TYPE(mclb_addNF14)
mov (%rsi), %rax
add (%rdx), %rax
mov %rax, (%rdi)
mov 8(%rsi), %rax
adc 8(%rdx), %rax
mov %rax, 8(%rdi)
mov 16(%rsi), %rax
adc 16(%rdx), %rax
mov %rax, 16(%rdi)
mov 24(%rsi), %rax
adc 24(%rdx), %rax
mov %rax, 24(%rdi)
mov 32(%rsi), %rax
adc 32(%rdx), %rax
mov %rax, 32(%rdi)
mov 40(%rsi), %rax
adc 40(%rdx), %rax
mov %rax, 40(%rdi)
mov 48(%rsi), %rax
adc 48(%rdx), %rax
mov %rax, 48(%rdi)
mov 56(%rsi), %rax
adc 56(%rdx), %rax
mov %rax, 56(%rdi)
mov 64(%rsi), %rax
adc 64(%rdx), %rax
mov %rax, 64(%rdi)
mov 72(%rsi), %rax
adc 72(%rdx), %rax
mov %rax, 72(%rdi)
mov 80(%rsi), %rax
adc 80(%rdx), %rax
mov %rax, 80(%rdi)
mov 88(%rsi), %rax
adc 88(%rdx), %rax
mov %rax, 88(%rdi)
mov 96(%rsi), %rax
adc 96(%rdx), %rax
mov %rax, 96(%rdi)
mov 104(%rsi), %rax
adc 104(%rdx), %rax
mov %rax, 104(%rdi)
ret
SIZE(mclb_addNF14)
.balign 16
.global PRE(mclb_addNF15)
PRE(mclb_addNF15):
TYPE(mclb_addNF15)
mov (%rsi), %rax
add (%rdx), %rax
mov %rax, (%rdi)
mov 8(%rsi), %rax
adc 8(%rdx), %rax
mov %rax, 8(%rdi)
mov 16(%rsi), %rax
adc 16(%rdx), %rax
mov %rax, 16(%rdi)
mov 24(%rsi), %rax
adc 24(%rdx), %rax
mov %rax, 24(%rdi)
mov 32(%rsi), %rax
adc 32(%rdx), %rax
mov %rax, 32(%rdi)
mov 40(%rsi), %rax
adc 40(%rdx), %rax
mov %rax, 40(%rdi)
mov 48(%rsi), %rax
adc 48(%rdx), %rax
mov %rax, 48(%rdi)
mov 56(%rsi), %rax
adc 56(%rdx), %rax
mov %rax, 56(%rdi)
mov 64(%rsi), %rax
adc 64(%rdx), %rax
mov %rax, 64(%rdi)
mov 72(%rsi), %rax
adc 72(%rdx), %rax
mov %rax, 72(%rdi)
mov 80(%rsi), %rax
adc 80(%rdx), %rax
mov %rax, 80(%rdi)
mov 88(%rsi), %rax
adc 88(%rdx), %rax
mov %rax, 88(%rdi)
mov 96(%rsi), %rax
adc 96(%rdx), %rax
mov %rax, 96(%rdi)
mov 104(%rsi), %rax
adc 104(%rdx), %rax
mov %rax, 104(%rdi)
mov 112(%rsi), %rax
adc 112(%rdx), %rax
mov %rax, 112(%rdi)
ret
SIZE(mclb_addNF15)
.balign 16
.global PRE(mclb_addNF16)
PRE(mclb_addNF16):
TYPE(mclb_addNF16)
mov (%rsi), %rax
add (%rdx), %rax
mov %rax, (%rdi)
mov 8(%rsi), %rax
adc 8(%rdx), %rax
mov %rax, 8(%rdi)
mov 16(%rsi), %rax
adc 16(%rdx), %rax
mov %rax, 16(%rdi)
mov 24(%rsi), %rax
adc 24(%rdx), %rax
mov %rax, 24(%rdi)
mov 32(%rsi), %rax
adc 32(%rdx), %rax
mov %rax, 32(%rdi)
mov 40(%rsi), %rax
adc 40(%rdx), %rax
mov %rax, 40(%rdi)
mov 48(%rsi), %rax
adc 48(%rdx), %rax
mov %rax, 48(%rdi)
mov 56(%rsi), %rax
adc 56(%rdx), %rax
mov %rax, 56(%rdi)
mov 64(%rsi), %rax
adc 64(%rdx), %rax
mov %rax, 64(%rdi)
mov 72(%rsi), %rax
adc 72(%rdx), %rax
mov %rax, 72(%rdi)
mov 80(%rsi), %rax
adc 80(%rdx), %rax
mov %rax, 80(%rdi)
mov 88(%rsi), %rax
adc 88(%rdx), %rax
mov %rax, 88(%rdi)
mov 96(%rsi), %rax
adc 96(%rdx), %rax
mov %rax, 96(%rdi)
mov 104(%rsi), %rax
adc 104(%rdx), %rax
mov %rax, 104(%rdi)
mov 112(%rsi), %rax
adc 112(%rdx), %rax
mov %rax, 112(%rdi)
mov 120(%rsi), %rax
adc 120(%rdx), %rax
mov %rax, 120(%rdi)
ret
SIZE(mclb_addNF16)
.balign 16
.global PRE(mclb_subNF1)
PRE(mclb_subNF1):
TYPE(mclb_subNF1)
mov (%rsi), %rax
sub (%rdx), %rax
mov %rax, (%rdi)
setc %al
movzx %al, %eax
ret
SIZE(mclb_subNF1)
.balign 16
.global PRE(mclb_subNF2)
PRE(mclb_subNF2):
TYPE(mclb_subNF2)
mov (%rsi), %rax
sub (%rdx), %rax
mov %rax, (%rdi)
mov 8(%rsi), %rax
sbb 8(%rdx), %rax
mov %rax, 8(%rdi)
setc %al
movzx %al, %eax
ret
SIZE(mclb_subNF2)
.balign 16
.global PRE(mclb_subNF3)
PRE(mclb_subNF3):
TYPE(mclb_subNF3)
mov (%rsi), %rax
sub (%rdx), %rax
mov %rax, (%rdi)
mov 8(%rsi), %rax
sbb 8(%rdx), %rax
mov %rax, 8(%rdi)
mov 16(%rsi), %rax
sbb 16(%rdx), %rax
mov %rax, 16(%rdi)
setc %al
movzx %al, %eax
ret
SIZE(mclb_subNF3)
.balign 16
.global PRE(mclb_subNF4)
PRE(mclb_subNF4):
TYPE(mclb_subNF4)
mov (%rsi), %rax
sub (%rdx), %rax
mov %rax, (%rdi)
mov 8(%rsi), %rax
sbb 8(%rdx), %rax
mov %rax, 8(%rdi)
mov 16(%rsi), %rax
sbb 16(%rdx), %rax
mov %rax, 16(%rdi)
mov 24(%rsi), %rax
sbb 24(%rdx), %rax
mov %rax, 24(%rdi)
setc %al
movzx %al, %eax
ret
SIZE(mclb_subNF4)
.balign 16
.global PRE(mclb_subNF5)
PRE(mclb_subNF5):
TYPE(mclb_subNF5)
mov (%rsi), %rax
sub (%rdx), %rax
mov %rax, (%rdi)
mov 8(%rsi), %rax
sbb 8(%rdx), %rax
mov %rax, 8(%rdi)
mov 16(%rsi), %rax
sbb 16(%rdx), %rax
mov %rax, 16(%rdi)
mov 24(%rsi), %rax
sbb 24(%rdx), %rax
mov %rax, 24(%rdi)
mov 32(%rsi), %rax
sbb 32(%rdx), %rax
mov %rax, 32(%rdi)
setc %al
movzx %al, %eax
ret
SIZE(mclb_subNF5)
.balign 16
.global PRE(mclb_subNF6)
PRE(mclb_subNF6):
TYPE(mclb_subNF6)
mov (%rsi), %rax
sub (%rdx), %rax
mov %rax, (%rdi)
mov 8(%rsi), %rax
sbb 8(%rdx), %rax
mov %rax, 8(%rdi)
mov 16(%rsi), %rax
sbb 16(%rdx), %rax
mov %rax, 16(%rdi)
mov 24(%rsi), %rax
sbb 24(%rdx), %rax
mov %rax, 24(%rdi)
mov 32(%rsi), %rax
sbb 32(%rdx), %rax
mov %rax, 32(%rdi)
mov 40(%rsi), %rax
sbb 40(%rdx), %rax
mov %rax, 40(%rdi)
setc %al
movzx %al, %eax
ret
SIZE(mclb_subNF6)
.balign 16
.global PRE(mclb_subNF7)
PRE(mclb_subNF7):
TYPE(mclb_subNF7)
mov (%rsi), %rax
sub (%rdx), %rax
mov %rax, (%rdi)
mov 8(%rsi), %rax
sbb 8(%rdx), %rax
mov %rax, 8(%rdi)
mov 16(%rsi), %rax
sbb 16(%rdx), %rax
mov %rax, 16(%rdi)
mov 24(%rsi), %rax
sbb 24(%rdx), %rax
mov %rax, 24(%rdi)
mov 32(%rsi), %rax
sbb 32(%rdx), %rax
mov %rax, 32(%rdi)
mov 40(%rsi), %rax
sbb 40(%rdx), %rax
mov %rax, 40(%rdi)
mov 48(%rsi), %rax
sbb 48(%rdx), %rax
mov %rax, 48(%rdi)
setc %al
movzx %al, %eax
ret
SIZE(mclb_subNF7)
.balign 16
.global PRE(mclb_subNF8)
PRE(mclb_subNF8):
TYPE(mclb_subNF8)
mov (%rsi), %rax
sub (%rdx), %rax
mov %rax, (%rdi)
mov 8(%rsi), %rax
sbb 8(%rdx), %rax
mov %rax, 8(%rdi)
mov 16(%rsi), %rax
sbb 16(%rdx), %rax
mov %rax, 16(%rdi)
mov 24(%rsi), %rax
sbb 24(%rdx), %rax
mov %rax, 24(%rdi)
mov 32(%rsi), %rax
sbb 32(%rdx), %rax
mov %rax, 32(%rdi)
mov 40(%rsi), %rax
sbb 40(%rdx), %rax
mov %rax, 40(%rdi)
mov 48(%rsi), %rax
sbb 48(%rdx), %rax
mov %rax, 48(%rdi)
mov 56(%rsi), %rax
sbb 56(%rdx), %rax
mov %rax, 56(%rdi)
setc %al
movzx %al, %eax
ret
SIZE(mclb_subNF8)
.balign 16
.global PRE(mclb_subNF9)
PRE(mclb_subNF9):
TYPE(mclb_subNF9)
mov (%rsi), %rax
sub (%rdx), %rax
mov %rax, (%rdi)
mov 8(%rsi), %rax
sbb 8(%rdx), %rax
mov %rax, 8(%rdi)
mov 16(%rsi), %rax
sbb 16(%rdx), %rax
mov %rax, 16(%rdi)
mov 24(%rsi), %rax
sbb 24(%rdx), %rax
mov %rax, 24(%rdi)
mov 32(%rsi), %rax
sbb 32(%rdx), %rax
mov %rax, 32(%rdi)
mov 40(%rsi), %rax
sbb 40(%rdx), %rax
mov %rax, 40(%rdi)
mov 48(%rsi), %rax
sbb 48(%rdx), %rax
mov %rax, 48(%rdi)
mov 56(%rsi), %rax
sbb 56(%rdx), %rax
mov %rax, 56(%rdi)
mov 64(%rsi), %rax
sbb 64(%rdx), %rax
mov %rax, 64(%rdi)
setc %al
movzx %al, %eax
ret
SIZE(mclb_subNF9)
.balign 16
.global PRE(mclb_subNF10)
PRE(mclb_subNF10):
TYPE(mclb_subNF10)
mov (%rsi), %rax
sub (%rdx), %rax
mov %rax, (%rdi)
mov 8(%rsi), %rax
sbb 8(%rdx), %rax
mov %rax, 8(%rdi)
mov 16(%rsi), %rax
sbb 16(%rdx), %rax
mov %rax, 16(%rdi)
mov 24(%rsi), %rax
sbb 24(%rdx), %rax
mov %rax, 24(%rdi)
mov 32(%rsi), %rax
sbb 32(%rdx), %rax
mov %rax, 32(%rdi)
mov 40(%rsi), %rax
sbb 40(%rdx), %rax
mov %rax, 40(%rdi)
mov 48(%rsi), %rax
sbb 48(%rdx), %rax
mov %rax, 48(%rdi)
mov 56(%rsi), %rax
sbb 56(%rdx), %rax
mov %rax, 56(%rdi)
mov 64(%rsi), %rax
sbb 64(%rdx), %rax
mov %rax, 64(%rdi)
mov 72(%rsi), %rax
sbb 72(%rdx), %rax
mov %rax, 72(%rdi)
setc %al
movzx %al, %eax
ret
SIZE(mclb_subNF10)
.balign 16
.global PRE(mclb_subNF11)
PRE(mclb_subNF11):
TYPE(mclb_subNF11)
mov (%rsi), %rax
sub (%rdx), %rax
mov %rax, (%rdi)
mov 8(%rsi), %rax
sbb 8(%rdx), %rax
mov %rax, 8(%rdi)
mov 16(%rsi), %rax
sbb 16(%rdx), %rax
mov %rax, 16(%rdi)
mov 24(%rsi), %rax
sbb 24(%rdx), %rax
mov %rax, 24(%rdi)
mov 32(%rsi), %rax
sbb 32(%rdx), %rax
mov %rax, 32(%rdi)
mov 40(%rsi), %rax
sbb 40(%rdx), %rax
mov %rax, 40(%rdi)
mov 48(%rsi), %rax
sbb 48(%rdx), %rax
mov %rax, 48(%rdi)
mov 56(%rsi), %rax
sbb 56(%rdx), %rax
mov %rax, 56(%rdi)
mov 64(%rsi), %rax
sbb 64(%rdx), %rax
mov %rax, 64(%rdi)
mov 72(%rsi), %rax
sbb 72(%rdx), %rax
mov %rax, 72(%rdi)
mov 80(%rsi), %rax
sbb 80(%rdx), %rax
mov %rax, 80(%rdi)
setc %al
movzx %al, %eax
ret
SIZE(mclb_subNF11)
.balign 16
.global PRE(mclb_subNF12)
PRE(mclb_subNF12):
TYPE(mclb_subNF12)
mov (%rsi), %rax
sub (%rdx), %rax
mov %rax, (%rdi)
mov 8(%rsi), %rax
sbb 8(%rdx), %rax
mov %rax, 8(%rdi)
mov 16(%rsi), %rax
sbb 16(%rdx), %rax
mov %rax, 16(%rdi)
mov 24(%rsi), %rax
sbb 24(%rdx), %rax
mov %rax, 24(%rdi)
mov 32(%rsi), %rax
sbb 32(%rdx), %rax
mov %rax, 32(%rdi)
mov 40(%rsi), %rax
sbb 40(%rdx), %rax
mov %rax, 40(%rdi)
mov 48(%rsi), %rax
sbb 48(%rdx), %rax
mov %rax, 48(%rdi)
mov 56(%rsi), %rax
sbb 56(%rdx), %rax
mov %rax, 56(%rdi)
mov 64(%rsi), %rax
sbb 64(%rdx), %rax
mov %rax, 64(%rdi)
mov 72(%rsi), %rax
sbb 72(%rdx), %rax
mov %rax, 72(%rdi)
mov 80(%rsi), %rax
sbb 80(%rdx), %rax
mov %rax, 80(%rdi)
mov 88(%rsi), %rax
sbb 88(%rdx), %rax
mov %rax, 88(%rdi)
setc %al
movzx %al, %eax
ret
SIZE(mclb_subNF12)
.balign 16
.global PRE(mclb_subNF13)
PRE(mclb_subNF13):
TYPE(mclb_subNF13)
mov (%rsi), %rax
sub (%rdx), %rax
mov %rax, (%rdi)
mov 8(%rsi), %rax
sbb 8(%rdx), %rax
mov %rax, 8(%rdi)
mov 16(%rsi), %rax
sbb 16(%rdx), %rax
mov %rax, 16(%rdi)
mov 24(%rsi), %rax
sbb 24(%rdx), %rax
mov %rax, 24(%rdi)
mov 32(%rsi), %rax
sbb 32(%rdx), %rax
mov %rax, 32(%rdi)
mov 40(%rsi), %rax
sbb 40(%rdx), %rax
mov %rax, 40(%rdi)
mov 48(%rsi), %rax
sbb 48(%rdx), %rax
mov %rax, 48(%rdi)
mov 56(%rsi), %rax
sbb 56(%rdx), %rax
mov %rax, 56(%rdi)
mov 64(%rsi), %rax
sbb 64(%rdx), %rax
mov %rax, 64(%rdi)
mov 72(%rsi), %rax
sbb 72(%rdx), %rax
mov %rax, 72(%rdi)
mov 80(%rsi), %rax
sbb 80(%rdx), %rax
mov %rax, 80(%rdi)
mov 88(%rsi), %rax
sbb 88(%rdx), %rax
mov %rax, 88(%rdi)
mov 96(%rsi), %rax
sbb 96(%rdx), %rax
mov %rax, 96(%rdi)
setc %al
movzx %al, %eax
ret
SIZE(mclb_subNF13)
.balign 16
.global PRE(mclb_subNF14)
PRE(mclb_subNF14):
TYPE(mclb_subNF14)
mov (%rsi), %rax
sub (%rdx), %rax
mov %rax, (%rdi)
mov 8(%rsi), %rax
sbb 8(%rdx), %rax
mov %rax, 8(%rdi)
mov 16(%rsi), %rax
sbb 16(%rdx), %rax
mov %rax, 16(%rdi)
mov 24(%rsi), %rax
sbb 24(%rdx), %rax
mov %rax, 24(%rdi)
mov 32(%rsi), %rax
sbb 32(%rdx), %rax
mov %rax, 32(%rdi)
mov 40(%rsi), %rax
sbb 40(%rdx), %rax
mov %rax, 40(%rdi)
mov 48(%rsi), %rax
sbb 48(%rdx), %rax
mov %rax, 48(%rdi)
mov 56(%rsi), %rax
sbb 56(%rdx), %rax
mov %rax, 56(%rdi)
mov 64(%rsi), %rax
sbb 64(%rdx), %rax
mov %rax, 64(%rdi)
mov 72(%rsi), %rax
sbb 72(%rdx), %rax
mov %rax, 72(%rdi)
mov 80(%rsi), %rax
sbb 80(%rdx), %rax
mov %rax, 80(%rdi)
mov 88(%rsi), %rax
sbb 88(%rdx), %rax
mov %rax, 88(%rdi)
mov 96(%rsi), %rax
sbb 96(%rdx), %rax
mov %rax, 96(%rdi)
mov 104(%rsi), %rax
sbb 104(%rdx), %rax
mov %rax, 104(%rdi)
setc %al
movzx %al, %eax
ret
SIZE(mclb_subNF14)
.balign 16
.global PRE(mclb_subNF15)
PRE(mclb_subNF15):
TYPE(mclb_subNF15)
mov (%rsi), %rax
sub (%rdx), %rax
mov %rax, (%rdi)
mov 8(%rsi), %rax
sbb 8(%rdx), %rax
mov %rax, 8(%rdi)
mov 16(%rsi), %rax
sbb 16(%rdx), %rax
mov %rax, 16(%rdi)
mov 24(%rsi), %rax
sbb 24(%rdx), %rax
mov %rax, 24(%rdi)
mov 32(%rsi), %rax
sbb 32(%rdx), %rax
mov %rax, 32(%rdi)
mov 40(%rsi), %rax
sbb 40(%rdx), %rax
mov %rax, 40(%rdi)
mov 48(%rsi), %rax
sbb 48(%rdx), %rax
mov %rax, 48(%rdi)
mov 56(%rsi), %rax
sbb 56(%rdx), %rax
mov %rax, 56(%rdi)
mov 64(%rsi), %rax
sbb 64(%rdx), %rax
mov %rax, 64(%rdi)
mov 72(%rsi), %rax
sbb 72(%rdx), %rax
mov %rax, 72(%rdi)
mov 80(%rsi), %rax
sbb 80(%rdx), %rax
mov %rax, 80(%rdi)
mov 88(%rsi), %rax
sbb 88(%rdx), %rax
mov %rax, 88(%rdi)
mov 96(%rsi), %rax
sbb 96(%rdx), %rax
mov %rax, 96(%rdi)
mov 104(%rsi), %rax
sbb 104(%rdx), %rax
mov %rax, 104(%rdi)
mov 112(%rsi), %rax
sbb 112(%rdx), %rax
mov %rax, 112(%rdi)
setc %al
movzx %al, %eax
ret
SIZE(mclb_subNF15)
.balign 16
.global PRE(mclb_subNF16)
PRE(mclb_subNF16):
TYPE(mclb_subNF16)
mov (%rsi), %rax
sub (%rdx), %rax
mov %rax, (%rdi)
mov 8(%rsi), %rax
sbb 8(%rdx), %rax
mov %rax, 8(%rdi)
mov 16(%rsi), %rax
sbb 16(%rdx), %rax
mov %rax, 16(%rdi)
mov 24(%rsi), %rax
sbb 24(%rdx), %rax
mov %rax, 24(%rdi)
mov 32(%rsi), %rax
sbb 32(%rdx), %rax
mov %rax, 32(%rdi)
mov 40(%rsi), %rax
sbb 40(%rdx), %rax
mov %rax, 40(%rdi)
mov 48(%rsi), %rax
sbb 48(%rdx), %rax
mov %rax, 48(%rdi)
mov 56(%rsi), %rax
sbb 56(%rdx), %rax
mov %rax, 56(%rdi)
mov 64(%rsi), %rax
sbb 64(%rdx), %rax
mov %rax, 64(%rdi)
mov 72(%rsi), %rax
sbb 72(%rdx), %rax
mov %rax, 72(%rdi)
mov 80(%rsi), %rax
sbb 80(%rdx), %rax
mov %rax, 80(%rdi)
mov 88(%rsi), %rax
sbb 88(%rdx), %rax
mov %rax, 88(%rdi)
mov 96(%rsi), %rax
sbb 96(%rdx), %rax
mov %rax, 96(%rdi)
mov 104(%rsi), %rax
sbb 104(%rdx), %rax
mov %rax, 104(%rdi)
mov 112(%rsi), %rax
sbb 112(%rdx), %rax
mov %rax, 112(%rdi)
mov 120(%rsi), %rax
sbb 120(%rdx), %rax
mov %rax, 120(%rdi)
setc %al
movzx %al, %eax
ret
SIZE(mclb_subNF16)
.balign 16
.global PRE(mclb_mulUnit_fast1)
PRE(mclb_mulUnit_fast1):
TYPE(mclb_mulUnit_fast1)
mov (%rsi), %rax
mul %rdx
mov %rax, (%rdi)
mov %rdx, %rax
ret
SIZE(mclb_mulUnit_fast1)
.balign 16
.global PRE(mclb_mulUnit_fast2)
PRE(mclb_mulUnit_fast2):
TYPE(mclb_mulUnit_fast2)
mov %rdx, %r11
mov (%rsi), %rax
mul %r11
mov %rax, (%rdi)
mov %rdx, %rcx
mov 8(%rsi), %rax
mul %r11
add %rcx, %rax
adc $0, %rdx
mov %rax, 8(%rdi)
mov %rdx, %rax
ret
SIZE(mclb_mulUnit_fast2)
.balign 16
.global PRE(mclb_mulUnit_fast3)
PRE(mclb_mulUnit_fast3):
TYPE(mclb_mulUnit_fast3)
mulx (%rsi), %rax, %r8
mov %rax, (%rdi)
mulx 8(%rsi), %rax, %rcx
add %r8, %rax
mov %rax, 8(%rdi)
mulx 16(%rsi), %rdx, %rax
adc %rcx, %rdx
mov %rdx, 16(%rdi)
adc $0, %rax
ret
SIZE(mclb_mulUnit_fast3)
.balign 16
.global PRE(mclb_mulUnit_fast4)
PRE(mclb_mulUnit_fast4):
TYPE(mclb_mulUnit_fast4)
mulx (%rsi), %rax, %r8
mov %rax, (%rdi)
mulx 8(%rsi), %rax, %rcx
add %r8, %rax
mov %rax, 8(%rdi)
mulx 16(%rsi), %rax, %r8
adc %rcx, %rax
mov %rax, 16(%rdi)
mulx 24(%rsi), %rdx, %rax
adc %r8, %rdx
mov %rdx, 24(%rdi)
adc $0, %rax
ret
SIZE(mclb_mulUnit_fast4)
.balign 16
.global PRE(mclb_mulUnit_fast5)
PRE(mclb_mulUnit_fast5):
TYPE(mclb_mulUnit_fast5)
mulx (%rsi), %rax, %r8
mov %rax, (%rdi)
mulx 8(%rsi), %rax, %rcx
add %r8, %rax
mov %rax, 8(%rdi)
mulx 16(%rsi), %rax, %r8
adc %rcx, %rax
mov %rax, 16(%rdi)
mulx 24(%rsi), %rax, %rcx
adc %r8, %rax
mov %rax, 24(%rdi)
mulx 32(%rsi), %rdx, %rax
adc %rcx, %rdx
mov %rdx, 32(%rdi)
adc $0, %rax
ret
SIZE(mclb_mulUnit_fast5)
.balign 16
.global PRE(mclb_mulUnit_fast6)
PRE(mclb_mulUnit_fast6):
TYPE(mclb_mulUnit_fast6)
mulx (%rsi), %rax, %r8
mov %rax, (%rdi)
mulx 8(%rsi), %rax, %rcx
add %r8, %rax
mov %rax, 8(%rdi)
mulx 16(%rsi), %rax, %r8
adc %rcx, %rax
mov %rax, 16(%rdi)
mulx 24(%rsi), %rax, %rcx
adc %r8, %rax
mov %rax, 24(%rdi)
mulx 32(%rsi), %rax, %r8
adc %rcx, %rax
mov %rax, 32(%rdi)
mulx 40(%rsi), %rdx, %rax
adc %r8, %rdx
mov %rdx, 40(%rdi)
adc $0, %rax
ret
SIZE(mclb_mulUnit_fast6)
.balign 16
.global PRE(mclb_mulUnit_fast7)
PRE(mclb_mulUnit_fast7):
TYPE(mclb_mulUnit_fast7)
mulx (%rsi), %rax, %r8
mov %rax, (%rdi)
mulx 8(%rsi), %rax, %rcx
add %r8, %rax
mov %rax, 8(%rdi)
mulx 16(%rsi), %rax, %r8
adc %rcx, %rax
mov %rax, 16(%rdi)
mulx 24(%rsi), %rax, %rcx
adc %r8, %rax
mov %rax, 24(%rdi)
mulx 32(%rsi), %rax, %r8
adc %rcx, %rax
mov %rax, 32(%rdi)
mulx 40(%rsi), %rax, %rcx
adc %r8, %rax
mov %rax, 40(%rdi)
mulx 48(%rsi), %rdx, %rax
adc %rcx, %rdx
mov %rdx, 48(%rdi)
adc $0, %rax
ret
SIZE(mclb_mulUnit_fast7)
.balign 16
.global PRE(mclb_mulUnit_fast8)
PRE(mclb_mulUnit_fast8):
TYPE(mclb_mulUnit_fast8)
mulx (%rsi), %rax, %r8
mov %rax, (%rdi)
mulx 8(%rsi), %rax, %rcx
add %r8, %rax
mov %rax, 8(%rdi)
mulx 16(%rsi), %rax, %r8
adc %rcx, %rax
mov %rax, 16(%rdi)
mulx 24(%rsi), %rax, %rcx
adc %r8, %rax
mov %rax, 24(%rdi)
mulx 32(%rsi), %rax, %r8
adc %rcx, %rax
mov %rax, 32(%rdi)
mulx 40(%rsi), %rax, %rcx
adc %r8, %rax
mov %rax, 40(%rdi)
mulx 48(%rsi), %rax, %r8
adc %rcx, %rax
mov %rax, 48(%rdi)
mulx 56(%rsi), %rdx, %rax
adc %r8, %rdx
mov %rdx, 56(%rdi)
adc $0, %rax
ret
SIZE(mclb_mulUnit_fast8)
.balign 16
.global PRE(mclb_mulUnit_fast9)
PRE(mclb_mulUnit_fast9):
TYPE(mclb_mulUnit_fast9)
mulx (%rsi), %rax, %r8
mov %rax, (%rdi)
mulx 8(%rsi), %rax, %rcx
add %r8, %rax
mov %rax, 8(%rdi)
mulx 16(%rsi), %rax, %r8
adc %rcx, %rax
mov %rax, 16(%rdi)
mulx 24(%rsi), %rax, %rcx
adc %r8, %rax
mov %rax, 24(%rdi)
mulx 32(%rsi), %rax, %r8
adc %rcx, %rax
mov %rax, 32(%rdi)
mulx 40(%rsi), %rax, %rcx
adc %r8, %rax
mov %rax, 40(%rdi)
mulx 48(%rsi), %rax, %r8
adc %rcx, %rax
mov %rax, 48(%rdi)
mulx 56(%rsi), %rax, %rcx
adc %r8, %rax
mov %rax, 56(%rdi)
mulx 64(%rsi), %rdx, %rax
adc %rcx, %rdx
mov %rdx, 64(%rdi)
adc $0, %rax
ret
SIZE(mclb_mulUnit_fast9)
.balign 16
.global PRE(mclb_mulUnitAdd_fast1)
PRE(mclb_mulUnitAdd_fast1):
TYPE(mclb_mulUnitAdd_fast1)
xor %eax, %eax
mov (%rdi), %rcx
mulx (%rsi), %r8, %rax
adox %r8, %rcx
mov %rcx, (%rdi)
mov $0, %rcx
adcx %rcx, %rax
adox %rcx, %rax
ret
SIZE(mclb_mulUnitAdd_fast1)
.balign 16
.global PRE(mclb_mulUnitAdd_fast2)
PRE(mclb_mulUnitAdd_fast2):
TYPE(mclb_mulUnitAdd_fast2)
xor %eax, %eax
mov (%rdi), %rcx
mulx (%rsi), %r8, %rax
adox %r8, %rcx
mov %rcx, (%rdi)
mov 8(%rdi), %rcx
adcx %rax, %rcx
mulx 8(%rsi), %r8, %rax
adox %r8, %rcx
mov %rcx, 8(%rdi)
mov $0, %rcx
adcx %rcx, %rax
adox %rcx, %rax
ret
SIZE(mclb_mulUnitAdd_fast2)
.balign 16
.global PRE(mclb_mulUnitAdd_fast3)
PRE(mclb_mulUnitAdd_fast3):
TYPE(mclb_mulUnitAdd_fast3)
xor %eax, %eax
mov (%rdi), %rcx
mulx (%rsi), %r8, %rax
adox %r8, %rcx
mov %rcx, (%rdi)
mov 8(%rdi), %rcx
adcx %rax, %rcx
mulx 8(%rsi), %r8, %rax
adox %r8, %rcx
mov %rcx, 8(%rdi)
mov 16(%rdi), %rcx
adcx %rax, %rcx
mulx 16(%rsi), %r8, %rax
adox %r8, %rcx
mov %rcx, 16(%rdi)
mov $0, %rcx
adcx %rcx, %rax
adox %rcx, %rax
ret
SIZE(mclb_mulUnitAdd_fast3)
.balign 16
.global PRE(mclb_mulUnitAdd_fast4)
PRE(mclb_mulUnitAdd_fast4):
TYPE(mclb_mulUnitAdd_fast4)
xor %eax, %eax
mov (%rdi), %rcx
mulx (%rsi), %r8, %rax
adox %r8, %rcx
mov %rcx, (%rdi)
mov 8(%rdi), %rcx
adcx %rax, %rcx
mulx 8(%rsi), %r8, %rax
adox %r8, %rcx
mov %rcx, 8(%rdi)
mov 16(%rdi), %rcx
adcx %rax, %rcx
mulx 16(%rsi), %r8, %rax
adox %r8, %rcx
mov %rcx, 16(%rdi)
mov 24(%rdi), %rcx
adcx %rax, %rcx
mulx 24(%rsi), %r8, %rax
adox %r8, %rcx
mov %rcx, 24(%rdi)
mov $0, %rcx
adcx %rcx, %rax
adox %rcx, %rax
ret
SIZE(mclb_mulUnitAdd_fast4)
.balign 16
.global PRE(mclb_mulUnitAdd_fast5)
PRE(mclb_mulUnitAdd_fast5):
TYPE(mclb_mulUnitAdd_fast5)
xor %eax, %eax
mov (%rdi), %rcx
mulx (%rsi), %r8, %rax
adox %r8, %rcx
mov %rcx, (%rdi)
mov 8(%rdi), %rcx
adcx %rax, %rcx
mulx 8(%rsi), %r8, %rax
adox %r8, %rcx
mov %rcx, 8(%rdi)
mov 16(%rdi), %rcx
adcx %rax, %rcx
mulx 16(%rsi), %r8, %rax
adox %r8, %rcx
mov %rcx, 16(%rdi)
mov 24(%rdi), %rcx
adcx %rax, %rcx
mulx 24(%rsi), %r8, %rax
adox %r8, %rcx
mov %rcx, 24(%rdi)
mov 32(%rdi), %rcx
adcx %rax, %rcx
mulx 32(%rsi), %r8, %rax
adox %r8, %rcx
mov %rcx, 32(%rdi)
mov $0, %rcx
adcx %rcx, %rax
adox %rcx, %rax
ret
SIZE(mclb_mulUnitAdd_fast5)
.balign 16
.global PRE(mclb_mulUnitAdd_fast6)
PRE(mclb_mulUnitAdd_fast6):
TYPE(mclb_mulUnitAdd_fast6)
xor %eax, %eax
mov (%rdi), %rcx
mulx (%rsi), %r8, %rax
adox %r8, %rcx
mov %rcx, (%rdi)
mov 8(%rdi), %rcx
adcx %rax, %rcx
mulx 8(%rsi), %r8, %rax
adox %r8, %rcx
mov %rcx, 8(%rdi)
mov 16(%rdi), %rcx
adcx %rax, %rcx
mulx 16(%rsi), %r8, %rax
adox %r8, %rcx
mov %rcx, 16(%rdi)
mov 24(%rdi), %rcx
adcx %rax, %rcx
mulx 24(%rsi), %r8, %rax
adox %r8, %rcx
mov %rcx, 24(%rdi)
mov 32(%rdi), %rcx
adcx %rax, %rcx
mulx 32(%rsi), %r8, %rax
adox %r8, %rcx
mov %rcx, 32(%rdi)
mov 40(%rdi), %rcx
adcx %rax, %rcx
mulx 40(%rsi), %r8, %rax
adox %r8, %rcx
mov %rcx, 40(%rdi)
mov $0, %rcx
adcx %rcx, %rax
adox %rcx, %rax
ret
SIZE(mclb_mulUnitAdd_fast6)
.balign 16
.global PRE(mclb_mulUnitAdd_fast7)
PRE(mclb_mulUnitAdd_fast7):
TYPE(mclb_mulUnitAdd_fast7)
xor %eax, %eax
mov (%rdi), %rcx
mulx (%rsi), %r8, %rax
adox %r8, %rcx
mov %rcx, (%rdi)
mov 8(%rdi), %rcx
adcx %rax, %rcx
mulx 8(%rsi), %r8, %rax
adox %r8, %rcx
mov %rcx, 8(%rdi)
mov 16(%rdi), %rcx
adcx %rax, %rcx
mulx 16(%rsi), %r8, %rax
adox %r8, %rcx
mov %rcx, 16(%rdi)
mov 24(%rdi), %rcx
adcx %rax, %rcx
mulx 24(%rsi), %r8, %rax
adox %r8, %rcx
mov %rcx, 24(%rdi)
mov 32(%rdi), %rcx
adcx %rax, %rcx
mulx 32(%rsi), %r8, %rax
adox %r8, %rcx
mov %rcx, 32(%rdi)
mov 40(%rdi), %rcx
adcx %rax, %rcx
mulx 40(%rsi), %r8, %rax
adox %r8, %rcx
mov %rcx, 40(%rdi)
mov 48(%rdi), %rcx
adcx %rax, %rcx
mulx 48(%rsi), %r8, %rax
adox %r8, %rcx
mov %rcx, 48(%rdi)
mov $0, %rcx
adcx %rcx, %rax
adox %rcx, %rax
ret
SIZE(mclb_mulUnitAdd_fast7)
.balign 16
.global PRE(mclb_mulUnitAdd_fast8)
PRE(mclb_mulUnitAdd_fast8):
TYPE(mclb_mulUnitAdd_fast8)
xor %eax, %eax
mov (%rdi), %rcx
mulx (%rsi), %r8, %rax
adox %r8, %rcx
mov %rcx, (%rdi)
mov 8(%rdi), %rcx
adcx %rax, %rcx
mulx 8(%rsi), %r8, %rax
adox %r8, %rcx
mov %rcx, 8(%rdi)
mov 16(%rdi), %rcx
adcx %rax, %rcx
mulx 16(%rsi), %r8, %rax
adox %r8, %rcx
mov %rcx, 16(%rdi)
mov 24(%rdi), %rcx
adcx %rax, %rcx
mulx 24(%rsi), %r8, %rax
adox %r8, %rcx
mov %rcx, 24(%rdi)
mov 32(%rdi), %rcx
adcx %rax, %rcx
mulx 32(%rsi), %r8, %rax
adox %r8, %rcx
mov %rcx, 32(%rdi)
mov 40(%rdi), %rcx
adcx %rax, %rcx
mulx 40(%rsi), %r8, %rax
adox %r8, %rcx
mov %rcx, 40(%rdi)
mov 48(%rdi), %rcx
adcx %rax, %rcx
mulx 48(%rsi), %r8, %rax
adox %r8, %rcx
mov %rcx, 48(%rdi)
mov 56(%rdi), %rcx
adcx %rax, %rcx
mulx 56(%rsi), %r8, %rax
adox %r8, %rcx
mov %rcx, 56(%rdi)
mov $0, %rcx
adcx %rcx, %rax
adox %rcx, %rax
ret
SIZE(mclb_mulUnitAdd_fast8)
.balign 16
.global PRE(mclb_mulUnitAdd_fast9)
PRE(mclb_mulUnitAdd_fast9):
TYPE(mclb_mulUnitAdd_fast9)
xor %eax, %eax
mov (%rdi), %rcx
mulx (%rsi), %r8, %rax
adox %r8, %rcx
mov %rcx, (%rdi)
mov 8(%rdi), %rcx
adcx %rax, %rcx
mulx 8(%rsi), %r8, %rax
adox %r8, %rcx
mov %rcx, 8(%rdi)
mov 16(%rdi), %rcx
adcx %rax, %rcx
mulx 16(%rsi), %r8, %rax
adox %r8, %rcx
mov %rcx, 16(%rdi)
mov 24(%rdi), %rcx
adcx %rax, %rcx
mulx 24(%rsi), %r8, %rax
adox %r8, %rcx
mov %rcx, 24(%rdi)
mov 32(%rdi), %rcx
adcx %rax, %rcx
mulx 32(%rsi), %r8, %rax
adox %r8, %rcx
mov %rcx, 32(%rdi)
mov 40(%rdi), %rcx
adcx %rax, %rcx
mulx 40(%rsi), %r8, %rax
adox %r8, %rcx
mov %rcx, 40(%rdi)
mov 48(%rdi), %rcx
adcx %rax, %rcx
mulx 48(%rsi), %r8, %rax
adox %r8, %rcx
mov %rcx, 48(%rdi)
mov 56(%rdi), %rcx
adcx %rax, %rcx
mulx 56(%rsi), %r8, %rax
adox %r8, %rcx
mov %rcx, 56(%rdi)
mov 64(%rdi), %rcx
adcx %rax, %rcx
mulx 64(%rsi), %r8, %rax
adox %r8, %rcx
mov %rcx, 64(%rdi)
mov $0, %rcx
adcx %rcx, %rax
adox %rcx, %rax
ret
SIZE(mclb_mulUnitAdd_fast9)
.balign 16
.global PRE(mclb_mulUnit_slow1)
PRE(mclb_mulUnit_slow1):
TYPE(mclb_mulUnit_slow1)
mov (%rsi), %rax
mul %rdx
mov %rax, (%rdi)
mov %rdx, %rax
ret
SIZE(mclb_mulUnit_slow1)
.balign 16
.global PRE(mclb_mulUnit_slow2)
PRE(mclb_mulUnit_slow2):
TYPE(mclb_mulUnit_slow2)
mov %rdx, %r11
mov (%rsi), %rax
mul %r11
mov %rax, (%rdi)
mov %rdx, %rcx
mov 8(%rsi), %rax
mul %r11
add %rcx, %rax
adc $0, %rdx
mov %rax, 8(%rdi)
mov %rdx, %rax
ret
SIZE(mclb_mulUnit_slow2)
.balign 16
.global PRE(mclb_mulUnit_slow3)
PRE(mclb_mulUnit_slow3):
TYPE(mclb_mulUnit_slow3)
sub $40, %rsp
mov %rdx, %r11
mov (%rsi), %rax
mul %r11
mov %rax, (%rdi)
mov %rdx, 16(%rsp)
mov 8(%rsi), %rax
mul %r11
mov %rax, (%rsp)
mov %rdx, 24(%rsp)
mov 16(%rsi), %rax
mul %r11
mov %rax, 8(%rsp)
mov 16(%rsp), %rax
add (%rsp), %rax
mov %rax, 8(%rdi)
mov 24(%rsp), %rax
adc 8(%rsp), %rax
mov %rax, 16(%rdi)
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
mov (%rsi), %rax
mul %r11
mov %rax, (%rdi)
mov %rdx, 24(%rsp)
mov 8(%rsi), %rax
mul %r11
mov %rax, (%rsp)
mov %rdx, 32(%rsp)
mov 16(%rsi), %rax
mul %r11
mov %rax, 8(%rsp)
mov %rdx, 40(%rsp)
mov 24(%rsi), %rax
mul %r11
mov %rax, 16(%rsp)
mov 24(%rsp), %rax
add (%rsp), %rax
mov %rax, 8(%rdi)
mov 32(%rsp), %rax
adc 8(%rsp), %rax
mov %rax, 16(%rdi)
mov 40(%rsp), %rax
adc 16(%rsp), %rax
mov %rax, 24(%rdi)
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
mov (%rsi), %rax
mul %r11
mov %rax, (%rdi)
mov %rdx, 32(%rsp)
mov 8(%rsi), %rax
mul %r11
mov %rax, (%rsp)
mov %rdx, 40(%rsp)
mov 16(%rsi), %rax
mul %r11
mov %rax, 8(%rsp)
mov %rdx, 48(%rsp)
mov 24(%rsi), %rax
mul %r11
mov %rax, 16(%rsp)
mov %rdx, 56(%rsp)
mov 32(%rsi), %rax
mul %r11
mov %rax, 24(%rsp)
mov 32(%rsp), %rax
add (%rsp), %rax
mov %rax, 8(%rdi)
mov 40(%rsp), %rax
adc 8(%rsp), %rax
mov %rax, 16(%rdi)
mov 48(%rsp), %rax
adc 16(%rsp), %rax
mov %rax, 24(%rdi)
mov 56(%rsp), %rax
adc 24(%rsp), %rax
mov %rax, 32(%rdi)
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
mov (%rsi), %rax
mul %r11
mov %rax, (%rdi)
mov %rdx, 40(%rsp)
mov 8(%rsi), %rax
mul %r11
mov %rax, (%rsp)
mov %rdx, 48(%rsp)
mov 16(%rsi), %rax
mul %r11
mov %rax, 8(%rsp)
mov %rdx, 56(%rsp)
mov 24(%rsi), %rax
mul %r11
mov %rax, 16(%rsp)
mov %rdx, 64(%rsp)
mov 32(%rsi), %rax
mul %r11
mov %rax, 24(%rsp)
mov %rdx, 72(%rsp)
mov 40(%rsi), %rax
mul %r11
mov %rax, 32(%rsp)
mov 40(%rsp), %rax
add (%rsp), %rax
mov %rax, 8(%rdi)
mov 48(%rsp), %rax
adc 8(%rsp), %rax
mov %rax, 16(%rdi)
mov 56(%rsp), %rax
adc 16(%rsp), %rax
mov %rax, 24(%rdi)
mov 64(%rsp), %rax
adc 24(%rsp), %rax
mov %rax, 32(%rdi)
mov 72(%rsp), %rax
adc 32(%rsp), %rax
mov %rax, 40(%rdi)
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
mov (%rsi), %rax
mul %r11
mov %rax, (%rdi)
mov %rdx, 48(%rsp)
mov 8(%rsi), %rax
mul %r11
mov %rax, (%rsp)
mov %rdx, 56(%rsp)
mov 16(%rsi), %rax
mul %r11
mov %rax, 8(%rsp)
mov %rdx, 64(%rsp)
mov 24(%rsi), %rax
mul %r11
mov %rax, 16(%rsp)
mov %rdx, 72(%rsp)
mov 32(%rsi), %rax
mul %r11
mov %rax, 24(%rsp)
mov %rdx, 80(%rsp)
mov 40(%rsi), %rax
mul %r11
mov %rax, 32(%rsp)
mov %rdx, 88(%rsp)
mov 48(%rsi), %rax
mul %r11
mov %rax, 40(%rsp)
mov 48(%rsp), %rax
add (%rsp), %rax
mov %rax, 8(%rdi)
mov 56(%rsp), %rax
adc 8(%rsp), %rax
mov %rax, 16(%rdi)
mov 64(%rsp), %rax
adc 16(%rsp), %rax
mov %rax, 24(%rdi)
mov 72(%rsp), %rax
adc 24(%rsp), %rax
mov %rax, 32(%rdi)
mov 80(%rsp), %rax
adc 32(%rsp), %rax
mov %rax, 40(%rdi)
mov 88(%rsp), %rax
adc 40(%rsp), %rax
mov %rax, 48(%rdi)
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
mov (%rsi), %rax
mul %r11
mov %rax, (%rdi)
mov %rdx, 56(%rsp)
mov 8(%rsi), %rax
mul %r11
mov %rax, (%rsp)
mov %rdx, 64(%rsp)
mov 16(%rsi), %rax
mul %r11
mov %rax, 8(%rsp)
mov %rdx, 72(%rsp)
mov 24(%rsi), %rax
mul %r11
mov %rax, 16(%rsp)
mov %rdx, 80(%rsp)
mov 32(%rsi), %rax
mul %r11
mov %rax, 24(%rsp)
mov %rdx, 88(%rsp)
mov 40(%rsi), %rax
mul %r11
mov %rax, 32(%rsp)
mov %rdx, 96(%rsp)
mov 48(%rsi), %rax
mul %r11
mov %rax, 40(%rsp)
mov %rdx, 104(%rsp)
mov 56(%rsi), %rax
mul %r11
mov %rax, 48(%rsp)
mov 56(%rsp), %rax
add (%rsp), %rax
mov %rax, 8(%rdi)
mov 64(%rsp), %rax
adc 8(%rsp), %rax
mov %rax, 16(%rdi)
mov 72(%rsp), %rax
adc 16(%rsp), %rax
mov %rax, 24(%rdi)
mov 80(%rsp), %rax
adc 24(%rsp), %rax
mov %rax, 32(%rdi)
mov 88(%rsp), %rax
adc 32(%rsp), %rax
mov %rax, 40(%rdi)
mov 96(%rsp), %rax
adc 40(%rsp), %rax
mov %rax, 48(%rdi)
mov 104(%rsp), %rax
adc 48(%rsp), %rax
mov %rax, 56(%rdi)
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
mov (%rsi), %rax
mul %r11
mov %rax, (%rdi)
mov %rdx, 64(%rsp)
mov 8(%rsi), %rax
mul %r11
mov %rax, (%rsp)
mov %rdx, 72(%rsp)
mov 16(%rsi), %rax
mul %r11
mov %rax, 8(%rsp)
mov %rdx, 80(%rsp)
mov 24(%rsi), %rax
mul %r11
mov %rax, 16(%rsp)
mov %rdx, 88(%rsp)
mov 32(%rsi), %rax
mul %r11
mov %rax, 24(%rsp)
mov %rdx, 96(%rsp)
mov 40(%rsi), %rax
mul %r11
mov %rax, 32(%rsp)
mov %rdx, 104(%rsp)
mov 48(%rsi), %rax
mul %r11
mov %rax, 40(%rsp)
mov %rdx, 112(%rsp)
mov 56(%rsi), %rax
mul %r11
mov %rax, 48(%rsp)
mov %rdx, 120(%rsp)
mov 64(%rsi), %rax
mul %r11
mov %rax, 56(%rsp)
mov 64(%rsp), %rax
add (%rsp), %rax
mov %rax, 8(%rdi)
mov 72(%rsp), %rax
adc 8(%rsp), %rax
mov %rax, 16(%rdi)
mov 80(%rsp), %rax
adc 16(%rsp), %rax
mov %rax, 24(%rdi)
mov 88(%rsp), %rax
adc 24(%rsp), %rax
mov %rax, 32(%rdi)
mov 96(%rsp), %rax
adc 32(%rsp), %rax
mov %rax, 40(%rdi)
mov 104(%rsp), %rax
adc 40(%rsp), %rax
mov %rax, 48(%rdi)
mov 112(%rsp), %rax
adc 48(%rsp), %rax
mov %rax, 56(%rdi)
mov 120(%rsp), %rax
adc 56(%rsp), %rax
mov %rax, 64(%rdi)
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
mov (%rsi), %rax
mul %r11
mov %rax, (%rsp)
mov (%rsp), %rax
add %rax, (%rdi)
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
mov (%rsi), %rax
mul %r11
mov %rax, (%rsp)
mov %rdx, 16(%rsp)
mov 8(%rsi), %rax
mul %r11
mov %rax, 8(%rsp)
mov 8(%rsp), %rax
add 16(%rsp), %rax
mov %rax, 8(%rsp)
adc $0, %rdx
mov (%rsp), %rax
add %rax, (%rdi)
mov 8(%rsp), %rax
adc %rax, 8(%rdi)
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
mov (%rsi), %rax
mul %r11
mov %rax, (%rsp)
mov %rdx, 24(%rsp)
mov 8(%rsi), %rax
mul %r11
mov %rax, 8(%rsp)
mov %rdx, 32(%rsp)
mov 16(%rsi), %rax
mul %r11
mov %rax, 16(%rsp)
mov 8(%rsp), %rax
add 24(%rsp), %rax
mov %rax, 8(%rsp)
mov 16(%rsp), %rax
adc 32(%rsp), %rax
mov %rax, 16(%rsp)
adc $0, %rdx
mov (%rsp), %rax
add %rax, (%rdi)
mov 8(%rsp), %rax
adc %rax, 8(%rdi)
mov 16(%rsp), %rax
adc %rax, 16(%rdi)
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
mov (%rsi), %rax
mul %r11
mov %rax, (%rsp)
mov %rdx, 32(%rsp)
mov 8(%rsi), %rax
mul %r11
mov %rax, 8(%rsp)
mov %rdx, 40(%rsp)
mov 16(%rsi), %rax
mul %r11
mov %rax, 16(%rsp)
mov %rdx, 48(%rsp)
mov 24(%rsi), %rax
mul %r11
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
add %rax, (%rdi)
mov 8(%rsp), %rax
adc %rax, 8(%rdi)
mov 16(%rsp), %rax
adc %rax, 16(%rdi)
mov 24(%rsp), %rax
adc %rax, 24(%rdi)
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
mov (%rsi), %rax
mul %r11
mov %rax, (%rsp)
mov %rdx, 40(%rsp)
mov 8(%rsi), %rax
mul %r11
mov %rax, 8(%rsp)
mov %rdx, 48(%rsp)
mov 16(%rsi), %rax
mul %r11
mov %rax, 16(%rsp)
mov %rdx, 56(%rsp)
mov 24(%rsi), %rax
mul %r11
mov %rax, 24(%rsp)
mov %rdx, 64(%rsp)
mov 32(%rsi), %rax
mul %r11
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
add %rax, (%rdi)
mov 8(%rsp), %rax
adc %rax, 8(%rdi)
mov 16(%rsp), %rax
adc %rax, 16(%rdi)
mov 24(%rsp), %rax
adc %rax, 24(%rdi)
mov 32(%rsp), %rax
adc %rax, 32(%rdi)
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
mov (%rsi), %rax
mul %r11
mov %rax, (%rsp)
mov %rdx, 48(%rsp)
mov 8(%rsi), %rax
mul %r11
mov %rax, 8(%rsp)
mov %rdx, 56(%rsp)
mov 16(%rsi), %rax
mul %r11
mov %rax, 16(%rsp)
mov %rdx, 64(%rsp)
mov 24(%rsi), %rax
mul %r11
mov %rax, 24(%rsp)
mov %rdx, 72(%rsp)
mov 32(%rsi), %rax
mul %r11
mov %rax, 32(%rsp)
mov %rdx, 80(%rsp)
mov 40(%rsi), %rax
mul %r11
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
add %rax, (%rdi)
mov 8(%rsp), %rax
adc %rax, 8(%rdi)
mov 16(%rsp), %rax
adc %rax, 16(%rdi)
mov 24(%rsp), %rax
adc %rax, 24(%rdi)
mov 32(%rsp), %rax
adc %rax, 32(%rdi)
mov 40(%rsp), %rax
adc %rax, 40(%rdi)
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
mov (%rsi), %rax
mul %r11
mov %rax, (%rsp)
mov %rdx, 56(%rsp)
mov 8(%rsi), %rax
mul %r11
mov %rax, 8(%rsp)
mov %rdx, 64(%rsp)
mov 16(%rsi), %rax
mul %r11
mov %rax, 16(%rsp)
mov %rdx, 72(%rsp)
mov 24(%rsi), %rax
mul %r11
mov %rax, 24(%rsp)
mov %rdx, 80(%rsp)
mov 32(%rsi), %rax
mul %r11
mov %rax, 32(%rsp)
mov %rdx, 88(%rsp)
mov 40(%rsi), %rax
mul %r11
mov %rax, 40(%rsp)
mov %rdx, 96(%rsp)
mov 48(%rsi), %rax
mul %r11
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
add %rax, (%rdi)
mov 8(%rsp), %rax
adc %rax, 8(%rdi)
mov 16(%rsp), %rax
adc %rax, 16(%rdi)
mov 24(%rsp), %rax
adc %rax, 24(%rdi)
mov 32(%rsp), %rax
adc %rax, 32(%rdi)
mov 40(%rsp), %rax
adc %rax, 40(%rdi)
mov 48(%rsp), %rax
adc %rax, 48(%rdi)
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
mov (%rsi), %rax
mul %r11
mov %rax, (%rsp)
mov %rdx, 64(%rsp)
mov 8(%rsi), %rax
mul %r11
mov %rax, 8(%rsp)
mov %rdx, 72(%rsp)
mov 16(%rsi), %rax
mul %r11
mov %rax, 16(%rsp)
mov %rdx, 80(%rsp)
mov 24(%rsi), %rax
mul %r11
mov %rax, 24(%rsp)
mov %rdx, 88(%rsp)
mov 32(%rsi), %rax
mul %r11
mov %rax, 32(%rsp)
mov %rdx, 96(%rsp)
mov 40(%rsi), %rax
mul %r11
mov %rax, 40(%rsp)
mov %rdx, 104(%rsp)
mov 48(%rsi), %rax
mul %r11
mov %rax, 48(%rsp)
mov %rdx, 112(%rsp)
mov 56(%rsi), %rax
mul %r11
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
add %rax, (%rdi)
mov 8(%rsp), %rax
adc %rax, 8(%rdi)
mov 16(%rsp), %rax
adc %rax, 16(%rdi)
mov 24(%rsp), %rax
adc %rax, 24(%rdi)
mov 32(%rsp), %rax
adc %rax, 32(%rdi)
mov 40(%rsp), %rax
adc %rax, 40(%rdi)
mov 48(%rsp), %rax
adc %rax, 48(%rdi)
mov 56(%rsp), %rax
adc %rax, 56(%rdi)
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
mov (%rsi), %rax
mul %r11
mov %rax, (%rsp)
mov %rdx, 72(%rsp)
mov 8(%rsi), %rax
mul %r11
mov %rax, 8(%rsp)
mov %rdx, 80(%rsp)
mov 16(%rsi), %rax
mul %r11
mov %rax, 16(%rsp)
mov %rdx, 88(%rsp)
mov 24(%rsi), %rax
mul %r11
mov %rax, 24(%rsp)
mov %rdx, 96(%rsp)
mov 32(%rsi), %rax
mul %r11
mov %rax, 32(%rsp)
mov %rdx, 104(%rsp)
mov 40(%rsi), %rax
mul %r11
mov %rax, 40(%rsp)
mov %rdx, 112(%rsp)
mov 48(%rsi), %rax
mul %r11
mov %rax, 48(%rsp)
mov %rdx, 120(%rsp)
mov 56(%rsi), %rax
mul %r11
mov %rax, 56(%rsp)
mov %rdx, 128(%rsp)
mov 64(%rsi), %rax
mul %r11
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
add %rax, (%rdi)
mov 8(%rsp), %rax
adc %rax, 8(%rdi)
mov 16(%rsp), %rax
adc %rax, 16(%rdi)
mov 24(%rsp), %rax
adc %rax, 24(%rdi)
mov 32(%rsp), %rax
adc %rax, 32(%rdi)
mov 40(%rsp), %rax
adc %rax, 40(%rdi)
mov 48(%rsp), %rax
adc %rax, 48(%rdi)
mov 56(%rsp), %rax
adc %rax, 56(%rdi)
mov 64(%rsp), %rax
adc %rax, 64(%rdi)
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
mov (%rsi), %rdx
mulx (%r11), %rax, %rcx
mov %rax, (%rdi)
adc $0, %rcx
mov %rcx, 8(%rdi)
ret
SIZE(mclb_mul_fast1)
.balign 16
.global PRE(mclb_mul_fast2)
PRE(mclb_mul_fast2):
TYPE(mclb_mul_fast2)
mov %rdx, %r11
mov (%rsi), %rdx
mulx (%r11), %rax, %rcx
mov %rax, (%rdi)
mulx 8(%r11), %rax, %r8
add %rax, %rcx
adc $0, %r8
mov 8(%rsi), %rdx
xor %rax, %rax
mulx (%r11), %rax, %r9
adox %rax, %rcx
mov %rcx, 8(%rdi)
adcx %r9, %r8
mulx 8(%r11), %rax, %r9
adox %rax, %r8
mov $0, %rax
adox %rax, %r9
adc %rax, %r9
mov %r8, 16(%rdi)
mov %r9, 24(%rdi)
ret
SIZE(mclb_mul_fast2)
.balign 16
.global PRE(mclb_mul_fast3)
PRE(mclb_mul_fast3):
TYPE(mclb_mul_fast3)
mov %rdx, %r11
mov (%rsi), %rdx
mulx (%r11), %rax, %rcx
mov %rax, (%rdi)
mulx 8(%r11), %rax, %r8
add %rax, %rcx
mulx 16(%r11), %rax, %r9
adc %rax, %r8
adc $0, %r9
mov 8(%rsi), %rdx
xor %rax, %rax
mulx (%r11), %rax, %r10
adox %rax, %rcx
mov %rcx, 8(%rdi)
adcx %r10, %r8
mulx 8(%r11), %rax, %r10
adox %rax, %r8
adcx %r10, %r9
mulx 16(%r11), %rax, %r10
adox %rax, %r9
mov $0, %rax
adox %rax, %r10
adc %rax, %r10
mov 16(%rsi), %rdx
xor %rax, %rax
mulx (%r11), %rax, %rcx
adox %rax, %r8
mov %r8, 16(%rdi)
adcx %rcx, %r9
mulx 8(%r11), %rax, %rcx
adox %rax, %r9
adcx %rcx, %r10
mulx 16(%r11), %rax, %rcx
adox %rax, %r10
mov $0, %rax
adox %rax, %rcx
adc %rax, %rcx
mov %r9, 24(%rdi)
mov %r10, 32(%rdi)
mov %rcx, 40(%rdi)
ret
SIZE(mclb_mul_fast3)
.balign 16
.global PRE(mclb_mul_fast4)
PRE(mclb_mul_fast4):
TYPE(mclb_mul_fast4)
push %rbx
mov %rdx, %r11
mov (%rsi), %rdx
mulx (%r11), %rax, %rcx
mov %rax, (%rdi)
mulx 8(%r11), %rax, %r8
add %rax, %rcx
mulx 16(%r11), %rax, %r9
adc %rax, %r8
mulx 24(%r11), %rax, %r10
adc %rax, %r9
adc $0, %r10
mov 8(%rsi), %rdx
xor %rax, %rax
mulx (%r11), %rax, %rbx
adox %rax, %rcx
mov %rcx, 8(%rdi)
adcx %rbx, %r8
mulx 8(%r11), %rax, %rbx
adox %rax, %r8
adcx %rbx, %r9
mulx 16(%r11), %rax, %rbx
adox %rax, %r9
adcx %rbx, %r10
mulx 24(%r11), %rax, %rbx
adox %rax, %r10
mov $0, %rax
adox %rax, %rbx
adc %rax, %rbx
mov 16(%rsi), %rdx
xor %rax, %rax
mulx (%r11), %rax, %rcx
adox %rax, %r8
mov %r8, 16(%rdi)
adcx %rcx, %r9
mulx 8(%r11), %rax, %rcx
adox %rax, %r9
adcx %rcx, %r10
mulx 16(%r11), %rax, %rcx
adox %rax, %r10
adcx %rcx, %rbx
mulx 24(%r11), %rax, %rcx
adox %rax, %rbx
mov $0, %rax
adox %rax, %rcx
adc %rax, %rcx
mov 24(%rsi), %rdx
xor %rax, %rax
mulx (%r11), %rax, %r8
adox %rax, %r9
mov %r9, 24(%rdi)
adcx %r8, %r10
mulx 8(%r11), %rax, %r8
adox %rax, %r10
adcx %r8, %rbx
mulx 16(%r11), %rax, %r8
adox %rax, %rbx
adcx %r8, %rcx
mulx 24(%r11), %rax, %r8
adox %rax, %rcx
mov $0, %rax
adox %rax, %r8
adc %rax, %r8
mov %r10, 32(%rdi)
mov %rbx, 40(%rdi)
mov %rcx, 48(%rdi)
mov %r8, 56(%rdi)
pop %rbx
ret
SIZE(mclb_mul_fast4)
.balign 16
.global PRE(mclb_mul_fast5)
PRE(mclb_mul_fast5):
TYPE(mclb_mul_fast5)
push %rbx
push %rbp
mov %rdx, %r11
mov (%rsi), %rdx
mulx (%r11), %rax, %rcx
mov %rax, (%rdi)
mulx 8(%r11), %rax, %r8
add %rax, %rcx
mulx 16(%r11), %rax, %r9
adc %rax, %r8
mulx 24(%r11), %rax, %r10
adc %rax, %r9
mulx 32(%r11), %rax, %rbx
adc %rax, %r10
adc $0, %rbx
mov 8(%rsi), %rdx
xor %rax, %rax
mulx (%r11), %rax, %rbp
adox %rax, %rcx
mov %rcx, 8(%rdi)
adcx %rbp, %r8
mulx 8(%r11), %rax, %rbp
adox %rax, %r8
adcx %rbp, %r9
mulx 16(%r11), %rax, %rbp
adox %rax, %r9
adcx %rbp, %r10
mulx 24(%r11), %rax, %rbp
adox %rax, %r10
adcx %rbp, %rbx
mulx 32(%r11), %rax, %rbp
adox %rax, %rbx
mov $0, %rax
adox %rax, %rbp
adc %rax, %rbp
mov 16(%rsi), %rdx
xor %rax, %rax
mulx (%r11), %rax, %rcx
adox %rax, %r8
mov %r8, 16(%rdi)
adcx %rcx, %r9
mulx 8(%r11), %rax, %rcx
adox %rax, %r9
adcx %rcx, %r10
mulx 16(%r11), %rax, %rcx
adox %rax, %r10
adcx %rcx, %rbx
mulx 24(%r11), %rax, %rcx
adox %rax, %rbx
adcx %rcx, %rbp
mulx 32(%r11), %rax, %rcx
adox %rax, %rbp
mov $0, %rax
adox %rax, %rcx
adc %rax, %rcx
mov 24(%rsi), %rdx
xor %rax, %rax
mulx (%r11), %rax, %r8
adox %rax, %r9
mov %r9, 24(%rdi)
adcx %r8, %r10
mulx 8(%r11), %rax, %r8
adox %rax, %r10
adcx %r8, %rbx
mulx 16(%r11), %rax, %r8
adox %rax, %rbx
adcx %r8, %rbp
mulx 24(%r11), %rax, %r8
adox %rax, %rbp
adcx %r8, %rcx
mulx 32(%r11), %rax, %r8
adox %rax, %rcx
mov $0, %rax
adox %rax, %r8
adc %rax, %r8
mov 32(%rsi), %rdx
xor %rax, %rax
mulx (%r11), %rax, %r9
adox %rax, %r10
mov %r10, 32(%rdi)
adcx %r9, %rbx
mulx 8(%r11), %rax, %r9
adox %rax, %rbx
adcx %r9, %rbp
mulx 16(%r11), %rax, %r9
adox %rax, %rbp
adcx %r9, %rcx
mulx 24(%r11), %rax, %r9
adox %rax, %rcx
adcx %r9, %r8
mulx 32(%r11), %rax, %r9
adox %rax, %r8
mov $0, %rax
adox %rax, %r9
adc %rax, %r9
mov %rbx, 40(%rdi)
mov %rbp, 48(%rdi)
mov %rcx, 56(%rdi)
mov %r8, 64(%rdi)
mov %r9, 72(%rdi)
pop %rbp
pop %rbx
ret
SIZE(mclb_mul_fast5)
.balign 16
.global PRE(mclb_mul_fast6)
PRE(mclb_mul_fast6):
TYPE(mclb_mul_fast6)
push %rbx
push %rbp
push %r12
mov %rdx, %r11
mov (%rsi), %rdx
mulx (%r11), %rax, %rcx
mov %rax, (%rdi)
mulx 8(%r11), %rax, %r8
add %rax, %rcx
mulx 16(%r11), %rax, %r9
adc %rax, %r8
mulx 24(%r11), %rax, %r10
adc %rax, %r9
mulx 32(%r11), %rax, %rbx
adc %rax, %r10
mulx 40(%r11), %rax, %rbp
adc %rax, %rbx
adc $0, %rbp
mov 8(%rsi), %rdx
xor %rax, %rax
mulx (%r11), %rax, %r12
adox %rax, %rcx
mov %rcx, 8(%rdi)
adcx %r12, %r8
mulx 8(%r11), %rax, %r12
adox %rax, %r8
adcx %r12, %r9
mulx 16(%r11), %rax, %r12
adox %rax, %r9
adcx %r12, %r10
mulx 24(%r11), %rax, %r12
adox %rax, %r10
adcx %r12, %rbx
mulx 32(%r11), %rax, %r12
adox %rax, %rbx
adcx %r12, %rbp
mulx 40(%r11), %rax, %r12
adox %rax, %rbp
mov $0, %rax
adox %rax, %r12
adc %rax, %r12
mov 16(%rsi), %rdx
xor %rax, %rax
mulx (%r11), %rax, %rcx
adox %rax, %r8
mov %r8, 16(%rdi)
adcx %rcx, %r9
mulx 8(%r11), %rax, %rcx
adox %rax, %r9
adcx %rcx, %r10
mulx 16(%r11), %rax, %rcx
adox %rax, %r10
adcx %rcx, %rbx
mulx 24(%r11), %rax, %rcx
adox %rax, %rbx
adcx %rcx, %rbp
mulx 32(%r11), %rax, %rcx
adox %rax, %rbp
adcx %rcx, %r12
mulx 40(%r11), %rax, %rcx
adox %rax, %r12
mov $0, %rax
adox %rax, %rcx
adc %rax, %rcx
mov 24(%rsi), %rdx
xor %rax, %rax
mulx (%r11), %rax, %r8
adox %rax, %r9
mov %r9, 24(%rdi)
adcx %r8, %r10
mulx 8(%r11), %rax, %r8
adox %rax, %r10
adcx %r8, %rbx
mulx 16(%r11), %rax, %r8
adox %rax, %rbx
adcx %r8, %rbp
mulx 24(%r11), %rax, %r8
adox %rax, %rbp
adcx %r8, %r12
mulx 32(%r11), %rax, %r8
adox %rax, %r12
adcx %r8, %rcx
mulx 40(%r11), %rax, %r8
adox %rax, %rcx
mov $0, %rax
adox %rax, %r8
adc %rax, %r8
mov 32(%rsi), %rdx
xor %rax, %rax
mulx (%r11), %rax, %r9
adox %rax, %r10
mov %r10, 32(%rdi)
adcx %r9, %rbx
mulx 8(%r11), %rax, %r9
adox %rax, %rbx
adcx %r9, %rbp
mulx 16(%r11), %rax, %r9
adox %rax, %rbp
adcx %r9, %r12
mulx 24(%r11), %rax, %r9
adox %rax, %r12
adcx %r9, %rcx
mulx 32(%r11), %rax, %r9
adox %rax, %rcx
adcx %r9, %r8
mulx 40(%r11), %rax, %r9
adox %rax, %r8
mov $0, %rax
adox %rax, %r9
adc %rax, %r9
mov 40(%rsi), %rdx
xor %rax, %rax
mulx (%r11), %rax, %r10
adox %rax, %rbx
mov %rbx, 40(%rdi)
adcx %r10, %rbp
mulx 8(%r11), %rax, %r10
adox %rax, %rbp
adcx %r10, %r12
mulx 16(%r11), %rax, %r10
adox %rax, %r12
adcx %r10, %rcx
mulx 24(%r11), %rax, %r10
adox %rax, %rcx
adcx %r10, %r8
mulx 32(%r11), %rax, %r10
adox %rax, %r8
adcx %r10, %r9
mulx 40(%r11), %rax, %r10
adox %rax, %r9
mov $0, %rax
adox %rax, %r10
adc %rax, %r10
mov %rbp, 48(%rdi)
mov %r12, 56(%rdi)
mov %rcx, 64(%rdi)
mov %r8, 72(%rdi)
mov %r9, 80(%rdi)
mov %r10, 88(%rdi)
pop %r12
pop %rbp
pop %rbx
ret
SIZE(mclb_mul_fast6)
.balign 16
.global PRE(mclb_mul_fast7)
PRE(mclb_mul_fast7):
TYPE(mclb_mul_fast7)
push %rbx
push %rbp
push %r12
push %r13
mov %rdx, %r11
mov (%rsi), %rdx
mulx (%r11), %rax, %rcx
mov %rax, (%rdi)
mulx 8(%r11), %rax, %r8
add %rax, %rcx
mulx 16(%r11), %rax, %r9
adc %rax, %r8
mulx 24(%r11), %rax, %r10
adc %rax, %r9
mulx 32(%r11), %rax, %rbx
adc %rax, %r10
mulx 40(%r11), %rax, %rbp
adc %rax, %rbx
mulx 48(%r11), %rax, %r12
adc %rax, %rbp
adc $0, %r12
mov 8(%rsi), %rdx
xor %rax, %rax
mulx (%r11), %rax, %r13
adox %rax, %rcx
mov %rcx, 8(%rdi)
adcx %r13, %r8
mulx 8(%r11), %rax, %r13
adox %rax, %r8
adcx %r13, %r9
mulx 16(%r11), %rax, %r13
adox %rax, %r9
adcx %r13, %r10
mulx 24(%r11), %rax, %r13
adox %rax, %r10
adcx %r13, %rbx
mulx 32(%r11), %rax, %r13
adox %rax, %rbx
adcx %r13, %rbp
mulx 40(%r11), %rax, %r13
adox %rax, %rbp
adcx %r13, %r12
mulx 48(%r11), %rax, %r13
adox %rax, %r12
mov $0, %rax
adox %rax, %r13
adc %rax, %r13
mov 16(%rsi), %rdx
xor %rax, %rax
mulx (%r11), %rax, %rcx
adox %rax, %r8
mov %r8, 16(%rdi)
adcx %rcx, %r9
mulx 8(%r11), %rax, %rcx
adox %rax, %r9
adcx %rcx, %r10
mulx 16(%r11), %rax, %rcx
adox %rax, %r10
adcx %rcx, %rbx
mulx 24(%r11), %rax, %rcx
adox %rax, %rbx
adcx %rcx, %rbp
mulx 32(%r11), %rax, %rcx
adox %rax, %rbp
adcx %rcx, %r12
mulx 40(%r11), %rax, %rcx
adox %rax, %r12
adcx %rcx, %r13
mulx 48(%r11), %rax, %rcx
adox %rax, %r13
mov $0, %rax
adox %rax, %rcx
adc %rax, %rcx
mov 24(%rsi), %rdx
xor %rax, %rax
mulx (%r11), %rax, %r8
adox %rax, %r9
mov %r9, 24(%rdi)
adcx %r8, %r10
mulx 8(%r11), %rax, %r8
adox %rax, %r10
adcx %r8, %rbx
mulx 16(%r11), %rax, %r8
adox %rax, %rbx
adcx %r8, %rbp
mulx 24(%r11), %rax, %r8
adox %rax, %rbp
adcx %r8, %r12
mulx 32(%r11), %rax, %r8
adox %rax, %r12
adcx %r8, %r13
mulx 40(%r11), %rax, %r8
adox %rax, %r13
adcx %r8, %rcx
mulx 48(%r11), %rax, %r8
adox %rax, %rcx
mov $0, %rax
adox %rax, %r8
adc %rax, %r8
mov 32(%rsi), %rdx
xor %rax, %rax
mulx (%r11), %rax, %r9
adox %rax, %r10
mov %r10, 32(%rdi)
adcx %r9, %rbx
mulx 8(%r11), %rax, %r9
adox %rax, %rbx
adcx %r9, %rbp
mulx 16(%r11), %rax, %r9
adox %rax, %rbp
adcx %r9, %r12
mulx 24(%r11), %rax, %r9
adox %rax, %r12
adcx %r9, %r13
mulx 32(%r11), %rax, %r9
adox %rax, %r13
adcx %r9, %rcx
mulx 40(%r11), %rax, %r9
adox %rax, %rcx
adcx %r9, %r8
mulx 48(%r11), %rax, %r9
adox %rax, %r8
mov $0, %rax
adox %rax, %r9
adc %rax, %r9
mov 40(%rsi), %rdx
xor %rax, %rax
mulx (%r11), %rax, %r10
adox %rax, %rbx
mov %rbx, 40(%rdi)
adcx %r10, %rbp
mulx 8(%r11), %rax, %r10
adox %rax, %rbp
adcx %r10, %r12
mulx 16(%r11), %rax, %r10
adox %rax, %r12
adcx %r10, %r13
mulx 24(%r11), %rax, %r10
adox %rax, %r13
adcx %r10, %rcx
mulx 32(%r11), %rax, %r10
adox %rax, %rcx
adcx %r10, %r8
mulx 40(%r11), %rax, %r10
adox %rax, %r8
adcx %r10, %r9
mulx 48(%r11), %rax, %r10
adox %rax, %r9
mov $0, %rax
adox %rax, %r10
adc %rax, %r10
mov 48(%rsi), %rdx
xor %rax, %rax
mulx (%r11), %rax, %rbx
adox %rax, %rbp
mov %rbp, 48(%rdi)
adcx %rbx, %r12
mulx 8(%r11), %rax, %rbx
adox %rax, %r12
adcx %rbx, %r13
mulx 16(%r11), %rax, %rbx
adox %rax, %r13
adcx %rbx, %rcx
mulx 24(%r11), %rax, %rbx
adox %rax, %rcx
adcx %rbx, %r8
mulx 32(%r11), %rax, %rbx
adox %rax, %r8
adcx %rbx, %r9
mulx 40(%r11), %rax, %rbx
adox %rax, %r9
adcx %rbx, %r10
mulx 48(%r11), %rax, %rbx
adox %rax, %r10
mov $0, %rax
adox %rax, %rbx
adc %rax, %rbx
mov %r12, 56(%rdi)
mov %r13, 64(%rdi)
mov %rcx, 72(%rdi)
mov %r8, 80(%rdi)
mov %r9, 88(%rdi)
mov %r10, 96(%rdi)
mov %rbx, 104(%rdi)
pop %r13
pop %r12
pop %rbp
pop %rbx
ret
SIZE(mclb_mul_fast7)
.balign 16
.global PRE(mclb_mul_fast8)
PRE(mclb_mul_fast8):
TYPE(mclb_mul_fast8)
push %rbx
push %rbp
push %r12
push %r13
push %r14
mov %rdx, %r11
mov (%rsi), %rdx
mulx (%r11), %rax, %rcx
mov %rax, (%rdi)
mulx 8(%r11), %rax, %r8
add %rax, %rcx
mulx 16(%r11), %rax, %r9
adc %rax, %r8
mulx 24(%r11), %rax, %r10
adc %rax, %r9
mulx 32(%r11), %rax, %rbx
adc %rax, %r10
mulx 40(%r11), %rax, %rbp
adc %rax, %rbx
mulx 48(%r11), %rax, %r12
adc %rax, %rbp
mulx 56(%r11), %rax, %r13
adc %rax, %r12
adc $0, %r13
mov 8(%rsi), %rdx
xor %rax, %rax
mulx (%r11), %rax, %r14
adox %rax, %rcx
mov %rcx, 8(%rdi)
adcx %r14, %r8
mulx 8(%r11), %rax, %r14
adox %rax, %r8
adcx %r14, %r9
mulx 16(%r11), %rax, %r14
adox %rax, %r9
adcx %r14, %r10
mulx 24(%r11), %rax, %r14
adox %rax, %r10
adcx %r14, %rbx
mulx 32(%r11), %rax, %r14
adox %rax, %rbx
adcx %r14, %rbp
mulx 40(%r11), %rax, %r14
adox %rax, %rbp
adcx %r14, %r12
mulx 48(%r11), %rax, %r14
adox %rax, %r12
adcx %r14, %r13
mulx 56(%r11), %rax, %r14
adox %rax, %r13
mov $0, %rax
adox %rax, %r14
adc %rax, %r14
mov 16(%rsi), %rdx
xor %rax, %rax
mulx (%r11), %rax, %rcx
adox %rax, %r8
mov %r8, 16(%rdi)
adcx %rcx, %r9
mulx 8(%r11), %rax, %rcx
adox %rax, %r9
adcx %rcx, %r10
mulx 16(%r11), %rax, %rcx
adox %rax, %r10
adcx %rcx, %rbx
mulx 24(%r11), %rax, %rcx
adox %rax, %rbx
adcx %rcx, %rbp
mulx 32(%r11), %rax, %rcx
adox %rax, %rbp
adcx %rcx, %r12
mulx 40(%r11), %rax, %rcx
adox %rax, %r12
adcx %rcx, %r13
mulx 48(%r11), %rax, %rcx
adox %rax, %r13
adcx %rcx, %r14
mulx 56(%r11), %rax, %rcx
adox %rax, %r14
mov $0, %rax
adox %rax, %rcx
adc %rax, %rcx
mov 24(%rsi), %rdx
xor %rax, %rax
mulx (%r11), %rax, %r8
adox %rax, %r9
mov %r9, 24(%rdi)
adcx %r8, %r10
mulx 8(%r11), %rax, %r8
adox %rax, %r10
adcx %r8, %rbx
mulx 16(%r11), %rax, %r8
adox %rax, %rbx
adcx %r8, %rbp
mulx 24(%r11), %rax, %r8
adox %rax, %rbp
adcx %r8, %r12
mulx 32(%r11), %rax, %r8
adox %rax, %r12
adcx %r8, %r13
mulx 40(%r11), %rax, %r8
adox %rax, %r13
adcx %r8, %r14
mulx 48(%r11), %rax, %r8
adox %rax, %r14
adcx %r8, %rcx
mulx 56(%r11), %rax, %r8
adox %rax, %rcx
mov $0, %rax
adox %rax, %r8
adc %rax, %r8
mov 32(%rsi), %rdx
xor %rax, %rax
mulx (%r11), %rax, %r9
adox %rax, %r10
mov %r10, 32(%rdi)
adcx %r9, %rbx
mulx 8(%r11), %rax, %r9
adox %rax, %rbx
adcx %r9, %rbp
mulx 16(%r11), %rax, %r9
adox %rax, %rbp
adcx %r9, %r12
mulx 24(%r11), %rax, %r9
adox %rax, %r12
adcx %r9, %r13
mulx 32(%r11), %rax, %r9
adox %rax, %r13
adcx %r9, %r14
mulx 40(%r11), %rax, %r9
adox %rax, %r14
adcx %r9, %rcx
mulx 48(%r11), %rax, %r9
adox %rax, %rcx
adcx %r9, %r8
mulx 56(%r11), %rax, %r9
adox %rax, %r8
mov $0, %rax
adox %rax, %r9
adc %rax, %r9
mov 40(%rsi), %rdx
xor %rax, %rax
mulx (%r11), %rax, %r10
adox %rax, %rbx
mov %rbx, 40(%rdi)
adcx %r10, %rbp
mulx 8(%r11), %rax, %r10
adox %rax, %rbp
adcx %r10, %r12
mulx 16(%r11), %rax, %r10
adox %rax, %r12
adcx %r10, %r13
mulx 24(%r11), %rax, %r10
adox %rax, %r13
adcx %r10, %r14
mulx 32(%r11), %rax, %r10
adox %rax, %r14
adcx %r10, %rcx
mulx 40(%r11), %rax, %r10
adox %rax, %rcx
adcx %r10, %r8
mulx 48(%r11), %rax, %r10
adox %rax, %r8
adcx %r10, %r9
mulx 56(%r11), %rax, %r10
adox %rax, %r9
mov $0, %rax
adox %rax, %r10
adc %rax, %r10
mov 48(%rsi), %rdx
xor %rax, %rax
mulx (%r11), %rax, %rbx
adox %rax, %rbp
mov %rbp, 48(%rdi)
adcx %rbx, %r12
mulx 8(%r11), %rax, %rbx
adox %rax, %r12
adcx %rbx, %r13
mulx 16(%r11), %rax, %rbx
adox %rax, %r13
adcx %rbx, %r14
mulx 24(%r11), %rax, %rbx
adox %rax, %r14
adcx %rbx, %rcx
mulx 32(%r11), %rax, %rbx
adox %rax, %rcx
adcx %rbx, %r8
mulx 40(%r11), %rax, %rbx
adox %rax, %r8
adcx %rbx, %r9
mulx 48(%r11), %rax, %rbx
adox %rax, %r9
adcx %rbx, %r10
mulx 56(%r11), %rax, %rbx
adox %rax, %r10
mov $0, %rax
adox %rax, %rbx
adc %rax, %rbx
mov 56(%rsi), %rdx
xor %rax, %rax
mulx (%r11), %rax, %rbp
adox %rax, %r12
mov %r12, 56(%rdi)
adcx %rbp, %r13
mulx 8(%r11), %rax, %rbp
adox %rax, %r13
adcx %rbp, %r14
mulx 16(%r11), %rax, %rbp
adox %rax, %r14
adcx %rbp, %rcx
mulx 24(%r11), %rax, %rbp
adox %rax, %rcx
adcx %rbp, %r8
mulx 32(%r11), %rax, %rbp
adox %rax, %r8
adcx %rbp, %r9
mulx 40(%r11), %rax, %rbp
adox %rax, %r9
adcx %rbp, %r10
mulx 48(%r11), %rax, %rbp
adox %rax, %r10
adcx %rbp, %rbx
mulx 56(%r11), %rax, %rbp
adox %rax, %rbx
mov $0, %rax
adox %rax, %rbp
adc %rax, %rbp
mov %r13, 64(%rdi)
mov %r14, 72(%rdi)
mov %rcx, 80(%rdi)
mov %r8, 88(%rdi)
mov %r9, 96(%rdi)
mov %r10, 104(%rdi)
mov %rbx, 112(%rdi)
mov %rbp, 120(%rdi)
pop %r14
pop %r13
pop %r12
pop %rbp
pop %rbx
ret
SIZE(mclb_mul_fast8)
.balign 16
.global PRE(mclb_mul_fast9)
PRE(mclb_mul_fast9):
TYPE(mclb_mul_fast9)
push %rbx
push %rbp
push %r12
push %r13
push %r14
push %r15
mov %rdx, %r11
mov (%rsi), %rdx
mulx (%r11), %rax, %rcx
mov %rax, (%rdi)
mulx 8(%r11), %rax, %r8
add %rax, %rcx
mulx 16(%r11), %rax, %r9
adc %rax, %r8
mulx 24(%r11), %rax, %r10
adc %rax, %r9
mulx 32(%r11), %rax, %rbx
adc %rax, %r10
mulx 40(%r11), %rax, %rbp
adc %rax, %rbx
mulx 48(%r11), %rax, %r12
adc %rax, %rbp
mulx 56(%r11), %rax, %r13
adc %rax, %r12
mulx 64(%r11), %rax, %r14
adc %rax, %r13
adc $0, %r14
mov 8(%rsi), %rdx
xor %rax, %rax
mulx (%r11), %rax, %r15
adox %rax, %rcx
mov %rcx, 8(%rdi)
adcx %r15, %r8
mulx 8(%r11), %rax, %r15
adox %rax, %r8
adcx %r15, %r9
mulx 16(%r11), %rax, %r15
adox %rax, %r9
adcx %r15, %r10
mulx 24(%r11), %rax, %r15
adox %rax, %r10
adcx %r15, %rbx
mulx 32(%r11), %rax, %r15
adox %rax, %rbx
adcx %r15, %rbp
mulx 40(%r11), %rax, %r15
adox %rax, %rbp
adcx %r15, %r12
mulx 48(%r11), %rax, %r15
adox %rax, %r12
adcx %r15, %r13
mulx 56(%r11), %rax, %r15
adox %rax, %r13
adcx %r15, %r14
mulx 64(%r11), %rax, %r15
adox %rax, %r14
mov $0, %rax
adox %rax, %r15
adc %rax, %r15
mov 16(%rsi), %rdx
xor %rax, %rax
mulx (%r11), %rax, %rcx
adox %rax, %r8
mov %r8, 16(%rdi)
adcx %rcx, %r9
mulx 8(%r11), %rax, %rcx
adox %rax, %r9
adcx %rcx, %r10
mulx 16(%r11), %rax, %rcx
adox %rax, %r10
adcx %rcx, %rbx
mulx 24(%r11), %rax, %rcx
adox %rax, %rbx
adcx %rcx, %rbp
mulx 32(%r11), %rax, %rcx
adox %rax, %rbp
adcx %rcx, %r12
mulx 40(%r11), %rax, %rcx
adox %rax, %r12
adcx %rcx, %r13
mulx 48(%r11), %rax, %rcx
adox %rax, %r13
adcx %rcx, %r14
mulx 56(%r11), %rax, %rcx
adox %rax, %r14
adcx %rcx, %r15
mulx 64(%r11), %rax, %rcx
adox %rax, %r15
mov $0, %rax
adox %rax, %rcx
adc %rax, %rcx
mov 24(%rsi), %rdx
xor %rax, %rax
mulx (%r11), %rax, %r8
adox %rax, %r9
mov %r9, 24(%rdi)
adcx %r8, %r10
mulx 8(%r11), %rax, %r8
adox %rax, %r10
adcx %r8, %rbx
mulx 16(%r11), %rax, %r8
adox %rax, %rbx
adcx %r8, %rbp
mulx 24(%r11), %rax, %r8
adox %rax, %rbp
adcx %r8, %r12
mulx 32(%r11), %rax, %r8
adox %rax, %r12
adcx %r8, %r13
mulx 40(%r11), %rax, %r8
adox %rax, %r13
adcx %r8, %r14
mulx 48(%r11), %rax, %r8
adox %rax, %r14
adcx %r8, %r15
mulx 56(%r11), %rax, %r8
adox %rax, %r15
adcx %r8, %rcx
mulx 64(%r11), %rax, %r8
adox %rax, %rcx
mov $0, %rax
adox %rax, %r8
adc %rax, %r8
mov 32(%rsi), %rdx
xor %rax, %rax
mulx (%r11), %rax, %r9
adox %rax, %r10
mov %r10, 32(%rdi)
adcx %r9, %rbx
mulx 8(%r11), %rax, %r9
adox %rax, %rbx
adcx %r9, %rbp
mulx 16(%r11), %rax, %r9
adox %rax, %rbp
adcx %r9, %r12
mulx 24(%r11), %rax, %r9
adox %rax, %r12
adcx %r9, %r13
mulx 32(%r11), %rax, %r9
adox %rax, %r13
adcx %r9, %r14
mulx 40(%r11), %rax, %r9
adox %rax, %r14
adcx %r9, %r15
mulx 48(%r11), %rax, %r9
adox %rax, %r15
adcx %r9, %rcx
mulx 56(%r11), %rax, %r9
adox %rax, %rcx
adcx %r9, %r8
mulx 64(%r11), %rax, %r9
adox %rax, %r8
mov $0, %rax
adox %rax, %r9
adc %rax, %r9
mov 40(%rsi), %rdx
xor %rax, %rax
mulx (%r11), %rax, %r10
adox %rax, %rbx
mov %rbx, 40(%rdi)
adcx %r10, %rbp
mulx 8(%r11), %rax, %r10
adox %rax, %rbp
adcx %r10, %r12
mulx 16(%r11), %rax, %r10
adox %rax, %r12
adcx %r10, %r13
mulx 24(%r11), %rax, %r10
adox %rax, %r13
adcx %r10, %r14
mulx 32(%r11), %rax, %r10
adox %rax, %r14
adcx %r10, %r15
mulx 40(%r11), %rax, %r10
adox %rax, %r15
adcx %r10, %rcx
mulx 48(%r11), %rax, %r10
adox %rax, %rcx
adcx %r10, %r8
mulx 56(%r11), %rax, %r10
adox %rax, %r8
adcx %r10, %r9
mulx 64(%r11), %rax, %r10
adox %rax, %r9
mov $0, %rax
adox %rax, %r10
adc %rax, %r10
mov 48(%rsi), %rdx
xor %rax, %rax
mulx (%r11), %rax, %rbx
adox %rax, %rbp
mov %rbp, 48(%rdi)
adcx %rbx, %r12
mulx 8(%r11), %rax, %rbx
adox %rax, %r12
adcx %rbx, %r13
mulx 16(%r11), %rax, %rbx
adox %rax, %r13
adcx %rbx, %r14
mulx 24(%r11), %rax, %rbx
adox %rax, %r14
adcx %rbx, %r15
mulx 32(%r11), %rax, %rbx
adox %rax, %r15
adcx %rbx, %rcx
mulx 40(%r11), %rax, %rbx
adox %rax, %rcx
adcx %rbx, %r8
mulx 48(%r11), %rax, %rbx
adox %rax, %r8
adcx %rbx, %r9
mulx 56(%r11), %rax, %rbx
adox %rax, %r9
adcx %rbx, %r10
mulx 64(%r11), %rax, %rbx
adox %rax, %r10
mov $0, %rax
adox %rax, %rbx
adc %rax, %rbx
mov 56(%rsi), %rdx
xor %rax, %rax
mulx (%r11), %rax, %rbp
adox %rax, %r12
mov %r12, 56(%rdi)
adcx %rbp, %r13
mulx 8(%r11), %rax, %rbp
adox %rax, %r13
adcx %rbp, %r14
mulx 16(%r11), %rax, %rbp
adox %rax, %r14
adcx %rbp, %r15
mulx 24(%r11), %rax, %rbp
adox %rax, %r15
adcx %rbp, %rcx
mulx 32(%r11), %rax, %rbp
adox %rax, %rcx
adcx %rbp, %r8
mulx 40(%r11), %rax, %rbp
adox %rax, %r8
adcx %rbp, %r9
mulx 48(%r11), %rax, %rbp
adox %rax, %r9
adcx %rbp, %r10
mulx 56(%r11), %rax, %rbp
adox %rax, %r10
adcx %rbp, %rbx
mulx 64(%r11), %rax, %rbp
adox %rax, %rbx
mov $0, %rax
adox %rax, %rbp
adc %rax, %rbp
mov 64(%rsi), %rdx
xor %rax, %rax
mulx (%r11), %rax, %r12
adox %rax, %r13
mov %r13, 64(%rdi)
adcx %r12, %r14
mulx 8(%r11), %rax, %r12
adox %rax, %r14
adcx %r12, %r15
mulx 16(%r11), %rax, %r12
adox %rax, %r15
adcx %r12, %rcx
mulx 24(%r11), %rax, %r12
adox %rax, %rcx
adcx %r12, %r8
mulx 32(%r11), %rax, %r12
adox %rax, %r8
adcx %r12, %r9
mulx 40(%r11), %rax, %r12
adox %rax, %r9
adcx %r12, %r10
mulx 48(%r11), %rax, %r12
adox %rax, %r10
adcx %r12, %rbx
mulx 56(%r11), %rax, %r12
adox %rax, %rbx
adcx %r12, %rbp
mulx 64(%r11), %rax, %r12
adox %rax, %rbp
mov $0, %rax
adox %rax, %r12
adc %rax, %r12
mov %r14, 72(%rdi)
mov %r15, 80(%rdi)
mov %rcx, 88(%rdi)
mov %r8, 96(%rdi)
mov %r9, 104(%rdi)
mov %r10, 112(%rdi)
mov %rbx, 120(%rdi)
mov %rbp, 128(%rdi)
mov %r12, 136(%rdi)
pop %r15
pop %r14
pop %r13
pop %r12
pop %rbp
pop %rbx
ret
SIZE(mclb_mul_fast9)
.balign 16
.global PRE(mclb_sqr_fast1)
PRE(mclb_sqr_fast1):
TYPE(mclb_sqr_fast1)
mov (%rsi), %rax
mul %rax
mov %rax, (%rdi)
mov %rdx, 8(%rdi)
ret
SIZE(mclb_sqr_fast1)
.balign 16
.global PRE(mclb_sqr_fast2)
PRE(mclb_sqr_fast2):
TYPE(mclb_sqr_fast2)
mov %rsi, %rdx
jmp PRE(mclb_mul_fast2)
SIZE(mclb_sqr_fast2)
.balign 16
.global PRE(mclb_sqr_fast3)
PRE(mclb_sqr_fast3):
TYPE(mclb_sqr_fast3)
mov %rsi, %rdx
jmp PRE(mclb_mul_fast3)
SIZE(mclb_sqr_fast3)
.balign 16
.global PRE(mclb_sqr_fast4)
PRE(mclb_sqr_fast4):
TYPE(mclb_sqr_fast4)
mov %rsi, %rdx
jmp PRE(mclb_mul_fast4)
SIZE(mclb_sqr_fast4)
.balign 16
.global PRE(mclb_sqr_fast5)
PRE(mclb_sqr_fast5):
TYPE(mclb_sqr_fast5)
mov %rsi, %rdx
jmp PRE(mclb_mul_fast5)
SIZE(mclb_sqr_fast5)
.balign 16
.global PRE(mclb_sqr_fast6)
PRE(mclb_sqr_fast6):
TYPE(mclb_sqr_fast6)
mov %rsi, %rdx
jmp PRE(mclb_mul_fast6)
SIZE(mclb_sqr_fast6)
.balign 16
.global PRE(mclb_sqr_fast7)
PRE(mclb_sqr_fast7):
TYPE(mclb_sqr_fast7)
mov %rsi, %rdx
jmp PRE(mclb_mul_fast7)
SIZE(mclb_sqr_fast7)
.balign 16
.global PRE(mclb_sqr_fast8)
PRE(mclb_sqr_fast8):
TYPE(mclb_sqr_fast8)
mov %rsi, %rdx
jmp PRE(mclb_mul_fast8)
SIZE(mclb_sqr_fast8)
.balign 16
.global PRE(mclb_sqr_fast9)
PRE(mclb_sqr_fast9):
TYPE(mclb_sqr_fast9)
mov %rsi, %rdx
jmp PRE(mclb_mul_fast9)
SIZE(mclb_sqr_fast9)
