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
define i64 @mclb_add1(i64* noalias  %r2, i64* noalias  %r3, i64* noalias  %r4)
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
define i64 @mclb_sub1(i64* noalias  %r2, i64* noalias  %r3, i64* noalias  %r4)
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
define void @mclb_addNF1(i64* noalias  %r1, i64* noalias  %r2, i64* noalias  %r3)
{
%r4 = load i64, i64* %r2
%r5 = load i64, i64* %r3
%r6 = add i64 %r4, %r5
store i64 %r6, i64* %r1
ret void
}
define i64 @mclb_subNF1(i64* noalias  %r2, i64* noalias  %r3, i64* noalias  %r4)
{
%r5 = load i64, i64* %r3
%r6 = load i64, i64* %r4
%r7 = sub i64 %r5, %r6
store i64 %r7, i64* %r2
%r8 = lshr i64 %r7, 63
%r10 = and i64 %r8, 1
ret i64 %r10
}
define i64 @mclb_add2(i64* noalias  %r2, i64* noalias  %r3, i64* noalias  %r4)
{
%r6 = bitcast i64* %r3 to i128*
%r7 = load i128, i128* %r6
%r8 = zext i128 %r7 to i192
%r10 = bitcast i64* %r4 to i128*
%r11 = load i128, i128* %r10
%r12 = zext i128 %r11 to i192
%r13 = add i192 %r8, %r12
%r14 = trunc i192 %r13 to i128
%r16 = getelementptr i64, i64* %r2, i32 0
%r17 = trunc i128 %r14 to i64
store i64 %r17, i64* %r16
%r18 = lshr i128 %r14, 64
%r20 = getelementptr i64, i64* %r2, i32 1
%r21 = trunc i128 %r18 to i64
store i64 %r21, i64* %r20
%r22 = lshr i192 %r13, 128
%r23 = trunc i192 %r22 to i64
ret i64 %r23
}
define i64 @mclb_sub2(i64* noalias  %r2, i64* noalias  %r3, i64* noalias  %r4)
{
%r6 = bitcast i64* %r3 to i128*
%r7 = load i128, i128* %r6
%r8 = zext i128 %r7 to i192
%r10 = bitcast i64* %r4 to i128*
%r11 = load i128, i128* %r10
%r12 = zext i128 %r11 to i192
%r13 = sub i192 %r8, %r12
%r14 = trunc i192 %r13 to i128
%r16 = getelementptr i64, i64* %r2, i32 0
%r17 = trunc i128 %r14 to i64
store i64 %r17, i64* %r16
%r18 = lshr i128 %r14, 64
%r20 = getelementptr i64, i64* %r2, i32 1
%r21 = trunc i128 %r18 to i64
store i64 %r21, i64* %r20
%r22 = lshr i192 %r13, 128
%r23 = trunc i192 %r22 to i64
%r25 = and i64 %r23, 1
ret i64 %r25
}
define void @mclb_addNF2(i64* noalias  %r1, i64* noalias  %r2, i64* noalias  %r3)
{
%r5 = bitcast i64* %r2 to i128*
%r6 = load i128, i128* %r5
%r8 = bitcast i64* %r3 to i128*
%r9 = load i128, i128* %r8
%r10 = add i128 %r6, %r9
%r12 = getelementptr i64, i64* %r1, i32 0
%r13 = trunc i128 %r10 to i64
store i64 %r13, i64* %r12
%r14 = lshr i128 %r10, 64
%r16 = getelementptr i64, i64* %r1, i32 1
%r17 = trunc i128 %r14 to i64
store i64 %r17, i64* %r16
ret void
}
define i64 @mclb_subNF2(i64* noalias  %r2, i64* noalias  %r3, i64* noalias  %r4)
{
%r6 = bitcast i64* %r3 to i128*
%r7 = load i128, i128* %r6
%r9 = bitcast i64* %r4 to i128*
%r10 = load i128, i128* %r9
%r11 = sub i128 %r7, %r10
%r13 = getelementptr i64, i64* %r2, i32 0
%r14 = trunc i128 %r11 to i64
store i64 %r14, i64* %r13
%r15 = lshr i128 %r11, 64
%r17 = getelementptr i64, i64* %r2, i32 1
%r18 = trunc i128 %r15 to i64
store i64 %r18, i64* %r17
%r19 = lshr i128 %r11, 127
%r20 = trunc i128 %r19 to i64
%r22 = and i64 %r20, 1
ret i64 %r22
}
define i64 @mclb_add3(i64* noalias  %r2, i64* noalias  %r3, i64* noalias  %r4)
{
%r6 = bitcast i64* %r3 to i192*
%r7 = load i192, i192* %r6
%r8 = zext i192 %r7 to i256
%r10 = bitcast i64* %r4 to i192*
%r11 = load i192, i192* %r10
%r12 = zext i192 %r11 to i256
%r13 = add i256 %r8, %r12
%r14 = trunc i256 %r13 to i192
%r16 = getelementptr i64, i64* %r2, i32 0
%r17 = trunc i192 %r14 to i64
store i64 %r17, i64* %r16
%r18 = lshr i192 %r14, 64
%r20 = getelementptr i64, i64* %r2, i32 1
%r21 = trunc i192 %r18 to i64
store i64 %r21, i64* %r20
%r22 = lshr i192 %r18, 64
%r24 = getelementptr i64, i64* %r2, i32 2
%r25 = trunc i192 %r22 to i64
store i64 %r25, i64* %r24
%r26 = lshr i256 %r13, 192
%r27 = trunc i256 %r26 to i64
ret i64 %r27
}
define i64 @mclb_sub3(i64* noalias  %r2, i64* noalias  %r3, i64* noalias  %r4)
{
%r6 = bitcast i64* %r3 to i192*
%r7 = load i192, i192* %r6
%r8 = zext i192 %r7 to i256
%r10 = bitcast i64* %r4 to i192*
%r11 = load i192, i192* %r10
%r12 = zext i192 %r11 to i256
%r13 = sub i256 %r8, %r12
%r14 = trunc i256 %r13 to i192
%r16 = getelementptr i64, i64* %r2, i32 0
%r17 = trunc i192 %r14 to i64
store i64 %r17, i64* %r16
%r18 = lshr i192 %r14, 64
%r20 = getelementptr i64, i64* %r2, i32 1
%r21 = trunc i192 %r18 to i64
store i64 %r21, i64* %r20
%r22 = lshr i192 %r18, 64
%r24 = getelementptr i64, i64* %r2, i32 2
%r25 = trunc i192 %r22 to i64
store i64 %r25, i64* %r24
%r26 = lshr i256 %r13, 192
%r27 = trunc i256 %r26 to i64
%r29 = and i64 %r27, 1
ret i64 %r29
}
define void @mclb_addNF3(i64* noalias  %r1, i64* noalias  %r2, i64* noalias  %r3)
{
%r5 = bitcast i64* %r2 to i192*
%r6 = load i192, i192* %r5
%r8 = bitcast i64* %r3 to i192*
%r9 = load i192, i192* %r8
%r10 = add i192 %r6, %r9
%r12 = getelementptr i64, i64* %r1, i32 0
%r13 = trunc i192 %r10 to i64
store i64 %r13, i64* %r12
%r14 = lshr i192 %r10, 64
%r16 = getelementptr i64, i64* %r1, i32 1
%r17 = trunc i192 %r14 to i64
store i64 %r17, i64* %r16
%r18 = lshr i192 %r14, 64
%r20 = getelementptr i64, i64* %r1, i32 2
%r21 = trunc i192 %r18 to i64
store i64 %r21, i64* %r20
ret void
}
define i64 @mclb_subNF3(i64* noalias  %r2, i64* noalias  %r3, i64* noalias  %r4)
{
%r6 = bitcast i64* %r3 to i192*
%r7 = load i192, i192* %r6
%r9 = bitcast i64* %r4 to i192*
%r10 = load i192, i192* %r9
%r11 = sub i192 %r7, %r10
%r13 = getelementptr i64, i64* %r2, i32 0
%r14 = trunc i192 %r11 to i64
store i64 %r14, i64* %r13
%r15 = lshr i192 %r11, 64
%r17 = getelementptr i64, i64* %r2, i32 1
%r18 = trunc i192 %r15 to i64
store i64 %r18, i64* %r17
%r19 = lshr i192 %r15, 64
%r21 = getelementptr i64, i64* %r2, i32 2
%r22 = trunc i192 %r19 to i64
store i64 %r22, i64* %r21
%r23 = lshr i192 %r11, 191
%r24 = trunc i192 %r23 to i64
%r26 = and i64 %r24, 1
ret i64 %r26
}
define i64 @mclb_add4(i64* noalias  %r2, i64* noalias  %r3, i64* noalias  %r4)
{
%r6 = bitcast i64* %r3 to i256*
%r7 = load i256, i256* %r6
%r8 = zext i256 %r7 to i320
%r10 = bitcast i64* %r4 to i256*
%r11 = load i256, i256* %r10
%r12 = zext i256 %r11 to i320
%r13 = add i320 %r8, %r12
%r14 = trunc i320 %r13 to i256
%r16 = getelementptr i64, i64* %r2, i32 0
%r17 = trunc i256 %r14 to i64
store i64 %r17, i64* %r16
%r18 = lshr i256 %r14, 64
%r20 = getelementptr i64, i64* %r2, i32 1
%r21 = trunc i256 %r18 to i64
store i64 %r21, i64* %r20
%r22 = lshr i256 %r18, 64
%r24 = getelementptr i64, i64* %r2, i32 2
%r25 = trunc i256 %r22 to i64
store i64 %r25, i64* %r24
%r26 = lshr i256 %r22, 64
%r28 = getelementptr i64, i64* %r2, i32 3
%r29 = trunc i256 %r26 to i64
store i64 %r29, i64* %r28
%r30 = lshr i320 %r13, 256
%r31 = trunc i320 %r30 to i64
ret i64 %r31
}
define i64 @mclb_sub4(i64* noalias  %r2, i64* noalias  %r3, i64* noalias  %r4)
{
%r6 = bitcast i64* %r3 to i256*
%r7 = load i256, i256* %r6
%r8 = zext i256 %r7 to i320
%r10 = bitcast i64* %r4 to i256*
%r11 = load i256, i256* %r10
%r12 = zext i256 %r11 to i320
%r13 = sub i320 %r8, %r12
%r14 = trunc i320 %r13 to i256
%r16 = getelementptr i64, i64* %r2, i32 0
%r17 = trunc i256 %r14 to i64
store i64 %r17, i64* %r16
%r18 = lshr i256 %r14, 64
%r20 = getelementptr i64, i64* %r2, i32 1
%r21 = trunc i256 %r18 to i64
store i64 %r21, i64* %r20
%r22 = lshr i256 %r18, 64
%r24 = getelementptr i64, i64* %r2, i32 2
%r25 = trunc i256 %r22 to i64
store i64 %r25, i64* %r24
%r26 = lshr i256 %r22, 64
%r28 = getelementptr i64, i64* %r2, i32 3
%r29 = trunc i256 %r26 to i64
store i64 %r29, i64* %r28
%r30 = lshr i320 %r13, 256
%r31 = trunc i320 %r30 to i64
%r33 = and i64 %r31, 1
ret i64 %r33
}
define void @mclb_addNF4(i64* noalias  %r1, i64* noalias  %r2, i64* noalias  %r3)
{
%r5 = bitcast i64* %r2 to i256*
%r6 = load i256, i256* %r5
%r8 = bitcast i64* %r3 to i256*
%r9 = load i256, i256* %r8
%r10 = add i256 %r6, %r9
%r12 = getelementptr i64, i64* %r1, i32 0
%r13 = trunc i256 %r10 to i64
store i64 %r13, i64* %r12
%r14 = lshr i256 %r10, 64
%r16 = getelementptr i64, i64* %r1, i32 1
%r17 = trunc i256 %r14 to i64
store i64 %r17, i64* %r16
%r18 = lshr i256 %r14, 64
%r20 = getelementptr i64, i64* %r1, i32 2
%r21 = trunc i256 %r18 to i64
store i64 %r21, i64* %r20
%r22 = lshr i256 %r18, 64
%r24 = getelementptr i64, i64* %r1, i32 3
%r25 = trunc i256 %r22 to i64
store i64 %r25, i64* %r24
ret void
}
define i64 @mclb_subNF4(i64* noalias  %r2, i64* noalias  %r3, i64* noalias  %r4)
{
%r6 = bitcast i64* %r3 to i256*
%r7 = load i256, i256* %r6
%r9 = bitcast i64* %r4 to i256*
%r10 = load i256, i256* %r9
%r11 = sub i256 %r7, %r10
%r13 = getelementptr i64, i64* %r2, i32 0
%r14 = trunc i256 %r11 to i64
store i64 %r14, i64* %r13
%r15 = lshr i256 %r11, 64
%r17 = getelementptr i64, i64* %r2, i32 1
%r18 = trunc i256 %r15 to i64
store i64 %r18, i64* %r17
%r19 = lshr i256 %r15, 64
%r21 = getelementptr i64, i64* %r2, i32 2
%r22 = trunc i256 %r19 to i64
store i64 %r22, i64* %r21
%r23 = lshr i256 %r19, 64
%r25 = getelementptr i64, i64* %r2, i32 3
%r26 = trunc i256 %r23 to i64
store i64 %r26, i64* %r25
%r27 = lshr i256 %r11, 255
%r28 = trunc i256 %r27 to i64
%r30 = and i64 %r28, 1
ret i64 %r30
}
define i64 @mclb_add5(i64* noalias  %r2, i64* noalias  %r3, i64* noalias  %r4)
{
%r6 = bitcast i64* %r3 to i320*
%r7 = load i320, i320* %r6
%r8 = zext i320 %r7 to i384
%r10 = bitcast i64* %r4 to i320*
%r11 = load i320, i320* %r10
%r12 = zext i320 %r11 to i384
%r13 = add i384 %r8, %r12
%r14 = trunc i384 %r13 to i320
%r16 = getelementptr i64, i64* %r2, i32 0
%r17 = trunc i320 %r14 to i64
store i64 %r17, i64* %r16
%r18 = lshr i320 %r14, 64
%r20 = getelementptr i64, i64* %r2, i32 1
%r21 = trunc i320 %r18 to i64
store i64 %r21, i64* %r20
%r22 = lshr i320 %r18, 64
%r24 = getelementptr i64, i64* %r2, i32 2
%r25 = trunc i320 %r22 to i64
store i64 %r25, i64* %r24
%r26 = lshr i320 %r22, 64
%r28 = getelementptr i64, i64* %r2, i32 3
%r29 = trunc i320 %r26 to i64
store i64 %r29, i64* %r28
%r30 = lshr i320 %r26, 64
%r32 = getelementptr i64, i64* %r2, i32 4
%r33 = trunc i320 %r30 to i64
store i64 %r33, i64* %r32
%r34 = lshr i384 %r13, 320
%r35 = trunc i384 %r34 to i64
ret i64 %r35
}
define i64 @mclb_sub5(i64* noalias  %r2, i64* noalias  %r3, i64* noalias  %r4)
{
%r6 = bitcast i64* %r3 to i320*
%r7 = load i320, i320* %r6
%r8 = zext i320 %r7 to i384
%r10 = bitcast i64* %r4 to i320*
%r11 = load i320, i320* %r10
%r12 = zext i320 %r11 to i384
%r13 = sub i384 %r8, %r12
%r14 = trunc i384 %r13 to i320
%r16 = getelementptr i64, i64* %r2, i32 0
%r17 = trunc i320 %r14 to i64
store i64 %r17, i64* %r16
%r18 = lshr i320 %r14, 64
%r20 = getelementptr i64, i64* %r2, i32 1
%r21 = trunc i320 %r18 to i64
store i64 %r21, i64* %r20
%r22 = lshr i320 %r18, 64
%r24 = getelementptr i64, i64* %r2, i32 2
%r25 = trunc i320 %r22 to i64
store i64 %r25, i64* %r24
%r26 = lshr i320 %r22, 64
%r28 = getelementptr i64, i64* %r2, i32 3
%r29 = trunc i320 %r26 to i64
store i64 %r29, i64* %r28
%r30 = lshr i320 %r26, 64
%r32 = getelementptr i64, i64* %r2, i32 4
%r33 = trunc i320 %r30 to i64
store i64 %r33, i64* %r32
%r34 = lshr i384 %r13, 320
%r35 = trunc i384 %r34 to i64
%r37 = and i64 %r35, 1
ret i64 %r37
}
define void @mclb_addNF5(i64* noalias  %r1, i64* noalias  %r2, i64* noalias  %r3)
{
%r5 = bitcast i64* %r2 to i320*
%r6 = load i320, i320* %r5
%r8 = bitcast i64* %r3 to i320*
%r9 = load i320, i320* %r8
%r10 = add i320 %r6, %r9
%r12 = getelementptr i64, i64* %r1, i32 0
%r13 = trunc i320 %r10 to i64
store i64 %r13, i64* %r12
%r14 = lshr i320 %r10, 64
%r16 = getelementptr i64, i64* %r1, i32 1
%r17 = trunc i320 %r14 to i64
store i64 %r17, i64* %r16
%r18 = lshr i320 %r14, 64
%r20 = getelementptr i64, i64* %r1, i32 2
%r21 = trunc i320 %r18 to i64
store i64 %r21, i64* %r20
%r22 = lshr i320 %r18, 64
%r24 = getelementptr i64, i64* %r1, i32 3
%r25 = trunc i320 %r22 to i64
store i64 %r25, i64* %r24
%r26 = lshr i320 %r22, 64
%r28 = getelementptr i64, i64* %r1, i32 4
%r29 = trunc i320 %r26 to i64
store i64 %r29, i64* %r28
ret void
}
define i64 @mclb_subNF5(i64* noalias  %r2, i64* noalias  %r3, i64* noalias  %r4)
{
%r6 = bitcast i64* %r3 to i320*
%r7 = load i320, i320* %r6
%r9 = bitcast i64* %r4 to i320*
%r10 = load i320, i320* %r9
%r11 = sub i320 %r7, %r10
%r13 = getelementptr i64, i64* %r2, i32 0
%r14 = trunc i320 %r11 to i64
store i64 %r14, i64* %r13
%r15 = lshr i320 %r11, 64
%r17 = getelementptr i64, i64* %r2, i32 1
%r18 = trunc i320 %r15 to i64
store i64 %r18, i64* %r17
%r19 = lshr i320 %r15, 64
%r21 = getelementptr i64, i64* %r2, i32 2
%r22 = trunc i320 %r19 to i64
store i64 %r22, i64* %r21
%r23 = lshr i320 %r19, 64
%r25 = getelementptr i64, i64* %r2, i32 3
%r26 = trunc i320 %r23 to i64
store i64 %r26, i64* %r25
%r27 = lshr i320 %r23, 64
%r29 = getelementptr i64, i64* %r2, i32 4
%r30 = trunc i320 %r27 to i64
store i64 %r30, i64* %r29
%r31 = lshr i320 %r11, 319
%r32 = trunc i320 %r31 to i64
%r34 = and i64 %r32, 1
ret i64 %r34
}
define i64 @mclb_add6(i64* noalias  %r2, i64* noalias  %r3, i64* noalias  %r4)
{
%r6 = bitcast i64* %r3 to i384*
%r7 = load i384, i384* %r6
%r8 = zext i384 %r7 to i448
%r10 = bitcast i64* %r4 to i384*
%r11 = load i384, i384* %r10
%r12 = zext i384 %r11 to i448
%r13 = add i448 %r8, %r12
%r14 = trunc i448 %r13 to i384
%r16 = getelementptr i64, i64* %r2, i32 0
%r17 = trunc i384 %r14 to i64
store i64 %r17, i64* %r16
%r18 = lshr i384 %r14, 64
%r20 = getelementptr i64, i64* %r2, i32 1
%r21 = trunc i384 %r18 to i64
store i64 %r21, i64* %r20
%r22 = lshr i384 %r18, 64
%r24 = getelementptr i64, i64* %r2, i32 2
%r25 = trunc i384 %r22 to i64
store i64 %r25, i64* %r24
%r26 = lshr i384 %r22, 64
%r28 = getelementptr i64, i64* %r2, i32 3
%r29 = trunc i384 %r26 to i64
store i64 %r29, i64* %r28
%r30 = lshr i384 %r26, 64
%r32 = getelementptr i64, i64* %r2, i32 4
%r33 = trunc i384 %r30 to i64
store i64 %r33, i64* %r32
%r34 = lshr i384 %r30, 64
%r36 = getelementptr i64, i64* %r2, i32 5
%r37 = trunc i384 %r34 to i64
store i64 %r37, i64* %r36
%r38 = lshr i448 %r13, 384
%r39 = trunc i448 %r38 to i64
ret i64 %r39
}
define i64 @mclb_sub6(i64* noalias  %r2, i64* noalias  %r3, i64* noalias  %r4)
{
%r6 = bitcast i64* %r3 to i384*
%r7 = load i384, i384* %r6
%r8 = zext i384 %r7 to i448
%r10 = bitcast i64* %r4 to i384*
%r11 = load i384, i384* %r10
%r12 = zext i384 %r11 to i448
%r13 = sub i448 %r8, %r12
%r14 = trunc i448 %r13 to i384
%r16 = getelementptr i64, i64* %r2, i32 0
%r17 = trunc i384 %r14 to i64
store i64 %r17, i64* %r16
%r18 = lshr i384 %r14, 64
%r20 = getelementptr i64, i64* %r2, i32 1
%r21 = trunc i384 %r18 to i64
store i64 %r21, i64* %r20
%r22 = lshr i384 %r18, 64
%r24 = getelementptr i64, i64* %r2, i32 2
%r25 = trunc i384 %r22 to i64
store i64 %r25, i64* %r24
%r26 = lshr i384 %r22, 64
%r28 = getelementptr i64, i64* %r2, i32 3
%r29 = trunc i384 %r26 to i64
store i64 %r29, i64* %r28
%r30 = lshr i384 %r26, 64
%r32 = getelementptr i64, i64* %r2, i32 4
%r33 = trunc i384 %r30 to i64
store i64 %r33, i64* %r32
%r34 = lshr i384 %r30, 64
%r36 = getelementptr i64, i64* %r2, i32 5
%r37 = trunc i384 %r34 to i64
store i64 %r37, i64* %r36
%r38 = lshr i448 %r13, 384
%r39 = trunc i448 %r38 to i64
%r41 = and i64 %r39, 1
ret i64 %r41
}
define void @mclb_addNF6(i64* noalias  %r1, i64* noalias  %r2, i64* noalias  %r3)
{
%r5 = bitcast i64* %r2 to i384*
%r6 = load i384, i384* %r5
%r8 = bitcast i64* %r3 to i384*
%r9 = load i384, i384* %r8
%r10 = add i384 %r6, %r9
%r12 = getelementptr i64, i64* %r1, i32 0
%r13 = trunc i384 %r10 to i64
store i64 %r13, i64* %r12
%r14 = lshr i384 %r10, 64
%r16 = getelementptr i64, i64* %r1, i32 1
%r17 = trunc i384 %r14 to i64
store i64 %r17, i64* %r16
%r18 = lshr i384 %r14, 64
%r20 = getelementptr i64, i64* %r1, i32 2
%r21 = trunc i384 %r18 to i64
store i64 %r21, i64* %r20
%r22 = lshr i384 %r18, 64
%r24 = getelementptr i64, i64* %r1, i32 3
%r25 = trunc i384 %r22 to i64
store i64 %r25, i64* %r24
%r26 = lshr i384 %r22, 64
%r28 = getelementptr i64, i64* %r1, i32 4
%r29 = trunc i384 %r26 to i64
store i64 %r29, i64* %r28
%r30 = lshr i384 %r26, 64
%r32 = getelementptr i64, i64* %r1, i32 5
%r33 = trunc i384 %r30 to i64
store i64 %r33, i64* %r32
ret void
}
define i64 @mclb_subNF6(i64* noalias  %r2, i64* noalias  %r3, i64* noalias  %r4)
{
%r6 = bitcast i64* %r3 to i384*
%r7 = load i384, i384* %r6
%r9 = bitcast i64* %r4 to i384*
%r10 = load i384, i384* %r9
%r11 = sub i384 %r7, %r10
%r13 = getelementptr i64, i64* %r2, i32 0
%r14 = trunc i384 %r11 to i64
store i64 %r14, i64* %r13
%r15 = lshr i384 %r11, 64
%r17 = getelementptr i64, i64* %r2, i32 1
%r18 = trunc i384 %r15 to i64
store i64 %r18, i64* %r17
%r19 = lshr i384 %r15, 64
%r21 = getelementptr i64, i64* %r2, i32 2
%r22 = trunc i384 %r19 to i64
store i64 %r22, i64* %r21
%r23 = lshr i384 %r19, 64
%r25 = getelementptr i64, i64* %r2, i32 3
%r26 = trunc i384 %r23 to i64
store i64 %r26, i64* %r25
%r27 = lshr i384 %r23, 64
%r29 = getelementptr i64, i64* %r2, i32 4
%r30 = trunc i384 %r27 to i64
store i64 %r30, i64* %r29
%r31 = lshr i384 %r27, 64
%r33 = getelementptr i64, i64* %r2, i32 5
%r34 = trunc i384 %r31 to i64
store i64 %r34, i64* %r33
%r35 = lshr i384 %r11, 383
%r36 = trunc i384 %r35 to i64
%r38 = and i64 %r36, 1
ret i64 %r38
}
define i64 @mclb_add7(i64* noalias  %r2, i64* noalias  %r3, i64* noalias  %r4)
{
%r6 = bitcast i64* %r3 to i448*
%r7 = load i448, i448* %r6
%r8 = zext i448 %r7 to i512
%r10 = bitcast i64* %r4 to i448*
%r11 = load i448, i448* %r10
%r12 = zext i448 %r11 to i512
%r13 = add i512 %r8, %r12
%r14 = trunc i512 %r13 to i448
%r16 = getelementptr i64, i64* %r2, i32 0
%r17 = trunc i448 %r14 to i64
store i64 %r17, i64* %r16
%r18 = lshr i448 %r14, 64
%r20 = getelementptr i64, i64* %r2, i32 1
%r21 = trunc i448 %r18 to i64
store i64 %r21, i64* %r20
%r22 = lshr i448 %r18, 64
%r24 = getelementptr i64, i64* %r2, i32 2
%r25 = trunc i448 %r22 to i64
store i64 %r25, i64* %r24
%r26 = lshr i448 %r22, 64
%r28 = getelementptr i64, i64* %r2, i32 3
%r29 = trunc i448 %r26 to i64
store i64 %r29, i64* %r28
%r30 = lshr i448 %r26, 64
%r32 = getelementptr i64, i64* %r2, i32 4
%r33 = trunc i448 %r30 to i64
store i64 %r33, i64* %r32
%r34 = lshr i448 %r30, 64
%r36 = getelementptr i64, i64* %r2, i32 5
%r37 = trunc i448 %r34 to i64
store i64 %r37, i64* %r36
%r38 = lshr i448 %r34, 64
%r40 = getelementptr i64, i64* %r2, i32 6
%r41 = trunc i448 %r38 to i64
store i64 %r41, i64* %r40
%r42 = lshr i512 %r13, 448
%r43 = trunc i512 %r42 to i64
ret i64 %r43
}
define i64 @mclb_sub7(i64* noalias  %r2, i64* noalias  %r3, i64* noalias  %r4)
{
%r6 = bitcast i64* %r3 to i448*
%r7 = load i448, i448* %r6
%r8 = zext i448 %r7 to i512
%r10 = bitcast i64* %r4 to i448*
%r11 = load i448, i448* %r10
%r12 = zext i448 %r11 to i512
%r13 = sub i512 %r8, %r12
%r14 = trunc i512 %r13 to i448
%r16 = getelementptr i64, i64* %r2, i32 0
%r17 = trunc i448 %r14 to i64
store i64 %r17, i64* %r16
%r18 = lshr i448 %r14, 64
%r20 = getelementptr i64, i64* %r2, i32 1
%r21 = trunc i448 %r18 to i64
store i64 %r21, i64* %r20
%r22 = lshr i448 %r18, 64
%r24 = getelementptr i64, i64* %r2, i32 2
%r25 = trunc i448 %r22 to i64
store i64 %r25, i64* %r24
%r26 = lshr i448 %r22, 64
%r28 = getelementptr i64, i64* %r2, i32 3
%r29 = trunc i448 %r26 to i64
store i64 %r29, i64* %r28
%r30 = lshr i448 %r26, 64
%r32 = getelementptr i64, i64* %r2, i32 4
%r33 = trunc i448 %r30 to i64
store i64 %r33, i64* %r32
%r34 = lshr i448 %r30, 64
%r36 = getelementptr i64, i64* %r2, i32 5
%r37 = trunc i448 %r34 to i64
store i64 %r37, i64* %r36
%r38 = lshr i448 %r34, 64
%r40 = getelementptr i64, i64* %r2, i32 6
%r41 = trunc i448 %r38 to i64
store i64 %r41, i64* %r40
%r42 = lshr i512 %r13, 448
%r43 = trunc i512 %r42 to i64
%r45 = and i64 %r43, 1
ret i64 %r45
}
define void @mclb_addNF7(i64* noalias  %r1, i64* noalias  %r2, i64* noalias  %r3)
{
%r5 = bitcast i64* %r2 to i448*
%r6 = load i448, i448* %r5
%r8 = bitcast i64* %r3 to i448*
%r9 = load i448, i448* %r8
%r10 = add i448 %r6, %r9
%r12 = getelementptr i64, i64* %r1, i32 0
%r13 = trunc i448 %r10 to i64
store i64 %r13, i64* %r12
%r14 = lshr i448 %r10, 64
%r16 = getelementptr i64, i64* %r1, i32 1
%r17 = trunc i448 %r14 to i64
store i64 %r17, i64* %r16
%r18 = lshr i448 %r14, 64
%r20 = getelementptr i64, i64* %r1, i32 2
%r21 = trunc i448 %r18 to i64
store i64 %r21, i64* %r20
%r22 = lshr i448 %r18, 64
%r24 = getelementptr i64, i64* %r1, i32 3
%r25 = trunc i448 %r22 to i64
store i64 %r25, i64* %r24
%r26 = lshr i448 %r22, 64
%r28 = getelementptr i64, i64* %r1, i32 4
%r29 = trunc i448 %r26 to i64
store i64 %r29, i64* %r28
%r30 = lshr i448 %r26, 64
%r32 = getelementptr i64, i64* %r1, i32 5
%r33 = trunc i448 %r30 to i64
store i64 %r33, i64* %r32
%r34 = lshr i448 %r30, 64
%r36 = getelementptr i64, i64* %r1, i32 6
%r37 = trunc i448 %r34 to i64
store i64 %r37, i64* %r36
ret void
}
define i64 @mclb_subNF7(i64* noalias  %r2, i64* noalias  %r3, i64* noalias  %r4)
{
%r6 = bitcast i64* %r3 to i448*
%r7 = load i448, i448* %r6
%r9 = bitcast i64* %r4 to i448*
%r10 = load i448, i448* %r9
%r11 = sub i448 %r7, %r10
%r13 = getelementptr i64, i64* %r2, i32 0
%r14 = trunc i448 %r11 to i64
store i64 %r14, i64* %r13
%r15 = lshr i448 %r11, 64
%r17 = getelementptr i64, i64* %r2, i32 1
%r18 = trunc i448 %r15 to i64
store i64 %r18, i64* %r17
%r19 = lshr i448 %r15, 64
%r21 = getelementptr i64, i64* %r2, i32 2
%r22 = trunc i448 %r19 to i64
store i64 %r22, i64* %r21
%r23 = lshr i448 %r19, 64
%r25 = getelementptr i64, i64* %r2, i32 3
%r26 = trunc i448 %r23 to i64
store i64 %r26, i64* %r25
%r27 = lshr i448 %r23, 64
%r29 = getelementptr i64, i64* %r2, i32 4
%r30 = trunc i448 %r27 to i64
store i64 %r30, i64* %r29
%r31 = lshr i448 %r27, 64
%r33 = getelementptr i64, i64* %r2, i32 5
%r34 = trunc i448 %r31 to i64
store i64 %r34, i64* %r33
%r35 = lshr i448 %r31, 64
%r37 = getelementptr i64, i64* %r2, i32 6
%r38 = trunc i448 %r35 to i64
store i64 %r38, i64* %r37
%r39 = lshr i448 %r11, 447
%r40 = trunc i448 %r39 to i64
%r42 = and i64 %r40, 1
ret i64 %r42
}
define i64 @mclb_add8(i64* noalias  %r2, i64* noalias  %r3, i64* noalias  %r4)
{
%r6 = bitcast i64* %r3 to i512*
%r7 = load i512, i512* %r6
%r8 = zext i512 %r7 to i576
%r10 = bitcast i64* %r4 to i512*
%r11 = load i512, i512* %r10
%r12 = zext i512 %r11 to i576
%r13 = add i576 %r8, %r12
%r14 = trunc i576 %r13 to i512
%r16 = getelementptr i64, i64* %r2, i32 0
%r17 = trunc i512 %r14 to i64
store i64 %r17, i64* %r16
%r18 = lshr i512 %r14, 64
%r20 = getelementptr i64, i64* %r2, i32 1
%r21 = trunc i512 %r18 to i64
store i64 %r21, i64* %r20
%r22 = lshr i512 %r18, 64
%r24 = getelementptr i64, i64* %r2, i32 2
%r25 = trunc i512 %r22 to i64
store i64 %r25, i64* %r24
%r26 = lshr i512 %r22, 64
%r28 = getelementptr i64, i64* %r2, i32 3
%r29 = trunc i512 %r26 to i64
store i64 %r29, i64* %r28
%r30 = lshr i512 %r26, 64
%r32 = getelementptr i64, i64* %r2, i32 4
%r33 = trunc i512 %r30 to i64
store i64 %r33, i64* %r32
%r34 = lshr i512 %r30, 64
%r36 = getelementptr i64, i64* %r2, i32 5
%r37 = trunc i512 %r34 to i64
store i64 %r37, i64* %r36
%r38 = lshr i512 %r34, 64
%r40 = getelementptr i64, i64* %r2, i32 6
%r41 = trunc i512 %r38 to i64
store i64 %r41, i64* %r40
%r42 = lshr i512 %r38, 64
%r44 = getelementptr i64, i64* %r2, i32 7
%r45 = trunc i512 %r42 to i64
store i64 %r45, i64* %r44
%r46 = lshr i576 %r13, 512
%r47 = trunc i576 %r46 to i64
ret i64 %r47
}
define i64 @mclb_sub8(i64* noalias  %r2, i64* noalias  %r3, i64* noalias  %r4)
{
%r6 = bitcast i64* %r3 to i512*
%r7 = load i512, i512* %r6
%r8 = zext i512 %r7 to i576
%r10 = bitcast i64* %r4 to i512*
%r11 = load i512, i512* %r10
%r12 = zext i512 %r11 to i576
%r13 = sub i576 %r8, %r12
%r14 = trunc i576 %r13 to i512
%r16 = getelementptr i64, i64* %r2, i32 0
%r17 = trunc i512 %r14 to i64
store i64 %r17, i64* %r16
%r18 = lshr i512 %r14, 64
%r20 = getelementptr i64, i64* %r2, i32 1
%r21 = trunc i512 %r18 to i64
store i64 %r21, i64* %r20
%r22 = lshr i512 %r18, 64
%r24 = getelementptr i64, i64* %r2, i32 2
%r25 = trunc i512 %r22 to i64
store i64 %r25, i64* %r24
%r26 = lshr i512 %r22, 64
%r28 = getelementptr i64, i64* %r2, i32 3
%r29 = trunc i512 %r26 to i64
store i64 %r29, i64* %r28
%r30 = lshr i512 %r26, 64
%r32 = getelementptr i64, i64* %r2, i32 4
%r33 = trunc i512 %r30 to i64
store i64 %r33, i64* %r32
%r34 = lshr i512 %r30, 64
%r36 = getelementptr i64, i64* %r2, i32 5
%r37 = trunc i512 %r34 to i64
store i64 %r37, i64* %r36
%r38 = lshr i512 %r34, 64
%r40 = getelementptr i64, i64* %r2, i32 6
%r41 = trunc i512 %r38 to i64
store i64 %r41, i64* %r40
%r42 = lshr i512 %r38, 64
%r44 = getelementptr i64, i64* %r2, i32 7
%r45 = trunc i512 %r42 to i64
store i64 %r45, i64* %r44
%r46 = lshr i576 %r13, 512
%r47 = trunc i576 %r46 to i64
%r49 = and i64 %r47, 1
ret i64 %r49
}
define void @mclb_addNF8(i64* noalias  %r1, i64* noalias  %r2, i64* noalias  %r3)
{
%r5 = bitcast i64* %r2 to i512*
%r6 = load i512, i512* %r5
%r8 = bitcast i64* %r3 to i512*
%r9 = load i512, i512* %r8
%r10 = add i512 %r6, %r9
%r12 = getelementptr i64, i64* %r1, i32 0
%r13 = trunc i512 %r10 to i64
store i64 %r13, i64* %r12
%r14 = lshr i512 %r10, 64
%r16 = getelementptr i64, i64* %r1, i32 1
%r17 = trunc i512 %r14 to i64
store i64 %r17, i64* %r16
%r18 = lshr i512 %r14, 64
%r20 = getelementptr i64, i64* %r1, i32 2
%r21 = trunc i512 %r18 to i64
store i64 %r21, i64* %r20
%r22 = lshr i512 %r18, 64
%r24 = getelementptr i64, i64* %r1, i32 3
%r25 = trunc i512 %r22 to i64
store i64 %r25, i64* %r24
%r26 = lshr i512 %r22, 64
%r28 = getelementptr i64, i64* %r1, i32 4
%r29 = trunc i512 %r26 to i64
store i64 %r29, i64* %r28
%r30 = lshr i512 %r26, 64
%r32 = getelementptr i64, i64* %r1, i32 5
%r33 = trunc i512 %r30 to i64
store i64 %r33, i64* %r32
%r34 = lshr i512 %r30, 64
%r36 = getelementptr i64, i64* %r1, i32 6
%r37 = trunc i512 %r34 to i64
store i64 %r37, i64* %r36
%r38 = lshr i512 %r34, 64
%r40 = getelementptr i64, i64* %r1, i32 7
%r41 = trunc i512 %r38 to i64
store i64 %r41, i64* %r40
ret void
}
define i64 @mclb_subNF8(i64* noalias  %r2, i64* noalias  %r3, i64* noalias  %r4)
{
%r6 = bitcast i64* %r3 to i512*
%r7 = load i512, i512* %r6
%r9 = bitcast i64* %r4 to i512*
%r10 = load i512, i512* %r9
%r11 = sub i512 %r7, %r10
%r13 = getelementptr i64, i64* %r2, i32 0
%r14 = trunc i512 %r11 to i64
store i64 %r14, i64* %r13
%r15 = lshr i512 %r11, 64
%r17 = getelementptr i64, i64* %r2, i32 1
%r18 = trunc i512 %r15 to i64
store i64 %r18, i64* %r17
%r19 = lshr i512 %r15, 64
%r21 = getelementptr i64, i64* %r2, i32 2
%r22 = trunc i512 %r19 to i64
store i64 %r22, i64* %r21
%r23 = lshr i512 %r19, 64
%r25 = getelementptr i64, i64* %r2, i32 3
%r26 = trunc i512 %r23 to i64
store i64 %r26, i64* %r25
%r27 = lshr i512 %r23, 64
%r29 = getelementptr i64, i64* %r2, i32 4
%r30 = trunc i512 %r27 to i64
store i64 %r30, i64* %r29
%r31 = lshr i512 %r27, 64
%r33 = getelementptr i64, i64* %r2, i32 5
%r34 = trunc i512 %r31 to i64
store i64 %r34, i64* %r33
%r35 = lshr i512 %r31, 64
%r37 = getelementptr i64, i64* %r2, i32 6
%r38 = trunc i512 %r35 to i64
store i64 %r38, i64* %r37
%r39 = lshr i512 %r35, 64
%r41 = getelementptr i64, i64* %r2, i32 7
%r42 = trunc i512 %r39 to i64
store i64 %r42, i64* %r41
%r43 = lshr i512 %r11, 511
%r44 = trunc i512 %r43 to i64
%r46 = and i64 %r44, 1
ret i64 %r46
}
define i64 @mclb_add9(i64* noalias  %r2, i64* noalias  %r3, i64* noalias  %r4)
{
%r6 = bitcast i64* %r3 to i576*
%r7 = load i576, i576* %r6
%r8 = zext i576 %r7 to i640
%r10 = bitcast i64* %r4 to i576*
%r11 = load i576, i576* %r10
%r12 = zext i576 %r11 to i640
%r13 = add i640 %r8, %r12
%r14 = trunc i640 %r13 to i576
%r16 = getelementptr i64, i64* %r2, i32 0
%r17 = trunc i576 %r14 to i64
store i64 %r17, i64* %r16
%r18 = lshr i576 %r14, 64
%r20 = getelementptr i64, i64* %r2, i32 1
%r21 = trunc i576 %r18 to i64
store i64 %r21, i64* %r20
%r22 = lshr i576 %r18, 64
%r24 = getelementptr i64, i64* %r2, i32 2
%r25 = trunc i576 %r22 to i64
store i64 %r25, i64* %r24
%r26 = lshr i576 %r22, 64
%r28 = getelementptr i64, i64* %r2, i32 3
%r29 = trunc i576 %r26 to i64
store i64 %r29, i64* %r28
%r30 = lshr i576 %r26, 64
%r32 = getelementptr i64, i64* %r2, i32 4
%r33 = trunc i576 %r30 to i64
store i64 %r33, i64* %r32
%r34 = lshr i576 %r30, 64
%r36 = getelementptr i64, i64* %r2, i32 5
%r37 = trunc i576 %r34 to i64
store i64 %r37, i64* %r36
%r38 = lshr i576 %r34, 64
%r40 = getelementptr i64, i64* %r2, i32 6
%r41 = trunc i576 %r38 to i64
store i64 %r41, i64* %r40
%r42 = lshr i576 %r38, 64
%r44 = getelementptr i64, i64* %r2, i32 7
%r45 = trunc i576 %r42 to i64
store i64 %r45, i64* %r44
%r46 = lshr i576 %r42, 64
%r48 = getelementptr i64, i64* %r2, i32 8
%r49 = trunc i576 %r46 to i64
store i64 %r49, i64* %r48
%r50 = lshr i640 %r13, 576
%r51 = trunc i640 %r50 to i64
ret i64 %r51
}
define i64 @mclb_sub9(i64* noalias  %r2, i64* noalias  %r3, i64* noalias  %r4)
{
%r6 = bitcast i64* %r3 to i576*
%r7 = load i576, i576* %r6
%r8 = zext i576 %r7 to i640
%r10 = bitcast i64* %r4 to i576*
%r11 = load i576, i576* %r10
%r12 = zext i576 %r11 to i640
%r13 = sub i640 %r8, %r12
%r14 = trunc i640 %r13 to i576
%r16 = getelementptr i64, i64* %r2, i32 0
%r17 = trunc i576 %r14 to i64
store i64 %r17, i64* %r16
%r18 = lshr i576 %r14, 64
%r20 = getelementptr i64, i64* %r2, i32 1
%r21 = trunc i576 %r18 to i64
store i64 %r21, i64* %r20
%r22 = lshr i576 %r18, 64
%r24 = getelementptr i64, i64* %r2, i32 2
%r25 = trunc i576 %r22 to i64
store i64 %r25, i64* %r24
%r26 = lshr i576 %r22, 64
%r28 = getelementptr i64, i64* %r2, i32 3
%r29 = trunc i576 %r26 to i64
store i64 %r29, i64* %r28
%r30 = lshr i576 %r26, 64
%r32 = getelementptr i64, i64* %r2, i32 4
%r33 = trunc i576 %r30 to i64
store i64 %r33, i64* %r32
%r34 = lshr i576 %r30, 64
%r36 = getelementptr i64, i64* %r2, i32 5
%r37 = trunc i576 %r34 to i64
store i64 %r37, i64* %r36
%r38 = lshr i576 %r34, 64
%r40 = getelementptr i64, i64* %r2, i32 6
%r41 = trunc i576 %r38 to i64
store i64 %r41, i64* %r40
%r42 = lshr i576 %r38, 64
%r44 = getelementptr i64, i64* %r2, i32 7
%r45 = trunc i576 %r42 to i64
store i64 %r45, i64* %r44
%r46 = lshr i576 %r42, 64
%r48 = getelementptr i64, i64* %r2, i32 8
%r49 = trunc i576 %r46 to i64
store i64 %r49, i64* %r48
%r50 = lshr i640 %r13, 576
%r51 = trunc i640 %r50 to i64
%r53 = and i64 %r51, 1
ret i64 %r53
}
define void @mclb_addNF9(i64* noalias  %r1, i64* noalias  %r2, i64* noalias  %r3)
{
%r5 = bitcast i64* %r2 to i576*
%r6 = load i576, i576* %r5
%r8 = bitcast i64* %r3 to i576*
%r9 = load i576, i576* %r8
%r10 = add i576 %r6, %r9
%r12 = getelementptr i64, i64* %r1, i32 0
%r13 = trunc i576 %r10 to i64
store i64 %r13, i64* %r12
%r14 = lshr i576 %r10, 64
%r16 = getelementptr i64, i64* %r1, i32 1
%r17 = trunc i576 %r14 to i64
store i64 %r17, i64* %r16
%r18 = lshr i576 %r14, 64
%r20 = getelementptr i64, i64* %r1, i32 2
%r21 = trunc i576 %r18 to i64
store i64 %r21, i64* %r20
%r22 = lshr i576 %r18, 64
%r24 = getelementptr i64, i64* %r1, i32 3
%r25 = trunc i576 %r22 to i64
store i64 %r25, i64* %r24
%r26 = lshr i576 %r22, 64
%r28 = getelementptr i64, i64* %r1, i32 4
%r29 = trunc i576 %r26 to i64
store i64 %r29, i64* %r28
%r30 = lshr i576 %r26, 64
%r32 = getelementptr i64, i64* %r1, i32 5
%r33 = trunc i576 %r30 to i64
store i64 %r33, i64* %r32
%r34 = lshr i576 %r30, 64
%r36 = getelementptr i64, i64* %r1, i32 6
%r37 = trunc i576 %r34 to i64
store i64 %r37, i64* %r36
%r38 = lshr i576 %r34, 64
%r40 = getelementptr i64, i64* %r1, i32 7
%r41 = trunc i576 %r38 to i64
store i64 %r41, i64* %r40
%r42 = lshr i576 %r38, 64
%r44 = getelementptr i64, i64* %r1, i32 8
%r45 = trunc i576 %r42 to i64
store i64 %r45, i64* %r44
ret void
}
define i64 @mclb_subNF9(i64* noalias  %r2, i64* noalias  %r3, i64* noalias  %r4)
{
%r6 = bitcast i64* %r3 to i576*
%r7 = load i576, i576* %r6
%r9 = bitcast i64* %r4 to i576*
%r10 = load i576, i576* %r9
%r11 = sub i576 %r7, %r10
%r13 = getelementptr i64, i64* %r2, i32 0
%r14 = trunc i576 %r11 to i64
store i64 %r14, i64* %r13
%r15 = lshr i576 %r11, 64
%r17 = getelementptr i64, i64* %r2, i32 1
%r18 = trunc i576 %r15 to i64
store i64 %r18, i64* %r17
%r19 = lshr i576 %r15, 64
%r21 = getelementptr i64, i64* %r2, i32 2
%r22 = trunc i576 %r19 to i64
store i64 %r22, i64* %r21
%r23 = lshr i576 %r19, 64
%r25 = getelementptr i64, i64* %r2, i32 3
%r26 = trunc i576 %r23 to i64
store i64 %r26, i64* %r25
%r27 = lshr i576 %r23, 64
%r29 = getelementptr i64, i64* %r2, i32 4
%r30 = trunc i576 %r27 to i64
store i64 %r30, i64* %r29
%r31 = lshr i576 %r27, 64
%r33 = getelementptr i64, i64* %r2, i32 5
%r34 = trunc i576 %r31 to i64
store i64 %r34, i64* %r33
%r35 = lshr i576 %r31, 64
%r37 = getelementptr i64, i64* %r2, i32 6
%r38 = trunc i576 %r35 to i64
store i64 %r38, i64* %r37
%r39 = lshr i576 %r35, 64
%r41 = getelementptr i64, i64* %r2, i32 7
%r42 = trunc i576 %r39 to i64
store i64 %r42, i64* %r41
%r43 = lshr i576 %r39, 64
%r45 = getelementptr i64, i64* %r2, i32 8
%r46 = trunc i576 %r43 to i64
store i64 %r46, i64* %r45
%r47 = lshr i576 %r11, 575
%r48 = trunc i576 %r47 to i64
%r50 = and i64 %r48, 1
ret i64 %r50
}
define i64 @mclb_add10(i64* noalias  %r2, i64* noalias  %r3, i64* noalias  %r4)
{
%r6 = bitcast i64* %r3 to i640*
%r7 = load i640, i640* %r6
%r8 = zext i640 %r7 to i704
%r10 = bitcast i64* %r4 to i640*
%r11 = load i640, i640* %r10
%r12 = zext i640 %r11 to i704
%r13 = add i704 %r8, %r12
%r14 = trunc i704 %r13 to i640
%r16 = getelementptr i64, i64* %r2, i32 0
%r17 = trunc i640 %r14 to i64
store i64 %r17, i64* %r16
%r18 = lshr i640 %r14, 64
%r20 = getelementptr i64, i64* %r2, i32 1
%r21 = trunc i640 %r18 to i64
store i64 %r21, i64* %r20
%r22 = lshr i640 %r18, 64
%r24 = getelementptr i64, i64* %r2, i32 2
%r25 = trunc i640 %r22 to i64
store i64 %r25, i64* %r24
%r26 = lshr i640 %r22, 64
%r28 = getelementptr i64, i64* %r2, i32 3
%r29 = trunc i640 %r26 to i64
store i64 %r29, i64* %r28
%r30 = lshr i640 %r26, 64
%r32 = getelementptr i64, i64* %r2, i32 4
%r33 = trunc i640 %r30 to i64
store i64 %r33, i64* %r32
%r34 = lshr i640 %r30, 64
%r36 = getelementptr i64, i64* %r2, i32 5
%r37 = trunc i640 %r34 to i64
store i64 %r37, i64* %r36
%r38 = lshr i640 %r34, 64
%r40 = getelementptr i64, i64* %r2, i32 6
%r41 = trunc i640 %r38 to i64
store i64 %r41, i64* %r40
%r42 = lshr i640 %r38, 64
%r44 = getelementptr i64, i64* %r2, i32 7
%r45 = trunc i640 %r42 to i64
store i64 %r45, i64* %r44
%r46 = lshr i640 %r42, 64
%r48 = getelementptr i64, i64* %r2, i32 8
%r49 = trunc i640 %r46 to i64
store i64 %r49, i64* %r48
%r50 = lshr i640 %r46, 64
%r52 = getelementptr i64, i64* %r2, i32 9
%r53 = trunc i640 %r50 to i64
store i64 %r53, i64* %r52
%r54 = lshr i704 %r13, 640
%r55 = trunc i704 %r54 to i64
ret i64 %r55
}
define i64 @mclb_sub10(i64* noalias  %r2, i64* noalias  %r3, i64* noalias  %r4)
{
%r6 = bitcast i64* %r3 to i640*
%r7 = load i640, i640* %r6
%r8 = zext i640 %r7 to i704
%r10 = bitcast i64* %r4 to i640*
%r11 = load i640, i640* %r10
%r12 = zext i640 %r11 to i704
%r13 = sub i704 %r8, %r12
%r14 = trunc i704 %r13 to i640
%r16 = getelementptr i64, i64* %r2, i32 0
%r17 = trunc i640 %r14 to i64
store i64 %r17, i64* %r16
%r18 = lshr i640 %r14, 64
%r20 = getelementptr i64, i64* %r2, i32 1
%r21 = trunc i640 %r18 to i64
store i64 %r21, i64* %r20
%r22 = lshr i640 %r18, 64
%r24 = getelementptr i64, i64* %r2, i32 2
%r25 = trunc i640 %r22 to i64
store i64 %r25, i64* %r24
%r26 = lshr i640 %r22, 64
%r28 = getelementptr i64, i64* %r2, i32 3
%r29 = trunc i640 %r26 to i64
store i64 %r29, i64* %r28
%r30 = lshr i640 %r26, 64
%r32 = getelementptr i64, i64* %r2, i32 4
%r33 = trunc i640 %r30 to i64
store i64 %r33, i64* %r32
%r34 = lshr i640 %r30, 64
%r36 = getelementptr i64, i64* %r2, i32 5
%r37 = trunc i640 %r34 to i64
store i64 %r37, i64* %r36
%r38 = lshr i640 %r34, 64
%r40 = getelementptr i64, i64* %r2, i32 6
%r41 = trunc i640 %r38 to i64
store i64 %r41, i64* %r40
%r42 = lshr i640 %r38, 64
%r44 = getelementptr i64, i64* %r2, i32 7
%r45 = trunc i640 %r42 to i64
store i64 %r45, i64* %r44
%r46 = lshr i640 %r42, 64
%r48 = getelementptr i64, i64* %r2, i32 8
%r49 = trunc i640 %r46 to i64
store i64 %r49, i64* %r48
%r50 = lshr i640 %r46, 64
%r52 = getelementptr i64, i64* %r2, i32 9
%r53 = trunc i640 %r50 to i64
store i64 %r53, i64* %r52
%r54 = lshr i704 %r13, 640
%r55 = trunc i704 %r54 to i64
%r57 = and i64 %r55, 1
ret i64 %r57
}
define void @mclb_addNF10(i64* noalias  %r1, i64* noalias  %r2, i64* noalias  %r3)
{
%r5 = bitcast i64* %r2 to i640*
%r6 = load i640, i640* %r5
%r8 = bitcast i64* %r3 to i640*
%r9 = load i640, i640* %r8
%r10 = add i640 %r6, %r9
%r12 = getelementptr i64, i64* %r1, i32 0
%r13 = trunc i640 %r10 to i64
store i64 %r13, i64* %r12
%r14 = lshr i640 %r10, 64
%r16 = getelementptr i64, i64* %r1, i32 1
%r17 = trunc i640 %r14 to i64
store i64 %r17, i64* %r16
%r18 = lshr i640 %r14, 64
%r20 = getelementptr i64, i64* %r1, i32 2
%r21 = trunc i640 %r18 to i64
store i64 %r21, i64* %r20
%r22 = lshr i640 %r18, 64
%r24 = getelementptr i64, i64* %r1, i32 3
%r25 = trunc i640 %r22 to i64
store i64 %r25, i64* %r24
%r26 = lshr i640 %r22, 64
%r28 = getelementptr i64, i64* %r1, i32 4
%r29 = trunc i640 %r26 to i64
store i64 %r29, i64* %r28
%r30 = lshr i640 %r26, 64
%r32 = getelementptr i64, i64* %r1, i32 5
%r33 = trunc i640 %r30 to i64
store i64 %r33, i64* %r32
%r34 = lshr i640 %r30, 64
%r36 = getelementptr i64, i64* %r1, i32 6
%r37 = trunc i640 %r34 to i64
store i64 %r37, i64* %r36
%r38 = lshr i640 %r34, 64
%r40 = getelementptr i64, i64* %r1, i32 7
%r41 = trunc i640 %r38 to i64
store i64 %r41, i64* %r40
%r42 = lshr i640 %r38, 64
%r44 = getelementptr i64, i64* %r1, i32 8
%r45 = trunc i640 %r42 to i64
store i64 %r45, i64* %r44
%r46 = lshr i640 %r42, 64
%r48 = getelementptr i64, i64* %r1, i32 9
%r49 = trunc i640 %r46 to i64
store i64 %r49, i64* %r48
ret void
}
define i64 @mclb_subNF10(i64* noalias  %r2, i64* noalias  %r3, i64* noalias  %r4)
{
%r6 = bitcast i64* %r3 to i640*
%r7 = load i640, i640* %r6
%r9 = bitcast i64* %r4 to i640*
%r10 = load i640, i640* %r9
%r11 = sub i640 %r7, %r10
%r13 = getelementptr i64, i64* %r2, i32 0
%r14 = trunc i640 %r11 to i64
store i64 %r14, i64* %r13
%r15 = lshr i640 %r11, 64
%r17 = getelementptr i64, i64* %r2, i32 1
%r18 = trunc i640 %r15 to i64
store i64 %r18, i64* %r17
%r19 = lshr i640 %r15, 64
%r21 = getelementptr i64, i64* %r2, i32 2
%r22 = trunc i640 %r19 to i64
store i64 %r22, i64* %r21
%r23 = lshr i640 %r19, 64
%r25 = getelementptr i64, i64* %r2, i32 3
%r26 = trunc i640 %r23 to i64
store i64 %r26, i64* %r25
%r27 = lshr i640 %r23, 64
%r29 = getelementptr i64, i64* %r2, i32 4
%r30 = trunc i640 %r27 to i64
store i64 %r30, i64* %r29
%r31 = lshr i640 %r27, 64
%r33 = getelementptr i64, i64* %r2, i32 5
%r34 = trunc i640 %r31 to i64
store i64 %r34, i64* %r33
%r35 = lshr i640 %r31, 64
%r37 = getelementptr i64, i64* %r2, i32 6
%r38 = trunc i640 %r35 to i64
store i64 %r38, i64* %r37
%r39 = lshr i640 %r35, 64
%r41 = getelementptr i64, i64* %r2, i32 7
%r42 = trunc i640 %r39 to i64
store i64 %r42, i64* %r41
%r43 = lshr i640 %r39, 64
%r45 = getelementptr i64, i64* %r2, i32 8
%r46 = trunc i640 %r43 to i64
store i64 %r46, i64* %r45
%r47 = lshr i640 %r43, 64
%r49 = getelementptr i64, i64* %r2, i32 9
%r50 = trunc i640 %r47 to i64
store i64 %r50, i64* %r49
%r51 = lshr i640 %r11, 639
%r52 = trunc i640 %r51 to i64
%r54 = and i64 %r52, 1
ret i64 %r54
}
define i64 @mclb_add11(i64* noalias  %r2, i64* noalias  %r3, i64* noalias  %r4)
{
%r6 = bitcast i64* %r3 to i704*
%r7 = load i704, i704* %r6
%r8 = zext i704 %r7 to i768
%r10 = bitcast i64* %r4 to i704*
%r11 = load i704, i704* %r10
%r12 = zext i704 %r11 to i768
%r13 = add i768 %r8, %r12
%r14 = trunc i768 %r13 to i704
%r16 = getelementptr i64, i64* %r2, i32 0
%r17 = trunc i704 %r14 to i64
store i64 %r17, i64* %r16
%r18 = lshr i704 %r14, 64
%r20 = getelementptr i64, i64* %r2, i32 1
%r21 = trunc i704 %r18 to i64
store i64 %r21, i64* %r20
%r22 = lshr i704 %r18, 64
%r24 = getelementptr i64, i64* %r2, i32 2
%r25 = trunc i704 %r22 to i64
store i64 %r25, i64* %r24
%r26 = lshr i704 %r22, 64
%r28 = getelementptr i64, i64* %r2, i32 3
%r29 = trunc i704 %r26 to i64
store i64 %r29, i64* %r28
%r30 = lshr i704 %r26, 64
%r32 = getelementptr i64, i64* %r2, i32 4
%r33 = trunc i704 %r30 to i64
store i64 %r33, i64* %r32
%r34 = lshr i704 %r30, 64
%r36 = getelementptr i64, i64* %r2, i32 5
%r37 = trunc i704 %r34 to i64
store i64 %r37, i64* %r36
%r38 = lshr i704 %r34, 64
%r40 = getelementptr i64, i64* %r2, i32 6
%r41 = trunc i704 %r38 to i64
store i64 %r41, i64* %r40
%r42 = lshr i704 %r38, 64
%r44 = getelementptr i64, i64* %r2, i32 7
%r45 = trunc i704 %r42 to i64
store i64 %r45, i64* %r44
%r46 = lshr i704 %r42, 64
%r48 = getelementptr i64, i64* %r2, i32 8
%r49 = trunc i704 %r46 to i64
store i64 %r49, i64* %r48
%r50 = lshr i704 %r46, 64
%r52 = getelementptr i64, i64* %r2, i32 9
%r53 = trunc i704 %r50 to i64
store i64 %r53, i64* %r52
%r54 = lshr i704 %r50, 64
%r56 = getelementptr i64, i64* %r2, i32 10
%r57 = trunc i704 %r54 to i64
store i64 %r57, i64* %r56
%r58 = lshr i768 %r13, 704
%r59 = trunc i768 %r58 to i64
ret i64 %r59
}
define i64 @mclb_sub11(i64* noalias  %r2, i64* noalias  %r3, i64* noalias  %r4)
{
%r6 = bitcast i64* %r3 to i704*
%r7 = load i704, i704* %r6
%r8 = zext i704 %r7 to i768
%r10 = bitcast i64* %r4 to i704*
%r11 = load i704, i704* %r10
%r12 = zext i704 %r11 to i768
%r13 = sub i768 %r8, %r12
%r14 = trunc i768 %r13 to i704
%r16 = getelementptr i64, i64* %r2, i32 0
%r17 = trunc i704 %r14 to i64
store i64 %r17, i64* %r16
%r18 = lshr i704 %r14, 64
%r20 = getelementptr i64, i64* %r2, i32 1
%r21 = trunc i704 %r18 to i64
store i64 %r21, i64* %r20
%r22 = lshr i704 %r18, 64
%r24 = getelementptr i64, i64* %r2, i32 2
%r25 = trunc i704 %r22 to i64
store i64 %r25, i64* %r24
%r26 = lshr i704 %r22, 64
%r28 = getelementptr i64, i64* %r2, i32 3
%r29 = trunc i704 %r26 to i64
store i64 %r29, i64* %r28
%r30 = lshr i704 %r26, 64
%r32 = getelementptr i64, i64* %r2, i32 4
%r33 = trunc i704 %r30 to i64
store i64 %r33, i64* %r32
%r34 = lshr i704 %r30, 64
%r36 = getelementptr i64, i64* %r2, i32 5
%r37 = trunc i704 %r34 to i64
store i64 %r37, i64* %r36
%r38 = lshr i704 %r34, 64
%r40 = getelementptr i64, i64* %r2, i32 6
%r41 = trunc i704 %r38 to i64
store i64 %r41, i64* %r40
%r42 = lshr i704 %r38, 64
%r44 = getelementptr i64, i64* %r2, i32 7
%r45 = trunc i704 %r42 to i64
store i64 %r45, i64* %r44
%r46 = lshr i704 %r42, 64
%r48 = getelementptr i64, i64* %r2, i32 8
%r49 = trunc i704 %r46 to i64
store i64 %r49, i64* %r48
%r50 = lshr i704 %r46, 64
%r52 = getelementptr i64, i64* %r2, i32 9
%r53 = trunc i704 %r50 to i64
store i64 %r53, i64* %r52
%r54 = lshr i704 %r50, 64
%r56 = getelementptr i64, i64* %r2, i32 10
%r57 = trunc i704 %r54 to i64
store i64 %r57, i64* %r56
%r58 = lshr i768 %r13, 704
%r59 = trunc i768 %r58 to i64
%r61 = and i64 %r59, 1
ret i64 %r61
}
define void @mclb_addNF11(i64* noalias  %r1, i64* noalias  %r2, i64* noalias  %r3)
{
%r5 = bitcast i64* %r2 to i704*
%r6 = load i704, i704* %r5
%r8 = bitcast i64* %r3 to i704*
%r9 = load i704, i704* %r8
%r10 = add i704 %r6, %r9
%r12 = getelementptr i64, i64* %r1, i32 0
%r13 = trunc i704 %r10 to i64
store i64 %r13, i64* %r12
%r14 = lshr i704 %r10, 64
%r16 = getelementptr i64, i64* %r1, i32 1
%r17 = trunc i704 %r14 to i64
store i64 %r17, i64* %r16
%r18 = lshr i704 %r14, 64
%r20 = getelementptr i64, i64* %r1, i32 2
%r21 = trunc i704 %r18 to i64
store i64 %r21, i64* %r20
%r22 = lshr i704 %r18, 64
%r24 = getelementptr i64, i64* %r1, i32 3
%r25 = trunc i704 %r22 to i64
store i64 %r25, i64* %r24
%r26 = lshr i704 %r22, 64
%r28 = getelementptr i64, i64* %r1, i32 4
%r29 = trunc i704 %r26 to i64
store i64 %r29, i64* %r28
%r30 = lshr i704 %r26, 64
%r32 = getelementptr i64, i64* %r1, i32 5
%r33 = trunc i704 %r30 to i64
store i64 %r33, i64* %r32
%r34 = lshr i704 %r30, 64
%r36 = getelementptr i64, i64* %r1, i32 6
%r37 = trunc i704 %r34 to i64
store i64 %r37, i64* %r36
%r38 = lshr i704 %r34, 64
%r40 = getelementptr i64, i64* %r1, i32 7
%r41 = trunc i704 %r38 to i64
store i64 %r41, i64* %r40
%r42 = lshr i704 %r38, 64
%r44 = getelementptr i64, i64* %r1, i32 8
%r45 = trunc i704 %r42 to i64
store i64 %r45, i64* %r44
%r46 = lshr i704 %r42, 64
%r48 = getelementptr i64, i64* %r1, i32 9
%r49 = trunc i704 %r46 to i64
store i64 %r49, i64* %r48
%r50 = lshr i704 %r46, 64
%r52 = getelementptr i64, i64* %r1, i32 10
%r53 = trunc i704 %r50 to i64
store i64 %r53, i64* %r52
ret void
}
define i64 @mclb_subNF11(i64* noalias  %r2, i64* noalias  %r3, i64* noalias  %r4)
{
%r6 = bitcast i64* %r3 to i704*
%r7 = load i704, i704* %r6
%r9 = bitcast i64* %r4 to i704*
%r10 = load i704, i704* %r9
%r11 = sub i704 %r7, %r10
%r13 = getelementptr i64, i64* %r2, i32 0
%r14 = trunc i704 %r11 to i64
store i64 %r14, i64* %r13
%r15 = lshr i704 %r11, 64
%r17 = getelementptr i64, i64* %r2, i32 1
%r18 = trunc i704 %r15 to i64
store i64 %r18, i64* %r17
%r19 = lshr i704 %r15, 64
%r21 = getelementptr i64, i64* %r2, i32 2
%r22 = trunc i704 %r19 to i64
store i64 %r22, i64* %r21
%r23 = lshr i704 %r19, 64
%r25 = getelementptr i64, i64* %r2, i32 3
%r26 = trunc i704 %r23 to i64
store i64 %r26, i64* %r25
%r27 = lshr i704 %r23, 64
%r29 = getelementptr i64, i64* %r2, i32 4
%r30 = trunc i704 %r27 to i64
store i64 %r30, i64* %r29
%r31 = lshr i704 %r27, 64
%r33 = getelementptr i64, i64* %r2, i32 5
%r34 = trunc i704 %r31 to i64
store i64 %r34, i64* %r33
%r35 = lshr i704 %r31, 64
%r37 = getelementptr i64, i64* %r2, i32 6
%r38 = trunc i704 %r35 to i64
store i64 %r38, i64* %r37
%r39 = lshr i704 %r35, 64
%r41 = getelementptr i64, i64* %r2, i32 7
%r42 = trunc i704 %r39 to i64
store i64 %r42, i64* %r41
%r43 = lshr i704 %r39, 64
%r45 = getelementptr i64, i64* %r2, i32 8
%r46 = trunc i704 %r43 to i64
store i64 %r46, i64* %r45
%r47 = lshr i704 %r43, 64
%r49 = getelementptr i64, i64* %r2, i32 9
%r50 = trunc i704 %r47 to i64
store i64 %r50, i64* %r49
%r51 = lshr i704 %r47, 64
%r53 = getelementptr i64, i64* %r2, i32 10
%r54 = trunc i704 %r51 to i64
store i64 %r54, i64* %r53
%r55 = lshr i704 %r11, 703
%r56 = trunc i704 %r55 to i64
%r58 = and i64 %r56, 1
ret i64 %r58
}
define i64 @mclb_add12(i64* noalias  %r2, i64* noalias  %r3, i64* noalias  %r4)
{
%r6 = bitcast i64* %r3 to i768*
%r7 = load i768, i768* %r6
%r8 = zext i768 %r7 to i832
%r10 = bitcast i64* %r4 to i768*
%r11 = load i768, i768* %r10
%r12 = zext i768 %r11 to i832
%r13 = add i832 %r8, %r12
%r14 = trunc i832 %r13 to i768
%r16 = getelementptr i64, i64* %r2, i32 0
%r17 = trunc i768 %r14 to i64
store i64 %r17, i64* %r16
%r18 = lshr i768 %r14, 64
%r20 = getelementptr i64, i64* %r2, i32 1
%r21 = trunc i768 %r18 to i64
store i64 %r21, i64* %r20
%r22 = lshr i768 %r18, 64
%r24 = getelementptr i64, i64* %r2, i32 2
%r25 = trunc i768 %r22 to i64
store i64 %r25, i64* %r24
%r26 = lshr i768 %r22, 64
%r28 = getelementptr i64, i64* %r2, i32 3
%r29 = trunc i768 %r26 to i64
store i64 %r29, i64* %r28
%r30 = lshr i768 %r26, 64
%r32 = getelementptr i64, i64* %r2, i32 4
%r33 = trunc i768 %r30 to i64
store i64 %r33, i64* %r32
%r34 = lshr i768 %r30, 64
%r36 = getelementptr i64, i64* %r2, i32 5
%r37 = trunc i768 %r34 to i64
store i64 %r37, i64* %r36
%r38 = lshr i768 %r34, 64
%r40 = getelementptr i64, i64* %r2, i32 6
%r41 = trunc i768 %r38 to i64
store i64 %r41, i64* %r40
%r42 = lshr i768 %r38, 64
%r44 = getelementptr i64, i64* %r2, i32 7
%r45 = trunc i768 %r42 to i64
store i64 %r45, i64* %r44
%r46 = lshr i768 %r42, 64
%r48 = getelementptr i64, i64* %r2, i32 8
%r49 = trunc i768 %r46 to i64
store i64 %r49, i64* %r48
%r50 = lshr i768 %r46, 64
%r52 = getelementptr i64, i64* %r2, i32 9
%r53 = trunc i768 %r50 to i64
store i64 %r53, i64* %r52
%r54 = lshr i768 %r50, 64
%r56 = getelementptr i64, i64* %r2, i32 10
%r57 = trunc i768 %r54 to i64
store i64 %r57, i64* %r56
%r58 = lshr i768 %r54, 64
%r60 = getelementptr i64, i64* %r2, i32 11
%r61 = trunc i768 %r58 to i64
store i64 %r61, i64* %r60
%r62 = lshr i832 %r13, 768
%r63 = trunc i832 %r62 to i64
ret i64 %r63
}
define i64 @mclb_sub12(i64* noalias  %r2, i64* noalias  %r3, i64* noalias  %r4)
{
%r6 = bitcast i64* %r3 to i768*
%r7 = load i768, i768* %r6
%r8 = zext i768 %r7 to i832
%r10 = bitcast i64* %r4 to i768*
%r11 = load i768, i768* %r10
%r12 = zext i768 %r11 to i832
%r13 = sub i832 %r8, %r12
%r14 = trunc i832 %r13 to i768
%r16 = getelementptr i64, i64* %r2, i32 0
%r17 = trunc i768 %r14 to i64
store i64 %r17, i64* %r16
%r18 = lshr i768 %r14, 64
%r20 = getelementptr i64, i64* %r2, i32 1
%r21 = trunc i768 %r18 to i64
store i64 %r21, i64* %r20
%r22 = lshr i768 %r18, 64
%r24 = getelementptr i64, i64* %r2, i32 2
%r25 = trunc i768 %r22 to i64
store i64 %r25, i64* %r24
%r26 = lshr i768 %r22, 64
%r28 = getelementptr i64, i64* %r2, i32 3
%r29 = trunc i768 %r26 to i64
store i64 %r29, i64* %r28
%r30 = lshr i768 %r26, 64
%r32 = getelementptr i64, i64* %r2, i32 4
%r33 = trunc i768 %r30 to i64
store i64 %r33, i64* %r32
%r34 = lshr i768 %r30, 64
%r36 = getelementptr i64, i64* %r2, i32 5
%r37 = trunc i768 %r34 to i64
store i64 %r37, i64* %r36
%r38 = lshr i768 %r34, 64
%r40 = getelementptr i64, i64* %r2, i32 6
%r41 = trunc i768 %r38 to i64
store i64 %r41, i64* %r40
%r42 = lshr i768 %r38, 64
%r44 = getelementptr i64, i64* %r2, i32 7
%r45 = trunc i768 %r42 to i64
store i64 %r45, i64* %r44
%r46 = lshr i768 %r42, 64
%r48 = getelementptr i64, i64* %r2, i32 8
%r49 = trunc i768 %r46 to i64
store i64 %r49, i64* %r48
%r50 = lshr i768 %r46, 64
%r52 = getelementptr i64, i64* %r2, i32 9
%r53 = trunc i768 %r50 to i64
store i64 %r53, i64* %r52
%r54 = lshr i768 %r50, 64
%r56 = getelementptr i64, i64* %r2, i32 10
%r57 = trunc i768 %r54 to i64
store i64 %r57, i64* %r56
%r58 = lshr i768 %r54, 64
%r60 = getelementptr i64, i64* %r2, i32 11
%r61 = trunc i768 %r58 to i64
store i64 %r61, i64* %r60
%r62 = lshr i832 %r13, 768
%r63 = trunc i832 %r62 to i64
%r65 = and i64 %r63, 1
ret i64 %r65
}
define void @mclb_addNF12(i64* noalias  %r1, i64* noalias  %r2, i64* noalias  %r3)
{
%r5 = bitcast i64* %r2 to i768*
%r6 = load i768, i768* %r5
%r8 = bitcast i64* %r3 to i768*
%r9 = load i768, i768* %r8
%r10 = add i768 %r6, %r9
%r12 = getelementptr i64, i64* %r1, i32 0
%r13 = trunc i768 %r10 to i64
store i64 %r13, i64* %r12
%r14 = lshr i768 %r10, 64
%r16 = getelementptr i64, i64* %r1, i32 1
%r17 = trunc i768 %r14 to i64
store i64 %r17, i64* %r16
%r18 = lshr i768 %r14, 64
%r20 = getelementptr i64, i64* %r1, i32 2
%r21 = trunc i768 %r18 to i64
store i64 %r21, i64* %r20
%r22 = lshr i768 %r18, 64
%r24 = getelementptr i64, i64* %r1, i32 3
%r25 = trunc i768 %r22 to i64
store i64 %r25, i64* %r24
%r26 = lshr i768 %r22, 64
%r28 = getelementptr i64, i64* %r1, i32 4
%r29 = trunc i768 %r26 to i64
store i64 %r29, i64* %r28
%r30 = lshr i768 %r26, 64
%r32 = getelementptr i64, i64* %r1, i32 5
%r33 = trunc i768 %r30 to i64
store i64 %r33, i64* %r32
%r34 = lshr i768 %r30, 64
%r36 = getelementptr i64, i64* %r1, i32 6
%r37 = trunc i768 %r34 to i64
store i64 %r37, i64* %r36
%r38 = lshr i768 %r34, 64
%r40 = getelementptr i64, i64* %r1, i32 7
%r41 = trunc i768 %r38 to i64
store i64 %r41, i64* %r40
%r42 = lshr i768 %r38, 64
%r44 = getelementptr i64, i64* %r1, i32 8
%r45 = trunc i768 %r42 to i64
store i64 %r45, i64* %r44
%r46 = lshr i768 %r42, 64
%r48 = getelementptr i64, i64* %r1, i32 9
%r49 = trunc i768 %r46 to i64
store i64 %r49, i64* %r48
%r50 = lshr i768 %r46, 64
%r52 = getelementptr i64, i64* %r1, i32 10
%r53 = trunc i768 %r50 to i64
store i64 %r53, i64* %r52
%r54 = lshr i768 %r50, 64
%r56 = getelementptr i64, i64* %r1, i32 11
%r57 = trunc i768 %r54 to i64
store i64 %r57, i64* %r56
ret void
}
define i64 @mclb_subNF12(i64* noalias  %r2, i64* noalias  %r3, i64* noalias  %r4)
{
%r6 = bitcast i64* %r3 to i768*
%r7 = load i768, i768* %r6
%r9 = bitcast i64* %r4 to i768*
%r10 = load i768, i768* %r9
%r11 = sub i768 %r7, %r10
%r13 = getelementptr i64, i64* %r2, i32 0
%r14 = trunc i768 %r11 to i64
store i64 %r14, i64* %r13
%r15 = lshr i768 %r11, 64
%r17 = getelementptr i64, i64* %r2, i32 1
%r18 = trunc i768 %r15 to i64
store i64 %r18, i64* %r17
%r19 = lshr i768 %r15, 64
%r21 = getelementptr i64, i64* %r2, i32 2
%r22 = trunc i768 %r19 to i64
store i64 %r22, i64* %r21
%r23 = lshr i768 %r19, 64
%r25 = getelementptr i64, i64* %r2, i32 3
%r26 = trunc i768 %r23 to i64
store i64 %r26, i64* %r25
%r27 = lshr i768 %r23, 64
%r29 = getelementptr i64, i64* %r2, i32 4
%r30 = trunc i768 %r27 to i64
store i64 %r30, i64* %r29
%r31 = lshr i768 %r27, 64
%r33 = getelementptr i64, i64* %r2, i32 5
%r34 = trunc i768 %r31 to i64
store i64 %r34, i64* %r33
%r35 = lshr i768 %r31, 64
%r37 = getelementptr i64, i64* %r2, i32 6
%r38 = trunc i768 %r35 to i64
store i64 %r38, i64* %r37
%r39 = lshr i768 %r35, 64
%r41 = getelementptr i64, i64* %r2, i32 7
%r42 = trunc i768 %r39 to i64
store i64 %r42, i64* %r41
%r43 = lshr i768 %r39, 64
%r45 = getelementptr i64, i64* %r2, i32 8
%r46 = trunc i768 %r43 to i64
store i64 %r46, i64* %r45
%r47 = lshr i768 %r43, 64
%r49 = getelementptr i64, i64* %r2, i32 9
%r50 = trunc i768 %r47 to i64
store i64 %r50, i64* %r49
%r51 = lshr i768 %r47, 64
%r53 = getelementptr i64, i64* %r2, i32 10
%r54 = trunc i768 %r51 to i64
store i64 %r54, i64* %r53
%r55 = lshr i768 %r51, 64
%r57 = getelementptr i64, i64* %r2, i32 11
%r58 = trunc i768 %r55 to i64
store i64 %r58, i64* %r57
%r59 = lshr i768 %r11, 767
%r60 = trunc i768 %r59 to i64
%r62 = and i64 %r60, 1
ret i64 %r62
}
define i64 @mclb_add13(i64* noalias  %r2, i64* noalias  %r3, i64* noalias  %r4)
{
%r6 = bitcast i64* %r3 to i832*
%r7 = load i832, i832* %r6
%r8 = zext i832 %r7 to i896
%r10 = bitcast i64* %r4 to i832*
%r11 = load i832, i832* %r10
%r12 = zext i832 %r11 to i896
%r13 = add i896 %r8, %r12
%r14 = trunc i896 %r13 to i832
%r16 = getelementptr i64, i64* %r2, i32 0
%r17 = trunc i832 %r14 to i64
store i64 %r17, i64* %r16
%r18 = lshr i832 %r14, 64
%r20 = getelementptr i64, i64* %r2, i32 1
%r21 = trunc i832 %r18 to i64
store i64 %r21, i64* %r20
%r22 = lshr i832 %r18, 64
%r24 = getelementptr i64, i64* %r2, i32 2
%r25 = trunc i832 %r22 to i64
store i64 %r25, i64* %r24
%r26 = lshr i832 %r22, 64
%r28 = getelementptr i64, i64* %r2, i32 3
%r29 = trunc i832 %r26 to i64
store i64 %r29, i64* %r28
%r30 = lshr i832 %r26, 64
%r32 = getelementptr i64, i64* %r2, i32 4
%r33 = trunc i832 %r30 to i64
store i64 %r33, i64* %r32
%r34 = lshr i832 %r30, 64
%r36 = getelementptr i64, i64* %r2, i32 5
%r37 = trunc i832 %r34 to i64
store i64 %r37, i64* %r36
%r38 = lshr i832 %r34, 64
%r40 = getelementptr i64, i64* %r2, i32 6
%r41 = trunc i832 %r38 to i64
store i64 %r41, i64* %r40
%r42 = lshr i832 %r38, 64
%r44 = getelementptr i64, i64* %r2, i32 7
%r45 = trunc i832 %r42 to i64
store i64 %r45, i64* %r44
%r46 = lshr i832 %r42, 64
%r48 = getelementptr i64, i64* %r2, i32 8
%r49 = trunc i832 %r46 to i64
store i64 %r49, i64* %r48
%r50 = lshr i832 %r46, 64
%r52 = getelementptr i64, i64* %r2, i32 9
%r53 = trunc i832 %r50 to i64
store i64 %r53, i64* %r52
%r54 = lshr i832 %r50, 64
%r56 = getelementptr i64, i64* %r2, i32 10
%r57 = trunc i832 %r54 to i64
store i64 %r57, i64* %r56
%r58 = lshr i832 %r54, 64
%r60 = getelementptr i64, i64* %r2, i32 11
%r61 = trunc i832 %r58 to i64
store i64 %r61, i64* %r60
%r62 = lshr i832 %r58, 64
%r64 = getelementptr i64, i64* %r2, i32 12
%r65 = trunc i832 %r62 to i64
store i64 %r65, i64* %r64
%r66 = lshr i896 %r13, 832
%r67 = trunc i896 %r66 to i64
ret i64 %r67
}
define i64 @mclb_sub13(i64* noalias  %r2, i64* noalias  %r3, i64* noalias  %r4)
{
%r6 = bitcast i64* %r3 to i832*
%r7 = load i832, i832* %r6
%r8 = zext i832 %r7 to i896
%r10 = bitcast i64* %r4 to i832*
%r11 = load i832, i832* %r10
%r12 = zext i832 %r11 to i896
%r13 = sub i896 %r8, %r12
%r14 = trunc i896 %r13 to i832
%r16 = getelementptr i64, i64* %r2, i32 0
%r17 = trunc i832 %r14 to i64
store i64 %r17, i64* %r16
%r18 = lshr i832 %r14, 64
%r20 = getelementptr i64, i64* %r2, i32 1
%r21 = trunc i832 %r18 to i64
store i64 %r21, i64* %r20
%r22 = lshr i832 %r18, 64
%r24 = getelementptr i64, i64* %r2, i32 2
%r25 = trunc i832 %r22 to i64
store i64 %r25, i64* %r24
%r26 = lshr i832 %r22, 64
%r28 = getelementptr i64, i64* %r2, i32 3
%r29 = trunc i832 %r26 to i64
store i64 %r29, i64* %r28
%r30 = lshr i832 %r26, 64
%r32 = getelementptr i64, i64* %r2, i32 4
%r33 = trunc i832 %r30 to i64
store i64 %r33, i64* %r32
%r34 = lshr i832 %r30, 64
%r36 = getelementptr i64, i64* %r2, i32 5
%r37 = trunc i832 %r34 to i64
store i64 %r37, i64* %r36
%r38 = lshr i832 %r34, 64
%r40 = getelementptr i64, i64* %r2, i32 6
%r41 = trunc i832 %r38 to i64
store i64 %r41, i64* %r40
%r42 = lshr i832 %r38, 64
%r44 = getelementptr i64, i64* %r2, i32 7
%r45 = trunc i832 %r42 to i64
store i64 %r45, i64* %r44
%r46 = lshr i832 %r42, 64
%r48 = getelementptr i64, i64* %r2, i32 8
%r49 = trunc i832 %r46 to i64
store i64 %r49, i64* %r48
%r50 = lshr i832 %r46, 64
%r52 = getelementptr i64, i64* %r2, i32 9
%r53 = trunc i832 %r50 to i64
store i64 %r53, i64* %r52
%r54 = lshr i832 %r50, 64
%r56 = getelementptr i64, i64* %r2, i32 10
%r57 = trunc i832 %r54 to i64
store i64 %r57, i64* %r56
%r58 = lshr i832 %r54, 64
%r60 = getelementptr i64, i64* %r2, i32 11
%r61 = trunc i832 %r58 to i64
store i64 %r61, i64* %r60
%r62 = lshr i832 %r58, 64
%r64 = getelementptr i64, i64* %r2, i32 12
%r65 = trunc i832 %r62 to i64
store i64 %r65, i64* %r64
%r66 = lshr i896 %r13, 832
%r67 = trunc i896 %r66 to i64
%r69 = and i64 %r67, 1
ret i64 %r69
}
define void @mclb_addNF13(i64* noalias  %r1, i64* noalias  %r2, i64* noalias  %r3)
{
%r5 = bitcast i64* %r2 to i832*
%r6 = load i832, i832* %r5
%r8 = bitcast i64* %r3 to i832*
%r9 = load i832, i832* %r8
%r10 = add i832 %r6, %r9
%r12 = getelementptr i64, i64* %r1, i32 0
%r13 = trunc i832 %r10 to i64
store i64 %r13, i64* %r12
%r14 = lshr i832 %r10, 64
%r16 = getelementptr i64, i64* %r1, i32 1
%r17 = trunc i832 %r14 to i64
store i64 %r17, i64* %r16
%r18 = lshr i832 %r14, 64
%r20 = getelementptr i64, i64* %r1, i32 2
%r21 = trunc i832 %r18 to i64
store i64 %r21, i64* %r20
%r22 = lshr i832 %r18, 64
%r24 = getelementptr i64, i64* %r1, i32 3
%r25 = trunc i832 %r22 to i64
store i64 %r25, i64* %r24
%r26 = lshr i832 %r22, 64
%r28 = getelementptr i64, i64* %r1, i32 4
%r29 = trunc i832 %r26 to i64
store i64 %r29, i64* %r28
%r30 = lshr i832 %r26, 64
%r32 = getelementptr i64, i64* %r1, i32 5
%r33 = trunc i832 %r30 to i64
store i64 %r33, i64* %r32
%r34 = lshr i832 %r30, 64
%r36 = getelementptr i64, i64* %r1, i32 6
%r37 = trunc i832 %r34 to i64
store i64 %r37, i64* %r36
%r38 = lshr i832 %r34, 64
%r40 = getelementptr i64, i64* %r1, i32 7
%r41 = trunc i832 %r38 to i64
store i64 %r41, i64* %r40
%r42 = lshr i832 %r38, 64
%r44 = getelementptr i64, i64* %r1, i32 8
%r45 = trunc i832 %r42 to i64
store i64 %r45, i64* %r44
%r46 = lshr i832 %r42, 64
%r48 = getelementptr i64, i64* %r1, i32 9
%r49 = trunc i832 %r46 to i64
store i64 %r49, i64* %r48
%r50 = lshr i832 %r46, 64
%r52 = getelementptr i64, i64* %r1, i32 10
%r53 = trunc i832 %r50 to i64
store i64 %r53, i64* %r52
%r54 = lshr i832 %r50, 64
%r56 = getelementptr i64, i64* %r1, i32 11
%r57 = trunc i832 %r54 to i64
store i64 %r57, i64* %r56
%r58 = lshr i832 %r54, 64
%r60 = getelementptr i64, i64* %r1, i32 12
%r61 = trunc i832 %r58 to i64
store i64 %r61, i64* %r60
ret void
}
define i64 @mclb_subNF13(i64* noalias  %r2, i64* noalias  %r3, i64* noalias  %r4)
{
%r6 = bitcast i64* %r3 to i832*
%r7 = load i832, i832* %r6
%r9 = bitcast i64* %r4 to i832*
%r10 = load i832, i832* %r9
%r11 = sub i832 %r7, %r10
%r13 = getelementptr i64, i64* %r2, i32 0
%r14 = trunc i832 %r11 to i64
store i64 %r14, i64* %r13
%r15 = lshr i832 %r11, 64
%r17 = getelementptr i64, i64* %r2, i32 1
%r18 = trunc i832 %r15 to i64
store i64 %r18, i64* %r17
%r19 = lshr i832 %r15, 64
%r21 = getelementptr i64, i64* %r2, i32 2
%r22 = trunc i832 %r19 to i64
store i64 %r22, i64* %r21
%r23 = lshr i832 %r19, 64
%r25 = getelementptr i64, i64* %r2, i32 3
%r26 = trunc i832 %r23 to i64
store i64 %r26, i64* %r25
%r27 = lshr i832 %r23, 64
%r29 = getelementptr i64, i64* %r2, i32 4
%r30 = trunc i832 %r27 to i64
store i64 %r30, i64* %r29
%r31 = lshr i832 %r27, 64
%r33 = getelementptr i64, i64* %r2, i32 5
%r34 = trunc i832 %r31 to i64
store i64 %r34, i64* %r33
%r35 = lshr i832 %r31, 64
%r37 = getelementptr i64, i64* %r2, i32 6
%r38 = trunc i832 %r35 to i64
store i64 %r38, i64* %r37
%r39 = lshr i832 %r35, 64
%r41 = getelementptr i64, i64* %r2, i32 7
%r42 = trunc i832 %r39 to i64
store i64 %r42, i64* %r41
%r43 = lshr i832 %r39, 64
%r45 = getelementptr i64, i64* %r2, i32 8
%r46 = trunc i832 %r43 to i64
store i64 %r46, i64* %r45
%r47 = lshr i832 %r43, 64
%r49 = getelementptr i64, i64* %r2, i32 9
%r50 = trunc i832 %r47 to i64
store i64 %r50, i64* %r49
%r51 = lshr i832 %r47, 64
%r53 = getelementptr i64, i64* %r2, i32 10
%r54 = trunc i832 %r51 to i64
store i64 %r54, i64* %r53
%r55 = lshr i832 %r51, 64
%r57 = getelementptr i64, i64* %r2, i32 11
%r58 = trunc i832 %r55 to i64
store i64 %r58, i64* %r57
%r59 = lshr i832 %r55, 64
%r61 = getelementptr i64, i64* %r2, i32 12
%r62 = trunc i832 %r59 to i64
store i64 %r62, i64* %r61
%r63 = lshr i832 %r11, 831
%r64 = trunc i832 %r63 to i64
%r66 = and i64 %r64, 1
ret i64 %r66
}
define i64 @mclb_add14(i64* noalias  %r2, i64* noalias  %r3, i64* noalias  %r4)
{
%r6 = bitcast i64* %r3 to i896*
%r7 = load i896, i896* %r6
%r8 = zext i896 %r7 to i960
%r10 = bitcast i64* %r4 to i896*
%r11 = load i896, i896* %r10
%r12 = zext i896 %r11 to i960
%r13 = add i960 %r8, %r12
%r14 = trunc i960 %r13 to i896
%r16 = getelementptr i64, i64* %r2, i32 0
%r17 = trunc i896 %r14 to i64
store i64 %r17, i64* %r16
%r18 = lshr i896 %r14, 64
%r20 = getelementptr i64, i64* %r2, i32 1
%r21 = trunc i896 %r18 to i64
store i64 %r21, i64* %r20
%r22 = lshr i896 %r18, 64
%r24 = getelementptr i64, i64* %r2, i32 2
%r25 = trunc i896 %r22 to i64
store i64 %r25, i64* %r24
%r26 = lshr i896 %r22, 64
%r28 = getelementptr i64, i64* %r2, i32 3
%r29 = trunc i896 %r26 to i64
store i64 %r29, i64* %r28
%r30 = lshr i896 %r26, 64
%r32 = getelementptr i64, i64* %r2, i32 4
%r33 = trunc i896 %r30 to i64
store i64 %r33, i64* %r32
%r34 = lshr i896 %r30, 64
%r36 = getelementptr i64, i64* %r2, i32 5
%r37 = trunc i896 %r34 to i64
store i64 %r37, i64* %r36
%r38 = lshr i896 %r34, 64
%r40 = getelementptr i64, i64* %r2, i32 6
%r41 = trunc i896 %r38 to i64
store i64 %r41, i64* %r40
%r42 = lshr i896 %r38, 64
%r44 = getelementptr i64, i64* %r2, i32 7
%r45 = trunc i896 %r42 to i64
store i64 %r45, i64* %r44
%r46 = lshr i896 %r42, 64
%r48 = getelementptr i64, i64* %r2, i32 8
%r49 = trunc i896 %r46 to i64
store i64 %r49, i64* %r48
%r50 = lshr i896 %r46, 64
%r52 = getelementptr i64, i64* %r2, i32 9
%r53 = trunc i896 %r50 to i64
store i64 %r53, i64* %r52
%r54 = lshr i896 %r50, 64
%r56 = getelementptr i64, i64* %r2, i32 10
%r57 = trunc i896 %r54 to i64
store i64 %r57, i64* %r56
%r58 = lshr i896 %r54, 64
%r60 = getelementptr i64, i64* %r2, i32 11
%r61 = trunc i896 %r58 to i64
store i64 %r61, i64* %r60
%r62 = lshr i896 %r58, 64
%r64 = getelementptr i64, i64* %r2, i32 12
%r65 = trunc i896 %r62 to i64
store i64 %r65, i64* %r64
%r66 = lshr i896 %r62, 64
%r68 = getelementptr i64, i64* %r2, i32 13
%r69 = trunc i896 %r66 to i64
store i64 %r69, i64* %r68
%r70 = lshr i960 %r13, 896
%r71 = trunc i960 %r70 to i64
ret i64 %r71
}
define i64 @mclb_sub14(i64* noalias  %r2, i64* noalias  %r3, i64* noalias  %r4)
{
%r6 = bitcast i64* %r3 to i896*
%r7 = load i896, i896* %r6
%r8 = zext i896 %r7 to i960
%r10 = bitcast i64* %r4 to i896*
%r11 = load i896, i896* %r10
%r12 = zext i896 %r11 to i960
%r13 = sub i960 %r8, %r12
%r14 = trunc i960 %r13 to i896
%r16 = getelementptr i64, i64* %r2, i32 0
%r17 = trunc i896 %r14 to i64
store i64 %r17, i64* %r16
%r18 = lshr i896 %r14, 64
%r20 = getelementptr i64, i64* %r2, i32 1
%r21 = trunc i896 %r18 to i64
store i64 %r21, i64* %r20
%r22 = lshr i896 %r18, 64
%r24 = getelementptr i64, i64* %r2, i32 2
%r25 = trunc i896 %r22 to i64
store i64 %r25, i64* %r24
%r26 = lshr i896 %r22, 64
%r28 = getelementptr i64, i64* %r2, i32 3
%r29 = trunc i896 %r26 to i64
store i64 %r29, i64* %r28
%r30 = lshr i896 %r26, 64
%r32 = getelementptr i64, i64* %r2, i32 4
%r33 = trunc i896 %r30 to i64
store i64 %r33, i64* %r32
%r34 = lshr i896 %r30, 64
%r36 = getelementptr i64, i64* %r2, i32 5
%r37 = trunc i896 %r34 to i64
store i64 %r37, i64* %r36
%r38 = lshr i896 %r34, 64
%r40 = getelementptr i64, i64* %r2, i32 6
%r41 = trunc i896 %r38 to i64
store i64 %r41, i64* %r40
%r42 = lshr i896 %r38, 64
%r44 = getelementptr i64, i64* %r2, i32 7
%r45 = trunc i896 %r42 to i64
store i64 %r45, i64* %r44
%r46 = lshr i896 %r42, 64
%r48 = getelementptr i64, i64* %r2, i32 8
%r49 = trunc i896 %r46 to i64
store i64 %r49, i64* %r48
%r50 = lshr i896 %r46, 64
%r52 = getelementptr i64, i64* %r2, i32 9
%r53 = trunc i896 %r50 to i64
store i64 %r53, i64* %r52
%r54 = lshr i896 %r50, 64
%r56 = getelementptr i64, i64* %r2, i32 10
%r57 = trunc i896 %r54 to i64
store i64 %r57, i64* %r56
%r58 = lshr i896 %r54, 64
%r60 = getelementptr i64, i64* %r2, i32 11
%r61 = trunc i896 %r58 to i64
store i64 %r61, i64* %r60
%r62 = lshr i896 %r58, 64
%r64 = getelementptr i64, i64* %r2, i32 12
%r65 = trunc i896 %r62 to i64
store i64 %r65, i64* %r64
%r66 = lshr i896 %r62, 64
%r68 = getelementptr i64, i64* %r2, i32 13
%r69 = trunc i896 %r66 to i64
store i64 %r69, i64* %r68
%r70 = lshr i960 %r13, 896
%r71 = trunc i960 %r70 to i64
%r73 = and i64 %r71, 1
ret i64 %r73
}
define void @mclb_addNF14(i64* noalias  %r1, i64* noalias  %r2, i64* noalias  %r3)
{
%r5 = bitcast i64* %r2 to i896*
%r6 = load i896, i896* %r5
%r8 = bitcast i64* %r3 to i896*
%r9 = load i896, i896* %r8
%r10 = add i896 %r6, %r9
%r12 = getelementptr i64, i64* %r1, i32 0
%r13 = trunc i896 %r10 to i64
store i64 %r13, i64* %r12
%r14 = lshr i896 %r10, 64
%r16 = getelementptr i64, i64* %r1, i32 1
%r17 = trunc i896 %r14 to i64
store i64 %r17, i64* %r16
%r18 = lshr i896 %r14, 64
%r20 = getelementptr i64, i64* %r1, i32 2
%r21 = trunc i896 %r18 to i64
store i64 %r21, i64* %r20
%r22 = lshr i896 %r18, 64
%r24 = getelementptr i64, i64* %r1, i32 3
%r25 = trunc i896 %r22 to i64
store i64 %r25, i64* %r24
%r26 = lshr i896 %r22, 64
%r28 = getelementptr i64, i64* %r1, i32 4
%r29 = trunc i896 %r26 to i64
store i64 %r29, i64* %r28
%r30 = lshr i896 %r26, 64
%r32 = getelementptr i64, i64* %r1, i32 5
%r33 = trunc i896 %r30 to i64
store i64 %r33, i64* %r32
%r34 = lshr i896 %r30, 64
%r36 = getelementptr i64, i64* %r1, i32 6
%r37 = trunc i896 %r34 to i64
store i64 %r37, i64* %r36
%r38 = lshr i896 %r34, 64
%r40 = getelementptr i64, i64* %r1, i32 7
%r41 = trunc i896 %r38 to i64
store i64 %r41, i64* %r40
%r42 = lshr i896 %r38, 64
%r44 = getelementptr i64, i64* %r1, i32 8
%r45 = trunc i896 %r42 to i64
store i64 %r45, i64* %r44
%r46 = lshr i896 %r42, 64
%r48 = getelementptr i64, i64* %r1, i32 9
%r49 = trunc i896 %r46 to i64
store i64 %r49, i64* %r48
%r50 = lshr i896 %r46, 64
%r52 = getelementptr i64, i64* %r1, i32 10
%r53 = trunc i896 %r50 to i64
store i64 %r53, i64* %r52
%r54 = lshr i896 %r50, 64
%r56 = getelementptr i64, i64* %r1, i32 11
%r57 = trunc i896 %r54 to i64
store i64 %r57, i64* %r56
%r58 = lshr i896 %r54, 64
%r60 = getelementptr i64, i64* %r1, i32 12
%r61 = trunc i896 %r58 to i64
store i64 %r61, i64* %r60
%r62 = lshr i896 %r58, 64
%r64 = getelementptr i64, i64* %r1, i32 13
%r65 = trunc i896 %r62 to i64
store i64 %r65, i64* %r64
ret void
}
define i64 @mclb_subNF14(i64* noalias  %r2, i64* noalias  %r3, i64* noalias  %r4)
{
%r6 = bitcast i64* %r3 to i896*
%r7 = load i896, i896* %r6
%r9 = bitcast i64* %r4 to i896*
%r10 = load i896, i896* %r9
%r11 = sub i896 %r7, %r10
%r13 = getelementptr i64, i64* %r2, i32 0
%r14 = trunc i896 %r11 to i64
store i64 %r14, i64* %r13
%r15 = lshr i896 %r11, 64
%r17 = getelementptr i64, i64* %r2, i32 1
%r18 = trunc i896 %r15 to i64
store i64 %r18, i64* %r17
%r19 = lshr i896 %r15, 64
%r21 = getelementptr i64, i64* %r2, i32 2
%r22 = trunc i896 %r19 to i64
store i64 %r22, i64* %r21
%r23 = lshr i896 %r19, 64
%r25 = getelementptr i64, i64* %r2, i32 3
%r26 = trunc i896 %r23 to i64
store i64 %r26, i64* %r25
%r27 = lshr i896 %r23, 64
%r29 = getelementptr i64, i64* %r2, i32 4
%r30 = trunc i896 %r27 to i64
store i64 %r30, i64* %r29
%r31 = lshr i896 %r27, 64
%r33 = getelementptr i64, i64* %r2, i32 5
%r34 = trunc i896 %r31 to i64
store i64 %r34, i64* %r33
%r35 = lshr i896 %r31, 64
%r37 = getelementptr i64, i64* %r2, i32 6
%r38 = trunc i896 %r35 to i64
store i64 %r38, i64* %r37
%r39 = lshr i896 %r35, 64
%r41 = getelementptr i64, i64* %r2, i32 7
%r42 = trunc i896 %r39 to i64
store i64 %r42, i64* %r41
%r43 = lshr i896 %r39, 64
%r45 = getelementptr i64, i64* %r2, i32 8
%r46 = trunc i896 %r43 to i64
store i64 %r46, i64* %r45
%r47 = lshr i896 %r43, 64
%r49 = getelementptr i64, i64* %r2, i32 9
%r50 = trunc i896 %r47 to i64
store i64 %r50, i64* %r49
%r51 = lshr i896 %r47, 64
%r53 = getelementptr i64, i64* %r2, i32 10
%r54 = trunc i896 %r51 to i64
store i64 %r54, i64* %r53
%r55 = lshr i896 %r51, 64
%r57 = getelementptr i64, i64* %r2, i32 11
%r58 = trunc i896 %r55 to i64
store i64 %r58, i64* %r57
%r59 = lshr i896 %r55, 64
%r61 = getelementptr i64, i64* %r2, i32 12
%r62 = trunc i896 %r59 to i64
store i64 %r62, i64* %r61
%r63 = lshr i896 %r59, 64
%r65 = getelementptr i64, i64* %r2, i32 13
%r66 = trunc i896 %r63 to i64
store i64 %r66, i64* %r65
%r67 = lshr i896 %r11, 895
%r68 = trunc i896 %r67 to i64
%r70 = and i64 %r68, 1
ret i64 %r70
}
define i64 @mclb_add15(i64* noalias  %r2, i64* noalias  %r3, i64* noalias  %r4)
{
%r6 = bitcast i64* %r3 to i960*
%r7 = load i960, i960* %r6
%r8 = zext i960 %r7 to i1024
%r10 = bitcast i64* %r4 to i960*
%r11 = load i960, i960* %r10
%r12 = zext i960 %r11 to i1024
%r13 = add i1024 %r8, %r12
%r14 = trunc i1024 %r13 to i960
%r16 = getelementptr i64, i64* %r2, i32 0
%r17 = trunc i960 %r14 to i64
store i64 %r17, i64* %r16
%r18 = lshr i960 %r14, 64
%r20 = getelementptr i64, i64* %r2, i32 1
%r21 = trunc i960 %r18 to i64
store i64 %r21, i64* %r20
%r22 = lshr i960 %r18, 64
%r24 = getelementptr i64, i64* %r2, i32 2
%r25 = trunc i960 %r22 to i64
store i64 %r25, i64* %r24
%r26 = lshr i960 %r22, 64
%r28 = getelementptr i64, i64* %r2, i32 3
%r29 = trunc i960 %r26 to i64
store i64 %r29, i64* %r28
%r30 = lshr i960 %r26, 64
%r32 = getelementptr i64, i64* %r2, i32 4
%r33 = trunc i960 %r30 to i64
store i64 %r33, i64* %r32
%r34 = lshr i960 %r30, 64
%r36 = getelementptr i64, i64* %r2, i32 5
%r37 = trunc i960 %r34 to i64
store i64 %r37, i64* %r36
%r38 = lshr i960 %r34, 64
%r40 = getelementptr i64, i64* %r2, i32 6
%r41 = trunc i960 %r38 to i64
store i64 %r41, i64* %r40
%r42 = lshr i960 %r38, 64
%r44 = getelementptr i64, i64* %r2, i32 7
%r45 = trunc i960 %r42 to i64
store i64 %r45, i64* %r44
%r46 = lshr i960 %r42, 64
%r48 = getelementptr i64, i64* %r2, i32 8
%r49 = trunc i960 %r46 to i64
store i64 %r49, i64* %r48
%r50 = lshr i960 %r46, 64
%r52 = getelementptr i64, i64* %r2, i32 9
%r53 = trunc i960 %r50 to i64
store i64 %r53, i64* %r52
%r54 = lshr i960 %r50, 64
%r56 = getelementptr i64, i64* %r2, i32 10
%r57 = trunc i960 %r54 to i64
store i64 %r57, i64* %r56
%r58 = lshr i960 %r54, 64
%r60 = getelementptr i64, i64* %r2, i32 11
%r61 = trunc i960 %r58 to i64
store i64 %r61, i64* %r60
%r62 = lshr i960 %r58, 64
%r64 = getelementptr i64, i64* %r2, i32 12
%r65 = trunc i960 %r62 to i64
store i64 %r65, i64* %r64
%r66 = lshr i960 %r62, 64
%r68 = getelementptr i64, i64* %r2, i32 13
%r69 = trunc i960 %r66 to i64
store i64 %r69, i64* %r68
%r70 = lshr i960 %r66, 64
%r72 = getelementptr i64, i64* %r2, i32 14
%r73 = trunc i960 %r70 to i64
store i64 %r73, i64* %r72
%r74 = lshr i1024 %r13, 960
%r75 = trunc i1024 %r74 to i64
ret i64 %r75
}
define i64 @mclb_sub15(i64* noalias  %r2, i64* noalias  %r3, i64* noalias  %r4)
{
%r6 = bitcast i64* %r3 to i960*
%r7 = load i960, i960* %r6
%r8 = zext i960 %r7 to i1024
%r10 = bitcast i64* %r4 to i960*
%r11 = load i960, i960* %r10
%r12 = zext i960 %r11 to i1024
%r13 = sub i1024 %r8, %r12
%r14 = trunc i1024 %r13 to i960
%r16 = getelementptr i64, i64* %r2, i32 0
%r17 = trunc i960 %r14 to i64
store i64 %r17, i64* %r16
%r18 = lshr i960 %r14, 64
%r20 = getelementptr i64, i64* %r2, i32 1
%r21 = trunc i960 %r18 to i64
store i64 %r21, i64* %r20
%r22 = lshr i960 %r18, 64
%r24 = getelementptr i64, i64* %r2, i32 2
%r25 = trunc i960 %r22 to i64
store i64 %r25, i64* %r24
%r26 = lshr i960 %r22, 64
%r28 = getelementptr i64, i64* %r2, i32 3
%r29 = trunc i960 %r26 to i64
store i64 %r29, i64* %r28
%r30 = lshr i960 %r26, 64
%r32 = getelementptr i64, i64* %r2, i32 4
%r33 = trunc i960 %r30 to i64
store i64 %r33, i64* %r32
%r34 = lshr i960 %r30, 64
%r36 = getelementptr i64, i64* %r2, i32 5
%r37 = trunc i960 %r34 to i64
store i64 %r37, i64* %r36
%r38 = lshr i960 %r34, 64
%r40 = getelementptr i64, i64* %r2, i32 6
%r41 = trunc i960 %r38 to i64
store i64 %r41, i64* %r40
%r42 = lshr i960 %r38, 64
%r44 = getelementptr i64, i64* %r2, i32 7
%r45 = trunc i960 %r42 to i64
store i64 %r45, i64* %r44
%r46 = lshr i960 %r42, 64
%r48 = getelementptr i64, i64* %r2, i32 8
%r49 = trunc i960 %r46 to i64
store i64 %r49, i64* %r48
%r50 = lshr i960 %r46, 64
%r52 = getelementptr i64, i64* %r2, i32 9
%r53 = trunc i960 %r50 to i64
store i64 %r53, i64* %r52
%r54 = lshr i960 %r50, 64
%r56 = getelementptr i64, i64* %r2, i32 10
%r57 = trunc i960 %r54 to i64
store i64 %r57, i64* %r56
%r58 = lshr i960 %r54, 64
%r60 = getelementptr i64, i64* %r2, i32 11
%r61 = trunc i960 %r58 to i64
store i64 %r61, i64* %r60
%r62 = lshr i960 %r58, 64
%r64 = getelementptr i64, i64* %r2, i32 12
%r65 = trunc i960 %r62 to i64
store i64 %r65, i64* %r64
%r66 = lshr i960 %r62, 64
%r68 = getelementptr i64, i64* %r2, i32 13
%r69 = trunc i960 %r66 to i64
store i64 %r69, i64* %r68
%r70 = lshr i960 %r66, 64
%r72 = getelementptr i64, i64* %r2, i32 14
%r73 = trunc i960 %r70 to i64
store i64 %r73, i64* %r72
%r74 = lshr i1024 %r13, 960
%r75 = trunc i1024 %r74 to i64
%r77 = and i64 %r75, 1
ret i64 %r77
}
define void @mclb_addNF15(i64* noalias  %r1, i64* noalias  %r2, i64* noalias  %r3)
{
%r5 = bitcast i64* %r2 to i960*
%r6 = load i960, i960* %r5
%r8 = bitcast i64* %r3 to i960*
%r9 = load i960, i960* %r8
%r10 = add i960 %r6, %r9
%r12 = getelementptr i64, i64* %r1, i32 0
%r13 = trunc i960 %r10 to i64
store i64 %r13, i64* %r12
%r14 = lshr i960 %r10, 64
%r16 = getelementptr i64, i64* %r1, i32 1
%r17 = trunc i960 %r14 to i64
store i64 %r17, i64* %r16
%r18 = lshr i960 %r14, 64
%r20 = getelementptr i64, i64* %r1, i32 2
%r21 = trunc i960 %r18 to i64
store i64 %r21, i64* %r20
%r22 = lshr i960 %r18, 64
%r24 = getelementptr i64, i64* %r1, i32 3
%r25 = trunc i960 %r22 to i64
store i64 %r25, i64* %r24
%r26 = lshr i960 %r22, 64
%r28 = getelementptr i64, i64* %r1, i32 4
%r29 = trunc i960 %r26 to i64
store i64 %r29, i64* %r28
%r30 = lshr i960 %r26, 64
%r32 = getelementptr i64, i64* %r1, i32 5
%r33 = trunc i960 %r30 to i64
store i64 %r33, i64* %r32
%r34 = lshr i960 %r30, 64
%r36 = getelementptr i64, i64* %r1, i32 6
%r37 = trunc i960 %r34 to i64
store i64 %r37, i64* %r36
%r38 = lshr i960 %r34, 64
%r40 = getelementptr i64, i64* %r1, i32 7
%r41 = trunc i960 %r38 to i64
store i64 %r41, i64* %r40
%r42 = lshr i960 %r38, 64
%r44 = getelementptr i64, i64* %r1, i32 8
%r45 = trunc i960 %r42 to i64
store i64 %r45, i64* %r44
%r46 = lshr i960 %r42, 64
%r48 = getelementptr i64, i64* %r1, i32 9
%r49 = trunc i960 %r46 to i64
store i64 %r49, i64* %r48
%r50 = lshr i960 %r46, 64
%r52 = getelementptr i64, i64* %r1, i32 10
%r53 = trunc i960 %r50 to i64
store i64 %r53, i64* %r52
%r54 = lshr i960 %r50, 64
%r56 = getelementptr i64, i64* %r1, i32 11
%r57 = trunc i960 %r54 to i64
store i64 %r57, i64* %r56
%r58 = lshr i960 %r54, 64
%r60 = getelementptr i64, i64* %r1, i32 12
%r61 = trunc i960 %r58 to i64
store i64 %r61, i64* %r60
%r62 = lshr i960 %r58, 64
%r64 = getelementptr i64, i64* %r1, i32 13
%r65 = trunc i960 %r62 to i64
store i64 %r65, i64* %r64
%r66 = lshr i960 %r62, 64
%r68 = getelementptr i64, i64* %r1, i32 14
%r69 = trunc i960 %r66 to i64
store i64 %r69, i64* %r68
ret void
}
define i64 @mclb_subNF15(i64* noalias  %r2, i64* noalias  %r3, i64* noalias  %r4)
{
%r6 = bitcast i64* %r3 to i960*
%r7 = load i960, i960* %r6
%r9 = bitcast i64* %r4 to i960*
%r10 = load i960, i960* %r9
%r11 = sub i960 %r7, %r10
%r13 = getelementptr i64, i64* %r2, i32 0
%r14 = trunc i960 %r11 to i64
store i64 %r14, i64* %r13
%r15 = lshr i960 %r11, 64
%r17 = getelementptr i64, i64* %r2, i32 1
%r18 = trunc i960 %r15 to i64
store i64 %r18, i64* %r17
%r19 = lshr i960 %r15, 64
%r21 = getelementptr i64, i64* %r2, i32 2
%r22 = trunc i960 %r19 to i64
store i64 %r22, i64* %r21
%r23 = lshr i960 %r19, 64
%r25 = getelementptr i64, i64* %r2, i32 3
%r26 = trunc i960 %r23 to i64
store i64 %r26, i64* %r25
%r27 = lshr i960 %r23, 64
%r29 = getelementptr i64, i64* %r2, i32 4
%r30 = trunc i960 %r27 to i64
store i64 %r30, i64* %r29
%r31 = lshr i960 %r27, 64
%r33 = getelementptr i64, i64* %r2, i32 5
%r34 = trunc i960 %r31 to i64
store i64 %r34, i64* %r33
%r35 = lshr i960 %r31, 64
%r37 = getelementptr i64, i64* %r2, i32 6
%r38 = trunc i960 %r35 to i64
store i64 %r38, i64* %r37
%r39 = lshr i960 %r35, 64
%r41 = getelementptr i64, i64* %r2, i32 7
%r42 = trunc i960 %r39 to i64
store i64 %r42, i64* %r41
%r43 = lshr i960 %r39, 64
%r45 = getelementptr i64, i64* %r2, i32 8
%r46 = trunc i960 %r43 to i64
store i64 %r46, i64* %r45
%r47 = lshr i960 %r43, 64
%r49 = getelementptr i64, i64* %r2, i32 9
%r50 = trunc i960 %r47 to i64
store i64 %r50, i64* %r49
%r51 = lshr i960 %r47, 64
%r53 = getelementptr i64, i64* %r2, i32 10
%r54 = trunc i960 %r51 to i64
store i64 %r54, i64* %r53
%r55 = lshr i960 %r51, 64
%r57 = getelementptr i64, i64* %r2, i32 11
%r58 = trunc i960 %r55 to i64
store i64 %r58, i64* %r57
%r59 = lshr i960 %r55, 64
%r61 = getelementptr i64, i64* %r2, i32 12
%r62 = trunc i960 %r59 to i64
store i64 %r62, i64* %r61
%r63 = lshr i960 %r59, 64
%r65 = getelementptr i64, i64* %r2, i32 13
%r66 = trunc i960 %r63 to i64
store i64 %r66, i64* %r65
%r67 = lshr i960 %r63, 64
%r69 = getelementptr i64, i64* %r2, i32 14
%r70 = trunc i960 %r67 to i64
store i64 %r70, i64* %r69
%r71 = lshr i960 %r11, 959
%r72 = trunc i960 %r71 to i64
%r74 = and i64 %r72, 1
ret i64 %r74
}
define i64 @mclb_add16(i64* noalias  %r2, i64* noalias  %r3, i64* noalias  %r4)
{
%r6 = bitcast i64* %r3 to i1024*
%r7 = load i1024, i1024* %r6
%r8 = zext i1024 %r7 to i1088
%r10 = bitcast i64* %r4 to i1024*
%r11 = load i1024, i1024* %r10
%r12 = zext i1024 %r11 to i1088
%r13 = add i1088 %r8, %r12
%r14 = trunc i1088 %r13 to i1024
%r16 = getelementptr i64, i64* %r2, i32 0
%r17 = trunc i1024 %r14 to i64
store i64 %r17, i64* %r16
%r18 = lshr i1024 %r14, 64
%r20 = getelementptr i64, i64* %r2, i32 1
%r21 = trunc i1024 %r18 to i64
store i64 %r21, i64* %r20
%r22 = lshr i1024 %r18, 64
%r24 = getelementptr i64, i64* %r2, i32 2
%r25 = trunc i1024 %r22 to i64
store i64 %r25, i64* %r24
%r26 = lshr i1024 %r22, 64
%r28 = getelementptr i64, i64* %r2, i32 3
%r29 = trunc i1024 %r26 to i64
store i64 %r29, i64* %r28
%r30 = lshr i1024 %r26, 64
%r32 = getelementptr i64, i64* %r2, i32 4
%r33 = trunc i1024 %r30 to i64
store i64 %r33, i64* %r32
%r34 = lshr i1024 %r30, 64
%r36 = getelementptr i64, i64* %r2, i32 5
%r37 = trunc i1024 %r34 to i64
store i64 %r37, i64* %r36
%r38 = lshr i1024 %r34, 64
%r40 = getelementptr i64, i64* %r2, i32 6
%r41 = trunc i1024 %r38 to i64
store i64 %r41, i64* %r40
%r42 = lshr i1024 %r38, 64
%r44 = getelementptr i64, i64* %r2, i32 7
%r45 = trunc i1024 %r42 to i64
store i64 %r45, i64* %r44
%r46 = lshr i1024 %r42, 64
%r48 = getelementptr i64, i64* %r2, i32 8
%r49 = trunc i1024 %r46 to i64
store i64 %r49, i64* %r48
%r50 = lshr i1024 %r46, 64
%r52 = getelementptr i64, i64* %r2, i32 9
%r53 = trunc i1024 %r50 to i64
store i64 %r53, i64* %r52
%r54 = lshr i1024 %r50, 64
%r56 = getelementptr i64, i64* %r2, i32 10
%r57 = trunc i1024 %r54 to i64
store i64 %r57, i64* %r56
%r58 = lshr i1024 %r54, 64
%r60 = getelementptr i64, i64* %r2, i32 11
%r61 = trunc i1024 %r58 to i64
store i64 %r61, i64* %r60
%r62 = lshr i1024 %r58, 64
%r64 = getelementptr i64, i64* %r2, i32 12
%r65 = trunc i1024 %r62 to i64
store i64 %r65, i64* %r64
%r66 = lshr i1024 %r62, 64
%r68 = getelementptr i64, i64* %r2, i32 13
%r69 = trunc i1024 %r66 to i64
store i64 %r69, i64* %r68
%r70 = lshr i1024 %r66, 64
%r72 = getelementptr i64, i64* %r2, i32 14
%r73 = trunc i1024 %r70 to i64
store i64 %r73, i64* %r72
%r74 = lshr i1024 %r70, 64
%r76 = getelementptr i64, i64* %r2, i32 15
%r77 = trunc i1024 %r74 to i64
store i64 %r77, i64* %r76
%r78 = lshr i1088 %r13, 1024
%r79 = trunc i1088 %r78 to i64
ret i64 %r79
}
define i64 @mclb_sub16(i64* noalias  %r2, i64* noalias  %r3, i64* noalias  %r4)
{
%r6 = bitcast i64* %r3 to i1024*
%r7 = load i1024, i1024* %r6
%r8 = zext i1024 %r7 to i1088
%r10 = bitcast i64* %r4 to i1024*
%r11 = load i1024, i1024* %r10
%r12 = zext i1024 %r11 to i1088
%r13 = sub i1088 %r8, %r12
%r14 = trunc i1088 %r13 to i1024
%r16 = getelementptr i64, i64* %r2, i32 0
%r17 = trunc i1024 %r14 to i64
store i64 %r17, i64* %r16
%r18 = lshr i1024 %r14, 64
%r20 = getelementptr i64, i64* %r2, i32 1
%r21 = trunc i1024 %r18 to i64
store i64 %r21, i64* %r20
%r22 = lshr i1024 %r18, 64
%r24 = getelementptr i64, i64* %r2, i32 2
%r25 = trunc i1024 %r22 to i64
store i64 %r25, i64* %r24
%r26 = lshr i1024 %r22, 64
%r28 = getelementptr i64, i64* %r2, i32 3
%r29 = trunc i1024 %r26 to i64
store i64 %r29, i64* %r28
%r30 = lshr i1024 %r26, 64
%r32 = getelementptr i64, i64* %r2, i32 4
%r33 = trunc i1024 %r30 to i64
store i64 %r33, i64* %r32
%r34 = lshr i1024 %r30, 64
%r36 = getelementptr i64, i64* %r2, i32 5
%r37 = trunc i1024 %r34 to i64
store i64 %r37, i64* %r36
%r38 = lshr i1024 %r34, 64
%r40 = getelementptr i64, i64* %r2, i32 6
%r41 = trunc i1024 %r38 to i64
store i64 %r41, i64* %r40
%r42 = lshr i1024 %r38, 64
%r44 = getelementptr i64, i64* %r2, i32 7
%r45 = trunc i1024 %r42 to i64
store i64 %r45, i64* %r44
%r46 = lshr i1024 %r42, 64
%r48 = getelementptr i64, i64* %r2, i32 8
%r49 = trunc i1024 %r46 to i64
store i64 %r49, i64* %r48
%r50 = lshr i1024 %r46, 64
%r52 = getelementptr i64, i64* %r2, i32 9
%r53 = trunc i1024 %r50 to i64
store i64 %r53, i64* %r52
%r54 = lshr i1024 %r50, 64
%r56 = getelementptr i64, i64* %r2, i32 10
%r57 = trunc i1024 %r54 to i64
store i64 %r57, i64* %r56
%r58 = lshr i1024 %r54, 64
%r60 = getelementptr i64, i64* %r2, i32 11
%r61 = trunc i1024 %r58 to i64
store i64 %r61, i64* %r60
%r62 = lshr i1024 %r58, 64
%r64 = getelementptr i64, i64* %r2, i32 12
%r65 = trunc i1024 %r62 to i64
store i64 %r65, i64* %r64
%r66 = lshr i1024 %r62, 64
%r68 = getelementptr i64, i64* %r2, i32 13
%r69 = trunc i1024 %r66 to i64
store i64 %r69, i64* %r68
%r70 = lshr i1024 %r66, 64
%r72 = getelementptr i64, i64* %r2, i32 14
%r73 = trunc i1024 %r70 to i64
store i64 %r73, i64* %r72
%r74 = lshr i1024 %r70, 64
%r76 = getelementptr i64, i64* %r2, i32 15
%r77 = trunc i1024 %r74 to i64
store i64 %r77, i64* %r76
%r78 = lshr i1088 %r13, 1024
%r79 = trunc i1088 %r78 to i64
%r81 = and i64 %r79, 1
ret i64 %r81
}
define void @mclb_addNF16(i64* noalias  %r1, i64* noalias  %r2, i64* noalias  %r3)
{
%r5 = bitcast i64* %r2 to i1024*
%r6 = load i1024, i1024* %r5
%r8 = bitcast i64* %r3 to i1024*
%r9 = load i1024, i1024* %r8
%r10 = add i1024 %r6, %r9
%r12 = getelementptr i64, i64* %r1, i32 0
%r13 = trunc i1024 %r10 to i64
store i64 %r13, i64* %r12
%r14 = lshr i1024 %r10, 64
%r16 = getelementptr i64, i64* %r1, i32 1
%r17 = trunc i1024 %r14 to i64
store i64 %r17, i64* %r16
%r18 = lshr i1024 %r14, 64
%r20 = getelementptr i64, i64* %r1, i32 2
%r21 = trunc i1024 %r18 to i64
store i64 %r21, i64* %r20
%r22 = lshr i1024 %r18, 64
%r24 = getelementptr i64, i64* %r1, i32 3
%r25 = trunc i1024 %r22 to i64
store i64 %r25, i64* %r24
%r26 = lshr i1024 %r22, 64
%r28 = getelementptr i64, i64* %r1, i32 4
%r29 = trunc i1024 %r26 to i64
store i64 %r29, i64* %r28
%r30 = lshr i1024 %r26, 64
%r32 = getelementptr i64, i64* %r1, i32 5
%r33 = trunc i1024 %r30 to i64
store i64 %r33, i64* %r32
%r34 = lshr i1024 %r30, 64
%r36 = getelementptr i64, i64* %r1, i32 6
%r37 = trunc i1024 %r34 to i64
store i64 %r37, i64* %r36
%r38 = lshr i1024 %r34, 64
%r40 = getelementptr i64, i64* %r1, i32 7
%r41 = trunc i1024 %r38 to i64
store i64 %r41, i64* %r40
%r42 = lshr i1024 %r38, 64
%r44 = getelementptr i64, i64* %r1, i32 8
%r45 = trunc i1024 %r42 to i64
store i64 %r45, i64* %r44
%r46 = lshr i1024 %r42, 64
%r48 = getelementptr i64, i64* %r1, i32 9
%r49 = trunc i1024 %r46 to i64
store i64 %r49, i64* %r48
%r50 = lshr i1024 %r46, 64
%r52 = getelementptr i64, i64* %r1, i32 10
%r53 = trunc i1024 %r50 to i64
store i64 %r53, i64* %r52
%r54 = lshr i1024 %r50, 64
%r56 = getelementptr i64, i64* %r1, i32 11
%r57 = trunc i1024 %r54 to i64
store i64 %r57, i64* %r56
%r58 = lshr i1024 %r54, 64
%r60 = getelementptr i64, i64* %r1, i32 12
%r61 = trunc i1024 %r58 to i64
store i64 %r61, i64* %r60
%r62 = lshr i1024 %r58, 64
%r64 = getelementptr i64, i64* %r1, i32 13
%r65 = trunc i1024 %r62 to i64
store i64 %r65, i64* %r64
%r66 = lshr i1024 %r62, 64
%r68 = getelementptr i64, i64* %r1, i32 14
%r69 = trunc i1024 %r66 to i64
store i64 %r69, i64* %r68
%r70 = lshr i1024 %r66, 64
%r72 = getelementptr i64, i64* %r1, i32 15
%r73 = trunc i1024 %r70 to i64
store i64 %r73, i64* %r72
ret void
}
define i64 @mclb_subNF16(i64* noalias  %r2, i64* noalias  %r3, i64* noalias  %r4)
{
%r6 = bitcast i64* %r3 to i1024*
%r7 = load i1024, i1024* %r6
%r9 = bitcast i64* %r4 to i1024*
%r10 = load i1024, i1024* %r9
%r11 = sub i1024 %r7, %r10
%r13 = getelementptr i64, i64* %r2, i32 0
%r14 = trunc i1024 %r11 to i64
store i64 %r14, i64* %r13
%r15 = lshr i1024 %r11, 64
%r17 = getelementptr i64, i64* %r2, i32 1
%r18 = trunc i1024 %r15 to i64
store i64 %r18, i64* %r17
%r19 = lshr i1024 %r15, 64
%r21 = getelementptr i64, i64* %r2, i32 2
%r22 = trunc i1024 %r19 to i64
store i64 %r22, i64* %r21
%r23 = lshr i1024 %r19, 64
%r25 = getelementptr i64, i64* %r2, i32 3
%r26 = trunc i1024 %r23 to i64
store i64 %r26, i64* %r25
%r27 = lshr i1024 %r23, 64
%r29 = getelementptr i64, i64* %r2, i32 4
%r30 = trunc i1024 %r27 to i64
store i64 %r30, i64* %r29
%r31 = lshr i1024 %r27, 64
%r33 = getelementptr i64, i64* %r2, i32 5
%r34 = trunc i1024 %r31 to i64
store i64 %r34, i64* %r33
%r35 = lshr i1024 %r31, 64
%r37 = getelementptr i64, i64* %r2, i32 6
%r38 = trunc i1024 %r35 to i64
store i64 %r38, i64* %r37
%r39 = lshr i1024 %r35, 64
%r41 = getelementptr i64, i64* %r2, i32 7
%r42 = trunc i1024 %r39 to i64
store i64 %r42, i64* %r41
%r43 = lshr i1024 %r39, 64
%r45 = getelementptr i64, i64* %r2, i32 8
%r46 = trunc i1024 %r43 to i64
store i64 %r46, i64* %r45
%r47 = lshr i1024 %r43, 64
%r49 = getelementptr i64, i64* %r2, i32 9
%r50 = trunc i1024 %r47 to i64
store i64 %r50, i64* %r49
%r51 = lshr i1024 %r47, 64
%r53 = getelementptr i64, i64* %r2, i32 10
%r54 = trunc i1024 %r51 to i64
store i64 %r54, i64* %r53
%r55 = lshr i1024 %r51, 64
%r57 = getelementptr i64, i64* %r2, i32 11
%r58 = trunc i1024 %r55 to i64
store i64 %r58, i64* %r57
%r59 = lshr i1024 %r55, 64
%r61 = getelementptr i64, i64* %r2, i32 12
%r62 = trunc i1024 %r59 to i64
store i64 %r62, i64* %r61
%r63 = lshr i1024 %r59, 64
%r65 = getelementptr i64, i64* %r2, i32 13
%r66 = trunc i1024 %r63 to i64
store i64 %r66, i64* %r65
%r67 = lshr i1024 %r63, 64
%r69 = getelementptr i64, i64* %r2, i32 14
%r70 = trunc i1024 %r67 to i64
store i64 %r70, i64* %r69
%r71 = lshr i1024 %r67, 64
%r73 = getelementptr i64, i64* %r2, i32 15
%r74 = trunc i1024 %r71 to i64
store i64 %r74, i64* %r73
%r75 = lshr i1024 %r11, 1023
%r76 = trunc i1024 %r75 to i64
%r78 = and i64 %r76, 1
ret i64 %r78
}
define i128 @mulUnit_inner64(i64* noalias  %r2, i64 %r3)
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
define i64 @mclb_mulUnit1(i64* noalias  %r2, i64* noalias  %r3, i64 %r4)
{
%r5 = call i128 @mulUnit_inner64(i64* %r3, i64 %r4)
%r6 = trunc i128 %r5 to i64
store i64 %r6, i64* %r2
%r7 = lshr i128 %r5, 64
%r8 = trunc i128 %r7 to i64
ret i64 %r8
}
define i64 @mclb_mulUnitAdd1(i64* noalias  %r2, i64* noalias  %r3, i64 %r4)
{
%r6 = call i128 @mulPos64x64(i64* %r3, i64 %r4, i64 0)
%r7 = trunc i128 %r6 to i64
%r8 = call i64 @extractHigh64(i128 %r6)
%r9 = zext i64 %r7 to i128
%r10 = zext i64 %r8 to i128
%r11 = shl i128 %r10, 64
%r12 = add i128 %r9, %r11
%r13 = load i64, i64* %r2
%r14 = zext i64 %r13 to i128
%r15 = add i128 %r12, %r14
%r16 = trunc i128 %r15 to i64
store i64 %r16, i64* %r2
%r17 = lshr i128 %r15, 64
%r18 = trunc i128 %r17 to i64
ret i64 %r18
}
define void @mclb_mul1(i64* noalias  %r1, i64* noalias  %r2, i64* noalias  %r3)
{
%r4 = load i64, i64* %r2
%r5 = load i64, i64* %r3
%r6 = zext i64 %r4 to i128
%r7 = zext i64 %r5 to i128
%r8 = mul i128 %r6, %r7
%r10 = getelementptr i64, i64* %r1, i32 0
%r11 = trunc i128 %r8 to i64
store i64 %r11, i64* %r10
%r12 = lshr i128 %r8, 64
%r14 = getelementptr i64, i64* %r1, i32 1
%r15 = trunc i128 %r12 to i64
store i64 %r15, i64* %r14
ret void
}
define void @mclb_sqr1(i64* noalias  %r1, i64* noalias  %r2)
{
%r3 = load i64, i64* %r2
%r4 = load i64, i64* %r2
%r5 = zext i64 %r3 to i128
%r6 = zext i64 %r4 to i128
%r7 = mul i128 %r5, %r6
%r9 = getelementptr i64, i64* %r1, i32 0
%r10 = trunc i128 %r7 to i64
store i64 %r10, i64* %r9
%r11 = lshr i128 %r7, 64
%r13 = getelementptr i64, i64* %r1, i32 1
%r14 = trunc i128 %r11 to i64
store i64 %r14, i64* %r13
ret void
}
define i192 @mulUnit_inner128(i64* noalias  %r2, i64 %r3)
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
define i64 @mclb_mulUnit2(i64* noalias  %r2, i64* noalias  %r3, i64 %r4)
{
%r5 = call i192 @mulUnit_inner128(i64* %r3, i64 %r4)
%r6 = trunc i192 %r5 to i128
%r8 = getelementptr i64, i64* %r2, i32 0
%r9 = trunc i128 %r6 to i64
store i64 %r9, i64* %r8
%r10 = lshr i128 %r6, 64
%r12 = getelementptr i64, i64* %r2, i32 1
%r13 = trunc i128 %r10 to i64
store i64 %r13, i64* %r12
%r14 = lshr i192 %r5, 128
%r15 = trunc i192 %r14 to i64
ret i64 %r15
}
define i64 @mclb_mulUnitAdd2(i64* noalias  %r2, i64* noalias  %r3, i64 %r4)
{
%r6 = call i128 @mulPos64x64(i64* %r3, i64 %r4, i64 0)
%r7 = trunc i128 %r6 to i64
%r8 = call i64 @extractHigh64(i128 %r6)
%r10 = call i128 @mulPos64x64(i64* %r3, i64 %r4, i64 1)
%r11 = trunc i128 %r10 to i64
%r12 = call i64 @extractHigh64(i128 %r10)
%r13 = zext i64 %r7 to i128
%r14 = zext i64 %r11 to i128
%r15 = shl i128 %r14, 64
%r16 = or i128 %r13, %r15
%r17 = zext i64 %r8 to i128
%r18 = zext i64 %r12 to i128
%r19 = shl i128 %r18, 64
%r20 = or i128 %r17, %r19
%r21 = zext i128 %r16 to i192
%r22 = zext i128 %r20 to i192
%r23 = shl i192 %r22, 64
%r24 = add i192 %r21, %r23
%r26 = bitcast i64* %r2 to i128*
%r27 = load i128, i128* %r26
%r28 = zext i128 %r27 to i192
%r29 = add i192 %r24, %r28
%r30 = trunc i192 %r29 to i128
%r32 = getelementptr i64, i64* %r2, i32 0
%r33 = trunc i128 %r30 to i64
store i64 %r33, i64* %r32
%r34 = lshr i128 %r30, 64
%r36 = getelementptr i64, i64* %r2, i32 1
%r37 = trunc i128 %r34 to i64
store i64 %r37, i64* %r36
%r38 = lshr i192 %r29, 128
%r39 = trunc i192 %r38 to i64
ret i64 %r39
}
define void @mclb_mul2(i64* noalias  %r1, i64* noalias  %r2, i64* noalias  %r3)
{
%r4 = load i64, i64* %r3
%r5 = call i192 @mulUnit_inner128(i64* %r2, i64 %r4)
%r6 = trunc i192 %r5 to i64
store i64 %r6, i64* %r1
%r7 = lshr i192 %r5, 64
%r9 = getelementptr i64, i64* %r3, i32 1
%r10 = load i64, i64* %r9
%r11 = call i192 @mulUnit_inner128(i64* %r2, i64 %r10)
%r12 = add i192 %r7, %r11
%r14 = getelementptr i64, i64* %r1, i32 1
%r16 = getelementptr i64, i64* %r14, i32 0
%r17 = trunc i192 %r12 to i64
store i64 %r17, i64* %r16
%r18 = lshr i192 %r12, 64
%r20 = getelementptr i64, i64* %r14, i32 1
%r21 = trunc i192 %r18 to i64
store i64 %r21, i64* %r20
%r22 = lshr i192 %r18, 64
%r24 = getelementptr i64, i64* %r14, i32 2
%r25 = trunc i192 %r22 to i64
store i64 %r25, i64* %r24
ret void
}
define void @mclb_sqr2(i64* noalias  %r1, i64* noalias  %r2)
{
%r3 = load i64, i64* %r2
%r4 = call i192 @mulUnit_inner128(i64* %r2, i64 %r3)
%r5 = trunc i192 %r4 to i64
store i64 %r5, i64* %r1
%r6 = lshr i192 %r4, 64
%r8 = getelementptr i64, i64* %r2, i32 1
%r9 = load i64, i64* %r8
%r10 = call i192 @mulUnit_inner128(i64* %r2, i64 %r9)
%r11 = add i192 %r6, %r10
%r13 = getelementptr i64, i64* %r1, i32 1
%r15 = getelementptr i64, i64* %r13, i32 0
%r16 = trunc i192 %r11 to i64
store i64 %r16, i64* %r15
%r17 = lshr i192 %r11, 64
%r19 = getelementptr i64, i64* %r13, i32 1
%r20 = trunc i192 %r17 to i64
store i64 %r20, i64* %r19
%r21 = lshr i192 %r17, 64
%r23 = getelementptr i64, i64* %r13, i32 2
%r24 = trunc i192 %r21 to i64
store i64 %r24, i64* %r23
ret void
}
define i256 @mulUnit_inner192(i64* noalias  %r2, i64 %r3)
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
define i64 @mclb_mulUnit3(i64* noalias  %r2, i64* noalias  %r3, i64 %r4)
{
%r5 = call i256 @mulUnit_inner192(i64* %r3, i64 %r4)
%r6 = trunc i256 %r5 to i192
%r8 = getelementptr i64, i64* %r2, i32 0
%r9 = trunc i192 %r6 to i64
store i64 %r9, i64* %r8
%r10 = lshr i192 %r6, 64
%r12 = getelementptr i64, i64* %r2, i32 1
%r13 = trunc i192 %r10 to i64
store i64 %r13, i64* %r12
%r14 = lshr i192 %r10, 64
%r16 = getelementptr i64, i64* %r2, i32 2
%r17 = trunc i192 %r14 to i64
store i64 %r17, i64* %r16
%r18 = lshr i256 %r5, 192
%r19 = trunc i256 %r18 to i64
ret i64 %r19
}
define i64 @mclb_mulUnitAdd3(i64* noalias  %r2, i64* noalias  %r3, i64 %r4)
{
%r6 = call i128 @mulPos64x64(i64* %r3, i64 %r4, i64 0)
%r7 = trunc i128 %r6 to i64
%r8 = call i64 @extractHigh64(i128 %r6)
%r10 = call i128 @mulPos64x64(i64* %r3, i64 %r4, i64 1)
%r11 = trunc i128 %r10 to i64
%r12 = call i64 @extractHigh64(i128 %r10)
%r14 = call i128 @mulPos64x64(i64* %r3, i64 %r4, i64 2)
%r15 = trunc i128 %r14 to i64
%r16 = call i64 @extractHigh64(i128 %r14)
%r17 = zext i64 %r7 to i128
%r18 = zext i64 %r11 to i128
%r19 = shl i128 %r18, 64
%r20 = or i128 %r17, %r19
%r21 = zext i128 %r20 to i192
%r22 = zext i64 %r15 to i192
%r23 = shl i192 %r22, 128
%r24 = or i192 %r21, %r23
%r25 = zext i64 %r8 to i128
%r26 = zext i64 %r12 to i128
%r27 = shl i128 %r26, 64
%r28 = or i128 %r25, %r27
%r29 = zext i128 %r28 to i192
%r30 = zext i64 %r16 to i192
%r31 = shl i192 %r30, 128
%r32 = or i192 %r29, %r31
%r33 = zext i192 %r24 to i256
%r34 = zext i192 %r32 to i256
%r35 = shl i256 %r34, 64
%r36 = add i256 %r33, %r35
%r38 = bitcast i64* %r2 to i192*
%r39 = load i192, i192* %r38
%r40 = zext i192 %r39 to i256
%r41 = add i256 %r36, %r40
%r42 = trunc i256 %r41 to i192
%r44 = getelementptr i64, i64* %r2, i32 0
%r45 = trunc i192 %r42 to i64
store i64 %r45, i64* %r44
%r46 = lshr i192 %r42, 64
%r48 = getelementptr i64, i64* %r2, i32 1
%r49 = trunc i192 %r46 to i64
store i64 %r49, i64* %r48
%r50 = lshr i192 %r46, 64
%r52 = getelementptr i64, i64* %r2, i32 2
%r53 = trunc i192 %r50 to i64
store i64 %r53, i64* %r52
%r54 = lshr i256 %r41, 192
%r55 = trunc i256 %r54 to i64
ret i64 %r55
}
define void @mclb_mul3(i64* noalias  %r1, i64* noalias  %r2, i64* noalias  %r3)
{
%r4 = load i64, i64* %r3
%r5 = call i256 @mulUnit_inner192(i64* %r2, i64 %r4)
%r6 = trunc i256 %r5 to i64
store i64 %r6, i64* %r1
%r7 = lshr i256 %r5, 64
%r9 = getelementptr i64, i64* %r3, i32 1
%r10 = load i64, i64* %r9
%r11 = call i256 @mulUnit_inner192(i64* %r2, i64 %r10)
%r12 = add i256 %r7, %r11
%r13 = trunc i256 %r12 to i64
%r15 = getelementptr i64, i64* %r1, i32 1
store i64 %r13, i64* %r15
%r16 = lshr i256 %r12, 64
%r18 = getelementptr i64, i64* %r3, i32 2
%r19 = load i64, i64* %r18
%r20 = call i256 @mulUnit_inner192(i64* %r2, i64 %r19)
%r21 = add i256 %r16, %r20
%r23 = getelementptr i64, i64* %r1, i32 2
%r25 = getelementptr i64, i64* %r23, i32 0
%r26 = trunc i256 %r21 to i64
store i64 %r26, i64* %r25
%r27 = lshr i256 %r21, 64
%r29 = getelementptr i64, i64* %r23, i32 1
%r30 = trunc i256 %r27 to i64
store i64 %r30, i64* %r29
%r31 = lshr i256 %r27, 64
%r33 = getelementptr i64, i64* %r23, i32 2
%r34 = trunc i256 %r31 to i64
store i64 %r34, i64* %r33
%r35 = lshr i256 %r31, 64
%r37 = getelementptr i64, i64* %r23, i32 3
%r38 = trunc i256 %r35 to i64
store i64 %r38, i64* %r37
ret void
}
define void @mclb_sqr3(i64* noalias  %r1, i64* noalias  %r2)
{
%r3 = load i64, i64* %r2
%r4 = call i256 @mulUnit_inner192(i64* %r2, i64 %r3)
%r5 = trunc i256 %r4 to i64
store i64 %r5, i64* %r1
%r6 = lshr i256 %r4, 64
%r8 = getelementptr i64, i64* %r2, i32 1
%r9 = load i64, i64* %r8
%r10 = call i256 @mulUnit_inner192(i64* %r2, i64 %r9)
%r11 = add i256 %r6, %r10
%r12 = trunc i256 %r11 to i64
%r14 = getelementptr i64, i64* %r1, i32 1
store i64 %r12, i64* %r14
%r15 = lshr i256 %r11, 64
%r17 = getelementptr i64, i64* %r2, i32 2
%r18 = load i64, i64* %r17
%r19 = call i256 @mulUnit_inner192(i64* %r2, i64 %r18)
%r20 = add i256 %r15, %r19
%r22 = getelementptr i64, i64* %r1, i32 2
%r24 = getelementptr i64, i64* %r22, i32 0
%r25 = trunc i256 %r20 to i64
store i64 %r25, i64* %r24
%r26 = lshr i256 %r20, 64
%r28 = getelementptr i64, i64* %r22, i32 1
%r29 = trunc i256 %r26 to i64
store i64 %r29, i64* %r28
%r30 = lshr i256 %r26, 64
%r32 = getelementptr i64, i64* %r22, i32 2
%r33 = trunc i256 %r30 to i64
store i64 %r33, i64* %r32
%r34 = lshr i256 %r30, 64
%r36 = getelementptr i64, i64* %r22, i32 3
%r37 = trunc i256 %r34 to i64
store i64 %r37, i64* %r36
ret void
}
define i320 @mulUnit_inner256(i64* noalias  %r2, i64 %r3)
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
define i64 @mclb_mulUnit4(i64* noalias  %r2, i64* noalias  %r3, i64 %r4)
{
%r5 = call i320 @mulUnit_inner256(i64* %r3, i64 %r4)
%r6 = trunc i320 %r5 to i256
%r8 = getelementptr i64, i64* %r2, i32 0
%r9 = trunc i256 %r6 to i64
store i64 %r9, i64* %r8
%r10 = lshr i256 %r6, 64
%r12 = getelementptr i64, i64* %r2, i32 1
%r13 = trunc i256 %r10 to i64
store i64 %r13, i64* %r12
%r14 = lshr i256 %r10, 64
%r16 = getelementptr i64, i64* %r2, i32 2
%r17 = trunc i256 %r14 to i64
store i64 %r17, i64* %r16
%r18 = lshr i256 %r14, 64
%r20 = getelementptr i64, i64* %r2, i32 3
%r21 = trunc i256 %r18 to i64
store i64 %r21, i64* %r20
%r22 = lshr i320 %r5, 256
%r23 = trunc i320 %r22 to i64
ret i64 %r23
}
define i64 @mclb_mulUnitAdd4(i64* noalias  %r2, i64* noalias  %r3, i64 %r4)
{
%r6 = call i128 @mulPos64x64(i64* %r3, i64 %r4, i64 0)
%r7 = trunc i128 %r6 to i64
%r8 = call i64 @extractHigh64(i128 %r6)
%r10 = call i128 @mulPos64x64(i64* %r3, i64 %r4, i64 1)
%r11 = trunc i128 %r10 to i64
%r12 = call i64 @extractHigh64(i128 %r10)
%r14 = call i128 @mulPos64x64(i64* %r3, i64 %r4, i64 2)
%r15 = trunc i128 %r14 to i64
%r16 = call i64 @extractHigh64(i128 %r14)
%r18 = call i128 @mulPos64x64(i64* %r3, i64 %r4, i64 3)
%r19 = trunc i128 %r18 to i64
%r20 = call i64 @extractHigh64(i128 %r18)
%r21 = zext i64 %r7 to i128
%r22 = zext i64 %r11 to i128
%r23 = shl i128 %r22, 64
%r24 = or i128 %r21, %r23
%r25 = zext i128 %r24 to i192
%r26 = zext i64 %r15 to i192
%r27 = shl i192 %r26, 128
%r28 = or i192 %r25, %r27
%r29 = zext i192 %r28 to i256
%r30 = zext i64 %r19 to i256
%r31 = shl i256 %r30, 192
%r32 = or i256 %r29, %r31
%r33 = zext i64 %r8 to i128
%r34 = zext i64 %r12 to i128
%r35 = shl i128 %r34, 64
%r36 = or i128 %r33, %r35
%r37 = zext i128 %r36 to i192
%r38 = zext i64 %r16 to i192
%r39 = shl i192 %r38, 128
%r40 = or i192 %r37, %r39
%r41 = zext i192 %r40 to i256
%r42 = zext i64 %r20 to i256
%r43 = shl i256 %r42, 192
%r44 = or i256 %r41, %r43
%r45 = zext i256 %r32 to i320
%r46 = zext i256 %r44 to i320
%r47 = shl i320 %r46, 64
%r48 = add i320 %r45, %r47
%r50 = bitcast i64* %r2 to i256*
%r51 = load i256, i256* %r50
%r52 = zext i256 %r51 to i320
%r53 = add i320 %r48, %r52
%r54 = trunc i320 %r53 to i256
%r56 = getelementptr i64, i64* %r2, i32 0
%r57 = trunc i256 %r54 to i64
store i64 %r57, i64* %r56
%r58 = lshr i256 %r54, 64
%r60 = getelementptr i64, i64* %r2, i32 1
%r61 = trunc i256 %r58 to i64
store i64 %r61, i64* %r60
%r62 = lshr i256 %r58, 64
%r64 = getelementptr i64, i64* %r2, i32 2
%r65 = trunc i256 %r62 to i64
store i64 %r65, i64* %r64
%r66 = lshr i256 %r62, 64
%r68 = getelementptr i64, i64* %r2, i32 3
%r69 = trunc i256 %r66 to i64
store i64 %r69, i64* %r68
%r70 = lshr i320 %r53, 256
%r71 = trunc i320 %r70 to i64
ret i64 %r71
}
define void @mclb_mul4(i64* noalias  %r1, i64* noalias  %r2, i64* noalias  %r3)
{
%r4 = load i64, i64* %r3
%r5 = call i320 @mulUnit_inner256(i64* %r2, i64 %r4)
%r6 = trunc i320 %r5 to i64
store i64 %r6, i64* %r1
%r7 = lshr i320 %r5, 64
%r9 = getelementptr i64, i64* %r3, i32 1
%r10 = load i64, i64* %r9
%r11 = call i320 @mulUnit_inner256(i64* %r2, i64 %r10)
%r12 = add i320 %r7, %r11
%r13 = trunc i320 %r12 to i64
%r15 = getelementptr i64, i64* %r1, i32 1
store i64 %r13, i64* %r15
%r16 = lshr i320 %r12, 64
%r18 = getelementptr i64, i64* %r3, i32 2
%r19 = load i64, i64* %r18
%r20 = call i320 @mulUnit_inner256(i64* %r2, i64 %r19)
%r21 = add i320 %r16, %r20
%r22 = trunc i320 %r21 to i64
%r24 = getelementptr i64, i64* %r1, i32 2
store i64 %r22, i64* %r24
%r25 = lshr i320 %r21, 64
%r27 = getelementptr i64, i64* %r3, i32 3
%r28 = load i64, i64* %r27
%r29 = call i320 @mulUnit_inner256(i64* %r2, i64 %r28)
%r30 = add i320 %r25, %r29
%r32 = getelementptr i64, i64* %r1, i32 3
%r34 = getelementptr i64, i64* %r32, i32 0
%r35 = trunc i320 %r30 to i64
store i64 %r35, i64* %r34
%r36 = lshr i320 %r30, 64
%r38 = getelementptr i64, i64* %r32, i32 1
%r39 = trunc i320 %r36 to i64
store i64 %r39, i64* %r38
%r40 = lshr i320 %r36, 64
%r42 = getelementptr i64, i64* %r32, i32 2
%r43 = trunc i320 %r40 to i64
store i64 %r43, i64* %r42
%r44 = lshr i320 %r40, 64
%r46 = getelementptr i64, i64* %r32, i32 3
%r47 = trunc i320 %r44 to i64
store i64 %r47, i64* %r46
%r48 = lshr i320 %r44, 64
%r50 = getelementptr i64, i64* %r32, i32 4
%r51 = trunc i320 %r48 to i64
store i64 %r51, i64* %r50
ret void
}
define void @mclb_sqr4(i64* noalias  %r1, i64* noalias  %r2)
{
%r3 = load i64, i64* %r2
%r4 = call i320 @mulUnit_inner256(i64* %r2, i64 %r3)
%r5 = trunc i320 %r4 to i64
store i64 %r5, i64* %r1
%r6 = lshr i320 %r4, 64
%r8 = getelementptr i64, i64* %r2, i32 1
%r9 = load i64, i64* %r8
%r10 = call i320 @mulUnit_inner256(i64* %r2, i64 %r9)
%r11 = add i320 %r6, %r10
%r12 = trunc i320 %r11 to i64
%r14 = getelementptr i64, i64* %r1, i32 1
store i64 %r12, i64* %r14
%r15 = lshr i320 %r11, 64
%r17 = getelementptr i64, i64* %r2, i32 2
%r18 = load i64, i64* %r17
%r19 = call i320 @mulUnit_inner256(i64* %r2, i64 %r18)
%r20 = add i320 %r15, %r19
%r21 = trunc i320 %r20 to i64
%r23 = getelementptr i64, i64* %r1, i32 2
store i64 %r21, i64* %r23
%r24 = lshr i320 %r20, 64
%r26 = getelementptr i64, i64* %r2, i32 3
%r27 = load i64, i64* %r26
%r28 = call i320 @mulUnit_inner256(i64* %r2, i64 %r27)
%r29 = add i320 %r24, %r28
%r31 = getelementptr i64, i64* %r1, i32 3
%r33 = getelementptr i64, i64* %r31, i32 0
%r34 = trunc i320 %r29 to i64
store i64 %r34, i64* %r33
%r35 = lshr i320 %r29, 64
%r37 = getelementptr i64, i64* %r31, i32 1
%r38 = trunc i320 %r35 to i64
store i64 %r38, i64* %r37
%r39 = lshr i320 %r35, 64
%r41 = getelementptr i64, i64* %r31, i32 2
%r42 = trunc i320 %r39 to i64
store i64 %r42, i64* %r41
%r43 = lshr i320 %r39, 64
%r45 = getelementptr i64, i64* %r31, i32 3
%r46 = trunc i320 %r43 to i64
store i64 %r46, i64* %r45
%r47 = lshr i320 %r43, 64
%r49 = getelementptr i64, i64* %r31, i32 4
%r50 = trunc i320 %r47 to i64
store i64 %r50, i64* %r49
ret void
}
define i384 @mulUnit_inner320(i64* noalias  %r2, i64 %r3)
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
define i64 @mclb_mulUnit5(i64* noalias  %r2, i64* noalias  %r3, i64 %r4)
{
%r5 = call i384 @mulUnit_inner320(i64* %r3, i64 %r4)
%r6 = trunc i384 %r5 to i320
%r8 = getelementptr i64, i64* %r2, i32 0
%r9 = trunc i320 %r6 to i64
store i64 %r9, i64* %r8
%r10 = lshr i320 %r6, 64
%r12 = getelementptr i64, i64* %r2, i32 1
%r13 = trunc i320 %r10 to i64
store i64 %r13, i64* %r12
%r14 = lshr i320 %r10, 64
%r16 = getelementptr i64, i64* %r2, i32 2
%r17 = trunc i320 %r14 to i64
store i64 %r17, i64* %r16
%r18 = lshr i320 %r14, 64
%r20 = getelementptr i64, i64* %r2, i32 3
%r21 = trunc i320 %r18 to i64
store i64 %r21, i64* %r20
%r22 = lshr i320 %r18, 64
%r24 = getelementptr i64, i64* %r2, i32 4
%r25 = trunc i320 %r22 to i64
store i64 %r25, i64* %r24
%r26 = lshr i384 %r5, 320
%r27 = trunc i384 %r26 to i64
ret i64 %r27
}
define i64 @mclb_mulUnitAdd5(i64* noalias  %r2, i64* noalias  %r3, i64 %r4)
{
%r6 = call i128 @mulPos64x64(i64* %r3, i64 %r4, i64 0)
%r7 = trunc i128 %r6 to i64
%r8 = call i64 @extractHigh64(i128 %r6)
%r10 = call i128 @mulPos64x64(i64* %r3, i64 %r4, i64 1)
%r11 = trunc i128 %r10 to i64
%r12 = call i64 @extractHigh64(i128 %r10)
%r14 = call i128 @mulPos64x64(i64* %r3, i64 %r4, i64 2)
%r15 = trunc i128 %r14 to i64
%r16 = call i64 @extractHigh64(i128 %r14)
%r18 = call i128 @mulPos64x64(i64* %r3, i64 %r4, i64 3)
%r19 = trunc i128 %r18 to i64
%r20 = call i64 @extractHigh64(i128 %r18)
%r22 = call i128 @mulPos64x64(i64* %r3, i64 %r4, i64 4)
%r23 = trunc i128 %r22 to i64
%r24 = call i64 @extractHigh64(i128 %r22)
%r25 = zext i64 %r7 to i128
%r26 = zext i64 %r11 to i128
%r27 = shl i128 %r26, 64
%r28 = or i128 %r25, %r27
%r29 = zext i128 %r28 to i192
%r30 = zext i64 %r15 to i192
%r31 = shl i192 %r30, 128
%r32 = or i192 %r29, %r31
%r33 = zext i192 %r32 to i256
%r34 = zext i64 %r19 to i256
%r35 = shl i256 %r34, 192
%r36 = or i256 %r33, %r35
%r37 = zext i256 %r36 to i320
%r38 = zext i64 %r23 to i320
%r39 = shl i320 %r38, 256
%r40 = or i320 %r37, %r39
%r41 = zext i64 %r8 to i128
%r42 = zext i64 %r12 to i128
%r43 = shl i128 %r42, 64
%r44 = or i128 %r41, %r43
%r45 = zext i128 %r44 to i192
%r46 = zext i64 %r16 to i192
%r47 = shl i192 %r46, 128
%r48 = or i192 %r45, %r47
%r49 = zext i192 %r48 to i256
%r50 = zext i64 %r20 to i256
%r51 = shl i256 %r50, 192
%r52 = or i256 %r49, %r51
%r53 = zext i256 %r52 to i320
%r54 = zext i64 %r24 to i320
%r55 = shl i320 %r54, 256
%r56 = or i320 %r53, %r55
%r57 = zext i320 %r40 to i384
%r58 = zext i320 %r56 to i384
%r59 = shl i384 %r58, 64
%r60 = add i384 %r57, %r59
%r62 = bitcast i64* %r2 to i320*
%r63 = load i320, i320* %r62
%r64 = zext i320 %r63 to i384
%r65 = add i384 %r60, %r64
%r66 = trunc i384 %r65 to i320
%r68 = getelementptr i64, i64* %r2, i32 0
%r69 = trunc i320 %r66 to i64
store i64 %r69, i64* %r68
%r70 = lshr i320 %r66, 64
%r72 = getelementptr i64, i64* %r2, i32 1
%r73 = trunc i320 %r70 to i64
store i64 %r73, i64* %r72
%r74 = lshr i320 %r70, 64
%r76 = getelementptr i64, i64* %r2, i32 2
%r77 = trunc i320 %r74 to i64
store i64 %r77, i64* %r76
%r78 = lshr i320 %r74, 64
%r80 = getelementptr i64, i64* %r2, i32 3
%r81 = trunc i320 %r78 to i64
store i64 %r81, i64* %r80
%r82 = lshr i320 %r78, 64
%r84 = getelementptr i64, i64* %r2, i32 4
%r85 = trunc i320 %r82 to i64
store i64 %r85, i64* %r84
%r86 = lshr i384 %r65, 320
%r87 = trunc i384 %r86 to i64
ret i64 %r87
}
define void @mclb_mul5(i64* noalias  %r1, i64* noalias  %r2, i64* noalias  %r3)
{
%r4 = load i64, i64* %r3
%r5 = call i384 @mulUnit_inner320(i64* %r2, i64 %r4)
%r6 = trunc i384 %r5 to i64
store i64 %r6, i64* %r1
%r7 = lshr i384 %r5, 64
%r9 = getelementptr i64, i64* %r3, i32 1
%r10 = load i64, i64* %r9
%r11 = call i384 @mulUnit_inner320(i64* %r2, i64 %r10)
%r12 = add i384 %r7, %r11
%r13 = trunc i384 %r12 to i64
%r15 = getelementptr i64, i64* %r1, i32 1
store i64 %r13, i64* %r15
%r16 = lshr i384 %r12, 64
%r18 = getelementptr i64, i64* %r3, i32 2
%r19 = load i64, i64* %r18
%r20 = call i384 @mulUnit_inner320(i64* %r2, i64 %r19)
%r21 = add i384 %r16, %r20
%r22 = trunc i384 %r21 to i64
%r24 = getelementptr i64, i64* %r1, i32 2
store i64 %r22, i64* %r24
%r25 = lshr i384 %r21, 64
%r27 = getelementptr i64, i64* %r3, i32 3
%r28 = load i64, i64* %r27
%r29 = call i384 @mulUnit_inner320(i64* %r2, i64 %r28)
%r30 = add i384 %r25, %r29
%r31 = trunc i384 %r30 to i64
%r33 = getelementptr i64, i64* %r1, i32 3
store i64 %r31, i64* %r33
%r34 = lshr i384 %r30, 64
%r36 = getelementptr i64, i64* %r3, i32 4
%r37 = load i64, i64* %r36
%r38 = call i384 @mulUnit_inner320(i64* %r2, i64 %r37)
%r39 = add i384 %r34, %r38
%r41 = getelementptr i64, i64* %r1, i32 4
%r43 = getelementptr i64, i64* %r41, i32 0
%r44 = trunc i384 %r39 to i64
store i64 %r44, i64* %r43
%r45 = lshr i384 %r39, 64
%r47 = getelementptr i64, i64* %r41, i32 1
%r48 = trunc i384 %r45 to i64
store i64 %r48, i64* %r47
%r49 = lshr i384 %r45, 64
%r51 = getelementptr i64, i64* %r41, i32 2
%r52 = trunc i384 %r49 to i64
store i64 %r52, i64* %r51
%r53 = lshr i384 %r49, 64
%r55 = getelementptr i64, i64* %r41, i32 3
%r56 = trunc i384 %r53 to i64
store i64 %r56, i64* %r55
%r57 = lshr i384 %r53, 64
%r59 = getelementptr i64, i64* %r41, i32 4
%r60 = trunc i384 %r57 to i64
store i64 %r60, i64* %r59
%r61 = lshr i384 %r57, 64
%r63 = getelementptr i64, i64* %r41, i32 5
%r64 = trunc i384 %r61 to i64
store i64 %r64, i64* %r63
ret void
}
define void @mclb_sqr5(i64* noalias  %r1, i64* noalias  %r2)
{
%r3 = load i64, i64* %r2
%r4 = call i384 @mulUnit_inner320(i64* %r2, i64 %r3)
%r5 = trunc i384 %r4 to i64
store i64 %r5, i64* %r1
%r6 = lshr i384 %r4, 64
%r8 = getelementptr i64, i64* %r2, i32 1
%r9 = load i64, i64* %r8
%r10 = call i384 @mulUnit_inner320(i64* %r2, i64 %r9)
%r11 = add i384 %r6, %r10
%r12 = trunc i384 %r11 to i64
%r14 = getelementptr i64, i64* %r1, i32 1
store i64 %r12, i64* %r14
%r15 = lshr i384 %r11, 64
%r17 = getelementptr i64, i64* %r2, i32 2
%r18 = load i64, i64* %r17
%r19 = call i384 @mulUnit_inner320(i64* %r2, i64 %r18)
%r20 = add i384 %r15, %r19
%r21 = trunc i384 %r20 to i64
%r23 = getelementptr i64, i64* %r1, i32 2
store i64 %r21, i64* %r23
%r24 = lshr i384 %r20, 64
%r26 = getelementptr i64, i64* %r2, i32 3
%r27 = load i64, i64* %r26
%r28 = call i384 @mulUnit_inner320(i64* %r2, i64 %r27)
%r29 = add i384 %r24, %r28
%r30 = trunc i384 %r29 to i64
%r32 = getelementptr i64, i64* %r1, i32 3
store i64 %r30, i64* %r32
%r33 = lshr i384 %r29, 64
%r35 = getelementptr i64, i64* %r2, i32 4
%r36 = load i64, i64* %r35
%r37 = call i384 @mulUnit_inner320(i64* %r2, i64 %r36)
%r38 = add i384 %r33, %r37
%r40 = getelementptr i64, i64* %r1, i32 4
%r42 = getelementptr i64, i64* %r40, i32 0
%r43 = trunc i384 %r38 to i64
store i64 %r43, i64* %r42
%r44 = lshr i384 %r38, 64
%r46 = getelementptr i64, i64* %r40, i32 1
%r47 = trunc i384 %r44 to i64
store i64 %r47, i64* %r46
%r48 = lshr i384 %r44, 64
%r50 = getelementptr i64, i64* %r40, i32 2
%r51 = trunc i384 %r48 to i64
store i64 %r51, i64* %r50
%r52 = lshr i384 %r48, 64
%r54 = getelementptr i64, i64* %r40, i32 3
%r55 = trunc i384 %r52 to i64
store i64 %r55, i64* %r54
%r56 = lshr i384 %r52, 64
%r58 = getelementptr i64, i64* %r40, i32 4
%r59 = trunc i384 %r56 to i64
store i64 %r59, i64* %r58
%r60 = lshr i384 %r56, 64
%r62 = getelementptr i64, i64* %r40, i32 5
%r63 = trunc i384 %r60 to i64
store i64 %r63, i64* %r62
ret void
}
define i448 @mulUnit_inner384(i64* noalias  %r2, i64 %r3)
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
define i64 @mclb_mulUnit6(i64* noalias  %r2, i64* noalias  %r3, i64 %r4)
{
%r5 = call i448 @mulUnit_inner384(i64* %r3, i64 %r4)
%r6 = trunc i448 %r5 to i384
%r8 = getelementptr i64, i64* %r2, i32 0
%r9 = trunc i384 %r6 to i64
store i64 %r9, i64* %r8
%r10 = lshr i384 %r6, 64
%r12 = getelementptr i64, i64* %r2, i32 1
%r13 = trunc i384 %r10 to i64
store i64 %r13, i64* %r12
%r14 = lshr i384 %r10, 64
%r16 = getelementptr i64, i64* %r2, i32 2
%r17 = trunc i384 %r14 to i64
store i64 %r17, i64* %r16
%r18 = lshr i384 %r14, 64
%r20 = getelementptr i64, i64* %r2, i32 3
%r21 = trunc i384 %r18 to i64
store i64 %r21, i64* %r20
%r22 = lshr i384 %r18, 64
%r24 = getelementptr i64, i64* %r2, i32 4
%r25 = trunc i384 %r22 to i64
store i64 %r25, i64* %r24
%r26 = lshr i384 %r22, 64
%r28 = getelementptr i64, i64* %r2, i32 5
%r29 = trunc i384 %r26 to i64
store i64 %r29, i64* %r28
%r30 = lshr i448 %r5, 384
%r31 = trunc i448 %r30 to i64
ret i64 %r31
}
define i64 @mclb_mulUnitAdd6(i64* noalias  %r2, i64* noalias  %r3, i64 %r4)
{
%r6 = call i128 @mulPos64x64(i64* %r3, i64 %r4, i64 0)
%r7 = trunc i128 %r6 to i64
%r8 = call i64 @extractHigh64(i128 %r6)
%r10 = call i128 @mulPos64x64(i64* %r3, i64 %r4, i64 1)
%r11 = trunc i128 %r10 to i64
%r12 = call i64 @extractHigh64(i128 %r10)
%r14 = call i128 @mulPos64x64(i64* %r3, i64 %r4, i64 2)
%r15 = trunc i128 %r14 to i64
%r16 = call i64 @extractHigh64(i128 %r14)
%r18 = call i128 @mulPos64x64(i64* %r3, i64 %r4, i64 3)
%r19 = trunc i128 %r18 to i64
%r20 = call i64 @extractHigh64(i128 %r18)
%r22 = call i128 @mulPos64x64(i64* %r3, i64 %r4, i64 4)
%r23 = trunc i128 %r22 to i64
%r24 = call i64 @extractHigh64(i128 %r22)
%r26 = call i128 @mulPos64x64(i64* %r3, i64 %r4, i64 5)
%r27 = trunc i128 %r26 to i64
%r28 = call i64 @extractHigh64(i128 %r26)
%r29 = zext i64 %r7 to i128
%r30 = zext i64 %r11 to i128
%r31 = shl i128 %r30, 64
%r32 = or i128 %r29, %r31
%r33 = zext i128 %r32 to i192
%r34 = zext i64 %r15 to i192
%r35 = shl i192 %r34, 128
%r36 = or i192 %r33, %r35
%r37 = zext i192 %r36 to i256
%r38 = zext i64 %r19 to i256
%r39 = shl i256 %r38, 192
%r40 = or i256 %r37, %r39
%r41 = zext i256 %r40 to i320
%r42 = zext i64 %r23 to i320
%r43 = shl i320 %r42, 256
%r44 = or i320 %r41, %r43
%r45 = zext i320 %r44 to i384
%r46 = zext i64 %r27 to i384
%r47 = shl i384 %r46, 320
%r48 = or i384 %r45, %r47
%r49 = zext i64 %r8 to i128
%r50 = zext i64 %r12 to i128
%r51 = shl i128 %r50, 64
%r52 = or i128 %r49, %r51
%r53 = zext i128 %r52 to i192
%r54 = zext i64 %r16 to i192
%r55 = shl i192 %r54, 128
%r56 = or i192 %r53, %r55
%r57 = zext i192 %r56 to i256
%r58 = zext i64 %r20 to i256
%r59 = shl i256 %r58, 192
%r60 = or i256 %r57, %r59
%r61 = zext i256 %r60 to i320
%r62 = zext i64 %r24 to i320
%r63 = shl i320 %r62, 256
%r64 = or i320 %r61, %r63
%r65 = zext i320 %r64 to i384
%r66 = zext i64 %r28 to i384
%r67 = shl i384 %r66, 320
%r68 = or i384 %r65, %r67
%r69 = zext i384 %r48 to i448
%r70 = zext i384 %r68 to i448
%r71 = shl i448 %r70, 64
%r72 = add i448 %r69, %r71
%r74 = bitcast i64* %r2 to i384*
%r75 = load i384, i384* %r74
%r76 = zext i384 %r75 to i448
%r77 = add i448 %r72, %r76
%r78 = trunc i448 %r77 to i384
%r80 = getelementptr i64, i64* %r2, i32 0
%r81 = trunc i384 %r78 to i64
store i64 %r81, i64* %r80
%r82 = lshr i384 %r78, 64
%r84 = getelementptr i64, i64* %r2, i32 1
%r85 = trunc i384 %r82 to i64
store i64 %r85, i64* %r84
%r86 = lshr i384 %r82, 64
%r88 = getelementptr i64, i64* %r2, i32 2
%r89 = trunc i384 %r86 to i64
store i64 %r89, i64* %r88
%r90 = lshr i384 %r86, 64
%r92 = getelementptr i64, i64* %r2, i32 3
%r93 = trunc i384 %r90 to i64
store i64 %r93, i64* %r92
%r94 = lshr i384 %r90, 64
%r96 = getelementptr i64, i64* %r2, i32 4
%r97 = trunc i384 %r94 to i64
store i64 %r97, i64* %r96
%r98 = lshr i384 %r94, 64
%r100 = getelementptr i64, i64* %r2, i32 5
%r101 = trunc i384 %r98 to i64
store i64 %r101, i64* %r100
%r102 = lshr i448 %r77, 384
%r103 = trunc i448 %r102 to i64
ret i64 %r103
}
define void @mclb_mul6(i64* noalias  %r1, i64* noalias  %r2, i64* noalias  %r3)
{
%r4 = load i64, i64* %r3
%r5 = call i448 @mulUnit_inner384(i64* %r2, i64 %r4)
%r6 = trunc i448 %r5 to i64
store i64 %r6, i64* %r1
%r7 = lshr i448 %r5, 64
%r9 = getelementptr i64, i64* %r3, i32 1
%r10 = load i64, i64* %r9
%r11 = call i448 @mulUnit_inner384(i64* %r2, i64 %r10)
%r12 = add i448 %r7, %r11
%r13 = trunc i448 %r12 to i64
%r15 = getelementptr i64, i64* %r1, i32 1
store i64 %r13, i64* %r15
%r16 = lshr i448 %r12, 64
%r18 = getelementptr i64, i64* %r3, i32 2
%r19 = load i64, i64* %r18
%r20 = call i448 @mulUnit_inner384(i64* %r2, i64 %r19)
%r21 = add i448 %r16, %r20
%r22 = trunc i448 %r21 to i64
%r24 = getelementptr i64, i64* %r1, i32 2
store i64 %r22, i64* %r24
%r25 = lshr i448 %r21, 64
%r27 = getelementptr i64, i64* %r3, i32 3
%r28 = load i64, i64* %r27
%r29 = call i448 @mulUnit_inner384(i64* %r2, i64 %r28)
%r30 = add i448 %r25, %r29
%r31 = trunc i448 %r30 to i64
%r33 = getelementptr i64, i64* %r1, i32 3
store i64 %r31, i64* %r33
%r34 = lshr i448 %r30, 64
%r36 = getelementptr i64, i64* %r3, i32 4
%r37 = load i64, i64* %r36
%r38 = call i448 @mulUnit_inner384(i64* %r2, i64 %r37)
%r39 = add i448 %r34, %r38
%r40 = trunc i448 %r39 to i64
%r42 = getelementptr i64, i64* %r1, i32 4
store i64 %r40, i64* %r42
%r43 = lshr i448 %r39, 64
%r45 = getelementptr i64, i64* %r3, i32 5
%r46 = load i64, i64* %r45
%r47 = call i448 @mulUnit_inner384(i64* %r2, i64 %r46)
%r48 = add i448 %r43, %r47
%r50 = getelementptr i64, i64* %r1, i32 5
%r52 = getelementptr i64, i64* %r50, i32 0
%r53 = trunc i448 %r48 to i64
store i64 %r53, i64* %r52
%r54 = lshr i448 %r48, 64
%r56 = getelementptr i64, i64* %r50, i32 1
%r57 = trunc i448 %r54 to i64
store i64 %r57, i64* %r56
%r58 = lshr i448 %r54, 64
%r60 = getelementptr i64, i64* %r50, i32 2
%r61 = trunc i448 %r58 to i64
store i64 %r61, i64* %r60
%r62 = lshr i448 %r58, 64
%r64 = getelementptr i64, i64* %r50, i32 3
%r65 = trunc i448 %r62 to i64
store i64 %r65, i64* %r64
%r66 = lshr i448 %r62, 64
%r68 = getelementptr i64, i64* %r50, i32 4
%r69 = trunc i448 %r66 to i64
store i64 %r69, i64* %r68
%r70 = lshr i448 %r66, 64
%r72 = getelementptr i64, i64* %r50, i32 5
%r73 = trunc i448 %r70 to i64
store i64 %r73, i64* %r72
%r74 = lshr i448 %r70, 64
%r76 = getelementptr i64, i64* %r50, i32 6
%r77 = trunc i448 %r74 to i64
store i64 %r77, i64* %r76
ret void
}
define void @mclb_sqr6(i64* noalias  %r1, i64* noalias  %r2)
{
%r3 = load i64, i64* %r2
%r4 = call i448 @mulUnit_inner384(i64* %r2, i64 %r3)
%r5 = trunc i448 %r4 to i64
store i64 %r5, i64* %r1
%r6 = lshr i448 %r4, 64
%r8 = getelementptr i64, i64* %r2, i32 1
%r9 = load i64, i64* %r8
%r10 = call i448 @mulUnit_inner384(i64* %r2, i64 %r9)
%r11 = add i448 %r6, %r10
%r12 = trunc i448 %r11 to i64
%r14 = getelementptr i64, i64* %r1, i32 1
store i64 %r12, i64* %r14
%r15 = lshr i448 %r11, 64
%r17 = getelementptr i64, i64* %r2, i32 2
%r18 = load i64, i64* %r17
%r19 = call i448 @mulUnit_inner384(i64* %r2, i64 %r18)
%r20 = add i448 %r15, %r19
%r21 = trunc i448 %r20 to i64
%r23 = getelementptr i64, i64* %r1, i32 2
store i64 %r21, i64* %r23
%r24 = lshr i448 %r20, 64
%r26 = getelementptr i64, i64* %r2, i32 3
%r27 = load i64, i64* %r26
%r28 = call i448 @mulUnit_inner384(i64* %r2, i64 %r27)
%r29 = add i448 %r24, %r28
%r30 = trunc i448 %r29 to i64
%r32 = getelementptr i64, i64* %r1, i32 3
store i64 %r30, i64* %r32
%r33 = lshr i448 %r29, 64
%r35 = getelementptr i64, i64* %r2, i32 4
%r36 = load i64, i64* %r35
%r37 = call i448 @mulUnit_inner384(i64* %r2, i64 %r36)
%r38 = add i448 %r33, %r37
%r39 = trunc i448 %r38 to i64
%r41 = getelementptr i64, i64* %r1, i32 4
store i64 %r39, i64* %r41
%r42 = lshr i448 %r38, 64
%r44 = getelementptr i64, i64* %r2, i32 5
%r45 = load i64, i64* %r44
%r46 = call i448 @mulUnit_inner384(i64* %r2, i64 %r45)
%r47 = add i448 %r42, %r46
%r49 = getelementptr i64, i64* %r1, i32 5
%r51 = getelementptr i64, i64* %r49, i32 0
%r52 = trunc i448 %r47 to i64
store i64 %r52, i64* %r51
%r53 = lshr i448 %r47, 64
%r55 = getelementptr i64, i64* %r49, i32 1
%r56 = trunc i448 %r53 to i64
store i64 %r56, i64* %r55
%r57 = lshr i448 %r53, 64
%r59 = getelementptr i64, i64* %r49, i32 2
%r60 = trunc i448 %r57 to i64
store i64 %r60, i64* %r59
%r61 = lshr i448 %r57, 64
%r63 = getelementptr i64, i64* %r49, i32 3
%r64 = trunc i448 %r61 to i64
store i64 %r64, i64* %r63
%r65 = lshr i448 %r61, 64
%r67 = getelementptr i64, i64* %r49, i32 4
%r68 = trunc i448 %r65 to i64
store i64 %r68, i64* %r67
%r69 = lshr i448 %r65, 64
%r71 = getelementptr i64, i64* %r49, i32 5
%r72 = trunc i448 %r69 to i64
store i64 %r72, i64* %r71
%r73 = lshr i448 %r69, 64
%r75 = getelementptr i64, i64* %r49, i32 6
%r76 = trunc i448 %r73 to i64
store i64 %r76, i64* %r75
ret void
}
define i512 @mulUnit_inner448(i64* noalias  %r2, i64 %r3)
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
define i64 @mclb_mulUnit7(i64* noalias  %r2, i64* noalias  %r3, i64 %r4)
{
%r5 = call i512 @mulUnit_inner448(i64* %r3, i64 %r4)
%r6 = trunc i512 %r5 to i448
%r8 = getelementptr i64, i64* %r2, i32 0
%r9 = trunc i448 %r6 to i64
store i64 %r9, i64* %r8
%r10 = lshr i448 %r6, 64
%r12 = getelementptr i64, i64* %r2, i32 1
%r13 = trunc i448 %r10 to i64
store i64 %r13, i64* %r12
%r14 = lshr i448 %r10, 64
%r16 = getelementptr i64, i64* %r2, i32 2
%r17 = trunc i448 %r14 to i64
store i64 %r17, i64* %r16
%r18 = lshr i448 %r14, 64
%r20 = getelementptr i64, i64* %r2, i32 3
%r21 = trunc i448 %r18 to i64
store i64 %r21, i64* %r20
%r22 = lshr i448 %r18, 64
%r24 = getelementptr i64, i64* %r2, i32 4
%r25 = trunc i448 %r22 to i64
store i64 %r25, i64* %r24
%r26 = lshr i448 %r22, 64
%r28 = getelementptr i64, i64* %r2, i32 5
%r29 = trunc i448 %r26 to i64
store i64 %r29, i64* %r28
%r30 = lshr i448 %r26, 64
%r32 = getelementptr i64, i64* %r2, i32 6
%r33 = trunc i448 %r30 to i64
store i64 %r33, i64* %r32
%r34 = lshr i512 %r5, 448
%r35 = trunc i512 %r34 to i64
ret i64 %r35
}
define i64 @mclb_mulUnitAdd7(i64* noalias  %r2, i64* noalias  %r3, i64 %r4)
{
%r6 = call i128 @mulPos64x64(i64* %r3, i64 %r4, i64 0)
%r7 = trunc i128 %r6 to i64
%r8 = call i64 @extractHigh64(i128 %r6)
%r10 = call i128 @mulPos64x64(i64* %r3, i64 %r4, i64 1)
%r11 = trunc i128 %r10 to i64
%r12 = call i64 @extractHigh64(i128 %r10)
%r14 = call i128 @mulPos64x64(i64* %r3, i64 %r4, i64 2)
%r15 = trunc i128 %r14 to i64
%r16 = call i64 @extractHigh64(i128 %r14)
%r18 = call i128 @mulPos64x64(i64* %r3, i64 %r4, i64 3)
%r19 = trunc i128 %r18 to i64
%r20 = call i64 @extractHigh64(i128 %r18)
%r22 = call i128 @mulPos64x64(i64* %r3, i64 %r4, i64 4)
%r23 = trunc i128 %r22 to i64
%r24 = call i64 @extractHigh64(i128 %r22)
%r26 = call i128 @mulPos64x64(i64* %r3, i64 %r4, i64 5)
%r27 = trunc i128 %r26 to i64
%r28 = call i64 @extractHigh64(i128 %r26)
%r30 = call i128 @mulPos64x64(i64* %r3, i64 %r4, i64 6)
%r31 = trunc i128 %r30 to i64
%r32 = call i64 @extractHigh64(i128 %r30)
%r33 = zext i64 %r7 to i128
%r34 = zext i64 %r11 to i128
%r35 = shl i128 %r34, 64
%r36 = or i128 %r33, %r35
%r37 = zext i128 %r36 to i192
%r38 = zext i64 %r15 to i192
%r39 = shl i192 %r38, 128
%r40 = or i192 %r37, %r39
%r41 = zext i192 %r40 to i256
%r42 = zext i64 %r19 to i256
%r43 = shl i256 %r42, 192
%r44 = or i256 %r41, %r43
%r45 = zext i256 %r44 to i320
%r46 = zext i64 %r23 to i320
%r47 = shl i320 %r46, 256
%r48 = or i320 %r45, %r47
%r49 = zext i320 %r48 to i384
%r50 = zext i64 %r27 to i384
%r51 = shl i384 %r50, 320
%r52 = or i384 %r49, %r51
%r53 = zext i384 %r52 to i448
%r54 = zext i64 %r31 to i448
%r55 = shl i448 %r54, 384
%r56 = or i448 %r53, %r55
%r57 = zext i64 %r8 to i128
%r58 = zext i64 %r12 to i128
%r59 = shl i128 %r58, 64
%r60 = or i128 %r57, %r59
%r61 = zext i128 %r60 to i192
%r62 = zext i64 %r16 to i192
%r63 = shl i192 %r62, 128
%r64 = or i192 %r61, %r63
%r65 = zext i192 %r64 to i256
%r66 = zext i64 %r20 to i256
%r67 = shl i256 %r66, 192
%r68 = or i256 %r65, %r67
%r69 = zext i256 %r68 to i320
%r70 = zext i64 %r24 to i320
%r71 = shl i320 %r70, 256
%r72 = or i320 %r69, %r71
%r73 = zext i320 %r72 to i384
%r74 = zext i64 %r28 to i384
%r75 = shl i384 %r74, 320
%r76 = or i384 %r73, %r75
%r77 = zext i384 %r76 to i448
%r78 = zext i64 %r32 to i448
%r79 = shl i448 %r78, 384
%r80 = or i448 %r77, %r79
%r81 = zext i448 %r56 to i512
%r82 = zext i448 %r80 to i512
%r83 = shl i512 %r82, 64
%r84 = add i512 %r81, %r83
%r86 = bitcast i64* %r2 to i448*
%r87 = load i448, i448* %r86
%r88 = zext i448 %r87 to i512
%r89 = add i512 %r84, %r88
%r90 = trunc i512 %r89 to i448
%r92 = getelementptr i64, i64* %r2, i32 0
%r93 = trunc i448 %r90 to i64
store i64 %r93, i64* %r92
%r94 = lshr i448 %r90, 64
%r96 = getelementptr i64, i64* %r2, i32 1
%r97 = trunc i448 %r94 to i64
store i64 %r97, i64* %r96
%r98 = lshr i448 %r94, 64
%r100 = getelementptr i64, i64* %r2, i32 2
%r101 = trunc i448 %r98 to i64
store i64 %r101, i64* %r100
%r102 = lshr i448 %r98, 64
%r104 = getelementptr i64, i64* %r2, i32 3
%r105 = trunc i448 %r102 to i64
store i64 %r105, i64* %r104
%r106 = lshr i448 %r102, 64
%r108 = getelementptr i64, i64* %r2, i32 4
%r109 = trunc i448 %r106 to i64
store i64 %r109, i64* %r108
%r110 = lshr i448 %r106, 64
%r112 = getelementptr i64, i64* %r2, i32 5
%r113 = trunc i448 %r110 to i64
store i64 %r113, i64* %r112
%r114 = lshr i448 %r110, 64
%r116 = getelementptr i64, i64* %r2, i32 6
%r117 = trunc i448 %r114 to i64
store i64 %r117, i64* %r116
%r118 = lshr i512 %r89, 448
%r119 = trunc i512 %r118 to i64
ret i64 %r119
}
define void @mclb_mul7(i64* noalias  %r1, i64* noalias  %r2, i64* noalias  %r3)
{
%r4 = load i64, i64* %r3
%r5 = call i512 @mulUnit_inner448(i64* %r2, i64 %r4)
%r6 = trunc i512 %r5 to i64
store i64 %r6, i64* %r1
%r7 = lshr i512 %r5, 64
%r9 = getelementptr i64, i64* %r3, i32 1
%r10 = load i64, i64* %r9
%r11 = call i512 @mulUnit_inner448(i64* %r2, i64 %r10)
%r12 = add i512 %r7, %r11
%r13 = trunc i512 %r12 to i64
%r15 = getelementptr i64, i64* %r1, i32 1
store i64 %r13, i64* %r15
%r16 = lshr i512 %r12, 64
%r18 = getelementptr i64, i64* %r3, i32 2
%r19 = load i64, i64* %r18
%r20 = call i512 @mulUnit_inner448(i64* %r2, i64 %r19)
%r21 = add i512 %r16, %r20
%r22 = trunc i512 %r21 to i64
%r24 = getelementptr i64, i64* %r1, i32 2
store i64 %r22, i64* %r24
%r25 = lshr i512 %r21, 64
%r27 = getelementptr i64, i64* %r3, i32 3
%r28 = load i64, i64* %r27
%r29 = call i512 @mulUnit_inner448(i64* %r2, i64 %r28)
%r30 = add i512 %r25, %r29
%r31 = trunc i512 %r30 to i64
%r33 = getelementptr i64, i64* %r1, i32 3
store i64 %r31, i64* %r33
%r34 = lshr i512 %r30, 64
%r36 = getelementptr i64, i64* %r3, i32 4
%r37 = load i64, i64* %r36
%r38 = call i512 @mulUnit_inner448(i64* %r2, i64 %r37)
%r39 = add i512 %r34, %r38
%r40 = trunc i512 %r39 to i64
%r42 = getelementptr i64, i64* %r1, i32 4
store i64 %r40, i64* %r42
%r43 = lshr i512 %r39, 64
%r45 = getelementptr i64, i64* %r3, i32 5
%r46 = load i64, i64* %r45
%r47 = call i512 @mulUnit_inner448(i64* %r2, i64 %r46)
%r48 = add i512 %r43, %r47
%r49 = trunc i512 %r48 to i64
%r51 = getelementptr i64, i64* %r1, i32 5
store i64 %r49, i64* %r51
%r52 = lshr i512 %r48, 64
%r54 = getelementptr i64, i64* %r3, i32 6
%r55 = load i64, i64* %r54
%r56 = call i512 @mulUnit_inner448(i64* %r2, i64 %r55)
%r57 = add i512 %r52, %r56
%r59 = getelementptr i64, i64* %r1, i32 6
%r61 = getelementptr i64, i64* %r59, i32 0
%r62 = trunc i512 %r57 to i64
store i64 %r62, i64* %r61
%r63 = lshr i512 %r57, 64
%r65 = getelementptr i64, i64* %r59, i32 1
%r66 = trunc i512 %r63 to i64
store i64 %r66, i64* %r65
%r67 = lshr i512 %r63, 64
%r69 = getelementptr i64, i64* %r59, i32 2
%r70 = trunc i512 %r67 to i64
store i64 %r70, i64* %r69
%r71 = lshr i512 %r67, 64
%r73 = getelementptr i64, i64* %r59, i32 3
%r74 = trunc i512 %r71 to i64
store i64 %r74, i64* %r73
%r75 = lshr i512 %r71, 64
%r77 = getelementptr i64, i64* %r59, i32 4
%r78 = trunc i512 %r75 to i64
store i64 %r78, i64* %r77
%r79 = lshr i512 %r75, 64
%r81 = getelementptr i64, i64* %r59, i32 5
%r82 = trunc i512 %r79 to i64
store i64 %r82, i64* %r81
%r83 = lshr i512 %r79, 64
%r85 = getelementptr i64, i64* %r59, i32 6
%r86 = trunc i512 %r83 to i64
store i64 %r86, i64* %r85
%r87 = lshr i512 %r83, 64
%r89 = getelementptr i64, i64* %r59, i32 7
%r90 = trunc i512 %r87 to i64
store i64 %r90, i64* %r89
ret void
}
define void @mclb_sqr7(i64* noalias  %r1, i64* noalias  %r2)
{
%r3 = load i64, i64* %r2
%r4 = call i128 @mul64x64L(i64 %r3, i64 %r3)
%r5 = trunc i128 %r4 to i64
store i64 %r5, i64* %r1
%r6 = lshr i128 %r4, 64
%r8 = getelementptr i64, i64* %r2, i32 6
%r9 = load i64, i64* %r8
%r10 = call i128 @mul64x64L(i64 %r3, i64 %r9)
%r11 = load i64, i64* %r2
%r13 = getelementptr i64, i64* %r2, i32 5
%r14 = load i64, i64* %r13
%r15 = call i128 @mul64x64L(i64 %r11, i64 %r14)
%r17 = getelementptr i64, i64* %r2, i32 1
%r18 = load i64, i64* %r17
%r20 = getelementptr i64, i64* %r2, i32 6
%r21 = load i64, i64* %r20
%r22 = call i128 @mul64x64L(i64 %r18, i64 %r21)
%r23 = zext i128 %r15 to i256
%r24 = zext i128 %r22 to i256
%r25 = shl i256 %r24, 128
%r26 = or i256 %r23, %r25
%r27 = zext i128 %r10 to i256
%r28 = shl i256 %r27, 64
%r29 = add i256 %r28, %r26
%r30 = load i64, i64* %r2
%r32 = getelementptr i64, i64* %r2, i32 4
%r33 = load i64, i64* %r32
%r34 = call i128 @mul64x64L(i64 %r30, i64 %r33)
%r36 = getelementptr i64, i64* %r2, i32 1
%r37 = load i64, i64* %r36
%r39 = getelementptr i64, i64* %r2, i32 5
%r40 = load i64, i64* %r39
%r41 = call i128 @mul64x64L(i64 %r37, i64 %r40)
%r42 = zext i128 %r34 to i256
%r43 = zext i128 %r41 to i256
%r44 = shl i256 %r43, 128
%r45 = or i256 %r42, %r44
%r47 = getelementptr i64, i64* %r2, i32 2
%r48 = load i64, i64* %r47
%r50 = getelementptr i64, i64* %r2, i32 6
%r51 = load i64, i64* %r50
%r52 = call i128 @mul64x64L(i64 %r48, i64 %r51)
%r53 = zext i256 %r45 to i384
%r54 = zext i128 %r52 to i384
%r55 = shl i384 %r54, 256
%r56 = or i384 %r53, %r55
%r57 = zext i256 %r29 to i384
%r58 = shl i384 %r57, 64
%r59 = add i384 %r58, %r56
%r60 = load i64, i64* %r2
%r62 = getelementptr i64, i64* %r2, i32 3
%r63 = load i64, i64* %r62
%r64 = call i128 @mul64x64L(i64 %r60, i64 %r63)
%r66 = getelementptr i64, i64* %r2, i32 1
%r67 = load i64, i64* %r66
%r69 = getelementptr i64, i64* %r2, i32 4
%r70 = load i64, i64* %r69
%r71 = call i128 @mul64x64L(i64 %r67, i64 %r70)
%r72 = zext i128 %r64 to i256
%r73 = zext i128 %r71 to i256
%r74 = shl i256 %r73, 128
%r75 = or i256 %r72, %r74
%r77 = getelementptr i64, i64* %r2, i32 2
%r78 = load i64, i64* %r77
%r80 = getelementptr i64, i64* %r2, i32 5
%r81 = load i64, i64* %r80
%r82 = call i128 @mul64x64L(i64 %r78, i64 %r81)
%r83 = zext i256 %r75 to i384
%r84 = zext i128 %r82 to i384
%r85 = shl i384 %r84, 256
%r86 = or i384 %r83, %r85
%r88 = getelementptr i64, i64* %r2, i32 3
%r89 = load i64, i64* %r88
%r91 = getelementptr i64, i64* %r2, i32 6
%r92 = load i64, i64* %r91
%r93 = call i128 @mul64x64L(i64 %r89, i64 %r92)
%r94 = zext i384 %r86 to i512
%r95 = zext i128 %r93 to i512
%r96 = shl i512 %r95, 384
%r97 = or i512 %r94, %r96
%r98 = zext i384 %r59 to i512
%r99 = shl i512 %r98, 64
%r100 = add i512 %r99, %r97
%r101 = load i64, i64* %r2
%r103 = getelementptr i64, i64* %r2, i32 2
%r104 = load i64, i64* %r103
%r105 = call i128 @mul64x64L(i64 %r101, i64 %r104)
%r107 = getelementptr i64, i64* %r2, i32 1
%r108 = load i64, i64* %r107
%r110 = getelementptr i64, i64* %r2, i32 3
%r111 = load i64, i64* %r110
%r112 = call i128 @mul64x64L(i64 %r108, i64 %r111)
%r113 = zext i128 %r105 to i256
%r114 = zext i128 %r112 to i256
%r115 = shl i256 %r114, 128
%r116 = or i256 %r113, %r115
%r118 = getelementptr i64, i64* %r2, i32 2
%r119 = load i64, i64* %r118
%r121 = getelementptr i64, i64* %r2, i32 4
%r122 = load i64, i64* %r121
%r123 = call i128 @mul64x64L(i64 %r119, i64 %r122)
%r124 = zext i256 %r116 to i384
%r125 = zext i128 %r123 to i384
%r126 = shl i384 %r125, 256
%r127 = or i384 %r124, %r126
%r129 = getelementptr i64, i64* %r2, i32 3
%r130 = load i64, i64* %r129
%r132 = getelementptr i64, i64* %r2, i32 5
%r133 = load i64, i64* %r132
%r134 = call i128 @mul64x64L(i64 %r130, i64 %r133)
%r135 = zext i384 %r127 to i512
%r136 = zext i128 %r134 to i512
%r137 = shl i512 %r136, 384
%r138 = or i512 %r135, %r137
%r140 = getelementptr i64, i64* %r2, i32 4
%r141 = load i64, i64* %r140
%r143 = getelementptr i64, i64* %r2, i32 6
%r144 = load i64, i64* %r143
%r145 = call i128 @mul64x64L(i64 %r141, i64 %r144)
%r146 = zext i512 %r138 to i640
%r147 = zext i128 %r145 to i640
%r148 = shl i640 %r147, 512
%r149 = or i640 %r146, %r148
%r150 = zext i512 %r100 to i640
%r151 = shl i640 %r150, 64
%r152 = add i640 %r151, %r149
%r153 = load i64, i64* %r2
%r155 = getelementptr i64, i64* %r2, i32 1
%r156 = load i64, i64* %r155
%r157 = call i128 @mul64x64L(i64 %r153, i64 %r156)
%r159 = getelementptr i64, i64* %r2, i32 1
%r160 = load i64, i64* %r159
%r162 = getelementptr i64, i64* %r2, i32 2
%r163 = load i64, i64* %r162
%r164 = call i128 @mul64x64L(i64 %r160, i64 %r163)
%r165 = zext i128 %r157 to i256
%r166 = zext i128 %r164 to i256
%r167 = shl i256 %r166, 128
%r168 = or i256 %r165, %r167
%r170 = getelementptr i64, i64* %r2, i32 2
%r171 = load i64, i64* %r170
%r173 = getelementptr i64, i64* %r2, i32 3
%r174 = load i64, i64* %r173
%r175 = call i128 @mul64x64L(i64 %r171, i64 %r174)
%r176 = zext i256 %r168 to i384
%r177 = zext i128 %r175 to i384
%r178 = shl i384 %r177, 256
%r179 = or i384 %r176, %r178
%r181 = getelementptr i64, i64* %r2, i32 3
%r182 = load i64, i64* %r181
%r184 = getelementptr i64, i64* %r2, i32 4
%r185 = load i64, i64* %r184
%r186 = call i128 @mul64x64L(i64 %r182, i64 %r185)
%r187 = zext i384 %r179 to i512
%r188 = zext i128 %r186 to i512
%r189 = shl i512 %r188, 384
%r190 = or i512 %r187, %r189
%r192 = getelementptr i64, i64* %r2, i32 4
%r193 = load i64, i64* %r192
%r195 = getelementptr i64, i64* %r2, i32 5
%r196 = load i64, i64* %r195
%r197 = call i128 @mul64x64L(i64 %r193, i64 %r196)
%r198 = zext i512 %r190 to i640
%r199 = zext i128 %r197 to i640
%r200 = shl i640 %r199, 512
%r201 = or i640 %r198, %r200
%r203 = getelementptr i64, i64* %r2, i32 5
%r204 = load i64, i64* %r203
%r206 = getelementptr i64, i64* %r2, i32 6
%r207 = load i64, i64* %r206
%r208 = call i128 @mul64x64L(i64 %r204, i64 %r207)
%r209 = zext i640 %r201 to i768
%r210 = zext i128 %r208 to i768
%r211 = shl i768 %r210, 640
%r212 = or i768 %r209, %r211
%r213 = zext i640 %r152 to i768
%r214 = shl i768 %r213, 64
%r215 = add i768 %r214, %r212
%r216 = zext i128 %r6 to i832
%r218 = getelementptr i64, i64* %r2, i32 1
%r219 = load i64, i64* %r218
%r220 = call i128 @mul64x64L(i64 %r219, i64 %r219)
%r221 = zext i128 %r220 to i832
%r222 = shl i832 %r221, 64
%r223 = or i832 %r216, %r222
%r225 = getelementptr i64, i64* %r2, i32 2
%r226 = load i64, i64* %r225
%r227 = call i128 @mul64x64L(i64 %r226, i64 %r226)
%r228 = zext i128 %r227 to i832
%r229 = shl i832 %r228, 192
%r230 = or i832 %r223, %r229
%r232 = getelementptr i64, i64* %r2, i32 3
%r233 = load i64, i64* %r232
%r234 = call i128 @mul64x64L(i64 %r233, i64 %r233)
%r235 = zext i128 %r234 to i832
%r236 = shl i832 %r235, 320
%r237 = or i832 %r230, %r236
%r239 = getelementptr i64, i64* %r2, i32 4
%r240 = load i64, i64* %r239
%r241 = call i128 @mul64x64L(i64 %r240, i64 %r240)
%r242 = zext i128 %r241 to i832
%r243 = shl i832 %r242, 448
%r244 = or i832 %r237, %r243
%r246 = getelementptr i64, i64* %r2, i32 5
%r247 = load i64, i64* %r246
%r248 = call i128 @mul64x64L(i64 %r247, i64 %r247)
%r249 = zext i128 %r248 to i832
%r250 = shl i832 %r249, 576
%r251 = or i832 %r244, %r250
%r253 = getelementptr i64, i64* %r2, i32 6
%r254 = load i64, i64* %r253
%r255 = call i128 @mul64x64L(i64 %r254, i64 %r254)
%r256 = zext i128 %r255 to i832
%r257 = shl i832 %r256, 704
%r258 = or i832 %r251, %r257
%r259 = zext i768 %r215 to i832
%r260 = add i832 %r259, %r259
%r261 = add i832 %r258, %r260
%r263 = getelementptr i64, i64* %r1, i32 1
%r265 = getelementptr i64, i64* %r263, i32 0
%r266 = trunc i832 %r261 to i64
store i64 %r266, i64* %r265
%r267 = lshr i832 %r261, 64
%r269 = getelementptr i64, i64* %r263, i32 1
%r270 = trunc i832 %r267 to i64
store i64 %r270, i64* %r269
%r271 = lshr i832 %r267, 64
%r273 = getelementptr i64, i64* %r263, i32 2
%r274 = trunc i832 %r271 to i64
store i64 %r274, i64* %r273
%r275 = lshr i832 %r271, 64
%r277 = getelementptr i64, i64* %r263, i32 3
%r278 = trunc i832 %r275 to i64
store i64 %r278, i64* %r277
%r279 = lshr i832 %r275, 64
%r281 = getelementptr i64, i64* %r263, i32 4
%r282 = trunc i832 %r279 to i64
store i64 %r282, i64* %r281
%r283 = lshr i832 %r279, 64
%r285 = getelementptr i64, i64* %r263, i32 5
%r286 = trunc i832 %r283 to i64
store i64 %r286, i64* %r285
%r287 = lshr i832 %r283, 64
%r289 = getelementptr i64, i64* %r263, i32 6
%r290 = trunc i832 %r287 to i64
store i64 %r290, i64* %r289
%r291 = lshr i832 %r287, 64
%r293 = getelementptr i64, i64* %r263, i32 7
%r294 = trunc i832 %r291 to i64
store i64 %r294, i64* %r293
%r295 = lshr i832 %r291, 64
%r297 = getelementptr i64, i64* %r263, i32 8
%r298 = trunc i832 %r295 to i64
store i64 %r298, i64* %r297
%r299 = lshr i832 %r295, 64
%r301 = getelementptr i64, i64* %r263, i32 9
%r302 = trunc i832 %r299 to i64
store i64 %r302, i64* %r301
%r303 = lshr i832 %r299, 64
%r305 = getelementptr i64, i64* %r263, i32 10
%r306 = trunc i832 %r303 to i64
store i64 %r306, i64* %r305
%r307 = lshr i832 %r303, 64
%r309 = getelementptr i64, i64* %r263, i32 11
%r310 = trunc i832 %r307 to i64
store i64 %r310, i64* %r309
%r311 = lshr i832 %r307, 64
%r313 = getelementptr i64, i64* %r263, i32 12
%r314 = trunc i832 %r311 to i64
store i64 %r314, i64* %r313
ret void
}
define i576 @mulUnit_inner512(i64* noalias  %r2, i64 %r3)
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
define i64 @mclb_mulUnit8(i64* noalias  %r2, i64* noalias  %r3, i64 %r4)
{
%r5 = call i576 @mulUnit_inner512(i64* %r3, i64 %r4)
%r6 = trunc i576 %r5 to i512
%r8 = getelementptr i64, i64* %r2, i32 0
%r9 = trunc i512 %r6 to i64
store i64 %r9, i64* %r8
%r10 = lshr i512 %r6, 64
%r12 = getelementptr i64, i64* %r2, i32 1
%r13 = trunc i512 %r10 to i64
store i64 %r13, i64* %r12
%r14 = lshr i512 %r10, 64
%r16 = getelementptr i64, i64* %r2, i32 2
%r17 = trunc i512 %r14 to i64
store i64 %r17, i64* %r16
%r18 = lshr i512 %r14, 64
%r20 = getelementptr i64, i64* %r2, i32 3
%r21 = trunc i512 %r18 to i64
store i64 %r21, i64* %r20
%r22 = lshr i512 %r18, 64
%r24 = getelementptr i64, i64* %r2, i32 4
%r25 = trunc i512 %r22 to i64
store i64 %r25, i64* %r24
%r26 = lshr i512 %r22, 64
%r28 = getelementptr i64, i64* %r2, i32 5
%r29 = trunc i512 %r26 to i64
store i64 %r29, i64* %r28
%r30 = lshr i512 %r26, 64
%r32 = getelementptr i64, i64* %r2, i32 6
%r33 = trunc i512 %r30 to i64
store i64 %r33, i64* %r32
%r34 = lshr i512 %r30, 64
%r36 = getelementptr i64, i64* %r2, i32 7
%r37 = trunc i512 %r34 to i64
store i64 %r37, i64* %r36
%r38 = lshr i576 %r5, 512
%r39 = trunc i576 %r38 to i64
ret i64 %r39
}
define i64 @mclb_mulUnitAdd8(i64* noalias  %r2, i64* noalias  %r3, i64 %r4)
{
%r6 = call i128 @mulPos64x64(i64* %r3, i64 %r4, i64 0)
%r7 = trunc i128 %r6 to i64
%r8 = call i64 @extractHigh64(i128 %r6)
%r10 = call i128 @mulPos64x64(i64* %r3, i64 %r4, i64 1)
%r11 = trunc i128 %r10 to i64
%r12 = call i64 @extractHigh64(i128 %r10)
%r14 = call i128 @mulPos64x64(i64* %r3, i64 %r4, i64 2)
%r15 = trunc i128 %r14 to i64
%r16 = call i64 @extractHigh64(i128 %r14)
%r18 = call i128 @mulPos64x64(i64* %r3, i64 %r4, i64 3)
%r19 = trunc i128 %r18 to i64
%r20 = call i64 @extractHigh64(i128 %r18)
%r22 = call i128 @mulPos64x64(i64* %r3, i64 %r4, i64 4)
%r23 = trunc i128 %r22 to i64
%r24 = call i64 @extractHigh64(i128 %r22)
%r26 = call i128 @mulPos64x64(i64* %r3, i64 %r4, i64 5)
%r27 = trunc i128 %r26 to i64
%r28 = call i64 @extractHigh64(i128 %r26)
%r30 = call i128 @mulPos64x64(i64* %r3, i64 %r4, i64 6)
%r31 = trunc i128 %r30 to i64
%r32 = call i64 @extractHigh64(i128 %r30)
%r34 = call i128 @mulPos64x64(i64* %r3, i64 %r4, i64 7)
%r35 = trunc i128 %r34 to i64
%r36 = call i64 @extractHigh64(i128 %r34)
%r37 = zext i64 %r7 to i128
%r38 = zext i64 %r11 to i128
%r39 = shl i128 %r38, 64
%r40 = or i128 %r37, %r39
%r41 = zext i128 %r40 to i192
%r42 = zext i64 %r15 to i192
%r43 = shl i192 %r42, 128
%r44 = or i192 %r41, %r43
%r45 = zext i192 %r44 to i256
%r46 = zext i64 %r19 to i256
%r47 = shl i256 %r46, 192
%r48 = or i256 %r45, %r47
%r49 = zext i256 %r48 to i320
%r50 = zext i64 %r23 to i320
%r51 = shl i320 %r50, 256
%r52 = or i320 %r49, %r51
%r53 = zext i320 %r52 to i384
%r54 = zext i64 %r27 to i384
%r55 = shl i384 %r54, 320
%r56 = or i384 %r53, %r55
%r57 = zext i384 %r56 to i448
%r58 = zext i64 %r31 to i448
%r59 = shl i448 %r58, 384
%r60 = or i448 %r57, %r59
%r61 = zext i448 %r60 to i512
%r62 = zext i64 %r35 to i512
%r63 = shl i512 %r62, 448
%r64 = or i512 %r61, %r63
%r65 = zext i64 %r8 to i128
%r66 = zext i64 %r12 to i128
%r67 = shl i128 %r66, 64
%r68 = or i128 %r65, %r67
%r69 = zext i128 %r68 to i192
%r70 = zext i64 %r16 to i192
%r71 = shl i192 %r70, 128
%r72 = or i192 %r69, %r71
%r73 = zext i192 %r72 to i256
%r74 = zext i64 %r20 to i256
%r75 = shl i256 %r74, 192
%r76 = or i256 %r73, %r75
%r77 = zext i256 %r76 to i320
%r78 = zext i64 %r24 to i320
%r79 = shl i320 %r78, 256
%r80 = or i320 %r77, %r79
%r81 = zext i320 %r80 to i384
%r82 = zext i64 %r28 to i384
%r83 = shl i384 %r82, 320
%r84 = or i384 %r81, %r83
%r85 = zext i384 %r84 to i448
%r86 = zext i64 %r32 to i448
%r87 = shl i448 %r86, 384
%r88 = or i448 %r85, %r87
%r89 = zext i448 %r88 to i512
%r90 = zext i64 %r36 to i512
%r91 = shl i512 %r90, 448
%r92 = or i512 %r89, %r91
%r93 = zext i512 %r64 to i576
%r94 = zext i512 %r92 to i576
%r95 = shl i576 %r94, 64
%r96 = add i576 %r93, %r95
%r98 = bitcast i64* %r2 to i512*
%r99 = load i512, i512* %r98
%r100 = zext i512 %r99 to i576
%r101 = add i576 %r96, %r100
%r102 = trunc i576 %r101 to i512
%r104 = getelementptr i64, i64* %r2, i32 0
%r105 = trunc i512 %r102 to i64
store i64 %r105, i64* %r104
%r106 = lshr i512 %r102, 64
%r108 = getelementptr i64, i64* %r2, i32 1
%r109 = trunc i512 %r106 to i64
store i64 %r109, i64* %r108
%r110 = lshr i512 %r106, 64
%r112 = getelementptr i64, i64* %r2, i32 2
%r113 = trunc i512 %r110 to i64
store i64 %r113, i64* %r112
%r114 = lshr i512 %r110, 64
%r116 = getelementptr i64, i64* %r2, i32 3
%r117 = trunc i512 %r114 to i64
store i64 %r117, i64* %r116
%r118 = lshr i512 %r114, 64
%r120 = getelementptr i64, i64* %r2, i32 4
%r121 = trunc i512 %r118 to i64
store i64 %r121, i64* %r120
%r122 = lshr i512 %r118, 64
%r124 = getelementptr i64, i64* %r2, i32 5
%r125 = trunc i512 %r122 to i64
store i64 %r125, i64* %r124
%r126 = lshr i512 %r122, 64
%r128 = getelementptr i64, i64* %r2, i32 6
%r129 = trunc i512 %r126 to i64
store i64 %r129, i64* %r128
%r130 = lshr i512 %r126, 64
%r132 = getelementptr i64, i64* %r2, i32 7
%r133 = trunc i512 %r130 to i64
store i64 %r133, i64* %r132
%r134 = lshr i576 %r101, 512
%r135 = trunc i576 %r134 to i64
ret i64 %r135
}
define void @mclb_mul8(i64* noalias  %r1, i64* noalias  %r2, i64* noalias  %r3)
{
%r4 = load i64, i64* %r3
%r5 = call i576 @mulUnit_inner512(i64* %r2, i64 %r4)
%r6 = trunc i576 %r5 to i64
store i64 %r6, i64* %r1
%r7 = lshr i576 %r5, 64
%r9 = getelementptr i64, i64* %r3, i32 1
%r10 = load i64, i64* %r9
%r11 = call i576 @mulUnit_inner512(i64* %r2, i64 %r10)
%r12 = add i576 %r7, %r11
%r13 = trunc i576 %r12 to i64
%r15 = getelementptr i64, i64* %r1, i32 1
store i64 %r13, i64* %r15
%r16 = lshr i576 %r12, 64
%r18 = getelementptr i64, i64* %r3, i32 2
%r19 = load i64, i64* %r18
%r20 = call i576 @mulUnit_inner512(i64* %r2, i64 %r19)
%r21 = add i576 %r16, %r20
%r22 = trunc i576 %r21 to i64
%r24 = getelementptr i64, i64* %r1, i32 2
store i64 %r22, i64* %r24
%r25 = lshr i576 %r21, 64
%r27 = getelementptr i64, i64* %r3, i32 3
%r28 = load i64, i64* %r27
%r29 = call i576 @mulUnit_inner512(i64* %r2, i64 %r28)
%r30 = add i576 %r25, %r29
%r31 = trunc i576 %r30 to i64
%r33 = getelementptr i64, i64* %r1, i32 3
store i64 %r31, i64* %r33
%r34 = lshr i576 %r30, 64
%r36 = getelementptr i64, i64* %r3, i32 4
%r37 = load i64, i64* %r36
%r38 = call i576 @mulUnit_inner512(i64* %r2, i64 %r37)
%r39 = add i576 %r34, %r38
%r40 = trunc i576 %r39 to i64
%r42 = getelementptr i64, i64* %r1, i32 4
store i64 %r40, i64* %r42
%r43 = lshr i576 %r39, 64
%r45 = getelementptr i64, i64* %r3, i32 5
%r46 = load i64, i64* %r45
%r47 = call i576 @mulUnit_inner512(i64* %r2, i64 %r46)
%r48 = add i576 %r43, %r47
%r49 = trunc i576 %r48 to i64
%r51 = getelementptr i64, i64* %r1, i32 5
store i64 %r49, i64* %r51
%r52 = lshr i576 %r48, 64
%r54 = getelementptr i64, i64* %r3, i32 6
%r55 = load i64, i64* %r54
%r56 = call i576 @mulUnit_inner512(i64* %r2, i64 %r55)
%r57 = add i576 %r52, %r56
%r58 = trunc i576 %r57 to i64
%r60 = getelementptr i64, i64* %r1, i32 6
store i64 %r58, i64* %r60
%r61 = lshr i576 %r57, 64
%r63 = getelementptr i64, i64* %r3, i32 7
%r64 = load i64, i64* %r63
%r65 = call i576 @mulUnit_inner512(i64* %r2, i64 %r64)
%r66 = add i576 %r61, %r65
%r68 = getelementptr i64, i64* %r1, i32 7
%r70 = getelementptr i64, i64* %r68, i32 0
%r71 = trunc i576 %r66 to i64
store i64 %r71, i64* %r70
%r72 = lshr i576 %r66, 64
%r74 = getelementptr i64, i64* %r68, i32 1
%r75 = trunc i576 %r72 to i64
store i64 %r75, i64* %r74
%r76 = lshr i576 %r72, 64
%r78 = getelementptr i64, i64* %r68, i32 2
%r79 = trunc i576 %r76 to i64
store i64 %r79, i64* %r78
%r80 = lshr i576 %r76, 64
%r82 = getelementptr i64, i64* %r68, i32 3
%r83 = trunc i576 %r80 to i64
store i64 %r83, i64* %r82
%r84 = lshr i576 %r80, 64
%r86 = getelementptr i64, i64* %r68, i32 4
%r87 = trunc i576 %r84 to i64
store i64 %r87, i64* %r86
%r88 = lshr i576 %r84, 64
%r90 = getelementptr i64, i64* %r68, i32 5
%r91 = trunc i576 %r88 to i64
store i64 %r91, i64* %r90
%r92 = lshr i576 %r88, 64
%r94 = getelementptr i64, i64* %r68, i32 6
%r95 = trunc i576 %r92 to i64
store i64 %r95, i64* %r94
%r96 = lshr i576 %r92, 64
%r98 = getelementptr i64, i64* %r68, i32 7
%r99 = trunc i576 %r96 to i64
store i64 %r99, i64* %r98
%r100 = lshr i576 %r96, 64
%r102 = getelementptr i64, i64* %r68, i32 8
%r103 = trunc i576 %r100 to i64
store i64 %r103, i64* %r102
ret void
}
define void @mclb_sqr8(i64* noalias  %r1, i64* noalias  %r2)
{
%r3 = load i64, i64* %r2
%r4 = call i128 @mul64x64L(i64 %r3, i64 %r3)
%r5 = trunc i128 %r4 to i64
store i64 %r5, i64* %r1
%r6 = lshr i128 %r4, 64
%r8 = getelementptr i64, i64* %r2, i32 7
%r9 = load i64, i64* %r8
%r10 = call i128 @mul64x64L(i64 %r3, i64 %r9)
%r11 = load i64, i64* %r2
%r13 = getelementptr i64, i64* %r2, i32 6
%r14 = load i64, i64* %r13
%r15 = call i128 @mul64x64L(i64 %r11, i64 %r14)
%r17 = getelementptr i64, i64* %r2, i32 1
%r18 = load i64, i64* %r17
%r20 = getelementptr i64, i64* %r2, i32 7
%r21 = load i64, i64* %r20
%r22 = call i128 @mul64x64L(i64 %r18, i64 %r21)
%r23 = zext i128 %r15 to i256
%r24 = zext i128 %r22 to i256
%r25 = shl i256 %r24, 128
%r26 = or i256 %r23, %r25
%r27 = zext i128 %r10 to i256
%r28 = shl i256 %r27, 64
%r29 = add i256 %r28, %r26
%r30 = load i64, i64* %r2
%r32 = getelementptr i64, i64* %r2, i32 5
%r33 = load i64, i64* %r32
%r34 = call i128 @mul64x64L(i64 %r30, i64 %r33)
%r36 = getelementptr i64, i64* %r2, i32 1
%r37 = load i64, i64* %r36
%r39 = getelementptr i64, i64* %r2, i32 6
%r40 = load i64, i64* %r39
%r41 = call i128 @mul64x64L(i64 %r37, i64 %r40)
%r42 = zext i128 %r34 to i256
%r43 = zext i128 %r41 to i256
%r44 = shl i256 %r43, 128
%r45 = or i256 %r42, %r44
%r47 = getelementptr i64, i64* %r2, i32 2
%r48 = load i64, i64* %r47
%r50 = getelementptr i64, i64* %r2, i32 7
%r51 = load i64, i64* %r50
%r52 = call i128 @mul64x64L(i64 %r48, i64 %r51)
%r53 = zext i256 %r45 to i384
%r54 = zext i128 %r52 to i384
%r55 = shl i384 %r54, 256
%r56 = or i384 %r53, %r55
%r57 = zext i256 %r29 to i384
%r58 = shl i384 %r57, 64
%r59 = add i384 %r58, %r56
%r60 = load i64, i64* %r2
%r62 = getelementptr i64, i64* %r2, i32 4
%r63 = load i64, i64* %r62
%r64 = call i128 @mul64x64L(i64 %r60, i64 %r63)
%r66 = getelementptr i64, i64* %r2, i32 1
%r67 = load i64, i64* %r66
%r69 = getelementptr i64, i64* %r2, i32 5
%r70 = load i64, i64* %r69
%r71 = call i128 @mul64x64L(i64 %r67, i64 %r70)
%r72 = zext i128 %r64 to i256
%r73 = zext i128 %r71 to i256
%r74 = shl i256 %r73, 128
%r75 = or i256 %r72, %r74
%r77 = getelementptr i64, i64* %r2, i32 2
%r78 = load i64, i64* %r77
%r80 = getelementptr i64, i64* %r2, i32 6
%r81 = load i64, i64* %r80
%r82 = call i128 @mul64x64L(i64 %r78, i64 %r81)
%r83 = zext i256 %r75 to i384
%r84 = zext i128 %r82 to i384
%r85 = shl i384 %r84, 256
%r86 = or i384 %r83, %r85
%r88 = getelementptr i64, i64* %r2, i32 3
%r89 = load i64, i64* %r88
%r91 = getelementptr i64, i64* %r2, i32 7
%r92 = load i64, i64* %r91
%r93 = call i128 @mul64x64L(i64 %r89, i64 %r92)
%r94 = zext i384 %r86 to i512
%r95 = zext i128 %r93 to i512
%r96 = shl i512 %r95, 384
%r97 = or i512 %r94, %r96
%r98 = zext i384 %r59 to i512
%r99 = shl i512 %r98, 64
%r100 = add i512 %r99, %r97
%r101 = load i64, i64* %r2
%r103 = getelementptr i64, i64* %r2, i32 3
%r104 = load i64, i64* %r103
%r105 = call i128 @mul64x64L(i64 %r101, i64 %r104)
%r107 = getelementptr i64, i64* %r2, i32 1
%r108 = load i64, i64* %r107
%r110 = getelementptr i64, i64* %r2, i32 4
%r111 = load i64, i64* %r110
%r112 = call i128 @mul64x64L(i64 %r108, i64 %r111)
%r113 = zext i128 %r105 to i256
%r114 = zext i128 %r112 to i256
%r115 = shl i256 %r114, 128
%r116 = or i256 %r113, %r115
%r118 = getelementptr i64, i64* %r2, i32 2
%r119 = load i64, i64* %r118
%r121 = getelementptr i64, i64* %r2, i32 5
%r122 = load i64, i64* %r121
%r123 = call i128 @mul64x64L(i64 %r119, i64 %r122)
%r124 = zext i256 %r116 to i384
%r125 = zext i128 %r123 to i384
%r126 = shl i384 %r125, 256
%r127 = or i384 %r124, %r126
%r129 = getelementptr i64, i64* %r2, i32 3
%r130 = load i64, i64* %r129
%r132 = getelementptr i64, i64* %r2, i32 6
%r133 = load i64, i64* %r132
%r134 = call i128 @mul64x64L(i64 %r130, i64 %r133)
%r135 = zext i384 %r127 to i512
%r136 = zext i128 %r134 to i512
%r137 = shl i512 %r136, 384
%r138 = or i512 %r135, %r137
%r140 = getelementptr i64, i64* %r2, i32 4
%r141 = load i64, i64* %r140
%r143 = getelementptr i64, i64* %r2, i32 7
%r144 = load i64, i64* %r143
%r145 = call i128 @mul64x64L(i64 %r141, i64 %r144)
%r146 = zext i512 %r138 to i640
%r147 = zext i128 %r145 to i640
%r148 = shl i640 %r147, 512
%r149 = or i640 %r146, %r148
%r150 = zext i512 %r100 to i640
%r151 = shl i640 %r150, 64
%r152 = add i640 %r151, %r149
%r153 = load i64, i64* %r2
%r155 = getelementptr i64, i64* %r2, i32 2
%r156 = load i64, i64* %r155
%r157 = call i128 @mul64x64L(i64 %r153, i64 %r156)
%r159 = getelementptr i64, i64* %r2, i32 1
%r160 = load i64, i64* %r159
%r162 = getelementptr i64, i64* %r2, i32 3
%r163 = load i64, i64* %r162
%r164 = call i128 @mul64x64L(i64 %r160, i64 %r163)
%r165 = zext i128 %r157 to i256
%r166 = zext i128 %r164 to i256
%r167 = shl i256 %r166, 128
%r168 = or i256 %r165, %r167
%r170 = getelementptr i64, i64* %r2, i32 2
%r171 = load i64, i64* %r170
%r173 = getelementptr i64, i64* %r2, i32 4
%r174 = load i64, i64* %r173
%r175 = call i128 @mul64x64L(i64 %r171, i64 %r174)
%r176 = zext i256 %r168 to i384
%r177 = zext i128 %r175 to i384
%r178 = shl i384 %r177, 256
%r179 = or i384 %r176, %r178
%r181 = getelementptr i64, i64* %r2, i32 3
%r182 = load i64, i64* %r181
%r184 = getelementptr i64, i64* %r2, i32 5
%r185 = load i64, i64* %r184
%r186 = call i128 @mul64x64L(i64 %r182, i64 %r185)
%r187 = zext i384 %r179 to i512
%r188 = zext i128 %r186 to i512
%r189 = shl i512 %r188, 384
%r190 = or i512 %r187, %r189
%r192 = getelementptr i64, i64* %r2, i32 4
%r193 = load i64, i64* %r192
%r195 = getelementptr i64, i64* %r2, i32 6
%r196 = load i64, i64* %r195
%r197 = call i128 @mul64x64L(i64 %r193, i64 %r196)
%r198 = zext i512 %r190 to i640
%r199 = zext i128 %r197 to i640
%r200 = shl i640 %r199, 512
%r201 = or i640 %r198, %r200
%r203 = getelementptr i64, i64* %r2, i32 5
%r204 = load i64, i64* %r203
%r206 = getelementptr i64, i64* %r2, i32 7
%r207 = load i64, i64* %r206
%r208 = call i128 @mul64x64L(i64 %r204, i64 %r207)
%r209 = zext i640 %r201 to i768
%r210 = zext i128 %r208 to i768
%r211 = shl i768 %r210, 640
%r212 = or i768 %r209, %r211
%r213 = zext i640 %r152 to i768
%r214 = shl i768 %r213, 64
%r215 = add i768 %r214, %r212
%r216 = load i64, i64* %r2
%r218 = getelementptr i64, i64* %r2, i32 1
%r219 = load i64, i64* %r218
%r220 = call i128 @mul64x64L(i64 %r216, i64 %r219)
%r222 = getelementptr i64, i64* %r2, i32 1
%r223 = load i64, i64* %r222
%r225 = getelementptr i64, i64* %r2, i32 2
%r226 = load i64, i64* %r225
%r227 = call i128 @mul64x64L(i64 %r223, i64 %r226)
%r228 = zext i128 %r220 to i256
%r229 = zext i128 %r227 to i256
%r230 = shl i256 %r229, 128
%r231 = or i256 %r228, %r230
%r233 = getelementptr i64, i64* %r2, i32 2
%r234 = load i64, i64* %r233
%r236 = getelementptr i64, i64* %r2, i32 3
%r237 = load i64, i64* %r236
%r238 = call i128 @mul64x64L(i64 %r234, i64 %r237)
%r239 = zext i256 %r231 to i384
%r240 = zext i128 %r238 to i384
%r241 = shl i384 %r240, 256
%r242 = or i384 %r239, %r241
%r244 = getelementptr i64, i64* %r2, i32 3
%r245 = load i64, i64* %r244
%r247 = getelementptr i64, i64* %r2, i32 4
%r248 = load i64, i64* %r247
%r249 = call i128 @mul64x64L(i64 %r245, i64 %r248)
%r250 = zext i384 %r242 to i512
%r251 = zext i128 %r249 to i512
%r252 = shl i512 %r251, 384
%r253 = or i512 %r250, %r252
%r255 = getelementptr i64, i64* %r2, i32 4
%r256 = load i64, i64* %r255
%r258 = getelementptr i64, i64* %r2, i32 5
%r259 = load i64, i64* %r258
%r260 = call i128 @mul64x64L(i64 %r256, i64 %r259)
%r261 = zext i512 %r253 to i640
%r262 = zext i128 %r260 to i640
%r263 = shl i640 %r262, 512
%r264 = or i640 %r261, %r263
%r266 = getelementptr i64, i64* %r2, i32 5
%r267 = load i64, i64* %r266
%r269 = getelementptr i64, i64* %r2, i32 6
%r270 = load i64, i64* %r269
%r271 = call i128 @mul64x64L(i64 %r267, i64 %r270)
%r272 = zext i640 %r264 to i768
%r273 = zext i128 %r271 to i768
%r274 = shl i768 %r273, 640
%r275 = or i768 %r272, %r274
%r277 = getelementptr i64, i64* %r2, i32 6
%r278 = load i64, i64* %r277
%r280 = getelementptr i64, i64* %r2, i32 7
%r281 = load i64, i64* %r280
%r282 = call i128 @mul64x64L(i64 %r278, i64 %r281)
%r283 = zext i768 %r275 to i896
%r284 = zext i128 %r282 to i896
%r285 = shl i896 %r284, 768
%r286 = or i896 %r283, %r285
%r287 = zext i768 %r215 to i896
%r288 = shl i896 %r287, 64
%r289 = add i896 %r288, %r286
%r290 = zext i128 %r6 to i960
%r292 = getelementptr i64, i64* %r2, i32 1
%r293 = load i64, i64* %r292
%r294 = call i128 @mul64x64L(i64 %r293, i64 %r293)
%r295 = zext i128 %r294 to i960
%r296 = shl i960 %r295, 64
%r297 = or i960 %r290, %r296
%r299 = getelementptr i64, i64* %r2, i32 2
%r300 = load i64, i64* %r299
%r301 = call i128 @mul64x64L(i64 %r300, i64 %r300)
%r302 = zext i128 %r301 to i960
%r303 = shl i960 %r302, 192
%r304 = or i960 %r297, %r303
%r306 = getelementptr i64, i64* %r2, i32 3
%r307 = load i64, i64* %r306
%r308 = call i128 @mul64x64L(i64 %r307, i64 %r307)
%r309 = zext i128 %r308 to i960
%r310 = shl i960 %r309, 320
%r311 = or i960 %r304, %r310
%r313 = getelementptr i64, i64* %r2, i32 4
%r314 = load i64, i64* %r313
%r315 = call i128 @mul64x64L(i64 %r314, i64 %r314)
%r316 = zext i128 %r315 to i960
%r317 = shl i960 %r316, 448
%r318 = or i960 %r311, %r317
%r320 = getelementptr i64, i64* %r2, i32 5
%r321 = load i64, i64* %r320
%r322 = call i128 @mul64x64L(i64 %r321, i64 %r321)
%r323 = zext i128 %r322 to i960
%r324 = shl i960 %r323, 576
%r325 = or i960 %r318, %r324
%r327 = getelementptr i64, i64* %r2, i32 6
%r328 = load i64, i64* %r327
%r329 = call i128 @mul64x64L(i64 %r328, i64 %r328)
%r330 = zext i128 %r329 to i960
%r331 = shl i960 %r330, 704
%r332 = or i960 %r325, %r331
%r334 = getelementptr i64, i64* %r2, i32 7
%r335 = load i64, i64* %r334
%r336 = call i128 @mul64x64L(i64 %r335, i64 %r335)
%r337 = zext i128 %r336 to i960
%r338 = shl i960 %r337, 832
%r339 = or i960 %r332, %r338
%r340 = zext i896 %r289 to i960
%r341 = add i960 %r340, %r340
%r342 = add i960 %r339, %r341
%r344 = getelementptr i64, i64* %r1, i32 1
%r346 = getelementptr i64, i64* %r344, i32 0
%r347 = trunc i960 %r342 to i64
store i64 %r347, i64* %r346
%r348 = lshr i960 %r342, 64
%r350 = getelementptr i64, i64* %r344, i32 1
%r351 = trunc i960 %r348 to i64
store i64 %r351, i64* %r350
%r352 = lshr i960 %r348, 64
%r354 = getelementptr i64, i64* %r344, i32 2
%r355 = trunc i960 %r352 to i64
store i64 %r355, i64* %r354
%r356 = lshr i960 %r352, 64
%r358 = getelementptr i64, i64* %r344, i32 3
%r359 = trunc i960 %r356 to i64
store i64 %r359, i64* %r358
%r360 = lshr i960 %r356, 64
%r362 = getelementptr i64, i64* %r344, i32 4
%r363 = trunc i960 %r360 to i64
store i64 %r363, i64* %r362
%r364 = lshr i960 %r360, 64
%r366 = getelementptr i64, i64* %r344, i32 5
%r367 = trunc i960 %r364 to i64
store i64 %r367, i64* %r366
%r368 = lshr i960 %r364, 64
%r370 = getelementptr i64, i64* %r344, i32 6
%r371 = trunc i960 %r368 to i64
store i64 %r371, i64* %r370
%r372 = lshr i960 %r368, 64
%r374 = getelementptr i64, i64* %r344, i32 7
%r375 = trunc i960 %r372 to i64
store i64 %r375, i64* %r374
%r376 = lshr i960 %r372, 64
%r378 = getelementptr i64, i64* %r344, i32 8
%r379 = trunc i960 %r376 to i64
store i64 %r379, i64* %r378
%r380 = lshr i960 %r376, 64
%r382 = getelementptr i64, i64* %r344, i32 9
%r383 = trunc i960 %r380 to i64
store i64 %r383, i64* %r382
%r384 = lshr i960 %r380, 64
%r386 = getelementptr i64, i64* %r344, i32 10
%r387 = trunc i960 %r384 to i64
store i64 %r387, i64* %r386
%r388 = lshr i960 %r384, 64
%r390 = getelementptr i64, i64* %r344, i32 11
%r391 = trunc i960 %r388 to i64
store i64 %r391, i64* %r390
%r392 = lshr i960 %r388, 64
%r394 = getelementptr i64, i64* %r344, i32 12
%r395 = trunc i960 %r392 to i64
store i64 %r395, i64* %r394
%r396 = lshr i960 %r392, 64
%r398 = getelementptr i64, i64* %r344, i32 13
%r399 = trunc i960 %r396 to i64
store i64 %r399, i64* %r398
%r400 = lshr i960 %r396, 64
%r402 = getelementptr i64, i64* %r344, i32 14
%r403 = trunc i960 %r400 to i64
store i64 %r403, i64* %r402
ret void
}
define i640 @mulUnit_inner576(i64* noalias  %r2, i64 %r3)
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
define i64 @mclb_mulUnit9(i64* noalias  %r2, i64* noalias  %r3, i64 %r4)
{
%r5 = call i640 @mulUnit_inner576(i64* %r3, i64 %r4)
%r6 = trunc i640 %r5 to i576
%r8 = getelementptr i64, i64* %r2, i32 0
%r9 = trunc i576 %r6 to i64
store i64 %r9, i64* %r8
%r10 = lshr i576 %r6, 64
%r12 = getelementptr i64, i64* %r2, i32 1
%r13 = trunc i576 %r10 to i64
store i64 %r13, i64* %r12
%r14 = lshr i576 %r10, 64
%r16 = getelementptr i64, i64* %r2, i32 2
%r17 = trunc i576 %r14 to i64
store i64 %r17, i64* %r16
%r18 = lshr i576 %r14, 64
%r20 = getelementptr i64, i64* %r2, i32 3
%r21 = trunc i576 %r18 to i64
store i64 %r21, i64* %r20
%r22 = lshr i576 %r18, 64
%r24 = getelementptr i64, i64* %r2, i32 4
%r25 = trunc i576 %r22 to i64
store i64 %r25, i64* %r24
%r26 = lshr i576 %r22, 64
%r28 = getelementptr i64, i64* %r2, i32 5
%r29 = trunc i576 %r26 to i64
store i64 %r29, i64* %r28
%r30 = lshr i576 %r26, 64
%r32 = getelementptr i64, i64* %r2, i32 6
%r33 = trunc i576 %r30 to i64
store i64 %r33, i64* %r32
%r34 = lshr i576 %r30, 64
%r36 = getelementptr i64, i64* %r2, i32 7
%r37 = trunc i576 %r34 to i64
store i64 %r37, i64* %r36
%r38 = lshr i576 %r34, 64
%r40 = getelementptr i64, i64* %r2, i32 8
%r41 = trunc i576 %r38 to i64
store i64 %r41, i64* %r40
%r42 = lshr i640 %r5, 576
%r43 = trunc i640 %r42 to i64
ret i64 %r43
}
define i64 @mclb_mulUnitAdd9(i64* noalias  %r2, i64* noalias  %r3, i64 %r4)
{
%r6 = call i128 @mulPos64x64(i64* %r3, i64 %r4, i64 0)
%r7 = trunc i128 %r6 to i64
%r8 = call i64 @extractHigh64(i128 %r6)
%r10 = call i128 @mulPos64x64(i64* %r3, i64 %r4, i64 1)
%r11 = trunc i128 %r10 to i64
%r12 = call i64 @extractHigh64(i128 %r10)
%r14 = call i128 @mulPos64x64(i64* %r3, i64 %r4, i64 2)
%r15 = trunc i128 %r14 to i64
%r16 = call i64 @extractHigh64(i128 %r14)
%r18 = call i128 @mulPos64x64(i64* %r3, i64 %r4, i64 3)
%r19 = trunc i128 %r18 to i64
%r20 = call i64 @extractHigh64(i128 %r18)
%r22 = call i128 @mulPos64x64(i64* %r3, i64 %r4, i64 4)
%r23 = trunc i128 %r22 to i64
%r24 = call i64 @extractHigh64(i128 %r22)
%r26 = call i128 @mulPos64x64(i64* %r3, i64 %r4, i64 5)
%r27 = trunc i128 %r26 to i64
%r28 = call i64 @extractHigh64(i128 %r26)
%r30 = call i128 @mulPos64x64(i64* %r3, i64 %r4, i64 6)
%r31 = trunc i128 %r30 to i64
%r32 = call i64 @extractHigh64(i128 %r30)
%r34 = call i128 @mulPos64x64(i64* %r3, i64 %r4, i64 7)
%r35 = trunc i128 %r34 to i64
%r36 = call i64 @extractHigh64(i128 %r34)
%r38 = call i128 @mulPos64x64(i64* %r3, i64 %r4, i64 8)
%r39 = trunc i128 %r38 to i64
%r40 = call i64 @extractHigh64(i128 %r38)
%r41 = zext i64 %r7 to i128
%r42 = zext i64 %r11 to i128
%r43 = shl i128 %r42, 64
%r44 = or i128 %r41, %r43
%r45 = zext i128 %r44 to i192
%r46 = zext i64 %r15 to i192
%r47 = shl i192 %r46, 128
%r48 = or i192 %r45, %r47
%r49 = zext i192 %r48 to i256
%r50 = zext i64 %r19 to i256
%r51 = shl i256 %r50, 192
%r52 = or i256 %r49, %r51
%r53 = zext i256 %r52 to i320
%r54 = zext i64 %r23 to i320
%r55 = shl i320 %r54, 256
%r56 = or i320 %r53, %r55
%r57 = zext i320 %r56 to i384
%r58 = zext i64 %r27 to i384
%r59 = shl i384 %r58, 320
%r60 = or i384 %r57, %r59
%r61 = zext i384 %r60 to i448
%r62 = zext i64 %r31 to i448
%r63 = shl i448 %r62, 384
%r64 = or i448 %r61, %r63
%r65 = zext i448 %r64 to i512
%r66 = zext i64 %r35 to i512
%r67 = shl i512 %r66, 448
%r68 = or i512 %r65, %r67
%r69 = zext i512 %r68 to i576
%r70 = zext i64 %r39 to i576
%r71 = shl i576 %r70, 512
%r72 = or i576 %r69, %r71
%r73 = zext i64 %r8 to i128
%r74 = zext i64 %r12 to i128
%r75 = shl i128 %r74, 64
%r76 = or i128 %r73, %r75
%r77 = zext i128 %r76 to i192
%r78 = zext i64 %r16 to i192
%r79 = shl i192 %r78, 128
%r80 = or i192 %r77, %r79
%r81 = zext i192 %r80 to i256
%r82 = zext i64 %r20 to i256
%r83 = shl i256 %r82, 192
%r84 = or i256 %r81, %r83
%r85 = zext i256 %r84 to i320
%r86 = zext i64 %r24 to i320
%r87 = shl i320 %r86, 256
%r88 = or i320 %r85, %r87
%r89 = zext i320 %r88 to i384
%r90 = zext i64 %r28 to i384
%r91 = shl i384 %r90, 320
%r92 = or i384 %r89, %r91
%r93 = zext i384 %r92 to i448
%r94 = zext i64 %r32 to i448
%r95 = shl i448 %r94, 384
%r96 = or i448 %r93, %r95
%r97 = zext i448 %r96 to i512
%r98 = zext i64 %r36 to i512
%r99 = shl i512 %r98, 448
%r100 = or i512 %r97, %r99
%r101 = zext i512 %r100 to i576
%r102 = zext i64 %r40 to i576
%r103 = shl i576 %r102, 512
%r104 = or i576 %r101, %r103
%r105 = zext i576 %r72 to i640
%r106 = zext i576 %r104 to i640
%r107 = shl i640 %r106, 64
%r108 = add i640 %r105, %r107
%r110 = bitcast i64* %r2 to i576*
%r111 = load i576, i576* %r110
%r112 = zext i576 %r111 to i640
%r113 = add i640 %r108, %r112
%r114 = trunc i640 %r113 to i576
%r116 = getelementptr i64, i64* %r2, i32 0
%r117 = trunc i576 %r114 to i64
store i64 %r117, i64* %r116
%r118 = lshr i576 %r114, 64
%r120 = getelementptr i64, i64* %r2, i32 1
%r121 = trunc i576 %r118 to i64
store i64 %r121, i64* %r120
%r122 = lshr i576 %r118, 64
%r124 = getelementptr i64, i64* %r2, i32 2
%r125 = trunc i576 %r122 to i64
store i64 %r125, i64* %r124
%r126 = lshr i576 %r122, 64
%r128 = getelementptr i64, i64* %r2, i32 3
%r129 = trunc i576 %r126 to i64
store i64 %r129, i64* %r128
%r130 = lshr i576 %r126, 64
%r132 = getelementptr i64, i64* %r2, i32 4
%r133 = trunc i576 %r130 to i64
store i64 %r133, i64* %r132
%r134 = lshr i576 %r130, 64
%r136 = getelementptr i64, i64* %r2, i32 5
%r137 = trunc i576 %r134 to i64
store i64 %r137, i64* %r136
%r138 = lshr i576 %r134, 64
%r140 = getelementptr i64, i64* %r2, i32 6
%r141 = trunc i576 %r138 to i64
store i64 %r141, i64* %r140
%r142 = lshr i576 %r138, 64
%r144 = getelementptr i64, i64* %r2, i32 7
%r145 = trunc i576 %r142 to i64
store i64 %r145, i64* %r144
%r146 = lshr i576 %r142, 64
%r148 = getelementptr i64, i64* %r2, i32 8
%r149 = trunc i576 %r146 to i64
store i64 %r149, i64* %r148
%r150 = lshr i640 %r113, 576
%r151 = trunc i640 %r150 to i64
ret i64 %r151
}
define void @mclb_mul9(i64* noalias  %r1, i64* noalias  %r2, i64* noalias  %r3)
{
%r4 = load i64, i64* %r3
%r5 = call i640 @mulUnit_inner576(i64* %r2, i64 %r4)
%r6 = trunc i640 %r5 to i64
store i64 %r6, i64* %r1
%r7 = lshr i640 %r5, 64
%r9 = getelementptr i64, i64* %r3, i32 1
%r10 = load i64, i64* %r9
%r11 = call i640 @mulUnit_inner576(i64* %r2, i64 %r10)
%r12 = add i640 %r7, %r11
%r13 = trunc i640 %r12 to i64
%r15 = getelementptr i64, i64* %r1, i32 1
store i64 %r13, i64* %r15
%r16 = lshr i640 %r12, 64
%r18 = getelementptr i64, i64* %r3, i32 2
%r19 = load i64, i64* %r18
%r20 = call i640 @mulUnit_inner576(i64* %r2, i64 %r19)
%r21 = add i640 %r16, %r20
%r22 = trunc i640 %r21 to i64
%r24 = getelementptr i64, i64* %r1, i32 2
store i64 %r22, i64* %r24
%r25 = lshr i640 %r21, 64
%r27 = getelementptr i64, i64* %r3, i32 3
%r28 = load i64, i64* %r27
%r29 = call i640 @mulUnit_inner576(i64* %r2, i64 %r28)
%r30 = add i640 %r25, %r29
%r31 = trunc i640 %r30 to i64
%r33 = getelementptr i64, i64* %r1, i32 3
store i64 %r31, i64* %r33
%r34 = lshr i640 %r30, 64
%r36 = getelementptr i64, i64* %r3, i32 4
%r37 = load i64, i64* %r36
%r38 = call i640 @mulUnit_inner576(i64* %r2, i64 %r37)
%r39 = add i640 %r34, %r38
%r40 = trunc i640 %r39 to i64
%r42 = getelementptr i64, i64* %r1, i32 4
store i64 %r40, i64* %r42
%r43 = lshr i640 %r39, 64
%r45 = getelementptr i64, i64* %r3, i32 5
%r46 = load i64, i64* %r45
%r47 = call i640 @mulUnit_inner576(i64* %r2, i64 %r46)
%r48 = add i640 %r43, %r47
%r49 = trunc i640 %r48 to i64
%r51 = getelementptr i64, i64* %r1, i32 5
store i64 %r49, i64* %r51
%r52 = lshr i640 %r48, 64
%r54 = getelementptr i64, i64* %r3, i32 6
%r55 = load i64, i64* %r54
%r56 = call i640 @mulUnit_inner576(i64* %r2, i64 %r55)
%r57 = add i640 %r52, %r56
%r58 = trunc i640 %r57 to i64
%r60 = getelementptr i64, i64* %r1, i32 6
store i64 %r58, i64* %r60
%r61 = lshr i640 %r57, 64
%r63 = getelementptr i64, i64* %r3, i32 7
%r64 = load i64, i64* %r63
%r65 = call i640 @mulUnit_inner576(i64* %r2, i64 %r64)
%r66 = add i640 %r61, %r65
%r67 = trunc i640 %r66 to i64
%r69 = getelementptr i64, i64* %r1, i32 7
store i64 %r67, i64* %r69
%r70 = lshr i640 %r66, 64
%r72 = getelementptr i64, i64* %r3, i32 8
%r73 = load i64, i64* %r72
%r74 = call i640 @mulUnit_inner576(i64* %r2, i64 %r73)
%r75 = add i640 %r70, %r74
%r77 = getelementptr i64, i64* %r1, i32 8
%r79 = getelementptr i64, i64* %r77, i32 0
%r80 = trunc i640 %r75 to i64
store i64 %r80, i64* %r79
%r81 = lshr i640 %r75, 64
%r83 = getelementptr i64, i64* %r77, i32 1
%r84 = trunc i640 %r81 to i64
store i64 %r84, i64* %r83
%r85 = lshr i640 %r81, 64
%r87 = getelementptr i64, i64* %r77, i32 2
%r88 = trunc i640 %r85 to i64
store i64 %r88, i64* %r87
%r89 = lshr i640 %r85, 64
%r91 = getelementptr i64, i64* %r77, i32 3
%r92 = trunc i640 %r89 to i64
store i64 %r92, i64* %r91
%r93 = lshr i640 %r89, 64
%r95 = getelementptr i64, i64* %r77, i32 4
%r96 = trunc i640 %r93 to i64
store i64 %r96, i64* %r95
%r97 = lshr i640 %r93, 64
%r99 = getelementptr i64, i64* %r77, i32 5
%r100 = trunc i640 %r97 to i64
store i64 %r100, i64* %r99
%r101 = lshr i640 %r97, 64
%r103 = getelementptr i64, i64* %r77, i32 6
%r104 = trunc i640 %r101 to i64
store i64 %r104, i64* %r103
%r105 = lshr i640 %r101, 64
%r107 = getelementptr i64, i64* %r77, i32 7
%r108 = trunc i640 %r105 to i64
store i64 %r108, i64* %r107
%r109 = lshr i640 %r105, 64
%r111 = getelementptr i64, i64* %r77, i32 8
%r112 = trunc i640 %r109 to i64
store i64 %r112, i64* %r111
%r113 = lshr i640 %r109, 64
%r115 = getelementptr i64, i64* %r77, i32 9
%r116 = trunc i640 %r113 to i64
store i64 %r116, i64* %r115
ret void
}
define void @mclb_sqr9(i64* noalias  %r1, i64* noalias  %r2)
{
%r3 = load i64, i64* %r2
%r4 = call i128 @mul64x64L(i64 %r3, i64 %r3)
%r5 = trunc i128 %r4 to i64
store i64 %r5, i64* %r1
%r6 = lshr i128 %r4, 64
%r8 = getelementptr i64, i64* %r2, i32 8
%r9 = load i64, i64* %r8
%r10 = call i128 @mul64x64L(i64 %r3, i64 %r9)
%r11 = load i64, i64* %r2
%r13 = getelementptr i64, i64* %r2, i32 7
%r14 = load i64, i64* %r13
%r15 = call i128 @mul64x64L(i64 %r11, i64 %r14)
%r17 = getelementptr i64, i64* %r2, i32 1
%r18 = load i64, i64* %r17
%r20 = getelementptr i64, i64* %r2, i32 8
%r21 = load i64, i64* %r20
%r22 = call i128 @mul64x64L(i64 %r18, i64 %r21)
%r23 = zext i128 %r15 to i256
%r24 = zext i128 %r22 to i256
%r25 = shl i256 %r24, 128
%r26 = or i256 %r23, %r25
%r27 = zext i128 %r10 to i256
%r28 = shl i256 %r27, 64
%r29 = add i256 %r28, %r26
%r30 = load i64, i64* %r2
%r32 = getelementptr i64, i64* %r2, i32 6
%r33 = load i64, i64* %r32
%r34 = call i128 @mul64x64L(i64 %r30, i64 %r33)
%r36 = getelementptr i64, i64* %r2, i32 1
%r37 = load i64, i64* %r36
%r39 = getelementptr i64, i64* %r2, i32 7
%r40 = load i64, i64* %r39
%r41 = call i128 @mul64x64L(i64 %r37, i64 %r40)
%r42 = zext i128 %r34 to i256
%r43 = zext i128 %r41 to i256
%r44 = shl i256 %r43, 128
%r45 = or i256 %r42, %r44
%r47 = getelementptr i64, i64* %r2, i32 2
%r48 = load i64, i64* %r47
%r50 = getelementptr i64, i64* %r2, i32 8
%r51 = load i64, i64* %r50
%r52 = call i128 @mul64x64L(i64 %r48, i64 %r51)
%r53 = zext i256 %r45 to i384
%r54 = zext i128 %r52 to i384
%r55 = shl i384 %r54, 256
%r56 = or i384 %r53, %r55
%r57 = zext i256 %r29 to i384
%r58 = shl i384 %r57, 64
%r59 = add i384 %r58, %r56
%r60 = load i64, i64* %r2
%r62 = getelementptr i64, i64* %r2, i32 5
%r63 = load i64, i64* %r62
%r64 = call i128 @mul64x64L(i64 %r60, i64 %r63)
%r66 = getelementptr i64, i64* %r2, i32 1
%r67 = load i64, i64* %r66
%r69 = getelementptr i64, i64* %r2, i32 6
%r70 = load i64, i64* %r69
%r71 = call i128 @mul64x64L(i64 %r67, i64 %r70)
%r72 = zext i128 %r64 to i256
%r73 = zext i128 %r71 to i256
%r74 = shl i256 %r73, 128
%r75 = or i256 %r72, %r74
%r77 = getelementptr i64, i64* %r2, i32 2
%r78 = load i64, i64* %r77
%r80 = getelementptr i64, i64* %r2, i32 7
%r81 = load i64, i64* %r80
%r82 = call i128 @mul64x64L(i64 %r78, i64 %r81)
%r83 = zext i256 %r75 to i384
%r84 = zext i128 %r82 to i384
%r85 = shl i384 %r84, 256
%r86 = or i384 %r83, %r85
%r88 = getelementptr i64, i64* %r2, i32 3
%r89 = load i64, i64* %r88
%r91 = getelementptr i64, i64* %r2, i32 8
%r92 = load i64, i64* %r91
%r93 = call i128 @mul64x64L(i64 %r89, i64 %r92)
%r94 = zext i384 %r86 to i512
%r95 = zext i128 %r93 to i512
%r96 = shl i512 %r95, 384
%r97 = or i512 %r94, %r96
%r98 = zext i384 %r59 to i512
%r99 = shl i512 %r98, 64
%r100 = add i512 %r99, %r97
%r101 = load i64, i64* %r2
%r103 = getelementptr i64, i64* %r2, i32 4
%r104 = load i64, i64* %r103
%r105 = call i128 @mul64x64L(i64 %r101, i64 %r104)
%r107 = getelementptr i64, i64* %r2, i32 1
%r108 = load i64, i64* %r107
%r110 = getelementptr i64, i64* %r2, i32 5
%r111 = load i64, i64* %r110
%r112 = call i128 @mul64x64L(i64 %r108, i64 %r111)
%r113 = zext i128 %r105 to i256
%r114 = zext i128 %r112 to i256
%r115 = shl i256 %r114, 128
%r116 = or i256 %r113, %r115
%r118 = getelementptr i64, i64* %r2, i32 2
%r119 = load i64, i64* %r118
%r121 = getelementptr i64, i64* %r2, i32 6
%r122 = load i64, i64* %r121
%r123 = call i128 @mul64x64L(i64 %r119, i64 %r122)
%r124 = zext i256 %r116 to i384
%r125 = zext i128 %r123 to i384
%r126 = shl i384 %r125, 256
%r127 = or i384 %r124, %r126
%r129 = getelementptr i64, i64* %r2, i32 3
%r130 = load i64, i64* %r129
%r132 = getelementptr i64, i64* %r2, i32 7
%r133 = load i64, i64* %r132
%r134 = call i128 @mul64x64L(i64 %r130, i64 %r133)
%r135 = zext i384 %r127 to i512
%r136 = zext i128 %r134 to i512
%r137 = shl i512 %r136, 384
%r138 = or i512 %r135, %r137
%r140 = getelementptr i64, i64* %r2, i32 4
%r141 = load i64, i64* %r140
%r143 = getelementptr i64, i64* %r2, i32 8
%r144 = load i64, i64* %r143
%r145 = call i128 @mul64x64L(i64 %r141, i64 %r144)
%r146 = zext i512 %r138 to i640
%r147 = zext i128 %r145 to i640
%r148 = shl i640 %r147, 512
%r149 = or i640 %r146, %r148
%r150 = zext i512 %r100 to i640
%r151 = shl i640 %r150, 64
%r152 = add i640 %r151, %r149
%r153 = load i64, i64* %r2
%r155 = getelementptr i64, i64* %r2, i32 3
%r156 = load i64, i64* %r155
%r157 = call i128 @mul64x64L(i64 %r153, i64 %r156)
%r159 = getelementptr i64, i64* %r2, i32 1
%r160 = load i64, i64* %r159
%r162 = getelementptr i64, i64* %r2, i32 4
%r163 = load i64, i64* %r162
%r164 = call i128 @mul64x64L(i64 %r160, i64 %r163)
%r165 = zext i128 %r157 to i256
%r166 = zext i128 %r164 to i256
%r167 = shl i256 %r166, 128
%r168 = or i256 %r165, %r167
%r170 = getelementptr i64, i64* %r2, i32 2
%r171 = load i64, i64* %r170
%r173 = getelementptr i64, i64* %r2, i32 5
%r174 = load i64, i64* %r173
%r175 = call i128 @mul64x64L(i64 %r171, i64 %r174)
%r176 = zext i256 %r168 to i384
%r177 = zext i128 %r175 to i384
%r178 = shl i384 %r177, 256
%r179 = or i384 %r176, %r178
%r181 = getelementptr i64, i64* %r2, i32 3
%r182 = load i64, i64* %r181
%r184 = getelementptr i64, i64* %r2, i32 6
%r185 = load i64, i64* %r184
%r186 = call i128 @mul64x64L(i64 %r182, i64 %r185)
%r187 = zext i384 %r179 to i512
%r188 = zext i128 %r186 to i512
%r189 = shl i512 %r188, 384
%r190 = or i512 %r187, %r189
%r192 = getelementptr i64, i64* %r2, i32 4
%r193 = load i64, i64* %r192
%r195 = getelementptr i64, i64* %r2, i32 7
%r196 = load i64, i64* %r195
%r197 = call i128 @mul64x64L(i64 %r193, i64 %r196)
%r198 = zext i512 %r190 to i640
%r199 = zext i128 %r197 to i640
%r200 = shl i640 %r199, 512
%r201 = or i640 %r198, %r200
%r203 = getelementptr i64, i64* %r2, i32 5
%r204 = load i64, i64* %r203
%r206 = getelementptr i64, i64* %r2, i32 8
%r207 = load i64, i64* %r206
%r208 = call i128 @mul64x64L(i64 %r204, i64 %r207)
%r209 = zext i640 %r201 to i768
%r210 = zext i128 %r208 to i768
%r211 = shl i768 %r210, 640
%r212 = or i768 %r209, %r211
%r213 = zext i640 %r152 to i768
%r214 = shl i768 %r213, 64
%r215 = add i768 %r214, %r212
%r216 = load i64, i64* %r2
%r218 = getelementptr i64, i64* %r2, i32 2
%r219 = load i64, i64* %r218
%r220 = call i128 @mul64x64L(i64 %r216, i64 %r219)
%r222 = getelementptr i64, i64* %r2, i32 1
%r223 = load i64, i64* %r222
%r225 = getelementptr i64, i64* %r2, i32 3
%r226 = load i64, i64* %r225
%r227 = call i128 @mul64x64L(i64 %r223, i64 %r226)
%r228 = zext i128 %r220 to i256
%r229 = zext i128 %r227 to i256
%r230 = shl i256 %r229, 128
%r231 = or i256 %r228, %r230
%r233 = getelementptr i64, i64* %r2, i32 2
%r234 = load i64, i64* %r233
%r236 = getelementptr i64, i64* %r2, i32 4
%r237 = load i64, i64* %r236
%r238 = call i128 @mul64x64L(i64 %r234, i64 %r237)
%r239 = zext i256 %r231 to i384
%r240 = zext i128 %r238 to i384
%r241 = shl i384 %r240, 256
%r242 = or i384 %r239, %r241
%r244 = getelementptr i64, i64* %r2, i32 3
%r245 = load i64, i64* %r244
%r247 = getelementptr i64, i64* %r2, i32 5
%r248 = load i64, i64* %r247
%r249 = call i128 @mul64x64L(i64 %r245, i64 %r248)
%r250 = zext i384 %r242 to i512
%r251 = zext i128 %r249 to i512
%r252 = shl i512 %r251, 384
%r253 = or i512 %r250, %r252
%r255 = getelementptr i64, i64* %r2, i32 4
%r256 = load i64, i64* %r255
%r258 = getelementptr i64, i64* %r2, i32 6
%r259 = load i64, i64* %r258
%r260 = call i128 @mul64x64L(i64 %r256, i64 %r259)
%r261 = zext i512 %r253 to i640
%r262 = zext i128 %r260 to i640
%r263 = shl i640 %r262, 512
%r264 = or i640 %r261, %r263
%r266 = getelementptr i64, i64* %r2, i32 5
%r267 = load i64, i64* %r266
%r269 = getelementptr i64, i64* %r2, i32 7
%r270 = load i64, i64* %r269
%r271 = call i128 @mul64x64L(i64 %r267, i64 %r270)
%r272 = zext i640 %r264 to i768
%r273 = zext i128 %r271 to i768
%r274 = shl i768 %r273, 640
%r275 = or i768 %r272, %r274
%r277 = getelementptr i64, i64* %r2, i32 6
%r278 = load i64, i64* %r277
%r280 = getelementptr i64, i64* %r2, i32 8
%r281 = load i64, i64* %r280
%r282 = call i128 @mul64x64L(i64 %r278, i64 %r281)
%r283 = zext i768 %r275 to i896
%r284 = zext i128 %r282 to i896
%r285 = shl i896 %r284, 768
%r286 = or i896 %r283, %r285
%r287 = zext i768 %r215 to i896
%r288 = shl i896 %r287, 64
%r289 = add i896 %r288, %r286
%r290 = load i64, i64* %r2
%r292 = getelementptr i64, i64* %r2, i32 1
%r293 = load i64, i64* %r292
%r294 = call i128 @mul64x64L(i64 %r290, i64 %r293)
%r296 = getelementptr i64, i64* %r2, i32 1
%r297 = load i64, i64* %r296
%r299 = getelementptr i64, i64* %r2, i32 2
%r300 = load i64, i64* %r299
%r301 = call i128 @mul64x64L(i64 %r297, i64 %r300)
%r302 = zext i128 %r294 to i256
%r303 = zext i128 %r301 to i256
%r304 = shl i256 %r303, 128
%r305 = or i256 %r302, %r304
%r307 = getelementptr i64, i64* %r2, i32 2
%r308 = load i64, i64* %r307
%r310 = getelementptr i64, i64* %r2, i32 3
%r311 = load i64, i64* %r310
%r312 = call i128 @mul64x64L(i64 %r308, i64 %r311)
%r313 = zext i256 %r305 to i384
%r314 = zext i128 %r312 to i384
%r315 = shl i384 %r314, 256
%r316 = or i384 %r313, %r315
%r318 = getelementptr i64, i64* %r2, i32 3
%r319 = load i64, i64* %r318
%r321 = getelementptr i64, i64* %r2, i32 4
%r322 = load i64, i64* %r321
%r323 = call i128 @mul64x64L(i64 %r319, i64 %r322)
%r324 = zext i384 %r316 to i512
%r325 = zext i128 %r323 to i512
%r326 = shl i512 %r325, 384
%r327 = or i512 %r324, %r326
%r329 = getelementptr i64, i64* %r2, i32 4
%r330 = load i64, i64* %r329
%r332 = getelementptr i64, i64* %r2, i32 5
%r333 = load i64, i64* %r332
%r334 = call i128 @mul64x64L(i64 %r330, i64 %r333)
%r335 = zext i512 %r327 to i640
%r336 = zext i128 %r334 to i640
%r337 = shl i640 %r336, 512
%r338 = or i640 %r335, %r337
%r340 = getelementptr i64, i64* %r2, i32 5
%r341 = load i64, i64* %r340
%r343 = getelementptr i64, i64* %r2, i32 6
%r344 = load i64, i64* %r343
%r345 = call i128 @mul64x64L(i64 %r341, i64 %r344)
%r346 = zext i640 %r338 to i768
%r347 = zext i128 %r345 to i768
%r348 = shl i768 %r347, 640
%r349 = or i768 %r346, %r348
%r351 = getelementptr i64, i64* %r2, i32 6
%r352 = load i64, i64* %r351
%r354 = getelementptr i64, i64* %r2, i32 7
%r355 = load i64, i64* %r354
%r356 = call i128 @mul64x64L(i64 %r352, i64 %r355)
%r357 = zext i768 %r349 to i896
%r358 = zext i128 %r356 to i896
%r359 = shl i896 %r358, 768
%r360 = or i896 %r357, %r359
%r362 = getelementptr i64, i64* %r2, i32 7
%r363 = load i64, i64* %r362
%r365 = getelementptr i64, i64* %r2, i32 8
%r366 = load i64, i64* %r365
%r367 = call i128 @mul64x64L(i64 %r363, i64 %r366)
%r368 = zext i896 %r360 to i1024
%r369 = zext i128 %r367 to i1024
%r370 = shl i1024 %r369, 896
%r371 = or i1024 %r368, %r370
%r372 = zext i896 %r289 to i1024
%r373 = shl i1024 %r372, 64
%r374 = add i1024 %r373, %r371
%r375 = zext i128 %r6 to i1088
%r377 = getelementptr i64, i64* %r2, i32 1
%r378 = load i64, i64* %r377
%r379 = call i128 @mul64x64L(i64 %r378, i64 %r378)
%r380 = zext i128 %r379 to i1088
%r381 = shl i1088 %r380, 64
%r382 = or i1088 %r375, %r381
%r384 = getelementptr i64, i64* %r2, i32 2
%r385 = load i64, i64* %r384
%r386 = call i128 @mul64x64L(i64 %r385, i64 %r385)
%r387 = zext i128 %r386 to i1088
%r388 = shl i1088 %r387, 192
%r389 = or i1088 %r382, %r388
%r391 = getelementptr i64, i64* %r2, i32 3
%r392 = load i64, i64* %r391
%r393 = call i128 @mul64x64L(i64 %r392, i64 %r392)
%r394 = zext i128 %r393 to i1088
%r395 = shl i1088 %r394, 320
%r396 = or i1088 %r389, %r395
%r398 = getelementptr i64, i64* %r2, i32 4
%r399 = load i64, i64* %r398
%r400 = call i128 @mul64x64L(i64 %r399, i64 %r399)
%r401 = zext i128 %r400 to i1088
%r402 = shl i1088 %r401, 448
%r403 = or i1088 %r396, %r402
%r405 = getelementptr i64, i64* %r2, i32 5
%r406 = load i64, i64* %r405
%r407 = call i128 @mul64x64L(i64 %r406, i64 %r406)
%r408 = zext i128 %r407 to i1088
%r409 = shl i1088 %r408, 576
%r410 = or i1088 %r403, %r409
%r412 = getelementptr i64, i64* %r2, i32 6
%r413 = load i64, i64* %r412
%r414 = call i128 @mul64x64L(i64 %r413, i64 %r413)
%r415 = zext i128 %r414 to i1088
%r416 = shl i1088 %r415, 704
%r417 = or i1088 %r410, %r416
%r419 = getelementptr i64, i64* %r2, i32 7
%r420 = load i64, i64* %r419
%r421 = call i128 @mul64x64L(i64 %r420, i64 %r420)
%r422 = zext i128 %r421 to i1088
%r423 = shl i1088 %r422, 832
%r424 = or i1088 %r417, %r423
%r426 = getelementptr i64, i64* %r2, i32 8
%r427 = load i64, i64* %r426
%r428 = call i128 @mul64x64L(i64 %r427, i64 %r427)
%r429 = zext i128 %r428 to i1088
%r430 = shl i1088 %r429, 960
%r431 = or i1088 %r424, %r430
%r432 = zext i1024 %r374 to i1088
%r433 = add i1088 %r432, %r432
%r434 = add i1088 %r431, %r433
%r436 = getelementptr i64, i64* %r1, i32 1
%r438 = getelementptr i64, i64* %r436, i32 0
%r439 = trunc i1088 %r434 to i64
store i64 %r439, i64* %r438
%r440 = lshr i1088 %r434, 64
%r442 = getelementptr i64, i64* %r436, i32 1
%r443 = trunc i1088 %r440 to i64
store i64 %r443, i64* %r442
%r444 = lshr i1088 %r440, 64
%r446 = getelementptr i64, i64* %r436, i32 2
%r447 = trunc i1088 %r444 to i64
store i64 %r447, i64* %r446
%r448 = lshr i1088 %r444, 64
%r450 = getelementptr i64, i64* %r436, i32 3
%r451 = trunc i1088 %r448 to i64
store i64 %r451, i64* %r450
%r452 = lshr i1088 %r448, 64
%r454 = getelementptr i64, i64* %r436, i32 4
%r455 = trunc i1088 %r452 to i64
store i64 %r455, i64* %r454
%r456 = lshr i1088 %r452, 64
%r458 = getelementptr i64, i64* %r436, i32 5
%r459 = trunc i1088 %r456 to i64
store i64 %r459, i64* %r458
%r460 = lshr i1088 %r456, 64
%r462 = getelementptr i64, i64* %r436, i32 6
%r463 = trunc i1088 %r460 to i64
store i64 %r463, i64* %r462
%r464 = lshr i1088 %r460, 64
%r466 = getelementptr i64, i64* %r436, i32 7
%r467 = trunc i1088 %r464 to i64
store i64 %r467, i64* %r466
%r468 = lshr i1088 %r464, 64
%r470 = getelementptr i64, i64* %r436, i32 8
%r471 = trunc i1088 %r468 to i64
store i64 %r471, i64* %r470
%r472 = lshr i1088 %r468, 64
%r474 = getelementptr i64, i64* %r436, i32 9
%r475 = trunc i1088 %r472 to i64
store i64 %r475, i64* %r474
%r476 = lshr i1088 %r472, 64
%r478 = getelementptr i64, i64* %r436, i32 10
%r479 = trunc i1088 %r476 to i64
store i64 %r479, i64* %r478
%r480 = lshr i1088 %r476, 64
%r482 = getelementptr i64, i64* %r436, i32 11
%r483 = trunc i1088 %r480 to i64
store i64 %r483, i64* %r482
%r484 = lshr i1088 %r480, 64
%r486 = getelementptr i64, i64* %r436, i32 12
%r487 = trunc i1088 %r484 to i64
store i64 %r487, i64* %r486
%r488 = lshr i1088 %r484, 64
%r490 = getelementptr i64, i64* %r436, i32 13
%r491 = trunc i1088 %r488 to i64
store i64 %r491, i64* %r490
%r492 = lshr i1088 %r488, 64
%r494 = getelementptr i64, i64* %r436, i32 14
%r495 = trunc i1088 %r492 to i64
store i64 %r495, i64* %r494
%r496 = lshr i1088 %r492, 64
%r498 = getelementptr i64, i64* %r436, i32 15
%r499 = trunc i1088 %r496 to i64
store i64 %r499, i64* %r498
%r500 = lshr i1088 %r496, 64
%r502 = getelementptr i64, i64* %r436, i32 16
%r503 = trunc i1088 %r500 to i64
store i64 %r503, i64* %r502
ret void
}
