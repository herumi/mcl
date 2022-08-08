# for gas
.text
.align 16
.global mclb_add1
.global _mclb_add1
mclb_add1:
_mclb_add1:
mov (%rsi), %rax
add (%rdx), %rax
mov %rax, (%rdi)
setc %al
movzx %al, %eax
ret
.align 16
.global mclb_add2
.global _mclb_add2
mclb_add2:
_mclb_add2:
mov (%rsi), %rax
add (%rdx), %rax
mov %rax, (%rdi)
mov 8(%rsi), %rax
adc 8(%rdx), %rax
mov %rax, 8(%rdi)
setc %al
movzx %al, %eax
ret
.align 16
.global mclb_add3
.global _mclb_add3
mclb_add3:
_mclb_add3:
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
.align 16
.global mclb_add4
.global _mclb_add4
mclb_add4:
_mclb_add4:
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
.align 16
.global mclb_add5
.global _mclb_add5
mclb_add5:
_mclb_add5:
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
.align 16
.global mclb_add6
.global _mclb_add6
mclb_add6:
_mclb_add6:
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
.align 16
.global mclb_add7
.global _mclb_add7
mclb_add7:
_mclb_add7:
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
.align 16
.global mclb_add8
.global _mclb_add8
mclb_add8:
_mclb_add8:
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
.align 16
.global mclb_add9
.global _mclb_add9
mclb_add9:
_mclb_add9:
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
.align 16
.global mclb_add10
.global _mclb_add10
mclb_add10:
_mclb_add10:
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
.align 16
.global mclb_add11
.global _mclb_add11
mclb_add11:
_mclb_add11:
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
.align 16
.global mclb_add12
.global _mclb_add12
mclb_add12:
_mclb_add12:
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
.align 16
.global mclb_add13
.global _mclb_add13
mclb_add13:
_mclb_add13:
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
.align 16
.global mclb_add14
.global _mclb_add14
mclb_add14:
_mclb_add14:
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
.align 16
.global mclb_add15
.global _mclb_add15
mclb_add15:
_mclb_add15:
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
.align 16
.global mclb_add16
.global _mclb_add16
mclb_add16:
_mclb_add16:
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
.align 16
.global mclb_sub1
.global _mclb_sub1
mclb_sub1:
_mclb_sub1:
mov (%rsi), %rax
sub (%rdx), %rax
mov %rax, (%rdi)
setc %al
movzx %al, %eax
ret
.align 16
.global mclb_sub2
.global _mclb_sub2
mclb_sub2:
_mclb_sub2:
mov (%rsi), %rax
sub (%rdx), %rax
mov %rax, (%rdi)
mov 8(%rsi), %rax
sbb 8(%rdx), %rax
mov %rax, 8(%rdi)
setc %al
movzx %al, %eax
ret
.align 16
.global mclb_sub3
.global _mclb_sub3
mclb_sub3:
_mclb_sub3:
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
.align 16
.global mclb_sub4
.global _mclb_sub4
mclb_sub4:
_mclb_sub4:
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
.align 16
.global mclb_sub5
.global _mclb_sub5
mclb_sub5:
_mclb_sub5:
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
.align 16
.global mclb_sub6
.global _mclb_sub6
mclb_sub6:
_mclb_sub6:
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
.align 16
.global mclb_sub7
.global _mclb_sub7
mclb_sub7:
_mclb_sub7:
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
.align 16
.global mclb_sub8
.global _mclb_sub8
mclb_sub8:
_mclb_sub8:
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
.align 16
.global mclb_sub9
.global _mclb_sub9
mclb_sub9:
_mclb_sub9:
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
.align 16
.global mclb_sub10
.global _mclb_sub10
mclb_sub10:
_mclb_sub10:
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
.align 16
.global mclb_sub11
.global _mclb_sub11
mclb_sub11:
_mclb_sub11:
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
.align 16
.global mclb_sub12
.global _mclb_sub12
mclb_sub12:
_mclb_sub12:
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
.align 16
.global mclb_sub13
.global _mclb_sub13
mclb_sub13:
_mclb_sub13:
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
.align 16
.global mclb_sub14
.global _mclb_sub14
mclb_sub14:
_mclb_sub14:
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
.align 16
.global mclb_sub15
.global _mclb_sub15
mclb_sub15:
_mclb_sub15:
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
.align 16
.global mclb_sub16
.global _mclb_sub16
mclb_sub16:
_mclb_sub16:
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
.align 16
.global mclb_addNF1
.global _mclb_addNF1
mclb_addNF1:
_mclb_addNF1:
mov (%rsi), %rax
add (%rdx), %rax
mov %rax, (%rdi)
ret
.align 16
.global mclb_addNF2
.global _mclb_addNF2
mclb_addNF2:
_mclb_addNF2:
mov (%rsi), %rax
add (%rdx), %rax
mov %rax, (%rdi)
mov 8(%rsi), %rax
adc 8(%rdx), %rax
mov %rax, 8(%rdi)
ret
.align 16
.global mclb_addNF3
.global _mclb_addNF3
mclb_addNF3:
_mclb_addNF3:
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
.align 16
.global mclb_addNF4
.global _mclb_addNF4
mclb_addNF4:
_mclb_addNF4:
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
.align 16
.global mclb_addNF5
.global _mclb_addNF5
mclb_addNF5:
_mclb_addNF5:
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
.align 16
.global mclb_addNF6
.global _mclb_addNF6
mclb_addNF6:
_mclb_addNF6:
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
.align 16
.global mclb_addNF7
.global _mclb_addNF7
mclb_addNF7:
_mclb_addNF7:
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
.align 16
.global mclb_addNF8
.global _mclb_addNF8
mclb_addNF8:
_mclb_addNF8:
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
.align 16
.global mclb_addNF9
.global _mclb_addNF9
mclb_addNF9:
_mclb_addNF9:
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
.align 16
.global mclb_addNF10
.global _mclb_addNF10
mclb_addNF10:
_mclb_addNF10:
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
.align 16
.global mclb_addNF11
.global _mclb_addNF11
mclb_addNF11:
_mclb_addNF11:
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
.align 16
.global mclb_addNF12
.global _mclb_addNF12
mclb_addNF12:
_mclb_addNF12:
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
.align 16
.global mclb_addNF13
.global _mclb_addNF13
mclb_addNF13:
_mclb_addNF13:
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
.align 16
.global mclb_addNF14
.global _mclb_addNF14
mclb_addNF14:
_mclb_addNF14:
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
.align 16
.global mclb_addNF15
.global _mclb_addNF15
mclb_addNF15:
_mclb_addNF15:
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
.align 16
.global mclb_addNF16
.global _mclb_addNF16
mclb_addNF16:
_mclb_addNF16:
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
.align 16
.global mclb_subNF1
.global _mclb_subNF1
mclb_subNF1:
_mclb_subNF1:
mov (%rsi), %rax
sub (%rdx), %rax
mov %rax, (%rdi)
setc %al
movzx %al, %eax
ret
.align 16
.global mclb_subNF2
.global _mclb_subNF2
mclb_subNF2:
_mclb_subNF2:
mov (%rsi), %rax
sub (%rdx), %rax
mov %rax, (%rdi)
mov 8(%rsi), %rax
sbb 8(%rdx), %rax
mov %rax, 8(%rdi)
setc %al
movzx %al, %eax
ret
.align 16
.global mclb_subNF3
.global _mclb_subNF3
mclb_subNF3:
_mclb_subNF3:
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
.align 16
.global mclb_subNF4
.global _mclb_subNF4
mclb_subNF4:
_mclb_subNF4:
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
.align 16
.global mclb_subNF5
.global _mclb_subNF5
mclb_subNF5:
_mclb_subNF5:
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
.align 16
.global mclb_subNF6
.global _mclb_subNF6
mclb_subNF6:
_mclb_subNF6:
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
.align 16
.global mclb_subNF7
.global _mclb_subNF7
mclb_subNF7:
_mclb_subNF7:
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
.align 16
.global mclb_subNF8
.global _mclb_subNF8
mclb_subNF8:
_mclb_subNF8:
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
.align 16
.global mclb_subNF9
.global _mclb_subNF9
mclb_subNF9:
_mclb_subNF9:
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
.align 16
.global mclb_subNF10
.global _mclb_subNF10
mclb_subNF10:
_mclb_subNF10:
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
.align 16
.global mclb_subNF11
.global _mclb_subNF11
mclb_subNF11:
_mclb_subNF11:
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
.align 16
.global mclb_subNF12
.global _mclb_subNF12
mclb_subNF12:
_mclb_subNF12:
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
.align 16
.global mclb_subNF13
.global _mclb_subNF13
mclb_subNF13:
_mclb_subNF13:
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
.align 16
.global mclb_subNF14
.global _mclb_subNF14
mclb_subNF14:
_mclb_subNF14:
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
.align 16
.global mclb_subNF15
.global _mclb_subNF15
mclb_subNF15:
_mclb_subNF15:
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
.align 16
.global mclb_subNF16
.global _mclb_subNF16
mclb_subNF16:
_mclb_subNF16:
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
.align 16
.global mclb_mulUnit_fast1
.global _mclb_mulUnit_fast1
mclb_mulUnit_fast1:
_mclb_mulUnit_fast1:
mov (%rsi), %rax
mul %rdx
mov %rax, (%rdi)
mov %rdx, %rax
ret
.align 16
.global mclb_mulUnit_fast2
.global _mclb_mulUnit_fast2
mclb_mulUnit_fast2:
_mclb_mulUnit_fast2:
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
.align 16
.global mclb_mulUnit_fast3
.global _mclb_mulUnit_fast3
mclb_mulUnit_fast3:
_mclb_mulUnit_fast3:
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
.align 16
.global mclb_mulUnit_fast4
.global _mclb_mulUnit_fast4
mclb_mulUnit_fast4:
_mclb_mulUnit_fast4:
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
.align 16
.global mclb_mulUnit_fast5
.global _mclb_mulUnit_fast5
mclb_mulUnit_fast5:
_mclb_mulUnit_fast5:
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
.align 16
.global mclb_mulUnit_fast6
.global _mclb_mulUnit_fast6
mclb_mulUnit_fast6:
_mclb_mulUnit_fast6:
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
.align 16
.global mclb_mulUnit_fast7
.global _mclb_mulUnit_fast7
mclb_mulUnit_fast7:
_mclb_mulUnit_fast7:
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
.align 16
.global mclb_mulUnit_fast8
.global _mclb_mulUnit_fast8
mclb_mulUnit_fast8:
_mclb_mulUnit_fast8:
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
.align 16
.global mclb_mulUnit_fast9
.global _mclb_mulUnit_fast9
mclb_mulUnit_fast9:
_mclb_mulUnit_fast9:
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
.align 16
.global mclb_mulUnitAdd_fast1
.global _mclb_mulUnitAdd_fast1
mclb_mulUnitAdd_fast1:
_mclb_mulUnitAdd_fast1:
xor %eax, %eax
mov (%rdi), %rcx
mulx (%rsi), %r8, %rax
adox %r8, %rcx
mov %rcx, (%rdi)
mov $0, %rcx
adcx %rcx, %rax
adox %rcx, %rax
ret
.align 16
.global mclb_mulUnitAdd_fast2
.global _mclb_mulUnitAdd_fast2
mclb_mulUnitAdd_fast2:
_mclb_mulUnitAdd_fast2:
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
.align 16
.global mclb_mulUnitAdd_fast3
.global _mclb_mulUnitAdd_fast3
mclb_mulUnitAdd_fast3:
_mclb_mulUnitAdd_fast3:
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
.align 16
.global mclb_mulUnitAdd_fast4
.global _mclb_mulUnitAdd_fast4
mclb_mulUnitAdd_fast4:
_mclb_mulUnitAdd_fast4:
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
.align 16
.global mclb_mulUnitAdd_fast5
.global _mclb_mulUnitAdd_fast5
mclb_mulUnitAdd_fast5:
_mclb_mulUnitAdd_fast5:
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
.align 16
.global mclb_mulUnitAdd_fast6
.global _mclb_mulUnitAdd_fast6
mclb_mulUnitAdd_fast6:
_mclb_mulUnitAdd_fast6:
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
.align 16
.global mclb_mulUnitAdd_fast7
.global _mclb_mulUnitAdd_fast7
mclb_mulUnitAdd_fast7:
_mclb_mulUnitAdd_fast7:
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
.align 16
.global mclb_mulUnitAdd_fast8
.global _mclb_mulUnitAdd_fast8
mclb_mulUnitAdd_fast8:
_mclb_mulUnitAdd_fast8:
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
.align 16
.global mclb_mulUnitAdd_fast9
.global _mclb_mulUnitAdd_fast9
mclb_mulUnitAdd_fast9:
_mclb_mulUnitAdd_fast9:
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
.align 16
.global mclb_mulUnit_slow1
.global _mclb_mulUnit_slow1
mclb_mulUnit_slow1:
_mclb_mulUnit_slow1:
mov (%rsi), %rax
mul %rdx
mov %rax, (%rdi)
mov %rdx, %rax
ret
.align 16
.global mclb_mulUnit_slow2
.global _mclb_mulUnit_slow2
mclb_mulUnit_slow2:
_mclb_mulUnit_slow2:
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
.align 16
.global mclb_mulUnit_slow3
.global _mclb_mulUnit_slow3
mclb_mulUnit_slow3:
_mclb_mulUnit_slow3:
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
.align 16
.global mclb_mulUnit_slow4
.global _mclb_mulUnit_slow4
mclb_mulUnit_slow4:
_mclb_mulUnit_slow4:
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
.align 16
.global mclb_mulUnit_slow5
.global _mclb_mulUnit_slow5
mclb_mulUnit_slow5:
_mclb_mulUnit_slow5:
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
.align 16
.global mclb_mulUnit_slow6
.global _mclb_mulUnit_slow6
mclb_mulUnit_slow6:
_mclb_mulUnit_slow6:
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
.align 16
.global mclb_mulUnit_slow7
.global _mclb_mulUnit_slow7
mclb_mulUnit_slow7:
_mclb_mulUnit_slow7:
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
.align 16
.global mclb_mulUnit_slow8
.global _mclb_mulUnit_slow8
mclb_mulUnit_slow8:
_mclb_mulUnit_slow8:
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
.align 16
.global mclb_mulUnit_slow9
.global _mclb_mulUnit_slow9
mclb_mulUnit_slow9:
_mclb_mulUnit_slow9:
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
.align 16
.global mclb_mulUnitAdd_slow1
.global _mclb_mulUnitAdd_slow1
mclb_mulUnitAdd_slow1:
_mclb_mulUnitAdd_slow1:
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
.align 16
.global mclb_mulUnitAdd_slow2
.global _mclb_mulUnitAdd_slow2
mclb_mulUnitAdd_slow2:
_mclb_mulUnitAdd_slow2:
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
.align 16
.global mclb_mulUnitAdd_slow3
.global _mclb_mulUnitAdd_slow3
mclb_mulUnitAdd_slow3:
_mclb_mulUnitAdd_slow3:
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
.align 16
.global mclb_mulUnitAdd_slow4
.global _mclb_mulUnitAdd_slow4
mclb_mulUnitAdd_slow4:
_mclb_mulUnitAdd_slow4:
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
.align 16
.global mclb_mulUnitAdd_slow5
.global _mclb_mulUnitAdd_slow5
mclb_mulUnitAdd_slow5:
_mclb_mulUnitAdd_slow5:
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
.align 16
.global mclb_mulUnitAdd_slow6
.global _mclb_mulUnitAdd_slow6
mclb_mulUnitAdd_slow6:
_mclb_mulUnitAdd_slow6:
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
.align 16
.global mclb_mulUnitAdd_slow7
.global _mclb_mulUnitAdd_slow7
mclb_mulUnitAdd_slow7:
_mclb_mulUnitAdd_slow7:
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
.align 16
.global mclb_mulUnitAdd_slow8
.global _mclb_mulUnitAdd_slow8
mclb_mulUnitAdd_slow8:
_mclb_mulUnitAdd_slow8:
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
.align 16
.global mclb_mulUnitAdd_slow9
.global _mclb_mulUnitAdd_slow9
mclb_mulUnitAdd_slow9:
_mclb_mulUnitAdd_slow9:
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
.align 16
.global mclb_mul_fast1
.global _mclb_mul_fast1
mclb_mul_fast1:
_mclb_mul_fast1:
.extern mclb_mul_slow1
.extern _mclb_mul_slow1
jmp mclb_mul_slow1
.align 16
.global mclb_mul_fast2
.global _mclb_mul_fast2
mclb_mul_fast2:
_mclb_mul_fast2:
.extern mclb_mul_slow2
.extern _mclb_mul_slow2
jmp mclb_mul_slow2
.align 16
.global mclb_mul_fast3
.global _mclb_mul_fast3
mclb_mul_fast3:
_mclb_mul_fast3:
.extern mclb_mul_slow3
.extern _mclb_mul_slow3
jmp mclb_mul_slow3
.align 16
.global mclb_mul_fast4
.global _mclb_mul_fast4
mclb_mul_fast4:
_mclb_mul_fast4:
.extern mclb_mul_slow4
.extern _mclb_mul_slow4
jmp mclb_mul_slow4
.align 16
.global mclb_mul_fast5
.global _mclb_mul_fast5
mclb_mul_fast5:
_mclb_mul_fast5:
.extern mclb_mul_slow5
.extern _mclb_mul_slow5
jmp mclb_mul_slow5
.align 16
.global mclb_mul_fast6
.global _mclb_mul_fast6
mclb_mul_fast6:
_mclb_mul_fast6:
.extern mclb_mul_slow6
.extern _mclb_mul_slow6
jmp mclb_mul_slow6
.align 16
.global mclb_mul_fast7
.global _mclb_mul_fast7
mclb_mul_fast7:
_mclb_mul_fast7:
.extern mclb_mul_slow7
.extern _mclb_mul_slow7
jmp mclb_mul_slow7
.align 16
.global mclb_mul_fast8
.global _mclb_mul_fast8
mclb_mul_fast8:
_mclb_mul_fast8:
.extern mclb_mul_slow8
.extern _mclb_mul_slow8
jmp mclb_mul_slow8
.align 16
.global mclb_mul_fast9
.global _mclb_mul_fast9
mclb_mul_fast9:
_mclb_mul_fast9:
.extern mclb_mul_slow9
.extern _mclb_mul_slow9
jmp mclb_mul_slow9
.align 16
.global mclb_sqr_fast1
.global _mclb_sqr_fast1
mclb_sqr_fast1:
_mclb_sqr_fast1:
.extern mclb_sqr_slow1
.extern _mclb_sqr_slow1
jmp mclb_sqr_slow1
.align 16
.global mclb_sqr_fast2
.global _mclb_sqr_fast2
mclb_sqr_fast2:
_mclb_sqr_fast2:
.extern mclb_sqr_slow2
.extern _mclb_sqr_slow2
jmp mclb_sqr_slow2
.align 16
.global mclb_sqr_fast3
.global _mclb_sqr_fast3
mclb_sqr_fast3:
_mclb_sqr_fast3:
.extern mclb_sqr_slow3
.extern _mclb_sqr_slow3
jmp mclb_sqr_slow3
.align 16
.global mclb_sqr_fast4
.global _mclb_sqr_fast4
mclb_sqr_fast4:
_mclb_sqr_fast4:
.extern mclb_sqr_slow4
.extern _mclb_sqr_slow4
jmp mclb_sqr_slow4
.align 16
.global mclb_sqr_fast5
.global _mclb_sqr_fast5
mclb_sqr_fast5:
_mclb_sqr_fast5:
.extern mclb_sqr_slow5
.extern _mclb_sqr_slow5
jmp mclb_sqr_slow5
.align 16
.global mclb_sqr_fast6
.global _mclb_sqr_fast6
mclb_sqr_fast6:
_mclb_sqr_fast6:
.extern mclb_sqr_slow6
.extern _mclb_sqr_slow6
jmp mclb_sqr_slow6
.align 16
.global mclb_sqr_fast7
.global _mclb_sqr_fast7
mclb_sqr_fast7:
_mclb_sqr_fast7:
.extern mclb_sqr_slow7
.extern _mclb_sqr_slow7
jmp mclb_sqr_slow7
.align 16
.global mclb_sqr_fast8
.global _mclb_sqr_fast8
mclb_sqr_fast8:
_mclb_sqr_fast8:
.extern mclb_sqr_slow8
.extern _mclb_sqr_slow8
jmp mclb_sqr_slow8
.align 16
.global mclb_sqr_fast9
.global _mclb_sqr_fast9
mclb_sqr_fast9:
_mclb_sqr_fast9:
.extern mclb_sqr_slow9
.extern _mclb_sqr_slow9
jmp mclb_sqr_slow9
