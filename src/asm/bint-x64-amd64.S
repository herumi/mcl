# for gas
#ifdef __linux__
  #define PRE(x) x
  #define TYPE(x) .type x, @function
  #define SIZE(x) .size x, .-x
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
mov (%rsi), %rax
add (%rdx), %rax
mov %rax, (%rdi)
setc %al
movzx %al, %eax
ret
SIZE(mclb_add1)
.align 16
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
.align 16
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
.align 16
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
.align 16
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
.align 16
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
.align 16
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
.align 16
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
.align 16
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
.align 16
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
.align 16
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
.align 16
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
.align 16
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
.align 16
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
.align 16
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
.align 16
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
.align 16
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
.align 16
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
.align 16
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
.align 16
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
.align 16
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
.align 16
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
.align 16
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
.align 16
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
.align 16
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
.align 16
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
.align 16
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
.align 16
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
.align 16
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
.align 16
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
.align 16
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
.align 16
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
.align 16
.global PRE(mclb_addNF1)
PRE(mclb_addNF1):
TYPE(mclb_addNF1)
mov (%rsi), %rax
add (%rdx), %rax
mov %rax, (%rdi)
ret
SIZE(mclb_addNF1)
.align 16
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
.align 16
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
.align 16
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
.align 16
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
.align 16
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
.align 16
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
.align 16
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
.align 16
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
.align 16
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
.align 16
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
.align 16
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
.align 16
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
.align 16
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
.align 16
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
.align 16
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
.align 16
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
.align 16
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
.align 16
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
.align 16
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
.align 16
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
.align 16
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
.align 16
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
.align 16
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
.align 16
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
.align 16
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
.align 16
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
.align 16
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
.align 16
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
.align 16
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
.align 16
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
.align 16
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
.align 16
.global PRE(mclb_mulUnit_fast1)
PRE(mclb_mulUnit_fast1):
TYPE(mclb_mulUnit_fast1)
mov (%rsi), %rax
mul %rdx
mov %rax, (%rdi)
mov %rdx, %rax
ret
SIZE(mclb_mulUnit_fast1)
.align 16
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
.align 16
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
.align 16
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
.align 16
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
.align 16
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
.align 16
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
.align 16
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
.align 16
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
.align 16
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
.align 16
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
.align 16
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
.align 16
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
.align 16
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
.align 16
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
.align 16
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
.align 16
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
.align 16
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
.align 16
.global PRE(mclb_mulUnit_slow1)
PRE(mclb_mulUnit_slow1):
TYPE(mclb_mulUnit_slow1)
mov (%rsi), %rax
mul %rdx
mov %rax, (%rdi)
mov %rdx, %rax
ret
SIZE(mclb_mulUnit_slow1)
.align 16
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
.align 16
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
.align 16
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
.align 16
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
.align 16
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
.align 16
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
.align 16
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
.align 16
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
.align 16
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
.align 16
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
.align 16
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
.align 16
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
.align 16
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
.align 16
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
.align 16
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
.align 16
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
.align 16
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
.align 16
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
.align 16
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
.align 16
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
.align 16
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
.align 16
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
.align 16
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
.align 16
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
.align 16
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
.align 16
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
.align 16
.global PRE(mclb_sqr_fast1)
PRE(mclb_sqr_fast1):
TYPE(mclb_sqr_fast1)
mov (%rsi), %rax
mul %rax
mov %rax, (%rdi)
mov %rdx, 8(%rdi)
ret
SIZE(mclb_sqr_fast1)
.align 16
.global PRE(mclb_sqr_fast2)
PRE(mclb_sqr_fast2):
TYPE(mclb_sqr_fast2)
mov %rsi, %rdx
jmp PRE(mclb_mul_fast2)
SIZE(mclb_sqr_fast2)
.align 16
.global PRE(mclb_sqr_fast3)
PRE(mclb_sqr_fast3):
TYPE(mclb_sqr_fast3)
mov %rsi, %rdx
jmp PRE(mclb_mul_fast3)
SIZE(mclb_sqr_fast3)
.align 16
.global PRE(mclb_sqr_fast4)
PRE(mclb_sqr_fast4):
TYPE(mclb_sqr_fast4)
mov %rsi, %rdx
jmp PRE(mclb_mul_fast4)
SIZE(mclb_sqr_fast4)
.align 16
.global PRE(mclb_sqr_fast5)
PRE(mclb_sqr_fast5):
TYPE(mclb_sqr_fast5)
mov %rsi, %rdx
jmp PRE(mclb_mul_fast5)
SIZE(mclb_sqr_fast5)
.align 16
.global PRE(mclb_sqr_fast6)
PRE(mclb_sqr_fast6):
TYPE(mclb_sqr_fast6)
mov %rsi, %rdx
jmp PRE(mclb_mul_fast6)
SIZE(mclb_sqr_fast6)
.align 16
.global PRE(mclb_sqr_fast7)
PRE(mclb_sqr_fast7):
TYPE(mclb_sqr_fast7)
mov %rsi, %rdx
jmp PRE(mclb_mul_fast7)
SIZE(mclb_sqr_fast7)
.align 16
.global PRE(mclb_sqr_fast8)
PRE(mclb_sqr_fast8):
TYPE(mclb_sqr_fast8)
mov %rsi, %rdx
jmp PRE(mclb_mul_fast8)
SIZE(mclb_sqr_fast8)
.align 16
.global PRE(mclb_sqr_fast9)
PRE(mclb_sqr_fast9):
TYPE(mclb_sqr_fast9)
mov %rsi, %rdx
jmp PRE(mclb_mul_fast9)
SIZE(mclb_sqr_fast9)
