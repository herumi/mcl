; for masm (ml64.exe)
_text segment
align 16
mclb_add1 proc export
mov rax, [rdx]
add rax, [r8]
mov [rcx], rax
setc al
movzx eax, al
ret
mclb_add1 endp
align 16
mclb_add2 proc export
mov rax, [rdx]
add rax, [r8]
mov [rcx], rax
mov rax, [rdx+8]
adc rax, [r8+8]
mov [rcx+8], rax
setc al
movzx eax, al
ret
mclb_add2 endp
align 16
mclb_add3 proc export
mov rax, [rdx]
add rax, [r8]
mov [rcx], rax
mov rax, [rdx+8]
adc rax, [r8+8]
mov [rcx+8], rax
mov rax, [rdx+16]
adc rax, [r8+16]
mov [rcx+16], rax
setc al
movzx eax, al
ret
mclb_add3 endp
align 16
mclb_add4 proc export
mov rax, [rdx]
add rax, [r8]
mov [rcx], rax
mov rax, [rdx+8]
adc rax, [r8+8]
mov [rcx+8], rax
mov rax, [rdx+16]
adc rax, [r8+16]
mov [rcx+16], rax
mov rax, [rdx+24]
adc rax, [r8+24]
mov [rcx+24], rax
setc al
movzx eax, al
ret
mclb_add4 endp
align 16
mclb_add5 proc export
mov rax, [rdx]
add rax, [r8]
mov [rcx], rax
mov rax, [rdx+8]
adc rax, [r8+8]
mov [rcx+8], rax
mov rax, [rdx+16]
adc rax, [r8+16]
mov [rcx+16], rax
mov rax, [rdx+24]
adc rax, [r8+24]
mov [rcx+24], rax
mov rax, [rdx+32]
adc rax, [r8+32]
mov [rcx+32], rax
setc al
movzx eax, al
ret
mclb_add5 endp
align 16
mclb_add6 proc export
mov rax, [rdx]
add rax, [r8]
mov [rcx], rax
mov rax, [rdx+8]
adc rax, [r8+8]
mov [rcx+8], rax
mov rax, [rdx+16]
adc rax, [r8+16]
mov [rcx+16], rax
mov rax, [rdx+24]
adc rax, [r8+24]
mov [rcx+24], rax
mov rax, [rdx+32]
adc rax, [r8+32]
mov [rcx+32], rax
mov rax, [rdx+40]
adc rax, [r8+40]
mov [rcx+40], rax
setc al
movzx eax, al
ret
mclb_add6 endp
align 16
mclb_add7 proc export
mov rax, [rdx]
add rax, [r8]
mov [rcx], rax
mov rax, [rdx+8]
adc rax, [r8+8]
mov [rcx+8], rax
mov rax, [rdx+16]
adc rax, [r8+16]
mov [rcx+16], rax
mov rax, [rdx+24]
adc rax, [r8+24]
mov [rcx+24], rax
mov rax, [rdx+32]
adc rax, [r8+32]
mov [rcx+32], rax
mov rax, [rdx+40]
adc rax, [r8+40]
mov [rcx+40], rax
mov rax, [rdx+48]
adc rax, [r8+48]
mov [rcx+48], rax
setc al
movzx eax, al
ret
mclb_add7 endp
align 16
mclb_add8 proc export
mov rax, [rdx]
add rax, [r8]
mov [rcx], rax
mov rax, [rdx+8]
adc rax, [r8+8]
mov [rcx+8], rax
mov rax, [rdx+16]
adc rax, [r8+16]
mov [rcx+16], rax
mov rax, [rdx+24]
adc rax, [r8+24]
mov [rcx+24], rax
mov rax, [rdx+32]
adc rax, [r8+32]
mov [rcx+32], rax
mov rax, [rdx+40]
adc rax, [r8+40]
mov [rcx+40], rax
mov rax, [rdx+48]
adc rax, [r8+48]
mov [rcx+48], rax
mov rax, [rdx+56]
adc rax, [r8+56]
mov [rcx+56], rax
setc al
movzx eax, al
ret
mclb_add8 endp
align 16
mclb_add9 proc export
mov rax, [rdx]
add rax, [r8]
mov [rcx], rax
mov rax, [rdx+8]
adc rax, [r8+8]
mov [rcx+8], rax
mov rax, [rdx+16]
adc rax, [r8+16]
mov [rcx+16], rax
mov rax, [rdx+24]
adc rax, [r8+24]
mov [rcx+24], rax
mov rax, [rdx+32]
adc rax, [r8+32]
mov [rcx+32], rax
mov rax, [rdx+40]
adc rax, [r8+40]
mov [rcx+40], rax
mov rax, [rdx+48]
adc rax, [r8+48]
mov [rcx+48], rax
mov rax, [rdx+56]
adc rax, [r8+56]
mov [rcx+56], rax
mov rax, [rdx+64]
adc rax, [r8+64]
mov [rcx+64], rax
setc al
movzx eax, al
ret
mclb_add9 endp
align 16
mclb_add10 proc export
mov rax, [rdx]
add rax, [r8]
mov [rcx], rax
mov rax, [rdx+8]
adc rax, [r8+8]
mov [rcx+8], rax
mov rax, [rdx+16]
adc rax, [r8+16]
mov [rcx+16], rax
mov rax, [rdx+24]
adc rax, [r8+24]
mov [rcx+24], rax
mov rax, [rdx+32]
adc rax, [r8+32]
mov [rcx+32], rax
mov rax, [rdx+40]
adc rax, [r8+40]
mov [rcx+40], rax
mov rax, [rdx+48]
adc rax, [r8+48]
mov [rcx+48], rax
mov rax, [rdx+56]
adc rax, [r8+56]
mov [rcx+56], rax
mov rax, [rdx+64]
adc rax, [r8+64]
mov [rcx+64], rax
mov rax, [rdx+72]
adc rax, [r8+72]
mov [rcx+72], rax
setc al
movzx eax, al
ret
mclb_add10 endp
align 16
mclb_add11 proc export
mov rax, [rdx]
add rax, [r8]
mov [rcx], rax
mov rax, [rdx+8]
adc rax, [r8+8]
mov [rcx+8], rax
mov rax, [rdx+16]
adc rax, [r8+16]
mov [rcx+16], rax
mov rax, [rdx+24]
adc rax, [r8+24]
mov [rcx+24], rax
mov rax, [rdx+32]
adc rax, [r8+32]
mov [rcx+32], rax
mov rax, [rdx+40]
adc rax, [r8+40]
mov [rcx+40], rax
mov rax, [rdx+48]
adc rax, [r8+48]
mov [rcx+48], rax
mov rax, [rdx+56]
adc rax, [r8+56]
mov [rcx+56], rax
mov rax, [rdx+64]
adc rax, [r8+64]
mov [rcx+64], rax
mov rax, [rdx+72]
adc rax, [r8+72]
mov [rcx+72], rax
mov rax, [rdx+80]
adc rax, [r8+80]
mov [rcx+80], rax
setc al
movzx eax, al
ret
mclb_add11 endp
align 16
mclb_add12 proc export
mov rax, [rdx]
add rax, [r8]
mov [rcx], rax
mov rax, [rdx+8]
adc rax, [r8+8]
mov [rcx+8], rax
mov rax, [rdx+16]
adc rax, [r8+16]
mov [rcx+16], rax
mov rax, [rdx+24]
adc rax, [r8+24]
mov [rcx+24], rax
mov rax, [rdx+32]
adc rax, [r8+32]
mov [rcx+32], rax
mov rax, [rdx+40]
adc rax, [r8+40]
mov [rcx+40], rax
mov rax, [rdx+48]
adc rax, [r8+48]
mov [rcx+48], rax
mov rax, [rdx+56]
adc rax, [r8+56]
mov [rcx+56], rax
mov rax, [rdx+64]
adc rax, [r8+64]
mov [rcx+64], rax
mov rax, [rdx+72]
adc rax, [r8+72]
mov [rcx+72], rax
mov rax, [rdx+80]
adc rax, [r8+80]
mov [rcx+80], rax
mov rax, [rdx+88]
adc rax, [r8+88]
mov [rcx+88], rax
setc al
movzx eax, al
ret
mclb_add12 endp
align 16
mclb_add13 proc export
mov rax, [rdx]
add rax, [r8]
mov [rcx], rax
mov rax, [rdx+8]
adc rax, [r8+8]
mov [rcx+8], rax
mov rax, [rdx+16]
adc rax, [r8+16]
mov [rcx+16], rax
mov rax, [rdx+24]
adc rax, [r8+24]
mov [rcx+24], rax
mov rax, [rdx+32]
adc rax, [r8+32]
mov [rcx+32], rax
mov rax, [rdx+40]
adc rax, [r8+40]
mov [rcx+40], rax
mov rax, [rdx+48]
adc rax, [r8+48]
mov [rcx+48], rax
mov rax, [rdx+56]
adc rax, [r8+56]
mov [rcx+56], rax
mov rax, [rdx+64]
adc rax, [r8+64]
mov [rcx+64], rax
mov rax, [rdx+72]
adc rax, [r8+72]
mov [rcx+72], rax
mov rax, [rdx+80]
adc rax, [r8+80]
mov [rcx+80], rax
mov rax, [rdx+88]
adc rax, [r8+88]
mov [rcx+88], rax
mov rax, [rdx+96]
adc rax, [r8+96]
mov [rcx+96], rax
setc al
movzx eax, al
ret
mclb_add13 endp
align 16
mclb_add14 proc export
mov rax, [rdx]
add rax, [r8]
mov [rcx], rax
mov rax, [rdx+8]
adc rax, [r8+8]
mov [rcx+8], rax
mov rax, [rdx+16]
adc rax, [r8+16]
mov [rcx+16], rax
mov rax, [rdx+24]
adc rax, [r8+24]
mov [rcx+24], rax
mov rax, [rdx+32]
adc rax, [r8+32]
mov [rcx+32], rax
mov rax, [rdx+40]
adc rax, [r8+40]
mov [rcx+40], rax
mov rax, [rdx+48]
adc rax, [r8+48]
mov [rcx+48], rax
mov rax, [rdx+56]
adc rax, [r8+56]
mov [rcx+56], rax
mov rax, [rdx+64]
adc rax, [r8+64]
mov [rcx+64], rax
mov rax, [rdx+72]
adc rax, [r8+72]
mov [rcx+72], rax
mov rax, [rdx+80]
adc rax, [r8+80]
mov [rcx+80], rax
mov rax, [rdx+88]
adc rax, [r8+88]
mov [rcx+88], rax
mov rax, [rdx+96]
adc rax, [r8+96]
mov [rcx+96], rax
mov rax, [rdx+104]
adc rax, [r8+104]
mov [rcx+104], rax
setc al
movzx eax, al
ret
mclb_add14 endp
align 16
mclb_add15 proc export
mov rax, [rdx]
add rax, [r8]
mov [rcx], rax
mov rax, [rdx+8]
adc rax, [r8+8]
mov [rcx+8], rax
mov rax, [rdx+16]
adc rax, [r8+16]
mov [rcx+16], rax
mov rax, [rdx+24]
adc rax, [r8+24]
mov [rcx+24], rax
mov rax, [rdx+32]
adc rax, [r8+32]
mov [rcx+32], rax
mov rax, [rdx+40]
adc rax, [r8+40]
mov [rcx+40], rax
mov rax, [rdx+48]
adc rax, [r8+48]
mov [rcx+48], rax
mov rax, [rdx+56]
adc rax, [r8+56]
mov [rcx+56], rax
mov rax, [rdx+64]
adc rax, [r8+64]
mov [rcx+64], rax
mov rax, [rdx+72]
adc rax, [r8+72]
mov [rcx+72], rax
mov rax, [rdx+80]
adc rax, [r8+80]
mov [rcx+80], rax
mov rax, [rdx+88]
adc rax, [r8+88]
mov [rcx+88], rax
mov rax, [rdx+96]
adc rax, [r8+96]
mov [rcx+96], rax
mov rax, [rdx+104]
adc rax, [r8+104]
mov [rcx+104], rax
mov rax, [rdx+112]
adc rax, [r8+112]
mov [rcx+112], rax
setc al
movzx eax, al
ret
mclb_add15 endp
align 16
mclb_add16 proc export
mov rax, [rdx]
add rax, [r8]
mov [rcx], rax
mov rax, [rdx+8]
adc rax, [r8+8]
mov [rcx+8], rax
mov rax, [rdx+16]
adc rax, [r8+16]
mov [rcx+16], rax
mov rax, [rdx+24]
adc rax, [r8+24]
mov [rcx+24], rax
mov rax, [rdx+32]
adc rax, [r8+32]
mov [rcx+32], rax
mov rax, [rdx+40]
adc rax, [r8+40]
mov [rcx+40], rax
mov rax, [rdx+48]
adc rax, [r8+48]
mov [rcx+48], rax
mov rax, [rdx+56]
adc rax, [r8+56]
mov [rcx+56], rax
mov rax, [rdx+64]
adc rax, [r8+64]
mov [rcx+64], rax
mov rax, [rdx+72]
adc rax, [r8+72]
mov [rcx+72], rax
mov rax, [rdx+80]
adc rax, [r8+80]
mov [rcx+80], rax
mov rax, [rdx+88]
adc rax, [r8+88]
mov [rcx+88], rax
mov rax, [rdx+96]
adc rax, [r8+96]
mov [rcx+96], rax
mov rax, [rdx+104]
adc rax, [r8+104]
mov [rcx+104], rax
mov rax, [rdx+112]
adc rax, [r8+112]
mov [rcx+112], rax
mov rax, [rdx+120]
adc rax, [r8+120]
mov [rcx+120], rax
setc al
movzx eax, al
ret
mclb_add16 endp
align 16
mclb_sub1 proc export
mov rax, [rdx]
sub rax, [r8]
mov [rcx], rax
setc al
movzx eax, al
ret
mclb_sub1 endp
align 16
mclb_sub2 proc export
mov rax, [rdx]
sub rax, [r8]
mov [rcx], rax
mov rax, [rdx+8]
sbb rax, [r8+8]
mov [rcx+8], rax
setc al
movzx eax, al
ret
mclb_sub2 endp
align 16
mclb_sub3 proc export
mov rax, [rdx]
sub rax, [r8]
mov [rcx], rax
mov rax, [rdx+8]
sbb rax, [r8+8]
mov [rcx+8], rax
mov rax, [rdx+16]
sbb rax, [r8+16]
mov [rcx+16], rax
setc al
movzx eax, al
ret
mclb_sub3 endp
align 16
mclb_sub4 proc export
mov rax, [rdx]
sub rax, [r8]
mov [rcx], rax
mov rax, [rdx+8]
sbb rax, [r8+8]
mov [rcx+8], rax
mov rax, [rdx+16]
sbb rax, [r8+16]
mov [rcx+16], rax
mov rax, [rdx+24]
sbb rax, [r8+24]
mov [rcx+24], rax
setc al
movzx eax, al
ret
mclb_sub4 endp
align 16
mclb_sub5 proc export
mov rax, [rdx]
sub rax, [r8]
mov [rcx], rax
mov rax, [rdx+8]
sbb rax, [r8+8]
mov [rcx+8], rax
mov rax, [rdx+16]
sbb rax, [r8+16]
mov [rcx+16], rax
mov rax, [rdx+24]
sbb rax, [r8+24]
mov [rcx+24], rax
mov rax, [rdx+32]
sbb rax, [r8+32]
mov [rcx+32], rax
setc al
movzx eax, al
ret
mclb_sub5 endp
align 16
mclb_sub6 proc export
mov rax, [rdx]
sub rax, [r8]
mov [rcx], rax
mov rax, [rdx+8]
sbb rax, [r8+8]
mov [rcx+8], rax
mov rax, [rdx+16]
sbb rax, [r8+16]
mov [rcx+16], rax
mov rax, [rdx+24]
sbb rax, [r8+24]
mov [rcx+24], rax
mov rax, [rdx+32]
sbb rax, [r8+32]
mov [rcx+32], rax
mov rax, [rdx+40]
sbb rax, [r8+40]
mov [rcx+40], rax
setc al
movzx eax, al
ret
mclb_sub6 endp
align 16
mclb_sub7 proc export
mov rax, [rdx]
sub rax, [r8]
mov [rcx], rax
mov rax, [rdx+8]
sbb rax, [r8+8]
mov [rcx+8], rax
mov rax, [rdx+16]
sbb rax, [r8+16]
mov [rcx+16], rax
mov rax, [rdx+24]
sbb rax, [r8+24]
mov [rcx+24], rax
mov rax, [rdx+32]
sbb rax, [r8+32]
mov [rcx+32], rax
mov rax, [rdx+40]
sbb rax, [r8+40]
mov [rcx+40], rax
mov rax, [rdx+48]
sbb rax, [r8+48]
mov [rcx+48], rax
setc al
movzx eax, al
ret
mclb_sub7 endp
align 16
mclb_sub8 proc export
mov rax, [rdx]
sub rax, [r8]
mov [rcx], rax
mov rax, [rdx+8]
sbb rax, [r8+8]
mov [rcx+8], rax
mov rax, [rdx+16]
sbb rax, [r8+16]
mov [rcx+16], rax
mov rax, [rdx+24]
sbb rax, [r8+24]
mov [rcx+24], rax
mov rax, [rdx+32]
sbb rax, [r8+32]
mov [rcx+32], rax
mov rax, [rdx+40]
sbb rax, [r8+40]
mov [rcx+40], rax
mov rax, [rdx+48]
sbb rax, [r8+48]
mov [rcx+48], rax
mov rax, [rdx+56]
sbb rax, [r8+56]
mov [rcx+56], rax
setc al
movzx eax, al
ret
mclb_sub8 endp
align 16
mclb_sub9 proc export
mov rax, [rdx]
sub rax, [r8]
mov [rcx], rax
mov rax, [rdx+8]
sbb rax, [r8+8]
mov [rcx+8], rax
mov rax, [rdx+16]
sbb rax, [r8+16]
mov [rcx+16], rax
mov rax, [rdx+24]
sbb rax, [r8+24]
mov [rcx+24], rax
mov rax, [rdx+32]
sbb rax, [r8+32]
mov [rcx+32], rax
mov rax, [rdx+40]
sbb rax, [r8+40]
mov [rcx+40], rax
mov rax, [rdx+48]
sbb rax, [r8+48]
mov [rcx+48], rax
mov rax, [rdx+56]
sbb rax, [r8+56]
mov [rcx+56], rax
mov rax, [rdx+64]
sbb rax, [r8+64]
mov [rcx+64], rax
setc al
movzx eax, al
ret
mclb_sub9 endp
align 16
mclb_sub10 proc export
mov rax, [rdx]
sub rax, [r8]
mov [rcx], rax
mov rax, [rdx+8]
sbb rax, [r8+8]
mov [rcx+8], rax
mov rax, [rdx+16]
sbb rax, [r8+16]
mov [rcx+16], rax
mov rax, [rdx+24]
sbb rax, [r8+24]
mov [rcx+24], rax
mov rax, [rdx+32]
sbb rax, [r8+32]
mov [rcx+32], rax
mov rax, [rdx+40]
sbb rax, [r8+40]
mov [rcx+40], rax
mov rax, [rdx+48]
sbb rax, [r8+48]
mov [rcx+48], rax
mov rax, [rdx+56]
sbb rax, [r8+56]
mov [rcx+56], rax
mov rax, [rdx+64]
sbb rax, [r8+64]
mov [rcx+64], rax
mov rax, [rdx+72]
sbb rax, [r8+72]
mov [rcx+72], rax
setc al
movzx eax, al
ret
mclb_sub10 endp
align 16
mclb_sub11 proc export
mov rax, [rdx]
sub rax, [r8]
mov [rcx], rax
mov rax, [rdx+8]
sbb rax, [r8+8]
mov [rcx+8], rax
mov rax, [rdx+16]
sbb rax, [r8+16]
mov [rcx+16], rax
mov rax, [rdx+24]
sbb rax, [r8+24]
mov [rcx+24], rax
mov rax, [rdx+32]
sbb rax, [r8+32]
mov [rcx+32], rax
mov rax, [rdx+40]
sbb rax, [r8+40]
mov [rcx+40], rax
mov rax, [rdx+48]
sbb rax, [r8+48]
mov [rcx+48], rax
mov rax, [rdx+56]
sbb rax, [r8+56]
mov [rcx+56], rax
mov rax, [rdx+64]
sbb rax, [r8+64]
mov [rcx+64], rax
mov rax, [rdx+72]
sbb rax, [r8+72]
mov [rcx+72], rax
mov rax, [rdx+80]
sbb rax, [r8+80]
mov [rcx+80], rax
setc al
movzx eax, al
ret
mclb_sub11 endp
align 16
mclb_sub12 proc export
mov rax, [rdx]
sub rax, [r8]
mov [rcx], rax
mov rax, [rdx+8]
sbb rax, [r8+8]
mov [rcx+8], rax
mov rax, [rdx+16]
sbb rax, [r8+16]
mov [rcx+16], rax
mov rax, [rdx+24]
sbb rax, [r8+24]
mov [rcx+24], rax
mov rax, [rdx+32]
sbb rax, [r8+32]
mov [rcx+32], rax
mov rax, [rdx+40]
sbb rax, [r8+40]
mov [rcx+40], rax
mov rax, [rdx+48]
sbb rax, [r8+48]
mov [rcx+48], rax
mov rax, [rdx+56]
sbb rax, [r8+56]
mov [rcx+56], rax
mov rax, [rdx+64]
sbb rax, [r8+64]
mov [rcx+64], rax
mov rax, [rdx+72]
sbb rax, [r8+72]
mov [rcx+72], rax
mov rax, [rdx+80]
sbb rax, [r8+80]
mov [rcx+80], rax
mov rax, [rdx+88]
sbb rax, [r8+88]
mov [rcx+88], rax
setc al
movzx eax, al
ret
mclb_sub12 endp
align 16
mclb_sub13 proc export
mov rax, [rdx]
sub rax, [r8]
mov [rcx], rax
mov rax, [rdx+8]
sbb rax, [r8+8]
mov [rcx+8], rax
mov rax, [rdx+16]
sbb rax, [r8+16]
mov [rcx+16], rax
mov rax, [rdx+24]
sbb rax, [r8+24]
mov [rcx+24], rax
mov rax, [rdx+32]
sbb rax, [r8+32]
mov [rcx+32], rax
mov rax, [rdx+40]
sbb rax, [r8+40]
mov [rcx+40], rax
mov rax, [rdx+48]
sbb rax, [r8+48]
mov [rcx+48], rax
mov rax, [rdx+56]
sbb rax, [r8+56]
mov [rcx+56], rax
mov rax, [rdx+64]
sbb rax, [r8+64]
mov [rcx+64], rax
mov rax, [rdx+72]
sbb rax, [r8+72]
mov [rcx+72], rax
mov rax, [rdx+80]
sbb rax, [r8+80]
mov [rcx+80], rax
mov rax, [rdx+88]
sbb rax, [r8+88]
mov [rcx+88], rax
mov rax, [rdx+96]
sbb rax, [r8+96]
mov [rcx+96], rax
setc al
movzx eax, al
ret
mclb_sub13 endp
align 16
mclb_sub14 proc export
mov rax, [rdx]
sub rax, [r8]
mov [rcx], rax
mov rax, [rdx+8]
sbb rax, [r8+8]
mov [rcx+8], rax
mov rax, [rdx+16]
sbb rax, [r8+16]
mov [rcx+16], rax
mov rax, [rdx+24]
sbb rax, [r8+24]
mov [rcx+24], rax
mov rax, [rdx+32]
sbb rax, [r8+32]
mov [rcx+32], rax
mov rax, [rdx+40]
sbb rax, [r8+40]
mov [rcx+40], rax
mov rax, [rdx+48]
sbb rax, [r8+48]
mov [rcx+48], rax
mov rax, [rdx+56]
sbb rax, [r8+56]
mov [rcx+56], rax
mov rax, [rdx+64]
sbb rax, [r8+64]
mov [rcx+64], rax
mov rax, [rdx+72]
sbb rax, [r8+72]
mov [rcx+72], rax
mov rax, [rdx+80]
sbb rax, [r8+80]
mov [rcx+80], rax
mov rax, [rdx+88]
sbb rax, [r8+88]
mov [rcx+88], rax
mov rax, [rdx+96]
sbb rax, [r8+96]
mov [rcx+96], rax
mov rax, [rdx+104]
sbb rax, [r8+104]
mov [rcx+104], rax
setc al
movzx eax, al
ret
mclb_sub14 endp
align 16
mclb_sub15 proc export
mov rax, [rdx]
sub rax, [r8]
mov [rcx], rax
mov rax, [rdx+8]
sbb rax, [r8+8]
mov [rcx+8], rax
mov rax, [rdx+16]
sbb rax, [r8+16]
mov [rcx+16], rax
mov rax, [rdx+24]
sbb rax, [r8+24]
mov [rcx+24], rax
mov rax, [rdx+32]
sbb rax, [r8+32]
mov [rcx+32], rax
mov rax, [rdx+40]
sbb rax, [r8+40]
mov [rcx+40], rax
mov rax, [rdx+48]
sbb rax, [r8+48]
mov [rcx+48], rax
mov rax, [rdx+56]
sbb rax, [r8+56]
mov [rcx+56], rax
mov rax, [rdx+64]
sbb rax, [r8+64]
mov [rcx+64], rax
mov rax, [rdx+72]
sbb rax, [r8+72]
mov [rcx+72], rax
mov rax, [rdx+80]
sbb rax, [r8+80]
mov [rcx+80], rax
mov rax, [rdx+88]
sbb rax, [r8+88]
mov [rcx+88], rax
mov rax, [rdx+96]
sbb rax, [r8+96]
mov [rcx+96], rax
mov rax, [rdx+104]
sbb rax, [r8+104]
mov [rcx+104], rax
mov rax, [rdx+112]
sbb rax, [r8+112]
mov [rcx+112], rax
setc al
movzx eax, al
ret
mclb_sub15 endp
align 16
mclb_sub16 proc export
mov rax, [rdx]
sub rax, [r8]
mov [rcx], rax
mov rax, [rdx+8]
sbb rax, [r8+8]
mov [rcx+8], rax
mov rax, [rdx+16]
sbb rax, [r8+16]
mov [rcx+16], rax
mov rax, [rdx+24]
sbb rax, [r8+24]
mov [rcx+24], rax
mov rax, [rdx+32]
sbb rax, [r8+32]
mov [rcx+32], rax
mov rax, [rdx+40]
sbb rax, [r8+40]
mov [rcx+40], rax
mov rax, [rdx+48]
sbb rax, [r8+48]
mov [rcx+48], rax
mov rax, [rdx+56]
sbb rax, [r8+56]
mov [rcx+56], rax
mov rax, [rdx+64]
sbb rax, [r8+64]
mov [rcx+64], rax
mov rax, [rdx+72]
sbb rax, [r8+72]
mov [rcx+72], rax
mov rax, [rdx+80]
sbb rax, [r8+80]
mov [rcx+80], rax
mov rax, [rdx+88]
sbb rax, [r8+88]
mov [rcx+88], rax
mov rax, [rdx+96]
sbb rax, [r8+96]
mov [rcx+96], rax
mov rax, [rdx+104]
sbb rax, [r8+104]
mov [rcx+104], rax
mov rax, [rdx+112]
sbb rax, [r8+112]
mov [rcx+112], rax
mov rax, [rdx+120]
sbb rax, [r8+120]
mov [rcx+120], rax
setc al
movzx eax, al
ret
mclb_sub16 endp
align 16
mclb_addNF1 proc export
mov rax, [rdx]
add rax, [r8]
mov [rcx], rax
ret
mclb_addNF1 endp
align 16
mclb_addNF2 proc export
mov rax, [rdx]
add rax, [r8]
mov [rcx], rax
mov rax, [rdx+8]
adc rax, [r8+8]
mov [rcx+8], rax
ret
mclb_addNF2 endp
align 16
mclb_addNF3 proc export
mov rax, [rdx]
add rax, [r8]
mov [rcx], rax
mov rax, [rdx+8]
adc rax, [r8+8]
mov [rcx+8], rax
mov rax, [rdx+16]
adc rax, [r8+16]
mov [rcx+16], rax
ret
mclb_addNF3 endp
align 16
mclb_addNF4 proc export
mov rax, [rdx]
add rax, [r8]
mov [rcx], rax
mov rax, [rdx+8]
adc rax, [r8+8]
mov [rcx+8], rax
mov rax, [rdx+16]
adc rax, [r8+16]
mov [rcx+16], rax
mov rax, [rdx+24]
adc rax, [r8+24]
mov [rcx+24], rax
ret
mclb_addNF4 endp
align 16
mclb_addNF5 proc export
mov rax, [rdx]
add rax, [r8]
mov [rcx], rax
mov rax, [rdx+8]
adc rax, [r8+8]
mov [rcx+8], rax
mov rax, [rdx+16]
adc rax, [r8+16]
mov [rcx+16], rax
mov rax, [rdx+24]
adc rax, [r8+24]
mov [rcx+24], rax
mov rax, [rdx+32]
adc rax, [r8+32]
mov [rcx+32], rax
ret
mclb_addNF5 endp
align 16
mclb_addNF6 proc export
mov rax, [rdx]
add rax, [r8]
mov [rcx], rax
mov rax, [rdx+8]
adc rax, [r8+8]
mov [rcx+8], rax
mov rax, [rdx+16]
adc rax, [r8+16]
mov [rcx+16], rax
mov rax, [rdx+24]
adc rax, [r8+24]
mov [rcx+24], rax
mov rax, [rdx+32]
adc rax, [r8+32]
mov [rcx+32], rax
mov rax, [rdx+40]
adc rax, [r8+40]
mov [rcx+40], rax
ret
mclb_addNF6 endp
align 16
mclb_addNF7 proc export
mov rax, [rdx]
add rax, [r8]
mov [rcx], rax
mov rax, [rdx+8]
adc rax, [r8+8]
mov [rcx+8], rax
mov rax, [rdx+16]
adc rax, [r8+16]
mov [rcx+16], rax
mov rax, [rdx+24]
adc rax, [r8+24]
mov [rcx+24], rax
mov rax, [rdx+32]
adc rax, [r8+32]
mov [rcx+32], rax
mov rax, [rdx+40]
adc rax, [r8+40]
mov [rcx+40], rax
mov rax, [rdx+48]
adc rax, [r8+48]
mov [rcx+48], rax
ret
mclb_addNF7 endp
align 16
mclb_addNF8 proc export
mov rax, [rdx]
add rax, [r8]
mov [rcx], rax
mov rax, [rdx+8]
adc rax, [r8+8]
mov [rcx+8], rax
mov rax, [rdx+16]
adc rax, [r8+16]
mov [rcx+16], rax
mov rax, [rdx+24]
adc rax, [r8+24]
mov [rcx+24], rax
mov rax, [rdx+32]
adc rax, [r8+32]
mov [rcx+32], rax
mov rax, [rdx+40]
adc rax, [r8+40]
mov [rcx+40], rax
mov rax, [rdx+48]
adc rax, [r8+48]
mov [rcx+48], rax
mov rax, [rdx+56]
adc rax, [r8+56]
mov [rcx+56], rax
ret
mclb_addNF8 endp
align 16
mclb_addNF9 proc export
mov rax, [rdx]
add rax, [r8]
mov [rcx], rax
mov rax, [rdx+8]
adc rax, [r8+8]
mov [rcx+8], rax
mov rax, [rdx+16]
adc rax, [r8+16]
mov [rcx+16], rax
mov rax, [rdx+24]
adc rax, [r8+24]
mov [rcx+24], rax
mov rax, [rdx+32]
adc rax, [r8+32]
mov [rcx+32], rax
mov rax, [rdx+40]
adc rax, [r8+40]
mov [rcx+40], rax
mov rax, [rdx+48]
adc rax, [r8+48]
mov [rcx+48], rax
mov rax, [rdx+56]
adc rax, [r8+56]
mov [rcx+56], rax
mov rax, [rdx+64]
adc rax, [r8+64]
mov [rcx+64], rax
ret
mclb_addNF9 endp
align 16
mclb_addNF10 proc export
mov rax, [rdx]
add rax, [r8]
mov [rcx], rax
mov rax, [rdx+8]
adc rax, [r8+8]
mov [rcx+8], rax
mov rax, [rdx+16]
adc rax, [r8+16]
mov [rcx+16], rax
mov rax, [rdx+24]
adc rax, [r8+24]
mov [rcx+24], rax
mov rax, [rdx+32]
adc rax, [r8+32]
mov [rcx+32], rax
mov rax, [rdx+40]
adc rax, [r8+40]
mov [rcx+40], rax
mov rax, [rdx+48]
adc rax, [r8+48]
mov [rcx+48], rax
mov rax, [rdx+56]
adc rax, [r8+56]
mov [rcx+56], rax
mov rax, [rdx+64]
adc rax, [r8+64]
mov [rcx+64], rax
mov rax, [rdx+72]
adc rax, [r8+72]
mov [rcx+72], rax
ret
mclb_addNF10 endp
align 16
mclb_addNF11 proc export
mov rax, [rdx]
add rax, [r8]
mov [rcx], rax
mov rax, [rdx+8]
adc rax, [r8+8]
mov [rcx+8], rax
mov rax, [rdx+16]
adc rax, [r8+16]
mov [rcx+16], rax
mov rax, [rdx+24]
adc rax, [r8+24]
mov [rcx+24], rax
mov rax, [rdx+32]
adc rax, [r8+32]
mov [rcx+32], rax
mov rax, [rdx+40]
adc rax, [r8+40]
mov [rcx+40], rax
mov rax, [rdx+48]
adc rax, [r8+48]
mov [rcx+48], rax
mov rax, [rdx+56]
adc rax, [r8+56]
mov [rcx+56], rax
mov rax, [rdx+64]
adc rax, [r8+64]
mov [rcx+64], rax
mov rax, [rdx+72]
adc rax, [r8+72]
mov [rcx+72], rax
mov rax, [rdx+80]
adc rax, [r8+80]
mov [rcx+80], rax
ret
mclb_addNF11 endp
align 16
mclb_addNF12 proc export
mov rax, [rdx]
add rax, [r8]
mov [rcx], rax
mov rax, [rdx+8]
adc rax, [r8+8]
mov [rcx+8], rax
mov rax, [rdx+16]
adc rax, [r8+16]
mov [rcx+16], rax
mov rax, [rdx+24]
adc rax, [r8+24]
mov [rcx+24], rax
mov rax, [rdx+32]
adc rax, [r8+32]
mov [rcx+32], rax
mov rax, [rdx+40]
adc rax, [r8+40]
mov [rcx+40], rax
mov rax, [rdx+48]
adc rax, [r8+48]
mov [rcx+48], rax
mov rax, [rdx+56]
adc rax, [r8+56]
mov [rcx+56], rax
mov rax, [rdx+64]
adc rax, [r8+64]
mov [rcx+64], rax
mov rax, [rdx+72]
adc rax, [r8+72]
mov [rcx+72], rax
mov rax, [rdx+80]
adc rax, [r8+80]
mov [rcx+80], rax
mov rax, [rdx+88]
adc rax, [r8+88]
mov [rcx+88], rax
ret
mclb_addNF12 endp
align 16
mclb_addNF13 proc export
mov rax, [rdx]
add rax, [r8]
mov [rcx], rax
mov rax, [rdx+8]
adc rax, [r8+8]
mov [rcx+8], rax
mov rax, [rdx+16]
adc rax, [r8+16]
mov [rcx+16], rax
mov rax, [rdx+24]
adc rax, [r8+24]
mov [rcx+24], rax
mov rax, [rdx+32]
adc rax, [r8+32]
mov [rcx+32], rax
mov rax, [rdx+40]
adc rax, [r8+40]
mov [rcx+40], rax
mov rax, [rdx+48]
adc rax, [r8+48]
mov [rcx+48], rax
mov rax, [rdx+56]
adc rax, [r8+56]
mov [rcx+56], rax
mov rax, [rdx+64]
adc rax, [r8+64]
mov [rcx+64], rax
mov rax, [rdx+72]
adc rax, [r8+72]
mov [rcx+72], rax
mov rax, [rdx+80]
adc rax, [r8+80]
mov [rcx+80], rax
mov rax, [rdx+88]
adc rax, [r8+88]
mov [rcx+88], rax
mov rax, [rdx+96]
adc rax, [r8+96]
mov [rcx+96], rax
ret
mclb_addNF13 endp
align 16
mclb_addNF14 proc export
mov rax, [rdx]
add rax, [r8]
mov [rcx], rax
mov rax, [rdx+8]
adc rax, [r8+8]
mov [rcx+8], rax
mov rax, [rdx+16]
adc rax, [r8+16]
mov [rcx+16], rax
mov rax, [rdx+24]
adc rax, [r8+24]
mov [rcx+24], rax
mov rax, [rdx+32]
adc rax, [r8+32]
mov [rcx+32], rax
mov rax, [rdx+40]
adc rax, [r8+40]
mov [rcx+40], rax
mov rax, [rdx+48]
adc rax, [r8+48]
mov [rcx+48], rax
mov rax, [rdx+56]
adc rax, [r8+56]
mov [rcx+56], rax
mov rax, [rdx+64]
adc rax, [r8+64]
mov [rcx+64], rax
mov rax, [rdx+72]
adc rax, [r8+72]
mov [rcx+72], rax
mov rax, [rdx+80]
adc rax, [r8+80]
mov [rcx+80], rax
mov rax, [rdx+88]
adc rax, [r8+88]
mov [rcx+88], rax
mov rax, [rdx+96]
adc rax, [r8+96]
mov [rcx+96], rax
mov rax, [rdx+104]
adc rax, [r8+104]
mov [rcx+104], rax
ret
mclb_addNF14 endp
align 16
mclb_addNF15 proc export
mov rax, [rdx]
add rax, [r8]
mov [rcx], rax
mov rax, [rdx+8]
adc rax, [r8+8]
mov [rcx+8], rax
mov rax, [rdx+16]
adc rax, [r8+16]
mov [rcx+16], rax
mov rax, [rdx+24]
adc rax, [r8+24]
mov [rcx+24], rax
mov rax, [rdx+32]
adc rax, [r8+32]
mov [rcx+32], rax
mov rax, [rdx+40]
adc rax, [r8+40]
mov [rcx+40], rax
mov rax, [rdx+48]
adc rax, [r8+48]
mov [rcx+48], rax
mov rax, [rdx+56]
adc rax, [r8+56]
mov [rcx+56], rax
mov rax, [rdx+64]
adc rax, [r8+64]
mov [rcx+64], rax
mov rax, [rdx+72]
adc rax, [r8+72]
mov [rcx+72], rax
mov rax, [rdx+80]
adc rax, [r8+80]
mov [rcx+80], rax
mov rax, [rdx+88]
adc rax, [r8+88]
mov [rcx+88], rax
mov rax, [rdx+96]
adc rax, [r8+96]
mov [rcx+96], rax
mov rax, [rdx+104]
adc rax, [r8+104]
mov [rcx+104], rax
mov rax, [rdx+112]
adc rax, [r8+112]
mov [rcx+112], rax
ret
mclb_addNF15 endp
align 16
mclb_addNF16 proc export
mov rax, [rdx]
add rax, [r8]
mov [rcx], rax
mov rax, [rdx+8]
adc rax, [r8+8]
mov [rcx+8], rax
mov rax, [rdx+16]
adc rax, [r8+16]
mov [rcx+16], rax
mov rax, [rdx+24]
adc rax, [r8+24]
mov [rcx+24], rax
mov rax, [rdx+32]
adc rax, [r8+32]
mov [rcx+32], rax
mov rax, [rdx+40]
adc rax, [r8+40]
mov [rcx+40], rax
mov rax, [rdx+48]
adc rax, [r8+48]
mov [rcx+48], rax
mov rax, [rdx+56]
adc rax, [r8+56]
mov [rcx+56], rax
mov rax, [rdx+64]
adc rax, [r8+64]
mov [rcx+64], rax
mov rax, [rdx+72]
adc rax, [r8+72]
mov [rcx+72], rax
mov rax, [rdx+80]
adc rax, [r8+80]
mov [rcx+80], rax
mov rax, [rdx+88]
adc rax, [r8+88]
mov [rcx+88], rax
mov rax, [rdx+96]
adc rax, [r8+96]
mov [rcx+96], rax
mov rax, [rdx+104]
adc rax, [r8+104]
mov [rcx+104], rax
mov rax, [rdx+112]
adc rax, [r8+112]
mov [rcx+112], rax
mov rax, [rdx+120]
adc rax, [r8+120]
mov [rcx+120], rax
ret
mclb_addNF16 endp
align 16
mclb_subNF1 proc export
mov rax, [rdx]
sub rax, [r8]
mov [rcx], rax
setc al
movzx eax, al
ret
mclb_subNF1 endp
align 16
mclb_subNF2 proc export
mov rax, [rdx]
sub rax, [r8]
mov [rcx], rax
mov rax, [rdx+8]
sbb rax, [r8+8]
mov [rcx+8], rax
setc al
movzx eax, al
ret
mclb_subNF2 endp
align 16
mclb_subNF3 proc export
mov rax, [rdx]
sub rax, [r8]
mov [rcx], rax
mov rax, [rdx+8]
sbb rax, [r8+8]
mov [rcx+8], rax
mov rax, [rdx+16]
sbb rax, [r8+16]
mov [rcx+16], rax
setc al
movzx eax, al
ret
mclb_subNF3 endp
align 16
mclb_subNF4 proc export
mov rax, [rdx]
sub rax, [r8]
mov [rcx], rax
mov rax, [rdx+8]
sbb rax, [r8+8]
mov [rcx+8], rax
mov rax, [rdx+16]
sbb rax, [r8+16]
mov [rcx+16], rax
mov rax, [rdx+24]
sbb rax, [r8+24]
mov [rcx+24], rax
setc al
movzx eax, al
ret
mclb_subNF4 endp
align 16
mclb_subNF5 proc export
mov rax, [rdx]
sub rax, [r8]
mov [rcx], rax
mov rax, [rdx+8]
sbb rax, [r8+8]
mov [rcx+8], rax
mov rax, [rdx+16]
sbb rax, [r8+16]
mov [rcx+16], rax
mov rax, [rdx+24]
sbb rax, [r8+24]
mov [rcx+24], rax
mov rax, [rdx+32]
sbb rax, [r8+32]
mov [rcx+32], rax
setc al
movzx eax, al
ret
mclb_subNF5 endp
align 16
mclb_subNF6 proc export
mov rax, [rdx]
sub rax, [r8]
mov [rcx], rax
mov rax, [rdx+8]
sbb rax, [r8+8]
mov [rcx+8], rax
mov rax, [rdx+16]
sbb rax, [r8+16]
mov [rcx+16], rax
mov rax, [rdx+24]
sbb rax, [r8+24]
mov [rcx+24], rax
mov rax, [rdx+32]
sbb rax, [r8+32]
mov [rcx+32], rax
mov rax, [rdx+40]
sbb rax, [r8+40]
mov [rcx+40], rax
setc al
movzx eax, al
ret
mclb_subNF6 endp
align 16
mclb_subNF7 proc export
mov rax, [rdx]
sub rax, [r8]
mov [rcx], rax
mov rax, [rdx+8]
sbb rax, [r8+8]
mov [rcx+8], rax
mov rax, [rdx+16]
sbb rax, [r8+16]
mov [rcx+16], rax
mov rax, [rdx+24]
sbb rax, [r8+24]
mov [rcx+24], rax
mov rax, [rdx+32]
sbb rax, [r8+32]
mov [rcx+32], rax
mov rax, [rdx+40]
sbb rax, [r8+40]
mov [rcx+40], rax
mov rax, [rdx+48]
sbb rax, [r8+48]
mov [rcx+48], rax
setc al
movzx eax, al
ret
mclb_subNF7 endp
align 16
mclb_subNF8 proc export
mov rax, [rdx]
sub rax, [r8]
mov [rcx], rax
mov rax, [rdx+8]
sbb rax, [r8+8]
mov [rcx+8], rax
mov rax, [rdx+16]
sbb rax, [r8+16]
mov [rcx+16], rax
mov rax, [rdx+24]
sbb rax, [r8+24]
mov [rcx+24], rax
mov rax, [rdx+32]
sbb rax, [r8+32]
mov [rcx+32], rax
mov rax, [rdx+40]
sbb rax, [r8+40]
mov [rcx+40], rax
mov rax, [rdx+48]
sbb rax, [r8+48]
mov [rcx+48], rax
mov rax, [rdx+56]
sbb rax, [r8+56]
mov [rcx+56], rax
setc al
movzx eax, al
ret
mclb_subNF8 endp
align 16
mclb_subNF9 proc export
mov rax, [rdx]
sub rax, [r8]
mov [rcx], rax
mov rax, [rdx+8]
sbb rax, [r8+8]
mov [rcx+8], rax
mov rax, [rdx+16]
sbb rax, [r8+16]
mov [rcx+16], rax
mov rax, [rdx+24]
sbb rax, [r8+24]
mov [rcx+24], rax
mov rax, [rdx+32]
sbb rax, [r8+32]
mov [rcx+32], rax
mov rax, [rdx+40]
sbb rax, [r8+40]
mov [rcx+40], rax
mov rax, [rdx+48]
sbb rax, [r8+48]
mov [rcx+48], rax
mov rax, [rdx+56]
sbb rax, [r8+56]
mov [rcx+56], rax
mov rax, [rdx+64]
sbb rax, [r8+64]
mov [rcx+64], rax
setc al
movzx eax, al
ret
mclb_subNF9 endp
align 16
mclb_subNF10 proc export
mov rax, [rdx]
sub rax, [r8]
mov [rcx], rax
mov rax, [rdx+8]
sbb rax, [r8+8]
mov [rcx+8], rax
mov rax, [rdx+16]
sbb rax, [r8+16]
mov [rcx+16], rax
mov rax, [rdx+24]
sbb rax, [r8+24]
mov [rcx+24], rax
mov rax, [rdx+32]
sbb rax, [r8+32]
mov [rcx+32], rax
mov rax, [rdx+40]
sbb rax, [r8+40]
mov [rcx+40], rax
mov rax, [rdx+48]
sbb rax, [r8+48]
mov [rcx+48], rax
mov rax, [rdx+56]
sbb rax, [r8+56]
mov [rcx+56], rax
mov rax, [rdx+64]
sbb rax, [r8+64]
mov [rcx+64], rax
mov rax, [rdx+72]
sbb rax, [r8+72]
mov [rcx+72], rax
setc al
movzx eax, al
ret
mclb_subNF10 endp
align 16
mclb_subNF11 proc export
mov rax, [rdx]
sub rax, [r8]
mov [rcx], rax
mov rax, [rdx+8]
sbb rax, [r8+8]
mov [rcx+8], rax
mov rax, [rdx+16]
sbb rax, [r8+16]
mov [rcx+16], rax
mov rax, [rdx+24]
sbb rax, [r8+24]
mov [rcx+24], rax
mov rax, [rdx+32]
sbb rax, [r8+32]
mov [rcx+32], rax
mov rax, [rdx+40]
sbb rax, [r8+40]
mov [rcx+40], rax
mov rax, [rdx+48]
sbb rax, [r8+48]
mov [rcx+48], rax
mov rax, [rdx+56]
sbb rax, [r8+56]
mov [rcx+56], rax
mov rax, [rdx+64]
sbb rax, [r8+64]
mov [rcx+64], rax
mov rax, [rdx+72]
sbb rax, [r8+72]
mov [rcx+72], rax
mov rax, [rdx+80]
sbb rax, [r8+80]
mov [rcx+80], rax
setc al
movzx eax, al
ret
mclb_subNF11 endp
align 16
mclb_subNF12 proc export
mov rax, [rdx]
sub rax, [r8]
mov [rcx], rax
mov rax, [rdx+8]
sbb rax, [r8+8]
mov [rcx+8], rax
mov rax, [rdx+16]
sbb rax, [r8+16]
mov [rcx+16], rax
mov rax, [rdx+24]
sbb rax, [r8+24]
mov [rcx+24], rax
mov rax, [rdx+32]
sbb rax, [r8+32]
mov [rcx+32], rax
mov rax, [rdx+40]
sbb rax, [r8+40]
mov [rcx+40], rax
mov rax, [rdx+48]
sbb rax, [r8+48]
mov [rcx+48], rax
mov rax, [rdx+56]
sbb rax, [r8+56]
mov [rcx+56], rax
mov rax, [rdx+64]
sbb rax, [r8+64]
mov [rcx+64], rax
mov rax, [rdx+72]
sbb rax, [r8+72]
mov [rcx+72], rax
mov rax, [rdx+80]
sbb rax, [r8+80]
mov [rcx+80], rax
mov rax, [rdx+88]
sbb rax, [r8+88]
mov [rcx+88], rax
setc al
movzx eax, al
ret
mclb_subNF12 endp
align 16
mclb_subNF13 proc export
mov rax, [rdx]
sub rax, [r8]
mov [rcx], rax
mov rax, [rdx+8]
sbb rax, [r8+8]
mov [rcx+8], rax
mov rax, [rdx+16]
sbb rax, [r8+16]
mov [rcx+16], rax
mov rax, [rdx+24]
sbb rax, [r8+24]
mov [rcx+24], rax
mov rax, [rdx+32]
sbb rax, [r8+32]
mov [rcx+32], rax
mov rax, [rdx+40]
sbb rax, [r8+40]
mov [rcx+40], rax
mov rax, [rdx+48]
sbb rax, [r8+48]
mov [rcx+48], rax
mov rax, [rdx+56]
sbb rax, [r8+56]
mov [rcx+56], rax
mov rax, [rdx+64]
sbb rax, [r8+64]
mov [rcx+64], rax
mov rax, [rdx+72]
sbb rax, [r8+72]
mov [rcx+72], rax
mov rax, [rdx+80]
sbb rax, [r8+80]
mov [rcx+80], rax
mov rax, [rdx+88]
sbb rax, [r8+88]
mov [rcx+88], rax
mov rax, [rdx+96]
sbb rax, [r8+96]
mov [rcx+96], rax
setc al
movzx eax, al
ret
mclb_subNF13 endp
align 16
mclb_subNF14 proc export
mov rax, [rdx]
sub rax, [r8]
mov [rcx], rax
mov rax, [rdx+8]
sbb rax, [r8+8]
mov [rcx+8], rax
mov rax, [rdx+16]
sbb rax, [r8+16]
mov [rcx+16], rax
mov rax, [rdx+24]
sbb rax, [r8+24]
mov [rcx+24], rax
mov rax, [rdx+32]
sbb rax, [r8+32]
mov [rcx+32], rax
mov rax, [rdx+40]
sbb rax, [r8+40]
mov [rcx+40], rax
mov rax, [rdx+48]
sbb rax, [r8+48]
mov [rcx+48], rax
mov rax, [rdx+56]
sbb rax, [r8+56]
mov [rcx+56], rax
mov rax, [rdx+64]
sbb rax, [r8+64]
mov [rcx+64], rax
mov rax, [rdx+72]
sbb rax, [r8+72]
mov [rcx+72], rax
mov rax, [rdx+80]
sbb rax, [r8+80]
mov [rcx+80], rax
mov rax, [rdx+88]
sbb rax, [r8+88]
mov [rcx+88], rax
mov rax, [rdx+96]
sbb rax, [r8+96]
mov [rcx+96], rax
mov rax, [rdx+104]
sbb rax, [r8+104]
mov [rcx+104], rax
setc al
movzx eax, al
ret
mclb_subNF14 endp
align 16
mclb_subNF15 proc export
mov rax, [rdx]
sub rax, [r8]
mov [rcx], rax
mov rax, [rdx+8]
sbb rax, [r8+8]
mov [rcx+8], rax
mov rax, [rdx+16]
sbb rax, [r8+16]
mov [rcx+16], rax
mov rax, [rdx+24]
sbb rax, [r8+24]
mov [rcx+24], rax
mov rax, [rdx+32]
sbb rax, [r8+32]
mov [rcx+32], rax
mov rax, [rdx+40]
sbb rax, [r8+40]
mov [rcx+40], rax
mov rax, [rdx+48]
sbb rax, [r8+48]
mov [rcx+48], rax
mov rax, [rdx+56]
sbb rax, [r8+56]
mov [rcx+56], rax
mov rax, [rdx+64]
sbb rax, [r8+64]
mov [rcx+64], rax
mov rax, [rdx+72]
sbb rax, [r8+72]
mov [rcx+72], rax
mov rax, [rdx+80]
sbb rax, [r8+80]
mov [rcx+80], rax
mov rax, [rdx+88]
sbb rax, [r8+88]
mov [rcx+88], rax
mov rax, [rdx+96]
sbb rax, [r8+96]
mov [rcx+96], rax
mov rax, [rdx+104]
sbb rax, [r8+104]
mov [rcx+104], rax
mov rax, [rdx+112]
sbb rax, [r8+112]
mov [rcx+112], rax
setc al
movzx eax, al
ret
mclb_subNF15 endp
align 16
mclb_subNF16 proc export
mov rax, [rdx]
sub rax, [r8]
mov [rcx], rax
mov rax, [rdx+8]
sbb rax, [r8+8]
mov [rcx+8], rax
mov rax, [rdx+16]
sbb rax, [r8+16]
mov [rcx+16], rax
mov rax, [rdx+24]
sbb rax, [r8+24]
mov [rcx+24], rax
mov rax, [rdx+32]
sbb rax, [r8+32]
mov [rcx+32], rax
mov rax, [rdx+40]
sbb rax, [r8+40]
mov [rcx+40], rax
mov rax, [rdx+48]
sbb rax, [r8+48]
mov [rcx+48], rax
mov rax, [rdx+56]
sbb rax, [r8+56]
mov [rcx+56], rax
mov rax, [rdx+64]
sbb rax, [r8+64]
mov [rcx+64], rax
mov rax, [rdx+72]
sbb rax, [r8+72]
mov [rcx+72], rax
mov rax, [rdx+80]
sbb rax, [r8+80]
mov [rcx+80], rax
mov rax, [rdx+88]
sbb rax, [r8+88]
mov [rcx+88], rax
mov rax, [rdx+96]
sbb rax, [r8+96]
mov [rcx+96], rax
mov rax, [rdx+104]
sbb rax, [r8+104]
mov [rcx+104], rax
mov rax, [rdx+112]
sbb rax, [r8+112]
mov [rcx+112], rax
mov rax, [rdx+120]
sbb rax, [r8+120]
mov [rcx+120], rax
setc al
movzx eax, al
ret
mclb_subNF16 endp
align 16
mclb_mulUnit_fast1 proc export
mov rax, [rdx]
mul r8
mov [rcx], rax
mov rax, rdx
ret
mclb_mulUnit_fast1 endp
align 16
mclb_mulUnit_fast2 proc export
mov r11, rdx
mov rax, [r11]
mul r8
mov [rcx], rax
mov r9, rdx
mov rax, [r11+8]
mul r8
add rax, r9
adc rdx, 0
mov [rcx+8], rax
mov rax, rdx
ret
mclb_mulUnit_fast2 endp
align 16
mclb_mulUnit_fast3 proc export
mov r11, rdx
mov rdx, r8
mulx r10, rax, [r11]
mov [rcx], rax
mulx r9, rax, [r11+8]
add rax, r10
mov [rcx+8], rax
mulx rax, rdx, [r11+16]
adc rdx, r9
mov [rcx+16], rdx
adc rax, 0
ret
mclb_mulUnit_fast3 endp
align 16
mclb_mulUnit_fast4 proc export
mov r11, rdx
mov rdx, r8
mulx r10, rax, [r11]
mov [rcx], rax
mulx r9, rax, [r11+8]
add rax, r10
mov [rcx+8], rax
mulx r10, rax, [r11+16]
adc rax, r9
mov [rcx+16], rax
mulx rax, rdx, [r11+24]
adc rdx, r10
mov [rcx+24], rdx
adc rax, 0
ret
mclb_mulUnit_fast4 endp
align 16
mclb_mulUnit_fast5 proc export
mov r11, rdx
mov rdx, r8
mulx r10, rax, [r11]
mov [rcx], rax
mulx r9, rax, [r11+8]
add rax, r10
mov [rcx+8], rax
mulx r10, rax, [r11+16]
adc rax, r9
mov [rcx+16], rax
mulx r9, rax, [r11+24]
adc rax, r10
mov [rcx+24], rax
mulx rax, rdx, [r11+32]
adc rdx, r9
mov [rcx+32], rdx
adc rax, 0
ret
mclb_mulUnit_fast5 endp
align 16
mclb_mulUnit_fast6 proc export
mov r11, rdx
mov rdx, r8
mulx r10, rax, [r11]
mov [rcx], rax
mulx r9, rax, [r11+8]
add rax, r10
mov [rcx+8], rax
mulx r10, rax, [r11+16]
adc rax, r9
mov [rcx+16], rax
mulx r9, rax, [r11+24]
adc rax, r10
mov [rcx+24], rax
mulx r10, rax, [r11+32]
adc rax, r9
mov [rcx+32], rax
mulx rax, rdx, [r11+40]
adc rdx, r10
mov [rcx+40], rdx
adc rax, 0
ret
mclb_mulUnit_fast6 endp
align 16
mclb_mulUnit_fast7 proc export
mov r11, rdx
mov rdx, r8
mulx r10, rax, [r11]
mov [rcx], rax
mulx r9, rax, [r11+8]
add rax, r10
mov [rcx+8], rax
mulx r10, rax, [r11+16]
adc rax, r9
mov [rcx+16], rax
mulx r9, rax, [r11+24]
adc rax, r10
mov [rcx+24], rax
mulx r10, rax, [r11+32]
adc rax, r9
mov [rcx+32], rax
mulx r9, rax, [r11+40]
adc rax, r10
mov [rcx+40], rax
mulx rax, rdx, [r11+48]
adc rdx, r9
mov [rcx+48], rdx
adc rax, 0
ret
mclb_mulUnit_fast7 endp
align 16
mclb_mulUnit_fast8 proc export
mov r11, rdx
mov rdx, r8
mulx r10, rax, [r11]
mov [rcx], rax
mulx r9, rax, [r11+8]
add rax, r10
mov [rcx+8], rax
mulx r10, rax, [r11+16]
adc rax, r9
mov [rcx+16], rax
mulx r9, rax, [r11+24]
adc rax, r10
mov [rcx+24], rax
mulx r10, rax, [r11+32]
adc rax, r9
mov [rcx+32], rax
mulx r9, rax, [r11+40]
adc rax, r10
mov [rcx+40], rax
mulx r10, rax, [r11+48]
adc rax, r9
mov [rcx+48], rax
mulx rax, rdx, [r11+56]
adc rdx, r10
mov [rcx+56], rdx
adc rax, 0
ret
mclb_mulUnit_fast8 endp
align 16
mclb_mulUnit_fast9 proc export
mov r11, rdx
mov rdx, r8
mulx r10, rax, [r11]
mov [rcx], rax
mulx r9, rax, [r11+8]
add rax, r10
mov [rcx+8], rax
mulx r10, rax, [r11+16]
adc rax, r9
mov [rcx+16], rax
mulx r9, rax, [r11+24]
adc rax, r10
mov [rcx+24], rax
mulx r10, rax, [r11+32]
adc rax, r9
mov [rcx+32], rax
mulx r9, rax, [r11+40]
adc rax, r10
mov [rcx+40], rax
mulx r10, rax, [r11+48]
adc rax, r9
mov [rcx+48], rax
mulx r9, rax, [r11+56]
adc rax, r10
mov [rcx+56], rax
mulx rax, rdx, [r11+64]
adc rdx, r9
mov [rcx+64], rdx
adc rax, 0
ret
mclb_mulUnit_fast9 endp
align 16
mclb_mulUnitAdd_fast1 proc export
mov r11, rdx
mov rdx, r8
xor eax, eax
mov r9, [rcx]
mulx rax, r10, [r11]
adox r9, r10
mov [rcx], r9
mov r9, 0
adcx rax, r9
adox rax, r9
ret
mclb_mulUnitAdd_fast1 endp
align 16
mclb_mulUnitAdd_fast2 proc export
mov r11, rdx
mov rdx, r8
xor eax, eax
mov r9, [rcx]
mulx rax, r10, [r11]
adox r9, r10
mov [rcx], r9
mov r9, [rcx+8]
adcx r9, rax
mulx rax, r10, [r11+8]
adox r9, r10
mov [rcx+8], r9
mov r9, 0
adcx rax, r9
adox rax, r9
ret
mclb_mulUnitAdd_fast2 endp
align 16
mclb_mulUnitAdd_fast3 proc export
mov r11, rdx
mov rdx, r8
xor eax, eax
mov r9, [rcx]
mulx rax, r10, [r11]
adox r9, r10
mov [rcx], r9
mov r9, [rcx+8]
adcx r9, rax
mulx rax, r10, [r11+8]
adox r9, r10
mov [rcx+8], r9
mov r9, [rcx+16]
adcx r9, rax
mulx rax, r10, [r11+16]
adox r9, r10
mov [rcx+16], r9
mov r9, 0
adcx rax, r9
adox rax, r9
ret
mclb_mulUnitAdd_fast3 endp
align 16
mclb_mulUnitAdd_fast4 proc export
mov r11, rdx
mov rdx, r8
xor eax, eax
mov r9, [rcx]
mulx rax, r10, [r11]
adox r9, r10
mov [rcx], r9
mov r9, [rcx+8]
adcx r9, rax
mulx rax, r10, [r11+8]
adox r9, r10
mov [rcx+8], r9
mov r9, [rcx+16]
adcx r9, rax
mulx rax, r10, [r11+16]
adox r9, r10
mov [rcx+16], r9
mov r9, [rcx+24]
adcx r9, rax
mulx rax, r10, [r11+24]
adox r9, r10
mov [rcx+24], r9
mov r9, 0
adcx rax, r9
adox rax, r9
ret
mclb_mulUnitAdd_fast4 endp
align 16
mclb_mulUnitAdd_fast5 proc export
mov r11, rdx
mov rdx, r8
xor eax, eax
mov r9, [rcx]
mulx rax, r10, [r11]
adox r9, r10
mov [rcx], r9
mov r9, [rcx+8]
adcx r9, rax
mulx rax, r10, [r11+8]
adox r9, r10
mov [rcx+8], r9
mov r9, [rcx+16]
adcx r9, rax
mulx rax, r10, [r11+16]
adox r9, r10
mov [rcx+16], r9
mov r9, [rcx+24]
adcx r9, rax
mulx rax, r10, [r11+24]
adox r9, r10
mov [rcx+24], r9
mov r9, [rcx+32]
adcx r9, rax
mulx rax, r10, [r11+32]
adox r9, r10
mov [rcx+32], r9
mov r9, 0
adcx rax, r9
adox rax, r9
ret
mclb_mulUnitAdd_fast5 endp
align 16
mclb_mulUnitAdd_fast6 proc export
mov r11, rdx
mov rdx, r8
xor eax, eax
mov r9, [rcx]
mulx rax, r10, [r11]
adox r9, r10
mov [rcx], r9
mov r9, [rcx+8]
adcx r9, rax
mulx rax, r10, [r11+8]
adox r9, r10
mov [rcx+8], r9
mov r9, [rcx+16]
adcx r9, rax
mulx rax, r10, [r11+16]
adox r9, r10
mov [rcx+16], r9
mov r9, [rcx+24]
adcx r9, rax
mulx rax, r10, [r11+24]
adox r9, r10
mov [rcx+24], r9
mov r9, [rcx+32]
adcx r9, rax
mulx rax, r10, [r11+32]
adox r9, r10
mov [rcx+32], r9
mov r9, [rcx+40]
adcx r9, rax
mulx rax, r10, [r11+40]
adox r9, r10
mov [rcx+40], r9
mov r9, 0
adcx rax, r9
adox rax, r9
ret
mclb_mulUnitAdd_fast6 endp
align 16
mclb_mulUnitAdd_fast7 proc export
mov r11, rdx
mov rdx, r8
xor eax, eax
mov r9, [rcx]
mulx rax, r10, [r11]
adox r9, r10
mov [rcx], r9
mov r9, [rcx+8]
adcx r9, rax
mulx rax, r10, [r11+8]
adox r9, r10
mov [rcx+8], r9
mov r9, [rcx+16]
adcx r9, rax
mulx rax, r10, [r11+16]
adox r9, r10
mov [rcx+16], r9
mov r9, [rcx+24]
adcx r9, rax
mulx rax, r10, [r11+24]
adox r9, r10
mov [rcx+24], r9
mov r9, [rcx+32]
adcx r9, rax
mulx rax, r10, [r11+32]
adox r9, r10
mov [rcx+32], r9
mov r9, [rcx+40]
adcx r9, rax
mulx rax, r10, [r11+40]
adox r9, r10
mov [rcx+40], r9
mov r9, [rcx+48]
adcx r9, rax
mulx rax, r10, [r11+48]
adox r9, r10
mov [rcx+48], r9
mov r9, 0
adcx rax, r9
adox rax, r9
ret
mclb_mulUnitAdd_fast7 endp
align 16
mclb_mulUnitAdd_fast8 proc export
mov r11, rdx
mov rdx, r8
xor eax, eax
mov r9, [rcx]
mulx rax, r10, [r11]
adox r9, r10
mov [rcx], r9
mov r9, [rcx+8]
adcx r9, rax
mulx rax, r10, [r11+8]
adox r9, r10
mov [rcx+8], r9
mov r9, [rcx+16]
adcx r9, rax
mulx rax, r10, [r11+16]
adox r9, r10
mov [rcx+16], r9
mov r9, [rcx+24]
adcx r9, rax
mulx rax, r10, [r11+24]
adox r9, r10
mov [rcx+24], r9
mov r9, [rcx+32]
adcx r9, rax
mulx rax, r10, [r11+32]
adox r9, r10
mov [rcx+32], r9
mov r9, [rcx+40]
adcx r9, rax
mulx rax, r10, [r11+40]
adox r9, r10
mov [rcx+40], r9
mov r9, [rcx+48]
adcx r9, rax
mulx rax, r10, [r11+48]
adox r9, r10
mov [rcx+48], r9
mov r9, [rcx+56]
adcx r9, rax
mulx rax, r10, [r11+56]
adox r9, r10
mov [rcx+56], r9
mov r9, 0
adcx rax, r9
adox rax, r9
ret
mclb_mulUnitAdd_fast8 endp
align 16
mclb_mulUnitAdd_fast9 proc export
mov r11, rdx
mov rdx, r8
xor eax, eax
mov r9, [rcx]
mulx rax, r10, [r11]
adox r9, r10
mov [rcx], r9
mov r9, [rcx+8]
adcx r9, rax
mulx rax, r10, [r11+8]
adox r9, r10
mov [rcx+8], r9
mov r9, [rcx+16]
adcx r9, rax
mulx rax, r10, [r11+16]
adox r9, r10
mov [rcx+16], r9
mov r9, [rcx+24]
adcx r9, rax
mulx rax, r10, [r11+24]
adox r9, r10
mov [rcx+24], r9
mov r9, [rcx+32]
adcx r9, rax
mulx rax, r10, [r11+32]
adox r9, r10
mov [rcx+32], r9
mov r9, [rcx+40]
adcx r9, rax
mulx rax, r10, [r11+40]
adox r9, r10
mov [rcx+40], r9
mov r9, [rcx+48]
adcx r9, rax
mulx rax, r10, [r11+48]
adox r9, r10
mov [rcx+48], r9
mov r9, [rcx+56]
adcx r9, rax
mulx rax, r10, [r11+56]
adox r9, r10
mov [rcx+56], r9
mov r9, [rcx+64]
adcx r9, rax
mulx rax, r10, [r11+64]
adox r9, r10
mov [rcx+64], r9
mov r9, 0
adcx rax, r9
adox rax, r9
ret
mclb_mulUnitAdd_fast9 endp
align 16
mclb_mulUnit_slow1 proc export
mov rax, [rdx]
mul r8
mov [rcx], rax
mov rax, rdx
ret
mclb_mulUnit_slow1 endp
align 16
mclb_mulUnit_slow2 proc export
mov r11, rdx
mov rax, [r11]
mul r8
mov [rcx], rax
mov r9, rdx
mov rax, [r11+8]
mul r8
add rax, r9
adc rdx, 0
mov [rcx+8], rax
mov rax, rdx
ret
mclb_mulUnit_slow2 endp
align 16
mclb_mulUnit_slow3 proc export
sub rsp, 40
mov r11, rdx
mov rax, [r11]
mul r8
mov [rcx], rax
mov [rsp+16], rdx
mov rax, [r11+8]
mul r8
mov [rsp], rax
mov [rsp+24], rdx
mov rax, [r11+16]
mul r8
mov [rsp+8], rax
mov rax, [rsp+16]
add rax, [rsp]
mov [rcx+8], rax
mov rax, [rsp+24]
adc rax, [rsp+8]
mov [rcx+16], rax
adc rdx, 0
mov rax, rdx
add rsp, 40
ret
mclb_mulUnit_slow3 endp
align 16
mclb_mulUnit_slow4 proc export
sub rsp, 56
mov r11, rdx
mov rax, [r11]
mul r8
mov [rcx], rax
mov [rsp+24], rdx
mov rax, [r11+8]
mul r8
mov [rsp], rax
mov [rsp+32], rdx
mov rax, [r11+16]
mul r8
mov [rsp+8], rax
mov [rsp+40], rdx
mov rax, [r11+24]
mul r8
mov [rsp+16], rax
mov rax, [rsp+24]
add rax, [rsp]
mov [rcx+8], rax
mov rax, [rsp+32]
adc rax, [rsp+8]
mov [rcx+16], rax
mov rax, [rsp+40]
adc rax, [rsp+16]
mov [rcx+24], rax
adc rdx, 0
mov rax, rdx
add rsp, 56
ret
mclb_mulUnit_slow4 endp
align 16
mclb_mulUnit_slow5 proc export
sub rsp, 72
mov r11, rdx
mov rax, [r11]
mul r8
mov [rcx], rax
mov [rsp+32], rdx
mov rax, [r11+8]
mul r8
mov [rsp], rax
mov [rsp+40], rdx
mov rax, [r11+16]
mul r8
mov [rsp+8], rax
mov [rsp+48], rdx
mov rax, [r11+24]
mul r8
mov [rsp+16], rax
mov [rsp+56], rdx
mov rax, [r11+32]
mul r8
mov [rsp+24], rax
mov rax, [rsp+32]
add rax, [rsp]
mov [rcx+8], rax
mov rax, [rsp+40]
adc rax, [rsp+8]
mov [rcx+16], rax
mov rax, [rsp+48]
adc rax, [rsp+16]
mov [rcx+24], rax
mov rax, [rsp+56]
adc rax, [rsp+24]
mov [rcx+32], rax
adc rdx, 0
mov rax, rdx
add rsp, 72
ret
mclb_mulUnit_slow5 endp
align 16
mclb_mulUnit_slow6 proc export
sub rsp, 88
mov r11, rdx
mov rax, [r11]
mul r8
mov [rcx], rax
mov [rsp+40], rdx
mov rax, [r11+8]
mul r8
mov [rsp], rax
mov [rsp+48], rdx
mov rax, [r11+16]
mul r8
mov [rsp+8], rax
mov [rsp+56], rdx
mov rax, [r11+24]
mul r8
mov [rsp+16], rax
mov [rsp+64], rdx
mov rax, [r11+32]
mul r8
mov [rsp+24], rax
mov [rsp+72], rdx
mov rax, [r11+40]
mul r8
mov [rsp+32], rax
mov rax, [rsp+40]
add rax, [rsp]
mov [rcx+8], rax
mov rax, [rsp+48]
adc rax, [rsp+8]
mov [rcx+16], rax
mov rax, [rsp+56]
adc rax, [rsp+16]
mov [rcx+24], rax
mov rax, [rsp+64]
adc rax, [rsp+24]
mov [rcx+32], rax
mov rax, [rsp+72]
adc rax, [rsp+32]
mov [rcx+40], rax
adc rdx, 0
mov rax, rdx
add rsp, 88
ret
mclb_mulUnit_slow6 endp
align 16
mclb_mulUnit_slow7 proc export
sub rsp, 104
mov r11, rdx
mov rax, [r11]
mul r8
mov [rcx], rax
mov [rsp+48], rdx
mov rax, [r11+8]
mul r8
mov [rsp], rax
mov [rsp+56], rdx
mov rax, [r11+16]
mul r8
mov [rsp+8], rax
mov [rsp+64], rdx
mov rax, [r11+24]
mul r8
mov [rsp+16], rax
mov [rsp+72], rdx
mov rax, [r11+32]
mul r8
mov [rsp+24], rax
mov [rsp+80], rdx
mov rax, [r11+40]
mul r8
mov [rsp+32], rax
mov [rsp+88], rdx
mov rax, [r11+48]
mul r8
mov [rsp+40], rax
mov rax, [rsp+48]
add rax, [rsp]
mov [rcx+8], rax
mov rax, [rsp+56]
adc rax, [rsp+8]
mov [rcx+16], rax
mov rax, [rsp+64]
adc rax, [rsp+16]
mov [rcx+24], rax
mov rax, [rsp+72]
adc rax, [rsp+24]
mov [rcx+32], rax
mov rax, [rsp+80]
adc rax, [rsp+32]
mov [rcx+40], rax
mov rax, [rsp+88]
adc rax, [rsp+40]
mov [rcx+48], rax
adc rdx, 0
mov rax, rdx
add rsp, 104
ret
mclb_mulUnit_slow7 endp
align 16
mclb_mulUnit_slow8 proc export
sub rsp, 120
mov r11, rdx
mov rax, [r11]
mul r8
mov [rcx], rax
mov [rsp+56], rdx
mov rax, [r11+8]
mul r8
mov [rsp], rax
mov [rsp+64], rdx
mov rax, [r11+16]
mul r8
mov [rsp+8], rax
mov [rsp+72], rdx
mov rax, [r11+24]
mul r8
mov [rsp+16], rax
mov [rsp+80], rdx
mov rax, [r11+32]
mul r8
mov [rsp+24], rax
mov [rsp+88], rdx
mov rax, [r11+40]
mul r8
mov [rsp+32], rax
mov [rsp+96], rdx
mov rax, [r11+48]
mul r8
mov [rsp+40], rax
mov [rsp+104], rdx
mov rax, [r11+56]
mul r8
mov [rsp+48], rax
mov rax, [rsp+56]
add rax, [rsp]
mov [rcx+8], rax
mov rax, [rsp+64]
adc rax, [rsp+8]
mov [rcx+16], rax
mov rax, [rsp+72]
adc rax, [rsp+16]
mov [rcx+24], rax
mov rax, [rsp+80]
adc rax, [rsp+24]
mov [rcx+32], rax
mov rax, [rsp+88]
adc rax, [rsp+32]
mov [rcx+40], rax
mov rax, [rsp+96]
adc rax, [rsp+40]
mov [rcx+48], rax
mov rax, [rsp+104]
adc rax, [rsp+48]
mov [rcx+56], rax
adc rdx, 0
mov rax, rdx
add rsp, 120
ret
mclb_mulUnit_slow8 endp
align 16
mclb_mulUnit_slow9 proc export
sub rsp, 136
mov r11, rdx
mov rax, [r11]
mul r8
mov [rcx], rax
mov [rsp+64], rdx
mov rax, [r11+8]
mul r8
mov [rsp], rax
mov [rsp+72], rdx
mov rax, [r11+16]
mul r8
mov [rsp+8], rax
mov [rsp+80], rdx
mov rax, [r11+24]
mul r8
mov [rsp+16], rax
mov [rsp+88], rdx
mov rax, [r11+32]
mul r8
mov [rsp+24], rax
mov [rsp+96], rdx
mov rax, [r11+40]
mul r8
mov [rsp+32], rax
mov [rsp+104], rdx
mov rax, [r11+48]
mul r8
mov [rsp+40], rax
mov [rsp+112], rdx
mov rax, [r11+56]
mul r8
mov [rsp+48], rax
mov [rsp+120], rdx
mov rax, [r11+64]
mul r8
mov [rsp+56], rax
mov rax, [rsp+64]
add rax, [rsp]
mov [rcx+8], rax
mov rax, [rsp+72]
adc rax, [rsp+8]
mov [rcx+16], rax
mov rax, [rsp+80]
adc rax, [rsp+16]
mov [rcx+24], rax
mov rax, [rsp+88]
adc rax, [rsp+24]
mov [rcx+32], rax
mov rax, [rsp+96]
adc rax, [rsp+32]
mov [rcx+40], rax
mov rax, [rsp+104]
adc rax, [rsp+40]
mov [rcx+48], rax
mov rax, [rsp+112]
adc rax, [rsp+48]
mov [rcx+56], rax
mov rax, [rsp+120]
adc rax, [rsp+56]
mov [rcx+64], rax
adc rdx, 0
mov rax, rdx
add rsp, 136
ret
mclb_mulUnit_slow9 endp
align 16
mclb_mulUnitAdd_slow1 proc export
sub rsp, 8
mov r11, rdx
mov rax, [r11]
mul r8
mov [rsp], rax
mov rax, [rsp]
add [rcx], rax
adc rdx, 0
mov rax, rdx
add rsp, 8
ret
mclb_mulUnitAdd_slow1 endp
align 16
mclb_mulUnitAdd_slow2 proc export
sub rsp, 24
mov r11, rdx
mov rax, [r11]
mul r8
mov [rsp], rax
mov [rsp+16], rdx
mov rax, [r11+8]
mul r8
mov [rsp+8], rax
mov rax, [rsp+8]
add rax, [rsp+16]
mov [rsp+8], rax
adc rdx, 0
mov rax, [rsp]
add [rcx], rax
mov rax, [rsp+8]
adc [rcx+8], rax
adc rdx, 0
mov rax, rdx
add rsp, 24
ret
mclb_mulUnitAdd_slow2 endp
align 16
mclb_mulUnitAdd_slow3 proc export
sub rsp, 40
mov r11, rdx
mov rax, [r11]
mul r8
mov [rsp], rax
mov [rsp+24], rdx
mov rax, [r11+8]
mul r8
mov [rsp+8], rax
mov [rsp+32], rdx
mov rax, [r11+16]
mul r8
mov [rsp+16], rax
mov rax, [rsp+8]
add rax, [rsp+24]
mov [rsp+8], rax
mov rax, [rsp+16]
adc rax, [rsp+32]
mov [rsp+16], rax
adc rdx, 0
mov rax, [rsp]
add [rcx], rax
mov rax, [rsp+8]
adc [rcx+8], rax
mov rax, [rsp+16]
adc [rcx+16], rax
adc rdx, 0
mov rax, rdx
add rsp, 40
ret
mclb_mulUnitAdd_slow3 endp
align 16
mclb_mulUnitAdd_slow4 proc export
sub rsp, 56
mov r11, rdx
mov rax, [r11]
mul r8
mov [rsp], rax
mov [rsp+32], rdx
mov rax, [r11+8]
mul r8
mov [rsp+8], rax
mov [rsp+40], rdx
mov rax, [r11+16]
mul r8
mov [rsp+16], rax
mov [rsp+48], rdx
mov rax, [r11+24]
mul r8
mov [rsp+24], rax
mov rax, [rsp+8]
add rax, [rsp+32]
mov [rsp+8], rax
mov rax, [rsp+16]
adc rax, [rsp+40]
mov [rsp+16], rax
mov rax, [rsp+24]
adc rax, [rsp+48]
mov [rsp+24], rax
adc rdx, 0
mov rax, [rsp]
add [rcx], rax
mov rax, [rsp+8]
adc [rcx+8], rax
mov rax, [rsp+16]
adc [rcx+16], rax
mov rax, [rsp+24]
adc [rcx+24], rax
adc rdx, 0
mov rax, rdx
add rsp, 56
ret
mclb_mulUnitAdd_slow4 endp
align 16
mclb_mulUnitAdd_slow5 proc export
sub rsp, 72
mov r11, rdx
mov rax, [r11]
mul r8
mov [rsp], rax
mov [rsp+40], rdx
mov rax, [r11+8]
mul r8
mov [rsp+8], rax
mov [rsp+48], rdx
mov rax, [r11+16]
mul r8
mov [rsp+16], rax
mov [rsp+56], rdx
mov rax, [r11+24]
mul r8
mov [rsp+24], rax
mov [rsp+64], rdx
mov rax, [r11+32]
mul r8
mov [rsp+32], rax
mov rax, [rsp+8]
add rax, [rsp+40]
mov [rsp+8], rax
mov rax, [rsp+16]
adc rax, [rsp+48]
mov [rsp+16], rax
mov rax, [rsp+24]
adc rax, [rsp+56]
mov [rsp+24], rax
mov rax, [rsp+32]
adc rax, [rsp+64]
mov [rsp+32], rax
adc rdx, 0
mov rax, [rsp]
add [rcx], rax
mov rax, [rsp+8]
adc [rcx+8], rax
mov rax, [rsp+16]
adc [rcx+16], rax
mov rax, [rsp+24]
adc [rcx+24], rax
mov rax, [rsp+32]
adc [rcx+32], rax
adc rdx, 0
mov rax, rdx
add rsp, 72
ret
mclb_mulUnitAdd_slow5 endp
align 16
mclb_mulUnitAdd_slow6 proc export
sub rsp, 88
mov r11, rdx
mov rax, [r11]
mul r8
mov [rsp], rax
mov [rsp+48], rdx
mov rax, [r11+8]
mul r8
mov [rsp+8], rax
mov [rsp+56], rdx
mov rax, [r11+16]
mul r8
mov [rsp+16], rax
mov [rsp+64], rdx
mov rax, [r11+24]
mul r8
mov [rsp+24], rax
mov [rsp+72], rdx
mov rax, [r11+32]
mul r8
mov [rsp+32], rax
mov [rsp+80], rdx
mov rax, [r11+40]
mul r8
mov [rsp+40], rax
mov rax, [rsp+8]
add rax, [rsp+48]
mov [rsp+8], rax
mov rax, [rsp+16]
adc rax, [rsp+56]
mov [rsp+16], rax
mov rax, [rsp+24]
adc rax, [rsp+64]
mov [rsp+24], rax
mov rax, [rsp+32]
adc rax, [rsp+72]
mov [rsp+32], rax
mov rax, [rsp+40]
adc rax, [rsp+80]
mov [rsp+40], rax
adc rdx, 0
mov rax, [rsp]
add [rcx], rax
mov rax, [rsp+8]
adc [rcx+8], rax
mov rax, [rsp+16]
adc [rcx+16], rax
mov rax, [rsp+24]
adc [rcx+24], rax
mov rax, [rsp+32]
adc [rcx+32], rax
mov rax, [rsp+40]
adc [rcx+40], rax
adc rdx, 0
mov rax, rdx
add rsp, 88
ret
mclb_mulUnitAdd_slow6 endp
align 16
mclb_mulUnitAdd_slow7 proc export
sub rsp, 104
mov r11, rdx
mov rax, [r11]
mul r8
mov [rsp], rax
mov [rsp+56], rdx
mov rax, [r11+8]
mul r8
mov [rsp+8], rax
mov [rsp+64], rdx
mov rax, [r11+16]
mul r8
mov [rsp+16], rax
mov [rsp+72], rdx
mov rax, [r11+24]
mul r8
mov [rsp+24], rax
mov [rsp+80], rdx
mov rax, [r11+32]
mul r8
mov [rsp+32], rax
mov [rsp+88], rdx
mov rax, [r11+40]
mul r8
mov [rsp+40], rax
mov [rsp+96], rdx
mov rax, [r11+48]
mul r8
mov [rsp+48], rax
mov rax, [rsp+8]
add rax, [rsp+56]
mov [rsp+8], rax
mov rax, [rsp+16]
adc rax, [rsp+64]
mov [rsp+16], rax
mov rax, [rsp+24]
adc rax, [rsp+72]
mov [rsp+24], rax
mov rax, [rsp+32]
adc rax, [rsp+80]
mov [rsp+32], rax
mov rax, [rsp+40]
adc rax, [rsp+88]
mov [rsp+40], rax
mov rax, [rsp+48]
adc rax, [rsp+96]
mov [rsp+48], rax
adc rdx, 0
mov rax, [rsp]
add [rcx], rax
mov rax, [rsp+8]
adc [rcx+8], rax
mov rax, [rsp+16]
adc [rcx+16], rax
mov rax, [rsp+24]
adc [rcx+24], rax
mov rax, [rsp+32]
adc [rcx+32], rax
mov rax, [rsp+40]
adc [rcx+40], rax
mov rax, [rsp+48]
adc [rcx+48], rax
adc rdx, 0
mov rax, rdx
add rsp, 104
ret
mclb_mulUnitAdd_slow7 endp
align 16
mclb_mulUnitAdd_slow8 proc export
sub rsp, 120
mov r11, rdx
mov rax, [r11]
mul r8
mov [rsp], rax
mov [rsp+64], rdx
mov rax, [r11+8]
mul r8
mov [rsp+8], rax
mov [rsp+72], rdx
mov rax, [r11+16]
mul r8
mov [rsp+16], rax
mov [rsp+80], rdx
mov rax, [r11+24]
mul r8
mov [rsp+24], rax
mov [rsp+88], rdx
mov rax, [r11+32]
mul r8
mov [rsp+32], rax
mov [rsp+96], rdx
mov rax, [r11+40]
mul r8
mov [rsp+40], rax
mov [rsp+104], rdx
mov rax, [r11+48]
mul r8
mov [rsp+48], rax
mov [rsp+112], rdx
mov rax, [r11+56]
mul r8
mov [rsp+56], rax
mov rax, [rsp+8]
add rax, [rsp+64]
mov [rsp+8], rax
mov rax, [rsp+16]
adc rax, [rsp+72]
mov [rsp+16], rax
mov rax, [rsp+24]
adc rax, [rsp+80]
mov [rsp+24], rax
mov rax, [rsp+32]
adc rax, [rsp+88]
mov [rsp+32], rax
mov rax, [rsp+40]
adc rax, [rsp+96]
mov [rsp+40], rax
mov rax, [rsp+48]
adc rax, [rsp+104]
mov [rsp+48], rax
mov rax, [rsp+56]
adc rax, [rsp+112]
mov [rsp+56], rax
adc rdx, 0
mov rax, [rsp]
add [rcx], rax
mov rax, [rsp+8]
adc [rcx+8], rax
mov rax, [rsp+16]
adc [rcx+16], rax
mov rax, [rsp+24]
adc [rcx+24], rax
mov rax, [rsp+32]
adc [rcx+32], rax
mov rax, [rsp+40]
adc [rcx+40], rax
mov rax, [rsp+48]
adc [rcx+48], rax
mov rax, [rsp+56]
adc [rcx+56], rax
adc rdx, 0
mov rax, rdx
add rsp, 120
ret
mclb_mulUnitAdd_slow8 endp
align 16
mclb_mulUnitAdd_slow9 proc export
sub rsp, 136
mov r11, rdx
mov rax, [r11]
mul r8
mov [rsp], rax
mov [rsp+72], rdx
mov rax, [r11+8]
mul r8
mov [rsp+8], rax
mov [rsp+80], rdx
mov rax, [r11+16]
mul r8
mov [rsp+16], rax
mov [rsp+88], rdx
mov rax, [r11+24]
mul r8
mov [rsp+24], rax
mov [rsp+96], rdx
mov rax, [r11+32]
mul r8
mov [rsp+32], rax
mov [rsp+104], rdx
mov rax, [r11+40]
mul r8
mov [rsp+40], rax
mov [rsp+112], rdx
mov rax, [r11+48]
mul r8
mov [rsp+48], rax
mov [rsp+120], rdx
mov rax, [r11+56]
mul r8
mov [rsp+56], rax
mov [rsp+128], rdx
mov rax, [r11+64]
mul r8
mov [rsp+64], rax
mov rax, [rsp+8]
add rax, [rsp+72]
mov [rsp+8], rax
mov rax, [rsp+16]
adc rax, [rsp+80]
mov [rsp+16], rax
mov rax, [rsp+24]
adc rax, [rsp+88]
mov [rsp+24], rax
mov rax, [rsp+32]
adc rax, [rsp+96]
mov [rsp+32], rax
mov rax, [rsp+40]
adc rax, [rsp+104]
mov [rsp+40], rax
mov rax, [rsp+48]
adc rax, [rsp+112]
mov [rsp+48], rax
mov rax, [rsp+56]
adc rax, [rsp+120]
mov [rsp+56], rax
mov rax, [rsp+64]
adc rax, [rsp+128]
mov [rsp+64], rax
adc rdx, 0
mov rax, [rsp]
add [rcx], rax
mov rax, [rsp+8]
adc [rcx+8], rax
mov rax, [rsp+16]
adc [rcx+16], rax
mov rax, [rsp+24]
adc [rcx+24], rax
mov rax, [rsp+32]
adc [rcx+32], rax
mov rax, [rsp+40]
adc [rcx+40], rax
mov rax, [rsp+48]
adc [rcx+48], rax
mov rax, [rsp+56]
adc [rcx+56], rax
mov rax, [rsp+64]
adc [rcx+64], rax
adc rdx, 0
mov rax, rdx
add rsp, 136
ret
mclb_mulUnitAdd_slow9 endp
align 16
mclb_mul_fast1 proc export
mov r11, rdx
mov rdx, [r11]
mulx r9, rax, [r8]
mov [rcx], rax
xor rax, rax
adc r9, 0
mov [rcx+8], r9
ret
mclb_mul_fast1 endp
align 16
mclb_mul_fast2 proc export
push rdi
mov r11, rdx
mov rdx, [r11]
mulx r9, rax, [r8]
mov [rcx], rax
xor rax, rax
mulx r10, rax, [r8+8]
adcx r9, rax
adc r10, 0
mov rdx, [r11+8]
xor rax, rax
mulx rdi, rax, [r8]
adox r9, rax
mov [rcx+8], r9
adcx r10, rdi
mulx rdi, rax, [r8+8]
adox r10, rax
mov rax, 0
adox rdi, rax
adc rdi, rax
mov [rcx+16], r10
mov [rcx+24], rdi
pop rdi
ret
mclb_mul_fast2 endp
align 16
mclb_mul_fast3 proc export
push rdi
push rsi
mov r11, rdx
mov rdx, [r11]
mulx r9, rax, [r8]
mov [rcx], rax
xor rax, rax
mulx r10, rax, [r8+8]
adcx r9, rax
mulx rdi, rax, [r8+16]
adcx r10, rax
adc rdi, 0
mov rdx, [r11+8]
xor rax, rax
mulx rsi, rax, [r8]
adox r9, rax
mov [rcx+8], r9
adcx r10, rsi
mulx rsi, rax, [r8+8]
adox r10, rax
adcx rdi, rsi
mulx rsi, rax, [r8+16]
adox rdi, rax
mov rax, 0
adox rsi, rax
adc rsi, rax
mov rdx, [r11+16]
xor rax, rax
mulx r9, rax, [r8]
adox r10, rax
mov [rcx+16], r10
adcx rdi, r9
mulx r9, rax, [r8+8]
adox rdi, rax
adcx rsi, r9
mulx r9, rax, [r8+16]
adox rsi, rax
mov rax, 0
adox r9, rax
adc r9, rax
mov [rcx+24], rdi
mov [rcx+32], rsi
mov [rcx+40], r9
pop rsi
pop rdi
ret
mclb_mul_fast3 endp
align 16
mclb_mul_fast4 proc export
push rdi
push rsi
push rbx
mov r11, rdx
mov rdx, [r11]
mulx r9, rax, [r8]
mov [rcx], rax
xor rax, rax
mulx r10, rax, [r8+8]
adcx r9, rax
mulx rdi, rax, [r8+16]
adcx r10, rax
mulx rsi, rax, [r8+24]
adcx rdi, rax
adc rsi, 0
mov rdx, [r11+8]
xor rax, rax
mulx rbx, rax, [r8]
adox r9, rax
mov [rcx+8], r9
adcx r10, rbx
mulx rbx, rax, [r8+8]
adox r10, rax
adcx rdi, rbx
mulx rbx, rax, [r8+16]
adox rdi, rax
adcx rsi, rbx
mulx rbx, rax, [r8+24]
adox rsi, rax
mov rax, 0
adox rbx, rax
adc rbx, rax
mov rdx, [r11+16]
xor rax, rax
mulx r9, rax, [r8]
adox r10, rax
mov [rcx+16], r10
adcx rdi, r9
mulx r9, rax, [r8+8]
adox rdi, rax
adcx rsi, r9
mulx r9, rax, [r8+16]
adox rsi, rax
adcx rbx, r9
mulx r9, rax, [r8+24]
adox rbx, rax
mov rax, 0
adox r9, rax
adc r9, rax
mov rdx, [r11+24]
xor rax, rax
mulx r10, rax, [r8]
adox rdi, rax
mov [rcx+24], rdi
adcx rsi, r10
mulx r10, rax, [r8+8]
adox rsi, rax
adcx rbx, r10
mulx r10, rax, [r8+16]
adox rbx, rax
adcx r9, r10
mulx r10, rax, [r8+24]
adox r9, rax
mov rax, 0
adox r10, rax
adc r10, rax
mov [rcx+32], rsi
mov [rcx+40], rbx
mov [rcx+48], r9
mov [rcx+56], r10
pop rbx
pop rsi
pop rdi
ret
mclb_mul_fast4 endp
align 16
mclb_mul_fast5 proc export
push rdi
push rsi
push rbx
push rbp
mov r11, rdx
mov rdx, [r11]
mulx r9, rax, [r8]
mov [rcx], rax
xor rax, rax
mulx r10, rax, [r8+8]
adcx r9, rax
mulx rdi, rax, [r8+16]
adcx r10, rax
mulx rsi, rax, [r8+24]
adcx rdi, rax
mulx rbx, rax, [r8+32]
adcx rsi, rax
adc rbx, 0
mov rdx, [r11+8]
xor rax, rax
mulx rbp, rax, [r8]
adox r9, rax
mov [rcx+8], r9
adcx r10, rbp
mulx rbp, rax, [r8+8]
adox r10, rax
adcx rdi, rbp
mulx rbp, rax, [r8+16]
adox rdi, rax
adcx rsi, rbp
mulx rbp, rax, [r8+24]
adox rsi, rax
adcx rbx, rbp
mulx rbp, rax, [r8+32]
adox rbx, rax
mov rax, 0
adox rbp, rax
adc rbp, rax
mov rdx, [r11+16]
xor rax, rax
mulx r9, rax, [r8]
adox r10, rax
mov [rcx+16], r10
adcx rdi, r9
mulx r9, rax, [r8+8]
adox rdi, rax
adcx rsi, r9
mulx r9, rax, [r8+16]
adox rsi, rax
adcx rbx, r9
mulx r9, rax, [r8+24]
adox rbx, rax
adcx rbp, r9
mulx r9, rax, [r8+32]
adox rbp, rax
mov rax, 0
adox r9, rax
adc r9, rax
mov rdx, [r11+24]
xor rax, rax
mulx r10, rax, [r8]
adox rdi, rax
mov [rcx+24], rdi
adcx rsi, r10
mulx r10, rax, [r8+8]
adox rsi, rax
adcx rbx, r10
mulx r10, rax, [r8+16]
adox rbx, rax
adcx rbp, r10
mulx r10, rax, [r8+24]
adox rbp, rax
adcx r9, r10
mulx r10, rax, [r8+32]
adox r9, rax
mov rax, 0
adox r10, rax
adc r10, rax
mov rdx, [r11+32]
xor rax, rax
mulx rdi, rax, [r8]
adox rsi, rax
mov [rcx+32], rsi
adcx rbx, rdi
mulx rdi, rax, [r8+8]
adox rbx, rax
adcx rbp, rdi
mulx rdi, rax, [r8+16]
adox rbp, rax
adcx r9, rdi
mulx rdi, rax, [r8+24]
adox r9, rax
adcx r10, rdi
mulx rdi, rax, [r8+32]
adox r10, rax
mov rax, 0
adox rdi, rax
adc rdi, rax
mov [rcx+40], rbx
mov [rcx+48], rbp
mov [rcx+56], r9
mov [rcx+64], r10
mov [rcx+72], rdi
pop rbp
pop rbx
pop rsi
pop rdi
ret
mclb_mul_fast5 endp
align 16
mclb_mul_fast6 proc export
push rdi
push rsi
push rbx
push rbp
push r12
mov r11, rdx
mov rdx, [r11]
mulx r9, rax, [r8]
mov [rcx], rax
xor rax, rax
mulx r10, rax, [r8+8]
adcx r9, rax
mulx rdi, rax, [r8+16]
adcx r10, rax
mulx rsi, rax, [r8+24]
adcx rdi, rax
mulx rbx, rax, [r8+32]
adcx rsi, rax
mulx rbp, rax, [r8+40]
adcx rbx, rax
adc rbp, 0
mov rdx, [r11+8]
xor rax, rax
mulx r12, rax, [r8]
adox r9, rax
mov [rcx+8], r9
adcx r10, r12
mulx r12, rax, [r8+8]
adox r10, rax
adcx rdi, r12
mulx r12, rax, [r8+16]
adox rdi, rax
adcx rsi, r12
mulx r12, rax, [r8+24]
adox rsi, rax
adcx rbx, r12
mulx r12, rax, [r8+32]
adox rbx, rax
adcx rbp, r12
mulx r12, rax, [r8+40]
adox rbp, rax
mov rax, 0
adox r12, rax
adc r12, rax
mov rdx, [r11+16]
xor rax, rax
mulx r9, rax, [r8]
adox r10, rax
mov [rcx+16], r10
adcx rdi, r9
mulx r9, rax, [r8+8]
adox rdi, rax
adcx rsi, r9
mulx r9, rax, [r8+16]
adox rsi, rax
adcx rbx, r9
mulx r9, rax, [r8+24]
adox rbx, rax
adcx rbp, r9
mulx r9, rax, [r8+32]
adox rbp, rax
adcx r12, r9
mulx r9, rax, [r8+40]
adox r12, rax
mov rax, 0
adox r9, rax
adc r9, rax
mov rdx, [r11+24]
xor rax, rax
mulx r10, rax, [r8]
adox rdi, rax
mov [rcx+24], rdi
adcx rsi, r10
mulx r10, rax, [r8+8]
adox rsi, rax
adcx rbx, r10
mulx r10, rax, [r8+16]
adox rbx, rax
adcx rbp, r10
mulx r10, rax, [r8+24]
adox rbp, rax
adcx r12, r10
mulx r10, rax, [r8+32]
adox r12, rax
adcx r9, r10
mulx r10, rax, [r8+40]
adox r9, rax
mov rax, 0
adox r10, rax
adc r10, rax
mov rdx, [r11+32]
xor rax, rax
mulx rdi, rax, [r8]
adox rsi, rax
mov [rcx+32], rsi
adcx rbx, rdi
mulx rdi, rax, [r8+8]
adox rbx, rax
adcx rbp, rdi
mulx rdi, rax, [r8+16]
adox rbp, rax
adcx r12, rdi
mulx rdi, rax, [r8+24]
adox r12, rax
adcx r9, rdi
mulx rdi, rax, [r8+32]
adox r9, rax
adcx r10, rdi
mulx rdi, rax, [r8+40]
adox r10, rax
mov rax, 0
adox rdi, rax
adc rdi, rax
mov rdx, [r11+40]
xor rax, rax
mulx rsi, rax, [r8]
adox rbx, rax
mov [rcx+40], rbx
adcx rbp, rsi
mulx rsi, rax, [r8+8]
adox rbp, rax
adcx r12, rsi
mulx rsi, rax, [r8+16]
adox r12, rax
adcx r9, rsi
mulx rsi, rax, [r8+24]
adox r9, rax
adcx r10, rsi
mulx rsi, rax, [r8+32]
adox r10, rax
adcx rdi, rsi
mulx rsi, rax, [r8+40]
adox rdi, rax
mov rax, 0
adox rsi, rax
adc rsi, rax
mov [rcx+48], rbp
mov [rcx+56], r12
mov [rcx+64], r9
mov [rcx+72], r10
mov [rcx+80], rdi
mov [rcx+88], rsi
pop r12
pop rbp
pop rbx
pop rsi
pop rdi
ret
mclb_mul_fast6 endp
align 16
mclb_mul_fast7 proc export
push rdi
push rsi
push rbx
push rbp
push r12
push r13
mov r11, rdx
mov rdx, [r11]
mulx r9, rax, [r8]
mov [rcx], rax
xor rax, rax
mulx r10, rax, [r8+8]
adcx r9, rax
mulx rdi, rax, [r8+16]
adcx r10, rax
mulx rsi, rax, [r8+24]
adcx rdi, rax
mulx rbx, rax, [r8+32]
adcx rsi, rax
mulx rbp, rax, [r8+40]
adcx rbx, rax
mulx r12, rax, [r8+48]
adcx rbp, rax
adc r12, 0
mov rdx, [r11+8]
xor rax, rax
mulx r13, rax, [r8]
adox r9, rax
mov [rcx+8], r9
adcx r10, r13
mulx r13, rax, [r8+8]
adox r10, rax
adcx rdi, r13
mulx r13, rax, [r8+16]
adox rdi, rax
adcx rsi, r13
mulx r13, rax, [r8+24]
adox rsi, rax
adcx rbx, r13
mulx r13, rax, [r8+32]
adox rbx, rax
adcx rbp, r13
mulx r13, rax, [r8+40]
adox rbp, rax
adcx r12, r13
mulx r13, rax, [r8+48]
adox r12, rax
mov rax, 0
adox r13, rax
adc r13, rax
mov rdx, [r11+16]
xor rax, rax
mulx r9, rax, [r8]
adox r10, rax
mov [rcx+16], r10
adcx rdi, r9
mulx r9, rax, [r8+8]
adox rdi, rax
adcx rsi, r9
mulx r9, rax, [r8+16]
adox rsi, rax
adcx rbx, r9
mulx r9, rax, [r8+24]
adox rbx, rax
adcx rbp, r9
mulx r9, rax, [r8+32]
adox rbp, rax
adcx r12, r9
mulx r9, rax, [r8+40]
adox r12, rax
adcx r13, r9
mulx r9, rax, [r8+48]
adox r13, rax
mov rax, 0
adox r9, rax
adc r9, rax
mov rdx, [r11+24]
xor rax, rax
mulx r10, rax, [r8]
adox rdi, rax
mov [rcx+24], rdi
adcx rsi, r10
mulx r10, rax, [r8+8]
adox rsi, rax
adcx rbx, r10
mulx r10, rax, [r8+16]
adox rbx, rax
adcx rbp, r10
mulx r10, rax, [r8+24]
adox rbp, rax
adcx r12, r10
mulx r10, rax, [r8+32]
adox r12, rax
adcx r13, r10
mulx r10, rax, [r8+40]
adox r13, rax
adcx r9, r10
mulx r10, rax, [r8+48]
adox r9, rax
mov rax, 0
adox r10, rax
adc r10, rax
mov rdx, [r11+32]
xor rax, rax
mulx rdi, rax, [r8]
adox rsi, rax
mov [rcx+32], rsi
adcx rbx, rdi
mulx rdi, rax, [r8+8]
adox rbx, rax
adcx rbp, rdi
mulx rdi, rax, [r8+16]
adox rbp, rax
adcx r12, rdi
mulx rdi, rax, [r8+24]
adox r12, rax
adcx r13, rdi
mulx rdi, rax, [r8+32]
adox r13, rax
adcx r9, rdi
mulx rdi, rax, [r8+40]
adox r9, rax
adcx r10, rdi
mulx rdi, rax, [r8+48]
adox r10, rax
mov rax, 0
adox rdi, rax
adc rdi, rax
mov rdx, [r11+40]
xor rax, rax
mulx rsi, rax, [r8]
adox rbx, rax
mov [rcx+40], rbx
adcx rbp, rsi
mulx rsi, rax, [r8+8]
adox rbp, rax
adcx r12, rsi
mulx rsi, rax, [r8+16]
adox r12, rax
adcx r13, rsi
mulx rsi, rax, [r8+24]
adox r13, rax
adcx r9, rsi
mulx rsi, rax, [r8+32]
adox r9, rax
adcx r10, rsi
mulx rsi, rax, [r8+40]
adox r10, rax
adcx rdi, rsi
mulx rsi, rax, [r8+48]
adox rdi, rax
mov rax, 0
adox rsi, rax
adc rsi, rax
mov rdx, [r11+48]
xor rax, rax
mulx rbx, rax, [r8]
adox rbp, rax
mov [rcx+48], rbp
adcx r12, rbx
mulx rbx, rax, [r8+8]
adox r12, rax
adcx r13, rbx
mulx rbx, rax, [r8+16]
adox r13, rax
adcx r9, rbx
mulx rbx, rax, [r8+24]
adox r9, rax
adcx r10, rbx
mulx rbx, rax, [r8+32]
adox r10, rax
adcx rdi, rbx
mulx rbx, rax, [r8+40]
adox rdi, rax
adcx rsi, rbx
mulx rbx, rax, [r8+48]
adox rsi, rax
mov rax, 0
adox rbx, rax
adc rbx, rax
mov [rcx+56], r12
mov [rcx+64], r13
mov [rcx+72], r9
mov [rcx+80], r10
mov [rcx+88], rdi
mov [rcx+96], rsi
mov [rcx+104], rbx
pop r13
pop r12
pop rbp
pop rbx
pop rsi
pop rdi
ret
mclb_mul_fast7 endp
align 16
mclb_mul_fast8 proc export
push rdi
push rsi
push rbx
push rbp
push r12
push r13
push r14
mov r11, rdx
mov rdx, [r11]
mulx r9, rax, [r8]
mov [rcx], rax
xor rax, rax
mulx r10, rax, [r8+8]
adcx r9, rax
mulx rdi, rax, [r8+16]
adcx r10, rax
mulx rsi, rax, [r8+24]
adcx rdi, rax
mulx rbx, rax, [r8+32]
adcx rsi, rax
mulx rbp, rax, [r8+40]
adcx rbx, rax
mulx r12, rax, [r8+48]
adcx rbp, rax
mulx r13, rax, [r8+56]
adcx r12, rax
adc r13, 0
mov rdx, [r11+8]
xor rax, rax
mulx r14, rax, [r8]
adox r9, rax
mov [rcx+8], r9
adcx r10, r14
mulx r14, rax, [r8+8]
adox r10, rax
adcx rdi, r14
mulx r14, rax, [r8+16]
adox rdi, rax
adcx rsi, r14
mulx r14, rax, [r8+24]
adox rsi, rax
adcx rbx, r14
mulx r14, rax, [r8+32]
adox rbx, rax
adcx rbp, r14
mulx r14, rax, [r8+40]
adox rbp, rax
adcx r12, r14
mulx r14, rax, [r8+48]
adox r12, rax
adcx r13, r14
mulx r14, rax, [r8+56]
adox r13, rax
mov rax, 0
adox r14, rax
adc r14, rax
mov rdx, [r11+16]
xor rax, rax
mulx r9, rax, [r8]
adox r10, rax
mov [rcx+16], r10
adcx rdi, r9
mulx r9, rax, [r8+8]
adox rdi, rax
adcx rsi, r9
mulx r9, rax, [r8+16]
adox rsi, rax
adcx rbx, r9
mulx r9, rax, [r8+24]
adox rbx, rax
adcx rbp, r9
mulx r9, rax, [r8+32]
adox rbp, rax
adcx r12, r9
mulx r9, rax, [r8+40]
adox r12, rax
adcx r13, r9
mulx r9, rax, [r8+48]
adox r13, rax
adcx r14, r9
mulx r9, rax, [r8+56]
adox r14, rax
mov rax, 0
adox r9, rax
adc r9, rax
mov rdx, [r11+24]
xor rax, rax
mulx r10, rax, [r8]
adox rdi, rax
mov [rcx+24], rdi
adcx rsi, r10
mulx r10, rax, [r8+8]
adox rsi, rax
adcx rbx, r10
mulx r10, rax, [r8+16]
adox rbx, rax
adcx rbp, r10
mulx r10, rax, [r8+24]
adox rbp, rax
adcx r12, r10
mulx r10, rax, [r8+32]
adox r12, rax
adcx r13, r10
mulx r10, rax, [r8+40]
adox r13, rax
adcx r14, r10
mulx r10, rax, [r8+48]
adox r14, rax
adcx r9, r10
mulx r10, rax, [r8+56]
adox r9, rax
mov rax, 0
adox r10, rax
adc r10, rax
mov rdx, [r11+32]
xor rax, rax
mulx rdi, rax, [r8]
adox rsi, rax
mov [rcx+32], rsi
adcx rbx, rdi
mulx rdi, rax, [r8+8]
adox rbx, rax
adcx rbp, rdi
mulx rdi, rax, [r8+16]
adox rbp, rax
adcx r12, rdi
mulx rdi, rax, [r8+24]
adox r12, rax
adcx r13, rdi
mulx rdi, rax, [r8+32]
adox r13, rax
adcx r14, rdi
mulx rdi, rax, [r8+40]
adox r14, rax
adcx r9, rdi
mulx rdi, rax, [r8+48]
adox r9, rax
adcx r10, rdi
mulx rdi, rax, [r8+56]
adox r10, rax
mov rax, 0
adox rdi, rax
adc rdi, rax
mov rdx, [r11+40]
xor rax, rax
mulx rsi, rax, [r8]
adox rbx, rax
mov [rcx+40], rbx
adcx rbp, rsi
mulx rsi, rax, [r8+8]
adox rbp, rax
adcx r12, rsi
mulx rsi, rax, [r8+16]
adox r12, rax
adcx r13, rsi
mulx rsi, rax, [r8+24]
adox r13, rax
adcx r14, rsi
mulx rsi, rax, [r8+32]
adox r14, rax
adcx r9, rsi
mulx rsi, rax, [r8+40]
adox r9, rax
adcx r10, rsi
mulx rsi, rax, [r8+48]
adox r10, rax
adcx rdi, rsi
mulx rsi, rax, [r8+56]
adox rdi, rax
mov rax, 0
adox rsi, rax
adc rsi, rax
mov rdx, [r11+48]
xor rax, rax
mulx rbx, rax, [r8]
adox rbp, rax
mov [rcx+48], rbp
adcx r12, rbx
mulx rbx, rax, [r8+8]
adox r12, rax
adcx r13, rbx
mulx rbx, rax, [r8+16]
adox r13, rax
adcx r14, rbx
mulx rbx, rax, [r8+24]
adox r14, rax
adcx r9, rbx
mulx rbx, rax, [r8+32]
adox r9, rax
adcx r10, rbx
mulx rbx, rax, [r8+40]
adox r10, rax
adcx rdi, rbx
mulx rbx, rax, [r8+48]
adox rdi, rax
adcx rsi, rbx
mulx rbx, rax, [r8+56]
adox rsi, rax
mov rax, 0
adox rbx, rax
adc rbx, rax
mov rdx, [r11+56]
xor rax, rax
mulx rbp, rax, [r8]
adox r12, rax
mov [rcx+56], r12
adcx r13, rbp
mulx rbp, rax, [r8+8]
adox r13, rax
adcx r14, rbp
mulx rbp, rax, [r8+16]
adox r14, rax
adcx r9, rbp
mulx rbp, rax, [r8+24]
adox r9, rax
adcx r10, rbp
mulx rbp, rax, [r8+32]
adox r10, rax
adcx rdi, rbp
mulx rbp, rax, [r8+40]
adox rdi, rax
adcx rsi, rbp
mulx rbp, rax, [r8+48]
adox rsi, rax
adcx rbx, rbp
mulx rbp, rax, [r8+56]
adox rbx, rax
mov rax, 0
adox rbp, rax
adc rbp, rax
mov [rcx+64], r13
mov [rcx+72], r14
mov [rcx+80], r9
mov [rcx+88], r10
mov [rcx+96], rdi
mov [rcx+104], rsi
mov [rcx+112], rbx
mov [rcx+120], rbp
pop r14
pop r13
pop r12
pop rbp
pop rbx
pop rsi
pop rdi
ret
mclb_mul_fast8 endp
align 16
mclb_mul_fast9 proc export
push rdi
push rsi
push rbx
push rbp
push r12
push r13
push r14
push r15
mov r11, rdx
mov rdx, [r11]
mulx r9, rax, [r8]
mov [rcx], rax
xor rax, rax
mulx r10, rax, [r8+8]
adcx r9, rax
mulx rdi, rax, [r8+16]
adcx r10, rax
mulx rsi, rax, [r8+24]
adcx rdi, rax
mulx rbx, rax, [r8+32]
adcx rsi, rax
mulx rbp, rax, [r8+40]
adcx rbx, rax
mulx r12, rax, [r8+48]
adcx rbp, rax
mulx r13, rax, [r8+56]
adcx r12, rax
mulx r14, rax, [r8+64]
adcx r13, rax
adc r14, 0
mov rdx, [r11+8]
xor rax, rax
mulx r15, rax, [r8]
adox r9, rax
mov [rcx+8], r9
adcx r10, r15
mulx r15, rax, [r8+8]
adox r10, rax
adcx rdi, r15
mulx r15, rax, [r8+16]
adox rdi, rax
adcx rsi, r15
mulx r15, rax, [r8+24]
adox rsi, rax
adcx rbx, r15
mulx r15, rax, [r8+32]
adox rbx, rax
adcx rbp, r15
mulx r15, rax, [r8+40]
adox rbp, rax
adcx r12, r15
mulx r15, rax, [r8+48]
adox r12, rax
adcx r13, r15
mulx r15, rax, [r8+56]
adox r13, rax
adcx r14, r15
mulx r15, rax, [r8+64]
adox r14, rax
mov rax, 0
adox r15, rax
adc r15, rax
mov rdx, [r11+16]
xor rax, rax
mulx r9, rax, [r8]
adox r10, rax
mov [rcx+16], r10
adcx rdi, r9
mulx r9, rax, [r8+8]
adox rdi, rax
adcx rsi, r9
mulx r9, rax, [r8+16]
adox rsi, rax
adcx rbx, r9
mulx r9, rax, [r8+24]
adox rbx, rax
adcx rbp, r9
mulx r9, rax, [r8+32]
adox rbp, rax
adcx r12, r9
mulx r9, rax, [r8+40]
adox r12, rax
adcx r13, r9
mulx r9, rax, [r8+48]
adox r13, rax
adcx r14, r9
mulx r9, rax, [r8+56]
adox r14, rax
adcx r15, r9
mulx r9, rax, [r8+64]
adox r15, rax
mov rax, 0
adox r9, rax
adc r9, rax
mov rdx, [r11+24]
xor rax, rax
mulx r10, rax, [r8]
adox rdi, rax
mov [rcx+24], rdi
adcx rsi, r10
mulx r10, rax, [r8+8]
adox rsi, rax
adcx rbx, r10
mulx r10, rax, [r8+16]
adox rbx, rax
adcx rbp, r10
mulx r10, rax, [r8+24]
adox rbp, rax
adcx r12, r10
mulx r10, rax, [r8+32]
adox r12, rax
adcx r13, r10
mulx r10, rax, [r8+40]
adox r13, rax
adcx r14, r10
mulx r10, rax, [r8+48]
adox r14, rax
adcx r15, r10
mulx r10, rax, [r8+56]
adox r15, rax
adcx r9, r10
mulx r10, rax, [r8+64]
adox r9, rax
mov rax, 0
adox r10, rax
adc r10, rax
mov rdx, [r11+32]
xor rax, rax
mulx rdi, rax, [r8]
adox rsi, rax
mov [rcx+32], rsi
adcx rbx, rdi
mulx rdi, rax, [r8+8]
adox rbx, rax
adcx rbp, rdi
mulx rdi, rax, [r8+16]
adox rbp, rax
adcx r12, rdi
mulx rdi, rax, [r8+24]
adox r12, rax
adcx r13, rdi
mulx rdi, rax, [r8+32]
adox r13, rax
adcx r14, rdi
mulx rdi, rax, [r8+40]
adox r14, rax
adcx r15, rdi
mulx rdi, rax, [r8+48]
adox r15, rax
adcx r9, rdi
mulx rdi, rax, [r8+56]
adox r9, rax
adcx r10, rdi
mulx rdi, rax, [r8+64]
adox r10, rax
mov rax, 0
adox rdi, rax
adc rdi, rax
mov rdx, [r11+40]
xor rax, rax
mulx rsi, rax, [r8]
adox rbx, rax
mov [rcx+40], rbx
adcx rbp, rsi
mulx rsi, rax, [r8+8]
adox rbp, rax
adcx r12, rsi
mulx rsi, rax, [r8+16]
adox r12, rax
adcx r13, rsi
mulx rsi, rax, [r8+24]
adox r13, rax
adcx r14, rsi
mulx rsi, rax, [r8+32]
adox r14, rax
adcx r15, rsi
mulx rsi, rax, [r8+40]
adox r15, rax
adcx r9, rsi
mulx rsi, rax, [r8+48]
adox r9, rax
adcx r10, rsi
mulx rsi, rax, [r8+56]
adox r10, rax
adcx rdi, rsi
mulx rsi, rax, [r8+64]
adox rdi, rax
mov rax, 0
adox rsi, rax
adc rsi, rax
mov rdx, [r11+48]
xor rax, rax
mulx rbx, rax, [r8]
adox rbp, rax
mov [rcx+48], rbp
adcx r12, rbx
mulx rbx, rax, [r8+8]
adox r12, rax
adcx r13, rbx
mulx rbx, rax, [r8+16]
adox r13, rax
adcx r14, rbx
mulx rbx, rax, [r8+24]
adox r14, rax
adcx r15, rbx
mulx rbx, rax, [r8+32]
adox r15, rax
adcx r9, rbx
mulx rbx, rax, [r8+40]
adox r9, rax
adcx r10, rbx
mulx rbx, rax, [r8+48]
adox r10, rax
adcx rdi, rbx
mulx rbx, rax, [r8+56]
adox rdi, rax
adcx rsi, rbx
mulx rbx, rax, [r8+64]
adox rsi, rax
mov rax, 0
adox rbx, rax
adc rbx, rax
mov rdx, [r11+56]
xor rax, rax
mulx rbp, rax, [r8]
adox r12, rax
mov [rcx+56], r12
adcx r13, rbp
mulx rbp, rax, [r8+8]
adox r13, rax
adcx r14, rbp
mulx rbp, rax, [r8+16]
adox r14, rax
adcx r15, rbp
mulx rbp, rax, [r8+24]
adox r15, rax
adcx r9, rbp
mulx rbp, rax, [r8+32]
adox r9, rax
adcx r10, rbp
mulx rbp, rax, [r8+40]
adox r10, rax
adcx rdi, rbp
mulx rbp, rax, [r8+48]
adox rdi, rax
adcx rsi, rbp
mulx rbp, rax, [r8+56]
adox rsi, rax
adcx rbx, rbp
mulx rbp, rax, [r8+64]
adox rbx, rax
mov rax, 0
adox rbp, rax
adc rbp, rax
mov rdx, [r11+64]
xor rax, rax
mulx r12, rax, [r8]
adox r13, rax
mov [rcx+64], r13
adcx r14, r12
mulx r12, rax, [r8+8]
adox r14, rax
adcx r15, r12
mulx r12, rax, [r8+16]
adox r15, rax
adcx r9, r12
mulx r12, rax, [r8+24]
adox r9, rax
adcx r10, r12
mulx r12, rax, [r8+32]
adox r10, rax
adcx rdi, r12
mulx r12, rax, [r8+40]
adox rdi, rax
adcx rsi, r12
mulx r12, rax, [r8+48]
adox rsi, rax
adcx rbx, r12
mulx r12, rax, [r8+56]
adox rbx, rax
adcx rbp, r12
mulx r12, rax, [r8+64]
adox rbp, rax
mov rax, 0
adox r12, rax
adc r12, rax
mov [rcx+72], r14
mov [rcx+80], r15
mov [rcx+88], r9
mov [rcx+96], r10
mov [rcx+104], rdi
mov [rcx+112], rsi
mov [rcx+120], rbx
mov [rcx+128], rbp
mov [rcx+136], r12
pop r15
pop r14
pop r13
pop r12
pop rbp
pop rbx
pop rsi
pop rdi
ret
mclb_mul_fast9 endp
align 16
mclb_sqr_fast1 proc export
mov r8, rdx
jmp mclb_mul_fast1
mclb_sqr_fast1 endp
align 16
mclb_sqr_fast2 proc export
mov r8, rdx
jmp mclb_mul_fast2
mclb_sqr_fast2 endp
align 16
mclb_sqr_fast3 proc export
mov r8, rdx
jmp mclb_mul_fast3
mclb_sqr_fast3 endp
align 16
mclb_sqr_fast4 proc export
mov r8, rdx
jmp mclb_mul_fast4
mclb_sqr_fast4 endp
align 16
mclb_sqr_fast5 proc export
mov r8, rdx
jmp mclb_mul_fast5
mclb_sqr_fast5 endp
align 16
mclb_sqr_fast6 proc export
mov r8, rdx
jmp mclb_mul_fast6
mclb_sqr_fast6 endp
align 16
mclb_sqr_fast7 proc export
mov r8, rdx
jmp mclb_mul_fast7
mclb_sqr_fast7 endp
align 16
mclb_sqr_fast8 proc export
mov r8, rdx
jmp mclb_mul_fast8
mclb_sqr_fast8 endp
align 16
mclb_sqr_fast9 proc export
mov r8, rdx
jmp mclb_mul_fast9
mclb_sqr_fast9 endp
align 16
mclb_udiv128 proc export
mov rax, rdx
mov rdx, rcx
div r8
mov [r9], rdx
ret
mclb_udiv128 endp
_text ends
end
