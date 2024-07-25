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
.text
.align 16
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
.align 16
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
.align 16
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
.align 16
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
.align 16
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
.align 16
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
.align 16
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
.align 16
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
.align 16
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
.align 16
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
.align 16
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
.align 16
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
.align 16
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
.align 16
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
.align 16
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
.align 16
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
.align 16
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
.align 16
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
.align 16
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
.align 16
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
.align 16
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
.align 16
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
.align 16
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
.align 16
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
.align 16
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
.align 16
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
.align 16
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
.align 16
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
.align 16
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
.align 16
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
.align 16
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
.align 16
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
.align 16
.global PRE(mclb_addNF1)
PRE(mclb_addNF1):
TYPE(mclb_addNF1)
mov (%rdx), %rax
add (%r8), %rax
mov %rax, (%rcx)
ret
SIZE(mclb_addNF1)
.align 16
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
.align 16
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
.align 16
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
.align 16
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
.align 16
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
.align 16
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
.align 16
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
.align 16
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
.align 16
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
.align 16
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
.align 16
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
.align 16
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
.align 16
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
.align 16
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
.align 16
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
.align 16
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
.align 16
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
.align 16
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
.align 16
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
.align 16
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
.align 16
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
.align 16
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
.align 16
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
.align 16
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
.align 16
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
.align 16
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
.align 16
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
.align 16
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
.align 16
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
.align 16
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
.align 16
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
.align 16
.global PRE(mclb_mulUnit_fast1)
PRE(mclb_mulUnit_fast1):
TYPE(mclb_mulUnit_fast1)
mov (%rdx), %rax
mul %r8
mov %rax, (%rcx)
mov %rdx, %rax
ret
SIZE(mclb_mulUnit_fast1)
.align 16
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
.align 16
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
.align 16
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
.align 16
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
.align 16
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
.align 16
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
.align 16
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
.align 16
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
.align 16
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
.align 16
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
.align 16
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
.align 16
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
.align 16
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
.align 16
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
.align 16
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
.align 16
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
.align 16
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
.align 16
.global PRE(mclb_mulUnit_slow1)
PRE(mclb_mulUnit_slow1):
TYPE(mclb_mulUnit_slow1)
mov (%rdx), %rax
mul %r8
mov %rax, (%rcx)
mov %rdx, %rax
ret
SIZE(mclb_mulUnit_slow1)
.align 16
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
.align 16
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
.align 16
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
.align 16
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
.align 16
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
.align 16
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
.align 16
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
.align 16
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
.align 16
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
.align 16
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
.align 16
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
.align 16
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
.align 16
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
.align 16
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
.align 16
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
.align 16
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
.align 16
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
.align 16
.global PRE(mclb_mul_fast1)
PRE(mclb_mul_fast1):
TYPE(mclb_mul_fast1)
mov %rdx, %r11
mov (%r11), %rdx
mulx (%r8), %rax, %r9
mov %rax, (%rcx)
adc $0, %r9
mov %r9, 8(%rcx)
ret
SIZE(mclb_mul_fast1)
.align 16
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
.align 16
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
.align 16
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
.align 16
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
.align 16
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
.align 16
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
.align 16
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
.align 16
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
.align 16
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
.align 16
.global PRE(mclb_sqr_fast2)
PRE(mclb_sqr_fast2):
TYPE(mclb_sqr_fast2)
mov %rdx, %r8
jmp PRE(mclb_mul_fast2)
SIZE(mclb_sqr_fast2)
.align 16
.global PRE(mclb_sqr_fast3)
PRE(mclb_sqr_fast3):
TYPE(mclb_sqr_fast3)
mov %rdx, %r8
jmp PRE(mclb_mul_fast3)
SIZE(mclb_sqr_fast3)
.align 16
.global PRE(mclb_sqr_fast4)
PRE(mclb_sqr_fast4):
TYPE(mclb_sqr_fast4)
mov %rdx, %r8
jmp PRE(mclb_mul_fast4)
SIZE(mclb_sqr_fast4)
.align 16
.global PRE(mclb_sqr_fast5)
PRE(mclb_sqr_fast5):
TYPE(mclb_sqr_fast5)
mov %rdx, %r8
jmp PRE(mclb_mul_fast5)
SIZE(mclb_sqr_fast5)
.align 16
.global PRE(mclb_sqr_fast6)
PRE(mclb_sqr_fast6):
TYPE(mclb_sqr_fast6)
mov %rdx, %r8
jmp PRE(mclb_mul_fast6)
SIZE(mclb_sqr_fast6)
.align 16
.global PRE(mclb_sqr_fast7)
PRE(mclb_sqr_fast7):
TYPE(mclb_sqr_fast7)
mov %rdx, %r8
jmp PRE(mclb_mul_fast7)
SIZE(mclb_sqr_fast7)
.align 16
.global PRE(mclb_sqr_fast8)
PRE(mclb_sqr_fast8):
TYPE(mclb_sqr_fast8)
mov %rdx, %r8
jmp PRE(mclb_mul_fast8)
SIZE(mclb_sqr_fast8)
.align 16
.global PRE(mclb_sqr_fast9)
PRE(mclb_sqr_fast9):
TYPE(mclb_sqr_fast9)
mov %rdx, %r8
jmp PRE(mclb_mul_fast9)
SIZE(mclb_sqr_fast9)
.align 16
.global PRE(mclb_udiv128)
PRE(mclb_udiv128):
TYPE(mclb_udiv128)
mov %rdx, %rax
mov %rcx, %rdx
div %r8
mov %rdx, (%r9)
ret
SIZE(mclb_udiv128)
