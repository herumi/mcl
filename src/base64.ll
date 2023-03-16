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
%r5 = bitcast i64* %r2 to i192*
%r6 = load i192, i192* %r5
%r7 = zext i192 %r6 to i256
%r9 = getelementptr i64, i64* %r2, i32 3
%r11 = bitcast i64* %r9 to i192*
%r12 = load i192, i192* %r11
%r13 = zext i192 %r12 to i256
%r14 = shl i192 %r12, 64
%r15 = zext i192 %r14 to i256
%r16 = lshr i192 %r12, 128
%r17 = trunc i192 %r16 to i64
%r18 = zext i64 %r17 to i256
%r19 = or i256 %r15, %r18
%r20 = shl i256 %r18, 64
%r21 = add i256 %r7, %r13
%r22 = add i256 %r21, %r19
%r23 = add i256 %r22, %r20
%r24 = lshr i256 %r23, 192
%r25 = trunc i256 %r24 to i64
%r26 = zext i64 %r25 to i256
%r27 = shl i256 %r26, 64
%r28 = or i256 %r26, %r27
%r29 = trunc i256 %r23 to i192
%r30 = zext i192 %r29 to i256
%r31 = add i256 %r30, %r28
%r32 = call i192 @makeNIST_P192L()
%r33 = zext i192 %r32 to i256
%r34 = sub i256 %r31, %r33
%r35 = lshr i256 %r34, 192
%r36 = trunc i256 %r35 to i1
%r37 = select i1 %r36, i256 %r31, i256 %r34
%r38 = trunc i256 %r37 to i192
%r40 = bitcast i64* %r1 to i192*
store i192 %r38, i192* %r40
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
%r5 = bitcast i64* %r2 to i1088*
%r6 = load i1088, i1088* %r5
%r7 = trunc i1088 %r6 to i521
%r8 = zext i521 %r7 to i576
%r9 = lshr i1088 %r6, 521
%r10 = trunc i1088 %r9 to i576
%r11 = add i576 %r8, %r10
%r12 = lshr i576 %r11, 521
%r14 = and i576 %r12, 1
%r15 = add i576 %r11, %r14
%r16 = trunc i576 %r15 to i521
%r17 = zext i521 %r16 to i576
%r18 = lshr i576 %r17, 512
%r19 = trunc i576 %r18 to i64
%r21 = or i64 %r19, -512
%r22 = lshr i576 %r17, 0
%r23 = trunc i576 %r22 to i64
%r24 = and i64 %r21, %r23
%r25 = lshr i576 %r17, 64
%r26 = trunc i576 %r25 to i64
%r27 = and i64 %r24, %r26
%r28 = lshr i576 %r17, 128
%r29 = trunc i576 %r28 to i64
%r30 = and i64 %r27, %r29
%r31 = lshr i576 %r17, 192
%r32 = trunc i576 %r31 to i64
%r33 = and i64 %r30, %r32
%r34 = lshr i576 %r17, 256
%r35 = trunc i576 %r34 to i64
%r36 = and i64 %r33, %r35
%r37 = lshr i576 %r17, 320
%r38 = trunc i576 %r37 to i64
%r39 = and i64 %r36, %r38
%r40 = lshr i576 %r17, 384
%r41 = trunc i576 %r40 to i64
%r42 = and i64 %r39, %r41
%r43 = lshr i576 %r17, 448
%r44 = trunc i576 %r43 to i64
%r45 = and i64 %r42, %r44
%r47 = icmp eq i64 %r45, -1
br i1%r47, label %zero, label %nonzero
zero:
store i64 0, i64* %r1
%r51 = getelementptr i64, i64* %r1, i32 1
store i64 0, i64* %r51
%r54 = getelementptr i64, i64* %r1, i32 2
store i64 0, i64* %r54
%r57 = getelementptr i64, i64* %r1, i32 3
store i64 0, i64* %r57
%r60 = getelementptr i64, i64* %r1, i32 4
store i64 0, i64* %r60
%r63 = getelementptr i64, i64* %r1, i32 5
store i64 0, i64* %r63
%r66 = getelementptr i64, i64* %r1, i32 6
store i64 0, i64* %r66
%r69 = getelementptr i64, i64* %r1, i32 7
store i64 0, i64* %r69
%r72 = getelementptr i64, i64* %r1, i32 8
store i64 0, i64* %r72
ret void
nonzero:
%r74 = bitcast i64* %r1 to i576*
store i576 %r17, i576* %r74
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
%r25 = bitcast i64* %r23 to i256*
store i256 %r21, i256* %r25
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
%r24 = bitcast i64* %r22 to i256*
store i256 %r20, i256* %r24
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
%r45 = bitcast i64* %r4 to i192*
%r46 = load i192, i192* %r45
%r47 = zext i192 %r46 to i256
%r48 = sub i256 %r43, %r47
%r49 = lshr i256 %r48, 192
%r50 = trunc i256 %r49 to i1
%r51 = select i1 %r50, i256 %r43, i256 %r48
%r52 = trunc i256 %r51 to i192
%r54 = bitcast i64* %r1 to i192*
store i192 %r52, i192* %r54
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
%r37 = bitcast i64* %r4 to i192*
%r38 = load i192, i192* %r37
%r39 = sub i192 %r35, %r38
%r40 = lshr i192 %r39, 191
%r41 = trunc i192 %r40 to i1
%r42 = select i1 %r41, i192 %r35, i192 %r39
%r44 = bitcast i64* %r1 to i192*
store i192 %r42, i192* %r44
ret void
}
define void @mcl_fp_montRed3L(i64* noalias  %r1, i64* noalias  %r2, i64* noalias  %r3)
{
%r5 = getelementptr i64, i64* %r3, i32 -1
%r6 = load i64, i64* %r5
%r8 = bitcast i64* %r3 to i192*
%r9 = load i192, i192* %r8
%r11 = bitcast i64* %r2 to i192*
%r12 = load i192, i192* %r11
%r13 = trunc i192 %r12 to i64
%r14 = mul i64 %r13, %r6
%r15 = call i256 @mulPv192x64(i64* %r3, i64 %r14)
%r17 = getelementptr i64, i64* %r2, i32 3
%r18 = load i64, i64* %r17
%r19 = zext i64 %r18 to i256
%r20 = shl i256 %r19, 192
%r21 = zext i192 %r12 to i256
%r22 = or i256 %r20, %r21
%r23 = zext i256 %r22 to i320
%r24 = zext i256 %r15 to i320
%r25 = add i320 %r23, %r24
%r26 = lshr i320 %r25, 64
%r27 = trunc i320 %r26 to i256
%r28 = lshr i256 %r27, 192
%r29 = trunc i256 %r28 to i64
%r30 = trunc i256 %r27 to i192
%r31 = trunc i192 %r30 to i64
%r32 = mul i64 %r31, %r6
%r33 = call i256 @mulPv192x64(i64* %r3, i64 %r32)
%r34 = zext i64 %r29 to i256
%r35 = shl i256 %r34, 192
%r36 = add i256 %r33, %r35
%r38 = getelementptr i64, i64* %r2, i32 4
%r39 = load i64, i64* %r38
%r40 = zext i64 %r39 to i256
%r41 = shl i256 %r40, 192
%r42 = zext i192 %r30 to i256
%r43 = or i256 %r41, %r42
%r44 = zext i256 %r43 to i320
%r45 = zext i256 %r36 to i320
%r46 = add i320 %r44, %r45
%r47 = lshr i320 %r46, 64
%r48 = trunc i320 %r47 to i256
%r49 = lshr i256 %r48, 192
%r50 = trunc i256 %r49 to i64
%r51 = trunc i256 %r48 to i192
%r52 = trunc i192 %r51 to i64
%r53 = mul i64 %r52, %r6
%r54 = call i256 @mulPv192x64(i64* %r3, i64 %r53)
%r55 = zext i64 %r50 to i256
%r56 = shl i256 %r55, 192
%r57 = add i256 %r54, %r56
%r59 = getelementptr i64, i64* %r2, i32 5
%r60 = load i64, i64* %r59
%r61 = zext i64 %r60 to i256
%r62 = shl i256 %r61, 192
%r63 = zext i192 %r51 to i256
%r64 = or i256 %r62, %r63
%r65 = zext i256 %r64 to i320
%r66 = zext i256 %r57 to i320
%r67 = add i320 %r65, %r66
%r68 = lshr i320 %r67, 64
%r69 = trunc i320 %r68 to i256
%r70 = lshr i256 %r69, 192
%r71 = trunc i256 %r70 to i64
%r72 = trunc i256 %r69 to i192
%r73 = zext i192 %r9 to i256
%r74 = zext i64 %r71 to i256
%r75 = shl i256 %r74, 192
%r76 = zext i192 %r72 to i256
%r77 = or i256 %r75, %r76
%r78 = sub i256 %r77, %r73
%r79 = lshr i256 %r78, 192
%r80 = trunc i256 %r79 to i1
%r81 = select i1 %r80, i256 %r77, i256 %r78
%r82 = trunc i256 %r81 to i192
%r84 = bitcast i64* %r1 to i192*
store i192 %r82, i192* %r84
ret void
}
define void @mcl_fp_montRedNF3L(i64* noalias  %r1, i64* noalias  %r2, i64* noalias  %r3)
{
%r5 = getelementptr i64, i64* %r3, i32 -1
%r6 = load i64, i64* %r5
%r8 = bitcast i64* %r3 to i192*
%r9 = load i192, i192* %r8
%r11 = bitcast i64* %r2 to i192*
%r12 = load i192, i192* %r11
%r13 = trunc i192 %r12 to i64
%r14 = mul i64 %r13, %r6
%r15 = call i256 @mulPv192x64(i64* %r3, i64 %r14)
%r17 = getelementptr i64, i64* %r2, i32 3
%r18 = load i64, i64* %r17
%r19 = zext i64 %r18 to i256
%r20 = shl i256 %r19, 192
%r21 = zext i192 %r12 to i256
%r22 = or i256 %r20, %r21
%r23 = zext i256 %r22 to i320
%r24 = zext i256 %r15 to i320
%r25 = add i320 %r23, %r24
%r26 = lshr i320 %r25, 64
%r27 = trunc i320 %r26 to i256
%r28 = lshr i256 %r27, 192
%r29 = trunc i256 %r28 to i64
%r30 = trunc i256 %r27 to i192
%r31 = trunc i192 %r30 to i64
%r32 = mul i64 %r31, %r6
%r33 = call i256 @mulPv192x64(i64* %r3, i64 %r32)
%r34 = zext i64 %r29 to i256
%r35 = shl i256 %r34, 192
%r36 = add i256 %r33, %r35
%r38 = getelementptr i64, i64* %r2, i32 4
%r39 = load i64, i64* %r38
%r40 = zext i64 %r39 to i256
%r41 = shl i256 %r40, 192
%r42 = zext i192 %r30 to i256
%r43 = or i256 %r41, %r42
%r44 = zext i256 %r43 to i320
%r45 = zext i256 %r36 to i320
%r46 = add i320 %r44, %r45
%r47 = lshr i320 %r46, 64
%r48 = trunc i320 %r47 to i256
%r49 = lshr i256 %r48, 192
%r50 = trunc i256 %r49 to i64
%r51 = trunc i256 %r48 to i192
%r52 = trunc i192 %r51 to i64
%r53 = mul i64 %r52, %r6
%r54 = call i256 @mulPv192x64(i64* %r3, i64 %r53)
%r55 = zext i64 %r50 to i256
%r56 = shl i256 %r55, 192
%r57 = add i256 %r54, %r56
%r59 = getelementptr i64, i64* %r2, i32 5
%r60 = load i64, i64* %r59
%r61 = zext i64 %r60 to i256
%r62 = shl i256 %r61, 192
%r63 = zext i192 %r51 to i256
%r64 = or i256 %r62, %r63
%r65 = zext i256 %r64 to i320
%r66 = zext i256 %r57 to i320
%r67 = add i320 %r65, %r66
%r68 = lshr i320 %r67, 64
%r69 = trunc i320 %r68 to i256
%r70 = lshr i256 %r69, 192
%r71 = trunc i256 %r70 to i64
%r72 = trunc i256 %r69 to i192
%r73 = sub i192 %r72, %r9
%r74 = lshr i192 %r73, 191
%r75 = trunc i192 %r74 to i1
%r76 = select i1 %r75, i192 %r72, i192 %r73
%r78 = bitcast i64* %r1 to i192*
store i192 %r76, i192* %r78
ret void
}
define i64 @mcl_fp_addPre3L(i64* noalias  %r2, i64* noalias  %r3, i64* noalias  %r4)
{
%r6 = bitcast i64* %r3 to i192*
%r7 = load i192, i192* %r6
%r8 = zext i192 %r7 to i256
%r10 = bitcast i64* %r4 to i192*
%r11 = load i192, i192* %r10
%r12 = zext i192 %r11 to i256
%r13 = add i256 %r8, %r12
%r14 = trunc i256 %r13 to i192
%r16 = bitcast i64* %r2 to i192*
store i192 %r14, i192* %r16
%r17 = lshr i256 %r13, 192
%r18 = trunc i256 %r17 to i64
ret i64 %r18
}
define i64 @mcl_fp_subPre3L(i64* noalias  %r2, i64* noalias  %r3, i64* noalias  %r4)
{
%r6 = bitcast i64* %r3 to i192*
%r7 = load i192, i192* %r6
%r8 = zext i192 %r7 to i256
%r10 = bitcast i64* %r4 to i192*
%r11 = load i192, i192* %r10
%r12 = zext i192 %r11 to i256
%r13 = sub i256 %r8, %r12
%r14 = trunc i256 %r13 to i192
%r16 = bitcast i64* %r2 to i192*
store i192 %r14, i192* %r16
%r18 = lshr i256 %r13, 192
%r19 = trunc i256 %r18 to i64
%r20 = and i64 %r19, 1
ret i64 %r20
}
define void @mcl_fp_shr1_3L(i64* noalias  %r1, i64* noalias  %r2)
{
%r4 = bitcast i64* %r2 to i192*
%r5 = load i192, i192* %r4
%r6 = lshr i192 %r5, 1
%r8 = bitcast i64* %r1 to i192*
store i192 %r6, i192* %r8
ret void
}
define void @mcl_fp_add3L(i64* noalias  %r1, i64* noalias  %r2, i64* noalias  %r3, i64* noalias  %r4)
{
%r6 = bitcast i64* %r2 to i192*
%r7 = load i192, i192* %r6
%r9 = bitcast i64* %r3 to i192*
%r10 = load i192, i192* %r9
%r11 = zext i192 %r7 to i256
%r12 = zext i192 %r10 to i256
%r13 = add i256 %r11, %r12
%r15 = bitcast i64* %r4 to i192*
%r16 = load i192, i192* %r15
%r17 = zext i192 %r16 to i256
%r18 = sub i256 %r13, %r17
%r19 = lshr i256 %r18, 192
%r20 = trunc i256 %r19 to i1
%r21 = select i1 %r20, i256 %r13, i256 %r18
%r22 = trunc i256 %r21 to i192
%r24 = bitcast i64* %r1 to i192*
store i192 %r22, i192* %r24
ret void
}
define void @mcl_fp_addNF3L(i64* noalias  %r1, i64* noalias  %r2, i64* noalias  %r3, i64* noalias  %r4)
{
%r6 = bitcast i64* %r2 to i192*
%r7 = load i192, i192* %r6
%r9 = bitcast i64* %r3 to i192*
%r10 = load i192, i192* %r9
%r11 = add i192 %r7, %r10
%r13 = bitcast i64* %r4 to i192*
%r14 = load i192, i192* %r13
%r15 = sub i192 %r11, %r14
%r16 = lshr i192 %r15, 191
%r17 = trunc i192 %r16 to i1
%r18 = select i1 %r17, i192 %r11, i192 %r15
%r20 = bitcast i64* %r1 to i192*
store i192 %r18, i192* %r20
ret void
}
define void @mcl_fp_sub3L(i64* noalias  %r1, i64* noalias  %r2, i64* noalias  %r3, i64* noalias  %r4)
{
%r6 = bitcast i64* %r2 to i192*
%r7 = load i192, i192* %r6
%r9 = bitcast i64* %r3 to i192*
%r10 = load i192, i192* %r9
%r11 = zext i192 %r7 to i193
%r12 = zext i192 %r10 to i193
%r13 = sub i193 %r11, %r12
%r14 = lshr i193 %r13, 192
%r15 = trunc i193 %r14 to i1
%r16 = trunc i193 %r13 to i192
%r18 = bitcast i64* %r4 to i192*
%r19 = load i192, i192* %r18
%r21 = select i1 %r15, i192 %r19, i192 0
%r22 = add i192 %r16, %r21
%r24 = bitcast i64* %r1 to i192*
store i192 %r22, i192* %r24
ret void
}
define void @mcl_fp_subNF3L(i64* noalias  %r1, i64* noalias  %r2, i64* noalias  %r3, i64* noalias  %r4)
{
%r6 = bitcast i64* %r2 to i192*
%r7 = load i192, i192* %r6
%r9 = bitcast i64* %r3 to i192*
%r10 = load i192, i192* %r9
%r11 = sub i192 %r7, %r10
%r12 = lshr i192 %r11, 191
%r13 = trunc i192 %r12 to i1
%r15 = bitcast i64* %r4 to i192*
%r16 = load i192, i192* %r15
%r18 = select i1 %r13, i192 %r16, i192 0
%r19 = add i192 %r11, %r18
%r21 = bitcast i64* %r1 to i192*
store i192 %r19, i192* %r21
ret void
}
define void @mcl_fpDbl_add3L(i64* noalias  %r1, i64* noalias  %r2, i64* noalias  %r3, i64* noalias  %r4)
{
%r6 = bitcast i64* %r2 to i384*
%r7 = load i384, i384* %r6
%r9 = bitcast i64* %r3 to i384*
%r10 = load i384, i384* %r9
%r11 = zext i384 %r7 to i448
%r12 = zext i384 %r10 to i448
%r13 = add i448 %r11, %r12
%r14 = trunc i448 %r13 to i192
%r16 = bitcast i64* %r1 to i192*
store i192 %r14, i192* %r16
%r17 = lshr i448 %r13, 192
%r18 = trunc i448 %r17 to i256
%r20 = bitcast i64* %r4 to i192*
%r21 = load i192, i192* %r20
%r22 = zext i192 %r21 to i256
%r23 = sub i256 %r18, %r22
%r24 = lshr i256 %r23, 192
%r25 = trunc i256 %r24 to i1
%r26 = select i1 %r25, i256 %r18, i256 %r23
%r27 = trunc i256 %r26 to i192
%r29 = getelementptr i64, i64* %r1, i32 3
%r31 = bitcast i64* %r29 to i192*
store i192 %r27, i192* %r31
ret void
}
define void @mcl_fpDbl_sub3L(i64* noalias  %r1, i64* noalias  %r2, i64* noalias  %r3, i64* noalias  %r4)
{
%r6 = bitcast i64* %r2 to i384*
%r7 = load i384, i384* %r6
%r9 = bitcast i64* %r3 to i384*
%r10 = load i384, i384* %r9
%r11 = zext i384 %r7 to i448
%r12 = zext i384 %r10 to i448
%r13 = sub i448 %r11, %r12
%r14 = trunc i448 %r13 to i192
%r16 = bitcast i64* %r1 to i192*
store i192 %r14, i192* %r16
%r17 = lshr i448 %r13, 192
%r18 = trunc i448 %r17 to i192
%r19 = lshr i448 %r13, 384
%r20 = trunc i448 %r19 to i1
%r22 = bitcast i64* %r4 to i192*
%r23 = load i192, i192* %r22
%r25 = select i1 %r20, i192 %r23, i192 0
%r26 = add i192 %r18, %r25
%r28 = getelementptr i64, i64* %r1, i32 3
%r30 = bitcast i64* %r28 to i192*
store i192 %r26, i192* %r30
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
%r57 = bitcast i64* %r4 to i256*
%r58 = load i256, i256* %r57
%r59 = zext i256 %r58 to i320
%r60 = sub i320 %r55, %r59
%r61 = lshr i320 %r60, 256
%r62 = trunc i320 %r61 to i1
%r63 = select i1 %r62, i320 %r55, i320 %r60
%r64 = trunc i320 %r63 to i256
%r66 = bitcast i64* %r1 to i256*
store i256 %r64, i256* %r66
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
%r47 = bitcast i64* %r4 to i256*
%r48 = load i256, i256* %r47
%r49 = sub i256 %r45, %r48
%r50 = lshr i256 %r49, 255
%r51 = trunc i256 %r50 to i1
%r52 = select i1 %r51, i256 %r45, i256 %r49
%r54 = bitcast i64* %r1 to i256*
store i256 %r52, i256* %r54
ret void
}
define void @mcl_fp_montRed4L(i64* noalias  %r1, i64* noalias  %r2, i64* noalias  %r3)
{
%r5 = getelementptr i64, i64* %r3, i32 -1
%r6 = load i64, i64* %r5
%r8 = bitcast i64* %r3 to i256*
%r9 = load i256, i256* %r8
%r11 = bitcast i64* %r2 to i256*
%r12 = load i256, i256* %r11
%r13 = trunc i256 %r12 to i64
%r14 = mul i64 %r13, %r6
%r15 = call i320 @mulPv256x64(i64* %r3, i64 %r14)
%r17 = getelementptr i64, i64* %r2, i32 4
%r18 = load i64, i64* %r17
%r19 = zext i64 %r18 to i320
%r20 = shl i320 %r19, 256
%r21 = zext i256 %r12 to i320
%r22 = or i320 %r20, %r21
%r23 = zext i320 %r22 to i384
%r24 = zext i320 %r15 to i384
%r25 = add i384 %r23, %r24
%r26 = lshr i384 %r25, 64
%r27 = trunc i384 %r26 to i320
%r28 = lshr i320 %r27, 256
%r29 = trunc i320 %r28 to i64
%r30 = trunc i320 %r27 to i256
%r31 = trunc i256 %r30 to i64
%r32 = mul i64 %r31, %r6
%r33 = call i320 @mulPv256x64(i64* %r3, i64 %r32)
%r34 = zext i64 %r29 to i320
%r35 = shl i320 %r34, 256
%r36 = add i320 %r33, %r35
%r38 = getelementptr i64, i64* %r2, i32 5
%r39 = load i64, i64* %r38
%r40 = zext i64 %r39 to i320
%r41 = shl i320 %r40, 256
%r42 = zext i256 %r30 to i320
%r43 = or i320 %r41, %r42
%r44 = zext i320 %r43 to i384
%r45 = zext i320 %r36 to i384
%r46 = add i384 %r44, %r45
%r47 = lshr i384 %r46, 64
%r48 = trunc i384 %r47 to i320
%r49 = lshr i320 %r48, 256
%r50 = trunc i320 %r49 to i64
%r51 = trunc i320 %r48 to i256
%r52 = trunc i256 %r51 to i64
%r53 = mul i64 %r52, %r6
%r54 = call i320 @mulPv256x64(i64* %r3, i64 %r53)
%r55 = zext i64 %r50 to i320
%r56 = shl i320 %r55, 256
%r57 = add i320 %r54, %r56
%r59 = getelementptr i64, i64* %r2, i32 6
%r60 = load i64, i64* %r59
%r61 = zext i64 %r60 to i320
%r62 = shl i320 %r61, 256
%r63 = zext i256 %r51 to i320
%r64 = or i320 %r62, %r63
%r65 = zext i320 %r64 to i384
%r66 = zext i320 %r57 to i384
%r67 = add i384 %r65, %r66
%r68 = lshr i384 %r67, 64
%r69 = trunc i384 %r68 to i320
%r70 = lshr i320 %r69, 256
%r71 = trunc i320 %r70 to i64
%r72 = trunc i320 %r69 to i256
%r73 = trunc i256 %r72 to i64
%r74 = mul i64 %r73, %r6
%r75 = call i320 @mulPv256x64(i64* %r3, i64 %r74)
%r76 = zext i64 %r71 to i320
%r77 = shl i320 %r76, 256
%r78 = add i320 %r75, %r77
%r80 = getelementptr i64, i64* %r2, i32 7
%r81 = load i64, i64* %r80
%r82 = zext i64 %r81 to i320
%r83 = shl i320 %r82, 256
%r84 = zext i256 %r72 to i320
%r85 = or i320 %r83, %r84
%r86 = zext i320 %r85 to i384
%r87 = zext i320 %r78 to i384
%r88 = add i384 %r86, %r87
%r89 = lshr i384 %r88, 64
%r90 = trunc i384 %r89 to i320
%r91 = lshr i320 %r90, 256
%r92 = trunc i320 %r91 to i64
%r93 = trunc i320 %r90 to i256
%r94 = zext i256 %r9 to i320
%r95 = zext i64 %r92 to i320
%r96 = shl i320 %r95, 256
%r97 = zext i256 %r93 to i320
%r98 = or i320 %r96, %r97
%r99 = sub i320 %r98, %r94
%r100 = lshr i320 %r99, 256
%r101 = trunc i320 %r100 to i1
%r102 = select i1 %r101, i320 %r98, i320 %r99
%r103 = trunc i320 %r102 to i256
%r105 = bitcast i64* %r1 to i256*
store i256 %r103, i256* %r105
ret void
}
define void @mcl_fp_montRedNF4L(i64* noalias  %r1, i64* noalias  %r2, i64* noalias  %r3)
{
%r5 = getelementptr i64, i64* %r3, i32 -1
%r6 = load i64, i64* %r5
%r8 = bitcast i64* %r3 to i256*
%r9 = load i256, i256* %r8
%r11 = bitcast i64* %r2 to i256*
%r12 = load i256, i256* %r11
%r13 = trunc i256 %r12 to i64
%r14 = mul i64 %r13, %r6
%r15 = call i320 @mulPv256x64(i64* %r3, i64 %r14)
%r17 = getelementptr i64, i64* %r2, i32 4
%r18 = load i64, i64* %r17
%r19 = zext i64 %r18 to i320
%r20 = shl i320 %r19, 256
%r21 = zext i256 %r12 to i320
%r22 = or i320 %r20, %r21
%r23 = zext i320 %r22 to i384
%r24 = zext i320 %r15 to i384
%r25 = add i384 %r23, %r24
%r26 = lshr i384 %r25, 64
%r27 = trunc i384 %r26 to i320
%r28 = lshr i320 %r27, 256
%r29 = trunc i320 %r28 to i64
%r30 = trunc i320 %r27 to i256
%r31 = trunc i256 %r30 to i64
%r32 = mul i64 %r31, %r6
%r33 = call i320 @mulPv256x64(i64* %r3, i64 %r32)
%r34 = zext i64 %r29 to i320
%r35 = shl i320 %r34, 256
%r36 = add i320 %r33, %r35
%r38 = getelementptr i64, i64* %r2, i32 5
%r39 = load i64, i64* %r38
%r40 = zext i64 %r39 to i320
%r41 = shl i320 %r40, 256
%r42 = zext i256 %r30 to i320
%r43 = or i320 %r41, %r42
%r44 = zext i320 %r43 to i384
%r45 = zext i320 %r36 to i384
%r46 = add i384 %r44, %r45
%r47 = lshr i384 %r46, 64
%r48 = trunc i384 %r47 to i320
%r49 = lshr i320 %r48, 256
%r50 = trunc i320 %r49 to i64
%r51 = trunc i320 %r48 to i256
%r52 = trunc i256 %r51 to i64
%r53 = mul i64 %r52, %r6
%r54 = call i320 @mulPv256x64(i64* %r3, i64 %r53)
%r55 = zext i64 %r50 to i320
%r56 = shl i320 %r55, 256
%r57 = add i320 %r54, %r56
%r59 = getelementptr i64, i64* %r2, i32 6
%r60 = load i64, i64* %r59
%r61 = zext i64 %r60 to i320
%r62 = shl i320 %r61, 256
%r63 = zext i256 %r51 to i320
%r64 = or i320 %r62, %r63
%r65 = zext i320 %r64 to i384
%r66 = zext i320 %r57 to i384
%r67 = add i384 %r65, %r66
%r68 = lshr i384 %r67, 64
%r69 = trunc i384 %r68 to i320
%r70 = lshr i320 %r69, 256
%r71 = trunc i320 %r70 to i64
%r72 = trunc i320 %r69 to i256
%r73 = trunc i256 %r72 to i64
%r74 = mul i64 %r73, %r6
%r75 = call i320 @mulPv256x64(i64* %r3, i64 %r74)
%r76 = zext i64 %r71 to i320
%r77 = shl i320 %r76, 256
%r78 = add i320 %r75, %r77
%r80 = getelementptr i64, i64* %r2, i32 7
%r81 = load i64, i64* %r80
%r82 = zext i64 %r81 to i320
%r83 = shl i320 %r82, 256
%r84 = zext i256 %r72 to i320
%r85 = or i320 %r83, %r84
%r86 = zext i320 %r85 to i384
%r87 = zext i320 %r78 to i384
%r88 = add i384 %r86, %r87
%r89 = lshr i384 %r88, 64
%r90 = trunc i384 %r89 to i320
%r91 = lshr i320 %r90, 256
%r92 = trunc i320 %r91 to i64
%r93 = trunc i320 %r90 to i256
%r94 = sub i256 %r93, %r9
%r95 = lshr i256 %r94, 255
%r96 = trunc i256 %r95 to i1
%r97 = select i1 %r96, i256 %r93, i256 %r94
%r99 = bitcast i64* %r1 to i256*
store i256 %r97, i256* %r99
ret void
}
define i64 @mcl_fp_addPre4L(i64* noalias  %r2, i64* noalias  %r3, i64* noalias  %r4)
{
%r6 = bitcast i64* %r3 to i256*
%r7 = load i256, i256* %r6
%r8 = zext i256 %r7 to i320
%r10 = bitcast i64* %r4 to i256*
%r11 = load i256, i256* %r10
%r12 = zext i256 %r11 to i320
%r13 = add i320 %r8, %r12
%r14 = trunc i320 %r13 to i256
%r16 = bitcast i64* %r2 to i256*
store i256 %r14, i256* %r16
%r17 = lshr i320 %r13, 256
%r18 = trunc i320 %r17 to i64
ret i64 %r18
}
define i64 @mcl_fp_subPre4L(i64* noalias  %r2, i64* noalias  %r3, i64* noalias  %r4)
{
%r6 = bitcast i64* %r3 to i256*
%r7 = load i256, i256* %r6
%r8 = zext i256 %r7 to i320
%r10 = bitcast i64* %r4 to i256*
%r11 = load i256, i256* %r10
%r12 = zext i256 %r11 to i320
%r13 = sub i320 %r8, %r12
%r14 = trunc i320 %r13 to i256
%r16 = bitcast i64* %r2 to i256*
store i256 %r14, i256* %r16
%r18 = lshr i320 %r13, 256
%r19 = trunc i320 %r18 to i64
%r20 = and i64 %r19, 1
ret i64 %r20
}
define void @mcl_fp_shr1_4L(i64* noalias  %r1, i64* noalias  %r2)
{
%r4 = bitcast i64* %r2 to i256*
%r5 = load i256, i256* %r4
%r6 = lshr i256 %r5, 1
%r8 = bitcast i64* %r1 to i256*
store i256 %r6, i256* %r8
ret void
}
define void @mcl_fp_add4L(i64* noalias  %r1, i64* noalias  %r2, i64* noalias  %r3, i64* noalias  %r4)
{
%r6 = bitcast i64* %r2 to i256*
%r7 = load i256, i256* %r6
%r9 = bitcast i64* %r3 to i256*
%r10 = load i256, i256* %r9
%r11 = zext i256 %r7 to i320
%r12 = zext i256 %r10 to i320
%r13 = add i320 %r11, %r12
%r15 = bitcast i64* %r4 to i256*
%r16 = load i256, i256* %r15
%r17 = zext i256 %r16 to i320
%r18 = sub i320 %r13, %r17
%r19 = lshr i320 %r18, 256
%r20 = trunc i320 %r19 to i1
%r21 = select i1 %r20, i320 %r13, i320 %r18
%r22 = trunc i320 %r21 to i256
%r24 = bitcast i64* %r1 to i256*
store i256 %r22, i256* %r24
ret void
}
define void @mcl_fp_addNF4L(i64* noalias  %r1, i64* noalias  %r2, i64* noalias  %r3, i64* noalias  %r4)
{
%r6 = bitcast i64* %r2 to i256*
%r7 = load i256, i256* %r6
%r9 = bitcast i64* %r3 to i256*
%r10 = load i256, i256* %r9
%r11 = add i256 %r7, %r10
%r13 = bitcast i64* %r4 to i256*
%r14 = load i256, i256* %r13
%r15 = sub i256 %r11, %r14
%r16 = lshr i256 %r15, 255
%r17 = trunc i256 %r16 to i1
%r18 = select i1 %r17, i256 %r11, i256 %r15
%r20 = bitcast i64* %r1 to i256*
store i256 %r18, i256* %r20
ret void
}
define void @mcl_fp_sub4L(i64* noalias  %r1, i64* noalias  %r2, i64* noalias  %r3, i64* noalias  %r4)
{
%r6 = bitcast i64* %r2 to i256*
%r7 = load i256, i256* %r6
%r9 = bitcast i64* %r3 to i256*
%r10 = load i256, i256* %r9
%r11 = zext i256 %r7 to i257
%r12 = zext i256 %r10 to i257
%r13 = sub i257 %r11, %r12
%r14 = lshr i257 %r13, 256
%r15 = trunc i257 %r14 to i1
%r16 = trunc i257 %r13 to i256
%r18 = bitcast i64* %r4 to i256*
%r19 = load i256, i256* %r18
%r21 = select i1 %r15, i256 %r19, i256 0
%r22 = add i256 %r16, %r21
%r24 = bitcast i64* %r1 to i256*
store i256 %r22, i256* %r24
ret void
}
define void @mcl_fp_subNF4L(i64* noalias  %r1, i64* noalias  %r2, i64* noalias  %r3, i64* noalias  %r4)
{
%r6 = bitcast i64* %r2 to i256*
%r7 = load i256, i256* %r6
%r9 = bitcast i64* %r3 to i256*
%r10 = load i256, i256* %r9
%r11 = sub i256 %r7, %r10
%r12 = lshr i256 %r11, 255
%r13 = trunc i256 %r12 to i1
%r15 = bitcast i64* %r4 to i256*
%r16 = load i256, i256* %r15
%r18 = select i1 %r13, i256 %r16, i256 0
%r19 = add i256 %r11, %r18
%r21 = bitcast i64* %r1 to i256*
store i256 %r19, i256* %r21
ret void
}
define void @mcl_fpDbl_add4L(i64* noalias  %r1, i64* noalias  %r2, i64* noalias  %r3, i64* noalias  %r4)
{
%r6 = bitcast i64* %r2 to i512*
%r7 = load i512, i512* %r6
%r9 = bitcast i64* %r3 to i512*
%r10 = load i512, i512* %r9
%r11 = zext i512 %r7 to i576
%r12 = zext i512 %r10 to i576
%r13 = add i576 %r11, %r12
%r14 = trunc i576 %r13 to i256
%r16 = bitcast i64* %r1 to i256*
store i256 %r14, i256* %r16
%r17 = lshr i576 %r13, 256
%r18 = trunc i576 %r17 to i320
%r20 = bitcast i64* %r4 to i256*
%r21 = load i256, i256* %r20
%r22 = zext i256 %r21 to i320
%r23 = sub i320 %r18, %r22
%r24 = lshr i320 %r23, 256
%r25 = trunc i320 %r24 to i1
%r26 = select i1 %r25, i320 %r18, i320 %r23
%r27 = trunc i320 %r26 to i256
%r29 = getelementptr i64, i64* %r1, i32 4
%r31 = bitcast i64* %r29 to i256*
store i256 %r27, i256* %r31
ret void
}
define void @mcl_fpDbl_sub4L(i64* noalias  %r1, i64* noalias  %r2, i64* noalias  %r3, i64* noalias  %r4)
{
%r6 = bitcast i64* %r2 to i512*
%r7 = load i512, i512* %r6
%r9 = bitcast i64* %r3 to i512*
%r10 = load i512, i512* %r9
%r11 = zext i512 %r7 to i576
%r12 = zext i512 %r10 to i576
%r13 = sub i576 %r11, %r12
%r14 = trunc i576 %r13 to i256
%r16 = bitcast i64* %r1 to i256*
store i256 %r14, i256* %r16
%r17 = lshr i576 %r13, 256
%r18 = trunc i576 %r17 to i256
%r19 = lshr i576 %r13, 512
%r20 = trunc i576 %r19 to i1
%r22 = bitcast i64* %r4 to i256*
%r23 = load i256, i256* %r22
%r25 = select i1 %r20, i256 %r23, i256 0
%r26 = add i256 %r18, %r25
%r28 = getelementptr i64, i64* %r1, i32 4
%r30 = bitcast i64* %r28 to i256*
store i256 %r26, i256* %r30
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
%r81 = bitcast i64* %r4 to i384*
%r82 = load i384, i384* %r81
%r83 = zext i384 %r82 to i448
%r84 = sub i448 %r79, %r83
%r85 = lshr i448 %r84, 384
%r86 = trunc i448 %r85 to i1
%r87 = select i1 %r86, i448 %r79, i448 %r84
%r88 = trunc i448 %r87 to i384
%r90 = bitcast i64* %r1 to i384*
store i384 %r88, i384* %r90
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
%r67 = bitcast i64* %r4 to i384*
%r68 = load i384, i384* %r67
%r69 = sub i384 %r65, %r68
%r70 = lshr i384 %r69, 383
%r71 = trunc i384 %r70 to i1
%r72 = select i1 %r71, i384 %r65, i384 %r69
%r74 = bitcast i64* %r1 to i384*
store i384 %r72, i384* %r74
ret void
}
define void @mcl_fp_montRed6L(i64* noalias  %r1, i64* noalias  %r2, i64* noalias  %r3)
{
%r5 = getelementptr i64, i64* %r3, i32 -1
%r6 = load i64, i64* %r5
%r8 = bitcast i64* %r3 to i384*
%r9 = load i384, i384* %r8
%r11 = bitcast i64* %r2 to i384*
%r12 = load i384, i384* %r11
%r13 = trunc i384 %r12 to i64
%r14 = mul i64 %r13, %r6
%r15 = call i448 @mulPv384x64(i64* %r3, i64 %r14)
%r17 = getelementptr i64, i64* %r2, i32 6
%r18 = load i64, i64* %r17
%r19 = zext i64 %r18 to i448
%r20 = shl i448 %r19, 384
%r21 = zext i384 %r12 to i448
%r22 = or i448 %r20, %r21
%r23 = zext i448 %r22 to i512
%r24 = zext i448 %r15 to i512
%r25 = add i512 %r23, %r24
%r26 = lshr i512 %r25, 64
%r27 = trunc i512 %r26 to i448
%r28 = lshr i448 %r27, 384
%r29 = trunc i448 %r28 to i64
%r30 = trunc i448 %r27 to i384
%r31 = trunc i384 %r30 to i64
%r32 = mul i64 %r31, %r6
%r33 = call i448 @mulPv384x64(i64* %r3, i64 %r32)
%r34 = zext i64 %r29 to i448
%r35 = shl i448 %r34, 384
%r36 = add i448 %r33, %r35
%r38 = getelementptr i64, i64* %r2, i32 7
%r39 = load i64, i64* %r38
%r40 = zext i64 %r39 to i448
%r41 = shl i448 %r40, 384
%r42 = zext i384 %r30 to i448
%r43 = or i448 %r41, %r42
%r44 = zext i448 %r43 to i512
%r45 = zext i448 %r36 to i512
%r46 = add i512 %r44, %r45
%r47 = lshr i512 %r46, 64
%r48 = trunc i512 %r47 to i448
%r49 = lshr i448 %r48, 384
%r50 = trunc i448 %r49 to i64
%r51 = trunc i448 %r48 to i384
%r52 = trunc i384 %r51 to i64
%r53 = mul i64 %r52, %r6
%r54 = call i448 @mulPv384x64(i64* %r3, i64 %r53)
%r55 = zext i64 %r50 to i448
%r56 = shl i448 %r55, 384
%r57 = add i448 %r54, %r56
%r59 = getelementptr i64, i64* %r2, i32 8
%r60 = load i64, i64* %r59
%r61 = zext i64 %r60 to i448
%r62 = shl i448 %r61, 384
%r63 = zext i384 %r51 to i448
%r64 = or i448 %r62, %r63
%r65 = zext i448 %r64 to i512
%r66 = zext i448 %r57 to i512
%r67 = add i512 %r65, %r66
%r68 = lshr i512 %r67, 64
%r69 = trunc i512 %r68 to i448
%r70 = lshr i448 %r69, 384
%r71 = trunc i448 %r70 to i64
%r72 = trunc i448 %r69 to i384
%r73 = trunc i384 %r72 to i64
%r74 = mul i64 %r73, %r6
%r75 = call i448 @mulPv384x64(i64* %r3, i64 %r74)
%r76 = zext i64 %r71 to i448
%r77 = shl i448 %r76, 384
%r78 = add i448 %r75, %r77
%r80 = getelementptr i64, i64* %r2, i32 9
%r81 = load i64, i64* %r80
%r82 = zext i64 %r81 to i448
%r83 = shl i448 %r82, 384
%r84 = zext i384 %r72 to i448
%r85 = or i448 %r83, %r84
%r86 = zext i448 %r85 to i512
%r87 = zext i448 %r78 to i512
%r88 = add i512 %r86, %r87
%r89 = lshr i512 %r88, 64
%r90 = trunc i512 %r89 to i448
%r91 = lshr i448 %r90, 384
%r92 = trunc i448 %r91 to i64
%r93 = trunc i448 %r90 to i384
%r94 = trunc i384 %r93 to i64
%r95 = mul i64 %r94, %r6
%r96 = call i448 @mulPv384x64(i64* %r3, i64 %r95)
%r97 = zext i64 %r92 to i448
%r98 = shl i448 %r97, 384
%r99 = add i448 %r96, %r98
%r101 = getelementptr i64, i64* %r2, i32 10
%r102 = load i64, i64* %r101
%r103 = zext i64 %r102 to i448
%r104 = shl i448 %r103, 384
%r105 = zext i384 %r93 to i448
%r106 = or i448 %r104, %r105
%r107 = zext i448 %r106 to i512
%r108 = zext i448 %r99 to i512
%r109 = add i512 %r107, %r108
%r110 = lshr i512 %r109, 64
%r111 = trunc i512 %r110 to i448
%r112 = lshr i448 %r111, 384
%r113 = trunc i448 %r112 to i64
%r114 = trunc i448 %r111 to i384
%r115 = trunc i384 %r114 to i64
%r116 = mul i64 %r115, %r6
%r117 = call i448 @mulPv384x64(i64* %r3, i64 %r116)
%r118 = zext i64 %r113 to i448
%r119 = shl i448 %r118, 384
%r120 = add i448 %r117, %r119
%r122 = getelementptr i64, i64* %r2, i32 11
%r123 = load i64, i64* %r122
%r124 = zext i64 %r123 to i448
%r125 = shl i448 %r124, 384
%r126 = zext i384 %r114 to i448
%r127 = or i448 %r125, %r126
%r128 = zext i448 %r127 to i512
%r129 = zext i448 %r120 to i512
%r130 = add i512 %r128, %r129
%r131 = lshr i512 %r130, 64
%r132 = trunc i512 %r131 to i448
%r133 = lshr i448 %r132, 384
%r134 = trunc i448 %r133 to i64
%r135 = trunc i448 %r132 to i384
%r136 = zext i384 %r9 to i448
%r137 = zext i64 %r134 to i448
%r138 = shl i448 %r137, 384
%r139 = zext i384 %r135 to i448
%r140 = or i448 %r138, %r139
%r141 = sub i448 %r140, %r136
%r142 = lshr i448 %r141, 384
%r143 = trunc i448 %r142 to i1
%r144 = select i1 %r143, i448 %r140, i448 %r141
%r145 = trunc i448 %r144 to i384
%r147 = bitcast i64* %r1 to i384*
store i384 %r145, i384* %r147
ret void
}
define void @mcl_fp_montRedNF6L(i64* noalias  %r1, i64* noalias  %r2, i64* noalias  %r3)
{
%r5 = getelementptr i64, i64* %r3, i32 -1
%r6 = load i64, i64* %r5
%r8 = bitcast i64* %r3 to i384*
%r9 = load i384, i384* %r8
%r11 = bitcast i64* %r2 to i384*
%r12 = load i384, i384* %r11
%r13 = trunc i384 %r12 to i64
%r14 = mul i64 %r13, %r6
%r15 = call i448 @mulPv384x64(i64* %r3, i64 %r14)
%r17 = getelementptr i64, i64* %r2, i32 6
%r18 = load i64, i64* %r17
%r19 = zext i64 %r18 to i448
%r20 = shl i448 %r19, 384
%r21 = zext i384 %r12 to i448
%r22 = or i448 %r20, %r21
%r23 = zext i448 %r22 to i512
%r24 = zext i448 %r15 to i512
%r25 = add i512 %r23, %r24
%r26 = lshr i512 %r25, 64
%r27 = trunc i512 %r26 to i448
%r28 = lshr i448 %r27, 384
%r29 = trunc i448 %r28 to i64
%r30 = trunc i448 %r27 to i384
%r31 = trunc i384 %r30 to i64
%r32 = mul i64 %r31, %r6
%r33 = call i448 @mulPv384x64(i64* %r3, i64 %r32)
%r34 = zext i64 %r29 to i448
%r35 = shl i448 %r34, 384
%r36 = add i448 %r33, %r35
%r38 = getelementptr i64, i64* %r2, i32 7
%r39 = load i64, i64* %r38
%r40 = zext i64 %r39 to i448
%r41 = shl i448 %r40, 384
%r42 = zext i384 %r30 to i448
%r43 = or i448 %r41, %r42
%r44 = zext i448 %r43 to i512
%r45 = zext i448 %r36 to i512
%r46 = add i512 %r44, %r45
%r47 = lshr i512 %r46, 64
%r48 = trunc i512 %r47 to i448
%r49 = lshr i448 %r48, 384
%r50 = trunc i448 %r49 to i64
%r51 = trunc i448 %r48 to i384
%r52 = trunc i384 %r51 to i64
%r53 = mul i64 %r52, %r6
%r54 = call i448 @mulPv384x64(i64* %r3, i64 %r53)
%r55 = zext i64 %r50 to i448
%r56 = shl i448 %r55, 384
%r57 = add i448 %r54, %r56
%r59 = getelementptr i64, i64* %r2, i32 8
%r60 = load i64, i64* %r59
%r61 = zext i64 %r60 to i448
%r62 = shl i448 %r61, 384
%r63 = zext i384 %r51 to i448
%r64 = or i448 %r62, %r63
%r65 = zext i448 %r64 to i512
%r66 = zext i448 %r57 to i512
%r67 = add i512 %r65, %r66
%r68 = lshr i512 %r67, 64
%r69 = trunc i512 %r68 to i448
%r70 = lshr i448 %r69, 384
%r71 = trunc i448 %r70 to i64
%r72 = trunc i448 %r69 to i384
%r73 = trunc i384 %r72 to i64
%r74 = mul i64 %r73, %r6
%r75 = call i448 @mulPv384x64(i64* %r3, i64 %r74)
%r76 = zext i64 %r71 to i448
%r77 = shl i448 %r76, 384
%r78 = add i448 %r75, %r77
%r80 = getelementptr i64, i64* %r2, i32 9
%r81 = load i64, i64* %r80
%r82 = zext i64 %r81 to i448
%r83 = shl i448 %r82, 384
%r84 = zext i384 %r72 to i448
%r85 = or i448 %r83, %r84
%r86 = zext i448 %r85 to i512
%r87 = zext i448 %r78 to i512
%r88 = add i512 %r86, %r87
%r89 = lshr i512 %r88, 64
%r90 = trunc i512 %r89 to i448
%r91 = lshr i448 %r90, 384
%r92 = trunc i448 %r91 to i64
%r93 = trunc i448 %r90 to i384
%r94 = trunc i384 %r93 to i64
%r95 = mul i64 %r94, %r6
%r96 = call i448 @mulPv384x64(i64* %r3, i64 %r95)
%r97 = zext i64 %r92 to i448
%r98 = shl i448 %r97, 384
%r99 = add i448 %r96, %r98
%r101 = getelementptr i64, i64* %r2, i32 10
%r102 = load i64, i64* %r101
%r103 = zext i64 %r102 to i448
%r104 = shl i448 %r103, 384
%r105 = zext i384 %r93 to i448
%r106 = or i448 %r104, %r105
%r107 = zext i448 %r106 to i512
%r108 = zext i448 %r99 to i512
%r109 = add i512 %r107, %r108
%r110 = lshr i512 %r109, 64
%r111 = trunc i512 %r110 to i448
%r112 = lshr i448 %r111, 384
%r113 = trunc i448 %r112 to i64
%r114 = trunc i448 %r111 to i384
%r115 = trunc i384 %r114 to i64
%r116 = mul i64 %r115, %r6
%r117 = call i448 @mulPv384x64(i64* %r3, i64 %r116)
%r118 = zext i64 %r113 to i448
%r119 = shl i448 %r118, 384
%r120 = add i448 %r117, %r119
%r122 = getelementptr i64, i64* %r2, i32 11
%r123 = load i64, i64* %r122
%r124 = zext i64 %r123 to i448
%r125 = shl i448 %r124, 384
%r126 = zext i384 %r114 to i448
%r127 = or i448 %r125, %r126
%r128 = zext i448 %r127 to i512
%r129 = zext i448 %r120 to i512
%r130 = add i512 %r128, %r129
%r131 = lshr i512 %r130, 64
%r132 = trunc i512 %r131 to i448
%r133 = lshr i448 %r132, 384
%r134 = trunc i448 %r133 to i64
%r135 = trunc i448 %r132 to i384
%r136 = sub i384 %r135, %r9
%r137 = lshr i384 %r136, 383
%r138 = trunc i384 %r137 to i1
%r139 = select i1 %r138, i384 %r135, i384 %r136
%r141 = bitcast i64* %r1 to i384*
store i384 %r139, i384* %r141
ret void
}
define i64 @mcl_fp_addPre6L(i64* noalias  %r2, i64* noalias  %r3, i64* noalias  %r4)
{
%r6 = bitcast i64* %r3 to i384*
%r7 = load i384, i384* %r6
%r8 = zext i384 %r7 to i448
%r10 = bitcast i64* %r4 to i384*
%r11 = load i384, i384* %r10
%r12 = zext i384 %r11 to i448
%r13 = add i448 %r8, %r12
%r14 = trunc i448 %r13 to i384
%r16 = bitcast i64* %r2 to i384*
store i384 %r14, i384* %r16
%r17 = lshr i448 %r13, 384
%r18 = trunc i448 %r17 to i64
ret i64 %r18
}
define i64 @mcl_fp_subPre6L(i64* noalias  %r2, i64* noalias  %r3, i64* noalias  %r4)
{
%r6 = bitcast i64* %r3 to i384*
%r7 = load i384, i384* %r6
%r8 = zext i384 %r7 to i448
%r10 = bitcast i64* %r4 to i384*
%r11 = load i384, i384* %r10
%r12 = zext i384 %r11 to i448
%r13 = sub i448 %r8, %r12
%r14 = trunc i448 %r13 to i384
%r16 = bitcast i64* %r2 to i384*
store i384 %r14, i384* %r16
%r18 = lshr i448 %r13, 384
%r19 = trunc i448 %r18 to i64
%r20 = and i64 %r19, 1
ret i64 %r20
}
define void @mcl_fp_shr1_6L(i64* noalias  %r1, i64* noalias  %r2)
{
%r4 = bitcast i64* %r2 to i384*
%r5 = load i384, i384* %r4
%r6 = lshr i384 %r5, 1
%r8 = bitcast i64* %r1 to i384*
store i384 %r6, i384* %r8
ret void
}
define void @mcl_fp_add6L(i64* noalias  %r1, i64* noalias  %r2, i64* noalias  %r3, i64* noalias  %r4)
{
%r6 = bitcast i64* %r2 to i384*
%r7 = load i384, i384* %r6
%r9 = bitcast i64* %r3 to i384*
%r10 = load i384, i384* %r9
%r11 = zext i384 %r7 to i448
%r12 = zext i384 %r10 to i448
%r13 = add i448 %r11, %r12
%r15 = bitcast i64* %r4 to i384*
%r16 = load i384, i384* %r15
%r17 = zext i384 %r16 to i448
%r18 = sub i448 %r13, %r17
%r19 = lshr i448 %r18, 384
%r20 = trunc i448 %r19 to i1
%r21 = select i1 %r20, i448 %r13, i448 %r18
%r22 = trunc i448 %r21 to i384
%r24 = bitcast i64* %r1 to i384*
store i384 %r22, i384* %r24
ret void
}
define void @mcl_fp_addNF6L(i64* noalias  %r1, i64* noalias  %r2, i64* noalias  %r3, i64* noalias  %r4)
{
%r6 = bitcast i64* %r2 to i384*
%r7 = load i384, i384* %r6
%r9 = bitcast i64* %r3 to i384*
%r10 = load i384, i384* %r9
%r11 = add i384 %r7, %r10
%r13 = bitcast i64* %r4 to i384*
%r14 = load i384, i384* %r13
%r15 = sub i384 %r11, %r14
%r16 = lshr i384 %r15, 383
%r17 = trunc i384 %r16 to i1
%r18 = select i1 %r17, i384 %r11, i384 %r15
%r20 = bitcast i64* %r1 to i384*
store i384 %r18, i384* %r20
ret void
}
define void @mcl_fp_sub6L(i64* noalias  %r1, i64* noalias  %r2, i64* noalias  %r3, i64* noalias  %r4)
{
%r6 = bitcast i64* %r2 to i384*
%r7 = load i384, i384* %r6
%r9 = bitcast i64* %r3 to i384*
%r10 = load i384, i384* %r9
%r11 = zext i384 %r7 to i385
%r12 = zext i384 %r10 to i385
%r13 = sub i385 %r11, %r12
%r14 = lshr i385 %r13, 384
%r15 = trunc i385 %r14 to i1
%r16 = trunc i385 %r13 to i384
%r18 = bitcast i64* %r4 to i384*
%r19 = load i384, i384* %r18
%r21 = select i1 %r15, i384 %r19, i384 0
%r22 = add i384 %r16, %r21
%r24 = bitcast i64* %r1 to i384*
store i384 %r22, i384* %r24
ret void
}
define void @mcl_fp_subNF6L(i64* noalias  %r1, i64* noalias  %r2, i64* noalias  %r3, i64* noalias  %r4)
{
%r6 = bitcast i64* %r2 to i384*
%r7 = load i384, i384* %r6
%r9 = bitcast i64* %r3 to i384*
%r10 = load i384, i384* %r9
%r11 = sub i384 %r7, %r10
%r12 = lshr i384 %r11, 383
%r13 = trunc i384 %r12 to i1
%r15 = bitcast i64* %r4 to i384*
%r16 = load i384, i384* %r15
%r18 = select i1 %r13, i384 %r16, i384 0
%r19 = add i384 %r11, %r18
%r21 = bitcast i64* %r1 to i384*
store i384 %r19, i384* %r21
ret void
}
define void @mcl_fpDbl_add6L(i64* noalias  %r1, i64* noalias  %r2, i64* noalias  %r3, i64* noalias  %r4)
{
%r6 = bitcast i64* %r2 to i768*
%r7 = load i768, i768* %r6
%r9 = bitcast i64* %r3 to i768*
%r10 = load i768, i768* %r9
%r11 = zext i768 %r7 to i832
%r12 = zext i768 %r10 to i832
%r13 = add i832 %r11, %r12
%r14 = trunc i832 %r13 to i384
%r16 = bitcast i64* %r1 to i384*
store i384 %r14, i384* %r16
%r17 = lshr i832 %r13, 384
%r18 = trunc i832 %r17 to i448
%r20 = bitcast i64* %r4 to i384*
%r21 = load i384, i384* %r20
%r22 = zext i384 %r21 to i448
%r23 = sub i448 %r18, %r22
%r24 = lshr i448 %r23, 384
%r25 = trunc i448 %r24 to i1
%r26 = select i1 %r25, i448 %r18, i448 %r23
%r27 = trunc i448 %r26 to i384
%r29 = getelementptr i64, i64* %r1, i32 6
%r31 = bitcast i64* %r29 to i384*
store i384 %r27, i384* %r31
ret void
}
define void @mcl_fpDbl_sub6L(i64* noalias  %r1, i64* noalias  %r2, i64* noalias  %r3, i64* noalias  %r4)
{
%r6 = bitcast i64* %r2 to i768*
%r7 = load i768, i768* %r6
%r9 = bitcast i64* %r3 to i768*
%r10 = load i768, i768* %r9
%r11 = zext i768 %r7 to i832
%r12 = zext i768 %r10 to i832
%r13 = sub i832 %r11, %r12
%r14 = trunc i832 %r13 to i384
%r16 = bitcast i64* %r1 to i384*
store i384 %r14, i384* %r16
%r17 = lshr i832 %r13, 384
%r18 = trunc i832 %r17 to i384
%r19 = lshr i832 %r13, 768
%r20 = trunc i832 %r19 to i1
%r22 = bitcast i64* %r4 to i384*
%r23 = load i384, i384* %r22
%r25 = select i1 %r20, i384 %r23, i384 0
%r26 = add i384 %r18, %r25
%r28 = getelementptr i64, i64* %r1, i32 6
%r30 = bitcast i64* %r28 to i384*
store i384 %r26, i384* %r30
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
%r105 = bitcast i64* %r4 to i512*
%r106 = load i512, i512* %r105
%r107 = zext i512 %r106 to i576
%r108 = sub i576 %r103, %r107
%r109 = lshr i576 %r108, 512
%r110 = trunc i576 %r109 to i1
%r111 = select i1 %r110, i576 %r103, i576 %r108
%r112 = trunc i576 %r111 to i512
%r114 = bitcast i64* %r1 to i512*
store i512 %r112, i512* %r114
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
%r87 = bitcast i64* %r4 to i512*
%r88 = load i512, i512* %r87
%r89 = sub i512 %r85, %r88
%r90 = lshr i512 %r89, 511
%r91 = trunc i512 %r90 to i1
%r92 = select i1 %r91, i512 %r85, i512 %r89
%r94 = bitcast i64* %r1 to i512*
store i512 %r92, i512* %r94
ret void
}
define void @mcl_fp_montRed8L(i64* noalias  %r1, i64* noalias  %r2, i64* noalias  %r3)
{
%r5 = getelementptr i64, i64* %r3, i32 -1
%r6 = load i64, i64* %r5
%r8 = bitcast i64* %r3 to i512*
%r9 = load i512, i512* %r8
%r11 = bitcast i64* %r2 to i512*
%r12 = load i512, i512* %r11
%r13 = trunc i512 %r12 to i64
%r14 = mul i64 %r13, %r6
%r15 = call i576 @mulPv512x64(i64* %r3, i64 %r14)
%r17 = getelementptr i64, i64* %r2, i32 8
%r18 = load i64, i64* %r17
%r19 = zext i64 %r18 to i576
%r20 = shl i576 %r19, 512
%r21 = zext i512 %r12 to i576
%r22 = or i576 %r20, %r21
%r23 = zext i576 %r22 to i640
%r24 = zext i576 %r15 to i640
%r25 = add i640 %r23, %r24
%r26 = lshr i640 %r25, 64
%r27 = trunc i640 %r26 to i576
%r28 = lshr i576 %r27, 512
%r29 = trunc i576 %r28 to i64
%r30 = trunc i576 %r27 to i512
%r31 = trunc i512 %r30 to i64
%r32 = mul i64 %r31, %r6
%r33 = call i576 @mulPv512x64(i64* %r3, i64 %r32)
%r34 = zext i64 %r29 to i576
%r35 = shl i576 %r34, 512
%r36 = add i576 %r33, %r35
%r38 = getelementptr i64, i64* %r2, i32 9
%r39 = load i64, i64* %r38
%r40 = zext i64 %r39 to i576
%r41 = shl i576 %r40, 512
%r42 = zext i512 %r30 to i576
%r43 = or i576 %r41, %r42
%r44 = zext i576 %r43 to i640
%r45 = zext i576 %r36 to i640
%r46 = add i640 %r44, %r45
%r47 = lshr i640 %r46, 64
%r48 = trunc i640 %r47 to i576
%r49 = lshr i576 %r48, 512
%r50 = trunc i576 %r49 to i64
%r51 = trunc i576 %r48 to i512
%r52 = trunc i512 %r51 to i64
%r53 = mul i64 %r52, %r6
%r54 = call i576 @mulPv512x64(i64* %r3, i64 %r53)
%r55 = zext i64 %r50 to i576
%r56 = shl i576 %r55, 512
%r57 = add i576 %r54, %r56
%r59 = getelementptr i64, i64* %r2, i32 10
%r60 = load i64, i64* %r59
%r61 = zext i64 %r60 to i576
%r62 = shl i576 %r61, 512
%r63 = zext i512 %r51 to i576
%r64 = or i576 %r62, %r63
%r65 = zext i576 %r64 to i640
%r66 = zext i576 %r57 to i640
%r67 = add i640 %r65, %r66
%r68 = lshr i640 %r67, 64
%r69 = trunc i640 %r68 to i576
%r70 = lshr i576 %r69, 512
%r71 = trunc i576 %r70 to i64
%r72 = trunc i576 %r69 to i512
%r73 = trunc i512 %r72 to i64
%r74 = mul i64 %r73, %r6
%r75 = call i576 @mulPv512x64(i64* %r3, i64 %r74)
%r76 = zext i64 %r71 to i576
%r77 = shl i576 %r76, 512
%r78 = add i576 %r75, %r77
%r80 = getelementptr i64, i64* %r2, i32 11
%r81 = load i64, i64* %r80
%r82 = zext i64 %r81 to i576
%r83 = shl i576 %r82, 512
%r84 = zext i512 %r72 to i576
%r85 = or i576 %r83, %r84
%r86 = zext i576 %r85 to i640
%r87 = zext i576 %r78 to i640
%r88 = add i640 %r86, %r87
%r89 = lshr i640 %r88, 64
%r90 = trunc i640 %r89 to i576
%r91 = lshr i576 %r90, 512
%r92 = trunc i576 %r91 to i64
%r93 = trunc i576 %r90 to i512
%r94 = trunc i512 %r93 to i64
%r95 = mul i64 %r94, %r6
%r96 = call i576 @mulPv512x64(i64* %r3, i64 %r95)
%r97 = zext i64 %r92 to i576
%r98 = shl i576 %r97, 512
%r99 = add i576 %r96, %r98
%r101 = getelementptr i64, i64* %r2, i32 12
%r102 = load i64, i64* %r101
%r103 = zext i64 %r102 to i576
%r104 = shl i576 %r103, 512
%r105 = zext i512 %r93 to i576
%r106 = or i576 %r104, %r105
%r107 = zext i576 %r106 to i640
%r108 = zext i576 %r99 to i640
%r109 = add i640 %r107, %r108
%r110 = lshr i640 %r109, 64
%r111 = trunc i640 %r110 to i576
%r112 = lshr i576 %r111, 512
%r113 = trunc i576 %r112 to i64
%r114 = trunc i576 %r111 to i512
%r115 = trunc i512 %r114 to i64
%r116 = mul i64 %r115, %r6
%r117 = call i576 @mulPv512x64(i64* %r3, i64 %r116)
%r118 = zext i64 %r113 to i576
%r119 = shl i576 %r118, 512
%r120 = add i576 %r117, %r119
%r122 = getelementptr i64, i64* %r2, i32 13
%r123 = load i64, i64* %r122
%r124 = zext i64 %r123 to i576
%r125 = shl i576 %r124, 512
%r126 = zext i512 %r114 to i576
%r127 = or i576 %r125, %r126
%r128 = zext i576 %r127 to i640
%r129 = zext i576 %r120 to i640
%r130 = add i640 %r128, %r129
%r131 = lshr i640 %r130, 64
%r132 = trunc i640 %r131 to i576
%r133 = lshr i576 %r132, 512
%r134 = trunc i576 %r133 to i64
%r135 = trunc i576 %r132 to i512
%r136 = trunc i512 %r135 to i64
%r137 = mul i64 %r136, %r6
%r138 = call i576 @mulPv512x64(i64* %r3, i64 %r137)
%r139 = zext i64 %r134 to i576
%r140 = shl i576 %r139, 512
%r141 = add i576 %r138, %r140
%r143 = getelementptr i64, i64* %r2, i32 14
%r144 = load i64, i64* %r143
%r145 = zext i64 %r144 to i576
%r146 = shl i576 %r145, 512
%r147 = zext i512 %r135 to i576
%r148 = or i576 %r146, %r147
%r149 = zext i576 %r148 to i640
%r150 = zext i576 %r141 to i640
%r151 = add i640 %r149, %r150
%r152 = lshr i640 %r151, 64
%r153 = trunc i640 %r152 to i576
%r154 = lshr i576 %r153, 512
%r155 = trunc i576 %r154 to i64
%r156 = trunc i576 %r153 to i512
%r157 = trunc i512 %r156 to i64
%r158 = mul i64 %r157, %r6
%r159 = call i576 @mulPv512x64(i64* %r3, i64 %r158)
%r160 = zext i64 %r155 to i576
%r161 = shl i576 %r160, 512
%r162 = add i576 %r159, %r161
%r164 = getelementptr i64, i64* %r2, i32 15
%r165 = load i64, i64* %r164
%r166 = zext i64 %r165 to i576
%r167 = shl i576 %r166, 512
%r168 = zext i512 %r156 to i576
%r169 = or i576 %r167, %r168
%r170 = zext i576 %r169 to i640
%r171 = zext i576 %r162 to i640
%r172 = add i640 %r170, %r171
%r173 = lshr i640 %r172, 64
%r174 = trunc i640 %r173 to i576
%r175 = lshr i576 %r174, 512
%r176 = trunc i576 %r175 to i64
%r177 = trunc i576 %r174 to i512
%r178 = zext i512 %r9 to i576
%r179 = zext i64 %r176 to i576
%r180 = shl i576 %r179, 512
%r181 = zext i512 %r177 to i576
%r182 = or i576 %r180, %r181
%r183 = sub i576 %r182, %r178
%r184 = lshr i576 %r183, 512
%r185 = trunc i576 %r184 to i1
%r186 = select i1 %r185, i576 %r182, i576 %r183
%r187 = trunc i576 %r186 to i512
%r189 = bitcast i64* %r1 to i512*
store i512 %r187, i512* %r189
ret void
}
define void @mcl_fp_montRedNF8L(i64* noalias  %r1, i64* noalias  %r2, i64* noalias  %r3)
{
%r5 = getelementptr i64, i64* %r3, i32 -1
%r6 = load i64, i64* %r5
%r8 = bitcast i64* %r3 to i512*
%r9 = load i512, i512* %r8
%r11 = bitcast i64* %r2 to i512*
%r12 = load i512, i512* %r11
%r13 = trunc i512 %r12 to i64
%r14 = mul i64 %r13, %r6
%r15 = call i576 @mulPv512x64(i64* %r3, i64 %r14)
%r17 = getelementptr i64, i64* %r2, i32 8
%r18 = load i64, i64* %r17
%r19 = zext i64 %r18 to i576
%r20 = shl i576 %r19, 512
%r21 = zext i512 %r12 to i576
%r22 = or i576 %r20, %r21
%r23 = zext i576 %r22 to i640
%r24 = zext i576 %r15 to i640
%r25 = add i640 %r23, %r24
%r26 = lshr i640 %r25, 64
%r27 = trunc i640 %r26 to i576
%r28 = lshr i576 %r27, 512
%r29 = trunc i576 %r28 to i64
%r30 = trunc i576 %r27 to i512
%r31 = trunc i512 %r30 to i64
%r32 = mul i64 %r31, %r6
%r33 = call i576 @mulPv512x64(i64* %r3, i64 %r32)
%r34 = zext i64 %r29 to i576
%r35 = shl i576 %r34, 512
%r36 = add i576 %r33, %r35
%r38 = getelementptr i64, i64* %r2, i32 9
%r39 = load i64, i64* %r38
%r40 = zext i64 %r39 to i576
%r41 = shl i576 %r40, 512
%r42 = zext i512 %r30 to i576
%r43 = or i576 %r41, %r42
%r44 = zext i576 %r43 to i640
%r45 = zext i576 %r36 to i640
%r46 = add i640 %r44, %r45
%r47 = lshr i640 %r46, 64
%r48 = trunc i640 %r47 to i576
%r49 = lshr i576 %r48, 512
%r50 = trunc i576 %r49 to i64
%r51 = trunc i576 %r48 to i512
%r52 = trunc i512 %r51 to i64
%r53 = mul i64 %r52, %r6
%r54 = call i576 @mulPv512x64(i64* %r3, i64 %r53)
%r55 = zext i64 %r50 to i576
%r56 = shl i576 %r55, 512
%r57 = add i576 %r54, %r56
%r59 = getelementptr i64, i64* %r2, i32 10
%r60 = load i64, i64* %r59
%r61 = zext i64 %r60 to i576
%r62 = shl i576 %r61, 512
%r63 = zext i512 %r51 to i576
%r64 = or i576 %r62, %r63
%r65 = zext i576 %r64 to i640
%r66 = zext i576 %r57 to i640
%r67 = add i640 %r65, %r66
%r68 = lshr i640 %r67, 64
%r69 = trunc i640 %r68 to i576
%r70 = lshr i576 %r69, 512
%r71 = trunc i576 %r70 to i64
%r72 = trunc i576 %r69 to i512
%r73 = trunc i512 %r72 to i64
%r74 = mul i64 %r73, %r6
%r75 = call i576 @mulPv512x64(i64* %r3, i64 %r74)
%r76 = zext i64 %r71 to i576
%r77 = shl i576 %r76, 512
%r78 = add i576 %r75, %r77
%r80 = getelementptr i64, i64* %r2, i32 11
%r81 = load i64, i64* %r80
%r82 = zext i64 %r81 to i576
%r83 = shl i576 %r82, 512
%r84 = zext i512 %r72 to i576
%r85 = or i576 %r83, %r84
%r86 = zext i576 %r85 to i640
%r87 = zext i576 %r78 to i640
%r88 = add i640 %r86, %r87
%r89 = lshr i640 %r88, 64
%r90 = trunc i640 %r89 to i576
%r91 = lshr i576 %r90, 512
%r92 = trunc i576 %r91 to i64
%r93 = trunc i576 %r90 to i512
%r94 = trunc i512 %r93 to i64
%r95 = mul i64 %r94, %r6
%r96 = call i576 @mulPv512x64(i64* %r3, i64 %r95)
%r97 = zext i64 %r92 to i576
%r98 = shl i576 %r97, 512
%r99 = add i576 %r96, %r98
%r101 = getelementptr i64, i64* %r2, i32 12
%r102 = load i64, i64* %r101
%r103 = zext i64 %r102 to i576
%r104 = shl i576 %r103, 512
%r105 = zext i512 %r93 to i576
%r106 = or i576 %r104, %r105
%r107 = zext i576 %r106 to i640
%r108 = zext i576 %r99 to i640
%r109 = add i640 %r107, %r108
%r110 = lshr i640 %r109, 64
%r111 = trunc i640 %r110 to i576
%r112 = lshr i576 %r111, 512
%r113 = trunc i576 %r112 to i64
%r114 = trunc i576 %r111 to i512
%r115 = trunc i512 %r114 to i64
%r116 = mul i64 %r115, %r6
%r117 = call i576 @mulPv512x64(i64* %r3, i64 %r116)
%r118 = zext i64 %r113 to i576
%r119 = shl i576 %r118, 512
%r120 = add i576 %r117, %r119
%r122 = getelementptr i64, i64* %r2, i32 13
%r123 = load i64, i64* %r122
%r124 = zext i64 %r123 to i576
%r125 = shl i576 %r124, 512
%r126 = zext i512 %r114 to i576
%r127 = or i576 %r125, %r126
%r128 = zext i576 %r127 to i640
%r129 = zext i576 %r120 to i640
%r130 = add i640 %r128, %r129
%r131 = lshr i640 %r130, 64
%r132 = trunc i640 %r131 to i576
%r133 = lshr i576 %r132, 512
%r134 = trunc i576 %r133 to i64
%r135 = trunc i576 %r132 to i512
%r136 = trunc i512 %r135 to i64
%r137 = mul i64 %r136, %r6
%r138 = call i576 @mulPv512x64(i64* %r3, i64 %r137)
%r139 = zext i64 %r134 to i576
%r140 = shl i576 %r139, 512
%r141 = add i576 %r138, %r140
%r143 = getelementptr i64, i64* %r2, i32 14
%r144 = load i64, i64* %r143
%r145 = zext i64 %r144 to i576
%r146 = shl i576 %r145, 512
%r147 = zext i512 %r135 to i576
%r148 = or i576 %r146, %r147
%r149 = zext i576 %r148 to i640
%r150 = zext i576 %r141 to i640
%r151 = add i640 %r149, %r150
%r152 = lshr i640 %r151, 64
%r153 = trunc i640 %r152 to i576
%r154 = lshr i576 %r153, 512
%r155 = trunc i576 %r154 to i64
%r156 = trunc i576 %r153 to i512
%r157 = trunc i512 %r156 to i64
%r158 = mul i64 %r157, %r6
%r159 = call i576 @mulPv512x64(i64* %r3, i64 %r158)
%r160 = zext i64 %r155 to i576
%r161 = shl i576 %r160, 512
%r162 = add i576 %r159, %r161
%r164 = getelementptr i64, i64* %r2, i32 15
%r165 = load i64, i64* %r164
%r166 = zext i64 %r165 to i576
%r167 = shl i576 %r166, 512
%r168 = zext i512 %r156 to i576
%r169 = or i576 %r167, %r168
%r170 = zext i576 %r169 to i640
%r171 = zext i576 %r162 to i640
%r172 = add i640 %r170, %r171
%r173 = lshr i640 %r172, 64
%r174 = trunc i640 %r173 to i576
%r175 = lshr i576 %r174, 512
%r176 = trunc i576 %r175 to i64
%r177 = trunc i576 %r174 to i512
%r178 = sub i512 %r177, %r9
%r179 = lshr i512 %r178, 511
%r180 = trunc i512 %r179 to i1
%r181 = select i1 %r180, i512 %r177, i512 %r178
%r183 = bitcast i64* %r1 to i512*
store i512 %r181, i512* %r183
ret void
}
define i64 @mcl_fp_addPre8L(i64* noalias  %r2, i64* noalias  %r3, i64* noalias  %r4)
{
%r6 = bitcast i64* %r3 to i512*
%r7 = load i512, i512* %r6
%r8 = zext i512 %r7 to i576
%r10 = bitcast i64* %r4 to i512*
%r11 = load i512, i512* %r10
%r12 = zext i512 %r11 to i576
%r13 = add i576 %r8, %r12
%r14 = trunc i576 %r13 to i512
%r16 = bitcast i64* %r2 to i512*
store i512 %r14, i512* %r16
%r17 = lshr i576 %r13, 512
%r18 = trunc i576 %r17 to i64
ret i64 %r18
}
define i64 @mcl_fp_subPre8L(i64* noalias  %r2, i64* noalias  %r3, i64* noalias  %r4)
{
%r6 = bitcast i64* %r3 to i512*
%r7 = load i512, i512* %r6
%r8 = zext i512 %r7 to i576
%r10 = bitcast i64* %r4 to i512*
%r11 = load i512, i512* %r10
%r12 = zext i512 %r11 to i576
%r13 = sub i576 %r8, %r12
%r14 = trunc i576 %r13 to i512
%r16 = bitcast i64* %r2 to i512*
store i512 %r14, i512* %r16
%r18 = lshr i576 %r13, 512
%r19 = trunc i576 %r18 to i64
%r20 = and i64 %r19, 1
ret i64 %r20
}
define void @mcl_fp_shr1_8L(i64* noalias  %r1, i64* noalias  %r2)
{
%r4 = bitcast i64* %r2 to i512*
%r5 = load i512, i512* %r4
%r6 = lshr i512 %r5, 1
%r8 = bitcast i64* %r1 to i512*
store i512 %r6, i512* %r8
ret void
}
define void @mcl_fp_add8L(i64* noalias  %r1, i64* noalias  %r2, i64* noalias  %r3, i64* noalias  %r4)
{
%r6 = bitcast i64* %r2 to i512*
%r7 = load i512, i512* %r6
%r9 = bitcast i64* %r3 to i512*
%r10 = load i512, i512* %r9
%r11 = zext i512 %r7 to i576
%r12 = zext i512 %r10 to i576
%r13 = add i576 %r11, %r12
%r15 = bitcast i64* %r4 to i512*
%r16 = load i512, i512* %r15
%r17 = zext i512 %r16 to i576
%r18 = sub i576 %r13, %r17
%r19 = lshr i576 %r18, 512
%r20 = trunc i576 %r19 to i1
%r21 = select i1 %r20, i576 %r13, i576 %r18
%r22 = trunc i576 %r21 to i512
%r24 = bitcast i64* %r1 to i512*
store i512 %r22, i512* %r24
ret void
}
define void @mcl_fp_addNF8L(i64* noalias  %r1, i64* noalias  %r2, i64* noalias  %r3, i64* noalias  %r4)
{
%r6 = bitcast i64* %r2 to i512*
%r7 = load i512, i512* %r6
%r9 = bitcast i64* %r3 to i512*
%r10 = load i512, i512* %r9
%r11 = add i512 %r7, %r10
%r13 = bitcast i64* %r4 to i512*
%r14 = load i512, i512* %r13
%r15 = sub i512 %r11, %r14
%r16 = lshr i512 %r15, 511
%r17 = trunc i512 %r16 to i1
%r18 = select i1 %r17, i512 %r11, i512 %r15
%r20 = bitcast i64* %r1 to i512*
store i512 %r18, i512* %r20
ret void
}
define void @mcl_fp_sub8L(i64* noalias  %r1, i64* noalias  %r2, i64* noalias  %r3, i64* noalias  %r4)
{
%r6 = bitcast i64* %r2 to i512*
%r7 = load i512, i512* %r6
%r9 = bitcast i64* %r3 to i512*
%r10 = load i512, i512* %r9
%r11 = zext i512 %r7 to i513
%r12 = zext i512 %r10 to i513
%r13 = sub i513 %r11, %r12
%r14 = lshr i513 %r13, 512
%r15 = trunc i513 %r14 to i1
%r16 = trunc i513 %r13 to i512
%r18 = bitcast i64* %r4 to i512*
%r19 = load i512, i512* %r18
%r21 = select i1 %r15, i512 %r19, i512 0
%r22 = add i512 %r16, %r21
%r24 = bitcast i64* %r1 to i512*
store i512 %r22, i512* %r24
ret void
}
define void @mcl_fp_subNF8L(i64* noalias  %r1, i64* noalias  %r2, i64* noalias  %r3, i64* noalias  %r4)
{
%r6 = bitcast i64* %r2 to i512*
%r7 = load i512, i512* %r6
%r9 = bitcast i64* %r3 to i512*
%r10 = load i512, i512* %r9
%r11 = sub i512 %r7, %r10
%r12 = lshr i512 %r11, 511
%r13 = trunc i512 %r12 to i1
%r15 = bitcast i64* %r4 to i512*
%r16 = load i512, i512* %r15
%r18 = select i1 %r13, i512 %r16, i512 0
%r19 = add i512 %r11, %r18
%r21 = bitcast i64* %r1 to i512*
store i512 %r19, i512* %r21
ret void
}
define void @mcl_fpDbl_add8L(i64* noalias  %r1, i64* noalias  %r2, i64* noalias  %r3, i64* noalias  %r4)
{
%r6 = bitcast i64* %r2 to i1024*
%r7 = load i1024, i1024* %r6
%r9 = bitcast i64* %r3 to i1024*
%r10 = load i1024, i1024* %r9
%r11 = zext i1024 %r7 to i1088
%r12 = zext i1024 %r10 to i1088
%r13 = add i1088 %r11, %r12
%r14 = trunc i1088 %r13 to i512
%r16 = bitcast i64* %r1 to i512*
store i512 %r14, i512* %r16
%r17 = lshr i1088 %r13, 512
%r18 = trunc i1088 %r17 to i576
%r20 = bitcast i64* %r4 to i512*
%r21 = load i512, i512* %r20
%r22 = zext i512 %r21 to i576
%r23 = sub i576 %r18, %r22
%r24 = lshr i576 %r23, 512
%r25 = trunc i576 %r24 to i1
%r26 = select i1 %r25, i576 %r18, i576 %r23
%r27 = trunc i576 %r26 to i512
%r29 = getelementptr i64, i64* %r1, i32 8
%r31 = bitcast i64* %r29 to i512*
store i512 %r27, i512* %r31
ret void
}
define void @mcl_fpDbl_sub8L(i64* noalias  %r1, i64* noalias  %r2, i64* noalias  %r3, i64* noalias  %r4)
{
%r6 = bitcast i64* %r2 to i1024*
%r7 = load i1024, i1024* %r6
%r9 = bitcast i64* %r3 to i1024*
%r10 = load i1024, i1024* %r9
%r11 = zext i1024 %r7 to i1088
%r12 = zext i1024 %r10 to i1088
%r13 = sub i1088 %r11, %r12
%r14 = trunc i1088 %r13 to i512
%r16 = bitcast i64* %r1 to i512*
store i512 %r14, i512* %r16
%r17 = lshr i1088 %r13, 512
%r18 = trunc i1088 %r17 to i512
%r19 = lshr i1088 %r13, 1024
%r20 = trunc i1088 %r19 to i1
%r22 = bitcast i64* %r4 to i512*
%r23 = load i512, i512* %r22
%r25 = select i1 %r20, i512 %r23, i512 0
%r26 = add i512 %r18, %r25
%r28 = getelementptr i64, i64* %r1, i32 8
%r30 = bitcast i64* %r28 to i512*
store i512 %r26, i512* %r30
ret void
}
