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
PRE(mclb_fast_flag):
.byte 0
.text
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
.global PRE(mclb_mulUnit_fast10)
PRE(mclb_mulUnit_fast10):
TYPE(mclb_mulUnit_fast10)
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
mulx 64(%r11), %rax, %r10
adc %r9, %rax
mov %rax, 64(%rcx)
mulx 72(%r11), %rdx, %rax
adc %r10, %rdx
mov %rdx, 72(%rcx)
adc $0, %rax
ret
SIZE(mclb_mulUnit_fast10)
.balign 16
.global PRE(mclb_mulUnit_fast11)
PRE(mclb_mulUnit_fast11):
TYPE(mclb_mulUnit_fast11)
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
mulx 64(%r11), %rax, %r10
adc %r9, %rax
mov %rax, 64(%rcx)
mulx 72(%r11), %rax, %r9
adc %r10, %rax
mov %rax, 72(%rcx)
mulx 80(%r11), %rdx, %rax
adc %r9, %rdx
mov %rdx, 80(%rcx)
adc $0, %rax
ret
SIZE(mclb_mulUnit_fast11)
.balign 16
.global PRE(mclb_mulUnit_fast12)
PRE(mclb_mulUnit_fast12):
TYPE(mclb_mulUnit_fast12)
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
mulx 64(%r11), %rax, %r10
adc %r9, %rax
mov %rax, 64(%rcx)
mulx 72(%r11), %rax, %r9
adc %r10, %rax
mov %rax, 72(%rcx)
mulx 80(%r11), %rax, %r10
adc %r9, %rax
mov %rax, 80(%rcx)
mulx 88(%r11), %rdx, %rax
adc %r10, %rdx
mov %rdx, 88(%rcx)
adc $0, %rax
ret
SIZE(mclb_mulUnit_fast12)
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
.global PRE(mclb_mulUnitAdd_fast10)
PRE(mclb_mulUnitAdd_fast10):
TYPE(mclb_mulUnitAdd_fast10)
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
mov 72(%rcx), %r9
adcx %rax, %r9
mulx 72(%r11), %r10, %rax
adox %r10, %r9
mov %r9, 72(%rcx)
mov $0, %r9
adcx %r9, %rax
adox %r9, %rax
ret
SIZE(mclb_mulUnitAdd_fast10)
.balign 16
.global PRE(mclb_mulUnitAdd_fast11)
PRE(mclb_mulUnitAdd_fast11):
TYPE(mclb_mulUnitAdd_fast11)
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
mov 72(%rcx), %r9
adcx %rax, %r9
mulx 72(%r11), %r10, %rax
adox %r10, %r9
mov %r9, 72(%rcx)
mov 80(%rcx), %r9
adcx %rax, %r9
mulx 80(%r11), %r10, %rax
adox %r10, %r9
mov %r9, 80(%rcx)
mov $0, %r9
adcx %r9, %rax
adox %r9, %rax
ret
SIZE(mclb_mulUnitAdd_fast11)
.balign 16
.global PRE(mclb_mulUnitAdd_fast12)
PRE(mclb_mulUnitAdd_fast12):
TYPE(mclb_mulUnitAdd_fast12)
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
mov 72(%rcx), %r9
adcx %rax, %r9
mulx 72(%r11), %r10, %rax
adox %r10, %r9
mov %r9, 72(%rcx)
mov 80(%rcx), %r9
adcx %rax, %r9
mulx 80(%r11), %r10, %rax
adox %r10, %r9
mov %r9, 80(%rcx)
mov 88(%rcx), %r9
adcx %rax, %r9
mulx 88(%r11), %r10, %rax
adox %r10, %r9
mov %r9, 88(%rcx)
mov $0, %r9
adcx %r9, %rax
adox %r9, %rax
ret
SIZE(mclb_mulUnitAdd_fast12)
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
.global PRE(mclb_mulUnit_slow10)
PRE(mclb_mulUnit_slow10):
TYPE(mclb_mulUnit_slow10)
sub $152, %rsp
mov %rdx, %r11
mov (%r11), %rax
mul %r8
mov %rax, (%rcx)
mov %rdx, 72(%rsp)
mov 8(%r11), %rax
mul %r8
mov %rax, (%rsp)
mov %rdx, 80(%rsp)
mov 16(%r11), %rax
mul %r8
mov %rax, 8(%rsp)
mov %rdx, 88(%rsp)
mov 24(%r11), %rax
mul %r8
mov %rax, 16(%rsp)
mov %rdx, 96(%rsp)
mov 32(%r11), %rax
mul %r8
mov %rax, 24(%rsp)
mov %rdx, 104(%rsp)
mov 40(%r11), %rax
mul %r8
mov %rax, 32(%rsp)
mov %rdx, 112(%rsp)
mov 48(%r11), %rax
mul %r8
mov %rax, 40(%rsp)
mov %rdx, 120(%rsp)
mov 56(%r11), %rax
mul %r8
mov %rax, 48(%rsp)
mov %rdx, 128(%rsp)
mov 64(%r11), %rax
mul %r8
mov %rax, 56(%rsp)
mov %rdx, 136(%rsp)
mov 72(%r11), %rax
mul %r8
mov %rax, 64(%rsp)
mov 72(%rsp), %rax
add (%rsp), %rax
mov %rax, 8(%rcx)
mov 80(%rsp), %rax
adc 8(%rsp), %rax
mov %rax, 16(%rcx)
mov 88(%rsp), %rax
adc 16(%rsp), %rax
mov %rax, 24(%rcx)
mov 96(%rsp), %rax
adc 24(%rsp), %rax
mov %rax, 32(%rcx)
mov 104(%rsp), %rax
adc 32(%rsp), %rax
mov %rax, 40(%rcx)
mov 112(%rsp), %rax
adc 40(%rsp), %rax
mov %rax, 48(%rcx)
mov 120(%rsp), %rax
adc 48(%rsp), %rax
mov %rax, 56(%rcx)
mov 128(%rsp), %rax
adc 56(%rsp), %rax
mov %rax, 64(%rcx)
mov 136(%rsp), %rax
adc 64(%rsp), %rax
mov %rax, 72(%rcx)
adc $0, %rdx
mov %rdx, %rax
add $152, %rsp
ret
SIZE(mclb_mulUnit_slow10)
.balign 16
.global PRE(mclb_mulUnit_slow11)
PRE(mclb_mulUnit_slow11):
TYPE(mclb_mulUnit_slow11)
sub $168, %rsp
mov %rdx, %r11
mov (%r11), %rax
mul %r8
mov %rax, (%rcx)
mov %rdx, 80(%rsp)
mov 8(%r11), %rax
mul %r8
mov %rax, (%rsp)
mov %rdx, 88(%rsp)
mov 16(%r11), %rax
mul %r8
mov %rax, 8(%rsp)
mov %rdx, 96(%rsp)
mov 24(%r11), %rax
mul %r8
mov %rax, 16(%rsp)
mov %rdx, 104(%rsp)
mov 32(%r11), %rax
mul %r8
mov %rax, 24(%rsp)
mov %rdx, 112(%rsp)
mov 40(%r11), %rax
mul %r8
mov %rax, 32(%rsp)
mov %rdx, 120(%rsp)
mov 48(%r11), %rax
mul %r8
mov %rax, 40(%rsp)
mov %rdx, 128(%rsp)
mov 56(%r11), %rax
mul %r8
mov %rax, 48(%rsp)
mov %rdx, 136(%rsp)
mov 64(%r11), %rax
mul %r8
mov %rax, 56(%rsp)
mov %rdx, 144(%rsp)
mov 72(%r11), %rax
mul %r8
mov %rax, 64(%rsp)
mov %rdx, 152(%rsp)
mov 80(%r11), %rax
mul %r8
mov %rax, 72(%rsp)
mov 80(%rsp), %rax
add (%rsp), %rax
mov %rax, 8(%rcx)
mov 88(%rsp), %rax
adc 8(%rsp), %rax
mov %rax, 16(%rcx)
mov 96(%rsp), %rax
adc 16(%rsp), %rax
mov %rax, 24(%rcx)
mov 104(%rsp), %rax
adc 24(%rsp), %rax
mov %rax, 32(%rcx)
mov 112(%rsp), %rax
adc 32(%rsp), %rax
mov %rax, 40(%rcx)
mov 120(%rsp), %rax
adc 40(%rsp), %rax
mov %rax, 48(%rcx)
mov 128(%rsp), %rax
adc 48(%rsp), %rax
mov %rax, 56(%rcx)
mov 136(%rsp), %rax
adc 56(%rsp), %rax
mov %rax, 64(%rcx)
mov 144(%rsp), %rax
adc 64(%rsp), %rax
mov %rax, 72(%rcx)
mov 152(%rsp), %rax
adc 72(%rsp), %rax
mov %rax, 80(%rcx)
adc $0, %rdx
mov %rdx, %rax
add $168, %rsp
ret
SIZE(mclb_mulUnit_slow11)
.balign 16
.global PRE(mclb_mulUnit_slow12)
PRE(mclb_mulUnit_slow12):
TYPE(mclb_mulUnit_slow12)
sub $184, %rsp
mov %rdx, %r11
mov (%r11), %rax
mul %r8
mov %rax, (%rcx)
mov %rdx, 88(%rsp)
mov 8(%r11), %rax
mul %r8
mov %rax, (%rsp)
mov %rdx, 96(%rsp)
mov 16(%r11), %rax
mul %r8
mov %rax, 8(%rsp)
mov %rdx, 104(%rsp)
mov 24(%r11), %rax
mul %r8
mov %rax, 16(%rsp)
mov %rdx, 112(%rsp)
mov 32(%r11), %rax
mul %r8
mov %rax, 24(%rsp)
mov %rdx, 120(%rsp)
mov 40(%r11), %rax
mul %r8
mov %rax, 32(%rsp)
mov %rdx, 128(%rsp)
mov 48(%r11), %rax
mul %r8
mov %rax, 40(%rsp)
mov %rdx, 136(%rsp)
mov 56(%r11), %rax
mul %r8
mov %rax, 48(%rsp)
mov %rdx, 144(%rsp)
mov 64(%r11), %rax
mul %r8
mov %rax, 56(%rsp)
mov %rdx, 152(%rsp)
mov 72(%r11), %rax
mul %r8
mov %rax, 64(%rsp)
mov %rdx, 160(%rsp)
mov 80(%r11), %rax
mul %r8
mov %rax, 72(%rsp)
mov %rdx, 168(%rsp)
mov 88(%r11), %rax
mul %r8
mov %rax, 80(%rsp)
mov 88(%rsp), %rax
add (%rsp), %rax
mov %rax, 8(%rcx)
mov 96(%rsp), %rax
adc 8(%rsp), %rax
mov %rax, 16(%rcx)
mov 104(%rsp), %rax
adc 16(%rsp), %rax
mov %rax, 24(%rcx)
mov 112(%rsp), %rax
adc 24(%rsp), %rax
mov %rax, 32(%rcx)
mov 120(%rsp), %rax
adc 32(%rsp), %rax
mov %rax, 40(%rcx)
mov 128(%rsp), %rax
adc 40(%rsp), %rax
mov %rax, 48(%rcx)
mov 136(%rsp), %rax
adc 48(%rsp), %rax
mov %rax, 56(%rcx)
mov 144(%rsp), %rax
adc 56(%rsp), %rax
mov %rax, 64(%rcx)
mov 152(%rsp), %rax
adc 64(%rsp), %rax
mov %rax, 72(%rcx)
mov 160(%rsp), %rax
adc 72(%rsp), %rax
mov %rax, 80(%rcx)
mov 168(%rsp), %rax
adc 80(%rsp), %rax
mov %rax, 88(%rcx)
adc $0, %rdx
mov %rdx, %rax
add $184, %rsp
ret
SIZE(mclb_mulUnit_slow12)
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
.global PRE(mclb_mulUnitAdd_slow10)
PRE(mclb_mulUnitAdd_slow10):
TYPE(mclb_mulUnitAdd_slow10)
sub $152, %rsp
mov %rdx, %r11
mov (%r11), %rax
mul %r8
mov %rax, (%rsp)
mov %rdx, 80(%rsp)
mov 8(%r11), %rax
mul %r8
mov %rax, 8(%rsp)
mov %rdx, 88(%rsp)
mov 16(%r11), %rax
mul %r8
mov %rax, 16(%rsp)
mov %rdx, 96(%rsp)
mov 24(%r11), %rax
mul %r8
mov %rax, 24(%rsp)
mov %rdx, 104(%rsp)
mov 32(%r11), %rax
mul %r8
mov %rax, 32(%rsp)
mov %rdx, 112(%rsp)
mov 40(%r11), %rax
mul %r8
mov %rax, 40(%rsp)
mov %rdx, 120(%rsp)
mov 48(%r11), %rax
mul %r8
mov %rax, 48(%rsp)
mov %rdx, 128(%rsp)
mov 56(%r11), %rax
mul %r8
mov %rax, 56(%rsp)
mov %rdx, 136(%rsp)
mov 64(%r11), %rax
mul %r8
mov %rax, 64(%rsp)
mov %rdx, 144(%rsp)
mov 72(%r11), %rax
mul %r8
mov %rax, 72(%rsp)
mov 8(%rsp), %rax
add 80(%rsp), %rax
mov %rax, 8(%rsp)
mov 16(%rsp), %rax
adc 88(%rsp), %rax
mov %rax, 16(%rsp)
mov 24(%rsp), %rax
adc 96(%rsp), %rax
mov %rax, 24(%rsp)
mov 32(%rsp), %rax
adc 104(%rsp), %rax
mov %rax, 32(%rsp)
mov 40(%rsp), %rax
adc 112(%rsp), %rax
mov %rax, 40(%rsp)
mov 48(%rsp), %rax
adc 120(%rsp), %rax
mov %rax, 48(%rsp)
mov 56(%rsp), %rax
adc 128(%rsp), %rax
mov %rax, 56(%rsp)
mov 64(%rsp), %rax
adc 136(%rsp), %rax
mov %rax, 64(%rsp)
mov 72(%rsp), %rax
adc 144(%rsp), %rax
mov %rax, 72(%rsp)
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
mov 72(%rsp), %rax
adc %rax, 72(%rcx)
adc $0, %rdx
mov %rdx, %rax
add $152, %rsp
ret
SIZE(mclb_mulUnitAdd_slow10)
.balign 16
.global PRE(mclb_mulUnitAdd_slow11)
PRE(mclb_mulUnitAdd_slow11):
TYPE(mclb_mulUnitAdd_slow11)
sub $168, %rsp
mov %rdx, %r11
mov (%r11), %rax
mul %r8
mov %rax, (%rsp)
mov %rdx, 88(%rsp)
mov 8(%r11), %rax
mul %r8
mov %rax, 8(%rsp)
mov %rdx, 96(%rsp)
mov 16(%r11), %rax
mul %r8
mov %rax, 16(%rsp)
mov %rdx, 104(%rsp)
mov 24(%r11), %rax
mul %r8
mov %rax, 24(%rsp)
mov %rdx, 112(%rsp)
mov 32(%r11), %rax
mul %r8
mov %rax, 32(%rsp)
mov %rdx, 120(%rsp)
mov 40(%r11), %rax
mul %r8
mov %rax, 40(%rsp)
mov %rdx, 128(%rsp)
mov 48(%r11), %rax
mul %r8
mov %rax, 48(%rsp)
mov %rdx, 136(%rsp)
mov 56(%r11), %rax
mul %r8
mov %rax, 56(%rsp)
mov %rdx, 144(%rsp)
mov 64(%r11), %rax
mul %r8
mov %rax, 64(%rsp)
mov %rdx, 152(%rsp)
mov 72(%r11), %rax
mul %r8
mov %rax, 72(%rsp)
mov %rdx, 160(%rsp)
mov 80(%r11), %rax
mul %r8
mov %rax, 80(%rsp)
mov 8(%rsp), %rax
add 88(%rsp), %rax
mov %rax, 8(%rsp)
mov 16(%rsp), %rax
adc 96(%rsp), %rax
mov %rax, 16(%rsp)
mov 24(%rsp), %rax
adc 104(%rsp), %rax
mov %rax, 24(%rsp)
mov 32(%rsp), %rax
adc 112(%rsp), %rax
mov %rax, 32(%rsp)
mov 40(%rsp), %rax
adc 120(%rsp), %rax
mov %rax, 40(%rsp)
mov 48(%rsp), %rax
adc 128(%rsp), %rax
mov %rax, 48(%rsp)
mov 56(%rsp), %rax
adc 136(%rsp), %rax
mov %rax, 56(%rsp)
mov 64(%rsp), %rax
adc 144(%rsp), %rax
mov %rax, 64(%rsp)
mov 72(%rsp), %rax
adc 152(%rsp), %rax
mov %rax, 72(%rsp)
mov 80(%rsp), %rax
adc 160(%rsp), %rax
mov %rax, 80(%rsp)
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
mov 72(%rsp), %rax
adc %rax, 72(%rcx)
mov 80(%rsp), %rax
adc %rax, 80(%rcx)
adc $0, %rdx
mov %rdx, %rax
add $168, %rsp
ret
SIZE(mclb_mulUnitAdd_slow11)
.balign 16
.global PRE(mclb_mulUnitAdd_slow12)
PRE(mclb_mulUnitAdd_slow12):
TYPE(mclb_mulUnitAdd_slow12)
sub $184, %rsp
mov %rdx, %r11
mov (%r11), %rax
mul %r8
mov %rax, (%rsp)
mov %rdx, 96(%rsp)
mov 8(%r11), %rax
mul %r8
mov %rax, 8(%rsp)
mov %rdx, 104(%rsp)
mov 16(%r11), %rax
mul %r8
mov %rax, 16(%rsp)
mov %rdx, 112(%rsp)
mov 24(%r11), %rax
mul %r8
mov %rax, 24(%rsp)
mov %rdx, 120(%rsp)
mov 32(%r11), %rax
mul %r8
mov %rax, 32(%rsp)
mov %rdx, 128(%rsp)
mov 40(%r11), %rax
mul %r8
mov %rax, 40(%rsp)
mov %rdx, 136(%rsp)
mov 48(%r11), %rax
mul %r8
mov %rax, 48(%rsp)
mov %rdx, 144(%rsp)
mov 56(%r11), %rax
mul %r8
mov %rax, 56(%rsp)
mov %rdx, 152(%rsp)
mov 64(%r11), %rax
mul %r8
mov %rax, 64(%rsp)
mov %rdx, 160(%rsp)
mov 72(%r11), %rax
mul %r8
mov %rax, 72(%rsp)
mov %rdx, 168(%rsp)
mov 80(%r11), %rax
mul %r8
mov %rax, 80(%rsp)
mov %rdx, 176(%rsp)
mov 88(%r11), %rax
mul %r8
mov %rax, 88(%rsp)
mov 8(%rsp), %rax
add 96(%rsp), %rax
mov %rax, 8(%rsp)
mov 16(%rsp), %rax
adc 104(%rsp), %rax
mov %rax, 16(%rsp)
mov 24(%rsp), %rax
adc 112(%rsp), %rax
mov %rax, 24(%rsp)
mov 32(%rsp), %rax
adc 120(%rsp), %rax
mov %rax, 32(%rsp)
mov 40(%rsp), %rax
adc 128(%rsp), %rax
mov %rax, 40(%rsp)
mov 48(%rsp), %rax
adc 136(%rsp), %rax
mov %rax, 48(%rsp)
mov 56(%rsp), %rax
adc 144(%rsp), %rax
mov %rax, 56(%rsp)
mov 64(%rsp), %rax
adc 152(%rsp), %rax
mov %rax, 64(%rsp)
mov 72(%rsp), %rax
adc 160(%rsp), %rax
mov %rax, 72(%rsp)
mov 80(%rsp), %rax
adc 168(%rsp), %rax
mov %rax, 80(%rsp)
mov 88(%rsp), %rax
adc 176(%rsp), %rax
mov %rax, 88(%rsp)
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
mov 72(%rsp), %rax
adc %rax, 72(%rcx)
mov 80(%rsp), %rax
adc %rax, 80(%rcx)
mov 88(%rsp), %rax
adc %rax, 88(%rcx)
adc $0, %rdx
mov %rdx, %rax
add $184, %rsp
ret
SIZE(mclb_mulUnitAdd_slow12)
.balign 16
.global PRE(mclb_mul_slow1)
PRE(mclb_mul_slow1):
TYPE(mclb_mul_slow1)
mov %rdx, %r11
mov (%r11), %rax
mov (%r8), %rdx
mul %rdx
mov %rax, (%rcx)
mov %rdx, 8(%rcx)
ret
SIZE(mclb_mul_slow1)
.balign 16
.global PRE(mclb_mul_slow2)
PRE(mclb_mul_slow2):
TYPE(mclb_mul_slow2)
push %rdi
mov %rdx, %r11
mov (%r11), %rax
mulq (%r8)
mov %rax, %r9
mov %rdx, %r10
xor %rdi, %rdi
mov %r9, (%rcx)
xor %r9, %r9
mov (%r11), %rax
mulq 8(%r8)
add %rax, %r10
adc %rdx, %rdi
adc $0, %r9
mov 8(%r11), %rax
mulq (%r8)
add %rax, %r10
adc %rdx, %rdi
adc $0, %r9
mov %r10, 8(%rcx)
xor %r10, %r10
mov 8(%r11), %rax
mulq 8(%r8)
add %rax, %rdi
adc %rdx, %r9
adc $0, %r10
mov %rdi, 16(%rcx)
mov %r9, 24(%rcx)
pop %rdi
ret
SIZE(mclb_mul_slow2)
.balign 16
.global PRE(mclb_mul_slow3)
PRE(mclb_mul_slow3):
TYPE(mclb_mul_slow3)
push %rdi
mov %rdx, %r11
mov (%r11), %rax
mulq (%r8)
mov %rax, %r9
mov %rdx, %r10
xor %rdi, %rdi
mov %r9, (%rcx)
xor %r9, %r9
mov (%r11), %rax
mulq 8(%r8)
add %rax, %r10
adc %rdx, %rdi
adc $0, %r9
mov 8(%r11), %rax
mulq (%r8)
add %rax, %r10
adc %rdx, %rdi
adc $0, %r9
mov %r10, 8(%rcx)
xor %r10, %r10
mov (%r11), %rax
mulq 16(%r8)
add %rax, %rdi
adc %rdx, %r9
adc $0, %r10
mov 8(%r11), %rax
mulq 8(%r8)
add %rax, %rdi
adc %rdx, %r9
adc $0, %r10
mov 16(%r11), %rax
mulq (%r8)
add %rax, %rdi
adc %rdx, %r9
adc $0, %r10
mov %rdi, 16(%rcx)
xor %rdi, %rdi
mov 8(%r11), %rax
mulq 16(%r8)
add %rax, %r9
adc %rdx, %r10
adc $0, %rdi
mov 16(%r11), %rax
mulq 8(%r8)
add %rax, %r9
adc %rdx, %r10
adc $0, %rdi
mov %r9, 24(%rcx)
xor %r9, %r9
mov 16(%r11), %rax
mulq 16(%r8)
add %rax, %r10
adc %rdx, %rdi
adc $0, %r9
mov %r10, 32(%rcx)
mov %rdi, 40(%rcx)
pop %rdi
ret
SIZE(mclb_mul_slow3)
.balign 16
.global PRE(mclb_mul_slow4)
PRE(mclb_mul_slow4):
TYPE(mclb_mul_slow4)
push %rdi
mov %rdx, %r11
mov (%r11), %rax
mulq (%r8)
mov %rax, %r9
mov %rdx, %r10
xor %rdi, %rdi
mov %r9, (%rcx)
xor %r9, %r9
mov (%r11), %rax
mulq 8(%r8)
add %rax, %r10
adc %rdx, %rdi
adc $0, %r9
mov 8(%r11), %rax
mulq (%r8)
add %rax, %r10
adc %rdx, %rdi
adc $0, %r9
mov %r10, 8(%rcx)
xor %r10, %r10
mov (%r11), %rax
mulq 16(%r8)
add %rax, %rdi
adc %rdx, %r9
adc $0, %r10
mov 8(%r11), %rax
mulq 8(%r8)
add %rax, %rdi
adc %rdx, %r9
adc $0, %r10
mov 16(%r11), %rax
mulq (%r8)
add %rax, %rdi
adc %rdx, %r9
adc $0, %r10
mov %rdi, 16(%rcx)
xor %rdi, %rdi
mov (%r11), %rax
mulq 24(%r8)
add %rax, %r9
adc %rdx, %r10
adc $0, %rdi
mov 8(%r11), %rax
mulq 16(%r8)
add %rax, %r9
adc %rdx, %r10
adc $0, %rdi
mov 16(%r11), %rax
mulq 8(%r8)
add %rax, %r9
adc %rdx, %r10
adc $0, %rdi
mov 24(%r11), %rax
mulq (%r8)
add %rax, %r9
adc %rdx, %r10
adc $0, %rdi
mov %r9, 24(%rcx)
xor %r9, %r9
mov 8(%r11), %rax
mulq 24(%r8)
add %rax, %r10
adc %rdx, %rdi
adc $0, %r9
mov 16(%r11), %rax
mulq 16(%r8)
add %rax, %r10
adc %rdx, %rdi
adc $0, %r9
mov 24(%r11), %rax
mulq 8(%r8)
add %rax, %r10
adc %rdx, %rdi
adc $0, %r9
mov %r10, 32(%rcx)
xor %r10, %r10
mov 16(%r11), %rax
mulq 24(%r8)
add %rax, %rdi
adc %rdx, %r9
adc $0, %r10
mov 24(%r11), %rax
mulq 16(%r8)
add %rax, %rdi
adc %rdx, %r9
adc $0, %r10
mov %rdi, 40(%rcx)
xor %rdi, %rdi
mov 24(%r11), %rax
mulq 24(%r8)
add %rax, %r9
adc %rdx, %r10
adc $0, %rdi
mov %r9, 48(%rcx)
mov %r10, 56(%rcx)
pop %rdi
ret
SIZE(mclb_mul_slow4)
.balign 16
.global PRE(mclb_mul_slow5)
PRE(mclb_mul_slow5):
TYPE(mclb_mul_slow5)
push %rdi
mov %rdx, %r11
mov (%r11), %rax
mulq (%r8)
mov %rax, %r9
mov %rdx, %r10
xor %rdi, %rdi
mov %r9, (%rcx)
xor %r9, %r9
mov (%r11), %rax
mulq 8(%r8)
add %rax, %r10
adc %rdx, %rdi
adc $0, %r9
mov 8(%r11), %rax
mulq (%r8)
add %rax, %r10
adc %rdx, %rdi
adc $0, %r9
mov %r10, 8(%rcx)
xor %r10, %r10
mov (%r11), %rax
mulq 16(%r8)
add %rax, %rdi
adc %rdx, %r9
adc $0, %r10
mov 8(%r11), %rax
mulq 8(%r8)
add %rax, %rdi
adc %rdx, %r9
adc $0, %r10
mov 16(%r11), %rax
mulq (%r8)
add %rax, %rdi
adc %rdx, %r9
adc $0, %r10
mov %rdi, 16(%rcx)
xor %rdi, %rdi
mov (%r11), %rax
mulq 24(%r8)
add %rax, %r9
adc %rdx, %r10
adc $0, %rdi
mov 8(%r11), %rax
mulq 16(%r8)
add %rax, %r9
adc %rdx, %r10
adc $0, %rdi
mov 16(%r11), %rax
mulq 8(%r8)
add %rax, %r9
adc %rdx, %r10
adc $0, %rdi
mov 24(%r11), %rax
mulq (%r8)
add %rax, %r9
adc %rdx, %r10
adc $0, %rdi
mov %r9, 24(%rcx)
xor %r9, %r9
mov (%r11), %rax
mulq 32(%r8)
add %rax, %r10
adc %rdx, %rdi
adc $0, %r9
mov 8(%r11), %rax
mulq 24(%r8)
add %rax, %r10
adc %rdx, %rdi
adc $0, %r9
mov 16(%r11), %rax
mulq 16(%r8)
add %rax, %r10
adc %rdx, %rdi
adc $0, %r9
mov 24(%r11), %rax
mulq 8(%r8)
add %rax, %r10
adc %rdx, %rdi
adc $0, %r9
mov 32(%r11), %rax
mulq (%r8)
add %rax, %r10
adc %rdx, %rdi
adc $0, %r9
mov %r10, 32(%rcx)
xor %r10, %r10
mov 8(%r11), %rax
mulq 32(%r8)
add %rax, %rdi
adc %rdx, %r9
adc $0, %r10
mov 16(%r11), %rax
mulq 24(%r8)
add %rax, %rdi
adc %rdx, %r9
adc $0, %r10
mov 24(%r11), %rax
mulq 16(%r8)
add %rax, %rdi
adc %rdx, %r9
adc $0, %r10
mov 32(%r11), %rax
mulq 8(%r8)
add %rax, %rdi
adc %rdx, %r9
adc $0, %r10
mov %rdi, 40(%rcx)
xor %rdi, %rdi
mov 16(%r11), %rax
mulq 32(%r8)
add %rax, %r9
adc %rdx, %r10
adc $0, %rdi
mov 24(%r11), %rax
mulq 24(%r8)
add %rax, %r9
adc %rdx, %r10
adc $0, %rdi
mov 32(%r11), %rax
mulq 16(%r8)
add %rax, %r9
adc %rdx, %r10
adc $0, %rdi
mov %r9, 48(%rcx)
xor %r9, %r9
mov 24(%r11), %rax
mulq 32(%r8)
add %rax, %r10
adc %rdx, %rdi
adc $0, %r9
mov 32(%r11), %rax
mulq 24(%r8)
add %rax, %r10
adc %rdx, %rdi
adc $0, %r9
mov %r10, 56(%rcx)
xor %r10, %r10
mov 32(%r11), %rax
mulq 32(%r8)
add %rax, %rdi
adc %rdx, %r9
adc $0, %r10
mov %rdi, 64(%rcx)
mov %r9, 72(%rcx)
pop %rdi
ret
SIZE(mclb_mul_slow5)
.balign 16
.global PRE(mclb_mul_slow6)
PRE(mclb_mul_slow6):
TYPE(mclb_mul_slow6)
push %rdi
mov %rdx, %r11
mov (%r11), %rax
mulq (%r8)
mov %rax, %r9
mov %rdx, %r10
xor %rdi, %rdi
mov %r9, (%rcx)
xor %r9, %r9
mov (%r11), %rax
mulq 8(%r8)
add %rax, %r10
adc %rdx, %rdi
adc $0, %r9
mov 8(%r11), %rax
mulq (%r8)
add %rax, %r10
adc %rdx, %rdi
adc $0, %r9
mov %r10, 8(%rcx)
xor %r10, %r10
mov (%r11), %rax
mulq 16(%r8)
add %rax, %rdi
adc %rdx, %r9
adc $0, %r10
mov 8(%r11), %rax
mulq 8(%r8)
add %rax, %rdi
adc %rdx, %r9
adc $0, %r10
mov 16(%r11), %rax
mulq (%r8)
add %rax, %rdi
adc %rdx, %r9
adc $0, %r10
mov %rdi, 16(%rcx)
xor %rdi, %rdi
mov (%r11), %rax
mulq 24(%r8)
add %rax, %r9
adc %rdx, %r10
adc $0, %rdi
mov 8(%r11), %rax
mulq 16(%r8)
add %rax, %r9
adc %rdx, %r10
adc $0, %rdi
mov 16(%r11), %rax
mulq 8(%r8)
add %rax, %r9
adc %rdx, %r10
adc $0, %rdi
mov 24(%r11), %rax
mulq (%r8)
add %rax, %r9
adc %rdx, %r10
adc $0, %rdi
mov %r9, 24(%rcx)
xor %r9, %r9
mov (%r11), %rax
mulq 32(%r8)
add %rax, %r10
adc %rdx, %rdi
adc $0, %r9
mov 8(%r11), %rax
mulq 24(%r8)
add %rax, %r10
adc %rdx, %rdi
adc $0, %r9
mov 16(%r11), %rax
mulq 16(%r8)
add %rax, %r10
adc %rdx, %rdi
adc $0, %r9
mov 24(%r11), %rax
mulq 8(%r8)
add %rax, %r10
adc %rdx, %rdi
adc $0, %r9
mov 32(%r11), %rax
mulq (%r8)
add %rax, %r10
adc %rdx, %rdi
adc $0, %r9
mov %r10, 32(%rcx)
xor %r10, %r10
mov (%r11), %rax
mulq 40(%r8)
add %rax, %rdi
adc %rdx, %r9
adc $0, %r10
mov 8(%r11), %rax
mulq 32(%r8)
add %rax, %rdi
adc %rdx, %r9
adc $0, %r10
mov 16(%r11), %rax
mulq 24(%r8)
add %rax, %rdi
adc %rdx, %r9
adc $0, %r10
mov 24(%r11), %rax
mulq 16(%r8)
add %rax, %rdi
adc %rdx, %r9
adc $0, %r10
mov 32(%r11), %rax
mulq 8(%r8)
add %rax, %rdi
adc %rdx, %r9
adc $0, %r10
mov 40(%r11), %rax
mulq (%r8)
add %rax, %rdi
adc %rdx, %r9
adc $0, %r10
mov %rdi, 40(%rcx)
xor %rdi, %rdi
mov 8(%r11), %rax
mulq 40(%r8)
add %rax, %r9
adc %rdx, %r10
adc $0, %rdi
mov 16(%r11), %rax
mulq 32(%r8)
add %rax, %r9
adc %rdx, %r10
adc $0, %rdi
mov 24(%r11), %rax
mulq 24(%r8)
add %rax, %r9
adc %rdx, %r10
adc $0, %rdi
mov 32(%r11), %rax
mulq 16(%r8)
add %rax, %r9
adc %rdx, %r10
adc $0, %rdi
mov 40(%r11), %rax
mulq 8(%r8)
add %rax, %r9
adc %rdx, %r10
adc $0, %rdi
mov %r9, 48(%rcx)
xor %r9, %r9
mov 16(%r11), %rax
mulq 40(%r8)
add %rax, %r10
adc %rdx, %rdi
adc $0, %r9
mov 24(%r11), %rax
mulq 32(%r8)
add %rax, %r10
adc %rdx, %rdi
adc $0, %r9
mov 32(%r11), %rax
mulq 24(%r8)
add %rax, %r10
adc %rdx, %rdi
adc $0, %r9
mov 40(%r11), %rax
mulq 16(%r8)
add %rax, %r10
adc %rdx, %rdi
adc $0, %r9
mov %r10, 56(%rcx)
xor %r10, %r10
mov 24(%r11), %rax
mulq 40(%r8)
add %rax, %rdi
adc %rdx, %r9
adc $0, %r10
mov 32(%r11), %rax
mulq 32(%r8)
add %rax, %rdi
adc %rdx, %r9
adc $0, %r10
mov 40(%r11), %rax
mulq 24(%r8)
add %rax, %rdi
adc %rdx, %r9
adc $0, %r10
mov %rdi, 64(%rcx)
xor %rdi, %rdi
mov 32(%r11), %rax
mulq 40(%r8)
add %rax, %r9
adc %rdx, %r10
adc $0, %rdi
mov 40(%r11), %rax
mulq 32(%r8)
add %rax, %r9
adc %rdx, %r10
adc $0, %rdi
mov %r9, 72(%rcx)
xor %r9, %r9
mov 40(%r11), %rax
mulq 40(%r8)
add %rax, %r10
adc %rdx, %rdi
adc $0, %r9
mov %r10, 80(%rcx)
mov %rdi, 88(%rcx)
pop %rdi
ret
SIZE(mclb_mul_slow6)
.balign 16
.global PRE(mclb_sqr_slow1)
PRE(mclb_sqr_slow1):
TYPE(mclb_sqr_slow1)
mov %rdx, %r11
mov (%r11), %rax
mul %rax
mov %rax, (%rcx)
mov %rdx, 8(%rcx)
ret
SIZE(mclb_sqr_slow1)
.balign 16
.global PRE(mclb_sqr_slow2)
PRE(mclb_sqr_slow2):
TYPE(mclb_sqr_slow2)
mov %rdx, %r8
jmp PRE(mclb_mul_slow2)
SIZE(mclb_sqr_slow2)
.balign 16
.global PRE(mclb_sqr_slow3)
PRE(mclb_sqr_slow3):
TYPE(mclb_sqr_slow3)
mov %rdx, %r8
jmp PRE(mclb_mul_slow3)
SIZE(mclb_sqr_slow3)
.balign 16
.global PRE(mclb_sqr_slow4)
PRE(mclb_sqr_slow4):
TYPE(mclb_sqr_slow4)
mov %rdx, %r8
jmp PRE(mclb_mul_slow4)
SIZE(mclb_sqr_slow4)
.balign 16
.global PRE(mclb_sqr_slow5)
PRE(mclb_sqr_slow5):
TYPE(mclb_sqr_slow5)
mov %rdx, %r8
jmp PRE(mclb_mul_slow5)
SIZE(mclb_sqr_slow5)
.balign 16
.global PRE(mclb_sqr_slow6)
PRE(mclb_sqr_slow6):
TYPE(mclb_sqr_slow6)
mov %rdx, %r8
jmp PRE(mclb_mul_slow6)
SIZE(mclb_sqr_slow6)
.balign 16
.global PRE(mclb_mulUnit1)
PRE(mclb_mulUnit1):
TYPE(mclb_mulUnit1)
cmpb $0, PRE(mclb_fast_flag)(%rip)
jne PRE(mclb_mulUnit_fast1)
jmp PRE(mclb_mulUnit_slow1)
SIZE(mclb_mulUnit1)
.balign 16
.global PRE(mclb_mulUnitAdd1)
PRE(mclb_mulUnitAdd1):
TYPE(mclb_mulUnitAdd1)
cmpb $0, PRE(mclb_fast_flag)(%rip)
jne PRE(mclb_mulUnitAdd_fast1)
jmp PRE(mclb_mulUnitAdd_slow1)
SIZE(mclb_mulUnitAdd1)
.balign 16
.global PRE(mclb_mulUnit2)
PRE(mclb_mulUnit2):
TYPE(mclb_mulUnit2)
cmpb $0, PRE(mclb_fast_flag)(%rip)
jne PRE(mclb_mulUnit_fast2)
jmp PRE(mclb_mulUnit_slow2)
SIZE(mclb_mulUnit2)
.balign 16
.global PRE(mclb_mulUnitAdd2)
PRE(mclb_mulUnitAdd2):
TYPE(mclb_mulUnitAdd2)
cmpb $0, PRE(mclb_fast_flag)(%rip)
jne PRE(mclb_mulUnitAdd_fast2)
jmp PRE(mclb_mulUnitAdd_slow2)
SIZE(mclb_mulUnitAdd2)
.balign 16
.global PRE(mclb_mulUnit3)
PRE(mclb_mulUnit3):
TYPE(mclb_mulUnit3)
cmpb $0, PRE(mclb_fast_flag)(%rip)
jne PRE(mclb_mulUnit_fast3)
jmp PRE(mclb_mulUnit_slow3)
SIZE(mclb_mulUnit3)
.balign 16
.global PRE(mclb_mulUnitAdd3)
PRE(mclb_mulUnitAdd3):
TYPE(mclb_mulUnitAdd3)
cmpb $0, PRE(mclb_fast_flag)(%rip)
jne PRE(mclb_mulUnitAdd_fast3)
jmp PRE(mclb_mulUnitAdd_slow3)
SIZE(mclb_mulUnitAdd3)
.balign 16
.global PRE(mclb_mulUnit4)
PRE(mclb_mulUnit4):
TYPE(mclb_mulUnit4)
cmpb $0, PRE(mclb_fast_flag)(%rip)
jne PRE(mclb_mulUnit_fast4)
jmp PRE(mclb_mulUnit_slow4)
SIZE(mclb_mulUnit4)
.balign 16
.global PRE(mclb_mulUnitAdd4)
PRE(mclb_mulUnitAdd4):
TYPE(mclb_mulUnitAdd4)
cmpb $0, PRE(mclb_fast_flag)(%rip)
jne PRE(mclb_mulUnitAdd_fast4)
jmp PRE(mclb_mulUnitAdd_slow4)
SIZE(mclb_mulUnitAdd4)
.balign 16
.global PRE(mclb_mulUnit5)
PRE(mclb_mulUnit5):
TYPE(mclb_mulUnit5)
cmpb $0, PRE(mclb_fast_flag)(%rip)
jne PRE(mclb_mulUnit_fast5)
jmp PRE(mclb_mulUnit_slow5)
SIZE(mclb_mulUnit5)
.balign 16
.global PRE(mclb_mulUnitAdd5)
PRE(mclb_mulUnitAdd5):
TYPE(mclb_mulUnitAdd5)
cmpb $0, PRE(mclb_fast_flag)(%rip)
jne PRE(mclb_mulUnitAdd_fast5)
jmp PRE(mclb_mulUnitAdd_slow5)
SIZE(mclb_mulUnitAdd5)
.balign 16
.global PRE(mclb_mulUnit6)
PRE(mclb_mulUnit6):
TYPE(mclb_mulUnit6)
cmpb $0, PRE(mclb_fast_flag)(%rip)
jne PRE(mclb_mulUnit_fast6)
jmp PRE(mclb_mulUnit_slow6)
SIZE(mclb_mulUnit6)
.balign 16
.global PRE(mclb_mulUnitAdd6)
PRE(mclb_mulUnitAdd6):
TYPE(mclb_mulUnitAdd6)
cmpb $0, PRE(mclb_fast_flag)(%rip)
jne PRE(mclb_mulUnitAdd_fast6)
jmp PRE(mclb_mulUnitAdd_slow6)
SIZE(mclb_mulUnitAdd6)
.balign 16
.global PRE(mclb_mulUnit7)
PRE(mclb_mulUnit7):
TYPE(mclb_mulUnit7)
cmpb $0, PRE(mclb_fast_flag)(%rip)
jne PRE(mclb_mulUnit_fast7)
jmp PRE(mclb_mulUnit_slow7)
SIZE(mclb_mulUnit7)
.balign 16
.global PRE(mclb_mulUnitAdd7)
PRE(mclb_mulUnitAdd7):
TYPE(mclb_mulUnitAdd7)
cmpb $0, PRE(mclb_fast_flag)(%rip)
jne PRE(mclb_mulUnitAdd_fast7)
jmp PRE(mclb_mulUnitAdd_slow7)
SIZE(mclb_mulUnitAdd7)
.balign 16
.global PRE(mclb_mulUnit8)
PRE(mclb_mulUnit8):
TYPE(mclb_mulUnit8)
cmpb $0, PRE(mclb_fast_flag)(%rip)
jne PRE(mclb_mulUnit_fast8)
jmp PRE(mclb_mulUnit_slow8)
SIZE(mclb_mulUnit8)
.balign 16
.global PRE(mclb_mulUnitAdd8)
PRE(mclb_mulUnitAdd8):
TYPE(mclb_mulUnitAdd8)
cmpb $0, PRE(mclb_fast_flag)(%rip)
jne PRE(mclb_mulUnitAdd_fast8)
jmp PRE(mclb_mulUnitAdd_slow8)
SIZE(mclb_mulUnitAdd8)
.balign 16
.global PRE(mclb_mulUnit9)
PRE(mclb_mulUnit9):
TYPE(mclb_mulUnit9)
cmpb $0, PRE(mclb_fast_flag)(%rip)
jne PRE(mclb_mulUnit_fast9)
jmp PRE(mclb_mulUnit_slow9)
SIZE(mclb_mulUnit9)
.balign 16
.global PRE(mclb_mulUnitAdd9)
PRE(mclb_mulUnitAdd9):
TYPE(mclb_mulUnitAdd9)
cmpb $0, PRE(mclb_fast_flag)(%rip)
jne PRE(mclb_mulUnitAdd_fast9)
jmp PRE(mclb_mulUnitAdd_slow9)
SIZE(mclb_mulUnitAdd9)
.balign 16
.global PRE(mclb_mulUnit10)
PRE(mclb_mulUnit10):
TYPE(mclb_mulUnit10)
cmpb $0, PRE(mclb_fast_flag)(%rip)
jne PRE(mclb_mulUnit_fast10)
jmp PRE(mclb_mulUnit_slow10)
SIZE(mclb_mulUnit10)
.balign 16
.global PRE(mclb_mulUnitAdd10)
PRE(mclb_mulUnitAdd10):
TYPE(mclb_mulUnitAdd10)
cmpb $0, PRE(mclb_fast_flag)(%rip)
jne PRE(mclb_mulUnitAdd_fast10)
jmp PRE(mclb_mulUnitAdd_slow10)
SIZE(mclb_mulUnitAdd10)
.balign 16
.global PRE(mclb_mulUnit11)
PRE(mclb_mulUnit11):
TYPE(mclb_mulUnit11)
cmpb $0, PRE(mclb_fast_flag)(%rip)
jne PRE(mclb_mulUnit_fast11)
jmp PRE(mclb_mulUnit_slow11)
SIZE(mclb_mulUnit11)
.balign 16
.global PRE(mclb_mulUnitAdd11)
PRE(mclb_mulUnitAdd11):
TYPE(mclb_mulUnitAdd11)
cmpb $0, PRE(mclb_fast_flag)(%rip)
jne PRE(mclb_mulUnitAdd_fast11)
jmp PRE(mclb_mulUnitAdd_slow11)
SIZE(mclb_mulUnitAdd11)
.balign 16
.global PRE(mclb_mulUnit12)
PRE(mclb_mulUnit12):
TYPE(mclb_mulUnit12)
cmpb $0, PRE(mclb_fast_flag)(%rip)
jne PRE(mclb_mulUnit_fast12)
jmp PRE(mclb_mulUnit_slow12)
SIZE(mclb_mulUnit12)
.balign 16
.global PRE(mclb_mulUnitAdd12)
PRE(mclb_mulUnitAdd12):
TYPE(mclb_mulUnitAdd12)
cmpb $0, PRE(mclb_fast_flag)(%rip)
jne PRE(mclb_mulUnitAdd_fast12)
jmp PRE(mclb_mulUnitAdd_slow12)
SIZE(mclb_mulUnitAdd12)
.balign 16
.global PRE(mclb_mul1)
PRE(mclb_mul1):
TYPE(mclb_mul1)
cmpb $0, PRE(mclb_fast_flag)(%rip)
jne PRE(mclb_mul_fast1)
jmp PRE(mclb_mul_slow1)
SIZE(mclb_mul1)
.balign 16
.global PRE(mclb_sqr1)
PRE(mclb_sqr1):
TYPE(mclb_sqr1)
cmpb $0, PRE(mclb_fast_flag)(%rip)
jne PRE(mclb_sqr_fast1)
jmp PRE(mclb_sqr_slow1)
SIZE(mclb_sqr1)
.balign 16
.global PRE(mclb_mul2)
PRE(mclb_mul2):
TYPE(mclb_mul2)
cmpb $0, PRE(mclb_fast_flag)(%rip)
jne PRE(mclb_mul_fast2)
jmp PRE(mclb_mul_slow2)
SIZE(mclb_mul2)
.balign 16
.global PRE(mclb_sqr2)
PRE(mclb_sqr2):
TYPE(mclb_sqr2)
cmpb $0, PRE(mclb_fast_flag)(%rip)
jne PRE(mclb_sqr_fast2)
jmp PRE(mclb_sqr_slow2)
SIZE(mclb_sqr2)
.balign 16
.global PRE(mclb_mul3)
PRE(mclb_mul3):
TYPE(mclb_mul3)
cmpb $0, PRE(mclb_fast_flag)(%rip)
jne PRE(mclb_mul_fast3)
jmp PRE(mclb_mul_slow3)
SIZE(mclb_mul3)
.balign 16
.global PRE(mclb_sqr3)
PRE(mclb_sqr3):
TYPE(mclb_sqr3)
cmpb $0, PRE(mclb_fast_flag)(%rip)
jne PRE(mclb_sqr_fast3)
jmp PRE(mclb_sqr_slow3)
SIZE(mclb_sqr3)
.balign 16
.global PRE(mclb_mul4)
PRE(mclb_mul4):
TYPE(mclb_mul4)
cmpb $0, PRE(mclb_fast_flag)(%rip)
jne PRE(mclb_mul_fast4)
jmp PRE(mclb_mul_slow4)
SIZE(mclb_mul4)
.balign 16
.global PRE(mclb_sqr4)
PRE(mclb_sqr4):
TYPE(mclb_sqr4)
cmpb $0, PRE(mclb_fast_flag)(%rip)
jne PRE(mclb_sqr_fast4)
jmp PRE(mclb_sqr_slow4)
SIZE(mclb_sqr4)
.balign 16
.global PRE(mclb_mul5)
PRE(mclb_mul5):
TYPE(mclb_mul5)
cmpb $0, PRE(mclb_fast_flag)(%rip)
jne PRE(mclb_mul_fast5)
jmp PRE(mclb_mul_slow5)
SIZE(mclb_mul5)
.balign 16
.global PRE(mclb_sqr5)
PRE(mclb_sqr5):
TYPE(mclb_sqr5)
cmpb $0, PRE(mclb_fast_flag)(%rip)
jne PRE(mclb_sqr_fast5)
jmp PRE(mclb_sqr_slow5)
SIZE(mclb_sqr5)
.balign 16
.global PRE(mclb_mul6)
PRE(mclb_mul6):
TYPE(mclb_mul6)
cmpb $0, PRE(mclb_fast_flag)(%rip)
jne PRE(mclb_mul_fast6)
jmp PRE(mclb_mul_slow6)
SIZE(mclb_mul6)
.balign 16
.global PRE(mclb_sqr6)
PRE(mclb_sqr6):
TYPE(mclb_sqr6)
cmpb $0, PRE(mclb_fast_flag)(%rip)
jne PRE(mclb_sqr_fast6)
jmp PRE(mclb_sqr_slow6)
SIZE(mclb_sqr6)
.balign 16
.global PRE(mclb_enable_fast)
PRE(mclb_enable_fast):
TYPE(mclb_enable_fast)
movb $1, PRE(mclb_fast_flag)(%rip)
ret
SIZE(mclb_enable_fast)
.balign 16
.global PRE(mclb_modp256_x64)
PRE(mclb_modp256_x64):
TYPE(mclb_modp256_x64)
cmp $8, %r8
ja .L11
push %rdi
push %rsi
push %rbx
push %rbp
push %r12
push %r13
sub $8, %rsp
mov %rcx, %r10
mov %rdx, %r11
mov %r10, (%rsp)
cmp $4, %r8
jb .L5
lea (%r11,%r8,8), %rax
mov -24(%rax), %rdi
mov -16(%rax), %rsi
mov -8(%rax), %rbx
xor %rbp, %rbp
lea -32(%rax), %r11
sub $4, %r8
mov (%r9), %rdx
mulx %rbx, %rax, %r10
mulx %rbp, %r13, %rax
add %r10, %r13
adc $0, %rax
mov 8(%r9), %rdx
mulx %rbx, %r12, %r10
add %r12, %r13
adc %r10, %rax
mulx %rbp, %r12, %r10
adc $0, %r10
add %r12, %rax
adc $0, %r10
mov (%r11), %rbp
shrd $1, %r10, %rax
mov %rax, %rdx
xor %r12, %r12
mulx 16(%r9), %r13, %r12
adox %r13, %rbp
adcx %r12, %rdi
mulx 24(%r9), %r13, %r12
adox %r13, %rdi
adcx %r12, %rsi
mulx 32(%r9), %r13, %r12
adox %r13, %rsi
adcx %r12, %rbx
mulx 40(%r9), %r13, %r12
adox %r13, %rbx
mov %rbp, %r12
mov %rdi, %r13
mov %rsi, %r10
mov %rbx, %rax
add 16(%r9), %rbp
adc 24(%r9), %rdi
adc 32(%r9), %rsi
adc 40(%r9), %rbx
cmovnc %r12, %rbp
cmovnc %r13, %rdi
cmovnc %r10, %rsi
cmovnc %rax, %rbx
sub $1, %r8
jc .L1
sub $8, %r11
mov (%r9), %rdx
mulx %rsi, %rax, %r10
mulx %rbx, %r13, %rax
add %r10, %r13
adc $0, %rax
mov 8(%r9), %rdx
mulx %rsi, %r12, %r10
add %r12, %r13
adc %r10, %rax
mulx %rbx, %r12, %r10
adc $0, %r10
add %r12, %rax
adc $0, %r10
mov (%r11), %rbx
shrd $1, %r10, %rax
mov %rax, %rdx
xor %r12, %r12
mulx 16(%r9), %r13, %r12
adox %r13, %rbx
adcx %r12, %rbp
mulx 24(%r9), %r13, %r12
adox %r13, %rbp
adcx %r12, %rdi
mulx 32(%r9), %r13, %r12
adox %r13, %rdi
adcx %r12, %rsi
mulx 40(%r9), %r13, %r12
adox %r13, %rsi
mov %rbx, %r12
mov %rbp, %r13
mov %rdi, %r10
mov %rsi, %rax
add 16(%r9), %rbx
adc 24(%r9), %rbp
adc 32(%r9), %rdi
adc 40(%r9), %rsi
cmovnc %r12, %rbx
cmovnc %r13, %rbp
cmovnc %r10, %rdi
cmovnc %rax, %rsi
sub $1, %r8
jc .L2
sub $8, %r11
mov (%r9), %rdx
mulx %rdi, %rax, %r10
mulx %rsi, %r13, %rax
add %r10, %r13
adc $0, %rax
mov 8(%r9), %rdx
mulx %rdi, %r12, %r10
add %r12, %r13
adc %r10, %rax
mulx %rsi, %r12, %r10
adc $0, %r10
add %r12, %rax
adc $0, %r10
mov (%r11), %rsi
shrd $1, %r10, %rax
mov %rax, %rdx
xor %r12, %r12
mulx 16(%r9), %r13, %r12
adox %r13, %rsi
adcx %r12, %rbx
mulx 24(%r9), %r13, %r12
adox %r13, %rbx
adcx %r12, %rbp
mulx 32(%r9), %r13, %r12
adox %r13, %rbp
adcx %r12, %rdi
mulx 40(%r9), %r13, %r12
adox %r13, %rdi
mov %rsi, %r12
mov %rbx, %r13
mov %rbp, %r10
mov %rdi, %rax
add 16(%r9), %rsi
adc 24(%r9), %rbx
adc 32(%r9), %rbp
adc 40(%r9), %rdi
cmovnc %r12, %rsi
cmovnc %r13, %rbx
cmovnc %r10, %rbp
cmovnc %rax, %rdi
sub $1, %r8
jc .L3
sub $8, %r11
mov (%r9), %rdx
mulx %rbp, %rax, %r10
mulx %rdi, %r13, %rax
add %r10, %r13
adc $0, %rax
mov 8(%r9), %rdx
mulx %rbp, %r12, %r10
add %r12, %r13
adc %r10, %rax
mulx %rdi, %r12, %r10
adc $0, %r10
add %r12, %rax
adc $0, %r10
mov (%r11), %rdi
shrd $1, %r10, %rax
mov %rax, %rdx
xor %r12, %r12
mulx 16(%r9), %r13, %r12
adox %r13, %rdi
adcx %r12, %rsi
mulx 24(%r9), %r13, %r12
adox %r13, %rsi
adcx %r12, %rbx
mulx 32(%r9), %r13, %r12
adox %r13, %rbx
adcx %r12, %rbp
mulx 40(%r9), %r13, %r12
adox %r13, %rbp
mov %rdi, %r12
mov %rsi, %r13
mov %rbx, %r10
mov %rbp, %rax
add 16(%r9), %rdi
adc 24(%r9), %rsi
adc 32(%r9), %rbx
adc 40(%r9), %rbp
cmovnc %r12, %rdi
cmovnc %r13, %rsi
cmovnc %r10, %rbx
cmovnc %rax, %rbp
sub $1, %r8
jc .L4
sub $8, %r11
mov (%r9), %rdx
mulx %rbx, %rax, %r10
mulx %rbp, %r13, %rax
add %r10, %r13
adc $0, %rax
mov 8(%r9), %rdx
mulx %rbx, %r12, %r10
add %r12, %r13
adc %r10, %rax
mulx %rbp, %r12, %r10
adc $0, %r10
add %r12, %rax
adc $0, %r10
mov (%r11), %rbp
shrd $1, %r10, %rax
mov %rax, %rdx
xor %r12, %r12
mulx 16(%r9), %r13, %r12
adox %r13, %rbp
adcx %r12, %rdi
mulx 24(%r9), %r13, %r12
adox %r13, %rdi
adcx %r12, %rsi
mulx 32(%r9), %r13, %r12
adox %r13, %rsi
adcx %r12, %rbx
mulx 40(%r9), %r13, %r12
adox %r13, %rbx
mov %rbp, %r12
mov %rdi, %r13
mov %rsi, %r10
mov %rbx, %rax
add 16(%r9), %rbp
adc 24(%r9), %rdi
adc 32(%r9), %rsi
adc 40(%r9), %rbx
cmovnc %r12, %rbp
cmovnc %r13, %rdi
cmovnc %r10, %rsi
cmovnc %rax, %rbx
mov (%rsp), %rdx
mov %rbp, (%rdx)
mov %rdi, 8(%rdx)
mov %rsi, 16(%rdx)
mov %rbx, 24(%rdx)
jmp .L10
.L1:
mov (%rsp), %rdx
mov %rbp, (%rdx)
mov %rdi, 8(%rdx)
mov %rsi, 16(%rdx)
mov %rbx, 24(%rdx)
jmp .L10
.L2:
mov (%rsp), %rdx
mov %rbx, (%rdx)
mov %rbp, 8(%rdx)
mov %rdi, 16(%rdx)
mov %rsi, 24(%rdx)
jmp .L10
.L3:
mov (%rsp), %rdx
mov %rsi, (%rdx)
mov %rbx, 8(%rdx)
mov %rbp, 16(%rdx)
mov %rdi, 24(%rdx)
jmp .L10
.L4:
mov (%rsp), %rdx
mov %rdi, (%rdx)
mov %rsi, 8(%rdx)
mov %rbx, 16(%rdx)
mov %rbp, 24(%rdx)
jmp .L10
.L5:
mov (%rsp), %rdx
cmp $0, %r8
je .L6
mov (%r11), %rax
mov %rax, (%rdx)
cmp $1, %r8
je .L7
mov 8(%r11), %rax
mov %rax, 8(%rdx)
cmp $2, %r8
je .L8
mov 16(%r11), %rax
mov %rax, 16(%rdx)
jmp .L9
.L6:
movq $0, (%rdx)
.L7:
movq $0, 8(%rdx)
.L8:
movq $0, 16(%rdx)
.L9:
movq $0, 24(%rdx)
.L10:
mov $1, %eax
add $8, %rsp
pop %r13
pop %r12
pop %rbp
pop %rbx
pop %rsi
pop %rdi
ret
.L11:
xor %eax, %eax
ret
SIZE(mclb_modp256_x64)
.balign 16
.global PRE(mclb_modp384_x64)
PRE(mclb_modp384_x64):
TYPE(mclb_modp384_x64)
cmp $8, %r8
ja .L22
push %rdi
push %rsi
push %rbx
push %rbp
push %r12
push %r13
push %r14
push %r15
sub $8, %rsp
mov %rcx, %r10
mov %rdx, %r11
mov %r10, (%rsp)
cmp $6, %r8
jb .L14
lea (%r11,%r8,8), %rax
mov -40(%rax), %rdi
mov -32(%rax), %rsi
mov -24(%rax), %rbx
mov -16(%rax), %rbp
mov -8(%rax), %r12
xor %r13, %r13
lea -48(%rax), %r11
sub $6, %r8
mov (%r9), %rdx
mulx %r12, %rax, %r10
mulx %r13, %r15, %rax
add %r10, %r15
adc $0, %rax
mov 8(%r9), %rdx
mulx %r12, %r14, %r10
add %r14, %r15
adc %r10, %rax
mulx %r13, %r14, %r10
adc $0, %r10
add %r14, %rax
adc $0, %r10
mov (%r11), %r13
shrd $1, %r10, %rax
mov %rax, %rdx
xor %r14, %r14
mulx 16(%r9), %r15, %r14
adox %r15, %r13
adcx %r14, %rdi
mulx 24(%r9), %r15, %r14
adox %r15, %rdi
adcx %r14, %rsi
mulx 32(%r9), %r15, %r14
adox %r15, %rsi
adcx %r14, %rbx
mulx 40(%r9), %r15, %r14
adox %r15, %rbx
adcx %r14, %rbp
mulx 48(%r9), %r15, %r14
adox %r15, %rbp
adcx %r14, %r12
mulx 56(%r9), %r15, %r14
adox %r15, %r12
mov %r13, %r14
mov %rdi, %r15
mov %rsi, %r10
mov %rbx, %rax
mov %rbp, %rcx
mov %r12, %rdx
add 16(%r9), %r13
adc 24(%r9), %rdi
adc 32(%r9), %rsi
adc 40(%r9), %rbx
adc 48(%r9), %rbp
adc 56(%r9), %r12
cmovnc %r14, %r13
cmovnc %r15, %rdi
cmovnc %r10, %rsi
cmovnc %rax, %rbx
cmovnc %rcx, %rbp
cmovnc %rdx, %r12
sub $1, %r8
jc .L12
sub $8, %r11
mov (%r9), %rdx
mulx %rbp, %rax, %r10
mulx %r12, %r15, %rax
add %r10, %r15
adc $0, %rax
mov 8(%r9), %rdx
mulx %rbp, %r14, %r10
add %r14, %r15
adc %r10, %rax
mulx %r12, %r14, %r10
adc $0, %r10
add %r14, %rax
adc $0, %r10
mov (%r11), %r12
shrd $1, %r10, %rax
mov %rax, %rdx
xor %r14, %r14
mulx 16(%r9), %r15, %r14
adox %r15, %r12
adcx %r14, %r13
mulx 24(%r9), %r15, %r14
adox %r15, %r13
adcx %r14, %rdi
mulx 32(%r9), %r15, %r14
adox %r15, %rdi
adcx %r14, %rsi
mulx 40(%r9), %r15, %r14
adox %r15, %rsi
adcx %r14, %rbx
mulx 48(%r9), %r15, %r14
adox %r15, %rbx
adcx %r14, %rbp
mulx 56(%r9), %r15, %r14
adox %r15, %rbp
mov %r12, %r14
mov %r13, %r15
mov %rdi, %r10
mov %rsi, %rax
mov %rbx, %rcx
mov %rbp, %rdx
add 16(%r9), %r12
adc 24(%r9), %r13
adc 32(%r9), %rdi
adc 40(%r9), %rsi
adc 48(%r9), %rbx
adc 56(%r9), %rbp
cmovnc %r14, %r12
cmovnc %r15, %r13
cmovnc %r10, %rdi
cmovnc %rax, %rsi
cmovnc %rcx, %rbx
cmovnc %rdx, %rbp
sub $1, %r8
jc .L13
sub $8, %r11
mov (%r9), %rdx
mulx %rbx, %rax, %r10
mulx %rbp, %r15, %rax
add %r10, %r15
adc $0, %rax
mov 8(%r9), %rdx
mulx %rbx, %r14, %r10
add %r14, %r15
adc %r10, %rax
mulx %rbp, %r14, %r10
adc $0, %r10
add %r14, %rax
adc $0, %r10
mov (%r11), %rbp
shrd $1, %r10, %rax
mov %rax, %rdx
xor %r14, %r14
mulx 16(%r9), %r15, %r14
adox %r15, %rbp
adcx %r14, %r12
mulx 24(%r9), %r15, %r14
adox %r15, %r12
adcx %r14, %r13
mulx 32(%r9), %r15, %r14
adox %r15, %r13
adcx %r14, %rdi
mulx 40(%r9), %r15, %r14
adox %r15, %rdi
adcx %r14, %rsi
mulx 48(%r9), %r15, %r14
adox %r15, %rsi
adcx %r14, %rbx
mulx 56(%r9), %r15, %r14
adox %r15, %rbx
mov %rbp, %r14
mov %r12, %r15
mov %r13, %r10
mov %rdi, %rax
mov %rsi, %rcx
mov %rbx, %rdx
add 16(%r9), %rbp
adc 24(%r9), %r12
adc 32(%r9), %r13
adc 40(%r9), %rdi
adc 48(%r9), %rsi
adc 56(%r9), %rbx
cmovnc %r14, %rbp
cmovnc %r15, %r12
cmovnc %r10, %r13
cmovnc %rax, %rdi
cmovnc %rcx, %rsi
cmovnc %rdx, %rbx
mov (%rsp), %rdx
mov %rbp, (%rdx)
mov %r12, 8(%rdx)
mov %r13, 16(%rdx)
mov %rdi, 24(%rdx)
mov %rsi, 32(%rdx)
mov %rbx, 40(%rdx)
jmp .L21
.L12:
mov (%rsp), %rdx
mov %r13, (%rdx)
mov %rdi, 8(%rdx)
mov %rsi, 16(%rdx)
mov %rbx, 24(%rdx)
mov %rbp, 32(%rdx)
mov %r12, 40(%rdx)
jmp .L21
.L13:
mov (%rsp), %rdx
mov %r12, (%rdx)
mov %r13, 8(%rdx)
mov %rdi, 16(%rdx)
mov %rsi, 24(%rdx)
mov %rbx, 32(%rdx)
mov %rbp, 40(%rdx)
jmp .L21
.L14:
mov (%rsp), %rdx
cmp $0, %r8
je .L15
mov (%r11), %rax
mov %rax, (%rdx)
cmp $1, %r8
je .L16
mov 8(%r11), %rax
mov %rax, 8(%rdx)
cmp $2, %r8
je .L17
mov 16(%r11), %rax
mov %rax, 16(%rdx)
cmp $3, %r8
je .L18
mov 24(%r11), %rax
mov %rax, 24(%rdx)
cmp $4, %r8
je .L19
mov 32(%r11), %rax
mov %rax, 32(%rdx)
jmp .L20
.L15:
movq $0, (%rdx)
.L16:
movq $0, 8(%rdx)
.L17:
movq $0, 16(%rdx)
.L18:
movq $0, 24(%rdx)
.L19:
movq $0, 32(%rdx)
.L20:
movq $0, 40(%rdx)
.L21:
mov $1, %eax
add $8, %rsp
pop %r15
pop %r14
pop %r13
pop %r12
pop %rbp
pop %rbx
pop %rsi
pop %rdi
ret
.L22:
xor %eax, %eax
ret
SIZE(mclb_modp384_x64)
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
