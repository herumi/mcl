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
define private i64 @mulPos32x32(i32* noalias  %r2, i32 %r3, i32 %r4)
{
%r5 = getelementptr i32, i32* %r2, i32 %r4
%r6 = load i32, i32* %r5
%r7 = call i64 @mul32x32L(i32 %r6, i32 %r3)
ret i64 %r7
}
define i32 @mclb_add1(i32* noalias  %r2, i32* noalias  %r3, i32* noalias  %r4)
{
%r5 = load i32, i32* %r3
%r6 = zext i32 %r5 to i64
%r7 = load i32, i32* %r4
%r8 = zext i32 %r7 to i64
%r9 = add i64 %r6, %r8
%r10 = trunc i64 %r9 to i32
store i32 %r10, i32* %r2
%r11 = lshr i64 %r9, 32
%r12 = trunc i64 %r11 to i32
ret i32 %r12
}
define i32 @mclb_sub1(i32* noalias  %r2, i32* noalias  %r3, i32* noalias  %r4)
{
%r5 = load i32, i32* %r3
%r6 = zext i32 %r5 to i64
%r7 = load i32, i32* %r4
%r8 = zext i32 %r7 to i64
%r9 = sub i64 %r6, %r8
%r10 = trunc i64 %r9 to i32
store i32 %r10, i32* %r2
%r11 = lshr i64 %r9, 32
%r12 = trunc i64 %r11 to i32
%r14 = and i32 %r12, 1
ret i32 %r14
}
define void @mclb_addNF1(i32* noalias  %r1, i32* noalias  %r2, i32* noalias  %r3)
{
%r4 = load i32, i32* %r2
%r5 = load i32, i32* %r3
%r6 = add i32 %r4, %r5
store i32 %r6, i32* %r1
ret void
}
define i32 @mclb_subNF1(i32* noalias  %r2, i32* noalias  %r3, i32* noalias  %r4)
{
%r5 = load i32, i32* %r3
%r6 = load i32, i32* %r4
%r7 = sub i32 %r5, %r6
store i32 %r7, i32* %r2
%r8 = lshr i32 %r7, 31
%r10 = and i32 %r8, 1
ret i32 %r10
}
define i32 @mclb_add2(i32* noalias  %r2, i32* noalias  %r3, i32* noalias  %r4)
{
%r6 = bitcast i32* %r3 to i64*
%r7 = load i64, i64* %r6
%r8 = zext i64 %r7 to i96
%r10 = bitcast i32* %r4 to i64*
%r11 = load i64, i64* %r10
%r12 = zext i64 %r11 to i96
%r13 = add i96 %r8, %r12
%r14 = trunc i96 %r13 to i64
%r16 = getelementptr i32, i32* %r2, i32 0
%r17 = trunc i64 %r14 to i32
store i32 %r17, i32* %r16
%r18 = lshr i64 %r14, 32
%r20 = getelementptr i32, i32* %r2, i32 1
%r21 = trunc i64 %r18 to i32
store i32 %r21, i32* %r20
%r22 = lshr i96 %r13, 64
%r23 = trunc i96 %r22 to i32
ret i32 %r23
}
define i32 @mclb_sub2(i32* noalias  %r2, i32* noalias  %r3, i32* noalias  %r4)
{
%r6 = bitcast i32* %r3 to i64*
%r7 = load i64, i64* %r6
%r8 = zext i64 %r7 to i96
%r10 = bitcast i32* %r4 to i64*
%r11 = load i64, i64* %r10
%r12 = zext i64 %r11 to i96
%r13 = sub i96 %r8, %r12
%r14 = trunc i96 %r13 to i64
%r16 = getelementptr i32, i32* %r2, i32 0
%r17 = trunc i64 %r14 to i32
store i32 %r17, i32* %r16
%r18 = lshr i64 %r14, 32
%r20 = getelementptr i32, i32* %r2, i32 1
%r21 = trunc i64 %r18 to i32
store i32 %r21, i32* %r20
%r22 = lshr i96 %r13, 64
%r23 = trunc i96 %r22 to i32
%r25 = and i32 %r23, 1
ret i32 %r25
}
define void @mclb_addNF2(i32* noalias  %r1, i32* noalias  %r2, i32* noalias  %r3)
{
%r5 = bitcast i32* %r2 to i64*
%r6 = load i64, i64* %r5
%r8 = bitcast i32* %r3 to i64*
%r9 = load i64, i64* %r8
%r10 = add i64 %r6, %r9
%r12 = getelementptr i32, i32* %r1, i32 0
%r13 = trunc i64 %r10 to i32
store i32 %r13, i32* %r12
%r14 = lshr i64 %r10, 32
%r16 = getelementptr i32, i32* %r1, i32 1
%r17 = trunc i64 %r14 to i32
store i32 %r17, i32* %r16
ret void
}
define i32 @mclb_subNF2(i32* noalias  %r2, i32* noalias  %r3, i32* noalias  %r4)
{
%r6 = bitcast i32* %r3 to i64*
%r7 = load i64, i64* %r6
%r9 = bitcast i32* %r4 to i64*
%r10 = load i64, i64* %r9
%r11 = sub i64 %r7, %r10
%r13 = getelementptr i32, i32* %r2, i32 0
%r14 = trunc i64 %r11 to i32
store i32 %r14, i32* %r13
%r15 = lshr i64 %r11, 32
%r17 = getelementptr i32, i32* %r2, i32 1
%r18 = trunc i64 %r15 to i32
store i32 %r18, i32* %r17
%r19 = lshr i64 %r11, 63
%r20 = trunc i64 %r19 to i32
%r22 = and i32 %r20, 1
ret i32 %r22
}
define i32 @mclb_add3(i32* noalias  %r2, i32* noalias  %r3, i32* noalias  %r4)
{
%r6 = bitcast i32* %r3 to i96*
%r7 = load i96, i96* %r6
%r8 = zext i96 %r7 to i128
%r10 = bitcast i32* %r4 to i96*
%r11 = load i96, i96* %r10
%r12 = zext i96 %r11 to i128
%r13 = add i128 %r8, %r12
%r14 = trunc i128 %r13 to i96
%r16 = getelementptr i32, i32* %r2, i32 0
%r17 = trunc i96 %r14 to i32
store i32 %r17, i32* %r16
%r18 = lshr i96 %r14, 32
%r20 = getelementptr i32, i32* %r2, i32 1
%r21 = trunc i96 %r18 to i32
store i32 %r21, i32* %r20
%r22 = lshr i96 %r18, 32
%r24 = getelementptr i32, i32* %r2, i32 2
%r25 = trunc i96 %r22 to i32
store i32 %r25, i32* %r24
%r26 = lshr i128 %r13, 96
%r27 = trunc i128 %r26 to i32
ret i32 %r27
}
define i32 @mclb_sub3(i32* noalias  %r2, i32* noalias  %r3, i32* noalias  %r4)
{
%r6 = bitcast i32* %r3 to i96*
%r7 = load i96, i96* %r6
%r8 = zext i96 %r7 to i128
%r10 = bitcast i32* %r4 to i96*
%r11 = load i96, i96* %r10
%r12 = zext i96 %r11 to i128
%r13 = sub i128 %r8, %r12
%r14 = trunc i128 %r13 to i96
%r16 = getelementptr i32, i32* %r2, i32 0
%r17 = trunc i96 %r14 to i32
store i32 %r17, i32* %r16
%r18 = lshr i96 %r14, 32
%r20 = getelementptr i32, i32* %r2, i32 1
%r21 = trunc i96 %r18 to i32
store i32 %r21, i32* %r20
%r22 = lshr i96 %r18, 32
%r24 = getelementptr i32, i32* %r2, i32 2
%r25 = trunc i96 %r22 to i32
store i32 %r25, i32* %r24
%r26 = lshr i128 %r13, 96
%r27 = trunc i128 %r26 to i32
%r29 = and i32 %r27, 1
ret i32 %r29
}
define void @mclb_addNF3(i32* noalias  %r1, i32* noalias  %r2, i32* noalias  %r3)
{
%r5 = bitcast i32* %r2 to i96*
%r6 = load i96, i96* %r5
%r8 = bitcast i32* %r3 to i96*
%r9 = load i96, i96* %r8
%r10 = add i96 %r6, %r9
%r12 = getelementptr i32, i32* %r1, i32 0
%r13 = trunc i96 %r10 to i32
store i32 %r13, i32* %r12
%r14 = lshr i96 %r10, 32
%r16 = getelementptr i32, i32* %r1, i32 1
%r17 = trunc i96 %r14 to i32
store i32 %r17, i32* %r16
%r18 = lshr i96 %r14, 32
%r20 = getelementptr i32, i32* %r1, i32 2
%r21 = trunc i96 %r18 to i32
store i32 %r21, i32* %r20
ret void
}
define i32 @mclb_subNF3(i32* noalias  %r2, i32* noalias  %r3, i32* noalias  %r4)
{
%r6 = bitcast i32* %r3 to i96*
%r7 = load i96, i96* %r6
%r9 = bitcast i32* %r4 to i96*
%r10 = load i96, i96* %r9
%r11 = sub i96 %r7, %r10
%r13 = getelementptr i32, i32* %r2, i32 0
%r14 = trunc i96 %r11 to i32
store i32 %r14, i32* %r13
%r15 = lshr i96 %r11, 32
%r17 = getelementptr i32, i32* %r2, i32 1
%r18 = trunc i96 %r15 to i32
store i32 %r18, i32* %r17
%r19 = lshr i96 %r15, 32
%r21 = getelementptr i32, i32* %r2, i32 2
%r22 = trunc i96 %r19 to i32
store i32 %r22, i32* %r21
%r23 = lshr i96 %r11, 95
%r24 = trunc i96 %r23 to i32
%r26 = and i32 %r24, 1
ret i32 %r26
}
define i32 @mclb_add4(i32* noalias  %r2, i32* noalias  %r3, i32* noalias  %r4)
{
%r6 = bitcast i32* %r3 to i128*
%r7 = load i128, i128* %r6
%r8 = zext i128 %r7 to i160
%r10 = bitcast i32* %r4 to i128*
%r11 = load i128, i128* %r10
%r12 = zext i128 %r11 to i160
%r13 = add i160 %r8, %r12
%r14 = trunc i160 %r13 to i128
%r16 = getelementptr i32, i32* %r2, i32 0
%r17 = trunc i128 %r14 to i32
store i32 %r17, i32* %r16
%r18 = lshr i128 %r14, 32
%r20 = getelementptr i32, i32* %r2, i32 1
%r21 = trunc i128 %r18 to i32
store i32 %r21, i32* %r20
%r22 = lshr i128 %r18, 32
%r24 = getelementptr i32, i32* %r2, i32 2
%r25 = trunc i128 %r22 to i32
store i32 %r25, i32* %r24
%r26 = lshr i128 %r22, 32
%r28 = getelementptr i32, i32* %r2, i32 3
%r29 = trunc i128 %r26 to i32
store i32 %r29, i32* %r28
%r30 = lshr i160 %r13, 128
%r31 = trunc i160 %r30 to i32
ret i32 %r31
}
define i32 @mclb_sub4(i32* noalias  %r2, i32* noalias  %r3, i32* noalias  %r4)
{
%r6 = bitcast i32* %r3 to i128*
%r7 = load i128, i128* %r6
%r8 = zext i128 %r7 to i160
%r10 = bitcast i32* %r4 to i128*
%r11 = load i128, i128* %r10
%r12 = zext i128 %r11 to i160
%r13 = sub i160 %r8, %r12
%r14 = trunc i160 %r13 to i128
%r16 = getelementptr i32, i32* %r2, i32 0
%r17 = trunc i128 %r14 to i32
store i32 %r17, i32* %r16
%r18 = lshr i128 %r14, 32
%r20 = getelementptr i32, i32* %r2, i32 1
%r21 = trunc i128 %r18 to i32
store i32 %r21, i32* %r20
%r22 = lshr i128 %r18, 32
%r24 = getelementptr i32, i32* %r2, i32 2
%r25 = trunc i128 %r22 to i32
store i32 %r25, i32* %r24
%r26 = lshr i128 %r22, 32
%r28 = getelementptr i32, i32* %r2, i32 3
%r29 = trunc i128 %r26 to i32
store i32 %r29, i32* %r28
%r30 = lshr i160 %r13, 128
%r31 = trunc i160 %r30 to i32
%r33 = and i32 %r31, 1
ret i32 %r33
}
define void @mclb_addNF4(i32* noalias  %r1, i32* noalias  %r2, i32* noalias  %r3)
{
%r5 = bitcast i32* %r2 to i128*
%r6 = load i128, i128* %r5
%r8 = bitcast i32* %r3 to i128*
%r9 = load i128, i128* %r8
%r10 = add i128 %r6, %r9
%r12 = getelementptr i32, i32* %r1, i32 0
%r13 = trunc i128 %r10 to i32
store i32 %r13, i32* %r12
%r14 = lshr i128 %r10, 32
%r16 = getelementptr i32, i32* %r1, i32 1
%r17 = trunc i128 %r14 to i32
store i32 %r17, i32* %r16
%r18 = lshr i128 %r14, 32
%r20 = getelementptr i32, i32* %r1, i32 2
%r21 = trunc i128 %r18 to i32
store i32 %r21, i32* %r20
%r22 = lshr i128 %r18, 32
%r24 = getelementptr i32, i32* %r1, i32 3
%r25 = trunc i128 %r22 to i32
store i32 %r25, i32* %r24
ret void
}
define i32 @mclb_subNF4(i32* noalias  %r2, i32* noalias  %r3, i32* noalias  %r4)
{
%r6 = bitcast i32* %r3 to i128*
%r7 = load i128, i128* %r6
%r9 = bitcast i32* %r4 to i128*
%r10 = load i128, i128* %r9
%r11 = sub i128 %r7, %r10
%r13 = getelementptr i32, i32* %r2, i32 0
%r14 = trunc i128 %r11 to i32
store i32 %r14, i32* %r13
%r15 = lshr i128 %r11, 32
%r17 = getelementptr i32, i32* %r2, i32 1
%r18 = trunc i128 %r15 to i32
store i32 %r18, i32* %r17
%r19 = lshr i128 %r15, 32
%r21 = getelementptr i32, i32* %r2, i32 2
%r22 = trunc i128 %r19 to i32
store i32 %r22, i32* %r21
%r23 = lshr i128 %r19, 32
%r25 = getelementptr i32, i32* %r2, i32 3
%r26 = trunc i128 %r23 to i32
store i32 %r26, i32* %r25
%r27 = lshr i128 %r11, 127
%r28 = trunc i128 %r27 to i32
%r30 = and i32 %r28, 1
ret i32 %r30
}
define i32 @mclb_add5(i32* noalias  %r2, i32* noalias  %r3, i32* noalias  %r4)
{
%r6 = bitcast i32* %r3 to i160*
%r7 = load i160, i160* %r6
%r8 = zext i160 %r7 to i192
%r10 = bitcast i32* %r4 to i160*
%r11 = load i160, i160* %r10
%r12 = zext i160 %r11 to i192
%r13 = add i192 %r8, %r12
%r14 = trunc i192 %r13 to i160
%r16 = getelementptr i32, i32* %r2, i32 0
%r17 = trunc i160 %r14 to i32
store i32 %r17, i32* %r16
%r18 = lshr i160 %r14, 32
%r20 = getelementptr i32, i32* %r2, i32 1
%r21 = trunc i160 %r18 to i32
store i32 %r21, i32* %r20
%r22 = lshr i160 %r18, 32
%r24 = getelementptr i32, i32* %r2, i32 2
%r25 = trunc i160 %r22 to i32
store i32 %r25, i32* %r24
%r26 = lshr i160 %r22, 32
%r28 = getelementptr i32, i32* %r2, i32 3
%r29 = trunc i160 %r26 to i32
store i32 %r29, i32* %r28
%r30 = lshr i160 %r26, 32
%r32 = getelementptr i32, i32* %r2, i32 4
%r33 = trunc i160 %r30 to i32
store i32 %r33, i32* %r32
%r34 = lshr i192 %r13, 160
%r35 = trunc i192 %r34 to i32
ret i32 %r35
}
define i32 @mclb_sub5(i32* noalias  %r2, i32* noalias  %r3, i32* noalias  %r4)
{
%r6 = bitcast i32* %r3 to i160*
%r7 = load i160, i160* %r6
%r8 = zext i160 %r7 to i192
%r10 = bitcast i32* %r4 to i160*
%r11 = load i160, i160* %r10
%r12 = zext i160 %r11 to i192
%r13 = sub i192 %r8, %r12
%r14 = trunc i192 %r13 to i160
%r16 = getelementptr i32, i32* %r2, i32 0
%r17 = trunc i160 %r14 to i32
store i32 %r17, i32* %r16
%r18 = lshr i160 %r14, 32
%r20 = getelementptr i32, i32* %r2, i32 1
%r21 = trunc i160 %r18 to i32
store i32 %r21, i32* %r20
%r22 = lshr i160 %r18, 32
%r24 = getelementptr i32, i32* %r2, i32 2
%r25 = trunc i160 %r22 to i32
store i32 %r25, i32* %r24
%r26 = lshr i160 %r22, 32
%r28 = getelementptr i32, i32* %r2, i32 3
%r29 = trunc i160 %r26 to i32
store i32 %r29, i32* %r28
%r30 = lshr i160 %r26, 32
%r32 = getelementptr i32, i32* %r2, i32 4
%r33 = trunc i160 %r30 to i32
store i32 %r33, i32* %r32
%r34 = lshr i192 %r13, 160
%r35 = trunc i192 %r34 to i32
%r37 = and i32 %r35, 1
ret i32 %r37
}
define void @mclb_addNF5(i32* noalias  %r1, i32* noalias  %r2, i32* noalias  %r3)
{
%r5 = bitcast i32* %r2 to i160*
%r6 = load i160, i160* %r5
%r8 = bitcast i32* %r3 to i160*
%r9 = load i160, i160* %r8
%r10 = add i160 %r6, %r9
%r12 = getelementptr i32, i32* %r1, i32 0
%r13 = trunc i160 %r10 to i32
store i32 %r13, i32* %r12
%r14 = lshr i160 %r10, 32
%r16 = getelementptr i32, i32* %r1, i32 1
%r17 = trunc i160 %r14 to i32
store i32 %r17, i32* %r16
%r18 = lshr i160 %r14, 32
%r20 = getelementptr i32, i32* %r1, i32 2
%r21 = trunc i160 %r18 to i32
store i32 %r21, i32* %r20
%r22 = lshr i160 %r18, 32
%r24 = getelementptr i32, i32* %r1, i32 3
%r25 = trunc i160 %r22 to i32
store i32 %r25, i32* %r24
%r26 = lshr i160 %r22, 32
%r28 = getelementptr i32, i32* %r1, i32 4
%r29 = trunc i160 %r26 to i32
store i32 %r29, i32* %r28
ret void
}
define i32 @mclb_subNF5(i32* noalias  %r2, i32* noalias  %r3, i32* noalias  %r4)
{
%r6 = bitcast i32* %r3 to i160*
%r7 = load i160, i160* %r6
%r9 = bitcast i32* %r4 to i160*
%r10 = load i160, i160* %r9
%r11 = sub i160 %r7, %r10
%r13 = getelementptr i32, i32* %r2, i32 0
%r14 = trunc i160 %r11 to i32
store i32 %r14, i32* %r13
%r15 = lshr i160 %r11, 32
%r17 = getelementptr i32, i32* %r2, i32 1
%r18 = trunc i160 %r15 to i32
store i32 %r18, i32* %r17
%r19 = lshr i160 %r15, 32
%r21 = getelementptr i32, i32* %r2, i32 2
%r22 = trunc i160 %r19 to i32
store i32 %r22, i32* %r21
%r23 = lshr i160 %r19, 32
%r25 = getelementptr i32, i32* %r2, i32 3
%r26 = trunc i160 %r23 to i32
store i32 %r26, i32* %r25
%r27 = lshr i160 %r23, 32
%r29 = getelementptr i32, i32* %r2, i32 4
%r30 = trunc i160 %r27 to i32
store i32 %r30, i32* %r29
%r31 = lshr i160 %r11, 159
%r32 = trunc i160 %r31 to i32
%r34 = and i32 %r32, 1
ret i32 %r34
}
define i32 @mclb_add6(i32* noalias  %r2, i32* noalias  %r3, i32* noalias  %r4)
{
%r6 = bitcast i32* %r3 to i192*
%r7 = load i192, i192* %r6
%r8 = zext i192 %r7 to i224
%r10 = bitcast i32* %r4 to i192*
%r11 = load i192, i192* %r10
%r12 = zext i192 %r11 to i224
%r13 = add i224 %r8, %r12
%r14 = trunc i224 %r13 to i192
%r16 = getelementptr i32, i32* %r2, i32 0
%r17 = trunc i192 %r14 to i32
store i32 %r17, i32* %r16
%r18 = lshr i192 %r14, 32
%r20 = getelementptr i32, i32* %r2, i32 1
%r21 = trunc i192 %r18 to i32
store i32 %r21, i32* %r20
%r22 = lshr i192 %r18, 32
%r24 = getelementptr i32, i32* %r2, i32 2
%r25 = trunc i192 %r22 to i32
store i32 %r25, i32* %r24
%r26 = lshr i192 %r22, 32
%r28 = getelementptr i32, i32* %r2, i32 3
%r29 = trunc i192 %r26 to i32
store i32 %r29, i32* %r28
%r30 = lshr i192 %r26, 32
%r32 = getelementptr i32, i32* %r2, i32 4
%r33 = trunc i192 %r30 to i32
store i32 %r33, i32* %r32
%r34 = lshr i192 %r30, 32
%r36 = getelementptr i32, i32* %r2, i32 5
%r37 = trunc i192 %r34 to i32
store i32 %r37, i32* %r36
%r38 = lshr i224 %r13, 192
%r39 = trunc i224 %r38 to i32
ret i32 %r39
}
define i32 @mclb_sub6(i32* noalias  %r2, i32* noalias  %r3, i32* noalias  %r4)
{
%r6 = bitcast i32* %r3 to i192*
%r7 = load i192, i192* %r6
%r8 = zext i192 %r7 to i224
%r10 = bitcast i32* %r4 to i192*
%r11 = load i192, i192* %r10
%r12 = zext i192 %r11 to i224
%r13 = sub i224 %r8, %r12
%r14 = trunc i224 %r13 to i192
%r16 = getelementptr i32, i32* %r2, i32 0
%r17 = trunc i192 %r14 to i32
store i32 %r17, i32* %r16
%r18 = lshr i192 %r14, 32
%r20 = getelementptr i32, i32* %r2, i32 1
%r21 = trunc i192 %r18 to i32
store i32 %r21, i32* %r20
%r22 = lshr i192 %r18, 32
%r24 = getelementptr i32, i32* %r2, i32 2
%r25 = trunc i192 %r22 to i32
store i32 %r25, i32* %r24
%r26 = lshr i192 %r22, 32
%r28 = getelementptr i32, i32* %r2, i32 3
%r29 = trunc i192 %r26 to i32
store i32 %r29, i32* %r28
%r30 = lshr i192 %r26, 32
%r32 = getelementptr i32, i32* %r2, i32 4
%r33 = trunc i192 %r30 to i32
store i32 %r33, i32* %r32
%r34 = lshr i192 %r30, 32
%r36 = getelementptr i32, i32* %r2, i32 5
%r37 = trunc i192 %r34 to i32
store i32 %r37, i32* %r36
%r38 = lshr i224 %r13, 192
%r39 = trunc i224 %r38 to i32
%r41 = and i32 %r39, 1
ret i32 %r41
}
define void @mclb_addNF6(i32* noalias  %r1, i32* noalias  %r2, i32* noalias  %r3)
{
%r5 = bitcast i32* %r2 to i192*
%r6 = load i192, i192* %r5
%r8 = bitcast i32* %r3 to i192*
%r9 = load i192, i192* %r8
%r10 = add i192 %r6, %r9
%r12 = getelementptr i32, i32* %r1, i32 0
%r13 = trunc i192 %r10 to i32
store i32 %r13, i32* %r12
%r14 = lshr i192 %r10, 32
%r16 = getelementptr i32, i32* %r1, i32 1
%r17 = trunc i192 %r14 to i32
store i32 %r17, i32* %r16
%r18 = lshr i192 %r14, 32
%r20 = getelementptr i32, i32* %r1, i32 2
%r21 = trunc i192 %r18 to i32
store i32 %r21, i32* %r20
%r22 = lshr i192 %r18, 32
%r24 = getelementptr i32, i32* %r1, i32 3
%r25 = trunc i192 %r22 to i32
store i32 %r25, i32* %r24
%r26 = lshr i192 %r22, 32
%r28 = getelementptr i32, i32* %r1, i32 4
%r29 = trunc i192 %r26 to i32
store i32 %r29, i32* %r28
%r30 = lshr i192 %r26, 32
%r32 = getelementptr i32, i32* %r1, i32 5
%r33 = trunc i192 %r30 to i32
store i32 %r33, i32* %r32
ret void
}
define i32 @mclb_subNF6(i32* noalias  %r2, i32* noalias  %r3, i32* noalias  %r4)
{
%r6 = bitcast i32* %r3 to i192*
%r7 = load i192, i192* %r6
%r9 = bitcast i32* %r4 to i192*
%r10 = load i192, i192* %r9
%r11 = sub i192 %r7, %r10
%r13 = getelementptr i32, i32* %r2, i32 0
%r14 = trunc i192 %r11 to i32
store i32 %r14, i32* %r13
%r15 = lshr i192 %r11, 32
%r17 = getelementptr i32, i32* %r2, i32 1
%r18 = trunc i192 %r15 to i32
store i32 %r18, i32* %r17
%r19 = lshr i192 %r15, 32
%r21 = getelementptr i32, i32* %r2, i32 2
%r22 = trunc i192 %r19 to i32
store i32 %r22, i32* %r21
%r23 = lshr i192 %r19, 32
%r25 = getelementptr i32, i32* %r2, i32 3
%r26 = trunc i192 %r23 to i32
store i32 %r26, i32* %r25
%r27 = lshr i192 %r23, 32
%r29 = getelementptr i32, i32* %r2, i32 4
%r30 = trunc i192 %r27 to i32
store i32 %r30, i32* %r29
%r31 = lshr i192 %r27, 32
%r33 = getelementptr i32, i32* %r2, i32 5
%r34 = trunc i192 %r31 to i32
store i32 %r34, i32* %r33
%r35 = lshr i192 %r11, 191
%r36 = trunc i192 %r35 to i32
%r38 = and i32 %r36, 1
ret i32 %r38
}
define i32 @mclb_add7(i32* noalias  %r2, i32* noalias  %r3, i32* noalias  %r4)
{
%r6 = bitcast i32* %r3 to i224*
%r7 = load i224, i224* %r6
%r8 = zext i224 %r7 to i256
%r10 = bitcast i32* %r4 to i224*
%r11 = load i224, i224* %r10
%r12 = zext i224 %r11 to i256
%r13 = add i256 %r8, %r12
%r14 = trunc i256 %r13 to i224
%r16 = getelementptr i32, i32* %r2, i32 0
%r17 = trunc i224 %r14 to i32
store i32 %r17, i32* %r16
%r18 = lshr i224 %r14, 32
%r20 = getelementptr i32, i32* %r2, i32 1
%r21 = trunc i224 %r18 to i32
store i32 %r21, i32* %r20
%r22 = lshr i224 %r18, 32
%r24 = getelementptr i32, i32* %r2, i32 2
%r25 = trunc i224 %r22 to i32
store i32 %r25, i32* %r24
%r26 = lshr i224 %r22, 32
%r28 = getelementptr i32, i32* %r2, i32 3
%r29 = trunc i224 %r26 to i32
store i32 %r29, i32* %r28
%r30 = lshr i224 %r26, 32
%r32 = getelementptr i32, i32* %r2, i32 4
%r33 = trunc i224 %r30 to i32
store i32 %r33, i32* %r32
%r34 = lshr i224 %r30, 32
%r36 = getelementptr i32, i32* %r2, i32 5
%r37 = trunc i224 %r34 to i32
store i32 %r37, i32* %r36
%r38 = lshr i224 %r34, 32
%r40 = getelementptr i32, i32* %r2, i32 6
%r41 = trunc i224 %r38 to i32
store i32 %r41, i32* %r40
%r42 = lshr i256 %r13, 224
%r43 = trunc i256 %r42 to i32
ret i32 %r43
}
define i32 @mclb_sub7(i32* noalias  %r2, i32* noalias  %r3, i32* noalias  %r4)
{
%r6 = bitcast i32* %r3 to i224*
%r7 = load i224, i224* %r6
%r8 = zext i224 %r7 to i256
%r10 = bitcast i32* %r4 to i224*
%r11 = load i224, i224* %r10
%r12 = zext i224 %r11 to i256
%r13 = sub i256 %r8, %r12
%r14 = trunc i256 %r13 to i224
%r16 = getelementptr i32, i32* %r2, i32 0
%r17 = trunc i224 %r14 to i32
store i32 %r17, i32* %r16
%r18 = lshr i224 %r14, 32
%r20 = getelementptr i32, i32* %r2, i32 1
%r21 = trunc i224 %r18 to i32
store i32 %r21, i32* %r20
%r22 = lshr i224 %r18, 32
%r24 = getelementptr i32, i32* %r2, i32 2
%r25 = trunc i224 %r22 to i32
store i32 %r25, i32* %r24
%r26 = lshr i224 %r22, 32
%r28 = getelementptr i32, i32* %r2, i32 3
%r29 = trunc i224 %r26 to i32
store i32 %r29, i32* %r28
%r30 = lshr i224 %r26, 32
%r32 = getelementptr i32, i32* %r2, i32 4
%r33 = trunc i224 %r30 to i32
store i32 %r33, i32* %r32
%r34 = lshr i224 %r30, 32
%r36 = getelementptr i32, i32* %r2, i32 5
%r37 = trunc i224 %r34 to i32
store i32 %r37, i32* %r36
%r38 = lshr i224 %r34, 32
%r40 = getelementptr i32, i32* %r2, i32 6
%r41 = trunc i224 %r38 to i32
store i32 %r41, i32* %r40
%r42 = lshr i256 %r13, 224
%r43 = trunc i256 %r42 to i32
%r45 = and i32 %r43, 1
ret i32 %r45
}
define void @mclb_addNF7(i32* noalias  %r1, i32* noalias  %r2, i32* noalias  %r3)
{
%r5 = bitcast i32* %r2 to i224*
%r6 = load i224, i224* %r5
%r8 = bitcast i32* %r3 to i224*
%r9 = load i224, i224* %r8
%r10 = add i224 %r6, %r9
%r12 = getelementptr i32, i32* %r1, i32 0
%r13 = trunc i224 %r10 to i32
store i32 %r13, i32* %r12
%r14 = lshr i224 %r10, 32
%r16 = getelementptr i32, i32* %r1, i32 1
%r17 = trunc i224 %r14 to i32
store i32 %r17, i32* %r16
%r18 = lshr i224 %r14, 32
%r20 = getelementptr i32, i32* %r1, i32 2
%r21 = trunc i224 %r18 to i32
store i32 %r21, i32* %r20
%r22 = lshr i224 %r18, 32
%r24 = getelementptr i32, i32* %r1, i32 3
%r25 = trunc i224 %r22 to i32
store i32 %r25, i32* %r24
%r26 = lshr i224 %r22, 32
%r28 = getelementptr i32, i32* %r1, i32 4
%r29 = trunc i224 %r26 to i32
store i32 %r29, i32* %r28
%r30 = lshr i224 %r26, 32
%r32 = getelementptr i32, i32* %r1, i32 5
%r33 = trunc i224 %r30 to i32
store i32 %r33, i32* %r32
%r34 = lshr i224 %r30, 32
%r36 = getelementptr i32, i32* %r1, i32 6
%r37 = trunc i224 %r34 to i32
store i32 %r37, i32* %r36
ret void
}
define i32 @mclb_subNF7(i32* noalias  %r2, i32* noalias  %r3, i32* noalias  %r4)
{
%r6 = bitcast i32* %r3 to i224*
%r7 = load i224, i224* %r6
%r9 = bitcast i32* %r4 to i224*
%r10 = load i224, i224* %r9
%r11 = sub i224 %r7, %r10
%r13 = getelementptr i32, i32* %r2, i32 0
%r14 = trunc i224 %r11 to i32
store i32 %r14, i32* %r13
%r15 = lshr i224 %r11, 32
%r17 = getelementptr i32, i32* %r2, i32 1
%r18 = trunc i224 %r15 to i32
store i32 %r18, i32* %r17
%r19 = lshr i224 %r15, 32
%r21 = getelementptr i32, i32* %r2, i32 2
%r22 = trunc i224 %r19 to i32
store i32 %r22, i32* %r21
%r23 = lshr i224 %r19, 32
%r25 = getelementptr i32, i32* %r2, i32 3
%r26 = trunc i224 %r23 to i32
store i32 %r26, i32* %r25
%r27 = lshr i224 %r23, 32
%r29 = getelementptr i32, i32* %r2, i32 4
%r30 = trunc i224 %r27 to i32
store i32 %r30, i32* %r29
%r31 = lshr i224 %r27, 32
%r33 = getelementptr i32, i32* %r2, i32 5
%r34 = trunc i224 %r31 to i32
store i32 %r34, i32* %r33
%r35 = lshr i224 %r31, 32
%r37 = getelementptr i32, i32* %r2, i32 6
%r38 = trunc i224 %r35 to i32
store i32 %r38, i32* %r37
%r39 = lshr i224 %r11, 223
%r40 = trunc i224 %r39 to i32
%r42 = and i32 %r40, 1
ret i32 %r42
}
define i32 @mclb_add8(i32* noalias  %r2, i32* noalias  %r3, i32* noalias  %r4)
{
%r6 = bitcast i32* %r3 to i256*
%r7 = load i256, i256* %r6
%r8 = zext i256 %r7 to i288
%r10 = bitcast i32* %r4 to i256*
%r11 = load i256, i256* %r10
%r12 = zext i256 %r11 to i288
%r13 = add i288 %r8, %r12
%r14 = trunc i288 %r13 to i256
%r16 = getelementptr i32, i32* %r2, i32 0
%r17 = trunc i256 %r14 to i32
store i32 %r17, i32* %r16
%r18 = lshr i256 %r14, 32
%r20 = getelementptr i32, i32* %r2, i32 1
%r21 = trunc i256 %r18 to i32
store i32 %r21, i32* %r20
%r22 = lshr i256 %r18, 32
%r24 = getelementptr i32, i32* %r2, i32 2
%r25 = trunc i256 %r22 to i32
store i32 %r25, i32* %r24
%r26 = lshr i256 %r22, 32
%r28 = getelementptr i32, i32* %r2, i32 3
%r29 = trunc i256 %r26 to i32
store i32 %r29, i32* %r28
%r30 = lshr i256 %r26, 32
%r32 = getelementptr i32, i32* %r2, i32 4
%r33 = trunc i256 %r30 to i32
store i32 %r33, i32* %r32
%r34 = lshr i256 %r30, 32
%r36 = getelementptr i32, i32* %r2, i32 5
%r37 = trunc i256 %r34 to i32
store i32 %r37, i32* %r36
%r38 = lshr i256 %r34, 32
%r40 = getelementptr i32, i32* %r2, i32 6
%r41 = trunc i256 %r38 to i32
store i32 %r41, i32* %r40
%r42 = lshr i256 %r38, 32
%r44 = getelementptr i32, i32* %r2, i32 7
%r45 = trunc i256 %r42 to i32
store i32 %r45, i32* %r44
%r46 = lshr i288 %r13, 256
%r47 = trunc i288 %r46 to i32
ret i32 %r47
}
define i32 @mclb_sub8(i32* noalias  %r2, i32* noalias  %r3, i32* noalias  %r4)
{
%r6 = bitcast i32* %r3 to i256*
%r7 = load i256, i256* %r6
%r8 = zext i256 %r7 to i288
%r10 = bitcast i32* %r4 to i256*
%r11 = load i256, i256* %r10
%r12 = zext i256 %r11 to i288
%r13 = sub i288 %r8, %r12
%r14 = trunc i288 %r13 to i256
%r16 = getelementptr i32, i32* %r2, i32 0
%r17 = trunc i256 %r14 to i32
store i32 %r17, i32* %r16
%r18 = lshr i256 %r14, 32
%r20 = getelementptr i32, i32* %r2, i32 1
%r21 = trunc i256 %r18 to i32
store i32 %r21, i32* %r20
%r22 = lshr i256 %r18, 32
%r24 = getelementptr i32, i32* %r2, i32 2
%r25 = trunc i256 %r22 to i32
store i32 %r25, i32* %r24
%r26 = lshr i256 %r22, 32
%r28 = getelementptr i32, i32* %r2, i32 3
%r29 = trunc i256 %r26 to i32
store i32 %r29, i32* %r28
%r30 = lshr i256 %r26, 32
%r32 = getelementptr i32, i32* %r2, i32 4
%r33 = trunc i256 %r30 to i32
store i32 %r33, i32* %r32
%r34 = lshr i256 %r30, 32
%r36 = getelementptr i32, i32* %r2, i32 5
%r37 = trunc i256 %r34 to i32
store i32 %r37, i32* %r36
%r38 = lshr i256 %r34, 32
%r40 = getelementptr i32, i32* %r2, i32 6
%r41 = trunc i256 %r38 to i32
store i32 %r41, i32* %r40
%r42 = lshr i256 %r38, 32
%r44 = getelementptr i32, i32* %r2, i32 7
%r45 = trunc i256 %r42 to i32
store i32 %r45, i32* %r44
%r46 = lshr i288 %r13, 256
%r47 = trunc i288 %r46 to i32
%r49 = and i32 %r47, 1
ret i32 %r49
}
define void @mclb_addNF8(i32* noalias  %r1, i32* noalias  %r2, i32* noalias  %r3)
{
%r5 = bitcast i32* %r2 to i256*
%r6 = load i256, i256* %r5
%r8 = bitcast i32* %r3 to i256*
%r9 = load i256, i256* %r8
%r10 = add i256 %r6, %r9
%r12 = getelementptr i32, i32* %r1, i32 0
%r13 = trunc i256 %r10 to i32
store i32 %r13, i32* %r12
%r14 = lshr i256 %r10, 32
%r16 = getelementptr i32, i32* %r1, i32 1
%r17 = trunc i256 %r14 to i32
store i32 %r17, i32* %r16
%r18 = lshr i256 %r14, 32
%r20 = getelementptr i32, i32* %r1, i32 2
%r21 = trunc i256 %r18 to i32
store i32 %r21, i32* %r20
%r22 = lshr i256 %r18, 32
%r24 = getelementptr i32, i32* %r1, i32 3
%r25 = trunc i256 %r22 to i32
store i32 %r25, i32* %r24
%r26 = lshr i256 %r22, 32
%r28 = getelementptr i32, i32* %r1, i32 4
%r29 = trunc i256 %r26 to i32
store i32 %r29, i32* %r28
%r30 = lshr i256 %r26, 32
%r32 = getelementptr i32, i32* %r1, i32 5
%r33 = trunc i256 %r30 to i32
store i32 %r33, i32* %r32
%r34 = lshr i256 %r30, 32
%r36 = getelementptr i32, i32* %r1, i32 6
%r37 = trunc i256 %r34 to i32
store i32 %r37, i32* %r36
%r38 = lshr i256 %r34, 32
%r40 = getelementptr i32, i32* %r1, i32 7
%r41 = trunc i256 %r38 to i32
store i32 %r41, i32* %r40
ret void
}
define i32 @mclb_subNF8(i32* noalias  %r2, i32* noalias  %r3, i32* noalias  %r4)
{
%r6 = bitcast i32* %r3 to i256*
%r7 = load i256, i256* %r6
%r9 = bitcast i32* %r4 to i256*
%r10 = load i256, i256* %r9
%r11 = sub i256 %r7, %r10
%r13 = getelementptr i32, i32* %r2, i32 0
%r14 = trunc i256 %r11 to i32
store i32 %r14, i32* %r13
%r15 = lshr i256 %r11, 32
%r17 = getelementptr i32, i32* %r2, i32 1
%r18 = trunc i256 %r15 to i32
store i32 %r18, i32* %r17
%r19 = lshr i256 %r15, 32
%r21 = getelementptr i32, i32* %r2, i32 2
%r22 = trunc i256 %r19 to i32
store i32 %r22, i32* %r21
%r23 = lshr i256 %r19, 32
%r25 = getelementptr i32, i32* %r2, i32 3
%r26 = trunc i256 %r23 to i32
store i32 %r26, i32* %r25
%r27 = lshr i256 %r23, 32
%r29 = getelementptr i32, i32* %r2, i32 4
%r30 = trunc i256 %r27 to i32
store i32 %r30, i32* %r29
%r31 = lshr i256 %r27, 32
%r33 = getelementptr i32, i32* %r2, i32 5
%r34 = trunc i256 %r31 to i32
store i32 %r34, i32* %r33
%r35 = lshr i256 %r31, 32
%r37 = getelementptr i32, i32* %r2, i32 6
%r38 = trunc i256 %r35 to i32
store i32 %r38, i32* %r37
%r39 = lshr i256 %r35, 32
%r41 = getelementptr i32, i32* %r2, i32 7
%r42 = trunc i256 %r39 to i32
store i32 %r42, i32* %r41
%r43 = lshr i256 %r11, 255
%r44 = trunc i256 %r43 to i32
%r46 = and i32 %r44, 1
ret i32 %r46
}
define i32 @mclb_add9(i32* noalias  %r2, i32* noalias  %r3, i32* noalias  %r4)
{
%r6 = bitcast i32* %r3 to i288*
%r7 = load i288, i288* %r6
%r8 = zext i288 %r7 to i320
%r10 = bitcast i32* %r4 to i288*
%r11 = load i288, i288* %r10
%r12 = zext i288 %r11 to i320
%r13 = add i320 %r8, %r12
%r14 = trunc i320 %r13 to i288
%r16 = getelementptr i32, i32* %r2, i32 0
%r17 = trunc i288 %r14 to i32
store i32 %r17, i32* %r16
%r18 = lshr i288 %r14, 32
%r20 = getelementptr i32, i32* %r2, i32 1
%r21 = trunc i288 %r18 to i32
store i32 %r21, i32* %r20
%r22 = lshr i288 %r18, 32
%r24 = getelementptr i32, i32* %r2, i32 2
%r25 = trunc i288 %r22 to i32
store i32 %r25, i32* %r24
%r26 = lshr i288 %r22, 32
%r28 = getelementptr i32, i32* %r2, i32 3
%r29 = trunc i288 %r26 to i32
store i32 %r29, i32* %r28
%r30 = lshr i288 %r26, 32
%r32 = getelementptr i32, i32* %r2, i32 4
%r33 = trunc i288 %r30 to i32
store i32 %r33, i32* %r32
%r34 = lshr i288 %r30, 32
%r36 = getelementptr i32, i32* %r2, i32 5
%r37 = trunc i288 %r34 to i32
store i32 %r37, i32* %r36
%r38 = lshr i288 %r34, 32
%r40 = getelementptr i32, i32* %r2, i32 6
%r41 = trunc i288 %r38 to i32
store i32 %r41, i32* %r40
%r42 = lshr i288 %r38, 32
%r44 = getelementptr i32, i32* %r2, i32 7
%r45 = trunc i288 %r42 to i32
store i32 %r45, i32* %r44
%r46 = lshr i288 %r42, 32
%r48 = getelementptr i32, i32* %r2, i32 8
%r49 = trunc i288 %r46 to i32
store i32 %r49, i32* %r48
%r50 = lshr i320 %r13, 288
%r51 = trunc i320 %r50 to i32
ret i32 %r51
}
define i32 @mclb_sub9(i32* noalias  %r2, i32* noalias  %r3, i32* noalias  %r4)
{
%r6 = bitcast i32* %r3 to i288*
%r7 = load i288, i288* %r6
%r8 = zext i288 %r7 to i320
%r10 = bitcast i32* %r4 to i288*
%r11 = load i288, i288* %r10
%r12 = zext i288 %r11 to i320
%r13 = sub i320 %r8, %r12
%r14 = trunc i320 %r13 to i288
%r16 = getelementptr i32, i32* %r2, i32 0
%r17 = trunc i288 %r14 to i32
store i32 %r17, i32* %r16
%r18 = lshr i288 %r14, 32
%r20 = getelementptr i32, i32* %r2, i32 1
%r21 = trunc i288 %r18 to i32
store i32 %r21, i32* %r20
%r22 = lshr i288 %r18, 32
%r24 = getelementptr i32, i32* %r2, i32 2
%r25 = trunc i288 %r22 to i32
store i32 %r25, i32* %r24
%r26 = lshr i288 %r22, 32
%r28 = getelementptr i32, i32* %r2, i32 3
%r29 = trunc i288 %r26 to i32
store i32 %r29, i32* %r28
%r30 = lshr i288 %r26, 32
%r32 = getelementptr i32, i32* %r2, i32 4
%r33 = trunc i288 %r30 to i32
store i32 %r33, i32* %r32
%r34 = lshr i288 %r30, 32
%r36 = getelementptr i32, i32* %r2, i32 5
%r37 = trunc i288 %r34 to i32
store i32 %r37, i32* %r36
%r38 = lshr i288 %r34, 32
%r40 = getelementptr i32, i32* %r2, i32 6
%r41 = trunc i288 %r38 to i32
store i32 %r41, i32* %r40
%r42 = lshr i288 %r38, 32
%r44 = getelementptr i32, i32* %r2, i32 7
%r45 = trunc i288 %r42 to i32
store i32 %r45, i32* %r44
%r46 = lshr i288 %r42, 32
%r48 = getelementptr i32, i32* %r2, i32 8
%r49 = trunc i288 %r46 to i32
store i32 %r49, i32* %r48
%r50 = lshr i320 %r13, 288
%r51 = trunc i320 %r50 to i32
%r53 = and i32 %r51, 1
ret i32 %r53
}
define void @mclb_addNF9(i32* noalias  %r1, i32* noalias  %r2, i32* noalias  %r3)
{
%r5 = bitcast i32* %r2 to i288*
%r6 = load i288, i288* %r5
%r8 = bitcast i32* %r3 to i288*
%r9 = load i288, i288* %r8
%r10 = add i288 %r6, %r9
%r12 = getelementptr i32, i32* %r1, i32 0
%r13 = trunc i288 %r10 to i32
store i32 %r13, i32* %r12
%r14 = lshr i288 %r10, 32
%r16 = getelementptr i32, i32* %r1, i32 1
%r17 = trunc i288 %r14 to i32
store i32 %r17, i32* %r16
%r18 = lshr i288 %r14, 32
%r20 = getelementptr i32, i32* %r1, i32 2
%r21 = trunc i288 %r18 to i32
store i32 %r21, i32* %r20
%r22 = lshr i288 %r18, 32
%r24 = getelementptr i32, i32* %r1, i32 3
%r25 = trunc i288 %r22 to i32
store i32 %r25, i32* %r24
%r26 = lshr i288 %r22, 32
%r28 = getelementptr i32, i32* %r1, i32 4
%r29 = trunc i288 %r26 to i32
store i32 %r29, i32* %r28
%r30 = lshr i288 %r26, 32
%r32 = getelementptr i32, i32* %r1, i32 5
%r33 = trunc i288 %r30 to i32
store i32 %r33, i32* %r32
%r34 = lshr i288 %r30, 32
%r36 = getelementptr i32, i32* %r1, i32 6
%r37 = trunc i288 %r34 to i32
store i32 %r37, i32* %r36
%r38 = lshr i288 %r34, 32
%r40 = getelementptr i32, i32* %r1, i32 7
%r41 = trunc i288 %r38 to i32
store i32 %r41, i32* %r40
%r42 = lshr i288 %r38, 32
%r44 = getelementptr i32, i32* %r1, i32 8
%r45 = trunc i288 %r42 to i32
store i32 %r45, i32* %r44
ret void
}
define i32 @mclb_subNF9(i32* noalias  %r2, i32* noalias  %r3, i32* noalias  %r4)
{
%r6 = bitcast i32* %r3 to i288*
%r7 = load i288, i288* %r6
%r9 = bitcast i32* %r4 to i288*
%r10 = load i288, i288* %r9
%r11 = sub i288 %r7, %r10
%r13 = getelementptr i32, i32* %r2, i32 0
%r14 = trunc i288 %r11 to i32
store i32 %r14, i32* %r13
%r15 = lshr i288 %r11, 32
%r17 = getelementptr i32, i32* %r2, i32 1
%r18 = trunc i288 %r15 to i32
store i32 %r18, i32* %r17
%r19 = lshr i288 %r15, 32
%r21 = getelementptr i32, i32* %r2, i32 2
%r22 = trunc i288 %r19 to i32
store i32 %r22, i32* %r21
%r23 = lshr i288 %r19, 32
%r25 = getelementptr i32, i32* %r2, i32 3
%r26 = trunc i288 %r23 to i32
store i32 %r26, i32* %r25
%r27 = lshr i288 %r23, 32
%r29 = getelementptr i32, i32* %r2, i32 4
%r30 = trunc i288 %r27 to i32
store i32 %r30, i32* %r29
%r31 = lshr i288 %r27, 32
%r33 = getelementptr i32, i32* %r2, i32 5
%r34 = trunc i288 %r31 to i32
store i32 %r34, i32* %r33
%r35 = lshr i288 %r31, 32
%r37 = getelementptr i32, i32* %r2, i32 6
%r38 = trunc i288 %r35 to i32
store i32 %r38, i32* %r37
%r39 = lshr i288 %r35, 32
%r41 = getelementptr i32, i32* %r2, i32 7
%r42 = trunc i288 %r39 to i32
store i32 %r42, i32* %r41
%r43 = lshr i288 %r39, 32
%r45 = getelementptr i32, i32* %r2, i32 8
%r46 = trunc i288 %r43 to i32
store i32 %r46, i32* %r45
%r47 = lshr i288 %r11, 287
%r48 = trunc i288 %r47 to i32
%r50 = and i32 %r48, 1
ret i32 %r50
}
define i32 @mclb_add10(i32* noalias  %r2, i32* noalias  %r3, i32* noalias  %r4)
{
%r6 = bitcast i32* %r3 to i320*
%r7 = load i320, i320* %r6
%r8 = zext i320 %r7 to i352
%r10 = bitcast i32* %r4 to i320*
%r11 = load i320, i320* %r10
%r12 = zext i320 %r11 to i352
%r13 = add i352 %r8, %r12
%r14 = trunc i352 %r13 to i320
%r16 = getelementptr i32, i32* %r2, i32 0
%r17 = trunc i320 %r14 to i32
store i32 %r17, i32* %r16
%r18 = lshr i320 %r14, 32
%r20 = getelementptr i32, i32* %r2, i32 1
%r21 = trunc i320 %r18 to i32
store i32 %r21, i32* %r20
%r22 = lshr i320 %r18, 32
%r24 = getelementptr i32, i32* %r2, i32 2
%r25 = trunc i320 %r22 to i32
store i32 %r25, i32* %r24
%r26 = lshr i320 %r22, 32
%r28 = getelementptr i32, i32* %r2, i32 3
%r29 = trunc i320 %r26 to i32
store i32 %r29, i32* %r28
%r30 = lshr i320 %r26, 32
%r32 = getelementptr i32, i32* %r2, i32 4
%r33 = trunc i320 %r30 to i32
store i32 %r33, i32* %r32
%r34 = lshr i320 %r30, 32
%r36 = getelementptr i32, i32* %r2, i32 5
%r37 = trunc i320 %r34 to i32
store i32 %r37, i32* %r36
%r38 = lshr i320 %r34, 32
%r40 = getelementptr i32, i32* %r2, i32 6
%r41 = trunc i320 %r38 to i32
store i32 %r41, i32* %r40
%r42 = lshr i320 %r38, 32
%r44 = getelementptr i32, i32* %r2, i32 7
%r45 = trunc i320 %r42 to i32
store i32 %r45, i32* %r44
%r46 = lshr i320 %r42, 32
%r48 = getelementptr i32, i32* %r2, i32 8
%r49 = trunc i320 %r46 to i32
store i32 %r49, i32* %r48
%r50 = lshr i320 %r46, 32
%r52 = getelementptr i32, i32* %r2, i32 9
%r53 = trunc i320 %r50 to i32
store i32 %r53, i32* %r52
%r54 = lshr i352 %r13, 320
%r55 = trunc i352 %r54 to i32
ret i32 %r55
}
define i32 @mclb_sub10(i32* noalias  %r2, i32* noalias  %r3, i32* noalias  %r4)
{
%r6 = bitcast i32* %r3 to i320*
%r7 = load i320, i320* %r6
%r8 = zext i320 %r7 to i352
%r10 = bitcast i32* %r4 to i320*
%r11 = load i320, i320* %r10
%r12 = zext i320 %r11 to i352
%r13 = sub i352 %r8, %r12
%r14 = trunc i352 %r13 to i320
%r16 = getelementptr i32, i32* %r2, i32 0
%r17 = trunc i320 %r14 to i32
store i32 %r17, i32* %r16
%r18 = lshr i320 %r14, 32
%r20 = getelementptr i32, i32* %r2, i32 1
%r21 = trunc i320 %r18 to i32
store i32 %r21, i32* %r20
%r22 = lshr i320 %r18, 32
%r24 = getelementptr i32, i32* %r2, i32 2
%r25 = trunc i320 %r22 to i32
store i32 %r25, i32* %r24
%r26 = lshr i320 %r22, 32
%r28 = getelementptr i32, i32* %r2, i32 3
%r29 = trunc i320 %r26 to i32
store i32 %r29, i32* %r28
%r30 = lshr i320 %r26, 32
%r32 = getelementptr i32, i32* %r2, i32 4
%r33 = trunc i320 %r30 to i32
store i32 %r33, i32* %r32
%r34 = lshr i320 %r30, 32
%r36 = getelementptr i32, i32* %r2, i32 5
%r37 = trunc i320 %r34 to i32
store i32 %r37, i32* %r36
%r38 = lshr i320 %r34, 32
%r40 = getelementptr i32, i32* %r2, i32 6
%r41 = trunc i320 %r38 to i32
store i32 %r41, i32* %r40
%r42 = lshr i320 %r38, 32
%r44 = getelementptr i32, i32* %r2, i32 7
%r45 = trunc i320 %r42 to i32
store i32 %r45, i32* %r44
%r46 = lshr i320 %r42, 32
%r48 = getelementptr i32, i32* %r2, i32 8
%r49 = trunc i320 %r46 to i32
store i32 %r49, i32* %r48
%r50 = lshr i320 %r46, 32
%r52 = getelementptr i32, i32* %r2, i32 9
%r53 = trunc i320 %r50 to i32
store i32 %r53, i32* %r52
%r54 = lshr i352 %r13, 320
%r55 = trunc i352 %r54 to i32
%r57 = and i32 %r55, 1
ret i32 %r57
}
define void @mclb_addNF10(i32* noalias  %r1, i32* noalias  %r2, i32* noalias  %r3)
{
%r5 = bitcast i32* %r2 to i320*
%r6 = load i320, i320* %r5
%r8 = bitcast i32* %r3 to i320*
%r9 = load i320, i320* %r8
%r10 = add i320 %r6, %r9
%r12 = getelementptr i32, i32* %r1, i32 0
%r13 = trunc i320 %r10 to i32
store i32 %r13, i32* %r12
%r14 = lshr i320 %r10, 32
%r16 = getelementptr i32, i32* %r1, i32 1
%r17 = trunc i320 %r14 to i32
store i32 %r17, i32* %r16
%r18 = lshr i320 %r14, 32
%r20 = getelementptr i32, i32* %r1, i32 2
%r21 = trunc i320 %r18 to i32
store i32 %r21, i32* %r20
%r22 = lshr i320 %r18, 32
%r24 = getelementptr i32, i32* %r1, i32 3
%r25 = trunc i320 %r22 to i32
store i32 %r25, i32* %r24
%r26 = lshr i320 %r22, 32
%r28 = getelementptr i32, i32* %r1, i32 4
%r29 = trunc i320 %r26 to i32
store i32 %r29, i32* %r28
%r30 = lshr i320 %r26, 32
%r32 = getelementptr i32, i32* %r1, i32 5
%r33 = trunc i320 %r30 to i32
store i32 %r33, i32* %r32
%r34 = lshr i320 %r30, 32
%r36 = getelementptr i32, i32* %r1, i32 6
%r37 = trunc i320 %r34 to i32
store i32 %r37, i32* %r36
%r38 = lshr i320 %r34, 32
%r40 = getelementptr i32, i32* %r1, i32 7
%r41 = trunc i320 %r38 to i32
store i32 %r41, i32* %r40
%r42 = lshr i320 %r38, 32
%r44 = getelementptr i32, i32* %r1, i32 8
%r45 = trunc i320 %r42 to i32
store i32 %r45, i32* %r44
%r46 = lshr i320 %r42, 32
%r48 = getelementptr i32, i32* %r1, i32 9
%r49 = trunc i320 %r46 to i32
store i32 %r49, i32* %r48
ret void
}
define i32 @mclb_subNF10(i32* noalias  %r2, i32* noalias  %r3, i32* noalias  %r4)
{
%r6 = bitcast i32* %r3 to i320*
%r7 = load i320, i320* %r6
%r9 = bitcast i32* %r4 to i320*
%r10 = load i320, i320* %r9
%r11 = sub i320 %r7, %r10
%r13 = getelementptr i32, i32* %r2, i32 0
%r14 = trunc i320 %r11 to i32
store i32 %r14, i32* %r13
%r15 = lshr i320 %r11, 32
%r17 = getelementptr i32, i32* %r2, i32 1
%r18 = trunc i320 %r15 to i32
store i32 %r18, i32* %r17
%r19 = lshr i320 %r15, 32
%r21 = getelementptr i32, i32* %r2, i32 2
%r22 = trunc i320 %r19 to i32
store i32 %r22, i32* %r21
%r23 = lshr i320 %r19, 32
%r25 = getelementptr i32, i32* %r2, i32 3
%r26 = trunc i320 %r23 to i32
store i32 %r26, i32* %r25
%r27 = lshr i320 %r23, 32
%r29 = getelementptr i32, i32* %r2, i32 4
%r30 = trunc i320 %r27 to i32
store i32 %r30, i32* %r29
%r31 = lshr i320 %r27, 32
%r33 = getelementptr i32, i32* %r2, i32 5
%r34 = trunc i320 %r31 to i32
store i32 %r34, i32* %r33
%r35 = lshr i320 %r31, 32
%r37 = getelementptr i32, i32* %r2, i32 6
%r38 = trunc i320 %r35 to i32
store i32 %r38, i32* %r37
%r39 = lshr i320 %r35, 32
%r41 = getelementptr i32, i32* %r2, i32 7
%r42 = trunc i320 %r39 to i32
store i32 %r42, i32* %r41
%r43 = lshr i320 %r39, 32
%r45 = getelementptr i32, i32* %r2, i32 8
%r46 = trunc i320 %r43 to i32
store i32 %r46, i32* %r45
%r47 = lshr i320 %r43, 32
%r49 = getelementptr i32, i32* %r2, i32 9
%r50 = trunc i320 %r47 to i32
store i32 %r50, i32* %r49
%r51 = lshr i320 %r11, 319
%r52 = trunc i320 %r51 to i32
%r54 = and i32 %r52, 1
ret i32 %r54
}
define i32 @mclb_add11(i32* noalias  %r2, i32* noalias  %r3, i32* noalias  %r4)
{
%r6 = bitcast i32* %r3 to i352*
%r7 = load i352, i352* %r6
%r8 = zext i352 %r7 to i384
%r10 = bitcast i32* %r4 to i352*
%r11 = load i352, i352* %r10
%r12 = zext i352 %r11 to i384
%r13 = add i384 %r8, %r12
%r14 = trunc i384 %r13 to i352
%r16 = getelementptr i32, i32* %r2, i32 0
%r17 = trunc i352 %r14 to i32
store i32 %r17, i32* %r16
%r18 = lshr i352 %r14, 32
%r20 = getelementptr i32, i32* %r2, i32 1
%r21 = trunc i352 %r18 to i32
store i32 %r21, i32* %r20
%r22 = lshr i352 %r18, 32
%r24 = getelementptr i32, i32* %r2, i32 2
%r25 = trunc i352 %r22 to i32
store i32 %r25, i32* %r24
%r26 = lshr i352 %r22, 32
%r28 = getelementptr i32, i32* %r2, i32 3
%r29 = trunc i352 %r26 to i32
store i32 %r29, i32* %r28
%r30 = lshr i352 %r26, 32
%r32 = getelementptr i32, i32* %r2, i32 4
%r33 = trunc i352 %r30 to i32
store i32 %r33, i32* %r32
%r34 = lshr i352 %r30, 32
%r36 = getelementptr i32, i32* %r2, i32 5
%r37 = trunc i352 %r34 to i32
store i32 %r37, i32* %r36
%r38 = lshr i352 %r34, 32
%r40 = getelementptr i32, i32* %r2, i32 6
%r41 = trunc i352 %r38 to i32
store i32 %r41, i32* %r40
%r42 = lshr i352 %r38, 32
%r44 = getelementptr i32, i32* %r2, i32 7
%r45 = trunc i352 %r42 to i32
store i32 %r45, i32* %r44
%r46 = lshr i352 %r42, 32
%r48 = getelementptr i32, i32* %r2, i32 8
%r49 = trunc i352 %r46 to i32
store i32 %r49, i32* %r48
%r50 = lshr i352 %r46, 32
%r52 = getelementptr i32, i32* %r2, i32 9
%r53 = trunc i352 %r50 to i32
store i32 %r53, i32* %r52
%r54 = lshr i352 %r50, 32
%r56 = getelementptr i32, i32* %r2, i32 10
%r57 = trunc i352 %r54 to i32
store i32 %r57, i32* %r56
%r58 = lshr i384 %r13, 352
%r59 = trunc i384 %r58 to i32
ret i32 %r59
}
define i32 @mclb_sub11(i32* noalias  %r2, i32* noalias  %r3, i32* noalias  %r4)
{
%r6 = bitcast i32* %r3 to i352*
%r7 = load i352, i352* %r6
%r8 = zext i352 %r7 to i384
%r10 = bitcast i32* %r4 to i352*
%r11 = load i352, i352* %r10
%r12 = zext i352 %r11 to i384
%r13 = sub i384 %r8, %r12
%r14 = trunc i384 %r13 to i352
%r16 = getelementptr i32, i32* %r2, i32 0
%r17 = trunc i352 %r14 to i32
store i32 %r17, i32* %r16
%r18 = lshr i352 %r14, 32
%r20 = getelementptr i32, i32* %r2, i32 1
%r21 = trunc i352 %r18 to i32
store i32 %r21, i32* %r20
%r22 = lshr i352 %r18, 32
%r24 = getelementptr i32, i32* %r2, i32 2
%r25 = trunc i352 %r22 to i32
store i32 %r25, i32* %r24
%r26 = lshr i352 %r22, 32
%r28 = getelementptr i32, i32* %r2, i32 3
%r29 = trunc i352 %r26 to i32
store i32 %r29, i32* %r28
%r30 = lshr i352 %r26, 32
%r32 = getelementptr i32, i32* %r2, i32 4
%r33 = trunc i352 %r30 to i32
store i32 %r33, i32* %r32
%r34 = lshr i352 %r30, 32
%r36 = getelementptr i32, i32* %r2, i32 5
%r37 = trunc i352 %r34 to i32
store i32 %r37, i32* %r36
%r38 = lshr i352 %r34, 32
%r40 = getelementptr i32, i32* %r2, i32 6
%r41 = trunc i352 %r38 to i32
store i32 %r41, i32* %r40
%r42 = lshr i352 %r38, 32
%r44 = getelementptr i32, i32* %r2, i32 7
%r45 = trunc i352 %r42 to i32
store i32 %r45, i32* %r44
%r46 = lshr i352 %r42, 32
%r48 = getelementptr i32, i32* %r2, i32 8
%r49 = trunc i352 %r46 to i32
store i32 %r49, i32* %r48
%r50 = lshr i352 %r46, 32
%r52 = getelementptr i32, i32* %r2, i32 9
%r53 = trunc i352 %r50 to i32
store i32 %r53, i32* %r52
%r54 = lshr i352 %r50, 32
%r56 = getelementptr i32, i32* %r2, i32 10
%r57 = trunc i352 %r54 to i32
store i32 %r57, i32* %r56
%r58 = lshr i384 %r13, 352
%r59 = trunc i384 %r58 to i32
%r61 = and i32 %r59, 1
ret i32 %r61
}
define void @mclb_addNF11(i32* noalias  %r1, i32* noalias  %r2, i32* noalias  %r3)
{
%r5 = bitcast i32* %r2 to i352*
%r6 = load i352, i352* %r5
%r8 = bitcast i32* %r3 to i352*
%r9 = load i352, i352* %r8
%r10 = add i352 %r6, %r9
%r12 = getelementptr i32, i32* %r1, i32 0
%r13 = trunc i352 %r10 to i32
store i32 %r13, i32* %r12
%r14 = lshr i352 %r10, 32
%r16 = getelementptr i32, i32* %r1, i32 1
%r17 = trunc i352 %r14 to i32
store i32 %r17, i32* %r16
%r18 = lshr i352 %r14, 32
%r20 = getelementptr i32, i32* %r1, i32 2
%r21 = trunc i352 %r18 to i32
store i32 %r21, i32* %r20
%r22 = lshr i352 %r18, 32
%r24 = getelementptr i32, i32* %r1, i32 3
%r25 = trunc i352 %r22 to i32
store i32 %r25, i32* %r24
%r26 = lshr i352 %r22, 32
%r28 = getelementptr i32, i32* %r1, i32 4
%r29 = trunc i352 %r26 to i32
store i32 %r29, i32* %r28
%r30 = lshr i352 %r26, 32
%r32 = getelementptr i32, i32* %r1, i32 5
%r33 = trunc i352 %r30 to i32
store i32 %r33, i32* %r32
%r34 = lshr i352 %r30, 32
%r36 = getelementptr i32, i32* %r1, i32 6
%r37 = trunc i352 %r34 to i32
store i32 %r37, i32* %r36
%r38 = lshr i352 %r34, 32
%r40 = getelementptr i32, i32* %r1, i32 7
%r41 = trunc i352 %r38 to i32
store i32 %r41, i32* %r40
%r42 = lshr i352 %r38, 32
%r44 = getelementptr i32, i32* %r1, i32 8
%r45 = trunc i352 %r42 to i32
store i32 %r45, i32* %r44
%r46 = lshr i352 %r42, 32
%r48 = getelementptr i32, i32* %r1, i32 9
%r49 = trunc i352 %r46 to i32
store i32 %r49, i32* %r48
%r50 = lshr i352 %r46, 32
%r52 = getelementptr i32, i32* %r1, i32 10
%r53 = trunc i352 %r50 to i32
store i32 %r53, i32* %r52
ret void
}
define i32 @mclb_subNF11(i32* noalias  %r2, i32* noalias  %r3, i32* noalias  %r4)
{
%r6 = bitcast i32* %r3 to i352*
%r7 = load i352, i352* %r6
%r9 = bitcast i32* %r4 to i352*
%r10 = load i352, i352* %r9
%r11 = sub i352 %r7, %r10
%r13 = getelementptr i32, i32* %r2, i32 0
%r14 = trunc i352 %r11 to i32
store i32 %r14, i32* %r13
%r15 = lshr i352 %r11, 32
%r17 = getelementptr i32, i32* %r2, i32 1
%r18 = trunc i352 %r15 to i32
store i32 %r18, i32* %r17
%r19 = lshr i352 %r15, 32
%r21 = getelementptr i32, i32* %r2, i32 2
%r22 = trunc i352 %r19 to i32
store i32 %r22, i32* %r21
%r23 = lshr i352 %r19, 32
%r25 = getelementptr i32, i32* %r2, i32 3
%r26 = trunc i352 %r23 to i32
store i32 %r26, i32* %r25
%r27 = lshr i352 %r23, 32
%r29 = getelementptr i32, i32* %r2, i32 4
%r30 = trunc i352 %r27 to i32
store i32 %r30, i32* %r29
%r31 = lshr i352 %r27, 32
%r33 = getelementptr i32, i32* %r2, i32 5
%r34 = trunc i352 %r31 to i32
store i32 %r34, i32* %r33
%r35 = lshr i352 %r31, 32
%r37 = getelementptr i32, i32* %r2, i32 6
%r38 = trunc i352 %r35 to i32
store i32 %r38, i32* %r37
%r39 = lshr i352 %r35, 32
%r41 = getelementptr i32, i32* %r2, i32 7
%r42 = trunc i352 %r39 to i32
store i32 %r42, i32* %r41
%r43 = lshr i352 %r39, 32
%r45 = getelementptr i32, i32* %r2, i32 8
%r46 = trunc i352 %r43 to i32
store i32 %r46, i32* %r45
%r47 = lshr i352 %r43, 32
%r49 = getelementptr i32, i32* %r2, i32 9
%r50 = trunc i352 %r47 to i32
store i32 %r50, i32* %r49
%r51 = lshr i352 %r47, 32
%r53 = getelementptr i32, i32* %r2, i32 10
%r54 = trunc i352 %r51 to i32
store i32 %r54, i32* %r53
%r55 = lshr i352 %r11, 351
%r56 = trunc i352 %r55 to i32
%r58 = and i32 %r56, 1
ret i32 %r58
}
define i32 @mclb_add12(i32* noalias  %r2, i32* noalias  %r3, i32* noalias  %r4)
{
%r6 = bitcast i32* %r3 to i384*
%r7 = load i384, i384* %r6
%r8 = zext i384 %r7 to i416
%r10 = bitcast i32* %r4 to i384*
%r11 = load i384, i384* %r10
%r12 = zext i384 %r11 to i416
%r13 = add i416 %r8, %r12
%r14 = trunc i416 %r13 to i384
%r16 = getelementptr i32, i32* %r2, i32 0
%r17 = trunc i384 %r14 to i32
store i32 %r17, i32* %r16
%r18 = lshr i384 %r14, 32
%r20 = getelementptr i32, i32* %r2, i32 1
%r21 = trunc i384 %r18 to i32
store i32 %r21, i32* %r20
%r22 = lshr i384 %r18, 32
%r24 = getelementptr i32, i32* %r2, i32 2
%r25 = trunc i384 %r22 to i32
store i32 %r25, i32* %r24
%r26 = lshr i384 %r22, 32
%r28 = getelementptr i32, i32* %r2, i32 3
%r29 = trunc i384 %r26 to i32
store i32 %r29, i32* %r28
%r30 = lshr i384 %r26, 32
%r32 = getelementptr i32, i32* %r2, i32 4
%r33 = trunc i384 %r30 to i32
store i32 %r33, i32* %r32
%r34 = lshr i384 %r30, 32
%r36 = getelementptr i32, i32* %r2, i32 5
%r37 = trunc i384 %r34 to i32
store i32 %r37, i32* %r36
%r38 = lshr i384 %r34, 32
%r40 = getelementptr i32, i32* %r2, i32 6
%r41 = trunc i384 %r38 to i32
store i32 %r41, i32* %r40
%r42 = lshr i384 %r38, 32
%r44 = getelementptr i32, i32* %r2, i32 7
%r45 = trunc i384 %r42 to i32
store i32 %r45, i32* %r44
%r46 = lshr i384 %r42, 32
%r48 = getelementptr i32, i32* %r2, i32 8
%r49 = trunc i384 %r46 to i32
store i32 %r49, i32* %r48
%r50 = lshr i384 %r46, 32
%r52 = getelementptr i32, i32* %r2, i32 9
%r53 = trunc i384 %r50 to i32
store i32 %r53, i32* %r52
%r54 = lshr i384 %r50, 32
%r56 = getelementptr i32, i32* %r2, i32 10
%r57 = trunc i384 %r54 to i32
store i32 %r57, i32* %r56
%r58 = lshr i384 %r54, 32
%r60 = getelementptr i32, i32* %r2, i32 11
%r61 = trunc i384 %r58 to i32
store i32 %r61, i32* %r60
%r62 = lshr i416 %r13, 384
%r63 = trunc i416 %r62 to i32
ret i32 %r63
}
define i32 @mclb_sub12(i32* noalias  %r2, i32* noalias  %r3, i32* noalias  %r4)
{
%r6 = bitcast i32* %r3 to i384*
%r7 = load i384, i384* %r6
%r8 = zext i384 %r7 to i416
%r10 = bitcast i32* %r4 to i384*
%r11 = load i384, i384* %r10
%r12 = zext i384 %r11 to i416
%r13 = sub i416 %r8, %r12
%r14 = trunc i416 %r13 to i384
%r16 = getelementptr i32, i32* %r2, i32 0
%r17 = trunc i384 %r14 to i32
store i32 %r17, i32* %r16
%r18 = lshr i384 %r14, 32
%r20 = getelementptr i32, i32* %r2, i32 1
%r21 = trunc i384 %r18 to i32
store i32 %r21, i32* %r20
%r22 = lshr i384 %r18, 32
%r24 = getelementptr i32, i32* %r2, i32 2
%r25 = trunc i384 %r22 to i32
store i32 %r25, i32* %r24
%r26 = lshr i384 %r22, 32
%r28 = getelementptr i32, i32* %r2, i32 3
%r29 = trunc i384 %r26 to i32
store i32 %r29, i32* %r28
%r30 = lshr i384 %r26, 32
%r32 = getelementptr i32, i32* %r2, i32 4
%r33 = trunc i384 %r30 to i32
store i32 %r33, i32* %r32
%r34 = lshr i384 %r30, 32
%r36 = getelementptr i32, i32* %r2, i32 5
%r37 = trunc i384 %r34 to i32
store i32 %r37, i32* %r36
%r38 = lshr i384 %r34, 32
%r40 = getelementptr i32, i32* %r2, i32 6
%r41 = trunc i384 %r38 to i32
store i32 %r41, i32* %r40
%r42 = lshr i384 %r38, 32
%r44 = getelementptr i32, i32* %r2, i32 7
%r45 = trunc i384 %r42 to i32
store i32 %r45, i32* %r44
%r46 = lshr i384 %r42, 32
%r48 = getelementptr i32, i32* %r2, i32 8
%r49 = trunc i384 %r46 to i32
store i32 %r49, i32* %r48
%r50 = lshr i384 %r46, 32
%r52 = getelementptr i32, i32* %r2, i32 9
%r53 = trunc i384 %r50 to i32
store i32 %r53, i32* %r52
%r54 = lshr i384 %r50, 32
%r56 = getelementptr i32, i32* %r2, i32 10
%r57 = trunc i384 %r54 to i32
store i32 %r57, i32* %r56
%r58 = lshr i384 %r54, 32
%r60 = getelementptr i32, i32* %r2, i32 11
%r61 = trunc i384 %r58 to i32
store i32 %r61, i32* %r60
%r62 = lshr i416 %r13, 384
%r63 = trunc i416 %r62 to i32
%r65 = and i32 %r63, 1
ret i32 %r65
}
define void @mclb_addNF12(i32* noalias  %r1, i32* noalias  %r2, i32* noalias  %r3)
{
%r5 = bitcast i32* %r2 to i384*
%r6 = load i384, i384* %r5
%r8 = bitcast i32* %r3 to i384*
%r9 = load i384, i384* %r8
%r10 = add i384 %r6, %r9
%r12 = getelementptr i32, i32* %r1, i32 0
%r13 = trunc i384 %r10 to i32
store i32 %r13, i32* %r12
%r14 = lshr i384 %r10, 32
%r16 = getelementptr i32, i32* %r1, i32 1
%r17 = trunc i384 %r14 to i32
store i32 %r17, i32* %r16
%r18 = lshr i384 %r14, 32
%r20 = getelementptr i32, i32* %r1, i32 2
%r21 = trunc i384 %r18 to i32
store i32 %r21, i32* %r20
%r22 = lshr i384 %r18, 32
%r24 = getelementptr i32, i32* %r1, i32 3
%r25 = trunc i384 %r22 to i32
store i32 %r25, i32* %r24
%r26 = lshr i384 %r22, 32
%r28 = getelementptr i32, i32* %r1, i32 4
%r29 = trunc i384 %r26 to i32
store i32 %r29, i32* %r28
%r30 = lshr i384 %r26, 32
%r32 = getelementptr i32, i32* %r1, i32 5
%r33 = trunc i384 %r30 to i32
store i32 %r33, i32* %r32
%r34 = lshr i384 %r30, 32
%r36 = getelementptr i32, i32* %r1, i32 6
%r37 = trunc i384 %r34 to i32
store i32 %r37, i32* %r36
%r38 = lshr i384 %r34, 32
%r40 = getelementptr i32, i32* %r1, i32 7
%r41 = trunc i384 %r38 to i32
store i32 %r41, i32* %r40
%r42 = lshr i384 %r38, 32
%r44 = getelementptr i32, i32* %r1, i32 8
%r45 = trunc i384 %r42 to i32
store i32 %r45, i32* %r44
%r46 = lshr i384 %r42, 32
%r48 = getelementptr i32, i32* %r1, i32 9
%r49 = trunc i384 %r46 to i32
store i32 %r49, i32* %r48
%r50 = lshr i384 %r46, 32
%r52 = getelementptr i32, i32* %r1, i32 10
%r53 = trunc i384 %r50 to i32
store i32 %r53, i32* %r52
%r54 = lshr i384 %r50, 32
%r56 = getelementptr i32, i32* %r1, i32 11
%r57 = trunc i384 %r54 to i32
store i32 %r57, i32* %r56
ret void
}
define i32 @mclb_subNF12(i32* noalias  %r2, i32* noalias  %r3, i32* noalias  %r4)
{
%r6 = bitcast i32* %r3 to i384*
%r7 = load i384, i384* %r6
%r9 = bitcast i32* %r4 to i384*
%r10 = load i384, i384* %r9
%r11 = sub i384 %r7, %r10
%r13 = getelementptr i32, i32* %r2, i32 0
%r14 = trunc i384 %r11 to i32
store i32 %r14, i32* %r13
%r15 = lshr i384 %r11, 32
%r17 = getelementptr i32, i32* %r2, i32 1
%r18 = trunc i384 %r15 to i32
store i32 %r18, i32* %r17
%r19 = lshr i384 %r15, 32
%r21 = getelementptr i32, i32* %r2, i32 2
%r22 = trunc i384 %r19 to i32
store i32 %r22, i32* %r21
%r23 = lshr i384 %r19, 32
%r25 = getelementptr i32, i32* %r2, i32 3
%r26 = trunc i384 %r23 to i32
store i32 %r26, i32* %r25
%r27 = lshr i384 %r23, 32
%r29 = getelementptr i32, i32* %r2, i32 4
%r30 = trunc i384 %r27 to i32
store i32 %r30, i32* %r29
%r31 = lshr i384 %r27, 32
%r33 = getelementptr i32, i32* %r2, i32 5
%r34 = trunc i384 %r31 to i32
store i32 %r34, i32* %r33
%r35 = lshr i384 %r31, 32
%r37 = getelementptr i32, i32* %r2, i32 6
%r38 = trunc i384 %r35 to i32
store i32 %r38, i32* %r37
%r39 = lshr i384 %r35, 32
%r41 = getelementptr i32, i32* %r2, i32 7
%r42 = trunc i384 %r39 to i32
store i32 %r42, i32* %r41
%r43 = lshr i384 %r39, 32
%r45 = getelementptr i32, i32* %r2, i32 8
%r46 = trunc i384 %r43 to i32
store i32 %r46, i32* %r45
%r47 = lshr i384 %r43, 32
%r49 = getelementptr i32, i32* %r2, i32 9
%r50 = trunc i384 %r47 to i32
store i32 %r50, i32* %r49
%r51 = lshr i384 %r47, 32
%r53 = getelementptr i32, i32* %r2, i32 10
%r54 = trunc i384 %r51 to i32
store i32 %r54, i32* %r53
%r55 = lshr i384 %r51, 32
%r57 = getelementptr i32, i32* %r2, i32 11
%r58 = trunc i384 %r55 to i32
store i32 %r58, i32* %r57
%r59 = lshr i384 %r11, 383
%r60 = trunc i384 %r59 to i32
%r62 = and i32 %r60, 1
ret i32 %r62
}
define i32 @mclb_add13(i32* noalias  %r2, i32* noalias  %r3, i32* noalias  %r4)
{
%r6 = bitcast i32* %r3 to i416*
%r7 = load i416, i416* %r6
%r8 = zext i416 %r7 to i448
%r10 = bitcast i32* %r4 to i416*
%r11 = load i416, i416* %r10
%r12 = zext i416 %r11 to i448
%r13 = add i448 %r8, %r12
%r14 = trunc i448 %r13 to i416
%r16 = getelementptr i32, i32* %r2, i32 0
%r17 = trunc i416 %r14 to i32
store i32 %r17, i32* %r16
%r18 = lshr i416 %r14, 32
%r20 = getelementptr i32, i32* %r2, i32 1
%r21 = trunc i416 %r18 to i32
store i32 %r21, i32* %r20
%r22 = lshr i416 %r18, 32
%r24 = getelementptr i32, i32* %r2, i32 2
%r25 = trunc i416 %r22 to i32
store i32 %r25, i32* %r24
%r26 = lshr i416 %r22, 32
%r28 = getelementptr i32, i32* %r2, i32 3
%r29 = trunc i416 %r26 to i32
store i32 %r29, i32* %r28
%r30 = lshr i416 %r26, 32
%r32 = getelementptr i32, i32* %r2, i32 4
%r33 = trunc i416 %r30 to i32
store i32 %r33, i32* %r32
%r34 = lshr i416 %r30, 32
%r36 = getelementptr i32, i32* %r2, i32 5
%r37 = trunc i416 %r34 to i32
store i32 %r37, i32* %r36
%r38 = lshr i416 %r34, 32
%r40 = getelementptr i32, i32* %r2, i32 6
%r41 = trunc i416 %r38 to i32
store i32 %r41, i32* %r40
%r42 = lshr i416 %r38, 32
%r44 = getelementptr i32, i32* %r2, i32 7
%r45 = trunc i416 %r42 to i32
store i32 %r45, i32* %r44
%r46 = lshr i416 %r42, 32
%r48 = getelementptr i32, i32* %r2, i32 8
%r49 = trunc i416 %r46 to i32
store i32 %r49, i32* %r48
%r50 = lshr i416 %r46, 32
%r52 = getelementptr i32, i32* %r2, i32 9
%r53 = trunc i416 %r50 to i32
store i32 %r53, i32* %r52
%r54 = lshr i416 %r50, 32
%r56 = getelementptr i32, i32* %r2, i32 10
%r57 = trunc i416 %r54 to i32
store i32 %r57, i32* %r56
%r58 = lshr i416 %r54, 32
%r60 = getelementptr i32, i32* %r2, i32 11
%r61 = trunc i416 %r58 to i32
store i32 %r61, i32* %r60
%r62 = lshr i416 %r58, 32
%r64 = getelementptr i32, i32* %r2, i32 12
%r65 = trunc i416 %r62 to i32
store i32 %r65, i32* %r64
%r66 = lshr i448 %r13, 416
%r67 = trunc i448 %r66 to i32
ret i32 %r67
}
define i32 @mclb_sub13(i32* noalias  %r2, i32* noalias  %r3, i32* noalias  %r4)
{
%r6 = bitcast i32* %r3 to i416*
%r7 = load i416, i416* %r6
%r8 = zext i416 %r7 to i448
%r10 = bitcast i32* %r4 to i416*
%r11 = load i416, i416* %r10
%r12 = zext i416 %r11 to i448
%r13 = sub i448 %r8, %r12
%r14 = trunc i448 %r13 to i416
%r16 = getelementptr i32, i32* %r2, i32 0
%r17 = trunc i416 %r14 to i32
store i32 %r17, i32* %r16
%r18 = lshr i416 %r14, 32
%r20 = getelementptr i32, i32* %r2, i32 1
%r21 = trunc i416 %r18 to i32
store i32 %r21, i32* %r20
%r22 = lshr i416 %r18, 32
%r24 = getelementptr i32, i32* %r2, i32 2
%r25 = trunc i416 %r22 to i32
store i32 %r25, i32* %r24
%r26 = lshr i416 %r22, 32
%r28 = getelementptr i32, i32* %r2, i32 3
%r29 = trunc i416 %r26 to i32
store i32 %r29, i32* %r28
%r30 = lshr i416 %r26, 32
%r32 = getelementptr i32, i32* %r2, i32 4
%r33 = trunc i416 %r30 to i32
store i32 %r33, i32* %r32
%r34 = lshr i416 %r30, 32
%r36 = getelementptr i32, i32* %r2, i32 5
%r37 = trunc i416 %r34 to i32
store i32 %r37, i32* %r36
%r38 = lshr i416 %r34, 32
%r40 = getelementptr i32, i32* %r2, i32 6
%r41 = trunc i416 %r38 to i32
store i32 %r41, i32* %r40
%r42 = lshr i416 %r38, 32
%r44 = getelementptr i32, i32* %r2, i32 7
%r45 = trunc i416 %r42 to i32
store i32 %r45, i32* %r44
%r46 = lshr i416 %r42, 32
%r48 = getelementptr i32, i32* %r2, i32 8
%r49 = trunc i416 %r46 to i32
store i32 %r49, i32* %r48
%r50 = lshr i416 %r46, 32
%r52 = getelementptr i32, i32* %r2, i32 9
%r53 = trunc i416 %r50 to i32
store i32 %r53, i32* %r52
%r54 = lshr i416 %r50, 32
%r56 = getelementptr i32, i32* %r2, i32 10
%r57 = trunc i416 %r54 to i32
store i32 %r57, i32* %r56
%r58 = lshr i416 %r54, 32
%r60 = getelementptr i32, i32* %r2, i32 11
%r61 = trunc i416 %r58 to i32
store i32 %r61, i32* %r60
%r62 = lshr i416 %r58, 32
%r64 = getelementptr i32, i32* %r2, i32 12
%r65 = trunc i416 %r62 to i32
store i32 %r65, i32* %r64
%r66 = lshr i448 %r13, 416
%r67 = trunc i448 %r66 to i32
%r69 = and i32 %r67, 1
ret i32 %r69
}
define void @mclb_addNF13(i32* noalias  %r1, i32* noalias  %r2, i32* noalias  %r3)
{
%r5 = bitcast i32* %r2 to i416*
%r6 = load i416, i416* %r5
%r8 = bitcast i32* %r3 to i416*
%r9 = load i416, i416* %r8
%r10 = add i416 %r6, %r9
%r12 = getelementptr i32, i32* %r1, i32 0
%r13 = trunc i416 %r10 to i32
store i32 %r13, i32* %r12
%r14 = lshr i416 %r10, 32
%r16 = getelementptr i32, i32* %r1, i32 1
%r17 = trunc i416 %r14 to i32
store i32 %r17, i32* %r16
%r18 = lshr i416 %r14, 32
%r20 = getelementptr i32, i32* %r1, i32 2
%r21 = trunc i416 %r18 to i32
store i32 %r21, i32* %r20
%r22 = lshr i416 %r18, 32
%r24 = getelementptr i32, i32* %r1, i32 3
%r25 = trunc i416 %r22 to i32
store i32 %r25, i32* %r24
%r26 = lshr i416 %r22, 32
%r28 = getelementptr i32, i32* %r1, i32 4
%r29 = trunc i416 %r26 to i32
store i32 %r29, i32* %r28
%r30 = lshr i416 %r26, 32
%r32 = getelementptr i32, i32* %r1, i32 5
%r33 = trunc i416 %r30 to i32
store i32 %r33, i32* %r32
%r34 = lshr i416 %r30, 32
%r36 = getelementptr i32, i32* %r1, i32 6
%r37 = trunc i416 %r34 to i32
store i32 %r37, i32* %r36
%r38 = lshr i416 %r34, 32
%r40 = getelementptr i32, i32* %r1, i32 7
%r41 = trunc i416 %r38 to i32
store i32 %r41, i32* %r40
%r42 = lshr i416 %r38, 32
%r44 = getelementptr i32, i32* %r1, i32 8
%r45 = trunc i416 %r42 to i32
store i32 %r45, i32* %r44
%r46 = lshr i416 %r42, 32
%r48 = getelementptr i32, i32* %r1, i32 9
%r49 = trunc i416 %r46 to i32
store i32 %r49, i32* %r48
%r50 = lshr i416 %r46, 32
%r52 = getelementptr i32, i32* %r1, i32 10
%r53 = trunc i416 %r50 to i32
store i32 %r53, i32* %r52
%r54 = lshr i416 %r50, 32
%r56 = getelementptr i32, i32* %r1, i32 11
%r57 = trunc i416 %r54 to i32
store i32 %r57, i32* %r56
%r58 = lshr i416 %r54, 32
%r60 = getelementptr i32, i32* %r1, i32 12
%r61 = trunc i416 %r58 to i32
store i32 %r61, i32* %r60
ret void
}
define i32 @mclb_subNF13(i32* noalias  %r2, i32* noalias  %r3, i32* noalias  %r4)
{
%r6 = bitcast i32* %r3 to i416*
%r7 = load i416, i416* %r6
%r9 = bitcast i32* %r4 to i416*
%r10 = load i416, i416* %r9
%r11 = sub i416 %r7, %r10
%r13 = getelementptr i32, i32* %r2, i32 0
%r14 = trunc i416 %r11 to i32
store i32 %r14, i32* %r13
%r15 = lshr i416 %r11, 32
%r17 = getelementptr i32, i32* %r2, i32 1
%r18 = trunc i416 %r15 to i32
store i32 %r18, i32* %r17
%r19 = lshr i416 %r15, 32
%r21 = getelementptr i32, i32* %r2, i32 2
%r22 = trunc i416 %r19 to i32
store i32 %r22, i32* %r21
%r23 = lshr i416 %r19, 32
%r25 = getelementptr i32, i32* %r2, i32 3
%r26 = trunc i416 %r23 to i32
store i32 %r26, i32* %r25
%r27 = lshr i416 %r23, 32
%r29 = getelementptr i32, i32* %r2, i32 4
%r30 = trunc i416 %r27 to i32
store i32 %r30, i32* %r29
%r31 = lshr i416 %r27, 32
%r33 = getelementptr i32, i32* %r2, i32 5
%r34 = trunc i416 %r31 to i32
store i32 %r34, i32* %r33
%r35 = lshr i416 %r31, 32
%r37 = getelementptr i32, i32* %r2, i32 6
%r38 = trunc i416 %r35 to i32
store i32 %r38, i32* %r37
%r39 = lshr i416 %r35, 32
%r41 = getelementptr i32, i32* %r2, i32 7
%r42 = trunc i416 %r39 to i32
store i32 %r42, i32* %r41
%r43 = lshr i416 %r39, 32
%r45 = getelementptr i32, i32* %r2, i32 8
%r46 = trunc i416 %r43 to i32
store i32 %r46, i32* %r45
%r47 = lshr i416 %r43, 32
%r49 = getelementptr i32, i32* %r2, i32 9
%r50 = trunc i416 %r47 to i32
store i32 %r50, i32* %r49
%r51 = lshr i416 %r47, 32
%r53 = getelementptr i32, i32* %r2, i32 10
%r54 = trunc i416 %r51 to i32
store i32 %r54, i32* %r53
%r55 = lshr i416 %r51, 32
%r57 = getelementptr i32, i32* %r2, i32 11
%r58 = trunc i416 %r55 to i32
store i32 %r58, i32* %r57
%r59 = lshr i416 %r55, 32
%r61 = getelementptr i32, i32* %r2, i32 12
%r62 = trunc i416 %r59 to i32
store i32 %r62, i32* %r61
%r63 = lshr i416 %r11, 415
%r64 = trunc i416 %r63 to i32
%r66 = and i32 %r64, 1
ret i32 %r66
}
define i32 @mclb_add14(i32* noalias  %r2, i32* noalias  %r3, i32* noalias  %r4)
{
%r6 = bitcast i32* %r3 to i448*
%r7 = load i448, i448* %r6
%r8 = zext i448 %r7 to i480
%r10 = bitcast i32* %r4 to i448*
%r11 = load i448, i448* %r10
%r12 = zext i448 %r11 to i480
%r13 = add i480 %r8, %r12
%r14 = trunc i480 %r13 to i448
%r16 = getelementptr i32, i32* %r2, i32 0
%r17 = trunc i448 %r14 to i32
store i32 %r17, i32* %r16
%r18 = lshr i448 %r14, 32
%r20 = getelementptr i32, i32* %r2, i32 1
%r21 = trunc i448 %r18 to i32
store i32 %r21, i32* %r20
%r22 = lshr i448 %r18, 32
%r24 = getelementptr i32, i32* %r2, i32 2
%r25 = trunc i448 %r22 to i32
store i32 %r25, i32* %r24
%r26 = lshr i448 %r22, 32
%r28 = getelementptr i32, i32* %r2, i32 3
%r29 = trunc i448 %r26 to i32
store i32 %r29, i32* %r28
%r30 = lshr i448 %r26, 32
%r32 = getelementptr i32, i32* %r2, i32 4
%r33 = trunc i448 %r30 to i32
store i32 %r33, i32* %r32
%r34 = lshr i448 %r30, 32
%r36 = getelementptr i32, i32* %r2, i32 5
%r37 = trunc i448 %r34 to i32
store i32 %r37, i32* %r36
%r38 = lshr i448 %r34, 32
%r40 = getelementptr i32, i32* %r2, i32 6
%r41 = trunc i448 %r38 to i32
store i32 %r41, i32* %r40
%r42 = lshr i448 %r38, 32
%r44 = getelementptr i32, i32* %r2, i32 7
%r45 = trunc i448 %r42 to i32
store i32 %r45, i32* %r44
%r46 = lshr i448 %r42, 32
%r48 = getelementptr i32, i32* %r2, i32 8
%r49 = trunc i448 %r46 to i32
store i32 %r49, i32* %r48
%r50 = lshr i448 %r46, 32
%r52 = getelementptr i32, i32* %r2, i32 9
%r53 = trunc i448 %r50 to i32
store i32 %r53, i32* %r52
%r54 = lshr i448 %r50, 32
%r56 = getelementptr i32, i32* %r2, i32 10
%r57 = trunc i448 %r54 to i32
store i32 %r57, i32* %r56
%r58 = lshr i448 %r54, 32
%r60 = getelementptr i32, i32* %r2, i32 11
%r61 = trunc i448 %r58 to i32
store i32 %r61, i32* %r60
%r62 = lshr i448 %r58, 32
%r64 = getelementptr i32, i32* %r2, i32 12
%r65 = trunc i448 %r62 to i32
store i32 %r65, i32* %r64
%r66 = lshr i448 %r62, 32
%r68 = getelementptr i32, i32* %r2, i32 13
%r69 = trunc i448 %r66 to i32
store i32 %r69, i32* %r68
%r70 = lshr i480 %r13, 448
%r71 = trunc i480 %r70 to i32
ret i32 %r71
}
define i32 @mclb_sub14(i32* noalias  %r2, i32* noalias  %r3, i32* noalias  %r4)
{
%r6 = bitcast i32* %r3 to i448*
%r7 = load i448, i448* %r6
%r8 = zext i448 %r7 to i480
%r10 = bitcast i32* %r4 to i448*
%r11 = load i448, i448* %r10
%r12 = zext i448 %r11 to i480
%r13 = sub i480 %r8, %r12
%r14 = trunc i480 %r13 to i448
%r16 = getelementptr i32, i32* %r2, i32 0
%r17 = trunc i448 %r14 to i32
store i32 %r17, i32* %r16
%r18 = lshr i448 %r14, 32
%r20 = getelementptr i32, i32* %r2, i32 1
%r21 = trunc i448 %r18 to i32
store i32 %r21, i32* %r20
%r22 = lshr i448 %r18, 32
%r24 = getelementptr i32, i32* %r2, i32 2
%r25 = trunc i448 %r22 to i32
store i32 %r25, i32* %r24
%r26 = lshr i448 %r22, 32
%r28 = getelementptr i32, i32* %r2, i32 3
%r29 = trunc i448 %r26 to i32
store i32 %r29, i32* %r28
%r30 = lshr i448 %r26, 32
%r32 = getelementptr i32, i32* %r2, i32 4
%r33 = trunc i448 %r30 to i32
store i32 %r33, i32* %r32
%r34 = lshr i448 %r30, 32
%r36 = getelementptr i32, i32* %r2, i32 5
%r37 = trunc i448 %r34 to i32
store i32 %r37, i32* %r36
%r38 = lshr i448 %r34, 32
%r40 = getelementptr i32, i32* %r2, i32 6
%r41 = trunc i448 %r38 to i32
store i32 %r41, i32* %r40
%r42 = lshr i448 %r38, 32
%r44 = getelementptr i32, i32* %r2, i32 7
%r45 = trunc i448 %r42 to i32
store i32 %r45, i32* %r44
%r46 = lshr i448 %r42, 32
%r48 = getelementptr i32, i32* %r2, i32 8
%r49 = trunc i448 %r46 to i32
store i32 %r49, i32* %r48
%r50 = lshr i448 %r46, 32
%r52 = getelementptr i32, i32* %r2, i32 9
%r53 = trunc i448 %r50 to i32
store i32 %r53, i32* %r52
%r54 = lshr i448 %r50, 32
%r56 = getelementptr i32, i32* %r2, i32 10
%r57 = trunc i448 %r54 to i32
store i32 %r57, i32* %r56
%r58 = lshr i448 %r54, 32
%r60 = getelementptr i32, i32* %r2, i32 11
%r61 = trunc i448 %r58 to i32
store i32 %r61, i32* %r60
%r62 = lshr i448 %r58, 32
%r64 = getelementptr i32, i32* %r2, i32 12
%r65 = trunc i448 %r62 to i32
store i32 %r65, i32* %r64
%r66 = lshr i448 %r62, 32
%r68 = getelementptr i32, i32* %r2, i32 13
%r69 = trunc i448 %r66 to i32
store i32 %r69, i32* %r68
%r70 = lshr i480 %r13, 448
%r71 = trunc i480 %r70 to i32
%r73 = and i32 %r71, 1
ret i32 %r73
}
define void @mclb_addNF14(i32* noalias  %r1, i32* noalias  %r2, i32* noalias  %r3)
{
%r5 = bitcast i32* %r2 to i448*
%r6 = load i448, i448* %r5
%r8 = bitcast i32* %r3 to i448*
%r9 = load i448, i448* %r8
%r10 = add i448 %r6, %r9
%r12 = getelementptr i32, i32* %r1, i32 0
%r13 = trunc i448 %r10 to i32
store i32 %r13, i32* %r12
%r14 = lshr i448 %r10, 32
%r16 = getelementptr i32, i32* %r1, i32 1
%r17 = trunc i448 %r14 to i32
store i32 %r17, i32* %r16
%r18 = lshr i448 %r14, 32
%r20 = getelementptr i32, i32* %r1, i32 2
%r21 = trunc i448 %r18 to i32
store i32 %r21, i32* %r20
%r22 = lshr i448 %r18, 32
%r24 = getelementptr i32, i32* %r1, i32 3
%r25 = trunc i448 %r22 to i32
store i32 %r25, i32* %r24
%r26 = lshr i448 %r22, 32
%r28 = getelementptr i32, i32* %r1, i32 4
%r29 = trunc i448 %r26 to i32
store i32 %r29, i32* %r28
%r30 = lshr i448 %r26, 32
%r32 = getelementptr i32, i32* %r1, i32 5
%r33 = trunc i448 %r30 to i32
store i32 %r33, i32* %r32
%r34 = lshr i448 %r30, 32
%r36 = getelementptr i32, i32* %r1, i32 6
%r37 = trunc i448 %r34 to i32
store i32 %r37, i32* %r36
%r38 = lshr i448 %r34, 32
%r40 = getelementptr i32, i32* %r1, i32 7
%r41 = trunc i448 %r38 to i32
store i32 %r41, i32* %r40
%r42 = lshr i448 %r38, 32
%r44 = getelementptr i32, i32* %r1, i32 8
%r45 = trunc i448 %r42 to i32
store i32 %r45, i32* %r44
%r46 = lshr i448 %r42, 32
%r48 = getelementptr i32, i32* %r1, i32 9
%r49 = trunc i448 %r46 to i32
store i32 %r49, i32* %r48
%r50 = lshr i448 %r46, 32
%r52 = getelementptr i32, i32* %r1, i32 10
%r53 = trunc i448 %r50 to i32
store i32 %r53, i32* %r52
%r54 = lshr i448 %r50, 32
%r56 = getelementptr i32, i32* %r1, i32 11
%r57 = trunc i448 %r54 to i32
store i32 %r57, i32* %r56
%r58 = lshr i448 %r54, 32
%r60 = getelementptr i32, i32* %r1, i32 12
%r61 = trunc i448 %r58 to i32
store i32 %r61, i32* %r60
%r62 = lshr i448 %r58, 32
%r64 = getelementptr i32, i32* %r1, i32 13
%r65 = trunc i448 %r62 to i32
store i32 %r65, i32* %r64
ret void
}
define i32 @mclb_subNF14(i32* noalias  %r2, i32* noalias  %r3, i32* noalias  %r4)
{
%r6 = bitcast i32* %r3 to i448*
%r7 = load i448, i448* %r6
%r9 = bitcast i32* %r4 to i448*
%r10 = load i448, i448* %r9
%r11 = sub i448 %r7, %r10
%r13 = getelementptr i32, i32* %r2, i32 0
%r14 = trunc i448 %r11 to i32
store i32 %r14, i32* %r13
%r15 = lshr i448 %r11, 32
%r17 = getelementptr i32, i32* %r2, i32 1
%r18 = trunc i448 %r15 to i32
store i32 %r18, i32* %r17
%r19 = lshr i448 %r15, 32
%r21 = getelementptr i32, i32* %r2, i32 2
%r22 = trunc i448 %r19 to i32
store i32 %r22, i32* %r21
%r23 = lshr i448 %r19, 32
%r25 = getelementptr i32, i32* %r2, i32 3
%r26 = trunc i448 %r23 to i32
store i32 %r26, i32* %r25
%r27 = lshr i448 %r23, 32
%r29 = getelementptr i32, i32* %r2, i32 4
%r30 = trunc i448 %r27 to i32
store i32 %r30, i32* %r29
%r31 = lshr i448 %r27, 32
%r33 = getelementptr i32, i32* %r2, i32 5
%r34 = trunc i448 %r31 to i32
store i32 %r34, i32* %r33
%r35 = lshr i448 %r31, 32
%r37 = getelementptr i32, i32* %r2, i32 6
%r38 = trunc i448 %r35 to i32
store i32 %r38, i32* %r37
%r39 = lshr i448 %r35, 32
%r41 = getelementptr i32, i32* %r2, i32 7
%r42 = trunc i448 %r39 to i32
store i32 %r42, i32* %r41
%r43 = lshr i448 %r39, 32
%r45 = getelementptr i32, i32* %r2, i32 8
%r46 = trunc i448 %r43 to i32
store i32 %r46, i32* %r45
%r47 = lshr i448 %r43, 32
%r49 = getelementptr i32, i32* %r2, i32 9
%r50 = trunc i448 %r47 to i32
store i32 %r50, i32* %r49
%r51 = lshr i448 %r47, 32
%r53 = getelementptr i32, i32* %r2, i32 10
%r54 = trunc i448 %r51 to i32
store i32 %r54, i32* %r53
%r55 = lshr i448 %r51, 32
%r57 = getelementptr i32, i32* %r2, i32 11
%r58 = trunc i448 %r55 to i32
store i32 %r58, i32* %r57
%r59 = lshr i448 %r55, 32
%r61 = getelementptr i32, i32* %r2, i32 12
%r62 = trunc i448 %r59 to i32
store i32 %r62, i32* %r61
%r63 = lshr i448 %r59, 32
%r65 = getelementptr i32, i32* %r2, i32 13
%r66 = trunc i448 %r63 to i32
store i32 %r66, i32* %r65
%r67 = lshr i448 %r11, 447
%r68 = trunc i448 %r67 to i32
%r70 = and i32 %r68, 1
ret i32 %r70
}
define i32 @mclb_add15(i32* noalias  %r2, i32* noalias  %r3, i32* noalias  %r4)
{
%r6 = bitcast i32* %r3 to i480*
%r7 = load i480, i480* %r6
%r8 = zext i480 %r7 to i512
%r10 = bitcast i32* %r4 to i480*
%r11 = load i480, i480* %r10
%r12 = zext i480 %r11 to i512
%r13 = add i512 %r8, %r12
%r14 = trunc i512 %r13 to i480
%r16 = getelementptr i32, i32* %r2, i32 0
%r17 = trunc i480 %r14 to i32
store i32 %r17, i32* %r16
%r18 = lshr i480 %r14, 32
%r20 = getelementptr i32, i32* %r2, i32 1
%r21 = trunc i480 %r18 to i32
store i32 %r21, i32* %r20
%r22 = lshr i480 %r18, 32
%r24 = getelementptr i32, i32* %r2, i32 2
%r25 = trunc i480 %r22 to i32
store i32 %r25, i32* %r24
%r26 = lshr i480 %r22, 32
%r28 = getelementptr i32, i32* %r2, i32 3
%r29 = trunc i480 %r26 to i32
store i32 %r29, i32* %r28
%r30 = lshr i480 %r26, 32
%r32 = getelementptr i32, i32* %r2, i32 4
%r33 = trunc i480 %r30 to i32
store i32 %r33, i32* %r32
%r34 = lshr i480 %r30, 32
%r36 = getelementptr i32, i32* %r2, i32 5
%r37 = trunc i480 %r34 to i32
store i32 %r37, i32* %r36
%r38 = lshr i480 %r34, 32
%r40 = getelementptr i32, i32* %r2, i32 6
%r41 = trunc i480 %r38 to i32
store i32 %r41, i32* %r40
%r42 = lshr i480 %r38, 32
%r44 = getelementptr i32, i32* %r2, i32 7
%r45 = trunc i480 %r42 to i32
store i32 %r45, i32* %r44
%r46 = lshr i480 %r42, 32
%r48 = getelementptr i32, i32* %r2, i32 8
%r49 = trunc i480 %r46 to i32
store i32 %r49, i32* %r48
%r50 = lshr i480 %r46, 32
%r52 = getelementptr i32, i32* %r2, i32 9
%r53 = trunc i480 %r50 to i32
store i32 %r53, i32* %r52
%r54 = lshr i480 %r50, 32
%r56 = getelementptr i32, i32* %r2, i32 10
%r57 = trunc i480 %r54 to i32
store i32 %r57, i32* %r56
%r58 = lshr i480 %r54, 32
%r60 = getelementptr i32, i32* %r2, i32 11
%r61 = trunc i480 %r58 to i32
store i32 %r61, i32* %r60
%r62 = lshr i480 %r58, 32
%r64 = getelementptr i32, i32* %r2, i32 12
%r65 = trunc i480 %r62 to i32
store i32 %r65, i32* %r64
%r66 = lshr i480 %r62, 32
%r68 = getelementptr i32, i32* %r2, i32 13
%r69 = trunc i480 %r66 to i32
store i32 %r69, i32* %r68
%r70 = lshr i480 %r66, 32
%r72 = getelementptr i32, i32* %r2, i32 14
%r73 = trunc i480 %r70 to i32
store i32 %r73, i32* %r72
%r74 = lshr i512 %r13, 480
%r75 = trunc i512 %r74 to i32
ret i32 %r75
}
define i32 @mclb_sub15(i32* noalias  %r2, i32* noalias  %r3, i32* noalias  %r4)
{
%r6 = bitcast i32* %r3 to i480*
%r7 = load i480, i480* %r6
%r8 = zext i480 %r7 to i512
%r10 = bitcast i32* %r4 to i480*
%r11 = load i480, i480* %r10
%r12 = zext i480 %r11 to i512
%r13 = sub i512 %r8, %r12
%r14 = trunc i512 %r13 to i480
%r16 = getelementptr i32, i32* %r2, i32 0
%r17 = trunc i480 %r14 to i32
store i32 %r17, i32* %r16
%r18 = lshr i480 %r14, 32
%r20 = getelementptr i32, i32* %r2, i32 1
%r21 = trunc i480 %r18 to i32
store i32 %r21, i32* %r20
%r22 = lshr i480 %r18, 32
%r24 = getelementptr i32, i32* %r2, i32 2
%r25 = trunc i480 %r22 to i32
store i32 %r25, i32* %r24
%r26 = lshr i480 %r22, 32
%r28 = getelementptr i32, i32* %r2, i32 3
%r29 = trunc i480 %r26 to i32
store i32 %r29, i32* %r28
%r30 = lshr i480 %r26, 32
%r32 = getelementptr i32, i32* %r2, i32 4
%r33 = trunc i480 %r30 to i32
store i32 %r33, i32* %r32
%r34 = lshr i480 %r30, 32
%r36 = getelementptr i32, i32* %r2, i32 5
%r37 = trunc i480 %r34 to i32
store i32 %r37, i32* %r36
%r38 = lshr i480 %r34, 32
%r40 = getelementptr i32, i32* %r2, i32 6
%r41 = trunc i480 %r38 to i32
store i32 %r41, i32* %r40
%r42 = lshr i480 %r38, 32
%r44 = getelementptr i32, i32* %r2, i32 7
%r45 = trunc i480 %r42 to i32
store i32 %r45, i32* %r44
%r46 = lshr i480 %r42, 32
%r48 = getelementptr i32, i32* %r2, i32 8
%r49 = trunc i480 %r46 to i32
store i32 %r49, i32* %r48
%r50 = lshr i480 %r46, 32
%r52 = getelementptr i32, i32* %r2, i32 9
%r53 = trunc i480 %r50 to i32
store i32 %r53, i32* %r52
%r54 = lshr i480 %r50, 32
%r56 = getelementptr i32, i32* %r2, i32 10
%r57 = trunc i480 %r54 to i32
store i32 %r57, i32* %r56
%r58 = lshr i480 %r54, 32
%r60 = getelementptr i32, i32* %r2, i32 11
%r61 = trunc i480 %r58 to i32
store i32 %r61, i32* %r60
%r62 = lshr i480 %r58, 32
%r64 = getelementptr i32, i32* %r2, i32 12
%r65 = trunc i480 %r62 to i32
store i32 %r65, i32* %r64
%r66 = lshr i480 %r62, 32
%r68 = getelementptr i32, i32* %r2, i32 13
%r69 = trunc i480 %r66 to i32
store i32 %r69, i32* %r68
%r70 = lshr i480 %r66, 32
%r72 = getelementptr i32, i32* %r2, i32 14
%r73 = trunc i480 %r70 to i32
store i32 %r73, i32* %r72
%r74 = lshr i512 %r13, 480
%r75 = trunc i512 %r74 to i32
%r77 = and i32 %r75, 1
ret i32 %r77
}
define void @mclb_addNF15(i32* noalias  %r1, i32* noalias  %r2, i32* noalias  %r3)
{
%r5 = bitcast i32* %r2 to i480*
%r6 = load i480, i480* %r5
%r8 = bitcast i32* %r3 to i480*
%r9 = load i480, i480* %r8
%r10 = add i480 %r6, %r9
%r12 = getelementptr i32, i32* %r1, i32 0
%r13 = trunc i480 %r10 to i32
store i32 %r13, i32* %r12
%r14 = lshr i480 %r10, 32
%r16 = getelementptr i32, i32* %r1, i32 1
%r17 = trunc i480 %r14 to i32
store i32 %r17, i32* %r16
%r18 = lshr i480 %r14, 32
%r20 = getelementptr i32, i32* %r1, i32 2
%r21 = trunc i480 %r18 to i32
store i32 %r21, i32* %r20
%r22 = lshr i480 %r18, 32
%r24 = getelementptr i32, i32* %r1, i32 3
%r25 = trunc i480 %r22 to i32
store i32 %r25, i32* %r24
%r26 = lshr i480 %r22, 32
%r28 = getelementptr i32, i32* %r1, i32 4
%r29 = trunc i480 %r26 to i32
store i32 %r29, i32* %r28
%r30 = lshr i480 %r26, 32
%r32 = getelementptr i32, i32* %r1, i32 5
%r33 = trunc i480 %r30 to i32
store i32 %r33, i32* %r32
%r34 = lshr i480 %r30, 32
%r36 = getelementptr i32, i32* %r1, i32 6
%r37 = trunc i480 %r34 to i32
store i32 %r37, i32* %r36
%r38 = lshr i480 %r34, 32
%r40 = getelementptr i32, i32* %r1, i32 7
%r41 = trunc i480 %r38 to i32
store i32 %r41, i32* %r40
%r42 = lshr i480 %r38, 32
%r44 = getelementptr i32, i32* %r1, i32 8
%r45 = trunc i480 %r42 to i32
store i32 %r45, i32* %r44
%r46 = lshr i480 %r42, 32
%r48 = getelementptr i32, i32* %r1, i32 9
%r49 = trunc i480 %r46 to i32
store i32 %r49, i32* %r48
%r50 = lshr i480 %r46, 32
%r52 = getelementptr i32, i32* %r1, i32 10
%r53 = trunc i480 %r50 to i32
store i32 %r53, i32* %r52
%r54 = lshr i480 %r50, 32
%r56 = getelementptr i32, i32* %r1, i32 11
%r57 = trunc i480 %r54 to i32
store i32 %r57, i32* %r56
%r58 = lshr i480 %r54, 32
%r60 = getelementptr i32, i32* %r1, i32 12
%r61 = trunc i480 %r58 to i32
store i32 %r61, i32* %r60
%r62 = lshr i480 %r58, 32
%r64 = getelementptr i32, i32* %r1, i32 13
%r65 = trunc i480 %r62 to i32
store i32 %r65, i32* %r64
%r66 = lshr i480 %r62, 32
%r68 = getelementptr i32, i32* %r1, i32 14
%r69 = trunc i480 %r66 to i32
store i32 %r69, i32* %r68
ret void
}
define i32 @mclb_subNF15(i32* noalias  %r2, i32* noalias  %r3, i32* noalias  %r4)
{
%r6 = bitcast i32* %r3 to i480*
%r7 = load i480, i480* %r6
%r9 = bitcast i32* %r4 to i480*
%r10 = load i480, i480* %r9
%r11 = sub i480 %r7, %r10
%r13 = getelementptr i32, i32* %r2, i32 0
%r14 = trunc i480 %r11 to i32
store i32 %r14, i32* %r13
%r15 = lshr i480 %r11, 32
%r17 = getelementptr i32, i32* %r2, i32 1
%r18 = trunc i480 %r15 to i32
store i32 %r18, i32* %r17
%r19 = lshr i480 %r15, 32
%r21 = getelementptr i32, i32* %r2, i32 2
%r22 = trunc i480 %r19 to i32
store i32 %r22, i32* %r21
%r23 = lshr i480 %r19, 32
%r25 = getelementptr i32, i32* %r2, i32 3
%r26 = trunc i480 %r23 to i32
store i32 %r26, i32* %r25
%r27 = lshr i480 %r23, 32
%r29 = getelementptr i32, i32* %r2, i32 4
%r30 = trunc i480 %r27 to i32
store i32 %r30, i32* %r29
%r31 = lshr i480 %r27, 32
%r33 = getelementptr i32, i32* %r2, i32 5
%r34 = trunc i480 %r31 to i32
store i32 %r34, i32* %r33
%r35 = lshr i480 %r31, 32
%r37 = getelementptr i32, i32* %r2, i32 6
%r38 = trunc i480 %r35 to i32
store i32 %r38, i32* %r37
%r39 = lshr i480 %r35, 32
%r41 = getelementptr i32, i32* %r2, i32 7
%r42 = trunc i480 %r39 to i32
store i32 %r42, i32* %r41
%r43 = lshr i480 %r39, 32
%r45 = getelementptr i32, i32* %r2, i32 8
%r46 = trunc i480 %r43 to i32
store i32 %r46, i32* %r45
%r47 = lshr i480 %r43, 32
%r49 = getelementptr i32, i32* %r2, i32 9
%r50 = trunc i480 %r47 to i32
store i32 %r50, i32* %r49
%r51 = lshr i480 %r47, 32
%r53 = getelementptr i32, i32* %r2, i32 10
%r54 = trunc i480 %r51 to i32
store i32 %r54, i32* %r53
%r55 = lshr i480 %r51, 32
%r57 = getelementptr i32, i32* %r2, i32 11
%r58 = trunc i480 %r55 to i32
store i32 %r58, i32* %r57
%r59 = lshr i480 %r55, 32
%r61 = getelementptr i32, i32* %r2, i32 12
%r62 = trunc i480 %r59 to i32
store i32 %r62, i32* %r61
%r63 = lshr i480 %r59, 32
%r65 = getelementptr i32, i32* %r2, i32 13
%r66 = trunc i480 %r63 to i32
store i32 %r66, i32* %r65
%r67 = lshr i480 %r63, 32
%r69 = getelementptr i32, i32* %r2, i32 14
%r70 = trunc i480 %r67 to i32
store i32 %r70, i32* %r69
%r71 = lshr i480 %r11, 479
%r72 = trunc i480 %r71 to i32
%r74 = and i32 %r72, 1
ret i32 %r74
}
define i32 @mclb_add16(i32* noalias  %r2, i32* noalias  %r3, i32* noalias  %r4)
{
%r6 = bitcast i32* %r3 to i512*
%r7 = load i512, i512* %r6
%r8 = zext i512 %r7 to i544
%r10 = bitcast i32* %r4 to i512*
%r11 = load i512, i512* %r10
%r12 = zext i512 %r11 to i544
%r13 = add i544 %r8, %r12
%r14 = trunc i544 %r13 to i512
%r16 = getelementptr i32, i32* %r2, i32 0
%r17 = trunc i512 %r14 to i32
store i32 %r17, i32* %r16
%r18 = lshr i512 %r14, 32
%r20 = getelementptr i32, i32* %r2, i32 1
%r21 = trunc i512 %r18 to i32
store i32 %r21, i32* %r20
%r22 = lshr i512 %r18, 32
%r24 = getelementptr i32, i32* %r2, i32 2
%r25 = trunc i512 %r22 to i32
store i32 %r25, i32* %r24
%r26 = lshr i512 %r22, 32
%r28 = getelementptr i32, i32* %r2, i32 3
%r29 = trunc i512 %r26 to i32
store i32 %r29, i32* %r28
%r30 = lshr i512 %r26, 32
%r32 = getelementptr i32, i32* %r2, i32 4
%r33 = trunc i512 %r30 to i32
store i32 %r33, i32* %r32
%r34 = lshr i512 %r30, 32
%r36 = getelementptr i32, i32* %r2, i32 5
%r37 = trunc i512 %r34 to i32
store i32 %r37, i32* %r36
%r38 = lshr i512 %r34, 32
%r40 = getelementptr i32, i32* %r2, i32 6
%r41 = trunc i512 %r38 to i32
store i32 %r41, i32* %r40
%r42 = lshr i512 %r38, 32
%r44 = getelementptr i32, i32* %r2, i32 7
%r45 = trunc i512 %r42 to i32
store i32 %r45, i32* %r44
%r46 = lshr i512 %r42, 32
%r48 = getelementptr i32, i32* %r2, i32 8
%r49 = trunc i512 %r46 to i32
store i32 %r49, i32* %r48
%r50 = lshr i512 %r46, 32
%r52 = getelementptr i32, i32* %r2, i32 9
%r53 = trunc i512 %r50 to i32
store i32 %r53, i32* %r52
%r54 = lshr i512 %r50, 32
%r56 = getelementptr i32, i32* %r2, i32 10
%r57 = trunc i512 %r54 to i32
store i32 %r57, i32* %r56
%r58 = lshr i512 %r54, 32
%r60 = getelementptr i32, i32* %r2, i32 11
%r61 = trunc i512 %r58 to i32
store i32 %r61, i32* %r60
%r62 = lshr i512 %r58, 32
%r64 = getelementptr i32, i32* %r2, i32 12
%r65 = trunc i512 %r62 to i32
store i32 %r65, i32* %r64
%r66 = lshr i512 %r62, 32
%r68 = getelementptr i32, i32* %r2, i32 13
%r69 = trunc i512 %r66 to i32
store i32 %r69, i32* %r68
%r70 = lshr i512 %r66, 32
%r72 = getelementptr i32, i32* %r2, i32 14
%r73 = trunc i512 %r70 to i32
store i32 %r73, i32* %r72
%r74 = lshr i512 %r70, 32
%r76 = getelementptr i32, i32* %r2, i32 15
%r77 = trunc i512 %r74 to i32
store i32 %r77, i32* %r76
%r78 = lshr i544 %r13, 512
%r79 = trunc i544 %r78 to i32
ret i32 %r79
}
define i32 @mclb_sub16(i32* noalias  %r2, i32* noalias  %r3, i32* noalias  %r4)
{
%r6 = bitcast i32* %r3 to i512*
%r7 = load i512, i512* %r6
%r8 = zext i512 %r7 to i544
%r10 = bitcast i32* %r4 to i512*
%r11 = load i512, i512* %r10
%r12 = zext i512 %r11 to i544
%r13 = sub i544 %r8, %r12
%r14 = trunc i544 %r13 to i512
%r16 = getelementptr i32, i32* %r2, i32 0
%r17 = trunc i512 %r14 to i32
store i32 %r17, i32* %r16
%r18 = lshr i512 %r14, 32
%r20 = getelementptr i32, i32* %r2, i32 1
%r21 = trunc i512 %r18 to i32
store i32 %r21, i32* %r20
%r22 = lshr i512 %r18, 32
%r24 = getelementptr i32, i32* %r2, i32 2
%r25 = trunc i512 %r22 to i32
store i32 %r25, i32* %r24
%r26 = lshr i512 %r22, 32
%r28 = getelementptr i32, i32* %r2, i32 3
%r29 = trunc i512 %r26 to i32
store i32 %r29, i32* %r28
%r30 = lshr i512 %r26, 32
%r32 = getelementptr i32, i32* %r2, i32 4
%r33 = trunc i512 %r30 to i32
store i32 %r33, i32* %r32
%r34 = lshr i512 %r30, 32
%r36 = getelementptr i32, i32* %r2, i32 5
%r37 = trunc i512 %r34 to i32
store i32 %r37, i32* %r36
%r38 = lshr i512 %r34, 32
%r40 = getelementptr i32, i32* %r2, i32 6
%r41 = trunc i512 %r38 to i32
store i32 %r41, i32* %r40
%r42 = lshr i512 %r38, 32
%r44 = getelementptr i32, i32* %r2, i32 7
%r45 = trunc i512 %r42 to i32
store i32 %r45, i32* %r44
%r46 = lshr i512 %r42, 32
%r48 = getelementptr i32, i32* %r2, i32 8
%r49 = trunc i512 %r46 to i32
store i32 %r49, i32* %r48
%r50 = lshr i512 %r46, 32
%r52 = getelementptr i32, i32* %r2, i32 9
%r53 = trunc i512 %r50 to i32
store i32 %r53, i32* %r52
%r54 = lshr i512 %r50, 32
%r56 = getelementptr i32, i32* %r2, i32 10
%r57 = trunc i512 %r54 to i32
store i32 %r57, i32* %r56
%r58 = lshr i512 %r54, 32
%r60 = getelementptr i32, i32* %r2, i32 11
%r61 = trunc i512 %r58 to i32
store i32 %r61, i32* %r60
%r62 = lshr i512 %r58, 32
%r64 = getelementptr i32, i32* %r2, i32 12
%r65 = trunc i512 %r62 to i32
store i32 %r65, i32* %r64
%r66 = lshr i512 %r62, 32
%r68 = getelementptr i32, i32* %r2, i32 13
%r69 = trunc i512 %r66 to i32
store i32 %r69, i32* %r68
%r70 = lshr i512 %r66, 32
%r72 = getelementptr i32, i32* %r2, i32 14
%r73 = trunc i512 %r70 to i32
store i32 %r73, i32* %r72
%r74 = lshr i512 %r70, 32
%r76 = getelementptr i32, i32* %r2, i32 15
%r77 = trunc i512 %r74 to i32
store i32 %r77, i32* %r76
%r78 = lshr i544 %r13, 512
%r79 = trunc i544 %r78 to i32
%r81 = and i32 %r79, 1
ret i32 %r81
}
define void @mclb_addNF16(i32* noalias  %r1, i32* noalias  %r2, i32* noalias  %r3)
{
%r5 = bitcast i32* %r2 to i512*
%r6 = load i512, i512* %r5
%r8 = bitcast i32* %r3 to i512*
%r9 = load i512, i512* %r8
%r10 = add i512 %r6, %r9
%r12 = getelementptr i32, i32* %r1, i32 0
%r13 = trunc i512 %r10 to i32
store i32 %r13, i32* %r12
%r14 = lshr i512 %r10, 32
%r16 = getelementptr i32, i32* %r1, i32 1
%r17 = trunc i512 %r14 to i32
store i32 %r17, i32* %r16
%r18 = lshr i512 %r14, 32
%r20 = getelementptr i32, i32* %r1, i32 2
%r21 = trunc i512 %r18 to i32
store i32 %r21, i32* %r20
%r22 = lshr i512 %r18, 32
%r24 = getelementptr i32, i32* %r1, i32 3
%r25 = trunc i512 %r22 to i32
store i32 %r25, i32* %r24
%r26 = lshr i512 %r22, 32
%r28 = getelementptr i32, i32* %r1, i32 4
%r29 = trunc i512 %r26 to i32
store i32 %r29, i32* %r28
%r30 = lshr i512 %r26, 32
%r32 = getelementptr i32, i32* %r1, i32 5
%r33 = trunc i512 %r30 to i32
store i32 %r33, i32* %r32
%r34 = lshr i512 %r30, 32
%r36 = getelementptr i32, i32* %r1, i32 6
%r37 = trunc i512 %r34 to i32
store i32 %r37, i32* %r36
%r38 = lshr i512 %r34, 32
%r40 = getelementptr i32, i32* %r1, i32 7
%r41 = trunc i512 %r38 to i32
store i32 %r41, i32* %r40
%r42 = lshr i512 %r38, 32
%r44 = getelementptr i32, i32* %r1, i32 8
%r45 = trunc i512 %r42 to i32
store i32 %r45, i32* %r44
%r46 = lshr i512 %r42, 32
%r48 = getelementptr i32, i32* %r1, i32 9
%r49 = trunc i512 %r46 to i32
store i32 %r49, i32* %r48
%r50 = lshr i512 %r46, 32
%r52 = getelementptr i32, i32* %r1, i32 10
%r53 = trunc i512 %r50 to i32
store i32 %r53, i32* %r52
%r54 = lshr i512 %r50, 32
%r56 = getelementptr i32, i32* %r1, i32 11
%r57 = trunc i512 %r54 to i32
store i32 %r57, i32* %r56
%r58 = lshr i512 %r54, 32
%r60 = getelementptr i32, i32* %r1, i32 12
%r61 = trunc i512 %r58 to i32
store i32 %r61, i32* %r60
%r62 = lshr i512 %r58, 32
%r64 = getelementptr i32, i32* %r1, i32 13
%r65 = trunc i512 %r62 to i32
store i32 %r65, i32* %r64
%r66 = lshr i512 %r62, 32
%r68 = getelementptr i32, i32* %r1, i32 14
%r69 = trunc i512 %r66 to i32
store i32 %r69, i32* %r68
%r70 = lshr i512 %r66, 32
%r72 = getelementptr i32, i32* %r1, i32 15
%r73 = trunc i512 %r70 to i32
store i32 %r73, i32* %r72
ret void
}
define i32 @mclb_subNF16(i32* noalias  %r2, i32* noalias  %r3, i32* noalias  %r4)
{
%r6 = bitcast i32* %r3 to i512*
%r7 = load i512, i512* %r6
%r9 = bitcast i32* %r4 to i512*
%r10 = load i512, i512* %r9
%r11 = sub i512 %r7, %r10
%r13 = getelementptr i32, i32* %r2, i32 0
%r14 = trunc i512 %r11 to i32
store i32 %r14, i32* %r13
%r15 = lshr i512 %r11, 32
%r17 = getelementptr i32, i32* %r2, i32 1
%r18 = trunc i512 %r15 to i32
store i32 %r18, i32* %r17
%r19 = lshr i512 %r15, 32
%r21 = getelementptr i32, i32* %r2, i32 2
%r22 = trunc i512 %r19 to i32
store i32 %r22, i32* %r21
%r23 = lshr i512 %r19, 32
%r25 = getelementptr i32, i32* %r2, i32 3
%r26 = trunc i512 %r23 to i32
store i32 %r26, i32* %r25
%r27 = lshr i512 %r23, 32
%r29 = getelementptr i32, i32* %r2, i32 4
%r30 = trunc i512 %r27 to i32
store i32 %r30, i32* %r29
%r31 = lshr i512 %r27, 32
%r33 = getelementptr i32, i32* %r2, i32 5
%r34 = trunc i512 %r31 to i32
store i32 %r34, i32* %r33
%r35 = lshr i512 %r31, 32
%r37 = getelementptr i32, i32* %r2, i32 6
%r38 = trunc i512 %r35 to i32
store i32 %r38, i32* %r37
%r39 = lshr i512 %r35, 32
%r41 = getelementptr i32, i32* %r2, i32 7
%r42 = trunc i512 %r39 to i32
store i32 %r42, i32* %r41
%r43 = lshr i512 %r39, 32
%r45 = getelementptr i32, i32* %r2, i32 8
%r46 = trunc i512 %r43 to i32
store i32 %r46, i32* %r45
%r47 = lshr i512 %r43, 32
%r49 = getelementptr i32, i32* %r2, i32 9
%r50 = trunc i512 %r47 to i32
store i32 %r50, i32* %r49
%r51 = lshr i512 %r47, 32
%r53 = getelementptr i32, i32* %r2, i32 10
%r54 = trunc i512 %r51 to i32
store i32 %r54, i32* %r53
%r55 = lshr i512 %r51, 32
%r57 = getelementptr i32, i32* %r2, i32 11
%r58 = trunc i512 %r55 to i32
store i32 %r58, i32* %r57
%r59 = lshr i512 %r55, 32
%r61 = getelementptr i32, i32* %r2, i32 12
%r62 = trunc i512 %r59 to i32
store i32 %r62, i32* %r61
%r63 = lshr i512 %r59, 32
%r65 = getelementptr i32, i32* %r2, i32 13
%r66 = trunc i512 %r63 to i32
store i32 %r66, i32* %r65
%r67 = lshr i512 %r63, 32
%r69 = getelementptr i32, i32* %r2, i32 14
%r70 = trunc i512 %r67 to i32
store i32 %r70, i32* %r69
%r71 = lshr i512 %r67, 32
%r73 = getelementptr i32, i32* %r2, i32 15
%r74 = trunc i512 %r71 to i32
store i32 %r74, i32* %r73
%r75 = lshr i512 %r11, 511
%r76 = trunc i512 %r75 to i32
%r78 = and i32 %r76, 1
ret i32 %r78
}
define i32 @mclb_add17(i32* noalias  %r2, i32* noalias  %r3, i32* noalias  %r4)
{
%r6 = bitcast i32* %r3 to i544*
%r7 = load i544, i544* %r6
%r8 = zext i544 %r7 to i576
%r10 = bitcast i32* %r4 to i544*
%r11 = load i544, i544* %r10
%r12 = zext i544 %r11 to i576
%r13 = add i576 %r8, %r12
%r14 = trunc i576 %r13 to i544
%r16 = getelementptr i32, i32* %r2, i32 0
%r17 = trunc i544 %r14 to i32
store i32 %r17, i32* %r16
%r18 = lshr i544 %r14, 32
%r20 = getelementptr i32, i32* %r2, i32 1
%r21 = trunc i544 %r18 to i32
store i32 %r21, i32* %r20
%r22 = lshr i544 %r18, 32
%r24 = getelementptr i32, i32* %r2, i32 2
%r25 = trunc i544 %r22 to i32
store i32 %r25, i32* %r24
%r26 = lshr i544 %r22, 32
%r28 = getelementptr i32, i32* %r2, i32 3
%r29 = trunc i544 %r26 to i32
store i32 %r29, i32* %r28
%r30 = lshr i544 %r26, 32
%r32 = getelementptr i32, i32* %r2, i32 4
%r33 = trunc i544 %r30 to i32
store i32 %r33, i32* %r32
%r34 = lshr i544 %r30, 32
%r36 = getelementptr i32, i32* %r2, i32 5
%r37 = trunc i544 %r34 to i32
store i32 %r37, i32* %r36
%r38 = lshr i544 %r34, 32
%r40 = getelementptr i32, i32* %r2, i32 6
%r41 = trunc i544 %r38 to i32
store i32 %r41, i32* %r40
%r42 = lshr i544 %r38, 32
%r44 = getelementptr i32, i32* %r2, i32 7
%r45 = trunc i544 %r42 to i32
store i32 %r45, i32* %r44
%r46 = lshr i544 %r42, 32
%r48 = getelementptr i32, i32* %r2, i32 8
%r49 = trunc i544 %r46 to i32
store i32 %r49, i32* %r48
%r50 = lshr i544 %r46, 32
%r52 = getelementptr i32, i32* %r2, i32 9
%r53 = trunc i544 %r50 to i32
store i32 %r53, i32* %r52
%r54 = lshr i544 %r50, 32
%r56 = getelementptr i32, i32* %r2, i32 10
%r57 = trunc i544 %r54 to i32
store i32 %r57, i32* %r56
%r58 = lshr i544 %r54, 32
%r60 = getelementptr i32, i32* %r2, i32 11
%r61 = trunc i544 %r58 to i32
store i32 %r61, i32* %r60
%r62 = lshr i544 %r58, 32
%r64 = getelementptr i32, i32* %r2, i32 12
%r65 = trunc i544 %r62 to i32
store i32 %r65, i32* %r64
%r66 = lshr i544 %r62, 32
%r68 = getelementptr i32, i32* %r2, i32 13
%r69 = trunc i544 %r66 to i32
store i32 %r69, i32* %r68
%r70 = lshr i544 %r66, 32
%r72 = getelementptr i32, i32* %r2, i32 14
%r73 = trunc i544 %r70 to i32
store i32 %r73, i32* %r72
%r74 = lshr i544 %r70, 32
%r76 = getelementptr i32, i32* %r2, i32 15
%r77 = trunc i544 %r74 to i32
store i32 %r77, i32* %r76
%r78 = lshr i544 %r74, 32
%r80 = getelementptr i32, i32* %r2, i32 16
%r81 = trunc i544 %r78 to i32
store i32 %r81, i32* %r80
%r82 = lshr i576 %r13, 544
%r83 = trunc i576 %r82 to i32
ret i32 %r83
}
define i32 @mclb_sub17(i32* noalias  %r2, i32* noalias  %r3, i32* noalias  %r4)
{
%r6 = bitcast i32* %r3 to i544*
%r7 = load i544, i544* %r6
%r8 = zext i544 %r7 to i576
%r10 = bitcast i32* %r4 to i544*
%r11 = load i544, i544* %r10
%r12 = zext i544 %r11 to i576
%r13 = sub i576 %r8, %r12
%r14 = trunc i576 %r13 to i544
%r16 = getelementptr i32, i32* %r2, i32 0
%r17 = trunc i544 %r14 to i32
store i32 %r17, i32* %r16
%r18 = lshr i544 %r14, 32
%r20 = getelementptr i32, i32* %r2, i32 1
%r21 = trunc i544 %r18 to i32
store i32 %r21, i32* %r20
%r22 = lshr i544 %r18, 32
%r24 = getelementptr i32, i32* %r2, i32 2
%r25 = trunc i544 %r22 to i32
store i32 %r25, i32* %r24
%r26 = lshr i544 %r22, 32
%r28 = getelementptr i32, i32* %r2, i32 3
%r29 = trunc i544 %r26 to i32
store i32 %r29, i32* %r28
%r30 = lshr i544 %r26, 32
%r32 = getelementptr i32, i32* %r2, i32 4
%r33 = trunc i544 %r30 to i32
store i32 %r33, i32* %r32
%r34 = lshr i544 %r30, 32
%r36 = getelementptr i32, i32* %r2, i32 5
%r37 = trunc i544 %r34 to i32
store i32 %r37, i32* %r36
%r38 = lshr i544 %r34, 32
%r40 = getelementptr i32, i32* %r2, i32 6
%r41 = trunc i544 %r38 to i32
store i32 %r41, i32* %r40
%r42 = lshr i544 %r38, 32
%r44 = getelementptr i32, i32* %r2, i32 7
%r45 = trunc i544 %r42 to i32
store i32 %r45, i32* %r44
%r46 = lshr i544 %r42, 32
%r48 = getelementptr i32, i32* %r2, i32 8
%r49 = trunc i544 %r46 to i32
store i32 %r49, i32* %r48
%r50 = lshr i544 %r46, 32
%r52 = getelementptr i32, i32* %r2, i32 9
%r53 = trunc i544 %r50 to i32
store i32 %r53, i32* %r52
%r54 = lshr i544 %r50, 32
%r56 = getelementptr i32, i32* %r2, i32 10
%r57 = trunc i544 %r54 to i32
store i32 %r57, i32* %r56
%r58 = lshr i544 %r54, 32
%r60 = getelementptr i32, i32* %r2, i32 11
%r61 = trunc i544 %r58 to i32
store i32 %r61, i32* %r60
%r62 = lshr i544 %r58, 32
%r64 = getelementptr i32, i32* %r2, i32 12
%r65 = trunc i544 %r62 to i32
store i32 %r65, i32* %r64
%r66 = lshr i544 %r62, 32
%r68 = getelementptr i32, i32* %r2, i32 13
%r69 = trunc i544 %r66 to i32
store i32 %r69, i32* %r68
%r70 = lshr i544 %r66, 32
%r72 = getelementptr i32, i32* %r2, i32 14
%r73 = trunc i544 %r70 to i32
store i32 %r73, i32* %r72
%r74 = lshr i544 %r70, 32
%r76 = getelementptr i32, i32* %r2, i32 15
%r77 = trunc i544 %r74 to i32
store i32 %r77, i32* %r76
%r78 = lshr i544 %r74, 32
%r80 = getelementptr i32, i32* %r2, i32 16
%r81 = trunc i544 %r78 to i32
store i32 %r81, i32* %r80
%r82 = lshr i576 %r13, 544
%r83 = trunc i576 %r82 to i32
%r85 = and i32 %r83, 1
ret i32 %r85
}
define void @mclb_addNF17(i32* noalias  %r1, i32* noalias  %r2, i32* noalias  %r3)
{
%r5 = bitcast i32* %r2 to i544*
%r6 = load i544, i544* %r5
%r8 = bitcast i32* %r3 to i544*
%r9 = load i544, i544* %r8
%r10 = add i544 %r6, %r9
%r12 = getelementptr i32, i32* %r1, i32 0
%r13 = trunc i544 %r10 to i32
store i32 %r13, i32* %r12
%r14 = lshr i544 %r10, 32
%r16 = getelementptr i32, i32* %r1, i32 1
%r17 = trunc i544 %r14 to i32
store i32 %r17, i32* %r16
%r18 = lshr i544 %r14, 32
%r20 = getelementptr i32, i32* %r1, i32 2
%r21 = trunc i544 %r18 to i32
store i32 %r21, i32* %r20
%r22 = lshr i544 %r18, 32
%r24 = getelementptr i32, i32* %r1, i32 3
%r25 = trunc i544 %r22 to i32
store i32 %r25, i32* %r24
%r26 = lshr i544 %r22, 32
%r28 = getelementptr i32, i32* %r1, i32 4
%r29 = trunc i544 %r26 to i32
store i32 %r29, i32* %r28
%r30 = lshr i544 %r26, 32
%r32 = getelementptr i32, i32* %r1, i32 5
%r33 = trunc i544 %r30 to i32
store i32 %r33, i32* %r32
%r34 = lshr i544 %r30, 32
%r36 = getelementptr i32, i32* %r1, i32 6
%r37 = trunc i544 %r34 to i32
store i32 %r37, i32* %r36
%r38 = lshr i544 %r34, 32
%r40 = getelementptr i32, i32* %r1, i32 7
%r41 = trunc i544 %r38 to i32
store i32 %r41, i32* %r40
%r42 = lshr i544 %r38, 32
%r44 = getelementptr i32, i32* %r1, i32 8
%r45 = trunc i544 %r42 to i32
store i32 %r45, i32* %r44
%r46 = lshr i544 %r42, 32
%r48 = getelementptr i32, i32* %r1, i32 9
%r49 = trunc i544 %r46 to i32
store i32 %r49, i32* %r48
%r50 = lshr i544 %r46, 32
%r52 = getelementptr i32, i32* %r1, i32 10
%r53 = trunc i544 %r50 to i32
store i32 %r53, i32* %r52
%r54 = lshr i544 %r50, 32
%r56 = getelementptr i32, i32* %r1, i32 11
%r57 = trunc i544 %r54 to i32
store i32 %r57, i32* %r56
%r58 = lshr i544 %r54, 32
%r60 = getelementptr i32, i32* %r1, i32 12
%r61 = trunc i544 %r58 to i32
store i32 %r61, i32* %r60
%r62 = lshr i544 %r58, 32
%r64 = getelementptr i32, i32* %r1, i32 13
%r65 = trunc i544 %r62 to i32
store i32 %r65, i32* %r64
%r66 = lshr i544 %r62, 32
%r68 = getelementptr i32, i32* %r1, i32 14
%r69 = trunc i544 %r66 to i32
store i32 %r69, i32* %r68
%r70 = lshr i544 %r66, 32
%r72 = getelementptr i32, i32* %r1, i32 15
%r73 = trunc i544 %r70 to i32
store i32 %r73, i32* %r72
%r74 = lshr i544 %r70, 32
%r76 = getelementptr i32, i32* %r1, i32 16
%r77 = trunc i544 %r74 to i32
store i32 %r77, i32* %r76
ret void
}
define i32 @mclb_subNF17(i32* noalias  %r2, i32* noalias  %r3, i32* noalias  %r4)
{
%r6 = bitcast i32* %r3 to i544*
%r7 = load i544, i544* %r6
%r9 = bitcast i32* %r4 to i544*
%r10 = load i544, i544* %r9
%r11 = sub i544 %r7, %r10
%r13 = getelementptr i32, i32* %r2, i32 0
%r14 = trunc i544 %r11 to i32
store i32 %r14, i32* %r13
%r15 = lshr i544 %r11, 32
%r17 = getelementptr i32, i32* %r2, i32 1
%r18 = trunc i544 %r15 to i32
store i32 %r18, i32* %r17
%r19 = lshr i544 %r15, 32
%r21 = getelementptr i32, i32* %r2, i32 2
%r22 = trunc i544 %r19 to i32
store i32 %r22, i32* %r21
%r23 = lshr i544 %r19, 32
%r25 = getelementptr i32, i32* %r2, i32 3
%r26 = trunc i544 %r23 to i32
store i32 %r26, i32* %r25
%r27 = lshr i544 %r23, 32
%r29 = getelementptr i32, i32* %r2, i32 4
%r30 = trunc i544 %r27 to i32
store i32 %r30, i32* %r29
%r31 = lshr i544 %r27, 32
%r33 = getelementptr i32, i32* %r2, i32 5
%r34 = trunc i544 %r31 to i32
store i32 %r34, i32* %r33
%r35 = lshr i544 %r31, 32
%r37 = getelementptr i32, i32* %r2, i32 6
%r38 = trunc i544 %r35 to i32
store i32 %r38, i32* %r37
%r39 = lshr i544 %r35, 32
%r41 = getelementptr i32, i32* %r2, i32 7
%r42 = trunc i544 %r39 to i32
store i32 %r42, i32* %r41
%r43 = lshr i544 %r39, 32
%r45 = getelementptr i32, i32* %r2, i32 8
%r46 = trunc i544 %r43 to i32
store i32 %r46, i32* %r45
%r47 = lshr i544 %r43, 32
%r49 = getelementptr i32, i32* %r2, i32 9
%r50 = trunc i544 %r47 to i32
store i32 %r50, i32* %r49
%r51 = lshr i544 %r47, 32
%r53 = getelementptr i32, i32* %r2, i32 10
%r54 = trunc i544 %r51 to i32
store i32 %r54, i32* %r53
%r55 = lshr i544 %r51, 32
%r57 = getelementptr i32, i32* %r2, i32 11
%r58 = trunc i544 %r55 to i32
store i32 %r58, i32* %r57
%r59 = lshr i544 %r55, 32
%r61 = getelementptr i32, i32* %r2, i32 12
%r62 = trunc i544 %r59 to i32
store i32 %r62, i32* %r61
%r63 = lshr i544 %r59, 32
%r65 = getelementptr i32, i32* %r2, i32 13
%r66 = trunc i544 %r63 to i32
store i32 %r66, i32* %r65
%r67 = lshr i544 %r63, 32
%r69 = getelementptr i32, i32* %r2, i32 14
%r70 = trunc i544 %r67 to i32
store i32 %r70, i32* %r69
%r71 = lshr i544 %r67, 32
%r73 = getelementptr i32, i32* %r2, i32 15
%r74 = trunc i544 %r71 to i32
store i32 %r74, i32* %r73
%r75 = lshr i544 %r71, 32
%r77 = getelementptr i32, i32* %r2, i32 16
%r78 = trunc i544 %r75 to i32
store i32 %r78, i32* %r77
%r79 = lshr i544 %r11, 543
%r80 = trunc i544 %r79 to i32
%r82 = and i32 %r80, 1
ret i32 %r82
}
define i32 @mclb_add18(i32* noalias  %r2, i32* noalias  %r3, i32* noalias  %r4)
{
%r6 = bitcast i32* %r3 to i576*
%r7 = load i576, i576* %r6
%r8 = zext i576 %r7 to i608
%r10 = bitcast i32* %r4 to i576*
%r11 = load i576, i576* %r10
%r12 = zext i576 %r11 to i608
%r13 = add i608 %r8, %r12
%r14 = trunc i608 %r13 to i576
%r16 = getelementptr i32, i32* %r2, i32 0
%r17 = trunc i576 %r14 to i32
store i32 %r17, i32* %r16
%r18 = lshr i576 %r14, 32
%r20 = getelementptr i32, i32* %r2, i32 1
%r21 = trunc i576 %r18 to i32
store i32 %r21, i32* %r20
%r22 = lshr i576 %r18, 32
%r24 = getelementptr i32, i32* %r2, i32 2
%r25 = trunc i576 %r22 to i32
store i32 %r25, i32* %r24
%r26 = lshr i576 %r22, 32
%r28 = getelementptr i32, i32* %r2, i32 3
%r29 = trunc i576 %r26 to i32
store i32 %r29, i32* %r28
%r30 = lshr i576 %r26, 32
%r32 = getelementptr i32, i32* %r2, i32 4
%r33 = trunc i576 %r30 to i32
store i32 %r33, i32* %r32
%r34 = lshr i576 %r30, 32
%r36 = getelementptr i32, i32* %r2, i32 5
%r37 = trunc i576 %r34 to i32
store i32 %r37, i32* %r36
%r38 = lshr i576 %r34, 32
%r40 = getelementptr i32, i32* %r2, i32 6
%r41 = trunc i576 %r38 to i32
store i32 %r41, i32* %r40
%r42 = lshr i576 %r38, 32
%r44 = getelementptr i32, i32* %r2, i32 7
%r45 = trunc i576 %r42 to i32
store i32 %r45, i32* %r44
%r46 = lshr i576 %r42, 32
%r48 = getelementptr i32, i32* %r2, i32 8
%r49 = trunc i576 %r46 to i32
store i32 %r49, i32* %r48
%r50 = lshr i576 %r46, 32
%r52 = getelementptr i32, i32* %r2, i32 9
%r53 = trunc i576 %r50 to i32
store i32 %r53, i32* %r52
%r54 = lshr i576 %r50, 32
%r56 = getelementptr i32, i32* %r2, i32 10
%r57 = trunc i576 %r54 to i32
store i32 %r57, i32* %r56
%r58 = lshr i576 %r54, 32
%r60 = getelementptr i32, i32* %r2, i32 11
%r61 = trunc i576 %r58 to i32
store i32 %r61, i32* %r60
%r62 = lshr i576 %r58, 32
%r64 = getelementptr i32, i32* %r2, i32 12
%r65 = trunc i576 %r62 to i32
store i32 %r65, i32* %r64
%r66 = lshr i576 %r62, 32
%r68 = getelementptr i32, i32* %r2, i32 13
%r69 = trunc i576 %r66 to i32
store i32 %r69, i32* %r68
%r70 = lshr i576 %r66, 32
%r72 = getelementptr i32, i32* %r2, i32 14
%r73 = trunc i576 %r70 to i32
store i32 %r73, i32* %r72
%r74 = lshr i576 %r70, 32
%r76 = getelementptr i32, i32* %r2, i32 15
%r77 = trunc i576 %r74 to i32
store i32 %r77, i32* %r76
%r78 = lshr i576 %r74, 32
%r80 = getelementptr i32, i32* %r2, i32 16
%r81 = trunc i576 %r78 to i32
store i32 %r81, i32* %r80
%r82 = lshr i576 %r78, 32
%r84 = getelementptr i32, i32* %r2, i32 17
%r85 = trunc i576 %r82 to i32
store i32 %r85, i32* %r84
%r86 = lshr i608 %r13, 576
%r87 = trunc i608 %r86 to i32
ret i32 %r87
}
define i32 @mclb_sub18(i32* noalias  %r2, i32* noalias  %r3, i32* noalias  %r4)
{
%r6 = bitcast i32* %r3 to i576*
%r7 = load i576, i576* %r6
%r8 = zext i576 %r7 to i608
%r10 = bitcast i32* %r4 to i576*
%r11 = load i576, i576* %r10
%r12 = zext i576 %r11 to i608
%r13 = sub i608 %r8, %r12
%r14 = trunc i608 %r13 to i576
%r16 = getelementptr i32, i32* %r2, i32 0
%r17 = trunc i576 %r14 to i32
store i32 %r17, i32* %r16
%r18 = lshr i576 %r14, 32
%r20 = getelementptr i32, i32* %r2, i32 1
%r21 = trunc i576 %r18 to i32
store i32 %r21, i32* %r20
%r22 = lshr i576 %r18, 32
%r24 = getelementptr i32, i32* %r2, i32 2
%r25 = trunc i576 %r22 to i32
store i32 %r25, i32* %r24
%r26 = lshr i576 %r22, 32
%r28 = getelementptr i32, i32* %r2, i32 3
%r29 = trunc i576 %r26 to i32
store i32 %r29, i32* %r28
%r30 = lshr i576 %r26, 32
%r32 = getelementptr i32, i32* %r2, i32 4
%r33 = trunc i576 %r30 to i32
store i32 %r33, i32* %r32
%r34 = lshr i576 %r30, 32
%r36 = getelementptr i32, i32* %r2, i32 5
%r37 = trunc i576 %r34 to i32
store i32 %r37, i32* %r36
%r38 = lshr i576 %r34, 32
%r40 = getelementptr i32, i32* %r2, i32 6
%r41 = trunc i576 %r38 to i32
store i32 %r41, i32* %r40
%r42 = lshr i576 %r38, 32
%r44 = getelementptr i32, i32* %r2, i32 7
%r45 = trunc i576 %r42 to i32
store i32 %r45, i32* %r44
%r46 = lshr i576 %r42, 32
%r48 = getelementptr i32, i32* %r2, i32 8
%r49 = trunc i576 %r46 to i32
store i32 %r49, i32* %r48
%r50 = lshr i576 %r46, 32
%r52 = getelementptr i32, i32* %r2, i32 9
%r53 = trunc i576 %r50 to i32
store i32 %r53, i32* %r52
%r54 = lshr i576 %r50, 32
%r56 = getelementptr i32, i32* %r2, i32 10
%r57 = trunc i576 %r54 to i32
store i32 %r57, i32* %r56
%r58 = lshr i576 %r54, 32
%r60 = getelementptr i32, i32* %r2, i32 11
%r61 = trunc i576 %r58 to i32
store i32 %r61, i32* %r60
%r62 = lshr i576 %r58, 32
%r64 = getelementptr i32, i32* %r2, i32 12
%r65 = trunc i576 %r62 to i32
store i32 %r65, i32* %r64
%r66 = lshr i576 %r62, 32
%r68 = getelementptr i32, i32* %r2, i32 13
%r69 = trunc i576 %r66 to i32
store i32 %r69, i32* %r68
%r70 = lshr i576 %r66, 32
%r72 = getelementptr i32, i32* %r2, i32 14
%r73 = trunc i576 %r70 to i32
store i32 %r73, i32* %r72
%r74 = lshr i576 %r70, 32
%r76 = getelementptr i32, i32* %r2, i32 15
%r77 = trunc i576 %r74 to i32
store i32 %r77, i32* %r76
%r78 = lshr i576 %r74, 32
%r80 = getelementptr i32, i32* %r2, i32 16
%r81 = trunc i576 %r78 to i32
store i32 %r81, i32* %r80
%r82 = lshr i576 %r78, 32
%r84 = getelementptr i32, i32* %r2, i32 17
%r85 = trunc i576 %r82 to i32
store i32 %r85, i32* %r84
%r86 = lshr i608 %r13, 576
%r87 = trunc i608 %r86 to i32
%r89 = and i32 %r87, 1
ret i32 %r89
}
define void @mclb_addNF18(i32* noalias  %r1, i32* noalias  %r2, i32* noalias  %r3)
{
%r5 = bitcast i32* %r2 to i576*
%r6 = load i576, i576* %r5
%r8 = bitcast i32* %r3 to i576*
%r9 = load i576, i576* %r8
%r10 = add i576 %r6, %r9
%r12 = getelementptr i32, i32* %r1, i32 0
%r13 = trunc i576 %r10 to i32
store i32 %r13, i32* %r12
%r14 = lshr i576 %r10, 32
%r16 = getelementptr i32, i32* %r1, i32 1
%r17 = trunc i576 %r14 to i32
store i32 %r17, i32* %r16
%r18 = lshr i576 %r14, 32
%r20 = getelementptr i32, i32* %r1, i32 2
%r21 = trunc i576 %r18 to i32
store i32 %r21, i32* %r20
%r22 = lshr i576 %r18, 32
%r24 = getelementptr i32, i32* %r1, i32 3
%r25 = trunc i576 %r22 to i32
store i32 %r25, i32* %r24
%r26 = lshr i576 %r22, 32
%r28 = getelementptr i32, i32* %r1, i32 4
%r29 = trunc i576 %r26 to i32
store i32 %r29, i32* %r28
%r30 = lshr i576 %r26, 32
%r32 = getelementptr i32, i32* %r1, i32 5
%r33 = trunc i576 %r30 to i32
store i32 %r33, i32* %r32
%r34 = lshr i576 %r30, 32
%r36 = getelementptr i32, i32* %r1, i32 6
%r37 = trunc i576 %r34 to i32
store i32 %r37, i32* %r36
%r38 = lshr i576 %r34, 32
%r40 = getelementptr i32, i32* %r1, i32 7
%r41 = trunc i576 %r38 to i32
store i32 %r41, i32* %r40
%r42 = lshr i576 %r38, 32
%r44 = getelementptr i32, i32* %r1, i32 8
%r45 = trunc i576 %r42 to i32
store i32 %r45, i32* %r44
%r46 = lshr i576 %r42, 32
%r48 = getelementptr i32, i32* %r1, i32 9
%r49 = trunc i576 %r46 to i32
store i32 %r49, i32* %r48
%r50 = lshr i576 %r46, 32
%r52 = getelementptr i32, i32* %r1, i32 10
%r53 = trunc i576 %r50 to i32
store i32 %r53, i32* %r52
%r54 = lshr i576 %r50, 32
%r56 = getelementptr i32, i32* %r1, i32 11
%r57 = trunc i576 %r54 to i32
store i32 %r57, i32* %r56
%r58 = lshr i576 %r54, 32
%r60 = getelementptr i32, i32* %r1, i32 12
%r61 = trunc i576 %r58 to i32
store i32 %r61, i32* %r60
%r62 = lshr i576 %r58, 32
%r64 = getelementptr i32, i32* %r1, i32 13
%r65 = trunc i576 %r62 to i32
store i32 %r65, i32* %r64
%r66 = lshr i576 %r62, 32
%r68 = getelementptr i32, i32* %r1, i32 14
%r69 = trunc i576 %r66 to i32
store i32 %r69, i32* %r68
%r70 = lshr i576 %r66, 32
%r72 = getelementptr i32, i32* %r1, i32 15
%r73 = trunc i576 %r70 to i32
store i32 %r73, i32* %r72
%r74 = lshr i576 %r70, 32
%r76 = getelementptr i32, i32* %r1, i32 16
%r77 = trunc i576 %r74 to i32
store i32 %r77, i32* %r76
%r78 = lshr i576 %r74, 32
%r80 = getelementptr i32, i32* %r1, i32 17
%r81 = trunc i576 %r78 to i32
store i32 %r81, i32* %r80
ret void
}
define i32 @mclb_subNF18(i32* noalias  %r2, i32* noalias  %r3, i32* noalias  %r4)
{
%r6 = bitcast i32* %r3 to i576*
%r7 = load i576, i576* %r6
%r9 = bitcast i32* %r4 to i576*
%r10 = load i576, i576* %r9
%r11 = sub i576 %r7, %r10
%r13 = getelementptr i32, i32* %r2, i32 0
%r14 = trunc i576 %r11 to i32
store i32 %r14, i32* %r13
%r15 = lshr i576 %r11, 32
%r17 = getelementptr i32, i32* %r2, i32 1
%r18 = trunc i576 %r15 to i32
store i32 %r18, i32* %r17
%r19 = lshr i576 %r15, 32
%r21 = getelementptr i32, i32* %r2, i32 2
%r22 = trunc i576 %r19 to i32
store i32 %r22, i32* %r21
%r23 = lshr i576 %r19, 32
%r25 = getelementptr i32, i32* %r2, i32 3
%r26 = trunc i576 %r23 to i32
store i32 %r26, i32* %r25
%r27 = lshr i576 %r23, 32
%r29 = getelementptr i32, i32* %r2, i32 4
%r30 = trunc i576 %r27 to i32
store i32 %r30, i32* %r29
%r31 = lshr i576 %r27, 32
%r33 = getelementptr i32, i32* %r2, i32 5
%r34 = trunc i576 %r31 to i32
store i32 %r34, i32* %r33
%r35 = lshr i576 %r31, 32
%r37 = getelementptr i32, i32* %r2, i32 6
%r38 = trunc i576 %r35 to i32
store i32 %r38, i32* %r37
%r39 = lshr i576 %r35, 32
%r41 = getelementptr i32, i32* %r2, i32 7
%r42 = trunc i576 %r39 to i32
store i32 %r42, i32* %r41
%r43 = lshr i576 %r39, 32
%r45 = getelementptr i32, i32* %r2, i32 8
%r46 = trunc i576 %r43 to i32
store i32 %r46, i32* %r45
%r47 = lshr i576 %r43, 32
%r49 = getelementptr i32, i32* %r2, i32 9
%r50 = trunc i576 %r47 to i32
store i32 %r50, i32* %r49
%r51 = lshr i576 %r47, 32
%r53 = getelementptr i32, i32* %r2, i32 10
%r54 = trunc i576 %r51 to i32
store i32 %r54, i32* %r53
%r55 = lshr i576 %r51, 32
%r57 = getelementptr i32, i32* %r2, i32 11
%r58 = trunc i576 %r55 to i32
store i32 %r58, i32* %r57
%r59 = lshr i576 %r55, 32
%r61 = getelementptr i32, i32* %r2, i32 12
%r62 = trunc i576 %r59 to i32
store i32 %r62, i32* %r61
%r63 = lshr i576 %r59, 32
%r65 = getelementptr i32, i32* %r2, i32 13
%r66 = trunc i576 %r63 to i32
store i32 %r66, i32* %r65
%r67 = lshr i576 %r63, 32
%r69 = getelementptr i32, i32* %r2, i32 14
%r70 = trunc i576 %r67 to i32
store i32 %r70, i32* %r69
%r71 = lshr i576 %r67, 32
%r73 = getelementptr i32, i32* %r2, i32 15
%r74 = trunc i576 %r71 to i32
store i32 %r74, i32* %r73
%r75 = lshr i576 %r71, 32
%r77 = getelementptr i32, i32* %r2, i32 16
%r78 = trunc i576 %r75 to i32
store i32 %r78, i32* %r77
%r79 = lshr i576 %r75, 32
%r81 = getelementptr i32, i32* %r2, i32 17
%r82 = trunc i576 %r79 to i32
store i32 %r82, i32* %r81
%r83 = lshr i576 %r11, 575
%r84 = trunc i576 %r83 to i32
%r86 = and i32 %r84, 1
ret i32 %r86
}
define i32 @mclb_add19(i32* noalias  %r2, i32* noalias  %r3, i32* noalias  %r4)
{
%r6 = bitcast i32* %r3 to i608*
%r7 = load i608, i608* %r6
%r8 = zext i608 %r7 to i640
%r10 = bitcast i32* %r4 to i608*
%r11 = load i608, i608* %r10
%r12 = zext i608 %r11 to i640
%r13 = add i640 %r8, %r12
%r14 = trunc i640 %r13 to i608
%r16 = getelementptr i32, i32* %r2, i32 0
%r17 = trunc i608 %r14 to i32
store i32 %r17, i32* %r16
%r18 = lshr i608 %r14, 32
%r20 = getelementptr i32, i32* %r2, i32 1
%r21 = trunc i608 %r18 to i32
store i32 %r21, i32* %r20
%r22 = lshr i608 %r18, 32
%r24 = getelementptr i32, i32* %r2, i32 2
%r25 = trunc i608 %r22 to i32
store i32 %r25, i32* %r24
%r26 = lshr i608 %r22, 32
%r28 = getelementptr i32, i32* %r2, i32 3
%r29 = trunc i608 %r26 to i32
store i32 %r29, i32* %r28
%r30 = lshr i608 %r26, 32
%r32 = getelementptr i32, i32* %r2, i32 4
%r33 = trunc i608 %r30 to i32
store i32 %r33, i32* %r32
%r34 = lshr i608 %r30, 32
%r36 = getelementptr i32, i32* %r2, i32 5
%r37 = trunc i608 %r34 to i32
store i32 %r37, i32* %r36
%r38 = lshr i608 %r34, 32
%r40 = getelementptr i32, i32* %r2, i32 6
%r41 = trunc i608 %r38 to i32
store i32 %r41, i32* %r40
%r42 = lshr i608 %r38, 32
%r44 = getelementptr i32, i32* %r2, i32 7
%r45 = trunc i608 %r42 to i32
store i32 %r45, i32* %r44
%r46 = lshr i608 %r42, 32
%r48 = getelementptr i32, i32* %r2, i32 8
%r49 = trunc i608 %r46 to i32
store i32 %r49, i32* %r48
%r50 = lshr i608 %r46, 32
%r52 = getelementptr i32, i32* %r2, i32 9
%r53 = trunc i608 %r50 to i32
store i32 %r53, i32* %r52
%r54 = lshr i608 %r50, 32
%r56 = getelementptr i32, i32* %r2, i32 10
%r57 = trunc i608 %r54 to i32
store i32 %r57, i32* %r56
%r58 = lshr i608 %r54, 32
%r60 = getelementptr i32, i32* %r2, i32 11
%r61 = trunc i608 %r58 to i32
store i32 %r61, i32* %r60
%r62 = lshr i608 %r58, 32
%r64 = getelementptr i32, i32* %r2, i32 12
%r65 = trunc i608 %r62 to i32
store i32 %r65, i32* %r64
%r66 = lshr i608 %r62, 32
%r68 = getelementptr i32, i32* %r2, i32 13
%r69 = trunc i608 %r66 to i32
store i32 %r69, i32* %r68
%r70 = lshr i608 %r66, 32
%r72 = getelementptr i32, i32* %r2, i32 14
%r73 = trunc i608 %r70 to i32
store i32 %r73, i32* %r72
%r74 = lshr i608 %r70, 32
%r76 = getelementptr i32, i32* %r2, i32 15
%r77 = trunc i608 %r74 to i32
store i32 %r77, i32* %r76
%r78 = lshr i608 %r74, 32
%r80 = getelementptr i32, i32* %r2, i32 16
%r81 = trunc i608 %r78 to i32
store i32 %r81, i32* %r80
%r82 = lshr i608 %r78, 32
%r84 = getelementptr i32, i32* %r2, i32 17
%r85 = trunc i608 %r82 to i32
store i32 %r85, i32* %r84
%r86 = lshr i608 %r82, 32
%r88 = getelementptr i32, i32* %r2, i32 18
%r89 = trunc i608 %r86 to i32
store i32 %r89, i32* %r88
%r90 = lshr i640 %r13, 608
%r91 = trunc i640 %r90 to i32
ret i32 %r91
}
define i32 @mclb_sub19(i32* noalias  %r2, i32* noalias  %r3, i32* noalias  %r4)
{
%r6 = bitcast i32* %r3 to i608*
%r7 = load i608, i608* %r6
%r8 = zext i608 %r7 to i640
%r10 = bitcast i32* %r4 to i608*
%r11 = load i608, i608* %r10
%r12 = zext i608 %r11 to i640
%r13 = sub i640 %r8, %r12
%r14 = trunc i640 %r13 to i608
%r16 = getelementptr i32, i32* %r2, i32 0
%r17 = trunc i608 %r14 to i32
store i32 %r17, i32* %r16
%r18 = lshr i608 %r14, 32
%r20 = getelementptr i32, i32* %r2, i32 1
%r21 = trunc i608 %r18 to i32
store i32 %r21, i32* %r20
%r22 = lshr i608 %r18, 32
%r24 = getelementptr i32, i32* %r2, i32 2
%r25 = trunc i608 %r22 to i32
store i32 %r25, i32* %r24
%r26 = lshr i608 %r22, 32
%r28 = getelementptr i32, i32* %r2, i32 3
%r29 = trunc i608 %r26 to i32
store i32 %r29, i32* %r28
%r30 = lshr i608 %r26, 32
%r32 = getelementptr i32, i32* %r2, i32 4
%r33 = trunc i608 %r30 to i32
store i32 %r33, i32* %r32
%r34 = lshr i608 %r30, 32
%r36 = getelementptr i32, i32* %r2, i32 5
%r37 = trunc i608 %r34 to i32
store i32 %r37, i32* %r36
%r38 = lshr i608 %r34, 32
%r40 = getelementptr i32, i32* %r2, i32 6
%r41 = trunc i608 %r38 to i32
store i32 %r41, i32* %r40
%r42 = lshr i608 %r38, 32
%r44 = getelementptr i32, i32* %r2, i32 7
%r45 = trunc i608 %r42 to i32
store i32 %r45, i32* %r44
%r46 = lshr i608 %r42, 32
%r48 = getelementptr i32, i32* %r2, i32 8
%r49 = trunc i608 %r46 to i32
store i32 %r49, i32* %r48
%r50 = lshr i608 %r46, 32
%r52 = getelementptr i32, i32* %r2, i32 9
%r53 = trunc i608 %r50 to i32
store i32 %r53, i32* %r52
%r54 = lshr i608 %r50, 32
%r56 = getelementptr i32, i32* %r2, i32 10
%r57 = trunc i608 %r54 to i32
store i32 %r57, i32* %r56
%r58 = lshr i608 %r54, 32
%r60 = getelementptr i32, i32* %r2, i32 11
%r61 = trunc i608 %r58 to i32
store i32 %r61, i32* %r60
%r62 = lshr i608 %r58, 32
%r64 = getelementptr i32, i32* %r2, i32 12
%r65 = trunc i608 %r62 to i32
store i32 %r65, i32* %r64
%r66 = lshr i608 %r62, 32
%r68 = getelementptr i32, i32* %r2, i32 13
%r69 = trunc i608 %r66 to i32
store i32 %r69, i32* %r68
%r70 = lshr i608 %r66, 32
%r72 = getelementptr i32, i32* %r2, i32 14
%r73 = trunc i608 %r70 to i32
store i32 %r73, i32* %r72
%r74 = lshr i608 %r70, 32
%r76 = getelementptr i32, i32* %r2, i32 15
%r77 = trunc i608 %r74 to i32
store i32 %r77, i32* %r76
%r78 = lshr i608 %r74, 32
%r80 = getelementptr i32, i32* %r2, i32 16
%r81 = trunc i608 %r78 to i32
store i32 %r81, i32* %r80
%r82 = lshr i608 %r78, 32
%r84 = getelementptr i32, i32* %r2, i32 17
%r85 = trunc i608 %r82 to i32
store i32 %r85, i32* %r84
%r86 = lshr i608 %r82, 32
%r88 = getelementptr i32, i32* %r2, i32 18
%r89 = trunc i608 %r86 to i32
store i32 %r89, i32* %r88
%r90 = lshr i640 %r13, 608
%r91 = trunc i640 %r90 to i32
%r93 = and i32 %r91, 1
ret i32 %r93
}
define void @mclb_addNF19(i32* noalias  %r1, i32* noalias  %r2, i32* noalias  %r3)
{
%r5 = bitcast i32* %r2 to i608*
%r6 = load i608, i608* %r5
%r8 = bitcast i32* %r3 to i608*
%r9 = load i608, i608* %r8
%r10 = add i608 %r6, %r9
%r12 = getelementptr i32, i32* %r1, i32 0
%r13 = trunc i608 %r10 to i32
store i32 %r13, i32* %r12
%r14 = lshr i608 %r10, 32
%r16 = getelementptr i32, i32* %r1, i32 1
%r17 = trunc i608 %r14 to i32
store i32 %r17, i32* %r16
%r18 = lshr i608 %r14, 32
%r20 = getelementptr i32, i32* %r1, i32 2
%r21 = trunc i608 %r18 to i32
store i32 %r21, i32* %r20
%r22 = lshr i608 %r18, 32
%r24 = getelementptr i32, i32* %r1, i32 3
%r25 = trunc i608 %r22 to i32
store i32 %r25, i32* %r24
%r26 = lshr i608 %r22, 32
%r28 = getelementptr i32, i32* %r1, i32 4
%r29 = trunc i608 %r26 to i32
store i32 %r29, i32* %r28
%r30 = lshr i608 %r26, 32
%r32 = getelementptr i32, i32* %r1, i32 5
%r33 = trunc i608 %r30 to i32
store i32 %r33, i32* %r32
%r34 = lshr i608 %r30, 32
%r36 = getelementptr i32, i32* %r1, i32 6
%r37 = trunc i608 %r34 to i32
store i32 %r37, i32* %r36
%r38 = lshr i608 %r34, 32
%r40 = getelementptr i32, i32* %r1, i32 7
%r41 = trunc i608 %r38 to i32
store i32 %r41, i32* %r40
%r42 = lshr i608 %r38, 32
%r44 = getelementptr i32, i32* %r1, i32 8
%r45 = trunc i608 %r42 to i32
store i32 %r45, i32* %r44
%r46 = lshr i608 %r42, 32
%r48 = getelementptr i32, i32* %r1, i32 9
%r49 = trunc i608 %r46 to i32
store i32 %r49, i32* %r48
%r50 = lshr i608 %r46, 32
%r52 = getelementptr i32, i32* %r1, i32 10
%r53 = trunc i608 %r50 to i32
store i32 %r53, i32* %r52
%r54 = lshr i608 %r50, 32
%r56 = getelementptr i32, i32* %r1, i32 11
%r57 = trunc i608 %r54 to i32
store i32 %r57, i32* %r56
%r58 = lshr i608 %r54, 32
%r60 = getelementptr i32, i32* %r1, i32 12
%r61 = trunc i608 %r58 to i32
store i32 %r61, i32* %r60
%r62 = lshr i608 %r58, 32
%r64 = getelementptr i32, i32* %r1, i32 13
%r65 = trunc i608 %r62 to i32
store i32 %r65, i32* %r64
%r66 = lshr i608 %r62, 32
%r68 = getelementptr i32, i32* %r1, i32 14
%r69 = trunc i608 %r66 to i32
store i32 %r69, i32* %r68
%r70 = lshr i608 %r66, 32
%r72 = getelementptr i32, i32* %r1, i32 15
%r73 = trunc i608 %r70 to i32
store i32 %r73, i32* %r72
%r74 = lshr i608 %r70, 32
%r76 = getelementptr i32, i32* %r1, i32 16
%r77 = trunc i608 %r74 to i32
store i32 %r77, i32* %r76
%r78 = lshr i608 %r74, 32
%r80 = getelementptr i32, i32* %r1, i32 17
%r81 = trunc i608 %r78 to i32
store i32 %r81, i32* %r80
%r82 = lshr i608 %r78, 32
%r84 = getelementptr i32, i32* %r1, i32 18
%r85 = trunc i608 %r82 to i32
store i32 %r85, i32* %r84
ret void
}
define i32 @mclb_subNF19(i32* noalias  %r2, i32* noalias  %r3, i32* noalias  %r4)
{
%r6 = bitcast i32* %r3 to i608*
%r7 = load i608, i608* %r6
%r9 = bitcast i32* %r4 to i608*
%r10 = load i608, i608* %r9
%r11 = sub i608 %r7, %r10
%r13 = getelementptr i32, i32* %r2, i32 0
%r14 = trunc i608 %r11 to i32
store i32 %r14, i32* %r13
%r15 = lshr i608 %r11, 32
%r17 = getelementptr i32, i32* %r2, i32 1
%r18 = trunc i608 %r15 to i32
store i32 %r18, i32* %r17
%r19 = lshr i608 %r15, 32
%r21 = getelementptr i32, i32* %r2, i32 2
%r22 = trunc i608 %r19 to i32
store i32 %r22, i32* %r21
%r23 = lshr i608 %r19, 32
%r25 = getelementptr i32, i32* %r2, i32 3
%r26 = trunc i608 %r23 to i32
store i32 %r26, i32* %r25
%r27 = lshr i608 %r23, 32
%r29 = getelementptr i32, i32* %r2, i32 4
%r30 = trunc i608 %r27 to i32
store i32 %r30, i32* %r29
%r31 = lshr i608 %r27, 32
%r33 = getelementptr i32, i32* %r2, i32 5
%r34 = trunc i608 %r31 to i32
store i32 %r34, i32* %r33
%r35 = lshr i608 %r31, 32
%r37 = getelementptr i32, i32* %r2, i32 6
%r38 = trunc i608 %r35 to i32
store i32 %r38, i32* %r37
%r39 = lshr i608 %r35, 32
%r41 = getelementptr i32, i32* %r2, i32 7
%r42 = trunc i608 %r39 to i32
store i32 %r42, i32* %r41
%r43 = lshr i608 %r39, 32
%r45 = getelementptr i32, i32* %r2, i32 8
%r46 = trunc i608 %r43 to i32
store i32 %r46, i32* %r45
%r47 = lshr i608 %r43, 32
%r49 = getelementptr i32, i32* %r2, i32 9
%r50 = trunc i608 %r47 to i32
store i32 %r50, i32* %r49
%r51 = lshr i608 %r47, 32
%r53 = getelementptr i32, i32* %r2, i32 10
%r54 = trunc i608 %r51 to i32
store i32 %r54, i32* %r53
%r55 = lshr i608 %r51, 32
%r57 = getelementptr i32, i32* %r2, i32 11
%r58 = trunc i608 %r55 to i32
store i32 %r58, i32* %r57
%r59 = lshr i608 %r55, 32
%r61 = getelementptr i32, i32* %r2, i32 12
%r62 = trunc i608 %r59 to i32
store i32 %r62, i32* %r61
%r63 = lshr i608 %r59, 32
%r65 = getelementptr i32, i32* %r2, i32 13
%r66 = trunc i608 %r63 to i32
store i32 %r66, i32* %r65
%r67 = lshr i608 %r63, 32
%r69 = getelementptr i32, i32* %r2, i32 14
%r70 = trunc i608 %r67 to i32
store i32 %r70, i32* %r69
%r71 = lshr i608 %r67, 32
%r73 = getelementptr i32, i32* %r2, i32 15
%r74 = trunc i608 %r71 to i32
store i32 %r74, i32* %r73
%r75 = lshr i608 %r71, 32
%r77 = getelementptr i32, i32* %r2, i32 16
%r78 = trunc i608 %r75 to i32
store i32 %r78, i32* %r77
%r79 = lshr i608 %r75, 32
%r81 = getelementptr i32, i32* %r2, i32 17
%r82 = trunc i608 %r79 to i32
store i32 %r82, i32* %r81
%r83 = lshr i608 %r79, 32
%r85 = getelementptr i32, i32* %r2, i32 18
%r86 = trunc i608 %r83 to i32
store i32 %r86, i32* %r85
%r87 = lshr i608 %r11, 607
%r88 = trunc i608 %r87 to i32
%r90 = and i32 %r88, 1
ret i32 %r90
}
define i32 @mclb_add20(i32* noalias  %r2, i32* noalias  %r3, i32* noalias  %r4)
{
%r6 = bitcast i32* %r3 to i640*
%r7 = load i640, i640* %r6
%r8 = zext i640 %r7 to i672
%r10 = bitcast i32* %r4 to i640*
%r11 = load i640, i640* %r10
%r12 = zext i640 %r11 to i672
%r13 = add i672 %r8, %r12
%r14 = trunc i672 %r13 to i640
%r16 = getelementptr i32, i32* %r2, i32 0
%r17 = trunc i640 %r14 to i32
store i32 %r17, i32* %r16
%r18 = lshr i640 %r14, 32
%r20 = getelementptr i32, i32* %r2, i32 1
%r21 = trunc i640 %r18 to i32
store i32 %r21, i32* %r20
%r22 = lshr i640 %r18, 32
%r24 = getelementptr i32, i32* %r2, i32 2
%r25 = trunc i640 %r22 to i32
store i32 %r25, i32* %r24
%r26 = lshr i640 %r22, 32
%r28 = getelementptr i32, i32* %r2, i32 3
%r29 = trunc i640 %r26 to i32
store i32 %r29, i32* %r28
%r30 = lshr i640 %r26, 32
%r32 = getelementptr i32, i32* %r2, i32 4
%r33 = trunc i640 %r30 to i32
store i32 %r33, i32* %r32
%r34 = lshr i640 %r30, 32
%r36 = getelementptr i32, i32* %r2, i32 5
%r37 = trunc i640 %r34 to i32
store i32 %r37, i32* %r36
%r38 = lshr i640 %r34, 32
%r40 = getelementptr i32, i32* %r2, i32 6
%r41 = trunc i640 %r38 to i32
store i32 %r41, i32* %r40
%r42 = lshr i640 %r38, 32
%r44 = getelementptr i32, i32* %r2, i32 7
%r45 = trunc i640 %r42 to i32
store i32 %r45, i32* %r44
%r46 = lshr i640 %r42, 32
%r48 = getelementptr i32, i32* %r2, i32 8
%r49 = trunc i640 %r46 to i32
store i32 %r49, i32* %r48
%r50 = lshr i640 %r46, 32
%r52 = getelementptr i32, i32* %r2, i32 9
%r53 = trunc i640 %r50 to i32
store i32 %r53, i32* %r52
%r54 = lshr i640 %r50, 32
%r56 = getelementptr i32, i32* %r2, i32 10
%r57 = trunc i640 %r54 to i32
store i32 %r57, i32* %r56
%r58 = lshr i640 %r54, 32
%r60 = getelementptr i32, i32* %r2, i32 11
%r61 = trunc i640 %r58 to i32
store i32 %r61, i32* %r60
%r62 = lshr i640 %r58, 32
%r64 = getelementptr i32, i32* %r2, i32 12
%r65 = trunc i640 %r62 to i32
store i32 %r65, i32* %r64
%r66 = lshr i640 %r62, 32
%r68 = getelementptr i32, i32* %r2, i32 13
%r69 = trunc i640 %r66 to i32
store i32 %r69, i32* %r68
%r70 = lshr i640 %r66, 32
%r72 = getelementptr i32, i32* %r2, i32 14
%r73 = trunc i640 %r70 to i32
store i32 %r73, i32* %r72
%r74 = lshr i640 %r70, 32
%r76 = getelementptr i32, i32* %r2, i32 15
%r77 = trunc i640 %r74 to i32
store i32 %r77, i32* %r76
%r78 = lshr i640 %r74, 32
%r80 = getelementptr i32, i32* %r2, i32 16
%r81 = trunc i640 %r78 to i32
store i32 %r81, i32* %r80
%r82 = lshr i640 %r78, 32
%r84 = getelementptr i32, i32* %r2, i32 17
%r85 = trunc i640 %r82 to i32
store i32 %r85, i32* %r84
%r86 = lshr i640 %r82, 32
%r88 = getelementptr i32, i32* %r2, i32 18
%r89 = trunc i640 %r86 to i32
store i32 %r89, i32* %r88
%r90 = lshr i640 %r86, 32
%r92 = getelementptr i32, i32* %r2, i32 19
%r93 = trunc i640 %r90 to i32
store i32 %r93, i32* %r92
%r94 = lshr i672 %r13, 640
%r95 = trunc i672 %r94 to i32
ret i32 %r95
}
define i32 @mclb_sub20(i32* noalias  %r2, i32* noalias  %r3, i32* noalias  %r4)
{
%r6 = bitcast i32* %r3 to i640*
%r7 = load i640, i640* %r6
%r8 = zext i640 %r7 to i672
%r10 = bitcast i32* %r4 to i640*
%r11 = load i640, i640* %r10
%r12 = zext i640 %r11 to i672
%r13 = sub i672 %r8, %r12
%r14 = trunc i672 %r13 to i640
%r16 = getelementptr i32, i32* %r2, i32 0
%r17 = trunc i640 %r14 to i32
store i32 %r17, i32* %r16
%r18 = lshr i640 %r14, 32
%r20 = getelementptr i32, i32* %r2, i32 1
%r21 = trunc i640 %r18 to i32
store i32 %r21, i32* %r20
%r22 = lshr i640 %r18, 32
%r24 = getelementptr i32, i32* %r2, i32 2
%r25 = trunc i640 %r22 to i32
store i32 %r25, i32* %r24
%r26 = lshr i640 %r22, 32
%r28 = getelementptr i32, i32* %r2, i32 3
%r29 = trunc i640 %r26 to i32
store i32 %r29, i32* %r28
%r30 = lshr i640 %r26, 32
%r32 = getelementptr i32, i32* %r2, i32 4
%r33 = trunc i640 %r30 to i32
store i32 %r33, i32* %r32
%r34 = lshr i640 %r30, 32
%r36 = getelementptr i32, i32* %r2, i32 5
%r37 = trunc i640 %r34 to i32
store i32 %r37, i32* %r36
%r38 = lshr i640 %r34, 32
%r40 = getelementptr i32, i32* %r2, i32 6
%r41 = trunc i640 %r38 to i32
store i32 %r41, i32* %r40
%r42 = lshr i640 %r38, 32
%r44 = getelementptr i32, i32* %r2, i32 7
%r45 = trunc i640 %r42 to i32
store i32 %r45, i32* %r44
%r46 = lshr i640 %r42, 32
%r48 = getelementptr i32, i32* %r2, i32 8
%r49 = trunc i640 %r46 to i32
store i32 %r49, i32* %r48
%r50 = lshr i640 %r46, 32
%r52 = getelementptr i32, i32* %r2, i32 9
%r53 = trunc i640 %r50 to i32
store i32 %r53, i32* %r52
%r54 = lshr i640 %r50, 32
%r56 = getelementptr i32, i32* %r2, i32 10
%r57 = trunc i640 %r54 to i32
store i32 %r57, i32* %r56
%r58 = lshr i640 %r54, 32
%r60 = getelementptr i32, i32* %r2, i32 11
%r61 = trunc i640 %r58 to i32
store i32 %r61, i32* %r60
%r62 = lshr i640 %r58, 32
%r64 = getelementptr i32, i32* %r2, i32 12
%r65 = trunc i640 %r62 to i32
store i32 %r65, i32* %r64
%r66 = lshr i640 %r62, 32
%r68 = getelementptr i32, i32* %r2, i32 13
%r69 = trunc i640 %r66 to i32
store i32 %r69, i32* %r68
%r70 = lshr i640 %r66, 32
%r72 = getelementptr i32, i32* %r2, i32 14
%r73 = trunc i640 %r70 to i32
store i32 %r73, i32* %r72
%r74 = lshr i640 %r70, 32
%r76 = getelementptr i32, i32* %r2, i32 15
%r77 = trunc i640 %r74 to i32
store i32 %r77, i32* %r76
%r78 = lshr i640 %r74, 32
%r80 = getelementptr i32, i32* %r2, i32 16
%r81 = trunc i640 %r78 to i32
store i32 %r81, i32* %r80
%r82 = lshr i640 %r78, 32
%r84 = getelementptr i32, i32* %r2, i32 17
%r85 = trunc i640 %r82 to i32
store i32 %r85, i32* %r84
%r86 = lshr i640 %r82, 32
%r88 = getelementptr i32, i32* %r2, i32 18
%r89 = trunc i640 %r86 to i32
store i32 %r89, i32* %r88
%r90 = lshr i640 %r86, 32
%r92 = getelementptr i32, i32* %r2, i32 19
%r93 = trunc i640 %r90 to i32
store i32 %r93, i32* %r92
%r94 = lshr i672 %r13, 640
%r95 = trunc i672 %r94 to i32
%r97 = and i32 %r95, 1
ret i32 %r97
}
define void @mclb_addNF20(i32* noalias  %r1, i32* noalias  %r2, i32* noalias  %r3)
{
%r5 = bitcast i32* %r2 to i640*
%r6 = load i640, i640* %r5
%r8 = bitcast i32* %r3 to i640*
%r9 = load i640, i640* %r8
%r10 = add i640 %r6, %r9
%r12 = getelementptr i32, i32* %r1, i32 0
%r13 = trunc i640 %r10 to i32
store i32 %r13, i32* %r12
%r14 = lshr i640 %r10, 32
%r16 = getelementptr i32, i32* %r1, i32 1
%r17 = trunc i640 %r14 to i32
store i32 %r17, i32* %r16
%r18 = lshr i640 %r14, 32
%r20 = getelementptr i32, i32* %r1, i32 2
%r21 = trunc i640 %r18 to i32
store i32 %r21, i32* %r20
%r22 = lshr i640 %r18, 32
%r24 = getelementptr i32, i32* %r1, i32 3
%r25 = trunc i640 %r22 to i32
store i32 %r25, i32* %r24
%r26 = lshr i640 %r22, 32
%r28 = getelementptr i32, i32* %r1, i32 4
%r29 = trunc i640 %r26 to i32
store i32 %r29, i32* %r28
%r30 = lshr i640 %r26, 32
%r32 = getelementptr i32, i32* %r1, i32 5
%r33 = trunc i640 %r30 to i32
store i32 %r33, i32* %r32
%r34 = lshr i640 %r30, 32
%r36 = getelementptr i32, i32* %r1, i32 6
%r37 = trunc i640 %r34 to i32
store i32 %r37, i32* %r36
%r38 = lshr i640 %r34, 32
%r40 = getelementptr i32, i32* %r1, i32 7
%r41 = trunc i640 %r38 to i32
store i32 %r41, i32* %r40
%r42 = lshr i640 %r38, 32
%r44 = getelementptr i32, i32* %r1, i32 8
%r45 = trunc i640 %r42 to i32
store i32 %r45, i32* %r44
%r46 = lshr i640 %r42, 32
%r48 = getelementptr i32, i32* %r1, i32 9
%r49 = trunc i640 %r46 to i32
store i32 %r49, i32* %r48
%r50 = lshr i640 %r46, 32
%r52 = getelementptr i32, i32* %r1, i32 10
%r53 = trunc i640 %r50 to i32
store i32 %r53, i32* %r52
%r54 = lshr i640 %r50, 32
%r56 = getelementptr i32, i32* %r1, i32 11
%r57 = trunc i640 %r54 to i32
store i32 %r57, i32* %r56
%r58 = lshr i640 %r54, 32
%r60 = getelementptr i32, i32* %r1, i32 12
%r61 = trunc i640 %r58 to i32
store i32 %r61, i32* %r60
%r62 = lshr i640 %r58, 32
%r64 = getelementptr i32, i32* %r1, i32 13
%r65 = trunc i640 %r62 to i32
store i32 %r65, i32* %r64
%r66 = lshr i640 %r62, 32
%r68 = getelementptr i32, i32* %r1, i32 14
%r69 = trunc i640 %r66 to i32
store i32 %r69, i32* %r68
%r70 = lshr i640 %r66, 32
%r72 = getelementptr i32, i32* %r1, i32 15
%r73 = trunc i640 %r70 to i32
store i32 %r73, i32* %r72
%r74 = lshr i640 %r70, 32
%r76 = getelementptr i32, i32* %r1, i32 16
%r77 = trunc i640 %r74 to i32
store i32 %r77, i32* %r76
%r78 = lshr i640 %r74, 32
%r80 = getelementptr i32, i32* %r1, i32 17
%r81 = trunc i640 %r78 to i32
store i32 %r81, i32* %r80
%r82 = lshr i640 %r78, 32
%r84 = getelementptr i32, i32* %r1, i32 18
%r85 = trunc i640 %r82 to i32
store i32 %r85, i32* %r84
%r86 = lshr i640 %r82, 32
%r88 = getelementptr i32, i32* %r1, i32 19
%r89 = trunc i640 %r86 to i32
store i32 %r89, i32* %r88
ret void
}
define i32 @mclb_subNF20(i32* noalias  %r2, i32* noalias  %r3, i32* noalias  %r4)
{
%r6 = bitcast i32* %r3 to i640*
%r7 = load i640, i640* %r6
%r9 = bitcast i32* %r4 to i640*
%r10 = load i640, i640* %r9
%r11 = sub i640 %r7, %r10
%r13 = getelementptr i32, i32* %r2, i32 0
%r14 = trunc i640 %r11 to i32
store i32 %r14, i32* %r13
%r15 = lshr i640 %r11, 32
%r17 = getelementptr i32, i32* %r2, i32 1
%r18 = trunc i640 %r15 to i32
store i32 %r18, i32* %r17
%r19 = lshr i640 %r15, 32
%r21 = getelementptr i32, i32* %r2, i32 2
%r22 = trunc i640 %r19 to i32
store i32 %r22, i32* %r21
%r23 = lshr i640 %r19, 32
%r25 = getelementptr i32, i32* %r2, i32 3
%r26 = trunc i640 %r23 to i32
store i32 %r26, i32* %r25
%r27 = lshr i640 %r23, 32
%r29 = getelementptr i32, i32* %r2, i32 4
%r30 = trunc i640 %r27 to i32
store i32 %r30, i32* %r29
%r31 = lshr i640 %r27, 32
%r33 = getelementptr i32, i32* %r2, i32 5
%r34 = trunc i640 %r31 to i32
store i32 %r34, i32* %r33
%r35 = lshr i640 %r31, 32
%r37 = getelementptr i32, i32* %r2, i32 6
%r38 = trunc i640 %r35 to i32
store i32 %r38, i32* %r37
%r39 = lshr i640 %r35, 32
%r41 = getelementptr i32, i32* %r2, i32 7
%r42 = trunc i640 %r39 to i32
store i32 %r42, i32* %r41
%r43 = lshr i640 %r39, 32
%r45 = getelementptr i32, i32* %r2, i32 8
%r46 = trunc i640 %r43 to i32
store i32 %r46, i32* %r45
%r47 = lshr i640 %r43, 32
%r49 = getelementptr i32, i32* %r2, i32 9
%r50 = trunc i640 %r47 to i32
store i32 %r50, i32* %r49
%r51 = lshr i640 %r47, 32
%r53 = getelementptr i32, i32* %r2, i32 10
%r54 = trunc i640 %r51 to i32
store i32 %r54, i32* %r53
%r55 = lshr i640 %r51, 32
%r57 = getelementptr i32, i32* %r2, i32 11
%r58 = trunc i640 %r55 to i32
store i32 %r58, i32* %r57
%r59 = lshr i640 %r55, 32
%r61 = getelementptr i32, i32* %r2, i32 12
%r62 = trunc i640 %r59 to i32
store i32 %r62, i32* %r61
%r63 = lshr i640 %r59, 32
%r65 = getelementptr i32, i32* %r2, i32 13
%r66 = trunc i640 %r63 to i32
store i32 %r66, i32* %r65
%r67 = lshr i640 %r63, 32
%r69 = getelementptr i32, i32* %r2, i32 14
%r70 = trunc i640 %r67 to i32
store i32 %r70, i32* %r69
%r71 = lshr i640 %r67, 32
%r73 = getelementptr i32, i32* %r2, i32 15
%r74 = trunc i640 %r71 to i32
store i32 %r74, i32* %r73
%r75 = lshr i640 %r71, 32
%r77 = getelementptr i32, i32* %r2, i32 16
%r78 = trunc i640 %r75 to i32
store i32 %r78, i32* %r77
%r79 = lshr i640 %r75, 32
%r81 = getelementptr i32, i32* %r2, i32 17
%r82 = trunc i640 %r79 to i32
store i32 %r82, i32* %r81
%r83 = lshr i640 %r79, 32
%r85 = getelementptr i32, i32* %r2, i32 18
%r86 = trunc i640 %r83 to i32
store i32 %r86, i32* %r85
%r87 = lshr i640 %r83, 32
%r89 = getelementptr i32, i32* %r2, i32 19
%r90 = trunc i640 %r87 to i32
store i32 %r90, i32* %r89
%r91 = lshr i640 %r11, 639
%r92 = trunc i640 %r91 to i32
%r94 = and i32 %r92, 1
ret i32 %r94
}
define i32 @mclb_add21(i32* noalias  %r2, i32* noalias  %r3, i32* noalias  %r4)
{
%r6 = bitcast i32* %r3 to i672*
%r7 = load i672, i672* %r6
%r8 = zext i672 %r7 to i704
%r10 = bitcast i32* %r4 to i672*
%r11 = load i672, i672* %r10
%r12 = zext i672 %r11 to i704
%r13 = add i704 %r8, %r12
%r14 = trunc i704 %r13 to i672
%r16 = getelementptr i32, i32* %r2, i32 0
%r17 = trunc i672 %r14 to i32
store i32 %r17, i32* %r16
%r18 = lshr i672 %r14, 32
%r20 = getelementptr i32, i32* %r2, i32 1
%r21 = trunc i672 %r18 to i32
store i32 %r21, i32* %r20
%r22 = lshr i672 %r18, 32
%r24 = getelementptr i32, i32* %r2, i32 2
%r25 = trunc i672 %r22 to i32
store i32 %r25, i32* %r24
%r26 = lshr i672 %r22, 32
%r28 = getelementptr i32, i32* %r2, i32 3
%r29 = trunc i672 %r26 to i32
store i32 %r29, i32* %r28
%r30 = lshr i672 %r26, 32
%r32 = getelementptr i32, i32* %r2, i32 4
%r33 = trunc i672 %r30 to i32
store i32 %r33, i32* %r32
%r34 = lshr i672 %r30, 32
%r36 = getelementptr i32, i32* %r2, i32 5
%r37 = trunc i672 %r34 to i32
store i32 %r37, i32* %r36
%r38 = lshr i672 %r34, 32
%r40 = getelementptr i32, i32* %r2, i32 6
%r41 = trunc i672 %r38 to i32
store i32 %r41, i32* %r40
%r42 = lshr i672 %r38, 32
%r44 = getelementptr i32, i32* %r2, i32 7
%r45 = trunc i672 %r42 to i32
store i32 %r45, i32* %r44
%r46 = lshr i672 %r42, 32
%r48 = getelementptr i32, i32* %r2, i32 8
%r49 = trunc i672 %r46 to i32
store i32 %r49, i32* %r48
%r50 = lshr i672 %r46, 32
%r52 = getelementptr i32, i32* %r2, i32 9
%r53 = trunc i672 %r50 to i32
store i32 %r53, i32* %r52
%r54 = lshr i672 %r50, 32
%r56 = getelementptr i32, i32* %r2, i32 10
%r57 = trunc i672 %r54 to i32
store i32 %r57, i32* %r56
%r58 = lshr i672 %r54, 32
%r60 = getelementptr i32, i32* %r2, i32 11
%r61 = trunc i672 %r58 to i32
store i32 %r61, i32* %r60
%r62 = lshr i672 %r58, 32
%r64 = getelementptr i32, i32* %r2, i32 12
%r65 = trunc i672 %r62 to i32
store i32 %r65, i32* %r64
%r66 = lshr i672 %r62, 32
%r68 = getelementptr i32, i32* %r2, i32 13
%r69 = trunc i672 %r66 to i32
store i32 %r69, i32* %r68
%r70 = lshr i672 %r66, 32
%r72 = getelementptr i32, i32* %r2, i32 14
%r73 = trunc i672 %r70 to i32
store i32 %r73, i32* %r72
%r74 = lshr i672 %r70, 32
%r76 = getelementptr i32, i32* %r2, i32 15
%r77 = trunc i672 %r74 to i32
store i32 %r77, i32* %r76
%r78 = lshr i672 %r74, 32
%r80 = getelementptr i32, i32* %r2, i32 16
%r81 = trunc i672 %r78 to i32
store i32 %r81, i32* %r80
%r82 = lshr i672 %r78, 32
%r84 = getelementptr i32, i32* %r2, i32 17
%r85 = trunc i672 %r82 to i32
store i32 %r85, i32* %r84
%r86 = lshr i672 %r82, 32
%r88 = getelementptr i32, i32* %r2, i32 18
%r89 = trunc i672 %r86 to i32
store i32 %r89, i32* %r88
%r90 = lshr i672 %r86, 32
%r92 = getelementptr i32, i32* %r2, i32 19
%r93 = trunc i672 %r90 to i32
store i32 %r93, i32* %r92
%r94 = lshr i672 %r90, 32
%r96 = getelementptr i32, i32* %r2, i32 20
%r97 = trunc i672 %r94 to i32
store i32 %r97, i32* %r96
%r98 = lshr i704 %r13, 672
%r99 = trunc i704 %r98 to i32
ret i32 %r99
}
define i32 @mclb_sub21(i32* noalias  %r2, i32* noalias  %r3, i32* noalias  %r4)
{
%r6 = bitcast i32* %r3 to i672*
%r7 = load i672, i672* %r6
%r8 = zext i672 %r7 to i704
%r10 = bitcast i32* %r4 to i672*
%r11 = load i672, i672* %r10
%r12 = zext i672 %r11 to i704
%r13 = sub i704 %r8, %r12
%r14 = trunc i704 %r13 to i672
%r16 = getelementptr i32, i32* %r2, i32 0
%r17 = trunc i672 %r14 to i32
store i32 %r17, i32* %r16
%r18 = lshr i672 %r14, 32
%r20 = getelementptr i32, i32* %r2, i32 1
%r21 = trunc i672 %r18 to i32
store i32 %r21, i32* %r20
%r22 = lshr i672 %r18, 32
%r24 = getelementptr i32, i32* %r2, i32 2
%r25 = trunc i672 %r22 to i32
store i32 %r25, i32* %r24
%r26 = lshr i672 %r22, 32
%r28 = getelementptr i32, i32* %r2, i32 3
%r29 = trunc i672 %r26 to i32
store i32 %r29, i32* %r28
%r30 = lshr i672 %r26, 32
%r32 = getelementptr i32, i32* %r2, i32 4
%r33 = trunc i672 %r30 to i32
store i32 %r33, i32* %r32
%r34 = lshr i672 %r30, 32
%r36 = getelementptr i32, i32* %r2, i32 5
%r37 = trunc i672 %r34 to i32
store i32 %r37, i32* %r36
%r38 = lshr i672 %r34, 32
%r40 = getelementptr i32, i32* %r2, i32 6
%r41 = trunc i672 %r38 to i32
store i32 %r41, i32* %r40
%r42 = lshr i672 %r38, 32
%r44 = getelementptr i32, i32* %r2, i32 7
%r45 = trunc i672 %r42 to i32
store i32 %r45, i32* %r44
%r46 = lshr i672 %r42, 32
%r48 = getelementptr i32, i32* %r2, i32 8
%r49 = trunc i672 %r46 to i32
store i32 %r49, i32* %r48
%r50 = lshr i672 %r46, 32
%r52 = getelementptr i32, i32* %r2, i32 9
%r53 = trunc i672 %r50 to i32
store i32 %r53, i32* %r52
%r54 = lshr i672 %r50, 32
%r56 = getelementptr i32, i32* %r2, i32 10
%r57 = trunc i672 %r54 to i32
store i32 %r57, i32* %r56
%r58 = lshr i672 %r54, 32
%r60 = getelementptr i32, i32* %r2, i32 11
%r61 = trunc i672 %r58 to i32
store i32 %r61, i32* %r60
%r62 = lshr i672 %r58, 32
%r64 = getelementptr i32, i32* %r2, i32 12
%r65 = trunc i672 %r62 to i32
store i32 %r65, i32* %r64
%r66 = lshr i672 %r62, 32
%r68 = getelementptr i32, i32* %r2, i32 13
%r69 = trunc i672 %r66 to i32
store i32 %r69, i32* %r68
%r70 = lshr i672 %r66, 32
%r72 = getelementptr i32, i32* %r2, i32 14
%r73 = trunc i672 %r70 to i32
store i32 %r73, i32* %r72
%r74 = lshr i672 %r70, 32
%r76 = getelementptr i32, i32* %r2, i32 15
%r77 = trunc i672 %r74 to i32
store i32 %r77, i32* %r76
%r78 = lshr i672 %r74, 32
%r80 = getelementptr i32, i32* %r2, i32 16
%r81 = trunc i672 %r78 to i32
store i32 %r81, i32* %r80
%r82 = lshr i672 %r78, 32
%r84 = getelementptr i32, i32* %r2, i32 17
%r85 = trunc i672 %r82 to i32
store i32 %r85, i32* %r84
%r86 = lshr i672 %r82, 32
%r88 = getelementptr i32, i32* %r2, i32 18
%r89 = trunc i672 %r86 to i32
store i32 %r89, i32* %r88
%r90 = lshr i672 %r86, 32
%r92 = getelementptr i32, i32* %r2, i32 19
%r93 = trunc i672 %r90 to i32
store i32 %r93, i32* %r92
%r94 = lshr i672 %r90, 32
%r96 = getelementptr i32, i32* %r2, i32 20
%r97 = trunc i672 %r94 to i32
store i32 %r97, i32* %r96
%r98 = lshr i704 %r13, 672
%r99 = trunc i704 %r98 to i32
%r101 = and i32 %r99, 1
ret i32 %r101
}
define void @mclb_addNF21(i32* noalias  %r1, i32* noalias  %r2, i32* noalias  %r3)
{
%r5 = bitcast i32* %r2 to i672*
%r6 = load i672, i672* %r5
%r8 = bitcast i32* %r3 to i672*
%r9 = load i672, i672* %r8
%r10 = add i672 %r6, %r9
%r12 = getelementptr i32, i32* %r1, i32 0
%r13 = trunc i672 %r10 to i32
store i32 %r13, i32* %r12
%r14 = lshr i672 %r10, 32
%r16 = getelementptr i32, i32* %r1, i32 1
%r17 = trunc i672 %r14 to i32
store i32 %r17, i32* %r16
%r18 = lshr i672 %r14, 32
%r20 = getelementptr i32, i32* %r1, i32 2
%r21 = trunc i672 %r18 to i32
store i32 %r21, i32* %r20
%r22 = lshr i672 %r18, 32
%r24 = getelementptr i32, i32* %r1, i32 3
%r25 = trunc i672 %r22 to i32
store i32 %r25, i32* %r24
%r26 = lshr i672 %r22, 32
%r28 = getelementptr i32, i32* %r1, i32 4
%r29 = trunc i672 %r26 to i32
store i32 %r29, i32* %r28
%r30 = lshr i672 %r26, 32
%r32 = getelementptr i32, i32* %r1, i32 5
%r33 = trunc i672 %r30 to i32
store i32 %r33, i32* %r32
%r34 = lshr i672 %r30, 32
%r36 = getelementptr i32, i32* %r1, i32 6
%r37 = trunc i672 %r34 to i32
store i32 %r37, i32* %r36
%r38 = lshr i672 %r34, 32
%r40 = getelementptr i32, i32* %r1, i32 7
%r41 = trunc i672 %r38 to i32
store i32 %r41, i32* %r40
%r42 = lshr i672 %r38, 32
%r44 = getelementptr i32, i32* %r1, i32 8
%r45 = trunc i672 %r42 to i32
store i32 %r45, i32* %r44
%r46 = lshr i672 %r42, 32
%r48 = getelementptr i32, i32* %r1, i32 9
%r49 = trunc i672 %r46 to i32
store i32 %r49, i32* %r48
%r50 = lshr i672 %r46, 32
%r52 = getelementptr i32, i32* %r1, i32 10
%r53 = trunc i672 %r50 to i32
store i32 %r53, i32* %r52
%r54 = lshr i672 %r50, 32
%r56 = getelementptr i32, i32* %r1, i32 11
%r57 = trunc i672 %r54 to i32
store i32 %r57, i32* %r56
%r58 = lshr i672 %r54, 32
%r60 = getelementptr i32, i32* %r1, i32 12
%r61 = trunc i672 %r58 to i32
store i32 %r61, i32* %r60
%r62 = lshr i672 %r58, 32
%r64 = getelementptr i32, i32* %r1, i32 13
%r65 = trunc i672 %r62 to i32
store i32 %r65, i32* %r64
%r66 = lshr i672 %r62, 32
%r68 = getelementptr i32, i32* %r1, i32 14
%r69 = trunc i672 %r66 to i32
store i32 %r69, i32* %r68
%r70 = lshr i672 %r66, 32
%r72 = getelementptr i32, i32* %r1, i32 15
%r73 = trunc i672 %r70 to i32
store i32 %r73, i32* %r72
%r74 = lshr i672 %r70, 32
%r76 = getelementptr i32, i32* %r1, i32 16
%r77 = trunc i672 %r74 to i32
store i32 %r77, i32* %r76
%r78 = lshr i672 %r74, 32
%r80 = getelementptr i32, i32* %r1, i32 17
%r81 = trunc i672 %r78 to i32
store i32 %r81, i32* %r80
%r82 = lshr i672 %r78, 32
%r84 = getelementptr i32, i32* %r1, i32 18
%r85 = trunc i672 %r82 to i32
store i32 %r85, i32* %r84
%r86 = lshr i672 %r82, 32
%r88 = getelementptr i32, i32* %r1, i32 19
%r89 = trunc i672 %r86 to i32
store i32 %r89, i32* %r88
%r90 = lshr i672 %r86, 32
%r92 = getelementptr i32, i32* %r1, i32 20
%r93 = trunc i672 %r90 to i32
store i32 %r93, i32* %r92
ret void
}
define i32 @mclb_subNF21(i32* noalias  %r2, i32* noalias  %r3, i32* noalias  %r4)
{
%r6 = bitcast i32* %r3 to i672*
%r7 = load i672, i672* %r6
%r9 = bitcast i32* %r4 to i672*
%r10 = load i672, i672* %r9
%r11 = sub i672 %r7, %r10
%r13 = getelementptr i32, i32* %r2, i32 0
%r14 = trunc i672 %r11 to i32
store i32 %r14, i32* %r13
%r15 = lshr i672 %r11, 32
%r17 = getelementptr i32, i32* %r2, i32 1
%r18 = trunc i672 %r15 to i32
store i32 %r18, i32* %r17
%r19 = lshr i672 %r15, 32
%r21 = getelementptr i32, i32* %r2, i32 2
%r22 = trunc i672 %r19 to i32
store i32 %r22, i32* %r21
%r23 = lshr i672 %r19, 32
%r25 = getelementptr i32, i32* %r2, i32 3
%r26 = trunc i672 %r23 to i32
store i32 %r26, i32* %r25
%r27 = lshr i672 %r23, 32
%r29 = getelementptr i32, i32* %r2, i32 4
%r30 = trunc i672 %r27 to i32
store i32 %r30, i32* %r29
%r31 = lshr i672 %r27, 32
%r33 = getelementptr i32, i32* %r2, i32 5
%r34 = trunc i672 %r31 to i32
store i32 %r34, i32* %r33
%r35 = lshr i672 %r31, 32
%r37 = getelementptr i32, i32* %r2, i32 6
%r38 = trunc i672 %r35 to i32
store i32 %r38, i32* %r37
%r39 = lshr i672 %r35, 32
%r41 = getelementptr i32, i32* %r2, i32 7
%r42 = trunc i672 %r39 to i32
store i32 %r42, i32* %r41
%r43 = lshr i672 %r39, 32
%r45 = getelementptr i32, i32* %r2, i32 8
%r46 = trunc i672 %r43 to i32
store i32 %r46, i32* %r45
%r47 = lshr i672 %r43, 32
%r49 = getelementptr i32, i32* %r2, i32 9
%r50 = trunc i672 %r47 to i32
store i32 %r50, i32* %r49
%r51 = lshr i672 %r47, 32
%r53 = getelementptr i32, i32* %r2, i32 10
%r54 = trunc i672 %r51 to i32
store i32 %r54, i32* %r53
%r55 = lshr i672 %r51, 32
%r57 = getelementptr i32, i32* %r2, i32 11
%r58 = trunc i672 %r55 to i32
store i32 %r58, i32* %r57
%r59 = lshr i672 %r55, 32
%r61 = getelementptr i32, i32* %r2, i32 12
%r62 = trunc i672 %r59 to i32
store i32 %r62, i32* %r61
%r63 = lshr i672 %r59, 32
%r65 = getelementptr i32, i32* %r2, i32 13
%r66 = trunc i672 %r63 to i32
store i32 %r66, i32* %r65
%r67 = lshr i672 %r63, 32
%r69 = getelementptr i32, i32* %r2, i32 14
%r70 = trunc i672 %r67 to i32
store i32 %r70, i32* %r69
%r71 = lshr i672 %r67, 32
%r73 = getelementptr i32, i32* %r2, i32 15
%r74 = trunc i672 %r71 to i32
store i32 %r74, i32* %r73
%r75 = lshr i672 %r71, 32
%r77 = getelementptr i32, i32* %r2, i32 16
%r78 = trunc i672 %r75 to i32
store i32 %r78, i32* %r77
%r79 = lshr i672 %r75, 32
%r81 = getelementptr i32, i32* %r2, i32 17
%r82 = trunc i672 %r79 to i32
store i32 %r82, i32* %r81
%r83 = lshr i672 %r79, 32
%r85 = getelementptr i32, i32* %r2, i32 18
%r86 = trunc i672 %r83 to i32
store i32 %r86, i32* %r85
%r87 = lshr i672 %r83, 32
%r89 = getelementptr i32, i32* %r2, i32 19
%r90 = trunc i672 %r87 to i32
store i32 %r90, i32* %r89
%r91 = lshr i672 %r87, 32
%r93 = getelementptr i32, i32* %r2, i32 20
%r94 = trunc i672 %r91 to i32
store i32 %r94, i32* %r93
%r95 = lshr i672 %r11, 671
%r96 = trunc i672 %r95 to i32
%r98 = and i32 %r96, 1
ret i32 %r98
}
define i32 @mclb_add22(i32* noalias  %r2, i32* noalias  %r3, i32* noalias  %r4)
{
%r6 = bitcast i32* %r3 to i704*
%r7 = load i704, i704* %r6
%r8 = zext i704 %r7 to i736
%r10 = bitcast i32* %r4 to i704*
%r11 = load i704, i704* %r10
%r12 = zext i704 %r11 to i736
%r13 = add i736 %r8, %r12
%r14 = trunc i736 %r13 to i704
%r16 = getelementptr i32, i32* %r2, i32 0
%r17 = trunc i704 %r14 to i32
store i32 %r17, i32* %r16
%r18 = lshr i704 %r14, 32
%r20 = getelementptr i32, i32* %r2, i32 1
%r21 = trunc i704 %r18 to i32
store i32 %r21, i32* %r20
%r22 = lshr i704 %r18, 32
%r24 = getelementptr i32, i32* %r2, i32 2
%r25 = trunc i704 %r22 to i32
store i32 %r25, i32* %r24
%r26 = lshr i704 %r22, 32
%r28 = getelementptr i32, i32* %r2, i32 3
%r29 = trunc i704 %r26 to i32
store i32 %r29, i32* %r28
%r30 = lshr i704 %r26, 32
%r32 = getelementptr i32, i32* %r2, i32 4
%r33 = trunc i704 %r30 to i32
store i32 %r33, i32* %r32
%r34 = lshr i704 %r30, 32
%r36 = getelementptr i32, i32* %r2, i32 5
%r37 = trunc i704 %r34 to i32
store i32 %r37, i32* %r36
%r38 = lshr i704 %r34, 32
%r40 = getelementptr i32, i32* %r2, i32 6
%r41 = trunc i704 %r38 to i32
store i32 %r41, i32* %r40
%r42 = lshr i704 %r38, 32
%r44 = getelementptr i32, i32* %r2, i32 7
%r45 = trunc i704 %r42 to i32
store i32 %r45, i32* %r44
%r46 = lshr i704 %r42, 32
%r48 = getelementptr i32, i32* %r2, i32 8
%r49 = trunc i704 %r46 to i32
store i32 %r49, i32* %r48
%r50 = lshr i704 %r46, 32
%r52 = getelementptr i32, i32* %r2, i32 9
%r53 = trunc i704 %r50 to i32
store i32 %r53, i32* %r52
%r54 = lshr i704 %r50, 32
%r56 = getelementptr i32, i32* %r2, i32 10
%r57 = trunc i704 %r54 to i32
store i32 %r57, i32* %r56
%r58 = lshr i704 %r54, 32
%r60 = getelementptr i32, i32* %r2, i32 11
%r61 = trunc i704 %r58 to i32
store i32 %r61, i32* %r60
%r62 = lshr i704 %r58, 32
%r64 = getelementptr i32, i32* %r2, i32 12
%r65 = trunc i704 %r62 to i32
store i32 %r65, i32* %r64
%r66 = lshr i704 %r62, 32
%r68 = getelementptr i32, i32* %r2, i32 13
%r69 = trunc i704 %r66 to i32
store i32 %r69, i32* %r68
%r70 = lshr i704 %r66, 32
%r72 = getelementptr i32, i32* %r2, i32 14
%r73 = trunc i704 %r70 to i32
store i32 %r73, i32* %r72
%r74 = lshr i704 %r70, 32
%r76 = getelementptr i32, i32* %r2, i32 15
%r77 = trunc i704 %r74 to i32
store i32 %r77, i32* %r76
%r78 = lshr i704 %r74, 32
%r80 = getelementptr i32, i32* %r2, i32 16
%r81 = trunc i704 %r78 to i32
store i32 %r81, i32* %r80
%r82 = lshr i704 %r78, 32
%r84 = getelementptr i32, i32* %r2, i32 17
%r85 = trunc i704 %r82 to i32
store i32 %r85, i32* %r84
%r86 = lshr i704 %r82, 32
%r88 = getelementptr i32, i32* %r2, i32 18
%r89 = trunc i704 %r86 to i32
store i32 %r89, i32* %r88
%r90 = lshr i704 %r86, 32
%r92 = getelementptr i32, i32* %r2, i32 19
%r93 = trunc i704 %r90 to i32
store i32 %r93, i32* %r92
%r94 = lshr i704 %r90, 32
%r96 = getelementptr i32, i32* %r2, i32 20
%r97 = trunc i704 %r94 to i32
store i32 %r97, i32* %r96
%r98 = lshr i704 %r94, 32
%r100 = getelementptr i32, i32* %r2, i32 21
%r101 = trunc i704 %r98 to i32
store i32 %r101, i32* %r100
%r102 = lshr i736 %r13, 704
%r103 = trunc i736 %r102 to i32
ret i32 %r103
}
define i32 @mclb_sub22(i32* noalias  %r2, i32* noalias  %r3, i32* noalias  %r4)
{
%r6 = bitcast i32* %r3 to i704*
%r7 = load i704, i704* %r6
%r8 = zext i704 %r7 to i736
%r10 = bitcast i32* %r4 to i704*
%r11 = load i704, i704* %r10
%r12 = zext i704 %r11 to i736
%r13 = sub i736 %r8, %r12
%r14 = trunc i736 %r13 to i704
%r16 = getelementptr i32, i32* %r2, i32 0
%r17 = trunc i704 %r14 to i32
store i32 %r17, i32* %r16
%r18 = lshr i704 %r14, 32
%r20 = getelementptr i32, i32* %r2, i32 1
%r21 = trunc i704 %r18 to i32
store i32 %r21, i32* %r20
%r22 = lshr i704 %r18, 32
%r24 = getelementptr i32, i32* %r2, i32 2
%r25 = trunc i704 %r22 to i32
store i32 %r25, i32* %r24
%r26 = lshr i704 %r22, 32
%r28 = getelementptr i32, i32* %r2, i32 3
%r29 = trunc i704 %r26 to i32
store i32 %r29, i32* %r28
%r30 = lshr i704 %r26, 32
%r32 = getelementptr i32, i32* %r2, i32 4
%r33 = trunc i704 %r30 to i32
store i32 %r33, i32* %r32
%r34 = lshr i704 %r30, 32
%r36 = getelementptr i32, i32* %r2, i32 5
%r37 = trunc i704 %r34 to i32
store i32 %r37, i32* %r36
%r38 = lshr i704 %r34, 32
%r40 = getelementptr i32, i32* %r2, i32 6
%r41 = trunc i704 %r38 to i32
store i32 %r41, i32* %r40
%r42 = lshr i704 %r38, 32
%r44 = getelementptr i32, i32* %r2, i32 7
%r45 = trunc i704 %r42 to i32
store i32 %r45, i32* %r44
%r46 = lshr i704 %r42, 32
%r48 = getelementptr i32, i32* %r2, i32 8
%r49 = trunc i704 %r46 to i32
store i32 %r49, i32* %r48
%r50 = lshr i704 %r46, 32
%r52 = getelementptr i32, i32* %r2, i32 9
%r53 = trunc i704 %r50 to i32
store i32 %r53, i32* %r52
%r54 = lshr i704 %r50, 32
%r56 = getelementptr i32, i32* %r2, i32 10
%r57 = trunc i704 %r54 to i32
store i32 %r57, i32* %r56
%r58 = lshr i704 %r54, 32
%r60 = getelementptr i32, i32* %r2, i32 11
%r61 = trunc i704 %r58 to i32
store i32 %r61, i32* %r60
%r62 = lshr i704 %r58, 32
%r64 = getelementptr i32, i32* %r2, i32 12
%r65 = trunc i704 %r62 to i32
store i32 %r65, i32* %r64
%r66 = lshr i704 %r62, 32
%r68 = getelementptr i32, i32* %r2, i32 13
%r69 = trunc i704 %r66 to i32
store i32 %r69, i32* %r68
%r70 = lshr i704 %r66, 32
%r72 = getelementptr i32, i32* %r2, i32 14
%r73 = trunc i704 %r70 to i32
store i32 %r73, i32* %r72
%r74 = lshr i704 %r70, 32
%r76 = getelementptr i32, i32* %r2, i32 15
%r77 = trunc i704 %r74 to i32
store i32 %r77, i32* %r76
%r78 = lshr i704 %r74, 32
%r80 = getelementptr i32, i32* %r2, i32 16
%r81 = trunc i704 %r78 to i32
store i32 %r81, i32* %r80
%r82 = lshr i704 %r78, 32
%r84 = getelementptr i32, i32* %r2, i32 17
%r85 = trunc i704 %r82 to i32
store i32 %r85, i32* %r84
%r86 = lshr i704 %r82, 32
%r88 = getelementptr i32, i32* %r2, i32 18
%r89 = trunc i704 %r86 to i32
store i32 %r89, i32* %r88
%r90 = lshr i704 %r86, 32
%r92 = getelementptr i32, i32* %r2, i32 19
%r93 = trunc i704 %r90 to i32
store i32 %r93, i32* %r92
%r94 = lshr i704 %r90, 32
%r96 = getelementptr i32, i32* %r2, i32 20
%r97 = trunc i704 %r94 to i32
store i32 %r97, i32* %r96
%r98 = lshr i704 %r94, 32
%r100 = getelementptr i32, i32* %r2, i32 21
%r101 = trunc i704 %r98 to i32
store i32 %r101, i32* %r100
%r102 = lshr i736 %r13, 704
%r103 = trunc i736 %r102 to i32
%r105 = and i32 %r103, 1
ret i32 %r105
}
define void @mclb_addNF22(i32* noalias  %r1, i32* noalias  %r2, i32* noalias  %r3)
{
%r5 = bitcast i32* %r2 to i704*
%r6 = load i704, i704* %r5
%r8 = bitcast i32* %r3 to i704*
%r9 = load i704, i704* %r8
%r10 = add i704 %r6, %r9
%r12 = getelementptr i32, i32* %r1, i32 0
%r13 = trunc i704 %r10 to i32
store i32 %r13, i32* %r12
%r14 = lshr i704 %r10, 32
%r16 = getelementptr i32, i32* %r1, i32 1
%r17 = trunc i704 %r14 to i32
store i32 %r17, i32* %r16
%r18 = lshr i704 %r14, 32
%r20 = getelementptr i32, i32* %r1, i32 2
%r21 = trunc i704 %r18 to i32
store i32 %r21, i32* %r20
%r22 = lshr i704 %r18, 32
%r24 = getelementptr i32, i32* %r1, i32 3
%r25 = trunc i704 %r22 to i32
store i32 %r25, i32* %r24
%r26 = lshr i704 %r22, 32
%r28 = getelementptr i32, i32* %r1, i32 4
%r29 = trunc i704 %r26 to i32
store i32 %r29, i32* %r28
%r30 = lshr i704 %r26, 32
%r32 = getelementptr i32, i32* %r1, i32 5
%r33 = trunc i704 %r30 to i32
store i32 %r33, i32* %r32
%r34 = lshr i704 %r30, 32
%r36 = getelementptr i32, i32* %r1, i32 6
%r37 = trunc i704 %r34 to i32
store i32 %r37, i32* %r36
%r38 = lshr i704 %r34, 32
%r40 = getelementptr i32, i32* %r1, i32 7
%r41 = trunc i704 %r38 to i32
store i32 %r41, i32* %r40
%r42 = lshr i704 %r38, 32
%r44 = getelementptr i32, i32* %r1, i32 8
%r45 = trunc i704 %r42 to i32
store i32 %r45, i32* %r44
%r46 = lshr i704 %r42, 32
%r48 = getelementptr i32, i32* %r1, i32 9
%r49 = trunc i704 %r46 to i32
store i32 %r49, i32* %r48
%r50 = lshr i704 %r46, 32
%r52 = getelementptr i32, i32* %r1, i32 10
%r53 = trunc i704 %r50 to i32
store i32 %r53, i32* %r52
%r54 = lshr i704 %r50, 32
%r56 = getelementptr i32, i32* %r1, i32 11
%r57 = trunc i704 %r54 to i32
store i32 %r57, i32* %r56
%r58 = lshr i704 %r54, 32
%r60 = getelementptr i32, i32* %r1, i32 12
%r61 = trunc i704 %r58 to i32
store i32 %r61, i32* %r60
%r62 = lshr i704 %r58, 32
%r64 = getelementptr i32, i32* %r1, i32 13
%r65 = trunc i704 %r62 to i32
store i32 %r65, i32* %r64
%r66 = lshr i704 %r62, 32
%r68 = getelementptr i32, i32* %r1, i32 14
%r69 = trunc i704 %r66 to i32
store i32 %r69, i32* %r68
%r70 = lshr i704 %r66, 32
%r72 = getelementptr i32, i32* %r1, i32 15
%r73 = trunc i704 %r70 to i32
store i32 %r73, i32* %r72
%r74 = lshr i704 %r70, 32
%r76 = getelementptr i32, i32* %r1, i32 16
%r77 = trunc i704 %r74 to i32
store i32 %r77, i32* %r76
%r78 = lshr i704 %r74, 32
%r80 = getelementptr i32, i32* %r1, i32 17
%r81 = trunc i704 %r78 to i32
store i32 %r81, i32* %r80
%r82 = lshr i704 %r78, 32
%r84 = getelementptr i32, i32* %r1, i32 18
%r85 = trunc i704 %r82 to i32
store i32 %r85, i32* %r84
%r86 = lshr i704 %r82, 32
%r88 = getelementptr i32, i32* %r1, i32 19
%r89 = trunc i704 %r86 to i32
store i32 %r89, i32* %r88
%r90 = lshr i704 %r86, 32
%r92 = getelementptr i32, i32* %r1, i32 20
%r93 = trunc i704 %r90 to i32
store i32 %r93, i32* %r92
%r94 = lshr i704 %r90, 32
%r96 = getelementptr i32, i32* %r1, i32 21
%r97 = trunc i704 %r94 to i32
store i32 %r97, i32* %r96
ret void
}
define i32 @mclb_subNF22(i32* noalias  %r2, i32* noalias  %r3, i32* noalias  %r4)
{
%r6 = bitcast i32* %r3 to i704*
%r7 = load i704, i704* %r6
%r9 = bitcast i32* %r4 to i704*
%r10 = load i704, i704* %r9
%r11 = sub i704 %r7, %r10
%r13 = getelementptr i32, i32* %r2, i32 0
%r14 = trunc i704 %r11 to i32
store i32 %r14, i32* %r13
%r15 = lshr i704 %r11, 32
%r17 = getelementptr i32, i32* %r2, i32 1
%r18 = trunc i704 %r15 to i32
store i32 %r18, i32* %r17
%r19 = lshr i704 %r15, 32
%r21 = getelementptr i32, i32* %r2, i32 2
%r22 = trunc i704 %r19 to i32
store i32 %r22, i32* %r21
%r23 = lshr i704 %r19, 32
%r25 = getelementptr i32, i32* %r2, i32 3
%r26 = trunc i704 %r23 to i32
store i32 %r26, i32* %r25
%r27 = lshr i704 %r23, 32
%r29 = getelementptr i32, i32* %r2, i32 4
%r30 = trunc i704 %r27 to i32
store i32 %r30, i32* %r29
%r31 = lshr i704 %r27, 32
%r33 = getelementptr i32, i32* %r2, i32 5
%r34 = trunc i704 %r31 to i32
store i32 %r34, i32* %r33
%r35 = lshr i704 %r31, 32
%r37 = getelementptr i32, i32* %r2, i32 6
%r38 = trunc i704 %r35 to i32
store i32 %r38, i32* %r37
%r39 = lshr i704 %r35, 32
%r41 = getelementptr i32, i32* %r2, i32 7
%r42 = trunc i704 %r39 to i32
store i32 %r42, i32* %r41
%r43 = lshr i704 %r39, 32
%r45 = getelementptr i32, i32* %r2, i32 8
%r46 = trunc i704 %r43 to i32
store i32 %r46, i32* %r45
%r47 = lshr i704 %r43, 32
%r49 = getelementptr i32, i32* %r2, i32 9
%r50 = trunc i704 %r47 to i32
store i32 %r50, i32* %r49
%r51 = lshr i704 %r47, 32
%r53 = getelementptr i32, i32* %r2, i32 10
%r54 = trunc i704 %r51 to i32
store i32 %r54, i32* %r53
%r55 = lshr i704 %r51, 32
%r57 = getelementptr i32, i32* %r2, i32 11
%r58 = trunc i704 %r55 to i32
store i32 %r58, i32* %r57
%r59 = lshr i704 %r55, 32
%r61 = getelementptr i32, i32* %r2, i32 12
%r62 = trunc i704 %r59 to i32
store i32 %r62, i32* %r61
%r63 = lshr i704 %r59, 32
%r65 = getelementptr i32, i32* %r2, i32 13
%r66 = trunc i704 %r63 to i32
store i32 %r66, i32* %r65
%r67 = lshr i704 %r63, 32
%r69 = getelementptr i32, i32* %r2, i32 14
%r70 = trunc i704 %r67 to i32
store i32 %r70, i32* %r69
%r71 = lshr i704 %r67, 32
%r73 = getelementptr i32, i32* %r2, i32 15
%r74 = trunc i704 %r71 to i32
store i32 %r74, i32* %r73
%r75 = lshr i704 %r71, 32
%r77 = getelementptr i32, i32* %r2, i32 16
%r78 = trunc i704 %r75 to i32
store i32 %r78, i32* %r77
%r79 = lshr i704 %r75, 32
%r81 = getelementptr i32, i32* %r2, i32 17
%r82 = trunc i704 %r79 to i32
store i32 %r82, i32* %r81
%r83 = lshr i704 %r79, 32
%r85 = getelementptr i32, i32* %r2, i32 18
%r86 = trunc i704 %r83 to i32
store i32 %r86, i32* %r85
%r87 = lshr i704 %r83, 32
%r89 = getelementptr i32, i32* %r2, i32 19
%r90 = trunc i704 %r87 to i32
store i32 %r90, i32* %r89
%r91 = lshr i704 %r87, 32
%r93 = getelementptr i32, i32* %r2, i32 20
%r94 = trunc i704 %r91 to i32
store i32 %r94, i32* %r93
%r95 = lshr i704 %r91, 32
%r97 = getelementptr i32, i32* %r2, i32 21
%r98 = trunc i704 %r95 to i32
store i32 %r98, i32* %r97
%r99 = lshr i704 %r11, 703
%r100 = trunc i704 %r99 to i32
%r102 = and i32 %r100, 1
ret i32 %r102
}
define i32 @mclb_add23(i32* noalias  %r2, i32* noalias  %r3, i32* noalias  %r4)
{
%r6 = bitcast i32* %r3 to i736*
%r7 = load i736, i736* %r6
%r8 = zext i736 %r7 to i768
%r10 = bitcast i32* %r4 to i736*
%r11 = load i736, i736* %r10
%r12 = zext i736 %r11 to i768
%r13 = add i768 %r8, %r12
%r14 = trunc i768 %r13 to i736
%r16 = getelementptr i32, i32* %r2, i32 0
%r17 = trunc i736 %r14 to i32
store i32 %r17, i32* %r16
%r18 = lshr i736 %r14, 32
%r20 = getelementptr i32, i32* %r2, i32 1
%r21 = trunc i736 %r18 to i32
store i32 %r21, i32* %r20
%r22 = lshr i736 %r18, 32
%r24 = getelementptr i32, i32* %r2, i32 2
%r25 = trunc i736 %r22 to i32
store i32 %r25, i32* %r24
%r26 = lshr i736 %r22, 32
%r28 = getelementptr i32, i32* %r2, i32 3
%r29 = trunc i736 %r26 to i32
store i32 %r29, i32* %r28
%r30 = lshr i736 %r26, 32
%r32 = getelementptr i32, i32* %r2, i32 4
%r33 = trunc i736 %r30 to i32
store i32 %r33, i32* %r32
%r34 = lshr i736 %r30, 32
%r36 = getelementptr i32, i32* %r2, i32 5
%r37 = trunc i736 %r34 to i32
store i32 %r37, i32* %r36
%r38 = lshr i736 %r34, 32
%r40 = getelementptr i32, i32* %r2, i32 6
%r41 = trunc i736 %r38 to i32
store i32 %r41, i32* %r40
%r42 = lshr i736 %r38, 32
%r44 = getelementptr i32, i32* %r2, i32 7
%r45 = trunc i736 %r42 to i32
store i32 %r45, i32* %r44
%r46 = lshr i736 %r42, 32
%r48 = getelementptr i32, i32* %r2, i32 8
%r49 = trunc i736 %r46 to i32
store i32 %r49, i32* %r48
%r50 = lshr i736 %r46, 32
%r52 = getelementptr i32, i32* %r2, i32 9
%r53 = trunc i736 %r50 to i32
store i32 %r53, i32* %r52
%r54 = lshr i736 %r50, 32
%r56 = getelementptr i32, i32* %r2, i32 10
%r57 = trunc i736 %r54 to i32
store i32 %r57, i32* %r56
%r58 = lshr i736 %r54, 32
%r60 = getelementptr i32, i32* %r2, i32 11
%r61 = trunc i736 %r58 to i32
store i32 %r61, i32* %r60
%r62 = lshr i736 %r58, 32
%r64 = getelementptr i32, i32* %r2, i32 12
%r65 = trunc i736 %r62 to i32
store i32 %r65, i32* %r64
%r66 = lshr i736 %r62, 32
%r68 = getelementptr i32, i32* %r2, i32 13
%r69 = trunc i736 %r66 to i32
store i32 %r69, i32* %r68
%r70 = lshr i736 %r66, 32
%r72 = getelementptr i32, i32* %r2, i32 14
%r73 = trunc i736 %r70 to i32
store i32 %r73, i32* %r72
%r74 = lshr i736 %r70, 32
%r76 = getelementptr i32, i32* %r2, i32 15
%r77 = trunc i736 %r74 to i32
store i32 %r77, i32* %r76
%r78 = lshr i736 %r74, 32
%r80 = getelementptr i32, i32* %r2, i32 16
%r81 = trunc i736 %r78 to i32
store i32 %r81, i32* %r80
%r82 = lshr i736 %r78, 32
%r84 = getelementptr i32, i32* %r2, i32 17
%r85 = trunc i736 %r82 to i32
store i32 %r85, i32* %r84
%r86 = lshr i736 %r82, 32
%r88 = getelementptr i32, i32* %r2, i32 18
%r89 = trunc i736 %r86 to i32
store i32 %r89, i32* %r88
%r90 = lshr i736 %r86, 32
%r92 = getelementptr i32, i32* %r2, i32 19
%r93 = trunc i736 %r90 to i32
store i32 %r93, i32* %r92
%r94 = lshr i736 %r90, 32
%r96 = getelementptr i32, i32* %r2, i32 20
%r97 = trunc i736 %r94 to i32
store i32 %r97, i32* %r96
%r98 = lshr i736 %r94, 32
%r100 = getelementptr i32, i32* %r2, i32 21
%r101 = trunc i736 %r98 to i32
store i32 %r101, i32* %r100
%r102 = lshr i736 %r98, 32
%r104 = getelementptr i32, i32* %r2, i32 22
%r105 = trunc i736 %r102 to i32
store i32 %r105, i32* %r104
%r106 = lshr i768 %r13, 736
%r107 = trunc i768 %r106 to i32
ret i32 %r107
}
define i32 @mclb_sub23(i32* noalias  %r2, i32* noalias  %r3, i32* noalias  %r4)
{
%r6 = bitcast i32* %r3 to i736*
%r7 = load i736, i736* %r6
%r8 = zext i736 %r7 to i768
%r10 = bitcast i32* %r4 to i736*
%r11 = load i736, i736* %r10
%r12 = zext i736 %r11 to i768
%r13 = sub i768 %r8, %r12
%r14 = trunc i768 %r13 to i736
%r16 = getelementptr i32, i32* %r2, i32 0
%r17 = trunc i736 %r14 to i32
store i32 %r17, i32* %r16
%r18 = lshr i736 %r14, 32
%r20 = getelementptr i32, i32* %r2, i32 1
%r21 = trunc i736 %r18 to i32
store i32 %r21, i32* %r20
%r22 = lshr i736 %r18, 32
%r24 = getelementptr i32, i32* %r2, i32 2
%r25 = trunc i736 %r22 to i32
store i32 %r25, i32* %r24
%r26 = lshr i736 %r22, 32
%r28 = getelementptr i32, i32* %r2, i32 3
%r29 = trunc i736 %r26 to i32
store i32 %r29, i32* %r28
%r30 = lshr i736 %r26, 32
%r32 = getelementptr i32, i32* %r2, i32 4
%r33 = trunc i736 %r30 to i32
store i32 %r33, i32* %r32
%r34 = lshr i736 %r30, 32
%r36 = getelementptr i32, i32* %r2, i32 5
%r37 = trunc i736 %r34 to i32
store i32 %r37, i32* %r36
%r38 = lshr i736 %r34, 32
%r40 = getelementptr i32, i32* %r2, i32 6
%r41 = trunc i736 %r38 to i32
store i32 %r41, i32* %r40
%r42 = lshr i736 %r38, 32
%r44 = getelementptr i32, i32* %r2, i32 7
%r45 = trunc i736 %r42 to i32
store i32 %r45, i32* %r44
%r46 = lshr i736 %r42, 32
%r48 = getelementptr i32, i32* %r2, i32 8
%r49 = trunc i736 %r46 to i32
store i32 %r49, i32* %r48
%r50 = lshr i736 %r46, 32
%r52 = getelementptr i32, i32* %r2, i32 9
%r53 = trunc i736 %r50 to i32
store i32 %r53, i32* %r52
%r54 = lshr i736 %r50, 32
%r56 = getelementptr i32, i32* %r2, i32 10
%r57 = trunc i736 %r54 to i32
store i32 %r57, i32* %r56
%r58 = lshr i736 %r54, 32
%r60 = getelementptr i32, i32* %r2, i32 11
%r61 = trunc i736 %r58 to i32
store i32 %r61, i32* %r60
%r62 = lshr i736 %r58, 32
%r64 = getelementptr i32, i32* %r2, i32 12
%r65 = trunc i736 %r62 to i32
store i32 %r65, i32* %r64
%r66 = lshr i736 %r62, 32
%r68 = getelementptr i32, i32* %r2, i32 13
%r69 = trunc i736 %r66 to i32
store i32 %r69, i32* %r68
%r70 = lshr i736 %r66, 32
%r72 = getelementptr i32, i32* %r2, i32 14
%r73 = trunc i736 %r70 to i32
store i32 %r73, i32* %r72
%r74 = lshr i736 %r70, 32
%r76 = getelementptr i32, i32* %r2, i32 15
%r77 = trunc i736 %r74 to i32
store i32 %r77, i32* %r76
%r78 = lshr i736 %r74, 32
%r80 = getelementptr i32, i32* %r2, i32 16
%r81 = trunc i736 %r78 to i32
store i32 %r81, i32* %r80
%r82 = lshr i736 %r78, 32
%r84 = getelementptr i32, i32* %r2, i32 17
%r85 = trunc i736 %r82 to i32
store i32 %r85, i32* %r84
%r86 = lshr i736 %r82, 32
%r88 = getelementptr i32, i32* %r2, i32 18
%r89 = trunc i736 %r86 to i32
store i32 %r89, i32* %r88
%r90 = lshr i736 %r86, 32
%r92 = getelementptr i32, i32* %r2, i32 19
%r93 = trunc i736 %r90 to i32
store i32 %r93, i32* %r92
%r94 = lshr i736 %r90, 32
%r96 = getelementptr i32, i32* %r2, i32 20
%r97 = trunc i736 %r94 to i32
store i32 %r97, i32* %r96
%r98 = lshr i736 %r94, 32
%r100 = getelementptr i32, i32* %r2, i32 21
%r101 = trunc i736 %r98 to i32
store i32 %r101, i32* %r100
%r102 = lshr i736 %r98, 32
%r104 = getelementptr i32, i32* %r2, i32 22
%r105 = trunc i736 %r102 to i32
store i32 %r105, i32* %r104
%r106 = lshr i768 %r13, 736
%r107 = trunc i768 %r106 to i32
%r109 = and i32 %r107, 1
ret i32 %r109
}
define void @mclb_addNF23(i32* noalias  %r1, i32* noalias  %r2, i32* noalias  %r3)
{
%r5 = bitcast i32* %r2 to i736*
%r6 = load i736, i736* %r5
%r8 = bitcast i32* %r3 to i736*
%r9 = load i736, i736* %r8
%r10 = add i736 %r6, %r9
%r12 = getelementptr i32, i32* %r1, i32 0
%r13 = trunc i736 %r10 to i32
store i32 %r13, i32* %r12
%r14 = lshr i736 %r10, 32
%r16 = getelementptr i32, i32* %r1, i32 1
%r17 = trunc i736 %r14 to i32
store i32 %r17, i32* %r16
%r18 = lshr i736 %r14, 32
%r20 = getelementptr i32, i32* %r1, i32 2
%r21 = trunc i736 %r18 to i32
store i32 %r21, i32* %r20
%r22 = lshr i736 %r18, 32
%r24 = getelementptr i32, i32* %r1, i32 3
%r25 = trunc i736 %r22 to i32
store i32 %r25, i32* %r24
%r26 = lshr i736 %r22, 32
%r28 = getelementptr i32, i32* %r1, i32 4
%r29 = trunc i736 %r26 to i32
store i32 %r29, i32* %r28
%r30 = lshr i736 %r26, 32
%r32 = getelementptr i32, i32* %r1, i32 5
%r33 = trunc i736 %r30 to i32
store i32 %r33, i32* %r32
%r34 = lshr i736 %r30, 32
%r36 = getelementptr i32, i32* %r1, i32 6
%r37 = trunc i736 %r34 to i32
store i32 %r37, i32* %r36
%r38 = lshr i736 %r34, 32
%r40 = getelementptr i32, i32* %r1, i32 7
%r41 = trunc i736 %r38 to i32
store i32 %r41, i32* %r40
%r42 = lshr i736 %r38, 32
%r44 = getelementptr i32, i32* %r1, i32 8
%r45 = trunc i736 %r42 to i32
store i32 %r45, i32* %r44
%r46 = lshr i736 %r42, 32
%r48 = getelementptr i32, i32* %r1, i32 9
%r49 = trunc i736 %r46 to i32
store i32 %r49, i32* %r48
%r50 = lshr i736 %r46, 32
%r52 = getelementptr i32, i32* %r1, i32 10
%r53 = trunc i736 %r50 to i32
store i32 %r53, i32* %r52
%r54 = lshr i736 %r50, 32
%r56 = getelementptr i32, i32* %r1, i32 11
%r57 = trunc i736 %r54 to i32
store i32 %r57, i32* %r56
%r58 = lshr i736 %r54, 32
%r60 = getelementptr i32, i32* %r1, i32 12
%r61 = trunc i736 %r58 to i32
store i32 %r61, i32* %r60
%r62 = lshr i736 %r58, 32
%r64 = getelementptr i32, i32* %r1, i32 13
%r65 = trunc i736 %r62 to i32
store i32 %r65, i32* %r64
%r66 = lshr i736 %r62, 32
%r68 = getelementptr i32, i32* %r1, i32 14
%r69 = trunc i736 %r66 to i32
store i32 %r69, i32* %r68
%r70 = lshr i736 %r66, 32
%r72 = getelementptr i32, i32* %r1, i32 15
%r73 = trunc i736 %r70 to i32
store i32 %r73, i32* %r72
%r74 = lshr i736 %r70, 32
%r76 = getelementptr i32, i32* %r1, i32 16
%r77 = trunc i736 %r74 to i32
store i32 %r77, i32* %r76
%r78 = lshr i736 %r74, 32
%r80 = getelementptr i32, i32* %r1, i32 17
%r81 = trunc i736 %r78 to i32
store i32 %r81, i32* %r80
%r82 = lshr i736 %r78, 32
%r84 = getelementptr i32, i32* %r1, i32 18
%r85 = trunc i736 %r82 to i32
store i32 %r85, i32* %r84
%r86 = lshr i736 %r82, 32
%r88 = getelementptr i32, i32* %r1, i32 19
%r89 = trunc i736 %r86 to i32
store i32 %r89, i32* %r88
%r90 = lshr i736 %r86, 32
%r92 = getelementptr i32, i32* %r1, i32 20
%r93 = trunc i736 %r90 to i32
store i32 %r93, i32* %r92
%r94 = lshr i736 %r90, 32
%r96 = getelementptr i32, i32* %r1, i32 21
%r97 = trunc i736 %r94 to i32
store i32 %r97, i32* %r96
%r98 = lshr i736 %r94, 32
%r100 = getelementptr i32, i32* %r1, i32 22
%r101 = trunc i736 %r98 to i32
store i32 %r101, i32* %r100
ret void
}
define i32 @mclb_subNF23(i32* noalias  %r2, i32* noalias  %r3, i32* noalias  %r4)
{
%r6 = bitcast i32* %r3 to i736*
%r7 = load i736, i736* %r6
%r9 = bitcast i32* %r4 to i736*
%r10 = load i736, i736* %r9
%r11 = sub i736 %r7, %r10
%r13 = getelementptr i32, i32* %r2, i32 0
%r14 = trunc i736 %r11 to i32
store i32 %r14, i32* %r13
%r15 = lshr i736 %r11, 32
%r17 = getelementptr i32, i32* %r2, i32 1
%r18 = trunc i736 %r15 to i32
store i32 %r18, i32* %r17
%r19 = lshr i736 %r15, 32
%r21 = getelementptr i32, i32* %r2, i32 2
%r22 = trunc i736 %r19 to i32
store i32 %r22, i32* %r21
%r23 = lshr i736 %r19, 32
%r25 = getelementptr i32, i32* %r2, i32 3
%r26 = trunc i736 %r23 to i32
store i32 %r26, i32* %r25
%r27 = lshr i736 %r23, 32
%r29 = getelementptr i32, i32* %r2, i32 4
%r30 = trunc i736 %r27 to i32
store i32 %r30, i32* %r29
%r31 = lshr i736 %r27, 32
%r33 = getelementptr i32, i32* %r2, i32 5
%r34 = trunc i736 %r31 to i32
store i32 %r34, i32* %r33
%r35 = lshr i736 %r31, 32
%r37 = getelementptr i32, i32* %r2, i32 6
%r38 = trunc i736 %r35 to i32
store i32 %r38, i32* %r37
%r39 = lshr i736 %r35, 32
%r41 = getelementptr i32, i32* %r2, i32 7
%r42 = trunc i736 %r39 to i32
store i32 %r42, i32* %r41
%r43 = lshr i736 %r39, 32
%r45 = getelementptr i32, i32* %r2, i32 8
%r46 = trunc i736 %r43 to i32
store i32 %r46, i32* %r45
%r47 = lshr i736 %r43, 32
%r49 = getelementptr i32, i32* %r2, i32 9
%r50 = trunc i736 %r47 to i32
store i32 %r50, i32* %r49
%r51 = lshr i736 %r47, 32
%r53 = getelementptr i32, i32* %r2, i32 10
%r54 = trunc i736 %r51 to i32
store i32 %r54, i32* %r53
%r55 = lshr i736 %r51, 32
%r57 = getelementptr i32, i32* %r2, i32 11
%r58 = trunc i736 %r55 to i32
store i32 %r58, i32* %r57
%r59 = lshr i736 %r55, 32
%r61 = getelementptr i32, i32* %r2, i32 12
%r62 = trunc i736 %r59 to i32
store i32 %r62, i32* %r61
%r63 = lshr i736 %r59, 32
%r65 = getelementptr i32, i32* %r2, i32 13
%r66 = trunc i736 %r63 to i32
store i32 %r66, i32* %r65
%r67 = lshr i736 %r63, 32
%r69 = getelementptr i32, i32* %r2, i32 14
%r70 = trunc i736 %r67 to i32
store i32 %r70, i32* %r69
%r71 = lshr i736 %r67, 32
%r73 = getelementptr i32, i32* %r2, i32 15
%r74 = trunc i736 %r71 to i32
store i32 %r74, i32* %r73
%r75 = lshr i736 %r71, 32
%r77 = getelementptr i32, i32* %r2, i32 16
%r78 = trunc i736 %r75 to i32
store i32 %r78, i32* %r77
%r79 = lshr i736 %r75, 32
%r81 = getelementptr i32, i32* %r2, i32 17
%r82 = trunc i736 %r79 to i32
store i32 %r82, i32* %r81
%r83 = lshr i736 %r79, 32
%r85 = getelementptr i32, i32* %r2, i32 18
%r86 = trunc i736 %r83 to i32
store i32 %r86, i32* %r85
%r87 = lshr i736 %r83, 32
%r89 = getelementptr i32, i32* %r2, i32 19
%r90 = trunc i736 %r87 to i32
store i32 %r90, i32* %r89
%r91 = lshr i736 %r87, 32
%r93 = getelementptr i32, i32* %r2, i32 20
%r94 = trunc i736 %r91 to i32
store i32 %r94, i32* %r93
%r95 = lshr i736 %r91, 32
%r97 = getelementptr i32, i32* %r2, i32 21
%r98 = trunc i736 %r95 to i32
store i32 %r98, i32* %r97
%r99 = lshr i736 %r95, 32
%r101 = getelementptr i32, i32* %r2, i32 22
%r102 = trunc i736 %r99 to i32
store i32 %r102, i32* %r101
%r103 = lshr i736 %r11, 735
%r104 = trunc i736 %r103 to i32
%r106 = and i32 %r104, 1
ret i32 %r106
}
define i32 @mclb_add24(i32* noalias  %r2, i32* noalias  %r3, i32* noalias  %r4)
{
%r6 = bitcast i32* %r3 to i768*
%r7 = load i768, i768* %r6
%r8 = zext i768 %r7 to i800
%r10 = bitcast i32* %r4 to i768*
%r11 = load i768, i768* %r10
%r12 = zext i768 %r11 to i800
%r13 = add i800 %r8, %r12
%r14 = trunc i800 %r13 to i768
%r16 = getelementptr i32, i32* %r2, i32 0
%r17 = trunc i768 %r14 to i32
store i32 %r17, i32* %r16
%r18 = lshr i768 %r14, 32
%r20 = getelementptr i32, i32* %r2, i32 1
%r21 = trunc i768 %r18 to i32
store i32 %r21, i32* %r20
%r22 = lshr i768 %r18, 32
%r24 = getelementptr i32, i32* %r2, i32 2
%r25 = trunc i768 %r22 to i32
store i32 %r25, i32* %r24
%r26 = lshr i768 %r22, 32
%r28 = getelementptr i32, i32* %r2, i32 3
%r29 = trunc i768 %r26 to i32
store i32 %r29, i32* %r28
%r30 = lshr i768 %r26, 32
%r32 = getelementptr i32, i32* %r2, i32 4
%r33 = trunc i768 %r30 to i32
store i32 %r33, i32* %r32
%r34 = lshr i768 %r30, 32
%r36 = getelementptr i32, i32* %r2, i32 5
%r37 = trunc i768 %r34 to i32
store i32 %r37, i32* %r36
%r38 = lshr i768 %r34, 32
%r40 = getelementptr i32, i32* %r2, i32 6
%r41 = trunc i768 %r38 to i32
store i32 %r41, i32* %r40
%r42 = lshr i768 %r38, 32
%r44 = getelementptr i32, i32* %r2, i32 7
%r45 = trunc i768 %r42 to i32
store i32 %r45, i32* %r44
%r46 = lshr i768 %r42, 32
%r48 = getelementptr i32, i32* %r2, i32 8
%r49 = trunc i768 %r46 to i32
store i32 %r49, i32* %r48
%r50 = lshr i768 %r46, 32
%r52 = getelementptr i32, i32* %r2, i32 9
%r53 = trunc i768 %r50 to i32
store i32 %r53, i32* %r52
%r54 = lshr i768 %r50, 32
%r56 = getelementptr i32, i32* %r2, i32 10
%r57 = trunc i768 %r54 to i32
store i32 %r57, i32* %r56
%r58 = lshr i768 %r54, 32
%r60 = getelementptr i32, i32* %r2, i32 11
%r61 = trunc i768 %r58 to i32
store i32 %r61, i32* %r60
%r62 = lshr i768 %r58, 32
%r64 = getelementptr i32, i32* %r2, i32 12
%r65 = trunc i768 %r62 to i32
store i32 %r65, i32* %r64
%r66 = lshr i768 %r62, 32
%r68 = getelementptr i32, i32* %r2, i32 13
%r69 = trunc i768 %r66 to i32
store i32 %r69, i32* %r68
%r70 = lshr i768 %r66, 32
%r72 = getelementptr i32, i32* %r2, i32 14
%r73 = trunc i768 %r70 to i32
store i32 %r73, i32* %r72
%r74 = lshr i768 %r70, 32
%r76 = getelementptr i32, i32* %r2, i32 15
%r77 = trunc i768 %r74 to i32
store i32 %r77, i32* %r76
%r78 = lshr i768 %r74, 32
%r80 = getelementptr i32, i32* %r2, i32 16
%r81 = trunc i768 %r78 to i32
store i32 %r81, i32* %r80
%r82 = lshr i768 %r78, 32
%r84 = getelementptr i32, i32* %r2, i32 17
%r85 = trunc i768 %r82 to i32
store i32 %r85, i32* %r84
%r86 = lshr i768 %r82, 32
%r88 = getelementptr i32, i32* %r2, i32 18
%r89 = trunc i768 %r86 to i32
store i32 %r89, i32* %r88
%r90 = lshr i768 %r86, 32
%r92 = getelementptr i32, i32* %r2, i32 19
%r93 = trunc i768 %r90 to i32
store i32 %r93, i32* %r92
%r94 = lshr i768 %r90, 32
%r96 = getelementptr i32, i32* %r2, i32 20
%r97 = trunc i768 %r94 to i32
store i32 %r97, i32* %r96
%r98 = lshr i768 %r94, 32
%r100 = getelementptr i32, i32* %r2, i32 21
%r101 = trunc i768 %r98 to i32
store i32 %r101, i32* %r100
%r102 = lshr i768 %r98, 32
%r104 = getelementptr i32, i32* %r2, i32 22
%r105 = trunc i768 %r102 to i32
store i32 %r105, i32* %r104
%r106 = lshr i768 %r102, 32
%r108 = getelementptr i32, i32* %r2, i32 23
%r109 = trunc i768 %r106 to i32
store i32 %r109, i32* %r108
%r110 = lshr i800 %r13, 768
%r111 = trunc i800 %r110 to i32
ret i32 %r111
}
define i32 @mclb_sub24(i32* noalias  %r2, i32* noalias  %r3, i32* noalias  %r4)
{
%r6 = bitcast i32* %r3 to i768*
%r7 = load i768, i768* %r6
%r8 = zext i768 %r7 to i800
%r10 = bitcast i32* %r4 to i768*
%r11 = load i768, i768* %r10
%r12 = zext i768 %r11 to i800
%r13 = sub i800 %r8, %r12
%r14 = trunc i800 %r13 to i768
%r16 = getelementptr i32, i32* %r2, i32 0
%r17 = trunc i768 %r14 to i32
store i32 %r17, i32* %r16
%r18 = lshr i768 %r14, 32
%r20 = getelementptr i32, i32* %r2, i32 1
%r21 = trunc i768 %r18 to i32
store i32 %r21, i32* %r20
%r22 = lshr i768 %r18, 32
%r24 = getelementptr i32, i32* %r2, i32 2
%r25 = trunc i768 %r22 to i32
store i32 %r25, i32* %r24
%r26 = lshr i768 %r22, 32
%r28 = getelementptr i32, i32* %r2, i32 3
%r29 = trunc i768 %r26 to i32
store i32 %r29, i32* %r28
%r30 = lshr i768 %r26, 32
%r32 = getelementptr i32, i32* %r2, i32 4
%r33 = trunc i768 %r30 to i32
store i32 %r33, i32* %r32
%r34 = lshr i768 %r30, 32
%r36 = getelementptr i32, i32* %r2, i32 5
%r37 = trunc i768 %r34 to i32
store i32 %r37, i32* %r36
%r38 = lshr i768 %r34, 32
%r40 = getelementptr i32, i32* %r2, i32 6
%r41 = trunc i768 %r38 to i32
store i32 %r41, i32* %r40
%r42 = lshr i768 %r38, 32
%r44 = getelementptr i32, i32* %r2, i32 7
%r45 = trunc i768 %r42 to i32
store i32 %r45, i32* %r44
%r46 = lshr i768 %r42, 32
%r48 = getelementptr i32, i32* %r2, i32 8
%r49 = trunc i768 %r46 to i32
store i32 %r49, i32* %r48
%r50 = lshr i768 %r46, 32
%r52 = getelementptr i32, i32* %r2, i32 9
%r53 = trunc i768 %r50 to i32
store i32 %r53, i32* %r52
%r54 = lshr i768 %r50, 32
%r56 = getelementptr i32, i32* %r2, i32 10
%r57 = trunc i768 %r54 to i32
store i32 %r57, i32* %r56
%r58 = lshr i768 %r54, 32
%r60 = getelementptr i32, i32* %r2, i32 11
%r61 = trunc i768 %r58 to i32
store i32 %r61, i32* %r60
%r62 = lshr i768 %r58, 32
%r64 = getelementptr i32, i32* %r2, i32 12
%r65 = trunc i768 %r62 to i32
store i32 %r65, i32* %r64
%r66 = lshr i768 %r62, 32
%r68 = getelementptr i32, i32* %r2, i32 13
%r69 = trunc i768 %r66 to i32
store i32 %r69, i32* %r68
%r70 = lshr i768 %r66, 32
%r72 = getelementptr i32, i32* %r2, i32 14
%r73 = trunc i768 %r70 to i32
store i32 %r73, i32* %r72
%r74 = lshr i768 %r70, 32
%r76 = getelementptr i32, i32* %r2, i32 15
%r77 = trunc i768 %r74 to i32
store i32 %r77, i32* %r76
%r78 = lshr i768 %r74, 32
%r80 = getelementptr i32, i32* %r2, i32 16
%r81 = trunc i768 %r78 to i32
store i32 %r81, i32* %r80
%r82 = lshr i768 %r78, 32
%r84 = getelementptr i32, i32* %r2, i32 17
%r85 = trunc i768 %r82 to i32
store i32 %r85, i32* %r84
%r86 = lshr i768 %r82, 32
%r88 = getelementptr i32, i32* %r2, i32 18
%r89 = trunc i768 %r86 to i32
store i32 %r89, i32* %r88
%r90 = lshr i768 %r86, 32
%r92 = getelementptr i32, i32* %r2, i32 19
%r93 = trunc i768 %r90 to i32
store i32 %r93, i32* %r92
%r94 = lshr i768 %r90, 32
%r96 = getelementptr i32, i32* %r2, i32 20
%r97 = trunc i768 %r94 to i32
store i32 %r97, i32* %r96
%r98 = lshr i768 %r94, 32
%r100 = getelementptr i32, i32* %r2, i32 21
%r101 = trunc i768 %r98 to i32
store i32 %r101, i32* %r100
%r102 = lshr i768 %r98, 32
%r104 = getelementptr i32, i32* %r2, i32 22
%r105 = trunc i768 %r102 to i32
store i32 %r105, i32* %r104
%r106 = lshr i768 %r102, 32
%r108 = getelementptr i32, i32* %r2, i32 23
%r109 = trunc i768 %r106 to i32
store i32 %r109, i32* %r108
%r110 = lshr i800 %r13, 768
%r111 = trunc i800 %r110 to i32
%r113 = and i32 %r111, 1
ret i32 %r113
}
define void @mclb_addNF24(i32* noalias  %r1, i32* noalias  %r2, i32* noalias  %r3)
{
%r5 = bitcast i32* %r2 to i768*
%r6 = load i768, i768* %r5
%r8 = bitcast i32* %r3 to i768*
%r9 = load i768, i768* %r8
%r10 = add i768 %r6, %r9
%r12 = getelementptr i32, i32* %r1, i32 0
%r13 = trunc i768 %r10 to i32
store i32 %r13, i32* %r12
%r14 = lshr i768 %r10, 32
%r16 = getelementptr i32, i32* %r1, i32 1
%r17 = trunc i768 %r14 to i32
store i32 %r17, i32* %r16
%r18 = lshr i768 %r14, 32
%r20 = getelementptr i32, i32* %r1, i32 2
%r21 = trunc i768 %r18 to i32
store i32 %r21, i32* %r20
%r22 = lshr i768 %r18, 32
%r24 = getelementptr i32, i32* %r1, i32 3
%r25 = trunc i768 %r22 to i32
store i32 %r25, i32* %r24
%r26 = lshr i768 %r22, 32
%r28 = getelementptr i32, i32* %r1, i32 4
%r29 = trunc i768 %r26 to i32
store i32 %r29, i32* %r28
%r30 = lshr i768 %r26, 32
%r32 = getelementptr i32, i32* %r1, i32 5
%r33 = trunc i768 %r30 to i32
store i32 %r33, i32* %r32
%r34 = lshr i768 %r30, 32
%r36 = getelementptr i32, i32* %r1, i32 6
%r37 = trunc i768 %r34 to i32
store i32 %r37, i32* %r36
%r38 = lshr i768 %r34, 32
%r40 = getelementptr i32, i32* %r1, i32 7
%r41 = trunc i768 %r38 to i32
store i32 %r41, i32* %r40
%r42 = lshr i768 %r38, 32
%r44 = getelementptr i32, i32* %r1, i32 8
%r45 = trunc i768 %r42 to i32
store i32 %r45, i32* %r44
%r46 = lshr i768 %r42, 32
%r48 = getelementptr i32, i32* %r1, i32 9
%r49 = trunc i768 %r46 to i32
store i32 %r49, i32* %r48
%r50 = lshr i768 %r46, 32
%r52 = getelementptr i32, i32* %r1, i32 10
%r53 = trunc i768 %r50 to i32
store i32 %r53, i32* %r52
%r54 = lshr i768 %r50, 32
%r56 = getelementptr i32, i32* %r1, i32 11
%r57 = trunc i768 %r54 to i32
store i32 %r57, i32* %r56
%r58 = lshr i768 %r54, 32
%r60 = getelementptr i32, i32* %r1, i32 12
%r61 = trunc i768 %r58 to i32
store i32 %r61, i32* %r60
%r62 = lshr i768 %r58, 32
%r64 = getelementptr i32, i32* %r1, i32 13
%r65 = trunc i768 %r62 to i32
store i32 %r65, i32* %r64
%r66 = lshr i768 %r62, 32
%r68 = getelementptr i32, i32* %r1, i32 14
%r69 = trunc i768 %r66 to i32
store i32 %r69, i32* %r68
%r70 = lshr i768 %r66, 32
%r72 = getelementptr i32, i32* %r1, i32 15
%r73 = trunc i768 %r70 to i32
store i32 %r73, i32* %r72
%r74 = lshr i768 %r70, 32
%r76 = getelementptr i32, i32* %r1, i32 16
%r77 = trunc i768 %r74 to i32
store i32 %r77, i32* %r76
%r78 = lshr i768 %r74, 32
%r80 = getelementptr i32, i32* %r1, i32 17
%r81 = trunc i768 %r78 to i32
store i32 %r81, i32* %r80
%r82 = lshr i768 %r78, 32
%r84 = getelementptr i32, i32* %r1, i32 18
%r85 = trunc i768 %r82 to i32
store i32 %r85, i32* %r84
%r86 = lshr i768 %r82, 32
%r88 = getelementptr i32, i32* %r1, i32 19
%r89 = trunc i768 %r86 to i32
store i32 %r89, i32* %r88
%r90 = lshr i768 %r86, 32
%r92 = getelementptr i32, i32* %r1, i32 20
%r93 = trunc i768 %r90 to i32
store i32 %r93, i32* %r92
%r94 = lshr i768 %r90, 32
%r96 = getelementptr i32, i32* %r1, i32 21
%r97 = trunc i768 %r94 to i32
store i32 %r97, i32* %r96
%r98 = lshr i768 %r94, 32
%r100 = getelementptr i32, i32* %r1, i32 22
%r101 = trunc i768 %r98 to i32
store i32 %r101, i32* %r100
%r102 = lshr i768 %r98, 32
%r104 = getelementptr i32, i32* %r1, i32 23
%r105 = trunc i768 %r102 to i32
store i32 %r105, i32* %r104
ret void
}
define i32 @mclb_subNF24(i32* noalias  %r2, i32* noalias  %r3, i32* noalias  %r4)
{
%r6 = bitcast i32* %r3 to i768*
%r7 = load i768, i768* %r6
%r9 = bitcast i32* %r4 to i768*
%r10 = load i768, i768* %r9
%r11 = sub i768 %r7, %r10
%r13 = getelementptr i32, i32* %r2, i32 0
%r14 = trunc i768 %r11 to i32
store i32 %r14, i32* %r13
%r15 = lshr i768 %r11, 32
%r17 = getelementptr i32, i32* %r2, i32 1
%r18 = trunc i768 %r15 to i32
store i32 %r18, i32* %r17
%r19 = lshr i768 %r15, 32
%r21 = getelementptr i32, i32* %r2, i32 2
%r22 = trunc i768 %r19 to i32
store i32 %r22, i32* %r21
%r23 = lshr i768 %r19, 32
%r25 = getelementptr i32, i32* %r2, i32 3
%r26 = trunc i768 %r23 to i32
store i32 %r26, i32* %r25
%r27 = lshr i768 %r23, 32
%r29 = getelementptr i32, i32* %r2, i32 4
%r30 = trunc i768 %r27 to i32
store i32 %r30, i32* %r29
%r31 = lshr i768 %r27, 32
%r33 = getelementptr i32, i32* %r2, i32 5
%r34 = trunc i768 %r31 to i32
store i32 %r34, i32* %r33
%r35 = lshr i768 %r31, 32
%r37 = getelementptr i32, i32* %r2, i32 6
%r38 = trunc i768 %r35 to i32
store i32 %r38, i32* %r37
%r39 = lshr i768 %r35, 32
%r41 = getelementptr i32, i32* %r2, i32 7
%r42 = trunc i768 %r39 to i32
store i32 %r42, i32* %r41
%r43 = lshr i768 %r39, 32
%r45 = getelementptr i32, i32* %r2, i32 8
%r46 = trunc i768 %r43 to i32
store i32 %r46, i32* %r45
%r47 = lshr i768 %r43, 32
%r49 = getelementptr i32, i32* %r2, i32 9
%r50 = trunc i768 %r47 to i32
store i32 %r50, i32* %r49
%r51 = lshr i768 %r47, 32
%r53 = getelementptr i32, i32* %r2, i32 10
%r54 = trunc i768 %r51 to i32
store i32 %r54, i32* %r53
%r55 = lshr i768 %r51, 32
%r57 = getelementptr i32, i32* %r2, i32 11
%r58 = trunc i768 %r55 to i32
store i32 %r58, i32* %r57
%r59 = lshr i768 %r55, 32
%r61 = getelementptr i32, i32* %r2, i32 12
%r62 = trunc i768 %r59 to i32
store i32 %r62, i32* %r61
%r63 = lshr i768 %r59, 32
%r65 = getelementptr i32, i32* %r2, i32 13
%r66 = trunc i768 %r63 to i32
store i32 %r66, i32* %r65
%r67 = lshr i768 %r63, 32
%r69 = getelementptr i32, i32* %r2, i32 14
%r70 = trunc i768 %r67 to i32
store i32 %r70, i32* %r69
%r71 = lshr i768 %r67, 32
%r73 = getelementptr i32, i32* %r2, i32 15
%r74 = trunc i768 %r71 to i32
store i32 %r74, i32* %r73
%r75 = lshr i768 %r71, 32
%r77 = getelementptr i32, i32* %r2, i32 16
%r78 = trunc i768 %r75 to i32
store i32 %r78, i32* %r77
%r79 = lshr i768 %r75, 32
%r81 = getelementptr i32, i32* %r2, i32 17
%r82 = trunc i768 %r79 to i32
store i32 %r82, i32* %r81
%r83 = lshr i768 %r79, 32
%r85 = getelementptr i32, i32* %r2, i32 18
%r86 = trunc i768 %r83 to i32
store i32 %r86, i32* %r85
%r87 = lshr i768 %r83, 32
%r89 = getelementptr i32, i32* %r2, i32 19
%r90 = trunc i768 %r87 to i32
store i32 %r90, i32* %r89
%r91 = lshr i768 %r87, 32
%r93 = getelementptr i32, i32* %r2, i32 20
%r94 = trunc i768 %r91 to i32
store i32 %r94, i32* %r93
%r95 = lshr i768 %r91, 32
%r97 = getelementptr i32, i32* %r2, i32 21
%r98 = trunc i768 %r95 to i32
store i32 %r98, i32* %r97
%r99 = lshr i768 %r95, 32
%r101 = getelementptr i32, i32* %r2, i32 22
%r102 = trunc i768 %r99 to i32
store i32 %r102, i32* %r101
%r103 = lshr i768 %r99, 32
%r105 = getelementptr i32, i32* %r2, i32 23
%r106 = trunc i768 %r103 to i32
store i32 %r106, i32* %r105
%r107 = lshr i768 %r11, 767
%r108 = trunc i768 %r107 to i32
%r110 = and i32 %r108, 1
ret i32 %r110
}
define i32 @mclb_add25(i32* noalias  %r2, i32* noalias  %r3, i32* noalias  %r4)
{
%r6 = bitcast i32* %r3 to i800*
%r7 = load i800, i800* %r6
%r8 = zext i800 %r7 to i832
%r10 = bitcast i32* %r4 to i800*
%r11 = load i800, i800* %r10
%r12 = zext i800 %r11 to i832
%r13 = add i832 %r8, %r12
%r14 = trunc i832 %r13 to i800
%r16 = getelementptr i32, i32* %r2, i32 0
%r17 = trunc i800 %r14 to i32
store i32 %r17, i32* %r16
%r18 = lshr i800 %r14, 32
%r20 = getelementptr i32, i32* %r2, i32 1
%r21 = trunc i800 %r18 to i32
store i32 %r21, i32* %r20
%r22 = lshr i800 %r18, 32
%r24 = getelementptr i32, i32* %r2, i32 2
%r25 = trunc i800 %r22 to i32
store i32 %r25, i32* %r24
%r26 = lshr i800 %r22, 32
%r28 = getelementptr i32, i32* %r2, i32 3
%r29 = trunc i800 %r26 to i32
store i32 %r29, i32* %r28
%r30 = lshr i800 %r26, 32
%r32 = getelementptr i32, i32* %r2, i32 4
%r33 = trunc i800 %r30 to i32
store i32 %r33, i32* %r32
%r34 = lshr i800 %r30, 32
%r36 = getelementptr i32, i32* %r2, i32 5
%r37 = trunc i800 %r34 to i32
store i32 %r37, i32* %r36
%r38 = lshr i800 %r34, 32
%r40 = getelementptr i32, i32* %r2, i32 6
%r41 = trunc i800 %r38 to i32
store i32 %r41, i32* %r40
%r42 = lshr i800 %r38, 32
%r44 = getelementptr i32, i32* %r2, i32 7
%r45 = trunc i800 %r42 to i32
store i32 %r45, i32* %r44
%r46 = lshr i800 %r42, 32
%r48 = getelementptr i32, i32* %r2, i32 8
%r49 = trunc i800 %r46 to i32
store i32 %r49, i32* %r48
%r50 = lshr i800 %r46, 32
%r52 = getelementptr i32, i32* %r2, i32 9
%r53 = trunc i800 %r50 to i32
store i32 %r53, i32* %r52
%r54 = lshr i800 %r50, 32
%r56 = getelementptr i32, i32* %r2, i32 10
%r57 = trunc i800 %r54 to i32
store i32 %r57, i32* %r56
%r58 = lshr i800 %r54, 32
%r60 = getelementptr i32, i32* %r2, i32 11
%r61 = trunc i800 %r58 to i32
store i32 %r61, i32* %r60
%r62 = lshr i800 %r58, 32
%r64 = getelementptr i32, i32* %r2, i32 12
%r65 = trunc i800 %r62 to i32
store i32 %r65, i32* %r64
%r66 = lshr i800 %r62, 32
%r68 = getelementptr i32, i32* %r2, i32 13
%r69 = trunc i800 %r66 to i32
store i32 %r69, i32* %r68
%r70 = lshr i800 %r66, 32
%r72 = getelementptr i32, i32* %r2, i32 14
%r73 = trunc i800 %r70 to i32
store i32 %r73, i32* %r72
%r74 = lshr i800 %r70, 32
%r76 = getelementptr i32, i32* %r2, i32 15
%r77 = trunc i800 %r74 to i32
store i32 %r77, i32* %r76
%r78 = lshr i800 %r74, 32
%r80 = getelementptr i32, i32* %r2, i32 16
%r81 = trunc i800 %r78 to i32
store i32 %r81, i32* %r80
%r82 = lshr i800 %r78, 32
%r84 = getelementptr i32, i32* %r2, i32 17
%r85 = trunc i800 %r82 to i32
store i32 %r85, i32* %r84
%r86 = lshr i800 %r82, 32
%r88 = getelementptr i32, i32* %r2, i32 18
%r89 = trunc i800 %r86 to i32
store i32 %r89, i32* %r88
%r90 = lshr i800 %r86, 32
%r92 = getelementptr i32, i32* %r2, i32 19
%r93 = trunc i800 %r90 to i32
store i32 %r93, i32* %r92
%r94 = lshr i800 %r90, 32
%r96 = getelementptr i32, i32* %r2, i32 20
%r97 = trunc i800 %r94 to i32
store i32 %r97, i32* %r96
%r98 = lshr i800 %r94, 32
%r100 = getelementptr i32, i32* %r2, i32 21
%r101 = trunc i800 %r98 to i32
store i32 %r101, i32* %r100
%r102 = lshr i800 %r98, 32
%r104 = getelementptr i32, i32* %r2, i32 22
%r105 = trunc i800 %r102 to i32
store i32 %r105, i32* %r104
%r106 = lshr i800 %r102, 32
%r108 = getelementptr i32, i32* %r2, i32 23
%r109 = trunc i800 %r106 to i32
store i32 %r109, i32* %r108
%r110 = lshr i800 %r106, 32
%r112 = getelementptr i32, i32* %r2, i32 24
%r113 = trunc i800 %r110 to i32
store i32 %r113, i32* %r112
%r114 = lshr i832 %r13, 800
%r115 = trunc i832 %r114 to i32
ret i32 %r115
}
define i32 @mclb_sub25(i32* noalias  %r2, i32* noalias  %r3, i32* noalias  %r4)
{
%r6 = bitcast i32* %r3 to i800*
%r7 = load i800, i800* %r6
%r8 = zext i800 %r7 to i832
%r10 = bitcast i32* %r4 to i800*
%r11 = load i800, i800* %r10
%r12 = zext i800 %r11 to i832
%r13 = sub i832 %r8, %r12
%r14 = trunc i832 %r13 to i800
%r16 = getelementptr i32, i32* %r2, i32 0
%r17 = trunc i800 %r14 to i32
store i32 %r17, i32* %r16
%r18 = lshr i800 %r14, 32
%r20 = getelementptr i32, i32* %r2, i32 1
%r21 = trunc i800 %r18 to i32
store i32 %r21, i32* %r20
%r22 = lshr i800 %r18, 32
%r24 = getelementptr i32, i32* %r2, i32 2
%r25 = trunc i800 %r22 to i32
store i32 %r25, i32* %r24
%r26 = lshr i800 %r22, 32
%r28 = getelementptr i32, i32* %r2, i32 3
%r29 = trunc i800 %r26 to i32
store i32 %r29, i32* %r28
%r30 = lshr i800 %r26, 32
%r32 = getelementptr i32, i32* %r2, i32 4
%r33 = trunc i800 %r30 to i32
store i32 %r33, i32* %r32
%r34 = lshr i800 %r30, 32
%r36 = getelementptr i32, i32* %r2, i32 5
%r37 = trunc i800 %r34 to i32
store i32 %r37, i32* %r36
%r38 = lshr i800 %r34, 32
%r40 = getelementptr i32, i32* %r2, i32 6
%r41 = trunc i800 %r38 to i32
store i32 %r41, i32* %r40
%r42 = lshr i800 %r38, 32
%r44 = getelementptr i32, i32* %r2, i32 7
%r45 = trunc i800 %r42 to i32
store i32 %r45, i32* %r44
%r46 = lshr i800 %r42, 32
%r48 = getelementptr i32, i32* %r2, i32 8
%r49 = trunc i800 %r46 to i32
store i32 %r49, i32* %r48
%r50 = lshr i800 %r46, 32
%r52 = getelementptr i32, i32* %r2, i32 9
%r53 = trunc i800 %r50 to i32
store i32 %r53, i32* %r52
%r54 = lshr i800 %r50, 32
%r56 = getelementptr i32, i32* %r2, i32 10
%r57 = trunc i800 %r54 to i32
store i32 %r57, i32* %r56
%r58 = lshr i800 %r54, 32
%r60 = getelementptr i32, i32* %r2, i32 11
%r61 = trunc i800 %r58 to i32
store i32 %r61, i32* %r60
%r62 = lshr i800 %r58, 32
%r64 = getelementptr i32, i32* %r2, i32 12
%r65 = trunc i800 %r62 to i32
store i32 %r65, i32* %r64
%r66 = lshr i800 %r62, 32
%r68 = getelementptr i32, i32* %r2, i32 13
%r69 = trunc i800 %r66 to i32
store i32 %r69, i32* %r68
%r70 = lshr i800 %r66, 32
%r72 = getelementptr i32, i32* %r2, i32 14
%r73 = trunc i800 %r70 to i32
store i32 %r73, i32* %r72
%r74 = lshr i800 %r70, 32
%r76 = getelementptr i32, i32* %r2, i32 15
%r77 = trunc i800 %r74 to i32
store i32 %r77, i32* %r76
%r78 = lshr i800 %r74, 32
%r80 = getelementptr i32, i32* %r2, i32 16
%r81 = trunc i800 %r78 to i32
store i32 %r81, i32* %r80
%r82 = lshr i800 %r78, 32
%r84 = getelementptr i32, i32* %r2, i32 17
%r85 = trunc i800 %r82 to i32
store i32 %r85, i32* %r84
%r86 = lshr i800 %r82, 32
%r88 = getelementptr i32, i32* %r2, i32 18
%r89 = trunc i800 %r86 to i32
store i32 %r89, i32* %r88
%r90 = lshr i800 %r86, 32
%r92 = getelementptr i32, i32* %r2, i32 19
%r93 = trunc i800 %r90 to i32
store i32 %r93, i32* %r92
%r94 = lshr i800 %r90, 32
%r96 = getelementptr i32, i32* %r2, i32 20
%r97 = trunc i800 %r94 to i32
store i32 %r97, i32* %r96
%r98 = lshr i800 %r94, 32
%r100 = getelementptr i32, i32* %r2, i32 21
%r101 = trunc i800 %r98 to i32
store i32 %r101, i32* %r100
%r102 = lshr i800 %r98, 32
%r104 = getelementptr i32, i32* %r2, i32 22
%r105 = trunc i800 %r102 to i32
store i32 %r105, i32* %r104
%r106 = lshr i800 %r102, 32
%r108 = getelementptr i32, i32* %r2, i32 23
%r109 = trunc i800 %r106 to i32
store i32 %r109, i32* %r108
%r110 = lshr i800 %r106, 32
%r112 = getelementptr i32, i32* %r2, i32 24
%r113 = trunc i800 %r110 to i32
store i32 %r113, i32* %r112
%r114 = lshr i832 %r13, 800
%r115 = trunc i832 %r114 to i32
%r117 = and i32 %r115, 1
ret i32 %r117
}
define void @mclb_addNF25(i32* noalias  %r1, i32* noalias  %r2, i32* noalias  %r3)
{
%r5 = bitcast i32* %r2 to i800*
%r6 = load i800, i800* %r5
%r8 = bitcast i32* %r3 to i800*
%r9 = load i800, i800* %r8
%r10 = add i800 %r6, %r9
%r12 = getelementptr i32, i32* %r1, i32 0
%r13 = trunc i800 %r10 to i32
store i32 %r13, i32* %r12
%r14 = lshr i800 %r10, 32
%r16 = getelementptr i32, i32* %r1, i32 1
%r17 = trunc i800 %r14 to i32
store i32 %r17, i32* %r16
%r18 = lshr i800 %r14, 32
%r20 = getelementptr i32, i32* %r1, i32 2
%r21 = trunc i800 %r18 to i32
store i32 %r21, i32* %r20
%r22 = lshr i800 %r18, 32
%r24 = getelementptr i32, i32* %r1, i32 3
%r25 = trunc i800 %r22 to i32
store i32 %r25, i32* %r24
%r26 = lshr i800 %r22, 32
%r28 = getelementptr i32, i32* %r1, i32 4
%r29 = trunc i800 %r26 to i32
store i32 %r29, i32* %r28
%r30 = lshr i800 %r26, 32
%r32 = getelementptr i32, i32* %r1, i32 5
%r33 = trunc i800 %r30 to i32
store i32 %r33, i32* %r32
%r34 = lshr i800 %r30, 32
%r36 = getelementptr i32, i32* %r1, i32 6
%r37 = trunc i800 %r34 to i32
store i32 %r37, i32* %r36
%r38 = lshr i800 %r34, 32
%r40 = getelementptr i32, i32* %r1, i32 7
%r41 = trunc i800 %r38 to i32
store i32 %r41, i32* %r40
%r42 = lshr i800 %r38, 32
%r44 = getelementptr i32, i32* %r1, i32 8
%r45 = trunc i800 %r42 to i32
store i32 %r45, i32* %r44
%r46 = lshr i800 %r42, 32
%r48 = getelementptr i32, i32* %r1, i32 9
%r49 = trunc i800 %r46 to i32
store i32 %r49, i32* %r48
%r50 = lshr i800 %r46, 32
%r52 = getelementptr i32, i32* %r1, i32 10
%r53 = trunc i800 %r50 to i32
store i32 %r53, i32* %r52
%r54 = lshr i800 %r50, 32
%r56 = getelementptr i32, i32* %r1, i32 11
%r57 = trunc i800 %r54 to i32
store i32 %r57, i32* %r56
%r58 = lshr i800 %r54, 32
%r60 = getelementptr i32, i32* %r1, i32 12
%r61 = trunc i800 %r58 to i32
store i32 %r61, i32* %r60
%r62 = lshr i800 %r58, 32
%r64 = getelementptr i32, i32* %r1, i32 13
%r65 = trunc i800 %r62 to i32
store i32 %r65, i32* %r64
%r66 = lshr i800 %r62, 32
%r68 = getelementptr i32, i32* %r1, i32 14
%r69 = trunc i800 %r66 to i32
store i32 %r69, i32* %r68
%r70 = lshr i800 %r66, 32
%r72 = getelementptr i32, i32* %r1, i32 15
%r73 = trunc i800 %r70 to i32
store i32 %r73, i32* %r72
%r74 = lshr i800 %r70, 32
%r76 = getelementptr i32, i32* %r1, i32 16
%r77 = trunc i800 %r74 to i32
store i32 %r77, i32* %r76
%r78 = lshr i800 %r74, 32
%r80 = getelementptr i32, i32* %r1, i32 17
%r81 = trunc i800 %r78 to i32
store i32 %r81, i32* %r80
%r82 = lshr i800 %r78, 32
%r84 = getelementptr i32, i32* %r1, i32 18
%r85 = trunc i800 %r82 to i32
store i32 %r85, i32* %r84
%r86 = lshr i800 %r82, 32
%r88 = getelementptr i32, i32* %r1, i32 19
%r89 = trunc i800 %r86 to i32
store i32 %r89, i32* %r88
%r90 = lshr i800 %r86, 32
%r92 = getelementptr i32, i32* %r1, i32 20
%r93 = trunc i800 %r90 to i32
store i32 %r93, i32* %r92
%r94 = lshr i800 %r90, 32
%r96 = getelementptr i32, i32* %r1, i32 21
%r97 = trunc i800 %r94 to i32
store i32 %r97, i32* %r96
%r98 = lshr i800 %r94, 32
%r100 = getelementptr i32, i32* %r1, i32 22
%r101 = trunc i800 %r98 to i32
store i32 %r101, i32* %r100
%r102 = lshr i800 %r98, 32
%r104 = getelementptr i32, i32* %r1, i32 23
%r105 = trunc i800 %r102 to i32
store i32 %r105, i32* %r104
%r106 = lshr i800 %r102, 32
%r108 = getelementptr i32, i32* %r1, i32 24
%r109 = trunc i800 %r106 to i32
store i32 %r109, i32* %r108
ret void
}
define i32 @mclb_subNF25(i32* noalias  %r2, i32* noalias  %r3, i32* noalias  %r4)
{
%r6 = bitcast i32* %r3 to i800*
%r7 = load i800, i800* %r6
%r9 = bitcast i32* %r4 to i800*
%r10 = load i800, i800* %r9
%r11 = sub i800 %r7, %r10
%r13 = getelementptr i32, i32* %r2, i32 0
%r14 = trunc i800 %r11 to i32
store i32 %r14, i32* %r13
%r15 = lshr i800 %r11, 32
%r17 = getelementptr i32, i32* %r2, i32 1
%r18 = trunc i800 %r15 to i32
store i32 %r18, i32* %r17
%r19 = lshr i800 %r15, 32
%r21 = getelementptr i32, i32* %r2, i32 2
%r22 = trunc i800 %r19 to i32
store i32 %r22, i32* %r21
%r23 = lshr i800 %r19, 32
%r25 = getelementptr i32, i32* %r2, i32 3
%r26 = trunc i800 %r23 to i32
store i32 %r26, i32* %r25
%r27 = lshr i800 %r23, 32
%r29 = getelementptr i32, i32* %r2, i32 4
%r30 = trunc i800 %r27 to i32
store i32 %r30, i32* %r29
%r31 = lshr i800 %r27, 32
%r33 = getelementptr i32, i32* %r2, i32 5
%r34 = trunc i800 %r31 to i32
store i32 %r34, i32* %r33
%r35 = lshr i800 %r31, 32
%r37 = getelementptr i32, i32* %r2, i32 6
%r38 = trunc i800 %r35 to i32
store i32 %r38, i32* %r37
%r39 = lshr i800 %r35, 32
%r41 = getelementptr i32, i32* %r2, i32 7
%r42 = trunc i800 %r39 to i32
store i32 %r42, i32* %r41
%r43 = lshr i800 %r39, 32
%r45 = getelementptr i32, i32* %r2, i32 8
%r46 = trunc i800 %r43 to i32
store i32 %r46, i32* %r45
%r47 = lshr i800 %r43, 32
%r49 = getelementptr i32, i32* %r2, i32 9
%r50 = trunc i800 %r47 to i32
store i32 %r50, i32* %r49
%r51 = lshr i800 %r47, 32
%r53 = getelementptr i32, i32* %r2, i32 10
%r54 = trunc i800 %r51 to i32
store i32 %r54, i32* %r53
%r55 = lshr i800 %r51, 32
%r57 = getelementptr i32, i32* %r2, i32 11
%r58 = trunc i800 %r55 to i32
store i32 %r58, i32* %r57
%r59 = lshr i800 %r55, 32
%r61 = getelementptr i32, i32* %r2, i32 12
%r62 = trunc i800 %r59 to i32
store i32 %r62, i32* %r61
%r63 = lshr i800 %r59, 32
%r65 = getelementptr i32, i32* %r2, i32 13
%r66 = trunc i800 %r63 to i32
store i32 %r66, i32* %r65
%r67 = lshr i800 %r63, 32
%r69 = getelementptr i32, i32* %r2, i32 14
%r70 = trunc i800 %r67 to i32
store i32 %r70, i32* %r69
%r71 = lshr i800 %r67, 32
%r73 = getelementptr i32, i32* %r2, i32 15
%r74 = trunc i800 %r71 to i32
store i32 %r74, i32* %r73
%r75 = lshr i800 %r71, 32
%r77 = getelementptr i32, i32* %r2, i32 16
%r78 = trunc i800 %r75 to i32
store i32 %r78, i32* %r77
%r79 = lshr i800 %r75, 32
%r81 = getelementptr i32, i32* %r2, i32 17
%r82 = trunc i800 %r79 to i32
store i32 %r82, i32* %r81
%r83 = lshr i800 %r79, 32
%r85 = getelementptr i32, i32* %r2, i32 18
%r86 = trunc i800 %r83 to i32
store i32 %r86, i32* %r85
%r87 = lshr i800 %r83, 32
%r89 = getelementptr i32, i32* %r2, i32 19
%r90 = trunc i800 %r87 to i32
store i32 %r90, i32* %r89
%r91 = lshr i800 %r87, 32
%r93 = getelementptr i32, i32* %r2, i32 20
%r94 = trunc i800 %r91 to i32
store i32 %r94, i32* %r93
%r95 = lshr i800 %r91, 32
%r97 = getelementptr i32, i32* %r2, i32 21
%r98 = trunc i800 %r95 to i32
store i32 %r98, i32* %r97
%r99 = lshr i800 %r95, 32
%r101 = getelementptr i32, i32* %r2, i32 22
%r102 = trunc i800 %r99 to i32
store i32 %r102, i32* %r101
%r103 = lshr i800 %r99, 32
%r105 = getelementptr i32, i32* %r2, i32 23
%r106 = trunc i800 %r103 to i32
store i32 %r106, i32* %r105
%r107 = lshr i800 %r103, 32
%r109 = getelementptr i32, i32* %r2, i32 24
%r110 = trunc i800 %r107 to i32
store i32 %r110, i32* %r109
%r111 = lshr i800 %r11, 799
%r112 = trunc i800 %r111 to i32
%r114 = and i32 %r112, 1
ret i32 %r114
}
define i32 @mclb_add26(i32* noalias  %r2, i32* noalias  %r3, i32* noalias  %r4)
{
%r6 = bitcast i32* %r3 to i832*
%r7 = load i832, i832* %r6
%r8 = zext i832 %r7 to i864
%r10 = bitcast i32* %r4 to i832*
%r11 = load i832, i832* %r10
%r12 = zext i832 %r11 to i864
%r13 = add i864 %r8, %r12
%r14 = trunc i864 %r13 to i832
%r16 = getelementptr i32, i32* %r2, i32 0
%r17 = trunc i832 %r14 to i32
store i32 %r17, i32* %r16
%r18 = lshr i832 %r14, 32
%r20 = getelementptr i32, i32* %r2, i32 1
%r21 = trunc i832 %r18 to i32
store i32 %r21, i32* %r20
%r22 = lshr i832 %r18, 32
%r24 = getelementptr i32, i32* %r2, i32 2
%r25 = trunc i832 %r22 to i32
store i32 %r25, i32* %r24
%r26 = lshr i832 %r22, 32
%r28 = getelementptr i32, i32* %r2, i32 3
%r29 = trunc i832 %r26 to i32
store i32 %r29, i32* %r28
%r30 = lshr i832 %r26, 32
%r32 = getelementptr i32, i32* %r2, i32 4
%r33 = trunc i832 %r30 to i32
store i32 %r33, i32* %r32
%r34 = lshr i832 %r30, 32
%r36 = getelementptr i32, i32* %r2, i32 5
%r37 = trunc i832 %r34 to i32
store i32 %r37, i32* %r36
%r38 = lshr i832 %r34, 32
%r40 = getelementptr i32, i32* %r2, i32 6
%r41 = trunc i832 %r38 to i32
store i32 %r41, i32* %r40
%r42 = lshr i832 %r38, 32
%r44 = getelementptr i32, i32* %r2, i32 7
%r45 = trunc i832 %r42 to i32
store i32 %r45, i32* %r44
%r46 = lshr i832 %r42, 32
%r48 = getelementptr i32, i32* %r2, i32 8
%r49 = trunc i832 %r46 to i32
store i32 %r49, i32* %r48
%r50 = lshr i832 %r46, 32
%r52 = getelementptr i32, i32* %r2, i32 9
%r53 = trunc i832 %r50 to i32
store i32 %r53, i32* %r52
%r54 = lshr i832 %r50, 32
%r56 = getelementptr i32, i32* %r2, i32 10
%r57 = trunc i832 %r54 to i32
store i32 %r57, i32* %r56
%r58 = lshr i832 %r54, 32
%r60 = getelementptr i32, i32* %r2, i32 11
%r61 = trunc i832 %r58 to i32
store i32 %r61, i32* %r60
%r62 = lshr i832 %r58, 32
%r64 = getelementptr i32, i32* %r2, i32 12
%r65 = trunc i832 %r62 to i32
store i32 %r65, i32* %r64
%r66 = lshr i832 %r62, 32
%r68 = getelementptr i32, i32* %r2, i32 13
%r69 = trunc i832 %r66 to i32
store i32 %r69, i32* %r68
%r70 = lshr i832 %r66, 32
%r72 = getelementptr i32, i32* %r2, i32 14
%r73 = trunc i832 %r70 to i32
store i32 %r73, i32* %r72
%r74 = lshr i832 %r70, 32
%r76 = getelementptr i32, i32* %r2, i32 15
%r77 = trunc i832 %r74 to i32
store i32 %r77, i32* %r76
%r78 = lshr i832 %r74, 32
%r80 = getelementptr i32, i32* %r2, i32 16
%r81 = trunc i832 %r78 to i32
store i32 %r81, i32* %r80
%r82 = lshr i832 %r78, 32
%r84 = getelementptr i32, i32* %r2, i32 17
%r85 = trunc i832 %r82 to i32
store i32 %r85, i32* %r84
%r86 = lshr i832 %r82, 32
%r88 = getelementptr i32, i32* %r2, i32 18
%r89 = trunc i832 %r86 to i32
store i32 %r89, i32* %r88
%r90 = lshr i832 %r86, 32
%r92 = getelementptr i32, i32* %r2, i32 19
%r93 = trunc i832 %r90 to i32
store i32 %r93, i32* %r92
%r94 = lshr i832 %r90, 32
%r96 = getelementptr i32, i32* %r2, i32 20
%r97 = trunc i832 %r94 to i32
store i32 %r97, i32* %r96
%r98 = lshr i832 %r94, 32
%r100 = getelementptr i32, i32* %r2, i32 21
%r101 = trunc i832 %r98 to i32
store i32 %r101, i32* %r100
%r102 = lshr i832 %r98, 32
%r104 = getelementptr i32, i32* %r2, i32 22
%r105 = trunc i832 %r102 to i32
store i32 %r105, i32* %r104
%r106 = lshr i832 %r102, 32
%r108 = getelementptr i32, i32* %r2, i32 23
%r109 = trunc i832 %r106 to i32
store i32 %r109, i32* %r108
%r110 = lshr i832 %r106, 32
%r112 = getelementptr i32, i32* %r2, i32 24
%r113 = trunc i832 %r110 to i32
store i32 %r113, i32* %r112
%r114 = lshr i832 %r110, 32
%r116 = getelementptr i32, i32* %r2, i32 25
%r117 = trunc i832 %r114 to i32
store i32 %r117, i32* %r116
%r118 = lshr i864 %r13, 832
%r119 = trunc i864 %r118 to i32
ret i32 %r119
}
define i32 @mclb_sub26(i32* noalias  %r2, i32* noalias  %r3, i32* noalias  %r4)
{
%r6 = bitcast i32* %r3 to i832*
%r7 = load i832, i832* %r6
%r8 = zext i832 %r7 to i864
%r10 = bitcast i32* %r4 to i832*
%r11 = load i832, i832* %r10
%r12 = zext i832 %r11 to i864
%r13 = sub i864 %r8, %r12
%r14 = trunc i864 %r13 to i832
%r16 = getelementptr i32, i32* %r2, i32 0
%r17 = trunc i832 %r14 to i32
store i32 %r17, i32* %r16
%r18 = lshr i832 %r14, 32
%r20 = getelementptr i32, i32* %r2, i32 1
%r21 = trunc i832 %r18 to i32
store i32 %r21, i32* %r20
%r22 = lshr i832 %r18, 32
%r24 = getelementptr i32, i32* %r2, i32 2
%r25 = trunc i832 %r22 to i32
store i32 %r25, i32* %r24
%r26 = lshr i832 %r22, 32
%r28 = getelementptr i32, i32* %r2, i32 3
%r29 = trunc i832 %r26 to i32
store i32 %r29, i32* %r28
%r30 = lshr i832 %r26, 32
%r32 = getelementptr i32, i32* %r2, i32 4
%r33 = trunc i832 %r30 to i32
store i32 %r33, i32* %r32
%r34 = lshr i832 %r30, 32
%r36 = getelementptr i32, i32* %r2, i32 5
%r37 = trunc i832 %r34 to i32
store i32 %r37, i32* %r36
%r38 = lshr i832 %r34, 32
%r40 = getelementptr i32, i32* %r2, i32 6
%r41 = trunc i832 %r38 to i32
store i32 %r41, i32* %r40
%r42 = lshr i832 %r38, 32
%r44 = getelementptr i32, i32* %r2, i32 7
%r45 = trunc i832 %r42 to i32
store i32 %r45, i32* %r44
%r46 = lshr i832 %r42, 32
%r48 = getelementptr i32, i32* %r2, i32 8
%r49 = trunc i832 %r46 to i32
store i32 %r49, i32* %r48
%r50 = lshr i832 %r46, 32
%r52 = getelementptr i32, i32* %r2, i32 9
%r53 = trunc i832 %r50 to i32
store i32 %r53, i32* %r52
%r54 = lshr i832 %r50, 32
%r56 = getelementptr i32, i32* %r2, i32 10
%r57 = trunc i832 %r54 to i32
store i32 %r57, i32* %r56
%r58 = lshr i832 %r54, 32
%r60 = getelementptr i32, i32* %r2, i32 11
%r61 = trunc i832 %r58 to i32
store i32 %r61, i32* %r60
%r62 = lshr i832 %r58, 32
%r64 = getelementptr i32, i32* %r2, i32 12
%r65 = trunc i832 %r62 to i32
store i32 %r65, i32* %r64
%r66 = lshr i832 %r62, 32
%r68 = getelementptr i32, i32* %r2, i32 13
%r69 = trunc i832 %r66 to i32
store i32 %r69, i32* %r68
%r70 = lshr i832 %r66, 32
%r72 = getelementptr i32, i32* %r2, i32 14
%r73 = trunc i832 %r70 to i32
store i32 %r73, i32* %r72
%r74 = lshr i832 %r70, 32
%r76 = getelementptr i32, i32* %r2, i32 15
%r77 = trunc i832 %r74 to i32
store i32 %r77, i32* %r76
%r78 = lshr i832 %r74, 32
%r80 = getelementptr i32, i32* %r2, i32 16
%r81 = trunc i832 %r78 to i32
store i32 %r81, i32* %r80
%r82 = lshr i832 %r78, 32
%r84 = getelementptr i32, i32* %r2, i32 17
%r85 = trunc i832 %r82 to i32
store i32 %r85, i32* %r84
%r86 = lshr i832 %r82, 32
%r88 = getelementptr i32, i32* %r2, i32 18
%r89 = trunc i832 %r86 to i32
store i32 %r89, i32* %r88
%r90 = lshr i832 %r86, 32
%r92 = getelementptr i32, i32* %r2, i32 19
%r93 = trunc i832 %r90 to i32
store i32 %r93, i32* %r92
%r94 = lshr i832 %r90, 32
%r96 = getelementptr i32, i32* %r2, i32 20
%r97 = trunc i832 %r94 to i32
store i32 %r97, i32* %r96
%r98 = lshr i832 %r94, 32
%r100 = getelementptr i32, i32* %r2, i32 21
%r101 = trunc i832 %r98 to i32
store i32 %r101, i32* %r100
%r102 = lshr i832 %r98, 32
%r104 = getelementptr i32, i32* %r2, i32 22
%r105 = trunc i832 %r102 to i32
store i32 %r105, i32* %r104
%r106 = lshr i832 %r102, 32
%r108 = getelementptr i32, i32* %r2, i32 23
%r109 = trunc i832 %r106 to i32
store i32 %r109, i32* %r108
%r110 = lshr i832 %r106, 32
%r112 = getelementptr i32, i32* %r2, i32 24
%r113 = trunc i832 %r110 to i32
store i32 %r113, i32* %r112
%r114 = lshr i832 %r110, 32
%r116 = getelementptr i32, i32* %r2, i32 25
%r117 = trunc i832 %r114 to i32
store i32 %r117, i32* %r116
%r118 = lshr i864 %r13, 832
%r119 = trunc i864 %r118 to i32
%r121 = and i32 %r119, 1
ret i32 %r121
}
define void @mclb_addNF26(i32* noalias  %r1, i32* noalias  %r2, i32* noalias  %r3)
{
%r5 = bitcast i32* %r2 to i832*
%r6 = load i832, i832* %r5
%r8 = bitcast i32* %r3 to i832*
%r9 = load i832, i832* %r8
%r10 = add i832 %r6, %r9
%r12 = getelementptr i32, i32* %r1, i32 0
%r13 = trunc i832 %r10 to i32
store i32 %r13, i32* %r12
%r14 = lshr i832 %r10, 32
%r16 = getelementptr i32, i32* %r1, i32 1
%r17 = trunc i832 %r14 to i32
store i32 %r17, i32* %r16
%r18 = lshr i832 %r14, 32
%r20 = getelementptr i32, i32* %r1, i32 2
%r21 = trunc i832 %r18 to i32
store i32 %r21, i32* %r20
%r22 = lshr i832 %r18, 32
%r24 = getelementptr i32, i32* %r1, i32 3
%r25 = trunc i832 %r22 to i32
store i32 %r25, i32* %r24
%r26 = lshr i832 %r22, 32
%r28 = getelementptr i32, i32* %r1, i32 4
%r29 = trunc i832 %r26 to i32
store i32 %r29, i32* %r28
%r30 = lshr i832 %r26, 32
%r32 = getelementptr i32, i32* %r1, i32 5
%r33 = trunc i832 %r30 to i32
store i32 %r33, i32* %r32
%r34 = lshr i832 %r30, 32
%r36 = getelementptr i32, i32* %r1, i32 6
%r37 = trunc i832 %r34 to i32
store i32 %r37, i32* %r36
%r38 = lshr i832 %r34, 32
%r40 = getelementptr i32, i32* %r1, i32 7
%r41 = trunc i832 %r38 to i32
store i32 %r41, i32* %r40
%r42 = lshr i832 %r38, 32
%r44 = getelementptr i32, i32* %r1, i32 8
%r45 = trunc i832 %r42 to i32
store i32 %r45, i32* %r44
%r46 = lshr i832 %r42, 32
%r48 = getelementptr i32, i32* %r1, i32 9
%r49 = trunc i832 %r46 to i32
store i32 %r49, i32* %r48
%r50 = lshr i832 %r46, 32
%r52 = getelementptr i32, i32* %r1, i32 10
%r53 = trunc i832 %r50 to i32
store i32 %r53, i32* %r52
%r54 = lshr i832 %r50, 32
%r56 = getelementptr i32, i32* %r1, i32 11
%r57 = trunc i832 %r54 to i32
store i32 %r57, i32* %r56
%r58 = lshr i832 %r54, 32
%r60 = getelementptr i32, i32* %r1, i32 12
%r61 = trunc i832 %r58 to i32
store i32 %r61, i32* %r60
%r62 = lshr i832 %r58, 32
%r64 = getelementptr i32, i32* %r1, i32 13
%r65 = trunc i832 %r62 to i32
store i32 %r65, i32* %r64
%r66 = lshr i832 %r62, 32
%r68 = getelementptr i32, i32* %r1, i32 14
%r69 = trunc i832 %r66 to i32
store i32 %r69, i32* %r68
%r70 = lshr i832 %r66, 32
%r72 = getelementptr i32, i32* %r1, i32 15
%r73 = trunc i832 %r70 to i32
store i32 %r73, i32* %r72
%r74 = lshr i832 %r70, 32
%r76 = getelementptr i32, i32* %r1, i32 16
%r77 = trunc i832 %r74 to i32
store i32 %r77, i32* %r76
%r78 = lshr i832 %r74, 32
%r80 = getelementptr i32, i32* %r1, i32 17
%r81 = trunc i832 %r78 to i32
store i32 %r81, i32* %r80
%r82 = lshr i832 %r78, 32
%r84 = getelementptr i32, i32* %r1, i32 18
%r85 = trunc i832 %r82 to i32
store i32 %r85, i32* %r84
%r86 = lshr i832 %r82, 32
%r88 = getelementptr i32, i32* %r1, i32 19
%r89 = trunc i832 %r86 to i32
store i32 %r89, i32* %r88
%r90 = lshr i832 %r86, 32
%r92 = getelementptr i32, i32* %r1, i32 20
%r93 = trunc i832 %r90 to i32
store i32 %r93, i32* %r92
%r94 = lshr i832 %r90, 32
%r96 = getelementptr i32, i32* %r1, i32 21
%r97 = trunc i832 %r94 to i32
store i32 %r97, i32* %r96
%r98 = lshr i832 %r94, 32
%r100 = getelementptr i32, i32* %r1, i32 22
%r101 = trunc i832 %r98 to i32
store i32 %r101, i32* %r100
%r102 = lshr i832 %r98, 32
%r104 = getelementptr i32, i32* %r1, i32 23
%r105 = trunc i832 %r102 to i32
store i32 %r105, i32* %r104
%r106 = lshr i832 %r102, 32
%r108 = getelementptr i32, i32* %r1, i32 24
%r109 = trunc i832 %r106 to i32
store i32 %r109, i32* %r108
%r110 = lshr i832 %r106, 32
%r112 = getelementptr i32, i32* %r1, i32 25
%r113 = trunc i832 %r110 to i32
store i32 %r113, i32* %r112
ret void
}
define i32 @mclb_subNF26(i32* noalias  %r2, i32* noalias  %r3, i32* noalias  %r4)
{
%r6 = bitcast i32* %r3 to i832*
%r7 = load i832, i832* %r6
%r9 = bitcast i32* %r4 to i832*
%r10 = load i832, i832* %r9
%r11 = sub i832 %r7, %r10
%r13 = getelementptr i32, i32* %r2, i32 0
%r14 = trunc i832 %r11 to i32
store i32 %r14, i32* %r13
%r15 = lshr i832 %r11, 32
%r17 = getelementptr i32, i32* %r2, i32 1
%r18 = trunc i832 %r15 to i32
store i32 %r18, i32* %r17
%r19 = lshr i832 %r15, 32
%r21 = getelementptr i32, i32* %r2, i32 2
%r22 = trunc i832 %r19 to i32
store i32 %r22, i32* %r21
%r23 = lshr i832 %r19, 32
%r25 = getelementptr i32, i32* %r2, i32 3
%r26 = trunc i832 %r23 to i32
store i32 %r26, i32* %r25
%r27 = lshr i832 %r23, 32
%r29 = getelementptr i32, i32* %r2, i32 4
%r30 = trunc i832 %r27 to i32
store i32 %r30, i32* %r29
%r31 = lshr i832 %r27, 32
%r33 = getelementptr i32, i32* %r2, i32 5
%r34 = trunc i832 %r31 to i32
store i32 %r34, i32* %r33
%r35 = lshr i832 %r31, 32
%r37 = getelementptr i32, i32* %r2, i32 6
%r38 = trunc i832 %r35 to i32
store i32 %r38, i32* %r37
%r39 = lshr i832 %r35, 32
%r41 = getelementptr i32, i32* %r2, i32 7
%r42 = trunc i832 %r39 to i32
store i32 %r42, i32* %r41
%r43 = lshr i832 %r39, 32
%r45 = getelementptr i32, i32* %r2, i32 8
%r46 = trunc i832 %r43 to i32
store i32 %r46, i32* %r45
%r47 = lshr i832 %r43, 32
%r49 = getelementptr i32, i32* %r2, i32 9
%r50 = trunc i832 %r47 to i32
store i32 %r50, i32* %r49
%r51 = lshr i832 %r47, 32
%r53 = getelementptr i32, i32* %r2, i32 10
%r54 = trunc i832 %r51 to i32
store i32 %r54, i32* %r53
%r55 = lshr i832 %r51, 32
%r57 = getelementptr i32, i32* %r2, i32 11
%r58 = trunc i832 %r55 to i32
store i32 %r58, i32* %r57
%r59 = lshr i832 %r55, 32
%r61 = getelementptr i32, i32* %r2, i32 12
%r62 = trunc i832 %r59 to i32
store i32 %r62, i32* %r61
%r63 = lshr i832 %r59, 32
%r65 = getelementptr i32, i32* %r2, i32 13
%r66 = trunc i832 %r63 to i32
store i32 %r66, i32* %r65
%r67 = lshr i832 %r63, 32
%r69 = getelementptr i32, i32* %r2, i32 14
%r70 = trunc i832 %r67 to i32
store i32 %r70, i32* %r69
%r71 = lshr i832 %r67, 32
%r73 = getelementptr i32, i32* %r2, i32 15
%r74 = trunc i832 %r71 to i32
store i32 %r74, i32* %r73
%r75 = lshr i832 %r71, 32
%r77 = getelementptr i32, i32* %r2, i32 16
%r78 = trunc i832 %r75 to i32
store i32 %r78, i32* %r77
%r79 = lshr i832 %r75, 32
%r81 = getelementptr i32, i32* %r2, i32 17
%r82 = trunc i832 %r79 to i32
store i32 %r82, i32* %r81
%r83 = lshr i832 %r79, 32
%r85 = getelementptr i32, i32* %r2, i32 18
%r86 = trunc i832 %r83 to i32
store i32 %r86, i32* %r85
%r87 = lshr i832 %r83, 32
%r89 = getelementptr i32, i32* %r2, i32 19
%r90 = trunc i832 %r87 to i32
store i32 %r90, i32* %r89
%r91 = lshr i832 %r87, 32
%r93 = getelementptr i32, i32* %r2, i32 20
%r94 = trunc i832 %r91 to i32
store i32 %r94, i32* %r93
%r95 = lshr i832 %r91, 32
%r97 = getelementptr i32, i32* %r2, i32 21
%r98 = trunc i832 %r95 to i32
store i32 %r98, i32* %r97
%r99 = lshr i832 %r95, 32
%r101 = getelementptr i32, i32* %r2, i32 22
%r102 = trunc i832 %r99 to i32
store i32 %r102, i32* %r101
%r103 = lshr i832 %r99, 32
%r105 = getelementptr i32, i32* %r2, i32 23
%r106 = trunc i832 %r103 to i32
store i32 %r106, i32* %r105
%r107 = lshr i832 %r103, 32
%r109 = getelementptr i32, i32* %r2, i32 24
%r110 = trunc i832 %r107 to i32
store i32 %r110, i32* %r109
%r111 = lshr i832 %r107, 32
%r113 = getelementptr i32, i32* %r2, i32 25
%r114 = trunc i832 %r111 to i32
store i32 %r114, i32* %r113
%r115 = lshr i832 %r11, 831
%r116 = trunc i832 %r115 to i32
%r118 = and i32 %r116, 1
ret i32 %r118
}
define i32 @mclb_add27(i32* noalias  %r2, i32* noalias  %r3, i32* noalias  %r4)
{
%r6 = bitcast i32* %r3 to i864*
%r7 = load i864, i864* %r6
%r8 = zext i864 %r7 to i896
%r10 = bitcast i32* %r4 to i864*
%r11 = load i864, i864* %r10
%r12 = zext i864 %r11 to i896
%r13 = add i896 %r8, %r12
%r14 = trunc i896 %r13 to i864
%r16 = getelementptr i32, i32* %r2, i32 0
%r17 = trunc i864 %r14 to i32
store i32 %r17, i32* %r16
%r18 = lshr i864 %r14, 32
%r20 = getelementptr i32, i32* %r2, i32 1
%r21 = trunc i864 %r18 to i32
store i32 %r21, i32* %r20
%r22 = lshr i864 %r18, 32
%r24 = getelementptr i32, i32* %r2, i32 2
%r25 = trunc i864 %r22 to i32
store i32 %r25, i32* %r24
%r26 = lshr i864 %r22, 32
%r28 = getelementptr i32, i32* %r2, i32 3
%r29 = trunc i864 %r26 to i32
store i32 %r29, i32* %r28
%r30 = lshr i864 %r26, 32
%r32 = getelementptr i32, i32* %r2, i32 4
%r33 = trunc i864 %r30 to i32
store i32 %r33, i32* %r32
%r34 = lshr i864 %r30, 32
%r36 = getelementptr i32, i32* %r2, i32 5
%r37 = trunc i864 %r34 to i32
store i32 %r37, i32* %r36
%r38 = lshr i864 %r34, 32
%r40 = getelementptr i32, i32* %r2, i32 6
%r41 = trunc i864 %r38 to i32
store i32 %r41, i32* %r40
%r42 = lshr i864 %r38, 32
%r44 = getelementptr i32, i32* %r2, i32 7
%r45 = trunc i864 %r42 to i32
store i32 %r45, i32* %r44
%r46 = lshr i864 %r42, 32
%r48 = getelementptr i32, i32* %r2, i32 8
%r49 = trunc i864 %r46 to i32
store i32 %r49, i32* %r48
%r50 = lshr i864 %r46, 32
%r52 = getelementptr i32, i32* %r2, i32 9
%r53 = trunc i864 %r50 to i32
store i32 %r53, i32* %r52
%r54 = lshr i864 %r50, 32
%r56 = getelementptr i32, i32* %r2, i32 10
%r57 = trunc i864 %r54 to i32
store i32 %r57, i32* %r56
%r58 = lshr i864 %r54, 32
%r60 = getelementptr i32, i32* %r2, i32 11
%r61 = trunc i864 %r58 to i32
store i32 %r61, i32* %r60
%r62 = lshr i864 %r58, 32
%r64 = getelementptr i32, i32* %r2, i32 12
%r65 = trunc i864 %r62 to i32
store i32 %r65, i32* %r64
%r66 = lshr i864 %r62, 32
%r68 = getelementptr i32, i32* %r2, i32 13
%r69 = trunc i864 %r66 to i32
store i32 %r69, i32* %r68
%r70 = lshr i864 %r66, 32
%r72 = getelementptr i32, i32* %r2, i32 14
%r73 = trunc i864 %r70 to i32
store i32 %r73, i32* %r72
%r74 = lshr i864 %r70, 32
%r76 = getelementptr i32, i32* %r2, i32 15
%r77 = trunc i864 %r74 to i32
store i32 %r77, i32* %r76
%r78 = lshr i864 %r74, 32
%r80 = getelementptr i32, i32* %r2, i32 16
%r81 = trunc i864 %r78 to i32
store i32 %r81, i32* %r80
%r82 = lshr i864 %r78, 32
%r84 = getelementptr i32, i32* %r2, i32 17
%r85 = trunc i864 %r82 to i32
store i32 %r85, i32* %r84
%r86 = lshr i864 %r82, 32
%r88 = getelementptr i32, i32* %r2, i32 18
%r89 = trunc i864 %r86 to i32
store i32 %r89, i32* %r88
%r90 = lshr i864 %r86, 32
%r92 = getelementptr i32, i32* %r2, i32 19
%r93 = trunc i864 %r90 to i32
store i32 %r93, i32* %r92
%r94 = lshr i864 %r90, 32
%r96 = getelementptr i32, i32* %r2, i32 20
%r97 = trunc i864 %r94 to i32
store i32 %r97, i32* %r96
%r98 = lshr i864 %r94, 32
%r100 = getelementptr i32, i32* %r2, i32 21
%r101 = trunc i864 %r98 to i32
store i32 %r101, i32* %r100
%r102 = lshr i864 %r98, 32
%r104 = getelementptr i32, i32* %r2, i32 22
%r105 = trunc i864 %r102 to i32
store i32 %r105, i32* %r104
%r106 = lshr i864 %r102, 32
%r108 = getelementptr i32, i32* %r2, i32 23
%r109 = trunc i864 %r106 to i32
store i32 %r109, i32* %r108
%r110 = lshr i864 %r106, 32
%r112 = getelementptr i32, i32* %r2, i32 24
%r113 = trunc i864 %r110 to i32
store i32 %r113, i32* %r112
%r114 = lshr i864 %r110, 32
%r116 = getelementptr i32, i32* %r2, i32 25
%r117 = trunc i864 %r114 to i32
store i32 %r117, i32* %r116
%r118 = lshr i864 %r114, 32
%r120 = getelementptr i32, i32* %r2, i32 26
%r121 = trunc i864 %r118 to i32
store i32 %r121, i32* %r120
%r122 = lshr i896 %r13, 864
%r123 = trunc i896 %r122 to i32
ret i32 %r123
}
define i32 @mclb_sub27(i32* noalias  %r2, i32* noalias  %r3, i32* noalias  %r4)
{
%r6 = bitcast i32* %r3 to i864*
%r7 = load i864, i864* %r6
%r8 = zext i864 %r7 to i896
%r10 = bitcast i32* %r4 to i864*
%r11 = load i864, i864* %r10
%r12 = zext i864 %r11 to i896
%r13 = sub i896 %r8, %r12
%r14 = trunc i896 %r13 to i864
%r16 = getelementptr i32, i32* %r2, i32 0
%r17 = trunc i864 %r14 to i32
store i32 %r17, i32* %r16
%r18 = lshr i864 %r14, 32
%r20 = getelementptr i32, i32* %r2, i32 1
%r21 = trunc i864 %r18 to i32
store i32 %r21, i32* %r20
%r22 = lshr i864 %r18, 32
%r24 = getelementptr i32, i32* %r2, i32 2
%r25 = trunc i864 %r22 to i32
store i32 %r25, i32* %r24
%r26 = lshr i864 %r22, 32
%r28 = getelementptr i32, i32* %r2, i32 3
%r29 = trunc i864 %r26 to i32
store i32 %r29, i32* %r28
%r30 = lshr i864 %r26, 32
%r32 = getelementptr i32, i32* %r2, i32 4
%r33 = trunc i864 %r30 to i32
store i32 %r33, i32* %r32
%r34 = lshr i864 %r30, 32
%r36 = getelementptr i32, i32* %r2, i32 5
%r37 = trunc i864 %r34 to i32
store i32 %r37, i32* %r36
%r38 = lshr i864 %r34, 32
%r40 = getelementptr i32, i32* %r2, i32 6
%r41 = trunc i864 %r38 to i32
store i32 %r41, i32* %r40
%r42 = lshr i864 %r38, 32
%r44 = getelementptr i32, i32* %r2, i32 7
%r45 = trunc i864 %r42 to i32
store i32 %r45, i32* %r44
%r46 = lshr i864 %r42, 32
%r48 = getelementptr i32, i32* %r2, i32 8
%r49 = trunc i864 %r46 to i32
store i32 %r49, i32* %r48
%r50 = lshr i864 %r46, 32
%r52 = getelementptr i32, i32* %r2, i32 9
%r53 = trunc i864 %r50 to i32
store i32 %r53, i32* %r52
%r54 = lshr i864 %r50, 32
%r56 = getelementptr i32, i32* %r2, i32 10
%r57 = trunc i864 %r54 to i32
store i32 %r57, i32* %r56
%r58 = lshr i864 %r54, 32
%r60 = getelementptr i32, i32* %r2, i32 11
%r61 = trunc i864 %r58 to i32
store i32 %r61, i32* %r60
%r62 = lshr i864 %r58, 32
%r64 = getelementptr i32, i32* %r2, i32 12
%r65 = trunc i864 %r62 to i32
store i32 %r65, i32* %r64
%r66 = lshr i864 %r62, 32
%r68 = getelementptr i32, i32* %r2, i32 13
%r69 = trunc i864 %r66 to i32
store i32 %r69, i32* %r68
%r70 = lshr i864 %r66, 32
%r72 = getelementptr i32, i32* %r2, i32 14
%r73 = trunc i864 %r70 to i32
store i32 %r73, i32* %r72
%r74 = lshr i864 %r70, 32
%r76 = getelementptr i32, i32* %r2, i32 15
%r77 = trunc i864 %r74 to i32
store i32 %r77, i32* %r76
%r78 = lshr i864 %r74, 32
%r80 = getelementptr i32, i32* %r2, i32 16
%r81 = trunc i864 %r78 to i32
store i32 %r81, i32* %r80
%r82 = lshr i864 %r78, 32
%r84 = getelementptr i32, i32* %r2, i32 17
%r85 = trunc i864 %r82 to i32
store i32 %r85, i32* %r84
%r86 = lshr i864 %r82, 32
%r88 = getelementptr i32, i32* %r2, i32 18
%r89 = trunc i864 %r86 to i32
store i32 %r89, i32* %r88
%r90 = lshr i864 %r86, 32
%r92 = getelementptr i32, i32* %r2, i32 19
%r93 = trunc i864 %r90 to i32
store i32 %r93, i32* %r92
%r94 = lshr i864 %r90, 32
%r96 = getelementptr i32, i32* %r2, i32 20
%r97 = trunc i864 %r94 to i32
store i32 %r97, i32* %r96
%r98 = lshr i864 %r94, 32
%r100 = getelementptr i32, i32* %r2, i32 21
%r101 = trunc i864 %r98 to i32
store i32 %r101, i32* %r100
%r102 = lshr i864 %r98, 32
%r104 = getelementptr i32, i32* %r2, i32 22
%r105 = trunc i864 %r102 to i32
store i32 %r105, i32* %r104
%r106 = lshr i864 %r102, 32
%r108 = getelementptr i32, i32* %r2, i32 23
%r109 = trunc i864 %r106 to i32
store i32 %r109, i32* %r108
%r110 = lshr i864 %r106, 32
%r112 = getelementptr i32, i32* %r2, i32 24
%r113 = trunc i864 %r110 to i32
store i32 %r113, i32* %r112
%r114 = lshr i864 %r110, 32
%r116 = getelementptr i32, i32* %r2, i32 25
%r117 = trunc i864 %r114 to i32
store i32 %r117, i32* %r116
%r118 = lshr i864 %r114, 32
%r120 = getelementptr i32, i32* %r2, i32 26
%r121 = trunc i864 %r118 to i32
store i32 %r121, i32* %r120
%r122 = lshr i896 %r13, 864
%r123 = trunc i896 %r122 to i32
%r125 = and i32 %r123, 1
ret i32 %r125
}
define void @mclb_addNF27(i32* noalias  %r1, i32* noalias  %r2, i32* noalias  %r3)
{
%r5 = bitcast i32* %r2 to i864*
%r6 = load i864, i864* %r5
%r8 = bitcast i32* %r3 to i864*
%r9 = load i864, i864* %r8
%r10 = add i864 %r6, %r9
%r12 = getelementptr i32, i32* %r1, i32 0
%r13 = trunc i864 %r10 to i32
store i32 %r13, i32* %r12
%r14 = lshr i864 %r10, 32
%r16 = getelementptr i32, i32* %r1, i32 1
%r17 = trunc i864 %r14 to i32
store i32 %r17, i32* %r16
%r18 = lshr i864 %r14, 32
%r20 = getelementptr i32, i32* %r1, i32 2
%r21 = trunc i864 %r18 to i32
store i32 %r21, i32* %r20
%r22 = lshr i864 %r18, 32
%r24 = getelementptr i32, i32* %r1, i32 3
%r25 = trunc i864 %r22 to i32
store i32 %r25, i32* %r24
%r26 = lshr i864 %r22, 32
%r28 = getelementptr i32, i32* %r1, i32 4
%r29 = trunc i864 %r26 to i32
store i32 %r29, i32* %r28
%r30 = lshr i864 %r26, 32
%r32 = getelementptr i32, i32* %r1, i32 5
%r33 = trunc i864 %r30 to i32
store i32 %r33, i32* %r32
%r34 = lshr i864 %r30, 32
%r36 = getelementptr i32, i32* %r1, i32 6
%r37 = trunc i864 %r34 to i32
store i32 %r37, i32* %r36
%r38 = lshr i864 %r34, 32
%r40 = getelementptr i32, i32* %r1, i32 7
%r41 = trunc i864 %r38 to i32
store i32 %r41, i32* %r40
%r42 = lshr i864 %r38, 32
%r44 = getelementptr i32, i32* %r1, i32 8
%r45 = trunc i864 %r42 to i32
store i32 %r45, i32* %r44
%r46 = lshr i864 %r42, 32
%r48 = getelementptr i32, i32* %r1, i32 9
%r49 = trunc i864 %r46 to i32
store i32 %r49, i32* %r48
%r50 = lshr i864 %r46, 32
%r52 = getelementptr i32, i32* %r1, i32 10
%r53 = trunc i864 %r50 to i32
store i32 %r53, i32* %r52
%r54 = lshr i864 %r50, 32
%r56 = getelementptr i32, i32* %r1, i32 11
%r57 = trunc i864 %r54 to i32
store i32 %r57, i32* %r56
%r58 = lshr i864 %r54, 32
%r60 = getelementptr i32, i32* %r1, i32 12
%r61 = trunc i864 %r58 to i32
store i32 %r61, i32* %r60
%r62 = lshr i864 %r58, 32
%r64 = getelementptr i32, i32* %r1, i32 13
%r65 = trunc i864 %r62 to i32
store i32 %r65, i32* %r64
%r66 = lshr i864 %r62, 32
%r68 = getelementptr i32, i32* %r1, i32 14
%r69 = trunc i864 %r66 to i32
store i32 %r69, i32* %r68
%r70 = lshr i864 %r66, 32
%r72 = getelementptr i32, i32* %r1, i32 15
%r73 = trunc i864 %r70 to i32
store i32 %r73, i32* %r72
%r74 = lshr i864 %r70, 32
%r76 = getelementptr i32, i32* %r1, i32 16
%r77 = trunc i864 %r74 to i32
store i32 %r77, i32* %r76
%r78 = lshr i864 %r74, 32
%r80 = getelementptr i32, i32* %r1, i32 17
%r81 = trunc i864 %r78 to i32
store i32 %r81, i32* %r80
%r82 = lshr i864 %r78, 32
%r84 = getelementptr i32, i32* %r1, i32 18
%r85 = trunc i864 %r82 to i32
store i32 %r85, i32* %r84
%r86 = lshr i864 %r82, 32
%r88 = getelementptr i32, i32* %r1, i32 19
%r89 = trunc i864 %r86 to i32
store i32 %r89, i32* %r88
%r90 = lshr i864 %r86, 32
%r92 = getelementptr i32, i32* %r1, i32 20
%r93 = trunc i864 %r90 to i32
store i32 %r93, i32* %r92
%r94 = lshr i864 %r90, 32
%r96 = getelementptr i32, i32* %r1, i32 21
%r97 = trunc i864 %r94 to i32
store i32 %r97, i32* %r96
%r98 = lshr i864 %r94, 32
%r100 = getelementptr i32, i32* %r1, i32 22
%r101 = trunc i864 %r98 to i32
store i32 %r101, i32* %r100
%r102 = lshr i864 %r98, 32
%r104 = getelementptr i32, i32* %r1, i32 23
%r105 = trunc i864 %r102 to i32
store i32 %r105, i32* %r104
%r106 = lshr i864 %r102, 32
%r108 = getelementptr i32, i32* %r1, i32 24
%r109 = trunc i864 %r106 to i32
store i32 %r109, i32* %r108
%r110 = lshr i864 %r106, 32
%r112 = getelementptr i32, i32* %r1, i32 25
%r113 = trunc i864 %r110 to i32
store i32 %r113, i32* %r112
%r114 = lshr i864 %r110, 32
%r116 = getelementptr i32, i32* %r1, i32 26
%r117 = trunc i864 %r114 to i32
store i32 %r117, i32* %r116
ret void
}
define i32 @mclb_subNF27(i32* noalias  %r2, i32* noalias  %r3, i32* noalias  %r4)
{
%r6 = bitcast i32* %r3 to i864*
%r7 = load i864, i864* %r6
%r9 = bitcast i32* %r4 to i864*
%r10 = load i864, i864* %r9
%r11 = sub i864 %r7, %r10
%r13 = getelementptr i32, i32* %r2, i32 0
%r14 = trunc i864 %r11 to i32
store i32 %r14, i32* %r13
%r15 = lshr i864 %r11, 32
%r17 = getelementptr i32, i32* %r2, i32 1
%r18 = trunc i864 %r15 to i32
store i32 %r18, i32* %r17
%r19 = lshr i864 %r15, 32
%r21 = getelementptr i32, i32* %r2, i32 2
%r22 = trunc i864 %r19 to i32
store i32 %r22, i32* %r21
%r23 = lshr i864 %r19, 32
%r25 = getelementptr i32, i32* %r2, i32 3
%r26 = trunc i864 %r23 to i32
store i32 %r26, i32* %r25
%r27 = lshr i864 %r23, 32
%r29 = getelementptr i32, i32* %r2, i32 4
%r30 = trunc i864 %r27 to i32
store i32 %r30, i32* %r29
%r31 = lshr i864 %r27, 32
%r33 = getelementptr i32, i32* %r2, i32 5
%r34 = trunc i864 %r31 to i32
store i32 %r34, i32* %r33
%r35 = lshr i864 %r31, 32
%r37 = getelementptr i32, i32* %r2, i32 6
%r38 = trunc i864 %r35 to i32
store i32 %r38, i32* %r37
%r39 = lshr i864 %r35, 32
%r41 = getelementptr i32, i32* %r2, i32 7
%r42 = trunc i864 %r39 to i32
store i32 %r42, i32* %r41
%r43 = lshr i864 %r39, 32
%r45 = getelementptr i32, i32* %r2, i32 8
%r46 = trunc i864 %r43 to i32
store i32 %r46, i32* %r45
%r47 = lshr i864 %r43, 32
%r49 = getelementptr i32, i32* %r2, i32 9
%r50 = trunc i864 %r47 to i32
store i32 %r50, i32* %r49
%r51 = lshr i864 %r47, 32
%r53 = getelementptr i32, i32* %r2, i32 10
%r54 = trunc i864 %r51 to i32
store i32 %r54, i32* %r53
%r55 = lshr i864 %r51, 32
%r57 = getelementptr i32, i32* %r2, i32 11
%r58 = trunc i864 %r55 to i32
store i32 %r58, i32* %r57
%r59 = lshr i864 %r55, 32
%r61 = getelementptr i32, i32* %r2, i32 12
%r62 = trunc i864 %r59 to i32
store i32 %r62, i32* %r61
%r63 = lshr i864 %r59, 32
%r65 = getelementptr i32, i32* %r2, i32 13
%r66 = trunc i864 %r63 to i32
store i32 %r66, i32* %r65
%r67 = lshr i864 %r63, 32
%r69 = getelementptr i32, i32* %r2, i32 14
%r70 = trunc i864 %r67 to i32
store i32 %r70, i32* %r69
%r71 = lshr i864 %r67, 32
%r73 = getelementptr i32, i32* %r2, i32 15
%r74 = trunc i864 %r71 to i32
store i32 %r74, i32* %r73
%r75 = lshr i864 %r71, 32
%r77 = getelementptr i32, i32* %r2, i32 16
%r78 = trunc i864 %r75 to i32
store i32 %r78, i32* %r77
%r79 = lshr i864 %r75, 32
%r81 = getelementptr i32, i32* %r2, i32 17
%r82 = trunc i864 %r79 to i32
store i32 %r82, i32* %r81
%r83 = lshr i864 %r79, 32
%r85 = getelementptr i32, i32* %r2, i32 18
%r86 = trunc i864 %r83 to i32
store i32 %r86, i32* %r85
%r87 = lshr i864 %r83, 32
%r89 = getelementptr i32, i32* %r2, i32 19
%r90 = trunc i864 %r87 to i32
store i32 %r90, i32* %r89
%r91 = lshr i864 %r87, 32
%r93 = getelementptr i32, i32* %r2, i32 20
%r94 = trunc i864 %r91 to i32
store i32 %r94, i32* %r93
%r95 = lshr i864 %r91, 32
%r97 = getelementptr i32, i32* %r2, i32 21
%r98 = trunc i864 %r95 to i32
store i32 %r98, i32* %r97
%r99 = lshr i864 %r95, 32
%r101 = getelementptr i32, i32* %r2, i32 22
%r102 = trunc i864 %r99 to i32
store i32 %r102, i32* %r101
%r103 = lshr i864 %r99, 32
%r105 = getelementptr i32, i32* %r2, i32 23
%r106 = trunc i864 %r103 to i32
store i32 %r106, i32* %r105
%r107 = lshr i864 %r103, 32
%r109 = getelementptr i32, i32* %r2, i32 24
%r110 = trunc i864 %r107 to i32
store i32 %r110, i32* %r109
%r111 = lshr i864 %r107, 32
%r113 = getelementptr i32, i32* %r2, i32 25
%r114 = trunc i864 %r111 to i32
store i32 %r114, i32* %r113
%r115 = lshr i864 %r111, 32
%r117 = getelementptr i32, i32* %r2, i32 26
%r118 = trunc i864 %r115 to i32
store i32 %r118, i32* %r117
%r119 = lshr i864 %r11, 863
%r120 = trunc i864 %r119 to i32
%r122 = and i32 %r120, 1
ret i32 %r122
}
define i32 @mclb_add28(i32* noalias  %r2, i32* noalias  %r3, i32* noalias  %r4)
{
%r6 = bitcast i32* %r3 to i896*
%r7 = load i896, i896* %r6
%r8 = zext i896 %r7 to i928
%r10 = bitcast i32* %r4 to i896*
%r11 = load i896, i896* %r10
%r12 = zext i896 %r11 to i928
%r13 = add i928 %r8, %r12
%r14 = trunc i928 %r13 to i896
%r16 = getelementptr i32, i32* %r2, i32 0
%r17 = trunc i896 %r14 to i32
store i32 %r17, i32* %r16
%r18 = lshr i896 %r14, 32
%r20 = getelementptr i32, i32* %r2, i32 1
%r21 = trunc i896 %r18 to i32
store i32 %r21, i32* %r20
%r22 = lshr i896 %r18, 32
%r24 = getelementptr i32, i32* %r2, i32 2
%r25 = trunc i896 %r22 to i32
store i32 %r25, i32* %r24
%r26 = lshr i896 %r22, 32
%r28 = getelementptr i32, i32* %r2, i32 3
%r29 = trunc i896 %r26 to i32
store i32 %r29, i32* %r28
%r30 = lshr i896 %r26, 32
%r32 = getelementptr i32, i32* %r2, i32 4
%r33 = trunc i896 %r30 to i32
store i32 %r33, i32* %r32
%r34 = lshr i896 %r30, 32
%r36 = getelementptr i32, i32* %r2, i32 5
%r37 = trunc i896 %r34 to i32
store i32 %r37, i32* %r36
%r38 = lshr i896 %r34, 32
%r40 = getelementptr i32, i32* %r2, i32 6
%r41 = trunc i896 %r38 to i32
store i32 %r41, i32* %r40
%r42 = lshr i896 %r38, 32
%r44 = getelementptr i32, i32* %r2, i32 7
%r45 = trunc i896 %r42 to i32
store i32 %r45, i32* %r44
%r46 = lshr i896 %r42, 32
%r48 = getelementptr i32, i32* %r2, i32 8
%r49 = trunc i896 %r46 to i32
store i32 %r49, i32* %r48
%r50 = lshr i896 %r46, 32
%r52 = getelementptr i32, i32* %r2, i32 9
%r53 = trunc i896 %r50 to i32
store i32 %r53, i32* %r52
%r54 = lshr i896 %r50, 32
%r56 = getelementptr i32, i32* %r2, i32 10
%r57 = trunc i896 %r54 to i32
store i32 %r57, i32* %r56
%r58 = lshr i896 %r54, 32
%r60 = getelementptr i32, i32* %r2, i32 11
%r61 = trunc i896 %r58 to i32
store i32 %r61, i32* %r60
%r62 = lshr i896 %r58, 32
%r64 = getelementptr i32, i32* %r2, i32 12
%r65 = trunc i896 %r62 to i32
store i32 %r65, i32* %r64
%r66 = lshr i896 %r62, 32
%r68 = getelementptr i32, i32* %r2, i32 13
%r69 = trunc i896 %r66 to i32
store i32 %r69, i32* %r68
%r70 = lshr i896 %r66, 32
%r72 = getelementptr i32, i32* %r2, i32 14
%r73 = trunc i896 %r70 to i32
store i32 %r73, i32* %r72
%r74 = lshr i896 %r70, 32
%r76 = getelementptr i32, i32* %r2, i32 15
%r77 = trunc i896 %r74 to i32
store i32 %r77, i32* %r76
%r78 = lshr i896 %r74, 32
%r80 = getelementptr i32, i32* %r2, i32 16
%r81 = trunc i896 %r78 to i32
store i32 %r81, i32* %r80
%r82 = lshr i896 %r78, 32
%r84 = getelementptr i32, i32* %r2, i32 17
%r85 = trunc i896 %r82 to i32
store i32 %r85, i32* %r84
%r86 = lshr i896 %r82, 32
%r88 = getelementptr i32, i32* %r2, i32 18
%r89 = trunc i896 %r86 to i32
store i32 %r89, i32* %r88
%r90 = lshr i896 %r86, 32
%r92 = getelementptr i32, i32* %r2, i32 19
%r93 = trunc i896 %r90 to i32
store i32 %r93, i32* %r92
%r94 = lshr i896 %r90, 32
%r96 = getelementptr i32, i32* %r2, i32 20
%r97 = trunc i896 %r94 to i32
store i32 %r97, i32* %r96
%r98 = lshr i896 %r94, 32
%r100 = getelementptr i32, i32* %r2, i32 21
%r101 = trunc i896 %r98 to i32
store i32 %r101, i32* %r100
%r102 = lshr i896 %r98, 32
%r104 = getelementptr i32, i32* %r2, i32 22
%r105 = trunc i896 %r102 to i32
store i32 %r105, i32* %r104
%r106 = lshr i896 %r102, 32
%r108 = getelementptr i32, i32* %r2, i32 23
%r109 = trunc i896 %r106 to i32
store i32 %r109, i32* %r108
%r110 = lshr i896 %r106, 32
%r112 = getelementptr i32, i32* %r2, i32 24
%r113 = trunc i896 %r110 to i32
store i32 %r113, i32* %r112
%r114 = lshr i896 %r110, 32
%r116 = getelementptr i32, i32* %r2, i32 25
%r117 = trunc i896 %r114 to i32
store i32 %r117, i32* %r116
%r118 = lshr i896 %r114, 32
%r120 = getelementptr i32, i32* %r2, i32 26
%r121 = trunc i896 %r118 to i32
store i32 %r121, i32* %r120
%r122 = lshr i896 %r118, 32
%r124 = getelementptr i32, i32* %r2, i32 27
%r125 = trunc i896 %r122 to i32
store i32 %r125, i32* %r124
%r126 = lshr i928 %r13, 896
%r127 = trunc i928 %r126 to i32
ret i32 %r127
}
define i32 @mclb_sub28(i32* noalias  %r2, i32* noalias  %r3, i32* noalias  %r4)
{
%r6 = bitcast i32* %r3 to i896*
%r7 = load i896, i896* %r6
%r8 = zext i896 %r7 to i928
%r10 = bitcast i32* %r4 to i896*
%r11 = load i896, i896* %r10
%r12 = zext i896 %r11 to i928
%r13 = sub i928 %r8, %r12
%r14 = trunc i928 %r13 to i896
%r16 = getelementptr i32, i32* %r2, i32 0
%r17 = trunc i896 %r14 to i32
store i32 %r17, i32* %r16
%r18 = lshr i896 %r14, 32
%r20 = getelementptr i32, i32* %r2, i32 1
%r21 = trunc i896 %r18 to i32
store i32 %r21, i32* %r20
%r22 = lshr i896 %r18, 32
%r24 = getelementptr i32, i32* %r2, i32 2
%r25 = trunc i896 %r22 to i32
store i32 %r25, i32* %r24
%r26 = lshr i896 %r22, 32
%r28 = getelementptr i32, i32* %r2, i32 3
%r29 = trunc i896 %r26 to i32
store i32 %r29, i32* %r28
%r30 = lshr i896 %r26, 32
%r32 = getelementptr i32, i32* %r2, i32 4
%r33 = trunc i896 %r30 to i32
store i32 %r33, i32* %r32
%r34 = lshr i896 %r30, 32
%r36 = getelementptr i32, i32* %r2, i32 5
%r37 = trunc i896 %r34 to i32
store i32 %r37, i32* %r36
%r38 = lshr i896 %r34, 32
%r40 = getelementptr i32, i32* %r2, i32 6
%r41 = trunc i896 %r38 to i32
store i32 %r41, i32* %r40
%r42 = lshr i896 %r38, 32
%r44 = getelementptr i32, i32* %r2, i32 7
%r45 = trunc i896 %r42 to i32
store i32 %r45, i32* %r44
%r46 = lshr i896 %r42, 32
%r48 = getelementptr i32, i32* %r2, i32 8
%r49 = trunc i896 %r46 to i32
store i32 %r49, i32* %r48
%r50 = lshr i896 %r46, 32
%r52 = getelementptr i32, i32* %r2, i32 9
%r53 = trunc i896 %r50 to i32
store i32 %r53, i32* %r52
%r54 = lshr i896 %r50, 32
%r56 = getelementptr i32, i32* %r2, i32 10
%r57 = trunc i896 %r54 to i32
store i32 %r57, i32* %r56
%r58 = lshr i896 %r54, 32
%r60 = getelementptr i32, i32* %r2, i32 11
%r61 = trunc i896 %r58 to i32
store i32 %r61, i32* %r60
%r62 = lshr i896 %r58, 32
%r64 = getelementptr i32, i32* %r2, i32 12
%r65 = trunc i896 %r62 to i32
store i32 %r65, i32* %r64
%r66 = lshr i896 %r62, 32
%r68 = getelementptr i32, i32* %r2, i32 13
%r69 = trunc i896 %r66 to i32
store i32 %r69, i32* %r68
%r70 = lshr i896 %r66, 32
%r72 = getelementptr i32, i32* %r2, i32 14
%r73 = trunc i896 %r70 to i32
store i32 %r73, i32* %r72
%r74 = lshr i896 %r70, 32
%r76 = getelementptr i32, i32* %r2, i32 15
%r77 = trunc i896 %r74 to i32
store i32 %r77, i32* %r76
%r78 = lshr i896 %r74, 32
%r80 = getelementptr i32, i32* %r2, i32 16
%r81 = trunc i896 %r78 to i32
store i32 %r81, i32* %r80
%r82 = lshr i896 %r78, 32
%r84 = getelementptr i32, i32* %r2, i32 17
%r85 = trunc i896 %r82 to i32
store i32 %r85, i32* %r84
%r86 = lshr i896 %r82, 32
%r88 = getelementptr i32, i32* %r2, i32 18
%r89 = trunc i896 %r86 to i32
store i32 %r89, i32* %r88
%r90 = lshr i896 %r86, 32
%r92 = getelementptr i32, i32* %r2, i32 19
%r93 = trunc i896 %r90 to i32
store i32 %r93, i32* %r92
%r94 = lshr i896 %r90, 32
%r96 = getelementptr i32, i32* %r2, i32 20
%r97 = trunc i896 %r94 to i32
store i32 %r97, i32* %r96
%r98 = lshr i896 %r94, 32
%r100 = getelementptr i32, i32* %r2, i32 21
%r101 = trunc i896 %r98 to i32
store i32 %r101, i32* %r100
%r102 = lshr i896 %r98, 32
%r104 = getelementptr i32, i32* %r2, i32 22
%r105 = trunc i896 %r102 to i32
store i32 %r105, i32* %r104
%r106 = lshr i896 %r102, 32
%r108 = getelementptr i32, i32* %r2, i32 23
%r109 = trunc i896 %r106 to i32
store i32 %r109, i32* %r108
%r110 = lshr i896 %r106, 32
%r112 = getelementptr i32, i32* %r2, i32 24
%r113 = trunc i896 %r110 to i32
store i32 %r113, i32* %r112
%r114 = lshr i896 %r110, 32
%r116 = getelementptr i32, i32* %r2, i32 25
%r117 = trunc i896 %r114 to i32
store i32 %r117, i32* %r116
%r118 = lshr i896 %r114, 32
%r120 = getelementptr i32, i32* %r2, i32 26
%r121 = trunc i896 %r118 to i32
store i32 %r121, i32* %r120
%r122 = lshr i896 %r118, 32
%r124 = getelementptr i32, i32* %r2, i32 27
%r125 = trunc i896 %r122 to i32
store i32 %r125, i32* %r124
%r126 = lshr i928 %r13, 896
%r127 = trunc i928 %r126 to i32
%r129 = and i32 %r127, 1
ret i32 %r129
}
define void @mclb_addNF28(i32* noalias  %r1, i32* noalias  %r2, i32* noalias  %r3)
{
%r5 = bitcast i32* %r2 to i896*
%r6 = load i896, i896* %r5
%r8 = bitcast i32* %r3 to i896*
%r9 = load i896, i896* %r8
%r10 = add i896 %r6, %r9
%r12 = getelementptr i32, i32* %r1, i32 0
%r13 = trunc i896 %r10 to i32
store i32 %r13, i32* %r12
%r14 = lshr i896 %r10, 32
%r16 = getelementptr i32, i32* %r1, i32 1
%r17 = trunc i896 %r14 to i32
store i32 %r17, i32* %r16
%r18 = lshr i896 %r14, 32
%r20 = getelementptr i32, i32* %r1, i32 2
%r21 = trunc i896 %r18 to i32
store i32 %r21, i32* %r20
%r22 = lshr i896 %r18, 32
%r24 = getelementptr i32, i32* %r1, i32 3
%r25 = trunc i896 %r22 to i32
store i32 %r25, i32* %r24
%r26 = lshr i896 %r22, 32
%r28 = getelementptr i32, i32* %r1, i32 4
%r29 = trunc i896 %r26 to i32
store i32 %r29, i32* %r28
%r30 = lshr i896 %r26, 32
%r32 = getelementptr i32, i32* %r1, i32 5
%r33 = trunc i896 %r30 to i32
store i32 %r33, i32* %r32
%r34 = lshr i896 %r30, 32
%r36 = getelementptr i32, i32* %r1, i32 6
%r37 = trunc i896 %r34 to i32
store i32 %r37, i32* %r36
%r38 = lshr i896 %r34, 32
%r40 = getelementptr i32, i32* %r1, i32 7
%r41 = trunc i896 %r38 to i32
store i32 %r41, i32* %r40
%r42 = lshr i896 %r38, 32
%r44 = getelementptr i32, i32* %r1, i32 8
%r45 = trunc i896 %r42 to i32
store i32 %r45, i32* %r44
%r46 = lshr i896 %r42, 32
%r48 = getelementptr i32, i32* %r1, i32 9
%r49 = trunc i896 %r46 to i32
store i32 %r49, i32* %r48
%r50 = lshr i896 %r46, 32
%r52 = getelementptr i32, i32* %r1, i32 10
%r53 = trunc i896 %r50 to i32
store i32 %r53, i32* %r52
%r54 = lshr i896 %r50, 32
%r56 = getelementptr i32, i32* %r1, i32 11
%r57 = trunc i896 %r54 to i32
store i32 %r57, i32* %r56
%r58 = lshr i896 %r54, 32
%r60 = getelementptr i32, i32* %r1, i32 12
%r61 = trunc i896 %r58 to i32
store i32 %r61, i32* %r60
%r62 = lshr i896 %r58, 32
%r64 = getelementptr i32, i32* %r1, i32 13
%r65 = trunc i896 %r62 to i32
store i32 %r65, i32* %r64
%r66 = lshr i896 %r62, 32
%r68 = getelementptr i32, i32* %r1, i32 14
%r69 = trunc i896 %r66 to i32
store i32 %r69, i32* %r68
%r70 = lshr i896 %r66, 32
%r72 = getelementptr i32, i32* %r1, i32 15
%r73 = trunc i896 %r70 to i32
store i32 %r73, i32* %r72
%r74 = lshr i896 %r70, 32
%r76 = getelementptr i32, i32* %r1, i32 16
%r77 = trunc i896 %r74 to i32
store i32 %r77, i32* %r76
%r78 = lshr i896 %r74, 32
%r80 = getelementptr i32, i32* %r1, i32 17
%r81 = trunc i896 %r78 to i32
store i32 %r81, i32* %r80
%r82 = lshr i896 %r78, 32
%r84 = getelementptr i32, i32* %r1, i32 18
%r85 = trunc i896 %r82 to i32
store i32 %r85, i32* %r84
%r86 = lshr i896 %r82, 32
%r88 = getelementptr i32, i32* %r1, i32 19
%r89 = trunc i896 %r86 to i32
store i32 %r89, i32* %r88
%r90 = lshr i896 %r86, 32
%r92 = getelementptr i32, i32* %r1, i32 20
%r93 = trunc i896 %r90 to i32
store i32 %r93, i32* %r92
%r94 = lshr i896 %r90, 32
%r96 = getelementptr i32, i32* %r1, i32 21
%r97 = trunc i896 %r94 to i32
store i32 %r97, i32* %r96
%r98 = lshr i896 %r94, 32
%r100 = getelementptr i32, i32* %r1, i32 22
%r101 = trunc i896 %r98 to i32
store i32 %r101, i32* %r100
%r102 = lshr i896 %r98, 32
%r104 = getelementptr i32, i32* %r1, i32 23
%r105 = trunc i896 %r102 to i32
store i32 %r105, i32* %r104
%r106 = lshr i896 %r102, 32
%r108 = getelementptr i32, i32* %r1, i32 24
%r109 = trunc i896 %r106 to i32
store i32 %r109, i32* %r108
%r110 = lshr i896 %r106, 32
%r112 = getelementptr i32, i32* %r1, i32 25
%r113 = trunc i896 %r110 to i32
store i32 %r113, i32* %r112
%r114 = lshr i896 %r110, 32
%r116 = getelementptr i32, i32* %r1, i32 26
%r117 = trunc i896 %r114 to i32
store i32 %r117, i32* %r116
%r118 = lshr i896 %r114, 32
%r120 = getelementptr i32, i32* %r1, i32 27
%r121 = trunc i896 %r118 to i32
store i32 %r121, i32* %r120
ret void
}
define i32 @mclb_subNF28(i32* noalias  %r2, i32* noalias  %r3, i32* noalias  %r4)
{
%r6 = bitcast i32* %r3 to i896*
%r7 = load i896, i896* %r6
%r9 = bitcast i32* %r4 to i896*
%r10 = load i896, i896* %r9
%r11 = sub i896 %r7, %r10
%r13 = getelementptr i32, i32* %r2, i32 0
%r14 = trunc i896 %r11 to i32
store i32 %r14, i32* %r13
%r15 = lshr i896 %r11, 32
%r17 = getelementptr i32, i32* %r2, i32 1
%r18 = trunc i896 %r15 to i32
store i32 %r18, i32* %r17
%r19 = lshr i896 %r15, 32
%r21 = getelementptr i32, i32* %r2, i32 2
%r22 = trunc i896 %r19 to i32
store i32 %r22, i32* %r21
%r23 = lshr i896 %r19, 32
%r25 = getelementptr i32, i32* %r2, i32 3
%r26 = trunc i896 %r23 to i32
store i32 %r26, i32* %r25
%r27 = lshr i896 %r23, 32
%r29 = getelementptr i32, i32* %r2, i32 4
%r30 = trunc i896 %r27 to i32
store i32 %r30, i32* %r29
%r31 = lshr i896 %r27, 32
%r33 = getelementptr i32, i32* %r2, i32 5
%r34 = trunc i896 %r31 to i32
store i32 %r34, i32* %r33
%r35 = lshr i896 %r31, 32
%r37 = getelementptr i32, i32* %r2, i32 6
%r38 = trunc i896 %r35 to i32
store i32 %r38, i32* %r37
%r39 = lshr i896 %r35, 32
%r41 = getelementptr i32, i32* %r2, i32 7
%r42 = trunc i896 %r39 to i32
store i32 %r42, i32* %r41
%r43 = lshr i896 %r39, 32
%r45 = getelementptr i32, i32* %r2, i32 8
%r46 = trunc i896 %r43 to i32
store i32 %r46, i32* %r45
%r47 = lshr i896 %r43, 32
%r49 = getelementptr i32, i32* %r2, i32 9
%r50 = trunc i896 %r47 to i32
store i32 %r50, i32* %r49
%r51 = lshr i896 %r47, 32
%r53 = getelementptr i32, i32* %r2, i32 10
%r54 = trunc i896 %r51 to i32
store i32 %r54, i32* %r53
%r55 = lshr i896 %r51, 32
%r57 = getelementptr i32, i32* %r2, i32 11
%r58 = trunc i896 %r55 to i32
store i32 %r58, i32* %r57
%r59 = lshr i896 %r55, 32
%r61 = getelementptr i32, i32* %r2, i32 12
%r62 = trunc i896 %r59 to i32
store i32 %r62, i32* %r61
%r63 = lshr i896 %r59, 32
%r65 = getelementptr i32, i32* %r2, i32 13
%r66 = trunc i896 %r63 to i32
store i32 %r66, i32* %r65
%r67 = lshr i896 %r63, 32
%r69 = getelementptr i32, i32* %r2, i32 14
%r70 = trunc i896 %r67 to i32
store i32 %r70, i32* %r69
%r71 = lshr i896 %r67, 32
%r73 = getelementptr i32, i32* %r2, i32 15
%r74 = trunc i896 %r71 to i32
store i32 %r74, i32* %r73
%r75 = lshr i896 %r71, 32
%r77 = getelementptr i32, i32* %r2, i32 16
%r78 = trunc i896 %r75 to i32
store i32 %r78, i32* %r77
%r79 = lshr i896 %r75, 32
%r81 = getelementptr i32, i32* %r2, i32 17
%r82 = trunc i896 %r79 to i32
store i32 %r82, i32* %r81
%r83 = lshr i896 %r79, 32
%r85 = getelementptr i32, i32* %r2, i32 18
%r86 = trunc i896 %r83 to i32
store i32 %r86, i32* %r85
%r87 = lshr i896 %r83, 32
%r89 = getelementptr i32, i32* %r2, i32 19
%r90 = trunc i896 %r87 to i32
store i32 %r90, i32* %r89
%r91 = lshr i896 %r87, 32
%r93 = getelementptr i32, i32* %r2, i32 20
%r94 = trunc i896 %r91 to i32
store i32 %r94, i32* %r93
%r95 = lshr i896 %r91, 32
%r97 = getelementptr i32, i32* %r2, i32 21
%r98 = trunc i896 %r95 to i32
store i32 %r98, i32* %r97
%r99 = lshr i896 %r95, 32
%r101 = getelementptr i32, i32* %r2, i32 22
%r102 = trunc i896 %r99 to i32
store i32 %r102, i32* %r101
%r103 = lshr i896 %r99, 32
%r105 = getelementptr i32, i32* %r2, i32 23
%r106 = trunc i896 %r103 to i32
store i32 %r106, i32* %r105
%r107 = lshr i896 %r103, 32
%r109 = getelementptr i32, i32* %r2, i32 24
%r110 = trunc i896 %r107 to i32
store i32 %r110, i32* %r109
%r111 = lshr i896 %r107, 32
%r113 = getelementptr i32, i32* %r2, i32 25
%r114 = trunc i896 %r111 to i32
store i32 %r114, i32* %r113
%r115 = lshr i896 %r111, 32
%r117 = getelementptr i32, i32* %r2, i32 26
%r118 = trunc i896 %r115 to i32
store i32 %r118, i32* %r117
%r119 = lshr i896 %r115, 32
%r121 = getelementptr i32, i32* %r2, i32 27
%r122 = trunc i896 %r119 to i32
store i32 %r122, i32* %r121
%r123 = lshr i896 %r11, 895
%r124 = trunc i896 %r123 to i32
%r126 = and i32 %r124, 1
ret i32 %r126
}
define i32 @mclb_add29(i32* noalias  %r2, i32* noalias  %r3, i32* noalias  %r4)
{
%r6 = bitcast i32* %r3 to i928*
%r7 = load i928, i928* %r6
%r8 = zext i928 %r7 to i960
%r10 = bitcast i32* %r4 to i928*
%r11 = load i928, i928* %r10
%r12 = zext i928 %r11 to i960
%r13 = add i960 %r8, %r12
%r14 = trunc i960 %r13 to i928
%r16 = getelementptr i32, i32* %r2, i32 0
%r17 = trunc i928 %r14 to i32
store i32 %r17, i32* %r16
%r18 = lshr i928 %r14, 32
%r20 = getelementptr i32, i32* %r2, i32 1
%r21 = trunc i928 %r18 to i32
store i32 %r21, i32* %r20
%r22 = lshr i928 %r18, 32
%r24 = getelementptr i32, i32* %r2, i32 2
%r25 = trunc i928 %r22 to i32
store i32 %r25, i32* %r24
%r26 = lshr i928 %r22, 32
%r28 = getelementptr i32, i32* %r2, i32 3
%r29 = trunc i928 %r26 to i32
store i32 %r29, i32* %r28
%r30 = lshr i928 %r26, 32
%r32 = getelementptr i32, i32* %r2, i32 4
%r33 = trunc i928 %r30 to i32
store i32 %r33, i32* %r32
%r34 = lshr i928 %r30, 32
%r36 = getelementptr i32, i32* %r2, i32 5
%r37 = trunc i928 %r34 to i32
store i32 %r37, i32* %r36
%r38 = lshr i928 %r34, 32
%r40 = getelementptr i32, i32* %r2, i32 6
%r41 = trunc i928 %r38 to i32
store i32 %r41, i32* %r40
%r42 = lshr i928 %r38, 32
%r44 = getelementptr i32, i32* %r2, i32 7
%r45 = trunc i928 %r42 to i32
store i32 %r45, i32* %r44
%r46 = lshr i928 %r42, 32
%r48 = getelementptr i32, i32* %r2, i32 8
%r49 = trunc i928 %r46 to i32
store i32 %r49, i32* %r48
%r50 = lshr i928 %r46, 32
%r52 = getelementptr i32, i32* %r2, i32 9
%r53 = trunc i928 %r50 to i32
store i32 %r53, i32* %r52
%r54 = lshr i928 %r50, 32
%r56 = getelementptr i32, i32* %r2, i32 10
%r57 = trunc i928 %r54 to i32
store i32 %r57, i32* %r56
%r58 = lshr i928 %r54, 32
%r60 = getelementptr i32, i32* %r2, i32 11
%r61 = trunc i928 %r58 to i32
store i32 %r61, i32* %r60
%r62 = lshr i928 %r58, 32
%r64 = getelementptr i32, i32* %r2, i32 12
%r65 = trunc i928 %r62 to i32
store i32 %r65, i32* %r64
%r66 = lshr i928 %r62, 32
%r68 = getelementptr i32, i32* %r2, i32 13
%r69 = trunc i928 %r66 to i32
store i32 %r69, i32* %r68
%r70 = lshr i928 %r66, 32
%r72 = getelementptr i32, i32* %r2, i32 14
%r73 = trunc i928 %r70 to i32
store i32 %r73, i32* %r72
%r74 = lshr i928 %r70, 32
%r76 = getelementptr i32, i32* %r2, i32 15
%r77 = trunc i928 %r74 to i32
store i32 %r77, i32* %r76
%r78 = lshr i928 %r74, 32
%r80 = getelementptr i32, i32* %r2, i32 16
%r81 = trunc i928 %r78 to i32
store i32 %r81, i32* %r80
%r82 = lshr i928 %r78, 32
%r84 = getelementptr i32, i32* %r2, i32 17
%r85 = trunc i928 %r82 to i32
store i32 %r85, i32* %r84
%r86 = lshr i928 %r82, 32
%r88 = getelementptr i32, i32* %r2, i32 18
%r89 = trunc i928 %r86 to i32
store i32 %r89, i32* %r88
%r90 = lshr i928 %r86, 32
%r92 = getelementptr i32, i32* %r2, i32 19
%r93 = trunc i928 %r90 to i32
store i32 %r93, i32* %r92
%r94 = lshr i928 %r90, 32
%r96 = getelementptr i32, i32* %r2, i32 20
%r97 = trunc i928 %r94 to i32
store i32 %r97, i32* %r96
%r98 = lshr i928 %r94, 32
%r100 = getelementptr i32, i32* %r2, i32 21
%r101 = trunc i928 %r98 to i32
store i32 %r101, i32* %r100
%r102 = lshr i928 %r98, 32
%r104 = getelementptr i32, i32* %r2, i32 22
%r105 = trunc i928 %r102 to i32
store i32 %r105, i32* %r104
%r106 = lshr i928 %r102, 32
%r108 = getelementptr i32, i32* %r2, i32 23
%r109 = trunc i928 %r106 to i32
store i32 %r109, i32* %r108
%r110 = lshr i928 %r106, 32
%r112 = getelementptr i32, i32* %r2, i32 24
%r113 = trunc i928 %r110 to i32
store i32 %r113, i32* %r112
%r114 = lshr i928 %r110, 32
%r116 = getelementptr i32, i32* %r2, i32 25
%r117 = trunc i928 %r114 to i32
store i32 %r117, i32* %r116
%r118 = lshr i928 %r114, 32
%r120 = getelementptr i32, i32* %r2, i32 26
%r121 = trunc i928 %r118 to i32
store i32 %r121, i32* %r120
%r122 = lshr i928 %r118, 32
%r124 = getelementptr i32, i32* %r2, i32 27
%r125 = trunc i928 %r122 to i32
store i32 %r125, i32* %r124
%r126 = lshr i928 %r122, 32
%r128 = getelementptr i32, i32* %r2, i32 28
%r129 = trunc i928 %r126 to i32
store i32 %r129, i32* %r128
%r130 = lshr i960 %r13, 928
%r131 = trunc i960 %r130 to i32
ret i32 %r131
}
define i32 @mclb_sub29(i32* noalias  %r2, i32* noalias  %r3, i32* noalias  %r4)
{
%r6 = bitcast i32* %r3 to i928*
%r7 = load i928, i928* %r6
%r8 = zext i928 %r7 to i960
%r10 = bitcast i32* %r4 to i928*
%r11 = load i928, i928* %r10
%r12 = zext i928 %r11 to i960
%r13 = sub i960 %r8, %r12
%r14 = trunc i960 %r13 to i928
%r16 = getelementptr i32, i32* %r2, i32 0
%r17 = trunc i928 %r14 to i32
store i32 %r17, i32* %r16
%r18 = lshr i928 %r14, 32
%r20 = getelementptr i32, i32* %r2, i32 1
%r21 = trunc i928 %r18 to i32
store i32 %r21, i32* %r20
%r22 = lshr i928 %r18, 32
%r24 = getelementptr i32, i32* %r2, i32 2
%r25 = trunc i928 %r22 to i32
store i32 %r25, i32* %r24
%r26 = lshr i928 %r22, 32
%r28 = getelementptr i32, i32* %r2, i32 3
%r29 = trunc i928 %r26 to i32
store i32 %r29, i32* %r28
%r30 = lshr i928 %r26, 32
%r32 = getelementptr i32, i32* %r2, i32 4
%r33 = trunc i928 %r30 to i32
store i32 %r33, i32* %r32
%r34 = lshr i928 %r30, 32
%r36 = getelementptr i32, i32* %r2, i32 5
%r37 = trunc i928 %r34 to i32
store i32 %r37, i32* %r36
%r38 = lshr i928 %r34, 32
%r40 = getelementptr i32, i32* %r2, i32 6
%r41 = trunc i928 %r38 to i32
store i32 %r41, i32* %r40
%r42 = lshr i928 %r38, 32
%r44 = getelementptr i32, i32* %r2, i32 7
%r45 = trunc i928 %r42 to i32
store i32 %r45, i32* %r44
%r46 = lshr i928 %r42, 32
%r48 = getelementptr i32, i32* %r2, i32 8
%r49 = trunc i928 %r46 to i32
store i32 %r49, i32* %r48
%r50 = lshr i928 %r46, 32
%r52 = getelementptr i32, i32* %r2, i32 9
%r53 = trunc i928 %r50 to i32
store i32 %r53, i32* %r52
%r54 = lshr i928 %r50, 32
%r56 = getelementptr i32, i32* %r2, i32 10
%r57 = trunc i928 %r54 to i32
store i32 %r57, i32* %r56
%r58 = lshr i928 %r54, 32
%r60 = getelementptr i32, i32* %r2, i32 11
%r61 = trunc i928 %r58 to i32
store i32 %r61, i32* %r60
%r62 = lshr i928 %r58, 32
%r64 = getelementptr i32, i32* %r2, i32 12
%r65 = trunc i928 %r62 to i32
store i32 %r65, i32* %r64
%r66 = lshr i928 %r62, 32
%r68 = getelementptr i32, i32* %r2, i32 13
%r69 = trunc i928 %r66 to i32
store i32 %r69, i32* %r68
%r70 = lshr i928 %r66, 32
%r72 = getelementptr i32, i32* %r2, i32 14
%r73 = trunc i928 %r70 to i32
store i32 %r73, i32* %r72
%r74 = lshr i928 %r70, 32
%r76 = getelementptr i32, i32* %r2, i32 15
%r77 = trunc i928 %r74 to i32
store i32 %r77, i32* %r76
%r78 = lshr i928 %r74, 32
%r80 = getelementptr i32, i32* %r2, i32 16
%r81 = trunc i928 %r78 to i32
store i32 %r81, i32* %r80
%r82 = lshr i928 %r78, 32
%r84 = getelementptr i32, i32* %r2, i32 17
%r85 = trunc i928 %r82 to i32
store i32 %r85, i32* %r84
%r86 = lshr i928 %r82, 32
%r88 = getelementptr i32, i32* %r2, i32 18
%r89 = trunc i928 %r86 to i32
store i32 %r89, i32* %r88
%r90 = lshr i928 %r86, 32
%r92 = getelementptr i32, i32* %r2, i32 19
%r93 = trunc i928 %r90 to i32
store i32 %r93, i32* %r92
%r94 = lshr i928 %r90, 32
%r96 = getelementptr i32, i32* %r2, i32 20
%r97 = trunc i928 %r94 to i32
store i32 %r97, i32* %r96
%r98 = lshr i928 %r94, 32
%r100 = getelementptr i32, i32* %r2, i32 21
%r101 = trunc i928 %r98 to i32
store i32 %r101, i32* %r100
%r102 = lshr i928 %r98, 32
%r104 = getelementptr i32, i32* %r2, i32 22
%r105 = trunc i928 %r102 to i32
store i32 %r105, i32* %r104
%r106 = lshr i928 %r102, 32
%r108 = getelementptr i32, i32* %r2, i32 23
%r109 = trunc i928 %r106 to i32
store i32 %r109, i32* %r108
%r110 = lshr i928 %r106, 32
%r112 = getelementptr i32, i32* %r2, i32 24
%r113 = trunc i928 %r110 to i32
store i32 %r113, i32* %r112
%r114 = lshr i928 %r110, 32
%r116 = getelementptr i32, i32* %r2, i32 25
%r117 = trunc i928 %r114 to i32
store i32 %r117, i32* %r116
%r118 = lshr i928 %r114, 32
%r120 = getelementptr i32, i32* %r2, i32 26
%r121 = trunc i928 %r118 to i32
store i32 %r121, i32* %r120
%r122 = lshr i928 %r118, 32
%r124 = getelementptr i32, i32* %r2, i32 27
%r125 = trunc i928 %r122 to i32
store i32 %r125, i32* %r124
%r126 = lshr i928 %r122, 32
%r128 = getelementptr i32, i32* %r2, i32 28
%r129 = trunc i928 %r126 to i32
store i32 %r129, i32* %r128
%r130 = lshr i960 %r13, 928
%r131 = trunc i960 %r130 to i32
%r133 = and i32 %r131, 1
ret i32 %r133
}
define void @mclb_addNF29(i32* noalias  %r1, i32* noalias  %r2, i32* noalias  %r3)
{
%r5 = bitcast i32* %r2 to i928*
%r6 = load i928, i928* %r5
%r8 = bitcast i32* %r3 to i928*
%r9 = load i928, i928* %r8
%r10 = add i928 %r6, %r9
%r12 = getelementptr i32, i32* %r1, i32 0
%r13 = trunc i928 %r10 to i32
store i32 %r13, i32* %r12
%r14 = lshr i928 %r10, 32
%r16 = getelementptr i32, i32* %r1, i32 1
%r17 = trunc i928 %r14 to i32
store i32 %r17, i32* %r16
%r18 = lshr i928 %r14, 32
%r20 = getelementptr i32, i32* %r1, i32 2
%r21 = trunc i928 %r18 to i32
store i32 %r21, i32* %r20
%r22 = lshr i928 %r18, 32
%r24 = getelementptr i32, i32* %r1, i32 3
%r25 = trunc i928 %r22 to i32
store i32 %r25, i32* %r24
%r26 = lshr i928 %r22, 32
%r28 = getelementptr i32, i32* %r1, i32 4
%r29 = trunc i928 %r26 to i32
store i32 %r29, i32* %r28
%r30 = lshr i928 %r26, 32
%r32 = getelementptr i32, i32* %r1, i32 5
%r33 = trunc i928 %r30 to i32
store i32 %r33, i32* %r32
%r34 = lshr i928 %r30, 32
%r36 = getelementptr i32, i32* %r1, i32 6
%r37 = trunc i928 %r34 to i32
store i32 %r37, i32* %r36
%r38 = lshr i928 %r34, 32
%r40 = getelementptr i32, i32* %r1, i32 7
%r41 = trunc i928 %r38 to i32
store i32 %r41, i32* %r40
%r42 = lshr i928 %r38, 32
%r44 = getelementptr i32, i32* %r1, i32 8
%r45 = trunc i928 %r42 to i32
store i32 %r45, i32* %r44
%r46 = lshr i928 %r42, 32
%r48 = getelementptr i32, i32* %r1, i32 9
%r49 = trunc i928 %r46 to i32
store i32 %r49, i32* %r48
%r50 = lshr i928 %r46, 32
%r52 = getelementptr i32, i32* %r1, i32 10
%r53 = trunc i928 %r50 to i32
store i32 %r53, i32* %r52
%r54 = lshr i928 %r50, 32
%r56 = getelementptr i32, i32* %r1, i32 11
%r57 = trunc i928 %r54 to i32
store i32 %r57, i32* %r56
%r58 = lshr i928 %r54, 32
%r60 = getelementptr i32, i32* %r1, i32 12
%r61 = trunc i928 %r58 to i32
store i32 %r61, i32* %r60
%r62 = lshr i928 %r58, 32
%r64 = getelementptr i32, i32* %r1, i32 13
%r65 = trunc i928 %r62 to i32
store i32 %r65, i32* %r64
%r66 = lshr i928 %r62, 32
%r68 = getelementptr i32, i32* %r1, i32 14
%r69 = trunc i928 %r66 to i32
store i32 %r69, i32* %r68
%r70 = lshr i928 %r66, 32
%r72 = getelementptr i32, i32* %r1, i32 15
%r73 = trunc i928 %r70 to i32
store i32 %r73, i32* %r72
%r74 = lshr i928 %r70, 32
%r76 = getelementptr i32, i32* %r1, i32 16
%r77 = trunc i928 %r74 to i32
store i32 %r77, i32* %r76
%r78 = lshr i928 %r74, 32
%r80 = getelementptr i32, i32* %r1, i32 17
%r81 = trunc i928 %r78 to i32
store i32 %r81, i32* %r80
%r82 = lshr i928 %r78, 32
%r84 = getelementptr i32, i32* %r1, i32 18
%r85 = trunc i928 %r82 to i32
store i32 %r85, i32* %r84
%r86 = lshr i928 %r82, 32
%r88 = getelementptr i32, i32* %r1, i32 19
%r89 = trunc i928 %r86 to i32
store i32 %r89, i32* %r88
%r90 = lshr i928 %r86, 32
%r92 = getelementptr i32, i32* %r1, i32 20
%r93 = trunc i928 %r90 to i32
store i32 %r93, i32* %r92
%r94 = lshr i928 %r90, 32
%r96 = getelementptr i32, i32* %r1, i32 21
%r97 = trunc i928 %r94 to i32
store i32 %r97, i32* %r96
%r98 = lshr i928 %r94, 32
%r100 = getelementptr i32, i32* %r1, i32 22
%r101 = trunc i928 %r98 to i32
store i32 %r101, i32* %r100
%r102 = lshr i928 %r98, 32
%r104 = getelementptr i32, i32* %r1, i32 23
%r105 = trunc i928 %r102 to i32
store i32 %r105, i32* %r104
%r106 = lshr i928 %r102, 32
%r108 = getelementptr i32, i32* %r1, i32 24
%r109 = trunc i928 %r106 to i32
store i32 %r109, i32* %r108
%r110 = lshr i928 %r106, 32
%r112 = getelementptr i32, i32* %r1, i32 25
%r113 = trunc i928 %r110 to i32
store i32 %r113, i32* %r112
%r114 = lshr i928 %r110, 32
%r116 = getelementptr i32, i32* %r1, i32 26
%r117 = trunc i928 %r114 to i32
store i32 %r117, i32* %r116
%r118 = lshr i928 %r114, 32
%r120 = getelementptr i32, i32* %r1, i32 27
%r121 = trunc i928 %r118 to i32
store i32 %r121, i32* %r120
%r122 = lshr i928 %r118, 32
%r124 = getelementptr i32, i32* %r1, i32 28
%r125 = trunc i928 %r122 to i32
store i32 %r125, i32* %r124
ret void
}
define i32 @mclb_subNF29(i32* noalias  %r2, i32* noalias  %r3, i32* noalias  %r4)
{
%r6 = bitcast i32* %r3 to i928*
%r7 = load i928, i928* %r6
%r9 = bitcast i32* %r4 to i928*
%r10 = load i928, i928* %r9
%r11 = sub i928 %r7, %r10
%r13 = getelementptr i32, i32* %r2, i32 0
%r14 = trunc i928 %r11 to i32
store i32 %r14, i32* %r13
%r15 = lshr i928 %r11, 32
%r17 = getelementptr i32, i32* %r2, i32 1
%r18 = trunc i928 %r15 to i32
store i32 %r18, i32* %r17
%r19 = lshr i928 %r15, 32
%r21 = getelementptr i32, i32* %r2, i32 2
%r22 = trunc i928 %r19 to i32
store i32 %r22, i32* %r21
%r23 = lshr i928 %r19, 32
%r25 = getelementptr i32, i32* %r2, i32 3
%r26 = trunc i928 %r23 to i32
store i32 %r26, i32* %r25
%r27 = lshr i928 %r23, 32
%r29 = getelementptr i32, i32* %r2, i32 4
%r30 = trunc i928 %r27 to i32
store i32 %r30, i32* %r29
%r31 = lshr i928 %r27, 32
%r33 = getelementptr i32, i32* %r2, i32 5
%r34 = trunc i928 %r31 to i32
store i32 %r34, i32* %r33
%r35 = lshr i928 %r31, 32
%r37 = getelementptr i32, i32* %r2, i32 6
%r38 = trunc i928 %r35 to i32
store i32 %r38, i32* %r37
%r39 = lshr i928 %r35, 32
%r41 = getelementptr i32, i32* %r2, i32 7
%r42 = trunc i928 %r39 to i32
store i32 %r42, i32* %r41
%r43 = lshr i928 %r39, 32
%r45 = getelementptr i32, i32* %r2, i32 8
%r46 = trunc i928 %r43 to i32
store i32 %r46, i32* %r45
%r47 = lshr i928 %r43, 32
%r49 = getelementptr i32, i32* %r2, i32 9
%r50 = trunc i928 %r47 to i32
store i32 %r50, i32* %r49
%r51 = lshr i928 %r47, 32
%r53 = getelementptr i32, i32* %r2, i32 10
%r54 = trunc i928 %r51 to i32
store i32 %r54, i32* %r53
%r55 = lshr i928 %r51, 32
%r57 = getelementptr i32, i32* %r2, i32 11
%r58 = trunc i928 %r55 to i32
store i32 %r58, i32* %r57
%r59 = lshr i928 %r55, 32
%r61 = getelementptr i32, i32* %r2, i32 12
%r62 = trunc i928 %r59 to i32
store i32 %r62, i32* %r61
%r63 = lshr i928 %r59, 32
%r65 = getelementptr i32, i32* %r2, i32 13
%r66 = trunc i928 %r63 to i32
store i32 %r66, i32* %r65
%r67 = lshr i928 %r63, 32
%r69 = getelementptr i32, i32* %r2, i32 14
%r70 = trunc i928 %r67 to i32
store i32 %r70, i32* %r69
%r71 = lshr i928 %r67, 32
%r73 = getelementptr i32, i32* %r2, i32 15
%r74 = trunc i928 %r71 to i32
store i32 %r74, i32* %r73
%r75 = lshr i928 %r71, 32
%r77 = getelementptr i32, i32* %r2, i32 16
%r78 = trunc i928 %r75 to i32
store i32 %r78, i32* %r77
%r79 = lshr i928 %r75, 32
%r81 = getelementptr i32, i32* %r2, i32 17
%r82 = trunc i928 %r79 to i32
store i32 %r82, i32* %r81
%r83 = lshr i928 %r79, 32
%r85 = getelementptr i32, i32* %r2, i32 18
%r86 = trunc i928 %r83 to i32
store i32 %r86, i32* %r85
%r87 = lshr i928 %r83, 32
%r89 = getelementptr i32, i32* %r2, i32 19
%r90 = trunc i928 %r87 to i32
store i32 %r90, i32* %r89
%r91 = lshr i928 %r87, 32
%r93 = getelementptr i32, i32* %r2, i32 20
%r94 = trunc i928 %r91 to i32
store i32 %r94, i32* %r93
%r95 = lshr i928 %r91, 32
%r97 = getelementptr i32, i32* %r2, i32 21
%r98 = trunc i928 %r95 to i32
store i32 %r98, i32* %r97
%r99 = lshr i928 %r95, 32
%r101 = getelementptr i32, i32* %r2, i32 22
%r102 = trunc i928 %r99 to i32
store i32 %r102, i32* %r101
%r103 = lshr i928 %r99, 32
%r105 = getelementptr i32, i32* %r2, i32 23
%r106 = trunc i928 %r103 to i32
store i32 %r106, i32* %r105
%r107 = lshr i928 %r103, 32
%r109 = getelementptr i32, i32* %r2, i32 24
%r110 = trunc i928 %r107 to i32
store i32 %r110, i32* %r109
%r111 = lshr i928 %r107, 32
%r113 = getelementptr i32, i32* %r2, i32 25
%r114 = trunc i928 %r111 to i32
store i32 %r114, i32* %r113
%r115 = lshr i928 %r111, 32
%r117 = getelementptr i32, i32* %r2, i32 26
%r118 = trunc i928 %r115 to i32
store i32 %r118, i32* %r117
%r119 = lshr i928 %r115, 32
%r121 = getelementptr i32, i32* %r2, i32 27
%r122 = trunc i928 %r119 to i32
store i32 %r122, i32* %r121
%r123 = lshr i928 %r119, 32
%r125 = getelementptr i32, i32* %r2, i32 28
%r126 = trunc i928 %r123 to i32
store i32 %r126, i32* %r125
%r127 = lshr i928 %r11, 927
%r128 = trunc i928 %r127 to i32
%r130 = and i32 %r128, 1
ret i32 %r130
}
define i32 @mclb_add30(i32* noalias  %r2, i32* noalias  %r3, i32* noalias  %r4)
{
%r6 = bitcast i32* %r3 to i960*
%r7 = load i960, i960* %r6
%r8 = zext i960 %r7 to i992
%r10 = bitcast i32* %r4 to i960*
%r11 = load i960, i960* %r10
%r12 = zext i960 %r11 to i992
%r13 = add i992 %r8, %r12
%r14 = trunc i992 %r13 to i960
%r16 = getelementptr i32, i32* %r2, i32 0
%r17 = trunc i960 %r14 to i32
store i32 %r17, i32* %r16
%r18 = lshr i960 %r14, 32
%r20 = getelementptr i32, i32* %r2, i32 1
%r21 = trunc i960 %r18 to i32
store i32 %r21, i32* %r20
%r22 = lshr i960 %r18, 32
%r24 = getelementptr i32, i32* %r2, i32 2
%r25 = trunc i960 %r22 to i32
store i32 %r25, i32* %r24
%r26 = lshr i960 %r22, 32
%r28 = getelementptr i32, i32* %r2, i32 3
%r29 = trunc i960 %r26 to i32
store i32 %r29, i32* %r28
%r30 = lshr i960 %r26, 32
%r32 = getelementptr i32, i32* %r2, i32 4
%r33 = trunc i960 %r30 to i32
store i32 %r33, i32* %r32
%r34 = lshr i960 %r30, 32
%r36 = getelementptr i32, i32* %r2, i32 5
%r37 = trunc i960 %r34 to i32
store i32 %r37, i32* %r36
%r38 = lshr i960 %r34, 32
%r40 = getelementptr i32, i32* %r2, i32 6
%r41 = trunc i960 %r38 to i32
store i32 %r41, i32* %r40
%r42 = lshr i960 %r38, 32
%r44 = getelementptr i32, i32* %r2, i32 7
%r45 = trunc i960 %r42 to i32
store i32 %r45, i32* %r44
%r46 = lshr i960 %r42, 32
%r48 = getelementptr i32, i32* %r2, i32 8
%r49 = trunc i960 %r46 to i32
store i32 %r49, i32* %r48
%r50 = lshr i960 %r46, 32
%r52 = getelementptr i32, i32* %r2, i32 9
%r53 = trunc i960 %r50 to i32
store i32 %r53, i32* %r52
%r54 = lshr i960 %r50, 32
%r56 = getelementptr i32, i32* %r2, i32 10
%r57 = trunc i960 %r54 to i32
store i32 %r57, i32* %r56
%r58 = lshr i960 %r54, 32
%r60 = getelementptr i32, i32* %r2, i32 11
%r61 = trunc i960 %r58 to i32
store i32 %r61, i32* %r60
%r62 = lshr i960 %r58, 32
%r64 = getelementptr i32, i32* %r2, i32 12
%r65 = trunc i960 %r62 to i32
store i32 %r65, i32* %r64
%r66 = lshr i960 %r62, 32
%r68 = getelementptr i32, i32* %r2, i32 13
%r69 = trunc i960 %r66 to i32
store i32 %r69, i32* %r68
%r70 = lshr i960 %r66, 32
%r72 = getelementptr i32, i32* %r2, i32 14
%r73 = trunc i960 %r70 to i32
store i32 %r73, i32* %r72
%r74 = lshr i960 %r70, 32
%r76 = getelementptr i32, i32* %r2, i32 15
%r77 = trunc i960 %r74 to i32
store i32 %r77, i32* %r76
%r78 = lshr i960 %r74, 32
%r80 = getelementptr i32, i32* %r2, i32 16
%r81 = trunc i960 %r78 to i32
store i32 %r81, i32* %r80
%r82 = lshr i960 %r78, 32
%r84 = getelementptr i32, i32* %r2, i32 17
%r85 = trunc i960 %r82 to i32
store i32 %r85, i32* %r84
%r86 = lshr i960 %r82, 32
%r88 = getelementptr i32, i32* %r2, i32 18
%r89 = trunc i960 %r86 to i32
store i32 %r89, i32* %r88
%r90 = lshr i960 %r86, 32
%r92 = getelementptr i32, i32* %r2, i32 19
%r93 = trunc i960 %r90 to i32
store i32 %r93, i32* %r92
%r94 = lshr i960 %r90, 32
%r96 = getelementptr i32, i32* %r2, i32 20
%r97 = trunc i960 %r94 to i32
store i32 %r97, i32* %r96
%r98 = lshr i960 %r94, 32
%r100 = getelementptr i32, i32* %r2, i32 21
%r101 = trunc i960 %r98 to i32
store i32 %r101, i32* %r100
%r102 = lshr i960 %r98, 32
%r104 = getelementptr i32, i32* %r2, i32 22
%r105 = trunc i960 %r102 to i32
store i32 %r105, i32* %r104
%r106 = lshr i960 %r102, 32
%r108 = getelementptr i32, i32* %r2, i32 23
%r109 = trunc i960 %r106 to i32
store i32 %r109, i32* %r108
%r110 = lshr i960 %r106, 32
%r112 = getelementptr i32, i32* %r2, i32 24
%r113 = trunc i960 %r110 to i32
store i32 %r113, i32* %r112
%r114 = lshr i960 %r110, 32
%r116 = getelementptr i32, i32* %r2, i32 25
%r117 = trunc i960 %r114 to i32
store i32 %r117, i32* %r116
%r118 = lshr i960 %r114, 32
%r120 = getelementptr i32, i32* %r2, i32 26
%r121 = trunc i960 %r118 to i32
store i32 %r121, i32* %r120
%r122 = lshr i960 %r118, 32
%r124 = getelementptr i32, i32* %r2, i32 27
%r125 = trunc i960 %r122 to i32
store i32 %r125, i32* %r124
%r126 = lshr i960 %r122, 32
%r128 = getelementptr i32, i32* %r2, i32 28
%r129 = trunc i960 %r126 to i32
store i32 %r129, i32* %r128
%r130 = lshr i960 %r126, 32
%r132 = getelementptr i32, i32* %r2, i32 29
%r133 = trunc i960 %r130 to i32
store i32 %r133, i32* %r132
%r134 = lshr i992 %r13, 960
%r135 = trunc i992 %r134 to i32
ret i32 %r135
}
define i32 @mclb_sub30(i32* noalias  %r2, i32* noalias  %r3, i32* noalias  %r4)
{
%r6 = bitcast i32* %r3 to i960*
%r7 = load i960, i960* %r6
%r8 = zext i960 %r7 to i992
%r10 = bitcast i32* %r4 to i960*
%r11 = load i960, i960* %r10
%r12 = zext i960 %r11 to i992
%r13 = sub i992 %r8, %r12
%r14 = trunc i992 %r13 to i960
%r16 = getelementptr i32, i32* %r2, i32 0
%r17 = trunc i960 %r14 to i32
store i32 %r17, i32* %r16
%r18 = lshr i960 %r14, 32
%r20 = getelementptr i32, i32* %r2, i32 1
%r21 = trunc i960 %r18 to i32
store i32 %r21, i32* %r20
%r22 = lshr i960 %r18, 32
%r24 = getelementptr i32, i32* %r2, i32 2
%r25 = trunc i960 %r22 to i32
store i32 %r25, i32* %r24
%r26 = lshr i960 %r22, 32
%r28 = getelementptr i32, i32* %r2, i32 3
%r29 = trunc i960 %r26 to i32
store i32 %r29, i32* %r28
%r30 = lshr i960 %r26, 32
%r32 = getelementptr i32, i32* %r2, i32 4
%r33 = trunc i960 %r30 to i32
store i32 %r33, i32* %r32
%r34 = lshr i960 %r30, 32
%r36 = getelementptr i32, i32* %r2, i32 5
%r37 = trunc i960 %r34 to i32
store i32 %r37, i32* %r36
%r38 = lshr i960 %r34, 32
%r40 = getelementptr i32, i32* %r2, i32 6
%r41 = trunc i960 %r38 to i32
store i32 %r41, i32* %r40
%r42 = lshr i960 %r38, 32
%r44 = getelementptr i32, i32* %r2, i32 7
%r45 = trunc i960 %r42 to i32
store i32 %r45, i32* %r44
%r46 = lshr i960 %r42, 32
%r48 = getelementptr i32, i32* %r2, i32 8
%r49 = trunc i960 %r46 to i32
store i32 %r49, i32* %r48
%r50 = lshr i960 %r46, 32
%r52 = getelementptr i32, i32* %r2, i32 9
%r53 = trunc i960 %r50 to i32
store i32 %r53, i32* %r52
%r54 = lshr i960 %r50, 32
%r56 = getelementptr i32, i32* %r2, i32 10
%r57 = trunc i960 %r54 to i32
store i32 %r57, i32* %r56
%r58 = lshr i960 %r54, 32
%r60 = getelementptr i32, i32* %r2, i32 11
%r61 = trunc i960 %r58 to i32
store i32 %r61, i32* %r60
%r62 = lshr i960 %r58, 32
%r64 = getelementptr i32, i32* %r2, i32 12
%r65 = trunc i960 %r62 to i32
store i32 %r65, i32* %r64
%r66 = lshr i960 %r62, 32
%r68 = getelementptr i32, i32* %r2, i32 13
%r69 = trunc i960 %r66 to i32
store i32 %r69, i32* %r68
%r70 = lshr i960 %r66, 32
%r72 = getelementptr i32, i32* %r2, i32 14
%r73 = trunc i960 %r70 to i32
store i32 %r73, i32* %r72
%r74 = lshr i960 %r70, 32
%r76 = getelementptr i32, i32* %r2, i32 15
%r77 = trunc i960 %r74 to i32
store i32 %r77, i32* %r76
%r78 = lshr i960 %r74, 32
%r80 = getelementptr i32, i32* %r2, i32 16
%r81 = trunc i960 %r78 to i32
store i32 %r81, i32* %r80
%r82 = lshr i960 %r78, 32
%r84 = getelementptr i32, i32* %r2, i32 17
%r85 = trunc i960 %r82 to i32
store i32 %r85, i32* %r84
%r86 = lshr i960 %r82, 32
%r88 = getelementptr i32, i32* %r2, i32 18
%r89 = trunc i960 %r86 to i32
store i32 %r89, i32* %r88
%r90 = lshr i960 %r86, 32
%r92 = getelementptr i32, i32* %r2, i32 19
%r93 = trunc i960 %r90 to i32
store i32 %r93, i32* %r92
%r94 = lshr i960 %r90, 32
%r96 = getelementptr i32, i32* %r2, i32 20
%r97 = trunc i960 %r94 to i32
store i32 %r97, i32* %r96
%r98 = lshr i960 %r94, 32
%r100 = getelementptr i32, i32* %r2, i32 21
%r101 = trunc i960 %r98 to i32
store i32 %r101, i32* %r100
%r102 = lshr i960 %r98, 32
%r104 = getelementptr i32, i32* %r2, i32 22
%r105 = trunc i960 %r102 to i32
store i32 %r105, i32* %r104
%r106 = lshr i960 %r102, 32
%r108 = getelementptr i32, i32* %r2, i32 23
%r109 = trunc i960 %r106 to i32
store i32 %r109, i32* %r108
%r110 = lshr i960 %r106, 32
%r112 = getelementptr i32, i32* %r2, i32 24
%r113 = trunc i960 %r110 to i32
store i32 %r113, i32* %r112
%r114 = lshr i960 %r110, 32
%r116 = getelementptr i32, i32* %r2, i32 25
%r117 = trunc i960 %r114 to i32
store i32 %r117, i32* %r116
%r118 = lshr i960 %r114, 32
%r120 = getelementptr i32, i32* %r2, i32 26
%r121 = trunc i960 %r118 to i32
store i32 %r121, i32* %r120
%r122 = lshr i960 %r118, 32
%r124 = getelementptr i32, i32* %r2, i32 27
%r125 = trunc i960 %r122 to i32
store i32 %r125, i32* %r124
%r126 = lshr i960 %r122, 32
%r128 = getelementptr i32, i32* %r2, i32 28
%r129 = trunc i960 %r126 to i32
store i32 %r129, i32* %r128
%r130 = lshr i960 %r126, 32
%r132 = getelementptr i32, i32* %r2, i32 29
%r133 = trunc i960 %r130 to i32
store i32 %r133, i32* %r132
%r134 = lshr i992 %r13, 960
%r135 = trunc i992 %r134 to i32
%r137 = and i32 %r135, 1
ret i32 %r137
}
define void @mclb_addNF30(i32* noalias  %r1, i32* noalias  %r2, i32* noalias  %r3)
{
%r5 = bitcast i32* %r2 to i960*
%r6 = load i960, i960* %r5
%r8 = bitcast i32* %r3 to i960*
%r9 = load i960, i960* %r8
%r10 = add i960 %r6, %r9
%r12 = getelementptr i32, i32* %r1, i32 0
%r13 = trunc i960 %r10 to i32
store i32 %r13, i32* %r12
%r14 = lshr i960 %r10, 32
%r16 = getelementptr i32, i32* %r1, i32 1
%r17 = trunc i960 %r14 to i32
store i32 %r17, i32* %r16
%r18 = lshr i960 %r14, 32
%r20 = getelementptr i32, i32* %r1, i32 2
%r21 = trunc i960 %r18 to i32
store i32 %r21, i32* %r20
%r22 = lshr i960 %r18, 32
%r24 = getelementptr i32, i32* %r1, i32 3
%r25 = trunc i960 %r22 to i32
store i32 %r25, i32* %r24
%r26 = lshr i960 %r22, 32
%r28 = getelementptr i32, i32* %r1, i32 4
%r29 = trunc i960 %r26 to i32
store i32 %r29, i32* %r28
%r30 = lshr i960 %r26, 32
%r32 = getelementptr i32, i32* %r1, i32 5
%r33 = trunc i960 %r30 to i32
store i32 %r33, i32* %r32
%r34 = lshr i960 %r30, 32
%r36 = getelementptr i32, i32* %r1, i32 6
%r37 = trunc i960 %r34 to i32
store i32 %r37, i32* %r36
%r38 = lshr i960 %r34, 32
%r40 = getelementptr i32, i32* %r1, i32 7
%r41 = trunc i960 %r38 to i32
store i32 %r41, i32* %r40
%r42 = lshr i960 %r38, 32
%r44 = getelementptr i32, i32* %r1, i32 8
%r45 = trunc i960 %r42 to i32
store i32 %r45, i32* %r44
%r46 = lshr i960 %r42, 32
%r48 = getelementptr i32, i32* %r1, i32 9
%r49 = trunc i960 %r46 to i32
store i32 %r49, i32* %r48
%r50 = lshr i960 %r46, 32
%r52 = getelementptr i32, i32* %r1, i32 10
%r53 = trunc i960 %r50 to i32
store i32 %r53, i32* %r52
%r54 = lshr i960 %r50, 32
%r56 = getelementptr i32, i32* %r1, i32 11
%r57 = trunc i960 %r54 to i32
store i32 %r57, i32* %r56
%r58 = lshr i960 %r54, 32
%r60 = getelementptr i32, i32* %r1, i32 12
%r61 = trunc i960 %r58 to i32
store i32 %r61, i32* %r60
%r62 = lshr i960 %r58, 32
%r64 = getelementptr i32, i32* %r1, i32 13
%r65 = trunc i960 %r62 to i32
store i32 %r65, i32* %r64
%r66 = lshr i960 %r62, 32
%r68 = getelementptr i32, i32* %r1, i32 14
%r69 = trunc i960 %r66 to i32
store i32 %r69, i32* %r68
%r70 = lshr i960 %r66, 32
%r72 = getelementptr i32, i32* %r1, i32 15
%r73 = trunc i960 %r70 to i32
store i32 %r73, i32* %r72
%r74 = lshr i960 %r70, 32
%r76 = getelementptr i32, i32* %r1, i32 16
%r77 = trunc i960 %r74 to i32
store i32 %r77, i32* %r76
%r78 = lshr i960 %r74, 32
%r80 = getelementptr i32, i32* %r1, i32 17
%r81 = trunc i960 %r78 to i32
store i32 %r81, i32* %r80
%r82 = lshr i960 %r78, 32
%r84 = getelementptr i32, i32* %r1, i32 18
%r85 = trunc i960 %r82 to i32
store i32 %r85, i32* %r84
%r86 = lshr i960 %r82, 32
%r88 = getelementptr i32, i32* %r1, i32 19
%r89 = trunc i960 %r86 to i32
store i32 %r89, i32* %r88
%r90 = lshr i960 %r86, 32
%r92 = getelementptr i32, i32* %r1, i32 20
%r93 = trunc i960 %r90 to i32
store i32 %r93, i32* %r92
%r94 = lshr i960 %r90, 32
%r96 = getelementptr i32, i32* %r1, i32 21
%r97 = trunc i960 %r94 to i32
store i32 %r97, i32* %r96
%r98 = lshr i960 %r94, 32
%r100 = getelementptr i32, i32* %r1, i32 22
%r101 = trunc i960 %r98 to i32
store i32 %r101, i32* %r100
%r102 = lshr i960 %r98, 32
%r104 = getelementptr i32, i32* %r1, i32 23
%r105 = trunc i960 %r102 to i32
store i32 %r105, i32* %r104
%r106 = lshr i960 %r102, 32
%r108 = getelementptr i32, i32* %r1, i32 24
%r109 = trunc i960 %r106 to i32
store i32 %r109, i32* %r108
%r110 = lshr i960 %r106, 32
%r112 = getelementptr i32, i32* %r1, i32 25
%r113 = trunc i960 %r110 to i32
store i32 %r113, i32* %r112
%r114 = lshr i960 %r110, 32
%r116 = getelementptr i32, i32* %r1, i32 26
%r117 = trunc i960 %r114 to i32
store i32 %r117, i32* %r116
%r118 = lshr i960 %r114, 32
%r120 = getelementptr i32, i32* %r1, i32 27
%r121 = trunc i960 %r118 to i32
store i32 %r121, i32* %r120
%r122 = lshr i960 %r118, 32
%r124 = getelementptr i32, i32* %r1, i32 28
%r125 = trunc i960 %r122 to i32
store i32 %r125, i32* %r124
%r126 = lshr i960 %r122, 32
%r128 = getelementptr i32, i32* %r1, i32 29
%r129 = trunc i960 %r126 to i32
store i32 %r129, i32* %r128
ret void
}
define i32 @mclb_subNF30(i32* noalias  %r2, i32* noalias  %r3, i32* noalias  %r4)
{
%r6 = bitcast i32* %r3 to i960*
%r7 = load i960, i960* %r6
%r9 = bitcast i32* %r4 to i960*
%r10 = load i960, i960* %r9
%r11 = sub i960 %r7, %r10
%r13 = getelementptr i32, i32* %r2, i32 0
%r14 = trunc i960 %r11 to i32
store i32 %r14, i32* %r13
%r15 = lshr i960 %r11, 32
%r17 = getelementptr i32, i32* %r2, i32 1
%r18 = trunc i960 %r15 to i32
store i32 %r18, i32* %r17
%r19 = lshr i960 %r15, 32
%r21 = getelementptr i32, i32* %r2, i32 2
%r22 = trunc i960 %r19 to i32
store i32 %r22, i32* %r21
%r23 = lshr i960 %r19, 32
%r25 = getelementptr i32, i32* %r2, i32 3
%r26 = trunc i960 %r23 to i32
store i32 %r26, i32* %r25
%r27 = lshr i960 %r23, 32
%r29 = getelementptr i32, i32* %r2, i32 4
%r30 = trunc i960 %r27 to i32
store i32 %r30, i32* %r29
%r31 = lshr i960 %r27, 32
%r33 = getelementptr i32, i32* %r2, i32 5
%r34 = trunc i960 %r31 to i32
store i32 %r34, i32* %r33
%r35 = lshr i960 %r31, 32
%r37 = getelementptr i32, i32* %r2, i32 6
%r38 = trunc i960 %r35 to i32
store i32 %r38, i32* %r37
%r39 = lshr i960 %r35, 32
%r41 = getelementptr i32, i32* %r2, i32 7
%r42 = trunc i960 %r39 to i32
store i32 %r42, i32* %r41
%r43 = lshr i960 %r39, 32
%r45 = getelementptr i32, i32* %r2, i32 8
%r46 = trunc i960 %r43 to i32
store i32 %r46, i32* %r45
%r47 = lshr i960 %r43, 32
%r49 = getelementptr i32, i32* %r2, i32 9
%r50 = trunc i960 %r47 to i32
store i32 %r50, i32* %r49
%r51 = lshr i960 %r47, 32
%r53 = getelementptr i32, i32* %r2, i32 10
%r54 = trunc i960 %r51 to i32
store i32 %r54, i32* %r53
%r55 = lshr i960 %r51, 32
%r57 = getelementptr i32, i32* %r2, i32 11
%r58 = trunc i960 %r55 to i32
store i32 %r58, i32* %r57
%r59 = lshr i960 %r55, 32
%r61 = getelementptr i32, i32* %r2, i32 12
%r62 = trunc i960 %r59 to i32
store i32 %r62, i32* %r61
%r63 = lshr i960 %r59, 32
%r65 = getelementptr i32, i32* %r2, i32 13
%r66 = trunc i960 %r63 to i32
store i32 %r66, i32* %r65
%r67 = lshr i960 %r63, 32
%r69 = getelementptr i32, i32* %r2, i32 14
%r70 = trunc i960 %r67 to i32
store i32 %r70, i32* %r69
%r71 = lshr i960 %r67, 32
%r73 = getelementptr i32, i32* %r2, i32 15
%r74 = trunc i960 %r71 to i32
store i32 %r74, i32* %r73
%r75 = lshr i960 %r71, 32
%r77 = getelementptr i32, i32* %r2, i32 16
%r78 = trunc i960 %r75 to i32
store i32 %r78, i32* %r77
%r79 = lshr i960 %r75, 32
%r81 = getelementptr i32, i32* %r2, i32 17
%r82 = trunc i960 %r79 to i32
store i32 %r82, i32* %r81
%r83 = lshr i960 %r79, 32
%r85 = getelementptr i32, i32* %r2, i32 18
%r86 = trunc i960 %r83 to i32
store i32 %r86, i32* %r85
%r87 = lshr i960 %r83, 32
%r89 = getelementptr i32, i32* %r2, i32 19
%r90 = trunc i960 %r87 to i32
store i32 %r90, i32* %r89
%r91 = lshr i960 %r87, 32
%r93 = getelementptr i32, i32* %r2, i32 20
%r94 = trunc i960 %r91 to i32
store i32 %r94, i32* %r93
%r95 = lshr i960 %r91, 32
%r97 = getelementptr i32, i32* %r2, i32 21
%r98 = trunc i960 %r95 to i32
store i32 %r98, i32* %r97
%r99 = lshr i960 %r95, 32
%r101 = getelementptr i32, i32* %r2, i32 22
%r102 = trunc i960 %r99 to i32
store i32 %r102, i32* %r101
%r103 = lshr i960 %r99, 32
%r105 = getelementptr i32, i32* %r2, i32 23
%r106 = trunc i960 %r103 to i32
store i32 %r106, i32* %r105
%r107 = lshr i960 %r103, 32
%r109 = getelementptr i32, i32* %r2, i32 24
%r110 = trunc i960 %r107 to i32
store i32 %r110, i32* %r109
%r111 = lshr i960 %r107, 32
%r113 = getelementptr i32, i32* %r2, i32 25
%r114 = trunc i960 %r111 to i32
store i32 %r114, i32* %r113
%r115 = lshr i960 %r111, 32
%r117 = getelementptr i32, i32* %r2, i32 26
%r118 = trunc i960 %r115 to i32
store i32 %r118, i32* %r117
%r119 = lshr i960 %r115, 32
%r121 = getelementptr i32, i32* %r2, i32 27
%r122 = trunc i960 %r119 to i32
store i32 %r122, i32* %r121
%r123 = lshr i960 %r119, 32
%r125 = getelementptr i32, i32* %r2, i32 28
%r126 = trunc i960 %r123 to i32
store i32 %r126, i32* %r125
%r127 = lshr i960 %r123, 32
%r129 = getelementptr i32, i32* %r2, i32 29
%r130 = trunc i960 %r127 to i32
store i32 %r130, i32* %r129
%r131 = lshr i960 %r11, 959
%r132 = trunc i960 %r131 to i32
%r134 = and i32 %r132, 1
ret i32 %r134
}
define i32 @mclb_add31(i32* noalias  %r2, i32* noalias  %r3, i32* noalias  %r4)
{
%r6 = bitcast i32* %r3 to i992*
%r7 = load i992, i992* %r6
%r8 = zext i992 %r7 to i1024
%r10 = bitcast i32* %r4 to i992*
%r11 = load i992, i992* %r10
%r12 = zext i992 %r11 to i1024
%r13 = add i1024 %r8, %r12
%r14 = trunc i1024 %r13 to i992
%r16 = getelementptr i32, i32* %r2, i32 0
%r17 = trunc i992 %r14 to i32
store i32 %r17, i32* %r16
%r18 = lshr i992 %r14, 32
%r20 = getelementptr i32, i32* %r2, i32 1
%r21 = trunc i992 %r18 to i32
store i32 %r21, i32* %r20
%r22 = lshr i992 %r18, 32
%r24 = getelementptr i32, i32* %r2, i32 2
%r25 = trunc i992 %r22 to i32
store i32 %r25, i32* %r24
%r26 = lshr i992 %r22, 32
%r28 = getelementptr i32, i32* %r2, i32 3
%r29 = trunc i992 %r26 to i32
store i32 %r29, i32* %r28
%r30 = lshr i992 %r26, 32
%r32 = getelementptr i32, i32* %r2, i32 4
%r33 = trunc i992 %r30 to i32
store i32 %r33, i32* %r32
%r34 = lshr i992 %r30, 32
%r36 = getelementptr i32, i32* %r2, i32 5
%r37 = trunc i992 %r34 to i32
store i32 %r37, i32* %r36
%r38 = lshr i992 %r34, 32
%r40 = getelementptr i32, i32* %r2, i32 6
%r41 = trunc i992 %r38 to i32
store i32 %r41, i32* %r40
%r42 = lshr i992 %r38, 32
%r44 = getelementptr i32, i32* %r2, i32 7
%r45 = trunc i992 %r42 to i32
store i32 %r45, i32* %r44
%r46 = lshr i992 %r42, 32
%r48 = getelementptr i32, i32* %r2, i32 8
%r49 = trunc i992 %r46 to i32
store i32 %r49, i32* %r48
%r50 = lshr i992 %r46, 32
%r52 = getelementptr i32, i32* %r2, i32 9
%r53 = trunc i992 %r50 to i32
store i32 %r53, i32* %r52
%r54 = lshr i992 %r50, 32
%r56 = getelementptr i32, i32* %r2, i32 10
%r57 = trunc i992 %r54 to i32
store i32 %r57, i32* %r56
%r58 = lshr i992 %r54, 32
%r60 = getelementptr i32, i32* %r2, i32 11
%r61 = trunc i992 %r58 to i32
store i32 %r61, i32* %r60
%r62 = lshr i992 %r58, 32
%r64 = getelementptr i32, i32* %r2, i32 12
%r65 = trunc i992 %r62 to i32
store i32 %r65, i32* %r64
%r66 = lshr i992 %r62, 32
%r68 = getelementptr i32, i32* %r2, i32 13
%r69 = trunc i992 %r66 to i32
store i32 %r69, i32* %r68
%r70 = lshr i992 %r66, 32
%r72 = getelementptr i32, i32* %r2, i32 14
%r73 = trunc i992 %r70 to i32
store i32 %r73, i32* %r72
%r74 = lshr i992 %r70, 32
%r76 = getelementptr i32, i32* %r2, i32 15
%r77 = trunc i992 %r74 to i32
store i32 %r77, i32* %r76
%r78 = lshr i992 %r74, 32
%r80 = getelementptr i32, i32* %r2, i32 16
%r81 = trunc i992 %r78 to i32
store i32 %r81, i32* %r80
%r82 = lshr i992 %r78, 32
%r84 = getelementptr i32, i32* %r2, i32 17
%r85 = trunc i992 %r82 to i32
store i32 %r85, i32* %r84
%r86 = lshr i992 %r82, 32
%r88 = getelementptr i32, i32* %r2, i32 18
%r89 = trunc i992 %r86 to i32
store i32 %r89, i32* %r88
%r90 = lshr i992 %r86, 32
%r92 = getelementptr i32, i32* %r2, i32 19
%r93 = trunc i992 %r90 to i32
store i32 %r93, i32* %r92
%r94 = lshr i992 %r90, 32
%r96 = getelementptr i32, i32* %r2, i32 20
%r97 = trunc i992 %r94 to i32
store i32 %r97, i32* %r96
%r98 = lshr i992 %r94, 32
%r100 = getelementptr i32, i32* %r2, i32 21
%r101 = trunc i992 %r98 to i32
store i32 %r101, i32* %r100
%r102 = lshr i992 %r98, 32
%r104 = getelementptr i32, i32* %r2, i32 22
%r105 = trunc i992 %r102 to i32
store i32 %r105, i32* %r104
%r106 = lshr i992 %r102, 32
%r108 = getelementptr i32, i32* %r2, i32 23
%r109 = trunc i992 %r106 to i32
store i32 %r109, i32* %r108
%r110 = lshr i992 %r106, 32
%r112 = getelementptr i32, i32* %r2, i32 24
%r113 = trunc i992 %r110 to i32
store i32 %r113, i32* %r112
%r114 = lshr i992 %r110, 32
%r116 = getelementptr i32, i32* %r2, i32 25
%r117 = trunc i992 %r114 to i32
store i32 %r117, i32* %r116
%r118 = lshr i992 %r114, 32
%r120 = getelementptr i32, i32* %r2, i32 26
%r121 = trunc i992 %r118 to i32
store i32 %r121, i32* %r120
%r122 = lshr i992 %r118, 32
%r124 = getelementptr i32, i32* %r2, i32 27
%r125 = trunc i992 %r122 to i32
store i32 %r125, i32* %r124
%r126 = lshr i992 %r122, 32
%r128 = getelementptr i32, i32* %r2, i32 28
%r129 = trunc i992 %r126 to i32
store i32 %r129, i32* %r128
%r130 = lshr i992 %r126, 32
%r132 = getelementptr i32, i32* %r2, i32 29
%r133 = trunc i992 %r130 to i32
store i32 %r133, i32* %r132
%r134 = lshr i992 %r130, 32
%r136 = getelementptr i32, i32* %r2, i32 30
%r137 = trunc i992 %r134 to i32
store i32 %r137, i32* %r136
%r138 = lshr i1024 %r13, 992
%r139 = trunc i1024 %r138 to i32
ret i32 %r139
}
define i32 @mclb_sub31(i32* noalias  %r2, i32* noalias  %r3, i32* noalias  %r4)
{
%r6 = bitcast i32* %r3 to i992*
%r7 = load i992, i992* %r6
%r8 = zext i992 %r7 to i1024
%r10 = bitcast i32* %r4 to i992*
%r11 = load i992, i992* %r10
%r12 = zext i992 %r11 to i1024
%r13 = sub i1024 %r8, %r12
%r14 = trunc i1024 %r13 to i992
%r16 = getelementptr i32, i32* %r2, i32 0
%r17 = trunc i992 %r14 to i32
store i32 %r17, i32* %r16
%r18 = lshr i992 %r14, 32
%r20 = getelementptr i32, i32* %r2, i32 1
%r21 = trunc i992 %r18 to i32
store i32 %r21, i32* %r20
%r22 = lshr i992 %r18, 32
%r24 = getelementptr i32, i32* %r2, i32 2
%r25 = trunc i992 %r22 to i32
store i32 %r25, i32* %r24
%r26 = lshr i992 %r22, 32
%r28 = getelementptr i32, i32* %r2, i32 3
%r29 = trunc i992 %r26 to i32
store i32 %r29, i32* %r28
%r30 = lshr i992 %r26, 32
%r32 = getelementptr i32, i32* %r2, i32 4
%r33 = trunc i992 %r30 to i32
store i32 %r33, i32* %r32
%r34 = lshr i992 %r30, 32
%r36 = getelementptr i32, i32* %r2, i32 5
%r37 = trunc i992 %r34 to i32
store i32 %r37, i32* %r36
%r38 = lshr i992 %r34, 32
%r40 = getelementptr i32, i32* %r2, i32 6
%r41 = trunc i992 %r38 to i32
store i32 %r41, i32* %r40
%r42 = lshr i992 %r38, 32
%r44 = getelementptr i32, i32* %r2, i32 7
%r45 = trunc i992 %r42 to i32
store i32 %r45, i32* %r44
%r46 = lshr i992 %r42, 32
%r48 = getelementptr i32, i32* %r2, i32 8
%r49 = trunc i992 %r46 to i32
store i32 %r49, i32* %r48
%r50 = lshr i992 %r46, 32
%r52 = getelementptr i32, i32* %r2, i32 9
%r53 = trunc i992 %r50 to i32
store i32 %r53, i32* %r52
%r54 = lshr i992 %r50, 32
%r56 = getelementptr i32, i32* %r2, i32 10
%r57 = trunc i992 %r54 to i32
store i32 %r57, i32* %r56
%r58 = lshr i992 %r54, 32
%r60 = getelementptr i32, i32* %r2, i32 11
%r61 = trunc i992 %r58 to i32
store i32 %r61, i32* %r60
%r62 = lshr i992 %r58, 32
%r64 = getelementptr i32, i32* %r2, i32 12
%r65 = trunc i992 %r62 to i32
store i32 %r65, i32* %r64
%r66 = lshr i992 %r62, 32
%r68 = getelementptr i32, i32* %r2, i32 13
%r69 = trunc i992 %r66 to i32
store i32 %r69, i32* %r68
%r70 = lshr i992 %r66, 32
%r72 = getelementptr i32, i32* %r2, i32 14
%r73 = trunc i992 %r70 to i32
store i32 %r73, i32* %r72
%r74 = lshr i992 %r70, 32
%r76 = getelementptr i32, i32* %r2, i32 15
%r77 = trunc i992 %r74 to i32
store i32 %r77, i32* %r76
%r78 = lshr i992 %r74, 32
%r80 = getelementptr i32, i32* %r2, i32 16
%r81 = trunc i992 %r78 to i32
store i32 %r81, i32* %r80
%r82 = lshr i992 %r78, 32
%r84 = getelementptr i32, i32* %r2, i32 17
%r85 = trunc i992 %r82 to i32
store i32 %r85, i32* %r84
%r86 = lshr i992 %r82, 32
%r88 = getelementptr i32, i32* %r2, i32 18
%r89 = trunc i992 %r86 to i32
store i32 %r89, i32* %r88
%r90 = lshr i992 %r86, 32
%r92 = getelementptr i32, i32* %r2, i32 19
%r93 = trunc i992 %r90 to i32
store i32 %r93, i32* %r92
%r94 = lshr i992 %r90, 32
%r96 = getelementptr i32, i32* %r2, i32 20
%r97 = trunc i992 %r94 to i32
store i32 %r97, i32* %r96
%r98 = lshr i992 %r94, 32
%r100 = getelementptr i32, i32* %r2, i32 21
%r101 = trunc i992 %r98 to i32
store i32 %r101, i32* %r100
%r102 = lshr i992 %r98, 32
%r104 = getelementptr i32, i32* %r2, i32 22
%r105 = trunc i992 %r102 to i32
store i32 %r105, i32* %r104
%r106 = lshr i992 %r102, 32
%r108 = getelementptr i32, i32* %r2, i32 23
%r109 = trunc i992 %r106 to i32
store i32 %r109, i32* %r108
%r110 = lshr i992 %r106, 32
%r112 = getelementptr i32, i32* %r2, i32 24
%r113 = trunc i992 %r110 to i32
store i32 %r113, i32* %r112
%r114 = lshr i992 %r110, 32
%r116 = getelementptr i32, i32* %r2, i32 25
%r117 = trunc i992 %r114 to i32
store i32 %r117, i32* %r116
%r118 = lshr i992 %r114, 32
%r120 = getelementptr i32, i32* %r2, i32 26
%r121 = trunc i992 %r118 to i32
store i32 %r121, i32* %r120
%r122 = lshr i992 %r118, 32
%r124 = getelementptr i32, i32* %r2, i32 27
%r125 = trunc i992 %r122 to i32
store i32 %r125, i32* %r124
%r126 = lshr i992 %r122, 32
%r128 = getelementptr i32, i32* %r2, i32 28
%r129 = trunc i992 %r126 to i32
store i32 %r129, i32* %r128
%r130 = lshr i992 %r126, 32
%r132 = getelementptr i32, i32* %r2, i32 29
%r133 = trunc i992 %r130 to i32
store i32 %r133, i32* %r132
%r134 = lshr i992 %r130, 32
%r136 = getelementptr i32, i32* %r2, i32 30
%r137 = trunc i992 %r134 to i32
store i32 %r137, i32* %r136
%r138 = lshr i1024 %r13, 992
%r139 = trunc i1024 %r138 to i32
%r141 = and i32 %r139, 1
ret i32 %r141
}
define void @mclb_addNF31(i32* noalias  %r1, i32* noalias  %r2, i32* noalias  %r3)
{
%r5 = bitcast i32* %r2 to i992*
%r6 = load i992, i992* %r5
%r8 = bitcast i32* %r3 to i992*
%r9 = load i992, i992* %r8
%r10 = add i992 %r6, %r9
%r12 = getelementptr i32, i32* %r1, i32 0
%r13 = trunc i992 %r10 to i32
store i32 %r13, i32* %r12
%r14 = lshr i992 %r10, 32
%r16 = getelementptr i32, i32* %r1, i32 1
%r17 = trunc i992 %r14 to i32
store i32 %r17, i32* %r16
%r18 = lshr i992 %r14, 32
%r20 = getelementptr i32, i32* %r1, i32 2
%r21 = trunc i992 %r18 to i32
store i32 %r21, i32* %r20
%r22 = lshr i992 %r18, 32
%r24 = getelementptr i32, i32* %r1, i32 3
%r25 = trunc i992 %r22 to i32
store i32 %r25, i32* %r24
%r26 = lshr i992 %r22, 32
%r28 = getelementptr i32, i32* %r1, i32 4
%r29 = trunc i992 %r26 to i32
store i32 %r29, i32* %r28
%r30 = lshr i992 %r26, 32
%r32 = getelementptr i32, i32* %r1, i32 5
%r33 = trunc i992 %r30 to i32
store i32 %r33, i32* %r32
%r34 = lshr i992 %r30, 32
%r36 = getelementptr i32, i32* %r1, i32 6
%r37 = trunc i992 %r34 to i32
store i32 %r37, i32* %r36
%r38 = lshr i992 %r34, 32
%r40 = getelementptr i32, i32* %r1, i32 7
%r41 = trunc i992 %r38 to i32
store i32 %r41, i32* %r40
%r42 = lshr i992 %r38, 32
%r44 = getelementptr i32, i32* %r1, i32 8
%r45 = trunc i992 %r42 to i32
store i32 %r45, i32* %r44
%r46 = lshr i992 %r42, 32
%r48 = getelementptr i32, i32* %r1, i32 9
%r49 = trunc i992 %r46 to i32
store i32 %r49, i32* %r48
%r50 = lshr i992 %r46, 32
%r52 = getelementptr i32, i32* %r1, i32 10
%r53 = trunc i992 %r50 to i32
store i32 %r53, i32* %r52
%r54 = lshr i992 %r50, 32
%r56 = getelementptr i32, i32* %r1, i32 11
%r57 = trunc i992 %r54 to i32
store i32 %r57, i32* %r56
%r58 = lshr i992 %r54, 32
%r60 = getelementptr i32, i32* %r1, i32 12
%r61 = trunc i992 %r58 to i32
store i32 %r61, i32* %r60
%r62 = lshr i992 %r58, 32
%r64 = getelementptr i32, i32* %r1, i32 13
%r65 = trunc i992 %r62 to i32
store i32 %r65, i32* %r64
%r66 = lshr i992 %r62, 32
%r68 = getelementptr i32, i32* %r1, i32 14
%r69 = trunc i992 %r66 to i32
store i32 %r69, i32* %r68
%r70 = lshr i992 %r66, 32
%r72 = getelementptr i32, i32* %r1, i32 15
%r73 = trunc i992 %r70 to i32
store i32 %r73, i32* %r72
%r74 = lshr i992 %r70, 32
%r76 = getelementptr i32, i32* %r1, i32 16
%r77 = trunc i992 %r74 to i32
store i32 %r77, i32* %r76
%r78 = lshr i992 %r74, 32
%r80 = getelementptr i32, i32* %r1, i32 17
%r81 = trunc i992 %r78 to i32
store i32 %r81, i32* %r80
%r82 = lshr i992 %r78, 32
%r84 = getelementptr i32, i32* %r1, i32 18
%r85 = trunc i992 %r82 to i32
store i32 %r85, i32* %r84
%r86 = lshr i992 %r82, 32
%r88 = getelementptr i32, i32* %r1, i32 19
%r89 = trunc i992 %r86 to i32
store i32 %r89, i32* %r88
%r90 = lshr i992 %r86, 32
%r92 = getelementptr i32, i32* %r1, i32 20
%r93 = trunc i992 %r90 to i32
store i32 %r93, i32* %r92
%r94 = lshr i992 %r90, 32
%r96 = getelementptr i32, i32* %r1, i32 21
%r97 = trunc i992 %r94 to i32
store i32 %r97, i32* %r96
%r98 = lshr i992 %r94, 32
%r100 = getelementptr i32, i32* %r1, i32 22
%r101 = trunc i992 %r98 to i32
store i32 %r101, i32* %r100
%r102 = lshr i992 %r98, 32
%r104 = getelementptr i32, i32* %r1, i32 23
%r105 = trunc i992 %r102 to i32
store i32 %r105, i32* %r104
%r106 = lshr i992 %r102, 32
%r108 = getelementptr i32, i32* %r1, i32 24
%r109 = trunc i992 %r106 to i32
store i32 %r109, i32* %r108
%r110 = lshr i992 %r106, 32
%r112 = getelementptr i32, i32* %r1, i32 25
%r113 = trunc i992 %r110 to i32
store i32 %r113, i32* %r112
%r114 = lshr i992 %r110, 32
%r116 = getelementptr i32, i32* %r1, i32 26
%r117 = trunc i992 %r114 to i32
store i32 %r117, i32* %r116
%r118 = lshr i992 %r114, 32
%r120 = getelementptr i32, i32* %r1, i32 27
%r121 = trunc i992 %r118 to i32
store i32 %r121, i32* %r120
%r122 = lshr i992 %r118, 32
%r124 = getelementptr i32, i32* %r1, i32 28
%r125 = trunc i992 %r122 to i32
store i32 %r125, i32* %r124
%r126 = lshr i992 %r122, 32
%r128 = getelementptr i32, i32* %r1, i32 29
%r129 = trunc i992 %r126 to i32
store i32 %r129, i32* %r128
%r130 = lshr i992 %r126, 32
%r132 = getelementptr i32, i32* %r1, i32 30
%r133 = trunc i992 %r130 to i32
store i32 %r133, i32* %r132
ret void
}
define i32 @mclb_subNF31(i32* noalias  %r2, i32* noalias  %r3, i32* noalias  %r4)
{
%r6 = bitcast i32* %r3 to i992*
%r7 = load i992, i992* %r6
%r9 = bitcast i32* %r4 to i992*
%r10 = load i992, i992* %r9
%r11 = sub i992 %r7, %r10
%r13 = getelementptr i32, i32* %r2, i32 0
%r14 = trunc i992 %r11 to i32
store i32 %r14, i32* %r13
%r15 = lshr i992 %r11, 32
%r17 = getelementptr i32, i32* %r2, i32 1
%r18 = trunc i992 %r15 to i32
store i32 %r18, i32* %r17
%r19 = lshr i992 %r15, 32
%r21 = getelementptr i32, i32* %r2, i32 2
%r22 = trunc i992 %r19 to i32
store i32 %r22, i32* %r21
%r23 = lshr i992 %r19, 32
%r25 = getelementptr i32, i32* %r2, i32 3
%r26 = trunc i992 %r23 to i32
store i32 %r26, i32* %r25
%r27 = lshr i992 %r23, 32
%r29 = getelementptr i32, i32* %r2, i32 4
%r30 = trunc i992 %r27 to i32
store i32 %r30, i32* %r29
%r31 = lshr i992 %r27, 32
%r33 = getelementptr i32, i32* %r2, i32 5
%r34 = trunc i992 %r31 to i32
store i32 %r34, i32* %r33
%r35 = lshr i992 %r31, 32
%r37 = getelementptr i32, i32* %r2, i32 6
%r38 = trunc i992 %r35 to i32
store i32 %r38, i32* %r37
%r39 = lshr i992 %r35, 32
%r41 = getelementptr i32, i32* %r2, i32 7
%r42 = trunc i992 %r39 to i32
store i32 %r42, i32* %r41
%r43 = lshr i992 %r39, 32
%r45 = getelementptr i32, i32* %r2, i32 8
%r46 = trunc i992 %r43 to i32
store i32 %r46, i32* %r45
%r47 = lshr i992 %r43, 32
%r49 = getelementptr i32, i32* %r2, i32 9
%r50 = trunc i992 %r47 to i32
store i32 %r50, i32* %r49
%r51 = lshr i992 %r47, 32
%r53 = getelementptr i32, i32* %r2, i32 10
%r54 = trunc i992 %r51 to i32
store i32 %r54, i32* %r53
%r55 = lshr i992 %r51, 32
%r57 = getelementptr i32, i32* %r2, i32 11
%r58 = trunc i992 %r55 to i32
store i32 %r58, i32* %r57
%r59 = lshr i992 %r55, 32
%r61 = getelementptr i32, i32* %r2, i32 12
%r62 = trunc i992 %r59 to i32
store i32 %r62, i32* %r61
%r63 = lshr i992 %r59, 32
%r65 = getelementptr i32, i32* %r2, i32 13
%r66 = trunc i992 %r63 to i32
store i32 %r66, i32* %r65
%r67 = lshr i992 %r63, 32
%r69 = getelementptr i32, i32* %r2, i32 14
%r70 = trunc i992 %r67 to i32
store i32 %r70, i32* %r69
%r71 = lshr i992 %r67, 32
%r73 = getelementptr i32, i32* %r2, i32 15
%r74 = trunc i992 %r71 to i32
store i32 %r74, i32* %r73
%r75 = lshr i992 %r71, 32
%r77 = getelementptr i32, i32* %r2, i32 16
%r78 = trunc i992 %r75 to i32
store i32 %r78, i32* %r77
%r79 = lshr i992 %r75, 32
%r81 = getelementptr i32, i32* %r2, i32 17
%r82 = trunc i992 %r79 to i32
store i32 %r82, i32* %r81
%r83 = lshr i992 %r79, 32
%r85 = getelementptr i32, i32* %r2, i32 18
%r86 = trunc i992 %r83 to i32
store i32 %r86, i32* %r85
%r87 = lshr i992 %r83, 32
%r89 = getelementptr i32, i32* %r2, i32 19
%r90 = trunc i992 %r87 to i32
store i32 %r90, i32* %r89
%r91 = lshr i992 %r87, 32
%r93 = getelementptr i32, i32* %r2, i32 20
%r94 = trunc i992 %r91 to i32
store i32 %r94, i32* %r93
%r95 = lshr i992 %r91, 32
%r97 = getelementptr i32, i32* %r2, i32 21
%r98 = trunc i992 %r95 to i32
store i32 %r98, i32* %r97
%r99 = lshr i992 %r95, 32
%r101 = getelementptr i32, i32* %r2, i32 22
%r102 = trunc i992 %r99 to i32
store i32 %r102, i32* %r101
%r103 = lshr i992 %r99, 32
%r105 = getelementptr i32, i32* %r2, i32 23
%r106 = trunc i992 %r103 to i32
store i32 %r106, i32* %r105
%r107 = lshr i992 %r103, 32
%r109 = getelementptr i32, i32* %r2, i32 24
%r110 = trunc i992 %r107 to i32
store i32 %r110, i32* %r109
%r111 = lshr i992 %r107, 32
%r113 = getelementptr i32, i32* %r2, i32 25
%r114 = trunc i992 %r111 to i32
store i32 %r114, i32* %r113
%r115 = lshr i992 %r111, 32
%r117 = getelementptr i32, i32* %r2, i32 26
%r118 = trunc i992 %r115 to i32
store i32 %r118, i32* %r117
%r119 = lshr i992 %r115, 32
%r121 = getelementptr i32, i32* %r2, i32 27
%r122 = trunc i992 %r119 to i32
store i32 %r122, i32* %r121
%r123 = lshr i992 %r119, 32
%r125 = getelementptr i32, i32* %r2, i32 28
%r126 = trunc i992 %r123 to i32
store i32 %r126, i32* %r125
%r127 = lshr i992 %r123, 32
%r129 = getelementptr i32, i32* %r2, i32 29
%r130 = trunc i992 %r127 to i32
store i32 %r130, i32* %r129
%r131 = lshr i992 %r127, 32
%r133 = getelementptr i32, i32* %r2, i32 30
%r134 = trunc i992 %r131 to i32
store i32 %r134, i32* %r133
%r135 = lshr i992 %r11, 991
%r136 = trunc i992 %r135 to i32
%r138 = and i32 %r136, 1
ret i32 %r138
}
define i32 @mclb_add32(i32* noalias  %r2, i32* noalias  %r3, i32* noalias  %r4)
{
%r6 = bitcast i32* %r3 to i1024*
%r7 = load i1024, i1024* %r6
%r8 = zext i1024 %r7 to i1056
%r10 = bitcast i32* %r4 to i1024*
%r11 = load i1024, i1024* %r10
%r12 = zext i1024 %r11 to i1056
%r13 = add i1056 %r8, %r12
%r14 = trunc i1056 %r13 to i1024
%r16 = getelementptr i32, i32* %r2, i32 0
%r17 = trunc i1024 %r14 to i32
store i32 %r17, i32* %r16
%r18 = lshr i1024 %r14, 32
%r20 = getelementptr i32, i32* %r2, i32 1
%r21 = trunc i1024 %r18 to i32
store i32 %r21, i32* %r20
%r22 = lshr i1024 %r18, 32
%r24 = getelementptr i32, i32* %r2, i32 2
%r25 = trunc i1024 %r22 to i32
store i32 %r25, i32* %r24
%r26 = lshr i1024 %r22, 32
%r28 = getelementptr i32, i32* %r2, i32 3
%r29 = trunc i1024 %r26 to i32
store i32 %r29, i32* %r28
%r30 = lshr i1024 %r26, 32
%r32 = getelementptr i32, i32* %r2, i32 4
%r33 = trunc i1024 %r30 to i32
store i32 %r33, i32* %r32
%r34 = lshr i1024 %r30, 32
%r36 = getelementptr i32, i32* %r2, i32 5
%r37 = trunc i1024 %r34 to i32
store i32 %r37, i32* %r36
%r38 = lshr i1024 %r34, 32
%r40 = getelementptr i32, i32* %r2, i32 6
%r41 = trunc i1024 %r38 to i32
store i32 %r41, i32* %r40
%r42 = lshr i1024 %r38, 32
%r44 = getelementptr i32, i32* %r2, i32 7
%r45 = trunc i1024 %r42 to i32
store i32 %r45, i32* %r44
%r46 = lshr i1024 %r42, 32
%r48 = getelementptr i32, i32* %r2, i32 8
%r49 = trunc i1024 %r46 to i32
store i32 %r49, i32* %r48
%r50 = lshr i1024 %r46, 32
%r52 = getelementptr i32, i32* %r2, i32 9
%r53 = trunc i1024 %r50 to i32
store i32 %r53, i32* %r52
%r54 = lshr i1024 %r50, 32
%r56 = getelementptr i32, i32* %r2, i32 10
%r57 = trunc i1024 %r54 to i32
store i32 %r57, i32* %r56
%r58 = lshr i1024 %r54, 32
%r60 = getelementptr i32, i32* %r2, i32 11
%r61 = trunc i1024 %r58 to i32
store i32 %r61, i32* %r60
%r62 = lshr i1024 %r58, 32
%r64 = getelementptr i32, i32* %r2, i32 12
%r65 = trunc i1024 %r62 to i32
store i32 %r65, i32* %r64
%r66 = lshr i1024 %r62, 32
%r68 = getelementptr i32, i32* %r2, i32 13
%r69 = trunc i1024 %r66 to i32
store i32 %r69, i32* %r68
%r70 = lshr i1024 %r66, 32
%r72 = getelementptr i32, i32* %r2, i32 14
%r73 = trunc i1024 %r70 to i32
store i32 %r73, i32* %r72
%r74 = lshr i1024 %r70, 32
%r76 = getelementptr i32, i32* %r2, i32 15
%r77 = trunc i1024 %r74 to i32
store i32 %r77, i32* %r76
%r78 = lshr i1024 %r74, 32
%r80 = getelementptr i32, i32* %r2, i32 16
%r81 = trunc i1024 %r78 to i32
store i32 %r81, i32* %r80
%r82 = lshr i1024 %r78, 32
%r84 = getelementptr i32, i32* %r2, i32 17
%r85 = trunc i1024 %r82 to i32
store i32 %r85, i32* %r84
%r86 = lshr i1024 %r82, 32
%r88 = getelementptr i32, i32* %r2, i32 18
%r89 = trunc i1024 %r86 to i32
store i32 %r89, i32* %r88
%r90 = lshr i1024 %r86, 32
%r92 = getelementptr i32, i32* %r2, i32 19
%r93 = trunc i1024 %r90 to i32
store i32 %r93, i32* %r92
%r94 = lshr i1024 %r90, 32
%r96 = getelementptr i32, i32* %r2, i32 20
%r97 = trunc i1024 %r94 to i32
store i32 %r97, i32* %r96
%r98 = lshr i1024 %r94, 32
%r100 = getelementptr i32, i32* %r2, i32 21
%r101 = trunc i1024 %r98 to i32
store i32 %r101, i32* %r100
%r102 = lshr i1024 %r98, 32
%r104 = getelementptr i32, i32* %r2, i32 22
%r105 = trunc i1024 %r102 to i32
store i32 %r105, i32* %r104
%r106 = lshr i1024 %r102, 32
%r108 = getelementptr i32, i32* %r2, i32 23
%r109 = trunc i1024 %r106 to i32
store i32 %r109, i32* %r108
%r110 = lshr i1024 %r106, 32
%r112 = getelementptr i32, i32* %r2, i32 24
%r113 = trunc i1024 %r110 to i32
store i32 %r113, i32* %r112
%r114 = lshr i1024 %r110, 32
%r116 = getelementptr i32, i32* %r2, i32 25
%r117 = trunc i1024 %r114 to i32
store i32 %r117, i32* %r116
%r118 = lshr i1024 %r114, 32
%r120 = getelementptr i32, i32* %r2, i32 26
%r121 = trunc i1024 %r118 to i32
store i32 %r121, i32* %r120
%r122 = lshr i1024 %r118, 32
%r124 = getelementptr i32, i32* %r2, i32 27
%r125 = trunc i1024 %r122 to i32
store i32 %r125, i32* %r124
%r126 = lshr i1024 %r122, 32
%r128 = getelementptr i32, i32* %r2, i32 28
%r129 = trunc i1024 %r126 to i32
store i32 %r129, i32* %r128
%r130 = lshr i1024 %r126, 32
%r132 = getelementptr i32, i32* %r2, i32 29
%r133 = trunc i1024 %r130 to i32
store i32 %r133, i32* %r132
%r134 = lshr i1024 %r130, 32
%r136 = getelementptr i32, i32* %r2, i32 30
%r137 = trunc i1024 %r134 to i32
store i32 %r137, i32* %r136
%r138 = lshr i1024 %r134, 32
%r140 = getelementptr i32, i32* %r2, i32 31
%r141 = trunc i1024 %r138 to i32
store i32 %r141, i32* %r140
%r142 = lshr i1056 %r13, 1024
%r143 = trunc i1056 %r142 to i32
ret i32 %r143
}
define i32 @mclb_sub32(i32* noalias  %r2, i32* noalias  %r3, i32* noalias  %r4)
{
%r6 = bitcast i32* %r3 to i1024*
%r7 = load i1024, i1024* %r6
%r8 = zext i1024 %r7 to i1056
%r10 = bitcast i32* %r4 to i1024*
%r11 = load i1024, i1024* %r10
%r12 = zext i1024 %r11 to i1056
%r13 = sub i1056 %r8, %r12
%r14 = trunc i1056 %r13 to i1024
%r16 = getelementptr i32, i32* %r2, i32 0
%r17 = trunc i1024 %r14 to i32
store i32 %r17, i32* %r16
%r18 = lshr i1024 %r14, 32
%r20 = getelementptr i32, i32* %r2, i32 1
%r21 = trunc i1024 %r18 to i32
store i32 %r21, i32* %r20
%r22 = lshr i1024 %r18, 32
%r24 = getelementptr i32, i32* %r2, i32 2
%r25 = trunc i1024 %r22 to i32
store i32 %r25, i32* %r24
%r26 = lshr i1024 %r22, 32
%r28 = getelementptr i32, i32* %r2, i32 3
%r29 = trunc i1024 %r26 to i32
store i32 %r29, i32* %r28
%r30 = lshr i1024 %r26, 32
%r32 = getelementptr i32, i32* %r2, i32 4
%r33 = trunc i1024 %r30 to i32
store i32 %r33, i32* %r32
%r34 = lshr i1024 %r30, 32
%r36 = getelementptr i32, i32* %r2, i32 5
%r37 = trunc i1024 %r34 to i32
store i32 %r37, i32* %r36
%r38 = lshr i1024 %r34, 32
%r40 = getelementptr i32, i32* %r2, i32 6
%r41 = trunc i1024 %r38 to i32
store i32 %r41, i32* %r40
%r42 = lshr i1024 %r38, 32
%r44 = getelementptr i32, i32* %r2, i32 7
%r45 = trunc i1024 %r42 to i32
store i32 %r45, i32* %r44
%r46 = lshr i1024 %r42, 32
%r48 = getelementptr i32, i32* %r2, i32 8
%r49 = trunc i1024 %r46 to i32
store i32 %r49, i32* %r48
%r50 = lshr i1024 %r46, 32
%r52 = getelementptr i32, i32* %r2, i32 9
%r53 = trunc i1024 %r50 to i32
store i32 %r53, i32* %r52
%r54 = lshr i1024 %r50, 32
%r56 = getelementptr i32, i32* %r2, i32 10
%r57 = trunc i1024 %r54 to i32
store i32 %r57, i32* %r56
%r58 = lshr i1024 %r54, 32
%r60 = getelementptr i32, i32* %r2, i32 11
%r61 = trunc i1024 %r58 to i32
store i32 %r61, i32* %r60
%r62 = lshr i1024 %r58, 32
%r64 = getelementptr i32, i32* %r2, i32 12
%r65 = trunc i1024 %r62 to i32
store i32 %r65, i32* %r64
%r66 = lshr i1024 %r62, 32
%r68 = getelementptr i32, i32* %r2, i32 13
%r69 = trunc i1024 %r66 to i32
store i32 %r69, i32* %r68
%r70 = lshr i1024 %r66, 32
%r72 = getelementptr i32, i32* %r2, i32 14
%r73 = trunc i1024 %r70 to i32
store i32 %r73, i32* %r72
%r74 = lshr i1024 %r70, 32
%r76 = getelementptr i32, i32* %r2, i32 15
%r77 = trunc i1024 %r74 to i32
store i32 %r77, i32* %r76
%r78 = lshr i1024 %r74, 32
%r80 = getelementptr i32, i32* %r2, i32 16
%r81 = trunc i1024 %r78 to i32
store i32 %r81, i32* %r80
%r82 = lshr i1024 %r78, 32
%r84 = getelementptr i32, i32* %r2, i32 17
%r85 = trunc i1024 %r82 to i32
store i32 %r85, i32* %r84
%r86 = lshr i1024 %r82, 32
%r88 = getelementptr i32, i32* %r2, i32 18
%r89 = trunc i1024 %r86 to i32
store i32 %r89, i32* %r88
%r90 = lshr i1024 %r86, 32
%r92 = getelementptr i32, i32* %r2, i32 19
%r93 = trunc i1024 %r90 to i32
store i32 %r93, i32* %r92
%r94 = lshr i1024 %r90, 32
%r96 = getelementptr i32, i32* %r2, i32 20
%r97 = trunc i1024 %r94 to i32
store i32 %r97, i32* %r96
%r98 = lshr i1024 %r94, 32
%r100 = getelementptr i32, i32* %r2, i32 21
%r101 = trunc i1024 %r98 to i32
store i32 %r101, i32* %r100
%r102 = lshr i1024 %r98, 32
%r104 = getelementptr i32, i32* %r2, i32 22
%r105 = trunc i1024 %r102 to i32
store i32 %r105, i32* %r104
%r106 = lshr i1024 %r102, 32
%r108 = getelementptr i32, i32* %r2, i32 23
%r109 = trunc i1024 %r106 to i32
store i32 %r109, i32* %r108
%r110 = lshr i1024 %r106, 32
%r112 = getelementptr i32, i32* %r2, i32 24
%r113 = trunc i1024 %r110 to i32
store i32 %r113, i32* %r112
%r114 = lshr i1024 %r110, 32
%r116 = getelementptr i32, i32* %r2, i32 25
%r117 = trunc i1024 %r114 to i32
store i32 %r117, i32* %r116
%r118 = lshr i1024 %r114, 32
%r120 = getelementptr i32, i32* %r2, i32 26
%r121 = trunc i1024 %r118 to i32
store i32 %r121, i32* %r120
%r122 = lshr i1024 %r118, 32
%r124 = getelementptr i32, i32* %r2, i32 27
%r125 = trunc i1024 %r122 to i32
store i32 %r125, i32* %r124
%r126 = lshr i1024 %r122, 32
%r128 = getelementptr i32, i32* %r2, i32 28
%r129 = trunc i1024 %r126 to i32
store i32 %r129, i32* %r128
%r130 = lshr i1024 %r126, 32
%r132 = getelementptr i32, i32* %r2, i32 29
%r133 = trunc i1024 %r130 to i32
store i32 %r133, i32* %r132
%r134 = lshr i1024 %r130, 32
%r136 = getelementptr i32, i32* %r2, i32 30
%r137 = trunc i1024 %r134 to i32
store i32 %r137, i32* %r136
%r138 = lshr i1024 %r134, 32
%r140 = getelementptr i32, i32* %r2, i32 31
%r141 = trunc i1024 %r138 to i32
store i32 %r141, i32* %r140
%r142 = lshr i1056 %r13, 1024
%r143 = trunc i1056 %r142 to i32
%r145 = and i32 %r143, 1
ret i32 %r145
}
define void @mclb_addNF32(i32* noalias  %r1, i32* noalias  %r2, i32* noalias  %r3)
{
%r5 = bitcast i32* %r2 to i1024*
%r6 = load i1024, i1024* %r5
%r8 = bitcast i32* %r3 to i1024*
%r9 = load i1024, i1024* %r8
%r10 = add i1024 %r6, %r9
%r12 = getelementptr i32, i32* %r1, i32 0
%r13 = trunc i1024 %r10 to i32
store i32 %r13, i32* %r12
%r14 = lshr i1024 %r10, 32
%r16 = getelementptr i32, i32* %r1, i32 1
%r17 = trunc i1024 %r14 to i32
store i32 %r17, i32* %r16
%r18 = lshr i1024 %r14, 32
%r20 = getelementptr i32, i32* %r1, i32 2
%r21 = trunc i1024 %r18 to i32
store i32 %r21, i32* %r20
%r22 = lshr i1024 %r18, 32
%r24 = getelementptr i32, i32* %r1, i32 3
%r25 = trunc i1024 %r22 to i32
store i32 %r25, i32* %r24
%r26 = lshr i1024 %r22, 32
%r28 = getelementptr i32, i32* %r1, i32 4
%r29 = trunc i1024 %r26 to i32
store i32 %r29, i32* %r28
%r30 = lshr i1024 %r26, 32
%r32 = getelementptr i32, i32* %r1, i32 5
%r33 = trunc i1024 %r30 to i32
store i32 %r33, i32* %r32
%r34 = lshr i1024 %r30, 32
%r36 = getelementptr i32, i32* %r1, i32 6
%r37 = trunc i1024 %r34 to i32
store i32 %r37, i32* %r36
%r38 = lshr i1024 %r34, 32
%r40 = getelementptr i32, i32* %r1, i32 7
%r41 = trunc i1024 %r38 to i32
store i32 %r41, i32* %r40
%r42 = lshr i1024 %r38, 32
%r44 = getelementptr i32, i32* %r1, i32 8
%r45 = trunc i1024 %r42 to i32
store i32 %r45, i32* %r44
%r46 = lshr i1024 %r42, 32
%r48 = getelementptr i32, i32* %r1, i32 9
%r49 = trunc i1024 %r46 to i32
store i32 %r49, i32* %r48
%r50 = lshr i1024 %r46, 32
%r52 = getelementptr i32, i32* %r1, i32 10
%r53 = trunc i1024 %r50 to i32
store i32 %r53, i32* %r52
%r54 = lshr i1024 %r50, 32
%r56 = getelementptr i32, i32* %r1, i32 11
%r57 = trunc i1024 %r54 to i32
store i32 %r57, i32* %r56
%r58 = lshr i1024 %r54, 32
%r60 = getelementptr i32, i32* %r1, i32 12
%r61 = trunc i1024 %r58 to i32
store i32 %r61, i32* %r60
%r62 = lshr i1024 %r58, 32
%r64 = getelementptr i32, i32* %r1, i32 13
%r65 = trunc i1024 %r62 to i32
store i32 %r65, i32* %r64
%r66 = lshr i1024 %r62, 32
%r68 = getelementptr i32, i32* %r1, i32 14
%r69 = trunc i1024 %r66 to i32
store i32 %r69, i32* %r68
%r70 = lshr i1024 %r66, 32
%r72 = getelementptr i32, i32* %r1, i32 15
%r73 = trunc i1024 %r70 to i32
store i32 %r73, i32* %r72
%r74 = lshr i1024 %r70, 32
%r76 = getelementptr i32, i32* %r1, i32 16
%r77 = trunc i1024 %r74 to i32
store i32 %r77, i32* %r76
%r78 = lshr i1024 %r74, 32
%r80 = getelementptr i32, i32* %r1, i32 17
%r81 = trunc i1024 %r78 to i32
store i32 %r81, i32* %r80
%r82 = lshr i1024 %r78, 32
%r84 = getelementptr i32, i32* %r1, i32 18
%r85 = trunc i1024 %r82 to i32
store i32 %r85, i32* %r84
%r86 = lshr i1024 %r82, 32
%r88 = getelementptr i32, i32* %r1, i32 19
%r89 = trunc i1024 %r86 to i32
store i32 %r89, i32* %r88
%r90 = lshr i1024 %r86, 32
%r92 = getelementptr i32, i32* %r1, i32 20
%r93 = trunc i1024 %r90 to i32
store i32 %r93, i32* %r92
%r94 = lshr i1024 %r90, 32
%r96 = getelementptr i32, i32* %r1, i32 21
%r97 = trunc i1024 %r94 to i32
store i32 %r97, i32* %r96
%r98 = lshr i1024 %r94, 32
%r100 = getelementptr i32, i32* %r1, i32 22
%r101 = trunc i1024 %r98 to i32
store i32 %r101, i32* %r100
%r102 = lshr i1024 %r98, 32
%r104 = getelementptr i32, i32* %r1, i32 23
%r105 = trunc i1024 %r102 to i32
store i32 %r105, i32* %r104
%r106 = lshr i1024 %r102, 32
%r108 = getelementptr i32, i32* %r1, i32 24
%r109 = trunc i1024 %r106 to i32
store i32 %r109, i32* %r108
%r110 = lshr i1024 %r106, 32
%r112 = getelementptr i32, i32* %r1, i32 25
%r113 = trunc i1024 %r110 to i32
store i32 %r113, i32* %r112
%r114 = lshr i1024 %r110, 32
%r116 = getelementptr i32, i32* %r1, i32 26
%r117 = trunc i1024 %r114 to i32
store i32 %r117, i32* %r116
%r118 = lshr i1024 %r114, 32
%r120 = getelementptr i32, i32* %r1, i32 27
%r121 = trunc i1024 %r118 to i32
store i32 %r121, i32* %r120
%r122 = lshr i1024 %r118, 32
%r124 = getelementptr i32, i32* %r1, i32 28
%r125 = trunc i1024 %r122 to i32
store i32 %r125, i32* %r124
%r126 = lshr i1024 %r122, 32
%r128 = getelementptr i32, i32* %r1, i32 29
%r129 = trunc i1024 %r126 to i32
store i32 %r129, i32* %r128
%r130 = lshr i1024 %r126, 32
%r132 = getelementptr i32, i32* %r1, i32 30
%r133 = trunc i1024 %r130 to i32
store i32 %r133, i32* %r132
%r134 = lshr i1024 %r130, 32
%r136 = getelementptr i32, i32* %r1, i32 31
%r137 = trunc i1024 %r134 to i32
store i32 %r137, i32* %r136
ret void
}
define i32 @mclb_subNF32(i32* noalias  %r2, i32* noalias  %r3, i32* noalias  %r4)
{
%r6 = bitcast i32* %r3 to i1024*
%r7 = load i1024, i1024* %r6
%r9 = bitcast i32* %r4 to i1024*
%r10 = load i1024, i1024* %r9
%r11 = sub i1024 %r7, %r10
%r13 = getelementptr i32, i32* %r2, i32 0
%r14 = trunc i1024 %r11 to i32
store i32 %r14, i32* %r13
%r15 = lshr i1024 %r11, 32
%r17 = getelementptr i32, i32* %r2, i32 1
%r18 = trunc i1024 %r15 to i32
store i32 %r18, i32* %r17
%r19 = lshr i1024 %r15, 32
%r21 = getelementptr i32, i32* %r2, i32 2
%r22 = trunc i1024 %r19 to i32
store i32 %r22, i32* %r21
%r23 = lshr i1024 %r19, 32
%r25 = getelementptr i32, i32* %r2, i32 3
%r26 = trunc i1024 %r23 to i32
store i32 %r26, i32* %r25
%r27 = lshr i1024 %r23, 32
%r29 = getelementptr i32, i32* %r2, i32 4
%r30 = trunc i1024 %r27 to i32
store i32 %r30, i32* %r29
%r31 = lshr i1024 %r27, 32
%r33 = getelementptr i32, i32* %r2, i32 5
%r34 = trunc i1024 %r31 to i32
store i32 %r34, i32* %r33
%r35 = lshr i1024 %r31, 32
%r37 = getelementptr i32, i32* %r2, i32 6
%r38 = trunc i1024 %r35 to i32
store i32 %r38, i32* %r37
%r39 = lshr i1024 %r35, 32
%r41 = getelementptr i32, i32* %r2, i32 7
%r42 = trunc i1024 %r39 to i32
store i32 %r42, i32* %r41
%r43 = lshr i1024 %r39, 32
%r45 = getelementptr i32, i32* %r2, i32 8
%r46 = trunc i1024 %r43 to i32
store i32 %r46, i32* %r45
%r47 = lshr i1024 %r43, 32
%r49 = getelementptr i32, i32* %r2, i32 9
%r50 = trunc i1024 %r47 to i32
store i32 %r50, i32* %r49
%r51 = lshr i1024 %r47, 32
%r53 = getelementptr i32, i32* %r2, i32 10
%r54 = trunc i1024 %r51 to i32
store i32 %r54, i32* %r53
%r55 = lshr i1024 %r51, 32
%r57 = getelementptr i32, i32* %r2, i32 11
%r58 = trunc i1024 %r55 to i32
store i32 %r58, i32* %r57
%r59 = lshr i1024 %r55, 32
%r61 = getelementptr i32, i32* %r2, i32 12
%r62 = trunc i1024 %r59 to i32
store i32 %r62, i32* %r61
%r63 = lshr i1024 %r59, 32
%r65 = getelementptr i32, i32* %r2, i32 13
%r66 = trunc i1024 %r63 to i32
store i32 %r66, i32* %r65
%r67 = lshr i1024 %r63, 32
%r69 = getelementptr i32, i32* %r2, i32 14
%r70 = trunc i1024 %r67 to i32
store i32 %r70, i32* %r69
%r71 = lshr i1024 %r67, 32
%r73 = getelementptr i32, i32* %r2, i32 15
%r74 = trunc i1024 %r71 to i32
store i32 %r74, i32* %r73
%r75 = lshr i1024 %r71, 32
%r77 = getelementptr i32, i32* %r2, i32 16
%r78 = trunc i1024 %r75 to i32
store i32 %r78, i32* %r77
%r79 = lshr i1024 %r75, 32
%r81 = getelementptr i32, i32* %r2, i32 17
%r82 = trunc i1024 %r79 to i32
store i32 %r82, i32* %r81
%r83 = lshr i1024 %r79, 32
%r85 = getelementptr i32, i32* %r2, i32 18
%r86 = trunc i1024 %r83 to i32
store i32 %r86, i32* %r85
%r87 = lshr i1024 %r83, 32
%r89 = getelementptr i32, i32* %r2, i32 19
%r90 = trunc i1024 %r87 to i32
store i32 %r90, i32* %r89
%r91 = lshr i1024 %r87, 32
%r93 = getelementptr i32, i32* %r2, i32 20
%r94 = trunc i1024 %r91 to i32
store i32 %r94, i32* %r93
%r95 = lshr i1024 %r91, 32
%r97 = getelementptr i32, i32* %r2, i32 21
%r98 = trunc i1024 %r95 to i32
store i32 %r98, i32* %r97
%r99 = lshr i1024 %r95, 32
%r101 = getelementptr i32, i32* %r2, i32 22
%r102 = trunc i1024 %r99 to i32
store i32 %r102, i32* %r101
%r103 = lshr i1024 %r99, 32
%r105 = getelementptr i32, i32* %r2, i32 23
%r106 = trunc i1024 %r103 to i32
store i32 %r106, i32* %r105
%r107 = lshr i1024 %r103, 32
%r109 = getelementptr i32, i32* %r2, i32 24
%r110 = trunc i1024 %r107 to i32
store i32 %r110, i32* %r109
%r111 = lshr i1024 %r107, 32
%r113 = getelementptr i32, i32* %r2, i32 25
%r114 = trunc i1024 %r111 to i32
store i32 %r114, i32* %r113
%r115 = lshr i1024 %r111, 32
%r117 = getelementptr i32, i32* %r2, i32 26
%r118 = trunc i1024 %r115 to i32
store i32 %r118, i32* %r117
%r119 = lshr i1024 %r115, 32
%r121 = getelementptr i32, i32* %r2, i32 27
%r122 = trunc i1024 %r119 to i32
store i32 %r122, i32* %r121
%r123 = lshr i1024 %r119, 32
%r125 = getelementptr i32, i32* %r2, i32 28
%r126 = trunc i1024 %r123 to i32
store i32 %r126, i32* %r125
%r127 = lshr i1024 %r123, 32
%r129 = getelementptr i32, i32* %r2, i32 29
%r130 = trunc i1024 %r127 to i32
store i32 %r130, i32* %r129
%r131 = lshr i1024 %r127, 32
%r133 = getelementptr i32, i32* %r2, i32 30
%r134 = trunc i1024 %r131 to i32
store i32 %r134, i32* %r133
%r135 = lshr i1024 %r131, 32
%r137 = getelementptr i32, i32* %r2, i32 31
%r138 = trunc i1024 %r135 to i32
store i32 %r138, i32* %r137
%r139 = lshr i1024 %r11, 1023
%r140 = trunc i1024 %r139 to i32
%r142 = and i32 %r140, 1
ret i32 %r142
}
define i64 @mulUnit_inner32(i32* noalias  %r2, i32 %r3)
{
%r5 = call i64 @mulPos32x32(i32* %r2, i32 %r3, i32 0)
%r6 = trunc i64 %r5 to i32
%r7 = call i32 @extractHigh32(i64 %r5)
%r8 = zext i32 %r6 to i64
%r9 = zext i32 %r7 to i64
%r10 = shl i64 %r9, 32
%r11 = add i64 %r8, %r10
ret i64 %r11
}
define i32 @mclb_mulUnit1(i32* noalias  %r2, i32* noalias  %r3, i32 %r4)
{
%r5 = call i64 @mulUnit_inner32(i32* %r3, i32 %r4)
%r6 = trunc i64 %r5 to i32
store i32 %r6, i32* %r2
%r7 = lshr i64 %r5, 32
%r8 = trunc i64 %r7 to i32
ret i32 %r8
}
define i32 @mclb_mulUnitAdd1(i32* noalias  %r2, i32* noalias  %r3, i32 %r4)
{
%r6 = call i64 @mulPos32x32(i32* %r3, i32 %r4, i32 0)
%r7 = trunc i64 %r6 to i32
%r8 = call i32 @extractHigh32(i64 %r6)
%r9 = zext i32 %r7 to i64
%r10 = zext i32 %r8 to i64
%r11 = shl i64 %r10, 32
%r12 = add i64 %r9, %r11
%r13 = load i32, i32* %r2
%r14 = zext i32 %r13 to i64
%r15 = add i64 %r12, %r14
%r16 = trunc i64 %r15 to i32
store i32 %r16, i32* %r2
%r17 = lshr i64 %r15, 32
%r18 = trunc i64 %r17 to i32
ret i32 %r18
}
define void @mclb_mul1(i32* noalias  %r1, i32* noalias  %r2, i32* noalias  %r3)
{
%r4 = load i32, i32* %r2
%r5 = load i32, i32* %r3
%r6 = zext i32 %r4 to i64
%r7 = zext i32 %r5 to i64
%r8 = mul i64 %r6, %r7
%r10 = getelementptr i32, i32* %r1, i32 0
%r11 = trunc i64 %r8 to i32
store i32 %r11, i32* %r10
%r12 = lshr i64 %r8, 32
%r14 = getelementptr i32, i32* %r1, i32 1
%r15 = trunc i64 %r12 to i32
store i32 %r15, i32* %r14
ret void
}
define void @mclb_sqr1(i32* noalias  %r1, i32* noalias  %r2)
{
%r3 = load i32, i32* %r2
%r4 = load i32, i32* %r2
%r5 = zext i32 %r3 to i64
%r6 = zext i32 %r4 to i64
%r7 = mul i64 %r5, %r6
%r9 = getelementptr i32, i32* %r1, i32 0
%r10 = trunc i64 %r7 to i32
store i32 %r10, i32* %r9
%r11 = lshr i64 %r7, 32
%r13 = getelementptr i32, i32* %r1, i32 1
%r14 = trunc i64 %r11 to i32
store i32 %r14, i32* %r13
ret void
}
define i96 @mulUnit_inner64(i32* noalias  %r2, i32 %r3)
{
%r5 = call i64 @mulPos32x32(i32* %r2, i32 %r3, i32 0)
%r6 = trunc i64 %r5 to i32
%r7 = call i32 @extractHigh32(i64 %r5)
%r9 = call i64 @mulPos32x32(i32* %r2, i32 %r3, i32 1)
%r10 = trunc i64 %r9 to i32
%r11 = call i32 @extractHigh32(i64 %r9)
%r12 = zext i32 %r6 to i64
%r13 = zext i32 %r10 to i64
%r14 = shl i64 %r13, 32
%r15 = or i64 %r12, %r14
%r16 = zext i32 %r7 to i64
%r17 = zext i32 %r11 to i64
%r18 = shl i64 %r17, 32
%r19 = or i64 %r16, %r18
%r20 = zext i64 %r15 to i96
%r21 = zext i64 %r19 to i96
%r22 = shl i96 %r21, 32
%r23 = add i96 %r20, %r22
ret i96 %r23
}
define i32 @mclb_mulUnit2(i32* noalias  %r2, i32* noalias  %r3, i32 %r4)
{
%r5 = call i96 @mulUnit_inner64(i32* %r3, i32 %r4)
%r6 = trunc i96 %r5 to i64
%r8 = getelementptr i32, i32* %r2, i32 0
%r9 = trunc i64 %r6 to i32
store i32 %r9, i32* %r8
%r10 = lshr i64 %r6, 32
%r12 = getelementptr i32, i32* %r2, i32 1
%r13 = trunc i64 %r10 to i32
store i32 %r13, i32* %r12
%r14 = lshr i96 %r5, 64
%r15 = trunc i96 %r14 to i32
ret i32 %r15
}
define i32 @mclb_mulUnitAdd2(i32* noalias  %r2, i32* noalias  %r3, i32 %r4)
{
%r6 = call i64 @mulPos32x32(i32* %r3, i32 %r4, i32 0)
%r7 = trunc i64 %r6 to i32
%r8 = call i32 @extractHigh32(i64 %r6)
%r10 = call i64 @mulPos32x32(i32* %r3, i32 %r4, i32 1)
%r11 = trunc i64 %r10 to i32
%r12 = call i32 @extractHigh32(i64 %r10)
%r13 = zext i32 %r7 to i64
%r14 = zext i32 %r11 to i64
%r15 = shl i64 %r14, 32
%r16 = or i64 %r13, %r15
%r17 = zext i32 %r8 to i64
%r18 = zext i32 %r12 to i64
%r19 = shl i64 %r18, 32
%r20 = or i64 %r17, %r19
%r21 = zext i64 %r16 to i96
%r22 = zext i64 %r20 to i96
%r23 = shl i96 %r22, 32
%r24 = add i96 %r21, %r23
%r26 = bitcast i32* %r2 to i64*
%r27 = load i64, i64* %r26
%r28 = zext i64 %r27 to i96
%r29 = add i96 %r24, %r28
%r30 = trunc i96 %r29 to i64
%r32 = getelementptr i32, i32* %r2, i32 0
%r33 = trunc i64 %r30 to i32
store i32 %r33, i32* %r32
%r34 = lshr i64 %r30, 32
%r36 = getelementptr i32, i32* %r2, i32 1
%r37 = trunc i64 %r34 to i32
store i32 %r37, i32* %r36
%r38 = lshr i96 %r29, 64
%r39 = trunc i96 %r38 to i32
ret i32 %r39
}
define void @mclb_mul2(i32* noalias  %r1, i32* noalias  %r2, i32* noalias  %r3)
{
%r4 = load i32, i32* %r3
%r5 = call i96 @mulUnit_inner64(i32* %r2, i32 %r4)
%r6 = trunc i96 %r5 to i32
store i32 %r6, i32* %r1
%r7 = lshr i96 %r5, 32
%r9 = getelementptr i32, i32* %r3, i32 1
%r10 = load i32, i32* %r9
%r11 = call i96 @mulUnit_inner64(i32* %r2, i32 %r10)
%r12 = add i96 %r7, %r11
%r14 = getelementptr i32, i32* %r1, i32 1
%r16 = getelementptr i32, i32* %r14, i32 0
%r17 = trunc i96 %r12 to i32
store i32 %r17, i32* %r16
%r18 = lshr i96 %r12, 32
%r20 = getelementptr i32, i32* %r14, i32 1
%r21 = trunc i96 %r18 to i32
store i32 %r21, i32* %r20
%r22 = lshr i96 %r18, 32
%r24 = getelementptr i32, i32* %r14, i32 2
%r25 = trunc i96 %r22 to i32
store i32 %r25, i32* %r24
ret void
}
define void @mclb_sqr2(i32* noalias  %r1, i32* noalias  %r2)
{
%r3 = load i32, i32* %r2
%r4 = call i96 @mulUnit_inner64(i32* %r2, i32 %r3)
%r5 = trunc i96 %r4 to i32
store i32 %r5, i32* %r1
%r6 = lshr i96 %r4, 32
%r8 = getelementptr i32, i32* %r2, i32 1
%r9 = load i32, i32* %r8
%r10 = call i96 @mulUnit_inner64(i32* %r2, i32 %r9)
%r11 = add i96 %r6, %r10
%r13 = getelementptr i32, i32* %r1, i32 1
%r15 = getelementptr i32, i32* %r13, i32 0
%r16 = trunc i96 %r11 to i32
store i32 %r16, i32* %r15
%r17 = lshr i96 %r11, 32
%r19 = getelementptr i32, i32* %r13, i32 1
%r20 = trunc i96 %r17 to i32
store i32 %r20, i32* %r19
%r21 = lshr i96 %r17, 32
%r23 = getelementptr i32, i32* %r13, i32 2
%r24 = trunc i96 %r21 to i32
store i32 %r24, i32* %r23
ret void
}
define i128 @mulUnit_inner96(i32* noalias  %r2, i32 %r3)
{
%r5 = call i64 @mulPos32x32(i32* %r2, i32 %r3, i32 0)
%r6 = trunc i64 %r5 to i32
%r7 = call i32 @extractHigh32(i64 %r5)
%r9 = call i64 @mulPos32x32(i32* %r2, i32 %r3, i32 1)
%r10 = trunc i64 %r9 to i32
%r11 = call i32 @extractHigh32(i64 %r9)
%r13 = call i64 @mulPos32x32(i32* %r2, i32 %r3, i32 2)
%r14 = trunc i64 %r13 to i32
%r15 = call i32 @extractHigh32(i64 %r13)
%r16 = zext i32 %r6 to i64
%r17 = zext i32 %r10 to i64
%r18 = shl i64 %r17, 32
%r19 = or i64 %r16, %r18
%r20 = zext i64 %r19 to i96
%r21 = zext i32 %r14 to i96
%r22 = shl i96 %r21, 64
%r23 = or i96 %r20, %r22
%r24 = zext i32 %r7 to i64
%r25 = zext i32 %r11 to i64
%r26 = shl i64 %r25, 32
%r27 = or i64 %r24, %r26
%r28 = zext i64 %r27 to i96
%r29 = zext i32 %r15 to i96
%r30 = shl i96 %r29, 64
%r31 = or i96 %r28, %r30
%r32 = zext i96 %r23 to i128
%r33 = zext i96 %r31 to i128
%r34 = shl i128 %r33, 32
%r35 = add i128 %r32, %r34
ret i128 %r35
}
define i32 @mclb_mulUnit3(i32* noalias  %r2, i32* noalias  %r3, i32 %r4)
{
%r5 = call i128 @mulUnit_inner96(i32* %r3, i32 %r4)
%r6 = trunc i128 %r5 to i96
%r8 = getelementptr i32, i32* %r2, i32 0
%r9 = trunc i96 %r6 to i32
store i32 %r9, i32* %r8
%r10 = lshr i96 %r6, 32
%r12 = getelementptr i32, i32* %r2, i32 1
%r13 = trunc i96 %r10 to i32
store i32 %r13, i32* %r12
%r14 = lshr i96 %r10, 32
%r16 = getelementptr i32, i32* %r2, i32 2
%r17 = trunc i96 %r14 to i32
store i32 %r17, i32* %r16
%r18 = lshr i128 %r5, 96
%r19 = trunc i128 %r18 to i32
ret i32 %r19
}
define i32 @mclb_mulUnitAdd3(i32* noalias  %r2, i32* noalias  %r3, i32 %r4)
{
%r6 = call i64 @mulPos32x32(i32* %r3, i32 %r4, i32 0)
%r7 = trunc i64 %r6 to i32
%r8 = call i32 @extractHigh32(i64 %r6)
%r10 = call i64 @mulPos32x32(i32* %r3, i32 %r4, i32 1)
%r11 = trunc i64 %r10 to i32
%r12 = call i32 @extractHigh32(i64 %r10)
%r14 = call i64 @mulPos32x32(i32* %r3, i32 %r4, i32 2)
%r15 = trunc i64 %r14 to i32
%r16 = call i32 @extractHigh32(i64 %r14)
%r17 = zext i32 %r7 to i64
%r18 = zext i32 %r11 to i64
%r19 = shl i64 %r18, 32
%r20 = or i64 %r17, %r19
%r21 = zext i64 %r20 to i96
%r22 = zext i32 %r15 to i96
%r23 = shl i96 %r22, 64
%r24 = or i96 %r21, %r23
%r25 = zext i32 %r8 to i64
%r26 = zext i32 %r12 to i64
%r27 = shl i64 %r26, 32
%r28 = or i64 %r25, %r27
%r29 = zext i64 %r28 to i96
%r30 = zext i32 %r16 to i96
%r31 = shl i96 %r30, 64
%r32 = or i96 %r29, %r31
%r33 = zext i96 %r24 to i128
%r34 = zext i96 %r32 to i128
%r35 = shl i128 %r34, 32
%r36 = add i128 %r33, %r35
%r38 = bitcast i32* %r2 to i96*
%r39 = load i96, i96* %r38
%r40 = zext i96 %r39 to i128
%r41 = add i128 %r36, %r40
%r42 = trunc i128 %r41 to i96
%r44 = getelementptr i32, i32* %r2, i32 0
%r45 = trunc i96 %r42 to i32
store i32 %r45, i32* %r44
%r46 = lshr i96 %r42, 32
%r48 = getelementptr i32, i32* %r2, i32 1
%r49 = trunc i96 %r46 to i32
store i32 %r49, i32* %r48
%r50 = lshr i96 %r46, 32
%r52 = getelementptr i32, i32* %r2, i32 2
%r53 = trunc i96 %r50 to i32
store i32 %r53, i32* %r52
%r54 = lshr i128 %r41, 96
%r55 = trunc i128 %r54 to i32
ret i32 %r55
}
define void @mclb_mul3(i32* noalias  %r1, i32* noalias  %r2, i32* noalias  %r3)
{
%r4 = load i32, i32* %r3
%r5 = call i128 @mulUnit_inner96(i32* %r2, i32 %r4)
%r6 = trunc i128 %r5 to i32
store i32 %r6, i32* %r1
%r7 = lshr i128 %r5, 32
%r9 = getelementptr i32, i32* %r3, i32 1
%r10 = load i32, i32* %r9
%r11 = call i128 @mulUnit_inner96(i32* %r2, i32 %r10)
%r12 = add i128 %r7, %r11
%r13 = trunc i128 %r12 to i32
%r15 = getelementptr i32, i32* %r1, i32 1
store i32 %r13, i32* %r15
%r16 = lshr i128 %r12, 32
%r18 = getelementptr i32, i32* %r3, i32 2
%r19 = load i32, i32* %r18
%r20 = call i128 @mulUnit_inner96(i32* %r2, i32 %r19)
%r21 = add i128 %r16, %r20
%r23 = getelementptr i32, i32* %r1, i32 2
%r25 = getelementptr i32, i32* %r23, i32 0
%r26 = trunc i128 %r21 to i32
store i32 %r26, i32* %r25
%r27 = lshr i128 %r21, 32
%r29 = getelementptr i32, i32* %r23, i32 1
%r30 = trunc i128 %r27 to i32
store i32 %r30, i32* %r29
%r31 = lshr i128 %r27, 32
%r33 = getelementptr i32, i32* %r23, i32 2
%r34 = trunc i128 %r31 to i32
store i32 %r34, i32* %r33
%r35 = lshr i128 %r31, 32
%r37 = getelementptr i32, i32* %r23, i32 3
%r38 = trunc i128 %r35 to i32
store i32 %r38, i32* %r37
ret void
}
define void @mclb_sqr3(i32* noalias  %r1, i32* noalias  %r2)
{
%r3 = load i32, i32* %r2
%r4 = call i128 @mulUnit_inner96(i32* %r2, i32 %r3)
%r5 = trunc i128 %r4 to i32
store i32 %r5, i32* %r1
%r6 = lshr i128 %r4, 32
%r8 = getelementptr i32, i32* %r2, i32 1
%r9 = load i32, i32* %r8
%r10 = call i128 @mulUnit_inner96(i32* %r2, i32 %r9)
%r11 = add i128 %r6, %r10
%r12 = trunc i128 %r11 to i32
%r14 = getelementptr i32, i32* %r1, i32 1
store i32 %r12, i32* %r14
%r15 = lshr i128 %r11, 32
%r17 = getelementptr i32, i32* %r2, i32 2
%r18 = load i32, i32* %r17
%r19 = call i128 @mulUnit_inner96(i32* %r2, i32 %r18)
%r20 = add i128 %r15, %r19
%r22 = getelementptr i32, i32* %r1, i32 2
%r24 = getelementptr i32, i32* %r22, i32 0
%r25 = trunc i128 %r20 to i32
store i32 %r25, i32* %r24
%r26 = lshr i128 %r20, 32
%r28 = getelementptr i32, i32* %r22, i32 1
%r29 = trunc i128 %r26 to i32
store i32 %r29, i32* %r28
%r30 = lshr i128 %r26, 32
%r32 = getelementptr i32, i32* %r22, i32 2
%r33 = trunc i128 %r30 to i32
store i32 %r33, i32* %r32
%r34 = lshr i128 %r30, 32
%r36 = getelementptr i32, i32* %r22, i32 3
%r37 = trunc i128 %r34 to i32
store i32 %r37, i32* %r36
ret void
}
define i160 @mulUnit_inner128(i32* noalias  %r2, i32 %r3)
{
%r5 = call i64 @mulPos32x32(i32* %r2, i32 %r3, i32 0)
%r6 = trunc i64 %r5 to i32
%r7 = call i32 @extractHigh32(i64 %r5)
%r9 = call i64 @mulPos32x32(i32* %r2, i32 %r3, i32 1)
%r10 = trunc i64 %r9 to i32
%r11 = call i32 @extractHigh32(i64 %r9)
%r13 = call i64 @mulPos32x32(i32* %r2, i32 %r3, i32 2)
%r14 = trunc i64 %r13 to i32
%r15 = call i32 @extractHigh32(i64 %r13)
%r17 = call i64 @mulPos32x32(i32* %r2, i32 %r3, i32 3)
%r18 = trunc i64 %r17 to i32
%r19 = call i32 @extractHigh32(i64 %r17)
%r20 = zext i32 %r6 to i64
%r21 = zext i32 %r10 to i64
%r22 = shl i64 %r21, 32
%r23 = or i64 %r20, %r22
%r24 = zext i64 %r23 to i96
%r25 = zext i32 %r14 to i96
%r26 = shl i96 %r25, 64
%r27 = or i96 %r24, %r26
%r28 = zext i96 %r27 to i128
%r29 = zext i32 %r18 to i128
%r30 = shl i128 %r29, 96
%r31 = or i128 %r28, %r30
%r32 = zext i32 %r7 to i64
%r33 = zext i32 %r11 to i64
%r34 = shl i64 %r33, 32
%r35 = or i64 %r32, %r34
%r36 = zext i64 %r35 to i96
%r37 = zext i32 %r15 to i96
%r38 = shl i96 %r37, 64
%r39 = or i96 %r36, %r38
%r40 = zext i96 %r39 to i128
%r41 = zext i32 %r19 to i128
%r42 = shl i128 %r41, 96
%r43 = or i128 %r40, %r42
%r44 = zext i128 %r31 to i160
%r45 = zext i128 %r43 to i160
%r46 = shl i160 %r45, 32
%r47 = add i160 %r44, %r46
ret i160 %r47
}
define i32 @mclb_mulUnit4(i32* noalias  %r2, i32* noalias  %r3, i32 %r4)
{
%r5 = call i160 @mulUnit_inner128(i32* %r3, i32 %r4)
%r6 = trunc i160 %r5 to i128
%r8 = getelementptr i32, i32* %r2, i32 0
%r9 = trunc i128 %r6 to i32
store i32 %r9, i32* %r8
%r10 = lshr i128 %r6, 32
%r12 = getelementptr i32, i32* %r2, i32 1
%r13 = trunc i128 %r10 to i32
store i32 %r13, i32* %r12
%r14 = lshr i128 %r10, 32
%r16 = getelementptr i32, i32* %r2, i32 2
%r17 = trunc i128 %r14 to i32
store i32 %r17, i32* %r16
%r18 = lshr i128 %r14, 32
%r20 = getelementptr i32, i32* %r2, i32 3
%r21 = trunc i128 %r18 to i32
store i32 %r21, i32* %r20
%r22 = lshr i160 %r5, 128
%r23 = trunc i160 %r22 to i32
ret i32 %r23
}
define i32 @mclb_mulUnitAdd4(i32* noalias  %r2, i32* noalias  %r3, i32 %r4)
{
%r6 = call i64 @mulPos32x32(i32* %r3, i32 %r4, i32 0)
%r7 = trunc i64 %r6 to i32
%r8 = call i32 @extractHigh32(i64 %r6)
%r10 = call i64 @mulPos32x32(i32* %r3, i32 %r4, i32 1)
%r11 = trunc i64 %r10 to i32
%r12 = call i32 @extractHigh32(i64 %r10)
%r14 = call i64 @mulPos32x32(i32* %r3, i32 %r4, i32 2)
%r15 = trunc i64 %r14 to i32
%r16 = call i32 @extractHigh32(i64 %r14)
%r18 = call i64 @mulPos32x32(i32* %r3, i32 %r4, i32 3)
%r19 = trunc i64 %r18 to i32
%r20 = call i32 @extractHigh32(i64 %r18)
%r21 = zext i32 %r7 to i64
%r22 = zext i32 %r11 to i64
%r23 = shl i64 %r22, 32
%r24 = or i64 %r21, %r23
%r25 = zext i64 %r24 to i96
%r26 = zext i32 %r15 to i96
%r27 = shl i96 %r26, 64
%r28 = or i96 %r25, %r27
%r29 = zext i96 %r28 to i128
%r30 = zext i32 %r19 to i128
%r31 = shl i128 %r30, 96
%r32 = or i128 %r29, %r31
%r33 = zext i32 %r8 to i64
%r34 = zext i32 %r12 to i64
%r35 = shl i64 %r34, 32
%r36 = or i64 %r33, %r35
%r37 = zext i64 %r36 to i96
%r38 = zext i32 %r16 to i96
%r39 = shl i96 %r38, 64
%r40 = or i96 %r37, %r39
%r41 = zext i96 %r40 to i128
%r42 = zext i32 %r20 to i128
%r43 = shl i128 %r42, 96
%r44 = or i128 %r41, %r43
%r45 = zext i128 %r32 to i160
%r46 = zext i128 %r44 to i160
%r47 = shl i160 %r46, 32
%r48 = add i160 %r45, %r47
%r50 = bitcast i32* %r2 to i128*
%r51 = load i128, i128* %r50
%r52 = zext i128 %r51 to i160
%r53 = add i160 %r48, %r52
%r54 = trunc i160 %r53 to i128
%r56 = getelementptr i32, i32* %r2, i32 0
%r57 = trunc i128 %r54 to i32
store i32 %r57, i32* %r56
%r58 = lshr i128 %r54, 32
%r60 = getelementptr i32, i32* %r2, i32 1
%r61 = trunc i128 %r58 to i32
store i32 %r61, i32* %r60
%r62 = lshr i128 %r58, 32
%r64 = getelementptr i32, i32* %r2, i32 2
%r65 = trunc i128 %r62 to i32
store i32 %r65, i32* %r64
%r66 = lshr i128 %r62, 32
%r68 = getelementptr i32, i32* %r2, i32 3
%r69 = trunc i128 %r66 to i32
store i32 %r69, i32* %r68
%r70 = lshr i160 %r53, 128
%r71 = trunc i160 %r70 to i32
ret i32 %r71
}
define void @mclb_mul4(i32* noalias  %r1, i32* noalias  %r2, i32* noalias  %r3)
{
%r4 = load i32, i32* %r3
%r5 = call i160 @mulUnit_inner128(i32* %r2, i32 %r4)
%r6 = trunc i160 %r5 to i32
store i32 %r6, i32* %r1
%r7 = lshr i160 %r5, 32
%r9 = getelementptr i32, i32* %r3, i32 1
%r10 = load i32, i32* %r9
%r11 = call i160 @mulUnit_inner128(i32* %r2, i32 %r10)
%r12 = add i160 %r7, %r11
%r13 = trunc i160 %r12 to i32
%r15 = getelementptr i32, i32* %r1, i32 1
store i32 %r13, i32* %r15
%r16 = lshr i160 %r12, 32
%r18 = getelementptr i32, i32* %r3, i32 2
%r19 = load i32, i32* %r18
%r20 = call i160 @mulUnit_inner128(i32* %r2, i32 %r19)
%r21 = add i160 %r16, %r20
%r22 = trunc i160 %r21 to i32
%r24 = getelementptr i32, i32* %r1, i32 2
store i32 %r22, i32* %r24
%r25 = lshr i160 %r21, 32
%r27 = getelementptr i32, i32* %r3, i32 3
%r28 = load i32, i32* %r27
%r29 = call i160 @mulUnit_inner128(i32* %r2, i32 %r28)
%r30 = add i160 %r25, %r29
%r32 = getelementptr i32, i32* %r1, i32 3
%r34 = getelementptr i32, i32* %r32, i32 0
%r35 = trunc i160 %r30 to i32
store i32 %r35, i32* %r34
%r36 = lshr i160 %r30, 32
%r38 = getelementptr i32, i32* %r32, i32 1
%r39 = trunc i160 %r36 to i32
store i32 %r39, i32* %r38
%r40 = lshr i160 %r36, 32
%r42 = getelementptr i32, i32* %r32, i32 2
%r43 = trunc i160 %r40 to i32
store i32 %r43, i32* %r42
%r44 = lshr i160 %r40, 32
%r46 = getelementptr i32, i32* %r32, i32 3
%r47 = trunc i160 %r44 to i32
store i32 %r47, i32* %r46
%r48 = lshr i160 %r44, 32
%r50 = getelementptr i32, i32* %r32, i32 4
%r51 = trunc i160 %r48 to i32
store i32 %r51, i32* %r50
ret void
}
define void @mclb_sqr4(i32* noalias  %r1, i32* noalias  %r2)
{
%r3 = load i32, i32* %r2
%r4 = call i160 @mulUnit_inner128(i32* %r2, i32 %r3)
%r5 = trunc i160 %r4 to i32
store i32 %r5, i32* %r1
%r6 = lshr i160 %r4, 32
%r8 = getelementptr i32, i32* %r2, i32 1
%r9 = load i32, i32* %r8
%r10 = call i160 @mulUnit_inner128(i32* %r2, i32 %r9)
%r11 = add i160 %r6, %r10
%r12 = trunc i160 %r11 to i32
%r14 = getelementptr i32, i32* %r1, i32 1
store i32 %r12, i32* %r14
%r15 = lshr i160 %r11, 32
%r17 = getelementptr i32, i32* %r2, i32 2
%r18 = load i32, i32* %r17
%r19 = call i160 @mulUnit_inner128(i32* %r2, i32 %r18)
%r20 = add i160 %r15, %r19
%r21 = trunc i160 %r20 to i32
%r23 = getelementptr i32, i32* %r1, i32 2
store i32 %r21, i32* %r23
%r24 = lshr i160 %r20, 32
%r26 = getelementptr i32, i32* %r2, i32 3
%r27 = load i32, i32* %r26
%r28 = call i160 @mulUnit_inner128(i32* %r2, i32 %r27)
%r29 = add i160 %r24, %r28
%r31 = getelementptr i32, i32* %r1, i32 3
%r33 = getelementptr i32, i32* %r31, i32 0
%r34 = trunc i160 %r29 to i32
store i32 %r34, i32* %r33
%r35 = lshr i160 %r29, 32
%r37 = getelementptr i32, i32* %r31, i32 1
%r38 = trunc i160 %r35 to i32
store i32 %r38, i32* %r37
%r39 = lshr i160 %r35, 32
%r41 = getelementptr i32, i32* %r31, i32 2
%r42 = trunc i160 %r39 to i32
store i32 %r42, i32* %r41
%r43 = lshr i160 %r39, 32
%r45 = getelementptr i32, i32* %r31, i32 3
%r46 = trunc i160 %r43 to i32
store i32 %r46, i32* %r45
%r47 = lshr i160 %r43, 32
%r49 = getelementptr i32, i32* %r31, i32 4
%r50 = trunc i160 %r47 to i32
store i32 %r50, i32* %r49
ret void
}
define i192 @mulUnit_inner160(i32* noalias  %r2, i32 %r3)
{
%r5 = call i64 @mulPos32x32(i32* %r2, i32 %r3, i32 0)
%r6 = trunc i64 %r5 to i32
%r7 = call i32 @extractHigh32(i64 %r5)
%r9 = call i64 @mulPos32x32(i32* %r2, i32 %r3, i32 1)
%r10 = trunc i64 %r9 to i32
%r11 = call i32 @extractHigh32(i64 %r9)
%r13 = call i64 @mulPos32x32(i32* %r2, i32 %r3, i32 2)
%r14 = trunc i64 %r13 to i32
%r15 = call i32 @extractHigh32(i64 %r13)
%r17 = call i64 @mulPos32x32(i32* %r2, i32 %r3, i32 3)
%r18 = trunc i64 %r17 to i32
%r19 = call i32 @extractHigh32(i64 %r17)
%r21 = call i64 @mulPos32x32(i32* %r2, i32 %r3, i32 4)
%r22 = trunc i64 %r21 to i32
%r23 = call i32 @extractHigh32(i64 %r21)
%r24 = zext i32 %r6 to i64
%r25 = zext i32 %r10 to i64
%r26 = shl i64 %r25, 32
%r27 = or i64 %r24, %r26
%r28 = zext i64 %r27 to i96
%r29 = zext i32 %r14 to i96
%r30 = shl i96 %r29, 64
%r31 = or i96 %r28, %r30
%r32 = zext i96 %r31 to i128
%r33 = zext i32 %r18 to i128
%r34 = shl i128 %r33, 96
%r35 = or i128 %r32, %r34
%r36 = zext i128 %r35 to i160
%r37 = zext i32 %r22 to i160
%r38 = shl i160 %r37, 128
%r39 = or i160 %r36, %r38
%r40 = zext i32 %r7 to i64
%r41 = zext i32 %r11 to i64
%r42 = shl i64 %r41, 32
%r43 = or i64 %r40, %r42
%r44 = zext i64 %r43 to i96
%r45 = zext i32 %r15 to i96
%r46 = shl i96 %r45, 64
%r47 = or i96 %r44, %r46
%r48 = zext i96 %r47 to i128
%r49 = zext i32 %r19 to i128
%r50 = shl i128 %r49, 96
%r51 = or i128 %r48, %r50
%r52 = zext i128 %r51 to i160
%r53 = zext i32 %r23 to i160
%r54 = shl i160 %r53, 128
%r55 = or i160 %r52, %r54
%r56 = zext i160 %r39 to i192
%r57 = zext i160 %r55 to i192
%r58 = shl i192 %r57, 32
%r59 = add i192 %r56, %r58
ret i192 %r59
}
define i32 @mclb_mulUnit5(i32* noalias  %r2, i32* noalias  %r3, i32 %r4)
{
%r5 = call i192 @mulUnit_inner160(i32* %r3, i32 %r4)
%r6 = trunc i192 %r5 to i160
%r8 = getelementptr i32, i32* %r2, i32 0
%r9 = trunc i160 %r6 to i32
store i32 %r9, i32* %r8
%r10 = lshr i160 %r6, 32
%r12 = getelementptr i32, i32* %r2, i32 1
%r13 = trunc i160 %r10 to i32
store i32 %r13, i32* %r12
%r14 = lshr i160 %r10, 32
%r16 = getelementptr i32, i32* %r2, i32 2
%r17 = trunc i160 %r14 to i32
store i32 %r17, i32* %r16
%r18 = lshr i160 %r14, 32
%r20 = getelementptr i32, i32* %r2, i32 3
%r21 = trunc i160 %r18 to i32
store i32 %r21, i32* %r20
%r22 = lshr i160 %r18, 32
%r24 = getelementptr i32, i32* %r2, i32 4
%r25 = trunc i160 %r22 to i32
store i32 %r25, i32* %r24
%r26 = lshr i192 %r5, 160
%r27 = trunc i192 %r26 to i32
ret i32 %r27
}
define i32 @mclb_mulUnitAdd5(i32* noalias  %r2, i32* noalias  %r3, i32 %r4)
{
%r6 = call i64 @mulPos32x32(i32* %r3, i32 %r4, i32 0)
%r7 = trunc i64 %r6 to i32
%r8 = call i32 @extractHigh32(i64 %r6)
%r10 = call i64 @mulPos32x32(i32* %r3, i32 %r4, i32 1)
%r11 = trunc i64 %r10 to i32
%r12 = call i32 @extractHigh32(i64 %r10)
%r14 = call i64 @mulPos32x32(i32* %r3, i32 %r4, i32 2)
%r15 = trunc i64 %r14 to i32
%r16 = call i32 @extractHigh32(i64 %r14)
%r18 = call i64 @mulPos32x32(i32* %r3, i32 %r4, i32 3)
%r19 = trunc i64 %r18 to i32
%r20 = call i32 @extractHigh32(i64 %r18)
%r22 = call i64 @mulPos32x32(i32* %r3, i32 %r4, i32 4)
%r23 = trunc i64 %r22 to i32
%r24 = call i32 @extractHigh32(i64 %r22)
%r25 = zext i32 %r7 to i64
%r26 = zext i32 %r11 to i64
%r27 = shl i64 %r26, 32
%r28 = or i64 %r25, %r27
%r29 = zext i64 %r28 to i96
%r30 = zext i32 %r15 to i96
%r31 = shl i96 %r30, 64
%r32 = or i96 %r29, %r31
%r33 = zext i96 %r32 to i128
%r34 = zext i32 %r19 to i128
%r35 = shl i128 %r34, 96
%r36 = or i128 %r33, %r35
%r37 = zext i128 %r36 to i160
%r38 = zext i32 %r23 to i160
%r39 = shl i160 %r38, 128
%r40 = or i160 %r37, %r39
%r41 = zext i32 %r8 to i64
%r42 = zext i32 %r12 to i64
%r43 = shl i64 %r42, 32
%r44 = or i64 %r41, %r43
%r45 = zext i64 %r44 to i96
%r46 = zext i32 %r16 to i96
%r47 = shl i96 %r46, 64
%r48 = or i96 %r45, %r47
%r49 = zext i96 %r48 to i128
%r50 = zext i32 %r20 to i128
%r51 = shl i128 %r50, 96
%r52 = or i128 %r49, %r51
%r53 = zext i128 %r52 to i160
%r54 = zext i32 %r24 to i160
%r55 = shl i160 %r54, 128
%r56 = or i160 %r53, %r55
%r57 = zext i160 %r40 to i192
%r58 = zext i160 %r56 to i192
%r59 = shl i192 %r58, 32
%r60 = add i192 %r57, %r59
%r62 = bitcast i32* %r2 to i160*
%r63 = load i160, i160* %r62
%r64 = zext i160 %r63 to i192
%r65 = add i192 %r60, %r64
%r66 = trunc i192 %r65 to i160
%r68 = getelementptr i32, i32* %r2, i32 0
%r69 = trunc i160 %r66 to i32
store i32 %r69, i32* %r68
%r70 = lshr i160 %r66, 32
%r72 = getelementptr i32, i32* %r2, i32 1
%r73 = trunc i160 %r70 to i32
store i32 %r73, i32* %r72
%r74 = lshr i160 %r70, 32
%r76 = getelementptr i32, i32* %r2, i32 2
%r77 = trunc i160 %r74 to i32
store i32 %r77, i32* %r76
%r78 = lshr i160 %r74, 32
%r80 = getelementptr i32, i32* %r2, i32 3
%r81 = trunc i160 %r78 to i32
store i32 %r81, i32* %r80
%r82 = lshr i160 %r78, 32
%r84 = getelementptr i32, i32* %r2, i32 4
%r85 = trunc i160 %r82 to i32
store i32 %r85, i32* %r84
%r86 = lshr i192 %r65, 160
%r87 = trunc i192 %r86 to i32
ret i32 %r87
}
define void @mclb_mul5(i32* noalias  %r1, i32* noalias  %r2, i32* noalias  %r3)
{
%r4 = load i32, i32* %r3
%r5 = call i192 @mulUnit_inner160(i32* %r2, i32 %r4)
%r6 = trunc i192 %r5 to i32
store i32 %r6, i32* %r1
%r7 = lshr i192 %r5, 32
%r9 = getelementptr i32, i32* %r3, i32 1
%r10 = load i32, i32* %r9
%r11 = call i192 @mulUnit_inner160(i32* %r2, i32 %r10)
%r12 = add i192 %r7, %r11
%r13 = trunc i192 %r12 to i32
%r15 = getelementptr i32, i32* %r1, i32 1
store i32 %r13, i32* %r15
%r16 = lshr i192 %r12, 32
%r18 = getelementptr i32, i32* %r3, i32 2
%r19 = load i32, i32* %r18
%r20 = call i192 @mulUnit_inner160(i32* %r2, i32 %r19)
%r21 = add i192 %r16, %r20
%r22 = trunc i192 %r21 to i32
%r24 = getelementptr i32, i32* %r1, i32 2
store i32 %r22, i32* %r24
%r25 = lshr i192 %r21, 32
%r27 = getelementptr i32, i32* %r3, i32 3
%r28 = load i32, i32* %r27
%r29 = call i192 @mulUnit_inner160(i32* %r2, i32 %r28)
%r30 = add i192 %r25, %r29
%r31 = trunc i192 %r30 to i32
%r33 = getelementptr i32, i32* %r1, i32 3
store i32 %r31, i32* %r33
%r34 = lshr i192 %r30, 32
%r36 = getelementptr i32, i32* %r3, i32 4
%r37 = load i32, i32* %r36
%r38 = call i192 @mulUnit_inner160(i32* %r2, i32 %r37)
%r39 = add i192 %r34, %r38
%r41 = getelementptr i32, i32* %r1, i32 4
%r43 = getelementptr i32, i32* %r41, i32 0
%r44 = trunc i192 %r39 to i32
store i32 %r44, i32* %r43
%r45 = lshr i192 %r39, 32
%r47 = getelementptr i32, i32* %r41, i32 1
%r48 = trunc i192 %r45 to i32
store i32 %r48, i32* %r47
%r49 = lshr i192 %r45, 32
%r51 = getelementptr i32, i32* %r41, i32 2
%r52 = trunc i192 %r49 to i32
store i32 %r52, i32* %r51
%r53 = lshr i192 %r49, 32
%r55 = getelementptr i32, i32* %r41, i32 3
%r56 = trunc i192 %r53 to i32
store i32 %r56, i32* %r55
%r57 = lshr i192 %r53, 32
%r59 = getelementptr i32, i32* %r41, i32 4
%r60 = trunc i192 %r57 to i32
store i32 %r60, i32* %r59
%r61 = lshr i192 %r57, 32
%r63 = getelementptr i32, i32* %r41, i32 5
%r64 = trunc i192 %r61 to i32
store i32 %r64, i32* %r63
ret void
}
define void @mclb_sqr5(i32* noalias  %r1, i32* noalias  %r2)
{
%r3 = load i32, i32* %r2
%r4 = call i192 @mulUnit_inner160(i32* %r2, i32 %r3)
%r5 = trunc i192 %r4 to i32
store i32 %r5, i32* %r1
%r6 = lshr i192 %r4, 32
%r8 = getelementptr i32, i32* %r2, i32 1
%r9 = load i32, i32* %r8
%r10 = call i192 @mulUnit_inner160(i32* %r2, i32 %r9)
%r11 = add i192 %r6, %r10
%r12 = trunc i192 %r11 to i32
%r14 = getelementptr i32, i32* %r1, i32 1
store i32 %r12, i32* %r14
%r15 = lshr i192 %r11, 32
%r17 = getelementptr i32, i32* %r2, i32 2
%r18 = load i32, i32* %r17
%r19 = call i192 @mulUnit_inner160(i32* %r2, i32 %r18)
%r20 = add i192 %r15, %r19
%r21 = trunc i192 %r20 to i32
%r23 = getelementptr i32, i32* %r1, i32 2
store i32 %r21, i32* %r23
%r24 = lshr i192 %r20, 32
%r26 = getelementptr i32, i32* %r2, i32 3
%r27 = load i32, i32* %r26
%r28 = call i192 @mulUnit_inner160(i32* %r2, i32 %r27)
%r29 = add i192 %r24, %r28
%r30 = trunc i192 %r29 to i32
%r32 = getelementptr i32, i32* %r1, i32 3
store i32 %r30, i32* %r32
%r33 = lshr i192 %r29, 32
%r35 = getelementptr i32, i32* %r2, i32 4
%r36 = load i32, i32* %r35
%r37 = call i192 @mulUnit_inner160(i32* %r2, i32 %r36)
%r38 = add i192 %r33, %r37
%r40 = getelementptr i32, i32* %r1, i32 4
%r42 = getelementptr i32, i32* %r40, i32 0
%r43 = trunc i192 %r38 to i32
store i32 %r43, i32* %r42
%r44 = lshr i192 %r38, 32
%r46 = getelementptr i32, i32* %r40, i32 1
%r47 = trunc i192 %r44 to i32
store i32 %r47, i32* %r46
%r48 = lshr i192 %r44, 32
%r50 = getelementptr i32, i32* %r40, i32 2
%r51 = trunc i192 %r48 to i32
store i32 %r51, i32* %r50
%r52 = lshr i192 %r48, 32
%r54 = getelementptr i32, i32* %r40, i32 3
%r55 = trunc i192 %r52 to i32
store i32 %r55, i32* %r54
%r56 = lshr i192 %r52, 32
%r58 = getelementptr i32, i32* %r40, i32 4
%r59 = trunc i192 %r56 to i32
store i32 %r59, i32* %r58
%r60 = lshr i192 %r56, 32
%r62 = getelementptr i32, i32* %r40, i32 5
%r63 = trunc i192 %r60 to i32
store i32 %r63, i32* %r62
ret void
}
define i224 @mulUnit_inner192(i32* noalias  %r2, i32 %r3)
{
%r5 = call i64 @mulPos32x32(i32* %r2, i32 %r3, i32 0)
%r6 = trunc i64 %r5 to i32
%r7 = call i32 @extractHigh32(i64 %r5)
%r9 = call i64 @mulPos32x32(i32* %r2, i32 %r3, i32 1)
%r10 = trunc i64 %r9 to i32
%r11 = call i32 @extractHigh32(i64 %r9)
%r13 = call i64 @mulPos32x32(i32* %r2, i32 %r3, i32 2)
%r14 = trunc i64 %r13 to i32
%r15 = call i32 @extractHigh32(i64 %r13)
%r17 = call i64 @mulPos32x32(i32* %r2, i32 %r3, i32 3)
%r18 = trunc i64 %r17 to i32
%r19 = call i32 @extractHigh32(i64 %r17)
%r21 = call i64 @mulPos32x32(i32* %r2, i32 %r3, i32 4)
%r22 = trunc i64 %r21 to i32
%r23 = call i32 @extractHigh32(i64 %r21)
%r25 = call i64 @mulPos32x32(i32* %r2, i32 %r3, i32 5)
%r26 = trunc i64 %r25 to i32
%r27 = call i32 @extractHigh32(i64 %r25)
%r28 = zext i32 %r6 to i64
%r29 = zext i32 %r10 to i64
%r30 = shl i64 %r29, 32
%r31 = or i64 %r28, %r30
%r32 = zext i64 %r31 to i96
%r33 = zext i32 %r14 to i96
%r34 = shl i96 %r33, 64
%r35 = or i96 %r32, %r34
%r36 = zext i96 %r35 to i128
%r37 = zext i32 %r18 to i128
%r38 = shl i128 %r37, 96
%r39 = or i128 %r36, %r38
%r40 = zext i128 %r39 to i160
%r41 = zext i32 %r22 to i160
%r42 = shl i160 %r41, 128
%r43 = or i160 %r40, %r42
%r44 = zext i160 %r43 to i192
%r45 = zext i32 %r26 to i192
%r46 = shl i192 %r45, 160
%r47 = or i192 %r44, %r46
%r48 = zext i32 %r7 to i64
%r49 = zext i32 %r11 to i64
%r50 = shl i64 %r49, 32
%r51 = or i64 %r48, %r50
%r52 = zext i64 %r51 to i96
%r53 = zext i32 %r15 to i96
%r54 = shl i96 %r53, 64
%r55 = or i96 %r52, %r54
%r56 = zext i96 %r55 to i128
%r57 = zext i32 %r19 to i128
%r58 = shl i128 %r57, 96
%r59 = or i128 %r56, %r58
%r60 = zext i128 %r59 to i160
%r61 = zext i32 %r23 to i160
%r62 = shl i160 %r61, 128
%r63 = or i160 %r60, %r62
%r64 = zext i160 %r63 to i192
%r65 = zext i32 %r27 to i192
%r66 = shl i192 %r65, 160
%r67 = or i192 %r64, %r66
%r68 = zext i192 %r47 to i224
%r69 = zext i192 %r67 to i224
%r70 = shl i224 %r69, 32
%r71 = add i224 %r68, %r70
ret i224 %r71
}
define i32 @mclb_mulUnit6(i32* noalias  %r2, i32* noalias  %r3, i32 %r4)
{
%r5 = call i224 @mulUnit_inner192(i32* %r3, i32 %r4)
%r6 = trunc i224 %r5 to i192
%r8 = getelementptr i32, i32* %r2, i32 0
%r9 = trunc i192 %r6 to i32
store i32 %r9, i32* %r8
%r10 = lshr i192 %r6, 32
%r12 = getelementptr i32, i32* %r2, i32 1
%r13 = trunc i192 %r10 to i32
store i32 %r13, i32* %r12
%r14 = lshr i192 %r10, 32
%r16 = getelementptr i32, i32* %r2, i32 2
%r17 = trunc i192 %r14 to i32
store i32 %r17, i32* %r16
%r18 = lshr i192 %r14, 32
%r20 = getelementptr i32, i32* %r2, i32 3
%r21 = trunc i192 %r18 to i32
store i32 %r21, i32* %r20
%r22 = lshr i192 %r18, 32
%r24 = getelementptr i32, i32* %r2, i32 4
%r25 = trunc i192 %r22 to i32
store i32 %r25, i32* %r24
%r26 = lshr i192 %r22, 32
%r28 = getelementptr i32, i32* %r2, i32 5
%r29 = trunc i192 %r26 to i32
store i32 %r29, i32* %r28
%r30 = lshr i224 %r5, 192
%r31 = trunc i224 %r30 to i32
ret i32 %r31
}
define i32 @mclb_mulUnitAdd6(i32* noalias  %r2, i32* noalias  %r3, i32 %r4)
{
%r6 = call i64 @mulPos32x32(i32* %r3, i32 %r4, i32 0)
%r7 = trunc i64 %r6 to i32
%r8 = call i32 @extractHigh32(i64 %r6)
%r10 = call i64 @mulPos32x32(i32* %r3, i32 %r4, i32 1)
%r11 = trunc i64 %r10 to i32
%r12 = call i32 @extractHigh32(i64 %r10)
%r14 = call i64 @mulPos32x32(i32* %r3, i32 %r4, i32 2)
%r15 = trunc i64 %r14 to i32
%r16 = call i32 @extractHigh32(i64 %r14)
%r18 = call i64 @mulPos32x32(i32* %r3, i32 %r4, i32 3)
%r19 = trunc i64 %r18 to i32
%r20 = call i32 @extractHigh32(i64 %r18)
%r22 = call i64 @mulPos32x32(i32* %r3, i32 %r4, i32 4)
%r23 = trunc i64 %r22 to i32
%r24 = call i32 @extractHigh32(i64 %r22)
%r26 = call i64 @mulPos32x32(i32* %r3, i32 %r4, i32 5)
%r27 = trunc i64 %r26 to i32
%r28 = call i32 @extractHigh32(i64 %r26)
%r29 = zext i32 %r7 to i64
%r30 = zext i32 %r11 to i64
%r31 = shl i64 %r30, 32
%r32 = or i64 %r29, %r31
%r33 = zext i64 %r32 to i96
%r34 = zext i32 %r15 to i96
%r35 = shl i96 %r34, 64
%r36 = or i96 %r33, %r35
%r37 = zext i96 %r36 to i128
%r38 = zext i32 %r19 to i128
%r39 = shl i128 %r38, 96
%r40 = or i128 %r37, %r39
%r41 = zext i128 %r40 to i160
%r42 = zext i32 %r23 to i160
%r43 = shl i160 %r42, 128
%r44 = or i160 %r41, %r43
%r45 = zext i160 %r44 to i192
%r46 = zext i32 %r27 to i192
%r47 = shl i192 %r46, 160
%r48 = or i192 %r45, %r47
%r49 = zext i32 %r8 to i64
%r50 = zext i32 %r12 to i64
%r51 = shl i64 %r50, 32
%r52 = or i64 %r49, %r51
%r53 = zext i64 %r52 to i96
%r54 = zext i32 %r16 to i96
%r55 = shl i96 %r54, 64
%r56 = or i96 %r53, %r55
%r57 = zext i96 %r56 to i128
%r58 = zext i32 %r20 to i128
%r59 = shl i128 %r58, 96
%r60 = or i128 %r57, %r59
%r61 = zext i128 %r60 to i160
%r62 = zext i32 %r24 to i160
%r63 = shl i160 %r62, 128
%r64 = or i160 %r61, %r63
%r65 = zext i160 %r64 to i192
%r66 = zext i32 %r28 to i192
%r67 = shl i192 %r66, 160
%r68 = or i192 %r65, %r67
%r69 = zext i192 %r48 to i224
%r70 = zext i192 %r68 to i224
%r71 = shl i224 %r70, 32
%r72 = add i224 %r69, %r71
%r74 = bitcast i32* %r2 to i192*
%r75 = load i192, i192* %r74
%r76 = zext i192 %r75 to i224
%r77 = add i224 %r72, %r76
%r78 = trunc i224 %r77 to i192
%r80 = getelementptr i32, i32* %r2, i32 0
%r81 = trunc i192 %r78 to i32
store i32 %r81, i32* %r80
%r82 = lshr i192 %r78, 32
%r84 = getelementptr i32, i32* %r2, i32 1
%r85 = trunc i192 %r82 to i32
store i32 %r85, i32* %r84
%r86 = lshr i192 %r82, 32
%r88 = getelementptr i32, i32* %r2, i32 2
%r89 = trunc i192 %r86 to i32
store i32 %r89, i32* %r88
%r90 = lshr i192 %r86, 32
%r92 = getelementptr i32, i32* %r2, i32 3
%r93 = trunc i192 %r90 to i32
store i32 %r93, i32* %r92
%r94 = lshr i192 %r90, 32
%r96 = getelementptr i32, i32* %r2, i32 4
%r97 = trunc i192 %r94 to i32
store i32 %r97, i32* %r96
%r98 = lshr i192 %r94, 32
%r100 = getelementptr i32, i32* %r2, i32 5
%r101 = trunc i192 %r98 to i32
store i32 %r101, i32* %r100
%r102 = lshr i224 %r77, 192
%r103 = trunc i224 %r102 to i32
ret i32 %r103
}
define void @mclb_mul6(i32* noalias  %r1, i32* noalias  %r2, i32* noalias  %r3)
{
%r4 = load i32, i32* %r3
%r5 = call i224 @mulUnit_inner192(i32* %r2, i32 %r4)
%r6 = trunc i224 %r5 to i32
store i32 %r6, i32* %r1
%r7 = lshr i224 %r5, 32
%r9 = getelementptr i32, i32* %r3, i32 1
%r10 = load i32, i32* %r9
%r11 = call i224 @mulUnit_inner192(i32* %r2, i32 %r10)
%r12 = add i224 %r7, %r11
%r13 = trunc i224 %r12 to i32
%r15 = getelementptr i32, i32* %r1, i32 1
store i32 %r13, i32* %r15
%r16 = lshr i224 %r12, 32
%r18 = getelementptr i32, i32* %r3, i32 2
%r19 = load i32, i32* %r18
%r20 = call i224 @mulUnit_inner192(i32* %r2, i32 %r19)
%r21 = add i224 %r16, %r20
%r22 = trunc i224 %r21 to i32
%r24 = getelementptr i32, i32* %r1, i32 2
store i32 %r22, i32* %r24
%r25 = lshr i224 %r21, 32
%r27 = getelementptr i32, i32* %r3, i32 3
%r28 = load i32, i32* %r27
%r29 = call i224 @mulUnit_inner192(i32* %r2, i32 %r28)
%r30 = add i224 %r25, %r29
%r31 = trunc i224 %r30 to i32
%r33 = getelementptr i32, i32* %r1, i32 3
store i32 %r31, i32* %r33
%r34 = lshr i224 %r30, 32
%r36 = getelementptr i32, i32* %r3, i32 4
%r37 = load i32, i32* %r36
%r38 = call i224 @mulUnit_inner192(i32* %r2, i32 %r37)
%r39 = add i224 %r34, %r38
%r40 = trunc i224 %r39 to i32
%r42 = getelementptr i32, i32* %r1, i32 4
store i32 %r40, i32* %r42
%r43 = lshr i224 %r39, 32
%r45 = getelementptr i32, i32* %r3, i32 5
%r46 = load i32, i32* %r45
%r47 = call i224 @mulUnit_inner192(i32* %r2, i32 %r46)
%r48 = add i224 %r43, %r47
%r50 = getelementptr i32, i32* %r1, i32 5
%r52 = getelementptr i32, i32* %r50, i32 0
%r53 = trunc i224 %r48 to i32
store i32 %r53, i32* %r52
%r54 = lshr i224 %r48, 32
%r56 = getelementptr i32, i32* %r50, i32 1
%r57 = trunc i224 %r54 to i32
store i32 %r57, i32* %r56
%r58 = lshr i224 %r54, 32
%r60 = getelementptr i32, i32* %r50, i32 2
%r61 = trunc i224 %r58 to i32
store i32 %r61, i32* %r60
%r62 = lshr i224 %r58, 32
%r64 = getelementptr i32, i32* %r50, i32 3
%r65 = trunc i224 %r62 to i32
store i32 %r65, i32* %r64
%r66 = lshr i224 %r62, 32
%r68 = getelementptr i32, i32* %r50, i32 4
%r69 = trunc i224 %r66 to i32
store i32 %r69, i32* %r68
%r70 = lshr i224 %r66, 32
%r72 = getelementptr i32, i32* %r50, i32 5
%r73 = trunc i224 %r70 to i32
store i32 %r73, i32* %r72
%r74 = lshr i224 %r70, 32
%r76 = getelementptr i32, i32* %r50, i32 6
%r77 = trunc i224 %r74 to i32
store i32 %r77, i32* %r76
ret void
}
define void @mclb_sqr6(i32* noalias  %r1, i32* noalias  %r2)
{
%r3 = load i32, i32* %r2
%r4 = call i224 @mulUnit_inner192(i32* %r2, i32 %r3)
%r5 = trunc i224 %r4 to i32
store i32 %r5, i32* %r1
%r6 = lshr i224 %r4, 32
%r8 = getelementptr i32, i32* %r2, i32 1
%r9 = load i32, i32* %r8
%r10 = call i224 @mulUnit_inner192(i32* %r2, i32 %r9)
%r11 = add i224 %r6, %r10
%r12 = trunc i224 %r11 to i32
%r14 = getelementptr i32, i32* %r1, i32 1
store i32 %r12, i32* %r14
%r15 = lshr i224 %r11, 32
%r17 = getelementptr i32, i32* %r2, i32 2
%r18 = load i32, i32* %r17
%r19 = call i224 @mulUnit_inner192(i32* %r2, i32 %r18)
%r20 = add i224 %r15, %r19
%r21 = trunc i224 %r20 to i32
%r23 = getelementptr i32, i32* %r1, i32 2
store i32 %r21, i32* %r23
%r24 = lshr i224 %r20, 32
%r26 = getelementptr i32, i32* %r2, i32 3
%r27 = load i32, i32* %r26
%r28 = call i224 @mulUnit_inner192(i32* %r2, i32 %r27)
%r29 = add i224 %r24, %r28
%r30 = trunc i224 %r29 to i32
%r32 = getelementptr i32, i32* %r1, i32 3
store i32 %r30, i32* %r32
%r33 = lshr i224 %r29, 32
%r35 = getelementptr i32, i32* %r2, i32 4
%r36 = load i32, i32* %r35
%r37 = call i224 @mulUnit_inner192(i32* %r2, i32 %r36)
%r38 = add i224 %r33, %r37
%r39 = trunc i224 %r38 to i32
%r41 = getelementptr i32, i32* %r1, i32 4
store i32 %r39, i32* %r41
%r42 = lshr i224 %r38, 32
%r44 = getelementptr i32, i32* %r2, i32 5
%r45 = load i32, i32* %r44
%r46 = call i224 @mulUnit_inner192(i32* %r2, i32 %r45)
%r47 = add i224 %r42, %r46
%r49 = getelementptr i32, i32* %r1, i32 5
%r51 = getelementptr i32, i32* %r49, i32 0
%r52 = trunc i224 %r47 to i32
store i32 %r52, i32* %r51
%r53 = lshr i224 %r47, 32
%r55 = getelementptr i32, i32* %r49, i32 1
%r56 = trunc i224 %r53 to i32
store i32 %r56, i32* %r55
%r57 = lshr i224 %r53, 32
%r59 = getelementptr i32, i32* %r49, i32 2
%r60 = trunc i224 %r57 to i32
store i32 %r60, i32* %r59
%r61 = lshr i224 %r57, 32
%r63 = getelementptr i32, i32* %r49, i32 3
%r64 = trunc i224 %r61 to i32
store i32 %r64, i32* %r63
%r65 = lshr i224 %r61, 32
%r67 = getelementptr i32, i32* %r49, i32 4
%r68 = trunc i224 %r65 to i32
store i32 %r68, i32* %r67
%r69 = lshr i224 %r65, 32
%r71 = getelementptr i32, i32* %r49, i32 5
%r72 = trunc i224 %r69 to i32
store i32 %r72, i32* %r71
%r73 = lshr i224 %r69, 32
%r75 = getelementptr i32, i32* %r49, i32 6
%r76 = trunc i224 %r73 to i32
store i32 %r76, i32* %r75
ret void
}
define i256 @mulUnit_inner224(i32* noalias  %r2, i32 %r3)
{
%r5 = call i64 @mulPos32x32(i32* %r2, i32 %r3, i32 0)
%r6 = trunc i64 %r5 to i32
%r7 = call i32 @extractHigh32(i64 %r5)
%r9 = call i64 @mulPos32x32(i32* %r2, i32 %r3, i32 1)
%r10 = trunc i64 %r9 to i32
%r11 = call i32 @extractHigh32(i64 %r9)
%r13 = call i64 @mulPos32x32(i32* %r2, i32 %r3, i32 2)
%r14 = trunc i64 %r13 to i32
%r15 = call i32 @extractHigh32(i64 %r13)
%r17 = call i64 @mulPos32x32(i32* %r2, i32 %r3, i32 3)
%r18 = trunc i64 %r17 to i32
%r19 = call i32 @extractHigh32(i64 %r17)
%r21 = call i64 @mulPos32x32(i32* %r2, i32 %r3, i32 4)
%r22 = trunc i64 %r21 to i32
%r23 = call i32 @extractHigh32(i64 %r21)
%r25 = call i64 @mulPos32x32(i32* %r2, i32 %r3, i32 5)
%r26 = trunc i64 %r25 to i32
%r27 = call i32 @extractHigh32(i64 %r25)
%r29 = call i64 @mulPos32x32(i32* %r2, i32 %r3, i32 6)
%r30 = trunc i64 %r29 to i32
%r31 = call i32 @extractHigh32(i64 %r29)
%r32 = zext i32 %r6 to i64
%r33 = zext i32 %r10 to i64
%r34 = shl i64 %r33, 32
%r35 = or i64 %r32, %r34
%r36 = zext i64 %r35 to i96
%r37 = zext i32 %r14 to i96
%r38 = shl i96 %r37, 64
%r39 = or i96 %r36, %r38
%r40 = zext i96 %r39 to i128
%r41 = zext i32 %r18 to i128
%r42 = shl i128 %r41, 96
%r43 = or i128 %r40, %r42
%r44 = zext i128 %r43 to i160
%r45 = zext i32 %r22 to i160
%r46 = shl i160 %r45, 128
%r47 = or i160 %r44, %r46
%r48 = zext i160 %r47 to i192
%r49 = zext i32 %r26 to i192
%r50 = shl i192 %r49, 160
%r51 = or i192 %r48, %r50
%r52 = zext i192 %r51 to i224
%r53 = zext i32 %r30 to i224
%r54 = shl i224 %r53, 192
%r55 = or i224 %r52, %r54
%r56 = zext i32 %r7 to i64
%r57 = zext i32 %r11 to i64
%r58 = shl i64 %r57, 32
%r59 = or i64 %r56, %r58
%r60 = zext i64 %r59 to i96
%r61 = zext i32 %r15 to i96
%r62 = shl i96 %r61, 64
%r63 = or i96 %r60, %r62
%r64 = zext i96 %r63 to i128
%r65 = zext i32 %r19 to i128
%r66 = shl i128 %r65, 96
%r67 = or i128 %r64, %r66
%r68 = zext i128 %r67 to i160
%r69 = zext i32 %r23 to i160
%r70 = shl i160 %r69, 128
%r71 = or i160 %r68, %r70
%r72 = zext i160 %r71 to i192
%r73 = zext i32 %r27 to i192
%r74 = shl i192 %r73, 160
%r75 = or i192 %r72, %r74
%r76 = zext i192 %r75 to i224
%r77 = zext i32 %r31 to i224
%r78 = shl i224 %r77, 192
%r79 = or i224 %r76, %r78
%r80 = zext i224 %r55 to i256
%r81 = zext i224 %r79 to i256
%r82 = shl i256 %r81, 32
%r83 = add i256 %r80, %r82
ret i256 %r83
}
define i32 @mclb_mulUnit7(i32* noalias  %r2, i32* noalias  %r3, i32 %r4)
{
%r5 = call i256 @mulUnit_inner224(i32* %r3, i32 %r4)
%r6 = trunc i256 %r5 to i224
%r8 = getelementptr i32, i32* %r2, i32 0
%r9 = trunc i224 %r6 to i32
store i32 %r9, i32* %r8
%r10 = lshr i224 %r6, 32
%r12 = getelementptr i32, i32* %r2, i32 1
%r13 = trunc i224 %r10 to i32
store i32 %r13, i32* %r12
%r14 = lshr i224 %r10, 32
%r16 = getelementptr i32, i32* %r2, i32 2
%r17 = trunc i224 %r14 to i32
store i32 %r17, i32* %r16
%r18 = lshr i224 %r14, 32
%r20 = getelementptr i32, i32* %r2, i32 3
%r21 = trunc i224 %r18 to i32
store i32 %r21, i32* %r20
%r22 = lshr i224 %r18, 32
%r24 = getelementptr i32, i32* %r2, i32 4
%r25 = trunc i224 %r22 to i32
store i32 %r25, i32* %r24
%r26 = lshr i224 %r22, 32
%r28 = getelementptr i32, i32* %r2, i32 5
%r29 = trunc i224 %r26 to i32
store i32 %r29, i32* %r28
%r30 = lshr i224 %r26, 32
%r32 = getelementptr i32, i32* %r2, i32 6
%r33 = trunc i224 %r30 to i32
store i32 %r33, i32* %r32
%r34 = lshr i256 %r5, 224
%r35 = trunc i256 %r34 to i32
ret i32 %r35
}
define i32 @mclb_mulUnitAdd7(i32* noalias  %r2, i32* noalias  %r3, i32 %r4)
{
%r6 = call i64 @mulPos32x32(i32* %r3, i32 %r4, i32 0)
%r7 = trunc i64 %r6 to i32
%r8 = call i32 @extractHigh32(i64 %r6)
%r10 = call i64 @mulPos32x32(i32* %r3, i32 %r4, i32 1)
%r11 = trunc i64 %r10 to i32
%r12 = call i32 @extractHigh32(i64 %r10)
%r14 = call i64 @mulPos32x32(i32* %r3, i32 %r4, i32 2)
%r15 = trunc i64 %r14 to i32
%r16 = call i32 @extractHigh32(i64 %r14)
%r18 = call i64 @mulPos32x32(i32* %r3, i32 %r4, i32 3)
%r19 = trunc i64 %r18 to i32
%r20 = call i32 @extractHigh32(i64 %r18)
%r22 = call i64 @mulPos32x32(i32* %r3, i32 %r4, i32 4)
%r23 = trunc i64 %r22 to i32
%r24 = call i32 @extractHigh32(i64 %r22)
%r26 = call i64 @mulPos32x32(i32* %r3, i32 %r4, i32 5)
%r27 = trunc i64 %r26 to i32
%r28 = call i32 @extractHigh32(i64 %r26)
%r30 = call i64 @mulPos32x32(i32* %r3, i32 %r4, i32 6)
%r31 = trunc i64 %r30 to i32
%r32 = call i32 @extractHigh32(i64 %r30)
%r33 = zext i32 %r7 to i64
%r34 = zext i32 %r11 to i64
%r35 = shl i64 %r34, 32
%r36 = or i64 %r33, %r35
%r37 = zext i64 %r36 to i96
%r38 = zext i32 %r15 to i96
%r39 = shl i96 %r38, 64
%r40 = or i96 %r37, %r39
%r41 = zext i96 %r40 to i128
%r42 = zext i32 %r19 to i128
%r43 = shl i128 %r42, 96
%r44 = or i128 %r41, %r43
%r45 = zext i128 %r44 to i160
%r46 = zext i32 %r23 to i160
%r47 = shl i160 %r46, 128
%r48 = or i160 %r45, %r47
%r49 = zext i160 %r48 to i192
%r50 = zext i32 %r27 to i192
%r51 = shl i192 %r50, 160
%r52 = or i192 %r49, %r51
%r53 = zext i192 %r52 to i224
%r54 = zext i32 %r31 to i224
%r55 = shl i224 %r54, 192
%r56 = or i224 %r53, %r55
%r57 = zext i32 %r8 to i64
%r58 = zext i32 %r12 to i64
%r59 = shl i64 %r58, 32
%r60 = or i64 %r57, %r59
%r61 = zext i64 %r60 to i96
%r62 = zext i32 %r16 to i96
%r63 = shl i96 %r62, 64
%r64 = or i96 %r61, %r63
%r65 = zext i96 %r64 to i128
%r66 = zext i32 %r20 to i128
%r67 = shl i128 %r66, 96
%r68 = or i128 %r65, %r67
%r69 = zext i128 %r68 to i160
%r70 = zext i32 %r24 to i160
%r71 = shl i160 %r70, 128
%r72 = or i160 %r69, %r71
%r73 = zext i160 %r72 to i192
%r74 = zext i32 %r28 to i192
%r75 = shl i192 %r74, 160
%r76 = or i192 %r73, %r75
%r77 = zext i192 %r76 to i224
%r78 = zext i32 %r32 to i224
%r79 = shl i224 %r78, 192
%r80 = or i224 %r77, %r79
%r81 = zext i224 %r56 to i256
%r82 = zext i224 %r80 to i256
%r83 = shl i256 %r82, 32
%r84 = add i256 %r81, %r83
%r86 = bitcast i32* %r2 to i224*
%r87 = load i224, i224* %r86
%r88 = zext i224 %r87 to i256
%r89 = add i256 %r84, %r88
%r90 = trunc i256 %r89 to i224
%r92 = getelementptr i32, i32* %r2, i32 0
%r93 = trunc i224 %r90 to i32
store i32 %r93, i32* %r92
%r94 = lshr i224 %r90, 32
%r96 = getelementptr i32, i32* %r2, i32 1
%r97 = trunc i224 %r94 to i32
store i32 %r97, i32* %r96
%r98 = lshr i224 %r94, 32
%r100 = getelementptr i32, i32* %r2, i32 2
%r101 = trunc i224 %r98 to i32
store i32 %r101, i32* %r100
%r102 = lshr i224 %r98, 32
%r104 = getelementptr i32, i32* %r2, i32 3
%r105 = trunc i224 %r102 to i32
store i32 %r105, i32* %r104
%r106 = lshr i224 %r102, 32
%r108 = getelementptr i32, i32* %r2, i32 4
%r109 = trunc i224 %r106 to i32
store i32 %r109, i32* %r108
%r110 = lshr i224 %r106, 32
%r112 = getelementptr i32, i32* %r2, i32 5
%r113 = trunc i224 %r110 to i32
store i32 %r113, i32* %r112
%r114 = lshr i224 %r110, 32
%r116 = getelementptr i32, i32* %r2, i32 6
%r117 = trunc i224 %r114 to i32
store i32 %r117, i32* %r116
%r118 = lshr i256 %r89, 224
%r119 = trunc i256 %r118 to i32
ret i32 %r119
}
define void @mclb_mul7(i32* noalias  %r1, i32* noalias  %r2, i32* noalias  %r3)
{
%r4 = load i32, i32* %r3
%r5 = call i256 @mulUnit_inner224(i32* %r2, i32 %r4)
%r6 = trunc i256 %r5 to i32
store i32 %r6, i32* %r1
%r7 = lshr i256 %r5, 32
%r9 = getelementptr i32, i32* %r3, i32 1
%r10 = load i32, i32* %r9
%r11 = call i256 @mulUnit_inner224(i32* %r2, i32 %r10)
%r12 = add i256 %r7, %r11
%r13 = trunc i256 %r12 to i32
%r15 = getelementptr i32, i32* %r1, i32 1
store i32 %r13, i32* %r15
%r16 = lshr i256 %r12, 32
%r18 = getelementptr i32, i32* %r3, i32 2
%r19 = load i32, i32* %r18
%r20 = call i256 @mulUnit_inner224(i32* %r2, i32 %r19)
%r21 = add i256 %r16, %r20
%r22 = trunc i256 %r21 to i32
%r24 = getelementptr i32, i32* %r1, i32 2
store i32 %r22, i32* %r24
%r25 = lshr i256 %r21, 32
%r27 = getelementptr i32, i32* %r3, i32 3
%r28 = load i32, i32* %r27
%r29 = call i256 @mulUnit_inner224(i32* %r2, i32 %r28)
%r30 = add i256 %r25, %r29
%r31 = trunc i256 %r30 to i32
%r33 = getelementptr i32, i32* %r1, i32 3
store i32 %r31, i32* %r33
%r34 = lshr i256 %r30, 32
%r36 = getelementptr i32, i32* %r3, i32 4
%r37 = load i32, i32* %r36
%r38 = call i256 @mulUnit_inner224(i32* %r2, i32 %r37)
%r39 = add i256 %r34, %r38
%r40 = trunc i256 %r39 to i32
%r42 = getelementptr i32, i32* %r1, i32 4
store i32 %r40, i32* %r42
%r43 = lshr i256 %r39, 32
%r45 = getelementptr i32, i32* %r3, i32 5
%r46 = load i32, i32* %r45
%r47 = call i256 @mulUnit_inner224(i32* %r2, i32 %r46)
%r48 = add i256 %r43, %r47
%r49 = trunc i256 %r48 to i32
%r51 = getelementptr i32, i32* %r1, i32 5
store i32 %r49, i32* %r51
%r52 = lshr i256 %r48, 32
%r54 = getelementptr i32, i32* %r3, i32 6
%r55 = load i32, i32* %r54
%r56 = call i256 @mulUnit_inner224(i32* %r2, i32 %r55)
%r57 = add i256 %r52, %r56
%r59 = getelementptr i32, i32* %r1, i32 6
%r61 = getelementptr i32, i32* %r59, i32 0
%r62 = trunc i256 %r57 to i32
store i32 %r62, i32* %r61
%r63 = lshr i256 %r57, 32
%r65 = getelementptr i32, i32* %r59, i32 1
%r66 = trunc i256 %r63 to i32
store i32 %r66, i32* %r65
%r67 = lshr i256 %r63, 32
%r69 = getelementptr i32, i32* %r59, i32 2
%r70 = trunc i256 %r67 to i32
store i32 %r70, i32* %r69
%r71 = lshr i256 %r67, 32
%r73 = getelementptr i32, i32* %r59, i32 3
%r74 = trunc i256 %r71 to i32
store i32 %r74, i32* %r73
%r75 = lshr i256 %r71, 32
%r77 = getelementptr i32, i32* %r59, i32 4
%r78 = trunc i256 %r75 to i32
store i32 %r78, i32* %r77
%r79 = lshr i256 %r75, 32
%r81 = getelementptr i32, i32* %r59, i32 5
%r82 = trunc i256 %r79 to i32
store i32 %r82, i32* %r81
%r83 = lshr i256 %r79, 32
%r85 = getelementptr i32, i32* %r59, i32 6
%r86 = trunc i256 %r83 to i32
store i32 %r86, i32* %r85
%r87 = lshr i256 %r83, 32
%r89 = getelementptr i32, i32* %r59, i32 7
%r90 = trunc i256 %r87 to i32
store i32 %r90, i32* %r89
ret void
}
define void @mclb_sqr7(i32* noalias  %r1, i32* noalias  %r2)
{
%r3 = load i32, i32* %r2
%r4 = call i64 @mul32x32L(i32 %r3, i32 %r3)
%r5 = trunc i64 %r4 to i32
store i32 %r5, i32* %r1
%r6 = lshr i64 %r4, 32
%r8 = getelementptr i32, i32* %r2, i32 6
%r9 = load i32, i32* %r8
%r10 = call i64 @mul32x32L(i32 %r3, i32 %r9)
%r11 = load i32, i32* %r2
%r13 = getelementptr i32, i32* %r2, i32 5
%r14 = load i32, i32* %r13
%r15 = call i64 @mul32x32L(i32 %r11, i32 %r14)
%r17 = getelementptr i32, i32* %r2, i32 1
%r18 = load i32, i32* %r17
%r20 = getelementptr i32, i32* %r2, i32 6
%r21 = load i32, i32* %r20
%r22 = call i64 @mul32x32L(i32 %r18, i32 %r21)
%r23 = zext i64 %r15 to i128
%r24 = zext i64 %r22 to i128
%r25 = shl i128 %r24, 64
%r26 = or i128 %r23, %r25
%r27 = zext i64 %r10 to i128
%r28 = shl i128 %r27, 32
%r29 = add i128 %r28, %r26
%r30 = load i32, i32* %r2
%r32 = getelementptr i32, i32* %r2, i32 4
%r33 = load i32, i32* %r32
%r34 = call i64 @mul32x32L(i32 %r30, i32 %r33)
%r36 = getelementptr i32, i32* %r2, i32 1
%r37 = load i32, i32* %r36
%r39 = getelementptr i32, i32* %r2, i32 5
%r40 = load i32, i32* %r39
%r41 = call i64 @mul32x32L(i32 %r37, i32 %r40)
%r42 = zext i64 %r34 to i128
%r43 = zext i64 %r41 to i128
%r44 = shl i128 %r43, 64
%r45 = or i128 %r42, %r44
%r47 = getelementptr i32, i32* %r2, i32 2
%r48 = load i32, i32* %r47
%r50 = getelementptr i32, i32* %r2, i32 6
%r51 = load i32, i32* %r50
%r52 = call i64 @mul32x32L(i32 %r48, i32 %r51)
%r53 = zext i128 %r45 to i192
%r54 = zext i64 %r52 to i192
%r55 = shl i192 %r54, 128
%r56 = or i192 %r53, %r55
%r57 = zext i128 %r29 to i192
%r58 = shl i192 %r57, 32
%r59 = add i192 %r58, %r56
%r60 = load i32, i32* %r2
%r62 = getelementptr i32, i32* %r2, i32 3
%r63 = load i32, i32* %r62
%r64 = call i64 @mul32x32L(i32 %r60, i32 %r63)
%r66 = getelementptr i32, i32* %r2, i32 1
%r67 = load i32, i32* %r66
%r69 = getelementptr i32, i32* %r2, i32 4
%r70 = load i32, i32* %r69
%r71 = call i64 @mul32x32L(i32 %r67, i32 %r70)
%r72 = zext i64 %r64 to i128
%r73 = zext i64 %r71 to i128
%r74 = shl i128 %r73, 64
%r75 = or i128 %r72, %r74
%r77 = getelementptr i32, i32* %r2, i32 2
%r78 = load i32, i32* %r77
%r80 = getelementptr i32, i32* %r2, i32 5
%r81 = load i32, i32* %r80
%r82 = call i64 @mul32x32L(i32 %r78, i32 %r81)
%r83 = zext i128 %r75 to i192
%r84 = zext i64 %r82 to i192
%r85 = shl i192 %r84, 128
%r86 = or i192 %r83, %r85
%r88 = getelementptr i32, i32* %r2, i32 3
%r89 = load i32, i32* %r88
%r91 = getelementptr i32, i32* %r2, i32 6
%r92 = load i32, i32* %r91
%r93 = call i64 @mul32x32L(i32 %r89, i32 %r92)
%r94 = zext i192 %r86 to i256
%r95 = zext i64 %r93 to i256
%r96 = shl i256 %r95, 192
%r97 = or i256 %r94, %r96
%r98 = zext i192 %r59 to i256
%r99 = shl i256 %r98, 32
%r100 = add i256 %r99, %r97
%r101 = load i32, i32* %r2
%r103 = getelementptr i32, i32* %r2, i32 2
%r104 = load i32, i32* %r103
%r105 = call i64 @mul32x32L(i32 %r101, i32 %r104)
%r107 = getelementptr i32, i32* %r2, i32 1
%r108 = load i32, i32* %r107
%r110 = getelementptr i32, i32* %r2, i32 3
%r111 = load i32, i32* %r110
%r112 = call i64 @mul32x32L(i32 %r108, i32 %r111)
%r113 = zext i64 %r105 to i128
%r114 = zext i64 %r112 to i128
%r115 = shl i128 %r114, 64
%r116 = or i128 %r113, %r115
%r118 = getelementptr i32, i32* %r2, i32 2
%r119 = load i32, i32* %r118
%r121 = getelementptr i32, i32* %r2, i32 4
%r122 = load i32, i32* %r121
%r123 = call i64 @mul32x32L(i32 %r119, i32 %r122)
%r124 = zext i128 %r116 to i192
%r125 = zext i64 %r123 to i192
%r126 = shl i192 %r125, 128
%r127 = or i192 %r124, %r126
%r129 = getelementptr i32, i32* %r2, i32 3
%r130 = load i32, i32* %r129
%r132 = getelementptr i32, i32* %r2, i32 5
%r133 = load i32, i32* %r132
%r134 = call i64 @mul32x32L(i32 %r130, i32 %r133)
%r135 = zext i192 %r127 to i256
%r136 = zext i64 %r134 to i256
%r137 = shl i256 %r136, 192
%r138 = or i256 %r135, %r137
%r140 = getelementptr i32, i32* %r2, i32 4
%r141 = load i32, i32* %r140
%r143 = getelementptr i32, i32* %r2, i32 6
%r144 = load i32, i32* %r143
%r145 = call i64 @mul32x32L(i32 %r141, i32 %r144)
%r146 = zext i256 %r138 to i320
%r147 = zext i64 %r145 to i320
%r148 = shl i320 %r147, 256
%r149 = or i320 %r146, %r148
%r150 = zext i256 %r100 to i320
%r151 = shl i320 %r150, 32
%r152 = add i320 %r151, %r149
%r153 = load i32, i32* %r2
%r155 = getelementptr i32, i32* %r2, i32 1
%r156 = load i32, i32* %r155
%r157 = call i64 @mul32x32L(i32 %r153, i32 %r156)
%r159 = getelementptr i32, i32* %r2, i32 1
%r160 = load i32, i32* %r159
%r162 = getelementptr i32, i32* %r2, i32 2
%r163 = load i32, i32* %r162
%r164 = call i64 @mul32x32L(i32 %r160, i32 %r163)
%r165 = zext i64 %r157 to i128
%r166 = zext i64 %r164 to i128
%r167 = shl i128 %r166, 64
%r168 = or i128 %r165, %r167
%r170 = getelementptr i32, i32* %r2, i32 2
%r171 = load i32, i32* %r170
%r173 = getelementptr i32, i32* %r2, i32 3
%r174 = load i32, i32* %r173
%r175 = call i64 @mul32x32L(i32 %r171, i32 %r174)
%r176 = zext i128 %r168 to i192
%r177 = zext i64 %r175 to i192
%r178 = shl i192 %r177, 128
%r179 = or i192 %r176, %r178
%r181 = getelementptr i32, i32* %r2, i32 3
%r182 = load i32, i32* %r181
%r184 = getelementptr i32, i32* %r2, i32 4
%r185 = load i32, i32* %r184
%r186 = call i64 @mul32x32L(i32 %r182, i32 %r185)
%r187 = zext i192 %r179 to i256
%r188 = zext i64 %r186 to i256
%r189 = shl i256 %r188, 192
%r190 = or i256 %r187, %r189
%r192 = getelementptr i32, i32* %r2, i32 4
%r193 = load i32, i32* %r192
%r195 = getelementptr i32, i32* %r2, i32 5
%r196 = load i32, i32* %r195
%r197 = call i64 @mul32x32L(i32 %r193, i32 %r196)
%r198 = zext i256 %r190 to i320
%r199 = zext i64 %r197 to i320
%r200 = shl i320 %r199, 256
%r201 = or i320 %r198, %r200
%r203 = getelementptr i32, i32* %r2, i32 5
%r204 = load i32, i32* %r203
%r206 = getelementptr i32, i32* %r2, i32 6
%r207 = load i32, i32* %r206
%r208 = call i64 @mul32x32L(i32 %r204, i32 %r207)
%r209 = zext i320 %r201 to i384
%r210 = zext i64 %r208 to i384
%r211 = shl i384 %r210, 320
%r212 = or i384 %r209, %r211
%r213 = zext i320 %r152 to i384
%r214 = shl i384 %r213, 32
%r215 = add i384 %r214, %r212
%r216 = zext i64 %r6 to i416
%r218 = getelementptr i32, i32* %r2, i32 1
%r219 = load i32, i32* %r218
%r220 = call i64 @mul32x32L(i32 %r219, i32 %r219)
%r221 = zext i64 %r220 to i416
%r222 = shl i416 %r221, 32
%r223 = or i416 %r216, %r222
%r225 = getelementptr i32, i32* %r2, i32 2
%r226 = load i32, i32* %r225
%r227 = call i64 @mul32x32L(i32 %r226, i32 %r226)
%r228 = zext i64 %r227 to i416
%r229 = shl i416 %r228, 96
%r230 = or i416 %r223, %r229
%r232 = getelementptr i32, i32* %r2, i32 3
%r233 = load i32, i32* %r232
%r234 = call i64 @mul32x32L(i32 %r233, i32 %r233)
%r235 = zext i64 %r234 to i416
%r236 = shl i416 %r235, 160
%r237 = or i416 %r230, %r236
%r239 = getelementptr i32, i32* %r2, i32 4
%r240 = load i32, i32* %r239
%r241 = call i64 @mul32x32L(i32 %r240, i32 %r240)
%r242 = zext i64 %r241 to i416
%r243 = shl i416 %r242, 224
%r244 = or i416 %r237, %r243
%r246 = getelementptr i32, i32* %r2, i32 5
%r247 = load i32, i32* %r246
%r248 = call i64 @mul32x32L(i32 %r247, i32 %r247)
%r249 = zext i64 %r248 to i416
%r250 = shl i416 %r249, 288
%r251 = or i416 %r244, %r250
%r253 = getelementptr i32, i32* %r2, i32 6
%r254 = load i32, i32* %r253
%r255 = call i64 @mul32x32L(i32 %r254, i32 %r254)
%r256 = zext i64 %r255 to i416
%r257 = shl i416 %r256, 352
%r258 = or i416 %r251, %r257
%r259 = zext i384 %r215 to i416
%r260 = add i416 %r259, %r259
%r261 = add i416 %r258, %r260
%r263 = getelementptr i32, i32* %r1, i32 1
%r265 = getelementptr i32, i32* %r263, i32 0
%r266 = trunc i416 %r261 to i32
store i32 %r266, i32* %r265
%r267 = lshr i416 %r261, 32
%r269 = getelementptr i32, i32* %r263, i32 1
%r270 = trunc i416 %r267 to i32
store i32 %r270, i32* %r269
%r271 = lshr i416 %r267, 32
%r273 = getelementptr i32, i32* %r263, i32 2
%r274 = trunc i416 %r271 to i32
store i32 %r274, i32* %r273
%r275 = lshr i416 %r271, 32
%r277 = getelementptr i32, i32* %r263, i32 3
%r278 = trunc i416 %r275 to i32
store i32 %r278, i32* %r277
%r279 = lshr i416 %r275, 32
%r281 = getelementptr i32, i32* %r263, i32 4
%r282 = trunc i416 %r279 to i32
store i32 %r282, i32* %r281
%r283 = lshr i416 %r279, 32
%r285 = getelementptr i32, i32* %r263, i32 5
%r286 = trunc i416 %r283 to i32
store i32 %r286, i32* %r285
%r287 = lshr i416 %r283, 32
%r289 = getelementptr i32, i32* %r263, i32 6
%r290 = trunc i416 %r287 to i32
store i32 %r290, i32* %r289
%r291 = lshr i416 %r287, 32
%r293 = getelementptr i32, i32* %r263, i32 7
%r294 = trunc i416 %r291 to i32
store i32 %r294, i32* %r293
%r295 = lshr i416 %r291, 32
%r297 = getelementptr i32, i32* %r263, i32 8
%r298 = trunc i416 %r295 to i32
store i32 %r298, i32* %r297
%r299 = lshr i416 %r295, 32
%r301 = getelementptr i32, i32* %r263, i32 9
%r302 = trunc i416 %r299 to i32
store i32 %r302, i32* %r301
%r303 = lshr i416 %r299, 32
%r305 = getelementptr i32, i32* %r263, i32 10
%r306 = trunc i416 %r303 to i32
store i32 %r306, i32* %r305
%r307 = lshr i416 %r303, 32
%r309 = getelementptr i32, i32* %r263, i32 11
%r310 = trunc i416 %r307 to i32
store i32 %r310, i32* %r309
%r311 = lshr i416 %r307, 32
%r313 = getelementptr i32, i32* %r263, i32 12
%r314 = trunc i416 %r311 to i32
store i32 %r314, i32* %r313
ret void
}
define i288 @mulUnit_inner256(i32* noalias  %r2, i32 %r3)
{
%r5 = call i64 @mulPos32x32(i32* %r2, i32 %r3, i32 0)
%r6 = trunc i64 %r5 to i32
%r7 = call i32 @extractHigh32(i64 %r5)
%r9 = call i64 @mulPos32x32(i32* %r2, i32 %r3, i32 1)
%r10 = trunc i64 %r9 to i32
%r11 = call i32 @extractHigh32(i64 %r9)
%r13 = call i64 @mulPos32x32(i32* %r2, i32 %r3, i32 2)
%r14 = trunc i64 %r13 to i32
%r15 = call i32 @extractHigh32(i64 %r13)
%r17 = call i64 @mulPos32x32(i32* %r2, i32 %r3, i32 3)
%r18 = trunc i64 %r17 to i32
%r19 = call i32 @extractHigh32(i64 %r17)
%r21 = call i64 @mulPos32x32(i32* %r2, i32 %r3, i32 4)
%r22 = trunc i64 %r21 to i32
%r23 = call i32 @extractHigh32(i64 %r21)
%r25 = call i64 @mulPos32x32(i32* %r2, i32 %r3, i32 5)
%r26 = trunc i64 %r25 to i32
%r27 = call i32 @extractHigh32(i64 %r25)
%r29 = call i64 @mulPos32x32(i32* %r2, i32 %r3, i32 6)
%r30 = trunc i64 %r29 to i32
%r31 = call i32 @extractHigh32(i64 %r29)
%r33 = call i64 @mulPos32x32(i32* %r2, i32 %r3, i32 7)
%r34 = trunc i64 %r33 to i32
%r35 = call i32 @extractHigh32(i64 %r33)
%r36 = zext i32 %r6 to i64
%r37 = zext i32 %r10 to i64
%r38 = shl i64 %r37, 32
%r39 = or i64 %r36, %r38
%r40 = zext i64 %r39 to i96
%r41 = zext i32 %r14 to i96
%r42 = shl i96 %r41, 64
%r43 = or i96 %r40, %r42
%r44 = zext i96 %r43 to i128
%r45 = zext i32 %r18 to i128
%r46 = shl i128 %r45, 96
%r47 = or i128 %r44, %r46
%r48 = zext i128 %r47 to i160
%r49 = zext i32 %r22 to i160
%r50 = shl i160 %r49, 128
%r51 = or i160 %r48, %r50
%r52 = zext i160 %r51 to i192
%r53 = zext i32 %r26 to i192
%r54 = shl i192 %r53, 160
%r55 = or i192 %r52, %r54
%r56 = zext i192 %r55 to i224
%r57 = zext i32 %r30 to i224
%r58 = shl i224 %r57, 192
%r59 = or i224 %r56, %r58
%r60 = zext i224 %r59 to i256
%r61 = zext i32 %r34 to i256
%r62 = shl i256 %r61, 224
%r63 = or i256 %r60, %r62
%r64 = zext i32 %r7 to i64
%r65 = zext i32 %r11 to i64
%r66 = shl i64 %r65, 32
%r67 = or i64 %r64, %r66
%r68 = zext i64 %r67 to i96
%r69 = zext i32 %r15 to i96
%r70 = shl i96 %r69, 64
%r71 = or i96 %r68, %r70
%r72 = zext i96 %r71 to i128
%r73 = zext i32 %r19 to i128
%r74 = shl i128 %r73, 96
%r75 = or i128 %r72, %r74
%r76 = zext i128 %r75 to i160
%r77 = zext i32 %r23 to i160
%r78 = shl i160 %r77, 128
%r79 = or i160 %r76, %r78
%r80 = zext i160 %r79 to i192
%r81 = zext i32 %r27 to i192
%r82 = shl i192 %r81, 160
%r83 = or i192 %r80, %r82
%r84 = zext i192 %r83 to i224
%r85 = zext i32 %r31 to i224
%r86 = shl i224 %r85, 192
%r87 = or i224 %r84, %r86
%r88 = zext i224 %r87 to i256
%r89 = zext i32 %r35 to i256
%r90 = shl i256 %r89, 224
%r91 = or i256 %r88, %r90
%r92 = zext i256 %r63 to i288
%r93 = zext i256 %r91 to i288
%r94 = shl i288 %r93, 32
%r95 = add i288 %r92, %r94
ret i288 %r95
}
define i32 @mclb_mulUnit8(i32* noalias  %r2, i32* noalias  %r3, i32 %r4)
{
%r5 = call i288 @mulUnit_inner256(i32* %r3, i32 %r4)
%r6 = trunc i288 %r5 to i256
%r8 = getelementptr i32, i32* %r2, i32 0
%r9 = trunc i256 %r6 to i32
store i32 %r9, i32* %r8
%r10 = lshr i256 %r6, 32
%r12 = getelementptr i32, i32* %r2, i32 1
%r13 = trunc i256 %r10 to i32
store i32 %r13, i32* %r12
%r14 = lshr i256 %r10, 32
%r16 = getelementptr i32, i32* %r2, i32 2
%r17 = trunc i256 %r14 to i32
store i32 %r17, i32* %r16
%r18 = lshr i256 %r14, 32
%r20 = getelementptr i32, i32* %r2, i32 3
%r21 = trunc i256 %r18 to i32
store i32 %r21, i32* %r20
%r22 = lshr i256 %r18, 32
%r24 = getelementptr i32, i32* %r2, i32 4
%r25 = trunc i256 %r22 to i32
store i32 %r25, i32* %r24
%r26 = lshr i256 %r22, 32
%r28 = getelementptr i32, i32* %r2, i32 5
%r29 = trunc i256 %r26 to i32
store i32 %r29, i32* %r28
%r30 = lshr i256 %r26, 32
%r32 = getelementptr i32, i32* %r2, i32 6
%r33 = trunc i256 %r30 to i32
store i32 %r33, i32* %r32
%r34 = lshr i256 %r30, 32
%r36 = getelementptr i32, i32* %r2, i32 7
%r37 = trunc i256 %r34 to i32
store i32 %r37, i32* %r36
%r38 = lshr i288 %r5, 256
%r39 = trunc i288 %r38 to i32
ret i32 %r39
}
define i32 @mclb_mulUnitAdd8(i32* noalias  %r2, i32* noalias  %r3, i32 %r4)
{
%r6 = call i64 @mulPos32x32(i32* %r3, i32 %r4, i32 0)
%r7 = trunc i64 %r6 to i32
%r8 = call i32 @extractHigh32(i64 %r6)
%r10 = call i64 @mulPos32x32(i32* %r3, i32 %r4, i32 1)
%r11 = trunc i64 %r10 to i32
%r12 = call i32 @extractHigh32(i64 %r10)
%r14 = call i64 @mulPos32x32(i32* %r3, i32 %r4, i32 2)
%r15 = trunc i64 %r14 to i32
%r16 = call i32 @extractHigh32(i64 %r14)
%r18 = call i64 @mulPos32x32(i32* %r3, i32 %r4, i32 3)
%r19 = trunc i64 %r18 to i32
%r20 = call i32 @extractHigh32(i64 %r18)
%r22 = call i64 @mulPos32x32(i32* %r3, i32 %r4, i32 4)
%r23 = trunc i64 %r22 to i32
%r24 = call i32 @extractHigh32(i64 %r22)
%r26 = call i64 @mulPos32x32(i32* %r3, i32 %r4, i32 5)
%r27 = trunc i64 %r26 to i32
%r28 = call i32 @extractHigh32(i64 %r26)
%r30 = call i64 @mulPos32x32(i32* %r3, i32 %r4, i32 6)
%r31 = trunc i64 %r30 to i32
%r32 = call i32 @extractHigh32(i64 %r30)
%r34 = call i64 @mulPos32x32(i32* %r3, i32 %r4, i32 7)
%r35 = trunc i64 %r34 to i32
%r36 = call i32 @extractHigh32(i64 %r34)
%r37 = zext i32 %r7 to i64
%r38 = zext i32 %r11 to i64
%r39 = shl i64 %r38, 32
%r40 = or i64 %r37, %r39
%r41 = zext i64 %r40 to i96
%r42 = zext i32 %r15 to i96
%r43 = shl i96 %r42, 64
%r44 = or i96 %r41, %r43
%r45 = zext i96 %r44 to i128
%r46 = zext i32 %r19 to i128
%r47 = shl i128 %r46, 96
%r48 = or i128 %r45, %r47
%r49 = zext i128 %r48 to i160
%r50 = zext i32 %r23 to i160
%r51 = shl i160 %r50, 128
%r52 = or i160 %r49, %r51
%r53 = zext i160 %r52 to i192
%r54 = zext i32 %r27 to i192
%r55 = shl i192 %r54, 160
%r56 = or i192 %r53, %r55
%r57 = zext i192 %r56 to i224
%r58 = zext i32 %r31 to i224
%r59 = shl i224 %r58, 192
%r60 = or i224 %r57, %r59
%r61 = zext i224 %r60 to i256
%r62 = zext i32 %r35 to i256
%r63 = shl i256 %r62, 224
%r64 = or i256 %r61, %r63
%r65 = zext i32 %r8 to i64
%r66 = zext i32 %r12 to i64
%r67 = shl i64 %r66, 32
%r68 = or i64 %r65, %r67
%r69 = zext i64 %r68 to i96
%r70 = zext i32 %r16 to i96
%r71 = shl i96 %r70, 64
%r72 = or i96 %r69, %r71
%r73 = zext i96 %r72 to i128
%r74 = zext i32 %r20 to i128
%r75 = shl i128 %r74, 96
%r76 = or i128 %r73, %r75
%r77 = zext i128 %r76 to i160
%r78 = zext i32 %r24 to i160
%r79 = shl i160 %r78, 128
%r80 = or i160 %r77, %r79
%r81 = zext i160 %r80 to i192
%r82 = zext i32 %r28 to i192
%r83 = shl i192 %r82, 160
%r84 = or i192 %r81, %r83
%r85 = zext i192 %r84 to i224
%r86 = zext i32 %r32 to i224
%r87 = shl i224 %r86, 192
%r88 = or i224 %r85, %r87
%r89 = zext i224 %r88 to i256
%r90 = zext i32 %r36 to i256
%r91 = shl i256 %r90, 224
%r92 = or i256 %r89, %r91
%r93 = zext i256 %r64 to i288
%r94 = zext i256 %r92 to i288
%r95 = shl i288 %r94, 32
%r96 = add i288 %r93, %r95
%r98 = bitcast i32* %r2 to i256*
%r99 = load i256, i256* %r98
%r100 = zext i256 %r99 to i288
%r101 = add i288 %r96, %r100
%r102 = trunc i288 %r101 to i256
%r104 = getelementptr i32, i32* %r2, i32 0
%r105 = trunc i256 %r102 to i32
store i32 %r105, i32* %r104
%r106 = lshr i256 %r102, 32
%r108 = getelementptr i32, i32* %r2, i32 1
%r109 = trunc i256 %r106 to i32
store i32 %r109, i32* %r108
%r110 = lshr i256 %r106, 32
%r112 = getelementptr i32, i32* %r2, i32 2
%r113 = trunc i256 %r110 to i32
store i32 %r113, i32* %r112
%r114 = lshr i256 %r110, 32
%r116 = getelementptr i32, i32* %r2, i32 3
%r117 = trunc i256 %r114 to i32
store i32 %r117, i32* %r116
%r118 = lshr i256 %r114, 32
%r120 = getelementptr i32, i32* %r2, i32 4
%r121 = trunc i256 %r118 to i32
store i32 %r121, i32* %r120
%r122 = lshr i256 %r118, 32
%r124 = getelementptr i32, i32* %r2, i32 5
%r125 = trunc i256 %r122 to i32
store i32 %r125, i32* %r124
%r126 = lshr i256 %r122, 32
%r128 = getelementptr i32, i32* %r2, i32 6
%r129 = trunc i256 %r126 to i32
store i32 %r129, i32* %r128
%r130 = lshr i256 %r126, 32
%r132 = getelementptr i32, i32* %r2, i32 7
%r133 = trunc i256 %r130 to i32
store i32 %r133, i32* %r132
%r134 = lshr i288 %r101, 256
%r135 = trunc i288 %r134 to i32
ret i32 %r135
}
define void @mclb_mul8(i32* noalias  %r1, i32* noalias  %r2, i32* noalias  %r3)
{
%r4 = load i32, i32* %r3
%r5 = call i288 @mulUnit_inner256(i32* %r2, i32 %r4)
%r6 = trunc i288 %r5 to i32
store i32 %r6, i32* %r1
%r7 = lshr i288 %r5, 32
%r9 = getelementptr i32, i32* %r3, i32 1
%r10 = load i32, i32* %r9
%r11 = call i288 @mulUnit_inner256(i32* %r2, i32 %r10)
%r12 = add i288 %r7, %r11
%r13 = trunc i288 %r12 to i32
%r15 = getelementptr i32, i32* %r1, i32 1
store i32 %r13, i32* %r15
%r16 = lshr i288 %r12, 32
%r18 = getelementptr i32, i32* %r3, i32 2
%r19 = load i32, i32* %r18
%r20 = call i288 @mulUnit_inner256(i32* %r2, i32 %r19)
%r21 = add i288 %r16, %r20
%r22 = trunc i288 %r21 to i32
%r24 = getelementptr i32, i32* %r1, i32 2
store i32 %r22, i32* %r24
%r25 = lshr i288 %r21, 32
%r27 = getelementptr i32, i32* %r3, i32 3
%r28 = load i32, i32* %r27
%r29 = call i288 @mulUnit_inner256(i32* %r2, i32 %r28)
%r30 = add i288 %r25, %r29
%r31 = trunc i288 %r30 to i32
%r33 = getelementptr i32, i32* %r1, i32 3
store i32 %r31, i32* %r33
%r34 = lshr i288 %r30, 32
%r36 = getelementptr i32, i32* %r3, i32 4
%r37 = load i32, i32* %r36
%r38 = call i288 @mulUnit_inner256(i32* %r2, i32 %r37)
%r39 = add i288 %r34, %r38
%r40 = trunc i288 %r39 to i32
%r42 = getelementptr i32, i32* %r1, i32 4
store i32 %r40, i32* %r42
%r43 = lshr i288 %r39, 32
%r45 = getelementptr i32, i32* %r3, i32 5
%r46 = load i32, i32* %r45
%r47 = call i288 @mulUnit_inner256(i32* %r2, i32 %r46)
%r48 = add i288 %r43, %r47
%r49 = trunc i288 %r48 to i32
%r51 = getelementptr i32, i32* %r1, i32 5
store i32 %r49, i32* %r51
%r52 = lshr i288 %r48, 32
%r54 = getelementptr i32, i32* %r3, i32 6
%r55 = load i32, i32* %r54
%r56 = call i288 @mulUnit_inner256(i32* %r2, i32 %r55)
%r57 = add i288 %r52, %r56
%r58 = trunc i288 %r57 to i32
%r60 = getelementptr i32, i32* %r1, i32 6
store i32 %r58, i32* %r60
%r61 = lshr i288 %r57, 32
%r63 = getelementptr i32, i32* %r3, i32 7
%r64 = load i32, i32* %r63
%r65 = call i288 @mulUnit_inner256(i32* %r2, i32 %r64)
%r66 = add i288 %r61, %r65
%r68 = getelementptr i32, i32* %r1, i32 7
%r70 = getelementptr i32, i32* %r68, i32 0
%r71 = trunc i288 %r66 to i32
store i32 %r71, i32* %r70
%r72 = lshr i288 %r66, 32
%r74 = getelementptr i32, i32* %r68, i32 1
%r75 = trunc i288 %r72 to i32
store i32 %r75, i32* %r74
%r76 = lshr i288 %r72, 32
%r78 = getelementptr i32, i32* %r68, i32 2
%r79 = trunc i288 %r76 to i32
store i32 %r79, i32* %r78
%r80 = lshr i288 %r76, 32
%r82 = getelementptr i32, i32* %r68, i32 3
%r83 = trunc i288 %r80 to i32
store i32 %r83, i32* %r82
%r84 = lshr i288 %r80, 32
%r86 = getelementptr i32, i32* %r68, i32 4
%r87 = trunc i288 %r84 to i32
store i32 %r87, i32* %r86
%r88 = lshr i288 %r84, 32
%r90 = getelementptr i32, i32* %r68, i32 5
%r91 = trunc i288 %r88 to i32
store i32 %r91, i32* %r90
%r92 = lshr i288 %r88, 32
%r94 = getelementptr i32, i32* %r68, i32 6
%r95 = trunc i288 %r92 to i32
store i32 %r95, i32* %r94
%r96 = lshr i288 %r92, 32
%r98 = getelementptr i32, i32* %r68, i32 7
%r99 = trunc i288 %r96 to i32
store i32 %r99, i32* %r98
%r100 = lshr i288 %r96, 32
%r102 = getelementptr i32, i32* %r68, i32 8
%r103 = trunc i288 %r100 to i32
store i32 %r103, i32* %r102
ret void
}
define void @mclb_sqr8(i32* noalias  %r1, i32* noalias  %r2)
{
%r3 = load i32, i32* %r2
%r4 = call i64 @mul32x32L(i32 %r3, i32 %r3)
%r5 = trunc i64 %r4 to i32
store i32 %r5, i32* %r1
%r6 = lshr i64 %r4, 32
%r8 = getelementptr i32, i32* %r2, i32 7
%r9 = load i32, i32* %r8
%r10 = call i64 @mul32x32L(i32 %r3, i32 %r9)
%r11 = load i32, i32* %r2
%r13 = getelementptr i32, i32* %r2, i32 6
%r14 = load i32, i32* %r13
%r15 = call i64 @mul32x32L(i32 %r11, i32 %r14)
%r17 = getelementptr i32, i32* %r2, i32 1
%r18 = load i32, i32* %r17
%r20 = getelementptr i32, i32* %r2, i32 7
%r21 = load i32, i32* %r20
%r22 = call i64 @mul32x32L(i32 %r18, i32 %r21)
%r23 = zext i64 %r15 to i128
%r24 = zext i64 %r22 to i128
%r25 = shl i128 %r24, 64
%r26 = or i128 %r23, %r25
%r27 = zext i64 %r10 to i128
%r28 = shl i128 %r27, 32
%r29 = add i128 %r28, %r26
%r30 = load i32, i32* %r2
%r32 = getelementptr i32, i32* %r2, i32 5
%r33 = load i32, i32* %r32
%r34 = call i64 @mul32x32L(i32 %r30, i32 %r33)
%r36 = getelementptr i32, i32* %r2, i32 1
%r37 = load i32, i32* %r36
%r39 = getelementptr i32, i32* %r2, i32 6
%r40 = load i32, i32* %r39
%r41 = call i64 @mul32x32L(i32 %r37, i32 %r40)
%r42 = zext i64 %r34 to i128
%r43 = zext i64 %r41 to i128
%r44 = shl i128 %r43, 64
%r45 = or i128 %r42, %r44
%r47 = getelementptr i32, i32* %r2, i32 2
%r48 = load i32, i32* %r47
%r50 = getelementptr i32, i32* %r2, i32 7
%r51 = load i32, i32* %r50
%r52 = call i64 @mul32x32L(i32 %r48, i32 %r51)
%r53 = zext i128 %r45 to i192
%r54 = zext i64 %r52 to i192
%r55 = shl i192 %r54, 128
%r56 = or i192 %r53, %r55
%r57 = zext i128 %r29 to i192
%r58 = shl i192 %r57, 32
%r59 = add i192 %r58, %r56
%r60 = load i32, i32* %r2
%r62 = getelementptr i32, i32* %r2, i32 4
%r63 = load i32, i32* %r62
%r64 = call i64 @mul32x32L(i32 %r60, i32 %r63)
%r66 = getelementptr i32, i32* %r2, i32 1
%r67 = load i32, i32* %r66
%r69 = getelementptr i32, i32* %r2, i32 5
%r70 = load i32, i32* %r69
%r71 = call i64 @mul32x32L(i32 %r67, i32 %r70)
%r72 = zext i64 %r64 to i128
%r73 = zext i64 %r71 to i128
%r74 = shl i128 %r73, 64
%r75 = or i128 %r72, %r74
%r77 = getelementptr i32, i32* %r2, i32 2
%r78 = load i32, i32* %r77
%r80 = getelementptr i32, i32* %r2, i32 6
%r81 = load i32, i32* %r80
%r82 = call i64 @mul32x32L(i32 %r78, i32 %r81)
%r83 = zext i128 %r75 to i192
%r84 = zext i64 %r82 to i192
%r85 = shl i192 %r84, 128
%r86 = or i192 %r83, %r85
%r88 = getelementptr i32, i32* %r2, i32 3
%r89 = load i32, i32* %r88
%r91 = getelementptr i32, i32* %r2, i32 7
%r92 = load i32, i32* %r91
%r93 = call i64 @mul32x32L(i32 %r89, i32 %r92)
%r94 = zext i192 %r86 to i256
%r95 = zext i64 %r93 to i256
%r96 = shl i256 %r95, 192
%r97 = or i256 %r94, %r96
%r98 = zext i192 %r59 to i256
%r99 = shl i256 %r98, 32
%r100 = add i256 %r99, %r97
%r101 = load i32, i32* %r2
%r103 = getelementptr i32, i32* %r2, i32 3
%r104 = load i32, i32* %r103
%r105 = call i64 @mul32x32L(i32 %r101, i32 %r104)
%r107 = getelementptr i32, i32* %r2, i32 1
%r108 = load i32, i32* %r107
%r110 = getelementptr i32, i32* %r2, i32 4
%r111 = load i32, i32* %r110
%r112 = call i64 @mul32x32L(i32 %r108, i32 %r111)
%r113 = zext i64 %r105 to i128
%r114 = zext i64 %r112 to i128
%r115 = shl i128 %r114, 64
%r116 = or i128 %r113, %r115
%r118 = getelementptr i32, i32* %r2, i32 2
%r119 = load i32, i32* %r118
%r121 = getelementptr i32, i32* %r2, i32 5
%r122 = load i32, i32* %r121
%r123 = call i64 @mul32x32L(i32 %r119, i32 %r122)
%r124 = zext i128 %r116 to i192
%r125 = zext i64 %r123 to i192
%r126 = shl i192 %r125, 128
%r127 = or i192 %r124, %r126
%r129 = getelementptr i32, i32* %r2, i32 3
%r130 = load i32, i32* %r129
%r132 = getelementptr i32, i32* %r2, i32 6
%r133 = load i32, i32* %r132
%r134 = call i64 @mul32x32L(i32 %r130, i32 %r133)
%r135 = zext i192 %r127 to i256
%r136 = zext i64 %r134 to i256
%r137 = shl i256 %r136, 192
%r138 = or i256 %r135, %r137
%r140 = getelementptr i32, i32* %r2, i32 4
%r141 = load i32, i32* %r140
%r143 = getelementptr i32, i32* %r2, i32 7
%r144 = load i32, i32* %r143
%r145 = call i64 @mul32x32L(i32 %r141, i32 %r144)
%r146 = zext i256 %r138 to i320
%r147 = zext i64 %r145 to i320
%r148 = shl i320 %r147, 256
%r149 = or i320 %r146, %r148
%r150 = zext i256 %r100 to i320
%r151 = shl i320 %r150, 32
%r152 = add i320 %r151, %r149
%r153 = load i32, i32* %r2
%r155 = getelementptr i32, i32* %r2, i32 2
%r156 = load i32, i32* %r155
%r157 = call i64 @mul32x32L(i32 %r153, i32 %r156)
%r159 = getelementptr i32, i32* %r2, i32 1
%r160 = load i32, i32* %r159
%r162 = getelementptr i32, i32* %r2, i32 3
%r163 = load i32, i32* %r162
%r164 = call i64 @mul32x32L(i32 %r160, i32 %r163)
%r165 = zext i64 %r157 to i128
%r166 = zext i64 %r164 to i128
%r167 = shl i128 %r166, 64
%r168 = or i128 %r165, %r167
%r170 = getelementptr i32, i32* %r2, i32 2
%r171 = load i32, i32* %r170
%r173 = getelementptr i32, i32* %r2, i32 4
%r174 = load i32, i32* %r173
%r175 = call i64 @mul32x32L(i32 %r171, i32 %r174)
%r176 = zext i128 %r168 to i192
%r177 = zext i64 %r175 to i192
%r178 = shl i192 %r177, 128
%r179 = or i192 %r176, %r178
%r181 = getelementptr i32, i32* %r2, i32 3
%r182 = load i32, i32* %r181
%r184 = getelementptr i32, i32* %r2, i32 5
%r185 = load i32, i32* %r184
%r186 = call i64 @mul32x32L(i32 %r182, i32 %r185)
%r187 = zext i192 %r179 to i256
%r188 = zext i64 %r186 to i256
%r189 = shl i256 %r188, 192
%r190 = or i256 %r187, %r189
%r192 = getelementptr i32, i32* %r2, i32 4
%r193 = load i32, i32* %r192
%r195 = getelementptr i32, i32* %r2, i32 6
%r196 = load i32, i32* %r195
%r197 = call i64 @mul32x32L(i32 %r193, i32 %r196)
%r198 = zext i256 %r190 to i320
%r199 = zext i64 %r197 to i320
%r200 = shl i320 %r199, 256
%r201 = or i320 %r198, %r200
%r203 = getelementptr i32, i32* %r2, i32 5
%r204 = load i32, i32* %r203
%r206 = getelementptr i32, i32* %r2, i32 7
%r207 = load i32, i32* %r206
%r208 = call i64 @mul32x32L(i32 %r204, i32 %r207)
%r209 = zext i320 %r201 to i384
%r210 = zext i64 %r208 to i384
%r211 = shl i384 %r210, 320
%r212 = or i384 %r209, %r211
%r213 = zext i320 %r152 to i384
%r214 = shl i384 %r213, 32
%r215 = add i384 %r214, %r212
%r216 = load i32, i32* %r2
%r218 = getelementptr i32, i32* %r2, i32 1
%r219 = load i32, i32* %r218
%r220 = call i64 @mul32x32L(i32 %r216, i32 %r219)
%r222 = getelementptr i32, i32* %r2, i32 1
%r223 = load i32, i32* %r222
%r225 = getelementptr i32, i32* %r2, i32 2
%r226 = load i32, i32* %r225
%r227 = call i64 @mul32x32L(i32 %r223, i32 %r226)
%r228 = zext i64 %r220 to i128
%r229 = zext i64 %r227 to i128
%r230 = shl i128 %r229, 64
%r231 = or i128 %r228, %r230
%r233 = getelementptr i32, i32* %r2, i32 2
%r234 = load i32, i32* %r233
%r236 = getelementptr i32, i32* %r2, i32 3
%r237 = load i32, i32* %r236
%r238 = call i64 @mul32x32L(i32 %r234, i32 %r237)
%r239 = zext i128 %r231 to i192
%r240 = zext i64 %r238 to i192
%r241 = shl i192 %r240, 128
%r242 = or i192 %r239, %r241
%r244 = getelementptr i32, i32* %r2, i32 3
%r245 = load i32, i32* %r244
%r247 = getelementptr i32, i32* %r2, i32 4
%r248 = load i32, i32* %r247
%r249 = call i64 @mul32x32L(i32 %r245, i32 %r248)
%r250 = zext i192 %r242 to i256
%r251 = zext i64 %r249 to i256
%r252 = shl i256 %r251, 192
%r253 = or i256 %r250, %r252
%r255 = getelementptr i32, i32* %r2, i32 4
%r256 = load i32, i32* %r255
%r258 = getelementptr i32, i32* %r2, i32 5
%r259 = load i32, i32* %r258
%r260 = call i64 @mul32x32L(i32 %r256, i32 %r259)
%r261 = zext i256 %r253 to i320
%r262 = zext i64 %r260 to i320
%r263 = shl i320 %r262, 256
%r264 = or i320 %r261, %r263
%r266 = getelementptr i32, i32* %r2, i32 5
%r267 = load i32, i32* %r266
%r269 = getelementptr i32, i32* %r2, i32 6
%r270 = load i32, i32* %r269
%r271 = call i64 @mul32x32L(i32 %r267, i32 %r270)
%r272 = zext i320 %r264 to i384
%r273 = zext i64 %r271 to i384
%r274 = shl i384 %r273, 320
%r275 = or i384 %r272, %r274
%r277 = getelementptr i32, i32* %r2, i32 6
%r278 = load i32, i32* %r277
%r280 = getelementptr i32, i32* %r2, i32 7
%r281 = load i32, i32* %r280
%r282 = call i64 @mul32x32L(i32 %r278, i32 %r281)
%r283 = zext i384 %r275 to i448
%r284 = zext i64 %r282 to i448
%r285 = shl i448 %r284, 384
%r286 = or i448 %r283, %r285
%r287 = zext i384 %r215 to i448
%r288 = shl i448 %r287, 32
%r289 = add i448 %r288, %r286
%r290 = zext i64 %r6 to i480
%r292 = getelementptr i32, i32* %r2, i32 1
%r293 = load i32, i32* %r292
%r294 = call i64 @mul32x32L(i32 %r293, i32 %r293)
%r295 = zext i64 %r294 to i480
%r296 = shl i480 %r295, 32
%r297 = or i480 %r290, %r296
%r299 = getelementptr i32, i32* %r2, i32 2
%r300 = load i32, i32* %r299
%r301 = call i64 @mul32x32L(i32 %r300, i32 %r300)
%r302 = zext i64 %r301 to i480
%r303 = shl i480 %r302, 96
%r304 = or i480 %r297, %r303
%r306 = getelementptr i32, i32* %r2, i32 3
%r307 = load i32, i32* %r306
%r308 = call i64 @mul32x32L(i32 %r307, i32 %r307)
%r309 = zext i64 %r308 to i480
%r310 = shl i480 %r309, 160
%r311 = or i480 %r304, %r310
%r313 = getelementptr i32, i32* %r2, i32 4
%r314 = load i32, i32* %r313
%r315 = call i64 @mul32x32L(i32 %r314, i32 %r314)
%r316 = zext i64 %r315 to i480
%r317 = shl i480 %r316, 224
%r318 = or i480 %r311, %r317
%r320 = getelementptr i32, i32* %r2, i32 5
%r321 = load i32, i32* %r320
%r322 = call i64 @mul32x32L(i32 %r321, i32 %r321)
%r323 = zext i64 %r322 to i480
%r324 = shl i480 %r323, 288
%r325 = or i480 %r318, %r324
%r327 = getelementptr i32, i32* %r2, i32 6
%r328 = load i32, i32* %r327
%r329 = call i64 @mul32x32L(i32 %r328, i32 %r328)
%r330 = zext i64 %r329 to i480
%r331 = shl i480 %r330, 352
%r332 = or i480 %r325, %r331
%r334 = getelementptr i32, i32* %r2, i32 7
%r335 = load i32, i32* %r334
%r336 = call i64 @mul32x32L(i32 %r335, i32 %r335)
%r337 = zext i64 %r336 to i480
%r338 = shl i480 %r337, 416
%r339 = or i480 %r332, %r338
%r340 = zext i448 %r289 to i480
%r341 = add i480 %r340, %r340
%r342 = add i480 %r339, %r341
%r344 = getelementptr i32, i32* %r1, i32 1
%r346 = getelementptr i32, i32* %r344, i32 0
%r347 = trunc i480 %r342 to i32
store i32 %r347, i32* %r346
%r348 = lshr i480 %r342, 32
%r350 = getelementptr i32, i32* %r344, i32 1
%r351 = trunc i480 %r348 to i32
store i32 %r351, i32* %r350
%r352 = lshr i480 %r348, 32
%r354 = getelementptr i32, i32* %r344, i32 2
%r355 = trunc i480 %r352 to i32
store i32 %r355, i32* %r354
%r356 = lshr i480 %r352, 32
%r358 = getelementptr i32, i32* %r344, i32 3
%r359 = trunc i480 %r356 to i32
store i32 %r359, i32* %r358
%r360 = lshr i480 %r356, 32
%r362 = getelementptr i32, i32* %r344, i32 4
%r363 = trunc i480 %r360 to i32
store i32 %r363, i32* %r362
%r364 = lshr i480 %r360, 32
%r366 = getelementptr i32, i32* %r344, i32 5
%r367 = trunc i480 %r364 to i32
store i32 %r367, i32* %r366
%r368 = lshr i480 %r364, 32
%r370 = getelementptr i32, i32* %r344, i32 6
%r371 = trunc i480 %r368 to i32
store i32 %r371, i32* %r370
%r372 = lshr i480 %r368, 32
%r374 = getelementptr i32, i32* %r344, i32 7
%r375 = trunc i480 %r372 to i32
store i32 %r375, i32* %r374
%r376 = lshr i480 %r372, 32
%r378 = getelementptr i32, i32* %r344, i32 8
%r379 = trunc i480 %r376 to i32
store i32 %r379, i32* %r378
%r380 = lshr i480 %r376, 32
%r382 = getelementptr i32, i32* %r344, i32 9
%r383 = trunc i480 %r380 to i32
store i32 %r383, i32* %r382
%r384 = lshr i480 %r380, 32
%r386 = getelementptr i32, i32* %r344, i32 10
%r387 = trunc i480 %r384 to i32
store i32 %r387, i32* %r386
%r388 = lshr i480 %r384, 32
%r390 = getelementptr i32, i32* %r344, i32 11
%r391 = trunc i480 %r388 to i32
store i32 %r391, i32* %r390
%r392 = lshr i480 %r388, 32
%r394 = getelementptr i32, i32* %r344, i32 12
%r395 = trunc i480 %r392 to i32
store i32 %r395, i32* %r394
%r396 = lshr i480 %r392, 32
%r398 = getelementptr i32, i32* %r344, i32 13
%r399 = trunc i480 %r396 to i32
store i32 %r399, i32* %r398
%r400 = lshr i480 %r396, 32
%r402 = getelementptr i32, i32* %r344, i32 14
%r403 = trunc i480 %r400 to i32
store i32 %r403, i32* %r402
ret void
}
define i320 @mulUnit_inner288(i32* noalias  %r2, i32 %r3)
{
%r5 = call i64 @mulPos32x32(i32* %r2, i32 %r3, i32 0)
%r6 = trunc i64 %r5 to i32
%r7 = call i32 @extractHigh32(i64 %r5)
%r9 = call i64 @mulPos32x32(i32* %r2, i32 %r3, i32 1)
%r10 = trunc i64 %r9 to i32
%r11 = call i32 @extractHigh32(i64 %r9)
%r13 = call i64 @mulPos32x32(i32* %r2, i32 %r3, i32 2)
%r14 = trunc i64 %r13 to i32
%r15 = call i32 @extractHigh32(i64 %r13)
%r17 = call i64 @mulPos32x32(i32* %r2, i32 %r3, i32 3)
%r18 = trunc i64 %r17 to i32
%r19 = call i32 @extractHigh32(i64 %r17)
%r21 = call i64 @mulPos32x32(i32* %r2, i32 %r3, i32 4)
%r22 = trunc i64 %r21 to i32
%r23 = call i32 @extractHigh32(i64 %r21)
%r25 = call i64 @mulPos32x32(i32* %r2, i32 %r3, i32 5)
%r26 = trunc i64 %r25 to i32
%r27 = call i32 @extractHigh32(i64 %r25)
%r29 = call i64 @mulPos32x32(i32* %r2, i32 %r3, i32 6)
%r30 = trunc i64 %r29 to i32
%r31 = call i32 @extractHigh32(i64 %r29)
%r33 = call i64 @mulPos32x32(i32* %r2, i32 %r3, i32 7)
%r34 = trunc i64 %r33 to i32
%r35 = call i32 @extractHigh32(i64 %r33)
%r37 = call i64 @mulPos32x32(i32* %r2, i32 %r3, i32 8)
%r38 = trunc i64 %r37 to i32
%r39 = call i32 @extractHigh32(i64 %r37)
%r40 = zext i32 %r6 to i64
%r41 = zext i32 %r10 to i64
%r42 = shl i64 %r41, 32
%r43 = or i64 %r40, %r42
%r44 = zext i64 %r43 to i96
%r45 = zext i32 %r14 to i96
%r46 = shl i96 %r45, 64
%r47 = or i96 %r44, %r46
%r48 = zext i96 %r47 to i128
%r49 = zext i32 %r18 to i128
%r50 = shl i128 %r49, 96
%r51 = or i128 %r48, %r50
%r52 = zext i128 %r51 to i160
%r53 = zext i32 %r22 to i160
%r54 = shl i160 %r53, 128
%r55 = or i160 %r52, %r54
%r56 = zext i160 %r55 to i192
%r57 = zext i32 %r26 to i192
%r58 = shl i192 %r57, 160
%r59 = or i192 %r56, %r58
%r60 = zext i192 %r59 to i224
%r61 = zext i32 %r30 to i224
%r62 = shl i224 %r61, 192
%r63 = or i224 %r60, %r62
%r64 = zext i224 %r63 to i256
%r65 = zext i32 %r34 to i256
%r66 = shl i256 %r65, 224
%r67 = or i256 %r64, %r66
%r68 = zext i256 %r67 to i288
%r69 = zext i32 %r38 to i288
%r70 = shl i288 %r69, 256
%r71 = or i288 %r68, %r70
%r72 = zext i32 %r7 to i64
%r73 = zext i32 %r11 to i64
%r74 = shl i64 %r73, 32
%r75 = or i64 %r72, %r74
%r76 = zext i64 %r75 to i96
%r77 = zext i32 %r15 to i96
%r78 = shl i96 %r77, 64
%r79 = or i96 %r76, %r78
%r80 = zext i96 %r79 to i128
%r81 = zext i32 %r19 to i128
%r82 = shl i128 %r81, 96
%r83 = or i128 %r80, %r82
%r84 = zext i128 %r83 to i160
%r85 = zext i32 %r23 to i160
%r86 = shl i160 %r85, 128
%r87 = or i160 %r84, %r86
%r88 = zext i160 %r87 to i192
%r89 = zext i32 %r27 to i192
%r90 = shl i192 %r89, 160
%r91 = or i192 %r88, %r90
%r92 = zext i192 %r91 to i224
%r93 = zext i32 %r31 to i224
%r94 = shl i224 %r93, 192
%r95 = or i224 %r92, %r94
%r96 = zext i224 %r95 to i256
%r97 = zext i32 %r35 to i256
%r98 = shl i256 %r97, 224
%r99 = or i256 %r96, %r98
%r100 = zext i256 %r99 to i288
%r101 = zext i32 %r39 to i288
%r102 = shl i288 %r101, 256
%r103 = or i288 %r100, %r102
%r104 = zext i288 %r71 to i320
%r105 = zext i288 %r103 to i320
%r106 = shl i320 %r105, 32
%r107 = add i320 %r104, %r106
ret i320 %r107
}
define i32 @mclb_mulUnit9(i32* noalias  %r2, i32* noalias  %r3, i32 %r4)
{
%r5 = call i320 @mulUnit_inner288(i32* %r3, i32 %r4)
%r6 = trunc i320 %r5 to i288
%r8 = getelementptr i32, i32* %r2, i32 0
%r9 = trunc i288 %r6 to i32
store i32 %r9, i32* %r8
%r10 = lshr i288 %r6, 32
%r12 = getelementptr i32, i32* %r2, i32 1
%r13 = trunc i288 %r10 to i32
store i32 %r13, i32* %r12
%r14 = lshr i288 %r10, 32
%r16 = getelementptr i32, i32* %r2, i32 2
%r17 = trunc i288 %r14 to i32
store i32 %r17, i32* %r16
%r18 = lshr i288 %r14, 32
%r20 = getelementptr i32, i32* %r2, i32 3
%r21 = trunc i288 %r18 to i32
store i32 %r21, i32* %r20
%r22 = lshr i288 %r18, 32
%r24 = getelementptr i32, i32* %r2, i32 4
%r25 = trunc i288 %r22 to i32
store i32 %r25, i32* %r24
%r26 = lshr i288 %r22, 32
%r28 = getelementptr i32, i32* %r2, i32 5
%r29 = trunc i288 %r26 to i32
store i32 %r29, i32* %r28
%r30 = lshr i288 %r26, 32
%r32 = getelementptr i32, i32* %r2, i32 6
%r33 = trunc i288 %r30 to i32
store i32 %r33, i32* %r32
%r34 = lshr i288 %r30, 32
%r36 = getelementptr i32, i32* %r2, i32 7
%r37 = trunc i288 %r34 to i32
store i32 %r37, i32* %r36
%r38 = lshr i288 %r34, 32
%r40 = getelementptr i32, i32* %r2, i32 8
%r41 = trunc i288 %r38 to i32
store i32 %r41, i32* %r40
%r42 = lshr i320 %r5, 288
%r43 = trunc i320 %r42 to i32
ret i32 %r43
}
define i32 @mclb_mulUnitAdd9(i32* noalias  %r2, i32* noalias  %r3, i32 %r4)
{
%r6 = call i64 @mulPos32x32(i32* %r3, i32 %r4, i32 0)
%r7 = trunc i64 %r6 to i32
%r8 = call i32 @extractHigh32(i64 %r6)
%r10 = call i64 @mulPos32x32(i32* %r3, i32 %r4, i32 1)
%r11 = trunc i64 %r10 to i32
%r12 = call i32 @extractHigh32(i64 %r10)
%r14 = call i64 @mulPos32x32(i32* %r3, i32 %r4, i32 2)
%r15 = trunc i64 %r14 to i32
%r16 = call i32 @extractHigh32(i64 %r14)
%r18 = call i64 @mulPos32x32(i32* %r3, i32 %r4, i32 3)
%r19 = trunc i64 %r18 to i32
%r20 = call i32 @extractHigh32(i64 %r18)
%r22 = call i64 @mulPos32x32(i32* %r3, i32 %r4, i32 4)
%r23 = trunc i64 %r22 to i32
%r24 = call i32 @extractHigh32(i64 %r22)
%r26 = call i64 @mulPos32x32(i32* %r3, i32 %r4, i32 5)
%r27 = trunc i64 %r26 to i32
%r28 = call i32 @extractHigh32(i64 %r26)
%r30 = call i64 @mulPos32x32(i32* %r3, i32 %r4, i32 6)
%r31 = trunc i64 %r30 to i32
%r32 = call i32 @extractHigh32(i64 %r30)
%r34 = call i64 @mulPos32x32(i32* %r3, i32 %r4, i32 7)
%r35 = trunc i64 %r34 to i32
%r36 = call i32 @extractHigh32(i64 %r34)
%r38 = call i64 @mulPos32x32(i32* %r3, i32 %r4, i32 8)
%r39 = trunc i64 %r38 to i32
%r40 = call i32 @extractHigh32(i64 %r38)
%r41 = zext i32 %r7 to i64
%r42 = zext i32 %r11 to i64
%r43 = shl i64 %r42, 32
%r44 = or i64 %r41, %r43
%r45 = zext i64 %r44 to i96
%r46 = zext i32 %r15 to i96
%r47 = shl i96 %r46, 64
%r48 = or i96 %r45, %r47
%r49 = zext i96 %r48 to i128
%r50 = zext i32 %r19 to i128
%r51 = shl i128 %r50, 96
%r52 = or i128 %r49, %r51
%r53 = zext i128 %r52 to i160
%r54 = zext i32 %r23 to i160
%r55 = shl i160 %r54, 128
%r56 = or i160 %r53, %r55
%r57 = zext i160 %r56 to i192
%r58 = zext i32 %r27 to i192
%r59 = shl i192 %r58, 160
%r60 = or i192 %r57, %r59
%r61 = zext i192 %r60 to i224
%r62 = zext i32 %r31 to i224
%r63 = shl i224 %r62, 192
%r64 = or i224 %r61, %r63
%r65 = zext i224 %r64 to i256
%r66 = zext i32 %r35 to i256
%r67 = shl i256 %r66, 224
%r68 = or i256 %r65, %r67
%r69 = zext i256 %r68 to i288
%r70 = zext i32 %r39 to i288
%r71 = shl i288 %r70, 256
%r72 = or i288 %r69, %r71
%r73 = zext i32 %r8 to i64
%r74 = zext i32 %r12 to i64
%r75 = shl i64 %r74, 32
%r76 = or i64 %r73, %r75
%r77 = zext i64 %r76 to i96
%r78 = zext i32 %r16 to i96
%r79 = shl i96 %r78, 64
%r80 = or i96 %r77, %r79
%r81 = zext i96 %r80 to i128
%r82 = zext i32 %r20 to i128
%r83 = shl i128 %r82, 96
%r84 = or i128 %r81, %r83
%r85 = zext i128 %r84 to i160
%r86 = zext i32 %r24 to i160
%r87 = shl i160 %r86, 128
%r88 = or i160 %r85, %r87
%r89 = zext i160 %r88 to i192
%r90 = zext i32 %r28 to i192
%r91 = shl i192 %r90, 160
%r92 = or i192 %r89, %r91
%r93 = zext i192 %r92 to i224
%r94 = zext i32 %r32 to i224
%r95 = shl i224 %r94, 192
%r96 = or i224 %r93, %r95
%r97 = zext i224 %r96 to i256
%r98 = zext i32 %r36 to i256
%r99 = shl i256 %r98, 224
%r100 = or i256 %r97, %r99
%r101 = zext i256 %r100 to i288
%r102 = zext i32 %r40 to i288
%r103 = shl i288 %r102, 256
%r104 = or i288 %r101, %r103
%r105 = zext i288 %r72 to i320
%r106 = zext i288 %r104 to i320
%r107 = shl i320 %r106, 32
%r108 = add i320 %r105, %r107
%r110 = bitcast i32* %r2 to i288*
%r111 = load i288, i288* %r110
%r112 = zext i288 %r111 to i320
%r113 = add i320 %r108, %r112
%r114 = trunc i320 %r113 to i288
%r116 = getelementptr i32, i32* %r2, i32 0
%r117 = trunc i288 %r114 to i32
store i32 %r117, i32* %r116
%r118 = lshr i288 %r114, 32
%r120 = getelementptr i32, i32* %r2, i32 1
%r121 = trunc i288 %r118 to i32
store i32 %r121, i32* %r120
%r122 = lshr i288 %r118, 32
%r124 = getelementptr i32, i32* %r2, i32 2
%r125 = trunc i288 %r122 to i32
store i32 %r125, i32* %r124
%r126 = lshr i288 %r122, 32
%r128 = getelementptr i32, i32* %r2, i32 3
%r129 = trunc i288 %r126 to i32
store i32 %r129, i32* %r128
%r130 = lshr i288 %r126, 32
%r132 = getelementptr i32, i32* %r2, i32 4
%r133 = trunc i288 %r130 to i32
store i32 %r133, i32* %r132
%r134 = lshr i288 %r130, 32
%r136 = getelementptr i32, i32* %r2, i32 5
%r137 = trunc i288 %r134 to i32
store i32 %r137, i32* %r136
%r138 = lshr i288 %r134, 32
%r140 = getelementptr i32, i32* %r2, i32 6
%r141 = trunc i288 %r138 to i32
store i32 %r141, i32* %r140
%r142 = lshr i288 %r138, 32
%r144 = getelementptr i32, i32* %r2, i32 7
%r145 = trunc i288 %r142 to i32
store i32 %r145, i32* %r144
%r146 = lshr i288 %r142, 32
%r148 = getelementptr i32, i32* %r2, i32 8
%r149 = trunc i288 %r146 to i32
store i32 %r149, i32* %r148
%r150 = lshr i320 %r113, 288
%r151 = trunc i320 %r150 to i32
ret i32 %r151
}
define void @mclb_mul9(i32* noalias  %r1, i32* noalias  %r2, i32* noalias  %r3)
{
%r4 = load i32, i32* %r3
%r5 = call i320 @mulUnit_inner288(i32* %r2, i32 %r4)
%r6 = trunc i320 %r5 to i32
store i32 %r6, i32* %r1
%r7 = lshr i320 %r5, 32
%r9 = getelementptr i32, i32* %r3, i32 1
%r10 = load i32, i32* %r9
%r11 = call i320 @mulUnit_inner288(i32* %r2, i32 %r10)
%r12 = add i320 %r7, %r11
%r13 = trunc i320 %r12 to i32
%r15 = getelementptr i32, i32* %r1, i32 1
store i32 %r13, i32* %r15
%r16 = lshr i320 %r12, 32
%r18 = getelementptr i32, i32* %r3, i32 2
%r19 = load i32, i32* %r18
%r20 = call i320 @mulUnit_inner288(i32* %r2, i32 %r19)
%r21 = add i320 %r16, %r20
%r22 = trunc i320 %r21 to i32
%r24 = getelementptr i32, i32* %r1, i32 2
store i32 %r22, i32* %r24
%r25 = lshr i320 %r21, 32
%r27 = getelementptr i32, i32* %r3, i32 3
%r28 = load i32, i32* %r27
%r29 = call i320 @mulUnit_inner288(i32* %r2, i32 %r28)
%r30 = add i320 %r25, %r29
%r31 = trunc i320 %r30 to i32
%r33 = getelementptr i32, i32* %r1, i32 3
store i32 %r31, i32* %r33
%r34 = lshr i320 %r30, 32
%r36 = getelementptr i32, i32* %r3, i32 4
%r37 = load i32, i32* %r36
%r38 = call i320 @mulUnit_inner288(i32* %r2, i32 %r37)
%r39 = add i320 %r34, %r38
%r40 = trunc i320 %r39 to i32
%r42 = getelementptr i32, i32* %r1, i32 4
store i32 %r40, i32* %r42
%r43 = lshr i320 %r39, 32
%r45 = getelementptr i32, i32* %r3, i32 5
%r46 = load i32, i32* %r45
%r47 = call i320 @mulUnit_inner288(i32* %r2, i32 %r46)
%r48 = add i320 %r43, %r47
%r49 = trunc i320 %r48 to i32
%r51 = getelementptr i32, i32* %r1, i32 5
store i32 %r49, i32* %r51
%r52 = lshr i320 %r48, 32
%r54 = getelementptr i32, i32* %r3, i32 6
%r55 = load i32, i32* %r54
%r56 = call i320 @mulUnit_inner288(i32* %r2, i32 %r55)
%r57 = add i320 %r52, %r56
%r58 = trunc i320 %r57 to i32
%r60 = getelementptr i32, i32* %r1, i32 6
store i32 %r58, i32* %r60
%r61 = lshr i320 %r57, 32
%r63 = getelementptr i32, i32* %r3, i32 7
%r64 = load i32, i32* %r63
%r65 = call i320 @mulUnit_inner288(i32* %r2, i32 %r64)
%r66 = add i320 %r61, %r65
%r67 = trunc i320 %r66 to i32
%r69 = getelementptr i32, i32* %r1, i32 7
store i32 %r67, i32* %r69
%r70 = lshr i320 %r66, 32
%r72 = getelementptr i32, i32* %r3, i32 8
%r73 = load i32, i32* %r72
%r74 = call i320 @mulUnit_inner288(i32* %r2, i32 %r73)
%r75 = add i320 %r70, %r74
%r77 = getelementptr i32, i32* %r1, i32 8
%r79 = getelementptr i32, i32* %r77, i32 0
%r80 = trunc i320 %r75 to i32
store i32 %r80, i32* %r79
%r81 = lshr i320 %r75, 32
%r83 = getelementptr i32, i32* %r77, i32 1
%r84 = trunc i320 %r81 to i32
store i32 %r84, i32* %r83
%r85 = lshr i320 %r81, 32
%r87 = getelementptr i32, i32* %r77, i32 2
%r88 = trunc i320 %r85 to i32
store i32 %r88, i32* %r87
%r89 = lshr i320 %r85, 32
%r91 = getelementptr i32, i32* %r77, i32 3
%r92 = trunc i320 %r89 to i32
store i32 %r92, i32* %r91
%r93 = lshr i320 %r89, 32
%r95 = getelementptr i32, i32* %r77, i32 4
%r96 = trunc i320 %r93 to i32
store i32 %r96, i32* %r95
%r97 = lshr i320 %r93, 32
%r99 = getelementptr i32, i32* %r77, i32 5
%r100 = trunc i320 %r97 to i32
store i32 %r100, i32* %r99
%r101 = lshr i320 %r97, 32
%r103 = getelementptr i32, i32* %r77, i32 6
%r104 = trunc i320 %r101 to i32
store i32 %r104, i32* %r103
%r105 = lshr i320 %r101, 32
%r107 = getelementptr i32, i32* %r77, i32 7
%r108 = trunc i320 %r105 to i32
store i32 %r108, i32* %r107
%r109 = lshr i320 %r105, 32
%r111 = getelementptr i32, i32* %r77, i32 8
%r112 = trunc i320 %r109 to i32
store i32 %r112, i32* %r111
%r113 = lshr i320 %r109, 32
%r115 = getelementptr i32, i32* %r77, i32 9
%r116 = trunc i320 %r113 to i32
store i32 %r116, i32* %r115
ret void
}
define void @mclb_sqr9(i32* noalias  %r1, i32* noalias  %r2)
{
%r3 = load i32, i32* %r2
%r4 = call i64 @mul32x32L(i32 %r3, i32 %r3)
%r5 = trunc i64 %r4 to i32
store i32 %r5, i32* %r1
%r6 = lshr i64 %r4, 32
%r8 = getelementptr i32, i32* %r2, i32 8
%r9 = load i32, i32* %r8
%r10 = call i64 @mul32x32L(i32 %r3, i32 %r9)
%r11 = load i32, i32* %r2
%r13 = getelementptr i32, i32* %r2, i32 7
%r14 = load i32, i32* %r13
%r15 = call i64 @mul32x32L(i32 %r11, i32 %r14)
%r17 = getelementptr i32, i32* %r2, i32 1
%r18 = load i32, i32* %r17
%r20 = getelementptr i32, i32* %r2, i32 8
%r21 = load i32, i32* %r20
%r22 = call i64 @mul32x32L(i32 %r18, i32 %r21)
%r23 = zext i64 %r15 to i128
%r24 = zext i64 %r22 to i128
%r25 = shl i128 %r24, 64
%r26 = or i128 %r23, %r25
%r27 = zext i64 %r10 to i128
%r28 = shl i128 %r27, 32
%r29 = add i128 %r28, %r26
%r30 = load i32, i32* %r2
%r32 = getelementptr i32, i32* %r2, i32 6
%r33 = load i32, i32* %r32
%r34 = call i64 @mul32x32L(i32 %r30, i32 %r33)
%r36 = getelementptr i32, i32* %r2, i32 1
%r37 = load i32, i32* %r36
%r39 = getelementptr i32, i32* %r2, i32 7
%r40 = load i32, i32* %r39
%r41 = call i64 @mul32x32L(i32 %r37, i32 %r40)
%r42 = zext i64 %r34 to i128
%r43 = zext i64 %r41 to i128
%r44 = shl i128 %r43, 64
%r45 = or i128 %r42, %r44
%r47 = getelementptr i32, i32* %r2, i32 2
%r48 = load i32, i32* %r47
%r50 = getelementptr i32, i32* %r2, i32 8
%r51 = load i32, i32* %r50
%r52 = call i64 @mul32x32L(i32 %r48, i32 %r51)
%r53 = zext i128 %r45 to i192
%r54 = zext i64 %r52 to i192
%r55 = shl i192 %r54, 128
%r56 = or i192 %r53, %r55
%r57 = zext i128 %r29 to i192
%r58 = shl i192 %r57, 32
%r59 = add i192 %r58, %r56
%r60 = load i32, i32* %r2
%r62 = getelementptr i32, i32* %r2, i32 5
%r63 = load i32, i32* %r62
%r64 = call i64 @mul32x32L(i32 %r60, i32 %r63)
%r66 = getelementptr i32, i32* %r2, i32 1
%r67 = load i32, i32* %r66
%r69 = getelementptr i32, i32* %r2, i32 6
%r70 = load i32, i32* %r69
%r71 = call i64 @mul32x32L(i32 %r67, i32 %r70)
%r72 = zext i64 %r64 to i128
%r73 = zext i64 %r71 to i128
%r74 = shl i128 %r73, 64
%r75 = or i128 %r72, %r74
%r77 = getelementptr i32, i32* %r2, i32 2
%r78 = load i32, i32* %r77
%r80 = getelementptr i32, i32* %r2, i32 7
%r81 = load i32, i32* %r80
%r82 = call i64 @mul32x32L(i32 %r78, i32 %r81)
%r83 = zext i128 %r75 to i192
%r84 = zext i64 %r82 to i192
%r85 = shl i192 %r84, 128
%r86 = or i192 %r83, %r85
%r88 = getelementptr i32, i32* %r2, i32 3
%r89 = load i32, i32* %r88
%r91 = getelementptr i32, i32* %r2, i32 8
%r92 = load i32, i32* %r91
%r93 = call i64 @mul32x32L(i32 %r89, i32 %r92)
%r94 = zext i192 %r86 to i256
%r95 = zext i64 %r93 to i256
%r96 = shl i256 %r95, 192
%r97 = or i256 %r94, %r96
%r98 = zext i192 %r59 to i256
%r99 = shl i256 %r98, 32
%r100 = add i256 %r99, %r97
%r101 = load i32, i32* %r2
%r103 = getelementptr i32, i32* %r2, i32 4
%r104 = load i32, i32* %r103
%r105 = call i64 @mul32x32L(i32 %r101, i32 %r104)
%r107 = getelementptr i32, i32* %r2, i32 1
%r108 = load i32, i32* %r107
%r110 = getelementptr i32, i32* %r2, i32 5
%r111 = load i32, i32* %r110
%r112 = call i64 @mul32x32L(i32 %r108, i32 %r111)
%r113 = zext i64 %r105 to i128
%r114 = zext i64 %r112 to i128
%r115 = shl i128 %r114, 64
%r116 = or i128 %r113, %r115
%r118 = getelementptr i32, i32* %r2, i32 2
%r119 = load i32, i32* %r118
%r121 = getelementptr i32, i32* %r2, i32 6
%r122 = load i32, i32* %r121
%r123 = call i64 @mul32x32L(i32 %r119, i32 %r122)
%r124 = zext i128 %r116 to i192
%r125 = zext i64 %r123 to i192
%r126 = shl i192 %r125, 128
%r127 = or i192 %r124, %r126
%r129 = getelementptr i32, i32* %r2, i32 3
%r130 = load i32, i32* %r129
%r132 = getelementptr i32, i32* %r2, i32 7
%r133 = load i32, i32* %r132
%r134 = call i64 @mul32x32L(i32 %r130, i32 %r133)
%r135 = zext i192 %r127 to i256
%r136 = zext i64 %r134 to i256
%r137 = shl i256 %r136, 192
%r138 = or i256 %r135, %r137
%r140 = getelementptr i32, i32* %r2, i32 4
%r141 = load i32, i32* %r140
%r143 = getelementptr i32, i32* %r2, i32 8
%r144 = load i32, i32* %r143
%r145 = call i64 @mul32x32L(i32 %r141, i32 %r144)
%r146 = zext i256 %r138 to i320
%r147 = zext i64 %r145 to i320
%r148 = shl i320 %r147, 256
%r149 = or i320 %r146, %r148
%r150 = zext i256 %r100 to i320
%r151 = shl i320 %r150, 32
%r152 = add i320 %r151, %r149
%r153 = load i32, i32* %r2
%r155 = getelementptr i32, i32* %r2, i32 3
%r156 = load i32, i32* %r155
%r157 = call i64 @mul32x32L(i32 %r153, i32 %r156)
%r159 = getelementptr i32, i32* %r2, i32 1
%r160 = load i32, i32* %r159
%r162 = getelementptr i32, i32* %r2, i32 4
%r163 = load i32, i32* %r162
%r164 = call i64 @mul32x32L(i32 %r160, i32 %r163)
%r165 = zext i64 %r157 to i128
%r166 = zext i64 %r164 to i128
%r167 = shl i128 %r166, 64
%r168 = or i128 %r165, %r167
%r170 = getelementptr i32, i32* %r2, i32 2
%r171 = load i32, i32* %r170
%r173 = getelementptr i32, i32* %r2, i32 5
%r174 = load i32, i32* %r173
%r175 = call i64 @mul32x32L(i32 %r171, i32 %r174)
%r176 = zext i128 %r168 to i192
%r177 = zext i64 %r175 to i192
%r178 = shl i192 %r177, 128
%r179 = or i192 %r176, %r178
%r181 = getelementptr i32, i32* %r2, i32 3
%r182 = load i32, i32* %r181
%r184 = getelementptr i32, i32* %r2, i32 6
%r185 = load i32, i32* %r184
%r186 = call i64 @mul32x32L(i32 %r182, i32 %r185)
%r187 = zext i192 %r179 to i256
%r188 = zext i64 %r186 to i256
%r189 = shl i256 %r188, 192
%r190 = or i256 %r187, %r189
%r192 = getelementptr i32, i32* %r2, i32 4
%r193 = load i32, i32* %r192
%r195 = getelementptr i32, i32* %r2, i32 7
%r196 = load i32, i32* %r195
%r197 = call i64 @mul32x32L(i32 %r193, i32 %r196)
%r198 = zext i256 %r190 to i320
%r199 = zext i64 %r197 to i320
%r200 = shl i320 %r199, 256
%r201 = or i320 %r198, %r200
%r203 = getelementptr i32, i32* %r2, i32 5
%r204 = load i32, i32* %r203
%r206 = getelementptr i32, i32* %r2, i32 8
%r207 = load i32, i32* %r206
%r208 = call i64 @mul32x32L(i32 %r204, i32 %r207)
%r209 = zext i320 %r201 to i384
%r210 = zext i64 %r208 to i384
%r211 = shl i384 %r210, 320
%r212 = or i384 %r209, %r211
%r213 = zext i320 %r152 to i384
%r214 = shl i384 %r213, 32
%r215 = add i384 %r214, %r212
%r216 = load i32, i32* %r2
%r218 = getelementptr i32, i32* %r2, i32 2
%r219 = load i32, i32* %r218
%r220 = call i64 @mul32x32L(i32 %r216, i32 %r219)
%r222 = getelementptr i32, i32* %r2, i32 1
%r223 = load i32, i32* %r222
%r225 = getelementptr i32, i32* %r2, i32 3
%r226 = load i32, i32* %r225
%r227 = call i64 @mul32x32L(i32 %r223, i32 %r226)
%r228 = zext i64 %r220 to i128
%r229 = zext i64 %r227 to i128
%r230 = shl i128 %r229, 64
%r231 = or i128 %r228, %r230
%r233 = getelementptr i32, i32* %r2, i32 2
%r234 = load i32, i32* %r233
%r236 = getelementptr i32, i32* %r2, i32 4
%r237 = load i32, i32* %r236
%r238 = call i64 @mul32x32L(i32 %r234, i32 %r237)
%r239 = zext i128 %r231 to i192
%r240 = zext i64 %r238 to i192
%r241 = shl i192 %r240, 128
%r242 = or i192 %r239, %r241
%r244 = getelementptr i32, i32* %r2, i32 3
%r245 = load i32, i32* %r244
%r247 = getelementptr i32, i32* %r2, i32 5
%r248 = load i32, i32* %r247
%r249 = call i64 @mul32x32L(i32 %r245, i32 %r248)
%r250 = zext i192 %r242 to i256
%r251 = zext i64 %r249 to i256
%r252 = shl i256 %r251, 192
%r253 = or i256 %r250, %r252
%r255 = getelementptr i32, i32* %r2, i32 4
%r256 = load i32, i32* %r255
%r258 = getelementptr i32, i32* %r2, i32 6
%r259 = load i32, i32* %r258
%r260 = call i64 @mul32x32L(i32 %r256, i32 %r259)
%r261 = zext i256 %r253 to i320
%r262 = zext i64 %r260 to i320
%r263 = shl i320 %r262, 256
%r264 = or i320 %r261, %r263
%r266 = getelementptr i32, i32* %r2, i32 5
%r267 = load i32, i32* %r266
%r269 = getelementptr i32, i32* %r2, i32 7
%r270 = load i32, i32* %r269
%r271 = call i64 @mul32x32L(i32 %r267, i32 %r270)
%r272 = zext i320 %r264 to i384
%r273 = zext i64 %r271 to i384
%r274 = shl i384 %r273, 320
%r275 = or i384 %r272, %r274
%r277 = getelementptr i32, i32* %r2, i32 6
%r278 = load i32, i32* %r277
%r280 = getelementptr i32, i32* %r2, i32 8
%r281 = load i32, i32* %r280
%r282 = call i64 @mul32x32L(i32 %r278, i32 %r281)
%r283 = zext i384 %r275 to i448
%r284 = zext i64 %r282 to i448
%r285 = shl i448 %r284, 384
%r286 = or i448 %r283, %r285
%r287 = zext i384 %r215 to i448
%r288 = shl i448 %r287, 32
%r289 = add i448 %r288, %r286
%r290 = load i32, i32* %r2
%r292 = getelementptr i32, i32* %r2, i32 1
%r293 = load i32, i32* %r292
%r294 = call i64 @mul32x32L(i32 %r290, i32 %r293)
%r296 = getelementptr i32, i32* %r2, i32 1
%r297 = load i32, i32* %r296
%r299 = getelementptr i32, i32* %r2, i32 2
%r300 = load i32, i32* %r299
%r301 = call i64 @mul32x32L(i32 %r297, i32 %r300)
%r302 = zext i64 %r294 to i128
%r303 = zext i64 %r301 to i128
%r304 = shl i128 %r303, 64
%r305 = or i128 %r302, %r304
%r307 = getelementptr i32, i32* %r2, i32 2
%r308 = load i32, i32* %r307
%r310 = getelementptr i32, i32* %r2, i32 3
%r311 = load i32, i32* %r310
%r312 = call i64 @mul32x32L(i32 %r308, i32 %r311)
%r313 = zext i128 %r305 to i192
%r314 = zext i64 %r312 to i192
%r315 = shl i192 %r314, 128
%r316 = or i192 %r313, %r315
%r318 = getelementptr i32, i32* %r2, i32 3
%r319 = load i32, i32* %r318
%r321 = getelementptr i32, i32* %r2, i32 4
%r322 = load i32, i32* %r321
%r323 = call i64 @mul32x32L(i32 %r319, i32 %r322)
%r324 = zext i192 %r316 to i256
%r325 = zext i64 %r323 to i256
%r326 = shl i256 %r325, 192
%r327 = or i256 %r324, %r326
%r329 = getelementptr i32, i32* %r2, i32 4
%r330 = load i32, i32* %r329
%r332 = getelementptr i32, i32* %r2, i32 5
%r333 = load i32, i32* %r332
%r334 = call i64 @mul32x32L(i32 %r330, i32 %r333)
%r335 = zext i256 %r327 to i320
%r336 = zext i64 %r334 to i320
%r337 = shl i320 %r336, 256
%r338 = or i320 %r335, %r337
%r340 = getelementptr i32, i32* %r2, i32 5
%r341 = load i32, i32* %r340
%r343 = getelementptr i32, i32* %r2, i32 6
%r344 = load i32, i32* %r343
%r345 = call i64 @mul32x32L(i32 %r341, i32 %r344)
%r346 = zext i320 %r338 to i384
%r347 = zext i64 %r345 to i384
%r348 = shl i384 %r347, 320
%r349 = or i384 %r346, %r348
%r351 = getelementptr i32, i32* %r2, i32 6
%r352 = load i32, i32* %r351
%r354 = getelementptr i32, i32* %r2, i32 7
%r355 = load i32, i32* %r354
%r356 = call i64 @mul32x32L(i32 %r352, i32 %r355)
%r357 = zext i384 %r349 to i448
%r358 = zext i64 %r356 to i448
%r359 = shl i448 %r358, 384
%r360 = or i448 %r357, %r359
%r362 = getelementptr i32, i32* %r2, i32 7
%r363 = load i32, i32* %r362
%r365 = getelementptr i32, i32* %r2, i32 8
%r366 = load i32, i32* %r365
%r367 = call i64 @mul32x32L(i32 %r363, i32 %r366)
%r368 = zext i448 %r360 to i512
%r369 = zext i64 %r367 to i512
%r370 = shl i512 %r369, 448
%r371 = or i512 %r368, %r370
%r372 = zext i448 %r289 to i512
%r373 = shl i512 %r372, 32
%r374 = add i512 %r373, %r371
%r375 = zext i64 %r6 to i544
%r377 = getelementptr i32, i32* %r2, i32 1
%r378 = load i32, i32* %r377
%r379 = call i64 @mul32x32L(i32 %r378, i32 %r378)
%r380 = zext i64 %r379 to i544
%r381 = shl i544 %r380, 32
%r382 = or i544 %r375, %r381
%r384 = getelementptr i32, i32* %r2, i32 2
%r385 = load i32, i32* %r384
%r386 = call i64 @mul32x32L(i32 %r385, i32 %r385)
%r387 = zext i64 %r386 to i544
%r388 = shl i544 %r387, 96
%r389 = or i544 %r382, %r388
%r391 = getelementptr i32, i32* %r2, i32 3
%r392 = load i32, i32* %r391
%r393 = call i64 @mul32x32L(i32 %r392, i32 %r392)
%r394 = zext i64 %r393 to i544
%r395 = shl i544 %r394, 160
%r396 = or i544 %r389, %r395
%r398 = getelementptr i32, i32* %r2, i32 4
%r399 = load i32, i32* %r398
%r400 = call i64 @mul32x32L(i32 %r399, i32 %r399)
%r401 = zext i64 %r400 to i544
%r402 = shl i544 %r401, 224
%r403 = or i544 %r396, %r402
%r405 = getelementptr i32, i32* %r2, i32 5
%r406 = load i32, i32* %r405
%r407 = call i64 @mul32x32L(i32 %r406, i32 %r406)
%r408 = zext i64 %r407 to i544
%r409 = shl i544 %r408, 288
%r410 = or i544 %r403, %r409
%r412 = getelementptr i32, i32* %r2, i32 6
%r413 = load i32, i32* %r412
%r414 = call i64 @mul32x32L(i32 %r413, i32 %r413)
%r415 = zext i64 %r414 to i544
%r416 = shl i544 %r415, 352
%r417 = or i544 %r410, %r416
%r419 = getelementptr i32, i32* %r2, i32 7
%r420 = load i32, i32* %r419
%r421 = call i64 @mul32x32L(i32 %r420, i32 %r420)
%r422 = zext i64 %r421 to i544
%r423 = shl i544 %r422, 416
%r424 = or i544 %r417, %r423
%r426 = getelementptr i32, i32* %r2, i32 8
%r427 = load i32, i32* %r426
%r428 = call i64 @mul32x32L(i32 %r427, i32 %r427)
%r429 = zext i64 %r428 to i544
%r430 = shl i544 %r429, 480
%r431 = or i544 %r424, %r430
%r432 = zext i512 %r374 to i544
%r433 = add i544 %r432, %r432
%r434 = add i544 %r431, %r433
%r436 = getelementptr i32, i32* %r1, i32 1
%r438 = getelementptr i32, i32* %r436, i32 0
%r439 = trunc i544 %r434 to i32
store i32 %r439, i32* %r438
%r440 = lshr i544 %r434, 32
%r442 = getelementptr i32, i32* %r436, i32 1
%r443 = trunc i544 %r440 to i32
store i32 %r443, i32* %r442
%r444 = lshr i544 %r440, 32
%r446 = getelementptr i32, i32* %r436, i32 2
%r447 = trunc i544 %r444 to i32
store i32 %r447, i32* %r446
%r448 = lshr i544 %r444, 32
%r450 = getelementptr i32, i32* %r436, i32 3
%r451 = trunc i544 %r448 to i32
store i32 %r451, i32* %r450
%r452 = lshr i544 %r448, 32
%r454 = getelementptr i32, i32* %r436, i32 4
%r455 = trunc i544 %r452 to i32
store i32 %r455, i32* %r454
%r456 = lshr i544 %r452, 32
%r458 = getelementptr i32, i32* %r436, i32 5
%r459 = trunc i544 %r456 to i32
store i32 %r459, i32* %r458
%r460 = lshr i544 %r456, 32
%r462 = getelementptr i32, i32* %r436, i32 6
%r463 = trunc i544 %r460 to i32
store i32 %r463, i32* %r462
%r464 = lshr i544 %r460, 32
%r466 = getelementptr i32, i32* %r436, i32 7
%r467 = trunc i544 %r464 to i32
store i32 %r467, i32* %r466
%r468 = lshr i544 %r464, 32
%r470 = getelementptr i32, i32* %r436, i32 8
%r471 = trunc i544 %r468 to i32
store i32 %r471, i32* %r470
%r472 = lshr i544 %r468, 32
%r474 = getelementptr i32, i32* %r436, i32 9
%r475 = trunc i544 %r472 to i32
store i32 %r475, i32* %r474
%r476 = lshr i544 %r472, 32
%r478 = getelementptr i32, i32* %r436, i32 10
%r479 = trunc i544 %r476 to i32
store i32 %r479, i32* %r478
%r480 = lshr i544 %r476, 32
%r482 = getelementptr i32, i32* %r436, i32 11
%r483 = trunc i544 %r480 to i32
store i32 %r483, i32* %r482
%r484 = lshr i544 %r480, 32
%r486 = getelementptr i32, i32* %r436, i32 12
%r487 = trunc i544 %r484 to i32
store i32 %r487, i32* %r486
%r488 = lshr i544 %r484, 32
%r490 = getelementptr i32, i32* %r436, i32 13
%r491 = trunc i544 %r488 to i32
store i32 %r491, i32* %r490
%r492 = lshr i544 %r488, 32
%r494 = getelementptr i32, i32* %r436, i32 14
%r495 = trunc i544 %r492 to i32
store i32 %r495, i32* %r494
%r496 = lshr i544 %r492, 32
%r498 = getelementptr i32, i32* %r436, i32 15
%r499 = trunc i544 %r496 to i32
store i32 %r499, i32* %r498
%r500 = lshr i544 %r496, 32
%r502 = getelementptr i32, i32* %r436, i32 16
%r503 = trunc i544 %r500 to i32
store i32 %r503, i32* %r502
ret void
}
define i352 @mulUnit_inner320(i32* noalias  %r2, i32 %r3)
{
%r5 = call i64 @mulPos32x32(i32* %r2, i32 %r3, i32 0)
%r6 = trunc i64 %r5 to i32
%r7 = call i32 @extractHigh32(i64 %r5)
%r9 = call i64 @mulPos32x32(i32* %r2, i32 %r3, i32 1)
%r10 = trunc i64 %r9 to i32
%r11 = call i32 @extractHigh32(i64 %r9)
%r13 = call i64 @mulPos32x32(i32* %r2, i32 %r3, i32 2)
%r14 = trunc i64 %r13 to i32
%r15 = call i32 @extractHigh32(i64 %r13)
%r17 = call i64 @mulPos32x32(i32* %r2, i32 %r3, i32 3)
%r18 = trunc i64 %r17 to i32
%r19 = call i32 @extractHigh32(i64 %r17)
%r21 = call i64 @mulPos32x32(i32* %r2, i32 %r3, i32 4)
%r22 = trunc i64 %r21 to i32
%r23 = call i32 @extractHigh32(i64 %r21)
%r25 = call i64 @mulPos32x32(i32* %r2, i32 %r3, i32 5)
%r26 = trunc i64 %r25 to i32
%r27 = call i32 @extractHigh32(i64 %r25)
%r29 = call i64 @mulPos32x32(i32* %r2, i32 %r3, i32 6)
%r30 = trunc i64 %r29 to i32
%r31 = call i32 @extractHigh32(i64 %r29)
%r33 = call i64 @mulPos32x32(i32* %r2, i32 %r3, i32 7)
%r34 = trunc i64 %r33 to i32
%r35 = call i32 @extractHigh32(i64 %r33)
%r37 = call i64 @mulPos32x32(i32* %r2, i32 %r3, i32 8)
%r38 = trunc i64 %r37 to i32
%r39 = call i32 @extractHigh32(i64 %r37)
%r41 = call i64 @mulPos32x32(i32* %r2, i32 %r3, i32 9)
%r42 = trunc i64 %r41 to i32
%r43 = call i32 @extractHigh32(i64 %r41)
%r44 = zext i32 %r6 to i64
%r45 = zext i32 %r10 to i64
%r46 = shl i64 %r45, 32
%r47 = or i64 %r44, %r46
%r48 = zext i64 %r47 to i96
%r49 = zext i32 %r14 to i96
%r50 = shl i96 %r49, 64
%r51 = or i96 %r48, %r50
%r52 = zext i96 %r51 to i128
%r53 = zext i32 %r18 to i128
%r54 = shl i128 %r53, 96
%r55 = or i128 %r52, %r54
%r56 = zext i128 %r55 to i160
%r57 = zext i32 %r22 to i160
%r58 = shl i160 %r57, 128
%r59 = or i160 %r56, %r58
%r60 = zext i160 %r59 to i192
%r61 = zext i32 %r26 to i192
%r62 = shl i192 %r61, 160
%r63 = or i192 %r60, %r62
%r64 = zext i192 %r63 to i224
%r65 = zext i32 %r30 to i224
%r66 = shl i224 %r65, 192
%r67 = or i224 %r64, %r66
%r68 = zext i224 %r67 to i256
%r69 = zext i32 %r34 to i256
%r70 = shl i256 %r69, 224
%r71 = or i256 %r68, %r70
%r72 = zext i256 %r71 to i288
%r73 = zext i32 %r38 to i288
%r74 = shl i288 %r73, 256
%r75 = or i288 %r72, %r74
%r76 = zext i288 %r75 to i320
%r77 = zext i32 %r42 to i320
%r78 = shl i320 %r77, 288
%r79 = or i320 %r76, %r78
%r80 = zext i32 %r7 to i64
%r81 = zext i32 %r11 to i64
%r82 = shl i64 %r81, 32
%r83 = or i64 %r80, %r82
%r84 = zext i64 %r83 to i96
%r85 = zext i32 %r15 to i96
%r86 = shl i96 %r85, 64
%r87 = or i96 %r84, %r86
%r88 = zext i96 %r87 to i128
%r89 = zext i32 %r19 to i128
%r90 = shl i128 %r89, 96
%r91 = or i128 %r88, %r90
%r92 = zext i128 %r91 to i160
%r93 = zext i32 %r23 to i160
%r94 = shl i160 %r93, 128
%r95 = or i160 %r92, %r94
%r96 = zext i160 %r95 to i192
%r97 = zext i32 %r27 to i192
%r98 = shl i192 %r97, 160
%r99 = or i192 %r96, %r98
%r100 = zext i192 %r99 to i224
%r101 = zext i32 %r31 to i224
%r102 = shl i224 %r101, 192
%r103 = or i224 %r100, %r102
%r104 = zext i224 %r103 to i256
%r105 = zext i32 %r35 to i256
%r106 = shl i256 %r105, 224
%r107 = or i256 %r104, %r106
%r108 = zext i256 %r107 to i288
%r109 = zext i32 %r39 to i288
%r110 = shl i288 %r109, 256
%r111 = or i288 %r108, %r110
%r112 = zext i288 %r111 to i320
%r113 = zext i32 %r43 to i320
%r114 = shl i320 %r113, 288
%r115 = or i320 %r112, %r114
%r116 = zext i320 %r79 to i352
%r117 = zext i320 %r115 to i352
%r118 = shl i352 %r117, 32
%r119 = add i352 %r116, %r118
ret i352 %r119
}
define i32 @mclb_mulUnit10(i32* noalias  %r2, i32* noalias  %r3, i32 %r4)
{
%r5 = call i352 @mulUnit_inner320(i32* %r3, i32 %r4)
%r6 = trunc i352 %r5 to i320
%r8 = getelementptr i32, i32* %r2, i32 0
%r9 = trunc i320 %r6 to i32
store i32 %r9, i32* %r8
%r10 = lshr i320 %r6, 32
%r12 = getelementptr i32, i32* %r2, i32 1
%r13 = trunc i320 %r10 to i32
store i32 %r13, i32* %r12
%r14 = lshr i320 %r10, 32
%r16 = getelementptr i32, i32* %r2, i32 2
%r17 = trunc i320 %r14 to i32
store i32 %r17, i32* %r16
%r18 = lshr i320 %r14, 32
%r20 = getelementptr i32, i32* %r2, i32 3
%r21 = trunc i320 %r18 to i32
store i32 %r21, i32* %r20
%r22 = lshr i320 %r18, 32
%r24 = getelementptr i32, i32* %r2, i32 4
%r25 = trunc i320 %r22 to i32
store i32 %r25, i32* %r24
%r26 = lshr i320 %r22, 32
%r28 = getelementptr i32, i32* %r2, i32 5
%r29 = trunc i320 %r26 to i32
store i32 %r29, i32* %r28
%r30 = lshr i320 %r26, 32
%r32 = getelementptr i32, i32* %r2, i32 6
%r33 = trunc i320 %r30 to i32
store i32 %r33, i32* %r32
%r34 = lshr i320 %r30, 32
%r36 = getelementptr i32, i32* %r2, i32 7
%r37 = trunc i320 %r34 to i32
store i32 %r37, i32* %r36
%r38 = lshr i320 %r34, 32
%r40 = getelementptr i32, i32* %r2, i32 8
%r41 = trunc i320 %r38 to i32
store i32 %r41, i32* %r40
%r42 = lshr i320 %r38, 32
%r44 = getelementptr i32, i32* %r2, i32 9
%r45 = trunc i320 %r42 to i32
store i32 %r45, i32* %r44
%r46 = lshr i352 %r5, 320
%r47 = trunc i352 %r46 to i32
ret i32 %r47
}
define i32 @mclb_mulUnitAdd10(i32* noalias  %r2, i32* noalias  %r3, i32 %r4)
{
%r6 = call i64 @mulPos32x32(i32* %r3, i32 %r4, i32 0)
%r7 = trunc i64 %r6 to i32
%r8 = call i32 @extractHigh32(i64 %r6)
%r10 = call i64 @mulPos32x32(i32* %r3, i32 %r4, i32 1)
%r11 = trunc i64 %r10 to i32
%r12 = call i32 @extractHigh32(i64 %r10)
%r14 = call i64 @mulPos32x32(i32* %r3, i32 %r4, i32 2)
%r15 = trunc i64 %r14 to i32
%r16 = call i32 @extractHigh32(i64 %r14)
%r18 = call i64 @mulPos32x32(i32* %r3, i32 %r4, i32 3)
%r19 = trunc i64 %r18 to i32
%r20 = call i32 @extractHigh32(i64 %r18)
%r22 = call i64 @mulPos32x32(i32* %r3, i32 %r4, i32 4)
%r23 = trunc i64 %r22 to i32
%r24 = call i32 @extractHigh32(i64 %r22)
%r26 = call i64 @mulPos32x32(i32* %r3, i32 %r4, i32 5)
%r27 = trunc i64 %r26 to i32
%r28 = call i32 @extractHigh32(i64 %r26)
%r30 = call i64 @mulPos32x32(i32* %r3, i32 %r4, i32 6)
%r31 = trunc i64 %r30 to i32
%r32 = call i32 @extractHigh32(i64 %r30)
%r34 = call i64 @mulPos32x32(i32* %r3, i32 %r4, i32 7)
%r35 = trunc i64 %r34 to i32
%r36 = call i32 @extractHigh32(i64 %r34)
%r38 = call i64 @mulPos32x32(i32* %r3, i32 %r4, i32 8)
%r39 = trunc i64 %r38 to i32
%r40 = call i32 @extractHigh32(i64 %r38)
%r42 = call i64 @mulPos32x32(i32* %r3, i32 %r4, i32 9)
%r43 = trunc i64 %r42 to i32
%r44 = call i32 @extractHigh32(i64 %r42)
%r45 = zext i32 %r7 to i64
%r46 = zext i32 %r11 to i64
%r47 = shl i64 %r46, 32
%r48 = or i64 %r45, %r47
%r49 = zext i64 %r48 to i96
%r50 = zext i32 %r15 to i96
%r51 = shl i96 %r50, 64
%r52 = or i96 %r49, %r51
%r53 = zext i96 %r52 to i128
%r54 = zext i32 %r19 to i128
%r55 = shl i128 %r54, 96
%r56 = or i128 %r53, %r55
%r57 = zext i128 %r56 to i160
%r58 = zext i32 %r23 to i160
%r59 = shl i160 %r58, 128
%r60 = or i160 %r57, %r59
%r61 = zext i160 %r60 to i192
%r62 = zext i32 %r27 to i192
%r63 = shl i192 %r62, 160
%r64 = or i192 %r61, %r63
%r65 = zext i192 %r64 to i224
%r66 = zext i32 %r31 to i224
%r67 = shl i224 %r66, 192
%r68 = or i224 %r65, %r67
%r69 = zext i224 %r68 to i256
%r70 = zext i32 %r35 to i256
%r71 = shl i256 %r70, 224
%r72 = or i256 %r69, %r71
%r73 = zext i256 %r72 to i288
%r74 = zext i32 %r39 to i288
%r75 = shl i288 %r74, 256
%r76 = or i288 %r73, %r75
%r77 = zext i288 %r76 to i320
%r78 = zext i32 %r43 to i320
%r79 = shl i320 %r78, 288
%r80 = or i320 %r77, %r79
%r81 = zext i32 %r8 to i64
%r82 = zext i32 %r12 to i64
%r83 = shl i64 %r82, 32
%r84 = or i64 %r81, %r83
%r85 = zext i64 %r84 to i96
%r86 = zext i32 %r16 to i96
%r87 = shl i96 %r86, 64
%r88 = or i96 %r85, %r87
%r89 = zext i96 %r88 to i128
%r90 = zext i32 %r20 to i128
%r91 = shl i128 %r90, 96
%r92 = or i128 %r89, %r91
%r93 = zext i128 %r92 to i160
%r94 = zext i32 %r24 to i160
%r95 = shl i160 %r94, 128
%r96 = or i160 %r93, %r95
%r97 = zext i160 %r96 to i192
%r98 = zext i32 %r28 to i192
%r99 = shl i192 %r98, 160
%r100 = or i192 %r97, %r99
%r101 = zext i192 %r100 to i224
%r102 = zext i32 %r32 to i224
%r103 = shl i224 %r102, 192
%r104 = or i224 %r101, %r103
%r105 = zext i224 %r104 to i256
%r106 = zext i32 %r36 to i256
%r107 = shl i256 %r106, 224
%r108 = or i256 %r105, %r107
%r109 = zext i256 %r108 to i288
%r110 = zext i32 %r40 to i288
%r111 = shl i288 %r110, 256
%r112 = or i288 %r109, %r111
%r113 = zext i288 %r112 to i320
%r114 = zext i32 %r44 to i320
%r115 = shl i320 %r114, 288
%r116 = or i320 %r113, %r115
%r117 = zext i320 %r80 to i352
%r118 = zext i320 %r116 to i352
%r119 = shl i352 %r118, 32
%r120 = add i352 %r117, %r119
%r122 = bitcast i32* %r2 to i320*
%r123 = load i320, i320* %r122
%r124 = zext i320 %r123 to i352
%r125 = add i352 %r120, %r124
%r126 = trunc i352 %r125 to i320
%r128 = getelementptr i32, i32* %r2, i32 0
%r129 = trunc i320 %r126 to i32
store i32 %r129, i32* %r128
%r130 = lshr i320 %r126, 32
%r132 = getelementptr i32, i32* %r2, i32 1
%r133 = trunc i320 %r130 to i32
store i32 %r133, i32* %r132
%r134 = lshr i320 %r130, 32
%r136 = getelementptr i32, i32* %r2, i32 2
%r137 = trunc i320 %r134 to i32
store i32 %r137, i32* %r136
%r138 = lshr i320 %r134, 32
%r140 = getelementptr i32, i32* %r2, i32 3
%r141 = trunc i320 %r138 to i32
store i32 %r141, i32* %r140
%r142 = lshr i320 %r138, 32
%r144 = getelementptr i32, i32* %r2, i32 4
%r145 = trunc i320 %r142 to i32
store i32 %r145, i32* %r144
%r146 = lshr i320 %r142, 32
%r148 = getelementptr i32, i32* %r2, i32 5
%r149 = trunc i320 %r146 to i32
store i32 %r149, i32* %r148
%r150 = lshr i320 %r146, 32
%r152 = getelementptr i32, i32* %r2, i32 6
%r153 = trunc i320 %r150 to i32
store i32 %r153, i32* %r152
%r154 = lshr i320 %r150, 32
%r156 = getelementptr i32, i32* %r2, i32 7
%r157 = trunc i320 %r154 to i32
store i32 %r157, i32* %r156
%r158 = lshr i320 %r154, 32
%r160 = getelementptr i32, i32* %r2, i32 8
%r161 = trunc i320 %r158 to i32
store i32 %r161, i32* %r160
%r162 = lshr i320 %r158, 32
%r164 = getelementptr i32, i32* %r2, i32 9
%r165 = trunc i320 %r162 to i32
store i32 %r165, i32* %r164
%r166 = lshr i352 %r125, 320
%r167 = trunc i352 %r166 to i32
ret i32 %r167
}
define void @mclb_mul10(i32* noalias  %r1, i32* noalias  %r2, i32* noalias  %r3)
{
%r5 = getelementptr i32, i32* %r2, i32 5
%r7 = getelementptr i32, i32* %r3, i32 5
%r9 = getelementptr i32, i32* %r1, i32 10
call void @mclb_mul5(i32* %r1, i32* %r2, i32* %r3)
call void @mclb_mul5(i32* %r9, i32* %r5, i32* %r7)
%r11 = bitcast i32* %r5 to i160*
%r12 = load i160, i160* %r11
%r13 = zext i160 %r12 to i192
%r15 = bitcast i32* %r2 to i160*
%r16 = load i160, i160* %r15
%r17 = zext i160 %r16 to i192
%r19 = bitcast i32* %r7 to i160*
%r20 = load i160, i160* %r19
%r21 = zext i160 %r20 to i192
%r23 = bitcast i32* %r3 to i160*
%r24 = load i160, i160* %r23
%r25 = zext i160 %r24 to i192
%r26 = add i192 %r13, %r17
%r27 = add i192 %r21, %r25
%r29 = alloca i32, i32 10
%r30 = trunc i192 %r26 to i160
%r31 = trunc i192 %r27 to i160
%r32 = lshr i192 %r26, 160
%r33 = trunc i192 %r32 to i1
%r34 = lshr i192 %r27, 160
%r35 = trunc i192 %r34 to i1
%r36 = and i1 %r33, %r35
%r38 = select i1 %r33, i160 %r31, i160 0
%r40 = select i1 %r35, i160 %r30, i160 0
%r42 = alloca i32, i32 5
%r44 = alloca i32, i32 5
%r46 = getelementptr i32, i32* %r42, i32 0
%r47 = trunc i160 %r30 to i32
store i32 %r47, i32* %r46
%r48 = lshr i160 %r30, 32
%r50 = getelementptr i32, i32* %r42, i32 1
%r51 = trunc i160 %r48 to i32
store i32 %r51, i32* %r50
%r52 = lshr i160 %r48, 32
%r54 = getelementptr i32, i32* %r42, i32 2
%r55 = trunc i160 %r52 to i32
store i32 %r55, i32* %r54
%r56 = lshr i160 %r52, 32
%r58 = getelementptr i32, i32* %r42, i32 3
%r59 = trunc i160 %r56 to i32
store i32 %r59, i32* %r58
%r60 = lshr i160 %r56, 32
%r62 = getelementptr i32, i32* %r42, i32 4
%r63 = trunc i160 %r60 to i32
store i32 %r63, i32* %r62
%r65 = getelementptr i32, i32* %r44, i32 0
%r66 = trunc i160 %r31 to i32
store i32 %r66, i32* %r65
%r67 = lshr i160 %r31, 32
%r69 = getelementptr i32, i32* %r44, i32 1
%r70 = trunc i160 %r67 to i32
store i32 %r70, i32* %r69
%r71 = lshr i160 %r67, 32
%r73 = getelementptr i32, i32* %r44, i32 2
%r74 = trunc i160 %r71 to i32
store i32 %r74, i32* %r73
%r75 = lshr i160 %r71, 32
%r77 = getelementptr i32, i32* %r44, i32 3
%r78 = trunc i160 %r75 to i32
store i32 %r78, i32* %r77
%r79 = lshr i160 %r75, 32
%r81 = getelementptr i32, i32* %r44, i32 4
%r82 = trunc i160 %r79 to i32
store i32 %r82, i32* %r81
call void @mclb_mul5(i32* %r29, i32* %r42, i32* %r44)
%r84 = bitcast i32* %r29 to i320*
%r85 = load i320, i320* %r84
%r86 = zext i320 %r85 to i352
%r87 = zext i1 %r36 to i352
%r88 = shl i352 %r87, 320
%r89 = or i352 %r86, %r88
%r90 = zext i160 %r38 to i352
%r91 = zext i160 %r40 to i352
%r92 = shl i352 %r90, 160
%r93 = shl i352 %r91, 160
%r94 = add i352 %r89, %r92
%r95 = add i352 %r94, %r93
%r97 = bitcast i32* %r1 to i320*
%r98 = load i320, i320* %r97
%r99 = zext i320 %r98 to i352
%r100 = sub i352 %r95, %r99
%r102 = getelementptr i32, i32* %r1, i32 10
%r104 = bitcast i32* %r102 to i320*
%r105 = load i320, i320* %r104
%r106 = zext i320 %r105 to i352
%r107 = sub i352 %r100, %r106
%r108 = zext i352 %r107 to i480
%r110 = getelementptr i32, i32* %r1, i32 5
%r112 = bitcast i32* %r110 to i480*
%r113 = load i480, i480* %r112
%r114 = add i480 %r108, %r113
%r116 = getelementptr i32, i32* %r1, i32 5
%r118 = getelementptr i32, i32* %r116, i32 0
%r119 = trunc i480 %r114 to i32
store i32 %r119, i32* %r118
%r120 = lshr i480 %r114, 32
%r122 = getelementptr i32, i32* %r116, i32 1
%r123 = trunc i480 %r120 to i32
store i32 %r123, i32* %r122
%r124 = lshr i480 %r120, 32
%r126 = getelementptr i32, i32* %r116, i32 2
%r127 = trunc i480 %r124 to i32
store i32 %r127, i32* %r126
%r128 = lshr i480 %r124, 32
%r130 = getelementptr i32, i32* %r116, i32 3
%r131 = trunc i480 %r128 to i32
store i32 %r131, i32* %r130
%r132 = lshr i480 %r128, 32
%r134 = getelementptr i32, i32* %r116, i32 4
%r135 = trunc i480 %r132 to i32
store i32 %r135, i32* %r134
%r136 = lshr i480 %r132, 32
%r138 = getelementptr i32, i32* %r116, i32 5
%r139 = trunc i480 %r136 to i32
store i32 %r139, i32* %r138
%r140 = lshr i480 %r136, 32
%r142 = getelementptr i32, i32* %r116, i32 6
%r143 = trunc i480 %r140 to i32
store i32 %r143, i32* %r142
%r144 = lshr i480 %r140, 32
%r146 = getelementptr i32, i32* %r116, i32 7
%r147 = trunc i480 %r144 to i32
store i32 %r147, i32* %r146
%r148 = lshr i480 %r144, 32
%r150 = getelementptr i32, i32* %r116, i32 8
%r151 = trunc i480 %r148 to i32
store i32 %r151, i32* %r150
%r152 = lshr i480 %r148, 32
%r154 = getelementptr i32, i32* %r116, i32 9
%r155 = trunc i480 %r152 to i32
store i32 %r155, i32* %r154
%r156 = lshr i480 %r152, 32
%r158 = getelementptr i32, i32* %r116, i32 10
%r159 = trunc i480 %r156 to i32
store i32 %r159, i32* %r158
%r160 = lshr i480 %r156, 32
%r162 = getelementptr i32, i32* %r116, i32 11
%r163 = trunc i480 %r160 to i32
store i32 %r163, i32* %r162
%r164 = lshr i480 %r160, 32
%r166 = getelementptr i32, i32* %r116, i32 12
%r167 = trunc i480 %r164 to i32
store i32 %r167, i32* %r166
%r168 = lshr i480 %r164, 32
%r170 = getelementptr i32, i32* %r116, i32 13
%r171 = trunc i480 %r168 to i32
store i32 %r171, i32* %r170
%r172 = lshr i480 %r168, 32
%r174 = getelementptr i32, i32* %r116, i32 14
%r175 = trunc i480 %r172 to i32
store i32 %r175, i32* %r174
ret void
}
define void @mclb_sqr10(i32* noalias  %r1, i32* noalias  %r2)
{
%r4 = getelementptr i32, i32* %r2, i32 5
%r6 = getelementptr i32, i32* %r1, i32 10
%r8 = alloca i32, i32 10
call void @mclb_mul5(i32* %r8, i32* %r2, i32* %r4)
call void @mclb_sqr5(i32* %r1, i32* %r2)
call void @mclb_sqr5(i32* %r6, i32* %r4)
%r10 = bitcast i32* %r8 to i320*
%r11 = load i320, i320* %r10
%r12 = zext i320 %r11 to i352
%r13 = add i352 %r12, %r12
%r14 = zext i352 %r13 to i480
%r16 = getelementptr i32, i32* %r1, i32 5
%r18 = bitcast i32* %r16 to i480*
%r19 = load i480, i480* %r18
%r20 = add i480 %r19, %r14
%r22 = getelementptr i32, i32* %r16, i32 0
%r23 = trunc i480 %r20 to i32
store i32 %r23, i32* %r22
%r24 = lshr i480 %r20, 32
%r26 = getelementptr i32, i32* %r16, i32 1
%r27 = trunc i480 %r24 to i32
store i32 %r27, i32* %r26
%r28 = lshr i480 %r24, 32
%r30 = getelementptr i32, i32* %r16, i32 2
%r31 = trunc i480 %r28 to i32
store i32 %r31, i32* %r30
%r32 = lshr i480 %r28, 32
%r34 = getelementptr i32, i32* %r16, i32 3
%r35 = trunc i480 %r32 to i32
store i32 %r35, i32* %r34
%r36 = lshr i480 %r32, 32
%r38 = getelementptr i32, i32* %r16, i32 4
%r39 = trunc i480 %r36 to i32
store i32 %r39, i32* %r38
%r40 = lshr i480 %r36, 32
%r42 = getelementptr i32, i32* %r16, i32 5
%r43 = trunc i480 %r40 to i32
store i32 %r43, i32* %r42
%r44 = lshr i480 %r40, 32
%r46 = getelementptr i32, i32* %r16, i32 6
%r47 = trunc i480 %r44 to i32
store i32 %r47, i32* %r46
%r48 = lshr i480 %r44, 32
%r50 = getelementptr i32, i32* %r16, i32 7
%r51 = trunc i480 %r48 to i32
store i32 %r51, i32* %r50
%r52 = lshr i480 %r48, 32
%r54 = getelementptr i32, i32* %r16, i32 8
%r55 = trunc i480 %r52 to i32
store i32 %r55, i32* %r54
%r56 = lshr i480 %r52, 32
%r58 = getelementptr i32, i32* %r16, i32 9
%r59 = trunc i480 %r56 to i32
store i32 %r59, i32* %r58
%r60 = lshr i480 %r56, 32
%r62 = getelementptr i32, i32* %r16, i32 10
%r63 = trunc i480 %r60 to i32
store i32 %r63, i32* %r62
%r64 = lshr i480 %r60, 32
%r66 = getelementptr i32, i32* %r16, i32 11
%r67 = trunc i480 %r64 to i32
store i32 %r67, i32* %r66
%r68 = lshr i480 %r64, 32
%r70 = getelementptr i32, i32* %r16, i32 12
%r71 = trunc i480 %r68 to i32
store i32 %r71, i32* %r70
%r72 = lshr i480 %r68, 32
%r74 = getelementptr i32, i32* %r16, i32 13
%r75 = trunc i480 %r72 to i32
store i32 %r75, i32* %r74
%r76 = lshr i480 %r72, 32
%r78 = getelementptr i32, i32* %r16, i32 14
%r79 = trunc i480 %r76 to i32
store i32 %r79, i32* %r78
ret void
}
define i384 @mulUnit_inner352(i32* noalias  %r2, i32 %r3)
{
%r5 = call i64 @mulPos32x32(i32* %r2, i32 %r3, i32 0)
%r6 = trunc i64 %r5 to i32
%r7 = call i32 @extractHigh32(i64 %r5)
%r9 = call i64 @mulPos32x32(i32* %r2, i32 %r3, i32 1)
%r10 = trunc i64 %r9 to i32
%r11 = call i32 @extractHigh32(i64 %r9)
%r13 = call i64 @mulPos32x32(i32* %r2, i32 %r3, i32 2)
%r14 = trunc i64 %r13 to i32
%r15 = call i32 @extractHigh32(i64 %r13)
%r17 = call i64 @mulPos32x32(i32* %r2, i32 %r3, i32 3)
%r18 = trunc i64 %r17 to i32
%r19 = call i32 @extractHigh32(i64 %r17)
%r21 = call i64 @mulPos32x32(i32* %r2, i32 %r3, i32 4)
%r22 = trunc i64 %r21 to i32
%r23 = call i32 @extractHigh32(i64 %r21)
%r25 = call i64 @mulPos32x32(i32* %r2, i32 %r3, i32 5)
%r26 = trunc i64 %r25 to i32
%r27 = call i32 @extractHigh32(i64 %r25)
%r29 = call i64 @mulPos32x32(i32* %r2, i32 %r3, i32 6)
%r30 = trunc i64 %r29 to i32
%r31 = call i32 @extractHigh32(i64 %r29)
%r33 = call i64 @mulPos32x32(i32* %r2, i32 %r3, i32 7)
%r34 = trunc i64 %r33 to i32
%r35 = call i32 @extractHigh32(i64 %r33)
%r37 = call i64 @mulPos32x32(i32* %r2, i32 %r3, i32 8)
%r38 = trunc i64 %r37 to i32
%r39 = call i32 @extractHigh32(i64 %r37)
%r41 = call i64 @mulPos32x32(i32* %r2, i32 %r3, i32 9)
%r42 = trunc i64 %r41 to i32
%r43 = call i32 @extractHigh32(i64 %r41)
%r45 = call i64 @mulPos32x32(i32* %r2, i32 %r3, i32 10)
%r46 = trunc i64 %r45 to i32
%r47 = call i32 @extractHigh32(i64 %r45)
%r48 = zext i32 %r6 to i64
%r49 = zext i32 %r10 to i64
%r50 = shl i64 %r49, 32
%r51 = or i64 %r48, %r50
%r52 = zext i64 %r51 to i96
%r53 = zext i32 %r14 to i96
%r54 = shl i96 %r53, 64
%r55 = or i96 %r52, %r54
%r56 = zext i96 %r55 to i128
%r57 = zext i32 %r18 to i128
%r58 = shl i128 %r57, 96
%r59 = or i128 %r56, %r58
%r60 = zext i128 %r59 to i160
%r61 = zext i32 %r22 to i160
%r62 = shl i160 %r61, 128
%r63 = or i160 %r60, %r62
%r64 = zext i160 %r63 to i192
%r65 = zext i32 %r26 to i192
%r66 = shl i192 %r65, 160
%r67 = or i192 %r64, %r66
%r68 = zext i192 %r67 to i224
%r69 = zext i32 %r30 to i224
%r70 = shl i224 %r69, 192
%r71 = or i224 %r68, %r70
%r72 = zext i224 %r71 to i256
%r73 = zext i32 %r34 to i256
%r74 = shl i256 %r73, 224
%r75 = or i256 %r72, %r74
%r76 = zext i256 %r75 to i288
%r77 = zext i32 %r38 to i288
%r78 = shl i288 %r77, 256
%r79 = or i288 %r76, %r78
%r80 = zext i288 %r79 to i320
%r81 = zext i32 %r42 to i320
%r82 = shl i320 %r81, 288
%r83 = or i320 %r80, %r82
%r84 = zext i320 %r83 to i352
%r85 = zext i32 %r46 to i352
%r86 = shl i352 %r85, 320
%r87 = or i352 %r84, %r86
%r88 = zext i32 %r7 to i64
%r89 = zext i32 %r11 to i64
%r90 = shl i64 %r89, 32
%r91 = or i64 %r88, %r90
%r92 = zext i64 %r91 to i96
%r93 = zext i32 %r15 to i96
%r94 = shl i96 %r93, 64
%r95 = or i96 %r92, %r94
%r96 = zext i96 %r95 to i128
%r97 = zext i32 %r19 to i128
%r98 = shl i128 %r97, 96
%r99 = or i128 %r96, %r98
%r100 = zext i128 %r99 to i160
%r101 = zext i32 %r23 to i160
%r102 = shl i160 %r101, 128
%r103 = or i160 %r100, %r102
%r104 = zext i160 %r103 to i192
%r105 = zext i32 %r27 to i192
%r106 = shl i192 %r105, 160
%r107 = or i192 %r104, %r106
%r108 = zext i192 %r107 to i224
%r109 = zext i32 %r31 to i224
%r110 = shl i224 %r109, 192
%r111 = or i224 %r108, %r110
%r112 = zext i224 %r111 to i256
%r113 = zext i32 %r35 to i256
%r114 = shl i256 %r113, 224
%r115 = or i256 %r112, %r114
%r116 = zext i256 %r115 to i288
%r117 = zext i32 %r39 to i288
%r118 = shl i288 %r117, 256
%r119 = or i288 %r116, %r118
%r120 = zext i288 %r119 to i320
%r121 = zext i32 %r43 to i320
%r122 = shl i320 %r121, 288
%r123 = or i320 %r120, %r122
%r124 = zext i320 %r123 to i352
%r125 = zext i32 %r47 to i352
%r126 = shl i352 %r125, 320
%r127 = or i352 %r124, %r126
%r128 = zext i352 %r87 to i384
%r129 = zext i352 %r127 to i384
%r130 = shl i384 %r129, 32
%r131 = add i384 %r128, %r130
ret i384 %r131
}
define i32 @mclb_mulUnit11(i32* noalias  %r2, i32* noalias  %r3, i32 %r4)
{
%r5 = call i384 @mulUnit_inner352(i32* %r3, i32 %r4)
%r6 = trunc i384 %r5 to i352
%r8 = getelementptr i32, i32* %r2, i32 0
%r9 = trunc i352 %r6 to i32
store i32 %r9, i32* %r8
%r10 = lshr i352 %r6, 32
%r12 = getelementptr i32, i32* %r2, i32 1
%r13 = trunc i352 %r10 to i32
store i32 %r13, i32* %r12
%r14 = lshr i352 %r10, 32
%r16 = getelementptr i32, i32* %r2, i32 2
%r17 = trunc i352 %r14 to i32
store i32 %r17, i32* %r16
%r18 = lshr i352 %r14, 32
%r20 = getelementptr i32, i32* %r2, i32 3
%r21 = trunc i352 %r18 to i32
store i32 %r21, i32* %r20
%r22 = lshr i352 %r18, 32
%r24 = getelementptr i32, i32* %r2, i32 4
%r25 = trunc i352 %r22 to i32
store i32 %r25, i32* %r24
%r26 = lshr i352 %r22, 32
%r28 = getelementptr i32, i32* %r2, i32 5
%r29 = trunc i352 %r26 to i32
store i32 %r29, i32* %r28
%r30 = lshr i352 %r26, 32
%r32 = getelementptr i32, i32* %r2, i32 6
%r33 = trunc i352 %r30 to i32
store i32 %r33, i32* %r32
%r34 = lshr i352 %r30, 32
%r36 = getelementptr i32, i32* %r2, i32 7
%r37 = trunc i352 %r34 to i32
store i32 %r37, i32* %r36
%r38 = lshr i352 %r34, 32
%r40 = getelementptr i32, i32* %r2, i32 8
%r41 = trunc i352 %r38 to i32
store i32 %r41, i32* %r40
%r42 = lshr i352 %r38, 32
%r44 = getelementptr i32, i32* %r2, i32 9
%r45 = trunc i352 %r42 to i32
store i32 %r45, i32* %r44
%r46 = lshr i352 %r42, 32
%r48 = getelementptr i32, i32* %r2, i32 10
%r49 = trunc i352 %r46 to i32
store i32 %r49, i32* %r48
%r50 = lshr i384 %r5, 352
%r51 = trunc i384 %r50 to i32
ret i32 %r51
}
define i32 @mclb_mulUnitAdd11(i32* noalias  %r2, i32* noalias  %r3, i32 %r4)
{
%r6 = call i64 @mulPos32x32(i32* %r3, i32 %r4, i32 0)
%r7 = trunc i64 %r6 to i32
%r8 = call i32 @extractHigh32(i64 %r6)
%r10 = call i64 @mulPos32x32(i32* %r3, i32 %r4, i32 1)
%r11 = trunc i64 %r10 to i32
%r12 = call i32 @extractHigh32(i64 %r10)
%r14 = call i64 @mulPos32x32(i32* %r3, i32 %r4, i32 2)
%r15 = trunc i64 %r14 to i32
%r16 = call i32 @extractHigh32(i64 %r14)
%r18 = call i64 @mulPos32x32(i32* %r3, i32 %r4, i32 3)
%r19 = trunc i64 %r18 to i32
%r20 = call i32 @extractHigh32(i64 %r18)
%r22 = call i64 @mulPos32x32(i32* %r3, i32 %r4, i32 4)
%r23 = trunc i64 %r22 to i32
%r24 = call i32 @extractHigh32(i64 %r22)
%r26 = call i64 @mulPos32x32(i32* %r3, i32 %r4, i32 5)
%r27 = trunc i64 %r26 to i32
%r28 = call i32 @extractHigh32(i64 %r26)
%r30 = call i64 @mulPos32x32(i32* %r3, i32 %r4, i32 6)
%r31 = trunc i64 %r30 to i32
%r32 = call i32 @extractHigh32(i64 %r30)
%r34 = call i64 @mulPos32x32(i32* %r3, i32 %r4, i32 7)
%r35 = trunc i64 %r34 to i32
%r36 = call i32 @extractHigh32(i64 %r34)
%r38 = call i64 @mulPos32x32(i32* %r3, i32 %r4, i32 8)
%r39 = trunc i64 %r38 to i32
%r40 = call i32 @extractHigh32(i64 %r38)
%r42 = call i64 @mulPos32x32(i32* %r3, i32 %r4, i32 9)
%r43 = trunc i64 %r42 to i32
%r44 = call i32 @extractHigh32(i64 %r42)
%r46 = call i64 @mulPos32x32(i32* %r3, i32 %r4, i32 10)
%r47 = trunc i64 %r46 to i32
%r48 = call i32 @extractHigh32(i64 %r46)
%r49 = zext i32 %r7 to i64
%r50 = zext i32 %r11 to i64
%r51 = shl i64 %r50, 32
%r52 = or i64 %r49, %r51
%r53 = zext i64 %r52 to i96
%r54 = zext i32 %r15 to i96
%r55 = shl i96 %r54, 64
%r56 = or i96 %r53, %r55
%r57 = zext i96 %r56 to i128
%r58 = zext i32 %r19 to i128
%r59 = shl i128 %r58, 96
%r60 = or i128 %r57, %r59
%r61 = zext i128 %r60 to i160
%r62 = zext i32 %r23 to i160
%r63 = shl i160 %r62, 128
%r64 = or i160 %r61, %r63
%r65 = zext i160 %r64 to i192
%r66 = zext i32 %r27 to i192
%r67 = shl i192 %r66, 160
%r68 = or i192 %r65, %r67
%r69 = zext i192 %r68 to i224
%r70 = zext i32 %r31 to i224
%r71 = shl i224 %r70, 192
%r72 = or i224 %r69, %r71
%r73 = zext i224 %r72 to i256
%r74 = zext i32 %r35 to i256
%r75 = shl i256 %r74, 224
%r76 = or i256 %r73, %r75
%r77 = zext i256 %r76 to i288
%r78 = zext i32 %r39 to i288
%r79 = shl i288 %r78, 256
%r80 = or i288 %r77, %r79
%r81 = zext i288 %r80 to i320
%r82 = zext i32 %r43 to i320
%r83 = shl i320 %r82, 288
%r84 = or i320 %r81, %r83
%r85 = zext i320 %r84 to i352
%r86 = zext i32 %r47 to i352
%r87 = shl i352 %r86, 320
%r88 = or i352 %r85, %r87
%r89 = zext i32 %r8 to i64
%r90 = zext i32 %r12 to i64
%r91 = shl i64 %r90, 32
%r92 = or i64 %r89, %r91
%r93 = zext i64 %r92 to i96
%r94 = zext i32 %r16 to i96
%r95 = shl i96 %r94, 64
%r96 = or i96 %r93, %r95
%r97 = zext i96 %r96 to i128
%r98 = zext i32 %r20 to i128
%r99 = shl i128 %r98, 96
%r100 = or i128 %r97, %r99
%r101 = zext i128 %r100 to i160
%r102 = zext i32 %r24 to i160
%r103 = shl i160 %r102, 128
%r104 = or i160 %r101, %r103
%r105 = zext i160 %r104 to i192
%r106 = zext i32 %r28 to i192
%r107 = shl i192 %r106, 160
%r108 = or i192 %r105, %r107
%r109 = zext i192 %r108 to i224
%r110 = zext i32 %r32 to i224
%r111 = shl i224 %r110, 192
%r112 = or i224 %r109, %r111
%r113 = zext i224 %r112 to i256
%r114 = zext i32 %r36 to i256
%r115 = shl i256 %r114, 224
%r116 = or i256 %r113, %r115
%r117 = zext i256 %r116 to i288
%r118 = zext i32 %r40 to i288
%r119 = shl i288 %r118, 256
%r120 = or i288 %r117, %r119
%r121 = zext i288 %r120 to i320
%r122 = zext i32 %r44 to i320
%r123 = shl i320 %r122, 288
%r124 = or i320 %r121, %r123
%r125 = zext i320 %r124 to i352
%r126 = zext i32 %r48 to i352
%r127 = shl i352 %r126, 320
%r128 = or i352 %r125, %r127
%r129 = zext i352 %r88 to i384
%r130 = zext i352 %r128 to i384
%r131 = shl i384 %r130, 32
%r132 = add i384 %r129, %r131
%r134 = bitcast i32* %r2 to i352*
%r135 = load i352, i352* %r134
%r136 = zext i352 %r135 to i384
%r137 = add i384 %r132, %r136
%r138 = trunc i384 %r137 to i352
%r140 = getelementptr i32, i32* %r2, i32 0
%r141 = trunc i352 %r138 to i32
store i32 %r141, i32* %r140
%r142 = lshr i352 %r138, 32
%r144 = getelementptr i32, i32* %r2, i32 1
%r145 = trunc i352 %r142 to i32
store i32 %r145, i32* %r144
%r146 = lshr i352 %r142, 32
%r148 = getelementptr i32, i32* %r2, i32 2
%r149 = trunc i352 %r146 to i32
store i32 %r149, i32* %r148
%r150 = lshr i352 %r146, 32
%r152 = getelementptr i32, i32* %r2, i32 3
%r153 = trunc i352 %r150 to i32
store i32 %r153, i32* %r152
%r154 = lshr i352 %r150, 32
%r156 = getelementptr i32, i32* %r2, i32 4
%r157 = trunc i352 %r154 to i32
store i32 %r157, i32* %r156
%r158 = lshr i352 %r154, 32
%r160 = getelementptr i32, i32* %r2, i32 5
%r161 = trunc i352 %r158 to i32
store i32 %r161, i32* %r160
%r162 = lshr i352 %r158, 32
%r164 = getelementptr i32, i32* %r2, i32 6
%r165 = trunc i352 %r162 to i32
store i32 %r165, i32* %r164
%r166 = lshr i352 %r162, 32
%r168 = getelementptr i32, i32* %r2, i32 7
%r169 = trunc i352 %r166 to i32
store i32 %r169, i32* %r168
%r170 = lshr i352 %r166, 32
%r172 = getelementptr i32, i32* %r2, i32 8
%r173 = trunc i352 %r170 to i32
store i32 %r173, i32* %r172
%r174 = lshr i352 %r170, 32
%r176 = getelementptr i32, i32* %r2, i32 9
%r177 = trunc i352 %r174 to i32
store i32 %r177, i32* %r176
%r178 = lshr i352 %r174, 32
%r180 = getelementptr i32, i32* %r2, i32 10
%r181 = trunc i352 %r178 to i32
store i32 %r181, i32* %r180
%r182 = lshr i384 %r137, 352
%r183 = trunc i384 %r182 to i32
ret i32 %r183
}
define void @mclb_mul11(i32* noalias  %r1, i32* noalias  %r2, i32* noalias  %r3)
{
%r4 = load i32, i32* %r3
%r5 = call i384 @mulUnit_inner352(i32* %r2, i32 %r4)
%r6 = trunc i384 %r5 to i32
store i32 %r6, i32* %r1
%r7 = lshr i384 %r5, 32
%r9 = getelementptr i32, i32* %r3, i32 1
%r10 = load i32, i32* %r9
%r11 = call i384 @mulUnit_inner352(i32* %r2, i32 %r10)
%r12 = add i384 %r7, %r11
%r13 = trunc i384 %r12 to i32
%r15 = getelementptr i32, i32* %r1, i32 1
store i32 %r13, i32* %r15
%r16 = lshr i384 %r12, 32
%r18 = getelementptr i32, i32* %r3, i32 2
%r19 = load i32, i32* %r18
%r20 = call i384 @mulUnit_inner352(i32* %r2, i32 %r19)
%r21 = add i384 %r16, %r20
%r22 = trunc i384 %r21 to i32
%r24 = getelementptr i32, i32* %r1, i32 2
store i32 %r22, i32* %r24
%r25 = lshr i384 %r21, 32
%r27 = getelementptr i32, i32* %r3, i32 3
%r28 = load i32, i32* %r27
%r29 = call i384 @mulUnit_inner352(i32* %r2, i32 %r28)
%r30 = add i384 %r25, %r29
%r31 = trunc i384 %r30 to i32
%r33 = getelementptr i32, i32* %r1, i32 3
store i32 %r31, i32* %r33
%r34 = lshr i384 %r30, 32
%r36 = getelementptr i32, i32* %r3, i32 4
%r37 = load i32, i32* %r36
%r38 = call i384 @mulUnit_inner352(i32* %r2, i32 %r37)
%r39 = add i384 %r34, %r38
%r40 = trunc i384 %r39 to i32
%r42 = getelementptr i32, i32* %r1, i32 4
store i32 %r40, i32* %r42
%r43 = lshr i384 %r39, 32
%r45 = getelementptr i32, i32* %r3, i32 5
%r46 = load i32, i32* %r45
%r47 = call i384 @mulUnit_inner352(i32* %r2, i32 %r46)
%r48 = add i384 %r43, %r47
%r49 = trunc i384 %r48 to i32
%r51 = getelementptr i32, i32* %r1, i32 5
store i32 %r49, i32* %r51
%r52 = lshr i384 %r48, 32
%r54 = getelementptr i32, i32* %r3, i32 6
%r55 = load i32, i32* %r54
%r56 = call i384 @mulUnit_inner352(i32* %r2, i32 %r55)
%r57 = add i384 %r52, %r56
%r58 = trunc i384 %r57 to i32
%r60 = getelementptr i32, i32* %r1, i32 6
store i32 %r58, i32* %r60
%r61 = lshr i384 %r57, 32
%r63 = getelementptr i32, i32* %r3, i32 7
%r64 = load i32, i32* %r63
%r65 = call i384 @mulUnit_inner352(i32* %r2, i32 %r64)
%r66 = add i384 %r61, %r65
%r67 = trunc i384 %r66 to i32
%r69 = getelementptr i32, i32* %r1, i32 7
store i32 %r67, i32* %r69
%r70 = lshr i384 %r66, 32
%r72 = getelementptr i32, i32* %r3, i32 8
%r73 = load i32, i32* %r72
%r74 = call i384 @mulUnit_inner352(i32* %r2, i32 %r73)
%r75 = add i384 %r70, %r74
%r76 = trunc i384 %r75 to i32
%r78 = getelementptr i32, i32* %r1, i32 8
store i32 %r76, i32* %r78
%r79 = lshr i384 %r75, 32
%r81 = getelementptr i32, i32* %r3, i32 9
%r82 = load i32, i32* %r81
%r83 = call i384 @mulUnit_inner352(i32* %r2, i32 %r82)
%r84 = add i384 %r79, %r83
%r85 = trunc i384 %r84 to i32
%r87 = getelementptr i32, i32* %r1, i32 9
store i32 %r85, i32* %r87
%r88 = lshr i384 %r84, 32
%r90 = getelementptr i32, i32* %r3, i32 10
%r91 = load i32, i32* %r90
%r92 = call i384 @mulUnit_inner352(i32* %r2, i32 %r91)
%r93 = add i384 %r88, %r92
%r95 = getelementptr i32, i32* %r1, i32 10
%r97 = getelementptr i32, i32* %r95, i32 0
%r98 = trunc i384 %r93 to i32
store i32 %r98, i32* %r97
%r99 = lshr i384 %r93, 32
%r101 = getelementptr i32, i32* %r95, i32 1
%r102 = trunc i384 %r99 to i32
store i32 %r102, i32* %r101
%r103 = lshr i384 %r99, 32
%r105 = getelementptr i32, i32* %r95, i32 2
%r106 = trunc i384 %r103 to i32
store i32 %r106, i32* %r105
%r107 = lshr i384 %r103, 32
%r109 = getelementptr i32, i32* %r95, i32 3
%r110 = trunc i384 %r107 to i32
store i32 %r110, i32* %r109
%r111 = lshr i384 %r107, 32
%r113 = getelementptr i32, i32* %r95, i32 4
%r114 = trunc i384 %r111 to i32
store i32 %r114, i32* %r113
%r115 = lshr i384 %r111, 32
%r117 = getelementptr i32, i32* %r95, i32 5
%r118 = trunc i384 %r115 to i32
store i32 %r118, i32* %r117
%r119 = lshr i384 %r115, 32
%r121 = getelementptr i32, i32* %r95, i32 6
%r122 = trunc i384 %r119 to i32
store i32 %r122, i32* %r121
%r123 = lshr i384 %r119, 32
%r125 = getelementptr i32, i32* %r95, i32 7
%r126 = trunc i384 %r123 to i32
store i32 %r126, i32* %r125
%r127 = lshr i384 %r123, 32
%r129 = getelementptr i32, i32* %r95, i32 8
%r130 = trunc i384 %r127 to i32
store i32 %r130, i32* %r129
%r131 = lshr i384 %r127, 32
%r133 = getelementptr i32, i32* %r95, i32 9
%r134 = trunc i384 %r131 to i32
store i32 %r134, i32* %r133
%r135 = lshr i384 %r131, 32
%r137 = getelementptr i32, i32* %r95, i32 10
%r138 = trunc i384 %r135 to i32
store i32 %r138, i32* %r137
%r139 = lshr i384 %r135, 32
%r141 = getelementptr i32, i32* %r95, i32 11
%r142 = trunc i384 %r139 to i32
store i32 %r142, i32* %r141
ret void
}
define void @mclb_sqr11(i32* noalias  %r1, i32* noalias  %r2)
{
%r3 = load i32, i32* %r2
%r4 = call i64 @mul32x32L(i32 %r3, i32 %r3)
%r5 = trunc i64 %r4 to i32
store i32 %r5, i32* %r1
%r6 = lshr i64 %r4, 32
%r8 = getelementptr i32, i32* %r2, i32 10
%r9 = load i32, i32* %r8
%r10 = call i64 @mul32x32L(i32 %r3, i32 %r9)
%r11 = load i32, i32* %r2
%r13 = getelementptr i32, i32* %r2, i32 9
%r14 = load i32, i32* %r13
%r15 = call i64 @mul32x32L(i32 %r11, i32 %r14)
%r17 = getelementptr i32, i32* %r2, i32 1
%r18 = load i32, i32* %r17
%r20 = getelementptr i32, i32* %r2, i32 10
%r21 = load i32, i32* %r20
%r22 = call i64 @mul32x32L(i32 %r18, i32 %r21)
%r23 = zext i64 %r15 to i128
%r24 = zext i64 %r22 to i128
%r25 = shl i128 %r24, 64
%r26 = or i128 %r23, %r25
%r27 = zext i64 %r10 to i128
%r28 = shl i128 %r27, 32
%r29 = add i128 %r28, %r26
%r30 = load i32, i32* %r2
%r32 = getelementptr i32, i32* %r2, i32 8
%r33 = load i32, i32* %r32
%r34 = call i64 @mul32x32L(i32 %r30, i32 %r33)
%r36 = getelementptr i32, i32* %r2, i32 1
%r37 = load i32, i32* %r36
%r39 = getelementptr i32, i32* %r2, i32 9
%r40 = load i32, i32* %r39
%r41 = call i64 @mul32x32L(i32 %r37, i32 %r40)
%r42 = zext i64 %r34 to i128
%r43 = zext i64 %r41 to i128
%r44 = shl i128 %r43, 64
%r45 = or i128 %r42, %r44
%r47 = getelementptr i32, i32* %r2, i32 2
%r48 = load i32, i32* %r47
%r50 = getelementptr i32, i32* %r2, i32 10
%r51 = load i32, i32* %r50
%r52 = call i64 @mul32x32L(i32 %r48, i32 %r51)
%r53 = zext i128 %r45 to i192
%r54 = zext i64 %r52 to i192
%r55 = shl i192 %r54, 128
%r56 = or i192 %r53, %r55
%r57 = zext i128 %r29 to i192
%r58 = shl i192 %r57, 32
%r59 = add i192 %r58, %r56
%r60 = load i32, i32* %r2
%r62 = getelementptr i32, i32* %r2, i32 7
%r63 = load i32, i32* %r62
%r64 = call i64 @mul32x32L(i32 %r60, i32 %r63)
%r66 = getelementptr i32, i32* %r2, i32 1
%r67 = load i32, i32* %r66
%r69 = getelementptr i32, i32* %r2, i32 8
%r70 = load i32, i32* %r69
%r71 = call i64 @mul32x32L(i32 %r67, i32 %r70)
%r72 = zext i64 %r64 to i128
%r73 = zext i64 %r71 to i128
%r74 = shl i128 %r73, 64
%r75 = or i128 %r72, %r74
%r77 = getelementptr i32, i32* %r2, i32 2
%r78 = load i32, i32* %r77
%r80 = getelementptr i32, i32* %r2, i32 9
%r81 = load i32, i32* %r80
%r82 = call i64 @mul32x32L(i32 %r78, i32 %r81)
%r83 = zext i128 %r75 to i192
%r84 = zext i64 %r82 to i192
%r85 = shl i192 %r84, 128
%r86 = or i192 %r83, %r85
%r88 = getelementptr i32, i32* %r2, i32 3
%r89 = load i32, i32* %r88
%r91 = getelementptr i32, i32* %r2, i32 10
%r92 = load i32, i32* %r91
%r93 = call i64 @mul32x32L(i32 %r89, i32 %r92)
%r94 = zext i192 %r86 to i256
%r95 = zext i64 %r93 to i256
%r96 = shl i256 %r95, 192
%r97 = or i256 %r94, %r96
%r98 = zext i192 %r59 to i256
%r99 = shl i256 %r98, 32
%r100 = add i256 %r99, %r97
%r101 = load i32, i32* %r2
%r103 = getelementptr i32, i32* %r2, i32 6
%r104 = load i32, i32* %r103
%r105 = call i64 @mul32x32L(i32 %r101, i32 %r104)
%r107 = getelementptr i32, i32* %r2, i32 1
%r108 = load i32, i32* %r107
%r110 = getelementptr i32, i32* %r2, i32 7
%r111 = load i32, i32* %r110
%r112 = call i64 @mul32x32L(i32 %r108, i32 %r111)
%r113 = zext i64 %r105 to i128
%r114 = zext i64 %r112 to i128
%r115 = shl i128 %r114, 64
%r116 = or i128 %r113, %r115
%r118 = getelementptr i32, i32* %r2, i32 2
%r119 = load i32, i32* %r118
%r121 = getelementptr i32, i32* %r2, i32 8
%r122 = load i32, i32* %r121
%r123 = call i64 @mul32x32L(i32 %r119, i32 %r122)
%r124 = zext i128 %r116 to i192
%r125 = zext i64 %r123 to i192
%r126 = shl i192 %r125, 128
%r127 = or i192 %r124, %r126
%r129 = getelementptr i32, i32* %r2, i32 3
%r130 = load i32, i32* %r129
%r132 = getelementptr i32, i32* %r2, i32 9
%r133 = load i32, i32* %r132
%r134 = call i64 @mul32x32L(i32 %r130, i32 %r133)
%r135 = zext i192 %r127 to i256
%r136 = zext i64 %r134 to i256
%r137 = shl i256 %r136, 192
%r138 = or i256 %r135, %r137
%r140 = getelementptr i32, i32* %r2, i32 4
%r141 = load i32, i32* %r140
%r143 = getelementptr i32, i32* %r2, i32 10
%r144 = load i32, i32* %r143
%r145 = call i64 @mul32x32L(i32 %r141, i32 %r144)
%r146 = zext i256 %r138 to i320
%r147 = zext i64 %r145 to i320
%r148 = shl i320 %r147, 256
%r149 = or i320 %r146, %r148
%r150 = zext i256 %r100 to i320
%r151 = shl i320 %r150, 32
%r152 = add i320 %r151, %r149
%r153 = load i32, i32* %r2
%r155 = getelementptr i32, i32* %r2, i32 5
%r156 = load i32, i32* %r155
%r157 = call i64 @mul32x32L(i32 %r153, i32 %r156)
%r159 = getelementptr i32, i32* %r2, i32 1
%r160 = load i32, i32* %r159
%r162 = getelementptr i32, i32* %r2, i32 6
%r163 = load i32, i32* %r162
%r164 = call i64 @mul32x32L(i32 %r160, i32 %r163)
%r165 = zext i64 %r157 to i128
%r166 = zext i64 %r164 to i128
%r167 = shl i128 %r166, 64
%r168 = or i128 %r165, %r167
%r170 = getelementptr i32, i32* %r2, i32 2
%r171 = load i32, i32* %r170
%r173 = getelementptr i32, i32* %r2, i32 7
%r174 = load i32, i32* %r173
%r175 = call i64 @mul32x32L(i32 %r171, i32 %r174)
%r176 = zext i128 %r168 to i192
%r177 = zext i64 %r175 to i192
%r178 = shl i192 %r177, 128
%r179 = or i192 %r176, %r178
%r181 = getelementptr i32, i32* %r2, i32 3
%r182 = load i32, i32* %r181
%r184 = getelementptr i32, i32* %r2, i32 8
%r185 = load i32, i32* %r184
%r186 = call i64 @mul32x32L(i32 %r182, i32 %r185)
%r187 = zext i192 %r179 to i256
%r188 = zext i64 %r186 to i256
%r189 = shl i256 %r188, 192
%r190 = or i256 %r187, %r189
%r192 = getelementptr i32, i32* %r2, i32 4
%r193 = load i32, i32* %r192
%r195 = getelementptr i32, i32* %r2, i32 9
%r196 = load i32, i32* %r195
%r197 = call i64 @mul32x32L(i32 %r193, i32 %r196)
%r198 = zext i256 %r190 to i320
%r199 = zext i64 %r197 to i320
%r200 = shl i320 %r199, 256
%r201 = or i320 %r198, %r200
%r203 = getelementptr i32, i32* %r2, i32 5
%r204 = load i32, i32* %r203
%r206 = getelementptr i32, i32* %r2, i32 10
%r207 = load i32, i32* %r206
%r208 = call i64 @mul32x32L(i32 %r204, i32 %r207)
%r209 = zext i320 %r201 to i384
%r210 = zext i64 %r208 to i384
%r211 = shl i384 %r210, 320
%r212 = or i384 %r209, %r211
%r213 = zext i320 %r152 to i384
%r214 = shl i384 %r213, 32
%r215 = add i384 %r214, %r212
%r216 = load i32, i32* %r2
%r218 = getelementptr i32, i32* %r2, i32 4
%r219 = load i32, i32* %r218
%r220 = call i64 @mul32x32L(i32 %r216, i32 %r219)
%r222 = getelementptr i32, i32* %r2, i32 1
%r223 = load i32, i32* %r222
%r225 = getelementptr i32, i32* %r2, i32 5
%r226 = load i32, i32* %r225
%r227 = call i64 @mul32x32L(i32 %r223, i32 %r226)
%r228 = zext i64 %r220 to i128
%r229 = zext i64 %r227 to i128
%r230 = shl i128 %r229, 64
%r231 = or i128 %r228, %r230
%r233 = getelementptr i32, i32* %r2, i32 2
%r234 = load i32, i32* %r233
%r236 = getelementptr i32, i32* %r2, i32 6
%r237 = load i32, i32* %r236
%r238 = call i64 @mul32x32L(i32 %r234, i32 %r237)
%r239 = zext i128 %r231 to i192
%r240 = zext i64 %r238 to i192
%r241 = shl i192 %r240, 128
%r242 = or i192 %r239, %r241
%r244 = getelementptr i32, i32* %r2, i32 3
%r245 = load i32, i32* %r244
%r247 = getelementptr i32, i32* %r2, i32 7
%r248 = load i32, i32* %r247
%r249 = call i64 @mul32x32L(i32 %r245, i32 %r248)
%r250 = zext i192 %r242 to i256
%r251 = zext i64 %r249 to i256
%r252 = shl i256 %r251, 192
%r253 = or i256 %r250, %r252
%r255 = getelementptr i32, i32* %r2, i32 4
%r256 = load i32, i32* %r255
%r258 = getelementptr i32, i32* %r2, i32 8
%r259 = load i32, i32* %r258
%r260 = call i64 @mul32x32L(i32 %r256, i32 %r259)
%r261 = zext i256 %r253 to i320
%r262 = zext i64 %r260 to i320
%r263 = shl i320 %r262, 256
%r264 = or i320 %r261, %r263
%r266 = getelementptr i32, i32* %r2, i32 5
%r267 = load i32, i32* %r266
%r269 = getelementptr i32, i32* %r2, i32 9
%r270 = load i32, i32* %r269
%r271 = call i64 @mul32x32L(i32 %r267, i32 %r270)
%r272 = zext i320 %r264 to i384
%r273 = zext i64 %r271 to i384
%r274 = shl i384 %r273, 320
%r275 = or i384 %r272, %r274
%r277 = getelementptr i32, i32* %r2, i32 6
%r278 = load i32, i32* %r277
%r280 = getelementptr i32, i32* %r2, i32 10
%r281 = load i32, i32* %r280
%r282 = call i64 @mul32x32L(i32 %r278, i32 %r281)
%r283 = zext i384 %r275 to i448
%r284 = zext i64 %r282 to i448
%r285 = shl i448 %r284, 384
%r286 = or i448 %r283, %r285
%r287 = zext i384 %r215 to i448
%r288 = shl i448 %r287, 32
%r289 = add i448 %r288, %r286
%r290 = load i32, i32* %r2
%r292 = getelementptr i32, i32* %r2, i32 3
%r293 = load i32, i32* %r292
%r294 = call i64 @mul32x32L(i32 %r290, i32 %r293)
%r296 = getelementptr i32, i32* %r2, i32 1
%r297 = load i32, i32* %r296
%r299 = getelementptr i32, i32* %r2, i32 4
%r300 = load i32, i32* %r299
%r301 = call i64 @mul32x32L(i32 %r297, i32 %r300)
%r302 = zext i64 %r294 to i128
%r303 = zext i64 %r301 to i128
%r304 = shl i128 %r303, 64
%r305 = or i128 %r302, %r304
%r307 = getelementptr i32, i32* %r2, i32 2
%r308 = load i32, i32* %r307
%r310 = getelementptr i32, i32* %r2, i32 5
%r311 = load i32, i32* %r310
%r312 = call i64 @mul32x32L(i32 %r308, i32 %r311)
%r313 = zext i128 %r305 to i192
%r314 = zext i64 %r312 to i192
%r315 = shl i192 %r314, 128
%r316 = or i192 %r313, %r315
%r318 = getelementptr i32, i32* %r2, i32 3
%r319 = load i32, i32* %r318
%r321 = getelementptr i32, i32* %r2, i32 6
%r322 = load i32, i32* %r321
%r323 = call i64 @mul32x32L(i32 %r319, i32 %r322)
%r324 = zext i192 %r316 to i256
%r325 = zext i64 %r323 to i256
%r326 = shl i256 %r325, 192
%r327 = or i256 %r324, %r326
%r329 = getelementptr i32, i32* %r2, i32 4
%r330 = load i32, i32* %r329
%r332 = getelementptr i32, i32* %r2, i32 7
%r333 = load i32, i32* %r332
%r334 = call i64 @mul32x32L(i32 %r330, i32 %r333)
%r335 = zext i256 %r327 to i320
%r336 = zext i64 %r334 to i320
%r337 = shl i320 %r336, 256
%r338 = or i320 %r335, %r337
%r340 = getelementptr i32, i32* %r2, i32 5
%r341 = load i32, i32* %r340
%r343 = getelementptr i32, i32* %r2, i32 8
%r344 = load i32, i32* %r343
%r345 = call i64 @mul32x32L(i32 %r341, i32 %r344)
%r346 = zext i320 %r338 to i384
%r347 = zext i64 %r345 to i384
%r348 = shl i384 %r347, 320
%r349 = or i384 %r346, %r348
%r351 = getelementptr i32, i32* %r2, i32 6
%r352 = load i32, i32* %r351
%r354 = getelementptr i32, i32* %r2, i32 9
%r355 = load i32, i32* %r354
%r356 = call i64 @mul32x32L(i32 %r352, i32 %r355)
%r357 = zext i384 %r349 to i448
%r358 = zext i64 %r356 to i448
%r359 = shl i448 %r358, 384
%r360 = or i448 %r357, %r359
%r362 = getelementptr i32, i32* %r2, i32 7
%r363 = load i32, i32* %r362
%r365 = getelementptr i32, i32* %r2, i32 10
%r366 = load i32, i32* %r365
%r367 = call i64 @mul32x32L(i32 %r363, i32 %r366)
%r368 = zext i448 %r360 to i512
%r369 = zext i64 %r367 to i512
%r370 = shl i512 %r369, 448
%r371 = or i512 %r368, %r370
%r372 = zext i448 %r289 to i512
%r373 = shl i512 %r372, 32
%r374 = add i512 %r373, %r371
%r375 = load i32, i32* %r2
%r377 = getelementptr i32, i32* %r2, i32 2
%r378 = load i32, i32* %r377
%r379 = call i64 @mul32x32L(i32 %r375, i32 %r378)
%r381 = getelementptr i32, i32* %r2, i32 1
%r382 = load i32, i32* %r381
%r384 = getelementptr i32, i32* %r2, i32 3
%r385 = load i32, i32* %r384
%r386 = call i64 @mul32x32L(i32 %r382, i32 %r385)
%r387 = zext i64 %r379 to i128
%r388 = zext i64 %r386 to i128
%r389 = shl i128 %r388, 64
%r390 = or i128 %r387, %r389
%r392 = getelementptr i32, i32* %r2, i32 2
%r393 = load i32, i32* %r392
%r395 = getelementptr i32, i32* %r2, i32 4
%r396 = load i32, i32* %r395
%r397 = call i64 @mul32x32L(i32 %r393, i32 %r396)
%r398 = zext i128 %r390 to i192
%r399 = zext i64 %r397 to i192
%r400 = shl i192 %r399, 128
%r401 = or i192 %r398, %r400
%r403 = getelementptr i32, i32* %r2, i32 3
%r404 = load i32, i32* %r403
%r406 = getelementptr i32, i32* %r2, i32 5
%r407 = load i32, i32* %r406
%r408 = call i64 @mul32x32L(i32 %r404, i32 %r407)
%r409 = zext i192 %r401 to i256
%r410 = zext i64 %r408 to i256
%r411 = shl i256 %r410, 192
%r412 = or i256 %r409, %r411
%r414 = getelementptr i32, i32* %r2, i32 4
%r415 = load i32, i32* %r414
%r417 = getelementptr i32, i32* %r2, i32 6
%r418 = load i32, i32* %r417
%r419 = call i64 @mul32x32L(i32 %r415, i32 %r418)
%r420 = zext i256 %r412 to i320
%r421 = zext i64 %r419 to i320
%r422 = shl i320 %r421, 256
%r423 = or i320 %r420, %r422
%r425 = getelementptr i32, i32* %r2, i32 5
%r426 = load i32, i32* %r425
%r428 = getelementptr i32, i32* %r2, i32 7
%r429 = load i32, i32* %r428
%r430 = call i64 @mul32x32L(i32 %r426, i32 %r429)
%r431 = zext i320 %r423 to i384
%r432 = zext i64 %r430 to i384
%r433 = shl i384 %r432, 320
%r434 = or i384 %r431, %r433
%r436 = getelementptr i32, i32* %r2, i32 6
%r437 = load i32, i32* %r436
%r439 = getelementptr i32, i32* %r2, i32 8
%r440 = load i32, i32* %r439
%r441 = call i64 @mul32x32L(i32 %r437, i32 %r440)
%r442 = zext i384 %r434 to i448
%r443 = zext i64 %r441 to i448
%r444 = shl i448 %r443, 384
%r445 = or i448 %r442, %r444
%r447 = getelementptr i32, i32* %r2, i32 7
%r448 = load i32, i32* %r447
%r450 = getelementptr i32, i32* %r2, i32 9
%r451 = load i32, i32* %r450
%r452 = call i64 @mul32x32L(i32 %r448, i32 %r451)
%r453 = zext i448 %r445 to i512
%r454 = zext i64 %r452 to i512
%r455 = shl i512 %r454, 448
%r456 = or i512 %r453, %r455
%r458 = getelementptr i32, i32* %r2, i32 8
%r459 = load i32, i32* %r458
%r461 = getelementptr i32, i32* %r2, i32 10
%r462 = load i32, i32* %r461
%r463 = call i64 @mul32x32L(i32 %r459, i32 %r462)
%r464 = zext i512 %r456 to i576
%r465 = zext i64 %r463 to i576
%r466 = shl i576 %r465, 512
%r467 = or i576 %r464, %r466
%r468 = zext i512 %r374 to i576
%r469 = shl i576 %r468, 32
%r470 = add i576 %r469, %r467
%r471 = load i32, i32* %r2
%r473 = getelementptr i32, i32* %r2, i32 1
%r474 = load i32, i32* %r473
%r475 = call i64 @mul32x32L(i32 %r471, i32 %r474)
%r477 = getelementptr i32, i32* %r2, i32 1
%r478 = load i32, i32* %r477
%r480 = getelementptr i32, i32* %r2, i32 2
%r481 = load i32, i32* %r480
%r482 = call i64 @mul32x32L(i32 %r478, i32 %r481)
%r483 = zext i64 %r475 to i128
%r484 = zext i64 %r482 to i128
%r485 = shl i128 %r484, 64
%r486 = or i128 %r483, %r485
%r488 = getelementptr i32, i32* %r2, i32 2
%r489 = load i32, i32* %r488
%r491 = getelementptr i32, i32* %r2, i32 3
%r492 = load i32, i32* %r491
%r493 = call i64 @mul32x32L(i32 %r489, i32 %r492)
%r494 = zext i128 %r486 to i192
%r495 = zext i64 %r493 to i192
%r496 = shl i192 %r495, 128
%r497 = or i192 %r494, %r496
%r499 = getelementptr i32, i32* %r2, i32 3
%r500 = load i32, i32* %r499
%r502 = getelementptr i32, i32* %r2, i32 4
%r503 = load i32, i32* %r502
%r504 = call i64 @mul32x32L(i32 %r500, i32 %r503)
%r505 = zext i192 %r497 to i256
%r506 = zext i64 %r504 to i256
%r507 = shl i256 %r506, 192
%r508 = or i256 %r505, %r507
%r510 = getelementptr i32, i32* %r2, i32 4
%r511 = load i32, i32* %r510
%r513 = getelementptr i32, i32* %r2, i32 5
%r514 = load i32, i32* %r513
%r515 = call i64 @mul32x32L(i32 %r511, i32 %r514)
%r516 = zext i256 %r508 to i320
%r517 = zext i64 %r515 to i320
%r518 = shl i320 %r517, 256
%r519 = or i320 %r516, %r518
%r521 = getelementptr i32, i32* %r2, i32 5
%r522 = load i32, i32* %r521
%r524 = getelementptr i32, i32* %r2, i32 6
%r525 = load i32, i32* %r524
%r526 = call i64 @mul32x32L(i32 %r522, i32 %r525)
%r527 = zext i320 %r519 to i384
%r528 = zext i64 %r526 to i384
%r529 = shl i384 %r528, 320
%r530 = or i384 %r527, %r529
%r532 = getelementptr i32, i32* %r2, i32 6
%r533 = load i32, i32* %r532
%r535 = getelementptr i32, i32* %r2, i32 7
%r536 = load i32, i32* %r535
%r537 = call i64 @mul32x32L(i32 %r533, i32 %r536)
%r538 = zext i384 %r530 to i448
%r539 = zext i64 %r537 to i448
%r540 = shl i448 %r539, 384
%r541 = or i448 %r538, %r540
%r543 = getelementptr i32, i32* %r2, i32 7
%r544 = load i32, i32* %r543
%r546 = getelementptr i32, i32* %r2, i32 8
%r547 = load i32, i32* %r546
%r548 = call i64 @mul32x32L(i32 %r544, i32 %r547)
%r549 = zext i448 %r541 to i512
%r550 = zext i64 %r548 to i512
%r551 = shl i512 %r550, 448
%r552 = or i512 %r549, %r551
%r554 = getelementptr i32, i32* %r2, i32 8
%r555 = load i32, i32* %r554
%r557 = getelementptr i32, i32* %r2, i32 9
%r558 = load i32, i32* %r557
%r559 = call i64 @mul32x32L(i32 %r555, i32 %r558)
%r560 = zext i512 %r552 to i576
%r561 = zext i64 %r559 to i576
%r562 = shl i576 %r561, 512
%r563 = or i576 %r560, %r562
%r565 = getelementptr i32, i32* %r2, i32 9
%r566 = load i32, i32* %r565
%r568 = getelementptr i32, i32* %r2, i32 10
%r569 = load i32, i32* %r568
%r570 = call i64 @mul32x32L(i32 %r566, i32 %r569)
%r571 = zext i576 %r563 to i640
%r572 = zext i64 %r570 to i640
%r573 = shl i640 %r572, 576
%r574 = or i640 %r571, %r573
%r575 = zext i576 %r470 to i640
%r576 = shl i640 %r575, 32
%r577 = add i640 %r576, %r574
%r578 = zext i64 %r6 to i672
%r580 = getelementptr i32, i32* %r2, i32 1
%r581 = load i32, i32* %r580
%r582 = call i64 @mul32x32L(i32 %r581, i32 %r581)
%r583 = zext i64 %r582 to i672
%r584 = shl i672 %r583, 32
%r585 = or i672 %r578, %r584
%r587 = getelementptr i32, i32* %r2, i32 2
%r588 = load i32, i32* %r587
%r589 = call i64 @mul32x32L(i32 %r588, i32 %r588)
%r590 = zext i64 %r589 to i672
%r591 = shl i672 %r590, 96
%r592 = or i672 %r585, %r591
%r594 = getelementptr i32, i32* %r2, i32 3
%r595 = load i32, i32* %r594
%r596 = call i64 @mul32x32L(i32 %r595, i32 %r595)
%r597 = zext i64 %r596 to i672
%r598 = shl i672 %r597, 160
%r599 = or i672 %r592, %r598
%r601 = getelementptr i32, i32* %r2, i32 4
%r602 = load i32, i32* %r601
%r603 = call i64 @mul32x32L(i32 %r602, i32 %r602)
%r604 = zext i64 %r603 to i672
%r605 = shl i672 %r604, 224
%r606 = or i672 %r599, %r605
%r608 = getelementptr i32, i32* %r2, i32 5
%r609 = load i32, i32* %r608
%r610 = call i64 @mul32x32L(i32 %r609, i32 %r609)
%r611 = zext i64 %r610 to i672
%r612 = shl i672 %r611, 288
%r613 = or i672 %r606, %r612
%r615 = getelementptr i32, i32* %r2, i32 6
%r616 = load i32, i32* %r615
%r617 = call i64 @mul32x32L(i32 %r616, i32 %r616)
%r618 = zext i64 %r617 to i672
%r619 = shl i672 %r618, 352
%r620 = or i672 %r613, %r619
%r622 = getelementptr i32, i32* %r2, i32 7
%r623 = load i32, i32* %r622
%r624 = call i64 @mul32x32L(i32 %r623, i32 %r623)
%r625 = zext i64 %r624 to i672
%r626 = shl i672 %r625, 416
%r627 = or i672 %r620, %r626
%r629 = getelementptr i32, i32* %r2, i32 8
%r630 = load i32, i32* %r629
%r631 = call i64 @mul32x32L(i32 %r630, i32 %r630)
%r632 = zext i64 %r631 to i672
%r633 = shl i672 %r632, 480
%r634 = or i672 %r627, %r633
%r636 = getelementptr i32, i32* %r2, i32 9
%r637 = load i32, i32* %r636
%r638 = call i64 @mul32x32L(i32 %r637, i32 %r637)
%r639 = zext i64 %r638 to i672
%r640 = shl i672 %r639, 544
%r641 = or i672 %r634, %r640
%r643 = getelementptr i32, i32* %r2, i32 10
%r644 = load i32, i32* %r643
%r645 = call i64 @mul32x32L(i32 %r644, i32 %r644)
%r646 = zext i64 %r645 to i672
%r647 = shl i672 %r646, 608
%r648 = or i672 %r641, %r647
%r649 = zext i640 %r577 to i672
%r650 = add i672 %r649, %r649
%r651 = add i672 %r648, %r650
%r653 = getelementptr i32, i32* %r1, i32 1
%r655 = getelementptr i32, i32* %r653, i32 0
%r656 = trunc i672 %r651 to i32
store i32 %r656, i32* %r655
%r657 = lshr i672 %r651, 32
%r659 = getelementptr i32, i32* %r653, i32 1
%r660 = trunc i672 %r657 to i32
store i32 %r660, i32* %r659
%r661 = lshr i672 %r657, 32
%r663 = getelementptr i32, i32* %r653, i32 2
%r664 = trunc i672 %r661 to i32
store i32 %r664, i32* %r663
%r665 = lshr i672 %r661, 32
%r667 = getelementptr i32, i32* %r653, i32 3
%r668 = trunc i672 %r665 to i32
store i32 %r668, i32* %r667
%r669 = lshr i672 %r665, 32
%r671 = getelementptr i32, i32* %r653, i32 4
%r672 = trunc i672 %r669 to i32
store i32 %r672, i32* %r671
%r673 = lshr i672 %r669, 32
%r675 = getelementptr i32, i32* %r653, i32 5
%r676 = trunc i672 %r673 to i32
store i32 %r676, i32* %r675
%r677 = lshr i672 %r673, 32
%r679 = getelementptr i32, i32* %r653, i32 6
%r680 = trunc i672 %r677 to i32
store i32 %r680, i32* %r679
%r681 = lshr i672 %r677, 32
%r683 = getelementptr i32, i32* %r653, i32 7
%r684 = trunc i672 %r681 to i32
store i32 %r684, i32* %r683
%r685 = lshr i672 %r681, 32
%r687 = getelementptr i32, i32* %r653, i32 8
%r688 = trunc i672 %r685 to i32
store i32 %r688, i32* %r687
%r689 = lshr i672 %r685, 32
%r691 = getelementptr i32, i32* %r653, i32 9
%r692 = trunc i672 %r689 to i32
store i32 %r692, i32* %r691
%r693 = lshr i672 %r689, 32
%r695 = getelementptr i32, i32* %r653, i32 10
%r696 = trunc i672 %r693 to i32
store i32 %r696, i32* %r695
%r697 = lshr i672 %r693, 32
%r699 = getelementptr i32, i32* %r653, i32 11
%r700 = trunc i672 %r697 to i32
store i32 %r700, i32* %r699
%r701 = lshr i672 %r697, 32
%r703 = getelementptr i32, i32* %r653, i32 12
%r704 = trunc i672 %r701 to i32
store i32 %r704, i32* %r703
%r705 = lshr i672 %r701, 32
%r707 = getelementptr i32, i32* %r653, i32 13
%r708 = trunc i672 %r705 to i32
store i32 %r708, i32* %r707
%r709 = lshr i672 %r705, 32
%r711 = getelementptr i32, i32* %r653, i32 14
%r712 = trunc i672 %r709 to i32
store i32 %r712, i32* %r711
%r713 = lshr i672 %r709, 32
%r715 = getelementptr i32, i32* %r653, i32 15
%r716 = trunc i672 %r713 to i32
store i32 %r716, i32* %r715
%r717 = lshr i672 %r713, 32
%r719 = getelementptr i32, i32* %r653, i32 16
%r720 = trunc i672 %r717 to i32
store i32 %r720, i32* %r719
%r721 = lshr i672 %r717, 32
%r723 = getelementptr i32, i32* %r653, i32 17
%r724 = trunc i672 %r721 to i32
store i32 %r724, i32* %r723
%r725 = lshr i672 %r721, 32
%r727 = getelementptr i32, i32* %r653, i32 18
%r728 = trunc i672 %r725 to i32
store i32 %r728, i32* %r727
%r729 = lshr i672 %r725, 32
%r731 = getelementptr i32, i32* %r653, i32 19
%r732 = trunc i672 %r729 to i32
store i32 %r732, i32* %r731
%r733 = lshr i672 %r729, 32
%r735 = getelementptr i32, i32* %r653, i32 20
%r736 = trunc i672 %r733 to i32
store i32 %r736, i32* %r735
ret void
}
define i416 @mulUnit_inner384(i32* noalias  %r2, i32 %r3)
{
%r5 = call i64 @mulPos32x32(i32* %r2, i32 %r3, i32 0)
%r6 = trunc i64 %r5 to i32
%r7 = call i32 @extractHigh32(i64 %r5)
%r9 = call i64 @mulPos32x32(i32* %r2, i32 %r3, i32 1)
%r10 = trunc i64 %r9 to i32
%r11 = call i32 @extractHigh32(i64 %r9)
%r13 = call i64 @mulPos32x32(i32* %r2, i32 %r3, i32 2)
%r14 = trunc i64 %r13 to i32
%r15 = call i32 @extractHigh32(i64 %r13)
%r17 = call i64 @mulPos32x32(i32* %r2, i32 %r3, i32 3)
%r18 = trunc i64 %r17 to i32
%r19 = call i32 @extractHigh32(i64 %r17)
%r21 = call i64 @mulPos32x32(i32* %r2, i32 %r3, i32 4)
%r22 = trunc i64 %r21 to i32
%r23 = call i32 @extractHigh32(i64 %r21)
%r25 = call i64 @mulPos32x32(i32* %r2, i32 %r3, i32 5)
%r26 = trunc i64 %r25 to i32
%r27 = call i32 @extractHigh32(i64 %r25)
%r29 = call i64 @mulPos32x32(i32* %r2, i32 %r3, i32 6)
%r30 = trunc i64 %r29 to i32
%r31 = call i32 @extractHigh32(i64 %r29)
%r33 = call i64 @mulPos32x32(i32* %r2, i32 %r3, i32 7)
%r34 = trunc i64 %r33 to i32
%r35 = call i32 @extractHigh32(i64 %r33)
%r37 = call i64 @mulPos32x32(i32* %r2, i32 %r3, i32 8)
%r38 = trunc i64 %r37 to i32
%r39 = call i32 @extractHigh32(i64 %r37)
%r41 = call i64 @mulPos32x32(i32* %r2, i32 %r3, i32 9)
%r42 = trunc i64 %r41 to i32
%r43 = call i32 @extractHigh32(i64 %r41)
%r45 = call i64 @mulPos32x32(i32* %r2, i32 %r3, i32 10)
%r46 = trunc i64 %r45 to i32
%r47 = call i32 @extractHigh32(i64 %r45)
%r49 = call i64 @mulPos32x32(i32* %r2, i32 %r3, i32 11)
%r50 = trunc i64 %r49 to i32
%r51 = call i32 @extractHigh32(i64 %r49)
%r52 = zext i32 %r6 to i64
%r53 = zext i32 %r10 to i64
%r54 = shl i64 %r53, 32
%r55 = or i64 %r52, %r54
%r56 = zext i64 %r55 to i96
%r57 = zext i32 %r14 to i96
%r58 = shl i96 %r57, 64
%r59 = or i96 %r56, %r58
%r60 = zext i96 %r59 to i128
%r61 = zext i32 %r18 to i128
%r62 = shl i128 %r61, 96
%r63 = or i128 %r60, %r62
%r64 = zext i128 %r63 to i160
%r65 = zext i32 %r22 to i160
%r66 = shl i160 %r65, 128
%r67 = or i160 %r64, %r66
%r68 = zext i160 %r67 to i192
%r69 = zext i32 %r26 to i192
%r70 = shl i192 %r69, 160
%r71 = or i192 %r68, %r70
%r72 = zext i192 %r71 to i224
%r73 = zext i32 %r30 to i224
%r74 = shl i224 %r73, 192
%r75 = or i224 %r72, %r74
%r76 = zext i224 %r75 to i256
%r77 = zext i32 %r34 to i256
%r78 = shl i256 %r77, 224
%r79 = or i256 %r76, %r78
%r80 = zext i256 %r79 to i288
%r81 = zext i32 %r38 to i288
%r82 = shl i288 %r81, 256
%r83 = or i288 %r80, %r82
%r84 = zext i288 %r83 to i320
%r85 = zext i32 %r42 to i320
%r86 = shl i320 %r85, 288
%r87 = or i320 %r84, %r86
%r88 = zext i320 %r87 to i352
%r89 = zext i32 %r46 to i352
%r90 = shl i352 %r89, 320
%r91 = or i352 %r88, %r90
%r92 = zext i352 %r91 to i384
%r93 = zext i32 %r50 to i384
%r94 = shl i384 %r93, 352
%r95 = or i384 %r92, %r94
%r96 = zext i32 %r7 to i64
%r97 = zext i32 %r11 to i64
%r98 = shl i64 %r97, 32
%r99 = or i64 %r96, %r98
%r100 = zext i64 %r99 to i96
%r101 = zext i32 %r15 to i96
%r102 = shl i96 %r101, 64
%r103 = or i96 %r100, %r102
%r104 = zext i96 %r103 to i128
%r105 = zext i32 %r19 to i128
%r106 = shl i128 %r105, 96
%r107 = or i128 %r104, %r106
%r108 = zext i128 %r107 to i160
%r109 = zext i32 %r23 to i160
%r110 = shl i160 %r109, 128
%r111 = or i160 %r108, %r110
%r112 = zext i160 %r111 to i192
%r113 = zext i32 %r27 to i192
%r114 = shl i192 %r113, 160
%r115 = or i192 %r112, %r114
%r116 = zext i192 %r115 to i224
%r117 = zext i32 %r31 to i224
%r118 = shl i224 %r117, 192
%r119 = or i224 %r116, %r118
%r120 = zext i224 %r119 to i256
%r121 = zext i32 %r35 to i256
%r122 = shl i256 %r121, 224
%r123 = or i256 %r120, %r122
%r124 = zext i256 %r123 to i288
%r125 = zext i32 %r39 to i288
%r126 = shl i288 %r125, 256
%r127 = or i288 %r124, %r126
%r128 = zext i288 %r127 to i320
%r129 = zext i32 %r43 to i320
%r130 = shl i320 %r129, 288
%r131 = or i320 %r128, %r130
%r132 = zext i320 %r131 to i352
%r133 = zext i32 %r47 to i352
%r134 = shl i352 %r133, 320
%r135 = or i352 %r132, %r134
%r136 = zext i352 %r135 to i384
%r137 = zext i32 %r51 to i384
%r138 = shl i384 %r137, 352
%r139 = or i384 %r136, %r138
%r140 = zext i384 %r95 to i416
%r141 = zext i384 %r139 to i416
%r142 = shl i416 %r141, 32
%r143 = add i416 %r140, %r142
ret i416 %r143
}
define i32 @mclb_mulUnit12(i32* noalias  %r2, i32* noalias  %r3, i32 %r4)
{
%r5 = call i416 @mulUnit_inner384(i32* %r3, i32 %r4)
%r6 = trunc i416 %r5 to i384
%r8 = getelementptr i32, i32* %r2, i32 0
%r9 = trunc i384 %r6 to i32
store i32 %r9, i32* %r8
%r10 = lshr i384 %r6, 32
%r12 = getelementptr i32, i32* %r2, i32 1
%r13 = trunc i384 %r10 to i32
store i32 %r13, i32* %r12
%r14 = lshr i384 %r10, 32
%r16 = getelementptr i32, i32* %r2, i32 2
%r17 = trunc i384 %r14 to i32
store i32 %r17, i32* %r16
%r18 = lshr i384 %r14, 32
%r20 = getelementptr i32, i32* %r2, i32 3
%r21 = trunc i384 %r18 to i32
store i32 %r21, i32* %r20
%r22 = lshr i384 %r18, 32
%r24 = getelementptr i32, i32* %r2, i32 4
%r25 = trunc i384 %r22 to i32
store i32 %r25, i32* %r24
%r26 = lshr i384 %r22, 32
%r28 = getelementptr i32, i32* %r2, i32 5
%r29 = trunc i384 %r26 to i32
store i32 %r29, i32* %r28
%r30 = lshr i384 %r26, 32
%r32 = getelementptr i32, i32* %r2, i32 6
%r33 = trunc i384 %r30 to i32
store i32 %r33, i32* %r32
%r34 = lshr i384 %r30, 32
%r36 = getelementptr i32, i32* %r2, i32 7
%r37 = trunc i384 %r34 to i32
store i32 %r37, i32* %r36
%r38 = lshr i384 %r34, 32
%r40 = getelementptr i32, i32* %r2, i32 8
%r41 = trunc i384 %r38 to i32
store i32 %r41, i32* %r40
%r42 = lshr i384 %r38, 32
%r44 = getelementptr i32, i32* %r2, i32 9
%r45 = trunc i384 %r42 to i32
store i32 %r45, i32* %r44
%r46 = lshr i384 %r42, 32
%r48 = getelementptr i32, i32* %r2, i32 10
%r49 = trunc i384 %r46 to i32
store i32 %r49, i32* %r48
%r50 = lshr i384 %r46, 32
%r52 = getelementptr i32, i32* %r2, i32 11
%r53 = trunc i384 %r50 to i32
store i32 %r53, i32* %r52
%r54 = lshr i416 %r5, 384
%r55 = trunc i416 %r54 to i32
ret i32 %r55
}
define i32 @mclb_mulUnitAdd12(i32* noalias  %r2, i32* noalias  %r3, i32 %r4)
{
%r6 = call i64 @mulPos32x32(i32* %r3, i32 %r4, i32 0)
%r7 = trunc i64 %r6 to i32
%r8 = call i32 @extractHigh32(i64 %r6)
%r10 = call i64 @mulPos32x32(i32* %r3, i32 %r4, i32 1)
%r11 = trunc i64 %r10 to i32
%r12 = call i32 @extractHigh32(i64 %r10)
%r14 = call i64 @mulPos32x32(i32* %r3, i32 %r4, i32 2)
%r15 = trunc i64 %r14 to i32
%r16 = call i32 @extractHigh32(i64 %r14)
%r18 = call i64 @mulPos32x32(i32* %r3, i32 %r4, i32 3)
%r19 = trunc i64 %r18 to i32
%r20 = call i32 @extractHigh32(i64 %r18)
%r22 = call i64 @mulPos32x32(i32* %r3, i32 %r4, i32 4)
%r23 = trunc i64 %r22 to i32
%r24 = call i32 @extractHigh32(i64 %r22)
%r26 = call i64 @mulPos32x32(i32* %r3, i32 %r4, i32 5)
%r27 = trunc i64 %r26 to i32
%r28 = call i32 @extractHigh32(i64 %r26)
%r30 = call i64 @mulPos32x32(i32* %r3, i32 %r4, i32 6)
%r31 = trunc i64 %r30 to i32
%r32 = call i32 @extractHigh32(i64 %r30)
%r34 = call i64 @mulPos32x32(i32* %r3, i32 %r4, i32 7)
%r35 = trunc i64 %r34 to i32
%r36 = call i32 @extractHigh32(i64 %r34)
%r38 = call i64 @mulPos32x32(i32* %r3, i32 %r4, i32 8)
%r39 = trunc i64 %r38 to i32
%r40 = call i32 @extractHigh32(i64 %r38)
%r42 = call i64 @mulPos32x32(i32* %r3, i32 %r4, i32 9)
%r43 = trunc i64 %r42 to i32
%r44 = call i32 @extractHigh32(i64 %r42)
%r46 = call i64 @mulPos32x32(i32* %r3, i32 %r4, i32 10)
%r47 = trunc i64 %r46 to i32
%r48 = call i32 @extractHigh32(i64 %r46)
%r50 = call i64 @mulPos32x32(i32* %r3, i32 %r4, i32 11)
%r51 = trunc i64 %r50 to i32
%r52 = call i32 @extractHigh32(i64 %r50)
%r53 = zext i32 %r7 to i64
%r54 = zext i32 %r11 to i64
%r55 = shl i64 %r54, 32
%r56 = or i64 %r53, %r55
%r57 = zext i64 %r56 to i96
%r58 = zext i32 %r15 to i96
%r59 = shl i96 %r58, 64
%r60 = or i96 %r57, %r59
%r61 = zext i96 %r60 to i128
%r62 = zext i32 %r19 to i128
%r63 = shl i128 %r62, 96
%r64 = or i128 %r61, %r63
%r65 = zext i128 %r64 to i160
%r66 = zext i32 %r23 to i160
%r67 = shl i160 %r66, 128
%r68 = or i160 %r65, %r67
%r69 = zext i160 %r68 to i192
%r70 = zext i32 %r27 to i192
%r71 = shl i192 %r70, 160
%r72 = or i192 %r69, %r71
%r73 = zext i192 %r72 to i224
%r74 = zext i32 %r31 to i224
%r75 = shl i224 %r74, 192
%r76 = or i224 %r73, %r75
%r77 = zext i224 %r76 to i256
%r78 = zext i32 %r35 to i256
%r79 = shl i256 %r78, 224
%r80 = or i256 %r77, %r79
%r81 = zext i256 %r80 to i288
%r82 = zext i32 %r39 to i288
%r83 = shl i288 %r82, 256
%r84 = or i288 %r81, %r83
%r85 = zext i288 %r84 to i320
%r86 = zext i32 %r43 to i320
%r87 = shl i320 %r86, 288
%r88 = or i320 %r85, %r87
%r89 = zext i320 %r88 to i352
%r90 = zext i32 %r47 to i352
%r91 = shl i352 %r90, 320
%r92 = or i352 %r89, %r91
%r93 = zext i352 %r92 to i384
%r94 = zext i32 %r51 to i384
%r95 = shl i384 %r94, 352
%r96 = or i384 %r93, %r95
%r97 = zext i32 %r8 to i64
%r98 = zext i32 %r12 to i64
%r99 = shl i64 %r98, 32
%r100 = or i64 %r97, %r99
%r101 = zext i64 %r100 to i96
%r102 = zext i32 %r16 to i96
%r103 = shl i96 %r102, 64
%r104 = or i96 %r101, %r103
%r105 = zext i96 %r104 to i128
%r106 = zext i32 %r20 to i128
%r107 = shl i128 %r106, 96
%r108 = or i128 %r105, %r107
%r109 = zext i128 %r108 to i160
%r110 = zext i32 %r24 to i160
%r111 = shl i160 %r110, 128
%r112 = or i160 %r109, %r111
%r113 = zext i160 %r112 to i192
%r114 = zext i32 %r28 to i192
%r115 = shl i192 %r114, 160
%r116 = or i192 %r113, %r115
%r117 = zext i192 %r116 to i224
%r118 = zext i32 %r32 to i224
%r119 = shl i224 %r118, 192
%r120 = or i224 %r117, %r119
%r121 = zext i224 %r120 to i256
%r122 = zext i32 %r36 to i256
%r123 = shl i256 %r122, 224
%r124 = or i256 %r121, %r123
%r125 = zext i256 %r124 to i288
%r126 = zext i32 %r40 to i288
%r127 = shl i288 %r126, 256
%r128 = or i288 %r125, %r127
%r129 = zext i288 %r128 to i320
%r130 = zext i32 %r44 to i320
%r131 = shl i320 %r130, 288
%r132 = or i320 %r129, %r131
%r133 = zext i320 %r132 to i352
%r134 = zext i32 %r48 to i352
%r135 = shl i352 %r134, 320
%r136 = or i352 %r133, %r135
%r137 = zext i352 %r136 to i384
%r138 = zext i32 %r52 to i384
%r139 = shl i384 %r138, 352
%r140 = or i384 %r137, %r139
%r141 = zext i384 %r96 to i416
%r142 = zext i384 %r140 to i416
%r143 = shl i416 %r142, 32
%r144 = add i416 %r141, %r143
%r146 = bitcast i32* %r2 to i384*
%r147 = load i384, i384* %r146
%r148 = zext i384 %r147 to i416
%r149 = add i416 %r144, %r148
%r150 = trunc i416 %r149 to i384
%r152 = getelementptr i32, i32* %r2, i32 0
%r153 = trunc i384 %r150 to i32
store i32 %r153, i32* %r152
%r154 = lshr i384 %r150, 32
%r156 = getelementptr i32, i32* %r2, i32 1
%r157 = trunc i384 %r154 to i32
store i32 %r157, i32* %r156
%r158 = lshr i384 %r154, 32
%r160 = getelementptr i32, i32* %r2, i32 2
%r161 = trunc i384 %r158 to i32
store i32 %r161, i32* %r160
%r162 = lshr i384 %r158, 32
%r164 = getelementptr i32, i32* %r2, i32 3
%r165 = trunc i384 %r162 to i32
store i32 %r165, i32* %r164
%r166 = lshr i384 %r162, 32
%r168 = getelementptr i32, i32* %r2, i32 4
%r169 = trunc i384 %r166 to i32
store i32 %r169, i32* %r168
%r170 = lshr i384 %r166, 32
%r172 = getelementptr i32, i32* %r2, i32 5
%r173 = trunc i384 %r170 to i32
store i32 %r173, i32* %r172
%r174 = lshr i384 %r170, 32
%r176 = getelementptr i32, i32* %r2, i32 6
%r177 = trunc i384 %r174 to i32
store i32 %r177, i32* %r176
%r178 = lshr i384 %r174, 32
%r180 = getelementptr i32, i32* %r2, i32 7
%r181 = trunc i384 %r178 to i32
store i32 %r181, i32* %r180
%r182 = lshr i384 %r178, 32
%r184 = getelementptr i32, i32* %r2, i32 8
%r185 = trunc i384 %r182 to i32
store i32 %r185, i32* %r184
%r186 = lshr i384 %r182, 32
%r188 = getelementptr i32, i32* %r2, i32 9
%r189 = trunc i384 %r186 to i32
store i32 %r189, i32* %r188
%r190 = lshr i384 %r186, 32
%r192 = getelementptr i32, i32* %r2, i32 10
%r193 = trunc i384 %r190 to i32
store i32 %r193, i32* %r192
%r194 = lshr i384 %r190, 32
%r196 = getelementptr i32, i32* %r2, i32 11
%r197 = trunc i384 %r194 to i32
store i32 %r197, i32* %r196
%r198 = lshr i416 %r149, 384
%r199 = trunc i416 %r198 to i32
ret i32 %r199
}
define void @mclb_mul12(i32* noalias  %r1, i32* noalias  %r2, i32* noalias  %r3)
{
%r5 = getelementptr i32, i32* %r2, i32 6
%r7 = getelementptr i32, i32* %r3, i32 6
%r9 = getelementptr i32, i32* %r1, i32 12
call void @mclb_mul6(i32* %r1, i32* %r2, i32* %r3)
call void @mclb_mul6(i32* %r9, i32* %r5, i32* %r7)
%r11 = bitcast i32* %r5 to i192*
%r12 = load i192, i192* %r11
%r13 = zext i192 %r12 to i224
%r15 = bitcast i32* %r2 to i192*
%r16 = load i192, i192* %r15
%r17 = zext i192 %r16 to i224
%r19 = bitcast i32* %r7 to i192*
%r20 = load i192, i192* %r19
%r21 = zext i192 %r20 to i224
%r23 = bitcast i32* %r3 to i192*
%r24 = load i192, i192* %r23
%r25 = zext i192 %r24 to i224
%r26 = add i224 %r13, %r17
%r27 = add i224 %r21, %r25
%r29 = alloca i32, i32 12
%r30 = trunc i224 %r26 to i192
%r31 = trunc i224 %r27 to i192
%r32 = lshr i224 %r26, 192
%r33 = trunc i224 %r32 to i1
%r34 = lshr i224 %r27, 192
%r35 = trunc i224 %r34 to i1
%r36 = and i1 %r33, %r35
%r38 = select i1 %r33, i192 %r31, i192 0
%r40 = select i1 %r35, i192 %r30, i192 0
%r42 = alloca i32, i32 6
%r44 = alloca i32, i32 6
%r46 = getelementptr i32, i32* %r42, i32 0
%r47 = trunc i192 %r30 to i32
store i32 %r47, i32* %r46
%r48 = lshr i192 %r30, 32
%r50 = getelementptr i32, i32* %r42, i32 1
%r51 = trunc i192 %r48 to i32
store i32 %r51, i32* %r50
%r52 = lshr i192 %r48, 32
%r54 = getelementptr i32, i32* %r42, i32 2
%r55 = trunc i192 %r52 to i32
store i32 %r55, i32* %r54
%r56 = lshr i192 %r52, 32
%r58 = getelementptr i32, i32* %r42, i32 3
%r59 = trunc i192 %r56 to i32
store i32 %r59, i32* %r58
%r60 = lshr i192 %r56, 32
%r62 = getelementptr i32, i32* %r42, i32 4
%r63 = trunc i192 %r60 to i32
store i32 %r63, i32* %r62
%r64 = lshr i192 %r60, 32
%r66 = getelementptr i32, i32* %r42, i32 5
%r67 = trunc i192 %r64 to i32
store i32 %r67, i32* %r66
%r69 = getelementptr i32, i32* %r44, i32 0
%r70 = trunc i192 %r31 to i32
store i32 %r70, i32* %r69
%r71 = lshr i192 %r31, 32
%r73 = getelementptr i32, i32* %r44, i32 1
%r74 = trunc i192 %r71 to i32
store i32 %r74, i32* %r73
%r75 = lshr i192 %r71, 32
%r77 = getelementptr i32, i32* %r44, i32 2
%r78 = trunc i192 %r75 to i32
store i32 %r78, i32* %r77
%r79 = lshr i192 %r75, 32
%r81 = getelementptr i32, i32* %r44, i32 3
%r82 = trunc i192 %r79 to i32
store i32 %r82, i32* %r81
%r83 = lshr i192 %r79, 32
%r85 = getelementptr i32, i32* %r44, i32 4
%r86 = trunc i192 %r83 to i32
store i32 %r86, i32* %r85
%r87 = lshr i192 %r83, 32
%r89 = getelementptr i32, i32* %r44, i32 5
%r90 = trunc i192 %r87 to i32
store i32 %r90, i32* %r89
call void @mclb_mul6(i32* %r29, i32* %r42, i32* %r44)
%r92 = bitcast i32* %r29 to i384*
%r93 = load i384, i384* %r92
%r94 = zext i384 %r93 to i416
%r95 = zext i1 %r36 to i416
%r96 = shl i416 %r95, 384
%r97 = or i416 %r94, %r96
%r98 = zext i192 %r38 to i416
%r99 = zext i192 %r40 to i416
%r100 = shl i416 %r98, 192
%r101 = shl i416 %r99, 192
%r102 = add i416 %r97, %r100
%r103 = add i416 %r102, %r101
%r105 = bitcast i32* %r1 to i384*
%r106 = load i384, i384* %r105
%r107 = zext i384 %r106 to i416
%r108 = sub i416 %r103, %r107
%r110 = getelementptr i32, i32* %r1, i32 12
%r112 = bitcast i32* %r110 to i384*
%r113 = load i384, i384* %r112
%r114 = zext i384 %r113 to i416
%r115 = sub i416 %r108, %r114
%r116 = zext i416 %r115 to i576
%r118 = getelementptr i32, i32* %r1, i32 6
%r120 = bitcast i32* %r118 to i576*
%r121 = load i576, i576* %r120
%r122 = add i576 %r116, %r121
%r124 = getelementptr i32, i32* %r1, i32 6
%r126 = getelementptr i32, i32* %r124, i32 0
%r127 = trunc i576 %r122 to i32
store i32 %r127, i32* %r126
%r128 = lshr i576 %r122, 32
%r130 = getelementptr i32, i32* %r124, i32 1
%r131 = trunc i576 %r128 to i32
store i32 %r131, i32* %r130
%r132 = lshr i576 %r128, 32
%r134 = getelementptr i32, i32* %r124, i32 2
%r135 = trunc i576 %r132 to i32
store i32 %r135, i32* %r134
%r136 = lshr i576 %r132, 32
%r138 = getelementptr i32, i32* %r124, i32 3
%r139 = trunc i576 %r136 to i32
store i32 %r139, i32* %r138
%r140 = lshr i576 %r136, 32
%r142 = getelementptr i32, i32* %r124, i32 4
%r143 = trunc i576 %r140 to i32
store i32 %r143, i32* %r142
%r144 = lshr i576 %r140, 32
%r146 = getelementptr i32, i32* %r124, i32 5
%r147 = trunc i576 %r144 to i32
store i32 %r147, i32* %r146
%r148 = lshr i576 %r144, 32
%r150 = getelementptr i32, i32* %r124, i32 6
%r151 = trunc i576 %r148 to i32
store i32 %r151, i32* %r150
%r152 = lshr i576 %r148, 32
%r154 = getelementptr i32, i32* %r124, i32 7
%r155 = trunc i576 %r152 to i32
store i32 %r155, i32* %r154
%r156 = lshr i576 %r152, 32
%r158 = getelementptr i32, i32* %r124, i32 8
%r159 = trunc i576 %r156 to i32
store i32 %r159, i32* %r158
%r160 = lshr i576 %r156, 32
%r162 = getelementptr i32, i32* %r124, i32 9
%r163 = trunc i576 %r160 to i32
store i32 %r163, i32* %r162
%r164 = lshr i576 %r160, 32
%r166 = getelementptr i32, i32* %r124, i32 10
%r167 = trunc i576 %r164 to i32
store i32 %r167, i32* %r166
%r168 = lshr i576 %r164, 32
%r170 = getelementptr i32, i32* %r124, i32 11
%r171 = trunc i576 %r168 to i32
store i32 %r171, i32* %r170
%r172 = lshr i576 %r168, 32
%r174 = getelementptr i32, i32* %r124, i32 12
%r175 = trunc i576 %r172 to i32
store i32 %r175, i32* %r174
%r176 = lshr i576 %r172, 32
%r178 = getelementptr i32, i32* %r124, i32 13
%r179 = trunc i576 %r176 to i32
store i32 %r179, i32* %r178
%r180 = lshr i576 %r176, 32
%r182 = getelementptr i32, i32* %r124, i32 14
%r183 = trunc i576 %r180 to i32
store i32 %r183, i32* %r182
%r184 = lshr i576 %r180, 32
%r186 = getelementptr i32, i32* %r124, i32 15
%r187 = trunc i576 %r184 to i32
store i32 %r187, i32* %r186
%r188 = lshr i576 %r184, 32
%r190 = getelementptr i32, i32* %r124, i32 16
%r191 = trunc i576 %r188 to i32
store i32 %r191, i32* %r190
%r192 = lshr i576 %r188, 32
%r194 = getelementptr i32, i32* %r124, i32 17
%r195 = trunc i576 %r192 to i32
store i32 %r195, i32* %r194
ret void
}
define void @mclb_sqr12(i32* noalias  %r1, i32* noalias  %r2)
{
%r4 = getelementptr i32, i32* %r2, i32 6
%r6 = getelementptr i32, i32* %r1, i32 12
%r8 = alloca i32, i32 12
call void @mclb_mul6(i32* %r8, i32* %r2, i32* %r4)
call void @mclb_sqr6(i32* %r1, i32* %r2)
call void @mclb_sqr6(i32* %r6, i32* %r4)
%r10 = bitcast i32* %r8 to i384*
%r11 = load i384, i384* %r10
%r12 = zext i384 %r11 to i416
%r13 = add i416 %r12, %r12
%r14 = zext i416 %r13 to i576
%r16 = getelementptr i32, i32* %r1, i32 6
%r18 = bitcast i32* %r16 to i576*
%r19 = load i576, i576* %r18
%r20 = add i576 %r19, %r14
%r22 = getelementptr i32, i32* %r16, i32 0
%r23 = trunc i576 %r20 to i32
store i32 %r23, i32* %r22
%r24 = lshr i576 %r20, 32
%r26 = getelementptr i32, i32* %r16, i32 1
%r27 = trunc i576 %r24 to i32
store i32 %r27, i32* %r26
%r28 = lshr i576 %r24, 32
%r30 = getelementptr i32, i32* %r16, i32 2
%r31 = trunc i576 %r28 to i32
store i32 %r31, i32* %r30
%r32 = lshr i576 %r28, 32
%r34 = getelementptr i32, i32* %r16, i32 3
%r35 = trunc i576 %r32 to i32
store i32 %r35, i32* %r34
%r36 = lshr i576 %r32, 32
%r38 = getelementptr i32, i32* %r16, i32 4
%r39 = trunc i576 %r36 to i32
store i32 %r39, i32* %r38
%r40 = lshr i576 %r36, 32
%r42 = getelementptr i32, i32* %r16, i32 5
%r43 = trunc i576 %r40 to i32
store i32 %r43, i32* %r42
%r44 = lshr i576 %r40, 32
%r46 = getelementptr i32, i32* %r16, i32 6
%r47 = trunc i576 %r44 to i32
store i32 %r47, i32* %r46
%r48 = lshr i576 %r44, 32
%r50 = getelementptr i32, i32* %r16, i32 7
%r51 = trunc i576 %r48 to i32
store i32 %r51, i32* %r50
%r52 = lshr i576 %r48, 32
%r54 = getelementptr i32, i32* %r16, i32 8
%r55 = trunc i576 %r52 to i32
store i32 %r55, i32* %r54
%r56 = lshr i576 %r52, 32
%r58 = getelementptr i32, i32* %r16, i32 9
%r59 = trunc i576 %r56 to i32
store i32 %r59, i32* %r58
%r60 = lshr i576 %r56, 32
%r62 = getelementptr i32, i32* %r16, i32 10
%r63 = trunc i576 %r60 to i32
store i32 %r63, i32* %r62
%r64 = lshr i576 %r60, 32
%r66 = getelementptr i32, i32* %r16, i32 11
%r67 = trunc i576 %r64 to i32
store i32 %r67, i32* %r66
%r68 = lshr i576 %r64, 32
%r70 = getelementptr i32, i32* %r16, i32 12
%r71 = trunc i576 %r68 to i32
store i32 %r71, i32* %r70
%r72 = lshr i576 %r68, 32
%r74 = getelementptr i32, i32* %r16, i32 13
%r75 = trunc i576 %r72 to i32
store i32 %r75, i32* %r74
%r76 = lshr i576 %r72, 32
%r78 = getelementptr i32, i32* %r16, i32 14
%r79 = trunc i576 %r76 to i32
store i32 %r79, i32* %r78
%r80 = lshr i576 %r76, 32
%r82 = getelementptr i32, i32* %r16, i32 15
%r83 = trunc i576 %r80 to i32
store i32 %r83, i32* %r82
%r84 = lshr i576 %r80, 32
%r86 = getelementptr i32, i32* %r16, i32 16
%r87 = trunc i576 %r84 to i32
store i32 %r87, i32* %r86
%r88 = lshr i576 %r84, 32
%r90 = getelementptr i32, i32* %r16, i32 17
%r91 = trunc i576 %r88 to i32
store i32 %r91, i32* %r90
ret void
}
define i448 @mulUnit_inner416(i32* noalias  %r2, i32 %r3)
{
%r5 = call i64 @mulPos32x32(i32* %r2, i32 %r3, i32 0)
%r6 = trunc i64 %r5 to i32
%r7 = call i32 @extractHigh32(i64 %r5)
%r9 = call i64 @mulPos32x32(i32* %r2, i32 %r3, i32 1)
%r10 = trunc i64 %r9 to i32
%r11 = call i32 @extractHigh32(i64 %r9)
%r13 = call i64 @mulPos32x32(i32* %r2, i32 %r3, i32 2)
%r14 = trunc i64 %r13 to i32
%r15 = call i32 @extractHigh32(i64 %r13)
%r17 = call i64 @mulPos32x32(i32* %r2, i32 %r3, i32 3)
%r18 = trunc i64 %r17 to i32
%r19 = call i32 @extractHigh32(i64 %r17)
%r21 = call i64 @mulPos32x32(i32* %r2, i32 %r3, i32 4)
%r22 = trunc i64 %r21 to i32
%r23 = call i32 @extractHigh32(i64 %r21)
%r25 = call i64 @mulPos32x32(i32* %r2, i32 %r3, i32 5)
%r26 = trunc i64 %r25 to i32
%r27 = call i32 @extractHigh32(i64 %r25)
%r29 = call i64 @mulPos32x32(i32* %r2, i32 %r3, i32 6)
%r30 = trunc i64 %r29 to i32
%r31 = call i32 @extractHigh32(i64 %r29)
%r33 = call i64 @mulPos32x32(i32* %r2, i32 %r3, i32 7)
%r34 = trunc i64 %r33 to i32
%r35 = call i32 @extractHigh32(i64 %r33)
%r37 = call i64 @mulPos32x32(i32* %r2, i32 %r3, i32 8)
%r38 = trunc i64 %r37 to i32
%r39 = call i32 @extractHigh32(i64 %r37)
%r41 = call i64 @mulPos32x32(i32* %r2, i32 %r3, i32 9)
%r42 = trunc i64 %r41 to i32
%r43 = call i32 @extractHigh32(i64 %r41)
%r45 = call i64 @mulPos32x32(i32* %r2, i32 %r3, i32 10)
%r46 = trunc i64 %r45 to i32
%r47 = call i32 @extractHigh32(i64 %r45)
%r49 = call i64 @mulPos32x32(i32* %r2, i32 %r3, i32 11)
%r50 = trunc i64 %r49 to i32
%r51 = call i32 @extractHigh32(i64 %r49)
%r53 = call i64 @mulPos32x32(i32* %r2, i32 %r3, i32 12)
%r54 = trunc i64 %r53 to i32
%r55 = call i32 @extractHigh32(i64 %r53)
%r56 = zext i32 %r6 to i64
%r57 = zext i32 %r10 to i64
%r58 = shl i64 %r57, 32
%r59 = or i64 %r56, %r58
%r60 = zext i64 %r59 to i96
%r61 = zext i32 %r14 to i96
%r62 = shl i96 %r61, 64
%r63 = or i96 %r60, %r62
%r64 = zext i96 %r63 to i128
%r65 = zext i32 %r18 to i128
%r66 = shl i128 %r65, 96
%r67 = or i128 %r64, %r66
%r68 = zext i128 %r67 to i160
%r69 = zext i32 %r22 to i160
%r70 = shl i160 %r69, 128
%r71 = or i160 %r68, %r70
%r72 = zext i160 %r71 to i192
%r73 = zext i32 %r26 to i192
%r74 = shl i192 %r73, 160
%r75 = or i192 %r72, %r74
%r76 = zext i192 %r75 to i224
%r77 = zext i32 %r30 to i224
%r78 = shl i224 %r77, 192
%r79 = or i224 %r76, %r78
%r80 = zext i224 %r79 to i256
%r81 = zext i32 %r34 to i256
%r82 = shl i256 %r81, 224
%r83 = or i256 %r80, %r82
%r84 = zext i256 %r83 to i288
%r85 = zext i32 %r38 to i288
%r86 = shl i288 %r85, 256
%r87 = or i288 %r84, %r86
%r88 = zext i288 %r87 to i320
%r89 = zext i32 %r42 to i320
%r90 = shl i320 %r89, 288
%r91 = or i320 %r88, %r90
%r92 = zext i320 %r91 to i352
%r93 = zext i32 %r46 to i352
%r94 = shl i352 %r93, 320
%r95 = or i352 %r92, %r94
%r96 = zext i352 %r95 to i384
%r97 = zext i32 %r50 to i384
%r98 = shl i384 %r97, 352
%r99 = or i384 %r96, %r98
%r100 = zext i384 %r99 to i416
%r101 = zext i32 %r54 to i416
%r102 = shl i416 %r101, 384
%r103 = or i416 %r100, %r102
%r104 = zext i32 %r7 to i64
%r105 = zext i32 %r11 to i64
%r106 = shl i64 %r105, 32
%r107 = or i64 %r104, %r106
%r108 = zext i64 %r107 to i96
%r109 = zext i32 %r15 to i96
%r110 = shl i96 %r109, 64
%r111 = or i96 %r108, %r110
%r112 = zext i96 %r111 to i128
%r113 = zext i32 %r19 to i128
%r114 = shl i128 %r113, 96
%r115 = or i128 %r112, %r114
%r116 = zext i128 %r115 to i160
%r117 = zext i32 %r23 to i160
%r118 = shl i160 %r117, 128
%r119 = or i160 %r116, %r118
%r120 = zext i160 %r119 to i192
%r121 = zext i32 %r27 to i192
%r122 = shl i192 %r121, 160
%r123 = or i192 %r120, %r122
%r124 = zext i192 %r123 to i224
%r125 = zext i32 %r31 to i224
%r126 = shl i224 %r125, 192
%r127 = or i224 %r124, %r126
%r128 = zext i224 %r127 to i256
%r129 = zext i32 %r35 to i256
%r130 = shl i256 %r129, 224
%r131 = or i256 %r128, %r130
%r132 = zext i256 %r131 to i288
%r133 = zext i32 %r39 to i288
%r134 = shl i288 %r133, 256
%r135 = or i288 %r132, %r134
%r136 = zext i288 %r135 to i320
%r137 = zext i32 %r43 to i320
%r138 = shl i320 %r137, 288
%r139 = or i320 %r136, %r138
%r140 = zext i320 %r139 to i352
%r141 = zext i32 %r47 to i352
%r142 = shl i352 %r141, 320
%r143 = or i352 %r140, %r142
%r144 = zext i352 %r143 to i384
%r145 = zext i32 %r51 to i384
%r146 = shl i384 %r145, 352
%r147 = or i384 %r144, %r146
%r148 = zext i384 %r147 to i416
%r149 = zext i32 %r55 to i416
%r150 = shl i416 %r149, 384
%r151 = or i416 %r148, %r150
%r152 = zext i416 %r103 to i448
%r153 = zext i416 %r151 to i448
%r154 = shl i448 %r153, 32
%r155 = add i448 %r152, %r154
ret i448 %r155
}
define i32 @mclb_mulUnit13(i32* noalias  %r2, i32* noalias  %r3, i32 %r4)
{
%r5 = call i448 @mulUnit_inner416(i32* %r3, i32 %r4)
%r6 = trunc i448 %r5 to i416
%r8 = getelementptr i32, i32* %r2, i32 0
%r9 = trunc i416 %r6 to i32
store i32 %r9, i32* %r8
%r10 = lshr i416 %r6, 32
%r12 = getelementptr i32, i32* %r2, i32 1
%r13 = trunc i416 %r10 to i32
store i32 %r13, i32* %r12
%r14 = lshr i416 %r10, 32
%r16 = getelementptr i32, i32* %r2, i32 2
%r17 = trunc i416 %r14 to i32
store i32 %r17, i32* %r16
%r18 = lshr i416 %r14, 32
%r20 = getelementptr i32, i32* %r2, i32 3
%r21 = trunc i416 %r18 to i32
store i32 %r21, i32* %r20
%r22 = lshr i416 %r18, 32
%r24 = getelementptr i32, i32* %r2, i32 4
%r25 = trunc i416 %r22 to i32
store i32 %r25, i32* %r24
%r26 = lshr i416 %r22, 32
%r28 = getelementptr i32, i32* %r2, i32 5
%r29 = trunc i416 %r26 to i32
store i32 %r29, i32* %r28
%r30 = lshr i416 %r26, 32
%r32 = getelementptr i32, i32* %r2, i32 6
%r33 = trunc i416 %r30 to i32
store i32 %r33, i32* %r32
%r34 = lshr i416 %r30, 32
%r36 = getelementptr i32, i32* %r2, i32 7
%r37 = trunc i416 %r34 to i32
store i32 %r37, i32* %r36
%r38 = lshr i416 %r34, 32
%r40 = getelementptr i32, i32* %r2, i32 8
%r41 = trunc i416 %r38 to i32
store i32 %r41, i32* %r40
%r42 = lshr i416 %r38, 32
%r44 = getelementptr i32, i32* %r2, i32 9
%r45 = trunc i416 %r42 to i32
store i32 %r45, i32* %r44
%r46 = lshr i416 %r42, 32
%r48 = getelementptr i32, i32* %r2, i32 10
%r49 = trunc i416 %r46 to i32
store i32 %r49, i32* %r48
%r50 = lshr i416 %r46, 32
%r52 = getelementptr i32, i32* %r2, i32 11
%r53 = trunc i416 %r50 to i32
store i32 %r53, i32* %r52
%r54 = lshr i416 %r50, 32
%r56 = getelementptr i32, i32* %r2, i32 12
%r57 = trunc i416 %r54 to i32
store i32 %r57, i32* %r56
%r58 = lshr i448 %r5, 416
%r59 = trunc i448 %r58 to i32
ret i32 %r59
}
define i32 @mclb_mulUnitAdd13(i32* noalias  %r2, i32* noalias  %r3, i32 %r4)
{
%r6 = call i64 @mulPos32x32(i32* %r3, i32 %r4, i32 0)
%r7 = trunc i64 %r6 to i32
%r8 = call i32 @extractHigh32(i64 %r6)
%r10 = call i64 @mulPos32x32(i32* %r3, i32 %r4, i32 1)
%r11 = trunc i64 %r10 to i32
%r12 = call i32 @extractHigh32(i64 %r10)
%r14 = call i64 @mulPos32x32(i32* %r3, i32 %r4, i32 2)
%r15 = trunc i64 %r14 to i32
%r16 = call i32 @extractHigh32(i64 %r14)
%r18 = call i64 @mulPos32x32(i32* %r3, i32 %r4, i32 3)
%r19 = trunc i64 %r18 to i32
%r20 = call i32 @extractHigh32(i64 %r18)
%r22 = call i64 @mulPos32x32(i32* %r3, i32 %r4, i32 4)
%r23 = trunc i64 %r22 to i32
%r24 = call i32 @extractHigh32(i64 %r22)
%r26 = call i64 @mulPos32x32(i32* %r3, i32 %r4, i32 5)
%r27 = trunc i64 %r26 to i32
%r28 = call i32 @extractHigh32(i64 %r26)
%r30 = call i64 @mulPos32x32(i32* %r3, i32 %r4, i32 6)
%r31 = trunc i64 %r30 to i32
%r32 = call i32 @extractHigh32(i64 %r30)
%r34 = call i64 @mulPos32x32(i32* %r3, i32 %r4, i32 7)
%r35 = trunc i64 %r34 to i32
%r36 = call i32 @extractHigh32(i64 %r34)
%r38 = call i64 @mulPos32x32(i32* %r3, i32 %r4, i32 8)
%r39 = trunc i64 %r38 to i32
%r40 = call i32 @extractHigh32(i64 %r38)
%r42 = call i64 @mulPos32x32(i32* %r3, i32 %r4, i32 9)
%r43 = trunc i64 %r42 to i32
%r44 = call i32 @extractHigh32(i64 %r42)
%r46 = call i64 @mulPos32x32(i32* %r3, i32 %r4, i32 10)
%r47 = trunc i64 %r46 to i32
%r48 = call i32 @extractHigh32(i64 %r46)
%r50 = call i64 @mulPos32x32(i32* %r3, i32 %r4, i32 11)
%r51 = trunc i64 %r50 to i32
%r52 = call i32 @extractHigh32(i64 %r50)
%r54 = call i64 @mulPos32x32(i32* %r3, i32 %r4, i32 12)
%r55 = trunc i64 %r54 to i32
%r56 = call i32 @extractHigh32(i64 %r54)
%r57 = zext i32 %r7 to i64
%r58 = zext i32 %r11 to i64
%r59 = shl i64 %r58, 32
%r60 = or i64 %r57, %r59
%r61 = zext i64 %r60 to i96
%r62 = zext i32 %r15 to i96
%r63 = shl i96 %r62, 64
%r64 = or i96 %r61, %r63
%r65 = zext i96 %r64 to i128
%r66 = zext i32 %r19 to i128
%r67 = shl i128 %r66, 96
%r68 = or i128 %r65, %r67
%r69 = zext i128 %r68 to i160
%r70 = zext i32 %r23 to i160
%r71 = shl i160 %r70, 128
%r72 = or i160 %r69, %r71
%r73 = zext i160 %r72 to i192
%r74 = zext i32 %r27 to i192
%r75 = shl i192 %r74, 160
%r76 = or i192 %r73, %r75
%r77 = zext i192 %r76 to i224
%r78 = zext i32 %r31 to i224
%r79 = shl i224 %r78, 192
%r80 = or i224 %r77, %r79
%r81 = zext i224 %r80 to i256
%r82 = zext i32 %r35 to i256
%r83 = shl i256 %r82, 224
%r84 = or i256 %r81, %r83
%r85 = zext i256 %r84 to i288
%r86 = zext i32 %r39 to i288
%r87 = shl i288 %r86, 256
%r88 = or i288 %r85, %r87
%r89 = zext i288 %r88 to i320
%r90 = zext i32 %r43 to i320
%r91 = shl i320 %r90, 288
%r92 = or i320 %r89, %r91
%r93 = zext i320 %r92 to i352
%r94 = zext i32 %r47 to i352
%r95 = shl i352 %r94, 320
%r96 = or i352 %r93, %r95
%r97 = zext i352 %r96 to i384
%r98 = zext i32 %r51 to i384
%r99 = shl i384 %r98, 352
%r100 = or i384 %r97, %r99
%r101 = zext i384 %r100 to i416
%r102 = zext i32 %r55 to i416
%r103 = shl i416 %r102, 384
%r104 = or i416 %r101, %r103
%r105 = zext i32 %r8 to i64
%r106 = zext i32 %r12 to i64
%r107 = shl i64 %r106, 32
%r108 = or i64 %r105, %r107
%r109 = zext i64 %r108 to i96
%r110 = zext i32 %r16 to i96
%r111 = shl i96 %r110, 64
%r112 = or i96 %r109, %r111
%r113 = zext i96 %r112 to i128
%r114 = zext i32 %r20 to i128
%r115 = shl i128 %r114, 96
%r116 = or i128 %r113, %r115
%r117 = zext i128 %r116 to i160
%r118 = zext i32 %r24 to i160
%r119 = shl i160 %r118, 128
%r120 = or i160 %r117, %r119
%r121 = zext i160 %r120 to i192
%r122 = zext i32 %r28 to i192
%r123 = shl i192 %r122, 160
%r124 = or i192 %r121, %r123
%r125 = zext i192 %r124 to i224
%r126 = zext i32 %r32 to i224
%r127 = shl i224 %r126, 192
%r128 = or i224 %r125, %r127
%r129 = zext i224 %r128 to i256
%r130 = zext i32 %r36 to i256
%r131 = shl i256 %r130, 224
%r132 = or i256 %r129, %r131
%r133 = zext i256 %r132 to i288
%r134 = zext i32 %r40 to i288
%r135 = shl i288 %r134, 256
%r136 = or i288 %r133, %r135
%r137 = zext i288 %r136 to i320
%r138 = zext i32 %r44 to i320
%r139 = shl i320 %r138, 288
%r140 = or i320 %r137, %r139
%r141 = zext i320 %r140 to i352
%r142 = zext i32 %r48 to i352
%r143 = shl i352 %r142, 320
%r144 = or i352 %r141, %r143
%r145 = zext i352 %r144 to i384
%r146 = zext i32 %r52 to i384
%r147 = shl i384 %r146, 352
%r148 = or i384 %r145, %r147
%r149 = zext i384 %r148 to i416
%r150 = zext i32 %r56 to i416
%r151 = shl i416 %r150, 384
%r152 = or i416 %r149, %r151
%r153 = zext i416 %r104 to i448
%r154 = zext i416 %r152 to i448
%r155 = shl i448 %r154, 32
%r156 = add i448 %r153, %r155
%r158 = bitcast i32* %r2 to i416*
%r159 = load i416, i416* %r158
%r160 = zext i416 %r159 to i448
%r161 = add i448 %r156, %r160
%r162 = trunc i448 %r161 to i416
%r164 = getelementptr i32, i32* %r2, i32 0
%r165 = trunc i416 %r162 to i32
store i32 %r165, i32* %r164
%r166 = lshr i416 %r162, 32
%r168 = getelementptr i32, i32* %r2, i32 1
%r169 = trunc i416 %r166 to i32
store i32 %r169, i32* %r168
%r170 = lshr i416 %r166, 32
%r172 = getelementptr i32, i32* %r2, i32 2
%r173 = trunc i416 %r170 to i32
store i32 %r173, i32* %r172
%r174 = lshr i416 %r170, 32
%r176 = getelementptr i32, i32* %r2, i32 3
%r177 = trunc i416 %r174 to i32
store i32 %r177, i32* %r176
%r178 = lshr i416 %r174, 32
%r180 = getelementptr i32, i32* %r2, i32 4
%r181 = trunc i416 %r178 to i32
store i32 %r181, i32* %r180
%r182 = lshr i416 %r178, 32
%r184 = getelementptr i32, i32* %r2, i32 5
%r185 = trunc i416 %r182 to i32
store i32 %r185, i32* %r184
%r186 = lshr i416 %r182, 32
%r188 = getelementptr i32, i32* %r2, i32 6
%r189 = trunc i416 %r186 to i32
store i32 %r189, i32* %r188
%r190 = lshr i416 %r186, 32
%r192 = getelementptr i32, i32* %r2, i32 7
%r193 = trunc i416 %r190 to i32
store i32 %r193, i32* %r192
%r194 = lshr i416 %r190, 32
%r196 = getelementptr i32, i32* %r2, i32 8
%r197 = trunc i416 %r194 to i32
store i32 %r197, i32* %r196
%r198 = lshr i416 %r194, 32
%r200 = getelementptr i32, i32* %r2, i32 9
%r201 = trunc i416 %r198 to i32
store i32 %r201, i32* %r200
%r202 = lshr i416 %r198, 32
%r204 = getelementptr i32, i32* %r2, i32 10
%r205 = trunc i416 %r202 to i32
store i32 %r205, i32* %r204
%r206 = lshr i416 %r202, 32
%r208 = getelementptr i32, i32* %r2, i32 11
%r209 = trunc i416 %r206 to i32
store i32 %r209, i32* %r208
%r210 = lshr i416 %r206, 32
%r212 = getelementptr i32, i32* %r2, i32 12
%r213 = trunc i416 %r210 to i32
store i32 %r213, i32* %r212
%r214 = lshr i448 %r161, 416
%r215 = trunc i448 %r214 to i32
ret i32 %r215
}
define void @mclb_mul13(i32* noalias  %r1, i32* noalias  %r2, i32* noalias  %r3)
{
%r4 = load i32, i32* %r3
%r5 = call i448 @mulUnit_inner416(i32* %r2, i32 %r4)
%r6 = trunc i448 %r5 to i32
store i32 %r6, i32* %r1
%r7 = lshr i448 %r5, 32
%r9 = getelementptr i32, i32* %r3, i32 1
%r10 = load i32, i32* %r9
%r11 = call i448 @mulUnit_inner416(i32* %r2, i32 %r10)
%r12 = add i448 %r7, %r11
%r13 = trunc i448 %r12 to i32
%r15 = getelementptr i32, i32* %r1, i32 1
store i32 %r13, i32* %r15
%r16 = lshr i448 %r12, 32
%r18 = getelementptr i32, i32* %r3, i32 2
%r19 = load i32, i32* %r18
%r20 = call i448 @mulUnit_inner416(i32* %r2, i32 %r19)
%r21 = add i448 %r16, %r20
%r22 = trunc i448 %r21 to i32
%r24 = getelementptr i32, i32* %r1, i32 2
store i32 %r22, i32* %r24
%r25 = lshr i448 %r21, 32
%r27 = getelementptr i32, i32* %r3, i32 3
%r28 = load i32, i32* %r27
%r29 = call i448 @mulUnit_inner416(i32* %r2, i32 %r28)
%r30 = add i448 %r25, %r29
%r31 = trunc i448 %r30 to i32
%r33 = getelementptr i32, i32* %r1, i32 3
store i32 %r31, i32* %r33
%r34 = lshr i448 %r30, 32
%r36 = getelementptr i32, i32* %r3, i32 4
%r37 = load i32, i32* %r36
%r38 = call i448 @mulUnit_inner416(i32* %r2, i32 %r37)
%r39 = add i448 %r34, %r38
%r40 = trunc i448 %r39 to i32
%r42 = getelementptr i32, i32* %r1, i32 4
store i32 %r40, i32* %r42
%r43 = lshr i448 %r39, 32
%r45 = getelementptr i32, i32* %r3, i32 5
%r46 = load i32, i32* %r45
%r47 = call i448 @mulUnit_inner416(i32* %r2, i32 %r46)
%r48 = add i448 %r43, %r47
%r49 = trunc i448 %r48 to i32
%r51 = getelementptr i32, i32* %r1, i32 5
store i32 %r49, i32* %r51
%r52 = lshr i448 %r48, 32
%r54 = getelementptr i32, i32* %r3, i32 6
%r55 = load i32, i32* %r54
%r56 = call i448 @mulUnit_inner416(i32* %r2, i32 %r55)
%r57 = add i448 %r52, %r56
%r58 = trunc i448 %r57 to i32
%r60 = getelementptr i32, i32* %r1, i32 6
store i32 %r58, i32* %r60
%r61 = lshr i448 %r57, 32
%r63 = getelementptr i32, i32* %r3, i32 7
%r64 = load i32, i32* %r63
%r65 = call i448 @mulUnit_inner416(i32* %r2, i32 %r64)
%r66 = add i448 %r61, %r65
%r67 = trunc i448 %r66 to i32
%r69 = getelementptr i32, i32* %r1, i32 7
store i32 %r67, i32* %r69
%r70 = lshr i448 %r66, 32
%r72 = getelementptr i32, i32* %r3, i32 8
%r73 = load i32, i32* %r72
%r74 = call i448 @mulUnit_inner416(i32* %r2, i32 %r73)
%r75 = add i448 %r70, %r74
%r76 = trunc i448 %r75 to i32
%r78 = getelementptr i32, i32* %r1, i32 8
store i32 %r76, i32* %r78
%r79 = lshr i448 %r75, 32
%r81 = getelementptr i32, i32* %r3, i32 9
%r82 = load i32, i32* %r81
%r83 = call i448 @mulUnit_inner416(i32* %r2, i32 %r82)
%r84 = add i448 %r79, %r83
%r85 = trunc i448 %r84 to i32
%r87 = getelementptr i32, i32* %r1, i32 9
store i32 %r85, i32* %r87
%r88 = lshr i448 %r84, 32
%r90 = getelementptr i32, i32* %r3, i32 10
%r91 = load i32, i32* %r90
%r92 = call i448 @mulUnit_inner416(i32* %r2, i32 %r91)
%r93 = add i448 %r88, %r92
%r94 = trunc i448 %r93 to i32
%r96 = getelementptr i32, i32* %r1, i32 10
store i32 %r94, i32* %r96
%r97 = lshr i448 %r93, 32
%r99 = getelementptr i32, i32* %r3, i32 11
%r100 = load i32, i32* %r99
%r101 = call i448 @mulUnit_inner416(i32* %r2, i32 %r100)
%r102 = add i448 %r97, %r101
%r103 = trunc i448 %r102 to i32
%r105 = getelementptr i32, i32* %r1, i32 11
store i32 %r103, i32* %r105
%r106 = lshr i448 %r102, 32
%r108 = getelementptr i32, i32* %r3, i32 12
%r109 = load i32, i32* %r108
%r110 = call i448 @mulUnit_inner416(i32* %r2, i32 %r109)
%r111 = add i448 %r106, %r110
%r113 = getelementptr i32, i32* %r1, i32 12
%r115 = getelementptr i32, i32* %r113, i32 0
%r116 = trunc i448 %r111 to i32
store i32 %r116, i32* %r115
%r117 = lshr i448 %r111, 32
%r119 = getelementptr i32, i32* %r113, i32 1
%r120 = trunc i448 %r117 to i32
store i32 %r120, i32* %r119
%r121 = lshr i448 %r117, 32
%r123 = getelementptr i32, i32* %r113, i32 2
%r124 = trunc i448 %r121 to i32
store i32 %r124, i32* %r123
%r125 = lshr i448 %r121, 32
%r127 = getelementptr i32, i32* %r113, i32 3
%r128 = trunc i448 %r125 to i32
store i32 %r128, i32* %r127
%r129 = lshr i448 %r125, 32
%r131 = getelementptr i32, i32* %r113, i32 4
%r132 = trunc i448 %r129 to i32
store i32 %r132, i32* %r131
%r133 = lshr i448 %r129, 32
%r135 = getelementptr i32, i32* %r113, i32 5
%r136 = trunc i448 %r133 to i32
store i32 %r136, i32* %r135
%r137 = lshr i448 %r133, 32
%r139 = getelementptr i32, i32* %r113, i32 6
%r140 = trunc i448 %r137 to i32
store i32 %r140, i32* %r139
%r141 = lshr i448 %r137, 32
%r143 = getelementptr i32, i32* %r113, i32 7
%r144 = trunc i448 %r141 to i32
store i32 %r144, i32* %r143
%r145 = lshr i448 %r141, 32
%r147 = getelementptr i32, i32* %r113, i32 8
%r148 = trunc i448 %r145 to i32
store i32 %r148, i32* %r147
%r149 = lshr i448 %r145, 32
%r151 = getelementptr i32, i32* %r113, i32 9
%r152 = trunc i448 %r149 to i32
store i32 %r152, i32* %r151
%r153 = lshr i448 %r149, 32
%r155 = getelementptr i32, i32* %r113, i32 10
%r156 = trunc i448 %r153 to i32
store i32 %r156, i32* %r155
%r157 = lshr i448 %r153, 32
%r159 = getelementptr i32, i32* %r113, i32 11
%r160 = trunc i448 %r157 to i32
store i32 %r160, i32* %r159
%r161 = lshr i448 %r157, 32
%r163 = getelementptr i32, i32* %r113, i32 12
%r164 = trunc i448 %r161 to i32
store i32 %r164, i32* %r163
%r165 = lshr i448 %r161, 32
%r167 = getelementptr i32, i32* %r113, i32 13
%r168 = trunc i448 %r165 to i32
store i32 %r168, i32* %r167
ret void
}
define void @mclb_sqr13(i32* noalias  %r1, i32* noalias  %r2)
{
%r3 = load i32, i32* %r2
%r4 = call i64 @mul32x32L(i32 %r3, i32 %r3)
%r5 = trunc i64 %r4 to i32
store i32 %r5, i32* %r1
%r6 = lshr i64 %r4, 32
%r8 = getelementptr i32, i32* %r2, i32 12
%r9 = load i32, i32* %r8
%r10 = call i64 @mul32x32L(i32 %r3, i32 %r9)
%r11 = load i32, i32* %r2
%r13 = getelementptr i32, i32* %r2, i32 11
%r14 = load i32, i32* %r13
%r15 = call i64 @mul32x32L(i32 %r11, i32 %r14)
%r17 = getelementptr i32, i32* %r2, i32 1
%r18 = load i32, i32* %r17
%r20 = getelementptr i32, i32* %r2, i32 12
%r21 = load i32, i32* %r20
%r22 = call i64 @mul32x32L(i32 %r18, i32 %r21)
%r23 = zext i64 %r15 to i128
%r24 = zext i64 %r22 to i128
%r25 = shl i128 %r24, 64
%r26 = or i128 %r23, %r25
%r27 = zext i64 %r10 to i128
%r28 = shl i128 %r27, 32
%r29 = add i128 %r28, %r26
%r30 = load i32, i32* %r2
%r32 = getelementptr i32, i32* %r2, i32 10
%r33 = load i32, i32* %r32
%r34 = call i64 @mul32x32L(i32 %r30, i32 %r33)
%r36 = getelementptr i32, i32* %r2, i32 1
%r37 = load i32, i32* %r36
%r39 = getelementptr i32, i32* %r2, i32 11
%r40 = load i32, i32* %r39
%r41 = call i64 @mul32x32L(i32 %r37, i32 %r40)
%r42 = zext i64 %r34 to i128
%r43 = zext i64 %r41 to i128
%r44 = shl i128 %r43, 64
%r45 = or i128 %r42, %r44
%r47 = getelementptr i32, i32* %r2, i32 2
%r48 = load i32, i32* %r47
%r50 = getelementptr i32, i32* %r2, i32 12
%r51 = load i32, i32* %r50
%r52 = call i64 @mul32x32L(i32 %r48, i32 %r51)
%r53 = zext i128 %r45 to i192
%r54 = zext i64 %r52 to i192
%r55 = shl i192 %r54, 128
%r56 = or i192 %r53, %r55
%r57 = zext i128 %r29 to i192
%r58 = shl i192 %r57, 32
%r59 = add i192 %r58, %r56
%r60 = load i32, i32* %r2
%r62 = getelementptr i32, i32* %r2, i32 9
%r63 = load i32, i32* %r62
%r64 = call i64 @mul32x32L(i32 %r60, i32 %r63)
%r66 = getelementptr i32, i32* %r2, i32 1
%r67 = load i32, i32* %r66
%r69 = getelementptr i32, i32* %r2, i32 10
%r70 = load i32, i32* %r69
%r71 = call i64 @mul32x32L(i32 %r67, i32 %r70)
%r72 = zext i64 %r64 to i128
%r73 = zext i64 %r71 to i128
%r74 = shl i128 %r73, 64
%r75 = or i128 %r72, %r74
%r77 = getelementptr i32, i32* %r2, i32 2
%r78 = load i32, i32* %r77
%r80 = getelementptr i32, i32* %r2, i32 11
%r81 = load i32, i32* %r80
%r82 = call i64 @mul32x32L(i32 %r78, i32 %r81)
%r83 = zext i128 %r75 to i192
%r84 = zext i64 %r82 to i192
%r85 = shl i192 %r84, 128
%r86 = or i192 %r83, %r85
%r88 = getelementptr i32, i32* %r2, i32 3
%r89 = load i32, i32* %r88
%r91 = getelementptr i32, i32* %r2, i32 12
%r92 = load i32, i32* %r91
%r93 = call i64 @mul32x32L(i32 %r89, i32 %r92)
%r94 = zext i192 %r86 to i256
%r95 = zext i64 %r93 to i256
%r96 = shl i256 %r95, 192
%r97 = or i256 %r94, %r96
%r98 = zext i192 %r59 to i256
%r99 = shl i256 %r98, 32
%r100 = add i256 %r99, %r97
%r101 = load i32, i32* %r2
%r103 = getelementptr i32, i32* %r2, i32 8
%r104 = load i32, i32* %r103
%r105 = call i64 @mul32x32L(i32 %r101, i32 %r104)
%r107 = getelementptr i32, i32* %r2, i32 1
%r108 = load i32, i32* %r107
%r110 = getelementptr i32, i32* %r2, i32 9
%r111 = load i32, i32* %r110
%r112 = call i64 @mul32x32L(i32 %r108, i32 %r111)
%r113 = zext i64 %r105 to i128
%r114 = zext i64 %r112 to i128
%r115 = shl i128 %r114, 64
%r116 = or i128 %r113, %r115
%r118 = getelementptr i32, i32* %r2, i32 2
%r119 = load i32, i32* %r118
%r121 = getelementptr i32, i32* %r2, i32 10
%r122 = load i32, i32* %r121
%r123 = call i64 @mul32x32L(i32 %r119, i32 %r122)
%r124 = zext i128 %r116 to i192
%r125 = zext i64 %r123 to i192
%r126 = shl i192 %r125, 128
%r127 = or i192 %r124, %r126
%r129 = getelementptr i32, i32* %r2, i32 3
%r130 = load i32, i32* %r129
%r132 = getelementptr i32, i32* %r2, i32 11
%r133 = load i32, i32* %r132
%r134 = call i64 @mul32x32L(i32 %r130, i32 %r133)
%r135 = zext i192 %r127 to i256
%r136 = zext i64 %r134 to i256
%r137 = shl i256 %r136, 192
%r138 = or i256 %r135, %r137
%r140 = getelementptr i32, i32* %r2, i32 4
%r141 = load i32, i32* %r140
%r143 = getelementptr i32, i32* %r2, i32 12
%r144 = load i32, i32* %r143
%r145 = call i64 @mul32x32L(i32 %r141, i32 %r144)
%r146 = zext i256 %r138 to i320
%r147 = zext i64 %r145 to i320
%r148 = shl i320 %r147, 256
%r149 = or i320 %r146, %r148
%r150 = zext i256 %r100 to i320
%r151 = shl i320 %r150, 32
%r152 = add i320 %r151, %r149
%r153 = load i32, i32* %r2
%r155 = getelementptr i32, i32* %r2, i32 7
%r156 = load i32, i32* %r155
%r157 = call i64 @mul32x32L(i32 %r153, i32 %r156)
%r159 = getelementptr i32, i32* %r2, i32 1
%r160 = load i32, i32* %r159
%r162 = getelementptr i32, i32* %r2, i32 8
%r163 = load i32, i32* %r162
%r164 = call i64 @mul32x32L(i32 %r160, i32 %r163)
%r165 = zext i64 %r157 to i128
%r166 = zext i64 %r164 to i128
%r167 = shl i128 %r166, 64
%r168 = or i128 %r165, %r167
%r170 = getelementptr i32, i32* %r2, i32 2
%r171 = load i32, i32* %r170
%r173 = getelementptr i32, i32* %r2, i32 9
%r174 = load i32, i32* %r173
%r175 = call i64 @mul32x32L(i32 %r171, i32 %r174)
%r176 = zext i128 %r168 to i192
%r177 = zext i64 %r175 to i192
%r178 = shl i192 %r177, 128
%r179 = or i192 %r176, %r178
%r181 = getelementptr i32, i32* %r2, i32 3
%r182 = load i32, i32* %r181
%r184 = getelementptr i32, i32* %r2, i32 10
%r185 = load i32, i32* %r184
%r186 = call i64 @mul32x32L(i32 %r182, i32 %r185)
%r187 = zext i192 %r179 to i256
%r188 = zext i64 %r186 to i256
%r189 = shl i256 %r188, 192
%r190 = or i256 %r187, %r189
%r192 = getelementptr i32, i32* %r2, i32 4
%r193 = load i32, i32* %r192
%r195 = getelementptr i32, i32* %r2, i32 11
%r196 = load i32, i32* %r195
%r197 = call i64 @mul32x32L(i32 %r193, i32 %r196)
%r198 = zext i256 %r190 to i320
%r199 = zext i64 %r197 to i320
%r200 = shl i320 %r199, 256
%r201 = or i320 %r198, %r200
%r203 = getelementptr i32, i32* %r2, i32 5
%r204 = load i32, i32* %r203
%r206 = getelementptr i32, i32* %r2, i32 12
%r207 = load i32, i32* %r206
%r208 = call i64 @mul32x32L(i32 %r204, i32 %r207)
%r209 = zext i320 %r201 to i384
%r210 = zext i64 %r208 to i384
%r211 = shl i384 %r210, 320
%r212 = or i384 %r209, %r211
%r213 = zext i320 %r152 to i384
%r214 = shl i384 %r213, 32
%r215 = add i384 %r214, %r212
%r216 = load i32, i32* %r2
%r218 = getelementptr i32, i32* %r2, i32 6
%r219 = load i32, i32* %r218
%r220 = call i64 @mul32x32L(i32 %r216, i32 %r219)
%r222 = getelementptr i32, i32* %r2, i32 1
%r223 = load i32, i32* %r222
%r225 = getelementptr i32, i32* %r2, i32 7
%r226 = load i32, i32* %r225
%r227 = call i64 @mul32x32L(i32 %r223, i32 %r226)
%r228 = zext i64 %r220 to i128
%r229 = zext i64 %r227 to i128
%r230 = shl i128 %r229, 64
%r231 = or i128 %r228, %r230
%r233 = getelementptr i32, i32* %r2, i32 2
%r234 = load i32, i32* %r233
%r236 = getelementptr i32, i32* %r2, i32 8
%r237 = load i32, i32* %r236
%r238 = call i64 @mul32x32L(i32 %r234, i32 %r237)
%r239 = zext i128 %r231 to i192
%r240 = zext i64 %r238 to i192
%r241 = shl i192 %r240, 128
%r242 = or i192 %r239, %r241
%r244 = getelementptr i32, i32* %r2, i32 3
%r245 = load i32, i32* %r244
%r247 = getelementptr i32, i32* %r2, i32 9
%r248 = load i32, i32* %r247
%r249 = call i64 @mul32x32L(i32 %r245, i32 %r248)
%r250 = zext i192 %r242 to i256
%r251 = zext i64 %r249 to i256
%r252 = shl i256 %r251, 192
%r253 = or i256 %r250, %r252
%r255 = getelementptr i32, i32* %r2, i32 4
%r256 = load i32, i32* %r255
%r258 = getelementptr i32, i32* %r2, i32 10
%r259 = load i32, i32* %r258
%r260 = call i64 @mul32x32L(i32 %r256, i32 %r259)
%r261 = zext i256 %r253 to i320
%r262 = zext i64 %r260 to i320
%r263 = shl i320 %r262, 256
%r264 = or i320 %r261, %r263
%r266 = getelementptr i32, i32* %r2, i32 5
%r267 = load i32, i32* %r266
%r269 = getelementptr i32, i32* %r2, i32 11
%r270 = load i32, i32* %r269
%r271 = call i64 @mul32x32L(i32 %r267, i32 %r270)
%r272 = zext i320 %r264 to i384
%r273 = zext i64 %r271 to i384
%r274 = shl i384 %r273, 320
%r275 = or i384 %r272, %r274
%r277 = getelementptr i32, i32* %r2, i32 6
%r278 = load i32, i32* %r277
%r280 = getelementptr i32, i32* %r2, i32 12
%r281 = load i32, i32* %r280
%r282 = call i64 @mul32x32L(i32 %r278, i32 %r281)
%r283 = zext i384 %r275 to i448
%r284 = zext i64 %r282 to i448
%r285 = shl i448 %r284, 384
%r286 = or i448 %r283, %r285
%r287 = zext i384 %r215 to i448
%r288 = shl i448 %r287, 32
%r289 = add i448 %r288, %r286
%r290 = load i32, i32* %r2
%r292 = getelementptr i32, i32* %r2, i32 5
%r293 = load i32, i32* %r292
%r294 = call i64 @mul32x32L(i32 %r290, i32 %r293)
%r296 = getelementptr i32, i32* %r2, i32 1
%r297 = load i32, i32* %r296
%r299 = getelementptr i32, i32* %r2, i32 6
%r300 = load i32, i32* %r299
%r301 = call i64 @mul32x32L(i32 %r297, i32 %r300)
%r302 = zext i64 %r294 to i128
%r303 = zext i64 %r301 to i128
%r304 = shl i128 %r303, 64
%r305 = or i128 %r302, %r304
%r307 = getelementptr i32, i32* %r2, i32 2
%r308 = load i32, i32* %r307
%r310 = getelementptr i32, i32* %r2, i32 7
%r311 = load i32, i32* %r310
%r312 = call i64 @mul32x32L(i32 %r308, i32 %r311)
%r313 = zext i128 %r305 to i192
%r314 = zext i64 %r312 to i192
%r315 = shl i192 %r314, 128
%r316 = or i192 %r313, %r315
%r318 = getelementptr i32, i32* %r2, i32 3
%r319 = load i32, i32* %r318
%r321 = getelementptr i32, i32* %r2, i32 8
%r322 = load i32, i32* %r321
%r323 = call i64 @mul32x32L(i32 %r319, i32 %r322)
%r324 = zext i192 %r316 to i256
%r325 = zext i64 %r323 to i256
%r326 = shl i256 %r325, 192
%r327 = or i256 %r324, %r326
%r329 = getelementptr i32, i32* %r2, i32 4
%r330 = load i32, i32* %r329
%r332 = getelementptr i32, i32* %r2, i32 9
%r333 = load i32, i32* %r332
%r334 = call i64 @mul32x32L(i32 %r330, i32 %r333)
%r335 = zext i256 %r327 to i320
%r336 = zext i64 %r334 to i320
%r337 = shl i320 %r336, 256
%r338 = or i320 %r335, %r337
%r340 = getelementptr i32, i32* %r2, i32 5
%r341 = load i32, i32* %r340
%r343 = getelementptr i32, i32* %r2, i32 10
%r344 = load i32, i32* %r343
%r345 = call i64 @mul32x32L(i32 %r341, i32 %r344)
%r346 = zext i320 %r338 to i384
%r347 = zext i64 %r345 to i384
%r348 = shl i384 %r347, 320
%r349 = or i384 %r346, %r348
%r351 = getelementptr i32, i32* %r2, i32 6
%r352 = load i32, i32* %r351
%r354 = getelementptr i32, i32* %r2, i32 11
%r355 = load i32, i32* %r354
%r356 = call i64 @mul32x32L(i32 %r352, i32 %r355)
%r357 = zext i384 %r349 to i448
%r358 = zext i64 %r356 to i448
%r359 = shl i448 %r358, 384
%r360 = or i448 %r357, %r359
%r362 = getelementptr i32, i32* %r2, i32 7
%r363 = load i32, i32* %r362
%r365 = getelementptr i32, i32* %r2, i32 12
%r366 = load i32, i32* %r365
%r367 = call i64 @mul32x32L(i32 %r363, i32 %r366)
%r368 = zext i448 %r360 to i512
%r369 = zext i64 %r367 to i512
%r370 = shl i512 %r369, 448
%r371 = or i512 %r368, %r370
%r372 = zext i448 %r289 to i512
%r373 = shl i512 %r372, 32
%r374 = add i512 %r373, %r371
%r375 = load i32, i32* %r2
%r377 = getelementptr i32, i32* %r2, i32 4
%r378 = load i32, i32* %r377
%r379 = call i64 @mul32x32L(i32 %r375, i32 %r378)
%r381 = getelementptr i32, i32* %r2, i32 1
%r382 = load i32, i32* %r381
%r384 = getelementptr i32, i32* %r2, i32 5
%r385 = load i32, i32* %r384
%r386 = call i64 @mul32x32L(i32 %r382, i32 %r385)
%r387 = zext i64 %r379 to i128
%r388 = zext i64 %r386 to i128
%r389 = shl i128 %r388, 64
%r390 = or i128 %r387, %r389
%r392 = getelementptr i32, i32* %r2, i32 2
%r393 = load i32, i32* %r392
%r395 = getelementptr i32, i32* %r2, i32 6
%r396 = load i32, i32* %r395
%r397 = call i64 @mul32x32L(i32 %r393, i32 %r396)
%r398 = zext i128 %r390 to i192
%r399 = zext i64 %r397 to i192
%r400 = shl i192 %r399, 128
%r401 = or i192 %r398, %r400
%r403 = getelementptr i32, i32* %r2, i32 3
%r404 = load i32, i32* %r403
%r406 = getelementptr i32, i32* %r2, i32 7
%r407 = load i32, i32* %r406
%r408 = call i64 @mul32x32L(i32 %r404, i32 %r407)
%r409 = zext i192 %r401 to i256
%r410 = zext i64 %r408 to i256
%r411 = shl i256 %r410, 192
%r412 = or i256 %r409, %r411
%r414 = getelementptr i32, i32* %r2, i32 4
%r415 = load i32, i32* %r414
%r417 = getelementptr i32, i32* %r2, i32 8
%r418 = load i32, i32* %r417
%r419 = call i64 @mul32x32L(i32 %r415, i32 %r418)
%r420 = zext i256 %r412 to i320
%r421 = zext i64 %r419 to i320
%r422 = shl i320 %r421, 256
%r423 = or i320 %r420, %r422
%r425 = getelementptr i32, i32* %r2, i32 5
%r426 = load i32, i32* %r425
%r428 = getelementptr i32, i32* %r2, i32 9
%r429 = load i32, i32* %r428
%r430 = call i64 @mul32x32L(i32 %r426, i32 %r429)
%r431 = zext i320 %r423 to i384
%r432 = zext i64 %r430 to i384
%r433 = shl i384 %r432, 320
%r434 = or i384 %r431, %r433
%r436 = getelementptr i32, i32* %r2, i32 6
%r437 = load i32, i32* %r436
%r439 = getelementptr i32, i32* %r2, i32 10
%r440 = load i32, i32* %r439
%r441 = call i64 @mul32x32L(i32 %r437, i32 %r440)
%r442 = zext i384 %r434 to i448
%r443 = zext i64 %r441 to i448
%r444 = shl i448 %r443, 384
%r445 = or i448 %r442, %r444
%r447 = getelementptr i32, i32* %r2, i32 7
%r448 = load i32, i32* %r447
%r450 = getelementptr i32, i32* %r2, i32 11
%r451 = load i32, i32* %r450
%r452 = call i64 @mul32x32L(i32 %r448, i32 %r451)
%r453 = zext i448 %r445 to i512
%r454 = zext i64 %r452 to i512
%r455 = shl i512 %r454, 448
%r456 = or i512 %r453, %r455
%r458 = getelementptr i32, i32* %r2, i32 8
%r459 = load i32, i32* %r458
%r461 = getelementptr i32, i32* %r2, i32 12
%r462 = load i32, i32* %r461
%r463 = call i64 @mul32x32L(i32 %r459, i32 %r462)
%r464 = zext i512 %r456 to i576
%r465 = zext i64 %r463 to i576
%r466 = shl i576 %r465, 512
%r467 = or i576 %r464, %r466
%r468 = zext i512 %r374 to i576
%r469 = shl i576 %r468, 32
%r470 = add i576 %r469, %r467
%r471 = load i32, i32* %r2
%r473 = getelementptr i32, i32* %r2, i32 3
%r474 = load i32, i32* %r473
%r475 = call i64 @mul32x32L(i32 %r471, i32 %r474)
%r477 = getelementptr i32, i32* %r2, i32 1
%r478 = load i32, i32* %r477
%r480 = getelementptr i32, i32* %r2, i32 4
%r481 = load i32, i32* %r480
%r482 = call i64 @mul32x32L(i32 %r478, i32 %r481)
%r483 = zext i64 %r475 to i128
%r484 = zext i64 %r482 to i128
%r485 = shl i128 %r484, 64
%r486 = or i128 %r483, %r485
%r488 = getelementptr i32, i32* %r2, i32 2
%r489 = load i32, i32* %r488
%r491 = getelementptr i32, i32* %r2, i32 5
%r492 = load i32, i32* %r491
%r493 = call i64 @mul32x32L(i32 %r489, i32 %r492)
%r494 = zext i128 %r486 to i192
%r495 = zext i64 %r493 to i192
%r496 = shl i192 %r495, 128
%r497 = or i192 %r494, %r496
%r499 = getelementptr i32, i32* %r2, i32 3
%r500 = load i32, i32* %r499
%r502 = getelementptr i32, i32* %r2, i32 6
%r503 = load i32, i32* %r502
%r504 = call i64 @mul32x32L(i32 %r500, i32 %r503)
%r505 = zext i192 %r497 to i256
%r506 = zext i64 %r504 to i256
%r507 = shl i256 %r506, 192
%r508 = or i256 %r505, %r507
%r510 = getelementptr i32, i32* %r2, i32 4
%r511 = load i32, i32* %r510
%r513 = getelementptr i32, i32* %r2, i32 7
%r514 = load i32, i32* %r513
%r515 = call i64 @mul32x32L(i32 %r511, i32 %r514)
%r516 = zext i256 %r508 to i320
%r517 = zext i64 %r515 to i320
%r518 = shl i320 %r517, 256
%r519 = or i320 %r516, %r518
%r521 = getelementptr i32, i32* %r2, i32 5
%r522 = load i32, i32* %r521
%r524 = getelementptr i32, i32* %r2, i32 8
%r525 = load i32, i32* %r524
%r526 = call i64 @mul32x32L(i32 %r522, i32 %r525)
%r527 = zext i320 %r519 to i384
%r528 = zext i64 %r526 to i384
%r529 = shl i384 %r528, 320
%r530 = or i384 %r527, %r529
%r532 = getelementptr i32, i32* %r2, i32 6
%r533 = load i32, i32* %r532
%r535 = getelementptr i32, i32* %r2, i32 9
%r536 = load i32, i32* %r535
%r537 = call i64 @mul32x32L(i32 %r533, i32 %r536)
%r538 = zext i384 %r530 to i448
%r539 = zext i64 %r537 to i448
%r540 = shl i448 %r539, 384
%r541 = or i448 %r538, %r540
%r543 = getelementptr i32, i32* %r2, i32 7
%r544 = load i32, i32* %r543
%r546 = getelementptr i32, i32* %r2, i32 10
%r547 = load i32, i32* %r546
%r548 = call i64 @mul32x32L(i32 %r544, i32 %r547)
%r549 = zext i448 %r541 to i512
%r550 = zext i64 %r548 to i512
%r551 = shl i512 %r550, 448
%r552 = or i512 %r549, %r551
%r554 = getelementptr i32, i32* %r2, i32 8
%r555 = load i32, i32* %r554
%r557 = getelementptr i32, i32* %r2, i32 11
%r558 = load i32, i32* %r557
%r559 = call i64 @mul32x32L(i32 %r555, i32 %r558)
%r560 = zext i512 %r552 to i576
%r561 = zext i64 %r559 to i576
%r562 = shl i576 %r561, 512
%r563 = or i576 %r560, %r562
%r565 = getelementptr i32, i32* %r2, i32 9
%r566 = load i32, i32* %r565
%r568 = getelementptr i32, i32* %r2, i32 12
%r569 = load i32, i32* %r568
%r570 = call i64 @mul32x32L(i32 %r566, i32 %r569)
%r571 = zext i576 %r563 to i640
%r572 = zext i64 %r570 to i640
%r573 = shl i640 %r572, 576
%r574 = or i640 %r571, %r573
%r575 = zext i576 %r470 to i640
%r576 = shl i640 %r575, 32
%r577 = add i640 %r576, %r574
%r578 = load i32, i32* %r2
%r580 = getelementptr i32, i32* %r2, i32 2
%r581 = load i32, i32* %r580
%r582 = call i64 @mul32x32L(i32 %r578, i32 %r581)
%r584 = getelementptr i32, i32* %r2, i32 1
%r585 = load i32, i32* %r584
%r587 = getelementptr i32, i32* %r2, i32 3
%r588 = load i32, i32* %r587
%r589 = call i64 @mul32x32L(i32 %r585, i32 %r588)
%r590 = zext i64 %r582 to i128
%r591 = zext i64 %r589 to i128
%r592 = shl i128 %r591, 64
%r593 = or i128 %r590, %r592
%r595 = getelementptr i32, i32* %r2, i32 2
%r596 = load i32, i32* %r595
%r598 = getelementptr i32, i32* %r2, i32 4
%r599 = load i32, i32* %r598
%r600 = call i64 @mul32x32L(i32 %r596, i32 %r599)
%r601 = zext i128 %r593 to i192
%r602 = zext i64 %r600 to i192
%r603 = shl i192 %r602, 128
%r604 = or i192 %r601, %r603
%r606 = getelementptr i32, i32* %r2, i32 3
%r607 = load i32, i32* %r606
%r609 = getelementptr i32, i32* %r2, i32 5
%r610 = load i32, i32* %r609
%r611 = call i64 @mul32x32L(i32 %r607, i32 %r610)
%r612 = zext i192 %r604 to i256
%r613 = zext i64 %r611 to i256
%r614 = shl i256 %r613, 192
%r615 = or i256 %r612, %r614
%r617 = getelementptr i32, i32* %r2, i32 4
%r618 = load i32, i32* %r617
%r620 = getelementptr i32, i32* %r2, i32 6
%r621 = load i32, i32* %r620
%r622 = call i64 @mul32x32L(i32 %r618, i32 %r621)
%r623 = zext i256 %r615 to i320
%r624 = zext i64 %r622 to i320
%r625 = shl i320 %r624, 256
%r626 = or i320 %r623, %r625
%r628 = getelementptr i32, i32* %r2, i32 5
%r629 = load i32, i32* %r628
%r631 = getelementptr i32, i32* %r2, i32 7
%r632 = load i32, i32* %r631
%r633 = call i64 @mul32x32L(i32 %r629, i32 %r632)
%r634 = zext i320 %r626 to i384
%r635 = zext i64 %r633 to i384
%r636 = shl i384 %r635, 320
%r637 = or i384 %r634, %r636
%r639 = getelementptr i32, i32* %r2, i32 6
%r640 = load i32, i32* %r639
%r642 = getelementptr i32, i32* %r2, i32 8
%r643 = load i32, i32* %r642
%r644 = call i64 @mul32x32L(i32 %r640, i32 %r643)
%r645 = zext i384 %r637 to i448
%r646 = zext i64 %r644 to i448
%r647 = shl i448 %r646, 384
%r648 = or i448 %r645, %r647
%r650 = getelementptr i32, i32* %r2, i32 7
%r651 = load i32, i32* %r650
%r653 = getelementptr i32, i32* %r2, i32 9
%r654 = load i32, i32* %r653
%r655 = call i64 @mul32x32L(i32 %r651, i32 %r654)
%r656 = zext i448 %r648 to i512
%r657 = zext i64 %r655 to i512
%r658 = shl i512 %r657, 448
%r659 = or i512 %r656, %r658
%r661 = getelementptr i32, i32* %r2, i32 8
%r662 = load i32, i32* %r661
%r664 = getelementptr i32, i32* %r2, i32 10
%r665 = load i32, i32* %r664
%r666 = call i64 @mul32x32L(i32 %r662, i32 %r665)
%r667 = zext i512 %r659 to i576
%r668 = zext i64 %r666 to i576
%r669 = shl i576 %r668, 512
%r670 = or i576 %r667, %r669
%r672 = getelementptr i32, i32* %r2, i32 9
%r673 = load i32, i32* %r672
%r675 = getelementptr i32, i32* %r2, i32 11
%r676 = load i32, i32* %r675
%r677 = call i64 @mul32x32L(i32 %r673, i32 %r676)
%r678 = zext i576 %r670 to i640
%r679 = zext i64 %r677 to i640
%r680 = shl i640 %r679, 576
%r681 = or i640 %r678, %r680
%r683 = getelementptr i32, i32* %r2, i32 10
%r684 = load i32, i32* %r683
%r686 = getelementptr i32, i32* %r2, i32 12
%r687 = load i32, i32* %r686
%r688 = call i64 @mul32x32L(i32 %r684, i32 %r687)
%r689 = zext i640 %r681 to i704
%r690 = zext i64 %r688 to i704
%r691 = shl i704 %r690, 640
%r692 = or i704 %r689, %r691
%r693 = zext i640 %r577 to i704
%r694 = shl i704 %r693, 32
%r695 = add i704 %r694, %r692
%r696 = load i32, i32* %r2
%r698 = getelementptr i32, i32* %r2, i32 1
%r699 = load i32, i32* %r698
%r700 = call i64 @mul32x32L(i32 %r696, i32 %r699)
%r702 = getelementptr i32, i32* %r2, i32 1
%r703 = load i32, i32* %r702
%r705 = getelementptr i32, i32* %r2, i32 2
%r706 = load i32, i32* %r705
%r707 = call i64 @mul32x32L(i32 %r703, i32 %r706)
%r708 = zext i64 %r700 to i128
%r709 = zext i64 %r707 to i128
%r710 = shl i128 %r709, 64
%r711 = or i128 %r708, %r710
%r713 = getelementptr i32, i32* %r2, i32 2
%r714 = load i32, i32* %r713
%r716 = getelementptr i32, i32* %r2, i32 3
%r717 = load i32, i32* %r716
%r718 = call i64 @mul32x32L(i32 %r714, i32 %r717)
%r719 = zext i128 %r711 to i192
%r720 = zext i64 %r718 to i192
%r721 = shl i192 %r720, 128
%r722 = or i192 %r719, %r721
%r724 = getelementptr i32, i32* %r2, i32 3
%r725 = load i32, i32* %r724
%r727 = getelementptr i32, i32* %r2, i32 4
%r728 = load i32, i32* %r727
%r729 = call i64 @mul32x32L(i32 %r725, i32 %r728)
%r730 = zext i192 %r722 to i256
%r731 = zext i64 %r729 to i256
%r732 = shl i256 %r731, 192
%r733 = or i256 %r730, %r732
%r735 = getelementptr i32, i32* %r2, i32 4
%r736 = load i32, i32* %r735
%r738 = getelementptr i32, i32* %r2, i32 5
%r739 = load i32, i32* %r738
%r740 = call i64 @mul32x32L(i32 %r736, i32 %r739)
%r741 = zext i256 %r733 to i320
%r742 = zext i64 %r740 to i320
%r743 = shl i320 %r742, 256
%r744 = or i320 %r741, %r743
%r746 = getelementptr i32, i32* %r2, i32 5
%r747 = load i32, i32* %r746
%r749 = getelementptr i32, i32* %r2, i32 6
%r750 = load i32, i32* %r749
%r751 = call i64 @mul32x32L(i32 %r747, i32 %r750)
%r752 = zext i320 %r744 to i384
%r753 = zext i64 %r751 to i384
%r754 = shl i384 %r753, 320
%r755 = or i384 %r752, %r754
%r757 = getelementptr i32, i32* %r2, i32 6
%r758 = load i32, i32* %r757
%r760 = getelementptr i32, i32* %r2, i32 7
%r761 = load i32, i32* %r760
%r762 = call i64 @mul32x32L(i32 %r758, i32 %r761)
%r763 = zext i384 %r755 to i448
%r764 = zext i64 %r762 to i448
%r765 = shl i448 %r764, 384
%r766 = or i448 %r763, %r765
%r768 = getelementptr i32, i32* %r2, i32 7
%r769 = load i32, i32* %r768
%r771 = getelementptr i32, i32* %r2, i32 8
%r772 = load i32, i32* %r771
%r773 = call i64 @mul32x32L(i32 %r769, i32 %r772)
%r774 = zext i448 %r766 to i512
%r775 = zext i64 %r773 to i512
%r776 = shl i512 %r775, 448
%r777 = or i512 %r774, %r776
%r779 = getelementptr i32, i32* %r2, i32 8
%r780 = load i32, i32* %r779
%r782 = getelementptr i32, i32* %r2, i32 9
%r783 = load i32, i32* %r782
%r784 = call i64 @mul32x32L(i32 %r780, i32 %r783)
%r785 = zext i512 %r777 to i576
%r786 = zext i64 %r784 to i576
%r787 = shl i576 %r786, 512
%r788 = or i576 %r785, %r787
%r790 = getelementptr i32, i32* %r2, i32 9
%r791 = load i32, i32* %r790
%r793 = getelementptr i32, i32* %r2, i32 10
%r794 = load i32, i32* %r793
%r795 = call i64 @mul32x32L(i32 %r791, i32 %r794)
%r796 = zext i576 %r788 to i640
%r797 = zext i64 %r795 to i640
%r798 = shl i640 %r797, 576
%r799 = or i640 %r796, %r798
%r801 = getelementptr i32, i32* %r2, i32 10
%r802 = load i32, i32* %r801
%r804 = getelementptr i32, i32* %r2, i32 11
%r805 = load i32, i32* %r804
%r806 = call i64 @mul32x32L(i32 %r802, i32 %r805)
%r807 = zext i640 %r799 to i704
%r808 = zext i64 %r806 to i704
%r809 = shl i704 %r808, 640
%r810 = or i704 %r807, %r809
%r812 = getelementptr i32, i32* %r2, i32 11
%r813 = load i32, i32* %r812
%r815 = getelementptr i32, i32* %r2, i32 12
%r816 = load i32, i32* %r815
%r817 = call i64 @mul32x32L(i32 %r813, i32 %r816)
%r818 = zext i704 %r810 to i768
%r819 = zext i64 %r817 to i768
%r820 = shl i768 %r819, 704
%r821 = or i768 %r818, %r820
%r822 = zext i704 %r695 to i768
%r823 = shl i768 %r822, 32
%r824 = add i768 %r823, %r821
%r825 = zext i64 %r6 to i800
%r827 = getelementptr i32, i32* %r2, i32 1
%r828 = load i32, i32* %r827
%r829 = call i64 @mul32x32L(i32 %r828, i32 %r828)
%r830 = zext i64 %r829 to i800
%r831 = shl i800 %r830, 32
%r832 = or i800 %r825, %r831
%r834 = getelementptr i32, i32* %r2, i32 2
%r835 = load i32, i32* %r834
%r836 = call i64 @mul32x32L(i32 %r835, i32 %r835)
%r837 = zext i64 %r836 to i800
%r838 = shl i800 %r837, 96
%r839 = or i800 %r832, %r838
%r841 = getelementptr i32, i32* %r2, i32 3
%r842 = load i32, i32* %r841
%r843 = call i64 @mul32x32L(i32 %r842, i32 %r842)
%r844 = zext i64 %r843 to i800
%r845 = shl i800 %r844, 160
%r846 = or i800 %r839, %r845
%r848 = getelementptr i32, i32* %r2, i32 4
%r849 = load i32, i32* %r848
%r850 = call i64 @mul32x32L(i32 %r849, i32 %r849)
%r851 = zext i64 %r850 to i800
%r852 = shl i800 %r851, 224
%r853 = or i800 %r846, %r852
%r855 = getelementptr i32, i32* %r2, i32 5
%r856 = load i32, i32* %r855
%r857 = call i64 @mul32x32L(i32 %r856, i32 %r856)
%r858 = zext i64 %r857 to i800
%r859 = shl i800 %r858, 288
%r860 = or i800 %r853, %r859
%r862 = getelementptr i32, i32* %r2, i32 6
%r863 = load i32, i32* %r862
%r864 = call i64 @mul32x32L(i32 %r863, i32 %r863)
%r865 = zext i64 %r864 to i800
%r866 = shl i800 %r865, 352
%r867 = or i800 %r860, %r866
%r869 = getelementptr i32, i32* %r2, i32 7
%r870 = load i32, i32* %r869
%r871 = call i64 @mul32x32L(i32 %r870, i32 %r870)
%r872 = zext i64 %r871 to i800
%r873 = shl i800 %r872, 416
%r874 = or i800 %r867, %r873
%r876 = getelementptr i32, i32* %r2, i32 8
%r877 = load i32, i32* %r876
%r878 = call i64 @mul32x32L(i32 %r877, i32 %r877)
%r879 = zext i64 %r878 to i800
%r880 = shl i800 %r879, 480
%r881 = or i800 %r874, %r880
%r883 = getelementptr i32, i32* %r2, i32 9
%r884 = load i32, i32* %r883
%r885 = call i64 @mul32x32L(i32 %r884, i32 %r884)
%r886 = zext i64 %r885 to i800
%r887 = shl i800 %r886, 544
%r888 = or i800 %r881, %r887
%r890 = getelementptr i32, i32* %r2, i32 10
%r891 = load i32, i32* %r890
%r892 = call i64 @mul32x32L(i32 %r891, i32 %r891)
%r893 = zext i64 %r892 to i800
%r894 = shl i800 %r893, 608
%r895 = or i800 %r888, %r894
%r897 = getelementptr i32, i32* %r2, i32 11
%r898 = load i32, i32* %r897
%r899 = call i64 @mul32x32L(i32 %r898, i32 %r898)
%r900 = zext i64 %r899 to i800
%r901 = shl i800 %r900, 672
%r902 = or i800 %r895, %r901
%r904 = getelementptr i32, i32* %r2, i32 12
%r905 = load i32, i32* %r904
%r906 = call i64 @mul32x32L(i32 %r905, i32 %r905)
%r907 = zext i64 %r906 to i800
%r908 = shl i800 %r907, 736
%r909 = or i800 %r902, %r908
%r910 = zext i768 %r824 to i800
%r911 = add i800 %r910, %r910
%r912 = add i800 %r909, %r911
%r914 = getelementptr i32, i32* %r1, i32 1
%r916 = getelementptr i32, i32* %r914, i32 0
%r917 = trunc i800 %r912 to i32
store i32 %r917, i32* %r916
%r918 = lshr i800 %r912, 32
%r920 = getelementptr i32, i32* %r914, i32 1
%r921 = trunc i800 %r918 to i32
store i32 %r921, i32* %r920
%r922 = lshr i800 %r918, 32
%r924 = getelementptr i32, i32* %r914, i32 2
%r925 = trunc i800 %r922 to i32
store i32 %r925, i32* %r924
%r926 = lshr i800 %r922, 32
%r928 = getelementptr i32, i32* %r914, i32 3
%r929 = trunc i800 %r926 to i32
store i32 %r929, i32* %r928
%r930 = lshr i800 %r926, 32
%r932 = getelementptr i32, i32* %r914, i32 4
%r933 = trunc i800 %r930 to i32
store i32 %r933, i32* %r932
%r934 = lshr i800 %r930, 32
%r936 = getelementptr i32, i32* %r914, i32 5
%r937 = trunc i800 %r934 to i32
store i32 %r937, i32* %r936
%r938 = lshr i800 %r934, 32
%r940 = getelementptr i32, i32* %r914, i32 6
%r941 = trunc i800 %r938 to i32
store i32 %r941, i32* %r940
%r942 = lshr i800 %r938, 32
%r944 = getelementptr i32, i32* %r914, i32 7
%r945 = trunc i800 %r942 to i32
store i32 %r945, i32* %r944
%r946 = lshr i800 %r942, 32
%r948 = getelementptr i32, i32* %r914, i32 8
%r949 = trunc i800 %r946 to i32
store i32 %r949, i32* %r948
%r950 = lshr i800 %r946, 32
%r952 = getelementptr i32, i32* %r914, i32 9
%r953 = trunc i800 %r950 to i32
store i32 %r953, i32* %r952
%r954 = lshr i800 %r950, 32
%r956 = getelementptr i32, i32* %r914, i32 10
%r957 = trunc i800 %r954 to i32
store i32 %r957, i32* %r956
%r958 = lshr i800 %r954, 32
%r960 = getelementptr i32, i32* %r914, i32 11
%r961 = trunc i800 %r958 to i32
store i32 %r961, i32* %r960
%r962 = lshr i800 %r958, 32
%r964 = getelementptr i32, i32* %r914, i32 12
%r965 = trunc i800 %r962 to i32
store i32 %r965, i32* %r964
%r966 = lshr i800 %r962, 32
%r968 = getelementptr i32, i32* %r914, i32 13
%r969 = trunc i800 %r966 to i32
store i32 %r969, i32* %r968
%r970 = lshr i800 %r966, 32
%r972 = getelementptr i32, i32* %r914, i32 14
%r973 = trunc i800 %r970 to i32
store i32 %r973, i32* %r972
%r974 = lshr i800 %r970, 32
%r976 = getelementptr i32, i32* %r914, i32 15
%r977 = trunc i800 %r974 to i32
store i32 %r977, i32* %r976
%r978 = lshr i800 %r974, 32
%r980 = getelementptr i32, i32* %r914, i32 16
%r981 = trunc i800 %r978 to i32
store i32 %r981, i32* %r980
%r982 = lshr i800 %r978, 32
%r984 = getelementptr i32, i32* %r914, i32 17
%r985 = trunc i800 %r982 to i32
store i32 %r985, i32* %r984
%r986 = lshr i800 %r982, 32
%r988 = getelementptr i32, i32* %r914, i32 18
%r989 = trunc i800 %r986 to i32
store i32 %r989, i32* %r988
%r990 = lshr i800 %r986, 32
%r992 = getelementptr i32, i32* %r914, i32 19
%r993 = trunc i800 %r990 to i32
store i32 %r993, i32* %r992
%r994 = lshr i800 %r990, 32
%r996 = getelementptr i32, i32* %r914, i32 20
%r997 = trunc i800 %r994 to i32
store i32 %r997, i32* %r996
%r998 = lshr i800 %r994, 32
%r1000 = getelementptr i32, i32* %r914, i32 21
%r1001 = trunc i800 %r998 to i32
store i32 %r1001, i32* %r1000
%r1002 = lshr i800 %r998, 32
%r1004 = getelementptr i32, i32* %r914, i32 22
%r1005 = trunc i800 %r1002 to i32
store i32 %r1005, i32* %r1004
%r1006 = lshr i800 %r1002, 32
%r1008 = getelementptr i32, i32* %r914, i32 23
%r1009 = trunc i800 %r1006 to i32
store i32 %r1009, i32* %r1008
%r1010 = lshr i800 %r1006, 32
%r1012 = getelementptr i32, i32* %r914, i32 24
%r1013 = trunc i800 %r1010 to i32
store i32 %r1013, i32* %r1012
ret void
}
define i480 @mulUnit_inner448(i32* noalias  %r2, i32 %r3)
{
%r5 = call i64 @mulPos32x32(i32* %r2, i32 %r3, i32 0)
%r6 = trunc i64 %r5 to i32
%r7 = call i32 @extractHigh32(i64 %r5)
%r9 = call i64 @mulPos32x32(i32* %r2, i32 %r3, i32 1)
%r10 = trunc i64 %r9 to i32
%r11 = call i32 @extractHigh32(i64 %r9)
%r13 = call i64 @mulPos32x32(i32* %r2, i32 %r3, i32 2)
%r14 = trunc i64 %r13 to i32
%r15 = call i32 @extractHigh32(i64 %r13)
%r17 = call i64 @mulPos32x32(i32* %r2, i32 %r3, i32 3)
%r18 = trunc i64 %r17 to i32
%r19 = call i32 @extractHigh32(i64 %r17)
%r21 = call i64 @mulPos32x32(i32* %r2, i32 %r3, i32 4)
%r22 = trunc i64 %r21 to i32
%r23 = call i32 @extractHigh32(i64 %r21)
%r25 = call i64 @mulPos32x32(i32* %r2, i32 %r3, i32 5)
%r26 = trunc i64 %r25 to i32
%r27 = call i32 @extractHigh32(i64 %r25)
%r29 = call i64 @mulPos32x32(i32* %r2, i32 %r3, i32 6)
%r30 = trunc i64 %r29 to i32
%r31 = call i32 @extractHigh32(i64 %r29)
%r33 = call i64 @mulPos32x32(i32* %r2, i32 %r3, i32 7)
%r34 = trunc i64 %r33 to i32
%r35 = call i32 @extractHigh32(i64 %r33)
%r37 = call i64 @mulPos32x32(i32* %r2, i32 %r3, i32 8)
%r38 = trunc i64 %r37 to i32
%r39 = call i32 @extractHigh32(i64 %r37)
%r41 = call i64 @mulPos32x32(i32* %r2, i32 %r3, i32 9)
%r42 = trunc i64 %r41 to i32
%r43 = call i32 @extractHigh32(i64 %r41)
%r45 = call i64 @mulPos32x32(i32* %r2, i32 %r3, i32 10)
%r46 = trunc i64 %r45 to i32
%r47 = call i32 @extractHigh32(i64 %r45)
%r49 = call i64 @mulPos32x32(i32* %r2, i32 %r3, i32 11)
%r50 = trunc i64 %r49 to i32
%r51 = call i32 @extractHigh32(i64 %r49)
%r53 = call i64 @mulPos32x32(i32* %r2, i32 %r3, i32 12)
%r54 = trunc i64 %r53 to i32
%r55 = call i32 @extractHigh32(i64 %r53)
%r57 = call i64 @mulPos32x32(i32* %r2, i32 %r3, i32 13)
%r58 = trunc i64 %r57 to i32
%r59 = call i32 @extractHigh32(i64 %r57)
%r60 = zext i32 %r6 to i64
%r61 = zext i32 %r10 to i64
%r62 = shl i64 %r61, 32
%r63 = or i64 %r60, %r62
%r64 = zext i64 %r63 to i96
%r65 = zext i32 %r14 to i96
%r66 = shl i96 %r65, 64
%r67 = or i96 %r64, %r66
%r68 = zext i96 %r67 to i128
%r69 = zext i32 %r18 to i128
%r70 = shl i128 %r69, 96
%r71 = or i128 %r68, %r70
%r72 = zext i128 %r71 to i160
%r73 = zext i32 %r22 to i160
%r74 = shl i160 %r73, 128
%r75 = or i160 %r72, %r74
%r76 = zext i160 %r75 to i192
%r77 = zext i32 %r26 to i192
%r78 = shl i192 %r77, 160
%r79 = or i192 %r76, %r78
%r80 = zext i192 %r79 to i224
%r81 = zext i32 %r30 to i224
%r82 = shl i224 %r81, 192
%r83 = or i224 %r80, %r82
%r84 = zext i224 %r83 to i256
%r85 = zext i32 %r34 to i256
%r86 = shl i256 %r85, 224
%r87 = or i256 %r84, %r86
%r88 = zext i256 %r87 to i288
%r89 = zext i32 %r38 to i288
%r90 = shl i288 %r89, 256
%r91 = or i288 %r88, %r90
%r92 = zext i288 %r91 to i320
%r93 = zext i32 %r42 to i320
%r94 = shl i320 %r93, 288
%r95 = or i320 %r92, %r94
%r96 = zext i320 %r95 to i352
%r97 = zext i32 %r46 to i352
%r98 = shl i352 %r97, 320
%r99 = or i352 %r96, %r98
%r100 = zext i352 %r99 to i384
%r101 = zext i32 %r50 to i384
%r102 = shl i384 %r101, 352
%r103 = or i384 %r100, %r102
%r104 = zext i384 %r103 to i416
%r105 = zext i32 %r54 to i416
%r106 = shl i416 %r105, 384
%r107 = or i416 %r104, %r106
%r108 = zext i416 %r107 to i448
%r109 = zext i32 %r58 to i448
%r110 = shl i448 %r109, 416
%r111 = or i448 %r108, %r110
%r112 = zext i32 %r7 to i64
%r113 = zext i32 %r11 to i64
%r114 = shl i64 %r113, 32
%r115 = or i64 %r112, %r114
%r116 = zext i64 %r115 to i96
%r117 = zext i32 %r15 to i96
%r118 = shl i96 %r117, 64
%r119 = or i96 %r116, %r118
%r120 = zext i96 %r119 to i128
%r121 = zext i32 %r19 to i128
%r122 = shl i128 %r121, 96
%r123 = or i128 %r120, %r122
%r124 = zext i128 %r123 to i160
%r125 = zext i32 %r23 to i160
%r126 = shl i160 %r125, 128
%r127 = or i160 %r124, %r126
%r128 = zext i160 %r127 to i192
%r129 = zext i32 %r27 to i192
%r130 = shl i192 %r129, 160
%r131 = or i192 %r128, %r130
%r132 = zext i192 %r131 to i224
%r133 = zext i32 %r31 to i224
%r134 = shl i224 %r133, 192
%r135 = or i224 %r132, %r134
%r136 = zext i224 %r135 to i256
%r137 = zext i32 %r35 to i256
%r138 = shl i256 %r137, 224
%r139 = or i256 %r136, %r138
%r140 = zext i256 %r139 to i288
%r141 = zext i32 %r39 to i288
%r142 = shl i288 %r141, 256
%r143 = or i288 %r140, %r142
%r144 = zext i288 %r143 to i320
%r145 = zext i32 %r43 to i320
%r146 = shl i320 %r145, 288
%r147 = or i320 %r144, %r146
%r148 = zext i320 %r147 to i352
%r149 = zext i32 %r47 to i352
%r150 = shl i352 %r149, 320
%r151 = or i352 %r148, %r150
%r152 = zext i352 %r151 to i384
%r153 = zext i32 %r51 to i384
%r154 = shl i384 %r153, 352
%r155 = or i384 %r152, %r154
%r156 = zext i384 %r155 to i416
%r157 = zext i32 %r55 to i416
%r158 = shl i416 %r157, 384
%r159 = or i416 %r156, %r158
%r160 = zext i416 %r159 to i448
%r161 = zext i32 %r59 to i448
%r162 = shl i448 %r161, 416
%r163 = or i448 %r160, %r162
%r164 = zext i448 %r111 to i480
%r165 = zext i448 %r163 to i480
%r166 = shl i480 %r165, 32
%r167 = add i480 %r164, %r166
ret i480 %r167
}
define i32 @mclb_mulUnit14(i32* noalias  %r2, i32* noalias  %r3, i32 %r4)
{
%r5 = call i480 @mulUnit_inner448(i32* %r3, i32 %r4)
%r6 = trunc i480 %r5 to i448
%r8 = getelementptr i32, i32* %r2, i32 0
%r9 = trunc i448 %r6 to i32
store i32 %r9, i32* %r8
%r10 = lshr i448 %r6, 32
%r12 = getelementptr i32, i32* %r2, i32 1
%r13 = trunc i448 %r10 to i32
store i32 %r13, i32* %r12
%r14 = lshr i448 %r10, 32
%r16 = getelementptr i32, i32* %r2, i32 2
%r17 = trunc i448 %r14 to i32
store i32 %r17, i32* %r16
%r18 = lshr i448 %r14, 32
%r20 = getelementptr i32, i32* %r2, i32 3
%r21 = trunc i448 %r18 to i32
store i32 %r21, i32* %r20
%r22 = lshr i448 %r18, 32
%r24 = getelementptr i32, i32* %r2, i32 4
%r25 = trunc i448 %r22 to i32
store i32 %r25, i32* %r24
%r26 = lshr i448 %r22, 32
%r28 = getelementptr i32, i32* %r2, i32 5
%r29 = trunc i448 %r26 to i32
store i32 %r29, i32* %r28
%r30 = lshr i448 %r26, 32
%r32 = getelementptr i32, i32* %r2, i32 6
%r33 = trunc i448 %r30 to i32
store i32 %r33, i32* %r32
%r34 = lshr i448 %r30, 32
%r36 = getelementptr i32, i32* %r2, i32 7
%r37 = trunc i448 %r34 to i32
store i32 %r37, i32* %r36
%r38 = lshr i448 %r34, 32
%r40 = getelementptr i32, i32* %r2, i32 8
%r41 = trunc i448 %r38 to i32
store i32 %r41, i32* %r40
%r42 = lshr i448 %r38, 32
%r44 = getelementptr i32, i32* %r2, i32 9
%r45 = trunc i448 %r42 to i32
store i32 %r45, i32* %r44
%r46 = lshr i448 %r42, 32
%r48 = getelementptr i32, i32* %r2, i32 10
%r49 = trunc i448 %r46 to i32
store i32 %r49, i32* %r48
%r50 = lshr i448 %r46, 32
%r52 = getelementptr i32, i32* %r2, i32 11
%r53 = trunc i448 %r50 to i32
store i32 %r53, i32* %r52
%r54 = lshr i448 %r50, 32
%r56 = getelementptr i32, i32* %r2, i32 12
%r57 = trunc i448 %r54 to i32
store i32 %r57, i32* %r56
%r58 = lshr i448 %r54, 32
%r60 = getelementptr i32, i32* %r2, i32 13
%r61 = trunc i448 %r58 to i32
store i32 %r61, i32* %r60
%r62 = lshr i480 %r5, 448
%r63 = trunc i480 %r62 to i32
ret i32 %r63
}
define i32 @mclb_mulUnitAdd14(i32* noalias  %r2, i32* noalias  %r3, i32 %r4)
{
%r6 = call i64 @mulPos32x32(i32* %r3, i32 %r4, i32 0)
%r7 = trunc i64 %r6 to i32
%r8 = call i32 @extractHigh32(i64 %r6)
%r10 = call i64 @mulPos32x32(i32* %r3, i32 %r4, i32 1)
%r11 = trunc i64 %r10 to i32
%r12 = call i32 @extractHigh32(i64 %r10)
%r14 = call i64 @mulPos32x32(i32* %r3, i32 %r4, i32 2)
%r15 = trunc i64 %r14 to i32
%r16 = call i32 @extractHigh32(i64 %r14)
%r18 = call i64 @mulPos32x32(i32* %r3, i32 %r4, i32 3)
%r19 = trunc i64 %r18 to i32
%r20 = call i32 @extractHigh32(i64 %r18)
%r22 = call i64 @mulPos32x32(i32* %r3, i32 %r4, i32 4)
%r23 = trunc i64 %r22 to i32
%r24 = call i32 @extractHigh32(i64 %r22)
%r26 = call i64 @mulPos32x32(i32* %r3, i32 %r4, i32 5)
%r27 = trunc i64 %r26 to i32
%r28 = call i32 @extractHigh32(i64 %r26)
%r30 = call i64 @mulPos32x32(i32* %r3, i32 %r4, i32 6)
%r31 = trunc i64 %r30 to i32
%r32 = call i32 @extractHigh32(i64 %r30)
%r34 = call i64 @mulPos32x32(i32* %r3, i32 %r4, i32 7)
%r35 = trunc i64 %r34 to i32
%r36 = call i32 @extractHigh32(i64 %r34)
%r38 = call i64 @mulPos32x32(i32* %r3, i32 %r4, i32 8)
%r39 = trunc i64 %r38 to i32
%r40 = call i32 @extractHigh32(i64 %r38)
%r42 = call i64 @mulPos32x32(i32* %r3, i32 %r4, i32 9)
%r43 = trunc i64 %r42 to i32
%r44 = call i32 @extractHigh32(i64 %r42)
%r46 = call i64 @mulPos32x32(i32* %r3, i32 %r4, i32 10)
%r47 = trunc i64 %r46 to i32
%r48 = call i32 @extractHigh32(i64 %r46)
%r50 = call i64 @mulPos32x32(i32* %r3, i32 %r4, i32 11)
%r51 = trunc i64 %r50 to i32
%r52 = call i32 @extractHigh32(i64 %r50)
%r54 = call i64 @mulPos32x32(i32* %r3, i32 %r4, i32 12)
%r55 = trunc i64 %r54 to i32
%r56 = call i32 @extractHigh32(i64 %r54)
%r58 = call i64 @mulPos32x32(i32* %r3, i32 %r4, i32 13)
%r59 = trunc i64 %r58 to i32
%r60 = call i32 @extractHigh32(i64 %r58)
%r61 = zext i32 %r7 to i64
%r62 = zext i32 %r11 to i64
%r63 = shl i64 %r62, 32
%r64 = or i64 %r61, %r63
%r65 = zext i64 %r64 to i96
%r66 = zext i32 %r15 to i96
%r67 = shl i96 %r66, 64
%r68 = or i96 %r65, %r67
%r69 = zext i96 %r68 to i128
%r70 = zext i32 %r19 to i128
%r71 = shl i128 %r70, 96
%r72 = or i128 %r69, %r71
%r73 = zext i128 %r72 to i160
%r74 = zext i32 %r23 to i160
%r75 = shl i160 %r74, 128
%r76 = or i160 %r73, %r75
%r77 = zext i160 %r76 to i192
%r78 = zext i32 %r27 to i192
%r79 = shl i192 %r78, 160
%r80 = or i192 %r77, %r79
%r81 = zext i192 %r80 to i224
%r82 = zext i32 %r31 to i224
%r83 = shl i224 %r82, 192
%r84 = or i224 %r81, %r83
%r85 = zext i224 %r84 to i256
%r86 = zext i32 %r35 to i256
%r87 = shl i256 %r86, 224
%r88 = or i256 %r85, %r87
%r89 = zext i256 %r88 to i288
%r90 = zext i32 %r39 to i288
%r91 = shl i288 %r90, 256
%r92 = or i288 %r89, %r91
%r93 = zext i288 %r92 to i320
%r94 = zext i32 %r43 to i320
%r95 = shl i320 %r94, 288
%r96 = or i320 %r93, %r95
%r97 = zext i320 %r96 to i352
%r98 = zext i32 %r47 to i352
%r99 = shl i352 %r98, 320
%r100 = or i352 %r97, %r99
%r101 = zext i352 %r100 to i384
%r102 = zext i32 %r51 to i384
%r103 = shl i384 %r102, 352
%r104 = or i384 %r101, %r103
%r105 = zext i384 %r104 to i416
%r106 = zext i32 %r55 to i416
%r107 = shl i416 %r106, 384
%r108 = or i416 %r105, %r107
%r109 = zext i416 %r108 to i448
%r110 = zext i32 %r59 to i448
%r111 = shl i448 %r110, 416
%r112 = or i448 %r109, %r111
%r113 = zext i32 %r8 to i64
%r114 = zext i32 %r12 to i64
%r115 = shl i64 %r114, 32
%r116 = or i64 %r113, %r115
%r117 = zext i64 %r116 to i96
%r118 = zext i32 %r16 to i96
%r119 = shl i96 %r118, 64
%r120 = or i96 %r117, %r119
%r121 = zext i96 %r120 to i128
%r122 = zext i32 %r20 to i128
%r123 = shl i128 %r122, 96
%r124 = or i128 %r121, %r123
%r125 = zext i128 %r124 to i160
%r126 = zext i32 %r24 to i160
%r127 = shl i160 %r126, 128
%r128 = or i160 %r125, %r127
%r129 = zext i160 %r128 to i192
%r130 = zext i32 %r28 to i192
%r131 = shl i192 %r130, 160
%r132 = or i192 %r129, %r131
%r133 = zext i192 %r132 to i224
%r134 = zext i32 %r32 to i224
%r135 = shl i224 %r134, 192
%r136 = or i224 %r133, %r135
%r137 = zext i224 %r136 to i256
%r138 = zext i32 %r36 to i256
%r139 = shl i256 %r138, 224
%r140 = or i256 %r137, %r139
%r141 = zext i256 %r140 to i288
%r142 = zext i32 %r40 to i288
%r143 = shl i288 %r142, 256
%r144 = or i288 %r141, %r143
%r145 = zext i288 %r144 to i320
%r146 = zext i32 %r44 to i320
%r147 = shl i320 %r146, 288
%r148 = or i320 %r145, %r147
%r149 = zext i320 %r148 to i352
%r150 = zext i32 %r48 to i352
%r151 = shl i352 %r150, 320
%r152 = or i352 %r149, %r151
%r153 = zext i352 %r152 to i384
%r154 = zext i32 %r52 to i384
%r155 = shl i384 %r154, 352
%r156 = or i384 %r153, %r155
%r157 = zext i384 %r156 to i416
%r158 = zext i32 %r56 to i416
%r159 = shl i416 %r158, 384
%r160 = or i416 %r157, %r159
%r161 = zext i416 %r160 to i448
%r162 = zext i32 %r60 to i448
%r163 = shl i448 %r162, 416
%r164 = or i448 %r161, %r163
%r165 = zext i448 %r112 to i480
%r166 = zext i448 %r164 to i480
%r167 = shl i480 %r166, 32
%r168 = add i480 %r165, %r167
%r170 = bitcast i32* %r2 to i448*
%r171 = load i448, i448* %r170
%r172 = zext i448 %r171 to i480
%r173 = add i480 %r168, %r172
%r174 = trunc i480 %r173 to i448
%r176 = getelementptr i32, i32* %r2, i32 0
%r177 = trunc i448 %r174 to i32
store i32 %r177, i32* %r176
%r178 = lshr i448 %r174, 32
%r180 = getelementptr i32, i32* %r2, i32 1
%r181 = trunc i448 %r178 to i32
store i32 %r181, i32* %r180
%r182 = lshr i448 %r178, 32
%r184 = getelementptr i32, i32* %r2, i32 2
%r185 = trunc i448 %r182 to i32
store i32 %r185, i32* %r184
%r186 = lshr i448 %r182, 32
%r188 = getelementptr i32, i32* %r2, i32 3
%r189 = trunc i448 %r186 to i32
store i32 %r189, i32* %r188
%r190 = lshr i448 %r186, 32
%r192 = getelementptr i32, i32* %r2, i32 4
%r193 = trunc i448 %r190 to i32
store i32 %r193, i32* %r192
%r194 = lshr i448 %r190, 32
%r196 = getelementptr i32, i32* %r2, i32 5
%r197 = trunc i448 %r194 to i32
store i32 %r197, i32* %r196
%r198 = lshr i448 %r194, 32
%r200 = getelementptr i32, i32* %r2, i32 6
%r201 = trunc i448 %r198 to i32
store i32 %r201, i32* %r200
%r202 = lshr i448 %r198, 32
%r204 = getelementptr i32, i32* %r2, i32 7
%r205 = trunc i448 %r202 to i32
store i32 %r205, i32* %r204
%r206 = lshr i448 %r202, 32
%r208 = getelementptr i32, i32* %r2, i32 8
%r209 = trunc i448 %r206 to i32
store i32 %r209, i32* %r208
%r210 = lshr i448 %r206, 32
%r212 = getelementptr i32, i32* %r2, i32 9
%r213 = trunc i448 %r210 to i32
store i32 %r213, i32* %r212
%r214 = lshr i448 %r210, 32
%r216 = getelementptr i32, i32* %r2, i32 10
%r217 = trunc i448 %r214 to i32
store i32 %r217, i32* %r216
%r218 = lshr i448 %r214, 32
%r220 = getelementptr i32, i32* %r2, i32 11
%r221 = trunc i448 %r218 to i32
store i32 %r221, i32* %r220
%r222 = lshr i448 %r218, 32
%r224 = getelementptr i32, i32* %r2, i32 12
%r225 = trunc i448 %r222 to i32
store i32 %r225, i32* %r224
%r226 = lshr i448 %r222, 32
%r228 = getelementptr i32, i32* %r2, i32 13
%r229 = trunc i448 %r226 to i32
store i32 %r229, i32* %r228
%r230 = lshr i480 %r173, 448
%r231 = trunc i480 %r230 to i32
ret i32 %r231
}
define void @mclb_mul14(i32* noalias  %r1, i32* noalias  %r2, i32* noalias  %r3)
{
%r5 = getelementptr i32, i32* %r2, i32 7
%r7 = getelementptr i32, i32* %r3, i32 7
%r9 = getelementptr i32, i32* %r1, i32 14
call void @mclb_mul7(i32* %r1, i32* %r2, i32* %r3)
call void @mclb_mul7(i32* %r9, i32* %r5, i32* %r7)
%r11 = bitcast i32* %r5 to i224*
%r12 = load i224, i224* %r11
%r13 = zext i224 %r12 to i256
%r15 = bitcast i32* %r2 to i224*
%r16 = load i224, i224* %r15
%r17 = zext i224 %r16 to i256
%r19 = bitcast i32* %r7 to i224*
%r20 = load i224, i224* %r19
%r21 = zext i224 %r20 to i256
%r23 = bitcast i32* %r3 to i224*
%r24 = load i224, i224* %r23
%r25 = zext i224 %r24 to i256
%r26 = add i256 %r13, %r17
%r27 = add i256 %r21, %r25
%r29 = alloca i32, i32 14
%r30 = trunc i256 %r26 to i224
%r31 = trunc i256 %r27 to i224
%r32 = lshr i256 %r26, 224
%r33 = trunc i256 %r32 to i1
%r34 = lshr i256 %r27, 224
%r35 = trunc i256 %r34 to i1
%r36 = and i1 %r33, %r35
%r38 = select i1 %r33, i224 %r31, i224 0
%r40 = select i1 %r35, i224 %r30, i224 0
%r42 = alloca i32, i32 7
%r44 = alloca i32, i32 7
%r46 = getelementptr i32, i32* %r42, i32 0
%r47 = trunc i224 %r30 to i32
store i32 %r47, i32* %r46
%r48 = lshr i224 %r30, 32
%r50 = getelementptr i32, i32* %r42, i32 1
%r51 = trunc i224 %r48 to i32
store i32 %r51, i32* %r50
%r52 = lshr i224 %r48, 32
%r54 = getelementptr i32, i32* %r42, i32 2
%r55 = trunc i224 %r52 to i32
store i32 %r55, i32* %r54
%r56 = lshr i224 %r52, 32
%r58 = getelementptr i32, i32* %r42, i32 3
%r59 = trunc i224 %r56 to i32
store i32 %r59, i32* %r58
%r60 = lshr i224 %r56, 32
%r62 = getelementptr i32, i32* %r42, i32 4
%r63 = trunc i224 %r60 to i32
store i32 %r63, i32* %r62
%r64 = lshr i224 %r60, 32
%r66 = getelementptr i32, i32* %r42, i32 5
%r67 = trunc i224 %r64 to i32
store i32 %r67, i32* %r66
%r68 = lshr i224 %r64, 32
%r70 = getelementptr i32, i32* %r42, i32 6
%r71 = trunc i224 %r68 to i32
store i32 %r71, i32* %r70
%r73 = getelementptr i32, i32* %r44, i32 0
%r74 = trunc i224 %r31 to i32
store i32 %r74, i32* %r73
%r75 = lshr i224 %r31, 32
%r77 = getelementptr i32, i32* %r44, i32 1
%r78 = trunc i224 %r75 to i32
store i32 %r78, i32* %r77
%r79 = lshr i224 %r75, 32
%r81 = getelementptr i32, i32* %r44, i32 2
%r82 = trunc i224 %r79 to i32
store i32 %r82, i32* %r81
%r83 = lshr i224 %r79, 32
%r85 = getelementptr i32, i32* %r44, i32 3
%r86 = trunc i224 %r83 to i32
store i32 %r86, i32* %r85
%r87 = lshr i224 %r83, 32
%r89 = getelementptr i32, i32* %r44, i32 4
%r90 = trunc i224 %r87 to i32
store i32 %r90, i32* %r89
%r91 = lshr i224 %r87, 32
%r93 = getelementptr i32, i32* %r44, i32 5
%r94 = trunc i224 %r91 to i32
store i32 %r94, i32* %r93
%r95 = lshr i224 %r91, 32
%r97 = getelementptr i32, i32* %r44, i32 6
%r98 = trunc i224 %r95 to i32
store i32 %r98, i32* %r97
call void @mclb_mul7(i32* %r29, i32* %r42, i32* %r44)
%r100 = bitcast i32* %r29 to i448*
%r101 = load i448, i448* %r100
%r102 = zext i448 %r101 to i480
%r103 = zext i1 %r36 to i480
%r104 = shl i480 %r103, 448
%r105 = or i480 %r102, %r104
%r106 = zext i224 %r38 to i480
%r107 = zext i224 %r40 to i480
%r108 = shl i480 %r106, 224
%r109 = shl i480 %r107, 224
%r110 = add i480 %r105, %r108
%r111 = add i480 %r110, %r109
%r113 = bitcast i32* %r1 to i448*
%r114 = load i448, i448* %r113
%r115 = zext i448 %r114 to i480
%r116 = sub i480 %r111, %r115
%r118 = getelementptr i32, i32* %r1, i32 14
%r120 = bitcast i32* %r118 to i448*
%r121 = load i448, i448* %r120
%r122 = zext i448 %r121 to i480
%r123 = sub i480 %r116, %r122
%r124 = zext i480 %r123 to i672
%r126 = getelementptr i32, i32* %r1, i32 7
%r128 = bitcast i32* %r126 to i672*
%r129 = load i672, i672* %r128
%r130 = add i672 %r124, %r129
%r132 = getelementptr i32, i32* %r1, i32 7
%r134 = getelementptr i32, i32* %r132, i32 0
%r135 = trunc i672 %r130 to i32
store i32 %r135, i32* %r134
%r136 = lshr i672 %r130, 32
%r138 = getelementptr i32, i32* %r132, i32 1
%r139 = trunc i672 %r136 to i32
store i32 %r139, i32* %r138
%r140 = lshr i672 %r136, 32
%r142 = getelementptr i32, i32* %r132, i32 2
%r143 = trunc i672 %r140 to i32
store i32 %r143, i32* %r142
%r144 = lshr i672 %r140, 32
%r146 = getelementptr i32, i32* %r132, i32 3
%r147 = trunc i672 %r144 to i32
store i32 %r147, i32* %r146
%r148 = lshr i672 %r144, 32
%r150 = getelementptr i32, i32* %r132, i32 4
%r151 = trunc i672 %r148 to i32
store i32 %r151, i32* %r150
%r152 = lshr i672 %r148, 32
%r154 = getelementptr i32, i32* %r132, i32 5
%r155 = trunc i672 %r152 to i32
store i32 %r155, i32* %r154
%r156 = lshr i672 %r152, 32
%r158 = getelementptr i32, i32* %r132, i32 6
%r159 = trunc i672 %r156 to i32
store i32 %r159, i32* %r158
%r160 = lshr i672 %r156, 32
%r162 = getelementptr i32, i32* %r132, i32 7
%r163 = trunc i672 %r160 to i32
store i32 %r163, i32* %r162
%r164 = lshr i672 %r160, 32
%r166 = getelementptr i32, i32* %r132, i32 8
%r167 = trunc i672 %r164 to i32
store i32 %r167, i32* %r166
%r168 = lshr i672 %r164, 32
%r170 = getelementptr i32, i32* %r132, i32 9
%r171 = trunc i672 %r168 to i32
store i32 %r171, i32* %r170
%r172 = lshr i672 %r168, 32
%r174 = getelementptr i32, i32* %r132, i32 10
%r175 = trunc i672 %r172 to i32
store i32 %r175, i32* %r174
%r176 = lshr i672 %r172, 32
%r178 = getelementptr i32, i32* %r132, i32 11
%r179 = trunc i672 %r176 to i32
store i32 %r179, i32* %r178
%r180 = lshr i672 %r176, 32
%r182 = getelementptr i32, i32* %r132, i32 12
%r183 = trunc i672 %r180 to i32
store i32 %r183, i32* %r182
%r184 = lshr i672 %r180, 32
%r186 = getelementptr i32, i32* %r132, i32 13
%r187 = trunc i672 %r184 to i32
store i32 %r187, i32* %r186
%r188 = lshr i672 %r184, 32
%r190 = getelementptr i32, i32* %r132, i32 14
%r191 = trunc i672 %r188 to i32
store i32 %r191, i32* %r190
%r192 = lshr i672 %r188, 32
%r194 = getelementptr i32, i32* %r132, i32 15
%r195 = trunc i672 %r192 to i32
store i32 %r195, i32* %r194
%r196 = lshr i672 %r192, 32
%r198 = getelementptr i32, i32* %r132, i32 16
%r199 = trunc i672 %r196 to i32
store i32 %r199, i32* %r198
%r200 = lshr i672 %r196, 32
%r202 = getelementptr i32, i32* %r132, i32 17
%r203 = trunc i672 %r200 to i32
store i32 %r203, i32* %r202
%r204 = lshr i672 %r200, 32
%r206 = getelementptr i32, i32* %r132, i32 18
%r207 = trunc i672 %r204 to i32
store i32 %r207, i32* %r206
%r208 = lshr i672 %r204, 32
%r210 = getelementptr i32, i32* %r132, i32 19
%r211 = trunc i672 %r208 to i32
store i32 %r211, i32* %r210
%r212 = lshr i672 %r208, 32
%r214 = getelementptr i32, i32* %r132, i32 20
%r215 = trunc i672 %r212 to i32
store i32 %r215, i32* %r214
ret void
}
define void @mclb_sqr14(i32* noalias  %r1, i32* noalias  %r2)
{
%r4 = getelementptr i32, i32* %r2, i32 7
%r6 = getelementptr i32, i32* %r1, i32 14
%r8 = alloca i32, i32 14
call void @mclb_mul7(i32* %r8, i32* %r2, i32* %r4)
call void @mclb_sqr7(i32* %r1, i32* %r2)
call void @mclb_sqr7(i32* %r6, i32* %r4)
%r10 = bitcast i32* %r8 to i448*
%r11 = load i448, i448* %r10
%r12 = zext i448 %r11 to i480
%r13 = add i480 %r12, %r12
%r14 = zext i480 %r13 to i672
%r16 = getelementptr i32, i32* %r1, i32 7
%r18 = bitcast i32* %r16 to i672*
%r19 = load i672, i672* %r18
%r20 = add i672 %r19, %r14
%r22 = getelementptr i32, i32* %r16, i32 0
%r23 = trunc i672 %r20 to i32
store i32 %r23, i32* %r22
%r24 = lshr i672 %r20, 32
%r26 = getelementptr i32, i32* %r16, i32 1
%r27 = trunc i672 %r24 to i32
store i32 %r27, i32* %r26
%r28 = lshr i672 %r24, 32
%r30 = getelementptr i32, i32* %r16, i32 2
%r31 = trunc i672 %r28 to i32
store i32 %r31, i32* %r30
%r32 = lshr i672 %r28, 32
%r34 = getelementptr i32, i32* %r16, i32 3
%r35 = trunc i672 %r32 to i32
store i32 %r35, i32* %r34
%r36 = lshr i672 %r32, 32
%r38 = getelementptr i32, i32* %r16, i32 4
%r39 = trunc i672 %r36 to i32
store i32 %r39, i32* %r38
%r40 = lshr i672 %r36, 32
%r42 = getelementptr i32, i32* %r16, i32 5
%r43 = trunc i672 %r40 to i32
store i32 %r43, i32* %r42
%r44 = lshr i672 %r40, 32
%r46 = getelementptr i32, i32* %r16, i32 6
%r47 = trunc i672 %r44 to i32
store i32 %r47, i32* %r46
%r48 = lshr i672 %r44, 32
%r50 = getelementptr i32, i32* %r16, i32 7
%r51 = trunc i672 %r48 to i32
store i32 %r51, i32* %r50
%r52 = lshr i672 %r48, 32
%r54 = getelementptr i32, i32* %r16, i32 8
%r55 = trunc i672 %r52 to i32
store i32 %r55, i32* %r54
%r56 = lshr i672 %r52, 32
%r58 = getelementptr i32, i32* %r16, i32 9
%r59 = trunc i672 %r56 to i32
store i32 %r59, i32* %r58
%r60 = lshr i672 %r56, 32
%r62 = getelementptr i32, i32* %r16, i32 10
%r63 = trunc i672 %r60 to i32
store i32 %r63, i32* %r62
%r64 = lshr i672 %r60, 32
%r66 = getelementptr i32, i32* %r16, i32 11
%r67 = trunc i672 %r64 to i32
store i32 %r67, i32* %r66
%r68 = lshr i672 %r64, 32
%r70 = getelementptr i32, i32* %r16, i32 12
%r71 = trunc i672 %r68 to i32
store i32 %r71, i32* %r70
%r72 = lshr i672 %r68, 32
%r74 = getelementptr i32, i32* %r16, i32 13
%r75 = trunc i672 %r72 to i32
store i32 %r75, i32* %r74
%r76 = lshr i672 %r72, 32
%r78 = getelementptr i32, i32* %r16, i32 14
%r79 = trunc i672 %r76 to i32
store i32 %r79, i32* %r78
%r80 = lshr i672 %r76, 32
%r82 = getelementptr i32, i32* %r16, i32 15
%r83 = trunc i672 %r80 to i32
store i32 %r83, i32* %r82
%r84 = lshr i672 %r80, 32
%r86 = getelementptr i32, i32* %r16, i32 16
%r87 = trunc i672 %r84 to i32
store i32 %r87, i32* %r86
%r88 = lshr i672 %r84, 32
%r90 = getelementptr i32, i32* %r16, i32 17
%r91 = trunc i672 %r88 to i32
store i32 %r91, i32* %r90
%r92 = lshr i672 %r88, 32
%r94 = getelementptr i32, i32* %r16, i32 18
%r95 = trunc i672 %r92 to i32
store i32 %r95, i32* %r94
%r96 = lshr i672 %r92, 32
%r98 = getelementptr i32, i32* %r16, i32 19
%r99 = trunc i672 %r96 to i32
store i32 %r99, i32* %r98
%r100 = lshr i672 %r96, 32
%r102 = getelementptr i32, i32* %r16, i32 20
%r103 = trunc i672 %r100 to i32
store i32 %r103, i32* %r102
ret void
}
define i512 @mulUnit_inner480(i32* noalias  %r2, i32 %r3)
{
%r5 = call i64 @mulPos32x32(i32* %r2, i32 %r3, i32 0)
%r6 = trunc i64 %r5 to i32
%r7 = call i32 @extractHigh32(i64 %r5)
%r9 = call i64 @mulPos32x32(i32* %r2, i32 %r3, i32 1)
%r10 = trunc i64 %r9 to i32
%r11 = call i32 @extractHigh32(i64 %r9)
%r13 = call i64 @mulPos32x32(i32* %r2, i32 %r3, i32 2)
%r14 = trunc i64 %r13 to i32
%r15 = call i32 @extractHigh32(i64 %r13)
%r17 = call i64 @mulPos32x32(i32* %r2, i32 %r3, i32 3)
%r18 = trunc i64 %r17 to i32
%r19 = call i32 @extractHigh32(i64 %r17)
%r21 = call i64 @mulPos32x32(i32* %r2, i32 %r3, i32 4)
%r22 = trunc i64 %r21 to i32
%r23 = call i32 @extractHigh32(i64 %r21)
%r25 = call i64 @mulPos32x32(i32* %r2, i32 %r3, i32 5)
%r26 = trunc i64 %r25 to i32
%r27 = call i32 @extractHigh32(i64 %r25)
%r29 = call i64 @mulPos32x32(i32* %r2, i32 %r3, i32 6)
%r30 = trunc i64 %r29 to i32
%r31 = call i32 @extractHigh32(i64 %r29)
%r33 = call i64 @mulPos32x32(i32* %r2, i32 %r3, i32 7)
%r34 = trunc i64 %r33 to i32
%r35 = call i32 @extractHigh32(i64 %r33)
%r37 = call i64 @mulPos32x32(i32* %r2, i32 %r3, i32 8)
%r38 = trunc i64 %r37 to i32
%r39 = call i32 @extractHigh32(i64 %r37)
%r41 = call i64 @mulPos32x32(i32* %r2, i32 %r3, i32 9)
%r42 = trunc i64 %r41 to i32
%r43 = call i32 @extractHigh32(i64 %r41)
%r45 = call i64 @mulPos32x32(i32* %r2, i32 %r3, i32 10)
%r46 = trunc i64 %r45 to i32
%r47 = call i32 @extractHigh32(i64 %r45)
%r49 = call i64 @mulPos32x32(i32* %r2, i32 %r3, i32 11)
%r50 = trunc i64 %r49 to i32
%r51 = call i32 @extractHigh32(i64 %r49)
%r53 = call i64 @mulPos32x32(i32* %r2, i32 %r3, i32 12)
%r54 = trunc i64 %r53 to i32
%r55 = call i32 @extractHigh32(i64 %r53)
%r57 = call i64 @mulPos32x32(i32* %r2, i32 %r3, i32 13)
%r58 = trunc i64 %r57 to i32
%r59 = call i32 @extractHigh32(i64 %r57)
%r61 = call i64 @mulPos32x32(i32* %r2, i32 %r3, i32 14)
%r62 = trunc i64 %r61 to i32
%r63 = call i32 @extractHigh32(i64 %r61)
%r64 = zext i32 %r6 to i64
%r65 = zext i32 %r10 to i64
%r66 = shl i64 %r65, 32
%r67 = or i64 %r64, %r66
%r68 = zext i64 %r67 to i96
%r69 = zext i32 %r14 to i96
%r70 = shl i96 %r69, 64
%r71 = or i96 %r68, %r70
%r72 = zext i96 %r71 to i128
%r73 = zext i32 %r18 to i128
%r74 = shl i128 %r73, 96
%r75 = or i128 %r72, %r74
%r76 = zext i128 %r75 to i160
%r77 = zext i32 %r22 to i160
%r78 = shl i160 %r77, 128
%r79 = or i160 %r76, %r78
%r80 = zext i160 %r79 to i192
%r81 = zext i32 %r26 to i192
%r82 = shl i192 %r81, 160
%r83 = or i192 %r80, %r82
%r84 = zext i192 %r83 to i224
%r85 = zext i32 %r30 to i224
%r86 = shl i224 %r85, 192
%r87 = or i224 %r84, %r86
%r88 = zext i224 %r87 to i256
%r89 = zext i32 %r34 to i256
%r90 = shl i256 %r89, 224
%r91 = or i256 %r88, %r90
%r92 = zext i256 %r91 to i288
%r93 = zext i32 %r38 to i288
%r94 = shl i288 %r93, 256
%r95 = or i288 %r92, %r94
%r96 = zext i288 %r95 to i320
%r97 = zext i32 %r42 to i320
%r98 = shl i320 %r97, 288
%r99 = or i320 %r96, %r98
%r100 = zext i320 %r99 to i352
%r101 = zext i32 %r46 to i352
%r102 = shl i352 %r101, 320
%r103 = or i352 %r100, %r102
%r104 = zext i352 %r103 to i384
%r105 = zext i32 %r50 to i384
%r106 = shl i384 %r105, 352
%r107 = or i384 %r104, %r106
%r108 = zext i384 %r107 to i416
%r109 = zext i32 %r54 to i416
%r110 = shl i416 %r109, 384
%r111 = or i416 %r108, %r110
%r112 = zext i416 %r111 to i448
%r113 = zext i32 %r58 to i448
%r114 = shl i448 %r113, 416
%r115 = or i448 %r112, %r114
%r116 = zext i448 %r115 to i480
%r117 = zext i32 %r62 to i480
%r118 = shl i480 %r117, 448
%r119 = or i480 %r116, %r118
%r120 = zext i32 %r7 to i64
%r121 = zext i32 %r11 to i64
%r122 = shl i64 %r121, 32
%r123 = or i64 %r120, %r122
%r124 = zext i64 %r123 to i96
%r125 = zext i32 %r15 to i96
%r126 = shl i96 %r125, 64
%r127 = or i96 %r124, %r126
%r128 = zext i96 %r127 to i128
%r129 = zext i32 %r19 to i128
%r130 = shl i128 %r129, 96
%r131 = or i128 %r128, %r130
%r132 = zext i128 %r131 to i160
%r133 = zext i32 %r23 to i160
%r134 = shl i160 %r133, 128
%r135 = or i160 %r132, %r134
%r136 = zext i160 %r135 to i192
%r137 = zext i32 %r27 to i192
%r138 = shl i192 %r137, 160
%r139 = or i192 %r136, %r138
%r140 = zext i192 %r139 to i224
%r141 = zext i32 %r31 to i224
%r142 = shl i224 %r141, 192
%r143 = or i224 %r140, %r142
%r144 = zext i224 %r143 to i256
%r145 = zext i32 %r35 to i256
%r146 = shl i256 %r145, 224
%r147 = or i256 %r144, %r146
%r148 = zext i256 %r147 to i288
%r149 = zext i32 %r39 to i288
%r150 = shl i288 %r149, 256
%r151 = or i288 %r148, %r150
%r152 = zext i288 %r151 to i320
%r153 = zext i32 %r43 to i320
%r154 = shl i320 %r153, 288
%r155 = or i320 %r152, %r154
%r156 = zext i320 %r155 to i352
%r157 = zext i32 %r47 to i352
%r158 = shl i352 %r157, 320
%r159 = or i352 %r156, %r158
%r160 = zext i352 %r159 to i384
%r161 = zext i32 %r51 to i384
%r162 = shl i384 %r161, 352
%r163 = or i384 %r160, %r162
%r164 = zext i384 %r163 to i416
%r165 = zext i32 %r55 to i416
%r166 = shl i416 %r165, 384
%r167 = or i416 %r164, %r166
%r168 = zext i416 %r167 to i448
%r169 = zext i32 %r59 to i448
%r170 = shl i448 %r169, 416
%r171 = or i448 %r168, %r170
%r172 = zext i448 %r171 to i480
%r173 = zext i32 %r63 to i480
%r174 = shl i480 %r173, 448
%r175 = or i480 %r172, %r174
%r176 = zext i480 %r119 to i512
%r177 = zext i480 %r175 to i512
%r178 = shl i512 %r177, 32
%r179 = add i512 %r176, %r178
ret i512 %r179
}
define i32 @mclb_mulUnit15(i32* noalias  %r2, i32* noalias  %r3, i32 %r4)
{
%r5 = call i512 @mulUnit_inner480(i32* %r3, i32 %r4)
%r6 = trunc i512 %r5 to i480
%r8 = getelementptr i32, i32* %r2, i32 0
%r9 = trunc i480 %r6 to i32
store i32 %r9, i32* %r8
%r10 = lshr i480 %r6, 32
%r12 = getelementptr i32, i32* %r2, i32 1
%r13 = trunc i480 %r10 to i32
store i32 %r13, i32* %r12
%r14 = lshr i480 %r10, 32
%r16 = getelementptr i32, i32* %r2, i32 2
%r17 = trunc i480 %r14 to i32
store i32 %r17, i32* %r16
%r18 = lshr i480 %r14, 32
%r20 = getelementptr i32, i32* %r2, i32 3
%r21 = trunc i480 %r18 to i32
store i32 %r21, i32* %r20
%r22 = lshr i480 %r18, 32
%r24 = getelementptr i32, i32* %r2, i32 4
%r25 = trunc i480 %r22 to i32
store i32 %r25, i32* %r24
%r26 = lshr i480 %r22, 32
%r28 = getelementptr i32, i32* %r2, i32 5
%r29 = trunc i480 %r26 to i32
store i32 %r29, i32* %r28
%r30 = lshr i480 %r26, 32
%r32 = getelementptr i32, i32* %r2, i32 6
%r33 = trunc i480 %r30 to i32
store i32 %r33, i32* %r32
%r34 = lshr i480 %r30, 32
%r36 = getelementptr i32, i32* %r2, i32 7
%r37 = trunc i480 %r34 to i32
store i32 %r37, i32* %r36
%r38 = lshr i480 %r34, 32
%r40 = getelementptr i32, i32* %r2, i32 8
%r41 = trunc i480 %r38 to i32
store i32 %r41, i32* %r40
%r42 = lshr i480 %r38, 32
%r44 = getelementptr i32, i32* %r2, i32 9
%r45 = trunc i480 %r42 to i32
store i32 %r45, i32* %r44
%r46 = lshr i480 %r42, 32
%r48 = getelementptr i32, i32* %r2, i32 10
%r49 = trunc i480 %r46 to i32
store i32 %r49, i32* %r48
%r50 = lshr i480 %r46, 32
%r52 = getelementptr i32, i32* %r2, i32 11
%r53 = trunc i480 %r50 to i32
store i32 %r53, i32* %r52
%r54 = lshr i480 %r50, 32
%r56 = getelementptr i32, i32* %r2, i32 12
%r57 = trunc i480 %r54 to i32
store i32 %r57, i32* %r56
%r58 = lshr i480 %r54, 32
%r60 = getelementptr i32, i32* %r2, i32 13
%r61 = trunc i480 %r58 to i32
store i32 %r61, i32* %r60
%r62 = lshr i480 %r58, 32
%r64 = getelementptr i32, i32* %r2, i32 14
%r65 = trunc i480 %r62 to i32
store i32 %r65, i32* %r64
%r66 = lshr i512 %r5, 480
%r67 = trunc i512 %r66 to i32
ret i32 %r67
}
define i32 @mclb_mulUnitAdd15(i32* noalias  %r2, i32* noalias  %r3, i32 %r4)
{
%r6 = call i64 @mulPos32x32(i32* %r3, i32 %r4, i32 0)
%r7 = trunc i64 %r6 to i32
%r8 = call i32 @extractHigh32(i64 %r6)
%r10 = call i64 @mulPos32x32(i32* %r3, i32 %r4, i32 1)
%r11 = trunc i64 %r10 to i32
%r12 = call i32 @extractHigh32(i64 %r10)
%r14 = call i64 @mulPos32x32(i32* %r3, i32 %r4, i32 2)
%r15 = trunc i64 %r14 to i32
%r16 = call i32 @extractHigh32(i64 %r14)
%r18 = call i64 @mulPos32x32(i32* %r3, i32 %r4, i32 3)
%r19 = trunc i64 %r18 to i32
%r20 = call i32 @extractHigh32(i64 %r18)
%r22 = call i64 @mulPos32x32(i32* %r3, i32 %r4, i32 4)
%r23 = trunc i64 %r22 to i32
%r24 = call i32 @extractHigh32(i64 %r22)
%r26 = call i64 @mulPos32x32(i32* %r3, i32 %r4, i32 5)
%r27 = trunc i64 %r26 to i32
%r28 = call i32 @extractHigh32(i64 %r26)
%r30 = call i64 @mulPos32x32(i32* %r3, i32 %r4, i32 6)
%r31 = trunc i64 %r30 to i32
%r32 = call i32 @extractHigh32(i64 %r30)
%r34 = call i64 @mulPos32x32(i32* %r3, i32 %r4, i32 7)
%r35 = trunc i64 %r34 to i32
%r36 = call i32 @extractHigh32(i64 %r34)
%r38 = call i64 @mulPos32x32(i32* %r3, i32 %r4, i32 8)
%r39 = trunc i64 %r38 to i32
%r40 = call i32 @extractHigh32(i64 %r38)
%r42 = call i64 @mulPos32x32(i32* %r3, i32 %r4, i32 9)
%r43 = trunc i64 %r42 to i32
%r44 = call i32 @extractHigh32(i64 %r42)
%r46 = call i64 @mulPos32x32(i32* %r3, i32 %r4, i32 10)
%r47 = trunc i64 %r46 to i32
%r48 = call i32 @extractHigh32(i64 %r46)
%r50 = call i64 @mulPos32x32(i32* %r3, i32 %r4, i32 11)
%r51 = trunc i64 %r50 to i32
%r52 = call i32 @extractHigh32(i64 %r50)
%r54 = call i64 @mulPos32x32(i32* %r3, i32 %r4, i32 12)
%r55 = trunc i64 %r54 to i32
%r56 = call i32 @extractHigh32(i64 %r54)
%r58 = call i64 @mulPos32x32(i32* %r3, i32 %r4, i32 13)
%r59 = trunc i64 %r58 to i32
%r60 = call i32 @extractHigh32(i64 %r58)
%r62 = call i64 @mulPos32x32(i32* %r3, i32 %r4, i32 14)
%r63 = trunc i64 %r62 to i32
%r64 = call i32 @extractHigh32(i64 %r62)
%r65 = zext i32 %r7 to i64
%r66 = zext i32 %r11 to i64
%r67 = shl i64 %r66, 32
%r68 = or i64 %r65, %r67
%r69 = zext i64 %r68 to i96
%r70 = zext i32 %r15 to i96
%r71 = shl i96 %r70, 64
%r72 = or i96 %r69, %r71
%r73 = zext i96 %r72 to i128
%r74 = zext i32 %r19 to i128
%r75 = shl i128 %r74, 96
%r76 = or i128 %r73, %r75
%r77 = zext i128 %r76 to i160
%r78 = zext i32 %r23 to i160
%r79 = shl i160 %r78, 128
%r80 = or i160 %r77, %r79
%r81 = zext i160 %r80 to i192
%r82 = zext i32 %r27 to i192
%r83 = shl i192 %r82, 160
%r84 = or i192 %r81, %r83
%r85 = zext i192 %r84 to i224
%r86 = zext i32 %r31 to i224
%r87 = shl i224 %r86, 192
%r88 = or i224 %r85, %r87
%r89 = zext i224 %r88 to i256
%r90 = zext i32 %r35 to i256
%r91 = shl i256 %r90, 224
%r92 = or i256 %r89, %r91
%r93 = zext i256 %r92 to i288
%r94 = zext i32 %r39 to i288
%r95 = shl i288 %r94, 256
%r96 = or i288 %r93, %r95
%r97 = zext i288 %r96 to i320
%r98 = zext i32 %r43 to i320
%r99 = shl i320 %r98, 288
%r100 = or i320 %r97, %r99
%r101 = zext i320 %r100 to i352
%r102 = zext i32 %r47 to i352
%r103 = shl i352 %r102, 320
%r104 = or i352 %r101, %r103
%r105 = zext i352 %r104 to i384
%r106 = zext i32 %r51 to i384
%r107 = shl i384 %r106, 352
%r108 = or i384 %r105, %r107
%r109 = zext i384 %r108 to i416
%r110 = zext i32 %r55 to i416
%r111 = shl i416 %r110, 384
%r112 = or i416 %r109, %r111
%r113 = zext i416 %r112 to i448
%r114 = zext i32 %r59 to i448
%r115 = shl i448 %r114, 416
%r116 = or i448 %r113, %r115
%r117 = zext i448 %r116 to i480
%r118 = zext i32 %r63 to i480
%r119 = shl i480 %r118, 448
%r120 = or i480 %r117, %r119
%r121 = zext i32 %r8 to i64
%r122 = zext i32 %r12 to i64
%r123 = shl i64 %r122, 32
%r124 = or i64 %r121, %r123
%r125 = zext i64 %r124 to i96
%r126 = zext i32 %r16 to i96
%r127 = shl i96 %r126, 64
%r128 = or i96 %r125, %r127
%r129 = zext i96 %r128 to i128
%r130 = zext i32 %r20 to i128
%r131 = shl i128 %r130, 96
%r132 = or i128 %r129, %r131
%r133 = zext i128 %r132 to i160
%r134 = zext i32 %r24 to i160
%r135 = shl i160 %r134, 128
%r136 = or i160 %r133, %r135
%r137 = zext i160 %r136 to i192
%r138 = zext i32 %r28 to i192
%r139 = shl i192 %r138, 160
%r140 = or i192 %r137, %r139
%r141 = zext i192 %r140 to i224
%r142 = zext i32 %r32 to i224
%r143 = shl i224 %r142, 192
%r144 = or i224 %r141, %r143
%r145 = zext i224 %r144 to i256
%r146 = zext i32 %r36 to i256
%r147 = shl i256 %r146, 224
%r148 = or i256 %r145, %r147
%r149 = zext i256 %r148 to i288
%r150 = zext i32 %r40 to i288
%r151 = shl i288 %r150, 256
%r152 = or i288 %r149, %r151
%r153 = zext i288 %r152 to i320
%r154 = zext i32 %r44 to i320
%r155 = shl i320 %r154, 288
%r156 = or i320 %r153, %r155
%r157 = zext i320 %r156 to i352
%r158 = zext i32 %r48 to i352
%r159 = shl i352 %r158, 320
%r160 = or i352 %r157, %r159
%r161 = zext i352 %r160 to i384
%r162 = zext i32 %r52 to i384
%r163 = shl i384 %r162, 352
%r164 = or i384 %r161, %r163
%r165 = zext i384 %r164 to i416
%r166 = zext i32 %r56 to i416
%r167 = shl i416 %r166, 384
%r168 = or i416 %r165, %r167
%r169 = zext i416 %r168 to i448
%r170 = zext i32 %r60 to i448
%r171 = shl i448 %r170, 416
%r172 = or i448 %r169, %r171
%r173 = zext i448 %r172 to i480
%r174 = zext i32 %r64 to i480
%r175 = shl i480 %r174, 448
%r176 = or i480 %r173, %r175
%r177 = zext i480 %r120 to i512
%r178 = zext i480 %r176 to i512
%r179 = shl i512 %r178, 32
%r180 = add i512 %r177, %r179
%r182 = bitcast i32* %r2 to i480*
%r183 = load i480, i480* %r182
%r184 = zext i480 %r183 to i512
%r185 = add i512 %r180, %r184
%r186 = trunc i512 %r185 to i480
%r188 = getelementptr i32, i32* %r2, i32 0
%r189 = trunc i480 %r186 to i32
store i32 %r189, i32* %r188
%r190 = lshr i480 %r186, 32
%r192 = getelementptr i32, i32* %r2, i32 1
%r193 = trunc i480 %r190 to i32
store i32 %r193, i32* %r192
%r194 = lshr i480 %r190, 32
%r196 = getelementptr i32, i32* %r2, i32 2
%r197 = trunc i480 %r194 to i32
store i32 %r197, i32* %r196
%r198 = lshr i480 %r194, 32
%r200 = getelementptr i32, i32* %r2, i32 3
%r201 = trunc i480 %r198 to i32
store i32 %r201, i32* %r200
%r202 = lshr i480 %r198, 32
%r204 = getelementptr i32, i32* %r2, i32 4
%r205 = trunc i480 %r202 to i32
store i32 %r205, i32* %r204
%r206 = lshr i480 %r202, 32
%r208 = getelementptr i32, i32* %r2, i32 5
%r209 = trunc i480 %r206 to i32
store i32 %r209, i32* %r208
%r210 = lshr i480 %r206, 32
%r212 = getelementptr i32, i32* %r2, i32 6
%r213 = trunc i480 %r210 to i32
store i32 %r213, i32* %r212
%r214 = lshr i480 %r210, 32
%r216 = getelementptr i32, i32* %r2, i32 7
%r217 = trunc i480 %r214 to i32
store i32 %r217, i32* %r216
%r218 = lshr i480 %r214, 32
%r220 = getelementptr i32, i32* %r2, i32 8
%r221 = trunc i480 %r218 to i32
store i32 %r221, i32* %r220
%r222 = lshr i480 %r218, 32
%r224 = getelementptr i32, i32* %r2, i32 9
%r225 = trunc i480 %r222 to i32
store i32 %r225, i32* %r224
%r226 = lshr i480 %r222, 32
%r228 = getelementptr i32, i32* %r2, i32 10
%r229 = trunc i480 %r226 to i32
store i32 %r229, i32* %r228
%r230 = lshr i480 %r226, 32
%r232 = getelementptr i32, i32* %r2, i32 11
%r233 = trunc i480 %r230 to i32
store i32 %r233, i32* %r232
%r234 = lshr i480 %r230, 32
%r236 = getelementptr i32, i32* %r2, i32 12
%r237 = trunc i480 %r234 to i32
store i32 %r237, i32* %r236
%r238 = lshr i480 %r234, 32
%r240 = getelementptr i32, i32* %r2, i32 13
%r241 = trunc i480 %r238 to i32
store i32 %r241, i32* %r240
%r242 = lshr i480 %r238, 32
%r244 = getelementptr i32, i32* %r2, i32 14
%r245 = trunc i480 %r242 to i32
store i32 %r245, i32* %r244
%r246 = lshr i512 %r185, 480
%r247 = trunc i512 %r246 to i32
ret i32 %r247
}
define void @mclb_mul15(i32* noalias  %r1, i32* noalias  %r2, i32* noalias  %r3)
{
%r4 = load i32, i32* %r3
%r5 = call i512 @mulUnit_inner480(i32* %r2, i32 %r4)
%r6 = trunc i512 %r5 to i32
store i32 %r6, i32* %r1
%r7 = lshr i512 %r5, 32
%r9 = getelementptr i32, i32* %r3, i32 1
%r10 = load i32, i32* %r9
%r11 = call i512 @mulUnit_inner480(i32* %r2, i32 %r10)
%r12 = add i512 %r7, %r11
%r13 = trunc i512 %r12 to i32
%r15 = getelementptr i32, i32* %r1, i32 1
store i32 %r13, i32* %r15
%r16 = lshr i512 %r12, 32
%r18 = getelementptr i32, i32* %r3, i32 2
%r19 = load i32, i32* %r18
%r20 = call i512 @mulUnit_inner480(i32* %r2, i32 %r19)
%r21 = add i512 %r16, %r20
%r22 = trunc i512 %r21 to i32
%r24 = getelementptr i32, i32* %r1, i32 2
store i32 %r22, i32* %r24
%r25 = lshr i512 %r21, 32
%r27 = getelementptr i32, i32* %r3, i32 3
%r28 = load i32, i32* %r27
%r29 = call i512 @mulUnit_inner480(i32* %r2, i32 %r28)
%r30 = add i512 %r25, %r29
%r31 = trunc i512 %r30 to i32
%r33 = getelementptr i32, i32* %r1, i32 3
store i32 %r31, i32* %r33
%r34 = lshr i512 %r30, 32
%r36 = getelementptr i32, i32* %r3, i32 4
%r37 = load i32, i32* %r36
%r38 = call i512 @mulUnit_inner480(i32* %r2, i32 %r37)
%r39 = add i512 %r34, %r38
%r40 = trunc i512 %r39 to i32
%r42 = getelementptr i32, i32* %r1, i32 4
store i32 %r40, i32* %r42
%r43 = lshr i512 %r39, 32
%r45 = getelementptr i32, i32* %r3, i32 5
%r46 = load i32, i32* %r45
%r47 = call i512 @mulUnit_inner480(i32* %r2, i32 %r46)
%r48 = add i512 %r43, %r47
%r49 = trunc i512 %r48 to i32
%r51 = getelementptr i32, i32* %r1, i32 5
store i32 %r49, i32* %r51
%r52 = lshr i512 %r48, 32
%r54 = getelementptr i32, i32* %r3, i32 6
%r55 = load i32, i32* %r54
%r56 = call i512 @mulUnit_inner480(i32* %r2, i32 %r55)
%r57 = add i512 %r52, %r56
%r58 = trunc i512 %r57 to i32
%r60 = getelementptr i32, i32* %r1, i32 6
store i32 %r58, i32* %r60
%r61 = lshr i512 %r57, 32
%r63 = getelementptr i32, i32* %r3, i32 7
%r64 = load i32, i32* %r63
%r65 = call i512 @mulUnit_inner480(i32* %r2, i32 %r64)
%r66 = add i512 %r61, %r65
%r67 = trunc i512 %r66 to i32
%r69 = getelementptr i32, i32* %r1, i32 7
store i32 %r67, i32* %r69
%r70 = lshr i512 %r66, 32
%r72 = getelementptr i32, i32* %r3, i32 8
%r73 = load i32, i32* %r72
%r74 = call i512 @mulUnit_inner480(i32* %r2, i32 %r73)
%r75 = add i512 %r70, %r74
%r76 = trunc i512 %r75 to i32
%r78 = getelementptr i32, i32* %r1, i32 8
store i32 %r76, i32* %r78
%r79 = lshr i512 %r75, 32
%r81 = getelementptr i32, i32* %r3, i32 9
%r82 = load i32, i32* %r81
%r83 = call i512 @mulUnit_inner480(i32* %r2, i32 %r82)
%r84 = add i512 %r79, %r83
%r85 = trunc i512 %r84 to i32
%r87 = getelementptr i32, i32* %r1, i32 9
store i32 %r85, i32* %r87
%r88 = lshr i512 %r84, 32
%r90 = getelementptr i32, i32* %r3, i32 10
%r91 = load i32, i32* %r90
%r92 = call i512 @mulUnit_inner480(i32* %r2, i32 %r91)
%r93 = add i512 %r88, %r92
%r94 = trunc i512 %r93 to i32
%r96 = getelementptr i32, i32* %r1, i32 10
store i32 %r94, i32* %r96
%r97 = lshr i512 %r93, 32
%r99 = getelementptr i32, i32* %r3, i32 11
%r100 = load i32, i32* %r99
%r101 = call i512 @mulUnit_inner480(i32* %r2, i32 %r100)
%r102 = add i512 %r97, %r101
%r103 = trunc i512 %r102 to i32
%r105 = getelementptr i32, i32* %r1, i32 11
store i32 %r103, i32* %r105
%r106 = lshr i512 %r102, 32
%r108 = getelementptr i32, i32* %r3, i32 12
%r109 = load i32, i32* %r108
%r110 = call i512 @mulUnit_inner480(i32* %r2, i32 %r109)
%r111 = add i512 %r106, %r110
%r112 = trunc i512 %r111 to i32
%r114 = getelementptr i32, i32* %r1, i32 12
store i32 %r112, i32* %r114
%r115 = lshr i512 %r111, 32
%r117 = getelementptr i32, i32* %r3, i32 13
%r118 = load i32, i32* %r117
%r119 = call i512 @mulUnit_inner480(i32* %r2, i32 %r118)
%r120 = add i512 %r115, %r119
%r121 = trunc i512 %r120 to i32
%r123 = getelementptr i32, i32* %r1, i32 13
store i32 %r121, i32* %r123
%r124 = lshr i512 %r120, 32
%r126 = getelementptr i32, i32* %r3, i32 14
%r127 = load i32, i32* %r126
%r128 = call i512 @mulUnit_inner480(i32* %r2, i32 %r127)
%r129 = add i512 %r124, %r128
%r131 = getelementptr i32, i32* %r1, i32 14
%r133 = getelementptr i32, i32* %r131, i32 0
%r134 = trunc i512 %r129 to i32
store i32 %r134, i32* %r133
%r135 = lshr i512 %r129, 32
%r137 = getelementptr i32, i32* %r131, i32 1
%r138 = trunc i512 %r135 to i32
store i32 %r138, i32* %r137
%r139 = lshr i512 %r135, 32
%r141 = getelementptr i32, i32* %r131, i32 2
%r142 = trunc i512 %r139 to i32
store i32 %r142, i32* %r141
%r143 = lshr i512 %r139, 32
%r145 = getelementptr i32, i32* %r131, i32 3
%r146 = trunc i512 %r143 to i32
store i32 %r146, i32* %r145
%r147 = lshr i512 %r143, 32
%r149 = getelementptr i32, i32* %r131, i32 4
%r150 = trunc i512 %r147 to i32
store i32 %r150, i32* %r149
%r151 = lshr i512 %r147, 32
%r153 = getelementptr i32, i32* %r131, i32 5
%r154 = trunc i512 %r151 to i32
store i32 %r154, i32* %r153
%r155 = lshr i512 %r151, 32
%r157 = getelementptr i32, i32* %r131, i32 6
%r158 = trunc i512 %r155 to i32
store i32 %r158, i32* %r157
%r159 = lshr i512 %r155, 32
%r161 = getelementptr i32, i32* %r131, i32 7
%r162 = trunc i512 %r159 to i32
store i32 %r162, i32* %r161
%r163 = lshr i512 %r159, 32
%r165 = getelementptr i32, i32* %r131, i32 8
%r166 = trunc i512 %r163 to i32
store i32 %r166, i32* %r165
%r167 = lshr i512 %r163, 32
%r169 = getelementptr i32, i32* %r131, i32 9
%r170 = trunc i512 %r167 to i32
store i32 %r170, i32* %r169
%r171 = lshr i512 %r167, 32
%r173 = getelementptr i32, i32* %r131, i32 10
%r174 = trunc i512 %r171 to i32
store i32 %r174, i32* %r173
%r175 = lshr i512 %r171, 32
%r177 = getelementptr i32, i32* %r131, i32 11
%r178 = trunc i512 %r175 to i32
store i32 %r178, i32* %r177
%r179 = lshr i512 %r175, 32
%r181 = getelementptr i32, i32* %r131, i32 12
%r182 = trunc i512 %r179 to i32
store i32 %r182, i32* %r181
%r183 = lshr i512 %r179, 32
%r185 = getelementptr i32, i32* %r131, i32 13
%r186 = trunc i512 %r183 to i32
store i32 %r186, i32* %r185
%r187 = lshr i512 %r183, 32
%r189 = getelementptr i32, i32* %r131, i32 14
%r190 = trunc i512 %r187 to i32
store i32 %r190, i32* %r189
%r191 = lshr i512 %r187, 32
%r193 = getelementptr i32, i32* %r131, i32 15
%r194 = trunc i512 %r191 to i32
store i32 %r194, i32* %r193
ret void
}
define void @mclb_sqr15(i32* noalias  %r1, i32* noalias  %r2)
{
%r3 = load i32, i32* %r2
%r4 = call i64 @mul32x32L(i32 %r3, i32 %r3)
%r5 = trunc i64 %r4 to i32
store i32 %r5, i32* %r1
%r6 = lshr i64 %r4, 32
%r8 = getelementptr i32, i32* %r2, i32 14
%r9 = load i32, i32* %r8
%r10 = call i64 @mul32x32L(i32 %r3, i32 %r9)
%r11 = load i32, i32* %r2
%r13 = getelementptr i32, i32* %r2, i32 13
%r14 = load i32, i32* %r13
%r15 = call i64 @mul32x32L(i32 %r11, i32 %r14)
%r17 = getelementptr i32, i32* %r2, i32 1
%r18 = load i32, i32* %r17
%r20 = getelementptr i32, i32* %r2, i32 14
%r21 = load i32, i32* %r20
%r22 = call i64 @mul32x32L(i32 %r18, i32 %r21)
%r23 = zext i64 %r15 to i128
%r24 = zext i64 %r22 to i128
%r25 = shl i128 %r24, 64
%r26 = or i128 %r23, %r25
%r27 = zext i64 %r10 to i128
%r28 = shl i128 %r27, 32
%r29 = add i128 %r28, %r26
%r30 = load i32, i32* %r2
%r32 = getelementptr i32, i32* %r2, i32 12
%r33 = load i32, i32* %r32
%r34 = call i64 @mul32x32L(i32 %r30, i32 %r33)
%r36 = getelementptr i32, i32* %r2, i32 1
%r37 = load i32, i32* %r36
%r39 = getelementptr i32, i32* %r2, i32 13
%r40 = load i32, i32* %r39
%r41 = call i64 @mul32x32L(i32 %r37, i32 %r40)
%r42 = zext i64 %r34 to i128
%r43 = zext i64 %r41 to i128
%r44 = shl i128 %r43, 64
%r45 = or i128 %r42, %r44
%r47 = getelementptr i32, i32* %r2, i32 2
%r48 = load i32, i32* %r47
%r50 = getelementptr i32, i32* %r2, i32 14
%r51 = load i32, i32* %r50
%r52 = call i64 @mul32x32L(i32 %r48, i32 %r51)
%r53 = zext i128 %r45 to i192
%r54 = zext i64 %r52 to i192
%r55 = shl i192 %r54, 128
%r56 = or i192 %r53, %r55
%r57 = zext i128 %r29 to i192
%r58 = shl i192 %r57, 32
%r59 = add i192 %r58, %r56
%r60 = load i32, i32* %r2
%r62 = getelementptr i32, i32* %r2, i32 11
%r63 = load i32, i32* %r62
%r64 = call i64 @mul32x32L(i32 %r60, i32 %r63)
%r66 = getelementptr i32, i32* %r2, i32 1
%r67 = load i32, i32* %r66
%r69 = getelementptr i32, i32* %r2, i32 12
%r70 = load i32, i32* %r69
%r71 = call i64 @mul32x32L(i32 %r67, i32 %r70)
%r72 = zext i64 %r64 to i128
%r73 = zext i64 %r71 to i128
%r74 = shl i128 %r73, 64
%r75 = or i128 %r72, %r74
%r77 = getelementptr i32, i32* %r2, i32 2
%r78 = load i32, i32* %r77
%r80 = getelementptr i32, i32* %r2, i32 13
%r81 = load i32, i32* %r80
%r82 = call i64 @mul32x32L(i32 %r78, i32 %r81)
%r83 = zext i128 %r75 to i192
%r84 = zext i64 %r82 to i192
%r85 = shl i192 %r84, 128
%r86 = or i192 %r83, %r85
%r88 = getelementptr i32, i32* %r2, i32 3
%r89 = load i32, i32* %r88
%r91 = getelementptr i32, i32* %r2, i32 14
%r92 = load i32, i32* %r91
%r93 = call i64 @mul32x32L(i32 %r89, i32 %r92)
%r94 = zext i192 %r86 to i256
%r95 = zext i64 %r93 to i256
%r96 = shl i256 %r95, 192
%r97 = or i256 %r94, %r96
%r98 = zext i192 %r59 to i256
%r99 = shl i256 %r98, 32
%r100 = add i256 %r99, %r97
%r101 = load i32, i32* %r2
%r103 = getelementptr i32, i32* %r2, i32 10
%r104 = load i32, i32* %r103
%r105 = call i64 @mul32x32L(i32 %r101, i32 %r104)
%r107 = getelementptr i32, i32* %r2, i32 1
%r108 = load i32, i32* %r107
%r110 = getelementptr i32, i32* %r2, i32 11
%r111 = load i32, i32* %r110
%r112 = call i64 @mul32x32L(i32 %r108, i32 %r111)
%r113 = zext i64 %r105 to i128
%r114 = zext i64 %r112 to i128
%r115 = shl i128 %r114, 64
%r116 = or i128 %r113, %r115
%r118 = getelementptr i32, i32* %r2, i32 2
%r119 = load i32, i32* %r118
%r121 = getelementptr i32, i32* %r2, i32 12
%r122 = load i32, i32* %r121
%r123 = call i64 @mul32x32L(i32 %r119, i32 %r122)
%r124 = zext i128 %r116 to i192
%r125 = zext i64 %r123 to i192
%r126 = shl i192 %r125, 128
%r127 = or i192 %r124, %r126
%r129 = getelementptr i32, i32* %r2, i32 3
%r130 = load i32, i32* %r129
%r132 = getelementptr i32, i32* %r2, i32 13
%r133 = load i32, i32* %r132
%r134 = call i64 @mul32x32L(i32 %r130, i32 %r133)
%r135 = zext i192 %r127 to i256
%r136 = zext i64 %r134 to i256
%r137 = shl i256 %r136, 192
%r138 = or i256 %r135, %r137
%r140 = getelementptr i32, i32* %r2, i32 4
%r141 = load i32, i32* %r140
%r143 = getelementptr i32, i32* %r2, i32 14
%r144 = load i32, i32* %r143
%r145 = call i64 @mul32x32L(i32 %r141, i32 %r144)
%r146 = zext i256 %r138 to i320
%r147 = zext i64 %r145 to i320
%r148 = shl i320 %r147, 256
%r149 = or i320 %r146, %r148
%r150 = zext i256 %r100 to i320
%r151 = shl i320 %r150, 32
%r152 = add i320 %r151, %r149
%r153 = load i32, i32* %r2
%r155 = getelementptr i32, i32* %r2, i32 9
%r156 = load i32, i32* %r155
%r157 = call i64 @mul32x32L(i32 %r153, i32 %r156)
%r159 = getelementptr i32, i32* %r2, i32 1
%r160 = load i32, i32* %r159
%r162 = getelementptr i32, i32* %r2, i32 10
%r163 = load i32, i32* %r162
%r164 = call i64 @mul32x32L(i32 %r160, i32 %r163)
%r165 = zext i64 %r157 to i128
%r166 = zext i64 %r164 to i128
%r167 = shl i128 %r166, 64
%r168 = or i128 %r165, %r167
%r170 = getelementptr i32, i32* %r2, i32 2
%r171 = load i32, i32* %r170
%r173 = getelementptr i32, i32* %r2, i32 11
%r174 = load i32, i32* %r173
%r175 = call i64 @mul32x32L(i32 %r171, i32 %r174)
%r176 = zext i128 %r168 to i192
%r177 = zext i64 %r175 to i192
%r178 = shl i192 %r177, 128
%r179 = or i192 %r176, %r178
%r181 = getelementptr i32, i32* %r2, i32 3
%r182 = load i32, i32* %r181
%r184 = getelementptr i32, i32* %r2, i32 12
%r185 = load i32, i32* %r184
%r186 = call i64 @mul32x32L(i32 %r182, i32 %r185)
%r187 = zext i192 %r179 to i256
%r188 = zext i64 %r186 to i256
%r189 = shl i256 %r188, 192
%r190 = or i256 %r187, %r189
%r192 = getelementptr i32, i32* %r2, i32 4
%r193 = load i32, i32* %r192
%r195 = getelementptr i32, i32* %r2, i32 13
%r196 = load i32, i32* %r195
%r197 = call i64 @mul32x32L(i32 %r193, i32 %r196)
%r198 = zext i256 %r190 to i320
%r199 = zext i64 %r197 to i320
%r200 = shl i320 %r199, 256
%r201 = or i320 %r198, %r200
%r203 = getelementptr i32, i32* %r2, i32 5
%r204 = load i32, i32* %r203
%r206 = getelementptr i32, i32* %r2, i32 14
%r207 = load i32, i32* %r206
%r208 = call i64 @mul32x32L(i32 %r204, i32 %r207)
%r209 = zext i320 %r201 to i384
%r210 = zext i64 %r208 to i384
%r211 = shl i384 %r210, 320
%r212 = or i384 %r209, %r211
%r213 = zext i320 %r152 to i384
%r214 = shl i384 %r213, 32
%r215 = add i384 %r214, %r212
%r216 = load i32, i32* %r2
%r218 = getelementptr i32, i32* %r2, i32 8
%r219 = load i32, i32* %r218
%r220 = call i64 @mul32x32L(i32 %r216, i32 %r219)
%r222 = getelementptr i32, i32* %r2, i32 1
%r223 = load i32, i32* %r222
%r225 = getelementptr i32, i32* %r2, i32 9
%r226 = load i32, i32* %r225
%r227 = call i64 @mul32x32L(i32 %r223, i32 %r226)
%r228 = zext i64 %r220 to i128
%r229 = zext i64 %r227 to i128
%r230 = shl i128 %r229, 64
%r231 = or i128 %r228, %r230
%r233 = getelementptr i32, i32* %r2, i32 2
%r234 = load i32, i32* %r233
%r236 = getelementptr i32, i32* %r2, i32 10
%r237 = load i32, i32* %r236
%r238 = call i64 @mul32x32L(i32 %r234, i32 %r237)
%r239 = zext i128 %r231 to i192
%r240 = zext i64 %r238 to i192
%r241 = shl i192 %r240, 128
%r242 = or i192 %r239, %r241
%r244 = getelementptr i32, i32* %r2, i32 3
%r245 = load i32, i32* %r244
%r247 = getelementptr i32, i32* %r2, i32 11
%r248 = load i32, i32* %r247
%r249 = call i64 @mul32x32L(i32 %r245, i32 %r248)
%r250 = zext i192 %r242 to i256
%r251 = zext i64 %r249 to i256
%r252 = shl i256 %r251, 192
%r253 = or i256 %r250, %r252
%r255 = getelementptr i32, i32* %r2, i32 4
%r256 = load i32, i32* %r255
%r258 = getelementptr i32, i32* %r2, i32 12
%r259 = load i32, i32* %r258
%r260 = call i64 @mul32x32L(i32 %r256, i32 %r259)
%r261 = zext i256 %r253 to i320
%r262 = zext i64 %r260 to i320
%r263 = shl i320 %r262, 256
%r264 = or i320 %r261, %r263
%r266 = getelementptr i32, i32* %r2, i32 5
%r267 = load i32, i32* %r266
%r269 = getelementptr i32, i32* %r2, i32 13
%r270 = load i32, i32* %r269
%r271 = call i64 @mul32x32L(i32 %r267, i32 %r270)
%r272 = zext i320 %r264 to i384
%r273 = zext i64 %r271 to i384
%r274 = shl i384 %r273, 320
%r275 = or i384 %r272, %r274
%r277 = getelementptr i32, i32* %r2, i32 6
%r278 = load i32, i32* %r277
%r280 = getelementptr i32, i32* %r2, i32 14
%r281 = load i32, i32* %r280
%r282 = call i64 @mul32x32L(i32 %r278, i32 %r281)
%r283 = zext i384 %r275 to i448
%r284 = zext i64 %r282 to i448
%r285 = shl i448 %r284, 384
%r286 = or i448 %r283, %r285
%r287 = zext i384 %r215 to i448
%r288 = shl i448 %r287, 32
%r289 = add i448 %r288, %r286
%r290 = load i32, i32* %r2
%r292 = getelementptr i32, i32* %r2, i32 7
%r293 = load i32, i32* %r292
%r294 = call i64 @mul32x32L(i32 %r290, i32 %r293)
%r296 = getelementptr i32, i32* %r2, i32 1
%r297 = load i32, i32* %r296
%r299 = getelementptr i32, i32* %r2, i32 8
%r300 = load i32, i32* %r299
%r301 = call i64 @mul32x32L(i32 %r297, i32 %r300)
%r302 = zext i64 %r294 to i128
%r303 = zext i64 %r301 to i128
%r304 = shl i128 %r303, 64
%r305 = or i128 %r302, %r304
%r307 = getelementptr i32, i32* %r2, i32 2
%r308 = load i32, i32* %r307
%r310 = getelementptr i32, i32* %r2, i32 9
%r311 = load i32, i32* %r310
%r312 = call i64 @mul32x32L(i32 %r308, i32 %r311)
%r313 = zext i128 %r305 to i192
%r314 = zext i64 %r312 to i192
%r315 = shl i192 %r314, 128
%r316 = or i192 %r313, %r315
%r318 = getelementptr i32, i32* %r2, i32 3
%r319 = load i32, i32* %r318
%r321 = getelementptr i32, i32* %r2, i32 10
%r322 = load i32, i32* %r321
%r323 = call i64 @mul32x32L(i32 %r319, i32 %r322)
%r324 = zext i192 %r316 to i256
%r325 = zext i64 %r323 to i256
%r326 = shl i256 %r325, 192
%r327 = or i256 %r324, %r326
%r329 = getelementptr i32, i32* %r2, i32 4
%r330 = load i32, i32* %r329
%r332 = getelementptr i32, i32* %r2, i32 11
%r333 = load i32, i32* %r332
%r334 = call i64 @mul32x32L(i32 %r330, i32 %r333)
%r335 = zext i256 %r327 to i320
%r336 = zext i64 %r334 to i320
%r337 = shl i320 %r336, 256
%r338 = or i320 %r335, %r337
%r340 = getelementptr i32, i32* %r2, i32 5
%r341 = load i32, i32* %r340
%r343 = getelementptr i32, i32* %r2, i32 12
%r344 = load i32, i32* %r343
%r345 = call i64 @mul32x32L(i32 %r341, i32 %r344)
%r346 = zext i320 %r338 to i384
%r347 = zext i64 %r345 to i384
%r348 = shl i384 %r347, 320
%r349 = or i384 %r346, %r348
%r351 = getelementptr i32, i32* %r2, i32 6
%r352 = load i32, i32* %r351
%r354 = getelementptr i32, i32* %r2, i32 13
%r355 = load i32, i32* %r354
%r356 = call i64 @mul32x32L(i32 %r352, i32 %r355)
%r357 = zext i384 %r349 to i448
%r358 = zext i64 %r356 to i448
%r359 = shl i448 %r358, 384
%r360 = or i448 %r357, %r359
%r362 = getelementptr i32, i32* %r2, i32 7
%r363 = load i32, i32* %r362
%r365 = getelementptr i32, i32* %r2, i32 14
%r366 = load i32, i32* %r365
%r367 = call i64 @mul32x32L(i32 %r363, i32 %r366)
%r368 = zext i448 %r360 to i512
%r369 = zext i64 %r367 to i512
%r370 = shl i512 %r369, 448
%r371 = or i512 %r368, %r370
%r372 = zext i448 %r289 to i512
%r373 = shl i512 %r372, 32
%r374 = add i512 %r373, %r371
%r375 = load i32, i32* %r2
%r377 = getelementptr i32, i32* %r2, i32 6
%r378 = load i32, i32* %r377
%r379 = call i64 @mul32x32L(i32 %r375, i32 %r378)
%r381 = getelementptr i32, i32* %r2, i32 1
%r382 = load i32, i32* %r381
%r384 = getelementptr i32, i32* %r2, i32 7
%r385 = load i32, i32* %r384
%r386 = call i64 @mul32x32L(i32 %r382, i32 %r385)
%r387 = zext i64 %r379 to i128
%r388 = zext i64 %r386 to i128
%r389 = shl i128 %r388, 64
%r390 = or i128 %r387, %r389
%r392 = getelementptr i32, i32* %r2, i32 2
%r393 = load i32, i32* %r392
%r395 = getelementptr i32, i32* %r2, i32 8
%r396 = load i32, i32* %r395
%r397 = call i64 @mul32x32L(i32 %r393, i32 %r396)
%r398 = zext i128 %r390 to i192
%r399 = zext i64 %r397 to i192
%r400 = shl i192 %r399, 128
%r401 = or i192 %r398, %r400
%r403 = getelementptr i32, i32* %r2, i32 3
%r404 = load i32, i32* %r403
%r406 = getelementptr i32, i32* %r2, i32 9
%r407 = load i32, i32* %r406
%r408 = call i64 @mul32x32L(i32 %r404, i32 %r407)
%r409 = zext i192 %r401 to i256
%r410 = zext i64 %r408 to i256
%r411 = shl i256 %r410, 192
%r412 = or i256 %r409, %r411
%r414 = getelementptr i32, i32* %r2, i32 4
%r415 = load i32, i32* %r414
%r417 = getelementptr i32, i32* %r2, i32 10
%r418 = load i32, i32* %r417
%r419 = call i64 @mul32x32L(i32 %r415, i32 %r418)
%r420 = zext i256 %r412 to i320
%r421 = zext i64 %r419 to i320
%r422 = shl i320 %r421, 256
%r423 = or i320 %r420, %r422
%r425 = getelementptr i32, i32* %r2, i32 5
%r426 = load i32, i32* %r425
%r428 = getelementptr i32, i32* %r2, i32 11
%r429 = load i32, i32* %r428
%r430 = call i64 @mul32x32L(i32 %r426, i32 %r429)
%r431 = zext i320 %r423 to i384
%r432 = zext i64 %r430 to i384
%r433 = shl i384 %r432, 320
%r434 = or i384 %r431, %r433
%r436 = getelementptr i32, i32* %r2, i32 6
%r437 = load i32, i32* %r436
%r439 = getelementptr i32, i32* %r2, i32 12
%r440 = load i32, i32* %r439
%r441 = call i64 @mul32x32L(i32 %r437, i32 %r440)
%r442 = zext i384 %r434 to i448
%r443 = zext i64 %r441 to i448
%r444 = shl i448 %r443, 384
%r445 = or i448 %r442, %r444
%r447 = getelementptr i32, i32* %r2, i32 7
%r448 = load i32, i32* %r447
%r450 = getelementptr i32, i32* %r2, i32 13
%r451 = load i32, i32* %r450
%r452 = call i64 @mul32x32L(i32 %r448, i32 %r451)
%r453 = zext i448 %r445 to i512
%r454 = zext i64 %r452 to i512
%r455 = shl i512 %r454, 448
%r456 = or i512 %r453, %r455
%r458 = getelementptr i32, i32* %r2, i32 8
%r459 = load i32, i32* %r458
%r461 = getelementptr i32, i32* %r2, i32 14
%r462 = load i32, i32* %r461
%r463 = call i64 @mul32x32L(i32 %r459, i32 %r462)
%r464 = zext i512 %r456 to i576
%r465 = zext i64 %r463 to i576
%r466 = shl i576 %r465, 512
%r467 = or i576 %r464, %r466
%r468 = zext i512 %r374 to i576
%r469 = shl i576 %r468, 32
%r470 = add i576 %r469, %r467
%r471 = load i32, i32* %r2
%r473 = getelementptr i32, i32* %r2, i32 5
%r474 = load i32, i32* %r473
%r475 = call i64 @mul32x32L(i32 %r471, i32 %r474)
%r477 = getelementptr i32, i32* %r2, i32 1
%r478 = load i32, i32* %r477
%r480 = getelementptr i32, i32* %r2, i32 6
%r481 = load i32, i32* %r480
%r482 = call i64 @mul32x32L(i32 %r478, i32 %r481)
%r483 = zext i64 %r475 to i128
%r484 = zext i64 %r482 to i128
%r485 = shl i128 %r484, 64
%r486 = or i128 %r483, %r485
%r488 = getelementptr i32, i32* %r2, i32 2
%r489 = load i32, i32* %r488
%r491 = getelementptr i32, i32* %r2, i32 7
%r492 = load i32, i32* %r491
%r493 = call i64 @mul32x32L(i32 %r489, i32 %r492)
%r494 = zext i128 %r486 to i192
%r495 = zext i64 %r493 to i192
%r496 = shl i192 %r495, 128
%r497 = or i192 %r494, %r496
%r499 = getelementptr i32, i32* %r2, i32 3
%r500 = load i32, i32* %r499
%r502 = getelementptr i32, i32* %r2, i32 8
%r503 = load i32, i32* %r502
%r504 = call i64 @mul32x32L(i32 %r500, i32 %r503)
%r505 = zext i192 %r497 to i256
%r506 = zext i64 %r504 to i256
%r507 = shl i256 %r506, 192
%r508 = or i256 %r505, %r507
%r510 = getelementptr i32, i32* %r2, i32 4
%r511 = load i32, i32* %r510
%r513 = getelementptr i32, i32* %r2, i32 9
%r514 = load i32, i32* %r513
%r515 = call i64 @mul32x32L(i32 %r511, i32 %r514)
%r516 = zext i256 %r508 to i320
%r517 = zext i64 %r515 to i320
%r518 = shl i320 %r517, 256
%r519 = or i320 %r516, %r518
%r521 = getelementptr i32, i32* %r2, i32 5
%r522 = load i32, i32* %r521
%r524 = getelementptr i32, i32* %r2, i32 10
%r525 = load i32, i32* %r524
%r526 = call i64 @mul32x32L(i32 %r522, i32 %r525)
%r527 = zext i320 %r519 to i384
%r528 = zext i64 %r526 to i384
%r529 = shl i384 %r528, 320
%r530 = or i384 %r527, %r529
%r532 = getelementptr i32, i32* %r2, i32 6
%r533 = load i32, i32* %r532
%r535 = getelementptr i32, i32* %r2, i32 11
%r536 = load i32, i32* %r535
%r537 = call i64 @mul32x32L(i32 %r533, i32 %r536)
%r538 = zext i384 %r530 to i448
%r539 = zext i64 %r537 to i448
%r540 = shl i448 %r539, 384
%r541 = or i448 %r538, %r540
%r543 = getelementptr i32, i32* %r2, i32 7
%r544 = load i32, i32* %r543
%r546 = getelementptr i32, i32* %r2, i32 12
%r547 = load i32, i32* %r546
%r548 = call i64 @mul32x32L(i32 %r544, i32 %r547)
%r549 = zext i448 %r541 to i512
%r550 = zext i64 %r548 to i512
%r551 = shl i512 %r550, 448
%r552 = or i512 %r549, %r551
%r554 = getelementptr i32, i32* %r2, i32 8
%r555 = load i32, i32* %r554
%r557 = getelementptr i32, i32* %r2, i32 13
%r558 = load i32, i32* %r557
%r559 = call i64 @mul32x32L(i32 %r555, i32 %r558)
%r560 = zext i512 %r552 to i576
%r561 = zext i64 %r559 to i576
%r562 = shl i576 %r561, 512
%r563 = or i576 %r560, %r562
%r565 = getelementptr i32, i32* %r2, i32 9
%r566 = load i32, i32* %r565
%r568 = getelementptr i32, i32* %r2, i32 14
%r569 = load i32, i32* %r568
%r570 = call i64 @mul32x32L(i32 %r566, i32 %r569)
%r571 = zext i576 %r563 to i640
%r572 = zext i64 %r570 to i640
%r573 = shl i640 %r572, 576
%r574 = or i640 %r571, %r573
%r575 = zext i576 %r470 to i640
%r576 = shl i640 %r575, 32
%r577 = add i640 %r576, %r574
%r578 = load i32, i32* %r2
%r580 = getelementptr i32, i32* %r2, i32 4
%r581 = load i32, i32* %r580
%r582 = call i64 @mul32x32L(i32 %r578, i32 %r581)
%r584 = getelementptr i32, i32* %r2, i32 1
%r585 = load i32, i32* %r584
%r587 = getelementptr i32, i32* %r2, i32 5
%r588 = load i32, i32* %r587
%r589 = call i64 @mul32x32L(i32 %r585, i32 %r588)
%r590 = zext i64 %r582 to i128
%r591 = zext i64 %r589 to i128
%r592 = shl i128 %r591, 64
%r593 = or i128 %r590, %r592
%r595 = getelementptr i32, i32* %r2, i32 2
%r596 = load i32, i32* %r595
%r598 = getelementptr i32, i32* %r2, i32 6
%r599 = load i32, i32* %r598
%r600 = call i64 @mul32x32L(i32 %r596, i32 %r599)
%r601 = zext i128 %r593 to i192
%r602 = zext i64 %r600 to i192
%r603 = shl i192 %r602, 128
%r604 = or i192 %r601, %r603
%r606 = getelementptr i32, i32* %r2, i32 3
%r607 = load i32, i32* %r606
%r609 = getelementptr i32, i32* %r2, i32 7
%r610 = load i32, i32* %r609
%r611 = call i64 @mul32x32L(i32 %r607, i32 %r610)
%r612 = zext i192 %r604 to i256
%r613 = zext i64 %r611 to i256
%r614 = shl i256 %r613, 192
%r615 = or i256 %r612, %r614
%r617 = getelementptr i32, i32* %r2, i32 4
%r618 = load i32, i32* %r617
%r620 = getelementptr i32, i32* %r2, i32 8
%r621 = load i32, i32* %r620
%r622 = call i64 @mul32x32L(i32 %r618, i32 %r621)
%r623 = zext i256 %r615 to i320
%r624 = zext i64 %r622 to i320
%r625 = shl i320 %r624, 256
%r626 = or i320 %r623, %r625
%r628 = getelementptr i32, i32* %r2, i32 5
%r629 = load i32, i32* %r628
%r631 = getelementptr i32, i32* %r2, i32 9
%r632 = load i32, i32* %r631
%r633 = call i64 @mul32x32L(i32 %r629, i32 %r632)
%r634 = zext i320 %r626 to i384
%r635 = zext i64 %r633 to i384
%r636 = shl i384 %r635, 320
%r637 = or i384 %r634, %r636
%r639 = getelementptr i32, i32* %r2, i32 6
%r640 = load i32, i32* %r639
%r642 = getelementptr i32, i32* %r2, i32 10
%r643 = load i32, i32* %r642
%r644 = call i64 @mul32x32L(i32 %r640, i32 %r643)
%r645 = zext i384 %r637 to i448
%r646 = zext i64 %r644 to i448
%r647 = shl i448 %r646, 384
%r648 = or i448 %r645, %r647
%r650 = getelementptr i32, i32* %r2, i32 7
%r651 = load i32, i32* %r650
%r653 = getelementptr i32, i32* %r2, i32 11
%r654 = load i32, i32* %r653
%r655 = call i64 @mul32x32L(i32 %r651, i32 %r654)
%r656 = zext i448 %r648 to i512
%r657 = zext i64 %r655 to i512
%r658 = shl i512 %r657, 448
%r659 = or i512 %r656, %r658
%r661 = getelementptr i32, i32* %r2, i32 8
%r662 = load i32, i32* %r661
%r664 = getelementptr i32, i32* %r2, i32 12
%r665 = load i32, i32* %r664
%r666 = call i64 @mul32x32L(i32 %r662, i32 %r665)
%r667 = zext i512 %r659 to i576
%r668 = zext i64 %r666 to i576
%r669 = shl i576 %r668, 512
%r670 = or i576 %r667, %r669
%r672 = getelementptr i32, i32* %r2, i32 9
%r673 = load i32, i32* %r672
%r675 = getelementptr i32, i32* %r2, i32 13
%r676 = load i32, i32* %r675
%r677 = call i64 @mul32x32L(i32 %r673, i32 %r676)
%r678 = zext i576 %r670 to i640
%r679 = zext i64 %r677 to i640
%r680 = shl i640 %r679, 576
%r681 = or i640 %r678, %r680
%r683 = getelementptr i32, i32* %r2, i32 10
%r684 = load i32, i32* %r683
%r686 = getelementptr i32, i32* %r2, i32 14
%r687 = load i32, i32* %r686
%r688 = call i64 @mul32x32L(i32 %r684, i32 %r687)
%r689 = zext i640 %r681 to i704
%r690 = zext i64 %r688 to i704
%r691 = shl i704 %r690, 640
%r692 = or i704 %r689, %r691
%r693 = zext i640 %r577 to i704
%r694 = shl i704 %r693, 32
%r695 = add i704 %r694, %r692
%r696 = load i32, i32* %r2
%r698 = getelementptr i32, i32* %r2, i32 3
%r699 = load i32, i32* %r698
%r700 = call i64 @mul32x32L(i32 %r696, i32 %r699)
%r702 = getelementptr i32, i32* %r2, i32 1
%r703 = load i32, i32* %r702
%r705 = getelementptr i32, i32* %r2, i32 4
%r706 = load i32, i32* %r705
%r707 = call i64 @mul32x32L(i32 %r703, i32 %r706)
%r708 = zext i64 %r700 to i128
%r709 = zext i64 %r707 to i128
%r710 = shl i128 %r709, 64
%r711 = or i128 %r708, %r710
%r713 = getelementptr i32, i32* %r2, i32 2
%r714 = load i32, i32* %r713
%r716 = getelementptr i32, i32* %r2, i32 5
%r717 = load i32, i32* %r716
%r718 = call i64 @mul32x32L(i32 %r714, i32 %r717)
%r719 = zext i128 %r711 to i192
%r720 = zext i64 %r718 to i192
%r721 = shl i192 %r720, 128
%r722 = or i192 %r719, %r721
%r724 = getelementptr i32, i32* %r2, i32 3
%r725 = load i32, i32* %r724
%r727 = getelementptr i32, i32* %r2, i32 6
%r728 = load i32, i32* %r727
%r729 = call i64 @mul32x32L(i32 %r725, i32 %r728)
%r730 = zext i192 %r722 to i256
%r731 = zext i64 %r729 to i256
%r732 = shl i256 %r731, 192
%r733 = or i256 %r730, %r732
%r735 = getelementptr i32, i32* %r2, i32 4
%r736 = load i32, i32* %r735
%r738 = getelementptr i32, i32* %r2, i32 7
%r739 = load i32, i32* %r738
%r740 = call i64 @mul32x32L(i32 %r736, i32 %r739)
%r741 = zext i256 %r733 to i320
%r742 = zext i64 %r740 to i320
%r743 = shl i320 %r742, 256
%r744 = or i320 %r741, %r743
%r746 = getelementptr i32, i32* %r2, i32 5
%r747 = load i32, i32* %r746
%r749 = getelementptr i32, i32* %r2, i32 8
%r750 = load i32, i32* %r749
%r751 = call i64 @mul32x32L(i32 %r747, i32 %r750)
%r752 = zext i320 %r744 to i384
%r753 = zext i64 %r751 to i384
%r754 = shl i384 %r753, 320
%r755 = or i384 %r752, %r754
%r757 = getelementptr i32, i32* %r2, i32 6
%r758 = load i32, i32* %r757
%r760 = getelementptr i32, i32* %r2, i32 9
%r761 = load i32, i32* %r760
%r762 = call i64 @mul32x32L(i32 %r758, i32 %r761)
%r763 = zext i384 %r755 to i448
%r764 = zext i64 %r762 to i448
%r765 = shl i448 %r764, 384
%r766 = or i448 %r763, %r765
%r768 = getelementptr i32, i32* %r2, i32 7
%r769 = load i32, i32* %r768
%r771 = getelementptr i32, i32* %r2, i32 10
%r772 = load i32, i32* %r771
%r773 = call i64 @mul32x32L(i32 %r769, i32 %r772)
%r774 = zext i448 %r766 to i512
%r775 = zext i64 %r773 to i512
%r776 = shl i512 %r775, 448
%r777 = or i512 %r774, %r776
%r779 = getelementptr i32, i32* %r2, i32 8
%r780 = load i32, i32* %r779
%r782 = getelementptr i32, i32* %r2, i32 11
%r783 = load i32, i32* %r782
%r784 = call i64 @mul32x32L(i32 %r780, i32 %r783)
%r785 = zext i512 %r777 to i576
%r786 = zext i64 %r784 to i576
%r787 = shl i576 %r786, 512
%r788 = or i576 %r785, %r787
%r790 = getelementptr i32, i32* %r2, i32 9
%r791 = load i32, i32* %r790
%r793 = getelementptr i32, i32* %r2, i32 12
%r794 = load i32, i32* %r793
%r795 = call i64 @mul32x32L(i32 %r791, i32 %r794)
%r796 = zext i576 %r788 to i640
%r797 = zext i64 %r795 to i640
%r798 = shl i640 %r797, 576
%r799 = or i640 %r796, %r798
%r801 = getelementptr i32, i32* %r2, i32 10
%r802 = load i32, i32* %r801
%r804 = getelementptr i32, i32* %r2, i32 13
%r805 = load i32, i32* %r804
%r806 = call i64 @mul32x32L(i32 %r802, i32 %r805)
%r807 = zext i640 %r799 to i704
%r808 = zext i64 %r806 to i704
%r809 = shl i704 %r808, 640
%r810 = or i704 %r807, %r809
%r812 = getelementptr i32, i32* %r2, i32 11
%r813 = load i32, i32* %r812
%r815 = getelementptr i32, i32* %r2, i32 14
%r816 = load i32, i32* %r815
%r817 = call i64 @mul32x32L(i32 %r813, i32 %r816)
%r818 = zext i704 %r810 to i768
%r819 = zext i64 %r817 to i768
%r820 = shl i768 %r819, 704
%r821 = or i768 %r818, %r820
%r822 = zext i704 %r695 to i768
%r823 = shl i768 %r822, 32
%r824 = add i768 %r823, %r821
%r825 = load i32, i32* %r2
%r827 = getelementptr i32, i32* %r2, i32 2
%r828 = load i32, i32* %r827
%r829 = call i64 @mul32x32L(i32 %r825, i32 %r828)
%r831 = getelementptr i32, i32* %r2, i32 1
%r832 = load i32, i32* %r831
%r834 = getelementptr i32, i32* %r2, i32 3
%r835 = load i32, i32* %r834
%r836 = call i64 @mul32x32L(i32 %r832, i32 %r835)
%r837 = zext i64 %r829 to i128
%r838 = zext i64 %r836 to i128
%r839 = shl i128 %r838, 64
%r840 = or i128 %r837, %r839
%r842 = getelementptr i32, i32* %r2, i32 2
%r843 = load i32, i32* %r842
%r845 = getelementptr i32, i32* %r2, i32 4
%r846 = load i32, i32* %r845
%r847 = call i64 @mul32x32L(i32 %r843, i32 %r846)
%r848 = zext i128 %r840 to i192
%r849 = zext i64 %r847 to i192
%r850 = shl i192 %r849, 128
%r851 = or i192 %r848, %r850
%r853 = getelementptr i32, i32* %r2, i32 3
%r854 = load i32, i32* %r853
%r856 = getelementptr i32, i32* %r2, i32 5
%r857 = load i32, i32* %r856
%r858 = call i64 @mul32x32L(i32 %r854, i32 %r857)
%r859 = zext i192 %r851 to i256
%r860 = zext i64 %r858 to i256
%r861 = shl i256 %r860, 192
%r862 = or i256 %r859, %r861
%r864 = getelementptr i32, i32* %r2, i32 4
%r865 = load i32, i32* %r864
%r867 = getelementptr i32, i32* %r2, i32 6
%r868 = load i32, i32* %r867
%r869 = call i64 @mul32x32L(i32 %r865, i32 %r868)
%r870 = zext i256 %r862 to i320
%r871 = zext i64 %r869 to i320
%r872 = shl i320 %r871, 256
%r873 = or i320 %r870, %r872
%r875 = getelementptr i32, i32* %r2, i32 5
%r876 = load i32, i32* %r875
%r878 = getelementptr i32, i32* %r2, i32 7
%r879 = load i32, i32* %r878
%r880 = call i64 @mul32x32L(i32 %r876, i32 %r879)
%r881 = zext i320 %r873 to i384
%r882 = zext i64 %r880 to i384
%r883 = shl i384 %r882, 320
%r884 = or i384 %r881, %r883
%r886 = getelementptr i32, i32* %r2, i32 6
%r887 = load i32, i32* %r886
%r889 = getelementptr i32, i32* %r2, i32 8
%r890 = load i32, i32* %r889
%r891 = call i64 @mul32x32L(i32 %r887, i32 %r890)
%r892 = zext i384 %r884 to i448
%r893 = zext i64 %r891 to i448
%r894 = shl i448 %r893, 384
%r895 = or i448 %r892, %r894
%r897 = getelementptr i32, i32* %r2, i32 7
%r898 = load i32, i32* %r897
%r900 = getelementptr i32, i32* %r2, i32 9
%r901 = load i32, i32* %r900
%r902 = call i64 @mul32x32L(i32 %r898, i32 %r901)
%r903 = zext i448 %r895 to i512
%r904 = zext i64 %r902 to i512
%r905 = shl i512 %r904, 448
%r906 = or i512 %r903, %r905
%r908 = getelementptr i32, i32* %r2, i32 8
%r909 = load i32, i32* %r908
%r911 = getelementptr i32, i32* %r2, i32 10
%r912 = load i32, i32* %r911
%r913 = call i64 @mul32x32L(i32 %r909, i32 %r912)
%r914 = zext i512 %r906 to i576
%r915 = zext i64 %r913 to i576
%r916 = shl i576 %r915, 512
%r917 = or i576 %r914, %r916
%r919 = getelementptr i32, i32* %r2, i32 9
%r920 = load i32, i32* %r919
%r922 = getelementptr i32, i32* %r2, i32 11
%r923 = load i32, i32* %r922
%r924 = call i64 @mul32x32L(i32 %r920, i32 %r923)
%r925 = zext i576 %r917 to i640
%r926 = zext i64 %r924 to i640
%r927 = shl i640 %r926, 576
%r928 = or i640 %r925, %r927
%r930 = getelementptr i32, i32* %r2, i32 10
%r931 = load i32, i32* %r930
%r933 = getelementptr i32, i32* %r2, i32 12
%r934 = load i32, i32* %r933
%r935 = call i64 @mul32x32L(i32 %r931, i32 %r934)
%r936 = zext i640 %r928 to i704
%r937 = zext i64 %r935 to i704
%r938 = shl i704 %r937, 640
%r939 = or i704 %r936, %r938
%r941 = getelementptr i32, i32* %r2, i32 11
%r942 = load i32, i32* %r941
%r944 = getelementptr i32, i32* %r2, i32 13
%r945 = load i32, i32* %r944
%r946 = call i64 @mul32x32L(i32 %r942, i32 %r945)
%r947 = zext i704 %r939 to i768
%r948 = zext i64 %r946 to i768
%r949 = shl i768 %r948, 704
%r950 = or i768 %r947, %r949
%r952 = getelementptr i32, i32* %r2, i32 12
%r953 = load i32, i32* %r952
%r955 = getelementptr i32, i32* %r2, i32 14
%r956 = load i32, i32* %r955
%r957 = call i64 @mul32x32L(i32 %r953, i32 %r956)
%r958 = zext i768 %r950 to i832
%r959 = zext i64 %r957 to i832
%r960 = shl i832 %r959, 768
%r961 = or i832 %r958, %r960
%r962 = zext i768 %r824 to i832
%r963 = shl i832 %r962, 32
%r964 = add i832 %r963, %r961
%r965 = load i32, i32* %r2
%r967 = getelementptr i32, i32* %r2, i32 1
%r968 = load i32, i32* %r967
%r969 = call i64 @mul32x32L(i32 %r965, i32 %r968)
%r971 = getelementptr i32, i32* %r2, i32 1
%r972 = load i32, i32* %r971
%r974 = getelementptr i32, i32* %r2, i32 2
%r975 = load i32, i32* %r974
%r976 = call i64 @mul32x32L(i32 %r972, i32 %r975)
%r977 = zext i64 %r969 to i128
%r978 = zext i64 %r976 to i128
%r979 = shl i128 %r978, 64
%r980 = or i128 %r977, %r979
%r982 = getelementptr i32, i32* %r2, i32 2
%r983 = load i32, i32* %r982
%r985 = getelementptr i32, i32* %r2, i32 3
%r986 = load i32, i32* %r985
%r987 = call i64 @mul32x32L(i32 %r983, i32 %r986)
%r988 = zext i128 %r980 to i192
%r989 = zext i64 %r987 to i192
%r990 = shl i192 %r989, 128
%r991 = or i192 %r988, %r990
%r993 = getelementptr i32, i32* %r2, i32 3
%r994 = load i32, i32* %r993
%r996 = getelementptr i32, i32* %r2, i32 4
%r997 = load i32, i32* %r996
%r998 = call i64 @mul32x32L(i32 %r994, i32 %r997)
%r999 = zext i192 %r991 to i256
%r1000 = zext i64 %r998 to i256
%r1001 = shl i256 %r1000, 192
%r1002 = or i256 %r999, %r1001
%r1004 = getelementptr i32, i32* %r2, i32 4
%r1005 = load i32, i32* %r1004
%r1007 = getelementptr i32, i32* %r2, i32 5
%r1008 = load i32, i32* %r1007
%r1009 = call i64 @mul32x32L(i32 %r1005, i32 %r1008)
%r1010 = zext i256 %r1002 to i320
%r1011 = zext i64 %r1009 to i320
%r1012 = shl i320 %r1011, 256
%r1013 = or i320 %r1010, %r1012
%r1015 = getelementptr i32, i32* %r2, i32 5
%r1016 = load i32, i32* %r1015
%r1018 = getelementptr i32, i32* %r2, i32 6
%r1019 = load i32, i32* %r1018
%r1020 = call i64 @mul32x32L(i32 %r1016, i32 %r1019)
%r1021 = zext i320 %r1013 to i384
%r1022 = zext i64 %r1020 to i384
%r1023 = shl i384 %r1022, 320
%r1024 = or i384 %r1021, %r1023
%r1026 = getelementptr i32, i32* %r2, i32 6
%r1027 = load i32, i32* %r1026
%r1029 = getelementptr i32, i32* %r2, i32 7
%r1030 = load i32, i32* %r1029
%r1031 = call i64 @mul32x32L(i32 %r1027, i32 %r1030)
%r1032 = zext i384 %r1024 to i448
%r1033 = zext i64 %r1031 to i448
%r1034 = shl i448 %r1033, 384
%r1035 = or i448 %r1032, %r1034
%r1037 = getelementptr i32, i32* %r2, i32 7
%r1038 = load i32, i32* %r1037
%r1040 = getelementptr i32, i32* %r2, i32 8
%r1041 = load i32, i32* %r1040
%r1042 = call i64 @mul32x32L(i32 %r1038, i32 %r1041)
%r1043 = zext i448 %r1035 to i512
%r1044 = zext i64 %r1042 to i512
%r1045 = shl i512 %r1044, 448
%r1046 = or i512 %r1043, %r1045
%r1048 = getelementptr i32, i32* %r2, i32 8
%r1049 = load i32, i32* %r1048
%r1051 = getelementptr i32, i32* %r2, i32 9
%r1052 = load i32, i32* %r1051
%r1053 = call i64 @mul32x32L(i32 %r1049, i32 %r1052)
%r1054 = zext i512 %r1046 to i576
%r1055 = zext i64 %r1053 to i576
%r1056 = shl i576 %r1055, 512
%r1057 = or i576 %r1054, %r1056
%r1059 = getelementptr i32, i32* %r2, i32 9
%r1060 = load i32, i32* %r1059
%r1062 = getelementptr i32, i32* %r2, i32 10
%r1063 = load i32, i32* %r1062
%r1064 = call i64 @mul32x32L(i32 %r1060, i32 %r1063)
%r1065 = zext i576 %r1057 to i640
%r1066 = zext i64 %r1064 to i640
%r1067 = shl i640 %r1066, 576
%r1068 = or i640 %r1065, %r1067
%r1070 = getelementptr i32, i32* %r2, i32 10
%r1071 = load i32, i32* %r1070
%r1073 = getelementptr i32, i32* %r2, i32 11
%r1074 = load i32, i32* %r1073
%r1075 = call i64 @mul32x32L(i32 %r1071, i32 %r1074)
%r1076 = zext i640 %r1068 to i704
%r1077 = zext i64 %r1075 to i704
%r1078 = shl i704 %r1077, 640
%r1079 = or i704 %r1076, %r1078
%r1081 = getelementptr i32, i32* %r2, i32 11
%r1082 = load i32, i32* %r1081
%r1084 = getelementptr i32, i32* %r2, i32 12
%r1085 = load i32, i32* %r1084
%r1086 = call i64 @mul32x32L(i32 %r1082, i32 %r1085)
%r1087 = zext i704 %r1079 to i768
%r1088 = zext i64 %r1086 to i768
%r1089 = shl i768 %r1088, 704
%r1090 = or i768 %r1087, %r1089
%r1092 = getelementptr i32, i32* %r2, i32 12
%r1093 = load i32, i32* %r1092
%r1095 = getelementptr i32, i32* %r2, i32 13
%r1096 = load i32, i32* %r1095
%r1097 = call i64 @mul32x32L(i32 %r1093, i32 %r1096)
%r1098 = zext i768 %r1090 to i832
%r1099 = zext i64 %r1097 to i832
%r1100 = shl i832 %r1099, 768
%r1101 = or i832 %r1098, %r1100
%r1103 = getelementptr i32, i32* %r2, i32 13
%r1104 = load i32, i32* %r1103
%r1106 = getelementptr i32, i32* %r2, i32 14
%r1107 = load i32, i32* %r1106
%r1108 = call i64 @mul32x32L(i32 %r1104, i32 %r1107)
%r1109 = zext i832 %r1101 to i896
%r1110 = zext i64 %r1108 to i896
%r1111 = shl i896 %r1110, 832
%r1112 = or i896 %r1109, %r1111
%r1113 = zext i832 %r964 to i896
%r1114 = shl i896 %r1113, 32
%r1115 = add i896 %r1114, %r1112
%r1116 = zext i64 %r6 to i928
%r1118 = getelementptr i32, i32* %r2, i32 1
%r1119 = load i32, i32* %r1118
%r1120 = call i64 @mul32x32L(i32 %r1119, i32 %r1119)
%r1121 = zext i64 %r1120 to i928
%r1122 = shl i928 %r1121, 32
%r1123 = or i928 %r1116, %r1122
%r1125 = getelementptr i32, i32* %r2, i32 2
%r1126 = load i32, i32* %r1125
%r1127 = call i64 @mul32x32L(i32 %r1126, i32 %r1126)
%r1128 = zext i64 %r1127 to i928
%r1129 = shl i928 %r1128, 96
%r1130 = or i928 %r1123, %r1129
%r1132 = getelementptr i32, i32* %r2, i32 3
%r1133 = load i32, i32* %r1132
%r1134 = call i64 @mul32x32L(i32 %r1133, i32 %r1133)
%r1135 = zext i64 %r1134 to i928
%r1136 = shl i928 %r1135, 160
%r1137 = or i928 %r1130, %r1136
%r1139 = getelementptr i32, i32* %r2, i32 4
%r1140 = load i32, i32* %r1139
%r1141 = call i64 @mul32x32L(i32 %r1140, i32 %r1140)
%r1142 = zext i64 %r1141 to i928
%r1143 = shl i928 %r1142, 224
%r1144 = or i928 %r1137, %r1143
%r1146 = getelementptr i32, i32* %r2, i32 5
%r1147 = load i32, i32* %r1146
%r1148 = call i64 @mul32x32L(i32 %r1147, i32 %r1147)
%r1149 = zext i64 %r1148 to i928
%r1150 = shl i928 %r1149, 288
%r1151 = or i928 %r1144, %r1150
%r1153 = getelementptr i32, i32* %r2, i32 6
%r1154 = load i32, i32* %r1153
%r1155 = call i64 @mul32x32L(i32 %r1154, i32 %r1154)
%r1156 = zext i64 %r1155 to i928
%r1157 = shl i928 %r1156, 352
%r1158 = or i928 %r1151, %r1157
%r1160 = getelementptr i32, i32* %r2, i32 7
%r1161 = load i32, i32* %r1160
%r1162 = call i64 @mul32x32L(i32 %r1161, i32 %r1161)
%r1163 = zext i64 %r1162 to i928
%r1164 = shl i928 %r1163, 416
%r1165 = or i928 %r1158, %r1164
%r1167 = getelementptr i32, i32* %r2, i32 8
%r1168 = load i32, i32* %r1167
%r1169 = call i64 @mul32x32L(i32 %r1168, i32 %r1168)
%r1170 = zext i64 %r1169 to i928
%r1171 = shl i928 %r1170, 480
%r1172 = or i928 %r1165, %r1171
%r1174 = getelementptr i32, i32* %r2, i32 9
%r1175 = load i32, i32* %r1174
%r1176 = call i64 @mul32x32L(i32 %r1175, i32 %r1175)
%r1177 = zext i64 %r1176 to i928
%r1178 = shl i928 %r1177, 544
%r1179 = or i928 %r1172, %r1178
%r1181 = getelementptr i32, i32* %r2, i32 10
%r1182 = load i32, i32* %r1181
%r1183 = call i64 @mul32x32L(i32 %r1182, i32 %r1182)
%r1184 = zext i64 %r1183 to i928
%r1185 = shl i928 %r1184, 608
%r1186 = or i928 %r1179, %r1185
%r1188 = getelementptr i32, i32* %r2, i32 11
%r1189 = load i32, i32* %r1188
%r1190 = call i64 @mul32x32L(i32 %r1189, i32 %r1189)
%r1191 = zext i64 %r1190 to i928
%r1192 = shl i928 %r1191, 672
%r1193 = or i928 %r1186, %r1192
%r1195 = getelementptr i32, i32* %r2, i32 12
%r1196 = load i32, i32* %r1195
%r1197 = call i64 @mul32x32L(i32 %r1196, i32 %r1196)
%r1198 = zext i64 %r1197 to i928
%r1199 = shl i928 %r1198, 736
%r1200 = or i928 %r1193, %r1199
%r1202 = getelementptr i32, i32* %r2, i32 13
%r1203 = load i32, i32* %r1202
%r1204 = call i64 @mul32x32L(i32 %r1203, i32 %r1203)
%r1205 = zext i64 %r1204 to i928
%r1206 = shl i928 %r1205, 800
%r1207 = or i928 %r1200, %r1206
%r1209 = getelementptr i32, i32* %r2, i32 14
%r1210 = load i32, i32* %r1209
%r1211 = call i64 @mul32x32L(i32 %r1210, i32 %r1210)
%r1212 = zext i64 %r1211 to i928
%r1213 = shl i928 %r1212, 864
%r1214 = or i928 %r1207, %r1213
%r1215 = zext i896 %r1115 to i928
%r1216 = add i928 %r1215, %r1215
%r1217 = add i928 %r1214, %r1216
%r1219 = getelementptr i32, i32* %r1, i32 1
%r1221 = getelementptr i32, i32* %r1219, i32 0
%r1222 = trunc i928 %r1217 to i32
store i32 %r1222, i32* %r1221
%r1223 = lshr i928 %r1217, 32
%r1225 = getelementptr i32, i32* %r1219, i32 1
%r1226 = trunc i928 %r1223 to i32
store i32 %r1226, i32* %r1225
%r1227 = lshr i928 %r1223, 32
%r1229 = getelementptr i32, i32* %r1219, i32 2
%r1230 = trunc i928 %r1227 to i32
store i32 %r1230, i32* %r1229
%r1231 = lshr i928 %r1227, 32
%r1233 = getelementptr i32, i32* %r1219, i32 3
%r1234 = trunc i928 %r1231 to i32
store i32 %r1234, i32* %r1233
%r1235 = lshr i928 %r1231, 32
%r1237 = getelementptr i32, i32* %r1219, i32 4
%r1238 = trunc i928 %r1235 to i32
store i32 %r1238, i32* %r1237
%r1239 = lshr i928 %r1235, 32
%r1241 = getelementptr i32, i32* %r1219, i32 5
%r1242 = trunc i928 %r1239 to i32
store i32 %r1242, i32* %r1241
%r1243 = lshr i928 %r1239, 32
%r1245 = getelementptr i32, i32* %r1219, i32 6
%r1246 = trunc i928 %r1243 to i32
store i32 %r1246, i32* %r1245
%r1247 = lshr i928 %r1243, 32
%r1249 = getelementptr i32, i32* %r1219, i32 7
%r1250 = trunc i928 %r1247 to i32
store i32 %r1250, i32* %r1249
%r1251 = lshr i928 %r1247, 32
%r1253 = getelementptr i32, i32* %r1219, i32 8
%r1254 = trunc i928 %r1251 to i32
store i32 %r1254, i32* %r1253
%r1255 = lshr i928 %r1251, 32
%r1257 = getelementptr i32, i32* %r1219, i32 9
%r1258 = trunc i928 %r1255 to i32
store i32 %r1258, i32* %r1257
%r1259 = lshr i928 %r1255, 32
%r1261 = getelementptr i32, i32* %r1219, i32 10
%r1262 = trunc i928 %r1259 to i32
store i32 %r1262, i32* %r1261
%r1263 = lshr i928 %r1259, 32
%r1265 = getelementptr i32, i32* %r1219, i32 11
%r1266 = trunc i928 %r1263 to i32
store i32 %r1266, i32* %r1265
%r1267 = lshr i928 %r1263, 32
%r1269 = getelementptr i32, i32* %r1219, i32 12
%r1270 = trunc i928 %r1267 to i32
store i32 %r1270, i32* %r1269
%r1271 = lshr i928 %r1267, 32
%r1273 = getelementptr i32, i32* %r1219, i32 13
%r1274 = trunc i928 %r1271 to i32
store i32 %r1274, i32* %r1273
%r1275 = lshr i928 %r1271, 32
%r1277 = getelementptr i32, i32* %r1219, i32 14
%r1278 = trunc i928 %r1275 to i32
store i32 %r1278, i32* %r1277
%r1279 = lshr i928 %r1275, 32
%r1281 = getelementptr i32, i32* %r1219, i32 15
%r1282 = trunc i928 %r1279 to i32
store i32 %r1282, i32* %r1281
%r1283 = lshr i928 %r1279, 32
%r1285 = getelementptr i32, i32* %r1219, i32 16
%r1286 = trunc i928 %r1283 to i32
store i32 %r1286, i32* %r1285
%r1287 = lshr i928 %r1283, 32
%r1289 = getelementptr i32, i32* %r1219, i32 17
%r1290 = trunc i928 %r1287 to i32
store i32 %r1290, i32* %r1289
%r1291 = lshr i928 %r1287, 32
%r1293 = getelementptr i32, i32* %r1219, i32 18
%r1294 = trunc i928 %r1291 to i32
store i32 %r1294, i32* %r1293
%r1295 = lshr i928 %r1291, 32
%r1297 = getelementptr i32, i32* %r1219, i32 19
%r1298 = trunc i928 %r1295 to i32
store i32 %r1298, i32* %r1297
%r1299 = lshr i928 %r1295, 32
%r1301 = getelementptr i32, i32* %r1219, i32 20
%r1302 = trunc i928 %r1299 to i32
store i32 %r1302, i32* %r1301
%r1303 = lshr i928 %r1299, 32
%r1305 = getelementptr i32, i32* %r1219, i32 21
%r1306 = trunc i928 %r1303 to i32
store i32 %r1306, i32* %r1305
%r1307 = lshr i928 %r1303, 32
%r1309 = getelementptr i32, i32* %r1219, i32 22
%r1310 = trunc i928 %r1307 to i32
store i32 %r1310, i32* %r1309
%r1311 = lshr i928 %r1307, 32
%r1313 = getelementptr i32, i32* %r1219, i32 23
%r1314 = trunc i928 %r1311 to i32
store i32 %r1314, i32* %r1313
%r1315 = lshr i928 %r1311, 32
%r1317 = getelementptr i32, i32* %r1219, i32 24
%r1318 = trunc i928 %r1315 to i32
store i32 %r1318, i32* %r1317
%r1319 = lshr i928 %r1315, 32
%r1321 = getelementptr i32, i32* %r1219, i32 25
%r1322 = trunc i928 %r1319 to i32
store i32 %r1322, i32* %r1321
%r1323 = lshr i928 %r1319, 32
%r1325 = getelementptr i32, i32* %r1219, i32 26
%r1326 = trunc i928 %r1323 to i32
store i32 %r1326, i32* %r1325
%r1327 = lshr i928 %r1323, 32
%r1329 = getelementptr i32, i32* %r1219, i32 27
%r1330 = trunc i928 %r1327 to i32
store i32 %r1330, i32* %r1329
%r1331 = lshr i928 %r1327, 32
%r1333 = getelementptr i32, i32* %r1219, i32 28
%r1334 = trunc i928 %r1331 to i32
store i32 %r1334, i32* %r1333
ret void
}
define i544 @mulUnit_inner512(i32* noalias  %r2, i32 %r3)
{
%r5 = call i64 @mulPos32x32(i32* %r2, i32 %r3, i32 0)
%r6 = trunc i64 %r5 to i32
%r7 = call i32 @extractHigh32(i64 %r5)
%r9 = call i64 @mulPos32x32(i32* %r2, i32 %r3, i32 1)
%r10 = trunc i64 %r9 to i32
%r11 = call i32 @extractHigh32(i64 %r9)
%r13 = call i64 @mulPos32x32(i32* %r2, i32 %r3, i32 2)
%r14 = trunc i64 %r13 to i32
%r15 = call i32 @extractHigh32(i64 %r13)
%r17 = call i64 @mulPos32x32(i32* %r2, i32 %r3, i32 3)
%r18 = trunc i64 %r17 to i32
%r19 = call i32 @extractHigh32(i64 %r17)
%r21 = call i64 @mulPos32x32(i32* %r2, i32 %r3, i32 4)
%r22 = trunc i64 %r21 to i32
%r23 = call i32 @extractHigh32(i64 %r21)
%r25 = call i64 @mulPos32x32(i32* %r2, i32 %r3, i32 5)
%r26 = trunc i64 %r25 to i32
%r27 = call i32 @extractHigh32(i64 %r25)
%r29 = call i64 @mulPos32x32(i32* %r2, i32 %r3, i32 6)
%r30 = trunc i64 %r29 to i32
%r31 = call i32 @extractHigh32(i64 %r29)
%r33 = call i64 @mulPos32x32(i32* %r2, i32 %r3, i32 7)
%r34 = trunc i64 %r33 to i32
%r35 = call i32 @extractHigh32(i64 %r33)
%r37 = call i64 @mulPos32x32(i32* %r2, i32 %r3, i32 8)
%r38 = trunc i64 %r37 to i32
%r39 = call i32 @extractHigh32(i64 %r37)
%r41 = call i64 @mulPos32x32(i32* %r2, i32 %r3, i32 9)
%r42 = trunc i64 %r41 to i32
%r43 = call i32 @extractHigh32(i64 %r41)
%r45 = call i64 @mulPos32x32(i32* %r2, i32 %r3, i32 10)
%r46 = trunc i64 %r45 to i32
%r47 = call i32 @extractHigh32(i64 %r45)
%r49 = call i64 @mulPos32x32(i32* %r2, i32 %r3, i32 11)
%r50 = trunc i64 %r49 to i32
%r51 = call i32 @extractHigh32(i64 %r49)
%r53 = call i64 @mulPos32x32(i32* %r2, i32 %r3, i32 12)
%r54 = trunc i64 %r53 to i32
%r55 = call i32 @extractHigh32(i64 %r53)
%r57 = call i64 @mulPos32x32(i32* %r2, i32 %r3, i32 13)
%r58 = trunc i64 %r57 to i32
%r59 = call i32 @extractHigh32(i64 %r57)
%r61 = call i64 @mulPos32x32(i32* %r2, i32 %r3, i32 14)
%r62 = trunc i64 %r61 to i32
%r63 = call i32 @extractHigh32(i64 %r61)
%r65 = call i64 @mulPos32x32(i32* %r2, i32 %r3, i32 15)
%r66 = trunc i64 %r65 to i32
%r67 = call i32 @extractHigh32(i64 %r65)
%r68 = zext i32 %r6 to i64
%r69 = zext i32 %r10 to i64
%r70 = shl i64 %r69, 32
%r71 = or i64 %r68, %r70
%r72 = zext i64 %r71 to i96
%r73 = zext i32 %r14 to i96
%r74 = shl i96 %r73, 64
%r75 = or i96 %r72, %r74
%r76 = zext i96 %r75 to i128
%r77 = zext i32 %r18 to i128
%r78 = shl i128 %r77, 96
%r79 = or i128 %r76, %r78
%r80 = zext i128 %r79 to i160
%r81 = zext i32 %r22 to i160
%r82 = shl i160 %r81, 128
%r83 = or i160 %r80, %r82
%r84 = zext i160 %r83 to i192
%r85 = zext i32 %r26 to i192
%r86 = shl i192 %r85, 160
%r87 = or i192 %r84, %r86
%r88 = zext i192 %r87 to i224
%r89 = zext i32 %r30 to i224
%r90 = shl i224 %r89, 192
%r91 = or i224 %r88, %r90
%r92 = zext i224 %r91 to i256
%r93 = zext i32 %r34 to i256
%r94 = shl i256 %r93, 224
%r95 = or i256 %r92, %r94
%r96 = zext i256 %r95 to i288
%r97 = zext i32 %r38 to i288
%r98 = shl i288 %r97, 256
%r99 = or i288 %r96, %r98
%r100 = zext i288 %r99 to i320
%r101 = zext i32 %r42 to i320
%r102 = shl i320 %r101, 288
%r103 = or i320 %r100, %r102
%r104 = zext i320 %r103 to i352
%r105 = zext i32 %r46 to i352
%r106 = shl i352 %r105, 320
%r107 = or i352 %r104, %r106
%r108 = zext i352 %r107 to i384
%r109 = zext i32 %r50 to i384
%r110 = shl i384 %r109, 352
%r111 = or i384 %r108, %r110
%r112 = zext i384 %r111 to i416
%r113 = zext i32 %r54 to i416
%r114 = shl i416 %r113, 384
%r115 = or i416 %r112, %r114
%r116 = zext i416 %r115 to i448
%r117 = zext i32 %r58 to i448
%r118 = shl i448 %r117, 416
%r119 = or i448 %r116, %r118
%r120 = zext i448 %r119 to i480
%r121 = zext i32 %r62 to i480
%r122 = shl i480 %r121, 448
%r123 = or i480 %r120, %r122
%r124 = zext i480 %r123 to i512
%r125 = zext i32 %r66 to i512
%r126 = shl i512 %r125, 480
%r127 = or i512 %r124, %r126
%r128 = zext i32 %r7 to i64
%r129 = zext i32 %r11 to i64
%r130 = shl i64 %r129, 32
%r131 = or i64 %r128, %r130
%r132 = zext i64 %r131 to i96
%r133 = zext i32 %r15 to i96
%r134 = shl i96 %r133, 64
%r135 = or i96 %r132, %r134
%r136 = zext i96 %r135 to i128
%r137 = zext i32 %r19 to i128
%r138 = shl i128 %r137, 96
%r139 = or i128 %r136, %r138
%r140 = zext i128 %r139 to i160
%r141 = zext i32 %r23 to i160
%r142 = shl i160 %r141, 128
%r143 = or i160 %r140, %r142
%r144 = zext i160 %r143 to i192
%r145 = zext i32 %r27 to i192
%r146 = shl i192 %r145, 160
%r147 = or i192 %r144, %r146
%r148 = zext i192 %r147 to i224
%r149 = zext i32 %r31 to i224
%r150 = shl i224 %r149, 192
%r151 = or i224 %r148, %r150
%r152 = zext i224 %r151 to i256
%r153 = zext i32 %r35 to i256
%r154 = shl i256 %r153, 224
%r155 = or i256 %r152, %r154
%r156 = zext i256 %r155 to i288
%r157 = zext i32 %r39 to i288
%r158 = shl i288 %r157, 256
%r159 = or i288 %r156, %r158
%r160 = zext i288 %r159 to i320
%r161 = zext i32 %r43 to i320
%r162 = shl i320 %r161, 288
%r163 = or i320 %r160, %r162
%r164 = zext i320 %r163 to i352
%r165 = zext i32 %r47 to i352
%r166 = shl i352 %r165, 320
%r167 = or i352 %r164, %r166
%r168 = zext i352 %r167 to i384
%r169 = zext i32 %r51 to i384
%r170 = shl i384 %r169, 352
%r171 = or i384 %r168, %r170
%r172 = zext i384 %r171 to i416
%r173 = zext i32 %r55 to i416
%r174 = shl i416 %r173, 384
%r175 = or i416 %r172, %r174
%r176 = zext i416 %r175 to i448
%r177 = zext i32 %r59 to i448
%r178 = shl i448 %r177, 416
%r179 = or i448 %r176, %r178
%r180 = zext i448 %r179 to i480
%r181 = zext i32 %r63 to i480
%r182 = shl i480 %r181, 448
%r183 = or i480 %r180, %r182
%r184 = zext i480 %r183 to i512
%r185 = zext i32 %r67 to i512
%r186 = shl i512 %r185, 480
%r187 = or i512 %r184, %r186
%r188 = zext i512 %r127 to i544
%r189 = zext i512 %r187 to i544
%r190 = shl i544 %r189, 32
%r191 = add i544 %r188, %r190
ret i544 %r191
}
define i32 @mclb_mulUnit16(i32* noalias  %r2, i32* noalias  %r3, i32 %r4)
{
%r5 = call i544 @mulUnit_inner512(i32* %r3, i32 %r4)
%r6 = trunc i544 %r5 to i512
%r8 = getelementptr i32, i32* %r2, i32 0
%r9 = trunc i512 %r6 to i32
store i32 %r9, i32* %r8
%r10 = lshr i512 %r6, 32
%r12 = getelementptr i32, i32* %r2, i32 1
%r13 = trunc i512 %r10 to i32
store i32 %r13, i32* %r12
%r14 = lshr i512 %r10, 32
%r16 = getelementptr i32, i32* %r2, i32 2
%r17 = trunc i512 %r14 to i32
store i32 %r17, i32* %r16
%r18 = lshr i512 %r14, 32
%r20 = getelementptr i32, i32* %r2, i32 3
%r21 = trunc i512 %r18 to i32
store i32 %r21, i32* %r20
%r22 = lshr i512 %r18, 32
%r24 = getelementptr i32, i32* %r2, i32 4
%r25 = trunc i512 %r22 to i32
store i32 %r25, i32* %r24
%r26 = lshr i512 %r22, 32
%r28 = getelementptr i32, i32* %r2, i32 5
%r29 = trunc i512 %r26 to i32
store i32 %r29, i32* %r28
%r30 = lshr i512 %r26, 32
%r32 = getelementptr i32, i32* %r2, i32 6
%r33 = trunc i512 %r30 to i32
store i32 %r33, i32* %r32
%r34 = lshr i512 %r30, 32
%r36 = getelementptr i32, i32* %r2, i32 7
%r37 = trunc i512 %r34 to i32
store i32 %r37, i32* %r36
%r38 = lshr i512 %r34, 32
%r40 = getelementptr i32, i32* %r2, i32 8
%r41 = trunc i512 %r38 to i32
store i32 %r41, i32* %r40
%r42 = lshr i512 %r38, 32
%r44 = getelementptr i32, i32* %r2, i32 9
%r45 = trunc i512 %r42 to i32
store i32 %r45, i32* %r44
%r46 = lshr i512 %r42, 32
%r48 = getelementptr i32, i32* %r2, i32 10
%r49 = trunc i512 %r46 to i32
store i32 %r49, i32* %r48
%r50 = lshr i512 %r46, 32
%r52 = getelementptr i32, i32* %r2, i32 11
%r53 = trunc i512 %r50 to i32
store i32 %r53, i32* %r52
%r54 = lshr i512 %r50, 32
%r56 = getelementptr i32, i32* %r2, i32 12
%r57 = trunc i512 %r54 to i32
store i32 %r57, i32* %r56
%r58 = lshr i512 %r54, 32
%r60 = getelementptr i32, i32* %r2, i32 13
%r61 = trunc i512 %r58 to i32
store i32 %r61, i32* %r60
%r62 = lshr i512 %r58, 32
%r64 = getelementptr i32, i32* %r2, i32 14
%r65 = trunc i512 %r62 to i32
store i32 %r65, i32* %r64
%r66 = lshr i512 %r62, 32
%r68 = getelementptr i32, i32* %r2, i32 15
%r69 = trunc i512 %r66 to i32
store i32 %r69, i32* %r68
%r70 = lshr i544 %r5, 512
%r71 = trunc i544 %r70 to i32
ret i32 %r71
}
define i32 @mclb_mulUnitAdd16(i32* noalias  %r2, i32* noalias  %r3, i32 %r4)
{
%r6 = call i64 @mulPos32x32(i32* %r3, i32 %r4, i32 0)
%r7 = trunc i64 %r6 to i32
%r8 = call i32 @extractHigh32(i64 %r6)
%r10 = call i64 @mulPos32x32(i32* %r3, i32 %r4, i32 1)
%r11 = trunc i64 %r10 to i32
%r12 = call i32 @extractHigh32(i64 %r10)
%r14 = call i64 @mulPos32x32(i32* %r3, i32 %r4, i32 2)
%r15 = trunc i64 %r14 to i32
%r16 = call i32 @extractHigh32(i64 %r14)
%r18 = call i64 @mulPos32x32(i32* %r3, i32 %r4, i32 3)
%r19 = trunc i64 %r18 to i32
%r20 = call i32 @extractHigh32(i64 %r18)
%r22 = call i64 @mulPos32x32(i32* %r3, i32 %r4, i32 4)
%r23 = trunc i64 %r22 to i32
%r24 = call i32 @extractHigh32(i64 %r22)
%r26 = call i64 @mulPos32x32(i32* %r3, i32 %r4, i32 5)
%r27 = trunc i64 %r26 to i32
%r28 = call i32 @extractHigh32(i64 %r26)
%r30 = call i64 @mulPos32x32(i32* %r3, i32 %r4, i32 6)
%r31 = trunc i64 %r30 to i32
%r32 = call i32 @extractHigh32(i64 %r30)
%r34 = call i64 @mulPos32x32(i32* %r3, i32 %r4, i32 7)
%r35 = trunc i64 %r34 to i32
%r36 = call i32 @extractHigh32(i64 %r34)
%r38 = call i64 @mulPos32x32(i32* %r3, i32 %r4, i32 8)
%r39 = trunc i64 %r38 to i32
%r40 = call i32 @extractHigh32(i64 %r38)
%r42 = call i64 @mulPos32x32(i32* %r3, i32 %r4, i32 9)
%r43 = trunc i64 %r42 to i32
%r44 = call i32 @extractHigh32(i64 %r42)
%r46 = call i64 @mulPos32x32(i32* %r3, i32 %r4, i32 10)
%r47 = trunc i64 %r46 to i32
%r48 = call i32 @extractHigh32(i64 %r46)
%r50 = call i64 @mulPos32x32(i32* %r3, i32 %r4, i32 11)
%r51 = trunc i64 %r50 to i32
%r52 = call i32 @extractHigh32(i64 %r50)
%r54 = call i64 @mulPos32x32(i32* %r3, i32 %r4, i32 12)
%r55 = trunc i64 %r54 to i32
%r56 = call i32 @extractHigh32(i64 %r54)
%r58 = call i64 @mulPos32x32(i32* %r3, i32 %r4, i32 13)
%r59 = trunc i64 %r58 to i32
%r60 = call i32 @extractHigh32(i64 %r58)
%r62 = call i64 @mulPos32x32(i32* %r3, i32 %r4, i32 14)
%r63 = trunc i64 %r62 to i32
%r64 = call i32 @extractHigh32(i64 %r62)
%r66 = call i64 @mulPos32x32(i32* %r3, i32 %r4, i32 15)
%r67 = trunc i64 %r66 to i32
%r68 = call i32 @extractHigh32(i64 %r66)
%r69 = zext i32 %r7 to i64
%r70 = zext i32 %r11 to i64
%r71 = shl i64 %r70, 32
%r72 = or i64 %r69, %r71
%r73 = zext i64 %r72 to i96
%r74 = zext i32 %r15 to i96
%r75 = shl i96 %r74, 64
%r76 = or i96 %r73, %r75
%r77 = zext i96 %r76 to i128
%r78 = zext i32 %r19 to i128
%r79 = shl i128 %r78, 96
%r80 = or i128 %r77, %r79
%r81 = zext i128 %r80 to i160
%r82 = zext i32 %r23 to i160
%r83 = shl i160 %r82, 128
%r84 = or i160 %r81, %r83
%r85 = zext i160 %r84 to i192
%r86 = zext i32 %r27 to i192
%r87 = shl i192 %r86, 160
%r88 = or i192 %r85, %r87
%r89 = zext i192 %r88 to i224
%r90 = zext i32 %r31 to i224
%r91 = shl i224 %r90, 192
%r92 = or i224 %r89, %r91
%r93 = zext i224 %r92 to i256
%r94 = zext i32 %r35 to i256
%r95 = shl i256 %r94, 224
%r96 = or i256 %r93, %r95
%r97 = zext i256 %r96 to i288
%r98 = zext i32 %r39 to i288
%r99 = shl i288 %r98, 256
%r100 = or i288 %r97, %r99
%r101 = zext i288 %r100 to i320
%r102 = zext i32 %r43 to i320
%r103 = shl i320 %r102, 288
%r104 = or i320 %r101, %r103
%r105 = zext i320 %r104 to i352
%r106 = zext i32 %r47 to i352
%r107 = shl i352 %r106, 320
%r108 = or i352 %r105, %r107
%r109 = zext i352 %r108 to i384
%r110 = zext i32 %r51 to i384
%r111 = shl i384 %r110, 352
%r112 = or i384 %r109, %r111
%r113 = zext i384 %r112 to i416
%r114 = zext i32 %r55 to i416
%r115 = shl i416 %r114, 384
%r116 = or i416 %r113, %r115
%r117 = zext i416 %r116 to i448
%r118 = zext i32 %r59 to i448
%r119 = shl i448 %r118, 416
%r120 = or i448 %r117, %r119
%r121 = zext i448 %r120 to i480
%r122 = zext i32 %r63 to i480
%r123 = shl i480 %r122, 448
%r124 = or i480 %r121, %r123
%r125 = zext i480 %r124 to i512
%r126 = zext i32 %r67 to i512
%r127 = shl i512 %r126, 480
%r128 = or i512 %r125, %r127
%r129 = zext i32 %r8 to i64
%r130 = zext i32 %r12 to i64
%r131 = shl i64 %r130, 32
%r132 = or i64 %r129, %r131
%r133 = zext i64 %r132 to i96
%r134 = zext i32 %r16 to i96
%r135 = shl i96 %r134, 64
%r136 = or i96 %r133, %r135
%r137 = zext i96 %r136 to i128
%r138 = zext i32 %r20 to i128
%r139 = shl i128 %r138, 96
%r140 = or i128 %r137, %r139
%r141 = zext i128 %r140 to i160
%r142 = zext i32 %r24 to i160
%r143 = shl i160 %r142, 128
%r144 = or i160 %r141, %r143
%r145 = zext i160 %r144 to i192
%r146 = zext i32 %r28 to i192
%r147 = shl i192 %r146, 160
%r148 = or i192 %r145, %r147
%r149 = zext i192 %r148 to i224
%r150 = zext i32 %r32 to i224
%r151 = shl i224 %r150, 192
%r152 = or i224 %r149, %r151
%r153 = zext i224 %r152 to i256
%r154 = zext i32 %r36 to i256
%r155 = shl i256 %r154, 224
%r156 = or i256 %r153, %r155
%r157 = zext i256 %r156 to i288
%r158 = zext i32 %r40 to i288
%r159 = shl i288 %r158, 256
%r160 = or i288 %r157, %r159
%r161 = zext i288 %r160 to i320
%r162 = zext i32 %r44 to i320
%r163 = shl i320 %r162, 288
%r164 = or i320 %r161, %r163
%r165 = zext i320 %r164 to i352
%r166 = zext i32 %r48 to i352
%r167 = shl i352 %r166, 320
%r168 = or i352 %r165, %r167
%r169 = zext i352 %r168 to i384
%r170 = zext i32 %r52 to i384
%r171 = shl i384 %r170, 352
%r172 = or i384 %r169, %r171
%r173 = zext i384 %r172 to i416
%r174 = zext i32 %r56 to i416
%r175 = shl i416 %r174, 384
%r176 = or i416 %r173, %r175
%r177 = zext i416 %r176 to i448
%r178 = zext i32 %r60 to i448
%r179 = shl i448 %r178, 416
%r180 = or i448 %r177, %r179
%r181 = zext i448 %r180 to i480
%r182 = zext i32 %r64 to i480
%r183 = shl i480 %r182, 448
%r184 = or i480 %r181, %r183
%r185 = zext i480 %r184 to i512
%r186 = zext i32 %r68 to i512
%r187 = shl i512 %r186, 480
%r188 = or i512 %r185, %r187
%r189 = zext i512 %r128 to i544
%r190 = zext i512 %r188 to i544
%r191 = shl i544 %r190, 32
%r192 = add i544 %r189, %r191
%r194 = bitcast i32* %r2 to i512*
%r195 = load i512, i512* %r194
%r196 = zext i512 %r195 to i544
%r197 = add i544 %r192, %r196
%r198 = trunc i544 %r197 to i512
%r200 = getelementptr i32, i32* %r2, i32 0
%r201 = trunc i512 %r198 to i32
store i32 %r201, i32* %r200
%r202 = lshr i512 %r198, 32
%r204 = getelementptr i32, i32* %r2, i32 1
%r205 = trunc i512 %r202 to i32
store i32 %r205, i32* %r204
%r206 = lshr i512 %r202, 32
%r208 = getelementptr i32, i32* %r2, i32 2
%r209 = trunc i512 %r206 to i32
store i32 %r209, i32* %r208
%r210 = lshr i512 %r206, 32
%r212 = getelementptr i32, i32* %r2, i32 3
%r213 = trunc i512 %r210 to i32
store i32 %r213, i32* %r212
%r214 = lshr i512 %r210, 32
%r216 = getelementptr i32, i32* %r2, i32 4
%r217 = trunc i512 %r214 to i32
store i32 %r217, i32* %r216
%r218 = lshr i512 %r214, 32
%r220 = getelementptr i32, i32* %r2, i32 5
%r221 = trunc i512 %r218 to i32
store i32 %r221, i32* %r220
%r222 = lshr i512 %r218, 32
%r224 = getelementptr i32, i32* %r2, i32 6
%r225 = trunc i512 %r222 to i32
store i32 %r225, i32* %r224
%r226 = lshr i512 %r222, 32
%r228 = getelementptr i32, i32* %r2, i32 7
%r229 = trunc i512 %r226 to i32
store i32 %r229, i32* %r228
%r230 = lshr i512 %r226, 32
%r232 = getelementptr i32, i32* %r2, i32 8
%r233 = trunc i512 %r230 to i32
store i32 %r233, i32* %r232
%r234 = lshr i512 %r230, 32
%r236 = getelementptr i32, i32* %r2, i32 9
%r237 = trunc i512 %r234 to i32
store i32 %r237, i32* %r236
%r238 = lshr i512 %r234, 32
%r240 = getelementptr i32, i32* %r2, i32 10
%r241 = trunc i512 %r238 to i32
store i32 %r241, i32* %r240
%r242 = lshr i512 %r238, 32
%r244 = getelementptr i32, i32* %r2, i32 11
%r245 = trunc i512 %r242 to i32
store i32 %r245, i32* %r244
%r246 = lshr i512 %r242, 32
%r248 = getelementptr i32, i32* %r2, i32 12
%r249 = trunc i512 %r246 to i32
store i32 %r249, i32* %r248
%r250 = lshr i512 %r246, 32
%r252 = getelementptr i32, i32* %r2, i32 13
%r253 = trunc i512 %r250 to i32
store i32 %r253, i32* %r252
%r254 = lshr i512 %r250, 32
%r256 = getelementptr i32, i32* %r2, i32 14
%r257 = trunc i512 %r254 to i32
store i32 %r257, i32* %r256
%r258 = lshr i512 %r254, 32
%r260 = getelementptr i32, i32* %r2, i32 15
%r261 = trunc i512 %r258 to i32
store i32 %r261, i32* %r260
%r262 = lshr i544 %r197, 512
%r263 = trunc i544 %r262 to i32
ret i32 %r263
}
define void @mclb_mul16(i32* noalias  %r1, i32* noalias  %r2, i32* noalias  %r3)
{
%r5 = getelementptr i32, i32* %r2, i32 8
%r7 = getelementptr i32, i32* %r3, i32 8
%r9 = getelementptr i32, i32* %r1, i32 16
call void @mclb_mul8(i32* %r1, i32* %r2, i32* %r3)
call void @mclb_mul8(i32* %r9, i32* %r5, i32* %r7)
%r11 = bitcast i32* %r5 to i256*
%r12 = load i256, i256* %r11
%r13 = zext i256 %r12 to i288
%r15 = bitcast i32* %r2 to i256*
%r16 = load i256, i256* %r15
%r17 = zext i256 %r16 to i288
%r19 = bitcast i32* %r7 to i256*
%r20 = load i256, i256* %r19
%r21 = zext i256 %r20 to i288
%r23 = bitcast i32* %r3 to i256*
%r24 = load i256, i256* %r23
%r25 = zext i256 %r24 to i288
%r26 = add i288 %r13, %r17
%r27 = add i288 %r21, %r25
%r29 = alloca i32, i32 16
%r30 = trunc i288 %r26 to i256
%r31 = trunc i288 %r27 to i256
%r32 = lshr i288 %r26, 256
%r33 = trunc i288 %r32 to i1
%r34 = lshr i288 %r27, 256
%r35 = trunc i288 %r34 to i1
%r36 = and i1 %r33, %r35
%r38 = select i1 %r33, i256 %r31, i256 0
%r40 = select i1 %r35, i256 %r30, i256 0
%r42 = alloca i32, i32 8
%r44 = alloca i32, i32 8
%r46 = getelementptr i32, i32* %r42, i32 0
%r47 = trunc i256 %r30 to i32
store i32 %r47, i32* %r46
%r48 = lshr i256 %r30, 32
%r50 = getelementptr i32, i32* %r42, i32 1
%r51 = trunc i256 %r48 to i32
store i32 %r51, i32* %r50
%r52 = lshr i256 %r48, 32
%r54 = getelementptr i32, i32* %r42, i32 2
%r55 = trunc i256 %r52 to i32
store i32 %r55, i32* %r54
%r56 = lshr i256 %r52, 32
%r58 = getelementptr i32, i32* %r42, i32 3
%r59 = trunc i256 %r56 to i32
store i32 %r59, i32* %r58
%r60 = lshr i256 %r56, 32
%r62 = getelementptr i32, i32* %r42, i32 4
%r63 = trunc i256 %r60 to i32
store i32 %r63, i32* %r62
%r64 = lshr i256 %r60, 32
%r66 = getelementptr i32, i32* %r42, i32 5
%r67 = trunc i256 %r64 to i32
store i32 %r67, i32* %r66
%r68 = lshr i256 %r64, 32
%r70 = getelementptr i32, i32* %r42, i32 6
%r71 = trunc i256 %r68 to i32
store i32 %r71, i32* %r70
%r72 = lshr i256 %r68, 32
%r74 = getelementptr i32, i32* %r42, i32 7
%r75 = trunc i256 %r72 to i32
store i32 %r75, i32* %r74
%r77 = getelementptr i32, i32* %r44, i32 0
%r78 = trunc i256 %r31 to i32
store i32 %r78, i32* %r77
%r79 = lshr i256 %r31, 32
%r81 = getelementptr i32, i32* %r44, i32 1
%r82 = trunc i256 %r79 to i32
store i32 %r82, i32* %r81
%r83 = lshr i256 %r79, 32
%r85 = getelementptr i32, i32* %r44, i32 2
%r86 = trunc i256 %r83 to i32
store i32 %r86, i32* %r85
%r87 = lshr i256 %r83, 32
%r89 = getelementptr i32, i32* %r44, i32 3
%r90 = trunc i256 %r87 to i32
store i32 %r90, i32* %r89
%r91 = lshr i256 %r87, 32
%r93 = getelementptr i32, i32* %r44, i32 4
%r94 = trunc i256 %r91 to i32
store i32 %r94, i32* %r93
%r95 = lshr i256 %r91, 32
%r97 = getelementptr i32, i32* %r44, i32 5
%r98 = trunc i256 %r95 to i32
store i32 %r98, i32* %r97
%r99 = lshr i256 %r95, 32
%r101 = getelementptr i32, i32* %r44, i32 6
%r102 = trunc i256 %r99 to i32
store i32 %r102, i32* %r101
%r103 = lshr i256 %r99, 32
%r105 = getelementptr i32, i32* %r44, i32 7
%r106 = trunc i256 %r103 to i32
store i32 %r106, i32* %r105
call void @mclb_mul8(i32* %r29, i32* %r42, i32* %r44)
%r108 = bitcast i32* %r29 to i512*
%r109 = load i512, i512* %r108
%r110 = zext i512 %r109 to i544
%r111 = zext i1 %r36 to i544
%r112 = shl i544 %r111, 512
%r113 = or i544 %r110, %r112
%r114 = zext i256 %r38 to i544
%r115 = zext i256 %r40 to i544
%r116 = shl i544 %r114, 256
%r117 = shl i544 %r115, 256
%r118 = add i544 %r113, %r116
%r119 = add i544 %r118, %r117
%r121 = bitcast i32* %r1 to i512*
%r122 = load i512, i512* %r121
%r123 = zext i512 %r122 to i544
%r124 = sub i544 %r119, %r123
%r126 = getelementptr i32, i32* %r1, i32 16
%r128 = bitcast i32* %r126 to i512*
%r129 = load i512, i512* %r128
%r130 = zext i512 %r129 to i544
%r131 = sub i544 %r124, %r130
%r132 = zext i544 %r131 to i768
%r134 = getelementptr i32, i32* %r1, i32 8
%r136 = bitcast i32* %r134 to i768*
%r137 = load i768, i768* %r136
%r138 = add i768 %r132, %r137
%r140 = getelementptr i32, i32* %r1, i32 8
%r142 = getelementptr i32, i32* %r140, i32 0
%r143 = trunc i768 %r138 to i32
store i32 %r143, i32* %r142
%r144 = lshr i768 %r138, 32
%r146 = getelementptr i32, i32* %r140, i32 1
%r147 = trunc i768 %r144 to i32
store i32 %r147, i32* %r146
%r148 = lshr i768 %r144, 32
%r150 = getelementptr i32, i32* %r140, i32 2
%r151 = trunc i768 %r148 to i32
store i32 %r151, i32* %r150
%r152 = lshr i768 %r148, 32
%r154 = getelementptr i32, i32* %r140, i32 3
%r155 = trunc i768 %r152 to i32
store i32 %r155, i32* %r154
%r156 = lshr i768 %r152, 32
%r158 = getelementptr i32, i32* %r140, i32 4
%r159 = trunc i768 %r156 to i32
store i32 %r159, i32* %r158
%r160 = lshr i768 %r156, 32
%r162 = getelementptr i32, i32* %r140, i32 5
%r163 = trunc i768 %r160 to i32
store i32 %r163, i32* %r162
%r164 = lshr i768 %r160, 32
%r166 = getelementptr i32, i32* %r140, i32 6
%r167 = trunc i768 %r164 to i32
store i32 %r167, i32* %r166
%r168 = lshr i768 %r164, 32
%r170 = getelementptr i32, i32* %r140, i32 7
%r171 = trunc i768 %r168 to i32
store i32 %r171, i32* %r170
%r172 = lshr i768 %r168, 32
%r174 = getelementptr i32, i32* %r140, i32 8
%r175 = trunc i768 %r172 to i32
store i32 %r175, i32* %r174
%r176 = lshr i768 %r172, 32
%r178 = getelementptr i32, i32* %r140, i32 9
%r179 = trunc i768 %r176 to i32
store i32 %r179, i32* %r178
%r180 = lshr i768 %r176, 32
%r182 = getelementptr i32, i32* %r140, i32 10
%r183 = trunc i768 %r180 to i32
store i32 %r183, i32* %r182
%r184 = lshr i768 %r180, 32
%r186 = getelementptr i32, i32* %r140, i32 11
%r187 = trunc i768 %r184 to i32
store i32 %r187, i32* %r186
%r188 = lshr i768 %r184, 32
%r190 = getelementptr i32, i32* %r140, i32 12
%r191 = trunc i768 %r188 to i32
store i32 %r191, i32* %r190
%r192 = lshr i768 %r188, 32
%r194 = getelementptr i32, i32* %r140, i32 13
%r195 = trunc i768 %r192 to i32
store i32 %r195, i32* %r194
%r196 = lshr i768 %r192, 32
%r198 = getelementptr i32, i32* %r140, i32 14
%r199 = trunc i768 %r196 to i32
store i32 %r199, i32* %r198
%r200 = lshr i768 %r196, 32
%r202 = getelementptr i32, i32* %r140, i32 15
%r203 = trunc i768 %r200 to i32
store i32 %r203, i32* %r202
%r204 = lshr i768 %r200, 32
%r206 = getelementptr i32, i32* %r140, i32 16
%r207 = trunc i768 %r204 to i32
store i32 %r207, i32* %r206
%r208 = lshr i768 %r204, 32
%r210 = getelementptr i32, i32* %r140, i32 17
%r211 = trunc i768 %r208 to i32
store i32 %r211, i32* %r210
%r212 = lshr i768 %r208, 32
%r214 = getelementptr i32, i32* %r140, i32 18
%r215 = trunc i768 %r212 to i32
store i32 %r215, i32* %r214
%r216 = lshr i768 %r212, 32
%r218 = getelementptr i32, i32* %r140, i32 19
%r219 = trunc i768 %r216 to i32
store i32 %r219, i32* %r218
%r220 = lshr i768 %r216, 32
%r222 = getelementptr i32, i32* %r140, i32 20
%r223 = trunc i768 %r220 to i32
store i32 %r223, i32* %r222
%r224 = lshr i768 %r220, 32
%r226 = getelementptr i32, i32* %r140, i32 21
%r227 = trunc i768 %r224 to i32
store i32 %r227, i32* %r226
%r228 = lshr i768 %r224, 32
%r230 = getelementptr i32, i32* %r140, i32 22
%r231 = trunc i768 %r228 to i32
store i32 %r231, i32* %r230
%r232 = lshr i768 %r228, 32
%r234 = getelementptr i32, i32* %r140, i32 23
%r235 = trunc i768 %r232 to i32
store i32 %r235, i32* %r234
ret void
}
define void @mclb_sqr16(i32* noalias  %r1, i32* noalias  %r2)
{
%r4 = getelementptr i32, i32* %r2, i32 8
%r6 = getelementptr i32, i32* %r1, i32 16
%r8 = alloca i32, i32 16
call void @mclb_mul8(i32* %r8, i32* %r2, i32* %r4)
call void @mclb_sqr8(i32* %r1, i32* %r2)
call void @mclb_sqr8(i32* %r6, i32* %r4)
%r10 = bitcast i32* %r8 to i512*
%r11 = load i512, i512* %r10
%r12 = zext i512 %r11 to i544
%r13 = add i544 %r12, %r12
%r14 = zext i544 %r13 to i768
%r16 = getelementptr i32, i32* %r1, i32 8
%r18 = bitcast i32* %r16 to i768*
%r19 = load i768, i768* %r18
%r20 = add i768 %r19, %r14
%r22 = getelementptr i32, i32* %r16, i32 0
%r23 = trunc i768 %r20 to i32
store i32 %r23, i32* %r22
%r24 = lshr i768 %r20, 32
%r26 = getelementptr i32, i32* %r16, i32 1
%r27 = trunc i768 %r24 to i32
store i32 %r27, i32* %r26
%r28 = lshr i768 %r24, 32
%r30 = getelementptr i32, i32* %r16, i32 2
%r31 = trunc i768 %r28 to i32
store i32 %r31, i32* %r30
%r32 = lshr i768 %r28, 32
%r34 = getelementptr i32, i32* %r16, i32 3
%r35 = trunc i768 %r32 to i32
store i32 %r35, i32* %r34
%r36 = lshr i768 %r32, 32
%r38 = getelementptr i32, i32* %r16, i32 4
%r39 = trunc i768 %r36 to i32
store i32 %r39, i32* %r38
%r40 = lshr i768 %r36, 32
%r42 = getelementptr i32, i32* %r16, i32 5
%r43 = trunc i768 %r40 to i32
store i32 %r43, i32* %r42
%r44 = lshr i768 %r40, 32
%r46 = getelementptr i32, i32* %r16, i32 6
%r47 = trunc i768 %r44 to i32
store i32 %r47, i32* %r46
%r48 = lshr i768 %r44, 32
%r50 = getelementptr i32, i32* %r16, i32 7
%r51 = trunc i768 %r48 to i32
store i32 %r51, i32* %r50
%r52 = lshr i768 %r48, 32
%r54 = getelementptr i32, i32* %r16, i32 8
%r55 = trunc i768 %r52 to i32
store i32 %r55, i32* %r54
%r56 = lshr i768 %r52, 32
%r58 = getelementptr i32, i32* %r16, i32 9
%r59 = trunc i768 %r56 to i32
store i32 %r59, i32* %r58
%r60 = lshr i768 %r56, 32
%r62 = getelementptr i32, i32* %r16, i32 10
%r63 = trunc i768 %r60 to i32
store i32 %r63, i32* %r62
%r64 = lshr i768 %r60, 32
%r66 = getelementptr i32, i32* %r16, i32 11
%r67 = trunc i768 %r64 to i32
store i32 %r67, i32* %r66
%r68 = lshr i768 %r64, 32
%r70 = getelementptr i32, i32* %r16, i32 12
%r71 = trunc i768 %r68 to i32
store i32 %r71, i32* %r70
%r72 = lshr i768 %r68, 32
%r74 = getelementptr i32, i32* %r16, i32 13
%r75 = trunc i768 %r72 to i32
store i32 %r75, i32* %r74
%r76 = lshr i768 %r72, 32
%r78 = getelementptr i32, i32* %r16, i32 14
%r79 = trunc i768 %r76 to i32
store i32 %r79, i32* %r78
%r80 = lshr i768 %r76, 32
%r82 = getelementptr i32, i32* %r16, i32 15
%r83 = trunc i768 %r80 to i32
store i32 %r83, i32* %r82
%r84 = lshr i768 %r80, 32
%r86 = getelementptr i32, i32* %r16, i32 16
%r87 = trunc i768 %r84 to i32
store i32 %r87, i32* %r86
%r88 = lshr i768 %r84, 32
%r90 = getelementptr i32, i32* %r16, i32 17
%r91 = trunc i768 %r88 to i32
store i32 %r91, i32* %r90
%r92 = lshr i768 %r88, 32
%r94 = getelementptr i32, i32* %r16, i32 18
%r95 = trunc i768 %r92 to i32
store i32 %r95, i32* %r94
%r96 = lshr i768 %r92, 32
%r98 = getelementptr i32, i32* %r16, i32 19
%r99 = trunc i768 %r96 to i32
store i32 %r99, i32* %r98
%r100 = lshr i768 %r96, 32
%r102 = getelementptr i32, i32* %r16, i32 20
%r103 = trunc i768 %r100 to i32
store i32 %r103, i32* %r102
%r104 = lshr i768 %r100, 32
%r106 = getelementptr i32, i32* %r16, i32 21
%r107 = trunc i768 %r104 to i32
store i32 %r107, i32* %r106
%r108 = lshr i768 %r104, 32
%r110 = getelementptr i32, i32* %r16, i32 22
%r111 = trunc i768 %r108 to i32
store i32 %r111, i32* %r110
%r112 = lshr i768 %r108, 32
%r114 = getelementptr i32, i32* %r16, i32 23
%r115 = trunc i768 %r112 to i32
store i32 %r115, i32* %r114
ret void
}
define i576 @mulUnit_inner544(i32* noalias  %r2, i32 %r3)
{
%r5 = call i64 @mulPos32x32(i32* %r2, i32 %r3, i32 0)
%r6 = trunc i64 %r5 to i32
%r7 = call i32 @extractHigh32(i64 %r5)
%r9 = call i64 @mulPos32x32(i32* %r2, i32 %r3, i32 1)
%r10 = trunc i64 %r9 to i32
%r11 = call i32 @extractHigh32(i64 %r9)
%r13 = call i64 @mulPos32x32(i32* %r2, i32 %r3, i32 2)
%r14 = trunc i64 %r13 to i32
%r15 = call i32 @extractHigh32(i64 %r13)
%r17 = call i64 @mulPos32x32(i32* %r2, i32 %r3, i32 3)
%r18 = trunc i64 %r17 to i32
%r19 = call i32 @extractHigh32(i64 %r17)
%r21 = call i64 @mulPos32x32(i32* %r2, i32 %r3, i32 4)
%r22 = trunc i64 %r21 to i32
%r23 = call i32 @extractHigh32(i64 %r21)
%r25 = call i64 @mulPos32x32(i32* %r2, i32 %r3, i32 5)
%r26 = trunc i64 %r25 to i32
%r27 = call i32 @extractHigh32(i64 %r25)
%r29 = call i64 @mulPos32x32(i32* %r2, i32 %r3, i32 6)
%r30 = trunc i64 %r29 to i32
%r31 = call i32 @extractHigh32(i64 %r29)
%r33 = call i64 @mulPos32x32(i32* %r2, i32 %r3, i32 7)
%r34 = trunc i64 %r33 to i32
%r35 = call i32 @extractHigh32(i64 %r33)
%r37 = call i64 @mulPos32x32(i32* %r2, i32 %r3, i32 8)
%r38 = trunc i64 %r37 to i32
%r39 = call i32 @extractHigh32(i64 %r37)
%r41 = call i64 @mulPos32x32(i32* %r2, i32 %r3, i32 9)
%r42 = trunc i64 %r41 to i32
%r43 = call i32 @extractHigh32(i64 %r41)
%r45 = call i64 @mulPos32x32(i32* %r2, i32 %r3, i32 10)
%r46 = trunc i64 %r45 to i32
%r47 = call i32 @extractHigh32(i64 %r45)
%r49 = call i64 @mulPos32x32(i32* %r2, i32 %r3, i32 11)
%r50 = trunc i64 %r49 to i32
%r51 = call i32 @extractHigh32(i64 %r49)
%r53 = call i64 @mulPos32x32(i32* %r2, i32 %r3, i32 12)
%r54 = trunc i64 %r53 to i32
%r55 = call i32 @extractHigh32(i64 %r53)
%r57 = call i64 @mulPos32x32(i32* %r2, i32 %r3, i32 13)
%r58 = trunc i64 %r57 to i32
%r59 = call i32 @extractHigh32(i64 %r57)
%r61 = call i64 @mulPos32x32(i32* %r2, i32 %r3, i32 14)
%r62 = trunc i64 %r61 to i32
%r63 = call i32 @extractHigh32(i64 %r61)
%r65 = call i64 @mulPos32x32(i32* %r2, i32 %r3, i32 15)
%r66 = trunc i64 %r65 to i32
%r67 = call i32 @extractHigh32(i64 %r65)
%r69 = call i64 @mulPos32x32(i32* %r2, i32 %r3, i32 16)
%r70 = trunc i64 %r69 to i32
%r71 = call i32 @extractHigh32(i64 %r69)
%r72 = zext i32 %r6 to i64
%r73 = zext i32 %r10 to i64
%r74 = shl i64 %r73, 32
%r75 = or i64 %r72, %r74
%r76 = zext i64 %r75 to i96
%r77 = zext i32 %r14 to i96
%r78 = shl i96 %r77, 64
%r79 = or i96 %r76, %r78
%r80 = zext i96 %r79 to i128
%r81 = zext i32 %r18 to i128
%r82 = shl i128 %r81, 96
%r83 = or i128 %r80, %r82
%r84 = zext i128 %r83 to i160
%r85 = zext i32 %r22 to i160
%r86 = shl i160 %r85, 128
%r87 = or i160 %r84, %r86
%r88 = zext i160 %r87 to i192
%r89 = zext i32 %r26 to i192
%r90 = shl i192 %r89, 160
%r91 = or i192 %r88, %r90
%r92 = zext i192 %r91 to i224
%r93 = zext i32 %r30 to i224
%r94 = shl i224 %r93, 192
%r95 = or i224 %r92, %r94
%r96 = zext i224 %r95 to i256
%r97 = zext i32 %r34 to i256
%r98 = shl i256 %r97, 224
%r99 = or i256 %r96, %r98
%r100 = zext i256 %r99 to i288
%r101 = zext i32 %r38 to i288
%r102 = shl i288 %r101, 256
%r103 = or i288 %r100, %r102
%r104 = zext i288 %r103 to i320
%r105 = zext i32 %r42 to i320
%r106 = shl i320 %r105, 288
%r107 = or i320 %r104, %r106
%r108 = zext i320 %r107 to i352
%r109 = zext i32 %r46 to i352
%r110 = shl i352 %r109, 320
%r111 = or i352 %r108, %r110
%r112 = zext i352 %r111 to i384
%r113 = zext i32 %r50 to i384
%r114 = shl i384 %r113, 352
%r115 = or i384 %r112, %r114
%r116 = zext i384 %r115 to i416
%r117 = zext i32 %r54 to i416
%r118 = shl i416 %r117, 384
%r119 = or i416 %r116, %r118
%r120 = zext i416 %r119 to i448
%r121 = zext i32 %r58 to i448
%r122 = shl i448 %r121, 416
%r123 = or i448 %r120, %r122
%r124 = zext i448 %r123 to i480
%r125 = zext i32 %r62 to i480
%r126 = shl i480 %r125, 448
%r127 = or i480 %r124, %r126
%r128 = zext i480 %r127 to i512
%r129 = zext i32 %r66 to i512
%r130 = shl i512 %r129, 480
%r131 = or i512 %r128, %r130
%r132 = zext i512 %r131 to i544
%r133 = zext i32 %r70 to i544
%r134 = shl i544 %r133, 512
%r135 = or i544 %r132, %r134
%r136 = zext i32 %r7 to i64
%r137 = zext i32 %r11 to i64
%r138 = shl i64 %r137, 32
%r139 = or i64 %r136, %r138
%r140 = zext i64 %r139 to i96
%r141 = zext i32 %r15 to i96
%r142 = shl i96 %r141, 64
%r143 = or i96 %r140, %r142
%r144 = zext i96 %r143 to i128
%r145 = zext i32 %r19 to i128
%r146 = shl i128 %r145, 96
%r147 = or i128 %r144, %r146
%r148 = zext i128 %r147 to i160
%r149 = zext i32 %r23 to i160
%r150 = shl i160 %r149, 128
%r151 = or i160 %r148, %r150
%r152 = zext i160 %r151 to i192
%r153 = zext i32 %r27 to i192
%r154 = shl i192 %r153, 160
%r155 = or i192 %r152, %r154
%r156 = zext i192 %r155 to i224
%r157 = zext i32 %r31 to i224
%r158 = shl i224 %r157, 192
%r159 = or i224 %r156, %r158
%r160 = zext i224 %r159 to i256
%r161 = zext i32 %r35 to i256
%r162 = shl i256 %r161, 224
%r163 = or i256 %r160, %r162
%r164 = zext i256 %r163 to i288
%r165 = zext i32 %r39 to i288
%r166 = shl i288 %r165, 256
%r167 = or i288 %r164, %r166
%r168 = zext i288 %r167 to i320
%r169 = zext i32 %r43 to i320
%r170 = shl i320 %r169, 288
%r171 = or i320 %r168, %r170
%r172 = zext i320 %r171 to i352
%r173 = zext i32 %r47 to i352
%r174 = shl i352 %r173, 320
%r175 = or i352 %r172, %r174
%r176 = zext i352 %r175 to i384
%r177 = zext i32 %r51 to i384
%r178 = shl i384 %r177, 352
%r179 = or i384 %r176, %r178
%r180 = zext i384 %r179 to i416
%r181 = zext i32 %r55 to i416
%r182 = shl i416 %r181, 384
%r183 = or i416 %r180, %r182
%r184 = zext i416 %r183 to i448
%r185 = zext i32 %r59 to i448
%r186 = shl i448 %r185, 416
%r187 = or i448 %r184, %r186
%r188 = zext i448 %r187 to i480
%r189 = zext i32 %r63 to i480
%r190 = shl i480 %r189, 448
%r191 = or i480 %r188, %r190
%r192 = zext i480 %r191 to i512
%r193 = zext i32 %r67 to i512
%r194 = shl i512 %r193, 480
%r195 = or i512 %r192, %r194
%r196 = zext i512 %r195 to i544
%r197 = zext i32 %r71 to i544
%r198 = shl i544 %r197, 512
%r199 = or i544 %r196, %r198
%r200 = zext i544 %r135 to i576
%r201 = zext i544 %r199 to i576
%r202 = shl i576 %r201, 32
%r203 = add i576 %r200, %r202
ret i576 %r203
}
define i32 @mclb_mulUnit17(i32* noalias  %r2, i32* noalias  %r3, i32 %r4)
{
%r5 = call i576 @mulUnit_inner544(i32* %r3, i32 %r4)
%r6 = trunc i576 %r5 to i544
%r8 = getelementptr i32, i32* %r2, i32 0
%r9 = trunc i544 %r6 to i32
store i32 %r9, i32* %r8
%r10 = lshr i544 %r6, 32
%r12 = getelementptr i32, i32* %r2, i32 1
%r13 = trunc i544 %r10 to i32
store i32 %r13, i32* %r12
%r14 = lshr i544 %r10, 32
%r16 = getelementptr i32, i32* %r2, i32 2
%r17 = trunc i544 %r14 to i32
store i32 %r17, i32* %r16
%r18 = lshr i544 %r14, 32
%r20 = getelementptr i32, i32* %r2, i32 3
%r21 = trunc i544 %r18 to i32
store i32 %r21, i32* %r20
%r22 = lshr i544 %r18, 32
%r24 = getelementptr i32, i32* %r2, i32 4
%r25 = trunc i544 %r22 to i32
store i32 %r25, i32* %r24
%r26 = lshr i544 %r22, 32
%r28 = getelementptr i32, i32* %r2, i32 5
%r29 = trunc i544 %r26 to i32
store i32 %r29, i32* %r28
%r30 = lshr i544 %r26, 32
%r32 = getelementptr i32, i32* %r2, i32 6
%r33 = trunc i544 %r30 to i32
store i32 %r33, i32* %r32
%r34 = lshr i544 %r30, 32
%r36 = getelementptr i32, i32* %r2, i32 7
%r37 = trunc i544 %r34 to i32
store i32 %r37, i32* %r36
%r38 = lshr i544 %r34, 32
%r40 = getelementptr i32, i32* %r2, i32 8
%r41 = trunc i544 %r38 to i32
store i32 %r41, i32* %r40
%r42 = lshr i544 %r38, 32
%r44 = getelementptr i32, i32* %r2, i32 9
%r45 = trunc i544 %r42 to i32
store i32 %r45, i32* %r44
%r46 = lshr i544 %r42, 32
%r48 = getelementptr i32, i32* %r2, i32 10
%r49 = trunc i544 %r46 to i32
store i32 %r49, i32* %r48
%r50 = lshr i544 %r46, 32
%r52 = getelementptr i32, i32* %r2, i32 11
%r53 = trunc i544 %r50 to i32
store i32 %r53, i32* %r52
%r54 = lshr i544 %r50, 32
%r56 = getelementptr i32, i32* %r2, i32 12
%r57 = trunc i544 %r54 to i32
store i32 %r57, i32* %r56
%r58 = lshr i544 %r54, 32
%r60 = getelementptr i32, i32* %r2, i32 13
%r61 = trunc i544 %r58 to i32
store i32 %r61, i32* %r60
%r62 = lshr i544 %r58, 32
%r64 = getelementptr i32, i32* %r2, i32 14
%r65 = trunc i544 %r62 to i32
store i32 %r65, i32* %r64
%r66 = lshr i544 %r62, 32
%r68 = getelementptr i32, i32* %r2, i32 15
%r69 = trunc i544 %r66 to i32
store i32 %r69, i32* %r68
%r70 = lshr i544 %r66, 32
%r72 = getelementptr i32, i32* %r2, i32 16
%r73 = trunc i544 %r70 to i32
store i32 %r73, i32* %r72
%r74 = lshr i576 %r5, 544
%r75 = trunc i576 %r74 to i32
ret i32 %r75
}
define i32 @mclb_mulUnitAdd17(i32* noalias  %r2, i32* noalias  %r3, i32 %r4)
{
%r6 = call i64 @mulPos32x32(i32* %r3, i32 %r4, i32 0)
%r7 = trunc i64 %r6 to i32
%r8 = call i32 @extractHigh32(i64 %r6)
%r10 = call i64 @mulPos32x32(i32* %r3, i32 %r4, i32 1)
%r11 = trunc i64 %r10 to i32
%r12 = call i32 @extractHigh32(i64 %r10)
%r14 = call i64 @mulPos32x32(i32* %r3, i32 %r4, i32 2)
%r15 = trunc i64 %r14 to i32
%r16 = call i32 @extractHigh32(i64 %r14)
%r18 = call i64 @mulPos32x32(i32* %r3, i32 %r4, i32 3)
%r19 = trunc i64 %r18 to i32
%r20 = call i32 @extractHigh32(i64 %r18)
%r22 = call i64 @mulPos32x32(i32* %r3, i32 %r4, i32 4)
%r23 = trunc i64 %r22 to i32
%r24 = call i32 @extractHigh32(i64 %r22)
%r26 = call i64 @mulPos32x32(i32* %r3, i32 %r4, i32 5)
%r27 = trunc i64 %r26 to i32
%r28 = call i32 @extractHigh32(i64 %r26)
%r30 = call i64 @mulPos32x32(i32* %r3, i32 %r4, i32 6)
%r31 = trunc i64 %r30 to i32
%r32 = call i32 @extractHigh32(i64 %r30)
%r34 = call i64 @mulPos32x32(i32* %r3, i32 %r4, i32 7)
%r35 = trunc i64 %r34 to i32
%r36 = call i32 @extractHigh32(i64 %r34)
%r38 = call i64 @mulPos32x32(i32* %r3, i32 %r4, i32 8)
%r39 = trunc i64 %r38 to i32
%r40 = call i32 @extractHigh32(i64 %r38)
%r42 = call i64 @mulPos32x32(i32* %r3, i32 %r4, i32 9)
%r43 = trunc i64 %r42 to i32
%r44 = call i32 @extractHigh32(i64 %r42)
%r46 = call i64 @mulPos32x32(i32* %r3, i32 %r4, i32 10)
%r47 = trunc i64 %r46 to i32
%r48 = call i32 @extractHigh32(i64 %r46)
%r50 = call i64 @mulPos32x32(i32* %r3, i32 %r4, i32 11)
%r51 = trunc i64 %r50 to i32
%r52 = call i32 @extractHigh32(i64 %r50)
%r54 = call i64 @mulPos32x32(i32* %r3, i32 %r4, i32 12)
%r55 = trunc i64 %r54 to i32
%r56 = call i32 @extractHigh32(i64 %r54)
%r58 = call i64 @mulPos32x32(i32* %r3, i32 %r4, i32 13)
%r59 = trunc i64 %r58 to i32
%r60 = call i32 @extractHigh32(i64 %r58)
%r62 = call i64 @mulPos32x32(i32* %r3, i32 %r4, i32 14)
%r63 = trunc i64 %r62 to i32
%r64 = call i32 @extractHigh32(i64 %r62)
%r66 = call i64 @mulPos32x32(i32* %r3, i32 %r4, i32 15)
%r67 = trunc i64 %r66 to i32
%r68 = call i32 @extractHigh32(i64 %r66)
%r70 = call i64 @mulPos32x32(i32* %r3, i32 %r4, i32 16)
%r71 = trunc i64 %r70 to i32
%r72 = call i32 @extractHigh32(i64 %r70)
%r73 = zext i32 %r7 to i64
%r74 = zext i32 %r11 to i64
%r75 = shl i64 %r74, 32
%r76 = or i64 %r73, %r75
%r77 = zext i64 %r76 to i96
%r78 = zext i32 %r15 to i96
%r79 = shl i96 %r78, 64
%r80 = or i96 %r77, %r79
%r81 = zext i96 %r80 to i128
%r82 = zext i32 %r19 to i128
%r83 = shl i128 %r82, 96
%r84 = or i128 %r81, %r83
%r85 = zext i128 %r84 to i160
%r86 = zext i32 %r23 to i160
%r87 = shl i160 %r86, 128
%r88 = or i160 %r85, %r87
%r89 = zext i160 %r88 to i192
%r90 = zext i32 %r27 to i192
%r91 = shl i192 %r90, 160
%r92 = or i192 %r89, %r91
%r93 = zext i192 %r92 to i224
%r94 = zext i32 %r31 to i224
%r95 = shl i224 %r94, 192
%r96 = or i224 %r93, %r95
%r97 = zext i224 %r96 to i256
%r98 = zext i32 %r35 to i256
%r99 = shl i256 %r98, 224
%r100 = or i256 %r97, %r99
%r101 = zext i256 %r100 to i288
%r102 = zext i32 %r39 to i288
%r103 = shl i288 %r102, 256
%r104 = or i288 %r101, %r103
%r105 = zext i288 %r104 to i320
%r106 = zext i32 %r43 to i320
%r107 = shl i320 %r106, 288
%r108 = or i320 %r105, %r107
%r109 = zext i320 %r108 to i352
%r110 = zext i32 %r47 to i352
%r111 = shl i352 %r110, 320
%r112 = or i352 %r109, %r111
%r113 = zext i352 %r112 to i384
%r114 = zext i32 %r51 to i384
%r115 = shl i384 %r114, 352
%r116 = or i384 %r113, %r115
%r117 = zext i384 %r116 to i416
%r118 = zext i32 %r55 to i416
%r119 = shl i416 %r118, 384
%r120 = or i416 %r117, %r119
%r121 = zext i416 %r120 to i448
%r122 = zext i32 %r59 to i448
%r123 = shl i448 %r122, 416
%r124 = or i448 %r121, %r123
%r125 = zext i448 %r124 to i480
%r126 = zext i32 %r63 to i480
%r127 = shl i480 %r126, 448
%r128 = or i480 %r125, %r127
%r129 = zext i480 %r128 to i512
%r130 = zext i32 %r67 to i512
%r131 = shl i512 %r130, 480
%r132 = or i512 %r129, %r131
%r133 = zext i512 %r132 to i544
%r134 = zext i32 %r71 to i544
%r135 = shl i544 %r134, 512
%r136 = or i544 %r133, %r135
%r137 = zext i32 %r8 to i64
%r138 = zext i32 %r12 to i64
%r139 = shl i64 %r138, 32
%r140 = or i64 %r137, %r139
%r141 = zext i64 %r140 to i96
%r142 = zext i32 %r16 to i96
%r143 = shl i96 %r142, 64
%r144 = or i96 %r141, %r143
%r145 = zext i96 %r144 to i128
%r146 = zext i32 %r20 to i128
%r147 = shl i128 %r146, 96
%r148 = or i128 %r145, %r147
%r149 = zext i128 %r148 to i160
%r150 = zext i32 %r24 to i160
%r151 = shl i160 %r150, 128
%r152 = or i160 %r149, %r151
%r153 = zext i160 %r152 to i192
%r154 = zext i32 %r28 to i192
%r155 = shl i192 %r154, 160
%r156 = or i192 %r153, %r155
%r157 = zext i192 %r156 to i224
%r158 = zext i32 %r32 to i224
%r159 = shl i224 %r158, 192
%r160 = or i224 %r157, %r159
%r161 = zext i224 %r160 to i256
%r162 = zext i32 %r36 to i256
%r163 = shl i256 %r162, 224
%r164 = or i256 %r161, %r163
%r165 = zext i256 %r164 to i288
%r166 = zext i32 %r40 to i288
%r167 = shl i288 %r166, 256
%r168 = or i288 %r165, %r167
%r169 = zext i288 %r168 to i320
%r170 = zext i32 %r44 to i320
%r171 = shl i320 %r170, 288
%r172 = or i320 %r169, %r171
%r173 = zext i320 %r172 to i352
%r174 = zext i32 %r48 to i352
%r175 = shl i352 %r174, 320
%r176 = or i352 %r173, %r175
%r177 = zext i352 %r176 to i384
%r178 = zext i32 %r52 to i384
%r179 = shl i384 %r178, 352
%r180 = or i384 %r177, %r179
%r181 = zext i384 %r180 to i416
%r182 = zext i32 %r56 to i416
%r183 = shl i416 %r182, 384
%r184 = or i416 %r181, %r183
%r185 = zext i416 %r184 to i448
%r186 = zext i32 %r60 to i448
%r187 = shl i448 %r186, 416
%r188 = or i448 %r185, %r187
%r189 = zext i448 %r188 to i480
%r190 = zext i32 %r64 to i480
%r191 = shl i480 %r190, 448
%r192 = or i480 %r189, %r191
%r193 = zext i480 %r192 to i512
%r194 = zext i32 %r68 to i512
%r195 = shl i512 %r194, 480
%r196 = or i512 %r193, %r195
%r197 = zext i512 %r196 to i544
%r198 = zext i32 %r72 to i544
%r199 = shl i544 %r198, 512
%r200 = or i544 %r197, %r199
%r201 = zext i544 %r136 to i576
%r202 = zext i544 %r200 to i576
%r203 = shl i576 %r202, 32
%r204 = add i576 %r201, %r203
%r206 = bitcast i32* %r2 to i544*
%r207 = load i544, i544* %r206
%r208 = zext i544 %r207 to i576
%r209 = add i576 %r204, %r208
%r210 = trunc i576 %r209 to i544
%r212 = getelementptr i32, i32* %r2, i32 0
%r213 = trunc i544 %r210 to i32
store i32 %r213, i32* %r212
%r214 = lshr i544 %r210, 32
%r216 = getelementptr i32, i32* %r2, i32 1
%r217 = trunc i544 %r214 to i32
store i32 %r217, i32* %r216
%r218 = lshr i544 %r214, 32
%r220 = getelementptr i32, i32* %r2, i32 2
%r221 = trunc i544 %r218 to i32
store i32 %r221, i32* %r220
%r222 = lshr i544 %r218, 32
%r224 = getelementptr i32, i32* %r2, i32 3
%r225 = trunc i544 %r222 to i32
store i32 %r225, i32* %r224
%r226 = lshr i544 %r222, 32
%r228 = getelementptr i32, i32* %r2, i32 4
%r229 = trunc i544 %r226 to i32
store i32 %r229, i32* %r228
%r230 = lshr i544 %r226, 32
%r232 = getelementptr i32, i32* %r2, i32 5
%r233 = trunc i544 %r230 to i32
store i32 %r233, i32* %r232
%r234 = lshr i544 %r230, 32
%r236 = getelementptr i32, i32* %r2, i32 6
%r237 = trunc i544 %r234 to i32
store i32 %r237, i32* %r236
%r238 = lshr i544 %r234, 32
%r240 = getelementptr i32, i32* %r2, i32 7
%r241 = trunc i544 %r238 to i32
store i32 %r241, i32* %r240
%r242 = lshr i544 %r238, 32
%r244 = getelementptr i32, i32* %r2, i32 8
%r245 = trunc i544 %r242 to i32
store i32 %r245, i32* %r244
%r246 = lshr i544 %r242, 32
%r248 = getelementptr i32, i32* %r2, i32 9
%r249 = trunc i544 %r246 to i32
store i32 %r249, i32* %r248
%r250 = lshr i544 %r246, 32
%r252 = getelementptr i32, i32* %r2, i32 10
%r253 = trunc i544 %r250 to i32
store i32 %r253, i32* %r252
%r254 = lshr i544 %r250, 32
%r256 = getelementptr i32, i32* %r2, i32 11
%r257 = trunc i544 %r254 to i32
store i32 %r257, i32* %r256
%r258 = lshr i544 %r254, 32
%r260 = getelementptr i32, i32* %r2, i32 12
%r261 = trunc i544 %r258 to i32
store i32 %r261, i32* %r260
%r262 = lshr i544 %r258, 32
%r264 = getelementptr i32, i32* %r2, i32 13
%r265 = trunc i544 %r262 to i32
store i32 %r265, i32* %r264
%r266 = lshr i544 %r262, 32
%r268 = getelementptr i32, i32* %r2, i32 14
%r269 = trunc i544 %r266 to i32
store i32 %r269, i32* %r268
%r270 = lshr i544 %r266, 32
%r272 = getelementptr i32, i32* %r2, i32 15
%r273 = trunc i544 %r270 to i32
store i32 %r273, i32* %r272
%r274 = lshr i544 %r270, 32
%r276 = getelementptr i32, i32* %r2, i32 16
%r277 = trunc i544 %r274 to i32
store i32 %r277, i32* %r276
%r278 = lshr i576 %r209, 544
%r279 = trunc i576 %r278 to i32
ret i32 %r279
}
define void @mclb_mul17(i32* noalias  %r1, i32* noalias  %r2, i32* noalias  %r3)
{
%r4 = load i32, i32* %r3
%r5 = call i576 @mulUnit_inner544(i32* %r2, i32 %r4)
%r6 = trunc i576 %r5 to i32
store i32 %r6, i32* %r1
%r7 = lshr i576 %r5, 32
%r9 = getelementptr i32, i32* %r3, i32 1
%r10 = load i32, i32* %r9
%r11 = call i576 @mulUnit_inner544(i32* %r2, i32 %r10)
%r12 = add i576 %r7, %r11
%r13 = trunc i576 %r12 to i32
%r15 = getelementptr i32, i32* %r1, i32 1
store i32 %r13, i32* %r15
%r16 = lshr i576 %r12, 32
%r18 = getelementptr i32, i32* %r3, i32 2
%r19 = load i32, i32* %r18
%r20 = call i576 @mulUnit_inner544(i32* %r2, i32 %r19)
%r21 = add i576 %r16, %r20
%r22 = trunc i576 %r21 to i32
%r24 = getelementptr i32, i32* %r1, i32 2
store i32 %r22, i32* %r24
%r25 = lshr i576 %r21, 32
%r27 = getelementptr i32, i32* %r3, i32 3
%r28 = load i32, i32* %r27
%r29 = call i576 @mulUnit_inner544(i32* %r2, i32 %r28)
%r30 = add i576 %r25, %r29
%r31 = trunc i576 %r30 to i32
%r33 = getelementptr i32, i32* %r1, i32 3
store i32 %r31, i32* %r33
%r34 = lshr i576 %r30, 32
%r36 = getelementptr i32, i32* %r3, i32 4
%r37 = load i32, i32* %r36
%r38 = call i576 @mulUnit_inner544(i32* %r2, i32 %r37)
%r39 = add i576 %r34, %r38
%r40 = trunc i576 %r39 to i32
%r42 = getelementptr i32, i32* %r1, i32 4
store i32 %r40, i32* %r42
%r43 = lshr i576 %r39, 32
%r45 = getelementptr i32, i32* %r3, i32 5
%r46 = load i32, i32* %r45
%r47 = call i576 @mulUnit_inner544(i32* %r2, i32 %r46)
%r48 = add i576 %r43, %r47
%r49 = trunc i576 %r48 to i32
%r51 = getelementptr i32, i32* %r1, i32 5
store i32 %r49, i32* %r51
%r52 = lshr i576 %r48, 32
%r54 = getelementptr i32, i32* %r3, i32 6
%r55 = load i32, i32* %r54
%r56 = call i576 @mulUnit_inner544(i32* %r2, i32 %r55)
%r57 = add i576 %r52, %r56
%r58 = trunc i576 %r57 to i32
%r60 = getelementptr i32, i32* %r1, i32 6
store i32 %r58, i32* %r60
%r61 = lshr i576 %r57, 32
%r63 = getelementptr i32, i32* %r3, i32 7
%r64 = load i32, i32* %r63
%r65 = call i576 @mulUnit_inner544(i32* %r2, i32 %r64)
%r66 = add i576 %r61, %r65
%r67 = trunc i576 %r66 to i32
%r69 = getelementptr i32, i32* %r1, i32 7
store i32 %r67, i32* %r69
%r70 = lshr i576 %r66, 32
%r72 = getelementptr i32, i32* %r3, i32 8
%r73 = load i32, i32* %r72
%r74 = call i576 @mulUnit_inner544(i32* %r2, i32 %r73)
%r75 = add i576 %r70, %r74
%r76 = trunc i576 %r75 to i32
%r78 = getelementptr i32, i32* %r1, i32 8
store i32 %r76, i32* %r78
%r79 = lshr i576 %r75, 32
%r81 = getelementptr i32, i32* %r3, i32 9
%r82 = load i32, i32* %r81
%r83 = call i576 @mulUnit_inner544(i32* %r2, i32 %r82)
%r84 = add i576 %r79, %r83
%r85 = trunc i576 %r84 to i32
%r87 = getelementptr i32, i32* %r1, i32 9
store i32 %r85, i32* %r87
%r88 = lshr i576 %r84, 32
%r90 = getelementptr i32, i32* %r3, i32 10
%r91 = load i32, i32* %r90
%r92 = call i576 @mulUnit_inner544(i32* %r2, i32 %r91)
%r93 = add i576 %r88, %r92
%r94 = trunc i576 %r93 to i32
%r96 = getelementptr i32, i32* %r1, i32 10
store i32 %r94, i32* %r96
%r97 = lshr i576 %r93, 32
%r99 = getelementptr i32, i32* %r3, i32 11
%r100 = load i32, i32* %r99
%r101 = call i576 @mulUnit_inner544(i32* %r2, i32 %r100)
%r102 = add i576 %r97, %r101
%r103 = trunc i576 %r102 to i32
%r105 = getelementptr i32, i32* %r1, i32 11
store i32 %r103, i32* %r105
%r106 = lshr i576 %r102, 32
%r108 = getelementptr i32, i32* %r3, i32 12
%r109 = load i32, i32* %r108
%r110 = call i576 @mulUnit_inner544(i32* %r2, i32 %r109)
%r111 = add i576 %r106, %r110
%r112 = trunc i576 %r111 to i32
%r114 = getelementptr i32, i32* %r1, i32 12
store i32 %r112, i32* %r114
%r115 = lshr i576 %r111, 32
%r117 = getelementptr i32, i32* %r3, i32 13
%r118 = load i32, i32* %r117
%r119 = call i576 @mulUnit_inner544(i32* %r2, i32 %r118)
%r120 = add i576 %r115, %r119
%r121 = trunc i576 %r120 to i32
%r123 = getelementptr i32, i32* %r1, i32 13
store i32 %r121, i32* %r123
%r124 = lshr i576 %r120, 32
%r126 = getelementptr i32, i32* %r3, i32 14
%r127 = load i32, i32* %r126
%r128 = call i576 @mulUnit_inner544(i32* %r2, i32 %r127)
%r129 = add i576 %r124, %r128
%r130 = trunc i576 %r129 to i32
%r132 = getelementptr i32, i32* %r1, i32 14
store i32 %r130, i32* %r132
%r133 = lshr i576 %r129, 32
%r135 = getelementptr i32, i32* %r3, i32 15
%r136 = load i32, i32* %r135
%r137 = call i576 @mulUnit_inner544(i32* %r2, i32 %r136)
%r138 = add i576 %r133, %r137
%r139 = trunc i576 %r138 to i32
%r141 = getelementptr i32, i32* %r1, i32 15
store i32 %r139, i32* %r141
%r142 = lshr i576 %r138, 32
%r144 = getelementptr i32, i32* %r3, i32 16
%r145 = load i32, i32* %r144
%r146 = call i576 @mulUnit_inner544(i32* %r2, i32 %r145)
%r147 = add i576 %r142, %r146
%r149 = getelementptr i32, i32* %r1, i32 16
%r151 = getelementptr i32, i32* %r149, i32 0
%r152 = trunc i576 %r147 to i32
store i32 %r152, i32* %r151
%r153 = lshr i576 %r147, 32
%r155 = getelementptr i32, i32* %r149, i32 1
%r156 = trunc i576 %r153 to i32
store i32 %r156, i32* %r155
%r157 = lshr i576 %r153, 32
%r159 = getelementptr i32, i32* %r149, i32 2
%r160 = trunc i576 %r157 to i32
store i32 %r160, i32* %r159
%r161 = lshr i576 %r157, 32
%r163 = getelementptr i32, i32* %r149, i32 3
%r164 = trunc i576 %r161 to i32
store i32 %r164, i32* %r163
%r165 = lshr i576 %r161, 32
%r167 = getelementptr i32, i32* %r149, i32 4
%r168 = trunc i576 %r165 to i32
store i32 %r168, i32* %r167
%r169 = lshr i576 %r165, 32
%r171 = getelementptr i32, i32* %r149, i32 5
%r172 = trunc i576 %r169 to i32
store i32 %r172, i32* %r171
%r173 = lshr i576 %r169, 32
%r175 = getelementptr i32, i32* %r149, i32 6
%r176 = trunc i576 %r173 to i32
store i32 %r176, i32* %r175
%r177 = lshr i576 %r173, 32
%r179 = getelementptr i32, i32* %r149, i32 7
%r180 = trunc i576 %r177 to i32
store i32 %r180, i32* %r179
%r181 = lshr i576 %r177, 32
%r183 = getelementptr i32, i32* %r149, i32 8
%r184 = trunc i576 %r181 to i32
store i32 %r184, i32* %r183
%r185 = lshr i576 %r181, 32
%r187 = getelementptr i32, i32* %r149, i32 9
%r188 = trunc i576 %r185 to i32
store i32 %r188, i32* %r187
%r189 = lshr i576 %r185, 32
%r191 = getelementptr i32, i32* %r149, i32 10
%r192 = trunc i576 %r189 to i32
store i32 %r192, i32* %r191
%r193 = lshr i576 %r189, 32
%r195 = getelementptr i32, i32* %r149, i32 11
%r196 = trunc i576 %r193 to i32
store i32 %r196, i32* %r195
%r197 = lshr i576 %r193, 32
%r199 = getelementptr i32, i32* %r149, i32 12
%r200 = trunc i576 %r197 to i32
store i32 %r200, i32* %r199
%r201 = lshr i576 %r197, 32
%r203 = getelementptr i32, i32* %r149, i32 13
%r204 = trunc i576 %r201 to i32
store i32 %r204, i32* %r203
%r205 = lshr i576 %r201, 32
%r207 = getelementptr i32, i32* %r149, i32 14
%r208 = trunc i576 %r205 to i32
store i32 %r208, i32* %r207
%r209 = lshr i576 %r205, 32
%r211 = getelementptr i32, i32* %r149, i32 15
%r212 = trunc i576 %r209 to i32
store i32 %r212, i32* %r211
%r213 = lshr i576 %r209, 32
%r215 = getelementptr i32, i32* %r149, i32 16
%r216 = trunc i576 %r213 to i32
store i32 %r216, i32* %r215
%r217 = lshr i576 %r213, 32
%r219 = getelementptr i32, i32* %r149, i32 17
%r220 = trunc i576 %r217 to i32
store i32 %r220, i32* %r219
ret void
}
define void @mclb_sqr17(i32* noalias  %r1, i32* noalias  %r2)
{
%r3 = load i32, i32* %r2
%r4 = call i64 @mul32x32L(i32 %r3, i32 %r3)
%r5 = trunc i64 %r4 to i32
store i32 %r5, i32* %r1
%r6 = lshr i64 %r4, 32
%r8 = getelementptr i32, i32* %r2, i32 16
%r9 = load i32, i32* %r8
%r10 = call i64 @mul32x32L(i32 %r3, i32 %r9)
%r11 = load i32, i32* %r2
%r13 = getelementptr i32, i32* %r2, i32 15
%r14 = load i32, i32* %r13
%r15 = call i64 @mul32x32L(i32 %r11, i32 %r14)
%r17 = getelementptr i32, i32* %r2, i32 1
%r18 = load i32, i32* %r17
%r20 = getelementptr i32, i32* %r2, i32 16
%r21 = load i32, i32* %r20
%r22 = call i64 @mul32x32L(i32 %r18, i32 %r21)
%r23 = zext i64 %r15 to i128
%r24 = zext i64 %r22 to i128
%r25 = shl i128 %r24, 64
%r26 = or i128 %r23, %r25
%r27 = zext i64 %r10 to i128
%r28 = shl i128 %r27, 32
%r29 = add i128 %r28, %r26
%r30 = load i32, i32* %r2
%r32 = getelementptr i32, i32* %r2, i32 14
%r33 = load i32, i32* %r32
%r34 = call i64 @mul32x32L(i32 %r30, i32 %r33)
%r36 = getelementptr i32, i32* %r2, i32 1
%r37 = load i32, i32* %r36
%r39 = getelementptr i32, i32* %r2, i32 15
%r40 = load i32, i32* %r39
%r41 = call i64 @mul32x32L(i32 %r37, i32 %r40)
%r42 = zext i64 %r34 to i128
%r43 = zext i64 %r41 to i128
%r44 = shl i128 %r43, 64
%r45 = or i128 %r42, %r44
%r47 = getelementptr i32, i32* %r2, i32 2
%r48 = load i32, i32* %r47
%r50 = getelementptr i32, i32* %r2, i32 16
%r51 = load i32, i32* %r50
%r52 = call i64 @mul32x32L(i32 %r48, i32 %r51)
%r53 = zext i128 %r45 to i192
%r54 = zext i64 %r52 to i192
%r55 = shl i192 %r54, 128
%r56 = or i192 %r53, %r55
%r57 = zext i128 %r29 to i192
%r58 = shl i192 %r57, 32
%r59 = add i192 %r58, %r56
%r60 = load i32, i32* %r2
%r62 = getelementptr i32, i32* %r2, i32 13
%r63 = load i32, i32* %r62
%r64 = call i64 @mul32x32L(i32 %r60, i32 %r63)
%r66 = getelementptr i32, i32* %r2, i32 1
%r67 = load i32, i32* %r66
%r69 = getelementptr i32, i32* %r2, i32 14
%r70 = load i32, i32* %r69
%r71 = call i64 @mul32x32L(i32 %r67, i32 %r70)
%r72 = zext i64 %r64 to i128
%r73 = zext i64 %r71 to i128
%r74 = shl i128 %r73, 64
%r75 = or i128 %r72, %r74
%r77 = getelementptr i32, i32* %r2, i32 2
%r78 = load i32, i32* %r77
%r80 = getelementptr i32, i32* %r2, i32 15
%r81 = load i32, i32* %r80
%r82 = call i64 @mul32x32L(i32 %r78, i32 %r81)
%r83 = zext i128 %r75 to i192
%r84 = zext i64 %r82 to i192
%r85 = shl i192 %r84, 128
%r86 = or i192 %r83, %r85
%r88 = getelementptr i32, i32* %r2, i32 3
%r89 = load i32, i32* %r88
%r91 = getelementptr i32, i32* %r2, i32 16
%r92 = load i32, i32* %r91
%r93 = call i64 @mul32x32L(i32 %r89, i32 %r92)
%r94 = zext i192 %r86 to i256
%r95 = zext i64 %r93 to i256
%r96 = shl i256 %r95, 192
%r97 = or i256 %r94, %r96
%r98 = zext i192 %r59 to i256
%r99 = shl i256 %r98, 32
%r100 = add i256 %r99, %r97
%r101 = load i32, i32* %r2
%r103 = getelementptr i32, i32* %r2, i32 12
%r104 = load i32, i32* %r103
%r105 = call i64 @mul32x32L(i32 %r101, i32 %r104)
%r107 = getelementptr i32, i32* %r2, i32 1
%r108 = load i32, i32* %r107
%r110 = getelementptr i32, i32* %r2, i32 13
%r111 = load i32, i32* %r110
%r112 = call i64 @mul32x32L(i32 %r108, i32 %r111)
%r113 = zext i64 %r105 to i128
%r114 = zext i64 %r112 to i128
%r115 = shl i128 %r114, 64
%r116 = or i128 %r113, %r115
%r118 = getelementptr i32, i32* %r2, i32 2
%r119 = load i32, i32* %r118
%r121 = getelementptr i32, i32* %r2, i32 14
%r122 = load i32, i32* %r121
%r123 = call i64 @mul32x32L(i32 %r119, i32 %r122)
%r124 = zext i128 %r116 to i192
%r125 = zext i64 %r123 to i192
%r126 = shl i192 %r125, 128
%r127 = or i192 %r124, %r126
%r129 = getelementptr i32, i32* %r2, i32 3
%r130 = load i32, i32* %r129
%r132 = getelementptr i32, i32* %r2, i32 15
%r133 = load i32, i32* %r132
%r134 = call i64 @mul32x32L(i32 %r130, i32 %r133)
%r135 = zext i192 %r127 to i256
%r136 = zext i64 %r134 to i256
%r137 = shl i256 %r136, 192
%r138 = or i256 %r135, %r137
%r140 = getelementptr i32, i32* %r2, i32 4
%r141 = load i32, i32* %r140
%r143 = getelementptr i32, i32* %r2, i32 16
%r144 = load i32, i32* %r143
%r145 = call i64 @mul32x32L(i32 %r141, i32 %r144)
%r146 = zext i256 %r138 to i320
%r147 = zext i64 %r145 to i320
%r148 = shl i320 %r147, 256
%r149 = or i320 %r146, %r148
%r150 = zext i256 %r100 to i320
%r151 = shl i320 %r150, 32
%r152 = add i320 %r151, %r149
%r153 = load i32, i32* %r2
%r155 = getelementptr i32, i32* %r2, i32 11
%r156 = load i32, i32* %r155
%r157 = call i64 @mul32x32L(i32 %r153, i32 %r156)
%r159 = getelementptr i32, i32* %r2, i32 1
%r160 = load i32, i32* %r159
%r162 = getelementptr i32, i32* %r2, i32 12
%r163 = load i32, i32* %r162
%r164 = call i64 @mul32x32L(i32 %r160, i32 %r163)
%r165 = zext i64 %r157 to i128
%r166 = zext i64 %r164 to i128
%r167 = shl i128 %r166, 64
%r168 = or i128 %r165, %r167
%r170 = getelementptr i32, i32* %r2, i32 2
%r171 = load i32, i32* %r170
%r173 = getelementptr i32, i32* %r2, i32 13
%r174 = load i32, i32* %r173
%r175 = call i64 @mul32x32L(i32 %r171, i32 %r174)
%r176 = zext i128 %r168 to i192
%r177 = zext i64 %r175 to i192
%r178 = shl i192 %r177, 128
%r179 = or i192 %r176, %r178
%r181 = getelementptr i32, i32* %r2, i32 3
%r182 = load i32, i32* %r181
%r184 = getelementptr i32, i32* %r2, i32 14
%r185 = load i32, i32* %r184
%r186 = call i64 @mul32x32L(i32 %r182, i32 %r185)
%r187 = zext i192 %r179 to i256
%r188 = zext i64 %r186 to i256
%r189 = shl i256 %r188, 192
%r190 = or i256 %r187, %r189
%r192 = getelementptr i32, i32* %r2, i32 4
%r193 = load i32, i32* %r192
%r195 = getelementptr i32, i32* %r2, i32 15
%r196 = load i32, i32* %r195
%r197 = call i64 @mul32x32L(i32 %r193, i32 %r196)
%r198 = zext i256 %r190 to i320
%r199 = zext i64 %r197 to i320
%r200 = shl i320 %r199, 256
%r201 = or i320 %r198, %r200
%r203 = getelementptr i32, i32* %r2, i32 5
%r204 = load i32, i32* %r203
%r206 = getelementptr i32, i32* %r2, i32 16
%r207 = load i32, i32* %r206
%r208 = call i64 @mul32x32L(i32 %r204, i32 %r207)
%r209 = zext i320 %r201 to i384
%r210 = zext i64 %r208 to i384
%r211 = shl i384 %r210, 320
%r212 = or i384 %r209, %r211
%r213 = zext i320 %r152 to i384
%r214 = shl i384 %r213, 32
%r215 = add i384 %r214, %r212
%r216 = load i32, i32* %r2
%r218 = getelementptr i32, i32* %r2, i32 10
%r219 = load i32, i32* %r218
%r220 = call i64 @mul32x32L(i32 %r216, i32 %r219)
%r222 = getelementptr i32, i32* %r2, i32 1
%r223 = load i32, i32* %r222
%r225 = getelementptr i32, i32* %r2, i32 11
%r226 = load i32, i32* %r225
%r227 = call i64 @mul32x32L(i32 %r223, i32 %r226)
%r228 = zext i64 %r220 to i128
%r229 = zext i64 %r227 to i128
%r230 = shl i128 %r229, 64
%r231 = or i128 %r228, %r230
%r233 = getelementptr i32, i32* %r2, i32 2
%r234 = load i32, i32* %r233
%r236 = getelementptr i32, i32* %r2, i32 12
%r237 = load i32, i32* %r236
%r238 = call i64 @mul32x32L(i32 %r234, i32 %r237)
%r239 = zext i128 %r231 to i192
%r240 = zext i64 %r238 to i192
%r241 = shl i192 %r240, 128
%r242 = or i192 %r239, %r241
%r244 = getelementptr i32, i32* %r2, i32 3
%r245 = load i32, i32* %r244
%r247 = getelementptr i32, i32* %r2, i32 13
%r248 = load i32, i32* %r247
%r249 = call i64 @mul32x32L(i32 %r245, i32 %r248)
%r250 = zext i192 %r242 to i256
%r251 = zext i64 %r249 to i256
%r252 = shl i256 %r251, 192
%r253 = or i256 %r250, %r252
%r255 = getelementptr i32, i32* %r2, i32 4
%r256 = load i32, i32* %r255
%r258 = getelementptr i32, i32* %r2, i32 14
%r259 = load i32, i32* %r258
%r260 = call i64 @mul32x32L(i32 %r256, i32 %r259)
%r261 = zext i256 %r253 to i320
%r262 = zext i64 %r260 to i320
%r263 = shl i320 %r262, 256
%r264 = or i320 %r261, %r263
%r266 = getelementptr i32, i32* %r2, i32 5
%r267 = load i32, i32* %r266
%r269 = getelementptr i32, i32* %r2, i32 15
%r270 = load i32, i32* %r269
%r271 = call i64 @mul32x32L(i32 %r267, i32 %r270)
%r272 = zext i320 %r264 to i384
%r273 = zext i64 %r271 to i384
%r274 = shl i384 %r273, 320
%r275 = or i384 %r272, %r274
%r277 = getelementptr i32, i32* %r2, i32 6
%r278 = load i32, i32* %r277
%r280 = getelementptr i32, i32* %r2, i32 16
%r281 = load i32, i32* %r280
%r282 = call i64 @mul32x32L(i32 %r278, i32 %r281)
%r283 = zext i384 %r275 to i448
%r284 = zext i64 %r282 to i448
%r285 = shl i448 %r284, 384
%r286 = or i448 %r283, %r285
%r287 = zext i384 %r215 to i448
%r288 = shl i448 %r287, 32
%r289 = add i448 %r288, %r286
%r290 = load i32, i32* %r2
%r292 = getelementptr i32, i32* %r2, i32 9
%r293 = load i32, i32* %r292
%r294 = call i64 @mul32x32L(i32 %r290, i32 %r293)
%r296 = getelementptr i32, i32* %r2, i32 1
%r297 = load i32, i32* %r296
%r299 = getelementptr i32, i32* %r2, i32 10
%r300 = load i32, i32* %r299
%r301 = call i64 @mul32x32L(i32 %r297, i32 %r300)
%r302 = zext i64 %r294 to i128
%r303 = zext i64 %r301 to i128
%r304 = shl i128 %r303, 64
%r305 = or i128 %r302, %r304
%r307 = getelementptr i32, i32* %r2, i32 2
%r308 = load i32, i32* %r307
%r310 = getelementptr i32, i32* %r2, i32 11
%r311 = load i32, i32* %r310
%r312 = call i64 @mul32x32L(i32 %r308, i32 %r311)
%r313 = zext i128 %r305 to i192
%r314 = zext i64 %r312 to i192
%r315 = shl i192 %r314, 128
%r316 = or i192 %r313, %r315
%r318 = getelementptr i32, i32* %r2, i32 3
%r319 = load i32, i32* %r318
%r321 = getelementptr i32, i32* %r2, i32 12
%r322 = load i32, i32* %r321
%r323 = call i64 @mul32x32L(i32 %r319, i32 %r322)
%r324 = zext i192 %r316 to i256
%r325 = zext i64 %r323 to i256
%r326 = shl i256 %r325, 192
%r327 = or i256 %r324, %r326
%r329 = getelementptr i32, i32* %r2, i32 4
%r330 = load i32, i32* %r329
%r332 = getelementptr i32, i32* %r2, i32 13
%r333 = load i32, i32* %r332
%r334 = call i64 @mul32x32L(i32 %r330, i32 %r333)
%r335 = zext i256 %r327 to i320
%r336 = zext i64 %r334 to i320
%r337 = shl i320 %r336, 256
%r338 = or i320 %r335, %r337
%r340 = getelementptr i32, i32* %r2, i32 5
%r341 = load i32, i32* %r340
%r343 = getelementptr i32, i32* %r2, i32 14
%r344 = load i32, i32* %r343
%r345 = call i64 @mul32x32L(i32 %r341, i32 %r344)
%r346 = zext i320 %r338 to i384
%r347 = zext i64 %r345 to i384
%r348 = shl i384 %r347, 320
%r349 = or i384 %r346, %r348
%r351 = getelementptr i32, i32* %r2, i32 6
%r352 = load i32, i32* %r351
%r354 = getelementptr i32, i32* %r2, i32 15
%r355 = load i32, i32* %r354
%r356 = call i64 @mul32x32L(i32 %r352, i32 %r355)
%r357 = zext i384 %r349 to i448
%r358 = zext i64 %r356 to i448
%r359 = shl i448 %r358, 384
%r360 = or i448 %r357, %r359
%r362 = getelementptr i32, i32* %r2, i32 7
%r363 = load i32, i32* %r362
%r365 = getelementptr i32, i32* %r2, i32 16
%r366 = load i32, i32* %r365
%r367 = call i64 @mul32x32L(i32 %r363, i32 %r366)
%r368 = zext i448 %r360 to i512
%r369 = zext i64 %r367 to i512
%r370 = shl i512 %r369, 448
%r371 = or i512 %r368, %r370
%r372 = zext i448 %r289 to i512
%r373 = shl i512 %r372, 32
%r374 = add i512 %r373, %r371
%r375 = load i32, i32* %r2
%r377 = getelementptr i32, i32* %r2, i32 8
%r378 = load i32, i32* %r377
%r379 = call i64 @mul32x32L(i32 %r375, i32 %r378)
%r381 = getelementptr i32, i32* %r2, i32 1
%r382 = load i32, i32* %r381
%r384 = getelementptr i32, i32* %r2, i32 9
%r385 = load i32, i32* %r384
%r386 = call i64 @mul32x32L(i32 %r382, i32 %r385)
%r387 = zext i64 %r379 to i128
%r388 = zext i64 %r386 to i128
%r389 = shl i128 %r388, 64
%r390 = or i128 %r387, %r389
%r392 = getelementptr i32, i32* %r2, i32 2
%r393 = load i32, i32* %r392
%r395 = getelementptr i32, i32* %r2, i32 10
%r396 = load i32, i32* %r395
%r397 = call i64 @mul32x32L(i32 %r393, i32 %r396)
%r398 = zext i128 %r390 to i192
%r399 = zext i64 %r397 to i192
%r400 = shl i192 %r399, 128
%r401 = or i192 %r398, %r400
%r403 = getelementptr i32, i32* %r2, i32 3
%r404 = load i32, i32* %r403
%r406 = getelementptr i32, i32* %r2, i32 11
%r407 = load i32, i32* %r406
%r408 = call i64 @mul32x32L(i32 %r404, i32 %r407)
%r409 = zext i192 %r401 to i256
%r410 = zext i64 %r408 to i256
%r411 = shl i256 %r410, 192
%r412 = or i256 %r409, %r411
%r414 = getelementptr i32, i32* %r2, i32 4
%r415 = load i32, i32* %r414
%r417 = getelementptr i32, i32* %r2, i32 12
%r418 = load i32, i32* %r417
%r419 = call i64 @mul32x32L(i32 %r415, i32 %r418)
%r420 = zext i256 %r412 to i320
%r421 = zext i64 %r419 to i320
%r422 = shl i320 %r421, 256
%r423 = or i320 %r420, %r422
%r425 = getelementptr i32, i32* %r2, i32 5
%r426 = load i32, i32* %r425
%r428 = getelementptr i32, i32* %r2, i32 13
%r429 = load i32, i32* %r428
%r430 = call i64 @mul32x32L(i32 %r426, i32 %r429)
%r431 = zext i320 %r423 to i384
%r432 = zext i64 %r430 to i384
%r433 = shl i384 %r432, 320
%r434 = or i384 %r431, %r433
%r436 = getelementptr i32, i32* %r2, i32 6
%r437 = load i32, i32* %r436
%r439 = getelementptr i32, i32* %r2, i32 14
%r440 = load i32, i32* %r439
%r441 = call i64 @mul32x32L(i32 %r437, i32 %r440)
%r442 = zext i384 %r434 to i448
%r443 = zext i64 %r441 to i448
%r444 = shl i448 %r443, 384
%r445 = or i448 %r442, %r444
%r447 = getelementptr i32, i32* %r2, i32 7
%r448 = load i32, i32* %r447
%r450 = getelementptr i32, i32* %r2, i32 15
%r451 = load i32, i32* %r450
%r452 = call i64 @mul32x32L(i32 %r448, i32 %r451)
%r453 = zext i448 %r445 to i512
%r454 = zext i64 %r452 to i512
%r455 = shl i512 %r454, 448
%r456 = or i512 %r453, %r455
%r458 = getelementptr i32, i32* %r2, i32 8
%r459 = load i32, i32* %r458
%r461 = getelementptr i32, i32* %r2, i32 16
%r462 = load i32, i32* %r461
%r463 = call i64 @mul32x32L(i32 %r459, i32 %r462)
%r464 = zext i512 %r456 to i576
%r465 = zext i64 %r463 to i576
%r466 = shl i576 %r465, 512
%r467 = or i576 %r464, %r466
%r468 = zext i512 %r374 to i576
%r469 = shl i576 %r468, 32
%r470 = add i576 %r469, %r467
%r471 = load i32, i32* %r2
%r473 = getelementptr i32, i32* %r2, i32 7
%r474 = load i32, i32* %r473
%r475 = call i64 @mul32x32L(i32 %r471, i32 %r474)
%r477 = getelementptr i32, i32* %r2, i32 1
%r478 = load i32, i32* %r477
%r480 = getelementptr i32, i32* %r2, i32 8
%r481 = load i32, i32* %r480
%r482 = call i64 @mul32x32L(i32 %r478, i32 %r481)
%r483 = zext i64 %r475 to i128
%r484 = zext i64 %r482 to i128
%r485 = shl i128 %r484, 64
%r486 = or i128 %r483, %r485
%r488 = getelementptr i32, i32* %r2, i32 2
%r489 = load i32, i32* %r488
%r491 = getelementptr i32, i32* %r2, i32 9
%r492 = load i32, i32* %r491
%r493 = call i64 @mul32x32L(i32 %r489, i32 %r492)
%r494 = zext i128 %r486 to i192
%r495 = zext i64 %r493 to i192
%r496 = shl i192 %r495, 128
%r497 = or i192 %r494, %r496
%r499 = getelementptr i32, i32* %r2, i32 3
%r500 = load i32, i32* %r499
%r502 = getelementptr i32, i32* %r2, i32 10
%r503 = load i32, i32* %r502
%r504 = call i64 @mul32x32L(i32 %r500, i32 %r503)
%r505 = zext i192 %r497 to i256
%r506 = zext i64 %r504 to i256
%r507 = shl i256 %r506, 192
%r508 = or i256 %r505, %r507
%r510 = getelementptr i32, i32* %r2, i32 4
%r511 = load i32, i32* %r510
%r513 = getelementptr i32, i32* %r2, i32 11
%r514 = load i32, i32* %r513
%r515 = call i64 @mul32x32L(i32 %r511, i32 %r514)
%r516 = zext i256 %r508 to i320
%r517 = zext i64 %r515 to i320
%r518 = shl i320 %r517, 256
%r519 = or i320 %r516, %r518
%r521 = getelementptr i32, i32* %r2, i32 5
%r522 = load i32, i32* %r521
%r524 = getelementptr i32, i32* %r2, i32 12
%r525 = load i32, i32* %r524
%r526 = call i64 @mul32x32L(i32 %r522, i32 %r525)
%r527 = zext i320 %r519 to i384
%r528 = zext i64 %r526 to i384
%r529 = shl i384 %r528, 320
%r530 = or i384 %r527, %r529
%r532 = getelementptr i32, i32* %r2, i32 6
%r533 = load i32, i32* %r532
%r535 = getelementptr i32, i32* %r2, i32 13
%r536 = load i32, i32* %r535
%r537 = call i64 @mul32x32L(i32 %r533, i32 %r536)
%r538 = zext i384 %r530 to i448
%r539 = zext i64 %r537 to i448
%r540 = shl i448 %r539, 384
%r541 = or i448 %r538, %r540
%r543 = getelementptr i32, i32* %r2, i32 7
%r544 = load i32, i32* %r543
%r546 = getelementptr i32, i32* %r2, i32 14
%r547 = load i32, i32* %r546
%r548 = call i64 @mul32x32L(i32 %r544, i32 %r547)
%r549 = zext i448 %r541 to i512
%r550 = zext i64 %r548 to i512
%r551 = shl i512 %r550, 448
%r552 = or i512 %r549, %r551
%r554 = getelementptr i32, i32* %r2, i32 8
%r555 = load i32, i32* %r554
%r557 = getelementptr i32, i32* %r2, i32 15
%r558 = load i32, i32* %r557
%r559 = call i64 @mul32x32L(i32 %r555, i32 %r558)
%r560 = zext i512 %r552 to i576
%r561 = zext i64 %r559 to i576
%r562 = shl i576 %r561, 512
%r563 = or i576 %r560, %r562
%r565 = getelementptr i32, i32* %r2, i32 9
%r566 = load i32, i32* %r565
%r568 = getelementptr i32, i32* %r2, i32 16
%r569 = load i32, i32* %r568
%r570 = call i64 @mul32x32L(i32 %r566, i32 %r569)
%r571 = zext i576 %r563 to i640
%r572 = zext i64 %r570 to i640
%r573 = shl i640 %r572, 576
%r574 = or i640 %r571, %r573
%r575 = zext i576 %r470 to i640
%r576 = shl i640 %r575, 32
%r577 = add i640 %r576, %r574
%r578 = load i32, i32* %r2
%r580 = getelementptr i32, i32* %r2, i32 6
%r581 = load i32, i32* %r580
%r582 = call i64 @mul32x32L(i32 %r578, i32 %r581)
%r584 = getelementptr i32, i32* %r2, i32 1
%r585 = load i32, i32* %r584
%r587 = getelementptr i32, i32* %r2, i32 7
%r588 = load i32, i32* %r587
%r589 = call i64 @mul32x32L(i32 %r585, i32 %r588)
%r590 = zext i64 %r582 to i128
%r591 = zext i64 %r589 to i128
%r592 = shl i128 %r591, 64
%r593 = or i128 %r590, %r592
%r595 = getelementptr i32, i32* %r2, i32 2
%r596 = load i32, i32* %r595
%r598 = getelementptr i32, i32* %r2, i32 8
%r599 = load i32, i32* %r598
%r600 = call i64 @mul32x32L(i32 %r596, i32 %r599)
%r601 = zext i128 %r593 to i192
%r602 = zext i64 %r600 to i192
%r603 = shl i192 %r602, 128
%r604 = or i192 %r601, %r603
%r606 = getelementptr i32, i32* %r2, i32 3
%r607 = load i32, i32* %r606
%r609 = getelementptr i32, i32* %r2, i32 9
%r610 = load i32, i32* %r609
%r611 = call i64 @mul32x32L(i32 %r607, i32 %r610)
%r612 = zext i192 %r604 to i256
%r613 = zext i64 %r611 to i256
%r614 = shl i256 %r613, 192
%r615 = or i256 %r612, %r614
%r617 = getelementptr i32, i32* %r2, i32 4
%r618 = load i32, i32* %r617
%r620 = getelementptr i32, i32* %r2, i32 10
%r621 = load i32, i32* %r620
%r622 = call i64 @mul32x32L(i32 %r618, i32 %r621)
%r623 = zext i256 %r615 to i320
%r624 = zext i64 %r622 to i320
%r625 = shl i320 %r624, 256
%r626 = or i320 %r623, %r625
%r628 = getelementptr i32, i32* %r2, i32 5
%r629 = load i32, i32* %r628
%r631 = getelementptr i32, i32* %r2, i32 11
%r632 = load i32, i32* %r631
%r633 = call i64 @mul32x32L(i32 %r629, i32 %r632)
%r634 = zext i320 %r626 to i384
%r635 = zext i64 %r633 to i384
%r636 = shl i384 %r635, 320
%r637 = or i384 %r634, %r636
%r639 = getelementptr i32, i32* %r2, i32 6
%r640 = load i32, i32* %r639
%r642 = getelementptr i32, i32* %r2, i32 12
%r643 = load i32, i32* %r642
%r644 = call i64 @mul32x32L(i32 %r640, i32 %r643)
%r645 = zext i384 %r637 to i448
%r646 = zext i64 %r644 to i448
%r647 = shl i448 %r646, 384
%r648 = or i448 %r645, %r647
%r650 = getelementptr i32, i32* %r2, i32 7
%r651 = load i32, i32* %r650
%r653 = getelementptr i32, i32* %r2, i32 13
%r654 = load i32, i32* %r653
%r655 = call i64 @mul32x32L(i32 %r651, i32 %r654)
%r656 = zext i448 %r648 to i512
%r657 = zext i64 %r655 to i512
%r658 = shl i512 %r657, 448
%r659 = or i512 %r656, %r658
%r661 = getelementptr i32, i32* %r2, i32 8
%r662 = load i32, i32* %r661
%r664 = getelementptr i32, i32* %r2, i32 14
%r665 = load i32, i32* %r664
%r666 = call i64 @mul32x32L(i32 %r662, i32 %r665)
%r667 = zext i512 %r659 to i576
%r668 = zext i64 %r666 to i576
%r669 = shl i576 %r668, 512
%r670 = or i576 %r667, %r669
%r672 = getelementptr i32, i32* %r2, i32 9
%r673 = load i32, i32* %r672
%r675 = getelementptr i32, i32* %r2, i32 15
%r676 = load i32, i32* %r675
%r677 = call i64 @mul32x32L(i32 %r673, i32 %r676)
%r678 = zext i576 %r670 to i640
%r679 = zext i64 %r677 to i640
%r680 = shl i640 %r679, 576
%r681 = or i640 %r678, %r680
%r683 = getelementptr i32, i32* %r2, i32 10
%r684 = load i32, i32* %r683
%r686 = getelementptr i32, i32* %r2, i32 16
%r687 = load i32, i32* %r686
%r688 = call i64 @mul32x32L(i32 %r684, i32 %r687)
%r689 = zext i640 %r681 to i704
%r690 = zext i64 %r688 to i704
%r691 = shl i704 %r690, 640
%r692 = or i704 %r689, %r691
%r693 = zext i640 %r577 to i704
%r694 = shl i704 %r693, 32
%r695 = add i704 %r694, %r692
%r696 = load i32, i32* %r2
%r698 = getelementptr i32, i32* %r2, i32 5
%r699 = load i32, i32* %r698
%r700 = call i64 @mul32x32L(i32 %r696, i32 %r699)
%r702 = getelementptr i32, i32* %r2, i32 1
%r703 = load i32, i32* %r702
%r705 = getelementptr i32, i32* %r2, i32 6
%r706 = load i32, i32* %r705
%r707 = call i64 @mul32x32L(i32 %r703, i32 %r706)
%r708 = zext i64 %r700 to i128
%r709 = zext i64 %r707 to i128
%r710 = shl i128 %r709, 64
%r711 = or i128 %r708, %r710
%r713 = getelementptr i32, i32* %r2, i32 2
%r714 = load i32, i32* %r713
%r716 = getelementptr i32, i32* %r2, i32 7
%r717 = load i32, i32* %r716
%r718 = call i64 @mul32x32L(i32 %r714, i32 %r717)
%r719 = zext i128 %r711 to i192
%r720 = zext i64 %r718 to i192
%r721 = shl i192 %r720, 128
%r722 = or i192 %r719, %r721
%r724 = getelementptr i32, i32* %r2, i32 3
%r725 = load i32, i32* %r724
%r727 = getelementptr i32, i32* %r2, i32 8
%r728 = load i32, i32* %r727
%r729 = call i64 @mul32x32L(i32 %r725, i32 %r728)
%r730 = zext i192 %r722 to i256
%r731 = zext i64 %r729 to i256
%r732 = shl i256 %r731, 192
%r733 = or i256 %r730, %r732
%r735 = getelementptr i32, i32* %r2, i32 4
%r736 = load i32, i32* %r735
%r738 = getelementptr i32, i32* %r2, i32 9
%r739 = load i32, i32* %r738
%r740 = call i64 @mul32x32L(i32 %r736, i32 %r739)
%r741 = zext i256 %r733 to i320
%r742 = zext i64 %r740 to i320
%r743 = shl i320 %r742, 256
%r744 = or i320 %r741, %r743
%r746 = getelementptr i32, i32* %r2, i32 5
%r747 = load i32, i32* %r746
%r749 = getelementptr i32, i32* %r2, i32 10
%r750 = load i32, i32* %r749
%r751 = call i64 @mul32x32L(i32 %r747, i32 %r750)
%r752 = zext i320 %r744 to i384
%r753 = zext i64 %r751 to i384
%r754 = shl i384 %r753, 320
%r755 = or i384 %r752, %r754
%r757 = getelementptr i32, i32* %r2, i32 6
%r758 = load i32, i32* %r757
%r760 = getelementptr i32, i32* %r2, i32 11
%r761 = load i32, i32* %r760
%r762 = call i64 @mul32x32L(i32 %r758, i32 %r761)
%r763 = zext i384 %r755 to i448
%r764 = zext i64 %r762 to i448
%r765 = shl i448 %r764, 384
%r766 = or i448 %r763, %r765
%r768 = getelementptr i32, i32* %r2, i32 7
%r769 = load i32, i32* %r768
%r771 = getelementptr i32, i32* %r2, i32 12
%r772 = load i32, i32* %r771
%r773 = call i64 @mul32x32L(i32 %r769, i32 %r772)
%r774 = zext i448 %r766 to i512
%r775 = zext i64 %r773 to i512
%r776 = shl i512 %r775, 448
%r777 = or i512 %r774, %r776
%r779 = getelementptr i32, i32* %r2, i32 8
%r780 = load i32, i32* %r779
%r782 = getelementptr i32, i32* %r2, i32 13
%r783 = load i32, i32* %r782
%r784 = call i64 @mul32x32L(i32 %r780, i32 %r783)
%r785 = zext i512 %r777 to i576
%r786 = zext i64 %r784 to i576
%r787 = shl i576 %r786, 512
%r788 = or i576 %r785, %r787
%r790 = getelementptr i32, i32* %r2, i32 9
%r791 = load i32, i32* %r790
%r793 = getelementptr i32, i32* %r2, i32 14
%r794 = load i32, i32* %r793
%r795 = call i64 @mul32x32L(i32 %r791, i32 %r794)
%r796 = zext i576 %r788 to i640
%r797 = zext i64 %r795 to i640
%r798 = shl i640 %r797, 576
%r799 = or i640 %r796, %r798
%r801 = getelementptr i32, i32* %r2, i32 10
%r802 = load i32, i32* %r801
%r804 = getelementptr i32, i32* %r2, i32 15
%r805 = load i32, i32* %r804
%r806 = call i64 @mul32x32L(i32 %r802, i32 %r805)
%r807 = zext i640 %r799 to i704
%r808 = zext i64 %r806 to i704
%r809 = shl i704 %r808, 640
%r810 = or i704 %r807, %r809
%r812 = getelementptr i32, i32* %r2, i32 11
%r813 = load i32, i32* %r812
%r815 = getelementptr i32, i32* %r2, i32 16
%r816 = load i32, i32* %r815
%r817 = call i64 @mul32x32L(i32 %r813, i32 %r816)
%r818 = zext i704 %r810 to i768
%r819 = zext i64 %r817 to i768
%r820 = shl i768 %r819, 704
%r821 = or i768 %r818, %r820
%r822 = zext i704 %r695 to i768
%r823 = shl i768 %r822, 32
%r824 = add i768 %r823, %r821
%r825 = load i32, i32* %r2
%r827 = getelementptr i32, i32* %r2, i32 4
%r828 = load i32, i32* %r827
%r829 = call i64 @mul32x32L(i32 %r825, i32 %r828)
%r831 = getelementptr i32, i32* %r2, i32 1
%r832 = load i32, i32* %r831
%r834 = getelementptr i32, i32* %r2, i32 5
%r835 = load i32, i32* %r834
%r836 = call i64 @mul32x32L(i32 %r832, i32 %r835)
%r837 = zext i64 %r829 to i128
%r838 = zext i64 %r836 to i128
%r839 = shl i128 %r838, 64
%r840 = or i128 %r837, %r839
%r842 = getelementptr i32, i32* %r2, i32 2
%r843 = load i32, i32* %r842
%r845 = getelementptr i32, i32* %r2, i32 6
%r846 = load i32, i32* %r845
%r847 = call i64 @mul32x32L(i32 %r843, i32 %r846)
%r848 = zext i128 %r840 to i192
%r849 = zext i64 %r847 to i192
%r850 = shl i192 %r849, 128
%r851 = or i192 %r848, %r850
%r853 = getelementptr i32, i32* %r2, i32 3
%r854 = load i32, i32* %r853
%r856 = getelementptr i32, i32* %r2, i32 7
%r857 = load i32, i32* %r856
%r858 = call i64 @mul32x32L(i32 %r854, i32 %r857)
%r859 = zext i192 %r851 to i256
%r860 = zext i64 %r858 to i256
%r861 = shl i256 %r860, 192
%r862 = or i256 %r859, %r861
%r864 = getelementptr i32, i32* %r2, i32 4
%r865 = load i32, i32* %r864
%r867 = getelementptr i32, i32* %r2, i32 8
%r868 = load i32, i32* %r867
%r869 = call i64 @mul32x32L(i32 %r865, i32 %r868)
%r870 = zext i256 %r862 to i320
%r871 = zext i64 %r869 to i320
%r872 = shl i320 %r871, 256
%r873 = or i320 %r870, %r872
%r875 = getelementptr i32, i32* %r2, i32 5
%r876 = load i32, i32* %r875
%r878 = getelementptr i32, i32* %r2, i32 9
%r879 = load i32, i32* %r878
%r880 = call i64 @mul32x32L(i32 %r876, i32 %r879)
%r881 = zext i320 %r873 to i384
%r882 = zext i64 %r880 to i384
%r883 = shl i384 %r882, 320
%r884 = or i384 %r881, %r883
%r886 = getelementptr i32, i32* %r2, i32 6
%r887 = load i32, i32* %r886
%r889 = getelementptr i32, i32* %r2, i32 10
%r890 = load i32, i32* %r889
%r891 = call i64 @mul32x32L(i32 %r887, i32 %r890)
%r892 = zext i384 %r884 to i448
%r893 = zext i64 %r891 to i448
%r894 = shl i448 %r893, 384
%r895 = or i448 %r892, %r894
%r897 = getelementptr i32, i32* %r2, i32 7
%r898 = load i32, i32* %r897
%r900 = getelementptr i32, i32* %r2, i32 11
%r901 = load i32, i32* %r900
%r902 = call i64 @mul32x32L(i32 %r898, i32 %r901)
%r903 = zext i448 %r895 to i512
%r904 = zext i64 %r902 to i512
%r905 = shl i512 %r904, 448
%r906 = or i512 %r903, %r905
%r908 = getelementptr i32, i32* %r2, i32 8
%r909 = load i32, i32* %r908
%r911 = getelementptr i32, i32* %r2, i32 12
%r912 = load i32, i32* %r911
%r913 = call i64 @mul32x32L(i32 %r909, i32 %r912)
%r914 = zext i512 %r906 to i576
%r915 = zext i64 %r913 to i576
%r916 = shl i576 %r915, 512
%r917 = or i576 %r914, %r916
%r919 = getelementptr i32, i32* %r2, i32 9
%r920 = load i32, i32* %r919
%r922 = getelementptr i32, i32* %r2, i32 13
%r923 = load i32, i32* %r922
%r924 = call i64 @mul32x32L(i32 %r920, i32 %r923)
%r925 = zext i576 %r917 to i640
%r926 = zext i64 %r924 to i640
%r927 = shl i640 %r926, 576
%r928 = or i640 %r925, %r927
%r930 = getelementptr i32, i32* %r2, i32 10
%r931 = load i32, i32* %r930
%r933 = getelementptr i32, i32* %r2, i32 14
%r934 = load i32, i32* %r933
%r935 = call i64 @mul32x32L(i32 %r931, i32 %r934)
%r936 = zext i640 %r928 to i704
%r937 = zext i64 %r935 to i704
%r938 = shl i704 %r937, 640
%r939 = or i704 %r936, %r938
%r941 = getelementptr i32, i32* %r2, i32 11
%r942 = load i32, i32* %r941
%r944 = getelementptr i32, i32* %r2, i32 15
%r945 = load i32, i32* %r944
%r946 = call i64 @mul32x32L(i32 %r942, i32 %r945)
%r947 = zext i704 %r939 to i768
%r948 = zext i64 %r946 to i768
%r949 = shl i768 %r948, 704
%r950 = or i768 %r947, %r949
%r952 = getelementptr i32, i32* %r2, i32 12
%r953 = load i32, i32* %r952
%r955 = getelementptr i32, i32* %r2, i32 16
%r956 = load i32, i32* %r955
%r957 = call i64 @mul32x32L(i32 %r953, i32 %r956)
%r958 = zext i768 %r950 to i832
%r959 = zext i64 %r957 to i832
%r960 = shl i832 %r959, 768
%r961 = or i832 %r958, %r960
%r962 = zext i768 %r824 to i832
%r963 = shl i832 %r962, 32
%r964 = add i832 %r963, %r961
%r965 = load i32, i32* %r2
%r967 = getelementptr i32, i32* %r2, i32 3
%r968 = load i32, i32* %r967
%r969 = call i64 @mul32x32L(i32 %r965, i32 %r968)
%r971 = getelementptr i32, i32* %r2, i32 1
%r972 = load i32, i32* %r971
%r974 = getelementptr i32, i32* %r2, i32 4
%r975 = load i32, i32* %r974
%r976 = call i64 @mul32x32L(i32 %r972, i32 %r975)
%r977 = zext i64 %r969 to i128
%r978 = zext i64 %r976 to i128
%r979 = shl i128 %r978, 64
%r980 = or i128 %r977, %r979
%r982 = getelementptr i32, i32* %r2, i32 2
%r983 = load i32, i32* %r982
%r985 = getelementptr i32, i32* %r2, i32 5
%r986 = load i32, i32* %r985
%r987 = call i64 @mul32x32L(i32 %r983, i32 %r986)
%r988 = zext i128 %r980 to i192
%r989 = zext i64 %r987 to i192
%r990 = shl i192 %r989, 128
%r991 = or i192 %r988, %r990
%r993 = getelementptr i32, i32* %r2, i32 3
%r994 = load i32, i32* %r993
%r996 = getelementptr i32, i32* %r2, i32 6
%r997 = load i32, i32* %r996
%r998 = call i64 @mul32x32L(i32 %r994, i32 %r997)
%r999 = zext i192 %r991 to i256
%r1000 = zext i64 %r998 to i256
%r1001 = shl i256 %r1000, 192
%r1002 = or i256 %r999, %r1001
%r1004 = getelementptr i32, i32* %r2, i32 4
%r1005 = load i32, i32* %r1004
%r1007 = getelementptr i32, i32* %r2, i32 7
%r1008 = load i32, i32* %r1007
%r1009 = call i64 @mul32x32L(i32 %r1005, i32 %r1008)
%r1010 = zext i256 %r1002 to i320
%r1011 = zext i64 %r1009 to i320
%r1012 = shl i320 %r1011, 256
%r1013 = or i320 %r1010, %r1012
%r1015 = getelementptr i32, i32* %r2, i32 5
%r1016 = load i32, i32* %r1015
%r1018 = getelementptr i32, i32* %r2, i32 8
%r1019 = load i32, i32* %r1018
%r1020 = call i64 @mul32x32L(i32 %r1016, i32 %r1019)
%r1021 = zext i320 %r1013 to i384
%r1022 = zext i64 %r1020 to i384
%r1023 = shl i384 %r1022, 320
%r1024 = or i384 %r1021, %r1023
%r1026 = getelementptr i32, i32* %r2, i32 6
%r1027 = load i32, i32* %r1026
%r1029 = getelementptr i32, i32* %r2, i32 9
%r1030 = load i32, i32* %r1029
%r1031 = call i64 @mul32x32L(i32 %r1027, i32 %r1030)
%r1032 = zext i384 %r1024 to i448
%r1033 = zext i64 %r1031 to i448
%r1034 = shl i448 %r1033, 384
%r1035 = or i448 %r1032, %r1034
%r1037 = getelementptr i32, i32* %r2, i32 7
%r1038 = load i32, i32* %r1037
%r1040 = getelementptr i32, i32* %r2, i32 10
%r1041 = load i32, i32* %r1040
%r1042 = call i64 @mul32x32L(i32 %r1038, i32 %r1041)
%r1043 = zext i448 %r1035 to i512
%r1044 = zext i64 %r1042 to i512
%r1045 = shl i512 %r1044, 448
%r1046 = or i512 %r1043, %r1045
%r1048 = getelementptr i32, i32* %r2, i32 8
%r1049 = load i32, i32* %r1048
%r1051 = getelementptr i32, i32* %r2, i32 11
%r1052 = load i32, i32* %r1051
%r1053 = call i64 @mul32x32L(i32 %r1049, i32 %r1052)
%r1054 = zext i512 %r1046 to i576
%r1055 = zext i64 %r1053 to i576
%r1056 = shl i576 %r1055, 512
%r1057 = or i576 %r1054, %r1056
%r1059 = getelementptr i32, i32* %r2, i32 9
%r1060 = load i32, i32* %r1059
%r1062 = getelementptr i32, i32* %r2, i32 12
%r1063 = load i32, i32* %r1062
%r1064 = call i64 @mul32x32L(i32 %r1060, i32 %r1063)
%r1065 = zext i576 %r1057 to i640
%r1066 = zext i64 %r1064 to i640
%r1067 = shl i640 %r1066, 576
%r1068 = or i640 %r1065, %r1067
%r1070 = getelementptr i32, i32* %r2, i32 10
%r1071 = load i32, i32* %r1070
%r1073 = getelementptr i32, i32* %r2, i32 13
%r1074 = load i32, i32* %r1073
%r1075 = call i64 @mul32x32L(i32 %r1071, i32 %r1074)
%r1076 = zext i640 %r1068 to i704
%r1077 = zext i64 %r1075 to i704
%r1078 = shl i704 %r1077, 640
%r1079 = or i704 %r1076, %r1078
%r1081 = getelementptr i32, i32* %r2, i32 11
%r1082 = load i32, i32* %r1081
%r1084 = getelementptr i32, i32* %r2, i32 14
%r1085 = load i32, i32* %r1084
%r1086 = call i64 @mul32x32L(i32 %r1082, i32 %r1085)
%r1087 = zext i704 %r1079 to i768
%r1088 = zext i64 %r1086 to i768
%r1089 = shl i768 %r1088, 704
%r1090 = or i768 %r1087, %r1089
%r1092 = getelementptr i32, i32* %r2, i32 12
%r1093 = load i32, i32* %r1092
%r1095 = getelementptr i32, i32* %r2, i32 15
%r1096 = load i32, i32* %r1095
%r1097 = call i64 @mul32x32L(i32 %r1093, i32 %r1096)
%r1098 = zext i768 %r1090 to i832
%r1099 = zext i64 %r1097 to i832
%r1100 = shl i832 %r1099, 768
%r1101 = or i832 %r1098, %r1100
%r1103 = getelementptr i32, i32* %r2, i32 13
%r1104 = load i32, i32* %r1103
%r1106 = getelementptr i32, i32* %r2, i32 16
%r1107 = load i32, i32* %r1106
%r1108 = call i64 @mul32x32L(i32 %r1104, i32 %r1107)
%r1109 = zext i832 %r1101 to i896
%r1110 = zext i64 %r1108 to i896
%r1111 = shl i896 %r1110, 832
%r1112 = or i896 %r1109, %r1111
%r1113 = zext i832 %r964 to i896
%r1114 = shl i896 %r1113, 32
%r1115 = add i896 %r1114, %r1112
%r1116 = load i32, i32* %r2
%r1118 = getelementptr i32, i32* %r2, i32 2
%r1119 = load i32, i32* %r1118
%r1120 = call i64 @mul32x32L(i32 %r1116, i32 %r1119)
%r1122 = getelementptr i32, i32* %r2, i32 1
%r1123 = load i32, i32* %r1122
%r1125 = getelementptr i32, i32* %r2, i32 3
%r1126 = load i32, i32* %r1125
%r1127 = call i64 @mul32x32L(i32 %r1123, i32 %r1126)
%r1128 = zext i64 %r1120 to i128
%r1129 = zext i64 %r1127 to i128
%r1130 = shl i128 %r1129, 64
%r1131 = or i128 %r1128, %r1130
%r1133 = getelementptr i32, i32* %r2, i32 2
%r1134 = load i32, i32* %r1133
%r1136 = getelementptr i32, i32* %r2, i32 4
%r1137 = load i32, i32* %r1136
%r1138 = call i64 @mul32x32L(i32 %r1134, i32 %r1137)
%r1139 = zext i128 %r1131 to i192
%r1140 = zext i64 %r1138 to i192
%r1141 = shl i192 %r1140, 128
%r1142 = or i192 %r1139, %r1141
%r1144 = getelementptr i32, i32* %r2, i32 3
%r1145 = load i32, i32* %r1144
%r1147 = getelementptr i32, i32* %r2, i32 5
%r1148 = load i32, i32* %r1147
%r1149 = call i64 @mul32x32L(i32 %r1145, i32 %r1148)
%r1150 = zext i192 %r1142 to i256
%r1151 = zext i64 %r1149 to i256
%r1152 = shl i256 %r1151, 192
%r1153 = or i256 %r1150, %r1152
%r1155 = getelementptr i32, i32* %r2, i32 4
%r1156 = load i32, i32* %r1155
%r1158 = getelementptr i32, i32* %r2, i32 6
%r1159 = load i32, i32* %r1158
%r1160 = call i64 @mul32x32L(i32 %r1156, i32 %r1159)
%r1161 = zext i256 %r1153 to i320
%r1162 = zext i64 %r1160 to i320
%r1163 = shl i320 %r1162, 256
%r1164 = or i320 %r1161, %r1163
%r1166 = getelementptr i32, i32* %r2, i32 5
%r1167 = load i32, i32* %r1166
%r1169 = getelementptr i32, i32* %r2, i32 7
%r1170 = load i32, i32* %r1169
%r1171 = call i64 @mul32x32L(i32 %r1167, i32 %r1170)
%r1172 = zext i320 %r1164 to i384
%r1173 = zext i64 %r1171 to i384
%r1174 = shl i384 %r1173, 320
%r1175 = or i384 %r1172, %r1174
%r1177 = getelementptr i32, i32* %r2, i32 6
%r1178 = load i32, i32* %r1177
%r1180 = getelementptr i32, i32* %r2, i32 8
%r1181 = load i32, i32* %r1180
%r1182 = call i64 @mul32x32L(i32 %r1178, i32 %r1181)
%r1183 = zext i384 %r1175 to i448
%r1184 = zext i64 %r1182 to i448
%r1185 = shl i448 %r1184, 384
%r1186 = or i448 %r1183, %r1185
%r1188 = getelementptr i32, i32* %r2, i32 7
%r1189 = load i32, i32* %r1188
%r1191 = getelementptr i32, i32* %r2, i32 9
%r1192 = load i32, i32* %r1191
%r1193 = call i64 @mul32x32L(i32 %r1189, i32 %r1192)
%r1194 = zext i448 %r1186 to i512
%r1195 = zext i64 %r1193 to i512
%r1196 = shl i512 %r1195, 448
%r1197 = or i512 %r1194, %r1196
%r1199 = getelementptr i32, i32* %r2, i32 8
%r1200 = load i32, i32* %r1199
%r1202 = getelementptr i32, i32* %r2, i32 10
%r1203 = load i32, i32* %r1202
%r1204 = call i64 @mul32x32L(i32 %r1200, i32 %r1203)
%r1205 = zext i512 %r1197 to i576
%r1206 = zext i64 %r1204 to i576
%r1207 = shl i576 %r1206, 512
%r1208 = or i576 %r1205, %r1207
%r1210 = getelementptr i32, i32* %r2, i32 9
%r1211 = load i32, i32* %r1210
%r1213 = getelementptr i32, i32* %r2, i32 11
%r1214 = load i32, i32* %r1213
%r1215 = call i64 @mul32x32L(i32 %r1211, i32 %r1214)
%r1216 = zext i576 %r1208 to i640
%r1217 = zext i64 %r1215 to i640
%r1218 = shl i640 %r1217, 576
%r1219 = or i640 %r1216, %r1218
%r1221 = getelementptr i32, i32* %r2, i32 10
%r1222 = load i32, i32* %r1221
%r1224 = getelementptr i32, i32* %r2, i32 12
%r1225 = load i32, i32* %r1224
%r1226 = call i64 @mul32x32L(i32 %r1222, i32 %r1225)
%r1227 = zext i640 %r1219 to i704
%r1228 = zext i64 %r1226 to i704
%r1229 = shl i704 %r1228, 640
%r1230 = or i704 %r1227, %r1229
%r1232 = getelementptr i32, i32* %r2, i32 11
%r1233 = load i32, i32* %r1232
%r1235 = getelementptr i32, i32* %r2, i32 13
%r1236 = load i32, i32* %r1235
%r1237 = call i64 @mul32x32L(i32 %r1233, i32 %r1236)
%r1238 = zext i704 %r1230 to i768
%r1239 = zext i64 %r1237 to i768
%r1240 = shl i768 %r1239, 704
%r1241 = or i768 %r1238, %r1240
%r1243 = getelementptr i32, i32* %r2, i32 12
%r1244 = load i32, i32* %r1243
%r1246 = getelementptr i32, i32* %r2, i32 14
%r1247 = load i32, i32* %r1246
%r1248 = call i64 @mul32x32L(i32 %r1244, i32 %r1247)
%r1249 = zext i768 %r1241 to i832
%r1250 = zext i64 %r1248 to i832
%r1251 = shl i832 %r1250, 768
%r1252 = or i832 %r1249, %r1251
%r1254 = getelementptr i32, i32* %r2, i32 13
%r1255 = load i32, i32* %r1254
%r1257 = getelementptr i32, i32* %r2, i32 15
%r1258 = load i32, i32* %r1257
%r1259 = call i64 @mul32x32L(i32 %r1255, i32 %r1258)
%r1260 = zext i832 %r1252 to i896
%r1261 = zext i64 %r1259 to i896
%r1262 = shl i896 %r1261, 832
%r1263 = or i896 %r1260, %r1262
%r1265 = getelementptr i32, i32* %r2, i32 14
%r1266 = load i32, i32* %r1265
%r1268 = getelementptr i32, i32* %r2, i32 16
%r1269 = load i32, i32* %r1268
%r1270 = call i64 @mul32x32L(i32 %r1266, i32 %r1269)
%r1271 = zext i896 %r1263 to i960
%r1272 = zext i64 %r1270 to i960
%r1273 = shl i960 %r1272, 896
%r1274 = or i960 %r1271, %r1273
%r1275 = zext i896 %r1115 to i960
%r1276 = shl i960 %r1275, 32
%r1277 = add i960 %r1276, %r1274
%r1278 = load i32, i32* %r2
%r1280 = getelementptr i32, i32* %r2, i32 1
%r1281 = load i32, i32* %r1280
%r1282 = call i64 @mul32x32L(i32 %r1278, i32 %r1281)
%r1284 = getelementptr i32, i32* %r2, i32 1
%r1285 = load i32, i32* %r1284
%r1287 = getelementptr i32, i32* %r2, i32 2
%r1288 = load i32, i32* %r1287
%r1289 = call i64 @mul32x32L(i32 %r1285, i32 %r1288)
%r1290 = zext i64 %r1282 to i128
%r1291 = zext i64 %r1289 to i128
%r1292 = shl i128 %r1291, 64
%r1293 = or i128 %r1290, %r1292
%r1295 = getelementptr i32, i32* %r2, i32 2
%r1296 = load i32, i32* %r1295
%r1298 = getelementptr i32, i32* %r2, i32 3
%r1299 = load i32, i32* %r1298
%r1300 = call i64 @mul32x32L(i32 %r1296, i32 %r1299)
%r1301 = zext i128 %r1293 to i192
%r1302 = zext i64 %r1300 to i192
%r1303 = shl i192 %r1302, 128
%r1304 = or i192 %r1301, %r1303
%r1306 = getelementptr i32, i32* %r2, i32 3
%r1307 = load i32, i32* %r1306
%r1309 = getelementptr i32, i32* %r2, i32 4
%r1310 = load i32, i32* %r1309
%r1311 = call i64 @mul32x32L(i32 %r1307, i32 %r1310)
%r1312 = zext i192 %r1304 to i256
%r1313 = zext i64 %r1311 to i256
%r1314 = shl i256 %r1313, 192
%r1315 = or i256 %r1312, %r1314
%r1317 = getelementptr i32, i32* %r2, i32 4
%r1318 = load i32, i32* %r1317
%r1320 = getelementptr i32, i32* %r2, i32 5
%r1321 = load i32, i32* %r1320
%r1322 = call i64 @mul32x32L(i32 %r1318, i32 %r1321)
%r1323 = zext i256 %r1315 to i320
%r1324 = zext i64 %r1322 to i320
%r1325 = shl i320 %r1324, 256
%r1326 = or i320 %r1323, %r1325
%r1328 = getelementptr i32, i32* %r2, i32 5
%r1329 = load i32, i32* %r1328
%r1331 = getelementptr i32, i32* %r2, i32 6
%r1332 = load i32, i32* %r1331
%r1333 = call i64 @mul32x32L(i32 %r1329, i32 %r1332)
%r1334 = zext i320 %r1326 to i384
%r1335 = zext i64 %r1333 to i384
%r1336 = shl i384 %r1335, 320
%r1337 = or i384 %r1334, %r1336
%r1339 = getelementptr i32, i32* %r2, i32 6
%r1340 = load i32, i32* %r1339
%r1342 = getelementptr i32, i32* %r2, i32 7
%r1343 = load i32, i32* %r1342
%r1344 = call i64 @mul32x32L(i32 %r1340, i32 %r1343)
%r1345 = zext i384 %r1337 to i448
%r1346 = zext i64 %r1344 to i448
%r1347 = shl i448 %r1346, 384
%r1348 = or i448 %r1345, %r1347
%r1350 = getelementptr i32, i32* %r2, i32 7
%r1351 = load i32, i32* %r1350
%r1353 = getelementptr i32, i32* %r2, i32 8
%r1354 = load i32, i32* %r1353
%r1355 = call i64 @mul32x32L(i32 %r1351, i32 %r1354)
%r1356 = zext i448 %r1348 to i512
%r1357 = zext i64 %r1355 to i512
%r1358 = shl i512 %r1357, 448
%r1359 = or i512 %r1356, %r1358
%r1361 = getelementptr i32, i32* %r2, i32 8
%r1362 = load i32, i32* %r1361
%r1364 = getelementptr i32, i32* %r2, i32 9
%r1365 = load i32, i32* %r1364
%r1366 = call i64 @mul32x32L(i32 %r1362, i32 %r1365)
%r1367 = zext i512 %r1359 to i576
%r1368 = zext i64 %r1366 to i576
%r1369 = shl i576 %r1368, 512
%r1370 = or i576 %r1367, %r1369
%r1372 = getelementptr i32, i32* %r2, i32 9
%r1373 = load i32, i32* %r1372
%r1375 = getelementptr i32, i32* %r2, i32 10
%r1376 = load i32, i32* %r1375
%r1377 = call i64 @mul32x32L(i32 %r1373, i32 %r1376)
%r1378 = zext i576 %r1370 to i640
%r1379 = zext i64 %r1377 to i640
%r1380 = shl i640 %r1379, 576
%r1381 = or i640 %r1378, %r1380
%r1383 = getelementptr i32, i32* %r2, i32 10
%r1384 = load i32, i32* %r1383
%r1386 = getelementptr i32, i32* %r2, i32 11
%r1387 = load i32, i32* %r1386
%r1388 = call i64 @mul32x32L(i32 %r1384, i32 %r1387)
%r1389 = zext i640 %r1381 to i704
%r1390 = zext i64 %r1388 to i704
%r1391 = shl i704 %r1390, 640
%r1392 = or i704 %r1389, %r1391
%r1394 = getelementptr i32, i32* %r2, i32 11
%r1395 = load i32, i32* %r1394
%r1397 = getelementptr i32, i32* %r2, i32 12
%r1398 = load i32, i32* %r1397
%r1399 = call i64 @mul32x32L(i32 %r1395, i32 %r1398)
%r1400 = zext i704 %r1392 to i768
%r1401 = zext i64 %r1399 to i768
%r1402 = shl i768 %r1401, 704
%r1403 = or i768 %r1400, %r1402
%r1405 = getelementptr i32, i32* %r2, i32 12
%r1406 = load i32, i32* %r1405
%r1408 = getelementptr i32, i32* %r2, i32 13
%r1409 = load i32, i32* %r1408
%r1410 = call i64 @mul32x32L(i32 %r1406, i32 %r1409)
%r1411 = zext i768 %r1403 to i832
%r1412 = zext i64 %r1410 to i832
%r1413 = shl i832 %r1412, 768
%r1414 = or i832 %r1411, %r1413
%r1416 = getelementptr i32, i32* %r2, i32 13
%r1417 = load i32, i32* %r1416
%r1419 = getelementptr i32, i32* %r2, i32 14
%r1420 = load i32, i32* %r1419
%r1421 = call i64 @mul32x32L(i32 %r1417, i32 %r1420)
%r1422 = zext i832 %r1414 to i896
%r1423 = zext i64 %r1421 to i896
%r1424 = shl i896 %r1423, 832
%r1425 = or i896 %r1422, %r1424
%r1427 = getelementptr i32, i32* %r2, i32 14
%r1428 = load i32, i32* %r1427
%r1430 = getelementptr i32, i32* %r2, i32 15
%r1431 = load i32, i32* %r1430
%r1432 = call i64 @mul32x32L(i32 %r1428, i32 %r1431)
%r1433 = zext i896 %r1425 to i960
%r1434 = zext i64 %r1432 to i960
%r1435 = shl i960 %r1434, 896
%r1436 = or i960 %r1433, %r1435
%r1438 = getelementptr i32, i32* %r2, i32 15
%r1439 = load i32, i32* %r1438
%r1441 = getelementptr i32, i32* %r2, i32 16
%r1442 = load i32, i32* %r1441
%r1443 = call i64 @mul32x32L(i32 %r1439, i32 %r1442)
%r1444 = zext i960 %r1436 to i1024
%r1445 = zext i64 %r1443 to i1024
%r1446 = shl i1024 %r1445, 960
%r1447 = or i1024 %r1444, %r1446
%r1448 = zext i960 %r1277 to i1024
%r1449 = shl i1024 %r1448, 32
%r1450 = add i1024 %r1449, %r1447
%r1451 = zext i64 %r6 to i1056
%r1453 = getelementptr i32, i32* %r2, i32 1
%r1454 = load i32, i32* %r1453
%r1455 = call i64 @mul32x32L(i32 %r1454, i32 %r1454)
%r1456 = zext i64 %r1455 to i1056
%r1457 = shl i1056 %r1456, 32
%r1458 = or i1056 %r1451, %r1457
%r1460 = getelementptr i32, i32* %r2, i32 2
%r1461 = load i32, i32* %r1460
%r1462 = call i64 @mul32x32L(i32 %r1461, i32 %r1461)
%r1463 = zext i64 %r1462 to i1056
%r1464 = shl i1056 %r1463, 96
%r1465 = or i1056 %r1458, %r1464
%r1467 = getelementptr i32, i32* %r2, i32 3
%r1468 = load i32, i32* %r1467
%r1469 = call i64 @mul32x32L(i32 %r1468, i32 %r1468)
%r1470 = zext i64 %r1469 to i1056
%r1471 = shl i1056 %r1470, 160
%r1472 = or i1056 %r1465, %r1471
%r1474 = getelementptr i32, i32* %r2, i32 4
%r1475 = load i32, i32* %r1474
%r1476 = call i64 @mul32x32L(i32 %r1475, i32 %r1475)
%r1477 = zext i64 %r1476 to i1056
%r1478 = shl i1056 %r1477, 224
%r1479 = or i1056 %r1472, %r1478
%r1481 = getelementptr i32, i32* %r2, i32 5
%r1482 = load i32, i32* %r1481
%r1483 = call i64 @mul32x32L(i32 %r1482, i32 %r1482)
%r1484 = zext i64 %r1483 to i1056
%r1485 = shl i1056 %r1484, 288
%r1486 = or i1056 %r1479, %r1485
%r1488 = getelementptr i32, i32* %r2, i32 6
%r1489 = load i32, i32* %r1488
%r1490 = call i64 @mul32x32L(i32 %r1489, i32 %r1489)
%r1491 = zext i64 %r1490 to i1056
%r1492 = shl i1056 %r1491, 352
%r1493 = or i1056 %r1486, %r1492
%r1495 = getelementptr i32, i32* %r2, i32 7
%r1496 = load i32, i32* %r1495
%r1497 = call i64 @mul32x32L(i32 %r1496, i32 %r1496)
%r1498 = zext i64 %r1497 to i1056
%r1499 = shl i1056 %r1498, 416
%r1500 = or i1056 %r1493, %r1499
%r1502 = getelementptr i32, i32* %r2, i32 8
%r1503 = load i32, i32* %r1502
%r1504 = call i64 @mul32x32L(i32 %r1503, i32 %r1503)
%r1505 = zext i64 %r1504 to i1056
%r1506 = shl i1056 %r1505, 480
%r1507 = or i1056 %r1500, %r1506
%r1509 = getelementptr i32, i32* %r2, i32 9
%r1510 = load i32, i32* %r1509
%r1511 = call i64 @mul32x32L(i32 %r1510, i32 %r1510)
%r1512 = zext i64 %r1511 to i1056
%r1513 = shl i1056 %r1512, 544
%r1514 = or i1056 %r1507, %r1513
%r1516 = getelementptr i32, i32* %r2, i32 10
%r1517 = load i32, i32* %r1516
%r1518 = call i64 @mul32x32L(i32 %r1517, i32 %r1517)
%r1519 = zext i64 %r1518 to i1056
%r1520 = shl i1056 %r1519, 608
%r1521 = or i1056 %r1514, %r1520
%r1523 = getelementptr i32, i32* %r2, i32 11
%r1524 = load i32, i32* %r1523
%r1525 = call i64 @mul32x32L(i32 %r1524, i32 %r1524)
%r1526 = zext i64 %r1525 to i1056
%r1527 = shl i1056 %r1526, 672
%r1528 = or i1056 %r1521, %r1527
%r1530 = getelementptr i32, i32* %r2, i32 12
%r1531 = load i32, i32* %r1530
%r1532 = call i64 @mul32x32L(i32 %r1531, i32 %r1531)
%r1533 = zext i64 %r1532 to i1056
%r1534 = shl i1056 %r1533, 736
%r1535 = or i1056 %r1528, %r1534
%r1537 = getelementptr i32, i32* %r2, i32 13
%r1538 = load i32, i32* %r1537
%r1539 = call i64 @mul32x32L(i32 %r1538, i32 %r1538)
%r1540 = zext i64 %r1539 to i1056
%r1541 = shl i1056 %r1540, 800
%r1542 = or i1056 %r1535, %r1541
%r1544 = getelementptr i32, i32* %r2, i32 14
%r1545 = load i32, i32* %r1544
%r1546 = call i64 @mul32x32L(i32 %r1545, i32 %r1545)
%r1547 = zext i64 %r1546 to i1056
%r1548 = shl i1056 %r1547, 864
%r1549 = or i1056 %r1542, %r1548
%r1551 = getelementptr i32, i32* %r2, i32 15
%r1552 = load i32, i32* %r1551
%r1553 = call i64 @mul32x32L(i32 %r1552, i32 %r1552)
%r1554 = zext i64 %r1553 to i1056
%r1555 = shl i1056 %r1554, 928
%r1556 = or i1056 %r1549, %r1555
%r1558 = getelementptr i32, i32* %r2, i32 16
%r1559 = load i32, i32* %r1558
%r1560 = call i64 @mul32x32L(i32 %r1559, i32 %r1559)
%r1561 = zext i64 %r1560 to i1056
%r1562 = shl i1056 %r1561, 992
%r1563 = or i1056 %r1556, %r1562
%r1564 = zext i1024 %r1450 to i1056
%r1565 = add i1056 %r1564, %r1564
%r1566 = add i1056 %r1563, %r1565
%r1568 = getelementptr i32, i32* %r1, i32 1
%r1570 = getelementptr i32, i32* %r1568, i32 0
%r1571 = trunc i1056 %r1566 to i32
store i32 %r1571, i32* %r1570
%r1572 = lshr i1056 %r1566, 32
%r1574 = getelementptr i32, i32* %r1568, i32 1
%r1575 = trunc i1056 %r1572 to i32
store i32 %r1575, i32* %r1574
%r1576 = lshr i1056 %r1572, 32
%r1578 = getelementptr i32, i32* %r1568, i32 2
%r1579 = trunc i1056 %r1576 to i32
store i32 %r1579, i32* %r1578
%r1580 = lshr i1056 %r1576, 32
%r1582 = getelementptr i32, i32* %r1568, i32 3
%r1583 = trunc i1056 %r1580 to i32
store i32 %r1583, i32* %r1582
%r1584 = lshr i1056 %r1580, 32
%r1586 = getelementptr i32, i32* %r1568, i32 4
%r1587 = trunc i1056 %r1584 to i32
store i32 %r1587, i32* %r1586
%r1588 = lshr i1056 %r1584, 32
%r1590 = getelementptr i32, i32* %r1568, i32 5
%r1591 = trunc i1056 %r1588 to i32
store i32 %r1591, i32* %r1590
%r1592 = lshr i1056 %r1588, 32
%r1594 = getelementptr i32, i32* %r1568, i32 6
%r1595 = trunc i1056 %r1592 to i32
store i32 %r1595, i32* %r1594
%r1596 = lshr i1056 %r1592, 32
%r1598 = getelementptr i32, i32* %r1568, i32 7
%r1599 = trunc i1056 %r1596 to i32
store i32 %r1599, i32* %r1598
%r1600 = lshr i1056 %r1596, 32
%r1602 = getelementptr i32, i32* %r1568, i32 8
%r1603 = trunc i1056 %r1600 to i32
store i32 %r1603, i32* %r1602
%r1604 = lshr i1056 %r1600, 32
%r1606 = getelementptr i32, i32* %r1568, i32 9
%r1607 = trunc i1056 %r1604 to i32
store i32 %r1607, i32* %r1606
%r1608 = lshr i1056 %r1604, 32
%r1610 = getelementptr i32, i32* %r1568, i32 10
%r1611 = trunc i1056 %r1608 to i32
store i32 %r1611, i32* %r1610
%r1612 = lshr i1056 %r1608, 32
%r1614 = getelementptr i32, i32* %r1568, i32 11
%r1615 = trunc i1056 %r1612 to i32
store i32 %r1615, i32* %r1614
%r1616 = lshr i1056 %r1612, 32
%r1618 = getelementptr i32, i32* %r1568, i32 12
%r1619 = trunc i1056 %r1616 to i32
store i32 %r1619, i32* %r1618
%r1620 = lshr i1056 %r1616, 32
%r1622 = getelementptr i32, i32* %r1568, i32 13
%r1623 = trunc i1056 %r1620 to i32
store i32 %r1623, i32* %r1622
%r1624 = lshr i1056 %r1620, 32
%r1626 = getelementptr i32, i32* %r1568, i32 14
%r1627 = trunc i1056 %r1624 to i32
store i32 %r1627, i32* %r1626
%r1628 = lshr i1056 %r1624, 32
%r1630 = getelementptr i32, i32* %r1568, i32 15
%r1631 = trunc i1056 %r1628 to i32
store i32 %r1631, i32* %r1630
%r1632 = lshr i1056 %r1628, 32
%r1634 = getelementptr i32, i32* %r1568, i32 16
%r1635 = trunc i1056 %r1632 to i32
store i32 %r1635, i32* %r1634
%r1636 = lshr i1056 %r1632, 32
%r1638 = getelementptr i32, i32* %r1568, i32 17
%r1639 = trunc i1056 %r1636 to i32
store i32 %r1639, i32* %r1638
%r1640 = lshr i1056 %r1636, 32
%r1642 = getelementptr i32, i32* %r1568, i32 18
%r1643 = trunc i1056 %r1640 to i32
store i32 %r1643, i32* %r1642
%r1644 = lshr i1056 %r1640, 32
%r1646 = getelementptr i32, i32* %r1568, i32 19
%r1647 = trunc i1056 %r1644 to i32
store i32 %r1647, i32* %r1646
%r1648 = lshr i1056 %r1644, 32
%r1650 = getelementptr i32, i32* %r1568, i32 20
%r1651 = trunc i1056 %r1648 to i32
store i32 %r1651, i32* %r1650
%r1652 = lshr i1056 %r1648, 32
%r1654 = getelementptr i32, i32* %r1568, i32 21
%r1655 = trunc i1056 %r1652 to i32
store i32 %r1655, i32* %r1654
%r1656 = lshr i1056 %r1652, 32
%r1658 = getelementptr i32, i32* %r1568, i32 22
%r1659 = trunc i1056 %r1656 to i32
store i32 %r1659, i32* %r1658
%r1660 = lshr i1056 %r1656, 32
%r1662 = getelementptr i32, i32* %r1568, i32 23
%r1663 = trunc i1056 %r1660 to i32
store i32 %r1663, i32* %r1662
%r1664 = lshr i1056 %r1660, 32
%r1666 = getelementptr i32, i32* %r1568, i32 24
%r1667 = trunc i1056 %r1664 to i32
store i32 %r1667, i32* %r1666
%r1668 = lshr i1056 %r1664, 32
%r1670 = getelementptr i32, i32* %r1568, i32 25
%r1671 = trunc i1056 %r1668 to i32
store i32 %r1671, i32* %r1670
%r1672 = lshr i1056 %r1668, 32
%r1674 = getelementptr i32, i32* %r1568, i32 26
%r1675 = trunc i1056 %r1672 to i32
store i32 %r1675, i32* %r1674
%r1676 = lshr i1056 %r1672, 32
%r1678 = getelementptr i32, i32* %r1568, i32 27
%r1679 = trunc i1056 %r1676 to i32
store i32 %r1679, i32* %r1678
%r1680 = lshr i1056 %r1676, 32
%r1682 = getelementptr i32, i32* %r1568, i32 28
%r1683 = trunc i1056 %r1680 to i32
store i32 %r1683, i32* %r1682
%r1684 = lshr i1056 %r1680, 32
%r1686 = getelementptr i32, i32* %r1568, i32 29
%r1687 = trunc i1056 %r1684 to i32
store i32 %r1687, i32* %r1686
%r1688 = lshr i1056 %r1684, 32
%r1690 = getelementptr i32, i32* %r1568, i32 30
%r1691 = trunc i1056 %r1688 to i32
store i32 %r1691, i32* %r1690
%r1692 = lshr i1056 %r1688, 32
%r1694 = getelementptr i32, i32* %r1568, i32 31
%r1695 = trunc i1056 %r1692 to i32
store i32 %r1695, i32* %r1694
%r1696 = lshr i1056 %r1692, 32
%r1698 = getelementptr i32, i32* %r1568, i32 32
%r1699 = trunc i1056 %r1696 to i32
store i32 %r1699, i32* %r1698
ret void
}
