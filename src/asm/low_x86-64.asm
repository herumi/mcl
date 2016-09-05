
; Linux     rdi     rsi    rdx    rcx
; Win       rcx     rdx    r8     r9

%ifdef _WIN64
	%define p1org rcx
	%define p2org rdx
	%define p3org r8
	%define p4org r9
%else
	%define p1org rdi
	%define p2org rsi
	%define p3org rdx
	%define p4org rcx
%endif

%imacro proc 1
global %1
%1:
%endmacro

segment .text

%imacro addNC 1
	mov rax, [p2org]
	add rax, [p3org]
	mov [p1org], rax
%assign i 1
%rep %1
	mov rax, [p2org + i * 8]
	adc rax, [p3org + i * 8]
	mov [p1org + i * 8], rax
%assign i (i+1)
%endrep
	setc al
	movzx eax, al
	ret
%endmacro

proc mcl_fp_addNC64
        addNC 0
proc mcl_fp_addNC128
        addNC 1
proc mcl_fp_addNC192
        addNC 2
proc mcl_fp_addNC256
        addNC 3
proc mcl_fp_addNC320
        addNC 4
proc mcl_fp_addNC384
        addNC 5
proc mcl_fp_addNC448
        addNC 6
proc mcl_fp_addNC512
        addNC 7
proc mcl_fp_addNC576
        addNC 8
proc mcl_fp_addNC640
        addNC 9
proc mcl_fp_addNC704
        addNC 10
proc mcl_fp_addNC768
        addNC 11
proc mcl_fp_addNC832
        addNC 12
proc mcl_fp_addNC896
        addNC 13
proc mcl_fp_addNC960
        addNC 14
proc mcl_fp_addNC1024
        addNC 15
proc mcl_fp_addNC1088
        addNC 16
proc mcl_fp_addNC1152
        addNC 17
proc mcl_fp_addNC1216
        addNC 18
proc mcl_fp_addNC1280
        addNC 19
proc mcl_fp_addNC1344
        addNC 20
proc mcl_fp_addNC1408
        addNC 21
proc mcl_fp_addNC1472
        addNC 22
proc mcl_fp_addNC1536
        addNC 23

