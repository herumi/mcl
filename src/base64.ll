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
define private i128 @mulPos64x64(i64* noalias %r2, i64 %r3, i64 %r4)
{
%r5 = getelementptr i64, i64* %r2, i64 %r4
%r6 = load i64, i64* %r5
%r7 = call i128 @mul64x64L(i64 %r6, i64 %r3)
ret i128 %r7
}
declare void @mclb_mul3(i64*, i64*, i64*)
declare void @mclb_sqr3(i64*, i64*)
define i192 @makeNIST_P192L()
{
%r5 = sub i64 0, 1
%r6 = sub i64 0, 2
%r7 = sub i64 0, 1
%r8 = zext i64 %r5 to i192
%r9 = zext i64 %r6 to i192
%r10 = zext i64 %r7 to i192
%r11 = shl i192 %r9, 64
%r12 = shl i192 %r10, 128
%r13 = add i192 %r8, %r11
%r14 = add i192 %r13, %r12
ret i192 %r14
}
define void @mcl_fpDbl_mod_NIST_P192L(i64* noalias %r1, i64* noalias %r2, i64* noalias %r3)
{
%r4 = bitcast i64* %r2 to i192*
%r5 = load i192, i192* %r4
%r6 = zext i192 %r5 to i256
%r7 = getelementptr i64, i64* %r2, i32 3
%r8 = bitcast i64* %r7 to i192*
%r9 = load i192, i192* %r8
%r10 = zext i192 %r9 to i256
%r11 = shl i192 %r9, 64
%r12 = zext i192 %r11 to i256
%r13 = lshr i192 %r9, 128
%r14 = trunc i192 %r13 to i64
%r15 = zext i64 %r14 to i256
%r16 = or i256 %r12, %r15
%r17 = shl i256 %r15, 64
%r18 = add i256 %r6, %r10
%r19 = add i256 %r18, %r16
%r20 = add i256 %r19, %r17
%r21 = lshr i256 %r20, 192
%r22 = trunc i256 %r21 to i64
%r23 = zext i64 %r22 to i256
%r24 = shl i256 %r23, 64
%r25 = or i256 %r23, %r24
%r26 = trunc i256 %r20 to i192
%r27 = zext i192 %r26 to i256
%r28 = add i256 %r27, %r25
%r29 = call i192 @makeNIST_P192L()
%r30 = zext i192 %r29 to i256
%r31 = sub i256 %r28, %r30
%r32 = lshr i256 %r31, 192
%r33 = trunc i256 %r32 to i1
%r34 = select i1 %r33, i256 %r28, i256 %r31
%r35 = trunc i256 %r34 to i192
%r36 = bitcast i64* %r1 to i192*
store i192 %r35, i192* %r36
ret void
}
define void @mcl_fp_sqr_NIST_P192L(i64* noalias %r1, i64* noalias %r2, i64* noalias %r3)
{
%r4 = alloca i64, i32 6
call void @mclb_sqr3(i64* %r4, i64* %r2)
call void @mcl_fpDbl_mod_NIST_P192L(i64* %r1, i64* %r4, i64* %r4)
ret void
}
define void @mcl_fp_mulNIST_P192L(i64* noalias %r1, i64* noalias %r2, i64* noalias %r3, i64* noalias %r4)
{
%r5 = alloca i64, i32 6
call void @mclb_mul3(i64* %r5, i64* %r2, i64* %r3)
call void @mcl_fpDbl_mod_NIST_P192L(i64* %r1, i64* %r5, i64* %r5)
ret void
}
define void @mcl_fpDbl_mod_NIST_P521L(i64* noalias %r1, i64* noalias %r2, i64* noalias %r3)
{
%r4 = bitcast i64* %r2 to i1088*
%r5 = load i1088, i1088* %r4
%r6 = trunc i1088 %r5 to i521
%r7 = zext i521 %r6 to i576
%r8 = lshr i1088 %r5, 521
%r9 = trunc i1088 %r8 to i576
%r10 = add i576 %r7, %r9
%r11 = lshr i576 %r10, 521
%r12 = and i576 %r11, 1
%r13 = add i576 %r10, %r12
%r14 = trunc i576 %r13 to i521
%r15 = zext i521 %r14 to i576
%r16 = lshr i576 %r15, 512
%r17 = trunc i576 %r16 to i64
%r18 = or i64 %r17, -512
%r19 = lshr i576 %r15, 0
%r20 = trunc i576 %r19 to i64
%r21 = and i64 %r18, %r20
%r22 = lshr i576 %r15, 64
%r23 = trunc i576 %r22 to i64
%r24 = and i64 %r21, %r23
%r25 = lshr i576 %r15, 128
%r26 = trunc i576 %r25 to i64
%r27 = and i64 %r24, %r26
%r28 = lshr i576 %r15, 192
%r29 = trunc i576 %r28 to i64
%r30 = and i64 %r27, %r29
%r31 = lshr i576 %r15, 256
%r32 = trunc i576 %r31 to i64
%r33 = and i64 %r30, %r32
%r34 = lshr i576 %r15, 320
%r35 = trunc i576 %r34 to i64
%r36 = and i64 %r33, %r35
%r37 = lshr i576 %r15, 384
%r38 = trunc i576 %r37 to i64
%r39 = and i64 %r36, %r38
%r40 = lshr i576 %r15, 448
%r41 = trunc i576 %r40 to i64
%r42 = and i64 %r39, %r41
%r43 = icmp eq i64 %r42, -1
br i1 %r43, label %L1, label %L2
L1:
store i64 0, i64* %r1
%r44 = getelementptr i64, i64* %r1, i32 1
store i64 0, i64* %r44
%r45 = getelementptr i64, i64* %r1, i32 2
store i64 0, i64* %r45
%r46 = getelementptr i64, i64* %r1, i32 3
store i64 0, i64* %r46
%r47 = getelementptr i64, i64* %r1, i32 4
store i64 0, i64* %r47
%r48 = getelementptr i64, i64* %r1, i32 5
store i64 0, i64* %r48
%r49 = getelementptr i64, i64* %r1, i32 6
store i64 0, i64* %r49
%r50 = getelementptr i64, i64* %r1, i32 7
store i64 0, i64* %r50
%r51 = getelementptr i64, i64* %r1, i32 8
store i64 0, i64* %r51
ret void
L2:
%r52 = bitcast i64* %r1 to i576*
store i576 %r15, i576* %r52
ret void
}
define i256 @mulPv192x64(i64* noalias %r2, i64 %r3)
{
%r4 = call i128 @mulPos64x64(i64* %r2, i64 %r3, i64 0)
%r5 = trunc i128 %r4 to i64
%r6 = call i64 @extractHigh64(i128 %r4)
%r7 = call i128 @mulPos64x64(i64* %r2, i64 %r3, i64 1)
%r8 = trunc i128 %r7 to i64
%r9 = call i64 @extractHigh64(i128 %r7)
%r10 = call i128 @mulPos64x64(i64* %r2, i64 %r3, i64 2)
%r11 = trunc i128 %r10 to i64
%r12 = call i64 @extractHigh64(i128 %r10)
%r13 = zext i64 %r5 to i128
%r14 = zext i64 %r8 to i128
%r15 = shl i128 %r14, 64
%r16 = or i128 %r13, %r15
%r17 = zext i128 %r16 to i192
%r18 = zext i64 %r11 to i192
%r19 = shl i192 %r18, 128
%r20 = or i192 %r17, %r19
%r21 = zext i64 %r6 to i128
%r22 = zext i64 %r9 to i128
%r23 = shl i128 %r22, 64
%r24 = or i128 %r21, %r23
%r25 = zext i128 %r24 to i192
%r26 = zext i64 %r12 to i192
%r27 = shl i192 %r26, 128
%r28 = or i192 %r25, %r27
%r29 = zext i192 %r20 to i256
%r30 = zext i192 %r28 to i256
%r31 = shl i256 %r30, 64
%r32 = add i256 %r29, %r31
ret i256 %r32
}
define void @mcl_fp_mont3L(i64* %r1, i64* %r2, i64* %r3, i64* %r4)
{
%r5 = getelementptr i64, i64* %r4, i32 -1
%r6 = load i64, i64* %r5
%r7 = getelementptr i64, i64* %r3, i32 0
%r8 = load i64, i64* %r7
%r9 = call i256 @mulPv192x64(i64* %r2, i64 %r8)
%r10 = zext i256 %r9 to i320
%r11 = trunc i256 %r9 to i64
%r12 = mul i64 %r11, %r6
%r13 = call i256 @mulPv192x64(i64* %r4, i64 %r12)
%r14 = zext i256 %r13 to i320
%r15 = add i320 %r10, %r14
%r16 = lshr i320 %r15, 64
%r17 = getelementptr i64, i64* %r3, i32 1
%r18 = load i64, i64* %r17
%r19 = call i256 @mulPv192x64(i64* %r2, i64 %r18)
%r20 = zext i256 %r19 to i320
%r21 = add i320 %r16, %r20
%r22 = trunc i320 %r21 to i64
%r23 = mul i64 %r22, %r6
%r24 = call i256 @mulPv192x64(i64* %r4, i64 %r23)
%r25 = zext i256 %r24 to i320
%r26 = add i320 %r21, %r25
%r27 = lshr i320 %r26, 64
%r28 = getelementptr i64, i64* %r3, i32 2
%r29 = load i64, i64* %r28
%r30 = call i256 @mulPv192x64(i64* %r2, i64 %r29)
%r31 = zext i256 %r30 to i320
%r32 = add i320 %r27, %r31
%r33 = trunc i320 %r32 to i64
%r34 = mul i64 %r33, %r6
%r35 = call i256 @mulPv192x64(i64* %r4, i64 %r34)
%r36 = zext i256 %r35 to i320
%r37 = add i320 %r32, %r36
%r38 = lshr i320 %r37, 64
%r39 = trunc i320 %r38 to i256
%r40 = bitcast i64* %r4 to i192*
%r41 = load i192, i192* %r40
%r42 = zext i192 %r41 to i256
%r43 = sub i256 %r39, %r42
%r44 = lshr i256 %r43, 192
%r45 = trunc i256 %r44 to i1
%r46 = select i1 %r45, i256 %r39, i256 %r43
%r47 = trunc i256 %r46 to i192
%r48 = bitcast i64* %r1 to i192*
store i192 %r47, i192* %r48
ret void
}
define void @mcl_fp_montNF3L(i64* %r1, i64* %r2, i64* %r3, i64* %r4)
{
%r5 = getelementptr i64, i64* %r4, i32 -1
%r6 = load i64, i64* %r5
%r7 = load i64, i64* %r3
%r8 = call i256 @mulPv192x64(i64* %r2, i64 %r7)
%r9 = trunc i256 %r8 to i64
%r10 = mul i64 %r9, %r6
%r11 = call i256 @mulPv192x64(i64* %r4, i64 %r10)
%r12 = add i256 %r8, %r11
%r13 = lshr i256 %r12, 64
%r14 = getelementptr i64, i64* %r3, i32 1
%r15 = load i64, i64* %r14
%r16 = call i256 @mulPv192x64(i64* %r2, i64 %r15)
%r17 = add i256 %r13, %r16
%r18 = trunc i256 %r17 to i64
%r19 = mul i64 %r18, %r6
%r20 = call i256 @mulPv192x64(i64* %r4, i64 %r19)
%r21 = add i256 %r17, %r20
%r22 = lshr i256 %r21, 64
%r23 = getelementptr i64, i64* %r3, i32 2
%r24 = load i64, i64* %r23
%r25 = call i256 @mulPv192x64(i64* %r2, i64 %r24)
%r26 = add i256 %r22, %r25
%r27 = trunc i256 %r26 to i64
%r28 = mul i64 %r27, %r6
%r29 = call i256 @mulPv192x64(i64* %r4, i64 %r28)
%r30 = add i256 %r26, %r29
%r31 = lshr i256 %r30, 64
%r32 = trunc i256 %r31 to i192
%r33 = bitcast i64* %r4 to i192*
%r34 = load i192, i192* %r33
%r35 = sub i192 %r32, %r34
%r36 = lshr i192 %r35, 191
%r37 = trunc i192 %r36 to i1
%r38 = select i1 %r37, i192 %r32, i192 %r35
%r39 = bitcast i64* %r1 to i192*
store i192 %r38, i192* %r39
ret void
}
define void @mcl_fp_montRed3L(i64* noalias %r1, i64* noalias %r2, i64* noalias %r3)
{
%r4 = getelementptr i64, i64* %r3, i32 -1
%r5 = load i64, i64* %r4
%r6 = bitcast i64* %r3 to i192*
%r7 = load i192, i192* %r6
%r8 = bitcast i64* %r2 to i192*
%r9 = load i192, i192* %r8
%r10 = trunc i192 %r9 to i64
%r11 = mul i64 %r10, %r5
%r12 = call i256 @mulPv192x64(i64* %r3, i64 %r11)
%r13 = getelementptr i64, i64* %r2, i32 3
%r14 = load i64, i64* %r13
%r15 = zext i192 %r9 to i256
%r16 = zext i64 %r14 to i256
%r17 = shl i256 %r16, 192
%r18 = or i256 %r15, %r17
%r19 = zext i256 %r18 to i320
%r20 = zext i256 %r12 to i320
%r21 = add i320 %r19, %r20
%r22 = lshr i320 %r21, 64
%r23 = trunc i320 %r22 to i256
%r24 = lshr i256 %r23, 192
%r25 = trunc i256 %r24 to i64
%r26 = trunc i256 %r23 to i192
%r27 = trunc i192 %r26 to i64
%r28 = mul i64 %r27, %r5
%r29 = call i256 @mulPv192x64(i64* %r3, i64 %r28)
%r30 = zext i64 %r25 to i256
%r31 = shl i256 %r30, 192
%r32 = add i256 %r29, %r31
%r33 = getelementptr i64, i64* %r2, i32 4
%r34 = load i64, i64* %r33
%r35 = zext i192 %r26 to i256
%r36 = zext i64 %r34 to i256
%r37 = shl i256 %r36, 192
%r38 = or i256 %r35, %r37
%r39 = zext i256 %r38 to i320
%r40 = zext i256 %r32 to i320
%r41 = add i320 %r39, %r40
%r42 = lshr i320 %r41, 64
%r43 = trunc i320 %r42 to i256
%r44 = lshr i256 %r43, 192
%r45 = trunc i256 %r44 to i64
%r46 = trunc i256 %r43 to i192
%r47 = trunc i192 %r46 to i64
%r48 = mul i64 %r47, %r5
%r49 = call i256 @mulPv192x64(i64* %r3, i64 %r48)
%r50 = zext i64 %r45 to i256
%r51 = shl i256 %r50, 192
%r52 = add i256 %r49, %r51
%r53 = getelementptr i64, i64* %r2, i32 5
%r54 = load i64, i64* %r53
%r55 = zext i192 %r46 to i256
%r56 = zext i64 %r54 to i256
%r57 = shl i256 %r56, 192
%r58 = or i256 %r55, %r57
%r59 = zext i256 %r58 to i320
%r60 = zext i256 %r52 to i320
%r61 = add i320 %r59, %r60
%r62 = lshr i320 %r61, 64
%r63 = trunc i320 %r62 to i256
%r64 = lshr i256 %r63, 192
%r65 = trunc i256 %r64 to i64
%r66 = trunc i256 %r63 to i192
%r67 = zext i192 %r7 to i256
%r68 = zext i192 %r66 to i256
%r69 = zext i64 %r65 to i256
%r70 = shl i256 %r69, 192
%r71 = or i256 %r68, %r70
%r72 = sub i256 %r71, %r67
%r73 = lshr i256 %r72, 192
%r74 = trunc i256 %r73 to i1
%r75 = select i1 %r74, i256 %r71, i256 %r72
%r76 = trunc i256 %r75 to i192
%r77 = bitcast i64* %r1 to i192*
store i192 %r76, i192* %r77
ret void
}
define void @mcl_fp_montRedNF3L(i64* noalias %r1, i64* noalias %r2, i64* noalias %r3)
{
%r4 = getelementptr i64, i64* %r3, i32 -1
%r5 = load i64, i64* %r4
%r6 = bitcast i64* %r3 to i192*
%r7 = load i192, i192* %r6
%r8 = bitcast i64* %r2 to i192*
%r9 = load i192, i192* %r8
%r10 = trunc i192 %r9 to i64
%r11 = mul i64 %r10, %r5
%r12 = call i256 @mulPv192x64(i64* %r3, i64 %r11)
%r13 = getelementptr i64, i64* %r2, i32 3
%r14 = load i64, i64* %r13
%r15 = zext i192 %r9 to i256
%r16 = zext i64 %r14 to i256
%r17 = shl i256 %r16, 192
%r18 = or i256 %r15, %r17
%r19 = zext i256 %r18 to i320
%r20 = zext i256 %r12 to i320
%r21 = add i320 %r19, %r20
%r22 = lshr i320 %r21, 64
%r23 = trunc i320 %r22 to i256
%r24 = lshr i256 %r23, 192
%r25 = trunc i256 %r24 to i64
%r26 = trunc i256 %r23 to i192
%r27 = trunc i192 %r26 to i64
%r28 = mul i64 %r27, %r5
%r29 = call i256 @mulPv192x64(i64* %r3, i64 %r28)
%r30 = zext i64 %r25 to i256
%r31 = shl i256 %r30, 192
%r32 = add i256 %r29, %r31
%r33 = getelementptr i64, i64* %r2, i32 4
%r34 = load i64, i64* %r33
%r35 = zext i192 %r26 to i256
%r36 = zext i64 %r34 to i256
%r37 = shl i256 %r36, 192
%r38 = or i256 %r35, %r37
%r39 = zext i256 %r38 to i320
%r40 = zext i256 %r32 to i320
%r41 = add i320 %r39, %r40
%r42 = lshr i320 %r41, 64
%r43 = trunc i320 %r42 to i256
%r44 = lshr i256 %r43, 192
%r45 = trunc i256 %r44 to i64
%r46 = trunc i256 %r43 to i192
%r47 = trunc i192 %r46 to i64
%r48 = mul i64 %r47, %r5
%r49 = call i256 @mulPv192x64(i64* %r3, i64 %r48)
%r50 = zext i64 %r45 to i256
%r51 = shl i256 %r50, 192
%r52 = add i256 %r49, %r51
%r53 = getelementptr i64, i64* %r2, i32 5
%r54 = load i64, i64* %r53
%r55 = zext i192 %r46 to i256
%r56 = zext i64 %r54 to i256
%r57 = shl i256 %r56, 192
%r58 = or i256 %r55, %r57
%r59 = zext i256 %r58 to i320
%r60 = zext i256 %r52 to i320
%r61 = add i320 %r59, %r60
%r62 = lshr i320 %r61, 64
%r63 = trunc i320 %r62 to i256
%r64 = lshr i256 %r63, 192
%r65 = trunc i256 %r64 to i64
%r66 = trunc i256 %r63 to i192
%r67 = sub i192 %r66, %r7
%r68 = lshr i192 %r67, 191
%r69 = trunc i192 %r68 to i1
%r70 = select i1 %r69, i192 %r66, i192 %r67
%r71 = bitcast i64* %r1 to i192*
store i192 %r70, i192* %r71
ret void
}
define i64 @mcl_fp_addPre3L(i64* noalias %r1, i64* noalias %r2, i64* noalias %r3)
{
%r5 = bitcast i64* %r2 to i192*
%r6 = load i192, i192* %r5
%r7 = zext i192 %r6 to i256
%r8 = bitcast i64* %r3 to i192*
%r9 = load i192, i192* %r8
%r10 = zext i192 %r9 to i256
%r11 = add i256 %r7, %r10
%r12 = trunc i256 %r11 to i192
%r13 = bitcast i64* %r1 to i192*
store i192 %r12, i192* %r13
%r14 = lshr i256 %r11, 192
%r15 = trunc i256 %r14 to i64
ret i64 %r15
}
define i64 @mcl_fp_subPre3L(i64* noalias %r1, i64* noalias %r2, i64* noalias %r3)
{
%r5 = bitcast i64* %r2 to i192*
%r6 = load i192, i192* %r5
%r7 = zext i192 %r6 to i256
%r8 = bitcast i64* %r3 to i192*
%r9 = load i192, i192* %r8
%r10 = zext i192 %r9 to i256
%r11 = sub i256 %r7, %r10
%r12 = trunc i256 %r11 to i192
%r13 = bitcast i64* %r1 to i192*
store i192 %r12, i192* %r13
%r14 = lshr i256 %r11, 192
%r15 = trunc i256 %r14 to i64
%r16 = and i64 %r15, 1
ret i64 %r16
}
define void @mcl_fp_shr1_3L(i64* noalias %r1, i64* noalias %r2)
{
%r3 = bitcast i64* %r2 to i192*
%r4 = load i192, i192* %r3
%r5 = lshr i192 %r4, 1
%r6 = bitcast i64* %r1 to i192*
store i192 %r5, i192* %r6
ret void
}
define void @mcl_fp_add3L(i64* noalias %r1, i64* noalias %r2, i64* noalias %r3, i64* noalias %r4)
{
%r5 = bitcast i64* %r2 to i192*
%r6 = load i192, i192* %r5
%r7 = bitcast i64* %r3 to i192*
%r8 = load i192, i192* %r7
%r9 = bitcast i64* %r4 to i192*
%r10 = load i192, i192* %r9
%r11 = zext i192 %r6 to i256
%r12 = zext i192 %r8 to i256
%r13 = add i256 %r11, %r12
%r14 = zext i192 %r10 to i256
%r15 = sub i256 %r13, %r14
%r16 = lshr i256 %r15, 192
%r17 = trunc i256 %r16 to i1
%r18 = select i1 %r17, i256 %r13, i256 %r15
%r19 = trunc i256 %r18 to i192
%r20 = bitcast i64* %r1 to i192*
store i192 %r19, i192* %r20
ret void
}
define void @mcl_fp_addNF3L(i64* noalias %r1, i64* noalias %r2, i64* noalias %r3, i64* noalias %r4)
{
%r5 = bitcast i64* %r2 to i192*
%r6 = load i192, i192* %r5
%r7 = bitcast i64* %r3 to i192*
%r8 = load i192, i192* %r7
%r9 = bitcast i64* %r4 to i192*
%r10 = load i192, i192* %r9
%r11 = add i192 %r6, %r8
%r12 = sub i192 %r11, %r10
%r13 = lshr i192 %r12, 191
%r14 = trunc i192 %r13 to i1
%r15 = select i1 %r14, i192 %r11, i192 %r12
%r16 = bitcast i64* %r1 to i192*
store i192 %r15, i192* %r16
ret void
}
define void @mcl_fp_sub3L(i64* noalias %r1, i64* noalias %r2, i64* noalias %r3, i64* noalias %r4)
{
%r5 = bitcast i64* %r2 to i192*
%r6 = load i192, i192* %r5
%r7 = bitcast i64* %r3 to i192*
%r8 = load i192, i192* %r7
%r9 = zext i192 %r6 to i256
%r10 = zext i192 %r8 to i256
%r11 = sub i256 %r9, %r10
%r12 = lshr i256 %r11, 192
%r13 = trunc i256 %r12 to i1
%r14 = trunc i256 %r11 to i192
%r15 = bitcast i64* %r4 to i192*
%r16 = load i192, i192* %r15
%r17 = select i1 %r13, i192 %r16, i192 0
%r18 = add i192 %r14, %r17
%r19 = bitcast i64* %r1 to i192*
store i192 %r18, i192* %r19
ret void
}
define void @mcl_fp_subNF3L(i64* noalias %r1, i64* noalias %r2, i64* noalias %r3, i64* noalias %r4)
{
%r5 = bitcast i64* %r2 to i192*
%r6 = load i192, i192* %r5
%r7 = bitcast i64* %r3 to i192*
%r8 = load i192, i192* %r7
%r9 = sub i192 %r6, %r8
%r10 = lshr i192 %r9, 191
%r11 = trunc i192 %r10 to i1
%r12 = bitcast i64* %r4 to i192*
%r13 = load i192, i192* %r12
%r14 = select i1 %r11, i192 %r13, i192 0
%r15 = add i192 %r9, %r14
%r16 = bitcast i64* %r1 to i192*
store i192 %r15, i192* %r16
ret void
}
define void @mcl_fpDbl_add3L(i64* noalias %r1, i64* noalias %r2, i64* noalias %r3, i64* noalias %r4)
{
%r5 = bitcast i64* %r2 to i384*
%r6 = load i384, i384* %r5
%r7 = bitcast i64* %r3 to i384*
%r8 = load i384, i384* %r7
%r9 = zext i384 %r6 to i448
%r10 = zext i384 %r8 to i448
%r11 = add i448 %r9, %r10
%r12 = trunc i448 %r11 to i192
%r13 = bitcast i64* %r1 to i192*
store i192 %r12, i192* %r13
%r14 = lshr i448 %r11, 192
%r15 = trunc i448 %r14 to i256
%r16 = bitcast i64* %r4 to i192*
%r17 = load i192, i192* %r16
%r18 = zext i192 %r17 to i256
%r19 = sub i256 %r15, %r18
%r20 = lshr i256 %r19, 192
%r21 = trunc i256 %r20 to i1
%r22 = select i1 %r21, i256 %r15, i256 %r19
%r23 = trunc i256 %r22 to i192
%r24 = getelementptr i64, i64* %r1, i32 3
%r25 = bitcast i64* %r24 to i192*
store i192 %r23, i192* %r25
ret void
}
define void @mcl_fpDbl_sub3L(i64* noalias %r1, i64* noalias %r2, i64* noalias %r3, i64* noalias %r4)
{
%r5 = bitcast i64* %r2 to i384*
%r6 = load i384, i384* %r5
%r7 = bitcast i64* %r3 to i384*
%r8 = load i384, i384* %r7
%r9 = zext i384 %r6 to i448
%r10 = zext i384 %r8 to i448
%r11 = sub i448 %r9, %r10
%r12 = trunc i448 %r11 to i192
%r13 = bitcast i64* %r1 to i192*
store i192 %r12, i192* %r13
%r14 = lshr i448 %r11, 192
%r15 = trunc i448 %r14 to i192
%r16 = lshr i448 %r11, 384
%r17 = trunc i448 %r16 to i1
%r18 = bitcast i64* %r4 to i192*
%r19 = load i192, i192* %r18
%r20 = select i1 %r17, i192 %r19, i192 0
%r21 = add i192 %r15, %r20
%r22 = getelementptr i64, i64* %r1, i32 3
%r23 = bitcast i64* %r22 to i192*
store i192 %r21, i192* %r23
ret void
}
define i320 @mulPv256x64(i64* noalias %r2, i64 %r3)
{
%r4 = call i128 @mulPos64x64(i64* %r2, i64 %r3, i64 0)
%r5 = trunc i128 %r4 to i64
%r6 = call i64 @extractHigh64(i128 %r4)
%r7 = call i128 @mulPos64x64(i64* %r2, i64 %r3, i64 1)
%r8 = trunc i128 %r7 to i64
%r9 = call i64 @extractHigh64(i128 %r7)
%r10 = call i128 @mulPos64x64(i64* %r2, i64 %r3, i64 2)
%r11 = trunc i128 %r10 to i64
%r12 = call i64 @extractHigh64(i128 %r10)
%r13 = call i128 @mulPos64x64(i64* %r2, i64 %r3, i64 3)
%r14 = trunc i128 %r13 to i64
%r15 = call i64 @extractHigh64(i128 %r13)
%r16 = zext i64 %r5 to i128
%r17 = zext i64 %r8 to i128
%r18 = shl i128 %r17, 64
%r19 = or i128 %r16, %r18
%r20 = zext i128 %r19 to i192
%r21 = zext i64 %r11 to i192
%r22 = shl i192 %r21, 128
%r23 = or i192 %r20, %r22
%r24 = zext i192 %r23 to i256
%r25 = zext i64 %r14 to i256
%r26 = shl i256 %r25, 192
%r27 = or i256 %r24, %r26
%r28 = zext i64 %r6 to i128
%r29 = zext i64 %r9 to i128
%r30 = shl i128 %r29, 64
%r31 = or i128 %r28, %r30
%r32 = zext i128 %r31 to i192
%r33 = zext i64 %r12 to i192
%r34 = shl i192 %r33, 128
%r35 = or i192 %r32, %r34
%r36 = zext i192 %r35 to i256
%r37 = zext i64 %r15 to i256
%r38 = shl i256 %r37, 192
%r39 = or i256 %r36, %r38
%r40 = zext i256 %r27 to i320
%r41 = zext i256 %r39 to i320
%r42 = shl i320 %r41, 64
%r43 = add i320 %r40, %r42
ret i320 %r43
}
define void @mcl_fp_mont4L(i64* %r1, i64* %r2, i64* %r3, i64* %r4)
{
%r5 = getelementptr i64, i64* %r4, i32 -1
%r6 = load i64, i64* %r5
%r7 = getelementptr i64, i64* %r3, i32 0
%r8 = load i64, i64* %r7
%r9 = call i320 @mulPv256x64(i64* %r2, i64 %r8)
%r10 = zext i320 %r9 to i384
%r11 = trunc i320 %r9 to i64
%r12 = mul i64 %r11, %r6
%r13 = call i320 @mulPv256x64(i64* %r4, i64 %r12)
%r14 = zext i320 %r13 to i384
%r15 = add i384 %r10, %r14
%r16 = lshr i384 %r15, 64
%r17 = getelementptr i64, i64* %r3, i32 1
%r18 = load i64, i64* %r17
%r19 = call i320 @mulPv256x64(i64* %r2, i64 %r18)
%r20 = zext i320 %r19 to i384
%r21 = add i384 %r16, %r20
%r22 = trunc i384 %r21 to i64
%r23 = mul i64 %r22, %r6
%r24 = call i320 @mulPv256x64(i64* %r4, i64 %r23)
%r25 = zext i320 %r24 to i384
%r26 = add i384 %r21, %r25
%r27 = lshr i384 %r26, 64
%r28 = getelementptr i64, i64* %r3, i32 2
%r29 = load i64, i64* %r28
%r30 = call i320 @mulPv256x64(i64* %r2, i64 %r29)
%r31 = zext i320 %r30 to i384
%r32 = add i384 %r27, %r31
%r33 = trunc i384 %r32 to i64
%r34 = mul i64 %r33, %r6
%r35 = call i320 @mulPv256x64(i64* %r4, i64 %r34)
%r36 = zext i320 %r35 to i384
%r37 = add i384 %r32, %r36
%r38 = lshr i384 %r37, 64
%r39 = getelementptr i64, i64* %r3, i32 3
%r40 = load i64, i64* %r39
%r41 = call i320 @mulPv256x64(i64* %r2, i64 %r40)
%r42 = zext i320 %r41 to i384
%r43 = add i384 %r38, %r42
%r44 = trunc i384 %r43 to i64
%r45 = mul i64 %r44, %r6
%r46 = call i320 @mulPv256x64(i64* %r4, i64 %r45)
%r47 = zext i320 %r46 to i384
%r48 = add i384 %r43, %r47
%r49 = lshr i384 %r48, 64
%r50 = trunc i384 %r49 to i320
%r51 = bitcast i64* %r4 to i256*
%r52 = load i256, i256* %r51
%r53 = zext i256 %r52 to i320
%r54 = sub i320 %r50, %r53
%r55 = lshr i320 %r54, 256
%r56 = trunc i320 %r55 to i1
%r57 = select i1 %r56, i320 %r50, i320 %r54
%r58 = trunc i320 %r57 to i256
%r59 = bitcast i64* %r1 to i256*
store i256 %r58, i256* %r59
ret void
}
define void @mcl_fp_montNF4L(i64* %r1, i64* %r2, i64* %r3, i64* %r4)
{
%r5 = getelementptr i64, i64* %r4, i32 -1
%r6 = load i64, i64* %r5
%r7 = load i64, i64* %r3
%r8 = call i320 @mulPv256x64(i64* %r2, i64 %r7)
%r9 = trunc i320 %r8 to i64
%r10 = mul i64 %r9, %r6
%r11 = call i320 @mulPv256x64(i64* %r4, i64 %r10)
%r12 = add i320 %r8, %r11
%r13 = lshr i320 %r12, 64
%r14 = getelementptr i64, i64* %r3, i32 1
%r15 = load i64, i64* %r14
%r16 = call i320 @mulPv256x64(i64* %r2, i64 %r15)
%r17 = add i320 %r13, %r16
%r18 = trunc i320 %r17 to i64
%r19 = mul i64 %r18, %r6
%r20 = call i320 @mulPv256x64(i64* %r4, i64 %r19)
%r21 = add i320 %r17, %r20
%r22 = lshr i320 %r21, 64
%r23 = getelementptr i64, i64* %r3, i32 2
%r24 = load i64, i64* %r23
%r25 = call i320 @mulPv256x64(i64* %r2, i64 %r24)
%r26 = add i320 %r22, %r25
%r27 = trunc i320 %r26 to i64
%r28 = mul i64 %r27, %r6
%r29 = call i320 @mulPv256x64(i64* %r4, i64 %r28)
%r30 = add i320 %r26, %r29
%r31 = lshr i320 %r30, 64
%r32 = getelementptr i64, i64* %r3, i32 3
%r33 = load i64, i64* %r32
%r34 = call i320 @mulPv256x64(i64* %r2, i64 %r33)
%r35 = add i320 %r31, %r34
%r36 = trunc i320 %r35 to i64
%r37 = mul i64 %r36, %r6
%r38 = call i320 @mulPv256x64(i64* %r4, i64 %r37)
%r39 = add i320 %r35, %r38
%r40 = lshr i320 %r39, 64
%r41 = trunc i320 %r40 to i256
%r42 = bitcast i64* %r4 to i256*
%r43 = load i256, i256* %r42
%r44 = sub i256 %r41, %r43
%r45 = lshr i256 %r44, 255
%r46 = trunc i256 %r45 to i1
%r47 = select i1 %r46, i256 %r41, i256 %r44
%r48 = bitcast i64* %r1 to i256*
store i256 %r47, i256* %r48
ret void
}
define void @mcl_fp_montRed4L(i64* noalias %r1, i64* noalias %r2, i64* noalias %r3)
{
%r4 = getelementptr i64, i64* %r3, i32 -1
%r5 = load i64, i64* %r4
%r6 = bitcast i64* %r3 to i256*
%r7 = load i256, i256* %r6
%r8 = bitcast i64* %r2 to i256*
%r9 = load i256, i256* %r8
%r10 = trunc i256 %r9 to i64
%r11 = mul i64 %r10, %r5
%r12 = call i320 @mulPv256x64(i64* %r3, i64 %r11)
%r13 = getelementptr i64, i64* %r2, i32 4
%r14 = load i64, i64* %r13
%r15 = zext i256 %r9 to i320
%r16 = zext i64 %r14 to i320
%r17 = shl i320 %r16, 256
%r18 = or i320 %r15, %r17
%r19 = zext i320 %r18 to i384
%r20 = zext i320 %r12 to i384
%r21 = add i384 %r19, %r20
%r22 = lshr i384 %r21, 64
%r23 = trunc i384 %r22 to i320
%r24 = lshr i320 %r23, 256
%r25 = trunc i320 %r24 to i64
%r26 = trunc i320 %r23 to i256
%r27 = trunc i256 %r26 to i64
%r28 = mul i64 %r27, %r5
%r29 = call i320 @mulPv256x64(i64* %r3, i64 %r28)
%r30 = zext i64 %r25 to i320
%r31 = shl i320 %r30, 256
%r32 = add i320 %r29, %r31
%r33 = getelementptr i64, i64* %r2, i32 5
%r34 = load i64, i64* %r33
%r35 = zext i256 %r26 to i320
%r36 = zext i64 %r34 to i320
%r37 = shl i320 %r36, 256
%r38 = or i320 %r35, %r37
%r39 = zext i320 %r38 to i384
%r40 = zext i320 %r32 to i384
%r41 = add i384 %r39, %r40
%r42 = lshr i384 %r41, 64
%r43 = trunc i384 %r42 to i320
%r44 = lshr i320 %r43, 256
%r45 = trunc i320 %r44 to i64
%r46 = trunc i320 %r43 to i256
%r47 = trunc i256 %r46 to i64
%r48 = mul i64 %r47, %r5
%r49 = call i320 @mulPv256x64(i64* %r3, i64 %r48)
%r50 = zext i64 %r45 to i320
%r51 = shl i320 %r50, 256
%r52 = add i320 %r49, %r51
%r53 = getelementptr i64, i64* %r2, i32 6
%r54 = load i64, i64* %r53
%r55 = zext i256 %r46 to i320
%r56 = zext i64 %r54 to i320
%r57 = shl i320 %r56, 256
%r58 = or i320 %r55, %r57
%r59 = zext i320 %r58 to i384
%r60 = zext i320 %r52 to i384
%r61 = add i384 %r59, %r60
%r62 = lshr i384 %r61, 64
%r63 = trunc i384 %r62 to i320
%r64 = lshr i320 %r63, 256
%r65 = trunc i320 %r64 to i64
%r66 = trunc i320 %r63 to i256
%r67 = trunc i256 %r66 to i64
%r68 = mul i64 %r67, %r5
%r69 = call i320 @mulPv256x64(i64* %r3, i64 %r68)
%r70 = zext i64 %r65 to i320
%r71 = shl i320 %r70, 256
%r72 = add i320 %r69, %r71
%r73 = getelementptr i64, i64* %r2, i32 7
%r74 = load i64, i64* %r73
%r75 = zext i256 %r66 to i320
%r76 = zext i64 %r74 to i320
%r77 = shl i320 %r76, 256
%r78 = or i320 %r75, %r77
%r79 = zext i320 %r78 to i384
%r80 = zext i320 %r72 to i384
%r81 = add i384 %r79, %r80
%r82 = lshr i384 %r81, 64
%r83 = trunc i384 %r82 to i320
%r84 = lshr i320 %r83, 256
%r85 = trunc i320 %r84 to i64
%r86 = trunc i320 %r83 to i256
%r87 = zext i256 %r7 to i320
%r88 = zext i256 %r86 to i320
%r89 = zext i64 %r85 to i320
%r90 = shl i320 %r89, 256
%r91 = or i320 %r88, %r90
%r92 = sub i320 %r91, %r87
%r93 = lshr i320 %r92, 256
%r94 = trunc i320 %r93 to i1
%r95 = select i1 %r94, i320 %r91, i320 %r92
%r96 = trunc i320 %r95 to i256
%r97 = bitcast i64* %r1 to i256*
store i256 %r96, i256* %r97
ret void
}
define void @mcl_fp_montRedNF4L(i64* noalias %r1, i64* noalias %r2, i64* noalias %r3)
{
%r4 = getelementptr i64, i64* %r3, i32 -1
%r5 = load i64, i64* %r4
%r6 = bitcast i64* %r3 to i256*
%r7 = load i256, i256* %r6
%r8 = bitcast i64* %r2 to i256*
%r9 = load i256, i256* %r8
%r10 = trunc i256 %r9 to i64
%r11 = mul i64 %r10, %r5
%r12 = call i320 @mulPv256x64(i64* %r3, i64 %r11)
%r13 = getelementptr i64, i64* %r2, i32 4
%r14 = load i64, i64* %r13
%r15 = zext i256 %r9 to i320
%r16 = zext i64 %r14 to i320
%r17 = shl i320 %r16, 256
%r18 = or i320 %r15, %r17
%r19 = zext i320 %r18 to i384
%r20 = zext i320 %r12 to i384
%r21 = add i384 %r19, %r20
%r22 = lshr i384 %r21, 64
%r23 = trunc i384 %r22 to i320
%r24 = lshr i320 %r23, 256
%r25 = trunc i320 %r24 to i64
%r26 = trunc i320 %r23 to i256
%r27 = trunc i256 %r26 to i64
%r28 = mul i64 %r27, %r5
%r29 = call i320 @mulPv256x64(i64* %r3, i64 %r28)
%r30 = zext i64 %r25 to i320
%r31 = shl i320 %r30, 256
%r32 = add i320 %r29, %r31
%r33 = getelementptr i64, i64* %r2, i32 5
%r34 = load i64, i64* %r33
%r35 = zext i256 %r26 to i320
%r36 = zext i64 %r34 to i320
%r37 = shl i320 %r36, 256
%r38 = or i320 %r35, %r37
%r39 = zext i320 %r38 to i384
%r40 = zext i320 %r32 to i384
%r41 = add i384 %r39, %r40
%r42 = lshr i384 %r41, 64
%r43 = trunc i384 %r42 to i320
%r44 = lshr i320 %r43, 256
%r45 = trunc i320 %r44 to i64
%r46 = trunc i320 %r43 to i256
%r47 = trunc i256 %r46 to i64
%r48 = mul i64 %r47, %r5
%r49 = call i320 @mulPv256x64(i64* %r3, i64 %r48)
%r50 = zext i64 %r45 to i320
%r51 = shl i320 %r50, 256
%r52 = add i320 %r49, %r51
%r53 = getelementptr i64, i64* %r2, i32 6
%r54 = load i64, i64* %r53
%r55 = zext i256 %r46 to i320
%r56 = zext i64 %r54 to i320
%r57 = shl i320 %r56, 256
%r58 = or i320 %r55, %r57
%r59 = zext i320 %r58 to i384
%r60 = zext i320 %r52 to i384
%r61 = add i384 %r59, %r60
%r62 = lshr i384 %r61, 64
%r63 = trunc i384 %r62 to i320
%r64 = lshr i320 %r63, 256
%r65 = trunc i320 %r64 to i64
%r66 = trunc i320 %r63 to i256
%r67 = trunc i256 %r66 to i64
%r68 = mul i64 %r67, %r5
%r69 = call i320 @mulPv256x64(i64* %r3, i64 %r68)
%r70 = zext i64 %r65 to i320
%r71 = shl i320 %r70, 256
%r72 = add i320 %r69, %r71
%r73 = getelementptr i64, i64* %r2, i32 7
%r74 = load i64, i64* %r73
%r75 = zext i256 %r66 to i320
%r76 = zext i64 %r74 to i320
%r77 = shl i320 %r76, 256
%r78 = or i320 %r75, %r77
%r79 = zext i320 %r78 to i384
%r80 = zext i320 %r72 to i384
%r81 = add i384 %r79, %r80
%r82 = lshr i384 %r81, 64
%r83 = trunc i384 %r82 to i320
%r84 = lshr i320 %r83, 256
%r85 = trunc i320 %r84 to i64
%r86 = trunc i320 %r83 to i256
%r87 = sub i256 %r86, %r7
%r88 = lshr i256 %r87, 255
%r89 = trunc i256 %r88 to i1
%r90 = select i1 %r89, i256 %r86, i256 %r87
%r91 = bitcast i64* %r1 to i256*
store i256 %r90, i256* %r91
ret void
}
define i64 @mcl_fp_addPre4L(i64* noalias %r1, i64* noalias %r2, i64* noalias %r3)
{
%r5 = bitcast i64* %r2 to i256*
%r6 = load i256, i256* %r5
%r7 = zext i256 %r6 to i320
%r8 = bitcast i64* %r3 to i256*
%r9 = load i256, i256* %r8
%r10 = zext i256 %r9 to i320
%r11 = add i320 %r7, %r10
%r12 = trunc i320 %r11 to i256
%r13 = bitcast i64* %r1 to i256*
store i256 %r12, i256* %r13
%r14 = lshr i320 %r11, 256
%r15 = trunc i320 %r14 to i64
ret i64 %r15
}
define i64 @mcl_fp_subPre4L(i64* noalias %r1, i64* noalias %r2, i64* noalias %r3)
{
%r5 = bitcast i64* %r2 to i256*
%r6 = load i256, i256* %r5
%r7 = zext i256 %r6 to i320
%r8 = bitcast i64* %r3 to i256*
%r9 = load i256, i256* %r8
%r10 = zext i256 %r9 to i320
%r11 = sub i320 %r7, %r10
%r12 = trunc i320 %r11 to i256
%r13 = bitcast i64* %r1 to i256*
store i256 %r12, i256* %r13
%r14 = lshr i320 %r11, 256
%r15 = trunc i320 %r14 to i64
%r16 = and i64 %r15, 1
ret i64 %r16
}
define void @mcl_fp_shr1_4L(i64* noalias %r1, i64* noalias %r2)
{
%r3 = bitcast i64* %r2 to i256*
%r4 = load i256, i256* %r3
%r5 = lshr i256 %r4, 1
%r6 = bitcast i64* %r1 to i256*
store i256 %r5, i256* %r6
ret void
}
define void @mcl_fp_add4L(i64* noalias %r1, i64* noalias %r2, i64* noalias %r3, i64* noalias %r4)
{
%r5 = bitcast i64* %r2 to i256*
%r6 = load i256, i256* %r5
%r7 = bitcast i64* %r3 to i256*
%r8 = load i256, i256* %r7
%r9 = bitcast i64* %r4 to i256*
%r10 = load i256, i256* %r9
%r11 = zext i256 %r6 to i320
%r12 = zext i256 %r8 to i320
%r13 = add i320 %r11, %r12
%r14 = zext i256 %r10 to i320
%r15 = sub i320 %r13, %r14
%r16 = lshr i320 %r15, 256
%r17 = trunc i320 %r16 to i1
%r18 = select i1 %r17, i320 %r13, i320 %r15
%r19 = trunc i320 %r18 to i256
%r20 = bitcast i64* %r1 to i256*
store i256 %r19, i256* %r20
ret void
}
define void @mcl_fp_addNF4L(i64* noalias %r1, i64* noalias %r2, i64* noalias %r3, i64* noalias %r4)
{
%r5 = bitcast i64* %r2 to i256*
%r6 = load i256, i256* %r5
%r7 = bitcast i64* %r3 to i256*
%r8 = load i256, i256* %r7
%r9 = bitcast i64* %r4 to i256*
%r10 = load i256, i256* %r9
%r11 = add i256 %r6, %r8
%r12 = sub i256 %r11, %r10
%r13 = lshr i256 %r12, 255
%r14 = trunc i256 %r13 to i1
%r15 = select i1 %r14, i256 %r11, i256 %r12
%r16 = bitcast i64* %r1 to i256*
store i256 %r15, i256* %r16
ret void
}
define void @mcl_fp_sub4L(i64* noalias %r1, i64* noalias %r2, i64* noalias %r3, i64* noalias %r4)
{
%r5 = bitcast i64* %r2 to i256*
%r6 = load i256, i256* %r5
%r7 = bitcast i64* %r3 to i256*
%r8 = load i256, i256* %r7
%r9 = zext i256 %r6 to i320
%r10 = zext i256 %r8 to i320
%r11 = sub i320 %r9, %r10
%r12 = lshr i320 %r11, 256
%r13 = trunc i320 %r12 to i1
%r14 = trunc i320 %r11 to i256
%r15 = bitcast i64* %r4 to i256*
%r16 = load i256, i256* %r15
%r17 = select i1 %r13, i256 %r16, i256 0
%r18 = add i256 %r14, %r17
%r19 = bitcast i64* %r1 to i256*
store i256 %r18, i256* %r19
ret void
}
define void @mcl_fp_subNF4L(i64* noalias %r1, i64* noalias %r2, i64* noalias %r3, i64* noalias %r4)
{
%r5 = bitcast i64* %r2 to i256*
%r6 = load i256, i256* %r5
%r7 = bitcast i64* %r3 to i256*
%r8 = load i256, i256* %r7
%r9 = sub i256 %r6, %r8
%r10 = lshr i256 %r9, 255
%r11 = trunc i256 %r10 to i1
%r12 = bitcast i64* %r4 to i256*
%r13 = load i256, i256* %r12
%r14 = select i1 %r11, i256 %r13, i256 0
%r15 = add i256 %r9, %r14
%r16 = bitcast i64* %r1 to i256*
store i256 %r15, i256* %r16
ret void
}
define void @mcl_fpDbl_add4L(i64* noalias %r1, i64* noalias %r2, i64* noalias %r3, i64* noalias %r4)
{
%r5 = bitcast i64* %r2 to i512*
%r6 = load i512, i512* %r5
%r7 = bitcast i64* %r3 to i512*
%r8 = load i512, i512* %r7
%r9 = zext i512 %r6 to i576
%r10 = zext i512 %r8 to i576
%r11 = add i576 %r9, %r10
%r12 = trunc i576 %r11 to i256
%r13 = bitcast i64* %r1 to i256*
store i256 %r12, i256* %r13
%r14 = lshr i576 %r11, 256
%r15 = trunc i576 %r14 to i320
%r16 = bitcast i64* %r4 to i256*
%r17 = load i256, i256* %r16
%r18 = zext i256 %r17 to i320
%r19 = sub i320 %r15, %r18
%r20 = lshr i320 %r19, 256
%r21 = trunc i320 %r20 to i1
%r22 = select i1 %r21, i320 %r15, i320 %r19
%r23 = trunc i320 %r22 to i256
%r24 = getelementptr i64, i64* %r1, i32 4
%r25 = bitcast i64* %r24 to i256*
store i256 %r23, i256* %r25
ret void
}
define void @mcl_fpDbl_sub4L(i64* noalias %r1, i64* noalias %r2, i64* noalias %r3, i64* noalias %r4)
{
%r5 = bitcast i64* %r2 to i512*
%r6 = load i512, i512* %r5
%r7 = bitcast i64* %r3 to i512*
%r8 = load i512, i512* %r7
%r9 = zext i512 %r6 to i576
%r10 = zext i512 %r8 to i576
%r11 = sub i576 %r9, %r10
%r12 = trunc i576 %r11 to i256
%r13 = bitcast i64* %r1 to i256*
store i256 %r12, i256* %r13
%r14 = lshr i576 %r11, 256
%r15 = trunc i576 %r14 to i256
%r16 = lshr i576 %r11, 512
%r17 = trunc i576 %r16 to i1
%r18 = bitcast i64* %r4 to i256*
%r19 = load i256, i256* %r18
%r20 = select i1 %r17, i256 %r19, i256 0
%r21 = add i256 %r15, %r20
%r22 = getelementptr i64, i64* %r1, i32 4
%r23 = bitcast i64* %r22 to i256*
store i256 %r21, i256* %r23
ret void
}
define i448 @mulPv384x64(i64* noalias %r2, i64 %r3)
{
%r4 = call i128 @mulPos64x64(i64* %r2, i64 %r3, i64 0)
%r5 = trunc i128 %r4 to i64
%r6 = call i64 @extractHigh64(i128 %r4)
%r7 = call i128 @mulPos64x64(i64* %r2, i64 %r3, i64 1)
%r8 = trunc i128 %r7 to i64
%r9 = call i64 @extractHigh64(i128 %r7)
%r10 = call i128 @mulPos64x64(i64* %r2, i64 %r3, i64 2)
%r11 = trunc i128 %r10 to i64
%r12 = call i64 @extractHigh64(i128 %r10)
%r13 = call i128 @mulPos64x64(i64* %r2, i64 %r3, i64 3)
%r14 = trunc i128 %r13 to i64
%r15 = call i64 @extractHigh64(i128 %r13)
%r16 = call i128 @mulPos64x64(i64* %r2, i64 %r3, i64 4)
%r17 = trunc i128 %r16 to i64
%r18 = call i64 @extractHigh64(i128 %r16)
%r19 = call i128 @mulPos64x64(i64* %r2, i64 %r3, i64 5)
%r20 = trunc i128 %r19 to i64
%r21 = call i64 @extractHigh64(i128 %r19)
%r22 = zext i64 %r5 to i128
%r23 = zext i64 %r8 to i128
%r24 = shl i128 %r23, 64
%r25 = or i128 %r22, %r24
%r26 = zext i128 %r25 to i192
%r27 = zext i64 %r11 to i192
%r28 = shl i192 %r27, 128
%r29 = or i192 %r26, %r28
%r30 = zext i192 %r29 to i256
%r31 = zext i64 %r14 to i256
%r32 = shl i256 %r31, 192
%r33 = or i256 %r30, %r32
%r34 = zext i256 %r33 to i320
%r35 = zext i64 %r17 to i320
%r36 = shl i320 %r35, 256
%r37 = or i320 %r34, %r36
%r38 = zext i320 %r37 to i384
%r39 = zext i64 %r20 to i384
%r40 = shl i384 %r39, 320
%r41 = or i384 %r38, %r40
%r42 = zext i64 %r6 to i128
%r43 = zext i64 %r9 to i128
%r44 = shl i128 %r43, 64
%r45 = or i128 %r42, %r44
%r46 = zext i128 %r45 to i192
%r47 = zext i64 %r12 to i192
%r48 = shl i192 %r47, 128
%r49 = or i192 %r46, %r48
%r50 = zext i192 %r49 to i256
%r51 = zext i64 %r15 to i256
%r52 = shl i256 %r51, 192
%r53 = or i256 %r50, %r52
%r54 = zext i256 %r53 to i320
%r55 = zext i64 %r18 to i320
%r56 = shl i320 %r55, 256
%r57 = or i320 %r54, %r56
%r58 = zext i320 %r57 to i384
%r59 = zext i64 %r21 to i384
%r60 = shl i384 %r59, 320
%r61 = or i384 %r58, %r60
%r62 = zext i384 %r41 to i448
%r63 = zext i384 %r61 to i448
%r64 = shl i448 %r63, 64
%r65 = add i448 %r62, %r64
ret i448 %r65
}
define void @mcl_fp_mont6L(i64* %r1, i64* %r2, i64* %r3, i64* %r4)
{
%r5 = getelementptr i64, i64* %r4, i32 -1
%r6 = load i64, i64* %r5
%r7 = getelementptr i64, i64* %r3, i32 0
%r8 = load i64, i64* %r7
%r9 = call i448 @mulPv384x64(i64* %r2, i64 %r8)
%r10 = zext i448 %r9 to i512
%r11 = trunc i448 %r9 to i64
%r12 = mul i64 %r11, %r6
%r13 = call i448 @mulPv384x64(i64* %r4, i64 %r12)
%r14 = zext i448 %r13 to i512
%r15 = add i512 %r10, %r14
%r16 = lshr i512 %r15, 64
%r17 = getelementptr i64, i64* %r3, i32 1
%r18 = load i64, i64* %r17
%r19 = call i448 @mulPv384x64(i64* %r2, i64 %r18)
%r20 = zext i448 %r19 to i512
%r21 = add i512 %r16, %r20
%r22 = trunc i512 %r21 to i64
%r23 = mul i64 %r22, %r6
%r24 = call i448 @mulPv384x64(i64* %r4, i64 %r23)
%r25 = zext i448 %r24 to i512
%r26 = add i512 %r21, %r25
%r27 = lshr i512 %r26, 64
%r28 = getelementptr i64, i64* %r3, i32 2
%r29 = load i64, i64* %r28
%r30 = call i448 @mulPv384x64(i64* %r2, i64 %r29)
%r31 = zext i448 %r30 to i512
%r32 = add i512 %r27, %r31
%r33 = trunc i512 %r32 to i64
%r34 = mul i64 %r33, %r6
%r35 = call i448 @mulPv384x64(i64* %r4, i64 %r34)
%r36 = zext i448 %r35 to i512
%r37 = add i512 %r32, %r36
%r38 = lshr i512 %r37, 64
%r39 = getelementptr i64, i64* %r3, i32 3
%r40 = load i64, i64* %r39
%r41 = call i448 @mulPv384x64(i64* %r2, i64 %r40)
%r42 = zext i448 %r41 to i512
%r43 = add i512 %r38, %r42
%r44 = trunc i512 %r43 to i64
%r45 = mul i64 %r44, %r6
%r46 = call i448 @mulPv384x64(i64* %r4, i64 %r45)
%r47 = zext i448 %r46 to i512
%r48 = add i512 %r43, %r47
%r49 = lshr i512 %r48, 64
%r50 = getelementptr i64, i64* %r3, i32 4
%r51 = load i64, i64* %r50
%r52 = call i448 @mulPv384x64(i64* %r2, i64 %r51)
%r53 = zext i448 %r52 to i512
%r54 = add i512 %r49, %r53
%r55 = trunc i512 %r54 to i64
%r56 = mul i64 %r55, %r6
%r57 = call i448 @mulPv384x64(i64* %r4, i64 %r56)
%r58 = zext i448 %r57 to i512
%r59 = add i512 %r54, %r58
%r60 = lshr i512 %r59, 64
%r61 = getelementptr i64, i64* %r3, i32 5
%r62 = load i64, i64* %r61
%r63 = call i448 @mulPv384x64(i64* %r2, i64 %r62)
%r64 = zext i448 %r63 to i512
%r65 = add i512 %r60, %r64
%r66 = trunc i512 %r65 to i64
%r67 = mul i64 %r66, %r6
%r68 = call i448 @mulPv384x64(i64* %r4, i64 %r67)
%r69 = zext i448 %r68 to i512
%r70 = add i512 %r65, %r69
%r71 = lshr i512 %r70, 64
%r72 = trunc i512 %r71 to i448
%r73 = bitcast i64* %r4 to i384*
%r74 = load i384, i384* %r73
%r75 = zext i384 %r74 to i448
%r76 = sub i448 %r72, %r75
%r77 = lshr i448 %r76, 384
%r78 = trunc i448 %r77 to i1
%r79 = select i1 %r78, i448 %r72, i448 %r76
%r80 = trunc i448 %r79 to i384
%r81 = bitcast i64* %r1 to i384*
store i384 %r80, i384* %r81
ret void
}
define void @mcl_fp_montNF6L(i64* %r1, i64* %r2, i64* %r3, i64* %r4)
{
%r5 = getelementptr i64, i64* %r4, i32 -1
%r6 = load i64, i64* %r5
%r7 = load i64, i64* %r3
%r8 = call i448 @mulPv384x64(i64* %r2, i64 %r7)
%r9 = trunc i448 %r8 to i64
%r10 = mul i64 %r9, %r6
%r11 = call i448 @mulPv384x64(i64* %r4, i64 %r10)
%r12 = add i448 %r8, %r11
%r13 = lshr i448 %r12, 64
%r14 = getelementptr i64, i64* %r3, i32 1
%r15 = load i64, i64* %r14
%r16 = call i448 @mulPv384x64(i64* %r2, i64 %r15)
%r17 = add i448 %r13, %r16
%r18 = trunc i448 %r17 to i64
%r19 = mul i64 %r18, %r6
%r20 = call i448 @mulPv384x64(i64* %r4, i64 %r19)
%r21 = add i448 %r17, %r20
%r22 = lshr i448 %r21, 64
%r23 = getelementptr i64, i64* %r3, i32 2
%r24 = load i64, i64* %r23
%r25 = call i448 @mulPv384x64(i64* %r2, i64 %r24)
%r26 = add i448 %r22, %r25
%r27 = trunc i448 %r26 to i64
%r28 = mul i64 %r27, %r6
%r29 = call i448 @mulPv384x64(i64* %r4, i64 %r28)
%r30 = add i448 %r26, %r29
%r31 = lshr i448 %r30, 64
%r32 = getelementptr i64, i64* %r3, i32 3
%r33 = load i64, i64* %r32
%r34 = call i448 @mulPv384x64(i64* %r2, i64 %r33)
%r35 = add i448 %r31, %r34
%r36 = trunc i448 %r35 to i64
%r37 = mul i64 %r36, %r6
%r38 = call i448 @mulPv384x64(i64* %r4, i64 %r37)
%r39 = add i448 %r35, %r38
%r40 = lshr i448 %r39, 64
%r41 = getelementptr i64, i64* %r3, i32 4
%r42 = load i64, i64* %r41
%r43 = call i448 @mulPv384x64(i64* %r2, i64 %r42)
%r44 = add i448 %r40, %r43
%r45 = trunc i448 %r44 to i64
%r46 = mul i64 %r45, %r6
%r47 = call i448 @mulPv384x64(i64* %r4, i64 %r46)
%r48 = add i448 %r44, %r47
%r49 = lshr i448 %r48, 64
%r50 = getelementptr i64, i64* %r3, i32 5
%r51 = load i64, i64* %r50
%r52 = call i448 @mulPv384x64(i64* %r2, i64 %r51)
%r53 = add i448 %r49, %r52
%r54 = trunc i448 %r53 to i64
%r55 = mul i64 %r54, %r6
%r56 = call i448 @mulPv384x64(i64* %r4, i64 %r55)
%r57 = add i448 %r53, %r56
%r58 = lshr i448 %r57, 64
%r59 = trunc i448 %r58 to i384
%r60 = bitcast i64* %r4 to i384*
%r61 = load i384, i384* %r60
%r62 = sub i384 %r59, %r61
%r63 = lshr i384 %r62, 383
%r64 = trunc i384 %r63 to i1
%r65 = select i1 %r64, i384 %r59, i384 %r62
%r66 = bitcast i64* %r1 to i384*
store i384 %r65, i384* %r66
ret void
}
define void @mcl_fp_montRed6L(i64* noalias %r1, i64* noalias %r2, i64* noalias %r3)
{
%r4 = getelementptr i64, i64* %r3, i32 -1
%r5 = load i64, i64* %r4
%r6 = bitcast i64* %r3 to i384*
%r7 = load i384, i384* %r6
%r8 = bitcast i64* %r2 to i384*
%r9 = load i384, i384* %r8
%r10 = trunc i384 %r9 to i64
%r11 = mul i64 %r10, %r5
%r12 = call i448 @mulPv384x64(i64* %r3, i64 %r11)
%r13 = getelementptr i64, i64* %r2, i32 6
%r14 = load i64, i64* %r13
%r15 = zext i384 %r9 to i448
%r16 = zext i64 %r14 to i448
%r17 = shl i448 %r16, 384
%r18 = or i448 %r15, %r17
%r19 = zext i448 %r18 to i512
%r20 = zext i448 %r12 to i512
%r21 = add i512 %r19, %r20
%r22 = lshr i512 %r21, 64
%r23 = trunc i512 %r22 to i448
%r24 = lshr i448 %r23, 384
%r25 = trunc i448 %r24 to i64
%r26 = trunc i448 %r23 to i384
%r27 = trunc i384 %r26 to i64
%r28 = mul i64 %r27, %r5
%r29 = call i448 @mulPv384x64(i64* %r3, i64 %r28)
%r30 = zext i64 %r25 to i448
%r31 = shl i448 %r30, 384
%r32 = add i448 %r29, %r31
%r33 = getelementptr i64, i64* %r2, i32 7
%r34 = load i64, i64* %r33
%r35 = zext i384 %r26 to i448
%r36 = zext i64 %r34 to i448
%r37 = shl i448 %r36, 384
%r38 = or i448 %r35, %r37
%r39 = zext i448 %r38 to i512
%r40 = zext i448 %r32 to i512
%r41 = add i512 %r39, %r40
%r42 = lshr i512 %r41, 64
%r43 = trunc i512 %r42 to i448
%r44 = lshr i448 %r43, 384
%r45 = trunc i448 %r44 to i64
%r46 = trunc i448 %r43 to i384
%r47 = trunc i384 %r46 to i64
%r48 = mul i64 %r47, %r5
%r49 = call i448 @mulPv384x64(i64* %r3, i64 %r48)
%r50 = zext i64 %r45 to i448
%r51 = shl i448 %r50, 384
%r52 = add i448 %r49, %r51
%r53 = getelementptr i64, i64* %r2, i32 8
%r54 = load i64, i64* %r53
%r55 = zext i384 %r46 to i448
%r56 = zext i64 %r54 to i448
%r57 = shl i448 %r56, 384
%r58 = or i448 %r55, %r57
%r59 = zext i448 %r58 to i512
%r60 = zext i448 %r52 to i512
%r61 = add i512 %r59, %r60
%r62 = lshr i512 %r61, 64
%r63 = trunc i512 %r62 to i448
%r64 = lshr i448 %r63, 384
%r65 = trunc i448 %r64 to i64
%r66 = trunc i448 %r63 to i384
%r67 = trunc i384 %r66 to i64
%r68 = mul i64 %r67, %r5
%r69 = call i448 @mulPv384x64(i64* %r3, i64 %r68)
%r70 = zext i64 %r65 to i448
%r71 = shl i448 %r70, 384
%r72 = add i448 %r69, %r71
%r73 = getelementptr i64, i64* %r2, i32 9
%r74 = load i64, i64* %r73
%r75 = zext i384 %r66 to i448
%r76 = zext i64 %r74 to i448
%r77 = shl i448 %r76, 384
%r78 = or i448 %r75, %r77
%r79 = zext i448 %r78 to i512
%r80 = zext i448 %r72 to i512
%r81 = add i512 %r79, %r80
%r82 = lshr i512 %r81, 64
%r83 = trunc i512 %r82 to i448
%r84 = lshr i448 %r83, 384
%r85 = trunc i448 %r84 to i64
%r86 = trunc i448 %r83 to i384
%r87 = trunc i384 %r86 to i64
%r88 = mul i64 %r87, %r5
%r89 = call i448 @mulPv384x64(i64* %r3, i64 %r88)
%r90 = zext i64 %r85 to i448
%r91 = shl i448 %r90, 384
%r92 = add i448 %r89, %r91
%r93 = getelementptr i64, i64* %r2, i32 10
%r94 = load i64, i64* %r93
%r95 = zext i384 %r86 to i448
%r96 = zext i64 %r94 to i448
%r97 = shl i448 %r96, 384
%r98 = or i448 %r95, %r97
%r99 = zext i448 %r98 to i512
%r100 = zext i448 %r92 to i512
%r101 = add i512 %r99, %r100
%r102 = lshr i512 %r101, 64
%r103 = trunc i512 %r102 to i448
%r104 = lshr i448 %r103, 384
%r105 = trunc i448 %r104 to i64
%r106 = trunc i448 %r103 to i384
%r107 = trunc i384 %r106 to i64
%r108 = mul i64 %r107, %r5
%r109 = call i448 @mulPv384x64(i64* %r3, i64 %r108)
%r110 = zext i64 %r105 to i448
%r111 = shl i448 %r110, 384
%r112 = add i448 %r109, %r111
%r113 = getelementptr i64, i64* %r2, i32 11
%r114 = load i64, i64* %r113
%r115 = zext i384 %r106 to i448
%r116 = zext i64 %r114 to i448
%r117 = shl i448 %r116, 384
%r118 = or i448 %r115, %r117
%r119 = zext i448 %r118 to i512
%r120 = zext i448 %r112 to i512
%r121 = add i512 %r119, %r120
%r122 = lshr i512 %r121, 64
%r123 = trunc i512 %r122 to i448
%r124 = lshr i448 %r123, 384
%r125 = trunc i448 %r124 to i64
%r126 = trunc i448 %r123 to i384
%r127 = zext i384 %r7 to i448
%r128 = zext i384 %r126 to i448
%r129 = zext i64 %r125 to i448
%r130 = shl i448 %r129, 384
%r131 = or i448 %r128, %r130
%r132 = sub i448 %r131, %r127
%r133 = lshr i448 %r132, 384
%r134 = trunc i448 %r133 to i1
%r135 = select i1 %r134, i448 %r131, i448 %r132
%r136 = trunc i448 %r135 to i384
%r137 = bitcast i64* %r1 to i384*
store i384 %r136, i384* %r137
ret void
}
define void @mcl_fp_montRedNF6L(i64* noalias %r1, i64* noalias %r2, i64* noalias %r3)
{
%r4 = getelementptr i64, i64* %r3, i32 -1
%r5 = load i64, i64* %r4
%r6 = bitcast i64* %r3 to i384*
%r7 = load i384, i384* %r6
%r8 = bitcast i64* %r2 to i384*
%r9 = load i384, i384* %r8
%r10 = trunc i384 %r9 to i64
%r11 = mul i64 %r10, %r5
%r12 = call i448 @mulPv384x64(i64* %r3, i64 %r11)
%r13 = getelementptr i64, i64* %r2, i32 6
%r14 = load i64, i64* %r13
%r15 = zext i384 %r9 to i448
%r16 = zext i64 %r14 to i448
%r17 = shl i448 %r16, 384
%r18 = or i448 %r15, %r17
%r19 = zext i448 %r18 to i512
%r20 = zext i448 %r12 to i512
%r21 = add i512 %r19, %r20
%r22 = lshr i512 %r21, 64
%r23 = trunc i512 %r22 to i448
%r24 = lshr i448 %r23, 384
%r25 = trunc i448 %r24 to i64
%r26 = trunc i448 %r23 to i384
%r27 = trunc i384 %r26 to i64
%r28 = mul i64 %r27, %r5
%r29 = call i448 @mulPv384x64(i64* %r3, i64 %r28)
%r30 = zext i64 %r25 to i448
%r31 = shl i448 %r30, 384
%r32 = add i448 %r29, %r31
%r33 = getelementptr i64, i64* %r2, i32 7
%r34 = load i64, i64* %r33
%r35 = zext i384 %r26 to i448
%r36 = zext i64 %r34 to i448
%r37 = shl i448 %r36, 384
%r38 = or i448 %r35, %r37
%r39 = zext i448 %r38 to i512
%r40 = zext i448 %r32 to i512
%r41 = add i512 %r39, %r40
%r42 = lshr i512 %r41, 64
%r43 = trunc i512 %r42 to i448
%r44 = lshr i448 %r43, 384
%r45 = trunc i448 %r44 to i64
%r46 = trunc i448 %r43 to i384
%r47 = trunc i384 %r46 to i64
%r48 = mul i64 %r47, %r5
%r49 = call i448 @mulPv384x64(i64* %r3, i64 %r48)
%r50 = zext i64 %r45 to i448
%r51 = shl i448 %r50, 384
%r52 = add i448 %r49, %r51
%r53 = getelementptr i64, i64* %r2, i32 8
%r54 = load i64, i64* %r53
%r55 = zext i384 %r46 to i448
%r56 = zext i64 %r54 to i448
%r57 = shl i448 %r56, 384
%r58 = or i448 %r55, %r57
%r59 = zext i448 %r58 to i512
%r60 = zext i448 %r52 to i512
%r61 = add i512 %r59, %r60
%r62 = lshr i512 %r61, 64
%r63 = trunc i512 %r62 to i448
%r64 = lshr i448 %r63, 384
%r65 = trunc i448 %r64 to i64
%r66 = trunc i448 %r63 to i384
%r67 = trunc i384 %r66 to i64
%r68 = mul i64 %r67, %r5
%r69 = call i448 @mulPv384x64(i64* %r3, i64 %r68)
%r70 = zext i64 %r65 to i448
%r71 = shl i448 %r70, 384
%r72 = add i448 %r69, %r71
%r73 = getelementptr i64, i64* %r2, i32 9
%r74 = load i64, i64* %r73
%r75 = zext i384 %r66 to i448
%r76 = zext i64 %r74 to i448
%r77 = shl i448 %r76, 384
%r78 = or i448 %r75, %r77
%r79 = zext i448 %r78 to i512
%r80 = zext i448 %r72 to i512
%r81 = add i512 %r79, %r80
%r82 = lshr i512 %r81, 64
%r83 = trunc i512 %r82 to i448
%r84 = lshr i448 %r83, 384
%r85 = trunc i448 %r84 to i64
%r86 = trunc i448 %r83 to i384
%r87 = trunc i384 %r86 to i64
%r88 = mul i64 %r87, %r5
%r89 = call i448 @mulPv384x64(i64* %r3, i64 %r88)
%r90 = zext i64 %r85 to i448
%r91 = shl i448 %r90, 384
%r92 = add i448 %r89, %r91
%r93 = getelementptr i64, i64* %r2, i32 10
%r94 = load i64, i64* %r93
%r95 = zext i384 %r86 to i448
%r96 = zext i64 %r94 to i448
%r97 = shl i448 %r96, 384
%r98 = or i448 %r95, %r97
%r99 = zext i448 %r98 to i512
%r100 = zext i448 %r92 to i512
%r101 = add i512 %r99, %r100
%r102 = lshr i512 %r101, 64
%r103 = trunc i512 %r102 to i448
%r104 = lshr i448 %r103, 384
%r105 = trunc i448 %r104 to i64
%r106 = trunc i448 %r103 to i384
%r107 = trunc i384 %r106 to i64
%r108 = mul i64 %r107, %r5
%r109 = call i448 @mulPv384x64(i64* %r3, i64 %r108)
%r110 = zext i64 %r105 to i448
%r111 = shl i448 %r110, 384
%r112 = add i448 %r109, %r111
%r113 = getelementptr i64, i64* %r2, i32 11
%r114 = load i64, i64* %r113
%r115 = zext i384 %r106 to i448
%r116 = zext i64 %r114 to i448
%r117 = shl i448 %r116, 384
%r118 = or i448 %r115, %r117
%r119 = zext i448 %r118 to i512
%r120 = zext i448 %r112 to i512
%r121 = add i512 %r119, %r120
%r122 = lshr i512 %r121, 64
%r123 = trunc i512 %r122 to i448
%r124 = lshr i448 %r123, 384
%r125 = trunc i448 %r124 to i64
%r126 = trunc i448 %r123 to i384
%r127 = sub i384 %r126, %r7
%r128 = lshr i384 %r127, 383
%r129 = trunc i384 %r128 to i1
%r130 = select i1 %r129, i384 %r126, i384 %r127
%r131 = bitcast i64* %r1 to i384*
store i384 %r130, i384* %r131
ret void
}
define i64 @mcl_fp_addPre6L(i64* noalias %r1, i64* noalias %r2, i64* noalias %r3)
{
%r5 = bitcast i64* %r2 to i384*
%r6 = load i384, i384* %r5
%r7 = zext i384 %r6 to i448
%r8 = bitcast i64* %r3 to i384*
%r9 = load i384, i384* %r8
%r10 = zext i384 %r9 to i448
%r11 = add i448 %r7, %r10
%r12 = trunc i448 %r11 to i384
%r13 = bitcast i64* %r1 to i384*
store i384 %r12, i384* %r13
%r14 = lshr i448 %r11, 384
%r15 = trunc i448 %r14 to i64
ret i64 %r15
}
define i64 @mcl_fp_subPre6L(i64* noalias %r1, i64* noalias %r2, i64* noalias %r3)
{
%r5 = bitcast i64* %r2 to i384*
%r6 = load i384, i384* %r5
%r7 = zext i384 %r6 to i448
%r8 = bitcast i64* %r3 to i384*
%r9 = load i384, i384* %r8
%r10 = zext i384 %r9 to i448
%r11 = sub i448 %r7, %r10
%r12 = trunc i448 %r11 to i384
%r13 = bitcast i64* %r1 to i384*
store i384 %r12, i384* %r13
%r14 = lshr i448 %r11, 384
%r15 = trunc i448 %r14 to i64
%r16 = and i64 %r15, 1
ret i64 %r16
}
define void @mcl_fp_shr1_6L(i64* noalias %r1, i64* noalias %r2)
{
%r3 = bitcast i64* %r2 to i384*
%r4 = load i384, i384* %r3
%r5 = lshr i384 %r4, 1
%r6 = bitcast i64* %r1 to i384*
store i384 %r5, i384* %r6
ret void
}
define void @mcl_fp_add6L(i64* noalias %r1, i64* noalias %r2, i64* noalias %r3, i64* noalias %r4)
{
%r5 = bitcast i64* %r2 to i384*
%r6 = load i384, i384* %r5
%r7 = bitcast i64* %r3 to i384*
%r8 = load i384, i384* %r7
%r9 = bitcast i64* %r4 to i384*
%r10 = load i384, i384* %r9
%r11 = zext i384 %r6 to i448
%r12 = zext i384 %r8 to i448
%r13 = add i448 %r11, %r12
%r14 = zext i384 %r10 to i448
%r15 = sub i448 %r13, %r14
%r16 = lshr i448 %r15, 384
%r17 = trunc i448 %r16 to i1
%r18 = select i1 %r17, i448 %r13, i448 %r15
%r19 = trunc i448 %r18 to i384
%r20 = bitcast i64* %r1 to i384*
store i384 %r19, i384* %r20
ret void
}
define void @mcl_fp_addNF6L(i64* noalias %r1, i64* noalias %r2, i64* noalias %r3, i64* noalias %r4)
{
%r5 = bitcast i64* %r2 to i384*
%r6 = load i384, i384* %r5
%r7 = bitcast i64* %r3 to i384*
%r8 = load i384, i384* %r7
%r9 = bitcast i64* %r4 to i384*
%r10 = load i384, i384* %r9
%r11 = add i384 %r6, %r8
%r12 = sub i384 %r11, %r10
%r13 = lshr i384 %r12, 383
%r14 = trunc i384 %r13 to i1
%r15 = select i1 %r14, i384 %r11, i384 %r12
%r16 = bitcast i64* %r1 to i384*
store i384 %r15, i384* %r16
ret void
}
define void @mcl_fp_sub6L(i64* noalias %r1, i64* noalias %r2, i64* noalias %r3, i64* noalias %r4)
{
%r5 = bitcast i64* %r2 to i384*
%r6 = load i384, i384* %r5
%r7 = bitcast i64* %r3 to i384*
%r8 = load i384, i384* %r7
%r9 = zext i384 %r6 to i448
%r10 = zext i384 %r8 to i448
%r11 = sub i448 %r9, %r10
%r12 = lshr i448 %r11, 384
%r13 = trunc i448 %r12 to i1
%r14 = trunc i448 %r11 to i384
%r15 = bitcast i64* %r4 to i384*
%r16 = load i384, i384* %r15
%r17 = select i1 %r13, i384 %r16, i384 0
%r18 = add i384 %r14, %r17
%r19 = bitcast i64* %r1 to i384*
store i384 %r18, i384* %r19
ret void
}
define void @mcl_fp_subNF6L(i64* noalias %r1, i64* noalias %r2, i64* noalias %r3, i64* noalias %r4)
{
%r5 = bitcast i64* %r2 to i384*
%r6 = load i384, i384* %r5
%r7 = bitcast i64* %r3 to i384*
%r8 = load i384, i384* %r7
%r9 = sub i384 %r6, %r8
%r10 = lshr i384 %r9, 383
%r11 = trunc i384 %r10 to i1
%r12 = bitcast i64* %r4 to i384*
%r13 = load i384, i384* %r12
%r14 = select i1 %r11, i384 %r13, i384 0
%r15 = add i384 %r9, %r14
%r16 = bitcast i64* %r1 to i384*
store i384 %r15, i384* %r16
ret void
}
define void @mcl_fpDbl_add6L(i64* noalias %r1, i64* noalias %r2, i64* noalias %r3, i64* noalias %r4)
{
%r5 = bitcast i64* %r2 to i768*
%r6 = load i768, i768* %r5
%r7 = bitcast i64* %r3 to i768*
%r8 = load i768, i768* %r7
%r9 = zext i768 %r6 to i832
%r10 = zext i768 %r8 to i832
%r11 = add i832 %r9, %r10
%r12 = trunc i832 %r11 to i384
%r13 = bitcast i64* %r1 to i384*
store i384 %r12, i384* %r13
%r14 = lshr i832 %r11, 384
%r15 = trunc i832 %r14 to i448
%r16 = bitcast i64* %r4 to i384*
%r17 = load i384, i384* %r16
%r18 = zext i384 %r17 to i448
%r19 = sub i448 %r15, %r18
%r20 = lshr i448 %r19, 384
%r21 = trunc i448 %r20 to i1
%r22 = select i1 %r21, i448 %r15, i448 %r19
%r23 = trunc i448 %r22 to i384
%r24 = getelementptr i64, i64* %r1, i32 6
%r25 = bitcast i64* %r24 to i384*
store i384 %r23, i384* %r25
ret void
}
define void @mcl_fpDbl_sub6L(i64* noalias %r1, i64* noalias %r2, i64* noalias %r3, i64* noalias %r4)
{
%r5 = bitcast i64* %r2 to i768*
%r6 = load i768, i768* %r5
%r7 = bitcast i64* %r3 to i768*
%r8 = load i768, i768* %r7
%r9 = zext i768 %r6 to i832
%r10 = zext i768 %r8 to i832
%r11 = sub i832 %r9, %r10
%r12 = trunc i832 %r11 to i384
%r13 = bitcast i64* %r1 to i384*
store i384 %r12, i384* %r13
%r14 = lshr i832 %r11, 384
%r15 = trunc i832 %r14 to i384
%r16 = lshr i832 %r11, 768
%r17 = trunc i832 %r16 to i1
%r18 = bitcast i64* %r4 to i384*
%r19 = load i384, i384* %r18
%r20 = select i1 %r17, i384 %r19, i384 0
%r21 = add i384 %r15, %r20
%r22 = getelementptr i64, i64* %r1, i32 6
%r23 = bitcast i64* %r22 to i384*
store i384 %r21, i384* %r23
ret void
}
define i576 @mulPv512x64(i64* noalias %r2, i64 %r3)
{
%r4 = call i128 @mulPos64x64(i64* %r2, i64 %r3, i64 0)
%r5 = trunc i128 %r4 to i64
%r6 = call i64 @extractHigh64(i128 %r4)
%r7 = call i128 @mulPos64x64(i64* %r2, i64 %r3, i64 1)
%r8 = trunc i128 %r7 to i64
%r9 = call i64 @extractHigh64(i128 %r7)
%r10 = call i128 @mulPos64x64(i64* %r2, i64 %r3, i64 2)
%r11 = trunc i128 %r10 to i64
%r12 = call i64 @extractHigh64(i128 %r10)
%r13 = call i128 @mulPos64x64(i64* %r2, i64 %r3, i64 3)
%r14 = trunc i128 %r13 to i64
%r15 = call i64 @extractHigh64(i128 %r13)
%r16 = call i128 @mulPos64x64(i64* %r2, i64 %r3, i64 4)
%r17 = trunc i128 %r16 to i64
%r18 = call i64 @extractHigh64(i128 %r16)
%r19 = call i128 @mulPos64x64(i64* %r2, i64 %r3, i64 5)
%r20 = trunc i128 %r19 to i64
%r21 = call i64 @extractHigh64(i128 %r19)
%r22 = call i128 @mulPos64x64(i64* %r2, i64 %r3, i64 6)
%r23 = trunc i128 %r22 to i64
%r24 = call i64 @extractHigh64(i128 %r22)
%r25 = call i128 @mulPos64x64(i64* %r2, i64 %r3, i64 7)
%r26 = trunc i128 %r25 to i64
%r27 = call i64 @extractHigh64(i128 %r25)
%r28 = zext i64 %r5 to i128
%r29 = zext i64 %r8 to i128
%r30 = shl i128 %r29, 64
%r31 = or i128 %r28, %r30
%r32 = zext i128 %r31 to i192
%r33 = zext i64 %r11 to i192
%r34 = shl i192 %r33, 128
%r35 = or i192 %r32, %r34
%r36 = zext i192 %r35 to i256
%r37 = zext i64 %r14 to i256
%r38 = shl i256 %r37, 192
%r39 = or i256 %r36, %r38
%r40 = zext i256 %r39 to i320
%r41 = zext i64 %r17 to i320
%r42 = shl i320 %r41, 256
%r43 = or i320 %r40, %r42
%r44 = zext i320 %r43 to i384
%r45 = zext i64 %r20 to i384
%r46 = shl i384 %r45, 320
%r47 = or i384 %r44, %r46
%r48 = zext i384 %r47 to i448
%r49 = zext i64 %r23 to i448
%r50 = shl i448 %r49, 384
%r51 = or i448 %r48, %r50
%r52 = zext i448 %r51 to i512
%r53 = zext i64 %r26 to i512
%r54 = shl i512 %r53, 448
%r55 = or i512 %r52, %r54
%r56 = zext i64 %r6 to i128
%r57 = zext i64 %r9 to i128
%r58 = shl i128 %r57, 64
%r59 = or i128 %r56, %r58
%r60 = zext i128 %r59 to i192
%r61 = zext i64 %r12 to i192
%r62 = shl i192 %r61, 128
%r63 = or i192 %r60, %r62
%r64 = zext i192 %r63 to i256
%r65 = zext i64 %r15 to i256
%r66 = shl i256 %r65, 192
%r67 = or i256 %r64, %r66
%r68 = zext i256 %r67 to i320
%r69 = zext i64 %r18 to i320
%r70 = shl i320 %r69, 256
%r71 = or i320 %r68, %r70
%r72 = zext i320 %r71 to i384
%r73 = zext i64 %r21 to i384
%r74 = shl i384 %r73, 320
%r75 = or i384 %r72, %r74
%r76 = zext i384 %r75 to i448
%r77 = zext i64 %r24 to i448
%r78 = shl i448 %r77, 384
%r79 = or i448 %r76, %r78
%r80 = zext i448 %r79 to i512
%r81 = zext i64 %r27 to i512
%r82 = shl i512 %r81, 448
%r83 = or i512 %r80, %r82
%r84 = zext i512 %r55 to i576
%r85 = zext i512 %r83 to i576
%r86 = shl i576 %r85, 64
%r87 = add i576 %r84, %r86
ret i576 %r87
}
define void @mcl_fp_mont8L(i64* %r1, i64* %r2, i64* %r3, i64* %r4)
{
%r5 = getelementptr i64, i64* %r4, i32 -1
%r6 = load i64, i64* %r5
%r7 = getelementptr i64, i64* %r3, i32 0
%r8 = load i64, i64* %r7
%r9 = call i576 @mulPv512x64(i64* %r2, i64 %r8)
%r10 = zext i576 %r9 to i640
%r11 = trunc i576 %r9 to i64
%r12 = mul i64 %r11, %r6
%r13 = call i576 @mulPv512x64(i64* %r4, i64 %r12)
%r14 = zext i576 %r13 to i640
%r15 = add i640 %r10, %r14
%r16 = lshr i640 %r15, 64
%r17 = getelementptr i64, i64* %r3, i32 1
%r18 = load i64, i64* %r17
%r19 = call i576 @mulPv512x64(i64* %r2, i64 %r18)
%r20 = zext i576 %r19 to i640
%r21 = add i640 %r16, %r20
%r22 = trunc i640 %r21 to i64
%r23 = mul i64 %r22, %r6
%r24 = call i576 @mulPv512x64(i64* %r4, i64 %r23)
%r25 = zext i576 %r24 to i640
%r26 = add i640 %r21, %r25
%r27 = lshr i640 %r26, 64
%r28 = getelementptr i64, i64* %r3, i32 2
%r29 = load i64, i64* %r28
%r30 = call i576 @mulPv512x64(i64* %r2, i64 %r29)
%r31 = zext i576 %r30 to i640
%r32 = add i640 %r27, %r31
%r33 = trunc i640 %r32 to i64
%r34 = mul i64 %r33, %r6
%r35 = call i576 @mulPv512x64(i64* %r4, i64 %r34)
%r36 = zext i576 %r35 to i640
%r37 = add i640 %r32, %r36
%r38 = lshr i640 %r37, 64
%r39 = getelementptr i64, i64* %r3, i32 3
%r40 = load i64, i64* %r39
%r41 = call i576 @mulPv512x64(i64* %r2, i64 %r40)
%r42 = zext i576 %r41 to i640
%r43 = add i640 %r38, %r42
%r44 = trunc i640 %r43 to i64
%r45 = mul i64 %r44, %r6
%r46 = call i576 @mulPv512x64(i64* %r4, i64 %r45)
%r47 = zext i576 %r46 to i640
%r48 = add i640 %r43, %r47
%r49 = lshr i640 %r48, 64
%r50 = getelementptr i64, i64* %r3, i32 4
%r51 = load i64, i64* %r50
%r52 = call i576 @mulPv512x64(i64* %r2, i64 %r51)
%r53 = zext i576 %r52 to i640
%r54 = add i640 %r49, %r53
%r55 = trunc i640 %r54 to i64
%r56 = mul i64 %r55, %r6
%r57 = call i576 @mulPv512x64(i64* %r4, i64 %r56)
%r58 = zext i576 %r57 to i640
%r59 = add i640 %r54, %r58
%r60 = lshr i640 %r59, 64
%r61 = getelementptr i64, i64* %r3, i32 5
%r62 = load i64, i64* %r61
%r63 = call i576 @mulPv512x64(i64* %r2, i64 %r62)
%r64 = zext i576 %r63 to i640
%r65 = add i640 %r60, %r64
%r66 = trunc i640 %r65 to i64
%r67 = mul i64 %r66, %r6
%r68 = call i576 @mulPv512x64(i64* %r4, i64 %r67)
%r69 = zext i576 %r68 to i640
%r70 = add i640 %r65, %r69
%r71 = lshr i640 %r70, 64
%r72 = getelementptr i64, i64* %r3, i32 6
%r73 = load i64, i64* %r72
%r74 = call i576 @mulPv512x64(i64* %r2, i64 %r73)
%r75 = zext i576 %r74 to i640
%r76 = add i640 %r71, %r75
%r77 = trunc i640 %r76 to i64
%r78 = mul i64 %r77, %r6
%r79 = call i576 @mulPv512x64(i64* %r4, i64 %r78)
%r80 = zext i576 %r79 to i640
%r81 = add i640 %r76, %r80
%r82 = lshr i640 %r81, 64
%r83 = getelementptr i64, i64* %r3, i32 7
%r84 = load i64, i64* %r83
%r85 = call i576 @mulPv512x64(i64* %r2, i64 %r84)
%r86 = zext i576 %r85 to i640
%r87 = add i640 %r82, %r86
%r88 = trunc i640 %r87 to i64
%r89 = mul i64 %r88, %r6
%r90 = call i576 @mulPv512x64(i64* %r4, i64 %r89)
%r91 = zext i576 %r90 to i640
%r92 = add i640 %r87, %r91
%r93 = lshr i640 %r92, 64
%r94 = trunc i640 %r93 to i576
%r95 = bitcast i64* %r4 to i512*
%r96 = load i512, i512* %r95
%r97 = zext i512 %r96 to i576
%r98 = sub i576 %r94, %r97
%r99 = lshr i576 %r98, 512
%r100 = trunc i576 %r99 to i1
%r101 = select i1 %r100, i576 %r94, i576 %r98
%r102 = trunc i576 %r101 to i512
%r103 = bitcast i64* %r1 to i512*
store i512 %r102, i512* %r103
ret void
}
define void @mcl_fp_montNF8L(i64* %r1, i64* %r2, i64* %r3, i64* %r4)
{
%r5 = getelementptr i64, i64* %r4, i32 -1
%r6 = load i64, i64* %r5
%r7 = load i64, i64* %r3
%r8 = call i576 @mulPv512x64(i64* %r2, i64 %r7)
%r9 = trunc i576 %r8 to i64
%r10 = mul i64 %r9, %r6
%r11 = call i576 @mulPv512x64(i64* %r4, i64 %r10)
%r12 = add i576 %r8, %r11
%r13 = lshr i576 %r12, 64
%r14 = getelementptr i64, i64* %r3, i32 1
%r15 = load i64, i64* %r14
%r16 = call i576 @mulPv512x64(i64* %r2, i64 %r15)
%r17 = add i576 %r13, %r16
%r18 = trunc i576 %r17 to i64
%r19 = mul i64 %r18, %r6
%r20 = call i576 @mulPv512x64(i64* %r4, i64 %r19)
%r21 = add i576 %r17, %r20
%r22 = lshr i576 %r21, 64
%r23 = getelementptr i64, i64* %r3, i32 2
%r24 = load i64, i64* %r23
%r25 = call i576 @mulPv512x64(i64* %r2, i64 %r24)
%r26 = add i576 %r22, %r25
%r27 = trunc i576 %r26 to i64
%r28 = mul i64 %r27, %r6
%r29 = call i576 @mulPv512x64(i64* %r4, i64 %r28)
%r30 = add i576 %r26, %r29
%r31 = lshr i576 %r30, 64
%r32 = getelementptr i64, i64* %r3, i32 3
%r33 = load i64, i64* %r32
%r34 = call i576 @mulPv512x64(i64* %r2, i64 %r33)
%r35 = add i576 %r31, %r34
%r36 = trunc i576 %r35 to i64
%r37 = mul i64 %r36, %r6
%r38 = call i576 @mulPv512x64(i64* %r4, i64 %r37)
%r39 = add i576 %r35, %r38
%r40 = lshr i576 %r39, 64
%r41 = getelementptr i64, i64* %r3, i32 4
%r42 = load i64, i64* %r41
%r43 = call i576 @mulPv512x64(i64* %r2, i64 %r42)
%r44 = add i576 %r40, %r43
%r45 = trunc i576 %r44 to i64
%r46 = mul i64 %r45, %r6
%r47 = call i576 @mulPv512x64(i64* %r4, i64 %r46)
%r48 = add i576 %r44, %r47
%r49 = lshr i576 %r48, 64
%r50 = getelementptr i64, i64* %r3, i32 5
%r51 = load i64, i64* %r50
%r52 = call i576 @mulPv512x64(i64* %r2, i64 %r51)
%r53 = add i576 %r49, %r52
%r54 = trunc i576 %r53 to i64
%r55 = mul i64 %r54, %r6
%r56 = call i576 @mulPv512x64(i64* %r4, i64 %r55)
%r57 = add i576 %r53, %r56
%r58 = lshr i576 %r57, 64
%r59 = getelementptr i64, i64* %r3, i32 6
%r60 = load i64, i64* %r59
%r61 = call i576 @mulPv512x64(i64* %r2, i64 %r60)
%r62 = add i576 %r58, %r61
%r63 = trunc i576 %r62 to i64
%r64 = mul i64 %r63, %r6
%r65 = call i576 @mulPv512x64(i64* %r4, i64 %r64)
%r66 = add i576 %r62, %r65
%r67 = lshr i576 %r66, 64
%r68 = getelementptr i64, i64* %r3, i32 7
%r69 = load i64, i64* %r68
%r70 = call i576 @mulPv512x64(i64* %r2, i64 %r69)
%r71 = add i576 %r67, %r70
%r72 = trunc i576 %r71 to i64
%r73 = mul i64 %r72, %r6
%r74 = call i576 @mulPv512x64(i64* %r4, i64 %r73)
%r75 = add i576 %r71, %r74
%r76 = lshr i576 %r75, 64
%r77 = trunc i576 %r76 to i512
%r78 = bitcast i64* %r4 to i512*
%r79 = load i512, i512* %r78
%r80 = sub i512 %r77, %r79
%r81 = lshr i512 %r80, 511
%r82 = trunc i512 %r81 to i1
%r83 = select i1 %r82, i512 %r77, i512 %r80
%r84 = bitcast i64* %r1 to i512*
store i512 %r83, i512* %r84
ret void
}
define void @mcl_fp_montRed8L(i64* noalias %r1, i64* noalias %r2, i64* noalias %r3)
{
%r4 = getelementptr i64, i64* %r3, i32 -1
%r5 = load i64, i64* %r4
%r6 = bitcast i64* %r3 to i512*
%r7 = load i512, i512* %r6
%r8 = bitcast i64* %r2 to i512*
%r9 = load i512, i512* %r8
%r10 = trunc i512 %r9 to i64
%r11 = mul i64 %r10, %r5
%r12 = call i576 @mulPv512x64(i64* %r3, i64 %r11)
%r13 = getelementptr i64, i64* %r2, i32 8
%r14 = load i64, i64* %r13
%r15 = zext i512 %r9 to i576
%r16 = zext i64 %r14 to i576
%r17 = shl i576 %r16, 512
%r18 = or i576 %r15, %r17
%r19 = zext i576 %r18 to i640
%r20 = zext i576 %r12 to i640
%r21 = add i640 %r19, %r20
%r22 = lshr i640 %r21, 64
%r23 = trunc i640 %r22 to i576
%r24 = lshr i576 %r23, 512
%r25 = trunc i576 %r24 to i64
%r26 = trunc i576 %r23 to i512
%r27 = trunc i512 %r26 to i64
%r28 = mul i64 %r27, %r5
%r29 = call i576 @mulPv512x64(i64* %r3, i64 %r28)
%r30 = zext i64 %r25 to i576
%r31 = shl i576 %r30, 512
%r32 = add i576 %r29, %r31
%r33 = getelementptr i64, i64* %r2, i32 9
%r34 = load i64, i64* %r33
%r35 = zext i512 %r26 to i576
%r36 = zext i64 %r34 to i576
%r37 = shl i576 %r36, 512
%r38 = or i576 %r35, %r37
%r39 = zext i576 %r38 to i640
%r40 = zext i576 %r32 to i640
%r41 = add i640 %r39, %r40
%r42 = lshr i640 %r41, 64
%r43 = trunc i640 %r42 to i576
%r44 = lshr i576 %r43, 512
%r45 = trunc i576 %r44 to i64
%r46 = trunc i576 %r43 to i512
%r47 = trunc i512 %r46 to i64
%r48 = mul i64 %r47, %r5
%r49 = call i576 @mulPv512x64(i64* %r3, i64 %r48)
%r50 = zext i64 %r45 to i576
%r51 = shl i576 %r50, 512
%r52 = add i576 %r49, %r51
%r53 = getelementptr i64, i64* %r2, i32 10
%r54 = load i64, i64* %r53
%r55 = zext i512 %r46 to i576
%r56 = zext i64 %r54 to i576
%r57 = shl i576 %r56, 512
%r58 = or i576 %r55, %r57
%r59 = zext i576 %r58 to i640
%r60 = zext i576 %r52 to i640
%r61 = add i640 %r59, %r60
%r62 = lshr i640 %r61, 64
%r63 = trunc i640 %r62 to i576
%r64 = lshr i576 %r63, 512
%r65 = trunc i576 %r64 to i64
%r66 = trunc i576 %r63 to i512
%r67 = trunc i512 %r66 to i64
%r68 = mul i64 %r67, %r5
%r69 = call i576 @mulPv512x64(i64* %r3, i64 %r68)
%r70 = zext i64 %r65 to i576
%r71 = shl i576 %r70, 512
%r72 = add i576 %r69, %r71
%r73 = getelementptr i64, i64* %r2, i32 11
%r74 = load i64, i64* %r73
%r75 = zext i512 %r66 to i576
%r76 = zext i64 %r74 to i576
%r77 = shl i576 %r76, 512
%r78 = or i576 %r75, %r77
%r79 = zext i576 %r78 to i640
%r80 = zext i576 %r72 to i640
%r81 = add i640 %r79, %r80
%r82 = lshr i640 %r81, 64
%r83 = trunc i640 %r82 to i576
%r84 = lshr i576 %r83, 512
%r85 = trunc i576 %r84 to i64
%r86 = trunc i576 %r83 to i512
%r87 = trunc i512 %r86 to i64
%r88 = mul i64 %r87, %r5
%r89 = call i576 @mulPv512x64(i64* %r3, i64 %r88)
%r90 = zext i64 %r85 to i576
%r91 = shl i576 %r90, 512
%r92 = add i576 %r89, %r91
%r93 = getelementptr i64, i64* %r2, i32 12
%r94 = load i64, i64* %r93
%r95 = zext i512 %r86 to i576
%r96 = zext i64 %r94 to i576
%r97 = shl i576 %r96, 512
%r98 = or i576 %r95, %r97
%r99 = zext i576 %r98 to i640
%r100 = zext i576 %r92 to i640
%r101 = add i640 %r99, %r100
%r102 = lshr i640 %r101, 64
%r103 = trunc i640 %r102 to i576
%r104 = lshr i576 %r103, 512
%r105 = trunc i576 %r104 to i64
%r106 = trunc i576 %r103 to i512
%r107 = trunc i512 %r106 to i64
%r108 = mul i64 %r107, %r5
%r109 = call i576 @mulPv512x64(i64* %r3, i64 %r108)
%r110 = zext i64 %r105 to i576
%r111 = shl i576 %r110, 512
%r112 = add i576 %r109, %r111
%r113 = getelementptr i64, i64* %r2, i32 13
%r114 = load i64, i64* %r113
%r115 = zext i512 %r106 to i576
%r116 = zext i64 %r114 to i576
%r117 = shl i576 %r116, 512
%r118 = or i576 %r115, %r117
%r119 = zext i576 %r118 to i640
%r120 = zext i576 %r112 to i640
%r121 = add i640 %r119, %r120
%r122 = lshr i640 %r121, 64
%r123 = trunc i640 %r122 to i576
%r124 = lshr i576 %r123, 512
%r125 = trunc i576 %r124 to i64
%r126 = trunc i576 %r123 to i512
%r127 = trunc i512 %r126 to i64
%r128 = mul i64 %r127, %r5
%r129 = call i576 @mulPv512x64(i64* %r3, i64 %r128)
%r130 = zext i64 %r125 to i576
%r131 = shl i576 %r130, 512
%r132 = add i576 %r129, %r131
%r133 = getelementptr i64, i64* %r2, i32 14
%r134 = load i64, i64* %r133
%r135 = zext i512 %r126 to i576
%r136 = zext i64 %r134 to i576
%r137 = shl i576 %r136, 512
%r138 = or i576 %r135, %r137
%r139 = zext i576 %r138 to i640
%r140 = zext i576 %r132 to i640
%r141 = add i640 %r139, %r140
%r142 = lshr i640 %r141, 64
%r143 = trunc i640 %r142 to i576
%r144 = lshr i576 %r143, 512
%r145 = trunc i576 %r144 to i64
%r146 = trunc i576 %r143 to i512
%r147 = trunc i512 %r146 to i64
%r148 = mul i64 %r147, %r5
%r149 = call i576 @mulPv512x64(i64* %r3, i64 %r148)
%r150 = zext i64 %r145 to i576
%r151 = shl i576 %r150, 512
%r152 = add i576 %r149, %r151
%r153 = getelementptr i64, i64* %r2, i32 15
%r154 = load i64, i64* %r153
%r155 = zext i512 %r146 to i576
%r156 = zext i64 %r154 to i576
%r157 = shl i576 %r156, 512
%r158 = or i576 %r155, %r157
%r159 = zext i576 %r158 to i640
%r160 = zext i576 %r152 to i640
%r161 = add i640 %r159, %r160
%r162 = lshr i640 %r161, 64
%r163 = trunc i640 %r162 to i576
%r164 = lshr i576 %r163, 512
%r165 = trunc i576 %r164 to i64
%r166 = trunc i576 %r163 to i512
%r167 = zext i512 %r7 to i576
%r168 = zext i512 %r166 to i576
%r169 = zext i64 %r165 to i576
%r170 = shl i576 %r169, 512
%r171 = or i576 %r168, %r170
%r172 = sub i576 %r171, %r167
%r173 = lshr i576 %r172, 512
%r174 = trunc i576 %r173 to i1
%r175 = select i1 %r174, i576 %r171, i576 %r172
%r176 = trunc i576 %r175 to i512
%r177 = bitcast i64* %r1 to i512*
store i512 %r176, i512* %r177
ret void
}
define void @mcl_fp_montRedNF8L(i64* noalias %r1, i64* noalias %r2, i64* noalias %r3)
{
%r4 = getelementptr i64, i64* %r3, i32 -1
%r5 = load i64, i64* %r4
%r6 = bitcast i64* %r3 to i512*
%r7 = load i512, i512* %r6
%r8 = bitcast i64* %r2 to i512*
%r9 = load i512, i512* %r8
%r10 = trunc i512 %r9 to i64
%r11 = mul i64 %r10, %r5
%r12 = call i576 @mulPv512x64(i64* %r3, i64 %r11)
%r13 = getelementptr i64, i64* %r2, i32 8
%r14 = load i64, i64* %r13
%r15 = zext i512 %r9 to i576
%r16 = zext i64 %r14 to i576
%r17 = shl i576 %r16, 512
%r18 = or i576 %r15, %r17
%r19 = zext i576 %r18 to i640
%r20 = zext i576 %r12 to i640
%r21 = add i640 %r19, %r20
%r22 = lshr i640 %r21, 64
%r23 = trunc i640 %r22 to i576
%r24 = lshr i576 %r23, 512
%r25 = trunc i576 %r24 to i64
%r26 = trunc i576 %r23 to i512
%r27 = trunc i512 %r26 to i64
%r28 = mul i64 %r27, %r5
%r29 = call i576 @mulPv512x64(i64* %r3, i64 %r28)
%r30 = zext i64 %r25 to i576
%r31 = shl i576 %r30, 512
%r32 = add i576 %r29, %r31
%r33 = getelementptr i64, i64* %r2, i32 9
%r34 = load i64, i64* %r33
%r35 = zext i512 %r26 to i576
%r36 = zext i64 %r34 to i576
%r37 = shl i576 %r36, 512
%r38 = or i576 %r35, %r37
%r39 = zext i576 %r38 to i640
%r40 = zext i576 %r32 to i640
%r41 = add i640 %r39, %r40
%r42 = lshr i640 %r41, 64
%r43 = trunc i640 %r42 to i576
%r44 = lshr i576 %r43, 512
%r45 = trunc i576 %r44 to i64
%r46 = trunc i576 %r43 to i512
%r47 = trunc i512 %r46 to i64
%r48 = mul i64 %r47, %r5
%r49 = call i576 @mulPv512x64(i64* %r3, i64 %r48)
%r50 = zext i64 %r45 to i576
%r51 = shl i576 %r50, 512
%r52 = add i576 %r49, %r51
%r53 = getelementptr i64, i64* %r2, i32 10
%r54 = load i64, i64* %r53
%r55 = zext i512 %r46 to i576
%r56 = zext i64 %r54 to i576
%r57 = shl i576 %r56, 512
%r58 = or i576 %r55, %r57
%r59 = zext i576 %r58 to i640
%r60 = zext i576 %r52 to i640
%r61 = add i640 %r59, %r60
%r62 = lshr i640 %r61, 64
%r63 = trunc i640 %r62 to i576
%r64 = lshr i576 %r63, 512
%r65 = trunc i576 %r64 to i64
%r66 = trunc i576 %r63 to i512
%r67 = trunc i512 %r66 to i64
%r68 = mul i64 %r67, %r5
%r69 = call i576 @mulPv512x64(i64* %r3, i64 %r68)
%r70 = zext i64 %r65 to i576
%r71 = shl i576 %r70, 512
%r72 = add i576 %r69, %r71
%r73 = getelementptr i64, i64* %r2, i32 11
%r74 = load i64, i64* %r73
%r75 = zext i512 %r66 to i576
%r76 = zext i64 %r74 to i576
%r77 = shl i576 %r76, 512
%r78 = or i576 %r75, %r77
%r79 = zext i576 %r78 to i640
%r80 = zext i576 %r72 to i640
%r81 = add i640 %r79, %r80
%r82 = lshr i640 %r81, 64
%r83 = trunc i640 %r82 to i576
%r84 = lshr i576 %r83, 512
%r85 = trunc i576 %r84 to i64
%r86 = trunc i576 %r83 to i512
%r87 = trunc i512 %r86 to i64
%r88 = mul i64 %r87, %r5
%r89 = call i576 @mulPv512x64(i64* %r3, i64 %r88)
%r90 = zext i64 %r85 to i576
%r91 = shl i576 %r90, 512
%r92 = add i576 %r89, %r91
%r93 = getelementptr i64, i64* %r2, i32 12
%r94 = load i64, i64* %r93
%r95 = zext i512 %r86 to i576
%r96 = zext i64 %r94 to i576
%r97 = shl i576 %r96, 512
%r98 = or i576 %r95, %r97
%r99 = zext i576 %r98 to i640
%r100 = zext i576 %r92 to i640
%r101 = add i640 %r99, %r100
%r102 = lshr i640 %r101, 64
%r103 = trunc i640 %r102 to i576
%r104 = lshr i576 %r103, 512
%r105 = trunc i576 %r104 to i64
%r106 = trunc i576 %r103 to i512
%r107 = trunc i512 %r106 to i64
%r108 = mul i64 %r107, %r5
%r109 = call i576 @mulPv512x64(i64* %r3, i64 %r108)
%r110 = zext i64 %r105 to i576
%r111 = shl i576 %r110, 512
%r112 = add i576 %r109, %r111
%r113 = getelementptr i64, i64* %r2, i32 13
%r114 = load i64, i64* %r113
%r115 = zext i512 %r106 to i576
%r116 = zext i64 %r114 to i576
%r117 = shl i576 %r116, 512
%r118 = or i576 %r115, %r117
%r119 = zext i576 %r118 to i640
%r120 = zext i576 %r112 to i640
%r121 = add i640 %r119, %r120
%r122 = lshr i640 %r121, 64
%r123 = trunc i640 %r122 to i576
%r124 = lshr i576 %r123, 512
%r125 = trunc i576 %r124 to i64
%r126 = trunc i576 %r123 to i512
%r127 = trunc i512 %r126 to i64
%r128 = mul i64 %r127, %r5
%r129 = call i576 @mulPv512x64(i64* %r3, i64 %r128)
%r130 = zext i64 %r125 to i576
%r131 = shl i576 %r130, 512
%r132 = add i576 %r129, %r131
%r133 = getelementptr i64, i64* %r2, i32 14
%r134 = load i64, i64* %r133
%r135 = zext i512 %r126 to i576
%r136 = zext i64 %r134 to i576
%r137 = shl i576 %r136, 512
%r138 = or i576 %r135, %r137
%r139 = zext i576 %r138 to i640
%r140 = zext i576 %r132 to i640
%r141 = add i640 %r139, %r140
%r142 = lshr i640 %r141, 64
%r143 = trunc i640 %r142 to i576
%r144 = lshr i576 %r143, 512
%r145 = trunc i576 %r144 to i64
%r146 = trunc i576 %r143 to i512
%r147 = trunc i512 %r146 to i64
%r148 = mul i64 %r147, %r5
%r149 = call i576 @mulPv512x64(i64* %r3, i64 %r148)
%r150 = zext i64 %r145 to i576
%r151 = shl i576 %r150, 512
%r152 = add i576 %r149, %r151
%r153 = getelementptr i64, i64* %r2, i32 15
%r154 = load i64, i64* %r153
%r155 = zext i512 %r146 to i576
%r156 = zext i64 %r154 to i576
%r157 = shl i576 %r156, 512
%r158 = or i576 %r155, %r157
%r159 = zext i576 %r158 to i640
%r160 = zext i576 %r152 to i640
%r161 = add i640 %r159, %r160
%r162 = lshr i640 %r161, 64
%r163 = trunc i640 %r162 to i576
%r164 = lshr i576 %r163, 512
%r165 = trunc i576 %r164 to i64
%r166 = trunc i576 %r163 to i512
%r167 = sub i512 %r166, %r7
%r168 = lshr i512 %r167, 511
%r169 = trunc i512 %r168 to i1
%r170 = select i1 %r169, i512 %r166, i512 %r167
%r171 = bitcast i64* %r1 to i512*
store i512 %r170, i512* %r171
ret void
}
define i64 @mcl_fp_addPre8L(i64* noalias %r1, i64* noalias %r2, i64* noalias %r3)
{
%r5 = bitcast i64* %r2 to i512*
%r6 = load i512, i512* %r5
%r7 = zext i512 %r6 to i576
%r8 = bitcast i64* %r3 to i512*
%r9 = load i512, i512* %r8
%r10 = zext i512 %r9 to i576
%r11 = add i576 %r7, %r10
%r12 = trunc i576 %r11 to i512
%r13 = bitcast i64* %r1 to i512*
store i512 %r12, i512* %r13
%r14 = lshr i576 %r11, 512
%r15 = trunc i576 %r14 to i64
ret i64 %r15
}
define i64 @mcl_fp_subPre8L(i64* noalias %r1, i64* noalias %r2, i64* noalias %r3)
{
%r5 = bitcast i64* %r2 to i512*
%r6 = load i512, i512* %r5
%r7 = zext i512 %r6 to i576
%r8 = bitcast i64* %r3 to i512*
%r9 = load i512, i512* %r8
%r10 = zext i512 %r9 to i576
%r11 = sub i576 %r7, %r10
%r12 = trunc i576 %r11 to i512
%r13 = bitcast i64* %r1 to i512*
store i512 %r12, i512* %r13
%r14 = lshr i576 %r11, 512
%r15 = trunc i576 %r14 to i64
%r16 = and i64 %r15, 1
ret i64 %r16
}
define void @mcl_fp_shr1_8L(i64* noalias %r1, i64* noalias %r2)
{
%r3 = bitcast i64* %r2 to i512*
%r4 = load i512, i512* %r3
%r5 = lshr i512 %r4, 1
%r6 = bitcast i64* %r1 to i512*
store i512 %r5, i512* %r6
ret void
}
define void @mcl_fp_add8L(i64* noalias %r1, i64* noalias %r2, i64* noalias %r3, i64* noalias %r4)
{
%r5 = bitcast i64* %r2 to i512*
%r6 = load i512, i512* %r5
%r7 = bitcast i64* %r3 to i512*
%r8 = load i512, i512* %r7
%r9 = bitcast i64* %r4 to i512*
%r10 = load i512, i512* %r9
%r11 = zext i512 %r6 to i576
%r12 = zext i512 %r8 to i576
%r13 = add i576 %r11, %r12
%r14 = zext i512 %r10 to i576
%r15 = sub i576 %r13, %r14
%r16 = lshr i576 %r15, 512
%r17 = trunc i576 %r16 to i1
%r18 = select i1 %r17, i576 %r13, i576 %r15
%r19 = trunc i576 %r18 to i512
%r20 = bitcast i64* %r1 to i512*
store i512 %r19, i512* %r20
ret void
}
define void @mcl_fp_addNF8L(i64* noalias %r1, i64* noalias %r2, i64* noalias %r3, i64* noalias %r4)
{
%r5 = bitcast i64* %r2 to i512*
%r6 = load i512, i512* %r5
%r7 = bitcast i64* %r3 to i512*
%r8 = load i512, i512* %r7
%r9 = bitcast i64* %r4 to i512*
%r10 = load i512, i512* %r9
%r11 = add i512 %r6, %r8
%r12 = sub i512 %r11, %r10
%r13 = lshr i512 %r12, 511
%r14 = trunc i512 %r13 to i1
%r15 = select i1 %r14, i512 %r11, i512 %r12
%r16 = bitcast i64* %r1 to i512*
store i512 %r15, i512* %r16
ret void
}
define void @mcl_fp_sub8L(i64* noalias %r1, i64* noalias %r2, i64* noalias %r3, i64* noalias %r4)
{
%r5 = bitcast i64* %r2 to i512*
%r6 = load i512, i512* %r5
%r7 = bitcast i64* %r3 to i512*
%r8 = load i512, i512* %r7
%r9 = zext i512 %r6 to i576
%r10 = zext i512 %r8 to i576
%r11 = sub i576 %r9, %r10
%r12 = lshr i576 %r11, 512
%r13 = trunc i576 %r12 to i1
%r14 = trunc i576 %r11 to i512
%r15 = bitcast i64* %r4 to i512*
%r16 = load i512, i512* %r15
%r17 = select i1 %r13, i512 %r16, i512 0
%r18 = add i512 %r14, %r17
%r19 = bitcast i64* %r1 to i512*
store i512 %r18, i512* %r19
ret void
}
define void @mcl_fp_subNF8L(i64* noalias %r1, i64* noalias %r2, i64* noalias %r3, i64* noalias %r4)
{
%r5 = bitcast i64* %r2 to i512*
%r6 = load i512, i512* %r5
%r7 = bitcast i64* %r3 to i512*
%r8 = load i512, i512* %r7
%r9 = sub i512 %r6, %r8
%r10 = lshr i512 %r9, 511
%r11 = trunc i512 %r10 to i1
%r12 = bitcast i64* %r4 to i512*
%r13 = load i512, i512* %r12
%r14 = select i1 %r11, i512 %r13, i512 0
%r15 = add i512 %r9, %r14
%r16 = bitcast i64* %r1 to i512*
store i512 %r15, i512* %r16
ret void
}
define void @mcl_fpDbl_add8L(i64* noalias %r1, i64* noalias %r2, i64* noalias %r3, i64* noalias %r4)
{
%r5 = bitcast i64* %r2 to i1024*
%r6 = load i1024, i1024* %r5
%r7 = bitcast i64* %r3 to i1024*
%r8 = load i1024, i1024* %r7
%r9 = zext i1024 %r6 to i1088
%r10 = zext i1024 %r8 to i1088
%r11 = add i1088 %r9, %r10
%r12 = trunc i1088 %r11 to i512
%r13 = bitcast i64* %r1 to i512*
store i512 %r12, i512* %r13
%r14 = lshr i1088 %r11, 512
%r15 = trunc i1088 %r14 to i576
%r16 = bitcast i64* %r4 to i512*
%r17 = load i512, i512* %r16
%r18 = zext i512 %r17 to i576
%r19 = sub i576 %r15, %r18
%r20 = lshr i576 %r19, 512
%r21 = trunc i576 %r20 to i1
%r22 = select i1 %r21, i576 %r15, i576 %r19
%r23 = trunc i576 %r22 to i512
%r24 = getelementptr i64, i64* %r1, i32 8
%r25 = bitcast i64* %r24 to i512*
store i512 %r23, i512* %r25
ret void
}
define void @mcl_fpDbl_sub8L(i64* noalias %r1, i64* noalias %r2, i64* noalias %r3, i64* noalias %r4)
{
%r5 = bitcast i64* %r2 to i1024*
%r6 = load i1024, i1024* %r5
%r7 = bitcast i64* %r3 to i1024*
%r8 = load i1024, i1024* %r7
%r9 = zext i1024 %r6 to i1088
%r10 = zext i1024 %r8 to i1088
%r11 = sub i1088 %r9, %r10
%r12 = trunc i1088 %r11 to i512
%r13 = bitcast i64* %r1 to i512*
store i512 %r12, i512* %r13
%r14 = lshr i1088 %r11, 512
%r15 = trunc i1088 %r14 to i512
%r16 = lshr i1088 %r11, 1024
%r17 = trunc i1088 %r16 to i1
%r18 = bitcast i64* %r4 to i512*
%r19 = load i512, i512* %r18
%r20 = select i1 %r17, i512 %r19, i512 0
%r21 = add i512 %r15, %r20
%r22 = getelementptr i64, i64* %r1, i32 8
%r23 = bitcast i64* %r22 to i512*
store i512 %r21, i512* %r23
ret void
}
define i32 @mclb_modp256(i64* noalias %r1, i64* noalias %r2, i64 %r3, i64* noalias readonly %r4)
{
%r6 = icmp ugt i64 %r3, 8
br i1 %r6, label %L3, label %L4
L3:
ret i32 0
L4:
%r7 = icmp ult i64 %r3, 4
br i1 %r7, label %L11, label %L5
L5:
%r8 = bitcast i64* %r4 to i128*
%r9 = load i128, i128* %r8
%r10 = getelementptr i64, i64* %r4, i32 2
%r11 = bitcast i64* %r10 to i256*
%r12 = load i256, i256* %r11
%r13 = zext i256 %r12 to i320
%r14 = sub i64 %r3, 3
%r15 = getelementptr i64, i64* %r2, i64 %r14
%r16 = bitcast i64* %r15 to i192*
%r17 = load i192, i192* %r16
%r18 = sub i64 %r3, 4
%r19 = getelementptr i64, i64* %r2, i64 %r18
%r20 = load i64, i64* %r19
%r21 = zext i64 %r20 to i256
%r22 = zext i192 %r17 to i256
%r23 = shl i256 %r22, 64
%r24 = or i256 %r21, %r23
%r25 = zext i256 %r24 to i320
%r26 = lshr i320 %r25, 192
%r27 = trunc i320 %r26 to i128
%r28 = zext i128 %r27 to i256
%r29 = zext i128 %r9 to i256
%r30 = mul i256 %r28, %r29
%r31 = lshr i256 %r30, 129
%r32 = trunc i256 %r31 to i64
%r33 = call i320 @mulPv256x64(i64* %r10, i64 %r32)
%r34 = add i320 %r25, %r33
%r35 = zext i64 %r32 to i320
%r36 = shl i320 %r35, 256
%r37 = sub i320 %r34, %r36
%r38 = add i320 %r37, %r13
%r39 = lshr i320 %r38, 256
%r40 = trunc i320 %r39 to i1
%r41 = trunc i320 %r38 to i256
%r42 = trunc i320 %r37 to i256
%r43 = select i1 %r40, i256 %r41, i256 %r42
%r44 = icmp eq i64 %r3, 4
br i1 %r44, label %L10, label %L6
L6:
%r45 = getelementptr i64, i64* %r19, i64 -1
%r46 = load i64, i64* %r45
%r47 = zext i64 %r46 to i320
%r48 = zext i256 %r43 to i320
%r49 = shl i320 %r48, 64
%r50 = or i320 %r47, %r49
%r51 = lshr i320 %r50, 192
%r52 = trunc i320 %r51 to i128
%r53 = zext i128 %r52 to i256
%r54 = zext i128 %r9 to i256
%r55 = mul i256 %r53, %r54
%r56 = lshr i256 %r55, 129
%r57 = trunc i256 %r56 to i64
%r58 = call i320 @mulPv256x64(i64* %r10, i64 %r57)
%r59 = add i320 %r50, %r58
%r60 = zext i64 %r57 to i320
%r61 = shl i320 %r60, 256
%r62 = sub i320 %r59, %r61
%r63 = add i320 %r62, %r13
%r64 = lshr i320 %r63, 256
%r65 = trunc i320 %r64 to i1
%r66 = trunc i320 %r63 to i256
%r67 = trunc i320 %r62 to i256
%r68 = select i1 %r65, i256 %r66, i256 %r67
%r69 = icmp eq i64 %r3, 5
br i1 %r69, label %L10, label %L7
L7:
%r70 = getelementptr i64, i64* %r45, i64 -1
%r71 = load i64, i64* %r70
%r72 = zext i64 %r71 to i320
%r73 = zext i256 %r68 to i320
%r74 = shl i320 %r73, 64
%r75 = or i320 %r72, %r74
%r76 = lshr i320 %r75, 192
%r77 = trunc i320 %r76 to i128
%r78 = zext i128 %r77 to i256
%r79 = zext i128 %r9 to i256
%r80 = mul i256 %r78, %r79
%r81 = lshr i256 %r80, 129
%r82 = trunc i256 %r81 to i64
%r83 = call i320 @mulPv256x64(i64* %r10, i64 %r82)
%r84 = add i320 %r75, %r83
%r85 = zext i64 %r82 to i320
%r86 = shl i320 %r85, 256
%r87 = sub i320 %r84, %r86
%r88 = add i320 %r87, %r13
%r89 = lshr i320 %r88, 256
%r90 = trunc i320 %r89 to i1
%r91 = trunc i320 %r88 to i256
%r92 = trunc i320 %r87 to i256
%r93 = select i1 %r90, i256 %r91, i256 %r92
%r94 = icmp eq i64 %r3, 6
br i1 %r94, label %L10, label %L8
L8:
%r95 = getelementptr i64, i64* %r70, i64 -1
%r96 = load i64, i64* %r95
%r97 = zext i64 %r96 to i320
%r98 = zext i256 %r93 to i320
%r99 = shl i320 %r98, 64
%r100 = or i320 %r97, %r99
%r101 = lshr i320 %r100, 192
%r102 = trunc i320 %r101 to i128
%r103 = zext i128 %r102 to i256
%r104 = zext i128 %r9 to i256
%r105 = mul i256 %r103, %r104
%r106 = lshr i256 %r105, 129
%r107 = trunc i256 %r106 to i64
%r108 = call i320 @mulPv256x64(i64* %r10, i64 %r107)
%r109 = add i320 %r100, %r108
%r110 = zext i64 %r107 to i320
%r111 = shl i320 %r110, 256
%r112 = sub i320 %r109, %r111
%r113 = add i320 %r112, %r13
%r114 = lshr i320 %r113, 256
%r115 = trunc i320 %r114 to i1
%r116 = trunc i320 %r113 to i256
%r117 = trunc i320 %r112 to i256
%r118 = select i1 %r115, i256 %r116, i256 %r117
%r119 = icmp eq i64 %r3, 7
br i1 %r119, label %L10, label %L9
L9:
%r120 = getelementptr i64, i64* %r95, i64 -1
%r121 = load i64, i64* %r120
%r122 = zext i64 %r121 to i320
%r123 = zext i256 %r118 to i320
%r124 = shl i320 %r123, 64
%r125 = or i320 %r122, %r124
%r126 = lshr i320 %r125, 192
%r127 = trunc i320 %r126 to i128
%r128 = zext i128 %r127 to i256
%r129 = zext i128 %r9 to i256
%r130 = mul i256 %r128, %r129
%r131 = lshr i256 %r130, 129
%r132 = trunc i256 %r131 to i64
%r133 = call i320 @mulPv256x64(i64* %r10, i64 %r132)
%r134 = add i320 %r125, %r133
%r135 = zext i64 %r132 to i320
%r136 = shl i320 %r135, 256
%r137 = sub i320 %r134, %r136
%r138 = add i320 %r137, %r13
%r139 = lshr i320 %r138, 256
%r140 = trunc i320 %r139 to i1
%r141 = trunc i320 %r138 to i256
%r142 = trunc i320 %r137 to i256
%r143 = select i1 %r140, i256 %r141, i256 %r142
br label %L10
L10:
%r144 = phi i256[%r43, %L5], [%r68, %L6], [%r93, %L7], [%r118, %L8], [%r143, %L9]
%r145 = bitcast i64* %r1 to i256*
store i256 %r144, i256* %r145
ret i32 1
L11:
%r146 = icmp eq i64 %r3, 0
br i1 %r146, label %L15, label %L12
L12:
%r147 = getelementptr i64, i64* %r2, i32 0
%r148 = load i64, i64* %r147
%r149 = getelementptr i64, i64* %r1, i32 0
store i64 %r148, i64* %r149
%r150 = icmp eq i64 %r3, 1
br i1 %r150, label %L16, label %L13
L13:
%r151 = getelementptr i64, i64* %r2, i32 1
%r152 = load i64, i64* %r151
%r153 = getelementptr i64, i64* %r1, i32 1
store i64 %r152, i64* %r153
%r154 = icmp eq i64 %r3, 2
br i1 %r154, label %L17, label %L14
L14:
%r155 = getelementptr i64, i64* %r2, i32 2
%r156 = load i64, i64* %r155
%r157 = getelementptr i64, i64* %r1, i32 2
store i64 %r156, i64* %r157
br label %L18
L15:
%r158 = getelementptr i64, i64* %r1, i32 0
store i64 0, i64* %r158
br label %L16
L16:
%r159 = getelementptr i64, i64* %r1, i32 1
store i64 0, i64* %r159
br label %L17
L17:
%r160 = getelementptr i64, i64* %r1, i32 2
store i64 0, i64* %r160
br label %L18
L18:
%r161 = getelementptr i64, i64* %r1, i32 3
store i64 0, i64* %r161
ret i32 1
}
define i32 @mclb_modp384(i64* noalias %r1, i64* noalias %r2, i64 %r3, i64* noalias readonly %r4)
{
%r6 = icmp ugt i64 %r3, 8
br i1 %r6, label %L19, label %L20
L19:
ret i32 0
L20:
%r7 = icmp ult i64 %r3, 6
br i1 %r7, label %L25, label %L21
L21:
%r8 = bitcast i64* %r4 to i128*
%r9 = load i128, i128* %r8
%r10 = getelementptr i64, i64* %r4, i32 2
%r11 = bitcast i64* %r10 to i384*
%r12 = load i384, i384* %r11
%r13 = zext i384 %r12 to i448
%r14 = sub i64 %r3, 5
%r15 = getelementptr i64, i64* %r2, i64 %r14
%r16 = bitcast i64* %r15 to i320*
%r17 = load i320, i320* %r16
%r18 = sub i64 %r3, 6
%r19 = getelementptr i64, i64* %r2, i64 %r18
%r20 = load i64, i64* %r19
%r21 = zext i64 %r20 to i384
%r22 = zext i320 %r17 to i384
%r23 = shl i384 %r22, 64
%r24 = or i384 %r21, %r23
%r25 = zext i384 %r24 to i448
%r26 = lshr i448 %r25, 320
%r27 = trunc i448 %r26 to i128
%r28 = zext i128 %r27 to i256
%r29 = zext i128 %r9 to i256
%r30 = mul i256 %r28, %r29
%r31 = lshr i256 %r30, 129
%r32 = trunc i256 %r31 to i64
%r33 = call i448 @mulPv384x64(i64* %r10, i64 %r32)
%r34 = add i448 %r25, %r33
%r35 = zext i64 %r32 to i448
%r36 = shl i448 %r35, 384
%r37 = sub i448 %r34, %r36
%r38 = add i448 %r37, %r13
%r39 = lshr i448 %r38, 384
%r40 = trunc i448 %r39 to i1
%r41 = trunc i448 %r38 to i384
%r42 = trunc i448 %r37 to i384
%r43 = select i1 %r40, i384 %r41, i384 %r42
%r44 = icmp eq i64 %r3, 6
br i1 %r44, label %L24, label %L22
L22:
%r45 = getelementptr i64, i64* %r19, i64 -1
%r46 = load i64, i64* %r45
%r47 = zext i64 %r46 to i448
%r48 = zext i384 %r43 to i448
%r49 = shl i448 %r48, 64
%r50 = or i448 %r47, %r49
%r51 = lshr i448 %r50, 320
%r52 = trunc i448 %r51 to i128
%r53 = zext i128 %r52 to i256
%r54 = zext i128 %r9 to i256
%r55 = mul i256 %r53, %r54
%r56 = lshr i256 %r55, 129
%r57 = trunc i256 %r56 to i64
%r58 = call i448 @mulPv384x64(i64* %r10, i64 %r57)
%r59 = add i448 %r50, %r58
%r60 = zext i64 %r57 to i448
%r61 = shl i448 %r60, 384
%r62 = sub i448 %r59, %r61
%r63 = add i448 %r62, %r13
%r64 = lshr i448 %r63, 384
%r65 = trunc i448 %r64 to i1
%r66 = trunc i448 %r63 to i384
%r67 = trunc i448 %r62 to i384
%r68 = select i1 %r65, i384 %r66, i384 %r67
%r69 = icmp eq i64 %r3, 7
br i1 %r69, label %L24, label %L23
L23:
%r70 = getelementptr i64, i64* %r45, i64 -1
%r71 = load i64, i64* %r70
%r72 = zext i64 %r71 to i448
%r73 = zext i384 %r68 to i448
%r74 = shl i448 %r73, 64
%r75 = or i448 %r72, %r74
%r76 = lshr i448 %r75, 320
%r77 = trunc i448 %r76 to i128
%r78 = zext i128 %r77 to i256
%r79 = zext i128 %r9 to i256
%r80 = mul i256 %r78, %r79
%r81 = lshr i256 %r80, 129
%r82 = trunc i256 %r81 to i64
%r83 = call i448 @mulPv384x64(i64* %r10, i64 %r82)
%r84 = add i448 %r75, %r83
%r85 = zext i64 %r82 to i448
%r86 = shl i448 %r85, 384
%r87 = sub i448 %r84, %r86
%r88 = add i448 %r87, %r13
%r89 = lshr i448 %r88, 384
%r90 = trunc i448 %r89 to i1
%r91 = trunc i448 %r88 to i384
%r92 = trunc i448 %r87 to i384
%r93 = select i1 %r90, i384 %r91, i384 %r92
br label %L24
L24:
%r94 = phi i384[%r43, %L21], [%r68, %L22], [%r93, %L23]
%r95 = bitcast i64* %r1 to i384*
store i384 %r94, i384* %r95
ret i32 1
L25:
%r96 = icmp eq i64 %r3, 0
br i1 %r96, label %L31, label %L26
L26:
%r97 = getelementptr i64, i64* %r2, i32 0
%r98 = load i64, i64* %r97
%r99 = getelementptr i64, i64* %r1, i32 0
store i64 %r98, i64* %r99
%r100 = icmp eq i64 %r3, 1
br i1 %r100, label %L32, label %L27
L27:
%r101 = getelementptr i64, i64* %r2, i32 1
%r102 = load i64, i64* %r101
%r103 = getelementptr i64, i64* %r1, i32 1
store i64 %r102, i64* %r103
%r104 = icmp eq i64 %r3, 2
br i1 %r104, label %L33, label %L28
L28:
%r105 = getelementptr i64, i64* %r2, i32 2
%r106 = load i64, i64* %r105
%r107 = getelementptr i64, i64* %r1, i32 2
store i64 %r106, i64* %r107
%r108 = icmp eq i64 %r3, 3
br i1 %r108, label %L34, label %L29
L29:
%r109 = getelementptr i64, i64* %r2, i32 3
%r110 = load i64, i64* %r109
%r111 = getelementptr i64, i64* %r1, i32 3
store i64 %r110, i64* %r111
%r112 = icmp eq i64 %r3, 4
br i1 %r112, label %L35, label %L30
L30:
%r113 = getelementptr i64, i64* %r2, i32 4
%r114 = load i64, i64* %r113
%r115 = getelementptr i64, i64* %r1, i32 4
store i64 %r114, i64* %r115
br label %L36
L31:
%r116 = getelementptr i64, i64* %r1, i32 0
store i64 0, i64* %r116
br label %L32
L32:
%r117 = getelementptr i64, i64* %r1, i32 1
store i64 0, i64* %r117
br label %L33
L33:
%r118 = getelementptr i64, i64* %r1, i32 2
store i64 0, i64* %r118
br label %L34
L34:
%r119 = getelementptr i64, i64* %r1, i32 3
store i64 0, i64* %r119
br label %L35
L35:
%r120 = getelementptr i64, i64* %r1, i32 4
store i64 0, i64* %r120
br label %L36
L36:
%r121 = getelementptr i64, i64* %r1, i32 5
store i64 0, i64* %r121
ret i32 1
}
