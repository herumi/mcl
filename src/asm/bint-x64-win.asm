; for masm (ml64.exe)
_data$x segment align(64)
mclb_fast_flag:
db 0
_data$x ends
_text$x segment align(64) execute
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
mclb_mulUnit_fast10 proc export
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
mulx r10, rax, [r11+64]
adc rax, r9
mov [rcx+64], rax
mulx rax, rdx, [r11+72]
adc rdx, r10
mov [rcx+72], rdx
adc rax, 0
ret
mclb_mulUnit_fast10 endp
align 16
mclb_mulUnit_fast11 proc export
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
mulx r10, rax, [r11+64]
adc rax, r9
mov [rcx+64], rax
mulx r9, rax, [r11+72]
adc rax, r10
mov [rcx+72], rax
mulx rax, rdx, [r11+80]
adc rdx, r9
mov [rcx+80], rdx
adc rax, 0
ret
mclb_mulUnit_fast11 endp
align 16
mclb_mulUnit_fast12 proc export
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
mulx r10, rax, [r11+64]
adc rax, r9
mov [rcx+64], rax
mulx r9, rax, [r11+72]
adc rax, r10
mov [rcx+72], rax
mulx r10, rax, [r11+80]
adc rax, r9
mov [rcx+80], rax
mulx rax, rdx, [r11+88]
adc rdx, r10
mov [rcx+88], rdx
adc rax, 0
ret
mclb_mulUnit_fast12 endp
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
mclb_mulUnitAdd_fast10 proc export
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
mov r9, [rcx+72]
adcx r9, rax
mulx rax, r10, [r11+72]
adox r9, r10
mov [rcx+72], r9
mov r9, 0
adcx rax, r9
adox rax, r9
ret
mclb_mulUnitAdd_fast10 endp
align 16
mclb_mulUnitAdd_fast11 proc export
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
mov r9, [rcx+72]
adcx r9, rax
mulx rax, r10, [r11+72]
adox r9, r10
mov [rcx+72], r9
mov r9, [rcx+80]
adcx r9, rax
mulx rax, r10, [r11+80]
adox r9, r10
mov [rcx+80], r9
mov r9, 0
adcx rax, r9
adox rax, r9
ret
mclb_mulUnitAdd_fast11 endp
align 16
mclb_mulUnitAdd_fast12 proc export
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
mov r9, [rcx+72]
adcx r9, rax
mulx rax, r10, [r11+72]
adox r9, r10
mov [rcx+72], r9
mov r9, [rcx+80]
adcx r9, rax
mulx rax, r10, [r11+80]
adox r9, r10
mov [rcx+80], r9
mov r9, [rcx+88]
adcx r9, rax
mulx rax, r10, [r11+88]
adox r9, r10
mov [rcx+88], r9
mov r9, 0
adcx rax, r9
adox rax, r9
ret
mclb_mulUnitAdd_fast12 endp
align 16
mclb_mul_fast1 proc export
mov r11, rdx
mov rax, [r11]
mov rdx, [r8]
mul rdx
mov [rcx], rax
mov [rcx+8], rdx
ret
mclb_mul_fast1 endp
align 16
mclb_mul_fast2 proc export
push rdi
mov r11, rdx
mov rdx, [r11]
mulx r9, rax, [r8]
mov [rcx], rax
mulx r10, rax, [r8+8]
add r9, rax
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
mulx r10, rax, [r8+8]
add r9, rax
mulx rdi, rax, [r8+16]
adc r10, rax
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
mulx r10, rax, [r8+8]
add r9, rax
mulx rdi, rax, [r8+16]
adc r10, rax
mulx rsi, rax, [r8+24]
adc rdi, rax
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
mulx r10, rax, [r8+8]
add r9, rax
mulx rdi, rax, [r8+16]
adc r10, rax
mulx rsi, rax, [r8+24]
adc rdi, rax
mulx rbx, rax, [r8+32]
adc rsi, rax
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
mulx r10, rax, [r8+8]
add r9, rax
mulx rdi, rax, [r8+16]
adc r10, rax
mulx rsi, rax, [r8+24]
adc rdi, rax
mulx rbx, rax, [r8+32]
adc rsi, rax
mulx rbp, rax, [r8+40]
adc rbx, rax
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
mclb_sqr_fast1 proc export
mov r11, rdx
mov rax, [r11]
mul rax
mov [rcx], rax
mov [rcx+8], rdx
ret
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
mclb_mulUnit_slow10 proc export
sub rsp, 152
mov r11, rdx
mov rax, [r11]
mul r8
mov [rcx], rax
mov [rsp+72], rdx
mov rax, [r11+8]
mul r8
mov [rsp], rax
mov [rsp+80], rdx
mov rax, [r11+16]
mul r8
mov [rsp+8], rax
mov [rsp+88], rdx
mov rax, [r11+24]
mul r8
mov [rsp+16], rax
mov [rsp+96], rdx
mov rax, [r11+32]
mul r8
mov [rsp+24], rax
mov [rsp+104], rdx
mov rax, [r11+40]
mul r8
mov [rsp+32], rax
mov [rsp+112], rdx
mov rax, [r11+48]
mul r8
mov [rsp+40], rax
mov [rsp+120], rdx
mov rax, [r11+56]
mul r8
mov [rsp+48], rax
mov [rsp+128], rdx
mov rax, [r11+64]
mul r8
mov [rsp+56], rax
mov [rsp+136], rdx
mov rax, [r11+72]
mul r8
mov [rsp+64], rax
mov rax, [rsp+72]
add rax, [rsp]
mov [rcx+8], rax
mov rax, [rsp+80]
adc rax, [rsp+8]
mov [rcx+16], rax
mov rax, [rsp+88]
adc rax, [rsp+16]
mov [rcx+24], rax
mov rax, [rsp+96]
adc rax, [rsp+24]
mov [rcx+32], rax
mov rax, [rsp+104]
adc rax, [rsp+32]
mov [rcx+40], rax
mov rax, [rsp+112]
adc rax, [rsp+40]
mov [rcx+48], rax
mov rax, [rsp+120]
adc rax, [rsp+48]
mov [rcx+56], rax
mov rax, [rsp+128]
adc rax, [rsp+56]
mov [rcx+64], rax
mov rax, [rsp+136]
adc rax, [rsp+64]
mov [rcx+72], rax
adc rdx, 0
mov rax, rdx
add rsp, 152
ret
mclb_mulUnit_slow10 endp
align 16
mclb_mulUnit_slow11 proc export
sub rsp, 168
mov r11, rdx
mov rax, [r11]
mul r8
mov [rcx], rax
mov [rsp+80], rdx
mov rax, [r11+8]
mul r8
mov [rsp], rax
mov [rsp+88], rdx
mov rax, [r11+16]
mul r8
mov [rsp+8], rax
mov [rsp+96], rdx
mov rax, [r11+24]
mul r8
mov [rsp+16], rax
mov [rsp+104], rdx
mov rax, [r11+32]
mul r8
mov [rsp+24], rax
mov [rsp+112], rdx
mov rax, [r11+40]
mul r8
mov [rsp+32], rax
mov [rsp+120], rdx
mov rax, [r11+48]
mul r8
mov [rsp+40], rax
mov [rsp+128], rdx
mov rax, [r11+56]
mul r8
mov [rsp+48], rax
mov [rsp+136], rdx
mov rax, [r11+64]
mul r8
mov [rsp+56], rax
mov [rsp+144], rdx
mov rax, [r11+72]
mul r8
mov [rsp+64], rax
mov [rsp+152], rdx
mov rax, [r11+80]
mul r8
mov [rsp+72], rax
mov rax, [rsp+80]
add rax, [rsp]
mov [rcx+8], rax
mov rax, [rsp+88]
adc rax, [rsp+8]
mov [rcx+16], rax
mov rax, [rsp+96]
adc rax, [rsp+16]
mov [rcx+24], rax
mov rax, [rsp+104]
adc rax, [rsp+24]
mov [rcx+32], rax
mov rax, [rsp+112]
adc rax, [rsp+32]
mov [rcx+40], rax
mov rax, [rsp+120]
adc rax, [rsp+40]
mov [rcx+48], rax
mov rax, [rsp+128]
adc rax, [rsp+48]
mov [rcx+56], rax
mov rax, [rsp+136]
adc rax, [rsp+56]
mov [rcx+64], rax
mov rax, [rsp+144]
adc rax, [rsp+64]
mov [rcx+72], rax
mov rax, [rsp+152]
adc rax, [rsp+72]
mov [rcx+80], rax
adc rdx, 0
mov rax, rdx
add rsp, 168
ret
mclb_mulUnit_slow11 endp
align 16
mclb_mulUnit_slow12 proc export
sub rsp, 184
mov r11, rdx
mov rax, [r11]
mul r8
mov [rcx], rax
mov [rsp+88], rdx
mov rax, [r11+8]
mul r8
mov [rsp], rax
mov [rsp+96], rdx
mov rax, [r11+16]
mul r8
mov [rsp+8], rax
mov [rsp+104], rdx
mov rax, [r11+24]
mul r8
mov [rsp+16], rax
mov [rsp+112], rdx
mov rax, [r11+32]
mul r8
mov [rsp+24], rax
mov [rsp+120], rdx
mov rax, [r11+40]
mul r8
mov [rsp+32], rax
mov [rsp+128], rdx
mov rax, [r11+48]
mul r8
mov [rsp+40], rax
mov [rsp+136], rdx
mov rax, [r11+56]
mul r8
mov [rsp+48], rax
mov [rsp+144], rdx
mov rax, [r11+64]
mul r8
mov [rsp+56], rax
mov [rsp+152], rdx
mov rax, [r11+72]
mul r8
mov [rsp+64], rax
mov [rsp+160], rdx
mov rax, [r11+80]
mul r8
mov [rsp+72], rax
mov [rsp+168], rdx
mov rax, [r11+88]
mul r8
mov [rsp+80], rax
mov rax, [rsp+88]
add rax, [rsp]
mov [rcx+8], rax
mov rax, [rsp+96]
adc rax, [rsp+8]
mov [rcx+16], rax
mov rax, [rsp+104]
adc rax, [rsp+16]
mov [rcx+24], rax
mov rax, [rsp+112]
adc rax, [rsp+24]
mov [rcx+32], rax
mov rax, [rsp+120]
adc rax, [rsp+32]
mov [rcx+40], rax
mov rax, [rsp+128]
adc rax, [rsp+40]
mov [rcx+48], rax
mov rax, [rsp+136]
adc rax, [rsp+48]
mov [rcx+56], rax
mov rax, [rsp+144]
adc rax, [rsp+56]
mov [rcx+64], rax
mov rax, [rsp+152]
adc rax, [rsp+64]
mov [rcx+72], rax
mov rax, [rsp+160]
adc rax, [rsp+72]
mov [rcx+80], rax
mov rax, [rsp+168]
adc rax, [rsp+80]
mov [rcx+88], rax
adc rdx, 0
mov rax, rdx
add rsp, 184
ret
mclb_mulUnit_slow12 endp
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
mclb_mulUnitAdd_slow10 proc export
sub rsp, 152
mov r11, rdx
mov rax, [r11]
mul r8
mov [rsp], rax
mov [rsp+80], rdx
mov rax, [r11+8]
mul r8
mov [rsp+8], rax
mov [rsp+88], rdx
mov rax, [r11+16]
mul r8
mov [rsp+16], rax
mov [rsp+96], rdx
mov rax, [r11+24]
mul r8
mov [rsp+24], rax
mov [rsp+104], rdx
mov rax, [r11+32]
mul r8
mov [rsp+32], rax
mov [rsp+112], rdx
mov rax, [r11+40]
mul r8
mov [rsp+40], rax
mov [rsp+120], rdx
mov rax, [r11+48]
mul r8
mov [rsp+48], rax
mov [rsp+128], rdx
mov rax, [r11+56]
mul r8
mov [rsp+56], rax
mov [rsp+136], rdx
mov rax, [r11+64]
mul r8
mov [rsp+64], rax
mov [rsp+144], rdx
mov rax, [r11+72]
mul r8
mov [rsp+72], rax
mov rax, [rsp+8]
add rax, [rsp+80]
mov [rsp+8], rax
mov rax, [rsp+16]
adc rax, [rsp+88]
mov [rsp+16], rax
mov rax, [rsp+24]
adc rax, [rsp+96]
mov [rsp+24], rax
mov rax, [rsp+32]
adc rax, [rsp+104]
mov [rsp+32], rax
mov rax, [rsp+40]
adc rax, [rsp+112]
mov [rsp+40], rax
mov rax, [rsp+48]
adc rax, [rsp+120]
mov [rsp+48], rax
mov rax, [rsp+56]
adc rax, [rsp+128]
mov [rsp+56], rax
mov rax, [rsp+64]
adc rax, [rsp+136]
mov [rsp+64], rax
mov rax, [rsp+72]
adc rax, [rsp+144]
mov [rsp+72], rax
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
mov rax, [rsp+72]
adc [rcx+72], rax
adc rdx, 0
mov rax, rdx
add rsp, 152
ret
mclb_mulUnitAdd_slow10 endp
align 16
mclb_mulUnitAdd_slow11 proc export
sub rsp, 168
mov r11, rdx
mov rax, [r11]
mul r8
mov [rsp], rax
mov [rsp+88], rdx
mov rax, [r11+8]
mul r8
mov [rsp+8], rax
mov [rsp+96], rdx
mov rax, [r11+16]
mul r8
mov [rsp+16], rax
mov [rsp+104], rdx
mov rax, [r11+24]
mul r8
mov [rsp+24], rax
mov [rsp+112], rdx
mov rax, [r11+32]
mul r8
mov [rsp+32], rax
mov [rsp+120], rdx
mov rax, [r11+40]
mul r8
mov [rsp+40], rax
mov [rsp+128], rdx
mov rax, [r11+48]
mul r8
mov [rsp+48], rax
mov [rsp+136], rdx
mov rax, [r11+56]
mul r8
mov [rsp+56], rax
mov [rsp+144], rdx
mov rax, [r11+64]
mul r8
mov [rsp+64], rax
mov [rsp+152], rdx
mov rax, [r11+72]
mul r8
mov [rsp+72], rax
mov [rsp+160], rdx
mov rax, [r11+80]
mul r8
mov [rsp+80], rax
mov rax, [rsp+8]
add rax, [rsp+88]
mov [rsp+8], rax
mov rax, [rsp+16]
adc rax, [rsp+96]
mov [rsp+16], rax
mov rax, [rsp+24]
adc rax, [rsp+104]
mov [rsp+24], rax
mov rax, [rsp+32]
adc rax, [rsp+112]
mov [rsp+32], rax
mov rax, [rsp+40]
adc rax, [rsp+120]
mov [rsp+40], rax
mov rax, [rsp+48]
adc rax, [rsp+128]
mov [rsp+48], rax
mov rax, [rsp+56]
adc rax, [rsp+136]
mov [rsp+56], rax
mov rax, [rsp+64]
adc rax, [rsp+144]
mov [rsp+64], rax
mov rax, [rsp+72]
adc rax, [rsp+152]
mov [rsp+72], rax
mov rax, [rsp+80]
adc rax, [rsp+160]
mov [rsp+80], rax
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
mov rax, [rsp+72]
adc [rcx+72], rax
mov rax, [rsp+80]
adc [rcx+80], rax
adc rdx, 0
mov rax, rdx
add rsp, 168
ret
mclb_mulUnitAdd_slow11 endp
align 16
mclb_mulUnitAdd_slow12 proc export
sub rsp, 184
mov r11, rdx
mov rax, [r11]
mul r8
mov [rsp], rax
mov [rsp+96], rdx
mov rax, [r11+8]
mul r8
mov [rsp+8], rax
mov [rsp+104], rdx
mov rax, [r11+16]
mul r8
mov [rsp+16], rax
mov [rsp+112], rdx
mov rax, [r11+24]
mul r8
mov [rsp+24], rax
mov [rsp+120], rdx
mov rax, [r11+32]
mul r8
mov [rsp+32], rax
mov [rsp+128], rdx
mov rax, [r11+40]
mul r8
mov [rsp+40], rax
mov [rsp+136], rdx
mov rax, [r11+48]
mul r8
mov [rsp+48], rax
mov [rsp+144], rdx
mov rax, [r11+56]
mul r8
mov [rsp+56], rax
mov [rsp+152], rdx
mov rax, [r11+64]
mul r8
mov [rsp+64], rax
mov [rsp+160], rdx
mov rax, [r11+72]
mul r8
mov [rsp+72], rax
mov [rsp+168], rdx
mov rax, [r11+80]
mul r8
mov [rsp+80], rax
mov [rsp+176], rdx
mov rax, [r11+88]
mul r8
mov [rsp+88], rax
mov rax, [rsp+8]
add rax, [rsp+96]
mov [rsp+8], rax
mov rax, [rsp+16]
adc rax, [rsp+104]
mov [rsp+16], rax
mov rax, [rsp+24]
adc rax, [rsp+112]
mov [rsp+24], rax
mov rax, [rsp+32]
adc rax, [rsp+120]
mov [rsp+32], rax
mov rax, [rsp+40]
adc rax, [rsp+128]
mov [rsp+40], rax
mov rax, [rsp+48]
adc rax, [rsp+136]
mov [rsp+48], rax
mov rax, [rsp+56]
adc rax, [rsp+144]
mov [rsp+56], rax
mov rax, [rsp+64]
adc rax, [rsp+152]
mov [rsp+64], rax
mov rax, [rsp+72]
adc rax, [rsp+160]
mov [rsp+72], rax
mov rax, [rsp+80]
adc rax, [rsp+168]
mov [rsp+80], rax
mov rax, [rsp+88]
adc rax, [rsp+176]
mov [rsp+88], rax
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
mov rax, [rsp+72]
adc [rcx+72], rax
mov rax, [rsp+80]
adc [rcx+80], rax
mov rax, [rsp+88]
adc [rcx+88], rax
adc rdx, 0
mov rax, rdx
add rsp, 184
ret
mclb_mulUnitAdd_slow12 endp
align 16
mclb_mul_slow1 proc export
mov r11, rdx
mov rax, [r11]
mov rdx, [r8]
mul rdx
mov [rcx], rax
mov [rcx+8], rdx
ret
mclb_mul_slow1 endp
align 16
mclb_mul_slow2 proc export
push rdi
mov r11, rdx
mov rax, [r11]
mul qword ptr [r8]
mov r9, rax
mov r10, rdx
xor rdi, rdi
mov [rcx], r9
xor r9, r9
mov rax, [r11]
mul qword ptr [r8+8]
add r10, rax
adc rdi, rdx
adc r9, 0
mov rax, [r11+8]
mul qword ptr [r8]
add r10, rax
adc rdi, rdx
adc r9, 0
mov [rcx+8], r10
xor r10, r10
mov rax, [r11+8]
mul qword ptr [r8+8]
add rdi, rax
adc r9, rdx
adc r10, 0
mov [rcx+16], rdi
mov [rcx+24], r9
pop rdi
ret
mclb_mul_slow2 endp
align 16
mclb_mul_slow3 proc export
push rdi
mov r11, rdx
mov rax, [r11]
mul qword ptr [r8]
mov r9, rax
mov r10, rdx
xor rdi, rdi
mov [rcx], r9
xor r9, r9
mov rax, [r11]
mul qword ptr [r8+8]
add r10, rax
adc rdi, rdx
adc r9, 0
mov rax, [r11+8]
mul qword ptr [r8]
add r10, rax
adc rdi, rdx
adc r9, 0
mov [rcx+8], r10
xor r10, r10
mov rax, [r11]
mul qword ptr [r8+16]
add rdi, rax
adc r9, rdx
adc r10, 0
mov rax, [r11+8]
mul qword ptr [r8+8]
add rdi, rax
adc r9, rdx
adc r10, 0
mov rax, [r11+16]
mul qword ptr [r8]
add rdi, rax
adc r9, rdx
adc r10, 0
mov [rcx+16], rdi
xor rdi, rdi
mov rax, [r11+8]
mul qword ptr [r8+16]
add r9, rax
adc r10, rdx
adc rdi, 0
mov rax, [r11+16]
mul qword ptr [r8+8]
add r9, rax
adc r10, rdx
adc rdi, 0
mov [rcx+24], r9
xor r9, r9
mov rax, [r11+16]
mul qword ptr [r8+16]
add r10, rax
adc rdi, rdx
adc r9, 0
mov [rcx+32], r10
mov [rcx+40], rdi
pop rdi
ret
mclb_mul_slow3 endp
align 16
mclb_mul_slow4 proc export
push rdi
mov r11, rdx
mov rax, [r11]
mul qword ptr [r8]
mov r9, rax
mov r10, rdx
xor rdi, rdi
mov [rcx], r9
xor r9, r9
mov rax, [r11]
mul qword ptr [r8+8]
add r10, rax
adc rdi, rdx
adc r9, 0
mov rax, [r11+8]
mul qword ptr [r8]
add r10, rax
adc rdi, rdx
adc r9, 0
mov [rcx+8], r10
xor r10, r10
mov rax, [r11]
mul qword ptr [r8+16]
add rdi, rax
adc r9, rdx
adc r10, 0
mov rax, [r11+8]
mul qword ptr [r8+8]
add rdi, rax
adc r9, rdx
adc r10, 0
mov rax, [r11+16]
mul qword ptr [r8]
add rdi, rax
adc r9, rdx
adc r10, 0
mov [rcx+16], rdi
xor rdi, rdi
mov rax, [r11]
mul qword ptr [r8+24]
add r9, rax
adc r10, rdx
adc rdi, 0
mov rax, [r11+8]
mul qword ptr [r8+16]
add r9, rax
adc r10, rdx
adc rdi, 0
mov rax, [r11+16]
mul qword ptr [r8+8]
add r9, rax
adc r10, rdx
adc rdi, 0
mov rax, [r11+24]
mul qword ptr [r8]
add r9, rax
adc r10, rdx
adc rdi, 0
mov [rcx+24], r9
xor r9, r9
mov rax, [r11+8]
mul qword ptr [r8+24]
add r10, rax
adc rdi, rdx
adc r9, 0
mov rax, [r11+16]
mul qword ptr [r8+16]
add r10, rax
adc rdi, rdx
adc r9, 0
mov rax, [r11+24]
mul qword ptr [r8+8]
add r10, rax
adc rdi, rdx
adc r9, 0
mov [rcx+32], r10
xor r10, r10
mov rax, [r11+16]
mul qword ptr [r8+24]
add rdi, rax
adc r9, rdx
adc r10, 0
mov rax, [r11+24]
mul qword ptr [r8+16]
add rdi, rax
adc r9, rdx
adc r10, 0
mov [rcx+40], rdi
xor rdi, rdi
mov rax, [r11+24]
mul qword ptr [r8+24]
add r9, rax
adc r10, rdx
adc rdi, 0
mov [rcx+48], r9
mov [rcx+56], r10
pop rdi
ret
mclb_mul_slow4 endp
align 16
mclb_mul_slow5 proc export
push rdi
mov r11, rdx
mov rax, [r11]
mul qword ptr [r8]
mov r9, rax
mov r10, rdx
xor rdi, rdi
mov [rcx], r9
xor r9, r9
mov rax, [r11]
mul qword ptr [r8+8]
add r10, rax
adc rdi, rdx
adc r9, 0
mov rax, [r11+8]
mul qword ptr [r8]
add r10, rax
adc rdi, rdx
adc r9, 0
mov [rcx+8], r10
xor r10, r10
mov rax, [r11]
mul qword ptr [r8+16]
add rdi, rax
adc r9, rdx
adc r10, 0
mov rax, [r11+8]
mul qword ptr [r8+8]
add rdi, rax
adc r9, rdx
adc r10, 0
mov rax, [r11+16]
mul qword ptr [r8]
add rdi, rax
adc r9, rdx
adc r10, 0
mov [rcx+16], rdi
xor rdi, rdi
mov rax, [r11]
mul qword ptr [r8+24]
add r9, rax
adc r10, rdx
adc rdi, 0
mov rax, [r11+8]
mul qword ptr [r8+16]
add r9, rax
adc r10, rdx
adc rdi, 0
mov rax, [r11+16]
mul qword ptr [r8+8]
add r9, rax
adc r10, rdx
adc rdi, 0
mov rax, [r11+24]
mul qword ptr [r8]
add r9, rax
adc r10, rdx
adc rdi, 0
mov [rcx+24], r9
xor r9, r9
mov rax, [r11]
mul qword ptr [r8+32]
add r10, rax
adc rdi, rdx
adc r9, 0
mov rax, [r11+8]
mul qword ptr [r8+24]
add r10, rax
adc rdi, rdx
adc r9, 0
mov rax, [r11+16]
mul qword ptr [r8+16]
add r10, rax
adc rdi, rdx
adc r9, 0
mov rax, [r11+24]
mul qword ptr [r8+8]
add r10, rax
adc rdi, rdx
adc r9, 0
mov rax, [r11+32]
mul qword ptr [r8]
add r10, rax
adc rdi, rdx
adc r9, 0
mov [rcx+32], r10
xor r10, r10
mov rax, [r11+8]
mul qword ptr [r8+32]
add rdi, rax
adc r9, rdx
adc r10, 0
mov rax, [r11+16]
mul qword ptr [r8+24]
add rdi, rax
adc r9, rdx
adc r10, 0
mov rax, [r11+24]
mul qword ptr [r8+16]
add rdi, rax
adc r9, rdx
adc r10, 0
mov rax, [r11+32]
mul qword ptr [r8+8]
add rdi, rax
adc r9, rdx
adc r10, 0
mov [rcx+40], rdi
xor rdi, rdi
mov rax, [r11+16]
mul qword ptr [r8+32]
add r9, rax
adc r10, rdx
adc rdi, 0
mov rax, [r11+24]
mul qword ptr [r8+24]
add r9, rax
adc r10, rdx
adc rdi, 0
mov rax, [r11+32]
mul qword ptr [r8+16]
add r9, rax
adc r10, rdx
adc rdi, 0
mov [rcx+48], r9
xor r9, r9
mov rax, [r11+24]
mul qword ptr [r8+32]
add r10, rax
adc rdi, rdx
adc r9, 0
mov rax, [r11+32]
mul qword ptr [r8+24]
add r10, rax
adc rdi, rdx
adc r9, 0
mov [rcx+56], r10
xor r10, r10
mov rax, [r11+32]
mul qword ptr [r8+32]
add rdi, rax
adc r9, rdx
adc r10, 0
mov [rcx+64], rdi
mov [rcx+72], r9
pop rdi
ret
mclb_mul_slow5 endp
align 16
mclb_mul_slow6 proc export
push rdi
mov r11, rdx
mov rax, [r11]
mul qword ptr [r8]
mov r9, rax
mov r10, rdx
xor rdi, rdi
mov [rcx], r9
xor r9, r9
mov rax, [r11]
mul qword ptr [r8+8]
add r10, rax
adc rdi, rdx
adc r9, 0
mov rax, [r11+8]
mul qword ptr [r8]
add r10, rax
adc rdi, rdx
adc r9, 0
mov [rcx+8], r10
xor r10, r10
mov rax, [r11]
mul qword ptr [r8+16]
add rdi, rax
adc r9, rdx
adc r10, 0
mov rax, [r11+8]
mul qword ptr [r8+8]
add rdi, rax
adc r9, rdx
adc r10, 0
mov rax, [r11+16]
mul qword ptr [r8]
add rdi, rax
adc r9, rdx
adc r10, 0
mov [rcx+16], rdi
xor rdi, rdi
mov rax, [r11]
mul qword ptr [r8+24]
add r9, rax
adc r10, rdx
adc rdi, 0
mov rax, [r11+8]
mul qword ptr [r8+16]
add r9, rax
adc r10, rdx
adc rdi, 0
mov rax, [r11+16]
mul qword ptr [r8+8]
add r9, rax
adc r10, rdx
adc rdi, 0
mov rax, [r11+24]
mul qword ptr [r8]
add r9, rax
adc r10, rdx
adc rdi, 0
mov [rcx+24], r9
xor r9, r9
mov rax, [r11]
mul qword ptr [r8+32]
add r10, rax
adc rdi, rdx
adc r9, 0
mov rax, [r11+8]
mul qword ptr [r8+24]
add r10, rax
adc rdi, rdx
adc r9, 0
mov rax, [r11+16]
mul qword ptr [r8+16]
add r10, rax
adc rdi, rdx
adc r9, 0
mov rax, [r11+24]
mul qword ptr [r8+8]
add r10, rax
adc rdi, rdx
adc r9, 0
mov rax, [r11+32]
mul qword ptr [r8]
add r10, rax
adc rdi, rdx
adc r9, 0
mov [rcx+32], r10
xor r10, r10
mov rax, [r11]
mul qword ptr [r8+40]
add rdi, rax
adc r9, rdx
adc r10, 0
mov rax, [r11+8]
mul qword ptr [r8+32]
add rdi, rax
adc r9, rdx
adc r10, 0
mov rax, [r11+16]
mul qword ptr [r8+24]
add rdi, rax
adc r9, rdx
adc r10, 0
mov rax, [r11+24]
mul qword ptr [r8+16]
add rdi, rax
adc r9, rdx
adc r10, 0
mov rax, [r11+32]
mul qword ptr [r8+8]
add rdi, rax
adc r9, rdx
adc r10, 0
mov rax, [r11+40]
mul qword ptr [r8]
add rdi, rax
adc r9, rdx
adc r10, 0
mov [rcx+40], rdi
xor rdi, rdi
mov rax, [r11+8]
mul qword ptr [r8+40]
add r9, rax
adc r10, rdx
adc rdi, 0
mov rax, [r11+16]
mul qword ptr [r8+32]
add r9, rax
adc r10, rdx
adc rdi, 0
mov rax, [r11+24]
mul qword ptr [r8+24]
add r9, rax
adc r10, rdx
adc rdi, 0
mov rax, [r11+32]
mul qword ptr [r8+16]
add r9, rax
adc r10, rdx
adc rdi, 0
mov rax, [r11+40]
mul qword ptr [r8+8]
add r9, rax
adc r10, rdx
adc rdi, 0
mov [rcx+48], r9
xor r9, r9
mov rax, [r11+16]
mul qword ptr [r8+40]
add r10, rax
adc rdi, rdx
adc r9, 0
mov rax, [r11+24]
mul qword ptr [r8+32]
add r10, rax
adc rdi, rdx
adc r9, 0
mov rax, [r11+32]
mul qword ptr [r8+24]
add r10, rax
adc rdi, rdx
adc r9, 0
mov rax, [r11+40]
mul qword ptr [r8+16]
add r10, rax
adc rdi, rdx
adc r9, 0
mov [rcx+56], r10
xor r10, r10
mov rax, [r11+24]
mul qword ptr [r8+40]
add rdi, rax
adc r9, rdx
adc r10, 0
mov rax, [r11+32]
mul qword ptr [r8+32]
add rdi, rax
adc r9, rdx
adc r10, 0
mov rax, [r11+40]
mul qword ptr [r8+24]
add rdi, rax
adc r9, rdx
adc r10, 0
mov [rcx+64], rdi
xor rdi, rdi
mov rax, [r11+32]
mul qword ptr [r8+40]
add r9, rax
adc r10, rdx
adc rdi, 0
mov rax, [r11+40]
mul qword ptr [r8+32]
add r9, rax
adc r10, rdx
adc rdi, 0
mov [rcx+72], r9
xor r9, r9
mov rax, [r11+40]
mul qword ptr [r8+40]
add r10, rax
adc rdi, rdx
adc r9, 0
mov [rcx+80], r10
mov [rcx+88], rdi
pop rdi
ret
mclb_mul_slow6 endp
align 16
mclb_sqr_slow1 proc export
mov r11, rdx
mov rax, [r11]
mul rax
mov [rcx], rax
mov [rcx+8], rdx
ret
mclb_sqr_slow1 endp
align 16
mclb_sqr_slow2 proc export
mov r8, rdx
jmp mclb_mul_slow2
mclb_sqr_slow2 endp
align 16
mclb_sqr_slow3 proc export
mov r8, rdx
jmp mclb_mul_slow3
mclb_sqr_slow3 endp
align 16
mclb_sqr_slow4 proc export
mov r8, rdx
jmp mclb_mul_slow4
mclb_sqr_slow4 endp
align 16
mclb_sqr_slow5 proc export
mov r8, rdx
jmp mclb_mul_slow5
mclb_sqr_slow5 endp
align 16
mclb_sqr_slow6 proc export
mov r8, rdx
jmp mclb_mul_slow6
mclb_sqr_slow6 endp
align 16
mclb_mulUnit1 proc export
cmp byte ptr mclb_fast_flag, 0
jne mclb_mulUnit_fast1
jmp mclb_mulUnit_slow1
mclb_mulUnit1 endp
align 16
mclb_mulUnitAdd1 proc export
cmp byte ptr mclb_fast_flag, 0
jne mclb_mulUnitAdd_fast1
jmp mclb_mulUnitAdd_slow1
mclb_mulUnitAdd1 endp
align 16
mclb_mulUnit2 proc export
cmp byte ptr mclb_fast_flag, 0
jne mclb_mulUnit_fast2
jmp mclb_mulUnit_slow2
mclb_mulUnit2 endp
align 16
mclb_mulUnitAdd2 proc export
cmp byte ptr mclb_fast_flag, 0
jne mclb_mulUnitAdd_fast2
jmp mclb_mulUnitAdd_slow2
mclb_mulUnitAdd2 endp
align 16
mclb_mulUnit3 proc export
cmp byte ptr mclb_fast_flag, 0
jne mclb_mulUnit_fast3
jmp mclb_mulUnit_slow3
mclb_mulUnit3 endp
align 16
mclb_mulUnitAdd3 proc export
cmp byte ptr mclb_fast_flag, 0
jne mclb_mulUnitAdd_fast3
jmp mclb_mulUnitAdd_slow3
mclb_mulUnitAdd3 endp
align 16
mclb_mulUnit4 proc export
cmp byte ptr mclb_fast_flag, 0
jne mclb_mulUnit_fast4
jmp mclb_mulUnit_slow4
mclb_mulUnit4 endp
align 16
mclb_mulUnitAdd4 proc export
cmp byte ptr mclb_fast_flag, 0
jne mclb_mulUnitAdd_fast4
jmp mclb_mulUnitAdd_slow4
mclb_mulUnitAdd4 endp
align 16
mclb_mulUnit5 proc export
cmp byte ptr mclb_fast_flag, 0
jne mclb_mulUnit_fast5
jmp mclb_mulUnit_slow5
mclb_mulUnit5 endp
align 16
mclb_mulUnitAdd5 proc export
cmp byte ptr mclb_fast_flag, 0
jne mclb_mulUnitAdd_fast5
jmp mclb_mulUnitAdd_slow5
mclb_mulUnitAdd5 endp
align 16
mclb_mulUnit6 proc export
cmp byte ptr mclb_fast_flag, 0
jne mclb_mulUnit_fast6
jmp mclb_mulUnit_slow6
mclb_mulUnit6 endp
align 16
mclb_mulUnitAdd6 proc export
cmp byte ptr mclb_fast_flag, 0
jne mclb_mulUnitAdd_fast6
jmp mclb_mulUnitAdd_slow6
mclb_mulUnitAdd6 endp
align 16
mclb_mulUnit7 proc export
cmp byte ptr mclb_fast_flag, 0
jne mclb_mulUnit_fast7
jmp mclb_mulUnit_slow7
mclb_mulUnit7 endp
align 16
mclb_mulUnitAdd7 proc export
cmp byte ptr mclb_fast_flag, 0
jne mclb_mulUnitAdd_fast7
jmp mclb_mulUnitAdd_slow7
mclb_mulUnitAdd7 endp
align 16
mclb_mulUnit8 proc export
cmp byte ptr mclb_fast_flag, 0
jne mclb_mulUnit_fast8
jmp mclb_mulUnit_slow8
mclb_mulUnit8 endp
align 16
mclb_mulUnitAdd8 proc export
cmp byte ptr mclb_fast_flag, 0
jne mclb_mulUnitAdd_fast8
jmp mclb_mulUnitAdd_slow8
mclb_mulUnitAdd8 endp
align 16
mclb_mulUnit9 proc export
cmp byte ptr mclb_fast_flag, 0
jne mclb_mulUnit_fast9
jmp mclb_mulUnit_slow9
mclb_mulUnit9 endp
align 16
mclb_mulUnitAdd9 proc export
cmp byte ptr mclb_fast_flag, 0
jne mclb_mulUnitAdd_fast9
jmp mclb_mulUnitAdd_slow9
mclb_mulUnitAdd9 endp
align 16
mclb_mulUnit10 proc export
cmp byte ptr mclb_fast_flag, 0
jne mclb_mulUnit_fast10
jmp mclb_mulUnit_slow10
mclb_mulUnit10 endp
align 16
mclb_mulUnitAdd10 proc export
cmp byte ptr mclb_fast_flag, 0
jne mclb_mulUnitAdd_fast10
jmp mclb_mulUnitAdd_slow10
mclb_mulUnitAdd10 endp
align 16
mclb_mulUnit11 proc export
cmp byte ptr mclb_fast_flag, 0
jne mclb_mulUnit_fast11
jmp mclb_mulUnit_slow11
mclb_mulUnit11 endp
align 16
mclb_mulUnitAdd11 proc export
cmp byte ptr mclb_fast_flag, 0
jne mclb_mulUnitAdd_fast11
jmp mclb_mulUnitAdd_slow11
mclb_mulUnitAdd11 endp
align 16
mclb_mulUnit12 proc export
cmp byte ptr mclb_fast_flag, 0
jne mclb_mulUnit_fast12
jmp mclb_mulUnit_slow12
mclb_mulUnit12 endp
align 16
mclb_mulUnitAdd12 proc export
cmp byte ptr mclb_fast_flag, 0
jne mclb_mulUnitAdd_fast12
jmp mclb_mulUnitAdd_slow12
mclb_mulUnitAdd12 endp
align 16
mclb_mul1 proc export
cmp byte ptr mclb_fast_flag, 0
jne mclb_mul_fast1
jmp mclb_mul_slow1
mclb_mul1 endp
align 16
mclb_sqr1 proc export
cmp byte ptr mclb_fast_flag, 0
jne mclb_sqr_fast1
jmp mclb_sqr_slow1
mclb_sqr1 endp
align 16
mclb_mul2 proc export
cmp byte ptr mclb_fast_flag, 0
jne mclb_mul_fast2
jmp mclb_mul_slow2
mclb_mul2 endp
align 16
mclb_sqr2 proc export
cmp byte ptr mclb_fast_flag, 0
jne mclb_sqr_fast2
jmp mclb_sqr_slow2
mclb_sqr2 endp
align 16
mclb_mul3 proc export
cmp byte ptr mclb_fast_flag, 0
jne mclb_mul_fast3
jmp mclb_mul_slow3
mclb_mul3 endp
align 16
mclb_sqr3 proc export
cmp byte ptr mclb_fast_flag, 0
jne mclb_sqr_fast3
jmp mclb_sqr_slow3
mclb_sqr3 endp
align 16
mclb_mul4 proc export
cmp byte ptr mclb_fast_flag, 0
jne mclb_mul_fast4
jmp mclb_mul_slow4
mclb_mul4 endp
align 16
mclb_sqr4 proc export
cmp byte ptr mclb_fast_flag, 0
jne mclb_sqr_fast4
jmp mclb_sqr_slow4
mclb_sqr4 endp
align 16
mclb_mul5 proc export
cmp byte ptr mclb_fast_flag, 0
jne mclb_mul_fast5
jmp mclb_mul_slow5
mclb_mul5 endp
align 16
mclb_sqr5 proc export
cmp byte ptr mclb_fast_flag, 0
jne mclb_sqr_fast5
jmp mclb_sqr_slow5
mclb_sqr5 endp
align 16
mclb_mul6 proc export
cmp byte ptr mclb_fast_flag, 0
jne mclb_mul_fast6
jmp mclb_mul_slow6
mclb_mul6 endp
align 16
mclb_sqr6 proc export
cmp byte ptr mclb_fast_flag, 0
jne mclb_sqr_fast6
jmp mclb_sqr_slow6
mclb_sqr6 endp
align 16
mclb_enable_fast proc export
mov byte ptr mclb_fast_flag, 1
ret
mclb_enable_fast endp
align 16
mclb_modp256_x64 proc export
cmp r8, 8
ja @L11
push rdi
push rsi
push rbx
push rbp
push r12
push r13
sub rsp, 8
mov r10, rcx
mov r11, rdx
mov [rsp], r10
cmp r8, 4
jb @L5
lea rax, [r11+r8*8]
mov rdi, [rax-24]
mov rsi, [rax-16]
mov rbx, [rax-8]
xor rbp, rbp
lea r11, [rax-32]
sub r8, 4
mov rdx, [r9]
mulx r10, rax, rbx
mulx rax, r13, rbp
add r13, r10
adc rax, 0
mov rdx, [r9+8]
mulx r10, r12, rbx
add r13, r12
adc rax, r10
mulx r10, r12, rbp
adc r10, 0
add rax, r12
adc r10, 0
mov rbp, [r11]
shrd rax, r10, 1
mov rdx, rax
xor r12, r12
mulx r12, r13, [r9+16]
adox rbp, r13
adcx rdi, r12
mulx r12, r13, [r9+24]
adox rdi, r13
adcx rsi, r12
mulx r12, r13, [r9+32]
adox rsi, r13
adcx rbx, r12
mulx r12, r13, [r9+40]
adox rbx, r13
mov r12, rbp
mov r13, rdi
mov r10, rsi
mov rax, rbx
add rbp, [r9+16]
adc rdi, [r9+24]
adc rsi, [r9+32]
adc rbx, [r9+40]
cmovnc rbp, r12
cmovnc rdi, r13
cmovnc rsi, r10
cmovnc rbx, rax
sub r8, 1
jc @L1
sub r11, 8
mov rdx, [r9]
mulx r10, rax, rsi
mulx rax, r13, rbx
add r13, r10
adc rax, 0
mov rdx, [r9+8]
mulx r10, r12, rsi
add r13, r12
adc rax, r10
mulx r10, r12, rbx
adc r10, 0
add rax, r12
adc r10, 0
mov rbx, [r11]
shrd rax, r10, 1
mov rdx, rax
xor r12, r12
mulx r12, r13, [r9+16]
adox rbx, r13
adcx rbp, r12
mulx r12, r13, [r9+24]
adox rbp, r13
adcx rdi, r12
mulx r12, r13, [r9+32]
adox rdi, r13
adcx rsi, r12
mulx r12, r13, [r9+40]
adox rsi, r13
mov r12, rbx
mov r13, rbp
mov r10, rdi
mov rax, rsi
add rbx, [r9+16]
adc rbp, [r9+24]
adc rdi, [r9+32]
adc rsi, [r9+40]
cmovnc rbx, r12
cmovnc rbp, r13
cmovnc rdi, r10
cmovnc rsi, rax
sub r8, 1
jc @L2
sub r11, 8
mov rdx, [r9]
mulx r10, rax, rdi
mulx rax, r13, rsi
add r13, r10
adc rax, 0
mov rdx, [r9+8]
mulx r10, r12, rdi
add r13, r12
adc rax, r10
mulx r10, r12, rsi
adc r10, 0
add rax, r12
adc r10, 0
mov rsi, [r11]
shrd rax, r10, 1
mov rdx, rax
xor r12, r12
mulx r12, r13, [r9+16]
adox rsi, r13
adcx rbx, r12
mulx r12, r13, [r9+24]
adox rbx, r13
adcx rbp, r12
mulx r12, r13, [r9+32]
adox rbp, r13
adcx rdi, r12
mulx r12, r13, [r9+40]
adox rdi, r13
mov r12, rsi
mov r13, rbx
mov r10, rbp
mov rax, rdi
add rsi, [r9+16]
adc rbx, [r9+24]
adc rbp, [r9+32]
adc rdi, [r9+40]
cmovnc rsi, r12
cmovnc rbx, r13
cmovnc rbp, r10
cmovnc rdi, rax
sub r8, 1
jc @L3
sub r11, 8
mov rdx, [r9]
mulx r10, rax, rbp
mulx rax, r13, rdi
add r13, r10
adc rax, 0
mov rdx, [r9+8]
mulx r10, r12, rbp
add r13, r12
adc rax, r10
mulx r10, r12, rdi
adc r10, 0
add rax, r12
adc r10, 0
mov rdi, [r11]
shrd rax, r10, 1
mov rdx, rax
xor r12, r12
mulx r12, r13, [r9+16]
adox rdi, r13
adcx rsi, r12
mulx r12, r13, [r9+24]
adox rsi, r13
adcx rbx, r12
mulx r12, r13, [r9+32]
adox rbx, r13
adcx rbp, r12
mulx r12, r13, [r9+40]
adox rbp, r13
mov r12, rdi
mov r13, rsi
mov r10, rbx
mov rax, rbp
add rdi, [r9+16]
adc rsi, [r9+24]
adc rbx, [r9+32]
adc rbp, [r9+40]
cmovnc rdi, r12
cmovnc rsi, r13
cmovnc rbx, r10
cmovnc rbp, rax
sub r8, 1
jc @L4
sub r11, 8
mov rdx, [r9]
mulx r10, rax, rbx
mulx rax, r13, rbp
add r13, r10
adc rax, 0
mov rdx, [r9+8]
mulx r10, r12, rbx
add r13, r12
adc rax, r10
mulx r10, r12, rbp
adc r10, 0
add rax, r12
adc r10, 0
mov rbp, [r11]
shrd rax, r10, 1
mov rdx, rax
xor r12, r12
mulx r12, r13, [r9+16]
adox rbp, r13
adcx rdi, r12
mulx r12, r13, [r9+24]
adox rdi, r13
adcx rsi, r12
mulx r12, r13, [r9+32]
adox rsi, r13
adcx rbx, r12
mulx r12, r13, [r9+40]
adox rbx, r13
mov r12, rbp
mov r13, rdi
mov r10, rsi
mov rax, rbx
add rbp, [r9+16]
adc rdi, [r9+24]
adc rsi, [r9+32]
adc rbx, [r9+40]
cmovnc rbp, r12
cmovnc rdi, r13
cmovnc rsi, r10
cmovnc rbx, rax
mov rdx, [rsp]
mov [rdx], rbp
mov [rdx+8], rdi
mov [rdx+16], rsi
mov [rdx+24], rbx
jmp @L10
@L1:
mov rdx, [rsp]
mov [rdx], rbp
mov [rdx+8], rdi
mov [rdx+16], rsi
mov [rdx+24], rbx
jmp @L10
@L2:
mov rdx, [rsp]
mov [rdx], rbx
mov [rdx+8], rbp
mov [rdx+16], rdi
mov [rdx+24], rsi
jmp @L10
@L3:
mov rdx, [rsp]
mov [rdx], rsi
mov [rdx+8], rbx
mov [rdx+16], rbp
mov [rdx+24], rdi
jmp @L10
@L4:
mov rdx, [rsp]
mov [rdx], rdi
mov [rdx+8], rsi
mov [rdx+16], rbx
mov [rdx+24], rbp
jmp @L10
@L5:
mov rdx, [rsp]
cmp r8, 0
je @L6
mov rax, [r11]
mov [rdx], rax
cmp r8, 1
je @L7
mov rax, [r11+8]
mov [rdx+8], rax
cmp r8, 2
je @L8
mov rax, [r11+16]
mov [rdx+16], rax
jmp @L9
@L6:
mov qword ptr [rdx], 0
@L7:
mov qword ptr [rdx+8], 0
@L8:
mov qword ptr [rdx+16], 0
@L9:
mov qword ptr [rdx+24], 0
@L10:
mov eax, 1
add rsp, 8
pop r13
pop r12
pop rbp
pop rbx
pop rsi
pop rdi
ret
@L11:
xor eax, eax
ret
mclb_modp256_x64 endp
align 16
mclb_modp384_x64 proc export
cmp r8, 8
ja @L22
push rdi
push rsi
push rbx
push rbp
push r12
push r13
push r14
push r15
sub rsp, 8
mov r10, rcx
mov r11, rdx
mov [rsp], r10
cmp r8, 6
jb @L14
lea rax, [r11+r8*8]
mov rdi, [rax-40]
mov rsi, [rax-32]
mov rbx, [rax-24]
mov rbp, [rax-16]
mov r12, [rax-8]
xor r13, r13
lea r11, [rax-48]
sub r8, 6
mov rdx, [r9]
mulx r10, rax, r12
mulx rax, r15, r13
add r15, r10
adc rax, 0
mov rdx, [r9+8]
mulx r10, r14, r12
add r15, r14
adc rax, r10
mulx r10, r14, r13
adc r10, 0
add rax, r14
adc r10, 0
mov r13, [r11]
shrd rax, r10, 1
mov rdx, rax
xor r14, r14
mulx r14, r15, [r9+16]
adox r13, r15
adcx rdi, r14
mulx r14, r15, [r9+24]
adox rdi, r15
adcx rsi, r14
mulx r14, r15, [r9+32]
adox rsi, r15
adcx rbx, r14
mulx r14, r15, [r9+40]
adox rbx, r15
adcx rbp, r14
mulx r14, r15, [r9+48]
adox rbp, r15
adcx r12, r14
mulx r14, r15, [r9+56]
adox r12, r15
mov r14, r13
mov r15, rdi
mov r10, rsi
mov rax, rbx
mov rcx, rbp
mov rdx, r12
add r13, [r9+16]
adc rdi, [r9+24]
adc rsi, [r9+32]
adc rbx, [r9+40]
adc rbp, [r9+48]
adc r12, [r9+56]
cmovnc r13, r14
cmovnc rdi, r15
cmovnc rsi, r10
cmovnc rbx, rax
cmovnc rbp, rcx
cmovnc r12, rdx
sub r8, 1
jc @L12
sub r11, 8
mov rdx, [r9]
mulx r10, rax, rbp
mulx rax, r15, r12
add r15, r10
adc rax, 0
mov rdx, [r9+8]
mulx r10, r14, rbp
add r15, r14
adc rax, r10
mulx r10, r14, r12
adc r10, 0
add rax, r14
adc r10, 0
mov r12, [r11]
shrd rax, r10, 1
mov rdx, rax
xor r14, r14
mulx r14, r15, [r9+16]
adox r12, r15
adcx r13, r14
mulx r14, r15, [r9+24]
adox r13, r15
adcx rdi, r14
mulx r14, r15, [r9+32]
adox rdi, r15
adcx rsi, r14
mulx r14, r15, [r9+40]
adox rsi, r15
adcx rbx, r14
mulx r14, r15, [r9+48]
adox rbx, r15
adcx rbp, r14
mulx r14, r15, [r9+56]
adox rbp, r15
mov r14, r12
mov r15, r13
mov r10, rdi
mov rax, rsi
mov rcx, rbx
mov rdx, rbp
add r12, [r9+16]
adc r13, [r9+24]
adc rdi, [r9+32]
adc rsi, [r9+40]
adc rbx, [r9+48]
adc rbp, [r9+56]
cmovnc r12, r14
cmovnc r13, r15
cmovnc rdi, r10
cmovnc rsi, rax
cmovnc rbx, rcx
cmovnc rbp, rdx
sub r8, 1
jc @L13
sub r11, 8
mov rdx, [r9]
mulx r10, rax, rbx
mulx rax, r15, rbp
add r15, r10
adc rax, 0
mov rdx, [r9+8]
mulx r10, r14, rbx
add r15, r14
adc rax, r10
mulx r10, r14, rbp
adc r10, 0
add rax, r14
adc r10, 0
mov rbp, [r11]
shrd rax, r10, 1
mov rdx, rax
xor r14, r14
mulx r14, r15, [r9+16]
adox rbp, r15
adcx r12, r14
mulx r14, r15, [r9+24]
adox r12, r15
adcx r13, r14
mulx r14, r15, [r9+32]
adox r13, r15
adcx rdi, r14
mulx r14, r15, [r9+40]
adox rdi, r15
adcx rsi, r14
mulx r14, r15, [r9+48]
adox rsi, r15
adcx rbx, r14
mulx r14, r15, [r9+56]
adox rbx, r15
mov r14, rbp
mov r15, r12
mov r10, r13
mov rax, rdi
mov rcx, rsi
mov rdx, rbx
add rbp, [r9+16]
adc r12, [r9+24]
adc r13, [r9+32]
adc rdi, [r9+40]
adc rsi, [r9+48]
adc rbx, [r9+56]
cmovnc rbp, r14
cmovnc r12, r15
cmovnc r13, r10
cmovnc rdi, rax
cmovnc rsi, rcx
cmovnc rbx, rdx
mov rdx, [rsp]
mov [rdx], rbp
mov [rdx+8], r12
mov [rdx+16], r13
mov [rdx+24], rdi
mov [rdx+32], rsi
mov [rdx+40], rbx
jmp @L21
@L12:
mov rdx, [rsp]
mov [rdx], r13
mov [rdx+8], rdi
mov [rdx+16], rsi
mov [rdx+24], rbx
mov [rdx+32], rbp
mov [rdx+40], r12
jmp @L21
@L13:
mov rdx, [rsp]
mov [rdx], r12
mov [rdx+8], r13
mov [rdx+16], rdi
mov [rdx+24], rsi
mov [rdx+32], rbx
mov [rdx+40], rbp
jmp @L21
@L14:
mov rdx, [rsp]
cmp r8, 0
je @L15
mov rax, [r11]
mov [rdx], rax
cmp r8, 1
je @L16
mov rax, [r11+8]
mov [rdx+8], rax
cmp r8, 2
je @L17
mov rax, [r11+16]
mov [rdx+16], rax
cmp r8, 3
je @L18
mov rax, [r11+24]
mov [rdx+24], rax
cmp r8, 4
je @L19
mov rax, [r11+32]
mov [rdx+32], rax
jmp @L20
@L15:
mov qword ptr [rdx], 0
@L16:
mov qword ptr [rdx+8], 0
@L17:
mov qword ptr [rdx+16], 0
@L18:
mov qword ptr [rdx+24], 0
@L19:
mov qword ptr [rdx+32], 0
@L20:
mov qword ptr [rdx+40], 0
@L21:
mov eax, 1
add rsp, 8
pop r15
pop r14
pop r13
pop r12
pop rbp
pop rbx
pop rsi
pop rdi
ret
@L22:
xor eax, eax
ret
mclb_modp384_x64 endp
align 16
mclb_udiv128 proc export
mov rax, rdx
mov rdx, rcx
div r8
mov [r9], rdx
ret
mclb_udiv128 endp
_text$x ends
end
