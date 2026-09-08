define private i64 @mul32x32L(i32 %r2, i32 %r3)
{
%r4 = zext i32 %r2 to i64
%r5 = zext i32 %r3 to i64
%r6 = mul i64 %r4, %r5
ret i64 %r6
}
define private i32 @extractHigh32(i64 %r2)
{
%r3 = lshr i64 %r2, 32
%r4 = trunc i64 %r3 to i32
ret i32 %r4
}
define private i64 @mulPos32x32(i32* noalias %r2, i32 %r3, i32 %r4)
{
%r5 = getelementptr i32, i32* %r2, i32 %r4
%r6 = load i32, i32* %r5
%r7 = call i64 @mul32x32L(i32 %r6, i32 %r3)
ret i64 %r7
}
declare void @mclb_mul6(i32*, i32*, i32*)
declare void @mclb_sqr6(i32*, i32*)
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
define void @mcl_fpDbl_mod_NIST_P192L(i32* noalias %r1, i32* noalias %r2, i32* noalias %r3)
{
%r4 = bitcast i32* %r2 to i192*
%r5 = load i192, i192* %r4
%r6 = zext i192 %r5 to i256
%r7 = getelementptr i32, i32* %r2, i32 6
%r8 = bitcast i32* %r7 to i192*
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
%r36 = bitcast i32* %r1 to i192*
store i192 %r35, i192* %r36
ret void
}
define void @mcl_fp_sqr_NIST_P192L(i32* noalias %r1, i32* noalias %r2, i32* noalias %r3)
{
%r4 = alloca i32, i32 12
call void @mclb_sqr6(i32* %r4, i32* %r2)
call void @mcl_fpDbl_mod_NIST_P192L(i32* %r1, i32* %r4, i32* %r4)
ret void
}
define void @mcl_fp_mulNIST_P192L(i32* noalias %r1, i32* noalias %r2, i32* noalias %r3, i32* noalias %r4)
{
%r5 = alloca i32, i32 12
call void @mclb_mul6(i32* %r5, i32* %r2, i32* %r3)
call void @mcl_fpDbl_mod_NIST_P192L(i32* %r1, i32* %r5, i32* %r5)
ret void
}
define void @mcl_fpDbl_mod_NIST_P521L(i32* noalias %r1, i32* noalias %r2, i32* noalias %r3)
{
%r4 = bitcast i32* %r2 to i1056*
%r5 = load i1056, i1056* %r4
%r6 = trunc i1056 %r5 to i521
%r7 = zext i521 %r6 to i544
%r8 = lshr i1056 %r5, 521
%r9 = trunc i1056 %r8 to i544
%r10 = add i544 %r7, %r9
%r11 = lshr i544 %r10, 521
%r12 = and i544 %r11, 1
%r13 = add i544 %r10, %r12
%r14 = trunc i544 %r13 to i521
%r15 = zext i521 %r14 to i544
%r16 = lshr i544 %r15, 512
%r17 = trunc i544 %r16 to i32
%r18 = or i32 %r17, -512
%r19 = lshr i544 %r15, 0
%r20 = trunc i544 %r19 to i32
%r21 = and i32 %r18, %r20
%r22 = lshr i544 %r15, 32
%r23 = trunc i544 %r22 to i32
%r24 = and i32 %r21, %r23
%r25 = lshr i544 %r15, 64
%r26 = trunc i544 %r25 to i32
%r27 = and i32 %r24, %r26
%r28 = lshr i544 %r15, 96
%r29 = trunc i544 %r28 to i32
%r30 = and i32 %r27, %r29
%r31 = lshr i544 %r15, 128
%r32 = trunc i544 %r31 to i32
%r33 = and i32 %r30, %r32
%r34 = lshr i544 %r15, 160
%r35 = trunc i544 %r34 to i32
%r36 = and i32 %r33, %r35
%r37 = lshr i544 %r15, 192
%r38 = trunc i544 %r37 to i32
%r39 = and i32 %r36, %r38
%r40 = lshr i544 %r15, 224
%r41 = trunc i544 %r40 to i32
%r42 = and i32 %r39, %r41
%r43 = lshr i544 %r15, 256
%r44 = trunc i544 %r43 to i32
%r45 = and i32 %r42, %r44
%r46 = lshr i544 %r15, 288
%r47 = trunc i544 %r46 to i32
%r48 = and i32 %r45, %r47
%r49 = lshr i544 %r15, 320
%r50 = trunc i544 %r49 to i32
%r51 = and i32 %r48, %r50
%r52 = lshr i544 %r15, 352
%r53 = trunc i544 %r52 to i32
%r54 = and i32 %r51, %r53
%r55 = lshr i544 %r15, 384
%r56 = trunc i544 %r55 to i32
%r57 = and i32 %r54, %r56
%r58 = lshr i544 %r15, 416
%r59 = trunc i544 %r58 to i32
%r60 = and i32 %r57, %r59
%r61 = lshr i544 %r15, 448
%r62 = trunc i544 %r61 to i32
%r63 = and i32 %r60, %r62
%r64 = lshr i544 %r15, 480
%r65 = trunc i544 %r64 to i32
%r66 = and i32 %r63, %r65
%r67 = icmp eq i32 %r66, -1
br i1 %r67, label %L1, label %L2
L1:
store i32 0, i32* %r1
%r68 = getelementptr i32, i32* %r1, i32 1
store i32 0, i32* %r68
%r69 = getelementptr i32, i32* %r1, i32 2
store i32 0, i32* %r69
%r70 = getelementptr i32, i32* %r1, i32 3
store i32 0, i32* %r70
%r71 = getelementptr i32, i32* %r1, i32 4
store i32 0, i32* %r71
%r72 = getelementptr i32, i32* %r1, i32 5
store i32 0, i32* %r72
%r73 = getelementptr i32, i32* %r1, i32 6
store i32 0, i32* %r73
%r74 = getelementptr i32, i32* %r1, i32 7
store i32 0, i32* %r74
%r75 = getelementptr i32, i32* %r1, i32 8
store i32 0, i32* %r75
%r76 = getelementptr i32, i32* %r1, i32 9
store i32 0, i32* %r76
%r77 = getelementptr i32, i32* %r1, i32 10
store i32 0, i32* %r77
%r78 = getelementptr i32, i32* %r1, i32 11
store i32 0, i32* %r78
%r79 = getelementptr i32, i32* %r1, i32 12
store i32 0, i32* %r79
%r80 = getelementptr i32, i32* %r1, i32 13
store i32 0, i32* %r80
%r81 = getelementptr i32, i32* %r1, i32 14
store i32 0, i32* %r81
%r82 = getelementptr i32, i32* %r1, i32 15
store i32 0, i32* %r82
%r83 = getelementptr i32, i32* %r1, i32 16
store i32 0, i32* %r83
ret void
L2:
%r84 = bitcast i32* %r1 to i544*
store i544 %r15, i544* %r84
ret void
}
define i224 @mulPv192x32(i32* noalias %r2, i32 %r3)
{
%r4 = call i64 @mulPos32x32(i32* %r2, i32 %r3, i32 0)
%r5 = trunc i64 %r4 to i32
%r6 = call i32 @extractHigh32(i64 %r4)
%r7 = call i64 @mulPos32x32(i32* %r2, i32 %r3, i32 1)
%r8 = trunc i64 %r7 to i32
%r9 = call i32 @extractHigh32(i64 %r7)
%r10 = call i64 @mulPos32x32(i32* %r2, i32 %r3, i32 2)
%r11 = trunc i64 %r10 to i32
%r12 = call i32 @extractHigh32(i64 %r10)
%r13 = call i64 @mulPos32x32(i32* %r2, i32 %r3, i32 3)
%r14 = trunc i64 %r13 to i32
%r15 = call i32 @extractHigh32(i64 %r13)
%r16 = call i64 @mulPos32x32(i32* %r2, i32 %r3, i32 4)
%r17 = trunc i64 %r16 to i32
%r18 = call i32 @extractHigh32(i64 %r16)
%r19 = call i64 @mulPos32x32(i32* %r2, i32 %r3, i32 5)
%r20 = trunc i64 %r19 to i32
%r21 = call i32 @extractHigh32(i64 %r19)
%r22 = zext i32 %r5 to i64
%r23 = zext i32 %r8 to i64
%r24 = shl i64 %r23, 32
%r25 = or i64 %r22, %r24
%r26 = zext i64 %r25 to i96
%r27 = zext i32 %r11 to i96
%r28 = shl i96 %r27, 64
%r29 = or i96 %r26, %r28
%r30 = zext i96 %r29 to i128
%r31 = zext i32 %r14 to i128
%r32 = shl i128 %r31, 96
%r33 = or i128 %r30, %r32
%r34 = zext i128 %r33 to i160
%r35 = zext i32 %r17 to i160
%r36 = shl i160 %r35, 128
%r37 = or i160 %r34, %r36
%r38 = zext i160 %r37 to i192
%r39 = zext i32 %r20 to i192
%r40 = shl i192 %r39, 160
%r41 = or i192 %r38, %r40
%r42 = zext i32 %r6 to i64
%r43 = zext i32 %r9 to i64
%r44 = shl i64 %r43, 32
%r45 = or i64 %r42, %r44
%r46 = zext i64 %r45 to i96
%r47 = zext i32 %r12 to i96
%r48 = shl i96 %r47, 64
%r49 = or i96 %r46, %r48
%r50 = zext i96 %r49 to i128
%r51 = zext i32 %r15 to i128
%r52 = shl i128 %r51, 96
%r53 = or i128 %r50, %r52
%r54 = zext i128 %r53 to i160
%r55 = zext i32 %r18 to i160
%r56 = shl i160 %r55, 128
%r57 = or i160 %r54, %r56
%r58 = zext i160 %r57 to i192
%r59 = zext i32 %r21 to i192
%r60 = shl i192 %r59, 160
%r61 = or i192 %r58, %r60
%r62 = zext i192 %r41 to i224
%r63 = zext i192 %r61 to i224
%r64 = shl i224 %r63, 32
%r65 = add i224 %r62, %r64
ret i224 %r65
}
define void @mcl_fp_mont6L(i32* %r1, i32* %r2, i32* %r3, i32* %r4)
{
%r5 = getelementptr i32, i32* %r4, i32 -1
%r6 = load i32, i32* %r5
%r7 = getelementptr i32, i32* %r3, i32 0
%r8 = load i32, i32* %r7
%r9 = call i224 @mulPv192x32(i32* %r2, i32 %r8)
%r10 = zext i224 %r9 to i256
%r11 = trunc i224 %r9 to i32
%r12 = mul i32 %r11, %r6
%r13 = call i224 @mulPv192x32(i32* %r4, i32 %r12)
%r14 = zext i224 %r13 to i256
%r15 = add i256 %r10, %r14
%r16 = lshr i256 %r15, 32
%r17 = getelementptr i32, i32* %r3, i32 1
%r18 = load i32, i32* %r17
%r19 = call i224 @mulPv192x32(i32* %r2, i32 %r18)
%r20 = zext i224 %r19 to i256
%r21 = add i256 %r16, %r20
%r22 = trunc i256 %r21 to i32
%r23 = mul i32 %r22, %r6
%r24 = call i224 @mulPv192x32(i32* %r4, i32 %r23)
%r25 = zext i224 %r24 to i256
%r26 = add i256 %r21, %r25
%r27 = lshr i256 %r26, 32
%r28 = getelementptr i32, i32* %r3, i32 2
%r29 = load i32, i32* %r28
%r30 = call i224 @mulPv192x32(i32* %r2, i32 %r29)
%r31 = zext i224 %r30 to i256
%r32 = add i256 %r27, %r31
%r33 = trunc i256 %r32 to i32
%r34 = mul i32 %r33, %r6
%r35 = call i224 @mulPv192x32(i32* %r4, i32 %r34)
%r36 = zext i224 %r35 to i256
%r37 = add i256 %r32, %r36
%r38 = lshr i256 %r37, 32
%r39 = getelementptr i32, i32* %r3, i32 3
%r40 = load i32, i32* %r39
%r41 = call i224 @mulPv192x32(i32* %r2, i32 %r40)
%r42 = zext i224 %r41 to i256
%r43 = add i256 %r38, %r42
%r44 = trunc i256 %r43 to i32
%r45 = mul i32 %r44, %r6
%r46 = call i224 @mulPv192x32(i32* %r4, i32 %r45)
%r47 = zext i224 %r46 to i256
%r48 = add i256 %r43, %r47
%r49 = lshr i256 %r48, 32
%r50 = getelementptr i32, i32* %r3, i32 4
%r51 = load i32, i32* %r50
%r52 = call i224 @mulPv192x32(i32* %r2, i32 %r51)
%r53 = zext i224 %r52 to i256
%r54 = add i256 %r49, %r53
%r55 = trunc i256 %r54 to i32
%r56 = mul i32 %r55, %r6
%r57 = call i224 @mulPv192x32(i32* %r4, i32 %r56)
%r58 = zext i224 %r57 to i256
%r59 = add i256 %r54, %r58
%r60 = lshr i256 %r59, 32
%r61 = getelementptr i32, i32* %r3, i32 5
%r62 = load i32, i32* %r61
%r63 = call i224 @mulPv192x32(i32* %r2, i32 %r62)
%r64 = zext i224 %r63 to i256
%r65 = add i256 %r60, %r64
%r66 = trunc i256 %r65 to i32
%r67 = mul i32 %r66, %r6
%r68 = call i224 @mulPv192x32(i32* %r4, i32 %r67)
%r69 = zext i224 %r68 to i256
%r70 = add i256 %r65, %r69
%r71 = lshr i256 %r70, 32
%r72 = trunc i256 %r71 to i224
%r73 = bitcast i32* %r4 to i192*
%r74 = load i192, i192* %r73
%r75 = zext i192 %r74 to i224
%r76 = sub i224 %r72, %r75
%r77 = lshr i224 %r76, 192
%r78 = trunc i224 %r77 to i1
%r79 = select i1 %r78, i224 %r72, i224 %r76
%r80 = trunc i224 %r79 to i192
%r81 = bitcast i32* %r1 to i192*
store i192 %r80, i192* %r81
ret void
}
define void @mcl_fp_montNF6L(i32* %r1, i32* %r2, i32* %r3, i32* %r4)
{
%r5 = getelementptr i32, i32* %r4, i32 -1
%r6 = load i32, i32* %r5
%r7 = load i32, i32* %r3
%r8 = call i224 @mulPv192x32(i32* %r2, i32 %r7)
%r9 = trunc i224 %r8 to i32
%r10 = mul i32 %r9, %r6
%r11 = call i224 @mulPv192x32(i32* %r4, i32 %r10)
%r12 = add i224 %r8, %r11
%r13 = lshr i224 %r12, 32
%r14 = getelementptr i32, i32* %r3, i32 1
%r15 = load i32, i32* %r14
%r16 = call i224 @mulPv192x32(i32* %r2, i32 %r15)
%r17 = add i224 %r13, %r16
%r18 = trunc i224 %r17 to i32
%r19 = mul i32 %r18, %r6
%r20 = call i224 @mulPv192x32(i32* %r4, i32 %r19)
%r21 = add i224 %r17, %r20
%r22 = lshr i224 %r21, 32
%r23 = getelementptr i32, i32* %r3, i32 2
%r24 = load i32, i32* %r23
%r25 = call i224 @mulPv192x32(i32* %r2, i32 %r24)
%r26 = add i224 %r22, %r25
%r27 = trunc i224 %r26 to i32
%r28 = mul i32 %r27, %r6
%r29 = call i224 @mulPv192x32(i32* %r4, i32 %r28)
%r30 = add i224 %r26, %r29
%r31 = lshr i224 %r30, 32
%r32 = getelementptr i32, i32* %r3, i32 3
%r33 = load i32, i32* %r32
%r34 = call i224 @mulPv192x32(i32* %r2, i32 %r33)
%r35 = add i224 %r31, %r34
%r36 = trunc i224 %r35 to i32
%r37 = mul i32 %r36, %r6
%r38 = call i224 @mulPv192x32(i32* %r4, i32 %r37)
%r39 = add i224 %r35, %r38
%r40 = lshr i224 %r39, 32
%r41 = getelementptr i32, i32* %r3, i32 4
%r42 = load i32, i32* %r41
%r43 = call i224 @mulPv192x32(i32* %r2, i32 %r42)
%r44 = add i224 %r40, %r43
%r45 = trunc i224 %r44 to i32
%r46 = mul i32 %r45, %r6
%r47 = call i224 @mulPv192x32(i32* %r4, i32 %r46)
%r48 = add i224 %r44, %r47
%r49 = lshr i224 %r48, 32
%r50 = getelementptr i32, i32* %r3, i32 5
%r51 = load i32, i32* %r50
%r52 = call i224 @mulPv192x32(i32* %r2, i32 %r51)
%r53 = add i224 %r49, %r52
%r54 = trunc i224 %r53 to i32
%r55 = mul i32 %r54, %r6
%r56 = call i224 @mulPv192x32(i32* %r4, i32 %r55)
%r57 = add i224 %r53, %r56
%r58 = lshr i224 %r57, 32
%r59 = trunc i224 %r58 to i192
%r60 = bitcast i32* %r4 to i192*
%r61 = load i192, i192* %r60
%r62 = sub i192 %r59, %r61
%r63 = lshr i192 %r62, 191
%r64 = trunc i192 %r63 to i1
%r65 = select i1 %r64, i192 %r59, i192 %r62
%r66 = bitcast i32* %r1 to i192*
store i192 %r65, i192* %r66
ret void
}
define void @mcl_fp_montRed6L(i32* noalias %r1, i32* noalias %r2, i32* noalias %r3)
{
%r4 = getelementptr i32, i32* %r3, i32 -1
%r5 = load i32, i32* %r4
%r6 = bitcast i32* %r3 to i192*
%r7 = load i192, i192* %r6
%r8 = bitcast i32* %r2 to i192*
%r9 = load i192, i192* %r8
%r10 = trunc i192 %r9 to i32
%r11 = mul i32 %r10, %r5
%r12 = call i224 @mulPv192x32(i32* %r3, i32 %r11)
%r13 = getelementptr i32, i32* %r2, i32 6
%r14 = load i32, i32* %r13
%r15 = zext i192 %r9 to i224
%r16 = zext i32 %r14 to i224
%r17 = shl i224 %r16, 192
%r18 = or i224 %r15, %r17
%r19 = zext i224 %r18 to i256
%r20 = zext i224 %r12 to i256
%r21 = add i256 %r19, %r20
%r22 = lshr i256 %r21, 32
%r23 = trunc i256 %r22 to i224
%r24 = lshr i224 %r23, 192
%r25 = trunc i224 %r24 to i32
%r26 = trunc i224 %r23 to i192
%r27 = trunc i192 %r26 to i32
%r28 = mul i32 %r27, %r5
%r29 = call i224 @mulPv192x32(i32* %r3, i32 %r28)
%r30 = zext i32 %r25 to i224
%r31 = shl i224 %r30, 192
%r32 = add i224 %r29, %r31
%r33 = getelementptr i32, i32* %r2, i32 7
%r34 = load i32, i32* %r33
%r35 = zext i192 %r26 to i224
%r36 = zext i32 %r34 to i224
%r37 = shl i224 %r36, 192
%r38 = or i224 %r35, %r37
%r39 = zext i224 %r38 to i256
%r40 = zext i224 %r32 to i256
%r41 = add i256 %r39, %r40
%r42 = lshr i256 %r41, 32
%r43 = trunc i256 %r42 to i224
%r44 = lshr i224 %r43, 192
%r45 = trunc i224 %r44 to i32
%r46 = trunc i224 %r43 to i192
%r47 = trunc i192 %r46 to i32
%r48 = mul i32 %r47, %r5
%r49 = call i224 @mulPv192x32(i32* %r3, i32 %r48)
%r50 = zext i32 %r45 to i224
%r51 = shl i224 %r50, 192
%r52 = add i224 %r49, %r51
%r53 = getelementptr i32, i32* %r2, i32 8
%r54 = load i32, i32* %r53
%r55 = zext i192 %r46 to i224
%r56 = zext i32 %r54 to i224
%r57 = shl i224 %r56, 192
%r58 = or i224 %r55, %r57
%r59 = zext i224 %r58 to i256
%r60 = zext i224 %r52 to i256
%r61 = add i256 %r59, %r60
%r62 = lshr i256 %r61, 32
%r63 = trunc i256 %r62 to i224
%r64 = lshr i224 %r63, 192
%r65 = trunc i224 %r64 to i32
%r66 = trunc i224 %r63 to i192
%r67 = trunc i192 %r66 to i32
%r68 = mul i32 %r67, %r5
%r69 = call i224 @mulPv192x32(i32* %r3, i32 %r68)
%r70 = zext i32 %r65 to i224
%r71 = shl i224 %r70, 192
%r72 = add i224 %r69, %r71
%r73 = getelementptr i32, i32* %r2, i32 9
%r74 = load i32, i32* %r73
%r75 = zext i192 %r66 to i224
%r76 = zext i32 %r74 to i224
%r77 = shl i224 %r76, 192
%r78 = or i224 %r75, %r77
%r79 = zext i224 %r78 to i256
%r80 = zext i224 %r72 to i256
%r81 = add i256 %r79, %r80
%r82 = lshr i256 %r81, 32
%r83 = trunc i256 %r82 to i224
%r84 = lshr i224 %r83, 192
%r85 = trunc i224 %r84 to i32
%r86 = trunc i224 %r83 to i192
%r87 = trunc i192 %r86 to i32
%r88 = mul i32 %r87, %r5
%r89 = call i224 @mulPv192x32(i32* %r3, i32 %r88)
%r90 = zext i32 %r85 to i224
%r91 = shl i224 %r90, 192
%r92 = add i224 %r89, %r91
%r93 = getelementptr i32, i32* %r2, i32 10
%r94 = load i32, i32* %r93
%r95 = zext i192 %r86 to i224
%r96 = zext i32 %r94 to i224
%r97 = shl i224 %r96, 192
%r98 = or i224 %r95, %r97
%r99 = zext i224 %r98 to i256
%r100 = zext i224 %r92 to i256
%r101 = add i256 %r99, %r100
%r102 = lshr i256 %r101, 32
%r103 = trunc i256 %r102 to i224
%r104 = lshr i224 %r103, 192
%r105 = trunc i224 %r104 to i32
%r106 = trunc i224 %r103 to i192
%r107 = trunc i192 %r106 to i32
%r108 = mul i32 %r107, %r5
%r109 = call i224 @mulPv192x32(i32* %r3, i32 %r108)
%r110 = zext i32 %r105 to i224
%r111 = shl i224 %r110, 192
%r112 = add i224 %r109, %r111
%r113 = getelementptr i32, i32* %r2, i32 11
%r114 = load i32, i32* %r113
%r115 = zext i192 %r106 to i224
%r116 = zext i32 %r114 to i224
%r117 = shl i224 %r116, 192
%r118 = or i224 %r115, %r117
%r119 = zext i224 %r118 to i256
%r120 = zext i224 %r112 to i256
%r121 = add i256 %r119, %r120
%r122 = lshr i256 %r121, 32
%r123 = trunc i256 %r122 to i224
%r124 = lshr i224 %r123, 192
%r125 = trunc i224 %r124 to i32
%r126 = trunc i224 %r123 to i192
%r127 = zext i192 %r7 to i224
%r128 = zext i192 %r126 to i224
%r129 = zext i32 %r125 to i224
%r130 = shl i224 %r129, 192
%r131 = or i224 %r128, %r130
%r132 = sub i224 %r131, %r127
%r133 = lshr i224 %r132, 192
%r134 = trunc i224 %r133 to i1
%r135 = select i1 %r134, i224 %r131, i224 %r132
%r136 = trunc i224 %r135 to i192
%r137 = bitcast i32* %r1 to i192*
store i192 %r136, i192* %r137
ret void
}
define void @mcl_fp_montRedNF6L(i32* noalias %r1, i32* noalias %r2, i32* noalias %r3)
{
%r4 = getelementptr i32, i32* %r3, i32 -1
%r5 = load i32, i32* %r4
%r6 = bitcast i32* %r3 to i192*
%r7 = load i192, i192* %r6
%r8 = bitcast i32* %r2 to i192*
%r9 = load i192, i192* %r8
%r10 = trunc i192 %r9 to i32
%r11 = mul i32 %r10, %r5
%r12 = call i224 @mulPv192x32(i32* %r3, i32 %r11)
%r13 = getelementptr i32, i32* %r2, i32 6
%r14 = load i32, i32* %r13
%r15 = zext i192 %r9 to i224
%r16 = zext i32 %r14 to i224
%r17 = shl i224 %r16, 192
%r18 = or i224 %r15, %r17
%r19 = zext i224 %r18 to i256
%r20 = zext i224 %r12 to i256
%r21 = add i256 %r19, %r20
%r22 = lshr i256 %r21, 32
%r23 = trunc i256 %r22 to i224
%r24 = lshr i224 %r23, 192
%r25 = trunc i224 %r24 to i32
%r26 = trunc i224 %r23 to i192
%r27 = trunc i192 %r26 to i32
%r28 = mul i32 %r27, %r5
%r29 = call i224 @mulPv192x32(i32* %r3, i32 %r28)
%r30 = zext i32 %r25 to i224
%r31 = shl i224 %r30, 192
%r32 = add i224 %r29, %r31
%r33 = getelementptr i32, i32* %r2, i32 7
%r34 = load i32, i32* %r33
%r35 = zext i192 %r26 to i224
%r36 = zext i32 %r34 to i224
%r37 = shl i224 %r36, 192
%r38 = or i224 %r35, %r37
%r39 = zext i224 %r38 to i256
%r40 = zext i224 %r32 to i256
%r41 = add i256 %r39, %r40
%r42 = lshr i256 %r41, 32
%r43 = trunc i256 %r42 to i224
%r44 = lshr i224 %r43, 192
%r45 = trunc i224 %r44 to i32
%r46 = trunc i224 %r43 to i192
%r47 = trunc i192 %r46 to i32
%r48 = mul i32 %r47, %r5
%r49 = call i224 @mulPv192x32(i32* %r3, i32 %r48)
%r50 = zext i32 %r45 to i224
%r51 = shl i224 %r50, 192
%r52 = add i224 %r49, %r51
%r53 = getelementptr i32, i32* %r2, i32 8
%r54 = load i32, i32* %r53
%r55 = zext i192 %r46 to i224
%r56 = zext i32 %r54 to i224
%r57 = shl i224 %r56, 192
%r58 = or i224 %r55, %r57
%r59 = zext i224 %r58 to i256
%r60 = zext i224 %r52 to i256
%r61 = add i256 %r59, %r60
%r62 = lshr i256 %r61, 32
%r63 = trunc i256 %r62 to i224
%r64 = lshr i224 %r63, 192
%r65 = trunc i224 %r64 to i32
%r66 = trunc i224 %r63 to i192
%r67 = trunc i192 %r66 to i32
%r68 = mul i32 %r67, %r5
%r69 = call i224 @mulPv192x32(i32* %r3, i32 %r68)
%r70 = zext i32 %r65 to i224
%r71 = shl i224 %r70, 192
%r72 = add i224 %r69, %r71
%r73 = getelementptr i32, i32* %r2, i32 9
%r74 = load i32, i32* %r73
%r75 = zext i192 %r66 to i224
%r76 = zext i32 %r74 to i224
%r77 = shl i224 %r76, 192
%r78 = or i224 %r75, %r77
%r79 = zext i224 %r78 to i256
%r80 = zext i224 %r72 to i256
%r81 = add i256 %r79, %r80
%r82 = lshr i256 %r81, 32
%r83 = trunc i256 %r82 to i224
%r84 = lshr i224 %r83, 192
%r85 = trunc i224 %r84 to i32
%r86 = trunc i224 %r83 to i192
%r87 = trunc i192 %r86 to i32
%r88 = mul i32 %r87, %r5
%r89 = call i224 @mulPv192x32(i32* %r3, i32 %r88)
%r90 = zext i32 %r85 to i224
%r91 = shl i224 %r90, 192
%r92 = add i224 %r89, %r91
%r93 = getelementptr i32, i32* %r2, i32 10
%r94 = load i32, i32* %r93
%r95 = zext i192 %r86 to i224
%r96 = zext i32 %r94 to i224
%r97 = shl i224 %r96, 192
%r98 = or i224 %r95, %r97
%r99 = zext i224 %r98 to i256
%r100 = zext i224 %r92 to i256
%r101 = add i256 %r99, %r100
%r102 = lshr i256 %r101, 32
%r103 = trunc i256 %r102 to i224
%r104 = lshr i224 %r103, 192
%r105 = trunc i224 %r104 to i32
%r106 = trunc i224 %r103 to i192
%r107 = trunc i192 %r106 to i32
%r108 = mul i32 %r107, %r5
%r109 = call i224 @mulPv192x32(i32* %r3, i32 %r108)
%r110 = zext i32 %r105 to i224
%r111 = shl i224 %r110, 192
%r112 = add i224 %r109, %r111
%r113 = getelementptr i32, i32* %r2, i32 11
%r114 = load i32, i32* %r113
%r115 = zext i192 %r106 to i224
%r116 = zext i32 %r114 to i224
%r117 = shl i224 %r116, 192
%r118 = or i224 %r115, %r117
%r119 = zext i224 %r118 to i256
%r120 = zext i224 %r112 to i256
%r121 = add i256 %r119, %r120
%r122 = lshr i256 %r121, 32
%r123 = trunc i256 %r122 to i224
%r124 = lshr i224 %r123, 192
%r125 = trunc i224 %r124 to i32
%r126 = trunc i224 %r123 to i192
%r127 = sub i192 %r126, %r7
%r128 = lshr i192 %r127, 191
%r129 = trunc i192 %r128 to i1
%r130 = select i1 %r129, i192 %r126, i192 %r127
%r131 = bitcast i32* %r1 to i192*
store i192 %r130, i192* %r131
ret void
}
define i32 @mcl_fp_addPre6L(i32* noalias %r1, i32* noalias %r2, i32* noalias %r3)
{
%r5 = bitcast i32* %r2 to i192*
%r6 = load i192, i192* %r5
%r7 = zext i192 %r6 to i224
%r8 = bitcast i32* %r3 to i192*
%r9 = load i192, i192* %r8
%r10 = zext i192 %r9 to i224
%r11 = add i224 %r7, %r10
%r12 = trunc i224 %r11 to i192
%r13 = bitcast i32* %r1 to i192*
store i192 %r12, i192* %r13
%r14 = lshr i224 %r11, 192
%r15 = trunc i224 %r14 to i32
ret i32 %r15
}
define i32 @mcl_fp_subPre6L(i32* noalias %r1, i32* noalias %r2, i32* noalias %r3)
{
%r5 = bitcast i32* %r2 to i192*
%r6 = load i192, i192* %r5
%r7 = zext i192 %r6 to i224
%r8 = bitcast i32* %r3 to i192*
%r9 = load i192, i192* %r8
%r10 = zext i192 %r9 to i224
%r11 = sub i224 %r7, %r10
%r12 = trunc i224 %r11 to i192
%r13 = bitcast i32* %r1 to i192*
store i192 %r12, i192* %r13
%r14 = lshr i224 %r11, 192
%r15 = trunc i224 %r14 to i32
%r16 = and i32 %r15, 1
ret i32 %r16
}
define void @mcl_fp_shr1_6L(i32* noalias %r1, i32* noalias %r2)
{
%r3 = bitcast i32* %r2 to i192*
%r4 = load i192, i192* %r3
%r5 = lshr i192 %r4, 1
%r6 = bitcast i32* %r1 to i192*
store i192 %r5, i192* %r6
ret void
}
define void @mcl_fp_add6L(i32* noalias %r1, i32* noalias %r2, i32* noalias %r3, i32* noalias %r4)
{
%r5 = bitcast i32* %r2 to i192*
%r6 = load i192, i192* %r5
%r7 = bitcast i32* %r3 to i192*
%r8 = load i192, i192* %r7
%r9 = bitcast i32* %r4 to i192*
%r10 = load i192, i192* %r9
%r11 = zext i192 %r6 to i224
%r12 = zext i192 %r8 to i224
%r13 = add i224 %r11, %r12
%r14 = zext i192 %r10 to i224
%r15 = sub i224 %r13, %r14
%r16 = lshr i224 %r15, 192
%r17 = trunc i224 %r16 to i1
%r18 = select i1 %r17, i224 %r13, i224 %r15
%r19 = trunc i224 %r18 to i192
%r20 = bitcast i32* %r1 to i192*
store i192 %r19, i192* %r20
ret void
}
define void @mcl_fp_addNF6L(i32* noalias %r1, i32* noalias %r2, i32* noalias %r3, i32* noalias %r4)
{
%r5 = bitcast i32* %r2 to i192*
%r6 = load i192, i192* %r5
%r7 = bitcast i32* %r3 to i192*
%r8 = load i192, i192* %r7
%r9 = bitcast i32* %r4 to i192*
%r10 = load i192, i192* %r9
%r11 = add i192 %r6, %r8
%r12 = sub i192 %r11, %r10
%r13 = lshr i192 %r12, 191
%r14 = trunc i192 %r13 to i1
%r15 = select i1 %r14, i192 %r11, i192 %r12
%r16 = bitcast i32* %r1 to i192*
store i192 %r15, i192* %r16
ret void
}
define void @mcl_fp_sub6L(i32* noalias %r1, i32* noalias %r2, i32* noalias %r3, i32* noalias %r4)
{
%r5 = bitcast i32* %r2 to i192*
%r6 = load i192, i192* %r5
%r7 = bitcast i32* %r3 to i192*
%r8 = load i192, i192* %r7
%r9 = zext i192 %r6 to i224
%r10 = zext i192 %r8 to i224
%r11 = sub i224 %r9, %r10
%r12 = lshr i224 %r11, 192
%r13 = trunc i224 %r12 to i1
%r14 = trunc i224 %r11 to i192
%r15 = bitcast i32* %r4 to i192*
%r16 = load i192, i192* %r15
%r17 = select i1 %r13, i192 %r16, i192 0
%r18 = add i192 %r14, %r17
%r19 = bitcast i32* %r1 to i192*
store i192 %r18, i192* %r19
ret void
}
define void @mcl_fp_subNF6L(i32* noalias %r1, i32* noalias %r2, i32* noalias %r3, i32* noalias %r4)
{
%r5 = bitcast i32* %r2 to i192*
%r6 = load i192, i192* %r5
%r7 = bitcast i32* %r3 to i192*
%r8 = load i192, i192* %r7
%r9 = sub i192 %r6, %r8
%r10 = lshr i192 %r9, 191
%r11 = trunc i192 %r10 to i1
%r12 = bitcast i32* %r4 to i192*
%r13 = load i192, i192* %r12
%r14 = select i1 %r11, i192 %r13, i192 0
%r15 = add i192 %r9, %r14
%r16 = bitcast i32* %r1 to i192*
store i192 %r15, i192* %r16
ret void
}
define void @mcl_fpDbl_add6L(i32* noalias %r1, i32* noalias %r2, i32* noalias %r3, i32* noalias %r4)
{
%r5 = bitcast i32* %r2 to i384*
%r6 = load i384, i384* %r5
%r7 = bitcast i32* %r3 to i384*
%r8 = load i384, i384* %r7
%r9 = zext i384 %r6 to i416
%r10 = zext i384 %r8 to i416
%r11 = add i416 %r9, %r10
%r12 = trunc i416 %r11 to i192
%r13 = bitcast i32* %r1 to i192*
store i192 %r12, i192* %r13
%r14 = lshr i416 %r11, 192
%r15 = trunc i416 %r14 to i224
%r16 = bitcast i32* %r4 to i192*
%r17 = load i192, i192* %r16
%r18 = zext i192 %r17 to i224
%r19 = sub i224 %r15, %r18
%r20 = lshr i224 %r19, 192
%r21 = trunc i224 %r20 to i1
%r22 = select i1 %r21, i224 %r15, i224 %r19
%r23 = trunc i224 %r22 to i192
%r24 = getelementptr i32, i32* %r1, i32 6
%r25 = bitcast i32* %r24 to i192*
store i192 %r23, i192* %r25
ret void
}
define void @mcl_fpDbl_sub6L(i32* noalias %r1, i32* noalias %r2, i32* noalias %r3, i32* noalias %r4)
{
%r5 = bitcast i32* %r2 to i384*
%r6 = load i384, i384* %r5
%r7 = bitcast i32* %r3 to i384*
%r8 = load i384, i384* %r7
%r9 = zext i384 %r6 to i416
%r10 = zext i384 %r8 to i416
%r11 = sub i416 %r9, %r10
%r12 = trunc i416 %r11 to i192
%r13 = bitcast i32* %r1 to i192*
store i192 %r12, i192* %r13
%r14 = lshr i416 %r11, 192
%r15 = trunc i416 %r14 to i192
%r16 = lshr i416 %r11, 384
%r17 = trunc i416 %r16 to i1
%r18 = bitcast i32* %r4 to i192*
%r19 = load i192, i192* %r18
%r20 = select i1 %r17, i192 %r19, i192 0
%r21 = add i192 %r15, %r20
%r22 = getelementptr i32, i32* %r1, i32 6
%r23 = bitcast i32* %r22 to i192*
store i192 %r21, i192* %r23
ret void
}
define i256 @mulPv224x32(i32* noalias %r2, i32 %r3)
{
%r4 = call i64 @mulPos32x32(i32* %r2, i32 %r3, i32 0)
%r5 = trunc i64 %r4 to i32
%r6 = call i32 @extractHigh32(i64 %r4)
%r7 = call i64 @mulPos32x32(i32* %r2, i32 %r3, i32 1)
%r8 = trunc i64 %r7 to i32
%r9 = call i32 @extractHigh32(i64 %r7)
%r10 = call i64 @mulPos32x32(i32* %r2, i32 %r3, i32 2)
%r11 = trunc i64 %r10 to i32
%r12 = call i32 @extractHigh32(i64 %r10)
%r13 = call i64 @mulPos32x32(i32* %r2, i32 %r3, i32 3)
%r14 = trunc i64 %r13 to i32
%r15 = call i32 @extractHigh32(i64 %r13)
%r16 = call i64 @mulPos32x32(i32* %r2, i32 %r3, i32 4)
%r17 = trunc i64 %r16 to i32
%r18 = call i32 @extractHigh32(i64 %r16)
%r19 = call i64 @mulPos32x32(i32* %r2, i32 %r3, i32 5)
%r20 = trunc i64 %r19 to i32
%r21 = call i32 @extractHigh32(i64 %r19)
%r22 = call i64 @mulPos32x32(i32* %r2, i32 %r3, i32 6)
%r23 = trunc i64 %r22 to i32
%r24 = call i32 @extractHigh32(i64 %r22)
%r25 = zext i32 %r5 to i64
%r26 = zext i32 %r8 to i64
%r27 = shl i64 %r26, 32
%r28 = or i64 %r25, %r27
%r29 = zext i64 %r28 to i96
%r30 = zext i32 %r11 to i96
%r31 = shl i96 %r30, 64
%r32 = or i96 %r29, %r31
%r33 = zext i96 %r32 to i128
%r34 = zext i32 %r14 to i128
%r35 = shl i128 %r34, 96
%r36 = or i128 %r33, %r35
%r37 = zext i128 %r36 to i160
%r38 = zext i32 %r17 to i160
%r39 = shl i160 %r38, 128
%r40 = or i160 %r37, %r39
%r41 = zext i160 %r40 to i192
%r42 = zext i32 %r20 to i192
%r43 = shl i192 %r42, 160
%r44 = or i192 %r41, %r43
%r45 = zext i192 %r44 to i224
%r46 = zext i32 %r23 to i224
%r47 = shl i224 %r46, 192
%r48 = or i224 %r45, %r47
%r49 = zext i32 %r6 to i64
%r50 = zext i32 %r9 to i64
%r51 = shl i64 %r50, 32
%r52 = or i64 %r49, %r51
%r53 = zext i64 %r52 to i96
%r54 = zext i32 %r12 to i96
%r55 = shl i96 %r54, 64
%r56 = or i96 %r53, %r55
%r57 = zext i96 %r56 to i128
%r58 = zext i32 %r15 to i128
%r59 = shl i128 %r58, 96
%r60 = or i128 %r57, %r59
%r61 = zext i128 %r60 to i160
%r62 = zext i32 %r18 to i160
%r63 = shl i160 %r62, 128
%r64 = or i160 %r61, %r63
%r65 = zext i160 %r64 to i192
%r66 = zext i32 %r21 to i192
%r67 = shl i192 %r66, 160
%r68 = or i192 %r65, %r67
%r69 = zext i192 %r68 to i224
%r70 = zext i32 %r24 to i224
%r71 = shl i224 %r70, 192
%r72 = or i224 %r69, %r71
%r73 = zext i224 %r48 to i256
%r74 = zext i224 %r72 to i256
%r75 = shl i256 %r74, 32
%r76 = add i256 %r73, %r75
ret i256 %r76
}
define void @mcl_fp_mont7L(i32* %r1, i32* %r2, i32* %r3, i32* %r4)
{
%r5 = getelementptr i32, i32* %r4, i32 -1
%r6 = load i32, i32* %r5
%r7 = getelementptr i32, i32* %r3, i32 0
%r8 = load i32, i32* %r7
%r9 = call i256 @mulPv224x32(i32* %r2, i32 %r8)
%r10 = zext i256 %r9 to i288
%r11 = trunc i256 %r9 to i32
%r12 = mul i32 %r11, %r6
%r13 = call i256 @mulPv224x32(i32* %r4, i32 %r12)
%r14 = zext i256 %r13 to i288
%r15 = add i288 %r10, %r14
%r16 = lshr i288 %r15, 32
%r17 = getelementptr i32, i32* %r3, i32 1
%r18 = load i32, i32* %r17
%r19 = call i256 @mulPv224x32(i32* %r2, i32 %r18)
%r20 = zext i256 %r19 to i288
%r21 = add i288 %r16, %r20
%r22 = trunc i288 %r21 to i32
%r23 = mul i32 %r22, %r6
%r24 = call i256 @mulPv224x32(i32* %r4, i32 %r23)
%r25 = zext i256 %r24 to i288
%r26 = add i288 %r21, %r25
%r27 = lshr i288 %r26, 32
%r28 = getelementptr i32, i32* %r3, i32 2
%r29 = load i32, i32* %r28
%r30 = call i256 @mulPv224x32(i32* %r2, i32 %r29)
%r31 = zext i256 %r30 to i288
%r32 = add i288 %r27, %r31
%r33 = trunc i288 %r32 to i32
%r34 = mul i32 %r33, %r6
%r35 = call i256 @mulPv224x32(i32* %r4, i32 %r34)
%r36 = zext i256 %r35 to i288
%r37 = add i288 %r32, %r36
%r38 = lshr i288 %r37, 32
%r39 = getelementptr i32, i32* %r3, i32 3
%r40 = load i32, i32* %r39
%r41 = call i256 @mulPv224x32(i32* %r2, i32 %r40)
%r42 = zext i256 %r41 to i288
%r43 = add i288 %r38, %r42
%r44 = trunc i288 %r43 to i32
%r45 = mul i32 %r44, %r6
%r46 = call i256 @mulPv224x32(i32* %r4, i32 %r45)
%r47 = zext i256 %r46 to i288
%r48 = add i288 %r43, %r47
%r49 = lshr i288 %r48, 32
%r50 = getelementptr i32, i32* %r3, i32 4
%r51 = load i32, i32* %r50
%r52 = call i256 @mulPv224x32(i32* %r2, i32 %r51)
%r53 = zext i256 %r52 to i288
%r54 = add i288 %r49, %r53
%r55 = trunc i288 %r54 to i32
%r56 = mul i32 %r55, %r6
%r57 = call i256 @mulPv224x32(i32* %r4, i32 %r56)
%r58 = zext i256 %r57 to i288
%r59 = add i288 %r54, %r58
%r60 = lshr i288 %r59, 32
%r61 = getelementptr i32, i32* %r3, i32 5
%r62 = load i32, i32* %r61
%r63 = call i256 @mulPv224x32(i32* %r2, i32 %r62)
%r64 = zext i256 %r63 to i288
%r65 = add i288 %r60, %r64
%r66 = trunc i288 %r65 to i32
%r67 = mul i32 %r66, %r6
%r68 = call i256 @mulPv224x32(i32* %r4, i32 %r67)
%r69 = zext i256 %r68 to i288
%r70 = add i288 %r65, %r69
%r71 = lshr i288 %r70, 32
%r72 = getelementptr i32, i32* %r3, i32 6
%r73 = load i32, i32* %r72
%r74 = call i256 @mulPv224x32(i32* %r2, i32 %r73)
%r75 = zext i256 %r74 to i288
%r76 = add i288 %r71, %r75
%r77 = trunc i288 %r76 to i32
%r78 = mul i32 %r77, %r6
%r79 = call i256 @mulPv224x32(i32* %r4, i32 %r78)
%r80 = zext i256 %r79 to i288
%r81 = add i288 %r76, %r80
%r82 = lshr i288 %r81, 32
%r83 = trunc i288 %r82 to i256
%r84 = bitcast i32* %r4 to i224*
%r85 = load i224, i224* %r84
%r86 = zext i224 %r85 to i256
%r87 = sub i256 %r83, %r86
%r88 = lshr i256 %r87, 224
%r89 = trunc i256 %r88 to i1
%r90 = select i1 %r89, i256 %r83, i256 %r87
%r91 = trunc i256 %r90 to i224
%r92 = bitcast i32* %r1 to i224*
store i224 %r91, i224* %r92
ret void
}
define void @mcl_fp_montNF7L(i32* %r1, i32* %r2, i32* %r3, i32* %r4)
{
%r5 = getelementptr i32, i32* %r4, i32 -1
%r6 = load i32, i32* %r5
%r7 = load i32, i32* %r3
%r8 = call i256 @mulPv224x32(i32* %r2, i32 %r7)
%r9 = trunc i256 %r8 to i32
%r10 = mul i32 %r9, %r6
%r11 = call i256 @mulPv224x32(i32* %r4, i32 %r10)
%r12 = add i256 %r8, %r11
%r13 = lshr i256 %r12, 32
%r14 = getelementptr i32, i32* %r3, i32 1
%r15 = load i32, i32* %r14
%r16 = call i256 @mulPv224x32(i32* %r2, i32 %r15)
%r17 = add i256 %r13, %r16
%r18 = trunc i256 %r17 to i32
%r19 = mul i32 %r18, %r6
%r20 = call i256 @mulPv224x32(i32* %r4, i32 %r19)
%r21 = add i256 %r17, %r20
%r22 = lshr i256 %r21, 32
%r23 = getelementptr i32, i32* %r3, i32 2
%r24 = load i32, i32* %r23
%r25 = call i256 @mulPv224x32(i32* %r2, i32 %r24)
%r26 = add i256 %r22, %r25
%r27 = trunc i256 %r26 to i32
%r28 = mul i32 %r27, %r6
%r29 = call i256 @mulPv224x32(i32* %r4, i32 %r28)
%r30 = add i256 %r26, %r29
%r31 = lshr i256 %r30, 32
%r32 = getelementptr i32, i32* %r3, i32 3
%r33 = load i32, i32* %r32
%r34 = call i256 @mulPv224x32(i32* %r2, i32 %r33)
%r35 = add i256 %r31, %r34
%r36 = trunc i256 %r35 to i32
%r37 = mul i32 %r36, %r6
%r38 = call i256 @mulPv224x32(i32* %r4, i32 %r37)
%r39 = add i256 %r35, %r38
%r40 = lshr i256 %r39, 32
%r41 = getelementptr i32, i32* %r3, i32 4
%r42 = load i32, i32* %r41
%r43 = call i256 @mulPv224x32(i32* %r2, i32 %r42)
%r44 = add i256 %r40, %r43
%r45 = trunc i256 %r44 to i32
%r46 = mul i32 %r45, %r6
%r47 = call i256 @mulPv224x32(i32* %r4, i32 %r46)
%r48 = add i256 %r44, %r47
%r49 = lshr i256 %r48, 32
%r50 = getelementptr i32, i32* %r3, i32 5
%r51 = load i32, i32* %r50
%r52 = call i256 @mulPv224x32(i32* %r2, i32 %r51)
%r53 = add i256 %r49, %r52
%r54 = trunc i256 %r53 to i32
%r55 = mul i32 %r54, %r6
%r56 = call i256 @mulPv224x32(i32* %r4, i32 %r55)
%r57 = add i256 %r53, %r56
%r58 = lshr i256 %r57, 32
%r59 = getelementptr i32, i32* %r3, i32 6
%r60 = load i32, i32* %r59
%r61 = call i256 @mulPv224x32(i32* %r2, i32 %r60)
%r62 = add i256 %r58, %r61
%r63 = trunc i256 %r62 to i32
%r64 = mul i32 %r63, %r6
%r65 = call i256 @mulPv224x32(i32* %r4, i32 %r64)
%r66 = add i256 %r62, %r65
%r67 = lshr i256 %r66, 32
%r68 = trunc i256 %r67 to i224
%r69 = bitcast i32* %r4 to i224*
%r70 = load i224, i224* %r69
%r71 = sub i224 %r68, %r70
%r72 = lshr i224 %r71, 223
%r73 = trunc i224 %r72 to i1
%r74 = select i1 %r73, i224 %r68, i224 %r71
%r75 = bitcast i32* %r1 to i224*
store i224 %r74, i224* %r75
ret void
}
define void @mcl_fp_montRed7L(i32* noalias %r1, i32* noalias %r2, i32* noalias %r3)
{
%r4 = getelementptr i32, i32* %r3, i32 -1
%r5 = load i32, i32* %r4
%r6 = bitcast i32* %r3 to i224*
%r7 = load i224, i224* %r6
%r8 = bitcast i32* %r2 to i224*
%r9 = load i224, i224* %r8
%r10 = trunc i224 %r9 to i32
%r11 = mul i32 %r10, %r5
%r12 = call i256 @mulPv224x32(i32* %r3, i32 %r11)
%r13 = getelementptr i32, i32* %r2, i32 7
%r14 = load i32, i32* %r13
%r15 = zext i224 %r9 to i256
%r16 = zext i32 %r14 to i256
%r17 = shl i256 %r16, 224
%r18 = or i256 %r15, %r17
%r19 = zext i256 %r18 to i288
%r20 = zext i256 %r12 to i288
%r21 = add i288 %r19, %r20
%r22 = lshr i288 %r21, 32
%r23 = trunc i288 %r22 to i256
%r24 = lshr i256 %r23, 224
%r25 = trunc i256 %r24 to i32
%r26 = trunc i256 %r23 to i224
%r27 = trunc i224 %r26 to i32
%r28 = mul i32 %r27, %r5
%r29 = call i256 @mulPv224x32(i32* %r3, i32 %r28)
%r30 = zext i32 %r25 to i256
%r31 = shl i256 %r30, 224
%r32 = add i256 %r29, %r31
%r33 = getelementptr i32, i32* %r2, i32 8
%r34 = load i32, i32* %r33
%r35 = zext i224 %r26 to i256
%r36 = zext i32 %r34 to i256
%r37 = shl i256 %r36, 224
%r38 = or i256 %r35, %r37
%r39 = zext i256 %r38 to i288
%r40 = zext i256 %r32 to i288
%r41 = add i288 %r39, %r40
%r42 = lshr i288 %r41, 32
%r43 = trunc i288 %r42 to i256
%r44 = lshr i256 %r43, 224
%r45 = trunc i256 %r44 to i32
%r46 = trunc i256 %r43 to i224
%r47 = trunc i224 %r46 to i32
%r48 = mul i32 %r47, %r5
%r49 = call i256 @mulPv224x32(i32* %r3, i32 %r48)
%r50 = zext i32 %r45 to i256
%r51 = shl i256 %r50, 224
%r52 = add i256 %r49, %r51
%r53 = getelementptr i32, i32* %r2, i32 9
%r54 = load i32, i32* %r53
%r55 = zext i224 %r46 to i256
%r56 = zext i32 %r54 to i256
%r57 = shl i256 %r56, 224
%r58 = or i256 %r55, %r57
%r59 = zext i256 %r58 to i288
%r60 = zext i256 %r52 to i288
%r61 = add i288 %r59, %r60
%r62 = lshr i288 %r61, 32
%r63 = trunc i288 %r62 to i256
%r64 = lshr i256 %r63, 224
%r65 = trunc i256 %r64 to i32
%r66 = trunc i256 %r63 to i224
%r67 = trunc i224 %r66 to i32
%r68 = mul i32 %r67, %r5
%r69 = call i256 @mulPv224x32(i32* %r3, i32 %r68)
%r70 = zext i32 %r65 to i256
%r71 = shl i256 %r70, 224
%r72 = add i256 %r69, %r71
%r73 = getelementptr i32, i32* %r2, i32 10
%r74 = load i32, i32* %r73
%r75 = zext i224 %r66 to i256
%r76 = zext i32 %r74 to i256
%r77 = shl i256 %r76, 224
%r78 = or i256 %r75, %r77
%r79 = zext i256 %r78 to i288
%r80 = zext i256 %r72 to i288
%r81 = add i288 %r79, %r80
%r82 = lshr i288 %r81, 32
%r83 = trunc i288 %r82 to i256
%r84 = lshr i256 %r83, 224
%r85 = trunc i256 %r84 to i32
%r86 = trunc i256 %r83 to i224
%r87 = trunc i224 %r86 to i32
%r88 = mul i32 %r87, %r5
%r89 = call i256 @mulPv224x32(i32* %r3, i32 %r88)
%r90 = zext i32 %r85 to i256
%r91 = shl i256 %r90, 224
%r92 = add i256 %r89, %r91
%r93 = getelementptr i32, i32* %r2, i32 11
%r94 = load i32, i32* %r93
%r95 = zext i224 %r86 to i256
%r96 = zext i32 %r94 to i256
%r97 = shl i256 %r96, 224
%r98 = or i256 %r95, %r97
%r99 = zext i256 %r98 to i288
%r100 = zext i256 %r92 to i288
%r101 = add i288 %r99, %r100
%r102 = lshr i288 %r101, 32
%r103 = trunc i288 %r102 to i256
%r104 = lshr i256 %r103, 224
%r105 = trunc i256 %r104 to i32
%r106 = trunc i256 %r103 to i224
%r107 = trunc i224 %r106 to i32
%r108 = mul i32 %r107, %r5
%r109 = call i256 @mulPv224x32(i32* %r3, i32 %r108)
%r110 = zext i32 %r105 to i256
%r111 = shl i256 %r110, 224
%r112 = add i256 %r109, %r111
%r113 = getelementptr i32, i32* %r2, i32 12
%r114 = load i32, i32* %r113
%r115 = zext i224 %r106 to i256
%r116 = zext i32 %r114 to i256
%r117 = shl i256 %r116, 224
%r118 = or i256 %r115, %r117
%r119 = zext i256 %r118 to i288
%r120 = zext i256 %r112 to i288
%r121 = add i288 %r119, %r120
%r122 = lshr i288 %r121, 32
%r123 = trunc i288 %r122 to i256
%r124 = lshr i256 %r123, 224
%r125 = trunc i256 %r124 to i32
%r126 = trunc i256 %r123 to i224
%r127 = trunc i224 %r126 to i32
%r128 = mul i32 %r127, %r5
%r129 = call i256 @mulPv224x32(i32* %r3, i32 %r128)
%r130 = zext i32 %r125 to i256
%r131 = shl i256 %r130, 224
%r132 = add i256 %r129, %r131
%r133 = getelementptr i32, i32* %r2, i32 13
%r134 = load i32, i32* %r133
%r135 = zext i224 %r126 to i256
%r136 = zext i32 %r134 to i256
%r137 = shl i256 %r136, 224
%r138 = or i256 %r135, %r137
%r139 = zext i256 %r138 to i288
%r140 = zext i256 %r132 to i288
%r141 = add i288 %r139, %r140
%r142 = lshr i288 %r141, 32
%r143 = trunc i288 %r142 to i256
%r144 = lshr i256 %r143, 224
%r145 = trunc i256 %r144 to i32
%r146 = trunc i256 %r143 to i224
%r147 = zext i224 %r7 to i256
%r148 = zext i224 %r146 to i256
%r149 = zext i32 %r145 to i256
%r150 = shl i256 %r149, 224
%r151 = or i256 %r148, %r150
%r152 = sub i256 %r151, %r147
%r153 = lshr i256 %r152, 224
%r154 = trunc i256 %r153 to i1
%r155 = select i1 %r154, i256 %r151, i256 %r152
%r156 = trunc i256 %r155 to i224
%r157 = bitcast i32* %r1 to i224*
store i224 %r156, i224* %r157
ret void
}
define void @mcl_fp_montRedNF7L(i32* noalias %r1, i32* noalias %r2, i32* noalias %r3)
{
%r4 = getelementptr i32, i32* %r3, i32 -1
%r5 = load i32, i32* %r4
%r6 = bitcast i32* %r3 to i224*
%r7 = load i224, i224* %r6
%r8 = bitcast i32* %r2 to i224*
%r9 = load i224, i224* %r8
%r10 = trunc i224 %r9 to i32
%r11 = mul i32 %r10, %r5
%r12 = call i256 @mulPv224x32(i32* %r3, i32 %r11)
%r13 = getelementptr i32, i32* %r2, i32 7
%r14 = load i32, i32* %r13
%r15 = zext i224 %r9 to i256
%r16 = zext i32 %r14 to i256
%r17 = shl i256 %r16, 224
%r18 = or i256 %r15, %r17
%r19 = zext i256 %r18 to i288
%r20 = zext i256 %r12 to i288
%r21 = add i288 %r19, %r20
%r22 = lshr i288 %r21, 32
%r23 = trunc i288 %r22 to i256
%r24 = lshr i256 %r23, 224
%r25 = trunc i256 %r24 to i32
%r26 = trunc i256 %r23 to i224
%r27 = trunc i224 %r26 to i32
%r28 = mul i32 %r27, %r5
%r29 = call i256 @mulPv224x32(i32* %r3, i32 %r28)
%r30 = zext i32 %r25 to i256
%r31 = shl i256 %r30, 224
%r32 = add i256 %r29, %r31
%r33 = getelementptr i32, i32* %r2, i32 8
%r34 = load i32, i32* %r33
%r35 = zext i224 %r26 to i256
%r36 = zext i32 %r34 to i256
%r37 = shl i256 %r36, 224
%r38 = or i256 %r35, %r37
%r39 = zext i256 %r38 to i288
%r40 = zext i256 %r32 to i288
%r41 = add i288 %r39, %r40
%r42 = lshr i288 %r41, 32
%r43 = trunc i288 %r42 to i256
%r44 = lshr i256 %r43, 224
%r45 = trunc i256 %r44 to i32
%r46 = trunc i256 %r43 to i224
%r47 = trunc i224 %r46 to i32
%r48 = mul i32 %r47, %r5
%r49 = call i256 @mulPv224x32(i32* %r3, i32 %r48)
%r50 = zext i32 %r45 to i256
%r51 = shl i256 %r50, 224
%r52 = add i256 %r49, %r51
%r53 = getelementptr i32, i32* %r2, i32 9
%r54 = load i32, i32* %r53
%r55 = zext i224 %r46 to i256
%r56 = zext i32 %r54 to i256
%r57 = shl i256 %r56, 224
%r58 = or i256 %r55, %r57
%r59 = zext i256 %r58 to i288
%r60 = zext i256 %r52 to i288
%r61 = add i288 %r59, %r60
%r62 = lshr i288 %r61, 32
%r63 = trunc i288 %r62 to i256
%r64 = lshr i256 %r63, 224
%r65 = trunc i256 %r64 to i32
%r66 = trunc i256 %r63 to i224
%r67 = trunc i224 %r66 to i32
%r68 = mul i32 %r67, %r5
%r69 = call i256 @mulPv224x32(i32* %r3, i32 %r68)
%r70 = zext i32 %r65 to i256
%r71 = shl i256 %r70, 224
%r72 = add i256 %r69, %r71
%r73 = getelementptr i32, i32* %r2, i32 10
%r74 = load i32, i32* %r73
%r75 = zext i224 %r66 to i256
%r76 = zext i32 %r74 to i256
%r77 = shl i256 %r76, 224
%r78 = or i256 %r75, %r77
%r79 = zext i256 %r78 to i288
%r80 = zext i256 %r72 to i288
%r81 = add i288 %r79, %r80
%r82 = lshr i288 %r81, 32
%r83 = trunc i288 %r82 to i256
%r84 = lshr i256 %r83, 224
%r85 = trunc i256 %r84 to i32
%r86 = trunc i256 %r83 to i224
%r87 = trunc i224 %r86 to i32
%r88 = mul i32 %r87, %r5
%r89 = call i256 @mulPv224x32(i32* %r3, i32 %r88)
%r90 = zext i32 %r85 to i256
%r91 = shl i256 %r90, 224
%r92 = add i256 %r89, %r91
%r93 = getelementptr i32, i32* %r2, i32 11
%r94 = load i32, i32* %r93
%r95 = zext i224 %r86 to i256
%r96 = zext i32 %r94 to i256
%r97 = shl i256 %r96, 224
%r98 = or i256 %r95, %r97
%r99 = zext i256 %r98 to i288
%r100 = zext i256 %r92 to i288
%r101 = add i288 %r99, %r100
%r102 = lshr i288 %r101, 32
%r103 = trunc i288 %r102 to i256
%r104 = lshr i256 %r103, 224
%r105 = trunc i256 %r104 to i32
%r106 = trunc i256 %r103 to i224
%r107 = trunc i224 %r106 to i32
%r108 = mul i32 %r107, %r5
%r109 = call i256 @mulPv224x32(i32* %r3, i32 %r108)
%r110 = zext i32 %r105 to i256
%r111 = shl i256 %r110, 224
%r112 = add i256 %r109, %r111
%r113 = getelementptr i32, i32* %r2, i32 12
%r114 = load i32, i32* %r113
%r115 = zext i224 %r106 to i256
%r116 = zext i32 %r114 to i256
%r117 = shl i256 %r116, 224
%r118 = or i256 %r115, %r117
%r119 = zext i256 %r118 to i288
%r120 = zext i256 %r112 to i288
%r121 = add i288 %r119, %r120
%r122 = lshr i288 %r121, 32
%r123 = trunc i288 %r122 to i256
%r124 = lshr i256 %r123, 224
%r125 = trunc i256 %r124 to i32
%r126 = trunc i256 %r123 to i224
%r127 = trunc i224 %r126 to i32
%r128 = mul i32 %r127, %r5
%r129 = call i256 @mulPv224x32(i32* %r3, i32 %r128)
%r130 = zext i32 %r125 to i256
%r131 = shl i256 %r130, 224
%r132 = add i256 %r129, %r131
%r133 = getelementptr i32, i32* %r2, i32 13
%r134 = load i32, i32* %r133
%r135 = zext i224 %r126 to i256
%r136 = zext i32 %r134 to i256
%r137 = shl i256 %r136, 224
%r138 = or i256 %r135, %r137
%r139 = zext i256 %r138 to i288
%r140 = zext i256 %r132 to i288
%r141 = add i288 %r139, %r140
%r142 = lshr i288 %r141, 32
%r143 = trunc i288 %r142 to i256
%r144 = lshr i256 %r143, 224
%r145 = trunc i256 %r144 to i32
%r146 = trunc i256 %r143 to i224
%r147 = sub i224 %r146, %r7
%r148 = lshr i224 %r147, 223
%r149 = trunc i224 %r148 to i1
%r150 = select i1 %r149, i224 %r146, i224 %r147
%r151 = bitcast i32* %r1 to i224*
store i224 %r150, i224* %r151
ret void
}
define i32 @mcl_fp_addPre7L(i32* noalias %r1, i32* noalias %r2, i32* noalias %r3)
{
%r5 = bitcast i32* %r2 to i224*
%r6 = load i224, i224* %r5
%r7 = zext i224 %r6 to i256
%r8 = bitcast i32* %r3 to i224*
%r9 = load i224, i224* %r8
%r10 = zext i224 %r9 to i256
%r11 = add i256 %r7, %r10
%r12 = trunc i256 %r11 to i224
%r13 = bitcast i32* %r1 to i224*
store i224 %r12, i224* %r13
%r14 = lshr i256 %r11, 224
%r15 = trunc i256 %r14 to i32
ret i32 %r15
}
define i32 @mcl_fp_subPre7L(i32* noalias %r1, i32* noalias %r2, i32* noalias %r3)
{
%r5 = bitcast i32* %r2 to i224*
%r6 = load i224, i224* %r5
%r7 = zext i224 %r6 to i256
%r8 = bitcast i32* %r3 to i224*
%r9 = load i224, i224* %r8
%r10 = zext i224 %r9 to i256
%r11 = sub i256 %r7, %r10
%r12 = trunc i256 %r11 to i224
%r13 = bitcast i32* %r1 to i224*
store i224 %r12, i224* %r13
%r14 = lshr i256 %r11, 224
%r15 = trunc i256 %r14 to i32
%r16 = and i32 %r15, 1
ret i32 %r16
}
define void @mcl_fp_shr1_7L(i32* noalias %r1, i32* noalias %r2)
{
%r3 = bitcast i32* %r2 to i224*
%r4 = load i224, i224* %r3
%r5 = lshr i224 %r4, 1
%r6 = bitcast i32* %r1 to i224*
store i224 %r5, i224* %r6
ret void
}
define void @mcl_fp_add7L(i32* noalias %r1, i32* noalias %r2, i32* noalias %r3, i32* noalias %r4)
{
%r5 = bitcast i32* %r2 to i224*
%r6 = load i224, i224* %r5
%r7 = bitcast i32* %r3 to i224*
%r8 = load i224, i224* %r7
%r9 = bitcast i32* %r4 to i224*
%r10 = load i224, i224* %r9
%r11 = zext i224 %r6 to i256
%r12 = zext i224 %r8 to i256
%r13 = add i256 %r11, %r12
%r14 = zext i224 %r10 to i256
%r15 = sub i256 %r13, %r14
%r16 = lshr i256 %r15, 224
%r17 = trunc i256 %r16 to i1
%r18 = select i1 %r17, i256 %r13, i256 %r15
%r19 = trunc i256 %r18 to i224
%r20 = bitcast i32* %r1 to i224*
store i224 %r19, i224* %r20
ret void
}
define void @mcl_fp_addNF7L(i32* noalias %r1, i32* noalias %r2, i32* noalias %r3, i32* noalias %r4)
{
%r5 = bitcast i32* %r2 to i224*
%r6 = load i224, i224* %r5
%r7 = bitcast i32* %r3 to i224*
%r8 = load i224, i224* %r7
%r9 = bitcast i32* %r4 to i224*
%r10 = load i224, i224* %r9
%r11 = add i224 %r6, %r8
%r12 = sub i224 %r11, %r10
%r13 = lshr i224 %r12, 223
%r14 = trunc i224 %r13 to i1
%r15 = select i1 %r14, i224 %r11, i224 %r12
%r16 = bitcast i32* %r1 to i224*
store i224 %r15, i224* %r16
ret void
}
define void @mcl_fp_sub7L(i32* noalias %r1, i32* noalias %r2, i32* noalias %r3, i32* noalias %r4)
{
%r5 = bitcast i32* %r2 to i224*
%r6 = load i224, i224* %r5
%r7 = bitcast i32* %r3 to i224*
%r8 = load i224, i224* %r7
%r9 = zext i224 %r6 to i256
%r10 = zext i224 %r8 to i256
%r11 = sub i256 %r9, %r10
%r12 = lshr i256 %r11, 224
%r13 = trunc i256 %r12 to i1
%r14 = trunc i256 %r11 to i224
%r15 = bitcast i32* %r4 to i224*
%r16 = load i224, i224* %r15
%r17 = select i1 %r13, i224 %r16, i224 0
%r18 = add i224 %r14, %r17
%r19 = bitcast i32* %r1 to i224*
store i224 %r18, i224* %r19
ret void
}
define void @mcl_fp_subNF7L(i32* noalias %r1, i32* noalias %r2, i32* noalias %r3, i32* noalias %r4)
{
%r5 = bitcast i32* %r2 to i224*
%r6 = load i224, i224* %r5
%r7 = bitcast i32* %r3 to i224*
%r8 = load i224, i224* %r7
%r9 = sub i224 %r6, %r8
%r10 = lshr i224 %r9, 223
%r11 = trunc i224 %r10 to i1
%r12 = bitcast i32* %r4 to i224*
%r13 = load i224, i224* %r12
%r14 = select i1 %r11, i224 %r13, i224 0
%r15 = add i224 %r9, %r14
%r16 = bitcast i32* %r1 to i224*
store i224 %r15, i224* %r16
ret void
}
define void @mcl_fpDbl_add7L(i32* noalias %r1, i32* noalias %r2, i32* noalias %r3, i32* noalias %r4)
{
%r5 = bitcast i32* %r2 to i448*
%r6 = load i448, i448* %r5
%r7 = bitcast i32* %r3 to i448*
%r8 = load i448, i448* %r7
%r9 = zext i448 %r6 to i480
%r10 = zext i448 %r8 to i480
%r11 = add i480 %r9, %r10
%r12 = trunc i480 %r11 to i224
%r13 = bitcast i32* %r1 to i224*
store i224 %r12, i224* %r13
%r14 = lshr i480 %r11, 224
%r15 = trunc i480 %r14 to i256
%r16 = bitcast i32* %r4 to i224*
%r17 = load i224, i224* %r16
%r18 = zext i224 %r17 to i256
%r19 = sub i256 %r15, %r18
%r20 = lshr i256 %r19, 224
%r21 = trunc i256 %r20 to i1
%r22 = select i1 %r21, i256 %r15, i256 %r19
%r23 = trunc i256 %r22 to i224
%r24 = getelementptr i32, i32* %r1, i32 7
%r25 = bitcast i32* %r24 to i224*
store i224 %r23, i224* %r25
ret void
}
define void @mcl_fpDbl_sub7L(i32* noalias %r1, i32* noalias %r2, i32* noalias %r3, i32* noalias %r4)
{
%r5 = bitcast i32* %r2 to i448*
%r6 = load i448, i448* %r5
%r7 = bitcast i32* %r3 to i448*
%r8 = load i448, i448* %r7
%r9 = zext i448 %r6 to i480
%r10 = zext i448 %r8 to i480
%r11 = sub i480 %r9, %r10
%r12 = trunc i480 %r11 to i224
%r13 = bitcast i32* %r1 to i224*
store i224 %r12, i224* %r13
%r14 = lshr i480 %r11, 224
%r15 = trunc i480 %r14 to i224
%r16 = lshr i480 %r11, 448
%r17 = trunc i480 %r16 to i1
%r18 = bitcast i32* %r4 to i224*
%r19 = load i224, i224* %r18
%r20 = select i1 %r17, i224 %r19, i224 0
%r21 = add i224 %r15, %r20
%r22 = getelementptr i32, i32* %r1, i32 7
%r23 = bitcast i32* %r22 to i224*
store i224 %r21, i224* %r23
ret void
}
define i288 @mulPv256x32(i32* noalias %r2, i32 %r3)
{
%r4 = call i64 @mulPos32x32(i32* %r2, i32 %r3, i32 0)
%r5 = trunc i64 %r4 to i32
%r6 = call i32 @extractHigh32(i64 %r4)
%r7 = call i64 @mulPos32x32(i32* %r2, i32 %r3, i32 1)
%r8 = trunc i64 %r7 to i32
%r9 = call i32 @extractHigh32(i64 %r7)
%r10 = call i64 @mulPos32x32(i32* %r2, i32 %r3, i32 2)
%r11 = trunc i64 %r10 to i32
%r12 = call i32 @extractHigh32(i64 %r10)
%r13 = call i64 @mulPos32x32(i32* %r2, i32 %r3, i32 3)
%r14 = trunc i64 %r13 to i32
%r15 = call i32 @extractHigh32(i64 %r13)
%r16 = call i64 @mulPos32x32(i32* %r2, i32 %r3, i32 4)
%r17 = trunc i64 %r16 to i32
%r18 = call i32 @extractHigh32(i64 %r16)
%r19 = call i64 @mulPos32x32(i32* %r2, i32 %r3, i32 5)
%r20 = trunc i64 %r19 to i32
%r21 = call i32 @extractHigh32(i64 %r19)
%r22 = call i64 @mulPos32x32(i32* %r2, i32 %r3, i32 6)
%r23 = trunc i64 %r22 to i32
%r24 = call i32 @extractHigh32(i64 %r22)
%r25 = call i64 @mulPos32x32(i32* %r2, i32 %r3, i32 7)
%r26 = trunc i64 %r25 to i32
%r27 = call i32 @extractHigh32(i64 %r25)
%r28 = zext i32 %r5 to i64
%r29 = zext i32 %r8 to i64
%r30 = shl i64 %r29, 32
%r31 = or i64 %r28, %r30
%r32 = zext i64 %r31 to i96
%r33 = zext i32 %r11 to i96
%r34 = shl i96 %r33, 64
%r35 = or i96 %r32, %r34
%r36 = zext i96 %r35 to i128
%r37 = zext i32 %r14 to i128
%r38 = shl i128 %r37, 96
%r39 = or i128 %r36, %r38
%r40 = zext i128 %r39 to i160
%r41 = zext i32 %r17 to i160
%r42 = shl i160 %r41, 128
%r43 = or i160 %r40, %r42
%r44 = zext i160 %r43 to i192
%r45 = zext i32 %r20 to i192
%r46 = shl i192 %r45, 160
%r47 = or i192 %r44, %r46
%r48 = zext i192 %r47 to i224
%r49 = zext i32 %r23 to i224
%r50 = shl i224 %r49, 192
%r51 = or i224 %r48, %r50
%r52 = zext i224 %r51 to i256
%r53 = zext i32 %r26 to i256
%r54 = shl i256 %r53, 224
%r55 = or i256 %r52, %r54
%r56 = zext i32 %r6 to i64
%r57 = zext i32 %r9 to i64
%r58 = shl i64 %r57, 32
%r59 = or i64 %r56, %r58
%r60 = zext i64 %r59 to i96
%r61 = zext i32 %r12 to i96
%r62 = shl i96 %r61, 64
%r63 = or i96 %r60, %r62
%r64 = zext i96 %r63 to i128
%r65 = zext i32 %r15 to i128
%r66 = shl i128 %r65, 96
%r67 = or i128 %r64, %r66
%r68 = zext i128 %r67 to i160
%r69 = zext i32 %r18 to i160
%r70 = shl i160 %r69, 128
%r71 = or i160 %r68, %r70
%r72 = zext i160 %r71 to i192
%r73 = zext i32 %r21 to i192
%r74 = shl i192 %r73, 160
%r75 = or i192 %r72, %r74
%r76 = zext i192 %r75 to i224
%r77 = zext i32 %r24 to i224
%r78 = shl i224 %r77, 192
%r79 = or i224 %r76, %r78
%r80 = zext i224 %r79 to i256
%r81 = zext i32 %r27 to i256
%r82 = shl i256 %r81, 224
%r83 = or i256 %r80, %r82
%r84 = zext i256 %r55 to i288
%r85 = zext i256 %r83 to i288
%r86 = shl i288 %r85, 32
%r87 = add i288 %r84, %r86
ret i288 %r87
}
define void @mcl_fp_mont8L(i32* %r1, i32* %r2, i32* %r3, i32* %r4)
{
%r5 = getelementptr i32, i32* %r4, i32 -1
%r6 = load i32, i32* %r5
%r7 = getelementptr i32, i32* %r3, i32 0
%r8 = load i32, i32* %r7
%r9 = call i288 @mulPv256x32(i32* %r2, i32 %r8)
%r10 = zext i288 %r9 to i320
%r11 = trunc i288 %r9 to i32
%r12 = mul i32 %r11, %r6
%r13 = call i288 @mulPv256x32(i32* %r4, i32 %r12)
%r14 = zext i288 %r13 to i320
%r15 = add i320 %r10, %r14
%r16 = lshr i320 %r15, 32
%r17 = getelementptr i32, i32* %r3, i32 1
%r18 = load i32, i32* %r17
%r19 = call i288 @mulPv256x32(i32* %r2, i32 %r18)
%r20 = zext i288 %r19 to i320
%r21 = add i320 %r16, %r20
%r22 = trunc i320 %r21 to i32
%r23 = mul i32 %r22, %r6
%r24 = call i288 @mulPv256x32(i32* %r4, i32 %r23)
%r25 = zext i288 %r24 to i320
%r26 = add i320 %r21, %r25
%r27 = lshr i320 %r26, 32
%r28 = getelementptr i32, i32* %r3, i32 2
%r29 = load i32, i32* %r28
%r30 = call i288 @mulPv256x32(i32* %r2, i32 %r29)
%r31 = zext i288 %r30 to i320
%r32 = add i320 %r27, %r31
%r33 = trunc i320 %r32 to i32
%r34 = mul i32 %r33, %r6
%r35 = call i288 @mulPv256x32(i32* %r4, i32 %r34)
%r36 = zext i288 %r35 to i320
%r37 = add i320 %r32, %r36
%r38 = lshr i320 %r37, 32
%r39 = getelementptr i32, i32* %r3, i32 3
%r40 = load i32, i32* %r39
%r41 = call i288 @mulPv256x32(i32* %r2, i32 %r40)
%r42 = zext i288 %r41 to i320
%r43 = add i320 %r38, %r42
%r44 = trunc i320 %r43 to i32
%r45 = mul i32 %r44, %r6
%r46 = call i288 @mulPv256x32(i32* %r4, i32 %r45)
%r47 = zext i288 %r46 to i320
%r48 = add i320 %r43, %r47
%r49 = lshr i320 %r48, 32
%r50 = getelementptr i32, i32* %r3, i32 4
%r51 = load i32, i32* %r50
%r52 = call i288 @mulPv256x32(i32* %r2, i32 %r51)
%r53 = zext i288 %r52 to i320
%r54 = add i320 %r49, %r53
%r55 = trunc i320 %r54 to i32
%r56 = mul i32 %r55, %r6
%r57 = call i288 @mulPv256x32(i32* %r4, i32 %r56)
%r58 = zext i288 %r57 to i320
%r59 = add i320 %r54, %r58
%r60 = lshr i320 %r59, 32
%r61 = getelementptr i32, i32* %r3, i32 5
%r62 = load i32, i32* %r61
%r63 = call i288 @mulPv256x32(i32* %r2, i32 %r62)
%r64 = zext i288 %r63 to i320
%r65 = add i320 %r60, %r64
%r66 = trunc i320 %r65 to i32
%r67 = mul i32 %r66, %r6
%r68 = call i288 @mulPv256x32(i32* %r4, i32 %r67)
%r69 = zext i288 %r68 to i320
%r70 = add i320 %r65, %r69
%r71 = lshr i320 %r70, 32
%r72 = getelementptr i32, i32* %r3, i32 6
%r73 = load i32, i32* %r72
%r74 = call i288 @mulPv256x32(i32* %r2, i32 %r73)
%r75 = zext i288 %r74 to i320
%r76 = add i320 %r71, %r75
%r77 = trunc i320 %r76 to i32
%r78 = mul i32 %r77, %r6
%r79 = call i288 @mulPv256x32(i32* %r4, i32 %r78)
%r80 = zext i288 %r79 to i320
%r81 = add i320 %r76, %r80
%r82 = lshr i320 %r81, 32
%r83 = getelementptr i32, i32* %r3, i32 7
%r84 = load i32, i32* %r83
%r85 = call i288 @mulPv256x32(i32* %r2, i32 %r84)
%r86 = zext i288 %r85 to i320
%r87 = add i320 %r82, %r86
%r88 = trunc i320 %r87 to i32
%r89 = mul i32 %r88, %r6
%r90 = call i288 @mulPv256x32(i32* %r4, i32 %r89)
%r91 = zext i288 %r90 to i320
%r92 = add i320 %r87, %r91
%r93 = lshr i320 %r92, 32
%r94 = trunc i320 %r93 to i288
%r95 = bitcast i32* %r4 to i256*
%r96 = load i256, i256* %r95
%r97 = zext i256 %r96 to i288
%r98 = sub i288 %r94, %r97
%r99 = lshr i288 %r98, 256
%r100 = trunc i288 %r99 to i1
%r101 = select i1 %r100, i288 %r94, i288 %r98
%r102 = trunc i288 %r101 to i256
%r103 = bitcast i32* %r1 to i256*
store i256 %r102, i256* %r103
ret void
}
define void @mcl_fp_montNF8L(i32* %r1, i32* %r2, i32* %r3, i32* %r4)
{
%r5 = getelementptr i32, i32* %r4, i32 -1
%r6 = load i32, i32* %r5
%r7 = load i32, i32* %r3
%r8 = call i288 @mulPv256x32(i32* %r2, i32 %r7)
%r9 = trunc i288 %r8 to i32
%r10 = mul i32 %r9, %r6
%r11 = call i288 @mulPv256x32(i32* %r4, i32 %r10)
%r12 = add i288 %r8, %r11
%r13 = lshr i288 %r12, 32
%r14 = getelementptr i32, i32* %r3, i32 1
%r15 = load i32, i32* %r14
%r16 = call i288 @mulPv256x32(i32* %r2, i32 %r15)
%r17 = add i288 %r13, %r16
%r18 = trunc i288 %r17 to i32
%r19 = mul i32 %r18, %r6
%r20 = call i288 @mulPv256x32(i32* %r4, i32 %r19)
%r21 = add i288 %r17, %r20
%r22 = lshr i288 %r21, 32
%r23 = getelementptr i32, i32* %r3, i32 2
%r24 = load i32, i32* %r23
%r25 = call i288 @mulPv256x32(i32* %r2, i32 %r24)
%r26 = add i288 %r22, %r25
%r27 = trunc i288 %r26 to i32
%r28 = mul i32 %r27, %r6
%r29 = call i288 @mulPv256x32(i32* %r4, i32 %r28)
%r30 = add i288 %r26, %r29
%r31 = lshr i288 %r30, 32
%r32 = getelementptr i32, i32* %r3, i32 3
%r33 = load i32, i32* %r32
%r34 = call i288 @mulPv256x32(i32* %r2, i32 %r33)
%r35 = add i288 %r31, %r34
%r36 = trunc i288 %r35 to i32
%r37 = mul i32 %r36, %r6
%r38 = call i288 @mulPv256x32(i32* %r4, i32 %r37)
%r39 = add i288 %r35, %r38
%r40 = lshr i288 %r39, 32
%r41 = getelementptr i32, i32* %r3, i32 4
%r42 = load i32, i32* %r41
%r43 = call i288 @mulPv256x32(i32* %r2, i32 %r42)
%r44 = add i288 %r40, %r43
%r45 = trunc i288 %r44 to i32
%r46 = mul i32 %r45, %r6
%r47 = call i288 @mulPv256x32(i32* %r4, i32 %r46)
%r48 = add i288 %r44, %r47
%r49 = lshr i288 %r48, 32
%r50 = getelementptr i32, i32* %r3, i32 5
%r51 = load i32, i32* %r50
%r52 = call i288 @mulPv256x32(i32* %r2, i32 %r51)
%r53 = add i288 %r49, %r52
%r54 = trunc i288 %r53 to i32
%r55 = mul i32 %r54, %r6
%r56 = call i288 @mulPv256x32(i32* %r4, i32 %r55)
%r57 = add i288 %r53, %r56
%r58 = lshr i288 %r57, 32
%r59 = getelementptr i32, i32* %r3, i32 6
%r60 = load i32, i32* %r59
%r61 = call i288 @mulPv256x32(i32* %r2, i32 %r60)
%r62 = add i288 %r58, %r61
%r63 = trunc i288 %r62 to i32
%r64 = mul i32 %r63, %r6
%r65 = call i288 @mulPv256x32(i32* %r4, i32 %r64)
%r66 = add i288 %r62, %r65
%r67 = lshr i288 %r66, 32
%r68 = getelementptr i32, i32* %r3, i32 7
%r69 = load i32, i32* %r68
%r70 = call i288 @mulPv256x32(i32* %r2, i32 %r69)
%r71 = add i288 %r67, %r70
%r72 = trunc i288 %r71 to i32
%r73 = mul i32 %r72, %r6
%r74 = call i288 @mulPv256x32(i32* %r4, i32 %r73)
%r75 = add i288 %r71, %r74
%r76 = lshr i288 %r75, 32
%r77 = trunc i288 %r76 to i256
%r78 = bitcast i32* %r4 to i256*
%r79 = load i256, i256* %r78
%r80 = sub i256 %r77, %r79
%r81 = lshr i256 %r80, 255
%r82 = trunc i256 %r81 to i1
%r83 = select i1 %r82, i256 %r77, i256 %r80
%r84 = bitcast i32* %r1 to i256*
store i256 %r83, i256* %r84
ret void
}
define void @mcl_fp_montRed8L(i32* noalias %r1, i32* noalias %r2, i32* noalias %r3)
{
%r4 = getelementptr i32, i32* %r3, i32 -1
%r5 = load i32, i32* %r4
%r6 = bitcast i32* %r3 to i256*
%r7 = load i256, i256* %r6
%r8 = bitcast i32* %r2 to i256*
%r9 = load i256, i256* %r8
%r10 = trunc i256 %r9 to i32
%r11 = mul i32 %r10, %r5
%r12 = call i288 @mulPv256x32(i32* %r3, i32 %r11)
%r13 = getelementptr i32, i32* %r2, i32 8
%r14 = load i32, i32* %r13
%r15 = zext i256 %r9 to i288
%r16 = zext i32 %r14 to i288
%r17 = shl i288 %r16, 256
%r18 = or i288 %r15, %r17
%r19 = zext i288 %r18 to i320
%r20 = zext i288 %r12 to i320
%r21 = add i320 %r19, %r20
%r22 = lshr i320 %r21, 32
%r23 = trunc i320 %r22 to i288
%r24 = lshr i288 %r23, 256
%r25 = trunc i288 %r24 to i32
%r26 = trunc i288 %r23 to i256
%r27 = trunc i256 %r26 to i32
%r28 = mul i32 %r27, %r5
%r29 = call i288 @mulPv256x32(i32* %r3, i32 %r28)
%r30 = zext i32 %r25 to i288
%r31 = shl i288 %r30, 256
%r32 = add i288 %r29, %r31
%r33 = getelementptr i32, i32* %r2, i32 9
%r34 = load i32, i32* %r33
%r35 = zext i256 %r26 to i288
%r36 = zext i32 %r34 to i288
%r37 = shl i288 %r36, 256
%r38 = or i288 %r35, %r37
%r39 = zext i288 %r38 to i320
%r40 = zext i288 %r32 to i320
%r41 = add i320 %r39, %r40
%r42 = lshr i320 %r41, 32
%r43 = trunc i320 %r42 to i288
%r44 = lshr i288 %r43, 256
%r45 = trunc i288 %r44 to i32
%r46 = trunc i288 %r43 to i256
%r47 = trunc i256 %r46 to i32
%r48 = mul i32 %r47, %r5
%r49 = call i288 @mulPv256x32(i32* %r3, i32 %r48)
%r50 = zext i32 %r45 to i288
%r51 = shl i288 %r50, 256
%r52 = add i288 %r49, %r51
%r53 = getelementptr i32, i32* %r2, i32 10
%r54 = load i32, i32* %r53
%r55 = zext i256 %r46 to i288
%r56 = zext i32 %r54 to i288
%r57 = shl i288 %r56, 256
%r58 = or i288 %r55, %r57
%r59 = zext i288 %r58 to i320
%r60 = zext i288 %r52 to i320
%r61 = add i320 %r59, %r60
%r62 = lshr i320 %r61, 32
%r63 = trunc i320 %r62 to i288
%r64 = lshr i288 %r63, 256
%r65 = trunc i288 %r64 to i32
%r66 = trunc i288 %r63 to i256
%r67 = trunc i256 %r66 to i32
%r68 = mul i32 %r67, %r5
%r69 = call i288 @mulPv256x32(i32* %r3, i32 %r68)
%r70 = zext i32 %r65 to i288
%r71 = shl i288 %r70, 256
%r72 = add i288 %r69, %r71
%r73 = getelementptr i32, i32* %r2, i32 11
%r74 = load i32, i32* %r73
%r75 = zext i256 %r66 to i288
%r76 = zext i32 %r74 to i288
%r77 = shl i288 %r76, 256
%r78 = or i288 %r75, %r77
%r79 = zext i288 %r78 to i320
%r80 = zext i288 %r72 to i320
%r81 = add i320 %r79, %r80
%r82 = lshr i320 %r81, 32
%r83 = trunc i320 %r82 to i288
%r84 = lshr i288 %r83, 256
%r85 = trunc i288 %r84 to i32
%r86 = trunc i288 %r83 to i256
%r87 = trunc i256 %r86 to i32
%r88 = mul i32 %r87, %r5
%r89 = call i288 @mulPv256x32(i32* %r3, i32 %r88)
%r90 = zext i32 %r85 to i288
%r91 = shl i288 %r90, 256
%r92 = add i288 %r89, %r91
%r93 = getelementptr i32, i32* %r2, i32 12
%r94 = load i32, i32* %r93
%r95 = zext i256 %r86 to i288
%r96 = zext i32 %r94 to i288
%r97 = shl i288 %r96, 256
%r98 = or i288 %r95, %r97
%r99 = zext i288 %r98 to i320
%r100 = zext i288 %r92 to i320
%r101 = add i320 %r99, %r100
%r102 = lshr i320 %r101, 32
%r103 = trunc i320 %r102 to i288
%r104 = lshr i288 %r103, 256
%r105 = trunc i288 %r104 to i32
%r106 = trunc i288 %r103 to i256
%r107 = trunc i256 %r106 to i32
%r108 = mul i32 %r107, %r5
%r109 = call i288 @mulPv256x32(i32* %r3, i32 %r108)
%r110 = zext i32 %r105 to i288
%r111 = shl i288 %r110, 256
%r112 = add i288 %r109, %r111
%r113 = getelementptr i32, i32* %r2, i32 13
%r114 = load i32, i32* %r113
%r115 = zext i256 %r106 to i288
%r116 = zext i32 %r114 to i288
%r117 = shl i288 %r116, 256
%r118 = or i288 %r115, %r117
%r119 = zext i288 %r118 to i320
%r120 = zext i288 %r112 to i320
%r121 = add i320 %r119, %r120
%r122 = lshr i320 %r121, 32
%r123 = trunc i320 %r122 to i288
%r124 = lshr i288 %r123, 256
%r125 = trunc i288 %r124 to i32
%r126 = trunc i288 %r123 to i256
%r127 = trunc i256 %r126 to i32
%r128 = mul i32 %r127, %r5
%r129 = call i288 @mulPv256x32(i32* %r3, i32 %r128)
%r130 = zext i32 %r125 to i288
%r131 = shl i288 %r130, 256
%r132 = add i288 %r129, %r131
%r133 = getelementptr i32, i32* %r2, i32 14
%r134 = load i32, i32* %r133
%r135 = zext i256 %r126 to i288
%r136 = zext i32 %r134 to i288
%r137 = shl i288 %r136, 256
%r138 = or i288 %r135, %r137
%r139 = zext i288 %r138 to i320
%r140 = zext i288 %r132 to i320
%r141 = add i320 %r139, %r140
%r142 = lshr i320 %r141, 32
%r143 = trunc i320 %r142 to i288
%r144 = lshr i288 %r143, 256
%r145 = trunc i288 %r144 to i32
%r146 = trunc i288 %r143 to i256
%r147 = trunc i256 %r146 to i32
%r148 = mul i32 %r147, %r5
%r149 = call i288 @mulPv256x32(i32* %r3, i32 %r148)
%r150 = zext i32 %r145 to i288
%r151 = shl i288 %r150, 256
%r152 = add i288 %r149, %r151
%r153 = getelementptr i32, i32* %r2, i32 15
%r154 = load i32, i32* %r153
%r155 = zext i256 %r146 to i288
%r156 = zext i32 %r154 to i288
%r157 = shl i288 %r156, 256
%r158 = or i288 %r155, %r157
%r159 = zext i288 %r158 to i320
%r160 = zext i288 %r152 to i320
%r161 = add i320 %r159, %r160
%r162 = lshr i320 %r161, 32
%r163 = trunc i320 %r162 to i288
%r164 = lshr i288 %r163, 256
%r165 = trunc i288 %r164 to i32
%r166 = trunc i288 %r163 to i256
%r167 = zext i256 %r7 to i288
%r168 = zext i256 %r166 to i288
%r169 = zext i32 %r165 to i288
%r170 = shl i288 %r169, 256
%r171 = or i288 %r168, %r170
%r172 = sub i288 %r171, %r167
%r173 = lshr i288 %r172, 256
%r174 = trunc i288 %r173 to i1
%r175 = select i1 %r174, i288 %r171, i288 %r172
%r176 = trunc i288 %r175 to i256
%r177 = bitcast i32* %r1 to i256*
store i256 %r176, i256* %r177
ret void
}
define void @mcl_fp_montRedNF8L(i32* noalias %r1, i32* noalias %r2, i32* noalias %r3)
{
%r4 = getelementptr i32, i32* %r3, i32 -1
%r5 = load i32, i32* %r4
%r6 = bitcast i32* %r3 to i256*
%r7 = load i256, i256* %r6
%r8 = bitcast i32* %r2 to i256*
%r9 = load i256, i256* %r8
%r10 = trunc i256 %r9 to i32
%r11 = mul i32 %r10, %r5
%r12 = call i288 @mulPv256x32(i32* %r3, i32 %r11)
%r13 = getelementptr i32, i32* %r2, i32 8
%r14 = load i32, i32* %r13
%r15 = zext i256 %r9 to i288
%r16 = zext i32 %r14 to i288
%r17 = shl i288 %r16, 256
%r18 = or i288 %r15, %r17
%r19 = zext i288 %r18 to i320
%r20 = zext i288 %r12 to i320
%r21 = add i320 %r19, %r20
%r22 = lshr i320 %r21, 32
%r23 = trunc i320 %r22 to i288
%r24 = lshr i288 %r23, 256
%r25 = trunc i288 %r24 to i32
%r26 = trunc i288 %r23 to i256
%r27 = trunc i256 %r26 to i32
%r28 = mul i32 %r27, %r5
%r29 = call i288 @mulPv256x32(i32* %r3, i32 %r28)
%r30 = zext i32 %r25 to i288
%r31 = shl i288 %r30, 256
%r32 = add i288 %r29, %r31
%r33 = getelementptr i32, i32* %r2, i32 9
%r34 = load i32, i32* %r33
%r35 = zext i256 %r26 to i288
%r36 = zext i32 %r34 to i288
%r37 = shl i288 %r36, 256
%r38 = or i288 %r35, %r37
%r39 = zext i288 %r38 to i320
%r40 = zext i288 %r32 to i320
%r41 = add i320 %r39, %r40
%r42 = lshr i320 %r41, 32
%r43 = trunc i320 %r42 to i288
%r44 = lshr i288 %r43, 256
%r45 = trunc i288 %r44 to i32
%r46 = trunc i288 %r43 to i256
%r47 = trunc i256 %r46 to i32
%r48 = mul i32 %r47, %r5
%r49 = call i288 @mulPv256x32(i32* %r3, i32 %r48)
%r50 = zext i32 %r45 to i288
%r51 = shl i288 %r50, 256
%r52 = add i288 %r49, %r51
%r53 = getelementptr i32, i32* %r2, i32 10
%r54 = load i32, i32* %r53
%r55 = zext i256 %r46 to i288
%r56 = zext i32 %r54 to i288
%r57 = shl i288 %r56, 256
%r58 = or i288 %r55, %r57
%r59 = zext i288 %r58 to i320
%r60 = zext i288 %r52 to i320
%r61 = add i320 %r59, %r60
%r62 = lshr i320 %r61, 32
%r63 = trunc i320 %r62 to i288
%r64 = lshr i288 %r63, 256
%r65 = trunc i288 %r64 to i32
%r66 = trunc i288 %r63 to i256
%r67 = trunc i256 %r66 to i32
%r68 = mul i32 %r67, %r5
%r69 = call i288 @mulPv256x32(i32* %r3, i32 %r68)
%r70 = zext i32 %r65 to i288
%r71 = shl i288 %r70, 256
%r72 = add i288 %r69, %r71
%r73 = getelementptr i32, i32* %r2, i32 11
%r74 = load i32, i32* %r73
%r75 = zext i256 %r66 to i288
%r76 = zext i32 %r74 to i288
%r77 = shl i288 %r76, 256
%r78 = or i288 %r75, %r77
%r79 = zext i288 %r78 to i320
%r80 = zext i288 %r72 to i320
%r81 = add i320 %r79, %r80
%r82 = lshr i320 %r81, 32
%r83 = trunc i320 %r82 to i288
%r84 = lshr i288 %r83, 256
%r85 = trunc i288 %r84 to i32
%r86 = trunc i288 %r83 to i256
%r87 = trunc i256 %r86 to i32
%r88 = mul i32 %r87, %r5
%r89 = call i288 @mulPv256x32(i32* %r3, i32 %r88)
%r90 = zext i32 %r85 to i288
%r91 = shl i288 %r90, 256
%r92 = add i288 %r89, %r91
%r93 = getelementptr i32, i32* %r2, i32 12
%r94 = load i32, i32* %r93
%r95 = zext i256 %r86 to i288
%r96 = zext i32 %r94 to i288
%r97 = shl i288 %r96, 256
%r98 = or i288 %r95, %r97
%r99 = zext i288 %r98 to i320
%r100 = zext i288 %r92 to i320
%r101 = add i320 %r99, %r100
%r102 = lshr i320 %r101, 32
%r103 = trunc i320 %r102 to i288
%r104 = lshr i288 %r103, 256
%r105 = trunc i288 %r104 to i32
%r106 = trunc i288 %r103 to i256
%r107 = trunc i256 %r106 to i32
%r108 = mul i32 %r107, %r5
%r109 = call i288 @mulPv256x32(i32* %r3, i32 %r108)
%r110 = zext i32 %r105 to i288
%r111 = shl i288 %r110, 256
%r112 = add i288 %r109, %r111
%r113 = getelementptr i32, i32* %r2, i32 13
%r114 = load i32, i32* %r113
%r115 = zext i256 %r106 to i288
%r116 = zext i32 %r114 to i288
%r117 = shl i288 %r116, 256
%r118 = or i288 %r115, %r117
%r119 = zext i288 %r118 to i320
%r120 = zext i288 %r112 to i320
%r121 = add i320 %r119, %r120
%r122 = lshr i320 %r121, 32
%r123 = trunc i320 %r122 to i288
%r124 = lshr i288 %r123, 256
%r125 = trunc i288 %r124 to i32
%r126 = trunc i288 %r123 to i256
%r127 = trunc i256 %r126 to i32
%r128 = mul i32 %r127, %r5
%r129 = call i288 @mulPv256x32(i32* %r3, i32 %r128)
%r130 = zext i32 %r125 to i288
%r131 = shl i288 %r130, 256
%r132 = add i288 %r129, %r131
%r133 = getelementptr i32, i32* %r2, i32 14
%r134 = load i32, i32* %r133
%r135 = zext i256 %r126 to i288
%r136 = zext i32 %r134 to i288
%r137 = shl i288 %r136, 256
%r138 = or i288 %r135, %r137
%r139 = zext i288 %r138 to i320
%r140 = zext i288 %r132 to i320
%r141 = add i320 %r139, %r140
%r142 = lshr i320 %r141, 32
%r143 = trunc i320 %r142 to i288
%r144 = lshr i288 %r143, 256
%r145 = trunc i288 %r144 to i32
%r146 = trunc i288 %r143 to i256
%r147 = trunc i256 %r146 to i32
%r148 = mul i32 %r147, %r5
%r149 = call i288 @mulPv256x32(i32* %r3, i32 %r148)
%r150 = zext i32 %r145 to i288
%r151 = shl i288 %r150, 256
%r152 = add i288 %r149, %r151
%r153 = getelementptr i32, i32* %r2, i32 15
%r154 = load i32, i32* %r153
%r155 = zext i256 %r146 to i288
%r156 = zext i32 %r154 to i288
%r157 = shl i288 %r156, 256
%r158 = or i288 %r155, %r157
%r159 = zext i288 %r158 to i320
%r160 = zext i288 %r152 to i320
%r161 = add i320 %r159, %r160
%r162 = lshr i320 %r161, 32
%r163 = trunc i320 %r162 to i288
%r164 = lshr i288 %r163, 256
%r165 = trunc i288 %r164 to i32
%r166 = trunc i288 %r163 to i256
%r167 = sub i256 %r166, %r7
%r168 = lshr i256 %r167, 255
%r169 = trunc i256 %r168 to i1
%r170 = select i1 %r169, i256 %r166, i256 %r167
%r171 = bitcast i32* %r1 to i256*
store i256 %r170, i256* %r171
ret void
}
define i32 @mcl_fp_addPre8L(i32* noalias %r1, i32* noalias %r2, i32* noalias %r3)
{
%r5 = bitcast i32* %r2 to i256*
%r6 = load i256, i256* %r5
%r7 = zext i256 %r6 to i288
%r8 = bitcast i32* %r3 to i256*
%r9 = load i256, i256* %r8
%r10 = zext i256 %r9 to i288
%r11 = add i288 %r7, %r10
%r12 = trunc i288 %r11 to i256
%r13 = bitcast i32* %r1 to i256*
store i256 %r12, i256* %r13
%r14 = lshr i288 %r11, 256
%r15 = trunc i288 %r14 to i32
ret i32 %r15
}
define i32 @mcl_fp_subPre8L(i32* noalias %r1, i32* noalias %r2, i32* noalias %r3)
{
%r5 = bitcast i32* %r2 to i256*
%r6 = load i256, i256* %r5
%r7 = zext i256 %r6 to i288
%r8 = bitcast i32* %r3 to i256*
%r9 = load i256, i256* %r8
%r10 = zext i256 %r9 to i288
%r11 = sub i288 %r7, %r10
%r12 = trunc i288 %r11 to i256
%r13 = bitcast i32* %r1 to i256*
store i256 %r12, i256* %r13
%r14 = lshr i288 %r11, 256
%r15 = trunc i288 %r14 to i32
%r16 = and i32 %r15, 1
ret i32 %r16
}
define void @mcl_fp_shr1_8L(i32* noalias %r1, i32* noalias %r2)
{
%r3 = bitcast i32* %r2 to i256*
%r4 = load i256, i256* %r3
%r5 = lshr i256 %r4, 1
%r6 = bitcast i32* %r1 to i256*
store i256 %r5, i256* %r6
ret void
}
define void @mcl_fp_add8L(i32* noalias %r1, i32* noalias %r2, i32* noalias %r3, i32* noalias %r4)
{
%r5 = bitcast i32* %r2 to i256*
%r6 = load i256, i256* %r5
%r7 = bitcast i32* %r3 to i256*
%r8 = load i256, i256* %r7
%r9 = bitcast i32* %r4 to i256*
%r10 = load i256, i256* %r9
%r11 = zext i256 %r6 to i288
%r12 = zext i256 %r8 to i288
%r13 = add i288 %r11, %r12
%r14 = zext i256 %r10 to i288
%r15 = sub i288 %r13, %r14
%r16 = lshr i288 %r15, 256
%r17 = trunc i288 %r16 to i1
%r18 = select i1 %r17, i288 %r13, i288 %r15
%r19 = trunc i288 %r18 to i256
%r20 = bitcast i32* %r1 to i256*
store i256 %r19, i256* %r20
ret void
}
define void @mcl_fp_addNF8L(i32* noalias %r1, i32* noalias %r2, i32* noalias %r3, i32* noalias %r4)
{
%r5 = bitcast i32* %r2 to i256*
%r6 = load i256, i256* %r5
%r7 = bitcast i32* %r3 to i256*
%r8 = load i256, i256* %r7
%r9 = bitcast i32* %r4 to i256*
%r10 = load i256, i256* %r9
%r11 = add i256 %r6, %r8
%r12 = sub i256 %r11, %r10
%r13 = lshr i256 %r12, 255
%r14 = trunc i256 %r13 to i1
%r15 = select i1 %r14, i256 %r11, i256 %r12
%r16 = bitcast i32* %r1 to i256*
store i256 %r15, i256* %r16
ret void
}
define void @mcl_fp_sub8L(i32* noalias %r1, i32* noalias %r2, i32* noalias %r3, i32* noalias %r4)
{
%r5 = bitcast i32* %r2 to i256*
%r6 = load i256, i256* %r5
%r7 = bitcast i32* %r3 to i256*
%r8 = load i256, i256* %r7
%r9 = zext i256 %r6 to i288
%r10 = zext i256 %r8 to i288
%r11 = sub i288 %r9, %r10
%r12 = lshr i288 %r11, 256
%r13 = trunc i288 %r12 to i1
%r14 = trunc i288 %r11 to i256
%r15 = bitcast i32* %r4 to i256*
%r16 = load i256, i256* %r15
%r17 = select i1 %r13, i256 %r16, i256 0
%r18 = add i256 %r14, %r17
%r19 = bitcast i32* %r1 to i256*
store i256 %r18, i256* %r19
ret void
}
define void @mcl_fp_subNF8L(i32* noalias %r1, i32* noalias %r2, i32* noalias %r3, i32* noalias %r4)
{
%r5 = bitcast i32* %r2 to i256*
%r6 = load i256, i256* %r5
%r7 = bitcast i32* %r3 to i256*
%r8 = load i256, i256* %r7
%r9 = sub i256 %r6, %r8
%r10 = lshr i256 %r9, 255
%r11 = trunc i256 %r10 to i1
%r12 = bitcast i32* %r4 to i256*
%r13 = load i256, i256* %r12
%r14 = select i1 %r11, i256 %r13, i256 0
%r15 = add i256 %r9, %r14
%r16 = bitcast i32* %r1 to i256*
store i256 %r15, i256* %r16
ret void
}
define void @mcl_fpDbl_add8L(i32* noalias %r1, i32* noalias %r2, i32* noalias %r3, i32* noalias %r4)
{
%r5 = bitcast i32* %r2 to i512*
%r6 = load i512, i512* %r5
%r7 = bitcast i32* %r3 to i512*
%r8 = load i512, i512* %r7
%r9 = zext i512 %r6 to i544
%r10 = zext i512 %r8 to i544
%r11 = add i544 %r9, %r10
%r12 = trunc i544 %r11 to i256
%r13 = bitcast i32* %r1 to i256*
store i256 %r12, i256* %r13
%r14 = lshr i544 %r11, 256
%r15 = trunc i544 %r14 to i288
%r16 = bitcast i32* %r4 to i256*
%r17 = load i256, i256* %r16
%r18 = zext i256 %r17 to i288
%r19 = sub i288 %r15, %r18
%r20 = lshr i288 %r19, 256
%r21 = trunc i288 %r20 to i1
%r22 = select i1 %r21, i288 %r15, i288 %r19
%r23 = trunc i288 %r22 to i256
%r24 = getelementptr i32, i32* %r1, i32 8
%r25 = bitcast i32* %r24 to i256*
store i256 %r23, i256* %r25
ret void
}
define void @mcl_fpDbl_sub8L(i32* noalias %r1, i32* noalias %r2, i32* noalias %r3, i32* noalias %r4)
{
%r5 = bitcast i32* %r2 to i512*
%r6 = load i512, i512* %r5
%r7 = bitcast i32* %r3 to i512*
%r8 = load i512, i512* %r7
%r9 = zext i512 %r6 to i544
%r10 = zext i512 %r8 to i544
%r11 = sub i544 %r9, %r10
%r12 = trunc i544 %r11 to i256
%r13 = bitcast i32* %r1 to i256*
store i256 %r12, i256* %r13
%r14 = lshr i544 %r11, 256
%r15 = trunc i544 %r14 to i256
%r16 = lshr i544 %r11, 512
%r17 = trunc i544 %r16 to i1
%r18 = bitcast i32* %r4 to i256*
%r19 = load i256, i256* %r18
%r20 = select i1 %r17, i256 %r19, i256 0
%r21 = add i256 %r15, %r20
%r22 = getelementptr i32, i32* %r1, i32 8
%r23 = bitcast i32* %r22 to i256*
store i256 %r21, i256* %r23
ret void
}
define i416 @mulPv384x32(i32* noalias %r2, i32 %r3)
{
%r4 = call i64 @mulPos32x32(i32* %r2, i32 %r3, i32 0)
%r5 = trunc i64 %r4 to i32
%r6 = call i32 @extractHigh32(i64 %r4)
%r7 = call i64 @mulPos32x32(i32* %r2, i32 %r3, i32 1)
%r8 = trunc i64 %r7 to i32
%r9 = call i32 @extractHigh32(i64 %r7)
%r10 = call i64 @mulPos32x32(i32* %r2, i32 %r3, i32 2)
%r11 = trunc i64 %r10 to i32
%r12 = call i32 @extractHigh32(i64 %r10)
%r13 = call i64 @mulPos32x32(i32* %r2, i32 %r3, i32 3)
%r14 = trunc i64 %r13 to i32
%r15 = call i32 @extractHigh32(i64 %r13)
%r16 = call i64 @mulPos32x32(i32* %r2, i32 %r3, i32 4)
%r17 = trunc i64 %r16 to i32
%r18 = call i32 @extractHigh32(i64 %r16)
%r19 = call i64 @mulPos32x32(i32* %r2, i32 %r3, i32 5)
%r20 = trunc i64 %r19 to i32
%r21 = call i32 @extractHigh32(i64 %r19)
%r22 = call i64 @mulPos32x32(i32* %r2, i32 %r3, i32 6)
%r23 = trunc i64 %r22 to i32
%r24 = call i32 @extractHigh32(i64 %r22)
%r25 = call i64 @mulPos32x32(i32* %r2, i32 %r3, i32 7)
%r26 = trunc i64 %r25 to i32
%r27 = call i32 @extractHigh32(i64 %r25)
%r28 = call i64 @mulPos32x32(i32* %r2, i32 %r3, i32 8)
%r29 = trunc i64 %r28 to i32
%r30 = call i32 @extractHigh32(i64 %r28)
%r31 = call i64 @mulPos32x32(i32* %r2, i32 %r3, i32 9)
%r32 = trunc i64 %r31 to i32
%r33 = call i32 @extractHigh32(i64 %r31)
%r34 = call i64 @mulPos32x32(i32* %r2, i32 %r3, i32 10)
%r35 = trunc i64 %r34 to i32
%r36 = call i32 @extractHigh32(i64 %r34)
%r37 = call i64 @mulPos32x32(i32* %r2, i32 %r3, i32 11)
%r38 = trunc i64 %r37 to i32
%r39 = call i32 @extractHigh32(i64 %r37)
%r40 = zext i32 %r5 to i64
%r41 = zext i32 %r8 to i64
%r42 = shl i64 %r41, 32
%r43 = or i64 %r40, %r42
%r44 = zext i64 %r43 to i96
%r45 = zext i32 %r11 to i96
%r46 = shl i96 %r45, 64
%r47 = or i96 %r44, %r46
%r48 = zext i96 %r47 to i128
%r49 = zext i32 %r14 to i128
%r50 = shl i128 %r49, 96
%r51 = or i128 %r48, %r50
%r52 = zext i128 %r51 to i160
%r53 = zext i32 %r17 to i160
%r54 = shl i160 %r53, 128
%r55 = or i160 %r52, %r54
%r56 = zext i160 %r55 to i192
%r57 = zext i32 %r20 to i192
%r58 = shl i192 %r57, 160
%r59 = or i192 %r56, %r58
%r60 = zext i192 %r59 to i224
%r61 = zext i32 %r23 to i224
%r62 = shl i224 %r61, 192
%r63 = or i224 %r60, %r62
%r64 = zext i224 %r63 to i256
%r65 = zext i32 %r26 to i256
%r66 = shl i256 %r65, 224
%r67 = or i256 %r64, %r66
%r68 = zext i256 %r67 to i288
%r69 = zext i32 %r29 to i288
%r70 = shl i288 %r69, 256
%r71 = or i288 %r68, %r70
%r72 = zext i288 %r71 to i320
%r73 = zext i32 %r32 to i320
%r74 = shl i320 %r73, 288
%r75 = or i320 %r72, %r74
%r76 = zext i320 %r75 to i352
%r77 = zext i32 %r35 to i352
%r78 = shl i352 %r77, 320
%r79 = or i352 %r76, %r78
%r80 = zext i352 %r79 to i384
%r81 = zext i32 %r38 to i384
%r82 = shl i384 %r81, 352
%r83 = or i384 %r80, %r82
%r84 = zext i32 %r6 to i64
%r85 = zext i32 %r9 to i64
%r86 = shl i64 %r85, 32
%r87 = or i64 %r84, %r86
%r88 = zext i64 %r87 to i96
%r89 = zext i32 %r12 to i96
%r90 = shl i96 %r89, 64
%r91 = or i96 %r88, %r90
%r92 = zext i96 %r91 to i128
%r93 = zext i32 %r15 to i128
%r94 = shl i128 %r93, 96
%r95 = or i128 %r92, %r94
%r96 = zext i128 %r95 to i160
%r97 = zext i32 %r18 to i160
%r98 = shl i160 %r97, 128
%r99 = or i160 %r96, %r98
%r100 = zext i160 %r99 to i192
%r101 = zext i32 %r21 to i192
%r102 = shl i192 %r101, 160
%r103 = or i192 %r100, %r102
%r104 = zext i192 %r103 to i224
%r105 = zext i32 %r24 to i224
%r106 = shl i224 %r105, 192
%r107 = or i224 %r104, %r106
%r108 = zext i224 %r107 to i256
%r109 = zext i32 %r27 to i256
%r110 = shl i256 %r109, 224
%r111 = or i256 %r108, %r110
%r112 = zext i256 %r111 to i288
%r113 = zext i32 %r30 to i288
%r114 = shl i288 %r113, 256
%r115 = or i288 %r112, %r114
%r116 = zext i288 %r115 to i320
%r117 = zext i32 %r33 to i320
%r118 = shl i320 %r117, 288
%r119 = or i320 %r116, %r118
%r120 = zext i320 %r119 to i352
%r121 = zext i32 %r36 to i352
%r122 = shl i352 %r121, 320
%r123 = or i352 %r120, %r122
%r124 = zext i352 %r123 to i384
%r125 = zext i32 %r39 to i384
%r126 = shl i384 %r125, 352
%r127 = or i384 %r124, %r126
%r128 = zext i384 %r83 to i416
%r129 = zext i384 %r127 to i416
%r130 = shl i416 %r129, 32
%r131 = add i416 %r128, %r130
ret i416 %r131
}
define void @mcl_fp_mont12L(i32* %r1, i32* %r2, i32* %r3, i32* %r4)
{
%r5 = getelementptr i32, i32* %r4, i32 -1
%r6 = load i32, i32* %r5
%r7 = getelementptr i32, i32* %r3, i32 0
%r8 = load i32, i32* %r7
%r9 = call i416 @mulPv384x32(i32* %r2, i32 %r8)
%r10 = zext i416 %r9 to i448
%r11 = trunc i416 %r9 to i32
%r12 = mul i32 %r11, %r6
%r13 = call i416 @mulPv384x32(i32* %r4, i32 %r12)
%r14 = zext i416 %r13 to i448
%r15 = add i448 %r10, %r14
%r16 = lshr i448 %r15, 32
%r17 = getelementptr i32, i32* %r3, i32 1
%r18 = load i32, i32* %r17
%r19 = call i416 @mulPv384x32(i32* %r2, i32 %r18)
%r20 = zext i416 %r19 to i448
%r21 = add i448 %r16, %r20
%r22 = trunc i448 %r21 to i32
%r23 = mul i32 %r22, %r6
%r24 = call i416 @mulPv384x32(i32* %r4, i32 %r23)
%r25 = zext i416 %r24 to i448
%r26 = add i448 %r21, %r25
%r27 = lshr i448 %r26, 32
%r28 = getelementptr i32, i32* %r3, i32 2
%r29 = load i32, i32* %r28
%r30 = call i416 @mulPv384x32(i32* %r2, i32 %r29)
%r31 = zext i416 %r30 to i448
%r32 = add i448 %r27, %r31
%r33 = trunc i448 %r32 to i32
%r34 = mul i32 %r33, %r6
%r35 = call i416 @mulPv384x32(i32* %r4, i32 %r34)
%r36 = zext i416 %r35 to i448
%r37 = add i448 %r32, %r36
%r38 = lshr i448 %r37, 32
%r39 = getelementptr i32, i32* %r3, i32 3
%r40 = load i32, i32* %r39
%r41 = call i416 @mulPv384x32(i32* %r2, i32 %r40)
%r42 = zext i416 %r41 to i448
%r43 = add i448 %r38, %r42
%r44 = trunc i448 %r43 to i32
%r45 = mul i32 %r44, %r6
%r46 = call i416 @mulPv384x32(i32* %r4, i32 %r45)
%r47 = zext i416 %r46 to i448
%r48 = add i448 %r43, %r47
%r49 = lshr i448 %r48, 32
%r50 = getelementptr i32, i32* %r3, i32 4
%r51 = load i32, i32* %r50
%r52 = call i416 @mulPv384x32(i32* %r2, i32 %r51)
%r53 = zext i416 %r52 to i448
%r54 = add i448 %r49, %r53
%r55 = trunc i448 %r54 to i32
%r56 = mul i32 %r55, %r6
%r57 = call i416 @mulPv384x32(i32* %r4, i32 %r56)
%r58 = zext i416 %r57 to i448
%r59 = add i448 %r54, %r58
%r60 = lshr i448 %r59, 32
%r61 = getelementptr i32, i32* %r3, i32 5
%r62 = load i32, i32* %r61
%r63 = call i416 @mulPv384x32(i32* %r2, i32 %r62)
%r64 = zext i416 %r63 to i448
%r65 = add i448 %r60, %r64
%r66 = trunc i448 %r65 to i32
%r67 = mul i32 %r66, %r6
%r68 = call i416 @mulPv384x32(i32* %r4, i32 %r67)
%r69 = zext i416 %r68 to i448
%r70 = add i448 %r65, %r69
%r71 = lshr i448 %r70, 32
%r72 = getelementptr i32, i32* %r3, i32 6
%r73 = load i32, i32* %r72
%r74 = call i416 @mulPv384x32(i32* %r2, i32 %r73)
%r75 = zext i416 %r74 to i448
%r76 = add i448 %r71, %r75
%r77 = trunc i448 %r76 to i32
%r78 = mul i32 %r77, %r6
%r79 = call i416 @mulPv384x32(i32* %r4, i32 %r78)
%r80 = zext i416 %r79 to i448
%r81 = add i448 %r76, %r80
%r82 = lshr i448 %r81, 32
%r83 = getelementptr i32, i32* %r3, i32 7
%r84 = load i32, i32* %r83
%r85 = call i416 @mulPv384x32(i32* %r2, i32 %r84)
%r86 = zext i416 %r85 to i448
%r87 = add i448 %r82, %r86
%r88 = trunc i448 %r87 to i32
%r89 = mul i32 %r88, %r6
%r90 = call i416 @mulPv384x32(i32* %r4, i32 %r89)
%r91 = zext i416 %r90 to i448
%r92 = add i448 %r87, %r91
%r93 = lshr i448 %r92, 32
%r94 = getelementptr i32, i32* %r3, i32 8
%r95 = load i32, i32* %r94
%r96 = call i416 @mulPv384x32(i32* %r2, i32 %r95)
%r97 = zext i416 %r96 to i448
%r98 = add i448 %r93, %r97
%r99 = trunc i448 %r98 to i32
%r100 = mul i32 %r99, %r6
%r101 = call i416 @mulPv384x32(i32* %r4, i32 %r100)
%r102 = zext i416 %r101 to i448
%r103 = add i448 %r98, %r102
%r104 = lshr i448 %r103, 32
%r105 = getelementptr i32, i32* %r3, i32 9
%r106 = load i32, i32* %r105
%r107 = call i416 @mulPv384x32(i32* %r2, i32 %r106)
%r108 = zext i416 %r107 to i448
%r109 = add i448 %r104, %r108
%r110 = trunc i448 %r109 to i32
%r111 = mul i32 %r110, %r6
%r112 = call i416 @mulPv384x32(i32* %r4, i32 %r111)
%r113 = zext i416 %r112 to i448
%r114 = add i448 %r109, %r113
%r115 = lshr i448 %r114, 32
%r116 = getelementptr i32, i32* %r3, i32 10
%r117 = load i32, i32* %r116
%r118 = call i416 @mulPv384x32(i32* %r2, i32 %r117)
%r119 = zext i416 %r118 to i448
%r120 = add i448 %r115, %r119
%r121 = trunc i448 %r120 to i32
%r122 = mul i32 %r121, %r6
%r123 = call i416 @mulPv384x32(i32* %r4, i32 %r122)
%r124 = zext i416 %r123 to i448
%r125 = add i448 %r120, %r124
%r126 = lshr i448 %r125, 32
%r127 = getelementptr i32, i32* %r3, i32 11
%r128 = load i32, i32* %r127
%r129 = call i416 @mulPv384x32(i32* %r2, i32 %r128)
%r130 = zext i416 %r129 to i448
%r131 = add i448 %r126, %r130
%r132 = trunc i448 %r131 to i32
%r133 = mul i32 %r132, %r6
%r134 = call i416 @mulPv384x32(i32* %r4, i32 %r133)
%r135 = zext i416 %r134 to i448
%r136 = add i448 %r131, %r135
%r137 = lshr i448 %r136, 32
%r138 = trunc i448 %r137 to i416
%r139 = bitcast i32* %r4 to i384*
%r140 = load i384, i384* %r139
%r141 = zext i384 %r140 to i416
%r142 = sub i416 %r138, %r141
%r143 = lshr i416 %r142, 384
%r144 = trunc i416 %r143 to i1
%r145 = select i1 %r144, i416 %r138, i416 %r142
%r146 = trunc i416 %r145 to i384
%r147 = bitcast i32* %r1 to i384*
store i384 %r146, i384* %r147
ret void
}
define void @mcl_fp_montNF12L(i32* %r1, i32* %r2, i32* %r3, i32* %r4)
{
%r5 = getelementptr i32, i32* %r4, i32 -1
%r6 = load i32, i32* %r5
%r7 = load i32, i32* %r3
%r8 = call i416 @mulPv384x32(i32* %r2, i32 %r7)
%r9 = trunc i416 %r8 to i32
%r10 = mul i32 %r9, %r6
%r11 = call i416 @mulPv384x32(i32* %r4, i32 %r10)
%r12 = add i416 %r8, %r11
%r13 = lshr i416 %r12, 32
%r14 = getelementptr i32, i32* %r3, i32 1
%r15 = load i32, i32* %r14
%r16 = call i416 @mulPv384x32(i32* %r2, i32 %r15)
%r17 = add i416 %r13, %r16
%r18 = trunc i416 %r17 to i32
%r19 = mul i32 %r18, %r6
%r20 = call i416 @mulPv384x32(i32* %r4, i32 %r19)
%r21 = add i416 %r17, %r20
%r22 = lshr i416 %r21, 32
%r23 = getelementptr i32, i32* %r3, i32 2
%r24 = load i32, i32* %r23
%r25 = call i416 @mulPv384x32(i32* %r2, i32 %r24)
%r26 = add i416 %r22, %r25
%r27 = trunc i416 %r26 to i32
%r28 = mul i32 %r27, %r6
%r29 = call i416 @mulPv384x32(i32* %r4, i32 %r28)
%r30 = add i416 %r26, %r29
%r31 = lshr i416 %r30, 32
%r32 = getelementptr i32, i32* %r3, i32 3
%r33 = load i32, i32* %r32
%r34 = call i416 @mulPv384x32(i32* %r2, i32 %r33)
%r35 = add i416 %r31, %r34
%r36 = trunc i416 %r35 to i32
%r37 = mul i32 %r36, %r6
%r38 = call i416 @mulPv384x32(i32* %r4, i32 %r37)
%r39 = add i416 %r35, %r38
%r40 = lshr i416 %r39, 32
%r41 = getelementptr i32, i32* %r3, i32 4
%r42 = load i32, i32* %r41
%r43 = call i416 @mulPv384x32(i32* %r2, i32 %r42)
%r44 = add i416 %r40, %r43
%r45 = trunc i416 %r44 to i32
%r46 = mul i32 %r45, %r6
%r47 = call i416 @mulPv384x32(i32* %r4, i32 %r46)
%r48 = add i416 %r44, %r47
%r49 = lshr i416 %r48, 32
%r50 = getelementptr i32, i32* %r3, i32 5
%r51 = load i32, i32* %r50
%r52 = call i416 @mulPv384x32(i32* %r2, i32 %r51)
%r53 = add i416 %r49, %r52
%r54 = trunc i416 %r53 to i32
%r55 = mul i32 %r54, %r6
%r56 = call i416 @mulPv384x32(i32* %r4, i32 %r55)
%r57 = add i416 %r53, %r56
%r58 = lshr i416 %r57, 32
%r59 = getelementptr i32, i32* %r3, i32 6
%r60 = load i32, i32* %r59
%r61 = call i416 @mulPv384x32(i32* %r2, i32 %r60)
%r62 = add i416 %r58, %r61
%r63 = trunc i416 %r62 to i32
%r64 = mul i32 %r63, %r6
%r65 = call i416 @mulPv384x32(i32* %r4, i32 %r64)
%r66 = add i416 %r62, %r65
%r67 = lshr i416 %r66, 32
%r68 = getelementptr i32, i32* %r3, i32 7
%r69 = load i32, i32* %r68
%r70 = call i416 @mulPv384x32(i32* %r2, i32 %r69)
%r71 = add i416 %r67, %r70
%r72 = trunc i416 %r71 to i32
%r73 = mul i32 %r72, %r6
%r74 = call i416 @mulPv384x32(i32* %r4, i32 %r73)
%r75 = add i416 %r71, %r74
%r76 = lshr i416 %r75, 32
%r77 = getelementptr i32, i32* %r3, i32 8
%r78 = load i32, i32* %r77
%r79 = call i416 @mulPv384x32(i32* %r2, i32 %r78)
%r80 = add i416 %r76, %r79
%r81 = trunc i416 %r80 to i32
%r82 = mul i32 %r81, %r6
%r83 = call i416 @mulPv384x32(i32* %r4, i32 %r82)
%r84 = add i416 %r80, %r83
%r85 = lshr i416 %r84, 32
%r86 = getelementptr i32, i32* %r3, i32 9
%r87 = load i32, i32* %r86
%r88 = call i416 @mulPv384x32(i32* %r2, i32 %r87)
%r89 = add i416 %r85, %r88
%r90 = trunc i416 %r89 to i32
%r91 = mul i32 %r90, %r6
%r92 = call i416 @mulPv384x32(i32* %r4, i32 %r91)
%r93 = add i416 %r89, %r92
%r94 = lshr i416 %r93, 32
%r95 = getelementptr i32, i32* %r3, i32 10
%r96 = load i32, i32* %r95
%r97 = call i416 @mulPv384x32(i32* %r2, i32 %r96)
%r98 = add i416 %r94, %r97
%r99 = trunc i416 %r98 to i32
%r100 = mul i32 %r99, %r6
%r101 = call i416 @mulPv384x32(i32* %r4, i32 %r100)
%r102 = add i416 %r98, %r101
%r103 = lshr i416 %r102, 32
%r104 = getelementptr i32, i32* %r3, i32 11
%r105 = load i32, i32* %r104
%r106 = call i416 @mulPv384x32(i32* %r2, i32 %r105)
%r107 = add i416 %r103, %r106
%r108 = trunc i416 %r107 to i32
%r109 = mul i32 %r108, %r6
%r110 = call i416 @mulPv384x32(i32* %r4, i32 %r109)
%r111 = add i416 %r107, %r110
%r112 = lshr i416 %r111, 32
%r113 = trunc i416 %r112 to i384
%r114 = bitcast i32* %r4 to i384*
%r115 = load i384, i384* %r114
%r116 = sub i384 %r113, %r115
%r117 = lshr i384 %r116, 383
%r118 = trunc i384 %r117 to i1
%r119 = select i1 %r118, i384 %r113, i384 %r116
%r120 = bitcast i32* %r1 to i384*
store i384 %r119, i384* %r120
ret void
}
define void @mcl_fp_montRed12L(i32* noalias %r1, i32* noalias %r2, i32* noalias %r3)
{
%r4 = getelementptr i32, i32* %r3, i32 -1
%r5 = load i32, i32* %r4
%r6 = bitcast i32* %r3 to i384*
%r7 = load i384, i384* %r6
%r8 = bitcast i32* %r2 to i384*
%r9 = load i384, i384* %r8
%r10 = trunc i384 %r9 to i32
%r11 = mul i32 %r10, %r5
%r12 = call i416 @mulPv384x32(i32* %r3, i32 %r11)
%r13 = getelementptr i32, i32* %r2, i32 12
%r14 = load i32, i32* %r13
%r15 = zext i384 %r9 to i416
%r16 = zext i32 %r14 to i416
%r17 = shl i416 %r16, 384
%r18 = or i416 %r15, %r17
%r19 = zext i416 %r18 to i448
%r20 = zext i416 %r12 to i448
%r21 = add i448 %r19, %r20
%r22 = lshr i448 %r21, 32
%r23 = trunc i448 %r22 to i416
%r24 = lshr i416 %r23, 384
%r25 = trunc i416 %r24 to i32
%r26 = trunc i416 %r23 to i384
%r27 = trunc i384 %r26 to i32
%r28 = mul i32 %r27, %r5
%r29 = call i416 @mulPv384x32(i32* %r3, i32 %r28)
%r30 = zext i32 %r25 to i416
%r31 = shl i416 %r30, 384
%r32 = add i416 %r29, %r31
%r33 = getelementptr i32, i32* %r2, i32 13
%r34 = load i32, i32* %r33
%r35 = zext i384 %r26 to i416
%r36 = zext i32 %r34 to i416
%r37 = shl i416 %r36, 384
%r38 = or i416 %r35, %r37
%r39 = zext i416 %r38 to i448
%r40 = zext i416 %r32 to i448
%r41 = add i448 %r39, %r40
%r42 = lshr i448 %r41, 32
%r43 = trunc i448 %r42 to i416
%r44 = lshr i416 %r43, 384
%r45 = trunc i416 %r44 to i32
%r46 = trunc i416 %r43 to i384
%r47 = trunc i384 %r46 to i32
%r48 = mul i32 %r47, %r5
%r49 = call i416 @mulPv384x32(i32* %r3, i32 %r48)
%r50 = zext i32 %r45 to i416
%r51 = shl i416 %r50, 384
%r52 = add i416 %r49, %r51
%r53 = getelementptr i32, i32* %r2, i32 14
%r54 = load i32, i32* %r53
%r55 = zext i384 %r46 to i416
%r56 = zext i32 %r54 to i416
%r57 = shl i416 %r56, 384
%r58 = or i416 %r55, %r57
%r59 = zext i416 %r58 to i448
%r60 = zext i416 %r52 to i448
%r61 = add i448 %r59, %r60
%r62 = lshr i448 %r61, 32
%r63 = trunc i448 %r62 to i416
%r64 = lshr i416 %r63, 384
%r65 = trunc i416 %r64 to i32
%r66 = trunc i416 %r63 to i384
%r67 = trunc i384 %r66 to i32
%r68 = mul i32 %r67, %r5
%r69 = call i416 @mulPv384x32(i32* %r3, i32 %r68)
%r70 = zext i32 %r65 to i416
%r71 = shl i416 %r70, 384
%r72 = add i416 %r69, %r71
%r73 = getelementptr i32, i32* %r2, i32 15
%r74 = load i32, i32* %r73
%r75 = zext i384 %r66 to i416
%r76 = zext i32 %r74 to i416
%r77 = shl i416 %r76, 384
%r78 = or i416 %r75, %r77
%r79 = zext i416 %r78 to i448
%r80 = zext i416 %r72 to i448
%r81 = add i448 %r79, %r80
%r82 = lshr i448 %r81, 32
%r83 = trunc i448 %r82 to i416
%r84 = lshr i416 %r83, 384
%r85 = trunc i416 %r84 to i32
%r86 = trunc i416 %r83 to i384
%r87 = trunc i384 %r86 to i32
%r88 = mul i32 %r87, %r5
%r89 = call i416 @mulPv384x32(i32* %r3, i32 %r88)
%r90 = zext i32 %r85 to i416
%r91 = shl i416 %r90, 384
%r92 = add i416 %r89, %r91
%r93 = getelementptr i32, i32* %r2, i32 16
%r94 = load i32, i32* %r93
%r95 = zext i384 %r86 to i416
%r96 = zext i32 %r94 to i416
%r97 = shl i416 %r96, 384
%r98 = or i416 %r95, %r97
%r99 = zext i416 %r98 to i448
%r100 = zext i416 %r92 to i448
%r101 = add i448 %r99, %r100
%r102 = lshr i448 %r101, 32
%r103 = trunc i448 %r102 to i416
%r104 = lshr i416 %r103, 384
%r105 = trunc i416 %r104 to i32
%r106 = trunc i416 %r103 to i384
%r107 = trunc i384 %r106 to i32
%r108 = mul i32 %r107, %r5
%r109 = call i416 @mulPv384x32(i32* %r3, i32 %r108)
%r110 = zext i32 %r105 to i416
%r111 = shl i416 %r110, 384
%r112 = add i416 %r109, %r111
%r113 = getelementptr i32, i32* %r2, i32 17
%r114 = load i32, i32* %r113
%r115 = zext i384 %r106 to i416
%r116 = zext i32 %r114 to i416
%r117 = shl i416 %r116, 384
%r118 = or i416 %r115, %r117
%r119 = zext i416 %r118 to i448
%r120 = zext i416 %r112 to i448
%r121 = add i448 %r119, %r120
%r122 = lshr i448 %r121, 32
%r123 = trunc i448 %r122 to i416
%r124 = lshr i416 %r123, 384
%r125 = trunc i416 %r124 to i32
%r126 = trunc i416 %r123 to i384
%r127 = trunc i384 %r126 to i32
%r128 = mul i32 %r127, %r5
%r129 = call i416 @mulPv384x32(i32* %r3, i32 %r128)
%r130 = zext i32 %r125 to i416
%r131 = shl i416 %r130, 384
%r132 = add i416 %r129, %r131
%r133 = getelementptr i32, i32* %r2, i32 18
%r134 = load i32, i32* %r133
%r135 = zext i384 %r126 to i416
%r136 = zext i32 %r134 to i416
%r137 = shl i416 %r136, 384
%r138 = or i416 %r135, %r137
%r139 = zext i416 %r138 to i448
%r140 = zext i416 %r132 to i448
%r141 = add i448 %r139, %r140
%r142 = lshr i448 %r141, 32
%r143 = trunc i448 %r142 to i416
%r144 = lshr i416 %r143, 384
%r145 = trunc i416 %r144 to i32
%r146 = trunc i416 %r143 to i384
%r147 = trunc i384 %r146 to i32
%r148 = mul i32 %r147, %r5
%r149 = call i416 @mulPv384x32(i32* %r3, i32 %r148)
%r150 = zext i32 %r145 to i416
%r151 = shl i416 %r150, 384
%r152 = add i416 %r149, %r151
%r153 = getelementptr i32, i32* %r2, i32 19
%r154 = load i32, i32* %r153
%r155 = zext i384 %r146 to i416
%r156 = zext i32 %r154 to i416
%r157 = shl i416 %r156, 384
%r158 = or i416 %r155, %r157
%r159 = zext i416 %r158 to i448
%r160 = zext i416 %r152 to i448
%r161 = add i448 %r159, %r160
%r162 = lshr i448 %r161, 32
%r163 = trunc i448 %r162 to i416
%r164 = lshr i416 %r163, 384
%r165 = trunc i416 %r164 to i32
%r166 = trunc i416 %r163 to i384
%r167 = trunc i384 %r166 to i32
%r168 = mul i32 %r167, %r5
%r169 = call i416 @mulPv384x32(i32* %r3, i32 %r168)
%r170 = zext i32 %r165 to i416
%r171 = shl i416 %r170, 384
%r172 = add i416 %r169, %r171
%r173 = getelementptr i32, i32* %r2, i32 20
%r174 = load i32, i32* %r173
%r175 = zext i384 %r166 to i416
%r176 = zext i32 %r174 to i416
%r177 = shl i416 %r176, 384
%r178 = or i416 %r175, %r177
%r179 = zext i416 %r178 to i448
%r180 = zext i416 %r172 to i448
%r181 = add i448 %r179, %r180
%r182 = lshr i448 %r181, 32
%r183 = trunc i448 %r182 to i416
%r184 = lshr i416 %r183, 384
%r185 = trunc i416 %r184 to i32
%r186 = trunc i416 %r183 to i384
%r187 = trunc i384 %r186 to i32
%r188 = mul i32 %r187, %r5
%r189 = call i416 @mulPv384x32(i32* %r3, i32 %r188)
%r190 = zext i32 %r185 to i416
%r191 = shl i416 %r190, 384
%r192 = add i416 %r189, %r191
%r193 = getelementptr i32, i32* %r2, i32 21
%r194 = load i32, i32* %r193
%r195 = zext i384 %r186 to i416
%r196 = zext i32 %r194 to i416
%r197 = shl i416 %r196, 384
%r198 = or i416 %r195, %r197
%r199 = zext i416 %r198 to i448
%r200 = zext i416 %r192 to i448
%r201 = add i448 %r199, %r200
%r202 = lshr i448 %r201, 32
%r203 = trunc i448 %r202 to i416
%r204 = lshr i416 %r203, 384
%r205 = trunc i416 %r204 to i32
%r206 = trunc i416 %r203 to i384
%r207 = trunc i384 %r206 to i32
%r208 = mul i32 %r207, %r5
%r209 = call i416 @mulPv384x32(i32* %r3, i32 %r208)
%r210 = zext i32 %r205 to i416
%r211 = shl i416 %r210, 384
%r212 = add i416 %r209, %r211
%r213 = getelementptr i32, i32* %r2, i32 22
%r214 = load i32, i32* %r213
%r215 = zext i384 %r206 to i416
%r216 = zext i32 %r214 to i416
%r217 = shl i416 %r216, 384
%r218 = or i416 %r215, %r217
%r219 = zext i416 %r218 to i448
%r220 = zext i416 %r212 to i448
%r221 = add i448 %r219, %r220
%r222 = lshr i448 %r221, 32
%r223 = trunc i448 %r222 to i416
%r224 = lshr i416 %r223, 384
%r225 = trunc i416 %r224 to i32
%r226 = trunc i416 %r223 to i384
%r227 = trunc i384 %r226 to i32
%r228 = mul i32 %r227, %r5
%r229 = call i416 @mulPv384x32(i32* %r3, i32 %r228)
%r230 = zext i32 %r225 to i416
%r231 = shl i416 %r230, 384
%r232 = add i416 %r229, %r231
%r233 = getelementptr i32, i32* %r2, i32 23
%r234 = load i32, i32* %r233
%r235 = zext i384 %r226 to i416
%r236 = zext i32 %r234 to i416
%r237 = shl i416 %r236, 384
%r238 = or i416 %r235, %r237
%r239 = zext i416 %r238 to i448
%r240 = zext i416 %r232 to i448
%r241 = add i448 %r239, %r240
%r242 = lshr i448 %r241, 32
%r243 = trunc i448 %r242 to i416
%r244 = lshr i416 %r243, 384
%r245 = trunc i416 %r244 to i32
%r246 = trunc i416 %r243 to i384
%r247 = zext i384 %r7 to i416
%r248 = zext i384 %r246 to i416
%r249 = zext i32 %r245 to i416
%r250 = shl i416 %r249, 384
%r251 = or i416 %r248, %r250
%r252 = sub i416 %r251, %r247
%r253 = lshr i416 %r252, 384
%r254 = trunc i416 %r253 to i1
%r255 = select i1 %r254, i416 %r251, i416 %r252
%r256 = trunc i416 %r255 to i384
%r257 = bitcast i32* %r1 to i384*
store i384 %r256, i384* %r257
ret void
}
define void @mcl_fp_montRedNF12L(i32* noalias %r1, i32* noalias %r2, i32* noalias %r3)
{
%r4 = getelementptr i32, i32* %r3, i32 -1
%r5 = load i32, i32* %r4
%r6 = bitcast i32* %r3 to i384*
%r7 = load i384, i384* %r6
%r8 = bitcast i32* %r2 to i384*
%r9 = load i384, i384* %r8
%r10 = trunc i384 %r9 to i32
%r11 = mul i32 %r10, %r5
%r12 = call i416 @mulPv384x32(i32* %r3, i32 %r11)
%r13 = getelementptr i32, i32* %r2, i32 12
%r14 = load i32, i32* %r13
%r15 = zext i384 %r9 to i416
%r16 = zext i32 %r14 to i416
%r17 = shl i416 %r16, 384
%r18 = or i416 %r15, %r17
%r19 = zext i416 %r18 to i448
%r20 = zext i416 %r12 to i448
%r21 = add i448 %r19, %r20
%r22 = lshr i448 %r21, 32
%r23 = trunc i448 %r22 to i416
%r24 = lshr i416 %r23, 384
%r25 = trunc i416 %r24 to i32
%r26 = trunc i416 %r23 to i384
%r27 = trunc i384 %r26 to i32
%r28 = mul i32 %r27, %r5
%r29 = call i416 @mulPv384x32(i32* %r3, i32 %r28)
%r30 = zext i32 %r25 to i416
%r31 = shl i416 %r30, 384
%r32 = add i416 %r29, %r31
%r33 = getelementptr i32, i32* %r2, i32 13
%r34 = load i32, i32* %r33
%r35 = zext i384 %r26 to i416
%r36 = zext i32 %r34 to i416
%r37 = shl i416 %r36, 384
%r38 = or i416 %r35, %r37
%r39 = zext i416 %r38 to i448
%r40 = zext i416 %r32 to i448
%r41 = add i448 %r39, %r40
%r42 = lshr i448 %r41, 32
%r43 = trunc i448 %r42 to i416
%r44 = lshr i416 %r43, 384
%r45 = trunc i416 %r44 to i32
%r46 = trunc i416 %r43 to i384
%r47 = trunc i384 %r46 to i32
%r48 = mul i32 %r47, %r5
%r49 = call i416 @mulPv384x32(i32* %r3, i32 %r48)
%r50 = zext i32 %r45 to i416
%r51 = shl i416 %r50, 384
%r52 = add i416 %r49, %r51
%r53 = getelementptr i32, i32* %r2, i32 14
%r54 = load i32, i32* %r53
%r55 = zext i384 %r46 to i416
%r56 = zext i32 %r54 to i416
%r57 = shl i416 %r56, 384
%r58 = or i416 %r55, %r57
%r59 = zext i416 %r58 to i448
%r60 = zext i416 %r52 to i448
%r61 = add i448 %r59, %r60
%r62 = lshr i448 %r61, 32
%r63 = trunc i448 %r62 to i416
%r64 = lshr i416 %r63, 384
%r65 = trunc i416 %r64 to i32
%r66 = trunc i416 %r63 to i384
%r67 = trunc i384 %r66 to i32
%r68 = mul i32 %r67, %r5
%r69 = call i416 @mulPv384x32(i32* %r3, i32 %r68)
%r70 = zext i32 %r65 to i416
%r71 = shl i416 %r70, 384
%r72 = add i416 %r69, %r71
%r73 = getelementptr i32, i32* %r2, i32 15
%r74 = load i32, i32* %r73
%r75 = zext i384 %r66 to i416
%r76 = zext i32 %r74 to i416
%r77 = shl i416 %r76, 384
%r78 = or i416 %r75, %r77
%r79 = zext i416 %r78 to i448
%r80 = zext i416 %r72 to i448
%r81 = add i448 %r79, %r80
%r82 = lshr i448 %r81, 32
%r83 = trunc i448 %r82 to i416
%r84 = lshr i416 %r83, 384
%r85 = trunc i416 %r84 to i32
%r86 = trunc i416 %r83 to i384
%r87 = trunc i384 %r86 to i32
%r88 = mul i32 %r87, %r5
%r89 = call i416 @mulPv384x32(i32* %r3, i32 %r88)
%r90 = zext i32 %r85 to i416
%r91 = shl i416 %r90, 384
%r92 = add i416 %r89, %r91
%r93 = getelementptr i32, i32* %r2, i32 16
%r94 = load i32, i32* %r93
%r95 = zext i384 %r86 to i416
%r96 = zext i32 %r94 to i416
%r97 = shl i416 %r96, 384
%r98 = or i416 %r95, %r97
%r99 = zext i416 %r98 to i448
%r100 = zext i416 %r92 to i448
%r101 = add i448 %r99, %r100
%r102 = lshr i448 %r101, 32
%r103 = trunc i448 %r102 to i416
%r104 = lshr i416 %r103, 384
%r105 = trunc i416 %r104 to i32
%r106 = trunc i416 %r103 to i384
%r107 = trunc i384 %r106 to i32
%r108 = mul i32 %r107, %r5
%r109 = call i416 @mulPv384x32(i32* %r3, i32 %r108)
%r110 = zext i32 %r105 to i416
%r111 = shl i416 %r110, 384
%r112 = add i416 %r109, %r111
%r113 = getelementptr i32, i32* %r2, i32 17
%r114 = load i32, i32* %r113
%r115 = zext i384 %r106 to i416
%r116 = zext i32 %r114 to i416
%r117 = shl i416 %r116, 384
%r118 = or i416 %r115, %r117
%r119 = zext i416 %r118 to i448
%r120 = zext i416 %r112 to i448
%r121 = add i448 %r119, %r120
%r122 = lshr i448 %r121, 32
%r123 = trunc i448 %r122 to i416
%r124 = lshr i416 %r123, 384
%r125 = trunc i416 %r124 to i32
%r126 = trunc i416 %r123 to i384
%r127 = trunc i384 %r126 to i32
%r128 = mul i32 %r127, %r5
%r129 = call i416 @mulPv384x32(i32* %r3, i32 %r128)
%r130 = zext i32 %r125 to i416
%r131 = shl i416 %r130, 384
%r132 = add i416 %r129, %r131
%r133 = getelementptr i32, i32* %r2, i32 18
%r134 = load i32, i32* %r133
%r135 = zext i384 %r126 to i416
%r136 = zext i32 %r134 to i416
%r137 = shl i416 %r136, 384
%r138 = or i416 %r135, %r137
%r139 = zext i416 %r138 to i448
%r140 = zext i416 %r132 to i448
%r141 = add i448 %r139, %r140
%r142 = lshr i448 %r141, 32
%r143 = trunc i448 %r142 to i416
%r144 = lshr i416 %r143, 384
%r145 = trunc i416 %r144 to i32
%r146 = trunc i416 %r143 to i384
%r147 = trunc i384 %r146 to i32
%r148 = mul i32 %r147, %r5
%r149 = call i416 @mulPv384x32(i32* %r3, i32 %r148)
%r150 = zext i32 %r145 to i416
%r151 = shl i416 %r150, 384
%r152 = add i416 %r149, %r151
%r153 = getelementptr i32, i32* %r2, i32 19
%r154 = load i32, i32* %r153
%r155 = zext i384 %r146 to i416
%r156 = zext i32 %r154 to i416
%r157 = shl i416 %r156, 384
%r158 = or i416 %r155, %r157
%r159 = zext i416 %r158 to i448
%r160 = zext i416 %r152 to i448
%r161 = add i448 %r159, %r160
%r162 = lshr i448 %r161, 32
%r163 = trunc i448 %r162 to i416
%r164 = lshr i416 %r163, 384
%r165 = trunc i416 %r164 to i32
%r166 = trunc i416 %r163 to i384
%r167 = trunc i384 %r166 to i32
%r168 = mul i32 %r167, %r5
%r169 = call i416 @mulPv384x32(i32* %r3, i32 %r168)
%r170 = zext i32 %r165 to i416
%r171 = shl i416 %r170, 384
%r172 = add i416 %r169, %r171
%r173 = getelementptr i32, i32* %r2, i32 20
%r174 = load i32, i32* %r173
%r175 = zext i384 %r166 to i416
%r176 = zext i32 %r174 to i416
%r177 = shl i416 %r176, 384
%r178 = or i416 %r175, %r177
%r179 = zext i416 %r178 to i448
%r180 = zext i416 %r172 to i448
%r181 = add i448 %r179, %r180
%r182 = lshr i448 %r181, 32
%r183 = trunc i448 %r182 to i416
%r184 = lshr i416 %r183, 384
%r185 = trunc i416 %r184 to i32
%r186 = trunc i416 %r183 to i384
%r187 = trunc i384 %r186 to i32
%r188 = mul i32 %r187, %r5
%r189 = call i416 @mulPv384x32(i32* %r3, i32 %r188)
%r190 = zext i32 %r185 to i416
%r191 = shl i416 %r190, 384
%r192 = add i416 %r189, %r191
%r193 = getelementptr i32, i32* %r2, i32 21
%r194 = load i32, i32* %r193
%r195 = zext i384 %r186 to i416
%r196 = zext i32 %r194 to i416
%r197 = shl i416 %r196, 384
%r198 = or i416 %r195, %r197
%r199 = zext i416 %r198 to i448
%r200 = zext i416 %r192 to i448
%r201 = add i448 %r199, %r200
%r202 = lshr i448 %r201, 32
%r203 = trunc i448 %r202 to i416
%r204 = lshr i416 %r203, 384
%r205 = trunc i416 %r204 to i32
%r206 = trunc i416 %r203 to i384
%r207 = trunc i384 %r206 to i32
%r208 = mul i32 %r207, %r5
%r209 = call i416 @mulPv384x32(i32* %r3, i32 %r208)
%r210 = zext i32 %r205 to i416
%r211 = shl i416 %r210, 384
%r212 = add i416 %r209, %r211
%r213 = getelementptr i32, i32* %r2, i32 22
%r214 = load i32, i32* %r213
%r215 = zext i384 %r206 to i416
%r216 = zext i32 %r214 to i416
%r217 = shl i416 %r216, 384
%r218 = or i416 %r215, %r217
%r219 = zext i416 %r218 to i448
%r220 = zext i416 %r212 to i448
%r221 = add i448 %r219, %r220
%r222 = lshr i448 %r221, 32
%r223 = trunc i448 %r222 to i416
%r224 = lshr i416 %r223, 384
%r225 = trunc i416 %r224 to i32
%r226 = trunc i416 %r223 to i384
%r227 = trunc i384 %r226 to i32
%r228 = mul i32 %r227, %r5
%r229 = call i416 @mulPv384x32(i32* %r3, i32 %r228)
%r230 = zext i32 %r225 to i416
%r231 = shl i416 %r230, 384
%r232 = add i416 %r229, %r231
%r233 = getelementptr i32, i32* %r2, i32 23
%r234 = load i32, i32* %r233
%r235 = zext i384 %r226 to i416
%r236 = zext i32 %r234 to i416
%r237 = shl i416 %r236, 384
%r238 = or i416 %r235, %r237
%r239 = zext i416 %r238 to i448
%r240 = zext i416 %r232 to i448
%r241 = add i448 %r239, %r240
%r242 = lshr i448 %r241, 32
%r243 = trunc i448 %r242 to i416
%r244 = lshr i416 %r243, 384
%r245 = trunc i416 %r244 to i32
%r246 = trunc i416 %r243 to i384
%r247 = sub i384 %r246, %r7
%r248 = lshr i384 %r247, 383
%r249 = trunc i384 %r248 to i1
%r250 = select i1 %r249, i384 %r246, i384 %r247
%r251 = bitcast i32* %r1 to i384*
store i384 %r250, i384* %r251
ret void
}
define i32 @mcl_fp_addPre12L(i32* noalias %r1, i32* noalias %r2, i32* noalias %r3)
{
%r5 = bitcast i32* %r2 to i384*
%r6 = load i384, i384* %r5
%r7 = zext i384 %r6 to i416
%r8 = bitcast i32* %r3 to i384*
%r9 = load i384, i384* %r8
%r10 = zext i384 %r9 to i416
%r11 = add i416 %r7, %r10
%r12 = trunc i416 %r11 to i384
%r13 = bitcast i32* %r1 to i384*
store i384 %r12, i384* %r13
%r14 = lshr i416 %r11, 384
%r15 = trunc i416 %r14 to i32
ret i32 %r15
}
define i32 @mcl_fp_subPre12L(i32* noalias %r1, i32* noalias %r2, i32* noalias %r3)
{
%r5 = bitcast i32* %r2 to i384*
%r6 = load i384, i384* %r5
%r7 = zext i384 %r6 to i416
%r8 = bitcast i32* %r3 to i384*
%r9 = load i384, i384* %r8
%r10 = zext i384 %r9 to i416
%r11 = sub i416 %r7, %r10
%r12 = trunc i416 %r11 to i384
%r13 = bitcast i32* %r1 to i384*
store i384 %r12, i384* %r13
%r14 = lshr i416 %r11, 384
%r15 = trunc i416 %r14 to i32
%r16 = and i32 %r15, 1
ret i32 %r16
}
define void @mcl_fp_shr1_12L(i32* noalias %r1, i32* noalias %r2)
{
%r3 = bitcast i32* %r2 to i384*
%r4 = load i384, i384* %r3
%r5 = lshr i384 %r4, 1
%r6 = bitcast i32* %r1 to i384*
store i384 %r5, i384* %r6
ret void
}
define void @mcl_fp_add12L(i32* noalias %r1, i32* noalias %r2, i32* noalias %r3, i32* noalias %r4)
{
%r5 = bitcast i32* %r2 to i384*
%r6 = load i384, i384* %r5
%r7 = bitcast i32* %r3 to i384*
%r8 = load i384, i384* %r7
%r9 = bitcast i32* %r4 to i384*
%r10 = load i384, i384* %r9
%r11 = zext i384 %r6 to i416
%r12 = zext i384 %r8 to i416
%r13 = add i416 %r11, %r12
%r14 = zext i384 %r10 to i416
%r15 = sub i416 %r13, %r14
%r16 = lshr i416 %r15, 384
%r17 = trunc i416 %r16 to i1
%r18 = select i1 %r17, i416 %r13, i416 %r15
%r19 = trunc i416 %r18 to i384
%r20 = bitcast i32* %r1 to i384*
store i384 %r19, i384* %r20
ret void
}
define void @mcl_fp_addNF12L(i32* noalias %r1, i32* noalias %r2, i32* noalias %r3, i32* noalias %r4)
{
%r5 = bitcast i32* %r2 to i384*
%r6 = load i384, i384* %r5
%r7 = bitcast i32* %r3 to i384*
%r8 = load i384, i384* %r7
%r9 = bitcast i32* %r4 to i384*
%r10 = load i384, i384* %r9
%r11 = add i384 %r6, %r8
%r12 = sub i384 %r11, %r10
%r13 = lshr i384 %r12, 383
%r14 = trunc i384 %r13 to i1
%r15 = select i1 %r14, i384 %r11, i384 %r12
%r16 = bitcast i32* %r1 to i384*
store i384 %r15, i384* %r16
ret void
}
define void @mcl_fp_sub12L(i32* noalias %r1, i32* noalias %r2, i32* noalias %r3, i32* noalias %r4)
{
%r5 = bitcast i32* %r2 to i384*
%r6 = load i384, i384* %r5
%r7 = bitcast i32* %r3 to i384*
%r8 = load i384, i384* %r7
%r9 = zext i384 %r6 to i416
%r10 = zext i384 %r8 to i416
%r11 = sub i416 %r9, %r10
%r12 = lshr i416 %r11, 384
%r13 = trunc i416 %r12 to i1
%r14 = trunc i416 %r11 to i384
%r15 = bitcast i32* %r4 to i384*
%r16 = load i384, i384* %r15
%r17 = select i1 %r13, i384 %r16, i384 0
%r18 = add i384 %r14, %r17
%r19 = bitcast i32* %r1 to i384*
store i384 %r18, i384* %r19
ret void
}
define void @mcl_fp_subNF12L(i32* noalias %r1, i32* noalias %r2, i32* noalias %r3, i32* noalias %r4)
{
%r5 = bitcast i32* %r2 to i384*
%r6 = load i384, i384* %r5
%r7 = bitcast i32* %r3 to i384*
%r8 = load i384, i384* %r7
%r9 = sub i384 %r6, %r8
%r10 = lshr i384 %r9, 383
%r11 = trunc i384 %r10 to i1
%r12 = bitcast i32* %r4 to i384*
%r13 = load i384, i384* %r12
%r14 = select i1 %r11, i384 %r13, i384 0
%r15 = add i384 %r9, %r14
%r16 = bitcast i32* %r1 to i384*
store i384 %r15, i384* %r16
ret void
}
define void @mcl_fpDbl_add12L(i32* noalias %r1, i32* noalias %r2, i32* noalias %r3, i32* noalias %r4)
{
%r5 = bitcast i32* %r2 to i768*
%r6 = load i768, i768* %r5
%r7 = bitcast i32* %r3 to i768*
%r8 = load i768, i768* %r7
%r9 = zext i768 %r6 to i800
%r10 = zext i768 %r8 to i800
%r11 = add i800 %r9, %r10
%r12 = trunc i800 %r11 to i384
%r13 = bitcast i32* %r1 to i384*
store i384 %r12, i384* %r13
%r14 = lshr i800 %r11, 384
%r15 = trunc i800 %r14 to i416
%r16 = bitcast i32* %r4 to i384*
%r17 = load i384, i384* %r16
%r18 = zext i384 %r17 to i416
%r19 = sub i416 %r15, %r18
%r20 = lshr i416 %r19, 384
%r21 = trunc i416 %r20 to i1
%r22 = select i1 %r21, i416 %r15, i416 %r19
%r23 = trunc i416 %r22 to i384
%r24 = getelementptr i32, i32* %r1, i32 12
%r25 = bitcast i32* %r24 to i384*
store i384 %r23, i384* %r25
ret void
}
define void @mcl_fpDbl_sub12L(i32* noalias %r1, i32* noalias %r2, i32* noalias %r3, i32* noalias %r4)
{
%r5 = bitcast i32* %r2 to i768*
%r6 = load i768, i768* %r5
%r7 = bitcast i32* %r3 to i768*
%r8 = load i768, i768* %r7
%r9 = zext i768 %r6 to i800
%r10 = zext i768 %r8 to i800
%r11 = sub i800 %r9, %r10
%r12 = trunc i800 %r11 to i384
%r13 = bitcast i32* %r1 to i384*
store i384 %r12, i384* %r13
%r14 = lshr i800 %r11, 384
%r15 = trunc i800 %r14 to i384
%r16 = lshr i800 %r11, 768
%r17 = trunc i800 %r16 to i1
%r18 = bitcast i32* %r4 to i384*
%r19 = load i384, i384* %r18
%r20 = select i1 %r17, i384 %r19, i384 0
%r21 = add i384 %r15, %r20
%r22 = getelementptr i32, i32* %r1, i32 12
%r23 = bitcast i32* %r22 to i384*
store i384 %r21, i384* %r23
ret void
}
define i544 @mulPv512x32(i32* noalias %r2, i32 %r3)
{
%r4 = call i64 @mulPos32x32(i32* %r2, i32 %r3, i32 0)
%r5 = trunc i64 %r4 to i32
%r6 = call i32 @extractHigh32(i64 %r4)
%r7 = call i64 @mulPos32x32(i32* %r2, i32 %r3, i32 1)
%r8 = trunc i64 %r7 to i32
%r9 = call i32 @extractHigh32(i64 %r7)
%r10 = call i64 @mulPos32x32(i32* %r2, i32 %r3, i32 2)
%r11 = trunc i64 %r10 to i32
%r12 = call i32 @extractHigh32(i64 %r10)
%r13 = call i64 @mulPos32x32(i32* %r2, i32 %r3, i32 3)
%r14 = trunc i64 %r13 to i32
%r15 = call i32 @extractHigh32(i64 %r13)
%r16 = call i64 @mulPos32x32(i32* %r2, i32 %r3, i32 4)
%r17 = trunc i64 %r16 to i32
%r18 = call i32 @extractHigh32(i64 %r16)
%r19 = call i64 @mulPos32x32(i32* %r2, i32 %r3, i32 5)
%r20 = trunc i64 %r19 to i32
%r21 = call i32 @extractHigh32(i64 %r19)
%r22 = call i64 @mulPos32x32(i32* %r2, i32 %r3, i32 6)
%r23 = trunc i64 %r22 to i32
%r24 = call i32 @extractHigh32(i64 %r22)
%r25 = call i64 @mulPos32x32(i32* %r2, i32 %r3, i32 7)
%r26 = trunc i64 %r25 to i32
%r27 = call i32 @extractHigh32(i64 %r25)
%r28 = call i64 @mulPos32x32(i32* %r2, i32 %r3, i32 8)
%r29 = trunc i64 %r28 to i32
%r30 = call i32 @extractHigh32(i64 %r28)
%r31 = call i64 @mulPos32x32(i32* %r2, i32 %r3, i32 9)
%r32 = trunc i64 %r31 to i32
%r33 = call i32 @extractHigh32(i64 %r31)
%r34 = call i64 @mulPos32x32(i32* %r2, i32 %r3, i32 10)
%r35 = trunc i64 %r34 to i32
%r36 = call i32 @extractHigh32(i64 %r34)
%r37 = call i64 @mulPos32x32(i32* %r2, i32 %r3, i32 11)
%r38 = trunc i64 %r37 to i32
%r39 = call i32 @extractHigh32(i64 %r37)
%r40 = call i64 @mulPos32x32(i32* %r2, i32 %r3, i32 12)
%r41 = trunc i64 %r40 to i32
%r42 = call i32 @extractHigh32(i64 %r40)
%r43 = call i64 @mulPos32x32(i32* %r2, i32 %r3, i32 13)
%r44 = trunc i64 %r43 to i32
%r45 = call i32 @extractHigh32(i64 %r43)
%r46 = call i64 @mulPos32x32(i32* %r2, i32 %r3, i32 14)
%r47 = trunc i64 %r46 to i32
%r48 = call i32 @extractHigh32(i64 %r46)
%r49 = call i64 @mulPos32x32(i32* %r2, i32 %r3, i32 15)
%r50 = trunc i64 %r49 to i32
%r51 = call i32 @extractHigh32(i64 %r49)
%r52 = zext i32 %r5 to i64
%r53 = zext i32 %r8 to i64
%r54 = shl i64 %r53, 32
%r55 = or i64 %r52, %r54
%r56 = zext i64 %r55 to i96
%r57 = zext i32 %r11 to i96
%r58 = shl i96 %r57, 64
%r59 = or i96 %r56, %r58
%r60 = zext i96 %r59 to i128
%r61 = zext i32 %r14 to i128
%r62 = shl i128 %r61, 96
%r63 = or i128 %r60, %r62
%r64 = zext i128 %r63 to i160
%r65 = zext i32 %r17 to i160
%r66 = shl i160 %r65, 128
%r67 = or i160 %r64, %r66
%r68 = zext i160 %r67 to i192
%r69 = zext i32 %r20 to i192
%r70 = shl i192 %r69, 160
%r71 = or i192 %r68, %r70
%r72 = zext i192 %r71 to i224
%r73 = zext i32 %r23 to i224
%r74 = shl i224 %r73, 192
%r75 = or i224 %r72, %r74
%r76 = zext i224 %r75 to i256
%r77 = zext i32 %r26 to i256
%r78 = shl i256 %r77, 224
%r79 = or i256 %r76, %r78
%r80 = zext i256 %r79 to i288
%r81 = zext i32 %r29 to i288
%r82 = shl i288 %r81, 256
%r83 = or i288 %r80, %r82
%r84 = zext i288 %r83 to i320
%r85 = zext i32 %r32 to i320
%r86 = shl i320 %r85, 288
%r87 = or i320 %r84, %r86
%r88 = zext i320 %r87 to i352
%r89 = zext i32 %r35 to i352
%r90 = shl i352 %r89, 320
%r91 = or i352 %r88, %r90
%r92 = zext i352 %r91 to i384
%r93 = zext i32 %r38 to i384
%r94 = shl i384 %r93, 352
%r95 = or i384 %r92, %r94
%r96 = zext i384 %r95 to i416
%r97 = zext i32 %r41 to i416
%r98 = shl i416 %r97, 384
%r99 = or i416 %r96, %r98
%r100 = zext i416 %r99 to i448
%r101 = zext i32 %r44 to i448
%r102 = shl i448 %r101, 416
%r103 = or i448 %r100, %r102
%r104 = zext i448 %r103 to i480
%r105 = zext i32 %r47 to i480
%r106 = shl i480 %r105, 448
%r107 = or i480 %r104, %r106
%r108 = zext i480 %r107 to i512
%r109 = zext i32 %r50 to i512
%r110 = shl i512 %r109, 480
%r111 = or i512 %r108, %r110
%r112 = zext i32 %r6 to i64
%r113 = zext i32 %r9 to i64
%r114 = shl i64 %r113, 32
%r115 = or i64 %r112, %r114
%r116 = zext i64 %r115 to i96
%r117 = zext i32 %r12 to i96
%r118 = shl i96 %r117, 64
%r119 = or i96 %r116, %r118
%r120 = zext i96 %r119 to i128
%r121 = zext i32 %r15 to i128
%r122 = shl i128 %r121, 96
%r123 = or i128 %r120, %r122
%r124 = zext i128 %r123 to i160
%r125 = zext i32 %r18 to i160
%r126 = shl i160 %r125, 128
%r127 = or i160 %r124, %r126
%r128 = zext i160 %r127 to i192
%r129 = zext i32 %r21 to i192
%r130 = shl i192 %r129, 160
%r131 = or i192 %r128, %r130
%r132 = zext i192 %r131 to i224
%r133 = zext i32 %r24 to i224
%r134 = shl i224 %r133, 192
%r135 = or i224 %r132, %r134
%r136 = zext i224 %r135 to i256
%r137 = zext i32 %r27 to i256
%r138 = shl i256 %r137, 224
%r139 = or i256 %r136, %r138
%r140 = zext i256 %r139 to i288
%r141 = zext i32 %r30 to i288
%r142 = shl i288 %r141, 256
%r143 = or i288 %r140, %r142
%r144 = zext i288 %r143 to i320
%r145 = zext i32 %r33 to i320
%r146 = shl i320 %r145, 288
%r147 = or i320 %r144, %r146
%r148 = zext i320 %r147 to i352
%r149 = zext i32 %r36 to i352
%r150 = shl i352 %r149, 320
%r151 = or i352 %r148, %r150
%r152 = zext i352 %r151 to i384
%r153 = zext i32 %r39 to i384
%r154 = shl i384 %r153, 352
%r155 = or i384 %r152, %r154
%r156 = zext i384 %r155 to i416
%r157 = zext i32 %r42 to i416
%r158 = shl i416 %r157, 384
%r159 = or i416 %r156, %r158
%r160 = zext i416 %r159 to i448
%r161 = zext i32 %r45 to i448
%r162 = shl i448 %r161, 416
%r163 = or i448 %r160, %r162
%r164 = zext i448 %r163 to i480
%r165 = zext i32 %r48 to i480
%r166 = shl i480 %r165, 448
%r167 = or i480 %r164, %r166
%r168 = zext i480 %r167 to i512
%r169 = zext i32 %r51 to i512
%r170 = shl i512 %r169, 480
%r171 = or i512 %r168, %r170
%r172 = zext i512 %r111 to i544
%r173 = zext i512 %r171 to i544
%r174 = shl i544 %r173, 32
%r175 = add i544 %r172, %r174
ret i544 %r175
}
define void @mcl_fp_mont16L(i32* %r1, i32* %r2, i32* %r3, i32* %r4)
{
%r5 = getelementptr i32, i32* %r4, i32 -1
%r6 = load i32, i32* %r5
%r7 = getelementptr i32, i32* %r3, i32 0
%r8 = load i32, i32* %r7
%r9 = call i544 @mulPv512x32(i32* %r2, i32 %r8)
%r10 = zext i544 %r9 to i576
%r11 = trunc i544 %r9 to i32
%r12 = mul i32 %r11, %r6
%r13 = call i544 @mulPv512x32(i32* %r4, i32 %r12)
%r14 = zext i544 %r13 to i576
%r15 = add i576 %r10, %r14
%r16 = lshr i576 %r15, 32
%r17 = getelementptr i32, i32* %r3, i32 1
%r18 = load i32, i32* %r17
%r19 = call i544 @mulPv512x32(i32* %r2, i32 %r18)
%r20 = zext i544 %r19 to i576
%r21 = add i576 %r16, %r20
%r22 = trunc i576 %r21 to i32
%r23 = mul i32 %r22, %r6
%r24 = call i544 @mulPv512x32(i32* %r4, i32 %r23)
%r25 = zext i544 %r24 to i576
%r26 = add i576 %r21, %r25
%r27 = lshr i576 %r26, 32
%r28 = getelementptr i32, i32* %r3, i32 2
%r29 = load i32, i32* %r28
%r30 = call i544 @mulPv512x32(i32* %r2, i32 %r29)
%r31 = zext i544 %r30 to i576
%r32 = add i576 %r27, %r31
%r33 = trunc i576 %r32 to i32
%r34 = mul i32 %r33, %r6
%r35 = call i544 @mulPv512x32(i32* %r4, i32 %r34)
%r36 = zext i544 %r35 to i576
%r37 = add i576 %r32, %r36
%r38 = lshr i576 %r37, 32
%r39 = getelementptr i32, i32* %r3, i32 3
%r40 = load i32, i32* %r39
%r41 = call i544 @mulPv512x32(i32* %r2, i32 %r40)
%r42 = zext i544 %r41 to i576
%r43 = add i576 %r38, %r42
%r44 = trunc i576 %r43 to i32
%r45 = mul i32 %r44, %r6
%r46 = call i544 @mulPv512x32(i32* %r4, i32 %r45)
%r47 = zext i544 %r46 to i576
%r48 = add i576 %r43, %r47
%r49 = lshr i576 %r48, 32
%r50 = getelementptr i32, i32* %r3, i32 4
%r51 = load i32, i32* %r50
%r52 = call i544 @mulPv512x32(i32* %r2, i32 %r51)
%r53 = zext i544 %r52 to i576
%r54 = add i576 %r49, %r53
%r55 = trunc i576 %r54 to i32
%r56 = mul i32 %r55, %r6
%r57 = call i544 @mulPv512x32(i32* %r4, i32 %r56)
%r58 = zext i544 %r57 to i576
%r59 = add i576 %r54, %r58
%r60 = lshr i576 %r59, 32
%r61 = getelementptr i32, i32* %r3, i32 5
%r62 = load i32, i32* %r61
%r63 = call i544 @mulPv512x32(i32* %r2, i32 %r62)
%r64 = zext i544 %r63 to i576
%r65 = add i576 %r60, %r64
%r66 = trunc i576 %r65 to i32
%r67 = mul i32 %r66, %r6
%r68 = call i544 @mulPv512x32(i32* %r4, i32 %r67)
%r69 = zext i544 %r68 to i576
%r70 = add i576 %r65, %r69
%r71 = lshr i576 %r70, 32
%r72 = getelementptr i32, i32* %r3, i32 6
%r73 = load i32, i32* %r72
%r74 = call i544 @mulPv512x32(i32* %r2, i32 %r73)
%r75 = zext i544 %r74 to i576
%r76 = add i576 %r71, %r75
%r77 = trunc i576 %r76 to i32
%r78 = mul i32 %r77, %r6
%r79 = call i544 @mulPv512x32(i32* %r4, i32 %r78)
%r80 = zext i544 %r79 to i576
%r81 = add i576 %r76, %r80
%r82 = lshr i576 %r81, 32
%r83 = getelementptr i32, i32* %r3, i32 7
%r84 = load i32, i32* %r83
%r85 = call i544 @mulPv512x32(i32* %r2, i32 %r84)
%r86 = zext i544 %r85 to i576
%r87 = add i576 %r82, %r86
%r88 = trunc i576 %r87 to i32
%r89 = mul i32 %r88, %r6
%r90 = call i544 @mulPv512x32(i32* %r4, i32 %r89)
%r91 = zext i544 %r90 to i576
%r92 = add i576 %r87, %r91
%r93 = lshr i576 %r92, 32
%r94 = getelementptr i32, i32* %r3, i32 8
%r95 = load i32, i32* %r94
%r96 = call i544 @mulPv512x32(i32* %r2, i32 %r95)
%r97 = zext i544 %r96 to i576
%r98 = add i576 %r93, %r97
%r99 = trunc i576 %r98 to i32
%r100 = mul i32 %r99, %r6
%r101 = call i544 @mulPv512x32(i32* %r4, i32 %r100)
%r102 = zext i544 %r101 to i576
%r103 = add i576 %r98, %r102
%r104 = lshr i576 %r103, 32
%r105 = getelementptr i32, i32* %r3, i32 9
%r106 = load i32, i32* %r105
%r107 = call i544 @mulPv512x32(i32* %r2, i32 %r106)
%r108 = zext i544 %r107 to i576
%r109 = add i576 %r104, %r108
%r110 = trunc i576 %r109 to i32
%r111 = mul i32 %r110, %r6
%r112 = call i544 @mulPv512x32(i32* %r4, i32 %r111)
%r113 = zext i544 %r112 to i576
%r114 = add i576 %r109, %r113
%r115 = lshr i576 %r114, 32
%r116 = getelementptr i32, i32* %r3, i32 10
%r117 = load i32, i32* %r116
%r118 = call i544 @mulPv512x32(i32* %r2, i32 %r117)
%r119 = zext i544 %r118 to i576
%r120 = add i576 %r115, %r119
%r121 = trunc i576 %r120 to i32
%r122 = mul i32 %r121, %r6
%r123 = call i544 @mulPv512x32(i32* %r4, i32 %r122)
%r124 = zext i544 %r123 to i576
%r125 = add i576 %r120, %r124
%r126 = lshr i576 %r125, 32
%r127 = getelementptr i32, i32* %r3, i32 11
%r128 = load i32, i32* %r127
%r129 = call i544 @mulPv512x32(i32* %r2, i32 %r128)
%r130 = zext i544 %r129 to i576
%r131 = add i576 %r126, %r130
%r132 = trunc i576 %r131 to i32
%r133 = mul i32 %r132, %r6
%r134 = call i544 @mulPv512x32(i32* %r4, i32 %r133)
%r135 = zext i544 %r134 to i576
%r136 = add i576 %r131, %r135
%r137 = lshr i576 %r136, 32
%r138 = getelementptr i32, i32* %r3, i32 12
%r139 = load i32, i32* %r138
%r140 = call i544 @mulPv512x32(i32* %r2, i32 %r139)
%r141 = zext i544 %r140 to i576
%r142 = add i576 %r137, %r141
%r143 = trunc i576 %r142 to i32
%r144 = mul i32 %r143, %r6
%r145 = call i544 @mulPv512x32(i32* %r4, i32 %r144)
%r146 = zext i544 %r145 to i576
%r147 = add i576 %r142, %r146
%r148 = lshr i576 %r147, 32
%r149 = getelementptr i32, i32* %r3, i32 13
%r150 = load i32, i32* %r149
%r151 = call i544 @mulPv512x32(i32* %r2, i32 %r150)
%r152 = zext i544 %r151 to i576
%r153 = add i576 %r148, %r152
%r154 = trunc i576 %r153 to i32
%r155 = mul i32 %r154, %r6
%r156 = call i544 @mulPv512x32(i32* %r4, i32 %r155)
%r157 = zext i544 %r156 to i576
%r158 = add i576 %r153, %r157
%r159 = lshr i576 %r158, 32
%r160 = getelementptr i32, i32* %r3, i32 14
%r161 = load i32, i32* %r160
%r162 = call i544 @mulPv512x32(i32* %r2, i32 %r161)
%r163 = zext i544 %r162 to i576
%r164 = add i576 %r159, %r163
%r165 = trunc i576 %r164 to i32
%r166 = mul i32 %r165, %r6
%r167 = call i544 @mulPv512x32(i32* %r4, i32 %r166)
%r168 = zext i544 %r167 to i576
%r169 = add i576 %r164, %r168
%r170 = lshr i576 %r169, 32
%r171 = getelementptr i32, i32* %r3, i32 15
%r172 = load i32, i32* %r171
%r173 = call i544 @mulPv512x32(i32* %r2, i32 %r172)
%r174 = zext i544 %r173 to i576
%r175 = add i576 %r170, %r174
%r176 = trunc i576 %r175 to i32
%r177 = mul i32 %r176, %r6
%r178 = call i544 @mulPv512x32(i32* %r4, i32 %r177)
%r179 = zext i544 %r178 to i576
%r180 = add i576 %r175, %r179
%r181 = lshr i576 %r180, 32
%r182 = trunc i576 %r181 to i544
%r183 = bitcast i32* %r4 to i512*
%r184 = load i512, i512* %r183
%r185 = zext i512 %r184 to i544
%r186 = sub i544 %r182, %r185
%r187 = lshr i544 %r186, 512
%r188 = trunc i544 %r187 to i1
%r189 = select i1 %r188, i544 %r182, i544 %r186
%r190 = trunc i544 %r189 to i512
%r191 = bitcast i32* %r1 to i512*
store i512 %r190, i512* %r191
ret void
}
define void @mcl_fp_montNF16L(i32* %r1, i32* %r2, i32* %r3, i32* %r4)
{
%r5 = getelementptr i32, i32* %r4, i32 -1
%r6 = load i32, i32* %r5
%r7 = load i32, i32* %r3
%r8 = call i544 @mulPv512x32(i32* %r2, i32 %r7)
%r9 = trunc i544 %r8 to i32
%r10 = mul i32 %r9, %r6
%r11 = call i544 @mulPv512x32(i32* %r4, i32 %r10)
%r12 = add i544 %r8, %r11
%r13 = lshr i544 %r12, 32
%r14 = getelementptr i32, i32* %r3, i32 1
%r15 = load i32, i32* %r14
%r16 = call i544 @mulPv512x32(i32* %r2, i32 %r15)
%r17 = add i544 %r13, %r16
%r18 = trunc i544 %r17 to i32
%r19 = mul i32 %r18, %r6
%r20 = call i544 @mulPv512x32(i32* %r4, i32 %r19)
%r21 = add i544 %r17, %r20
%r22 = lshr i544 %r21, 32
%r23 = getelementptr i32, i32* %r3, i32 2
%r24 = load i32, i32* %r23
%r25 = call i544 @mulPv512x32(i32* %r2, i32 %r24)
%r26 = add i544 %r22, %r25
%r27 = trunc i544 %r26 to i32
%r28 = mul i32 %r27, %r6
%r29 = call i544 @mulPv512x32(i32* %r4, i32 %r28)
%r30 = add i544 %r26, %r29
%r31 = lshr i544 %r30, 32
%r32 = getelementptr i32, i32* %r3, i32 3
%r33 = load i32, i32* %r32
%r34 = call i544 @mulPv512x32(i32* %r2, i32 %r33)
%r35 = add i544 %r31, %r34
%r36 = trunc i544 %r35 to i32
%r37 = mul i32 %r36, %r6
%r38 = call i544 @mulPv512x32(i32* %r4, i32 %r37)
%r39 = add i544 %r35, %r38
%r40 = lshr i544 %r39, 32
%r41 = getelementptr i32, i32* %r3, i32 4
%r42 = load i32, i32* %r41
%r43 = call i544 @mulPv512x32(i32* %r2, i32 %r42)
%r44 = add i544 %r40, %r43
%r45 = trunc i544 %r44 to i32
%r46 = mul i32 %r45, %r6
%r47 = call i544 @mulPv512x32(i32* %r4, i32 %r46)
%r48 = add i544 %r44, %r47
%r49 = lshr i544 %r48, 32
%r50 = getelementptr i32, i32* %r3, i32 5
%r51 = load i32, i32* %r50
%r52 = call i544 @mulPv512x32(i32* %r2, i32 %r51)
%r53 = add i544 %r49, %r52
%r54 = trunc i544 %r53 to i32
%r55 = mul i32 %r54, %r6
%r56 = call i544 @mulPv512x32(i32* %r4, i32 %r55)
%r57 = add i544 %r53, %r56
%r58 = lshr i544 %r57, 32
%r59 = getelementptr i32, i32* %r3, i32 6
%r60 = load i32, i32* %r59
%r61 = call i544 @mulPv512x32(i32* %r2, i32 %r60)
%r62 = add i544 %r58, %r61
%r63 = trunc i544 %r62 to i32
%r64 = mul i32 %r63, %r6
%r65 = call i544 @mulPv512x32(i32* %r4, i32 %r64)
%r66 = add i544 %r62, %r65
%r67 = lshr i544 %r66, 32
%r68 = getelementptr i32, i32* %r3, i32 7
%r69 = load i32, i32* %r68
%r70 = call i544 @mulPv512x32(i32* %r2, i32 %r69)
%r71 = add i544 %r67, %r70
%r72 = trunc i544 %r71 to i32
%r73 = mul i32 %r72, %r6
%r74 = call i544 @mulPv512x32(i32* %r4, i32 %r73)
%r75 = add i544 %r71, %r74
%r76 = lshr i544 %r75, 32
%r77 = getelementptr i32, i32* %r3, i32 8
%r78 = load i32, i32* %r77
%r79 = call i544 @mulPv512x32(i32* %r2, i32 %r78)
%r80 = add i544 %r76, %r79
%r81 = trunc i544 %r80 to i32
%r82 = mul i32 %r81, %r6
%r83 = call i544 @mulPv512x32(i32* %r4, i32 %r82)
%r84 = add i544 %r80, %r83
%r85 = lshr i544 %r84, 32
%r86 = getelementptr i32, i32* %r3, i32 9
%r87 = load i32, i32* %r86
%r88 = call i544 @mulPv512x32(i32* %r2, i32 %r87)
%r89 = add i544 %r85, %r88
%r90 = trunc i544 %r89 to i32
%r91 = mul i32 %r90, %r6
%r92 = call i544 @mulPv512x32(i32* %r4, i32 %r91)
%r93 = add i544 %r89, %r92
%r94 = lshr i544 %r93, 32
%r95 = getelementptr i32, i32* %r3, i32 10
%r96 = load i32, i32* %r95
%r97 = call i544 @mulPv512x32(i32* %r2, i32 %r96)
%r98 = add i544 %r94, %r97
%r99 = trunc i544 %r98 to i32
%r100 = mul i32 %r99, %r6
%r101 = call i544 @mulPv512x32(i32* %r4, i32 %r100)
%r102 = add i544 %r98, %r101
%r103 = lshr i544 %r102, 32
%r104 = getelementptr i32, i32* %r3, i32 11
%r105 = load i32, i32* %r104
%r106 = call i544 @mulPv512x32(i32* %r2, i32 %r105)
%r107 = add i544 %r103, %r106
%r108 = trunc i544 %r107 to i32
%r109 = mul i32 %r108, %r6
%r110 = call i544 @mulPv512x32(i32* %r4, i32 %r109)
%r111 = add i544 %r107, %r110
%r112 = lshr i544 %r111, 32
%r113 = getelementptr i32, i32* %r3, i32 12
%r114 = load i32, i32* %r113
%r115 = call i544 @mulPv512x32(i32* %r2, i32 %r114)
%r116 = add i544 %r112, %r115
%r117 = trunc i544 %r116 to i32
%r118 = mul i32 %r117, %r6
%r119 = call i544 @mulPv512x32(i32* %r4, i32 %r118)
%r120 = add i544 %r116, %r119
%r121 = lshr i544 %r120, 32
%r122 = getelementptr i32, i32* %r3, i32 13
%r123 = load i32, i32* %r122
%r124 = call i544 @mulPv512x32(i32* %r2, i32 %r123)
%r125 = add i544 %r121, %r124
%r126 = trunc i544 %r125 to i32
%r127 = mul i32 %r126, %r6
%r128 = call i544 @mulPv512x32(i32* %r4, i32 %r127)
%r129 = add i544 %r125, %r128
%r130 = lshr i544 %r129, 32
%r131 = getelementptr i32, i32* %r3, i32 14
%r132 = load i32, i32* %r131
%r133 = call i544 @mulPv512x32(i32* %r2, i32 %r132)
%r134 = add i544 %r130, %r133
%r135 = trunc i544 %r134 to i32
%r136 = mul i32 %r135, %r6
%r137 = call i544 @mulPv512x32(i32* %r4, i32 %r136)
%r138 = add i544 %r134, %r137
%r139 = lshr i544 %r138, 32
%r140 = getelementptr i32, i32* %r3, i32 15
%r141 = load i32, i32* %r140
%r142 = call i544 @mulPv512x32(i32* %r2, i32 %r141)
%r143 = add i544 %r139, %r142
%r144 = trunc i544 %r143 to i32
%r145 = mul i32 %r144, %r6
%r146 = call i544 @mulPv512x32(i32* %r4, i32 %r145)
%r147 = add i544 %r143, %r146
%r148 = lshr i544 %r147, 32
%r149 = trunc i544 %r148 to i512
%r150 = bitcast i32* %r4 to i512*
%r151 = load i512, i512* %r150
%r152 = sub i512 %r149, %r151
%r153 = lshr i512 %r152, 511
%r154 = trunc i512 %r153 to i1
%r155 = select i1 %r154, i512 %r149, i512 %r152
%r156 = bitcast i32* %r1 to i512*
store i512 %r155, i512* %r156
ret void
}
define void @mcl_fp_montRed16L(i32* noalias %r1, i32* noalias %r2, i32* noalias %r3)
{
%r4 = getelementptr i32, i32* %r3, i32 -1
%r5 = load i32, i32* %r4
%r6 = bitcast i32* %r3 to i512*
%r7 = load i512, i512* %r6
%r8 = bitcast i32* %r2 to i512*
%r9 = load i512, i512* %r8
%r10 = trunc i512 %r9 to i32
%r11 = mul i32 %r10, %r5
%r12 = call i544 @mulPv512x32(i32* %r3, i32 %r11)
%r13 = getelementptr i32, i32* %r2, i32 16
%r14 = load i32, i32* %r13
%r15 = zext i512 %r9 to i544
%r16 = zext i32 %r14 to i544
%r17 = shl i544 %r16, 512
%r18 = or i544 %r15, %r17
%r19 = zext i544 %r18 to i576
%r20 = zext i544 %r12 to i576
%r21 = add i576 %r19, %r20
%r22 = lshr i576 %r21, 32
%r23 = trunc i576 %r22 to i544
%r24 = lshr i544 %r23, 512
%r25 = trunc i544 %r24 to i32
%r26 = trunc i544 %r23 to i512
%r27 = trunc i512 %r26 to i32
%r28 = mul i32 %r27, %r5
%r29 = call i544 @mulPv512x32(i32* %r3, i32 %r28)
%r30 = zext i32 %r25 to i544
%r31 = shl i544 %r30, 512
%r32 = add i544 %r29, %r31
%r33 = getelementptr i32, i32* %r2, i32 17
%r34 = load i32, i32* %r33
%r35 = zext i512 %r26 to i544
%r36 = zext i32 %r34 to i544
%r37 = shl i544 %r36, 512
%r38 = or i544 %r35, %r37
%r39 = zext i544 %r38 to i576
%r40 = zext i544 %r32 to i576
%r41 = add i576 %r39, %r40
%r42 = lshr i576 %r41, 32
%r43 = trunc i576 %r42 to i544
%r44 = lshr i544 %r43, 512
%r45 = trunc i544 %r44 to i32
%r46 = trunc i544 %r43 to i512
%r47 = trunc i512 %r46 to i32
%r48 = mul i32 %r47, %r5
%r49 = call i544 @mulPv512x32(i32* %r3, i32 %r48)
%r50 = zext i32 %r45 to i544
%r51 = shl i544 %r50, 512
%r52 = add i544 %r49, %r51
%r53 = getelementptr i32, i32* %r2, i32 18
%r54 = load i32, i32* %r53
%r55 = zext i512 %r46 to i544
%r56 = zext i32 %r54 to i544
%r57 = shl i544 %r56, 512
%r58 = or i544 %r55, %r57
%r59 = zext i544 %r58 to i576
%r60 = zext i544 %r52 to i576
%r61 = add i576 %r59, %r60
%r62 = lshr i576 %r61, 32
%r63 = trunc i576 %r62 to i544
%r64 = lshr i544 %r63, 512
%r65 = trunc i544 %r64 to i32
%r66 = trunc i544 %r63 to i512
%r67 = trunc i512 %r66 to i32
%r68 = mul i32 %r67, %r5
%r69 = call i544 @mulPv512x32(i32* %r3, i32 %r68)
%r70 = zext i32 %r65 to i544
%r71 = shl i544 %r70, 512
%r72 = add i544 %r69, %r71
%r73 = getelementptr i32, i32* %r2, i32 19
%r74 = load i32, i32* %r73
%r75 = zext i512 %r66 to i544
%r76 = zext i32 %r74 to i544
%r77 = shl i544 %r76, 512
%r78 = or i544 %r75, %r77
%r79 = zext i544 %r78 to i576
%r80 = zext i544 %r72 to i576
%r81 = add i576 %r79, %r80
%r82 = lshr i576 %r81, 32
%r83 = trunc i576 %r82 to i544
%r84 = lshr i544 %r83, 512
%r85 = trunc i544 %r84 to i32
%r86 = trunc i544 %r83 to i512
%r87 = trunc i512 %r86 to i32
%r88 = mul i32 %r87, %r5
%r89 = call i544 @mulPv512x32(i32* %r3, i32 %r88)
%r90 = zext i32 %r85 to i544
%r91 = shl i544 %r90, 512
%r92 = add i544 %r89, %r91
%r93 = getelementptr i32, i32* %r2, i32 20
%r94 = load i32, i32* %r93
%r95 = zext i512 %r86 to i544
%r96 = zext i32 %r94 to i544
%r97 = shl i544 %r96, 512
%r98 = or i544 %r95, %r97
%r99 = zext i544 %r98 to i576
%r100 = zext i544 %r92 to i576
%r101 = add i576 %r99, %r100
%r102 = lshr i576 %r101, 32
%r103 = trunc i576 %r102 to i544
%r104 = lshr i544 %r103, 512
%r105 = trunc i544 %r104 to i32
%r106 = trunc i544 %r103 to i512
%r107 = trunc i512 %r106 to i32
%r108 = mul i32 %r107, %r5
%r109 = call i544 @mulPv512x32(i32* %r3, i32 %r108)
%r110 = zext i32 %r105 to i544
%r111 = shl i544 %r110, 512
%r112 = add i544 %r109, %r111
%r113 = getelementptr i32, i32* %r2, i32 21
%r114 = load i32, i32* %r113
%r115 = zext i512 %r106 to i544
%r116 = zext i32 %r114 to i544
%r117 = shl i544 %r116, 512
%r118 = or i544 %r115, %r117
%r119 = zext i544 %r118 to i576
%r120 = zext i544 %r112 to i576
%r121 = add i576 %r119, %r120
%r122 = lshr i576 %r121, 32
%r123 = trunc i576 %r122 to i544
%r124 = lshr i544 %r123, 512
%r125 = trunc i544 %r124 to i32
%r126 = trunc i544 %r123 to i512
%r127 = trunc i512 %r126 to i32
%r128 = mul i32 %r127, %r5
%r129 = call i544 @mulPv512x32(i32* %r3, i32 %r128)
%r130 = zext i32 %r125 to i544
%r131 = shl i544 %r130, 512
%r132 = add i544 %r129, %r131
%r133 = getelementptr i32, i32* %r2, i32 22
%r134 = load i32, i32* %r133
%r135 = zext i512 %r126 to i544
%r136 = zext i32 %r134 to i544
%r137 = shl i544 %r136, 512
%r138 = or i544 %r135, %r137
%r139 = zext i544 %r138 to i576
%r140 = zext i544 %r132 to i576
%r141 = add i576 %r139, %r140
%r142 = lshr i576 %r141, 32
%r143 = trunc i576 %r142 to i544
%r144 = lshr i544 %r143, 512
%r145 = trunc i544 %r144 to i32
%r146 = trunc i544 %r143 to i512
%r147 = trunc i512 %r146 to i32
%r148 = mul i32 %r147, %r5
%r149 = call i544 @mulPv512x32(i32* %r3, i32 %r148)
%r150 = zext i32 %r145 to i544
%r151 = shl i544 %r150, 512
%r152 = add i544 %r149, %r151
%r153 = getelementptr i32, i32* %r2, i32 23
%r154 = load i32, i32* %r153
%r155 = zext i512 %r146 to i544
%r156 = zext i32 %r154 to i544
%r157 = shl i544 %r156, 512
%r158 = or i544 %r155, %r157
%r159 = zext i544 %r158 to i576
%r160 = zext i544 %r152 to i576
%r161 = add i576 %r159, %r160
%r162 = lshr i576 %r161, 32
%r163 = trunc i576 %r162 to i544
%r164 = lshr i544 %r163, 512
%r165 = trunc i544 %r164 to i32
%r166 = trunc i544 %r163 to i512
%r167 = trunc i512 %r166 to i32
%r168 = mul i32 %r167, %r5
%r169 = call i544 @mulPv512x32(i32* %r3, i32 %r168)
%r170 = zext i32 %r165 to i544
%r171 = shl i544 %r170, 512
%r172 = add i544 %r169, %r171
%r173 = getelementptr i32, i32* %r2, i32 24
%r174 = load i32, i32* %r173
%r175 = zext i512 %r166 to i544
%r176 = zext i32 %r174 to i544
%r177 = shl i544 %r176, 512
%r178 = or i544 %r175, %r177
%r179 = zext i544 %r178 to i576
%r180 = zext i544 %r172 to i576
%r181 = add i576 %r179, %r180
%r182 = lshr i576 %r181, 32
%r183 = trunc i576 %r182 to i544
%r184 = lshr i544 %r183, 512
%r185 = trunc i544 %r184 to i32
%r186 = trunc i544 %r183 to i512
%r187 = trunc i512 %r186 to i32
%r188 = mul i32 %r187, %r5
%r189 = call i544 @mulPv512x32(i32* %r3, i32 %r188)
%r190 = zext i32 %r185 to i544
%r191 = shl i544 %r190, 512
%r192 = add i544 %r189, %r191
%r193 = getelementptr i32, i32* %r2, i32 25
%r194 = load i32, i32* %r193
%r195 = zext i512 %r186 to i544
%r196 = zext i32 %r194 to i544
%r197 = shl i544 %r196, 512
%r198 = or i544 %r195, %r197
%r199 = zext i544 %r198 to i576
%r200 = zext i544 %r192 to i576
%r201 = add i576 %r199, %r200
%r202 = lshr i576 %r201, 32
%r203 = trunc i576 %r202 to i544
%r204 = lshr i544 %r203, 512
%r205 = trunc i544 %r204 to i32
%r206 = trunc i544 %r203 to i512
%r207 = trunc i512 %r206 to i32
%r208 = mul i32 %r207, %r5
%r209 = call i544 @mulPv512x32(i32* %r3, i32 %r208)
%r210 = zext i32 %r205 to i544
%r211 = shl i544 %r210, 512
%r212 = add i544 %r209, %r211
%r213 = getelementptr i32, i32* %r2, i32 26
%r214 = load i32, i32* %r213
%r215 = zext i512 %r206 to i544
%r216 = zext i32 %r214 to i544
%r217 = shl i544 %r216, 512
%r218 = or i544 %r215, %r217
%r219 = zext i544 %r218 to i576
%r220 = zext i544 %r212 to i576
%r221 = add i576 %r219, %r220
%r222 = lshr i576 %r221, 32
%r223 = trunc i576 %r222 to i544
%r224 = lshr i544 %r223, 512
%r225 = trunc i544 %r224 to i32
%r226 = trunc i544 %r223 to i512
%r227 = trunc i512 %r226 to i32
%r228 = mul i32 %r227, %r5
%r229 = call i544 @mulPv512x32(i32* %r3, i32 %r228)
%r230 = zext i32 %r225 to i544
%r231 = shl i544 %r230, 512
%r232 = add i544 %r229, %r231
%r233 = getelementptr i32, i32* %r2, i32 27
%r234 = load i32, i32* %r233
%r235 = zext i512 %r226 to i544
%r236 = zext i32 %r234 to i544
%r237 = shl i544 %r236, 512
%r238 = or i544 %r235, %r237
%r239 = zext i544 %r238 to i576
%r240 = zext i544 %r232 to i576
%r241 = add i576 %r239, %r240
%r242 = lshr i576 %r241, 32
%r243 = trunc i576 %r242 to i544
%r244 = lshr i544 %r243, 512
%r245 = trunc i544 %r244 to i32
%r246 = trunc i544 %r243 to i512
%r247 = trunc i512 %r246 to i32
%r248 = mul i32 %r247, %r5
%r249 = call i544 @mulPv512x32(i32* %r3, i32 %r248)
%r250 = zext i32 %r245 to i544
%r251 = shl i544 %r250, 512
%r252 = add i544 %r249, %r251
%r253 = getelementptr i32, i32* %r2, i32 28
%r254 = load i32, i32* %r253
%r255 = zext i512 %r246 to i544
%r256 = zext i32 %r254 to i544
%r257 = shl i544 %r256, 512
%r258 = or i544 %r255, %r257
%r259 = zext i544 %r258 to i576
%r260 = zext i544 %r252 to i576
%r261 = add i576 %r259, %r260
%r262 = lshr i576 %r261, 32
%r263 = trunc i576 %r262 to i544
%r264 = lshr i544 %r263, 512
%r265 = trunc i544 %r264 to i32
%r266 = trunc i544 %r263 to i512
%r267 = trunc i512 %r266 to i32
%r268 = mul i32 %r267, %r5
%r269 = call i544 @mulPv512x32(i32* %r3, i32 %r268)
%r270 = zext i32 %r265 to i544
%r271 = shl i544 %r270, 512
%r272 = add i544 %r269, %r271
%r273 = getelementptr i32, i32* %r2, i32 29
%r274 = load i32, i32* %r273
%r275 = zext i512 %r266 to i544
%r276 = zext i32 %r274 to i544
%r277 = shl i544 %r276, 512
%r278 = or i544 %r275, %r277
%r279 = zext i544 %r278 to i576
%r280 = zext i544 %r272 to i576
%r281 = add i576 %r279, %r280
%r282 = lshr i576 %r281, 32
%r283 = trunc i576 %r282 to i544
%r284 = lshr i544 %r283, 512
%r285 = trunc i544 %r284 to i32
%r286 = trunc i544 %r283 to i512
%r287 = trunc i512 %r286 to i32
%r288 = mul i32 %r287, %r5
%r289 = call i544 @mulPv512x32(i32* %r3, i32 %r288)
%r290 = zext i32 %r285 to i544
%r291 = shl i544 %r290, 512
%r292 = add i544 %r289, %r291
%r293 = getelementptr i32, i32* %r2, i32 30
%r294 = load i32, i32* %r293
%r295 = zext i512 %r286 to i544
%r296 = zext i32 %r294 to i544
%r297 = shl i544 %r296, 512
%r298 = or i544 %r295, %r297
%r299 = zext i544 %r298 to i576
%r300 = zext i544 %r292 to i576
%r301 = add i576 %r299, %r300
%r302 = lshr i576 %r301, 32
%r303 = trunc i576 %r302 to i544
%r304 = lshr i544 %r303, 512
%r305 = trunc i544 %r304 to i32
%r306 = trunc i544 %r303 to i512
%r307 = trunc i512 %r306 to i32
%r308 = mul i32 %r307, %r5
%r309 = call i544 @mulPv512x32(i32* %r3, i32 %r308)
%r310 = zext i32 %r305 to i544
%r311 = shl i544 %r310, 512
%r312 = add i544 %r309, %r311
%r313 = getelementptr i32, i32* %r2, i32 31
%r314 = load i32, i32* %r313
%r315 = zext i512 %r306 to i544
%r316 = zext i32 %r314 to i544
%r317 = shl i544 %r316, 512
%r318 = or i544 %r315, %r317
%r319 = zext i544 %r318 to i576
%r320 = zext i544 %r312 to i576
%r321 = add i576 %r319, %r320
%r322 = lshr i576 %r321, 32
%r323 = trunc i576 %r322 to i544
%r324 = lshr i544 %r323, 512
%r325 = trunc i544 %r324 to i32
%r326 = trunc i544 %r323 to i512
%r327 = zext i512 %r7 to i544
%r328 = zext i512 %r326 to i544
%r329 = zext i32 %r325 to i544
%r330 = shl i544 %r329, 512
%r331 = or i544 %r328, %r330
%r332 = sub i544 %r331, %r327
%r333 = lshr i544 %r332, 512
%r334 = trunc i544 %r333 to i1
%r335 = select i1 %r334, i544 %r331, i544 %r332
%r336 = trunc i544 %r335 to i512
%r337 = bitcast i32* %r1 to i512*
store i512 %r336, i512* %r337
ret void
}
define void @mcl_fp_montRedNF16L(i32* noalias %r1, i32* noalias %r2, i32* noalias %r3)
{
%r4 = getelementptr i32, i32* %r3, i32 -1
%r5 = load i32, i32* %r4
%r6 = bitcast i32* %r3 to i512*
%r7 = load i512, i512* %r6
%r8 = bitcast i32* %r2 to i512*
%r9 = load i512, i512* %r8
%r10 = trunc i512 %r9 to i32
%r11 = mul i32 %r10, %r5
%r12 = call i544 @mulPv512x32(i32* %r3, i32 %r11)
%r13 = getelementptr i32, i32* %r2, i32 16
%r14 = load i32, i32* %r13
%r15 = zext i512 %r9 to i544
%r16 = zext i32 %r14 to i544
%r17 = shl i544 %r16, 512
%r18 = or i544 %r15, %r17
%r19 = zext i544 %r18 to i576
%r20 = zext i544 %r12 to i576
%r21 = add i576 %r19, %r20
%r22 = lshr i576 %r21, 32
%r23 = trunc i576 %r22 to i544
%r24 = lshr i544 %r23, 512
%r25 = trunc i544 %r24 to i32
%r26 = trunc i544 %r23 to i512
%r27 = trunc i512 %r26 to i32
%r28 = mul i32 %r27, %r5
%r29 = call i544 @mulPv512x32(i32* %r3, i32 %r28)
%r30 = zext i32 %r25 to i544
%r31 = shl i544 %r30, 512
%r32 = add i544 %r29, %r31
%r33 = getelementptr i32, i32* %r2, i32 17
%r34 = load i32, i32* %r33
%r35 = zext i512 %r26 to i544
%r36 = zext i32 %r34 to i544
%r37 = shl i544 %r36, 512
%r38 = or i544 %r35, %r37
%r39 = zext i544 %r38 to i576
%r40 = zext i544 %r32 to i576
%r41 = add i576 %r39, %r40
%r42 = lshr i576 %r41, 32
%r43 = trunc i576 %r42 to i544
%r44 = lshr i544 %r43, 512
%r45 = trunc i544 %r44 to i32
%r46 = trunc i544 %r43 to i512
%r47 = trunc i512 %r46 to i32
%r48 = mul i32 %r47, %r5
%r49 = call i544 @mulPv512x32(i32* %r3, i32 %r48)
%r50 = zext i32 %r45 to i544
%r51 = shl i544 %r50, 512
%r52 = add i544 %r49, %r51
%r53 = getelementptr i32, i32* %r2, i32 18
%r54 = load i32, i32* %r53
%r55 = zext i512 %r46 to i544
%r56 = zext i32 %r54 to i544
%r57 = shl i544 %r56, 512
%r58 = or i544 %r55, %r57
%r59 = zext i544 %r58 to i576
%r60 = zext i544 %r52 to i576
%r61 = add i576 %r59, %r60
%r62 = lshr i576 %r61, 32
%r63 = trunc i576 %r62 to i544
%r64 = lshr i544 %r63, 512
%r65 = trunc i544 %r64 to i32
%r66 = trunc i544 %r63 to i512
%r67 = trunc i512 %r66 to i32
%r68 = mul i32 %r67, %r5
%r69 = call i544 @mulPv512x32(i32* %r3, i32 %r68)
%r70 = zext i32 %r65 to i544
%r71 = shl i544 %r70, 512
%r72 = add i544 %r69, %r71
%r73 = getelementptr i32, i32* %r2, i32 19
%r74 = load i32, i32* %r73
%r75 = zext i512 %r66 to i544
%r76 = zext i32 %r74 to i544
%r77 = shl i544 %r76, 512
%r78 = or i544 %r75, %r77
%r79 = zext i544 %r78 to i576
%r80 = zext i544 %r72 to i576
%r81 = add i576 %r79, %r80
%r82 = lshr i576 %r81, 32
%r83 = trunc i576 %r82 to i544
%r84 = lshr i544 %r83, 512
%r85 = trunc i544 %r84 to i32
%r86 = trunc i544 %r83 to i512
%r87 = trunc i512 %r86 to i32
%r88 = mul i32 %r87, %r5
%r89 = call i544 @mulPv512x32(i32* %r3, i32 %r88)
%r90 = zext i32 %r85 to i544
%r91 = shl i544 %r90, 512
%r92 = add i544 %r89, %r91
%r93 = getelementptr i32, i32* %r2, i32 20
%r94 = load i32, i32* %r93
%r95 = zext i512 %r86 to i544
%r96 = zext i32 %r94 to i544
%r97 = shl i544 %r96, 512
%r98 = or i544 %r95, %r97
%r99 = zext i544 %r98 to i576
%r100 = zext i544 %r92 to i576
%r101 = add i576 %r99, %r100
%r102 = lshr i576 %r101, 32
%r103 = trunc i576 %r102 to i544
%r104 = lshr i544 %r103, 512
%r105 = trunc i544 %r104 to i32
%r106 = trunc i544 %r103 to i512
%r107 = trunc i512 %r106 to i32
%r108 = mul i32 %r107, %r5
%r109 = call i544 @mulPv512x32(i32* %r3, i32 %r108)
%r110 = zext i32 %r105 to i544
%r111 = shl i544 %r110, 512
%r112 = add i544 %r109, %r111
%r113 = getelementptr i32, i32* %r2, i32 21
%r114 = load i32, i32* %r113
%r115 = zext i512 %r106 to i544
%r116 = zext i32 %r114 to i544
%r117 = shl i544 %r116, 512
%r118 = or i544 %r115, %r117
%r119 = zext i544 %r118 to i576
%r120 = zext i544 %r112 to i576
%r121 = add i576 %r119, %r120
%r122 = lshr i576 %r121, 32
%r123 = trunc i576 %r122 to i544
%r124 = lshr i544 %r123, 512
%r125 = trunc i544 %r124 to i32
%r126 = trunc i544 %r123 to i512
%r127 = trunc i512 %r126 to i32
%r128 = mul i32 %r127, %r5
%r129 = call i544 @mulPv512x32(i32* %r3, i32 %r128)
%r130 = zext i32 %r125 to i544
%r131 = shl i544 %r130, 512
%r132 = add i544 %r129, %r131
%r133 = getelementptr i32, i32* %r2, i32 22
%r134 = load i32, i32* %r133
%r135 = zext i512 %r126 to i544
%r136 = zext i32 %r134 to i544
%r137 = shl i544 %r136, 512
%r138 = or i544 %r135, %r137
%r139 = zext i544 %r138 to i576
%r140 = zext i544 %r132 to i576
%r141 = add i576 %r139, %r140
%r142 = lshr i576 %r141, 32
%r143 = trunc i576 %r142 to i544
%r144 = lshr i544 %r143, 512
%r145 = trunc i544 %r144 to i32
%r146 = trunc i544 %r143 to i512
%r147 = trunc i512 %r146 to i32
%r148 = mul i32 %r147, %r5
%r149 = call i544 @mulPv512x32(i32* %r3, i32 %r148)
%r150 = zext i32 %r145 to i544
%r151 = shl i544 %r150, 512
%r152 = add i544 %r149, %r151
%r153 = getelementptr i32, i32* %r2, i32 23
%r154 = load i32, i32* %r153
%r155 = zext i512 %r146 to i544
%r156 = zext i32 %r154 to i544
%r157 = shl i544 %r156, 512
%r158 = or i544 %r155, %r157
%r159 = zext i544 %r158 to i576
%r160 = zext i544 %r152 to i576
%r161 = add i576 %r159, %r160
%r162 = lshr i576 %r161, 32
%r163 = trunc i576 %r162 to i544
%r164 = lshr i544 %r163, 512
%r165 = trunc i544 %r164 to i32
%r166 = trunc i544 %r163 to i512
%r167 = trunc i512 %r166 to i32
%r168 = mul i32 %r167, %r5
%r169 = call i544 @mulPv512x32(i32* %r3, i32 %r168)
%r170 = zext i32 %r165 to i544
%r171 = shl i544 %r170, 512
%r172 = add i544 %r169, %r171
%r173 = getelementptr i32, i32* %r2, i32 24
%r174 = load i32, i32* %r173
%r175 = zext i512 %r166 to i544
%r176 = zext i32 %r174 to i544
%r177 = shl i544 %r176, 512
%r178 = or i544 %r175, %r177
%r179 = zext i544 %r178 to i576
%r180 = zext i544 %r172 to i576
%r181 = add i576 %r179, %r180
%r182 = lshr i576 %r181, 32
%r183 = trunc i576 %r182 to i544
%r184 = lshr i544 %r183, 512
%r185 = trunc i544 %r184 to i32
%r186 = trunc i544 %r183 to i512
%r187 = trunc i512 %r186 to i32
%r188 = mul i32 %r187, %r5
%r189 = call i544 @mulPv512x32(i32* %r3, i32 %r188)
%r190 = zext i32 %r185 to i544
%r191 = shl i544 %r190, 512
%r192 = add i544 %r189, %r191
%r193 = getelementptr i32, i32* %r2, i32 25
%r194 = load i32, i32* %r193
%r195 = zext i512 %r186 to i544
%r196 = zext i32 %r194 to i544
%r197 = shl i544 %r196, 512
%r198 = or i544 %r195, %r197
%r199 = zext i544 %r198 to i576
%r200 = zext i544 %r192 to i576
%r201 = add i576 %r199, %r200
%r202 = lshr i576 %r201, 32
%r203 = trunc i576 %r202 to i544
%r204 = lshr i544 %r203, 512
%r205 = trunc i544 %r204 to i32
%r206 = trunc i544 %r203 to i512
%r207 = trunc i512 %r206 to i32
%r208 = mul i32 %r207, %r5
%r209 = call i544 @mulPv512x32(i32* %r3, i32 %r208)
%r210 = zext i32 %r205 to i544
%r211 = shl i544 %r210, 512
%r212 = add i544 %r209, %r211
%r213 = getelementptr i32, i32* %r2, i32 26
%r214 = load i32, i32* %r213
%r215 = zext i512 %r206 to i544
%r216 = zext i32 %r214 to i544
%r217 = shl i544 %r216, 512
%r218 = or i544 %r215, %r217
%r219 = zext i544 %r218 to i576
%r220 = zext i544 %r212 to i576
%r221 = add i576 %r219, %r220
%r222 = lshr i576 %r221, 32
%r223 = trunc i576 %r222 to i544
%r224 = lshr i544 %r223, 512
%r225 = trunc i544 %r224 to i32
%r226 = trunc i544 %r223 to i512
%r227 = trunc i512 %r226 to i32
%r228 = mul i32 %r227, %r5
%r229 = call i544 @mulPv512x32(i32* %r3, i32 %r228)
%r230 = zext i32 %r225 to i544
%r231 = shl i544 %r230, 512
%r232 = add i544 %r229, %r231
%r233 = getelementptr i32, i32* %r2, i32 27
%r234 = load i32, i32* %r233
%r235 = zext i512 %r226 to i544
%r236 = zext i32 %r234 to i544
%r237 = shl i544 %r236, 512
%r238 = or i544 %r235, %r237
%r239 = zext i544 %r238 to i576
%r240 = zext i544 %r232 to i576
%r241 = add i576 %r239, %r240
%r242 = lshr i576 %r241, 32
%r243 = trunc i576 %r242 to i544
%r244 = lshr i544 %r243, 512
%r245 = trunc i544 %r244 to i32
%r246 = trunc i544 %r243 to i512
%r247 = trunc i512 %r246 to i32
%r248 = mul i32 %r247, %r5
%r249 = call i544 @mulPv512x32(i32* %r3, i32 %r248)
%r250 = zext i32 %r245 to i544
%r251 = shl i544 %r250, 512
%r252 = add i544 %r249, %r251
%r253 = getelementptr i32, i32* %r2, i32 28
%r254 = load i32, i32* %r253
%r255 = zext i512 %r246 to i544
%r256 = zext i32 %r254 to i544
%r257 = shl i544 %r256, 512
%r258 = or i544 %r255, %r257
%r259 = zext i544 %r258 to i576
%r260 = zext i544 %r252 to i576
%r261 = add i576 %r259, %r260
%r262 = lshr i576 %r261, 32
%r263 = trunc i576 %r262 to i544
%r264 = lshr i544 %r263, 512
%r265 = trunc i544 %r264 to i32
%r266 = trunc i544 %r263 to i512
%r267 = trunc i512 %r266 to i32
%r268 = mul i32 %r267, %r5
%r269 = call i544 @mulPv512x32(i32* %r3, i32 %r268)
%r270 = zext i32 %r265 to i544
%r271 = shl i544 %r270, 512
%r272 = add i544 %r269, %r271
%r273 = getelementptr i32, i32* %r2, i32 29
%r274 = load i32, i32* %r273
%r275 = zext i512 %r266 to i544
%r276 = zext i32 %r274 to i544
%r277 = shl i544 %r276, 512
%r278 = or i544 %r275, %r277
%r279 = zext i544 %r278 to i576
%r280 = zext i544 %r272 to i576
%r281 = add i576 %r279, %r280
%r282 = lshr i576 %r281, 32
%r283 = trunc i576 %r282 to i544
%r284 = lshr i544 %r283, 512
%r285 = trunc i544 %r284 to i32
%r286 = trunc i544 %r283 to i512
%r287 = trunc i512 %r286 to i32
%r288 = mul i32 %r287, %r5
%r289 = call i544 @mulPv512x32(i32* %r3, i32 %r288)
%r290 = zext i32 %r285 to i544
%r291 = shl i544 %r290, 512
%r292 = add i544 %r289, %r291
%r293 = getelementptr i32, i32* %r2, i32 30
%r294 = load i32, i32* %r293
%r295 = zext i512 %r286 to i544
%r296 = zext i32 %r294 to i544
%r297 = shl i544 %r296, 512
%r298 = or i544 %r295, %r297
%r299 = zext i544 %r298 to i576
%r300 = zext i544 %r292 to i576
%r301 = add i576 %r299, %r300
%r302 = lshr i576 %r301, 32
%r303 = trunc i576 %r302 to i544
%r304 = lshr i544 %r303, 512
%r305 = trunc i544 %r304 to i32
%r306 = trunc i544 %r303 to i512
%r307 = trunc i512 %r306 to i32
%r308 = mul i32 %r307, %r5
%r309 = call i544 @mulPv512x32(i32* %r3, i32 %r308)
%r310 = zext i32 %r305 to i544
%r311 = shl i544 %r310, 512
%r312 = add i544 %r309, %r311
%r313 = getelementptr i32, i32* %r2, i32 31
%r314 = load i32, i32* %r313
%r315 = zext i512 %r306 to i544
%r316 = zext i32 %r314 to i544
%r317 = shl i544 %r316, 512
%r318 = or i544 %r315, %r317
%r319 = zext i544 %r318 to i576
%r320 = zext i544 %r312 to i576
%r321 = add i576 %r319, %r320
%r322 = lshr i576 %r321, 32
%r323 = trunc i576 %r322 to i544
%r324 = lshr i544 %r323, 512
%r325 = trunc i544 %r324 to i32
%r326 = trunc i544 %r323 to i512
%r327 = sub i512 %r326, %r7
%r328 = lshr i512 %r327, 511
%r329 = trunc i512 %r328 to i1
%r330 = select i1 %r329, i512 %r326, i512 %r327
%r331 = bitcast i32* %r1 to i512*
store i512 %r330, i512* %r331
ret void
}
define i32 @mcl_fp_addPre16L(i32* noalias %r1, i32* noalias %r2, i32* noalias %r3)
{
%r5 = bitcast i32* %r2 to i512*
%r6 = load i512, i512* %r5
%r7 = zext i512 %r6 to i544
%r8 = bitcast i32* %r3 to i512*
%r9 = load i512, i512* %r8
%r10 = zext i512 %r9 to i544
%r11 = add i544 %r7, %r10
%r12 = trunc i544 %r11 to i512
%r13 = bitcast i32* %r1 to i512*
store i512 %r12, i512* %r13
%r14 = lshr i544 %r11, 512
%r15 = trunc i544 %r14 to i32
ret i32 %r15
}
define i32 @mcl_fp_subPre16L(i32* noalias %r1, i32* noalias %r2, i32* noalias %r3)
{
%r5 = bitcast i32* %r2 to i512*
%r6 = load i512, i512* %r5
%r7 = zext i512 %r6 to i544
%r8 = bitcast i32* %r3 to i512*
%r9 = load i512, i512* %r8
%r10 = zext i512 %r9 to i544
%r11 = sub i544 %r7, %r10
%r12 = trunc i544 %r11 to i512
%r13 = bitcast i32* %r1 to i512*
store i512 %r12, i512* %r13
%r14 = lshr i544 %r11, 512
%r15 = trunc i544 %r14 to i32
%r16 = and i32 %r15, 1
ret i32 %r16
}
define void @mcl_fp_shr1_16L(i32* noalias %r1, i32* noalias %r2)
{
%r3 = bitcast i32* %r2 to i512*
%r4 = load i512, i512* %r3
%r5 = lshr i512 %r4, 1
%r6 = bitcast i32* %r1 to i512*
store i512 %r5, i512* %r6
ret void
}
define void @mcl_fp_add16L(i32* noalias %r1, i32* noalias %r2, i32* noalias %r3, i32* noalias %r4)
{
%r5 = bitcast i32* %r2 to i512*
%r6 = load i512, i512* %r5
%r7 = bitcast i32* %r3 to i512*
%r8 = load i512, i512* %r7
%r9 = bitcast i32* %r4 to i512*
%r10 = load i512, i512* %r9
%r11 = zext i512 %r6 to i544
%r12 = zext i512 %r8 to i544
%r13 = add i544 %r11, %r12
%r14 = zext i512 %r10 to i544
%r15 = sub i544 %r13, %r14
%r16 = lshr i544 %r15, 512
%r17 = trunc i544 %r16 to i1
%r18 = select i1 %r17, i544 %r13, i544 %r15
%r19 = trunc i544 %r18 to i512
%r20 = bitcast i32* %r1 to i512*
store i512 %r19, i512* %r20
ret void
}
define void @mcl_fp_addNF16L(i32* noalias %r1, i32* noalias %r2, i32* noalias %r3, i32* noalias %r4)
{
%r5 = bitcast i32* %r2 to i512*
%r6 = load i512, i512* %r5
%r7 = bitcast i32* %r3 to i512*
%r8 = load i512, i512* %r7
%r9 = bitcast i32* %r4 to i512*
%r10 = load i512, i512* %r9
%r11 = add i512 %r6, %r8
%r12 = sub i512 %r11, %r10
%r13 = lshr i512 %r12, 511
%r14 = trunc i512 %r13 to i1
%r15 = select i1 %r14, i512 %r11, i512 %r12
%r16 = bitcast i32* %r1 to i512*
store i512 %r15, i512* %r16
ret void
}
define void @mcl_fp_sub16L(i32* noalias %r1, i32* noalias %r2, i32* noalias %r3, i32* noalias %r4)
{
%r5 = bitcast i32* %r2 to i512*
%r6 = load i512, i512* %r5
%r7 = bitcast i32* %r3 to i512*
%r8 = load i512, i512* %r7
%r9 = zext i512 %r6 to i544
%r10 = zext i512 %r8 to i544
%r11 = sub i544 %r9, %r10
%r12 = lshr i544 %r11, 512
%r13 = trunc i544 %r12 to i1
%r14 = trunc i544 %r11 to i512
%r15 = bitcast i32* %r4 to i512*
%r16 = load i512, i512* %r15
%r17 = select i1 %r13, i512 %r16, i512 0
%r18 = add i512 %r14, %r17
%r19 = bitcast i32* %r1 to i512*
store i512 %r18, i512* %r19
ret void
}
define void @mcl_fp_subNF16L(i32* noalias %r1, i32* noalias %r2, i32* noalias %r3, i32* noalias %r4)
{
%r5 = bitcast i32* %r2 to i512*
%r6 = load i512, i512* %r5
%r7 = bitcast i32* %r3 to i512*
%r8 = load i512, i512* %r7
%r9 = sub i512 %r6, %r8
%r10 = lshr i512 %r9, 511
%r11 = trunc i512 %r10 to i1
%r12 = bitcast i32* %r4 to i512*
%r13 = load i512, i512* %r12
%r14 = select i1 %r11, i512 %r13, i512 0
%r15 = add i512 %r9, %r14
%r16 = bitcast i32* %r1 to i512*
store i512 %r15, i512* %r16
ret void
}
define void @mcl_fpDbl_add16L(i32* noalias %r1, i32* noalias %r2, i32* noalias %r3, i32* noalias %r4)
{
%r5 = bitcast i32* %r2 to i1024*
%r6 = load i1024, i1024* %r5
%r7 = bitcast i32* %r3 to i1024*
%r8 = load i1024, i1024* %r7
%r9 = zext i1024 %r6 to i1056
%r10 = zext i1024 %r8 to i1056
%r11 = add i1056 %r9, %r10
%r12 = trunc i1056 %r11 to i512
%r13 = bitcast i32* %r1 to i512*
store i512 %r12, i512* %r13
%r14 = lshr i1056 %r11, 512
%r15 = trunc i1056 %r14 to i544
%r16 = bitcast i32* %r4 to i512*
%r17 = load i512, i512* %r16
%r18 = zext i512 %r17 to i544
%r19 = sub i544 %r15, %r18
%r20 = lshr i544 %r19, 512
%r21 = trunc i544 %r20 to i1
%r22 = select i1 %r21, i544 %r15, i544 %r19
%r23 = trunc i544 %r22 to i512
%r24 = getelementptr i32, i32* %r1, i32 16
%r25 = bitcast i32* %r24 to i512*
store i512 %r23, i512* %r25
ret void
}
define void @mcl_fpDbl_sub16L(i32* noalias %r1, i32* noalias %r2, i32* noalias %r3, i32* noalias %r4)
{
%r5 = bitcast i32* %r2 to i1024*
%r6 = load i1024, i1024* %r5
%r7 = bitcast i32* %r3 to i1024*
%r8 = load i1024, i1024* %r7
%r9 = zext i1024 %r6 to i1056
%r10 = zext i1024 %r8 to i1056
%r11 = sub i1056 %r9, %r10
%r12 = trunc i1056 %r11 to i512
%r13 = bitcast i32* %r1 to i512*
store i512 %r12, i512* %r13
%r14 = lshr i1056 %r11, 512
%r15 = trunc i1056 %r14 to i512
%r16 = lshr i1056 %r11, 1024
%r17 = trunc i1056 %r16 to i1
%r18 = bitcast i32* %r4 to i512*
%r19 = load i512, i512* %r18
%r20 = select i1 %r17, i512 %r19, i512 0
%r21 = add i512 %r15, %r20
%r22 = getelementptr i32, i32* %r1, i32 16
%r23 = bitcast i32* %r22 to i512*
store i512 %r21, i512* %r23
ret void
}
define i32 @mclb_modp256(i32* noalias %r1, i32* noalias %r2, i32 %r3, i32* noalias readonly %r4)
{
%r6 = icmp ugt i32 %r3, 16
br i1 %r6, label %L3, label %L4
L3:
ret i32 0
L4:
%r7 = icmp ult i32 %r3, 8
br i1 %r7, label %L15, label %L5
L5:
%r8 = bitcast i32* %r4 to i64*
%r9 = load i64, i64* %r8
%r10 = getelementptr i32, i32* %r4, i32 2
%r11 = bitcast i32* %r10 to i256*
%r12 = load i256, i256* %r11
%r13 = zext i256 %r12 to i288
%r14 = sub i32 %r3, 7
%r15 = getelementptr i32, i32* %r2, i32 %r14
%r16 = bitcast i32* %r15 to i224*
%r17 = load i224, i224* %r16
%r18 = sub i32 %r3, 8
%r19 = getelementptr i32, i32* %r2, i32 %r18
%r20 = load i32, i32* %r19
%r21 = zext i32 %r20 to i256
%r22 = zext i224 %r17 to i256
%r23 = shl i256 %r22, 32
%r24 = or i256 %r21, %r23
%r25 = zext i256 %r24 to i288
%r26 = lshr i288 %r25, 224
%r27 = trunc i288 %r26 to i64
%r28 = zext i64 %r27 to i128
%r29 = zext i64 %r9 to i128
%r30 = mul i128 %r28, %r29
%r31 = lshr i128 %r30, 65
%r32 = trunc i128 %r31 to i32
%r33 = call i288 @mulPv256x32(i32* %r10, i32 %r32)
%r34 = add i288 %r25, %r33
%r35 = zext i32 %r32 to i288
%r36 = shl i288 %r35, 256
%r37 = sub i288 %r34, %r36
%r38 = add i288 %r37, %r13
%r39 = lshr i288 %r38, 256
%r40 = trunc i288 %r39 to i1
%r41 = trunc i288 %r38 to i256
%r42 = trunc i288 %r37 to i256
%r43 = select i1 %r40, i256 %r41, i256 %r42
%r44 = icmp eq i32 %r3, 8
br i1 %r44, label %L14, label %L6
L6:
%r45 = getelementptr i32, i32* %r19, i32 -1
%r46 = load i32, i32* %r45
%r47 = zext i32 %r46 to i288
%r48 = zext i256 %r43 to i288
%r49 = shl i288 %r48, 32
%r50 = or i288 %r47, %r49
%r51 = lshr i288 %r50, 224
%r52 = trunc i288 %r51 to i64
%r53 = zext i64 %r52 to i128
%r54 = zext i64 %r9 to i128
%r55 = mul i128 %r53, %r54
%r56 = lshr i128 %r55, 65
%r57 = trunc i128 %r56 to i32
%r58 = call i288 @mulPv256x32(i32* %r10, i32 %r57)
%r59 = add i288 %r50, %r58
%r60 = zext i32 %r57 to i288
%r61 = shl i288 %r60, 256
%r62 = sub i288 %r59, %r61
%r63 = add i288 %r62, %r13
%r64 = lshr i288 %r63, 256
%r65 = trunc i288 %r64 to i1
%r66 = trunc i288 %r63 to i256
%r67 = trunc i288 %r62 to i256
%r68 = select i1 %r65, i256 %r66, i256 %r67
%r69 = icmp eq i32 %r3, 9
br i1 %r69, label %L14, label %L7
L7:
%r70 = getelementptr i32, i32* %r45, i32 -1
%r71 = load i32, i32* %r70
%r72 = zext i32 %r71 to i288
%r73 = zext i256 %r68 to i288
%r74 = shl i288 %r73, 32
%r75 = or i288 %r72, %r74
%r76 = lshr i288 %r75, 224
%r77 = trunc i288 %r76 to i64
%r78 = zext i64 %r77 to i128
%r79 = zext i64 %r9 to i128
%r80 = mul i128 %r78, %r79
%r81 = lshr i128 %r80, 65
%r82 = trunc i128 %r81 to i32
%r83 = call i288 @mulPv256x32(i32* %r10, i32 %r82)
%r84 = add i288 %r75, %r83
%r85 = zext i32 %r82 to i288
%r86 = shl i288 %r85, 256
%r87 = sub i288 %r84, %r86
%r88 = add i288 %r87, %r13
%r89 = lshr i288 %r88, 256
%r90 = trunc i288 %r89 to i1
%r91 = trunc i288 %r88 to i256
%r92 = trunc i288 %r87 to i256
%r93 = select i1 %r90, i256 %r91, i256 %r92
%r94 = icmp eq i32 %r3, 10
br i1 %r94, label %L14, label %L8
L8:
%r95 = getelementptr i32, i32* %r70, i32 -1
%r96 = load i32, i32* %r95
%r97 = zext i32 %r96 to i288
%r98 = zext i256 %r93 to i288
%r99 = shl i288 %r98, 32
%r100 = or i288 %r97, %r99
%r101 = lshr i288 %r100, 224
%r102 = trunc i288 %r101 to i64
%r103 = zext i64 %r102 to i128
%r104 = zext i64 %r9 to i128
%r105 = mul i128 %r103, %r104
%r106 = lshr i128 %r105, 65
%r107 = trunc i128 %r106 to i32
%r108 = call i288 @mulPv256x32(i32* %r10, i32 %r107)
%r109 = add i288 %r100, %r108
%r110 = zext i32 %r107 to i288
%r111 = shl i288 %r110, 256
%r112 = sub i288 %r109, %r111
%r113 = add i288 %r112, %r13
%r114 = lshr i288 %r113, 256
%r115 = trunc i288 %r114 to i1
%r116 = trunc i288 %r113 to i256
%r117 = trunc i288 %r112 to i256
%r118 = select i1 %r115, i256 %r116, i256 %r117
%r119 = icmp eq i32 %r3, 11
br i1 %r119, label %L14, label %L9
L9:
%r120 = getelementptr i32, i32* %r95, i32 -1
%r121 = load i32, i32* %r120
%r122 = zext i32 %r121 to i288
%r123 = zext i256 %r118 to i288
%r124 = shl i288 %r123, 32
%r125 = or i288 %r122, %r124
%r126 = lshr i288 %r125, 224
%r127 = trunc i288 %r126 to i64
%r128 = zext i64 %r127 to i128
%r129 = zext i64 %r9 to i128
%r130 = mul i128 %r128, %r129
%r131 = lshr i128 %r130, 65
%r132 = trunc i128 %r131 to i32
%r133 = call i288 @mulPv256x32(i32* %r10, i32 %r132)
%r134 = add i288 %r125, %r133
%r135 = zext i32 %r132 to i288
%r136 = shl i288 %r135, 256
%r137 = sub i288 %r134, %r136
%r138 = add i288 %r137, %r13
%r139 = lshr i288 %r138, 256
%r140 = trunc i288 %r139 to i1
%r141 = trunc i288 %r138 to i256
%r142 = trunc i288 %r137 to i256
%r143 = select i1 %r140, i256 %r141, i256 %r142
%r144 = icmp eq i32 %r3, 12
br i1 %r144, label %L14, label %L10
L10:
%r145 = getelementptr i32, i32* %r120, i32 -1
%r146 = load i32, i32* %r145
%r147 = zext i32 %r146 to i288
%r148 = zext i256 %r143 to i288
%r149 = shl i288 %r148, 32
%r150 = or i288 %r147, %r149
%r151 = lshr i288 %r150, 224
%r152 = trunc i288 %r151 to i64
%r153 = zext i64 %r152 to i128
%r154 = zext i64 %r9 to i128
%r155 = mul i128 %r153, %r154
%r156 = lshr i128 %r155, 65
%r157 = trunc i128 %r156 to i32
%r158 = call i288 @mulPv256x32(i32* %r10, i32 %r157)
%r159 = add i288 %r150, %r158
%r160 = zext i32 %r157 to i288
%r161 = shl i288 %r160, 256
%r162 = sub i288 %r159, %r161
%r163 = add i288 %r162, %r13
%r164 = lshr i288 %r163, 256
%r165 = trunc i288 %r164 to i1
%r166 = trunc i288 %r163 to i256
%r167 = trunc i288 %r162 to i256
%r168 = select i1 %r165, i256 %r166, i256 %r167
%r169 = icmp eq i32 %r3, 13
br i1 %r169, label %L14, label %L11
L11:
%r170 = getelementptr i32, i32* %r145, i32 -1
%r171 = load i32, i32* %r170
%r172 = zext i32 %r171 to i288
%r173 = zext i256 %r168 to i288
%r174 = shl i288 %r173, 32
%r175 = or i288 %r172, %r174
%r176 = lshr i288 %r175, 224
%r177 = trunc i288 %r176 to i64
%r178 = zext i64 %r177 to i128
%r179 = zext i64 %r9 to i128
%r180 = mul i128 %r178, %r179
%r181 = lshr i128 %r180, 65
%r182 = trunc i128 %r181 to i32
%r183 = call i288 @mulPv256x32(i32* %r10, i32 %r182)
%r184 = add i288 %r175, %r183
%r185 = zext i32 %r182 to i288
%r186 = shl i288 %r185, 256
%r187 = sub i288 %r184, %r186
%r188 = add i288 %r187, %r13
%r189 = lshr i288 %r188, 256
%r190 = trunc i288 %r189 to i1
%r191 = trunc i288 %r188 to i256
%r192 = trunc i288 %r187 to i256
%r193 = select i1 %r190, i256 %r191, i256 %r192
%r194 = icmp eq i32 %r3, 14
br i1 %r194, label %L14, label %L12
L12:
%r195 = getelementptr i32, i32* %r170, i32 -1
%r196 = load i32, i32* %r195
%r197 = zext i32 %r196 to i288
%r198 = zext i256 %r193 to i288
%r199 = shl i288 %r198, 32
%r200 = or i288 %r197, %r199
%r201 = lshr i288 %r200, 224
%r202 = trunc i288 %r201 to i64
%r203 = zext i64 %r202 to i128
%r204 = zext i64 %r9 to i128
%r205 = mul i128 %r203, %r204
%r206 = lshr i128 %r205, 65
%r207 = trunc i128 %r206 to i32
%r208 = call i288 @mulPv256x32(i32* %r10, i32 %r207)
%r209 = add i288 %r200, %r208
%r210 = zext i32 %r207 to i288
%r211 = shl i288 %r210, 256
%r212 = sub i288 %r209, %r211
%r213 = add i288 %r212, %r13
%r214 = lshr i288 %r213, 256
%r215 = trunc i288 %r214 to i1
%r216 = trunc i288 %r213 to i256
%r217 = trunc i288 %r212 to i256
%r218 = select i1 %r215, i256 %r216, i256 %r217
%r219 = icmp eq i32 %r3, 15
br i1 %r219, label %L14, label %L13
L13:
%r220 = getelementptr i32, i32* %r195, i32 -1
%r221 = load i32, i32* %r220
%r222 = zext i32 %r221 to i288
%r223 = zext i256 %r218 to i288
%r224 = shl i288 %r223, 32
%r225 = or i288 %r222, %r224
%r226 = lshr i288 %r225, 224
%r227 = trunc i288 %r226 to i64
%r228 = zext i64 %r227 to i128
%r229 = zext i64 %r9 to i128
%r230 = mul i128 %r228, %r229
%r231 = lshr i128 %r230, 65
%r232 = trunc i128 %r231 to i32
%r233 = call i288 @mulPv256x32(i32* %r10, i32 %r232)
%r234 = add i288 %r225, %r233
%r235 = zext i32 %r232 to i288
%r236 = shl i288 %r235, 256
%r237 = sub i288 %r234, %r236
%r238 = add i288 %r237, %r13
%r239 = lshr i288 %r238, 256
%r240 = trunc i288 %r239 to i1
%r241 = trunc i288 %r238 to i256
%r242 = trunc i288 %r237 to i256
%r243 = select i1 %r240, i256 %r241, i256 %r242
br label %L14
L14:
%r244 = phi i256[%r43, %L5], [%r68, %L6], [%r93, %L7], [%r118, %L8], [%r143, %L9], [%r168, %L10], [%r193, %L11], [%r218, %L12], [%r243, %L13]
%r245 = bitcast i32* %r1 to i256*
store i256 %r244, i256* %r245
ret i32 1
L15:
%r246 = icmp eq i32 %r3, 0
br i1 %r246, label %L23, label %L16
L16:
%r247 = getelementptr i32, i32* %r2, i32 0
%r248 = load i32, i32* %r247
%r249 = getelementptr i32, i32* %r1, i32 0
store i32 %r248, i32* %r249
%r250 = icmp eq i32 %r3, 1
br i1 %r250, label %L24, label %L17
L17:
%r251 = getelementptr i32, i32* %r2, i32 1
%r252 = load i32, i32* %r251
%r253 = getelementptr i32, i32* %r1, i32 1
store i32 %r252, i32* %r253
%r254 = icmp eq i32 %r3, 2
br i1 %r254, label %L25, label %L18
L18:
%r255 = getelementptr i32, i32* %r2, i32 2
%r256 = load i32, i32* %r255
%r257 = getelementptr i32, i32* %r1, i32 2
store i32 %r256, i32* %r257
%r258 = icmp eq i32 %r3, 3
br i1 %r258, label %L26, label %L19
L19:
%r259 = getelementptr i32, i32* %r2, i32 3
%r260 = load i32, i32* %r259
%r261 = getelementptr i32, i32* %r1, i32 3
store i32 %r260, i32* %r261
%r262 = icmp eq i32 %r3, 4
br i1 %r262, label %L27, label %L20
L20:
%r263 = getelementptr i32, i32* %r2, i32 4
%r264 = load i32, i32* %r263
%r265 = getelementptr i32, i32* %r1, i32 4
store i32 %r264, i32* %r265
%r266 = icmp eq i32 %r3, 5
br i1 %r266, label %L28, label %L21
L21:
%r267 = getelementptr i32, i32* %r2, i32 5
%r268 = load i32, i32* %r267
%r269 = getelementptr i32, i32* %r1, i32 5
store i32 %r268, i32* %r269
%r270 = icmp eq i32 %r3, 6
br i1 %r270, label %L29, label %L22
L22:
%r271 = getelementptr i32, i32* %r2, i32 6
%r272 = load i32, i32* %r271
%r273 = getelementptr i32, i32* %r1, i32 6
store i32 %r272, i32* %r273
br label %L30
L23:
%r274 = getelementptr i32, i32* %r1, i32 0
store i32 0, i32* %r274
br label %L24
L24:
%r275 = getelementptr i32, i32* %r1, i32 1
store i32 0, i32* %r275
br label %L25
L25:
%r276 = getelementptr i32, i32* %r1, i32 2
store i32 0, i32* %r276
br label %L26
L26:
%r277 = getelementptr i32, i32* %r1, i32 3
store i32 0, i32* %r277
br label %L27
L27:
%r278 = getelementptr i32, i32* %r1, i32 4
store i32 0, i32* %r278
br label %L28
L28:
%r279 = getelementptr i32, i32* %r1, i32 5
store i32 0, i32* %r279
br label %L29
L29:
%r280 = getelementptr i32, i32* %r1, i32 6
store i32 0, i32* %r280
br label %L30
L30:
%r281 = getelementptr i32, i32* %r1, i32 7
store i32 0, i32* %r281
ret i32 1
}
define i32 @mclb_modp384(i32* noalias %r1, i32* noalias %r2, i32 %r3, i32* noalias readonly %r4)
{
%r6 = icmp ugt i32 %r3, 16
br i1 %r6, label %L31, label %L32
L31:
ret i32 0
L32:
%r7 = icmp ult i32 %r3, 12
br i1 %r7, label %L39, label %L33
L33:
%r8 = bitcast i32* %r4 to i64*
%r9 = load i64, i64* %r8
%r10 = getelementptr i32, i32* %r4, i32 2
%r11 = bitcast i32* %r10 to i384*
%r12 = load i384, i384* %r11
%r13 = zext i384 %r12 to i416
%r14 = sub i32 %r3, 11
%r15 = getelementptr i32, i32* %r2, i32 %r14
%r16 = bitcast i32* %r15 to i352*
%r17 = load i352, i352* %r16
%r18 = sub i32 %r3, 12
%r19 = getelementptr i32, i32* %r2, i32 %r18
%r20 = load i32, i32* %r19
%r21 = zext i32 %r20 to i384
%r22 = zext i352 %r17 to i384
%r23 = shl i384 %r22, 32
%r24 = or i384 %r21, %r23
%r25 = zext i384 %r24 to i416
%r26 = lshr i416 %r25, 352
%r27 = trunc i416 %r26 to i64
%r28 = zext i64 %r27 to i128
%r29 = zext i64 %r9 to i128
%r30 = mul i128 %r28, %r29
%r31 = lshr i128 %r30, 65
%r32 = trunc i128 %r31 to i32
%r33 = call i416 @mulPv384x32(i32* %r10, i32 %r32)
%r34 = add i416 %r25, %r33
%r35 = zext i32 %r32 to i416
%r36 = shl i416 %r35, 384
%r37 = sub i416 %r34, %r36
%r38 = add i416 %r37, %r13
%r39 = lshr i416 %r38, 384
%r40 = trunc i416 %r39 to i1
%r41 = trunc i416 %r38 to i384
%r42 = trunc i416 %r37 to i384
%r43 = select i1 %r40, i384 %r41, i384 %r42
%r44 = icmp eq i32 %r3, 12
br i1 %r44, label %L38, label %L34
L34:
%r45 = getelementptr i32, i32* %r19, i32 -1
%r46 = load i32, i32* %r45
%r47 = zext i32 %r46 to i416
%r48 = zext i384 %r43 to i416
%r49 = shl i416 %r48, 32
%r50 = or i416 %r47, %r49
%r51 = lshr i416 %r50, 352
%r52 = trunc i416 %r51 to i64
%r53 = zext i64 %r52 to i128
%r54 = zext i64 %r9 to i128
%r55 = mul i128 %r53, %r54
%r56 = lshr i128 %r55, 65
%r57 = trunc i128 %r56 to i32
%r58 = call i416 @mulPv384x32(i32* %r10, i32 %r57)
%r59 = add i416 %r50, %r58
%r60 = zext i32 %r57 to i416
%r61 = shl i416 %r60, 384
%r62 = sub i416 %r59, %r61
%r63 = add i416 %r62, %r13
%r64 = lshr i416 %r63, 384
%r65 = trunc i416 %r64 to i1
%r66 = trunc i416 %r63 to i384
%r67 = trunc i416 %r62 to i384
%r68 = select i1 %r65, i384 %r66, i384 %r67
%r69 = icmp eq i32 %r3, 13
br i1 %r69, label %L38, label %L35
L35:
%r70 = getelementptr i32, i32* %r45, i32 -1
%r71 = load i32, i32* %r70
%r72 = zext i32 %r71 to i416
%r73 = zext i384 %r68 to i416
%r74 = shl i416 %r73, 32
%r75 = or i416 %r72, %r74
%r76 = lshr i416 %r75, 352
%r77 = trunc i416 %r76 to i64
%r78 = zext i64 %r77 to i128
%r79 = zext i64 %r9 to i128
%r80 = mul i128 %r78, %r79
%r81 = lshr i128 %r80, 65
%r82 = trunc i128 %r81 to i32
%r83 = call i416 @mulPv384x32(i32* %r10, i32 %r82)
%r84 = add i416 %r75, %r83
%r85 = zext i32 %r82 to i416
%r86 = shl i416 %r85, 384
%r87 = sub i416 %r84, %r86
%r88 = add i416 %r87, %r13
%r89 = lshr i416 %r88, 384
%r90 = trunc i416 %r89 to i1
%r91 = trunc i416 %r88 to i384
%r92 = trunc i416 %r87 to i384
%r93 = select i1 %r90, i384 %r91, i384 %r92
%r94 = icmp eq i32 %r3, 14
br i1 %r94, label %L38, label %L36
L36:
%r95 = getelementptr i32, i32* %r70, i32 -1
%r96 = load i32, i32* %r95
%r97 = zext i32 %r96 to i416
%r98 = zext i384 %r93 to i416
%r99 = shl i416 %r98, 32
%r100 = or i416 %r97, %r99
%r101 = lshr i416 %r100, 352
%r102 = trunc i416 %r101 to i64
%r103 = zext i64 %r102 to i128
%r104 = zext i64 %r9 to i128
%r105 = mul i128 %r103, %r104
%r106 = lshr i128 %r105, 65
%r107 = trunc i128 %r106 to i32
%r108 = call i416 @mulPv384x32(i32* %r10, i32 %r107)
%r109 = add i416 %r100, %r108
%r110 = zext i32 %r107 to i416
%r111 = shl i416 %r110, 384
%r112 = sub i416 %r109, %r111
%r113 = add i416 %r112, %r13
%r114 = lshr i416 %r113, 384
%r115 = trunc i416 %r114 to i1
%r116 = trunc i416 %r113 to i384
%r117 = trunc i416 %r112 to i384
%r118 = select i1 %r115, i384 %r116, i384 %r117
%r119 = icmp eq i32 %r3, 15
br i1 %r119, label %L38, label %L37
L37:
%r120 = getelementptr i32, i32* %r95, i32 -1
%r121 = load i32, i32* %r120
%r122 = zext i32 %r121 to i416
%r123 = zext i384 %r118 to i416
%r124 = shl i416 %r123, 32
%r125 = or i416 %r122, %r124
%r126 = lshr i416 %r125, 352
%r127 = trunc i416 %r126 to i64
%r128 = zext i64 %r127 to i128
%r129 = zext i64 %r9 to i128
%r130 = mul i128 %r128, %r129
%r131 = lshr i128 %r130, 65
%r132 = trunc i128 %r131 to i32
%r133 = call i416 @mulPv384x32(i32* %r10, i32 %r132)
%r134 = add i416 %r125, %r133
%r135 = zext i32 %r132 to i416
%r136 = shl i416 %r135, 384
%r137 = sub i416 %r134, %r136
%r138 = add i416 %r137, %r13
%r139 = lshr i416 %r138, 384
%r140 = trunc i416 %r139 to i1
%r141 = trunc i416 %r138 to i384
%r142 = trunc i416 %r137 to i384
%r143 = select i1 %r140, i384 %r141, i384 %r142
br label %L38
L38:
%r144 = phi i384[%r43, %L33], [%r68, %L34], [%r93, %L35], [%r118, %L36], [%r143, %L37]
%r145 = bitcast i32* %r1 to i384*
store i384 %r144, i384* %r145
ret i32 1
L39:
%r146 = icmp eq i32 %r3, 0
br i1 %r146, label %L51, label %L40
L40:
%r147 = getelementptr i32, i32* %r2, i32 0
%r148 = load i32, i32* %r147
%r149 = getelementptr i32, i32* %r1, i32 0
store i32 %r148, i32* %r149
%r150 = icmp eq i32 %r3, 1
br i1 %r150, label %L52, label %L41
L41:
%r151 = getelementptr i32, i32* %r2, i32 1
%r152 = load i32, i32* %r151
%r153 = getelementptr i32, i32* %r1, i32 1
store i32 %r152, i32* %r153
%r154 = icmp eq i32 %r3, 2
br i1 %r154, label %L53, label %L42
L42:
%r155 = getelementptr i32, i32* %r2, i32 2
%r156 = load i32, i32* %r155
%r157 = getelementptr i32, i32* %r1, i32 2
store i32 %r156, i32* %r157
%r158 = icmp eq i32 %r3, 3
br i1 %r158, label %L54, label %L43
L43:
%r159 = getelementptr i32, i32* %r2, i32 3
%r160 = load i32, i32* %r159
%r161 = getelementptr i32, i32* %r1, i32 3
store i32 %r160, i32* %r161
%r162 = icmp eq i32 %r3, 4
br i1 %r162, label %L55, label %L44
L44:
%r163 = getelementptr i32, i32* %r2, i32 4
%r164 = load i32, i32* %r163
%r165 = getelementptr i32, i32* %r1, i32 4
store i32 %r164, i32* %r165
%r166 = icmp eq i32 %r3, 5
br i1 %r166, label %L56, label %L45
L45:
%r167 = getelementptr i32, i32* %r2, i32 5
%r168 = load i32, i32* %r167
%r169 = getelementptr i32, i32* %r1, i32 5
store i32 %r168, i32* %r169
%r170 = icmp eq i32 %r3, 6
br i1 %r170, label %L57, label %L46
L46:
%r171 = getelementptr i32, i32* %r2, i32 6
%r172 = load i32, i32* %r171
%r173 = getelementptr i32, i32* %r1, i32 6
store i32 %r172, i32* %r173
%r174 = icmp eq i32 %r3, 7
br i1 %r174, label %L58, label %L47
L47:
%r175 = getelementptr i32, i32* %r2, i32 7
%r176 = load i32, i32* %r175
%r177 = getelementptr i32, i32* %r1, i32 7
store i32 %r176, i32* %r177
%r178 = icmp eq i32 %r3, 8
br i1 %r178, label %L59, label %L48
L48:
%r179 = getelementptr i32, i32* %r2, i32 8
%r180 = load i32, i32* %r179
%r181 = getelementptr i32, i32* %r1, i32 8
store i32 %r180, i32* %r181
%r182 = icmp eq i32 %r3, 9
br i1 %r182, label %L60, label %L49
L49:
%r183 = getelementptr i32, i32* %r2, i32 9
%r184 = load i32, i32* %r183
%r185 = getelementptr i32, i32* %r1, i32 9
store i32 %r184, i32* %r185
%r186 = icmp eq i32 %r3, 10
br i1 %r186, label %L61, label %L50
L50:
%r187 = getelementptr i32, i32* %r2, i32 10
%r188 = load i32, i32* %r187
%r189 = getelementptr i32, i32* %r1, i32 10
store i32 %r188, i32* %r189
br label %L62
L51:
%r190 = getelementptr i32, i32* %r1, i32 0
store i32 0, i32* %r190
br label %L52
L52:
%r191 = getelementptr i32, i32* %r1, i32 1
store i32 0, i32* %r191
br label %L53
L53:
%r192 = getelementptr i32, i32* %r1, i32 2
store i32 0, i32* %r192
br label %L54
L54:
%r193 = getelementptr i32, i32* %r1, i32 3
store i32 0, i32* %r193
br label %L55
L55:
%r194 = getelementptr i32, i32* %r1, i32 4
store i32 0, i32* %r194
br label %L56
L56:
%r195 = getelementptr i32, i32* %r1, i32 5
store i32 0, i32* %r195
br label %L57
L57:
%r196 = getelementptr i32, i32* %r1, i32 6
store i32 0, i32* %r196
br label %L58
L58:
%r197 = getelementptr i32, i32* %r1, i32 7
store i32 0, i32* %r197
br label %L59
L59:
%r198 = getelementptr i32, i32* %r1, i32 8
store i32 0, i32* %r198
br label %L60
L60:
%r199 = getelementptr i32, i32* %r1, i32 9
store i32 0, i32* %r199
br label %L61
L61:
%r200 = getelementptr i32, i32* %r1, i32 10
store i32 0, i32* %r200
br label %L62
L62:
%r201 = getelementptr i32, i32* %r1, i32 11
store i32 0, i32* %r201
ret i32 1
}
