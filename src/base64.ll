define private i128 @mul64x64L(i64 %r2, i64 %r3)
{
%r4 = zext i64 %r2 to i128
%r5 = zext i64 %r3 to i128
%r6 = mul i128 %r4, %r5
ret i128 %r6
}
define private i64 @extractHigh64(i128 %r2)
{
%r3 = lshr i128 %r2, 64
%r4 = trunc i128 %r3 to i64
ret i64 %r4
}
define private i128 @mulPos64x64(i64* noalias  %r2, i64 %r3, i64 %r4)
{
%r5 = getelementptr i64, i64* %r2, i64 %r4
%r6 = load i64, i64* %r5
%r7 = call i128 @mul64x64L(i64 %r6, i64 %r3)
ret i128 %r7
}
define i192 @makeNIST_P192L()
{
%r8 = sub i64 0, 1
%r9 = sub i64 0, 2
%r10 = sub i64 0, 1
%r11 = zext i64 %r8 to i192
%r12 = zext i64 %r9 to i192
%r13 = zext i64 %r10 to i192
%r14 = shl i192 %r12, 64
%r15 = shl i192 %r13, 128
%r16 = add i192 %r11, %r14
%r17 = add i192 %r16, %r15
ret i192 %r17
}
define void @mcl_fpDbl_mod_NIST_P192L(i64* noalias  %r1, i64* noalias  %r2, i64* noalias  %r3)
{
%r4 = load i64, i64* %r2
%r5 = zext i64 %r4 to i128
%r7 = getelementptr i64, i64* %r2, i32 1
%r8 = load i64, i64* %r7
%r9 = zext i64 %r8 to i128
%r10 = shl i128 %r9, 64
%r11 = or i128 %r5, %r10
%r12 = zext i128 %r11 to i192
%r14 = getelementptr i64, i64* %r2, i32 2
%r15 = load i64, i64* %r14
%r16 = zext i64 %r15 to i192
%r17 = shl i192 %r16, 128
%r18 = or i192 %r12, %r17
%r19 = zext i192 %r18 to i256
%r21 = getelementptr i64, i64* %r2, i32 3
%r22 = load i64, i64* %r21
%r23 = zext i64 %r22 to i128
%r25 = getelementptr i64, i64* %r21, i32 1
%r26 = load i64, i64* %r25
%r27 = zext i64 %r26 to i128
%r28 = shl i128 %r27, 64
%r29 = or i128 %r23, %r28
%r30 = zext i128 %r29 to i192
%r32 = getelementptr i64, i64* %r21, i32 2
%r33 = load i64, i64* %r32
%r34 = zext i64 %r33 to i192
%r35 = shl i192 %r34, 128
%r36 = or i192 %r30, %r35
%r37 = zext i192 %r36 to i256
%r38 = shl i192 %r36, 64
%r39 = zext i192 %r38 to i256
%r40 = lshr i192 %r36, 128
%r41 = trunc i192 %r40 to i64
%r42 = zext i64 %r41 to i256
%r43 = or i256 %r39, %r42
%r44 = shl i256 %r42, 64
%r45 = add i256 %r19, %r37
%r46 = add i256 %r45, %r43
%r47 = add i256 %r46, %r44
%r48 = lshr i256 %r47, 192
%r49 = trunc i256 %r48 to i64
%r50 = zext i64 %r49 to i256
%r51 = shl i256 %r50, 64
%r52 = or i256 %r50, %r51
%r53 = trunc i256 %r47 to i192
%r54 = zext i192 %r53 to i256
%r55 = add i256 %r54, %r52
%r56 = call i192 @makeNIST_P192L()
%r57 = zext i192 %r56 to i256
%r58 = sub i256 %r55, %r57
%r59 = lshr i256 %r58, 192
%r60 = trunc i256 %r59 to i1
%r61 = select i1 %r60, i256 %r55, i256 %r58
%r62 = trunc i256 %r61 to i192
%r63 = trunc i192 %r62 to i64
%r65 = getelementptr i64, i64* %r1, i32 0
store i64 %r63, i64* %r65
%r66 = lshr i192 %r62, 64
%r67 = trunc i192 %r66 to i64
%r69 = getelementptr i64, i64* %r1, i32 1
store i64 %r67, i64* %r69
%r70 = lshr i192 %r66, 64
%r71 = trunc i192 %r70 to i64
%r73 = getelementptr i64, i64* %r1, i32 2
store i64 %r71, i64* %r73
ret void
}
define void @mcl_fp_sqr_NIST_P192L(i64* noalias  %r1, i64* noalias  %r2, i64* noalias  %r3)
{
%r5 = alloca i64, i32 6
call void @mcl_fpDbl_sqrPre3L(i64* %r5, i64* %r2)
call void @mcl_fpDbl_mod_NIST_P192L(i64* %r1, i64* %r5, i64* %r5)
ret void
}
define void @mcl_fp_mulNIST_P192L(i64* noalias  %r1, i64* noalias  %r2, i64* noalias  %r3, i64* noalias  %r4)
{
%r6 = alloca i64, i32 6
call void @mcl_fpDbl_mulPre3L(i64* %r6, i64* %r2, i64* %r3)
call void @mcl_fpDbl_mod_NIST_P192L(i64* %r1, i64* %r6, i64* %r6)
ret void
}
define void @mcl_fpDbl_mod_NIST_P521L(i64* noalias  %r1, i64* noalias  %r2, i64* noalias  %r3)
{
%r4 = load i64, i64* %r2
%r5 = zext i64 %r4 to i128
%r7 = getelementptr i64, i64* %r2, i32 1
%r8 = load i64, i64* %r7
%r9 = zext i64 %r8 to i128
%r10 = shl i128 %r9, 64
%r11 = or i128 %r5, %r10
%r12 = zext i128 %r11 to i192
%r14 = getelementptr i64, i64* %r2, i32 2
%r15 = load i64, i64* %r14
%r16 = zext i64 %r15 to i192
%r17 = shl i192 %r16, 128
%r18 = or i192 %r12, %r17
%r19 = zext i192 %r18 to i256
%r21 = getelementptr i64, i64* %r2, i32 3
%r22 = load i64, i64* %r21
%r23 = zext i64 %r22 to i256
%r24 = shl i256 %r23, 192
%r25 = or i256 %r19, %r24
%r26 = zext i256 %r25 to i320
%r28 = getelementptr i64, i64* %r2, i32 4
%r29 = load i64, i64* %r28
%r30 = zext i64 %r29 to i320
%r31 = shl i320 %r30, 256
%r32 = or i320 %r26, %r31
%r33 = zext i320 %r32 to i384
%r35 = getelementptr i64, i64* %r2, i32 5
%r36 = load i64, i64* %r35
%r37 = zext i64 %r36 to i384
%r38 = shl i384 %r37, 320
%r39 = or i384 %r33, %r38
%r40 = zext i384 %r39 to i448
%r42 = getelementptr i64, i64* %r2, i32 6
%r43 = load i64, i64* %r42
%r44 = zext i64 %r43 to i448
%r45 = shl i448 %r44, 384
%r46 = or i448 %r40, %r45
%r47 = zext i448 %r46 to i512
%r49 = getelementptr i64, i64* %r2, i32 7
%r50 = load i64, i64* %r49
%r51 = zext i64 %r50 to i512
%r52 = shl i512 %r51, 448
%r53 = or i512 %r47, %r52
%r54 = zext i512 %r53 to i576
%r56 = getelementptr i64, i64* %r2, i32 8
%r57 = load i64, i64* %r56
%r58 = zext i64 %r57 to i576
%r59 = shl i576 %r58, 512
%r60 = or i576 %r54, %r59
%r61 = zext i576 %r60 to i640
%r63 = getelementptr i64, i64* %r2, i32 9
%r64 = load i64, i64* %r63
%r65 = zext i64 %r64 to i640
%r66 = shl i640 %r65, 576
%r67 = or i640 %r61, %r66
%r68 = zext i640 %r67 to i704
%r70 = getelementptr i64, i64* %r2, i32 10
%r71 = load i64, i64* %r70
%r72 = zext i64 %r71 to i704
%r73 = shl i704 %r72, 640
%r74 = or i704 %r68, %r73
%r75 = zext i704 %r74 to i768
%r77 = getelementptr i64, i64* %r2, i32 11
%r78 = load i64, i64* %r77
%r79 = zext i64 %r78 to i768
%r80 = shl i768 %r79, 704
%r81 = or i768 %r75, %r80
%r82 = zext i768 %r81 to i832
%r84 = getelementptr i64, i64* %r2, i32 12
%r85 = load i64, i64* %r84
%r86 = zext i64 %r85 to i832
%r87 = shl i832 %r86, 768
%r88 = or i832 %r82, %r87
%r89 = zext i832 %r88 to i896
%r91 = getelementptr i64, i64* %r2, i32 13
%r92 = load i64, i64* %r91
%r93 = zext i64 %r92 to i896
%r94 = shl i896 %r93, 832
%r95 = or i896 %r89, %r94
%r96 = zext i896 %r95 to i960
%r98 = getelementptr i64, i64* %r2, i32 14
%r99 = load i64, i64* %r98
%r100 = zext i64 %r99 to i960
%r101 = shl i960 %r100, 896
%r102 = or i960 %r96, %r101
%r103 = zext i960 %r102 to i1024
%r105 = getelementptr i64, i64* %r2, i32 15
%r106 = load i64, i64* %r105
%r107 = zext i64 %r106 to i1024
%r108 = shl i1024 %r107, 960
%r109 = or i1024 %r103, %r108
%r110 = zext i1024 %r109 to i1088
%r112 = getelementptr i64, i64* %r2, i32 16
%r113 = load i64, i64* %r112
%r114 = zext i64 %r113 to i1088
%r115 = shl i1088 %r114, 1024
%r116 = or i1088 %r110, %r115
%r117 = trunc i1088 %r116 to i521
%r118 = zext i521 %r117 to i576
%r119 = lshr i1088 %r116, 521
%r120 = trunc i1088 %r119 to i576
%r121 = add i576 %r118, %r120
%r122 = lshr i576 %r121, 521
%r124 = and i576 %r122, 1
%r125 = add i576 %r121, %r124
%r126 = trunc i576 %r125 to i521
%r127 = zext i521 %r126 to i576
%r128 = lshr i576 %r127, 512
%r129 = trunc i576 %r128 to i64
%r131 = or i64 %r129, -512
%r132 = lshr i576 %r127, 0
%r133 = trunc i576 %r132 to i64
%r134 = and i64 %r131, %r133
%r135 = lshr i576 %r127, 64
%r136 = trunc i576 %r135 to i64
%r137 = and i64 %r134, %r136
%r138 = lshr i576 %r127, 128
%r139 = trunc i576 %r138 to i64
%r140 = and i64 %r137, %r139
%r141 = lshr i576 %r127, 192
%r142 = trunc i576 %r141 to i64
%r143 = and i64 %r140, %r142
%r144 = lshr i576 %r127, 256
%r145 = trunc i576 %r144 to i64
%r146 = and i64 %r143, %r145
%r147 = lshr i576 %r127, 320
%r148 = trunc i576 %r147 to i64
%r149 = and i64 %r146, %r148
%r150 = lshr i576 %r127, 384
%r151 = trunc i576 %r150 to i64
%r152 = and i64 %r149, %r151
%r153 = lshr i576 %r127, 448
%r154 = trunc i576 %r153 to i64
%r155 = and i64 %r152, %r154
%r157 = icmp eq i64 %r155, -1
br i1%r157, label %zero, label %nonzero
zero:
store i64 0, i64* %r1
%r161 = getelementptr i64, i64* %r1, i32 1
store i64 0, i64* %r161
%r164 = getelementptr i64, i64* %r1, i32 2
store i64 0, i64* %r164
%r167 = getelementptr i64, i64* %r1, i32 3
store i64 0, i64* %r167
%r170 = getelementptr i64, i64* %r1, i32 4
store i64 0, i64* %r170
%r173 = getelementptr i64, i64* %r1, i32 5
store i64 0, i64* %r173
%r176 = getelementptr i64, i64* %r1, i32 6
store i64 0, i64* %r176
%r179 = getelementptr i64, i64* %r1, i32 7
store i64 0, i64* %r179
%r182 = getelementptr i64, i64* %r1, i32 8
store i64 0, i64* %r182
ret void
nonzero:
%r183 = trunc i576 %r127 to i64
%r185 = getelementptr i64, i64* %r1, i32 0
store i64 %r183, i64* %r185
%r186 = lshr i576 %r127, 64
%r187 = trunc i576 %r186 to i64
%r189 = getelementptr i64, i64* %r1, i32 1
store i64 %r187, i64* %r189
%r190 = lshr i576 %r186, 64
%r191 = trunc i576 %r190 to i64
%r193 = getelementptr i64, i64* %r1, i32 2
store i64 %r191, i64* %r193
%r194 = lshr i576 %r190, 64
%r195 = trunc i576 %r194 to i64
%r197 = getelementptr i64, i64* %r1, i32 3
store i64 %r195, i64* %r197
%r198 = lshr i576 %r194, 64
%r199 = trunc i576 %r198 to i64
%r201 = getelementptr i64, i64* %r1, i32 4
store i64 %r199, i64* %r201
%r202 = lshr i576 %r198, 64
%r203 = trunc i576 %r202 to i64
%r205 = getelementptr i64, i64* %r1, i32 5
store i64 %r203, i64* %r205
%r206 = lshr i576 %r202, 64
%r207 = trunc i576 %r206 to i64
%r209 = getelementptr i64, i64* %r1, i32 6
store i64 %r207, i64* %r209
%r210 = lshr i576 %r206, 64
%r211 = trunc i576 %r210 to i64
%r213 = getelementptr i64, i64* %r1, i32 7
store i64 %r211, i64* %r213
%r214 = lshr i576 %r210, 64
%r215 = trunc i576 %r214 to i64
%r217 = getelementptr i64, i64* %r1, i32 8
store i64 %r215, i64* %r217
ret void
}
define i128 @mulPv64x64(i64* noalias  %r2, i64 %r3)
{
%r5 = call i128 @mulPos64x64(i64* %r2, i64 %r3, i64 0)
%r6 = trunc i128 %r5 to i64
%r7 = call i64 @extractHigh64(i128 %r5)
%r8 = zext i64 %r6 to i128
%r9 = zext i64 %r7 to i128
%r10 = shl i128 %r9, 64
%r11 = add i128 %r8, %r10
ret i128 %r11
}
define void @mcl_fp_mulUnitPre1L(i64* noalias  %r1, i64* noalias  %r2, i64 %r3)
{
%r4 = call i128 @mulPv64x64(i64* %r2, i64 %r3)
%r5 = trunc i128 %r4 to i64
%r7 = getelementptr i64, i64* %r1, i32 0
store i64 %r5, i64* %r7
%r8 = lshr i128 %r4, 64
%r9 = trunc i128 %r8 to i64
%r11 = getelementptr i64, i64* %r1, i32 1
store i64 %r9, i64* %r11
ret void
}
define void @mcl_fpDbl_mulPre1L(i64* noalias  %r1, i64* noalias  %r2, i64* noalias  %r3)
{
%r4 = load i64, i64* %r2
%r5 = load i64, i64* %r3
%r6 = zext i64 %r4 to i128
%r7 = zext i64 %r5 to i128
%r8 = mul i128 %r6, %r7
%r9 = trunc i128 %r8 to i64
%r11 = getelementptr i64, i64* %r1, i32 0
store i64 %r9, i64* %r11
%r12 = lshr i128 %r8, 64
%r13 = trunc i128 %r12 to i64
%r15 = getelementptr i64, i64* %r1, i32 1
store i64 %r13, i64* %r15
ret void
}
define void @mcl_fpDbl_sqrPre1L(i64* noalias  %r1, i64* noalias  %r2)
{
%r3 = load i64, i64* %r2
%r4 = load i64, i64* %r2
%r5 = zext i64 %r3 to i128
%r6 = zext i64 %r4 to i128
%r7 = mul i128 %r5, %r6
%r8 = trunc i128 %r7 to i64
%r10 = getelementptr i64, i64* %r1, i32 0
store i64 %r8, i64* %r10
%r11 = lshr i128 %r7, 64
%r12 = trunc i128 %r11 to i64
%r14 = getelementptr i64, i64* %r1, i32 1
store i64 %r12, i64* %r14
ret void
}
define void @mcl_fp_mont1L(i64* %r1, i64* %r2, i64* %r3, i64* %r4)
{
%r6 = getelementptr i64, i64* %r4, i32 -1
%r7 = load i64, i64* %r6
%r9 = getelementptr i64, i64* %r3, i32 0
%r10 = load i64, i64* %r9
%r11 = call i128 @mulPv64x64(i64* %r2, i64 %r10)
%r12 = zext i128 %r11 to i192
%r13 = trunc i128 %r11 to i64
%r14 = mul i64 %r13, %r7
%r15 = call i128 @mulPv64x64(i64* %r4, i64 %r14)
%r16 = zext i128 %r15 to i192
%r17 = add i192 %r12, %r16
%r18 = lshr i192 %r17, 64
%r19 = trunc i192 %r18 to i128
%r20 = load i64, i64* %r4
%r21 = zext i64 %r20 to i128
%r22 = sub i128 %r19, %r21
%r23 = lshr i128 %r22, 64
%r24 = trunc i128 %r23 to i1
%r25 = select i1 %r24, i128 %r19, i128 %r22
%r26 = trunc i128 %r25 to i64
store i64 %r26, i64* %r1
ret void
}
define void @mcl_fp_montNF1L(i64* %r1, i64* %r2, i64* %r3, i64* %r4)
{
%r6 = getelementptr i64, i64* %r4, i32 -1
%r7 = load i64, i64* %r6
%r8 = load i64, i64* %r3
%r9 = call i128 @mulPv64x64(i64* %r2, i64 %r8)
%r10 = trunc i128 %r9 to i64
%r11 = mul i64 %r10, %r7
%r12 = call i128 @mulPv64x64(i64* %r4, i64 %r11)
%r13 = add i128 %r9, %r12
%r14 = lshr i128 %r13, 64
%r15 = trunc i128 %r14 to i64
%r16 = load i64, i64* %r4
%r17 = sub i64 %r15, %r16
%r18 = lshr i64 %r17, 63
%r19 = trunc i64 %r18 to i1
%r20 = select i1 %r19, i64 %r15, i64 %r17
store i64 %r20, i64* %r1
ret void
}
define void @mcl_fp_montRed1L(i64* noalias  %r1, i64* noalias  %r2, i64* noalias  %r3)
{
%r5 = getelementptr i64, i64* %r3, i32 -1
%r6 = load i64, i64* %r5
%r7 = load i64, i64* %r3
%r8 = load i64, i64* %r2
%r9 = zext i64 %r8 to i128
%r11 = getelementptr i64, i64* %r2, i32 1
%r12 = load i64, i64* %r11
%r13 = zext i64 %r12 to i128
%r14 = shl i128 %r13, 64
%r15 = or i128 %r9, %r14
%r16 = zext i128 %r15 to i192
%r17 = trunc i192 %r16 to i64
%r18 = mul i64 %r17, %r6
%r19 = call i128 @mulPv64x64(i64* %r3, i64 %r18)
%r20 = zext i128 %r19 to i192
%r21 = add i192 %r16, %r20
%r22 = lshr i192 %r21, 64
%r23 = trunc i192 %r22 to i128
%r24 = zext i64 %r7 to i128
%r25 = sub i128 %r23, %r24
%r26 = lshr i128 %r25, 64
%r27 = trunc i128 %r26 to i1
%r28 = select i1 %r27, i128 %r23, i128 %r25
%r29 = trunc i128 %r28 to i64
store i64 %r29, i64* %r1
ret void
}
define i64 @mcl_fp_addPre1L(i64* noalias  %r2, i64* noalias  %r3, i64* noalias  %r4)
{
%r5 = load i64, i64* %r3
%r6 = zext i64 %r5 to i128
%r7 = load i64, i64* %r4
%r8 = zext i64 %r7 to i128
%r9 = add i128 %r6, %r8
%r10 = trunc i128 %r9 to i64
store i64 %r10, i64* %r2
%r11 = lshr i128 %r9, 64
%r12 = trunc i128 %r11 to i64
ret i64 %r12
}
define i64 @mcl_fp_subPre1L(i64* noalias  %r2, i64* noalias  %r3, i64* noalias  %r4)
{
%r5 = load i64, i64* %r3
%r6 = zext i64 %r5 to i128
%r7 = load i64, i64* %r4
%r8 = zext i64 %r7 to i128
%r9 = sub i128 %r6, %r8
%r10 = trunc i128 %r9 to i64
store i64 %r10, i64* %r2
%r11 = lshr i128 %r9, 64
%r12 = trunc i128 %r11 to i64
%r14 = and i64 %r12, 1
ret i64 %r14
}
define void @mcl_fp_shr1_1L(i64* noalias  %r1, i64* noalias  %r2)
{
%r3 = load i64, i64* %r2
%r4 = lshr i64 %r3, 1
store i64 %r4, i64* %r1
ret void
}
define void @mcl_fp_add1L(i64* noalias  %r1, i64* noalias  %r2, i64* noalias  %r3, i64* noalias  %r4)
{
%r5 = load i64, i64* %r2
%r6 = load i64, i64* %r3
%r7 = zext i64 %r5 to i128
%r8 = zext i64 %r6 to i128
%r9 = add i128 %r7, %r8
%r10 = trunc i128 %r9 to i64
store i64 %r10, i64* %r1
%r11 = load i64, i64* %r4
%r12 = zext i64 %r11 to i128
%r13 = sub i128 %r9, %r12
%r14 = lshr i128 %r13, 64
%r15 = trunc i128 %r14 to i1
br i1%r15, label %carry, label %nocarry
nocarry:
%r16 = trunc i128 %r13 to i64
store i64 %r16, i64* %r1
ret void
carry:
ret void
}
define void @mcl_fp_addNF1L(i64* noalias  %r1, i64* noalias  %r2, i64* noalias  %r3, i64* noalias  %r4)
{
%r5 = load i64, i64* %r2
%r6 = load i64, i64* %r3
%r7 = add i64 %r5, %r6
%r8 = load i64, i64* %r4
%r9 = sub i64 %r7, %r8
%r10 = lshr i64 %r9, 63
%r11 = trunc i64 %r10 to i1
%r12 = select i1 %r11, i64 %r7, i64 %r9
store i64 %r12, i64* %r1
ret void
}
define void @mcl_fp_sub1L(i64* noalias  %r1, i64* noalias  %r2, i64* noalias  %r3, i64* noalias  %r4)
{
%r5 = load i64, i64* %r2
%r6 = load i64, i64* %r3
%r7 = zext i64 %r5 to i128
%r8 = zext i64 %r6 to i128
%r9 = sub i128 %r7, %r8
%r10 = trunc i128 %r9 to i64
%r11 = lshr i128 %r9, 64
%r12 = trunc i128 %r11 to i1
store i64 %r10, i64* %r1
br i1%r12, label %carry, label %nocarry
nocarry:
ret void
carry:
%r13 = load i64, i64* %r4
%r14 = add i64 %r10, %r13
store i64 %r14, i64* %r1
ret void
}
define void @mcl_fp_subNF1L(i64* noalias  %r1, i64* noalias  %r2, i64* noalias  %r3, i64* noalias  %r4)
{
%r5 = load i64, i64* %r2
%r6 = load i64, i64* %r3
%r7 = sub i64 %r5, %r6
%r8 = lshr i64 %r7, 63
%r9 = trunc i64 %r8 to i1
%r10 = load i64, i64* %r4
%r12 = select i1 %r9, i64 %r10, i64 0
%r13 = add i64 %r7, %r12
store i64 %r13, i64* %r1
ret void
}
define void @mcl_fpDbl_add1L(i64* noalias  %r1, i64* noalias  %r2, i64* noalias  %r3, i64* noalias  %r4)
{
%r5 = load i64, i64* %r2
%r6 = zext i64 %r5 to i128
%r8 = getelementptr i64, i64* %r2, i32 1
%r9 = load i64, i64* %r8
%r10 = zext i64 %r9 to i128
%r11 = shl i128 %r10, 64
%r12 = or i128 %r6, %r11
%r13 = load i64, i64* %r3
%r14 = zext i64 %r13 to i128
%r16 = getelementptr i64, i64* %r3, i32 1
%r17 = load i64, i64* %r16
%r18 = zext i64 %r17 to i128
%r19 = shl i128 %r18, 64
%r20 = or i128 %r14, %r19
%r21 = zext i128 %r12 to i192
%r22 = zext i128 %r20 to i192
%r23 = add i192 %r21, %r22
%r24 = trunc i192 %r23 to i64
store i64 %r24, i64* %r1
%r25 = lshr i192 %r23, 64
%r26 = trunc i192 %r25 to i128
%r27 = load i64, i64* %r4
%r28 = zext i64 %r27 to i128
%r29 = sub i128 %r26, %r28
%r30 = lshr i128 %r29, 64
%r31 = trunc i128 %r30 to i1
%r32 = select i1 %r31, i128 %r26, i128 %r29
%r33 = trunc i128 %r32 to i64
%r35 = getelementptr i64, i64* %r1, i32 1
store i64 %r33, i64* %r35
ret void
}
define void @mcl_fpDbl_sub1L(i64* noalias  %r1, i64* noalias  %r2, i64* noalias  %r3, i64* noalias  %r4)
{
%r5 = load i64, i64* %r2
%r6 = zext i64 %r5 to i128
%r8 = getelementptr i64, i64* %r2, i32 1
%r9 = load i64, i64* %r8
%r10 = zext i64 %r9 to i128
%r11 = shl i128 %r10, 64
%r12 = or i128 %r6, %r11
%r13 = load i64, i64* %r3
%r14 = zext i64 %r13 to i128
%r16 = getelementptr i64, i64* %r3, i32 1
%r17 = load i64, i64* %r16
%r18 = zext i64 %r17 to i128
%r19 = shl i128 %r18, 64
%r20 = or i128 %r14, %r19
%r21 = zext i128 %r12 to i192
%r22 = zext i128 %r20 to i192
%r23 = sub i192 %r21, %r22
%r24 = trunc i192 %r23 to i64
store i64 %r24, i64* %r1
%r25 = lshr i192 %r23, 64
%r26 = trunc i192 %r25 to i64
%r27 = lshr i192 %r23, 128
%r28 = trunc i192 %r27 to i1
%r29 = load i64, i64* %r4
%r31 = select i1 %r28, i64 %r29, i64 0
%r32 = add i64 %r26, %r31
%r34 = getelementptr i64, i64* %r1, i32 1
store i64 %r32, i64* %r34
ret void
}
define i192 @mulPv128x64(i64* noalias  %r2, i64 %r3)
{
%r5 = call i128 @mulPos64x64(i64* %r2, i64 %r3, i64 0)
%r6 = trunc i128 %r5 to i64
%r7 = call i64 @extractHigh64(i128 %r5)
%r9 = call i128 @mulPos64x64(i64* %r2, i64 %r3, i64 1)
%r10 = trunc i128 %r9 to i64
%r11 = call i64 @extractHigh64(i128 %r9)
%r12 = zext i64 %r6 to i128
%r13 = zext i64 %r10 to i128
%r14 = shl i128 %r13, 64
%r15 = or i128 %r12, %r14
%r16 = zext i64 %r7 to i128
%r17 = zext i64 %r11 to i128
%r18 = shl i128 %r17, 64
%r19 = or i128 %r16, %r18
%r20 = zext i128 %r15 to i192
%r21 = zext i128 %r19 to i192
%r22 = shl i192 %r21, 64
%r23 = add i192 %r20, %r22
ret i192 %r23
}
define void @mcl_fp_mulUnitPre2L(i64* noalias  %r1, i64* noalias  %r2, i64 %r3)
{
%r4 = call i192 @mulPv128x64(i64* %r2, i64 %r3)
%r5 = trunc i192 %r4 to i64
%r7 = getelementptr i64, i64* %r1, i32 0
store i64 %r5, i64* %r7
%r8 = lshr i192 %r4, 64
%r9 = trunc i192 %r8 to i64
%r11 = getelementptr i64, i64* %r1, i32 1
store i64 %r9, i64* %r11
%r12 = lshr i192 %r8, 64
%r13 = trunc i192 %r12 to i64
%r15 = getelementptr i64, i64* %r1, i32 2
store i64 %r13, i64* %r15
ret void
}
define void @mcl_fpDbl_mulPre2L(i64* noalias  %r1, i64* noalias  %r2, i64* noalias  %r3)
{
%r4 = load i64, i64* %r3
%r5 = call i192 @mulPv128x64(i64* %r2, i64 %r4)
%r6 = trunc i192 %r5 to i64
store i64 %r6, i64* %r1
%r7 = lshr i192 %r5, 64
%r9 = getelementptr i64, i64* %r3, i32 1
%r10 = load i64, i64* %r9
%r11 = call i192 @mulPv128x64(i64* %r2, i64 %r10)
%r12 = add i192 %r7, %r11
%r14 = getelementptr i64, i64* %r1, i32 1
%r15 = trunc i192 %r12 to i64
%r17 = getelementptr i64, i64* %r14, i32 0
store i64 %r15, i64* %r17
%r18 = lshr i192 %r12, 64
%r19 = trunc i192 %r18 to i64
%r21 = getelementptr i64, i64* %r14, i32 1
store i64 %r19, i64* %r21
%r22 = lshr i192 %r18, 64
%r23 = trunc i192 %r22 to i64
%r25 = getelementptr i64, i64* %r14, i32 2
store i64 %r23, i64* %r25
ret void
}
define void @mcl_fpDbl_sqrPre2L(i64* noalias  %r1, i64* noalias  %r2)
{
%r3 = load i64, i64* %r2
%r4 = call i192 @mulPv128x64(i64* %r2, i64 %r3)
%r5 = trunc i192 %r4 to i64
store i64 %r5, i64* %r1
%r6 = lshr i192 %r4, 64
%r8 = getelementptr i64, i64* %r2, i32 1
%r9 = load i64, i64* %r8
%r10 = call i192 @mulPv128x64(i64* %r2, i64 %r9)
%r11 = add i192 %r6, %r10
%r13 = getelementptr i64, i64* %r1, i32 1
%r14 = trunc i192 %r11 to i64
%r16 = getelementptr i64, i64* %r13, i32 0
store i64 %r14, i64* %r16
%r17 = lshr i192 %r11, 64
%r18 = trunc i192 %r17 to i64
%r20 = getelementptr i64, i64* %r13, i32 1
store i64 %r18, i64* %r20
%r21 = lshr i192 %r17, 64
%r22 = trunc i192 %r21 to i64
%r24 = getelementptr i64, i64* %r13, i32 2
store i64 %r22, i64* %r24
ret void
}
define void @mcl_fp_mont2L(i64* %r1, i64* %r2, i64* %r3, i64* %r4)
{
%r6 = getelementptr i64, i64* %r4, i32 -1
%r7 = load i64, i64* %r6
%r9 = getelementptr i64, i64* %r3, i32 0
%r10 = load i64, i64* %r9
%r11 = call i192 @mulPv128x64(i64* %r2, i64 %r10)
%r12 = zext i192 %r11 to i256
%r13 = trunc i192 %r11 to i64
%r14 = mul i64 %r13, %r7
%r15 = call i192 @mulPv128x64(i64* %r4, i64 %r14)
%r16 = zext i192 %r15 to i256
%r17 = add i256 %r12, %r16
%r18 = lshr i256 %r17, 64
%r20 = getelementptr i64, i64* %r3, i32 1
%r21 = load i64, i64* %r20
%r22 = call i192 @mulPv128x64(i64* %r2, i64 %r21)
%r23 = zext i192 %r22 to i256
%r24 = add i256 %r18, %r23
%r25 = trunc i256 %r24 to i64
%r26 = mul i64 %r25, %r7
%r27 = call i192 @mulPv128x64(i64* %r4, i64 %r26)
%r28 = zext i192 %r27 to i256
%r29 = add i256 %r24, %r28
%r30 = lshr i256 %r29, 64
%r31 = trunc i256 %r30 to i192
%r32 = load i64, i64* %r4
%r33 = zext i64 %r32 to i128
%r35 = getelementptr i64, i64* %r4, i32 1
%r36 = load i64, i64* %r35
%r37 = zext i64 %r36 to i128
%r38 = shl i128 %r37, 64
%r39 = or i128 %r33, %r38
%r40 = zext i128 %r39 to i192
%r41 = sub i192 %r31, %r40
%r42 = lshr i192 %r41, 128
%r43 = trunc i192 %r42 to i1
%r44 = select i1 %r43, i192 %r31, i192 %r41
%r45 = trunc i192 %r44 to i128
%r46 = trunc i128 %r45 to i64
%r48 = getelementptr i64, i64* %r1, i32 0
store i64 %r46, i64* %r48
%r49 = lshr i128 %r45, 64
%r50 = trunc i128 %r49 to i64
%r52 = getelementptr i64, i64* %r1, i32 1
store i64 %r50, i64* %r52
ret void
}
define void @mcl_fp_montNF2L(i64* %r1, i64* %r2, i64* %r3, i64* %r4)
{
%r6 = getelementptr i64, i64* %r4, i32 -1
%r7 = load i64, i64* %r6
%r8 = load i64, i64* %r3
%r9 = call i192 @mulPv128x64(i64* %r2, i64 %r8)
%r10 = trunc i192 %r9 to i64
%r11 = mul i64 %r10, %r7
%r12 = call i192 @mulPv128x64(i64* %r4, i64 %r11)
%r13 = add i192 %r9, %r12
%r14 = lshr i192 %r13, 64
%r16 = getelementptr i64, i64* %r3, i32 1
%r17 = load i64, i64* %r16
%r18 = call i192 @mulPv128x64(i64* %r2, i64 %r17)
%r19 = add i192 %r14, %r18
%r20 = trunc i192 %r19 to i64
%r21 = mul i64 %r20, %r7
%r22 = call i192 @mulPv128x64(i64* %r4, i64 %r21)
%r23 = add i192 %r19, %r22
%r24 = lshr i192 %r23, 64
%r25 = trunc i192 %r24 to i128
%r26 = load i64, i64* %r4
%r27 = zext i64 %r26 to i128
%r29 = getelementptr i64, i64* %r4, i32 1
%r30 = load i64, i64* %r29
%r31 = zext i64 %r30 to i128
%r32 = shl i128 %r31, 64
%r33 = or i128 %r27, %r32
%r34 = sub i128 %r25, %r33
%r35 = lshr i128 %r34, 127
%r36 = trunc i128 %r35 to i1
%r37 = select i1 %r36, i128 %r25, i128 %r34
%r38 = trunc i128 %r37 to i64
%r40 = getelementptr i64, i64* %r1, i32 0
store i64 %r38, i64* %r40
%r41 = lshr i128 %r37, 64
%r42 = trunc i128 %r41 to i64
%r44 = getelementptr i64, i64* %r1, i32 1
store i64 %r42, i64* %r44
ret void
}
define void @mcl_fp_montRed2L(i64* noalias  %r1, i64* noalias  %r2, i64* noalias  %r3)
{
%r5 = getelementptr i64, i64* %r3, i32 -1
%r6 = load i64, i64* %r5
%r7 = load i64, i64* %r3
%r8 = zext i64 %r7 to i128
%r10 = getelementptr i64, i64* %r3, i32 1
%r11 = load i64, i64* %r10
%r12 = zext i64 %r11 to i128
%r13 = shl i128 %r12, 64
%r14 = or i128 %r8, %r13
%r15 = load i64, i64* %r2
%r16 = zext i64 %r15 to i128
%r18 = getelementptr i64, i64* %r2, i32 1
%r19 = load i64, i64* %r18
%r20 = zext i64 %r19 to i128
%r21 = shl i128 %r20, 64
%r22 = or i128 %r16, %r21
%r23 = zext i128 %r22 to i192
%r25 = getelementptr i64, i64* %r2, i32 2
%r26 = load i64, i64* %r25
%r27 = zext i64 %r26 to i192
%r28 = shl i192 %r27, 128
%r29 = or i192 %r23, %r28
%r30 = zext i192 %r29 to i256
%r32 = getelementptr i64, i64* %r2, i32 3
%r33 = load i64, i64* %r32
%r34 = zext i64 %r33 to i256
%r35 = shl i256 %r34, 192
%r36 = or i256 %r30, %r35
%r37 = zext i256 %r36 to i320
%r38 = trunc i320 %r37 to i64
%r39 = mul i64 %r38, %r6
%r40 = call i192 @mulPv128x64(i64* %r3, i64 %r39)
%r41 = zext i192 %r40 to i320
%r42 = add i320 %r37, %r41
%r43 = lshr i320 %r42, 64
%r44 = trunc i320 %r43 to i256
%r45 = trunc i256 %r44 to i64
%r46 = mul i64 %r45, %r6
%r47 = call i192 @mulPv128x64(i64* %r3, i64 %r46)
%r48 = zext i192 %r47 to i256
%r49 = add i256 %r44, %r48
%r50 = lshr i256 %r49, 64
%r51 = trunc i256 %r50 to i192
%r52 = zext i128 %r14 to i192
%r53 = sub i192 %r51, %r52
%r54 = lshr i192 %r53, 128
%r55 = trunc i192 %r54 to i1
%r56 = select i1 %r55, i192 %r51, i192 %r53
%r57 = trunc i192 %r56 to i128
%r58 = trunc i128 %r57 to i64
%r60 = getelementptr i64, i64* %r1, i32 0
store i64 %r58, i64* %r60
%r61 = lshr i128 %r57, 64
%r62 = trunc i128 %r61 to i64
%r64 = getelementptr i64, i64* %r1, i32 1
store i64 %r62, i64* %r64
ret void
}
define i64 @mcl_fp_addPre2L(i64* noalias  %r2, i64* noalias  %r3, i64* noalias  %r4)
{
%r5 = load i64, i64* %r3
%r6 = zext i64 %r5 to i128
%r8 = getelementptr i64, i64* %r3, i32 1
%r9 = load i64, i64* %r8
%r10 = zext i64 %r9 to i128
%r11 = shl i128 %r10, 64
%r12 = or i128 %r6, %r11
%r13 = zext i128 %r12 to i192
%r14 = load i64, i64* %r4
%r15 = zext i64 %r14 to i128
%r17 = getelementptr i64, i64* %r4, i32 1
%r18 = load i64, i64* %r17
%r19 = zext i64 %r18 to i128
%r20 = shl i128 %r19, 64
%r21 = or i128 %r15, %r20
%r22 = zext i128 %r21 to i192
%r23 = add i192 %r13, %r22
%r24 = trunc i192 %r23 to i128
%r25 = trunc i128 %r24 to i64
%r27 = getelementptr i64, i64* %r2, i32 0
store i64 %r25, i64* %r27
%r28 = lshr i128 %r24, 64
%r29 = trunc i128 %r28 to i64
%r31 = getelementptr i64, i64* %r2, i32 1
store i64 %r29, i64* %r31
%r32 = lshr i192 %r23, 128
%r33 = trunc i192 %r32 to i64
ret i64 %r33
}
define i64 @mcl_fp_subPre2L(i64* noalias  %r2, i64* noalias  %r3, i64* noalias  %r4)
{
%r5 = load i64, i64* %r3
%r6 = zext i64 %r5 to i128
%r8 = getelementptr i64, i64* %r3, i32 1
%r9 = load i64, i64* %r8
%r10 = zext i64 %r9 to i128
%r11 = shl i128 %r10, 64
%r12 = or i128 %r6, %r11
%r13 = zext i128 %r12 to i192
%r14 = load i64, i64* %r4
%r15 = zext i64 %r14 to i128
%r17 = getelementptr i64, i64* %r4, i32 1
%r18 = load i64, i64* %r17
%r19 = zext i64 %r18 to i128
%r20 = shl i128 %r19, 64
%r21 = or i128 %r15, %r20
%r22 = zext i128 %r21 to i192
%r23 = sub i192 %r13, %r22
%r24 = trunc i192 %r23 to i128
%r25 = trunc i128 %r24 to i64
%r27 = getelementptr i64, i64* %r2, i32 0
store i64 %r25, i64* %r27
%r28 = lshr i128 %r24, 64
%r29 = trunc i128 %r28 to i64
%r31 = getelementptr i64, i64* %r2, i32 1
store i64 %r29, i64* %r31
%r32 = lshr i192 %r23, 128
%r33 = trunc i192 %r32 to i64
%r35 = and i64 %r33, 1
ret i64 %r35
}
define void @mcl_fp_shr1_2L(i64* noalias  %r1, i64* noalias  %r2)
{
%r3 = load i64, i64* %r2
%r4 = zext i64 %r3 to i128
%r6 = getelementptr i64, i64* %r2, i32 1
%r7 = load i64, i64* %r6
%r8 = zext i64 %r7 to i128
%r9 = shl i128 %r8, 64
%r10 = or i128 %r4, %r9
%r11 = lshr i128 %r10, 1
%r12 = trunc i128 %r11 to i64
%r14 = getelementptr i64, i64* %r1, i32 0
store i64 %r12, i64* %r14
%r15 = lshr i128 %r11, 64
%r16 = trunc i128 %r15 to i64
%r18 = getelementptr i64, i64* %r1, i32 1
store i64 %r16, i64* %r18
ret void
}
define void @mcl_fp_add2L(i64* noalias  %r1, i64* noalias  %r2, i64* noalias  %r3, i64* noalias  %r4)
{
%r5 = load i64, i64* %r2
%r6 = zext i64 %r5 to i128
%r8 = getelementptr i64, i64* %r2, i32 1
%r9 = load i64, i64* %r8
%r10 = zext i64 %r9 to i128
%r11 = shl i128 %r10, 64
%r12 = or i128 %r6, %r11
%r13 = load i64, i64* %r3
%r14 = zext i64 %r13 to i128
%r16 = getelementptr i64, i64* %r3, i32 1
%r17 = load i64, i64* %r16
%r18 = zext i64 %r17 to i128
%r19 = shl i128 %r18, 64
%r20 = or i128 %r14, %r19
%r21 = zext i128 %r12 to i192
%r22 = zext i128 %r20 to i192
%r23 = add i192 %r21, %r22
%r24 = trunc i192 %r23 to i128
%r25 = trunc i128 %r24 to i64
%r27 = getelementptr i64, i64* %r1, i32 0
store i64 %r25, i64* %r27
%r28 = lshr i128 %r24, 64
%r29 = trunc i128 %r28 to i64
%r31 = getelementptr i64, i64* %r1, i32 1
store i64 %r29, i64* %r31
%r32 = load i64, i64* %r4
%r33 = zext i64 %r32 to i128
%r35 = getelementptr i64, i64* %r4, i32 1
%r36 = load i64, i64* %r35
%r37 = zext i64 %r36 to i128
%r38 = shl i128 %r37, 64
%r39 = or i128 %r33, %r38
%r40 = zext i128 %r39 to i192
%r41 = sub i192 %r23, %r40
%r42 = lshr i192 %r41, 128
%r43 = trunc i192 %r42 to i1
br i1%r43, label %carry, label %nocarry
nocarry:
%r44 = trunc i192 %r41 to i128
%r45 = trunc i128 %r44 to i64
%r47 = getelementptr i64, i64* %r1, i32 0
store i64 %r45, i64* %r47
%r48 = lshr i128 %r44, 64
%r49 = trunc i128 %r48 to i64
%r51 = getelementptr i64, i64* %r1, i32 1
store i64 %r49, i64* %r51
ret void
carry:
ret void
}
define void @mcl_fp_addNF2L(i64* noalias  %r1, i64* noalias  %r2, i64* noalias  %r3, i64* noalias  %r4)
{
%r5 = load i64, i64* %r2
%r6 = zext i64 %r5 to i128
%r8 = getelementptr i64, i64* %r2, i32 1
%r9 = load i64, i64* %r8
%r10 = zext i64 %r9 to i128
%r11 = shl i128 %r10, 64
%r12 = or i128 %r6, %r11
%r13 = load i64, i64* %r3
%r14 = zext i64 %r13 to i128
%r16 = getelementptr i64, i64* %r3, i32 1
%r17 = load i64, i64* %r16
%r18 = zext i64 %r17 to i128
%r19 = shl i128 %r18, 64
%r20 = or i128 %r14, %r19
%r21 = add i128 %r12, %r20
%r22 = load i64, i64* %r4
%r23 = zext i64 %r22 to i128
%r25 = getelementptr i64, i64* %r4, i32 1
%r26 = load i64, i64* %r25
%r27 = zext i64 %r26 to i128
%r28 = shl i128 %r27, 64
%r29 = or i128 %r23, %r28
%r30 = sub i128 %r21, %r29
%r31 = lshr i128 %r30, 127
%r32 = trunc i128 %r31 to i1
%r33 = select i1 %r32, i128 %r21, i128 %r30
%r34 = trunc i128 %r33 to i64
%r36 = getelementptr i64, i64* %r1, i32 0
store i64 %r34, i64* %r36
%r37 = lshr i128 %r33, 64
%r38 = trunc i128 %r37 to i64
%r40 = getelementptr i64, i64* %r1, i32 1
store i64 %r38, i64* %r40
ret void
}
define void @mcl_fp_sub2L(i64* noalias  %r1, i64* noalias  %r2, i64* noalias  %r3, i64* noalias  %r4)
{
%r5 = load i64, i64* %r2
%r6 = zext i64 %r5 to i128
%r8 = getelementptr i64, i64* %r2, i32 1
%r9 = load i64, i64* %r8
%r10 = zext i64 %r9 to i128
%r11 = shl i128 %r10, 64
%r12 = or i128 %r6, %r11
%r13 = load i64, i64* %r3
%r14 = zext i64 %r13 to i128
%r16 = getelementptr i64, i64* %r3, i32 1
%r17 = load i64, i64* %r16
%r18 = zext i64 %r17 to i128
%r19 = shl i128 %r18, 64
%r20 = or i128 %r14, %r19
%r21 = zext i128 %r12 to i192
%r22 = zext i128 %r20 to i192
%r23 = sub i192 %r21, %r22
%r24 = trunc i192 %r23 to i128
%r25 = lshr i192 %r23, 128
%r26 = trunc i192 %r25 to i1
%r27 = trunc i128 %r24 to i64
%r29 = getelementptr i64, i64* %r1, i32 0
store i64 %r27, i64* %r29
%r30 = lshr i128 %r24, 64
%r31 = trunc i128 %r30 to i64
%r33 = getelementptr i64, i64* %r1, i32 1
store i64 %r31, i64* %r33
br i1%r26, label %carry, label %nocarry
nocarry:
ret void
carry:
%r34 = load i64, i64* %r4
%r35 = zext i64 %r34 to i128
%r37 = getelementptr i64, i64* %r4, i32 1
%r38 = load i64, i64* %r37
%r39 = zext i64 %r38 to i128
%r40 = shl i128 %r39, 64
%r41 = or i128 %r35, %r40
%r42 = add i128 %r24, %r41
%r43 = trunc i128 %r42 to i64
%r45 = getelementptr i64, i64* %r1, i32 0
store i64 %r43, i64* %r45
%r46 = lshr i128 %r42, 64
%r47 = trunc i128 %r46 to i64
%r49 = getelementptr i64, i64* %r1, i32 1
store i64 %r47, i64* %r49
ret void
}
define void @mcl_fp_subNF2L(i64* noalias  %r1, i64* noalias  %r2, i64* noalias  %r3, i64* noalias  %r4)
{
%r5 = load i64, i64* %r2
%r6 = zext i64 %r5 to i128
%r8 = getelementptr i64, i64* %r2, i32 1
%r9 = load i64, i64* %r8
%r10 = zext i64 %r9 to i128
%r11 = shl i128 %r10, 64
%r12 = or i128 %r6, %r11
%r13 = load i64, i64* %r3
%r14 = zext i64 %r13 to i128
%r16 = getelementptr i64, i64* %r3, i32 1
%r17 = load i64, i64* %r16
%r18 = zext i64 %r17 to i128
%r19 = shl i128 %r18, 64
%r20 = or i128 %r14, %r19
%r21 = sub i128 %r12, %r20
%r22 = lshr i128 %r21, 127
%r23 = trunc i128 %r22 to i1
%r24 = load i64, i64* %r4
%r25 = zext i64 %r24 to i128
%r27 = getelementptr i64, i64* %r4, i32 1
%r28 = load i64, i64* %r27
%r29 = zext i64 %r28 to i128
%r30 = shl i128 %r29, 64
%r31 = or i128 %r25, %r30
%r33 = select i1 %r23, i128 %r31, i128 0
%r34 = add i128 %r21, %r33
%r35 = trunc i128 %r34 to i64
%r37 = getelementptr i64, i64* %r1, i32 0
store i64 %r35, i64* %r37
%r38 = lshr i128 %r34, 64
%r39 = trunc i128 %r38 to i64
%r41 = getelementptr i64, i64* %r1, i32 1
store i64 %r39, i64* %r41
ret void
}
define void @mcl_fpDbl_add2L(i64* noalias  %r1, i64* noalias  %r2, i64* noalias  %r3, i64* noalias  %r4)
{
%r5 = load i64, i64* %r2
%r6 = zext i64 %r5 to i128
%r8 = getelementptr i64, i64* %r2, i32 1
%r9 = load i64, i64* %r8
%r10 = zext i64 %r9 to i128
%r11 = shl i128 %r10, 64
%r12 = or i128 %r6, %r11
%r13 = zext i128 %r12 to i192
%r15 = getelementptr i64, i64* %r2, i32 2
%r16 = load i64, i64* %r15
%r17 = zext i64 %r16 to i192
%r18 = shl i192 %r17, 128
%r19 = or i192 %r13, %r18
%r20 = zext i192 %r19 to i256
%r22 = getelementptr i64, i64* %r2, i32 3
%r23 = load i64, i64* %r22
%r24 = zext i64 %r23 to i256
%r25 = shl i256 %r24, 192
%r26 = or i256 %r20, %r25
%r27 = load i64, i64* %r3
%r28 = zext i64 %r27 to i128
%r30 = getelementptr i64, i64* %r3, i32 1
%r31 = load i64, i64* %r30
%r32 = zext i64 %r31 to i128
%r33 = shl i128 %r32, 64
%r34 = or i128 %r28, %r33
%r35 = zext i128 %r34 to i192
%r37 = getelementptr i64, i64* %r3, i32 2
%r38 = load i64, i64* %r37
%r39 = zext i64 %r38 to i192
%r40 = shl i192 %r39, 128
%r41 = or i192 %r35, %r40
%r42 = zext i192 %r41 to i256
%r44 = getelementptr i64, i64* %r3, i32 3
%r45 = load i64, i64* %r44
%r46 = zext i64 %r45 to i256
%r47 = shl i256 %r46, 192
%r48 = or i256 %r42, %r47
%r49 = zext i256 %r26 to i320
%r50 = zext i256 %r48 to i320
%r51 = add i320 %r49, %r50
%r52 = trunc i320 %r51 to i128
%r53 = trunc i128 %r52 to i64
%r55 = getelementptr i64, i64* %r1, i32 0
store i64 %r53, i64* %r55
%r56 = lshr i128 %r52, 64
%r57 = trunc i128 %r56 to i64
%r59 = getelementptr i64, i64* %r1, i32 1
store i64 %r57, i64* %r59
%r60 = lshr i320 %r51, 128
%r61 = trunc i320 %r60 to i192
%r62 = load i64, i64* %r4
%r63 = zext i64 %r62 to i128
%r65 = getelementptr i64, i64* %r4, i32 1
%r66 = load i64, i64* %r65
%r67 = zext i64 %r66 to i128
%r68 = shl i128 %r67, 64
%r69 = or i128 %r63, %r68
%r70 = zext i128 %r69 to i192
%r71 = sub i192 %r61, %r70
%r72 = lshr i192 %r71, 128
%r73 = trunc i192 %r72 to i1
%r74 = select i1 %r73, i192 %r61, i192 %r71
%r75 = trunc i192 %r74 to i128
%r77 = getelementptr i64, i64* %r1, i32 2
%r78 = trunc i128 %r75 to i64
%r80 = getelementptr i64, i64* %r77, i32 0
store i64 %r78, i64* %r80
%r81 = lshr i128 %r75, 64
%r82 = trunc i128 %r81 to i64
%r84 = getelementptr i64, i64* %r77, i32 1
store i64 %r82, i64* %r84
ret void
}
define void @mcl_fpDbl_sub2L(i64* noalias  %r1, i64* noalias  %r2, i64* noalias  %r3, i64* noalias  %r4)
{
%r5 = load i64, i64* %r2
%r6 = zext i64 %r5 to i128
%r8 = getelementptr i64, i64* %r2, i32 1
%r9 = load i64, i64* %r8
%r10 = zext i64 %r9 to i128
%r11 = shl i128 %r10, 64
%r12 = or i128 %r6, %r11
%r13 = zext i128 %r12 to i192
%r15 = getelementptr i64, i64* %r2, i32 2
%r16 = load i64, i64* %r15
%r17 = zext i64 %r16 to i192
%r18 = shl i192 %r17, 128
%r19 = or i192 %r13, %r18
%r20 = zext i192 %r19 to i256
%r22 = getelementptr i64, i64* %r2, i32 3
%r23 = load i64, i64* %r22
%r24 = zext i64 %r23 to i256
%r25 = shl i256 %r24, 192
%r26 = or i256 %r20, %r25
%r27 = load i64, i64* %r3
%r28 = zext i64 %r27 to i128
%r30 = getelementptr i64, i64* %r3, i32 1
%r31 = load i64, i64* %r30
%r32 = zext i64 %r31 to i128
%r33 = shl i128 %r32, 64
%r34 = or i128 %r28, %r33
%r35 = zext i128 %r34 to i192
%r37 = getelementptr i64, i64* %r3, i32 2
%r38 = load i64, i64* %r37
%r39 = zext i64 %r38 to i192
%r40 = shl i192 %r39, 128
%r41 = or i192 %r35, %r40
%r42 = zext i192 %r41 to i256
%r44 = getelementptr i64, i64* %r3, i32 3
%r45 = load i64, i64* %r44
%r46 = zext i64 %r45 to i256
%r47 = shl i256 %r46, 192
%r48 = or i256 %r42, %r47
%r49 = zext i256 %r26 to i320
%r50 = zext i256 %r48 to i320
%r51 = sub i320 %r49, %r50
%r52 = trunc i320 %r51 to i128
%r53 = trunc i128 %r52 to i64
%r55 = getelementptr i64, i64* %r1, i32 0
store i64 %r53, i64* %r55
%r56 = lshr i128 %r52, 64
%r57 = trunc i128 %r56 to i64
%r59 = getelementptr i64, i64* %r1, i32 1
store i64 %r57, i64* %r59
%r60 = lshr i320 %r51, 128
%r61 = trunc i320 %r60 to i128
%r62 = lshr i320 %r51, 256
%r63 = trunc i320 %r62 to i1
%r64 = load i64, i64* %r4
%r65 = zext i64 %r64 to i128
%r67 = getelementptr i64, i64* %r4, i32 1
%r68 = load i64, i64* %r67
%r69 = zext i64 %r68 to i128
%r70 = shl i128 %r69, 64
%r71 = or i128 %r65, %r70
%r73 = select i1 %r63, i128 %r71, i128 0
%r74 = add i128 %r61, %r73
%r76 = getelementptr i64, i64* %r1, i32 2
%r77 = trunc i128 %r74 to i64
%r79 = getelementptr i64, i64* %r76, i32 0
store i64 %r77, i64* %r79
%r80 = lshr i128 %r74, 64
%r81 = trunc i128 %r80 to i64
%r83 = getelementptr i64, i64* %r76, i32 1
store i64 %r81, i64* %r83
ret void
}
define i256 @mulPv192x64(i64* noalias  %r2, i64 %r3)
{
%r5 = call i128 @mulPos64x64(i64* %r2, i64 %r3, i64 0)
%r6 = trunc i128 %r5 to i64
%r7 = call i64 @extractHigh64(i128 %r5)
%r9 = call i128 @mulPos64x64(i64* %r2, i64 %r3, i64 1)
%r10 = trunc i128 %r9 to i64
%r11 = call i64 @extractHigh64(i128 %r9)
%r13 = call i128 @mulPos64x64(i64* %r2, i64 %r3, i64 2)
%r14 = trunc i128 %r13 to i64
%r15 = call i64 @extractHigh64(i128 %r13)
%r16 = zext i64 %r6 to i128
%r17 = zext i64 %r10 to i128
%r18 = shl i128 %r17, 64
%r19 = or i128 %r16, %r18
%r20 = zext i128 %r19 to i192
%r21 = zext i64 %r14 to i192
%r22 = shl i192 %r21, 128
%r23 = or i192 %r20, %r22
%r24 = zext i64 %r7 to i128
%r25 = zext i64 %r11 to i128
%r26 = shl i128 %r25, 64
%r27 = or i128 %r24, %r26
%r28 = zext i128 %r27 to i192
%r29 = zext i64 %r15 to i192
%r30 = shl i192 %r29, 128
%r31 = or i192 %r28, %r30
%r32 = zext i192 %r23 to i256
%r33 = zext i192 %r31 to i256
%r34 = shl i256 %r33, 64
%r35 = add i256 %r32, %r34
ret i256 %r35
}
define void @mcl_fp_mulUnitPre3L(i64* noalias  %r1, i64* noalias  %r2, i64 %r3)
{
%r4 = call i256 @mulPv192x64(i64* %r2, i64 %r3)
%r5 = trunc i256 %r4 to i64
%r7 = getelementptr i64, i64* %r1, i32 0
store i64 %r5, i64* %r7
%r8 = lshr i256 %r4, 64
%r9 = trunc i256 %r8 to i64
%r11 = getelementptr i64, i64* %r1, i32 1
store i64 %r9, i64* %r11
%r12 = lshr i256 %r8, 64
%r13 = trunc i256 %r12 to i64
%r15 = getelementptr i64, i64* %r1, i32 2
store i64 %r13, i64* %r15
%r16 = lshr i256 %r12, 64
%r17 = trunc i256 %r16 to i64
%r19 = getelementptr i64, i64* %r1, i32 3
store i64 %r17, i64* %r19
ret void
}
define void @mcl_fpDbl_mulPre3L(i64* noalias  %r1, i64* noalias  %r2, i64* noalias  %r3)
{
%r4 = load i64, i64* %r3
%r5 = call i256 @mulPv192x64(i64* %r2, i64 %r4)
%r6 = trunc i256 %r5 to i64
store i64 %r6, i64* %r1
%r7 = lshr i256 %r5, 64
%r9 = getelementptr i64, i64* %r3, i32 1
%r10 = load i64, i64* %r9
%r11 = call i256 @mulPv192x64(i64* %r2, i64 %r10)
%r12 = add i256 %r7, %r11
%r13 = trunc i256 %r12 to i64
%r15 = getelementptr i64, i64* %r1, i32 1
store i64 %r13, i64* %r15
%r16 = lshr i256 %r12, 64
%r18 = getelementptr i64, i64* %r3, i32 2
%r19 = load i64, i64* %r18
%r20 = call i256 @mulPv192x64(i64* %r2, i64 %r19)
%r21 = add i256 %r16, %r20
%r23 = getelementptr i64, i64* %r1, i32 2
%r24 = trunc i256 %r21 to i64
%r26 = getelementptr i64, i64* %r23, i32 0
store i64 %r24, i64* %r26
%r27 = lshr i256 %r21, 64
%r28 = trunc i256 %r27 to i64
%r30 = getelementptr i64, i64* %r23, i32 1
store i64 %r28, i64* %r30
%r31 = lshr i256 %r27, 64
%r32 = trunc i256 %r31 to i64
%r34 = getelementptr i64, i64* %r23, i32 2
store i64 %r32, i64* %r34
%r35 = lshr i256 %r31, 64
%r36 = trunc i256 %r35 to i64
%r38 = getelementptr i64, i64* %r23, i32 3
store i64 %r36, i64* %r38
ret void
}
define void @mcl_fpDbl_sqrPre3L(i64* noalias  %r1, i64* noalias  %r2)
{
%r3 = load i64, i64* %r2
%r4 = call i256 @mulPv192x64(i64* %r2, i64 %r3)
%r5 = trunc i256 %r4 to i64
store i64 %r5, i64* %r1
%r6 = lshr i256 %r4, 64
%r8 = getelementptr i64, i64* %r2, i32 1
%r9 = load i64, i64* %r8
%r10 = call i256 @mulPv192x64(i64* %r2, i64 %r9)
%r11 = add i256 %r6, %r10
%r12 = trunc i256 %r11 to i64
%r14 = getelementptr i64, i64* %r1, i32 1
store i64 %r12, i64* %r14
%r15 = lshr i256 %r11, 64
%r17 = getelementptr i64, i64* %r2, i32 2
%r18 = load i64, i64* %r17
%r19 = call i256 @mulPv192x64(i64* %r2, i64 %r18)
%r20 = add i256 %r15, %r19
%r22 = getelementptr i64, i64* %r1, i32 2
%r23 = trunc i256 %r20 to i64
%r25 = getelementptr i64, i64* %r22, i32 0
store i64 %r23, i64* %r25
%r26 = lshr i256 %r20, 64
%r27 = trunc i256 %r26 to i64
%r29 = getelementptr i64, i64* %r22, i32 1
store i64 %r27, i64* %r29
%r30 = lshr i256 %r26, 64
%r31 = trunc i256 %r30 to i64
%r33 = getelementptr i64, i64* %r22, i32 2
store i64 %r31, i64* %r33
%r34 = lshr i256 %r30, 64
%r35 = trunc i256 %r34 to i64
%r37 = getelementptr i64, i64* %r22, i32 3
store i64 %r35, i64* %r37
ret void
}
define void @mcl_fp_mont3L(i64* %r1, i64* %r2, i64* %r3, i64* %r4)
{
%r6 = getelementptr i64, i64* %r4, i32 -1
%r7 = load i64, i64* %r6
%r9 = getelementptr i64, i64* %r3, i32 0
%r10 = load i64, i64* %r9
%r11 = call i256 @mulPv192x64(i64* %r2, i64 %r10)
%r12 = zext i256 %r11 to i320
%r13 = trunc i256 %r11 to i64
%r14 = mul i64 %r13, %r7
%r15 = call i256 @mulPv192x64(i64* %r4, i64 %r14)
%r16 = zext i256 %r15 to i320
%r17 = add i320 %r12, %r16
%r18 = lshr i320 %r17, 64
%r20 = getelementptr i64, i64* %r3, i32 1
%r21 = load i64, i64* %r20
%r22 = call i256 @mulPv192x64(i64* %r2, i64 %r21)
%r23 = zext i256 %r22 to i320
%r24 = add i320 %r18, %r23
%r25 = trunc i320 %r24 to i64
%r26 = mul i64 %r25, %r7
%r27 = call i256 @mulPv192x64(i64* %r4, i64 %r26)
%r28 = zext i256 %r27 to i320
%r29 = add i320 %r24, %r28
%r30 = lshr i320 %r29, 64
%r32 = getelementptr i64, i64* %r3, i32 2
%r33 = load i64, i64* %r32
%r34 = call i256 @mulPv192x64(i64* %r2, i64 %r33)
%r35 = zext i256 %r34 to i320
%r36 = add i320 %r30, %r35
%r37 = trunc i320 %r36 to i64
%r38 = mul i64 %r37, %r7
%r39 = call i256 @mulPv192x64(i64* %r4, i64 %r38)
%r40 = zext i256 %r39 to i320
%r41 = add i320 %r36, %r40
%r42 = lshr i320 %r41, 64
%r43 = trunc i320 %r42 to i256
%r44 = load i64, i64* %r4
%r45 = zext i64 %r44 to i128
%r47 = getelementptr i64, i64* %r4, i32 1
%r48 = load i64, i64* %r47
%r49 = zext i64 %r48 to i128
%r50 = shl i128 %r49, 64
%r51 = or i128 %r45, %r50
%r52 = zext i128 %r51 to i192
%r54 = getelementptr i64, i64* %r4, i32 2
%r55 = load i64, i64* %r54
%r56 = zext i64 %r55 to i192
%r57 = shl i192 %r56, 128
%r58 = or i192 %r52, %r57
%r59 = zext i192 %r58 to i256
%r60 = sub i256 %r43, %r59
%r61 = lshr i256 %r60, 192
%r62 = trunc i256 %r61 to i1
%r63 = select i1 %r62, i256 %r43, i256 %r60
%r64 = trunc i256 %r63 to i192
%r65 = trunc i192 %r64 to i64
%r67 = getelementptr i64, i64* %r1, i32 0
store i64 %r65, i64* %r67
%r68 = lshr i192 %r64, 64
%r69 = trunc i192 %r68 to i64
%r71 = getelementptr i64, i64* %r1, i32 1
store i64 %r69, i64* %r71
%r72 = lshr i192 %r68, 64
%r73 = trunc i192 %r72 to i64
%r75 = getelementptr i64, i64* %r1, i32 2
store i64 %r73, i64* %r75
ret void
}
define void @mcl_fp_montNF3L(i64* %r1, i64* %r2, i64* %r3, i64* %r4)
{
%r6 = getelementptr i64, i64* %r4, i32 -1
%r7 = load i64, i64* %r6
%r8 = load i64, i64* %r3
%r9 = call i256 @mulPv192x64(i64* %r2, i64 %r8)
%r10 = trunc i256 %r9 to i64
%r11 = mul i64 %r10, %r7
%r12 = call i256 @mulPv192x64(i64* %r4, i64 %r11)
%r13 = add i256 %r9, %r12
%r14 = lshr i256 %r13, 64
%r16 = getelementptr i64, i64* %r3, i32 1
%r17 = load i64, i64* %r16
%r18 = call i256 @mulPv192x64(i64* %r2, i64 %r17)
%r19 = add i256 %r14, %r18
%r20 = trunc i256 %r19 to i64
%r21 = mul i64 %r20, %r7
%r22 = call i256 @mulPv192x64(i64* %r4, i64 %r21)
%r23 = add i256 %r19, %r22
%r24 = lshr i256 %r23, 64
%r26 = getelementptr i64, i64* %r3, i32 2
%r27 = load i64, i64* %r26
%r28 = call i256 @mulPv192x64(i64* %r2, i64 %r27)
%r29 = add i256 %r24, %r28
%r30 = trunc i256 %r29 to i64
%r31 = mul i64 %r30, %r7
%r32 = call i256 @mulPv192x64(i64* %r4, i64 %r31)
%r33 = add i256 %r29, %r32
%r34 = lshr i256 %r33, 64
%r35 = trunc i256 %r34 to i192
%r36 = load i64, i64* %r4
%r37 = zext i64 %r36 to i128
%r39 = getelementptr i64, i64* %r4, i32 1
%r40 = load i64, i64* %r39
%r41 = zext i64 %r40 to i128
%r42 = shl i128 %r41, 64
%r43 = or i128 %r37, %r42
%r44 = zext i128 %r43 to i192
%r46 = getelementptr i64, i64* %r4, i32 2
%r47 = load i64, i64* %r46
%r48 = zext i64 %r47 to i192
%r49 = shl i192 %r48, 128
%r50 = or i192 %r44, %r49
%r51 = sub i192 %r35, %r50
%r52 = lshr i192 %r51, 191
%r53 = trunc i192 %r52 to i1
%r54 = select i1 %r53, i192 %r35, i192 %r51
%r55 = trunc i192 %r54 to i64
%r57 = getelementptr i64, i64* %r1, i32 0
store i64 %r55, i64* %r57
%r58 = lshr i192 %r54, 64
%r59 = trunc i192 %r58 to i64
%r61 = getelementptr i64, i64* %r1, i32 1
store i64 %r59, i64* %r61
%r62 = lshr i192 %r58, 64
%r63 = trunc i192 %r62 to i64
%r65 = getelementptr i64, i64* %r1, i32 2
store i64 %r63, i64* %r65
ret void
}
define void @mcl_fp_montRed3L(i64* noalias  %r1, i64* noalias  %r2, i64* noalias  %r3)
{
%r5 = getelementptr i64, i64* %r3, i32 -1
%r6 = load i64, i64* %r5
%r7 = load i64, i64* %r3
%r8 = zext i64 %r7 to i128
%r10 = getelementptr i64, i64* %r3, i32 1
%r11 = load i64, i64* %r10
%r12 = zext i64 %r11 to i128
%r13 = shl i128 %r12, 64
%r14 = or i128 %r8, %r13
%r15 = zext i128 %r14 to i192
%r17 = getelementptr i64, i64* %r3, i32 2
%r18 = load i64, i64* %r17
%r19 = zext i64 %r18 to i192
%r20 = shl i192 %r19, 128
%r21 = or i192 %r15, %r20
%r22 = load i64, i64* %r2
%r23 = zext i64 %r22 to i128
%r25 = getelementptr i64, i64* %r2, i32 1
%r26 = load i64, i64* %r25
%r27 = zext i64 %r26 to i128
%r28 = shl i128 %r27, 64
%r29 = or i128 %r23, %r28
%r30 = zext i128 %r29 to i192
%r32 = getelementptr i64, i64* %r2, i32 2
%r33 = load i64, i64* %r32
%r34 = zext i64 %r33 to i192
%r35 = shl i192 %r34, 128
%r36 = or i192 %r30, %r35
%r37 = zext i192 %r36 to i256
%r39 = getelementptr i64, i64* %r2, i32 3
%r40 = load i64, i64* %r39
%r41 = zext i64 %r40 to i256
%r42 = shl i256 %r41, 192
%r43 = or i256 %r37, %r42
%r44 = zext i256 %r43 to i320
%r46 = getelementptr i64, i64* %r2, i32 4
%r47 = load i64, i64* %r46
%r48 = zext i64 %r47 to i320
%r49 = shl i320 %r48, 256
%r50 = or i320 %r44, %r49
%r51 = zext i320 %r50 to i384
%r53 = getelementptr i64, i64* %r2, i32 5
%r54 = load i64, i64* %r53
%r55 = zext i64 %r54 to i384
%r56 = shl i384 %r55, 320
%r57 = or i384 %r51, %r56
%r58 = zext i384 %r57 to i448
%r59 = trunc i448 %r58 to i64
%r60 = mul i64 %r59, %r6
%r61 = call i256 @mulPv192x64(i64* %r3, i64 %r60)
%r62 = zext i256 %r61 to i448
%r63 = add i448 %r58, %r62
%r64 = lshr i448 %r63, 64
%r65 = trunc i448 %r64 to i384
%r66 = trunc i384 %r65 to i64
%r67 = mul i64 %r66, %r6
%r68 = call i256 @mulPv192x64(i64* %r3, i64 %r67)
%r69 = zext i256 %r68 to i384
%r70 = add i384 %r65, %r69
%r71 = lshr i384 %r70, 64
%r72 = trunc i384 %r71 to i320
%r73 = trunc i320 %r72 to i64
%r74 = mul i64 %r73, %r6
%r75 = call i256 @mulPv192x64(i64* %r3, i64 %r74)
%r76 = zext i256 %r75 to i320
%r77 = add i320 %r72, %r76
%r78 = lshr i320 %r77, 64
%r79 = trunc i320 %r78 to i256
%r80 = zext i192 %r21 to i256
%r81 = sub i256 %r79, %r80
%r82 = lshr i256 %r81, 192
%r83 = trunc i256 %r82 to i1
%r84 = select i1 %r83, i256 %r79, i256 %r81
%r85 = trunc i256 %r84 to i192
%r86 = trunc i192 %r85 to i64
%r88 = getelementptr i64, i64* %r1, i32 0
store i64 %r86, i64* %r88
%r89 = lshr i192 %r85, 64
%r90 = trunc i192 %r89 to i64
%r92 = getelementptr i64, i64* %r1, i32 1
store i64 %r90, i64* %r92
%r93 = lshr i192 %r89, 64
%r94 = trunc i192 %r93 to i64
%r96 = getelementptr i64, i64* %r1, i32 2
store i64 %r94, i64* %r96
ret void
}
define i64 @mcl_fp_addPre3L(i64* noalias  %r2, i64* noalias  %r3, i64* noalias  %r4)
{
%r5 = load i64, i64* %r3
%r6 = zext i64 %r5 to i128
%r8 = getelementptr i64, i64* %r3, i32 1
%r9 = load i64, i64* %r8
%r10 = zext i64 %r9 to i128
%r11 = shl i128 %r10, 64
%r12 = or i128 %r6, %r11
%r13 = zext i128 %r12 to i192
%r15 = getelementptr i64, i64* %r3, i32 2
%r16 = load i64, i64* %r15
%r17 = zext i64 %r16 to i192
%r18 = shl i192 %r17, 128
%r19 = or i192 %r13, %r18
%r20 = zext i192 %r19 to i256
%r21 = load i64, i64* %r4
%r22 = zext i64 %r21 to i128
%r24 = getelementptr i64, i64* %r4, i32 1
%r25 = load i64, i64* %r24
%r26 = zext i64 %r25 to i128
%r27 = shl i128 %r26, 64
%r28 = or i128 %r22, %r27
%r29 = zext i128 %r28 to i192
%r31 = getelementptr i64, i64* %r4, i32 2
%r32 = load i64, i64* %r31
%r33 = zext i64 %r32 to i192
%r34 = shl i192 %r33, 128
%r35 = or i192 %r29, %r34
%r36 = zext i192 %r35 to i256
%r37 = add i256 %r20, %r36
%r38 = trunc i256 %r37 to i192
%r39 = trunc i192 %r38 to i64
%r41 = getelementptr i64, i64* %r2, i32 0
store i64 %r39, i64* %r41
%r42 = lshr i192 %r38, 64
%r43 = trunc i192 %r42 to i64
%r45 = getelementptr i64, i64* %r2, i32 1
store i64 %r43, i64* %r45
%r46 = lshr i192 %r42, 64
%r47 = trunc i192 %r46 to i64
%r49 = getelementptr i64, i64* %r2, i32 2
store i64 %r47, i64* %r49
%r50 = lshr i256 %r37, 192
%r51 = trunc i256 %r50 to i64
ret i64 %r51
}
define i64 @mcl_fp_subPre3L(i64* noalias  %r2, i64* noalias  %r3, i64* noalias  %r4)
{
%r5 = load i64, i64* %r3
%r6 = zext i64 %r5 to i128
%r8 = getelementptr i64, i64* %r3, i32 1
%r9 = load i64, i64* %r8
%r10 = zext i64 %r9 to i128
%r11 = shl i128 %r10, 64
%r12 = or i128 %r6, %r11
%r13 = zext i128 %r12 to i192
%r15 = getelementptr i64, i64* %r3, i32 2
%r16 = load i64, i64* %r15
%r17 = zext i64 %r16 to i192
%r18 = shl i192 %r17, 128
%r19 = or i192 %r13, %r18
%r20 = zext i192 %r19 to i256
%r21 = load i64, i64* %r4
%r22 = zext i64 %r21 to i128
%r24 = getelementptr i64, i64* %r4, i32 1
%r25 = load i64, i64* %r24
%r26 = zext i64 %r25 to i128
%r27 = shl i128 %r26, 64
%r28 = or i128 %r22, %r27
%r29 = zext i128 %r28 to i192
%r31 = getelementptr i64, i64* %r4, i32 2
%r32 = load i64, i64* %r31
%r33 = zext i64 %r32 to i192
%r34 = shl i192 %r33, 128
%r35 = or i192 %r29, %r34
%r36 = zext i192 %r35 to i256
%r37 = sub i256 %r20, %r36
%r38 = trunc i256 %r37 to i192
%r39 = trunc i192 %r38 to i64
%r41 = getelementptr i64, i64* %r2, i32 0
store i64 %r39, i64* %r41
%r42 = lshr i192 %r38, 64
%r43 = trunc i192 %r42 to i64
%r45 = getelementptr i64, i64* %r2, i32 1
store i64 %r43, i64* %r45
%r46 = lshr i192 %r42, 64
%r47 = trunc i192 %r46 to i64
%r49 = getelementptr i64, i64* %r2, i32 2
store i64 %r47, i64* %r49
%r50 = lshr i256 %r37, 192
%r51 = trunc i256 %r50 to i64
%r53 = and i64 %r51, 1
ret i64 %r53
}
define void @mcl_fp_shr1_3L(i64* noalias  %r1, i64* noalias  %r2)
{
%r3 = load i64, i64* %r2
%r4 = zext i64 %r3 to i128
%r6 = getelementptr i64, i64* %r2, i32 1
%r7 = load i64, i64* %r6
%r8 = zext i64 %r7 to i128
%r9 = shl i128 %r8, 64
%r10 = or i128 %r4, %r9
%r11 = zext i128 %r10 to i192
%r13 = getelementptr i64, i64* %r2, i32 2
%r14 = load i64, i64* %r13
%r15 = zext i64 %r14 to i192
%r16 = shl i192 %r15, 128
%r17 = or i192 %r11, %r16
%r18 = lshr i192 %r17, 1
%r19 = trunc i192 %r18 to i64
%r21 = getelementptr i64, i64* %r1, i32 0
store i64 %r19, i64* %r21
%r22 = lshr i192 %r18, 64
%r23 = trunc i192 %r22 to i64
%r25 = getelementptr i64, i64* %r1, i32 1
store i64 %r23, i64* %r25
%r26 = lshr i192 %r22, 64
%r27 = trunc i192 %r26 to i64
%r29 = getelementptr i64, i64* %r1, i32 2
store i64 %r27, i64* %r29
ret void
}
define void @mcl_fp_add3L(i64* noalias  %r1, i64* noalias  %r2, i64* noalias  %r3, i64* noalias  %r4)
{
%r5 = load i64, i64* %r2
%r6 = zext i64 %r5 to i128
%r8 = getelementptr i64, i64* %r2, i32 1
%r9 = load i64, i64* %r8
%r10 = zext i64 %r9 to i128
%r11 = shl i128 %r10, 64
%r12 = or i128 %r6, %r11
%r13 = zext i128 %r12 to i192
%r15 = getelementptr i64, i64* %r2, i32 2
%r16 = load i64, i64* %r15
%r17 = zext i64 %r16 to i192
%r18 = shl i192 %r17, 128
%r19 = or i192 %r13, %r18
%r20 = load i64, i64* %r3
%r21 = zext i64 %r20 to i128
%r23 = getelementptr i64, i64* %r3, i32 1
%r24 = load i64, i64* %r23
%r25 = zext i64 %r24 to i128
%r26 = shl i128 %r25, 64
%r27 = or i128 %r21, %r26
%r28 = zext i128 %r27 to i192
%r30 = getelementptr i64, i64* %r3, i32 2
%r31 = load i64, i64* %r30
%r32 = zext i64 %r31 to i192
%r33 = shl i192 %r32, 128
%r34 = or i192 %r28, %r33
%r35 = zext i192 %r19 to i256
%r36 = zext i192 %r34 to i256
%r37 = add i256 %r35, %r36
%r38 = trunc i256 %r37 to i192
%r39 = trunc i192 %r38 to i64
%r41 = getelementptr i64, i64* %r1, i32 0
store i64 %r39, i64* %r41
%r42 = lshr i192 %r38, 64
%r43 = trunc i192 %r42 to i64
%r45 = getelementptr i64, i64* %r1, i32 1
store i64 %r43, i64* %r45
%r46 = lshr i192 %r42, 64
%r47 = trunc i192 %r46 to i64
%r49 = getelementptr i64, i64* %r1, i32 2
store i64 %r47, i64* %r49
%r50 = load i64, i64* %r4
%r51 = zext i64 %r50 to i128
%r53 = getelementptr i64, i64* %r4, i32 1
%r54 = load i64, i64* %r53
%r55 = zext i64 %r54 to i128
%r56 = shl i128 %r55, 64
%r57 = or i128 %r51, %r56
%r58 = zext i128 %r57 to i192
%r60 = getelementptr i64, i64* %r4, i32 2
%r61 = load i64, i64* %r60
%r62 = zext i64 %r61 to i192
%r63 = shl i192 %r62, 128
%r64 = or i192 %r58, %r63
%r65 = zext i192 %r64 to i256
%r66 = sub i256 %r37, %r65
%r67 = lshr i256 %r66, 192
%r68 = trunc i256 %r67 to i1
br i1%r68, label %carry, label %nocarry
nocarry:
%r69 = trunc i256 %r66 to i192
%r70 = trunc i192 %r69 to i64
%r72 = getelementptr i64, i64* %r1, i32 0
store i64 %r70, i64* %r72
%r73 = lshr i192 %r69, 64
%r74 = trunc i192 %r73 to i64
%r76 = getelementptr i64, i64* %r1, i32 1
store i64 %r74, i64* %r76
%r77 = lshr i192 %r73, 64
%r78 = trunc i192 %r77 to i64
%r80 = getelementptr i64, i64* %r1, i32 2
store i64 %r78, i64* %r80
ret void
carry:
ret void
}
define void @mcl_fp_addNF3L(i64* noalias  %r1, i64* noalias  %r2, i64* noalias  %r3, i64* noalias  %r4)
{
%r5 = load i64, i64* %r2
%r6 = zext i64 %r5 to i128
%r8 = getelementptr i64, i64* %r2, i32 1
%r9 = load i64, i64* %r8
%r10 = zext i64 %r9 to i128
%r11 = shl i128 %r10, 64
%r12 = or i128 %r6, %r11
%r13 = zext i128 %r12 to i192
%r15 = getelementptr i64, i64* %r2, i32 2
%r16 = load i64, i64* %r15
%r17 = zext i64 %r16 to i192
%r18 = shl i192 %r17, 128
%r19 = or i192 %r13, %r18
%r20 = load i64, i64* %r3
%r21 = zext i64 %r20 to i128
%r23 = getelementptr i64, i64* %r3, i32 1
%r24 = load i64, i64* %r23
%r25 = zext i64 %r24 to i128
%r26 = shl i128 %r25, 64
%r27 = or i128 %r21, %r26
%r28 = zext i128 %r27 to i192
%r30 = getelementptr i64, i64* %r3, i32 2
%r31 = load i64, i64* %r30
%r32 = zext i64 %r31 to i192
%r33 = shl i192 %r32, 128
%r34 = or i192 %r28, %r33
%r35 = add i192 %r19, %r34
%r36 = load i64, i64* %r4
%r37 = zext i64 %r36 to i128
%r39 = getelementptr i64, i64* %r4, i32 1
%r40 = load i64, i64* %r39
%r41 = zext i64 %r40 to i128
%r42 = shl i128 %r41, 64
%r43 = or i128 %r37, %r42
%r44 = zext i128 %r43 to i192
%r46 = getelementptr i64, i64* %r4, i32 2
%r47 = load i64, i64* %r46
%r48 = zext i64 %r47 to i192
%r49 = shl i192 %r48, 128
%r50 = or i192 %r44, %r49
%r51 = sub i192 %r35, %r50
%r52 = lshr i192 %r51, 191
%r53 = trunc i192 %r52 to i1
%r54 = select i1 %r53, i192 %r35, i192 %r51
%r55 = trunc i192 %r54 to i64
%r57 = getelementptr i64, i64* %r1, i32 0
store i64 %r55, i64* %r57
%r58 = lshr i192 %r54, 64
%r59 = trunc i192 %r58 to i64
%r61 = getelementptr i64, i64* %r1, i32 1
store i64 %r59, i64* %r61
%r62 = lshr i192 %r58, 64
%r63 = trunc i192 %r62 to i64
%r65 = getelementptr i64, i64* %r1, i32 2
store i64 %r63, i64* %r65
ret void
}
define void @mcl_fp_sub3L(i64* noalias  %r1, i64* noalias  %r2, i64* noalias  %r3, i64* noalias  %r4)
{
%r5 = load i64, i64* %r2
%r6 = zext i64 %r5 to i128
%r8 = getelementptr i64, i64* %r2, i32 1
%r9 = load i64, i64* %r8
%r10 = zext i64 %r9 to i128
%r11 = shl i128 %r10, 64
%r12 = or i128 %r6, %r11
%r13 = zext i128 %r12 to i192
%r15 = getelementptr i64, i64* %r2, i32 2
%r16 = load i64, i64* %r15
%r17 = zext i64 %r16 to i192
%r18 = shl i192 %r17, 128
%r19 = or i192 %r13, %r18
%r20 = load i64, i64* %r3
%r21 = zext i64 %r20 to i128
%r23 = getelementptr i64, i64* %r3, i32 1
%r24 = load i64, i64* %r23
%r25 = zext i64 %r24 to i128
%r26 = shl i128 %r25, 64
%r27 = or i128 %r21, %r26
%r28 = zext i128 %r27 to i192
%r30 = getelementptr i64, i64* %r3, i32 2
%r31 = load i64, i64* %r30
%r32 = zext i64 %r31 to i192
%r33 = shl i192 %r32, 128
%r34 = or i192 %r28, %r33
%r35 = zext i192 %r19 to i256
%r36 = zext i192 %r34 to i256
%r37 = sub i256 %r35, %r36
%r38 = trunc i256 %r37 to i192
%r39 = lshr i256 %r37, 192
%r40 = trunc i256 %r39 to i1
%r41 = trunc i192 %r38 to i64
%r43 = getelementptr i64, i64* %r1, i32 0
store i64 %r41, i64* %r43
%r44 = lshr i192 %r38, 64
%r45 = trunc i192 %r44 to i64
%r47 = getelementptr i64, i64* %r1, i32 1
store i64 %r45, i64* %r47
%r48 = lshr i192 %r44, 64
%r49 = trunc i192 %r48 to i64
%r51 = getelementptr i64, i64* %r1, i32 2
store i64 %r49, i64* %r51
br i1%r40, label %carry, label %nocarry
nocarry:
ret void
carry:
%r52 = load i64, i64* %r4
%r53 = zext i64 %r52 to i128
%r55 = getelementptr i64, i64* %r4, i32 1
%r56 = load i64, i64* %r55
%r57 = zext i64 %r56 to i128
%r58 = shl i128 %r57, 64
%r59 = or i128 %r53, %r58
%r60 = zext i128 %r59 to i192
%r62 = getelementptr i64, i64* %r4, i32 2
%r63 = load i64, i64* %r62
%r64 = zext i64 %r63 to i192
%r65 = shl i192 %r64, 128
%r66 = or i192 %r60, %r65
%r67 = add i192 %r38, %r66
%r68 = trunc i192 %r67 to i64
%r70 = getelementptr i64, i64* %r1, i32 0
store i64 %r68, i64* %r70
%r71 = lshr i192 %r67, 64
%r72 = trunc i192 %r71 to i64
%r74 = getelementptr i64, i64* %r1, i32 1
store i64 %r72, i64* %r74
%r75 = lshr i192 %r71, 64
%r76 = trunc i192 %r75 to i64
%r78 = getelementptr i64, i64* %r1, i32 2
store i64 %r76, i64* %r78
ret void
}
define void @mcl_fp_subNF3L(i64* noalias  %r1, i64* noalias  %r2, i64* noalias  %r3, i64* noalias  %r4)
{
%r5 = load i64, i64* %r2
%r6 = zext i64 %r5 to i128
%r8 = getelementptr i64, i64* %r2, i32 1
%r9 = load i64, i64* %r8
%r10 = zext i64 %r9 to i128
%r11 = shl i128 %r10, 64
%r12 = or i128 %r6, %r11
%r13 = zext i128 %r12 to i192
%r15 = getelementptr i64, i64* %r2, i32 2
%r16 = load i64, i64* %r15
%r17 = zext i64 %r16 to i192
%r18 = shl i192 %r17, 128
%r19 = or i192 %r13, %r18
%r20 = load i64, i64* %r3
%r21 = zext i64 %r20 to i128
%r23 = getelementptr i64, i64* %r3, i32 1
%r24 = load i64, i64* %r23
%r25 = zext i64 %r24 to i128
%r26 = shl i128 %r25, 64
%r27 = or i128 %r21, %r26
%r28 = zext i128 %r27 to i192
%r30 = getelementptr i64, i64* %r3, i32 2
%r31 = load i64, i64* %r30
%r32 = zext i64 %r31 to i192
%r33 = shl i192 %r32, 128
%r34 = or i192 %r28, %r33
%r35 = sub i192 %r19, %r34
%r36 = lshr i192 %r35, 191
%r37 = trunc i192 %r36 to i1
%r38 = load i64, i64* %r4
%r39 = zext i64 %r38 to i128
%r41 = getelementptr i64, i64* %r4, i32 1
%r42 = load i64, i64* %r41
%r43 = zext i64 %r42 to i128
%r44 = shl i128 %r43, 64
%r45 = or i128 %r39, %r44
%r46 = zext i128 %r45 to i192
%r48 = getelementptr i64, i64* %r4, i32 2
%r49 = load i64, i64* %r48
%r50 = zext i64 %r49 to i192
%r51 = shl i192 %r50, 128
%r52 = or i192 %r46, %r51
%r54 = select i1 %r37, i192 %r52, i192 0
%r55 = add i192 %r35, %r54
%r56 = trunc i192 %r55 to i64
%r58 = getelementptr i64, i64* %r1, i32 0
store i64 %r56, i64* %r58
%r59 = lshr i192 %r55, 64
%r60 = trunc i192 %r59 to i64
%r62 = getelementptr i64, i64* %r1, i32 1
store i64 %r60, i64* %r62
%r63 = lshr i192 %r59, 64
%r64 = trunc i192 %r63 to i64
%r66 = getelementptr i64, i64* %r1, i32 2
store i64 %r64, i64* %r66
ret void
}
define void @mcl_fpDbl_add3L(i64* noalias  %r1, i64* noalias  %r2, i64* noalias  %r3, i64* noalias  %r4)
{
%r5 = load i64, i64* %r2
%r6 = zext i64 %r5 to i128
%r8 = getelementptr i64, i64* %r2, i32 1
%r9 = load i64, i64* %r8
%r10 = zext i64 %r9 to i128
%r11 = shl i128 %r10, 64
%r12 = or i128 %r6, %r11
%r13 = zext i128 %r12 to i192
%r15 = getelementptr i64, i64* %r2, i32 2
%r16 = load i64, i64* %r15
%r17 = zext i64 %r16 to i192
%r18 = shl i192 %r17, 128
%r19 = or i192 %r13, %r18
%r20 = zext i192 %r19 to i256
%r22 = getelementptr i64, i64* %r2, i32 3
%r23 = load i64, i64* %r22
%r24 = zext i64 %r23 to i256
%r25 = shl i256 %r24, 192
%r26 = or i256 %r20, %r25
%r27 = zext i256 %r26 to i320
%r29 = getelementptr i64, i64* %r2, i32 4
%r30 = load i64, i64* %r29
%r31 = zext i64 %r30 to i320
%r32 = shl i320 %r31, 256
%r33 = or i320 %r27, %r32
%r34 = zext i320 %r33 to i384
%r36 = getelementptr i64, i64* %r2, i32 5
%r37 = load i64, i64* %r36
%r38 = zext i64 %r37 to i384
%r39 = shl i384 %r38, 320
%r40 = or i384 %r34, %r39
%r41 = load i64, i64* %r3
%r42 = zext i64 %r41 to i128
%r44 = getelementptr i64, i64* %r3, i32 1
%r45 = load i64, i64* %r44
%r46 = zext i64 %r45 to i128
%r47 = shl i128 %r46, 64
%r48 = or i128 %r42, %r47
%r49 = zext i128 %r48 to i192
%r51 = getelementptr i64, i64* %r3, i32 2
%r52 = load i64, i64* %r51
%r53 = zext i64 %r52 to i192
%r54 = shl i192 %r53, 128
%r55 = or i192 %r49, %r54
%r56 = zext i192 %r55 to i256
%r58 = getelementptr i64, i64* %r3, i32 3
%r59 = load i64, i64* %r58
%r60 = zext i64 %r59 to i256
%r61 = shl i256 %r60, 192
%r62 = or i256 %r56, %r61
%r63 = zext i256 %r62 to i320
%r65 = getelementptr i64, i64* %r3, i32 4
%r66 = load i64, i64* %r65
%r67 = zext i64 %r66 to i320
%r68 = shl i320 %r67, 256
%r69 = or i320 %r63, %r68
%r70 = zext i320 %r69 to i384
%r72 = getelementptr i64, i64* %r3, i32 5
%r73 = load i64, i64* %r72
%r74 = zext i64 %r73 to i384
%r75 = shl i384 %r74, 320
%r76 = or i384 %r70, %r75
%r77 = zext i384 %r40 to i448
%r78 = zext i384 %r76 to i448
%r79 = add i448 %r77, %r78
%r80 = trunc i448 %r79 to i192
%r81 = trunc i192 %r80 to i64
%r83 = getelementptr i64, i64* %r1, i32 0
store i64 %r81, i64* %r83
%r84 = lshr i192 %r80, 64
%r85 = trunc i192 %r84 to i64
%r87 = getelementptr i64, i64* %r1, i32 1
store i64 %r85, i64* %r87
%r88 = lshr i192 %r84, 64
%r89 = trunc i192 %r88 to i64
%r91 = getelementptr i64, i64* %r1, i32 2
store i64 %r89, i64* %r91
%r92 = lshr i448 %r79, 192
%r93 = trunc i448 %r92 to i256
%r94 = load i64, i64* %r4
%r95 = zext i64 %r94 to i128
%r97 = getelementptr i64, i64* %r4, i32 1
%r98 = load i64, i64* %r97
%r99 = zext i64 %r98 to i128
%r100 = shl i128 %r99, 64
%r101 = or i128 %r95, %r100
%r102 = zext i128 %r101 to i192
%r104 = getelementptr i64, i64* %r4, i32 2
%r105 = load i64, i64* %r104
%r106 = zext i64 %r105 to i192
%r107 = shl i192 %r106, 128
%r108 = or i192 %r102, %r107
%r109 = zext i192 %r108 to i256
%r110 = sub i256 %r93, %r109
%r111 = lshr i256 %r110, 192
%r112 = trunc i256 %r111 to i1
%r113 = select i1 %r112, i256 %r93, i256 %r110
%r114 = trunc i256 %r113 to i192
%r116 = getelementptr i64, i64* %r1, i32 3
%r117 = trunc i192 %r114 to i64
%r119 = getelementptr i64, i64* %r116, i32 0
store i64 %r117, i64* %r119
%r120 = lshr i192 %r114, 64
%r121 = trunc i192 %r120 to i64
%r123 = getelementptr i64, i64* %r116, i32 1
store i64 %r121, i64* %r123
%r124 = lshr i192 %r120, 64
%r125 = trunc i192 %r124 to i64
%r127 = getelementptr i64, i64* %r116, i32 2
store i64 %r125, i64* %r127
ret void
}
define void @mcl_fpDbl_sub3L(i64* noalias  %r1, i64* noalias  %r2, i64* noalias  %r3, i64* noalias  %r4)
{
%r5 = load i64, i64* %r2
%r6 = zext i64 %r5 to i128
%r8 = getelementptr i64, i64* %r2, i32 1
%r9 = load i64, i64* %r8
%r10 = zext i64 %r9 to i128
%r11 = shl i128 %r10, 64
%r12 = or i128 %r6, %r11
%r13 = zext i128 %r12 to i192
%r15 = getelementptr i64, i64* %r2, i32 2
%r16 = load i64, i64* %r15
%r17 = zext i64 %r16 to i192
%r18 = shl i192 %r17, 128
%r19 = or i192 %r13, %r18
%r20 = zext i192 %r19 to i256
%r22 = getelementptr i64, i64* %r2, i32 3
%r23 = load i64, i64* %r22
%r24 = zext i64 %r23 to i256
%r25 = shl i256 %r24, 192
%r26 = or i256 %r20, %r25
%r27 = zext i256 %r26 to i320
%r29 = getelementptr i64, i64* %r2, i32 4
%r30 = load i64, i64* %r29
%r31 = zext i64 %r30 to i320
%r32 = shl i320 %r31, 256
%r33 = or i320 %r27, %r32
%r34 = zext i320 %r33 to i384
%r36 = getelementptr i64, i64* %r2, i32 5
%r37 = load i64, i64* %r36
%r38 = zext i64 %r37 to i384
%r39 = shl i384 %r38, 320
%r40 = or i384 %r34, %r39
%r41 = load i64, i64* %r3
%r42 = zext i64 %r41 to i128
%r44 = getelementptr i64, i64* %r3, i32 1
%r45 = load i64, i64* %r44
%r46 = zext i64 %r45 to i128
%r47 = shl i128 %r46, 64
%r48 = or i128 %r42, %r47
%r49 = zext i128 %r48 to i192
%r51 = getelementptr i64, i64* %r3, i32 2
%r52 = load i64, i64* %r51
%r53 = zext i64 %r52 to i192
%r54 = shl i192 %r53, 128
%r55 = or i192 %r49, %r54
%r56 = zext i192 %r55 to i256
%r58 = getelementptr i64, i64* %r3, i32 3
%r59 = load i64, i64* %r58
%r60 = zext i64 %r59 to i256
%r61 = shl i256 %r60, 192
%r62 = or i256 %r56, %r61
%r63 = zext i256 %r62 to i320
%r65 = getelementptr i64, i64* %r3, i32 4
%r66 = load i64, i64* %r65
%r67 = zext i64 %r66 to i320
%r68 = shl i320 %r67, 256
%r69 = or i320 %r63, %r68
%r70 = zext i320 %r69 to i384
%r72 = getelementptr i64, i64* %r3, i32 5
%r73 = load i64, i64* %r72
%r74 = zext i64 %r73 to i384
%r75 = shl i384 %r74, 320
%r76 = or i384 %r70, %r75
%r77 = zext i384 %r40 to i448
%r78 = zext i384 %r76 to i448
%r79 = sub i448 %r77, %r78
%r80 = trunc i448 %r79 to i192
%r81 = trunc i192 %r80 to i64
%r83 = getelementptr i64, i64* %r1, i32 0
store i64 %r81, i64* %r83
%r84 = lshr i192 %r80, 64
%r85 = trunc i192 %r84 to i64
%r87 = getelementptr i64, i64* %r1, i32 1
store i64 %r85, i64* %r87
%r88 = lshr i192 %r84, 64
%r89 = trunc i192 %r88 to i64
%r91 = getelementptr i64, i64* %r1, i32 2
store i64 %r89, i64* %r91
%r92 = lshr i448 %r79, 192
%r93 = trunc i448 %r92 to i192
%r94 = lshr i448 %r79, 384
%r95 = trunc i448 %r94 to i1
%r96 = load i64, i64* %r4
%r97 = zext i64 %r96 to i128
%r99 = getelementptr i64, i64* %r4, i32 1
%r100 = load i64, i64* %r99
%r101 = zext i64 %r100 to i128
%r102 = shl i128 %r101, 64
%r103 = or i128 %r97, %r102
%r104 = zext i128 %r103 to i192
%r106 = getelementptr i64, i64* %r4, i32 2
%r107 = load i64, i64* %r106
%r108 = zext i64 %r107 to i192
%r109 = shl i192 %r108, 128
%r110 = or i192 %r104, %r109
%r112 = select i1 %r95, i192 %r110, i192 0
%r113 = add i192 %r93, %r112
%r115 = getelementptr i64, i64* %r1, i32 3
%r116 = trunc i192 %r113 to i64
%r118 = getelementptr i64, i64* %r115, i32 0
store i64 %r116, i64* %r118
%r119 = lshr i192 %r113, 64
%r120 = trunc i192 %r119 to i64
%r122 = getelementptr i64, i64* %r115, i32 1
store i64 %r120, i64* %r122
%r123 = lshr i192 %r119, 64
%r124 = trunc i192 %r123 to i64
%r126 = getelementptr i64, i64* %r115, i32 2
store i64 %r124, i64* %r126
ret void
}
define i320 @mulPv256x64(i64* noalias  %r2, i64 %r3)
{
%r5 = call i128 @mulPos64x64(i64* %r2, i64 %r3, i64 0)
%r6 = trunc i128 %r5 to i64
%r7 = call i64 @extractHigh64(i128 %r5)
%r9 = call i128 @mulPos64x64(i64* %r2, i64 %r3, i64 1)
%r10 = trunc i128 %r9 to i64
%r11 = call i64 @extractHigh64(i128 %r9)
%r13 = call i128 @mulPos64x64(i64* %r2, i64 %r3, i64 2)
%r14 = trunc i128 %r13 to i64
%r15 = call i64 @extractHigh64(i128 %r13)
%r17 = call i128 @mulPos64x64(i64* %r2, i64 %r3, i64 3)
%r18 = trunc i128 %r17 to i64
%r19 = call i64 @extractHigh64(i128 %r17)
%r20 = zext i64 %r6 to i128
%r21 = zext i64 %r10 to i128
%r22 = shl i128 %r21, 64
%r23 = or i128 %r20, %r22
%r24 = zext i128 %r23 to i192
%r25 = zext i64 %r14 to i192
%r26 = shl i192 %r25, 128
%r27 = or i192 %r24, %r26
%r28 = zext i192 %r27 to i256
%r29 = zext i64 %r18 to i256
%r30 = shl i256 %r29, 192
%r31 = or i256 %r28, %r30
%r32 = zext i64 %r7 to i128
%r33 = zext i64 %r11 to i128
%r34 = shl i128 %r33, 64
%r35 = or i128 %r32, %r34
%r36 = zext i128 %r35 to i192
%r37 = zext i64 %r15 to i192
%r38 = shl i192 %r37, 128
%r39 = or i192 %r36, %r38
%r40 = zext i192 %r39 to i256
%r41 = zext i64 %r19 to i256
%r42 = shl i256 %r41, 192
%r43 = or i256 %r40, %r42
%r44 = zext i256 %r31 to i320
%r45 = zext i256 %r43 to i320
%r46 = shl i320 %r45, 64
%r47 = add i320 %r44, %r46
ret i320 %r47
}
define void @mcl_fp_mulUnitPre4L(i64* noalias  %r1, i64* noalias  %r2, i64 %r3)
{
%r4 = call i320 @mulPv256x64(i64* %r2, i64 %r3)
%r5 = trunc i320 %r4 to i64
%r7 = getelementptr i64, i64* %r1, i32 0
store i64 %r5, i64* %r7
%r8 = lshr i320 %r4, 64
%r9 = trunc i320 %r8 to i64
%r11 = getelementptr i64, i64* %r1, i32 1
store i64 %r9, i64* %r11
%r12 = lshr i320 %r8, 64
%r13 = trunc i320 %r12 to i64
%r15 = getelementptr i64, i64* %r1, i32 2
store i64 %r13, i64* %r15
%r16 = lshr i320 %r12, 64
%r17 = trunc i320 %r16 to i64
%r19 = getelementptr i64, i64* %r1, i32 3
store i64 %r17, i64* %r19
%r20 = lshr i320 %r16, 64
%r21 = trunc i320 %r20 to i64
%r23 = getelementptr i64, i64* %r1, i32 4
store i64 %r21, i64* %r23
ret void
}
define void @mcl_fpDbl_mulPre4L(i64* noalias  %r1, i64* noalias  %r2, i64* noalias  %r3)
{
%r4 = load i64, i64* %r3
%r5 = call i320 @mulPv256x64(i64* %r2, i64 %r4)
%r6 = trunc i320 %r5 to i64
store i64 %r6, i64* %r1
%r7 = lshr i320 %r5, 64
%r9 = getelementptr i64, i64* %r3, i32 1
%r10 = load i64, i64* %r9
%r11 = call i320 @mulPv256x64(i64* %r2, i64 %r10)
%r12 = add i320 %r7, %r11
%r13 = trunc i320 %r12 to i64
%r15 = getelementptr i64, i64* %r1, i32 1
store i64 %r13, i64* %r15
%r16 = lshr i320 %r12, 64
%r18 = getelementptr i64, i64* %r3, i32 2
%r19 = load i64, i64* %r18
%r20 = call i320 @mulPv256x64(i64* %r2, i64 %r19)
%r21 = add i320 %r16, %r20
%r22 = trunc i320 %r21 to i64
%r24 = getelementptr i64, i64* %r1, i32 2
store i64 %r22, i64* %r24
%r25 = lshr i320 %r21, 64
%r27 = getelementptr i64, i64* %r3, i32 3
%r28 = load i64, i64* %r27
%r29 = call i320 @mulPv256x64(i64* %r2, i64 %r28)
%r30 = add i320 %r25, %r29
%r32 = getelementptr i64, i64* %r1, i32 3
%r33 = trunc i320 %r30 to i64
%r35 = getelementptr i64, i64* %r32, i32 0
store i64 %r33, i64* %r35
%r36 = lshr i320 %r30, 64
%r37 = trunc i320 %r36 to i64
%r39 = getelementptr i64, i64* %r32, i32 1
store i64 %r37, i64* %r39
%r40 = lshr i320 %r36, 64
%r41 = trunc i320 %r40 to i64
%r43 = getelementptr i64, i64* %r32, i32 2
store i64 %r41, i64* %r43
%r44 = lshr i320 %r40, 64
%r45 = trunc i320 %r44 to i64
%r47 = getelementptr i64, i64* %r32, i32 3
store i64 %r45, i64* %r47
%r48 = lshr i320 %r44, 64
%r49 = trunc i320 %r48 to i64
%r51 = getelementptr i64, i64* %r32, i32 4
store i64 %r49, i64* %r51
ret void
}
define void @mcl_fpDbl_sqrPre4L(i64* noalias  %r1, i64* noalias  %r2)
{
%r3 = load i64, i64* %r2
%r4 = call i320 @mulPv256x64(i64* %r2, i64 %r3)
%r5 = trunc i320 %r4 to i64
store i64 %r5, i64* %r1
%r6 = lshr i320 %r4, 64
%r8 = getelementptr i64, i64* %r2, i32 1
%r9 = load i64, i64* %r8
%r10 = call i320 @mulPv256x64(i64* %r2, i64 %r9)
%r11 = add i320 %r6, %r10
%r12 = trunc i320 %r11 to i64
%r14 = getelementptr i64, i64* %r1, i32 1
store i64 %r12, i64* %r14
%r15 = lshr i320 %r11, 64
%r17 = getelementptr i64, i64* %r2, i32 2
%r18 = load i64, i64* %r17
%r19 = call i320 @mulPv256x64(i64* %r2, i64 %r18)
%r20 = add i320 %r15, %r19
%r21 = trunc i320 %r20 to i64
%r23 = getelementptr i64, i64* %r1, i32 2
store i64 %r21, i64* %r23
%r24 = lshr i320 %r20, 64
%r26 = getelementptr i64, i64* %r2, i32 3
%r27 = load i64, i64* %r26
%r28 = call i320 @mulPv256x64(i64* %r2, i64 %r27)
%r29 = add i320 %r24, %r28
%r31 = getelementptr i64, i64* %r1, i32 3
%r32 = trunc i320 %r29 to i64
%r34 = getelementptr i64, i64* %r31, i32 0
store i64 %r32, i64* %r34
%r35 = lshr i320 %r29, 64
%r36 = trunc i320 %r35 to i64
%r38 = getelementptr i64, i64* %r31, i32 1
store i64 %r36, i64* %r38
%r39 = lshr i320 %r35, 64
%r40 = trunc i320 %r39 to i64
%r42 = getelementptr i64, i64* %r31, i32 2
store i64 %r40, i64* %r42
%r43 = lshr i320 %r39, 64
%r44 = trunc i320 %r43 to i64
%r46 = getelementptr i64, i64* %r31, i32 3
store i64 %r44, i64* %r46
%r47 = lshr i320 %r43, 64
%r48 = trunc i320 %r47 to i64
%r50 = getelementptr i64, i64* %r31, i32 4
store i64 %r48, i64* %r50
ret void
}
define void @mcl_fp_mont4L(i64* %r1, i64* %r2, i64* %r3, i64* %r4)
{
%r6 = getelementptr i64, i64* %r4, i32 -1
%r7 = load i64, i64* %r6
%r9 = getelementptr i64, i64* %r3, i32 0
%r10 = load i64, i64* %r9
%r11 = call i320 @mulPv256x64(i64* %r2, i64 %r10)
%r12 = zext i320 %r11 to i384
%r13 = trunc i320 %r11 to i64
%r14 = mul i64 %r13, %r7
%r15 = call i320 @mulPv256x64(i64* %r4, i64 %r14)
%r16 = zext i320 %r15 to i384
%r17 = add i384 %r12, %r16
%r18 = lshr i384 %r17, 64
%r20 = getelementptr i64, i64* %r3, i32 1
%r21 = load i64, i64* %r20
%r22 = call i320 @mulPv256x64(i64* %r2, i64 %r21)
%r23 = zext i320 %r22 to i384
%r24 = add i384 %r18, %r23
%r25 = trunc i384 %r24 to i64
%r26 = mul i64 %r25, %r7
%r27 = call i320 @mulPv256x64(i64* %r4, i64 %r26)
%r28 = zext i320 %r27 to i384
%r29 = add i384 %r24, %r28
%r30 = lshr i384 %r29, 64
%r32 = getelementptr i64, i64* %r3, i32 2
%r33 = load i64, i64* %r32
%r34 = call i320 @mulPv256x64(i64* %r2, i64 %r33)
%r35 = zext i320 %r34 to i384
%r36 = add i384 %r30, %r35
%r37 = trunc i384 %r36 to i64
%r38 = mul i64 %r37, %r7
%r39 = call i320 @mulPv256x64(i64* %r4, i64 %r38)
%r40 = zext i320 %r39 to i384
%r41 = add i384 %r36, %r40
%r42 = lshr i384 %r41, 64
%r44 = getelementptr i64, i64* %r3, i32 3
%r45 = load i64, i64* %r44
%r46 = call i320 @mulPv256x64(i64* %r2, i64 %r45)
%r47 = zext i320 %r46 to i384
%r48 = add i384 %r42, %r47
%r49 = trunc i384 %r48 to i64
%r50 = mul i64 %r49, %r7
%r51 = call i320 @mulPv256x64(i64* %r4, i64 %r50)
%r52 = zext i320 %r51 to i384
%r53 = add i384 %r48, %r52
%r54 = lshr i384 %r53, 64
%r55 = trunc i384 %r54 to i320
%r56 = load i64, i64* %r4
%r57 = zext i64 %r56 to i128
%r59 = getelementptr i64, i64* %r4, i32 1
%r60 = load i64, i64* %r59
%r61 = zext i64 %r60 to i128
%r62 = shl i128 %r61, 64
%r63 = or i128 %r57, %r62
%r64 = zext i128 %r63 to i192
%r66 = getelementptr i64, i64* %r4, i32 2
%r67 = load i64, i64* %r66
%r68 = zext i64 %r67 to i192
%r69 = shl i192 %r68, 128
%r70 = or i192 %r64, %r69
%r71 = zext i192 %r70 to i256
%r73 = getelementptr i64, i64* %r4, i32 3
%r74 = load i64, i64* %r73
%r75 = zext i64 %r74 to i256
%r76 = shl i256 %r75, 192
%r77 = or i256 %r71, %r76
%r78 = zext i256 %r77 to i320
%r79 = sub i320 %r55, %r78
%r80 = lshr i320 %r79, 256
%r81 = trunc i320 %r80 to i1
%r82 = select i1 %r81, i320 %r55, i320 %r79
%r83 = trunc i320 %r82 to i256
%r84 = trunc i256 %r83 to i64
%r86 = getelementptr i64, i64* %r1, i32 0
store i64 %r84, i64* %r86
%r87 = lshr i256 %r83, 64
%r88 = trunc i256 %r87 to i64
%r90 = getelementptr i64, i64* %r1, i32 1
store i64 %r88, i64* %r90
%r91 = lshr i256 %r87, 64
%r92 = trunc i256 %r91 to i64
%r94 = getelementptr i64, i64* %r1, i32 2
store i64 %r92, i64* %r94
%r95 = lshr i256 %r91, 64
%r96 = trunc i256 %r95 to i64
%r98 = getelementptr i64, i64* %r1, i32 3
store i64 %r96, i64* %r98
ret void
}
define void @mcl_fp_montNF4L(i64* %r1, i64* %r2, i64* %r3, i64* %r4)
{
%r6 = getelementptr i64, i64* %r4, i32 -1
%r7 = load i64, i64* %r6
%r8 = load i64, i64* %r3
%r9 = call i320 @mulPv256x64(i64* %r2, i64 %r8)
%r10 = trunc i320 %r9 to i64
%r11 = mul i64 %r10, %r7
%r12 = call i320 @mulPv256x64(i64* %r4, i64 %r11)
%r13 = add i320 %r9, %r12
%r14 = lshr i320 %r13, 64
%r16 = getelementptr i64, i64* %r3, i32 1
%r17 = load i64, i64* %r16
%r18 = call i320 @mulPv256x64(i64* %r2, i64 %r17)
%r19 = add i320 %r14, %r18
%r20 = trunc i320 %r19 to i64
%r21 = mul i64 %r20, %r7
%r22 = call i320 @mulPv256x64(i64* %r4, i64 %r21)
%r23 = add i320 %r19, %r22
%r24 = lshr i320 %r23, 64
%r26 = getelementptr i64, i64* %r3, i32 2
%r27 = load i64, i64* %r26
%r28 = call i320 @mulPv256x64(i64* %r2, i64 %r27)
%r29 = add i320 %r24, %r28
%r30 = trunc i320 %r29 to i64
%r31 = mul i64 %r30, %r7
%r32 = call i320 @mulPv256x64(i64* %r4, i64 %r31)
%r33 = add i320 %r29, %r32
%r34 = lshr i320 %r33, 64
%r36 = getelementptr i64, i64* %r3, i32 3
%r37 = load i64, i64* %r36
%r38 = call i320 @mulPv256x64(i64* %r2, i64 %r37)
%r39 = add i320 %r34, %r38
%r40 = trunc i320 %r39 to i64
%r41 = mul i64 %r40, %r7
%r42 = call i320 @mulPv256x64(i64* %r4, i64 %r41)
%r43 = add i320 %r39, %r42
%r44 = lshr i320 %r43, 64
%r45 = trunc i320 %r44 to i256
%r46 = load i64, i64* %r4
%r47 = zext i64 %r46 to i128
%r49 = getelementptr i64, i64* %r4, i32 1
%r50 = load i64, i64* %r49
%r51 = zext i64 %r50 to i128
%r52 = shl i128 %r51, 64
%r53 = or i128 %r47, %r52
%r54 = zext i128 %r53 to i192
%r56 = getelementptr i64, i64* %r4, i32 2
%r57 = load i64, i64* %r56
%r58 = zext i64 %r57 to i192
%r59 = shl i192 %r58, 128
%r60 = or i192 %r54, %r59
%r61 = zext i192 %r60 to i256
%r63 = getelementptr i64, i64* %r4, i32 3
%r64 = load i64, i64* %r63
%r65 = zext i64 %r64 to i256
%r66 = shl i256 %r65, 192
%r67 = or i256 %r61, %r66
%r68 = sub i256 %r45, %r67
%r69 = lshr i256 %r68, 255
%r70 = trunc i256 %r69 to i1
%r71 = select i1 %r70, i256 %r45, i256 %r68
%r72 = trunc i256 %r71 to i64
%r74 = getelementptr i64, i64* %r1, i32 0
store i64 %r72, i64* %r74
%r75 = lshr i256 %r71, 64
%r76 = trunc i256 %r75 to i64
%r78 = getelementptr i64, i64* %r1, i32 1
store i64 %r76, i64* %r78
%r79 = lshr i256 %r75, 64
%r80 = trunc i256 %r79 to i64
%r82 = getelementptr i64, i64* %r1, i32 2
store i64 %r80, i64* %r82
%r83 = lshr i256 %r79, 64
%r84 = trunc i256 %r83 to i64
%r86 = getelementptr i64, i64* %r1, i32 3
store i64 %r84, i64* %r86
ret void
}
define void @mcl_fp_montRed4L(i64* noalias  %r1, i64* noalias  %r2, i64* noalias  %r3)
{
%r5 = getelementptr i64, i64* %r3, i32 -1
%r6 = load i64, i64* %r5
%r7 = load i64, i64* %r3
%r8 = zext i64 %r7 to i128
%r10 = getelementptr i64, i64* %r3, i32 1
%r11 = load i64, i64* %r10
%r12 = zext i64 %r11 to i128
%r13 = shl i128 %r12, 64
%r14 = or i128 %r8, %r13
%r15 = zext i128 %r14 to i192
%r17 = getelementptr i64, i64* %r3, i32 2
%r18 = load i64, i64* %r17
%r19 = zext i64 %r18 to i192
%r20 = shl i192 %r19, 128
%r21 = or i192 %r15, %r20
%r22 = zext i192 %r21 to i256
%r24 = getelementptr i64, i64* %r3, i32 3
%r25 = load i64, i64* %r24
%r26 = zext i64 %r25 to i256
%r27 = shl i256 %r26, 192
%r28 = or i256 %r22, %r27
%r29 = load i64, i64* %r2
%r30 = zext i64 %r29 to i128
%r32 = getelementptr i64, i64* %r2, i32 1
%r33 = load i64, i64* %r32
%r34 = zext i64 %r33 to i128
%r35 = shl i128 %r34, 64
%r36 = or i128 %r30, %r35
%r37 = zext i128 %r36 to i192
%r39 = getelementptr i64, i64* %r2, i32 2
%r40 = load i64, i64* %r39
%r41 = zext i64 %r40 to i192
%r42 = shl i192 %r41, 128
%r43 = or i192 %r37, %r42
%r44 = zext i192 %r43 to i256
%r46 = getelementptr i64, i64* %r2, i32 3
%r47 = load i64, i64* %r46
%r48 = zext i64 %r47 to i256
%r49 = shl i256 %r48, 192
%r50 = or i256 %r44, %r49
%r51 = zext i256 %r50 to i320
%r53 = getelementptr i64, i64* %r2, i32 4
%r54 = load i64, i64* %r53
%r55 = zext i64 %r54 to i320
%r56 = shl i320 %r55, 256
%r57 = or i320 %r51, %r56
%r58 = zext i320 %r57 to i384
%r60 = getelementptr i64, i64* %r2, i32 5
%r61 = load i64, i64* %r60
%r62 = zext i64 %r61 to i384
%r63 = shl i384 %r62, 320
%r64 = or i384 %r58, %r63
%r65 = zext i384 %r64 to i448
%r67 = getelementptr i64, i64* %r2, i32 6
%r68 = load i64, i64* %r67
%r69 = zext i64 %r68 to i448
%r70 = shl i448 %r69, 384
%r71 = or i448 %r65, %r70
%r72 = zext i448 %r71 to i512
%r74 = getelementptr i64, i64* %r2, i32 7
%r75 = load i64, i64* %r74
%r76 = zext i64 %r75 to i512
%r77 = shl i512 %r76, 448
%r78 = or i512 %r72, %r77
%r79 = zext i512 %r78 to i576
%r80 = trunc i576 %r79 to i64
%r81 = mul i64 %r80, %r6
%r82 = call i320 @mulPv256x64(i64* %r3, i64 %r81)
%r83 = zext i320 %r82 to i576
%r84 = add i576 %r79, %r83
%r85 = lshr i576 %r84, 64
%r86 = trunc i576 %r85 to i512
%r87 = trunc i512 %r86 to i64
%r88 = mul i64 %r87, %r6
%r89 = call i320 @mulPv256x64(i64* %r3, i64 %r88)
%r90 = zext i320 %r89 to i512
%r91 = add i512 %r86, %r90
%r92 = lshr i512 %r91, 64
%r93 = trunc i512 %r92 to i448
%r94 = trunc i448 %r93 to i64
%r95 = mul i64 %r94, %r6
%r96 = call i320 @mulPv256x64(i64* %r3, i64 %r95)
%r97 = zext i320 %r96 to i448
%r98 = add i448 %r93, %r97
%r99 = lshr i448 %r98, 64
%r100 = trunc i448 %r99 to i384
%r101 = trunc i384 %r100 to i64
%r102 = mul i64 %r101, %r6
%r103 = call i320 @mulPv256x64(i64* %r3, i64 %r102)
%r104 = zext i320 %r103 to i384
%r105 = add i384 %r100, %r104
%r106 = lshr i384 %r105, 64
%r107 = trunc i384 %r106 to i320
%r108 = zext i256 %r28 to i320
%r109 = sub i320 %r107, %r108
%r110 = lshr i320 %r109, 256
%r111 = trunc i320 %r110 to i1
%r112 = select i1 %r111, i320 %r107, i320 %r109
%r113 = trunc i320 %r112 to i256
%r114 = trunc i256 %r113 to i64
%r116 = getelementptr i64, i64* %r1, i32 0
store i64 %r114, i64* %r116
%r117 = lshr i256 %r113, 64
%r118 = trunc i256 %r117 to i64
%r120 = getelementptr i64, i64* %r1, i32 1
store i64 %r118, i64* %r120
%r121 = lshr i256 %r117, 64
%r122 = trunc i256 %r121 to i64
%r124 = getelementptr i64, i64* %r1, i32 2
store i64 %r122, i64* %r124
%r125 = lshr i256 %r121, 64
%r126 = trunc i256 %r125 to i64
%r128 = getelementptr i64, i64* %r1, i32 3
store i64 %r126, i64* %r128
ret void
}
define i64 @mcl_fp_addPre4L(i64* noalias  %r2, i64* noalias  %r3, i64* noalias  %r4)
{
%r5 = load i64, i64* %r3
%r6 = zext i64 %r5 to i128
%r8 = getelementptr i64, i64* %r3, i32 1
%r9 = load i64, i64* %r8
%r10 = zext i64 %r9 to i128
%r11 = shl i128 %r10, 64
%r12 = or i128 %r6, %r11
%r13 = zext i128 %r12 to i192
%r15 = getelementptr i64, i64* %r3, i32 2
%r16 = load i64, i64* %r15
%r17 = zext i64 %r16 to i192
%r18 = shl i192 %r17, 128
%r19 = or i192 %r13, %r18
%r20 = zext i192 %r19 to i256
%r22 = getelementptr i64, i64* %r3, i32 3
%r23 = load i64, i64* %r22
%r24 = zext i64 %r23 to i256
%r25 = shl i256 %r24, 192
%r26 = or i256 %r20, %r25
%r27 = zext i256 %r26 to i320
%r28 = load i64, i64* %r4
%r29 = zext i64 %r28 to i128
%r31 = getelementptr i64, i64* %r4, i32 1
%r32 = load i64, i64* %r31
%r33 = zext i64 %r32 to i128
%r34 = shl i128 %r33, 64
%r35 = or i128 %r29, %r34
%r36 = zext i128 %r35 to i192
%r38 = getelementptr i64, i64* %r4, i32 2
%r39 = load i64, i64* %r38
%r40 = zext i64 %r39 to i192
%r41 = shl i192 %r40, 128
%r42 = or i192 %r36, %r41
%r43 = zext i192 %r42 to i256
%r45 = getelementptr i64, i64* %r4, i32 3
%r46 = load i64, i64* %r45
%r47 = zext i64 %r46 to i256
%r48 = shl i256 %r47, 192
%r49 = or i256 %r43, %r48
%r50 = zext i256 %r49 to i320
%r51 = add i320 %r27, %r50
%r52 = trunc i320 %r51 to i256
%r53 = trunc i256 %r52 to i64
%r55 = getelementptr i64, i64* %r2, i32 0
store i64 %r53, i64* %r55
%r56 = lshr i256 %r52, 64
%r57 = trunc i256 %r56 to i64
%r59 = getelementptr i64, i64* %r2, i32 1
store i64 %r57, i64* %r59
%r60 = lshr i256 %r56, 64
%r61 = trunc i256 %r60 to i64
%r63 = getelementptr i64, i64* %r2, i32 2
store i64 %r61, i64* %r63
%r64 = lshr i256 %r60, 64
%r65 = trunc i256 %r64 to i64
%r67 = getelementptr i64, i64* %r2, i32 3
store i64 %r65, i64* %r67
%r68 = lshr i320 %r51, 256
%r69 = trunc i320 %r68 to i64
ret i64 %r69
}
define i64 @mcl_fp_subPre4L(i64* noalias  %r2, i64* noalias  %r3, i64* noalias  %r4)
{
%r5 = load i64, i64* %r3
%r6 = zext i64 %r5 to i128
%r8 = getelementptr i64, i64* %r3, i32 1
%r9 = load i64, i64* %r8
%r10 = zext i64 %r9 to i128
%r11 = shl i128 %r10, 64
%r12 = or i128 %r6, %r11
%r13 = zext i128 %r12 to i192
%r15 = getelementptr i64, i64* %r3, i32 2
%r16 = load i64, i64* %r15
%r17 = zext i64 %r16 to i192
%r18 = shl i192 %r17, 128
%r19 = or i192 %r13, %r18
%r20 = zext i192 %r19 to i256
%r22 = getelementptr i64, i64* %r3, i32 3
%r23 = load i64, i64* %r22
%r24 = zext i64 %r23 to i256
%r25 = shl i256 %r24, 192
%r26 = or i256 %r20, %r25
%r27 = zext i256 %r26 to i320
%r28 = load i64, i64* %r4
%r29 = zext i64 %r28 to i128
%r31 = getelementptr i64, i64* %r4, i32 1
%r32 = load i64, i64* %r31
%r33 = zext i64 %r32 to i128
%r34 = shl i128 %r33, 64
%r35 = or i128 %r29, %r34
%r36 = zext i128 %r35 to i192
%r38 = getelementptr i64, i64* %r4, i32 2
%r39 = load i64, i64* %r38
%r40 = zext i64 %r39 to i192
%r41 = shl i192 %r40, 128
%r42 = or i192 %r36, %r41
%r43 = zext i192 %r42 to i256
%r45 = getelementptr i64, i64* %r4, i32 3
%r46 = load i64, i64* %r45
%r47 = zext i64 %r46 to i256
%r48 = shl i256 %r47, 192
%r49 = or i256 %r43, %r48
%r50 = zext i256 %r49 to i320
%r51 = sub i320 %r27, %r50
%r52 = trunc i320 %r51 to i256
%r53 = trunc i256 %r52 to i64
%r55 = getelementptr i64, i64* %r2, i32 0
store i64 %r53, i64* %r55
%r56 = lshr i256 %r52, 64
%r57 = trunc i256 %r56 to i64
%r59 = getelementptr i64, i64* %r2, i32 1
store i64 %r57, i64* %r59
%r60 = lshr i256 %r56, 64
%r61 = trunc i256 %r60 to i64
%r63 = getelementptr i64, i64* %r2, i32 2
store i64 %r61, i64* %r63
%r64 = lshr i256 %r60, 64
%r65 = trunc i256 %r64 to i64
%r67 = getelementptr i64, i64* %r2, i32 3
store i64 %r65, i64* %r67
%r68 = lshr i320 %r51, 256
%r69 = trunc i320 %r68 to i64
%r71 = and i64 %r69, 1
ret i64 %r71
}
define void @mcl_fp_shr1_4L(i64* noalias  %r1, i64* noalias  %r2)
{
%r3 = load i64, i64* %r2
%r4 = zext i64 %r3 to i128
%r6 = getelementptr i64, i64* %r2, i32 1
%r7 = load i64, i64* %r6
%r8 = zext i64 %r7 to i128
%r9 = shl i128 %r8, 64
%r10 = or i128 %r4, %r9
%r11 = zext i128 %r10 to i192
%r13 = getelementptr i64, i64* %r2, i32 2
%r14 = load i64, i64* %r13
%r15 = zext i64 %r14 to i192
%r16 = shl i192 %r15, 128
%r17 = or i192 %r11, %r16
%r18 = zext i192 %r17 to i256
%r20 = getelementptr i64, i64* %r2, i32 3
%r21 = load i64, i64* %r20
%r22 = zext i64 %r21 to i256
%r23 = shl i256 %r22, 192
%r24 = or i256 %r18, %r23
%r25 = lshr i256 %r24, 1
%r26 = trunc i256 %r25 to i64
%r28 = getelementptr i64, i64* %r1, i32 0
store i64 %r26, i64* %r28
%r29 = lshr i256 %r25, 64
%r30 = trunc i256 %r29 to i64
%r32 = getelementptr i64, i64* %r1, i32 1
store i64 %r30, i64* %r32
%r33 = lshr i256 %r29, 64
%r34 = trunc i256 %r33 to i64
%r36 = getelementptr i64, i64* %r1, i32 2
store i64 %r34, i64* %r36
%r37 = lshr i256 %r33, 64
%r38 = trunc i256 %r37 to i64
%r40 = getelementptr i64, i64* %r1, i32 3
store i64 %r38, i64* %r40
ret void
}
define void @mcl_fp_add4L(i64* noalias  %r1, i64* noalias  %r2, i64* noalias  %r3, i64* noalias  %r4)
{
%r5 = load i64, i64* %r2
%r6 = zext i64 %r5 to i128
%r8 = getelementptr i64, i64* %r2, i32 1
%r9 = load i64, i64* %r8
%r10 = zext i64 %r9 to i128
%r11 = shl i128 %r10, 64
%r12 = or i128 %r6, %r11
%r13 = zext i128 %r12 to i192
%r15 = getelementptr i64, i64* %r2, i32 2
%r16 = load i64, i64* %r15
%r17 = zext i64 %r16 to i192
%r18 = shl i192 %r17, 128
%r19 = or i192 %r13, %r18
%r20 = zext i192 %r19 to i256
%r22 = getelementptr i64, i64* %r2, i32 3
%r23 = load i64, i64* %r22
%r24 = zext i64 %r23 to i256
%r25 = shl i256 %r24, 192
%r26 = or i256 %r20, %r25
%r27 = load i64, i64* %r3
%r28 = zext i64 %r27 to i128
%r30 = getelementptr i64, i64* %r3, i32 1
%r31 = load i64, i64* %r30
%r32 = zext i64 %r31 to i128
%r33 = shl i128 %r32, 64
%r34 = or i128 %r28, %r33
%r35 = zext i128 %r34 to i192
%r37 = getelementptr i64, i64* %r3, i32 2
%r38 = load i64, i64* %r37
%r39 = zext i64 %r38 to i192
%r40 = shl i192 %r39, 128
%r41 = or i192 %r35, %r40
%r42 = zext i192 %r41 to i256
%r44 = getelementptr i64, i64* %r3, i32 3
%r45 = load i64, i64* %r44
%r46 = zext i64 %r45 to i256
%r47 = shl i256 %r46, 192
%r48 = or i256 %r42, %r47
%r49 = zext i256 %r26 to i320
%r50 = zext i256 %r48 to i320
%r51 = add i320 %r49, %r50
%r52 = trunc i320 %r51 to i256
%r53 = trunc i256 %r52 to i64
%r55 = getelementptr i64, i64* %r1, i32 0
store i64 %r53, i64* %r55
%r56 = lshr i256 %r52, 64
%r57 = trunc i256 %r56 to i64
%r59 = getelementptr i64, i64* %r1, i32 1
store i64 %r57, i64* %r59
%r60 = lshr i256 %r56, 64
%r61 = trunc i256 %r60 to i64
%r63 = getelementptr i64, i64* %r1, i32 2
store i64 %r61, i64* %r63
%r64 = lshr i256 %r60, 64
%r65 = trunc i256 %r64 to i64
%r67 = getelementptr i64, i64* %r1, i32 3
store i64 %r65, i64* %r67
%r68 = load i64, i64* %r4
%r69 = zext i64 %r68 to i128
%r71 = getelementptr i64, i64* %r4, i32 1
%r72 = load i64, i64* %r71
%r73 = zext i64 %r72 to i128
%r74 = shl i128 %r73, 64
%r75 = or i128 %r69, %r74
%r76 = zext i128 %r75 to i192
%r78 = getelementptr i64, i64* %r4, i32 2
%r79 = load i64, i64* %r78
%r80 = zext i64 %r79 to i192
%r81 = shl i192 %r80, 128
%r82 = or i192 %r76, %r81
%r83 = zext i192 %r82 to i256
%r85 = getelementptr i64, i64* %r4, i32 3
%r86 = load i64, i64* %r85
%r87 = zext i64 %r86 to i256
%r88 = shl i256 %r87, 192
%r89 = or i256 %r83, %r88
%r90 = zext i256 %r89 to i320
%r91 = sub i320 %r51, %r90
%r92 = lshr i320 %r91, 256
%r93 = trunc i320 %r92 to i1
br i1%r93, label %carry, label %nocarry
nocarry:
%r94 = trunc i320 %r91 to i256
%r95 = trunc i256 %r94 to i64
%r97 = getelementptr i64, i64* %r1, i32 0
store i64 %r95, i64* %r97
%r98 = lshr i256 %r94, 64
%r99 = trunc i256 %r98 to i64
%r101 = getelementptr i64, i64* %r1, i32 1
store i64 %r99, i64* %r101
%r102 = lshr i256 %r98, 64
%r103 = trunc i256 %r102 to i64
%r105 = getelementptr i64, i64* %r1, i32 2
store i64 %r103, i64* %r105
%r106 = lshr i256 %r102, 64
%r107 = trunc i256 %r106 to i64
%r109 = getelementptr i64, i64* %r1, i32 3
store i64 %r107, i64* %r109
ret void
carry:
ret void
}
define void @mcl_fp_addNF4L(i64* noalias  %r1, i64* noalias  %r2, i64* noalias  %r3, i64* noalias  %r4)
{
%r5 = load i64, i64* %r2
%r6 = zext i64 %r5 to i128
%r8 = getelementptr i64, i64* %r2, i32 1
%r9 = load i64, i64* %r8
%r10 = zext i64 %r9 to i128
%r11 = shl i128 %r10, 64
%r12 = or i128 %r6, %r11
%r13 = zext i128 %r12 to i192
%r15 = getelementptr i64, i64* %r2, i32 2
%r16 = load i64, i64* %r15
%r17 = zext i64 %r16 to i192
%r18 = shl i192 %r17, 128
%r19 = or i192 %r13, %r18
%r20 = zext i192 %r19 to i256
%r22 = getelementptr i64, i64* %r2, i32 3
%r23 = load i64, i64* %r22
%r24 = zext i64 %r23 to i256
%r25 = shl i256 %r24, 192
%r26 = or i256 %r20, %r25
%r27 = load i64, i64* %r3
%r28 = zext i64 %r27 to i128
%r30 = getelementptr i64, i64* %r3, i32 1
%r31 = load i64, i64* %r30
%r32 = zext i64 %r31 to i128
%r33 = shl i128 %r32, 64
%r34 = or i128 %r28, %r33
%r35 = zext i128 %r34 to i192
%r37 = getelementptr i64, i64* %r3, i32 2
%r38 = load i64, i64* %r37
%r39 = zext i64 %r38 to i192
%r40 = shl i192 %r39, 128
%r41 = or i192 %r35, %r40
%r42 = zext i192 %r41 to i256
%r44 = getelementptr i64, i64* %r3, i32 3
%r45 = load i64, i64* %r44
%r46 = zext i64 %r45 to i256
%r47 = shl i256 %r46, 192
%r48 = or i256 %r42, %r47
%r49 = add i256 %r26, %r48
%r50 = load i64, i64* %r4
%r51 = zext i64 %r50 to i128
%r53 = getelementptr i64, i64* %r4, i32 1
%r54 = load i64, i64* %r53
%r55 = zext i64 %r54 to i128
%r56 = shl i128 %r55, 64
%r57 = or i128 %r51, %r56
%r58 = zext i128 %r57 to i192
%r60 = getelementptr i64, i64* %r4, i32 2
%r61 = load i64, i64* %r60
%r62 = zext i64 %r61 to i192
%r63 = shl i192 %r62, 128
%r64 = or i192 %r58, %r63
%r65 = zext i192 %r64 to i256
%r67 = getelementptr i64, i64* %r4, i32 3
%r68 = load i64, i64* %r67
%r69 = zext i64 %r68 to i256
%r70 = shl i256 %r69, 192
%r71 = or i256 %r65, %r70
%r72 = sub i256 %r49, %r71
%r73 = lshr i256 %r72, 255
%r74 = trunc i256 %r73 to i1
%r75 = select i1 %r74, i256 %r49, i256 %r72
%r76 = trunc i256 %r75 to i64
%r78 = getelementptr i64, i64* %r1, i32 0
store i64 %r76, i64* %r78
%r79 = lshr i256 %r75, 64
%r80 = trunc i256 %r79 to i64
%r82 = getelementptr i64, i64* %r1, i32 1
store i64 %r80, i64* %r82
%r83 = lshr i256 %r79, 64
%r84 = trunc i256 %r83 to i64
%r86 = getelementptr i64, i64* %r1, i32 2
store i64 %r84, i64* %r86
%r87 = lshr i256 %r83, 64
%r88 = trunc i256 %r87 to i64
%r90 = getelementptr i64, i64* %r1, i32 3
store i64 %r88, i64* %r90
ret void
}
define void @mcl_fp_sub4L(i64* noalias  %r1, i64* noalias  %r2, i64* noalias  %r3, i64* noalias  %r4)
{
%r5 = load i64, i64* %r2
%r6 = zext i64 %r5 to i128
%r8 = getelementptr i64, i64* %r2, i32 1
%r9 = load i64, i64* %r8
%r10 = zext i64 %r9 to i128
%r11 = shl i128 %r10, 64
%r12 = or i128 %r6, %r11
%r13 = zext i128 %r12 to i192
%r15 = getelementptr i64, i64* %r2, i32 2
%r16 = load i64, i64* %r15
%r17 = zext i64 %r16 to i192
%r18 = shl i192 %r17, 128
%r19 = or i192 %r13, %r18
%r20 = zext i192 %r19 to i256
%r22 = getelementptr i64, i64* %r2, i32 3
%r23 = load i64, i64* %r22
%r24 = zext i64 %r23 to i256
%r25 = shl i256 %r24, 192
%r26 = or i256 %r20, %r25
%r27 = load i64, i64* %r3
%r28 = zext i64 %r27 to i128
%r30 = getelementptr i64, i64* %r3, i32 1
%r31 = load i64, i64* %r30
%r32 = zext i64 %r31 to i128
%r33 = shl i128 %r32, 64
%r34 = or i128 %r28, %r33
%r35 = zext i128 %r34 to i192
%r37 = getelementptr i64, i64* %r3, i32 2
%r38 = load i64, i64* %r37
%r39 = zext i64 %r38 to i192
%r40 = shl i192 %r39, 128
%r41 = or i192 %r35, %r40
%r42 = zext i192 %r41 to i256
%r44 = getelementptr i64, i64* %r3, i32 3
%r45 = load i64, i64* %r44
%r46 = zext i64 %r45 to i256
%r47 = shl i256 %r46, 192
%r48 = or i256 %r42, %r47
%r49 = zext i256 %r26 to i320
%r50 = zext i256 %r48 to i320
%r51 = sub i320 %r49, %r50
%r52 = trunc i320 %r51 to i256
%r53 = lshr i320 %r51, 256
%r54 = trunc i320 %r53 to i1
%r55 = trunc i256 %r52 to i64
%r57 = getelementptr i64, i64* %r1, i32 0
store i64 %r55, i64* %r57
%r58 = lshr i256 %r52, 64
%r59 = trunc i256 %r58 to i64
%r61 = getelementptr i64, i64* %r1, i32 1
store i64 %r59, i64* %r61
%r62 = lshr i256 %r58, 64
%r63 = trunc i256 %r62 to i64
%r65 = getelementptr i64, i64* %r1, i32 2
store i64 %r63, i64* %r65
%r66 = lshr i256 %r62, 64
%r67 = trunc i256 %r66 to i64
%r69 = getelementptr i64, i64* %r1, i32 3
store i64 %r67, i64* %r69
br i1%r54, label %carry, label %nocarry
nocarry:
ret void
carry:
%r70 = load i64, i64* %r4
%r71 = zext i64 %r70 to i128
%r73 = getelementptr i64, i64* %r4, i32 1
%r74 = load i64, i64* %r73
%r75 = zext i64 %r74 to i128
%r76 = shl i128 %r75, 64
%r77 = or i128 %r71, %r76
%r78 = zext i128 %r77 to i192
%r80 = getelementptr i64, i64* %r4, i32 2
%r81 = load i64, i64* %r80
%r82 = zext i64 %r81 to i192
%r83 = shl i192 %r82, 128
%r84 = or i192 %r78, %r83
%r85 = zext i192 %r84 to i256
%r87 = getelementptr i64, i64* %r4, i32 3
%r88 = load i64, i64* %r87
%r89 = zext i64 %r88 to i256
%r90 = shl i256 %r89, 192
%r91 = or i256 %r85, %r90
%r92 = add i256 %r52, %r91
%r93 = trunc i256 %r92 to i64
%r95 = getelementptr i64, i64* %r1, i32 0
store i64 %r93, i64* %r95
%r96 = lshr i256 %r92, 64
%r97 = trunc i256 %r96 to i64
%r99 = getelementptr i64, i64* %r1, i32 1
store i64 %r97, i64* %r99
%r100 = lshr i256 %r96, 64
%r101 = trunc i256 %r100 to i64
%r103 = getelementptr i64, i64* %r1, i32 2
store i64 %r101, i64* %r103
%r104 = lshr i256 %r100, 64
%r105 = trunc i256 %r104 to i64
%r107 = getelementptr i64, i64* %r1, i32 3
store i64 %r105, i64* %r107
ret void
}
define void @mcl_fp_subNF4L(i64* noalias  %r1, i64* noalias  %r2, i64* noalias  %r3, i64* noalias  %r4)
{
%r5 = load i64, i64* %r2
%r6 = zext i64 %r5 to i128
%r8 = getelementptr i64, i64* %r2, i32 1
%r9 = load i64, i64* %r8
%r10 = zext i64 %r9 to i128
%r11 = shl i128 %r10, 64
%r12 = or i128 %r6, %r11
%r13 = zext i128 %r12 to i192
%r15 = getelementptr i64, i64* %r2, i32 2
%r16 = load i64, i64* %r15
%r17 = zext i64 %r16 to i192
%r18 = shl i192 %r17, 128
%r19 = or i192 %r13, %r18
%r20 = zext i192 %r19 to i256
%r22 = getelementptr i64, i64* %r2, i32 3
%r23 = load i64, i64* %r22
%r24 = zext i64 %r23 to i256
%r25 = shl i256 %r24, 192
%r26 = or i256 %r20, %r25
%r27 = load i64, i64* %r3
%r28 = zext i64 %r27 to i128
%r30 = getelementptr i64, i64* %r3, i32 1
%r31 = load i64, i64* %r30
%r32 = zext i64 %r31 to i128
%r33 = shl i128 %r32, 64
%r34 = or i128 %r28, %r33
%r35 = zext i128 %r34 to i192
%r37 = getelementptr i64, i64* %r3, i32 2
%r38 = load i64, i64* %r37
%r39 = zext i64 %r38 to i192
%r40 = shl i192 %r39, 128
%r41 = or i192 %r35, %r40
%r42 = zext i192 %r41 to i256
%r44 = getelementptr i64, i64* %r3, i32 3
%r45 = load i64, i64* %r44
%r46 = zext i64 %r45 to i256
%r47 = shl i256 %r46, 192
%r48 = or i256 %r42, %r47
%r49 = sub i256 %r26, %r48
%r50 = lshr i256 %r49, 255
%r51 = trunc i256 %r50 to i1
%r52 = load i64, i64* %r4
%r53 = zext i64 %r52 to i128
%r55 = getelementptr i64, i64* %r4, i32 1
%r56 = load i64, i64* %r55
%r57 = zext i64 %r56 to i128
%r58 = shl i128 %r57, 64
%r59 = or i128 %r53, %r58
%r60 = zext i128 %r59 to i192
%r62 = getelementptr i64, i64* %r4, i32 2
%r63 = load i64, i64* %r62
%r64 = zext i64 %r63 to i192
%r65 = shl i192 %r64, 128
%r66 = or i192 %r60, %r65
%r67 = zext i192 %r66 to i256
%r69 = getelementptr i64, i64* %r4, i32 3
%r70 = load i64, i64* %r69
%r71 = zext i64 %r70 to i256
%r72 = shl i256 %r71, 192
%r73 = or i256 %r67, %r72
%r75 = select i1 %r51, i256 %r73, i256 0
%r76 = add i256 %r49, %r75
%r77 = trunc i256 %r76 to i64
%r79 = getelementptr i64, i64* %r1, i32 0
store i64 %r77, i64* %r79
%r80 = lshr i256 %r76, 64
%r81 = trunc i256 %r80 to i64
%r83 = getelementptr i64, i64* %r1, i32 1
store i64 %r81, i64* %r83
%r84 = lshr i256 %r80, 64
%r85 = trunc i256 %r84 to i64
%r87 = getelementptr i64, i64* %r1, i32 2
store i64 %r85, i64* %r87
%r88 = lshr i256 %r84, 64
%r89 = trunc i256 %r88 to i64
%r91 = getelementptr i64, i64* %r1, i32 3
store i64 %r89, i64* %r91
ret void
}
define void @mcl_fpDbl_add4L(i64* noalias  %r1, i64* noalias  %r2, i64* noalias  %r3, i64* noalias  %r4)
{
%r5 = load i64, i64* %r2
%r6 = zext i64 %r5 to i128
%r8 = getelementptr i64, i64* %r2, i32 1
%r9 = load i64, i64* %r8
%r10 = zext i64 %r9 to i128
%r11 = shl i128 %r10, 64
%r12 = or i128 %r6, %r11
%r13 = zext i128 %r12 to i192
%r15 = getelementptr i64, i64* %r2, i32 2
%r16 = load i64, i64* %r15
%r17 = zext i64 %r16 to i192
%r18 = shl i192 %r17, 128
%r19 = or i192 %r13, %r18
%r20 = zext i192 %r19 to i256
%r22 = getelementptr i64, i64* %r2, i32 3
%r23 = load i64, i64* %r22
%r24 = zext i64 %r23 to i256
%r25 = shl i256 %r24, 192
%r26 = or i256 %r20, %r25
%r27 = zext i256 %r26 to i320
%r29 = getelementptr i64, i64* %r2, i32 4
%r30 = load i64, i64* %r29
%r31 = zext i64 %r30 to i320
%r32 = shl i320 %r31, 256
%r33 = or i320 %r27, %r32
%r34 = zext i320 %r33 to i384
%r36 = getelementptr i64, i64* %r2, i32 5
%r37 = load i64, i64* %r36
%r38 = zext i64 %r37 to i384
%r39 = shl i384 %r38, 320
%r40 = or i384 %r34, %r39
%r41 = zext i384 %r40 to i448
%r43 = getelementptr i64, i64* %r2, i32 6
%r44 = load i64, i64* %r43
%r45 = zext i64 %r44 to i448
%r46 = shl i448 %r45, 384
%r47 = or i448 %r41, %r46
%r48 = zext i448 %r47 to i512
%r50 = getelementptr i64, i64* %r2, i32 7
%r51 = load i64, i64* %r50
%r52 = zext i64 %r51 to i512
%r53 = shl i512 %r52, 448
%r54 = or i512 %r48, %r53
%r55 = load i64, i64* %r3
%r56 = zext i64 %r55 to i128
%r58 = getelementptr i64, i64* %r3, i32 1
%r59 = load i64, i64* %r58
%r60 = zext i64 %r59 to i128
%r61 = shl i128 %r60, 64
%r62 = or i128 %r56, %r61
%r63 = zext i128 %r62 to i192
%r65 = getelementptr i64, i64* %r3, i32 2
%r66 = load i64, i64* %r65
%r67 = zext i64 %r66 to i192
%r68 = shl i192 %r67, 128
%r69 = or i192 %r63, %r68
%r70 = zext i192 %r69 to i256
%r72 = getelementptr i64, i64* %r3, i32 3
%r73 = load i64, i64* %r72
%r74 = zext i64 %r73 to i256
%r75 = shl i256 %r74, 192
%r76 = or i256 %r70, %r75
%r77 = zext i256 %r76 to i320
%r79 = getelementptr i64, i64* %r3, i32 4
%r80 = load i64, i64* %r79
%r81 = zext i64 %r80 to i320
%r82 = shl i320 %r81, 256
%r83 = or i320 %r77, %r82
%r84 = zext i320 %r83 to i384
%r86 = getelementptr i64, i64* %r3, i32 5
%r87 = load i64, i64* %r86
%r88 = zext i64 %r87 to i384
%r89 = shl i384 %r88, 320
%r90 = or i384 %r84, %r89
%r91 = zext i384 %r90 to i448
%r93 = getelementptr i64, i64* %r3, i32 6
%r94 = load i64, i64* %r93
%r95 = zext i64 %r94 to i448
%r96 = shl i448 %r95, 384
%r97 = or i448 %r91, %r96
%r98 = zext i448 %r97 to i512
%r100 = getelementptr i64, i64* %r3, i32 7
%r101 = load i64, i64* %r100
%r102 = zext i64 %r101 to i512
%r103 = shl i512 %r102, 448
%r104 = or i512 %r98, %r103
%r105 = zext i512 %r54 to i576
%r106 = zext i512 %r104 to i576
%r107 = add i576 %r105, %r106
%r108 = trunc i576 %r107 to i256
%r109 = trunc i256 %r108 to i64
%r111 = getelementptr i64, i64* %r1, i32 0
store i64 %r109, i64* %r111
%r112 = lshr i256 %r108, 64
%r113 = trunc i256 %r112 to i64
%r115 = getelementptr i64, i64* %r1, i32 1
store i64 %r113, i64* %r115
%r116 = lshr i256 %r112, 64
%r117 = trunc i256 %r116 to i64
%r119 = getelementptr i64, i64* %r1, i32 2
store i64 %r117, i64* %r119
%r120 = lshr i256 %r116, 64
%r121 = trunc i256 %r120 to i64
%r123 = getelementptr i64, i64* %r1, i32 3
store i64 %r121, i64* %r123
%r124 = lshr i576 %r107, 256
%r125 = trunc i576 %r124 to i320
%r126 = load i64, i64* %r4
%r127 = zext i64 %r126 to i128
%r129 = getelementptr i64, i64* %r4, i32 1
%r130 = load i64, i64* %r129
%r131 = zext i64 %r130 to i128
%r132 = shl i128 %r131, 64
%r133 = or i128 %r127, %r132
%r134 = zext i128 %r133 to i192
%r136 = getelementptr i64, i64* %r4, i32 2
%r137 = load i64, i64* %r136
%r138 = zext i64 %r137 to i192
%r139 = shl i192 %r138, 128
%r140 = or i192 %r134, %r139
%r141 = zext i192 %r140 to i256
%r143 = getelementptr i64, i64* %r4, i32 3
%r144 = load i64, i64* %r143
%r145 = zext i64 %r144 to i256
%r146 = shl i256 %r145, 192
%r147 = or i256 %r141, %r146
%r148 = zext i256 %r147 to i320
%r149 = sub i320 %r125, %r148
%r150 = lshr i320 %r149, 256
%r151 = trunc i320 %r150 to i1
%r152 = select i1 %r151, i320 %r125, i320 %r149
%r153 = trunc i320 %r152 to i256
%r155 = getelementptr i64, i64* %r1, i32 4
%r156 = trunc i256 %r153 to i64
%r158 = getelementptr i64, i64* %r155, i32 0
store i64 %r156, i64* %r158
%r159 = lshr i256 %r153, 64
%r160 = trunc i256 %r159 to i64
%r162 = getelementptr i64, i64* %r155, i32 1
store i64 %r160, i64* %r162
%r163 = lshr i256 %r159, 64
%r164 = trunc i256 %r163 to i64
%r166 = getelementptr i64, i64* %r155, i32 2
store i64 %r164, i64* %r166
%r167 = lshr i256 %r163, 64
%r168 = trunc i256 %r167 to i64
%r170 = getelementptr i64, i64* %r155, i32 3
store i64 %r168, i64* %r170
ret void
}
define void @mcl_fpDbl_sub4L(i64* noalias  %r1, i64* noalias  %r2, i64* noalias  %r3, i64* noalias  %r4)
{
%r5 = load i64, i64* %r2
%r6 = zext i64 %r5 to i128
%r8 = getelementptr i64, i64* %r2, i32 1
%r9 = load i64, i64* %r8
%r10 = zext i64 %r9 to i128
%r11 = shl i128 %r10, 64
%r12 = or i128 %r6, %r11
%r13 = zext i128 %r12 to i192
%r15 = getelementptr i64, i64* %r2, i32 2
%r16 = load i64, i64* %r15
%r17 = zext i64 %r16 to i192
%r18 = shl i192 %r17, 128
%r19 = or i192 %r13, %r18
%r20 = zext i192 %r19 to i256
%r22 = getelementptr i64, i64* %r2, i32 3
%r23 = load i64, i64* %r22
%r24 = zext i64 %r23 to i256
%r25 = shl i256 %r24, 192
%r26 = or i256 %r20, %r25
%r27 = zext i256 %r26 to i320
%r29 = getelementptr i64, i64* %r2, i32 4
%r30 = load i64, i64* %r29
%r31 = zext i64 %r30 to i320
%r32 = shl i320 %r31, 256
%r33 = or i320 %r27, %r32
%r34 = zext i320 %r33 to i384
%r36 = getelementptr i64, i64* %r2, i32 5
%r37 = load i64, i64* %r36
%r38 = zext i64 %r37 to i384
%r39 = shl i384 %r38, 320
%r40 = or i384 %r34, %r39
%r41 = zext i384 %r40 to i448
%r43 = getelementptr i64, i64* %r2, i32 6
%r44 = load i64, i64* %r43
%r45 = zext i64 %r44 to i448
%r46 = shl i448 %r45, 384
%r47 = or i448 %r41, %r46
%r48 = zext i448 %r47 to i512
%r50 = getelementptr i64, i64* %r2, i32 7
%r51 = load i64, i64* %r50
%r52 = zext i64 %r51 to i512
%r53 = shl i512 %r52, 448
%r54 = or i512 %r48, %r53
%r55 = load i64, i64* %r3
%r56 = zext i64 %r55 to i128
%r58 = getelementptr i64, i64* %r3, i32 1
%r59 = load i64, i64* %r58
%r60 = zext i64 %r59 to i128
%r61 = shl i128 %r60, 64
%r62 = or i128 %r56, %r61
%r63 = zext i128 %r62 to i192
%r65 = getelementptr i64, i64* %r3, i32 2
%r66 = load i64, i64* %r65
%r67 = zext i64 %r66 to i192
%r68 = shl i192 %r67, 128
%r69 = or i192 %r63, %r68
%r70 = zext i192 %r69 to i256
%r72 = getelementptr i64, i64* %r3, i32 3
%r73 = load i64, i64* %r72
%r74 = zext i64 %r73 to i256
%r75 = shl i256 %r74, 192
%r76 = or i256 %r70, %r75
%r77 = zext i256 %r76 to i320
%r79 = getelementptr i64, i64* %r3, i32 4
%r80 = load i64, i64* %r79
%r81 = zext i64 %r80 to i320
%r82 = shl i320 %r81, 256
%r83 = or i320 %r77, %r82
%r84 = zext i320 %r83 to i384
%r86 = getelementptr i64, i64* %r3, i32 5
%r87 = load i64, i64* %r86
%r88 = zext i64 %r87 to i384
%r89 = shl i384 %r88, 320
%r90 = or i384 %r84, %r89
%r91 = zext i384 %r90 to i448
%r93 = getelementptr i64, i64* %r3, i32 6
%r94 = load i64, i64* %r93
%r95 = zext i64 %r94 to i448
%r96 = shl i448 %r95, 384
%r97 = or i448 %r91, %r96
%r98 = zext i448 %r97 to i512
%r100 = getelementptr i64, i64* %r3, i32 7
%r101 = load i64, i64* %r100
%r102 = zext i64 %r101 to i512
%r103 = shl i512 %r102, 448
%r104 = or i512 %r98, %r103
%r105 = zext i512 %r54 to i576
%r106 = zext i512 %r104 to i576
%r107 = sub i576 %r105, %r106
%r108 = trunc i576 %r107 to i256
%r109 = trunc i256 %r108 to i64
%r111 = getelementptr i64, i64* %r1, i32 0
store i64 %r109, i64* %r111
%r112 = lshr i256 %r108, 64
%r113 = trunc i256 %r112 to i64
%r115 = getelementptr i64, i64* %r1, i32 1
store i64 %r113, i64* %r115
%r116 = lshr i256 %r112, 64
%r117 = trunc i256 %r116 to i64
%r119 = getelementptr i64, i64* %r1, i32 2
store i64 %r117, i64* %r119
%r120 = lshr i256 %r116, 64
%r121 = trunc i256 %r120 to i64
%r123 = getelementptr i64, i64* %r1, i32 3
store i64 %r121, i64* %r123
%r124 = lshr i576 %r107, 256
%r125 = trunc i576 %r124 to i256
%r126 = lshr i576 %r107, 512
%r127 = trunc i576 %r126 to i1
%r128 = load i64, i64* %r4
%r129 = zext i64 %r128 to i128
%r131 = getelementptr i64, i64* %r4, i32 1
%r132 = load i64, i64* %r131
%r133 = zext i64 %r132 to i128
%r134 = shl i128 %r133, 64
%r135 = or i128 %r129, %r134
%r136 = zext i128 %r135 to i192
%r138 = getelementptr i64, i64* %r4, i32 2
%r139 = load i64, i64* %r138
%r140 = zext i64 %r139 to i192
%r141 = shl i192 %r140, 128
%r142 = or i192 %r136, %r141
%r143 = zext i192 %r142 to i256
%r145 = getelementptr i64, i64* %r4, i32 3
%r146 = load i64, i64* %r145
%r147 = zext i64 %r146 to i256
%r148 = shl i256 %r147, 192
%r149 = or i256 %r143, %r148
%r151 = select i1 %r127, i256 %r149, i256 0
%r152 = add i256 %r125, %r151
%r154 = getelementptr i64, i64* %r1, i32 4
%r155 = trunc i256 %r152 to i64
%r157 = getelementptr i64, i64* %r154, i32 0
store i64 %r155, i64* %r157
%r158 = lshr i256 %r152, 64
%r159 = trunc i256 %r158 to i64
%r161 = getelementptr i64, i64* %r154, i32 1
store i64 %r159, i64* %r161
%r162 = lshr i256 %r158, 64
%r163 = trunc i256 %r162 to i64
%r165 = getelementptr i64, i64* %r154, i32 2
store i64 %r163, i64* %r165
%r166 = lshr i256 %r162, 64
%r167 = trunc i256 %r166 to i64
%r169 = getelementptr i64, i64* %r154, i32 3
store i64 %r167, i64* %r169
ret void
}
define i384 @mulPv320x64(i64* noalias  %r2, i64 %r3)
{
%r5 = call i128 @mulPos64x64(i64* %r2, i64 %r3, i64 0)
%r6 = trunc i128 %r5 to i64
%r7 = call i64 @extractHigh64(i128 %r5)
%r9 = call i128 @mulPos64x64(i64* %r2, i64 %r3, i64 1)
%r10 = trunc i128 %r9 to i64
%r11 = call i64 @extractHigh64(i128 %r9)
%r13 = call i128 @mulPos64x64(i64* %r2, i64 %r3, i64 2)
%r14 = trunc i128 %r13 to i64
%r15 = call i64 @extractHigh64(i128 %r13)
%r17 = call i128 @mulPos64x64(i64* %r2, i64 %r3, i64 3)
%r18 = trunc i128 %r17 to i64
%r19 = call i64 @extractHigh64(i128 %r17)
%r21 = call i128 @mulPos64x64(i64* %r2, i64 %r3, i64 4)
%r22 = trunc i128 %r21 to i64
%r23 = call i64 @extractHigh64(i128 %r21)
%r24 = zext i64 %r6 to i128
%r25 = zext i64 %r10 to i128
%r26 = shl i128 %r25, 64
%r27 = or i128 %r24, %r26
%r28 = zext i128 %r27 to i192
%r29 = zext i64 %r14 to i192
%r30 = shl i192 %r29, 128
%r31 = or i192 %r28, %r30
%r32 = zext i192 %r31 to i256
%r33 = zext i64 %r18 to i256
%r34 = shl i256 %r33, 192
%r35 = or i256 %r32, %r34
%r36 = zext i256 %r35 to i320
%r37 = zext i64 %r22 to i320
%r38 = shl i320 %r37, 256
%r39 = or i320 %r36, %r38
%r40 = zext i64 %r7 to i128
%r41 = zext i64 %r11 to i128
%r42 = shl i128 %r41, 64
%r43 = or i128 %r40, %r42
%r44 = zext i128 %r43 to i192
%r45 = zext i64 %r15 to i192
%r46 = shl i192 %r45, 128
%r47 = or i192 %r44, %r46
%r48 = zext i192 %r47 to i256
%r49 = zext i64 %r19 to i256
%r50 = shl i256 %r49, 192
%r51 = or i256 %r48, %r50
%r52 = zext i256 %r51 to i320
%r53 = zext i64 %r23 to i320
%r54 = shl i320 %r53, 256
%r55 = or i320 %r52, %r54
%r56 = zext i320 %r39 to i384
%r57 = zext i320 %r55 to i384
%r58 = shl i384 %r57, 64
%r59 = add i384 %r56, %r58
ret i384 %r59
}
define void @mcl_fp_mulUnitPre5L(i64* noalias  %r1, i64* noalias  %r2, i64 %r3)
{
%r4 = call i384 @mulPv320x64(i64* %r2, i64 %r3)
%r5 = trunc i384 %r4 to i64
%r7 = getelementptr i64, i64* %r1, i32 0
store i64 %r5, i64* %r7
%r8 = lshr i384 %r4, 64
%r9 = trunc i384 %r8 to i64
%r11 = getelementptr i64, i64* %r1, i32 1
store i64 %r9, i64* %r11
%r12 = lshr i384 %r8, 64
%r13 = trunc i384 %r12 to i64
%r15 = getelementptr i64, i64* %r1, i32 2
store i64 %r13, i64* %r15
%r16 = lshr i384 %r12, 64
%r17 = trunc i384 %r16 to i64
%r19 = getelementptr i64, i64* %r1, i32 3
store i64 %r17, i64* %r19
%r20 = lshr i384 %r16, 64
%r21 = trunc i384 %r20 to i64
%r23 = getelementptr i64, i64* %r1, i32 4
store i64 %r21, i64* %r23
%r24 = lshr i384 %r20, 64
%r25 = trunc i384 %r24 to i64
%r27 = getelementptr i64, i64* %r1, i32 5
store i64 %r25, i64* %r27
ret void
}
define void @mcl_fpDbl_mulPre5L(i64* noalias  %r1, i64* noalias  %r2, i64* noalias  %r3)
{
%r4 = load i64, i64* %r3
%r5 = call i384 @mulPv320x64(i64* %r2, i64 %r4)
%r6 = trunc i384 %r5 to i64
store i64 %r6, i64* %r1
%r7 = lshr i384 %r5, 64
%r9 = getelementptr i64, i64* %r3, i32 1
%r10 = load i64, i64* %r9
%r11 = call i384 @mulPv320x64(i64* %r2, i64 %r10)
%r12 = add i384 %r7, %r11
%r13 = trunc i384 %r12 to i64
%r15 = getelementptr i64, i64* %r1, i32 1
store i64 %r13, i64* %r15
%r16 = lshr i384 %r12, 64
%r18 = getelementptr i64, i64* %r3, i32 2
%r19 = load i64, i64* %r18
%r20 = call i384 @mulPv320x64(i64* %r2, i64 %r19)
%r21 = add i384 %r16, %r20
%r22 = trunc i384 %r21 to i64
%r24 = getelementptr i64, i64* %r1, i32 2
store i64 %r22, i64* %r24
%r25 = lshr i384 %r21, 64
%r27 = getelementptr i64, i64* %r3, i32 3
%r28 = load i64, i64* %r27
%r29 = call i384 @mulPv320x64(i64* %r2, i64 %r28)
%r30 = add i384 %r25, %r29
%r31 = trunc i384 %r30 to i64
%r33 = getelementptr i64, i64* %r1, i32 3
store i64 %r31, i64* %r33
%r34 = lshr i384 %r30, 64
%r36 = getelementptr i64, i64* %r3, i32 4
%r37 = load i64, i64* %r36
%r38 = call i384 @mulPv320x64(i64* %r2, i64 %r37)
%r39 = add i384 %r34, %r38
%r41 = getelementptr i64, i64* %r1, i32 4
%r42 = trunc i384 %r39 to i64
%r44 = getelementptr i64, i64* %r41, i32 0
store i64 %r42, i64* %r44
%r45 = lshr i384 %r39, 64
%r46 = trunc i384 %r45 to i64
%r48 = getelementptr i64, i64* %r41, i32 1
store i64 %r46, i64* %r48
%r49 = lshr i384 %r45, 64
%r50 = trunc i384 %r49 to i64
%r52 = getelementptr i64, i64* %r41, i32 2
store i64 %r50, i64* %r52
%r53 = lshr i384 %r49, 64
%r54 = trunc i384 %r53 to i64
%r56 = getelementptr i64, i64* %r41, i32 3
store i64 %r54, i64* %r56
%r57 = lshr i384 %r53, 64
%r58 = trunc i384 %r57 to i64
%r60 = getelementptr i64, i64* %r41, i32 4
store i64 %r58, i64* %r60
%r61 = lshr i384 %r57, 64
%r62 = trunc i384 %r61 to i64
%r64 = getelementptr i64, i64* %r41, i32 5
store i64 %r62, i64* %r64
ret void
}
define void @mcl_fpDbl_sqrPre5L(i64* noalias  %r1, i64* noalias  %r2)
{
%r3 = load i64, i64* %r2
%r4 = call i384 @mulPv320x64(i64* %r2, i64 %r3)
%r5 = trunc i384 %r4 to i64
store i64 %r5, i64* %r1
%r6 = lshr i384 %r4, 64
%r8 = getelementptr i64, i64* %r2, i32 1
%r9 = load i64, i64* %r8
%r10 = call i384 @mulPv320x64(i64* %r2, i64 %r9)
%r11 = add i384 %r6, %r10
%r12 = trunc i384 %r11 to i64
%r14 = getelementptr i64, i64* %r1, i32 1
store i64 %r12, i64* %r14
%r15 = lshr i384 %r11, 64
%r17 = getelementptr i64, i64* %r2, i32 2
%r18 = load i64, i64* %r17
%r19 = call i384 @mulPv320x64(i64* %r2, i64 %r18)
%r20 = add i384 %r15, %r19
%r21 = trunc i384 %r20 to i64
%r23 = getelementptr i64, i64* %r1, i32 2
store i64 %r21, i64* %r23
%r24 = lshr i384 %r20, 64
%r26 = getelementptr i64, i64* %r2, i32 3
%r27 = load i64, i64* %r26
%r28 = call i384 @mulPv320x64(i64* %r2, i64 %r27)
%r29 = add i384 %r24, %r28
%r30 = trunc i384 %r29 to i64
%r32 = getelementptr i64, i64* %r1, i32 3
store i64 %r30, i64* %r32
%r33 = lshr i384 %r29, 64
%r35 = getelementptr i64, i64* %r2, i32 4
%r36 = load i64, i64* %r35
%r37 = call i384 @mulPv320x64(i64* %r2, i64 %r36)
%r38 = add i384 %r33, %r37
%r40 = getelementptr i64, i64* %r1, i32 4
%r41 = trunc i384 %r38 to i64
%r43 = getelementptr i64, i64* %r40, i32 0
store i64 %r41, i64* %r43
%r44 = lshr i384 %r38, 64
%r45 = trunc i384 %r44 to i64
%r47 = getelementptr i64, i64* %r40, i32 1
store i64 %r45, i64* %r47
%r48 = lshr i384 %r44, 64
%r49 = trunc i384 %r48 to i64
%r51 = getelementptr i64, i64* %r40, i32 2
store i64 %r49, i64* %r51
%r52 = lshr i384 %r48, 64
%r53 = trunc i384 %r52 to i64
%r55 = getelementptr i64, i64* %r40, i32 3
store i64 %r53, i64* %r55
%r56 = lshr i384 %r52, 64
%r57 = trunc i384 %r56 to i64
%r59 = getelementptr i64, i64* %r40, i32 4
store i64 %r57, i64* %r59
%r60 = lshr i384 %r56, 64
%r61 = trunc i384 %r60 to i64
%r63 = getelementptr i64, i64* %r40, i32 5
store i64 %r61, i64* %r63
ret void
}
define void @mcl_fp_mont5L(i64* %r1, i64* %r2, i64* %r3, i64* %r4)
{
%r6 = getelementptr i64, i64* %r4, i32 -1
%r7 = load i64, i64* %r6
%r9 = getelementptr i64, i64* %r3, i32 0
%r10 = load i64, i64* %r9
%r11 = call i384 @mulPv320x64(i64* %r2, i64 %r10)
%r12 = zext i384 %r11 to i448
%r13 = trunc i384 %r11 to i64
%r14 = mul i64 %r13, %r7
%r15 = call i384 @mulPv320x64(i64* %r4, i64 %r14)
%r16 = zext i384 %r15 to i448
%r17 = add i448 %r12, %r16
%r18 = lshr i448 %r17, 64
%r20 = getelementptr i64, i64* %r3, i32 1
%r21 = load i64, i64* %r20
%r22 = call i384 @mulPv320x64(i64* %r2, i64 %r21)
%r23 = zext i384 %r22 to i448
%r24 = add i448 %r18, %r23
%r25 = trunc i448 %r24 to i64
%r26 = mul i64 %r25, %r7
%r27 = call i384 @mulPv320x64(i64* %r4, i64 %r26)
%r28 = zext i384 %r27 to i448
%r29 = add i448 %r24, %r28
%r30 = lshr i448 %r29, 64
%r32 = getelementptr i64, i64* %r3, i32 2
%r33 = load i64, i64* %r32
%r34 = call i384 @mulPv320x64(i64* %r2, i64 %r33)
%r35 = zext i384 %r34 to i448
%r36 = add i448 %r30, %r35
%r37 = trunc i448 %r36 to i64
%r38 = mul i64 %r37, %r7
%r39 = call i384 @mulPv320x64(i64* %r4, i64 %r38)
%r40 = zext i384 %r39 to i448
%r41 = add i448 %r36, %r40
%r42 = lshr i448 %r41, 64
%r44 = getelementptr i64, i64* %r3, i32 3
%r45 = load i64, i64* %r44
%r46 = call i384 @mulPv320x64(i64* %r2, i64 %r45)
%r47 = zext i384 %r46 to i448
%r48 = add i448 %r42, %r47
%r49 = trunc i448 %r48 to i64
%r50 = mul i64 %r49, %r7
%r51 = call i384 @mulPv320x64(i64* %r4, i64 %r50)
%r52 = zext i384 %r51 to i448
%r53 = add i448 %r48, %r52
%r54 = lshr i448 %r53, 64
%r56 = getelementptr i64, i64* %r3, i32 4
%r57 = load i64, i64* %r56
%r58 = call i384 @mulPv320x64(i64* %r2, i64 %r57)
%r59 = zext i384 %r58 to i448
%r60 = add i448 %r54, %r59
%r61 = trunc i448 %r60 to i64
%r62 = mul i64 %r61, %r7
%r63 = call i384 @mulPv320x64(i64* %r4, i64 %r62)
%r64 = zext i384 %r63 to i448
%r65 = add i448 %r60, %r64
%r66 = lshr i448 %r65, 64
%r67 = trunc i448 %r66 to i384
%r68 = load i64, i64* %r4
%r69 = zext i64 %r68 to i128
%r71 = getelementptr i64, i64* %r4, i32 1
%r72 = load i64, i64* %r71
%r73 = zext i64 %r72 to i128
%r74 = shl i128 %r73, 64
%r75 = or i128 %r69, %r74
%r76 = zext i128 %r75 to i192
%r78 = getelementptr i64, i64* %r4, i32 2
%r79 = load i64, i64* %r78
%r80 = zext i64 %r79 to i192
%r81 = shl i192 %r80, 128
%r82 = or i192 %r76, %r81
%r83 = zext i192 %r82 to i256
%r85 = getelementptr i64, i64* %r4, i32 3
%r86 = load i64, i64* %r85
%r87 = zext i64 %r86 to i256
%r88 = shl i256 %r87, 192
%r89 = or i256 %r83, %r88
%r90 = zext i256 %r89 to i320
%r92 = getelementptr i64, i64* %r4, i32 4
%r93 = load i64, i64* %r92
%r94 = zext i64 %r93 to i320
%r95 = shl i320 %r94, 256
%r96 = or i320 %r90, %r95
%r97 = zext i320 %r96 to i384
%r98 = sub i384 %r67, %r97
%r99 = lshr i384 %r98, 320
%r100 = trunc i384 %r99 to i1
%r101 = select i1 %r100, i384 %r67, i384 %r98
%r102 = trunc i384 %r101 to i320
%r103 = trunc i320 %r102 to i64
%r105 = getelementptr i64, i64* %r1, i32 0
store i64 %r103, i64* %r105
%r106 = lshr i320 %r102, 64
%r107 = trunc i320 %r106 to i64
%r109 = getelementptr i64, i64* %r1, i32 1
store i64 %r107, i64* %r109
%r110 = lshr i320 %r106, 64
%r111 = trunc i320 %r110 to i64
%r113 = getelementptr i64, i64* %r1, i32 2
store i64 %r111, i64* %r113
%r114 = lshr i320 %r110, 64
%r115 = trunc i320 %r114 to i64
%r117 = getelementptr i64, i64* %r1, i32 3
store i64 %r115, i64* %r117
%r118 = lshr i320 %r114, 64
%r119 = trunc i320 %r118 to i64
%r121 = getelementptr i64, i64* %r1, i32 4
store i64 %r119, i64* %r121
ret void
}
define void @mcl_fp_montNF5L(i64* %r1, i64* %r2, i64* %r3, i64* %r4)
{
%r6 = getelementptr i64, i64* %r4, i32 -1
%r7 = load i64, i64* %r6
%r8 = load i64, i64* %r3
%r9 = call i384 @mulPv320x64(i64* %r2, i64 %r8)
%r10 = trunc i384 %r9 to i64
%r11 = mul i64 %r10, %r7
%r12 = call i384 @mulPv320x64(i64* %r4, i64 %r11)
%r13 = add i384 %r9, %r12
%r14 = lshr i384 %r13, 64
%r16 = getelementptr i64, i64* %r3, i32 1
%r17 = load i64, i64* %r16
%r18 = call i384 @mulPv320x64(i64* %r2, i64 %r17)
%r19 = add i384 %r14, %r18
%r20 = trunc i384 %r19 to i64
%r21 = mul i64 %r20, %r7
%r22 = call i384 @mulPv320x64(i64* %r4, i64 %r21)
%r23 = add i384 %r19, %r22
%r24 = lshr i384 %r23, 64
%r26 = getelementptr i64, i64* %r3, i32 2
%r27 = load i64, i64* %r26
%r28 = call i384 @mulPv320x64(i64* %r2, i64 %r27)
%r29 = add i384 %r24, %r28
%r30 = trunc i384 %r29 to i64
%r31 = mul i64 %r30, %r7
%r32 = call i384 @mulPv320x64(i64* %r4, i64 %r31)
%r33 = add i384 %r29, %r32
%r34 = lshr i384 %r33, 64
%r36 = getelementptr i64, i64* %r3, i32 3
%r37 = load i64, i64* %r36
%r38 = call i384 @mulPv320x64(i64* %r2, i64 %r37)
%r39 = add i384 %r34, %r38
%r40 = trunc i384 %r39 to i64
%r41 = mul i64 %r40, %r7
%r42 = call i384 @mulPv320x64(i64* %r4, i64 %r41)
%r43 = add i384 %r39, %r42
%r44 = lshr i384 %r43, 64
%r46 = getelementptr i64, i64* %r3, i32 4
%r47 = load i64, i64* %r46
%r48 = call i384 @mulPv320x64(i64* %r2, i64 %r47)
%r49 = add i384 %r44, %r48
%r50 = trunc i384 %r49 to i64
%r51 = mul i64 %r50, %r7
%r52 = call i384 @mulPv320x64(i64* %r4, i64 %r51)
%r53 = add i384 %r49, %r52
%r54 = lshr i384 %r53, 64
%r55 = trunc i384 %r54 to i320
%r56 = load i64, i64* %r4
%r57 = zext i64 %r56 to i128
%r59 = getelementptr i64, i64* %r4, i32 1
%r60 = load i64, i64* %r59
%r61 = zext i64 %r60 to i128
%r62 = shl i128 %r61, 64
%r63 = or i128 %r57, %r62
%r64 = zext i128 %r63 to i192
%r66 = getelementptr i64, i64* %r4, i32 2
%r67 = load i64, i64* %r66
%r68 = zext i64 %r67 to i192
%r69 = shl i192 %r68, 128
%r70 = or i192 %r64, %r69
%r71 = zext i192 %r70 to i256
%r73 = getelementptr i64, i64* %r4, i32 3
%r74 = load i64, i64* %r73
%r75 = zext i64 %r74 to i256
%r76 = shl i256 %r75, 192
%r77 = or i256 %r71, %r76
%r78 = zext i256 %r77 to i320
%r80 = getelementptr i64, i64* %r4, i32 4
%r81 = load i64, i64* %r80
%r82 = zext i64 %r81 to i320
%r83 = shl i320 %r82, 256
%r84 = or i320 %r78, %r83
%r85 = sub i320 %r55, %r84
%r86 = lshr i320 %r85, 319
%r87 = trunc i320 %r86 to i1
%r88 = select i1 %r87, i320 %r55, i320 %r85
%r89 = trunc i320 %r88 to i64
%r91 = getelementptr i64, i64* %r1, i32 0
store i64 %r89, i64* %r91
%r92 = lshr i320 %r88, 64
%r93 = trunc i320 %r92 to i64
%r95 = getelementptr i64, i64* %r1, i32 1
store i64 %r93, i64* %r95
%r96 = lshr i320 %r92, 64
%r97 = trunc i320 %r96 to i64
%r99 = getelementptr i64, i64* %r1, i32 2
store i64 %r97, i64* %r99
%r100 = lshr i320 %r96, 64
%r101 = trunc i320 %r100 to i64
%r103 = getelementptr i64, i64* %r1, i32 3
store i64 %r101, i64* %r103
%r104 = lshr i320 %r100, 64
%r105 = trunc i320 %r104 to i64
%r107 = getelementptr i64, i64* %r1, i32 4
store i64 %r105, i64* %r107
ret void
}
define void @mcl_fp_montRed5L(i64* noalias  %r1, i64* noalias  %r2, i64* noalias  %r3)
{
%r5 = getelementptr i64, i64* %r3, i32 -1
%r6 = load i64, i64* %r5
%r7 = load i64, i64* %r3
%r8 = zext i64 %r7 to i128
%r10 = getelementptr i64, i64* %r3, i32 1
%r11 = load i64, i64* %r10
%r12 = zext i64 %r11 to i128
%r13 = shl i128 %r12, 64
%r14 = or i128 %r8, %r13
%r15 = zext i128 %r14 to i192
%r17 = getelementptr i64, i64* %r3, i32 2
%r18 = load i64, i64* %r17
%r19 = zext i64 %r18 to i192
%r20 = shl i192 %r19, 128
%r21 = or i192 %r15, %r20
%r22 = zext i192 %r21 to i256
%r24 = getelementptr i64, i64* %r3, i32 3
%r25 = load i64, i64* %r24
%r26 = zext i64 %r25 to i256
%r27 = shl i256 %r26, 192
%r28 = or i256 %r22, %r27
%r29 = zext i256 %r28 to i320
%r31 = getelementptr i64, i64* %r3, i32 4
%r32 = load i64, i64* %r31
%r33 = zext i64 %r32 to i320
%r34 = shl i320 %r33, 256
%r35 = or i320 %r29, %r34
%r36 = load i64, i64* %r2
%r37 = zext i64 %r36 to i128
%r39 = getelementptr i64, i64* %r2, i32 1
%r40 = load i64, i64* %r39
%r41 = zext i64 %r40 to i128
%r42 = shl i128 %r41, 64
%r43 = or i128 %r37, %r42
%r44 = zext i128 %r43 to i192
%r46 = getelementptr i64, i64* %r2, i32 2
%r47 = load i64, i64* %r46
%r48 = zext i64 %r47 to i192
%r49 = shl i192 %r48, 128
%r50 = or i192 %r44, %r49
%r51 = zext i192 %r50 to i256
%r53 = getelementptr i64, i64* %r2, i32 3
%r54 = load i64, i64* %r53
%r55 = zext i64 %r54 to i256
%r56 = shl i256 %r55, 192
%r57 = or i256 %r51, %r56
%r58 = zext i256 %r57 to i320
%r60 = getelementptr i64, i64* %r2, i32 4
%r61 = load i64, i64* %r60
%r62 = zext i64 %r61 to i320
%r63 = shl i320 %r62, 256
%r64 = or i320 %r58, %r63
%r65 = zext i320 %r64 to i384
%r67 = getelementptr i64, i64* %r2, i32 5
%r68 = load i64, i64* %r67
%r69 = zext i64 %r68 to i384
%r70 = shl i384 %r69, 320
%r71 = or i384 %r65, %r70
%r72 = zext i384 %r71 to i448
%r74 = getelementptr i64, i64* %r2, i32 6
%r75 = load i64, i64* %r74
%r76 = zext i64 %r75 to i448
%r77 = shl i448 %r76, 384
%r78 = or i448 %r72, %r77
%r79 = zext i448 %r78 to i512
%r81 = getelementptr i64, i64* %r2, i32 7
%r82 = load i64, i64* %r81
%r83 = zext i64 %r82 to i512
%r84 = shl i512 %r83, 448
%r85 = or i512 %r79, %r84
%r86 = zext i512 %r85 to i576
%r88 = getelementptr i64, i64* %r2, i32 8
%r89 = load i64, i64* %r88
%r90 = zext i64 %r89 to i576
%r91 = shl i576 %r90, 512
%r92 = or i576 %r86, %r91
%r93 = zext i576 %r92 to i640
%r95 = getelementptr i64, i64* %r2, i32 9
%r96 = load i64, i64* %r95
%r97 = zext i64 %r96 to i640
%r98 = shl i640 %r97, 576
%r99 = or i640 %r93, %r98
%r100 = zext i640 %r99 to i704
%r101 = trunc i704 %r100 to i64
%r102 = mul i64 %r101, %r6
%r103 = call i384 @mulPv320x64(i64* %r3, i64 %r102)
%r104 = zext i384 %r103 to i704
%r105 = add i704 %r100, %r104
%r106 = lshr i704 %r105, 64
%r107 = trunc i704 %r106 to i640
%r108 = trunc i640 %r107 to i64
%r109 = mul i64 %r108, %r6
%r110 = call i384 @mulPv320x64(i64* %r3, i64 %r109)
%r111 = zext i384 %r110 to i640
%r112 = add i640 %r107, %r111
%r113 = lshr i640 %r112, 64
%r114 = trunc i640 %r113 to i576
%r115 = trunc i576 %r114 to i64
%r116 = mul i64 %r115, %r6
%r117 = call i384 @mulPv320x64(i64* %r3, i64 %r116)
%r118 = zext i384 %r117 to i576
%r119 = add i576 %r114, %r118
%r120 = lshr i576 %r119, 64
%r121 = trunc i576 %r120 to i512
%r122 = trunc i512 %r121 to i64
%r123 = mul i64 %r122, %r6
%r124 = call i384 @mulPv320x64(i64* %r3, i64 %r123)
%r125 = zext i384 %r124 to i512
%r126 = add i512 %r121, %r125
%r127 = lshr i512 %r126, 64
%r128 = trunc i512 %r127 to i448
%r129 = trunc i448 %r128 to i64
%r130 = mul i64 %r129, %r6
%r131 = call i384 @mulPv320x64(i64* %r3, i64 %r130)
%r132 = zext i384 %r131 to i448
%r133 = add i448 %r128, %r132
%r134 = lshr i448 %r133, 64
%r135 = trunc i448 %r134 to i384
%r136 = zext i320 %r35 to i384
%r137 = sub i384 %r135, %r136
%r138 = lshr i384 %r137, 320
%r139 = trunc i384 %r138 to i1
%r140 = select i1 %r139, i384 %r135, i384 %r137
%r141 = trunc i384 %r140 to i320
%r142 = trunc i320 %r141 to i64
%r144 = getelementptr i64, i64* %r1, i32 0
store i64 %r142, i64* %r144
%r145 = lshr i320 %r141, 64
%r146 = trunc i320 %r145 to i64
%r148 = getelementptr i64, i64* %r1, i32 1
store i64 %r146, i64* %r148
%r149 = lshr i320 %r145, 64
%r150 = trunc i320 %r149 to i64
%r152 = getelementptr i64, i64* %r1, i32 2
store i64 %r150, i64* %r152
%r153 = lshr i320 %r149, 64
%r154 = trunc i320 %r153 to i64
%r156 = getelementptr i64, i64* %r1, i32 3
store i64 %r154, i64* %r156
%r157 = lshr i320 %r153, 64
%r158 = trunc i320 %r157 to i64
%r160 = getelementptr i64, i64* %r1, i32 4
store i64 %r158, i64* %r160
ret void
}
define i64 @mcl_fp_addPre5L(i64* noalias  %r2, i64* noalias  %r3, i64* noalias  %r4)
{
%r5 = load i64, i64* %r3
%r6 = zext i64 %r5 to i128
%r8 = getelementptr i64, i64* %r3, i32 1
%r9 = load i64, i64* %r8
%r10 = zext i64 %r9 to i128
%r11 = shl i128 %r10, 64
%r12 = or i128 %r6, %r11
%r13 = zext i128 %r12 to i192
%r15 = getelementptr i64, i64* %r3, i32 2
%r16 = load i64, i64* %r15
%r17 = zext i64 %r16 to i192
%r18 = shl i192 %r17, 128
%r19 = or i192 %r13, %r18
%r20 = zext i192 %r19 to i256
%r22 = getelementptr i64, i64* %r3, i32 3
%r23 = load i64, i64* %r22
%r24 = zext i64 %r23 to i256
%r25 = shl i256 %r24, 192
%r26 = or i256 %r20, %r25
%r27 = zext i256 %r26 to i320
%r29 = getelementptr i64, i64* %r3, i32 4
%r30 = load i64, i64* %r29
%r31 = zext i64 %r30 to i320
%r32 = shl i320 %r31, 256
%r33 = or i320 %r27, %r32
%r34 = zext i320 %r33 to i384
%r35 = load i64, i64* %r4
%r36 = zext i64 %r35 to i128
%r38 = getelementptr i64, i64* %r4, i32 1
%r39 = load i64, i64* %r38
%r40 = zext i64 %r39 to i128
%r41 = shl i128 %r40, 64
%r42 = or i128 %r36, %r41
%r43 = zext i128 %r42 to i192
%r45 = getelementptr i64, i64* %r4, i32 2
%r46 = load i64, i64* %r45
%r47 = zext i64 %r46 to i192
%r48 = shl i192 %r47, 128
%r49 = or i192 %r43, %r48
%r50 = zext i192 %r49 to i256
%r52 = getelementptr i64, i64* %r4, i32 3
%r53 = load i64, i64* %r52
%r54 = zext i64 %r53 to i256
%r55 = shl i256 %r54, 192
%r56 = or i256 %r50, %r55
%r57 = zext i256 %r56 to i320
%r59 = getelementptr i64, i64* %r4, i32 4
%r60 = load i64, i64* %r59
%r61 = zext i64 %r60 to i320
%r62 = shl i320 %r61, 256
%r63 = or i320 %r57, %r62
%r64 = zext i320 %r63 to i384
%r65 = add i384 %r34, %r64
%r66 = trunc i384 %r65 to i320
%r67 = trunc i320 %r66 to i64
%r69 = getelementptr i64, i64* %r2, i32 0
store i64 %r67, i64* %r69
%r70 = lshr i320 %r66, 64
%r71 = trunc i320 %r70 to i64
%r73 = getelementptr i64, i64* %r2, i32 1
store i64 %r71, i64* %r73
%r74 = lshr i320 %r70, 64
%r75 = trunc i320 %r74 to i64
%r77 = getelementptr i64, i64* %r2, i32 2
store i64 %r75, i64* %r77
%r78 = lshr i320 %r74, 64
%r79 = trunc i320 %r78 to i64
%r81 = getelementptr i64, i64* %r2, i32 3
store i64 %r79, i64* %r81
%r82 = lshr i320 %r78, 64
%r83 = trunc i320 %r82 to i64
%r85 = getelementptr i64, i64* %r2, i32 4
store i64 %r83, i64* %r85
%r86 = lshr i384 %r65, 320
%r87 = trunc i384 %r86 to i64
ret i64 %r87
}
define i64 @mcl_fp_subPre5L(i64* noalias  %r2, i64* noalias  %r3, i64* noalias  %r4)
{
%r5 = load i64, i64* %r3
%r6 = zext i64 %r5 to i128
%r8 = getelementptr i64, i64* %r3, i32 1
%r9 = load i64, i64* %r8
%r10 = zext i64 %r9 to i128
%r11 = shl i128 %r10, 64
%r12 = or i128 %r6, %r11
%r13 = zext i128 %r12 to i192
%r15 = getelementptr i64, i64* %r3, i32 2
%r16 = load i64, i64* %r15
%r17 = zext i64 %r16 to i192
%r18 = shl i192 %r17, 128
%r19 = or i192 %r13, %r18
%r20 = zext i192 %r19 to i256
%r22 = getelementptr i64, i64* %r3, i32 3
%r23 = load i64, i64* %r22
%r24 = zext i64 %r23 to i256
%r25 = shl i256 %r24, 192
%r26 = or i256 %r20, %r25
%r27 = zext i256 %r26 to i320
%r29 = getelementptr i64, i64* %r3, i32 4
%r30 = load i64, i64* %r29
%r31 = zext i64 %r30 to i320
%r32 = shl i320 %r31, 256
%r33 = or i320 %r27, %r32
%r34 = zext i320 %r33 to i384
%r35 = load i64, i64* %r4
%r36 = zext i64 %r35 to i128
%r38 = getelementptr i64, i64* %r4, i32 1
%r39 = load i64, i64* %r38
%r40 = zext i64 %r39 to i128
%r41 = shl i128 %r40, 64
%r42 = or i128 %r36, %r41
%r43 = zext i128 %r42 to i192
%r45 = getelementptr i64, i64* %r4, i32 2
%r46 = load i64, i64* %r45
%r47 = zext i64 %r46 to i192
%r48 = shl i192 %r47, 128
%r49 = or i192 %r43, %r48
%r50 = zext i192 %r49 to i256
%r52 = getelementptr i64, i64* %r4, i32 3
%r53 = load i64, i64* %r52
%r54 = zext i64 %r53 to i256
%r55 = shl i256 %r54, 192
%r56 = or i256 %r50, %r55
%r57 = zext i256 %r56 to i320
%r59 = getelementptr i64, i64* %r4, i32 4
%r60 = load i64, i64* %r59
%r61 = zext i64 %r60 to i320
%r62 = shl i320 %r61, 256
%r63 = or i320 %r57, %r62
%r64 = zext i320 %r63 to i384
%r65 = sub i384 %r34, %r64
%r66 = trunc i384 %r65 to i320
%r67 = trunc i320 %r66 to i64
%r69 = getelementptr i64, i64* %r2, i32 0
store i64 %r67, i64* %r69
%r70 = lshr i320 %r66, 64
%r71 = trunc i320 %r70 to i64
%r73 = getelementptr i64, i64* %r2, i32 1
store i64 %r71, i64* %r73
%r74 = lshr i320 %r70, 64
%r75 = trunc i320 %r74 to i64
%r77 = getelementptr i64, i64* %r2, i32 2
store i64 %r75, i64* %r77
%r78 = lshr i320 %r74, 64
%r79 = trunc i320 %r78 to i64
%r81 = getelementptr i64, i64* %r2, i32 3
store i64 %r79, i64* %r81
%r82 = lshr i320 %r78, 64
%r83 = trunc i320 %r82 to i64
%r85 = getelementptr i64, i64* %r2, i32 4
store i64 %r83, i64* %r85
%r86 = lshr i384 %r65, 320
%r87 = trunc i384 %r86 to i64
%r89 = and i64 %r87, 1
ret i64 %r89
}
define void @mcl_fp_shr1_5L(i64* noalias  %r1, i64* noalias  %r2)
{
%r3 = load i64, i64* %r2
%r4 = zext i64 %r3 to i128
%r6 = getelementptr i64, i64* %r2, i32 1
%r7 = load i64, i64* %r6
%r8 = zext i64 %r7 to i128
%r9 = shl i128 %r8, 64
%r10 = or i128 %r4, %r9
%r11 = zext i128 %r10 to i192
%r13 = getelementptr i64, i64* %r2, i32 2
%r14 = load i64, i64* %r13
%r15 = zext i64 %r14 to i192
%r16 = shl i192 %r15, 128
%r17 = or i192 %r11, %r16
%r18 = zext i192 %r17 to i256
%r20 = getelementptr i64, i64* %r2, i32 3
%r21 = load i64, i64* %r20
%r22 = zext i64 %r21 to i256
%r23 = shl i256 %r22, 192
%r24 = or i256 %r18, %r23
%r25 = zext i256 %r24 to i320
%r27 = getelementptr i64, i64* %r2, i32 4
%r28 = load i64, i64* %r27
%r29 = zext i64 %r28 to i320
%r30 = shl i320 %r29, 256
%r31 = or i320 %r25, %r30
%r32 = lshr i320 %r31, 1
%r33 = trunc i320 %r32 to i64
%r35 = getelementptr i64, i64* %r1, i32 0
store i64 %r33, i64* %r35
%r36 = lshr i320 %r32, 64
%r37 = trunc i320 %r36 to i64
%r39 = getelementptr i64, i64* %r1, i32 1
store i64 %r37, i64* %r39
%r40 = lshr i320 %r36, 64
%r41 = trunc i320 %r40 to i64
%r43 = getelementptr i64, i64* %r1, i32 2
store i64 %r41, i64* %r43
%r44 = lshr i320 %r40, 64
%r45 = trunc i320 %r44 to i64
%r47 = getelementptr i64, i64* %r1, i32 3
store i64 %r45, i64* %r47
%r48 = lshr i320 %r44, 64
%r49 = trunc i320 %r48 to i64
%r51 = getelementptr i64, i64* %r1, i32 4
store i64 %r49, i64* %r51
ret void
}
define void @mcl_fp_add5L(i64* noalias  %r1, i64* noalias  %r2, i64* noalias  %r3, i64* noalias  %r4)
{
%r5 = load i64, i64* %r2
%r6 = zext i64 %r5 to i128
%r8 = getelementptr i64, i64* %r2, i32 1
%r9 = load i64, i64* %r8
%r10 = zext i64 %r9 to i128
%r11 = shl i128 %r10, 64
%r12 = or i128 %r6, %r11
%r13 = zext i128 %r12 to i192
%r15 = getelementptr i64, i64* %r2, i32 2
%r16 = load i64, i64* %r15
%r17 = zext i64 %r16 to i192
%r18 = shl i192 %r17, 128
%r19 = or i192 %r13, %r18
%r20 = zext i192 %r19 to i256
%r22 = getelementptr i64, i64* %r2, i32 3
%r23 = load i64, i64* %r22
%r24 = zext i64 %r23 to i256
%r25 = shl i256 %r24, 192
%r26 = or i256 %r20, %r25
%r27 = zext i256 %r26 to i320
%r29 = getelementptr i64, i64* %r2, i32 4
%r30 = load i64, i64* %r29
%r31 = zext i64 %r30 to i320
%r32 = shl i320 %r31, 256
%r33 = or i320 %r27, %r32
%r34 = load i64, i64* %r3
%r35 = zext i64 %r34 to i128
%r37 = getelementptr i64, i64* %r3, i32 1
%r38 = load i64, i64* %r37
%r39 = zext i64 %r38 to i128
%r40 = shl i128 %r39, 64
%r41 = or i128 %r35, %r40
%r42 = zext i128 %r41 to i192
%r44 = getelementptr i64, i64* %r3, i32 2
%r45 = load i64, i64* %r44
%r46 = zext i64 %r45 to i192
%r47 = shl i192 %r46, 128
%r48 = or i192 %r42, %r47
%r49 = zext i192 %r48 to i256
%r51 = getelementptr i64, i64* %r3, i32 3
%r52 = load i64, i64* %r51
%r53 = zext i64 %r52 to i256
%r54 = shl i256 %r53, 192
%r55 = or i256 %r49, %r54
%r56 = zext i256 %r55 to i320
%r58 = getelementptr i64, i64* %r3, i32 4
%r59 = load i64, i64* %r58
%r60 = zext i64 %r59 to i320
%r61 = shl i320 %r60, 256
%r62 = or i320 %r56, %r61
%r63 = zext i320 %r33 to i384
%r64 = zext i320 %r62 to i384
%r65 = add i384 %r63, %r64
%r66 = trunc i384 %r65 to i320
%r67 = trunc i320 %r66 to i64
%r69 = getelementptr i64, i64* %r1, i32 0
store i64 %r67, i64* %r69
%r70 = lshr i320 %r66, 64
%r71 = trunc i320 %r70 to i64
%r73 = getelementptr i64, i64* %r1, i32 1
store i64 %r71, i64* %r73
%r74 = lshr i320 %r70, 64
%r75 = trunc i320 %r74 to i64
%r77 = getelementptr i64, i64* %r1, i32 2
store i64 %r75, i64* %r77
%r78 = lshr i320 %r74, 64
%r79 = trunc i320 %r78 to i64
%r81 = getelementptr i64, i64* %r1, i32 3
store i64 %r79, i64* %r81
%r82 = lshr i320 %r78, 64
%r83 = trunc i320 %r82 to i64
%r85 = getelementptr i64, i64* %r1, i32 4
store i64 %r83, i64* %r85
%r86 = load i64, i64* %r4
%r87 = zext i64 %r86 to i128
%r89 = getelementptr i64, i64* %r4, i32 1
%r90 = load i64, i64* %r89
%r91 = zext i64 %r90 to i128
%r92 = shl i128 %r91, 64
%r93 = or i128 %r87, %r92
%r94 = zext i128 %r93 to i192
%r96 = getelementptr i64, i64* %r4, i32 2
%r97 = load i64, i64* %r96
%r98 = zext i64 %r97 to i192
%r99 = shl i192 %r98, 128
%r100 = or i192 %r94, %r99
%r101 = zext i192 %r100 to i256
%r103 = getelementptr i64, i64* %r4, i32 3
%r104 = load i64, i64* %r103
%r105 = zext i64 %r104 to i256
%r106 = shl i256 %r105, 192
%r107 = or i256 %r101, %r106
%r108 = zext i256 %r107 to i320
%r110 = getelementptr i64, i64* %r4, i32 4
%r111 = load i64, i64* %r110
%r112 = zext i64 %r111 to i320
%r113 = shl i320 %r112, 256
%r114 = or i320 %r108, %r113
%r115 = zext i320 %r114 to i384
%r116 = sub i384 %r65, %r115
%r117 = lshr i384 %r116, 320
%r118 = trunc i384 %r117 to i1
br i1%r118, label %carry, label %nocarry
nocarry:
%r119 = trunc i384 %r116 to i320
%r120 = trunc i320 %r119 to i64
%r122 = getelementptr i64, i64* %r1, i32 0
store i64 %r120, i64* %r122
%r123 = lshr i320 %r119, 64
%r124 = trunc i320 %r123 to i64
%r126 = getelementptr i64, i64* %r1, i32 1
store i64 %r124, i64* %r126
%r127 = lshr i320 %r123, 64
%r128 = trunc i320 %r127 to i64
%r130 = getelementptr i64, i64* %r1, i32 2
store i64 %r128, i64* %r130
%r131 = lshr i320 %r127, 64
%r132 = trunc i320 %r131 to i64
%r134 = getelementptr i64, i64* %r1, i32 3
store i64 %r132, i64* %r134
%r135 = lshr i320 %r131, 64
%r136 = trunc i320 %r135 to i64
%r138 = getelementptr i64, i64* %r1, i32 4
store i64 %r136, i64* %r138
ret void
carry:
ret void
}
define void @mcl_fp_addNF5L(i64* noalias  %r1, i64* noalias  %r2, i64* noalias  %r3, i64* noalias  %r4)
{
%r5 = load i64, i64* %r2
%r6 = zext i64 %r5 to i128
%r8 = getelementptr i64, i64* %r2, i32 1
%r9 = load i64, i64* %r8
%r10 = zext i64 %r9 to i128
%r11 = shl i128 %r10, 64
%r12 = or i128 %r6, %r11
%r13 = zext i128 %r12 to i192
%r15 = getelementptr i64, i64* %r2, i32 2
%r16 = load i64, i64* %r15
%r17 = zext i64 %r16 to i192
%r18 = shl i192 %r17, 128
%r19 = or i192 %r13, %r18
%r20 = zext i192 %r19 to i256
%r22 = getelementptr i64, i64* %r2, i32 3
%r23 = load i64, i64* %r22
%r24 = zext i64 %r23 to i256
%r25 = shl i256 %r24, 192
%r26 = or i256 %r20, %r25
%r27 = zext i256 %r26 to i320
%r29 = getelementptr i64, i64* %r2, i32 4
%r30 = load i64, i64* %r29
%r31 = zext i64 %r30 to i320
%r32 = shl i320 %r31, 256
%r33 = or i320 %r27, %r32
%r34 = load i64, i64* %r3
%r35 = zext i64 %r34 to i128
%r37 = getelementptr i64, i64* %r3, i32 1
%r38 = load i64, i64* %r37
%r39 = zext i64 %r38 to i128
%r40 = shl i128 %r39, 64
%r41 = or i128 %r35, %r40
%r42 = zext i128 %r41 to i192
%r44 = getelementptr i64, i64* %r3, i32 2
%r45 = load i64, i64* %r44
%r46 = zext i64 %r45 to i192
%r47 = shl i192 %r46, 128
%r48 = or i192 %r42, %r47
%r49 = zext i192 %r48 to i256
%r51 = getelementptr i64, i64* %r3, i32 3
%r52 = load i64, i64* %r51
%r53 = zext i64 %r52 to i256
%r54 = shl i256 %r53, 192
%r55 = or i256 %r49, %r54
%r56 = zext i256 %r55 to i320
%r58 = getelementptr i64, i64* %r3, i32 4
%r59 = load i64, i64* %r58
%r60 = zext i64 %r59 to i320
%r61 = shl i320 %r60, 256
%r62 = or i320 %r56, %r61
%r63 = add i320 %r33, %r62
%r64 = load i64, i64* %r4
%r65 = zext i64 %r64 to i128
%r67 = getelementptr i64, i64* %r4, i32 1
%r68 = load i64, i64* %r67
%r69 = zext i64 %r68 to i128
%r70 = shl i128 %r69, 64
%r71 = or i128 %r65, %r70
%r72 = zext i128 %r71 to i192
%r74 = getelementptr i64, i64* %r4, i32 2
%r75 = load i64, i64* %r74
%r76 = zext i64 %r75 to i192
%r77 = shl i192 %r76, 128
%r78 = or i192 %r72, %r77
%r79 = zext i192 %r78 to i256
%r81 = getelementptr i64, i64* %r4, i32 3
%r82 = load i64, i64* %r81
%r83 = zext i64 %r82 to i256
%r84 = shl i256 %r83, 192
%r85 = or i256 %r79, %r84
%r86 = zext i256 %r85 to i320
%r88 = getelementptr i64, i64* %r4, i32 4
%r89 = load i64, i64* %r88
%r90 = zext i64 %r89 to i320
%r91 = shl i320 %r90, 256
%r92 = or i320 %r86, %r91
%r93 = sub i320 %r63, %r92
%r94 = lshr i320 %r93, 319
%r95 = trunc i320 %r94 to i1
%r96 = select i1 %r95, i320 %r63, i320 %r93
%r97 = trunc i320 %r96 to i64
%r99 = getelementptr i64, i64* %r1, i32 0
store i64 %r97, i64* %r99
%r100 = lshr i320 %r96, 64
%r101 = trunc i320 %r100 to i64
%r103 = getelementptr i64, i64* %r1, i32 1
store i64 %r101, i64* %r103
%r104 = lshr i320 %r100, 64
%r105 = trunc i320 %r104 to i64
%r107 = getelementptr i64, i64* %r1, i32 2
store i64 %r105, i64* %r107
%r108 = lshr i320 %r104, 64
%r109 = trunc i320 %r108 to i64
%r111 = getelementptr i64, i64* %r1, i32 3
store i64 %r109, i64* %r111
%r112 = lshr i320 %r108, 64
%r113 = trunc i320 %r112 to i64
%r115 = getelementptr i64, i64* %r1, i32 4
store i64 %r113, i64* %r115
ret void
}
define void @mcl_fp_sub5L(i64* noalias  %r1, i64* noalias  %r2, i64* noalias  %r3, i64* noalias  %r4)
{
%r5 = load i64, i64* %r2
%r6 = zext i64 %r5 to i128
%r8 = getelementptr i64, i64* %r2, i32 1
%r9 = load i64, i64* %r8
%r10 = zext i64 %r9 to i128
%r11 = shl i128 %r10, 64
%r12 = or i128 %r6, %r11
%r13 = zext i128 %r12 to i192
%r15 = getelementptr i64, i64* %r2, i32 2
%r16 = load i64, i64* %r15
%r17 = zext i64 %r16 to i192
%r18 = shl i192 %r17, 128
%r19 = or i192 %r13, %r18
%r20 = zext i192 %r19 to i256
%r22 = getelementptr i64, i64* %r2, i32 3
%r23 = load i64, i64* %r22
%r24 = zext i64 %r23 to i256
%r25 = shl i256 %r24, 192
%r26 = or i256 %r20, %r25
%r27 = zext i256 %r26 to i320
%r29 = getelementptr i64, i64* %r2, i32 4
%r30 = load i64, i64* %r29
%r31 = zext i64 %r30 to i320
%r32 = shl i320 %r31, 256
%r33 = or i320 %r27, %r32
%r34 = load i64, i64* %r3
%r35 = zext i64 %r34 to i128
%r37 = getelementptr i64, i64* %r3, i32 1
%r38 = load i64, i64* %r37
%r39 = zext i64 %r38 to i128
%r40 = shl i128 %r39, 64
%r41 = or i128 %r35, %r40
%r42 = zext i128 %r41 to i192
%r44 = getelementptr i64, i64* %r3, i32 2
%r45 = load i64, i64* %r44
%r46 = zext i64 %r45 to i192
%r47 = shl i192 %r46, 128
%r48 = or i192 %r42, %r47
%r49 = zext i192 %r48 to i256
%r51 = getelementptr i64, i64* %r3, i32 3
%r52 = load i64, i64* %r51
%r53 = zext i64 %r52 to i256
%r54 = shl i256 %r53, 192
%r55 = or i256 %r49, %r54
%r56 = zext i256 %r55 to i320
%r58 = getelementptr i64, i64* %r3, i32 4
%r59 = load i64, i64* %r58
%r60 = zext i64 %r59 to i320
%r61 = shl i320 %r60, 256
%r62 = or i320 %r56, %r61
%r63 = zext i320 %r33 to i384
%r64 = zext i320 %r62 to i384
%r65 = sub i384 %r63, %r64
%r66 = trunc i384 %r65 to i320
%r67 = lshr i384 %r65, 320
%r68 = trunc i384 %r67 to i1
%r69 = trunc i320 %r66 to i64
%r71 = getelementptr i64, i64* %r1, i32 0
store i64 %r69, i64* %r71
%r72 = lshr i320 %r66, 64
%r73 = trunc i320 %r72 to i64
%r75 = getelementptr i64, i64* %r1, i32 1
store i64 %r73, i64* %r75
%r76 = lshr i320 %r72, 64
%r77 = trunc i320 %r76 to i64
%r79 = getelementptr i64, i64* %r1, i32 2
store i64 %r77, i64* %r79
%r80 = lshr i320 %r76, 64
%r81 = trunc i320 %r80 to i64
%r83 = getelementptr i64, i64* %r1, i32 3
store i64 %r81, i64* %r83
%r84 = lshr i320 %r80, 64
%r85 = trunc i320 %r84 to i64
%r87 = getelementptr i64, i64* %r1, i32 4
store i64 %r85, i64* %r87
br i1%r68, label %carry, label %nocarry
nocarry:
ret void
carry:
%r88 = load i64, i64* %r4
%r89 = zext i64 %r88 to i128
%r91 = getelementptr i64, i64* %r4, i32 1
%r92 = load i64, i64* %r91
%r93 = zext i64 %r92 to i128
%r94 = shl i128 %r93, 64
%r95 = or i128 %r89, %r94
%r96 = zext i128 %r95 to i192
%r98 = getelementptr i64, i64* %r4, i32 2
%r99 = load i64, i64* %r98
%r100 = zext i64 %r99 to i192
%r101 = shl i192 %r100, 128
%r102 = or i192 %r96, %r101
%r103 = zext i192 %r102 to i256
%r105 = getelementptr i64, i64* %r4, i32 3
%r106 = load i64, i64* %r105
%r107 = zext i64 %r106 to i256
%r108 = shl i256 %r107, 192
%r109 = or i256 %r103, %r108
%r110 = zext i256 %r109 to i320
%r112 = getelementptr i64, i64* %r4, i32 4
%r113 = load i64, i64* %r112
%r114 = zext i64 %r113 to i320
%r115 = shl i320 %r114, 256
%r116 = or i320 %r110, %r115
%r117 = add i320 %r66, %r116
%r118 = trunc i320 %r117 to i64
%r120 = getelementptr i64, i64* %r1, i32 0
store i64 %r118, i64* %r120
%r121 = lshr i320 %r117, 64
%r122 = trunc i320 %r121 to i64
%r124 = getelementptr i64, i64* %r1, i32 1
store i64 %r122, i64* %r124
%r125 = lshr i320 %r121, 64
%r126 = trunc i320 %r125 to i64
%r128 = getelementptr i64, i64* %r1, i32 2
store i64 %r126, i64* %r128
%r129 = lshr i320 %r125, 64
%r130 = trunc i320 %r129 to i64
%r132 = getelementptr i64, i64* %r1, i32 3
store i64 %r130, i64* %r132
%r133 = lshr i320 %r129, 64
%r134 = trunc i320 %r133 to i64
%r136 = getelementptr i64, i64* %r1, i32 4
store i64 %r134, i64* %r136
ret void
}
define void @mcl_fp_subNF5L(i64* noalias  %r1, i64* noalias  %r2, i64* noalias  %r3, i64* noalias  %r4)
{
%r5 = load i64, i64* %r2
%r6 = zext i64 %r5 to i128
%r8 = getelementptr i64, i64* %r2, i32 1
%r9 = load i64, i64* %r8
%r10 = zext i64 %r9 to i128
%r11 = shl i128 %r10, 64
%r12 = or i128 %r6, %r11
%r13 = zext i128 %r12 to i192
%r15 = getelementptr i64, i64* %r2, i32 2
%r16 = load i64, i64* %r15
%r17 = zext i64 %r16 to i192
%r18 = shl i192 %r17, 128
%r19 = or i192 %r13, %r18
%r20 = zext i192 %r19 to i256
%r22 = getelementptr i64, i64* %r2, i32 3
%r23 = load i64, i64* %r22
%r24 = zext i64 %r23 to i256
%r25 = shl i256 %r24, 192
%r26 = or i256 %r20, %r25
%r27 = zext i256 %r26 to i320
%r29 = getelementptr i64, i64* %r2, i32 4
%r30 = load i64, i64* %r29
%r31 = zext i64 %r30 to i320
%r32 = shl i320 %r31, 256
%r33 = or i320 %r27, %r32
%r34 = load i64, i64* %r3
%r35 = zext i64 %r34 to i128
%r37 = getelementptr i64, i64* %r3, i32 1
%r38 = load i64, i64* %r37
%r39 = zext i64 %r38 to i128
%r40 = shl i128 %r39, 64
%r41 = or i128 %r35, %r40
%r42 = zext i128 %r41 to i192
%r44 = getelementptr i64, i64* %r3, i32 2
%r45 = load i64, i64* %r44
%r46 = zext i64 %r45 to i192
%r47 = shl i192 %r46, 128
%r48 = or i192 %r42, %r47
%r49 = zext i192 %r48 to i256
%r51 = getelementptr i64, i64* %r3, i32 3
%r52 = load i64, i64* %r51
%r53 = zext i64 %r52 to i256
%r54 = shl i256 %r53, 192
%r55 = or i256 %r49, %r54
%r56 = zext i256 %r55 to i320
%r58 = getelementptr i64, i64* %r3, i32 4
%r59 = load i64, i64* %r58
%r60 = zext i64 %r59 to i320
%r61 = shl i320 %r60, 256
%r62 = or i320 %r56, %r61
%r63 = sub i320 %r33, %r62
%r64 = lshr i320 %r63, 319
%r65 = trunc i320 %r64 to i1
%r66 = load i64, i64* %r4
%r67 = zext i64 %r66 to i128
%r69 = getelementptr i64, i64* %r4, i32 1
%r70 = load i64, i64* %r69
%r71 = zext i64 %r70 to i128
%r72 = shl i128 %r71, 64
%r73 = or i128 %r67, %r72
%r74 = zext i128 %r73 to i192
%r76 = getelementptr i64, i64* %r4, i32 2
%r77 = load i64, i64* %r76
%r78 = zext i64 %r77 to i192
%r79 = shl i192 %r78, 128
%r80 = or i192 %r74, %r79
%r81 = zext i192 %r80 to i256
%r83 = getelementptr i64, i64* %r4, i32 3
%r84 = load i64, i64* %r83
%r85 = zext i64 %r84 to i256
%r86 = shl i256 %r85, 192
%r87 = or i256 %r81, %r86
%r88 = zext i256 %r87 to i320
%r90 = getelementptr i64, i64* %r4, i32 4
%r91 = load i64, i64* %r90
%r92 = zext i64 %r91 to i320
%r93 = shl i320 %r92, 256
%r94 = or i320 %r88, %r93
%r96 = select i1 %r65, i320 %r94, i320 0
%r97 = add i320 %r63, %r96
%r98 = trunc i320 %r97 to i64
%r100 = getelementptr i64, i64* %r1, i32 0
store i64 %r98, i64* %r100
%r101 = lshr i320 %r97, 64
%r102 = trunc i320 %r101 to i64
%r104 = getelementptr i64, i64* %r1, i32 1
store i64 %r102, i64* %r104
%r105 = lshr i320 %r101, 64
%r106 = trunc i320 %r105 to i64
%r108 = getelementptr i64, i64* %r1, i32 2
store i64 %r106, i64* %r108
%r109 = lshr i320 %r105, 64
%r110 = trunc i320 %r109 to i64
%r112 = getelementptr i64, i64* %r1, i32 3
store i64 %r110, i64* %r112
%r113 = lshr i320 %r109, 64
%r114 = trunc i320 %r113 to i64
%r116 = getelementptr i64, i64* %r1, i32 4
store i64 %r114, i64* %r116
ret void
}
define void @mcl_fpDbl_add5L(i64* noalias  %r1, i64* noalias  %r2, i64* noalias  %r3, i64* noalias  %r4)
{
%r5 = load i64, i64* %r2
%r6 = zext i64 %r5 to i128
%r8 = getelementptr i64, i64* %r2, i32 1
%r9 = load i64, i64* %r8
%r10 = zext i64 %r9 to i128
%r11 = shl i128 %r10, 64
%r12 = or i128 %r6, %r11
%r13 = zext i128 %r12 to i192
%r15 = getelementptr i64, i64* %r2, i32 2
%r16 = load i64, i64* %r15
%r17 = zext i64 %r16 to i192
%r18 = shl i192 %r17, 128
%r19 = or i192 %r13, %r18
%r20 = zext i192 %r19 to i256
%r22 = getelementptr i64, i64* %r2, i32 3
%r23 = load i64, i64* %r22
%r24 = zext i64 %r23 to i256
%r25 = shl i256 %r24, 192
%r26 = or i256 %r20, %r25
%r27 = zext i256 %r26 to i320
%r29 = getelementptr i64, i64* %r2, i32 4
%r30 = load i64, i64* %r29
%r31 = zext i64 %r30 to i320
%r32 = shl i320 %r31, 256
%r33 = or i320 %r27, %r32
%r34 = zext i320 %r33 to i384
%r36 = getelementptr i64, i64* %r2, i32 5
%r37 = load i64, i64* %r36
%r38 = zext i64 %r37 to i384
%r39 = shl i384 %r38, 320
%r40 = or i384 %r34, %r39
%r41 = zext i384 %r40 to i448
%r43 = getelementptr i64, i64* %r2, i32 6
%r44 = load i64, i64* %r43
%r45 = zext i64 %r44 to i448
%r46 = shl i448 %r45, 384
%r47 = or i448 %r41, %r46
%r48 = zext i448 %r47 to i512
%r50 = getelementptr i64, i64* %r2, i32 7
%r51 = load i64, i64* %r50
%r52 = zext i64 %r51 to i512
%r53 = shl i512 %r52, 448
%r54 = or i512 %r48, %r53
%r55 = zext i512 %r54 to i576
%r57 = getelementptr i64, i64* %r2, i32 8
%r58 = load i64, i64* %r57
%r59 = zext i64 %r58 to i576
%r60 = shl i576 %r59, 512
%r61 = or i576 %r55, %r60
%r62 = zext i576 %r61 to i640
%r64 = getelementptr i64, i64* %r2, i32 9
%r65 = load i64, i64* %r64
%r66 = zext i64 %r65 to i640
%r67 = shl i640 %r66, 576
%r68 = or i640 %r62, %r67
%r69 = load i64, i64* %r3
%r70 = zext i64 %r69 to i128
%r72 = getelementptr i64, i64* %r3, i32 1
%r73 = load i64, i64* %r72
%r74 = zext i64 %r73 to i128
%r75 = shl i128 %r74, 64
%r76 = or i128 %r70, %r75
%r77 = zext i128 %r76 to i192
%r79 = getelementptr i64, i64* %r3, i32 2
%r80 = load i64, i64* %r79
%r81 = zext i64 %r80 to i192
%r82 = shl i192 %r81, 128
%r83 = or i192 %r77, %r82
%r84 = zext i192 %r83 to i256
%r86 = getelementptr i64, i64* %r3, i32 3
%r87 = load i64, i64* %r86
%r88 = zext i64 %r87 to i256
%r89 = shl i256 %r88, 192
%r90 = or i256 %r84, %r89
%r91 = zext i256 %r90 to i320
%r93 = getelementptr i64, i64* %r3, i32 4
%r94 = load i64, i64* %r93
%r95 = zext i64 %r94 to i320
%r96 = shl i320 %r95, 256
%r97 = or i320 %r91, %r96
%r98 = zext i320 %r97 to i384
%r100 = getelementptr i64, i64* %r3, i32 5
%r101 = load i64, i64* %r100
%r102 = zext i64 %r101 to i384
%r103 = shl i384 %r102, 320
%r104 = or i384 %r98, %r103
%r105 = zext i384 %r104 to i448
%r107 = getelementptr i64, i64* %r3, i32 6
%r108 = load i64, i64* %r107
%r109 = zext i64 %r108 to i448
%r110 = shl i448 %r109, 384
%r111 = or i448 %r105, %r110
%r112 = zext i448 %r111 to i512
%r114 = getelementptr i64, i64* %r3, i32 7
%r115 = load i64, i64* %r114
%r116 = zext i64 %r115 to i512
%r117 = shl i512 %r116, 448
%r118 = or i512 %r112, %r117
%r119 = zext i512 %r118 to i576
%r121 = getelementptr i64, i64* %r3, i32 8
%r122 = load i64, i64* %r121
%r123 = zext i64 %r122 to i576
%r124 = shl i576 %r123, 512
%r125 = or i576 %r119, %r124
%r126 = zext i576 %r125 to i640
%r128 = getelementptr i64, i64* %r3, i32 9
%r129 = load i64, i64* %r128
%r130 = zext i64 %r129 to i640
%r131 = shl i640 %r130, 576
%r132 = or i640 %r126, %r131
%r133 = zext i640 %r68 to i704
%r134 = zext i640 %r132 to i704
%r135 = add i704 %r133, %r134
%r136 = trunc i704 %r135 to i320
%r137 = trunc i320 %r136 to i64
%r139 = getelementptr i64, i64* %r1, i32 0
store i64 %r137, i64* %r139
%r140 = lshr i320 %r136, 64
%r141 = trunc i320 %r140 to i64
%r143 = getelementptr i64, i64* %r1, i32 1
store i64 %r141, i64* %r143
%r144 = lshr i320 %r140, 64
%r145 = trunc i320 %r144 to i64
%r147 = getelementptr i64, i64* %r1, i32 2
store i64 %r145, i64* %r147
%r148 = lshr i320 %r144, 64
%r149 = trunc i320 %r148 to i64
%r151 = getelementptr i64, i64* %r1, i32 3
store i64 %r149, i64* %r151
%r152 = lshr i320 %r148, 64
%r153 = trunc i320 %r152 to i64
%r155 = getelementptr i64, i64* %r1, i32 4
store i64 %r153, i64* %r155
%r156 = lshr i704 %r135, 320
%r157 = trunc i704 %r156 to i384
%r158 = load i64, i64* %r4
%r159 = zext i64 %r158 to i128
%r161 = getelementptr i64, i64* %r4, i32 1
%r162 = load i64, i64* %r161
%r163 = zext i64 %r162 to i128
%r164 = shl i128 %r163, 64
%r165 = or i128 %r159, %r164
%r166 = zext i128 %r165 to i192
%r168 = getelementptr i64, i64* %r4, i32 2
%r169 = load i64, i64* %r168
%r170 = zext i64 %r169 to i192
%r171 = shl i192 %r170, 128
%r172 = or i192 %r166, %r171
%r173 = zext i192 %r172 to i256
%r175 = getelementptr i64, i64* %r4, i32 3
%r176 = load i64, i64* %r175
%r177 = zext i64 %r176 to i256
%r178 = shl i256 %r177, 192
%r179 = or i256 %r173, %r178
%r180 = zext i256 %r179 to i320
%r182 = getelementptr i64, i64* %r4, i32 4
%r183 = load i64, i64* %r182
%r184 = zext i64 %r183 to i320
%r185 = shl i320 %r184, 256
%r186 = or i320 %r180, %r185
%r187 = zext i320 %r186 to i384
%r188 = sub i384 %r157, %r187
%r189 = lshr i384 %r188, 320
%r190 = trunc i384 %r189 to i1
%r191 = select i1 %r190, i384 %r157, i384 %r188
%r192 = trunc i384 %r191 to i320
%r194 = getelementptr i64, i64* %r1, i32 5
%r195 = trunc i320 %r192 to i64
%r197 = getelementptr i64, i64* %r194, i32 0
store i64 %r195, i64* %r197
%r198 = lshr i320 %r192, 64
%r199 = trunc i320 %r198 to i64
%r201 = getelementptr i64, i64* %r194, i32 1
store i64 %r199, i64* %r201
%r202 = lshr i320 %r198, 64
%r203 = trunc i320 %r202 to i64
%r205 = getelementptr i64, i64* %r194, i32 2
store i64 %r203, i64* %r205
%r206 = lshr i320 %r202, 64
%r207 = trunc i320 %r206 to i64
%r209 = getelementptr i64, i64* %r194, i32 3
store i64 %r207, i64* %r209
%r210 = lshr i320 %r206, 64
%r211 = trunc i320 %r210 to i64
%r213 = getelementptr i64, i64* %r194, i32 4
store i64 %r211, i64* %r213
ret void
}
define void @mcl_fpDbl_sub5L(i64* noalias  %r1, i64* noalias  %r2, i64* noalias  %r3, i64* noalias  %r4)
{
%r5 = load i64, i64* %r2
%r6 = zext i64 %r5 to i128
%r8 = getelementptr i64, i64* %r2, i32 1
%r9 = load i64, i64* %r8
%r10 = zext i64 %r9 to i128
%r11 = shl i128 %r10, 64
%r12 = or i128 %r6, %r11
%r13 = zext i128 %r12 to i192
%r15 = getelementptr i64, i64* %r2, i32 2
%r16 = load i64, i64* %r15
%r17 = zext i64 %r16 to i192
%r18 = shl i192 %r17, 128
%r19 = or i192 %r13, %r18
%r20 = zext i192 %r19 to i256
%r22 = getelementptr i64, i64* %r2, i32 3
%r23 = load i64, i64* %r22
%r24 = zext i64 %r23 to i256
%r25 = shl i256 %r24, 192
%r26 = or i256 %r20, %r25
%r27 = zext i256 %r26 to i320
%r29 = getelementptr i64, i64* %r2, i32 4
%r30 = load i64, i64* %r29
%r31 = zext i64 %r30 to i320
%r32 = shl i320 %r31, 256
%r33 = or i320 %r27, %r32
%r34 = zext i320 %r33 to i384
%r36 = getelementptr i64, i64* %r2, i32 5
%r37 = load i64, i64* %r36
%r38 = zext i64 %r37 to i384
%r39 = shl i384 %r38, 320
%r40 = or i384 %r34, %r39
%r41 = zext i384 %r40 to i448
%r43 = getelementptr i64, i64* %r2, i32 6
%r44 = load i64, i64* %r43
%r45 = zext i64 %r44 to i448
%r46 = shl i448 %r45, 384
%r47 = or i448 %r41, %r46
%r48 = zext i448 %r47 to i512
%r50 = getelementptr i64, i64* %r2, i32 7
%r51 = load i64, i64* %r50
%r52 = zext i64 %r51 to i512
%r53 = shl i512 %r52, 448
%r54 = or i512 %r48, %r53
%r55 = zext i512 %r54 to i576
%r57 = getelementptr i64, i64* %r2, i32 8
%r58 = load i64, i64* %r57
%r59 = zext i64 %r58 to i576
%r60 = shl i576 %r59, 512
%r61 = or i576 %r55, %r60
%r62 = zext i576 %r61 to i640
%r64 = getelementptr i64, i64* %r2, i32 9
%r65 = load i64, i64* %r64
%r66 = zext i64 %r65 to i640
%r67 = shl i640 %r66, 576
%r68 = or i640 %r62, %r67
%r69 = load i64, i64* %r3
%r70 = zext i64 %r69 to i128
%r72 = getelementptr i64, i64* %r3, i32 1
%r73 = load i64, i64* %r72
%r74 = zext i64 %r73 to i128
%r75 = shl i128 %r74, 64
%r76 = or i128 %r70, %r75
%r77 = zext i128 %r76 to i192
%r79 = getelementptr i64, i64* %r3, i32 2
%r80 = load i64, i64* %r79
%r81 = zext i64 %r80 to i192
%r82 = shl i192 %r81, 128
%r83 = or i192 %r77, %r82
%r84 = zext i192 %r83 to i256
%r86 = getelementptr i64, i64* %r3, i32 3
%r87 = load i64, i64* %r86
%r88 = zext i64 %r87 to i256
%r89 = shl i256 %r88, 192
%r90 = or i256 %r84, %r89
%r91 = zext i256 %r90 to i320
%r93 = getelementptr i64, i64* %r3, i32 4
%r94 = load i64, i64* %r93
%r95 = zext i64 %r94 to i320
%r96 = shl i320 %r95, 256
%r97 = or i320 %r91, %r96
%r98 = zext i320 %r97 to i384
%r100 = getelementptr i64, i64* %r3, i32 5
%r101 = load i64, i64* %r100
%r102 = zext i64 %r101 to i384
%r103 = shl i384 %r102, 320
%r104 = or i384 %r98, %r103
%r105 = zext i384 %r104 to i448
%r107 = getelementptr i64, i64* %r3, i32 6
%r108 = load i64, i64* %r107
%r109 = zext i64 %r108 to i448
%r110 = shl i448 %r109, 384
%r111 = or i448 %r105, %r110
%r112 = zext i448 %r111 to i512
%r114 = getelementptr i64, i64* %r3, i32 7
%r115 = load i64, i64* %r114
%r116 = zext i64 %r115 to i512
%r117 = shl i512 %r116, 448
%r118 = or i512 %r112, %r117
%r119 = zext i512 %r118 to i576
%r121 = getelementptr i64, i64* %r3, i32 8
%r122 = load i64, i64* %r121
%r123 = zext i64 %r122 to i576
%r124 = shl i576 %r123, 512
%r125 = or i576 %r119, %r124
%r126 = zext i576 %r125 to i640
%r128 = getelementptr i64, i64* %r3, i32 9
%r129 = load i64, i64* %r128
%r130 = zext i64 %r129 to i640
%r131 = shl i640 %r130, 576
%r132 = or i640 %r126, %r131
%r133 = zext i640 %r68 to i704
%r134 = zext i640 %r132 to i704
%r135 = sub i704 %r133, %r134
%r136 = trunc i704 %r135 to i320
%r137 = trunc i320 %r136 to i64
%r139 = getelementptr i64, i64* %r1, i32 0
store i64 %r137, i64* %r139
%r140 = lshr i320 %r136, 64
%r141 = trunc i320 %r140 to i64
%r143 = getelementptr i64, i64* %r1, i32 1
store i64 %r141, i64* %r143
%r144 = lshr i320 %r140, 64
%r145 = trunc i320 %r144 to i64
%r147 = getelementptr i64, i64* %r1, i32 2
store i64 %r145, i64* %r147
%r148 = lshr i320 %r144, 64
%r149 = trunc i320 %r148 to i64
%r151 = getelementptr i64, i64* %r1, i32 3
store i64 %r149, i64* %r151
%r152 = lshr i320 %r148, 64
%r153 = trunc i320 %r152 to i64
%r155 = getelementptr i64, i64* %r1, i32 4
store i64 %r153, i64* %r155
%r156 = lshr i704 %r135, 320
%r157 = trunc i704 %r156 to i320
%r158 = lshr i704 %r135, 640
%r159 = trunc i704 %r158 to i1
%r160 = load i64, i64* %r4
%r161 = zext i64 %r160 to i128
%r163 = getelementptr i64, i64* %r4, i32 1
%r164 = load i64, i64* %r163
%r165 = zext i64 %r164 to i128
%r166 = shl i128 %r165, 64
%r167 = or i128 %r161, %r166
%r168 = zext i128 %r167 to i192
%r170 = getelementptr i64, i64* %r4, i32 2
%r171 = load i64, i64* %r170
%r172 = zext i64 %r171 to i192
%r173 = shl i192 %r172, 128
%r174 = or i192 %r168, %r173
%r175 = zext i192 %r174 to i256
%r177 = getelementptr i64, i64* %r4, i32 3
%r178 = load i64, i64* %r177
%r179 = zext i64 %r178 to i256
%r180 = shl i256 %r179, 192
%r181 = or i256 %r175, %r180
%r182 = zext i256 %r181 to i320
%r184 = getelementptr i64, i64* %r4, i32 4
%r185 = load i64, i64* %r184
%r186 = zext i64 %r185 to i320
%r187 = shl i320 %r186, 256
%r188 = or i320 %r182, %r187
%r190 = select i1 %r159, i320 %r188, i320 0
%r191 = add i320 %r157, %r190
%r193 = getelementptr i64, i64* %r1, i32 5
%r194 = trunc i320 %r191 to i64
%r196 = getelementptr i64, i64* %r193, i32 0
store i64 %r194, i64* %r196
%r197 = lshr i320 %r191, 64
%r198 = trunc i320 %r197 to i64
%r200 = getelementptr i64, i64* %r193, i32 1
store i64 %r198, i64* %r200
%r201 = lshr i320 %r197, 64
%r202 = trunc i320 %r201 to i64
%r204 = getelementptr i64, i64* %r193, i32 2
store i64 %r202, i64* %r204
%r205 = lshr i320 %r201, 64
%r206 = trunc i320 %r205 to i64
%r208 = getelementptr i64, i64* %r193, i32 3
store i64 %r206, i64* %r208
%r209 = lshr i320 %r205, 64
%r210 = trunc i320 %r209 to i64
%r212 = getelementptr i64, i64* %r193, i32 4
store i64 %r210, i64* %r212
ret void
}
define i448 @mulPv384x64(i64* noalias  %r2, i64 %r3)
{
%r5 = call i128 @mulPos64x64(i64* %r2, i64 %r3, i64 0)
%r6 = trunc i128 %r5 to i64
%r7 = call i64 @extractHigh64(i128 %r5)
%r9 = call i128 @mulPos64x64(i64* %r2, i64 %r3, i64 1)
%r10 = trunc i128 %r9 to i64
%r11 = call i64 @extractHigh64(i128 %r9)
%r13 = call i128 @mulPos64x64(i64* %r2, i64 %r3, i64 2)
%r14 = trunc i128 %r13 to i64
%r15 = call i64 @extractHigh64(i128 %r13)
%r17 = call i128 @mulPos64x64(i64* %r2, i64 %r3, i64 3)
%r18 = trunc i128 %r17 to i64
%r19 = call i64 @extractHigh64(i128 %r17)
%r21 = call i128 @mulPos64x64(i64* %r2, i64 %r3, i64 4)
%r22 = trunc i128 %r21 to i64
%r23 = call i64 @extractHigh64(i128 %r21)
%r25 = call i128 @mulPos64x64(i64* %r2, i64 %r3, i64 5)
%r26 = trunc i128 %r25 to i64
%r27 = call i64 @extractHigh64(i128 %r25)
%r28 = zext i64 %r6 to i128
%r29 = zext i64 %r10 to i128
%r30 = shl i128 %r29, 64
%r31 = or i128 %r28, %r30
%r32 = zext i128 %r31 to i192
%r33 = zext i64 %r14 to i192
%r34 = shl i192 %r33, 128
%r35 = or i192 %r32, %r34
%r36 = zext i192 %r35 to i256
%r37 = zext i64 %r18 to i256
%r38 = shl i256 %r37, 192
%r39 = or i256 %r36, %r38
%r40 = zext i256 %r39 to i320
%r41 = zext i64 %r22 to i320
%r42 = shl i320 %r41, 256
%r43 = or i320 %r40, %r42
%r44 = zext i320 %r43 to i384
%r45 = zext i64 %r26 to i384
%r46 = shl i384 %r45, 320
%r47 = or i384 %r44, %r46
%r48 = zext i64 %r7 to i128
%r49 = zext i64 %r11 to i128
%r50 = shl i128 %r49, 64
%r51 = or i128 %r48, %r50
%r52 = zext i128 %r51 to i192
%r53 = zext i64 %r15 to i192
%r54 = shl i192 %r53, 128
%r55 = or i192 %r52, %r54
%r56 = zext i192 %r55 to i256
%r57 = zext i64 %r19 to i256
%r58 = shl i256 %r57, 192
%r59 = or i256 %r56, %r58
%r60 = zext i256 %r59 to i320
%r61 = zext i64 %r23 to i320
%r62 = shl i320 %r61, 256
%r63 = or i320 %r60, %r62
%r64 = zext i320 %r63 to i384
%r65 = zext i64 %r27 to i384
%r66 = shl i384 %r65, 320
%r67 = or i384 %r64, %r66
%r68 = zext i384 %r47 to i448
%r69 = zext i384 %r67 to i448
%r70 = shl i448 %r69, 64
%r71 = add i448 %r68, %r70
ret i448 %r71
}
define void @mcl_fp_mulUnitPre6L(i64* noalias  %r1, i64* noalias  %r2, i64 %r3)
{
%r4 = call i448 @mulPv384x64(i64* %r2, i64 %r3)
%r5 = trunc i448 %r4 to i64
%r7 = getelementptr i64, i64* %r1, i32 0
store i64 %r5, i64* %r7
%r8 = lshr i448 %r4, 64
%r9 = trunc i448 %r8 to i64
%r11 = getelementptr i64, i64* %r1, i32 1
store i64 %r9, i64* %r11
%r12 = lshr i448 %r8, 64
%r13 = trunc i448 %r12 to i64
%r15 = getelementptr i64, i64* %r1, i32 2
store i64 %r13, i64* %r15
%r16 = lshr i448 %r12, 64
%r17 = trunc i448 %r16 to i64
%r19 = getelementptr i64, i64* %r1, i32 3
store i64 %r17, i64* %r19
%r20 = lshr i448 %r16, 64
%r21 = trunc i448 %r20 to i64
%r23 = getelementptr i64, i64* %r1, i32 4
store i64 %r21, i64* %r23
%r24 = lshr i448 %r20, 64
%r25 = trunc i448 %r24 to i64
%r27 = getelementptr i64, i64* %r1, i32 5
store i64 %r25, i64* %r27
%r28 = lshr i448 %r24, 64
%r29 = trunc i448 %r28 to i64
%r31 = getelementptr i64, i64* %r1, i32 6
store i64 %r29, i64* %r31
ret void
}
define void @mcl_fpDbl_mulPre6L(i64* noalias  %r1, i64* noalias  %r2, i64* noalias  %r3)
{
%r4 = load i64, i64* %r3
%r5 = call i448 @mulPv384x64(i64* %r2, i64 %r4)
%r6 = trunc i448 %r5 to i64
store i64 %r6, i64* %r1
%r7 = lshr i448 %r5, 64
%r9 = getelementptr i64, i64* %r3, i32 1
%r10 = load i64, i64* %r9
%r11 = call i448 @mulPv384x64(i64* %r2, i64 %r10)
%r12 = add i448 %r7, %r11
%r13 = trunc i448 %r12 to i64
%r15 = getelementptr i64, i64* %r1, i32 1
store i64 %r13, i64* %r15
%r16 = lshr i448 %r12, 64
%r18 = getelementptr i64, i64* %r3, i32 2
%r19 = load i64, i64* %r18
%r20 = call i448 @mulPv384x64(i64* %r2, i64 %r19)
%r21 = add i448 %r16, %r20
%r22 = trunc i448 %r21 to i64
%r24 = getelementptr i64, i64* %r1, i32 2
store i64 %r22, i64* %r24
%r25 = lshr i448 %r21, 64
%r27 = getelementptr i64, i64* %r3, i32 3
%r28 = load i64, i64* %r27
%r29 = call i448 @mulPv384x64(i64* %r2, i64 %r28)
%r30 = add i448 %r25, %r29
%r31 = trunc i448 %r30 to i64
%r33 = getelementptr i64, i64* %r1, i32 3
store i64 %r31, i64* %r33
%r34 = lshr i448 %r30, 64
%r36 = getelementptr i64, i64* %r3, i32 4
%r37 = load i64, i64* %r36
%r38 = call i448 @mulPv384x64(i64* %r2, i64 %r37)
%r39 = add i448 %r34, %r38
%r40 = trunc i448 %r39 to i64
%r42 = getelementptr i64, i64* %r1, i32 4
store i64 %r40, i64* %r42
%r43 = lshr i448 %r39, 64
%r45 = getelementptr i64, i64* %r3, i32 5
%r46 = load i64, i64* %r45
%r47 = call i448 @mulPv384x64(i64* %r2, i64 %r46)
%r48 = add i448 %r43, %r47
%r50 = getelementptr i64, i64* %r1, i32 5
%r51 = trunc i448 %r48 to i64
%r53 = getelementptr i64, i64* %r50, i32 0
store i64 %r51, i64* %r53
%r54 = lshr i448 %r48, 64
%r55 = trunc i448 %r54 to i64
%r57 = getelementptr i64, i64* %r50, i32 1
store i64 %r55, i64* %r57
%r58 = lshr i448 %r54, 64
%r59 = trunc i448 %r58 to i64
%r61 = getelementptr i64, i64* %r50, i32 2
store i64 %r59, i64* %r61
%r62 = lshr i448 %r58, 64
%r63 = trunc i448 %r62 to i64
%r65 = getelementptr i64, i64* %r50, i32 3
store i64 %r63, i64* %r65
%r66 = lshr i448 %r62, 64
%r67 = trunc i448 %r66 to i64
%r69 = getelementptr i64, i64* %r50, i32 4
store i64 %r67, i64* %r69
%r70 = lshr i448 %r66, 64
%r71 = trunc i448 %r70 to i64
%r73 = getelementptr i64, i64* %r50, i32 5
store i64 %r71, i64* %r73
%r74 = lshr i448 %r70, 64
%r75 = trunc i448 %r74 to i64
%r77 = getelementptr i64, i64* %r50, i32 6
store i64 %r75, i64* %r77
ret void
}
define void @mcl_fpDbl_sqrPre6L(i64* noalias  %r1, i64* noalias  %r2)
{
%r3 = load i64, i64* %r2
%r4 = call i448 @mulPv384x64(i64* %r2, i64 %r3)
%r5 = trunc i448 %r4 to i64
store i64 %r5, i64* %r1
%r6 = lshr i448 %r4, 64
%r8 = getelementptr i64, i64* %r2, i32 1
%r9 = load i64, i64* %r8
%r10 = call i448 @mulPv384x64(i64* %r2, i64 %r9)
%r11 = add i448 %r6, %r10
%r12 = trunc i448 %r11 to i64
%r14 = getelementptr i64, i64* %r1, i32 1
store i64 %r12, i64* %r14
%r15 = lshr i448 %r11, 64
%r17 = getelementptr i64, i64* %r2, i32 2
%r18 = load i64, i64* %r17
%r19 = call i448 @mulPv384x64(i64* %r2, i64 %r18)
%r20 = add i448 %r15, %r19
%r21 = trunc i448 %r20 to i64
%r23 = getelementptr i64, i64* %r1, i32 2
store i64 %r21, i64* %r23
%r24 = lshr i448 %r20, 64
%r26 = getelementptr i64, i64* %r2, i32 3
%r27 = load i64, i64* %r26
%r28 = call i448 @mulPv384x64(i64* %r2, i64 %r27)
%r29 = add i448 %r24, %r28
%r30 = trunc i448 %r29 to i64
%r32 = getelementptr i64, i64* %r1, i32 3
store i64 %r30, i64* %r32
%r33 = lshr i448 %r29, 64
%r35 = getelementptr i64, i64* %r2, i32 4
%r36 = load i64, i64* %r35
%r37 = call i448 @mulPv384x64(i64* %r2, i64 %r36)
%r38 = add i448 %r33, %r37
%r39 = trunc i448 %r38 to i64
%r41 = getelementptr i64, i64* %r1, i32 4
store i64 %r39, i64* %r41
%r42 = lshr i448 %r38, 64
%r44 = getelementptr i64, i64* %r2, i32 5
%r45 = load i64, i64* %r44
%r46 = call i448 @mulPv384x64(i64* %r2, i64 %r45)
%r47 = add i448 %r42, %r46
%r49 = getelementptr i64, i64* %r1, i32 5
%r50 = trunc i448 %r47 to i64
%r52 = getelementptr i64, i64* %r49, i32 0
store i64 %r50, i64* %r52
%r53 = lshr i448 %r47, 64
%r54 = trunc i448 %r53 to i64
%r56 = getelementptr i64, i64* %r49, i32 1
store i64 %r54, i64* %r56
%r57 = lshr i448 %r53, 64
%r58 = trunc i448 %r57 to i64
%r60 = getelementptr i64, i64* %r49, i32 2
store i64 %r58, i64* %r60
%r61 = lshr i448 %r57, 64
%r62 = trunc i448 %r61 to i64
%r64 = getelementptr i64, i64* %r49, i32 3
store i64 %r62, i64* %r64
%r65 = lshr i448 %r61, 64
%r66 = trunc i448 %r65 to i64
%r68 = getelementptr i64, i64* %r49, i32 4
store i64 %r66, i64* %r68
%r69 = lshr i448 %r65, 64
%r70 = trunc i448 %r69 to i64
%r72 = getelementptr i64, i64* %r49, i32 5
store i64 %r70, i64* %r72
%r73 = lshr i448 %r69, 64
%r74 = trunc i448 %r73 to i64
%r76 = getelementptr i64, i64* %r49, i32 6
store i64 %r74, i64* %r76
ret void
}
define void @mcl_fp_mont6L(i64* %r1, i64* %r2, i64* %r3, i64* %r4)
{
%r6 = getelementptr i64, i64* %r4, i32 -1
%r7 = load i64, i64* %r6
%r9 = getelementptr i64, i64* %r3, i32 0
%r10 = load i64, i64* %r9
%r11 = call i448 @mulPv384x64(i64* %r2, i64 %r10)
%r12 = zext i448 %r11 to i512
%r13 = trunc i448 %r11 to i64
%r14 = mul i64 %r13, %r7
%r15 = call i448 @mulPv384x64(i64* %r4, i64 %r14)
%r16 = zext i448 %r15 to i512
%r17 = add i512 %r12, %r16
%r18 = lshr i512 %r17, 64
%r20 = getelementptr i64, i64* %r3, i32 1
%r21 = load i64, i64* %r20
%r22 = call i448 @mulPv384x64(i64* %r2, i64 %r21)
%r23 = zext i448 %r22 to i512
%r24 = add i512 %r18, %r23
%r25 = trunc i512 %r24 to i64
%r26 = mul i64 %r25, %r7
%r27 = call i448 @mulPv384x64(i64* %r4, i64 %r26)
%r28 = zext i448 %r27 to i512
%r29 = add i512 %r24, %r28
%r30 = lshr i512 %r29, 64
%r32 = getelementptr i64, i64* %r3, i32 2
%r33 = load i64, i64* %r32
%r34 = call i448 @mulPv384x64(i64* %r2, i64 %r33)
%r35 = zext i448 %r34 to i512
%r36 = add i512 %r30, %r35
%r37 = trunc i512 %r36 to i64
%r38 = mul i64 %r37, %r7
%r39 = call i448 @mulPv384x64(i64* %r4, i64 %r38)
%r40 = zext i448 %r39 to i512
%r41 = add i512 %r36, %r40
%r42 = lshr i512 %r41, 64
%r44 = getelementptr i64, i64* %r3, i32 3
%r45 = load i64, i64* %r44
%r46 = call i448 @mulPv384x64(i64* %r2, i64 %r45)
%r47 = zext i448 %r46 to i512
%r48 = add i512 %r42, %r47
%r49 = trunc i512 %r48 to i64
%r50 = mul i64 %r49, %r7
%r51 = call i448 @mulPv384x64(i64* %r4, i64 %r50)
%r52 = zext i448 %r51 to i512
%r53 = add i512 %r48, %r52
%r54 = lshr i512 %r53, 64
%r56 = getelementptr i64, i64* %r3, i32 4
%r57 = load i64, i64* %r56
%r58 = call i448 @mulPv384x64(i64* %r2, i64 %r57)
%r59 = zext i448 %r58 to i512
%r60 = add i512 %r54, %r59
%r61 = trunc i512 %r60 to i64
%r62 = mul i64 %r61, %r7
%r63 = call i448 @mulPv384x64(i64* %r4, i64 %r62)
%r64 = zext i448 %r63 to i512
%r65 = add i512 %r60, %r64
%r66 = lshr i512 %r65, 64
%r68 = getelementptr i64, i64* %r3, i32 5
%r69 = load i64, i64* %r68
%r70 = call i448 @mulPv384x64(i64* %r2, i64 %r69)
%r71 = zext i448 %r70 to i512
%r72 = add i512 %r66, %r71
%r73 = trunc i512 %r72 to i64
%r74 = mul i64 %r73, %r7
%r75 = call i448 @mulPv384x64(i64* %r4, i64 %r74)
%r76 = zext i448 %r75 to i512
%r77 = add i512 %r72, %r76
%r78 = lshr i512 %r77, 64
%r79 = trunc i512 %r78 to i448
%r80 = load i64, i64* %r4
%r81 = zext i64 %r80 to i128
%r83 = getelementptr i64, i64* %r4, i32 1
%r84 = load i64, i64* %r83
%r85 = zext i64 %r84 to i128
%r86 = shl i128 %r85, 64
%r87 = or i128 %r81, %r86
%r88 = zext i128 %r87 to i192
%r90 = getelementptr i64, i64* %r4, i32 2
%r91 = load i64, i64* %r90
%r92 = zext i64 %r91 to i192
%r93 = shl i192 %r92, 128
%r94 = or i192 %r88, %r93
%r95 = zext i192 %r94 to i256
%r97 = getelementptr i64, i64* %r4, i32 3
%r98 = load i64, i64* %r97
%r99 = zext i64 %r98 to i256
%r100 = shl i256 %r99, 192
%r101 = or i256 %r95, %r100
%r102 = zext i256 %r101 to i320
%r104 = getelementptr i64, i64* %r4, i32 4
%r105 = load i64, i64* %r104
%r106 = zext i64 %r105 to i320
%r107 = shl i320 %r106, 256
%r108 = or i320 %r102, %r107
%r109 = zext i320 %r108 to i384
%r111 = getelementptr i64, i64* %r4, i32 5
%r112 = load i64, i64* %r111
%r113 = zext i64 %r112 to i384
%r114 = shl i384 %r113, 320
%r115 = or i384 %r109, %r114
%r116 = zext i384 %r115 to i448
%r117 = sub i448 %r79, %r116
%r118 = lshr i448 %r117, 384
%r119 = trunc i448 %r118 to i1
%r120 = select i1 %r119, i448 %r79, i448 %r117
%r121 = trunc i448 %r120 to i384
%r122 = trunc i384 %r121 to i64
%r124 = getelementptr i64, i64* %r1, i32 0
store i64 %r122, i64* %r124
%r125 = lshr i384 %r121, 64
%r126 = trunc i384 %r125 to i64
%r128 = getelementptr i64, i64* %r1, i32 1
store i64 %r126, i64* %r128
%r129 = lshr i384 %r125, 64
%r130 = trunc i384 %r129 to i64
%r132 = getelementptr i64, i64* %r1, i32 2
store i64 %r130, i64* %r132
%r133 = lshr i384 %r129, 64
%r134 = trunc i384 %r133 to i64
%r136 = getelementptr i64, i64* %r1, i32 3
store i64 %r134, i64* %r136
%r137 = lshr i384 %r133, 64
%r138 = trunc i384 %r137 to i64
%r140 = getelementptr i64, i64* %r1, i32 4
store i64 %r138, i64* %r140
%r141 = lshr i384 %r137, 64
%r142 = trunc i384 %r141 to i64
%r144 = getelementptr i64, i64* %r1, i32 5
store i64 %r142, i64* %r144
ret void
}
define void @mcl_fp_montNF6L(i64* %r1, i64* %r2, i64* %r3, i64* %r4)
{
%r6 = getelementptr i64, i64* %r4, i32 -1
%r7 = load i64, i64* %r6
%r8 = load i64, i64* %r3
%r9 = call i448 @mulPv384x64(i64* %r2, i64 %r8)
%r10 = trunc i448 %r9 to i64
%r11 = mul i64 %r10, %r7
%r12 = call i448 @mulPv384x64(i64* %r4, i64 %r11)
%r13 = add i448 %r9, %r12
%r14 = lshr i448 %r13, 64
%r16 = getelementptr i64, i64* %r3, i32 1
%r17 = load i64, i64* %r16
%r18 = call i448 @mulPv384x64(i64* %r2, i64 %r17)
%r19 = add i448 %r14, %r18
%r20 = trunc i448 %r19 to i64
%r21 = mul i64 %r20, %r7
%r22 = call i448 @mulPv384x64(i64* %r4, i64 %r21)
%r23 = add i448 %r19, %r22
%r24 = lshr i448 %r23, 64
%r26 = getelementptr i64, i64* %r3, i32 2
%r27 = load i64, i64* %r26
%r28 = call i448 @mulPv384x64(i64* %r2, i64 %r27)
%r29 = add i448 %r24, %r28
%r30 = trunc i448 %r29 to i64
%r31 = mul i64 %r30, %r7
%r32 = call i448 @mulPv384x64(i64* %r4, i64 %r31)
%r33 = add i448 %r29, %r32
%r34 = lshr i448 %r33, 64
%r36 = getelementptr i64, i64* %r3, i32 3
%r37 = load i64, i64* %r36
%r38 = call i448 @mulPv384x64(i64* %r2, i64 %r37)
%r39 = add i448 %r34, %r38
%r40 = trunc i448 %r39 to i64
%r41 = mul i64 %r40, %r7
%r42 = call i448 @mulPv384x64(i64* %r4, i64 %r41)
%r43 = add i448 %r39, %r42
%r44 = lshr i448 %r43, 64
%r46 = getelementptr i64, i64* %r3, i32 4
%r47 = load i64, i64* %r46
%r48 = call i448 @mulPv384x64(i64* %r2, i64 %r47)
%r49 = add i448 %r44, %r48
%r50 = trunc i448 %r49 to i64
%r51 = mul i64 %r50, %r7
%r52 = call i448 @mulPv384x64(i64* %r4, i64 %r51)
%r53 = add i448 %r49, %r52
%r54 = lshr i448 %r53, 64
%r56 = getelementptr i64, i64* %r3, i32 5
%r57 = load i64, i64* %r56
%r58 = call i448 @mulPv384x64(i64* %r2, i64 %r57)
%r59 = add i448 %r54, %r58
%r60 = trunc i448 %r59 to i64
%r61 = mul i64 %r60, %r7
%r62 = call i448 @mulPv384x64(i64* %r4, i64 %r61)
%r63 = add i448 %r59, %r62
%r64 = lshr i448 %r63, 64
%r65 = trunc i448 %r64 to i384
%r66 = load i64, i64* %r4
%r67 = zext i64 %r66 to i128
%r69 = getelementptr i64, i64* %r4, i32 1
%r70 = load i64, i64* %r69
%r71 = zext i64 %r70 to i128
%r72 = shl i128 %r71, 64
%r73 = or i128 %r67, %r72
%r74 = zext i128 %r73 to i192
%r76 = getelementptr i64, i64* %r4, i32 2
%r77 = load i64, i64* %r76
%r78 = zext i64 %r77 to i192
%r79 = shl i192 %r78, 128
%r80 = or i192 %r74, %r79
%r81 = zext i192 %r80 to i256
%r83 = getelementptr i64, i64* %r4, i32 3
%r84 = load i64, i64* %r83
%r85 = zext i64 %r84 to i256
%r86 = shl i256 %r85, 192
%r87 = or i256 %r81, %r86
%r88 = zext i256 %r87 to i320
%r90 = getelementptr i64, i64* %r4, i32 4
%r91 = load i64, i64* %r90
%r92 = zext i64 %r91 to i320
%r93 = shl i320 %r92, 256
%r94 = or i320 %r88, %r93
%r95 = zext i320 %r94 to i384
%r97 = getelementptr i64, i64* %r4, i32 5
%r98 = load i64, i64* %r97
%r99 = zext i64 %r98 to i384
%r100 = shl i384 %r99, 320
%r101 = or i384 %r95, %r100
%r102 = sub i384 %r65, %r101
%r103 = lshr i384 %r102, 383
%r104 = trunc i384 %r103 to i1
%r105 = select i1 %r104, i384 %r65, i384 %r102
%r106 = trunc i384 %r105 to i64
%r108 = getelementptr i64, i64* %r1, i32 0
store i64 %r106, i64* %r108
%r109 = lshr i384 %r105, 64
%r110 = trunc i384 %r109 to i64
%r112 = getelementptr i64, i64* %r1, i32 1
store i64 %r110, i64* %r112
%r113 = lshr i384 %r109, 64
%r114 = trunc i384 %r113 to i64
%r116 = getelementptr i64, i64* %r1, i32 2
store i64 %r114, i64* %r116
%r117 = lshr i384 %r113, 64
%r118 = trunc i384 %r117 to i64
%r120 = getelementptr i64, i64* %r1, i32 3
store i64 %r118, i64* %r120
%r121 = lshr i384 %r117, 64
%r122 = trunc i384 %r121 to i64
%r124 = getelementptr i64, i64* %r1, i32 4
store i64 %r122, i64* %r124
%r125 = lshr i384 %r121, 64
%r126 = trunc i384 %r125 to i64
%r128 = getelementptr i64, i64* %r1, i32 5
store i64 %r126, i64* %r128
ret void
}
define void @mcl_fp_montRed6L(i64* noalias  %r1, i64* noalias  %r2, i64* noalias  %r3)
{
%r5 = getelementptr i64, i64* %r3, i32 -1
%r6 = load i64, i64* %r5
%r7 = load i64, i64* %r3
%r8 = zext i64 %r7 to i128
%r10 = getelementptr i64, i64* %r3, i32 1
%r11 = load i64, i64* %r10
%r12 = zext i64 %r11 to i128
%r13 = shl i128 %r12, 64
%r14 = or i128 %r8, %r13
%r15 = zext i128 %r14 to i192
%r17 = getelementptr i64, i64* %r3, i32 2
%r18 = load i64, i64* %r17
%r19 = zext i64 %r18 to i192
%r20 = shl i192 %r19, 128
%r21 = or i192 %r15, %r20
%r22 = zext i192 %r21 to i256
%r24 = getelementptr i64, i64* %r3, i32 3
%r25 = load i64, i64* %r24
%r26 = zext i64 %r25 to i256
%r27 = shl i256 %r26, 192
%r28 = or i256 %r22, %r27
%r29 = zext i256 %r28 to i320
%r31 = getelementptr i64, i64* %r3, i32 4
%r32 = load i64, i64* %r31
%r33 = zext i64 %r32 to i320
%r34 = shl i320 %r33, 256
%r35 = or i320 %r29, %r34
%r36 = zext i320 %r35 to i384
%r38 = getelementptr i64, i64* %r3, i32 5
%r39 = load i64, i64* %r38
%r40 = zext i64 %r39 to i384
%r41 = shl i384 %r40, 320
%r42 = or i384 %r36, %r41
%r43 = load i64, i64* %r2
%r44 = zext i64 %r43 to i128
%r46 = getelementptr i64, i64* %r2, i32 1
%r47 = load i64, i64* %r46
%r48 = zext i64 %r47 to i128
%r49 = shl i128 %r48, 64
%r50 = or i128 %r44, %r49
%r51 = zext i128 %r50 to i192
%r53 = getelementptr i64, i64* %r2, i32 2
%r54 = load i64, i64* %r53
%r55 = zext i64 %r54 to i192
%r56 = shl i192 %r55, 128
%r57 = or i192 %r51, %r56
%r58 = zext i192 %r57 to i256
%r60 = getelementptr i64, i64* %r2, i32 3
%r61 = load i64, i64* %r60
%r62 = zext i64 %r61 to i256
%r63 = shl i256 %r62, 192
%r64 = or i256 %r58, %r63
%r65 = zext i256 %r64 to i320
%r67 = getelementptr i64, i64* %r2, i32 4
%r68 = load i64, i64* %r67
%r69 = zext i64 %r68 to i320
%r70 = shl i320 %r69, 256
%r71 = or i320 %r65, %r70
%r72 = zext i320 %r71 to i384
%r74 = getelementptr i64, i64* %r2, i32 5
%r75 = load i64, i64* %r74
%r76 = zext i64 %r75 to i384
%r77 = shl i384 %r76, 320
%r78 = or i384 %r72, %r77
%r79 = zext i384 %r78 to i448
%r81 = getelementptr i64, i64* %r2, i32 6
%r82 = load i64, i64* %r81
%r83 = zext i64 %r82 to i448
%r84 = shl i448 %r83, 384
%r85 = or i448 %r79, %r84
%r86 = zext i448 %r85 to i512
%r88 = getelementptr i64, i64* %r2, i32 7
%r89 = load i64, i64* %r88
%r90 = zext i64 %r89 to i512
%r91 = shl i512 %r90, 448
%r92 = or i512 %r86, %r91
%r93 = zext i512 %r92 to i576
%r95 = getelementptr i64, i64* %r2, i32 8
%r96 = load i64, i64* %r95
%r97 = zext i64 %r96 to i576
%r98 = shl i576 %r97, 512
%r99 = or i576 %r93, %r98
%r100 = zext i576 %r99 to i640
%r102 = getelementptr i64, i64* %r2, i32 9
%r103 = load i64, i64* %r102
%r104 = zext i64 %r103 to i640
%r105 = shl i640 %r104, 576
%r106 = or i640 %r100, %r105
%r107 = zext i640 %r106 to i704
%r109 = getelementptr i64, i64* %r2, i32 10
%r110 = load i64, i64* %r109
%r111 = zext i64 %r110 to i704
%r112 = shl i704 %r111, 640
%r113 = or i704 %r107, %r112
%r114 = zext i704 %r113 to i768
%r116 = getelementptr i64, i64* %r2, i32 11
%r117 = load i64, i64* %r116
%r118 = zext i64 %r117 to i768
%r119 = shl i768 %r118, 704
%r120 = or i768 %r114, %r119
%r121 = zext i768 %r120 to i832
%r122 = trunc i832 %r121 to i64
%r123 = mul i64 %r122, %r6
%r124 = call i448 @mulPv384x64(i64* %r3, i64 %r123)
%r125 = zext i448 %r124 to i832
%r126 = add i832 %r121, %r125
%r127 = lshr i832 %r126, 64
%r128 = trunc i832 %r127 to i768
%r129 = trunc i768 %r128 to i64
%r130 = mul i64 %r129, %r6
%r131 = call i448 @mulPv384x64(i64* %r3, i64 %r130)
%r132 = zext i448 %r131 to i768
%r133 = add i768 %r128, %r132
%r134 = lshr i768 %r133, 64
%r135 = trunc i768 %r134 to i704
%r136 = trunc i704 %r135 to i64
%r137 = mul i64 %r136, %r6
%r138 = call i448 @mulPv384x64(i64* %r3, i64 %r137)
%r139 = zext i448 %r138 to i704
%r140 = add i704 %r135, %r139
%r141 = lshr i704 %r140, 64
%r142 = trunc i704 %r141 to i640
%r143 = trunc i640 %r142 to i64
%r144 = mul i64 %r143, %r6
%r145 = call i448 @mulPv384x64(i64* %r3, i64 %r144)
%r146 = zext i448 %r145 to i640
%r147 = add i640 %r142, %r146
%r148 = lshr i640 %r147, 64
%r149 = trunc i640 %r148 to i576
%r150 = trunc i576 %r149 to i64
%r151 = mul i64 %r150, %r6
%r152 = call i448 @mulPv384x64(i64* %r3, i64 %r151)
%r153 = zext i448 %r152 to i576
%r154 = add i576 %r149, %r153
%r155 = lshr i576 %r154, 64
%r156 = trunc i576 %r155 to i512
%r157 = trunc i512 %r156 to i64
%r158 = mul i64 %r157, %r6
%r159 = call i448 @mulPv384x64(i64* %r3, i64 %r158)
%r160 = zext i448 %r159 to i512
%r161 = add i512 %r156, %r160
%r162 = lshr i512 %r161, 64
%r163 = trunc i512 %r162 to i448
%r164 = zext i384 %r42 to i448
%r165 = sub i448 %r163, %r164
%r166 = lshr i448 %r165, 384
%r167 = trunc i448 %r166 to i1
%r168 = select i1 %r167, i448 %r163, i448 %r165
%r169 = trunc i448 %r168 to i384
%r170 = trunc i384 %r169 to i64
%r172 = getelementptr i64, i64* %r1, i32 0
store i64 %r170, i64* %r172
%r173 = lshr i384 %r169, 64
%r174 = trunc i384 %r173 to i64
%r176 = getelementptr i64, i64* %r1, i32 1
store i64 %r174, i64* %r176
%r177 = lshr i384 %r173, 64
%r178 = trunc i384 %r177 to i64
%r180 = getelementptr i64, i64* %r1, i32 2
store i64 %r178, i64* %r180
%r181 = lshr i384 %r177, 64
%r182 = trunc i384 %r181 to i64
%r184 = getelementptr i64, i64* %r1, i32 3
store i64 %r182, i64* %r184
%r185 = lshr i384 %r181, 64
%r186 = trunc i384 %r185 to i64
%r188 = getelementptr i64, i64* %r1, i32 4
store i64 %r186, i64* %r188
%r189 = lshr i384 %r185, 64
%r190 = trunc i384 %r189 to i64
%r192 = getelementptr i64, i64* %r1, i32 5
store i64 %r190, i64* %r192
ret void
}
define i64 @mcl_fp_addPre6L(i64* noalias  %r2, i64* noalias  %r3, i64* noalias  %r4)
{
%r5 = load i64, i64* %r3
%r6 = zext i64 %r5 to i128
%r8 = getelementptr i64, i64* %r3, i32 1
%r9 = load i64, i64* %r8
%r10 = zext i64 %r9 to i128
%r11 = shl i128 %r10, 64
%r12 = or i128 %r6, %r11
%r13 = zext i128 %r12 to i192
%r15 = getelementptr i64, i64* %r3, i32 2
%r16 = load i64, i64* %r15
%r17 = zext i64 %r16 to i192
%r18 = shl i192 %r17, 128
%r19 = or i192 %r13, %r18
%r20 = zext i192 %r19 to i256
%r22 = getelementptr i64, i64* %r3, i32 3
%r23 = load i64, i64* %r22
%r24 = zext i64 %r23 to i256
%r25 = shl i256 %r24, 192
%r26 = or i256 %r20, %r25
%r27 = zext i256 %r26 to i320
%r29 = getelementptr i64, i64* %r3, i32 4
%r30 = load i64, i64* %r29
%r31 = zext i64 %r30 to i320
%r32 = shl i320 %r31, 256
%r33 = or i320 %r27, %r32
%r34 = zext i320 %r33 to i384
%r36 = getelementptr i64, i64* %r3, i32 5
%r37 = load i64, i64* %r36
%r38 = zext i64 %r37 to i384
%r39 = shl i384 %r38, 320
%r40 = or i384 %r34, %r39
%r41 = zext i384 %r40 to i448
%r42 = load i64, i64* %r4
%r43 = zext i64 %r42 to i128
%r45 = getelementptr i64, i64* %r4, i32 1
%r46 = load i64, i64* %r45
%r47 = zext i64 %r46 to i128
%r48 = shl i128 %r47, 64
%r49 = or i128 %r43, %r48
%r50 = zext i128 %r49 to i192
%r52 = getelementptr i64, i64* %r4, i32 2
%r53 = load i64, i64* %r52
%r54 = zext i64 %r53 to i192
%r55 = shl i192 %r54, 128
%r56 = or i192 %r50, %r55
%r57 = zext i192 %r56 to i256
%r59 = getelementptr i64, i64* %r4, i32 3
%r60 = load i64, i64* %r59
%r61 = zext i64 %r60 to i256
%r62 = shl i256 %r61, 192
%r63 = or i256 %r57, %r62
%r64 = zext i256 %r63 to i320
%r66 = getelementptr i64, i64* %r4, i32 4
%r67 = load i64, i64* %r66
%r68 = zext i64 %r67 to i320
%r69 = shl i320 %r68, 256
%r70 = or i320 %r64, %r69
%r71 = zext i320 %r70 to i384
%r73 = getelementptr i64, i64* %r4, i32 5
%r74 = load i64, i64* %r73
%r75 = zext i64 %r74 to i384
%r76 = shl i384 %r75, 320
%r77 = or i384 %r71, %r76
%r78 = zext i384 %r77 to i448
%r79 = add i448 %r41, %r78
%r80 = trunc i448 %r79 to i384
%r81 = trunc i384 %r80 to i64
%r83 = getelementptr i64, i64* %r2, i32 0
store i64 %r81, i64* %r83
%r84 = lshr i384 %r80, 64
%r85 = trunc i384 %r84 to i64
%r87 = getelementptr i64, i64* %r2, i32 1
store i64 %r85, i64* %r87
%r88 = lshr i384 %r84, 64
%r89 = trunc i384 %r88 to i64
%r91 = getelementptr i64, i64* %r2, i32 2
store i64 %r89, i64* %r91
%r92 = lshr i384 %r88, 64
%r93 = trunc i384 %r92 to i64
%r95 = getelementptr i64, i64* %r2, i32 3
store i64 %r93, i64* %r95
%r96 = lshr i384 %r92, 64
%r97 = trunc i384 %r96 to i64
%r99 = getelementptr i64, i64* %r2, i32 4
store i64 %r97, i64* %r99
%r100 = lshr i384 %r96, 64
%r101 = trunc i384 %r100 to i64
%r103 = getelementptr i64, i64* %r2, i32 5
store i64 %r101, i64* %r103
%r104 = lshr i448 %r79, 384
%r105 = trunc i448 %r104 to i64
ret i64 %r105
}
define i64 @mcl_fp_subPre6L(i64* noalias  %r2, i64* noalias  %r3, i64* noalias  %r4)
{
%r5 = load i64, i64* %r3
%r6 = zext i64 %r5 to i128
%r8 = getelementptr i64, i64* %r3, i32 1
%r9 = load i64, i64* %r8
%r10 = zext i64 %r9 to i128
%r11 = shl i128 %r10, 64
%r12 = or i128 %r6, %r11
%r13 = zext i128 %r12 to i192
%r15 = getelementptr i64, i64* %r3, i32 2
%r16 = load i64, i64* %r15
%r17 = zext i64 %r16 to i192
%r18 = shl i192 %r17, 128
%r19 = or i192 %r13, %r18
%r20 = zext i192 %r19 to i256
%r22 = getelementptr i64, i64* %r3, i32 3
%r23 = load i64, i64* %r22
%r24 = zext i64 %r23 to i256
%r25 = shl i256 %r24, 192
%r26 = or i256 %r20, %r25
%r27 = zext i256 %r26 to i320
%r29 = getelementptr i64, i64* %r3, i32 4
%r30 = load i64, i64* %r29
%r31 = zext i64 %r30 to i320
%r32 = shl i320 %r31, 256
%r33 = or i320 %r27, %r32
%r34 = zext i320 %r33 to i384
%r36 = getelementptr i64, i64* %r3, i32 5
%r37 = load i64, i64* %r36
%r38 = zext i64 %r37 to i384
%r39 = shl i384 %r38, 320
%r40 = or i384 %r34, %r39
%r41 = zext i384 %r40 to i448
%r42 = load i64, i64* %r4
%r43 = zext i64 %r42 to i128
%r45 = getelementptr i64, i64* %r4, i32 1
%r46 = load i64, i64* %r45
%r47 = zext i64 %r46 to i128
%r48 = shl i128 %r47, 64
%r49 = or i128 %r43, %r48
%r50 = zext i128 %r49 to i192
%r52 = getelementptr i64, i64* %r4, i32 2
%r53 = load i64, i64* %r52
%r54 = zext i64 %r53 to i192
%r55 = shl i192 %r54, 128
%r56 = or i192 %r50, %r55
%r57 = zext i192 %r56 to i256
%r59 = getelementptr i64, i64* %r4, i32 3
%r60 = load i64, i64* %r59
%r61 = zext i64 %r60 to i256
%r62 = shl i256 %r61, 192
%r63 = or i256 %r57, %r62
%r64 = zext i256 %r63 to i320
%r66 = getelementptr i64, i64* %r4, i32 4
%r67 = load i64, i64* %r66
%r68 = zext i64 %r67 to i320
%r69 = shl i320 %r68, 256
%r70 = or i320 %r64, %r69
%r71 = zext i320 %r70 to i384
%r73 = getelementptr i64, i64* %r4, i32 5
%r74 = load i64, i64* %r73
%r75 = zext i64 %r74 to i384
%r76 = shl i384 %r75, 320
%r77 = or i384 %r71, %r76
%r78 = zext i384 %r77 to i448
%r79 = sub i448 %r41, %r78
%r80 = trunc i448 %r79 to i384
%r81 = trunc i384 %r80 to i64
%r83 = getelementptr i64, i64* %r2, i32 0
store i64 %r81, i64* %r83
%r84 = lshr i384 %r80, 64
%r85 = trunc i384 %r84 to i64
%r87 = getelementptr i64, i64* %r2, i32 1
store i64 %r85, i64* %r87
%r88 = lshr i384 %r84, 64
%r89 = trunc i384 %r88 to i64
%r91 = getelementptr i64, i64* %r2, i32 2
store i64 %r89, i64* %r91
%r92 = lshr i384 %r88, 64
%r93 = trunc i384 %r92 to i64
%r95 = getelementptr i64, i64* %r2, i32 3
store i64 %r93, i64* %r95
%r96 = lshr i384 %r92, 64
%r97 = trunc i384 %r96 to i64
%r99 = getelementptr i64, i64* %r2, i32 4
store i64 %r97, i64* %r99
%r100 = lshr i384 %r96, 64
%r101 = trunc i384 %r100 to i64
%r103 = getelementptr i64, i64* %r2, i32 5
store i64 %r101, i64* %r103
%r104 = lshr i448 %r79, 384
%r105 = trunc i448 %r104 to i64
%r107 = and i64 %r105, 1
ret i64 %r107
}
define void @mcl_fp_shr1_6L(i64* noalias  %r1, i64* noalias  %r2)
{
%r3 = load i64, i64* %r2
%r4 = zext i64 %r3 to i128
%r6 = getelementptr i64, i64* %r2, i32 1
%r7 = load i64, i64* %r6
%r8 = zext i64 %r7 to i128
%r9 = shl i128 %r8, 64
%r10 = or i128 %r4, %r9
%r11 = zext i128 %r10 to i192
%r13 = getelementptr i64, i64* %r2, i32 2
%r14 = load i64, i64* %r13
%r15 = zext i64 %r14 to i192
%r16 = shl i192 %r15, 128
%r17 = or i192 %r11, %r16
%r18 = zext i192 %r17 to i256
%r20 = getelementptr i64, i64* %r2, i32 3
%r21 = load i64, i64* %r20
%r22 = zext i64 %r21 to i256
%r23 = shl i256 %r22, 192
%r24 = or i256 %r18, %r23
%r25 = zext i256 %r24 to i320
%r27 = getelementptr i64, i64* %r2, i32 4
%r28 = load i64, i64* %r27
%r29 = zext i64 %r28 to i320
%r30 = shl i320 %r29, 256
%r31 = or i320 %r25, %r30
%r32 = zext i320 %r31 to i384
%r34 = getelementptr i64, i64* %r2, i32 5
%r35 = load i64, i64* %r34
%r36 = zext i64 %r35 to i384
%r37 = shl i384 %r36, 320
%r38 = or i384 %r32, %r37
%r39 = lshr i384 %r38, 1
%r40 = trunc i384 %r39 to i64
%r42 = getelementptr i64, i64* %r1, i32 0
store i64 %r40, i64* %r42
%r43 = lshr i384 %r39, 64
%r44 = trunc i384 %r43 to i64
%r46 = getelementptr i64, i64* %r1, i32 1
store i64 %r44, i64* %r46
%r47 = lshr i384 %r43, 64
%r48 = trunc i384 %r47 to i64
%r50 = getelementptr i64, i64* %r1, i32 2
store i64 %r48, i64* %r50
%r51 = lshr i384 %r47, 64
%r52 = trunc i384 %r51 to i64
%r54 = getelementptr i64, i64* %r1, i32 3
store i64 %r52, i64* %r54
%r55 = lshr i384 %r51, 64
%r56 = trunc i384 %r55 to i64
%r58 = getelementptr i64, i64* %r1, i32 4
store i64 %r56, i64* %r58
%r59 = lshr i384 %r55, 64
%r60 = trunc i384 %r59 to i64
%r62 = getelementptr i64, i64* %r1, i32 5
store i64 %r60, i64* %r62
ret void
}
define void @mcl_fp_add6L(i64* noalias  %r1, i64* noalias  %r2, i64* noalias  %r3, i64* noalias  %r4)
{
%r5 = load i64, i64* %r2
%r6 = zext i64 %r5 to i128
%r8 = getelementptr i64, i64* %r2, i32 1
%r9 = load i64, i64* %r8
%r10 = zext i64 %r9 to i128
%r11 = shl i128 %r10, 64
%r12 = or i128 %r6, %r11
%r13 = zext i128 %r12 to i192
%r15 = getelementptr i64, i64* %r2, i32 2
%r16 = load i64, i64* %r15
%r17 = zext i64 %r16 to i192
%r18 = shl i192 %r17, 128
%r19 = or i192 %r13, %r18
%r20 = zext i192 %r19 to i256
%r22 = getelementptr i64, i64* %r2, i32 3
%r23 = load i64, i64* %r22
%r24 = zext i64 %r23 to i256
%r25 = shl i256 %r24, 192
%r26 = or i256 %r20, %r25
%r27 = zext i256 %r26 to i320
%r29 = getelementptr i64, i64* %r2, i32 4
%r30 = load i64, i64* %r29
%r31 = zext i64 %r30 to i320
%r32 = shl i320 %r31, 256
%r33 = or i320 %r27, %r32
%r34 = zext i320 %r33 to i384
%r36 = getelementptr i64, i64* %r2, i32 5
%r37 = load i64, i64* %r36
%r38 = zext i64 %r37 to i384
%r39 = shl i384 %r38, 320
%r40 = or i384 %r34, %r39
%r41 = load i64, i64* %r3
%r42 = zext i64 %r41 to i128
%r44 = getelementptr i64, i64* %r3, i32 1
%r45 = load i64, i64* %r44
%r46 = zext i64 %r45 to i128
%r47 = shl i128 %r46, 64
%r48 = or i128 %r42, %r47
%r49 = zext i128 %r48 to i192
%r51 = getelementptr i64, i64* %r3, i32 2
%r52 = load i64, i64* %r51
%r53 = zext i64 %r52 to i192
%r54 = shl i192 %r53, 128
%r55 = or i192 %r49, %r54
%r56 = zext i192 %r55 to i256
%r58 = getelementptr i64, i64* %r3, i32 3
%r59 = load i64, i64* %r58
%r60 = zext i64 %r59 to i256
%r61 = shl i256 %r60, 192
%r62 = or i256 %r56, %r61
%r63 = zext i256 %r62 to i320
%r65 = getelementptr i64, i64* %r3, i32 4
%r66 = load i64, i64* %r65
%r67 = zext i64 %r66 to i320
%r68 = shl i320 %r67, 256
%r69 = or i320 %r63, %r68
%r70 = zext i320 %r69 to i384
%r72 = getelementptr i64, i64* %r3, i32 5
%r73 = load i64, i64* %r72
%r74 = zext i64 %r73 to i384
%r75 = shl i384 %r74, 320
%r76 = or i384 %r70, %r75
%r77 = zext i384 %r40 to i448
%r78 = zext i384 %r76 to i448
%r79 = add i448 %r77, %r78
%r80 = trunc i448 %r79 to i384
%r81 = trunc i384 %r80 to i64
%r83 = getelementptr i64, i64* %r1, i32 0
store i64 %r81, i64* %r83
%r84 = lshr i384 %r80, 64
%r85 = trunc i384 %r84 to i64
%r87 = getelementptr i64, i64* %r1, i32 1
store i64 %r85, i64* %r87
%r88 = lshr i384 %r84, 64
%r89 = trunc i384 %r88 to i64
%r91 = getelementptr i64, i64* %r1, i32 2
store i64 %r89, i64* %r91
%r92 = lshr i384 %r88, 64
%r93 = trunc i384 %r92 to i64
%r95 = getelementptr i64, i64* %r1, i32 3
store i64 %r93, i64* %r95
%r96 = lshr i384 %r92, 64
%r97 = trunc i384 %r96 to i64
%r99 = getelementptr i64, i64* %r1, i32 4
store i64 %r97, i64* %r99
%r100 = lshr i384 %r96, 64
%r101 = trunc i384 %r100 to i64
%r103 = getelementptr i64, i64* %r1, i32 5
store i64 %r101, i64* %r103
%r104 = load i64, i64* %r4
%r105 = zext i64 %r104 to i128
%r107 = getelementptr i64, i64* %r4, i32 1
%r108 = load i64, i64* %r107
%r109 = zext i64 %r108 to i128
%r110 = shl i128 %r109, 64
%r111 = or i128 %r105, %r110
%r112 = zext i128 %r111 to i192
%r114 = getelementptr i64, i64* %r4, i32 2
%r115 = load i64, i64* %r114
%r116 = zext i64 %r115 to i192
%r117 = shl i192 %r116, 128
%r118 = or i192 %r112, %r117
%r119 = zext i192 %r118 to i256
%r121 = getelementptr i64, i64* %r4, i32 3
%r122 = load i64, i64* %r121
%r123 = zext i64 %r122 to i256
%r124 = shl i256 %r123, 192
%r125 = or i256 %r119, %r124
%r126 = zext i256 %r125 to i320
%r128 = getelementptr i64, i64* %r4, i32 4
%r129 = load i64, i64* %r128
%r130 = zext i64 %r129 to i320
%r131 = shl i320 %r130, 256
%r132 = or i320 %r126, %r131
%r133 = zext i320 %r132 to i384
%r135 = getelementptr i64, i64* %r4, i32 5
%r136 = load i64, i64* %r135
%r137 = zext i64 %r136 to i384
%r138 = shl i384 %r137, 320
%r139 = or i384 %r133, %r138
%r140 = zext i384 %r139 to i448
%r141 = sub i448 %r79, %r140
%r142 = lshr i448 %r141, 384
%r143 = trunc i448 %r142 to i1
br i1%r143, label %carry, label %nocarry
nocarry:
%r144 = trunc i448 %r141 to i384
%r145 = trunc i384 %r144 to i64
%r147 = getelementptr i64, i64* %r1, i32 0
store i64 %r145, i64* %r147
%r148 = lshr i384 %r144, 64
%r149 = trunc i384 %r148 to i64
%r151 = getelementptr i64, i64* %r1, i32 1
store i64 %r149, i64* %r151
%r152 = lshr i384 %r148, 64
%r153 = trunc i384 %r152 to i64
%r155 = getelementptr i64, i64* %r1, i32 2
store i64 %r153, i64* %r155
%r156 = lshr i384 %r152, 64
%r157 = trunc i384 %r156 to i64
%r159 = getelementptr i64, i64* %r1, i32 3
store i64 %r157, i64* %r159
%r160 = lshr i384 %r156, 64
%r161 = trunc i384 %r160 to i64
%r163 = getelementptr i64, i64* %r1, i32 4
store i64 %r161, i64* %r163
%r164 = lshr i384 %r160, 64
%r165 = trunc i384 %r164 to i64
%r167 = getelementptr i64, i64* %r1, i32 5
store i64 %r165, i64* %r167
ret void
carry:
ret void
}
define void @mcl_fp_addNF6L(i64* noalias  %r1, i64* noalias  %r2, i64* noalias  %r3, i64* noalias  %r4)
{
%r5 = load i64, i64* %r2
%r6 = zext i64 %r5 to i128
%r8 = getelementptr i64, i64* %r2, i32 1
%r9 = load i64, i64* %r8
%r10 = zext i64 %r9 to i128
%r11 = shl i128 %r10, 64
%r12 = or i128 %r6, %r11
%r13 = zext i128 %r12 to i192
%r15 = getelementptr i64, i64* %r2, i32 2
%r16 = load i64, i64* %r15
%r17 = zext i64 %r16 to i192
%r18 = shl i192 %r17, 128
%r19 = or i192 %r13, %r18
%r20 = zext i192 %r19 to i256
%r22 = getelementptr i64, i64* %r2, i32 3
%r23 = load i64, i64* %r22
%r24 = zext i64 %r23 to i256
%r25 = shl i256 %r24, 192
%r26 = or i256 %r20, %r25
%r27 = zext i256 %r26 to i320
%r29 = getelementptr i64, i64* %r2, i32 4
%r30 = load i64, i64* %r29
%r31 = zext i64 %r30 to i320
%r32 = shl i320 %r31, 256
%r33 = or i320 %r27, %r32
%r34 = zext i320 %r33 to i384
%r36 = getelementptr i64, i64* %r2, i32 5
%r37 = load i64, i64* %r36
%r38 = zext i64 %r37 to i384
%r39 = shl i384 %r38, 320
%r40 = or i384 %r34, %r39
%r41 = load i64, i64* %r3
%r42 = zext i64 %r41 to i128
%r44 = getelementptr i64, i64* %r3, i32 1
%r45 = load i64, i64* %r44
%r46 = zext i64 %r45 to i128
%r47 = shl i128 %r46, 64
%r48 = or i128 %r42, %r47
%r49 = zext i128 %r48 to i192
%r51 = getelementptr i64, i64* %r3, i32 2
%r52 = load i64, i64* %r51
%r53 = zext i64 %r52 to i192
%r54 = shl i192 %r53, 128
%r55 = or i192 %r49, %r54
%r56 = zext i192 %r55 to i256
%r58 = getelementptr i64, i64* %r3, i32 3
%r59 = load i64, i64* %r58
%r60 = zext i64 %r59 to i256
%r61 = shl i256 %r60, 192
%r62 = or i256 %r56, %r61
%r63 = zext i256 %r62 to i320
%r65 = getelementptr i64, i64* %r3, i32 4
%r66 = load i64, i64* %r65
%r67 = zext i64 %r66 to i320
%r68 = shl i320 %r67, 256
%r69 = or i320 %r63, %r68
%r70 = zext i320 %r69 to i384
%r72 = getelementptr i64, i64* %r3, i32 5
%r73 = load i64, i64* %r72
%r74 = zext i64 %r73 to i384
%r75 = shl i384 %r74, 320
%r76 = or i384 %r70, %r75
%r77 = add i384 %r40, %r76
%r78 = load i64, i64* %r4
%r79 = zext i64 %r78 to i128
%r81 = getelementptr i64, i64* %r4, i32 1
%r82 = load i64, i64* %r81
%r83 = zext i64 %r82 to i128
%r84 = shl i128 %r83, 64
%r85 = or i128 %r79, %r84
%r86 = zext i128 %r85 to i192
%r88 = getelementptr i64, i64* %r4, i32 2
%r89 = load i64, i64* %r88
%r90 = zext i64 %r89 to i192
%r91 = shl i192 %r90, 128
%r92 = or i192 %r86, %r91
%r93 = zext i192 %r92 to i256
%r95 = getelementptr i64, i64* %r4, i32 3
%r96 = load i64, i64* %r95
%r97 = zext i64 %r96 to i256
%r98 = shl i256 %r97, 192
%r99 = or i256 %r93, %r98
%r100 = zext i256 %r99 to i320
%r102 = getelementptr i64, i64* %r4, i32 4
%r103 = load i64, i64* %r102
%r104 = zext i64 %r103 to i320
%r105 = shl i320 %r104, 256
%r106 = or i320 %r100, %r105
%r107 = zext i320 %r106 to i384
%r109 = getelementptr i64, i64* %r4, i32 5
%r110 = load i64, i64* %r109
%r111 = zext i64 %r110 to i384
%r112 = shl i384 %r111, 320
%r113 = or i384 %r107, %r112
%r114 = sub i384 %r77, %r113
%r115 = lshr i384 %r114, 383
%r116 = trunc i384 %r115 to i1
%r117 = select i1 %r116, i384 %r77, i384 %r114
%r118 = trunc i384 %r117 to i64
%r120 = getelementptr i64, i64* %r1, i32 0
store i64 %r118, i64* %r120
%r121 = lshr i384 %r117, 64
%r122 = trunc i384 %r121 to i64
%r124 = getelementptr i64, i64* %r1, i32 1
store i64 %r122, i64* %r124
%r125 = lshr i384 %r121, 64
%r126 = trunc i384 %r125 to i64
%r128 = getelementptr i64, i64* %r1, i32 2
store i64 %r126, i64* %r128
%r129 = lshr i384 %r125, 64
%r130 = trunc i384 %r129 to i64
%r132 = getelementptr i64, i64* %r1, i32 3
store i64 %r130, i64* %r132
%r133 = lshr i384 %r129, 64
%r134 = trunc i384 %r133 to i64
%r136 = getelementptr i64, i64* %r1, i32 4
store i64 %r134, i64* %r136
%r137 = lshr i384 %r133, 64
%r138 = trunc i384 %r137 to i64
%r140 = getelementptr i64, i64* %r1, i32 5
store i64 %r138, i64* %r140
ret void
}
define void @mcl_fp_sub6L(i64* noalias  %r1, i64* noalias  %r2, i64* noalias  %r3, i64* noalias  %r4)
{
%r5 = load i64, i64* %r2
%r6 = zext i64 %r5 to i128
%r8 = getelementptr i64, i64* %r2, i32 1
%r9 = load i64, i64* %r8
%r10 = zext i64 %r9 to i128
%r11 = shl i128 %r10, 64
%r12 = or i128 %r6, %r11
%r13 = zext i128 %r12 to i192
%r15 = getelementptr i64, i64* %r2, i32 2
%r16 = load i64, i64* %r15
%r17 = zext i64 %r16 to i192
%r18 = shl i192 %r17, 128
%r19 = or i192 %r13, %r18
%r20 = zext i192 %r19 to i256
%r22 = getelementptr i64, i64* %r2, i32 3
%r23 = load i64, i64* %r22
%r24 = zext i64 %r23 to i256
%r25 = shl i256 %r24, 192
%r26 = or i256 %r20, %r25
%r27 = zext i256 %r26 to i320
%r29 = getelementptr i64, i64* %r2, i32 4
%r30 = load i64, i64* %r29
%r31 = zext i64 %r30 to i320
%r32 = shl i320 %r31, 256
%r33 = or i320 %r27, %r32
%r34 = zext i320 %r33 to i384
%r36 = getelementptr i64, i64* %r2, i32 5
%r37 = load i64, i64* %r36
%r38 = zext i64 %r37 to i384
%r39 = shl i384 %r38, 320
%r40 = or i384 %r34, %r39
%r41 = load i64, i64* %r3
%r42 = zext i64 %r41 to i128
%r44 = getelementptr i64, i64* %r3, i32 1
%r45 = load i64, i64* %r44
%r46 = zext i64 %r45 to i128
%r47 = shl i128 %r46, 64
%r48 = or i128 %r42, %r47
%r49 = zext i128 %r48 to i192
%r51 = getelementptr i64, i64* %r3, i32 2
%r52 = load i64, i64* %r51
%r53 = zext i64 %r52 to i192
%r54 = shl i192 %r53, 128
%r55 = or i192 %r49, %r54
%r56 = zext i192 %r55 to i256
%r58 = getelementptr i64, i64* %r3, i32 3
%r59 = load i64, i64* %r58
%r60 = zext i64 %r59 to i256
%r61 = shl i256 %r60, 192
%r62 = or i256 %r56, %r61
%r63 = zext i256 %r62 to i320
%r65 = getelementptr i64, i64* %r3, i32 4
%r66 = load i64, i64* %r65
%r67 = zext i64 %r66 to i320
%r68 = shl i320 %r67, 256
%r69 = or i320 %r63, %r68
%r70 = zext i320 %r69 to i384
%r72 = getelementptr i64, i64* %r3, i32 5
%r73 = load i64, i64* %r72
%r74 = zext i64 %r73 to i384
%r75 = shl i384 %r74, 320
%r76 = or i384 %r70, %r75
%r77 = zext i384 %r40 to i448
%r78 = zext i384 %r76 to i448
%r79 = sub i448 %r77, %r78
%r80 = trunc i448 %r79 to i384
%r81 = lshr i448 %r79, 384
%r82 = trunc i448 %r81 to i1
%r83 = trunc i384 %r80 to i64
%r85 = getelementptr i64, i64* %r1, i32 0
store i64 %r83, i64* %r85
%r86 = lshr i384 %r80, 64
%r87 = trunc i384 %r86 to i64
%r89 = getelementptr i64, i64* %r1, i32 1
store i64 %r87, i64* %r89
%r90 = lshr i384 %r86, 64
%r91 = trunc i384 %r90 to i64
%r93 = getelementptr i64, i64* %r1, i32 2
store i64 %r91, i64* %r93
%r94 = lshr i384 %r90, 64
%r95 = trunc i384 %r94 to i64
%r97 = getelementptr i64, i64* %r1, i32 3
store i64 %r95, i64* %r97
%r98 = lshr i384 %r94, 64
%r99 = trunc i384 %r98 to i64
%r101 = getelementptr i64, i64* %r1, i32 4
store i64 %r99, i64* %r101
%r102 = lshr i384 %r98, 64
%r103 = trunc i384 %r102 to i64
%r105 = getelementptr i64, i64* %r1, i32 5
store i64 %r103, i64* %r105
br i1%r82, label %carry, label %nocarry
nocarry:
ret void
carry:
%r106 = load i64, i64* %r4
%r107 = zext i64 %r106 to i128
%r109 = getelementptr i64, i64* %r4, i32 1
%r110 = load i64, i64* %r109
%r111 = zext i64 %r110 to i128
%r112 = shl i128 %r111, 64
%r113 = or i128 %r107, %r112
%r114 = zext i128 %r113 to i192
%r116 = getelementptr i64, i64* %r4, i32 2
%r117 = load i64, i64* %r116
%r118 = zext i64 %r117 to i192
%r119 = shl i192 %r118, 128
%r120 = or i192 %r114, %r119
%r121 = zext i192 %r120 to i256
%r123 = getelementptr i64, i64* %r4, i32 3
%r124 = load i64, i64* %r123
%r125 = zext i64 %r124 to i256
%r126 = shl i256 %r125, 192
%r127 = or i256 %r121, %r126
%r128 = zext i256 %r127 to i320
%r130 = getelementptr i64, i64* %r4, i32 4
%r131 = load i64, i64* %r130
%r132 = zext i64 %r131 to i320
%r133 = shl i320 %r132, 256
%r134 = or i320 %r128, %r133
%r135 = zext i320 %r134 to i384
%r137 = getelementptr i64, i64* %r4, i32 5
%r138 = load i64, i64* %r137
%r139 = zext i64 %r138 to i384
%r140 = shl i384 %r139, 320
%r141 = or i384 %r135, %r140
%r142 = add i384 %r80, %r141
%r143 = trunc i384 %r142 to i64
%r145 = getelementptr i64, i64* %r1, i32 0
store i64 %r143, i64* %r145
%r146 = lshr i384 %r142, 64
%r147 = trunc i384 %r146 to i64
%r149 = getelementptr i64, i64* %r1, i32 1
store i64 %r147, i64* %r149
%r150 = lshr i384 %r146, 64
%r151 = trunc i384 %r150 to i64
%r153 = getelementptr i64, i64* %r1, i32 2
store i64 %r151, i64* %r153
%r154 = lshr i384 %r150, 64
%r155 = trunc i384 %r154 to i64
%r157 = getelementptr i64, i64* %r1, i32 3
store i64 %r155, i64* %r157
%r158 = lshr i384 %r154, 64
%r159 = trunc i384 %r158 to i64
%r161 = getelementptr i64, i64* %r1, i32 4
store i64 %r159, i64* %r161
%r162 = lshr i384 %r158, 64
%r163 = trunc i384 %r162 to i64
%r165 = getelementptr i64, i64* %r1, i32 5
store i64 %r163, i64* %r165
ret void
}
define void @mcl_fp_subNF6L(i64* noalias  %r1, i64* noalias  %r2, i64* noalias  %r3, i64* noalias  %r4)
{
%r5 = load i64, i64* %r2
%r6 = zext i64 %r5 to i128
%r8 = getelementptr i64, i64* %r2, i32 1
%r9 = load i64, i64* %r8
%r10 = zext i64 %r9 to i128
%r11 = shl i128 %r10, 64
%r12 = or i128 %r6, %r11
%r13 = zext i128 %r12 to i192
%r15 = getelementptr i64, i64* %r2, i32 2
%r16 = load i64, i64* %r15
%r17 = zext i64 %r16 to i192
%r18 = shl i192 %r17, 128
%r19 = or i192 %r13, %r18
%r20 = zext i192 %r19 to i256
%r22 = getelementptr i64, i64* %r2, i32 3
%r23 = load i64, i64* %r22
%r24 = zext i64 %r23 to i256
%r25 = shl i256 %r24, 192
%r26 = or i256 %r20, %r25
%r27 = zext i256 %r26 to i320
%r29 = getelementptr i64, i64* %r2, i32 4
%r30 = load i64, i64* %r29
%r31 = zext i64 %r30 to i320
%r32 = shl i320 %r31, 256
%r33 = or i320 %r27, %r32
%r34 = zext i320 %r33 to i384
%r36 = getelementptr i64, i64* %r2, i32 5
%r37 = load i64, i64* %r36
%r38 = zext i64 %r37 to i384
%r39 = shl i384 %r38, 320
%r40 = or i384 %r34, %r39
%r41 = load i64, i64* %r3
%r42 = zext i64 %r41 to i128
%r44 = getelementptr i64, i64* %r3, i32 1
%r45 = load i64, i64* %r44
%r46 = zext i64 %r45 to i128
%r47 = shl i128 %r46, 64
%r48 = or i128 %r42, %r47
%r49 = zext i128 %r48 to i192
%r51 = getelementptr i64, i64* %r3, i32 2
%r52 = load i64, i64* %r51
%r53 = zext i64 %r52 to i192
%r54 = shl i192 %r53, 128
%r55 = or i192 %r49, %r54
%r56 = zext i192 %r55 to i256
%r58 = getelementptr i64, i64* %r3, i32 3
%r59 = load i64, i64* %r58
%r60 = zext i64 %r59 to i256
%r61 = shl i256 %r60, 192
%r62 = or i256 %r56, %r61
%r63 = zext i256 %r62 to i320
%r65 = getelementptr i64, i64* %r3, i32 4
%r66 = load i64, i64* %r65
%r67 = zext i64 %r66 to i320
%r68 = shl i320 %r67, 256
%r69 = or i320 %r63, %r68
%r70 = zext i320 %r69 to i384
%r72 = getelementptr i64, i64* %r3, i32 5
%r73 = load i64, i64* %r72
%r74 = zext i64 %r73 to i384
%r75 = shl i384 %r74, 320
%r76 = or i384 %r70, %r75
%r77 = sub i384 %r40, %r76
%r78 = lshr i384 %r77, 383
%r79 = trunc i384 %r78 to i1
%r80 = load i64, i64* %r4
%r81 = zext i64 %r80 to i128
%r83 = getelementptr i64, i64* %r4, i32 1
%r84 = load i64, i64* %r83
%r85 = zext i64 %r84 to i128
%r86 = shl i128 %r85, 64
%r87 = or i128 %r81, %r86
%r88 = zext i128 %r87 to i192
%r90 = getelementptr i64, i64* %r4, i32 2
%r91 = load i64, i64* %r90
%r92 = zext i64 %r91 to i192
%r93 = shl i192 %r92, 128
%r94 = or i192 %r88, %r93
%r95 = zext i192 %r94 to i256
%r97 = getelementptr i64, i64* %r4, i32 3
%r98 = load i64, i64* %r97
%r99 = zext i64 %r98 to i256
%r100 = shl i256 %r99, 192
%r101 = or i256 %r95, %r100
%r102 = zext i256 %r101 to i320
%r104 = getelementptr i64, i64* %r4, i32 4
%r105 = load i64, i64* %r104
%r106 = zext i64 %r105 to i320
%r107 = shl i320 %r106, 256
%r108 = or i320 %r102, %r107
%r109 = zext i320 %r108 to i384
%r111 = getelementptr i64, i64* %r4, i32 5
%r112 = load i64, i64* %r111
%r113 = zext i64 %r112 to i384
%r114 = shl i384 %r113, 320
%r115 = or i384 %r109, %r114
%r117 = select i1 %r79, i384 %r115, i384 0
%r118 = add i384 %r77, %r117
%r119 = trunc i384 %r118 to i64
%r121 = getelementptr i64, i64* %r1, i32 0
store i64 %r119, i64* %r121
%r122 = lshr i384 %r118, 64
%r123 = trunc i384 %r122 to i64
%r125 = getelementptr i64, i64* %r1, i32 1
store i64 %r123, i64* %r125
%r126 = lshr i384 %r122, 64
%r127 = trunc i384 %r126 to i64
%r129 = getelementptr i64, i64* %r1, i32 2
store i64 %r127, i64* %r129
%r130 = lshr i384 %r126, 64
%r131 = trunc i384 %r130 to i64
%r133 = getelementptr i64, i64* %r1, i32 3
store i64 %r131, i64* %r133
%r134 = lshr i384 %r130, 64
%r135 = trunc i384 %r134 to i64
%r137 = getelementptr i64, i64* %r1, i32 4
store i64 %r135, i64* %r137
%r138 = lshr i384 %r134, 64
%r139 = trunc i384 %r138 to i64
%r141 = getelementptr i64, i64* %r1, i32 5
store i64 %r139, i64* %r141
ret void
}
define void @mcl_fpDbl_add6L(i64* noalias  %r1, i64* noalias  %r2, i64* noalias  %r3, i64* noalias  %r4)
{
%r5 = load i64, i64* %r2
%r6 = zext i64 %r5 to i128
%r8 = getelementptr i64, i64* %r2, i32 1
%r9 = load i64, i64* %r8
%r10 = zext i64 %r9 to i128
%r11 = shl i128 %r10, 64
%r12 = or i128 %r6, %r11
%r13 = zext i128 %r12 to i192
%r15 = getelementptr i64, i64* %r2, i32 2
%r16 = load i64, i64* %r15
%r17 = zext i64 %r16 to i192
%r18 = shl i192 %r17, 128
%r19 = or i192 %r13, %r18
%r20 = zext i192 %r19 to i256
%r22 = getelementptr i64, i64* %r2, i32 3
%r23 = load i64, i64* %r22
%r24 = zext i64 %r23 to i256
%r25 = shl i256 %r24, 192
%r26 = or i256 %r20, %r25
%r27 = zext i256 %r26 to i320
%r29 = getelementptr i64, i64* %r2, i32 4
%r30 = load i64, i64* %r29
%r31 = zext i64 %r30 to i320
%r32 = shl i320 %r31, 256
%r33 = or i320 %r27, %r32
%r34 = zext i320 %r33 to i384
%r36 = getelementptr i64, i64* %r2, i32 5
%r37 = load i64, i64* %r36
%r38 = zext i64 %r37 to i384
%r39 = shl i384 %r38, 320
%r40 = or i384 %r34, %r39
%r41 = zext i384 %r40 to i448
%r43 = getelementptr i64, i64* %r2, i32 6
%r44 = load i64, i64* %r43
%r45 = zext i64 %r44 to i448
%r46 = shl i448 %r45, 384
%r47 = or i448 %r41, %r46
%r48 = zext i448 %r47 to i512
%r50 = getelementptr i64, i64* %r2, i32 7
%r51 = load i64, i64* %r50
%r52 = zext i64 %r51 to i512
%r53 = shl i512 %r52, 448
%r54 = or i512 %r48, %r53
%r55 = zext i512 %r54 to i576
%r57 = getelementptr i64, i64* %r2, i32 8
%r58 = load i64, i64* %r57
%r59 = zext i64 %r58 to i576
%r60 = shl i576 %r59, 512
%r61 = or i576 %r55, %r60
%r62 = zext i576 %r61 to i640
%r64 = getelementptr i64, i64* %r2, i32 9
%r65 = load i64, i64* %r64
%r66 = zext i64 %r65 to i640
%r67 = shl i640 %r66, 576
%r68 = or i640 %r62, %r67
%r69 = zext i640 %r68 to i704
%r71 = getelementptr i64, i64* %r2, i32 10
%r72 = load i64, i64* %r71
%r73 = zext i64 %r72 to i704
%r74 = shl i704 %r73, 640
%r75 = or i704 %r69, %r74
%r76 = zext i704 %r75 to i768
%r78 = getelementptr i64, i64* %r2, i32 11
%r79 = load i64, i64* %r78
%r80 = zext i64 %r79 to i768
%r81 = shl i768 %r80, 704
%r82 = or i768 %r76, %r81
%r83 = load i64, i64* %r3
%r84 = zext i64 %r83 to i128
%r86 = getelementptr i64, i64* %r3, i32 1
%r87 = load i64, i64* %r86
%r88 = zext i64 %r87 to i128
%r89 = shl i128 %r88, 64
%r90 = or i128 %r84, %r89
%r91 = zext i128 %r90 to i192
%r93 = getelementptr i64, i64* %r3, i32 2
%r94 = load i64, i64* %r93
%r95 = zext i64 %r94 to i192
%r96 = shl i192 %r95, 128
%r97 = or i192 %r91, %r96
%r98 = zext i192 %r97 to i256
%r100 = getelementptr i64, i64* %r3, i32 3
%r101 = load i64, i64* %r100
%r102 = zext i64 %r101 to i256
%r103 = shl i256 %r102, 192
%r104 = or i256 %r98, %r103
%r105 = zext i256 %r104 to i320
%r107 = getelementptr i64, i64* %r3, i32 4
%r108 = load i64, i64* %r107
%r109 = zext i64 %r108 to i320
%r110 = shl i320 %r109, 256
%r111 = or i320 %r105, %r110
%r112 = zext i320 %r111 to i384
%r114 = getelementptr i64, i64* %r3, i32 5
%r115 = load i64, i64* %r114
%r116 = zext i64 %r115 to i384
%r117 = shl i384 %r116, 320
%r118 = or i384 %r112, %r117
%r119 = zext i384 %r118 to i448
%r121 = getelementptr i64, i64* %r3, i32 6
%r122 = load i64, i64* %r121
%r123 = zext i64 %r122 to i448
%r124 = shl i448 %r123, 384
%r125 = or i448 %r119, %r124
%r126 = zext i448 %r125 to i512
%r128 = getelementptr i64, i64* %r3, i32 7
%r129 = load i64, i64* %r128
%r130 = zext i64 %r129 to i512
%r131 = shl i512 %r130, 448
%r132 = or i512 %r126, %r131
%r133 = zext i512 %r132 to i576
%r135 = getelementptr i64, i64* %r3, i32 8
%r136 = load i64, i64* %r135
%r137 = zext i64 %r136 to i576
%r138 = shl i576 %r137, 512
%r139 = or i576 %r133, %r138
%r140 = zext i576 %r139 to i640
%r142 = getelementptr i64, i64* %r3, i32 9
%r143 = load i64, i64* %r142
%r144 = zext i64 %r143 to i640
%r145 = shl i640 %r144, 576
%r146 = or i640 %r140, %r145
%r147 = zext i640 %r146 to i704
%r149 = getelementptr i64, i64* %r3, i32 10
%r150 = load i64, i64* %r149
%r151 = zext i64 %r150 to i704
%r152 = shl i704 %r151, 640
%r153 = or i704 %r147, %r152
%r154 = zext i704 %r153 to i768
%r156 = getelementptr i64, i64* %r3, i32 11
%r157 = load i64, i64* %r156
%r158 = zext i64 %r157 to i768
%r159 = shl i768 %r158, 704
%r160 = or i768 %r154, %r159
%r161 = zext i768 %r82 to i832
%r162 = zext i768 %r160 to i832
%r163 = add i832 %r161, %r162
%r164 = trunc i832 %r163 to i384
%r165 = trunc i384 %r164 to i64
%r167 = getelementptr i64, i64* %r1, i32 0
store i64 %r165, i64* %r167
%r168 = lshr i384 %r164, 64
%r169 = trunc i384 %r168 to i64
%r171 = getelementptr i64, i64* %r1, i32 1
store i64 %r169, i64* %r171
%r172 = lshr i384 %r168, 64
%r173 = trunc i384 %r172 to i64
%r175 = getelementptr i64, i64* %r1, i32 2
store i64 %r173, i64* %r175
%r176 = lshr i384 %r172, 64
%r177 = trunc i384 %r176 to i64
%r179 = getelementptr i64, i64* %r1, i32 3
store i64 %r177, i64* %r179
%r180 = lshr i384 %r176, 64
%r181 = trunc i384 %r180 to i64
%r183 = getelementptr i64, i64* %r1, i32 4
store i64 %r181, i64* %r183
%r184 = lshr i384 %r180, 64
%r185 = trunc i384 %r184 to i64
%r187 = getelementptr i64, i64* %r1, i32 5
store i64 %r185, i64* %r187
%r188 = lshr i832 %r163, 384
%r189 = trunc i832 %r188 to i448
%r190 = load i64, i64* %r4
%r191 = zext i64 %r190 to i128
%r193 = getelementptr i64, i64* %r4, i32 1
%r194 = load i64, i64* %r193
%r195 = zext i64 %r194 to i128
%r196 = shl i128 %r195, 64
%r197 = or i128 %r191, %r196
%r198 = zext i128 %r197 to i192
%r200 = getelementptr i64, i64* %r4, i32 2
%r201 = load i64, i64* %r200
%r202 = zext i64 %r201 to i192
%r203 = shl i192 %r202, 128
%r204 = or i192 %r198, %r203
%r205 = zext i192 %r204 to i256
%r207 = getelementptr i64, i64* %r4, i32 3
%r208 = load i64, i64* %r207
%r209 = zext i64 %r208 to i256
%r210 = shl i256 %r209, 192
%r211 = or i256 %r205, %r210
%r212 = zext i256 %r211 to i320
%r214 = getelementptr i64, i64* %r4, i32 4
%r215 = load i64, i64* %r214
%r216 = zext i64 %r215 to i320
%r217 = shl i320 %r216, 256
%r218 = or i320 %r212, %r217
%r219 = zext i320 %r218 to i384
%r221 = getelementptr i64, i64* %r4, i32 5
%r222 = load i64, i64* %r221
%r223 = zext i64 %r222 to i384
%r224 = shl i384 %r223, 320
%r225 = or i384 %r219, %r224
%r226 = zext i384 %r225 to i448
%r227 = sub i448 %r189, %r226
%r228 = lshr i448 %r227, 384
%r229 = trunc i448 %r228 to i1
%r230 = select i1 %r229, i448 %r189, i448 %r227
%r231 = trunc i448 %r230 to i384
%r233 = getelementptr i64, i64* %r1, i32 6
%r234 = trunc i384 %r231 to i64
%r236 = getelementptr i64, i64* %r233, i32 0
store i64 %r234, i64* %r236
%r237 = lshr i384 %r231, 64
%r238 = trunc i384 %r237 to i64
%r240 = getelementptr i64, i64* %r233, i32 1
store i64 %r238, i64* %r240
%r241 = lshr i384 %r237, 64
%r242 = trunc i384 %r241 to i64
%r244 = getelementptr i64, i64* %r233, i32 2
store i64 %r242, i64* %r244
%r245 = lshr i384 %r241, 64
%r246 = trunc i384 %r245 to i64
%r248 = getelementptr i64, i64* %r233, i32 3
store i64 %r246, i64* %r248
%r249 = lshr i384 %r245, 64
%r250 = trunc i384 %r249 to i64
%r252 = getelementptr i64, i64* %r233, i32 4
store i64 %r250, i64* %r252
%r253 = lshr i384 %r249, 64
%r254 = trunc i384 %r253 to i64
%r256 = getelementptr i64, i64* %r233, i32 5
store i64 %r254, i64* %r256
ret void
}
define void @mcl_fpDbl_sub6L(i64* noalias  %r1, i64* noalias  %r2, i64* noalias  %r3, i64* noalias  %r4)
{
%r5 = load i64, i64* %r2
%r6 = zext i64 %r5 to i128
%r8 = getelementptr i64, i64* %r2, i32 1
%r9 = load i64, i64* %r8
%r10 = zext i64 %r9 to i128
%r11 = shl i128 %r10, 64
%r12 = or i128 %r6, %r11
%r13 = zext i128 %r12 to i192
%r15 = getelementptr i64, i64* %r2, i32 2
%r16 = load i64, i64* %r15
%r17 = zext i64 %r16 to i192
%r18 = shl i192 %r17, 128
%r19 = or i192 %r13, %r18
%r20 = zext i192 %r19 to i256
%r22 = getelementptr i64, i64* %r2, i32 3
%r23 = load i64, i64* %r22
%r24 = zext i64 %r23 to i256
%r25 = shl i256 %r24, 192
%r26 = or i256 %r20, %r25
%r27 = zext i256 %r26 to i320
%r29 = getelementptr i64, i64* %r2, i32 4
%r30 = load i64, i64* %r29
%r31 = zext i64 %r30 to i320
%r32 = shl i320 %r31, 256
%r33 = or i320 %r27, %r32
%r34 = zext i320 %r33 to i384
%r36 = getelementptr i64, i64* %r2, i32 5
%r37 = load i64, i64* %r36
%r38 = zext i64 %r37 to i384
%r39 = shl i384 %r38, 320
%r40 = or i384 %r34, %r39
%r41 = zext i384 %r40 to i448
%r43 = getelementptr i64, i64* %r2, i32 6
%r44 = load i64, i64* %r43
%r45 = zext i64 %r44 to i448
%r46 = shl i448 %r45, 384
%r47 = or i448 %r41, %r46
%r48 = zext i448 %r47 to i512
%r50 = getelementptr i64, i64* %r2, i32 7
%r51 = load i64, i64* %r50
%r52 = zext i64 %r51 to i512
%r53 = shl i512 %r52, 448
%r54 = or i512 %r48, %r53
%r55 = zext i512 %r54 to i576
%r57 = getelementptr i64, i64* %r2, i32 8
%r58 = load i64, i64* %r57
%r59 = zext i64 %r58 to i576
%r60 = shl i576 %r59, 512
%r61 = or i576 %r55, %r60
%r62 = zext i576 %r61 to i640
%r64 = getelementptr i64, i64* %r2, i32 9
%r65 = load i64, i64* %r64
%r66 = zext i64 %r65 to i640
%r67 = shl i640 %r66, 576
%r68 = or i640 %r62, %r67
%r69 = zext i640 %r68 to i704
%r71 = getelementptr i64, i64* %r2, i32 10
%r72 = load i64, i64* %r71
%r73 = zext i64 %r72 to i704
%r74 = shl i704 %r73, 640
%r75 = or i704 %r69, %r74
%r76 = zext i704 %r75 to i768
%r78 = getelementptr i64, i64* %r2, i32 11
%r79 = load i64, i64* %r78
%r80 = zext i64 %r79 to i768
%r81 = shl i768 %r80, 704
%r82 = or i768 %r76, %r81
%r83 = load i64, i64* %r3
%r84 = zext i64 %r83 to i128
%r86 = getelementptr i64, i64* %r3, i32 1
%r87 = load i64, i64* %r86
%r88 = zext i64 %r87 to i128
%r89 = shl i128 %r88, 64
%r90 = or i128 %r84, %r89
%r91 = zext i128 %r90 to i192
%r93 = getelementptr i64, i64* %r3, i32 2
%r94 = load i64, i64* %r93
%r95 = zext i64 %r94 to i192
%r96 = shl i192 %r95, 128
%r97 = or i192 %r91, %r96
%r98 = zext i192 %r97 to i256
%r100 = getelementptr i64, i64* %r3, i32 3
%r101 = load i64, i64* %r100
%r102 = zext i64 %r101 to i256
%r103 = shl i256 %r102, 192
%r104 = or i256 %r98, %r103
%r105 = zext i256 %r104 to i320
%r107 = getelementptr i64, i64* %r3, i32 4
%r108 = load i64, i64* %r107
%r109 = zext i64 %r108 to i320
%r110 = shl i320 %r109, 256
%r111 = or i320 %r105, %r110
%r112 = zext i320 %r111 to i384
%r114 = getelementptr i64, i64* %r3, i32 5
%r115 = load i64, i64* %r114
%r116 = zext i64 %r115 to i384
%r117 = shl i384 %r116, 320
%r118 = or i384 %r112, %r117
%r119 = zext i384 %r118 to i448
%r121 = getelementptr i64, i64* %r3, i32 6
%r122 = load i64, i64* %r121
%r123 = zext i64 %r122 to i448
%r124 = shl i448 %r123, 384
%r125 = or i448 %r119, %r124
%r126 = zext i448 %r125 to i512
%r128 = getelementptr i64, i64* %r3, i32 7
%r129 = load i64, i64* %r128
%r130 = zext i64 %r129 to i512
%r131 = shl i512 %r130, 448
%r132 = or i512 %r126, %r131
%r133 = zext i512 %r132 to i576
%r135 = getelementptr i64, i64* %r3, i32 8
%r136 = load i64, i64* %r135
%r137 = zext i64 %r136 to i576
%r138 = shl i576 %r137, 512
%r139 = or i576 %r133, %r138
%r140 = zext i576 %r139 to i640
%r142 = getelementptr i64, i64* %r3, i32 9
%r143 = load i64, i64* %r142
%r144 = zext i64 %r143 to i640
%r145 = shl i640 %r144, 576
%r146 = or i640 %r140, %r145
%r147 = zext i640 %r146 to i704
%r149 = getelementptr i64, i64* %r3, i32 10
%r150 = load i64, i64* %r149
%r151 = zext i64 %r150 to i704
%r152 = shl i704 %r151, 640
%r153 = or i704 %r147, %r152
%r154 = zext i704 %r153 to i768
%r156 = getelementptr i64, i64* %r3, i32 11
%r157 = load i64, i64* %r156
%r158 = zext i64 %r157 to i768
%r159 = shl i768 %r158, 704
%r160 = or i768 %r154, %r159
%r161 = zext i768 %r82 to i832
%r162 = zext i768 %r160 to i832
%r163 = sub i832 %r161, %r162
%r164 = trunc i832 %r163 to i384
%r165 = trunc i384 %r164 to i64
%r167 = getelementptr i64, i64* %r1, i32 0
store i64 %r165, i64* %r167
%r168 = lshr i384 %r164, 64
%r169 = trunc i384 %r168 to i64
%r171 = getelementptr i64, i64* %r1, i32 1
store i64 %r169, i64* %r171
%r172 = lshr i384 %r168, 64
%r173 = trunc i384 %r172 to i64
%r175 = getelementptr i64, i64* %r1, i32 2
store i64 %r173, i64* %r175
%r176 = lshr i384 %r172, 64
%r177 = trunc i384 %r176 to i64
%r179 = getelementptr i64, i64* %r1, i32 3
store i64 %r177, i64* %r179
%r180 = lshr i384 %r176, 64
%r181 = trunc i384 %r180 to i64
%r183 = getelementptr i64, i64* %r1, i32 4
store i64 %r181, i64* %r183
%r184 = lshr i384 %r180, 64
%r185 = trunc i384 %r184 to i64
%r187 = getelementptr i64, i64* %r1, i32 5
store i64 %r185, i64* %r187
%r188 = lshr i832 %r163, 384
%r189 = trunc i832 %r188 to i384
%r190 = lshr i832 %r163, 768
%r191 = trunc i832 %r190 to i1
%r192 = load i64, i64* %r4
%r193 = zext i64 %r192 to i128
%r195 = getelementptr i64, i64* %r4, i32 1
%r196 = load i64, i64* %r195
%r197 = zext i64 %r196 to i128
%r198 = shl i128 %r197, 64
%r199 = or i128 %r193, %r198
%r200 = zext i128 %r199 to i192
%r202 = getelementptr i64, i64* %r4, i32 2
%r203 = load i64, i64* %r202
%r204 = zext i64 %r203 to i192
%r205 = shl i192 %r204, 128
%r206 = or i192 %r200, %r205
%r207 = zext i192 %r206 to i256
%r209 = getelementptr i64, i64* %r4, i32 3
%r210 = load i64, i64* %r209
%r211 = zext i64 %r210 to i256
%r212 = shl i256 %r211, 192
%r213 = or i256 %r207, %r212
%r214 = zext i256 %r213 to i320
%r216 = getelementptr i64, i64* %r4, i32 4
%r217 = load i64, i64* %r216
%r218 = zext i64 %r217 to i320
%r219 = shl i320 %r218, 256
%r220 = or i320 %r214, %r219
%r221 = zext i320 %r220 to i384
%r223 = getelementptr i64, i64* %r4, i32 5
%r224 = load i64, i64* %r223
%r225 = zext i64 %r224 to i384
%r226 = shl i384 %r225, 320
%r227 = or i384 %r221, %r226
%r229 = select i1 %r191, i384 %r227, i384 0
%r230 = add i384 %r189, %r229
%r232 = getelementptr i64, i64* %r1, i32 6
%r233 = trunc i384 %r230 to i64
%r235 = getelementptr i64, i64* %r232, i32 0
store i64 %r233, i64* %r235
%r236 = lshr i384 %r230, 64
%r237 = trunc i384 %r236 to i64
%r239 = getelementptr i64, i64* %r232, i32 1
store i64 %r237, i64* %r239
%r240 = lshr i384 %r236, 64
%r241 = trunc i384 %r240 to i64
%r243 = getelementptr i64, i64* %r232, i32 2
store i64 %r241, i64* %r243
%r244 = lshr i384 %r240, 64
%r245 = trunc i384 %r244 to i64
%r247 = getelementptr i64, i64* %r232, i32 3
store i64 %r245, i64* %r247
%r248 = lshr i384 %r244, 64
%r249 = trunc i384 %r248 to i64
%r251 = getelementptr i64, i64* %r232, i32 4
store i64 %r249, i64* %r251
%r252 = lshr i384 %r248, 64
%r253 = trunc i384 %r252 to i64
%r255 = getelementptr i64, i64* %r232, i32 5
store i64 %r253, i64* %r255
ret void
}
define i512 @mulPv448x64(i64* noalias  %r2, i64 %r3)
{
%r5 = call i128 @mulPos64x64(i64* %r2, i64 %r3, i64 0)
%r6 = trunc i128 %r5 to i64
%r7 = call i64 @extractHigh64(i128 %r5)
%r9 = call i128 @mulPos64x64(i64* %r2, i64 %r3, i64 1)
%r10 = trunc i128 %r9 to i64
%r11 = call i64 @extractHigh64(i128 %r9)
%r13 = call i128 @mulPos64x64(i64* %r2, i64 %r3, i64 2)
%r14 = trunc i128 %r13 to i64
%r15 = call i64 @extractHigh64(i128 %r13)
%r17 = call i128 @mulPos64x64(i64* %r2, i64 %r3, i64 3)
%r18 = trunc i128 %r17 to i64
%r19 = call i64 @extractHigh64(i128 %r17)
%r21 = call i128 @mulPos64x64(i64* %r2, i64 %r3, i64 4)
%r22 = trunc i128 %r21 to i64
%r23 = call i64 @extractHigh64(i128 %r21)
%r25 = call i128 @mulPos64x64(i64* %r2, i64 %r3, i64 5)
%r26 = trunc i128 %r25 to i64
%r27 = call i64 @extractHigh64(i128 %r25)
%r29 = call i128 @mulPos64x64(i64* %r2, i64 %r3, i64 6)
%r30 = trunc i128 %r29 to i64
%r31 = call i64 @extractHigh64(i128 %r29)
%r32 = zext i64 %r6 to i128
%r33 = zext i64 %r10 to i128
%r34 = shl i128 %r33, 64
%r35 = or i128 %r32, %r34
%r36 = zext i128 %r35 to i192
%r37 = zext i64 %r14 to i192
%r38 = shl i192 %r37, 128
%r39 = or i192 %r36, %r38
%r40 = zext i192 %r39 to i256
%r41 = zext i64 %r18 to i256
%r42 = shl i256 %r41, 192
%r43 = or i256 %r40, %r42
%r44 = zext i256 %r43 to i320
%r45 = zext i64 %r22 to i320
%r46 = shl i320 %r45, 256
%r47 = or i320 %r44, %r46
%r48 = zext i320 %r47 to i384
%r49 = zext i64 %r26 to i384
%r50 = shl i384 %r49, 320
%r51 = or i384 %r48, %r50
%r52 = zext i384 %r51 to i448
%r53 = zext i64 %r30 to i448
%r54 = shl i448 %r53, 384
%r55 = or i448 %r52, %r54
%r56 = zext i64 %r7 to i128
%r57 = zext i64 %r11 to i128
%r58 = shl i128 %r57, 64
%r59 = or i128 %r56, %r58
%r60 = zext i128 %r59 to i192
%r61 = zext i64 %r15 to i192
%r62 = shl i192 %r61, 128
%r63 = or i192 %r60, %r62
%r64 = zext i192 %r63 to i256
%r65 = zext i64 %r19 to i256
%r66 = shl i256 %r65, 192
%r67 = or i256 %r64, %r66
%r68 = zext i256 %r67 to i320
%r69 = zext i64 %r23 to i320
%r70 = shl i320 %r69, 256
%r71 = or i320 %r68, %r70
%r72 = zext i320 %r71 to i384
%r73 = zext i64 %r27 to i384
%r74 = shl i384 %r73, 320
%r75 = or i384 %r72, %r74
%r76 = zext i384 %r75 to i448
%r77 = zext i64 %r31 to i448
%r78 = shl i448 %r77, 384
%r79 = or i448 %r76, %r78
%r80 = zext i448 %r55 to i512
%r81 = zext i448 %r79 to i512
%r82 = shl i512 %r81, 64
%r83 = add i512 %r80, %r82
ret i512 %r83
}
define void @mcl_fp_mulUnitPre7L(i64* noalias  %r1, i64* noalias  %r2, i64 %r3)
{
%r4 = call i512 @mulPv448x64(i64* %r2, i64 %r3)
%r5 = trunc i512 %r4 to i64
%r7 = getelementptr i64, i64* %r1, i32 0
store i64 %r5, i64* %r7
%r8 = lshr i512 %r4, 64
%r9 = trunc i512 %r8 to i64
%r11 = getelementptr i64, i64* %r1, i32 1
store i64 %r9, i64* %r11
%r12 = lshr i512 %r8, 64
%r13 = trunc i512 %r12 to i64
%r15 = getelementptr i64, i64* %r1, i32 2
store i64 %r13, i64* %r15
%r16 = lshr i512 %r12, 64
%r17 = trunc i512 %r16 to i64
%r19 = getelementptr i64, i64* %r1, i32 3
store i64 %r17, i64* %r19
%r20 = lshr i512 %r16, 64
%r21 = trunc i512 %r20 to i64
%r23 = getelementptr i64, i64* %r1, i32 4
store i64 %r21, i64* %r23
%r24 = lshr i512 %r20, 64
%r25 = trunc i512 %r24 to i64
%r27 = getelementptr i64, i64* %r1, i32 5
store i64 %r25, i64* %r27
%r28 = lshr i512 %r24, 64
%r29 = trunc i512 %r28 to i64
%r31 = getelementptr i64, i64* %r1, i32 6
store i64 %r29, i64* %r31
%r32 = lshr i512 %r28, 64
%r33 = trunc i512 %r32 to i64
%r35 = getelementptr i64, i64* %r1, i32 7
store i64 %r33, i64* %r35
ret void
}
define void @mcl_fpDbl_mulPre7L(i64* noalias  %r1, i64* noalias  %r2, i64* noalias  %r3)
{
%r4 = load i64, i64* %r3
%r5 = call i512 @mulPv448x64(i64* %r2, i64 %r4)
%r6 = trunc i512 %r5 to i64
store i64 %r6, i64* %r1
%r7 = lshr i512 %r5, 64
%r9 = getelementptr i64, i64* %r3, i32 1
%r10 = load i64, i64* %r9
%r11 = call i512 @mulPv448x64(i64* %r2, i64 %r10)
%r12 = add i512 %r7, %r11
%r13 = trunc i512 %r12 to i64
%r15 = getelementptr i64, i64* %r1, i32 1
store i64 %r13, i64* %r15
%r16 = lshr i512 %r12, 64
%r18 = getelementptr i64, i64* %r3, i32 2
%r19 = load i64, i64* %r18
%r20 = call i512 @mulPv448x64(i64* %r2, i64 %r19)
%r21 = add i512 %r16, %r20
%r22 = trunc i512 %r21 to i64
%r24 = getelementptr i64, i64* %r1, i32 2
store i64 %r22, i64* %r24
%r25 = lshr i512 %r21, 64
%r27 = getelementptr i64, i64* %r3, i32 3
%r28 = load i64, i64* %r27
%r29 = call i512 @mulPv448x64(i64* %r2, i64 %r28)
%r30 = add i512 %r25, %r29
%r31 = trunc i512 %r30 to i64
%r33 = getelementptr i64, i64* %r1, i32 3
store i64 %r31, i64* %r33
%r34 = lshr i512 %r30, 64
%r36 = getelementptr i64, i64* %r3, i32 4
%r37 = load i64, i64* %r36
%r38 = call i512 @mulPv448x64(i64* %r2, i64 %r37)
%r39 = add i512 %r34, %r38
%r40 = trunc i512 %r39 to i64
%r42 = getelementptr i64, i64* %r1, i32 4
store i64 %r40, i64* %r42
%r43 = lshr i512 %r39, 64
%r45 = getelementptr i64, i64* %r3, i32 5
%r46 = load i64, i64* %r45
%r47 = call i512 @mulPv448x64(i64* %r2, i64 %r46)
%r48 = add i512 %r43, %r47
%r49 = trunc i512 %r48 to i64
%r51 = getelementptr i64, i64* %r1, i32 5
store i64 %r49, i64* %r51
%r52 = lshr i512 %r48, 64
%r54 = getelementptr i64, i64* %r3, i32 6
%r55 = load i64, i64* %r54
%r56 = call i512 @mulPv448x64(i64* %r2, i64 %r55)
%r57 = add i512 %r52, %r56
%r59 = getelementptr i64, i64* %r1, i32 6
%r60 = trunc i512 %r57 to i64
%r62 = getelementptr i64, i64* %r59, i32 0
store i64 %r60, i64* %r62
%r63 = lshr i512 %r57, 64
%r64 = trunc i512 %r63 to i64
%r66 = getelementptr i64, i64* %r59, i32 1
store i64 %r64, i64* %r66
%r67 = lshr i512 %r63, 64
%r68 = trunc i512 %r67 to i64
%r70 = getelementptr i64, i64* %r59, i32 2
store i64 %r68, i64* %r70
%r71 = lshr i512 %r67, 64
%r72 = trunc i512 %r71 to i64
%r74 = getelementptr i64, i64* %r59, i32 3
store i64 %r72, i64* %r74
%r75 = lshr i512 %r71, 64
%r76 = trunc i512 %r75 to i64
%r78 = getelementptr i64, i64* %r59, i32 4
store i64 %r76, i64* %r78
%r79 = lshr i512 %r75, 64
%r80 = trunc i512 %r79 to i64
%r82 = getelementptr i64, i64* %r59, i32 5
store i64 %r80, i64* %r82
%r83 = lshr i512 %r79, 64
%r84 = trunc i512 %r83 to i64
%r86 = getelementptr i64, i64* %r59, i32 6
store i64 %r84, i64* %r86
%r87 = lshr i512 %r83, 64
%r88 = trunc i512 %r87 to i64
%r90 = getelementptr i64, i64* %r59, i32 7
store i64 %r88, i64* %r90
ret void
}
define void @mcl_fpDbl_sqrPre7L(i64* noalias  %r1, i64* noalias  %r2)
{
%r3 = load i64, i64* %r2
%r4 = call i512 @mulPv448x64(i64* %r2, i64 %r3)
%r5 = trunc i512 %r4 to i64
store i64 %r5, i64* %r1
%r6 = lshr i512 %r4, 64
%r8 = getelementptr i64, i64* %r2, i32 1
%r9 = load i64, i64* %r8
%r10 = call i512 @mulPv448x64(i64* %r2, i64 %r9)
%r11 = add i512 %r6, %r10
%r12 = trunc i512 %r11 to i64
%r14 = getelementptr i64, i64* %r1, i32 1
store i64 %r12, i64* %r14
%r15 = lshr i512 %r11, 64
%r17 = getelementptr i64, i64* %r2, i32 2
%r18 = load i64, i64* %r17
%r19 = call i512 @mulPv448x64(i64* %r2, i64 %r18)
%r20 = add i512 %r15, %r19
%r21 = trunc i512 %r20 to i64
%r23 = getelementptr i64, i64* %r1, i32 2
store i64 %r21, i64* %r23
%r24 = lshr i512 %r20, 64
%r26 = getelementptr i64, i64* %r2, i32 3
%r27 = load i64, i64* %r26
%r28 = call i512 @mulPv448x64(i64* %r2, i64 %r27)
%r29 = add i512 %r24, %r28
%r30 = trunc i512 %r29 to i64
%r32 = getelementptr i64, i64* %r1, i32 3
store i64 %r30, i64* %r32
%r33 = lshr i512 %r29, 64
%r35 = getelementptr i64, i64* %r2, i32 4
%r36 = load i64, i64* %r35
%r37 = call i512 @mulPv448x64(i64* %r2, i64 %r36)
%r38 = add i512 %r33, %r37
%r39 = trunc i512 %r38 to i64
%r41 = getelementptr i64, i64* %r1, i32 4
store i64 %r39, i64* %r41
%r42 = lshr i512 %r38, 64
%r44 = getelementptr i64, i64* %r2, i32 5
%r45 = load i64, i64* %r44
%r46 = call i512 @mulPv448x64(i64* %r2, i64 %r45)
%r47 = add i512 %r42, %r46
%r48 = trunc i512 %r47 to i64
%r50 = getelementptr i64, i64* %r1, i32 5
store i64 %r48, i64* %r50
%r51 = lshr i512 %r47, 64
%r53 = getelementptr i64, i64* %r2, i32 6
%r54 = load i64, i64* %r53
%r55 = call i512 @mulPv448x64(i64* %r2, i64 %r54)
%r56 = add i512 %r51, %r55
%r58 = getelementptr i64, i64* %r1, i32 6
%r59 = trunc i512 %r56 to i64
%r61 = getelementptr i64, i64* %r58, i32 0
store i64 %r59, i64* %r61
%r62 = lshr i512 %r56, 64
%r63 = trunc i512 %r62 to i64
%r65 = getelementptr i64, i64* %r58, i32 1
store i64 %r63, i64* %r65
%r66 = lshr i512 %r62, 64
%r67 = trunc i512 %r66 to i64
%r69 = getelementptr i64, i64* %r58, i32 2
store i64 %r67, i64* %r69
%r70 = lshr i512 %r66, 64
%r71 = trunc i512 %r70 to i64
%r73 = getelementptr i64, i64* %r58, i32 3
store i64 %r71, i64* %r73
%r74 = lshr i512 %r70, 64
%r75 = trunc i512 %r74 to i64
%r77 = getelementptr i64, i64* %r58, i32 4
store i64 %r75, i64* %r77
%r78 = lshr i512 %r74, 64
%r79 = trunc i512 %r78 to i64
%r81 = getelementptr i64, i64* %r58, i32 5
store i64 %r79, i64* %r81
%r82 = lshr i512 %r78, 64
%r83 = trunc i512 %r82 to i64
%r85 = getelementptr i64, i64* %r58, i32 6
store i64 %r83, i64* %r85
%r86 = lshr i512 %r82, 64
%r87 = trunc i512 %r86 to i64
%r89 = getelementptr i64, i64* %r58, i32 7
store i64 %r87, i64* %r89
ret void
}
define void @mcl_fp_mont7L(i64* %r1, i64* %r2, i64* %r3, i64* %r4)
{
%r6 = getelementptr i64, i64* %r4, i32 -1
%r7 = load i64, i64* %r6
%r9 = getelementptr i64, i64* %r3, i32 0
%r10 = load i64, i64* %r9
%r11 = call i512 @mulPv448x64(i64* %r2, i64 %r10)
%r12 = zext i512 %r11 to i576
%r13 = trunc i512 %r11 to i64
%r14 = mul i64 %r13, %r7
%r15 = call i512 @mulPv448x64(i64* %r4, i64 %r14)
%r16 = zext i512 %r15 to i576
%r17 = add i576 %r12, %r16
%r18 = lshr i576 %r17, 64
%r20 = getelementptr i64, i64* %r3, i32 1
%r21 = load i64, i64* %r20
%r22 = call i512 @mulPv448x64(i64* %r2, i64 %r21)
%r23 = zext i512 %r22 to i576
%r24 = add i576 %r18, %r23
%r25 = trunc i576 %r24 to i64
%r26 = mul i64 %r25, %r7
%r27 = call i512 @mulPv448x64(i64* %r4, i64 %r26)
%r28 = zext i512 %r27 to i576
%r29 = add i576 %r24, %r28
%r30 = lshr i576 %r29, 64
%r32 = getelementptr i64, i64* %r3, i32 2
%r33 = load i64, i64* %r32
%r34 = call i512 @mulPv448x64(i64* %r2, i64 %r33)
%r35 = zext i512 %r34 to i576
%r36 = add i576 %r30, %r35
%r37 = trunc i576 %r36 to i64
%r38 = mul i64 %r37, %r7
%r39 = call i512 @mulPv448x64(i64* %r4, i64 %r38)
%r40 = zext i512 %r39 to i576
%r41 = add i576 %r36, %r40
%r42 = lshr i576 %r41, 64
%r44 = getelementptr i64, i64* %r3, i32 3
%r45 = load i64, i64* %r44
%r46 = call i512 @mulPv448x64(i64* %r2, i64 %r45)
%r47 = zext i512 %r46 to i576
%r48 = add i576 %r42, %r47
%r49 = trunc i576 %r48 to i64
%r50 = mul i64 %r49, %r7
%r51 = call i512 @mulPv448x64(i64* %r4, i64 %r50)
%r52 = zext i512 %r51 to i576
%r53 = add i576 %r48, %r52
%r54 = lshr i576 %r53, 64
%r56 = getelementptr i64, i64* %r3, i32 4
%r57 = load i64, i64* %r56
%r58 = call i512 @mulPv448x64(i64* %r2, i64 %r57)
%r59 = zext i512 %r58 to i576
%r60 = add i576 %r54, %r59
%r61 = trunc i576 %r60 to i64
%r62 = mul i64 %r61, %r7
%r63 = call i512 @mulPv448x64(i64* %r4, i64 %r62)
%r64 = zext i512 %r63 to i576
%r65 = add i576 %r60, %r64
%r66 = lshr i576 %r65, 64
%r68 = getelementptr i64, i64* %r3, i32 5
%r69 = load i64, i64* %r68
%r70 = call i512 @mulPv448x64(i64* %r2, i64 %r69)
%r71 = zext i512 %r70 to i576
%r72 = add i576 %r66, %r71
%r73 = trunc i576 %r72 to i64
%r74 = mul i64 %r73, %r7
%r75 = call i512 @mulPv448x64(i64* %r4, i64 %r74)
%r76 = zext i512 %r75 to i576
%r77 = add i576 %r72, %r76
%r78 = lshr i576 %r77, 64
%r80 = getelementptr i64, i64* %r3, i32 6
%r81 = load i64, i64* %r80
%r82 = call i512 @mulPv448x64(i64* %r2, i64 %r81)
%r83 = zext i512 %r82 to i576
%r84 = add i576 %r78, %r83
%r85 = trunc i576 %r84 to i64
%r86 = mul i64 %r85, %r7
%r87 = call i512 @mulPv448x64(i64* %r4, i64 %r86)
%r88 = zext i512 %r87 to i576
%r89 = add i576 %r84, %r88
%r90 = lshr i576 %r89, 64
%r91 = trunc i576 %r90 to i512
%r92 = load i64, i64* %r4
%r93 = zext i64 %r92 to i128
%r95 = getelementptr i64, i64* %r4, i32 1
%r96 = load i64, i64* %r95
%r97 = zext i64 %r96 to i128
%r98 = shl i128 %r97, 64
%r99 = or i128 %r93, %r98
%r100 = zext i128 %r99 to i192
%r102 = getelementptr i64, i64* %r4, i32 2
%r103 = load i64, i64* %r102
%r104 = zext i64 %r103 to i192
%r105 = shl i192 %r104, 128
%r106 = or i192 %r100, %r105
%r107 = zext i192 %r106 to i256
%r109 = getelementptr i64, i64* %r4, i32 3
%r110 = load i64, i64* %r109
%r111 = zext i64 %r110 to i256
%r112 = shl i256 %r111, 192
%r113 = or i256 %r107, %r112
%r114 = zext i256 %r113 to i320
%r116 = getelementptr i64, i64* %r4, i32 4
%r117 = load i64, i64* %r116
%r118 = zext i64 %r117 to i320
%r119 = shl i320 %r118, 256
%r120 = or i320 %r114, %r119
%r121 = zext i320 %r120 to i384
%r123 = getelementptr i64, i64* %r4, i32 5
%r124 = load i64, i64* %r123
%r125 = zext i64 %r124 to i384
%r126 = shl i384 %r125, 320
%r127 = or i384 %r121, %r126
%r128 = zext i384 %r127 to i448
%r130 = getelementptr i64, i64* %r4, i32 6
%r131 = load i64, i64* %r130
%r132 = zext i64 %r131 to i448
%r133 = shl i448 %r132, 384
%r134 = or i448 %r128, %r133
%r135 = zext i448 %r134 to i512
%r136 = sub i512 %r91, %r135
%r137 = lshr i512 %r136, 448
%r138 = trunc i512 %r137 to i1
%r139 = select i1 %r138, i512 %r91, i512 %r136
%r140 = trunc i512 %r139 to i448
%r141 = trunc i448 %r140 to i64
%r143 = getelementptr i64, i64* %r1, i32 0
store i64 %r141, i64* %r143
%r144 = lshr i448 %r140, 64
%r145 = trunc i448 %r144 to i64
%r147 = getelementptr i64, i64* %r1, i32 1
store i64 %r145, i64* %r147
%r148 = lshr i448 %r144, 64
%r149 = trunc i448 %r148 to i64
%r151 = getelementptr i64, i64* %r1, i32 2
store i64 %r149, i64* %r151
%r152 = lshr i448 %r148, 64
%r153 = trunc i448 %r152 to i64
%r155 = getelementptr i64, i64* %r1, i32 3
store i64 %r153, i64* %r155
%r156 = lshr i448 %r152, 64
%r157 = trunc i448 %r156 to i64
%r159 = getelementptr i64, i64* %r1, i32 4
store i64 %r157, i64* %r159
%r160 = lshr i448 %r156, 64
%r161 = trunc i448 %r160 to i64
%r163 = getelementptr i64, i64* %r1, i32 5
store i64 %r161, i64* %r163
%r164 = lshr i448 %r160, 64
%r165 = trunc i448 %r164 to i64
%r167 = getelementptr i64, i64* %r1, i32 6
store i64 %r165, i64* %r167
ret void
}
define void @mcl_fp_montNF7L(i64* %r1, i64* %r2, i64* %r3, i64* %r4)
{
%r6 = getelementptr i64, i64* %r4, i32 -1
%r7 = load i64, i64* %r6
%r8 = load i64, i64* %r3
%r9 = call i512 @mulPv448x64(i64* %r2, i64 %r8)
%r10 = trunc i512 %r9 to i64
%r11 = mul i64 %r10, %r7
%r12 = call i512 @mulPv448x64(i64* %r4, i64 %r11)
%r13 = add i512 %r9, %r12
%r14 = lshr i512 %r13, 64
%r16 = getelementptr i64, i64* %r3, i32 1
%r17 = load i64, i64* %r16
%r18 = call i512 @mulPv448x64(i64* %r2, i64 %r17)
%r19 = add i512 %r14, %r18
%r20 = trunc i512 %r19 to i64
%r21 = mul i64 %r20, %r7
%r22 = call i512 @mulPv448x64(i64* %r4, i64 %r21)
%r23 = add i512 %r19, %r22
%r24 = lshr i512 %r23, 64
%r26 = getelementptr i64, i64* %r3, i32 2
%r27 = load i64, i64* %r26
%r28 = call i512 @mulPv448x64(i64* %r2, i64 %r27)
%r29 = add i512 %r24, %r28
%r30 = trunc i512 %r29 to i64
%r31 = mul i64 %r30, %r7
%r32 = call i512 @mulPv448x64(i64* %r4, i64 %r31)
%r33 = add i512 %r29, %r32
%r34 = lshr i512 %r33, 64
%r36 = getelementptr i64, i64* %r3, i32 3
%r37 = load i64, i64* %r36
%r38 = call i512 @mulPv448x64(i64* %r2, i64 %r37)
%r39 = add i512 %r34, %r38
%r40 = trunc i512 %r39 to i64
%r41 = mul i64 %r40, %r7
%r42 = call i512 @mulPv448x64(i64* %r4, i64 %r41)
%r43 = add i512 %r39, %r42
%r44 = lshr i512 %r43, 64
%r46 = getelementptr i64, i64* %r3, i32 4
%r47 = load i64, i64* %r46
%r48 = call i512 @mulPv448x64(i64* %r2, i64 %r47)
%r49 = add i512 %r44, %r48
%r50 = trunc i512 %r49 to i64
%r51 = mul i64 %r50, %r7
%r52 = call i512 @mulPv448x64(i64* %r4, i64 %r51)
%r53 = add i512 %r49, %r52
%r54 = lshr i512 %r53, 64
%r56 = getelementptr i64, i64* %r3, i32 5
%r57 = load i64, i64* %r56
%r58 = call i512 @mulPv448x64(i64* %r2, i64 %r57)
%r59 = add i512 %r54, %r58
%r60 = trunc i512 %r59 to i64
%r61 = mul i64 %r60, %r7
%r62 = call i512 @mulPv448x64(i64* %r4, i64 %r61)
%r63 = add i512 %r59, %r62
%r64 = lshr i512 %r63, 64
%r66 = getelementptr i64, i64* %r3, i32 6
%r67 = load i64, i64* %r66
%r68 = call i512 @mulPv448x64(i64* %r2, i64 %r67)
%r69 = add i512 %r64, %r68
%r70 = trunc i512 %r69 to i64
%r71 = mul i64 %r70, %r7
%r72 = call i512 @mulPv448x64(i64* %r4, i64 %r71)
%r73 = add i512 %r69, %r72
%r74 = lshr i512 %r73, 64
%r75 = trunc i512 %r74 to i448
%r76 = load i64, i64* %r4
%r77 = zext i64 %r76 to i128
%r79 = getelementptr i64, i64* %r4, i32 1
%r80 = load i64, i64* %r79
%r81 = zext i64 %r80 to i128
%r82 = shl i128 %r81, 64
%r83 = or i128 %r77, %r82
%r84 = zext i128 %r83 to i192
%r86 = getelementptr i64, i64* %r4, i32 2
%r87 = load i64, i64* %r86
%r88 = zext i64 %r87 to i192
%r89 = shl i192 %r88, 128
%r90 = or i192 %r84, %r89
%r91 = zext i192 %r90 to i256
%r93 = getelementptr i64, i64* %r4, i32 3
%r94 = load i64, i64* %r93
%r95 = zext i64 %r94 to i256
%r96 = shl i256 %r95, 192
%r97 = or i256 %r91, %r96
%r98 = zext i256 %r97 to i320
%r100 = getelementptr i64, i64* %r4, i32 4
%r101 = load i64, i64* %r100
%r102 = zext i64 %r101 to i320
%r103 = shl i320 %r102, 256
%r104 = or i320 %r98, %r103
%r105 = zext i320 %r104 to i384
%r107 = getelementptr i64, i64* %r4, i32 5
%r108 = load i64, i64* %r107
%r109 = zext i64 %r108 to i384
%r110 = shl i384 %r109, 320
%r111 = or i384 %r105, %r110
%r112 = zext i384 %r111 to i448
%r114 = getelementptr i64, i64* %r4, i32 6
%r115 = load i64, i64* %r114
%r116 = zext i64 %r115 to i448
%r117 = shl i448 %r116, 384
%r118 = or i448 %r112, %r117
%r119 = sub i448 %r75, %r118
%r120 = lshr i448 %r119, 447
%r121 = trunc i448 %r120 to i1
%r122 = select i1 %r121, i448 %r75, i448 %r119
%r123 = trunc i448 %r122 to i64
%r125 = getelementptr i64, i64* %r1, i32 0
store i64 %r123, i64* %r125
%r126 = lshr i448 %r122, 64
%r127 = trunc i448 %r126 to i64
%r129 = getelementptr i64, i64* %r1, i32 1
store i64 %r127, i64* %r129
%r130 = lshr i448 %r126, 64
%r131 = trunc i448 %r130 to i64
%r133 = getelementptr i64, i64* %r1, i32 2
store i64 %r131, i64* %r133
%r134 = lshr i448 %r130, 64
%r135 = trunc i448 %r134 to i64
%r137 = getelementptr i64, i64* %r1, i32 3
store i64 %r135, i64* %r137
%r138 = lshr i448 %r134, 64
%r139 = trunc i448 %r138 to i64
%r141 = getelementptr i64, i64* %r1, i32 4
store i64 %r139, i64* %r141
%r142 = lshr i448 %r138, 64
%r143 = trunc i448 %r142 to i64
%r145 = getelementptr i64, i64* %r1, i32 5
store i64 %r143, i64* %r145
%r146 = lshr i448 %r142, 64
%r147 = trunc i448 %r146 to i64
%r149 = getelementptr i64, i64* %r1, i32 6
store i64 %r147, i64* %r149
ret void
}
define void @mcl_fp_montRed7L(i64* noalias  %r1, i64* noalias  %r2, i64* noalias  %r3)
{
%r5 = getelementptr i64, i64* %r3, i32 -1
%r6 = load i64, i64* %r5
%r7 = load i64, i64* %r3
%r8 = zext i64 %r7 to i128
%r10 = getelementptr i64, i64* %r3, i32 1
%r11 = load i64, i64* %r10
%r12 = zext i64 %r11 to i128
%r13 = shl i128 %r12, 64
%r14 = or i128 %r8, %r13
%r15 = zext i128 %r14 to i192
%r17 = getelementptr i64, i64* %r3, i32 2
%r18 = load i64, i64* %r17
%r19 = zext i64 %r18 to i192
%r20 = shl i192 %r19, 128
%r21 = or i192 %r15, %r20
%r22 = zext i192 %r21 to i256
%r24 = getelementptr i64, i64* %r3, i32 3
%r25 = load i64, i64* %r24
%r26 = zext i64 %r25 to i256
%r27 = shl i256 %r26, 192
%r28 = or i256 %r22, %r27
%r29 = zext i256 %r28 to i320
%r31 = getelementptr i64, i64* %r3, i32 4
%r32 = load i64, i64* %r31
%r33 = zext i64 %r32 to i320
%r34 = shl i320 %r33, 256
%r35 = or i320 %r29, %r34
%r36 = zext i320 %r35 to i384
%r38 = getelementptr i64, i64* %r3, i32 5
%r39 = load i64, i64* %r38
%r40 = zext i64 %r39 to i384
%r41 = shl i384 %r40, 320
%r42 = or i384 %r36, %r41
%r43 = zext i384 %r42 to i448
%r45 = getelementptr i64, i64* %r3, i32 6
%r46 = load i64, i64* %r45
%r47 = zext i64 %r46 to i448
%r48 = shl i448 %r47, 384
%r49 = or i448 %r43, %r48
%r50 = load i64, i64* %r2
%r51 = zext i64 %r50 to i128
%r53 = getelementptr i64, i64* %r2, i32 1
%r54 = load i64, i64* %r53
%r55 = zext i64 %r54 to i128
%r56 = shl i128 %r55, 64
%r57 = or i128 %r51, %r56
%r58 = zext i128 %r57 to i192
%r60 = getelementptr i64, i64* %r2, i32 2
%r61 = load i64, i64* %r60
%r62 = zext i64 %r61 to i192
%r63 = shl i192 %r62, 128
%r64 = or i192 %r58, %r63
%r65 = zext i192 %r64 to i256
%r67 = getelementptr i64, i64* %r2, i32 3
%r68 = load i64, i64* %r67
%r69 = zext i64 %r68 to i256
%r70 = shl i256 %r69, 192
%r71 = or i256 %r65, %r70
%r72 = zext i256 %r71 to i320
%r74 = getelementptr i64, i64* %r2, i32 4
%r75 = load i64, i64* %r74
%r76 = zext i64 %r75 to i320
%r77 = shl i320 %r76, 256
%r78 = or i320 %r72, %r77
%r79 = zext i320 %r78 to i384
%r81 = getelementptr i64, i64* %r2, i32 5
%r82 = load i64, i64* %r81
%r83 = zext i64 %r82 to i384
%r84 = shl i384 %r83, 320
%r85 = or i384 %r79, %r84
%r86 = zext i384 %r85 to i448
%r88 = getelementptr i64, i64* %r2, i32 6
%r89 = load i64, i64* %r88
%r90 = zext i64 %r89 to i448
%r91 = shl i448 %r90, 384
%r92 = or i448 %r86, %r91
%r93 = zext i448 %r92 to i512
%r95 = getelementptr i64, i64* %r2, i32 7
%r96 = load i64, i64* %r95
%r97 = zext i64 %r96 to i512
%r98 = shl i512 %r97, 448
%r99 = or i512 %r93, %r98
%r100 = zext i512 %r99 to i576
%r102 = getelementptr i64, i64* %r2, i32 8
%r103 = load i64, i64* %r102
%r104 = zext i64 %r103 to i576
%r105 = shl i576 %r104, 512
%r106 = or i576 %r100, %r105
%r107 = zext i576 %r106 to i640
%r109 = getelementptr i64, i64* %r2, i32 9
%r110 = load i64, i64* %r109
%r111 = zext i64 %r110 to i640
%r112 = shl i640 %r111, 576
%r113 = or i640 %r107, %r112
%r114 = zext i640 %r113 to i704
%r116 = getelementptr i64, i64* %r2, i32 10
%r117 = load i64, i64* %r116
%r118 = zext i64 %r117 to i704
%r119 = shl i704 %r118, 640
%r120 = or i704 %r114, %r119
%r121 = zext i704 %r120 to i768
%r123 = getelementptr i64, i64* %r2, i32 11
%r124 = load i64, i64* %r123
%r125 = zext i64 %r124 to i768
%r126 = shl i768 %r125, 704
%r127 = or i768 %r121, %r126
%r128 = zext i768 %r127 to i832
%r130 = getelementptr i64, i64* %r2, i32 12
%r131 = load i64, i64* %r130
%r132 = zext i64 %r131 to i832
%r133 = shl i832 %r132, 768
%r134 = or i832 %r128, %r133
%r135 = zext i832 %r134 to i896
%r137 = getelementptr i64, i64* %r2, i32 13
%r138 = load i64, i64* %r137
%r139 = zext i64 %r138 to i896
%r140 = shl i896 %r139, 832
%r141 = or i896 %r135, %r140
%r142 = zext i896 %r141 to i960
%r143 = trunc i960 %r142 to i64
%r144 = mul i64 %r143, %r6
%r145 = call i512 @mulPv448x64(i64* %r3, i64 %r144)
%r146 = zext i512 %r145 to i960
%r147 = add i960 %r142, %r146
%r148 = lshr i960 %r147, 64
%r149 = trunc i960 %r148 to i896
%r150 = trunc i896 %r149 to i64
%r151 = mul i64 %r150, %r6
%r152 = call i512 @mulPv448x64(i64* %r3, i64 %r151)
%r153 = zext i512 %r152 to i896
%r154 = add i896 %r149, %r153
%r155 = lshr i896 %r154, 64
%r156 = trunc i896 %r155 to i832
%r157 = trunc i832 %r156 to i64
%r158 = mul i64 %r157, %r6
%r159 = call i512 @mulPv448x64(i64* %r3, i64 %r158)
%r160 = zext i512 %r159 to i832
%r161 = add i832 %r156, %r160
%r162 = lshr i832 %r161, 64
%r163 = trunc i832 %r162 to i768
%r164 = trunc i768 %r163 to i64
%r165 = mul i64 %r164, %r6
%r166 = call i512 @mulPv448x64(i64* %r3, i64 %r165)
%r167 = zext i512 %r166 to i768
%r168 = add i768 %r163, %r167
%r169 = lshr i768 %r168, 64
%r170 = trunc i768 %r169 to i704
%r171 = trunc i704 %r170 to i64
%r172 = mul i64 %r171, %r6
%r173 = call i512 @mulPv448x64(i64* %r3, i64 %r172)
%r174 = zext i512 %r173 to i704
%r175 = add i704 %r170, %r174
%r176 = lshr i704 %r175, 64
%r177 = trunc i704 %r176 to i640
%r178 = trunc i640 %r177 to i64
%r179 = mul i64 %r178, %r6
%r180 = call i512 @mulPv448x64(i64* %r3, i64 %r179)
%r181 = zext i512 %r180 to i640
%r182 = add i640 %r177, %r181
%r183 = lshr i640 %r182, 64
%r184 = trunc i640 %r183 to i576
%r185 = trunc i576 %r184 to i64
%r186 = mul i64 %r185, %r6
%r187 = call i512 @mulPv448x64(i64* %r3, i64 %r186)
%r188 = zext i512 %r187 to i576
%r189 = add i576 %r184, %r188
%r190 = lshr i576 %r189, 64
%r191 = trunc i576 %r190 to i512
%r192 = zext i448 %r49 to i512
%r193 = sub i512 %r191, %r192
%r194 = lshr i512 %r193, 448
%r195 = trunc i512 %r194 to i1
%r196 = select i1 %r195, i512 %r191, i512 %r193
%r197 = trunc i512 %r196 to i448
%r198 = trunc i448 %r197 to i64
%r200 = getelementptr i64, i64* %r1, i32 0
store i64 %r198, i64* %r200
%r201 = lshr i448 %r197, 64
%r202 = trunc i448 %r201 to i64
%r204 = getelementptr i64, i64* %r1, i32 1
store i64 %r202, i64* %r204
%r205 = lshr i448 %r201, 64
%r206 = trunc i448 %r205 to i64
%r208 = getelementptr i64, i64* %r1, i32 2
store i64 %r206, i64* %r208
%r209 = lshr i448 %r205, 64
%r210 = trunc i448 %r209 to i64
%r212 = getelementptr i64, i64* %r1, i32 3
store i64 %r210, i64* %r212
%r213 = lshr i448 %r209, 64
%r214 = trunc i448 %r213 to i64
%r216 = getelementptr i64, i64* %r1, i32 4
store i64 %r214, i64* %r216
%r217 = lshr i448 %r213, 64
%r218 = trunc i448 %r217 to i64
%r220 = getelementptr i64, i64* %r1, i32 5
store i64 %r218, i64* %r220
%r221 = lshr i448 %r217, 64
%r222 = trunc i448 %r221 to i64
%r224 = getelementptr i64, i64* %r1, i32 6
store i64 %r222, i64* %r224
ret void
}
define i64 @mcl_fp_addPre7L(i64* noalias  %r2, i64* noalias  %r3, i64* noalias  %r4)
{
%r5 = load i64, i64* %r3
%r6 = zext i64 %r5 to i128
%r8 = getelementptr i64, i64* %r3, i32 1
%r9 = load i64, i64* %r8
%r10 = zext i64 %r9 to i128
%r11 = shl i128 %r10, 64
%r12 = or i128 %r6, %r11
%r13 = zext i128 %r12 to i192
%r15 = getelementptr i64, i64* %r3, i32 2
%r16 = load i64, i64* %r15
%r17 = zext i64 %r16 to i192
%r18 = shl i192 %r17, 128
%r19 = or i192 %r13, %r18
%r20 = zext i192 %r19 to i256
%r22 = getelementptr i64, i64* %r3, i32 3
%r23 = load i64, i64* %r22
%r24 = zext i64 %r23 to i256
%r25 = shl i256 %r24, 192
%r26 = or i256 %r20, %r25
%r27 = zext i256 %r26 to i320
%r29 = getelementptr i64, i64* %r3, i32 4
%r30 = load i64, i64* %r29
%r31 = zext i64 %r30 to i320
%r32 = shl i320 %r31, 256
%r33 = or i320 %r27, %r32
%r34 = zext i320 %r33 to i384
%r36 = getelementptr i64, i64* %r3, i32 5
%r37 = load i64, i64* %r36
%r38 = zext i64 %r37 to i384
%r39 = shl i384 %r38, 320
%r40 = or i384 %r34, %r39
%r41 = zext i384 %r40 to i448
%r43 = getelementptr i64, i64* %r3, i32 6
%r44 = load i64, i64* %r43
%r45 = zext i64 %r44 to i448
%r46 = shl i448 %r45, 384
%r47 = or i448 %r41, %r46
%r48 = zext i448 %r47 to i512
%r49 = load i64, i64* %r4
%r50 = zext i64 %r49 to i128
%r52 = getelementptr i64, i64* %r4, i32 1
%r53 = load i64, i64* %r52
%r54 = zext i64 %r53 to i128
%r55 = shl i128 %r54, 64
%r56 = or i128 %r50, %r55
%r57 = zext i128 %r56 to i192
%r59 = getelementptr i64, i64* %r4, i32 2
%r60 = load i64, i64* %r59
%r61 = zext i64 %r60 to i192
%r62 = shl i192 %r61, 128
%r63 = or i192 %r57, %r62
%r64 = zext i192 %r63 to i256
%r66 = getelementptr i64, i64* %r4, i32 3
%r67 = load i64, i64* %r66
%r68 = zext i64 %r67 to i256
%r69 = shl i256 %r68, 192
%r70 = or i256 %r64, %r69
%r71 = zext i256 %r70 to i320
%r73 = getelementptr i64, i64* %r4, i32 4
%r74 = load i64, i64* %r73
%r75 = zext i64 %r74 to i320
%r76 = shl i320 %r75, 256
%r77 = or i320 %r71, %r76
%r78 = zext i320 %r77 to i384
%r80 = getelementptr i64, i64* %r4, i32 5
%r81 = load i64, i64* %r80
%r82 = zext i64 %r81 to i384
%r83 = shl i384 %r82, 320
%r84 = or i384 %r78, %r83
%r85 = zext i384 %r84 to i448
%r87 = getelementptr i64, i64* %r4, i32 6
%r88 = load i64, i64* %r87
%r89 = zext i64 %r88 to i448
%r90 = shl i448 %r89, 384
%r91 = or i448 %r85, %r90
%r92 = zext i448 %r91 to i512
%r93 = add i512 %r48, %r92
%r94 = trunc i512 %r93 to i448
%r95 = trunc i448 %r94 to i64
%r97 = getelementptr i64, i64* %r2, i32 0
store i64 %r95, i64* %r97
%r98 = lshr i448 %r94, 64
%r99 = trunc i448 %r98 to i64
%r101 = getelementptr i64, i64* %r2, i32 1
store i64 %r99, i64* %r101
%r102 = lshr i448 %r98, 64
%r103 = trunc i448 %r102 to i64
%r105 = getelementptr i64, i64* %r2, i32 2
store i64 %r103, i64* %r105
%r106 = lshr i448 %r102, 64
%r107 = trunc i448 %r106 to i64
%r109 = getelementptr i64, i64* %r2, i32 3
store i64 %r107, i64* %r109
%r110 = lshr i448 %r106, 64
%r111 = trunc i448 %r110 to i64
%r113 = getelementptr i64, i64* %r2, i32 4
store i64 %r111, i64* %r113
%r114 = lshr i448 %r110, 64
%r115 = trunc i448 %r114 to i64
%r117 = getelementptr i64, i64* %r2, i32 5
store i64 %r115, i64* %r117
%r118 = lshr i448 %r114, 64
%r119 = trunc i448 %r118 to i64
%r121 = getelementptr i64, i64* %r2, i32 6
store i64 %r119, i64* %r121
%r122 = lshr i512 %r93, 448
%r123 = trunc i512 %r122 to i64
ret i64 %r123
}
define i64 @mcl_fp_subPre7L(i64* noalias  %r2, i64* noalias  %r3, i64* noalias  %r4)
{
%r5 = load i64, i64* %r3
%r6 = zext i64 %r5 to i128
%r8 = getelementptr i64, i64* %r3, i32 1
%r9 = load i64, i64* %r8
%r10 = zext i64 %r9 to i128
%r11 = shl i128 %r10, 64
%r12 = or i128 %r6, %r11
%r13 = zext i128 %r12 to i192
%r15 = getelementptr i64, i64* %r3, i32 2
%r16 = load i64, i64* %r15
%r17 = zext i64 %r16 to i192
%r18 = shl i192 %r17, 128
%r19 = or i192 %r13, %r18
%r20 = zext i192 %r19 to i256
%r22 = getelementptr i64, i64* %r3, i32 3
%r23 = load i64, i64* %r22
%r24 = zext i64 %r23 to i256
%r25 = shl i256 %r24, 192
%r26 = or i256 %r20, %r25
%r27 = zext i256 %r26 to i320
%r29 = getelementptr i64, i64* %r3, i32 4
%r30 = load i64, i64* %r29
%r31 = zext i64 %r30 to i320
%r32 = shl i320 %r31, 256
%r33 = or i320 %r27, %r32
%r34 = zext i320 %r33 to i384
%r36 = getelementptr i64, i64* %r3, i32 5
%r37 = load i64, i64* %r36
%r38 = zext i64 %r37 to i384
%r39 = shl i384 %r38, 320
%r40 = or i384 %r34, %r39
%r41 = zext i384 %r40 to i448
%r43 = getelementptr i64, i64* %r3, i32 6
%r44 = load i64, i64* %r43
%r45 = zext i64 %r44 to i448
%r46 = shl i448 %r45, 384
%r47 = or i448 %r41, %r46
%r48 = zext i448 %r47 to i512
%r49 = load i64, i64* %r4
%r50 = zext i64 %r49 to i128
%r52 = getelementptr i64, i64* %r4, i32 1
%r53 = load i64, i64* %r52
%r54 = zext i64 %r53 to i128
%r55 = shl i128 %r54, 64
%r56 = or i128 %r50, %r55
%r57 = zext i128 %r56 to i192
%r59 = getelementptr i64, i64* %r4, i32 2
%r60 = load i64, i64* %r59
%r61 = zext i64 %r60 to i192
%r62 = shl i192 %r61, 128
%r63 = or i192 %r57, %r62
%r64 = zext i192 %r63 to i256
%r66 = getelementptr i64, i64* %r4, i32 3
%r67 = load i64, i64* %r66
%r68 = zext i64 %r67 to i256
%r69 = shl i256 %r68, 192
%r70 = or i256 %r64, %r69
%r71 = zext i256 %r70 to i320
%r73 = getelementptr i64, i64* %r4, i32 4
%r74 = load i64, i64* %r73
%r75 = zext i64 %r74 to i320
%r76 = shl i320 %r75, 256
%r77 = or i320 %r71, %r76
%r78 = zext i320 %r77 to i384
%r80 = getelementptr i64, i64* %r4, i32 5
%r81 = load i64, i64* %r80
%r82 = zext i64 %r81 to i384
%r83 = shl i384 %r82, 320
%r84 = or i384 %r78, %r83
%r85 = zext i384 %r84 to i448
%r87 = getelementptr i64, i64* %r4, i32 6
%r88 = load i64, i64* %r87
%r89 = zext i64 %r88 to i448
%r90 = shl i448 %r89, 384
%r91 = or i448 %r85, %r90
%r92 = zext i448 %r91 to i512
%r93 = sub i512 %r48, %r92
%r94 = trunc i512 %r93 to i448
%r95 = trunc i448 %r94 to i64
%r97 = getelementptr i64, i64* %r2, i32 0
store i64 %r95, i64* %r97
%r98 = lshr i448 %r94, 64
%r99 = trunc i448 %r98 to i64
%r101 = getelementptr i64, i64* %r2, i32 1
store i64 %r99, i64* %r101
%r102 = lshr i448 %r98, 64
%r103 = trunc i448 %r102 to i64
%r105 = getelementptr i64, i64* %r2, i32 2
store i64 %r103, i64* %r105
%r106 = lshr i448 %r102, 64
%r107 = trunc i448 %r106 to i64
%r109 = getelementptr i64, i64* %r2, i32 3
store i64 %r107, i64* %r109
%r110 = lshr i448 %r106, 64
%r111 = trunc i448 %r110 to i64
%r113 = getelementptr i64, i64* %r2, i32 4
store i64 %r111, i64* %r113
%r114 = lshr i448 %r110, 64
%r115 = trunc i448 %r114 to i64
%r117 = getelementptr i64, i64* %r2, i32 5
store i64 %r115, i64* %r117
%r118 = lshr i448 %r114, 64
%r119 = trunc i448 %r118 to i64
%r121 = getelementptr i64, i64* %r2, i32 6
store i64 %r119, i64* %r121
%r122 = lshr i512 %r93, 448
%r123 = trunc i512 %r122 to i64
%r125 = and i64 %r123, 1
ret i64 %r125
}
define void @mcl_fp_shr1_7L(i64* noalias  %r1, i64* noalias  %r2)
{
%r3 = load i64, i64* %r2
%r4 = zext i64 %r3 to i128
%r6 = getelementptr i64, i64* %r2, i32 1
%r7 = load i64, i64* %r6
%r8 = zext i64 %r7 to i128
%r9 = shl i128 %r8, 64
%r10 = or i128 %r4, %r9
%r11 = zext i128 %r10 to i192
%r13 = getelementptr i64, i64* %r2, i32 2
%r14 = load i64, i64* %r13
%r15 = zext i64 %r14 to i192
%r16 = shl i192 %r15, 128
%r17 = or i192 %r11, %r16
%r18 = zext i192 %r17 to i256
%r20 = getelementptr i64, i64* %r2, i32 3
%r21 = load i64, i64* %r20
%r22 = zext i64 %r21 to i256
%r23 = shl i256 %r22, 192
%r24 = or i256 %r18, %r23
%r25 = zext i256 %r24 to i320
%r27 = getelementptr i64, i64* %r2, i32 4
%r28 = load i64, i64* %r27
%r29 = zext i64 %r28 to i320
%r30 = shl i320 %r29, 256
%r31 = or i320 %r25, %r30
%r32 = zext i320 %r31 to i384
%r34 = getelementptr i64, i64* %r2, i32 5
%r35 = load i64, i64* %r34
%r36 = zext i64 %r35 to i384
%r37 = shl i384 %r36, 320
%r38 = or i384 %r32, %r37
%r39 = zext i384 %r38 to i448
%r41 = getelementptr i64, i64* %r2, i32 6
%r42 = load i64, i64* %r41
%r43 = zext i64 %r42 to i448
%r44 = shl i448 %r43, 384
%r45 = or i448 %r39, %r44
%r46 = lshr i448 %r45, 1
%r47 = trunc i448 %r46 to i64
%r49 = getelementptr i64, i64* %r1, i32 0
store i64 %r47, i64* %r49
%r50 = lshr i448 %r46, 64
%r51 = trunc i448 %r50 to i64
%r53 = getelementptr i64, i64* %r1, i32 1
store i64 %r51, i64* %r53
%r54 = lshr i448 %r50, 64
%r55 = trunc i448 %r54 to i64
%r57 = getelementptr i64, i64* %r1, i32 2
store i64 %r55, i64* %r57
%r58 = lshr i448 %r54, 64
%r59 = trunc i448 %r58 to i64
%r61 = getelementptr i64, i64* %r1, i32 3
store i64 %r59, i64* %r61
%r62 = lshr i448 %r58, 64
%r63 = trunc i448 %r62 to i64
%r65 = getelementptr i64, i64* %r1, i32 4
store i64 %r63, i64* %r65
%r66 = lshr i448 %r62, 64
%r67 = trunc i448 %r66 to i64
%r69 = getelementptr i64, i64* %r1, i32 5
store i64 %r67, i64* %r69
%r70 = lshr i448 %r66, 64
%r71 = trunc i448 %r70 to i64
%r73 = getelementptr i64, i64* %r1, i32 6
store i64 %r71, i64* %r73
ret void
}
define void @mcl_fp_add7L(i64* noalias  %r1, i64* noalias  %r2, i64* noalias  %r3, i64* noalias  %r4)
{
%r5 = load i64, i64* %r2
%r6 = zext i64 %r5 to i128
%r8 = getelementptr i64, i64* %r2, i32 1
%r9 = load i64, i64* %r8
%r10 = zext i64 %r9 to i128
%r11 = shl i128 %r10, 64
%r12 = or i128 %r6, %r11
%r13 = zext i128 %r12 to i192
%r15 = getelementptr i64, i64* %r2, i32 2
%r16 = load i64, i64* %r15
%r17 = zext i64 %r16 to i192
%r18 = shl i192 %r17, 128
%r19 = or i192 %r13, %r18
%r20 = zext i192 %r19 to i256
%r22 = getelementptr i64, i64* %r2, i32 3
%r23 = load i64, i64* %r22
%r24 = zext i64 %r23 to i256
%r25 = shl i256 %r24, 192
%r26 = or i256 %r20, %r25
%r27 = zext i256 %r26 to i320
%r29 = getelementptr i64, i64* %r2, i32 4
%r30 = load i64, i64* %r29
%r31 = zext i64 %r30 to i320
%r32 = shl i320 %r31, 256
%r33 = or i320 %r27, %r32
%r34 = zext i320 %r33 to i384
%r36 = getelementptr i64, i64* %r2, i32 5
%r37 = load i64, i64* %r36
%r38 = zext i64 %r37 to i384
%r39 = shl i384 %r38, 320
%r40 = or i384 %r34, %r39
%r41 = zext i384 %r40 to i448
%r43 = getelementptr i64, i64* %r2, i32 6
%r44 = load i64, i64* %r43
%r45 = zext i64 %r44 to i448
%r46 = shl i448 %r45, 384
%r47 = or i448 %r41, %r46
%r48 = load i64, i64* %r3
%r49 = zext i64 %r48 to i128
%r51 = getelementptr i64, i64* %r3, i32 1
%r52 = load i64, i64* %r51
%r53 = zext i64 %r52 to i128
%r54 = shl i128 %r53, 64
%r55 = or i128 %r49, %r54
%r56 = zext i128 %r55 to i192
%r58 = getelementptr i64, i64* %r3, i32 2
%r59 = load i64, i64* %r58
%r60 = zext i64 %r59 to i192
%r61 = shl i192 %r60, 128
%r62 = or i192 %r56, %r61
%r63 = zext i192 %r62 to i256
%r65 = getelementptr i64, i64* %r3, i32 3
%r66 = load i64, i64* %r65
%r67 = zext i64 %r66 to i256
%r68 = shl i256 %r67, 192
%r69 = or i256 %r63, %r68
%r70 = zext i256 %r69 to i320
%r72 = getelementptr i64, i64* %r3, i32 4
%r73 = load i64, i64* %r72
%r74 = zext i64 %r73 to i320
%r75 = shl i320 %r74, 256
%r76 = or i320 %r70, %r75
%r77 = zext i320 %r76 to i384
%r79 = getelementptr i64, i64* %r3, i32 5
%r80 = load i64, i64* %r79
%r81 = zext i64 %r80 to i384
%r82 = shl i384 %r81, 320
%r83 = or i384 %r77, %r82
%r84 = zext i384 %r83 to i448
%r86 = getelementptr i64, i64* %r3, i32 6
%r87 = load i64, i64* %r86
%r88 = zext i64 %r87 to i448
%r89 = shl i448 %r88, 384
%r90 = or i448 %r84, %r89
%r91 = zext i448 %r47 to i512
%r92 = zext i448 %r90 to i512
%r93 = add i512 %r91, %r92
%r94 = trunc i512 %r93 to i448
%r95 = trunc i448 %r94 to i64
%r97 = getelementptr i64, i64* %r1, i32 0
store i64 %r95, i64* %r97
%r98 = lshr i448 %r94, 64
%r99 = trunc i448 %r98 to i64
%r101 = getelementptr i64, i64* %r1, i32 1
store i64 %r99, i64* %r101
%r102 = lshr i448 %r98, 64
%r103 = trunc i448 %r102 to i64
%r105 = getelementptr i64, i64* %r1, i32 2
store i64 %r103, i64* %r105
%r106 = lshr i448 %r102, 64
%r107 = trunc i448 %r106 to i64
%r109 = getelementptr i64, i64* %r1, i32 3
store i64 %r107, i64* %r109
%r110 = lshr i448 %r106, 64
%r111 = trunc i448 %r110 to i64
%r113 = getelementptr i64, i64* %r1, i32 4
store i64 %r111, i64* %r113
%r114 = lshr i448 %r110, 64
%r115 = trunc i448 %r114 to i64
%r117 = getelementptr i64, i64* %r1, i32 5
store i64 %r115, i64* %r117
%r118 = lshr i448 %r114, 64
%r119 = trunc i448 %r118 to i64
%r121 = getelementptr i64, i64* %r1, i32 6
store i64 %r119, i64* %r121
%r122 = load i64, i64* %r4
%r123 = zext i64 %r122 to i128
%r125 = getelementptr i64, i64* %r4, i32 1
%r126 = load i64, i64* %r125
%r127 = zext i64 %r126 to i128
%r128 = shl i128 %r127, 64
%r129 = or i128 %r123, %r128
%r130 = zext i128 %r129 to i192
%r132 = getelementptr i64, i64* %r4, i32 2
%r133 = load i64, i64* %r132
%r134 = zext i64 %r133 to i192
%r135 = shl i192 %r134, 128
%r136 = or i192 %r130, %r135
%r137 = zext i192 %r136 to i256
%r139 = getelementptr i64, i64* %r4, i32 3
%r140 = load i64, i64* %r139
%r141 = zext i64 %r140 to i256
%r142 = shl i256 %r141, 192
%r143 = or i256 %r137, %r142
%r144 = zext i256 %r143 to i320
%r146 = getelementptr i64, i64* %r4, i32 4
%r147 = load i64, i64* %r146
%r148 = zext i64 %r147 to i320
%r149 = shl i320 %r148, 256
%r150 = or i320 %r144, %r149
%r151 = zext i320 %r150 to i384
%r153 = getelementptr i64, i64* %r4, i32 5
%r154 = load i64, i64* %r153
%r155 = zext i64 %r154 to i384
%r156 = shl i384 %r155, 320
%r157 = or i384 %r151, %r156
%r158 = zext i384 %r157 to i448
%r160 = getelementptr i64, i64* %r4, i32 6
%r161 = load i64, i64* %r160
%r162 = zext i64 %r161 to i448
%r163 = shl i448 %r162, 384
%r164 = or i448 %r158, %r163
%r165 = zext i448 %r164 to i512
%r166 = sub i512 %r93, %r165
%r167 = lshr i512 %r166, 448
%r168 = trunc i512 %r167 to i1
br i1%r168, label %carry, label %nocarry
nocarry:
%r169 = trunc i512 %r166 to i448
%r170 = trunc i448 %r169 to i64
%r172 = getelementptr i64, i64* %r1, i32 0
store i64 %r170, i64* %r172
%r173 = lshr i448 %r169, 64
%r174 = trunc i448 %r173 to i64
%r176 = getelementptr i64, i64* %r1, i32 1
store i64 %r174, i64* %r176
%r177 = lshr i448 %r173, 64
%r178 = trunc i448 %r177 to i64
%r180 = getelementptr i64, i64* %r1, i32 2
store i64 %r178, i64* %r180
%r181 = lshr i448 %r177, 64
%r182 = trunc i448 %r181 to i64
%r184 = getelementptr i64, i64* %r1, i32 3
store i64 %r182, i64* %r184
%r185 = lshr i448 %r181, 64
%r186 = trunc i448 %r185 to i64
%r188 = getelementptr i64, i64* %r1, i32 4
store i64 %r186, i64* %r188
%r189 = lshr i448 %r185, 64
%r190 = trunc i448 %r189 to i64
%r192 = getelementptr i64, i64* %r1, i32 5
store i64 %r190, i64* %r192
%r193 = lshr i448 %r189, 64
%r194 = trunc i448 %r193 to i64
%r196 = getelementptr i64, i64* %r1, i32 6
store i64 %r194, i64* %r196
ret void
carry:
ret void
}
define void @mcl_fp_addNF7L(i64* noalias  %r1, i64* noalias  %r2, i64* noalias  %r3, i64* noalias  %r4)
{
%r5 = load i64, i64* %r2
%r6 = zext i64 %r5 to i128
%r8 = getelementptr i64, i64* %r2, i32 1
%r9 = load i64, i64* %r8
%r10 = zext i64 %r9 to i128
%r11 = shl i128 %r10, 64
%r12 = or i128 %r6, %r11
%r13 = zext i128 %r12 to i192
%r15 = getelementptr i64, i64* %r2, i32 2
%r16 = load i64, i64* %r15
%r17 = zext i64 %r16 to i192
%r18 = shl i192 %r17, 128
%r19 = or i192 %r13, %r18
%r20 = zext i192 %r19 to i256
%r22 = getelementptr i64, i64* %r2, i32 3
%r23 = load i64, i64* %r22
%r24 = zext i64 %r23 to i256
%r25 = shl i256 %r24, 192
%r26 = or i256 %r20, %r25
%r27 = zext i256 %r26 to i320
%r29 = getelementptr i64, i64* %r2, i32 4
%r30 = load i64, i64* %r29
%r31 = zext i64 %r30 to i320
%r32 = shl i320 %r31, 256
%r33 = or i320 %r27, %r32
%r34 = zext i320 %r33 to i384
%r36 = getelementptr i64, i64* %r2, i32 5
%r37 = load i64, i64* %r36
%r38 = zext i64 %r37 to i384
%r39 = shl i384 %r38, 320
%r40 = or i384 %r34, %r39
%r41 = zext i384 %r40 to i448
%r43 = getelementptr i64, i64* %r2, i32 6
%r44 = load i64, i64* %r43
%r45 = zext i64 %r44 to i448
%r46 = shl i448 %r45, 384
%r47 = or i448 %r41, %r46
%r48 = load i64, i64* %r3
%r49 = zext i64 %r48 to i128
%r51 = getelementptr i64, i64* %r3, i32 1
%r52 = load i64, i64* %r51
%r53 = zext i64 %r52 to i128
%r54 = shl i128 %r53, 64
%r55 = or i128 %r49, %r54
%r56 = zext i128 %r55 to i192
%r58 = getelementptr i64, i64* %r3, i32 2
%r59 = load i64, i64* %r58
%r60 = zext i64 %r59 to i192
%r61 = shl i192 %r60, 128
%r62 = or i192 %r56, %r61
%r63 = zext i192 %r62 to i256
%r65 = getelementptr i64, i64* %r3, i32 3
%r66 = load i64, i64* %r65
%r67 = zext i64 %r66 to i256
%r68 = shl i256 %r67, 192
%r69 = or i256 %r63, %r68
%r70 = zext i256 %r69 to i320
%r72 = getelementptr i64, i64* %r3, i32 4
%r73 = load i64, i64* %r72
%r74 = zext i64 %r73 to i320
%r75 = shl i320 %r74, 256
%r76 = or i320 %r70, %r75
%r77 = zext i320 %r76 to i384
%r79 = getelementptr i64, i64* %r3, i32 5
%r80 = load i64, i64* %r79
%r81 = zext i64 %r80 to i384
%r82 = shl i384 %r81, 320
%r83 = or i384 %r77, %r82
%r84 = zext i384 %r83 to i448
%r86 = getelementptr i64, i64* %r3, i32 6
%r87 = load i64, i64* %r86
%r88 = zext i64 %r87 to i448
%r89 = shl i448 %r88, 384
%r90 = or i448 %r84, %r89
%r91 = add i448 %r47, %r90
%r92 = load i64, i64* %r4
%r93 = zext i64 %r92 to i128
%r95 = getelementptr i64, i64* %r4, i32 1
%r96 = load i64, i64* %r95
%r97 = zext i64 %r96 to i128
%r98 = shl i128 %r97, 64
%r99 = or i128 %r93, %r98
%r100 = zext i128 %r99 to i192
%r102 = getelementptr i64, i64* %r4, i32 2
%r103 = load i64, i64* %r102
%r104 = zext i64 %r103 to i192
%r105 = shl i192 %r104, 128
%r106 = or i192 %r100, %r105
%r107 = zext i192 %r106 to i256
%r109 = getelementptr i64, i64* %r4, i32 3
%r110 = load i64, i64* %r109
%r111 = zext i64 %r110 to i256
%r112 = shl i256 %r111, 192
%r113 = or i256 %r107, %r112
%r114 = zext i256 %r113 to i320
%r116 = getelementptr i64, i64* %r4, i32 4
%r117 = load i64, i64* %r116
%r118 = zext i64 %r117 to i320
%r119 = shl i320 %r118, 256
%r120 = or i320 %r114, %r119
%r121 = zext i320 %r120 to i384
%r123 = getelementptr i64, i64* %r4, i32 5
%r124 = load i64, i64* %r123
%r125 = zext i64 %r124 to i384
%r126 = shl i384 %r125, 320
%r127 = or i384 %r121, %r126
%r128 = zext i384 %r127 to i448
%r130 = getelementptr i64, i64* %r4, i32 6
%r131 = load i64, i64* %r130
%r132 = zext i64 %r131 to i448
%r133 = shl i448 %r132, 384
%r134 = or i448 %r128, %r133
%r135 = sub i448 %r91, %r134
%r136 = lshr i448 %r135, 447
%r137 = trunc i448 %r136 to i1
%r138 = select i1 %r137, i448 %r91, i448 %r135
%r139 = trunc i448 %r138 to i64
%r141 = getelementptr i64, i64* %r1, i32 0
store i64 %r139, i64* %r141
%r142 = lshr i448 %r138, 64
%r143 = trunc i448 %r142 to i64
%r145 = getelementptr i64, i64* %r1, i32 1
store i64 %r143, i64* %r145
%r146 = lshr i448 %r142, 64
%r147 = trunc i448 %r146 to i64
%r149 = getelementptr i64, i64* %r1, i32 2
store i64 %r147, i64* %r149
%r150 = lshr i448 %r146, 64
%r151 = trunc i448 %r150 to i64
%r153 = getelementptr i64, i64* %r1, i32 3
store i64 %r151, i64* %r153
%r154 = lshr i448 %r150, 64
%r155 = trunc i448 %r154 to i64
%r157 = getelementptr i64, i64* %r1, i32 4
store i64 %r155, i64* %r157
%r158 = lshr i448 %r154, 64
%r159 = trunc i448 %r158 to i64
%r161 = getelementptr i64, i64* %r1, i32 5
store i64 %r159, i64* %r161
%r162 = lshr i448 %r158, 64
%r163 = trunc i448 %r162 to i64
%r165 = getelementptr i64, i64* %r1, i32 6
store i64 %r163, i64* %r165
ret void
}
define void @mcl_fp_sub7L(i64* noalias  %r1, i64* noalias  %r2, i64* noalias  %r3, i64* noalias  %r4)
{
%r5 = load i64, i64* %r2
%r6 = zext i64 %r5 to i128
%r8 = getelementptr i64, i64* %r2, i32 1
%r9 = load i64, i64* %r8
%r10 = zext i64 %r9 to i128
%r11 = shl i128 %r10, 64
%r12 = or i128 %r6, %r11
%r13 = zext i128 %r12 to i192
%r15 = getelementptr i64, i64* %r2, i32 2
%r16 = load i64, i64* %r15
%r17 = zext i64 %r16 to i192
%r18 = shl i192 %r17, 128
%r19 = or i192 %r13, %r18
%r20 = zext i192 %r19 to i256
%r22 = getelementptr i64, i64* %r2, i32 3
%r23 = load i64, i64* %r22
%r24 = zext i64 %r23 to i256
%r25 = shl i256 %r24, 192
%r26 = or i256 %r20, %r25
%r27 = zext i256 %r26 to i320
%r29 = getelementptr i64, i64* %r2, i32 4
%r30 = load i64, i64* %r29
%r31 = zext i64 %r30 to i320
%r32 = shl i320 %r31, 256
%r33 = or i320 %r27, %r32
%r34 = zext i320 %r33 to i384
%r36 = getelementptr i64, i64* %r2, i32 5
%r37 = load i64, i64* %r36
%r38 = zext i64 %r37 to i384
%r39 = shl i384 %r38, 320
%r40 = or i384 %r34, %r39
%r41 = zext i384 %r40 to i448
%r43 = getelementptr i64, i64* %r2, i32 6
%r44 = load i64, i64* %r43
%r45 = zext i64 %r44 to i448
%r46 = shl i448 %r45, 384
%r47 = or i448 %r41, %r46
%r48 = load i64, i64* %r3
%r49 = zext i64 %r48 to i128
%r51 = getelementptr i64, i64* %r3, i32 1
%r52 = load i64, i64* %r51
%r53 = zext i64 %r52 to i128
%r54 = shl i128 %r53, 64
%r55 = or i128 %r49, %r54
%r56 = zext i128 %r55 to i192
%r58 = getelementptr i64, i64* %r3, i32 2
%r59 = load i64, i64* %r58
%r60 = zext i64 %r59 to i192
%r61 = shl i192 %r60, 128
%r62 = or i192 %r56, %r61
%r63 = zext i192 %r62 to i256
%r65 = getelementptr i64, i64* %r3, i32 3
%r66 = load i64, i64* %r65
%r67 = zext i64 %r66 to i256
%r68 = shl i256 %r67, 192
%r69 = or i256 %r63, %r68
%r70 = zext i256 %r69 to i320
%r72 = getelementptr i64, i64* %r3, i32 4
%r73 = load i64, i64* %r72
%r74 = zext i64 %r73 to i320
%r75 = shl i320 %r74, 256
%r76 = or i320 %r70, %r75
%r77 = zext i320 %r76 to i384
%r79 = getelementptr i64, i64* %r3, i32 5
%r80 = load i64, i64* %r79
%r81 = zext i64 %r80 to i384
%r82 = shl i384 %r81, 320
%r83 = or i384 %r77, %r82
%r84 = zext i384 %r83 to i448
%r86 = getelementptr i64, i64* %r3, i32 6
%r87 = load i64, i64* %r86
%r88 = zext i64 %r87 to i448
%r89 = shl i448 %r88, 384
%r90 = or i448 %r84, %r89
%r91 = zext i448 %r47 to i512
%r92 = zext i448 %r90 to i512
%r93 = sub i512 %r91, %r92
%r94 = trunc i512 %r93 to i448
%r95 = lshr i512 %r93, 448
%r96 = trunc i512 %r95 to i1
%r97 = trunc i448 %r94 to i64
%r99 = getelementptr i64, i64* %r1, i32 0
store i64 %r97, i64* %r99
%r100 = lshr i448 %r94, 64
%r101 = trunc i448 %r100 to i64
%r103 = getelementptr i64, i64* %r1, i32 1
store i64 %r101, i64* %r103
%r104 = lshr i448 %r100, 64
%r105 = trunc i448 %r104 to i64
%r107 = getelementptr i64, i64* %r1, i32 2
store i64 %r105, i64* %r107
%r108 = lshr i448 %r104, 64
%r109 = trunc i448 %r108 to i64
%r111 = getelementptr i64, i64* %r1, i32 3
store i64 %r109, i64* %r111
%r112 = lshr i448 %r108, 64
%r113 = trunc i448 %r112 to i64
%r115 = getelementptr i64, i64* %r1, i32 4
store i64 %r113, i64* %r115
%r116 = lshr i448 %r112, 64
%r117 = trunc i448 %r116 to i64
%r119 = getelementptr i64, i64* %r1, i32 5
store i64 %r117, i64* %r119
%r120 = lshr i448 %r116, 64
%r121 = trunc i448 %r120 to i64
%r123 = getelementptr i64, i64* %r1, i32 6
store i64 %r121, i64* %r123
br i1%r96, label %carry, label %nocarry
nocarry:
ret void
carry:
%r124 = load i64, i64* %r4
%r125 = zext i64 %r124 to i128
%r127 = getelementptr i64, i64* %r4, i32 1
%r128 = load i64, i64* %r127
%r129 = zext i64 %r128 to i128
%r130 = shl i128 %r129, 64
%r131 = or i128 %r125, %r130
%r132 = zext i128 %r131 to i192
%r134 = getelementptr i64, i64* %r4, i32 2
%r135 = load i64, i64* %r134
%r136 = zext i64 %r135 to i192
%r137 = shl i192 %r136, 128
%r138 = or i192 %r132, %r137
%r139 = zext i192 %r138 to i256
%r141 = getelementptr i64, i64* %r4, i32 3
%r142 = load i64, i64* %r141
%r143 = zext i64 %r142 to i256
%r144 = shl i256 %r143, 192
%r145 = or i256 %r139, %r144
%r146 = zext i256 %r145 to i320
%r148 = getelementptr i64, i64* %r4, i32 4
%r149 = load i64, i64* %r148
%r150 = zext i64 %r149 to i320
%r151 = shl i320 %r150, 256
%r152 = or i320 %r146, %r151
%r153 = zext i320 %r152 to i384
%r155 = getelementptr i64, i64* %r4, i32 5
%r156 = load i64, i64* %r155
%r157 = zext i64 %r156 to i384
%r158 = shl i384 %r157, 320
%r159 = or i384 %r153, %r158
%r160 = zext i384 %r159 to i448
%r162 = getelementptr i64, i64* %r4, i32 6
%r163 = load i64, i64* %r162
%r164 = zext i64 %r163 to i448
%r165 = shl i448 %r164, 384
%r166 = or i448 %r160, %r165
%r167 = add i448 %r94, %r166
%r168 = trunc i448 %r167 to i64
%r170 = getelementptr i64, i64* %r1, i32 0
store i64 %r168, i64* %r170
%r171 = lshr i448 %r167, 64
%r172 = trunc i448 %r171 to i64
%r174 = getelementptr i64, i64* %r1, i32 1
store i64 %r172, i64* %r174
%r175 = lshr i448 %r171, 64
%r176 = trunc i448 %r175 to i64
%r178 = getelementptr i64, i64* %r1, i32 2
store i64 %r176, i64* %r178
%r179 = lshr i448 %r175, 64
%r180 = trunc i448 %r179 to i64
%r182 = getelementptr i64, i64* %r1, i32 3
store i64 %r180, i64* %r182
%r183 = lshr i448 %r179, 64
%r184 = trunc i448 %r183 to i64
%r186 = getelementptr i64, i64* %r1, i32 4
store i64 %r184, i64* %r186
%r187 = lshr i448 %r183, 64
%r188 = trunc i448 %r187 to i64
%r190 = getelementptr i64, i64* %r1, i32 5
store i64 %r188, i64* %r190
%r191 = lshr i448 %r187, 64
%r192 = trunc i448 %r191 to i64
%r194 = getelementptr i64, i64* %r1, i32 6
store i64 %r192, i64* %r194
ret void
}
define void @mcl_fp_subNF7L(i64* noalias  %r1, i64* noalias  %r2, i64* noalias  %r3, i64* noalias  %r4)
{
%r5 = load i64, i64* %r2
%r6 = zext i64 %r5 to i128
%r8 = getelementptr i64, i64* %r2, i32 1
%r9 = load i64, i64* %r8
%r10 = zext i64 %r9 to i128
%r11 = shl i128 %r10, 64
%r12 = or i128 %r6, %r11
%r13 = zext i128 %r12 to i192
%r15 = getelementptr i64, i64* %r2, i32 2
%r16 = load i64, i64* %r15
%r17 = zext i64 %r16 to i192
%r18 = shl i192 %r17, 128
%r19 = or i192 %r13, %r18
%r20 = zext i192 %r19 to i256
%r22 = getelementptr i64, i64* %r2, i32 3
%r23 = load i64, i64* %r22
%r24 = zext i64 %r23 to i256
%r25 = shl i256 %r24, 192
%r26 = or i256 %r20, %r25
%r27 = zext i256 %r26 to i320
%r29 = getelementptr i64, i64* %r2, i32 4
%r30 = load i64, i64* %r29
%r31 = zext i64 %r30 to i320
%r32 = shl i320 %r31, 256
%r33 = or i320 %r27, %r32
%r34 = zext i320 %r33 to i384
%r36 = getelementptr i64, i64* %r2, i32 5
%r37 = load i64, i64* %r36
%r38 = zext i64 %r37 to i384
%r39 = shl i384 %r38, 320
%r40 = or i384 %r34, %r39
%r41 = zext i384 %r40 to i448
%r43 = getelementptr i64, i64* %r2, i32 6
%r44 = load i64, i64* %r43
%r45 = zext i64 %r44 to i448
%r46 = shl i448 %r45, 384
%r47 = or i448 %r41, %r46
%r48 = load i64, i64* %r3
%r49 = zext i64 %r48 to i128
%r51 = getelementptr i64, i64* %r3, i32 1
%r52 = load i64, i64* %r51
%r53 = zext i64 %r52 to i128
%r54 = shl i128 %r53, 64
%r55 = or i128 %r49, %r54
%r56 = zext i128 %r55 to i192
%r58 = getelementptr i64, i64* %r3, i32 2
%r59 = load i64, i64* %r58
%r60 = zext i64 %r59 to i192
%r61 = shl i192 %r60, 128
%r62 = or i192 %r56, %r61
%r63 = zext i192 %r62 to i256
%r65 = getelementptr i64, i64* %r3, i32 3
%r66 = load i64, i64* %r65
%r67 = zext i64 %r66 to i256
%r68 = shl i256 %r67, 192
%r69 = or i256 %r63, %r68
%r70 = zext i256 %r69 to i320
%r72 = getelementptr i64, i64* %r3, i32 4
%r73 = load i64, i64* %r72
%r74 = zext i64 %r73 to i320
%r75 = shl i320 %r74, 256
%r76 = or i320 %r70, %r75
%r77 = zext i320 %r76 to i384
%r79 = getelementptr i64, i64* %r3, i32 5
%r80 = load i64, i64* %r79
%r81 = zext i64 %r80 to i384
%r82 = shl i384 %r81, 320
%r83 = or i384 %r77, %r82
%r84 = zext i384 %r83 to i448
%r86 = getelementptr i64, i64* %r3, i32 6
%r87 = load i64, i64* %r86
%r88 = zext i64 %r87 to i448
%r89 = shl i448 %r88, 384
%r90 = or i448 %r84, %r89
%r91 = sub i448 %r47, %r90
%r92 = lshr i448 %r91, 447
%r93 = trunc i448 %r92 to i1
%r94 = load i64, i64* %r4
%r95 = zext i64 %r94 to i128
%r97 = getelementptr i64, i64* %r4, i32 1
%r98 = load i64, i64* %r97
%r99 = zext i64 %r98 to i128
%r100 = shl i128 %r99, 64
%r101 = or i128 %r95, %r100
%r102 = zext i128 %r101 to i192
%r104 = getelementptr i64, i64* %r4, i32 2
%r105 = load i64, i64* %r104
%r106 = zext i64 %r105 to i192
%r107 = shl i192 %r106, 128
%r108 = or i192 %r102, %r107
%r109 = zext i192 %r108 to i256
%r111 = getelementptr i64, i64* %r4, i32 3
%r112 = load i64, i64* %r111
%r113 = zext i64 %r112 to i256
%r114 = shl i256 %r113, 192
%r115 = or i256 %r109, %r114
%r116 = zext i256 %r115 to i320
%r118 = getelementptr i64, i64* %r4, i32 4
%r119 = load i64, i64* %r118
%r120 = zext i64 %r119 to i320
%r121 = shl i320 %r120, 256
%r122 = or i320 %r116, %r121
%r123 = zext i320 %r122 to i384
%r125 = getelementptr i64, i64* %r4, i32 5
%r126 = load i64, i64* %r125
%r127 = zext i64 %r126 to i384
%r128 = shl i384 %r127, 320
%r129 = or i384 %r123, %r128
%r130 = zext i384 %r129 to i448
%r132 = getelementptr i64, i64* %r4, i32 6
%r133 = load i64, i64* %r132
%r134 = zext i64 %r133 to i448
%r135 = shl i448 %r134, 384
%r136 = or i448 %r130, %r135
%r138 = select i1 %r93, i448 %r136, i448 0
%r139 = add i448 %r91, %r138
%r140 = trunc i448 %r139 to i64
%r142 = getelementptr i64, i64* %r1, i32 0
store i64 %r140, i64* %r142
%r143 = lshr i448 %r139, 64
%r144 = trunc i448 %r143 to i64
%r146 = getelementptr i64, i64* %r1, i32 1
store i64 %r144, i64* %r146
%r147 = lshr i448 %r143, 64
%r148 = trunc i448 %r147 to i64
%r150 = getelementptr i64, i64* %r1, i32 2
store i64 %r148, i64* %r150
%r151 = lshr i448 %r147, 64
%r152 = trunc i448 %r151 to i64
%r154 = getelementptr i64, i64* %r1, i32 3
store i64 %r152, i64* %r154
%r155 = lshr i448 %r151, 64
%r156 = trunc i448 %r155 to i64
%r158 = getelementptr i64, i64* %r1, i32 4
store i64 %r156, i64* %r158
%r159 = lshr i448 %r155, 64
%r160 = trunc i448 %r159 to i64
%r162 = getelementptr i64, i64* %r1, i32 5
store i64 %r160, i64* %r162
%r163 = lshr i448 %r159, 64
%r164 = trunc i448 %r163 to i64
%r166 = getelementptr i64, i64* %r1, i32 6
store i64 %r164, i64* %r166
ret void
}
define void @mcl_fpDbl_add7L(i64* noalias  %r1, i64* noalias  %r2, i64* noalias  %r3, i64* noalias  %r4)
{
%r5 = load i64, i64* %r2
%r6 = zext i64 %r5 to i128
%r8 = getelementptr i64, i64* %r2, i32 1
%r9 = load i64, i64* %r8
%r10 = zext i64 %r9 to i128
%r11 = shl i128 %r10, 64
%r12 = or i128 %r6, %r11
%r13 = zext i128 %r12 to i192
%r15 = getelementptr i64, i64* %r2, i32 2
%r16 = load i64, i64* %r15
%r17 = zext i64 %r16 to i192
%r18 = shl i192 %r17, 128
%r19 = or i192 %r13, %r18
%r20 = zext i192 %r19 to i256
%r22 = getelementptr i64, i64* %r2, i32 3
%r23 = load i64, i64* %r22
%r24 = zext i64 %r23 to i256
%r25 = shl i256 %r24, 192
%r26 = or i256 %r20, %r25
%r27 = zext i256 %r26 to i320
%r29 = getelementptr i64, i64* %r2, i32 4
%r30 = load i64, i64* %r29
%r31 = zext i64 %r30 to i320
%r32 = shl i320 %r31, 256
%r33 = or i320 %r27, %r32
%r34 = zext i320 %r33 to i384
%r36 = getelementptr i64, i64* %r2, i32 5
%r37 = load i64, i64* %r36
%r38 = zext i64 %r37 to i384
%r39 = shl i384 %r38, 320
%r40 = or i384 %r34, %r39
%r41 = zext i384 %r40 to i448
%r43 = getelementptr i64, i64* %r2, i32 6
%r44 = load i64, i64* %r43
%r45 = zext i64 %r44 to i448
%r46 = shl i448 %r45, 384
%r47 = or i448 %r41, %r46
%r48 = zext i448 %r47 to i512
%r50 = getelementptr i64, i64* %r2, i32 7
%r51 = load i64, i64* %r50
%r52 = zext i64 %r51 to i512
%r53 = shl i512 %r52, 448
%r54 = or i512 %r48, %r53
%r55 = zext i512 %r54 to i576
%r57 = getelementptr i64, i64* %r2, i32 8
%r58 = load i64, i64* %r57
%r59 = zext i64 %r58 to i576
%r60 = shl i576 %r59, 512
%r61 = or i576 %r55, %r60
%r62 = zext i576 %r61 to i640
%r64 = getelementptr i64, i64* %r2, i32 9
%r65 = load i64, i64* %r64
%r66 = zext i64 %r65 to i640
%r67 = shl i640 %r66, 576
%r68 = or i640 %r62, %r67
%r69 = zext i640 %r68 to i704
%r71 = getelementptr i64, i64* %r2, i32 10
%r72 = load i64, i64* %r71
%r73 = zext i64 %r72 to i704
%r74 = shl i704 %r73, 640
%r75 = or i704 %r69, %r74
%r76 = zext i704 %r75 to i768
%r78 = getelementptr i64, i64* %r2, i32 11
%r79 = load i64, i64* %r78
%r80 = zext i64 %r79 to i768
%r81 = shl i768 %r80, 704
%r82 = or i768 %r76, %r81
%r83 = zext i768 %r82 to i832
%r85 = getelementptr i64, i64* %r2, i32 12
%r86 = load i64, i64* %r85
%r87 = zext i64 %r86 to i832
%r88 = shl i832 %r87, 768
%r89 = or i832 %r83, %r88
%r90 = zext i832 %r89 to i896
%r92 = getelementptr i64, i64* %r2, i32 13
%r93 = load i64, i64* %r92
%r94 = zext i64 %r93 to i896
%r95 = shl i896 %r94, 832
%r96 = or i896 %r90, %r95
%r97 = load i64, i64* %r3
%r98 = zext i64 %r97 to i128
%r100 = getelementptr i64, i64* %r3, i32 1
%r101 = load i64, i64* %r100
%r102 = zext i64 %r101 to i128
%r103 = shl i128 %r102, 64
%r104 = or i128 %r98, %r103
%r105 = zext i128 %r104 to i192
%r107 = getelementptr i64, i64* %r3, i32 2
%r108 = load i64, i64* %r107
%r109 = zext i64 %r108 to i192
%r110 = shl i192 %r109, 128
%r111 = or i192 %r105, %r110
%r112 = zext i192 %r111 to i256
%r114 = getelementptr i64, i64* %r3, i32 3
%r115 = load i64, i64* %r114
%r116 = zext i64 %r115 to i256
%r117 = shl i256 %r116, 192
%r118 = or i256 %r112, %r117
%r119 = zext i256 %r118 to i320
%r121 = getelementptr i64, i64* %r3, i32 4
%r122 = load i64, i64* %r121
%r123 = zext i64 %r122 to i320
%r124 = shl i320 %r123, 256
%r125 = or i320 %r119, %r124
%r126 = zext i320 %r125 to i384
%r128 = getelementptr i64, i64* %r3, i32 5
%r129 = load i64, i64* %r128
%r130 = zext i64 %r129 to i384
%r131 = shl i384 %r130, 320
%r132 = or i384 %r126, %r131
%r133 = zext i384 %r132 to i448
%r135 = getelementptr i64, i64* %r3, i32 6
%r136 = load i64, i64* %r135
%r137 = zext i64 %r136 to i448
%r138 = shl i448 %r137, 384
%r139 = or i448 %r133, %r138
%r140 = zext i448 %r139 to i512
%r142 = getelementptr i64, i64* %r3, i32 7
%r143 = load i64, i64* %r142
%r144 = zext i64 %r143 to i512
%r145 = shl i512 %r144, 448
%r146 = or i512 %r140, %r145
%r147 = zext i512 %r146 to i576
%r149 = getelementptr i64, i64* %r3, i32 8
%r150 = load i64, i64* %r149
%r151 = zext i64 %r150 to i576
%r152 = shl i576 %r151, 512
%r153 = or i576 %r147, %r152
%r154 = zext i576 %r153 to i640
%r156 = getelementptr i64, i64* %r3, i32 9
%r157 = load i64, i64* %r156
%r158 = zext i64 %r157 to i640
%r159 = shl i640 %r158, 576
%r160 = or i640 %r154, %r159
%r161 = zext i640 %r160 to i704
%r163 = getelementptr i64, i64* %r3, i32 10
%r164 = load i64, i64* %r163
%r165 = zext i64 %r164 to i704
%r166 = shl i704 %r165, 640
%r167 = or i704 %r161, %r166
%r168 = zext i704 %r167 to i768
%r170 = getelementptr i64, i64* %r3, i32 11
%r171 = load i64, i64* %r170
%r172 = zext i64 %r171 to i768
%r173 = shl i768 %r172, 704
%r174 = or i768 %r168, %r173
%r175 = zext i768 %r174 to i832
%r177 = getelementptr i64, i64* %r3, i32 12
%r178 = load i64, i64* %r177
%r179 = zext i64 %r178 to i832
%r180 = shl i832 %r179, 768
%r181 = or i832 %r175, %r180
%r182 = zext i832 %r181 to i896
%r184 = getelementptr i64, i64* %r3, i32 13
%r185 = load i64, i64* %r184
%r186 = zext i64 %r185 to i896
%r187 = shl i896 %r186, 832
%r188 = or i896 %r182, %r187
%r189 = zext i896 %r96 to i960
%r190 = zext i896 %r188 to i960
%r191 = add i960 %r189, %r190
%r192 = trunc i960 %r191 to i448
%r193 = trunc i448 %r192 to i64
%r195 = getelementptr i64, i64* %r1, i32 0
store i64 %r193, i64* %r195
%r196 = lshr i448 %r192, 64
%r197 = trunc i448 %r196 to i64
%r199 = getelementptr i64, i64* %r1, i32 1
store i64 %r197, i64* %r199
%r200 = lshr i448 %r196, 64
%r201 = trunc i448 %r200 to i64
%r203 = getelementptr i64, i64* %r1, i32 2
store i64 %r201, i64* %r203
%r204 = lshr i448 %r200, 64
%r205 = trunc i448 %r204 to i64
%r207 = getelementptr i64, i64* %r1, i32 3
store i64 %r205, i64* %r207
%r208 = lshr i448 %r204, 64
%r209 = trunc i448 %r208 to i64
%r211 = getelementptr i64, i64* %r1, i32 4
store i64 %r209, i64* %r211
%r212 = lshr i448 %r208, 64
%r213 = trunc i448 %r212 to i64
%r215 = getelementptr i64, i64* %r1, i32 5
store i64 %r213, i64* %r215
%r216 = lshr i448 %r212, 64
%r217 = trunc i448 %r216 to i64
%r219 = getelementptr i64, i64* %r1, i32 6
store i64 %r217, i64* %r219
%r220 = lshr i960 %r191, 448
%r221 = trunc i960 %r220 to i512
%r222 = load i64, i64* %r4
%r223 = zext i64 %r222 to i128
%r225 = getelementptr i64, i64* %r4, i32 1
%r226 = load i64, i64* %r225
%r227 = zext i64 %r226 to i128
%r228 = shl i128 %r227, 64
%r229 = or i128 %r223, %r228
%r230 = zext i128 %r229 to i192
%r232 = getelementptr i64, i64* %r4, i32 2
%r233 = load i64, i64* %r232
%r234 = zext i64 %r233 to i192
%r235 = shl i192 %r234, 128
%r236 = or i192 %r230, %r235
%r237 = zext i192 %r236 to i256
%r239 = getelementptr i64, i64* %r4, i32 3
%r240 = load i64, i64* %r239
%r241 = zext i64 %r240 to i256
%r242 = shl i256 %r241, 192
%r243 = or i256 %r237, %r242
%r244 = zext i256 %r243 to i320
%r246 = getelementptr i64, i64* %r4, i32 4
%r247 = load i64, i64* %r246
%r248 = zext i64 %r247 to i320
%r249 = shl i320 %r248, 256
%r250 = or i320 %r244, %r249
%r251 = zext i320 %r250 to i384
%r253 = getelementptr i64, i64* %r4, i32 5
%r254 = load i64, i64* %r253
%r255 = zext i64 %r254 to i384
%r256 = shl i384 %r255, 320
%r257 = or i384 %r251, %r256
%r258 = zext i384 %r257 to i448
%r260 = getelementptr i64, i64* %r4, i32 6
%r261 = load i64, i64* %r260
%r262 = zext i64 %r261 to i448
%r263 = shl i448 %r262, 384
%r264 = or i448 %r258, %r263
%r265 = zext i448 %r264 to i512
%r266 = sub i512 %r221, %r265
%r267 = lshr i512 %r266, 448
%r268 = trunc i512 %r267 to i1
%r269 = select i1 %r268, i512 %r221, i512 %r266
%r270 = trunc i512 %r269 to i448
%r272 = getelementptr i64, i64* %r1, i32 7
%r273 = trunc i448 %r270 to i64
%r275 = getelementptr i64, i64* %r272, i32 0
store i64 %r273, i64* %r275
%r276 = lshr i448 %r270, 64
%r277 = trunc i448 %r276 to i64
%r279 = getelementptr i64, i64* %r272, i32 1
store i64 %r277, i64* %r279
%r280 = lshr i448 %r276, 64
%r281 = trunc i448 %r280 to i64
%r283 = getelementptr i64, i64* %r272, i32 2
store i64 %r281, i64* %r283
%r284 = lshr i448 %r280, 64
%r285 = trunc i448 %r284 to i64
%r287 = getelementptr i64, i64* %r272, i32 3
store i64 %r285, i64* %r287
%r288 = lshr i448 %r284, 64
%r289 = trunc i448 %r288 to i64
%r291 = getelementptr i64, i64* %r272, i32 4
store i64 %r289, i64* %r291
%r292 = lshr i448 %r288, 64
%r293 = trunc i448 %r292 to i64
%r295 = getelementptr i64, i64* %r272, i32 5
store i64 %r293, i64* %r295
%r296 = lshr i448 %r292, 64
%r297 = trunc i448 %r296 to i64
%r299 = getelementptr i64, i64* %r272, i32 6
store i64 %r297, i64* %r299
ret void
}
define void @mcl_fpDbl_sub7L(i64* noalias  %r1, i64* noalias  %r2, i64* noalias  %r3, i64* noalias  %r4)
{
%r5 = load i64, i64* %r2
%r6 = zext i64 %r5 to i128
%r8 = getelementptr i64, i64* %r2, i32 1
%r9 = load i64, i64* %r8
%r10 = zext i64 %r9 to i128
%r11 = shl i128 %r10, 64
%r12 = or i128 %r6, %r11
%r13 = zext i128 %r12 to i192
%r15 = getelementptr i64, i64* %r2, i32 2
%r16 = load i64, i64* %r15
%r17 = zext i64 %r16 to i192
%r18 = shl i192 %r17, 128
%r19 = or i192 %r13, %r18
%r20 = zext i192 %r19 to i256
%r22 = getelementptr i64, i64* %r2, i32 3
%r23 = load i64, i64* %r22
%r24 = zext i64 %r23 to i256
%r25 = shl i256 %r24, 192
%r26 = or i256 %r20, %r25
%r27 = zext i256 %r26 to i320
%r29 = getelementptr i64, i64* %r2, i32 4
%r30 = load i64, i64* %r29
%r31 = zext i64 %r30 to i320
%r32 = shl i320 %r31, 256
%r33 = or i320 %r27, %r32
%r34 = zext i320 %r33 to i384
%r36 = getelementptr i64, i64* %r2, i32 5
%r37 = load i64, i64* %r36
%r38 = zext i64 %r37 to i384
%r39 = shl i384 %r38, 320
%r40 = or i384 %r34, %r39
%r41 = zext i384 %r40 to i448
%r43 = getelementptr i64, i64* %r2, i32 6
%r44 = load i64, i64* %r43
%r45 = zext i64 %r44 to i448
%r46 = shl i448 %r45, 384
%r47 = or i448 %r41, %r46
%r48 = zext i448 %r47 to i512
%r50 = getelementptr i64, i64* %r2, i32 7
%r51 = load i64, i64* %r50
%r52 = zext i64 %r51 to i512
%r53 = shl i512 %r52, 448
%r54 = or i512 %r48, %r53
%r55 = zext i512 %r54 to i576
%r57 = getelementptr i64, i64* %r2, i32 8
%r58 = load i64, i64* %r57
%r59 = zext i64 %r58 to i576
%r60 = shl i576 %r59, 512
%r61 = or i576 %r55, %r60
%r62 = zext i576 %r61 to i640
%r64 = getelementptr i64, i64* %r2, i32 9
%r65 = load i64, i64* %r64
%r66 = zext i64 %r65 to i640
%r67 = shl i640 %r66, 576
%r68 = or i640 %r62, %r67
%r69 = zext i640 %r68 to i704
%r71 = getelementptr i64, i64* %r2, i32 10
%r72 = load i64, i64* %r71
%r73 = zext i64 %r72 to i704
%r74 = shl i704 %r73, 640
%r75 = or i704 %r69, %r74
%r76 = zext i704 %r75 to i768
%r78 = getelementptr i64, i64* %r2, i32 11
%r79 = load i64, i64* %r78
%r80 = zext i64 %r79 to i768
%r81 = shl i768 %r80, 704
%r82 = or i768 %r76, %r81
%r83 = zext i768 %r82 to i832
%r85 = getelementptr i64, i64* %r2, i32 12
%r86 = load i64, i64* %r85
%r87 = zext i64 %r86 to i832
%r88 = shl i832 %r87, 768
%r89 = or i832 %r83, %r88
%r90 = zext i832 %r89 to i896
%r92 = getelementptr i64, i64* %r2, i32 13
%r93 = load i64, i64* %r92
%r94 = zext i64 %r93 to i896
%r95 = shl i896 %r94, 832
%r96 = or i896 %r90, %r95
%r97 = load i64, i64* %r3
%r98 = zext i64 %r97 to i128
%r100 = getelementptr i64, i64* %r3, i32 1
%r101 = load i64, i64* %r100
%r102 = zext i64 %r101 to i128
%r103 = shl i128 %r102, 64
%r104 = or i128 %r98, %r103
%r105 = zext i128 %r104 to i192
%r107 = getelementptr i64, i64* %r3, i32 2
%r108 = load i64, i64* %r107
%r109 = zext i64 %r108 to i192
%r110 = shl i192 %r109, 128
%r111 = or i192 %r105, %r110
%r112 = zext i192 %r111 to i256
%r114 = getelementptr i64, i64* %r3, i32 3
%r115 = load i64, i64* %r114
%r116 = zext i64 %r115 to i256
%r117 = shl i256 %r116, 192
%r118 = or i256 %r112, %r117
%r119 = zext i256 %r118 to i320
%r121 = getelementptr i64, i64* %r3, i32 4
%r122 = load i64, i64* %r121
%r123 = zext i64 %r122 to i320
%r124 = shl i320 %r123, 256
%r125 = or i320 %r119, %r124
%r126 = zext i320 %r125 to i384
%r128 = getelementptr i64, i64* %r3, i32 5
%r129 = load i64, i64* %r128
%r130 = zext i64 %r129 to i384
%r131 = shl i384 %r130, 320
%r132 = or i384 %r126, %r131
%r133 = zext i384 %r132 to i448
%r135 = getelementptr i64, i64* %r3, i32 6
%r136 = load i64, i64* %r135
%r137 = zext i64 %r136 to i448
%r138 = shl i448 %r137, 384
%r139 = or i448 %r133, %r138
%r140 = zext i448 %r139 to i512
%r142 = getelementptr i64, i64* %r3, i32 7
%r143 = load i64, i64* %r142
%r144 = zext i64 %r143 to i512
%r145 = shl i512 %r144, 448
%r146 = or i512 %r140, %r145
%r147 = zext i512 %r146 to i576
%r149 = getelementptr i64, i64* %r3, i32 8
%r150 = load i64, i64* %r149
%r151 = zext i64 %r150 to i576
%r152 = shl i576 %r151, 512
%r153 = or i576 %r147, %r152
%r154 = zext i576 %r153 to i640
%r156 = getelementptr i64, i64* %r3, i32 9
%r157 = load i64, i64* %r156
%r158 = zext i64 %r157 to i640
%r159 = shl i640 %r158, 576
%r160 = or i640 %r154, %r159
%r161 = zext i640 %r160 to i704
%r163 = getelementptr i64, i64* %r3, i32 10
%r164 = load i64, i64* %r163
%r165 = zext i64 %r164 to i704
%r166 = shl i704 %r165, 640
%r167 = or i704 %r161, %r166
%r168 = zext i704 %r167 to i768
%r170 = getelementptr i64, i64* %r3, i32 11
%r171 = load i64, i64* %r170
%r172 = zext i64 %r171 to i768
%r173 = shl i768 %r172, 704
%r174 = or i768 %r168, %r173
%r175 = zext i768 %r174 to i832
%r177 = getelementptr i64, i64* %r3, i32 12
%r178 = load i64, i64* %r177
%r179 = zext i64 %r178 to i832
%r180 = shl i832 %r179, 768
%r181 = or i832 %r175, %r180
%r182 = zext i832 %r181 to i896
%r184 = getelementptr i64, i64* %r3, i32 13
%r185 = load i64, i64* %r184
%r186 = zext i64 %r185 to i896
%r187 = shl i896 %r186, 832
%r188 = or i896 %r182, %r187
%r189 = zext i896 %r96 to i960
%r190 = zext i896 %r188 to i960
%r191 = sub i960 %r189, %r190
%r192 = trunc i960 %r191 to i448
%r193 = trunc i448 %r192 to i64
%r195 = getelementptr i64, i64* %r1, i32 0
store i64 %r193, i64* %r195
%r196 = lshr i448 %r192, 64
%r197 = trunc i448 %r196 to i64
%r199 = getelementptr i64, i64* %r1, i32 1
store i64 %r197, i64* %r199
%r200 = lshr i448 %r196, 64
%r201 = trunc i448 %r200 to i64
%r203 = getelementptr i64, i64* %r1, i32 2
store i64 %r201, i64* %r203
%r204 = lshr i448 %r200, 64
%r205 = trunc i448 %r204 to i64
%r207 = getelementptr i64, i64* %r1, i32 3
store i64 %r205, i64* %r207
%r208 = lshr i448 %r204, 64
%r209 = trunc i448 %r208 to i64
%r211 = getelementptr i64, i64* %r1, i32 4
store i64 %r209, i64* %r211
%r212 = lshr i448 %r208, 64
%r213 = trunc i448 %r212 to i64
%r215 = getelementptr i64, i64* %r1, i32 5
store i64 %r213, i64* %r215
%r216 = lshr i448 %r212, 64
%r217 = trunc i448 %r216 to i64
%r219 = getelementptr i64, i64* %r1, i32 6
store i64 %r217, i64* %r219
%r220 = lshr i960 %r191, 448
%r221 = trunc i960 %r220 to i448
%r222 = lshr i960 %r191, 896
%r223 = trunc i960 %r222 to i1
%r224 = load i64, i64* %r4
%r225 = zext i64 %r224 to i128
%r227 = getelementptr i64, i64* %r4, i32 1
%r228 = load i64, i64* %r227
%r229 = zext i64 %r228 to i128
%r230 = shl i128 %r229, 64
%r231 = or i128 %r225, %r230
%r232 = zext i128 %r231 to i192
%r234 = getelementptr i64, i64* %r4, i32 2
%r235 = load i64, i64* %r234
%r236 = zext i64 %r235 to i192
%r237 = shl i192 %r236, 128
%r238 = or i192 %r232, %r237
%r239 = zext i192 %r238 to i256
%r241 = getelementptr i64, i64* %r4, i32 3
%r242 = load i64, i64* %r241
%r243 = zext i64 %r242 to i256
%r244 = shl i256 %r243, 192
%r245 = or i256 %r239, %r244
%r246 = zext i256 %r245 to i320
%r248 = getelementptr i64, i64* %r4, i32 4
%r249 = load i64, i64* %r248
%r250 = zext i64 %r249 to i320
%r251 = shl i320 %r250, 256
%r252 = or i320 %r246, %r251
%r253 = zext i320 %r252 to i384
%r255 = getelementptr i64, i64* %r4, i32 5
%r256 = load i64, i64* %r255
%r257 = zext i64 %r256 to i384
%r258 = shl i384 %r257, 320
%r259 = or i384 %r253, %r258
%r260 = zext i384 %r259 to i448
%r262 = getelementptr i64, i64* %r4, i32 6
%r263 = load i64, i64* %r262
%r264 = zext i64 %r263 to i448
%r265 = shl i448 %r264, 384
%r266 = or i448 %r260, %r265
%r268 = select i1 %r223, i448 %r266, i448 0
%r269 = add i448 %r221, %r268
%r271 = getelementptr i64, i64* %r1, i32 7
%r272 = trunc i448 %r269 to i64
%r274 = getelementptr i64, i64* %r271, i32 0
store i64 %r272, i64* %r274
%r275 = lshr i448 %r269, 64
%r276 = trunc i448 %r275 to i64
%r278 = getelementptr i64, i64* %r271, i32 1
store i64 %r276, i64* %r278
%r279 = lshr i448 %r275, 64
%r280 = trunc i448 %r279 to i64
%r282 = getelementptr i64, i64* %r271, i32 2
store i64 %r280, i64* %r282
%r283 = lshr i448 %r279, 64
%r284 = trunc i448 %r283 to i64
%r286 = getelementptr i64, i64* %r271, i32 3
store i64 %r284, i64* %r286
%r287 = lshr i448 %r283, 64
%r288 = trunc i448 %r287 to i64
%r290 = getelementptr i64, i64* %r271, i32 4
store i64 %r288, i64* %r290
%r291 = lshr i448 %r287, 64
%r292 = trunc i448 %r291 to i64
%r294 = getelementptr i64, i64* %r271, i32 5
store i64 %r292, i64* %r294
%r295 = lshr i448 %r291, 64
%r296 = trunc i448 %r295 to i64
%r298 = getelementptr i64, i64* %r271, i32 6
store i64 %r296, i64* %r298
ret void
}
define i576 @mulPv512x64(i64* noalias  %r2, i64 %r3)
{
%r5 = call i128 @mulPos64x64(i64* %r2, i64 %r3, i64 0)
%r6 = trunc i128 %r5 to i64
%r7 = call i64 @extractHigh64(i128 %r5)
%r9 = call i128 @mulPos64x64(i64* %r2, i64 %r3, i64 1)
%r10 = trunc i128 %r9 to i64
%r11 = call i64 @extractHigh64(i128 %r9)
%r13 = call i128 @mulPos64x64(i64* %r2, i64 %r3, i64 2)
%r14 = trunc i128 %r13 to i64
%r15 = call i64 @extractHigh64(i128 %r13)
%r17 = call i128 @mulPos64x64(i64* %r2, i64 %r3, i64 3)
%r18 = trunc i128 %r17 to i64
%r19 = call i64 @extractHigh64(i128 %r17)
%r21 = call i128 @mulPos64x64(i64* %r2, i64 %r3, i64 4)
%r22 = trunc i128 %r21 to i64
%r23 = call i64 @extractHigh64(i128 %r21)
%r25 = call i128 @mulPos64x64(i64* %r2, i64 %r3, i64 5)
%r26 = trunc i128 %r25 to i64
%r27 = call i64 @extractHigh64(i128 %r25)
%r29 = call i128 @mulPos64x64(i64* %r2, i64 %r3, i64 6)
%r30 = trunc i128 %r29 to i64
%r31 = call i64 @extractHigh64(i128 %r29)
%r33 = call i128 @mulPos64x64(i64* %r2, i64 %r3, i64 7)
%r34 = trunc i128 %r33 to i64
%r35 = call i64 @extractHigh64(i128 %r33)
%r36 = zext i64 %r6 to i128
%r37 = zext i64 %r10 to i128
%r38 = shl i128 %r37, 64
%r39 = or i128 %r36, %r38
%r40 = zext i128 %r39 to i192
%r41 = zext i64 %r14 to i192
%r42 = shl i192 %r41, 128
%r43 = or i192 %r40, %r42
%r44 = zext i192 %r43 to i256
%r45 = zext i64 %r18 to i256
%r46 = shl i256 %r45, 192
%r47 = or i256 %r44, %r46
%r48 = zext i256 %r47 to i320
%r49 = zext i64 %r22 to i320
%r50 = shl i320 %r49, 256
%r51 = or i320 %r48, %r50
%r52 = zext i320 %r51 to i384
%r53 = zext i64 %r26 to i384
%r54 = shl i384 %r53, 320
%r55 = or i384 %r52, %r54
%r56 = zext i384 %r55 to i448
%r57 = zext i64 %r30 to i448
%r58 = shl i448 %r57, 384
%r59 = or i448 %r56, %r58
%r60 = zext i448 %r59 to i512
%r61 = zext i64 %r34 to i512
%r62 = shl i512 %r61, 448
%r63 = or i512 %r60, %r62
%r64 = zext i64 %r7 to i128
%r65 = zext i64 %r11 to i128
%r66 = shl i128 %r65, 64
%r67 = or i128 %r64, %r66
%r68 = zext i128 %r67 to i192
%r69 = zext i64 %r15 to i192
%r70 = shl i192 %r69, 128
%r71 = or i192 %r68, %r70
%r72 = zext i192 %r71 to i256
%r73 = zext i64 %r19 to i256
%r74 = shl i256 %r73, 192
%r75 = or i256 %r72, %r74
%r76 = zext i256 %r75 to i320
%r77 = zext i64 %r23 to i320
%r78 = shl i320 %r77, 256
%r79 = or i320 %r76, %r78
%r80 = zext i320 %r79 to i384
%r81 = zext i64 %r27 to i384
%r82 = shl i384 %r81, 320
%r83 = or i384 %r80, %r82
%r84 = zext i384 %r83 to i448
%r85 = zext i64 %r31 to i448
%r86 = shl i448 %r85, 384
%r87 = or i448 %r84, %r86
%r88 = zext i448 %r87 to i512
%r89 = zext i64 %r35 to i512
%r90 = shl i512 %r89, 448
%r91 = or i512 %r88, %r90
%r92 = zext i512 %r63 to i576
%r93 = zext i512 %r91 to i576
%r94 = shl i576 %r93, 64
%r95 = add i576 %r92, %r94
ret i576 %r95
}
define void @mcl_fp_mulUnitPre8L(i64* noalias  %r1, i64* noalias  %r2, i64 %r3)
{
%r4 = call i576 @mulPv512x64(i64* %r2, i64 %r3)
%r5 = trunc i576 %r4 to i64
%r7 = getelementptr i64, i64* %r1, i32 0
store i64 %r5, i64* %r7
%r8 = lshr i576 %r4, 64
%r9 = trunc i576 %r8 to i64
%r11 = getelementptr i64, i64* %r1, i32 1
store i64 %r9, i64* %r11
%r12 = lshr i576 %r8, 64
%r13 = trunc i576 %r12 to i64
%r15 = getelementptr i64, i64* %r1, i32 2
store i64 %r13, i64* %r15
%r16 = lshr i576 %r12, 64
%r17 = trunc i576 %r16 to i64
%r19 = getelementptr i64, i64* %r1, i32 3
store i64 %r17, i64* %r19
%r20 = lshr i576 %r16, 64
%r21 = trunc i576 %r20 to i64
%r23 = getelementptr i64, i64* %r1, i32 4
store i64 %r21, i64* %r23
%r24 = lshr i576 %r20, 64
%r25 = trunc i576 %r24 to i64
%r27 = getelementptr i64, i64* %r1, i32 5
store i64 %r25, i64* %r27
%r28 = lshr i576 %r24, 64
%r29 = trunc i576 %r28 to i64
%r31 = getelementptr i64, i64* %r1, i32 6
store i64 %r29, i64* %r31
%r32 = lshr i576 %r28, 64
%r33 = trunc i576 %r32 to i64
%r35 = getelementptr i64, i64* %r1, i32 7
store i64 %r33, i64* %r35
%r36 = lshr i576 %r32, 64
%r37 = trunc i576 %r36 to i64
%r39 = getelementptr i64, i64* %r1, i32 8
store i64 %r37, i64* %r39
ret void
}
define void @mcl_fpDbl_mulPre8L(i64* noalias  %r1, i64* noalias  %r2, i64* noalias  %r3)
{
%r5 = getelementptr i64, i64* %r2, i32 4
%r7 = getelementptr i64, i64* %r3, i32 4
%r9 = getelementptr i64, i64* %r1, i32 8
call void @mcl_fpDbl_mulPre4L(i64* %r1, i64* %r2, i64* %r3)
call void @mcl_fpDbl_mulPre4L(i64* %r9, i64* %r5, i64* %r7)
%r10 = load i64, i64* %r5
%r11 = zext i64 %r10 to i128
%r13 = getelementptr i64, i64* %r5, i32 1
%r14 = load i64, i64* %r13
%r15 = zext i64 %r14 to i128
%r16 = shl i128 %r15, 64
%r17 = or i128 %r11, %r16
%r18 = zext i128 %r17 to i192
%r20 = getelementptr i64, i64* %r5, i32 2
%r21 = load i64, i64* %r20
%r22 = zext i64 %r21 to i192
%r23 = shl i192 %r22, 128
%r24 = or i192 %r18, %r23
%r25 = zext i192 %r24 to i256
%r27 = getelementptr i64, i64* %r5, i32 3
%r28 = load i64, i64* %r27
%r29 = zext i64 %r28 to i256
%r30 = shl i256 %r29, 192
%r31 = or i256 %r25, %r30
%r32 = zext i256 %r31 to i320
%r33 = load i64, i64* %r2
%r34 = zext i64 %r33 to i128
%r36 = getelementptr i64, i64* %r2, i32 1
%r37 = load i64, i64* %r36
%r38 = zext i64 %r37 to i128
%r39 = shl i128 %r38, 64
%r40 = or i128 %r34, %r39
%r41 = zext i128 %r40 to i192
%r43 = getelementptr i64, i64* %r2, i32 2
%r44 = load i64, i64* %r43
%r45 = zext i64 %r44 to i192
%r46 = shl i192 %r45, 128
%r47 = or i192 %r41, %r46
%r48 = zext i192 %r47 to i256
%r50 = getelementptr i64, i64* %r2, i32 3
%r51 = load i64, i64* %r50
%r52 = zext i64 %r51 to i256
%r53 = shl i256 %r52, 192
%r54 = or i256 %r48, %r53
%r55 = zext i256 %r54 to i320
%r56 = load i64, i64* %r7
%r57 = zext i64 %r56 to i128
%r59 = getelementptr i64, i64* %r7, i32 1
%r60 = load i64, i64* %r59
%r61 = zext i64 %r60 to i128
%r62 = shl i128 %r61, 64
%r63 = or i128 %r57, %r62
%r64 = zext i128 %r63 to i192
%r66 = getelementptr i64, i64* %r7, i32 2
%r67 = load i64, i64* %r66
%r68 = zext i64 %r67 to i192
%r69 = shl i192 %r68, 128
%r70 = or i192 %r64, %r69
%r71 = zext i192 %r70 to i256
%r73 = getelementptr i64, i64* %r7, i32 3
%r74 = load i64, i64* %r73
%r75 = zext i64 %r74 to i256
%r76 = shl i256 %r75, 192
%r77 = or i256 %r71, %r76
%r78 = zext i256 %r77 to i320
%r79 = load i64, i64* %r3
%r80 = zext i64 %r79 to i128
%r82 = getelementptr i64, i64* %r3, i32 1
%r83 = load i64, i64* %r82
%r84 = zext i64 %r83 to i128
%r85 = shl i128 %r84, 64
%r86 = or i128 %r80, %r85
%r87 = zext i128 %r86 to i192
%r89 = getelementptr i64, i64* %r3, i32 2
%r90 = load i64, i64* %r89
%r91 = zext i64 %r90 to i192
%r92 = shl i192 %r91, 128
%r93 = or i192 %r87, %r92
%r94 = zext i192 %r93 to i256
%r96 = getelementptr i64, i64* %r3, i32 3
%r97 = load i64, i64* %r96
%r98 = zext i64 %r97 to i256
%r99 = shl i256 %r98, 192
%r100 = or i256 %r94, %r99
%r101 = zext i256 %r100 to i320
%r102 = add i320 %r32, %r55
%r103 = add i320 %r78, %r101
%r105 = alloca i64, i32 8
%r106 = trunc i320 %r102 to i256
%r107 = trunc i320 %r103 to i256
%r108 = lshr i320 %r102, 256
%r109 = trunc i320 %r108 to i1
%r110 = lshr i320 %r103, 256
%r111 = trunc i320 %r110 to i1
%r112 = and i1 %r109, %r111
%r114 = select i1 %r109, i256 %r107, i256 0
%r116 = select i1 %r111, i256 %r106, i256 0
%r118 = alloca i64, i32 4
%r120 = alloca i64, i32 4
%r121 = trunc i256 %r106 to i64
%r123 = getelementptr i64, i64* %r118, i32 0
store i64 %r121, i64* %r123
%r124 = lshr i256 %r106, 64
%r125 = trunc i256 %r124 to i64
%r127 = getelementptr i64, i64* %r118, i32 1
store i64 %r125, i64* %r127
%r128 = lshr i256 %r124, 64
%r129 = trunc i256 %r128 to i64
%r131 = getelementptr i64, i64* %r118, i32 2
store i64 %r129, i64* %r131
%r132 = lshr i256 %r128, 64
%r133 = trunc i256 %r132 to i64
%r135 = getelementptr i64, i64* %r118, i32 3
store i64 %r133, i64* %r135
%r136 = trunc i256 %r107 to i64
%r138 = getelementptr i64, i64* %r120, i32 0
store i64 %r136, i64* %r138
%r139 = lshr i256 %r107, 64
%r140 = trunc i256 %r139 to i64
%r142 = getelementptr i64, i64* %r120, i32 1
store i64 %r140, i64* %r142
%r143 = lshr i256 %r139, 64
%r144 = trunc i256 %r143 to i64
%r146 = getelementptr i64, i64* %r120, i32 2
store i64 %r144, i64* %r146
%r147 = lshr i256 %r143, 64
%r148 = trunc i256 %r147 to i64
%r150 = getelementptr i64, i64* %r120, i32 3
store i64 %r148, i64* %r150
call void @mcl_fpDbl_mulPre4L(i64* %r105, i64* %r118, i64* %r120)
%r151 = load i64, i64* %r105
%r152 = zext i64 %r151 to i128
%r154 = getelementptr i64, i64* %r105, i32 1
%r155 = load i64, i64* %r154
%r156 = zext i64 %r155 to i128
%r157 = shl i128 %r156, 64
%r158 = or i128 %r152, %r157
%r159 = zext i128 %r158 to i192
%r161 = getelementptr i64, i64* %r105, i32 2
%r162 = load i64, i64* %r161
%r163 = zext i64 %r162 to i192
%r164 = shl i192 %r163, 128
%r165 = or i192 %r159, %r164
%r166 = zext i192 %r165 to i256
%r168 = getelementptr i64, i64* %r105, i32 3
%r169 = load i64, i64* %r168
%r170 = zext i64 %r169 to i256
%r171 = shl i256 %r170, 192
%r172 = or i256 %r166, %r171
%r173 = zext i256 %r172 to i320
%r175 = getelementptr i64, i64* %r105, i32 4
%r176 = load i64, i64* %r175
%r177 = zext i64 %r176 to i320
%r178 = shl i320 %r177, 256
%r179 = or i320 %r173, %r178
%r180 = zext i320 %r179 to i384
%r182 = getelementptr i64, i64* %r105, i32 5
%r183 = load i64, i64* %r182
%r184 = zext i64 %r183 to i384
%r185 = shl i384 %r184, 320
%r186 = or i384 %r180, %r185
%r187 = zext i384 %r186 to i448
%r189 = getelementptr i64, i64* %r105, i32 6
%r190 = load i64, i64* %r189
%r191 = zext i64 %r190 to i448
%r192 = shl i448 %r191, 384
%r193 = or i448 %r187, %r192
%r194 = zext i448 %r193 to i512
%r196 = getelementptr i64, i64* %r105, i32 7
%r197 = load i64, i64* %r196
%r198 = zext i64 %r197 to i512
%r199 = shl i512 %r198, 448
%r200 = or i512 %r194, %r199
%r201 = zext i512 %r200 to i576
%r202 = zext i1 %r112 to i576
%r203 = shl i576 %r202, 512
%r204 = or i576 %r201, %r203
%r205 = zext i256 %r114 to i576
%r206 = zext i256 %r116 to i576
%r207 = shl i576 %r205, 256
%r208 = shl i576 %r206, 256
%r209 = add i576 %r204, %r207
%r210 = add i576 %r209, %r208
%r211 = load i64, i64* %r1
%r212 = zext i64 %r211 to i128
%r214 = getelementptr i64, i64* %r1, i32 1
%r215 = load i64, i64* %r214
%r216 = zext i64 %r215 to i128
%r217 = shl i128 %r216, 64
%r218 = or i128 %r212, %r217
%r219 = zext i128 %r218 to i192
%r221 = getelementptr i64, i64* %r1, i32 2
%r222 = load i64, i64* %r221
%r223 = zext i64 %r222 to i192
%r224 = shl i192 %r223, 128
%r225 = or i192 %r219, %r224
%r226 = zext i192 %r225 to i256
%r228 = getelementptr i64, i64* %r1, i32 3
%r229 = load i64, i64* %r228
%r230 = zext i64 %r229 to i256
%r231 = shl i256 %r230, 192
%r232 = or i256 %r226, %r231
%r233 = zext i256 %r232 to i320
%r235 = getelementptr i64, i64* %r1, i32 4
%r236 = load i64, i64* %r235
%r237 = zext i64 %r236 to i320
%r238 = shl i320 %r237, 256
%r239 = or i320 %r233, %r238
%r240 = zext i320 %r239 to i384
%r242 = getelementptr i64, i64* %r1, i32 5
%r243 = load i64, i64* %r242
%r244 = zext i64 %r243 to i384
%r245 = shl i384 %r244, 320
%r246 = or i384 %r240, %r245
%r247 = zext i384 %r246 to i448
%r249 = getelementptr i64, i64* %r1, i32 6
%r250 = load i64, i64* %r249
%r251 = zext i64 %r250 to i448
%r252 = shl i448 %r251, 384
%r253 = or i448 %r247, %r252
%r254 = zext i448 %r253 to i512
%r256 = getelementptr i64, i64* %r1, i32 7
%r257 = load i64, i64* %r256
%r258 = zext i64 %r257 to i512
%r259 = shl i512 %r258, 448
%r260 = or i512 %r254, %r259
%r261 = zext i512 %r260 to i576
%r262 = sub i576 %r210, %r261
%r264 = getelementptr i64, i64* %r1, i32 8
%r265 = load i64, i64* %r264
%r266 = zext i64 %r265 to i128
%r268 = getelementptr i64, i64* %r264, i32 1
%r269 = load i64, i64* %r268
%r270 = zext i64 %r269 to i128
%r271 = shl i128 %r270, 64
%r272 = or i128 %r266, %r271
%r273 = zext i128 %r272 to i192
%r275 = getelementptr i64, i64* %r264, i32 2
%r276 = load i64, i64* %r275
%r277 = zext i64 %r276 to i192
%r278 = shl i192 %r277, 128
%r279 = or i192 %r273, %r278
%r280 = zext i192 %r279 to i256
%r282 = getelementptr i64, i64* %r264, i32 3
%r283 = load i64, i64* %r282
%r284 = zext i64 %r283 to i256
%r285 = shl i256 %r284, 192
%r286 = or i256 %r280, %r285
%r287 = zext i256 %r286 to i320
%r289 = getelementptr i64, i64* %r264, i32 4
%r290 = load i64, i64* %r289
%r291 = zext i64 %r290 to i320
%r292 = shl i320 %r291, 256
%r293 = or i320 %r287, %r292
%r294 = zext i320 %r293 to i384
%r296 = getelementptr i64, i64* %r264, i32 5
%r297 = load i64, i64* %r296
%r298 = zext i64 %r297 to i384
%r299 = shl i384 %r298, 320
%r300 = or i384 %r294, %r299
%r301 = zext i384 %r300 to i448
%r303 = getelementptr i64, i64* %r264, i32 6
%r304 = load i64, i64* %r303
%r305 = zext i64 %r304 to i448
%r306 = shl i448 %r305, 384
%r307 = or i448 %r301, %r306
%r308 = zext i448 %r307 to i512
%r310 = getelementptr i64, i64* %r264, i32 7
%r311 = load i64, i64* %r310
%r312 = zext i64 %r311 to i512
%r313 = shl i512 %r312, 448
%r314 = or i512 %r308, %r313
%r315 = zext i512 %r314 to i576
%r316 = sub i576 %r262, %r315
%r317 = zext i576 %r316 to i768
%r319 = getelementptr i64, i64* %r1, i32 4
%r320 = load i64, i64* %r319
%r321 = zext i64 %r320 to i128
%r323 = getelementptr i64, i64* %r319, i32 1
%r324 = load i64, i64* %r323
%r325 = zext i64 %r324 to i128
%r326 = shl i128 %r325, 64
%r327 = or i128 %r321, %r326
%r328 = zext i128 %r327 to i192
%r330 = getelementptr i64, i64* %r319, i32 2
%r331 = load i64, i64* %r330
%r332 = zext i64 %r331 to i192
%r333 = shl i192 %r332, 128
%r334 = or i192 %r328, %r333
%r335 = zext i192 %r334 to i256
%r337 = getelementptr i64, i64* %r319, i32 3
%r338 = load i64, i64* %r337
%r339 = zext i64 %r338 to i256
%r340 = shl i256 %r339, 192
%r341 = or i256 %r335, %r340
%r342 = zext i256 %r341 to i320
%r344 = getelementptr i64, i64* %r319, i32 4
%r345 = load i64, i64* %r344
%r346 = zext i64 %r345 to i320
%r347 = shl i320 %r346, 256
%r348 = or i320 %r342, %r347
%r349 = zext i320 %r348 to i384
%r351 = getelementptr i64, i64* %r319, i32 5
%r352 = load i64, i64* %r351
%r353 = zext i64 %r352 to i384
%r354 = shl i384 %r353, 320
%r355 = or i384 %r349, %r354
%r356 = zext i384 %r355 to i448
%r358 = getelementptr i64, i64* %r319, i32 6
%r359 = load i64, i64* %r358
%r360 = zext i64 %r359 to i448
%r361 = shl i448 %r360, 384
%r362 = or i448 %r356, %r361
%r363 = zext i448 %r362 to i512
%r365 = getelementptr i64, i64* %r319, i32 7
%r366 = load i64, i64* %r365
%r367 = zext i64 %r366 to i512
%r368 = shl i512 %r367, 448
%r369 = or i512 %r363, %r368
%r370 = zext i512 %r369 to i576
%r372 = getelementptr i64, i64* %r319, i32 8
%r373 = load i64, i64* %r372
%r374 = zext i64 %r373 to i576
%r375 = shl i576 %r374, 512
%r376 = or i576 %r370, %r375
%r377 = zext i576 %r376 to i640
%r379 = getelementptr i64, i64* %r319, i32 9
%r380 = load i64, i64* %r379
%r381 = zext i64 %r380 to i640
%r382 = shl i640 %r381, 576
%r383 = or i640 %r377, %r382
%r384 = zext i640 %r383 to i704
%r386 = getelementptr i64, i64* %r319, i32 10
%r387 = load i64, i64* %r386
%r388 = zext i64 %r387 to i704
%r389 = shl i704 %r388, 640
%r390 = or i704 %r384, %r389
%r391 = zext i704 %r390 to i768
%r393 = getelementptr i64, i64* %r319, i32 11
%r394 = load i64, i64* %r393
%r395 = zext i64 %r394 to i768
%r396 = shl i768 %r395, 704
%r397 = or i768 %r391, %r396
%r398 = add i768 %r317, %r397
%r400 = getelementptr i64, i64* %r1, i32 4
%r401 = trunc i768 %r398 to i64
%r403 = getelementptr i64, i64* %r400, i32 0
store i64 %r401, i64* %r403
%r404 = lshr i768 %r398, 64
%r405 = trunc i768 %r404 to i64
%r407 = getelementptr i64, i64* %r400, i32 1
store i64 %r405, i64* %r407
%r408 = lshr i768 %r404, 64
%r409 = trunc i768 %r408 to i64
%r411 = getelementptr i64, i64* %r400, i32 2
store i64 %r409, i64* %r411
%r412 = lshr i768 %r408, 64
%r413 = trunc i768 %r412 to i64
%r415 = getelementptr i64, i64* %r400, i32 3
store i64 %r413, i64* %r415
%r416 = lshr i768 %r412, 64
%r417 = trunc i768 %r416 to i64
%r419 = getelementptr i64, i64* %r400, i32 4
store i64 %r417, i64* %r419
%r420 = lshr i768 %r416, 64
%r421 = trunc i768 %r420 to i64
%r423 = getelementptr i64, i64* %r400, i32 5
store i64 %r421, i64* %r423
%r424 = lshr i768 %r420, 64
%r425 = trunc i768 %r424 to i64
%r427 = getelementptr i64, i64* %r400, i32 6
store i64 %r425, i64* %r427
%r428 = lshr i768 %r424, 64
%r429 = trunc i768 %r428 to i64
%r431 = getelementptr i64, i64* %r400, i32 7
store i64 %r429, i64* %r431
%r432 = lshr i768 %r428, 64
%r433 = trunc i768 %r432 to i64
%r435 = getelementptr i64, i64* %r400, i32 8
store i64 %r433, i64* %r435
%r436 = lshr i768 %r432, 64
%r437 = trunc i768 %r436 to i64
%r439 = getelementptr i64, i64* %r400, i32 9
store i64 %r437, i64* %r439
%r440 = lshr i768 %r436, 64
%r441 = trunc i768 %r440 to i64
%r443 = getelementptr i64, i64* %r400, i32 10
store i64 %r441, i64* %r443
%r444 = lshr i768 %r440, 64
%r445 = trunc i768 %r444 to i64
%r447 = getelementptr i64, i64* %r400, i32 11
store i64 %r445, i64* %r447
ret void
}
define void @mcl_fpDbl_sqrPre8L(i64* noalias  %r1, i64* noalias  %r2)
{
%r4 = getelementptr i64, i64* %r2, i32 4
%r6 = getelementptr i64, i64* %r2, i32 4
%r8 = getelementptr i64, i64* %r1, i32 8
call void @mcl_fpDbl_mulPre4L(i64* %r1, i64* %r2, i64* %r2)
call void @mcl_fpDbl_mulPre4L(i64* %r8, i64* %r4, i64* %r6)
%r9 = load i64, i64* %r4
%r10 = zext i64 %r9 to i128
%r12 = getelementptr i64, i64* %r4, i32 1
%r13 = load i64, i64* %r12
%r14 = zext i64 %r13 to i128
%r15 = shl i128 %r14, 64
%r16 = or i128 %r10, %r15
%r17 = zext i128 %r16 to i192
%r19 = getelementptr i64, i64* %r4, i32 2
%r20 = load i64, i64* %r19
%r21 = zext i64 %r20 to i192
%r22 = shl i192 %r21, 128
%r23 = or i192 %r17, %r22
%r24 = zext i192 %r23 to i256
%r26 = getelementptr i64, i64* %r4, i32 3
%r27 = load i64, i64* %r26
%r28 = zext i64 %r27 to i256
%r29 = shl i256 %r28, 192
%r30 = or i256 %r24, %r29
%r31 = zext i256 %r30 to i320
%r32 = load i64, i64* %r2
%r33 = zext i64 %r32 to i128
%r35 = getelementptr i64, i64* %r2, i32 1
%r36 = load i64, i64* %r35
%r37 = zext i64 %r36 to i128
%r38 = shl i128 %r37, 64
%r39 = or i128 %r33, %r38
%r40 = zext i128 %r39 to i192
%r42 = getelementptr i64, i64* %r2, i32 2
%r43 = load i64, i64* %r42
%r44 = zext i64 %r43 to i192
%r45 = shl i192 %r44, 128
%r46 = or i192 %r40, %r45
%r47 = zext i192 %r46 to i256
%r49 = getelementptr i64, i64* %r2, i32 3
%r50 = load i64, i64* %r49
%r51 = zext i64 %r50 to i256
%r52 = shl i256 %r51, 192
%r53 = or i256 %r47, %r52
%r54 = zext i256 %r53 to i320
%r55 = load i64, i64* %r6
%r56 = zext i64 %r55 to i128
%r58 = getelementptr i64, i64* %r6, i32 1
%r59 = load i64, i64* %r58
%r60 = zext i64 %r59 to i128
%r61 = shl i128 %r60, 64
%r62 = or i128 %r56, %r61
%r63 = zext i128 %r62 to i192
%r65 = getelementptr i64, i64* %r6, i32 2
%r66 = load i64, i64* %r65
%r67 = zext i64 %r66 to i192
%r68 = shl i192 %r67, 128
%r69 = or i192 %r63, %r68
%r70 = zext i192 %r69 to i256
%r72 = getelementptr i64, i64* %r6, i32 3
%r73 = load i64, i64* %r72
%r74 = zext i64 %r73 to i256
%r75 = shl i256 %r74, 192
%r76 = or i256 %r70, %r75
%r77 = zext i256 %r76 to i320
%r78 = load i64, i64* %r2
%r79 = zext i64 %r78 to i128
%r81 = getelementptr i64, i64* %r2, i32 1
%r82 = load i64, i64* %r81
%r83 = zext i64 %r82 to i128
%r84 = shl i128 %r83, 64
%r85 = or i128 %r79, %r84
%r86 = zext i128 %r85 to i192
%r88 = getelementptr i64, i64* %r2, i32 2
%r89 = load i64, i64* %r88
%r90 = zext i64 %r89 to i192
%r91 = shl i192 %r90, 128
%r92 = or i192 %r86, %r91
%r93 = zext i192 %r92 to i256
%r95 = getelementptr i64, i64* %r2, i32 3
%r96 = load i64, i64* %r95
%r97 = zext i64 %r96 to i256
%r98 = shl i256 %r97, 192
%r99 = or i256 %r93, %r98
%r100 = zext i256 %r99 to i320
%r101 = add i320 %r31, %r54
%r102 = add i320 %r77, %r100
%r104 = alloca i64, i32 8
%r105 = trunc i320 %r101 to i256
%r106 = trunc i320 %r102 to i256
%r107 = lshr i320 %r101, 256
%r108 = trunc i320 %r107 to i1
%r109 = lshr i320 %r102, 256
%r110 = trunc i320 %r109 to i1
%r111 = and i1 %r108, %r110
%r113 = select i1 %r108, i256 %r106, i256 0
%r115 = select i1 %r110, i256 %r105, i256 0
%r117 = alloca i64, i32 4
%r119 = alloca i64, i32 4
%r120 = trunc i256 %r105 to i64
%r122 = getelementptr i64, i64* %r117, i32 0
store i64 %r120, i64* %r122
%r123 = lshr i256 %r105, 64
%r124 = trunc i256 %r123 to i64
%r126 = getelementptr i64, i64* %r117, i32 1
store i64 %r124, i64* %r126
%r127 = lshr i256 %r123, 64
%r128 = trunc i256 %r127 to i64
%r130 = getelementptr i64, i64* %r117, i32 2
store i64 %r128, i64* %r130
%r131 = lshr i256 %r127, 64
%r132 = trunc i256 %r131 to i64
%r134 = getelementptr i64, i64* %r117, i32 3
store i64 %r132, i64* %r134
%r135 = trunc i256 %r106 to i64
%r137 = getelementptr i64, i64* %r119, i32 0
store i64 %r135, i64* %r137
%r138 = lshr i256 %r106, 64
%r139 = trunc i256 %r138 to i64
%r141 = getelementptr i64, i64* %r119, i32 1
store i64 %r139, i64* %r141
%r142 = lshr i256 %r138, 64
%r143 = trunc i256 %r142 to i64
%r145 = getelementptr i64, i64* %r119, i32 2
store i64 %r143, i64* %r145
%r146 = lshr i256 %r142, 64
%r147 = trunc i256 %r146 to i64
%r149 = getelementptr i64, i64* %r119, i32 3
store i64 %r147, i64* %r149
call void @mcl_fpDbl_mulPre4L(i64* %r104, i64* %r117, i64* %r119)
%r150 = load i64, i64* %r104
%r151 = zext i64 %r150 to i128
%r153 = getelementptr i64, i64* %r104, i32 1
%r154 = load i64, i64* %r153
%r155 = zext i64 %r154 to i128
%r156 = shl i128 %r155, 64
%r157 = or i128 %r151, %r156
%r158 = zext i128 %r157 to i192
%r160 = getelementptr i64, i64* %r104, i32 2
%r161 = load i64, i64* %r160
%r162 = zext i64 %r161 to i192
%r163 = shl i192 %r162, 128
%r164 = or i192 %r158, %r163
%r165 = zext i192 %r164 to i256
%r167 = getelementptr i64, i64* %r104, i32 3
%r168 = load i64, i64* %r167
%r169 = zext i64 %r168 to i256
%r170 = shl i256 %r169, 192
%r171 = or i256 %r165, %r170
%r172 = zext i256 %r171 to i320
%r174 = getelementptr i64, i64* %r104, i32 4
%r175 = load i64, i64* %r174
%r176 = zext i64 %r175 to i320
%r177 = shl i320 %r176, 256
%r178 = or i320 %r172, %r177
%r179 = zext i320 %r178 to i384
%r181 = getelementptr i64, i64* %r104, i32 5
%r182 = load i64, i64* %r181
%r183 = zext i64 %r182 to i384
%r184 = shl i384 %r183, 320
%r185 = or i384 %r179, %r184
%r186 = zext i384 %r185 to i448
%r188 = getelementptr i64, i64* %r104, i32 6
%r189 = load i64, i64* %r188
%r190 = zext i64 %r189 to i448
%r191 = shl i448 %r190, 384
%r192 = or i448 %r186, %r191
%r193 = zext i448 %r192 to i512
%r195 = getelementptr i64, i64* %r104, i32 7
%r196 = load i64, i64* %r195
%r197 = zext i64 %r196 to i512
%r198 = shl i512 %r197, 448
%r199 = or i512 %r193, %r198
%r200 = zext i512 %r199 to i576
%r201 = zext i1 %r111 to i576
%r202 = shl i576 %r201, 512
%r203 = or i576 %r200, %r202
%r204 = zext i256 %r113 to i576
%r205 = zext i256 %r115 to i576
%r206 = shl i576 %r204, 256
%r207 = shl i576 %r205, 256
%r208 = add i576 %r203, %r206
%r209 = add i576 %r208, %r207
%r210 = load i64, i64* %r1
%r211 = zext i64 %r210 to i128
%r213 = getelementptr i64, i64* %r1, i32 1
%r214 = load i64, i64* %r213
%r215 = zext i64 %r214 to i128
%r216 = shl i128 %r215, 64
%r217 = or i128 %r211, %r216
%r218 = zext i128 %r217 to i192
%r220 = getelementptr i64, i64* %r1, i32 2
%r221 = load i64, i64* %r220
%r222 = zext i64 %r221 to i192
%r223 = shl i192 %r222, 128
%r224 = or i192 %r218, %r223
%r225 = zext i192 %r224 to i256
%r227 = getelementptr i64, i64* %r1, i32 3
%r228 = load i64, i64* %r227
%r229 = zext i64 %r228 to i256
%r230 = shl i256 %r229, 192
%r231 = or i256 %r225, %r230
%r232 = zext i256 %r231 to i320
%r234 = getelementptr i64, i64* %r1, i32 4
%r235 = load i64, i64* %r234
%r236 = zext i64 %r235 to i320
%r237 = shl i320 %r236, 256
%r238 = or i320 %r232, %r237
%r239 = zext i320 %r238 to i384
%r241 = getelementptr i64, i64* %r1, i32 5
%r242 = load i64, i64* %r241
%r243 = zext i64 %r242 to i384
%r244 = shl i384 %r243, 320
%r245 = or i384 %r239, %r244
%r246 = zext i384 %r245 to i448
%r248 = getelementptr i64, i64* %r1, i32 6
%r249 = load i64, i64* %r248
%r250 = zext i64 %r249 to i448
%r251 = shl i448 %r250, 384
%r252 = or i448 %r246, %r251
%r253 = zext i448 %r252 to i512
%r255 = getelementptr i64, i64* %r1, i32 7
%r256 = load i64, i64* %r255
%r257 = zext i64 %r256 to i512
%r258 = shl i512 %r257, 448
%r259 = or i512 %r253, %r258
%r260 = zext i512 %r259 to i576
%r261 = sub i576 %r209, %r260
%r263 = getelementptr i64, i64* %r1, i32 8
%r264 = load i64, i64* %r263
%r265 = zext i64 %r264 to i128
%r267 = getelementptr i64, i64* %r263, i32 1
%r268 = load i64, i64* %r267
%r269 = zext i64 %r268 to i128
%r270 = shl i128 %r269, 64
%r271 = or i128 %r265, %r270
%r272 = zext i128 %r271 to i192
%r274 = getelementptr i64, i64* %r263, i32 2
%r275 = load i64, i64* %r274
%r276 = zext i64 %r275 to i192
%r277 = shl i192 %r276, 128
%r278 = or i192 %r272, %r277
%r279 = zext i192 %r278 to i256
%r281 = getelementptr i64, i64* %r263, i32 3
%r282 = load i64, i64* %r281
%r283 = zext i64 %r282 to i256
%r284 = shl i256 %r283, 192
%r285 = or i256 %r279, %r284
%r286 = zext i256 %r285 to i320
%r288 = getelementptr i64, i64* %r263, i32 4
%r289 = load i64, i64* %r288
%r290 = zext i64 %r289 to i320
%r291 = shl i320 %r290, 256
%r292 = or i320 %r286, %r291
%r293 = zext i320 %r292 to i384
%r295 = getelementptr i64, i64* %r263, i32 5
%r296 = load i64, i64* %r295
%r297 = zext i64 %r296 to i384
%r298 = shl i384 %r297, 320
%r299 = or i384 %r293, %r298
%r300 = zext i384 %r299 to i448
%r302 = getelementptr i64, i64* %r263, i32 6
%r303 = load i64, i64* %r302
%r304 = zext i64 %r303 to i448
%r305 = shl i448 %r304, 384
%r306 = or i448 %r300, %r305
%r307 = zext i448 %r306 to i512
%r309 = getelementptr i64, i64* %r263, i32 7
%r310 = load i64, i64* %r309
%r311 = zext i64 %r310 to i512
%r312 = shl i512 %r311, 448
%r313 = or i512 %r307, %r312
%r314 = zext i512 %r313 to i576
%r315 = sub i576 %r261, %r314
%r316 = zext i576 %r315 to i768
%r318 = getelementptr i64, i64* %r1, i32 4
%r319 = load i64, i64* %r318
%r320 = zext i64 %r319 to i128
%r322 = getelementptr i64, i64* %r318, i32 1
%r323 = load i64, i64* %r322
%r324 = zext i64 %r323 to i128
%r325 = shl i128 %r324, 64
%r326 = or i128 %r320, %r325
%r327 = zext i128 %r326 to i192
%r329 = getelementptr i64, i64* %r318, i32 2
%r330 = load i64, i64* %r329
%r331 = zext i64 %r330 to i192
%r332 = shl i192 %r331, 128
%r333 = or i192 %r327, %r332
%r334 = zext i192 %r333 to i256
%r336 = getelementptr i64, i64* %r318, i32 3
%r337 = load i64, i64* %r336
%r338 = zext i64 %r337 to i256
%r339 = shl i256 %r338, 192
%r340 = or i256 %r334, %r339
%r341 = zext i256 %r340 to i320
%r343 = getelementptr i64, i64* %r318, i32 4
%r344 = load i64, i64* %r343
%r345 = zext i64 %r344 to i320
%r346 = shl i320 %r345, 256
%r347 = or i320 %r341, %r346
%r348 = zext i320 %r347 to i384
%r350 = getelementptr i64, i64* %r318, i32 5
%r351 = load i64, i64* %r350
%r352 = zext i64 %r351 to i384
%r353 = shl i384 %r352, 320
%r354 = or i384 %r348, %r353
%r355 = zext i384 %r354 to i448
%r357 = getelementptr i64, i64* %r318, i32 6
%r358 = load i64, i64* %r357
%r359 = zext i64 %r358 to i448
%r360 = shl i448 %r359, 384
%r361 = or i448 %r355, %r360
%r362 = zext i448 %r361 to i512
%r364 = getelementptr i64, i64* %r318, i32 7
%r365 = load i64, i64* %r364
%r366 = zext i64 %r365 to i512
%r367 = shl i512 %r366, 448
%r368 = or i512 %r362, %r367
%r369 = zext i512 %r368 to i576
%r371 = getelementptr i64, i64* %r318, i32 8
%r372 = load i64, i64* %r371
%r373 = zext i64 %r372 to i576
%r374 = shl i576 %r373, 512
%r375 = or i576 %r369, %r374
%r376 = zext i576 %r375 to i640
%r378 = getelementptr i64, i64* %r318, i32 9
%r379 = load i64, i64* %r378
%r380 = zext i64 %r379 to i640
%r381 = shl i640 %r380, 576
%r382 = or i640 %r376, %r381
%r383 = zext i640 %r382 to i704
%r385 = getelementptr i64, i64* %r318, i32 10
%r386 = load i64, i64* %r385
%r387 = zext i64 %r386 to i704
%r388 = shl i704 %r387, 640
%r389 = or i704 %r383, %r388
%r390 = zext i704 %r389 to i768
%r392 = getelementptr i64, i64* %r318, i32 11
%r393 = load i64, i64* %r392
%r394 = zext i64 %r393 to i768
%r395 = shl i768 %r394, 704
%r396 = or i768 %r390, %r395
%r397 = add i768 %r316, %r396
%r399 = getelementptr i64, i64* %r1, i32 4
%r400 = trunc i768 %r397 to i64
%r402 = getelementptr i64, i64* %r399, i32 0
store i64 %r400, i64* %r402
%r403 = lshr i768 %r397, 64
%r404 = trunc i768 %r403 to i64
%r406 = getelementptr i64, i64* %r399, i32 1
store i64 %r404, i64* %r406
%r407 = lshr i768 %r403, 64
%r408 = trunc i768 %r407 to i64
%r410 = getelementptr i64, i64* %r399, i32 2
store i64 %r408, i64* %r410
%r411 = lshr i768 %r407, 64
%r412 = trunc i768 %r411 to i64
%r414 = getelementptr i64, i64* %r399, i32 3
store i64 %r412, i64* %r414
%r415 = lshr i768 %r411, 64
%r416 = trunc i768 %r415 to i64
%r418 = getelementptr i64, i64* %r399, i32 4
store i64 %r416, i64* %r418
%r419 = lshr i768 %r415, 64
%r420 = trunc i768 %r419 to i64
%r422 = getelementptr i64, i64* %r399, i32 5
store i64 %r420, i64* %r422
%r423 = lshr i768 %r419, 64
%r424 = trunc i768 %r423 to i64
%r426 = getelementptr i64, i64* %r399, i32 6
store i64 %r424, i64* %r426
%r427 = lshr i768 %r423, 64
%r428 = trunc i768 %r427 to i64
%r430 = getelementptr i64, i64* %r399, i32 7
store i64 %r428, i64* %r430
%r431 = lshr i768 %r427, 64
%r432 = trunc i768 %r431 to i64
%r434 = getelementptr i64, i64* %r399, i32 8
store i64 %r432, i64* %r434
%r435 = lshr i768 %r431, 64
%r436 = trunc i768 %r435 to i64
%r438 = getelementptr i64, i64* %r399, i32 9
store i64 %r436, i64* %r438
%r439 = lshr i768 %r435, 64
%r440 = trunc i768 %r439 to i64
%r442 = getelementptr i64, i64* %r399, i32 10
store i64 %r440, i64* %r442
%r443 = lshr i768 %r439, 64
%r444 = trunc i768 %r443 to i64
%r446 = getelementptr i64, i64* %r399, i32 11
store i64 %r444, i64* %r446
ret void
}
define void @mcl_fp_mont8L(i64* %r1, i64* %r2, i64* %r3, i64* %r4)
{
%r6 = getelementptr i64, i64* %r4, i32 -1
%r7 = load i64, i64* %r6
%r9 = getelementptr i64, i64* %r3, i32 0
%r10 = load i64, i64* %r9
%r11 = call i576 @mulPv512x64(i64* %r2, i64 %r10)
%r12 = zext i576 %r11 to i640
%r13 = trunc i576 %r11 to i64
%r14 = mul i64 %r13, %r7
%r15 = call i576 @mulPv512x64(i64* %r4, i64 %r14)
%r16 = zext i576 %r15 to i640
%r17 = add i640 %r12, %r16
%r18 = lshr i640 %r17, 64
%r20 = getelementptr i64, i64* %r3, i32 1
%r21 = load i64, i64* %r20
%r22 = call i576 @mulPv512x64(i64* %r2, i64 %r21)
%r23 = zext i576 %r22 to i640
%r24 = add i640 %r18, %r23
%r25 = trunc i640 %r24 to i64
%r26 = mul i64 %r25, %r7
%r27 = call i576 @mulPv512x64(i64* %r4, i64 %r26)
%r28 = zext i576 %r27 to i640
%r29 = add i640 %r24, %r28
%r30 = lshr i640 %r29, 64
%r32 = getelementptr i64, i64* %r3, i32 2
%r33 = load i64, i64* %r32
%r34 = call i576 @mulPv512x64(i64* %r2, i64 %r33)
%r35 = zext i576 %r34 to i640
%r36 = add i640 %r30, %r35
%r37 = trunc i640 %r36 to i64
%r38 = mul i64 %r37, %r7
%r39 = call i576 @mulPv512x64(i64* %r4, i64 %r38)
%r40 = zext i576 %r39 to i640
%r41 = add i640 %r36, %r40
%r42 = lshr i640 %r41, 64
%r44 = getelementptr i64, i64* %r3, i32 3
%r45 = load i64, i64* %r44
%r46 = call i576 @mulPv512x64(i64* %r2, i64 %r45)
%r47 = zext i576 %r46 to i640
%r48 = add i640 %r42, %r47
%r49 = trunc i640 %r48 to i64
%r50 = mul i64 %r49, %r7
%r51 = call i576 @mulPv512x64(i64* %r4, i64 %r50)
%r52 = zext i576 %r51 to i640
%r53 = add i640 %r48, %r52
%r54 = lshr i640 %r53, 64
%r56 = getelementptr i64, i64* %r3, i32 4
%r57 = load i64, i64* %r56
%r58 = call i576 @mulPv512x64(i64* %r2, i64 %r57)
%r59 = zext i576 %r58 to i640
%r60 = add i640 %r54, %r59
%r61 = trunc i640 %r60 to i64
%r62 = mul i64 %r61, %r7
%r63 = call i576 @mulPv512x64(i64* %r4, i64 %r62)
%r64 = zext i576 %r63 to i640
%r65 = add i640 %r60, %r64
%r66 = lshr i640 %r65, 64
%r68 = getelementptr i64, i64* %r3, i32 5
%r69 = load i64, i64* %r68
%r70 = call i576 @mulPv512x64(i64* %r2, i64 %r69)
%r71 = zext i576 %r70 to i640
%r72 = add i640 %r66, %r71
%r73 = trunc i640 %r72 to i64
%r74 = mul i64 %r73, %r7
%r75 = call i576 @mulPv512x64(i64* %r4, i64 %r74)
%r76 = zext i576 %r75 to i640
%r77 = add i640 %r72, %r76
%r78 = lshr i640 %r77, 64
%r80 = getelementptr i64, i64* %r3, i32 6
%r81 = load i64, i64* %r80
%r82 = call i576 @mulPv512x64(i64* %r2, i64 %r81)
%r83 = zext i576 %r82 to i640
%r84 = add i640 %r78, %r83
%r85 = trunc i640 %r84 to i64
%r86 = mul i64 %r85, %r7
%r87 = call i576 @mulPv512x64(i64* %r4, i64 %r86)
%r88 = zext i576 %r87 to i640
%r89 = add i640 %r84, %r88
%r90 = lshr i640 %r89, 64
%r92 = getelementptr i64, i64* %r3, i32 7
%r93 = load i64, i64* %r92
%r94 = call i576 @mulPv512x64(i64* %r2, i64 %r93)
%r95 = zext i576 %r94 to i640
%r96 = add i640 %r90, %r95
%r97 = trunc i640 %r96 to i64
%r98 = mul i64 %r97, %r7
%r99 = call i576 @mulPv512x64(i64* %r4, i64 %r98)
%r100 = zext i576 %r99 to i640
%r101 = add i640 %r96, %r100
%r102 = lshr i640 %r101, 64
%r103 = trunc i640 %r102 to i576
%r104 = load i64, i64* %r4
%r105 = zext i64 %r104 to i128
%r107 = getelementptr i64, i64* %r4, i32 1
%r108 = load i64, i64* %r107
%r109 = zext i64 %r108 to i128
%r110 = shl i128 %r109, 64
%r111 = or i128 %r105, %r110
%r112 = zext i128 %r111 to i192
%r114 = getelementptr i64, i64* %r4, i32 2
%r115 = load i64, i64* %r114
%r116 = zext i64 %r115 to i192
%r117 = shl i192 %r116, 128
%r118 = or i192 %r112, %r117
%r119 = zext i192 %r118 to i256
%r121 = getelementptr i64, i64* %r4, i32 3
%r122 = load i64, i64* %r121
%r123 = zext i64 %r122 to i256
%r124 = shl i256 %r123, 192
%r125 = or i256 %r119, %r124
%r126 = zext i256 %r125 to i320
%r128 = getelementptr i64, i64* %r4, i32 4
%r129 = load i64, i64* %r128
%r130 = zext i64 %r129 to i320
%r131 = shl i320 %r130, 256
%r132 = or i320 %r126, %r131
%r133 = zext i320 %r132 to i384
%r135 = getelementptr i64, i64* %r4, i32 5
%r136 = load i64, i64* %r135
%r137 = zext i64 %r136 to i384
%r138 = shl i384 %r137, 320
%r139 = or i384 %r133, %r138
%r140 = zext i384 %r139 to i448
%r142 = getelementptr i64, i64* %r4, i32 6
%r143 = load i64, i64* %r142
%r144 = zext i64 %r143 to i448
%r145 = shl i448 %r144, 384
%r146 = or i448 %r140, %r145
%r147 = zext i448 %r146 to i512
%r149 = getelementptr i64, i64* %r4, i32 7
%r150 = load i64, i64* %r149
%r151 = zext i64 %r150 to i512
%r152 = shl i512 %r151, 448
%r153 = or i512 %r147, %r152
%r154 = zext i512 %r153 to i576
%r155 = sub i576 %r103, %r154
%r156 = lshr i576 %r155, 512
%r157 = trunc i576 %r156 to i1
%r158 = select i1 %r157, i576 %r103, i576 %r155
%r159 = trunc i576 %r158 to i512
%r160 = trunc i512 %r159 to i64
%r162 = getelementptr i64, i64* %r1, i32 0
store i64 %r160, i64* %r162
%r163 = lshr i512 %r159, 64
%r164 = trunc i512 %r163 to i64
%r166 = getelementptr i64, i64* %r1, i32 1
store i64 %r164, i64* %r166
%r167 = lshr i512 %r163, 64
%r168 = trunc i512 %r167 to i64
%r170 = getelementptr i64, i64* %r1, i32 2
store i64 %r168, i64* %r170
%r171 = lshr i512 %r167, 64
%r172 = trunc i512 %r171 to i64
%r174 = getelementptr i64, i64* %r1, i32 3
store i64 %r172, i64* %r174
%r175 = lshr i512 %r171, 64
%r176 = trunc i512 %r175 to i64
%r178 = getelementptr i64, i64* %r1, i32 4
store i64 %r176, i64* %r178
%r179 = lshr i512 %r175, 64
%r180 = trunc i512 %r179 to i64
%r182 = getelementptr i64, i64* %r1, i32 5
store i64 %r180, i64* %r182
%r183 = lshr i512 %r179, 64
%r184 = trunc i512 %r183 to i64
%r186 = getelementptr i64, i64* %r1, i32 6
store i64 %r184, i64* %r186
%r187 = lshr i512 %r183, 64
%r188 = trunc i512 %r187 to i64
%r190 = getelementptr i64, i64* %r1, i32 7
store i64 %r188, i64* %r190
ret void
}
define void @mcl_fp_montNF8L(i64* %r1, i64* %r2, i64* %r3, i64* %r4)
{
%r6 = getelementptr i64, i64* %r4, i32 -1
%r7 = load i64, i64* %r6
%r8 = load i64, i64* %r3
%r9 = call i576 @mulPv512x64(i64* %r2, i64 %r8)
%r10 = trunc i576 %r9 to i64
%r11 = mul i64 %r10, %r7
%r12 = call i576 @mulPv512x64(i64* %r4, i64 %r11)
%r13 = add i576 %r9, %r12
%r14 = lshr i576 %r13, 64
%r16 = getelementptr i64, i64* %r3, i32 1
%r17 = load i64, i64* %r16
%r18 = call i576 @mulPv512x64(i64* %r2, i64 %r17)
%r19 = add i576 %r14, %r18
%r20 = trunc i576 %r19 to i64
%r21 = mul i64 %r20, %r7
%r22 = call i576 @mulPv512x64(i64* %r4, i64 %r21)
%r23 = add i576 %r19, %r22
%r24 = lshr i576 %r23, 64
%r26 = getelementptr i64, i64* %r3, i32 2
%r27 = load i64, i64* %r26
%r28 = call i576 @mulPv512x64(i64* %r2, i64 %r27)
%r29 = add i576 %r24, %r28
%r30 = trunc i576 %r29 to i64
%r31 = mul i64 %r30, %r7
%r32 = call i576 @mulPv512x64(i64* %r4, i64 %r31)
%r33 = add i576 %r29, %r32
%r34 = lshr i576 %r33, 64
%r36 = getelementptr i64, i64* %r3, i32 3
%r37 = load i64, i64* %r36
%r38 = call i576 @mulPv512x64(i64* %r2, i64 %r37)
%r39 = add i576 %r34, %r38
%r40 = trunc i576 %r39 to i64
%r41 = mul i64 %r40, %r7
%r42 = call i576 @mulPv512x64(i64* %r4, i64 %r41)
%r43 = add i576 %r39, %r42
%r44 = lshr i576 %r43, 64
%r46 = getelementptr i64, i64* %r3, i32 4
%r47 = load i64, i64* %r46
%r48 = call i576 @mulPv512x64(i64* %r2, i64 %r47)
%r49 = add i576 %r44, %r48
%r50 = trunc i576 %r49 to i64
%r51 = mul i64 %r50, %r7
%r52 = call i576 @mulPv512x64(i64* %r4, i64 %r51)
%r53 = add i576 %r49, %r52
%r54 = lshr i576 %r53, 64
%r56 = getelementptr i64, i64* %r3, i32 5
%r57 = load i64, i64* %r56
%r58 = call i576 @mulPv512x64(i64* %r2, i64 %r57)
%r59 = add i576 %r54, %r58
%r60 = trunc i576 %r59 to i64
%r61 = mul i64 %r60, %r7
%r62 = call i576 @mulPv512x64(i64* %r4, i64 %r61)
%r63 = add i576 %r59, %r62
%r64 = lshr i576 %r63, 64
%r66 = getelementptr i64, i64* %r3, i32 6
%r67 = load i64, i64* %r66
%r68 = call i576 @mulPv512x64(i64* %r2, i64 %r67)
%r69 = add i576 %r64, %r68
%r70 = trunc i576 %r69 to i64
%r71 = mul i64 %r70, %r7
%r72 = call i576 @mulPv512x64(i64* %r4, i64 %r71)
%r73 = add i576 %r69, %r72
%r74 = lshr i576 %r73, 64
%r76 = getelementptr i64, i64* %r3, i32 7
%r77 = load i64, i64* %r76
%r78 = call i576 @mulPv512x64(i64* %r2, i64 %r77)
%r79 = add i576 %r74, %r78
%r80 = trunc i576 %r79 to i64
%r81 = mul i64 %r80, %r7
%r82 = call i576 @mulPv512x64(i64* %r4, i64 %r81)
%r83 = add i576 %r79, %r82
%r84 = lshr i576 %r83, 64
%r85 = trunc i576 %r84 to i512
%r86 = load i64, i64* %r4
%r87 = zext i64 %r86 to i128
%r89 = getelementptr i64, i64* %r4, i32 1
%r90 = load i64, i64* %r89
%r91 = zext i64 %r90 to i128
%r92 = shl i128 %r91, 64
%r93 = or i128 %r87, %r92
%r94 = zext i128 %r93 to i192
%r96 = getelementptr i64, i64* %r4, i32 2
%r97 = load i64, i64* %r96
%r98 = zext i64 %r97 to i192
%r99 = shl i192 %r98, 128
%r100 = or i192 %r94, %r99
%r101 = zext i192 %r100 to i256
%r103 = getelementptr i64, i64* %r4, i32 3
%r104 = load i64, i64* %r103
%r105 = zext i64 %r104 to i256
%r106 = shl i256 %r105, 192
%r107 = or i256 %r101, %r106
%r108 = zext i256 %r107 to i320
%r110 = getelementptr i64, i64* %r4, i32 4
%r111 = load i64, i64* %r110
%r112 = zext i64 %r111 to i320
%r113 = shl i320 %r112, 256
%r114 = or i320 %r108, %r113
%r115 = zext i320 %r114 to i384
%r117 = getelementptr i64, i64* %r4, i32 5
%r118 = load i64, i64* %r117
%r119 = zext i64 %r118 to i384
%r120 = shl i384 %r119, 320
%r121 = or i384 %r115, %r120
%r122 = zext i384 %r121 to i448
%r124 = getelementptr i64, i64* %r4, i32 6
%r125 = load i64, i64* %r124
%r126 = zext i64 %r125 to i448
%r127 = shl i448 %r126, 384
%r128 = or i448 %r122, %r127
%r129 = zext i448 %r128 to i512
%r131 = getelementptr i64, i64* %r4, i32 7
%r132 = load i64, i64* %r131
%r133 = zext i64 %r132 to i512
%r134 = shl i512 %r133, 448
%r135 = or i512 %r129, %r134
%r136 = sub i512 %r85, %r135
%r137 = lshr i512 %r136, 511
%r138 = trunc i512 %r137 to i1
%r139 = select i1 %r138, i512 %r85, i512 %r136
%r140 = trunc i512 %r139 to i64
%r142 = getelementptr i64, i64* %r1, i32 0
store i64 %r140, i64* %r142
%r143 = lshr i512 %r139, 64
%r144 = trunc i512 %r143 to i64
%r146 = getelementptr i64, i64* %r1, i32 1
store i64 %r144, i64* %r146
%r147 = lshr i512 %r143, 64
%r148 = trunc i512 %r147 to i64
%r150 = getelementptr i64, i64* %r1, i32 2
store i64 %r148, i64* %r150
%r151 = lshr i512 %r147, 64
%r152 = trunc i512 %r151 to i64
%r154 = getelementptr i64, i64* %r1, i32 3
store i64 %r152, i64* %r154
%r155 = lshr i512 %r151, 64
%r156 = trunc i512 %r155 to i64
%r158 = getelementptr i64, i64* %r1, i32 4
store i64 %r156, i64* %r158
%r159 = lshr i512 %r155, 64
%r160 = trunc i512 %r159 to i64
%r162 = getelementptr i64, i64* %r1, i32 5
store i64 %r160, i64* %r162
%r163 = lshr i512 %r159, 64
%r164 = trunc i512 %r163 to i64
%r166 = getelementptr i64, i64* %r1, i32 6
store i64 %r164, i64* %r166
%r167 = lshr i512 %r163, 64
%r168 = trunc i512 %r167 to i64
%r170 = getelementptr i64, i64* %r1, i32 7
store i64 %r168, i64* %r170
ret void
}
define void @mcl_fp_montRed8L(i64* noalias  %r1, i64* noalias  %r2, i64* noalias  %r3)
{
%r5 = getelementptr i64, i64* %r3, i32 -1
%r6 = load i64, i64* %r5
%r7 = load i64, i64* %r3
%r8 = zext i64 %r7 to i128
%r10 = getelementptr i64, i64* %r3, i32 1
%r11 = load i64, i64* %r10
%r12 = zext i64 %r11 to i128
%r13 = shl i128 %r12, 64
%r14 = or i128 %r8, %r13
%r15 = zext i128 %r14 to i192
%r17 = getelementptr i64, i64* %r3, i32 2
%r18 = load i64, i64* %r17
%r19 = zext i64 %r18 to i192
%r20 = shl i192 %r19, 128
%r21 = or i192 %r15, %r20
%r22 = zext i192 %r21 to i256
%r24 = getelementptr i64, i64* %r3, i32 3
%r25 = load i64, i64* %r24
%r26 = zext i64 %r25 to i256
%r27 = shl i256 %r26, 192
%r28 = or i256 %r22, %r27
%r29 = zext i256 %r28 to i320
%r31 = getelementptr i64, i64* %r3, i32 4
%r32 = load i64, i64* %r31
%r33 = zext i64 %r32 to i320
%r34 = shl i320 %r33, 256
%r35 = or i320 %r29, %r34
%r36 = zext i320 %r35 to i384
%r38 = getelementptr i64, i64* %r3, i32 5
%r39 = load i64, i64* %r38
%r40 = zext i64 %r39 to i384
%r41 = shl i384 %r40, 320
%r42 = or i384 %r36, %r41
%r43 = zext i384 %r42 to i448
%r45 = getelementptr i64, i64* %r3, i32 6
%r46 = load i64, i64* %r45
%r47 = zext i64 %r46 to i448
%r48 = shl i448 %r47, 384
%r49 = or i448 %r43, %r48
%r50 = zext i448 %r49 to i512
%r52 = getelementptr i64, i64* %r3, i32 7
%r53 = load i64, i64* %r52
%r54 = zext i64 %r53 to i512
%r55 = shl i512 %r54, 448
%r56 = or i512 %r50, %r55
%r57 = load i64, i64* %r2
%r58 = zext i64 %r57 to i128
%r60 = getelementptr i64, i64* %r2, i32 1
%r61 = load i64, i64* %r60
%r62 = zext i64 %r61 to i128
%r63 = shl i128 %r62, 64
%r64 = or i128 %r58, %r63
%r65 = zext i128 %r64 to i192
%r67 = getelementptr i64, i64* %r2, i32 2
%r68 = load i64, i64* %r67
%r69 = zext i64 %r68 to i192
%r70 = shl i192 %r69, 128
%r71 = or i192 %r65, %r70
%r72 = zext i192 %r71 to i256
%r74 = getelementptr i64, i64* %r2, i32 3
%r75 = load i64, i64* %r74
%r76 = zext i64 %r75 to i256
%r77 = shl i256 %r76, 192
%r78 = or i256 %r72, %r77
%r79 = zext i256 %r78 to i320
%r81 = getelementptr i64, i64* %r2, i32 4
%r82 = load i64, i64* %r81
%r83 = zext i64 %r82 to i320
%r84 = shl i320 %r83, 256
%r85 = or i320 %r79, %r84
%r86 = zext i320 %r85 to i384
%r88 = getelementptr i64, i64* %r2, i32 5
%r89 = load i64, i64* %r88
%r90 = zext i64 %r89 to i384
%r91 = shl i384 %r90, 320
%r92 = or i384 %r86, %r91
%r93 = zext i384 %r92 to i448
%r95 = getelementptr i64, i64* %r2, i32 6
%r96 = load i64, i64* %r95
%r97 = zext i64 %r96 to i448
%r98 = shl i448 %r97, 384
%r99 = or i448 %r93, %r98
%r100 = zext i448 %r99 to i512
%r102 = getelementptr i64, i64* %r2, i32 7
%r103 = load i64, i64* %r102
%r104 = zext i64 %r103 to i512
%r105 = shl i512 %r104, 448
%r106 = or i512 %r100, %r105
%r107 = zext i512 %r106 to i576
%r109 = getelementptr i64, i64* %r2, i32 8
%r110 = load i64, i64* %r109
%r111 = zext i64 %r110 to i576
%r112 = shl i576 %r111, 512
%r113 = or i576 %r107, %r112
%r114 = zext i576 %r113 to i640
%r116 = getelementptr i64, i64* %r2, i32 9
%r117 = load i64, i64* %r116
%r118 = zext i64 %r117 to i640
%r119 = shl i640 %r118, 576
%r120 = or i640 %r114, %r119
%r121 = zext i640 %r120 to i704
%r123 = getelementptr i64, i64* %r2, i32 10
%r124 = load i64, i64* %r123
%r125 = zext i64 %r124 to i704
%r126 = shl i704 %r125, 640
%r127 = or i704 %r121, %r126
%r128 = zext i704 %r127 to i768
%r130 = getelementptr i64, i64* %r2, i32 11
%r131 = load i64, i64* %r130
%r132 = zext i64 %r131 to i768
%r133 = shl i768 %r132, 704
%r134 = or i768 %r128, %r133
%r135 = zext i768 %r134 to i832
%r137 = getelementptr i64, i64* %r2, i32 12
%r138 = load i64, i64* %r137
%r139 = zext i64 %r138 to i832
%r140 = shl i832 %r139, 768
%r141 = or i832 %r135, %r140
%r142 = zext i832 %r141 to i896
%r144 = getelementptr i64, i64* %r2, i32 13
%r145 = load i64, i64* %r144
%r146 = zext i64 %r145 to i896
%r147 = shl i896 %r146, 832
%r148 = or i896 %r142, %r147
%r149 = zext i896 %r148 to i960
%r151 = getelementptr i64, i64* %r2, i32 14
%r152 = load i64, i64* %r151
%r153 = zext i64 %r152 to i960
%r154 = shl i960 %r153, 896
%r155 = or i960 %r149, %r154
%r156 = zext i960 %r155 to i1024
%r158 = getelementptr i64, i64* %r2, i32 15
%r159 = load i64, i64* %r158
%r160 = zext i64 %r159 to i1024
%r161 = shl i1024 %r160, 960
%r162 = or i1024 %r156, %r161
%r163 = zext i1024 %r162 to i1088
%r164 = trunc i1088 %r163 to i64
%r165 = mul i64 %r164, %r6
%r166 = call i576 @mulPv512x64(i64* %r3, i64 %r165)
%r167 = zext i576 %r166 to i1088
%r168 = add i1088 %r163, %r167
%r169 = lshr i1088 %r168, 64
%r170 = trunc i1088 %r169 to i1024
%r171 = trunc i1024 %r170 to i64
%r172 = mul i64 %r171, %r6
%r173 = call i576 @mulPv512x64(i64* %r3, i64 %r172)
%r174 = zext i576 %r173 to i1024
%r175 = add i1024 %r170, %r174
%r176 = lshr i1024 %r175, 64
%r177 = trunc i1024 %r176 to i960
%r178 = trunc i960 %r177 to i64
%r179 = mul i64 %r178, %r6
%r180 = call i576 @mulPv512x64(i64* %r3, i64 %r179)
%r181 = zext i576 %r180 to i960
%r182 = add i960 %r177, %r181
%r183 = lshr i960 %r182, 64
%r184 = trunc i960 %r183 to i896
%r185 = trunc i896 %r184 to i64
%r186 = mul i64 %r185, %r6
%r187 = call i576 @mulPv512x64(i64* %r3, i64 %r186)
%r188 = zext i576 %r187 to i896
%r189 = add i896 %r184, %r188
%r190 = lshr i896 %r189, 64
%r191 = trunc i896 %r190 to i832
%r192 = trunc i832 %r191 to i64
%r193 = mul i64 %r192, %r6
%r194 = call i576 @mulPv512x64(i64* %r3, i64 %r193)
%r195 = zext i576 %r194 to i832
%r196 = add i832 %r191, %r195
%r197 = lshr i832 %r196, 64
%r198 = trunc i832 %r197 to i768
%r199 = trunc i768 %r198 to i64
%r200 = mul i64 %r199, %r6
%r201 = call i576 @mulPv512x64(i64* %r3, i64 %r200)
%r202 = zext i576 %r201 to i768
%r203 = add i768 %r198, %r202
%r204 = lshr i768 %r203, 64
%r205 = trunc i768 %r204 to i704
%r206 = trunc i704 %r205 to i64
%r207 = mul i64 %r206, %r6
%r208 = call i576 @mulPv512x64(i64* %r3, i64 %r207)
%r209 = zext i576 %r208 to i704
%r210 = add i704 %r205, %r209
%r211 = lshr i704 %r210, 64
%r212 = trunc i704 %r211 to i640
%r213 = trunc i640 %r212 to i64
%r214 = mul i64 %r213, %r6
%r215 = call i576 @mulPv512x64(i64* %r3, i64 %r214)
%r216 = zext i576 %r215 to i640
%r217 = add i640 %r212, %r216
%r218 = lshr i640 %r217, 64
%r219 = trunc i640 %r218 to i576
%r220 = zext i512 %r56 to i576
%r221 = sub i576 %r219, %r220
%r222 = lshr i576 %r221, 512
%r223 = trunc i576 %r222 to i1
%r224 = select i1 %r223, i576 %r219, i576 %r221
%r225 = trunc i576 %r224 to i512
%r226 = trunc i512 %r225 to i64
%r228 = getelementptr i64, i64* %r1, i32 0
store i64 %r226, i64* %r228
%r229 = lshr i512 %r225, 64
%r230 = trunc i512 %r229 to i64
%r232 = getelementptr i64, i64* %r1, i32 1
store i64 %r230, i64* %r232
%r233 = lshr i512 %r229, 64
%r234 = trunc i512 %r233 to i64
%r236 = getelementptr i64, i64* %r1, i32 2
store i64 %r234, i64* %r236
%r237 = lshr i512 %r233, 64
%r238 = trunc i512 %r237 to i64
%r240 = getelementptr i64, i64* %r1, i32 3
store i64 %r238, i64* %r240
%r241 = lshr i512 %r237, 64
%r242 = trunc i512 %r241 to i64
%r244 = getelementptr i64, i64* %r1, i32 4
store i64 %r242, i64* %r244
%r245 = lshr i512 %r241, 64
%r246 = trunc i512 %r245 to i64
%r248 = getelementptr i64, i64* %r1, i32 5
store i64 %r246, i64* %r248
%r249 = lshr i512 %r245, 64
%r250 = trunc i512 %r249 to i64
%r252 = getelementptr i64, i64* %r1, i32 6
store i64 %r250, i64* %r252
%r253 = lshr i512 %r249, 64
%r254 = trunc i512 %r253 to i64
%r256 = getelementptr i64, i64* %r1, i32 7
store i64 %r254, i64* %r256
ret void
}
define i64 @mcl_fp_addPre8L(i64* noalias  %r2, i64* noalias  %r3, i64* noalias  %r4)
{
%r5 = load i64, i64* %r3
%r6 = zext i64 %r5 to i128
%r8 = getelementptr i64, i64* %r3, i32 1
%r9 = load i64, i64* %r8
%r10 = zext i64 %r9 to i128
%r11 = shl i128 %r10, 64
%r12 = or i128 %r6, %r11
%r13 = zext i128 %r12 to i192
%r15 = getelementptr i64, i64* %r3, i32 2
%r16 = load i64, i64* %r15
%r17 = zext i64 %r16 to i192
%r18 = shl i192 %r17, 128
%r19 = or i192 %r13, %r18
%r20 = zext i192 %r19 to i256
%r22 = getelementptr i64, i64* %r3, i32 3
%r23 = load i64, i64* %r22
%r24 = zext i64 %r23 to i256
%r25 = shl i256 %r24, 192
%r26 = or i256 %r20, %r25
%r27 = zext i256 %r26 to i320
%r29 = getelementptr i64, i64* %r3, i32 4
%r30 = load i64, i64* %r29
%r31 = zext i64 %r30 to i320
%r32 = shl i320 %r31, 256
%r33 = or i320 %r27, %r32
%r34 = zext i320 %r33 to i384
%r36 = getelementptr i64, i64* %r3, i32 5
%r37 = load i64, i64* %r36
%r38 = zext i64 %r37 to i384
%r39 = shl i384 %r38, 320
%r40 = or i384 %r34, %r39
%r41 = zext i384 %r40 to i448
%r43 = getelementptr i64, i64* %r3, i32 6
%r44 = load i64, i64* %r43
%r45 = zext i64 %r44 to i448
%r46 = shl i448 %r45, 384
%r47 = or i448 %r41, %r46
%r48 = zext i448 %r47 to i512
%r50 = getelementptr i64, i64* %r3, i32 7
%r51 = load i64, i64* %r50
%r52 = zext i64 %r51 to i512
%r53 = shl i512 %r52, 448
%r54 = or i512 %r48, %r53
%r55 = zext i512 %r54 to i576
%r56 = load i64, i64* %r4
%r57 = zext i64 %r56 to i128
%r59 = getelementptr i64, i64* %r4, i32 1
%r60 = load i64, i64* %r59
%r61 = zext i64 %r60 to i128
%r62 = shl i128 %r61, 64
%r63 = or i128 %r57, %r62
%r64 = zext i128 %r63 to i192
%r66 = getelementptr i64, i64* %r4, i32 2
%r67 = load i64, i64* %r66
%r68 = zext i64 %r67 to i192
%r69 = shl i192 %r68, 128
%r70 = or i192 %r64, %r69
%r71 = zext i192 %r70 to i256
%r73 = getelementptr i64, i64* %r4, i32 3
%r74 = load i64, i64* %r73
%r75 = zext i64 %r74 to i256
%r76 = shl i256 %r75, 192
%r77 = or i256 %r71, %r76
%r78 = zext i256 %r77 to i320
%r80 = getelementptr i64, i64* %r4, i32 4
%r81 = load i64, i64* %r80
%r82 = zext i64 %r81 to i320
%r83 = shl i320 %r82, 256
%r84 = or i320 %r78, %r83
%r85 = zext i320 %r84 to i384
%r87 = getelementptr i64, i64* %r4, i32 5
%r88 = load i64, i64* %r87
%r89 = zext i64 %r88 to i384
%r90 = shl i384 %r89, 320
%r91 = or i384 %r85, %r90
%r92 = zext i384 %r91 to i448
%r94 = getelementptr i64, i64* %r4, i32 6
%r95 = load i64, i64* %r94
%r96 = zext i64 %r95 to i448
%r97 = shl i448 %r96, 384
%r98 = or i448 %r92, %r97
%r99 = zext i448 %r98 to i512
%r101 = getelementptr i64, i64* %r4, i32 7
%r102 = load i64, i64* %r101
%r103 = zext i64 %r102 to i512
%r104 = shl i512 %r103, 448
%r105 = or i512 %r99, %r104
%r106 = zext i512 %r105 to i576
%r107 = add i576 %r55, %r106
%r108 = trunc i576 %r107 to i512
%r109 = trunc i512 %r108 to i64
%r111 = getelementptr i64, i64* %r2, i32 0
store i64 %r109, i64* %r111
%r112 = lshr i512 %r108, 64
%r113 = trunc i512 %r112 to i64
%r115 = getelementptr i64, i64* %r2, i32 1
store i64 %r113, i64* %r115
%r116 = lshr i512 %r112, 64
%r117 = trunc i512 %r116 to i64
%r119 = getelementptr i64, i64* %r2, i32 2
store i64 %r117, i64* %r119
%r120 = lshr i512 %r116, 64
%r121 = trunc i512 %r120 to i64
%r123 = getelementptr i64, i64* %r2, i32 3
store i64 %r121, i64* %r123
%r124 = lshr i512 %r120, 64
%r125 = trunc i512 %r124 to i64
%r127 = getelementptr i64, i64* %r2, i32 4
store i64 %r125, i64* %r127
%r128 = lshr i512 %r124, 64
%r129 = trunc i512 %r128 to i64
%r131 = getelementptr i64, i64* %r2, i32 5
store i64 %r129, i64* %r131
%r132 = lshr i512 %r128, 64
%r133 = trunc i512 %r132 to i64
%r135 = getelementptr i64, i64* %r2, i32 6
store i64 %r133, i64* %r135
%r136 = lshr i512 %r132, 64
%r137 = trunc i512 %r136 to i64
%r139 = getelementptr i64, i64* %r2, i32 7
store i64 %r137, i64* %r139
%r140 = lshr i576 %r107, 512
%r141 = trunc i576 %r140 to i64
ret i64 %r141
}
define i64 @mcl_fp_subPre8L(i64* noalias  %r2, i64* noalias  %r3, i64* noalias  %r4)
{
%r5 = load i64, i64* %r3
%r6 = zext i64 %r5 to i128
%r8 = getelementptr i64, i64* %r3, i32 1
%r9 = load i64, i64* %r8
%r10 = zext i64 %r9 to i128
%r11 = shl i128 %r10, 64
%r12 = or i128 %r6, %r11
%r13 = zext i128 %r12 to i192
%r15 = getelementptr i64, i64* %r3, i32 2
%r16 = load i64, i64* %r15
%r17 = zext i64 %r16 to i192
%r18 = shl i192 %r17, 128
%r19 = or i192 %r13, %r18
%r20 = zext i192 %r19 to i256
%r22 = getelementptr i64, i64* %r3, i32 3
%r23 = load i64, i64* %r22
%r24 = zext i64 %r23 to i256
%r25 = shl i256 %r24, 192
%r26 = or i256 %r20, %r25
%r27 = zext i256 %r26 to i320
%r29 = getelementptr i64, i64* %r3, i32 4
%r30 = load i64, i64* %r29
%r31 = zext i64 %r30 to i320
%r32 = shl i320 %r31, 256
%r33 = or i320 %r27, %r32
%r34 = zext i320 %r33 to i384
%r36 = getelementptr i64, i64* %r3, i32 5
%r37 = load i64, i64* %r36
%r38 = zext i64 %r37 to i384
%r39 = shl i384 %r38, 320
%r40 = or i384 %r34, %r39
%r41 = zext i384 %r40 to i448
%r43 = getelementptr i64, i64* %r3, i32 6
%r44 = load i64, i64* %r43
%r45 = zext i64 %r44 to i448
%r46 = shl i448 %r45, 384
%r47 = or i448 %r41, %r46
%r48 = zext i448 %r47 to i512
%r50 = getelementptr i64, i64* %r3, i32 7
%r51 = load i64, i64* %r50
%r52 = zext i64 %r51 to i512
%r53 = shl i512 %r52, 448
%r54 = or i512 %r48, %r53
%r55 = zext i512 %r54 to i576
%r56 = load i64, i64* %r4
%r57 = zext i64 %r56 to i128
%r59 = getelementptr i64, i64* %r4, i32 1
%r60 = load i64, i64* %r59
%r61 = zext i64 %r60 to i128
%r62 = shl i128 %r61, 64
%r63 = or i128 %r57, %r62
%r64 = zext i128 %r63 to i192
%r66 = getelementptr i64, i64* %r4, i32 2
%r67 = load i64, i64* %r66
%r68 = zext i64 %r67 to i192
%r69 = shl i192 %r68, 128
%r70 = or i192 %r64, %r69
%r71 = zext i192 %r70 to i256
%r73 = getelementptr i64, i64* %r4, i32 3
%r74 = load i64, i64* %r73
%r75 = zext i64 %r74 to i256
%r76 = shl i256 %r75, 192
%r77 = or i256 %r71, %r76
%r78 = zext i256 %r77 to i320
%r80 = getelementptr i64, i64* %r4, i32 4
%r81 = load i64, i64* %r80
%r82 = zext i64 %r81 to i320
%r83 = shl i320 %r82, 256
%r84 = or i320 %r78, %r83
%r85 = zext i320 %r84 to i384
%r87 = getelementptr i64, i64* %r4, i32 5
%r88 = load i64, i64* %r87
%r89 = zext i64 %r88 to i384
%r90 = shl i384 %r89, 320
%r91 = or i384 %r85, %r90
%r92 = zext i384 %r91 to i448
%r94 = getelementptr i64, i64* %r4, i32 6
%r95 = load i64, i64* %r94
%r96 = zext i64 %r95 to i448
%r97 = shl i448 %r96, 384
%r98 = or i448 %r92, %r97
%r99 = zext i448 %r98 to i512
%r101 = getelementptr i64, i64* %r4, i32 7
%r102 = load i64, i64* %r101
%r103 = zext i64 %r102 to i512
%r104 = shl i512 %r103, 448
%r105 = or i512 %r99, %r104
%r106 = zext i512 %r105 to i576
%r107 = sub i576 %r55, %r106
%r108 = trunc i576 %r107 to i512
%r109 = trunc i512 %r108 to i64
%r111 = getelementptr i64, i64* %r2, i32 0
store i64 %r109, i64* %r111
%r112 = lshr i512 %r108, 64
%r113 = trunc i512 %r112 to i64
%r115 = getelementptr i64, i64* %r2, i32 1
store i64 %r113, i64* %r115
%r116 = lshr i512 %r112, 64
%r117 = trunc i512 %r116 to i64
%r119 = getelementptr i64, i64* %r2, i32 2
store i64 %r117, i64* %r119
%r120 = lshr i512 %r116, 64
%r121 = trunc i512 %r120 to i64
%r123 = getelementptr i64, i64* %r2, i32 3
store i64 %r121, i64* %r123
%r124 = lshr i512 %r120, 64
%r125 = trunc i512 %r124 to i64
%r127 = getelementptr i64, i64* %r2, i32 4
store i64 %r125, i64* %r127
%r128 = lshr i512 %r124, 64
%r129 = trunc i512 %r128 to i64
%r131 = getelementptr i64, i64* %r2, i32 5
store i64 %r129, i64* %r131
%r132 = lshr i512 %r128, 64
%r133 = trunc i512 %r132 to i64
%r135 = getelementptr i64, i64* %r2, i32 6
store i64 %r133, i64* %r135
%r136 = lshr i512 %r132, 64
%r137 = trunc i512 %r136 to i64
%r139 = getelementptr i64, i64* %r2, i32 7
store i64 %r137, i64* %r139
%r140 = lshr i576 %r107, 512
%r141 = trunc i576 %r140 to i64
%r143 = and i64 %r141, 1
ret i64 %r143
}
define void @mcl_fp_shr1_8L(i64* noalias  %r1, i64* noalias  %r2)
{
%r3 = load i64, i64* %r2
%r4 = zext i64 %r3 to i128
%r6 = getelementptr i64, i64* %r2, i32 1
%r7 = load i64, i64* %r6
%r8 = zext i64 %r7 to i128
%r9 = shl i128 %r8, 64
%r10 = or i128 %r4, %r9
%r11 = zext i128 %r10 to i192
%r13 = getelementptr i64, i64* %r2, i32 2
%r14 = load i64, i64* %r13
%r15 = zext i64 %r14 to i192
%r16 = shl i192 %r15, 128
%r17 = or i192 %r11, %r16
%r18 = zext i192 %r17 to i256
%r20 = getelementptr i64, i64* %r2, i32 3
%r21 = load i64, i64* %r20
%r22 = zext i64 %r21 to i256
%r23 = shl i256 %r22, 192
%r24 = or i256 %r18, %r23
%r25 = zext i256 %r24 to i320
%r27 = getelementptr i64, i64* %r2, i32 4
%r28 = load i64, i64* %r27
%r29 = zext i64 %r28 to i320
%r30 = shl i320 %r29, 256
%r31 = or i320 %r25, %r30
%r32 = zext i320 %r31 to i384
%r34 = getelementptr i64, i64* %r2, i32 5
%r35 = load i64, i64* %r34
%r36 = zext i64 %r35 to i384
%r37 = shl i384 %r36, 320
%r38 = or i384 %r32, %r37
%r39 = zext i384 %r38 to i448
%r41 = getelementptr i64, i64* %r2, i32 6
%r42 = load i64, i64* %r41
%r43 = zext i64 %r42 to i448
%r44 = shl i448 %r43, 384
%r45 = or i448 %r39, %r44
%r46 = zext i448 %r45 to i512
%r48 = getelementptr i64, i64* %r2, i32 7
%r49 = load i64, i64* %r48
%r50 = zext i64 %r49 to i512
%r51 = shl i512 %r50, 448
%r52 = or i512 %r46, %r51
%r53 = lshr i512 %r52, 1
%r54 = trunc i512 %r53 to i64
%r56 = getelementptr i64, i64* %r1, i32 0
store i64 %r54, i64* %r56
%r57 = lshr i512 %r53, 64
%r58 = trunc i512 %r57 to i64
%r60 = getelementptr i64, i64* %r1, i32 1
store i64 %r58, i64* %r60
%r61 = lshr i512 %r57, 64
%r62 = trunc i512 %r61 to i64
%r64 = getelementptr i64, i64* %r1, i32 2
store i64 %r62, i64* %r64
%r65 = lshr i512 %r61, 64
%r66 = trunc i512 %r65 to i64
%r68 = getelementptr i64, i64* %r1, i32 3
store i64 %r66, i64* %r68
%r69 = lshr i512 %r65, 64
%r70 = trunc i512 %r69 to i64
%r72 = getelementptr i64, i64* %r1, i32 4
store i64 %r70, i64* %r72
%r73 = lshr i512 %r69, 64
%r74 = trunc i512 %r73 to i64
%r76 = getelementptr i64, i64* %r1, i32 5
store i64 %r74, i64* %r76
%r77 = lshr i512 %r73, 64
%r78 = trunc i512 %r77 to i64
%r80 = getelementptr i64, i64* %r1, i32 6
store i64 %r78, i64* %r80
%r81 = lshr i512 %r77, 64
%r82 = trunc i512 %r81 to i64
%r84 = getelementptr i64, i64* %r1, i32 7
store i64 %r82, i64* %r84
ret void
}
define void @mcl_fp_add8L(i64* noalias  %r1, i64* noalias  %r2, i64* noalias  %r3, i64* noalias  %r4)
{
%r5 = load i64, i64* %r2
%r6 = zext i64 %r5 to i128
%r8 = getelementptr i64, i64* %r2, i32 1
%r9 = load i64, i64* %r8
%r10 = zext i64 %r9 to i128
%r11 = shl i128 %r10, 64
%r12 = or i128 %r6, %r11
%r13 = zext i128 %r12 to i192
%r15 = getelementptr i64, i64* %r2, i32 2
%r16 = load i64, i64* %r15
%r17 = zext i64 %r16 to i192
%r18 = shl i192 %r17, 128
%r19 = or i192 %r13, %r18
%r20 = zext i192 %r19 to i256
%r22 = getelementptr i64, i64* %r2, i32 3
%r23 = load i64, i64* %r22
%r24 = zext i64 %r23 to i256
%r25 = shl i256 %r24, 192
%r26 = or i256 %r20, %r25
%r27 = zext i256 %r26 to i320
%r29 = getelementptr i64, i64* %r2, i32 4
%r30 = load i64, i64* %r29
%r31 = zext i64 %r30 to i320
%r32 = shl i320 %r31, 256
%r33 = or i320 %r27, %r32
%r34 = zext i320 %r33 to i384
%r36 = getelementptr i64, i64* %r2, i32 5
%r37 = load i64, i64* %r36
%r38 = zext i64 %r37 to i384
%r39 = shl i384 %r38, 320
%r40 = or i384 %r34, %r39
%r41 = zext i384 %r40 to i448
%r43 = getelementptr i64, i64* %r2, i32 6
%r44 = load i64, i64* %r43
%r45 = zext i64 %r44 to i448
%r46 = shl i448 %r45, 384
%r47 = or i448 %r41, %r46
%r48 = zext i448 %r47 to i512
%r50 = getelementptr i64, i64* %r2, i32 7
%r51 = load i64, i64* %r50
%r52 = zext i64 %r51 to i512
%r53 = shl i512 %r52, 448
%r54 = or i512 %r48, %r53
%r55 = load i64, i64* %r3
%r56 = zext i64 %r55 to i128
%r58 = getelementptr i64, i64* %r3, i32 1
%r59 = load i64, i64* %r58
%r60 = zext i64 %r59 to i128
%r61 = shl i128 %r60, 64
%r62 = or i128 %r56, %r61
%r63 = zext i128 %r62 to i192
%r65 = getelementptr i64, i64* %r3, i32 2
%r66 = load i64, i64* %r65
%r67 = zext i64 %r66 to i192
%r68 = shl i192 %r67, 128
%r69 = or i192 %r63, %r68
%r70 = zext i192 %r69 to i256
%r72 = getelementptr i64, i64* %r3, i32 3
%r73 = load i64, i64* %r72
%r74 = zext i64 %r73 to i256
%r75 = shl i256 %r74, 192
%r76 = or i256 %r70, %r75
%r77 = zext i256 %r76 to i320
%r79 = getelementptr i64, i64* %r3, i32 4
%r80 = load i64, i64* %r79
%r81 = zext i64 %r80 to i320
%r82 = shl i320 %r81, 256
%r83 = or i320 %r77, %r82
%r84 = zext i320 %r83 to i384
%r86 = getelementptr i64, i64* %r3, i32 5
%r87 = load i64, i64* %r86
%r88 = zext i64 %r87 to i384
%r89 = shl i384 %r88, 320
%r90 = or i384 %r84, %r89
%r91 = zext i384 %r90 to i448
%r93 = getelementptr i64, i64* %r3, i32 6
%r94 = load i64, i64* %r93
%r95 = zext i64 %r94 to i448
%r96 = shl i448 %r95, 384
%r97 = or i448 %r91, %r96
%r98 = zext i448 %r97 to i512
%r100 = getelementptr i64, i64* %r3, i32 7
%r101 = load i64, i64* %r100
%r102 = zext i64 %r101 to i512
%r103 = shl i512 %r102, 448
%r104 = or i512 %r98, %r103
%r105 = zext i512 %r54 to i576
%r106 = zext i512 %r104 to i576
%r107 = add i576 %r105, %r106
%r108 = trunc i576 %r107 to i512
%r109 = trunc i512 %r108 to i64
%r111 = getelementptr i64, i64* %r1, i32 0
store i64 %r109, i64* %r111
%r112 = lshr i512 %r108, 64
%r113 = trunc i512 %r112 to i64
%r115 = getelementptr i64, i64* %r1, i32 1
store i64 %r113, i64* %r115
%r116 = lshr i512 %r112, 64
%r117 = trunc i512 %r116 to i64
%r119 = getelementptr i64, i64* %r1, i32 2
store i64 %r117, i64* %r119
%r120 = lshr i512 %r116, 64
%r121 = trunc i512 %r120 to i64
%r123 = getelementptr i64, i64* %r1, i32 3
store i64 %r121, i64* %r123
%r124 = lshr i512 %r120, 64
%r125 = trunc i512 %r124 to i64
%r127 = getelementptr i64, i64* %r1, i32 4
store i64 %r125, i64* %r127
%r128 = lshr i512 %r124, 64
%r129 = trunc i512 %r128 to i64
%r131 = getelementptr i64, i64* %r1, i32 5
store i64 %r129, i64* %r131
%r132 = lshr i512 %r128, 64
%r133 = trunc i512 %r132 to i64
%r135 = getelementptr i64, i64* %r1, i32 6
store i64 %r133, i64* %r135
%r136 = lshr i512 %r132, 64
%r137 = trunc i512 %r136 to i64
%r139 = getelementptr i64, i64* %r1, i32 7
store i64 %r137, i64* %r139
%r140 = load i64, i64* %r4
%r141 = zext i64 %r140 to i128
%r143 = getelementptr i64, i64* %r4, i32 1
%r144 = load i64, i64* %r143
%r145 = zext i64 %r144 to i128
%r146 = shl i128 %r145, 64
%r147 = or i128 %r141, %r146
%r148 = zext i128 %r147 to i192
%r150 = getelementptr i64, i64* %r4, i32 2
%r151 = load i64, i64* %r150
%r152 = zext i64 %r151 to i192
%r153 = shl i192 %r152, 128
%r154 = or i192 %r148, %r153
%r155 = zext i192 %r154 to i256
%r157 = getelementptr i64, i64* %r4, i32 3
%r158 = load i64, i64* %r157
%r159 = zext i64 %r158 to i256
%r160 = shl i256 %r159, 192
%r161 = or i256 %r155, %r160
%r162 = zext i256 %r161 to i320
%r164 = getelementptr i64, i64* %r4, i32 4
%r165 = load i64, i64* %r164
%r166 = zext i64 %r165 to i320
%r167 = shl i320 %r166, 256
%r168 = or i320 %r162, %r167
%r169 = zext i320 %r168 to i384
%r171 = getelementptr i64, i64* %r4, i32 5
%r172 = load i64, i64* %r171
%r173 = zext i64 %r172 to i384
%r174 = shl i384 %r173, 320
%r175 = or i384 %r169, %r174
%r176 = zext i384 %r175 to i448
%r178 = getelementptr i64, i64* %r4, i32 6
%r179 = load i64, i64* %r178
%r180 = zext i64 %r179 to i448
%r181 = shl i448 %r180, 384
%r182 = or i448 %r176, %r181
%r183 = zext i448 %r182 to i512
%r185 = getelementptr i64, i64* %r4, i32 7
%r186 = load i64, i64* %r185
%r187 = zext i64 %r186 to i512
%r188 = shl i512 %r187, 448
%r189 = or i512 %r183, %r188
%r190 = zext i512 %r189 to i576
%r191 = sub i576 %r107, %r190
%r192 = lshr i576 %r191, 512
%r193 = trunc i576 %r192 to i1
br i1%r193, label %carry, label %nocarry
nocarry:
%r194 = trunc i576 %r191 to i512
%r195 = trunc i512 %r194 to i64
%r197 = getelementptr i64, i64* %r1, i32 0
store i64 %r195, i64* %r197
%r198 = lshr i512 %r194, 64
%r199 = trunc i512 %r198 to i64
%r201 = getelementptr i64, i64* %r1, i32 1
store i64 %r199, i64* %r201
%r202 = lshr i512 %r198, 64
%r203 = trunc i512 %r202 to i64
%r205 = getelementptr i64, i64* %r1, i32 2
store i64 %r203, i64* %r205
%r206 = lshr i512 %r202, 64
%r207 = trunc i512 %r206 to i64
%r209 = getelementptr i64, i64* %r1, i32 3
store i64 %r207, i64* %r209
%r210 = lshr i512 %r206, 64
%r211 = trunc i512 %r210 to i64
%r213 = getelementptr i64, i64* %r1, i32 4
store i64 %r211, i64* %r213
%r214 = lshr i512 %r210, 64
%r215 = trunc i512 %r214 to i64
%r217 = getelementptr i64, i64* %r1, i32 5
store i64 %r215, i64* %r217
%r218 = lshr i512 %r214, 64
%r219 = trunc i512 %r218 to i64
%r221 = getelementptr i64, i64* %r1, i32 6
store i64 %r219, i64* %r221
%r222 = lshr i512 %r218, 64
%r223 = trunc i512 %r222 to i64
%r225 = getelementptr i64, i64* %r1, i32 7
store i64 %r223, i64* %r225
ret void
carry:
ret void
}
define void @mcl_fp_addNF8L(i64* noalias  %r1, i64* noalias  %r2, i64* noalias  %r3, i64* noalias  %r4)
{
%r5 = load i64, i64* %r2
%r6 = zext i64 %r5 to i128
%r8 = getelementptr i64, i64* %r2, i32 1
%r9 = load i64, i64* %r8
%r10 = zext i64 %r9 to i128
%r11 = shl i128 %r10, 64
%r12 = or i128 %r6, %r11
%r13 = zext i128 %r12 to i192
%r15 = getelementptr i64, i64* %r2, i32 2
%r16 = load i64, i64* %r15
%r17 = zext i64 %r16 to i192
%r18 = shl i192 %r17, 128
%r19 = or i192 %r13, %r18
%r20 = zext i192 %r19 to i256
%r22 = getelementptr i64, i64* %r2, i32 3
%r23 = load i64, i64* %r22
%r24 = zext i64 %r23 to i256
%r25 = shl i256 %r24, 192
%r26 = or i256 %r20, %r25
%r27 = zext i256 %r26 to i320
%r29 = getelementptr i64, i64* %r2, i32 4
%r30 = load i64, i64* %r29
%r31 = zext i64 %r30 to i320
%r32 = shl i320 %r31, 256
%r33 = or i320 %r27, %r32
%r34 = zext i320 %r33 to i384
%r36 = getelementptr i64, i64* %r2, i32 5
%r37 = load i64, i64* %r36
%r38 = zext i64 %r37 to i384
%r39 = shl i384 %r38, 320
%r40 = or i384 %r34, %r39
%r41 = zext i384 %r40 to i448
%r43 = getelementptr i64, i64* %r2, i32 6
%r44 = load i64, i64* %r43
%r45 = zext i64 %r44 to i448
%r46 = shl i448 %r45, 384
%r47 = or i448 %r41, %r46
%r48 = zext i448 %r47 to i512
%r50 = getelementptr i64, i64* %r2, i32 7
%r51 = load i64, i64* %r50
%r52 = zext i64 %r51 to i512
%r53 = shl i512 %r52, 448
%r54 = or i512 %r48, %r53
%r55 = load i64, i64* %r3
%r56 = zext i64 %r55 to i128
%r58 = getelementptr i64, i64* %r3, i32 1
%r59 = load i64, i64* %r58
%r60 = zext i64 %r59 to i128
%r61 = shl i128 %r60, 64
%r62 = or i128 %r56, %r61
%r63 = zext i128 %r62 to i192
%r65 = getelementptr i64, i64* %r3, i32 2
%r66 = load i64, i64* %r65
%r67 = zext i64 %r66 to i192
%r68 = shl i192 %r67, 128
%r69 = or i192 %r63, %r68
%r70 = zext i192 %r69 to i256
%r72 = getelementptr i64, i64* %r3, i32 3
%r73 = load i64, i64* %r72
%r74 = zext i64 %r73 to i256
%r75 = shl i256 %r74, 192
%r76 = or i256 %r70, %r75
%r77 = zext i256 %r76 to i320
%r79 = getelementptr i64, i64* %r3, i32 4
%r80 = load i64, i64* %r79
%r81 = zext i64 %r80 to i320
%r82 = shl i320 %r81, 256
%r83 = or i320 %r77, %r82
%r84 = zext i320 %r83 to i384
%r86 = getelementptr i64, i64* %r3, i32 5
%r87 = load i64, i64* %r86
%r88 = zext i64 %r87 to i384
%r89 = shl i384 %r88, 320
%r90 = or i384 %r84, %r89
%r91 = zext i384 %r90 to i448
%r93 = getelementptr i64, i64* %r3, i32 6
%r94 = load i64, i64* %r93
%r95 = zext i64 %r94 to i448
%r96 = shl i448 %r95, 384
%r97 = or i448 %r91, %r96
%r98 = zext i448 %r97 to i512
%r100 = getelementptr i64, i64* %r3, i32 7
%r101 = load i64, i64* %r100
%r102 = zext i64 %r101 to i512
%r103 = shl i512 %r102, 448
%r104 = or i512 %r98, %r103
%r105 = add i512 %r54, %r104
%r106 = load i64, i64* %r4
%r107 = zext i64 %r106 to i128
%r109 = getelementptr i64, i64* %r4, i32 1
%r110 = load i64, i64* %r109
%r111 = zext i64 %r110 to i128
%r112 = shl i128 %r111, 64
%r113 = or i128 %r107, %r112
%r114 = zext i128 %r113 to i192
%r116 = getelementptr i64, i64* %r4, i32 2
%r117 = load i64, i64* %r116
%r118 = zext i64 %r117 to i192
%r119 = shl i192 %r118, 128
%r120 = or i192 %r114, %r119
%r121 = zext i192 %r120 to i256
%r123 = getelementptr i64, i64* %r4, i32 3
%r124 = load i64, i64* %r123
%r125 = zext i64 %r124 to i256
%r126 = shl i256 %r125, 192
%r127 = or i256 %r121, %r126
%r128 = zext i256 %r127 to i320
%r130 = getelementptr i64, i64* %r4, i32 4
%r131 = load i64, i64* %r130
%r132 = zext i64 %r131 to i320
%r133 = shl i320 %r132, 256
%r134 = or i320 %r128, %r133
%r135 = zext i320 %r134 to i384
%r137 = getelementptr i64, i64* %r4, i32 5
%r138 = load i64, i64* %r137
%r139 = zext i64 %r138 to i384
%r140 = shl i384 %r139, 320
%r141 = or i384 %r135, %r140
%r142 = zext i384 %r141 to i448
%r144 = getelementptr i64, i64* %r4, i32 6
%r145 = load i64, i64* %r144
%r146 = zext i64 %r145 to i448
%r147 = shl i448 %r146, 384
%r148 = or i448 %r142, %r147
%r149 = zext i448 %r148 to i512
%r151 = getelementptr i64, i64* %r4, i32 7
%r152 = load i64, i64* %r151
%r153 = zext i64 %r152 to i512
%r154 = shl i512 %r153, 448
%r155 = or i512 %r149, %r154
%r156 = sub i512 %r105, %r155
%r157 = lshr i512 %r156, 511
%r158 = trunc i512 %r157 to i1
%r159 = select i1 %r158, i512 %r105, i512 %r156
%r160 = trunc i512 %r159 to i64
%r162 = getelementptr i64, i64* %r1, i32 0
store i64 %r160, i64* %r162
%r163 = lshr i512 %r159, 64
%r164 = trunc i512 %r163 to i64
%r166 = getelementptr i64, i64* %r1, i32 1
store i64 %r164, i64* %r166
%r167 = lshr i512 %r163, 64
%r168 = trunc i512 %r167 to i64
%r170 = getelementptr i64, i64* %r1, i32 2
store i64 %r168, i64* %r170
%r171 = lshr i512 %r167, 64
%r172 = trunc i512 %r171 to i64
%r174 = getelementptr i64, i64* %r1, i32 3
store i64 %r172, i64* %r174
%r175 = lshr i512 %r171, 64
%r176 = trunc i512 %r175 to i64
%r178 = getelementptr i64, i64* %r1, i32 4
store i64 %r176, i64* %r178
%r179 = lshr i512 %r175, 64
%r180 = trunc i512 %r179 to i64
%r182 = getelementptr i64, i64* %r1, i32 5
store i64 %r180, i64* %r182
%r183 = lshr i512 %r179, 64
%r184 = trunc i512 %r183 to i64
%r186 = getelementptr i64, i64* %r1, i32 6
store i64 %r184, i64* %r186
%r187 = lshr i512 %r183, 64
%r188 = trunc i512 %r187 to i64
%r190 = getelementptr i64, i64* %r1, i32 7
store i64 %r188, i64* %r190
ret void
}
define void @mcl_fp_sub8L(i64* noalias  %r1, i64* noalias  %r2, i64* noalias  %r3, i64* noalias  %r4)
{
%r5 = load i64, i64* %r2
%r6 = zext i64 %r5 to i128
%r8 = getelementptr i64, i64* %r2, i32 1
%r9 = load i64, i64* %r8
%r10 = zext i64 %r9 to i128
%r11 = shl i128 %r10, 64
%r12 = or i128 %r6, %r11
%r13 = zext i128 %r12 to i192
%r15 = getelementptr i64, i64* %r2, i32 2
%r16 = load i64, i64* %r15
%r17 = zext i64 %r16 to i192
%r18 = shl i192 %r17, 128
%r19 = or i192 %r13, %r18
%r20 = zext i192 %r19 to i256
%r22 = getelementptr i64, i64* %r2, i32 3
%r23 = load i64, i64* %r22
%r24 = zext i64 %r23 to i256
%r25 = shl i256 %r24, 192
%r26 = or i256 %r20, %r25
%r27 = zext i256 %r26 to i320
%r29 = getelementptr i64, i64* %r2, i32 4
%r30 = load i64, i64* %r29
%r31 = zext i64 %r30 to i320
%r32 = shl i320 %r31, 256
%r33 = or i320 %r27, %r32
%r34 = zext i320 %r33 to i384
%r36 = getelementptr i64, i64* %r2, i32 5
%r37 = load i64, i64* %r36
%r38 = zext i64 %r37 to i384
%r39 = shl i384 %r38, 320
%r40 = or i384 %r34, %r39
%r41 = zext i384 %r40 to i448
%r43 = getelementptr i64, i64* %r2, i32 6
%r44 = load i64, i64* %r43
%r45 = zext i64 %r44 to i448
%r46 = shl i448 %r45, 384
%r47 = or i448 %r41, %r46
%r48 = zext i448 %r47 to i512
%r50 = getelementptr i64, i64* %r2, i32 7
%r51 = load i64, i64* %r50
%r52 = zext i64 %r51 to i512
%r53 = shl i512 %r52, 448
%r54 = or i512 %r48, %r53
%r55 = load i64, i64* %r3
%r56 = zext i64 %r55 to i128
%r58 = getelementptr i64, i64* %r3, i32 1
%r59 = load i64, i64* %r58
%r60 = zext i64 %r59 to i128
%r61 = shl i128 %r60, 64
%r62 = or i128 %r56, %r61
%r63 = zext i128 %r62 to i192
%r65 = getelementptr i64, i64* %r3, i32 2
%r66 = load i64, i64* %r65
%r67 = zext i64 %r66 to i192
%r68 = shl i192 %r67, 128
%r69 = or i192 %r63, %r68
%r70 = zext i192 %r69 to i256
%r72 = getelementptr i64, i64* %r3, i32 3
%r73 = load i64, i64* %r72
%r74 = zext i64 %r73 to i256
%r75 = shl i256 %r74, 192
%r76 = or i256 %r70, %r75
%r77 = zext i256 %r76 to i320
%r79 = getelementptr i64, i64* %r3, i32 4
%r80 = load i64, i64* %r79
%r81 = zext i64 %r80 to i320
%r82 = shl i320 %r81, 256
%r83 = or i320 %r77, %r82
%r84 = zext i320 %r83 to i384
%r86 = getelementptr i64, i64* %r3, i32 5
%r87 = load i64, i64* %r86
%r88 = zext i64 %r87 to i384
%r89 = shl i384 %r88, 320
%r90 = or i384 %r84, %r89
%r91 = zext i384 %r90 to i448
%r93 = getelementptr i64, i64* %r3, i32 6
%r94 = load i64, i64* %r93
%r95 = zext i64 %r94 to i448
%r96 = shl i448 %r95, 384
%r97 = or i448 %r91, %r96
%r98 = zext i448 %r97 to i512
%r100 = getelementptr i64, i64* %r3, i32 7
%r101 = load i64, i64* %r100
%r102 = zext i64 %r101 to i512
%r103 = shl i512 %r102, 448
%r104 = or i512 %r98, %r103
%r105 = zext i512 %r54 to i576
%r106 = zext i512 %r104 to i576
%r107 = sub i576 %r105, %r106
%r108 = trunc i576 %r107 to i512
%r109 = lshr i576 %r107, 512
%r110 = trunc i576 %r109 to i1
%r111 = trunc i512 %r108 to i64
%r113 = getelementptr i64, i64* %r1, i32 0
store i64 %r111, i64* %r113
%r114 = lshr i512 %r108, 64
%r115 = trunc i512 %r114 to i64
%r117 = getelementptr i64, i64* %r1, i32 1
store i64 %r115, i64* %r117
%r118 = lshr i512 %r114, 64
%r119 = trunc i512 %r118 to i64
%r121 = getelementptr i64, i64* %r1, i32 2
store i64 %r119, i64* %r121
%r122 = lshr i512 %r118, 64
%r123 = trunc i512 %r122 to i64
%r125 = getelementptr i64, i64* %r1, i32 3
store i64 %r123, i64* %r125
%r126 = lshr i512 %r122, 64
%r127 = trunc i512 %r126 to i64
%r129 = getelementptr i64, i64* %r1, i32 4
store i64 %r127, i64* %r129
%r130 = lshr i512 %r126, 64
%r131 = trunc i512 %r130 to i64
%r133 = getelementptr i64, i64* %r1, i32 5
store i64 %r131, i64* %r133
%r134 = lshr i512 %r130, 64
%r135 = trunc i512 %r134 to i64
%r137 = getelementptr i64, i64* %r1, i32 6
store i64 %r135, i64* %r137
%r138 = lshr i512 %r134, 64
%r139 = trunc i512 %r138 to i64
%r141 = getelementptr i64, i64* %r1, i32 7
store i64 %r139, i64* %r141
br i1%r110, label %carry, label %nocarry
nocarry:
ret void
carry:
%r142 = load i64, i64* %r4
%r143 = zext i64 %r142 to i128
%r145 = getelementptr i64, i64* %r4, i32 1
%r146 = load i64, i64* %r145
%r147 = zext i64 %r146 to i128
%r148 = shl i128 %r147, 64
%r149 = or i128 %r143, %r148
%r150 = zext i128 %r149 to i192
%r152 = getelementptr i64, i64* %r4, i32 2
%r153 = load i64, i64* %r152
%r154 = zext i64 %r153 to i192
%r155 = shl i192 %r154, 128
%r156 = or i192 %r150, %r155
%r157 = zext i192 %r156 to i256
%r159 = getelementptr i64, i64* %r4, i32 3
%r160 = load i64, i64* %r159
%r161 = zext i64 %r160 to i256
%r162 = shl i256 %r161, 192
%r163 = or i256 %r157, %r162
%r164 = zext i256 %r163 to i320
%r166 = getelementptr i64, i64* %r4, i32 4
%r167 = load i64, i64* %r166
%r168 = zext i64 %r167 to i320
%r169 = shl i320 %r168, 256
%r170 = or i320 %r164, %r169
%r171 = zext i320 %r170 to i384
%r173 = getelementptr i64, i64* %r4, i32 5
%r174 = load i64, i64* %r173
%r175 = zext i64 %r174 to i384
%r176 = shl i384 %r175, 320
%r177 = or i384 %r171, %r176
%r178 = zext i384 %r177 to i448
%r180 = getelementptr i64, i64* %r4, i32 6
%r181 = load i64, i64* %r180
%r182 = zext i64 %r181 to i448
%r183 = shl i448 %r182, 384
%r184 = or i448 %r178, %r183
%r185 = zext i448 %r184 to i512
%r187 = getelementptr i64, i64* %r4, i32 7
%r188 = load i64, i64* %r187
%r189 = zext i64 %r188 to i512
%r190 = shl i512 %r189, 448
%r191 = or i512 %r185, %r190
%r192 = add i512 %r108, %r191
%r193 = trunc i512 %r192 to i64
%r195 = getelementptr i64, i64* %r1, i32 0
store i64 %r193, i64* %r195
%r196 = lshr i512 %r192, 64
%r197 = trunc i512 %r196 to i64
%r199 = getelementptr i64, i64* %r1, i32 1
store i64 %r197, i64* %r199
%r200 = lshr i512 %r196, 64
%r201 = trunc i512 %r200 to i64
%r203 = getelementptr i64, i64* %r1, i32 2
store i64 %r201, i64* %r203
%r204 = lshr i512 %r200, 64
%r205 = trunc i512 %r204 to i64
%r207 = getelementptr i64, i64* %r1, i32 3
store i64 %r205, i64* %r207
%r208 = lshr i512 %r204, 64
%r209 = trunc i512 %r208 to i64
%r211 = getelementptr i64, i64* %r1, i32 4
store i64 %r209, i64* %r211
%r212 = lshr i512 %r208, 64
%r213 = trunc i512 %r212 to i64
%r215 = getelementptr i64, i64* %r1, i32 5
store i64 %r213, i64* %r215
%r216 = lshr i512 %r212, 64
%r217 = trunc i512 %r216 to i64
%r219 = getelementptr i64, i64* %r1, i32 6
store i64 %r217, i64* %r219
%r220 = lshr i512 %r216, 64
%r221 = trunc i512 %r220 to i64
%r223 = getelementptr i64, i64* %r1, i32 7
store i64 %r221, i64* %r223
ret void
}
define void @mcl_fp_subNF8L(i64* noalias  %r1, i64* noalias  %r2, i64* noalias  %r3, i64* noalias  %r4)
{
%r5 = load i64, i64* %r2
%r6 = zext i64 %r5 to i128
%r8 = getelementptr i64, i64* %r2, i32 1
%r9 = load i64, i64* %r8
%r10 = zext i64 %r9 to i128
%r11 = shl i128 %r10, 64
%r12 = or i128 %r6, %r11
%r13 = zext i128 %r12 to i192
%r15 = getelementptr i64, i64* %r2, i32 2
%r16 = load i64, i64* %r15
%r17 = zext i64 %r16 to i192
%r18 = shl i192 %r17, 128
%r19 = or i192 %r13, %r18
%r20 = zext i192 %r19 to i256
%r22 = getelementptr i64, i64* %r2, i32 3
%r23 = load i64, i64* %r22
%r24 = zext i64 %r23 to i256
%r25 = shl i256 %r24, 192
%r26 = or i256 %r20, %r25
%r27 = zext i256 %r26 to i320
%r29 = getelementptr i64, i64* %r2, i32 4
%r30 = load i64, i64* %r29
%r31 = zext i64 %r30 to i320
%r32 = shl i320 %r31, 256
%r33 = or i320 %r27, %r32
%r34 = zext i320 %r33 to i384
%r36 = getelementptr i64, i64* %r2, i32 5
%r37 = load i64, i64* %r36
%r38 = zext i64 %r37 to i384
%r39 = shl i384 %r38, 320
%r40 = or i384 %r34, %r39
%r41 = zext i384 %r40 to i448
%r43 = getelementptr i64, i64* %r2, i32 6
%r44 = load i64, i64* %r43
%r45 = zext i64 %r44 to i448
%r46 = shl i448 %r45, 384
%r47 = or i448 %r41, %r46
%r48 = zext i448 %r47 to i512
%r50 = getelementptr i64, i64* %r2, i32 7
%r51 = load i64, i64* %r50
%r52 = zext i64 %r51 to i512
%r53 = shl i512 %r52, 448
%r54 = or i512 %r48, %r53
%r55 = load i64, i64* %r3
%r56 = zext i64 %r55 to i128
%r58 = getelementptr i64, i64* %r3, i32 1
%r59 = load i64, i64* %r58
%r60 = zext i64 %r59 to i128
%r61 = shl i128 %r60, 64
%r62 = or i128 %r56, %r61
%r63 = zext i128 %r62 to i192
%r65 = getelementptr i64, i64* %r3, i32 2
%r66 = load i64, i64* %r65
%r67 = zext i64 %r66 to i192
%r68 = shl i192 %r67, 128
%r69 = or i192 %r63, %r68
%r70 = zext i192 %r69 to i256
%r72 = getelementptr i64, i64* %r3, i32 3
%r73 = load i64, i64* %r72
%r74 = zext i64 %r73 to i256
%r75 = shl i256 %r74, 192
%r76 = or i256 %r70, %r75
%r77 = zext i256 %r76 to i320
%r79 = getelementptr i64, i64* %r3, i32 4
%r80 = load i64, i64* %r79
%r81 = zext i64 %r80 to i320
%r82 = shl i320 %r81, 256
%r83 = or i320 %r77, %r82
%r84 = zext i320 %r83 to i384
%r86 = getelementptr i64, i64* %r3, i32 5
%r87 = load i64, i64* %r86
%r88 = zext i64 %r87 to i384
%r89 = shl i384 %r88, 320
%r90 = or i384 %r84, %r89
%r91 = zext i384 %r90 to i448
%r93 = getelementptr i64, i64* %r3, i32 6
%r94 = load i64, i64* %r93
%r95 = zext i64 %r94 to i448
%r96 = shl i448 %r95, 384
%r97 = or i448 %r91, %r96
%r98 = zext i448 %r97 to i512
%r100 = getelementptr i64, i64* %r3, i32 7
%r101 = load i64, i64* %r100
%r102 = zext i64 %r101 to i512
%r103 = shl i512 %r102, 448
%r104 = or i512 %r98, %r103
%r105 = sub i512 %r54, %r104
%r106 = lshr i512 %r105, 511
%r107 = trunc i512 %r106 to i1
%r108 = load i64, i64* %r4
%r109 = zext i64 %r108 to i128
%r111 = getelementptr i64, i64* %r4, i32 1
%r112 = load i64, i64* %r111
%r113 = zext i64 %r112 to i128
%r114 = shl i128 %r113, 64
%r115 = or i128 %r109, %r114
%r116 = zext i128 %r115 to i192
%r118 = getelementptr i64, i64* %r4, i32 2
%r119 = load i64, i64* %r118
%r120 = zext i64 %r119 to i192
%r121 = shl i192 %r120, 128
%r122 = or i192 %r116, %r121
%r123 = zext i192 %r122 to i256
%r125 = getelementptr i64, i64* %r4, i32 3
%r126 = load i64, i64* %r125
%r127 = zext i64 %r126 to i256
%r128 = shl i256 %r127, 192
%r129 = or i256 %r123, %r128
%r130 = zext i256 %r129 to i320
%r132 = getelementptr i64, i64* %r4, i32 4
%r133 = load i64, i64* %r132
%r134 = zext i64 %r133 to i320
%r135 = shl i320 %r134, 256
%r136 = or i320 %r130, %r135
%r137 = zext i320 %r136 to i384
%r139 = getelementptr i64, i64* %r4, i32 5
%r140 = load i64, i64* %r139
%r141 = zext i64 %r140 to i384
%r142 = shl i384 %r141, 320
%r143 = or i384 %r137, %r142
%r144 = zext i384 %r143 to i448
%r146 = getelementptr i64, i64* %r4, i32 6
%r147 = load i64, i64* %r146
%r148 = zext i64 %r147 to i448
%r149 = shl i448 %r148, 384
%r150 = or i448 %r144, %r149
%r151 = zext i448 %r150 to i512
%r153 = getelementptr i64, i64* %r4, i32 7
%r154 = load i64, i64* %r153
%r155 = zext i64 %r154 to i512
%r156 = shl i512 %r155, 448
%r157 = or i512 %r151, %r156
%r159 = select i1 %r107, i512 %r157, i512 0
%r160 = add i512 %r105, %r159
%r161 = trunc i512 %r160 to i64
%r163 = getelementptr i64, i64* %r1, i32 0
store i64 %r161, i64* %r163
%r164 = lshr i512 %r160, 64
%r165 = trunc i512 %r164 to i64
%r167 = getelementptr i64, i64* %r1, i32 1
store i64 %r165, i64* %r167
%r168 = lshr i512 %r164, 64
%r169 = trunc i512 %r168 to i64
%r171 = getelementptr i64, i64* %r1, i32 2
store i64 %r169, i64* %r171
%r172 = lshr i512 %r168, 64
%r173 = trunc i512 %r172 to i64
%r175 = getelementptr i64, i64* %r1, i32 3
store i64 %r173, i64* %r175
%r176 = lshr i512 %r172, 64
%r177 = trunc i512 %r176 to i64
%r179 = getelementptr i64, i64* %r1, i32 4
store i64 %r177, i64* %r179
%r180 = lshr i512 %r176, 64
%r181 = trunc i512 %r180 to i64
%r183 = getelementptr i64, i64* %r1, i32 5
store i64 %r181, i64* %r183
%r184 = lshr i512 %r180, 64
%r185 = trunc i512 %r184 to i64
%r187 = getelementptr i64, i64* %r1, i32 6
store i64 %r185, i64* %r187
%r188 = lshr i512 %r184, 64
%r189 = trunc i512 %r188 to i64
%r191 = getelementptr i64, i64* %r1, i32 7
store i64 %r189, i64* %r191
ret void
}
define void @mcl_fpDbl_add8L(i64* noalias  %r1, i64* noalias  %r2, i64* noalias  %r3, i64* noalias  %r4)
{
%r5 = load i64, i64* %r2
%r6 = zext i64 %r5 to i128
%r8 = getelementptr i64, i64* %r2, i32 1
%r9 = load i64, i64* %r8
%r10 = zext i64 %r9 to i128
%r11 = shl i128 %r10, 64
%r12 = or i128 %r6, %r11
%r13 = zext i128 %r12 to i192
%r15 = getelementptr i64, i64* %r2, i32 2
%r16 = load i64, i64* %r15
%r17 = zext i64 %r16 to i192
%r18 = shl i192 %r17, 128
%r19 = or i192 %r13, %r18
%r20 = zext i192 %r19 to i256
%r22 = getelementptr i64, i64* %r2, i32 3
%r23 = load i64, i64* %r22
%r24 = zext i64 %r23 to i256
%r25 = shl i256 %r24, 192
%r26 = or i256 %r20, %r25
%r27 = zext i256 %r26 to i320
%r29 = getelementptr i64, i64* %r2, i32 4
%r30 = load i64, i64* %r29
%r31 = zext i64 %r30 to i320
%r32 = shl i320 %r31, 256
%r33 = or i320 %r27, %r32
%r34 = zext i320 %r33 to i384
%r36 = getelementptr i64, i64* %r2, i32 5
%r37 = load i64, i64* %r36
%r38 = zext i64 %r37 to i384
%r39 = shl i384 %r38, 320
%r40 = or i384 %r34, %r39
%r41 = zext i384 %r40 to i448
%r43 = getelementptr i64, i64* %r2, i32 6
%r44 = load i64, i64* %r43
%r45 = zext i64 %r44 to i448
%r46 = shl i448 %r45, 384
%r47 = or i448 %r41, %r46
%r48 = zext i448 %r47 to i512
%r50 = getelementptr i64, i64* %r2, i32 7
%r51 = load i64, i64* %r50
%r52 = zext i64 %r51 to i512
%r53 = shl i512 %r52, 448
%r54 = or i512 %r48, %r53
%r55 = zext i512 %r54 to i576
%r57 = getelementptr i64, i64* %r2, i32 8
%r58 = load i64, i64* %r57
%r59 = zext i64 %r58 to i576
%r60 = shl i576 %r59, 512
%r61 = or i576 %r55, %r60
%r62 = zext i576 %r61 to i640
%r64 = getelementptr i64, i64* %r2, i32 9
%r65 = load i64, i64* %r64
%r66 = zext i64 %r65 to i640
%r67 = shl i640 %r66, 576
%r68 = or i640 %r62, %r67
%r69 = zext i640 %r68 to i704
%r71 = getelementptr i64, i64* %r2, i32 10
%r72 = load i64, i64* %r71
%r73 = zext i64 %r72 to i704
%r74 = shl i704 %r73, 640
%r75 = or i704 %r69, %r74
%r76 = zext i704 %r75 to i768
%r78 = getelementptr i64, i64* %r2, i32 11
%r79 = load i64, i64* %r78
%r80 = zext i64 %r79 to i768
%r81 = shl i768 %r80, 704
%r82 = or i768 %r76, %r81
%r83 = zext i768 %r82 to i832
%r85 = getelementptr i64, i64* %r2, i32 12
%r86 = load i64, i64* %r85
%r87 = zext i64 %r86 to i832
%r88 = shl i832 %r87, 768
%r89 = or i832 %r83, %r88
%r90 = zext i832 %r89 to i896
%r92 = getelementptr i64, i64* %r2, i32 13
%r93 = load i64, i64* %r92
%r94 = zext i64 %r93 to i896
%r95 = shl i896 %r94, 832
%r96 = or i896 %r90, %r95
%r97 = zext i896 %r96 to i960
%r99 = getelementptr i64, i64* %r2, i32 14
%r100 = load i64, i64* %r99
%r101 = zext i64 %r100 to i960
%r102 = shl i960 %r101, 896
%r103 = or i960 %r97, %r102
%r104 = zext i960 %r103 to i1024
%r106 = getelementptr i64, i64* %r2, i32 15
%r107 = load i64, i64* %r106
%r108 = zext i64 %r107 to i1024
%r109 = shl i1024 %r108, 960
%r110 = or i1024 %r104, %r109
%r111 = load i64, i64* %r3
%r112 = zext i64 %r111 to i128
%r114 = getelementptr i64, i64* %r3, i32 1
%r115 = load i64, i64* %r114
%r116 = zext i64 %r115 to i128
%r117 = shl i128 %r116, 64
%r118 = or i128 %r112, %r117
%r119 = zext i128 %r118 to i192
%r121 = getelementptr i64, i64* %r3, i32 2
%r122 = load i64, i64* %r121
%r123 = zext i64 %r122 to i192
%r124 = shl i192 %r123, 128
%r125 = or i192 %r119, %r124
%r126 = zext i192 %r125 to i256
%r128 = getelementptr i64, i64* %r3, i32 3
%r129 = load i64, i64* %r128
%r130 = zext i64 %r129 to i256
%r131 = shl i256 %r130, 192
%r132 = or i256 %r126, %r131
%r133 = zext i256 %r132 to i320
%r135 = getelementptr i64, i64* %r3, i32 4
%r136 = load i64, i64* %r135
%r137 = zext i64 %r136 to i320
%r138 = shl i320 %r137, 256
%r139 = or i320 %r133, %r138
%r140 = zext i320 %r139 to i384
%r142 = getelementptr i64, i64* %r3, i32 5
%r143 = load i64, i64* %r142
%r144 = zext i64 %r143 to i384
%r145 = shl i384 %r144, 320
%r146 = or i384 %r140, %r145
%r147 = zext i384 %r146 to i448
%r149 = getelementptr i64, i64* %r3, i32 6
%r150 = load i64, i64* %r149
%r151 = zext i64 %r150 to i448
%r152 = shl i448 %r151, 384
%r153 = or i448 %r147, %r152
%r154 = zext i448 %r153 to i512
%r156 = getelementptr i64, i64* %r3, i32 7
%r157 = load i64, i64* %r156
%r158 = zext i64 %r157 to i512
%r159 = shl i512 %r158, 448
%r160 = or i512 %r154, %r159
%r161 = zext i512 %r160 to i576
%r163 = getelementptr i64, i64* %r3, i32 8
%r164 = load i64, i64* %r163
%r165 = zext i64 %r164 to i576
%r166 = shl i576 %r165, 512
%r167 = or i576 %r161, %r166
%r168 = zext i576 %r167 to i640
%r170 = getelementptr i64, i64* %r3, i32 9
%r171 = load i64, i64* %r170
%r172 = zext i64 %r171 to i640
%r173 = shl i640 %r172, 576
%r174 = or i640 %r168, %r173
%r175 = zext i640 %r174 to i704
%r177 = getelementptr i64, i64* %r3, i32 10
%r178 = load i64, i64* %r177
%r179 = zext i64 %r178 to i704
%r180 = shl i704 %r179, 640
%r181 = or i704 %r175, %r180
%r182 = zext i704 %r181 to i768
%r184 = getelementptr i64, i64* %r3, i32 11
%r185 = load i64, i64* %r184
%r186 = zext i64 %r185 to i768
%r187 = shl i768 %r186, 704
%r188 = or i768 %r182, %r187
%r189 = zext i768 %r188 to i832
%r191 = getelementptr i64, i64* %r3, i32 12
%r192 = load i64, i64* %r191
%r193 = zext i64 %r192 to i832
%r194 = shl i832 %r193, 768
%r195 = or i832 %r189, %r194
%r196 = zext i832 %r195 to i896
%r198 = getelementptr i64, i64* %r3, i32 13
%r199 = load i64, i64* %r198
%r200 = zext i64 %r199 to i896
%r201 = shl i896 %r200, 832
%r202 = or i896 %r196, %r201
%r203 = zext i896 %r202 to i960
%r205 = getelementptr i64, i64* %r3, i32 14
%r206 = load i64, i64* %r205
%r207 = zext i64 %r206 to i960
%r208 = shl i960 %r207, 896
%r209 = or i960 %r203, %r208
%r210 = zext i960 %r209 to i1024
%r212 = getelementptr i64, i64* %r3, i32 15
%r213 = load i64, i64* %r212
%r214 = zext i64 %r213 to i1024
%r215 = shl i1024 %r214, 960
%r216 = or i1024 %r210, %r215
%r217 = zext i1024 %r110 to i1088
%r218 = zext i1024 %r216 to i1088
%r219 = add i1088 %r217, %r218
%r220 = trunc i1088 %r219 to i512
%r221 = trunc i512 %r220 to i64
%r223 = getelementptr i64, i64* %r1, i32 0
store i64 %r221, i64* %r223
%r224 = lshr i512 %r220, 64
%r225 = trunc i512 %r224 to i64
%r227 = getelementptr i64, i64* %r1, i32 1
store i64 %r225, i64* %r227
%r228 = lshr i512 %r224, 64
%r229 = trunc i512 %r228 to i64
%r231 = getelementptr i64, i64* %r1, i32 2
store i64 %r229, i64* %r231
%r232 = lshr i512 %r228, 64
%r233 = trunc i512 %r232 to i64
%r235 = getelementptr i64, i64* %r1, i32 3
store i64 %r233, i64* %r235
%r236 = lshr i512 %r232, 64
%r237 = trunc i512 %r236 to i64
%r239 = getelementptr i64, i64* %r1, i32 4
store i64 %r237, i64* %r239
%r240 = lshr i512 %r236, 64
%r241 = trunc i512 %r240 to i64
%r243 = getelementptr i64, i64* %r1, i32 5
store i64 %r241, i64* %r243
%r244 = lshr i512 %r240, 64
%r245 = trunc i512 %r244 to i64
%r247 = getelementptr i64, i64* %r1, i32 6
store i64 %r245, i64* %r247
%r248 = lshr i512 %r244, 64
%r249 = trunc i512 %r248 to i64
%r251 = getelementptr i64, i64* %r1, i32 7
store i64 %r249, i64* %r251
%r252 = lshr i1088 %r219, 512
%r253 = trunc i1088 %r252 to i576
%r254 = load i64, i64* %r4
%r255 = zext i64 %r254 to i128
%r257 = getelementptr i64, i64* %r4, i32 1
%r258 = load i64, i64* %r257
%r259 = zext i64 %r258 to i128
%r260 = shl i128 %r259, 64
%r261 = or i128 %r255, %r260
%r262 = zext i128 %r261 to i192
%r264 = getelementptr i64, i64* %r4, i32 2
%r265 = load i64, i64* %r264
%r266 = zext i64 %r265 to i192
%r267 = shl i192 %r266, 128
%r268 = or i192 %r262, %r267
%r269 = zext i192 %r268 to i256
%r271 = getelementptr i64, i64* %r4, i32 3
%r272 = load i64, i64* %r271
%r273 = zext i64 %r272 to i256
%r274 = shl i256 %r273, 192
%r275 = or i256 %r269, %r274
%r276 = zext i256 %r275 to i320
%r278 = getelementptr i64, i64* %r4, i32 4
%r279 = load i64, i64* %r278
%r280 = zext i64 %r279 to i320
%r281 = shl i320 %r280, 256
%r282 = or i320 %r276, %r281
%r283 = zext i320 %r282 to i384
%r285 = getelementptr i64, i64* %r4, i32 5
%r286 = load i64, i64* %r285
%r287 = zext i64 %r286 to i384
%r288 = shl i384 %r287, 320
%r289 = or i384 %r283, %r288
%r290 = zext i384 %r289 to i448
%r292 = getelementptr i64, i64* %r4, i32 6
%r293 = load i64, i64* %r292
%r294 = zext i64 %r293 to i448
%r295 = shl i448 %r294, 384
%r296 = or i448 %r290, %r295
%r297 = zext i448 %r296 to i512
%r299 = getelementptr i64, i64* %r4, i32 7
%r300 = load i64, i64* %r299
%r301 = zext i64 %r300 to i512
%r302 = shl i512 %r301, 448
%r303 = or i512 %r297, %r302
%r304 = zext i512 %r303 to i576
%r305 = sub i576 %r253, %r304
%r306 = lshr i576 %r305, 512
%r307 = trunc i576 %r306 to i1
%r308 = select i1 %r307, i576 %r253, i576 %r305
%r309 = trunc i576 %r308 to i512
%r311 = getelementptr i64, i64* %r1, i32 8
%r312 = trunc i512 %r309 to i64
%r314 = getelementptr i64, i64* %r311, i32 0
store i64 %r312, i64* %r314
%r315 = lshr i512 %r309, 64
%r316 = trunc i512 %r315 to i64
%r318 = getelementptr i64, i64* %r311, i32 1
store i64 %r316, i64* %r318
%r319 = lshr i512 %r315, 64
%r320 = trunc i512 %r319 to i64
%r322 = getelementptr i64, i64* %r311, i32 2
store i64 %r320, i64* %r322
%r323 = lshr i512 %r319, 64
%r324 = trunc i512 %r323 to i64
%r326 = getelementptr i64, i64* %r311, i32 3
store i64 %r324, i64* %r326
%r327 = lshr i512 %r323, 64
%r328 = trunc i512 %r327 to i64
%r330 = getelementptr i64, i64* %r311, i32 4
store i64 %r328, i64* %r330
%r331 = lshr i512 %r327, 64
%r332 = trunc i512 %r331 to i64
%r334 = getelementptr i64, i64* %r311, i32 5
store i64 %r332, i64* %r334
%r335 = lshr i512 %r331, 64
%r336 = trunc i512 %r335 to i64
%r338 = getelementptr i64, i64* %r311, i32 6
store i64 %r336, i64* %r338
%r339 = lshr i512 %r335, 64
%r340 = trunc i512 %r339 to i64
%r342 = getelementptr i64, i64* %r311, i32 7
store i64 %r340, i64* %r342
ret void
}
define void @mcl_fpDbl_sub8L(i64* noalias  %r1, i64* noalias  %r2, i64* noalias  %r3, i64* noalias  %r4)
{
%r5 = load i64, i64* %r2
%r6 = zext i64 %r5 to i128
%r8 = getelementptr i64, i64* %r2, i32 1
%r9 = load i64, i64* %r8
%r10 = zext i64 %r9 to i128
%r11 = shl i128 %r10, 64
%r12 = or i128 %r6, %r11
%r13 = zext i128 %r12 to i192
%r15 = getelementptr i64, i64* %r2, i32 2
%r16 = load i64, i64* %r15
%r17 = zext i64 %r16 to i192
%r18 = shl i192 %r17, 128
%r19 = or i192 %r13, %r18
%r20 = zext i192 %r19 to i256
%r22 = getelementptr i64, i64* %r2, i32 3
%r23 = load i64, i64* %r22
%r24 = zext i64 %r23 to i256
%r25 = shl i256 %r24, 192
%r26 = or i256 %r20, %r25
%r27 = zext i256 %r26 to i320
%r29 = getelementptr i64, i64* %r2, i32 4
%r30 = load i64, i64* %r29
%r31 = zext i64 %r30 to i320
%r32 = shl i320 %r31, 256
%r33 = or i320 %r27, %r32
%r34 = zext i320 %r33 to i384
%r36 = getelementptr i64, i64* %r2, i32 5
%r37 = load i64, i64* %r36
%r38 = zext i64 %r37 to i384
%r39 = shl i384 %r38, 320
%r40 = or i384 %r34, %r39
%r41 = zext i384 %r40 to i448
%r43 = getelementptr i64, i64* %r2, i32 6
%r44 = load i64, i64* %r43
%r45 = zext i64 %r44 to i448
%r46 = shl i448 %r45, 384
%r47 = or i448 %r41, %r46
%r48 = zext i448 %r47 to i512
%r50 = getelementptr i64, i64* %r2, i32 7
%r51 = load i64, i64* %r50
%r52 = zext i64 %r51 to i512
%r53 = shl i512 %r52, 448
%r54 = or i512 %r48, %r53
%r55 = zext i512 %r54 to i576
%r57 = getelementptr i64, i64* %r2, i32 8
%r58 = load i64, i64* %r57
%r59 = zext i64 %r58 to i576
%r60 = shl i576 %r59, 512
%r61 = or i576 %r55, %r60
%r62 = zext i576 %r61 to i640
%r64 = getelementptr i64, i64* %r2, i32 9
%r65 = load i64, i64* %r64
%r66 = zext i64 %r65 to i640
%r67 = shl i640 %r66, 576
%r68 = or i640 %r62, %r67
%r69 = zext i640 %r68 to i704
%r71 = getelementptr i64, i64* %r2, i32 10
%r72 = load i64, i64* %r71
%r73 = zext i64 %r72 to i704
%r74 = shl i704 %r73, 640
%r75 = or i704 %r69, %r74
%r76 = zext i704 %r75 to i768
%r78 = getelementptr i64, i64* %r2, i32 11
%r79 = load i64, i64* %r78
%r80 = zext i64 %r79 to i768
%r81 = shl i768 %r80, 704
%r82 = or i768 %r76, %r81
%r83 = zext i768 %r82 to i832
%r85 = getelementptr i64, i64* %r2, i32 12
%r86 = load i64, i64* %r85
%r87 = zext i64 %r86 to i832
%r88 = shl i832 %r87, 768
%r89 = or i832 %r83, %r88
%r90 = zext i832 %r89 to i896
%r92 = getelementptr i64, i64* %r2, i32 13
%r93 = load i64, i64* %r92
%r94 = zext i64 %r93 to i896
%r95 = shl i896 %r94, 832
%r96 = or i896 %r90, %r95
%r97 = zext i896 %r96 to i960
%r99 = getelementptr i64, i64* %r2, i32 14
%r100 = load i64, i64* %r99
%r101 = zext i64 %r100 to i960
%r102 = shl i960 %r101, 896
%r103 = or i960 %r97, %r102
%r104 = zext i960 %r103 to i1024
%r106 = getelementptr i64, i64* %r2, i32 15
%r107 = load i64, i64* %r106
%r108 = zext i64 %r107 to i1024
%r109 = shl i1024 %r108, 960
%r110 = or i1024 %r104, %r109
%r111 = load i64, i64* %r3
%r112 = zext i64 %r111 to i128
%r114 = getelementptr i64, i64* %r3, i32 1
%r115 = load i64, i64* %r114
%r116 = zext i64 %r115 to i128
%r117 = shl i128 %r116, 64
%r118 = or i128 %r112, %r117
%r119 = zext i128 %r118 to i192
%r121 = getelementptr i64, i64* %r3, i32 2
%r122 = load i64, i64* %r121
%r123 = zext i64 %r122 to i192
%r124 = shl i192 %r123, 128
%r125 = or i192 %r119, %r124
%r126 = zext i192 %r125 to i256
%r128 = getelementptr i64, i64* %r3, i32 3
%r129 = load i64, i64* %r128
%r130 = zext i64 %r129 to i256
%r131 = shl i256 %r130, 192
%r132 = or i256 %r126, %r131
%r133 = zext i256 %r132 to i320
%r135 = getelementptr i64, i64* %r3, i32 4
%r136 = load i64, i64* %r135
%r137 = zext i64 %r136 to i320
%r138 = shl i320 %r137, 256
%r139 = or i320 %r133, %r138
%r140 = zext i320 %r139 to i384
%r142 = getelementptr i64, i64* %r3, i32 5
%r143 = load i64, i64* %r142
%r144 = zext i64 %r143 to i384
%r145 = shl i384 %r144, 320
%r146 = or i384 %r140, %r145
%r147 = zext i384 %r146 to i448
%r149 = getelementptr i64, i64* %r3, i32 6
%r150 = load i64, i64* %r149
%r151 = zext i64 %r150 to i448
%r152 = shl i448 %r151, 384
%r153 = or i448 %r147, %r152
%r154 = zext i448 %r153 to i512
%r156 = getelementptr i64, i64* %r3, i32 7
%r157 = load i64, i64* %r156
%r158 = zext i64 %r157 to i512
%r159 = shl i512 %r158, 448
%r160 = or i512 %r154, %r159
%r161 = zext i512 %r160 to i576
%r163 = getelementptr i64, i64* %r3, i32 8
%r164 = load i64, i64* %r163
%r165 = zext i64 %r164 to i576
%r166 = shl i576 %r165, 512
%r167 = or i576 %r161, %r166
%r168 = zext i576 %r167 to i640
%r170 = getelementptr i64, i64* %r3, i32 9
%r171 = load i64, i64* %r170
%r172 = zext i64 %r171 to i640
%r173 = shl i640 %r172, 576
%r174 = or i640 %r168, %r173
%r175 = zext i640 %r174 to i704
%r177 = getelementptr i64, i64* %r3, i32 10
%r178 = load i64, i64* %r177
%r179 = zext i64 %r178 to i704
%r180 = shl i704 %r179, 640
%r181 = or i704 %r175, %r180
%r182 = zext i704 %r181 to i768
%r184 = getelementptr i64, i64* %r3, i32 11
%r185 = load i64, i64* %r184
%r186 = zext i64 %r185 to i768
%r187 = shl i768 %r186, 704
%r188 = or i768 %r182, %r187
%r189 = zext i768 %r188 to i832
%r191 = getelementptr i64, i64* %r3, i32 12
%r192 = load i64, i64* %r191
%r193 = zext i64 %r192 to i832
%r194 = shl i832 %r193, 768
%r195 = or i832 %r189, %r194
%r196 = zext i832 %r195 to i896
%r198 = getelementptr i64, i64* %r3, i32 13
%r199 = load i64, i64* %r198
%r200 = zext i64 %r199 to i896
%r201 = shl i896 %r200, 832
%r202 = or i896 %r196, %r201
%r203 = zext i896 %r202 to i960
%r205 = getelementptr i64, i64* %r3, i32 14
%r206 = load i64, i64* %r205
%r207 = zext i64 %r206 to i960
%r208 = shl i960 %r207, 896
%r209 = or i960 %r203, %r208
%r210 = zext i960 %r209 to i1024
%r212 = getelementptr i64, i64* %r3, i32 15
%r213 = load i64, i64* %r212
%r214 = zext i64 %r213 to i1024
%r215 = shl i1024 %r214, 960
%r216 = or i1024 %r210, %r215
%r217 = zext i1024 %r110 to i1088
%r218 = zext i1024 %r216 to i1088
%r219 = sub i1088 %r217, %r218
%r220 = trunc i1088 %r219 to i512
%r221 = trunc i512 %r220 to i64
%r223 = getelementptr i64, i64* %r1, i32 0
store i64 %r221, i64* %r223
%r224 = lshr i512 %r220, 64
%r225 = trunc i512 %r224 to i64
%r227 = getelementptr i64, i64* %r1, i32 1
store i64 %r225, i64* %r227
%r228 = lshr i512 %r224, 64
%r229 = trunc i512 %r228 to i64
%r231 = getelementptr i64, i64* %r1, i32 2
store i64 %r229, i64* %r231
%r232 = lshr i512 %r228, 64
%r233 = trunc i512 %r232 to i64
%r235 = getelementptr i64, i64* %r1, i32 3
store i64 %r233, i64* %r235
%r236 = lshr i512 %r232, 64
%r237 = trunc i512 %r236 to i64
%r239 = getelementptr i64, i64* %r1, i32 4
store i64 %r237, i64* %r239
%r240 = lshr i512 %r236, 64
%r241 = trunc i512 %r240 to i64
%r243 = getelementptr i64, i64* %r1, i32 5
store i64 %r241, i64* %r243
%r244 = lshr i512 %r240, 64
%r245 = trunc i512 %r244 to i64
%r247 = getelementptr i64, i64* %r1, i32 6
store i64 %r245, i64* %r247
%r248 = lshr i512 %r244, 64
%r249 = trunc i512 %r248 to i64
%r251 = getelementptr i64, i64* %r1, i32 7
store i64 %r249, i64* %r251
%r252 = lshr i1088 %r219, 512
%r253 = trunc i1088 %r252 to i512
%r254 = lshr i1088 %r219, 1024
%r255 = trunc i1088 %r254 to i1
%r256 = load i64, i64* %r4
%r257 = zext i64 %r256 to i128
%r259 = getelementptr i64, i64* %r4, i32 1
%r260 = load i64, i64* %r259
%r261 = zext i64 %r260 to i128
%r262 = shl i128 %r261, 64
%r263 = or i128 %r257, %r262
%r264 = zext i128 %r263 to i192
%r266 = getelementptr i64, i64* %r4, i32 2
%r267 = load i64, i64* %r266
%r268 = zext i64 %r267 to i192
%r269 = shl i192 %r268, 128
%r270 = or i192 %r264, %r269
%r271 = zext i192 %r270 to i256
%r273 = getelementptr i64, i64* %r4, i32 3
%r274 = load i64, i64* %r273
%r275 = zext i64 %r274 to i256
%r276 = shl i256 %r275, 192
%r277 = or i256 %r271, %r276
%r278 = zext i256 %r277 to i320
%r280 = getelementptr i64, i64* %r4, i32 4
%r281 = load i64, i64* %r280
%r282 = zext i64 %r281 to i320
%r283 = shl i320 %r282, 256
%r284 = or i320 %r278, %r283
%r285 = zext i320 %r284 to i384
%r287 = getelementptr i64, i64* %r4, i32 5
%r288 = load i64, i64* %r287
%r289 = zext i64 %r288 to i384
%r290 = shl i384 %r289, 320
%r291 = or i384 %r285, %r290
%r292 = zext i384 %r291 to i448
%r294 = getelementptr i64, i64* %r4, i32 6
%r295 = load i64, i64* %r294
%r296 = zext i64 %r295 to i448
%r297 = shl i448 %r296, 384
%r298 = or i448 %r292, %r297
%r299 = zext i448 %r298 to i512
%r301 = getelementptr i64, i64* %r4, i32 7
%r302 = load i64, i64* %r301
%r303 = zext i64 %r302 to i512
%r304 = shl i512 %r303, 448
%r305 = or i512 %r299, %r304
%r307 = select i1 %r255, i512 %r305, i512 0
%r308 = add i512 %r253, %r307
%r310 = getelementptr i64, i64* %r1, i32 8
%r311 = trunc i512 %r308 to i64
%r313 = getelementptr i64, i64* %r310, i32 0
store i64 %r311, i64* %r313
%r314 = lshr i512 %r308, 64
%r315 = trunc i512 %r314 to i64
%r317 = getelementptr i64, i64* %r310, i32 1
store i64 %r315, i64* %r317
%r318 = lshr i512 %r314, 64
%r319 = trunc i512 %r318 to i64
%r321 = getelementptr i64, i64* %r310, i32 2
store i64 %r319, i64* %r321
%r322 = lshr i512 %r318, 64
%r323 = trunc i512 %r322 to i64
%r325 = getelementptr i64, i64* %r310, i32 3
store i64 %r323, i64* %r325
%r326 = lshr i512 %r322, 64
%r327 = trunc i512 %r326 to i64
%r329 = getelementptr i64, i64* %r310, i32 4
store i64 %r327, i64* %r329
%r330 = lshr i512 %r326, 64
%r331 = trunc i512 %r330 to i64
%r333 = getelementptr i64, i64* %r310, i32 5
store i64 %r331, i64* %r333
%r334 = lshr i512 %r330, 64
%r335 = trunc i512 %r334 to i64
%r337 = getelementptr i64, i64* %r310, i32 6
store i64 %r335, i64* %r337
%r338 = lshr i512 %r334, 64
%r339 = trunc i512 %r338 to i64
%r341 = getelementptr i64, i64* %r310, i32 7
store i64 %r339, i64* %r341
ret void
}
define i640 @mulPv576x64(i64* noalias  %r2, i64 %r3)
{
%r5 = call i128 @mulPos64x64(i64* %r2, i64 %r3, i64 0)
%r6 = trunc i128 %r5 to i64
%r7 = call i64 @extractHigh64(i128 %r5)
%r9 = call i128 @mulPos64x64(i64* %r2, i64 %r3, i64 1)
%r10 = trunc i128 %r9 to i64
%r11 = call i64 @extractHigh64(i128 %r9)
%r13 = call i128 @mulPos64x64(i64* %r2, i64 %r3, i64 2)
%r14 = trunc i128 %r13 to i64
%r15 = call i64 @extractHigh64(i128 %r13)
%r17 = call i128 @mulPos64x64(i64* %r2, i64 %r3, i64 3)
%r18 = trunc i128 %r17 to i64
%r19 = call i64 @extractHigh64(i128 %r17)
%r21 = call i128 @mulPos64x64(i64* %r2, i64 %r3, i64 4)
%r22 = trunc i128 %r21 to i64
%r23 = call i64 @extractHigh64(i128 %r21)
%r25 = call i128 @mulPos64x64(i64* %r2, i64 %r3, i64 5)
%r26 = trunc i128 %r25 to i64
%r27 = call i64 @extractHigh64(i128 %r25)
%r29 = call i128 @mulPos64x64(i64* %r2, i64 %r3, i64 6)
%r30 = trunc i128 %r29 to i64
%r31 = call i64 @extractHigh64(i128 %r29)
%r33 = call i128 @mulPos64x64(i64* %r2, i64 %r3, i64 7)
%r34 = trunc i128 %r33 to i64
%r35 = call i64 @extractHigh64(i128 %r33)
%r37 = call i128 @mulPos64x64(i64* %r2, i64 %r3, i64 8)
%r38 = trunc i128 %r37 to i64
%r39 = call i64 @extractHigh64(i128 %r37)
%r40 = zext i64 %r6 to i128
%r41 = zext i64 %r10 to i128
%r42 = shl i128 %r41, 64
%r43 = or i128 %r40, %r42
%r44 = zext i128 %r43 to i192
%r45 = zext i64 %r14 to i192
%r46 = shl i192 %r45, 128
%r47 = or i192 %r44, %r46
%r48 = zext i192 %r47 to i256
%r49 = zext i64 %r18 to i256
%r50 = shl i256 %r49, 192
%r51 = or i256 %r48, %r50
%r52 = zext i256 %r51 to i320
%r53 = zext i64 %r22 to i320
%r54 = shl i320 %r53, 256
%r55 = or i320 %r52, %r54
%r56 = zext i320 %r55 to i384
%r57 = zext i64 %r26 to i384
%r58 = shl i384 %r57, 320
%r59 = or i384 %r56, %r58
%r60 = zext i384 %r59 to i448
%r61 = zext i64 %r30 to i448
%r62 = shl i448 %r61, 384
%r63 = or i448 %r60, %r62
%r64 = zext i448 %r63 to i512
%r65 = zext i64 %r34 to i512
%r66 = shl i512 %r65, 448
%r67 = or i512 %r64, %r66
%r68 = zext i512 %r67 to i576
%r69 = zext i64 %r38 to i576
%r70 = shl i576 %r69, 512
%r71 = or i576 %r68, %r70
%r72 = zext i64 %r7 to i128
%r73 = zext i64 %r11 to i128
%r74 = shl i128 %r73, 64
%r75 = or i128 %r72, %r74
%r76 = zext i128 %r75 to i192
%r77 = zext i64 %r15 to i192
%r78 = shl i192 %r77, 128
%r79 = or i192 %r76, %r78
%r80 = zext i192 %r79 to i256
%r81 = zext i64 %r19 to i256
%r82 = shl i256 %r81, 192
%r83 = or i256 %r80, %r82
%r84 = zext i256 %r83 to i320
%r85 = zext i64 %r23 to i320
%r86 = shl i320 %r85, 256
%r87 = or i320 %r84, %r86
%r88 = zext i320 %r87 to i384
%r89 = zext i64 %r27 to i384
%r90 = shl i384 %r89, 320
%r91 = or i384 %r88, %r90
%r92 = zext i384 %r91 to i448
%r93 = zext i64 %r31 to i448
%r94 = shl i448 %r93, 384
%r95 = or i448 %r92, %r94
%r96 = zext i448 %r95 to i512
%r97 = zext i64 %r35 to i512
%r98 = shl i512 %r97, 448
%r99 = or i512 %r96, %r98
%r100 = zext i512 %r99 to i576
%r101 = zext i64 %r39 to i576
%r102 = shl i576 %r101, 512
%r103 = or i576 %r100, %r102
%r104 = zext i576 %r71 to i640
%r105 = zext i576 %r103 to i640
%r106 = shl i640 %r105, 64
%r107 = add i640 %r104, %r106
ret i640 %r107
}
define void @mcl_fp_mulUnitPre9L(i64* noalias  %r1, i64* noalias  %r2, i64 %r3)
{
%r4 = call i640 @mulPv576x64(i64* %r2, i64 %r3)
%r5 = trunc i640 %r4 to i64
%r7 = getelementptr i64, i64* %r1, i32 0
store i64 %r5, i64* %r7
%r8 = lshr i640 %r4, 64
%r9 = trunc i640 %r8 to i64
%r11 = getelementptr i64, i64* %r1, i32 1
store i64 %r9, i64* %r11
%r12 = lshr i640 %r8, 64
%r13 = trunc i640 %r12 to i64
%r15 = getelementptr i64, i64* %r1, i32 2
store i64 %r13, i64* %r15
%r16 = lshr i640 %r12, 64
%r17 = trunc i640 %r16 to i64
%r19 = getelementptr i64, i64* %r1, i32 3
store i64 %r17, i64* %r19
%r20 = lshr i640 %r16, 64
%r21 = trunc i640 %r20 to i64
%r23 = getelementptr i64, i64* %r1, i32 4
store i64 %r21, i64* %r23
%r24 = lshr i640 %r20, 64
%r25 = trunc i640 %r24 to i64
%r27 = getelementptr i64, i64* %r1, i32 5
store i64 %r25, i64* %r27
%r28 = lshr i640 %r24, 64
%r29 = trunc i640 %r28 to i64
%r31 = getelementptr i64, i64* %r1, i32 6
store i64 %r29, i64* %r31
%r32 = lshr i640 %r28, 64
%r33 = trunc i640 %r32 to i64
%r35 = getelementptr i64, i64* %r1, i32 7
store i64 %r33, i64* %r35
%r36 = lshr i640 %r32, 64
%r37 = trunc i640 %r36 to i64
%r39 = getelementptr i64, i64* %r1, i32 8
store i64 %r37, i64* %r39
%r40 = lshr i640 %r36, 64
%r41 = trunc i640 %r40 to i64
%r43 = getelementptr i64, i64* %r1, i32 9
store i64 %r41, i64* %r43
ret void
}
define void @mcl_fpDbl_mulPre9L(i64* noalias  %r1, i64* noalias  %r2, i64* noalias  %r3)
{
%r4 = load i64, i64* %r3
%r5 = call i640 @mulPv576x64(i64* %r2, i64 %r4)
%r6 = trunc i640 %r5 to i64
store i64 %r6, i64* %r1
%r7 = lshr i640 %r5, 64
%r9 = getelementptr i64, i64* %r3, i32 1
%r10 = load i64, i64* %r9
%r11 = call i640 @mulPv576x64(i64* %r2, i64 %r10)
%r12 = add i640 %r7, %r11
%r13 = trunc i640 %r12 to i64
%r15 = getelementptr i64, i64* %r1, i32 1
store i64 %r13, i64* %r15
%r16 = lshr i640 %r12, 64
%r18 = getelementptr i64, i64* %r3, i32 2
%r19 = load i64, i64* %r18
%r20 = call i640 @mulPv576x64(i64* %r2, i64 %r19)
%r21 = add i640 %r16, %r20
%r22 = trunc i640 %r21 to i64
%r24 = getelementptr i64, i64* %r1, i32 2
store i64 %r22, i64* %r24
%r25 = lshr i640 %r21, 64
%r27 = getelementptr i64, i64* %r3, i32 3
%r28 = load i64, i64* %r27
%r29 = call i640 @mulPv576x64(i64* %r2, i64 %r28)
%r30 = add i640 %r25, %r29
%r31 = trunc i640 %r30 to i64
%r33 = getelementptr i64, i64* %r1, i32 3
store i64 %r31, i64* %r33
%r34 = lshr i640 %r30, 64
%r36 = getelementptr i64, i64* %r3, i32 4
%r37 = load i64, i64* %r36
%r38 = call i640 @mulPv576x64(i64* %r2, i64 %r37)
%r39 = add i640 %r34, %r38
%r40 = trunc i640 %r39 to i64
%r42 = getelementptr i64, i64* %r1, i32 4
store i64 %r40, i64* %r42
%r43 = lshr i640 %r39, 64
%r45 = getelementptr i64, i64* %r3, i32 5
%r46 = load i64, i64* %r45
%r47 = call i640 @mulPv576x64(i64* %r2, i64 %r46)
%r48 = add i640 %r43, %r47
%r49 = trunc i640 %r48 to i64
%r51 = getelementptr i64, i64* %r1, i32 5
store i64 %r49, i64* %r51
%r52 = lshr i640 %r48, 64
%r54 = getelementptr i64, i64* %r3, i32 6
%r55 = load i64, i64* %r54
%r56 = call i640 @mulPv576x64(i64* %r2, i64 %r55)
%r57 = add i640 %r52, %r56
%r58 = trunc i640 %r57 to i64
%r60 = getelementptr i64, i64* %r1, i32 6
store i64 %r58, i64* %r60
%r61 = lshr i640 %r57, 64
%r63 = getelementptr i64, i64* %r3, i32 7
%r64 = load i64, i64* %r63
%r65 = call i640 @mulPv576x64(i64* %r2, i64 %r64)
%r66 = add i640 %r61, %r65
%r67 = trunc i640 %r66 to i64
%r69 = getelementptr i64, i64* %r1, i32 7
store i64 %r67, i64* %r69
%r70 = lshr i640 %r66, 64
%r72 = getelementptr i64, i64* %r3, i32 8
%r73 = load i64, i64* %r72
%r74 = call i640 @mulPv576x64(i64* %r2, i64 %r73)
%r75 = add i640 %r70, %r74
%r77 = getelementptr i64, i64* %r1, i32 8
%r78 = trunc i640 %r75 to i64
%r80 = getelementptr i64, i64* %r77, i32 0
store i64 %r78, i64* %r80
%r81 = lshr i640 %r75, 64
%r82 = trunc i640 %r81 to i64
%r84 = getelementptr i64, i64* %r77, i32 1
store i64 %r82, i64* %r84
%r85 = lshr i640 %r81, 64
%r86 = trunc i640 %r85 to i64
%r88 = getelementptr i64, i64* %r77, i32 2
store i64 %r86, i64* %r88
%r89 = lshr i640 %r85, 64
%r90 = trunc i640 %r89 to i64
%r92 = getelementptr i64, i64* %r77, i32 3
store i64 %r90, i64* %r92
%r93 = lshr i640 %r89, 64
%r94 = trunc i640 %r93 to i64
%r96 = getelementptr i64, i64* %r77, i32 4
store i64 %r94, i64* %r96
%r97 = lshr i640 %r93, 64
%r98 = trunc i640 %r97 to i64
%r100 = getelementptr i64, i64* %r77, i32 5
store i64 %r98, i64* %r100
%r101 = lshr i640 %r97, 64
%r102 = trunc i640 %r101 to i64
%r104 = getelementptr i64, i64* %r77, i32 6
store i64 %r102, i64* %r104
%r105 = lshr i640 %r101, 64
%r106 = trunc i640 %r105 to i64
%r108 = getelementptr i64, i64* %r77, i32 7
store i64 %r106, i64* %r108
%r109 = lshr i640 %r105, 64
%r110 = trunc i640 %r109 to i64
%r112 = getelementptr i64, i64* %r77, i32 8
store i64 %r110, i64* %r112
%r113 = lshr i640 %r109, 64
%r114 = trunc i640 %r113 to i64
%r116 = getelementptr i64, i64* %r77, i32 9
store i64 %r114, i64* %r116
ret void
}
define void @mcl_fpDbl_sqrPre9L(i64* noalias  %r1, i64* noalias  %r2)
{
%r3 = load i64, i64* %r2
%r4 = call i640 @mulPv576x64(i64* %r2, i64 %r3)
%r5 = trunc i640 %r4 to i64
store i64 %r5, i64* %r1
%r6 = lshr i640 %r4, 64
%r8 = getelementptr i64, i64* %r2, i32 1
%r9 = load i64, i64* %r8
%r10 = call i640 @mulPv576x64(i64* %r2, i64 %r9)
%r11 = add i640 %r6, %r10
%r12 = trunc i640 %r11 to i64
%r14 = getelementptr i64, i64* %r1, i32 1
store i64 %r12, i64* %r14
%r15 = lshr i640 %r11, 64
%r17 = getelementptr i64, i64* %r2, i32 2
%r18 = load i64, i64* %r17
%r19 = call i640 @mulPv576x64(i64* %r2, i64 %r18)
%r20 = add i640 %r15, %r19
%r21 = trunc i640 %r20 to i64
%r23 = getelementptr i64, i64* %r1, i32 2
store i64 %r21, i64* %r23
%r24 = lshr i640 %r20, 64
%r26 = getelementptr i64, i64* %r2, i32 3
%r27 = load i64, i64* %r26
%r28 = call i640 @mulPv576x64(i64* %r2, i64 %r27)
%r29 = add i640 %r24, %r28
%r30 = trunc i640 %r29 to i64
%r32 = getelementptr i64, i64* %r1, i32 3
store i64 %r30, i64* %r32
%r33 = lshr i640 %r29, 64
%r35 = getelementptr i64, i64* %r2, i32 4
%r36 = load i64, i64* %r35
%r37 = call i640 @mulPv576x64(i64* %r2, i64 %r36)
%r38 = add i640 %r33, %r37
%r39 = trunc i640 %r38 to i64
%r41 = getelementptr i64, i64* %r1, i32 4
store i64 %r39, i64* %r41
%r42 = lshr i640 %r38, 64
%r44 = getelementptr i64, i64* %r2, i32 5
%r45 = load i64, i64* %r44
%r46 = call i640 @mulPv576x64(i64* %r2, i64 %r45)
%r47 = add i640 %r42, %r46
%r48 = trunc i640 %r47 to i64
%r50 = getelementptr i64, i64* %r1, i32 5
store i64 %r48, i64* %r50
%r51 = lshr i640 %r47, 64
%r53 = getelementptr i64, i64* %r2, i32 6
%r54 = load i64, i64* %r53
%r55 = call i640 @mulPv576x64(i64* %r2, i64 %r54)
%r56 = add i640 %r51, %r55
%r57 = trunc i640 %r56 to i64
%r59 = getelementptr i64, i64* %r1, i32 6
store i64 %r57, i64* %r59
%r60 = lshr i640 %r56, 64
%r62 = getelementptr i64, i64* %r2, i32 7
%r63 = load i64, i64* %r62
%r64 = call i640 @mulPv576x64(i64* %r2, i64 %r63)
%r65 = add i640 %r60, %r64
%r66 = trunc i640 %r65 to i64
%r68 = getelementptr i64, i64* %r1, i32 7
store i64 %r66, i64* %r68
%r69 = lshr i640 %r65, 64
%r71 = getelementptr i64, i64* %r2, i32 8
%r72 = load i64, i64* %r71
%r73 = call i640 @mulPv576x64(i64* %r2, i64 %r72)
%r74 = add i640 %r69, %r73
%r76 = getelementptr i64, i64* %r1, i32 8
%r77 = trunc i640 %r74 to i64
%r79 = getelementptr i64, i64* %r76, i32 0
store i64 %r77, i64* %r79
%r80 = lshr i640 %r74, 64
%r81 = trunc i640 %r80 to i64
%r83 = getelementptr i64, i64* %r76, i32 1
store i64 %r81, i64* %r83
%r84 = lshr i640 %r80, 64
%r85 = trunc i640 %r84 to i64
%r87 = getelementptr i64, i64* %r76, i32 2
store i64 %r85, i64* %r87
%r88 = lshr i640 %r84, 64
%r89 = trunc i640 %r88 to i64
%r91 = getelementptr i64, i64* %r76, i32 3
store i64 %r89, i64* %r91
%r92 = lshr i640 %r88, 64
%r93 = trunc i640 %r92 to i64
%r95 = getelementptr i64, i64* %r76, i32 4
store i64 %r93, i64* %r95
%r96 = lshr i640 %r92, 64
%r97 = trunc i640 %r96 to i64
%r99 = getelementptr i64, i64* %r76, i32 5
store i64 %r97, i64* %r99
%r100 = lshr i640 %r96, 64
%r101 = trunc i640 %r100 to i64
%r103 = getelementptr i64, i64* %r76, i32 6
store i64 %r101, i64* %r103
%r104 = lshr i640 %r100, 64
%r105 = trunc i640 %r104 to i64
%r107 = getelementptr i64, i64* %r76, i32 7
store i64 %r105, i64* %r107
%r108 = lshr i640 %r104, 64
%r109 = trunc i640 %r108 to i64
%r111 = getelementptr i64, i64* %r76, i32 8
store i64 %r109, i64* %r111
%r112 = lshr i640 %r108, 64
%r113 = trunc i640 %r112 to i64
%r115 = getelementptr i64, i64* %r76, i32 9
store i64 %r113, i64* %r115
ret void
}
define void @mcl_fp_mont9L(i64* %r1, i64* %r2, i64* %r3, i64* %r4)
{
%r6 = getelementptr i64, i64* %r4, i32 -1
%r7 = load i64, i64* %r6
%r9 = getelementptr i64, i64* %r3, i32 0
%r10 = load i64, i64* %r9
%r11 = call i640 @mulPv576x64(i64* %r2, i64 %r10)
%r12 = zext i640 %r11 to i704
%r13 = trunc i640 %r11 to i64
%r14 = mul i64 %r13, %r7
%r15 = call i640 @mulPv576x64(i64* %r4, i64 %r14)
%r16 = zext i640 %r15 to i704
%r17 = add i704 %r12, %r16
%r18 = lshr i704 %r17, 64
%r20 = getelementptr i64, i64* %r3, i32 1
%r21 = load i64, i64* %r20
%r22 = call i640 @mulPv576x64(i64* %r2, i64 %r21)
%r23 = zext i640 %r22 to i704
%r24 = add i704 %r18, %r23
%r25 = trunc i704 %r24 to i64
%r26 = mul i64 %r25, %r7
%r27 = call i640 @mulPv576x64(i64* %r4, i64 %r26)
%r28 = zext i640 %r27 to i704
%r29 = add i704 %r24, %r28
%r30 = lshr i704 %r29, 64
%r32 = getelementptr i64, i64* %r3, i32 2
%r33 = load i64, i64* %r32
%r34 = call i640 @mulPv576x64(i64* %r2, i64 %r33)
%r35 = zext i640 %r34 to i704
%r36 = add i704 %r30, %r35
%r37 = trunc i704 %r36 to i64
%r38 = mul i64 %r37, %r7
%r39 = call i640 @mulPv576x64(i64* %r4, i64 %r38)
%r40 = zext i640 %r39 to i704
%r41 = add i704 %r36, %r40
%r42 = lshr i704 %r41, 64
%r44 = getelementptr i64, i64* %r3, i32 3
%r45 = load i64, i64* %r44
%r46 = call i640 @mulPv576x64(i64* %r2, i64 %r45)
%r47 = zext i640 %r46 to i704
%r48 = add i704 %r42, %r47
%r49 = trunc i704 %r48 to i64
%r50 = mul i64 %r49, %r7
%r51 = call i640 @mulPv576x64(i64* %r4, i64 %r50)
%r52 = zext i640 %r51 to i704
%r53 = add i704 %r48, %r52
%r54 = lshr i704 %r53, 64
%r56 = getelementptr i64, i64* %r3, i32 4
%r57 = load i64, i64* %r56
%r58 = call i640 @mulPv576x64(i64* %r2, i64 %r57)
%r59 = zext i640 %r58 to i704
%r60 = add i704 %r54, %r59
%r61 = trunc i704 %r60 to i64
%r62 = mul i64 %r61, %r7
%r63 = call i640 @mulPv576x64(i64* %r4, i64 %r62)
%r64 = zext i640 %r63 to i704
%r65 = add i704 %r60, %r64
%r66 = lshr i704 %r65, 64
%r68 = getelementptr i64, i64* %r3, i32 5
%r69 = load i64, i64* %r68
%r70 = call i640 @mulPv576x64(i64* %r2, i64 %r69)
%r71 = zext i640 %r70 to i704
%r72 = add i704 %r66, %r71
%r73 = trunc i704 %r72 to i64
%r74 = mul i64 %r73, %r7
%r75 = call i640 @mulPv576x64(i64* %r4, i64 %r74)
%r76 = zext i640 %r75 to i704
%r77 = add i704 %r72, %r76
%r78 = lshr i704 %r77, 64
%r80 = getelementptr i64, i64* %r3, i32 6
%r81 = load i64, i64* %r80
%r82 = call i640 @mulPv576x64(i64* %r2, i64 %r81)
%r83 = zext i640 %r82 to i704
%r84 = add i704 %r78, %r83
%r85 = trunc i704 %r84 to i64
%r86 = mul i64 %r85, %r7
%r87 = call i640 @mulPv576x64(i64* %r4, i64 %r86)
%r88 = zext i640 %r87 to i704
%r89 = add i704 %r84, %r88
%r90 = lshr i704 %r89, 64
%r92 = getelementptr i64, i64* %r3, i32 7
%r93 = load i64, i64* %r92
%r94 = call i640 @mulPv576x64(i64* %r2, i64 %r93)
%r95 = zext i640 %r94 to i704
%r96 = add i704 %r90, %r95
%r97 = trunc i704 %r96 to i64
%r98 = mul i64 %r97, %r7
%r99 = call i640 @mulPv576x64(i64* %r4, i64 %r98)
%r100 = zext i640 %r99 to i704
%r101 = add i704 %r96, %r100
%r102 = lshr i704 %r101, 64
%r104 = getelementptr i64, i64* %r3, i32 8
%r105 = load i64, i64* %r104
%r106 = call i640 @mulPv576x64(i64* %r2, i64 %r105)
%r107 = zext i640 %r106 to i704
%r108 = add i704 %r102, %r107
%r109 = trunc i704 %r108 to i64
%r110 = mul i64 %r109, %r7
%r111 = call i640 @mulPv576x64(i64* %r4, i64 %r110)
%r112 = zext i640 %r111 to i704
%r113 = add i704 %r108, %r112
%r114 = lshr i704 %r113, 64
%r115 = trunc i704 %r114 to i640
%r116 = load i64, i64* %r4
%r117 = zext i64 %r116 to i128
%r119 = getelementptr i64, i64* %r4, i32 1
%r120 = load i64, i64* %r119
%r121 = zext i64 %r120 to i128
%r122 = shl i128 %r121, 64
%r123 = or i128 %r117, %r122
%r124 = zext i128 %r123 to i192
%r126 = getelementptr i64, i64* %r4, i32 2
%r127 = load i64, i64* %r126
%r128 = zext i64 %r127 to i192
%r129 = shl i192 %r128, 128
%r130 = or i192 %r124, %r129
%r131 = zext i192 %r130 to i256
%r133 = getelementptr i64, i64* %r4, i32 3
%r134 = load i64, i64* %r133
%r135 = zext i64 %r134 to i256
%r136 = shl i256 %r135, 192
%r137 = or i256 %r131, %r136
%r138 = zext i256 %r137 to i320
%r140 = getelementptr i64, i64* %r4, i32 4
%r141 = load i64, i64* %r140
%r142 = zext i64 %r141 to i320
%r143 = shl i320 %r142, 256
%r144 = or i320 %r138, %r143
%r145 = zext i320 %r144 to i384
%r147 = getelementptr i64, i64* %r4, i32 5
%r148 = load i64, i64* %r147
%r149 = zext i64 %r148 to i384
%r150 = shl i384 %r149, 320
%r151 = or i384 %r145, %r150
%r152 = zext i384 %r151 to i448
%r154 = getelementptr i64, i64* %r4, i32 6
%r155 = load i64, i64* %r154
%r156 = zext i64 %r155 to i448
%r157 = shl i448 %r156, 384
%r158 = or i448 %r152, %r157
%r159 = zext i448 %r158 to i512
%r161 = getelementptr i64, i64* %r4, i32 7
%r162 = load i64, i64* %r161
%r163 = zext i64 %r162 to i512
%r164 = shl i512 %r163, 448
%r165 = or i512 %r159, %r164
%r166 = zext i512 %r165 to i576
%r168 = getelementptr i64, i64* %r4, i32 8
%r169 = load i64, i64* %r168
%r170 = zext i64 %r169 to i576
%r171 = shl i576 %r170, 512
%r172 = or i576 %r166, %r171
%r173 = zext i576 %r172 to i640
%r174 = sub i640 %r115, %r173
%r175 = lshr i640 %r174, 576
%r176 = trunc i640 %r175 to i1
%r177 = select i1 %r176, i640 %r115, i640 %r174
%r178 = trunc i640 %r177 to i576
%r179 = trunc i576 %r178 to i64
%r181 = getelementptr i64, i64* %r1, i32 0
store i64 %r179, i64* %r181
%r182 = lshr i576 %r178, 64
%r183 = trunc i576 %r182 to i64
%r185 = getelementptr i64, i64* %r1, i32 1
store i64 %r183, i64* %r185
%r186 = lshr i576 %r182, 64
%r187 = trunc i576 %r186 to i64
%r189 = getelementptr i64, i64* %r1, i32 2
store i64 %r187, i64* %r189
%r190 = lshr i576 %r186, 64
%r191 = trunc i576 %r190 to i64
%r193 = getelementptr i64, i64* %r1, i32 3
store i64 %r191, i64* %r193
%r194 = lshr i576 %r190, 64
%r195 = trunc i576 %r194 to i64
%r197 = getelementptr i64, i64* %r1, i32 4
store i64 %r195, i64* %r197
%r198 = lshr i576 %r194, 64
%r199 = trunc i576 %r198 to i64
%r201 = getelementptr i64, i64* %r1, i32 5
store i64 %r199, i64* %r201
%r202 = lshr i576 %r198, 64
%r203 = trunc i576 %r202 to i64
%r205 = getelementptr i64, i64* %r1, i32 6
store i64 %r203, i64* %r205
%r206 = lshr i576 %r202, 64
%r207 = trunc i576 %r206 to i64
%r209 = getelementptr i64, i64* %r1, i32 7
store i64 %r207, i64* %r209
%r210 = lshr i576 %r206, 64
%r211 = trunc i576 %r210 to i64
%r213 = getelementptr i64, i64* %r1, i32 8
store i64 %r211, i64* %r213
ret void
}
define void @mcl_fp_montNF9L(i64* %r1, i64* %r2, i64* %r3, i64* %r4)
{
%r6 = getelementptr i64, i64* %r4, i32 -1
%r7 = load i64, i64* %r6
%r8 = load i64, i64* %r3
%r9 = call i640 @mulPv576x64(i64* %r2, i64 %r8)
%r10 = trunc i640 %r9 to i64
%r11 = mul i64 %r10, %r7
%r12 = call i640 @mulPv576x64(i64* %r4, i64 %r11)
%r13 = add i640 %r9, %r12
%r14 = lshr i640 %r13, 64
%r16 = getelementptr i64, i64* %r3, i32 1
%r17 = load i64, i64* %r16
%r18 = call i640 @mulPv576x64(i64* %r2, i64 %r17)
%r19 = add i640 %r14, %r18
%r20 = trunc i640 %r19 to i64
%r21 = mul i64 %r20, %r7
%r22 = call i640 @mulPv576x64(i64* %r4, i64 %r21)
%r23 = add i640 %r19, %r22
%r24 = lshr i640 %r23, 64
%r26 = getelementptr i64, i64* %r3, i32 2
%r27 = load i64, i64* %r26
%r28 = call i640 @mulPv576x64(i64* %r2, i64 %r27)
%r29 = add i640 %r24, %r28
%r30 = trunc i640 %r29 to i64
%r31 = mul i64 %r30, %r7
%r32 = call i640 @mulPv576x64(i64* %r4, i64 %r31)
%r33 = add i640 %r29, %r32
%r34 = lshr i640 %r33, 64
%r36 = getelementptr i64, i64* %r3, i32 3
%r37 = load i64, i64* %r36
%r38 = call i640 @mulPv576x64(i64* %r2, i64 %r37)
%r39 = add i640 %r34, %r38
%r40 = trunc i640 %r39 to i64
%r41 = mul i64 %r40, %r7
%r42 = call i640 @mulPv576x64(i64* %r4, i64 %r41)
%r43 = add i640 %r39, %r42
%r44 = lshr i640 %r43, 64
%r46 = getelementptr i64, i64* %r3, i32 4
%r47 = load i64, i64* %r46
%r48 = call i640 @mulPv576x64(i64* %r2, i64 %r47)
%r49 = add i640 %r44, %r48
%r50 = trunc i640 %r49 to i64
%r51 = mul i64 %r50, %r7
%r52 = call i640 @mulPv576x64(i64* %r4, i64 %r51)
%r53 = add i640 %r49, %r52
%r54 = lshr i640 %r53, 64
%r56 = getelementptr i64, i64* %r3, i32 5
%r57 = load i64, i64* %r56
%r58 = call i640 @mulPv576x64(i64* %r2, i64 %r57)
%r59 = add i640 %r54, %r58
%r60 = trunc i640 %r59 to i64
%r61 = mul i64 %r60, %r7
%r62 = call i640 @mulPv576x64(i64* %r4, i64 %r61)
%r63 = add i640 %r59, %r62
%r64 = lshr i640 %r63, 64
%r66 = getelementptr i64, i64* %r3, i32 6
%r67 = load i64, i64* %r66
%r68 = call i640 @mulPv576x64(i64* %r2, i64 %r67)
%r69 = add i640 %r64, %r68
%r70 = trunc i640 %r69 to i64
%r71 = mul i64 %r70, %r7
%r72 = call i640 @mulPv576x64(i64* %r4, i64 %r71)
%r73 = add i640 %r69, %r72
%r74 = lshr i640 %r73, 64
%r76 = getelementptr i64, i64* %r3, i32 7
%r77 = load i64, i64* %r76
%r78 = call i640 @mulPv576x64(i64* %r2, i64 %r77)
%r79 = add i640 %r74, %r78
%r80 = trunc i640 %r79 to i64
%r81 = mul i64 %r80, %r7
%r82 = call i640 @mulPv576x64(i64* %r4, i64 %r81)
%r83 = add i640 %r79, %r82
%r84 = lshr i640 %r83, 64
%r86 = getelementptr i64, i64* %r3, i32 8
%r87 = load i64, i64* %r86
%r88 = call i640 @mulPv576x64(i64* %r2, i64 %r87)
%r89 = add i640 %r84, %r88
%r90 = trunc i640 %r89 to i64
%r91 = mul i64 %r90, %r7
%r92 = call i640 @mulPv576x64(i64* %r4, i64 %r91)
%r93 = add i640 %r89, %r92
%r94 = lshr i640 %r93, 64
%r95 = trunc i640 %r94 to i576
%r96 = load i64, i64* %r4
%r97 = zext i64 %r96 to i128
%r99 = getelementptr i64, i64* %r4, i32 1
%r100 = load i64, i64* %r99
%r101 = zext i64 %r100 to i128
%r102 = shl i128 %r101, 64
%r103 = or i128 %r97, %r102
%r104 = zext i128 %r103 to i192
%r106 = getelementptr i64, i64* %r4, i32 2
%r107 = load i64, i64* %r106
%r108 = zext i64 %r107 to i192
%r109 = shl i192 %r108, 128
%r110 = or i192 %r104, %r109
%r111 = zext i192 %r110 to i256
%r113 = getelementptr i64, i64* %r4, i32 3
%r114 = load i64, i64* %r113
%r115 = zext i64 %r114 to i256
%r116 = shl i256 %r115, 192
%r117 = or i256 %r111, %r116
%r118 = zext i256 %r117 to i320
%r120 = getelementptr i64, i64* %r4, i32 4
%r121 = load i64, i64* %r120
%r122 = zext i64 %r121 to i320
%r123 = shl i320 %r122, 256
%r124 = or i320 %r118, %r123
%r125 = zext i320 %r124 to i384
%r127 = getelementptr i64, i64* %r4, i32 5
%r128 = load i64, i64* %r127
%r129 = zext i64 %r128 to i384
%r130 = shl i384 %r129, 320
%r131 = or i384 %r125, %r130
%r132 = zext i384 %r131 to i448
%r134 = getelementptr i64, i64* %r4, i32 6
%r135 = load i64, i64* %r134
%r136 = zext i64 %r135 to i448
%r137 = shl i448 %r136, 384
%r138 = or i448 %r132, %r137
%r139 = zext i448 %r138 to i512
%r141 = getelementptr i64, i64* %r4, i32 7
%r142 = load i64, i64* %r141
%r143 = zext i64 %r142 to i512
%r144 = shl i512 %r143, 448
%r145 = or i512 %r139, %r144
%r146 = zext i512 %r145 to i576
%r148 = getelementptr i64, i64* %r4, i32 8
%r149 = load i64, i64* %r148
%r150 = zext i64 %r149 to i576
%r151 = shl i576 %r150, 512
%r152 = or i576 %r146, %r151
%r153 = sub i576 %r95, %r152
%r154 = lshr i576 %r153, 575
%r155 = trunc i576 %r154 to i1
%r156 = select i1 %r155, i576 %r95, i576 %r153
%r157 = trunc i576 %r156 to i64
%r159 = getelementptr i64, i64* %r1, i32 0
store i64 %r157, i64* %r159
%r160 = lshr i576 %r156, 64
%r161 = trunc i576 %r160 to i64
%r163 = getelementptr i64, i64* %r1, i32 1
store i64 %r161, i64* %r163
%r164 = lshr i576 %r160, 64
%r165 = trunc i576 %r164 to i64
%r167 = getelementptr i64, i64* %r1, i32 2
store i64 %r165, i64* %r167
%r168 = lshr i576 %r164, 64
%r169 = trunc i576 %r168 to i64
%r171 = getelementptr i64, i64* %r1, i32 3
store i64 %r169, i64* %r171
%r172 = lshr i576 %r168, 64
%r173 = trunc i576 %r172 to i64
%r175 = getelementptr i64, i64* %r1, i32 4
store i64 %r173, i64* %r175
%r176 = lshr i576 %r172, 64
%r177 = trunc i576 %r176 to i64
%r179 = getelementptr i64, i64* %r1, i32 5
store i64 %r177, i64* %r179
%r180 = lshr i576 %r176, 64
%r181 = trunc i576 %r180 to i64
%r183 = getelementptr i64, i64* %r1, i32 6
store i64 %r181, i64* %r183
%r184 = lshr i576 %r180, 64
%r185 = trunc i576 %r184 to i64
%r187 = getelementptr i64, i64* %r1, i32 7
store i64 %r185, i64* %r187
%r188 = lshr i576 %r184, 64
%r189 = trunc i576 %r188 to i64
%r191 = getelementptr i64, i64* %r1, i32 8
store i64 %r189, i64* %r191
ret void
}
define void @mcl_fp_montRed9L(i64* noalias  %r1, i64* noalias  %r2, i64* noalias  %r3)
{
%r5 = getelementptr i64, i64* %r3, i32 -1
%r6 = load i64, i64* %r5
%r7 = load i64, i64* %r3
%r8 = zext i64 %r7 to i128
%r10 = getelementptr i64, i64* %r3, i32 1
%r11 = load i64, i64* %r10
%r12 = zext i64 %r11 to i128
%r13 = shl i128 %r12, 64
%r14 = or i128 %r8, %r13
%r15 = zext i128 %r14 to i192
%r17 = getelementptr i64, i64* %r3, i32 2
%r18 = load i64, i64* %r17
%r19 = zext i64 %r18 to i192
%r20 = shl i192 %r19, 128
%r21 = or i192 %r15, %r20
%r22 = zext i192 %r21 to i256
%r24 = getelementptr i64, i64* %r3, i32 3
%r25 = load i64, i64* %r24
%r26 = zext i64 %r25 to i256
%r27 = shl i256 %r26, 192
%r28 = or i256 %r22, %r27
%r29 = zext i256 %r28 to i320
%r31 = getelementptr i64, i64* %r3, i32 4
%r32 = load i64, i64* %r31
%r33 = zext i64 %r32 to i320
%r34 = shl i320 %r33, 256
%r35 = or i320 %r29, %r34
%r36 = zext i320 %r35 to i384
%r38 = getelementptr i64, i64* %r3, i32 5
%r39 = load i64, i64* %r38
%r40 = zext i64 %r39 to i384
%r41 = shl i384 %r40, 320
%r42 = or i384 %r36, %r41
%r43 = zext i384 %r42 to i448
%r45 = getelementptr i64, i64* %r3, i32 6
%r46 = load i64, i64* %r45
%r47 = zext i64 %r46 to i448
%r48 = shl i448 %r47, 384
%r49 = or i448 %r43, %r48
%r50 = zext i448 %r49 to i512
%r52 = getelementptr i64, i64* %r3, i32 7
%r53 = load i64, i64* %r52
%r54 = zext i64 %r53 to i512
%r55 = shl i512 %r54, 448
%r56 = or i512 %r50, %r55
%r57 = zext i512 %r56 to i576
%r59 = getelementptr i64, i64* %r3, i32 8
%r60 = load i64, i64* %r59
%r61 = zext i64 %r60 to i576
%r62 = shl i576 %r61, 512
%r63 = or i576 %r57, %r62
%r64 = load i64, i64* %r2
%r65 = zext i64 %r64 to i128
%r67 = getelementptr i64, i64* %r2, i32 1
%r68 = load i64, i64* %r67
%r69 = zext i64 %r68 to i128
%r70 = shl i128 %r69, 64
%r71 = or i128 %r65, %r70
%r72 = zext i128 %r71 to i192
%r74 = getelementptr i64, i64* %r2, i32 2
%r75 = load i64, i64* %r74
%r76 = zext i64 %r75 to i192
%r77 = shl i192 %r76, 128
%r78 = or i192 %r72, %r77
%r79 = zext i192 %r78 to i256
%r81 = getelementptr i64, i64* %r2, i32 3
%r82 = load i64, i64* %r81
%r83 = zext i64 %r82 to i256
%r84 = shl i256 %r83, 192
%r85 = or i256 %r79, %r84
%r86 = zext i256 %r85 to i320
%r88 = getelementptr i64, i64* %r2, i32 4
%r89 = load i64, i64* %r88
%r90 = zext i64 %r89 to i320
%r91 = shl i320 %r90, 256
%r92 = or i320 %r86, %r91
%r93 = zext i320 %r92 to i384
%r95 = getelementptr i64, i64* %r2, i32 5
%r96 = load i64, i64* %r95
%r97 = zext i64 %r96 to i384
%r98 = shl i384 %r97, 320
%r99 = or i384 %r93, %r98
%r100 = zext i384 %r99 to i448
%r102 = getelementptr i64, i64* %r2, i32 6
%r103 = load i64, i64* %r102
%r104 = zext i64 %r103 to i448
%r105 = shl i448 %r104, 384
%r106 = or i448 %r100, %r105
%r107 = zext i448 %r106 to i512
%r109 = getelementptr i64, i64* %r2, i32 7
%r110 = load i64, i64* %r109
%r111 = zext i64 %r110 to i512
%r112 = shl i512 %r111, 448
%r113 = or i512 %r107, %r112
%r114 = zext i512 %r113 to i576
%r116 = getelementptr i64, i64* %r2, i32 8
%r117 = load i64, i64* %r116
%r118 = zext i64 %r117 to i576
%r119 = shl i576 %r118, 512
%r120 = or i576 %r114, %r119
%r121 = zext i576 %r120 to i640
%r123 = getelementptr i64, i64* %r2, i32 9
%r124 = load i64, i64* %r123
%r125 = zext i64 %r124 to i640
%r126 = shl i640 %r125, 576
%r127 = or i640 %r121, %r126
%r128 = zext i640 %r127 to i704
%r130 = getelementptr i64, i64* %r2, i32 10
%r131 = load i64, i64* %r130
%r132 = zext i64 %r131 to i704
%r133 = shl i704 %r132, 640
%r134 = or i704 %r128, %r133
%r135 = zext i704 %r134 to i768
%r137 = getelementptr i64, i64* %r2, i32 11
%r138 = load i64, i64* %r137
%r139 = zext i64 %r138 to i768
%r140 = shl i768 %r139, 704
%r141 = or i768 %r135, %r140
%r142 = zext i768 %r141 to i832
%r144 = getelementptr i64, i64* %r2, i32 12
%r145 = load i64, i64* %r144
%r146 = zext i64 %r145 to i832
%r147 = shl i832 %r146, 768
%r148 = or i832 %r142, %r147
%r149 = zext i832 %r148 to i896
%r151 = getelementptr i64, i64* %r2, i32 13
%r152 = load i64, i64* %r151
%r153 = zext i64 %r152 to i896
%r154 = shl i896 %r153, 832
%r155 = or i896 %r149, %r154
%r156 = zext i896 %r155 to i960
%r158 = getelementptr i64, i64* %r2, i32 14
%r159 = load i64, i64* %r158
%r160 = zext i64 %r159 to i960
%r161 = shl i960 %r160, 896
%r162 = or i960 %r156, %r161
%r163 = zext i960 %r162 to i1024
%r165 = getelementptr i64, i64* %r2, i32 15
%r166 = load i64, i64* %r165
%r167 = zext i64 %r166 to i1024
%r168 = shl i1024 %r167, 960
%r169 = or i1024 %r163, %r168
%r170 = zext i1024 %r169 to i1088
%r172 = getelementptr i64, i64* %r2, i32 16
%r173 = load i64, i64* %r172
%r174 = zext i64 %r173 to i1088
%r175 = shl i1088 %r174, 1024
%r176 = or i1088 %r170, %r175
%r177 = zext i1088 %r176 to i1152
%r179 = getelementptr i64, i64* %r2, i32 17
%r180 = load i64, i64* %r179
%r181 = zext i64 %r180 to i1152
%r182 = shl i1152 %r181, 1088
%r183 = or i1152 %r177, %r182
%r184 = zext i1152 %r183 to i1216
%r185 = trunc i1216 %r184 to i64
%r186 = mul i64 %r185, %r6
%r187 = call i640 @mulPv576x64(i64* %r3, i64 %r186)
%r188 = zext i640 %r187 to i1216
%r189 = add i1216 %r184, %r188
%r190 = lshr i1216 %r189, 64
%r191 = trunc i1216 %r190 to i1152
%r192 = trunc i1152 %r191 to i64
%r193 = mul i64 %r192, %r6
%r194 = call i640 @mulPv576x64(i64* %r3, i64 %r193)
%r195 = zext i640 %r194 to i1152
%r196 = add i1152 %r191, %r195
%r197 = lshr i1152 %r196, 64
%r198 = trunc i1152 %r197 to i1088
%r199 = trunc i1088 %r198 to i64
%r200 = mul i64 %r199, %r6
%r201 = call i640 @mulPv576x64(i64* %r3, i64 %r200)
%r202 = zext i640 %r201 to i1088
%r203 = add i1088 %r198, %r202
%r204 = lshr i1088 %r203, 64
%r205 = trunc i1088 %r204 to i1024
%r206 = trunc i1024 %r205 to i64
%r207 = mul i64 %r206, %r6
%r208 = call i640 @mulPv576x64(i64* %r3, i64 %r207)
%r209 = zext i640 %r208 to i1024
%r210 = add i1024 %r205, %r209
%r211 = lshr i1024 %r210, 64
%r212 = trunc i1024 %r211 to i960
%r213 = trunc i960 %r212 to i64
%r214 = mul i64 %r213, %r6
%r215 = call i640 @mulPv576x64(i64* %r3, i64 %r214)
%r216 = zext i640 %r215 to i960
%r217 = add i960 %r212, %r216
%r218 = lshr i960 %r217, 64
%r219 = trunc i960 %r218 to i896
%r220 = trunc i896 %r219 to i64
%r221 = mul i64 %r220, %r6
%r222 = call i640 @mulPv576x64(i64* %r3, i64 %r221)
%r223 = zext i640 %r222 to i896
%r224 = add i896 %r219, %r223
%r225 = lshr i896 %r224, 64
%r226 = trunc i896 %r225 to i832
%r227 = trunc i832 %r226 to i64
%r228 = mul i64 %r227, %r6
%r229 = call i640 @mulPv576x64(i64* %r3, i64 %r228)
%r230 = zext i640 %r229 to i832
%r231 = add i832 %r226, %r230
%r232 = lshr i832 %r231, 64
%r233 = trunc i832 %r232 to i768
%r234 = trunc i768 %r233 to i64
%r235 = mul i64 %r234, %r6
%r236 = call i640 @mulPv576x64(i64* %r3, i64 %r235)
%r237 = zext i640 %r236 to i768
%r238 = add i768 %r233, %r237
%r239 = lshr i768 %r238, 64
%r240 = trunc i768 %r239 to i704
%r241 = trunc i704 %r240 to i64
%r242 = mul i64 %r241, %r6
%r243 = call i640 @mulPv576x64(i64* %r3, i64 %r242)
%r244 = zext i640 %r243 to i704
%r245 = add i704 %r240, %r244
%r246 = lshr i704 %r245, 64
%r247 = trunc i704 %r246 to i640
%r248 = zext i576 %r63 to i640
%r249 = sub i640 %r247, %r248
%r250 = lshr i640 %r249, 576
%r251 = trunc i640 %r250 to i1
%r252 = select i1 %r251, i640 %r247, i640 %r249
%r253 = trunc i640 %r252 to i576
%r254 = trunc i576 %r253 to i64
%r256 = getelementptr i64, i64* %r1, i32 0
store i64 %r254, i64* %r256
%r257 = lshr i576 %r253, 64
%r258 = trunc i576 %r257 to i64
%r260 = getelementptr i64, i64* %r1, i32 1
store i64 %r258, i64* %r260
%r261 = lshr i576 %r257, 64
%r262 = trunc i576 %r261 to i64
%r264 = getelementptr i64, i64* %r1, i32 2
store i64 %r262, i64* %r264
%r265 = lshr i576 %r261, 64
%r266 = trunc i576 %r265 to i64
%r268 = getelementptr i64, i64* %r1, i32 3
store i64 %r266, i64* %r268
%r269 = lshr i576 %r265, 64
%r270 = trunc i576 %r269 to i64
%r272 = getelementptr i64, i64* %r1, i32 4
store i64 %r270, i64* %r272
%r273 = lshr i576 %r269, 64
%r274 = trunc i576 %r273 to i64
%r276 = getelementptr i64, i64* %r1, i32 5
store i64 %r274, i64* %r276
%r277 = lshr i576 %r273, 64
%r278 = trunc i576 %r277 to i64
%r280 = getelementptr i64, i64* %r1, i32 6
store i64 %r278, i64* %r280
%r281 = lshr i576 %r277, 64
%r282 = trunc i576 %r281 to i64
%r284 = getelementptr i64, i64* %r1, i32 7
store i64 %r282, i64* %r284
%r285 = lshr i576 %r281, 64
%r286 = trunc i576 %r285 to i64
%r288 = getelementptr i64, i64* %r1, i32 8
store i64 %r286, i64* %r288
ret void
}
define i64 @mcl_fp_addPre9L(i64* noalias  %r2, i64* noalias  %r3, i64* noalias  %r4)
{
%r5 = load i64, i64* %r3
%r6 = zext i64 %r5 to i128
%r8 = getelementptr i64, i64* %r3, i32 1
%r9 = load i64, i64* %r8
%r10 = zext i64 %r9 to i128
%r11 = shl i128 %r10, 64
%r12 = or i128 %r6, %r11
%r13 = zext i128 %r12 to i192
%r15 = getelementptr i64, i64* %r3, i32 2
%r16 = load i64, i64* %r15
%r17 = zext i64 %r16 to i192
%r18 = shl i192 %r17, 128
%r19 = or i192 %r13, %r18
%r20 = zext i192 %r19 to i256
%r22 = getelementptr i64, i64* %r3, i32 3
%r23 = load i64, i64* %r22
%r24 = zext i64 %r23 to i256
%r25 = shl i256 %r24, 192
%r26 = or i256 %r20, %r25
%r27 = zext i256 %r26 to i320
%r29 = getelementptr i64, i64* %r3, i32 4
%r30 = load i64, i64* %r29
%r31 = zext i64 %r30 to i320
%r32 = shl i320 %r31, 256
%r33 = or i320 %r27, %r32
%r34 = zext i320 %r33 to i384
%r36 = getelementptr i64, i64* %r3, i32 5
%r37 = load i64, i64* %r36
%r38 = zext i64 %r37 to i384
%r39 = shl i384 %r38, 320
%r40 = or i384 %r34, %r39
%r41 = zext i384 %r40 to i448
%r43 = getelementptr i64, i64* %r3, i32 6
%r44 = load i64, i64* %r43
%r45 = zext i64 %r44 to i448
%r46 = shl i448 %r45, 384
%r47 = or i448 %r41, %r46
%r48 = zext i448 %r47 to i512
%r50 = getelementptr i64, i64* %r3, i32 7
%r51 = load i64, i64* %r50
%r52 = zext i64 %r51 to i512
%r53 = shl i512 %r52, 448
%r54 = or i512 %r48, %r53
%r55 = zext i512 %r54 to i576
%r57 = getelementptr i64, i64* %r3, i32 8
%r58 = load i64, i64* %r57
%r59 = zext i64 %r58 to i576
%r60 = shl i576 %r59, 512
%r61 = or i576 %r55, %r60
%r62 = zext i576 %r61 to i640
%r63 = load i64, i64* %r4
%r64 = zext i64 %r63 to i128
%r66 = getelementptr i64, i64* %r4, i32 1
%r67 = load i64, i64* %r66
%r68 = zext i64 %r67 to i128
%r69 = shl i128 %r68, 64
%r70 = or i128 %r64, %r69
%r71 = zext i128 %r70 to i192
%r73 = getelementptr i64, i64* %r4, i32 2
%r74 = load i64, i64* %r73
%r75 = zext i64 %r74 to i192
%r76 = shl i192 %r75, 128
%r77 = or i192 %r71, %r76
%r78 = zext i192 %r77 to i256
%r80 = getelementptr i64, i64* %r4, i32 3
%r81 = load i64, i64* %r80
%r82 = zext i64 %r81 to i256
%r83 = shl i256 %r82, 192
%r84 = or i256 %r78, %r83
%r85 = zext i256 %r84 to i320
%r87 = getelementptr i64, i64* %r4, i32 4
%r88 = load i64, i64* %r87
%r89 = zext i64 %r88 to i320
%r90 = shl i320 %r89, 256
%r91 = or i320 %r85, %r90
%r92 = zext i320 %r91 to i384
%r94 = getelementptr i64, i64* %r4, i32 5
%r95 = load i64, i64* %r94
%r96 = zext i64 %r95 to i384
%r97 = shl i384 %r96, 320
%r98 = or i384 %r92, %r97
%r99 = zext i384 %r98 to i448
%r101 = getelementptr i64, i64* %r4, i32 6
%r102 = load i64, i64* %r101
%r103 = zext i64 %r102 to i448
%r104 = shl i448 %r103, 384
%r105 = or i448 %r99, %r104
%r106 = zext i448 %r105 to i512
%r108 = getelementptr i64, i64* %r4, i32 7
%r109 = load i64, i64* %r108
%r110 = zext i64 %r109 to i512
%r111 = shl i512 %r110, 448
%r112 = or i512 %r106, %r111
%r113 = zext i512 %r112 to i576
%r115 = getelementptr i64, i64* %r4, i32 8
%r116 = load i64, i64* %r115
%r117 = zext i64 %r116 to i576
%r118 = shl i576 %r117, 512
%r119 = or i576 %r113, %r118
%r120 = zext i576 %r119 to i640
%r121 = add i640 %r62, %r120
%r122 = trunc i640 %r121 to i576
%r123 = trunc i576 %r122 to i64
%r125 = getelementptr i64, i64* %r2, i32 0
store i64 %r123, i64* %r125
%r126 = lshr i576 %r122, 64
%r127 = trunc i576 %r126 to i64
%r129 = getelementptr i64, i64* %r2, i32 1
store i64 %r127, i64* %r129
%r130 = lshr i576 %r126, 64
%r131 = trunc i576 %r130 to i64
%r133 = getelementptr i64, i64* %r2, i32 2
store i64 %r131, i64* %r133
%r134 = lshr i576 %r130, 64
%r135 = trunc i576 %r134 to i64
%r137 = getelementptr i64, i64* %r2, i32 3
store i64 %r135, i64* %r137
%r138 = lshr i576 %r134, 64
%r139 = trunc i576 %r138 to i64
%r141 = getelementptr i64, i64* %r2, i32 4
store i64 %r139, i64* %r141
%r142 = lshr i576 %r138, 64
%r143 = trunc i576 %r142 to i64
%r145 = getelementptr i64, i64* %r2, i32 5
store i64 %r143, i64* %r145
%r146 = lshr i576 %r142, 64
%r147 = trunc i576 %r146 to i64
%r149 = getelementptr i64, i64* %r2, i32 6
store i64 %r147, i64* %r149
%r150 = lshr i576 %r146, 64
%r151 = trunc i576 %r150 to i64
%r153 = getelementptr i64, i64* %r2, i32 7
store i64 %r151, i64* %r153
%r154 = lshr i576 %r150, 64
%r155 = trunc i576 %r154 to i64
%r157 = getelementptr i64, i64* %r2, i32 8
store i64 %r155, i64* %r157
%r158 = lshr i640 %r121, 576
%r159 = trunc i640 %r158 to i64
ret i64 %r159
}
define i64 @mcl_fp_subPre9L(i64* noalias  %r2, i64* noalias  %r3, i64* noalias  %r4)
{
%r5 = load i64, i64* %r3
%r6 = zext i64 %r5 to i128
%r8 = getelementptr i64, i64* %r3, i32 1
%r9 = load i64, i64* %r8
%r10 = zext i64 %r9 to i128
%r11 = shl i128 %r10, 64
%r12 = or i128 %r6, %r11
%r13 = zext i128 %r12 to i192
%r15 = getelementptr i64, i64* %r3, i32 2
%r16 = load i64, i64* %r15
%r17 = zext i64 %r16 to i192
%r18 = shl i192 %r17, 128
%r19 = or i192 %r13, %r18
%r20 = zext i192 %r19 to i256
%r22 = getelementptr i64, i64* %r3, i32 3
%r23 = load i64, i64* %r22
%r24 = zext i64 %r23 to i256
%r25 = shl i256 %r24, 192
%r26 = or i256 %r20, %r25
%r27 = zext i256 %r26 to i320
%r29 = getelementptr i64, i64* %r3, i32 4
%r30 = load i64, i64* %r29
%r31 = zext i64 %r30 to i320
%r32 = shl i320 %r31, 256
%r33 = or i320 %r27, %r32
%r34 = zext i320 %r33 to i384
%r36 = getelementptr i64, i64* %r3, i32 5
%r37 = load i64, i64* %r36
%r38 = zext i64 %r37 to i384
%r39 = shl i384 %r38, 320
%r40 = or i384 %r34, %r39
%r41 = zext i384 %r40 to i448
%r43 = getelementptr i64, i64* %r3, i32 6
%r44 = load i64, i64* %r43
%r45 = zext i64 %r44 to i448
%r46 = shl i448 %r45, 384
%r47 = or i448 %r41, %r46
%r48 = zext i448 %r47 to i512
%r50 = getelementptr i64, i64* %r3, i32 7
%r51 = load i64, i64* %r50
%r52 = zext i64 %r51 to i512
%r53 = shl i512 %r52, 448
%r54 = or i512 %r48, %r53
%r55 = zext i512 %r54 to i576
%r57 = getelementptr i64, i64* %r3, i32 8
%r58 = load i64, i64* %r57
%r59 = zext i64 %r58 to i576
%r60 = shl i576 %r59, 512
%r61 = or i576 %r55, %r60
%r62 = zext i576 %r61 to i640
%r63 = load i64, i64* %r4
%r64 = zext i64 %r63 to i128
%r66 = getelementptr i64, i64* %r4, i32 1
%r67 = load i64, i64* %r66
%r68 = zext i64 %r67 to i128
%r69 = shl i128 %r68, 64
%r70 = or i128 %r64, %r69
%r71 = zext i128 %r70 to i192
%r73 = getelementptr i64, i64* %r4, i32 2
%r74 = load i64, i64* %r73
%r75 = zext i64 %r74 to i192
%r76 = shl i192 %r75, 128
%r77 = or i192 %r71, %r76
%r78 = zext i192 %r77 to i256
%r80 = getelementptr i64, i64* %r4, i32 3
%r81 = load i64, i64* %r80
%r82 = zext i64 %r81 to i256
%r83 = shl i256 %r82, 192
%r84 = or i256 %r78, %r83
%r85 = zext i256 %r84 to i320
%r87 = getelementptr i64, i64* %r4, i32 4
%r88 = load i64, i64* %r87
%r89 = zext i64 %r88 to i320
%r90 = shl i320 %r89, 256
%r91 = or i320 %r85, %r90
%r92 = zext i320 %r91 to i384
%r94 = getelementptr i64, i64* %r4, i32 5
%r95 = load i64, i64* %r94
%r96 = zext i64 %r95 to i384
%r97 = shl i384 %r96, 320
%r98 = or i384 %r92, %r97
%r99 = zext i384 %r98 to i448
%r101 = getelementptr i64, i64* %r4, i32 6
%r102 = load i64, i64* %r101
%r103 = zext i64 %r102 to i448
%r104 = shl i448 %r103, 384
%r105 = or i448 %r99, %r104
%r106 = zext i448 %r105 to i512
%r108 = getelementptr i64, i64* %r4, i32 7
%r109 = load i64, i64* %r108
%r110 = zext i64 %r109 to i512
%r111 = shl i512 %r110, 448
%r112 = or i512 %r106, %r111
%r113 = zext i512 %r112 to i576
%r115 = getelementptr i64, i64* %r4, i32 8
%r116 = load i64, i64* %r115
%r117 = zext i64 %r116 to i576
%r118 = shl i576 %r117, 512
%r119 = or i576 %r113, %r118
%r120 = zext i576 %r119 to i640
%r121 = sub i640 %r62, %r120
%r122 = trunc i640 %r121 to i576
%r123 = trunc i576 %r122 to i64
%r125 = getelementptr i64, i64* %r2, i32 0
store i64 %r123, i64* %r125
%r126 = lshr i576 %r122, 64
%r127 = trunc i576 %r126 to i64
%r129 = getelementptr i64, i64* %r2, i32 1
store i64 %r127, i64* %r129
%r130 = lshr i576 %r126, 64
%r131 = trunc i576 %r130 to i64
%r133 = getelementptr i64, i64* %r2, i32 2
store i64 %r131, i64* %r133
%r134 = lshr i576 %r130, 64
%r135 = trunc i576 %r134 to i64
%r137 = getelementptr i64, i64* %r2, i32 3
store i64 %r135, i64* %r137
%r138 = lshr i576 %r134, 64
%r139 = trunc i576 %r138 to i64
%r141 = getelementptr i64, i64* %r2, i32 4
store i64 %r139, i64* %r141
%r142 = lshr i576 %r138, 64
%r143 = trunc i576 %r142 to i64
%r145 = getelementptr i64, i64* %r2, i32 5
store i64 %r143, i64* %r145
%r146 = lshr i576 %r142, 64
%r147 = trunc i576 %r146 to i64
%r149 = getelementptr i64, i64* %r2, i32 6
store i64 %r147, i64* %r149
%r150 = lshr i576 %r146, 64
%r151 = trunc i576 %r150 to i64
%r153 = getelementptr i64, i64* %r2, i32 7
store i64 %r151, i64* %r153
%r154 = lshr i576 %r150, 64
%r155 = trunc i576 %r154 to i64
%r157 = getelementptr i64, i64* %r2, i32 8
store i64 %r155, i64* %r157
%r158 = lshr i640 %r121, 576
%r159 = trunc i640 %r158 to i64
%r161 = and i64 %r159, 1
ret i64 %r161
}
define void @mcl_fp_shr1_9L(i64* noalias  %r1, i64* noalias  %r2)
{
%r3 = load i64, i64* %r2
%r4 = zext i64 %r3 to i128
%r6 = getelementptr i64, i64* %r2, i32 1
%r7 = load i64, i64* %r6
%r8 = zext i64 %r7 to i128
%r9 = shl i128 %r8, 64
%r10 = or i128 %r4, %r9
%r11 = zext i128 %r10 to i192
%r13 = getelementptr i64, i64* %r2, i32 2
%r14 = load i64, i64* %r13
%r15 = zext i64 %r14 to i192
%r16 = shl i192 %r15, 128
%r17 = or i192 %r11, %r16
%r18 = zext i192 %r17 to i256
%r20 = getelementptr i64, i64* %r2, i32 3
%r21 = load i64, i64* %r20
%r22 = zext i64 %r21 to i256
%r23 = shl i256 %r22, 192
%r24 = or i256 %r18, %r23
%r25 = zext i256 %r24 to i320
%r27 = getelementptr i64, i64* %r2, i32 4
%r28 = load i64, i64* %r27
%r29 = zext i64 %r28 to i320
%r30 = shl i320 %r29, 256
%r31 = or i320 %r25, %r30
%r32 = zext i320 %r31 to i384
%r34 = getelementptr i64, i64* %r2, i32 5
%r35 = load i64, i64* %r34
%r36 = zext i64 %r35 to i384
%r37 = shl i384 %r36, 320
%r38 = or i384 %r32, %r37
%r39 = zext i384 %r38 to i448
%r41 = getelementptr i64, i64* %r2, i32 6
%r42 = load i64, i64* %r41
%r43 = zext i64 %r42 to i448
%r44 = shl i448 %r43, 384
%r45 = or i448 %r39, %r44
%r46 = zext i448 %r45 to i512
%r48 = getelementptr i64, i64* %r2, i32 7
%r49 = load i64, i64* %r48
%r50 = zext i64 %r49 to i512
%r51 = shl i512 %r50, 448
%r52 = or i512 %r46, %r51
%r53 = zext i512 %r52 to i576
%r55 = getelementptr i64, i64* %r2, i32 8
%r56 = load i64, i64* %r55
%r57 = zext i64 %r56 to i576
%r58 = shl i576 %r57, 512
%r59 = or i576 %r53, %r58
%r60 = lshr i576 %r59, 1
%r61 = trunc i576 %r60 to i64
%r63 = getelementptr i64, i64* %r1, i32 0
store i64 %r61, i64* %r63
%r64 = lshr i576 %r60, 64
%r65 = trunc i576 %r64 to i64
%r67 = getelementptr i64, i64* %r1, i32 1
store i64 %r65, i64* %r67
%r68 = lshr i576 %r64, 64
%r69 = trunc i576 %r68 to i64
%r71 = getelementptr i64, i64* %r1, i32 2
store i64 %r69, i64* %r71
%r72 = lshr i576 %r68, 64
%r73 = trunc i576 %r72 to i64
%r75 = getelementptr i64, i64* %r1, i32 3
store i64 %r73, i64* %r75
%r76 = lshr i576 %r72, 64
%r77 = trunc i576 %r76 to i64
%r79 = getelementptr i64, i64* %r1, i32 4
store i64 %r77, i64* %r79
%r80 = lshr i576 %r76, 64
%r81 = trunc i576 %r80 to i64
%r83 = getelementptr i64, i64* %r1, i32 5
store i64 %r81, i64* %r83
%r84 = lshr i576 %r80, 64
%r85 = trunc i576 %r84 to i64
%r87 = getelementptr i64, i64* %r1, i32 6
store i64 %r85, i64* %r87
%r88 = lshr i576 %r84, 64
%r89 = trunc i576 %r88 to i64
%r91 = getelementptr i64, i64* %r1, i32 7
store i64 %r89, i64* %r91
%r92 = lshr i576 %r88, 64
%r93 = trunc i576 %r92 to i64
%r95 = getelementptr i64, i64* %r1, i32 8
store i64 %r93, i64* %r95
ret void
}
define void @mcl_fp_add9L(i64* noalias  %r1, i64* noalias  %r2, i64* noalias  %r3, i64* noalias  %r4)
{
%r5 = load i64, i64* %r2
%r6 = zext i64 %r5 to i128
%r8 = getelementptr i64, i64* %r2, i32 1
%r9 = load i64, i64* %r8
%r10 = zext i64 %r9 to i128
%r11 = shl i128 %r10, 64
%r12 = or i128 %r6, %r11
%r13 = zext i128 %r12 to i192
%r15 = getelementptr i64, i64* %r2, i32 2
%r16 = load i64, i64* %r15
%r17 = zext i64 %r16 to i192
%r18 = shl i192 %r17, 128
%r19 = or i192 %r13, %r18
%r20 = zext i192 %r19 to i256
%r22 = getelementptr i64, i64* %r2, i32 3
%r23 = load i64, i64* %r22
%r24 = zext i64 %r23 to i256
%r25 = shl i256 %r24, 192
%r26 = or i256 %r20, %r25
%r27 = zext i256 %r26 to i320
%r29 = getelementptr i64, i64* %r2, i32 4
%r30 = load i64, i64* %r29
%r31 = zext i64 %r30 to i320
%r32 = shl i320 %r31, 256
%r33 = or i320 %r27, %r32
%r34 = zext i320 %r33 to i384
%r36 = getelementptr i64, i64* %r2, i32 5
%r37 = load i64, i64* %r36
%r38 = zext i64 %r37 to i384
%r39 = shl i384 %r38, 320
%r40 = or i384 %r34, %r39
%r41 = zext i384 %r40 to i448
%r43 = getelementptr i64, i64* %r2, i32 6
%r44 = load i64, i64* %r43
%r45 = zext i64 %r44 to i448
%r46 = shl i448 %r45, 384
%r47 = or i448 %r41, %r46
%r48 = zext i448 %r47 to i512
%r50 = getelementptr i64, i64* %r2, i32 7
%r51 = load i64, i64* %r50
%r52 = zext i64 %r51 to i512
%r53 = shl i512 %r52, 448
%r54 = or i512 %r48, %r53
%r55 = zext i512 %r54 to i576
%r57 = getelementptr i64, i64* %r2, i32 8
%r58 = load i64, i64* %r57
%r59 = zext i64 %r58 to i576
%r60 = shl i576 %r59, 512
%r61 = or i576 %r55, %r60
%r62 = load i64, i64* %r3
%r63 = zext i64 %r62 to i128
%r65 = getelementptr i64, i64* %r3, i32 1
%r66 = load i64, i64* %r65
%r67 = zext i64 %r66 to i128
%r68 = shl i128 %r67, 64
%r69 = or i128 %r63, %r68
%r70 = zext i128 %r69 to i192
%r72 = getelementptr i64, i64* %r3, i32 2
%r73 = load i64, i64* %r72
%r74 = zext i64 %r73 to i192
%r75 = shl i192 %r74, 128
%r76 = or i192 %r70, %r75
%r77 = zext i192 %r76 to i256
%r79 = getelementptr i64, i64* %r3, i32 3
%r80 = load i64, i64* %r79
%r81 = zext i64 %r80 to i256
%r82 = shl i256 %r81, 192
%r83 = or i256 %r77, %r82
%r84 = zext i256 %r83 to i320
%r86 = getelementptr i64, i64* %r3, i32 4
%r87 = load i64, i64* %r86
%r88 = zext i64 %r87 to i320
%r89 = shl i320 %r88, 256
%r90 = or i320 %r84, %r89
%r91 = zext i320 %r90 to i384
%r93 = getelementptr i64, i64* %r3, i32 5
%r94 = load i64, i64* %r93
%r95 = zext i64 %r94 to i384
%r96 = shl i384 %r95, 320
%r97 = or i384 %r91, %r96
%r98 = zext i384 %r97 to i448
%r100 = getelementptr i64, i64* %r3, i32 6
%r101 = load i64, i64* %r100
%r102 = zext i64 %r101 to i448
%r103 = shl i448 %r102, 384
%r104 = or i448 %r98, %r103
%r105 = zext i448 %r104 to i512
%r107 = getelementptr i64, i64* %r3, i32 7
%r108 = load i64, i64* %r107
%r109 = zext i64 %r108 to i512
%r110 = shl i512 %r109, 448
%r111 = or i512 %r105, %r110
%r112 = zext i512 %r111 to i576
%r114 = getelementptr i64, i64* %r3, i32 8
%r115 = load i64, i64* %r114
%r116 = zext i64 %r115 to i576
%r117 = shl i576 %r116, 512
%r118 = or i576 %r112, %r117
%r119 = zext i576 %r61 to i640
%r120 = zext i576 %r118 to i640
%r121 = add i640 %r119, %r120
%r122 = trunc i640 %r121 to i576
%r123 = trunc i576 %r122 to i64
%r125 = getelementptr i64, i64* %r1, i32 0
store i64 %r123, i64* %r125
%r126 = lshr i576 %r122, 64
%r127 = trunc i576 %r126 to i64
%r129 = getelementptr i64, i64* %r1, i32 1
store i64 %r127, i64* %r129
%r130 = lshr i576 %r126, 64
%r131 = trunc i576 %r130 to i64
%r133 = getelementptr i64, i64* %r1, i32 2
store i64 %r131, i64* %r133
%r134 = lshr i576 %r130, 64
%r135 = trunc i576 %r134 to i64
%r137 = getelementptr i64, i64* %r1, i32 3
store i64 %r135, i64* %r137
%r138 = lshr i576 %r134, 64
%r139 = trunc i576 %r138 to i64
%r141 = getelementptr i64, i64* %r1, i32 4
store i64 %r139, i64* %r141
%r142 = lshr i576 %r138, 64
%r143 = trunc i576 %r142 to i64
%r145 = getelementptr i64, i64* %r1, i32 5
store i64 %r143, i64* %r145
%r146 = lshr i576 %r142, 64
%r147 = trunc i576 %r146 to i64
%r149 = getelementptr i64, i64* %r1, i32 6
store i64 %r147, i64* %r149
%r150 = lshr i576 %r146, 64
%r151 = trunc i576 %r150 to i64
%r153 = getelementptr i64, i64* %r1, i32 7
store i64 %r151, i64* %r153
%r154 = lshr i576 %r150, 64
%r155 = trunc i576 %r154 to i64
%r157 = getelementptr i64, i64* %r1, i32 8
store i64 %r155, i64* %r157
%r158 = load i64, i64* %r4
%r159 = zext i64 %r158 to i128
%r161 = getelementptr i64, i64* %r4, i32 1
%r162 = load i64, i64* %r161
%r163 = zext i64 %r162 to i128
%r164 = shl i128 %r163, 64
%r165 = or i128 %r159, %r164
%r166 = zext i128 %r165 to i192
%r168 = getelementptr i64, i64* %r4, i32 2
%r169 = load i64, i64* %r168
%r170 = zext i64 %r169 to i192
%r171 = shl i192 %r170, 128
%r172 = or i192 %r166, %r171
%r173 = zext i192 %r172 to i256
%r175 = getelementptr i64, i64* %r4, i32 3
%r176 = load i64, i64* %r175
%r177 = zext i64 %r176 to i256
%r178 = shl i256 %r177, 192
%r179 = or i256 %r173, %r178
%r180 = zext i256 %r179 to i320
%r182 = getelementptr i64, i64* %r4, i32 4
%r183 = load i64, i64* %r182
%r184 = zext i64 %r183 to i320
%r185 = shl i320 %r184, 256
%r186 = or i320 %r180, %r185
%r187 = zext i320 %r186 to i384
%r189 = getelementptr i64, i64* %r4, i32 5
%r190 = load i64, i64* %r189
%r191 = zext i64 %r190 to i384
%r192 = shl i384 %r191, 320
%r193 = or i384 %r187, %r192
%r194 = zext i384 %r193 to i448
%r196 = getelementptr i64, i64* %r4, i32 6
%r197 = load i64, i64* %r196
%r198 = zext i64 %r197 to i448
%r199 = shl i448 %r198, 384
%r200 = or i448 %r194, %r199
%r201 = zext i448 %r200 to i512
%r203 = getelementptr i64, i64* %r4, i32 7
%r204 = load i64, i64* %r203
%r205 = zext i64 %r204 to i512
%r206 = shl i512 %r205, 448
%r207 = or i512 %r201, %r206
%r208 = zext i512 %r207 to i576
%r210 = getelementptr i64, i64* %r4, i32 8
%r211 = load i64, i64* %r210
%r212 = zext i64 %r211 to i576
%r213 = shl i576 %r212, 512
%r214 = or i576 %r208, %r213
%r215 = zext i576 %r214 to i640
%r216 = sub i640 %r121, %r215
%r217 = lshr i640 %r216, 576
%r218 = trunc i640 %r217 to i1
br i1%r218, label %carry, label %nocarry
nocarry:
%r219 = trunc i640 %r216 to i576
%r220 = trunc i576 %r219 to i64
%r222 = getelementptr i64, i64* %r1, i32 0
store i64 %r220, i64* %r222
%r223 = lshr i576 %r219, 64
%r224 = trunc i576 %r223 to i64
%r226 = getelementptr i64, i64* %r1, i32 1
store i64 %r224, i64* %r226
%r227 = lshr i576 %r223, 64
%r228 = trunc i576 %r227 to i64
%r230 = getelementptr i64, i64* %r1, i32 2
store i64 %r228, i64* %r230
%r231 = lshr i576 %r227, 64
%r232 = trunc i576 %r231 to i64
%r234 = getelementptr i64, i64* %r1, i32 3
store i64 %r232, i64* %r234
%r235 = lshr i576 %r231, 64
%r236 = trunc i576 %r235 to i64
%r238 = getelementptr i64, i64* %r1, i32 4
store i64 %r236, i64* %r238
%r239 = lshr i576 %r235, 64
%r240 = trunc i576 %r239 to i64
%r242 = getelementptr i64, i64* %r1, i32 5
store i64 %r240, i64* %r242
%r243 = lshr i576 %r239, 64
%r244 = trunc i576 %r243 to i64
%r246 = getelementptr i64, i64* %r1, i32 6
store i64 %r244, i64* %r246
%r247 = lshr i576 %r243, 64
%r248 = trunc i576 %r247 to i64
%r250 = getelementptr i64, i64* %r1, i32 7
store i64 %r248, i64* %r250
%r251 = lshr i576 %r247, 64
%r252 = trunc i576 %r251 to i64
%r254 = getelementptr i64, i64* %r1, i32 8
store i64 %r252, i64* %r254
ret void
carry:
ret void
}
define void @mcl_fp_addNF9L(i64* noalias  %r1, i64* noalias  %r2, i64* noalias  %r3, i64* noalias  %r4)
{
%r5 = load i64, i64* %r2
%r6 = zext i64 %r5 to i128
%r8 = getelementptr i64, i64* %r2, i32 1
%r9 = load i64, i64* %r8
%r10 = zext i64 %r9 to i128
%r11 = shl i128 %r10, 64
%r12 = or i128 %r6, %r11
%r13 = zext i128 %r12 to i192
%r15 = getelementptr i64, i64* %r2, i32 2
%r16 = load i64, i64* %r15
%r17 = zext i64 %r16 to i192
%r18 = shl i192 %r17, 128
%r19 = or i192 %r13, %r18
%r20 = zext i192 %r19 to i256
%r22 = getelementptr i64, i64* %r2, i32 3
%r23 = load i64, i64* %r22
%r24 = zext i64 %r23 to i256
%r25 = shl i256 %r24, 192
%r26 = or i256 %r20, %r25
%r27 = zext i256 %r26 to i320
%r29 = getelementptr i64, i64* %r2, i32 4
%r30 = load i64, i64* %r29
%r31 = zext i64 %r30 to i320
%r32 = shl i320 %r31, 256
%r33 = or i320 %r27, %r32
%r34 = zext i320 %r33 to i384
%r36 = getelementptr i64, i64* %r2, i32 5
%r37 = load i64, i64* %r36
%r38 = zext i64 %r37 to i384
%r39 = shl i384 %r38, 320
%r40 = or i384 %r34, %r39
%r41 = zext i384 %r40 to i448
%r43 = getelementptr i64, i64* %r2, i32 6
%r44 = load i64, i64* %r43
%r45 = zext i64 %r44 to i448
%r46 = shl i448 %r45, 384
%r47 = or i448 %r41, %r46
%r48 = zext i448 %r47 to i512
%r50 = getelementptr i64, i64* %r2, i32 7
%r51 = load i64, i64* %r50
%r52 = zext i64 %r51 to i512
%r53 = shl i512 %r52, 448
%r54 = or i512 %r48, %r53
%r55 = zext i512 %r54 to i576
%r57 = getelementptr i64, i64* %r2, i32 8
%r58 = load i64, i64* %r57
%r59 = zext i64 %r58 to i576
%r60 = shl i576 %r59, 512
%r61 = or i576 %r55, %r60
%r62 = load i64, i64* %r3
%r63 = zext i64 %r62 to i128
%r65 = getelementptr i64, i64* %r3, i32 1
%r66 = load i64, i64* %r65
%r67 = zext i64 %r66 to i128
%r68 = shl i128 %r67, 64
%r69 = or i128 %r63, %r68
%r70 = zext i128 %r69 to i192
%r72 = getelementptr i64, i64* %r3, i32 2
%r73 = load i64, i64* %r72
%r74 = zext i64 %r73 to i192
%r75 = shl i192 %r74, 128
%r76 = or i192 %r70, %r75
%r77 = zext i192 %r76 to i256
%r79 = getelementptr i64, i64* %r3, i32 3
%r80 = load i64, i64* %r79
%r81 = zext i64 %r80 to i256
%r82 = shl i256 %r81, 192
%r83 = or i256 %r77, %r82
%r84 = zext i256 %r83 to i320
%r86 = getelementptr i64, i64* %r3, i32 4
%r87 = load i64, i64* %r86
%r88 = zext i64 %r87 to i320
%r89 = shl i320 %r88, 256
%r90 = or i320 %r84, %r89
%r91 = zext i320 %r90 to i384
%r93 = getelementptr i64, i64* %r3, i32 5
%r94 = load i64, i64* %r93
%r95 = zext i64 %r94 to i384
%r96 = shl i384 %r95, 320
%r97 = or i384 %r91, %r96
%r98 = zext i384 %r97 to i448
%r100 = getelementptr i64, i64* %r3, i32 6
%r101 = load i64, i64* %r100
%r102 = zext i64 %r101 to i448
%r103 = shl i448 %r102, 384
%r104 = or i448 %r98, %r103
%r105 = zext i448 %r104 to i512
%r107 = getelementptr i64, i64* %r3, i32 7
%r108 = load i64, i64* %r107
%r109 = zext i64 %r108 to i512
%r110 = shl i512 %r109, 448
%r111 = or i512 %r105, %r110
%r112 = zext i512 %r111 to i576
%r114 = getelementptr i64, i64* %r3, i32 8
%r115 = load i64, i64* %r114
%r116 = zext i64 %r115 to i576
%r117 = shl i576 %r116, 512
%r118 = or i576 %r112, %r117
%r119 = add i576 %r61, %r118
%r120 = load i64, i64* %r4
%r121 = zext i64 %r120 to i128
%r123 = getelementptr i64, i64* %r4, i32 1
%r124 = load i64, i64* %r123
%r125 = zext i64 %r124 to i128
%r126 = shl i128 %r125, 64
%r127 = or i128 %r121, %r126
%r128 = zext i128 %r127 to i192
%r130 = getelementptr i64, i64* %r4, i32 2
%r131 = load i64, i64* %r130
%r132 = zext i64 %r131 to i192
%r133 = shl i192 %r132, 128
%r134 = or i192 %r128, %r133
%r135 = zext i192 %r134 to i256
%r137 = getelementptr i64, i64* %r4, i32 3
%r138 = load i64, i64* %r137
%r139 = zext i64 %r138 to i256
%r140 = shl i256 %r139, 192
%r141 = or i256 %r135, %r140
%r142 = zext i256 %r141 to i320
%r144 = getelementptr i64, i64* %r4, i32 4
%r145 = load i64, i64* %r144
%r146 = zext i64 %r145 to i320
%r147 = shl i320 %r146, 256
%r148 = or i320 %r142, %r147
%r149 = zext i320 %r148 to i384
%r151 = getelementptr i64, i64* %r4, i32 5
%r152 = load i64, i64* %r151
%r153 = zext i64 %r152 to i384
%r154 = shl i384 %r153, 320
%r155 = or i384 %r149, %r154
%r156 = zext i384 %r155 to i448
%r158 = getelementptr i64, i64* %r4, i32 6
%r159 = load i64, i64* %r158
%r160 = zext i64 %r159 to i448
%r161 = shl i448 %r160, 384
%r162 = or i448 %r156, %r161
%r163 = zext i448 %r162 to i512
%r165 = getelementptr i64, i64* %r4, i32 7
%r166 = load i64, i64* %r165
%r167 = zext i64 %r166 to i512
%r168 = shl i512 %r167, 448
%r169 = or i512 %r163, %r168
%r170 = zext i512 %r169 to i576
%r172 = getelementptr i64, i64* %r4, i32 8
%r173 = load i64, i64* %r172
%r174 = zext i64 %r173 to i576
%r175 = shl i576 %r174, 512
%r176 = or i576 %r170, %r175
%r177 = sub i576 %r119, %r176
%r178 = lshr i576 %r177, 575
%r179 = trunc i576 %r178 to i1
%r180 = select i1 %r179, i576 %r119, i576 %r177
%r181 = trunc i576 %r180 to i64
%r183 = getelementptr i64, i64* %r1, i32 0
store i64 %r181, i64* %r183
%r184 = lshr i576 %r180, 64
%r185 = trunc i576 %r184 to i64
%r187 = getelementptr i64, i64* %r1, i32 1
store i64 %r185, i64* %r187
%r188 = lshr i576 %r184, 64
%r189 = trunc i576 %r188 to i64
%r191 = getelementptr i64, i64* %r1, i32 2
store i64 %r189, i64* %r191
%r192 = lshr i576 %r188, 64
%r193 = trunc i576 %r192 to i64
%r195 = getelementptr i64, i64* %r1, i32 3
store i64 %r193, i64* %r195
%r196 = lshr i576 %r192, 64
%r197 = trunc i576 %r196 to i64
%r199 = getelementptr i64, i64* %r1, i32 4
store i64 %r197, i64* %r199
%r200 = lshr i576 %r196, 64
%r201 = trunc i576 %r200 to i64
%r203 = getelementptr i64, i64* %r1, i32 5
store i64 %r201, i64* %r203
%r204 = lshr i576 %r200, 64
%r205 = trunc i576 %r204 to i64
%r207 = getelementptr i64, i64* %r1, i32 6
store i64 %r205, i64* %r207
%r208 = lshr i576 %r204, 64
%r209 = trunc i576 %r208 to i64
%r211 = getelementptr i64, i64* %r1, i32 7
store i64 %r209, i64* %r211
%r212 = lshr i576 %r208, 64
%r213 = trunc i576 %r212 to i64
%r215 = getelementptr i64, i64* %r1, i32 8
store i64 %r213, i64* %r215
ret void
}
define void @mcl_fp_sub9L(i64* noalias  %r1, i64* noalias  %r2, i64* noalias  %r3, i64* noalias  %r4)
{
%r5 = load i64, i64* %r2
%r6 = zext i64 %r5 to i128
%r8 = getelementptr i64, i64* %r2, i32 1
%r9 = load i64, i64* %r8
%r10 = zext i64 %r9 to i128
%r11 = shl i128 %r10, 64
%r12 = or i128 %r6, %r11
%r13 = zext i128 %r12 to i192
%r15 = getelementptr i64, i64* %r2, i32 2
%r16 = load i64, i64* %r15
%r17 = zext i64 %r16 to i192
%r18 = shl i192 %r17, 128
%r19 = or i192 %r13, %r18
%r20 = zext i192 %r19 to i256
%r22 = getelementptr i64, i64* %r2, i32 3
%r23 = load i64, i64* %r22
%r24 = zext i64 %r23 to i256
%r25 = shl i256 %r24, 192
%r26 = or i256 %r20, %r25
%r27 = zext i256 %r26 to i320
%r29 = getelementptr i64, i64* %r2, i32 4
%r30 = load i64, i64* %r29
%r31 = zext i64 %r30 to i320
%r32 = shl i320 %r31, 256
%r33 = or i320 %r27, %r32
%r34 = zext i320 %r33 to i384
%r36 = getelementptr i64, i64* %r2, i32 5
%r37 = load i64, i64* %r36
%r38 = zext i64 %r37 to i384
%r39 = shl i384 %r38, 320
%r40 = or i384 %r34, %r39
%r41 = zext i384 %r40 to i448
%r43 = getelementptr i64, i64* %r2, i32 6
%r44 = load i64, i64* %r43
%r45 = zext i64 %r44 to i448
%r46 = shl i448 %r45, 384
%r47 = or i448 %r41, %r46
%r48 = zext i448 %r47 to i512
%r50 = getelementptr i64, i64* %r2, i32 7
%r51 = load i64, i64* %r50
%r52 = zext i64 %r51 to i512
%r53 = shl i512 %r52, 448
%r54 = or i512 %r48, %r53
%r55 = zext i512 %r54 to i576
%r57 = getelementptr i64, i64* %r2, i32 8
%r58 = load i64, i64* %r57
%r59 = zext i64 %r58 to i576
%r60 = shl i576 %r59, 512
%r61 = or i576 %r55, %r60
%r62 = load i64, i64* %r3
%r63 = zext i64 %r62 to i128
%r65 = getelementptr i64, i64* %r3, i32 1
%r66 = load i64, i64* %r65
%r67 = zext i64 %r66 to i128
%r68 = shl i128 %r67, 64
%r69 = or i128 %r63, %r68
%r70 = zext i128 %r69 to i192
%r72 = getelementptr i64, i64* %r3, i32 2
%r73 = load i64, i64* %r72
%r74 = zext i64 %r73 to i192
%r75 = shl i192 %r74, 128
%r76 = or i192 %r70, %r75
%r77 = zext i192 %r76 to i256
%r79 = getelementptr i64, i64* %r3, i32 3
%r80 = load i64, i64* %r79
%r81 = zext i64 %r80 to i256
%r82 = shl i256 %r81, 192
%r83 = or i256 %r77, %r82
%r84 = zext i256 %r83 to i320
%r86 = getelementptr i64, i64* %r3, i32 4
%r87 = load i64, i64* %r86
%r88 = zext i64 %r87 to i320
%r89 = shl i320 %r88, 256
%r90 = or i320 %r84, %r89
%r91 = zext i320 %r90 to i384
%r93 = getelementptr i64, i64* %r3, i32 5
%r94 = load i64, i64* %r93
%r95 = zext i64 %r94 to i384
%r96 = shl i384 %r95, 320
%r97 = or i384 %r91, %r96
%r98 = zext i384 %r97 to i448
%r100 = getelementptr i64, i64* %r3, i32 6
%r101 = load i64, i64* %r100
%r102 = zext i64 %r101 to i448
%r103 = shl i448 %r102, 384
%r104 = or i448 %r98, %r103
%r105 = zext i448 %r104 to i512
%r107 = getelementptr i64, i64* %r3, i32 7
%r108 = load i64, i64* %r107
%r109 = zext i64 %r108 to i512
%r110 = shl i512 %r109, 448
%r111 = or i512 %r105, %r110
%r112 = zext i512 %r111 to i576
%r114 = getelementptr i64, i64* %r3, i32 8
%r115 = load i64, i64* %r114
%r116 = zext i64 %r115 to i576
%r117 = shl i576 %r116, 512
%r118 = or i576 %r112, %r117
%r119 = zext i576 %r61 to i640
%r120 = zext i576 %r118 to i640
%r121 = sub i640 %r119, %r120
%r122 = trunc i640 %r121 to i576
%r123 = lshr i640 %r121, 576
%r124 = trunc i640 %r123 to i1
%r125 = trunc i576 %r122 to i64
%r127 = getelementptr i64, i64* %r1, i32 0
store i64 %r125, i64* %r127
%r128 = lshr i576 %r122, 64
%r129 = trunc i576 %r128 to i64
%r131 = getelementptr i64, i64* %r1, i32 1
store i64 %r129, i64* %r131
%r132 = lshr i576 %r128, 64
%r133 = trunc i576 %r132 to i64
%r135 = getelementptr i64, i64* %r1, i32 2
store i64 %r133, i64* %r135
%r136 = lshr i576 %r132, 64
%r137 = trunc i576 %r136 to i64
%r139 = getelementptr i64, i64* %r1, i32 3
store i64 %r137, i64* %r139
%r140 = lshr i576 %r136, 64
%r141 = trunc i576 %r140 to i64
%r143 = getelementptr i64, i64* %r1, i32 4
store i64 %r141, i64* %r143
%r144 = lshr i576 %r140, 64
%r145 = trunc i576 %r144 to i64
%r147 = getelementptr i64, i64* %r1, i32 5
store i64 %r145, i64* %r147
%r148 = lshr i576 %r144, 64
%r149 = trunc i576 %r148 to i64
%r151 = getelementptr i64, i64* %r1, i32 6
store i64 %r149, i64* %r151
%r152 = lshr i576 %r148, 64
%r153 = trunc i576 %r152 to i64
%r155 = getelementptr i64, i64* %r1, i32 7
store i64 %r153, i64* %r155
%r156 = lshr i576 %r152, 64
%r157 = trunc i576 %r156 to i64
%r159 = getelementptr i64, i64* %r1, i32 8
store i64 %r157, i64* %r159
br i1%r124, label %carry, label %nocarry
nocarry:
ret void
carry:
%r160 = load i64, i64* %r4
%r161 = zext i64 %r160 to i128
%r163 = getelementptr i64, i64* %r4, i32 1
%r164 = load i64, i64* %r163
%r165 = zext i64 %r164 to i128
%r166 = shl i128 %r165, 64
%r167 = or i128 %r161, %r166
%r168 = zext i128 %r167 to i192
%r170 = getelementptr i64, i64* %r4, i32 2
%r171 = load i64, i64* %r170
%r172 = zext i64 %r171 to i192
%r173 = shl i192 %r172, 128
%r174 = or i192 %r168, %r173
%r175 = zext i192 %r174 to i256
%r177 = getelementptr i64, i64* %r4, i32 3
%r178 = load i64, i64* %r177
%r179 = zext i64 %r178 to i256
%r180 = shl i256 %r179, 192
%r181 = or i256 %r175, %r180
%r182 = zext i256 %r181 to i320
%r184 = getelementptr i64, i64* %r4, i32 4
%r185 = load i64, i64* %r184
%r186 = zext i64 %r185 to i320
%r187 = shl i320 %r186, 256
%r188 = or i320 %r182, %r187
%r189 = zext i320 %r188 to i384
%r191 = getelementptr i64, i64* %r4, i32 5
%r192 = load i64, i64* %r191
%r193 = zext i64 %r192 to i384
%r194 = shl i384 %r193, 320
%r195 = or i384 %r189, %r194
%r196 = zext i384 %r195 to i448
%r198 = getelementptr i64, i64* %r4, i32 6
%r199 = load i64, i64* %r198
%r200 = zext i64 %r199 to i448
%r201 = shl i448 %r200, 384
%r202 = or i448 %r196, %r201
%r203 = zext i448 %r202 to i512
%r205 = getelementptr i64, i64* %r4, i32 7
%r206 = load i64, i64* %r205
%r207 = zext i64 %r206 to i512
%r208 = shl i512 %r207, 448
%r209 = or i512 %r203, %r208
%r210 = zext i512 %r209 to i576
%r212 = getelementptr i64, i64* %r4, i32 8
%r213 = load i64, i64* %r212
%r214 = zext i64 %r213 to i576
%r215 = shl i576 %r214, 512
%r216 = or i576 %r210, %r215
%r217 = add i576 %r122, %r216
%r218 = trunc i576 %r217 to i64
%r220 = getelementptr i64, i64* %r1, i32 0
store i64 %r218, i64* %r220
%r221 = lshr i576 %r217, 64
%r222 = trunc i576 %r221 to i64
%r224 = getelementptr i64, i64* %r1, i32 1
store i64 %r222, i64* %r224
%r225 = lshr i576 %r221, 64
%r226 = trunc i576 %r225 to i64
%r228 = getelementptr i64, i64* %r1, i32 2
store i64 %r226, i64* %r228
%r229 = lshr i576 %r225, 64
%r230 = trunc i576 %r229 to i64
%r232 = getelementptr i64, i64* %r1, i32 3
store i64 %r230, i64* %r232
%r233 = lshr i576 %r229, 64
%r234 = trunc i576 %r233 to i64
%r236 = getelementptr i64, i64* %r1, i32 4
store i64 %r234, i64* %r236
%r237 = lshr i576 %r233, 64
%r238 = trunc i576 %r237 to i64
%r240 = getelementptr i64, i64* %r1, i32 5
store i64 %r238, i64* %r240
%r241 = lshr i576 %r237, 64
%r242 = trunc i576 %r241 to i64
%r244 = getelementptr i64, i64* %r1, i32 6
store i64 %r242, i64* %r244
%r245 = lshr i576 %r241, 64
%r246 = trunc i576 %r245 to i64
%r248 = getelementptr i64, i64* %r1, i32 7
store i64 %r246, i64* %r248
%r249 = lshr i576 %r245, 64
%r250 = trunc i576 %r249 to i64
%r252 = getelementptr i64, i64* %r1, i32 8
store i64 %r250, i64* %r252
ret void
}
define void @mcl_fp_subNF9L(i64* noalias  %r1, i64* noalias  %r2, i64* noalias  %r3, i64* noalias  %r4)
{
%r5 = load i64, i64* %r2
%r6 = zext i64 %r5 to i128
%r8 = getelementptr i64, i64* %r2, i32 1
%r9 = load i64, i64* %r8
%r10 = zext i64 %r9 to i128
%r11 = shl i128 %r10, 64
%r12 = or i128 %r6, %r11
%r13 = zext i128 %r12 to i192
%r15 = getelementptr i64, i64* %r2, i32 2
%r16 = load i64, i64* %r15
%r17 = zext i64 %r16 to i192
%r18 = shl i192 %r17, 128
%r19 = or i192 %r13, %r18
%r20 = zext i192 %r19 to i256
%r22 = getelementptr i64, i64* %r2, i32 3
%r23 = load i64, i64* %r22
%r24 = zext i64 %r23 to i256
%r25 = shl i256 %r24, 192
%r26 = or i256 %r20, %r25
%r27 = zext i256 %r26 to i320
%r29 = getelementptr i64, i64* %r2, i32 4
%r30 = load i64, i64* %r29
%r31 = zext i64 %r30 to i320
%r32 = shl i320 %r31, 256
%r33 = or i320 %r27, %r32
%r34 = zext i320 %r33 to i384
%r36 = getelementptr i64, i64* %r2, i32 5
%r37 = load i64, i64* %r36
%r38 = zext i64 %r37 to i384
%r39 = shl i384 %r38, 320
%r40 = or i384 %r34, %r39
%r41 = zext i384 %r40 to i448
%r43 = getelementptr i64, i64* %r2, i32 6
%r44 = load i64, i64* %r43
%r45 = zext i64 %r44 to i448
%r46 = shl i448 %r45, 384
%r47 = or i448 %r41, %r46
%r48 = zext i448 %r47 to i512
%r50 = getelementptr i64, i64* %r2, i32 7
%r51 = load i64, i64* %r50
%r52 = zext i64 %r51 to i512
%r53 = shl i512 %r52, 448
%r54 = or i512 %r48, %r53
%r55 = zext i512 %r54 to i576
%r57 = getelementptr i64, i64* %r2, i32 8
%r58 = load i64, i64* %r57
%r59 = zext i64 %r58 to i576
%r60 = shl i576 %r59, 512
%r61 = or i576 %r55, %r60
%r62 = load i64, i64* %r3
%r63 = zext i64 %r62 to i128
%r65 = getelementptr i64, i64* %r3, i32 1
%r66 = load i64, i64* %r65
%r67 = zext i64 %r66 to i128
%r68 = shl i128 %r67, 64
%r69 = or i128 %r63, %r68
%r70 = zext i128 %r69 to i192
%r72 = getelementptr i64, i64* %r3, i32 2
%r73 = load i64, i64* %r72
%r74 = zext i64 %r73 to i192
%r75 = shl i192 %r74, 128
%r76 = or i192 %r70, %r75
%r77 = zext i192 %r76 to i256
%r79 = getelementptr i64, i64* %r3, i32 3
%r80 = load i64, i64* %r79
%r81 = zext i64 %r80 to i256
%r82 = shl i256 %r81, 192
%r83 = or i256 %r77, %r82
%r84 = zext i256 %r83 to i320
%r86 = getelementptr i64, i64* %r3, i32 4
%r87 = load i64, i64* %r86
%r88 = zext i64 %r87 to i320
%r89 = shl i320 %r88, 256
%r90 = or i320 %r84, %r89
%r91 = zext i320 %r90 to i384
%r93 = getelementptr i64, i64* %r3, i32 5
%r94 = load i64, i64* %r93
%r95 = zext i64 %r94 to i384
%r96 = shl i384 %r95, 320
%r97 = or i384 %r91, %r96
%r98 = zext i384 %r97 to i448
%r100 = getelementptr i64, i64* %r3, i32 6
%r101 = load i64, i64* %r100
%r102 = zext i64 %r101 to i448
%r103 = shl i448 %r102, 384
%r104 = or i448 %r98, %r103
%r105 = zext i448 %r104 to i512
%r107 = getelementptr i64, i64* %r3, i32 7
%r108 = load i64, i64* %r107
%r109 = zext i64 %r108 to i512
%r110 = shl i512 %r109, 448
%r111 = or i512 %r105, %r110
%r112 = zext i512 %r111 to i576
%r114 = getelementptr i64, i64* %r3, i32 8
%r115 = load i64, i64* %r114
%r116 = zext i64 %r115 to i576
%r117 = shl i576 %r116, 512
%r118 = or i576 %r112, %r117
%r119 = sub i576 %r61, %r118
%r120 = lshr i576 %r119, 575
%r121 = trunc i576 %r120 to i1
%r122 = load i64, i64* %r4
%r123 = zext i64 %r122 to i128
%r125 = getelementptr i64, i64* %r4, i32 1
%r126 = load i64, i64* %r125
%r127 = zext i64 %r126 to i128
%r128 = shl i128 %r127, 64
%r129 = or i128 %r123, %r128
%r130 = zext i128 %r129 to i192
%r132 = getelementptr i64, i64* %r4, i32 2
%r133 = load i64, i64* %r132
%r134 = zext i64 %r133 to i192
%r135 = shl i192 %r134, 128
%r136 = or i192 %r130, %r135
%r137 = zext i192 %r136 to i256
%r139 = getelementptr i64, i64* %r4, i32 3
%r140 = load i64, i64* %r139
%r141 = zext i64 %r140 to i256
%r142 = shl i256 %r141, 192
%r143 = or i256 %r137, %r142
%r144 = zext i256 %r143 to i320
%r146 = getelementptr i64, i64* %r4, i32 4
%r147 = load i64, i64* %r146
%r148 = zext i64 %r147 to i320
%r149 = shl i320 %r148, 256
%r150 = or i320 %r144, %r149
%r151 = zext i320 %r150 to i384
%r153 = getelementptr i64, i64* %r4, i32 5
%r154 = load i64, i64* %r153
%r155 = zext i64 %r154 to i384
%r156 = shl i384 %r155, 320
%r157 = or i384 %r151, %r156
%r158 = zext i384 %r157 to i448
%r160 = getelementptr i64, i64* %r4, i32 6
%r161 = load i64, i64* %r160
%r162 = zext i64 %r161 to i448
%r163 = shl i448 %r162, 384
%r164 = or i448 %r158, %r163
%r165 = zext i448 %r164 to i512
%r167 = getelementptr i64, i64* %r4, i32 7
%r168 = load i64, i64* %r167
%r169 = zext i64 %r168 to i512
%r170 = shl i512 %r169, 448
%r171 = or i512 %r165, %r170
%r172 = zext i512 %r171 to i576
%r174 = getelementptr i64, i64* %r4, i32 8
%r175 = load i64, i64* %r174
%r176 = zext i64 %r175 to i576
%r177 = shl i576 %r176, 512
%r178 = or i576 %r172, %r177
%r180 = select i1 %r121, i576 %r178, i576 0
%r181 = add i576 %r119, %r180
%r182 = trunc i576 %r181 to i64
%r184 = getelementptr i64, i64* %r1, i32 0
store i64 %r182, i64* %r184
%r185 = lshr i576 %r181, 64
%r186 = trunc i576 %r185 to i64
%r188 = getelementptr i64, i64* %r1, i32 1
store i64 %r186, i64* %r188
%r189 = lshr i576 %r185, 64
%r190 = trunc i576 %r189 to i64
%r192 = getelementptr i64, i64* %r1, i32 2
store i64 %r190, i64* %r192
%r193 = lshr i576 %r189, 64
%r194 = trunc i576 %r193 to i64
%r196 = getelementptr i64, i64* %r1, i32 3
store i64 %r194, i64* %r196
%r197 = lshr i576 %r193, 64
%r198 = trunc i576 %r197 to i64
%r200 = getelementptr i64, i64* %r1, i32 4
store i64 %r198, i64* %r200
%r201 = lshr i576 %r197, 64
%r202 = trunc i576 %r201 to i64
%r204 = getelementptr i64, i64* %r1, i32 5
store i64 %r202, i64* %r204
%r205 = lshr i576 %r201, 64
%r206 = trunc i576 %r205 to i64
%r208 = getelementptr i64, i64* %r1, i32 6
store i64 %r206, i64* %r208
%r209 = lshr i576 %r205, 64
%r210 = trunc i576 %r209 to i64
%r212 = getelementptr i64, i64* %r1, i32 7
store i64 %r210, i64* %r212
%r213 = lshr i576 %r209, 64
%r214 = trunc i576 %r213 to i64
%r216 = getelementptr i64, i64* %r1, i32 8
store i64 %r214, i64* %r216
ret void
}
define void @mcl_fpDbl_add9L(i64* noalias  %r1, i64* noalias  %r2, i64* noalias  %r3, i64* noalias  %r4)
{
%r5 = load i64, i64* %r2
%r6 = zext i64 %r5 to i128
%r8 = getelementptr i64, i64* %r2, i32 1
%r9 = load i64, i64* %r8
%r10 = zext i64 %r9 to i128
%r11 = shl i128 %r10, 64
%r12 = or i128 %r6, %r11
%r13 = zext i128 %r12 to i192
%r15 = getelementptr i64, i64* %r2, i32 2
%r16 = load i64, i64* %r15
%r17 = zext i64 %r16 to i192
%r18 = shl i192 %r17, 128
%r19 = or i192 %r13, %r18
%r20 = zext i192 %r19 to i256
%r22 = getelementptr i64, i64* %r2, i32 3
%r23 = load i64, i64* %r22
%r24 = zext i64 %r23 to i256
%r25 = shl i256 %r24, 192
%r26 = or i256 %r20, %r25
%r27 = zext i256 %r26 to i320
%r29 = getelementptr i64, i64* %r2, i32 4
%r30 = load i64, i64* %r29
%r31 = zext i64 %r30 to i320
%r32 = shl i320 %r31, 256
%r33 = or i320 %r27, %r32
%r34 = zext i320 %r33 to i384
%r36 = getelementptr i64, i64* %r2, i32 5
%r37 = load i64, i64* %r36
%r38 = zext i64 %r37 to i384
%r39 = shl i384 %r38, 320
%r40 = or i384 %r34, %r39
%r41 = zext i384 %r40 to i448
%r43 = getelementptr i64, i64* %r2, i32 6
%r44 = load i64, i64* %r43
%r45 = zext i64 %r44 to i448
%r46 = shl i448 %r45, 384
%r47 = or i448 %r41, %r46
%r48 = zext i448 %r47 to i512
%r50 = getelementptr i64, i64* %r2, i32 7
%r51 = load i64, i64* %r50
%r52 = zext i64 %r51 to i512
%r53 = shl i512 %r52, 448
%r54 = or i512 %r48, %r53
%r55 = zext i512 %r54 to i576
%r57 = getelementptr i64, i64* %r2, i32 8
%r58 = load i64, i64* %r57
%r59 = zext i64 %r58 to i576
%r60 = shl i576 %r59, 512
%r61 = or i576 %r55, %r60
%r62 = zext i576 %r61 to i640
%r64 = getelementptr i64, i64* %r2, i32 9
%r65 = load i64, i64* %r64
%r66 = zext i64 %r65 to i640
%r67 = shl i640 %r66, 576
%r68 = or i640 %r62, %r67
%r69 = zext i640 %r68 to i704
%r71 = getelementptr i64, i64* %r2, i32 10
%r72 = load i64, i64* %r71
%r73 = zext i64 %r72 to i704
%r74 = shl i704 %r73, 640
%r75 = or i704 %r69, %r74
%r76 = zext i704 %r75 to i768
%r78 = getelementptr i64, i64* %r2, i32 11
%r79 = load i64, i64* %r78
%r80 = zext i64 %r79 to i768
%r81 = shl i768 %r80, 704
%r82 = or i768 %r76, %r81
%r83 = zext i768 %r82 to i832
%r85 = getelementptr i64, i64* %r2, i32 12
%r86 = load i64, i64* %r85
%r87 = zext i64 %r86 to i832
%r88 = shl i832 %r87, 768
%r89 = or i832 %r83, %r88
%r90 = zext i832 %r89 to i896
%r92 = getelementptr i64, i64* %r2, i32 13
%r93 = load i64, i64* %r92
%r94 = zext i64 %r93 to i896
%r95 = shl i896 %r94, 832
%r96 = or i896 %r90, %r95
%r97 = zext i896 %r96 to i960
%r99 = getelementptr i64, i64* %r2, i32 14
%r100 = load i64, i64* %r99
%r101 = zext i64 %r100 to i960
%r102 = shl i960 %r101, 896
%r103 = or i960 %r97, %r102
%r104 = zext i960 %r103 to i1024
%r106 = getelementptr i64, i64* %r2, i32 15
%r107 = load i64, i64* %r106
%r108 = zext i64 %r107 to i1024
%r109 = shl i1024 %r108, 960
%r110 = or i1024 %r104, %r109
%r111 = zext i1024 %r110 to i1088
%r113 = getelementptr i64, i64* %r2, i32 16
%r114 = load i64, i64* %r113
%r115 = zext i64 %r114 to i1088
%r116 = shl i1088 %r115, 1024
%r117 = or i1088 %r111, %r116
%r118 = zext i1088 %r117 to i1152
%r120 = getelementptr i64, i64* %r2, i32 17
%r121 = load i64, i64* %r120
%r122 = zext i64 %r121 to i1152
%r123 = shl i1152 %r122, 1088
%r124 = or i1152 %r118, %r123
%r125 = load i64, i64* %r3
%r126 = zext i64 %r125 to i128
%r128 = getelementptr i64, i64* %r3, i32 1
%r129 = load i64, i64* %r128
%r130 = zext i64 %r129 to i128
%r131 = shl i128 %r130, 64
%r132 = or i128 %r126, %r131
%r133 = zext i128 %r132 to i192
%r135 = getelementptr i64, i64* %r3, i32 2
%r136 = load i64, i64* %r135
%r137 = zext i64 %r136 to i192
%r138 = shl i192 %r137, 128
%r139 = or i192 %r133, %r138
%r140 = zext i192 %r139 to i256
%r142 = getelementptr i64, i64* %r3, i32 3
%r143 = load i64, i64* %r142
%r144 = zext i64 %r143 to i256
%r145 = shl i256 %r144, 192
%r146 = or i256 %r140, %r145
%r147 = zext i256 %r146 to i320
%r149 = getelementptr i64, i64* %r3, i32 4
%r150 = load i64, i64* %r149
%r151 = zext i64 %r150 to i320
%r152 = shl i320 %r151, 256
%r153 = or i320 %r147, %r152
%r154 = zext i320 %r153 to i384
%r156 = getelementptr i64, i64* %r3, i32 5
%r157 = load i64, i64* %r156
%r158 = zext i64 %r157 to i384
%r159 = shl i384 %r158, 320
%r160 = or i384 %r154, %r159
%r161 = zext i384 %r160 to i448
%r163 = getelementptr i64, i64* %r3, i32 6
%r164 = load i64, i64* %r163
%r165 = zext i64 %r164 to i448
%r166 = shl i448 %r165, 384
%r167 = or i448 %r161, %r166
%r168 = zext i448 %r167 to i512
%r170 = getelementptr i64, i64* %r3, i32 7
%r171 = load i64, i64* %r170
%r172 = zext i64 %r171 to i512
%r173 = shl i512 %r172, 448
%r174 = or i512 %r168, %r173
%r175 = zext i512 %r174 to i576
%r177 = getelementptr i64, i64* %r3, i32 8
%r178 = load i64, i64* %r177
%r179 = zext i64 %r178 to i576
%r180 = shl i576 %r179, 512
%r181 = or i576 %r175, %r180
%r182 = zext i576 %r181 to i640
%r184 = getelementptr i64, i64* %r3, i32 9
%r185 = load i64, i64* %r184
%r186 = zext i64 %r185 to i640
%r187 = shl i640 %r186, 576
%r188 = or i640 %r182, %r187
%r189 = zext i640 %r188 to i704
%r191 = getelementptr i64, i64* %r3, i32 10
%r192 = load i64, i64* %r191
%r193 = zext i64 %r192 to i704
%r194 = shl i704 %r193, 640
%r195 = or i704 %r189, %r194
%r196 = zext i704 %r195 to i768
%r198 = getelementptr i64, i64* %r3, i32 11
%r199 = load i64, i64* %r198
%r200 = zext i64 %r199 to i768
%r201 = shl i768 %r200, 704
%r202 = or i768 %r196, %r201
%r203 = zext i768 %r202 to i832
%r205 = getelementptr i64, i64* %r3, i32 12
%r206 = load i64, i64* %r205
%r207 = zext i64 %r206 to i832
%r208 = shl i832 %r207, 768
%r209 = or i832 %r203, %r208
%r210 = zext i832 %r209 to i896
%r212 = getelementptr i64, i64* %r3, i32 13
%r213 = load i64, i64* %r212
%r214 = zext i64 %r213 to i896
%r215 = shl i896 %r214, 832
%r216 = or i896 %r210, %r215
%r217 = zext i896 %r216 to i960
%r219 = getelementptr i64, i64* %r3, i32 14
%r220 = load i64, i64* %r219
%r221 = zext i64 %r220 to i960
%r222 = shl i960 %r221, 896
%r223 = or i960 %r217, %r222
%r224 = zext i960 %r223 to i1024
%r226 = getelementptr i64, i64* %r3, i32 15
%r227 = load i64, i64* %r226
%r228 = zext i64 %r227 to i1024
%r229 = shl i1024 %r228, 960
%r230 = or i1024 %r224, %r229
%r231 = zext i1024 %r230 to i1088
%r233 = getelementptr i64, i64* %r3, i32 16
%r234 = load i64, i64* %r233
%r235 = zext i64 %r234 to i1088
%r236 = shl i1088 %r235, 1024
%r237 = or i1088 %r231, %r236
%r238 = zext i1088 %r237 to i1152
%r240 = getelementptr i64, i64* %r3, i32 17
%r241 = load i64, i64* %r240
%r242 = zext i64 %r241 to i1152
%r243 = shl i1152 %r242, 1088
%r244 = or i1152 %r238, %r243
%r245 = zext i1152 %r124 to i1216
%r246 = zext i1152 %r244 to i1216
%r247 = add i1216 %r245, %r246
%r248 = trunc i1216 %r247 to i576
%r249 = trunc i576 %r248 to i64
%r251 = getelementptr i64, i64* %r1, i32 0
store i64 %r249, i64* %r251
%r252 = lshr i576 %r248, 64
%r253 = trunc i576 %r252 to i64
%r255 = getelementptr i64, i64* %r1, i32 1
store i64 %r253, i64* %r255
%r256 = lshr i576 %r252, 64
%r257 = trunc i576 %r256 to i64
%r259 = getelementptr i64, i64* %r1, i32 2
store i64 %r257, i64* %r259
%r260 = lshr i576 %r256, 64
%r261 = trunc i576 %r260 to i64
%r263 = getelementptr i64, i64* %r1, i32 3
store i64 %r261, i64* %r263
%r264 = lshr i576 %r260, 64
%r265 = trunc i576 %r264 to i64
%r267 = getelementptr i64, i64* %r1, i32 4
store i64 %r265, i64* %r267
%r268 = lshr i576 %r264, 64
%r269 = trunc i576 %r268 to i64
%r271 = getelementptr i64, i64* %r1, i32 5
store i64 %r269, i64* %r271
%r272 = lshr i576 %r268, 64
%r273 = trunc i576 %r272 to i64
%r275 = getelementptr i64, i64* %r1, i32 6
store i64 %r273, i64* %r275
%r276 = lshr i576 %r272, 64
%r277 = trunc i576 %r276 to i64
%r279 = getelementptr i64, i64* %r1, i32 7
store i64 %r277, i64* %r279
%r280 = lshr i576 %r276, 64
%r281 = trunc i576 %r280 to i64
%r283 = getelementptr i64, i64* %r1, i32 8
store i64 %r281, i64* %r283
%r284 = lshr i1216 %r247, 576
%r285 = trunc i1216 %r284 to i640
%r286 = load i64, i64* %r4
%r287 = zext i64 %r286 to i128
%r289 = getelementptr i64, i64* %r4, i32 1
%r290 = load i64, i64* %r289
%r291 = zext i64 %r290 to i128
%r292 = shl i128 %r291, 64
%r293 = or i128 %r287, %r292
%r294 = zext i128 %r293 to i192
%r296 = getelementptr i64, i64* %r4, i32 2
%r297 = load i64, i64* %r296
%r298 = zext i64 %r297 to i192
%r299 = shl i192 %r298, 128
%r300 = or i192 %r294, %r299
%r301 = zext i192 %r300 to i256
%r303 = getelementptr i64, i64* %r4, i32 3
%r304 = load i64, i64* %r303
%r305 = zext i64 %r304 to i256
%r306 = shl i256 %r305, 192
%r307 = or i256 %r301, %r306
%r308 = zext i256 %r307 to i320
%r310 = getelementptr i64, i64* %r4, i32 4
%r311 = load i64, i64* %r310
%r312 = zext i64 %r311 to i320
%r313 = shl i320 %r312, 256
%r314 = or i320 %r308, %r313
%r315 = zext i320 %r314 to i384
%r317 = getelementptr i64, i64* %r4, i32 5
%r318 = load i64, i64* %r317
%r319 = zext i64 %r318 to i384
%r320 = shl i384 %r319, 320
%r321 = or i384 %r315, %r320
%r322 = zext i384 %r321 to i448
%r324 = getelementptr i64, i64* %r4, i32 6
%r325 = load i64, i64* %r324
%r326 = zext i64 %r325 to i448
%r327 = shl i448 %r326, 384
%r328 = or i448 %r322, %r327
%r329 = zext i448 %r328 to i512
%r331 = getelementptr i64, i64* %r4, i32 7
%r332 = load i64, i64* %r331
%r333 = zext i64 %r332 to i512
%r334 = shl i512 %r333, 448
%r335 = or i512 %r329, %r334
%r336 = zext i512 %r335 to i576
%r338 = getelementptr i64, i64* %r4, i32 8
%r339 = load i64, i64* %r338
%r340 = zext i64 %r339 to i576
%r341 = shl i576 %r340, 512
%r342 = or i576 %r336, %r341
%r343 = zext i576 %r342 to i640
%r344 = sub i640 %r285, %r343
%r345 = lshr i640 %r344, 576
%r346 = trunc i640 %r345 to i1
%r347 = select i1 %r346, i640 %r285, i640 %r344
%r348 = trunc i640 %r347 to i576
%r350 = getelementptr i64, i64* %r1, i32 9
%r351 = trunc i576 %r348 to i64
%r353 = getelementptr i64, i64* %r350, i32 0
store i64 %r351, i64* %r353
%r354 = lshr i576 %r348, 64
%r355 = trunc i576 %r354 to i64
%r357 = getelementptr i64, i64* %r350, i32 1
store i64 %r355, i64* %r357
%r358 = lshr i576 %r354, 64
%r359 = trunc i576 %r358 to i64
%r361 = getelementptr i64, i64* %r350, i32 2
store i64 %r359, i64* %r361
%r362 = lshr i576 %r358, 64
%r363 = trunc i576 %r362 to i64
%r365 = getelementptr i64, i64* %r350, i32 3
store i64 %r363, i64* %r365
%r366 = lshr i576 %r362, 64
%r367 = trunc i576 %r366 to i64
%r369 = getelementptr i64, i64* %r350, i32 4
store i64 %r367, i64* %r369
%r370 = lshr i576 %r366, 64
%r371 = trunc i576 %r370 to i64
%r373 = getelementptr i64, i64* %r350, i32 5
store i64 %r371, i64* %r373
%r374 = lshr i576 %r370, 64
%r375 = trunc i576 %r374 to i64
%r377 = getelementptr i64, i64* %r350, i32 6
store i64 %r375, i64* %r377
%r378 = lshr i576 %r374, 64
%r379 = trunc i576 %r378 to i64
%r381 = getelementptr i64, i64* %r350, i32 7
store i64 %r379, i64* %r381
%r382 = lshr i576 %r378, 64
%r383 = trunc i576 %r382 to i64
%r385 = getelementptr i64, i64* %r350, i32 8
store i64 %r383, i64* %r385
ret void
}
define void @mcl_fpDbl_sub9L(i64* noalias  %r1, i64* noalias  %r2, i64* noalias  %r3, i64* noalias  %r4)
{
%r5 = load i64, i64* %r2
%r6 = zext i64 %r5 to i128
%r8 = getelementptr i64, i64* %r2, i32 1
%r9 = load i64, i64* %r8
%r10 = zext i64 %r9 to i128
%r11 = shl i128 %r10, 64
%r12 = or i128 %r6, %r11
%r13 = zext i128 %r12 to i192
%r15 = getelementptr i64, i64* %r2, i32 2
%r16 = load i64, i64* %r15
%r17 = zext i64 %r16 to i192
%r18 = shl i192 %r17, 128
%r19 = or i192 %r13, %r18
%r20 = zext i192 %r19 to i256
%r22 = getelementptr i64, i64* %r2, i32 3
%r23 = load i64, i64* %r22
%r24 = zext i64 %r23 to i256
%r25 = shl i256 %r24, 192
%r26 = or i256 %r20, %r25
%r27 = zext i256 %r26 to i320
%r29 = getelementptr i64, i64* %r2, i32 4
%r30 = load i64, i64* %r29
%r31 = zext i64 %r30 to i320
%r32 = shl i320 %r31, 256
%r33 = or i320 %r27, %r32
%r34 = zext i320 %r33 to i384
%r36 = getelementptr i64, i64* %r2, i32 5
%r37 = load i64, i64* %r36
%r38 = zext i64 %r37 to i384
%r39 = shl i384 %r38, 320
%r40 = or i384 %r34, %r39
%r41 = zext i384 %r40 to i448
%r43 = getelementptr i64, i64* %r2, i32 6
%r44 = load i64, i64* %r43
%r45 = zext i64 %r44 to i448
%r46 = shl i448 %r45, 384
%r47 = or i448 %r41, %r46
%r48 = zext i448 %r47 to i512
%r50 = getelementptr i64, i64* %r2, i32 7
%r51 = load i64, i64* %r50
%r52 = zext i64 %r51 to i512
%r53 = shl i512 %r52, 448
%r54 = or i512 %r48, %r53
%r55 = zext i512 %r54 to i576
%r57 = getelementptr i64, i64* %r2, i32 8
%r58 = load i64, i64* %r57
%r59 = zext i64 %r58 to i576
%r60 = shl i576 %r59, 512
%r61 = or i576 %r55, %r60
%r62 = zext i576 %r61 to i640
%r64 = getelementptr i64, i64* %r2, i32 9
%r65 = load i64, i64* %r64
%r66 = zext i64 %r65 to i640
%r67 = shl i640 %r66, 576
%r68 = or i640 %r62, %r67
%r69 = zext i640 %r68 to i704
%r71 = getelementptr i64, i64* %r2, i32 10
%r72 = load i64, i64* %r71
%r73 = zext i64 %r72 to i704
%r74 = shl i704 %r73, 640
%r75 = or i704 %r69, %r74
%r76 = zext i704 %r75 to i768
%r78 = getelementptr i64, i64* %r2, i32 11
%r79 = load i64, i64* %r78
%r80 = zext i64 %r79 to i768
%r81 = shl i768 %r80, 704
%r82 = or i768 %r76, %r81
%r83 = zext i768 %r82 to i832
%r85 = getelementptr i64, i64* %r2, i32 12
%r86 = load i64, i64* %r85
%r87 = zext i64 %r86 to i832
%r88 = shl i832 %r87, 768
%r89 = or i832 %r83, %r88
%r90 = zext i832 %r89 to i896
%r92 = getelementptr i64, i64* %r2, i32 13
%r93 = load i64, i64* %r92
%r94 = zext i64 %r93 to i896
%r95 = shl i896 %r94, 832
%r96 = or i896 %r90, %r95
%r97 = zext i896 %r96 to i960
%r99 = getelementptr i64, i64* %r2, i32 14
%r100 = load i64, i64* %r99
%r101 = zext i64 %r100 to i960
%r102 = shl i960 %r101, 896
%r103 = or i960 %r97, %r102
%r104 = zext i960 %r103 to i1024
%r106 = getelementptr i64, i64* %r2, i32 15
%r107 = load i64, i64* %r106
%r108 = zext i64 %r107 to i1024
%r109 = shl i1024 %r108, 960
%r110 = or i1024 %r104, %r109
%r111 = zext i1024 %r110 to i1088
%r113 = getelementptr i64, i64* %r2, i32 16
%r114 = load i64, i64* %r113
%r115 = zext i64 %r114 to i1088
%r116 = shl i1088 %r115, 1024
%r117 = or i1088 %r111, %r116
%r118 = zext i1088 %r117 to i1152
%r120 = getelementptr i64, i64* %r2, i32 17
%r121 = load i64, i64* %r120
%r122 = zext i64 %r121 to i1152
%r123 = shl i1152 %r122, 1088
%r124 = or i1152 %r118, %r123
%r125 = load i64, i64* %r3
%r126 = zext i64 %r125 to i128
%r128 = getelementptr i64, i64* %r3, i32 1
%r129 = load i64, i64* %r128
%r130 = zext i64 %r129 to i128
%r131 = shl i128 %r130, 64
%r132 = or i128 %r126, %r131
%r133 = zext i128 %r132 to i192
%r135 = getelementptr i64, i64* %r3, i32 2
%r136 = load i64, i64* %r135
%r137 = zext i64 %r136 to i192
%r138 = shl i192 %r137, 128
%r139 = or i192 %r133, %r138
%r140 = zext i192 %r139 to i256
%r142 = getelementptr i64, i64* %r3, i32 3
%r143 = load i64, i64* %r142
%r144 = zext i64 %r143 to i256
%r145 = shl i256 %r144, 192
%r146 = or i256 %r140, %r145
%r147 = zext i256 %r146 to i320
%r149 = getelementptr i64, i64* %r3, i32 4
%r150 = load i64, i64* %r149
%r151 = zext i64 %r150 to i320
%r152 = shl i320 %r151, 256
%r153 = or i320 %r147, %r152
%r154 = zext i320 %r153 to i384
%r156 = getelementptr i64, i64* %r3, i32 5
%r157 = load i64, i64* %r156
%r158 = zext i64 %r157 to i384
%r159 = shl i384 %r158, 320
%r160 = or i384 %r154, %r159
%r161 = zext i384 %r160 to i448
%r163 = getelementptr i64, i64* %r3, i32 6
%r164 = load i64, i64* %r163
%r165 = zext i64 %r164 to i448
%r166 = shl i448 %r165, 384
%r167 = or i448 %r161, %r166
%r168 = zext i448 %r167 to i512
%r170 = getelementptr i64, i64* %r3, i32 7
%r171 = load i64, i64* %r170
%r172 = zext i64 %r171 to i512
%r173 = shl i512 %r172, 448
%r174 = or i512 %r168, %r173
%r175 = zext i512 %r174 to i576
%r177 = getelementptr i64, i64* %r3, i32 8
%r178 = load i64, i64* %r177
%r179 = zext i64 %r178 to i576
%r180 = shl i576 %r179, 512
%r181 = or i576 %r175, %r180
%r182 = zext i576 %r181 to i640
%r184 = getelementptr i64, i64* %r3, i32 9
%r185 = load i64, i64* %r184
%r186 = zext i64 %r185 to i640
%r187 = shl i640 %r186, 576
%r188 = or i640 %r182, %r187
%r189 = zext i640 %r188 to i704
%r191 = getelementptr i64, i64* %r3, i32 10
%r192 = load i64, i64* %r191
%r193 = zext i64 %r192 to i704
%r194 = shl i704 %r193, 640
%r195 = or i704 %r189, %r194
%r196 = zext i704 %r195 to i768
%r198 = getelementptr i64, i64* %r3, i32 11
%r199 = load i64, i64* %r198
%r200 = zext i64 %r199 to i768
%r201 = shl i768 %r200, 704
%r202 = or i768 %r196, %r201
%r203 = zext i768 %r202 to i832
%r205 = getelementptr i64, i64* %r3, i32 12
%r206 = load i64, i64* %r205
%r207 = zext i64 %r206 to i832
%r208 = shl i832 %r207, 768
%r209 = or i832 %r203, %r208
%r210 = zext i832 %r209 to i896
%r212 = getelementptr i64, i64* %r3, i32 13
%r213 = load i64, i64* %r212
%r214 = zext i64 %r213 to i896
%r215 = shl i896 %r214, 832
%r216 = or i896 %r210, %r215
%r217 = zext i896 %r216 to i960
%r219 = getelementptr i64, i64* %r3, i32 14
%r220 = load i64, i64* %r219
%r221 = zext i64 %r220 to i960
%r222 = shl i960 %r221, 896
%r223 = or i960 %r217, %r222
%r224 = zext i960 %r223 to i1024
%r226 = getelementptr i64, i64* %r3, i32 15
%r227 = load i64, i64* %r226
%r228 = zext i64 %r227 to i1024
%r229 = shl i1024 %r228, 960
%r230 = or i1024 %r224, %r229
%r231 = zext i1024 %r230 to i1088
%r233 = getelementptr i64, i64* %r3, i32 16
%r234 = load i64, i64* %r233
%r235 = zext i64 %r234 to i1088
%r236 = shl i1088 %r235, 1024
%r237 = or i1088 %r231, %r236
%r238 = zext i1088 %r237 to i1152
%r240 = getelementptr i64, i64* %r3, i32 17
%r241 = load i64, i64* %r240
%r242 = zext i64 %r241 to i1152
%r243 = shl i1152 %r242, 1088
%r244 = or i1152 %r238, %r243
%r245 = zext i1152 %r124 to i1216
%r246 = zext i1152 %r244 to i1216
%r247 = sub i1216 %r245, %r246
%r248 = trunc i1216 %r247 to i576
%r249 = trunc i576 %r248 to i64
%r251 = getelementptr i64, i64* %r1, i32 0
store i64 %r249, i64* %r251
%r252 = lshr i576 %r248, 64
%r253 = trunc i576 %r252 to i64
%r255 = getelementptr i64, i64* %r1, i32 1
store i64 %r253, i64* %r255
%r256 = lshr i576 %r252, 64
%r257 = trunc i576 %r256 to i64
%r259 = getelementptr i64, i64* %r1, i32 2
store i64 %r257, i64* %r259
%r260 = lshr i576 %r256, 64
%r261 = trunc i576 %r260 to i64
%r263 = getelementptr i64, i64* %r1, i32 3
store i64 %r261, i64* %r263
%r264 = lshr i576 %r260, 64
%r265 = trunc i576 %r264 to i64
%r267 = getelementptr i64, i64* %r1, i32 4
store i64 %r265, i64* %r267
%r268 = lshr i576 %r264, 64
%r269 = trunc i576 %r268 to i64
%r271 = getelementptr i64, i64* %r1, i32 5
store i64 %r269, i64* %r271
%r272 = lshr i576 %r268, 64
%r273 = trunc i576 %r272 to i64
%r275 = getelementptr i64, i64* %r1, i32 6
store i64 %r273, i64* %r275
%r276 = lshr i576 %r272, 64
%r277 = trunc i576 %r276 to i64
%r279 = getelementptr i64, i64* %r1, i32 7
store i64 %r277, i64* %r279
%r280 = lshr i576 %r276, 64
%r281 = trunc i576 %r280 to i64
%r283 = getelementptr i64, i64* %r1, i32 8
store i64 %r281, i64* %r283
%r284 = lshr i1216 %r247, 576
%r285 = trunc i1216 %r284 to i576
%r286 = lshr i1216 %r247, 1152
%r287 = trunc i1216 %r286 to i1
%r288 = load i64, i64* %r4
%r289 = zext i64 %r288 to i128
%r291 = getelementptr i64, i64* %r4, i32 1
%r292 = load i64, i64* %r291
%r293 = zext i64 %r292 to i128
%r294 = shl i128 %r293, 64
%r295 = or i128 %r289, %r294
%r296 = zext i128 %r295 to i192
%r298 = getelementptr i64, i64* %r4, i32 2
%r299 = load i64, i64* %r298
%r300 = zext i64 %r299 to i192
%r301 = shl i192 %r300, 128
%r302 = or i192 %r296, %r301
%r303 = zext i192 %r302 to i256
%r305 = getelementptr i64, i64* %r4, i32 3
%r306 = load i64, i64* %r305
%r307 = zext i64 %r306 to i256
%r308 = shl i256 %r307, 192
%r309 = or i256 %r303, %r308
%r310 = zext i256 %r309 to i320
%r312 = getelementptr i64, i64* %r4, i32 4
%r313 = load i64, i64* %r312
%r314 = zext i64 %r313 to i320
%r315 = shl i320 %r314, 256
%r316 = or i320 %r310, %r315
%r317 = zext i320 %r316 to i384
%r319 = getelementptr i64, i64* %r4, i32 5
%r320 = load i64, i64* %r319
%r321 = zext i64 %r320 to i384
%r322 = shl i384 %r321, 320
%r323 = or i384 %r317, %r322
%r324 = zext i384 %r323 to i448
%r326 = getelementptr i64, i64* %r4, i32 6
%r327 = load i64, i64* %r326
%r328 = zext i64 %r327 to i448
%r329 = shl i448 %r328, 384
%r330 = or i448 %r324, %r329
%r331 = zext i448 %r330 to i512
%r333 = getelementptr i64, i64* %r4, i32 7
%r334 = load i64, i64* %r333
%r335 = zext i64 %r334 to i512
%r336 = shl i512 %r335, 448
%r337 = or i512 %r331, %r336
%r338 = zext i512 %r337 to i576
%r340 = getelementptr i64, i64* %r4, i32 8
%r341 = load i64, i64* %r340
%r342 = zext i64 %r341 to i576
%r343 = shl i576 %r342, 512
%r344 = or i576 %r338, %r343
%r346 = select i1 %r287, i576 %r344, i576 0
%r347 = add i576 %r285, %r346
%r349 = getelementptr i64, i64* %r1, i32 9
%r350 = trunc i576 %r347 to i64
%r352 = getelementptr i64, i64* %r349, i32 0
store i64 %r350, i64* %r352
%r353 = lshr i576 %r347, 64
%r354 = trunc i576 %r353 to i64
%r356 = getelementptr i64, i64* %r349, i32 1
store i64 %r354, i64* %r356
%r357 = lshr i576 %r353, 64
%r358 = trunc i576 %r357 to i64
%r360 = getelementptr i64, i64* %r349, i32 2
store i64 %r358, i64* %r360
%r361 = lshr i576 %r357, 64
%r362 = trunc i576 %r361 to i64
%r364 = getelementptr i64, i64* %r349, i32 3
store i64 %r362, i64* %r364
%r365 = lshr i576 %r361, 64
%r366 = trunc i576 %r365 to i64
%r368 = getelementptr i64, i64* %r349, i32 4
store i64 %r366, i64* %r368
%r369 = lshr i576 %r365, 64
%r370 = trunc i576 %r369 to i64
%r372 = getelementptr i64, i64* %r349, i32 5
store i64 %r370, i64* %r372
%r373 = lshr i576 %r369, 64
%r374 = trunc i576 %r373 to i64
%r376 = getelementptr i64, i64* %r349, i32 6
store i64 %r374, i64* %r376
%r377 = lshr i576 %r373, 64
%r378 = trunc i576 %r377 to i64
%r380 = getelementptr i64, i64* %r349, i32 7
store i64 %r378, i64* %r380
%r381 = lshr i576 %r377, 64
%r382 = trunc i576 %r381 to i64
%r384 = getelementptr i64, i64* %r349, i32 8
store i64 %r382, i64* %r384
ret void
}
