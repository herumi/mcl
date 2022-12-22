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
define i64 @mclb_add17(i64* noalias  %r2, i64* noalias  %r3, i64* noalias  %r4)
{
%r6 = bitcast i64* %r3 to i1088*
%r7 = load i1088, i1088* %r6
%r8 = zext i1088 %r7 to i1152
%r10 = bitcast i64* %r4 to i1088*
%r11 = load i1088, i1088* %r10
%r12 = zext i1088 %r11 to i1152
%r13 = add i1152 %r8, %r12
%r14 = trunc i1152 %r13 to i1088
%r16 = getelementptr i64, i64* %r2, i32 0
%r17 = trunc i1088 %r14 to i64
store i64 %r17, i64* %r16
%r18 = lshr i1088 %r14, 64
%r20 = getelementptr i64, i64* %r2, i32 1
%r21 = trunc i1088 %r18 to i64
store i64 %r21, i64* %r20
%r22 = lshr i1088 %r18, 64
%r24 = getelementptr i64, i64* %r2, i32 2
%r25 = trunc i1088 %r22 to i64
store i64 %r25, i64* %r24
%r26 = lshr i1088 %r22, 64
%r28 = getelementptr i64, i64* %r2, i32 3
%r29 = trunc i1088 %r26 to i64
store i64 %r29, i64* %r28
%r30 = lshr i1088 %r26, 64
%r32 = getelementptr i64, i64* %r2, i32 4
%r33 = trunc i1088 %r30 to i64
store i64 %r33, i64* %r32
%r34 = lshr i1088 %r30, 64
%r36 = getelementptr i64, i64* %r2, i32 5
%r37 = trunc i1088 %r34 to i64
store i64 %r37, i64* %r36
%r38 = lshr i1088 %r34, 64
%r40 = getelementptr i64, i64* %r2, i32 6
%r41 = trunc i1088 %r38 to i64
store i64 %r41, i64* %r40
%r42 = lshr i1088 %r38, 64
%r44 = getelementptr i64, i64* %r2, i32 7
%r45 = trunc i1088 %r42 to i64
store i64 %r45, i64* %r44
%r46 = lshr i1088 %r42, 64
%r48 = getelementptr i64, i64* %r2, i32 8
%r49 = trunc i1088 %r46 to i64
store i64 %r49, i64* %r48
%r50 = lshr i1088 %r46, 64
%r52 = getelementptr i64, i64* %r2, i32 9
%r53 = trunc i1088 %r50 to i64
store i64 %r53, i64* %r52
%r54 = lshr i1088 %r50, 64
%r56 = getelementptr i64, i64* %r2, i32 10
%r57 = trunc i1088 %r54 to i64
store i64 %r57, i64* %r56
%r58 = lshr i1088 %r54, 64
%r60 = getelementptr i64, i64* %r2, i32 11
%r61 = trunc i1088 %r58 to i64
store i64 %r61, i64* %r60
%r62 = lshr i1088 %r58, 64
%r64 = getelementptr i64, i64* %r2, i32 12
%r65 = trunc i1088 %r62 to i64
store i64 %r65, i64* %r64
%r66 = lshr i1088 %r62, 64
%r68 = getelementptr i64, i64* %r2, i32 13
%r69 = trunc i1088 %r66 to i64
store i64 %r69, i64* %r68
%r70 = lshr i1088 %r66, 64
%r72 = getelementptr i64, i64* %r2, i32 14
%r73 = trunc i1088 %r70 to i64
store i64 %r73, i64* %r72
%r74 = lshr i1088 %r70, 64
%r76 = getelementptr i64, i64* %r2, i32 15
%r77 = trunc i1088 %r74 to i64
store i64 %r77, i64* %r76
%r78 = lshr i1088 %r74, 64
%r80 = getelementptr i64, i64* %r2, i32 16
%r81 = trunc i1088 %r78 to i64
store i64 %r81, i64* %r80
%r82 = lshr i1152 %r13, 1088
%r83 = trunc i1152 %r82 to i64
ret i64 %r83
}
define i64 @mclb_sub17(i64* noalias  %r2, i64* noalias  %r3, i64* noalias  %r4)
{
%r6 = bitcast i64* %r3 to i1088*
%r7 = load i1088, i1088* %r6
%r8 = zext i1088 %r7 to i1152
%r10 = bitcast i64* %r4 to i1088*
%r11 = load i1088, i1088* %r10
%r12 = zext i1088 %r11 to i1152
%r13 = sub i1152 %r8, %r12
%r14 = trunc i1152 %r13 to i1088
%r16 = getelementptr i64, i64* %r2, i32 0
%r17 = trunc i1088 %r14 to i64
store i64 %r17, i64* %r16
%r18 = lshr i1088 %r14, 64
%r20 = getelementptr i64, i64* %r2, i32 1
%r21 = trunc i1088 %r18 to i64
store i64 %r21, i64* %r20
%r22 = lshr i1088 %r18, 64
%r24 = getelementptr i64, i64* %r2, i32 2
%r25 = trunc i1088 %r22 to i64
store i64 %r25, i64* %r24
%r26 = lshr i1088 %r22, 64
%r28 = getelementptr i64, i64* %r2, i32 3
%r29 = trunc i1088 %r26 to i64
store i64 %r29, i64* %r28
%r30 = lshr i1088 %r26, 64
%r32 = getelementptr i64, i64* %r2, i32 4
%r33 = trunc i1088 %r30 to i64
store i64 %r33, i64* %r32
%r34 = lshr i1088 %r30, 64
%r36 = getelementptr i64, i64* %r2, i32 5
%r37 = trunc i1088 %r34 to i64
store i64 %r37, i64* %r36
%r38 = lshr i1088 %r34, 64
%r40 = getelementptr i64, i64* %r2, i32 6
%r41 = trunc i1088 %r38 to i64
store i64 %r41, i64* %r40
%r42 = lshr i1088 %r38, 64
%r44 = getelementptr i64, i64* %r2, i32 7
%r45 = trunc i1088 %r42 to i64
store i64 %r45, i64* %r44
%r46 = lshr i1088 %r42, 64
%r48 = getelementptr i64, i64* %r2, i32 8
%r49 = trunc i1088 %r46 to i64
store i64 %r49, i64* %r48
%r50 = lshr i1088 %r46, 64
%r52 = getelementptr i64, i64* %r2, i32 9
%r53 = trunc i1088 %r50 to i64
store i64 %r53, i64* %r52
%r54 = lshr i1088 %r50, 64
%r56 = getelementptr i64, i64* %r2, i32 10
%r57 = trunc i1088 %r54 to i64
store i64 %r57, i64* %r56
%r58 = lshr i1088 %r54, 64
%r60 = getelementptr i64, i64* %r2, i32 11
%r61 = trunc i1088 %r58 to i64
store i64 %r61, i64* %r60
%r62 = lshr i1088 %r58, 64
%r64 = getelementptr i64, i64* %r2, i32 12
%r65 = trunc i1088 %r62 to i64
store i64 %r65, i64* %r64
%r66 = lshr i1088 %r62, 64
%r68 = getelementptr i64, i64* %r2, i32 13
%r69 = trunc i1088 %r66 to i64
store i64 %r69, i64* %r68
%r70 = lshr i1088 %r66, 64
%r72 = getelementptr i64, i64* %r2, i32 14
%r73 = trunc i1088 %r70 to i64
store i64 %r73, i64* %r72
%r74 = lshr i1088 %r70, 64
%r76 = getelementptr i64, i64* %r2, i32 15
%r77 = trunc i1088 %r74 to i64
store i64 %r77, i64* %r76
%r78 = lshr i1088 %r74, 64
%r80 = getelementptr i64, i64* %r2, i32 16
%r81 = trunc i1088 %r78 to i64
store i64 %r81, i64* %r80
%r82 = lshr i1152 %r13, 1088
%r83 = trunc i1152 %r82 to i64
%r85 = and i64 %r83, 1
ret i64 %r85
}
define void @mclb_addNF17(i64* noalias  %r1, i64* noalias  %r2, i64* noalias  %r3)
{
%r5 = bitcast i64* %r2 to i1088*
%r6 = load i1088, i1088* %r5
%r8 = bitcast i64* %r3 to i1088*
%r9 = load i1088, i1088* %r8
%r10 = add i1088 %r6, %r9
%r12 = getelementptr i64, i64* %r1, i32 0
%r13 = trunc i1088 %r10 to i64
store i64 %r13, i64* %r12
%r14 = lshr i1088 %r10, 64
%r16 = getelementptr i64, i64* %r1, i32 1
%r17 = trunc i1088 %r14 to i64
store i64 %r17, i64* %r16
%r18 = lshr i1088 %r14, 64
%r20 = getelementptr i64, i64* %r1, i32 2
%r21 = trunc i1088 %r18 to i64
store i64 %r21, i64* %r20
%r22 = lshr i1088 %r18, 64
%r24 = getelementptr i64, i64* %r1, i32 3
%r25 = trunc i1088 %r22 to i64
store i64 %r25, i64* %r24
%r26 = lshr i1088 %r22, 64
%r28 = getelementptr i64, i64* %r1, i32 4
%r29 = trunc i1088 %r26 to i64
store i64 %r29, i64* %r28
%r30 = lshr i1088 %r26, 64
%r32 = getelementptr i64, i64* %r1, i32 5
%r33 = trunc i1088 %r30 to i64
store i64 %r33, i64* %r32
%r34 = lshr i1088 %r30, 64
%r36 = getelementptr i64, i64* %r1, i32 6
%r37 = trunc i1088 %r34 to i64
store i64 %r37, i64* %r36
%r38 = lshr i1088 %r34, 64
%r40 = getelementptr i64, i64* %r1, i32 7
%r41 = trunc i1088 %r38 to i64
store i64 %r41, i64* %r40
%r42 = lshr i1088 %r38, 64
%r44 = getelementptr i64, i64* %r1, i32 8
%r45 = trunc i1088 %r42 to i64
store i64 %r45, i64* %r44
%r46 = lshr i1088 %r42, 64
%r48 = getelementptr i64, i64* %r1, i32 9
%r49 = trunc i1088 %r46 to i64
store i64 %r49, i64* %r48
%r50 = lshr i1088 %r46, 64
%r52 = getelementptr i64, i64* %r1, i32 10
%r53 = trunc i1088 %r50 to i64
store i64 %r53, i64* %r52
%r54 = lshr i1088 %r50, 64
%r56 = getelementptr i64, i64* %r1, i32 11
%r57 = trunc i1088 %r54 to i64
store i64 %r57, i64* %r56
%r58 = lshr i1088 %r54, 64
%r60 = getelementptr i64, i64* %r1, i32 12
%r61 = trunc i1088 %r58 to i64
store i64 %r61, i64* %r60
%r62 = lshr i1088 %r58, 64
%r64 = getelementptr i64, i64* %r1, i32 13
%r65 = trunc i1088 %r62 to i64
store i64 %r65, i64* %r64
%r66 = lshr i1088 %r62, 64
%r68 = getelementptr i64, i64* %r1, i32 14
%r69 = trunc i1088 %r66 to i64
store i64 %r69, i64* %r68
%r70 = lshr i1088 %r66, 64
%r72 = getelementptr i64, i64* %r1, i32 15
%r73 = trunc i1088 %r70 to i64
store i64 %r73, i64* %r72
%r74 = lshr i1088 %r70, 64
%r76 = getelementptr i64, i64* %r1, i32 16
%r77 = trunc i1088 %r74 to i64
store i64 %r77, i64* %r76
ret void
}
define i64 @mclb_subNF17(i64* noalias  %r2, i64* noalias  %r3, i64* noalias  %r4)
{
%r6 = bitcast i64* %r3 to i1088*
%r7 = load i1088, i1088* %r6
%r9 = bitcast i64* %r4 to i1088*
%r10 = load i1088, i1088* %r9
%r11 = sub i1088 %r7, %r10
%r13 = getelementptr i64, i64* %r2, i32 0
%r14 = trunc i1088 %r11 to i64
store i64 %r14, i64* %r13
%r15 = lshr i1088 %r11, 64
%r17 = getelementptr i64, i64* %r2, i32 1
%r18 = trunc i1088 %r15 to i64
store i64 %r18, i64* %r17
%r19 = lshr i1088 %r15, 64
%r21 = getelementptr i64, i64* %r2, i32 2
%r22 = trunc i1088 %r19 to i64
store i64 %r22, i64* %r21
%r23 = lshr i1088 %r19, 64
%r25 = getelementptr i64, i64* %r2, i32 3
%r26 = trunc i1088 %r23 to i64
store i64 %r26, i64* %r25
%r27 = lshr i1088 %r23, 64
%r29 = getelementptr i64, i64* %r2, i32 4
%r30 = trunc i1088 %r27 to i64
store i64 %r30, i64* %r29
%r31 = lshr i1088 %r27, 64
%r33 = getelementptr i64, i64* %r2, i32 5
%r34 = trunc i1088 %r31 to i64
store i64 %r34, i64* %r33
%r35 = lshr i1088 %r31, 64
%r37 = getelementptr i64, i64* %r2, i32 6
%r38 = trunc i1088 %r35 to i64
store i64 %r38, i64* %r37
%r39 = lshr i1088 %r35, 64
%r41 = getelementptr i64, i64* %r2, i32 7
%r42 = trunc i1088 %r39 to i64
store i64 %r42, i64* %r41
%r43 = lshr i1088 %r39, 64
%r45 = getelementptr i64, i64* %r2, i32 8
%r46 = trunc i1088 %r43 to i64
store i64 %r46, i64* %r45
%r47 = lshr i1088 %r43, 64
%r49 = getelementptr i64, i64* %r2, i32 9
%r50 = trunc i1088 %r47 to i64
store i64 %r50, i64* %r49
%r51 = lshr i1088 %r47, 64
%r53 = getelementptr i64, i64* %r2, i32 10
%r54 = trunc i1088 %r51 to i64
store i64 %r54, i64* %r53
%r55 = lshr i1088 %r51, 64
%r57 = getelementptr i64, i64* %r2, i32 11
%r58 = trunc i1088 %r55 to i64
store i64 %r58, i64* %r57
%r59 = lshr i1088 %r55, 64
%r61 = getelementptr i64, i64* %r2, i32 12
%r62 = trunc i1088 %r59 to i64
store i64 %r62, i64* %r61
%r63 = lshr i1088 %r59, 64
%r65 = getelementptr i64, i64* %r2, i32 13
%r66 = trunc i1088 %r63 to i64
store i64 %r66, i64* %r65
%r67 = lshr i1088 %r63, 64
%r69 = getelementptr i64, i64* %r2, i32 14
%r70 = trunc i1088 %r67 to i64
store i64 %r70, i64* %r69
%r71 = lshr i1088 %r67, 64
%r73 = getelementptr i64, i64* %r2, i32 15
%r74 = trunc i1088 %r71 to i64
store i64 %r74, i64* %r73
%r75 = lshr i1088 %r71, 64
%r77 = getelementptr i64, i64* %r2, i32 16
%r78 = trunc i1088 %r75 to i64
store i64 %r78, i64* %r77
%r79 = lshr i1088 %r11, 1087
%r80 = trunc i1088 %r79 to i64
%r82 = and i64 %r80, 1
ret i64 %r82
}
define i64 @mclb_add18(i64* noalias  %r2, i64* noalias  %r3, i64* noalias  %r4)
{
%r6 = bitcast i64* %r3 to i1152*
%r7 = load i1152, i1152* %r6
%r8 = zext i1152 %r7 to i1216
%r10 = bitcast i64* %r4 to i1152*
%r11 = load i1152, i1152* %r10
%r12 = zext i1152 %r11 to i1216
%r13 = add i1216 %r8, %r12
%r14 = trunc i1216 %r13 to i1152
%r16 = getelementptr i64, i64* %r2, i32 0
%r17 = trunc i1152 %r14 to i64
store i64 %r17, i64* %r16
%r18 = lshr i1152 %r14, 64
%r20 = getelementptr i64, i64* %r2, i32 1
%r21 = trunc i1152 %r18 to i64
store i64 %r21, i64* %r20
%r22 = lshr i1152 %r18, 64
%r24 = getelementptr i64, i64* %r2, i32 2
%r25 = trunc i1152 %r22 to i64
store i64 %r25, i64* %r24
%r26 = lshr i1152 %r22, 64
%r28 = getelementptr i64, i64* %r2, i32 3
%r29 = trunc i1152 %r26 to i64
store i64 %r29, i64* %r28
%r30 = lshr i1152 %r26, 64
%r32 = getelementptr i64, i64* %r2, i32 4
%r33 = trunc i1152 %r30 to i64
store i64 %r33, i64* %r32
%r34 = lshr i1152 %r30, 64
%r36 = getelementptr i64, i64* %r2, i32 5
%r37 = trunc i1152 %r34 to i64
store i64 %r37, i64* %r36
%r38 = lshr i1152 %r34, 64
%r40 = getelementptr i64, i64* %r2, i32 6
%r41 = trunc i1152 %r38 to i64
store i64 %r41, i64* %r40
%r42 = lshr i1152 %r38, 64
%r44 = getelementptr i64, i64* %r2, i32 7
%r45 = trunc i1152 %r42 to i64
store i64 %r45, i64* %r44
%r46 = lshr i1152 %r42, 64
%r48 = getelementptr i64, i64* %r2, i32 8
%r49 = trunc i1152 %r46 to i64
store i64 %r49, i64* %r48
%r50 = lshr i1152 %r46, 64
%r52 = getelementptr i64, i64* %r2, i32 9
%r53 = trunc i1152 %r50 to i64
store i64 %r53, i64* %r52
%r54 = lshr i1152 %r50, 64
%r56 = getelementptr i64, i64* %r2, i32 10
%r57 = trunc i1152 %r54 to i64
store i64 %r57, i64* %r56
%r58 = lshr i1152 %r54, 64
%r60 = getelementptr i64, i64* %r2, i32 11
%r61 = trunc i1152 %r58 to i64
store i64 %r61, i64* %r60
%r62 = lshr i1152 %r58, 64
%r64 = getelementptr i64, i64* %r2, i32 12
%r65 = trunc i1152 %r62 to i64
store i64 %r65, i64* %r64
%r66 = lshr i1152 %r62, 64
%r68 = getelementptr i64, i64* %r2, i32 13
%r69 = trunc i1152 %r66 to i64
store i64 %r69, i64* %r68
%r70 = lshr i1152 %r66, 64
%r72 = getelementptr i64, i64* %r2, i32 14
%r73 = trunc i1152 %r70 to i64
store i64 %r73, i64* %r72
%r74 = lshr i1152 %r70, 64
%r76 = getelementptr i64, i64* %r2, i32 15
%r77 = trunc i1152 %r74 to i64
store i64 %r77, i64* %r76
%r78 = lshr i1152 %r74, 64
%r80 = getelementptr i64, i64* %r2, i32 16
%r81 = trunc i1152 %r78 to i64
store i64 %r81, i64* %r80
%r82 = lshr i1152 %r78, 64
%r84 = getelementptr i64, i64* %r2, i32 17
%r85 = trunc i1152 %r82 to i64
store i64 %r85, i64* %r84
%r86 = lshr i1216 %r13, 1152
%r87 = trunc i1216 %r86 to i64
ret i64 %r87
}
define i64 @mclb_sub18(i64* noalias  %r2, i64* noalias  %r3, i64* noalias  %r4)
{
%r6 = bitcast i64* %r3 to i1152*
%r7 = load i1152, i1152* %r6
%r8 = zext i1152 %r7 to i1216
%r10 = bitcast i64* %r4 to i1152*
%r11 = load i1152, i1152* %r10
%r12 = zext i1152 %r11 to i1216
%r13 = sub i1216 %r8, %r12
%r14 = trunc i1216 %r13 to i1152
%r16 = getelementptr i64, i64* %r2, i32 0
%r17 = trunc i1152 %r14 to i64
store i64 %r17, i64* %r16
%r18 = lshr i1152 %r14, 64
%r20 = getelementptr i64, i64* %r2, i32 1
%r21 = trunc i1152 %r18 to i64
store i64 %r21, i64* %r20
%r22 = lshr i1152 %r18, 64
%r24 = getelementptr i64, i64* %r2, i32 2
%r25 = trunc i1152 %r22 to i64
store i64 %r25, i64* %r24
%r26 = lshr i1152 %r22, 64
%r28 = getelementptr i64, i64* %r2, i32 3
%r29 = trunc i1152 %r26 to i64
store i64 %r29, i64* %r28
%r30 = lshr i1152 %r26, 64
%r32 = getelementptr i64, i64* %r2, i32 4
%r33 = trunc i1152 %r30 to i64
store i64 %r33, i64* %r32
%r34 = lshr i1152 %r30, 64
%r36 = getelementptr i64, i64* %r2, i32 5
%r37 = trunc i1152 %r34 to i64
store i64 %r37, i64* %r36
%r38 = lshr i1152 %r34, 64
%r40 = getelementptr i64, i64* %r2, i32 6
%r41 = trunc i1152 %r38 to i64
store i64 %r41, i64* %r40
%r42 = lshr i1152 %r38, 64
%r44 = getelementptr i64, i64* %r2, i32 7
%r45 = trunc i1152 %r42 to i64
store i64 %r45, i64* %r44
%r46 = lshr i1152 %r42, 64
%r48 = getelementptr i64, i64* %r2, i32 8
%r49 = trunc i1152 %r46 to i64
store i64 %r49, i64* %r48
%r50 = lshr i1152 %r46, 64
%r52 = getelementptr i64, i64* %r2, i32 9
%r53 = trunc i1152 %r50 to i64
store i64 %r53, i64* %r52
%r54 = lshr i1152 %r50, 64
%r56 = getelementptr i64, i64* %r2, i32 10
%r57 = trunc i1152 %r54 to i64
store i64 %r57, i64* %r56
%r58 = lshr i1152 %r54, 64
%r60 = getelementptr i64, i64* %r2, i32 11
%r61 = trunc i1152 %r58 to i64
store i64 %r61, i64* %r60
%r62 = lshr i1152 %r58, 64
%r64 = getelementptr i64, i64* %r2, i32 12
%r65 = trunc i1152 %r62 to i64
store i64 %r65, i64* %r64
%r66 = lshr i1152 %r62, 64
%r68 = getelementptr i64, i64* %r2, i32 13
%r69 = trunc i1152 %r66 to i64
store i64 %r69, i64* %r68
%r70 = lshr i1152 %r66, 64
%r72 = getelementptr i64, i64* %r2, i32 14
%r73 = trunc i1152 %r70 to i64
store i64 %r73, i64* %r72
%r74 = lshr i1152 %r70, 64
%r76 = getelementptr i64, i64* %r2, i32 15
%r77 = trunc i1152 %r74 to i64
store i64 %r77, i64* %r76
%r78 = lshr i1152 %r74, 64
%r80 = getelementptr i64, i64* %r2, i32 16
%r81 = trunc i1152 %r78 to i64
store i64 %r81, i64* %r80
%r82 = lshr i1152 %r78, 64
%r84 = getelementptr i64, i64* %r2, i32 17
%r85 = trunc i1152 %r82 to i64
store i64 %r85, i64* %r84
%r86 = lshr i1216 %r13, 1152
%r87 = trunc i1216 %r86 to i64
%r89 = and i64 %r87, 1
ret i64 %r89
}
define void @mclb_addNF18(i64* noalias  %r1, i64* noalias  %r2, i64* noalias  %r3)
{
%r5 = bitcast i64* %r2 to i1152*
%r6 = load i1152, i1152* %r5
%r8 = bitcast i64* %r3 to i1152*
%r9 = load i1152, i1152* %r8
%r10 = add i1152 %r6, %r9
%r12 = getelementptr i64, i64* %r1, i32 0
%r13 = trunc i1152 %r10 to i64
store i64 %r13, i64* %r12
%r14 = lshr i1152 %r10, 64
%r16 = getelementptr i64, i64* %r1, i32 1
%r17 = trunc i1152 %r14 to i64
store i64 %r17, i64* %r16
%r18 = lshr i1152 %r14, 64
%r20 = getelementptr i64, i64* %r1, i32 2
%r21 = trunc i1152 %r18 to i64
store i64 %r21, i64* %r20
%r22 = lshr i1152 %r18, 64
%r24 = getelementptr i64, i64* %r1, i32 3
%r25 = trunc i1152 %r22 to i64
store i64 %r25, i64* %r24
%r26 = lshr i1152 %r22, 64
%r28 = getelementptr i64, i64* %r1, i32 4
%r29 = trunc i1152 %r26 to i64
store i64 %r29, i64* %r28
%r30 = lshr i1152 %r26, 64
%r32 = getelementptr i64, i64* %r1, i32 5
%r33 = trunc i1152 %r30 to i64
store i64 %r33, i64* %r32
%r34 = lshr i1152 %r30, 64
%r36 = getelementptr i64, i64* %r1, i32 6
%r37 = trunc i1152 %r34 to i64
store i64 %r37, i64* %r36
%r38 = lshr i1152 %r34, 64
%r40 = getelementptr i64, i64* %r1, i32 7
%r41 = trunc i1152 %r38 to i64
store i64 %r41, i64* %r40
%r42 = lshr i1152 %r38, 64
%r44 = getelementptr i64, i64* %r1, i32 8
%r45 = trunc i1152 %r42 to i64
store i64 %r45, i64* %r44
%r46 = lshr i1152 %r42, 64
%r48 = getelementptr i64, i64* %r1, i32 9
%r49 = trunc i1152 %r46 to i64
store i64 %r49, i64* %r48
%r50 = lshr i1152 %r46, 64
%r52 = getelementptr i64, i64* %r1, i32 10
%r53 = trunc i1152 %r50 to i64
store i64 %r53, i64* %r52
%r54 = lshr i1152 %r50, 64
%r56 = getelementptr i64, i64* %r1, i32 11
%r57 = trunc i1152 %r54 to i64
store i64 %r57, i64* %r56
%r58 = lshr i1152 %r54, 64
%r60 = getelementptr i64, i64* %r1, i32 12
%r61 = trunc i1152 %r58 to i64
store i64 %r61, i64* %r60
%r62 = lshr i1152 %r58, 64
%r64 = getelementptr i64, i64* %r1, i32 13
%r65 = trunc i1152 %r62 to i64
store i64 %r65, i64* %r64
%r66 = lshr i1152 %r62, 64
%r68 = getelementptr i64, i64* %r1, i32 14
%r69 = trunc i1152 %r66 to i64
store i64 %r69, i64* %r68
%r70 = lshr i1152 %r66, 64
%r72 = getelementptr i64, i64* %r1, i32 15
%r73 = trunc i1152 %r70 to i64
store i64 %r73, i64* %r72
%r74 = lshr i1152 %r70, 64
%r76 = getelementptr i64, i64* %r1, i32 16
%r77 = trunc i1152 %r74 to i64
store i64 %r77, i64* %r76
%r78 = lshr i1152 %r74, 64
%r80 = getelementptr i64, i64* %r1, i32 17
%r81 = trunc i1152 %r78 to i64
store i64 %r81, i64* %r80
ret void
}
define i64 @mclb_subNF18(i64* noalias  %r2, i64* noalias  %r3, i64* noalias  %r4)
{
%r6 = bitcast i64* %r3 to i1152*
%r7 = load i1152, i1152* %r6
%r9 = bitcast i64* %r4 to i1152*
%r10 = load i1152, i1152* %r9
%r11 = sub i1152 %r7, %r10
%r13 = getelementptr i64, i64* %r2, i32 0
%r14 = trunc i1152 %r11 to i64
store i64 %r14, i64* %r13
%r15 = lshr i1152 %r11, 64
%r17 = getelementptr i64, i64* %r2, i32 1
%r18 = trunc i1152 %r15 to i64
store i64 %r18, i64* %r17
%r19 = lshr i1152 %r15, 64
%r21 = getelementptr i64, i64* %r2, i32 2
%r22 = trunc i1152 %r19 to i64
store i64 %r22, i64* %r21
%r23 = lshr i1152 %r19, 64
%r25 = getelementptr i64, i64* %r2, i32 3
%r26 = trunc i1152 %r23 to i64
store i64 %r26, i64* %r25
%r27 = lshr i1152 %r23, 64
%r29 = getelementptr i64, i64* %r2, i32 4
%r30 = trunc i1152 %r27 to i64
store i64 %r30, i64* %r29
%r31 = lshr i1152 %r27, 64
%r33 = getelementptr i64, i64* %r2, i32 5
%r34 = trunc i1152 %r31 to i64
store i64 %r34, i64* %r33
%r35 = lshr i1152 %r31, 64
%r37 = getelementptr i64, i64* %r2, i32 6
%r38 = trunc i1152 %r35 to i64
store i64 %r38, i64* %r37
%r39 = lshr i1152 %r35, 64
%r41 = getelementptr i64, i64* %r2, i32 7
%r42 = trunc i1152 %r39 to i64
store i64 %r42, i64* %r41
%r43 = lshr i1152 %r39, 64
%r45 = getelementptr i64, i64* %r2, i32 8
%r46 = trunc i1152 %r43 to i64
store i64 %r46, i64* %r45
%r47 = lshr i1152 %r43, 64
%r49 = getelementptr i64, i64* %r2, i32 9
%r50 = trunc i1152 %r47 to i64
store i64 %r50, i64* %r49
%r51 = lshr i1152 %r47, 64
%r53 = getelementptr i64, i64* %r2, i32 10
%r54 = trunc i1152 %r51 to i64
store i64 %r54, i64* %r53
%r55 = lshr i1152 %r51, 64
%r57 = getelementptr i64, i64* %r2, i32 11
%r58 = trunc i1152 %r55 to i64
store i64 %r58, i64* %r57
%r59 = lshr i1152 %r55, 64
%r61 = getelementptr i64, i64* %r2, i32 12
%r62 = trunc i1152 %r59 to i64
store i64 %r62, i64* %r61
%r63 = lshr i1152 %r59, 64
%r65 = getelementptr i64, i64* %r2, i32 13
%r66 = trunc i1152 %r63 to i64
store i64 %r66, i64* %r65
%r67 = lshr i1152 %r63, 64
%r69 = getelementptr i64, i64* %r2, i32 14
%r70 = trunc i1152 %r67 to i64
store i64 %r70, i64* %r69
%r71 = lshr i1152 %r67, 64
%r73 = getelementptr i64, i64* %r2, i32 15
%r74 = trunc i1152 %r71 to i64
store i64 %r74, i64* %r73
%r75 = lshr i1152 %r71, 64
%r77 = getelementptr i64, i64* %r2, i32 16
%r78 = trunc i1152 %r75 to i64
store i64 %r78, i64* %r77
%r79 = lshr i1152 %r75, 64
%r81 = getelementptr i64, i64* %r2, i32 17
%r82 = trunc i1152 %r79 to i64
store i64 %r82, i64* %r81
%r83 = lshr i1152 %r11, 1151
%r84 = trunc i1152 %r83 to i64
%r86 = and i64 %r84, 1
ret i64 %r86
}
define i64 @mclb_add19(i64* noalias  %r2, i64* noalias  %r3, i64* noalias  %r4)
{
%r6 = bitcast i64* %r3 to i1216*
%r7 = load i1216, i1216* %r6
%r8 = zext i1216 %r7 to i1280
%r10 = bitcast i64* %r4 to i1216*
%r11 = load i1216, i1216* %r10
%r12 = zext i1216 %r11 to i1280
%r13 = add i1280 %r8, %r12
%r14 = trunc i1280 %r13 to i1216
%r16 = getelementptr i64, i64* %r2, i32 0
%r17 = trunc i1216 %r14 to i64
store i64 %r17, i64* %r16
%r18 = lshr i1216 %r14, 64
%r20 = getelementptr i64, i64* %r2, i32 1
%r21 = trunc i1216 %r18 to i64
store i64 %r21, i64* %r20
%r22 = lshr i1216 %r18, 64
%r24 = getelementptr i64, i64* %r2, i32 2
%r25 = trunc i1216 %r22 to i64
store i64 %r25, i64* %r24
%r26 = lshr i1216 %r22, 64
%r28 = getelementptr i64, i64* %r2, i32 3
%r29 = trunc i1216 %r26 to i64
store i64 %r29, i64* %r28
%r30 = lshr i1216 %r26, 64
%r32 = getelementptr i64, i64* %r2, i32 4
%r33 = trunc i1216 %r30 to i64
store i64 %r33, i64* %r32
%r34 = lshr i1216 %r30, 64
%r36 = getelementptr i64, i64* %r2, i32 5
%r37 = trunc i1216 %r34 to i64
store i64 %r37, i64* %r36
%r38 = lshr i1216 %r34, 64
%r40 = getelementptr i64, i64* %r2, i32 6
%r41 = trunc i1216 %r38 to i64
store i64 %r41, i64* %r40
%r42 = lshr i1216 %r38, 64
%r44 = getelementptr i64, i64* %r2, i32 7
%r45 = trunc i1216 %r42 to i64
store i64 %r45, i64* %r44
%r46 = lshr i1216 %r42, 64
%r48 = getelementptr i64, i64* %r2, i32 8
%r49 = trunc i1216 %r46 to i64
store i64 %r49, i64* %r48
%r50 = lshr i1216 %r46, 64
%r52 = getelementptr i64, i64* %r2, i32 9
%r53 = trunc i1216 %r50 to i64
store i64 %r53, i64* %r52
%r54 = lshr i1216 %r50, 64
%r56 = getelementptr i64, i64* %r2, i32 10
%r57 = trunc i1216 %r54 to i64
store i64 %r57, i64* %r56
%r58 = lshr i1216 %r54, 64
%r60 = getelementptr i64, i64* %r2, i32 11
%r61 = trunc i1216 %r58 to i64
store i64 %r61, i64* %r60
%r62 = lshr i1216 %r58, 64
%r64 = getelementptr i64, i64* %r2, i32 12
%r65 = trunc i1216 %r62 to i64
store i64 %r65, i64* %r64
%r66 = lshr i1216 %r62, 64
%r68 = getelementptr i64, i64* %r2, i32 13
%r69 = trunc i1216 %r66 to i64
store i64 %r69, i64* %r68
%r70 = lshr i1216 %r66, 64
%r72 = getelementptr i64, i64* %r2, i32 14
%r73 = trunc i1216 %r70 to i64
store i64 %r73, i64* %r72
%r74 = lshr i1216 %r70, 64
%r76 = getelementptr i64, i64* %r2, i32 15
%r77 = trunc i1216 %r74 to i64
store i64 %r77, i64* %r76
%r78 = lshr i1216 %r74, 64
%r80 = getelementptr i64, i64* %r2, i32 16
%r81 = trunc i1216 %r78 to i64
store i64 %r81, i64* %r80
%r82 = lshr i1216 %r78, 64
%r84 = getelementptr i64, i64* %r2, i32 17
%r85 = trunc i1216 %r82 to i64
store i64 %r85, i64* %r84
%r86 = lshr i1216 %r82, 64
%r88 = getelementptr i64, i64* %r2, i32 18
%r89 = trunc i1216 %r86 to i64
store i64 %r89, i64* %r88
%r90 = lshr i1280 %r13, 1216
%r91 = trunc i1280 %r90 to i64
ret i64 %r91
}
define i64 @mclb_sub19(i64* noalias  %r2, i64* noalias  %r3, i64* noalias  %r4)
{
%r6 = bitcast i64* %r3 to i1216*
%r7 = load i1216, i1216* %r6
%r8 = zext i1216 %r7 to i1280
%r10 = bitcast i64* %r4 to i1216*
%r11 = load i1216, i1216* %r10
%r12 = zext i1216 %r11 to i1280
%r13 = sub i1280 %r8, %r12
%r14 = trunc i1280 %r13 to i1216
%r16 = getelementptr i64, i64* %r2, i32 0
%r17 = trunc i1216 %r14 to i64
store i64 %r17, i64* %r16
%r18 = lshr i1216 %r14, 64
%r20 = getelementptr i64, i64* %r2, i32 1
%r21 = trunc i1216 %r18 to i64
store i64 %r21, i64* %r20
%r22 = lshr i1216 %r18, 64
%r24 = getelementptr i64, i64* %r2, i32 2
%r25 = trunc i1216 %r22 to i64
store i64 %r25, i64* %r24
%r26 = lshr i1216 %r22, 64
%r28 = getelementptr i64, i64* %r2, i32 3
%r29 = trunc i1216 %r26 to i64
store i64 %r29, i64* %r28
%r30 = lshr i1216 %r26, 64
%r32 = getelementptr i64, i64* %r2, i32 4
%r33 = trunc i1216 %r30 to i64
store i64 %r33, i64* %r32
%r34 = lshr i1216 %r30, 64
%r36 = getelementptr i64, i64* %r2, i32 5
%r37 = trunc i1216 %r34 to i64
store i64 %r37, i64* %r36
%r38 = lshr i1216 %r34, 64
%r40 = getelementptr i64, i64* %r2, i32 6
%r41 = trunc i1216 %r38 to i64
store i64 %r41, i64* %r40
%r42 = lshr i1216 %r38, 64
%r44 = getelementptr i64, i64* %r2, i32 7
%r45 = trunc i1216 %r42 to i64
store i64 %r45, i64* %r44
%r46 = lshr i1216 %r42, 64
%r48 = getelementptr i64, i64* %r2, i32 8
%r49 = trunc i1216 %r46 to i64
store i64 %r49, i64* %r48
%r50 = lshr i1216 %r46, 64
%r52 = getelementptr i64, i64* %r2, i32 9
%r53 = trunc i1216 %r50 to i64
store i64 %r53, i64* %r52
%r54 = lshr i1216 %r50, 64
%r56 = getelementptr i64, i64* %r2, i32 10
%r57 = trunc i1216 %r54 to i64
store i64 %r57, i64* %r56
%r58 = lshr i1216 %r54, 64
%r60 = getelementptr i64, i64* %r2, i32 11
%r61 = trunc i1216 %r58 to i64
store i64 %r61, i64* %r60
%r62 = lshr i1216 %r58, 64
%r64 = getelementptr i64, i64* %r2, i32 12
%r65 = trunc i1216 %r62 to i64
store i64 %r65, i64* %r64
%r66 = lshr i1216 %r62, 64
%r68 = getelementptr i64, i64* %r2, i32 13
%r69 = trunc i1216 %r66 to i64
store i64 %r69, i64* %r68
%r70 = lshr i1216 %r66, 64
%r72 = getelementptr i64, i64* %r2, i32 14
%r73 = trunc i1216 %r70 to i64
store i64 %r73, i64* %r72
%r74 = lshr i1216 %r70, 64
%r76 = getelementptr i64, i64* %r2, i32 15
%r77 = trunc i1216 %r74 to i64
store i64 %r77, i64* %r76
%r78 = lshr i1216 %r74, 64
%r80 = getelementptr i64, i64* %r2, i32 16
%r81 = trunc i1216 %r78 to i64
store i64 %r81, i64* %r80
%r82 = lshr i1216 %r78, 64
%r84 = getelementptr i64, i64* %r2, i32 17
%r85 = trunc i1216 %r82 to i64
store i64 %r85, i64* %r84
%r86 = lshr i1216 %r82, 64
%r88 = getelementptr i64, i64* %r2, i32 18
%r89 = trunc i1216 %r86 to i64
store i64 %r89, i64* %r88
%r90 = lshr i1280 %r13, 1216
%r91 = trunc i1280 %r90 to i64
%r93 = and i64 %r91, 1
ret i64 %r93
}
define void @mclb_addNF19(i64* noalias  %r1, i64* noalias  %r2, i64* noalias  %r3)
{
%r5 = bitcast i64* %r2 to i1216*
%r6 = load i1216, i1216* %r5
%r8 = bitcast i64* %r3 to i1216*
%r9 = load i1216, i1216* %r8
%r10 = add i1216 %r6, %r9
%r12 = getelementptr i64, i64* %r1, i32 0
%r13 = trunc i1216 %r10 to i64
store i64 %r13, i64* %r12
%r14 = lshr i1216 %r10, 64
%r16 = getelementptr i64, i64* %r1, i32 1
%r17 = trunc i1216 %r14 to i64
store i64 %r17, i64* %r16
%r18 = lshr i1216 %r14, 64
%r20 = getelementptr i64, i64* %r1, i32 2
%r21 = trunc i1216 %r18 to i64
store i64 %r21, i64* %r20
%r22 = lshr i1216 %r18, 64
%r24 = getelementptr i64, i64* %r1, i32 3
%r25 = trunc i1216 %r22 to i64
store i64 %r25, i64* %r24
%r26 = lshr i1216 %r22, 64
%r28 = getelementptr i64, i64* %r1, i32 4
%r29 = trunc i1216 %r26 to i64
store i64 %r29, i64* %r28
%r30 = lshr i1216 %r26, 64
%r32 = getelementptr i64, i64* %r1, i32 5
%r33 = trunc i1216 %r30 to i64
store i64 %r33, i64* %r32
%r34 = lshr i1216 %r30, 64
%r36 = getelementptr i64, i64* %r1, i32 6
%r37 = trunc i1216 %r34 to i64
store i64 %r37, i64* %r36
%r38 = lshr i1216 %r34, 64
%r40 = getelementptr i64, i64* %r1, i32 7
%r41 = trunc i1216 %r38 to i64
store i64 %r41, i64* %r40
%r42 = lshr i1216 %r38, 64
%r44 = getelementptr i64, i64* %r1, i32 8
%r45 = trunc i1216 %r42 to i64
store i64 %r45, i64* %r44
%r46 = lshr i1216 %r42, 64
%r48 = getelementptr i64, i64* %r1, i32 9
%r49 = trunc i1216 %r46 to i64
store i64 %r49, i64* %r48
%r50 = lshr i1216 %r46, 64
%r52 = getelementptr i64, i64* %r1, i32 10
%r53 = trunc i1216 %r50 to i64
store i64 %r53, i64* %r52
%r54 = lshr i1216 %r50, 64
%r56 = getelementptr i64, i64* %r1, i32 11
%r57 = trunc i1216 %r54 to i64
store i64 %r57, i64* %r56
%r58 = lshr i1216 %r54, 64
%r60 = getelementptr i64, i64* %r1, i32 12
%r61 = trunc i1216 %r58 to i64
store i64 %r61, i64* %r60
%r62 = lshr i1216 %r58, 64
%r64 = getelementptr i64, i64* %r1, i32 13
%r65 = trunc i1216 %r62 to i64
store i64 %r65, i64* %r64
%r66 = lshr i1216 %r62, 64
%r68 = getelementptr i64, i64* %r1, i32 14
%r69 = trunc i1216 %r66 to i64
store i64 %r69, i64* %r68
%r70 = lshr i1216 %r66, 64
%r72 = getelementptr i64, i64* %r1, i32 15
%r73 = trunc i1216 %r70 to i64
store i64 %r73, i64* %r72
%r74 = lshr i1216 %r70, 64
%r76 = getelementptr i64, i64* %r1, i32 16
%r77 = trunc i1216 %r74 to i64
store i64 %r77, i64* %r76
%r78 = lshr i1216 %r74, 64
%r80 = getelementptr i64, i64* %r1, i32 17
%r81 = trunc i1216 %r78 to i64
store i64 %r81, i64* %r80
%r82 = lshr i1216 %r78, 64
%r84 = getelementptr i64, i64* %r1, i32 18
%r85 = trunc i1216 %r82 to i64
store i64 %r85, i64* %r84
ret void
}
define i64 @mclb_subNF19(i64* noalias  %r2, i64* noalias  %r3, i64* noalias  %r4)
{
%r6 = bitcast i64* %r3 to i1216*
%r7 = load i1216, i1216* %r6
%r9 = bitcast i64* %r4 to i1216*
%r10 = load i1216, i1216* %r9
%r11 = sub i1216 %r7, %r10
%r13 = getelementptr i64, i64* %r2, i32 0
%r14 = trunc i1216 %r11 to i64
store i64 %r14, i64* %r13
%r15 = lshr i1216 %r11, 64
%r17 = getelementptr i64, i64* %r2, i32 1
%r18 = trunc i1216 %r15 to i64
store i64 %r18, i64* %r17
%r19 = lshr i1216 %r15, 64
%r21 = getelementptr i64, i64* %r2, i32 2
%r22 = trunc i1216 %r19 to i64
store i64 %r22, i64* %r21
%r23 = lshr i1216 %r19, 64
%r25 = getelementptr i64, i64* %r2, i32 3
%r26 = trunc i1216 %r23 to i64
store i64 %r26, i64* %r25
%r27 = lshr i1216 %r23, 64
%r29 = getelementptr i64, i64* %r2, i32 4
%r30 = trunc i1216 %r27 to i64
store i64 %r30, i64* %r29
%r31 = lshr i1216 %r27, 64
%r33 = getelementptr i64, i64* %r2, i32 5
%r34 = trunc i1216 %r31 to i64
store i64 %r34, i64* %r33
%r35 = lshr i1216 %r31, 64
%r37 = getelementptr i64, i64* %r2, i32 6
%r38 = trunc i1216 %r35 to i64
store i64 %r38, i64* %r37
%r39 = lshr i1216 %r35, 64
%r41 = getelementptr i64, i64* %r2, i32 7
%r42 = trunc i1216 %r39 to i64
store i64 %r42, i64* %r41
%r43 = lshr i1216 %r39, 64
%r45 = getelementptr i64, i64* %r2, i32 8
%r46 = trunc i1216 %r43 to i64
store i64 %r46, i64* %r45
%r47 = lshr i1216 %r43, 64
%r49 = getelementptr i64, i64* %r2, i32 9
%r50 = trunc i1216 %r47 to i64
store i64 %r50, i64* %r49
%r51 = lshr i1216 %r47, 64
%r53 = getelementptr i64, i64* %r2, i32 10
%r54 = trunc i1216 %r51 to i64
store i64 %r54, i64* %r53
%r55 = lshr i1216 %r51, 64
%r57 = getelementptr i64, i64* %r2, i32 11
%r58 = trunc i1216 %r55 to i64
store i64 %r58, i64* %r57
%r59 = lshr i1216 %r55, 64
%r61 = getelementptr i64, i64* %r2, i32 12
%r62 = trunc i1216 %r59 to i64
store i64 %r62, i64* %r61
%r63 = lshr i1216 %r59, 64
%r65 = getelementptr i64, i64* %r2, i32 13
%r66 = trunc i1216 %r63 to i64
store i64 %r66, i64* %r65
%r67 = lshr i1216 %r63, 64
%r69 = getelementptr i64, i64* %r2, i32 14
%r70 = trunc i1216 %r67 to i64
store i64 %r70, i64* %r69
%r71 = lshr i1216 %r67, 64
%r73 = getelementptr i64, i64* %r2, i32 15
%r74 = trunc i1216 %r71 to i64
store i64 %r74, i64* %r73
%r75 = lshr i1216 %r71, 64
%r77 = getelementptr i64, i64* %r2, i32 16
%r78 = trunc i1216 %r75 to i64
store i64 %r78, i64* %r77
%r79 = lshr i1216 %r75, 64
%r81 = getelementptr i64, i64* %r2, i32 17
%r82 = trunc i1216 %r79 to i64
store i64 %r82, i64* %r81
%r83 = lshr i1216 %r79, 64
%r85 = getelementptr i64, i64* %r2, i32 18
%r86 = trunc i1216 %r83 to i64
store i64 %r86, i64* %r85
%r87 = lshr i1216 %r11, 1215
%r88 = trunc i1216 %r87 to i64
%r90 = and i64 %r88, 1
ret i64 %r90
}
define i64 @mclb_add20(i64* noalias  %r2, i64* noalias  %r3, i64* noalias  %r4)
{
%r6 = bitcast i64* %r3 to i1280*
%r7 = load i1280, i1280* %r6
%r8 = zext i1280 %r7 to i1344
%r10 = bitcast i64* %r4 to i1280*
%r11 = load i1280, i1280* %r10
%r12 = zext i1280 %r11 to i1344
%r13 = add i1344 %r8, %r12
%r14 = trunc i1344 %r13 to i1280
%r16 = getelementptr i64, i64* %r2, i32 0
%r17 = trunc i1280 %r14 to i64
store i64 %r17, i64* %r16
%r18 = lshr i1280 %r14, 64
%r20 = getelementptr i64, i64* %r2, i32 1
%r21 = trunc i1280 %r18 to i64
store i64 %r21, i64* %r20
%r22 = lshr i1280 %r18, 64
%r24 = getelementptr i64, i64* %r2, i32 2
%r25 = trunc i1280 %r22 to i64
store i64 %r25, i64* %r24
%r26 = lshr i1280 %r22, 64
%r28 = getelementptr i64, i64* %r2, i32 3
%r29 = trunc i1280 %r26 to i64
store i64 %r29, i64* %r28
%r30 = lshr i1280 %r26, 64
%r32 = getelementptr i64, i64* %r2, i32 4
%r33 = trunc i1280 %r30 to i64
store i64 %r33, i64* %r32
%r34 = lshr i1280 %r30, 64
%r36 = getelementptr i64, i64* %r2, i32 5
%r37 = trunc i1280 %r34 to i64
store i64 %r37, i64* %r36
%r38 = lshr i1280 %r34, 64
%r40 = getelementptr i64, i64* %r2, i32 6
%r41 = trunc i1280 %r38 to i64
store i64 %r41, i64* %r40
%r42 = lshr i1280 %r38, 64
%r44 = getelementptr i64, i64* %r2, i32 7
%r45 = trunc i1280 %r42 to i64
store i64 %r45, i64* %r44
%r46 = lshr i1280 %r42, 64
%r48 = getelementptr i64, i64* %r2, i32 8
%r49 = trunc i1280 %r46 to i64
store i64 %r49, i64* %r48
%r50 = lshr i1280 %r46, 64
%r52 = getelementptr i64, i64* %r2, i32 9
%r53 = trunc i1280 %r50 to i64
store i64 %r53, i64* %r52
%r54 = lshr i1280 %r50, 64
%r56 = getelementptr i64, i64* %r2, i32 10
%r57 = trunc i1280 %r54 to i64
store i64 %r57, i64* %r56
%r58 = lshr i1280 %r54, 64
%r60 = getelementptr i64, i64* %r2, i32 11
%r61 = trunc i1280 %r58 to i64
store i64 %r61, i64* %r60
%r62 = lshr i1280 %r58, 64
%r64 = getelementptr i64, i64* %r2, i32 12
%r65 = trunc i1280 %r62 to i64
store i64 %r65, i64* %r64
%r66 = lshr i1280 %r62, 64
%r68 = getelementptr i64, i64* %r2, i32 13
%r69 = trunc i1280 %r66 to i64
store i64 %r69, i64* %r68
%r70 = lshr i1280 %r66, 64
%r72 = getelementptr i64, i64* %r2, i32 14
%r73 = trunc i1280 %r70 to i64
store i64 %r73, i64* %r72
%r74 = lshr i1280 %r70, 64
%r76 = getelementptr i64, i64* %r2, i32 15
%r77 = trunc i1280 %r74 to i64
store i64 %r77, i64* %r76
%r78 = lshr i1280 %r74, 64
%r80 = getelementptr i64, i64* %r2, i32 16
%r81 = trunc i1280 %r78 to i64
store i64 %r81, i64* %r80
%r82 = lshr i1280 %r78, 64
%r84 = getelementptr i64, i64* %r2, i32 17
%r85 = trunc i1280 %r82 to i64
store i64 %r85, i64* %r84
%r86 = lshr i1280 %r82, 64
%r88 = getelementptr i64, i64* %r2, i32 18
%r89 = trunc i1280 %r86 to i64
store i64 %r89, i64* %r88
%r90 = lshr i1280 %r86, 64
%r92 = getelementptr i64, i64* %r2, i32 19
%r93 = trunc i1280 %r90 to i64
store i64 %r93, i64* %r92
%r94 = lshr i1344 %r13, 1280
%r95 = trunc i1344 %r94 to i64
ret i64 %r95
}
define i64 @mclb_sub20(i64* noalias  %r2, i64* noalias  %r3, i64* noalias  %r4)
{
%r6 = bitcast i64* %r3 to i1280*
%r7 = load i1280, i1280* %r6
%r8 = zext i1280 %r7 to i1344
%r10 = bitcast i64* %r4 to i1280*
%r11 = load i1280, i1280* %r10
%r12 = zext i1280 %r11 to i1344
%r13 = sub i1344 %r8, %r12
%r14 = trunc i1344 %r13 to i1280
%r16 = getelementptr i64, i64* %r2, i32 0
%r17 = trunc i1280 %r14 to i64
store i64 %r17, i64* %r16
%r18 = lshr i1280 %r14, 64
%r20 = getelementptr i64, i64* %r2, i32 1
%r21 = trunc i1280 %r18 to i64
store i64 %r21, i64* %r20
%r22 = lshr i1280 %r18, 64
%r24 = getelementptr i64, i64* %r2, i32 2
%r25 = trunc i1280 %r22 to i64
store i64 %r25, i64* %r24
%r26 = lshr i1280 %r22, 64
%r28 = getelementptr i64, i64* %r2, i32 3
%r29 = trunc i1280 %r26 to i64
store i64 %r29, i64* %r28
%r30 = lshr i1280 %r26, 64
%r32 = getelementptr i64, i64* %r2, i32 4
%r33 = trunc i1280 %r30 to i64
store i64 %r33, i64* %r32
%r34 = lshr i1280 %r30, 64
%r36 = getelementptr i64, i64* %r2, i32 5
%r37 = trunc i1280 %r34 to i64
store i64 %r37, i64* %r36
%r38 = lshr i1280 %r34, 64
%r40 = getelementptr i64, i64* %r2, i32 6
%r41 = trunc i1280 %r38 to i64
store i64 %r41, i64* %r40
%r42 = lshr i1280 %r38, 64
%r44 = getelementptr i64, i64* %r2, i32 7
%r45 = trunc i1280 %r42 to i64
store i64 %r45, i64* %r44
%r46 = lshr i1280 %r42, 64
%r48 = getelementptr i64, i64* %r2, i32 8
%r49 = trunc i1280 %r46 to i64
store i64 %r49, i64* %r48
%r50 = lshr i1280 %r46, 64
%r52 = getelementptr i64, i64* %r2, i32 9
%r53 = trunc i1280 %r50 to i64
store i64 %r53, i64* %r52
%r54 = lshr i1280 %r50, 64
%r56 = getelementptr i64, i64* %r2, i32 10
%r57 = trunc i1280 %r54 to i64
store i64 %r57, i64* %r56
%r58 = lshr i1280 %r54, 64
%r60 = getelementptr i64, i64* %r2, i32 11
%r61 = trunc i1280 %r58 to i64
store i64 %r61, i64* %r60
%r62 = lshr i1280 %r58, 64
%r64 = getelementptr i64, i64* %r2, i32 12
%r65 = trunc i1280 %r62 to i64
store i64 %r65, i64* %r64
%r66 = lshr i1280 %r62, 64
%r68 = getelementptr i64, i64* %r2, i32 13
%r69 = trunc i1280 %r66 to i64
store i64 %r69, i64* %r68
%r70 = lshr i1280 %r66, 64
%r72 = getelementptr i64, i64* %r2, i32 14
%r73 = trunc i1280 %r70 to i64
store i64 %r73, i64* %r72
%r74 = lshr i1280 %r70, 64
%r76 = getelementptr i64, i64* %r2, i32 15
%r77 = trunc i1280 %r74 to i64
store i64 %r77, i64* %r76
%r78 = lshr i1280 %r74, 64
%r80 = getelementptr i64, i64* %r2, i32 16
%r81 = trunc i1280 %r78 to i64
store i64 %r81, i64* %r80
%r82 = lshr i1280 %r78, 64
%r84 = getelementptr i64, i64* %r2, i32 17
%r85 = trunc i1280 %r82 to i64
store i64 %r85, i64* %r84
%r86 = lshr i1280 %r82, 64
%r88 = getelementptr i64, i64* %r2, i32 18
%r89 = trunc i1280 %r86 to i64
store i64 %r89, i64* %r88
%r90 = lshr i1280 %r86, 64
%r92 = getelementptr i64, i64* %r2, i32 19
%r93 = trunc i1280 %r90 to i64
store i64 %r93, i64* %r92
%r94 = lshr i1344 %r13, 1280
%r95 = trunc i1344 %r94 to i64
%r97 = and i64 %r95, 1
ret i64 %r97
}
define void @mclb_addNF20(i64* noalias  %r1, i64* noalias  %r2, i64* noalias  %r3)
{
%r5 = bitcast i64* %r2 to i1280*
%r6 = load i1280, i1280* %r5
%r8 = bitcast i64* %r3 to i1280*
%r9 = load i1280, i1280* %r8
%r10 = add i1280 %r6, %r9
%r12 = getelementptr i64, i64* %r1, i32 0
%r13 = trunc i1280 %r10 to i64
store i64 %r13, i64* %r12
%r14 = lshr i1280 %r10, 64
%r16 = getelementptr i64, i64* %r1, i32 1
%r17 = trunc i1280 %r14 to i64
store i64 %r17, i64* %r16
%r18 = lshr i1280 %r14, 64
%r20 = getelementptr i64, i64* %r1, i32 2
%r21 = trunc i1280 %r18 to i64
store i64 %r21, i64* %r20
%r22 = lshr i1280 %r18, 64
%r24 = getelementptr i64, i64* %r1, i32 3
%r25 = trunc i1280 %r22 to i64
store i64 %r25, i64* %r24
%r26 = lshr i1280 %r22, 64
%r28 = getelementptr i64, i64* %r1, i32 4
%r29 = trunc i1280 %r26 to i64
store i64 %r29, i64* %r28
%r30 = lshr i1280 %r26, 64
%r32 = getelementptr i64, i64* %r1, i32 5
%r33 = trunc i1280 %r30 to i64
store i64 %r33, i64* %r32
%r34 = lshr i1280 %r30, 64
%r36 = getelementptr i64, i64* %r1, i32 6
%r37 = trunc i1280 %r34 to i64
store i64 %r37, i64* %r36
%r38 = lshr i1280 %r34, 64
%r40 = getelementptr i64, i64* %r1, i32 7
%r41 = trunc i1280 %r38 to i64
store i64 %r41, i64* %r40
%r42 = lshr i1280 %r38, 64
%r44 = getelementptr i64, i64* %r1, i32 8
%r45 = trunc i1280 %r42 to i64
store i64 %r45, i64* %r44
%r46 = lshr i1280 %r42, 64
%r48 = getelementptr i64, i64* %r1, i32 9
%r49 = trunc i1280 %r46 to i64
store i64 %r49, i64* %r48
%r50 = lshr i1280 %r46, 64
%r52 = getelementptr i64, i64* %r1, i32 10
%r53 = trunc i1280 %r50 to i64
store i64 %r53, i64* %r52
%r54 = lshr i1280 %r50, 64
%r56 = getelementptr i64, i64* %r1, i32 11
%r57 = trunc i1280 %r54 to i64
store i64 %r57, i64* %r56
%r58 = lshr i1280 %r54, 64
%r60 = getelementptr i64, i64* %r1, i32 12
%r61 = trunc i1280 %r58 to i64
store i64 %r61, i64* %r60
%r62 = lshr i1280 %r58, 64
%r64 = getelementptr i64, i64* %r1, i32 13
%r65 = trunc i1280 %r62 to i64
store i64 %r65, i64* %r64
%r66 = lshr i1280 %r62, 64
%r68 = getelementptr i64, i64* %r1, i32 14
%r69 = trunc i1280 %r66 to i64
store i64 %r69, i64* %r68
%r70 = lshr i1280 %r66, 64
%r72 = getelementptr i64, i64* %r1, i32 15
%r73 = trunc i1280 %r70 to i64
store i64 %r73, i64* %r72
%r74 = lshr i1280 %r70, 64
%r76 = getelementptr i64, i64* %r1, i32 16
%r77 = trunc i1280 %r74 to i64
store i64 %r77, i64* %r76
%r78 = lshr i1280 %r74, 64
%r80 = getelementptr i64, i64* %r1, i32 17
%r81 = trunc i1280 %r78 to i64
store i64 %r81, i64* %r80
%r82 = lshr i1280 %r78, 64
%r84 = getelementptr i64, i64* %r1, i32 18
%r85 = trunc i1280 %r82 to i64
store i64 %r85, i64* %r84
%r86 = lshr i1280 %r82, 64
%r88 = getelementptr i64, i64* %r1, i32 19
%r89 = trunc i1280 %r86 to i64
store i64 %r89, i64* %r88
ret void
}
define i64 @mclb_subNF20(i64* noalias  %r2, i64* noalias  %r3, i64* noalias  %r4)
{
%r6 = bitcast i64* %r3 to i1280*
%r7 = load i1280, i1280* %r6
%r9 = bitcast i64* %r4 to i1280*
%r10 = load i1280, i1280* %r9
%r11 = sub i1280 %r7, %r10
%r13 = getelementptr i64, i64* %r2, i32 0
%r14 = trunc i1280 %r11 to i64
store i64 %r14, i64* %r13
%r15 = lshr i1280 %r11, 64
%r17 = getelementptr i64, i64* %r2, i32 1
%r18 = trunc i1280 %r15 to i64
store i64 %r18, i64* %r17
%r19 = lshr i1280 %r15, 64
%r21 = getelementptr i64, i64* %r2, i32 2
%r22 = trunc i1280 %r19 to i64
store i64 %r22, i64* %r21
%r23 = lshr i1280 %r19, 64
%r25 = getelementptr i64, i64* %r2, i32 3
%r26 = trunc i1280 %r23 to i64
store i64 %r26, i64* %r25
%r27 = lshr i1280 %r23, 64
%r29 = getelementptr i64, i64* %r2, i32 4
%r30 = trunc i1280 %r27 to i64
store i64 %r30, i64* %r29
%r31 = lshr i1280 %r27, 64
%r33 = getelementptr i64, i64* %r2, i32 5
%r34 = trunc i1280 %r31 to i64
store i64 %r34, i64* %r33
%r35 = lshr i1280 %r31, 64
%r37 = getelementptr i64, i64* %r2, i32 6
%r38 = trunc i1280 %r35 to i64
store i64 %r38, i64* %r37
%r39 = lshr i1280 %r35, 64
%r41 = getelementptr i64, i64* %r2, i32 7
%r42 = trunc i1280 %r39 to i64
store i64 %r42, i64* %r41
%r43 = lshr i1280 %r39, 64
%r45 = getelementptr i64, i64* %r2, i32 8
%r46 = trunc i1280 %r43 to i64
store i64 %r46, i64* %r45
%r47 = lshr i1280 %r43, 64
%r49 = getelementptr i64, i64* %r2, i32 9
%r50 = trunc i1280 %r47 to i64
store i64 %r50, i64* %r49
%r51 = lshr i1280 %r47, 64
%r53 = getelementptr i64, i64* %r2, i32 10
%r54 = trunc i1280 %r51 to i64
store i64 %r54, i64* %r53
%r55 = lshr i1280 %r51, 64
%r57 = getelementptr i64, i64* %r2, i32 11
%r58 = trunc i1280 %r55 to i64
store i64 %r58, i64* %r57
%r59 = lshr i1280 %r55, 64
%r61 = getelementptr i64, i64* %r2, i32 12
%r62 = trunc i1280 %r59 to i64
store i64 %r62, i64* %r61
%r63 = lshr i1280 %r59, 64
%r65 = getelementptr i64, i64* %r2, i32 13
%r66 = trunc i1280 %r63 to i64
store i64 %r66, i64* %r65
%r67 = lshr i1280 %r63, 64
%r69 = getelementptr i64, i64* %r2, i32 14
%r70 = trunc i1280 %r67 to i64
store i64 %r70, i64* %r69
%r71 = lshr i1280 %r67, 64
%r73 = getelementptr i64, i64* %r2, i32 15
%r74 = trunc i1280 %r71 to i64
store i64 %r74, i64* %r73
%r75 = lshr i1280 %r71, 64
%r77 = getelementptr i64, i64* %r2, i32 16
%r78 = trunc i1280 %r75 to i64
store i64 %r78, i64* %r77
%r79 = lshr i1280 %r75, 64
%r81 = getelementptr i64, i64* %r2, i32 17
%r82 = trunc i1280 %r79 to i64
store i64 %r82, i64* %r81
%r83 = lshr i1280 %r79, 64
%r85 = getelementptr i64, i64* %r2, i32 18
%r86 = trunc i1280 %r83 to i64
store i64 %r86, i64* %r85
%r87 = lshr i1280 %r83, 64
%r89 = getelementptr i64, i64* %r2, i32 19
%r90 = trunc i1280 %r87 to i64
store i64 %r90, i64* %r89
%r91 = lshr i1280 %r11, 1279
%r92 = trunc i1280 %r91 to i64
%r94 = and i64 %r92, 1
ret i64 %r94
}
define i64 @mclb_add21(i64* noalias  %r2, i64* noalias  %r3, i64* noalias  %r4)
{
%r6 = bitcast i64* %r3 to i1344*
%r7 = load i1344, i1344* %r6
%r8 = zext i1344 %r7 to i1408
%r10 = bitcast i64* %r4 to i1344*
%r11 = load i1344, i1344* %r10
%r12 = zext i1344 %r11 to i1408
%r13 = add i1408 %r8, %r12
%r14 = trunc i1408 %r13 to i1344
%r16 = getelementptr i64, i64* %r2, i32 0
%r17 = trunc i1344 %r14 to i64
store i64 %r17, i64* %r16
%r18 = lshr i1344 %r14, 64
%r20 = getelementptr i64, i64* %r2, i32 1
%r21 = trunc i1344 %r18 to i64
store i64 %r21, i64* %r20
%r22 = lshr i1344 %r18, 64
%r24 = getelementptr i64, i64* %r2, i32 2
%r25 = trunc i1344 %r22 to i64
store i64 %r25, i64* %r24
%r26 = lshr i1344 %r22, 64
%r28 = getelementptr i64, i64* %r2, i32 3
%r29 = trunc i1344 %r26 to i64
store i64 %r29, i64* %r28
%r30 = lshr i1344 %r26, 64
%r32 = getelementptr i64, i64* %r2, i32 4
%r33 = trunc i1344 %r30 to i64
store i64 %r33, i64* %r32
%r34 = lshr i1344 %r30, 64
%r36 = getelementptr i64, i64* %r2, i32 5
%r37 = trunc i1344 %r34 to i64
store i64 %r37, i64* %r36
%r38 = lshr i1344 %r34, 64
%r40 = getelementptr i64, i64* %r2, i32 6
%r41 = trunc i1344 %r38 to i64
store i64 %r41, i64* %r40
%r42 = lshr i1344 %r38, 64
%r44 = getelementptr i64, i64* %r2, i32 7
%r45 = trunc i1344 %r42 to i64
store i64 %r45, i64* %r44
%r46 = lshr i1344 %r42, 64
%r48 = getelementptr i64, i64* %r2, i32 8
%r49 = trunc i1344 %r46 to i64
store i64 %r49, i64* %r48
%r50 = lshr i1344 %r46, 64
%r52 = getelementptr i64, i64* %r2, i32 9
%r53 = trunc i1344 %r50 to i64
store i64 %r53, i64* %r52
%r54 = lshr i1344 %r50, 64
%r56 = getelementptr i64, i64* %r2, i32 10
%r57 = trunc i1344 %r54 to i64
store i64 %r57, i64* %r56
%r58 = lshr i1344 %r54, 64
%r60 = getelementptr i64, i64* %r2, i32 11
%r61 = trunc i1344 %r58 to i64
store i64 %r61, i64* %r60
%r62 = lshr i1344 %r58, 64
%r64 = getelementptr i64, i64* %r2, i32 12
%r65 = trunc i1344 %r62 to i64
store i64 %r65, i64* %r64
%r66 = lshr i1344 %r62, 64
%r68 = getelementptr i64, i64* %r2, i32 13
%r69 = trunc i1344 %r66 to i64
store i64 %r69, i64* %r68
%r70 = lshr i1344 %r66, 64
%r72 = getelementptr i64, i64* %r2, i32 14
%r73 = trunc i1344 %r70 to i64
store i64 %r73, i64* %r72
%r74 = lshr i1344 %r70, 64
%r76 = getelementptr i64, i64* %r2, i32 15
%r77 = trunc i1344 %r74 to i64
store i64 %r77, i64* %r76
%r78 = lshr i1344 %r74, 64
%r80 = getelementptr i64, i64* %r2, i32 16
%r81 = trunc i1344 %r78 to i64
store i64 %r81, i64* %r80
%r82 = lshr i1344 %r78, 64
%r84 = getelementptr i64, i64* %r2, i32 17
%r85 = trunc i1344 %r82 to i64
store i64 %r85, i64* %r84
%r86 = lshr i1344 %r82, 64
%r88 = getelementptr i64, i64* %r2, i32 18
%r89 = trunc i1344 %r86 to i64
store i64 %r89, i64* %r88
%r90 = lshr i1344 %r86, 64
%r92 = getelementptr i64, i64* %r2, i32 19
%r93 = trunc i1344 %r90 to i64
store i64 %r93, i64* %r92
%r94 = lshr i1344 %r90, 64
%r96 = getelementptr i64, i64* %r2, i32 20
%r97 = trunc i1344 %r94 to i64
store i64 %r97, i64* %r96
%r98 = lshr i1408 %r13, 1344
%r99 = trunc i1408 %r98 to i64
ret i64 %r99
}
define i64 @mclb_sub21(i64* noalias  %r2, i64* noalias  %r3, i64* noalias  %r4)
{
%r6 = bitcast i64* %r3 to i1344*
%r7 = load i1344, i1344* %r6
%r8 = zext i1344 %r7 to i1408
%r10 = bitcast i64* %r4 to i1344*
%r11 = load i1344, i1344* %r10
%r12 = zext i1344 %r11 to i1408
%r13 = sub i1408 %r8, %r12
%r14 = trunc i1408 %r13 to i1344
%r16 = getelementptr i64, i64* %r2, i32 0
%r17 = trunc i1344 %r14 to i64
store i64 %r17, i64* %r16
%r18 = lshr i1344 %r14, 64
%r20 = getelementptr i64, i64* %r2, i32 1
%r21 = trunc i1344 %r18 to i64
store i64 %r21, i64* %r20
%r22 = lshr i1344 %r18, 64
%r24 = getelementptr i64, i64* %r2, i32 2
%r25 = trunc i1344 %r22 to i64
store i64 %r25, i64* %r24
%r26 = lshr i1344 %r22, 64
%r28 = getelementptr i64, i64* %r2, i32 3
%r29 = trunc i1344 %r26 to i64
store i64 %r29, i64* %r28
%r30 = lshr i1344 %r26, 64
%r32 = getelementptr i64, i64* %r2, i32 4
%r33 = trunc i1344 %r30 to i64
store i64 %r33, i64* %r32
%r34 = lshr i1344 %r30, 64
%r36 = getelementptr i64, i64* %r2, i32 5
%r37 = trunc i1344 %r34 to i64
store i64 %r37, i64* %r36
%r38 = lshr i1344 %r34, 64
%r40 = getelementptr i64, i64* %r2, i32 6
%r41 = trunc i1344 %r38 to i64
store i64 %r41, i64* %r40
%r42 = lshr i1344 %r38, 64
%r44 = getelementptr i64, i64* %r2, i32 7
%r45 = trunc i1344 %r42 to i64
store i64 %r45, i64* %r44
%r46 = lshr i1344 %r42, 64
%r48 = getelementptr i64, i64* %r2, i32 8
%r49 = trunc i1344 %r46 to i64
store i64 %r49, i64* %r48
%r50 = lshr i1344 %r46, 64
%r52 = getelementptr i64, i64* %r2, i32 9
%r53 = trunc i1344 %r50 to i64
store i64 %r53, i64* %r52
%r54 = lshr i1344 %r50, 64
%r56 = getelementptr i64, i64* %r2, i32 10
%r57 = trunc i1344 %r54 to i64
store i64 %r57, i64* %r56
%r58 = lshr i1344 %r54, 64
%r60 = getelementptr i64, i64* %r2, i32 11
%r61 = trunc i1344 %r58 to i64
store i64 %r61, i64* %r60
%r62 = lshr i1344 %r58, 64
%r64 = getelementptr i64, i64* %r2, i32 12
%r65 = trunc i1344 %r62 to i64
store i64 %r65, i64* %r64
%r66 = lshr i1344 %r62, 64
%r68 = getelementptr i64, i64* %r2, i32 13
%r69 = trunc i1344 %r66 to i64
store i64 %r69, i64* %r68
%r70 = lshr i1344 %r66, 64
%r72 = getelementptr i64, i64* %r2, i32 14
%r73 = trunc i1344 %r70 to i64
store i64 %r73, i64* %r72
%r74 = lshr i1344 %r70, 64
%r76 = getelementptr i64, i64* %r2, i32 15
%r77 = trunc i1344 %r74 to i64
store i64 %r77, i64* %r76
%r78 = lshr i1344 %r74, 64
%r80 = getelementptr i64, i64* %r2, i32 16
%r81 = trunc i1344 %r78 to i64
store i64 %r81, i64* %r80
%r82 = lshr i1344 %r78, 64
%r84 = getelementptr i64, i64* %r2, i32 17
%r85 = trunc i1344 %r82 to i64
store i64 %r85, i64* %r84
%r86 = lshr i1344 %r82, 64
%r88 = getelementptr i64, i64* %r2, i32 18
%r89 = trunc i1344 %r86 to i64
store i64 %r89, i64* %r88
%r90 = lshr i1344 %r86, 64
%r92 = getelementptr i64, i64* %r2, i32 19
%r93 = trunc i1344 %r90 to i64
store i64 %r93, i64* %r92
%r94 = lshr i1344 %r90, 64
%r96 = getelementptr i64, i64* %r2, i32 20
%r97 = trunc i1344 %r94 to i64
store i64 %r97, i64* %r96
%r98 = lshr i1408 %r13, 1344
%r99 = trunc i1408 %r98 to i64
%r101 = and i64 %r99, 1
ret i64 %r101
}
define void @mclb_addNF21(i64* noalias  %r1, i64* noalias  %r2, i64* noalias  %r3)
{
%r5 = bitcast i64* %r2 to i1344*
%r6 = load i1344, i1344* %r5
%r8 = bitcast i64* %r3 to i1344*
%r9 = load i1344, i1344* %r8
%r10 = add i1344 %r6, %r9
%r12 = getelementptr i64, i64* %r1, i32 0
%r13 = trunc i1344 %r10 to i64
store i64 %r13, i64* %r12
%r14 = lshr i1344 %r10, 64
%r16 = getelementptr i64, i64* %r1, i32 1
%r17 = trunc i1344 %r14 to i64
store i64 %r17, i64* %r16
%r18 = lshr i1344 %r14, 64
%r20 = getelementptr i64, i64* %r1, i32 2
%r21 = trunc i1344 %r18 to i64
store i64 %r21, i64* %r20
%r22 = lshr i1344 %r18, 64
%r24 = getelementptr i64, i64* %r1, i32 3
%r25 = trunc i1344 %r22 to i64
store i64 %r25, i64* %r24
%r26 = lshr i1344 %r22, 64
%r28 = getelementptr i64, i64* %r1, i32 4
%r29 = trunc i1344 %r26 to i64
store i64 %r29, i64* %r28
%r30 = lshr i1344 %r26, 64
%r32 = getelementptr i64, i64* %r1, i32 5
%r33 = trunc i1344 %r30 to i64
store i64 %r33, i64* %r32
%r34 = lshr i1344 %r30, 64
%r36 = getelementptr i64, i64* %r1, i32 6
%r37 = trunc i1344 %r34 to i64
store i64 %r37, i64* %r36
%r38 = lshr i1344 %r34, 64
%r40 = getelementptr i64, i64* %r1, i32 7
%r41 = trunc i1344 %r38 to i64
store i64 %r41, i64* %r40
%r42 = lshr i1344 %r38, 64
%r44 = getelementptr i64, i64* %r1, i32 8
%r45 = trunc i1344 %r42 to i64
store i64 %r45, i64* %r44
%r46 = lshr i1344 %r42, 64
%r48 = getelementptr i64, i64* %r1, i32 9
%r49 = trunc i1344 %r46 to i64
store i64 %r49, i64* %r48
%r50 = lshr i1344 %r46, 64
%r52 = getelementptr i64, i64* %r1, i32 10
%r53 = trunc i1344 %r50 to i64
store i64 %r53, i64* %r52
%r54 = lshr i1344 %r50, 64
%r56 = getelementptr i64, i64* %r1, i32 11
%r57 = trunc i1344 %r54 to i64
store i64 %r57, i64* %r56
%r58 = lshr i1344 %r54, 64
%r60 = getelementptr i64, i64* %r1, i32 12
%r61 = trunc i1344 %r58 to i64
store i64 %r61, i64* %r60
%r62 = lshr i1344 %r58, 64
%r64 = getelementptr i64, i64* %r1, i32 13
%r65 = trunc i1344 %r62 to i64
store i64 %r65, i64* %r64
%r66 = lshr i1344 %r62, 64
%r68 = getelementptr i64, i64* %r1, i32 14
%r69 = trunc i1344 %r66 to i64
store i64 %r69, i64* %r68
%r70 = lshr i1344 %r66, 64
%r72 = getelementptr i64, i64* %r1, i32 15
%r73 = trunc i1344 %r70 to i64
store i64 %r73, i64* %r72
%r74 = lshr i1344 %r70, 64
%r76 = getelementptr i64, i64* %r1, i32 16
%r77 = trunc i1344 %r74 to i64
store i64 %r77, i64* %r76
%r78 = lshr i1344 %r74, 64
%r80 = getelementptr i64, i64* %r1, i32 17
%r81 = trunc i1344 %r78 to i64
store i64 %r81, i64* %r80
%r82 = lshr i1344 %r78, 64
%r84 = getelementptr i64, i64* %r1, i32 18
%r85 = trunc i1344 %r82 to i64
store i64 %r85, i64* %r84
%r86 = lshr i1344 %r82, 64
%r88 = getelementptr i64, i64* %r1, i32 19
%r89 = trunc i1344 %r86 to i64
store i64 %r89, i64* %r88
%r90 = lshr i1344 %r86, 64
%r92 = getelementptr i64, i64* %r1, i32 20
%r93 = trunc i1344 %r90 to i64
store i64 %r93, i64* %r92
ret void
}
define i64 @mclb_subNF21(i64* noalias  %r2, i64* noalias  %r3, i64* noalias  %r4)
{
%r6 = bitcast i64* %r3 to i1344*
%r7 = load i1344, i1344* %r6
%r9 = bitcast i64* %r4 to i1344*
%r10 = load i1344, i1344* %r9
%r11 = sub i1344 %r7, %r10
%r13 = getelementptr i64, i64* %r2, i32 0
%r14 = trunc i1344 %r11 to i64
store i64 %r14, i64* %r13
%r15 = lshr i1344 %r11, 64
%r17 = getelementptr i64, i64* %r2, i32 1
%r18 = trunc i1344 %r15 to i64
store i64 %r18, i64* %r17
%r19 = lshr i1344 %r15, 64
%r21 = getelementptr i64, i64* %r2, i32 2
%r22 = trunc i1344 %r19 to i64
store i64 %r22, i64* %r21
%r23 = lshr i1344 %r19, 64
%r25 = getelementptr i64, i64* %r2, i32 3
%r26 = trunc i1344 %r23 to i64
store i64 %r26, i64* %r25
%r27 = lshr i1344 %r23, 64
%r29 = getelementptr i64, i64* %r2, i32 4
%r30 = trunc i1344 %r27 to i64
store i64 %r30, i64* %r29
%r31 = lshr i1344 %r27, 64
%r33 = getelementptr i64, i64* %r2, i32 5
%r34 = trunc i1344 %r31 to i64
store i64 %r34, i64* %r33
%r35 = lshr i1344 %r31, 64
%r37 = getelementptr i64, i64* %r2, i32 6
%r38 = trunc i1344 %r35 to i64
store i64 %r38, i64* %r37
%r39 = lshr i1344 %r35, 64
%r41 = getelementptr i64, i64* %r2, i32 7
%r42 = trunc i1344 %r39 to i64
store i64 %r42, i64* %r41
%r43 = lshr i1344 %r39, 64
%r45 = getelementptr i64, i64* %r2, i32 8
%r46 = trunc i1344 %r43 to i64
store i64 %r46, i64* %r45
%r47 = lshr i1344 %r43, 64
%r49 = getelementptr i64, i64* %r2, i32 9
%r50 = trunc i1344 %r47 to i64
store i64 %r50, i64* %r49
%r51 = lshr i1344 %r47, 64
%r53 = getelementptr i64, i64* %r2, i32 10
%r54 = trunc i1344 %r51 to i64
store i64 %r54, i64* %r53
%r55 = lshr i1344 %r51, 64
%r57 = getelementptr i64, i64* %r2, i32 11
%r58 = trunc i1344 %r55 to i64
store i64 %r58, i64* %r57
%r59 = lshr i1344 %r55, 64
%r61 = getelementptr i64, i64* %r2, i32 12
%r62 = trunc i1344 %r59 to i64
store i64 %r62, i64* %r61
%r63 = lshr i1344 %r59, 64
%r65 = getelementptr i64, i64* %r2, i32 13
%r66 = trunc i1344 %r63 to i64
store i64 %r66, i64* %r65
%r67 = lshr i1344 %r63, 64
%r69 = getelementptr i64, i64* %r2, i32 14
%r70 = trunc i1344 %r67 to i64
store i64 %r70, i64* %r69
%r71 = lshr i1344 %r67, 64
%r73 = getelementptr i64, i64* %r2, i32 15
%r74 = trunc i1344 %r71 to i64
store i64 %r74, i64* %r73
%r75 = lshr i1344 %r71, 64
%r77 = getelementptr i64, i64* %r2, i32 16
%r78 = trunc i1344 %r75 to i64
store i64 %r78, i64* %r77
%r79 = lshr i1344 %r75, 64
%r81 = getelementptr i64, i64* %r2, i32 17
%r82 = trunc i1344 %r79 to i64
store i64 %r82, i64* %r81
%r83 = lshr i1344 %r79, 64
%r85 = getelementptr i64, i64* %r2, i32 18
%r86 = trunc i1344 %r83 to i64
store i64 %r86, i64* %r85
%r87 = lshr i1344 %r83, 64
%r89 = getelementptr i64, i64* %r2, i32 19
%r90 = trunc i1344 %r87 to i64
store i64 %r90, i64* %r89
%r91 = lshr i1344 %r87, 64
%r93 = getelementptr i64, i64* %r2, i32 20
%r94 = trunc i1344 %r91 to i64
store i64 %r94, i64* %r93
%r95 = lshr i1344 %r11, 1343
%r96 = trunc i1344 %r95 to i64
%r98 = and i64 %r96, 1
ret i64 %r98
}
define i64 @mclb_add22(i64* noalias  %r2, i64* noalias  %r3, i64* noalias  %r4)
{
%r6 = bitcast i64* %r3 to i1408*
%r7 = load i1408, i1408* %r6
%r8 = zext i1408 %r7 to i1472
%r10 = bitcast i64* %r4 to i1408*
%r11 = load i1408, i1408* %r10
%r12 = zext i1408 %r11 to i1472
%r13 = add i1472 %r8, %r12
%r14 = trunc i1472 %r13 to i1408
%r16 = getelementptr i64, i64* %r2, i32 0
%r17 = trunc i1408 %r14 to i64
store i64 %r17, i64* %r16
%r18 = lshr i1408 %r14, 64
%r20 = getelementptr i64, i64* %r2, i32 1
%r21 = trunc i1408 %r18 to i64
store i64 %r21, i64* %r20
%r22 = lshr i1408 %r18, 64
%r24 = getelementptr i64, i64* %r2, i32 2
%r25 = trunc i1408 %r22 to i64
store i64 %r25, i64* %r24
%r26 = lshr i1408 %r22, 64
%r28 = getelementptr i64, i64* %r2, i32 3
%r29 = trunc i1408 %r26 to i64
store i64 %r29, i64* %r28
%r30 = lshr i1408 %r26, 64
%r32 = getelementptr i64, i64* %r2, i32 4
%r33 = trunc i1408 %r30 to i64
store i64 %r33, i64* %r32
%r34 = lshr i1408 %r30, 64
%r36 = getelementptr i64, i64* %r2, i32 5
%r37 = trunc i1408 %r34 to i64
store i64 %r37, i64* %r36
%r38 = lshr i1408 %r34, 64
%r40 = getelementptr i64, i64* %r2, i32 6
%r41 = trunc i1408 %r38 to i64
store i64 %r41, i64* %r40
%r42 = lshr i1408 %r38, 64
%r44 = getelementptr i64, i64* %r2, i32 7
%r45 = trunc i1408 %r42 to i64
store i64 %r45, i64* %r44
%r46 = lshr i1408 %r42, 64
%r48 = getelementptr i64, i64* %r2, i32 8
%r49 = trunc i1408 %r46 to i64
store i64 %r49, i64* %r48
%r50 = lshr i1408 %r46, 64
%r52 = getelementptr i64, i64* %r2, i32 9
%r53 = trunc i1408 %r50 to i64
store i64 %r53, i64* %r52
%r54 = lshr i1408 %r50, 64
%r56 = getelementptr i64, i64* %r2, i32 10
%r57 = trunc i1408 %r54 to i64
store i64 %r57, i64* %r56
%r58 = lshr i1408 %r54, 64
%r60 = getelementptr i64, i64* %r2, i32 11
%r61 = trunc i1408 %r58 to i64
store i64 %r61, i64* %r60
%r62 = lshr i1408 %r58, 64
%r64 = getelementptr i64, i64* %r2, i32 12
%r65 = trunc i1408 %r62 to i64
store i64 %r65, i64* %r64
%r66 = lshr i1408 %r62, 64
%r68 = getelementptr i64, i64* %r2, i32 13
%r69 = trunc i1408 %r66 to i64
store i64 %r69, i64* %r68
%r70 = lshr i1408 %r66, 64
%r72 = getelementptr i64, i64* %r2, i32 14
%r73 = trunc i1408 %r70 to i64
store i64 %r73, i64* %r72
%r74 = lshr i1408 %r70, 64
%r76 = getelementptr i64, i64* %r2, i32 15
%r77 = trunc i1408 %r74 to i64
store i64 %r77, i64* %r76
%r78 = lshr i1408 %r74, 64
%r80 = getelementptr i64, i64* %r2, i32 16
%r81 = trunc i1408 %r78 to i64
store i64 %r81, i64* %r80
%r82 = lshr i1408 %r78, 64
%r84 = getelementptr i64, i64* %r2, i32 17
%r85 = trunc i1408 %r82 to i64
store i64 %r85, i64* %r84
%r86 = lshr i1408 %r82, 64
%r88 = getelementptr i64, i64* %r2, i32 18
%r89 = trunc i1408 %r86 to i64
store i64 %r89, i64* %r88
%r90 = lshr i1408 %r86, 64
%r92 = getelementptr i64, i64* %r2, i32 19
%r93 = trunc i1408 %r90 to i64
store i64 %r93, i64* %r92
%r94 = lshr i1408 %r90, 64
%r96 = getelementptr i64, i64* %r2, i32 20
%r97 = trunc i1408 %r94 to i64
store i64 %r97, i64* %r96
%r98 = lshr i1408 %r94, 64
%r100 = getelementptr i64, i64* %r2, i32 21
%r101 = trunc i1408 %r98 to i64
store i64 %r101, i64* %r100
%r102 = lshr i1472 %r13, 1408
%r103 = trunc i1472 %r102 to i64
ret i64 %r103
}
define i64 @mclb_sub22(i64* noalias  %r2, i64* noalias  %r3, i64* noalias  %r4)
{
%r6 = bitcast i64* %r3 to i1408*
%r7 = load i1408, i1408* %r6
%r8 = zext i1408 %r7 to i1472
%r10 = bitcast i64* %r4 to i1408*
%r11 = load i1408, i1408* %r10
%r12 = zext i1408 %r11 to i1472
%r13 = sub i1472 %r8, %r12
%r14 = trunc i1472 %r13 to i1408
%r16 = getelementptr i64, i64* %r2, i32 0
%r17 = trunc i1408 %r14 to i64
store i64 %r17, i64* %r16
%r18 = lshr i1408 %r14, 64
%r20 = getelementptr i64, i64* %r2, i32 1
%r21 = trunc i1408 %r18 to i64
store i64 %r21, i64* %r20
%r22 = lshr i1408 %r18, 64
%r24 = getelementptr i64, i64* %r2, i32 2
%r25 = trunc i1408 %r22 to i64
store i64 %r25, i64* %r24
%r26 = lshr i1408 %r22, 64
%r28 = getelementptr i64, i64* %r2, i32 3
%r29 = trunc i1408 %r26 to i64
store i64 %r29, i64* %r28
%r30 = lshr i1408 %r26, 64
%r32 = getelementptr i64, i64* %r2, i32 4
%r33 = trunc i1408 %r30 to i64
store i64 %r33, i64* %r32
%r34 = lshr i1408 %r30, 64
%r36 = getelementptr i64, i64* %r2, i32 5
%r37 = trunc i1408 %r34 to i64
store i64 %r37, i64* %r36
%r38 = lshr i1408 %r34, 64
%r40 = getelementptr i64, i64* %r2, i32 6
%r41 = trunc i1408 %r38 to i64
store i64 %r41, i64* %r40
%r42 = lshr i1408 %r38, 64
%r44 = getelementptr i64, i64* %r2, i32 7
%r45 = trunc i1408 %r42 to i64
store i64 %r45, i64* %r44
%r46 = lshr i1408 %r42, 64
%r48 = getelementptr i64, i64* %r2, i32 8
%r49 = trunc i1408 %r46 to i64
store i64 %r49, i64* %r48
%r50 = lshr i1408 %r46, 64
%r52 = getelementptr i64, i64* %r2, i32 9
%r53 = trunc i1408 %r50 to i64
store i64 %r53, i64* %r52
%r54 = lshr i1408 %r50, 64
%r56 = getelementptr i64, i64* %r2, i32 10
%r57 = trunc i1408 %r54 to i64
store i64 %r57, i64* %r56
%r58 = lshr i1408 %r54, 64
%r60 = getelementptr i64, i64* %r2, i32 11
%r61 = trunc i1408 %r58 to i64
store i64 %r61, i64* %r60
%r62 = lshr i1408 %r58, 64
%r64 = getelementptr i64, i64* %r2, i32 12
%r65 = trunc i1408 %r62 to i64
store i64 %r65, i64* %r64
%r66 = lshr i1408 %r62, 64
%r68 = getelementptr i64, i64* %r2, i32 13
%r69 = trunc i1408 %r66 to i64
store i64 %r69, i64* %r68
%r70 = lshr i1408 %r66, 64
%r72 = getelementptr i64, i64* %r2, i32 14
%r73 = trunc i1408 %r70 to i64
store i64 %r73, i64* %r72
%r74 = lshr i1408 %r70, 64
%r76 = getelementptr i64, i64* %r2, i32 15
%r77 = trunc i1408 %r74 to i64
store i64 %r77, i64* %r76
%r78 = lshr i1408 %r74, 64
%r80 = getelementptr i64, i64* %r2, i32 16
%r81 = trunc i1408 %r78 to i64
store i64 %r81, i64* %r80
%r82 = lshr i1408 %r78, 64
%r84 = getelementptr i64, i64* %r2, i32 17
%r85 = trunc i1408 %r82 to i64
store i64 %r85, i64* %r84
%r86 = lshr i1408 %r82, 64
%r88 = getelementptr i64, i64* %r2, i32 18
%r89 = trunc i1408 %r86 to i64
store i64 %r89, i64* %r88
%r90 = lshr i1408 %r86, 64
%r92 = getelementptr i64, i64* %r2, i32 19
%r93 = trunc i1408 %r90 to i64
store i64 %r93, i64* %r92
%r94 = lshr i1408 %r90, 64
%r96 = getelementptr i64, i64* %r2, i32 20
%r97 = trunc i1408 %r94 to i64
store i64 %r97, i64* %r96
%r98 = lshr i1408 %r94, 64
%r100 = getelementptr i64, i64* %r2, i32 21
%r101 = trunc i1408 %r98 to i64
store i64 %r101, i64* %r100
%r102 = lshr i1472 %r13, 1408
%r103 = trunc i1472 %r102 to i64
%r105 = and i64 %r103, 1
ret i64 %r105
}
define void @mclb_addNF22(i64* noalias  %r1, i64* noalias  %r2, i64* noalias  %r3)
{
%r5 = bitcast i64* %r2 to i1408*
%r6 = load i1408, i1408* %r5
%r8 = bitcast i64* %r3 to i1408*
%r9 = load i1408, i1408* %r8
%r10 = add i1408 %r6, %r9
%r12 = getelementptr i64, i64* %r1, i32 0
%r13 = trunc i1408 %r10 to i64
store i64 %r13, i64* %r12
%r14 = lshr i1408 %r10, 64
%r16 = getelementptr i64, i64* %r1, i32 1
%r17 = trunc i1408 %r14 to i64
store i64 %r17, i64* %r16
%r18 = lshr i1408 %r14, 64
%r20 = getelementptr i64, i64* %r1, i32 2
%r21 = trunc i1408 %r18 to i64
store i64 %r21, i64* %r20
%r22 = lshr i1408 %r18, 64
%r24 = getelementptr i64, i64* %r1, i32 3
%r25 = trunc i1408 %r22 to i64
store i64 %r25, i64* %r24
%r26 = lshr i1408 %r22, 64
%r28 = getelementptr i64, i64* %r1, i32 4
%r29 = trunc i1408 %r26 to i64
store i64 %r29, i64* %r28
%r30 = lshr i1408 %r26, 64
%r32 = getelementptr i64, i64* %r1, i32 5
%r33 = trunc i1408 %r30 to i64
store i64 %r33, i64* %r32
%r34 = lshr i1408 %r30, 64
%r36 = getelementptr i64, i64* %r1, i32 6
%r37 = trunc i1408 %r34 to i64
store i64 %r37, i64* %r36
%r38 = lshr i1408 %r34, 64
%r40 = getelementptr i64, i64* %r1, i32 7
%r41 = trunc i1408 %r38 to i64
store i64 %r41, i64* %r40
%r42 = lshr i1408 %r38, 64
%r44 = getelementptr i64, i64* %r1, i32 8
%r45 = trunc i1408 %r42 to i64
store i64 %r45, i64* %r44
%r46 = lshr i1408 %r42, 64
%r48 = getelementptr i64, i64* %r1, i32 9
%r49 = trunc i1408 %r46 to i64
store i64 %r49, i64* %r48
%r50 = lshr i1408 %r46, 64
%r52 = getelementptr i64, i64* %r1, i32 10
%r53 = trunc i1408 %r50 to i64
store i64 %r53, i64* %r52
%r54 = lshr i1408 %r50, 64
%r56 = getelementptr i64, i64* %r1, i32 11
%r57 = trunc i1408 %r54 to i64
store i64 %r57, i64* %r56
%r58 = lshr i1408 %r54, 64
%r60 = getelementptr i64, i64* %r1, i32 12
%r61 = trunc i1408 %r58 to i64
store i64 %r61, i64* %r60
%r62 = lshr i1408 %r58, 64
%r64 = getelementptr i64, i64* %r1, i32 13
%r65 = trunc i1408 %r62 to i64
store i64 %r65, i64* %r64
%r66 = lshr i1408 %r62, 64
%r68 = getelementptr i64, i64* %r1, i32 14
%r69 = trunc i1408 %r66 to i64
store i64 %r69, i64* %r68
%r70 = lshr i1408 %r66, 64
%r72 = getelementptr i64, i64* %r1, i32 15
%r73 = trunc i1408 %r70 to i64
store i64 %r73, i64* %r72
%r74 = lshr i1408 %r70, 64
%r76 = getelementptr i64, i64* %r1, i32 16
%r77 = trunc i1408 %r74 to i64
store i64 %r77, i64* %r76
%r78 = lshr i1408 %r74, 64
%r80 = getelementptr i64, i64* %r1, i32 17
%r81 = trunc i1408 %r78 to i64
store i64 %r81, i64* %r80
%r82 = lshr i1408 %r78, 64
%r84 = getelementptr i64, i64* %r1, i32 18
%r85 = trunc i1408 %r82 to i64
store i64 %r85, i64* %r84
%r86 = lshr i1408 %r82, 64
%r88 = getelementptr i64, i64* %r1, i32 19
%r89 = trunc i1408 %r86 to i64
store i64 %r89, i64* %r88
%r90 = lshr i1408 %r86, 64
%r92 = getelementptr i64, i64* %r1, i32 20
%r93 = trunc i1408 %r90 to i64
store i64 %r93, i64* %r92
%r94 = lshr i1408 %r90, 64
%r96 = getelementptr i64, i64* %r1, i32 21
%r97 = trunc i1408 %r94 to i64
store i64 %r97, i64* %r96
ret void
}
define i64 @mclb_subNF22(i64* noalias  %r2, i64* noalias  %r3, i64* noalias  %r4)
{
%r6 = bitcast i64* %r3 to i1408*
%r7 = load i1408, i1408* %r6
%r9 = bitcast i64* %r4 to i1408*
%r10 = load i1408, i1408* %r9
%r11 = sub i1408 %r7, %r10
%r13 = getelementptr i64, i64* %r2, i32 0
%r14 = trunc i1408 %r11 to i64
store i64 %r14, i64* %r13
%r15 = lshr i1408 %r11, 64
%r17 = getelementptr i64, i64* %r2, i32 1
%r18 = trunc i1408 %r15 to i64
store i64 %r18, i64* %r17
%r19 = lshr i1408 %r15, 64
%r21 = getelementptr i64, i64* %r2, i32 2
%r22 = trunc i1408 %r19 to i64
store i64 %r22, i64* %r21
%r23 = lshr i1408 %r19, 64
%r25 = getelementptr i64, i64* %r2, i32 3
%r26 = trunc i1408 %r23 to i64
store i64 %r26, i64* %r25
%r27 = lshr i1408 %r23, 64
%r29 = getelementptr i64, i64* %r2, i32 4
%r30 = trunc i1408 %r27 to i64
store i64 %r30, i64* %r29
%r31 = lshr i1408 %r27, 64
%r33 = getelementptr i64, i64* %r2, i32 5
%r34 = trunc i1408 %r31 to i64
store i64 %r34, i64* %r33
%r35 = lshr i1408 %r31, 64
%r37 = getelementptr i64, i64* %r2, i32 6
%r38 = trunc i1408 %r35 to i64
store i64 %r38, i64* %r37
%r39 = lshr i1408 %r35, 64
%r41 = getelementptr i64, i64* %r2, i32 7
%r42 = trunc i1408 %r39 to i64
store i64 %r42, i64* %r41
%r43 = lshr i1408 %r39, 64
%r45 = getelementptr i64, i64* %r2, i32 8
%r46 = trunc i1408 %r43 to i64
store i64 %r46, i64* %r45
%r47 = lshr i1408 %r43, 64
%r49 = getelementptr i64, i64* %r2, i32 9
%r50 = trunc i1408 %r47 to i64
store i64 %r50, i64* %r49
%r51 = lshr i1408 %r47, 64
%r53 = getelementptr i64, i64* %r2, i32 10
%r54 = trunc i1408 %r51 to i64
store i64 %r54, i64* %r53
%r55 = lshr i1408 %r51, 64
%r57 = getelementptr i64, i64* %r2, i32 11
%r58 = trunc i1408 %r55 to i64
store i64 %r58, i64* %r57
%r59 = lshr i1408 %r55, 64
%r61 = getelementptr i64, i64* %r2, i32 12
%r62 = trunc i1408 %r59 to i64
store i64 %r62, i64* %r61
%r63 = lshr i1408 %r59, 64
%r65 = getelementptr i64, i64* %r2, i32 13
%r66 = trunc i1408 %r63 to i64
store i64 %r66, i64* %r65
%r67 = lshr i1408 %r63, 64
%r69 = getelementptr i64, i64* %r2, i32 14
%r70 = trunc i1408 %r67 to i64
store i64 %r70, i64* %r69
%r71 = lshr i1408 %r67, 64
%r73 = getelementptr i64, i64* %r2, i32 15
%r74 = trunc i1408 %r71 to i64
store i64 %r74, i64* %r73
%r75 = lshr i1408 %r71, 64
%r77 = getelementptr i64, i64* %r2, i32 16
%r78 = trunc i1408 %r75 to i64
store i64 %r78, i64* %r77
%r79 = lshr i1408 %r75, 64
%r81 = getelementptr i64, i64* %r2, i32 17
%r82 = trunc i1408 %r79 to i64
store i64 %r82, i64* %r81
%r83 = lshr i1408 %r79, 64
%r85 = getelementptr i64, i64* %r2, i32 18
%r86 = trunc i1408 %r83 to i64
store i64 %r86, i64* %r85
%r87 = lshr i1408 %r83, 64
%r89 = getelementptr i64, i64* %r2, i32 19
%r90 = trunc i1408 %r87 to i64
store i64 %r90, i64* %r89
%r91 = lshr i1408 %r87, 64
%r93 = getelementptr i64, i64* %r2, i32 20
%r94 = trunc i1408 %r91 to i64
store i64 %r94, i64* %r93
%r95 = lshr i1408 %r91, 64
%r97 = getelementptr i64, i64* %r2, i32 21
%r98 = trunc i1408 %r95 to i64
store i64 %r98, i64* %r97
%r99 = lshr i1408 %r11, 1407
%r100 = trunc i1408 %r99 to i64
%r102 = and i64 %r100, 1
ret i64 %r102
}
define i64 @mclb_add23(i64* noalias  %r2, i64* noalias  %r3, i64* noalias  %r4)
{
%r6 = bitcast i64* %r3 to i1472*
%r7 = load i1472, i1472* %r6
%r8 = zext i1472 %r7 to i1536
%r10 = bitcast i64* %r4 to i1472*
%r11 = load i1472, i1472* %r10
%r12 = zext i1472 %r11 to i1536
%r13 = add i1536 %r8, %r12
%r14 = trunc i1536 %r13 to i1472
%r16 = getelementptr i64, i64* %r2, i32 0
%r17 = trunc i1472 %r14 to i64
store i64 %r17, i64* %r16
%r18 = lshr i1472 %r14, 64
%r20 = getelementptr i64, i64* %r2, i32 1
%r21 = trunc i1472 %r18 to i64
store i64 %r21, i64* %r20
%r22 = lshr i1472 %r18, 64
%r24 = getelementptr i64, i64* %r2, i32 2
%r25 = trunc i1472 %r22 to i64
store i64 %r25, i64* %r24
%r26 = lshr i1472 %r22, 64
%r28 = getelementptr i64, i64* %r2, i32 3
%r29 = trunc i1472 %r26 to i64
store i64 %r29, i64* %r28
%r30 = lshr i1472 %r26, 64
%r32 = getelementptr i64, i64* %r2, i32 4
%r33 = trunc i1472 %r30 to i64
store i64 %r33, i64* %r32
%r34 = lshr i1472 %r30, 64
%r36 = getelementptr i64, i64* %r2, i32 5
%r37 = trunc i1472 %r34 to i64
store i64 %r37, i64* %r36
%r38 = lshr i1472 %r34, 64
%r40 = getelementptr i64, i64* %r2, i32 6
%r41 = trunc i1472 %r38 to i64
store i64 %r41, i64* %r40
%r42 = lshr i1472 %r38, 64
%r44 = getelementptr i64, i64* %r2, i32 7
%r45 = trunc i1472 %r42 to i64
store i64 %r45, i64* %r44
%r46 = lshr i1472 %r42, 64
%r48 = getelementptr i64, i64* %r2, i32 8
%r49 = trunc i1472 %r46 to i64
store i64 %r49, i64* %r48
%r50 = lshr i1472 %r46, 64
%r52 = getelementptr i64, i64* %r2, i32 9
%r53 = trunc i1472 %r50 to i64
store i64 %r53, i64* %r52
%r54 = lshr i1472 %r50, 64
%r56 = getelementptr i64, i64* %r2, i32 10
%r57 = trunc i1472 %r54 to i64
store i64 %r57, i64* %r56
%r58 = lshr i1472 %r54, 64
%r60 = getelementptr i64, i64* %r2, i32 11
%r61 = trunc i1472 %r58 to i64
store i64 %r61, i64* %r60
%r62 = lshr i1472 %r58, 64
%r64 = getelementptr i64, i64* %r2, i32 12
%r65 = trunc i1472 %r62 to i64
store i64 %r65, i64* %r64
%r66 = lshr i1472 %r62, 64
%r68 = getelementptr i64, i64* %r2, i32 13
%r69 = trunc i1472 %r66 to i64
store i64 %r69, i64* %r68
%r70 = lshr i1472 %r66, 64
%r72 = getelementptr i64, i64* %r2, i32 14
%r73 = trunc i1472 %r70 to i64
store i64 %r73, i64* %r72
%r74 = lshr i1472 %r70, 64
%r76 = getelementptr i64, i64* %r2, i32 15
%r77 = trunc i1472 %r74 to i64
store i64 %r77, i64* %r76
%r78 = lshr i1472 %r74, 64
%r80 = getelementptr i64, i64* %r2, i32 16
%r81 = trunc i1472 %r78 to i64
store i64 %r81, i64* %r80
%r82 = lshr i1472 %r78, 64
%r84 = getelementptr i64, i64* %r2, i32 17
%r85 = trunc i1472 %r82 to i64
store i64 %r85, i64* %r84
%r86 = lshr i1472 %r82, 64
%r88 = getelementptr i64, i64* %r2, i32 18
%r89 = trunc i1472 %r86 to i64
store i64 %r89, i64* %r88
%r90 = lshr i1472 %r86, 64
%r92 = getelementptr i64, i64* %r2, i32 19
%r93 = trunc i1472 %r90 to i64
store i64 %r93, i64* %r92
%r94 = lshr i1472 %r90, 64
%r96 = getelementptr i64, i64* %r2, i32 20
%r97 = trunc i1472 %r94 to i64
store i64 %r97, i64* %r96
%r98 = lshr i1472 %r94, 64
%r100 = getelementptr i64, i64* %r2, i32 21
%r101 = trunc i1472 %r98 to i64
store i64 %r101, i64* %r100
%r102 = lshr i1472 %r98, 64
%r104 = getelementptr i64, i64* %r2, i32 22
%r105 = trunc i1472 %r102 to i64
store i64 %r105, i64* %r104
%r106 = lshr i1536 %r13, 1472
%r107 = trunc i1536 %r106 to i64
ret i64 %r107
}
define i64 @mclb_sub23(i64* noalias  %r2, i64* noalias  %r3, i64* noalias  %r4)
{
%r6 = bitcast i64* %r3 to i1472*
%r7 = load i1472, i1472* %r6
%r8 = zext i1472 %r7 to i1536
%r10 = bitcast i64* %r4 to i1472*
%r11 = load i1472, i1472* %r10
%r12 = zext i1472 %r11 to i1536
%r13 = sub i1536 %r8, %r12
%r14 = trunc i1536 %r13 to i1472
%r16 = getelementptr i64, i64* %r2, i32 0
%r17 = trunc i1472 %r14 to i64
store i64 %r17, i64* %r16
%r18 = lshr i1472 %r14, 64
%r20 = getelementptr i64, i64* %r2, i32 1
%r21 = trunc i1472 %r18 to i64
store i64 %r21, i64* %r20
%r22 = lshr i1472 %r18, 64
%r24 = getelementptr i64, i64* %r2, i32 2
%r25 = trunc i1472 %r22 to i64
store i64 %r25, i64* %r24
%r26 = lshr i1472 %r22, 64
%r28 = getelementptr i64, i64* %r2, i32 3
%r29 = trunc i1472 %r26 to i64
store i64 %r29, i64* %r28
%r30 = lshr i1472 %r26, 64
%r32 = getelementptr i64, i64* %r2, i32 4
%r33 = trunc i1472 %r30 to i64
store i64 %r33, i64* %r32
%r34 = lshr i1472 %r30, 64
%r36 = getelementptr i64, i64* %r2, i32 5
%r37 = trunc i1472 %r34 to i64
store i64 %r37, i64* %r36
%r38 = lshr i1472 %r34, 64
%r40 = getelementptr i64, i64* %r2, i32 6
%r41 = trunc i1472 %r38 to i64
store i64 %r41, i64* %r40
%r42 = lshr i1472 %r38, 64
%r44 = getelementptr i64, i64* %r2, i32 7
%r45 = trunc i1472 %r42 to i64
store i64 %r45, i64* %r44
%r46 = lshr i1472 %r42, 64
%r48 = getelementptr i64, i64* %r2, i32 8
%r49 = trunc i1472 %r46 to i64
store i64 %r49, i64* %r48
%r50 = lshr i1472 %r46, 64
%r52 = getelementptr i64, i64* %r2, i32 9
%r53 = trunc i1472 %r50 to i64
store i64 %r53, i64* %r52
%r54 = lshr i1472 %r50, 64
%r56 = getelementptr i64, i64* %r2, i32 10
%r57 = trunc i1472 %r54 to i64
store i64 %r57, i64* %r56
%r58 = lshr i1472 %r54, 64
%r60 = getelementptr i64, i64* %r2, i32 11
%r61 = trunc i1472 %r58 to i64
store i64 %r61, i64* %r60
%r62 = lshr i1472 %r58, 64
%r64 = getelementptr i64, i64* %r2, i32 12
%r65 = trunc i1472 %r62 to i64
store i64 %r65, i64* %r64
%r66 = lshr i1472 %r62, 64
%r68 = getelementptr i64, i64* %r2, i32 13
%r69 = trunc i1472 %r66 to i64
store i64 %r69, i64* %r68
%r70 = lshr i1472 %r66, 64
%r72 = getelementptr i64, i64* %r2, i32 14
%r73 = trunc i1472 %r70 to i64
store i64 %r73, i64* %r72
%r74 = lshr i1472 %r70, 64
%r76 = getelementptr i64, i64* %r2, i32 15
%r77 = trunc i1472 %r74 to i64
store i64 %r77, i64* %r76
%r78 = lshr i1472 %r74, 64
%r80 = getelementptr i64, i64* %r2, i32 16
%r81 = trunc i1472 %r78 to i64
store i64 %r81, i64* %r80
%r82 = lshr i1472 %r78, 64
%r84 = getelementptr i64, i64* %r2, i32 17
%r85 = trunc i1472 %r82 to i64
store i64 %r85, i64* %r84
%r86 = lshr i1472 %r82, 64
%r88 = getelementptr i64, i64* %r2, i32 18
%r89 = trunc i1472 %r86 to i64
store i64 %r89, i64* %r88
%r90 = lshr i1472 %r86, 64
%r92 = getelementptr i64, i64* %r2, i32 19
%r93 = trunc i1472 %r90 to i64
store i64 %r93, i64* %r92
%r94 = lshr i1472 %r90, 64
%r96 = getelementptr i64, i64* %r2, i32 20
%r97 = trunc i1472 %r94 to i64
store i64 %r97, i64* %r96
%r98 = lshr i1472 %r94, 64
%r100 = getelementptr i64, i64* %r2, i32 21
%r101 = trunc i1472 %r98 to i64
store i64 %r101, i64* %r100
%r102 = lshr i1472 %r98, 64
%r104 = getelementptr i64, i64* %r2, i32 22
%r105 = trunc i1472 %r102 to i64
store i64 %r105, i64* %r104
%r106 = lshr i1536 %r13, 1472
%r107 = trunc i1536 %r106 to i64
%r109 = and i64 %r107, 1
ret i64 %r109
}
define void @mclb_addNF23(i64* noalias  %r1, i64* noalias  %r2, i64* noalias  %r3)
{
%r5 = bitcast i64* %r2 to i1472*
%r6 = load i1472, i1472* %r5
%r8 = bitcast i64* %r3 to i1472*
%r9 = load i1472, i1472* %r8
%r10 = add i1472 %r6, %r9
%r12 = getelementptr i64, i64* %r1, i32 0
%r13 = trunc i1472 %r10 to i64
store i64 %r13, i64* %r12
%r14 = lshr i1472 %r10, 64
%r16 = getelementptr i64, i64* %r1, i32 1
%r17 = trunc i1472 %r14 to i64
store i64 %r17, i64* %r16
%r18 = lshr i1472 %r14, 64
%r20 = getelementptr i64, i64* %r1, i32 2
%r21 = trunc i1472 %r18 to i64
store i64 %r21, i64* %r20
%r22 = lshr i1472 %r18, 64
%r24 = getelementptr i64, i64* %r1, i32 3
%r25 = trunc i1472 %r22 to i64
store i64 %r25, i64* %r24
%r26 = lshr i1472 %r22, 64
%r28 = getelementptr i64, i64* %r1, i32 4
%r29 = trunc i1472 %r26 to i64
store i64 %r29, i64* %r28
%r30 = lshr i1472 %r26, 64
%r32 = getelementptr i64, i64* %r1, i32 5
%r33 = trunc i1472 %r30 to i64
store i64 %r33, i64* %r32
%r34 = lshr i1472 %r30, 64
%r36 = getelementptr i64, i64* %r1, i32 6
%r37 = trunc i1472 %r34 to i64
store i64 %r37, i64* %r36
%r38 = lshr i1472 %r34, 64
%r40 = getelementptr i64, i64* %r1, i32 7
%r41 = trunc i1472 %r38 to i64
store i64 %r41, i64* %r40
%r42 = lshr i1472 %r38, 64
%r44 = getelementptr i64, i64* %r1, i32 8
%r45 = trunc i1472 %r42 to i64
store i64 %r45, i64* %r44
%r46 = lshr i1472 %r42, 64
%r48 = getelementptr i64, i64* %r1, i32 9
%r49 = trunc i1472 %r46 to i64
store i64 %r49, i64* %r48
%r50 = lshr i1472 %r46, 64
%r52 = getelementptr i64, i64* %r1, i32 10
%r53 = trunc i1472 %r50 to i64
store i64 %r53, i64* %r52
%r54 = lshr i1472 %r50, 64
%r56 = getelementptr i64, i64* %r1, i32 11
%r57 = trunc i1472 %r54 to i64
store i64 %r57, i64* %r56
%r58 = lshr i1472 %r54, 64
%r60 = getelementptr i64, i64* %r1, i32 12
%r61 = trunc i1472 %r58 to i64
store i64 %r61, i64* %r60
%r62 = lshr i1472 %r58, 64
%r64 = getelementptr i64, i64* %r1, i32 13
%r65 = trunc i1472 %r62 to i64
store i64 %r65, i64* %r64
%r66 = lshr i1472 %r62, 64
%r68 = getelementptr i64, i64* %r1, i32 14
%r69 = trunc i1472 %r66 to i64
store i64 %r69, i64* %r68
%r70 = lshr i1472 %r66, 64
%r72 = getelementptr i64, i64* %r1, i32 15
%r73 = trunc i1472 %r70 to i64
store i64 %r73, i64* %r72
%r74 = lshr i1472 %r70, 64
%r76 = getelementptr i64, i64* %r1, i32 16
%r77 = trunc i1472 %r74 to i64
store i64 %r77, i64* %r76
%r78 = lshr i1472 %r74, 64
%r80 = getelementptr i64, i64* %r1, i32 17
%r81 = trunc i1472 %r78 to i64
store i64 %r81, i64* %r80
%r82 = lshr i1472 %r78, 64
%r84 = getelementptr i64, i64* %r1, i32 18
%r85 = trunc i1472 %r82 to i64
store i64 %r85, i64* %r84
%r86 = lshr i1472 %r82, 64
%r88 = getelementptr i64, i64* %r1, i32 19
%r89 = trunc i1472 %r86 to i64
store i64 %r89, i64* %r88
%r90 = lshr i1472 %r86, 64
%r92 = getelementptr i64, i64* %r1, i32 20
%r93 = trunc i1472 %r90 to i64
store i64 %r93, i64* %r92
%r94 = lshr i1472 %r90, 64
%r96 = getelementptr i64, i64* %r1, i32 21
%r97 = trunc i1472 %r94 to i64
store i64 %r97, i64* %r96
%r98 = lshr i1472 %r94, 64
%r100 = getelementptr i64, i64* %r1, i32 22
%r101 = trunc i1472 %r98 to i64
store i64 %r101, i64* %r100
ret void
}
define i64 @mclb_subNF23(i64* noalias  %r2, i64* noalias  %r3, i64* noalias  %r4)
{
%r6 = bitcast i64* %r3 to i1472*
%r7 = load i1472, i1472* %r6
%r9 = bitcast i64* %r4 to i1472*
%r10 = load i1472, i1472* %r9
%r11 = sub i1472 %r7, %r10
%r13 = getelementptr i64, i64* %r2, i32 0
%r14 = trunc i1472 %r11 to i64
store i64 %r14, i64* %r13
%r15 = lshr i1472 %r11, 64
%r17 = getelementptr i64, i64* %r2, i32 1
%r18 = trunc i1472 %r15 to i64
store i64 %r18, i64* %r17
%r19 = lshr i1472 %r15, 64
%r21 = getelementptr i64, i64* %r2, i32 2
%r22 = trunc i1472 %r19 to i64
store i64 %r22, i64* %r21
%r23 = lshr i1472 %r19, 64
%r25 = getelementptr i64, i64* %r2, i32 3
%r26 = trunc i1472 %r23 to i64
store i64 %r26, i64* %r25
%r27 = lshr i1472 %r23, 64
%r29 = getelementptr i64, i64* %r2, i32 4
%r30 = trunc i1472 %r27 to i64
store i64 %r30, i64* %r29
%r31 = lshr i1472 %r27, 64
%r33 = getelementptr i64, i64* %r2, i32 5
%r34 = trunc i1472 %r31 to i64
store i64 %r34, i64* %r33
%r35 = lshr i1472 %r31, 64
%r37 = getelementptr i64, i64* %r2, i32 6
%r38 = trunc i1472 %r35 to i64
store i64 %r38, i64* %r37
%r39 = lshr i1472 %r35, 64
%r41 = getelementptr i64, i64* %r2, i32 7
%r42 = trunc i1472 %r39 to i64
store i64 %r42, i64* %r41
%r43 = lshr i1472 %r39, 64
%r45 = getelementptr i64, i64* %r2, i32 8
%r46 = trunc i1472 %r43 to i64
store i64 %r46, i64* %r45
%r47 = lshr i1472 %r43, 64
%r49 = getelementptr i64, i64* %r2, i32 9
%r50 = trunc i1472 %r47 to i64
store i64 %r50, i64* %r49
%r51 = lshr i1472 %r47, 64
%r53 = getelementptr i64, i64* %r2, i32 10
%r54 = trunc i1472 %r51 to i64
store i64 %r54, i64* %r53
%r55 = lshr i1472 %r51, 64
%r57 = getelementptr i64, i64* %r2, i32 11
%r58 = trunc i1472 %r55 to i64
store i64 %r58, i64* %r57
%r59 = lshr i1472 %r55, 64
%r61 = getelementptr i64, i64* %r2, i32 12
%r62 = trunc i1472 %r59 to i64
store i64 %r62, i64* %r61
%r63 = lshr i1472 %r59, 64
%r65 = getelementptr i64, i64* %r2, i32 13
%r66 = trunc i1472 %r63 to i64
store i64 %r66, i64* %r65
%r67 = lshr i1472 %r63, 64
%r69 = getelementptr i64, i64* %r2, i32 14
%r70 = trunc i1472 %r67 to i64
store i64 %r70, i64* %r69
%r71 = lshr i1472 %r67, 64
%r73 = getelementptr i64, i64* %r2, i32 15
%r74 = trunc i1472 %r71 to i64
store i64 %r74, i64* %r73
%r75 = lshr i1472 %r71, 64
%r77 = getelementptr i64, i64* %r2, i32 16
%r78 = trunc i1472 %r75 to i64
store i64 %r78, i64* %r77
%r79 = lshr i1472 %r75, 64
%r81 = getelementptr i64, i64* %r2, i32 17
%r82 = trunc i1472 %r79 to i64
store i64 %r82, i64* %r81
%r83 = lshr i1472 %r79, 64
%r85 = getelementptr i64, i64* %r2, i32 18
%r86 = trunc i1472 %r83 to i64
store i64 %r86, i64* %r85
%r87 = lshr i1472 %r83, 64
%r89 = getelementptr i64, i64* %r2, i32 19
%r90 = trunc i1472 %r87 to i64
store i64 %r90, i64* %r89
%r91 = lshr i1472 %r87, 64
%r93 = getelementptr i64, i64* %r2, i32 20
%r94 = trunc i1472 %r91 to i64
store i64 %r94, i64* %r93
%r95 = lshr i1472 %r91, 64
%r97 = getelementptr i64, i64* %r2, i32 21
%r98 = trunc i1472 %r95 to i64
store i64 %r98, i64* %r97
%r99 = lshr i1472 %r95, 64
%r101 = getelementptr i64, i64* %r2, i32 22
%r102 = trunc i1472 %r99 to i64
store i64 %r102, i64* %r101
%r103 = lshr i1472 %r11, 1471
%r104 = trunc i1472 %r103 to i64
%r106 = and i64 %r104, 1
ret i64 %r106
}
define i64 @mclb_add24(i64* noalias  %r2, i64* noalias  %r3, i64* noalias  %r4)
{
%r6 = bitcast i64* %r3 to i1536*
%r7 = load i1536, i1536* %r6
%r8 = zext i1536 %r7 to i1600
%r10 = bitcast i64* %r4 to i1536*
%r11 = load i1536, i1536* %r10
%r12 = zext i1536 %r11 to i1600
%r13 = add i1600 %r8, %r12
%r14 = trunc i1600 %r13 to i1536
%r16 = getelementptr i64, i64* %r2, i32 0
%r17 = trunc i1536 %r14 to i64
store i64 %r17, i64* %r16
%r18 = lshr i1536 %r14, 64
%r20 = getelementptr i64, i64* %r2, i32 1
%r21 = trunc i1536 %r18 to i64
store i64 %r21, i64* %r20
%r22 = lshr i1536 %r18, 64
%r24 = getelementptr i64, i64* %r2, i32 2
%r25 = trunc i1536 %r22 to i64
store i64 %r25, i64* %r24
%r26 = lshr i1536 %r22, 64
%r28 = getelementptr i64, i64* %r2, i32 3
%r29 = trunc i1536 %r26 to i64
store i64 %r29, i64* %r28
%r30 = lshr i1536 %r26, 64
%r32 = getelementptr i64, i64* %r2, i32 4
%r33 = trunc i1536 %r30 to i64
store i64 %r33, i64* %r32
%r34 = lshr i1536 %r30, 64
%r36 = getelementptr i64, i64* %r2, i32 5
%r37 = trunc i1536 %r34 to i64
store i64 %r37, i64* %r36
%r38 = lshr i1536 %r34, 64
%r40 = getelementptr i64, i64* %r2, i32 6
%r41 = trunc i1536 %r38 to i64
store i64 %r41, i64* %r40
%r42 = lshr i1536 %r38, 64
%r44 = getelementptr i64, i64* %r2, i32 7
%r45 = trunc i1536 %r42 to i64
store i64 %r45, i64* %r44
%r46 = lshr i1536 %r42, 64
%r48 = getelementptr i64, i64* %r2, i32 8
%r49 = trunc i1536 %r46 to i64
store i64 %r49, i64* %r48
%r50 = lshr i1536 %r46, 64
%r52 = getelementptr i64, i64* %r2, i32 9
%r53 = trunc i1536 %r50 to i64
store i64 %r53, i64* %r52
%r54 = lshr i1536 %r50, 64
%r56 = getelementptr i64, i64* %r2, i32 10
%r57 = trunc i1536 %r54 to i64
store i64 %r57, i64* %r56
%r58 = lshr i1536 %r54, 64
%r60 = getelementptr i64, i64* %r2, i32 11
%r61 = trunc i1536 %r58 to i64
store i64 %r61, i64* %r60
%r62 = lshr i1536 %r58, 64
%r64 = getelementptr i64, i64* %r2, i32 12
%r65 = trunc i1536 %r62 to i64
store i64 %r65, i64* %r64
%r66 = lshr i1536 %r62, 64
%r68 = getelementptr i64, i64* %r2, i32 13
%r69 = trunc i1536 %r66 to i64
store i64 %r69, i64* %r68
%r70 = lshr i1536 %r66, 64
%r72 = getelementptr i64, i64* %r2, i32 14
%r73 = trunc i1536 %r70 to i64
store i64 %r73, i64* %r72
%r74 = lshr i1536 %r70, 64
%r76 = getelementptr i64, i64* %r2, i32 15
%r77 = trunc i1536 %r74 to i64
store i64 %r77, i64* %r76
%r78 = lshr i1536 %r74, 64
%r80 = getelementptr i64, i64* %r2, i32 16
%r81 = trunc i1536 %r78 to i64
store i64 %r81, i64* %r80
%r82 = lshr i1536 %r78, 64
%r84 = getelementptr i64, i64* %r2, i32 17
%r85 = trunc i1536 %r82 to i64
store i64 %r85, i64* %r84
%r86 = lshr i1536 %r82, 64
%r88 = getelementptr i64, i64* %r2, i32 18
%r89 = trunc i1536 %r86 to i64
store i64 %r89, i64* %r88
%r90 = lshr i1536 %r86, 64
%r92 = getelementptr i64, i64* %r2, i32 19
%r93 = trunc i1536 %r90 to i64
store i64 %r93, i64* %r92
%r94 = lshr i1536 %r90, 64
%r96 = getelementptr i64, i64* %r2, i32 20
%r97 = trunc i1536 %r94 to i64
store i64 %r97, i64* %r96
%r98 = lshr i1536 %r94, 64
%r100 = getelementptr i64, i64* %r2, i32 21
%r101 = trunc i1536 %r98 to i64
store i64 %r101, i64* %r100
%r102 = lshr i1536 %r98, 64
%r104 = getelementptr i64, i64* %r2, i32 22
%r105 = trunc i1536 %r102 to i64
store i64 %r105, i64* %r104
%r106 = lshr i1536 %r102, 64
%r108 = getelementptr i64, i64* %r2, i32 23
%r109 = trunc i1536 %r106 to i64
store i64 %r109, i64* %r108
%r110 = lshr i1600 %r13, 1536
%r111 = trunc i1600 %r110 to i64
ret i64 %r111
}
define i64 @mclb_sub24(i64* noalias  %r2, i64* noalias  %r3, i64* noalias  %r4)
{
%r6 = bitcast i64* %r3 to i1536*
%r7 = load i1536, i1536* %r6
%r8 = zext i1536 %r7 to i1600
%r10 = bitcast i64* %r4 to i1536*
%r11 = load i1536, i1536* %r10
%r12 = zext i1536 %r11 to i1600
%r13 = sub i1600 %r8, %r12
%r14 = trunc i1600 %r13 to i1536
%r16 = getelementptr i64, i64* %r2, i32 0
%r17 = trunc i1536 %r14 to i64
store i64 %r17, i64* %r16
%r18 = lshr i1536 %r14, 64
%r20 = getelementptr i64, i64* %r2, i32 1
%r21 = trunc i1536 %r18 to i64
store i64 %r21, i64* %r20
%r22 = lshr i1536 %r18, 64
%r24 = getelementptr i64, i64* %r2, i32 2
%r25 = trunc i1536 %r22 to i64
store i64 %r25, i64* %r24
%r26 = lshr i1536 %r22, 64
%r28 = getelementptr i64, i64* %r2, i32 3
%r29 = trunc i1536 %r26 to i64
store i64 %r29, i64* %r28
%r30 = lshr i1536 %r26, 64
%r32 = getelementptr i64, i64* %r2, i32 4
%r33 = trunc i1536 %r30 to i64
store i64 %r33, i64* %r32
%r34 = lshr i1536 %r30, 64
%r36 = getelementptr i64, i64* %r2, i32 5
%r37 = trunc i1536 %r34 to i64
store i64 %r37, i64* %r36
%r38 = lshr i1536 %r34, 64
%r40 = getelementptr i64, i64* %r2, i32 6
%r41 = trunc i1536 %r38 to i64
store i64 %r41, i64* %r40
%r42 = lshr i1536 %r38, 64
%r44 = getelementptr i64, i64* %r2, i32 7
%r45 = trunc i1536 %r42 to i64
store i64 %r45, i64* %r44
%r46 = lshr i1536 %r42, 64
%r48 = getelementptr i64, i64* %r2, i32 8
%r49 = trunc i1536 %r46 to i64
store i64 %r49, i64* %r48
%r50 = lshr i1536 %r46, 64
%r52 = getelementptr i64, i64* %r2, i32 9
%r53 = trunc i1536 %r50 to i64
store i64 %r53, i64* %r52
%r54 = lshr i1536 %r50, 64
%r56 = getelementptr i64, i64* %r2, i32 10
%r57 = trunc i1536 %r54 to i64
store i64 %r57, i64* %r56
%r58 = lshr i1536 %r54, 64
%r60 = getelementptr i64, i64* %r2, i32 11
%r61 = trunc i1536 %r58 to i64
store i64 %r61, i64* %r60
%r62 = lshr i1536 %r58, 64
%r64 = getelementptr i64, i64* %r2, i32 12
%r65 = trunc i1536 %r62 to i64
store i64 %r65, i64* %r64
%r66 = lshr i1536 %r62, 64
%r68 = getelementptr i64, i64* %r2, i32 13
%r69 = trunc i1536 %r66 to i64
store i64 %r69, i64* %r68
%r70 = lshr i1536 %r66, 64
%r72 = getelementptr i64, i64* %r2, i32 14
%r73 = trunc i1536 %r70 to i64
store i64 %r73, i64* %r72
%r74 = lshr i1536 %r70, 64
%r76 = getelementptr i64, i64* %r2, i32 15
%r77 = trunc i1536 %r74 to i64
store i64 %r77, i64* %r76
%r78 = lshr i1536 %r74, 64
%r80 = getelementptr i64, i64* %r2, i32 16
%r81 = trunc i1536 %r78 to i64
store i64 %r81, i64* %r80
%r82 = lshr i1536 %r78, 64
%r84 = getelementptr i64, i64* %r2, i32 17
%r85 = trunc i1536 %r82 to i64
store i64 %r85, i64* %r84
%r86 = lshr i1536 %r82, 64
%r88 = getelementptr i64, i64* %r2, i32 18
%r89 = trunc i1536 %r86 to i64
store i64 %r89, i64* %r88
%r90 = lshr i1536 %r86, 64
%r92 = getelementptr i64, i64* %r2, i32 19
%r93 = trunc i1536 %r90 to i64
store i64 %r93, i64* %r92
%r94 = lshr i1536 %r90, 64
%r96 = getelementptr i64, i64* %r2, i32 20
%r97 = trunc i1536 %r94 to i64
store i64 %r97, i64* %r96
%r98 = lshr i1536 %r94, 64
%r100 = getelementptr i64, i64* %r2, i32 21
%r101 = trunc i1536 %r98 to i64
store i64 %r101, i64* %r100
%r102 = lshr i1536 %r98, 64
%r104 = getelementptr i64, i64* %r2, i32 22
%r105 = trunc i1536 %r102 to i64
store i64 %r105, i64* %r104
%r106 = lshr i1536 %r102, 64
%r108 = getelementptr i64, i64* %r2, i32 23
%r109 = trunc i1536 %r106 to i64
store i64 %r109, i64* %r108
%r110 = lshr i1600 %r13, 1536
%r111 = trunc i1600 %r110 to i64
%r113 = and i64 %r111, 1
ret i64 %r113
}
define void @mclb_addNF24(i64* noalias  %r1, i64* noalias  %r2, i64* noalias  %r3)
{
%r5 = bitcast i64* %r2 to i1536*
%r6 = load i1536, i1536* %r5
%r8 = bitcast i64* %r3 to i1536*
%r9 = load i1536, i1536* %r8
%r10 = add i1536 %r6, %r9
%r12 = getelementptr i64, i64* %r1, i32 0
%r13 = trunc i1536 %r10 to i64
store i64 %r13, i64* %r12
%r14 = lshr i1536 %r10, 64
%r16 = getelementptr i64, i64* %r1, i32 1
%r17 = trunc i1536 %r14 to i64
store i64 %r17, i64* %r16
%r18 = lshr i1536 %r14, 64
%r20 = getelementptr i64, i64* %r1, i32 2
%r21 = trunc i1536 %r18 to i64
store i64 %r21, i64* %r20
%r22 = lshr i1536 %r18, 64
%r24 = getelementptr i64, i64* %r1, i32 3
%r25 = trunc i1536 %r22 to i64
store i64 %r25, i64* %r24
%r26 = lshr i1536 %r22, 64
%r28 = getelementptr i64, i64* %r1, i32 4
%r29 = trunc i1536 %r26 to i64
store i64 %r29, i64* %r28
%r30 = lshr i1536 %r26, 64
%r32 = getelementptr i64, i64* %r1, i32 5
%r33 = trunc i1536 %r30 to i64
store i64 %r33, i64* %r32
%r34 = lshr i1536 %r30, 64
%r36 = getelementptr i64, i64* %r1, i32 6
%r37 = trunc i1536 %r34 to i64
store i64 %r37, i64* %r36
%r38 = lshr i1536 %r34, 64
%r40 = getelementptr i64, i64* %r1, i32 7
%r41 = trunc i1536 %r38 to i64
store i64 %r41, i64* %r40
%r42 = lshr i1536 %r38, 64
%r44 = getelementptr i64, i64* %r1, i32 8
%r45 = trunc i1536 %r42 to i64
store i64 %r45, i64* %r44
%r46 = lshr i1536 %r42, 64
%r48 = getelementptr i64, i64* %r1, i32 9
%r49 = trunc i1536 %r46 to i64
store i64 %r49, i64* %r48
%r50 = lshr i1536 %r46, 64
%r52 = getelementptr i64, i64* %r1, i32 10
%r53 = trunc i1536 %r50 to i64
store i64 %r53, i64* %r52
%r54 = lshr i1536 %r50, 64
%r56 = getelementptr i64, i64* %r1, i32 11
%r57 = trunc i1536 %r54 to i64
store i64 %r57, i64* %r56
%r58 = lshr i1536 %r54, 64
%r60 = getelementptr i64, i64* %r1, i32 12
%r61 = trunc i1536 %r58 to i64
store i64 %r61, i64* %r60
%r62 = lshr i1536 %r58, 64
%r64 = getelementptr i64, i64* %r1, i32 13
%r65 = trunc i1536 %r62 to i64
store i64 %r65, i64* %r64
%r66 = lshr i1536 %r62, 64
%r68 = getelementptr i64, i64* %r1, i32 14
%r69 = trunc i1536 %r66 to i64
store i64 %r69, i64* %r68
%r70 = lshr i1536 %r66, 64
%r72 = getelementptr i64, i64* %r1, i32 15
%r73 = trunc i1536 %r70 to i64
store i64 %r73, i64* %r72
%r74 = lshr i1536 %r70, 64
%r76 = getelementptr i64, i64* %r1, i32 16
%r77 = trunc i1536 %r74 to i64
store i64 %r77, i64* %r76
%r78 = lshr i1536 %r74, 64
%r80 = getelementptr i64, i64* %r1, i32 17
%r81 = trunc i1536 %r78 to i64
store i64 %r81, i64* %r80
%r82 = lshr i1536 %r78, 64
%r84 = getelementptr i64, i64* %r1, i32 18
%r85 = trunc i1536 %r82 to i64
store i64 %r85, i64* %r84
%r86 = lshr i1536 %r82, 64
%r88 = getelementptr i64, i64* %r1, i32 19
%r89 = trunc i1536 %r86 to i64
store i64 %r89, i64* %r88
%r90 = lshr i1536 %r86, 64
%r92 = getelementptr i64, i64* %r1, i32 20
%r93 = trunc i1536 %r90 to i64
store i64 %r93, i64* %r92
%r94 = lshr i1536 %r90, 64
%r96 = getelementptr i64, i64* %r1, i32 21
%r97 = trunc i1536 %r94 to i64
store i64 %r97, i64* %r96
%r98 = lshr i1536 %r94, 64
%r100 = getelementptr i64, i64* %r1, i32 22
%r101 = trunc i1536 %r98 to i64
store i64 %r101, i64* %r100
%r102 = lshr i1536 %r98, 64
%r104 = getelementptr i64, i64* %r1, i32 23
%r105 = trunc i1536 %r102 to i64
store i64 %r105, i64* %r104
ret void
}
define i64 @mclb_subNF24(i64* noalias  %r2, i64* noalias  %r3, i64* noalias  %r4)
{
%r6 = bitcast i64* %r3 to i1536*
%r7 = load i1536, i1536* %r6
%r9 = bitcast i64* %r4 to i1536*
%r10 = load i1536, i1536* %r9
%r11 = sub i1536 %r7, %r10
%r13 = getelementptr i64, i64* %r2, i32 0
%r14 = trunc i1536 %r11 to i64
store i64 %r14, i64* %r13
%r15 = lshr i1536 %r11, 64
%r17 = getelementptr i64, i64* %r2, i32 1
%r18 = trunc i1536 %r15 to i64
store i64 %r18, i64* %r17
%r19 = lshr i1536 %r15, 64
%r21 = getelementptr i64, i64* %r2, i32 2
%r22 = trunc i1536 %r19 to i64
store i64 %r22, i64* %r21
%r23 = lshr i1536 %r19, 64
%r25 = getelementptr i64, i64* %r2, i32 3
%r26 = trunc i1536 %r23 to i64
store i64 %r26, i64* %r25
%r27 = lshr i1536 %r23, 64
%r29 = getelementptr i64, i64* %r2, i32 4
%r30 = trunc i1536 %r27 to i64
store i64 %r30, i64* %r29
%r31 = lshr i1536 %r27, 64
%r33 = getelementptr i64, i64* %r2, i32 5
%r34 = trunc i1536 %r31 to i64
store i64 %r34, i64* %r33
%r35 = lshr i1536 %r31, 64
%r37 = getelementptr i64, i64* %r2, i32 6
%r38 = trunc i1536 %r35 to i64
store i64 %r38, i64* %r37
%r39 = lshr i1536 %r35, 64
%r41 = getelementptr i64, i64* %r2, i32 7
%r42 = trunc i1536 %r39 to i64
store i64 %r42, i64* %r41
%r43 = lshr i1536 %r39, 64
%r45 = getelementptr i64, i64* %r2, i32 8
%r46 = trunc i1536 %r43 to i64
store i64 %r46, i64* %r45
%r47 = lshr i1536 %r43, 64
%r49 = getelementptr i64, i64* %r2, i32 9
%r50 = trunc i1536 %r47 to i64
store i64 %r50, i64* %r49
%r51 = lshr i1536 %r47, 64
%r53 = getelementptr i64, i64* %r2, i32 10
%r54 = trunc i1536 %r51 to i64
store i64 %r54, i64* %r53
%r55 = lshr i1536 %r51, 64
%r57 = getelementptr i64, i64* %r2, i32 11
%r58 = trunc i1536 %r55 to i64
store i64 %r58, i64* %r57
%r59 = lshr i1536 %r55, 64
%r61 = getelementptr i64, i64* %r2, i32 12
%r62 = trunc i1536 %r59 to i64
store i64 %r62, i64* %r61
%r63 = lshr i1536 %r59, 64
%r65 = getelementptr i64, i64* %r2, i32 13
%r66 = trunc i1536 %r63 to i64
store i64 %r66, i64* %r65
%r67 = lshr i1536 %r63, 64
%r69 = getelementptr i64, i64* %r2, i32 14
%r70 = trunc i1536 %r67 to i64
store i64 %r70, i64* %r69
%r71 = lshr i1536 %r67, 64
%r73 = getelementptr i64, i64* %r2, i32 15
%r74 = trunc i1536 %r71 to i64
store i64 %r74, i64* %r73
%r75 = lshr i1536 %r71, 64
%r77 = getelementptr i64, i64* %r2, i32 16
%r78 = trunc i1536 %r75 to i64
store i64 %r78, i64* %r77
%r79 = lshr i1536 %r75, 64
%r81 = getelementptr i64, i64* %r2, i32 17
%r82 = trunc i1536 %r79 to i64
store i64 %r82, i64* %r81
%r83 = lshr i1536 %r79, 64
%r85 = getelementptr i64, i64* %r2, i32 18
%r86 = trunc i1536 %r83 to i64
store i64 %r86, i64* %r85
%r87 = lshr i1536 %r83, 64
%r89 = getelementptr i64, i64* %r2, i32 19
%r90 = trunc i1536 %r87 to i64
store i64 %r90, i64* %r89
%r91 = lshr i1536 %r87, 64
%r93 = getelementptr i64, i64* %r2, i32 20
%r94 = trunc i1536 %r91 to i64
store i64 %r94, i64* %r93
%r95 = lshr i1536 %r91, 64
%r97 = getelementptr i64, i64* %r2, i32 21
%r98 = trunc i1536 %r95 to i64
store i64 %r98, i64* %r97
%r99 = lshr i1536 %r95, 64
%r101 = getelementptr i64, i64* %r2, i32 22
%r102 = trunc i1536 %r99 to i64
store i64 %r102, i64* %r101
%r103 = lshr i1536 %r99, 64
%r105 = getelementptr i64, i64* %r2, i32 23
%r106 = trunc i1536 %r103 to i64
store i64 %r106, i64* %r105
%r107 = lshr i1536 %r11, 1535
%r108 = trunc i1536 %r107 to i64
%r110 = and i64 %r108, 1
ret i64 %r110
}
define i64 @mclb_add25(i64* noalias  %r2, i64* noalias  %r3, i64* noalias  %r4)
{
%r6 = bitcast i64* %r3 to i1600*
%r7 = load i1600, i1600* %r6
%r8 = zext i1600 %r7 to i1664
%r10 = bitcast i64* %r4 to i1600*
%r11 = load i1600, i1600* %r10
%r12 = zext i1600 %r11 to i1664
%r13 = add i1664 %r8, %r12
%r14 = trunc i1664 %r13 to i1600
%r16 = getelementptr i64, i64* %r2, i32 0
%r17 = trunc i1600 %r14 to i64
store i64 %r17, i64* %r16
%r18 = lshr i1600 %r14, 64
%r20 = getelementptr i64, i64* %r2, i32 1
%r21 = trunc i1600 %r18 to i64
store i64 %r21, i64* %r20
%r22 = lshr i1600 %r18, 64
%r24 = getelementptr i64, i64* %r2, i32 2
%r25 = trunc i1600 %r22 to i64
store i64 %r25, i64* %r24
%r26 = lshr i1600 %r22, 64
%r28 = getelementptr i64, i64* %r2, i32 3
%r29 = trunc i1600 %r26 to i64
store i64 %r29, i64* %r28
%r30 = lshr i1600 %r26, 64
%r32 = getelementptr i64, i64* %r2, i32 4
%r33 = trunc i1600 %r30 to i64
store i64 %r33, i64* %r32
%r34 = lshr i1600 %r30, 64
%r36 = getelementptr i64, i64* %r2, i32 5
%r37 = trunc i1600 %r34 to i64
store i64 %r37, i64* %r36
%r38 = lshr i1600 %r34, 64
%r40 = getelementptr i64, i64* %r2, i32 6
%r41 = trunc i1600 %r38 to i64
store i64 %r41, i64* %r40
%r42 = lshr i1600 %r38, 64
%r44 = getelementptr i64, i64* %r2, i32 7
%r45 = trunc i1600 %r42 to i64
store i64 %r45, i64* %r44
%r46 = lshr i1600 %r42, 64
%r48 = getelementptr i64, i64* %r2, i32 8
%r49 = trunc i1600 %r46 to i64
store i64 %r49, i64* %r48
%r50 = lshr i1600 %r46, 64
%r52 = getelementptr i64, i64* %r2, i32 9
%r53 = trunc i1600 %r50 to i64
store i64 %r53, i64* %r52
%r54 = lshr i1600 %r50, 64
%r56 = getelementptr i64, i64* %r2, i32 10
%r57 = trunc i1600 %r54 to i64
store i64 %r57, i64* %r56
%r58 = lshr i1600 %r54, 64
%r60 = getelementptr i64, i64* %r2, i32 11
%r61 = trunc i1600 %r58 to i64
store i64 %r61, i64* %r60
%r62 = lshr i1600 %r58, 64
%r64 = getelementptr i64, i64* %r2, i32 12
%r65 = trunc i1600 %r62 to i64
store i64 %r65, i64* %r64
%r66 = lshr i1600 %r62, 64
%r68 = getelementptr i64, i64* %r2, i32 13
%r69 = trunc i1600 %r66 to i64
store i64 %r69, i64* %r68
%r70 = lshr i1600 %r66, 64
%r72 = getelementptr i64, i64* %r2, i32 14
%r73 = trunc i1600 %r70 to i64
store i64 %r73, i64* %r72
%r74 = lshr i1600 %r70, 64
%r76 = getelementptr i64, i64* %r2, i32 15
%r77 = trunc i1600 %r74 to i64
store i64 %r77, i64* %r76
%r78 = lshr i1600 %r74, 64
%r80 = getelementptr i64, i64* %r2, i32 16
%r81 = trunc i1600 %r78 to i64
store i64 %r81, i64* %r80
%r82 = lshr i1600 %r78, 64
%r84 = getelementptr i64, i64* %r2, i32 17
%r85 = trunc i1600 %r82 to i64
store i64 %r85, i64* %r84
%r86 = lshr i1600 %r82, 64
%r88 = getelementptr i64, i64* %r2, i32 18
%r89 = trunc i1600 %r86 to i64
store i64 %r89, i64* %r88
%r90 = lshr i1600 %r86, 64
%r92 = getelementptr i64, i64* %r2, i32 19
%r93 = trunc i1600 %r90 to i64
store i64 %r93, i64* %r92
%r94 = lshr i1600 %r90, 64
%r96 = getelementptr i64, i64* %r2, i32 20
%r97 = trunc i1600 %r94 to i64
store i64 %r97, i64* %r96
%r98 = lshr i1600 %r94, 64
%r100 = getelementptr i64, i64* %r2, i32 21
%r101 = trunc i1600 %r98 to i64
store i64 %r101, i64* %r100
%r102 = lshr i1600 %r98, 64
%r104 = getelementptr i64, i64* %r2, i32 22
%r105 = trunc i1600 %r102 to i64
store i64 %r105, i64* %r104
%r106 = lshr i1600 %r102, 64
%r108 = getelementptr i64, i64* %r2, i32 23
%r109 = trunc i1600 %r106 to i64
store i64 %r109, i64* %r108
%r110 = lshr i1600 %r106, 64
%r112 = getelementptr i64, i64* %r2, i32 24
%r113 = trunc i1600 %r110 to i64
store i64 %r113, i64* %r112
%r114 = lshr i1664 %r13, 1600
%r115 = trunc i1664 %r114 to i64
ret i64 %r115
}
define i64 @mclb_sub25(i64* noalias  %r2, i64* noalias  %r3, i64* noalias  %r4)
{
%r6 = bitcast i64* %r3 to i1600*
%r7 = load i1600, i1600* %r6
%r8 = zext i1600 %r7 to i1664
%r10 = bitcast i64* %r4 to i1600*
%r11 = load i1600, i1600* %r10
%r12 = zext i1600 %r11 to i1664
%r13 = sub i1664 %r8, %r12
%r14 = trunc i1664 %r13 to i1600
%r16 = getelementptr i64, i64* %r2, i32 0
%r17 = trunc i1600 %r14 to i64
store i64 %r17, i64* %r16
%r18 = lshr i1600 %r14, 64
%r20 = getelementptr i64, i64* %r2, i32 1
%r21 = trunc i1600 %r18 to i64
store i64 %r21, i64* %r20
%r22 = lshr i1600 %r18, 64
%r24 = getelementptr i64, i64* %r2, i32 2
%r25 = trunc i1600 %r22 to i64
store i64 %r25, i64* %r24
%r26 = lshr i1600 %r22, 64
%r28 = getelementptr i64, i64* %r2, i32 3
%r29 = trunc i1600 %r26 to i64
store i64 %r29, i64* %r28
%r30 = lshr i1600 %r26, 64
%r32 = getelementptr i64, i64* %r2, i32 4
%r33 = trunc i1600 %r30 to i64
store i64 %r33, i64* %r32
%r34 = lshr i1600 %r30, 64
%r36 = getelementptr i64, i64* %r2, i32 5
%r37 = trunc i1600 %r34 to i64
store i64 %r37, i64* %r36
%r38 = lshr i1600 %r34, 64
%r40 = getelementptr i64, i64* %r2, i32 6
%r41 = trunc i1600 %r38 to i64
store i64 %r41, i64* %r40
%r42 = lshr i1600 %r38, 64
%r44 = getelementptr i64, i64* %r2, i32 7
%r45 = trunc i1600 %r42 to i64
store i64 %r45, i64* %r44
%r46 = lshr i1600 %r42, 64
%r48 = getelementptr i64, i64* %r2, i32 8
%r49 = trunc i1600 %r46 to i64
store i64 %r49, i64* %r48
%r50 = lshr i1600 %r46, 64
%r52 = getelementptr i64, i64* %r2, i32 9
%r53 = trunc i1600 %r50 to i64
store i64 %r53, i64* %r52
%r54 = lshr i1600 %r50, 64
%r56 = getelementptr i64, i64* %r2, i32 10
%r57 = trunc i1600 %r54 to i64
store i64 %r57, i64* %r56
%r58 = lshr i1600 %r54, 64
%r60 = getelementptr i64, i64* %r2, i32 11
%r61 = trunc i1600 %r58 to i64
store i64 %r61, i64* %r60
%r62 = lshr i1600 %r58, 64
%r64 = getelementptr i64, i64* %r2, i32 12
%r65 = trunc i1600 %r62 to i64
store i64 %r65, i64* %r64
%r66 = lshr i1600 %r62, 64
%r68 = getelementptr i64, i64* %r2, i32 13
%r69 = trunc i1600 %r66 to i64
store i64 %r69, i64* %r68
%r70 = lshr i1600 %r66, 64
%r72 = getelementptr i64, i64* %r2, i32 14
%r73 = trunc i1600 %r70 to i64
store i64 %r73, i64* %r72
%r74 = lshr i1600 %r70, 64
%r76 = getelementptr i64, i64* %r2, i32 15
%r77 = trunc i1600 %r74 to i64
store i64 %r77, i64* %r76
%r78 = lshr i1600 %r74, 64
%r80 = getelementptr i64, i64* %r2, i32 16
%r81 = trunc i1600 %r78 to i64
store i64 %r81, i64* %r80
%r82 = lshr i1600 %r78, 64
%r84 = getelementptr i64, i64* %r2, i32 17
%r85 = trunc i1600 %r82 to i64
store i64 %r85, i64* %r84
%r86 = lshr i1600 %r82, 64
%r88 = getelementptr i64, i64* %r2, i32 18
%r89 = trunc i1600 %r86 to i64
store i64 %r89, i64* %r88
%r90 = lshr i1600 %r86, 64
%r92 = getelementptr i64, i64* %r2, i32 19
%r93 = trunc i1600 %r90 to i64
store i64 %r93, i64* %r92
%r94 = lshr i1600 %r90, 64
%r96 = getelementptr i64, i64* %r2, i32 20
%r97 = trunc i1600 %r94 to i64
store i64 %r97, i64* %r96
%r98 = lshr i1600 %r94, 64
%r100 = getelementptr i64, i64* %r2, i32 21
%r101 = trunc i1600 %r98 to i64
store i64 %r101, i64* %r100
%r102 = lshr i1600 %r98, 64
%r104 = getelementptr i64, i64* %r2, i32 22
%r105 = trunc i1600 %r102 to i64
store i64 %r105, i64* %r104
%r106 = lshr i1600 %r102, 64
%r108 = getelementptr i64, i64* %r2, i32 23
%r109 = trunc i1600 %r106 to i64
store i64 %r109, i64* %r108
%r110 = lshr i1600 %r106, 64
%r112 = getelementptr i64, i64* %r2, i32 24
%r113 = trunc i1600 %r110 to i64
store i64 %r113, i64* %r112
%r114 = lshr i1664 %r13, 1600
%r115 = trunc i1664 %r114 to i64
%r117 = and i64 %r115, 1
ret i64 %r117
}
define void @mclb_addNF25(i64* noalias  %r1, i64* noalias  %r2, i64* noalias  %r3)
{
%r5 = bitcast i64* %r2 to i1600*
%r6 = load i1600, i1600* %r5
%r8 = bitcast i64* %r3 to i1600*
%r9 = load i1600, i1600* %r8
%r10 = add i1600 %r6, %r9
%r12 = getelementptr i64, i64* %r1, i32 0
%r13 = trunc i1600 %r10 to i64
store i64 %r13, i64* %r12
%r14 = lshr i1600 %r10, 64
%r16 = getelementptr i64, i64* %r1, i32 1
%r17 = trunc i1600 %r14 to i64
store i64 %r17, i64* %r16
%r18 = lshr i1600 %r14, 64
%r20 = getelementptr i64, i64* %r1, i32 2
%r21 = trunc i1600 %r18 to i64
store i64 %r21, i64* %r20
%r22 = lshr i1600 %r18, 64
%r24 = getelementptr i64, i64* %r1, i32 3
%r25 = trunc i1600 %r22 to i64
store i64 %r25, i64* %r24
%r26 = lshr i1600 %r22, 64
%r28 = getelementptr i64, i64* %r1, i32 4
%r29 = trunc i1600 %r26 to i64
store i64 %r29, i64* %r28
%r30 = lshr i1600 %r26, 64
%r32 = getelementptr i64, i64* %r1, i32 5
%r33 = trunc i1600 %r30 to i64
store i64 %r33, i64* %r32
%r34 = lshr i1600 %r30, 64
%r36 = getelementptr i64, i64* %r1, i32 6
%r37 = trunc i1600 %r34 to i64
store i64 %r37, i64* %r36
%r38 = lshr i1600 %r34, 64
%r40 = getelementptr i64, i64* %r1, i32 7
%r41 = trunc i1600 %r38 to i64
store i64 %r41, i64* %r40
%r42 = lshr i1600 %r38, 64
%r44 = getelementptr i64, i64* %r1, i32 8
%r45 = trunc i1600 %r42 to i64
store i64 %r45, i64* %r44
%r46 = lshr i1600 %r42, 64
%r48 = getelementptr i64, i64* %r1, i32 9
%r49 = trunc i1600 %r46 to i64
store i64 %r49, i64* %r48
%r50 = lshr i1600 %r46, 64
%r52 = getelementptr i64, i64* %r1, i32 10
%r53 = trunc i1600 %r50 to i64
store i64 %r53, i64* %r52
%r54 = lshr i1600 %r50, 64
%r56 = getelementptr i64, i64* %r1, i32 11
%r57 = trunc i1600 %r54 to i64
store i64 %r57, i64* %r56
%r58 = lshr i1600 %r54, 64
%r60 = getelementptr i64, i64* %r1, i32 12
%r61 = trunc i1600 %r58 to i64
store i64 %r61, i64* %r60
%r62 = lshr i1600 %r58, 64
%r64 = getelementptr i64, i64* %r1, i32 13
%r65 = trunc i1600 %r62 to i64
store i64 %r65, i64* %r64
%r66 = lshr i1600 %r62, 64
%r68 = getelementptr i64, i64* %r1, i32 14
%r69 = trunc i1600 %r66 to i64
store i64 %r69, i64* %r68
%r70 = lshr i1600 %r66, 64
%r72 = getelementptr i64, i64* %r1, i32 15
%r73 = trunc i1600 %r70 to i64
store i64 %r73, i64* %r72
%r74 = lshr i1600 %r70, 64
%r76 = getelementptr i64, i64* %r1, i32 16
%r77 = trunc i1600 %r74 to i64
store i64 %r77, i64* %r76
%r78 = lshr i1600 %r74, 64
%r80 = getelementptr i64, i64* %r1, i32 17
%r81 = trunc i1600 %r78 to i64
store i64 %r81, i64* %r80
%r82 = lshr i1600 %r78, 64
%r84 = getelementptr i64, i64* %r1, i32 18
%r85 = trunc i1600 %r82 to i64
store i64 %r85, i64* %r84
%r86 = lshr i1600 %r82, 64
%r88 = getelementptr i64, i64* %r1, i32 19
%r89 = trunc i1600 %r86 to i64
store i64 %r89, i64* %r88
%r90 = lshr i1600 %r86, 64
%r92 = getelementptr i64, i64* %r1, i32 20
%r93 = trunc i1600 %r90 to i64
store i64 %r93, i64* %r92
%r94 = lshr i1600 %r90, 64
%r96 = getelementptr i64, i64* %r1, i32 21
%r97 = trunc i1600 %r94 to i64
store i64 %r97, i64* %r96
%r98 = lshr i1600 %r94, 64
%r100 = getelementptr i64, i64* %r1, i32 22
%r101 = trunc i1600 %r98 to i64
store i64 %r101, i64* %r100
%r102 = lshr i1600 %r98, 64
%r104 = getelementptr i64, i64* %r1, i32 23
%r105 = trunc i1600 %r102 to i64
store i64 %r105, i64* %r104
%r106 = lshr i1600 %r102, 64
%r108 = getelementptr i64, i64* %r1, i32 24
%r109 = trunc i1600 %r106 to i64
store i64 %r109, i64* %r108
ret void
}
define i64 @mclb_subNF25(i64* noalias  %r2, i64* noalias  %r3, i64* noalias  %r4)
{
%r6 = bitcast i64* %r3 to i1600*
%r7 = load i1600, i1600* %r6
%r9 = bitcast i64* %r4 to i1600*
%r10 = load i1600, i1600* %r9
%r11 = sub i1600 %r7, %r10
%r13 = getelementptr i64, i64* %r2, i32 0
%r14 = trunc i1600 %r11 to i64
store i64 %r14, i64* %r13
%r15 = lshr i1600 %r11, 64
%r17 = getelementptr i64, i64* %r2, i32 1
%r18 = trunc i1600 %r15 to i64
store i64 %r18, i64* %r17
%r19 = lshr i1600 %r15, 64
%r21 = getelementptr i64, i64* %r2, i32 2
%r22 = trunc i1600 %r19 to i64
store i64 %r22, i64* %r21
%r23 = lshr i1600 %r19, 64
%r25 = getelementptr i64, i64* %r2, i32 3
%r26 = trunc i1600 %r23 to i64
store i64 %r26, i64* %r25
%r27 = lshr i1600 %r23, 64
%r29 = getelementptr i64, i64* %r2, i32 4
%r30 = trunc i1600 %r27 to i64
store i64 %r30, i64* %r29
%r31 = lshr i1600 %r27, 64
%r33 = getelementptr i64, i64* %r2, i32 5
%r34 = trunc i1600 %r31 to i64
store i64 %r34, i64* %r33
%r35 = lshr i1600 %r31, 64
%r37 = getelementptr i64, i64* %r2, i32 6
%r38 = trunc i1600 %r35 to i64
store i64 %r38, i64* %r37
%r39 = lshr i1600 %r35, 64
%r41 = getelementptr i64, i64* %r2, i32 7
%r42 = trunc i1600 %r39 to i64
store i64 %r42, i64* %r41
%r43 = lshr i1600 %r39, 64
%r45 = getelementptr i64, i64* %r2, i32 8
%r46 = trunc i1600 %r43 to i64
store i64 %r46, i64* %r45
%r47 = lshr i1600 %r43, 64
%r49 = getelementptr i64, i64* %r2, i32 9
%r50 = trunc i1600 %r47 to i64
store i64 %r50, i64* %r49
%r51 = lshr i1600 %r47, 64
%r53 = getelementptr i64, i64* %r2, i32 10
%r54 = trunc i1600 %r51 to i64
store i64 %r54, i64* %r53
%r55 = lshr i1600 %r51, 64
%r57 = getelementptr i64, i64* %r2, i32 11
%r58 = trunc i1600 %r55 to i64
store i64 %r58, i64* %r57
%r59 = lshr i1600 %r55, 64
%r61 = getelementptr i64, i64* %r2, i32 12
%r62 = trunc i1600 %r59 to i64
store i64 %r62, i64* %r61
%r63 = lshr i1600 %r59, 64
%r65 = getelementptr i64, i64* %r2, i32 13
%r66 = trunc i1600 %r63 to i64
store i64 %r66, i64* %r65
%r67 = lshr i1600 %r63, 64
%r69 = getelementptr i64, i64* %r2, i32 14
%r70 = trunc i1600 %r67 to i64
store i64 %r70, i64* %r69
%r71 = lshr i1600 %r67, 64
%r73 = getelementptr i64, i64* %r2, i32 15
%r74 = trunc i1600 %r71 to i64
store i64 %r74, i64* %r73
%r75 = lshr i1600 %r71, 64
%r77 = getelementptr i64, i64* %r2, i32 16
%r78 = trunc i1600 %r75 to i64
store i64 %r78, i64* %r77
%r79 = lshr i1600 %r75, 64
%r81 = getelementptr i64, i64* %r2, i32 17
%r82 = trunc i1600 %r79 to i64
store i64 %r82, i64* %r81
%r83 = lshr i1600 %r79, 64
%r85 = getelementptr i64, i64* %r2, i32 18
%r86 = trunc i1600 %r83 to i64
store i64 %r86, i64* %r85
%r87 = lshr i1600 %r83, 64
%r89 = getelementptr i64, i64* %r2, i32 19
%r90 = trunc i1600 %r87 to i64
store i64 %r90, i64* %r89
%r91 = lshr i1600 %r87, 64
%r93 = getelementptr i64, i64* %r2, i32 20
%r94 = trunc i1600 %r91 to i64
store i64 %r94, i64* %r93
%r95 = lshr i1600 %r91, 64
%r97 = getelementptr i64, i64* %r2, i32 21
%r98 = trunc i1600 %r95 to i64
store i64 %r98, i64* %r97
%r99 = lshr i1600 %r95, 64
%r101 = getelementptr i64, i64* %r2, i32 22
%r102 = trunc i1600 %r99 to i64
store i64 %r102, i64* %r101
%r103 = lshr i1600 %r99, 64
%r105 = getelementptr i64, i64* %r2, i32 23
%r106 = trunc i1600 %r103 to i64
store i64 %r106, i64* %r105
%r107 = lshr i1600 %r103, 64
%r109 = getelementptr i64, i64* %r2, i32 24
%r110 = trunc i1600 %r107 to i64
store i64 %r110, i64* %r109
%r111 = lshr i1600 %r11, 1599
%r112 = trunc i1600 %r111 to i64
%r114 = and i64 %r112, 1
ret i64 %r114
}
define i64 @mclb_add26(i64* noalias  %r2, i64* noalias  %r3, i64* noalias  %r4)
{
%r6 = bitcast i64* %r3 to i1664*
%r7 = load i1664, i1664* %r6
%r8 = zext i1664 %r7 to i1728
%r10 = bitcast i64* %r4 to i1664*
%r11 = load i1664, i1664* %r10
%r12 = zext i1664 %r11 to i1728
%r13 = add i1728 %r8, %r12
%r14 = trunc i1728 %r13 to i1664
%r16 = getelementptr i64, i64* %r2, i32 0
%r17 = trunc i1664 %r14 to i64
store i64 %r17, i64* %r16
%r18 = lshr i1664 %r14, 64
%r20 = getelementptr i64, i64* %r2, i32 1
%r21 = trunc i1664 %r18 to i64
store i64 %r21, i64* %r20
%r22 = lshr i1664 %r18, 64
%r24 = getelementptr i64, i64* %r2, i32 2
%r25 = trunc i1664 %r22 to i64
store i64 %r25, i64* %r24
%r26 = lshr i1664 %r22, 64
%r28 = getelementptr i64, i64* %r2, i32 3
%r29 = trunc i1664 %r26 to i64
store i64 %r29, i64* %r28
%r30 = lshr i1664 %r26, 64
%r32 = getelementptr i64, i64* %r2, i32 4
%r33 = trunc i1664 %r30 to i64
store i64 %r33, i64* %r32
%r34 = lshr i1664 %r30, 64
%r36 = getelementptr i64, i64* %r2, i32 5
%r37 = trunc i1664 %r34 to i64
store i64 %r37, i64* %r36
%r38 = lshr i1664 %r34, 64
%r40 = getelementptr i64, i64* %r2, i32 6
%r41 = trunc i1664 %r38 to i64
store i64 %r41, i64* %r40
%r42 = lshr i1664 %r38, 64
%r44 = getelementptr i64, i64* %r2, i32 7
%r45 = trunc i1664 %r42 to i64
store i64 %r45, i64* %r44
%r46 = lshr i1664 %r42, 64
%r48 = getelementptr i64, i64* %r2, i32 8
%r49 = trunc i1664 %r46 to i64
store i64 %r49, i64* %r48
%r50 = lshr i1664 %r46, 64
%r52 = getelementptr i64, i64* %r2, i32 9
%r53 = trunc i1664 %r50 to i64
store i64 %r53, i64* %r52
%r54 = lshr i1664 %r50, 64
%r56 = getelementptr i64, i64* %r2, i32 10
%r57 = trunc i1664 %r54 to i64
store i64 %r57, i64* %r56
%r58 = lshr i1664 %r54, 64
%r60 = getelementptr i64, i64* %r2, i32 11
%r61 = trunc i1664 %r58 to i64
store i64 %r61, i64* %r60
%r62 = lshr i1664 %r58, 64
%r64 = getelementptr i64, i64* %r2, i32 12
%r65 = trunc i1664 %r62 to i64
store i64 %r65, i64* %r64
%r66 = lshr i1664 %r62, 64
%r68 = getelementptr i64, i64* %r2, i32 13
%r69 = trunc i1664 %r66 to i64
store i64 %r69, i64* %r68
%r70 = lshr i1664 %r66, 64
%r72 = getelementptr i64, i64* %r2, i32 14
%r73 = trunc i1664 %r70 to i64
store i64 %r73, i64* %r72
%r74 = lshr i1664 %r70, 64
%r76 = getelementptr i64, i64* %r2, i32 15
%r77 = trunc i1664 %r74 to i64
store i64 %r77, i64* %r76
%r78 = lshr i1664 %r74, 64
%r80 = getelementptr i64, i64* %r2, i32 16
%r81 = trunc i1664 %r78 to i64
store i64 %r81, i64* %r80
%r82 = lshr i1664 %r78, 64
%r84 = getelementptr i64, i64* %r2, i32 17
%r85 = trunc i1664 %r82 to i64
store i64 %r85, i64* %r84
%r86 = lshr i1664 %r82, 64
%r88 = getelementptr i64, i64* %r2, i32 18
%r89 = trunc i1664 %r86 to i64
store i64 %r89, i64* %r88
%r90 = lshr i1664 %r86, 64
%r92 = getelementptr i64, i64* %r2, i32 19
%r93 = trunc i1664 %r90 to i64
store i64 %r93, i64* %r92
%r94 = lshr i1664 %r90, 64
%r96 = getelementptr i64, i64* %r2, i32 20
%r97 = trunc i1664 %r94 to i64
store i64 %r97, i64* %r96
%r98 = lshr i1664 %r94, 64
%r100 = getelementptr i64, i64* %r2, i32 21
%r101 = trunc i1664 %r98 to i64
store i64 %r101, i64* %r100
%r102 = lshr i1664 %r98, 64
%r104 = getelementptr i64, i64* %r2, i32 22
%r105 = trunc i1664 %r102 to i64
store i64 %r105, i64* %r104
%r106 = lshr i1664 %r102, 64
%r108 = getelementptr i64, i64* %r2, i32 23
%r109 = trunc i1664 %r106 to i64
store i64 %r109, i64* %r108
%r110 = lshr i1664 %r106, 64
%r112 = getelementptr i64, i64* %r2, i32 24
%r113 = trunc i1664 %r110 to i64
store i64 %r113, i64* %r112
%r114 = lshr i1664 %r110, 64
%r116 = getelementptr i64, i64* %r2, i32 25
%r117 = trunc i1664 %r114 to i64
store i64 %r117, i64* %r116
%r118 = lshr i1728 %r13, 1664
%r119 = trunc i1728 %r118 to i64
ret i64 %r119
}
define i64 @mclb_sub26(i64* noalias  %r2, i64* noalias  %r3, i64* noalias  %r4)
{
%r6 = bitcast i64* %r3 to i1664*
%r7 = load i1664, i1664* %r6
%r8 = zext i1664 %r7 to i1728
%r10 = bitcast i64* %r4 to i1664*
%r11 = load i1664, i1664* %r10
%r12 = zext i1664 %r11 to i1728
%r13 = sub i1728 %r8, %r12
%r14 = trunc i1728 %r13 to i1664
%r16 = getelementptr i64, i64* %r2, i32 0
%r17 = trunc i1664 %r14 to i64
store i64 %r17, i64* %r16
%r18 = lshr i1664 %r14, 64
%r20 = getelementptr i64, i64* %r2, i32 1
%r21 = trunc i1664 %r18 to i64
store i64 %r21, i64* %r20
%r22 = lshr i1664 %r18, 64
%r24 = getelementptr i64, i64* %r2, i32 2
%r25 = trunc i1664 %r22 to i64
store i64 %r25, i64* %r24
%r26 = lshr i1664 %r22, 64
%r28 = getelementptr i64, i64* %r2, i32 3
%r29 = trunc i1664 %r26 to i64
store i64 %r29, i64* %r28
%r30 = lshr i1664 %r26, 64
%r32 = getelementptr i64, i64* %r2, i32 4
%r33 = trunc i1664 %r30 to i64
store i64 %r33, i64* %r32
%r34 = lshr i1664 %r30, 64
%r36 = getelementptr i64, i64* %r2, i32 5
%r37 = trunc i1664 %r34 to i64
store i64 %r37, i64* %r36
%r38 = lshr i1664 %r34, 64
%r40 = getelementptr i64, i64* %r2, i32 6
%r41 = trunc i1664 %r38 to i64
store i64 %r41, i64* %r40
%r42 = lshr i1664 %r38, 64
%r44 = getelementptr i64, i64* %r2, i32 7
%r45 = trunc i1664 %r42 to i64
store i64 %r45, i64* %r44
%r46 = lshr i1664 %r42, 64
%r48 = getelementptr i64, i64* %r2, i32 8
%r49 = trunc i1664 %r46 to i64
store i64 %r49, i64* %r48
%r50 = lshr i1664 %r46, 64
%r52 = getelementptr i64, i64* %r2, i32 9
%r53 = trunc i1664 %r50 to i64
store i64 %r53, i64* %r52
%r54 = lshr i1664 %r50, 64
%r56 = getelementptr i64, i64* %r2, i32 10
%r57 = trunc i1664 %r54 to i64
store i64 %r57, i64* %r56
%r58 = lshr i1664 %r54, 64
%r60 = getelementptr i64, i64* %r2, i32 11
%r61 = trunc i1664 %r58 to i64
store i64 %r61, i64* %r60
%r62 = lshr i1664 %r58, 64
%r64 = getelementptr i64, i64* %r2, i32 12
%r65 = trunc i1664 %r62 to i64
store i64 %r65, i64* %r64
%r66 = lshr i1664 %r62, 64
%r68 = getelementptr i64, i64* %r2, i32 13
%r69 = trunc i1664 %r66 to i64
store i64 %r69, i64* %r68
%r70 = lshr i1664 %r66, 64
%r72 = getelementptr i64, i64* %r2, i32 14
%r73 = trunc i1664 %r70 to i64
store i64 %r73, i64* %r72
%r74 = lshr i1664 %r70, 64
%r76 = getelementptr i64, i64* %r2, i32 15
%r77 = trunc i1664 %r74 to i64
store i64 %r77, i64* %r76
%r78 = lshr i1664 %r74, 64
%r80 = getelementptr i64, i64* %r2, i32 16
%r81 = trunc i1664 %r78 to i64
store i64 %r81, i64* %r80
%r82 = lshr i1664 %r78, 64
%r84 = getelementptr i64, i64* %r2, i32 17
%r85 = trunc i1664 %r82 to i64
store i64 %r85, i64* %r84
%r86 = lshr i1664 %r82, 64
%r88 = getelementptr i64, i64* %r2, i32 18
%r89 = trunc i1664 %r86 to i64
store i64 %r89, i64* %r88
%r90 = lshr i1664 %r86, 64
%r92 = getelementptr i64, i64* %r2, i32 19
%r93 = trunc i1664 %r90 to i64
store i64 %r93, i64* %r92
%r94 = lshr i1664 %r90, 64
%r96 = getelementptr i64, i64* %r2, i32 20
%r97 = trunc i1664 %r94 to i64
store i64 %r97, i64* %r96
%r98 = lshr i1664 %r94, 64
%r100 = getelementptr i64, i64* %r2, i32 21
%r101 = trunc i1664 %r98 to i64
store i64 %r101, i64* %r100
%r102 = lshr i1664 %r98, 64
%r104 = getelementptr i64, i64* %r2, i32 22
%r105 = trunc i1664 %r102 to i64
store i64 %r105, i64* %r104
%r106 = lshr i1664 %r102, 64
%r108 = getelementptr i64, i64* %r2, i32 23
%r109 = trunc i1664 %r106 to i64
store i64 %r109, i64* %r108
%r110 = lshr i1664 %r106, 64
%r112 = getelementptr i64, i64* %r2, i32 24
%r113 = trunc i1664 %r110 to i64
store i64 %r113, i64* %r112
%r114 = lshr i1664 %r110, 64
%r116 = getelementptr i64, i64* %r2, i32 25
%r117 = trunc i1664 %r114 to i64
store i64 %r117, i64* %r116
%r118 = lshr i1728 %r13, 1664
%r119 = trunc i1728 %r118 to i64
%r121 = and i64 %r119, 1
ret i64 %r121
}
define void @mclb_addNF26(i64* noalias  %r1, i64* noalias  %r2, i64* noalias  %r3)
{
%r5 = bitcast i64* %r2 to i1664*
%r6 = load i1664, i1664* %r5
%r8 = bitcast i64* %r3 to i1664*
%r9 = load i1664, i1664* %r8
%r10 = add i1664 %r6, %r9
%r12 = getelementptr i64, i64* %r1, i32 0
%r13 = trunc i1664 %r10 to i64
store i64 %r13, i64* %r12
%r14 = lshr i1664 %r10, 64
%r16 = getelementptr i64, i64* %r1, i32 1
%r17 = trunc i1664 %r14 to i64
store i64 %r17, i64* %r16
%r18 = lshr i1664 %r14, 64
%r20 = getelementptr i64, i64* %r1, i32 2
%r21 = trunc i1664 %r18 to i64
store i64 %r21, i64* %r20
%r22 = lshr i1664 %r18, 64
%r24 = getelementptr i64, i64* %r1, i32 3
%r25 = trunc i1664 %r22 to i64
store i64 %r25, i64* %r24
%r26 = lshr i1664 %r22, 64
%r28 = getelementptr i64, i64* %r1, i32 4
%r29 = trunc i1664 %r26 to i64
store i64 %r29, i64* %r28
%r30 = lshr i1664 %r26, 64
%r32 = getelementptr i64, i64* %r1, i32 5
%r33 = trunc i1664 %r30 to i64
store i64 %r33, i64* %r32
%r34 = lshr i1664 %r30, 64
%r36 = getelementptr i64, i64* %r1, i32 6
%r37 = trunc i1664 %r34 to i64
store i64 %r37, i64* %r36
%r38 = lshr i1664 %r34, 64
%r40 = getelementptr i64, i64* %r1, i32 7
%r41 = trunc i1664 %r38 to i64
store i64 %r41, i64* %r40
%r42 = lshr i1664 %r38, 64
%r44 = getelementptr i64, i64* %r1, i32 8
%r45 = trunc i1664 %r42 to i64
store i64 %r45, i64* %r44
%r46 = lshr i1664 %r42, 64
%r48 = getelementptr i64, i64* %r1, i32 9
%r49 = trunc i1664 %r46 to i64
store i64 %r49, i64* %r48
%r50 = lshr i1664 %r46, 64
%r52 = getelementptr i64, i64* %r1, i32 10
%r53 = trunc i1664 %r50 to i64
store i64 %r53, i64* %r52
%r54 = lshr i1664 %r50, 64
%r56 = getelementptr i64, i64* %r1, i32 11
%r57 = trunc i1664 %r54 to i64
store i64 %r57, i64* %r56
%r58 = lshr i1664 %r54, 64
%r60 = getelementptr i64, i64* %r1, i32 12
%r61 = trunc i1664 %r58 to i64
store i64 %r61, i64* %r60
%r62 = lshr i1664 %r58, 64
%r64 = getelementptr i64, i64* %r1, i32 13
%r65 = trunc i1664 %r62 to i64
store i64 %r65, i64* %r64
%r66 = lshr i1664 %r62, 64
%r68 = getelementptr i64, i64* %r1, i32 14
%r69 = trunc i1664 %r66 to i64
store i64 %r69, i64* %r68
%r70 = lshr i1664 %r66, 64
%r72 = getelementptr i64, i64* %r1, i32 15
%r73 = trunc i1664 %r70 to i64
store i64 %r73, i64* %r72
%r74 = lshr i1664 %r70, 64
%r76 = getelementptr i64, i64* %r1, i32 16
%r77 = trunc i1664 %r74 to i64
store i64 %r77, i64* %r76
%r78 = lshr i1664 %r74, 64
%r80 = getelementptr i64, i64* %r1, i32 17
%r81 = trunc i1664 %r78 to i64
store i64 %r81, i64* %r80
%r82 = lshr i1664 %r78, 64
%r84 = getelementptr i64, i64* %r1, i32 18
%r85 = trunc i1664 %r82 to i64
store i64 %r85, i64* %r84
%r86 = lshr i1664 %r82, 64
%r88 = getelementptr i64, i64* %r1, i32 19
%r89 = trunc i1664 %r86 to i64
store i64 %r89, i64* %r88
%r90 = lshr i1664 %r86, 64
%r92 = getelementptr i64, i64* %r1, i32 20
%r93 = trunc i1664 %r90 to i64
store i64 %r93, i64* %r92
%r94 = lshr i1664 %r90, 64
%r96 = getelementptr i64, i64* %r1, i32 21
%r97 = trunc i1664 %r94 to i64
store i64 %r97, i64* %r96
%r98 = lshr i1664 %r94, 64
%r100 = getelementptr i64, i64* %r1, i32 22
%r101 = trunc i1664 %r98 to i64
store i64 %r101, i64* %r100
%r102 = lshr i1664 %r98, 64
%r104 = getelementptr i64, i64* %r1, i32 23
%r105 = trunc i1664 %r102 to i64
store i64 %r105, i64* %r104
%r106 = lshr i1664 %r102, 64
%r108 = getelementptr i64, i64* %r1, i32 24
%r109 = trunc i1664 %r106 to i64
store i64 %r109, i64* %r108
%r110 = lshr i1664 %r106, 64
%r112 = getelementptr i64, i64* %r1, i32 25
%r113 = trunc i1664 %r110 to i64
store i64 %r113, i64* %r112
ret void
}
define i64 @mclb_subNF26(i64* noalias  %r2, i64* noalias  %r3, i64* noalias  %r4)
{
%r6 = bitcast i64* %r3 to i1664*
%r7 = load i1664, i1664* %r6
%r9 = bitcast i64* %r4 to i1664*
%r10 = load i1664, i1664* %r9
%r11 = sub i1664 %r7, %r10
%r13 = getelementptr i64, i64* %r2, i32 0
%r14 = trunc i1664 %r11 to i64
store i64 %r14, i64* %r13
%r15 = lshr i1664 %r11, 64
%r17 = getelementptr i64, i64* %r2, i32 1
%r18 = trunc i1664 %r15 to i64
store i64 %r18, i64* %r17
%r19 = lshr i1664 %r15, 64
%r21 = getelementptr i64, i64* %r2, i32 2
%r22 = trunc i1664 %r19 to i64
store i64 %r22, i64* %r21
%r23 = lshr i1664 %r19, 64
%r25 = getelementptr i64, i64* %r2, i32 3
%r26 = trunc i1664 %r23 to i64
store i64 %r26, i64* %r25
%r27 = lshr i1664 %r23, 64
%r29 = getelementptr i64, i64* %r2, i32 4
%r30 = trunc i1664 %r27 to i64
store i64 %r30, i64* %r29
%r31 = lshr i1664 %r27, 64
%r33 = getelementptr i64, i64* %r2, i32 5
%r34 = trunc i1664 %r31 to i64
store i64 %r34, i64* %r33
%r35 = lshr i1664 %r31, 64
%r37 = getelementptr i64, i64* %r2, i32 6
%r38 = trunc i1664 %r35 to i64
store i64 %r38, i64* %r37
%r39 = lshr i1664 %r35, 64
%r41 = getelementptr i64, i64* %r2, i32 7
%r42 = trunc i1664 %r39 to i64
store i64 %r42, i64* %r41
%r43 = lshr i1664 %r39, 64
%r45 = getelementptr i64, i64* %r2, i32 8
%r46 = trunc i1664 %r43 to i64
store i64 %r46, i64* %r45
%r47 = lshr i1664 %r43, 64
%r49 = getelementptr i64, i64* %r2, i32 9
%r50 = trunc i1664 %r47 to i64
store i64 %r50, i64* %r49
%r51 = lshr i1664 %r47, 64
%r53 = getelementptr i64, i64* %r2, i32 10
%r54 = trunc i1664 %r51 to i64
store i64 %r54, i64* %r53
%r55 = lshr i1664 %r51, 64
%r57 = getelementptr i64, i64* %r2, i32 11
%r58 = trunc i1664 %r55 to i64
store i64 %r58, i64* %r57
%r59 = lshr i1664 %r55, 64
%r61 = getelementptr i64, i64* %r2, i32 12
%r62 = trunc i1664 %r59 to i64
store i64 %r62, i64* %r61
%r63 = lshr i1664 %r59, 64
%r65 = getelementptr i64, i64* %r2, i32 13
%r66 = trunc i1664 %r63 to i64
store i64 %r66, i64* %r65
%r67 = lshr i1664 %r63, 64
%r69 = getelementptr i64, i64* %r2, i32 14
%r70 = trunc i1664 %r67 to i64
store i64 %r70, i64* %r69
%r71 = lshr i1664 %r67, 64
%r73 = getelementptr i64, i64* %r2, i32 15
%r74 = trunc i1664 %r71 to i64
store i64 %r74, i64* %r73
%r75 = lshr i1664 %r71, 64
%r77 = getelementptr i64, i64* %r2, i32 16
%r78 = trunc i1664 %r75 to i64
store i64 %r78, i64* %r77
%r79 = lshr i1664 %r75, 64
%r81 = getelementptr i64, i64* %r2, i32 17
%r82 = trunc i1664 %r79 to i64
store i64 %r82, i64* %r81
%r83 = lshr i1664 %r79, 64
%r85 = getelementptr i64, i64* %r2, i32 18
%r86 = trunc i1664 %r83 to i64
store i64 %r86, i64* %r85
%r87 = lshr i1664 %r83, 64
%r89 = getelementptr i64, i64* %r2, i32 19
%r90 = trunc i1664 %r87 to i64
store i64 %r90, i64* %r89
%r91 = lshr i1664 %r87, 64
%r93 = getelementptr i64, i64* %r2, i32 20
%r94 = trunc i1664 %r91 to i64
store i64 %r94, i64* %r93
%r95 = lshr i1664 %r91, 64
%r97 = getelementptr i64, i64* %r2, i32 21
%r98 = trunc i1664 %r95 to i64
store i64 %r98, i64* %r97
%r99 = lshr i1664 %r95, 64
%r101 = getelementptr i64, i64* %r2, i32 22
%r102 = trunc i1664 %r99 to i64
store i64 %r102, i64* %r101
%r103 = lshr i1664 %r99, 64
%r105 = getelementptr i64, i64* %r2, i32 23
%r106 = trunc i1664 %r103 to i64
store i64 %r106, i64* %r105
%r107 = lshr i1664 %r103, 64
%r109 = getelementptr i64, i64* %r2, i32 24
%r110 = trunc i1664 %r107 to i64
store i64 %r110, i64* %r109
%r111 = lshr i1664 %r107, 64
%r113 = getelementptr i64, i64* %r2, i32 25
%r114 = trunc i1664 %r111 to i64
store i64 %r114, i64* %r113
%r115 = lshr i1664 %r11, 1663
%r116 = trunc i1664 %r115 to i64
%r118 = and i64 %r116, 1
ret i64 %r118
}
define i64 @mclb_add27(i64* noalias  %r2, i64* noalias  %r3, i64* noalias  %r4)
{
%r6 = bitcast i64* %r3 to i1728*
%r7 = load i1728, i1728* %r6
%r8 = zext i1728 %r7 to i1792
%r10 = bitcast i64* %r4 to i1728*
%r11 = load i1728, i1728* %r10
%r12 = zext i1728 %r11 to i1792
%r13 = add i1792 %r8, %r12
%r14 = trunc i1792 %r13 to i1728
%r16 = getelementptr i64, i64* %r2, i32 0
%r17 = trunc i1728 %r14 to i64
store i64 %r17, i64* %r16
%r18 = lshr i1728 %r14, 64
%r20 = getelementptr i64, i64* %r2, i32 1
%r21 = trunc i1728 %r18 to i64
store i64 %r21, i64* %r20
%r22 = lshr i1728 %r18, 64
%r24 = getelementptr i64, i64* %r2, i32 2
%r25 = trunc i1728 %r22 to i64
store i64 %r25, i64* %r24
%r26 = lshr i1728 %r22, 64
%r28 = getelementptr i64, i64* %r2, i32 3
%r29 = trunc i1728 %r26 to i64
store i64 %r29, i64* %r28
%r30 = lshr i1728 %r26, 64
%r32 = getelementptr i64, i64* %r2, i32 4
%r33 = trunc i1728 %r30 to i64
store i64 %r33, i64* %r32
%r34 = lshr i1728 %r30, 64
%r36 = getelementptr i64, i64* %r2, i32 5
%r37 = trunc i1728 %r34 to i64
store i64 %r37, i64* %r36
%r38 = lshr i1728 %r34, 64
%r40 = getelementptr i64, i64* %r2, i32 6
%r41 = trunc i1728 %r38 to i64
store i64 %r41, i64* %r40
%r42 = lshr i1728 %r38, 64
%r44 = getelementptr i64, i64* %r2, i32 7
%r45 = trunc i1728 %r42 to i64
store i64 %r45, i64* %r44
%r46 = lshr i1728 %r42, 64
%r48 = getelementptr i64, i64* %r2, i32 8
%r49 = trunc i1728 %r46 to i64
store i64 %r49, i64* %r48
%r50 = lshr i1728 %r46, 64
%r52 = getelementptr i64, i64* %r2, i32 9
%r53 = trunc i1728 %r50 to i64
store i64 %r53, i64* %r52
%r54 = lshr i1728 %r50, 64
%r56 = getelementptr i64, i64* %r2, i32 10
%r57 = trunc i1728 %r54 to i64
store i64 %r57, i64* %r56
%r58 = lshr i1728 %r54, 64
%r60 = getelementptr i64, i64* %r2, i32 11
%r61 = trunc i1728 %r58 to i64
store i64 %r61, i64* %r60
%r62 = lshr i1728 %r58, 64
%r64 = getelementptr i64, i64* %r2, i32 12
%r65 = trunc i1728 %r62 to i64
store i64 %r65, i64* %r64
%r66 = lshr i1728 %r62, 64
%r68 = getelementptr i64, i64* %r2, i32 13
%r69 = trunc i1728 %r66 to i64
store i64 %r69, i64* %r68
%r70 = lshr i1728 %r66, 64
%r72 = getelementptr i64, i64* %r2, i32 14
%r73 = trunc i1728 %r70 to i64
store i64 %r73, i64* %r72
%r74 = lshr i1728 %r70, 64
%r76 = getelementptr i64, i64* %r2, i32 15
%r77 = trunc i1728 %r74 to i64
store i64 %r77, i64* %r76
%r78 = lshr i1728 %r74, 64
%r80 = getelementptr i64, i64* %r2, i32 16
%r81 = trunc i1728 %r78 to i64
store i64 %r81, i64* %r80
%r82 = lshr i1728 %r78, 64
%r84 = getelementptr i64, i64* %r2, i32 17
%r85 = trunc i1728 %r82 to i64
store i64 %r85, i64* %r84
%r86 = lshr i1728 %r82, 64
%r88 = getelementptr i64, i64* %r2, i32 18
%r89 = trunc i1728 %r86 to i64
store i64 %r89, i64* %r88
%r90 = lshr i1728 %r86, 64
%r92 = getelementptr i64, i64* %r2, i32 19
%r93 = trunc i1728 %r90 to i64
store i64 %r93, i64* %r92
%r94 = lshr i1728 %r90, 64
%r96 = getelementptr i64, i64* %r2, i32 20
%r97 = trunc i1728 %r94 to i64
store i64 %r97, i64* %r96
%r98 = lshr i1728 %r94, 64
%r100 = getelementptr i64, i64* %r2, i32 21
%r101 = trunc i1728 %r98 to i64
store i64 %r101, i64* %r100
%r102 = lshr i1728 %r98, 64
%r104 = getelementptr i64, i64* %r2, i32 22
%r105 = trunc i1728 %r102 to i64
store i64 %r105, i64* %r104
%r106 = lshr i1728 %r102, 64
%r108 = getelementptr i64, i64* %r2, i32 23
%r109 = trunc i1728 %r106 to i64
store i64 %r109, i64* %r108
%r110 = lshr i1728 %r106, 64
%r112 = getelementptr i64, i64* %r2, i32 24
%r113 = trunc i1728 %r110 to i64
store i64 %r113, i64* %r112
%r114 = lshr i1728 %r110, 64
%r116 = getelementptr i64, i64* %r2, i32 25
%r117 = trunc i1728 %r114 to i64
store i64 %r117, i64* %r116
%r118 = lshr i1728 %r114, 64
%r120 = getelementptr i64, i64* %r2, i32 26
%r121 = trunc i1728 %r118 to i64
store i64 %r121, i64* %r120
%r122 = lshr i1792 %r13, 1728
%r123 = trunc i1792 %r122 to i64
ret i64 %r123
}
define i64 @mclb_sub27(i64* noalias  %r2, i64* noalias  %r3, i64* noalias  %r4)
{
%r6 = bitcast i64* %r3 to i1728*
%r7 = load i1728, i1728* %r6
%r8 = zext i1728 %r7 to i1792
%r10 = bitcast i64* %r4 to i1728*
%r11 = load i1728, i1728* %r10
%r12 = zext i1728 %r11 to i1792
%r13 = sub i1792 %r8, %r12
%r14 = trunc i1792 %r13 to i1728
%r16 = getelementptr i64, i64* %r2, i32 0
%r17 = trunc i1728 %r14 to i64
store i64 %r17, i64* %r16
%r18 = lshr i1728 %r14, 64
%r20 = getelementptr i64, i64* %r2, i32 1
%r21 = trunc i1728 %r18 to i64
store i64 %r21, i64* %r20
%r22 = lshr i1728 %r18, 64
%r24 = getelementptr i64, i64* %r2, i32 2
%r25 = trunc i1728 %r22 to i64
store i64 %r25, i64* %r24
%r26 = lshr i1728 %r22, 64
%r28 = getelementptr i64, i64* %r2, i32 3
%r29 = trunc i1728 %r26 to i64
store i64 %r29, i64* %r28
%r30 = lshr i1728 %r26, 64
%r32 = getelementptr i64, i64* %r2, i32 4
%r33 = trunc i1728 %r30 to i64
store i64 %r33, i64* %r32
%r34 = lshr i1728 %r30, 64
%r36 = getelementptr i64, i64* %r2, i32 5
%r37 = trunc i1728 %r34 to i64
store i64 %r37, i64* %r36
%r38 = lshr i1728 %r34, 64
%r40 = getelementptr i64, i64* %r2, i32 6
%r41 = trunc i1728 %r38 to i64
store i64 %r41, i64* %r40
%r42 = lshr i1728 %r38, 64
%r44 = getelementptr i64, i64* %r2, i32 7
%r45 = trunc i1728 %r42 to i64
store i64 %r45, i64* %r44
%r46 = lshr i1728 %r42, 64
%r48 = getelementptr i64, i64* %r2, i32 8
%r49 = trunc i1728 %r46 to i64
store i64 %r49, i64* %r48
%r50 = lshr i1728 %r46, 64
%r52 = getelementptr i64, i64* %r2, i32 9
%r53 = trunc i1728 %r50 to i64
store i64 %r53, i64* %r52
%r54 = lshr i1728 %r50, 64
%r56 = getelementptr i64, i64* %r2, i32 10
%r57 = trunc i1728 %r54 to i64
store i64 %r57, i64* %r56
%r58 = lshr i1728 %r54, 64
%r60 = getelementptr i64, i64* %r2, i32 11
%r61 = trunc i1728 %r58 to i64
store i64 %r61, i64* %r60
%r62 = lshr i1728 %r58, 64
%r64 = getelementptr i64, i64* %r2, i32 12
%r65 = trunc i1728 %r62 to i64
store i64 %r65, i64* %r64
%r66 = lshr i1728 %r62, 64
%r68 = getelementptr i64, i64* %r2, i32 13
%r69 = trunc i1728 %r66 to i64
store i64 %r69, i64* %r68
%r70 = lshr i1728 %r66, 64
%r72 = getelementptr i64, i64* %r2, i32 14
%r73 = trunc i1728 %r70 to i64
store i64 %r73, i64* %r72
%r74 = lshr i1728 %r70, 64
%r76 = getelementptr i64, i64* %r2, i32 15
%r77 = trunc i1728 %r74 to i64
store i64 %r77, i64* %r76
%r78 = lshr i1728 %r74, 64
%r80 = getelementptr i64, i64* %r2, i32 16
%r81 = trunc i1728 %r78 to i64
store i64 %r81, i64* %r80
%r82 = lshr i1728 %r78, 64
%r84 = getelementptr i64, i64* %r2, i32 17
%r85 = trunc i1728 %r82 to i64
store i64 %r85, i64* %r84
%r86 = lshr i1728 %r82, 64
%r88 = getelementptr i64, i64* %r2, i32 18
%r89 = trunc i1728 %r86 to i64
store i64 %r89, i64* %r88
%r90 = lshr i1728 %r86, 64
%r92 = getelementptr i64, i64* %r2, i32 19
%r93 = trunc i1728 %r90 to i64
store i64 %r93, i64* %r92
%r94 = lshr i1728 %r90, 64
%r96 = getelementptr i64, i64* %r2, i32 20
%r97 = trunc i1728 %r94 to i64
store i64 %r97, i64* %r96
%r98 = lshr i1728 %r94, 64
%r100 = getelementptr i64, i64* %r2, i32 21
%r101 = trunc i1728 %r98 to i64
store i64 %r101, i64* %r100
%r102 = lshr i1728 %r98, 64
%r104 = getelementptr i64, i64* %r2, i32 22
%r105 = trunc i1728 %r102 to i64
store i64 %r105, i64* %r104
%r106 = lshr i1728 %r102, 64
%r108 = getelementptr i64, i64* %r2, i32 23
%r109 = trunc i1728 %r106 to i64
store i64 %r109, i64* %r108
%r110 = lshr i1728 %r106, 64
%r112 = getelementptr i64, i64* %r2, i32 24
%r113 = trunc i1728 %r110 to i64
store i64 %r113, i64* %r112
%r114 = lshr i1728 %r110, 64
%r116 = getelementptr i64, i64* %r2, i32 25
%r117 = trunc i1728 %r114 to i64
store i64 %r117, i64* %r116
%r118 = lshr i1728 %r114, 64
%r120 = getelementptr i64, i64* %r2, i32 26
%r121 = trunc i1728 %r118 to i64
store i64 %r121, i64* %r120
%r122 = lshr i1792 %r13, 1728
%r123 = trunc i1792 %r122 to i64
%r125 = and i64 %r123, 1
ret i64 %r125
}
define void @mclb_addNF27(i64* noalias  %r1, i64* noalias  %r2, i64* noalias  %r3)
{
%r5 = bitcast i64* %r2 to i1728*
%r6 = load i1728, i1728* %r5
%r8 = bitcast i64* %r3 to i1728*
%r9 = load i1728, i1728* %r8
%r10 = add i1728 %r6, %r9
%r12 = getelementptr i64, i64* %r1, i32 0
%r13 = trunc i1728 %r10 to i64
store i64 %r13, i64* %r12
%r14 = lshr i1728 %r10, 64
%r16 = getelementptr i64, i64* %r1, i32 1
%r17 = trunc i1728 %r14 to i64
store i64 %r17, i64* %r16
%r18 = lshr i1728 %r14, 64
%r20 = getelementptr i64, i64* %r1, i32 2
%r21 = trunc i1728 %r18 to i64
store i64 %r21, i64* %r20
%r22 = lshr i1728 %r18, 64
%r24 = getelementptr i64, i64* %r1, i32 3
%r25 = trunc i1728 %r22 to i64
store i64 %r25, i64* %r24
%r26 = lshr i1728 %r22, 64
%r28 = getelementptr i64, i64* %r1, i32 4
%r29 = trunc i1728 %r26 to i64
store i64 %r29, i64* %r28
%r30 = lshr i1728 %r26, 64
%r32 = getelementptr i64, i64* %r1, i32 5
%r33 = trunc i1728 %r30 to i64
store i64 %r33, i64* %r32
%r34 = lshr i1728 %r30, 64
%r36 = getelementptr i64, i64* %r1, i32 6
%r37 = trunc i1728 %r34 to i64
store i64 %r37, i64* %r36
%r38 = lshr i1728 %r34, 64
%r40 = getelementptr i64, i64* %r1, i32 7
%r41 = trunc i1728 %r38 to i64
store i64 %r41, i64* %r40
%r42 = lshr i1728 %r38, 64
%r44 = getelementptr i64, i64* %r1, i32 8
%r45 = trunc i1728 %r42 to i64
store i64 %r45, i64* %r44
%r46 = lshr i1728 %r42, 64
%r48 = getelementptr i64, i64* %r1, i32 9
%r49 = trunc i1728 %r46 to i64
store i64 %r49, i64* %r48
%r50 = lshr i1728 %r46, 64
%r52 = getelementptr i64, i64* %r1, i32 10
%r53 = trunc i1728 %r50 to i64
store i64 %r53, i64* %r52
%r54 = lshr i1728 %r50, 64
%r56 = getelementptr i64, i64* %r1, i32 11
%r57 = trunc i1728 %r54 to i64
store i64 %r57, i64* %r56
%r58 = lshr i1728 %r54, 64
%r60 = getelementptr i64, i64* %r1, i32 12
%r61 = trunc i1728 %r58 to i64
store i64 %r61, i64* %r60
%r62 = lshr i1728 %r58, 64
%r64 = getelementptr i64, i64* %r1, i32 13
%r65 = trunc i1728 %r62 to i64
store i64 %r65, i64* %r64
%r66 = lshr i1728 %r62, 64
%r68 = getelementptr i64, i64* %r1, i32 14
%r69 = trunc i1728 %r66 to i64
store i64 %r69, i64* %r68
%r70 = lshr i1728 %r66, 64
%r72 = getelementptr i64, i64* %r1, i32 15
%r73 = trunc i1728 %r70 to i64
store i64 %r73, i64* %r72
%r74 = lshr i1728 %r70, 64
%r76 = getelementptr i64, i64* %r1, i32 16
%r77 = trunc i1728 %r74 to i64
store i64 %r77, i64* %r76
%r78 = lshr i1728 %r74, 64
%r80 = getelementptr i64, i64* %r1, i32 17
%r81 = trunc i1728 %r78 to i64
store i64 %r81, i64* %r80
%r82 = lshr i1728 %r78, 64
%r84 = getelementptr i64, i64* %r1, i32 18
%r85 = trunc i1728 %r82 to i64
store i64 %r85, i64* %r84
%r86 = lshr i1728 %r82, 64
%r88 = getelementptr i64, i64* %r1, i32 19
%r89 = trunc i1728 %r86 to i64
store i64 %r89, i64* %r88
%r90 = lshr i1728 %r86, 64
%r92 = getelementptr i64, i64* %r1, i32 20
%r93 = trunc i1728 %r90 to i64
store i64 %r93, i64* %r92
%r94 = lshr i1728 %r90, 64
%r96 = getelementptr i64, i64* %r1, i32 21
%r97 = trunc i1728 %r94 to i64
store i64 %r97, i64* %r96
%r98 = lshr i1728 %r94, 64
%r100 = getelementptr i64, i64* %r1, i32 22
%r101 = trunc i1728 %r98 to i64
store i64 %r101, i64* %r100
%r102 = lshr i1728 %r98, 64
%r104 = getelementptr i64, i64* %r1, i32 23
%r105 = trunc i1728 %r102 to i64
store i64 %r105, i64* %r104
%r106 = lshr i1728 %r102, 64
%r108 = getelementptr i64, i64* %r1, i32 24
%r109 = trunc i1728 %r106 to i64
store i64 %r109, i64* %r108
%r110 = lshr i1728 %r106, 64
%r112 = getelementptr i64, i64* %r1, i32 25
%r113 = trunc i1728 %r110 to i64
store i64 %r113, i64* %r112
%r114 = lshr i1728 %r110, 64
%r116 = getelementptr i64, i64* %r1, i32 26
%r117 = trunc i1728 %r114 to i64
store i64 %r117, i64* %r116
ret void
}
define i64 @mclb_subNF27(i64* noalias  %r2, i64* noalias  %r3, i64* noalias  %r4)
{
%r6 = bitcast i64* %r3 to i1728*
%r7 = load i1728, i1728* %r6
%r9 = bitcast i64* %r4 to i1728*
%r10 = load i1728, i1728* %r9
%r11 = sub i1728 %r7, %r10
%r13 = getelementptr i64, i64* %r2, i32 0
%r14 = trunc i1728 %r11 to i64
store i64 %r14, i64* %r13
%r15 = lshr i1728 %r11, 64
%r17 = getelementptr i64, i64* %r2, i32 1
%r18 = trunc i1728 %r15 to i64
store i64 %r18, i64* %r17
%r19 = lshr i1728 %r15, 64
%r21 = getelementptr i64, i64* %r2, i32 2
%r22 = trunc i1728 %r19 to i64
store i64 %r22, i64* %r21
%r23 = lshr i1728 %r19, 64
%r25 = getelementptr i64, i64* %r2, i32 3
%r26 = trunc i1728 %r23 to i64
store i64 %r26, i64* %r25
%r27 = lshr i1728 %r23, 64
%r29 = getelementptr i64, i64* %r2, i32 4
%r30 = trunc i1728 %r27 to i64
store i64 %r30, i64* %r29
%r31 = lshr i1728 %r27, 64
%r33 = getelementptr i64, i64* %r2, i32 5
%r34 = trunc i1728 %r31 to i64
store i64 %r34, i64* %r33
%r35 = lshr i1728 %r31, 64
%r37 = getelementptr i64, i64* %r2, i32 6
%r38 = trunc i1728 %r35 to i64
store i64 %r38, i64* %r37
%r39 = lshr i1728 %r35, 64
%r41 = getelementptr i64, i64* %r2, i32 7
%r42 = trunc i1728 %r39 to i64
store i64 %r42, i64* %r41
%r43 = lshr i1728 %r39, 64
%r45 = getelementptr i64, i64* %r2, i32 8
%r46 = trunc i1728 %r43 to i64
store i64 %r46, i64* %r45
%r47 = lshr i1728 %r43, 64
%r49 = getelementptr i64, i64* %r2, i32 9
%r50 = trunc i1728 %r47 to i64
store i64 %r50, i64* %r49
%r51 = lshr i1728 %r47, 64
%r53 = getelementptr i64, i64* %r2, i32 10
%r54 = trunc i1728 %r51 to i64
store i64 %r54, i64* %r53
%r55 = lshr i1728 %r51, 64
%r57 = getelementptr i64, i64* %r2, i32 11
%r58 = trunc i1728 %r55 to i64
store i64 %r58, i64* %r57
%r59 = lshr i1728 %r55, 64
%r61 = getelementptr i64, i64* %r2, i32 12
%r62 = trunc i1728 %r59 to i64
store i64 %r62, i64* %r61
%r63 = lshr i1728 %r59, 64
%r65 = getelementptr i64, i64* %r2, i32 13
%r66 = trunc i1728 %r63 to i64
store i64 %r66, i64* %r65
%r67 = lshr i1728 %r63, 64
%r69 = getelementptr i64, i64* %r2, i32 14
%r70 = trunc i1728 %r67 to i64
store i64 %r70, i64* %r69
%r71 = lshr i1728 %r67, 64
%r73 = getelementptr i64, i64* %r2, i32 15
%r74 = trunc i1728 %r71 to i64
store i64 %r74, i64* %r73
%r75 = lshr i1728 %r71, 64
%r77 = getelementptr i64, i64* %r2, i32 16
%r78 = trunc i1728 %r75 to i64
store i64 %r78, i64* %r77
%r79 = lshr i1728 %r75, 64
%r81 = getelementptr i64, i64* %r2, i32 17
%r82 = trunc i1728 %r79 to i64
store i64 %r82, i64* %r81
%r83 = lshr i1728 %r79, 64
%r85 = getelementptr i64, i64* %r2, i32 18
%r86 = trunc i1728 %r83 to i64
store i64 %r86, i64* %r85
%r87 = lshr i1728 %r83, 64
%r89 = getelementptr i64, i64* %r2, i32 19
%r90 = trunc i1728 %r87 to i64
store i64 %r90, i64* %r89
%r91 = lshr i1728 %r87, 64
%r93 = getelementptr i64, i64* %r2, i32 20
%r94 = trunc i1728 %r91 to i64
store i64 %r94, i64* %r93
%r95 = lshr i1728 %r91, 64
%r97 = getelementptr i64, i64* %r2, i32 21
%r98 = trunc i1728 %r95 to i64
store i64 %r98, i64* %r97
%r99 = lshr i1728 %r95, 64
%r101 = getelementptr i64, i64* %r2, i32 22
%r102 = trunc i1728 %r99 to i64
store i64 %r102, i64* %r101
%r103 = lshr i1728 %r99, 64
%r105 = getelementptr i64, i64* %r2, i32 23
%r106 = trunc i1728 %r103 to i64
store i64 %r106, i64* %r105
%r107 = lshr i1728 %r103, 64
%r109 = getelementptr i64, i64* %r2, i32 24
%r110 = trunc i1728 %r107 to i64
store i64 %r110, i64* %r109
%r111 = lshr i1728 %r107, 64
%r113 = getelementptr i64, i64* %r2, i32 25
%r114 = trunc i1728 %r111 to i64
store i64 %r114, i64* %r113
%r115 = lshr i1728 %r111, 64
%r117 = getelementptr i64, i64* %r2, i32 26
%r118 = trunc i1728 %r115 to i64
store i64 %r118, i64* %r117
%r119 = lshr i1728 %r11, 1727
%r120 = trunc i1728 %r119 to i64
%r122 = and i64 %r120, 1
ret i64 %r122
}
define i64 @mclb_add28(i64* noalias  %r2, i64* noalias  %r3, i64* noalias  %r4)
{
%r6 = bitcast i64* %r3 to i1792*
%r7 = load i1792, i1792* %r6
%r8 = zext i1792 %r7 to i1856
%r10 = bitcast i64* %r4 to i1792*
%r11 = load i1792, i1792* %r10
%r12 = zext i1792 %r11 to i1856
%r13 = add i1856 %r8, %r12
%r14 = trunc i1856 %r13 to i1792
%r16 = getelementptr i64, i64* %r2, i32 0
%r17 = trunc i1792 %r14 to i64
store i64 %r17, i64* %r16
%r18 = lshr i1792 %r14, 64
%r20 = getelementptr i64, i64* %r2, i32 1
%r21 = trunc i1792 %r18 to i64
store i64 %r21, i64* %r20
%r22 = lshr i1792 %r18, 64
%r24 = getelementptr i64, i64* %r2, i32 2
%r25 = trunc i1792 %r22 to i64
store i64 %r25, i64* %r24
%r26 = lshr i1792 %r22, 64
%r28 = getelementptr i64, i64* %r2, i32 3
%r29 = trunc i1792 %r26 to i64
store i64 %r29, i64* %r28
%r30 = lshr i1792 %r26, 64
%r32 = getelementptr i64, i64* %r2, i32 4
%r33 = trunc i1792 %r30 to i64
store i64 %r33, i64* %r32
%r34 = lshr i1792 %r30, 64
%r36 = getelementptr i64, i64* %r2, i32 5
%r37 = trunc i1792 %r34 to i64
store i64 %r37, i64* %r36
%r38 = lshr i1792 %r34, 64
%r40 = getelementptr i64, i64* %r2, i32 6
%r41 = trunc i1792 %r38 to i64
store i64 %r41, i64* %r40
%r42 = lshr i1792 %r38, 64
%r44 = getelementptr i64, i64* %r2, i32 7
%r45 = trunc i1792 %r42 to i64
store i64 %r45, i64* %r44
%r46 = lshr i1792 %r42, 64
%r48 = getelementptr i64, i64* %r2, i32 8
%r49 = trunc i1792 %r46 to i64
store i64 %r49, i64* %r48
%r50 = lshr i1792 %r46, 64
%r52 = getelementptr i64, i64* %r2, i32 9
%r53 = trunc i1792 %r50 to i64
store i64 %r53, i64* %r52
%r54 = lshr i1792 %r50, 64
%r56 = getelementptr i64, i64* %r2, i32 10
%r57 = trunc i1792 %r54 to i64
store i64 %r57, i64* %r56
%r58 = lshr i1792 %r54, 64
%r60 = getelementptr i64, i64* %r2, i32 11
%r61 = trunc i1792 %r58 to i64
store i64 %r61, i64* %r60
%r62 = lshr i1792 %r58, 64
%r64 = getelementptr i64, i64* %r2, i32 12
%r65 = trunc i1792 %r62 to i64
store i64 %r65, i64* %r64
%r66 = lshr i1792 %r62, 64
%r68 = getelementptr i64, i64* %r2, i32 13
%r69 = trunc i1792 %r66 to i64
store i64 %r69, i64* %r68
%r70 = lshr i1792 %r66, 64
%r72 = getelementptr i64, i64* %r2, i32 14
%r73 = trunc i1792 %r70 to i64
store i64 %r73, i64* %r72
%r74 = lshr i1792 %r70, 64
%r76 = getelementptr i64, i64* %r2, i32 15
%r77 = trunc i1792 %r74 to i64
store i64 %r77, i64* %r76
%r78 = lshr i1792 %r74, 64
%r80 = getelementptr i64, i64* %r2, i32 16
%r81 = trunc i1792 %r78 to i64
store i64 %r81, i64* %r80
%r82 = lshr i1792 %r78, 64
%r84 = getelementptr i64, i64* %r2, i32 17
%r85 = trunc i1792 %r82 to i64
store i64 %r85, i64* %r84
%r86 = lshr i1792 %r82, 64
%r88 = getelementptr i64, i64* %r2, i32 18
%r89 = trunc i1792 %r86 to i64
store i64 %r89, i64* %r88
%r90 = lshr i1792 %r86, 64
%r92 = getelementptr i64, i64* %r2, i32 19
%r93 = trunc i1792 %r90 to i64
store i64 %r93, i64* %r92
%r94 = lshr i1792 %r90, 64
%r96 = getelementptr i64, i64* %r2, i32 20
%r97 = trunc i1792 %r94 to i64
store i64 %r97, i64* %r96
%r98 = lshr i1792 %r94, 64
%r100 = getelementptr i64, i64* %r2, i32 21
%r101 = trunc i1792 %r98 to i64
store i64 %r101, i64* %r100
%r102 = lshr i1792 %r98, 64
%r104 = getelementptr i64, i64* %r2, i32 22
%r105 = trunc i1792 %r102 to i64
store i64 %r105, i64* %r104
%r106 = lshr i1792 %r102, 64
%r108 = getelementptr i64, i64* %r2, i32 23
%r109 = trunc i1792 %r106 to i64
store i64 %r109, i64* %r108
%r110 = lshr i1792 %r106, 64
%r112 = getelementptr i64, i64* %r2, i32 24
%r113 = trunc i1792 %r110 to i64
store i64 %r113, i64* %r112
%r114 = lshr i1792 %r110, 64
%r116 = getelementptr i64, i64* %r2, i32 25
%r117 = trunc i1792 %r114 to i64
store i64 %r117, i64* %r116
%r118 = lshr i1792 %r114, 64
%r120 = getelementptr i64, i64* %r2, i32 26
%r121 = trunc i1792 %r118 to i64
store i64 %r121, i64* %r120
%r122 = lshr i1792 %r118, 64
%r124 = getelementptr i64, i64* %r2, i32 27
%r125 = trunc i1792 %r122 to i64
store i64 %r125, i64* %r124
%r126 = lshr i1856 %r13, 1792
%r127 = trunc i1856 %r126 to i64
ret i64 %r127
}
define i64 @mclb_sub28(i64* noalias  %r2, i64* noalias  %r3, i64* noalias  %r4)
{
%r6 = bitcast i64* %r3 to i1792*
%r7 = load i1792, i1792* %r6
%r8 = zext i1792 %r7 to i1856
%r10 = bitcast i64* %r4 to i1792*
%r11 = load i1792, i1792* %r10
%r12 = zext i1792 %r11 to i1856
%r13 = sub i1856 %r8, %r12
%r14 = trunc i1856 %r13 to i1792
%r16 = getelementptr i64, i64* %r2, i32 0
%r17 = trunc i1792 %r14 to i64
store i64 %r17, i64* %r16
%r18 = lshr i1792 %r14, 64
%r20 = getelementptr i64, i64* %r2, i32 1
%r21 = trunc i1792 %r18 to i64
store i64 %r21, i64* %r20
%r22 = lshr i1792 %r18, 64
%r24 = getelementptr i64, i64* %r2, i32 2
%r25 = trunc i1792 %r22 to i64
store i64 %r25, i64* %r24
%r26 = lshr i1792 %r22, 64
%r28 = getelementptr i64, i64* %r2, i32 3
%r29 = trunc i1792 %r26 to i64
store i64 %r29, i64* %r28
%r30 = lshr i1792 %r26, 64
%r32 = getelementptr i64, i64* %r2, i32 4
%r33 = trunc i1792 %r30 to i64
store i64 %r33, i64* %r32
%r34 = lshr i1792 %r30, 64
%r36 = getelementptr i64, i64* %r2, i32 5
%r37 = trunc i1792 %r34 to i64
store i64 %r37, i64* %r36
%r38 = lshr i1792 %r34, 64
%r40 = getelementptr i64, i64* %r2, i32 6
%r41 = trunc i1792 %r38 to i64
store i64 %r41, i64* %r40
%r42 = lshr i1792 %r38, 64
%r44 = getelementptr i64, i64* %r2, i32 7
%r45 = trunc i1792 %r42 to i64
store i64 %r45, i64* %r44
%r46 = lshr i1792 %r42, 64
%r48 = getelementptr i64, i64* %r2, i32 8
%r49 = trunc i1792 %r46 to i64
store i64 %r49, i64* %r48
%r50 = lshr i1792 %r46, 64
%r52 = getelementptr i64, i64* %r2, i32 9
%r53 = trunc i1792 %r50 to i64
store i64 %r53, i64* %r52
%r54 = lshr i1792 %r50, 64
%r56 = getelementptr i64, i64* %r2, i32 10
%r57 = trunc i1792 %r54 to i64
store i64 %r57, i64* %r56
%r58 = lshr i1792 %r54, 64
%r60 = getelementptr i64, i64* %r2, i32 11
%r61 = trunc i1792 %r58 to i64
store i64 %r61, i64* %r60
%r62 = lshr i1792 %r58, 64
%r64 = getelementptr i64, i64* %r2, i32 12
%r65 = trunc i1792 %r62 to i64
store i64 %r65, i64* %r64
%r66 = lshr i1792 %r62, 64
%r68 = getelementptr i64, i64* %r2, i32 13
%r69 = trunc i1792 %r66 to i64
store i64 %r69, i64* %r68
%r70 = lshr i1792 %r66, 64
%r72 = getelementptr i64, i64* %r2, i32 14
%r73 = trunc i1792 %r70 to i64
store i64 %r73, i64* %r72
%r74 = lshr i1792 %r70, 64
%r76 = getelementptr i64, i64* %r2, i32 15
%r77 = trunc i1792 %r74 to i64
store i64 %r77, i64* %r76
%r78 = lshr i1792 %r74, 64
%r80 = getelementptr i64, i64* %r2, i32 16
%r81 = trunc i1792 %r78 to i64
store i64 %r81, i64* %r80
%r82 = lshr i1792 %r78, 64
%r84 = getelementptr i64, i64* %r2, i32 17
%r85 = trunc i1792 %r82 to i64
store i64 %r85, i64* %r84
%r86 = lshr i1792 %r82, 64
%r88 = getelementptr i64, i64* %r2, i32 18
%r89 = trunc i1792 %r86 to i64
store i64 %r89, i64* %r88
%r90 = lshr i1792 %r86, 64
%r92 = getelementptr i64, i64* %r2, i32 19
%r93 = trunc i1792 %r90 to i64
store i64 %r93, i64* %r92
%r94 = lshr i1792 %r90, 64
%r96 = getelementptr i64, i64* %r2, i32 20
%r97 = trunc i1792 %r94 to i64
store i64 %r97, i64* %r96
%r98 = lshr i1792 %r94, 64
%r100 = getelementptr i64, i64* %r2, i32 21
%r101 = trunc i1792 %r98 to i64
store i64 %r101, i64* %r100
%r102 = lshr i1792 %r98, 64
%r104 = getelementptr i64, i64* %r2, i32 22
%r105 = trunc i1792 %r102 to i64
store i64 %r105, i64* %r104
%r106 = lshr i1792 %r102, 64
%r108 = getelementptr i64, i64* %r2, i32 23
%r109 = trunc i1792 %r106 to i64
store i64 %r109, i64* %r108
%r110 = lshr i1792 %r106, 64
%r112 = getelementptr i64, i64* %r2, i32 24
%r113 = trunc i1792 %r110 to i64
store i64 %r113, i64* %r112
%r114 = lshr i1792 %r110, 64
%r116 = getelementptr i64, i64* %r2, i32 25
%r117 = trunc i1792 %r114 to i64
store i64 %r117, i64* %r116
%r118 = lshr i1792 %r114, 64
%r120 = getelementptr i64, i64* %r2, i32 26
%r121 = trunc i1792 %r118 to i64
store i64 %r121, i64* %r120
%r122 = lshr i1792 %r118, 64
%r124 = getelementptr i64, i64* %r2, i32 27
%r125 = trunc i1792 %r122 to i64
store i64 %r125, i64* %r124
%r126 = lshr i1856 %r13, 1792
%r127 = trunc i1856 %r126 to i64
%r129 = and i64 %r127, 1
ret i64 %r129
}
define void @mclb_addNF28(i64* noalias  %r1, i64* noalias  %r2, i64* noalias  %r3)
{
%r5 = bitcast i64* %r2 to i1792*
%r6 = load i1792, i1792* %r5
%r8 = bitcast i64* %r3 to i1792*
%r9 = load i1792, i1792* %r8
%r10 = add i1792 %r6, %r9
%r12 = getelementptr i64, i64* %r1, i32 0
%r13 = trunc i1792 %r10 to i64
store i64 %r13, i64* %r12
%r14 = lshr i1792 %r10, 64
%r16 = getelementptr i64, i64* %r1, i32 1
%r17 = trunc i1792 %r14 to i64
store i64 %r17, i64* %r16
%r18 = lshr i1792 %r14, 64
%r20 = getelementptr i64, i64* %r1, i32 2
%r21 = trunc i1792 %r18 to i64
store i64 %r21, i64* %r20
%r22 = lshr i1792 %r18, 64
%r24 = getelementptr i64, i64* %r1, i32 3
%r25 = trunc i1792 %r22 to i64
store i64 %r25, i64* %r24
%r26 = lshr i1792 %r22, 64
%r28 = getelementptr i64, i64* %r1, i32 4
%r29 = trunc i1792 %r26 to i64
store i64 %r29, i64* %r28
%r30 = lshr i1792 %r26, 64
%r32 = getelementptr i64, i64* %r1, i32 5
%r33 = trunc i1792 %r30 to i64
store i64 %r33, i64* %r32
%r34 = lshr i1792 %r30, 64
%r36 = getelementptr i64, i64* %r1, i32 6
%r37 = trunc i1792 %r34 to i64
store i64 %r37, i64* %r36
%r38 = lshr i1792 %r34, 64
%r40 = getelementptr i64, i64* %r1, i32 7
%r41 = trunc i1792 %r38 to i64
store i64 %r41, i64* %r40
%r42 = lshr i1792 %r38, 64
%r44 = getelementptr i64, i64* %r1, i32 8
%r45 = trunc i1792 %r42 to i64
store i64 %r45, i64* %r44
%r46 = lshr i1792 %r42, 64
%r48 = getelementptr i64, i64* %r1, i32 9
%r49 = trunc i1792 %r46 to i64
store i64 %r49, i64* %r48
%r50 = lshr i1792 %r46, 64
%r52 = getelementptr i64, i64* %r1, i32 10
%r53 = trunc i1792 %r50 to i64
store i64 %r53, i64* %r52
%r54 = lshr i1792 %r50, 64
%r56 = getelementptr i64, i64* %r1, i32 11
%r57 = trunc i1792 %r54 to i64
store i64 %r57, i64* %r56
%r58 = lshr i1792 %r54, 64
%r60 = getelementptr i64, i64* %r1, i32 12
%r61 = trunc i1792 %r58 to i64
store i64 %r61, i64* %r60
%r62 = lshr i1792 %r58, 64
%r64 = getelementptr i64, i64* %r1, i32 13
%r65 = trunc i1792 %r62 to i64
store i64 %r65, i64* %r64
%r66 = lshr i1792 %r62, 64
%r68 = getelementptr i64, i64* %r1, i32 14
%r69 = trunc i1792 %r66 to i64
store i64 %r69, i64* %r68
%r70 = lshr i1792 %r66, 64
%r72 = getelementptr i64, i64* %r1, i32 15
%r73 = trunc i1792 %r70 to i64
store i64 %r73, i64* %r72
%r74 = lshr i1792 %r70, 64
%r76 = getelementptr i64, i64* %r1, i32 16
%r77 = trunc i1792 %r74 to i64
store i64 %r77, i64* %r76
%r78 = lshr i1792 %r74, 64
%r80 = getelementptr i64, i64* %r1, i32 17
%r81 = trunc i1792 %r78 to i64
store i64 %r81, i64* %r80
%r82 = lshr i1792 %r78, 64
%r84 = getelementptr i64, i64* %r1, i32 18
%r85 = trunc i1792 %r82 to i64
store i64 %r85, i64* %r84
%r86 = lshr i1792 %r82, 64
%r88 = getelementptr i64, i64* %r1, i32 19
%r89 = trunc i1792 %r86 to i64
store i64 %r89, i64* %r88
%r90 = lshr i1792 %r86, 64
%r92 = getelementptr i64, i64* %r1, i32 20
%r93 = trunc i1792 %r90 to i64
store i64 %r93, i64* %r92
%r94 = lshr i1792 %r90, 64
%r96 = getelementptr i64, i64* %r1, i32 21
%r97 = trunc i1792 %r94 to i64
store i64 %r97, i64* %r96
%r98 = lshr i1792 %r94, 64
%r100 = getelementptr i64, i64* %r1, i32 22
%r101 = trunc i1792 %r98 to i64
store i64 %r101, i64* %r100
%r102 = lshr i1792 %r98, 64
%r104 = getelementptr i64, i64* %r1, i32 23
%r105 = trunc i1792 %r102 to i64
store i64 %r105, i64* %r104
%r106 = lshr i1792 %r102, 64
%r108 = getelementptr i64, i64* %r1, i32 24
%r109 = trunc i1792 %r106 to i64
store i64 %r109, i64* %r108
%r110 = lshr i1792 %r106, 64
%r112 = getelementptr i64, i64* %r1, i32 25
%r113 = trunc i1792 %r110 to i64
store i64 %r113, i64* %r112
%r114 = lshr i1792 %r110, 64
%r116 = getelementptr i64, i64* %r1, i32 26
%r117 = trunc i1792 %r114 to i64
store i64 %r117, i64* %r116
%r118 = lshr i1792 %r114, 64
%r120 = getelementptr i64, i64* %r1, i32 27
%r121 = trunc i1792 %r118 to i64
store i64 %r121, i64* %r120
ret void
}
define i64 @mclb_subNF28(i64* noalias  %r2, i64* noalias  %r3, i64* noalias  %r4)
{
%r6 = bitcast i64* %r3 to i1792*
%r7 = load i1792, i1792* %r6
%r9 = bitcast i64* %r4 to i1792*
%r10 = load i1792, i1792* %r9
%r11 = sub i1792 %r7, %r10
%r13 = getelementptr i64, i64* %r2, i32 0
%r14 = trunc i1792 %r11 to i64
store i64 %r14, i64* %r13
%r15 = lshr i1792 %r11, 64
%r17 = getelementptr i64, i64* %r2, i32 1
%r18 = trunc i1792 %r15 to i64
store i64 %r18, i64* %r17
%r19 = lshr i1792 %r15, 64
%r21 = getelementptr i64, i64* %r2, i32 2
%r22 = trunc i1792 %r19 to i64
store i64 %r22, i64* %r21
%r23 = lshr i1792 %r19, 64
%r25 = getelementptr i64, i64* %r2, i32 3
%r26 = trunc i1792 %r23 to i64
store i64 %r26, i64* %r25
%r27 = lshr i1792 %r23, 64
%r29 = getelementptr i64, i64* %r2, i32 4
%r30 = trunc i1792 %r27 to i64
store i64 %r30, i64* %r29
%r31 = lshr i1792 %r27, 64
%r33 = getelementptr i64, i64* %r2, i32 5
%r34 = trunc i1792 %r31 to i64
store i64 %r34, i64* %r33
%r35 = lshr i1792 %r31, 64
%r37 = getelementptr i64, i64* %r2, i32 6
%r38 = trunc i1792 %r35 to i64
store i64 %r38, i64* %r37
%r39 = lshr i1792 %r35, 64
%r41 = getelementptr i64, i64* %r2, i32 7
%r42 = trunc i1792 %r39 to i64
store i64 %r42, i64* %r41
%r43 = lshr i1792 %r39, 64
%r45 = getelementptr i64, i64* %r2, i32 8
%r46 = trunc i1792 %r43 to i64
store i64 %r46, i64* %r45
%r47 = lshr i1792 %r43, 64
%r49 = getelementptr i64, i64* %r2, i32 9
%r50 = trunc i1792 %r47 to i64
store i64 %r50, i64* %r49
%r51 = lshr i1792 %r47, 64
%r53 = getelementptr i64, i64* %r2, i32 10
%r54 = trunc i1792 %r51 to i64
store i64 %r54, i64* %r53
%r55 = lshr i1792 %r51, 64
%r57 = getelementptr i64, i64* %r2, i32 11
%r58 = trunc i1792 %r55 to i64
store i64 %r58, i64* %r57
%r59 = lshr i1792 %r55, 64
%r61 = getelementptr i64, i64* %r2, i32 12
%r62 = trunc i1792 %r59 to i64
store i64 %r62, i64* %r61
%r63 = lshr i1792 %r59, 64
%r65 = getelementptr i64, i64* %r2, i32 13
%r66 = trunc i1792 %r63 to i64
store i64 %r66, i64* %r65
%r67 = lshr i1792 %r63, 64
%r69 = getelementptr i64, i64* %r2, i32 14
%r70 = trunc i1792 %r67 to i64
store i64 %r70, i64* %r69
%r71 = lshr i1792 %r67, 64
%r73 = getelementptr i64, i64* %r2, i32 15
%r74 = trunc i1792 %r71 to i64
store i64 %r74, i64* %r73
%r75 = lshr i1792 %r71, 64
%r77 = getelementptr i64, i64* %r2, i32 16
%r78 = trunc i1792 %r75 to i64
store i64 %r78, i64* %r77
%r79 = lshr i1792 %r75, 64
%r81 = getelementptr i64, i64* %r2, i32 17
%r82 = trunc i1792 %r79 to i64
store i64 %r82, i64* %r81
%r83 = lshr i1792 %r79, 64
%r85 = getelementptr i64, i64* %r2, i32 18
%r86 = trunc i1792 %r83 to i64
store i64 %r86, i64* %r85
%r87 = lshr i1792 %r83, 64
%r89 = getelementptr i64, i64* %r2, i32 19
%r90 = trunc i1792 %r87 to i64
store i64 %r90, i64* %r89
%r91 = lshr i1792 %r87, 64
%r93 = getelementptr i64, i64* %r2, i32 20
%r94 = trunc i1792 %r91 to i64
store i64 %r94, i64* %r93
%r95 = lshr i1792 %r91, 64
%r97 = getelementptr i64, i64* %r2, i32 21
%r98 = trunc i1792 %r95 to i64
store i64 %r98, i64* %r97
%r99 = lshr i1792 %r95, 64
%r101 = getelementptr i64, i64* %r2, i32 22
%r102 = trunc i1792 %r99 to i64
store i64 %r102, i64* %r101
%r103 = lshr i1792 %r99, 64
%r105 = getelementptr i64, i64* %r2, i32 23
%r106 = trunc i1792 %r103 to i64
store i64 %r106, i64* %r105
%r107 = lshr i1792 %r103, 64
%r109 = getelementptr i64, i64* %r2, i32 24
%r110 = trunc i1792 %r107 to i64
store i64 %r110, i64* %r109
%r111 = lshr i1792 %r107, 64
%r113 = getelementptr i64, i64* %r2, i32 25
%r114 = trunc i1792 %r111 to i64
store i64 %r114, i64* %r113
%r115 = lshr i1792 %r111, 64
%r117 = getelementptr i64, i64* %r2, i32 26
%r118 = trunc i1792 %r115 to i64
store i64 %r118, i64* %r117
%r119 = lshr i1792 %r115, 64
%r121 = getelementptr i64, i64* %r2, i32 27
%r122 = trunc i1792 %r119 to i64
store i64 %r122, i64* %r121
%r123 = lshr i1792 %r11, 1791
%r124 = trunc i1792 %r123 to i64
%r126 = and i64 %r124, 1
ret i64 %r126
}
define i64 @mclb_add29(i64* noalias  %r2, i64* noalias  %r3, i64* noalias  %r4)
{
%r6 = bitcast i64* %r3 to i1856*
%r7 = load i1856, i1856* %r6
%r8 = zext i1856 %r7 to i1920
%r10 = bitcast i64* %r4 to i1856*
%r11 = load i1856, i1856* %r10
%r12 = zext i1856 %r11 to i1920
%r13 = add i1920 %r8, %r12
%r14 = trunc i1920 %r13 to i1856
%r16 = getelementptr i64, i64* %r2, i32 0
%r17 = trunc i1856 %r14 to i64
store i64 %r17, i64* %r16
%r18 = lshr i1856 %r14, 64
%r20 = getelementptr i64, i64* %r2, i32 1
%r21 = trunc i1856 %r18 to i64
store i64 %r21, i64* %r20
%r22 = lshr i1856 %r18, 64
%r24 = getelementptr i64, i64* %r2, i32 2
%r25 = trunc i1856 %r22 to i64
store i64 %r25, i64* %r24
%r26 = lshr i1856 %r22, 64
%r28 = getelementptr i64, i64* %r2, i32 3
%r29 = trunc i1856 %r26 to i64
store i64 %r29, i64* %r28
%r30 = lshr i1856 %r26, 64
%r32 = getelementptr i64, i64* %r2, i32 4
%r33 = trunc i1856 %r30 to i64
store i64 %r33, i64* %r32
%r34 = lshr i1856 %r30, 64
%r36 = getelementptr i64, i64* %r2, i32 5
%r37 = trunc i1856 %r34 to i64
store i64 %r37, i64* %r36
%r38 = lshr i1856 %r34, 64
%r40 = getelementptr i64, i64* %r2, i32 6
%r41 = trunc i1856 %r38 to i64
store i64 %r41, i64* %r40
%r42 = lshr i1856 %r38, 64
%r44 = getelementptr i64, i64* %r2, i32 7
%r45 = trunc i1856 %r42 to i64
store i64 %r45, i64* %r44
%r46 = lshr i1856 %r42, 64
%r48 = getelementptr i64, i64* %r2, i32 8
%r49 = trunc i1856 %r46 to i64
store i64 %r49, i64* %r48
%r50 = lshr i1856 %r46, 64
%r52 = getelementptr i64, i64* %r2, i32 9
%r53 = trunc i1856 %r50 to i64
store i64 %r53, i64* %r52
%r54 = lshr i1856 %r50, 64
%r56 = getelementptr i64, i64* %r2, i32 10
%r57 = trunc i1856 %r54 to i64
store i64 %r57, i64* %r56
%r58 = lshr i1856 %r54, 64
%r60 = getelementptr i64, i64* %r2, i32 11
%r61 = trunc i1856 %r58 to i64
store i64 %r61, i64* %r60
%r62 = lshr i1856 %r58, 64
%r64 = getelementptr i64, i64* %r2, i32 12
%r65 = trunc i1856 %r62 to i64
store i64 %r65, i64* %r64
%r66 = lshr i1856 %r62, 64
%r68 = getelementptr i64, i64* %r2, i32 13
%r69 = trunc i1856 %r66 to i64
store i64 %r69, i64* %r68
%r70 = lshr i1856 %r66, 64
%r72 = getelementptr i64, i64* %r2, i32 14
%r73 = trunc i1856 %r70 to i64
store i64 %r73, i64* %r72
%r74 = lshr i1856 %r70, 64
%r76 = getelementptr i64, i64* %r2, i32 15
%r77 = trunc i1856 %r74 to i64
store i64 %r77, i64* %r76
%r78 = lshr i1856 %r74, 64
%r80 = getelementptr i64, i64* %r2, i32 16
%r81 = trunc i1856 %r78 to i64
store i64 %r81, i64* %r80
%r82 = lshr i1856 %r78, 64
%r84 = getelementptr i64, i64* %r2, i32 17
%r85 = trunc i1856 %r82 to i64
store i64 %r85, i64* %r84
%r86 = lshr i1856 %r82, 64
%r88 = getelementptr i64, i64* %r2, i32 18
%r89 = trunc i1856 %r86 to i64
store i64 %r89, i64* %r88
%r90 = lshr i1856 %r86, 64
%r92 = getelementptr i64, i64* %r2, i32 19
%r93 = trunc i1856 %r90 to i64
store i64 %r93, i64* %r92
%r94 = lshr i1856 %r90, 64
%r96 = getelementptr i64, i64* %r2, i32 20
%r97 = trunc i1856 %r94 to i64
store i64 %r97, i64* %r96
%r98 = lshr i1856 %r94, 64
%r100 = getelementptr i64, i64* %r2, i32 21
%r101 = trunc i1856 %r98 to i64
store i64 %r101, i64* %r100
%r102 = lshr i1856 %r98, 64
%r104 = getelementptr i64, i64* %r2, i32 22
%r105 = trunc i1856 %r102 to i64
store i64 %r105, i64* %r104
%r106 = lshr i1856 %r102, 64
%r108 = getelementptr i64, i64* %r2, i32 23
%r109 = trunc i1856 %r106 to i64
store i64 %r109, i64* %r108
%r110 = lshr i1856 %r106, 64
%r112 = getelementptr i64, i64* %r2, i32 24
%r113 = trunc i1856 %r110 to i64
store i64 %r113, i64* %r112
%r114 = lshr i1856 %r110, 64
%r116 = getelementptr i64, i64* %r2, i32 25
%r117 = trunc i1856 %r114 to i64
store i64 %r117, i64* %r116
%r118 = lshr i1856 %r114, 64
%r120 = getelementptr i64, i64* %r2, i32 26
%r121 = trunc i1856 %r118 to i64
store i64 %r121, i64* %r120
%r122 = lshr i1856 %r118, 64
%r124 = getelementptr i64, i64* %r2, i32 27
%r125 = trunc i1856 %r122 to i64
store i64 %r125, i64* %r124
%r126 = lshr i1856 %r122, 64
%r128 = getelementptr i64, i64* %r2, i32 28
%r129 = trunc i1856 %r126 to i64
store i64 %r129, i64* %r128
%r130 = lshr i1920 %r13, 1856
%r131 = trunc i1920 %r130 to i64
ret i64 %r131
}
define i64 @mclb_sub29(i64* noalias  %r2, i64* noalias  %r3, i64* noalias  %r4)
{
%r6 = bitcast i64* %r3 to i1856*
%r7 = load i1856, i1856* %r6
%r8 = zext i1856 %r7 to i1920
%r10 = bitcast i64* %r4 to i1856*
%r11 = load i1856, i1856* %r10
%r12 = zext i1856 %r11 to i1920
%r13 = sub i1920 %r8, %r12
%r14 = trunc i1920 %r13 to i1856
%r16 = getelementptr i64, i64* %r2, i32 0
%r17 = trunc i1856 %r14 to i64
store i64 %r17, i64* %r16
%r18 = lshr i1856 %r14, 64
%r20 = getelementptr i64, i64* %r2, i32 1
%r21 = trunc i1856 %r18 to i64
store i64 %r21, i64* %r20
%r22 = lshr i1856 %r18, 64
%r24 = getelementptr i64, i64* %r2, i32 2
%r25 = trunc i1856 %r22 to i64
store i64 %r25, i64* %r24
%r26 = lshr i1856 %r22, 64
%r28 = getelementptr i64, i64* %r2, i32 3
%r29 = trunc i1856 %r26 to i64
store i64 %r29, i64* %r28
%r30 = lshr i1856 %r26, 64
%r32 = getelementptr i64, i64* %r2, i32 4
%r33 = trunc i1856 %r30 to i64
store i64 %r33, i64* %r32
%r34 = lshr i1856 %r30, 64
%r36 = getelementptr i64, i64* %r2, i32 5
%r37 = trunc i1856 %r34 to i64
store i64 %r37, i64* %r36
%r38 = lshr i1856 %r34, 64
%r40 = getelementptr i64, i64* %r2, i32 6
%r41 = trunc i1856 %r38 to i64
store i64 %r41, i64* %r40
%r42 = lshr i1856 %r38, 64
%r44 = getelementptr i64, i64* %r2, i32 7
%r45 = trunc i1856 %r42 to i64
store i64 %r45, i64* %r44
%r46 = lshr i1856 %r42, 64
%r48 = getelementptr i64, i64* %r2, i32 8
%r49 = trunc i1856 %r46 to i64
store i64 %r49, i64* %r48
%r50 = lshr i1856 %r46, 64
%r52 = getelementptr i64, i64* %r2, i32 9
%r53 = trunc i1856 %r50 to i64
store i64 %r53, i64* %r52
%r54 = lshr i1856 %r50, 64
%r56 = getelementptr i64, i64* %r2, i32 10
%r57 = trunc i1856 %r54 to i64
store i64 %r57, i64* %r56
%r58 = lshr i1856 %r54, 64
%r60 = getelementptr i64, i64* %r2, i32 11
%r61 = trunc i1856 %r58 to i64
store i64 %r61, i64* %r60
%r62 = lshr i1856 %r58, 64
%r64 = getelementptr i64, i64* %r2, i32 12
%r65 = trunc i1856 %r62 to i64
store i64 %r65, i64* %r64
%r66 = lshr i1856 %r62, 64
%r68 = getelementptr i64, i64* %r2, i32 13
%r69 = trunc i1856 %r66 to i64
store i64 %r69, i64* %r68
%r70 = lshr i1856 %r66, 64
%r72 = getelementptr i64, i64* %r2, i32 14
%r73 = trunc i1856 %r70 to i64
store i64 %r73, i64* %r72
%r74 = lshr i1856 %r70, 64
%r76 = getelementptr i64, i64* %r2, i32 15
%r77 = trunc i1856 %r74 to i64
store i64 %r77, i64* %r76
%r78 = lshr i1856 %r74, 64
%r80 = getelementptr i64, i64* %r2, i32 16
%r81 = trunc i1856 %r78 to i64
store i64 %r81, i64* %r80
%r82 = lshr i1856 %r78, 64
%r84 = getelementptr i64, i64* %r2, i32 17
%r85 = trunc i1856 %r82 to i64
store i64 %r85, i64* %r84
%r86 = lshr i1856 %r82, 64
%r88 = getelementptr i64, i64* %r2, i32 18
%r89 = trunc i1856 %r86 to i64
store i64 %r89, i64* %r88
%r90 = lshr i1856 %r86, 64
%r92 = getelementptr i64, i64* %r2, i32 19
%r93 = trunc i1856 %r90 to i64
store i64 %r93, i64* %r92
%r94 = lshr i1856 %r90, 64
%r96 = getelementptr i64, i64* %r2, i32 20
%r97 = trunc i1856 %r94 to i64
store i64 %r97, i64* %r96
%r98 = lshr i1856 %r94, 64
%r100 = getelementptr i64, i64* %r2, i32 21
%r101 = trunc i1856 %r98 to i64
store i64 %r101, i64* %r100
%r102 = lshr i1856 %r98, 64
%r104 = getelementptr i64, i64* %r2, i32 22
%r105 = trunc i1856 %r102 to i64
store i64 %r105, i64* %r104
%r106 = lshr i1856 %r102, 64
%r108 = getelementptr i64, i64* %r2, i32 23
%r109 = trunc i1856 %r106 to i64
store i64 %r109, i64* %r108
%r110 = lshr i1856 %r106, 64
%r112 = getelementptr i64, i64* %r2, i32 24
%r113 = trunc i1856 %r110 to i64
store i64 %r113, i64* %r112
%r114 = lshr i1856 %r110, 64
%r116 = getelementptr i64, i64* %r2, i32 25
%r117 = trunc i1856 %r114 to i64
store i64 %r117, i64* %r116
%r118 = lshr i1856 %r114, 64
%r120 = getelementptr i64, i64* %r2, i32 26
%r121 = trunc i1856 %r118 to i64
store i64 %r121, i64* %r120
%r122 = lshr i1856 %r118, 64
%r124 = getelementptr i64, i64* %r2, i32 27
%r125 = trunc i1856 %r122 to i64
store i64 %r125, i64* %r124
%r126 = lshr i1856 %r122, 64
%r128 = getelementptr i64, i64* %r2, i32 28
%r129 = trunc i1856 %r126 to i64
store i64 %r129, i64* %r128
%r130 = lshr i1920 %r13, 1856
%r131 = trunc i1920 %r130 to i64
%r133 = and i64 %r131, 1
ret i64 %r133
}
define void @mclb_addNF29(i64* noalias  %r1, i64* noalias  %r2, i64* noalias  %r3)
{
%r5 = bitcast i64* %r2 to i1856*
%r6 = load i1856, i1856* %r5
%r8 = bitcast i64* %r3 to i1856*
%r9 = load i1856, i1856* %r8
%r10 = add i1856 %r6, %r9
%r12 = getelementptr i64, i64* %r1, i32 0
%r13 = trunc i1856 %r10 to i64
store i64 %r13, i64* %r12
%r14 = lshr i1856 %r10, 64
%r16 = getelementptr i64, i64* %r1, i32 1
%r17 = trunc i1856 %r14 to i64
store i64 %r17, i64* %r16
%r18 = lshr i1856 %r14, 64
%r20 = getelementptr i64, i64* %r1, i32 2
%r21 = trunc i1856 %r18 to i64
store i64 %r21, i64* %r20
%r22 = lshr i1856 %r18, 64
%r24 = getelementptr i64, i64* %r1, i32 3
%r25 = trunc i1856 %r22 to i64
store i64 %r25, i64* %r24
%r26 = lshr i1856 %r22, 64
%r28 = getelementptr i64, i64* %r1, i32 4
%r29 = trunc i1856 %r26 to i64
store i64 %r29, i64* %r28
%r30 = lshr i1856 %r26, 64
%r32 = getelementptr i64, i64* %r1, i32 5
%r33 = trunc i1856 %r30 to i64
store i64 %r33, i64* %r32
%r34 = lshr i1856 %r30, 64
%r36 = getelementptr i64, i64* %r1, i32 6
%r37 = trunc i1856 %r34 to i64
store i64 %r37, i64* %r36
%r38 = lshr i1856 %r34, 64
%r40 = getelementptr i64, i64* %r1, i32 7
%r41 = trunc i1856 %r38 to i64
store i64 %r41, i64* %r40
%r42 = lshr i1856 %r38, 64
%r44 = getelementptr i64, i64* %r1, i32 8
%r45 = trunc i1856 %r42 to i64
store i64 %r45, i64* %r44
%r46 = lshr i1856 %r42, 64
%r48 = getelementptr i64, i64* %r1, i32 9
%r49 = trunc i1856 %r46 to i64
store i64 %r49, i64* %r48
%r50 = lshr i1856 %r46, 64
%r52 = getelementptr i64, i64* %r1, i32 10
%r53 = trunc i1856 %r50 to i64
store i64 %r53, i64* %r52
%r54 = lshr i1856 %r50, 64
%r56 = getelementptr i64, i64* %r1, i32 11
%r57 = trunc i1856 %r54 to i64
store i64 %r57, i64* %r56
%r58 = lshr i1856 %r54, 64
%r60 = getelementptr i64, i64* %r1, i32 12
%r61 = trunc i1856 %r58 to i64
store i64 %r61, i64* %r60
%r62 = lshr i1856 %r58, 64
%r64 = getelementptr i64, i64* %r1, i32 13
%r65 = trunc i1856 %r62 to i64
store i64 %r65, i64* %r64
%r66 = lshr i1856 %r62, 64
%r68 = getelementptr i64, i64* %r1, i32 14
%r69 = trunc i1856 %r66 to i64
store i64 %r69, i64* %r68
%r70 = lshr i1856 %r66, 64
%r72 = getelementptr i64, i64* %r1, i32 15
%r73 = trunc i1856 %r70 to i64
store i64 %r73, i64* %r72
%r74 = lshr i1856 %r70, 64
%r76 = getelementptr i64, i64* %r1, i32 16
%r77 = trunc i1856 %r74 to i64
store i64 %r77, i64* %r76
%r78 = lshr i1856 %r74, 64
%r80 = getelementptr i64, i64* %r1, i32 17
%r81 = trunc i1856 %r78 to i64
store i64 %r81, i64* %r80
%r82 = lshr i1856 %r78, 64
%r84 = getelementptr i64, i64* %r1, i32 18
%r85 = trunc i1856 %r82 to i64
store i64 %r85, i64* %r84
%r86 = lshr i1856 %r82, 64
%r88 = getelementptr i64, i64* %r1, i32 19
%r89 = trunc i1856 %r86 to i64
store i64 %r89, i64* %r88
%r90 = lshr i1856 %r86, 64
%r92 = getelementptr i64, i64* %r1, i32 20
%r93 = trunc i1856 %r90 to i64
store i64 %r93, i64* %r92
%r94 = lshr i1856 %r90, 64
%r96 = getelementptr i64, i64* %r1, i32 21
%r97 = trunc i1856 %r94 to i64
store i64 %r97, i64* %r96
%r98 = lshr i1856 %r94, 64
%r100 = getelementptr i64, i64* %r1, i32 22
%r101 = trunc i1856 %r98 to i64
store i64 %r101, i64* %r100
%r102 = lshr i1856 %r98, 64
%r104 = getelementptr i64, i64* %r1, i32 23
%r105 = trunc i1856 %r102 to i64
store i64 %r105, i64* %r104
%r106 = lshr i1856 %r102, 64
%r108 = getelementptr i64, i64* %r1, i32 24
%r109 = trunc i1856 %r106 to i64
store i64 %r109, i64* %r108
%r110 = lshr i1856 %r106, 64
%r112 = getelementptr i64, i64* %r1, i32 25
%r113 = trunc i1856 %r110 to i64
store i64 %r113, i64* %r112
%r114 = lshr i1856 %r110, 64
%r116 = getelementptr i64, i64* %r1, i32 26
%r117 = trunc i1856 %r114 to i64
store i64 %r117, i64* %r116
%r118 = lshr i1856 %r114, 64
%r120 = getelementptr i64, i64* %r1, i32 27
%r121 = trunc i1856 %r118 to i64
store i64 %r121, i64* %r120
%r122 = lshr i1856 %r118, 64
%r124 = getelementptr i64, i64* %r1, i32 28
%r125 = trunc i1856 %r122 to i64
store i64 %r125, i64* %r124
ret void
}
define i64 @mclb_subNF29(i64* noalias  %r2, i64* noalias  %r3, i64* noalias  %r4)
{
%r6 = bitcast i64* %r3 to i1856*
%r7 = load i1856, i1856* %r6
%r9 = bitcast i64* %r4 to i1856*
%r10 = load i1856, i1856* %r9
%r11 = sub i1856 %r7, %r10
%r13 = getelementptr i64, i64* %r2, i32 0
%r14 = trunc i1856 %r11 to i64
store i64 %r14, i64* %r13
%r15 = lshr i1856 %r11, 64
%r17 = getelementptr i64, i64* %r2, i32 1
%r18 = trunc i1856 %r15 to i64
store i64 %r18, i64* %r17
%r19 = lshr i1856 %r15, 64
%r21 = getelementptr i64, i64* %r2, i32 2
%r22 = trunc i1856 %r19 to i64
store i64 %r22, i64* %r21
%r23 = lshr i1856 %r19, 64
%r25 = getelementptr i64, i64* %r2, i32 3
%r26 = trunc i1856 %r23 to i64
store i64 %r26, i64* %r25
%r27 = lshr i1856 %r23, 64
%r29 = getelementptr i64, i64* %r2, i32 4
%r30 = trunc i1856 %r27 to i64
store i64 %r30, i64* %r29
%r31 = lshr i1856 %r27, 64
%r33 = getelementptr i64, i64* %r2, i32 5
%r34 = trunc i1856 %r31 to i64
store i64 %r34, i64* %r33
%r35 = lshr i1856 %r31, 64
%r37 = getelementptr i64, i64* %r2, i32 6
%r38 = trunc i1856 %r35 to i64
store i64 %r38, i64* %r37
%r39 = lshr i1856 %r35, 64
%r41 = getelementptr i64, i64* %r2, i32 7
%r42 = trunc i1856 %r39 to i64
store i64 %r42, i64* %r41
%r43 = lshr i1856 %r39, 64
%r45 = getelementptr i64, i64* %r2, i32 8
%r46 = trunc i1856 %r43 to i64
store i64 %r46, i64* %r45
%r47 = lshr i1856 %r43, 64
%r49 = getelementptr i64, i64* %r2, i32 9
%r50 = trunc i1856 %r47 to i64
store i64 %r50, i64* %r49
%r51 = lshr i1856 %r47, 64
%r53 = getelementptr i64, i64* %r2, i32 10
%r54 = trunc i1856 %r51 to i64
store i64 %r54, i64* %r53
%r55 = lshr i1856 %r51, 64
%r57 = getelementptr i64, i64* %r2, i32 11
%r58 = trunc i1856 %r55 to i64
store i64 %r58, i64* %r57
%r59 = lshr i1856 %r55, 64
%r61 = getelementptr i64, i64* %r2, i32 12
%r62 = trunc i1856 %r59 to i64
store i64 %r62, i64* %r61
%r63 = lshr i1856 %r59, 64
%r65 = getelementptr i64, i64* %r2, i32 13
%r66 = trunc i1856 %r63 to i64
store i64 %r66, i64* %r65
%r67 = lshr i1856 %r63, 64
%r69 = getelementptr i64, i64* %r2, i32 14
%r70 = trunc i1856 %r67 to i64
store i64 %r70, i64* %r69
%r71 = lshr i1856 %r67, 64
%r73 = getelementptr i64, i64* %r2, i32 15
%r74 = trunc i1856 %r71 to i64
store i64 %r74, i64* %r73
%r75 = lshr i1856 %r71, 64
%r77 = getelementptr i64, i64* %r2, i32 16
%r78 = trunc i1856 %r75 to i64
store i64 %r78, i64* %r77
%r79 = lshr i1856 %r75, 64
%r81 = getelementptr i64, i64* %r2, i32 17
%r82 = trunc i1856 %r79 to i64
store i64 %r82, i64* %r81
%r83 = lshr i1856 %r79, 64
%r85 = getelementptr i64, i64* %r2, i32 18
%r86 = trunc i1856 %r83 to i64
store i64 %r86, i64* %r85
%r87 = lshr i1856 %r83, 64
%r89 = getelementptr i64, i64* %r2, i32 19
%r90 = trunc i1856 %r87 to i64
store i64 %r90, i64* %r89
%r91 = lshr i1856 %r87, 64
%r93 = getelementptr i64, i64* %r2, i32 20
%r94 = trunc i1856 %r91 to i64
store i64 %r94, i64* %r93
%r95 = lshr i1856 %r91, 64
%r97 = getelementptr i64, i64* %r2, i32 21
%r98 = trunc i1856 %r95 to i64
store i64 %r98, i64* %r97
%r99 = lshr i1856 %r95, 64
%r101 = getelementptr i64, i64* %r2, i32 22
%r102 = trunc i1856 %r99 to i64
store i64 %r102, i64* %r101
%r103 = lshr i1856 %r99, 64
%r105 = getelementptr i64, i64* %r2, i32 23
%r106 = trunc i1856 %r103 to i64
store i64 %r106, i64* %r105
%r107 = lshr i1856 %r103, 64
%r109 = getelementptr i64, i64* %r2, i32 24
%r110 = trunc i1856 %r107 to i64
store i64 %r110, i64* %r109
%r111 = lshr i1856 %r107, 64
%r113 = getelementptr i64, i64* %r2, i32 25
%r114 = trunc i1856 %r111 to i64
store i64 %r114, i64* %r113
%r115 = lshr i1856 %r111, 64
%r117 = getelementptr i64, i64* %r2, i32 26
%r118 = trunc i1856 %r115 to i64
store i64 %r118, i64* %r117
%r119 = lshr i1856 %r115, 64
%r121 = getelementptr i64, i64* %r2, i32 27
%r122 = trunc i1856 %r119 to i64
store i64 %r122, i64* %r121
%r123 = lshr i1856 %r119, 64
%r125 = getelementptr i64, i64* %r2, i32 28
%r126 = trunc i1856 %r123 to i64
store i64 %r126, i64* %r125
%r127 = lshr i1856 %r11, 1855
%r128 = trunc i1856 %r127 to i64
%r130 = and i64 %r128, 1
ret i64 %r130
}
define i64 @mclb_add30(i64* noalias  %r2, i64* noalias  %r3, i64* noalias  %r4)
{
%r6 = bitcast i64* %r3 to i1920*
%r7 = load i1920, i1920* %r6
%r8 = zext i1920 %r7 to i1984
%r10 = bitcast i64* %r4 to i1920*
%r11 = load i1920, i1920* %r10
%r12 = zext i1920 %r11 to i1984
%r13 = add i1984 %r8, %r12
%r14 = trunc i1984 %r13 to i1920
%r16 = getelementptr i64, i64* %r2, i32 0
%r17 = trunc i1920 %r14 to i64
store i64 %r17, i64* %r16
%r18 = lshr i1920 %r14, 64
%r20 = getelementptr i64, i64* %r2, i32 1
%r21 = trunc i1920 %r18 to i64
store i64 %r21, i64* %r20
%r22 = lshr i1920 %r18, 64
%r24 = getelementptr i64, i64* %r2, i32 2
%r25 = trunc i1920 %r22 to i64
store i64 %r25, i64* %r24
%r26 = lshr i1920 %r22, 64
%r28 = getelementptr i64, i64* %r2, i32 3
%r29 = trunc i1920 %r26 to i64
store i64 %r29, i64* %r28
%r30 = lshr i1920 %r26, 64
%r32 = getelementptr i64, i64* %r2, i32 4
%r33 = trunc i1920 %r30 to i64
store i64 %r33, i64* %r32
%r34 = lshr i1920 %r30, 64
%r36 = getelementptr i64, i64* %r2, i32 5
%r37 = trunc i1920 %r34 to i64
store i64 %r37, i64* %r36
%r38 = lshr i1920 %r34, 64
%r40 = getelementptr i64, i64* %r2, i32 6
%r41 = trunc i1920 %r38 to i64
store i64 %r41, i64* %r40
%r42 = lshr i1920 %r38, 64
%r44 = getelementptr i64, i64* %r2, i32 7
%r45 = trunc i1920 %r42 to i64
store i64 %r45, i64* %r44
%r46 = lshr i1920 %r42, 64
%r48 = getelementptr i64, i64* %r2, i32 8
%r49 = trunc i1920 %r46 to i64
store i64 %r49, i64* %r48
%r50 = lshr i1920 %r46, 64
%r52 = getelementptr i64, i64* %r2, i32 9
%r53 = trunc i1920 %r50 to i64
store i64 %r53, i64* %r52
%r54 = lshr i1920 %r50, 64
%r56 = getelementptr i64, i64* %r2, i32 10
%r57 = trunc i1920 %r54 to i64
store i64 %r57, i64* %r56
%r58 = lshr i1920 %r54, 64
%r60 = getelementptr i64, i64* %r2, i32 11
%r61 = trunc i1920 %r58 to i64
store i64 %r61, i64* %r60
%r62 = lshr i1920 %r58, 64
%r64 = getelementptr i64, i64* %r2, i32 12
%r65 = trunc i1920 %r62 to i64
store i64 %r65, i64* %r64
%r66 = lshr i1920 %r62, 64
%r68 = getelementptr i64, i64* %r2, i32 13
%r69 = trunc i1920 %r66 to i64
store i64 %r69, i64* %r68
%r70 = lshr i1920 %r66, 64
%r72 = getelementptr i64, i64* %r2, i32 14
%r73 = trunc i1920 %r70 to i64
store i64 %r73, i64* %r72
%r74 = lshr i1920 %r70, 64
%r76 = getelementptr i64, i64* %r2, i32 15
%r77 = trunc i1920 %r74 to i64
store i64 %r77, i64* %r76
%r78 = lshr i1920 %r74, 64
%r80 = getelementptr i64, i64* %r2, i32 16
%r81 = trunc i1920 %r78 to i64
store i64 %r81, i64* %r80
%r82 = lshr i1920 %r78, 64
%r84 = getelementptr i64, i64* %r2, i32 17
%r85 = trunc i1920 %r82 to i64
store i64 %r85, i64* %r84
%r86 = lshr i1920 %r82, 64
%r88 = getelementptr i64, i64* %r2, i32 18
%r89 = trunc i1920 %r86 to i64
store i64 %r89, i64* %r88
%r90 = lshr i1920 %r86, 64
%r92 = getelementptr i64, i64* %r2, i32 19
%r93 = trunc i1920 %r90 to i64
store i64 %r93, i64* %r92
%r94 = lshr i1920 %r90, 64
%r96 = getelementptr i64, i64* %r2, i32 20
%r97 = trunc i1920 %r94 to i64
store i64 %r97, i64* %r96
%r98 = lshr i1920 %r94, 64
%r100 = getelementptr i64, i64* %r2, i32 21
%r101 = trunc i1920 %r98 to i64
store i64 %r101, i64* %r100
%r102 = lshr i1920 %r98, 64
%r104 = getelementptr i64, i64* %r2, i32 22
%r105 = trunc i1920 %r102 to i64
store i64 %r105, i64* %r104
%r106 = lshr i1920 %r102, 64
%r108 = getelementptr i64, i64* %r2, i32 23
%r109 = trunc i1920 %r106 to i64
store i64 %r109, i64* %r108
%r110 = lshr i1920 %r106, 64
%r112 = getelementptr i64, i64* %r2, i32 24
%r113 = trunc i1920 %r110 to i64
store i64 %r113, i64* %r112
%r114 = lshr i1920 %r110, 64
%r116 = getelementptr i64, i64* %r2, i32 25
%r117 = trunc i1920 %r114 to i64
store i64 %r117, i64* %r116
%r118 = lshr i1920 %r114, 64
%r120 = getelementptr i64, i64* %r2, i32 26
%r121 = trunc i1920 %r118 to i64
store i64 %r121, i64* %r120
%r122 = lshr i1920 %r118, 64
%r124 = getelementptr i64, i64* %r2, i32 27
%r125 = trunc i1920 %r122 to i64
store i64 %r125, i64* %r124
%r126 = lshr i1920 %r122, 64
%r128 = getelementptr i64, i64* %r2, i32 28
%r129 = trunc i1920 %r126 to i64
store i64 %r129, i64* %r128
%r130 = lshr i1920 %r126, 64
%r132 = getelementptr i64, i64* %r2, i32 29
%r133 = trunc i1920 %r130 to i64
store i64 %r133, i64* %r132
%r134 = lshr i1984 %r13, 1920
%r135 = trunc i1984 %r134 to i64
ret i64 %r135
}
define i64 @mclb_sub30(i64* noalias  %r2, i64* noalias  %r3, i64* noalias  %r4)
{
%r6 = bitcast i64* %r3 to i1920*
%r7 = load i1920, i1920* %r6
%r8 = zext i1920 %r7 to i1984
%r10 = bitcast i64* %r4 to i1920*
%r11 = load i1920, i1920* %r10
%r12 = zext i1920 %r11 to i1984
%r13 = sub i1984 %r8, %r12
%r14 = trunc i1984 %r13 to i1920
%r16 = getelementptr i64, i64* %r2, i32 0
%r17 = trunc i1920 %r14 to i64
store i64 %r17, i64* %r16
%r18 = lshr i1920 %r14, 64
%r20 = getelementptr i64, i64* %r2, i32 1
%r21 = trunc i1920 %r18 to i64
store i64 %r21, i64* %r20
%r22 = lshr i1920 %r18, 64
%r24 = getelementptr i64, i64* %r2, i32 2
%r25 = trunc i1920 %r22 to i64
store i64 %r25, i64* %r24
%r26 = lshr i1920 %r22, 64
%r28 = getelementptr i64, i64* %r2, i32 3
%r29 = trunc i1920 %r26 to i64
store i64 %r29, i64* %r28
%r30 = lshr i1920 %r26, 64
%r32 = getelementptr i64, i64* %r2, i32 4
%r33 = trunc i1920 %r30 to i64
store i64 %r33, i64* %r32
%r34 = lshr i1920 %r30, 64
%r36 = getelementptr i64, i64* %r2, i32 5
%r37 = trunc i1920 %r34 to i64
store i64 %r37, i64* %r36
%r38 = lshr i1920 %r34, 64
%r40 = getelementptr i64, i64* %r2, i32 6
%r41 = trunc i1920 %r38 to i64
store i64 %r41, i64* %r40
%r42 = lshr i1920 %r38, 64
%r44 = getelementptr i64, i64* %r2, i32 7
%r45 = trunc i1920 %r42 to i64
store i64 %r45, i64* %r44
%r46 = lshr i1920 %r42, 64
%r48 = getelementptr i64, i64* %r2, i32 8
%r49 = trunc i1920 %r46 to i64
store i64 %r49, i64* %r48
%r50 = lshr i1920 %r46, 64
%r52 = getelementptr i64, i64* %r2, i32 9
%r53 = trunc i1920 %r50 to i64
store i64 %r53, i64* %r52
%r54 = lshr i1920 %r50, 64
%r56 = getelementptr i64, i64* %r2, i32 10
%r57 = trunc i1920 %r54 to i64
store i64 %r57, i64* %r56
%r58 = lshr i1920 %r54, 64
%r60 = getelementptr i64, i64* %r2, i32 11
%r61 = trunc i1920 %r58 to i64
store i64 %r61, i64* %r60
%r62 = lshr i1920 %r58, 64
%r64 = getelementptr i64, i64* %r2, i32 12
%r65 = trunc i1920 %r62 to i64
store i64 %r65, i64* %r64
%r66 = lshr i1920 %r62, 64
%r68 = getelementptr i64, i64* %r2, i32 13
%r69 = trunc i1920 %r66 to i64
store i64 %r69, i64* %r68
%r70 = lshr i1920 %r66, 64
%r72 = getelementptr i64, i64* %r2, i32 14
%r73 = trunc i1920 %r70 to i64
store i64 %r73, i64* %r72
%r74 = lshr i1920 %r70, 64
%r76 = getelementptr i64, i64* %r2, i32 15
%r77 = trunc i1920 %r74 to i64
store i64 %r77, i64* %r76
%r78 = lshr i1920 %r74, 64
%r80 = getelementptr i64, i64* %r2, i32 16
%r81 = trunc i1920 %r78 to i64
store i64 %r81, i64* %r80
%r82 = lshr i1920 %r78, 64
%r84 = getelementptr i64, i64* %r2, i32 17
%r85 = trunc i1920 %r82 to i64
store i64 %r85, i64* %r84
%r86 = lshr i1920 %r82, 64
%r88 = getelementptr i64, i64* %r2, i32 18
%r89 = trunc i1920 %r86 to i64
store i64 %r89, i64* %r88
%r90 = lshr i1920 %r86, 64
%r92 = getelementptr i64, i64* %r2, i32 19
%r93 = trunc i1920 %r90 to i64
store i64 %r93, i64* %r92
%r94 = lshr i1920 %r90, 64
%r96 = getelementptr i64, i64* %r2, i32 20
%r97 = trunc i1920 %r94 to i64
store i64 %r97, i64* %r96
%r98 = lshr i1920 %r94, 64
%r100 = getelementptr i64, i64* %r2, i32 21
%r101 = trunc i1920 %r98 to i64
store i64 %r101, i64* %r100
%r102 = lshr i1920 %r98, 64
%r104 = getelementptr i64, i64* %r2, i32 22
%r105 = trunc i1920 %r102 to i64
store i64 %r105, i64* %r104
%r106 = lshr i1920 %r102, 64
%r108 = getelementptr i64, i64* %r2, i32 23
%r109 = trunc i1920 %r106 to i64
store i64 %r109, i64* %r108
%r110 = lshr i1920 %r106, 64
%r112 = getelementptr i64, i64* %r2, i32 24
%r113 = trunc i1920 %r110 to i64
store i64 %r113, i64* %r112
%r114 = lshr i1920 %r110, 64
%r116 = getelementptr i64, i64* %r2, i32 25
%r117 = trunc i1920 %r114 to i64
store i64 %r117, i64* %r116
%r118 = lshr i1920 %r114, 64
%r120 = getelementptr i64, i64* %r2, i32 26
%r121 = trunc i1920 %r118 to i64
store i64 %r121, i64* %r120
%r122 = lshr i1920 %r118, 64
%r124 = getelementptr i64, i64* %r2, i32 27
%r125 = trunc i1920 %r122 to i64
store i64 %r125, i64* %r124
%r126 = lshr i1920 %r122, 64
%r128 = getelementptr i64, i64* %r2, i32 28
%r129 = trunc i1920 %r126 to i64
store i64 %r129, i64* %r128
%r130 = lshr i1920 %r126, 64
%r132 = getelementptr i64, i64* %r2, i32 29
%r133 = trunc i1920 %r130 to i64
store i64 %r133, i64* %r132
%r134 = lshr i1984 %r13, 1920
%r135 = trunc i1984 %r134 to i64
%r137 = and i64 %r135, 1
ret i64 %r137
}
define void @mclb_addNF30(i64* noalias  %r1, i64* noalias  %r2, i64* noalias  %r3)
{
%r5 = bitcast i64* %r2 to i1920*
%r6 = load i1920, i1920* %r5
%r8 = bitcast i64* %r3 to i1920*
%r9 = load i1920, i1920* %r8
%r10 = add i1920 %r6, %r9
%r12 = getelementptr i64, i64* %r1, i32 0
%r13 = trunc i1920 %r10 to i64
store i64 %r13, i64* %r12
%r14 = lshr i1920 %r10, 64
%r16 = getelementptr i64, i64* %r1, i32 1
%r17 = trunc i1920 %r14 to i64
store i64 %r17, i64* %r16
%r18 = lshr i1920 %r14, 64
%r20 = getelementptr i64, i64* %r1, i32 2
%r21 = trunc i1920 %r18 to i64
store i64 %r21, i64* %r20
%r22 = lshr i1920 %r18, 64
%r24 = getelementptr i64, i64* %r1, i32 3
%r25 = trunc i1920 %r22 to i64
store i64 %r25, i64* %r24
%r26 = lshr i1920 %r22, 64
%r28 = getelementptr i64, i64* %r1, i32 4
%r29 = trunc i1920 %r26 to i64
store i64 %r29, i64* %r28
%r30 = lshr i1920 %r26, 64
%r32 = getelementptr i64, i64* %r1, i32 5
%r33 = trunc i1920 %r30 to i64
store i64 %r33, i64* %r32
%r34 = lshr i1920 %r30, 64
%r36 = getelementptr i64, i64* %r1, i32 6
%r37 = trunc i1920 %r34 to i64
store i64 %r37, i64* %r36
%r38 = lshr i1920 %r34, 64
%r40 = getelementptr i64, i64* %r1, i32 7
%r41 = trunc i1920 %r38 to i64
store i64 %r41, i64* %r40
%r42 = lshr i1920 %r38, 64
%r44 = getelementptr i64, i64* %r1, i32 8
%r45 = trunc i1920 %r42 to i64
store i64 %r45, i64* %r44
%r46 = lshr i1920 %r42, 64
%r48 = getelementptr i64, i64* %r1, i32 9
%r49 = trunc i1920 %r46 to i64
store i64 %r49, i64* %r48
%r50 = lshr i1920 %r46, 64
%r52 = getelementptr i64, i64* %r1, i32 10
%r53 = trunc i1920 %r50 to i64
store i64 %r53, i64* %r52
%r54 = lshr i1920 %r50, 64
%r56 = getelementptr i64, i64* %r1, i32 11
%r57 = trunc i1920 %r54 to i64
store i64 %r57, i64* %r56
%r58 = lshr i1920 %r54, 64
%r60 = getelementptr i64, i64* %r1, i32 12
%r61 = trunc i1920 %r58 to i64
store i64 %r61, i64* %r60
%r62 = lshr i1920 %r58, 64
%r64 = getelementptr i64, i64* %r1, i32 13
%r65 = trunc i1920 %r62 to i64
store i64 %r65, i64* %r64
%r66 = lshr i1920 %r62, 64
%r68 = getelementptr i64, i64* %r1, i32 14
%r69 = trunc i1920 %r66 to i64
store i64 %r69, i64* %r68
%r70 = lshr i1920 %r66, 64
%r72 = getelementptr i64, i64* %r1, i32 15
%r73 = trunc i1920 %r70 to i64
store i64 %r73, i64* %r72
%r74 = lshr i1920 %r70, 64
%r76 = getelementptr i64, i64* %r1, i32 16
%r77 = trunc i1920 %r74 to i64
store i64 %r77, i64* %r76
%r78 = lshr i1920 %r74, 64
%r80 = getelementptr i64, i64* %r1, i32 17
%r81 = trunc i1920 %r78 to i64
store i64 %r81, i64* %r80
%r82 = lshr i1920 %r78, 64
%r84 = getelementptr i64, i64* %r1, i32 18
%r85 = trunc i1920 %r82 to i64
store i64 %r85, i64* %r84
%r86 = lshr i1920 %r82, 64
%r88 = getelementptr i64, i64* %r1, i32 19
%r89 = trunc i1920 %r86 to i64
store i64 %r89, i64* %r88
%r90 = lshr i1920 %r86, 64
%r92 = getelementptr i64, i64* %r1, i32 20
%r93 = trunc i1920 %r90 to i64
store i64 %r93, i64* %r92
%r94 = lshr i1920 %r90, 64
%r96 = getelementptr i64, i64* %r1, i32 21
%r97 = trunc i1920 %r94 to i64
store i64 %r97, i64* %r96
%r98 = lshr i1920 %r94, 64
%r100 = getelementptr i64, i64* %r1, i32 22
%r101 = trunc i1920 %r98 to i64
store i64 %r101, i64* %r100
%r102 = lshr i1920 %r98, 64
%r104 = getelementptr i64, i64* %r1, i32 23
%r105 = trunc i1920 %r102 to i64
store i64 %r105, i64* %r104
%r106 = lshr i1920 %r102, 64
%r108 = getelementptr i64, i64* %r1, i32 24
%r109 = trunc i1920 %r106 to i64
store i64 %r109, i64* %r108
%r110 = lshr i1920 %r106, 64
%r112 = getelementptr i64, i64* %r1, i32 25
%r113 = trunc i1920 %r110 to i64
store i64 %r113, i64* %r112
%r114 = lshr i1920 %r110, 64
%r116 = getelementptr i64, i64* %r1, i32 26
%r117 = trunc i1920 %r114 to i64
store i64 %r117, i64* %r116
%r118 = lshr i1920 %r114, 64
%r120 = getelementptr i64, i64* %r1, i32 27
%r121 = trunc i1920 %r118 to i64
store i64 %r121, i64* %r120
%r122 = lshr i1920 %r118, 64
%r124 = getelementptr i64, i64* %r1, i32 28
%r125 = trunc i1920 %r122 to i64
store i64 %r125, i64* %r124
%r126 = lshr i1920 %r122, 64
%r128 = getelementptr i64, i64* %r1, i32 29
%r129 = trunc i1920 %r126 to i64
store i64 %r129, i64* %r128
ret void
}
define i64 @mclb_subNF30(i64* noalias  %r2, i64* noalias  %r3, i64* noalias  %r4)
{
%r6 = bitcast i64* %r3 to i1920*
%r7 = load i1920, i1920* %r6
%r9 = bitcast i64* %r4 to i1920*
%r10 = load i1920, i1920* %r9
%r11 = sub i1920 %r7, %r10
%r13 = getelementptr i64, i64* %r2, i32 0
%r14 = trunc i1920 %r11 to i64
store i64 %r14, i64* %r13
%r15 = lshr i1920 %r11, 64
%r17 = getelementptr i64, i64* %r2, i32 1
%r18 = trunc i1920 %r15 to i64
store i64 %r18, i64* %r17
%r19 = lshr i1920 %r15, 64
%r21 = getelementptr i64, i64* %r2, i32 2
%r22 = trunc i1920 %r19 to i64
store i64 %r22, i64* %r21
%r23 = lshr i1920 %r19, 64
%r25 = getelementptr i64, i64* %r2, i32 3
%r26 = trunc i1920 %r23 to i64
store i64 %r26, i64* %r25
%r27 = lshr i1920 %r23, 64
%r29 = getelementptr i64, i64* %r2, i32 4
%r30 = trunc i1920 %r27 to i64
store i64 %r30, i64* %r29
%r31 = lshr i1920 %r27, 64
%r33 = getelementptr i64, i64* %r2, i32 5
%r34 = trunc i1920 %r31 to i64
store i64 %r34, i64* %r33
%r35 = lshr i1920 %r31, 64
%r37 = getelementptr i64, i64* %r2, i32 6
%r38 = trunc i1920 %r35 to i64
store i64 %r38, i64* %r37
%r39 = lshr i1920 %r35, 64
%r41 = getelementptr i64, i64* %r2, i32 7
%r42 = trunc i1920 %r39 to i64
store i64 %r42, i64* %r41
%r43 = lshr i1920 %r39, 64
%r45 = getelementptr i64, i64* %r2, i32 8
%r46 = trunc i1920 %r43 to i64
store i64 %r46, i64* %r45
%r47 = lshr i1920 %r43, 64
%r49 = getelementptr i64, i64* %r2, i32 9
%r50 = trunc i1920 %r47 to i64
store i64 %r50, i64* %r49
%r51 = lshr i1920 %r47, 64
%r53 = getelementptr i64, i64* %r2, i32 10
%r54 = trunc i1920 %r51 to i64
store i64 %r54, i64* %r53
%r55 = lshr i1920 %r51, 64
%r57 = getelementptr i64, i64* %r2, i32 11
%r58 = trunc i1920 %r55 to i64
store i64 %r58, i64* %r57
%r59 = lshr i1920 %r55, 64
%r61 = getelementptr i64, i64* %r2, i32 12
%r62 = trunc i1920 %r59 to i64
store i64 %r62, i64* %r61
%r63 = lshr i1920 %r59, 64
%r65 = getelementptr i64, i64* %r2, i32 13
%r66 = trunc i1920 %r63 to i64
store i64 %r66, i64* %r65
%r67 = lshr i1920 %r63, 64
%r69 = getelementptr i64, i64* %r2, i32 14
%r70 = trunc i1920 %r67 to i64
store i64 %r70, i64* %r69
%r71 = lshr i1920 %r67, 64
%r73 = getelementptr i64, i64* %r2, i32 15
%r74 = trunc i1920 %r71 to i64
store i64 %r74, i64* %r73
%r75 = lshr i1920 %r71, 64
%r77 = getelementptr i64, i64* %r2, i32 16
%r78 = trunc i1920 %r75 to i64
store i64 %r78, i64* %r77
%r79 = lshr i1920 %r75, 64
%r81 = getelementptr i64, i64* %r2, i32 17
%r82 = trunc i1920 %r79 to i64
store i64 %r82, i64* %r81
%r83 = lshr i1920 %r79, 64
%r85 = getelementptr i64, i64* %r2, i32 18
%r86 = trunc i1920 %r83 to i64
store i64 %r86, i64* %r85
%r87 = lshr i1920 %r83, 64
%r89 = getelementptr i64, i64* %r2, i32 19
%r90 = trunc i1920 %r87 to i64
store i64 %r90, i64* %r89
%r91 = lshr i1920 %r87, 64
%r93 = getelementptr i64, i64* %r2, i32 20
%r94 = trunc i1920 %r91 to i64
store i64 %r94, i64* %r93
%r95 = lshr i1920 %r91, 64
%r97 = getelementptr i64, i64* %r2, i32 21
%r98 = trunc i1920 %r95 to i64
store i64 %r98, i64* %r97
%r99 = lshr i1920 %r95, 64
%r101 = getelementptr i64, i64* %r2, i32 22
%r102 = trunc i1920 %r99 to i64
store i64 %r102, i64* %r101
%r103 = lshr i1920 %r99, 64
%r105 = getelementptr i64, i64* %r2, i32 23
%r106 = trunc i1920 %r103 to i64
store i64 %r106, i64* %r105
%r107 = lshr i1920 %r103, 64
%r109 = getelementptr i64, i64* %r2, i32 24
%r110 = trunc i1920 %r107 to i64
store i64 %r110, i64* %r109
%r111 = lshr i1920 %r107, 64
%r113 = getelementptr i64, i64* %r2, i32 25
%r114 = trunc i1920 %r111 to i64
store i64 %r114, i64* %r113
%r115 = lshr i1920 %r111, 64
%r117 = getelementptr i64, i64* %r2, i32 26
%r118 = trunc i1920 %r115 to i64
store i64 %r118, i64* %r117
%r119 = lshr i1920 %r115, 64
%r121 = getelementptr i64, i64* %r2, i32 27
%r122 = trunc i1920 %r119 to i64
store i64 %r122, i64* %r121
%r123 = lshr i1920 %r119, 64
%r125 = getelementptr i64, i64* %r2, i32 28
%r126 = trunc i1920 %r123 to i64
store i64 %r126, i64* %r125
%r127 = lshr i1920 %r123, 64
%r129 = getelementptr i64, i64* %r2, i32 29
%r130 = trunc i1920 %r127 to i64
store i64 %r130, i64* %r129
%r131 = lshr i1920 %r11, 1919
%r132 = trunc i1920 %r131 to i64
%r134 = and i64 %r132, 1
ret i64 %r134
}
define i64 @mclb_add31(i64* noalias  %r2, i64* noalias  %r3, i64* noalias  %r4)
{
%r6 = bitcast i64* %r3 to i1984*
%r7 = load i1984, i1984* %r6
%r8 = zext i1984 %r7 to i2048
%r10 = bitcast i64* %r4 to i1984*
%r11 = load i1984, i1984* %r10
%r12 = zext i1984 %r11 to i2048
%r13 = add i2048 %r8, %r12
%r14 = trunc i2048 %r13 to i1984
%r16 = getelementptr i64, i64* %r2, i32 0
%r17 = trunc i1984 %r14 to i64
store i64 %r17, i64* %r16
%r18 = lshr i1984 %r14, 64
%r20 = getelementptr i64, i64* %r2, i32 1
%r21 = trunc i1984 %r18 to i64
store i64 %r21, i64* %r20
%r22 = lshr i1984 %r18, 64
%r24 = getelementptr i64, i64* %r2, i32 2
%r25 = trunc i1984 %r22 to i64
store i64 %r25, i64* %r24
%r26 = lshr i1984 %r22, 64
%r28 = getelementptr i64, i64* %r2, i32 3
%r29 = trunc i1984 %r26 to i64
store i64 %r29, i64* %r28
%r30 = lshr i1984 %r26, 64
%r32 = getelementptr i64, i64* %r2, i32 4
%r33 = trunc i1984 %r30 to i64
store i64 %r33, i64* %r32
%r34 = lshr i1984 %r30, 64
%r36 = getelementptr i64, i64* %r2, i32 5
%r37 = trunc i1984 %r34 to i64
store i64 %r37, i64* %r36
%r38 = lshr i1984 %r34, 64
%r40 = getelementptr i64, i64* %r2, i32 6
%r41 = trunc i1984 %r38 to i64
store i64 %r41, i64* %r40
%r42 = lshr i1984 %r38, 64
%r44 = getelementptr i64, i64* %r2, i32 7
%r45 = trunc i1984 %r42 to i64
store i64 %r45, i64* %r44
%r46 = lshr i1984 %r42, 64
%r48 = getelementptr i64, i64* %r2, i32 8
%r49 = trunc i1984 %r46 to i64
store i64 %r49, i64* %r48
%r50 = lshr i1984 %r46, 64
%r52 = getelementptr i64, i64* %r2, i32 9
%r53 = trunc i1984 %r50 to i64
store i64 %r53, i64* %r52
%r54 = lshr i1984 %r50, 64
%r56 = getelementptr i64, i64* %r2, i32 10
%r57 = trunc i1984 %r54 to i64
store i64 %r57, i64* %r56
%r58 = lshr i1984 %r54, 64
%r60 = getelementptr i64, i64* %r2, i32 11
%r61 = trunc i1984 %r58 to i64
store i64 %r61, i64* %r60
%r62 = lshr i1984 %r58, 64
%r64 = getelementptr i64, i64* %r2, i32 12
%r65 = trunc i1984 %r62 to i64
store i64 %r65, i64* %r64
%r66 = lshr i1984 %r62, 64
%r68 = getelementptr i64, i64* %r2, i32 13
%r69 = trunc i1984 %r66 to i64
store i64 %r69, i64* %r68
%r70 = lshr i1984 %r66, 64
%r72 = getelementptr i64, i64* %r2, i32 14
%r73 = trunc i1984 %r70 to i64
store i64 %r73, i64* %r72
%r74 = lshr i1984 %r70, 64
%r76 = getelementptr i64, i64* %r2, i32 15
%r77 = trunc i1984 %r74 to i64
store i64 %r77, i64* %r76
%r78 = lshr i1984 %r74, 64
%r80 = getelementptr i64, i64* %r2, i32 16
%r81 = trunc i1984 %r78 to i64
store i64 %r81, i64* %r80
%r82 = lshr i1984 %r78, 64
%r84 = getelementptr i64, i64* %r2, i32 17
%r85 = trunc i1984 %r82 to i64
store i64 %r85, i64* %r84
%r86 = lshr i1984 %r82, 64
%r88 = getelementptr i64, i64* %r2, i32 18
%r89 = trunc i1984 %r86 to i64
store i64 %r89, i64* %r88
%r90 = lshr i1984 %r86, 64
%r92 = getelementptr i64, i64* %r2, i32 19
%r93 = trunc i1984 %r90 to i64
store i64 %r93, i64* %r92
%r94 = lshr i1984 %r90, 64
%r96 = getelementptr i64, i64* %r2, i32 20
%r97 = trunc i1984 %r94 to i64
store i64 %r97, i64* %r96
%r98 = lshr i1984 %r94, 64
%r100 = getelementptr i64, i64* %r2, i32 21
%r101 = trunc i1984 %r98 to i64
store i64 %r101, i64* %r100
%r102 = lshr i1984 %r98, 64
%r104 = getelementptr i64, i64* %r2, i32 22
%r105 = trunc i1984 %r102 to i64
store i64 %r105, i64* %r104
%r106 = lshr i1984 %r102, 64
%r108 = getelementptr i64, i64* %r2, i32 23
%r109 = trunc i1984 %r106 to i64
store i64 %r109, i64* %r108
%r110 = lshr i1984 %r106, 64
%r112 = getelementptr i64, i64* %r2, i32 24
%r113 = trunc i1984 %r110 to i64
store i64 %r113, i64* %r112
%r114 = lshr i1984 %r110, 64
%r116 = getelementptr i64, i64* %r2, i32 25
%r117 = trunc i1984 %r114 to i64
store i64 %r117, i64* %r116
%r118 = lshr i1984 %r114, 64
%r120 = getelementptr i64, i64* %r2, i32 26
%r121 = trunc i1984 %r118 to i64
store i64 %r121, i64* %r120
%r122 = lshr i1984 %r118, 64
%r124 = getelementptr i64, i64* %r2, i32 27
%r125 = trunc i1984 %r122 to i64
store i64 %r125, i64* %r124
%r126 = lshr i1984 %r122, 64
%r128 = getelementptr i64, i64* %r2, i32 28
%r129 = trunc i1984 %r126 to i64
store i64 %r129, i64* %r128
%r130 = lshr i1984 %r126, 64
%r132 = getelementptr i64, i64* %r2, i32 29
%r133 = trunc i1984 %r130 to i64
store i64 %r133, i64* %r132
%r134 = lshr i1984 %r130, 64
%r136 = getelementptr i64, i64* %r2, i32 30
%r137 = trunc i1984 %r134 to i64
store i64 %r137, i64* %r136
%r138 = lshr i2048 %r13, 1984
%r139 = trunc i2048 %r138 to i64
ret i64 %r139
}
define i64 @mclb_sub31(i64* noalias  %r2, i64* noalias  %r3, i64* noalias  %r4)
{
%r6 = bitcast i64* %r3 to i1984*
%r7 = load i1984, i1984* %r6
%r8 = zext i1984 %r7 to i2048
%r10 = bitcast i64* %r4 to i1984*
%r11 = load i1984, i1984* %r10
%r12 = zext i1984 %r11 to i2048
%r13 = sub i2048 %r8, %r12
%r14 = trunc i2048 %r13 to i1984
%r16 = getelementptr i64, i64* %r2, i32 0
%r17 = trunc i1984 %r14 to i64
store i64 %r17, i64* %r16
%r18 = lshr i1984 %r14, 64
%r20 = getelementptr i64, i64* %r2, i32 1
%r21 = trunc i1984 %r18 to i64
store i64 %r21, i64* %r20
%r22 = lshr i1984 %r18, 64
%r24 = getelementptr i64, i64* %r2, i32 2
%r25 = trunc i1984 %r22 to i64
store i64 %r25, i64* %r24
%r26 = lshr i1984 %r22, 64
%r28 = getelementptr i64, i64* %r2, i32 3
%r29 = trunc i1984 %r26 to i64
store i64 %r29, i64* %r28
%r30 = lshr i1984 %r26, 64
%r32 = getelementptr i64, i64* %r2, i32 4
%r33 = trunc i1984 %r30 to i64
store i64 %r33, i64* %r32
%r34 = lshr i1984 %r30, 64
%r36 = getelementptr i64, i64* %r2, i32 5
%r37 = trunc i1984 %r34 to i64
store i64 %r37, i64* %r36
%r38 = lshr i1984 %r34, 64
%r40 = getelementptr i64, i64* %r2, i32 6
%r41 = trunc i1984 %r38 to i64
store i64 %r41, i64* %r40
%r42 = lshr i1984 %r38, 64
%r44 = getelementptr i64, i64* %r2, i32 7
%r45 = trunc i1984 %r42 to i64
store i64 %r45, i64* %r44
%r46 = lshr i1984 %r42, 64
%r48 = getelementptr i64, i64* %r2, i32 8
%r49 = trunc i1984 %r46 to i64
store i64 %r49, i64* %r48
%r50 = lshr i1984 %r46, 64
%r52 = getelementptr i64, i64* %r2, i32 9
%r53 = trunc i1984 %r50 to i64
store i64 %r53, i64* %r52
%r54 = lshr i1984 %r50, 64
%r56 = getelementptr i64, i64* %r2, i32 10
%r57 = trunc i1984 %r54 to i64
store i64 %r57, i64* %r56
%r58 = lshr i1984 %r54, 64
%r60 = getelementptr i64, i64* %r2, i32 11
%r61 = trunc i1984 %r58 to i64
store i64 %r61, i64* %r60
%r62 = lshr i1984 %r58, 64
%r64 = getelementptr i64, i64* %r2, i32 12
%r65 = trunc i1984 %r62 to i64
store i64 %r65, i64* %r64
%r66 = lshr i1984 %r62, 64
%r68 = getelementptr i64, i64* %r2, i32 13
%r69 = trunc i1984 %r66 to i64
store i64 %r69, i64* %r68
%r70 = lshr i1984 %r66, 64
%r72 = getelementptr i64, i64* %r2, i32 14
%r73 = trunc i1984 %r70 to i64
store i64 %r73, i64* %r72
%r74 = lshr i1984 %r70, 64
%r76 = getelementptr i64, i64* %r2, i32 15
%r77 = trunc i1984 %r74 to i64
store i64 %r77, i64* %r76
%r78 = lshr i1984 %r74, 64
%r80 = getelementptr i64, i64* %r2, i32 16
%r81 = trunc i1984 %r78 to i64
store i64 %r81, i64* %r80
%r82 = lshr i1984 %r78, 64
%r84 = getelementptr i64, i64* %r2, i32 17
%r85 = trunc i1984 %r82 to i64
store i64 %r85, i64* %r84
%r86 = lshr i1984 %r82, 64
%r88 = getelementptr i64, i64* %r2, i32 18
%r89 = trunc i1984 %r86 to i64
store i64 %r89, i64* %r88
%r90 = lshr i1984 %r86, 64
%r92 = getelementptr i64, i64* %r2, i32 19
%r93 = trunc i1984 %r90 to i64
store i64 %r93, i64* %r92
%r94 = lshr i1984 %r90, 64
%r96 = getelementptr i64, i64* %r2, i32 20
%r97 = trunc i1984 %r94 to i64
store i64 %r97, i64* %r96
%r98 = lshr i1984 %r94, 64
%r100 = getelementptr i64, i64* %r2, i32 21
%r101 = trunc i1984 %r98 to i64
store i64 %r101, i64* %r100
%r102 = lshr i1984 %r98, 64
%r104 = getelementptr i64, i64* %r2, i32 22
%r105 = trunc i1984 %r102 to i64
store i64 %r105, i64* %r104
%r106 = lshr i1984 %r102, 64
%r108 = getelementptr i64, i64* %r2, i32 23
%r109 = trunc i1984 %r106 to i64
store i64 %r109, i64* %r108
%r110 = lshr i1984 %r106, 64
%r112 = getelementptr i64, i64* %r2, i32 24
%r113 = trunc i1984 %r110 to i64
store i64 %r113, i64* %r112
%r114 = lshr i1984 %r110, 64
%r116 = getelementptr i64, i64* %r2, i32 25
%r117 = trunc i1984 %r114 to i64
store i64 %r117, i64* %r116
%r118 = lshr i1984 %r114, 64
%r120 = getelementptr i64, i64* %r2, i32 26
%r121 = trunc i1984 %r118 to i64
store i64 %r121, i64* %r120
%r122 = lshr i1984 %r118, 64
%r124 = getelementptr i64, i64* %r2, i32 27
%r125 = trunc i1984 %r122 to i64
store i64 %r125, i64* %r124
%r126 = lshr i1984 %r122, 64
%r128 = getelementptr i64, i64* %r2, i32 28
%r129 = trunc i1984 %r126 to i64
store i64 %r129, i64* %r128
%r130 = lshr i1984 %r126, 64
%r132 = getelementptr i64, i64* %r2, i32 29
%r133 = trunc i1984 %r130 to i64
store i64 %r133, i64* %r132
%r134 = lshr i1984 %r130, 64
%r136 = getelementptr i64, i64* %r2, i32 30
%r137 = trunc i1984 %r134 to i64
store i64 %r137, i64* %r136
%r138 = lshr i2048 %r13, 1984
%r139 = trunc i2048 %r138 to i64
%r141 = and i64 %r139, 1
ret i64 %r141
}
define void @mclb_addNF31(i64* noalias  %r1, i64* noalias  %r2, i64* noalias  %r3)
{
%r5 = bitcast i64* %r2 to i1984*
%r6 = load i1984, i1984* %r5
%r8 = bitcast i64* %r3 to i1984*
%r9 = load i1984, i1984* %r8
%r10 = add i1984 %r6, %r9
%r12 = getelementptr i64, i64* %r1, i32 0
%r13 = trunc i1984 %r10 to i64
store i64 %r13, i64* %r12
%r14 = lshr i1984 %r10, 64
%r16 = getelementptr i64, i64* %r1, i32 1
%r17 = trunc i1984 %r14 to i64
store i64 %r17, i64* %r16
%r18 = lshr i1984 %r14, 64
%r20 = getelementptr i64, i64* %r1, i32 2
%r21 = trunc i1984 %r18 to i64
store i64 %r21, i64* %r20
%r22 = lshr i1984 %r18, 64
%r24 = getelementptr i64, i64* %r1, i32 3
%r25 = trunc i1984 %r22 to i64
store i64 %r25, i64* %r24
%r26 = lshr i1984 %r22, 64
%r28 = getelementptr i64, i64* %r1, i32 4
%r29 = trunc i1984 %r26 to i64
store i64 %r29, i64* %r28
%r30 = lshr i1984 %r26, 64
%r32 = getelementptr i64, i64* %r1, i32 5
%r33 = trunc i1984 %r30 to i64
store i64 %r33, i64* %r32
%r34 = lshr i1984 %r30, 64
%r36 = getelementptr i64, i64* %r1, i32 6
%r37 = trunc i1984 %r34 to i64
store i64 %r37, i64* %r36
%r38 = lshr i1984 %r34, 64
%r40 = getelementptr i64, i64* %r1, i32 7
%r41 = trunc i1984 %r38 to i64
store i64 %r41, i64* %r40
%r42 = lshr i1984 %r38, 64
%r44 = getelementptr i64, i64* %r1, i32 8
%r45 = trunc i1984 %r42 to i64
store i64 %r45, i64* %r44
%r46 = lshr i1984 %r42, 64
%r48 = getelementptr i64, i64* %r1, i32 9
%r49 = trunc i1984 %r46 to i64
store i64 %r49, i64* %r48
%r50 = lshr i1984 %r46, 64
%r52 = getelementptr i64, i64* %r1, i32 10
%r53 = trunc i1984 %r50 to i64
store i64 %r53, i64* %r52
%r54 = lshr i1984 %r50, 64
%r56 = getelementptr i64, i64* %r1, i32 11
%r57 = trunc i1984 %r54 to i64
store i64 %r57, i64* %r56
%r58 = lshr i1984 %r54, 64
%r60 = getelementptr i64, i64* %r1, i32 12
%r61 = trunc i1984 %r58 to i64
store i64 %r61, i64* %r60
%r62 = lshr i1984 %r58, 64
%r64 = getelementptr i64, i64* %r1, i32 13
%r65 = trunc i1984 %r62 to i64
store i64 %r65, i64* %r64
%r66 = lshr i1984 %r62, 64
%r68 = getelementptr i64, i64* %r1, i32 14
%r69 = trunc i1984 %r66 to i64
store i64 %r69, i64* %r68
%r70 = lshr i1984 %r66, 64
%r72 = getelementptr i64, i64* %r1, i32 15
%r73 = trunc i1984 %r70 to i64
store i64 %r73, i64* %r72
%r74 = lshr i1984 %r70, 64
%r76 = getelementptr i64, i64* %r1, i32 16
%r77 = trunc i1984 %r74 to i64
store i64 %r77, i64* %r76
%r78 = lshr i1984 %r74, 64
%r80 = getelementptr i64, i64* %r1, i32 17
%r81 = trunc i1984 %r78 to i64
store i64 %r81, i64* %r80
%r82 = lshr i1984 %r78, 64
%r84 = getelementptr i64, i64* %r1, i32 18
%r85 = trunc i1984 %r82 to i64
store i64 %r85, i64* %r84
%r86 = lshr i1984 %r82, 64
%r88 = getelementptr i64, i64* %r1, i32 19
%r89 = trunc i1984 %r86 to i64
store i64 %r89, i64* %r88
%r90 = lshr i1984 %r86, 64
%r92 = getelementptr i64, i64* %r1, i32 20
%r93 = trunc i1984 %r90 to i64
store i64 %r93, i64* %r92
%r94 = lshr i1984 %r90, 64
%r96 = getelementptr i64, i64* %r1, i32 21
%r97 = trunc i1984 %r94 to i64
store i64 %r97, i64* %r96
%r98 = lshr i1984 %r94, 64
%r100 = getelementptr i64, i64* %r1, i32 22
%r101 = trunc i1984 %r98 to i64
store i64 %r101, i64* %r100
%r102 = lshr i1984 %r98, 64
%r104 = getelementptr i64, i64* %r1, i32 23
%r105 = trunc i1984 %r102 to i64
store i64 %r105, i64* %r104
%r106 = lshr i1984 %r102, 64
%r108 = getelementptr i64, i64* %r1, i32 24
%r109 = trunc i1984 %r106 to i64
store i64 %r109, i64* %r108
%r110 = lshr i1984 %r106, 64
%r112 = getelementptr i64, i64* %r1, i32 25
%r113 = trunc i1984 %r110 to i64
store i64 %r113, i64* %r112
%r114 = lshr i1984 %r110, 64
%r116 = getelementptr i64, i64* %r1, i32 26
%r117 = trunc i1984 %r114 to i64
store i64 %r117, i64* %r116
%r118 = lshr i1984 %r114, 64
%r120 = getelementptr i64, i64* %r1, i32 27
%r121 = trunc i1984 %r118 to i64
store i64 %r121, i64* %r120
%r122 = lshr i1984 %r118, 64
%r124 = getelementptr i64, i64* %r1, i32 28
%r125 = trunc i1984 %r122 to i64
store i64 %r125, i64* %r124
%r126 = lshr i1984 %r122, 64
%r128 = getelementptr i64, i64* %r1, i32 29
%r129 = trunc i1984 %r126 to i64
store i64 %r129, i64* %r128
%r130 = lshr i1984 %r126, 64
%r132 = getelementptr i64, i64* %r1, i32 30
%r133 = trunc i1984 %r130 to i64
store i64 %r133, i64* %r132
ret void
}
define i64 @mclb_subNF31(i64* noalias  %r2, i64* noalias  %r3, i64* noalias  %r4)
{
%r6 = bitcast i64* %r3 to i1984*
%r7 = load i1984, i1984* %r6
%r9 = bitcast i64* %r4 to i1984*
%r10 = load i1984, i1984* %r9
%r11 = sub i1984 %r7, %r10
%r13 = getelementptr i64, i64* %r2, i32 0
%r14 = trunc i1984 %r11 to i64
store i64 %r14, i64* %r13
%r15 = lshr i1984 %r11, 64
%r17 = getelementptr i64, i64* %r2, i32 1
%r18 = trunc i1984 %r15 to i64
store i64 %r18, i64* %r17
%r19 = lshr i1984 %r15, 64
%r21 = getelementptr i64, i64* %r2, i32 2
%r22 = trunc i1984 %r19 to i64
store i64 %r22, i64* %r21
%r23 = lshr i1984 %r19, 64
%r25 = getelementptr i64, i64* %r2, i32 3
%r26 = trunc i1984 %r23 to i64
store i64 %r26, i64* %r25
%r27 = lshr i1984 %r23, 64
%r29 = getelementptr i64, i64* %r2, i32 4
%r30 = trunc i1984 %r27 to i64
store i64 %r30, i64* %r29
%r31 = lshr i1984 %r27, 64
%r33 = getelementptr i64, i64* %r2, i32 5
%r34 = trunc i1984 %r31 to i64
store i64 %r34, i64* %r33
%r35 = lshr i1984 %r31, 64
%r37 = getelementptr i64, i64* %r2, i32 6
%r38 = trunc i1984 %r35 to i64
store i64 %r38, i64* %r37
%r39 = lshr i1984 %r35, 64
%r41 = getelementptr i64, i64* %r2, i32 7
%r42 = trunc i1984 %r39 to i64
store i64 %r42, i64* %r41
%r43 = lshr i1984 %r39, 64
%r45 = getelementptr i64, i64* %r2, i32 8
%r46 = trunc i1984 %r43 to i64
store i64 %r46, i64* %r45
%r47 = lshr i1984 %r43, 64
%r49 = getelementptr i64, i64* %r2, i32 9
%r50 = trunc i1984 %r47 to i64
store i64 %r50, i64* %r49
%r51 = lshr i1984 %r47, 64
%r53 = getelementptr i64, i64* %r2, i32 10
%r54 = trunc i1984 %r51 to i64
store i64 %r54, i64* %r53
%r55 = lshr i1984 %r51, 64
%r57 = getelementptr i64, i64* %r2, i32 11
%r58 = trunc i1984 %r55 to i64
store i64 %r58, i64* %r57
%r59 = lshr i1984 %r55, 64
%r61 = getelementptr i64, i64* %r2, i32 12
%r62 = trunc i1984 %r59 to i64
store i64 %r62, i64* %r61
%r63 = lshr i1984 %r59, 64
%r65 = getelementptr i64, i64* %r2, i32 13
%r66 = trunc i1984 %r63 to i64
store i64 %r66, i64* %r65
%r67 = lshr i1984 %r63, 64
%r69 = getelementptr i64, i64* %r2, i32 14
%r70 = trunc i1984 %r67 to i64
store i64 %r70, i64* %r69
%r71 = lshr i1984 %r67, 64
%r73 = getelementptr i64, i64* %r2, i32 15
%r74 = trunc i1984 %r71 to i64
store i64 %r74, i64* %r73
%r75 = lshr i1984 %r71, 64
%r77 = getelementptr i64, i64* %r2, i32 16
%r78 = trunc i1984 %r75 to i64
store i64 %r78, i64* %r77
%r79 = lshr i1984 %r75, 64
%r81 = getelementptr i64, i64* %r2, i32 17
%r82 = trunc i1984 %r79 to i64
store i64 %r82, i64* %r81
%r83 = lshr i1984 %r79, 64
%r85 = getelementptr i64, i64* %r2, i32 18
%r86 = trunc i1984 %r83 to i64
store i64 %r86, i64* %r85
%r87 = lshr i1984 %r83, 64
%r89 = getelementptr i64, i64* %r2, i32 19
%r90 = trunc i1984 %r87 to i64
store i64 %r90, i64* %r89
%r91 = lshr i1984 %r87, 64
%r93 = getelementptr i64, i64* %r2, i32 20
%r94 = trunc i1984 %r91 to i64
store i64 %r94, i64* %r93
%r95 = lshr i1984 %r91, 64
%r97 = getelementptr i64, i64* %r2, i32 21
%r98 = trunc i1984 %r95 to i64
store i64 %r98, i64* %r97
%r99 = lshr i1984 %r95, 64
%r101 = getelementptr i64, i64* %r2, i32 22
%r102 = trunc i1984 %r99 to i64
store i64 %r102, i64* %r101
%r103 = lshr i1984 %r99, 64
%r105 = getelementptr i64, i64* %r2, i32 23
%r106 = trunc i1984 %r103 to i64
store i64 %r106, i64* %r105
%r107 = lshr i1984 %r103, 64
%r109 = getelementptr i64, i64* %r2, i32 24
%r110 = trunc i1984 %r107 to i64
store i64 %r110, i64* %r109
%r111 = lshr i1984 %r107, 64
%r113 = getelementptr i64, i64* %r2, i32 25
%r114 = trunc i1984 %r111 to i64
store i64 %r114, i64* %r113
%r115 = lshr i1984 %r111, 64
%r117 = getelementptr i64, i64* %r2, i32 26
%r118 = trunc i1984 %r115 to i64
store i64 %r118, i64* %r117
%r119 = lshr i1984 %r115, 64
%r121 = getelementptr i64, i64* %r2, i32 27
%r122 = trunc i1984 %r119 to i64
store i64 %r122, i64* %r121
%r123 = lshr i1984 %r119, 64
%r125 = getelementptr i64, i64* %r2, i32 28
%r126 = trunc i1984 %r123 to i64
store i64 %r126, i64* %r125
%r127 = lshr i1984 %r123, 64
%r129 = getelementptr i64, i64* %r2, i32 29
%r130 = trunc i1984 %r127 to i64
store i64 %r130, i64* %r129
%r131 = lshr i1984 %r127, 64
%r133 = getelementptr i64, i64* %r2, i32 30
%r134 = trunc i1984 %r131 to i64
store i64 %r134, i64* %r133
%r135 = lshr i1984 %r11, 1983
%r136 = trunc i1984 %r135 to i64
%r138 = and i64 %r136, 1
ret i64 %r138
}
define i64 @mclb_add32(i64* noalias  %r2, i64* noalias  %r3, i64* noalias  %r4)
{
%r6 = bitcast i64* %r3 to i2048*
%r7 = load i2048, i2048* %r6
%r8 = zext i2048 %r7 to i2112
%r10 = bitcast i64* %r4 to i2048*
%r11 = load i2048, i2048* %r10
%r12 = zext i2048 %r11 to i2112
%r13 = add i2112 %r8, %r12
%r14 = trunc i2112 %r13 to i2048
%r16 = getelementptr i64, i64* %r2, i32 0
%r17 = trunc i2048 %r14 to i64
store i64 %r17, i64* %r16
%r18 = lshr i2048 %r14, 64
%r20 = getelementptr i64, i64* %r2, i32 1
%r21 = trunc i2048 %r18 to i64
store i64 %r21, i64* %r20
%r22 = lshr i2048 %r18, 64
%r24 = getelementptr i64, i64* %r2, i32 2
%r25 = trunc i2048 %r22 to i64
store i64 %r25, i64* %r24
%r26 = lshr i2048 %r22, 64
%r28 = getelementptr i64, i64* %r2, i32 3
%r29 = trunc i2048 %r26 to i64
store i64 %r29, i64* %r28
%r30 = lshr i2048 %r26, 64
%r32 = getelementptr i64, i64* %r2, i32 4
%r33 = trunc i2048 %r30 to i64
store i64 %r33, i64* %r32
%r34 = lshr i2048 %r30, 64
%r36 = getelementptr i64, i64* %r2, i32 5
%r37 = trunc i2048 %r34 to i64
store i64 %r37, i64* %r36
%r38 = lshr i2048 %r34, 64
%r40 = getelementptr i64, i64* %r2, i32 6
%r41 = trunc i2048 %r38 to i64
store i64 %r41, i64* %r40
%r42 = lshr i2048 %r38, 64
%r44 = getelementptr i64, i64* %r2, i32 7
%r45 = trunc i2048 %r42 to i64
store i64 %r45, i64* %r44
%r46 = lshr i2048 %r42, 64
%r48 = getelementptr i64, i64* %r2, i32 8
%r49 = trunc i2048 %r46 to i64
store i64 %r49, i64* %r48
%r50 = lshr i2048 %r46, 64
%r52 = getelementptr i64, i64* %r2, i32 9
%r53 = trunc i2048 %r50 to i64
store i64 %r53, i64* %r52
%r54 = lshr i2048 %r50, 64
%r56 = getelementptr i64, i64* %r2, i32 10
%r57 = trunc i2048 %r54 to i64
store i64 %r57, i64* %r56
%r58 = lshr i2048 %r54, 64
%r60 = getelementptr i64, i64* %r2, i32 11
%r61 = trunc i2048 %r58 to i64
store i64 %r61, i64* %r60
%r62 = lshr i2048 %r58, 64
%r64 = getelementptr i64, i64* %r2, i32 12
%r65 = trunc i2048 %r62 to i64
store i64 %r65, i64* %r64
%r66 = lshr i2048 %r62, 64
%r68 = getelementptr i64, i64* %r2, i32 13
%r69 = trunc i2048 %r66 to i64
store i64 %r69, i64* %r68
%r70 = lshr i2048 %r66, 64
%r72 = getelementptr i64, i64* %r2, i32 14
%r73 = trunc i2048 %r70 to i64
store i64 %r73, i64* %r72
%r74 = lshr i2048 %r70, 64
%r76 = getelementptr i64, i64* %r2, i32 15
%r77 = trunc i2048 %r74 to i64
store i64 %r77, i64* %r76
%r78 = lshr i2048 %r74, 64
%r80 = getelementptr i64, i64* %r2, i32 16
%r81 = trunc i2048 %r78 to i64
store i64 %r81, i64* %r80
%r82 = lshr i2048 %r78, 64
%r84 = getelementptr i64, i64* %r2, i32 17
%r85 = trunc i2048 %r82 to i64
store i64 %r85, i64* %r84
%r86 = lshr i2048 %r82, 64
%r88 = getelementptr i64, i64* %r2, i32 18
%r89 = trunc i2048 %r86 to i64
store i64 %r89, i64* %r88
%r90 = lshr i2048 %r86, 64
%r92 = getelementptr i64, i64* %r2, i32 19
%r93 = trunc i2048 %r90 to i64
store i64 %r93, i64* %r92
%r94 = lshr i2048 %r90, 64
%r96 = getelementptr i64, i64* %r2, i32 20
%r97 = trunc i2048 %r94 to i64
store i64 %r97, i64* %r96
%r98 = lshr i2048 %r94, 64
%r100 = getelementptr i64, i64* %r2, i32 21
%r101 = trunc i2048 %r98 to i64
store i64 %r101, i64* %r100
%r102 = lshr i2048 %r98, 64
%r104 = getelementptr i64, i64* %r2, i32 22
%r105 = trunc i2048 %r102 to i64
store i64 %r105, i64* %r104
%r106 = lshr i2048 %r102, 64
%r108 = getelementptr i64, i64* %r2, i32 23
%r109 = trunc i2048 %r106 to i64
store i64 %r109, i64* %r108
%r110 = lshr i2048 %r106, 64
%r112 = getelementptr i64, i64* %r2, i32 24
%r113 = trunc i2048 %r110 to i64
store i64 %r113, i64* %r112
%r114 = lshr i2048 %r110, 64
%r116 = getelementptr i64, i64* %r2, i32 25
%r117 = trunc i2048 %r114 to i64
store i64 %r117, i64* %r116
%r118 = lshr i2048 %r114, 64
%r120 = getelementptr i64, i64* %r2, i32 26
%r121 = trunc i2048 %r118 to i64
store i64 %r121, i64* %r120
%r122 = lshr i2048 %r118, 64
%r124 = getelementptr i64, i64* %r2, i32 27
%r125 = trunc i2048 %r122 to i64
store i64 %r125, i64* %r124
%r126 = lshr i2048 %r122, 64
%r128 = getelementptr i64, i64* %r2, i32 28
%r129 = trunc i2048 %r126 to i64
store i64 %r129, i64* %r128
%r130 = lshr i2048 %r126, 64
%r132 = getelementptr i64, i64* %r2, i32 29
%r133 = trunc i2048 %r130 to i64
store i64 %r133, i64* %r132
%r134 = lshr i2048 %r130, 64
%r136 = getelementptr i64, i64* %r2, i32 30
%r137 = trunc i2048 %r134 to i64
store i64 %r137, i64* %r136
%r138 = lshr i2048 %r134, 64
%r140 = getelementptr i64, i64* %r2, i32 31
%r141 = trunc i2048 %r138 to i64
store i64 %r141, i64* %r140
%r142 = lshr i2112 %r13, 2048
%r143 = trunc i2112 %r142 to i64
ret i64 %r143
}
define i64 @mclb_sub32(i64* noalias  %r2, i64* noalias  %r3, i64* noalias  %r4)
{
%r6 = bitcast i64* %r3 to i2048*
%r7 = load i2048, i2048* %r6
%r8 = zext i2048 %r7 to i2112
%r10 = bitcast i64* %r4 to i2048*
%r11 = load i2048, i2048* %r10
%r12 = zext i2048 %r11 to i2112
%r13 = sub i2112 %r8, %r12
%r14 = trunc i2112 %r13 to i2048
%r16 = getelementptr i64, i64* %r2, i32 0
%r17 = trunc i2048 %r14 to i64
store i64 %r17, i64* %r16
%r18 = lshr i2048 %r14, 64
%r20 = getelementptr i64, i64* %r2, i32 1
%r21 = trunc i2048 %r18 to i64
store i64 %r21, i64* %r20
%r22 = lshr i2048 %r18, 64
%r24 = getelementptr i64, i64* %r2, i32 2
%r25 = trunc i2048 %r22 to i64
store i64 %r25, i64* %r24
%r26 = lshr i2048 %r22, 64
%r28 = getelementptr i64, i64* %r2, i32 3
%r29 = trunc i2048 %r26 to i64
store i64 %r29, i64* %r28
%r30 = lshr i2048 %r26, 64
%r32 = getelementptr i64, i64* %r2, i32 4
%r33 = trunc i2048 %r30 to i64
store i64 %r33, i64* %r32
%r34 = lshr i2048 %r30, 64
%r36 = getelementptr i64, i64* %r2, i32 5
%r37 = trunc i2048 %r34 to i64
store i64 %r37, i64* %r36
%r38 = lshr i2048 %r34, 64
%r40 = getelementptr i64, i64* %r2, i32 6
%r41 = trunc i2048 %r38 to i64
store i64 %r41, i64* %r40
%r42 = lshr i2048 %r38, 64
%r44 = getelementptr i64, i64* %r2, i32 7
%r45 = trunc i2048 %r42 to i64
store i64 %r45, i64* %r44
%r46 = lshr i2048 %r42, 64
%r48 = getelementptr i64, i64* %r2, i32 8
%r49 = trunc i2048 %r46 to i64
store i64 %r49, i64* %r48
%r50 = lshr i2048 %r46, 64
%r52 = getelementptr i64, i64* %r2, i32 9
%r53 = trunc i2048 %r50 to i64
store i64 %r53, i64* %r52
%r54 = lshr i2048 %r50, 64
%r56 = getelementptr i64, i64* %r2, i32 10
%r57 = trunc i2048 %r54 to i64
store i64 %r57, i64* %r56
%r58 = lshr i2048 %r54, 64
%r60 = getelementptr i64, i64* %r2, i32 11
%r61 = trunc i2048 %r58 to i64
store i64 %r61, i64* %r60
%r62 = lshr i2048 %r58, 64
%r64 = getelementptr i64, i64* %r2, i32 12
%r65 = trunc i2048 %r62 to i64
store i64 %r65, i64* %r64
%r66 = lshr i2048 %r62, 64
%r68 = getelementptr i64, i64* %r2, i32 13
%r69 = trunc i2048 %r66 to i64
store i64 %r69, i64* %r68
%r70 = lshr i2048 %r66, 64
%r72 = getelementptr i64, i64* %r2, i32 14
%r73 = trunc i2048 %r70 to i64
store i64 %r73, i64* %r72
%r74 = lshr i2048 %r70, 64
%r76 = getelementptr i64, i64* %r2, i32 15
%r77 = trunc i2048 %r74 to i64
store i64 %r77, i64* %r76
%r78 = lshr i2048 %r74, 64
%r80 = getelementptr i64, i64* %r2, i32 16
%r81 = trunc i2048 %r78 to i64
store i64 %r81, i64* %r80
%r82 = lshr i2048 %r78, 64
%r84 = getelementptr i64, i64* %r2, i32 17
%r85 = trunc i2048 %r82 to i64
store i64 %r85, i64* %r84
%r86 = lshr i2048 %r82, 64
%r88 = getelementptr i64, i64* %r2, i32 18
%r89 = trunc i2048 %r86 to i64
store i64 %r89, i64* %r88
%r90 = lshr i2048 %r86, 64
%r92 = getelementptr i64, i64* %r2, i32 19
%r93 = trunc i2048 %r90 to i64
store i64 %r93, i64* %r92
%r94 = lshr i2048 %r90, 64
%r96 = getelementptr i64, i64* %r2, i32 20
%r97 = trunc i2048 %r94 to i64
store i64 %r97, i64* %r96
%r98 = lshr i2048 %r94, 64
%r100 = getelementptr i64, i64* %r2, i32 21
%r101 = trunc i2048 %r98 to i64
store i64 %r101, i64* %r100
%r102 = lshr i2048 %r98, 64
%r104 = getelementptr i64, i64* %r2, i32 22
%r105 = trunc i2048 %r102 to i64
store i64 %r105, i64* %r104
%r106 = lshr i2048 %r102, 64
%r108 = getelementptr i64, i64* %r2, i32 23
%r109 = trunc i2048 %r106 to i64
store i64 %r109, i64* %r108
%r110 = lshr i2048 %r106, 64
%r112 = getelementptr i64, i64* %r2, i32 24
%r113 = trunc i2048 %r110 to i64
store i64 %r113, i64* %r112
%r114 = lshr i2048 %r110, 64
%r116 = getelementptr i64, i64* %r2, i32 25
%r117 = trunc i2048 %r114 to i64
store i64 %r117, i64* %r116
%r118 = lshr i2048 %r114, 64
%r120 = getelementptr i64, i64* %r2, i32 26
%r121 = trunc i2048 %r118 to i64
store i64 %r121, i64* %r120
%r122 = lshr i2048 %r118, 64
%r124 = getelementptr i64, i64* %r2, i32 27
%r125 = trunc i2048 %r122 to i64
store i64 %r125, i64* %r124
%r126 = lshr i2048 %r122, 64
%r128 = getelementptr i64, i64* %r2, i32 28
%r129 = trunc i2048 %r126 to i64
store i64 %r129, i64* %r128
%r130 = lshr i2048 %r126, 64
%r132 = getelementptr i64, i64* %r2, i32 29
%r133 = trunc i2048 %r130 to i64
store i64 %r133, i64* %r132
%r134 = lshr i2048 %r130, 64
%r136 = getelementptr i64, i64* %r2, i32 30
%r137 = trunc i2048 %r134 to i64
store i64 %r137, i64* %r136
%r138 = lshr i2048 %r134, 64
%r140 = getelementptr i64, i64* %r2, i32 31
%r141 = trunc i2048 %r138 to i64
store i64 %r141, i64* %r140
%r142 = lshr i2112 %r13, 2048
%r143 = trunc i2112 %r142 to i64
%r145 = and i64 %r143, 1
ret i64 %r145
}
define void @mclb_addNF32(i64* noalias  %r1, i64* noalias  %r2, i64* noalias  %r3)
{
%r5 = bitcast i64* %r2 to i2048*
%r6 = load i2048, i2048* %r5
%r8 = bitcast i64* %r3 to i2048*
%r9 = load i2048, i2048* %r8
%r10 = add i2048 %r6, %r9
%r12 = getelementptr i64, i64* %r1, i32 0
%r13 = trunc i2048 %r10 to i64
store i64 %r13, i64* %r12
%r14 = lshr i2048 %r10, 64
%r16 = getelementptr i64, i64* %r1, i32 1
%r17 = trunc i2048 %r14 to i64
store i64 %r17, i64* %r16
%r18 = lshr i2048 %r14, 64
%r20 = getelementptr i64, i64* %r1, i32 2
%r21 = trunc i2048 %r18 to i64
store i64 %r21, i64* %r20
%r22 = lshr i2048 %r18, 64
%r24 = getelementptr i64, i64* %r1, i32 3
%r25 = trunc i2048 %r22 to i64
store i64 %r25, i64* %r24
%r26 = lshr i2048 %r22, 64
%r28 = getelementptr i64, i64* %r1, i32 4
%r29 = trunc i2048 %r26 to i64
store i64 %r29, i64* %r28
%r30 = lshr i2048 %r26, 64
%r32 = getelementptr i64, i64* %r1, i32 5
%r33 = trunc i2048 %r30 to i64
store i64 %r33, i64* %r32
%r34 = lshr i2048 %r30, 64
%r36 = getelementptr i64, i64* %r1, i32 6
%r37 = trunc i2048 %r34 to i64
store i64 %r37, i64* %r36
%r38 = lshr i2048 %r34, 64
%r40 = getelementptr i64, i64* %r1, i32 7
%r41 = trunc i2048 %r38 to i64
store i64 %r41, i64* %r40
%r42 = lshr i2048 %r38, 64
%r44 = getelementptr i64, i64* %r1, i32 8
%r45 = trunc i2048 %r42 to i64
store i64 %r45, i64* %r44
%r46 = lshr i2048 %r42, 64
%r48 = getelementptr i64, i64* %r1, i32 9
%r49 = trunc i2048 %r46 to i64
store i64 %r49, i64* %r48
%r50 = lshr i2048 %r46, 64
%r52 = getelementptr i64, i64* %r1, i32 10
%r53 = trunc i2048 %r50 to i64
store i64 %r53, i64* %r52
%r54 = lshr i2048 %r50, 64
%r56 = getelementptr i64, i64* %r1, i32 11
%r57 = trunc i2048 %r54 to i64
store i64 %r57, i64* %r56
%r58 = lshr i2048 %r54, 64
%r60 = getelementptr i64, i64* %r1, i32 12
%r61 = trunc i2048 %r58 to i64
store i64 %r61, i64* %r60
%r62 = lshr i2048 %r58, 64
%r64 = getelementptr i64, i64* %r1, i32 13
%r65 = trunc i2048 %r62 to i64
store i64 %r65, i64* %r64
%r66 = lshr i2048 %r62, 64
%r68 = getelementptr i64, i64* %r1, i32 14
%r69 = trunc i2048 %r66 to i64
store i64 %r69, i64* %r68
%r70 = lshr i2048 %r66, 64
%r72 = getelementptr i64, i64* %r1, i32 15
%r73 = trunc i2048 %r70 to i64
store i64 %r73, i64* %r72
%r74 = lshr i2048 %r70, 64
%r76 = getelementptr i64, i64* %r1, i32 16
%r77 = trunc i2048 %r74 to i64
store i64 %r77, i64* %r76
%r78 = lshr i2048 %r74, 64
%r80 = getelementptr i64, i64* %r1, i32 17
%r81 = trunc i2048 %r78 to i64
store i64 %r81, i64* %r80
%r82 = lshr i2048 %r78, 64
%r84 = getelementptr i64, i64* %r1, i32 18
%r85 = trunc i2048 %r82 to i64
store i64 %r85, i64* %r84
%r86 = lshr i2048 %r82, 64
%r88 = getelementptr i64, i64* %r1, i32 19
%r89 = trunc i2048 %r86 to i64
store i64 %r89, i64* %r88
%r90 = lshr i2048 %r86, 64
%r92 = getelementptr i64, i64* %r1, i32 20
%r93 = trunc i2048 %r90 to i64
store i64 %r93, i64* %r92
%r94 = lshr i2048 %r90, 64
%r96 = getelementptr i64, i64* %r1, i32 21
%r97 = trunc i2048 %r94 to i64
store i64 %r97, i64* %r96
%r98 = lshr i2048 %r94, 64
%r100 = getelementptr i64, i64* %r1, i32 22
%r101 = trunc i2048 %r98 to i64
store i64 %r101, i64* %r100
%r102 = lshr i2048 %r98, 64
%r104 = getelementptr i64, i64* %r1, i32 23
%r105 = trunc i2048 %r102 to i64
store i64 %r105, i64* %r104
%r106 = lshr i2048 %r102, 64
%r108 = getelementptr i64, i64* %r1, i32 24
%r109 = trunc i2048 %r106 to i64
store i64 %r109, i64* %r108
%r110 = lshr i2048 %r106, 64
%r112 = getelementptr i64, i64* %r1, i32 25
%r113 = trunc i2048 %r110 to i64
store i64 %r113, i64* %r112
%r114 = lshr i2048 %r110, 64
%r116 = getelementptr i64, i64* %r1, i32 26
%r117 = trunc i2048 %r114 to i64
store i64 %r117, i64* %r116
%r118 = lshr i2048 %r114, 64
%r120 = getelementptr i64, i64* %r1, i32 27
%r121 = trunc i2048 %r118 to i64
store i64 %r121, i64* %r120
%r122 = lshr i2048 %r118, 64
%r124 = getelementptr i64, i64* %r1, i32 28
%r125 = trunc i2048 %r122 to i64
store i64 %r125, i64* %r124
%r126 = lshr i2048 %r122, 64
%r128 = getelementptr i64, i64* %r1, i32 29
%r129 = trunc i2048 %r126 to i64
store i64 %r129, i64* %r128
%r130 = lshr i2048 %r126, 64
%r132 = getelementptr i64, i64* %r1, i32 30
%r133 = trunc i2048 %r130 to i64
store i64 %r133, i64* %r132
%r134 = lshr i2048 %r130, 64
%r136 = getelementptr i64, i64* %r1, i32 31
%r137 = trunc i2048 %r134 to i64
store i64 %r137, i64* %r136
ret void
}
define i64 @mclb_subNF32(i64* noalias  %r2, i64* noalias  %r3, i64* noalias  %r4)
{
%r6 = bitcast i64* %r3 to i2048*
%r7 = load i2048, i2048* %r6
%r9 = bitcast i64* %r4 to i2048*
%r10 = load i2048, i2048* %r9
%r11 = sub i2048 %r7, %r10
%r13 = getelementptr i64, i64* %r2, i32 0
%r14 = trunc i2048 %r11 to i64
store i64 %r14, i64* %r13
%r15 = lshr i2048 %r11, 64
%r17 = getelementptr i64, i64* %r2, i32 1
%r18 = trunc i2048 %r15 to i64
store i64 %r18, i64* %r17
%r19 = lshr i2048 %r15, 64
%r21 = getelementptr i64, i64* %r2, i32 2
%r22 = trunc i2048 %r19 to i64
store i64 %r22, i64* %r21
%r23 = lshr i2048 %r19, 64
%r25 = getelementptr i64, i64* %r2, i32 3
%r26 = trunc i2048 %r23 to i64
store i64 %r26, i64* %r25
%r27 = lshr i2048 %r23, 64
%r29 = getelementptr i64, i64* %r2, i32 4
%r30 = trunc i2048 %r27 to i64
store i64 %r30, i64* %r29
%r31 = lshr i2048 %r27, 64
%r33 = getelementptr i64, i64* %r2, i32 5
%r34 = trunc i2048 %r31 to i64
store i64 %r34, i64* %r33
%r35 = lshr i2048 %r31, 64
%r37 = getelementptr i64, i64* %r2, i32 6
%r38 = trunc i2048 %r35 to i64
store i64 %r38, i64* %r37
%r39 = lshr i2048 %r35, 64
%r41 = getelementptr i64, i64* %r2, i32 7
%r42 = trunc i2048 %r39 to i64
store i64 %r42, i64* %r41
%r43 = lshr i2048 %r39, 64
%r45 = getelementptr i64, i64* %r2, i32 8
%r46 = trunc i2048 %r43 to i64
store i64 %r46, i64* %r45
%r47 = lshr i2048 %r43, 64
%r49 = getelementptr i64, i64* %r2, i32 9
%r50 = trunc i2048 %r47 to i64
store i64 %r50, i64* %r49
%r51 = lshr i2048 %r47, 64
%r53 = getelementptr i64, i64* %r2, i32 10
%r54 = trunc i2048 %r51 to i64
store i64 %r54, i64* %r53
%r55 = lshr i2048 %r51, 64
%r57 = getelementptr i64, i64* %r2, i32 11
%r58 = trunc i2048 %r55 to i64
store i64 %r58, i64* %r57
%r59 = lshr i2048 %r55, 64
%r61 = getelementptr i64, i64* %r2, i32 12
%r62 = trunc i2048 %r59 to i64
store i64 %r62, i64* %r61
%r63 = lshr i2048 %r59, 64
%r65 = getelementptr i64, i64* %r2, i32 13
%r66 = trunc i2048 %r63 to i64
store i64 %r66, i64* %r65
%r67 = lshr i2048 %r63, 64
%r69 = getelementptr i64, i64* %r2, i32 14
%r70 = trunc i2048 %r67 to i64
store i64 %r70, i64* %r69
%r71 = lshr i2048 %r67, 64
%r73 = getelementptr i64, i64* %r2, i32 15
%r74 = trunc i2048 %r71 to i64
store i64 %r74, i64* %r73
%r75 = lshr i2048 %r71, 64
%r77 = getelementptr i64, i64* %r2, i32 16
%r78 = trunc i2048 %r75 to i64
store i64 %r78, i64* %r77
%r79 = lshr i2048 %r75, 64
%r81 = getelementptr i64, i64* %r2, i32 17
%r82 = trunc i2048 %r79 to i64
store i64 %r82, i64* %r81
%r83 = lshr i2048 %r79, 64
%r85 = getelementptr i64, i64* %r2, i32 18
%r86 = trunc i2048 %r83 to i64
store i64 %r86, i64* %r85
%r87 = lshr i2048 %r83, 64
%r89 = getelementptr i64, i64* %r2, i32 19
%r90 = trunc i2048 %r87 to i64
store i64 %r90, i64* %r89
%r91 = lshr i2048 %r87, 64
%r93 = getelementptr i64, i64* %r2, i32 20
%r94 = trunc i2048 %r91 to i64
store i64 %r94, i64* %r93
%r95 = lshr i2048 %r91, 64
%r97 = getelementptr i64, i64* %r2, i32 21
%r98 = trunc i2048 %r95 to i64
store i64 %r98, i64* %r97
%r99 = lshr i2048 %r95, 64
%r101 = getelementptr i64, i64* %r2, i32 22
%r102 = trunc i2048 %r99 to i64
store i64 %r102, i64* %r101
%r103 = lshr i2048 %r99, 64
%r105 = getelementptr i64, i64* %r2, i32 23
%r106 = trunc i2048 %r103 to i64
store i64 %r106, i64* %r105
%r107 = lshr i2048 %r103, 64
%r109 = getelementptr i64, i64* %r2, i32 24
%r110 = trunc i2048 %r107 to i64
store i64 %r110, i64* %r109
%r111 = lshr i2048 %r107, 64
%r113 = getelementptr i64, i64* %r2, i32 25
%r114 = trunc i2048 %r111 to i64
store i64 %r114, i64* %r113
%r115 = lshr i2048 %r111, 64
%r117 = getelementptr i64, i64* %r2, i32 26
%r118 = trunc i2048 %r115 to i64
store i64 %r118, i64* %r117
%r119 = lshr i2048 %r115, 64
%r121 = getelementptr i64, i64* %r2, i32 27
%r122 = trunc i2048 %r119 to i64
store i64 %r122, i64* %r121
%r123 = lshr i2048 %r119, 64
%r125 = getelementptr i64, i64* %r2, i32 28
%r126 = trunc i2048 %r123 to i64
store i64 %r126, i64* %r125
%r127 = lshr i2048 %r123, 64
%r129 = getelementptr i64, i64* %r2, i32 29
%r130 = trunc i2048 %r127 to i64
store i64 %r130, i64* %r129
%r131 = lshr i2048 %r127, 64
%r133 = getelementptr i64, i64* %r2, i32 30
%r134 = trunc i2048 %r131 to i64
store i64 %r134, i64* %r133
%r135 = lshr i2048 %r131, 64
%r137 = getelementptr i64, i64* %r2, i32 31
%r138 = trunc i2048 %r135 to i64
store i64 %r138, i64* %r137
%r139 = lshr i2048 %r11, 2047
%r140 = trunc i2048 %r139 to i64
%r142 = and i64 %r140, 1
ret i64 %r142
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
define private i64 @mulUnit2_inner64(i64* noalias  %r2, i64 %r3)
{
%r4 = load i64, i64* %r2
%r5 = mul i64 %r4, %r3
ret i64 %r5
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
define private i128 @mulUnit2_inner128(i64* noalias  %r2, i64 %r3)
{
%r5 = call i128 @mulPos64x64(i64* %r2, i64 %r3, i64 0)
%r6 = trunc i128 %r5 to i64
%r7 = call i64 @extractHigh64(i128 %r5)
%r9 = call i128 @mulPos64x64(i64* %r2, i64 %r3, i64 1)
%r10 = trunc i128 %r9 to i64
%r11 = zext i64 %r6 to i128
%r12 = zext i64 %r10 to i128
%r13 = shl i128 %r12, 64
%r14 = or i128 %r11, %r13
%r15 = zext i64 %r7 to i128
%r16 = shl i128 %r15, 64
%r17 = add i128 %r14, %r16
ret i128 %r17
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
define private i192 @mulUnit2_inner192(i64* noalias  %r2, i64 %r3)
{
%r5 = call i128 @mulPos64x64(i64* %r2, i64 %r3, i64 0)
%r6 = trunc i128 %r5 to i64
%r7 = call i64 @extractHigh64(i128 %r5)
%r9 = call i128 @mulPos64x64(i64* %r2, i64 %r3, i64 1)
%r10 = trunc i128 %r9 to i64
%r11 = call i64 @extractHigh64(i128 %r9)
%r13 = call i128 @mulPos64x64(i64* %r2, i64 %r3, i64 2)
%r14 = trunc i128 %r13 to i64
%r15 = zext i64 %r6 to i128
%r16 = zext i64 %r10 to i128
%r17 = shl i128 %r16, 64
%r18 = or i128 %r15, %r17
%r19 = zext i128 %r18 to i192
%r20 = zext i64 %r14 to i192
%r21 = shl i192 %r20, 128
%r22 = or i192 %r19, %r21
%r23 = zext i64 %r7 to i128
%r24 = zext i64 %r11 to i128
%r25 = shl i128 %r24, 64
%r26 = or i128 %r23, %r25
%r27 = zext i128 %r26 to i192
%r28 = shl i192 %r27, 64
%r29 = add i192 %r22, %r28
ret i192 %r29
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
define private i256 @mulUnit2_inner256(i64* noalias  %r2, i64 %r3)
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
%r19 = zext i64 %r6 to i128
%r20 = zext i64 %r10 to i128
%r21 = shl i128 %r20, 64
%r22 = or i128 %r19, %r21
%r23 = zext i128 %r22 to i192
%r24 = zext i64 %r14 to i192
%r25 = shl i192 %r24, 128
%r26 = or i192 %r23, %r25
%r27 = zext i192 %r26 to i256
%r28 = zext i64 %r18 to i256
%r29 = shl i256 %r28, 192
%r30 = or i256 %r27, %r29
%r31 = zext i64 %r7 to i128
%r32 = zext i64 %r11 to i128
%r33 = shl i128 %r32, 64
%r34 = or i128 %r31, %r33
%r35 = zext i128 %r34 to i192
%r36 = zext i64 %r15 to i192
%r37 = shl i192 %r36, 128
%r38 = or i192 %r35, %r37
%r39 = zext i192 %r38 to i256
%r40 = shl i256 %r39, 64
%r41 = add i256 %r30, %r40
ret i256 %r41
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
define private i320 @mulUnit2_inner320(i64* noalias  %r2, i64 %r3)
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
%r23 = zext i64 %r6 to i128
%r24 = zext i64 %r10 to i128
%r25 = shl i128 %r24, 64
%r26 = or i128 %r23, %r25
%r27 = zext i128 %r26 to i192
%r28 = zext i64 %r14 to i192
%r29 = shl i192 %r28, 128
%r30 = or i192 %r27, %r29
%r31 = zext i192 %r30 to i256
%r32 = zext i64 %r18 to i256
%r33 = shl i256 %r32, 192
%r34 = or i256 %r31, %r33
%r35 = zext i256 %r34 to i320
%r36 = zext i64 %r22 to i320
%r37 = shl i320 %r36, 256
%r38 = or i320 %r35, %r37
%r39 = zext i64 %r7 to i128
%r40 = zext i64 %r11 to i128
%r41 = shl i128 %r40, 64
%r42 = or i128 %r39, %r41
%r43 = zext i128 %r42 to i192
%r44 = zext i64 %r15 to i192
%r45 = shl i192 %r44, 128
%r46 = or i192 %r43, %r45
%r47 = zext i192 %r46 to i256
%r48 = zext i64 %r19 to i256
%r49 = shl i256 %r48, 192
%r50 = or i256 %r47, %r49
%r51 = zext i256 %r50 to i320
%r52 = shl i320 %r51, 64
%r53 = add i320 %r38, %r52
ret i320 %r53
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
define private i384 @mulUnit2_inner384(i64* noalias  %r2, i64 %r3)
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
%r27 = zext i64 %r6 to i128
%r28 = zext i64 %r10 to i128
%r29 = shl i128 %r28, 64
%r30 = or i128 %r27, %r29
%r31 = zext i128 %r30 to i192
%r32 = zext i64 %r14 to i192
%r33 = shl i192 %r32, 128
%r34 = or i192 %r31, %r33
%r35 = zext i192 %r34 to i256
%r36 = zext i64 %r18 to i256
%r37 = shl i256 %r36, 192
%r38 = or i256 %r35, %r37
%r39 = zext i256 %r38 to i320
%r40 = zext i64 %r22 to i320
%r41 = shl i320 %r40, 256
%r42 = or i320 %r39, %r41
%r43 = zext i320 %r42 to i384
%r44 = zext i64 %r26 to i384
%r45 = shl i384 %r44, 320
%r46 = or i384 %r43, %r45
%r47 = zext i64 %r7 to i128
%r48 = zext i64 %r11 to i128
%r49 = shl i128 %r48, 64
%r50 = or i128 %r47, %r49
%r51 = zext i128 %r50 to i192
%r52 = zext i64 %r15 to i192
%r53 = shl i192 %r52, 128
%r54 = or i192 %r51, %r53
%r55 = zext i192 %r54 to i256
%r56 = zext i64 %r19 to i256
%r57 = shl i256 %r56, 192
%r58 = or i256 %r55, %r57
%r59 = zext i256 %r58 to i320
%r60 = zext i64 %r23 to i320
%r61 = shl i320 %r60, 256
%r62 = or i320 %r59, %r61
%r63 = zext i320 %r62 to i384
%r64 = shl i384 %r63, 64
%r65 = add i384 %r46, %r64
ret i384 %r65
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
define private i448 @mulUnit2_inner448(i64* noalias  %r2, i64 %r3)
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
%r31 = zext i64 %r6 to i128
%r32 = zext i64 %r10 to i128
%r33 = shl i128 %r32, 64
%r34 = or i128 %r31, %r33
%r35 = zext i128 %r34 to i192
%r36 = zext i64 %r14 to i192
%r37 = shl i192 %r36, 128
%r38 = or i192 %r35, %r37
%r39 = zext i192 %r38 to i256
%r40 = zext i64 %r18 to i256
%r41 = shl i256 %r40, 192
%r42 = or i256 %r39, %r41
%r43 = zext i256 %r42 to i320
%r44 = zext i64 %r22 to i320
%r45 = shl i320 %r44, 256
%r46 = or i320 %r43, %r45
%r47 = zext i320 %r46 to i384
%r48 = zext i64 %r26 to i384
%r49 = shl i384 %r48, 320
%r50 = or i384 %r47, %r49
%r51 = zext i384 %r50 to i448
%r52 = zext i64 %r30 to i448
%r53 = shl i448 %r52, 384
%r54 = or i448 %r51, %r53
%r55 = zext i64 %r7 to i128
%r56 = zext i64 %r11 to i128
%r57 = shl i128 %r56, 64
%r58 = or i128 %r55, %r57
%r59 = zext i128 %r58 to i192
%r60 = zext i64 %r15 to i192
%r61 = shl i192 %r60, 128
%r62 = or i192 %r59, %r61
%r63 = zext i192 %r62 to i256
%r64 = zext i64 %r19 to i256
%r65 = shl i256 %r64, 192
%r66 = or i256 %r63, %r65
%r67 = zext i256 %r66 to i320
%r68 = zext i64 %r23 to i320
%r69 = shl i320 %r68, 256
%r70 = or i320 %r67, %r69
%r71 = zext i320 %r70 to i384
%r72 = zext i64 %r27 to i384
%r73 = shl i384 %r72, 320
%r74 = or i384 %r71, %r73
%r75 = zext i384 %r74 to i448
%r76 = shl i448 %r75, 64
%r77 = add i448 %r54, %r76
ret i448 %r77
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
define private i512 @mulUnit2_inner512(i64* noalias  %r2, i64 %r3)
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
%r35 = zext i64 %r6 to i128
%r36 = zext i64 %r10 to i128
%r37 = shl i128 %r36, 64
%r38 = or i128 %r35, %r37
%r39 = zext i128 %r38 to i192
%r40 = zext i64 %r14 to i192
%r41 = shl i192 %r40, 128
%r42 = or i192 %r39, %r41
%r43 = zext i192 %r42 to i256
%r44 = zext i64 %r18 to i256
%r45 = shl i256 %r44, 192
%r46 = or i256 %r43, %r45
%r47 = zext i256 %r46 to i320
%r48 = zext i64 %r22 to i320
%r49 = shl i320 %r48, 256
%r50 = or i320 %r47, %r49
%r51 = zext i320 %r50 to i384
%r52 = zext i64 %r26 to i384
%r53 = shl i384 %r52, 320
%r54 = or i384 %r51, %r53
%r55 = zext i384 %r54 to i448
%r56 = zext i64 %r30 to i448
%r57 = shl i448 %r56, 384
%r58 = or i448 %r55, %r57
%r59 = zext i448 %r58 to i512
%r60 = zext i64 %r34 to i512
%r61 = shl i512 %r60, 448
%r62 = or i512 %r59, %r61
%r63 = zext i64 %r7 to i128
%r64 = zext i64 %r11 to i128
%r65 = shl i128 %r64, 64
%r66 = or i128 %r63, %r65
%r67 = zext i128 %r66 to i192
%r68 = zext i64 %r15 to i192
%r69 = shl i192 %r68, 128
%r70 = or i192 %r67, %r69
%r71 = zext i192 %r70 to i256
%r72 = zext i64 %r19 to i256
%r73 = shl i256 %r72, 192
%r74 = or i256 %r71, %r73
%r75 = zext i256 %r74 to i320
%r76 = zext i64 %r23 to i320
%r77 = shl i320 %r76, 256
%r78 = or i320 %r75, %r77
%r79 = zext i320 %r78 to i384
%r80 = zext i64 %r27 to i384
%r81 = shl i384 %r80, 320
%r82 = or i384 %r79, %r81
%r83 = zext i384 %r82 to i448
%r84 = zext i64 %r31 to i448
%r85 = shl i448 %r84, 384
%r86 = or i448 %r83, %r85
%r87 = zext i448 %r86 to i512
%r88 = shl i512 %r87, 64
%r89 = add i512 %r62, %r88
ret i512 %r89
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
define private i576 @mulUnit2_inner576(i64* noalias  %r2, i64 %r3)
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
%r39 = zext i64 %r6 to i128
%r40 = zext i64 %r10 to i128
%r41 = shl i128 %r40, 64
%r42 = or i128 %r39, %r41
%r43 = zext i128 %r42 to i192
%r44 = zext i64 %r14 to i192
%r45 = shl i192 %r44, 128
%r46 = or i192 %r43, %r45
%r47 = zext i192 %r46 to i256
%r48 = zext i64 %r18 to i256
%r49 = shl i256 %r48, 192
%r50 = or i256 %r47, %r49
%r51 = zext i256 %r50 to i320
%r52 = zext i64 %r22 to i320
%r53 = shl i320 %r52, 256
%r54 = or i320 %r51, %r53
%r55 = zext i320 %r54 to i384
%r56 = zext i64 %r26 to i384
%r57 = shl i384 %r56, 320
%r58 = or i384 %r55, %r57
%r59 = zext i384 %r58 to i448
%r60 = zext i64 %r30 to i448
%r61 = shl i448 %r60, 384
%r62 = or i448 %r59, %r61
%r63 = zext i448 %r62 to i512
%r64 = zext i64 %r34 to i512
%r65 = shl i512 %r64, 448
%r66 = or i512 %r63, %r65
%r67 = zext i512 %r66 to i576
%r68 = zext i64 %r38 to i576
%r69 = shl i576 %r68, 512
%r70 = or i576 %r67, %r69
%r71 = zext i64 %r7 to i128
%r72 = zext i64 %r11 to i128
%r73 = shl i128 %r72, 64
%r74 = or i128 %r71, %r73
%r75 = zext i128 %r74 to i192
%r76 = zext i64 %r15 to i192
%r77 = shl i192 %r76, 128
%r78 = or i192 %r75, %r77
%r79 = zext i192 %r78 to i256
%r80 = zext i64 %r19 to i256
%r81 = shl i256 %r80, 192
%r82 = or i256 %r79, %r81
%r83 = zext i256 %r82 to i320
%r84 = zext i64 %r23 to i320
%r85 = shl i320 %r84, 256
%r86 = or i320 %r83, %r85
%r87 = zext i320 %r86 to i384
%r88 = zext i64 %r27 to i384
%r89 = shl i384 %r88, 320
%r90 = or i384 %r87, %r89
%r91 = zext i384 %r90 to i448
%r92 = zext i64 %r31 to i448
%r93 = shl i448 %r92, 384
%r94 = or i448 %r91, %r93
%r95 = zext i448 %r94 to i512
%r96 = zext i64 %r35 to i512
%r97 = shl i512 %r96, 448
%r98 = or i512 %r95, %r97
%r99 = zext i512 %r98 to i576
%r100 = shl i576 %r99, 64
%r101 = add i576 %r70, %r100
ret i576 %r101
}
define i704 @mulUnit_inner640(i64* noalias  %r2, i64 %r3)
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
%r41 = call i128 @mulPos64x64(i64* %r2, i64 %r3, i64 9)
%r42 = trunc i128 %r41 to i64
%r43 = call i64 @extractHigh64(i128 %r41)
%r44 = zext i64 %r6 to i128
%r45 = zext i64 %r10 to i128
%r46 = shl i128 %r45, 64
%r47 = or i128 %r44, %r46
%r48 = zext i128 %r47 to i192
%r49 = zext i64 %r14 to i192
%r50 = shl i192 %r49, 128
%r51 = or i192 %r48, %r50
%r52 = zext i192 %r51 to i256
%r53 = zext i64 %r18 to i256
%r54 = shl i256 %r53, 192
%r55 = or i256 %r52, %r54
%r56 = zext i256 %r55 to i320
%r57 = zext i64 %r22 to i320
%r58 = shl i320 %r57, 256
%r59 = or i320 %r56, %r58
%r60 = zext i320 %r59 to i384
%r61 = zext i64 %r26 to i384
%r62 = shl i384 %r61, 320
%r63 = or i384 %r60, %r62
%r64 = zext i384 %r63 to i448
%r65 = zext i64 %r30 to i448
%r66 = shl i448 %r65, 384
%r67 = or i448 %r64, %r66
%r68 = zext i448 %r67 to i512
%r69 = zext i64 %r34 to i512
%r70 = shl i512 %r69, 448
%r71 = or i512 %r68, %r70
%r72 = zext i512 %r71 to i576
%r73 = zext i64 %r38 to i576
%r74 = shl i576 %r73, 512
%r75 = or i576 %r72, %r74
%r76 = zext i576 %r75 to i640
%r77 = zext i64 %r42 to i640
%r78 = shl i640 %r77, 576
%r79 = or i640 %r76, %r78
%r80 = zext i64 %r7 to i128
%r81 = zext i64 %r11 to i128
%r82 = shl i128 %r81, 64
%r83 = or i128 %r80, %r82
%r84 = zext i128 %r83 to i192
%r85 = zext i64 %r15 to i192
%r86 = shl i192 %r85, 128
%r87 = or i192 %r84, %r86
%r88 = zext i192 %r87 to i256
%r89 = zext i64 %r19 to i256
%r90 = shl i256 %r89, 192
%r91 = or i256 %r88, %r90
%r92 = zext i256 %r91 to i320
%r93 = zext i64 %r23 to i320
%r94 = shl i320 %r93, 256
%r95 = or i320 %r92, %r94
%r96 = zext i320 %r95 to i384
%r97 = zext i64 %r27 to i384
%r98 = shl i384 %r97, 320
%r99 = or i384 %r96, %r98
%r100 = zext i384 %r99 to i448
%r101 = zext i64 %r31 to i448
%r102 = shl i448 %r101, 384
%r103 = or i448 %r100, %r102
%r104 = zext i448 %r103 to i512
%r105 = zext i64 %r35 to i512
%r106 = shl i512 %r105, 448
%r107 = or i512 %r104, %r106
%r108 = zext i512 %r107 to i576
%r109 = zext i64 %r39 to i576
%r110 = shl i576 %r109, 512
%r111 = or i576 %r108, %r110
%r112 = zext i576 %r111 to i640
%r113 = zext i64 %r43 to i640
%r114 = shl i640 %r113, 576
%r115 = or i640 %r112, %r114
%r116 = zext i640 %r79 to i704
%r117 = zext i640 %r115 to i704
%r118 = shl i704 %r117, 64
%r119 = add i704 %r116, %r118
ret i704 %r119
}
define i64 @mclb_mulUnit10(i64* noalias  %r2, i64* noalias  %r3, i64 %r4)
{
%r5 = call i704 @mulUnit_inner640(i64* %r3, i64 %r4)
%r6 = trunc i704 %r5 to i640
%r8 = getelementptr i64, i64* %r2, i32 0
%r9 = trunc i640 %r6 to i64
store i64 %r9, i64* %r8
%r10 = lshr i640 %r6, 64
%r12 = getelementptr i64, i64* %r2, i32 1
%r13 = trunc i640 %r10 to i64
store i64 %r13, i64* %r12
%r14 = lshr i640 %r10, 64
%r16 = getelementptr i64, i64* %r2, i32 2
%r17 = trunc i640 %r14 to i64
store i64 %r17, i64* %r16
%r18 = lshr i640 %r14, 64
%r20 = getelementptr i64, i64* %r2, i32 3
%r21 = trunc i640 %r18 to i64
store i64 %r21, i64* %r20
%r22 = lshr i640 %r18, 64
%r24 = getelementptr i64, i64* %r2, i32 4
%r25 = trunc i640 %r22 to i64
store i64 %r25, i64* %r24
%r26 = lshr i640 %r22, 64
%r28 = getelementptr i64, i64* %r2, i32 5
%r29 = trunc i640 %r26 to i64
store i64 %r29, i64* %r28
%r30 = lshr i640 %r26, 64
%r32 = getelementptr i64, i64* %r2, i32 6
%r33 = trunc i640 %r30 to i64
store i64 %r33, i64* %r32
%r34 = lshr i640 %r30, 64
%r36 = getelementptr i64, i64* %r2, i32 7
%r37 = trunc i640 %r34 to i64
store i64 %r37, i64* %r36
%r38 = lshr i640 %r34, 64
%r40 = getelementptr i64, i64* %r2, i32 8
%r41 = trunc i640 %r38 to i64
store i64 %r41, i64* %r40
%r42 = lshr i640 %r38, 64
%r44 = getelementptr i64, i64* %r2, i32 9
%r45 = trunc i640 %r42 to i64
store i64 %r45, i64* %r44
%r46 = lshr i704 %r5, 640
%r47 = trunc i704 %r46 to i64
ret i64 %r47
}
define i64 @mclb_mulUnitAdd10(i64* noalias  %r2, i64* noalias  %r3, i64 %r4)
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
%r42 = call i128 @mulPos64x64(i64* %r3, i64 %r4, i64 9)
%r43 = trunc i128 %r42 to i64
%r44 = call i64 @extractHigh64(i128 %r42)
%r45 = zext i64 %r7 to i128
%r46 = zext i64 %r11 to i128
%r47 = shl i128 %r46, 64
%r48 = or i128 %r45, %r47
%r49 = zext i128 %r48 to i192
%r50 = zext i64 %r15 to i192
%r51 = shl i192 %r50, 128
%r52 = or i192 %r49, %r51
%r53 = zext i192 %r52 to i256
%r54 = zext i64 %r19 to i256
%r55 = shl i256 %r54, 192
%r56 = or i256 %r53, %r55
%r57 = zext i256 %r56 to i320
%r58 = zext i64 %r23 to i320
%r59 = shl i320 %r58, 256
%r60 = or i320 %r57, %r59
%r61 = zext i320 %r60 to i384
%r62 = zext i64 %r27 to i384
%r63 = shl i384 %r62, 320
%r64 = or i384 %r61, %r63
%r65 = zext i384 %r64 to i448
%r66 = zext i64 %r31 to i448
%r67 = shl i448 %r66, 384
%r68 = or i448 %r65, %r67
%r69 = zext i448 %r68 to i512
%r70 = zext i64 %r35 to i512
%r71 = shl i512 %r70, 448
%r72 = or i512 %r69, %r71
%r73 = zext i512 %r72 to i576
%r74 = zext i64 %r39 to i576
%r75 = shl i576 %r74, 512
%r76 = or i576 %r73, %r75
%r77 = zext i576 %r76 to i640
%r78 = zext i64 %r43 to i640
%r79 = shl i640 %r78, 576
%r80 = or i640 %r77, %r79
%r81 = zext i64 %r8 to i128
%r82 = zext i64 %r12 to i128
%r83 = shl i128 %r82, 64
%r84 = or i128 %r81, %r83
%r85 = zext i128 %r84 to i192
%r86 = zext i64 %r16 to i192
%r87 = shl i192 %r86, 128
%r88 = or i192 %r85, %r87
%r89 = zext i192 %r88 to i256
%r90 = zext i64 %r20 to i256
%r91 = shl i256 %r90, 192
%r92 = or i256 %r89, %r91
%r93 = zext i256 %r92 to i320
%r94 = zext i64 %r24 to i320
%r95 = shl i320 %r94, 256
%r96 = or i320 %r93, %r95
%r97 = zext i320 %r96 to i384
%r98 = zext i64 %r28 to i384
%r99 = shl i384 %r98, 320
%r100 = or i384 %r97, %r99
%r101 = zext i384 %r100 to i448
%r102 = zext i64 %r32 to i448
%r103 = shl i448 %r102, 384
%r104 = or i448 %r101, %r103
%r105 = zext i448 %r104 to i512
%r106 = zext i64 %r36 to i512
%r107 = shl i512 %r106, 448
%r108 = or i512 %r105, %r107
%r109 = zext i512 %r108 to i576
%r110 = zext i64 %r40 to i576
%r111 = shl i576 %r110, 512
%r112 = or i576 %r109, %r111
%r113 = zext i576 %r112 to i640
%r114 = zext i64 %r44 to i640
%r115 = shl i640 %r114, 576
%r116 = or i640 %r113, %r115
%r117 = zext i640 %r80 to i704
%r118 = zext i640 %r116 to i704
%r119 = shl i704 %r118, 64
%r120 = add i704 %r117, %r119
%r122 = bitcast i64* %r2 to i640*
%r123 = load i640, i640* %r122
%r124 = zext i640 %r123 to i704
%r125 = add i704 %r120, %r124
%r126 = trunc i704 %r125 to i640
%r128 = getelementptr i64, i64* %r2, i32 0
%r129 = trunc i640 %r126 to i64
store i64 %r129, i64* %r128
%r130 = lshr i640 %r126, 64
%r132 = getelementptr i64, i64* %r2, i32 1
%r133 = trunc i640 %r130 to i64
store i64 %r133, i64* %r132
%r134 = lshr i640 %r130, 64
%r136 = getelementptr i64, i64* %r2, i32 2
%r137 = trunc i640 %r134 to i64
store i64 %r137, i64* %r136
%r138 = lshr i640 %r134, 64
%r140 = getelementptr i64, i64* %r2, i32 3
%r141 = trunc i640 %r138 to i64
store i64 %r141, i64* %r140
%r142 = lshr i640 %r138, 64
%r144 = getelementptr i64, i64* %r2, i32 4
%r145 = trunc i640 %r142 to i64
store i64 %r145, i64* %r144
%r146 = lshr i640 %r142, 64
%r148 = getelementptr i64, i64* %r2, i32 5
%r149 = trunc i640 %r146 to i64
store i64 %r149, i64* %r148
%r150 = lshr i640 %r146, 64
%r152 = getelementptr i64, i64* %r2, i32 6
%r153 = trunc i640 %r150 to i64
store i64 %r153, i64* %r152
%r154 = lshr i640 %r150, 64
%r156 = getelementptr i64, i64* %r2, i32 7
%r157 = trunc i640 %r154 to i64
store i64 %r157, i64* %r156
%r158 = lshr i640 %r154, 64
%r160 = getelementptr i64, i64* %r2, i32 8
%r161 = trunc i640 %r158 to i64
store i64 %r161, i64* %r160
%r162 = lshr i640 %r158, 64
%r164 = getelementptr i64, i64* %r2, i32 9
%r165 = trunc i640 %r162 to i64
store i64 %r165, i64* %r164
%r166 = lshr i704 %r125, 640
%r167 = trunc i704 %r166 to i64
ret i64 %r167
}
define void @mclb_mul10(i64* noalias  %r1, i64* noalias  %r2, i64* noalias  %r3)
{
%r5 = getelementptr i64, i64* %r2, i32 5
%r7 = getelementptr i64, i64* %r3, i32 5
%r9 = getelementptr i64, i64* %r1, i32 10
call void @mclb_mul5(i64* %r1, i64* %r2, i64* %r3)
call void @mclb_mul5(i64* %r9, i64* %r5, i64* %r7)
%r11 = bitcast i64* %r5 to i320*
%r12 = load i320, i320* %r11
%r13 = zext i320 %r12 to i384
%r15 = bitcast i64* %r2 to i320*
%r16 = load i320, i320* %r15
%r17 = zext i320 %r16 to i384
%r19 = bitcast i64* %r7 to i320*
%r20 = load i320, i320* %r19
%r21 = zext i320 %r20 to i384
%r23 = bitcast i64* %r3 to i320*
%r24 = load i320, i320* %r23
%r25 = zext i320 %r24 to i384
%r26 = add i384 %r13, %r17
%r27 = add i384 %r21, %r25
%r29 = alloca i64, i32 10
%r30 = trunc i384 %r26 to i320
%r31 = trunc i384 %r27 to i320
%r32 = lshr i384 %r26, 320
%r33 = trunc i384 %r32 to i1
%r34 = lshr i384 %r27, 320
%r35 = trunc i384 %r34 to i1
%r36 = and i1 %r33, %r35
%r38 = select i1 %r33, i320 %r31, i320 0
%r40 = select i1 %r35, i320 %r30, i320 0
%r42 = alloca i64, i32 5
%r44 = alloca i64, i32 5
%r46 = getelementptr i64, i64* %r42, i32 0
%r47 = trunc i320 %r30 to i64
store i64 %r47, i64* %r46
%r48 = lshr i320 %r30, 64
%r50 = getelementptr i64, i64* %r42, i32 1
%r51 = trunc i320 %r48 to i64
store i64 %r51, i64* %r50
%r52 = lshr i320 %r48, 64
%r54 = getelementptr i64, i64* %r42, i32 2
%r55 = trunc i320 %r52 to i64
store i64 %r55, i64* %r54
%r56 = lshr i320 %r52, 64
%r58 = getelementptr i64, i64* %r42, i32 3
%r59 = trunc i320 %r56 to i64
store i64 %r59, i64* %r58
%r60 = lshr i320 %r56, 64
%r62 = getelementptr i64, i64* %r42, i32 4
%r63 = trunc i320 %r60 to i64
store i64 %r63, i64* %r62
%r65 = getelementptr i64, i64* %r44, i32 0
%r66 = trunc i320 %r31 to i64
store i64 %r66, i64* %r65
%r67 = lshr i320 %r31, 64
%r69 = getelementptr i64, i64* %r44, i32 1
%r70 = trunc i320 %r67 to i64
store i64 %r70, i64* %r69
%r71 = lshr i320 %r67, 64
%r73 = getelementptr i64, i64* %r44, i32 2
%r74 = trunc i320 %r71 to i64
store i64 %r74, i64* %r73
%r75 = lshr i320 %r71, 64
%r77 = getelementptr i64, i64* %r44, i32 3
%r78 = trunc i320 %r75 to i64
store i64 %r78, i64* %r77
%r79 = lshr i320 %r75, 64
%r81 = getelementptr i64, i64* %r44, i32 4
%r82 = trunc i320 %r79 to i64
store i64 %r82, i64* %r81
call void @mclb_mul5(i64* %r29, i64* %r42, i64* %r44)
%r84 = bitcast i64* %r29 to i640*
%r85 = load i640, i640* %r84
%r86 = zext i640 %r85 to i704
%r87 = zext i1 %r36 to i704
%r88 = shl i704 %r87, 640
%r89 = or i704 %r86, %r88
%r90 = zext i320 %r38 to i704
%r91 = zext i320 %r40 to i704
%r92 = shl i704 %r90, 320
%r93 = shl i704 %r91, 320
%r94 = add i704 %r89, %r92
%r95 = add i704 %r94, %r93
%r97 = bitcast i64* %r1 to i640*
%r98 = load i640, i640* %r97
%r99 = zext i640 %r98 to i704
%r100 = sub i704 %r95, %r99
%r102 = getelementptr i64, i64* %r1, i32 10
%r104 = bitcast i64* %r102 to i640*
%r105 = load i640, i640* %r104
%r106 = zext i640 %r105 to i704
%r107 = sub i704 %r100, %r106
%r108 = zext i704 %r107 to i960
%r110 = getelementptr i64, i64* %r1, i32 5
%r112 = bitcast i64* %r110 to i960*
%r113 = load i960, i960* %r112
%r114 = add i960 %r108, %r113
%r116 = getelementptr i64, i64* %r1, i32 5
%r118 = getelementptr i64, i64* %r116, i32 0
%r119 = trunc i960 %r114 to i64
store i64 %r119, i64* %r118
%r120 = lshr i960 %r114, 64
%r122 = getelementptr i64, i64* %r116, i32 1
%r123 = trunc i960 %r120 to i64
store i64 %r123, i64* %r122
%r124 = lshr i960 %r120, 64
%r126 = getelementptr i64, i64* %r116, i32 2
%r127 = trunc i960 %r124 to i64
store i64 %r127, i64* %r126
%r128 = lshr i960 %r124, 64
%r130 = getelementptr i64, i64* %r116, i32 3
%r131 = trunc i960 %r128 to i64
store i64 %r131, i64* %r130
%r132 = lshr i960 %r128, 64
%r134 = getelementptr i64, i64* %r116, i32 4
%r135 = trunc i960 %r132 to i64
store i64 %r135, i64* %r134
%r136 = lshr i960 %r132, 64
%r138 = getelementptr i64, i64* %r116, i32 5
%r139 = trunc i960 %r136 to i64
store i64 %r139, i64* %r138
%r140 = lshr i960 %r136, 64
%r142 = getelementptr i64, i64* %r116, i32 6
%r143 = trunc i960 %r140 to i64
store i64 %r143, i64* %r142
%r144 = lshr i960 %r140, 64
%r146 = getelementptr i64, i64* %r116, i32 7
%r147 = trunc i960 %r144 to i64
store i64 %r147, i64* %r146
%r148 = lshr i960 %r144, 64
%r150 = getelementptr i64, i64* %r116, i32 8
%r151 = trunc i960 %r148 to i64
store i64 %r151, i64* %r150
%r152 = lshr i960 %r148, 64
%r154 = getelementptr i64, i64* %r116, i32 9
%r155 = trunc i960 %r152 to i64
store i64 %r155, i64* %r154
%r156 = lshr i960 %r152, 64
%r158 = getelementptr i64, i64* %r116, i32 10
%r159 = trunc i960 %r156 to i64
store i64 %r159, i64* %r158
%r160 = lshr i960 %r156, 64
%r162 = getelementptr i64, i64* %r116, i32 11
%r163 = trunc i960 %r160 to i64
store i64 %r163, i64* %r162
%r164 = lshr i960 %r160, 64
%r166 = getelementptr i64, i64* %r116, i32 12
%r167 = trunc i960 %r164 to i64
store i64 %r167, i64* %r166
%r168 = lshr i960 %r164, 64
%r170 = getelementptr i64, i64* %r116, i32 13
%r171 = trunc i960 %r168 to i64
store i64 %r171, i64* %r170
%r172 = lshr i960 %r168, 64
%r174 = getelementptr i64, i64* %r116, i32 14
%r175 = trunc i960 %r172 to i64
store i64 %r175, i64* %r174
ret void
}
define void @mclb_sqr10(i64* noalias  %r1, i64* noalias  %r2)
{
%r4 = getelementptr i64, i64* %r2, i32 5
%r6 = getelementptr i64, i64* %r1, i32 10
%r8 = alloca i64, i32 10
call void @mclb_mul5(i64* %r8, i64* %r2, i64* %r4)
call void @mclb_sqr5(i64* %r1, i64* %r2)
call void @mclb_sqr5(i64* %r6, i64* %r4)
%r10 = bitcast i64* %r8 to i640*
%r11 = load i640, i640* %r10
%r12 = zext i640 %r11 to i704
%r13 = add i704 %r12, %r12
%r14 = zext i704 %r13 to i960
%r16 = getelementptr i64, i64* %r1, i32 5
%r18 = bitcast i64* %r16 to i960*
%r19 = load i960, i960* %r18
%r20 = add i960 %r19, %r14
%r22 = getelementptr i64, i64* %r16, i32 0
%r23 = trunc i960 %r20 to i64
store i64 %r23, i64* %r22
%r24 = lshr i960 %r20, 64
%r26 = getelementptr i64, i64* %r16, i32 1
%r27 = trunc i960 %r24 to i64
store i64 %r27, i64* %r26
%r28 = lshr i960 %r24, 64
%r30 = getelementptr i64, i64* %r16, i32 2
%r31 = trunc i960 %r28 to i64
store i64 %r31, i64* %r30
%r32 = lshr i960 %r28, 64
%r34 = getelementptr i64, i64* %r16, i32 3
%r35 = trunc i960 %r32 to i64
store i64 %r35, i64* %r34
%r36 = lshr i960 %r32, 64
%r38 = getelementptr i64, i64* %r16, i32 4
%r39 = trunc i960 %r36 to i64
store i64 %r39, i64* %r38
%r40 = lshr i960 %r36, 64
%r42 = getelementptr i64, i64* %r16, i32 5
%r43 = trunc i960 %r40 to i64
store i64 %r43, i64* %r42
%r44 = lshr i960 %r40, 64
%r46 = getelementptr i64, i64* %r16, i32 6
%r47 = trunc i960 %r44 to i64
store i64 %r47, i64* %r46
%r48 = lshr i960 %r44, 64
%r50 = getelementptr i64, i64* %r16, i32 7
%r51 = trunc i960 %r48 to i64
store i64 %r51, i64* %r50
%r52 = lshr i960 %r48, 64
%r54 = getelementptr i64, i64* %r16, i32 8
%r55 = trunc i960 %r52 to i64
store i64 %r55, i64* %r54
%r56 = lshr i960 %r52, 64
%r58 = getelementptr i64, i64* %r16, i32 9
%r59 = trunc i960 %r56 to i64
store i64 %r59, i64* %r58
%r60 = lshr i960 %r56, 64
%r62 = getelementptr i64, i64* %r16, i32 10
%r63 = trunc i960 %r60 to i64
store i64 %r63, i64* %r62
%r64 = lshr i960 %r60, 64
%r66 = getelementptr i64, i64* %r16, i32 11
%r67 = trunc i960 %r64 to i64
store i64 %r67, i64* %r66
%r68 = lshr i960 %r64, 64
%r70 = getelementptr i64, i64* %r16, i32 12
%r71 = trunc i960 %r68 to i64
store i64 %r71, i64* %r70
%r72 = lshr i960 %r68, 64
%r74 = getelementptr i64, i64* %r16, i32 13
%r75 = trunc i960 %r72 to i64
store i64 %r75, i64* %r74
%r76 = lshr i960 %r72, 64
%r78 = getelementptr i64, i64* %r16, i32 14
%r79 = trunc i960 %r76 to i64
store i64 %r79, i64* %r78
ret void
}
define private i640 @mulUnit2_inner640(i64* noalias  %r2, i64 %r3)
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
%r41 = call i128 @mulPos64x64(i64* %r2, i64 %r3, i64 9)
%r42 = trunc i128 %r41 to i64
%r43 = zext i64 %r6 to i128
%r44 = zext i64 %r10 to i128
%r45 = shl i128 %r44, 64
%r46 = or i128 %r43, %r45
%r47 = zext i128 %r46 to i192
%r48 = zext i64 %r14 to i192
%r49 = shl i192 %r48, 128
%r50 = or i192 %r47, %r49
%r51 = zext i192 %r50 to i256
%r52 = zext i64 %r18 to i256
%r53 = shl i256 %r52, 192
%r54 = or i256 %r51, %r53
%r55 = zext i256 %r54 to i320
%r56 = zext i64 %r22 to i320
%r57 = shl i320 %r56, 256
%r58 = or i320 %r55, %r57
%r59 = zext i320 %r58 to i384
%r60 = zext i64 %r26 to i384
%r61 = shl i384 %r60, 320
%r62 = or i384 %r59, %r61
%r63 = zext i384 %r62 to i448
%r64 = zext i64 %r30 to i448
%r65 = shl i448 %r64, 384
%r66 = or i448 %r63, %r65
%r67 = zext i448 %r66 to i512
%r68 = zext i64 %r34 to i512
%r69 = shl i512 %r68, 448
%r70 = or i512 %r67, %r69
%r71 = zext i512 %r70 to i576
%r72 = zext i64 %r38 to i576
%r73 = shl i576 %r72, 512
%r74 = or i576 %r71, %r73
%r75 = zext i576 %r74 to i640
%r76 = zext i64 %r42 to i640
%r77 = shl i640 %r76, 576
%r78 = or i640 %r75, %r77
%r79 = zext i64 %r7 to i128
%r80 = zext i64 %r11 to i128
%r81 = shl i128 %r80, 64
%r82 = or i128 %r79, %r81
%r83 = zext i128 %r82 to i192
%r84 = zext i64 %r15 to i192
%r85 = shl i192 %r84, 128
%r86 = or i192 %r83, %r85
%r87 = zext i192 %r86 to i256
%r88 = zext i64 %r19 to i256
%r89 = shl i256 %r88, 192
%r90 = or i256 %r87, %r89
%r91 = zext i256 %r90 to i320
%r92 = zext i64 %r23 to i320
%r93 = shl i320 %r92, 256
%r94 = or i320 %r91, %r93
%r95 = zext i320 %r94 to i384
%r96 = zext i64 %r27 to i384
%r97 = shl i384 %r96, 320
%r98 = or i384 %r95, %r97
%r99 = zext i384 %r98 to i448
%r100 = zext i64 %r31 to i448
%r101 = shl i448 %r100, 384
%r102 = or i448 %r99, %r101
%r103 = zext i448 %r102 to i512
%r104 = zext i64 %r35 to i512
%r105 = shl i512 %r104, 448
%r106 = or i512 %r103, %r105
%r107 = zext i512 %r106 to i576
%r108 = zext i64 %r39 to i576
%r109 = shl i576 %r108, 512
%r110 = or i576 %r107, %r109
%r111 = zext i576 %r110 to i640
%r112 = shl i640 %r111, 64
%r113 = add i640 %r78, %r112
ret i640 %r113
}
define i768 @mulUnit_inner704(i64* noalias  %r2, i64 %r3)
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
%r41 = call i128 @mulPos64x64(i64* %r2, i64 %r3, i64 9)
%r42 = trunc i128 %r41 to i64
%r43 = call i64 @extractHigh64(i128 %r41)
%r45 = call i128 @mulPos64x64(i64* %r2, i64 %r3, i64 10)
%r46 = trunc i128 %r45 to i64
%r47 = call i64 @extractHigh64(i128 %r45)
%r48 = zext i64 %r6 to i128
%r49 = zext i64 %r10 to i128
%r50 = shl i128 %r49, 64
%r51 = or i128 %r48, %r50
%r52 = zext i128 %r51 to i192
%r53 = zext i64 %r14 to i192
%r54 = shl i192 %r53, 128
%r55 = or i192 %r52, %r54
%r56 = zext i192 %r55 to i256
%r57 = zext i64 %r18 to i256
%r58 = shl i256 %r57, 192
%r59 = or i256 %r56, %r58
%r60 = zext i256 %r59 to i320
%r61 = zext i64 %r22 to i320
%r62 = shl i320 %r61, 256
%r63 = or i320 %r60, %r62
%r64 = zext i320 %r63 to i384
%r65 = zext i64 %r26 to i384
%r66 = shl i384 %r65, 320
%r67 = or i384 %r64, %r66
%r68 = zext i384 %r67 to i448
%r69 = zext i64 %r30 to i448
%r70 = shl i448 %r69, 384
%r71 = or i448 %r68, %r70
%r72 = zext i448 %r71 to i512
%r73 = zext i64 %r34 to i512
%r74 = shl i512 %r73, 448
%r75 = or i512 %r72, %r74
%r76 = zext i512 %r75 to i576
%r77 = zext i64 %r38 to i576
%r78 = shl i576 %r77, 512
%r79 = or i576 %r76, %r78
%r80 = zext i576 %r79 to i640
%r81 = zext i64 %r42 to i640
%r82 = shl i640 %r81, 576
%r83 = or i640 %r80, %r82
%r84 = zext i640 %r83 to i704
%r85 = zext i64 %r46 to i704
%r86 = shl i704 %r85, 640
%r87 = or i704 %r84, %r86
%r88 = zext i64 %r7 to i128
%r89 = zext i64 %r11 to i128
%r90 = shl i128 %r89, 64
%r91 = or i128 %r88, %r90
%r92 = zext i128 %r91 to i192
%r93 = zext i64 %r15 to i192
%r94 = shl i192 %r93, 128
%r95 = or i192 %r92, %r94
%r96 = zext i192 %r95 to i256
%r97 = zext i64 %r19 to i256
%r98 = shl i256 %r97, 192
%r99 = or i256 %r96, %r98
%r100 = zext i256 %r99 to i320
%r101 = zext i64 %r23 to i320
%r102 = shl i320 %r101, 256
%r103 = or i320 %r100, %r102
%r104 = zext i320 %r103 to i384
%r105 = zext i64 %r27 to i384
%r106 = shl i384 %r105, 320
%r107 = or i384 %r104, %r106
%r108 = zext i384 %r107 to i448
%r109 = zext i64 %r31 to i448
%r110 = shl i448 %r109, 384
%r111 = or i448 %r108, %r110
%r112 = zext i448 %r111 to i512
%r113 = zext i64 %r35 to i512
%r114 = shl i512 %r113, 448
%r115 = or i512 %r112, %r114
%r116 = zext i512 %r115 to i576
%r117 = zext i64 %r39 to i576
%r118 = shl i576 %r117, 512
%r119 = or i576 %r116, %r118
%r120 = zext i576 %r119 to i640
%r121 = zext i64 %r43 to i640
%r122 = shl i640 %r121, 576
%r123 = or i640 %r120, %r122
%r124 = zext i640 %r123 to i704
%r125 = zext i64 %r47 to i704
%r126 = shl i704 %r125, 640
%r127 = or i704 %r124, %r126
%r128 = zext i704 %r87 to i768
%r129 = zext i704 %r127 to i768
%r130 = shl i768 %r129, 64
%r131 = add i768 %r128, %r130
ret i768 %r131
}
define i64 @mclb_mulUnit11(i64* noalias  %r2, i64* noalias  %r3, i64 %r4)
{
%r5 = call i768 @mulUnit_inner704(i64* %r3, i64 %r4)
%r6 = trunc i768 %r5 to i704
%r8 = getelementptr i64, i64* %r2, i32 0
%r9 = trunc i704 %r6 to i64
store i64 %r9, i64* %r8
%r10 = lshr i704 %r6, 64
%r12 = getelementptr i64, i64* %r2, i32 1
%r13 = trunc i704 %r10 to i64
store i64 %r13, i64* %r12
%r14 = lshr i704 %r10, 64
%r16 = getelementptr i64, i64* %r2, i32 2
%r17 = trunc i704 %r14 to i64
store i64 %r17, i64* %r16
%r18 = lshr i704 %r14, 64
%r20 = getelementptr i64, i64* %r2, i32 3
%r21 = trunc i704 %r18 to i64
store i64 %r21, i64* %r20
%r22 = lshr i704 %r18, 64
%r24 = getelementptr i64, i64* %r2, i32 4
%r25 = trunc i704 %r22 to i64
store i64 %r25, i64* %r24
%r26 = lshr i704 %r22, 64
%r28 = getelementptr i64, i64* %r2, i32 5
%r29 = trunc i704 %r26 to i64
store i64 %r29, i64* %r28
%r30 = lshr i704 %r26, 64
%r32 = getelementptr i64, i64* %r2, i32 6
%r33 = trunc i704 %r30 to i64
store i64 %r33, i64* %r32
%r34 = lshr i704 %r30, 64
%r36 = getelementptr i64, i64* %r2, i32 7
%r37 = trunc i704 %r34 to i64
store i64 %r37, i64* %r36
%r38 = lshr i704 %r34, 64
%r40 = getelementptr i64, i64* %r2, i32 8
%r41 = trunc i704 %r38 to i64
store i64 %r41, i64* %r40
%r42 = lshr i704 %r38, 64
%r44 = getelementptr i64, i64* %r2, i32 9
%r45 = trunc i704 %r42 to i64
store i64 %r45, i64* %r44
%r46 = lshr i704 %r42, 64
%r48 = getelementptr i64, i64* %r2, i32 10
%r49 = trunc i704 %r46 to i64
store i64 %r49, i64* %r48
%r50 = lshr i768 %r5, 704
%r51 = trunc i768 %r50 to i64
ret i64 %r51
}
define i64 @mclb_mulUnitAdd11(i64* noalias  %r2, i64* noalias  %r3, i64 %r4)
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
%r42 = call i128 @mulPos64x64(i64* %r3, i64 %r4, i64 9)
%r43 = trunc i128 %r42 to i64
%r44 = call i64 @extractHigh64(i128 %r42)
%r46 = call i128 @mulPos64x64(i64* %r3, i64 %r4, i64 10)
%r47 = trunc i128 %r46 to i64
%r48 = call i64 @extractHigh64(i128 %r46)
%r49 = zext i64 %r7 to i128
%r50 = zext i64 %r11 to i128
%r51 = shl i128 %r50, 64
%r52 = or i128 %r49, %r51
%r53 = zext i128 %r52 to i192
%r54 = zext i64 %r15 to i192
%r55 = shl i192 %r54, 128
%r56 = or i192 %r53, %r55
%r57 = zext i192 %r56 to i256
%r58 = zext i64 %r19 to i256
%r59 = shl i256 %r58, 192
%r60 = or i256 %r57, %r59
%r61 = zext i256 %r60 to i320
%r62 = zext i64 %r23 to i320
%r63 = shl i320 %r62, 256
%r64 = or i320 %r61, %r63
%r65 = zext i320 %r64 to i384
%r66 = zext i64 %r27 to i384
%r67 = shl i384 %r66, 320
%r68 = or i384 %r65, %r67
%r69 = zext i384 %r68 to i448
%r70 = zext i64 %r31 to i448
%r71 = shl i448 %r70, 384
%r72 = or i448 %r69, %r71
%r73 = zext i448 %r72 to i512
%r74 = zext i64 %r35 to i512
%r75 = shl i512 %r74, 448
%r76 = or i512 %r73, %r75
%r77 = zext i512 %r76 to i576
%r78 = zext i64 %r39 to i576
%r79 = shl i576 %r78, 512
%r80 = or i576 %r77, %r79
%r81 = zext i576 %r80 to i640
%r82 = zext i64 %r43 to i640
%r83 = shl i640 %r82, 576
%r84 = or i640 %r81, %r83
%r85 = zext i640 %r84 to i704
%r86 = zext i64 %r47 to i704
%r87 = shl i704 %r86, 640
%r88 = or i704 %r85, %r87
%r89 = zext i64 %r8 to i128
%r90 = zext i64 %r12 to i128
%r91 = shl i128 %r90, 64
%r92 = or i128 %r89, %r91
%r93 = zext i128 %r92 to i192
%r94 = zext i64 %r16 to i192
%r95 = shl i192 %r94, 128
%r96 = or i192 %r93, %r95
%r97 = zext i192 %r96 to i256
%r98 = zext i64 %r20 to i256
%r99 = shl i256 %r98, 192
%r100 = or i256 %r97, %r99
%r101 = zext i256 %r100 to i320
%r102 = zext i64 %r24 to i320
%r103 = shl i320 %r102, 256
%r104 = or i320 %r101, %r103
%r105 = zext i320 %r104 to i384
%r106 = zext i64 %r28 to i384
%r107 = shl i384 %r106, 320
%r108 = or i384 %r105, %r107
%r109 = zext i384 %r108 to i448
%r110 = zext i64 %r32 to i448
%r111 = shl i448 %r110, 384
%r112 = or i448 %r109, %r111
%r113 = zext i448 %r112 to i512
%r114 = zext i64 %r36 to i512
%r115 = shl i512 %r114, 448
%r116 = or i512 %r113, %r115
%r117 = zext i512 %r116 to i576
%r118 = zext i64 %r40 to i576
%r119 = shl i576 %r118, 512
%r120 = or i576 %r117, %r119
%r121 = zext i576 %r120 to i640
%r122 = zext i64 %r44 to i640
%r123 = shl i640 %r122, 576
%r124 = or i640 %r121, %r123
%r125 = zext i640 %r124 to i704
%r126 = zext i64 %r48 to i704
%r127 = shl i704 %r126, 640
%r128 = or i704 %r125, %r127
%r129 = zext i704 %r88 to i768
%r130 = zext i704 %r128 to i768
%r131 = shl i768 %r130, 64
%r132 = add i768 %r129, %r131
%r134 = bitcast i64* %r2 to i704*
%r135 = load i704, i704* %r134
%r136 = zext i704 %r135 to i768
%r137 = add i768 %r132, %r136
%r138 = trunc i768 %r137 to i704
%r140 = getelementptr i64, i64* %r2, i32 0
%r141 = trunc i704 %r138 to i64
store i64 %r141, i64* %r140
%r142 = lshr i704 %r138, 64
%r144 = getelementptr i64, i64* %r2, i32 1
%r145 = trunc i704 %r142 to i64
store i64 %r145, i64* %r144
%r146 = lshr i704 %r142, 64
%r148 = getelementptr i64, i64* %r2, i32 2
%r149 = trunc i704 %r146 to i64
store i64 %r149, i64* %r148
%r150 = lshr i704 %r146, 64
%r152 = getelementptr i64, i64* %r2, i32 3
%r153 = trunc i704 %r150 to i64
store i64 %r153, i64* %r152
%r154 = lshr i704 %r150, 64
%r156 = getelementptr i64, i64* %r2, i32 4
%r157 = trunc i704 %r154 to i64
store i64 %r157, i64* %r156
%r158 = lshr i704 %r154, 64
%r160 = getelementptr i64, i64* %r2, i32 5
%r161 = trunc i704 %r158 to i64
store i64 %r161, i64* %r160
%r162 = lshr i704 %r158, 64
%r164 = getelementptr i64, i64* %r2, i32 6
%r165 = trunc i704 %r162 to i64
store i64 %r165, i64* %r164
%r166 = lshr i704 %r162, 64
%r168 = getelementptr i64, i64* %r2, i32 7
%r169 = trunc i704 %r166 to i64
store i64 %r169, i64* %r168
%r170 = lshr i704 %r166, 64
%r172 = getelementptr i64, i64* %r2, i32 8
%r173 = trunc i704 %r170 to i64
store i64 %r173, i64* %r172
%r174 = lshr i704 %r170, 64
%r176 = getelementptr i64, i64* %r2, i32 9
%r177 = trunc i704 %r174 to i64
store i64 %r177, i64* %r176
%r178 = lshr i704 %r174, 64
%r180 = getelementptr i64, i64* %r2, i32 10
%r181 = trunc i704 %r178 to i64
store i64 %r181, i64* %r180
%r182 = lshr i768 %r137, 704
%r183 = trunc i768 %r182 to i64
ret i64 %r183
}
define void @mclb_mul11(i64* noalias  %r1, i64* noalias  %r2, i64* noalias  %r3)
{
%r4 = load i64, i64* %r3
%r5 = call i768 @mulUnit_inner704(i64* %r2, i64 %r4)
%r6 = trunc i768 %r5 to i64
store i64 %r6, i64* %r1
%r7 = lshr i768 %r5, 64
%r9 = getelementptr i64, i64* %r3, i32 1
%r10 = load i64, i64* %r9
%r11 = call i768 @mulUnit_inner704(i64* %r2, i64 %r10)
%r12 = add i768 %r7, %r11
%r13 = trunc i768 %r12 to i64
%r15 = getelementptr i64, i64* %r1, i32 1
store i64 %r13, i64* %r15
%r16 = lshr i768 %r12, 64
%r18 = getelementptr i64, i64* %r3, i32 2
%r19 = load i64, i64* %r18
%r20 = call i768 @mulUnit_inner704(i64* %r2, i64 %r19)
%r21 = add i768 %r16, %r20
%r22 = trunc i768 %r21 to i64
%r24 = getelementptr i64, i64* %r1, i32 2
store i64 %r22, i64* %r24
%r25 = lshr i768 %r21, 64
%r27 = getelementptr i64, i64* %r3, i32 3
%r28 = load i64, i64* %r27
%r29 = call i768 @mulUnit_inner704(i64* %r2, i64 %r28)
%r30 = add i768 %r25, %r29
%r31 = trunc i768 %r30 to i64
%r33 = getelementptr i64, i64* %r1, i32 3
store i64 %r31, i64* %r33
%r34 = lshr i768 %r30, 64
%r36 = getelementptr i64, i64* %r3, i32 4
%r37 = load i64, i64* %r36
%r38 = call i768 @mulUnit_inner704(i64* %r2, i64 %r37)
%r39 = add i768 %r34, %r38
%r40 = trunc i768 %r39 to i64
%r42 = getelementptr i64, i64* %r1, i32 4
store i64 %r40, i64* %r42
%r43 = lshr i768 %r39, 64
%r45 = getelementptr i64, i64* %r3, i32 5
%r46 = load i64, i64* %r45
%r47 = call i768 @mulUnit_inner704(i64* %r2, i64 %r46)
%r48 = add i768 %r43, %r47
%r49 = trunc i768 %r48 to i64
%r51 = getelementptr i64, i64* %r1, i32 5
store i64 %r49, i64* %r51
%r52 = lshr i768 %r48, 64
%r54 = getelementptr i64, i64* %r3, i32 6
%r55 = load i64, i64* %r54
%r56 = call i768 @mulUnit_inner704(i64* %r2, i64 %r55)
%r57 = add i768 %r52, %r56
%r58 = trunc i768 %r57 to i64
%r60 = getelementptr i64, i64* %r1, i32 6
store i64 %r58, i64* %r60
%r61 = lshr i768 %r57, 64
%r63 = getelementptr i64, i64* %r3, i32 7
%r64 = load i64, i64* %r63
%r65 = call i768 @mulUnit_inner704(i64* %r2, i64 %r64)
%r66 = add i768 %r61, %r65
%r67 = trunc i768 %r66 to i64
%r69 = getelementptr i64, i64* %r1, i32 7
store i64 %r67, i64* %r69
%r70 = lshr i768 %r66, 64
%r72 = getelementptr i64, i64* %r3, i32 8
%r73 = load i64, i64* %r72
%r74 = call i768 @mulUnit_inner704(i64* %r2, i64 %r73)
%r75 = add i768 %r70, %r74
%r76 = trunc i768 %r75 to i64
%r78 = getelementptr i64, i64* %r1, i32 8
store i64 %r76, i64* %r78
%r79 = lshr i768 %r75, 64
%r81 = getelementptr i64, i64* %r3, i32 9
%r82 = load i64, i64* %r81
%r83 = call i768 @mulUnit_inner704(i64* %r2, i64 %r82)
%r84 = add i768 %r79, %r83
%r85 = trunc i768 %r84 to i64
%r87 = getelementptr i64, i64* %r1, i32 9
store i64 %r85, i64* %r87
%r88 = lshr i768 %r84, 64
%r90 = getelementptr i64, i64* %r3, i32 10
%r91 = load i64, i64* %r90
%r92 = call i768 @mulUnit_inner704(i64* %r2, i64 %r91)
%r93 = add i768 %r88, %r92
%r95 = getelementptr i64, i64* %r1, i32 10
%r97 = getelementptr i64, i64* %r95, i32 0
%r98 = trunc i768 %r93 to i64
store i64 %r98, i64* %r97
%r99 = lshr i768 %r93, 64
%r101 = getelementptr i64, i64* %r95, i32 1
%r102 = trunc i768 %r99 to i64
store i64 %r102, i64* %r101
%r103 = lshr i768 %r99, 64
%r105 = getelementptr i64, i64* %r95, i32 2
%r106 = trunc i768 %r103 to i64
store i64 %r106, i64* %r105
%r107 = lshr i768 %r103, 64
%r109 = getelementptr i64, i64* %r95, i32 3
%r110 = trunc i768 %r107 to i64
store i64 %r110, i64* %r109
%r111 = lshr i768 %r107, 64
%r113 = getelementptr i64, i64* %r95, i32 4
%r114 = trunc i768 %r111 to i64
store i64 %r114, i64* %r113
%r115 = lshr i768 %r111, 64
%r117 = getelementptr i64, i64* %r95, i32 5
%r118 = trunc i768 %r115 to i64
store i64 %r118, i64* %r117
%r119 = lshr i768 %r115, 64
%r121 = getelementptr i64, i64* %r95, i32 6
%r122 = trunc i768 %r119 to i64
store i64 %r122, i64* %r121
%r123 = lshr i768 %r119, 64
%r125 = getelementptr i64, i64* %r95, i32 7
%r126 = trunc i768 %r123 to i64
store i64 %r126, i64* %r125
%r127 = lshr i768 %r123, 64
%r129 = getelementptr i64, i64* %r95, i32 8
%r130 = trunc i768 %r127 to i64
store i64 %r130, i64* %r129
%r131 = lshr i768 %r127, 64
%r133 = getelementptr i64, i64* %r95, i32 9
%r134 = trunc i768 %r131 to i64
store i64 %r134, i64* %r133
%r135 = lshr i768 %r131, 64
%r137 = getelementptr i64, i64* %r95, i32 10
%r138 = trunc i768 %r135 to i64
store i64 %r138, i64* %r137
%r139 = lshr i768 %r135, 64
%r141 = getelementptr i64, i64* %r95, i32 11
%r142 = trunc i768 %r139 to i64
store i64 %r142, i64* %r141
ret void
}
define void @mclb_sqr11(i64* noalias  %r1, i64* noalias  %r2)
{
%r3 = load i64, i64* %r2
%r4 = call i128 @mul64x64L(i64 %r3, i64 %r3)
%r5 = trunc i128 %r4 to i64
store i64 %r5, i64* %r1
%r6 = lshr i128 %r4, 64
%r8 = getelementptr i64, i64* %r2, i32 10
%r9 = load i64, i64* %r8
%r10 = call i128 @mul64x64L(i64 %r3, i64 %r9)
%r11 = load i64, i64* %r2
%r13 = getelementptr i64, i64* %r2, i32 9
%r14 = load i64, i64* %r13
%r15 = call i128 @mul64x64L(i64 %r11, i64 %r14)
%r17 = getelementptr i64, i64* %r2, i32 1
%r18 = load i64, i64* %r17
%r20 = getelementptr i64, i64* %r2, i32 10
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
%r32 = getelementptr i64, i64* %r2, i32 8
%r33 = load i64, i64* %r32
%r34 = call i128 @mul64x64L(i64 %r30, i64 %r33)
%r36 = getelementptr i64, i64* %r2, i32 1
%r37 = load i64, i64* %r36
%r39 = getelementptr i64, i64* %r2, i32 9
%r40 = load i64, i64* %r39
%r41 = call i128 @mul64x64L(i64 %r37, i64 %r40)
%r42 = zext i128 %r34 to i256
%r43 = zext i128 %r41 to i256
%r44 = shl i256 %r43, 128
%r45 = or i256 %r42, %r44
%r47 = getelementptr i64, i64* %r2, i32 2
%r48 = load i64, i64* %r47
%r50 = getelementptr i64, i64* %r2, i32 10
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
%r62 = getelementptr i64, i64* %r2, i32 7
%r63 = load i64, i64* %r62
%r64 = call i128 @mul64x64L(i64 %r60, i64 %r63)
%r66 = getelementptr i64, i64* %r2, i32 1
%r67 = load i64, i64* %r66
%r69 = getelementptr i64, i64* %r2, i32 8
%r70 = load i64, i64* %r69
%r71 = call i128 @mul64x64L(i64 %r67, i64 %r70)
%r72 = zext i128 %r64 to i256
%r73 = zext i128 %r71 to i256
%r74 = shl i256 %r73, 128
%r75 = or i256 %r72, %r74
%r77 = getelementptr i64, i64* %r2, i32 2
%r78 = load i64, i64* %r77
%r80 = getelementptr i64, i64* %r2, i32 9
%r81 = load i64, i64* %r80
%r82 = call i128 @mul64x64L(i64 %r78, i64 %r81)
%r83 = zext i256 %r75 to i384
%r84 = zext i128 %r82 to i384
%r85 = shl i384 %r84, 256
%r86 = or i384 %r83, %r85
%r88 = getelementptr i64, i64* %r2, i32 3
%r89 = load i64, i64* %r88
%r91 = getelementptr i64, i64* %r2, i32 10
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
%r103 = getelementptr i64, i64* %r2, i32 6
%r104 = load i64, i64* %r103
%r105 = call i128 @mul64x64L(i64 %r101, i64 %r104)
%r107 = getelementptr i64, i64* %r2, i32 1
%r108 = load i64, i64* %r107
%r110 = getelementptr i64, i64* %r2, i32 7
%r111 = load i64, i64* %r110
%r112 = call i128 @mul64x64L(i64 %r108, i64 %r111)
%r113 = zext i128 %r105 to i256
%r114 = zext i128 %r112 to i256
%r115 = shl i256 %r114, 128
%r116 = or i256 %r113, %r115
%r118 = getelementptr i64, i64* %r2, i32 2
%r119 = load i64, i64* %r118
%r121 = getelementptr i64, i64* %r2, i32 8
%r122 = load i64, i64* %r121
%r123 = call i128 @mul64x64L(i64 %r119, i64 %r122)
%r124 = zext i256 %r116 to i384
%r125 = zext i128 %r123 to i384
%r126 = shl i384 %r125, 256
%r127 = or i384 %r124, %r126
%r129 = getelementptr i64, i64* %r2, i32 3
%r130 = load i64, i64* %r129
%r132 = getelementptr i64, i64* %r2, i32 9
%r133 = load i64, i64* %r132
%r134 = call i128 @mul64x64L(i64 %r130, i64 %r133)
%r135 = zext i384 %r127 to i512
%r136 = zext i128 %r134 to i512
%r137 = shl i512 %r136, 384
%r138 = or i512 %r135, %r137
%r140 = getelementptr i64, i64* %r2, i32 4
%r141 = load i64, i64* %r140
%r143 = getelementptr i64, i64* %r2, i32 10
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
%r155 = getelementptr i64, i64* %r2, i32 5
%r156 = load i64, i64* %r155
%r157 = call i128 @mul64x64L(i64 %r153, i64 %r156)
%r159 = getelementptr i64, i64* %r2, i32 1
%r160 = load i64, i64* %r159
%r162 = getelementptr i64, i64* %r2, i32 6
%r163 = load i64, i64* %r162
%r164 = call i128 @mul64x64L(i64 %r160, i64 %r163)
%r165 = zext i128 %r157 to i256
%r166 = zext i128 %r164 to i256
%r167 = shl i256 %r166, 128
%r168 = or i256 %r165, %r167
%r170 = getelementptr i64, i64* %r2, i32 2
%r171 = load i64, i64* %r170
%r173 = getelementptr i64, i64* %r2, i32 7
%r174 = load i64, i64* %r173
%r175 = call i128 @mul64x64L(i64 %r171, i64 %r174)
%r176 = zext i256 %r168 to i384
%r177 = zext i128 %r175 to i384
%r178 = shl i384 %r177, 256
%r179 = or i384 %r176, %r178
%r181 = getelementptr i64, i64* %r2, i32 3
%r182 = load i64, i64* %r181
%r184 = getelementptr i64, i64* %r2, i32 8
%r185 = load i64, i64* %r184
%r186 = call i128 @mul64x64L(i64 %r182, i64 %r185)
%r187 = zext i384 %r179 to i512
%r188 = zext i128 %r186 to i512
%r189 = shl i512 %r188, 384
%r190 = or i512 %r187, %r189
%r192 = getelementptr i64, i64* %r2, i32 4
%r193 = load i64, i64* %r192
%r195 = getelementptr i64, i64* %r2, i32 9
%r196 = load i64, i64* %r195
%r197 = call i128 @mul64x64L(i64 %r193, i64 %r196)
%r198 = zext i512 %r190 to i640
%r199 = zext i128 %r197 to i640
%r200 = shl i640 %r199, 512
%r201 = or i640 %r198, %r200
%r203 = getelementptr i64, i64* %r2, i32 5
%r204 = load i64, i64* %r203
%r206 = getelementptr i64, i64* %r2, i32 10
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
%r218 = getelementptr i64, i64* %r2, i32 4
%r219 = load i64, i64* %r218
%r220 = call i128 @mul64x64L(i64 %r216, i64 %r219)
%r222 = getelementptr i64, i64* %r2, i32 1
%r223 = load i64, i64* %r222
%r225 = getelementptr i64, i64* %r2, i32 5
%r226 = load i64, i64* %r225
%r227 = call i128 @mul64x64L(i64 %r223, i64 %r226)
%r228 = zext i128 %r220 to i256
%r229 = zext i128 %r227 to i256
%r230 = shl i256 %r229, 128
%r231 = or i256 %r228, %r230
%r233 = getelementptr i64, i64* %r2, i32 2
%r234 = load i64, i64* %r233
%r236 = getelementptr i64, i64* %r2, i32 6
%r237 = load i64, i64* %r236
%r238 = call i128 @mul64x64L(i64 %r234, i64 %r237)
%r239 = zext i256 %r231 to i384
%r240 = zext i128 %r238 to i384
%r241 = shl i384 %r240, 256
%r242 = or i384 %r239, %r241
%r244 = getelementptr i64, i64* %r2, i32 3
%r245 = load i64, i64* %r244
%r247 = getelementptr i64, i64* %r2, i32 7
%r248 = load i64, i64* %r247
%r249 = call i128 @mul64x64L(i64 %r245, i64 %r248)
%r250 = zext i384 %r242 to i512
%r251 = zext i128 %r249 to i512
%r252 = shl i512 %r251, 384
%r253 = or i512 %r250, %r252
%r255 = getelementptr i64, i64* %r2, i32 4
%r256 = load i64, i64* %r255
%r258 = getelementptr i64, i64* %r2, i32 8
%r259 = load i64, i64* %r258
%r260 = call i128 @mul64x64L(i64 %r256, i64 %r259)
%r261 = zext i512 %r253 to i640
%r262 = zext i128 %r260 to i640
%r263 = shl i640 %r262, 512
%r264 = or i640 %r261, %r263
%r266 = getelementptr i64, i64* %r2, i32 5
%r267 = load i64, i64* %r266
%r269 = getelementptr i64, i64* %r2, i32 9
%r270 = load i64, i64* %r269
%r271 = call i128 @mul64x64L(i64 %r267, i64 %r270)
%r272 = zext i640 %r264 to i768
%r273 = zext i128 %r271 to i768
%r274 = shl i768 %r273, 640
%r275 = or i768 %r272, %r274
%r277 = getelementptr i64, i64* %r2, i32 6
%r278 = load i64, i64* %r277
%r280 = getelementptr i64, i64* %r2, i32 10
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
%r292 = getelementptr i64, i64* %r2, i32 3
%r293 = load i64, i64* %r292
%r294 = call i128 @mul64x64L(i64 %r290, i64 %r293)
%r296 = getelementptr i64, i64* %r2, i32 1
%r297 = load i64, i64* %r296
%r299 = getelementptr i64, i64* %r2, i32 4
%r300 = load i64, i64* %r299
%r301 = call i128 @mul64x64L(i64 %r297, i64 %r300)
%r302 = zext i128 %r294 to i256
%r303 = zext i128 %r301 to i256
%r304 = shl i256 %r303, 128
%r305 = or i256 %r302, %r304
%r307 = getelementptr i64, i64* %r2, i32 2
%r308 = load i64, i64* %r307
%r310 = getelementptr i64, i64* %r2, i32 5
%r311 = load i64, i64* %r310
%r312 = call i128 @mul64x64L(i64 %r308, i64 %r311)
%r313 = zext i256 %r305 to i384
%r314 = zext i128 %r312 to i384
%r315 = shl i384 %r314, 256
%r316 = or i384 %r313, %r315
%r318 = getelementptr i64, i64* %r2, i32 3
%r319 = load i64, i64* %r318
%r321 = getelementptr i64, i64* %r2, i32 6
%r322 = load i64, i64* %r321
%r323 = call i128 @mul64x64L(i64 %r319, i64 %r322)
%r324 = zext i384 %r316 to i512
%r325 = zext i128 %r323 to i512
%r326 = shl i512 %r325, 384
%r327 = or i512 %r324, %r326
%r329 = getelementptr i64, i64* %r2, i32 4
%r330 = load i64, i64* %r329
%r332 = getelementptr i64, i64* %r2, i32 7
%r333 = load i64, i64* %r332
%r334 = call i128 @mul64x64L(i64 %r330, i64 %r333)
%r335 = zext i512 %r327 to i640
%r336 = zext i128 %r334 to i640
%r337 = shl i640 %r336, 512
%r338 = or i640 %r335, %r337
%r340 = getelementptr i64, i64* %r2, i32 5
%r341 = load i64, i64* %r340
%r343 = getelementptr i64, i64* %r2, i32 8
%r344 = load i64, i64* %r343
%r345 = call i128 @mul64x64L(i64 %r341, i64 %r344)
%r346 = zext i640 %r338 to i768
%r347 = zext i128 %r345 to i768
%r348 = shl i768 %r347, 640
%r349 = or i768 %r346, %r348
%r351 = getelementptr i64, i64* %r2, i32 6
%r352 = load i64, i64* %r351
%r354 = getelementptr i64, i64* %r2, i32 9
%r355 = load i64, i64* %r354
%r356 = call i128 @mul64x64L(i64 %r352, i64 %r355)
%r357 = zext i768 %r349 to i896
%r358 = zext i128 %r356 to i896
%r359 = shl i896 %r358, 768
%r360 = or i896 %r357, %r359
%r362 = getelementptr i64, i64* %r2, i32 7
%r363 = load i64, i64* %r362
%r365 = getelementptr i64, i64* %r2, i32 10
%r366 = load i64, i64* %r365
%r367 = call i128 @mul64x64L(i64 %r363, i64 %r366)
%r368 = zext i896 %r360 to i1024
%r369 = zext i128 %r367 to i1024
%r370 = shl i1024 %r369, 896
%r371 = or i1024 %r368, %r370
%r372 = zext i896 %r289 to i1024
%r373 = shl i1024 %r372, 64
%r374 = add i1024 %r373, %r371
%r375 = load i64, i64* %r2
%r377 = getelementptr i64, i64* %r2, i32 2
%r378 = load i64, i64* %r377
%r379 = call i128 @mul64x64L(i64 %r375, i64 %r378)
%r381 = getelementptr i64, i64* %r2, i32 1
%r382 = load i64, i64* %r381
%r384 = getelementptr i64, i64* %r2, i32 3
%r385 = load i64, i64* %r384
%r386 = call i128 @mul64x64L(i64 %r382, i64 %r385)
%r387 = zext i128 %r379 to i256
%r388 = zext i128 %r386 to i256
%r389 = shl i256 %r388, 128
%r390 = or i256 %r387, %r389
%r392 = getelementptr i64, i64* %r2, i32 2
%r393 = load i64, i64* %r392
%r395 = getelementptr i64, i64* %r2, i32 4
%r396 = load i64, i64* %r395
%r397 = call i128 @mul64x64L(i64 %r393, i64 %r396)
%r398 = zext i256 %r390 to i384
%r399 = zext i128 %r397 to i384
%r400 = shl i384 %r399, 256
%r401 = or i384 %r398, %r400
%r403 = getelementptr i64, i64* %r2, i32 3
%r404 = load i64, i64* %r403
%r406 = getelementptr i64, i64* %r2, i32 5
%r407 = load i64, i64* %r406
%r408 = call i128 @mul64x64L(i64 %r404, i64 %r407)
%r409 = zext i384 %r401 to i512
%r410 = zext i128 %r408 to i512
%r411 = shl i512 %r410, 384
%r412 = or i512 %r409, %r411
%r414 = getelementptr i64, i64* %r2, i32 4
%r415 = load i64, i64* %r414
%r417 = getelementptr i64, i64* %r2, i32 6
%r418 = load i64, i64* %r417
%r419 = call i128 @mul64x64L(i64 %r415, i64 %r418)
%r420 = zext i512 %r412 to i640
%r421 = zext i128 %r419 to i640
%r422 = shl i640 %r421, 512
%r423 = or i640 %r420, %r422
%r425 = getelementptr i64, i64* %r2, i32 5
%r426 = load i64, i64* %r425
%r428 = getelementptr i64, i64* %r2, i32 7
%r429 = load i64, i64* %r428
%r430 = call i128 @mul64x64L(i64 %r426, i64 %r429)
%r431 = zext i640 %r423 to i768
%r432 = zext i128 %r430 to i768
%r433 = shl i768 %r432, 640
%r434 = or i768 %r431, %r433
%r436 = getelementptr i64, i64* %r2, i32 6
%r437 = load i64, i64* %r436
%r439 = getelementptr i64, i64* %r2, i32 8
%r440 = load i64, i64* %r439
%r441 = call i128 @mul64x64L(i64 %r437, i64 %r440)
%r442 = zext i768 %r434 to i896
%r443 = zext i128 %r441 to i896
%r444 = shl i896 %r443, 768
%r445 = or i896 %r442, %r444
%r447 = getelementptr i64, i64* %r2, i32 7
%r448 = load i64, i64* %r447
%r450 = getelementptr i64, i64* %r2, i32 9
%r451 = load i64, i64* %r450
%r452 = call i128 @mul64x64L(i64 %r448, i64 %r451)
%r453 = zext i896 %r445 to i1024
%r454 = zext i128 %r452 to i1024
%r455 = shl i1024 %r454, 896
%r456 = or i1024 %r453, %r455
%r458 = getelementptr i64, i64* %r2, i32 8
%r459 = load i64, i64* %r458
%r461 = getelementptr i64, i64* %r2, i32 10
%r462 = load i64, i64* %r461
%r463 = call i128 @mul64x64L(i64 %r459, i64 %r462)
%r464 = zext i1024 %r456 to i1152
%r465 = zext i128 %r463 to i1152
%r466 = shl i1152 %r465, 1024
%r467 = or i1152 %r464, %r466
%r468 = zext i1024 %r374 to i1152
%r469 = shl i1152 %r468, 64
%r470 = add i1152 %r469, %r467
%r471 = load i64, i64* %r2
%r473 = getelementptr i64, i64* %r2, i32 1
%r474 = load i64, i64* %r473
%r475 = call i128 @mul64x64L(i64 %r471, i64 %r474)
%r477 = getelementptr i64, i64* %r2, i32 1
%r478 = load i64, i64* %r477
%r480 = getelementptr i64, i64* %r2, i32 2
%r481 = load i64, i64* %r480
%r482 = call i128 @mul64x64L(i64 %r478, i64 %r481)
%r483 = zext i128 %r475 to i256
%r484 = zext i128 %r482 to i256
%r485 = shl i256 %r484, 128
%r486 = or i256 %r483, %r485
%r488 = getelementptr i64, i64* %r2, i32 2
%r489 = load i64, i64* %r488
%r491 = getelementptr i64, i64* %r2, i32 3
%r492 = load i64, i64* %r491
%r493 = call i128 @mul64x64L(i64 %r489, i64 %r492)
%r494 = zext i256 %r486 to i384
%r495 = zext i128 %r493 to i384
%r496 = shl i384 %r495, 256
%r497 = or i384 %r494, %r496
%r499 = getelementptr i64, i64* %r2, i32 3
%r500 = load i64, i64* %r499
%r502 = getelementptr i64, i64* %r2, i32 4
%r503 = load i64, i64* %r502
%r504 = call i128 @mul64x64L(i64 %r500, i64 %r503)
%r505 = zext i384 %r497 to i512
%r506 = zext i128 %r504 to i512
%r507 = shl i512 %r506, 384
%r508 = or i512 %r505, %r507
%r510 = getelementptr i64, i64* %r2, i32 4
%r511 = load i64, i64* %r510
%r513 = getelementptr i64, i64* %r2, i32 5
%r514 = load i64, i64* %r513
%r515 = call i128 @mul64x64L(i64 %r511, i64 %r514)
%r516 = zext i512 %r508 to i640
%r517 = zext i128 %r515 to i640
%r518 = shl i640 %r517, 512
%r519 = or i640 %r516, %r518
%r521 = getelementptr i64, i64* %r2, i32 5
%r522 = load i64, i64* %r521
%r524 = getelementptr i64, i64* %r2, i32 6
%r525 = load i64, i64* %r524
%r526 = call i128 @mul64x64L(i64 %r522, i64 %r525)
%r527 = zext i640 %r519 to i768
%r528 = zext i128 %r526 to i768
%r529 = shl i768 %r528, 640
%r530 = or i768 %r527, %r529
%r532 = getelementptr i64, i64* %r2, i32 6
%r533 = load i64, i64* %r532
%r535 = getelementptr i64, i64* %r2, i32 7
%r536 = load i64, i64* %r535
%r537 = call i128 @mul64x64L(i64 %r533, i64 %r536)
%r538 = zext i768 %r530 to i896
%r539 = zext i128 %r537 to i896
%r540 = shl i896 %r539, 768
%r541 = or i896 %r538, %r540
%r543 = getelementptr i64, i64* %r2, i32 7
%r544 = load i64, i64* %r543
%r546 = getelementptr i64, i64* %r2, i32 8
%r547 = load i64, i64* %r546
%r548 = call i128 @mul64x64L(i64 %r544, i64 %r547)
%r549 = zext i896 %r541 to i1024
%r550 = zext i128 %r548 to i1024
%r551 = shl i1024 %r550, 896
%r552 = or i1024 %r549, %r551
%r554 = getelementptr i64, i64* %r2, i32 8
%r555 = load i64, i64* %r554
%r557 = getelementptr i64, i64* %r2, i32 9
%r558 = load i64, i64* %r557
%r559 = call i128 @mul64x64L(i64 %r555, i64 %r558)
%r560 = zext i1024 %r552 to i1152
%r561 = zext i128 %r559 to i1152
%r562 = shl i1152 %r561, 1024
%r563 = or i1152 %r560, %r562
%r565 = getelementptr i64, i64* %r2, i32 9
%r566 = load i64, i64* %r565
%r568 = getelementptr i64, i64* %r2, i32 10
%r569 = load i64, i64* %r568
%r570 = call i128 @mul64x64L(i64 %r566, i64 %r569)
%r571 = zext i1152 %r563 to i1280
%r572 = zext i128 %r570 to i1280
%r573 = shl i1280 %r572, 1152
%r574 = or i1280 %r571, %r573
%r575 = zext i1152 %r470 to i1280
%r576 = shl i1280 %r575, 64
%r577 = add i1280 %r576, %r574
%r578 = zext i128 %r6 to i1344
%r580 = getelementptr i64, i64* %r2, i32 1
%r581 = load i64, i64* %r580
%r582 = call i128 @mul64x64L(i64 %r581, i64 %r581)
%r583 = zext i128 %r582 to i1344
%r584 = shl i1344 %r583, 64
%r585 = or i1344 %r578, %r584
%r587 = getelementptr i64, i64* %r2, i32 2
%r588 = load i64, i64* %r587
%r589 = call i128 @mul64x64L(i64 %r588, i64 %r588)
%r590 = zext i128 %r589 to i1344
%r591 = shl i1344 %r590, 192
%r592 = or i1344 %r585, %r591
%r594 = getelementptr i64, i64* %r2, i32 3
%r595 = load i64, i64* %r594
%r596 = call i128 @mul64x64L(i64 %r595, i64 %r595)
%r597 = zext i128 %r596 to i1344
%r598 = shl i1344 %r597, 320
%r599 = or i1344 %r592, %r598
%r601 = getelementptr i64, i64* %r2, i32 4
%r602 = load i64, i64* %r601
%r603 = call i128 @mul64x64L(i64 %r602, i64 %r602)
%r604 = zext i128 %r603 to i1344
%r605 = shl i1344 %r604, 448
%r606 = or i1344 %r599, %r605
%r608 = getelementptr i64, i64* %r2, i32 5
%r609 = load i64, i64* %r608
%r610 = call i128 @mul64x64L(i64 %r609, i64 %r609)
%r611 = zext i128 %r610 to i1344
%r612 = shl i1344 %r611, 576
%r613 = or i1344 %r606, %r612
%r615 = getelementptr i64, i64* %r2, i32 6
%r616 = load i64, i64* %r615
%r617 = call i128 @mul64x64L(i64 %r616, i64 %r616)
%r618 = zext i128 %r617 to i1344
%r619 = shl i1344 %r618, 704
%r620 = or i1344 %r613, %r619
%r622 = getelementptr i64, i64* %r2, i32 7
%r623 = load i64, i64* %r622
%r624 = call i128 @mul64x64L(i64 %r623, i64 %r623)
%r625 = zext i128 %r624 to i1344
%r626 = shl i1344 %r625, 832
%r627 = or i1344 %r620, %r626
%r629 = getelementptr i64, i64* %r2, i32 8
%r630 = load i64, i64* %r629
%r631 = call i128 @mul64x64L(i64 %r630, i64 %r630)
%r632 = zext i128 %r631 to i1344
%r633 = shl i1344 %r632, 960
%r634 = or i1344 %r627, %r633
%r636 = getelementptr i64, i64* %r2, i32 9
%r637 = load i64, i64* %r636
%r638 = call i128 @mul64x64L(i64 %r637, i64 %r637)
%r639 = zext i128 %r638 to i1344
%r640 = shl i1344 %r639, 1088
%r641 = or i1344 %r634, %r640
%r643 = getelementptr i64, i64* %r2, i32 10
%r644 = load i64, i64* %r643
%r645 = call i128 @mul64x64L(i64 %r644, i64 %r644)
%r646 = zext i128 %r645 to i1344
%r647 = shl i1344 %r646, 1216
%r648 = or i1344 %r641, %r647
%r649 = zext i1280 %r577 to i1344
%r650 = add i1344 %r649, %r649
%r651 = add i1344 %r648, %r650
%r653 = getelementptr i64, i64* %r1, i32 1
%r655 = getelementptr i64, i64* %r653, i32 0
%r656 = trunc i1344 %r651 to i64
store i64 %r656, i64* %r655
%r657 = lshr i1344 %r651, 64
%r659 = getelementptr i64, i64* %r653, i32 1
%r660 = trunc i1344 %r657 to i64
store i64 %r660, i64* %r659
%r661 = lshr i1344 %r657, 64
%r663 = getelementptr i64, i64* %r653, i32 2
%r664 = trunc i1344 %r661 to i64
store i64 %r664, i64* %r663
%r665 = lshr i1344 %r661, 64
%r667 = getelementptr i64, i64* %r653, i32 3
%r668 = trunc i1344 %r665 to i64
store i64 %r668, i64* %r667
%r669 = lshr i1344 %r665, 64
%r671 = getelementptr i64, i64* %r653, i32 4
%r672 = trunc i1344 %r669 to i64
store i64 %r672, i64* %r671
%r673 = lshr i1344 %r669, 64
%r675 = getelementptr i64, i64* %r653, i32 5
%r676 = trunc i1344 %r673 to i64
store i64 %r676, i64* %r675
%r677 = lshr i1344 %r673, 64
%r679 = getelementptr i64, i64* %r653, i32 6
%r680 = trunc i1344 %r677 to i64
store i64 %r680, i64* %r679
%r681 = lshr i1344 %r677, 64
%r683 = getelementptr i64, i64* %r653, i32 7
%r684 = trunc i1344 %r681 to i64
store i64 %r684, i64* %r683
%r685 = lshr i1344 %r681, 64
%r687 = getelementptr i64, i64* %r653, i32 8
%r688 = trunc i1344 %r685 to i64
store i64 %r688, i64* %r687
%r689 = lshr i1344 %r685, 64
%r691 = getelementptr i64, i64* %r653, i32 9
%r692 = trunc i1344 %r689 to i64
store i64 %r692, i64* %r691
%r693 = lshr i1344 %r689, 64
%r695 = getelementptr i64, i64* %r653, i32 10
%r696 = trunc i1344 %r693 to i64
store i64 %r696, i64* %r695
%r697 = lshr i1344 %r693, 64
%r699 = getelementptr i64, i64* %r653, i32 11
%r700 = trunc i1344 %r697 to i64
store i64 %r700, i64* %r699
%r701 = lshr i1344 %r697, 64
%r703 = getelementptr i64, i64* %r653, i32 12
%r704 = trunc i1344 %r701 to i64
store i64 %r704, i64* %r703
%r705 = lshr i1344 %r701, 64
%r707 = getelementptr i64, i64* %r653, i32 13
%r708 = trunc i1344 %r705 to i64
store i64 %r708, i64* %r707
%r709 = lshr i1344 %r705, 64
%r711 = getelementptr i64, i64* %r653, i32 14
%r712 = trunc i1344 %r709 to i64
store i64 %r712, i64* %r711
%r713 = lshr i1344 %r709, 64
%r715 = getelementptr i64, i64* %r653, i32 15
%r716 = trunc i1344 %r713 to i64
store i64 %r716, i64* %r715
%r717 = lshr i1344 %r713, 64
%r719 = getelementptr i64, i64* %r653, i32 16
%r720 = trunc i1344 %r717 to i64
store i64 %r720, i64* %r719
%r721 = lshr i1344 %r717, 64
%r723 = getelementptr i64, i64* %r653, i32 17
%r724 = trunc i1344 %r721 to i64
store i64 %r724, i64* %r723
%r725 = lshr i1344 %r721, 64
%r727 = getelementptr i64, i64* %r653, i32 18
%r728 = trunc i1344 %r725 to i64
store i64 %r728, i64* %r727
%r729 = lshr i1344 %r725, 64
%r731 = getelementptr i64, i64* %r653, i32 19
%r732 = trunc i1344 %r729 to i64
store i64 %r732, i64* %r731
%r733 = lshr i1344 %r729, 64
%r735 = getelementptr i64, i64* %r653, i32 20
%r736 = trunc i1344 %r733 to i64
store i64 %r736, i64* %r735
ret void
}
define private i704 @mulUnit2_inner704(i64* noalias  %r2, i64 %r3)
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
%r41 = call i128 @mulPos64x64(i64* %r2, i64 %r3, i64 9)
%r42 = trunc i128 %r41 to i64
%r43 = call i64 @extractHigh64(i128 %r41)
%r45 = call i128 @mulPos64x64(i64* %r2, i64 %r3, i64 10)
%r46 = trunc i128 %r45 to i64
%r47 = zext i64 %r6 to i128
%r48 = zext i64 %r10 to i128
%r49 = shl i128 %r48, 64
%r50 = or i128 %r47, %r49
%r51 = zext i128 %r50 to i192
%r52 = zext i64 %r14 to i192
%r53 = shl i192 %r52, 128
%r54 = or i192 %r51, %r53
%r55 = zext i192 %r54 to i256
%r56 = zext i64 %r18 to i256
%r57 = shl i256 %r56, 192
%r58 = or i256 %r55, %r57
%r59 = zext i256 %r58 to i320
%r60 = zext i64 %r22 to i320
%r61 = shl i320 %r60, 256
%r62 = or i320 %r59, %r61
%r63 = zext i320 %r62 to i384
%r64 = zext i64 %r26 to i384
%r65 = shl i384 %r64, 320
%r66 = or i384 %r63, %r65
%r67 = zext i384 %r66 to i448
%r68 = zext i64 %r30 to i448
%r69 = shl i448 %r68, 384
%r70 = or i448 %r67, %r69
%r71 = zext i448 %r70 to i512
%r72 = zext i64 %r34 to i512
%r73 = shl i512 %r72, 448
%r74 = or i512 %r71, %r73
%r75 = zext i512 %r74 to i576
%r76 = zext i64 %r38 to i576
%r77 = shl i576 %r76, 512
%r78 = or i576 %r75, %r77
%r79 = zext i576 %r78 to i640
%r80 = zext i64 %r42 to i640
%r81 = shl i640 %r80, 576
%r82 = or i640 %r79, %r81
%r83 = zext i640 %r82 to i704
%r84 = zext i64 %r46 to i704
%r85 = shl i704 %r84, 640
%r86 = or i704 %r83, %r85
%r87 = zext i64 %r7 to i128
%r88 = zext i64 %r11 to i128
%r89 = shl i128 %r88, 64
%r90 = or i128 %r87, %r89
%r91 = zext i128 %r90 to i192
%r92 = zext i64 %r15 to i192
%r93 = shl i192 %r92, 128
%r94 = or i192 %r91, %r93
%r95 = zext i192 %r94 to i256
%r96 = zext i64 %r19 to i256
%r97 = shl i256 %r96, 192
%r98 = or i256 %r95, %r97
%r99 = zext i256 %r98 to i320
%r100 = zext i64 %r23 to i320
%r101 = shl i320 %r100, 256
%r102 = or i320 %r99, %r101
%r103 = zext i320 %r102 to i384
%r104 = zext i64 %r27 to i384
%r105 = shl i384 %r104, 320
%r106 = or i384 %r103, %r105
%r107 = zext i384 %r106 to i448
%r108 = zext i64 %r31 to i448
%r109 = shl i448 %r108, 384
%r110 = or i448 %r107, %r109
%r111 = zext i448 %r110 to i512
%r112 = zext i64 %r35 to i512
%r113 = shl i512 %r112, 448
%r114 = or i512 %r111, %r113
%r115 = zext i512 %r114 to i576
%r116 = zext i64 %r39 to i576
%r117 = shl i576 %r116, 512
%r118 = or i576 %r115, %r117
%r119 = zext i576 %r118 to i640
%r120 = zext i64 %r43 to i640
%r121 = shl i640 %r120, 576
%r122 = or i640 %r119, %r121
%r123 = zext i640 %r122 to i704
%r124 = shl i704 %r123, 64
%r125 = add i704 %r86, %r124
ret i704 %r125
}
define i832 @mulUnit_inner768(i64* noalias  %r2, i64 %r3)
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
%r41 = call i128 @mulPos64x64(i64* %r2, i64 %r3, i64 9)
%r42 = trunc i128 %r41 to i64
%r43 = call i64 @extractHigh64(i128 %r41)
%r45 = call i128 @mulPos64x64(i64* %r2, i64 %r3, i64 10)
%r46 = trunc i128 %r45 to i64
%r47 = call i64 @extractHigh64(i128 %r45)
%r49 = call i128 @mulPos64x64(i64* %r2, i64 %r3, i64 11)
%r50 = trunc i128 %r49 to i64
%r51 = call i64 @extractHigh64(i128 %r49)
%r52 = zext i64 %r6 to i128
%r53 = zext i64 %r10 to i128
%r54 = shl i128 %r53, 64
%r55 = or i128 %r52, %r54
%r56 = zext i128 %r55 to i192
%r57 = zext i64 %r14 to i192
%r58 = shl i192 %r57, 128
%r59 = or i192 %r56, %r58
%r60 = zext i192 %r59 to i256
%r61 = zext i64 %r18 to i256
%r62 = shl i256 %r61, 192
%r63 = or i256 %r60, %r62
%r64 = zext i256 %r63 to i320
%r65 = zext i64 %r22 to i320
%r66 = shl i320 %r65, 256
%r67 = or i320 %r64, %r66
%r68 = zext i320 %r67 to i384
%r69 = zext i64 %r26 to i384
%r70 = shl i384 %r69, 320
%r71 = or i384 %r68, %r70
%r72 = zext i384 %r71 to i448
%r73 = zext i64 %r30 to i448
%r74 = shl i448 %r73, 384
%r75 = or i448 %r72, %r74
%r76 = zext i448 %r75 to i512
%r77 = zext i64 %r34 to i512
%r78 = shl i512 %r77, 448
%r79 = or i512 %r76, %r78
%r80 = zext i512 %r79 to i576
%r81 = zext i64 %r38 to i576
%r82 = shl i576 %r81, 512
%r83 = or i576 %r80, %r82
%r84 = zext i576 %r83 to i640
%r85 = zext i64 %r42 to i640
%r86 = shl i640 %r85, 576
%r87 = or i640 %r84, %r86
%r88 = zext i640 %r87 to i704
%r89 = zext i64 %r46 to i704
%r90 = shl i704 %r89, 640
%r91 = or i704 %r88, %r90
%r92 = zext i704 %r91 to i768
%r93 = zext i64 %r50 to i768
%r94 = shl i768 %r93, 704
%r95 = or i768 %r92, %r94
%r96 = zext i64 %r7 to i128
%r97 = zext i64 %r11 to i128
%r98 = shl i128 %r97, 64
%r99 = or i128 %r96, %r98
%r100 = zext i128 %r99 to i192
%r101 = zext i64 %r15 to i192
%r102 = shl i192 %r101, 128
%r103 = or i192 %r100, %r102
%r104 = zext i192 %r103 to i256
%r105 = zext i64 %r19 to i256
%r106 = shl i256 %r105, 192
%r107 = or i256 %r104, %r106
%r108 = zext i256 %r107 to i320
%r109 = zext i64 %r23 to i320
%r110 = shl i320 %r109, 256
%r111 = or i320 %r108, %r110
%r112 = zext i320 %r111 to i384
%r113 = zext i64 %r27 to i384
%r114 = shl i384 %r113, 320
%r115 = or i384 %r112, %r114
%r116 = zext i384 %r115 to i448
%r117 = zext i64 %r31 to i448
%r118 = shl i448 %r117, 384
%r119 = or i448 %r116, %r118
%r120 = zext i448 %r119 to i512
%r121 = zext i64 %r35 to i512
%r122 = shl i512 %r121, 448
%r123 = or i512 %r120, %r122
%r124 = zext i512 %r123 to i576
%r125 = zext i64 %r39 to i576
%r126 = shl i576 %r125, 512
%r127 = or i576 %r124, %r126
%r128 = zext i576 %r127 to i640
%r129 = zext i64 %r43 to i640
%r130 = shl i640 %r129, 576
%r131 = or i640 %r128, %r130
%r132 = zext i640 %r131 to i704
%r133 = zext i64 %r47 to i704
%r134 = shl i704 %r133, 640
%r135 = or i704 %r132, %r134
%r136 = zext i704 %r135 to i768
%r137 = zext i64 %r51 to i768
%r138 = shl i768 %r137, 704
%r139 = or i768 %r136, %r138
%r140 = zext i768 %r95 to i832
%r141 = zext i768 %r139 to i832
%r142 = shl i832 %r141, 64
%r143 = add i832 %r140, %r142
ret i832 %r143
}
define i64 @mclb_mulUnit12(i64* noalias  %r2, i64* noalias  %r3, i64 %r4)
{
%r5 = call i832 @mulUnit_inner768(i64* %r3, i64 %r4)
%r6 = trunc i832 %r5 to i768
%r8 = getelementptr i64, i64* %r2, i32 0
%r9 = trunc i768 %r6 to i64
store i64 %r9, i64* %r8
%r10 = lshr i768 %r6, 64
%r12 = getelementptr i64, i64* %r2, i32 1
%r13 = trunc i768 %r10 to i64
store i64 %r13, i64* %r12
%r14 = lshr i768 %r10, 64
%r16 = getelementptr i64, i64* %r2, i32 2
%r17 = trunc i768 %r14 to i64
store i64 %r17, i64* %r16
%r18 = lshr i768 %r14, 64
%r20 = getelementptr i64, i64* %r2, i32 3
%r21 = trunc i768 %r18 to i64
store i64 %r21, i64* %r20
%r22 = lshr i768 %r18, 64
%r24 = getelementptr i64, i64* %r2, i32 4
%r25 = trunc i768 %r22 to i64
store i64 %r25, i64* %r24
%r26 = lshr i768 %r22, 64
%r28 = getelementptr i64, i64* %r2, i32 5
%r29 = trunc i768 %r26 to i64
store i64 %r29, i64* %r28
%r30 = lshr i768 %r26, 64
%r32 = getelementptr i64, i64* %r2, i32 6
%r33 = trunc i768 %r30 to i64
store i64 %r33, i64* %r32
%r34 = lshr i768 %r30, 64
%r36 = getelementptr i64, i64* %r2, i32 7
%r37 = trunc i768 %r34 to i64
store i64 %r37, i64* %r36
%r38 = lshr i768 %r34, 64
%r40 = getelementptr i64, i64* %r2, i32 8
%r41 = trunc i768 %r38 to i64
store i64 %r41, i64* %r40
%r42 = lshr i768 %r38, 64
%r44 = getelementptr i64, i64* %r2, i32 9
%r45 = trunc i768 %r42 to i64
store i64 %r45, i64* %r44
%r46 = lshr i768 %r42, 64
%r48 = getelementptr i64, i64* %r2, i32 10
%r49 = trunc i768 %r46 to i64
store i64 %r49, i64* %r48
%r50 = lshr i768 %r46, 64
%r52 = getelementptr i64, i64* %r2, i32 11
%r53 = trunc i768 %r50 to i64
store i64 %r53, i64* %r52
%r54 = lshr i832 %r5, 768
%r55 = trunc i832 %r54 to i64
ret i64 %r55
}
define i64 @mclb_mulUnitAdd12(i64* noalias  %r2, i64* noalias  %r3, i64 %r4)
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
%r42 = call i128 @mulPos64x64(i64* %r3, i64 %r4, i64 9)
%r43 = trunc i128 %r42 to i64
%r44 = call i64 @extractHigh64(i128 %r42)
%r46 = call i128 @mulPos64x64(i64* %r3, i64 %r4, i64 10)
%r47 = trunc i128 %r46 to i64
%r48 = call i64 @extractHigh64(i128 %r46)
%r50 = call i128 @mulPos64x64(i64* %r3, i64 %r4, i64 11)
%r51 = trunc i128 %r50 to i64
%r52 = call i64 @extractHigh64(i128 %r50)
%r53 = zext i64 %r7 to i128
%r54 = zext i64 %r11 to i128
%r55 = shl i128 %r54, 64
%r56 = or i128 %r53, %r55
%r57 = zext i128 %r56 to i192
%r58 = zext i64 %r15 to i192
%r59 = shl i192 %r58, 128
%r60 = or i192 %r57, %r59
%r61 = zext i192 %r60 to i256
%r62 = zext i64 %r19 to i256
%r63 = shl i256 %r62, 192
%r64 = or i256 %r61, %r63
%r65 = zext i256 %r64 to i320
%r66 = zext i64 %r23 to i320
%r67 = shl i320 %r66, 256
%r68 = or i320 %r65, %r67
%r69 = zext i320 %r68 to i384
%r70 = zext i64 %r27 to i384
%r71 = shl i384 %r70, 320
%r72 = or i384 %r69, %r71
%r73 = zext i384 %r72 to i448
%r74 = zext i64 %r31 to i448
%r75 = shl i448 %r74, 384
%r76 = or i448 %r73, %r75
%r77 = zext i448 %r76 to i512
%r78 = zext i64 %r35 to i512
%r79 = shl i512 %r78, 448
%r80 = or i512 %r77, %r79
%r81 = zext i512 %r80 to i576
%r82 = zext i64 %r39 to i576
%r83 = shl i576 %r82, 512
%r84 = or i576 %r81, %r83
%r85 = zext i576 %r84 to i640
%r86 = zext i64 %r43 to i640
%r87 = shl i640 %r86, 576
%r88 = or i640 %r85, %r87
%r89 = zext i640 %r88 to i704
%r90 = zext i64 %r47 to i704
%r91 = shl i704 %r90, 640
%r92 = or i704 %r89, %r91
%r93 = zext i704 %r92 to i768
%r94 = zext i64 %r51 to i768
%r95 = shl i768 %r94, 704
%r96 = or i768 %r93, %r95
%r97 = zext i64 %r8 to i128
%r98 = zext i64 %r12 to i128
%r99 = shl i128 %r98, 64
%r100 = or i128 %r97, %r99
%r101 = zext i128 %r100 to i192
%r102 = zext i64 %r16 to i192
%r103 = shl i192 %r102, 128
%r104 = or i192 %r101, %r103
%r105 = zext i192 %r104 to i256
%r106 = zext i64 %r20 to i256
%r107 = shl i256 %r106, 192
%r108 = or i256 %r105, %r107
%r109 = zext i256 %r108 to i320
%r110 = zext i64 %r24 to i320
%r111 = shl i320 %r110, 256
%r112 = or i320 %r109, %r111
%r113 = zext i320 %r112 to i384
%r114 = zext i64 %r28 to i384
%r115 = shl i384 %r114, 320
%r116 = or i384 %r113, %r115
%r117 = zext i384 %r116 to i448
%r118 = zext i64 %r32 to i448
%r119 = shl i448 %r118, 384
%r120 = or i448 %r117, %r119
%r121 = zext i448 %r120 to i512
%r122 = zext i64 %r36 to i512
%r123 = shl i512 %r122, 448
%r124 = or i512 %r121, %r123
%r125 = zext i512 %r124 to i576
%r126 = zext i64 %r40 to i576
%r127 = shl i576 %r126, 512
%r128 = or i576 %r125, %r127
%r129 = zext i576 %r128 to i640
%r130 = zext i64 %r44 to i640
%r131 = shl i640 %r130, 576
%r132 = or i640 %r129, %r131
%r133 = zext i640 %r132 to i704
%r134 = zext i64 %r48 to i704
%r135 = shl i704 %r134, 640
%r136 = or i704 %r133, %r135
%r137 = zext i704 %r136 to i768
%r138 = zext i64 %r52 to i768
%r139 = shl i768 %r138, 704
%r140 = or i768 %r137, %r139
%r141 = zext i768 %r96 to i832
%r142 = zext i768 %r140 to i832
%r143 = shl i832 %r142, 64
%r144 = add i832 %r141, %r143
%r146 = bitcast i64* %r2 to i768*
%r147 = load i768, i768* %r146
%r148 = zext i768 %r147 to i832
%r149 = add i832 %r144, %r148
%r150 = trunc i832 %r149 to i768
%r152 = getelementptr i64, i64* %r2, i32 0
%r153 = trunc i768 %r150 to i64
store i64 %r153, i64* %r152
%r154 = lshr i768 %r150, 64
%r156 = getelementptr i64, i64* %r2, i32 1
%r157 = trunc i768 %r154 to i64
store i64 %r157, i64* %r156
%r158 = lshr i768 %r154, 64
%r160 = getelementptr i64, i64* %r2, i32 2
%r161 = trunc i768 %r158 to i64
store i64 %r161, i64* %r160
%r162 = lshr i768 %r158, 64
%r164 = getelementptr i64, i64* %r2, i32 3
%r165 = trunc i768 %r162 to i64
store i64 %r165, i64* %r164
%r166 = lshr i768 %r162, 64
%r168 = getelementptr i64, i64* %r2, i32 4
%r169 = trunc i768 %r166 to i64
store i64 %r169, i64* %r168
%r170 = lshr i768 %r166, 64
%r172 = getelementptr i64, i64* %r2, i32 5
%r173 = trunc i768 %r170 to i64
store i64 %r173, i64* %r172
%r174 = lshr i768 %r170, 64
%r176 = getelementptr i64, i64* %r2, i32 6
%r177 = trunc i768 %r174 to i64
store i64 %r177, i64* %r176
%r178 = lshr i768 %r174, 64
%r180 = getelementptr i64, i64* %r2, i32 7
%r181 = trunc i768 %r178 to i64
store i64 %r181, i64* %r180
%r182 = lshr i768 %r178, 64
%r184 = getelementptr i64, i64* %r2, i32 8
%r185 = trunc i768 %r182 to i64
store i64 %r185, i64* %r184
%r186 = lshr i768 %r182, 64
%r188 = getelementptr i64, i64* %r2, i32 9
%r189 = trunc i768 %r186 to i64
store i64 %r189, i64* %r188
%r190 = lshr i768 %r186, 64
%r192 = getelementptr i64, i64* %r2, i32 10
%r193 = trunc i768 %r190 to i64
store i64 %r193, i64* %r192
%r194 = lshr i768 %r190, 64
%r196 = getelementptr i64, i64* %r2, i32 11
%r197 = trunc i768 %r194 to i64
store i64 %r197, i64* %r196
%r198 = lshr i832 %r149, 768
%r199 = trunc i832 %r198 to i64
ret i64 %r199
}
define void @mclb_mul12(i64* noalias  %r1, i64* noalias  %r2, i64* noalias  %r3)
{
%r5 = getelementptr i64, i64* %r2, i32 6
%r7 = getelementptr i64, i64* %r3, i32 6
%r9 = getelementptr i64, i64* %r1, i32 12
call void @mclb_mul6(i64* %r1, i64* %r2, i64* %r3)
call void @mclb_mul6(i64* %r9, i64* %r5, i64* %r7)
%r11 = bitcast i64* %r5 to i384*
%r12 = load i384, i384* %r11
%r13 = zext i384 %r12 to i448
%r15 = bitcast i64* %r2 to i384*
%r16 = load i384, i384* %r15
%r17 = zext i384 %r16 to i448
%r19 = bitcast i64* %r7 to i384*
%r20 = load i384, i384* %r19
%r21 = zext i384 %r20 to i448
%r23 = bitcast i64* %r3 to i384*
%r24 = load i384, i384* %r23
%r25 = zext i384 %r24 to i448
%r26 = add i448 %r13, %r17
%r27 = add i448 %r21, %r25
%r29 = alloca i64, i32 12
%r30 = trunc i448 %r26 to i384
%r31 = trunc i448 %r27 to i384
%r32 = lshr i448 %r26, 384
%r33 = trunc i448 %r32 to i1
%r34 = lshr i448 %r27, 384
%r35 = trunc i448 %r34 to i1
%r36 = and i1 %r33, %r35
%r38 = select i1 %r33, i384 %r31, i384 0
%r40 = select i1 %r35, i384 %r30, i384 0
%r42 = alloca i64, i32 6
%r44 = alloca i64, i32 6
%r46 = getelementptr i64, i64* %r42, i32 0
%r47 = trunc i384 %r30 to i64
store i64 %r47, i64* %r46
%r48 = lshr i384 %r30, 64
%r50 = getelementptr i64, i64* %r42, i32 1
%r51 = trunc i384 %r48 to i64
store i64 %r51, i64* %r50
%r52 = lshr i384 %r48, 64
%r54 = getelementptr i64, i64* %r42, i32 2
%r55 = trunc i384 %r52 to i64
store i64 %r55, i64* %r54
%r56 = lshr i384 %r52, 64
%r58 = getelementptr i64, i64* %r42, i32 3
%r59 = trunc i384 %r56 to i64
store i64 %r59, i64* %r58
%r60 = lshr i384 %r56, 64
%r62 = getelementptr i64, i64* %r42, i32 4
%r63 = trunc i384 %r60 to i64
store i64 %r63, i64* %r62
%r64 = lshr i384 %r60, 64
%r66 = getelementptr i64, i64* %r42, i32 5
%r67 = trunc i384 %r64 to i64
store i64 %r67, i64* %r66
%r69 = getelementptr i64, i64* %r44, i32 0
%r70 = trunc i384 %r31 to i64
store i64 %r70, i64* %r69
%r71 = lshr i384 %r31, 64
%r73 = getelementptr i64, i64* %r44, i32 1
%r74 = trunc i384 %r71 to i64
store i64 %r74, i64* %r73
%r75 = lshr i384 %r71, 64
%r77 = getelementptr i64, i64* %r44, i32 2
%r78 = trunc i384 %r75 to i64
store i64 %r78, i64* %r77
%r79 = lshr i384 %r75, 64
%r81 = getelementptr i64, i64* %r44, i32 3
%r82 = trunc i384 %r79 to i64
store i64 %r82, i64* %r81
%r83 = lshr i384 %r79, 64
%r85 = getelementptr i64, i64* %r44, i32 4
%r86 = trunc i384 %r83 to i64
store i64 %r86, i64* %r85
%r87 = lshr i384 %r83, 64
%r89 = getelementptr i64, i64* %r44, i32 5
%r90 = trunc i384 %r87 to i64
store i64 %r90, i64* %r89
call void @mclb_mul6(i64* %r29, i64* %r42, i64* %r44)
%r92 = bitcast i64* %r29 to i768*
%r93 = load i768, i768* %r92
%r94 = zext i768 %r93 to i832
%r95 = zext i1 %r36 to i832
%r96 = shl i832 %r95, 768
%r97 = or i832 %r94, %r96
%r98 = zext i384 %r38 to i832
%r99 = zext i384 %r40 to i832
%r100 = shl i832 %r98, 384
%r101 = shl i832 %r99, 384
%r102 = add i832 %r97, %r100
%r103 = add i832 %r102, %r101
%r105 = bitcast i64* %r1 to i768*
%r106 = load i768, i768* %r105
%r107 = zext i768 %r106 to i832
%r108 = sub i832 %r103, %r107
%r110 = getelementptr i64, i64* %r1, i32 12
%r112 = bitcast i64* %r110 to i768*
%r113 = load i768, i768* %r112
%r114 = zext i768 %r113 to i832
%r115 = sub i832 %r108, %r114
%r116 = zext i832 %r115 to i1152
%r118 = getelementptr i64, i64* %r1, i32 6
%r120 = bitcast i64* %r118 to i1152*
%r121 = load i1152, i1152* %r120
%r122 = add i1152 %r116, %r121
%r124 = getelementptr i64, i64* %r1, i32 6
%r126 = getelementptr i64, i64* %r124, i32 0
%r127 = trunc i1152 %r122 to i64
store i64 %r127, i64* %r126
%r128 = lshr i1152 %r122, 64
%r130 = getelementptr i64, i64* %r124, i32 1
%r131 = trunc i1152 %r128 to i64
store i64 %r131, i64* %r130
%r132 = lshr i1152 %r128, 64
%r134 = getelementptr i64, i64* %r124, i32 2
%r135 = trunc i1152 %r132 to i64
store i64 %r135, i64* %r134
%r136 = lshr i1152 %r132, 64
%r138 = getelementptr i64, i64* %r124, i32 3
%r139 = trunc i1152 %r136 to i64
store i64 %r139, i64* %r138
%r140 = lshr i1152 %r136, 64
%r142 = getelementptr i64, i64* %r124, i32 4
%r143 = trunc i1152 %r140 to i64
store i64 %r143, i64* %r142
%r144 = lshr i1152 %r140, 64
%r146 = getelementptr i64, i64* %r124, i32 5
%r147 = trunc i1152 %r144 to i64
store i64 %r147, i64* %r146
%r148 = lshr i1152 %r144, 64
%r150 = getelementptr i64, i64* %r124, i32 6
%r151 = trunc i1152 %r148 to i64
store i64 %r151, i64* %r150
%r152 = lshr i1152 %r148, 64
%r154 = getelementptr i64, i64* %r124, i32 7
%r155 = trunc i1152 %r152 to i64
store i64 %r155, i64* %r154
%r156 = lshr i1152 %r152, 64
%r158 = getelementptr i64, i64* %r124, i32 8
%r159 = trunc i1152 %r156 to i64
store i64 %r159, i64* %r158
%r160 = lshr i1152 %r156, 64
%r162 = getelementptr i64, i64* %r124, i32 9
%r163 = trunc i1152 %r160 to i64
store i64 %r163, i64* %r162
%r164 = lshr i1152 %r160, 64
%r166 = getelementptr i64, i64* %r124, i32 10
%r167 = trunc i1152 %r164 to i64
store i64 %r167, i64* %r166
%r168 = lshr i1152 %r164, 64
%r170 = getelementptr i64, i64* %r124, i32 11
%r171 = trunc i1152 %r168 to i64
store i64 %r171, i64* %r170
%r172 = lshr i1152 %r168, 64
%r174 = getelementptr i64, i64* %r124, i32 12
%r175 = trunc i1152 %r172 to i64
store i64 %r175, i64* %r174
%r176 = lshr i1152 %r172, 64
%r178 = getelementptr i64, i64* %r124, i32 13
%r179 = trunc i1152 %r176 to i64
store i64 %r179, i64* %r178
%r180 = lshr i1152 %r176, 64
%r182 = getelementptr i64, i64* %r124, i32 14
%r183 = trunc i1152 %r180 to i64
store i64 %r183, i64* %r182
%r184 = lshr i1152 %r180, 64
%r186 = getelementptr i64, i64* %r124, i32 15
%r187 = trunc i1152 %r184 to i64
store i64 %r187, i64* %r186
%r188 = lshr i1152 %r184, 64
%r190 = getelementptr i64, i64* %r124, i32 16
%r191 = trunc i1152 %r188 to i64
store i64 %r191, i64* %r190
%r192 = lshr i1152 %r188, 64
%r194 = getelementptr i64, i64* %r124, i32 17
%r195 = trunc i1152 %r192 to i64
store i64 %r195, i64* %r194
ret void
}
define void @mclb_sqr12(i64* noalias  %r1, i64* noalias  %r2)
{
%r4 = getelementptr i64, i64* %r2, i32 6
%r6 = getelementptr i64, i64* %r1, i32 12
%r8 = alloca i64, i32 12
call void @mclb_mul6(i64* %r8, i64* %r2, i64* %r4)
call void @mclb_sqr6(i64* %r1, i64* %r2)
call void @mclb_sqr6(i64* %r6, i64* %r4)
%r10 = bitcast i64* %r8 to i768*
%r11 = load i768, i768* %r10
%r12 = zext i768 %r11 to i832
%r13 = add i832 %r12, %r12
%r14 = zext i832 %r13 to i1152
%r16 = getelementptr i64, i64* %r1, i32 6
%r18 = bitcast i64* %r16 to i1152*
%r19 = load i1152, i1152* %r18
%r20 = add i1152 %r19, %r14
%r22 = getelementptr i64, i64* %r16, i32 0
%r23 = trunc i1152 %r20 to i64
store i64 %r23, i64* %r22
%r24 = lshr i1152 %r20, 64
%r26 = getelementptr i64, i64* %r16, i32 1
%r27 = trunc i1152 %r24 to i64
store i64 %r27, i64* %r26
%r28 = lshr i1152 %r24, 64
%r30 = getelementptr i64, i64* %r16, i32 2
%r31 = trunc i1152 %r28 to i64
store i64 %r31, i64* %r30
%r32 = lshr i1152 %r28, 64
%r34 = getelementptr i64, i64* %r16, i32 3
%r35 = trunc i1152 %r32 to i64
store i64 %r35, i64* %r34
%r36 = lshr i1152 %r32, 64
%r38 = getelementptr i64, i64* %r16, i32 4
%r39 = trunc i1152 %r36 to i64
store i64 %r39, i64* %r38
%r40 = lshr i1152 %r36, 64
%r42 = getelementptr i64, i64* %r16, i32 5
%r43 = trunc i1152 %r40 to i64
store i64 %r43, i64* %r42
%r44 = lshr i1152 %r40, 64
%r46 = getelementptr i64, i64* %r16, i32 6
%r47 = trunc i1152 %r44 to i64
store i64 %r47, i64* %r46
%r48 = lshr i1152 %r44, 64
%r50 = getelementptr i64, i64* %r16, i32 7
%r51 = trunc i1152 %r48 to i64
store i64 %r51, i64* %r50
%r52 = lshr i1152 %r48, 64
%r54 = getelementptr i64, i64* %r16, i32 8
%r55 = trunc i1152 %r52 to i64
store i64 %r55, i64* %r54
%r56 = lshr i1152 %r52, 64
%r58 = getelementptr i64, i64* %r16, i32 9
%r59 = trunc i1152 %r56 to i64
store i64 %r59, i64* %r58
%r60 = lshr i1152 %r56, 64
%r62 = getelementptr i64, i64* %r16, i32 10
%r63 = trunc i1152 %r60 to i64
store i64 %r63, i64* %r62
%r64 = lshr i1152 %r60, 64
%r66 = getelementptr i64, i64* %r16, i32 11
%r67 = trunc i1152 %r64 to i64
store i64 %r67, i64* %r66
%r68 = lshr i1152 %r64, 64
%r70 = getelementptr i64, i64* %r16, i32 12
%r71 = trunc i1152 %r68 to i64
store i64 %r71, i64* %r70
%r72 = lshr i1152 %r68, 64
%r74 = getelementptr i64, i64* %r16, i32 13
%r75 = trunc i1152 %r72 to i64
store i64 %r75, i64* %r74
%r76 = lshr i1152 %r72, 64
%r78 = getelementptr i64, i64* %r16, i32 14
%r79 = trunc i1152 %r76 to i64
store i64 %r79, i64* %r78
%r80 = lshr i1152 %r76, 64
%r82 = getelementptr i64, i64* %r16, i32 15
%r83 = trunc i1152 %r80 to i64
store i64 %r83, i64* %r82
%r84 = lshr i1152 %r80, 64
%r86 = getelementptr i64, i64* %r16, i32 16
%r87 = trunc i1152 %r84 to i64
store i64 %r87, i64* %r86
%r88 = lshr i1152 %r84, 64
%r90 = getelementptr i64, i64* %r16, i32 17
%r91 = trunc i1152 %r88 to i64
store i64 %r91, i64* %r90
ret void
}
define private i768 @mulUnit2_inner768(i64* noalias  %r2, i64 %r3)
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
%r41 = call i128 @mulPos64x64(i64* %r2, i64 %r3, i64 9)
%r42 = trunc i128 %r41 to i64
%r43 = call i64 @extractHigh64(i128 %r41)
%r45 = call i128 @mulPos64x64(i64* %r2, i64 %r3, i64 10)
%r46 = trunc i128 %r45 to i64
%r47 = call i64 @extractHigh64(i128 %r45)
%r49 = call i128 @mulPos64x64(i64* %r2, i64 %r3, i64 11)
%r50 = trunc i128 %r49 to i64
%r51 = zext i64 %r6 to i128
%r52 = zext i64 %r10 to i128
%r53 = shl i128 %r52, 64
%r54 = or i128 %r51, %r53
%r55 = zext i128 %r54 to i192
%r56 = zext i64 %r14 to i192
%r57 = shl i192 %r56, 128
%r58 = or i192 %r55, %r57
%r59 = zext i192 %r58 to i256
%r60 = zext i64 %r18 to i256
%r61 = shl i256 %r60, 192
%r62 = or i256 %r59, %r61
%r63 = zext i256 %r62 to i320
%r64 = zext i64 %r22 to i320
%r65 = shl i320 %r64, 256
%r66 = or i320 %r63, %r65
%r67 = zext i320 %r66 to i384
%r68 = zext i64 %r26 to i384
%r69 = shl i384 %r68, 320
%r70 = or i384 %r67, %r69
%r71 = zext i384 %r70 to i448
%r72 = zext i64 %r30 to i448
%r73 = shl i448 %r72, 384
%r74 = or i448 %r71, %r73
%r75 = zext i448 %r74 to i512
%r76 = zext i64 %r34 to i512
%r77 = shl i512 %r76, 448
%r78 = or i512 %r75, %r77
%r79 = zext i512 %r78 to i576
%r80 = zext i64 %r38 to i576
%r81 = shl i576 %r80, 512
%r82 = or i576 %r79, %r81
%r83 = zext i576 %r82 to i640
%r84 = zext i64 %r42 to i640
%r85 = shl i640 %r84, 576
%r86 = or i640 %r83, %r85
%r87 = zext i640 %r86 to i704
%r88 = zext i64 %r46 to i704
%r89 = shl i704 %r88, 640
%r90 = or i704 %r87, %r89
%r91 = zext i704 %r90 to i768
%r92 = zext i64 %r50 to i768
%r93 = shl i768 %r92, 704
%r94 = or i768 %r91, %r93
%r95 = zext i64 %r7 to i128
%r96 = zext i64 %r11 to i128
%r97 = shl i128 %r96, 64
%r98 = or i128 %r95, %r97
%r99 = zext i128 %r98 to i192
%r100 = zext i64 %r15 to i192
%r101 = shl i192 %r100, 128
%r102 = or i192 %r99, %r101
%r103 = zext i192 %r102 to i256
%r104 = zext i64 %r19 to i256
%r105 = shl i256 %r104, 192
%r106 = or i256 %r103, %r105
%r107 = zext i256 %r106 to i320
%r108 = zext i64 %r23 to i320
%r109 = shl i320 %r108, 256
%r110 = or i320 %r107, %r109
%r111 = zext i320 %r110 to i384
%r112 = zext i64 %r27 to i384
%r113 = shl i384 %r112, 320
%r114 = or i384 %r111, %r113
%r115 = zext i384 %r114 to i448
%r116 = zext i64 %r31 to i448
%r117 = shl i448 %r116, 384
%r118 = or i448 %r115, %r117
%r119 = zext i448 %r118 to i512
%r120 = zext i64 %r35 to i512
%r121 = shl i512 %r120, 448
%r122 = or i512 %r119, %r121
%r123 = zext i512 %r122 to i576
%r124 = zext i64 %r39 to i576
%r125 = shl i576 %r124, 512
%r126 = or i576 %r123, %r125
%r127 = zext i576 %r126 to i640
%r128 = zext i64 %r43 to i640
%r129 = shl i640 %r128, 576
%r130 = or i640 %r127, %r129
%r131 = zext i640 %r130 to i704
%r132 = zext i64 %r47 to i704
%r133 = shl i704 %r132, 640
%r134 = or i704 %r131, %r133
%r135 = zext i704 %r134 to i768
%r136 = shl i768 %r135, 64
%r137 = add i768 %r94, %r136
ret i768 %r137
}
define i896 @mulUnit_inner832(i64* noalias  %r2, i64 %r3)
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
%r41 = call i128 @mulPos64x64(i64* %r2, i64 %r3, i64 9)
%r42 = trunc i128 %r41 to i64
%r43 = call i64 @extractHigh64(i128 %r41)
%r45 = call i128 @mulPos64x64(i64* %r2, i64 %r3, i64 10)
%r46 = trunc i128 %r45 to i64
%r47 = call i64 @extractHigh64(i128 %r45)
%r49 = call i128 @mulPos64x64(i64* %r2, i64 %r3, i64 11)
%r50 = trunc i128 %r49 to i64
%r51 = call i64 @extractHigh64(i128 %r49)
%r53 = call i128 @mulPos64x64(i64* %r2, i64 %r3, i64 12)
%r54 = trunc i128 %r53 to i64
%r55 = call i64 @extractHigh64(i128 %r53)
%r56 = zext i64 %r6 to i128
%r57 = zext i64 %r10 to i128
%r58 = shl i128 %r57, 64
%r59 = or i128 %r56, %r58
%r60 = zext i128 %r59 to i192
%r61 = zext i64 %r14 to i192
%r62 = shl i192 %r61, 128
%r63 = or i192 %r60, %r62
%r64 = zext i192 %r63 to i256
%r65 = zext i64 %r18 to i256
%r66 = shl i256 %r65, 192
%r67 = or i256 %r64, %r66
%r68 = zext i256 %r67 to i320
%r69 = zext i64 %r22 to i320
%r70 = shl i320 %r69, 256
%r71 = or i320 %r68, %r70
%r72 = zext i320 %r71 to i384
%r73 = zext i64 %r26 to i384
%r74 = shl i384 %r73, 320
%r75 = or i384 %r72, %r74
%r76 = zext i384 %r75 to i448
%r77 = zext i64 %r30 to i448
%r78 = shl i448 %r77, 384
%r79 = or i448 %r76, %r78
%r80 = zext i448 %r79 to i512
%r81 = zext i64 %r34 to i512
%r82 = shl i512 %r81, 448
%r83 = or i512 %r80, %r82
%r84 = zext i512 %r83 to i576
%r85 = zext i64 %r38 to i576
%r86 = shl i576 %r85, 512
%r87 = or i576 %r84, %r86
%r88 = zext i576 %r87 to i640
%r89 = zext i64 %r42 to i640
%r90 = shl i640 %r89, 576
%r91 = or i640 %r88, %r90
%r92 = zext i640 %r91 to i704
%r93 = zext i64 %r46 to i704
%r94 = shl i704 %r93, 640
%r95 = or i704 %r92, %r94
%r96 = zext i704 %r95 to i768
%r97 = zext i64 %r50 to i768
%r98 = shl i768 %r97, 704
%r99 = or i768 %r96, %r98
%r100 = zext i768 %r99 to i832
%r101 = zext i64 %r54 to i832
%r102 = shl i832 %r101, 768
%r103 = or i832 %r100, %r102
%r104 = zext i64 %r7 to i128
%r105 = zext i64 %r11 to i128
%r106 = shl i128 %r105, 64
%r107 = or i128 %r104, %r106
%r108 = zext i128 %r107 to i192
%r109 = zext i64 %r15 to i192
%r110 = shl i192 %r109, 128
%r111 = or i192 %r108, %r110
%r112 = zext i192 %r111 to i256
%r113 = zext i64 %r19 to i256
%r114 = shl i256 %r113, 192
%r115 = or i256 %r112, %r114
%r116 = zext i256 %r115 to i320
%r117 = zext i64 %r23 to i320
%r118 = shl i320 %r117, 256
%r119 = or i320 %r116, %r118
%r120 = zext i320 %r119 to i384
%r121 = zext i64 %r27 to i384
%r122 = shl i384 %r121, 320
%r123 = or i384 %r120, %r122
%r124 = zext i384 %r123 to i448
%r125 = zext i64 %r31 to i448
%r126 = shl i448 %r125, 384
%r127 = or i448 %r124, %r126
%r128 = zext i448 %r127 to i512
%r129 = zext i64 %r35 to i512
%r130 = shl i512 %r129, 448
%r131 = or i512 %r128, %r130
%r132 = zext i512 %r131 to i576
%r133 = zext i64 %r39 to i576
%r134 = shl i576 %r133, 512
%r135 = or i576 %r132, %r134
%r136 = zext i576 %r135 to i640
%r137 = zext i64 %r43 to i640
%r138 = shl i640 %r137, 576
%r139 = or i640 %r136, %r138
%r140 = zext i640 %r139 to i704
%r141 = zext i64 %r47 to i704
%r142 = shl i704 %r141, 640
%r143 = or i704 %r140, %r142
%r144 = zext i704 %r143 to i768
%r145 = zext i64 %r51 to i768
%r146 = shl i768 %r145, 704
%r147 = or i768 %r144, %r146
%r148 = zext i768 %r147 to i832
%r149 = zext i64 %r55 to i832
%r150 = shl i832 %r149, 768
%r151 = or i832 %r148, %r150
%r152 = zext i832 %r103 to i896
%r153 = zext i832 %r151 to i896
%r154 = shl i896 %r153, 64
%r155 = add i896 %r152, %r154
ret i896 %r155
}
define i64 @mclb_mulUnit13(i64* noalias  %r2, i64* noalias  %r3, i64 %r4)
{
%r5 = call i896 @mulUnit_inner832(i64* %r3, i64 %r4)
%r6 = trunc i896 %r5 to i832
%r8 = getelementptr i64, i64* %r2, i32 0
%r9 = trunc i832 %r6 to i64
store i64 %r9, i64* %r8
%r10 = lshr i832 %r6, 64
%r12 = getelementptr i64, i64* %r2, i32 1
%r13 = trunc i832 %r10 to i64
store i64 %r13, i64* %r12
%r14 = lshr i832 %r10, 64
%r16 = getelementptr i64, i64* %r2, i32 2
%r17 = trunc i832 %r14 to i64
store i64 %r17, i64* %r16
%r18 = lshr i832 %r14, 64
%r20 = getelementptr i64, i64* %r2, i32 3
%r21 = trunc i832 %r18 to i64
store i64 %r21, i64* %r20
%r22 = lshr i832 %r18, 64
%r24 = getelementptr i64, i64* %r2, i32 4
%r25 = trunc i832 %r22 to i64
store i64 %r25, i64* %r24
%r26 = lshr i832 %r22, 64
%r28 = getelementptr i64, i64* %r2, i32 5
%r29 = trunc i832 %r26 to i64
store i64 %r29, i64* %r28
%r30 = lshr i832 %r26, 64
%r32 = getelementptr i64, i64* %r2, i32 6
%r33 = trunc i832 %r30 to i64
store i64 %r33, i64* %r32
%r34 = lshr i832 %r30, 64
%r36 = getelementptr i64, i64* %r2, i32 7
%r37 = trunc i832 %r34 to i64
store i64 %r37, i64* %r36
%r38 = lshr i832 %r34, 64
%r40 = getelementptr i64, i64* %r2, i32 8
%r41 = trunc i832 %r38 to i64
store i64 %r41, i64* %r40
%r42 = lshr i832 %r38, 64
%r44 = getelementptr i64, i64* %r2, i32 9
%r45 = trunc i832 %r42 to i64
store i64 %r45, i64* %r44
%r46 = lshr i832 %r42, 64
%r48 = getelementptr i64, i64* %r2, i32 10
%r49 = trunc i832 %r46 to i64
store i64 %r49, i64* %r48
%r50 = lshr i832 %r46, 64
%r52 = getelementptr i64, i64* %r2, i32 11
%r53 = trunc i832 %r50 to i64
store i64 %r53, i64* %r52
%r54 = lshr i832 %r50, 64
%r56 = getelementptr i64, i64* %r2, i32 12
%r57 = trunc i832 %r54 to i64
store i64 %r57, i64* %r56
%r58 = lshr i896 %r5, 832
%r59 = trunc i896 %r58 to i64
ret i64 %r59
}
define i64 @mclb_mulUnitAdd13(i64* noalias  %r2, i64* noalias  %r3, i64 %r4)
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
%r42 = call i128 @mulPos64x64(i64* %r3, i64 %r4, i64 9)
%r43 = trunc i128 %r42 to i64
%r44 = call i64 @extractHigh64(i128 %r42)
%r46 = call i128 @mulPos64x64(i64* %r3, i64 %r4, i64 10)
%r47 = trunc i128 %r46 to i64
%r48 = call i64 @extractHigh64(i128 %r46)
%r50 = call i128 @mulPos64x64(i64* %r3, i64 %r4, i64 11)
%r51 = trunc i128 %r50 to i64
%r52 = call i64 @extractHigh64(i128 %r50)
%r54 = call i128 @mulPos64x64(i64* %r3, i64 %r4, i64 12)
%r55 = trunc i128 %r54 to i64
%r56 = call i64 @extractHigh64(i128 %r54)
%r57 = zext i64 %r7 to i128
%r58 = zext i64 %r11 to i128
%r59 = shl i128 %r58, 64
%r60 = or i128 %r57, %r59
%r61 = zext i128 %r60 to i192
%r62 = zext i64 %r15 to i192
%r63 = shl i192 %r62, 128
%r64 = or i192 %r61, %r63
%r65 = zext i192 %r64 to i256
%r66 = zext i64 %r19 to i256
%r67 = shl i256 %r66, 192
%r68 = or i256 %r65, %r67
%r69 = zext i256 %r68 to i320
%r70 = zext i64 %r23 to i320
%r71 = shl i320 %r70, 256
%r72 = or i320 %r69, %r71
%r73 = zext i320 %r72 to i384
%r74 = zext i64 %r27 to i384
%r75 = shl i384 %r74, 320
%r76 = or i384 %r73, %r75
%r77 = zext i384 %r76 to i448
%r78 = zext i64 %r31 to i448
%r79 = shl i448 %r78, 384
%r80 = or i448 %r77, %r79
%r81 = zext i448 %r80 to i512
%r82 = zext i64 %r35 to i512
%r83 = shl i512 %r82, 448
%r84 = or i512 %r81, %r83
%r85 = zext i512 %r84 to i576
%r86 = zext i64 %r39 to i576
%r87 = shl i576 %r86, 512
%r88 = or i576 %r85, %r87
%r89 = zext i576 %r88 to i640
%r90 = zext i64 %r43 to i640
%r91 = shl i640 %r90, 576
%r92 = or i640 %r89, %r91
%r93 = zext i640 %r92 to i704
%r94 = zext i64 %r47 to i704
%r95 = shl i704 %r94, 640
%r96 = or i704 %r93, %r95
%r97 = zext i704 %r96 to i768
%r98 = zext i64 %r51 to i768
%r99 = shl i768 %r98, 704
%r100 = or i768 %r97, %r99
%r101 = zext i768 %r100 to i832
%r102 = zext i64 %r55 to i832
%r103 = shl i832 %r102, 768
%r104 = or i832 %r101, %r103
%r105 = zext i64 %r8 to i128
%r106 = zext i64 %r12 to i128
%r107 = shl i128 %r106, 64
%r108 = or i128 %r105, %r107
%r109 = zext i128 %r108 to i192
%r110 = zext i64 %r16 to i192
%r111 = shl i192 %r110, 128
%r112 = or i192 %r109, %r111
%r113 = zext i192 %r112 to i256
%r114 = zext i64 %r20 to i256
%r115 = shl i256 %r114, 192
%r116 = or i256 %r113, %r115
%r117 = zext i256 %r116 to i320
%r118 = zext i64 %r24 to i320
%r119 = shl i320 %r118, 256
%r120 = or i320 %r117, %r119
%r121 = zext i320 %r120 to i384
%r122 = zext i64 %r28 to i384
%r123 = shl i384 %r122, 320
%r124 = or i384 %r121, %r123
%r125 = zext i384 %r124 to i448
%r126 = zext i64 %r32 to i448
%r127 = shl i448 %r126, 384
%r128 = or i448 %r125, %r127
%r129 = zext i448 %r128 to i512
%r130 = zext i64 %r36 to i512
%r131 = shl i512 %r130, 448
%r132 = or i512 %r129, %r131
%r133 = zext i512 %r132 to i576
%r134 = zext i64 %r40 to i576
%r135 = shl i576 %r134, 512
%r136 = or i576 %r133, %r135
%r137 = zext i576 %r136 to i640
%r138 = zext i64 %r44 to i640
%r139 = shl i640 %r138, 576
%r140 = or i640 %r137, %r139
%r141 = zext i640 %r140 to i704
%r142 = zext i64 %r48 to i704
%r143 = shl i704 %r142, 640
%r144 = or i704 %r141, %r143
%r145 = zext i704 %r144 to i768
%r146 = zext i64 %r52 to i768
%r147 = shl i768 %r146, 704
%r148 = or i768 %r145, %r147
%r149 = zext i768 %r148 to i832
%r150 = zext i64 %r56 to i832
%r151 = shl i832 %r150, 768
%r152 = or i832 %r149, %r151
%r153 = zext i832 %r104 to i896
%r154 = zext i832 %r152 to i896
%r155 = shl i896 %r154, 64
%r156 = add i896 %r153, %r155
%r158 = bitcast i64* %r2 to i832*
%r159 = load i832, i832* %r158
%r160 = zext i832 %r159 to i896
%r161 = add i896 %r156, %r160
%r162 = trunc i896 %r161 to i832
%r164 = getelementptr i64, i64* %r2, i32 0
%r165 = trunc i832 %r162 to i64
store i64 %r165, i64* %r164
%r166 = lshr i832 %r162, 64
%r168 = getelementptr i64, i64* %r2, i32 1
%r169 = trunc i832 %r166 to i64
store i64 %r169, i64* %r168
%r170 = lshr i832 %r166, 64
%r172 = getelementptr i64, i64* %r2, i32 2
%r173 = trunc i832 %r170 to i64
store i64 %r173, i64* %r172
%r174 = lshr i832 %r170, 64
%r176 = getelementptr i64, i64* %r2, i32 3
%r177 = trunc i832 %r174 to i64
store i64 %r177, i64* %r176
%r178 = lshr i832 %r174, 64
%r180 = getelementptr i64, i64* %r2, i32 4
%r181 = trunc i832 %r178 to i64
store i64 %r181, i64* %r180
%r182 = lshr i832 %r178, 64
%r184 = getelementptr i64, i64* %r2, i32 5
%r185 = trunc i832 %r182 to i64
store i64 %r185, i64* %r184
%r186 = lshr i832 %r182, 64
%r188 = getelementptr i64, i64* %r2, i32 6
%r189 = trunc i832 %r186 to i64
store i64 %r189, i64* %r188
%r190 = lshr i832 %r186, 64
%r192 = getelementptr i64, i64* %r2, i32 7
%r193 = trunc i832 %r190 to i64
store i64 %r193, i64* %r192
%r194 = lshr i832 %r190, 64
%r196 = getelementptr i64, i64* %r2, i32 8
%r197 = trunc i832 %r194 to i64
store i64 %r197, i64* %r196
%r198 = lshr i832 %r194, 64
%r200 = getelementptr i64, i64* %r2, i32 9
%r201 = trunc i832 %r198 to i64
store i64 %r201, i64* %r200
%r202 = lshr i832 %r198, 64
%r204 = getelementptr i64, i64* %r2, i32 10
%r205 = trunc i832 %r202 to i64
store i64 %r205, i64* %r204
%r206 = lshr i832 %r202, 64
%r208 = getelementptr i64, i64* %r2, i32 11
%r209 = trunc i832 %r206 to i64
store i64 %r209, i64* %r208
%r210 = lshr i832 %r206, 64
%r212 = getelementptr i64, i64* %r2, i32 12
%r213 = trunc i832 %r210 to i64
store i64 %r213, i64* %r212
%r214 = lshr i896 %r161, 832
%r215 = trunc i896 %r214 to i64
ret i64 %r215
}
define void @mclb_mul13(i64* noalias  %r1, i64* noalias  %r2, i64* noalias  %r3)
{
%r4 = load i64, i64* %r3
%r5 = call i896 @mulUnit_inner832(i64* %r2, i64 %r4)
%r6 = trunc i896 %r5 to i64
store i64 %r6, i64* %r1
%r7 = lshr i896 %r5, 64
%r9 = getelementptr i64, i64* %r3, i32 1
%r10 = load i64, i64* %r9
%r11 = call i896 @mulUnit_inner832(i64* %r2, i64 %r10)
%r12 = add i896 %r7, %r11
%r13 = trunc i896 %r12 to i64
%r15 = getelementptr i64, i64* %r1, i32 1
store i64 %r13, i64* %r15
%r16 = lshr i896 %r12, 64
%r18 = getelementptr i64, i64* %r3, i32 2
%r19 = load i64, i64* %r18
%r20 = call i896 @mulUnit_inner832(i64* %r2, i64 %r19)
%r21 = add i896 %r16, %r20
%r22 = trunc i896 %r21 to i64
%r24 = getelementptr i64, i64* %r1, i32 2
store i64 %r22, i64* %r24
%r25 = lshr i896 %r21, 64
%r27 = getelementptr i64, i64* %r3, i32 3
%r28 = load i64, i64* %r27
%r29 = call i896 @mulUnit_inner832(i64* %r2, i64 %r28)
%r30 = add i896 %r25, %r29
%r31 = trunc i896 %r30 to i64
%r33 = getelementptr i64, i64* %r1, i32 3
store i64 %r31, i64* %r33
%r34 = lshr i896 %r30, 64
%r36 = getelementptr i64, i64* %r3, i32 4
%r37 = load i64, i64* %r36
%r38 = call i896 @mulUnit_inner832(i64* %r2, i64 %r37)
%r39 = add i896 %r34, %r38
%r40 = trunc i896 %r39 to i64
%r42 = getelementptr i64, i64* %r1, i32 4
store i64 %r40, i64* %r42
%r43 = lshr i896 %r39, 64
%r45 = getelementptr i64, i64* %r3, i32 5
%r46 = load i64, i64* %r45
%r47 = call i896 @mulUnit_inner832(i64* %r2, i64 %r46)
%r48 = add i896 %r43, %r47
%r49 = trunc i896 %r48 to i64
%r51 = getelementptr i64, i64* %r1, i32 5
store i64 %r49, i64* %r51
%r52 = lshr i896 %r48, 64
%r54 = getelementptr i64, i64* %r3, i32 6
%r55 = load i64, i64* %r54
%r56 = call i896 @mulUnit_inner832(i64* %r2, i64 %r55)
%r57 = add i896 %r52, %r56
%r58 = trunc i896 %r57 to i64
%r60 = getelementptr i64, i64* %r1, i32 6
store i64 %r58, i64* %r60
%r61 = lshr i896 %r57, 64
%r63 = getelementptr i64, i64* %r3, i32 7
%r64 = load i64, i64* %r63
%r65 = call i896 @mulUnit_inner832(i64* %r2, i64 %r64)
%r66 = add i896 %r61, %r65
%r67 = trunc i896 %r66 to i64
%r69 = getelementptr i64, i64* %r1, i32 7
store i64 %r67, i64* %r69
%r70 = lshr i896 %r66, 64
%r72 = getelementptr i64, i64* %r3, i32 8
%r73 = load i64, i64* %r72
%r74 = call i896 @mulUnit_inner832(i64* %r2, i64 %r73)
%r75 = add i896 %r70, %r74
%r76 = trunc i896 %r75 to i64
%r78 = getelementptr i64, i64* %r1, i32 8
store i64 %r76, i64* %r78
%r79 = lshr i896 %r75, 64
%r81 = getelementptr i64, i64* %r3, i32 9
%r82 = load i64, i64* %r81
%r83 = call i896 @mulUnit_inner832(i64* %r2, i64 %r82)
%r84 = add i896 %r79, %r83
%r85 = trunc i896 %r84 to i64
%r87 = getelementptr i64, i64* %r1, i32 9
store i64 %r85, i64* %r87
%r88 = lshr i896 %r84, 64
%r90 = getelementptr i64, i64* %r3, i32 10
%r91 = load i64, i64* %r90
%r92 = call i896 @mulUnit_inner832(i64* %r2, i64 %r91)
%r93 = add i896 %r88, %r92
%r94 = trunc i896 %r93 to i64
%r96 = getelementptr i64, i64* %r1, i32 10
store i64 %r94, i64* %r96
%r97 = lshr i896 %r93, 64
%r99 = getelementptr i64, i64* %r3, i32 11
%r100 = load i64, i64* %r99
%r101 = call i896 @mulUnit_inner832(i64* %r2, i64 %r100)
%r102 = add i896 %r97, %r101
%r103 = trunc i896 %r102 to i64
%r105 = getelementptr i64, i64* %r1, i32 11
store i64 %r103, i64* %r105
%r106 = lshr i896 %r102, 64
%r108 = getelementptr i64, i64* %r3, i32 12
%r109 = load i64, i64* %r108
%r110 = call i896 @mulUnit_inner832(i64* %r2, i64 %r109)
%r111 = add i896 %r106, %r110
%r113 = getelementptr i64, i64* %r1, i32 12
%r115 = getelementptr i64, i64* %r113, i32 0
%r116 = trunc i896 %r111 to i64
store i64 %r116, i64* %r115
%r117 = lshr i896 %r111, 64
%r119 = getelementptr i64, i64* %r113, i32 1
%r120 = trunc i896 %r117 to i64
store i64 %r120, i64* %r119
%r121 = lshr i896 %r117, 64
%r123 = getelementptr i64, i64* %r113, i32 2
%r124 = trunc i896 %r121 to i64
store i64 %r124, i64* %r123
%r125 = lshr i896 %r121, 64
%r127 = getelementptr i64, i64* %r113, i32 3
%r128 = trunc i896 %r125 to i64
store i64 %r128, i64* %r127
%r129 = lshr i896 %r125, 64
%r131 = getelementptr i64, i64* %r113, i32 4
%r132 = trunc i896 %r129 to i64
store i64 %r132, i64* %r131
%r133 = lshr i896 %r129, 64
%r135 = getelementptr i64, i64* %r113, i32 5
%r136 = trunc i896 %r133 to i64
store i64 %r136, i64* %r135
%r137 = lshr i896 %r133, 64
%r139 = getelementptr i64, i64* %r113, i32 6
%r140 = trunc i896 %r137 to i64
store i64 %r140, i64* %r139
%r141 = lshr i896 %r137, 64
%r143 = getelementptr i64, i64* %r113, i32 7
%r144 = trunc i896 %r141 to i64
store i64 %r144, i64* %r143
%r145 = lshr i896 %r141, 64
%r147 = getelementptr i64, i64* %r113, i32 8
%r148 = trunc i896 %r145 to i64
store i64 %r148, i64* %r147
%r149 = lshr i896 %r145, 64
%r151 = getelementptr i64, i64* %r113, i32 9
%r152 = trunc i896 %r149 to i64
store i64 %r152, i64* %r151
%r153 = lshr i896 %r149, 64
%r155 = getelementptr i64, i64* %r113, i32 10
%r156 = trunc i896 %r153 to i64
store i64 %r156, i64* %r155
%r157 = lshr i896 %r153, 64
%r159 = getelementptr i64, i64* %r113, i32 11
%r160 = trunc i896 %r157 to i64
store i64 %r160, i64* %r159
%r161 = lshr i896 %r157, 64
%r163 = getelementptr i64, i64* %r113, i32 12
%r164 = trunc i896 %r161 to i64
store i64 %r164, i64* %r163
%r165 = lshr i896 %r161, 64
%r167 = getelementptr i64, i64* %r113, i32 13
%r168 = trunc i896 %r165 to i64
store i64 %r168, i64* %r167
ret void
}
define void @mclb_sqr13(i64* noalias  %r1, i64* noalias  %r2)
{
%r3 = load i64, i64* %r2
%r4 = call i128 @mul64x64L(i64 %r3, i64 %r3)
%r5 = trunc i128 %r4 to i64
store i64 %r5, i64* %r1
%r6 = lshr i128 %r4, 64
%r8 = getelementptr i64, i64* %r2, i32 12
%r9 = load i64, i64* %r8
%r10 = call i128 @mul64x64L(i64 %r3, i64 %r9)
%r11 = load i64, i64* %r2
%r13 = getelementptr i64, i64* %r2, i32 11
%r14 = load i64, i64* %r13
%r15 = call i128 @mul64x64L(i64 %r11, i64 %r14)
%r17 = getelementptr i64, i64* %r2, i32 1
%r18 = load i64, i64* %r17
%r20 = getelementptr i64, i64* %r2, i32 12
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
%r32 = getelementptr i64, i64* %r2, i32 10
%r33 = load i64, i64* %r32
%r34 = call i128 @mul64x64L(i64 %r30, i64 %r33)
%r36 = getelementptr i64, i64* %r2, i32 1
%r37 = load i64, i64* %r36
%r39 = getelementptr i64, i64* %r2, i32 11
%r40 = load i64, i64* %r39
%r41 = call i128 @mul64x64L(i64 %r37, i64 %r40)
%r42 = zext i128 %r34 to i256
%r43 = zext i128 %r41 to i256
%r44 = shl i256 %r43, 128
%r45 = or i256 %r42, %r44
%r47 = getelementptr i64, i64* %r2, i32 2
%r48 = load i64, i64* %r47
%r50 = getelementptr i64, i64* %r2, i32 12
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
%r62 = getelementptr i64, i64* %r2, i32 9
%r63 = load i64, i64* %r62
%r64 = call i128 @mul64x64L(i64 %r60, i64 %r63)
%r66 = getelementptr i64, i64* %r2, i32 1
%r67 = load i64, i64* %r66
%r69 = getelementptr i64, i64* %r2, i32 10
%r70 = load i64, i64* %r69
%r71 = call i128 @mul64x64L(i64 %r67, i64 %r70)
%r72 = zext i128 %r64 to i256
%r73 = zext i128 %r71 to i256
%r74 = shl i256 %r73, 128
%r75 = or i256 %r72, %r74
%r77 = getelementptr i64, i64* %r2, i32 2
%r78 = load i64, i64* %r77
%r80 = getelementptr i64, i64* %r2, i32 11
%r81 = load i64, i64* %r80
%r82 = call i128 @mul64x64L(i64 %r78, i64 %r81)
%r83 = zext i256 %r75 to i384
%r84 = zext i128 %r82 to i384
%r85 = shl i384 %r84, 256
%r86 = or i384 %r83, %r85
%r88 = getelementptr i64, i64* %r2, i32 3
%r89 = load i64, i64* %r88
%r91 = getelementptr i64, i64* %r2, i32 12
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
%r103 = getelementptr i64, i64* %r2, i32 8
%r104 = load i64, i64* %r103
%r105 = call i128 @mul64x64L(i64 %r101, i64 %r104)
%r107 = getelementptr i64, i64* %r2, i32 1
%r108 = load i64, i64* %r107
%r110 = getelementptr i64, i64* %r2, i32 9
%r111 = load i64, i64* %r110
%r112 = call i128 @mul64x64L(i64 %r108, i64 %r111)
%r113 = zext i128 %r105 to i256
%r114 = zext i128 %r112 to i256
%r115 = shl i256 %r114, 128
%r116 = or i256 %r113, %r115
%r118 = getelementptr i64, i64* %r2, i32 2
%r119 = load i64, i64* %r118
%r121 = getelementptr i64, i64* %r2, i32 10
%r122 = load i64, i64* %r121
%r123 = call i128 @mul64x64L(i64 %r119, i64 %r122)
%r124 = zext i256 %r116 to i384
%r125 = zext i128 %r123 to i384
%r126 = shl i384 %r125, 256
%r127 = or i384 %r124, %r126
%r129 = getelementptr i64, i64* %r2, i32 3
%r130 = load i64, i64* %r129
%r132 = getelementptr i64, i64* %r2, i32 11
%r133 = load i64, i64* %r132
%r134 = call i128 @mul64x64L(i64 %r130, i64 %r133)
%r135 = zext i384 %r127 to i512
%r136 = zext i128 %r134 to i512
%r137 = shl i512 %r136, 384
%r138 = or i512 %r135, %r137
%r140 = getelementptr i64, i64* %r2, i32 4
%r141 = load i64, i64* %r140
%r143 = getelementptr i64, i64* %r2, i32 12
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
%r155 = getelementptr i64, i64* %r2, i32 7
%r156 = load i64, i64* %r155
%r157 = call i128 @mul64x64L(i64 %r153, i64 %r156)
%r159 = getelementptr i64, i64* %r2, i32 1
%r160 = load i64, i64* %r159
%r162 = getelementptr i64, i64* %r2, i32 8
%r163 = load i64, i64* %r162
%r164 = call i128 @mul64x64L(i64 %r160, i64 %r163)
%r165 = zext i128 %r157 to i256
%r166 = zext i128 %r164 to i256
%r167 = shl i256 %r166, 128
%r168 = or i256 %r165, %r167
%r170 = getelementptr i64, i64* %r2, i32 2
%r171 = load i64, i64* %r170
%r173 = getelementptr i64, i64* %r2, i32 9
%r174 = load i64, i64* %r173
%r175 = call i128 @mul64x64L(i64 %r171, i64 %r174)
%r176 = zext i256 %r168 to i384
%r177 = zext i128 %r175 to i384
%r178 = shl i384 %r177, 256
%r179 = or i384 %r176, %r178
%r181 = getelementptr i64, i64* %r2, i32 3
%r182 = load i64, i64* %r181
%r184 = getelementptr i64, i64* %r2, i32 10
%r185 = load i64, i64* %r184
%r186 = call i128 @mul64x64L(i64 %r182, i64 %r185)
%r187 = zext i384 %r179 to i512
%r188 = zext i128 %r186 to i512
%r189 = shl i512 %r188, 384
%r190 = or i512 %r187, %r189
%r192 = getelementptr i64, i64* %r2, i32 4
%r193 = load i64, i64* %r192
%r195 = getelementptr i64, i64* %r2, i32 11
%r196 = load i64, i64* %r195
%r197 = call i128 @mul64x64L(i64 %r193, i64 %r196)
%r198 = zext i512 %r190 to i640
%r199 = zext i128 %r197 to i640
%r200 = shl i640 %r199, 512
%r201 = or i640 %r198, %r200
%r203 = getelementptr i64, i64* %r2, i32 5
%r204 = load i64, i64* %r203
%r206 = getelementptr i64, i64* %r2, i32 12
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
%r218 = getelementptr i64, i64* %r2, i32 6
%r219 = load i64, i64* %r218
%r220 = call i128 @mul64x64L(i64 %r216, i64 %r219)
%r222 = getelementptr i64, i64* %r2, i32 1
%r223 = load i64, i64* %r222
%r225 = getelementptr i64, i64* %r2, i32 7
%r226 = load i64, i64* %r225
%r227 = call i128 @mul64x64L(i64 %r223, i64 %r226)
%r228 = zext i128 %r220 to i256
%r229 = zext i128 %r227 to i256
%r230 = shl i256 %r229, 128
%r231 = or i256 %r228, %r230
%r233 = getelementptr i64, i64* %r2, i32 2
%r234 = load i64, i64* %r233
%r236 = getelementptr i64, i64* %r2, i32 8
%r237 = load i64, i64* %r236
%r238 = call i128 @mul64x64L(i64 %r234, i64 %r237)
%r239 = zext i256 %r231 to i384
%r240 = zext i128 %r238 to i384
%r241 = shl i384 %r240, 256
%r242 = or i384 %r239, %r241
%r244 = getelementptr i64, i64* %r2, i32 3
%r245 = load i64, i64* %r244
%r247 = getelementptr i64, i64* %r2, i32 9
%r248 = load i64, i64* %r247
%r249 = call i128 @mul64x64L(i64 %r245, i64 %r248)
%r250 = zext i384 %r242 to i512
%r251 = zext i128 %r249 to i512
%r252 = shl i512 %r251, 384
%r253 = or i512 %r250, %r252
%r255 = getelementptr i64, i64* %r2, i32 4
%r256 = load i64, i64* %r255
%r258 = getelementptr i64, i64* %r2, i32 10
%r259 = load i64, i64* %r258
%r260 = call i128 @mul64x64L(i64 %r256, i64 %r259)
%r261 = zext i512 %r253 to i640
%r262 = zext i128 %r260 to i640
%r263 = shl i640 %r262, 512
%r264 = or i640 %r261, %r263
%r266 = getelementptr i64, i64* %r2, i32 5
%r267 = load i64, i64* %r266
%r269 = getelementptr i64, i64* %r2, i32 11
%r270 = load i64, i64* %r269
%r271 = call i128 @mul64x64L(i64 %r267, i64 %r270)
%r272 = zext i640 %r264 to i768
%r273 = zext i128 %r271 to i768
%r274 = shl i768 %r273, 640
%r275 = or i768 %r272, %r274
%r277 = getelementptr i64, i64* %r2, i32 6
%r278 = load i64, i64* %r277
%r280 = getelementptr i64, i64* %r2, i32 12
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
%r292 = getelementptr i64, i64* %r2, i32 5
%r293 = load i64, i64* %r292
%r294 = call i128 @mul64x64L(i64 %r290, i64 %r293)
%r296 = getelementptr i64, i64* %r2, i32 1
%r297 = load i64, i64* %r296
%r299 = getelementptr i64, i64* %r2, i32 6
%r300 = load i64, i64* %r299
%r301 = call i128 @mul64x64L(i64 %r297, i64 %r300)
%r302 = zext i128 %r294 to i256
%r303 = zext i128 %r301 to i256
%r304 = shl i256 %r303, 128
%r305 = or i256 %r302, %r304
%r307 = getelementptr i64, i64* %r2, i32 2
%r308 = load i64, i64* %r307
%r310 = getelementptr i64, i64* %r2, i32 7
%r311 = load i64, i64* %r310
%r312 = call i128 @mul64x64L(i64 %r308, i64 %r311)
%r313 = zext i256 %r305 to i384
%r314 = zext i128 %r312 to i384
%r315 = shl i384 %r314, 256
%r316 = or i384 %r313, %r315
%r318 = getelementptr i64, i64* %r2, i32 3
%r319 = load i64, i64* %r318
%r321 = getelementptr i64, i64* %r2, i32 8
%r322 = load i64, i64* %r321
%r323 = call i128 @mul64x64L(i64 %r319, i64 %r322)
%r324 = zext i384 %r316 to i512
%r325 = zext i128 %r323 to i512
%r326 = shl i512 %r325, 384
%r327 = or i512 %r324, %r326
%r329 = getelementptr i64, i64* %r2, i32 4
%r330 = load i64, i64* %r329
%r332 = getelementptr i64, i64* %r2, i32 9
%r333 = load i64, i64* %r332
%r334 = call i128 @mul64x64L(i64 %r330, i64 %r333)
%r335 = zext i512 %r327 to i640
%r336 = zext i128 %r334 to i640
%r337 = shl i640 %r336, 512
%r338 = or i640 %r335, %r337
%r340 = getelementptr i64, i64* %r2, i32 5
%r341 = load i64, i64* %r340
%r343 = getelementptr i64, i64* %r2, i32 10
%r344 = load i64, i64* %r343
%r345 = call i128 @mul64x64L(i64 %r341, i64 %r344)
%r346 = zext i640 %r338 to i768
%r347 = zext i128 %r345 to i768
%r348 = shl i768 %r347, 640
%r349 = or i768 %r346, %r348
%r351 = getelementptr i64, i64* %r2, i32 6
%r352 = load i64, i64* %r351
%r354 = getelementptr i64, i64* %r2, i32 11
%r355 = load i64, i64* %r354
%r356 = call i128 @mul64x64L(i64 %r352, i64 %r355)
%r357 = zext i768 %r349 to i896
%r358 = zext i128 %r356 to i896
%r359 = shl i896 %r358, 768
%r360 = or i896 %r357, %r359
%r362 = getelementptr i64, i64* %r2, i32 7
%r363 = load i64, i64* %r362
%r365 = getelementptr i64, i64* %r2, i32 12
%r366 = load i64, i64* %r365
%r367 = call i128 @mul64x64L(i64 %r363, i64 %r366)
%r368 = zext i896 %r360 to i1024
%r369 = zext i128 %r367 to i1024
%r370 = shl i1024 %r369, 896
%r371 = or i1024 %r368, %r370
%r372 = zext i896 %r289 to i1024
%r373 = shl i1024 %r372, 64
%r374 = add i1024 %r373, %r371
%r375 = load i64, i64* %r2
%r377 = getelementptr i64, i64* %r2, i32 4
%r378 = load i64, i64* %r377
%r379 = call i128 @mul64x64L(i64 %r375, i64 %r378)
%r381 = getelementptr i64, i64* %r2, i32 1
%r382 = load i64, i64* %r381
%r384 = getelementptr i64, i64* %r2, i32 5
%r385 = load i64, i64* %r384
%r386 = call i128 @mul64x64L(i64 %r382, i64 %r385)
%r387 = zext i128 %r379 to i256
%r388 = zext i128 %r386 to i256
%r389 = shl i256 %r388, 128
%r390 = or i256 %r387, %r389
%r392 = getelementptr i64, i64* %r2, i32 2
%r393 = load i64, i64* %r392
%r395 = getelementptr i64, i64* %r2, i32 6
%r396 = load i64, i64* %r395
%r397 = call i128 @mul64x64L(i64 %r393, i64 %r396)
%r398 = zext i256 %r390 to i384
%r399 = zext i128 %r397 to i384
%r400 = shl i384 %r399, 256
%r401 = or i384 %r398, %r400
%r403 = getelementptr i64, i64* %r2, i32 3
%r404 = load i64, i64* %r403
%r406 = getelementptr i64, i64* %r2, i32 7
%r407 = load i64, i64* %r406
%r408 = call i128 @mul64x64L(i64 %r404, i64 %r407)
%r409 = zext i384 %r401 to i512
%r410 = zext i128 %r408 to i512
%r411 = shl i512 %r410, 384
%r412 = or i512 %r409, %r411
%r414 = getelementptr i64, i64* %r2, i32 4
%r415 = load i64, i64* %r414
%r417 = getelementptr i64, i64* %r2, i32 8
%r418 = load i64, i64* %r417
%r419 = call i128 @mul64x64L(i64 %r415, i64 %r418)
%r420 = zext i512 %r412 to i640
%r421 = zext i128 %r419 to i640
%r422 = shl i640 %r421, 512
%r423 = or i640 %r420, %r422
%r425 = getelementptr i64, i64* %r2, i32 5
%r426 = load i64, i64* %r425
%r428 = getelementptr i64, i64* %r2, i32 9
%r429 = load i64, i64* %r428
%r430 = call i128 @mul64x64L(i64 %r426, i64 %r429)
%r431 = zext i640 %r423 to i768
%r432 = zext i128 %r430 to i768
%r433 = shl i768 %r432, 640
%r434 = or i768 %r431, %r433
%r436 = getelementptr i64, i64* %r2, i32 6
%r437 = load i64, i64* %r436
%r439 = getelementptr i64, i64* %r2, i32 10
%r440 = load i64, i64* %r439
%r441 = call i128 @mul64x64L(i64 %r437, i64 %r440)
%r442 = zext i768 %r434 to i896
%r443 = zext i128 %r441 to i896
%r444 = shl i896 %r443, 768
%r445 = or i896 %r442, %r444
%r447 = getelementptr i64, i64* %r2, i32 7
%r448 = load i64, i64* %r447
%r450 = getelementptr i64, i64* %r2, i32 11
%r451 = load i64, i64* %r450
%r452 = call i128 @mul64x64L(i64 %r448, i64 %r451)
%r453 = zext i896 %r445 to i1024
%r454 = zext i128 %r452 to i1024
%r455 = shl i1024 %r454, 896
%r456 = or i1024 %r453, %r455
%r458 = getelementptr i64, i64* %r2, i32 8
%r459 = load i64, i64* %r458
%r461 = getelementptr i64, i64* %r2, i32 12
%r462 = load i64, i64* %r461
%r463 = call i128 @mul64x64L(i64 %r459, i64 %r462)
%r464 = zext i1024 %r456 to i1152
%r465 = zext i128 %r463 to i1152
%r466 = shl i1152 %r465, 1024
%r467 = or i1152 %r464, %r466
%r468 = zext i1024 %r374 to i1152
%r469 = shl i1152 %r468, 64
%r470 = add i1152 %r469, %r467
%r471 = load i64, i64* %r2
%r473 = getelementptr i64, i64* %r2, i32 3
%r474 = load i64, i64* %r473
%r475 = call i128 @mul64x64L(i64 %r471, i64 %r474)
%r477 = getelementptr i64, i64* %r2, i32 1
%r478 = load i64, i64* %r477
%r480 = getelementptr i64, i64* %r2, i32 4
%r481 = load i64, i64* %r480
%r482 = call i128 @mul64x64L(i64 %r478, i64 %r481)
%r483 = zext i128 %r475 to i256
%r484 = zext i128 %r482 to i256
%r485 = shl i256 %r484, 128
%r486 = or i256 %r483, %r485
%r488 = getelementptr i64, i64* %r2, i32 2
%r489 = load i64, i64* %r488
%r491 = getelementptr i64, i64* %r2, i32 5
%r492 = load i64, i64* %r491
%r493 = call i128 @mul64x64L(i64 %r489, i64 %r492)
%r494 = zext i256 %r486 to i384
%r495 = zext i128 %r493 to i384
%r496 = shl i384 %r495, 256
%r497 = or i384 %r494, %r496
%r499 = getelementptr i64, i64* %r2, i32 3
%r500 = load i64, i64* %r499
%r502 = getelementptr i64, i64* %r2, i32 6
%r503 = load i64, i64* %r502
%r504 = call i128 @mul64x64L(i64 %r500, i64 %r503)
%r505 = zext i384 %r497 to i512
%r506 = zext i128 %r504 to i512
%r507 = shl i512 %r506, 384
%r508 = or i512 %r505, %r507
%r510 = getelementptr i64, i64* %r2, i32 4
%r511 = load i64, i64* %r510
%r513 = getelementptr i64, i64* %r2, i32 7
%r514 = load i64, i64* %r513
%r515 = call i128 @mul64x64L(i64 %r511, i64 %r514)
%r516 = zext i512 %r508 to i640
%r517 = zext i128 %r515 to i640
%r518 = shl i640 %r517, 512
%r519 = or i640 %r516, %r518
%r521 = getelementptr i64, i64* %r2, i32 5
%r522 = load i64, i64* %r521
%r524 = getelementptr i64, i64* %r2, i32 8
%r525 = load i64, i64* %r524
%r526 = call i128 @mul64x64L(i64 %r522, i64 %r525)
%r527 = zext i640 %r519 to i768
%r528 = zext i128 %r526 to i768
%r529 = shl i768 %r528, 640
%r530 = or i768 %r527, %r529
%r532 = getelementptr i64, i64* %r2, i32 6
%r533 = load i64, i64* %r532
%r535 = getelementptr i64, i64* %r2, i32 9
%r536 = load i64, i64* %r535
%r537 = call i128 @mul64x64L(i64 %r533, i64 %r536)
%r538 = zext i768 %r530 to i896
%r539 = zext i128 %r537 to i896
%r540 = shl i896 %r539, 768
%r541 = or i896 %r538, %r540
%r543 = getelementptr i64, i64* %r2, i32 7
%r544 = load i64, i64* %r543
%r546 = getelementptr i64, i64* %r2, i32 10
%r547 = load i64, i64* %r546
%r548 = call i128 @mul64x64L(i64 %r544, i64 %r547)
%r549 = zext i896 %r541 to i1024
%r550 = zext i128 %r548 to i1024
%r551 = shl i1024 %r550, 896
%r552 = or i1024 %r549, %r551
%r554 = getelementptr i64, i64* %r2, i32 8
%r555 = load i64, i64* %r554
%r557 = getelementptr i64, i64* %r2, i32 11
%r558 = load i64, i64* %r557
%r559 = call i128 @mul64x64L(i64 %r555, i64 %r558)
%r560 = zext i1024 %r552 to i1152
%r561 = zext i128 %r559 to i1152
%r562 = shl i1152 %r561, 1024
%r563 = or i1152 %r560, %r562
%r565 = getelementptr i64, i64* %r2, i32 9
%r566 = load i64, i64* %r565
%r568 = getelementptr i64, i64* %r2, i32 12
%r569 = load i64, i64* %r568
%r570 = call i128 @mul64x64L(i64 %r566, i64 %r569)
%r571 = zext i1152 %r563 to i1280
%r572 = zext i128 %r570 to i1280
%r573 = shl i1280 %r572, 1152
%r574 = or i1280 %r571, %r573
%r575 = zext i1152 %r470 to i1280
%r576 = shl i1280 %r575, 64
%r577 = add i1280 %r576, %r574
%r578 = load i64, i64* %r2
%r580 = getelementptr i64, i64* %r2, i32 2
%r581 = load i64, i64* %r580
%r582 = call i128 @mul64x64L(i64 %r578, i64 %r581)
%r584 = getelementptr i64, i64* %r2, i32 1
%r585 = load i64, i64* %r584
%r587 = getelementptr i64, i64* %r2, i32 3
%r588 = load i64, i64* %r587
%r589 = call i128 @mul64x64L(i64 %r585, i64 %r588)
%r590 = zext i128 %r582 to i256
%r591 = zext i128 %r589 to i256
%r592 = shl i256 %r591, 128
%r593 = or i256 %r590, %r592
%r595 = getelementptr i64, i64* %r2, i32 2
%r596 = load i64, i64* %r595
%r598 = getelementptr i64, i64* %r2, i32 4
%r599 = load i64, i64* %r598
%r600 = call i128 @mul64x64L(i64 %r596, i64 %r599)
%r601 = zext i256 %r593 to i384
%r602 = zext i128 %r600 to i384
%r603 = shl i384 %r602, 256
%r604 = or i384 %r601, %r603
%r606 = getelementptr i64, i64* %r2, i32 3
%r607 = load i64, i64* %r606
%r609 = getelementptr i64, i64* %r2, i32 5
%r610 = load i64, i64* %r609
%r611 = call i128 @mul64x64L(i64 %r607, i64 %r610)
%r612 = zext i384 %r604 to i512
%r613 = zext i128 %r611 to i512
%r614 = shl i512 %r613, 384
%r615 = or i512 %r612, %r614
%r617 = getelementptr i64, i64* %r2, i32 4
%r618 = load i64, i64* %r617
%r620 = getelementptr i64, i64* %r2, i32 6
%r621 = load i64, i64* %r620
%r622 = call i128 @mul64x64L(i64 %r618, i64 %r621)
%r623 = zext i512 %r615 to i640
%r624 = zext i128 %r622 to i640
%r625 = shl i640 %r624, 512
%r626 = or i640 %r623, %r625
%r628 = getelementptr i64, i64* %r2, i32 5
%r629 = load i64, i64* %r628
%r631 = getelementptr i64, i64* %r2, i32 7
%r632 = load i64, i64* %r631
%r633 = call i128 @mul64x64L(i64 %r629, i64 %r632)
%r634 = zext i640 %r626 to i768
%r635 = zext i128 %r633 to i768
%r636 = shl i768 %r635, 640
%r637 = or i768 %r634, %r636
%r639 = getelementptr i64, i64* %r2, i32 6
%r640 = load i64, i64* %r639
%r642 = getelementptr i64, i64* %r2, i32 8
%r643 = load i64, i64* %r642
%r644 = call i128 @mul64x64L(i64 %r640, i64 %r643)
%r645 = zext i768 %r637 to i896
%r646 = zext i128 %r644 to i896
%r647 = shl i896 %r646, 768
%r648 = or i896 %r645, %r647
%r650 = getelementptr i64, i64* %r2, i32 7
%r651 = load i64, i64* %r650
%r653 = getelementptr i64, i64* %r2, i32 9
%r654 = load i64, i64* %r653
%r655 = call i128 @mul64x64L(i64 %r651, i64 %r654)
%r656 = zext i896 %r648 to i1024
%r657 = zext i128 %r655 to i1024
%r658 = shl i1024 %r657, 896
%r659 = or i1024 %r656, %r658
%r661 = getelementptr i64, i64* %r2, i32 8
%r662 = load i64, i64* %r661
%r664 = getelementptr i64, i64* %r2, i32 10
%r665 = load i64, i64* %r664
%r666 = call i128 @mul64x64L(i64 %r662, i64 %r665)
%r667 = zext i1024 %r659 to i1152
%r668 = zext i128 %r666 to i1152
%r669 = shl i1152 %r668, 1024
%r670 = or i1152 %r667, %r669
%r672 = getelementptr i64, i64* %r2, i32 9
%r673 = load i64, i64* %r672
%r675 = getelementptr i64, i64* %r2, i32 11
%r676 = load i64, i64* %r675
%r677 = call i128 @mul64x64L(i64 %r673, i64 %r676)
%r678 = zext i1152 %r670 to i1280
%r679 = zext i128 %r677 to i1280
%r680 = shl i1280 %r679, 1152
%r681 = or i1280 %r678, %r680
%r683 = getelementptr i64, i64* %r2, i32 10
%r684 = load i64, i64* %r683
%r686 = getelementptr i64, i64* %r2, i32 12
%r687 = load i64, i64* %r686
%r688 = call i128 @mul64x64L(i64 %r684, i64 %r687)
%r689 = zext i1280 %r681 to i1408
%r690 = zext i128 %r688 to i1408
%r691 = shl i1408 %r690, 1280
%r692 = or i1408 %r689, %r691
%r693 = zext i1280 %r577 to i1408
%r694 = shl i1408 %r693, 64
%r695 = add i1408 %r694, %r692
%r696 = load i64, i64* %r2
%r698 = getelementptr i64, i64* %r2, i32 1
%r699 = load i64, i64* %r698
%r700 = call i128 @mul64x64L(i64 %r696, i64 %r699)
%r702 = getelementptr i64, i64* %r2, i32 1
%r703 = load i64, i64* %r702
%r705 = getelementptr i64, i64* %r2, i32 2
%r706 = load i64, i64* %r705
%r707 = call i128 @mul64x64L(i64 %r703, i64 %r706)
%r708 = zext i128 %r700 to i256
%r709 = zext i128 %r707 to i256
%r710 = shl i256 %r709, 128
%r711 = or i256 %r708, %r710
%r713 = getelementptr i64, i64* %r2, i32 2
%r714 = load i64, i64* %r713
%r716 = getelementptr i64, i64* %r2, i32 3
%r717 = load i64, i64* %r716
%r718 = call i128 @mul64x64L(i64 %r714, i64 %r717)
%r719 = zext i256 %r711 to i384
%r720 = zext i128 %r718 to i384
%r721 = shl i384 %r720, 256
%r722 = or i384 %r719, %r721
%r724 = getelementptr i64, i64* %r2, i32 3
%r725 = load i64, i64* %r724
%r727 = getelementptr i64, i64* %r2, i32 4
%r728 = load i64, i64* %r727
%r729 = call i128 @mul64x64L(i64 %r725, i64 %r728)
%r730 = zext i384 %r722 to i512
%r731 = zext i128 %r729 to i512
%r732 = shl i512 %r731, 384
%r733 = or i512 %r730, %r732
%r735 = getelementptr i64, i64* %r2, i32 4
%r736 = load i64, i64* %r735
%r738 = getelementptr i64, i64* %r2, i32 5
%r739 = load i64, i64* %r738
%r740 = call i128 @mul64x64L(i64 %r736, i64 %r739)
%r741 = zext i512 %r733 to i640
%r742 = zext i128 %r740 to i640
%r743 = shl i640 %r742, 512
%r744 = or i640 %r741, %r743
%r746 = getelementptr i64, i64* %r2, i32 5
%r747 = load i64, i64* %r746
%r749 = getelementptr i64, i64* %r2, i32 6
%r750 = load i64, i64* %r749
%r751 = call i128 @mul64x64L(i64 %r747, i64 %r750)
%r752 = zext i640 %r744 to i768
%r753 = zext i128 %r751 to i768
%r754 = shl i768 %r753, 640
%r755 = or i768 %r752, %r754
%r757 = getelementptr i64, i64* %r2, i32 6
%r758 = load i64, i64* %r757
%r760 = getelementptr i64, i64* %r2, i32 7
%r761 = load i64, i64* %r760
%r762 = call i128 @mul64x64L(i64 %r758, i64 %r761)
%r763 = zext i768 %r755 to i896
%r764 = zext i128 %r762 to i896
%r765 = shl i896 %r764, 768
%r766 = or i896 %r763, %r765
%r768 = getelementptr i64, i64* %r2, i32 7
%r769 = load i64, i64* %r768
%r771 = getelementptr i64, i64* %r2, i32 8
%r772 = load i64, i64* %r771
%r773 = call i128 @mul64x64L(i64 %r769, i64 %r772)
%r774 = zext i896 %r766 to i1024
%r775 = zext i128 %r773 to i1024
%r776 = shl i1024 %r775, 896
%r777 = or i1024 %r774, %r776
%r779 = getelementptr i64, i64* %r2, i32 8
%r780 = load i64, i64* %r779
%r782 = getelementptr i64, i64* %r2, i32 9
%r783 = load i64, i64* %r782
%r784 = call i128 @mul64x64L(i64 %r780, i64 %r783)
%r785 = zext i1024 %r777 to i1152
%r786 = zext i128 %r784 to i1152
%r787 = shl i1152 %r786, 1024
%r788 = or i1152 %r785, %r787
%r790 = getelementptr i64, i64* %r2, i32 9
%r791 = load i64, i64* %r790
%r793 = getelementptr i64, i64* %r2, i32 10
%r794 = load i64, i64* %r793
%r795 = call i128 @mul64x64L(i64 %r791, i64 %r794)
%r796 = zext i1152 %r788 to i1280
%r797 = zext i128 %r795 to i1280
%r798 = shl i1280 %r797, 1152
%r799 = or i1280 %r796, %r798
%r801 = getelementptr i64, i64* %r2, i32 10
%r802 = load i64, i64* %r801
%r804 = getelementptr i64, i64* %r2, i32 11
%r805 = load i64, i64* %r804
%r806 = call i128 @mul64x64L(i64 %r802, i64 %r805)
%r807 = zext i1280 %r799 to i1408
%r808 = zext i128 %r806 to i1408
%r809 = shl i1408 %r808, 1280
%r810 = or i1408 %r807, %r809
%r812 = getelementptr i64, i64* %r2, i32 11
%r813 = load i64, i64* %r812
%r815 = getelementptr i64, i64* %r2, i32 12
%r816 = load i64, i64* %r815
%r817 = call i128 @mul64x64L(i64 %r813, i64 %r816)
%r818 = zext i1408 %r810 to i1536
%r819 = zext i128 %r817 to i1536
%r820 = shl i1536 %r819, 1408
%r821 = or i1536 %r818, %r820
%r822 = zext i1408 %r695 to i1536
%r823 = shl i1536 %r822, 64
%r824 = add i1536 %r823, %r821
%r825 = zext i128 %r6 to i1600
%r827 = getelementptr i64, i64* %r2, i32 1
%r828 = load i64, i64* %r827
%r829 = call i128 @mul64x64L(i64 %r828, i64 %r828)
%r830 = zext i128 %r829 to i1600
%r831 = shl i1600 %r830, 64
%r832 = or i1600 %r825, %r831
%r834 = getelementptr i64, i64* %r2, i32 2
%r835 = load i64, i64* %r834
%r836 = call i128 @mul64x64L(i64 %r835, i64 %r835)
%r837 = zext i128 %r836 to i1600
%r838 = shl i1600 %r837, 192
%r839 = or i1600 %r832, %r838
%r841 = getelementptr i64, i64* %r2, i32 3
%r842 = load i64, i64* %r841
%r843 = call i128 @mul64x64L(i64 %r842, i64 %r842)
%r844 = zext i128 %r843 to i1600
%r845 = shl i1600 %r844, 320
%r846 = or i1600 %r839, %r845
%r848 = getelementptr i64, i64* %r2, i32 4
%r849 = load i64, i64* %r848
%r850 = call i128 @mul64x64L(i64 %r849, i64 %r849)
%r851 = zext i128 %r850 to i1600
%r852 = shl i1600 %r851, 448
%r853 = or i1600 %r846, %r852
%r855 = getelementptr i64, i64* %r2, i32 5
%r856 = load i64, i64* %r855
%r857 = call i128 @mul64x64L(i64 %r856, i64 %r856)
%r858 = zext i128 %r857 to i1600
%r859 = shl i1600 %r858, 576
%r860 = or i1600 %r853, %r859
%r862 = getelementptr i64, i64* %r2, i32 6
%r863 = load i64, i64* %r862
%r864 = call i128 @mul64x64L(i64 %r863, i64 %r863)
%r865 = zext i128 %r864 to i1600
%r866 = shl i1600 %r865, 704
%r867 = or i1600 %r860, %r866
%r869 = getelementptr i64, i64* %r2, i32 7
%r870 = load i64, i64* %r869
%r871 = call i128 @mul64x64L(i64 %r870, i64 %r870)
%r872 = zext i128 %r871 to i1600
%r873 = shl i1600 %r872, 832
%r874 = or i1600 %r867, %r873
%r876 = getelementptr i64, i64* %r2, i32 8
%r877 = load i64, i64* %r876
%r878 = call i128 @mul64x64L(i64 %r877, i64 %r877)
%r879 = zext i128 %r878 to i1600
%r880 = shl i1600 %r879, 960
%r881 = or i1600 %r874, %r880
%r883 = getelementptr i64, i64* %r2, i32 9
%r884 = load i64, i64* %r883
%r885 = call i128 @mul64x64L(i64 %r884, i64 %r884)
%r886 = zext i128 %r885 to i1600
%r887 = shl i1600 %r886, 1088
%r888 = or i1600 %r881, %r887
%r890 = getelementptr i64, i64* %r2, i32 10
%r891 = load i64, i64* %r890
%r892 = call i128 @mul64x64L(i64 %r891, i64 %r891)
%r893 = zext i128 %r892 to i1600
%r894 = shl i1600 %r893, 1216
%r895 = or i1600 %r888, %r894
%r897 = getelementptr i64, i64* %r2, i32 11
%r898 = load i64, i64* %r897
%r899 = call i128 @mul64x64L(i64 %r898, i64 %r898)
%r900 = zext i128 %r899 to i1600
%r901 = shl i1600 %r900, 1344
%r902 = or i1600 %r895, %r901
%r904 = getelementptr i64, i64* %r2, i32 12
%r905 = load i64, i64* %r904
%r906 = call i128 @mul64x64L(i64 %r905, i64 %r905)
%r907 = zext i128 %r906 to i1600
%r908 = shl i1600 %r907, 1472
%r909 = or i1600 %r902, %r908
%r910 = zext i1536 %r824 to i1600
%r911 = add i1600 %r910, %r910
%r912 = add i1600 %r909, %r911
%r914 = getelementptr i64, i64* %r1, i32 1
%r916 = getelementptr i64, i64* %r914, i32 0
%r917 = trunc i1600 %r912 to i64
store i64 %r917, i64* %r916
%r918 = lshr i1600 %r912, 64
%r920 = getelementptr i64, i64* %r914, i32 1
%r921 = trunc i1600 %r918 to i64
store i64 %r921, i64* %r920
%r922 = lshr i1600 %r918, 64
%r924 = getelementptr i64, i64* %r914, i32 2
%r925 = trunc i1600 %r922 to i64
store i64 %r925, i64* %r924
%r926 = lshr i1600 %r922, 64
%r928 = getelementptr i64, i64* %r914, i32 3
%r929 = trunc i1600 %r926 to i64
store i64 %r929, i64* %r928
%r930 = lshr i1600 %r926, 64
%r932 = getelementptr i64, i64* %r914, i32 4
%r933 = trunc i1600 %r930 to i64
store i64 %r933, i64* %r932
%r934 = lshr i1600 %r930, 64
%r936 = getelementptr i64, i64* %r914, i32 5
%r937 = trunc i1600 %r934 to i64
store i64 %r937, i64* %r936
%r938 = lshr i1600 %r934, 64
%r940 = getelementptr i64, i64* %r914, i32 6
%r941 = trunc i1600 %r938 to i64
store i64 %r941, i64* %r940
%r942 = lshr i1600 %r938, 64
%r944 = getelementptr i64, i64* %r914, i32 7
%r945 = trunc i1600 %r942 to i64
store i64 %r945, i64* %r944
%r946 = lshr i1600 %r942, 64
%r948 = getelementptr i64, i64* %r914, i32 8
%r949 = trunc i1600 %r946 to i64
store i64 %r949, i64* %r948
%r950 = lshr i1600 %r946, 64
%r952 = getelementptr i64, i64* %r914, i32 9
%r953 = trunc i1600 %r950 to i64
store i64 %r953, i64* %r952
%r954 = lshr i1600 %r950, 64
%r956 = getelementptr i64, i64* %r914, i32 10
%r957 = trunc i1600 %r954 to i64
store i64 %r957, i64* %r956
%r958 = lshr i1600 %r954, 64
%r960 = getelementptr i64, i64* %r914, i32 11
%r961 = trunc i1600 %r958 to i64
store i64 %r961, i64* %r960
%r962 = lshr i1600 %r958, 64
%r964 = getelementptr i64, i64* %r914, i32 12
%r965 = trunc i1600 %r962 to i64
store i64 %r965, i64* %r964
%r966 = lshr i1600 %r962, 64
%r968 = getelementptr i64, i64* %r914, i32 13
%r969 = trunc i1600 %r966 to i64
store i64 %r969, i64* %r968
%r970 = lshr i1600 %r966, 64
%r972 = getelementptr i64, i64* %r914, i32 14
%r973 = trunc i1600 %r970 to i64
store i64 %r973, i64* %r972
%r974 = lshr i1600 %r970, 64
%r976 = getelementptr i64, i64* %r914, i32 15
%r977 = trunc i1600 %r974 to i64
store i64 %r977, i64* %r976
%r978 = lshr i1600 %r974, 64
%r980 = getelementptr i64, i64* %r914, i32 16
%r981 = trunc i1600 %r978 to i64
store i64 %r981, i64* %r980
%r982 = lshr i1600 %r978, 64
%r984 = getelementptr i64, i64* %r914, i32 17
%r985 = trunc i1600 %r982 to i64
store i64 %r985, i64* %r984
%r986 = lshr i1600 %r982, 64
%r988 = getelementptr i64, i64* %r914, i32 18
%r989 = trunc i1600 %r986 to i64
store i64 %r989, i64* %r988
%r990 = lshr i1600 %r986, 64
%r992 = getelementptr i64, i64* %r914, i32 19
%r993 = trunc i1600 %r990 to i64
store i64 %r993, i64* %r992
%r994 = lshr i1600 %r990, 64
%r996 = getelementptr i64, i64* %r914, i32 20
%r997 = trunc i1600 %r994 to i64
store i64 %r997, i64* %r996
%r998 = lshr i1600 %r994, 64
%r1000 = getelementptr i64, i64* %r914, i32 21
%r1001 = trunc i1600 %r998 to i64
store i64 %r1001, i64* %r1000
%r1002 = lshr i1600 %r998, 64
%r1004 = getelementptr i64, i64* %r914, i32 22
%r1005 = trunc i1600 %r1002 to i64
store i64 %r1005, i64* %r1004
%r1006 = lshr i1600 %r1002, 64
%r1008 = getelementptr i64, i64* %r914, i32 23
%r1009 = trunc i1600 %r1006 to i64
store i64 %r1009, i64* %r1008
%r1010 = lshr i1600 %r1006, 64
%r1012 = getelementptr i64, i64* %r914, i32 24
%r1013 = trunc i1600 %r1010 to i64
store i64 %r1013, i64* %r1012
ret void
}
define private i832 @mulUnit2_inner832(i64* noalias  %r2, i64 %r3)
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
%r41 = call i128 @mulPos64x64(i64* %r2, i64 %r3, i64 9)
%r42 = trunc i128 %r41 to i64
%r43 = call i64 @extractHigh64(i128 %r41)
%r45 = call i128 @mulPos64x64(i64* %r2, i64 %r3, i64 10)
%r46 = trunc i128 %r45 to i64
%r47 = call i64 @extractHigh64(i128 %r45)
%r49 = call i128 @mulPos64x64(i64* %r2, i64 %r3, i64 11)
%r50 = trunc i128 %r49 to i64
%r51 = call i64 @extractHigh64(i128 %r49)
%r53 = call i128 @mulPos64x64(i64* %r2, i64 %r3, i64 12)
%r54 = trunc i128 %r53 to i64
%r55 = zext i64 %r6 to i128
%r56 = zext i64 %r10 to i128
%r57 = shl i128 %r56, 64
%r58 = or i128 %r55, %r57
%r59 = zext i128 %r58 to i192
%r60 = zext i64 %r14 to i192
%r61 = shl i192 %r60, 128
%r62 = or i192 %r59, %r61
%r63 = zext i192 %r62 to i256
%r64 = zext i64 %r18 to i256
%r65 = shl i256 %r64, 192
%r66 = or i256 %r63, %r65
%r67 = zext i256 %r66 to i320
%r68 = zext i64 %r22 to i320
%r69 = shl i320 %r68, 256
%r70 = or i320 %r67, %r69
%r71 = zext i320 %r70 to i384
%r72 = zext i64 %r26 to i384
%r73 = shl i384 %r72, 320
%r74 = or i384 %r71, %r73
%r75 = zext i384 %r74 to i448
%r76 = zext i64 %r30 to i448
%r77 = shl i448 %r76, 384
%r78 = or i448 %r75, %r77
%r79 = zext i448 %r78 to i512
%r80 = zext i64 %r34 to i512
%r81 = shl i512 %r80, 448
%r82 = or i512 %r79, %r81
%r83 = zext i512 %r82 to i576
%r84 = zext i64 %r38 to i576
%r85 = shl i576 %r84, 512
%r86 = or i576 %r83, %r85
%r87 = zext i576 %r86 to i640
%r88 = zext i64 %r42 to i640
%r89 = shl i640 %r88, 576
%r90 = or i640 %r87, %r89
%r91 = zext i640 %r90 to i704
%r92 = zext i64 %r46 to i704
%r93 = shl i704 %r92, 640
%r94 = or i704 %r91, %r93
%r95 = zext i704 %r94 to i768
%r96 = zext i64 %r50 to i768
%r97 = shl i768 %r96, 704
%r98 = or i768 %r95, %r97
%r99 = zext i768 %r98 to i832
%r100 = zext i64 %r54 to i832
%r101 = shl i832 %r100, 768
%r102 = or i832 %r99, %r101
%r103 = zext i64 %r7 to i128
%r104 = zext i64 %r11 to i128
%r105 = shl i128 %r104, 64
%r106 = or i128 %r103, %r105
%r107 = zext i128 %r106 to i192
%r108 = zext i64 %r15 to i192
%r109 = shl i192 %r108, 128
%r110 = or i192 %r107, %r109
%r111 = zext i192 %r110 to i256
%r112 = zext i64 %r19 to i256
%r113 = shl i256 %r112, 192
%r114 = or i256 %r111, %r113
%r115 = zext i256 %r114 to i320
%r116 = zext i64 %r23 to i320
%r117 = shl i320 %r116, 256
%r118 = or i320 %r115, %r117
%r119 = zext i320 %r118 to i384
%r120 = zext i64 %r27 to i384
%r121 = shl i384 %r120, 320
%r122 = or i384 %r119, %r121
%r123 = zext i384 %r122 to i448
%r124 = zext i64 %r31 to i448
%r125 = shl i448 %r124, 384
%r126 = or i448 %r123, %r125
%r127 = zext i448 %r126 to i512
%r128 = zext i64 %r35 to i512
%r129 = shl i512 %r128, 448
%r130 = or i512 %r127, %r129
%r131 = zext i512 %r130 to i576
%r132 = zext i64 %r39 to i576
%r133 = shl i576 %r132, 512
%r134 = or i576 %r131, %r133
%r135 = zext i576 %r134 to i640
%r136 = zext i64 %r43 to i640
%r137 = shl i640 %r136, 576
%r138 = or i640 %r135, %r137
%r139 = zext i640 %r138 to i704
%r140 = zext i64 %r47 to i704
%r141 = shl i704 %r140, 640
%r142 = or i704 %r139, %r141
%r143 = zext i704 %r142 to i768
%r144 = zext i64 %r51 to i768
%r145 = shl i768 %r144, 704
%r146 = or i768 %r143, %r145
%r147 = zext i768 %r146 to i832
%r148 = shl i832 %r147, 64
%r149 = add i832 %r102, %r148
ret i832 %r149
}
define i960 @mulUnit_inner896(i64* noalias  %r2, i64 %r3)
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
%r41 = call i128 @mulPos64x64(i64* %r2, i64 %r3, i64 9)
%r42 = trunc i128 %r41 to i64
%r43 = call i64 @extractHigh64(i128 %r41)
%r45 = call i128 @mulPos64x64(i64* %r2, i64 %r3, i64 10)
%r46 = trunc i128 %r45 to i64
%r47 = call i64 @extractHigh64(i128 %r45)
%r49 = call i128 @mulPos64x64(i64* %r2, i64 %r3, i64 11)
%r50 = trunc i128 %r49 to i64
%r51 = call i64 @extractHigh64(i128 %r49)
%r53 = call i128 @mulPos64x64(i64* %r2, i64 %r3, i64 12)
%r54 = trunc i128 %r53 to i64
%r55 = call i64 @extractHigh64(i128 %r53)
%r57 = call i128 @mulPos64x64(i64* %r2, i64 %r3, i64 13)
%r58 = trunc i128 %r57 to i64
%r59 = call i64 @extractHigh64(i128 %r57)
%r60 = zext i64 %r6 to i128
%r61 = zext i64 %r10 to i128
%r62 = shl i128 %r61, 64
%r63 = or i128 %r60, %r62
%r64 = zext i128 %r63 to i192
%r65 = zext i64 %r14 to i192
%r66 = shl i192 %r65, 128
%r67 = or i192 %r64, %r66
%r68 = zext i192 %r67 to i256
%r69 = zext i64 %r18 to i256
%r70 = shl i256 %r69, 192
%r71 = or i256 %r68, %r70
%r72 = zext i256 %r71 to i320
%r73 = zext i64 %r22 to i320
%r74 = shl i320 %r73, 256
%r75 = or i320 %r72, %r74
%r76 = zext i320 %r75 to i384
%r77 = zext i64 %r26 to i384
%r78 = shl i384 %r77, 320
%r79 = or i384 %r76, %r78
%r80 = zext i384 %r79 to i448
%r81 = zext i64 %r30 to i448
%r82 = shl i448 %r81, 384
%r83 = or i448 %r80, %r82
%r84 = zext i448 %r83 to i512
%r85 = zext i64 %r34 to i512
%r86 = shl i512 %r85, 448
%r87 = or i512 %r84, %r86
%r88 = zext i512 %r87 to i576
%r89 = zext i64 %r38 to i576
%r90 = shl i576 %r89, 512
%r91 = or i576 %r88, %r90
%r92 = zext i576 %r91 to i640
%r93 = zext i64 %r42 to i640
%r94 = shl i640 %r93, 576
%r95 = or i640 %r92, %r94
%r96 = zext i640 %r95 to i704
%r97 = zext i64 %r46 to i704
%r98 = shl i704 %r97, 640
%r99 = or i704 %r96, %r98
%r100 = zext i704 %r99 to i768
%r101 = zext i64 %r50 to i768
%r102 = shl i768 %r101, 704
%r103 = or i768 %r100, %r102
%r104 = zext i768 %r103 to i832
%r105 = zext i64 %r54 to i832
%r106 = shl i832 %r105, 768
%r107 = or i832 %r104, %r106
%r108 = zext i832 %r107 to i896
%r109 = zext i64 %r58 to i896
%r110 = shl i896 %r109, 832
%r111 = or i896 %r108, %r110
%r112 = zext i64 %r7 to i128
%r113 = zext i64 %r11 to i128
%r114 = shl i128 %r113, 64
%r115 = or i128 %r112, %r114
%r116 = zext i128 %r115 to i192
%r117 = zext i64 %r15 to i192
%r118 = shl i192 %r117, 128
%r119 = or i192 %r116, %r118
%r120 = zext i192 %r119 to i256
%r121 = zext i64 %r19 to i256
%r122 = shl i256 %r121, 192
%r123 = or i256 %r120, %r122
%r124 = zext i256 %r123 to i320
%r125 = zext i64 %r23 to i320
%r126 = shl i320 %r125, 256
%r127 = or i320 %r124, %r126
%r128 = zext i320 %r127 to i384
%r129 = zext i64 %r27 to i384
%r130 = shl i384 %r129, 320
%r131 = or i384 %r128, %r130
%r132 = zext i384 %r131 to i448
%r133 = zext i64 %r31 to i448
%r134 = shl i448 %r133, 384
%r135 = or i448 %r132, %r134
%r136 = zext i448 %r135 to i512
%r137 = zext i64 %r35 to i512
%r138 = shl i512 %r137, 448
%r139 = or i512 %r136, %r138
%r140 = zext i512 %r139 to i576
%r141 = zext i64 %r39 to i576
%r142 = shl i576 %r141, 512
%r143 = or i576 %r140, %r142
%r144 = zext i576 %r143 to i640
%r145 = zext i64 %r43 to i640
%r146 = shl i640 %r145, 576
%r147 = or i640 %r144, %r146
%r148 = zext i640 %r147 to i704
%r149 = zext i64 %r47 to i704
%r150 = shl i704 %r149, 640
%r151 = or i704 %r148, %r150
%r152 = zext i704 %r151 to i768
%r153 = zext i64 %r51 to i768
%r154 = shl i768 %r153, 704
%r155 = or i768 %r152, %r154
%r156 = zext i768 %r155 to i832
%r157 = zext i64 %r55 to i832
%r158 = shl i832 %r157, 768
%r159 = or i832 %r156, %r158
%r160 = zext i832 %r159 to i896
%r161 = zext i64 %r59 to i896
%r162 = shl i896 %r161, 832
%r163 = or i896 %r160, %r162
%r164 = zext i896 %r111 to i960
%r165 = zext i896 %r163 to i960
%r166 = shl i960 %r165, 64
%r167 = add i960 %r164, %r166
ret i960 %r167
}
define i64 @mclb_mulUnit14(i64* noalias  %r2, i64* noalias  %r3, i64 %r4)
{
%r5 = call i960 @mulUnit_inner896(i64* %r3, i64 %r4)
%r6 = trunc i960 %r5 to i896
%r8 = getelementptr i64, i64* %r2, i32 0
%r9 = trunc i896 %r6 to i64
store i64 %r9, i64* %r8
%r10 = lshr i896 %r6, 64
%r12 = getelementptr i64, i64* %r2, i32 1
%r13 = trunc i896 %r10 to i64
store i64 %r13, i64* %r12
%r14 = lshr i896 %r10, 64
%r16 = getelementptr i64, i64* %r2, i32 2
%r17 = trunc i896 %r14 to i64
store i64 %r17, i64* %r16
%r18 = lshr i896 %r14, 64
%r20 = getelementptr i64, i64* %r2, i32 3
%r21 = trunc i896 %r18 to i64
store i64 %r21, i64* %r20
%r22 = lshr i896 %r18, 64
%r24 = getelementptr i64, i64* %r2, i32 4
%r25 = trunc i896 %r22 to i64
store i64 %r25, i64* %r24
%r26 = lshr i896 %r22, 64
%r28 = getelementptr i64, i64* %r2, i32 5
%r29 = trunc i896 %r26 to i64
store i64 %r29, i64* %r28
%r30 = lshr i896 %r26, 64
%r32 = getelementptr i64, i64* %r2, i32 6
%r33 = trunc i896 %r30 to i64
store i64 %r33, i64* %r32
%r34 = lshr i896 %r30, 64
%r36 = getelementptr i64, i64* %r2, i32 7
%r37 = trunc i896 %r34 to i64
store i64 %r37, i64* %r36
%r38 = lshr i896 %r34, 64
%r40 = getelementptr i64, i64* %r2, i32 8
%r41 = trunc i896 %r38 to i64
store i64 %r41, i64* %r40
%r42 = lshr i896 %r38, 64
%r44 = getelementptr i64, i64* %r2, i32 9
%r45 = trunc i896 %r42 to i64
store i64 %r45, i64* %r44
%r46 = lshr i896 %r42, 64
%r48 = getelementptr i64, i64* %r2, i32 10
%r49 = trunc i896 %r46 to i64
store i64 %r49, i64* %r48
%r50 = lshr i896 %r46, 64
%r52 = getelementptr i64, i64* %r2, i32 11
%r53 = trunc i896 %r50 to i64
store i64 %r53, i64* %r52
%r54 = lshr i896 %r50, 64
%r56 = getelementptr i64, i64* %r2, i32 12
%r57 = trunc i896 %r54 to i64
store i64 %r57, i64* %r56
%r58 = lshr i896 %r54, 64
%r60 = getelementptr i64, i64* %r2, i32 13
%r61 = trunc i896 %r58 to i64
store i64 %r61, i64* %r60
%r62 = lshr i960 %r5, 896
%r63 = trunc i960 %r62 to i64
ret i64 %r63
}
define i64 @mclb_mulUnitAdd14(i64* noalias  %r2, i64* noalias  %r3, i64 %r4)
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
%r42 = call i128 @mulPos64x64(i64* %r3, i64 %r4, i64 9)
%r43 = trunc i128 %r42 to i64
%r44 = call i64 @extractHigh64(i128 %r42)
%r46 = call i128 @mulPos64x64(i64* %r3, i64 %r4, i64 10)
%r47 = trunc i128 %r46 to i64
%r48 = call i64 @extractHigh64(i128 %r46)
%r50 = call i128 @mulPos64x64(i64* %r3, i64 %r4, i64 11)
%r51 = trunc i128 %r50 to i64
%r52 = call i64 @extractHigh64(i128 %r50)
%r54 = call i128 @mulPos64x64(i64* %r3, i64 %r4, i64 12)
%r55 = trunc i128 %r54 to i64
%r56 = call i64 @extractHigh64(i128 %r54)
%r58 = call i128 @mulPos64x64(i64* %r3, i64 %r4, i64 13)
%r59 = trunc i128 %r58 to i64
%r60 = call i64 @extractHigh64(i128 %r58)
%r61 = zext i64 %r7 to i128
%r62 = zext i64 %r11 to i128
%r63 = shl i128 %r62, 64
%r64 = or i128 %r61, %r63
%r65 = zext i128 %r64 to i192
%r66 = zext i64 %r15 to i192
%r67 = shl i192 %r66, 128
%r68 = or i192 %r65, %r67
%r69 = zext i192 %r68 to i256
%r70 = zext i64 %r19 to i256
%r71 = shl i256 %r70, 192
%r72 = or i256 %r69, %r71
%r73 = zext i256 %r72 to i320
%r74 = zext i64 %r23 to i320
%r75 = shl i320 %r74, 256
%r76 = or i320 %r73, %r75
%r77 = zext i320 %r76 to i384
%r78 = zext i64 %r27 to i384
%r79 = shl i384 %r78, 320
%r80 = or i384 %r77, %r79
%r81 = zext i384 %r80 to i448
%r82 = zext i64 %r31 to i448
%r83 = shl i448 %r82, 384
%r84 = or i448 %r81, %r83
%r85 = zext i448 %r84 to i512
%r86 = zext i64 %r35 to i512
%r87 = shl i512 %r86, 448
%r88 = or i512 %r85, %r87
%r89 = zext i512 %r88 to i576
%r90 = zext i64 %r39 to i576
%r91 = shl i576 %r90, 512
%r92 = or i576 %r89, %r91
%r93 = zext i576 %r92 to i640
%r94 = zext i64 %r43 to i640
%r95 = shl i640 %r94, 576
%r96 = or i640 %r93, %r95
%r97 = zext i640 %r96 to i704
%r98 = zext i64 %r47 to i704
%r99 = shl i704 %r98, 640
%r100 = or i704 %r97, %r99
%r101 = zext i704 %r100 to i768
%r102 = zext i64 %r51 to i768
%r103 = shl i768 %r102, 704
%r104 = or i768 %r101, %r103
%r105 = zext i768 %r104 to i832
%r106 = zext i64 %r55 to i832
%r107 = shl i832 %r106, 768
%r108 = or i832 %r105, %r107
%r109 = zext i832 %r108 to i896
%r110 = zext i64 %r59 to i896
%r111 = shl i896 %r110, 832
%r112 = or i896 %r109, %r111
%r113 = zext i64 %r8 to i128
%r114 = zext i64 %r12 to i128
%r115 = shl i128 %r114, 64
%r116 = or i128 %r113, %r115
%r117 = zext i128 %r116 to i192
%r118 = zext i64 %r16 to i192
%r119 = shl i192 %r118, 128
%r120 = or i192 %r117, %r119
%r121 = zext i192 %r120 to i256
%r122 = zext i64 %r20 to i256
%r123 = shl i256 %r122, 192
%r124 = or i256 %r121, %r123
%r125 = zext i256 %r124 to i320
%r126 = zext i64 %r24 to i320
%r127 = shl i320 %r126, 256
%r128 = or i320 %r125, %r127
%r129 = zext i320 %r128 to i384
%r130 = zext i64 %r28 to i384
%r131 = shl i384 %r130, 320
%r132 = or i384 %r129, %r131
%r133 = zext i384 %r132 to i448
%r134 = zext i64 %r32 to i448
%r135 = shl i448 %r134, 384
%r136 = or i448 %r133, %r135
%r137 = zext i448 %r136 to i512
%r138 = zext i64 %r36 to i512
%r139 = shl i512 %r138, 448
%r140 = or i512 %r137, %r139
%r141 = zext i512 %r140 to i576
%r142 = zext i64 %r40 to i576
%r143 = shl i576 %r142, 512
%r144 = or i576 %r141, %r143
%r145 = zext i576 %r144 to i640
%r146 = zext i64 %r44 to i640
%r147 = shl i640 %r146, 576
%r148 = or i640 %r145, %r147
%r149 = zext i640 %r148 to i704
%r150 = zext i64 %r48 to i704
%r151 = shl i704 %r150, 640
%r152 = or i704 %r149, %r151
%r153 = zext i704 %r152 to i768
%r154 = zext i64 %r52 to i768
%r155 = shl i768 %r154, 704
%r156 = or i768 %r153, %r155
%r157 = zext i768 %r156 to i832
%r158 = zext i64 %r56 to i832
%r159 = shl i832 %r158, 768
%r160 = or i832 %r157, %r159
%r161 = zext i832 %r160 to i896
%r162 = zext i64 %r60 to i896
%r163 = shl i896 %r162, 832
%r164 = or i896 %r161, %r163
%r165 = zext i896 %r112 to i960
%r166 = zext i896 %r164 to i960
%r167 = shl i960 %r166, 64
%r168 = add i960 %r165, %r167
%r170 = bitcast i64* %r2 to i896*
%r171 = load i896, i896* %r170
%r172 = zext i896 %r171 to i960
%r173 = add i960 %r168, %r172
%r174 = trunc i960 %r173 to i896
%r176 = getelementptr i64, i64* %r2, i32 0
%r177 = trunc i896 %r174 to i64
store i64 %r177, i64* %r176
%r178 = lshr i896 %r174, 64
%r180 = getelementptr i64, i64* %r2, i32 1
%r181 = trunc i896 %r178 to i64
store i64 %r181, i64* %r180
%r182 = lshr i896 %r178, 64
%r184 = getelementptr i64, i64* %r2, i32 2
%r185 = trunc i896 %r182 to i64
store i64 %r185, i64* %r184
%r186 = lshr i896 %r182, 64
%r188 = getelementptr i64, i64* %r2, i32 3
%r189 = trunc i896 %r186 to i64
store i64 %r189, i64* %r188
%r190 = lshr i896 %r186, 64
%r192 = getelementptr i64, i64* %r2, i32 4
%r193 = trunc i896 %r190 to i64
store i64 %r193, i64* %r192
%r194 = lshr i896 %r190, 64
%r196 = getelementptr i64, i64* %r2, i32 5
%r197 = trunc i896 %r194 to i64
store i64 %r197, i64* %r196
%r198 = lshr i896 %r194, 64
%r200 = getelementptr i64, i64* %r2, i32 6
%r201 = trunc i896 %r198 to i64
store i64 %r201, i64* %r200
%r202 = lshr i896 %r198, 64
%r204 = getelementptr i64, i64* %r2, i32 7
%r205 = trunc i896 %r202 to i64
store i64 %r205, i64* %r204
%r206 = lshr i896 %r202, 64
%r208 = getelementptr i64, i64* %r2, i32 8
%r209 = trunc i896 %r206 to i64
store i64 %r209, i64* %r208
%r210 = lshr i896 %r206, 64
%r212 = getelementptr i64, i64* %r2, i32 9
%r213 = trunc i896 %r210 to i64
store i64 %r213, i64* %r212
%r214 = lshr i896 %r210, 64
%r216 = getelementptr i64, i64* %r2, i32 10
%r217 = trunc i896 %r214 to i64
store i64 %r217, i64* %r216
%r218 = lshr i896 %r214, 64
%r220 = getelementptr i64, i64* %r2, i32 11
%r221 = trunc i896 %r218 to i64
store i64 %r221, i64* %r220
%r222 = lshr i896 %r218, 64
%r224 = getelementptr i64, i64* %r2, i32 12
%r225 = trunc i896 %r222 to i64
store i64 %r225, i64* %r224
%r226 = lshr i896 %r222, 64
%r228 = getelementptr i64, i64* %r2, i32 13
%r229 = trunc i896 %r226 to i64
store i64 %r229, i64* %r228
%r230 = lshr i960 %r173, 896
%r231 = trunc i960 %r230 to i64
ret i64 %r231
}
define void @mclb_mul14(i64* noalias  %r1, i64* noalias  %r2, i64* noalias  %r3)
{
%r5 = getelementptr i64, i64* %r2, i32 7
%r7 = getelementptr i64, i64* %r3, i32 7
%r9 = getelementptr i64, i64* %r1, i32 14
call void @mclb_mul7(i64* %r1, i64* %r2, i64* %r3)
call void @mclb_mul7(i64* %r9, i64* %r5, i64* %r7)
%r11 = bitcast i64* %r5 to i448*
%r12 = load i448, i448* %r11
%r13 = zext i448 %r12 to i512
%r15 = bitcast i64* %r2 to i448*
%r16 = load i448, i448* %r15
%r17 = zext i448 %r16 to i512
%r19 = bitcast i64* %r7 to i448*
%r20 = load i448, i448* %r19
%r21 = zext i448 %r20 to i512
%r23 = bitcast i64* %r3 to i448*
%r24 = load i448, i448* %r23
%r25 = zext i448 %r24 to i512
%r26 = add i512 %r13, %r17
%r27 = add i512 %r21, %r25
%r29 = alloca i64, i32 14
%r30 = trunc i512 %r26 to i448
%r31 = trunc i512 %r27 to i448
%r32 = lshr i512 %r26, 448
%r33 = trunc i512 %r32 to i1
%r34 = lshr i512 %r27, 448
%r35 = trunc i512 %r34 to i1
%r36 = and i1 %r33, %r35
%r38 = select i1 %r33, i448 %r31, i448 0
%r40 = select i1 %r35, i448 %r30, i448 0
%r42 = alloca i64, i32 7
%r44 = alloca i64, i32 7
%r46 = getelementptr i64, i64* %r42, i32 0
%r47 = trunc i448 %r30 to i64
store i64 %r47, i64* %r46
%r48 = lshr i448 %r30, 64
%r50 = getelementptr i64, i64* %r42, i32 1
%r51 = trunc i448 %r48 to i64
store i64 %r51, i64* %r50
%r52 = lshr i448 %r48, 64
%r54 = getelementptr i64, i64* %r42, i32 2
%r55 = trunc i448 %r52 to i64
store i64 %r55, i64* %r54
%r56 = lshr i448 %r52, 64
%r58 = getelementptr i64, i64* %r42, i32 3
%r59 = trunc i448 %r56 to i64
store i64 %r59, i64* %r58
%r60 = lshr i448 %r56, 64
%r62 = getelementptr i64, i64* %r42, i32 4
%r63 = trunc i448 %r60 to i64
store i64 %r63, i64* %r62
%r64 = lshr i448 %r60, 64
%r66 = getelementptr i64, i64* %r42, i32 5
%r67 = trunc i448 %r64 to i64
store i64 %r67, i64* %r66
%r68 = lshr i448 %r64, 64
%r70 = getelementptr i64, i64* %r42, i32 6
%r71 = trunc i448 %r68 to i64
store i64 %r71, i64* %r70
%r73 = getelementptr i64, i64* %r44, i32 0
%r74 = trunc i448 %r31 to i64
store i64 %r74, i64* %r73
%r75 = lshr i448 %r31, 64
%r77 = getelementptr i64, i64* %r44, i32 1
%r78 = trunc i448 %r75 to i64
store i64 %r78, i64* %r77
%r79 = lshr i448 %r75, 64
%r81 = getelementptr i64, i64* %r44, i32 2
%r82 = trunc i448 %r79 to i64
store i64 %r82, i64* %r81
%r83 = lshr i448 %r79, 64
%r85 = getelementptr i64, i64* %r44, i32 3
%r86 = trunc i448 %r83 to i64
store i64 %r86, i64* %r85
%r87 = lshr i448 %r83, 64
%r89 = getelementptr i64, i64* %r44, i32 4
%r90 = trunc i448 %r87 to i64
store i64 %r90, i64* %r89
%r91 = lshr i448 %r87, 64
%r93 = getelementptr i64, i64* %r44, i32 5
%r94 = trunc i448 %r91 to i64
store i64 %r94, i64* %r93
%r95 = lshr i448 %r91, 64
%r97 = getelementptr i64, i64* %r44, i32 6
%r98 = trunc i448 %r95 to i64
store i64 %r98, i64* %r97
call void @mclb_mul7(i64* %r29, i64* %r42, i64* %r44)
%r100 = bitcast i64* %r29 to i896*
%r101 = load i896, i896* %r100
%r102 = zext i896 %r101 to i960
%r103 = zext i1 %r36 to i960
%r104 = shl i960 %r103, 896
%r105 = or i960 %r102, %r104
%r106 = zext i448 %r38 to i960
%r107 = zext i448 %r40 to i960
%r108 = shl i960 %r106, 448
%r109 = shl i960 %r107, 448
%r110 = add i960 %r105, %r108
%r111 = add i960 %r110, %r109
%r113 = bitcast i64* %r1 to i896*
%r114 = load i896, i896* %r113
%r115 = zext i896 %r114 to i960
%r116 = sub i960 %r111, %r115
%r118 = getelementptr i64, i64* %r1, i32 14
%r120 = bitcast i64* %r118 to i896*
%r121 = load i896, i896* %r120
%r122 = zext i896 %r121 to i960
%r123 = sub i960 %r116, %r122
%r124 = zext i960 %r123 to i1344
%r126 = getelementptr i64, i64* %r1, i32 7
%r128 = bitcast i64* %r126 to i1344*
%r129 = load i1344, i1344* %r128
%r130 = add i1344 %r124, %r129
%r132 = getelementptr i64, i64* %r1, i32 7
%r134 = getelementptr i64, i64* %r132, i32 0
%r135 = trunc i1344 %r130 to i64
store i64 %r135, i64* %r134
%r136 = lshr i1344 %r130, 64
%r138 = getelementptr i64, i64* %r132, i32 1
%r139 = trunc i1344 %r136 to i64
store i64 %r139, i64* %r138
%r140 = lshr i1344 %r136, 64
%r142 = getelementptr i64, i64* %r132, i32 2
%r143 = trunc i1344 %r140 to i64
store i64 %r143, i64* %r142
%r144 = lshr i1344 %r140, 64
%r146 = getelementptr i64, i64* %r132, i32 3
%r147 = trunc i1344 %r144 to i64
store i64 %r147, i64* %r146
%r148 = lshr i1344 %r144, 64
%r150 = getelementptr i64, i64* %r132, i32 4
%r151 = trunc i1344 %r148 to i64
store i64 %r151, i64* %r150
%r152 = lshr i1344 %r148, 64
%r154 = getelementptr i64, i64* %r132, i32 5
%r155 = trunc i1344 %r152 to i64
store i64 %r155, i64* %r154
%r156 = lshr i1344 %r152, 64
%r158 = getelementptr i64, i64* %r132, i32 6
%r159 = trunc i1344 %r156 to i64
store i64 %r159, i64* %r158
%r160 = lshr i1344 %r156, 64
%r162 = getelementptr i64, i64* %r132, i32 7
%r163 = trunc i1344 %r160 to i64
store i64 %r163, i64* %r162
%r164 = lshr i1344 %r160, 64
%r166 = getelementptr i64, i64* %r132, i32 8
%r167 = trunc i1344 %r164 to i64
store i64 %r167, i64* %r166
%r168 = lshr i1344 %r164, 64
%r170 = getelementptr i64, i64* %r132, i32 9
%r171 = trunc i1344 %r168 to i64
store i64 %r171, i64* %r170
%r172 = lshr i1344 %r168, 64
%r174 = getelementptr i64, i64* %r132, i32 10
%r175 = trunc i1344 %r172 to i64
store i64 %r175, i64* %r174
%r176 = lshr i1344 %r172, 64
%r178 = getelementptr i64, i64* %r132, i32 11
%r179 = trunc i1344 %r176 to i64
store i64 %r179, i64* %r178
%r180 = lshr i1344 %r176, 64
%r182 = getelementptr i64, i64* %r132, i32 12
%r183 = trunc i1344 %r180 to i64
store i64 %r183, i64* %r182
%r184 = lshr i1344 %r180, 64
%r186 = getelementptr i64, i64* %r132, i32 13
%r187 = trunc i1344 %r184 to i64
store i64 %r187, i64* %r186
%r188 = lshr i1344 %r184, 64
%r190 = getelementptr i64, i64* %r132, i32 14
%r191 = trunc i1344 %r188 to i64
store i64 %r191, i64* %r190
%r192 = lshr i1344 %r188, 64
%r194 = getelementptr i64, i64* %r132, i32 15
%r195 = trunc i1344 %r192 to i64
store i64 %r195, i64* %r194
%r196 = lshr i1344 %r192, 64
%r198 = getelementptr i64, i64* %r132, i32 16
%r199 = trunc i1344 %r196 to i64
store i64 %r199, i64* %r198
%r200 = lshr i1344 %r196, 64
%r202 = getelementptr i64, i64* %r132, i32 17
%r203 = trunc i1344 %r200 to i64
store i64 %r203, i64* %r202
%r204 = lshr i1344 %r200, 64
%r206 = getelementptr i64, i64* %r132, i32 18
%r207 = trunc i1344 %r204 to i64
store i64 %r207, i64* %r206
%r208 = lshr i1344 %r204, 64
%r210 = getelementptr i64, i64* %r132, i32 19
%r211 = trunc i1344 %r208 to i64
store i64 %r211, i64* %r210
%r212 = lshr i1344 %r208, 64
%r214 = getelementptr i64, i64* %r132, i32 20
%r215 = trunc i1344 %r212 to i64
store i64 %r215, i64* %r214
ret void
}
define void @mclb_sqr14(i64* noalias  %r1, i64* noalias  %r2)
{
%r4 = getelementptr i64, i64* %r2, i32 7
%r6 = getelementptr i64, i64* %r1, i32 14
%r8 = alloca i64, i32 14
call void @mclb_mul7(i64* %r8, i64* %r2, i64* %r4)
call void @mclb_sqr7(i64* %r1, i64* %r2)
call void @mclb_sqr7(i64* %r6, i64* %r4)
%r10 = bitcast i64* %r8 to i896*
%r11 = load i896, i896* %r10
%r12 = zext i896 %r11 to i960
%r13 = add i960 %r12, %r12
%r14 = zext i960 %r13 to i1344
%r16 = getelementptr i64, i64* %r1, i32 7
%r18 = bitcast i64* %r16 to i1344*
%r19 = load i1344, i1344* %r18
%r20 = add i1344 %r19, %r14
%r22 = getelementptr i64, i64* %r16, i32 0
%r23 = trunc i1344 %r20 to i64
store i64 %r23, i64* %r22
%r24 = lshr i1344 %r20, 64
%r26 = getelementptr i64, i64* %r16, i32 1
%r27 = trunc i1344 %r24 to i64
store i64 %r27, i64* %r26
%r28 = lshr i1344 %r24, 64
%r30 = getelementptr i64, i64* %r16, i32 2
%r31 = trunc i1344 %r28 to i64
store i64 %r31, i64* %r30
%r32 = lshr i1344 %r28, 64
%r34 = getelementptr i64, i64* %r16, i32 3
%r35 = trunc i1344 %r32 to i64
store i64 %r35, i64* %r34
%r36 = lshr i1344 %r32, 64
%r38 = getelementptr i64, i64* %r16, i32 4
%r39 = trunc i1344 %r36 to i64
store i64 %r39, i64* %r38
%r40 = lshr i1344 %r36, 64
%r42 = getelementptr i64, i64* %r16, i32 5
%r43 = trunc i1344 %r40 to i64
store i64 %r43, i64* %r42
%r44 = lshr i1344 %r40, 64
%r46 = getelementptr i64, i64* %r16, i32 6
%r47 = trunc i1344 %r44 to i64
store i64 %r47, i64* %r46
%r48 = lshr i1344 %r44, 64
%r50 = getelementptr i64, i64* %r16, i32 7
%r51 = trunc i1344 %r48 to i64
store i64 %r51, i64* %r50
%r52 = lshr i1344 %r48, 64
%r54 = getelementptr i64, i64* %r16, i32 8
%r55 = trunc i1344 %r52 to i64
store i64 %r55, i64* %r54
%r56 = lshr i1344 %r52, 64
%r58 = getelementptr i64, i64* %r16, i32 9
%r59 = trunc i1344 %r56 to i64
store i64 %r59, i64* %r58
%r60 = lshr i1344 %r56, 64
%r62 = getelementptr i64, i64* %r16, i32 10
%r63 = trunc i1344 %r60 to i64
store i64 %r63, i64* %r62
%r64 = lshr i1344 %r60, 64
%r66 = getelementptr i64, i64* %r16, i32 11
%r67 = trunc i1344 %r64 to i64
store i64 %r67, i64* %r66
%r68 = lshr i1344 %r64, 64
%r70 = getelementptr i64, i64* %r16, i32 12
%r71 = trunc i1344 %r68 to i64
store i64 %r71, i64* %r70
%r72 = lshr i1344 %r68, 64
%r74 = getelementptr i64, i64* %r16, i32 13
%r75 = trunc i1344 %r72 to i64
store i64 %r75, i64* %r74
%r76 = lshr i1344 %r72, 64
%r78 = getelementptr i64, i64* %r16, i32 14
%r79 = trunc i1344 %r76 to i64
store i64 %r79, i64* %r78
%r80 = lshr i1344 %r76, 64
%r82 = getelementptr i64, i64* %r16, i32 15
%r83 = trunc i1344 %r80 to i64
store i64 %r83, i64* %r82
%r84 = lshr i1344 %r80, 64
%r86 = getelementptr i64, i64* %r16, i32 16
%r87 = trunc i1344 %r84 to i64
store i64 %r87, i64* %r86
%r88 = lshr i1344 %r84, 64
%r90 = getelementptr i64, i64* %r16, i32 17
%r91 = trunc i1344 %r88 to i64
store i64 %r91, i64* %r90
%r92 = lshr i1344 %r88, 64
%r94 = getelementptr i64, i64* %r16, i32 18
%r95 = trunc i1344 %r92 to i64
store i64 %r95, i64* %r94
%r96 = lshr i1344 %r92, 64
%r98 = getelementptr i64, i64* %r16, i32 19
%r99 = trunc i1344 %r96 to i64
store i64 %r99, i64* %r98
%r100 = lshr i1344 %r96, 64
%r102 = getelementptr i64, i64* %r16, i32 20
%r103 = trunc i1344 %r100 to i64
store i64 %r103, i64* %r102
ret void
}
define private i896 @mulUnit2_inner896(i64* noalias  %r2, i64 %r3)
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
%r41 = call i128 @mulPos64x64(i64* %r2, i64 %r3, i64 9)
%r42 = trunc i128 %r41 to i64
%r43 = call i64 @extractHigh64(i128 %r41)
%r45 = call i128 @mulPos64x64(i64* %r2, i64 %r3, i64 10)
%r46 = trunc i128 %r45 to i64
%r47 = call i64 @extractHigh64(i128 %r45)
%r49 = call i128 @mulPos64x64(i64* %r2, i64 %r3, i64 11)
%r50 = trunc i128 %r49 to i64
%r51 = call i64 @extractHigh64(i128 %r49)
%r53 = call i128 @mulPos64x64(i64* %r2, i64 %r3, i64 12)
%r54 = trunc i128 %r53 to i64
%r55 = call i64 @extractHigh64(i128 %r53)
%r57 = call i128 @mulPos64x64(i64* %r2, i64 %r3, i64 13)
%r58 = trunc i128 %r57 to i64
%r59 = zext i64 %r6 to i128
%r60 = zext i64 %r10 to i128
%r61 = shl i128 %r60, 64
%r62 = or i128 %r59, %r61
%r63 = zext i128 %r62 to i192
%r64 = zext i64 %r14 to i192
%r65 = shl i192 %r64, 128
%r66 = or i192 %r63, %r65
%r67 = zext i192 %r66 to i256
%r68 = zext i64 %r18 to i256
%r69 = shl i256 %r68, 192
%r70 = or i256 %r67, %r69
%r71 = zext i256 %r70 to i320
%r72 = zext i64 %r22 to i320
%r73 = shl i320 %r72, 256
%r74 = or i320 %r71, %r73
%r75 = zext i320 %r74 to i384
%r76 = zext i64 %r26 to i384
%r77 = shl i384 %r76, 320
%r78 = or i384 %r75, %r77
%r79 = zext i384 %r78 to i448
%r80 = zext i64 %r30 to i448
%r81 = shl i448 %r80, 384
%r82 = or i448 %r79, %r81
%r83 = zext i448 %r82 to i512
%r84 = zext i64 %r34 to i512
%r85 = shl i512 %r84, 448
%r86 = or i512 %r83, %r85
%r87 = zext i512 %r86 to i576
%r88 = zext i64 %r38 to i576
%r89 = shl i576 %r88, 512
%r90 = or i576 %r87, %r89
%r91 = zext i576 %r90 to i640
%r92 = zext i64 %r42 to i640
%r93 = shl i640 %r92, 576
%r94 = or i640 %r91, %r93
%r95 = zext i640 %r94 to i704
%r96 = zext i64 %r46 to i704
%r97 = shl i704 %r96, 640
%r98 = or i704 %r95, %r97
%r99 = zext i704 %r98 to i768
%r100 = zext i64 %r50 to i768
%r101 = shl i768 %r100, 704
%r102 = or i768 %r99, %r101
%r103 = zext i768 %r102 to i832
%r104 = zext i64 %r54 to i832
%r105 = shl i832 %r104, 768
%r106 = or i832 %r103, %r105
%r107 = zext i832 %r106 to i896
%r108 = zext i64 %r58 to i896
%r109 = shl i896 %r108, 832
%r110 = or i896 %r107, %r109
%r111 = zext i64 %r7 to i128
%r112 = zext i64 %r11 to i128
%r113 = shl i128 %r112, 64
%r114 = or i128 %r111, %r113
%r115 = zext i128 %r114 to i192
%r116 = zext i64 %r15 to i192
%r117 = shl i192 %r116, 128
%r118 = or i192 %r115, %r117
%r119 = zext i192 %r118 to i256
%r120 = zext i64 %r19 to i256
%r121 = shl i256 %r120, 192
%r122 = or i256 %r119, %r121
%r123 = zext i256 %r122 to i320
%r124 = zext i64 %r23 to i320
%r125 = shl i320 %r124, 256
%r126 = or i320 %r123, %r125
%r127 = zext i320 %r126 to i384
%r128 = zext i64 %r27 to i384
%r129 = shl i384 %r128, 320
%r130 = or i384 %r127, %r129
%r131 = zext i384 %r130 to i448
%r132 = zext i64 %r31 to i448
%r133 = shl i448 %r132, 384
%r134 = or i448 %r131, %r133
%r135 = zext i448 %r134 to i512
%r136 = zext i64 %r35 to i512
%r137 = shl i512 %r136, 448
%r138 = or i512 %r135, %r137
%r139 = zext i512 %r138 to i576
%r140 = zext i64 %r39 to i576
%r141 = shl i576 %r140, 512
%r142 = or i576 %r139, %r141
%r143 = zext i576 %r142 to i640
%r144 = zext i64 %r43 to i640
%r145 = shl i640 %r144, 576
%r146 = or i640 %r143, %r145
%r147 = zext i640 %r146 to i704
%r148 = zext i64 %r47 to i704
%r149 = shl i704 %r148, 640
%r150 = or i704 %r147, %r149
%r151 = zext i704 %r150 to i768
%r152 = zext i64 %r51 to i768
%r153 = shl i768 %r152, 704
%r154 = or i768 %r151, %r153
%r155 = zext i768 %r154 to i832
%r156 = zext i64 %r55 to i832
%r157 = shl i832 %r156, 768
%r158 = or i832 %r155, %r157
%r159 = zext i832 %r158 to i896
%r160 = shl i896 %r159, 64
%r161 = add i896 %r110, %r160
ret i896 %r161
}
define i1024 @mulUnit_inner960(i64* noalias  %r2, i64 %r3)
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
%r41 = call i128 @mulPos64x64(i64* %r2, i64 %r3, i64 9)
%r42 = trunc i128 %r41 to i64
%r43 = call i64 @extractHigh64(i128 %r41)
%r45 = call i128 @mulPos64x64(i64* %r2, i64 %r3, i64 10)
%r46 = trunc i128 %r45 to i64
%r47 = call i64 @extractHigh64(i128 %r45)
%r49 = call i128 @mulPos64x64(i64* %r2, i64 %r3, i64 11)
%r50 = trunc i128 %r49 to i64
%r51 = call i64 @extractHigh64(i128 %r49)
%r53 = call i128 @mulPos64x64(i64* %r2, i64 %r3, i64 12)
%r54 = trunc i128 %r53 to i64
%r55 = call i64 @extractHigh64(i128 %r53)
%r57 = call i128 @mulPos64x64(i64* %r2, i64 %r3, i64 13)
%r58 = trunc i128 %r57 to i64
%r59 = call i64 @extractHigh64(i128 %r57)
%r61 = call i128 @mulPos64x64(i64* %r2, i64 %r3, i64 14)
%r62 = trunc i128 %r61 to i64
%r63 = call i64 @extractHigh64(i128 %r61)
%r64 = zext i64 %r6 to i128
%r65 = zext i64 %r10 to i128
%r66 = shl i128 %r65, 64
%r67 = or i128 %r64, %r66
%r68 = zext i128 %r67 to i192
%r69 = zext i64 %r14 to i192
%r70 = shl i192 %r69, 128
%r71 = or i192 %r68, %r70
%r72 = zext i192 %r71 to i256
%r73 = zext i64 %r18 to i256
%r74 = shl i256 %r73, 192
%r75 = or i256 %r72, %r74
%r76 = zext i256 %r75 to i320
%r77 = zext i64 %r22 to i320
%r78 = shl i320 %r77, 256
%r79 = or i320 %r76, %r78
%r80 = zext i320 %r79 to i384
%r81 = zext i64 %r26 to i384
%r82 = shl i384 %r81, 320
%r83 = or i384 %r80, %r82
%r84 = zext i384 %r83 to i448
%r85 = zext i64 %r30 to i448
%r86 = shl i448 %r85, 384
%r87 = or i448 %r84, %r86
%r88 = zext i448 %r87 to i512
%r89 = zext i64 %r34 to i512
%r90 = shl i512 %r89, 448
%r91 = or i512 %r88, %r90
%r92 = zext i512 %r91 to i576
%r93 = zext i64 %r38 to i576
%r94 = shl i576 %r93, 512
%r95 = or i576 %r92, %r94
%r96 = zext i576 %r95 to i640
%r97 = zext i64 %r42 to i640
%r98 = shl i640 %r97, 576
%r99 = or i640 %r96, %r98
%r100 = zext i640 %r99 to i704
%r101 = zext i64 %r46 to i704
%r102 = shl i704 %r101, 640
%r103 = or i704 %r100, %r102
%r104 = zext i704 %r103 to i768
%r105 = zext i64 %r50 to i768
%r106 = shl i768 %r105, 704
%r107 = or i768 %r104, %r106
%r108 = zext i768 %r107 to i832
%r109 = zext i64 %r54 to i832
%r110 = shl i832 %r109, 768
%r111 = or i832 %r108, %r110
%r112 = zext i832 %r111 to i896
%r113 = zext i64 %r58 to i896
%r114 = shl i896 %r113, 832
%r115 = or i896 %r112, %r114
%r116 = zext i896 %r115 to i960
%r117 = zext i64 %r62 to i960
%r118 = shl i960 %r117, 896
%r119 = or i960 %r116, %r118
%r120 = zext i64 %r7 to i128
%r121 = zext i64 %r11 to i128
%r122 = shl i128 %r121, 64
%r123 = or i128 %r120, %r122
%r124 = zext i128 %r123 to i192
%r125 = zext i64 %r15 to i192
%r126 = shl i192 %r125, 128
%r127 = or i192 %r124, %r126
%r128 = zext i192 %r127 to i256
%r129 = zext i64 %r19 to i256
%r130 = shl i256 %r129, 192
%r131 = or i256 %r128, %r130
%r132 = zext i256 %r131 to i320
%r133 = zext i64 %r23 to i320
%r134 = shl i320 %r133, 256
%r135 = or i320 %r132, %r134
%r136 = zext i320 %r135 to i384
%r137 = zext i64 %r27 to i384
%r138 = shl i384 %r137, 320
%r139 = or i384 %r136, %r138
%r140 = zext i384 %r139 to i448
%r141 = zext i64 %r31 to i448
%r142 = shl i448 %r141, 384
%r143 = or i448 %r140, %r142
%r144 = zext i448 %r143 to i512
%r145 = zext i64 %r35 to i512
%r146 = shl i512 %r145, 448
%r147 = or i512 %r144, %r146
%r148 = zext i512 %r147 to i576
%r149 = zext i64 %r39 to i576
%r150 = shl i576 %r149, 512
%r151 = or i576 %r148, %r150
%r152 = zext i576 %r151 to i640
%r153 = zext i64 %r43 to i640
%r154 = shl i640 %r153, 576
%r155 = or i640 %r152, %r154
%r156 = zext i640 %r155 to i704
%r157 = zext i64 %r47 to i704
%r158 = shl i704 %r157, 640
%r159 = or i704 %r156, %r158
%r160 = zext i704 %r159 to i768
%r161 = zext i64 %r51 to i768
%r162 = shl i768 %r161, 704
%r163 = or i768 %r160, %r162
%r164 = zext i768 %r163 to i832
%r165 = zext i64 %r55 to i832
%r166 = shl i832 %r165, 768
%r167 = or i832 %r164, %r166
%r168 = zext i832 %r167 to i896
%r169 = zext i64 %r59 to i896
%r170 = shl i896 %r169, 832
%r171 = or i896 %r168, %r170
%r172 = zext i896 %r171 to i960
%r173 = zext i64 %r63 to i960
%r174 = shl i960 %r173, 896
%r175 = or i960 %r172, %r174
%r176 = zext i960 %r119 to i1024
%r177 = zext i960 %r175 to i1024
%r178 = shl i1024 %r177, 64
%r179 = add i1024 %r176, %r178
ret i1024 %r179
}
define i64 @mclb_mulUnit15(i64* noalias  %r2, i64* noalias  %r3, i64 %r4)
{
%r5 = call i1024 @mulUnit_inner960(i64* %r3, i64 %r4)
%r6 = trunc i1024 %r5 to i960
%r8 = getelementptr i64, i64* %r2, i32 0
%r9 = trunc i960 %r6 to i64
store i64 %r9, i64* %r8
%r10 = lshr i960 %r6, 64
%r12 = getelementptr i64, i64* %r2, i32 1
%r13 = trunc i960 %r10 to i64
store i64 %r13, i64* %r12
%r14 = lshr i960 %r10, 64
%r16 = getelementptr i64, i64* %r2, i32 2
%r17 = trunc i960 %r14 to i64
store i64 %r17, i64* %r16
%r18 = lshr i960 %r14, 64
%r20 = getelementptr i64, i64* %r2, i32 3
%r21 = trunc i960 %r18 to i64
store i64 %r21, i64* %r20
%r22 = lshr i960 %r18, 64
%r24 = getelementptr i64, i64* %r2, i32 4
%r25 = trunc i960 %r22 to i64
store i64 %r25, i64* %r24
%r26 = lshr i960 %r22, 64
%r28 = getelementptr i64, i64* %r2, i32 5
%r29 = trunc i960 %r26 to i64
store i64 %r29, i64* %r28
%r30 = lshr i960 %r26, 64
%r32 = getelementptr i64, i64* %r2, i32 6
%r33 = trunc i960 %r30 to i64
store i64 %r33, i64* %r32
%r34 = lshr i960 %r30, 64
%r36 = getelementptr i64, i64* %r2, i32 7
%r37 = trunc i960 %r34 to i64
store i64 %r37, i64* %r36
%r38 = lshr i960 %r34, 64
%r40 = getelementptr i64, i64* %r2, i32 8
%r41 = trunc i960 %r38 to i64
store i64 %r41, i64* %r40
%r42 = lshr i960 %r38, 64
%r44 = getelementptr i64, i64* %r2, i32 9
%r45 = trunc i960 %r42 to i64
store i64 %r45, i64* %r44
%r46 = lshr i960 %r42, 64
%r48 = getelementptr i64, i64* %r2, i32 10
%r49 = trunc i960 %r46 to i64
store i64 %r49, i64* %r48
%r50 = lshr i960 %r46, 64
%r52 = getelementptr i64, i64* %r2, i32 11
%r53 = trunc i960 %r50 to i64
store i64 %r53, i64* %r52
%r54 = lshr i960 %r50, 64
%r56 = getelementptr i64, i64* %r2, i32 12
%r57 = trunc i960 %r54 to i64
store i64 %r57, i64* %r56
%r58 = lshr i960 %r54, 64
%r60 = getelementptr i64, i64* %r2, i32 13
%r61 = trunc i960 %r58 to i64
store i64 %r61, i64* %r60
%r62 = lshr i960 %r58, 64
%r64 = getelementptr i64, i64* %r2, i32 14
%r65 = trunc i960 %r62 to i64
store i64 %r65, i64* %r64
%r66 = lshr i1024 %r5, 960
%r67 = trunc i1024 %r66 to i64
ret i64 %r67
}
define i64 @mclb_mulUnitAdd15(i64* noalias  %r2, i64* noalias  %r3, i64 %r4)
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
%r42 = call i128 @mulPos64x64(i64* %r3, i64 %r4, i64 9)
%r43 = trunc i128 %r42 to i64
%r44 = call i64 @extractHigh64(i128 %r42)
%r46 = call i128 @mulPos64x64(i64* %r3, i64 %r4, i64 10)
%r47 = trunc i128 %r46 to i64
%r48 = call i64 @extractHigh64(i128 %r46)
%r50 = call i128 @mulPos64x64(i64* %r3, i64 %r4, i64 11)
%r51 = trunc i128 %r50 to i64
%r52 = call i64 @extractHigh64(i128 %r50)
%r54 = call i128 @mulPos64x64(i64* %r3, i64 %r4, i64 12)
%r55 = trunc i128 %r54 to i64
%r56 = call i64 @extractHigh64(i128 %r54)
%r58 = call i128 @mulPos64x64(i64* %r3, i64 %r4, i64 13)
%r59 = trunc i128 %r58 to i64
%r60 = call i64 @extractHigh64(i128 %r58)
%r62 = call i128 @mulPos64x64(i64* %r3, i64 %r4, i64 14)
%r63 = trunc i128 %r62 to i64
%r64 = call i64 @extractHigh64(i128 %r62)
%r65 = zext i64 %r7 to i128
%r66 = zext i64 %r11 to i128
%r67 = shl i128 %r66, 64
%r68 = or i128 %r65, %r67
%r69 = zext i128 %r68 to i192
%r70 = zext i64 %r15 to i192
%r71 = shl i192 %r70, 128
%r72 = or i192 %r69, %r71
%r73 = zext i192 %r72 to i256
%r74 = zext i64 %r19 to i256
%r75 = shl i256 %r74, 192
%r76 = or i256 %r73, %r75
%r77 = zext i256 %r76 to i320
%r78 = zext i64 %r23 to i320
%r79 = shl i320 %r78, 256
%r80 = or i320 %r77, %r79
%r81 = zext i320 %r80 to i384
%r82 = zext i64 %r27 to i384
%r83 = shl i384 %r82, 320
%r84 = or i384 %r81, %r83
%r85 = zext i384 %r84 to i448
%r86 = zext i64 %r31 to i448
%r87 = shl i448 %r86, 384
%r88 = or i448 %r85, %r87
%r89 = zext i448 %r88 to i512
%r90 = zext i64 %r35 to i512
%r91 = shl i512 %r90, 448
%r92 = or i512 %r89, %r91
%r93 = zext i512 %r92 to i576
%r94 = zext i64 %r39 to i576
%r95 = shl i576 %r94, 512
%r96 = or i576 %r93, %r95
%r97 = zext i576 %r96 to i640
%r98 = zext i64 %r43 to i640
%r99 = shl i640 %r98, 576
%r100 = or i640 %r97, %r99
%r101 = zext i640 %r100 to i704
%r102 = zext i64 %r47 to i704
%r103 = shl i704 %r102, 640
%r104 = or i704 %r101, %r103
%r105 = zext i704 %r104 to i768
%r106 = zext i64 %r51 to i768
%r107 = shl i768 %r106, 704
%r108 = or i768 %r105, %r107
%r109 = zext i768 %r108 to i832
%r110 = zext i64 %r55 to i832
%r111 = shl i832 %r110, 768
%r112 = or i832 %r109, %r111
%r113 = zext i832 %r112 to i896
%r114 = zext i64 %r59 to i896
%r115 = shl i896 %r114, 832
%r116 = or i896 %r113, %r115
%r117 = zext i896 %r116 to i960
%r118 = zext i64 %r63 to i960
%r119 = shl i960 %r118, 896
%r120 = or i960 %r117, %r119
%r121 = zext i64 %r8 to i128
%r122 = zext i64 %r12 to i128
%r123 = shl i128 %r122, 64
%r124 = or i128 %r121, %r123
%r125 = zext i128 %r124 to i192
%r126 = zext i64 %r16 to i192
%r127 = shl i192 %r126, 128
%r128 = or i192 %r125, %r127
%r129 = zext i192 %r128 to i256
%r130 = zext i64 %r20 to i256
%r131 = shl i256 %r130, 192
%r132 = or i256 %r129, %r131
%r133 = zext i256 %r132 to i320
%r134 = zext i64 %r24 to i320
%r135 = shl i320 %r134, 256
%r136 = or i320 %r133, %r135
%r137 = zext i320 %r136 to i384
%r138 = zext i64 %r28 to i384
%r139 = shl i384 %r138, 320
%r140 = or i384 %r137, %r139
%r141 = zext i384 %r140 to i448
%r142 = zext i64 %r32 to i448
%r143 = shl i448 %r142, 384
%r144 = or i448 %r141, %r143
%r145 = zext i448 %r144 to i512
%r146 = zext i64 %r36 to i512
%r147 = shl i512 %r146, 448
%r148 = or i512 %r145, %r147
%r149 = zext i512 %r148 to i576
%r150 = zext i64 %r40 to i576
%r151 = shl i576 %r150, 512
%r152 = or i576 %r149, %r151
%r153 = zext i576 %r152 to i640
%r154 = zext i64 %r44 to i640
%r155 = shl i640 %r154, 576
%r156 = or i640 %r153, %r155
%r157 = zext i640 %r156 to i704
%r158 = zext i64 %r48 to i704
%r159 = shl i704 %r158, 640
%r160 = or i704 %r157, %r159
%r161 = zext i704 %r160 to i768
%r162 = zext i64 %r52 to i768
%r163 = shl i768 %r162, 704
%r164 = or i768 %r161, %r163
%r165 = zext i768 %r164 to i832
%r166 = zext i64 %r56 to i832
%r167 = shl i832 %r166, 768
%r168 = or i832 %r165, %r167
%r169 = zext i832 %r168 to i896
%r170 = zext i64 %r60 to i896
%r171 = shl i896 %r170, 832
%r172 = or i896 %r169, %r171
%r173 = zext i896 %r172 to i960
%r174 = zext i64 %r64 to i960
%r175 = shl i960 %r174, 896
%r176 = or i960 %r173, %r175
%r177 = zext i960 %r120 to i1024
%r178 = zext i960 %r176 to i1024
%r179 = shl i1024 %r178, 64
%r180 = add i1024 %r177, %r179
%r182 = bitcast i64* %r2 to i960*
%r183 = load i960, i960* %r182
%r184 = zext i960 %r183 to i1024
%r185 = add i1024 %r180, %r184
%r186 = trunc i1024 %r185 to i960
%r188 = getelementptr i64, i64* %r2, i32 0
%r189 = trunc i960 %r186 to i64
store i64 %r189, i64* %r188
%r190 = lshr i960 %r186, 64
%r192 = getelementptr i64, i64* %r2, i32 1
%r193 = trunc i960 %r190 to i64
store i64 %r193, i64* %r192
%r194 = lshr i960 %r190, 64
%r196 = getelementptr i64, i64* %r2, i32 2
%r197 = trunc i960 %r194 to i64
store i64 %r197, i64* %r196
%r198 = lshr i960 %r194, 64
%r200 = getelementptr i64, i64* %r2, i32 3
%r201 = trunc i960 %r198 to i64
store i64 %r201, i64* %r200
%r202 = lshr i960 %r198, 64
%r204 = getelementptr i64, i64* %r2, i32 4
%r205 = trunc i960 %r202 to i64
store i64 %r205, i64* %r204
%r206 = lshr i960 %r202, 64
%r208 = getelementptr i64, i64* %r2, i32 5
%r209 = trunc i960 %r206 to i64
store i64 %r209, i64* %r208
%r210 = lshr i960 %r206, 64
%r212 = getelementptr i64, i64* %r2, i32 6
%r213 = trunc i960 %r210 to i64
store i64 %r213, i64* %r212
%r214 = lshr i960 %r210, 64
%r216 = getelementptr i64, i64* %r2, i32 7
%r217 = trunc i960 %r214 to i64
store i64 %r217, i64* %r216
%r218 = lshr i960 %r214, 64
%r220 = getelementptr i64, i64* %r2, i32 8
%r221 = trunc i960 %r218 to i64
store i64 %r221, i64* %r220
%r222 = lshr i960 %r218, 64
%r224 = getelementptr i64, i64* %r2, i32 9
%r225 = trunc i960 %r222 to i64
store i64 %r225, i64* %r224
%r226 = lshr i960 %r222, 64
%r228 = getelementptr i64, i64* %r2, i32 10
%r229 = trunc i960 %r226 to i64
store i64 %r229, i64* %r228
%r230 = lshr i960 %r226, 64
%r232 = getelementptr i64, i64* %r2, i32 11
%r233 = trunc i960 %r230 to i64
store i64 %r233, i64* %r232
%r234 = lshr i960 %r230, 64
%r236 = getelementptr i64, i64* %r2, i32 12
%r237 = trunc i960 %r234 to i64
store i64 %r237, i64* %r236
%r238 = lshr i960 %r234, 64
%r240 = getelementptr i64, i64* %r2, i32 13
%r241 = trunc i960 %r238 to i64
store i64 %r241, i64* %r240
%r242 = lshr i960 %r238, 64
%r244 = getelementptr i64, i64* %r2, i32 14
%r245 = trunc i960 %r242 to i64
store i64 %r245, i64* %r244
%r246 = lshr i1024 %r185, 960
%r247 = trunc i1024 %r246 to i64
ret i64 %r247
}
define void @mclb_mul15(i64* noalias  %r1, i64* noalias  %r2, i64* noalias  %r3)
{
%r4 = load i64, i64* %r3
%r5 = call i1024 @mulUnit_inner960(i64* %r2, i64 %r4)
%r6 = trunc i1024 %r5 to i64
store i64 %r6, i64* %r1
%r7 = lshr i1024 %r5, 64
%r9 = getelementptr i64, i64* %r3, i32 1
%r10 = load i64, i64* %r9
%r11 = call i1024 @mulUnit_inner960(i64* %r2, i64 %r10)
%r12 = add i1024 %r7, %r11
%r13 = trunc i1024 %r12 to i64
%r15 = getelementptr i64, i64* %r1, i32 1
store i64 %r13, i64* %r15
%r16 = lshr i1024 %r12, 64
%r18 = getelementptr i64, i64* %r3, i32 2
%r19 = load i64, i64* %r18
%r20 = call i1024 @mulUnit_inner960(i64* %r2, i64 %r19)
%r21 = add i1024 %r16, %r20
%r22 = trunc i1024 %r21 to i64
%r24 = getelementptr i64, i64* %r1, i32 2
store i64 %r22, i64* %r24
%r25 = lshr i1024 %r21, 64
%r27 = getelementptr i64, i64* %r3, i32 3
%r28 = load i64, i64* %r27
%r29 = call i1024 @mulUnit_inner960(i64* %r2, i64 %r28)
%r30 = add i1024 %r25, %r29
%r31 = trunc i1024 %r30 to i64
%r33 = getelementptr i64, i64* %r1, i32 3
store i64 %r31, i64* %r33
%r34 = lshr i1024 %r30, 64
%r36 = getelementptr i64, i64* %r3, i32 4
%r37 = load i64, i64* %r36
%r38 = call i1024 @mulUnit_inner960(i64* %r2, i64 %r37)
%r39 = add i1024 %r34, %r38
%r40 = trunc i1024 %r39 to i64
%r42 = getelementptr i64, i64* %r1, i32 4
store i64 %r40, i64* %r42
%r43 = lshr i1024 %r39, 64
%r45 = getelementptr i64, i64* %r3, i32 5
%r46 = load i64, i64* %r45
%r47 = call i1024 @mulUnit_inner960(i64* %r2, i64 %r46)
%r48 = add i1024 %r43, %r47
%r49 = trunc i1024 %r48 to i64
%r51 = getelementptr i64, i64* %r1, i32 5
store i64 %r49, i64* %r51
%r52 = lshr i1024 %r48, 64
%r54 = getelementptr i64, i64* %r3, i32 6
%r55 = load i64, i64* %r54
%r56 = call i1024 @mulUnit_inner960(i64* %r2, i64 %r55)
%r57 = add i1024 %r52, %r56
%r58 = trunc i1024 %r57 to i64
%r60 = getelementptr i64, i64* %r1, i32 6
store i64 %r58, i64* %r60
%r61 = lshr i1024 %r57, 64
%r63 = getelementptr i64, i64* %r3, i32 7
%r64 = load i64, i64* %r63
%r65 = call i1024 @mulUnit_inner960(i64* %r2, i64 %r64)
%r66 = add i1024 %r61, %r65
%r67 = trunc i1024 %r66 to i64
%r69 = getelementptr i64, i64* %r1, i32 7
store i64 %r67, i64* %r69
%r70 = lshr i1024 %r66, 64
%r72 = getelementptr i64, i64* %r3, i32 8
%r73 = load i64, i64* %r72
%r74 = call i1024 @mulUnit_inner960(i64* %r2, i64 %r73)
%r75 = add i1024 %r70, %r74
%r76 = trunc i1024 %r75 to i64
%r78 = getelementptr i64, i64* %r1, i32 8
store i64 %r76, i64* %r78
%r79 = lshr i1024 %r75, 64
%r81 = getelementptr i64, i64* %r3, i32 9
%r82 = load i64, i64* %r81
%r83 = call i1024 @mulUnit_inner960(i64* %r2, i64 %r82)
%r84 = add i1024 %r79, %r83
%r85 = trunc i1024 %r84 to i64
%r87 = getelementptr i64, i64* %r1, i32 9
store i64 %r85, i64* %r87
%r88 = lshr i1024 %r84, 64
%r90 = getelementptr i64, i64* %r3, i32 10
%r91 = load i64, i64* %r90
%r92 = call i1024 @mulUnit_inner960(i64* %r2, i64 %r91)
%r93 = add i1024 %r88, %r92
%r94 = trunc i1024 %r93 to i64
%r96 = getelementptr i64, i64* %r1, i32 10
store i64 %r94, i64* %r96
%r97 = lshr i1024 %r93, 64
%r99 = getelementptr i64, i64* %r3, i32 11
%r100 = load i64, i64* %r99
%r101 = call i1024 @mulUnit_inner960(i64* %r2, i64 %r100)
%r102 = add i1024 %r97, %r101
%r103 = trunc i1024 %r102 to i64
%r105 = getelementptr i64, i64* %r1, i32 11
store i64 %r103, i64* %r105
%r106 = lshr i1024 %r102, 64
%r108 = getelementptr i64, i64* %r3, i32 12
%r109 = load i64, i64* %r108
%r110 = call i1024 @mulUnit_inner960(i64* %r2, i64 %r109)
%r111 = add i1024 %r106, %r110
%r112 = trunc i1024 %r111 to i64
%r114 = getelementptr i64, i64* %r1, i32 12
store i64 %r112, i64* %r114
%r115 = lshr i1024 %r111, 64
%r117 = getelementptr i64, i64* %r3, i32 13
%r118 = load i64, i64* %r117
%r119 = call i1024 @mulUnit_inner960(i64* %r2, i64 %r118)
%r120 = add i1024 %r115, %r119
%r121 = trunc i1024 %r120 to i64
%r123 = getelementptr i64, i64* %r1, i32 13
store i64 %r121, i64* %r123
%r124 = lshr i1024 %r120, 64
%r126 = getelementptr i64, i64* %r3, i32 14
%r127 = load i64, i64* %r126
%r128 = call i1024 @mulUnit_inner960(i64* %r2, i64 %r127)
%r129 = add i1024 %r124, %r128
%r131 = getelementptr i64, i64* %r1, i32 14
%r133 = getelementptr i64, i64* %r131, i32 0
%r134 = trunc i1024 %r129 to i64
store i64 %r134, i64* %r133
%r135 = lshr i1024 %r129, 64
%r137 = getelementptr i64, i64* %r131, i32 1
%r138 = trunc i1024 %r135 to i64
store i64 %r138, i64* %r137
%r139 = lshr i1024 %r135, 64
%r141 = getelementptr i64, i64* %r131, i32 2
%r142 = trunc i1024 %r139 to i64
store i64 %r142, i64* %r141
%r143 = lshr i1024 %r139, 64
%r145 = getelementptr i64, i64* %r131, i32 3
%r146 = trunc i1024 %r143 to i64
store i64 %r146, i64* %r145
%r147 = lshr i1024 %r143, 64
%r149 = getelementptr i64, i64* %r131, i32 4
%r150 = trunc i1024 %r147 to i64
store i64 %r150, i64* %r149
%r151 = lshr i1024 %r147, 64
%r153 = getelementptr i64, i64* %r131, i32 5
%r154 = trunc i1024 %r151 to i64
store i64 %r154, i64* %r153
%r155 = lshr i1024 %r151, 64
%r157 = getelementptr i64, i64* %r131, i32 6
%r158 = trunc i1024 %r155 to i64
store i64 %r158, i64* %r157
%r159 = lshr i1024 %r155, 64
%r161 = getelementptr i64, i64* %r131, i32 7
%r162 = trunc i1024 %r159 to i64
store i64 %r162, i64* %r161
%r163 = lshr i1024 %r159, 64
%r165 = getelementptr i64, i64* %r131, i32 8
%r166 = trunc i1024 %r163 to i64
store i64 %r166, i64* %r165
%r167 = lshr i1024 %r163, 64
%r169 = getelementptr i64, i64* %r131, i32 9
%r170 = trunc i1024 %r167 to i64
store i64 %r170, i64* %r169
%r171 = lshr i1024 %r167, 64
%r173 = getelementptr i64, i64* %r131, i32 10
%r174 = trunc i1024 %r171 to i64
store i64 %r174, i64* %r173
%r175 = lshr i1024 %r171, 64
%r177 = getelementptr i64, i64* %r131, i32 11
%r178 = trunc i1024 %r175 to i64
store i64 %r178, i64* %r177
%r179 = lshr i1024 %r175, 64
%r181 = getelementptr i64, i64* %r131, i32 12
%r182 = trunc i1024 %r179 to i64
store i64 %r182, i64* %r181
%r183 = lshr i1024 %r179, 64
%r185 = getelementptr i64, i64* %r131, i32 13
%r186 = trunc i1024 %r183 to i64
store i64 %r186, i64* %r185
%r187 = lshr i1024 %r183, 64
%r189 = getelementptr i64, i64* %r131, i32 14
%r190 = trunc i1024 %r187 to i64
store i64 %r190, i64* %r189
%r191 = lshr i1024 %r187, 64
%r193 = getelementptr i64, i64* %r131, i32 15
%r194 = trunc i1024 %r191 to i64
store i64 %r194, i64* %r193
ret void
}
define void @mclb_sqr15(i64* noalias  %r1, i64* noalias  %r2)
{
%r3 = load i64, i64* %r2
%r4 = call i128 @mul64x64L(i64 %r3, i64 %r3)
%r5 = trunc i128 %r4 to i64
store i64 %r5, i64* %r1
%r6 = lshr i128 %r4, 64
%r8 = getelementptr i64, i64* %r2, i32 14
%r9 = load i64, i64* %r8
%r10 = call i128 @mul64x64L(i64 %r3, i64 %r9)
%r11 = load i64, i64* %r2
%r13 = getelementptr i64, i64* %r2, i32 13
%r14 = load i64, i64* %r13
%r15 = call i128 @mul64x64L(i64 %r11, i64 %r14)
%r17 = getelementptr i64, i64* %r2, i32 1
%r18 = load i64, i64* %r17
%r20 = getelementptr i64, i64* %r2, i32 14
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
%r32 = getelementptr i64, i64* %r2, i32 12
%r33 = load i64, i64* %r32
%r34 = call i128 @mul64x64L(i64 %r30, i64 %r33)
%r36 = getelementptr i64, i64* %r2, i32 1
%r37 = load i64, i64* %r36
%r39 = getelementptr i64, i64* %r2, i32 13
%r40 = load i64, i64* %r39
%r41 = call i128 @mul64x64L(i64 %r37, i64 %r40)
%r42 = zext i128 %r34 to i256
%r43 = zext i128 %r41 to i256
%r44 = shl i256 %r43, 128
%r45 = or i256 %r42, %r44
%r47 = getelementptr i64, i64* %r2, i32 2
%r48 = load i64, i64* %r47
%r50 = getelementptr i64, i64* %r2, i32 14
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
%r62 = getelementptr i64, i64* %r2, i32 11
%r63 = load i64, i64* %r62
%r64 = call i128 @mul64x64L(i64 %r60, i64 %r63)
%r66 = getelementptr i64, i64* %r2, i32 1
%r67 = load i64, i64* %r66
%r69 = getelementptr i64, i64* %r2, i32 12
%r70 = load i64, i64* %r69
%r71 = call i128 @mul64x64L(i64 %r67, i64 %r70)
%r72 = zext i128 %r64 to i256
%r73 = zext i128 %r71 to i256
%r74 = shl i256 %r73, 128
%r75 = or i256 %r72, %r74
%r77 = getelementptr i64, i64* %r2, i32 2
%r78 = load i64, i64* %r77
%r80 = getelementptr i64, i64* %r2, i32 13
%r81 = load i64, i64* %r80
%r82 = call i128 @mul64x64L(i64 %r78, i64 %r81)
%r83 = zext i256 %r75 to i384
%r84 = zext i128 %r82 to i384
%r85 = shl i384 %r84, 256
%r86 = or i384 %r83, %r85
%r88 = getelementptr i64, i64* %r2, i32 3
%r89 = load i64, i64* %r88
%r91 = getelementptr i64, i64* %r2, i32 14
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
%r103 = getelementptr i64, i64* %r2, i32 10
%r104 = load i64, i64* %r103
%r105 = call i128 @mul64x64L(i64 %r101, i64 %r104)
%r107 = getelementptr i64, i64* %r2, i32 1
%r108 = load i64, i64* %r107
%r110 = getelementptr i64, i64* %r2, i32 11
%r111 = load i64, i64* %r110
%r112 = call i128 @mul64x64L(i64 %r108, i64 %r111)
%r113 = zext i128 %r105 to i256
%r114 = zext i128 %r112 to i256
%r115 = shl i256 %r114, 128
%r116 = or i256 %r113, %r115
%r118 = getelementptr i64, i64* %r2, i32 2
%r119 = load i64, i64* %r118
%r121 = getelementptr i64, i64* %r2, i32 12
%r122 = load i64, i64* %r121
%r123 = call i128 @mul64x64L(i64 %r119, i64 %r122)
%r124 = zext i256 %r116 to i384
%r125 = zext i128 %r123 to i384
%r126 = shl i384 %r125, 256
%r127 = or i384 %r124, %r126
%r129 = getelementptr i64, i64* %r2, i32 3
%r130 = load i64, i64* %r129
%r132 = getelementptr i64, i64* %r2, i32 13
%r133 = load i64, i64* %r132
%r134 = call i128 @mul64x64L(i64 %r130, i64 %r133)
%r135 = zext i384 %r127 to i512
%r136 = zext i128 %r134 to i512
%r137 = shl i512 %r136, 384
%r138 = or i512 %r135, %r137
%r140 = getelementptr i64, i64* %r2, i32 4
%r141 = load i64, i64* %r140
%r143 = getelementptr i64, i64* %r2, i32 14
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
%r155 = getelementptr i64, i64* %r2, i32 9
%r156 = load i64, i64* %r155
%r157 = call i128 @mul64x64L(i64 %r153, i64 %r156)
%r159 = getelementptr i64, i64* %r2, i32 1
%r160 = load i64, i64* %r159
%r162 = getelementptr i64, i64* %r2, i32 10
%r163 = load i64, i64* %r162
%r164 = call i128 @mul64x64L(i64 %r160, i64 %r163)
%r165 = zext i128 %r157 to i256
%r166 = zext i128 %r164 to i256
%r167 = shl i256 %r166, 128
%r168 = or i256 %r165, %r167
%r170 = getelementptr i64, i64* %r2, i32 2
%r171 = load i64, i64* %r170
%r173 = getelementptr i64, i64* %r2, i32 11
%r174 = load i64, i64* %r173
%r175 = call i128 @mul64x64L(i64 %r171, i64 %r174)
%r176 = zext i256 %r168 to i384
%r177 = zext i128 %r175 to i384
%r178 = shl i384 %r177, 256
%r179 = or i384 %r176, %r178
%r181 = getelementptr i64, i64* %r2, i32 3
%r182 = load i64, i64* %r181
%r184 = getelementptr i64, i64* %r2, i32 12
%r185 = load i64, i64* %r184
%r186 = call i128 @mul64x64L(i64 %r182, i64 %r185)
%r187 = zext i384 %r179 to i512
%r188 = zext i128 %r186 to i512
%r189 = shl i512 %r188, 384
%r190 = or i512 %r187, %r189
%r192 = getelementptr i64, i64* %r2, i32 4
%r193 = load i64, i64* %r192
%r195 = getelementptr i64, i64* %r2, i32 13
%r196 = load i64, i64* %r195
%r197 = call i128 @mul64x64L(i64 %r193, i64 %r196)
%r198 = zext i512 %r190 to i640
%r199 = zext i128 %r197 to i640
%r200 = shl i640 %r199, 512
%r201 = or i640 %r198, %r200
%r203 = getelementptr i64, i64* %r2, i32 5
%r204 = load i64, i64* %r203
%r206 = getelementptr i64, i64* %r2, i32 14
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
%r218 = getelementptr i64, i64* %r2, i32 8
%r219 = load i64, i64* %r218
%r220 = call i128 @mul64x64L(i64 %r216, i64 %r219)
%r222 = getelementptr i64, i64* %r2, i32 1
%r223 = load i64, i64* %r222
%r225 = getelementptr i64, i64* %r2, i32 9
%r226 = load i64, i64* %r225
%r227 = call i128 @mul64x64L(i64 %r223, i64 %r226)
%r228 = zext i128 %r220 to i256
%r229 = zext i128 %r227 to i256
%r230 = shl i256 %r229, 128
%r231 = or i256 %r228, %r230
%r233 = getelementptr i64, i64* %r2, i32 2
%r234 = load i64, i64* %r233
%r236 = getelementptr i64, i64* %r2, i32 10
%r237 = load i64, i64* %r236
%r238 = call i128 @mul64x64L(i64 %r234, i64 %r237)
%r239 = zext i256 %r231 to i384
%r240 = zext i128 %r238 to i384
%r241 = shl i384 %r240, 256
%r242 = or i384 %r239, %r241
%r244 = getelementptr i64, i64* %r2, i32 3
%r245 = load i64, i64* %r244
%r247 = getelementptr i64, i64* %r2, i32 11
%r248 = load i64, i64* %r247
%r249 = call i128 @mul64x64L(i64 %r245, i64 %r248)
%r250 = zext i384 %r242 to i512
%r251 = zext i128 %r249 to i512
%r252 = shl i512 %r251, 384
%r253 = or i512 %r250, %r252
%r255 = getelementptr i64, i64* %r2, i32 4
%r256 = load i64, i64* %r255
%r258 = getelementptr i64, i64* %r2, i32 12
%r259 = load i64, i64* %r258
%r260 = call i128 @mul64x64L(i64 %r256, i64 %r259)
%r261 = zext i512 %r253 to i640
%r262 = zext i128 %r260 to i640
%r263 = shl i640 %r262, 512
%r264 = or i640 %r261, %r263
%r266 = getelementptr i64, i64* %r2, i32 5
%r267 = load i64, i64* %r266
%r269 = getelementptr i64, i64* %r2, i32 13
%r270 = load i64, i64* %r269
%r271 = call i128 @mul64x64L(i64 %r267, i64 %r270)
%r272 = zext i640 %r264 to i768
%r273 = zext i128 %r271 to i768
%r274 = shl i768 %r273, 640
%r275 = or i768 %r272, %r274
%r277 = getelementptr i64, i64* %r2, i32 6
%r278 = load i64, i64* %r277
%r280 = getelementptr i64, i64* %r2, i32 14
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
%r292 = getelementptr i64, i64* %r2, i32 7
%r293 = load i64, i64* %r292
%r294 = call i128 @mul64x64L(i64 %r290, i64 %r293)
%r296 = getelementptr i64, i64* %r2, i32 1
%r297 = load i64, i64* %r296
%r299 = getelementptr i64, i64* %r2, i32 8
%r300 = load i64, i64* %r299
%r301 = call i128 @mul64x64L(i64 %r297, i64 %r300)
%r302 = zext i128 %r294 to i256
%r303 = zext i128 %r301 to i256
%r304 = shl i256 %r303, 128
%r305 = or i256 %r302, %r304
%r307 = getelementptr i64, i64* %r2, i32 2
%r308 = load i64, i64* %r307
%r310 = getelementptr i64, i64* %r2, i32 9
%r311 = load i64, i64* %r310
%r312 = call i128 @mul64x64L(i64 %r308, i64 %r311)
%r313 = zext i256 %r305 to i384
%r314 = zext i128 %r312 to i384
%r315 = shl i384 %r314, 256
%r316 = or i384 %r313, %r315
%r318 = getelementptr i64, i64* %r2, i32 3
%r319 = load i64, i64* %r318
%r321 = getelementptr i64, i64* %r2, i32 10
%r322 = load i64, i64* %r321
%r323 = call i128 @mul64x64L(i64 %r319, i64 %r322)
%r324 = zext i384 %r316 to i512
%r325 = zext i128 %r323 to i512
%r326 = shl i512 %r325, 384
%r327 = or i512 %r324, %r326
%r329 = getelementptr i64, i64* %r2, i32 4
%r330 = load i64, i64* %r329
%r332 = getelementptr i64, i64* %r2, i32 11
%r333 = load i64, i64* %r332
%r334 = call i128 @mul64x64L(i64 %r330, i64 %r333)
%r335 = zext i512 %r327 to i640
%r336 = zext i128 %r334 to i640
%r337 = shl i640 %r336, 512
%r338 = or i640 %r335, %r337
%r340 = getelementptr i64, i64* %r2, i32 5
%r341 = load i64, i64* %r340
%r343 = getelementptr i64, i64* %r2, i32 12
%r344 = load i64, i64* %r343
%r345 = call i128 @mul64x64L(i64 %r341, i64 %r344)
%r346 = zext i640 %r338 to i768
%r347 = zext i128 %r345 to i768
%r348 = shl i768 %r347, 640
%r349 = or i768 %r346, %r348
%r351 = getelementptr i64, i64* %r2, i32 6
%r352 = load i64, i64* %r351
%r354 = getelementptr i64, i64* %r2, i32 13
%r355 = load i64, i64* %r354
%r356 = call i128 @mul64x64L(i64 %r352, i64 %r355)
%r357 = zext i768 %r349 to i896
%r358 = zext i128 %r356 to i896
%r359 = shl i896 %r358, 768
%r360 = or i896 %r357, %r359
%r362 = getelementptr i64, i64* %r2, i32 7
%r363 = load i64, i64* %r362
%r365 = getelementptr i64, i64* %r2, i32 14
%r366 = load i64, i64* %r365
%r367 = call i128 @mul64x64L(i64 %r363, i64 %r366)
%r368 = zext i896 %r360 to i1024
%r369 = zext i128 %r367 to i1024
%r370 = shl i1024 %r369, 896
%r371 = or i1024 %r368, %r370
%r372 = zext i896 %r289 to i1024
%r373 = shl i1024 %r372, 64
%r374 = add i1024 %r373, %r371
%r375 = load i64, i64* %r2
%r377 = getelementptr i64, i64* %r2, i32 6
%r378 = load i64, i64* %r377
%r379 = call i128 @mul64x64L(i64 %r375, i64 %r378)
%r381 = getelementptr i64, i64* %r2, i32 1
%r382 = load i64, i64* %r381
%r384 = getelementptr i64, i64* %r2, i32 7
%r385 = load i64, i64* %r384
%r386 = call i128 @mul64x64L(i64 %r382, i64 %r385)
%r387 = zext i128 %r379 to i256
%r388 = zext i128 %r386 to i256
%r389 = shl i256 %r388, 128
%r390 = or i256 %r387, %r389
%r392 = getelementptr i64, i64* %r2, i32 2
%r393 = load i64, i64* %r392
%r395 = getelementptr i64, i64* %r2, i32 8
%r396 = load i64, i64* %r395
%r397 = call i128 @mul64x64L(i64 %r393, i64 %r396)
%r398 = zext i256 %r390 to i384
%r399 = zext i128 %r397 to i384
%r400 = shl i384 %r399, 256
%r401 = or i384 %r398, %r400
%r403 = getelementptr i64, i64* %r2, i32 3
%r404 = load i64, i64* %r403
%r406 = getelementptr i64, i64* %r2, i32 9
%r407 = load i64, i64* %r406
%r408 = call i128 @mul64x64L(i64 %r404, i64 %r407)
%r409 = zext i384 %r401 to i512
%r410 = zext i128 %r408 to i512
%r411 = shl i512 %r410, 384
%r412 = or i512 %r409, %r411
%r414 = getelementptr i64, i64* %r2, i32 4
%r415 = load i64, i64* %r414
%r417 = getelementptr i64, i64* %r2, i32 10
%r418 = load i64, i64* %r417
%r419 = call i128 @mul64x64L(i64 %r415, i64 %r418)
%r420 = zext i512 %r412 to i640
%r421 = zext i128 %r419 to i640
%r422 = shl i640 %r421, 512
%r423 = or i640 %r420, %r422
%r425 = getelementptr i64, i64* %r2, i32 5
%r426 = load i64, i64* %r425
%r428 = getelementptr i64, i64* %r2, i32 11
%r429 = load i64, i64* %r428
%r430 = call i128 @mul64x64L(i64 %r426, i64 %r429)
%r431 = zext i640 %r423 to i768
%r432 = zext i128 %r430 to i768
%r433 = shl i768 %r432, 640
%r434 = or i768 %r431, %r433
%r436 = getelementptr i64, i64* %r2, i32 6
%r437 = load i64, i64* %r436
%r439 = getelementptr i64, i64* %r2, i32 12
%r440 = load i64, i64* %r439
%r441 = call i128 @mul64x64L(i64 %r437, i64 %r440)
%r442 = zext i768 %r434 to i896
%r443 = zext i128 %r441 to i896
%r444 = shl i896 %r443, 768
%r445 = or i896 %r442, %r444
%r447 = getelementptr i64, i64* %r2, i32 7
%r448 = load i64, i64* %r447
%r450 = getelementptr i64, i64* %r2, i32 13
%r451 = load i64, i64* %r450
%r452 = call i128 @mul64x64L(i64 %r448, i64 %r451)
%r453 = zext i896 %r445 to i1024
%r454 = zext i128 %r452 to i1024
%r455 = shl i1024 %r454, 896
%r456 = or i1024 %r453, %r455
%r458 = getelementptr i64, i64* %r2, i32 8
%r459 = load i64, i64* %r458
%r461 = getelementptr i64, i64* %r2, i32 14
%r462 = load i64, i64* %r461
%r463 = call i128 @mul64x64L(i64 %r459, i64 %r462)
%r464 = zext i1024 %r456 to i1152
%r465 = zext i128 %r463 to i1152
%r466 = shl i1152 %r465, 1024
%r467 = or i1152 %r464, %r466
%r468 = zext i1024 %r374 to i1152
%r469 = shl i1152 %r468, 64
%r470 = add i1152 %r469, %r467
%r471 = load i64, i64* %r2
%r473 = getelementptr i64, i64* %r2, i32 5
%r474 = load i64, i64* %r473
%r475 = call i128 @mul64x64L(i64 %r471, i64 %r474)
%r477 = getelementptr i64, i64* %r2, i32 1
%r478 = load i64, i64* %r477
%r480 = getelementptr i64, i64* %r2, i32 6
%r481 = load i64, i64* %r480
%r482 = call i128 @mul64x64L(i64 %r478, i64 %r481)
%r483 = zext i128 %r475 to i256
%r484 = zext i128 %r482 to i256
%r485 = shl i256 %r484, 128
%r486 = or i256 %r483, %r485
%r488 = getelementptr i64, i64* %r2, i32 2
%r489 = load i64, i64* %r488
%r491 = getelementptr i64, i64* %r2, i32 7
%r492 = load i64, i64* %r491
%r493 = call i128 @mul64x64L(i64 %r489, i64 %r492)
%r494 = zext i256 %r486 to i384
%r495 = zext i128 %r493 to i384
%r496 = shl i384 %r495, 256
%r497 = or i384 %r494, %r496
%r499 = getelementptr i64, i64* %r2, i32 3
%r500 = load i64, i64* %r499
%r502 = getelementptr i64, i64* %r2, i32 8
%r503 = load i64, i64* %r502
%r504 = call i128 @mul64x64L(i64 %r500, i64 %r503)
%r505 = zext i384 %r497 to i512
%r506 = zext i128 %r504 to i512
%r507 = shl i512 %r506, 384
%r508 = or i512 %r505, %r507
%r510 = getelementptr i64, i64* %r2, i32 4
%r511 = load i64, i64* %r510
%r513 = getelementptr i64, i64* %r2, i32 9
%r514 = load i64, i64* %r513
%r515 = call i128 @mul64x64L(i64 %r511, i64 %r514)
%r516 = zext i512 %r508 to i640
%r517 = zext i128 %r515 to i640
%r518 = shl i640 %r517, 512
%r519 = or i640 %r516, %r518
%r521 = getelementptr i64, i64* %r2, i32 5
%r522 = load i64, i64* %r521
%r524 = getelementptr i64, i64* %r2, i32 10
%r525 = load i64, i64* %r524
%r526 = call i128 @mul64x64L(i64 %r522, i64 %r525)
%r527 = zext i640 %r519 to i768
%r528 = zext i128 %r526 to i768
%r529 = shl i768 %r528, 640
%r530 = or i768 %r527, %r529
%r532 = getelementptr i64, i64* %r2, i32 6
%r533 = load i64, i64* %r532
%r535 = getelementptr i64, i64* %r2, i32 11
%r536 = load i64, i64* %r535
%r537 = call i128 @mul64x64L(i64 %r533, i64 %r536)
%r538 = zext i768 %r530 to i896
%r539 = zext i128 %r537 to i896
%r540 = shl i896 %r539, 768
%r541 = or i896 %r538, %r540
%r543 = getelementptr i64, i64* %r2, i32 7
%r544 = load i64, i64* %r543
%r546 = getelementptr i64, i64* %r2, i32 12
%r547 = load i64, i64* %r546
%r548 = call i128 @mul64x64L(i64 %r544, i64 %r547)
%r549 = zext i896 %r541 to i1024
%r550 = zext i128 %r548 to i1024
%r551 = shl i1024 %r550, 896
%r552 = or i1024 %r549, %r551
%r554 = getelementptr i64, i64* %r2, i32 8
%r555 = load i64, i64* %r554
%r557 = getelementptr i64, i64* %r2, i32 13
%r558 = load i64, i64* %r557
%r559 = call i128 @mul64x64L(i64 %r555, i64 %r558)
%r560 = zext i1024 %r552 to i1152
%r561 = zext i128 %r559 to i1152
%r562 = shl i1152 %r561, 1024
%r563 = or i1152 %r560, %r562
%r565 = getelementptr i64, i64* %r2, i32 9
%r566 = load i64, i64* %r565
%r568 = getelementptr i64, i64* %r2, i32 14
%r569 = load i64, i64* %r568
%r570 = call i128 @mul64x64L(i64 %r566, i64 %r569)
%r571 = zext i1152 %r563 to i1280
%r572 = zext i128 %r570 to i1280
%r573 = shl i1280 %r572, 1152
%r574 = or i1280 %r571, %r573
%r575 = zext i1152 %r470 to i1280
%r576 = shl i1280 %r575, 64
%r577 = add i1280 %r576, %r574
%r578 = load i64, i64* %r2
%r580 = getelementptr i64, i64* %r2, i32 4
%r581 = load i64, i64* %r580
%r582 = call i128 @mul64x64L(i64 %r578, i64 %r581)
%r584 = getelementptr i64, i64* %r2, i32 1
%r585 = load i64, i64* %r584
%r587 = getelementptr i64, i64* %r2, i32 5
%r588 = load i64, i64* %r587
%r589 = call i128 @mul64x64L(i64 %r585, i64 %r588)
%r590 = zext i128 %r582 to i256
%r591 = zext i128 %r589 to i256
%r592 = shl i256 %r591, 128
%r593 = or i256 %r590, %r592
%r595 = getelementptr i64, i64* %r2, i32 2
%r596 = load i64, i64* %r595
%r598 = getelementptr i64, i64* %r2, i32 6
%r599 = load i64, i64* %r598
%r600 = call i128 @mul64x64L(i64 %r596, i64 %r599)
%r601 = zext i256 %r593 to i384
%r602 = zext i128 %r600 to i384
%r603 = shl i384 %r602, 256
%r604 = or i384 %r601, %r603
%r606 = getelementptr i64, i64* %r2, i32 3
%r607 = load i64, i64* %r606
%r609 = getelementptr i64, i64* %r2, i32 7
%r610 = load i64, i64* %r609
%r611 = call i128 @mul64x64L(i64 %r607, i64 %r610)
%r612 = zext i384 %r604 to i512
%r613 = zext i128 %r611 to i512
%r614 = shl i512 %r613, 384
%r615 = or i512 %r612, %r614
%r617 = getelementptr i64, i64* %r2, i32 4
%r618 = load i64, i64* %r617
%r620 = getelementptr i64, i64* %r2, i32 8
%r621 = load i64, i64* %r620
%r622 = call i128 @mul64x64L(i64 %r618, i64 %r621)
%r623 = zext i512 %r615 to i640
%r624 = zext i128 %r622 to i640
%r625 = shl i640 %r624, 512
%r626 = or i640 %r623, %r625
%r628 = getelementptr i64, i64* %r2, i32 5
%r629 = load i64, i64* %r628
%r631 = getelementptr i64, i64* %r2, i32 9
%r632 = load i64, i64* %r631
%r633 = call i128 @mul64x64L(i64 %r629, i64 %r632)
%r634 = zext i640 %r626 to i768
%r635 = zext i128 %r633 to i768
%r636 = shl i768 %r635, 640
%r637 = or i768 %r634, %r636
%r639 = getelementptr i64, i64* %r2, i32 6
%r640 = load i64, i64* %r639
%r642 = getelementptr i64, i64* %r2, i32 10
%r643 = load i64, i64* %r642
%r644 = call i128 @mul64x64L(i64 %r640, i64 %r643)
%r645 = zext i768 %r637 to i896
%r646 = zext i128 %r644 to i896
%r647 = shl i896 %r646, 768
%r648 = or i896 %r645, %r647
%r650 = getelementptr i64, i64* %r2, i32 7
%r651 = load i64, i64* %r650
%r653 = getelementptr i64, i64* %r2, i32 11
%r654 = load i64, i64* %r653
%r655 = call i128 @mul64x64L(i64 %r651, i64 %r654)
%r656 = zext i896 %r648 to i1024
%r657 = zext i128 %r655 to i1024
%r658 = shl i1024 %r657, 896
%r659 = or i1024 %r656, %r658
%r661 = getelementptr i64, i64* %r2, i32 8
%r662 = load i64, i64* %r661
%r664 = getelementptr i64, i64* %r2, i32 12
%r665 = load i64, i64* %r664
%r666 = call i128 @mul64x64L(i64 %r662, i64 %r665)
%r667 = zext i1024 %r659 to i1152
%r668 = zext i128 %r666 to i1152
%r669 = shl i1152 %r668, 1024
%r670 = or i1152 %r667, %r669
%r672 = getelementptr i64, i64* %r2, i32 9
%r673 = load i64, i64* %r672
%r675 = getelementptr i64, i64* %r2, i32 13
%r676 = load i64, i64* %r675
%r677 = call i128 @mul64x64L(i64 %r673, i64 %r676)
%r678 = zext i1152 %r670 to i1280
%r679 = zext i128 %r677 to i1280
%r680 = shl i1280 %r679, 1152
%r681 = or i1280 %r678, %r680
%r683 = getelementptr i64, i64* %r2, i32 10
%r684 = load i64, i64* %r683
%r686 = getelementptr i64, i64* %r2, i32 14
%r687 = load i64, i64* %r686
%r688 = call i128 @mul64x64L(i64 %r684, i64 %r687)
%r689 = zext i1280 %r681 to i1408
%r690 = zext i128 %r688 to i1408
%r691 = shl i1408 %r690, 1280
%r692 = or i1408 %r689, %r691
%r693 = zext i1280 %r577 to i1408
%r694 = shl i1408 %r693, 64
%r695 = add i1408 %r694, %r692
%r696 = load i64, i64* %r2
%r698 = getelementptr i64, i64* %r2, i32 3
%r699 = load i64, i64* %r698
%r700 = call i128 @mul64x64L(i64 %r696, i64 %r699)
%r702 = getelementptr i64, i64* %r2, i32 1
%r703 = load i64, i64* %r702
%r705 = getelementptr i64, i64* %r2, i32 4
%r706 = load i64, i64* %r705
%r707 = call i128 @mul64x64L(i64 %r703, i64 %r706)
%r708 = zext i128 %r700 to i256
%r709 = zext i128 %r707 to i256
%r710 = shl i256 %r709, 128
%r711 = or i256 %r708, %r710
%r713 = getelementptr i64, i64* %r2, i32 2
%r714 = load i64, i64* %r713
%r716 = getelementptr i64, i64* %r2, i32 5
%r717 = load i64, i64* %r716
%r718 = call i128 @mul64x64L(i64 %r714, i64 %r717)
%r719 = zext i256 %r711 to i384
%r720 = zext i128 %r718 to i384
%r721 = shl i384 %r720, 256
%r722 = or i384 %r719, %r721
%r724 = getelementptr i64, i64* %r2, i32 3
%r725 = load i64, i64* %r724
%r727 = getelementptr i64, i64* %r2, i32 6
%r728 = load i64, i64* %r727
%r729 = call i128 @mul64x64L(i64 %r725, i64 %r728)
%r730 = zext i384 %r722 to i512
%r731 = zext i128 %r729 to i512
%r732 = shl i512 %r731, 384
%r733 = or i512 %r730, %r732
%r735 = getelementptr i64, i64* %r2, i32 4
%r736 = load i64, i64* %r735
%r738 = getelementptr i64, i64* %r2, i32 7
%r739 = load i64, i64* %r738
%r740 = call i128 @mul64x64L(i64 %r736, i64 %r739)
%r741 = zext i512 %r733 to i640
%r742 = zext i128 %r740 to i640
%r743 = shl i640 %r742, 512
%r744 = or i640 %r741, %r743
%r746 = getelementptr i64, i64* %r2, i32 5
%r747 = load i64, i64* %r746
%r749 = getelementptr i64, i64* %r2, i32 8
%r750 = load i64, i64* %r749
%r751 = call i128 @mul64x64L(i64 %r747, i64 %r750)
%r752 = zext i640 %r744 to i768
%r753 = zext i128 %r751 to i768
%r754 = shl i768 %r753, 640
%r755 = or i768 %r752, %r754
%r757 = getelementptr i64, i64* %r2, i32 6
%r758 = load i64, i64* %r757
%r760 = getelementptr i64, i64* %r2, i32 9
%r761 = load i64, i64* %r760
%r762 = call i128 @mul64x64L(i64 %r758, i64 %r761)
%r763 = zext i768 %r755 to i896
%r764 = zext i128 %r762 to i896
%r765 = shl i896 %r764, 768
%r766 = or i896 %r763, %r765
%r768 = getelementptr i64, i64* %r2, i32 7
%r769 = load i64, i64* %r768
%r771 = getelementptr i64, i64* %r2, i32 10
%r772 = load i64, i64* %r771
%r773 = call i128 @mul64x64L(i64 %r769, i64 %r772)
%r774 = zext i896 %r766 to i1024
%r775 = zext i128 %r773 to i1024
%r776 = shl i1024 %r775, 896
%r777 = or i1024 %r774, %r776
%r779 = getelementptr i64, i64* %r2, i32 8
%r780 = load i64, i64* %r779
%r782 = getelementptr i64, i64* %r2, i32 11
%r783 = load i64, i64* %r782
%r784 = call i128 @mul64x64L(i64 %r780, i64 %r783)
%r785 = zext i1024 %r777 to i1152
%r786 = zext i128 %r784 to i1152
%r787 = shl i1152 %r786, 1024
%r788 = or i1152 %r785, %r787
%r790 = getelementptr i64, i64* %r2, i32 9
%r791 = load i64, i64* %r790
%r793 = getelementptr i64, i64* %r2, i32 12
%r794 = load i64, i64* %r793
%r795 = call i128 @mul64x64L(i64 %r791, i64 %r794)
%r796 = zext i1152 %r788 to i1280
%r797 = zext i128 %r795 to i1280
%r798 = shl i1280 %r797, 1152
%r799 = or i1280 %r796, %r798
%r801 = getelementptr i64, i64* %r2, i32 10
%r802 = load i64, i64* %r801
%r804 = getelementptr i64, i64* %r2, i32 13
%r805 = load i64, i64* %r804
%r806 = call i128 @mul64x64L(i64 %r802, i64 %r805)
%r807 = zext i1280 %r799 to i1408
%r808 = zext i128 %r806 to i1408
%r809 = shl i1408 %r808, 1280
%r810 = or i1408 %r807, %r809
%r812 = getelementptr i64, i64* %r2, i32 11
%r813 = load i64, i64* %r812
%r815 = getelementptr i64, i64* %r2, i32 14
%r816 = load i64, i64* %r815
%r817 = call i128 @mul64x64L(i64 %r813, i64 %r816)
%r818 = zext i1408 %r810 to i1536
%r819 = zext i128 %r817 to i1536
%r820 = shl i1536 %r819, 1408
%r821 = or i1536 %r818, %r820
%r822 = zext i1408 %r695 to i1536
%r823 = shl i1536 %r822, 64
%r824 = add i1536 %r823, %r821
%r825 = load i64, i64* %r2
%r827 = getelementptr i64, i64* %r2, i32 2
%r828 = load i64, i64* %r827
%r829 = call i128 @mul64x64L(i64 %r825, i64 %r828)
%r831 = getelementptr i64, i64* %r2, i32 1
%r832 = load i64, i64* %r831
%r834 = getelementptr i64, i64* %r2, i32 3
%r835 = load i64, i64* %r834
%r836 = call i128 @mul64x64L(i64 %r832, i64 %r835)
%r837 = zext i128 %r829 to i256
%r838 = zext i128 %r836 to i256
%r839 = shl i256 %r838, 128
%r840 = or i256 %r837, %r839
%r842 = getelementptr i64, i64* %r2, i32 2
%r843 = load i64, i64* %r842
%r845 = getelementptr i64, i64* %r2, i32 4
%r846 = load i64, i64* %r845
%r847 = call i128 @mul64x64L(i64 %r843, i64 %r846)
%r848 = zext i256 %r840 to i384
%r849 = zext i128 %r847 to i384
%r850 = shl i384 %r849, 256
%r851 = or i384 %r848, %r850
%r853 = getelementptr i64, i64* %r2, i32 3
%r854 = load i64, i64* %r853
%r856 = getelementptr i64, i64* %r2, i32 5
%r857 = load i64, i64* %r856
%r858 = call i128 @mul64x64L(i64 %r854, i64 %r857)
%r859 = zext i384 %r851 to i512
%r860 = zext i128 %r858 to i512
%r861 = shl i512 %r860, 384
%r862 = or i512 %r859, %r861
%r864 = getelementptr i64, i64* %r2, i32 4
%r865 = load i64, i64* %r864
%r867 = getelementptr i64, i64* %r2, i32 6
%r868 = load i64, i64* %r867
%r869 = call i128 @mul64x64L(i64 %r865, i64 %r868)
%r870 = zext i512 %r862 to i640
%r871 = zext i128 %r869 to i640
%r872 = shl i640 %r871, 512
%r873 = or i640 %r870, %r872
%r875 = getelementptr i64, i64* %r2, i32 5
%r876 = load i64, i64* %r875
%r878 = getelementptr i64, i64* %r2, i32 7
%r879 = load i64, i64* %r878
%r880 = call i128 @mul64x64L(i64 %r876, i64 %r879)
%r881 = zext i640 %r873 to i768
%r882 = zext i128 %r880 to i768
%r883 = shl i768 %r882, 640
%r884 = or i768 %r881, %r883
%r886 = getelementptr i64, i64* %r2, i32 6
%r887 = load i64, i64* %r886
%r889 = getelementptr i64, i64* %r2, i32 8
%r890 = load i64, i64* %r889
%r891 = call i128 @mul64x64L(i64 %r887, i64 %r890)
%r892 = zext i768 %r884 to i896
%r893 = zext i128 %r891 to i896
%r894 = shl i896 %r893, 768
%r895 = or i896 %r892, %r894
%r897 = getelementptr i64, i64* %r2, i32 7
%r898 = load i64, i64* %r897
%r900 = getelementptr i64, i64* %r2, i32 9
%r901 = load i64, i64* %r900
%r902 = call i128 @mul64x64L(i64 %r898, i64 %r901)
%r903 = zext i896 %r895 to i1024
%r904 = zext i128 %r902 to i1024
%r905 = shl i1024 %r904, 896
%r906 = or i1024 %r903, %r905
%r908 = getelementptr i64, i64* %r2, i32 8
%r909 = load i64, i64* %r908
%r911 = getelementptr i64, i64* %r2, i32 10
%r912 = load i64, i64* %r911
%r913 = call i128 @mul64x64L(i64 %r909, i64 %r912)
%r914 = zext i1024 %r906 to i1152
%r915 = zext i128 %r913 to i1152
%r916 = shl i1152 %r915, 1024
%r917 = or i1152 %r914, %r916
%r919 = getelementptr i64, i64* %r2, i32 9
%r920 = load i64, i64* %r919
%r922 = getelementptr i64, i64* %r2, i32 11
%r923 = load i64, i64* %r922
%r924 = call i128 @mul64x64L(i64 %r920, i64 %r923)
%r925 = zext i1152 %r917 to i1280
%r926 = zext i128 %r924 to i1280
%r927 = shl i1280 %r926, 1152
%r928 = or i1280 %r925, %r927
%r930 = getelementptr i64, i64* %r2, i32 10
%r931 = load i64, i64* %r930
%r933 = getelementptr i64, i64* %r2, i32 12
%r934 = load i64, i64* %r933
%r935 = call i128 @mul64x64L(i64 %r931, i64 %r934)
%r936 = zext i1280 %r928 to i1408
%r937 = zext i128 %r935 to i1408
%r938 = shl i1408 %r937, 1280
%r939 = or i1408 %r936, %r938
%r941 = getelementptr i64, i64* %r2, i32 11
%r942 = load i64, i64* %r941
%r944 = getelementptr i64, i64* %r2, i32 13
%r945 = load i64, i64* %r944
%r946 = call i128 @mul64x64L(i64 %r942, i64 %r945)
%r947 = zext i1408 %r939 to i1536
%r948 = zext i128 %r946 to i1536
%r949 = shl i1536 %r948, 1408
%r950 = or i1536 %r947, %r949
%r952 = getelementptr i64, i64* %r2, i32 12
%r953 = load i64, i64* %r952
%r955 = getelementptr i64, i64* %r2, i32 14
%r956 = load i64, i64* %r955
%r957 = call i128 @mul64x64L(i64 %r953, i64 %r956)
%r958 = zext i1536 %r950 to i1664
%r959 = zext i128 %r957 to i1664
%r960 = shl i1664 %r959, 1536
%r961 = or i1664 %r958, %r960
%r962 = zext i1536 %r824 to i1664
%r963 = shl i1664 %r962, 64
%r964 = add i1664 %r963, %r961
%r965 = load i64, i64* %r2
%r967 = getelementptr i64, i64* %r2, i32 1
%r968 = load i64, i64* %r967
%r969 = call i128 @mul64x64L(i64 %r965, i64 %r968)
%r971 = getelementptr i64, i64* %r2, i32 1
%r972 = load i64, i64* %r971
%r974 = getelementptr i64, i64* %r2, i32 2
%r975 = load i64, i64* %r974
%r976 = call i128 @mul64x64L(i64 %r972, i64 %r975)
%r977 = zext i128 %r969 to i256
%r978 = zext i128 %r976 to i256
%r979 = shl i256 %r978, 128
%r980 = or i256 %r977, %r979
%r982 = getelementptr i64, i64* %r2, i32 2
%r983 = load i64, i64* %r982
%r985 = getelementptr i64, i64* %r2, i32 3
%r986 = load i64, i64* %r985
%r987 = call i128 @mul64x64L(i64 %r983, i64 %r986)
%r988 = zext i256 %r980 to i384
%r989 = zext i128 %r987 to i384
%r990 = shl i384 %r989, 256
%r991 = or i384 %r988, %r990
%r993 = getelementptr i64, i64* %r2, i32 3
%r994 = load i64, i64* %r993
%r996 = getelementptr i64, i64* %r2, i32 4
%r997 = load i64, i64* %r996
%r998 = call i128 @mul64x64L(i64 %r994, i64 %r997)
%r999 = zext i384 %r991 to i512
%r1000 = zext i128 %r998 to i512
%r1001 = shl i512 %r1000, 384
%r1002 = or i512 %r999, %r1001
%r1004 = getelementptr i64, i64* %r2, i32 4
%r1005 = load i64, i64* %r1004
%r1007 = getelementptr i64, i64* %r2, i32 5
%r1008 = load i64, i64* %r1007
%r1009 = call i128 @mul64x64L(i64 %r1005, i64 %r1008)
%r1010 = zext i512 %r1002 to i640
%r1011 = zext i128 %r1009 to i640
%r1012 = shl i640 %r1011, 512
%r1013 = or i640 %r1010, %r1012
%r1015 = getelementptr i64, i64* %r2, i32 5
%r1016 = load i64, i64* %r1015
%r1018 = getelementptr i64, i64* %r2, i32 6
%r1019 = load i64, i64* %r1018
%r1020 = call i128 @mul64x64L(i64 %r1016, i64 %r1019)
%r1021 = zext i640 %r1013 to i768
%r1022 = zext i128 %r1020 to i768
%r1023 = shl i768 %r1022, 640
%r1024 = or i768 %r1021, %r1023
%r1026 = getelementptr i64, i64* %r2, i32 6
%r1027 = load i64, i64* %r1026
%r1029 = getelementptr i64, i64* %r2, i32 7
%r1030 = load i64, i64* %r1029
%r1031 = call i128 @mul64x64L(i64 %r1027, i64 %r1030)
%r1032 = zext i768 %r1024 to i896
%r1033 = zext i128 %r1031 to i896
%r1034 = shl i896 %r1033, 768
%r1035 = or i896 %r1032, %r1034
%r1037 = getelementptr i64, i64* %r2, i32 7
%r1038 = load i64, i64* %r1037
%r1040 = getelementptr i64, i64* %r2, i32 8
%r1041 = load i64, i64* %r1040
%r1042 = call i128 @mul64x64L(i64 %r1038, i64 %r1041)
%r1043 = zext i896 %r1035 to i1024
%r1044 = zext i128 %r1042 to i1024
%r1045 = shl i1024 %r1044, 896
%r1046 = or i1024 %r1043, %r1045
%r1048 = getelementptr i64, i64* %r2, i32 8
%r1049 = load i64, i64* %r1048
%r1051 = getelementptr i64, i64* %r2, i32 9
%r1052 = load i64, i64* %r1051
%r1053 = call i128 @mul64x64L(i64 %r1049, i64 %r1052)
%r1054 = zext i1024 %r1046 to i1152
%r1055 = zext i128 %r1053 to i1152
%r1056 = shl i1152 %r1055, 1024
%r1057 = or i1152 %r1054, %r1056
%r1059 = getelementptr i64, i64* %r2, i32 9
%r1060 = load i64, i64* %r1059
%r1062 = getelementptr i64, i64* %r2, i32 10
%r1063 = load i64, i64* %r1062
%r1064 = call i128 @mul64x64L(i64 %r1060, i64 %r1063)
%r1065 = zext i1152 %r1057 to i1280
%r1066 = zext i128 %r1064 to i1280
%r1067 = shl i1280 %r1066, 1152
%r1068 = or i1280 %r1065, %r1067
%r1070 = getelementptr i64, i64* %r2, i32 10
%r1071 = load i64, i64* %r1070
%r1073 = getelementptr i64, i64* %r2, i32 11
%r1074 = load i64, i64* %r1073
%r1075 = call i128 @mul64x64L(i64 %r1071, i64 %r1074)
%r1076 = zext i1280 %r1068 to i1408
%r1077 = zext i128 %r1075 to i1408
%r1078 = shl i1408 %r1077, 1280
%r1079 = or i1408 %r1076, %r1078
%r1081 = getelementptr i64, i64* %r2, i32 11
%r1082 = load i64, i64* %r1081
%r1084 = getelementptr i64, i64* %r2, i32 12
%r1085 = load i64, i64* %r1084
%r1086 = call i128 @mul64x64L(i64 %r1082, i64 %r1085)
%r1087 = zext i1408 %r1079 to i1536
%r1088 = zext i128 %r1086 to i1536
%r1089 = shl i1536 %r1088, 1408
%r1090 = or i1536 %r1087, %r1089
%r1092 = getelementptr i64, i64* %r2, i32 12
%r1093 = load i64, i64* %r1092
%r1095 = getelementptr i64, i64* %r2, i32 13
%r1096 = load i64, i64* %r1095
%r1097 = call i128 @mul64x64L(i64 %r1093, i64 %r1096)
%r1098 = zext i1536 %r1090 to i1664
%r1099 = zext i128 %r1097 to i1664
%r1100 = shl i1664 %r1099, 1536
%r1101 = or i1664 %r1098, %r1100
%r1103 = getelementptr i64, i64* %r2, i32 13
%r1104 = load i64, i64* %r1103
%r1106 = getelementptr i64, i64* %r2, i32 14
%r1107 = load i64, i64* %r1106
%r1108 = call i128 @mul64x64L(i64 %r1104, i64 %r1107)
%r1109 = zext i1664 %r1101 to i1792
%r1110 = zext i128 %r1108 to i1792
%r1111 = shl i1792 %r1110, 1664
%r1112 = or i1792 %r1109, %r1111
%r1113 = zext i1664 %r964 to i1792
%r1114 = shl i1792 %r1113, 64
%r1115 = add i1792 %r1114, %r1112
%r1116 = zext i128 %r6 to i1856
%r1118 = getelementptr i64, i64* %r2, i32 1
%r1119 = load i64, i64* %r1118
%r1120 = call i128 @mul64x64L(i64 %r1119, i64 %r1119)
%r1121 = zext i128 %r1120 to i1856
%r1122 = shl i1856 %r1121, 64
%r1123 = or i1856 %r1116, %r1122
%r1125 = getelementptr i64, i64* %r2, i32 2
%r1126 = load i64, i64* %r1125
%r1127 = call i128 @mul64x64L(i64 %r1126, i64 %r1126)
%r1128 = zext i128 %r1127 to i1856
%r1129 = shl i1856 %r1128, 192
%r1130 = or i1856 %r1123, %r1129
%r1132 = getelementptr i64, i64* %r2, i32 3
%r1133 = load i64, i64* %r1132
%r1134 = call i128 @mul64x64L(i64 %r1133, i64 %r1133)
%r1135 = zext i128 %r1134 to i1856
%r1136 = shl i1856 %r1135, 320
%r1137 = or i1856 %r1130, %r1136
%r1139 = getelementptr i64, i64* %r2, i32 4
%r1140 = load i64, i64* %r1139
%r1141 = call i128 @mul64x64L(i64 %r1140, i64 %r1140)
%r1142 = zext i128 %r1141 to i1856
%r1143 = shl i1856 %r1142, 448
%r1144 = or i1856 %r1137, %r1143
%r1146 = getelementptr i64, i64* %r2, i32 5
%r1147 = load i64, i64* %r1146
%r1148 = call i128 @mul64x64L(i64 %r1147, i64 %r1147)
%r1149 = zext i128 %r1148 to i1856
%r1150 = shl i1856 %r1149, 576
%r1151 = or i1856 %r1144, %r1150
%r1153 = getelementptr i64, i64* %r2, i32 6
%r1154 = load i64, i64* %r1153
%r1155 = call i128 @mul64x64L(i64 %r1154, i64 %r1154)
%r1156 = zext i128 %r1155 to i1856
%r1157 = shl i1856 %r1156, 704
%r1158 = or i1856 %r1151, %r1157
%r1160 = getelementptr i64, i64* %r2, i32 7
%r1161 = load i64, i64* %r1160
%r1162 = call i128 @mul64x64L(i64 %r1161, i64 %r1161)
%r1163 = zext i128 %r1162 to i1856
%r1164 = shl i1856 %r1163, 832
%r1165 = or i1856 %r1158, %r1164
%r1167 = getelementptr i64, i64* %r2, i32 8
%r1168 = load i64, i64* %r1167
%r1169 = call i128 @mul64x64L(i64 %r1168, i64 %r1168)
%r1170 = zext i128 %r1169 to i1856
%r1171 = shl i1856 %r1170, 960
%r1172 = or i1856 %r1165, %r1171
%r1174 = getelementptr i64, i64* %r2, i32 9
%r1175 = load i64, i64* %r1174
%r1176 = call i128 @mul64x64L(i64 %r1175, i64 %r1175)
%r1177 = zext i128 %r1176 to i1856
%r1178 = shl i1856 %r1177, 1088
%r1179 = or i1856 %r1172, %r1178
%r1181 = getelementptr i64, i64* %r2, i32 10
%r1182 = load i64, i64* %r1181
%r1183 = call i128 @mul64x64L(i64 %r1182, i64 %r1182)
%r1184 = zext i128 %r1183 to i1856
%r1185 = shl i1856 %r1184, 1216
%r1186 = or i1856 %r1179, %r1185
%r1188 = getelementptr i64, i64* %r2, i32 11
%r1189 = load i64, i64* %r1188
%r1190 = call i128 @mul64x64L(i64 %r1189, i64 %r1189)
%r1191 = zext i128 %r1190 to i1856
%r1192 = shl i1856 %r1191, 1344
%r1193 = or i1856 %r1186, %r1192
%r1195 = getelementptr i64, i64* %r2, i32 12
%r1196 = load i64, i64* %r1195
%r1197 = call i128 @mul64x64L(i64 %r1196, i64 %r1196)
%r1198 = zext i128 %r1197 to i1856
%r1199 = shl i1856 %r1198, 1472
%r1200 = or i1856 %r1193, %r1199
%r1202 = getelementptr i64, i64* %r2, i32 13
%r1203 = load i64, i64* %r1202
%r1204 = call i128 @mul64x64L(i64 %r1203, i64 %r1203)
%r1205 = zext i128 %r1204 to i1856
%r1206 = shl i1856 %r1205, 1600
%r1207 = or i1856 %r1200, %r1206
%r1209 = getelementptr i64, i64* %r2, i32 14
%r1210 = load i64, i64* %r1209
%r1211 = call i128 @mul64x64L(i64 %r1210, i64 %r1210)
%r1212 = zext i128 %r1211 to i1856
%r1213 = shl i1856 %r1212, 1728
%r1214 = or i1856 %r1207, %r1213
%r1215 = zext i1792 %r1115 to i1856
%r1216 = add i1856 %r1215, %r1215
%r1217 = add i1856 %r1214, %r1216
%r1219 = getelementptr i64, i64* %r1, i32 1
%r1221 = getelementptr i64, i64* %r1219, i32 0
%r1222 = trunc i1856 %r1217 to i64
store i64 %r1222, i64* %r1221
%r1223 = lshr i1856 %r1217, 64
%r1225 = getelementptr i64, i64* %r1219, i32 1
%r1226 = trunc i1856 %r1223 to i64
store i64 %r1226, i64* %r1225
%r1227 = lshr i1856 %r1223, 64
%r1229 = getelementptr i64, i64* %r1219, i32 2
%r1230 = trunc i1856 %r1227 to i64
store i64 %r1230, i64* %r1229
%r1231 = lshr i1856 %r1227, 64
%r1233 = getelementptr i64, i64* %r1219, i32 3
%r1234 = trunc i1856 %r1231 to i64
store i64 %r1234, i64* %r1233
%r1235 = lshr i1856 %r1231, 64
%r1237 = getelementptr i64, i64* %r1219, i32 4
%r1238 = trunc i1856 %r1235 to i64
store i64 %r1238, i64* %r1237
%r1239 = lshr i1856 %r1235, 64
%r1241 = getelementptr i64, i64* %r1219, i32 5
%r1242 = trunc i1856 %r1239 to i64
store i64 %r1242, i64* %r1241
%r1243 = lshr i1856 %r1239, 64
%r1245 = getelementptr i64, i64* %r1219, i32 6
%r1246 = trunc i1856 %r1243 to i64
store i64 %r1246, i64* %r1245
%r1247 = lshr i1856 %r1243, 64
%r1249 = getelementptr i64, i64* %r1219, i32 7
%r1250 = trunc i1856 %r1247 to i64
store i64 %r1250, i64* %r1249
%r1251 = lshr i1856 %r1247, 64
%r1253 = getelementptr i64, i64* %r1219, i32 8
%r1254 = trunc i1856 %r1251 to i64
store i64 %r1254, i64* %r1253
%r1255 = lshr i1856 %r1251, 64
%r1257 = getelementptr i64, i64* %r1219, i32 9
%r1258 = trunc i1856 %r1255 to i64
store i64 %r1258, i64* %r1257
%r1259 = lshr i1856 %r1255, 64
%r1261 = getelementptr i64, i64* %r1219, i32 10
%r1262 = trunc i1856 %r1259 to i64
store i64 %r1262, i64* %r1261
%r1263 = lshr i1856 %r1259, 64
%r1265 = getelementptr i64, i64* %r1219, i32 11
%r1266 = trunc i1856 %r1263 to i64
store i64 %r1266, i64* %r1265
%r1267 = lshr i1856 %r1263, 64
%r1269 = getelementptr i64, i64* %r1219, i32 12
%r1270 = trunc i1856 %r1267 to i64
store i64 %r1270, i64* %r1269
%r1271 = lshr i1856 %r1267, 64
%r1273 = getelementptr i64, i64* %r1219, i32 13
%r1274 = trunc i1856 %r1271 to i64
store i64 %r1274, i64* %r1273
%r1275 = lshr i1856 %r1271, 64
%r1277 = getelementptr i64, i64* %r1219, i32 14
%r1278 = trunc i1856 %r1275 to i64
store i64 %r1278, i64* %r1277
%r1279 = lshr i1856 %r1275, 64
%r1281 = getelementptr i64, i64* %r1219, i32 15
%r1282 = trunc i1856 %r1279 to i64
store i64 %r1282, i64* %r1281
%r1283 = lshr i1856 %r1279, 64
%r1285 = getelementptr i64, i64* %r1219, i32 16
%r1286 = trunc i1856 %r1283 to i64
store i64 %r1286, i64* %r1285
%r1287 = lshr i1856 %r1283, 64
%r1289 = getelementptr i64, i64* %r1219, i32 17
%r1290 = trunc i1856 %r1287 to i64
store i64 %r1290, i64* %r1289
%r1291 = lshr i1856 %r1287, 64
%r1293 = getelementptr i64, i64* %r1219, i32 18
%r1294 = trunc i1856 %r1291 to i64
store i64 %r1294, i64* %r1293
%r1295 = lshr i1856 %r1291, 64
%r1297 = getelementptr i64, i64* %r1219, i32 19
%r1298 = trunc i1856 %r1295 to i64
store i64 %r1298, i64* %r1297
%r1299 = lshr i1856 %r1295, 64
%r1301 = getelementptr i64, i64* %r1219, i32 20
%r1302 = trunc i1856 %r1299 to i64
store i64 %r1302, i64* %r1301
%r1303 = lshr i1856 %r1299, 64
%r1305 = getelementptr i64, i64* %r1219, i32 21
%r1306 = trunc i1856 %r1303 to i64
store i64 %r1306, i64* %r1305
%r1307 = lshr i1856 %r1303, 64
%r1309 = getelementptr i64, i64* %r1219, i32 22
%r1310 = trunc i1856 %r1307 to i64
store i64 %r1310, i64* %r1309
%r1311 = lshr i1856 %r1307, 64
%r1313 = getelementptr i64, i64* %r1219, i32 23
%r1314 = trunc i1856 %r1311 to i64
store i64 %r1314, i64* %r1313
%r1315 = lshr i1856 %r1311, 64
%r1317 = getelementptr i64, i64* %r1219, i32 24
%r1318 = trunc i1856 %r1315 to i64
store i64 %r1318, i64* %r1317
%r1319 = lshr i1856 %r1315, 64
%r1321 = getelementptr i64, i64* %r1219, i32 25
%r1322 = trunc i1856 %r1319 to i64
store i64 %r1322, i64* %r1321
%r1323 = lshr i1856 %r1319, 64
%r1325 = getelementptr i64, i64* %r1219, i32 26
%r1326 = trunc i1856 %r1323 to i64
store i64 %r1326, i64* %r1325
%r1327 = lshr i1856 %r1323, 64
%r1329 = getelementptr i64, i64* %r1219, i32 27
%r1330 = trunc i1856 %r1327 to i64
store i64 %r1330, i64* %r1329
%r1331 = lshr i1856 %r1327, 64
%r1333 = getelementptr i64, i64* %r1219, i32 28
%r1334 = trunc i1856 %r1331 to i64
store i64 %r1334, i64* %r1333
ret void
}
define private i960 @mulUnit2_inner960(i64* noalias  %r2, i64 %r3)
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
%r41 = call i128 @mulPos64x64(i64* %r2, i64 %r3, i64 9)
%r42 = trunc i128 %r41 to i64
%r43 = call i64 @extractHigh64(i128 %r41)
%r45 = call i128 @mulPos64x64(i64* %r2, i64 %r3, i64 10)
%r46 = trunc i128 %r45 to i64
%r47 = call i64 @extractHigh64(i128 %r45)
%r49 = call i128 @mulPos64x64(i64* %r2, i64 %r3, i64 11)
%r50 = trunc i128 %r49 to i64
%r51 = call i64 @extractHigh64(i128 %r49)
%r53 = call i128 @mulPos64x64(i64* %r2, i64 %r3, i64 12)
%r54 = trunc i128 %r53 to i64
%r55 = call i64 @extractHigh64(i128 %r53)
%r57 = call i128 @mulPos64x64(i64* %r2, i64 %r3, i64 13)
%r58 = trunc i128 %r57 to i64
%r59 = call i64 @extractHigh64(i128 %r57)
%r61 = call i128 @mulPos64x64(i64* %r2, i64 %r3, i64 14)
%r62 = trunc i128 %r61 to i64
%r63 = zext i64 %r6 to i128
%r64 = zext i64 %r10 to i128
%r65 = shl i128 %r64, 64
%r66 = or i128 %r63, %r65
%r67 = zext i128 %r66 to i192
%r68 = zext i64 %r14 to i192
%r69 = shl i192 %r68, 128
%r70 = or i192 %r67, %r69
%r71 = zext i192 %r70 to i256
%r72 = zext i64 %r18 to i256
%r73 = shl i256 %r72, 192
%r74 = or i256 %r71, %r73
%r75 = zext i256 %r74 to i320
%r76 = zext i64 %r22 to i320
%r77 = shl i320 %r76, 256
%r78 = or i320 %r75, %r77
%r79 = zext i320 %r78 to i384
%r80 = zext i64 %r26 to i384
%r81 = shl i384 %r80, 320
%r82 = or i384 %r79, %r81
%r83 = zext i384 %r82 to i448
%r84 = zext i64 %r30 to i448
%r85 = shl i448 %r84, 384
%r86 = or i448 %r83, %r85
%r87 = zext i448 %r86 to i512
%r88 = zext i64 %r34 to i512
%r89 = shl i512 %r88, 448
%r90 = or i512 %r87, %r89
%r91 = zext i512 %r90 to i576
%r92 = zext i64 %r38 to i576
%r93 = shl i576 %r92, 512
%r94 = or i576 %r91, %r93
%r95 = zext i576 %r94 to i640
%r96 = zext i64 %r42 to i640
%r97 = shl i640 %r96, 576
%r98 = or i640 %r95, %r97
%r99 = zext i640 %r98 to i704
%r100 = zext i64 %r46 to i704
%r101 = shl i704 %r100, 640
%r102 = or i704 %r99, %r101
%r103 = zext i704 %r102 to i768
%r104 = zext i64 %r50 to i768
%r105 = shl i768 %r104, 704
%r106 = or i768 %r103, %r105
%r107 = zext i768 %r106 to i832
%r108 = zext i64 %r54 to i832
%r109 = shl i832 %r108, 768
%r110 = or i832 %r107, %r109
%r111 = zext i832 %r110 to i896
%r112 = zext i64 %r58 to i896
%r113 = shl i896 %r112, 832
%r114 = or i896 %r111, %r113
%r115 = zext i896 %r114 to i960
%r116 = zext i64 %r62 to i960
%r117 = shl i960 %r116, 896
%r118 = or i960 %r115, %r117
%r119 = zext i64 %r7 to i128
%r120 = zext i64 %r11 to i128
%r121 = shl i128 %r120, 64
%r122 = or i128 %r119, %r121
%r123 = zext i128 %r122 to i192
%r124 = zext i64 %r15 to i192
%r125 = shl i192 %r124, 128
%r126 = or i192 %r123, %r125
%r127 = zext i192 %r126 to i256
%r128 = zext i64 %r19 to i256
%r129 = shl i256 %r128, 192
%r130 = or i256 %r127, %r129
%r131 = zext i256 %r130 to i320
%r132 = zext i64 %r23 to i320
%r133 = shl i320 %r132, 256
%r134 = or i320 %r131, %r133
%r135 = zext i320 %r134 to i384
%r136 = zext i64 %r27 to i384
%r137 = shl i384 %r136, 320
%r138 = or i384 %r135, %r137
%r139 = zext i384 %r138 to i448
%r140 = zext i64 %r31 to i448
%r141 = shl i448 %r140, 384
%r142 = or i448 %r139, %r141
%r143 = zext i448 %r142 to i512
%r144 = zext i64 %r35 to i512
%r145 = shl i512 %r144, 448
%r146 = or i512 %r143, %r145
%r147 = zext i512 %r146 to i576
%r148 = zext i64 %r39 to i576
%r149 = shl i576 %r148, 512
%r150 = or i576 %r147, %r149
%r151 = zext i576 %r150 to i640
%r152 = zext i64 %r43 to i640
%r153 = shl i640 %r152, 576
%r154 = or i640 %r151, %r153
%r155 = zext i640 %r154 to i704
%r156 = zext i64 %r47 to i704
%r157 = shl i704 %r156, 640
%r158 = or i704 %r155, %r157
%r159 = zext i704 %r158 to i768
%r160 = zext i64 %r51 to i768
%r161 = shl i768 %r160, 704
%r162 = or i768 %r159, %r161
%r163 = zext i768 %r162 to i832
%r164 = zext i64 %r55 to i832
%r165 = shl i832 %r164, 768
%r166 = or i832 %r163, %r165
%r167 = zext i832 %r166 to i896
%r168 = zext i64 %r59 to i896
%r169 = shl i896 %r168, 832
%r170 = or i896 %r167, %r169
%r171 = zext i896 %r170 to i960
%r172 = shl i960 %r171, 64
%r173 = add i960 %r118, %r172
ret i960 %r173
}
define i1088 @mulUnit_inner1024(i64* noalias  %r2, i64 %r3)
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
%r41 = call i128 @mulPos64x64(i64* %r2, i64 %r3, i64 9)
%r42 = trunc i128 %r41 to i64
%r43 = call i64 @extractHigh64(i128 %r41)
%r45 = call i128 @mulPos64x64(i64* %r2, i64 %r3, i64 10)
%r46 = trunc i128 %r45 to i64
%r47 = call i64 @extractHigh64(i128 %r45)
%r49 = call i128 @mulPos64x64(i64* %r2, i64 %r3, i64 11)
%r50 = trunc i128 %r49 to i64
%r51 = call i64 @extractHigh64(i128 %r49)
%r53 = call i128 @mulPos64x64(i64* %r2, i64 %r3, i64 12)
%r54 = trunc i128 %r53 to i64
%r55 = call i64 @extractHigh64(i128 %r53)
%r57 = call i128 @mulPos64x64(i64* %r2, i64 %r3, i64 13)
%r58 = trunc i128 %r57 to i64
%r59 = call i64 @extractHigh64(i128 %r57)
%r61 = call i128 @mulPos64x64(i64* %r2, i64 %r3, i64 14)
%r62 = trunc i128 %r61 to i64
%r63 = call i64 @extractHigh64(i128 %r61)
%r65 = call i128 @mulPos64x64(i64* %r2, i64 %r3, i64 15)
%r66 = trunc i128 %r65 to i64
%r67 = call i64 @extractHigh64(i128 %r65)
%r68 = zext i64 %r6 to i128
%r69 = zext i64 %r10 to i128
%r70 = shl i128 %r69, 64
%r71 = or i128 %r68, %r70
%r72 = zext i128 %r71 to i192
%r73 = zext i64 %r14 to i192
%r74 = shl i192 %r73, 128
%r75 = or i192 %r72, %r74
%r76 = zext i192 %r75 to i256
%r77 = zext i64 %r18 to i256
%r78 = shl i256 %r77, 192
%r79 = or i256 %r76, %r78
%r80 = zext i256 %r79 to i320
%r81 = zext i64 %r22 to i320
%r82 = shl i320 %r81, 256
%r83 = or i320 %r80, %r82
%r84 = zext i320 %r83 to i384
%r85 = zext i64 %r26 to i384
%r86 = shl i384 %r85, 320
%r87 = or i384 %r84, %r86
%r88 = zext i384 %r87 to i448
%r89 = zext i64 %r30 to i448
%r90 = shl i448 %r89, 384
%r91 = or i448 %r88, %r90
%r92 = zext i448 %r91 to i512
%r93 = zext i64 %r34 to i512
%r94 = shl i512 %r93, 448
%r95 = or i512 %r92, %r94
%r96 = zext i512 %r95 to i576
%r97 = zext i64 %r38 to i576
%r98 = shl i576 %r97, 512
%r99 = or i576 %r96, %r98
%r100 = zext i576 %r99 to i640
%r101 = zext i64 %r42 to i640
%r102 = shl i640 %r101, 576
%r103 = or i640 %r100, %r102
%r104 = zext i640 %r103 to i704
%r105 = zext i64 %r46 to i704
%r106 = shl i704 %r105, 640
%r107 = or i704 %r104, %r106
%r108 = zext i704 %r107 to i768
%r109 = zext i64 %r50 to i768
%r110 = shl i768 %r109, 704
%r111 = or i768 %r108, %r110
%r112 = zext i768 %r111 to i832
%r113 = zext i64 %r54 to i832
%r114 = shl i832 %r113, 768
%r115 = or i832 %r112, %r114
%r116 = zext i832 %r115 to i896
%r117 = zext i64 %r58 to i896
%r118 = shl i896 %r117, 832
%r119 = or i896 %r116, %r118
%r120 = zext i896 %r119 to i960
%r121 = zext i64 %r62 to i960
%r122 = shl i960 %r121, 896
%r123 = or i960 %r120, %r122
%r124 = zext i960 %r123 to i1024
%r125 = zext i64 %r66 to i1024
%r126 = shl i1024 %r125, 960
%r127 = or i1024 %r124, %r126
%r128 = zext i64 %r7 to i128
%r129 = zext i64 %r11 to i128
%r130 = shl i128 %r129, 64
%r131 = or i128 %r128, %r130
%r132 = zext i128 %r131 to i192
%r133 = zext i64 %r15 to i192
%r134 = shl i192 %r133, 128
%r135 = or i192 %r132, %r134
%r136 = zext i192 %r135 to i256
%r137 = zext i64 %r19 to i256
%r138 = shl i256 %r137, 192
%r139 = or i256 %r136, %r138
%r140 = zext i256 %r139 to i320
%r141 = zext i64 %r23 to i320
%r142 = shl i320 %r141, 256
%r143 = or i320 %r140, %r142
%r144 = zext i320 %r143 to i384
%r145 = zext i64 %r27 to i384
%r146 = shl i384 %r145, 320
%r147 = or i384 %r144, %r146
%r148 = zext i384 %r147 to i448
%r149 = zext i64 %r31 to i448
%r150 = shl i448 %r149, 384
%r151 = or i448 %r148, %r150
%r152 = zext i448 %r151 to i512
%r153 = zext i64 %r35 to i512
%r154 = shl i512 %r153, 448
%r155 = or i512 %r152, %r154
%r156 = zext i512 %r155 to i576
%r157 = zext i64 %r39 to i576
%r158 = shl i576 %r157, 512
%r159 = or i576 %r156, %r158
%r160 = zext i576 %r159 to i640
%r161 = zext i64 %r43 to i640
%r162 = shl i640 %r161, 576
%r163 = or i640 %r160, %r162
%r164 = zext i640 %r163 to i704
%r165 = zext i64 %r47 to i704
%r166 = shl i704 %r165, 640
%r167 = or i704 %r164, %r166
%r168 = zext i704 %r167 to i768
%r169 = zext i64 %r51 to i768
%r170 = shl i768 %r169, 704
%r171 = or i768 %r168, %r170
%r172 = zext i768 %r171 to i832
%r173 = zext i64 %r55 to i832
%r174 = shl i832 %r173, 768
%r175 = or i832 %r172, %r174
%r176 = zext i832 %r175 to i896
%r177 = zext i64 %r59 to i896
%r178 = shl i896 %r177, 832
%r179 = or i896 %r176, %r178
%r180 = zext i896 %r179 to i960
%r181 = zext i64 %r63 to i960
%r182 = shl i960 %r181, 896
%r183 = or i960 %r180, %r182
%r184 = zext i960 %r183 to i1024
%r185 = zext i64 %r67 to i1024
%r186 = shl i1024 %r185, 960
%r187 = or i1024 %r184, %r186
%r188 = zext i1024 %r127 to i1088
%r189 = zext i1024 %r187 to i1088
%r190 = shl i1088 %r189, 64
%r191 = add i1088 %r188, %r190
ret i1088 %r191
}
define i64 @mclb_mulUnit16(i64* noalias  %r2, i64* noalias  %r3, i64 %r4)
{
%r5 = call i1088 @mulUnit_inner1024(i64* %r3, i64 %r4)
%r6 = trunc i1088 %r5 to i1024
%r8 = getelementptr i64, i64* %r2, i32 0
%r9 = trunc i1024 %r6 to i64
store i64 %r9, i64* %r8
%r10 = lshr i1024 %r6, 64
%r12 = getelementptr i64, i64* %r2, i32 1
%r13 = trunc i1024 %r10 to i64
store i64 %r13, i64* %r12
%r14 = lshr i1024 %r10, 64
%r16 = getelementptr i64, i64* %r2, i32 2
%r17 = trunc i1024 %r14 to i64
store i64 %r17, i64* %r16
%r18 = lshr i1024 %r14, 64
%r20 = getelementptr i64, i64* %r2, i32 3
%r21 = trunc i1024 %r18 to i64
store i64 %r21, i64* %r20
%r22 = lshr i1024 %r18, 64
%r24 = getelementptr i64, i64* %r2, i32 4
%r25 = trunc i1024 %r22 to i64
store i64 %r25, i64* %r24
%r26 = lshr i1024 %r22, 64
%r28 = getelementptr i64, i64* %r2, i32 5
%r29 = trunc i1024 %r26 to i64
store i64 %r29, i64* %r28
%r30 = lshr i1024 %r26, 64
%r32 = getelementptr i64, i64* %r2, i32 6
%r33 = trunc i1024 %r30 to i64
store i64 %r33, i64* %r32
%r34 = lshr i1024 %r30, 64
%r36 = getelementptr i64, i64* %r2, i32 7
%r37 = trunc i1024 %r34 to i64
store i64 %r37, i64* %r36
%r38 = lshr i1024 %r34, 64
%r40 = getelementptr i64, i64* %r2, i32 8
%r41 = trunc i1024 %r38 to i64
store i64 %r41, i64* %r40
%r42 = lshr i1024 %r38, 64
%r44 = getelementptr i64, i64* %r2, i32 9
%r45 = trunc i1024 %r42 to i64
store i64 %r45, i64* %r44
%r46 = lshr i1024 %r42, 64
%r48 = getelementptr i64, i64* %r2, i32 10
%r49 = trunc i1024 %r46 to i64
store i64 %r49, i64* %r48
%r50 = lshr i1024 %r46, 64
%r52 = getelementptr i64, i64* %r2, i32 11
%r53 = trunc i1024 %r50 to i64
store i64 %r53, i64* %r52
%r54 = lshr i1024 %r50, 64
%r56 = getelementptr i64, i64* %r2, i32 12
%r57 = trunc i1024 %r54 to i64
store i64 %r57, i64* %r56
%r58 = lshr i1024 %r54, 64
%r60 = getelementptr i64, i64* %r2, i32 13
%r61 = trunc i1024 %r58 to i64
store i64 %r61, i64* %r60
%r62 = lshr i1024 %r58, 64
%r64 = getelementptr i64, i64* %r2, i32 14
%r65 = trunc i1024 %r62 to i64
store i64 %r65, i64* %r64
%r66 = lshr i1024 %r62, 64
%r68 = getelementptr i64, i64* %r2, i32 15
%r69 = trunc i1024 %r66 to i64
store i64 %r69, i64* %r68
%r70 = lshr i1088 %r5, 1024
%r71 = trunc i1088 %r70 to i64
ret i64 %r71
}
define i64 @mclb_mulUnitAdd16(i64* noalias  %r2, i64* noalias  %r3, i64 %r4)
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
%r42 = call i128 @mulPos64x64(i64* %r3, i64 %r4, i64 9)
%r43 = trunc i128 %r42 to i64
%r44 = call i64 @extractHigh64(i128 %r42)
%r46 = call i128 @mulPos64x64(i64* %r3, i64 %r4, i64 10)
%r47 = trunc i128 %r46 to i64
%r48 = call i64 @extractHigh64(i128 %r46)
%r50 = call i128 @mulPos64x64(i64* %r3, i64 %r4, i64 11)
%r51 = trunc i128 %r50 to i64
%r52 = call i64 @extractHigh64(i128 %r50)
%r54 = call i128 @mulPos64x64(i64* %r3, i64 %r4, i64 12)
%r55 = trunc i128 %r54 to i64
%r56 = call i64 @extractHigh64(i128 %r54)
%r58 = call i128 @mulPos64x64(i64* %r3, i64 %r4, i64 13)
%r59 = trunc i128 %r58 to i64
%r60 = call i64 @extractHigh64(i128 %r58)
%r62 = call i128 @mulPos64x64(i64* %r3, i64 %r4, i64 14)
%r63 = trunc i128 %r62 to i64
%r64 = call i64 @extractHigh64(i128 %r62)
%r66 = call i128 @mulPos64x64(i64* %r3, i64 %r4, i64 15)
%r67 = trunc i128 %r66 to i64
%r68 = call i64 @extractHigh64(i128 %r66)
%r69 = zext i64 %r7 to i128
%r70 = zext i64 %r11 to i128
%r71 = shl i128 %r70, 64
%r72 = or i128 %r69, %r71
%r73 = zext i128 %r72 to i192
%r74 = zext i64 %r15 to i192
%r75 = shl i192 %r74, 128
%r76 = or i192 %r73, %r75
%r77 = zext i192 %r76 to i256
%r78 = zext i64 %r19 to i256
%r79 = shl i256 %r78, 192
%r80 = or i256 %r77, %r79
%r81 = zext i256 %r80 to i320
%r82 = zext i64 %r23 to i320
%r83 = shl i320 %r82, 256
%r84 = or i320 %r81, %r83
%r85 = zext i320 %r84 to i384
%r86 = zext i64 %r27 to i384
%r87 = shl i384 %r86, 320
%r88 = or i384 %r85, %r87
%r89 = zext i384 %r88 to i448
%r90 = zext i64 %r31 to i448
%r91 = shl i448 %r90, 384
%r92 = or i448 %r89, %r91
%r93 = zext i448 %r92 to i512
%r94 = zext i64 %r35 to i512
%r95 = shl i512 %r94, 448
%r96 = or i512 %r93, %r95
%r97 = zext i512 %r96 to i576
%r98 = zext i64 %r39 to i576
%r99 = shl i576 %r98, 512
%r100 = or i576 %r97, %r99
%r101 = zext i576 %r100 to i640
%r102 = zext i64 %r43 to i640
%r103 = shl i640 %r102, 576
%r104 = or i640 %r101, %r103
%r105 = zext i640 %r104 to i704
%r106 = zext i64 %r47 to i704
%r107 = shl i704 %r106, 640
%r108 = or i704 %r105, %r107
%r109 = zext i704 %r108 to i768
%r110 = zext i64 %r51 to i768
%r111 = shl i768 %r110, 704
%r112 = or i768 %r109, %r111
%r113 = zext i768 %r112 to i832
%r114 = zext i64 %r55 to i832
%r115 = shl i832 %r114, 768
%r116 = or i832 %r113, %r115
%r117 = zext i832 %r116 to i896
%r118 = zext i64 %r59 to i896
%r119 = shl i896 %r118, 832
%r120 = or i896 %r117, %r119
%r121 = zext i896 %r120 to i960
%r122 = zext i64 %r63 to i960
%r123 = shl i960 %r122, 896
%r124 = or i960 %r121, %r123
%r125 = zext i960 %r124 to i1024
%r126 = zext i64 %r67 to i1024
%r127 = shl i1024 %r126, 960
%r128 = or i1024 %r125, %r127
%r129 = zext i64 %r8 to i128
%r130 = zext i64 %r12 to i128
%r131 = shl i128 %r130, 64
%r132 = or i128 %r129, %r131
%r133 = zext i128 %r132 to i192
%r134 = zext i64 %r16 to i192
%r135 = shl i192 %r134, 128
%r136 = or i192 %r133, %r135
%r137 = zext i192 %r136 to i256
%r138 = zext i64 %r20 to i256
%r139 = shl i256 %r138, 192
%r140 = or i256 %r137, %r139
%r141 = zext i256 %r140 to i320
%r142 = zext i64 %r24 to i320
%r143 = shl i320 %r142, 256
%r144 = or i320 %r141, %r143
%r145 = zext i320 %r144 to i384
%r146 = zext i64 %r28 to i384
%r147 = shl i384 %r146, 320
%r148 = or i384 %r145, %r147
%r149 = zext i384 %r148 to i448
%r150 = zext i64 %r32 to i448
%r151 = shl i448 %r150, 384
%r152 = or i448 %r149, %r151
%r153 = zext i448 %r152 to i512
%r154 = zext i64 %r36 to i512
%r155 = shl i512 %r154, 448
%r156 = or i512 %r153, %r155
%r157 = zext i512 %r156 to i576
%r158 = zext i64 %r40 to i576
%r159 = shl i576 %r158, 512
%r160 = or i576 %r157, %r159
%r161 = zext i576 %r160 to i640
%r162 = zext i64 %r44 to i640
%r163 = shl i640 %r162, 576
%r164 = or i640 %r161, %r163
%r165 = zext i640 %r164 to i704
%r166 = zext i64 %r48 to i704
%r167 = shl i704 %r166, 640
%r168 = or i704 %r165, %r167
%r169 = zext i704 %r168 to i768
%r170 = zext i64 %r52 to i768
%r171 = shl i768 %r170, 704
%r172 = or i768 %r169, %r171
%r173 = zext i768 %r172 to i832
%r174 = zext i64 %r56 to i832
%r175 = shl i832 %r174, 768
%r176 = or i832 %r173, %r175
%r177 = zext i832 %r176 to i896
%r178 = zext i64 %r60 to i896
%r179 = shl i896 %r178, 832
%r180 = or i896 %r177, %r179
%r181 = zext i896 %r180 to i960
%r182 = zext i64 %r64 to i960
%r183 = shl i960 %r182, 896
%r184 = or i960 %r181, %r183
%r185 = zext i960 %r184 to i1024
%r186 = zext i64 %r68 to i1024
%r187 = shl i1024 %r186, 960
%r188 = or i1024 %r185, %r187
%r189 = zext i1024 %r128 to i1088
%r190 = zext i1024 %r188 to i1088
%r191 = shl i1088 %r190, 64
%r192 = add i1088 %r189, %r191
%r194 = bitcast i64* %r2 to i1024*
%r195 = load i1024, i1024* %r194
%r196 = zext i1024 %r195 to i1088
%r197 = add i1088 %r192, %r196
%r198 = trunc i1088 %r197 to i1024
%r200 = getelementptr i64, i64* %r2, i32 0
%r201 = trunc i1024 %r198 to i64
store i64 %r201, i64* %r200
%r202 = lshr i1024 %r198, 64
%r204 = getelementptr i64, i64* %r2, i32 1
%r205 = trunc i1024 %r202 to i64
store i64 %r205, i64* %r204
%r206 = lshr i1024 %r202, 64
%r208 = getelementptr i64, i64* %r2, i32 2
%r209 = trunc i1024 %r206 to i64
store i64 %r209, i64* %r208
%r210 = lshr i1024 %r206, 64
%r212 = getelementptr i64, i64* %r2, i32 3
%r213 = trunc i1024 %r210 to i64
store i64 %r213, i64* %r212
%r214 = lshr i1024 %r210, 64
%r216 = getelementptr i64, i64* %r2, i32 4
%r217 = trunc i1024 %r214 to i64
store i64 %r217, i64* %r216
%r218 = lshr i1024 %r214, 64
%r220 = getelementptr i64, i64* %r2, i32 5
%r221 = trunc i1024 %r218 to i64
store i64 %r221, i64* %r220
%r222 = lshr i1024 %r218, 64
%r224 = getelementptr i64, i64* %r2, i32 6
%r225 = trunc i1024 %r222 to i64
store i64 %r225, i64* %r224
%r226 = lshr i1024 %r222, 64
%r228 = getelementptr i64, i64* %r2, i32 7
%r229 = trunc i1024 %r226 to i64
store i64 %r229, i64* %r228
%r230 = lshr i1024 %r226, 64
%r232 = getelementptr i64, i64* %r2, i32 8
%r233 = trunc i1024 %r230 to i64
store i64 %r233, i64* %r232
%r234 = lshr i1024 %r230, 64
%r236 = getelementptr i64, i64* %r2, i32 9
%r237 = trunc i1024 %r234 to i64
store i64 %r237, i64* %r236
%r238 = lshr i1024 %r234, 64
%r240 = getelementptr i64, i64* %r2, i32 10
%r241 = trunc i1024 %r238 to i64
store i64 %r241, i64* %r240
%r242 = lshr i1024 %r238, 64
%r244 = getelementptr i64, i64* %r2, i32 11
%r245 = trunc i1024 %r242 to i64
store i64 %r245, i64* %r244
%r246 = lshr i1024 %r242, 64
%r248 = getelementptr i64, i64* %r2, i32 12
%r249 = trunc i1024 %r246 to i64
store i64 %r249, i64* %r248
%r250 = lshr i1024 %r246, 64
%r252 = getelementptr i64, i64* %r2, i32 13
%r253 = trunc i1024 %r250 to i64
store i64 %r253, i64* %r252
%r254 = lshr i1024 %r250, 64
%r256 = getelementptr i64, i64* %r2, i32 14
%r257 = trunc i1024 %r254 to i64
store i64 %r257, i64* %r256
%r258 = lshr i1024 %r254, 64
%r260 = getelementptr i64, i64* %r2, i32 15
%r261 = trunc i1024 %r258 to i64
store i64 %r261, i64* %r260
%r262 = lshr i1088 %r197, 1024
%r263 = trunc i1088 %r262 to i64
ret i64 %r263
}
define void @mclb_mul16(i64* noalias  %r1, i64* noalias  %r2, i64* noalias  %r3)
{
%r5 = getelementptr i64, i64* %r2, i32 8
%r7 = getelementptr i64, i64* %r3, i32 8
%r9 = getelementptr i64, i64* %r1, i32 16
call void @mclb_mul8(i64* %r1, i64* %r2, i64* %r3)
call void @mclb_mul8(i64* %r9, i64* %r5, i64* %r7)
%r11 = bitcast i64* %r5 to i512*
%r12 = load i512, i512* %r11
%r13 = zext i512 %r12 to i576
%r15 = bitcast i64* %r2 to i512*
%r16 = load i512, i512* %r15
%r17 = zext i512 %r16 to i576
%r19 = bitcast i64* %r7 to i512*
%r20 = load i512, i512* %r19
%r21 = zext i512 %r20 to i576
%r23 = bitcast i64* %r3 to i512*
%r24 = load i512, i512* %r23
%r25 = zext i512 %r24 to i576
%r26 = add i576 %r13, %r17
%r27 = add i576 %r21, %r25
%r29 = alloca i64, i32 16
%r30 = trunc i576 %r26 to i512
%r31 = trunc i576 %r27 to i512
%r32 = lshr i576 %r26, 512
%r33 = trunc i576 %r32 to i1
%r34 = lshr i576 %r27, 512
%r35 = trunc i576 %r34 to i1
%r36 = and i1 %r33, %r35
%r38 = select i1 %r33, i512 %r31, i512 0
%r40 = select i1 %r35, i512 %r30, i512 0
%r42 = alloca i64, i32 8
%r44 = alloca i64, i32 8
%r46 = getelementptr i64, i64* %r42, i32 0
%r47 = trunc i512 %r30 to i64
store i64 %r47, i64* %r46
%r48 = lshr i512 %r30, 64
%r50 = getelementptr i64, i64* %r42, i32 1
%r51 = trunc i512 %r48 to i64
store i64 %r51, i64* %r50
%r52 = lshr i512 %r48, 64
%r54 = getelementptr i64, i64* %r42, i32 2
%r55 = trunc i512 %r52 to i64
store i64 %r55, i64* %r54
%r56 = lshr i512 %r52, 64
%r58 = getelementptr i64, i64* %r42, i32 3
%r59 = trunc i512 %r56 to i64
store i64 %r59, i64* %r58
%r60 = lshr i512 %r56, 64
%r62 = getelementptr i64, i64* %r42, i32 4
%r63 = trunc i512 %r60 to i64
store i64 %r63, i64* %r62
%r64 = lshr i512 %r60, 64
%r66 = getelementptr i64, i64* %r42, i32 5
%r67 = trunc i512 %r64 to i64
store i64 %r67, i64* %r66
%r68 = lshr i512 %r64, 64
%r70 = getelementptr i64, i64* %r42, i32 6
%r71 = trunc i512 %r68 to i64
store i64 %r71, i64* %r70
%r72 = lshr i512 %r68, 64
%r74 = getelementptr i64, i64* %r42, i32 7
%r75 = trunc i512 %r72 to i64
store i64 %r75, i64* %r74
%r77 = getelementptr i64, i64* %r44, i32 0
%r78 = trunc i512 %r31 to i64
store i64 %r78, i64* %r77
%r79 = lshr i512 %r31, 64
%r81 = getelementptr i64, i64* %r44, i32 1
%r82 = trunc i512 %r79 to i64
store i64 %r82, i64* %r81
%r83 = lshr i512 %r79, 64
%r85 = getelementptr i64, i64* %r44, i32 2
%r86 = trunc i512 %r83 to i64
store i64 %r86, i64* %r85
%r87 = lshr i512 %r83, 64
%r89 = getelementptr i64, i64* %r44, i32 3
%r90 = trunc i512 %r87 to i64
store i64 %r90, i64* %r89
%r91 = lshr i512 %r87, 64
%r93 = getelementptr i64, i64* %r44, i32 4
%r94 = trunc i512 %r91 to i64
store i64 %r94, i64* %r93
%r95 = lshr i512 %r91, 64
%r97 = getelementptr i64, i64* %r44, i32 5
%r98 = trunc i512 %r95 to i64
store i64 %r98, i64* %r97
%r99 = lshr i512 %r95, 64
%r101 = getelementptr i64, i64* %r44, i32 6
%r102 = trunc i512 %r99 to i64
store i64 %r102, i64* %r101
%r103 = lshr i512 %r99, 64
%r105 = getelementptr i64, i64* %r44, i32 7
%r106 = trunc i512 %r103 to i64
store i64 %r106, i64* %r105
call void @mclb_mul8(i64* %r29, i64* %r42, i64* %r44)
%r108 = bitcast i64* %r29 to i1024*
%r109 = load i1024, i1024* %r108
%r110 = zext i1024 %r109 to i1088
%r111 = zext i1 %r36 to i1088
%r112 = shl i1088 %r111, 1024
%r113 = or i1088 %r110, %r112
%r114 = zext i512 %r38 to i1088
%r115 = zext i512 %r40 to i1088
%r116 = shl i1088 %r114, 512
%r117 = shl i1088 %r115, 512
%r118 = add i1088 %r113, %r116
%r119 = add i1088 %r118, %r117
%r121 = bitcast i64* %r1 to i1024*
%r122 = load i1024, i1024* %r121
%r123 = zext i1024 %r122 to i1088
%r124 = sub i1088 %r119, %r123
%r126 = getelementptr i64, i64* %r1, i32 16
%r128 = bitcast i64* %r126 to i1024*
%r129 = load i1024, i1024* %r128
%r130 = zext i1024 %r129 to i1088
%r131 = sub i1088 %r124, %r130
%r132 = zext i1088 %r131 to i1536
%r134 = getelementptr i64, i64* %r1, i32 8
%r136 = bitcast i64* %r134 to i1536*
%r137 = load i1536, i1536* %r136
%r138 = add i1536 %r132, %r137
%r140 = getelementptr i64, i64* %r1, i32 8
%r142 = getelementptr i64, i64* %r140, i32 0
%r143 = trunc i1536 %r138 to i64
store i64 %r143, i64* %r142
%r144 = lshr i1536 %r138, 64
%r146 = getelementptr i64, i64* %r140, i32 1
%r147 = trunc i1536 %r144 to i64
store i64 %r147, i64* %r146
%r148 = lshr i1536 %r144, 64
%r150 = getelementptr i64, i64* %r140, i32 2
%r151 = trunc i1536 %r148 to i64
store i64 %r151, i64* %r150
%r152 = lshr i1536 %r148, 64
%r154 = getelementptr i64, i64* %r140, i32 3
%r155 = trunc i1536 %r152 to i64
store i64 %r155, i64* %r154
%r156 = lshr i1536 %r152, 64
%r158 = getelementptr i64, i64* %r140, i32 4
%r159 = trunc i1536 %r156 to i64
store i64 %r159, i64* %r158
%r160 = lshr i1536 %r156, 64
%r162 = getelementptr i64, i64* %r140, i32 5
%r163 = trunc i1536 %r160 to i64
store i64 %r163, i64* %r162
%r164 = lshr i1536 %r160, 64
%r166 = getelementptr i64, i64* %r140, i32 6
%r167 = trunc i1536 %r164 to i64
store i64 %r167, i64* %r166
%r168 = lshr i1536 %r164, 64
%r170 = getelementptr i64, i64* %r140, i32 7
%r171 = trunc i1536 %r168 to i64
store i64 %r171, i64* %r170
%r172 = lshr i1536 %r168, 64
%r174 = getelementptr i64, i64* %r140, i32 8
%r175 = trunc i1536 %r172 to i64
store i64 %r175, i64* %r174
%r176 = lshr i1536 %r172, 64
%r178 = getelementptr i64, i64* %r140, i32 9
%r179 = trunc i1536 %r176 to i64
store i64 %r179, i64* %r178
%r180 = lshr i1536 %r176, 64
%r182 = getelementptr i64, i64* %r140, i32 10
%r183 = trunc i1536 %r180 to i64
store i64 %r183, i64* %r182
%r184 = lshr i1536 %r180, 64
%r186 = getelementptr i64, i64* %r140, i32 11
%r187 = trunc i1536 %r184 to i64
store i64 %r187, i64* %r186
%r188 = lshr i1536 %r184, 64
%r190 = getelementptr i64, i64* %r140, i32 12
%r191 = trunc i1536 %r188 to i64
store i64 %r191, i64* %r190
%r192 = lshr i1536 %r188, 64
%r194 = getelementptr i64, i64* %r140, i32 13
%r195 = trunc i1536 %r192 to i64
store i64 %r195, i64* %r194
%r196 = lshr i1536 %r192, 64
%r198 = getelementptr i64, i64* %r140, i32 14
%r199 = trunc i1536 %r196 to i64
store i64 %r199, i64* %r198
%r200 = lshr i1536 %r196, 64
%r202 = getelementptr i64, i64* %r140, i32 15
%r203 = trunc i1536 %r200 to i64
store i64 %r203, i64* %r202
%r204 = lshr i1536 %r200, 64
%r206 = getelementptr i64, i64* %r140, i32 16
%r207 = trunc i1536 %r204 to i64
store i64 %r207, i64* %r206
%r208 = lshr i1536 %r204, 64
%r210 = getelementptr i64, i64* %r140, i32 17
%r211 = trunc i1536 %r208 to i64
store i64 %r211, i64* %r210
%r212 = lshr i1536 %r208, 64
%r214 = getelementptr i64, i64* %r140, i32 18
%r215 = trunc i1536 %r212 to i64
store i64 %r215, i64* %r214
%r216 = lshr i1536 %r212, 64
%r218 = getelementptr i64, i64* %r140, i32 19
%r219 = trunc i1536 %r216 to i64
store i64 %r219, i64* %r218
%r220 = lshr i1536 %r216, 64
%r222 = getelementptr i64, i64* %r140, i32 20
%r223 = trunc i1536 %r220 to i64
store i64 %r223, i64* %r222
%r224 = lshr i1536 %r220, 64
%r226 = getelementptr i64, i64* %r140, i32 21
%r227 = trunc i1536 %r224 to i64
store i64 %r227, i64* %r226
%r228 = lshr i1536 %r224, 64
%r230 = getelementptr i64, i64* %r140, i32 22
%r231 = trunc i1536 %r228 to i64
store i64 %r231, i64* %r230
%r232 = lshr i1536 %r228, 64
%r234 = getelementptr i64, i64* %r140, i32 23
%r235 = trunc i1536 %r232 to i64
store i64 %r235, i64* %r234
ret void
}
define void @mclb_sqr16(i64* noalias  %r1, i64* noalias  %r2)
{
%r4 = getelementptr i64, i64* %r2, i32 8
%r6 = getelementptr i64, i64* %r1, i32 16
%r8 = alloca i64, i32 16
call void @mclb_mul8(i64* %r8, i64* %r2, i64* %r4)
call void @mclb_sqr8(i64* %r1, i64* %r2)
call void @mclb_sqr8(i64* %r6, i64* %r4)
%r10 = bitcast i64* %r8 to i1024*
%r11 = load i1024, i1024* %r10
%r12 = zext i1024 %r11 to i1088
%r13 = add i1088 %r12, %r12
%r14 = zext i1088 %r13 to i1536
%r16 = getelementptr i64, i64* %r1, i32 8
%r18 = bitcast i64* %r16 to i1536*
%r19 = load i1536, i1536* %r18
%r20 = add i1536 %r19, %r14
%r22 = getelementptr i64, i64* %r16, i32 0
%r23 = trunc i1536 %r20 to i64
store i64 %r23, i64* %r22
%r24 = lshr i1536 %r20, 64
%r26 = getelementptr i64, i64* %r16, i32 1
%r27 = trunc i1536 %r24 to i64
store i64 %r27, i64* %r26
%r28 = lshr i1536 %r24, 64
%r30 = getelementptr i64, i64* %r16, i32 2
%r31 = trunc i1536 %r28 to i64
store i64 %r31, i64* %r30
%r32 = lshr i1536 %r28, 64
%r34 = getelementptr i64, i64* %r16, i32 3
%r35 = trunc i1536 %r32 to i64
store i64 %r35, i64* %r34
%r36 = lshr i1536 %r32, 64
%r38 = getelementptr i64, i64* %r16, i32 4
%r39 = trunc i1536 %r36 to i64
store i64 %r39, i64* %r38
%r40 = lshr i1536 %r36, 64
%r42 = getelementptr i64, i64* %r16, i32 5
%r43 = trunc i1536 %r40 to i64
store i64 %r43, i64* %r42
%r44 = lshr i1536 %r40, 64
%r46 = getelementptr i64, i64* %r16, i32 6
%r47 = trunc i1536 %r44 to i64
store i64 %r47, i64* %r46
%r48 = lshr i1536 %r44, 64
%r50 = getelementptr i64, i64* %r16, i32 7
%r51 = trunc i1536 %r48 to i64
store i64 %r51, i64* %r50
%r52 = lshr i1536 %r48, 64
%r54 = getelementptr i64, i64* %r16, i32 8
%r55 = trunc i1536 %r52 to i64
store i64 %r55, i64* %r54
%r56 = lshr i1536 %r52, 64
%r58 = getelementptr i64, i64* %r16, i32 9
%r59 = trunc i1536 %r56 to i64
store i64 %r59, i64* %r58
%r60 = lshr i1536 %r56, 64
%r62 = getelementptr i64, i64* %r16, i32 10
%r63 = trunc i1536 %r60 to i64
store i64 %r63, i64* %r62
%r64 = lshr i1536 %r60, 64
%r66 = getelementptr i64, i64* %r16, i32 11
%r67 = trunc i1536 %r64 to i64
store i64 %r67, i64* %r66
%r68 = lshr i1536 %r64, 64
%r70 = getelementptr i64, i64* %r16, i32 12
%r71 = trunc i1536 %r68 to i64
store i64 %r71, i64* %r70
%r72 = lshr i1536 %r68, 64
%r74 = getelementptr i64, i64* %r16, i32 13
%r75 = trunc i1536 %r72 to i64
store i64 %r75, i64* %r74
%r76 = lshr i1536 %r72, 64
%r78 = getelementptr i64, i64* %r16, i32 14
%r79 = trunc i1536 %r76 to i64
store i64 %r79, i64* %r78
%r80 = lshr i1536 %r76, 64
%r82 = getelementptr i64, i64* %r16, i32 15
%r83 = trunc i1536 %r80 to i64
store i64 %r83, i64* %r82
%r84 = lshr i1536 %r80, 64
%r86 = getelementptr i64, i64* %r16, i32 16
%r87 = trunc i1536 %r84 to i64
store i64 %r87, i64* %r86
%r88 = lshr i1536 %r84, 64
%r90 = getelementptr i64, i64* %r16, i32 17
%r91 = trunc i1536 %r88 to i64
store i64 %r91, i64* %r90
%r92 = lshr i1536 %r88, 64
%r94 = getelementptr i64, i64* %r16, i32 18
%r95 = trunc i1536 %r92 to i64
store i64 %r95, i64* %r94
%r96 = lshr i1536 %r92, 64
%r98 = getelementptr i64, i64* %r16, i32 19
%r99 = trunc i1536 %r96 to i64
store i64 %r99, i64* %r98
%r100 = lshr i1536 %r96, 64
%r102 = getelementptr i64, i64* %r16, i32 20
%r103 = trunc i1536 %r100 to i64
store i64 %r103, i64* %r102
%r104 = lshr i1536 %r100, 64
%r106 = getelementptr i64, i64* %r16, i32 21
%r107 = trunc i1536 %r104 to i64
store i64 %r107, i64* %r106
%r108 = lshr i1536 %r104, 64
%r110 = getelementptr i64, i64* %r16, i32 22
%r111 = trunc i1536 %r108 to i64
store i64 %r111, i64* %r110
%r112 = lshr i1536 %r108, 64
%r114 = getelementptr i64, i64* %r16, i32 23
%r115 = trunc i1536 %r112 to i64
store i64 %r115, i64* %r114
ret void
}
define private i1024 @mulUnit2_inner1024(i64* noalias  %r2, i64 %r3)
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
%r41 = call i128 @mulPos64x64(i64* %r2, i64 %r3, i64 9)
%r42 = trunc i128 %r41 to i64
%r43 = call i64 @extractHigh64(i128 %r41)
%r45 = call i128 @mulPos64x64(i64* %r2, i64 %r3, i64 10)
%r46 = trunc i128 %r45 to i64
%r47 = call i64 @extractHigh64(i128 %r45)
%r49 = call i128 @mulPos64x64(i64* %r2, i64 %r3, i64 11)
%r50 = trunc i128 %r49 to i64
%r51 = call i64 @extractHigh64(i128 %r49)
%r53 = call i128 @mulPos64x64(i64* %r2, i64 %r3, i64 12)
%r54 = trunc i128 %r53 to i64
%r55 = call i64 @extractHigh64(i128 %r53)
%r57 = call i128 @mulPos64x64(i64* %r2, i64 %r3, i64 13)
%r58 = trunc i128 %r57 to i64
%r59 = call i64 @extractHigh64(i128 %r57)
%r61 = call i128 @mulPos64x64(i64* %r2, i64 %r3, i64 14)
%r62 = trunc i128 %r61 to i64
%r63 = call i64 @extractHigh64(i128 %r61)
%r65 = call i128 @mulPos64x64(i64* %r2, i64 %r3, i64 15)
%r66 = trunc i128 %r65 to i64
%r67 = zext i64 %r6 to i128
%r68 = zext i64 %r10 to i128
%r69 = shl i128 %r68, 64
%r70 = or i128 %r67, %r69
%r71 = zext i128 %r70 to i192
%r72 = zext i64 %r14 to i192
%r73 = shl i192 %r72, 128
%r74 = or i192 %r71, %r73
%r75 = zext i192 %r74 to i256
%r76 = zext i64 %r18 to i256
%r77 = shl i256 %r76, 192
%r78 = or i256 %r75, %r77
%r79 = zext i256 %r78 to i320
%r80 = zext i64 %r22 to i320
%r81 = shl i320 %r80, 256
%r82 = or i320 %r79, %r81
%r83 = zext i320 %r82 to i384
%r84 = zext i64 %r26 to i384
%r85 = shl i384 %r84, 320
%r86 = or i384 %r83, %r85
%r87 = zext i384 %r86 to i448
%r88 = zext i64 %r30 to i448
%r89 = shl i448 %r88, 384
%r90 = or i448 %r87, %r89
%r91 = zext i448 %r90 to i512
%r92 = zext i64 %r34 to i512
%r93 = shl i512 %r92, 448
%r94 = or i512 %r91, %r93
%r95 = zext i512 %r94 to i576
%r96 = zext i64 %r38 to i576
%r97 = shl i576 %r96, 512
%r98 = or i576 %r95, %r97
%r99 = zext i576 %r98 to i640
%r100 = zext i64 %r42 to i640
%r101 = shl i640 %r100, 576
%r102 = or i640 %r99, %r101
%r103 = zext i640 %r102 to i704
%r104 = zext i64 %r46 to i704
%r105 = shl i704 %r104, 640
%r106 = or i704 %r103, %r105
%r107 = zext i704 %r106 to i768
%r108 = zext i64 %r50 to i768
%r109 = shl i768 %r108, 704
%r110 = or i768 %r107, %r109
%r111 = zext i768 %r110 to i832
%r112 = zext i64 %r54 to i832
%r113 = shl i832 %r112, 768
%r114 = or i832 %r111, %r113
%r115 = zext i832 %r114 to i896
%r116 = zext i64 %r58 to i896
%r117 = shl i896 %r116, 832
%r118 = or i896 %r115, %r117
%r119 = zext i896 %r118 to i960
%r120 = zext i64 %r62 to i960
%r121 = shl i960 %r120, 896
%r122 = or i960 %r119, %r121
%r123 = zext i960 %r122 to i1024
%r124 = zext i64 %r66 to i1024
%r125 = shl i1024 %r124, 960
%r126 = or i1024 %r123, %r125
%r127 = zext i64 %r7 to i128
%r128 = zext i64 %r11 to i128
%r129 = shl i128 %r128, 64
%r130 = or i128 %r127, %r129
%r131 = zext i128 %r130 to i192
%r132 = zext i64 %r15 to i192
%r133 = shl i192 %r132, 128
%r134 = or i192 %r131, %r133
%r135 = zext i192 %r134 to i256
%r136 = zext i64 %r19 to i256
%r137 = shl i256 %r136, 192
%r138 = or i256 %r135, %r137
%r139 = zext i256 %r138 to i320
%r140 = zext i64 %r23 to i320
%r141 = shl i320 %r140, 256
%r142 = or i320 %r139, %r141
%r143 = zext i320 %r142 to i384
%r144 = zext i64 %r27 to i384
%r145 = shl i384 %r144, 320
%r146 = or i384 %r143, %r145
%r147 = zext i384 %r146 to i448
%r148 = zext i64 %r31 to i448
%r149 = shl i448 %r148, 384
%r150 = or i448 %r147, %r149
%r151 = zext i448 %r150 to i512
%r152 = zext i64 %r35 to i512
%r153 = shl i512 %r152, 448
%r154 = or i512 %r151, %r153
%r155 = zext i512 %r154 to i576
%r156 = zext i64 %r39 to i576
%r157 = shl i576 %r156, 512
%r158 = or i576 %r155, %r157
%r159 = zext i576 %r158 to i640
%r160 = zext i64 %r43 to i640
%r161 = shl i640 %r160, 576
%r162 = or i640 %r159, %r161
%r163 = zext i640 %r162 to i704
%r164 = zext i64 %r47 to i704
%r165 = shl i704 %r164, 640
%r166 = or i704 %r163, %r165
%r167 = zext i704 %r166 to i768
%r168 = zext i64 %r51 to i768
%r169 = shl i768 %r168, 704
%r170 = or i768 %r167, %r169
%r171 = zext i768 %r170 to i832
%r172 = zext i64 %r55 to i832
%r173 = shl i832 %r172, 768
%r174 = or i832 %r171, %r173
%r175 = zext i832 %r174 to i896
%r176 = zext i64 %r59 to i896
%r177 = shl i896 %r176, 832
%r178 = or i896 %r175, %r177
%r179 = zext i896 %r178 to i960
%r180 = zext i64 %r63 to i960
%r181 = shl i960 %r180, 896
%r182 = or i960 %r179, %r181
%r183 = zext i960 %r182 to i1024
%r184 = shl i1024 %r183, 64
%r185 = add i1024 %r126, %r184
ret i1024 %r185
}
define i1152 @mulUnit_inner1088(i64* noalias  %r2, i64 %r3)
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
%r41 = call i128 @mulPos64x64(i64* %r2, i64 %r3, i64 9)
%r42 = trunc i128 %r41 to i64
%r43 = call i64 @extractHigh64(i128 %r41)
%r45 = call i128 @mulPos64x64(i64* %r2, i64 %r3, i64 10)
%r46 = trunc i128 %r45 to i64
%r47 = call i64 @extractHigh64(i128 %r45)
%r49 = call i128 @mulPos64x64(i64* %r2, i64 %r3, i64 11)
%r50 = trunc i128 %r49 to i64
%r51 = call i64 @extractHigh64(i128 %r49)
%r53 = call i128 @mulPos64x64(i64* %r2, i64 %r3, i64 12)
%r54 = trunc i128 %r53 to i64
%r55 = call i64 @extractHigh64(i128 %r53)
%r57 = call i128 @mulPos64x64(i64* %r2, i64 %r3, i64 13)
%r58 = trunc i128 %r57 to i64
%r59 = call i64 @extractHigh64(i128 %r57)
%r61 = call i128 @mulPos64x64(i64* %r2, i64 %r3, i64 14)
%r62 = trunc i128 %r61 to i64
%r63 = call i64 @extractHigh64(i128 %r61)
%r65 = call i128 @mulPos64x64(i64* %r2, i64 %r3, i64 15)
%r66 = trunc i128 %r65 to i64
%r67 = call i64 @extractHigh64(i128 %r65)
%r69 = call i128 @mulPos64x64(i64* %r2, i64 %r3, i64 16)
%r70 = trunc i128 %r69 to i64
%r71 = call i64 @extractHigh64(i128 %r69)
%r72 = zext i64 %r6 to i128
%r73 = zext i64 %r10 to i128
%r74 = shl i128 %r73, 64
%r75 = or i128 %r72, %r74
%r76 = zext i128 %r75 to i192
%r77 = zext i64 %r14 to i192
%r78 = shl i192 %r77, 128
%r79 = or i192 %r76, %r78
%r80 = zext i192 %r79 to i256
%r81 = zext i64 %r18 to i256
%r82 = shl i256 %r81, 192
%r83 = or i256 %r80, %r82
%r84 = zext i256 %r83 to i320
%r85 = zext i64 %r22 to i320
%r86 = shl i320 %r85, 256
%r87 = or i320 %r84, %r86
%r88 = zext i320 %r87 to i384
%r89 = zext i64 %r26 to i384
%r90 = shl i384 %r89, 320
%r91 = or i384 %r88, %r90
%r92 = zext i384 %r91 to i448
%r93 = zext i64 %r30 to i448
%r94 = shl i448 %r93, 384
%r95 = or i448 %r92, %r94
%r96 = zext i448 %r95 to i512
%r97 = zext i64 %r34 to i512
%r98 = shl i512 %r97, 448
%r99 = or i512 %r96, %r98
%r100 = zext i512 %r99 to i576
%r101 = zext i64 %r38 to i576
%r102 = shl i576 %r101, 512
%r103 = or i576 %r100, %r102
%r104 = zext i576 %r103 to i640
%r105 = zext i64 %r42 to i640
%r106 = shl i640 %r105, 576
%r107 = or i640 %r104, %r106
%r108 = zext i640 %r107 to i704
%r109 = zext i64 %r46 to i704
%r110 = shl i704 %r109, 640
%r111 = or i704 %r108, %r110
%r112 = zext i704 %r111 to i768
%r113 = zext i64 %r50 to i768
%r114 = shl i768 %r113, 704
%r115 = or i768 %r112, %r114
%r116 = zext i768 %r115 to i832
%r117 = zext i64 %r54 to i832
%r118 = shl i832 %r117, 768
%r119 = or i832 %r116, %r118
%r120 = zext i832 %r119 to i896
%r121 = zext i64 %r58 to i896
%r122 = shl i896 %r121, 832
%r123 = or i896 %r120, %r122
%r124 = zext i896 %r123 to i960
%r125 = zext i64 %r62 to i960
%r126 = shl i960 %r125, 896
%r127 = or i960 %r124, %r126
%r128 = zext i960 %r127 to i1024
%r129 = zext i64 %r66 to i1024
%r130 = shl i1024 %r129, 960
%r131 = or i1024 %r128, %r130
%r132 = zext i1024 %r131 to i1088
%r133 = zext i64 %r70 to i1088
%r134 = shl i1088 %r133, 1024
%r135 = or i1088 %r132, %r134
%r136 = zext i64 %r7 to i128
%r137 = zext i64 %r11 to i128
%r138 = shl i128 %r137, 64
%r139 = or i128 %r136, %r138
%r140 = zext i128 %r139 to i192
%r141 = zext i64 %r15 to i192
%r142 = shl i192 %r141, 128
%r143 = or i192 %r140, %r142
%r144 = zext i192 %r143 to i256
%r145 = zext i64 %r19 to i256
%r146 = shl i256 %r145, 192
%r147 = or i256 %r144, %r146
%r148 = zext i256 %r147 to i320
%r149 = zext i64 %r23 to i320
%r150 = shl i320 %r149, 256
%r151 = or i320 %r148, %r150
%r152 = zext i320 %r151 to i384
%r153 = zext i64 %r27 to i384
%r154 = shl i384 %r153, 320
%r155 = or i384 %r152, %r154
%r156 = zext i384 %r155 to i448
%r157 = zext i64 %r31 to i448
%r158 = shl i448 %r157, 384
%r159 = or i448 %r156, %r158
%r160 = zext i448 %r159 to i512
%r161 = zext i64 %r35 to i512
%r162 = shl i512 %r161, 448
%r163 = or i512 %r160, %r162
%r164 = zext i512 %r163 to i576
%r165 = zext i64 %r39 to i576
%r166 = shl i576 %r165, 512
%r167 = or i576 %r164, %r166
%r168 = zext i576 %r167 to i640
%r169 = zext i64 %r43 to i640
%r170 = shl i640 %r169, 576
%r171 = or i640 %r168, %r170
%r172 = zext i640 %r171 to i704
%r173 = zext i64 %r47 to i704
%r174 = shl i704 %r173, 640
%r175 = or i704 %r172, %r174
%r176 = zext i704 %r175 to i768
%r177 = zext i64 %r51 to i768
%r178 = shl i768 %r177, 704
%r179 = or i768 %r176, %r178
%r180 = zext i768 %r179 to i832
%r181 = zext i64 %r55 to i832
%r182 = shl i832 %r181, 768
%r183 = or i832 %r180, %r182
%r184 = zext i832 %r183 to i896
%r185 = zext i64 %r59 to i896
%r186 = shl i896 %r185, 832
%r187 = or i896 %r184, %r186
%r188 = zext i896 %r187 to i960
%r189 = zext i64 %r63 to i960
%r190 = shl i960 %r189, 896
%r191 = or i960 %r188, %r190
%r192 = zext i960 %r191 to i1024
%r193 = zext i64 %r67 to i1024
%r194 = shl i1024 %r193, 960
%r195 = or i1024 %r192, %r194
%r196 = zext i1024 %r195 to i1088
%r197 = zext i64 %r71 to i1088
%r198 = shl i1088 %r197, 1024
%r199 = or i1088 %r196, %r198
%r200 = zext i1088 %r135 to i1152
%r201 = zext i1088 %r199 to i1152
%r202 = shl i1152 %r201, 64
%r203 = add i1152 %r200, %r202
ret i1152 %r203
}
define i64 @mclb_mulUnit17(i64* noalias  %r2, i64* noalias  %r3, i64 %r4)
{
%r5 = call i1152 @mulUnit_inner1088(i64* %r3, i64 %r4)
%r6 = trunc i1152 %r5 to i1088
%r8 = getelementptr i64, i64* %r2, i32 0
%r9 = trunc i1088 %r6 to i64
store i64 %r9, i64* %r8
%r10 = lshr i1088 %r6, 64
%r12 = getelementptr i64, i64* %r2, i32 1
%r13 = trunc i1088 %r10 to i64
store i64 %r13, i64* %r12
%r14 = lshr i1088 %r10, 64
%r16 = getelementptr i64, i64* %r2, i32 2
%r17 = trunc i1088 %r14 to i64
store i64 %r17, i64* %r16
%r18 = lshr i1088 %r14, 64
%r20 = getelementptr i64, i64* %r2, i32 3
%r21 = trunc i1088 %r18 to i64
store i64 %r21, i64* %r20
%r22 = lshr i1088 %r18, 64
%r24 = getelementptr i64, i64* %r2, i32 4
%r25 = trunc i1088 %r22 to i64
store i64 %r25, i64* %r24
%r26 = lshr i1088 %r22, 64
%r28 = getelementptr i64, i64* %r2, i32 5
%r29 = trunc i1088 %r26 to i64
store i64 %r29, i64* %r28
%r30 = lshr i1088 %r26, 64
%r32 = getelementptr i64, i64* %r2, i32 6
%r33 = trunc i1088 %r30 to i64
store i64 %r33, i64* %r32
%r34 = lshr i1088 %r30, 64
%r36 = getelementptr i64, i64* %r2, i32 7
%r37 = trunc i1088 %r34 to i64
store i64 %r37, i64* %r36
%r38 = lshr i1088 %r34, 64
%r40 = getelementptr i64, i64* %r2, i32 8
%r41 = trunc i1088 %r38 to i64
store i64 %r41, i64* %r40
%r42 = lshr i1088 %r38, 64
%r44 = getelementptr i64, i64* %r2, i32 9
%r45 = trunc i1088 %r42 to i64
store i64 %r45, i64* %r44
%r46 = lshr i1088 %r42, 64
%r48 = getelementptr i64, i64* %r2, i32 10
%r49 = trunc i1088 %r46 to i64
store i64 %r49, i64* %r48
%r50 = lshr i1088 %r46, 64
%r52 = getelementptr i64, i64* %r2, i32 11
%r53 = trunc i1088 %r50 to i64
store i64 %r53, i64* %r52
%r54 = lshr i1088 %r50, 64
%r56 = getelementptr i64, i64* %r2, i32 12
%r57 = trunc i1088 %r54 to i64
store i64 %r57, i64* %r56
%r58 = lshr i1088 %r54, 64
%r60 = getelementptr i64, i64* %r2, i32 13
%r61 = trunc i1088 %r58 to i64
store i64 %r61, i64* %r60
%r62 = lshr i1088 %r58, 64
%r64 = getelementptr i64, i64* %r2, i32 14
%r65 = trunc i1088 %r62 to i64
store i64 %r65, i64* %r64
%r66 = lshr i1088 %r62, 64
%r68 = getelementptr i64, i64* %r2, i32 15
%r69 = trunc i1088 %r66 to i64
store i64 %r69, i64* %r68
%r70 = lshr i1088 %r66, 64
%r72 = getelementptr i64, i64* %r2, i32 16
%r73 = trunc i1088 %r70 to i64
store i64 %r73, i64* %r72
%r74 = lshr i1152 %r5, 1088
%r75 = trunc i1152 %r74 to i64
ret i64 %r75
}
define i64 @mclb_mulUnitAdd17(i64* noalias  %r2, i64* noalias  %r3, i64 %r4)
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
%r42 = call i128 @mulPos64x64(i64* %r3, i64 %r4, i64 9)
%r43 = trunc i128 %r42 to i64
%r44 = call i64 @extractHigh64(i128 %r42)
%r46 = call i128 @mulPos64x64(i64* %r3, i64 %r4, i64 10)
%r47 = trunc i128 %r46 to i64
%r48 = call i64 @extractHigh64(i128 %r46)
%r50 = call i128 @mulPos64x64(i64* %r3, i64 %r4, i64 11)
%r51 = trunc i128 %r50 to i64
%r52 = call i64 @extractHigh64(i128 %r50)
%r54 = call i128 @mulPos64x64(i64* %r3, i64 %r4, i64 12)
%r55 = trunc i128 %r54 to i64
%r56 = call i64 @extractHigh64(i128 %r54)
%r58 = call i128 @mulPos64x64(i64* %r3, i64 %r4, i64 13)
%r59 = trunc i128 %r58 to i64
%r60 = call i64 @extractHigh64(i128 %r58)
%r62 = call i128 @mulPos64x64(i64* %r3, i64 %r4, i64 14)
%r63 = trunc i128 %r62 to i64
%r64 = call i64 @extractHigh64(i128 %r62)
%r66 = call i128 @mulPos64x64(i64* %r3, i64 %r4, i64 15)
%r67 = trunc i128 %r66 to i64
%r68 = call i64 @extractHigh64(i128 %r66)
%r70 = call i128 @mulPos64x64(i64* %r3, i64 %r4, i64 16)
%r71 = trunc i128 %r70 to i64
%r72 = call i64 @extractHigh64(i128 %r70)
%r73 = zext i64 %r7 to i128
%r74 = zext i64 %r11 to i128
%r75 = shl i128 %r74, 64
%r76 = or i128 %r73, %r75
%r77 = zext i128 %r76 to i192
%r78 = zext i64 %r15 to i192
%r79 = shl i192 %r78, 128
%r80 = or i192 %r77, %r79
%r81 = zext i192 %r80 to i256
%r82 = zext i64 %r19 to i256
%r83 = shl i256 %r82, 192
%r84 = or i256 %r81, %r83
%r85 = zext i256 %r84 to i320
%r86 = zext i64 %r23 to i320
%r87 = shl i320 %r86, 256
%r88 = or i320 %r85, %r87
%r89 = zext i320 %r88 to i384
%r90 = zext i64 %r27 to i384
%r91 = shl i384 %r90, 320
%r92 = or i384 %r89, %r91
%r93 = zext i384 %r92 to i448
%r94 = zext i64 %r31 to i448
%r95 = shl i448 %r94, 384
%r96 = or i448 %r93, %r95
%r97 = zext i448 %r96 to i512
%r98 = zext i64 %r35 to i512
%r99 = shl i512 %r98, 448
%r100 = or i512 %r97, %r99
%r101 = zext i512 %r100 to i576
%r102 = zext i64 %r39 to i576
%r103 = shl i576 %r102, 512
%r104 = or i576 %r101, %r103
%r105 = zext i576 %r104 to i640
%r106 = zext i64 %r43 to i640
%r107 = shl i640 %r106, 576
%r108 = or i640 %r105, %r107
%r109 = zext i640 %r108 to i704
%r110 = zext i64 %r47 to i704
%r111 = shl i704 %r110, 640
%r112 = or i704 %r109, %r111
%r113 = zext i704 %r112 to i768
%r114 = zext i64 %r51 to i768
%r115 = shl i768 %r114, 704
%r116 = or i768 %r113, %r115
%r117 = zext i768 %r116 to i832
%r118 = zext i64 %r55 to i832
%r119 = shl i832 %r118, 768
%r120 = or i832 %r117, %r119
%r121 = zext i832 %r120 to i896
%r122 = zext i64 %r59 to i896
%r123 = shl i896 %r122, 832
%r124 = or i896 %r121, %r123
%r125 = zext i896 %r124 to i960
%r126 = zext i64 %r63 to i960
%r127 = shl i960 %r126, 896
%r128 = or i960 %r125, %r127
%r129 = zext i960 %r128 to i1024
%r130 = zext i64 %r67 to i1024
%r131 = shl i1024 %r130, 960
%r132 = or i1024 %r129, %r131
%r133 = zext i1024 %r132 to i1088
%r134 = zext i64 %r71 to i1088
%r135 = shl i1088 %r134, 1024
%r136 = or i1088 %r133, %r135
%r137 = zext i64 %r8 to i128
%r138 = zext i64 %r12 to i128
%r139 = shl i128 %r138, 64
%r140 = or i128 %r137, %r139
%r141 = zext i128 %r140 to i192
%r142 = zext i64 %r16 to i192
%r143 = shl i192 %r142, 128
%r144 = or i192 %r141, %r143
%r145 = zext i192 %r144 to i256
%r146 = zext i64 %r20 to i256
%r147 = shl i256 %r146, 192
%r148 = or i256 %r145, %r147
%r149 = zext i256 %r148 to i320
%r150 = zext i64 %r24 to i320
%r151 = shl i320 %r150, 256
%r152 = or i320 %r149, %r151
%r153 = zext i320 %r152 to i384
%r154 = zext i64 %r28 to i384
%r155 = shl i384 %r154, 320
%r156 = or i384 %r153, %r155
%r157 = zext i384 %r156 to i448
%r158 = zext i64 %r32 to i448
%r159 = shl i448 %r158, 384
%r160 = or i448 %r157, %r159
%r161 = zext i448 %r160 to i512
%r162 = zext i64 %r36 to i512
%r163 = shl i512 %r162, 448
%r164 = or i512 %r161, %r163
%r165 = zext i512 %r164 to i576
%r166 = zext i64 %r40 to i576
%r167 = shl i576 %r166, 512
%r168 = or i576 %r165, %r167
%r169 = zext i576 %r168 to i640
%r170 = zext i64 %r44 to i640
%r171 = shl i640 %r170, 576
%r172 = or i640 %r169, %r171
%r173 = zext i640 %r172 to i704
%r174 = zext i64 %r48 to i704
%r175 = shl i704 %r174, 640
%r176 = or i704 %r173, %r175
%r177 = zext i704 %r176 to i768
%r178 = zext i64 %r52 to i768
%r179 = shl i768 %r178, 704
%r180 = or i768 %r177, %r179
%r181 = zext i768 %r180 to i832
%r182 = zext i64 %r56 to i832
%r183 = shl i832 %r182, 768
%r184 = or i832 %r181, %r183
%r185 = zext i832 %r184 to i896
%r186 = zext i64 %r60 to i896
%r187 = shl i896 %r186, 832
%r188 = or i896 %r185, %r187
%r189 = zext i896 %r188 to i960
%r190 = zext i64 %r64 to i960
%r191 = shl i960 %r190, 896
%r192 = or i960 %r189, %r191
%r193 = zext i960 %r192 to i1024
%r194 = zext i64 %r68 to i1024
%r195 = shl i1024 %r194, 960
%r196 = or i1024 %r193, %r195
%r197 = zext i1024 %r196 to i1088
%r198 = zext i64 %r72 to i1088
%r199 = shl i1088 %r198, 1024
%r200 = or i1088 %r197, %r199
%r201 = zext i1088 %r136 to i1152
%r202 = zext i1088 %r200 to i1152
%r203 = shl i1152 %r202, 64
%r204 = add i1152 %r201, %r203
%r206 = bitcast i64* %r2 to i1088*
%r207 = load i1088, i1088* %r206
%r208 = zext i1088 %r207 to i1152
%r209 = add i1152 %r204, %r208
%r210 = trunc i1152 %r209 to i1088
%r212 = getelementptr i64, i64* %r2, i32 0
%r213 = trunc i1088 %r210 to i64
store i64 %r213, i64* %r212
%r214 = lshr i1088 %r210, 64
%r216 = getelementptr i64, i64* %r2, i32 1
%r217 = trunc i1088 %r214 to i64
store i64 %r217, i64* %r216
%r218 = lshr i1088 %r214, 64
%r220 = getelementptr i64, i64* %r2, i32 2
%r221 = trunc i1088 %r218 to i64
store i64 %r221, i64* %r220
%r222 = lshr i1088 %r218, 64
%r224 = getelementptr i64, i64* %r2, i32 3
%r225 = trunc i1088 %r222 to i64
store i64 %r225, i64* %r224
%r226 = lshr i1088 %r222, 64
%r228 = getelementptr i64, i64* %r2, i32 4
%r229 = trunc i1088 %r226 to i64
store i64 %r229, i64* %r228
%r230 = lshr i1088 %r226, 64
%r232 = getelementptr i64, i64* %r2, i32 5
%r233 = trunc i1088 %r230 to i64
store i64 %r233, i64* %r232
%r234 = lshr i1088 %r230, 64
%r236 = getelementptr i64, i64* %r2, i32 6
%r237 = trunc i1088 %r234 to i64
store i64 %r237, i64* %r236
%r238 = lshr i1088 %r234, 64
%r240 = getelementptr i64, i64* %r2, i32 7
%r241 = trunc i1088 %r238 to i64
store i64 %r241, i64* %r240
%r242 = lshr i1088 %r238, 64
%r244 = getelementptr i64, i64* %r2, i32 8
%r245 = trunc i1088 %r242 to i64
store i64 %r245, i64* %r244
%r246 = lshr i1088 %r242, 64
%r248 = getelementptr i64, i64* %r2, i32 9
%r249 = trunc i1088 %r246 to i64
store i64 %r249, i64* %r248
%r250 = lshr i1088 %r246, 64
%r252 = getelementptr i64, i64* %r2, i32 10
%r253 = trunc i1088 %r250 to i64
store i64 %r253, i64* %r252
%r254 = lshr i1088 %r250, 64
%r256 = getelementptr i64, i64* %r2, i32 11
%r257 = trunc i1088 %r254 to i64
store i64 %r257, i64* %r256
%r258 = lshr i1088 %r254, 64
%r260 = getelementptr i64, i64* %r2, i32 12
%r261 = trunc i1088 %r258 to i64
store i64 %r261, i64* %r260
%r262 = lshr i1088 %r258, 64
%r264 = getelementptr i64, i64* %r2, i32 13
%r265 = trunc i1088 %r262 to i64
store i64 %r265, i64* %r264
%r266 = lshr i1088 %r262, 64
%r268 = getelementptr i64, i64* %r2, i32 14
%r269 = trunc i1088 %r266 to i64
store i64 %r269, i64* %r268
%r270 = lshr i1088 %r266, 64
%r272 = getelementptr i64, i64* %r2, i32 15
%r273 = trunc i1088 %r270 to i64
store i64 %r273, i64* %r272
%r274 = lshr i1088 %r270, 64
%r276 = getelementptr i64, i64* %r2, i32 16
%r277 = trunc i1088 %r274 to i64
store i64 %r277, i64* %r276
%r278 = lshr i1152 %r209, 1088
%r279 = trunc i1152 %r278 to i64
ret i64 %r279
}
define void @mclb_mul17(i64* noalias  %r1, i64* noalias  %r2, i64* noalias  %r3)
{
%r4 = load i64, i64* %r3
%r5 = call i1152 @mulUnit_inner1088(i64* %r2, i64 %r4)
%r6 = trunc i1152 %r5 to i64
store i64 %r6, i64* %r1
%r7 = lshr i1152 %r5, 64
%r9 = getelementptr i64, i64* %r3, i32 1
%r10 = load i64, i64* %r9
%r11 = call i1152 @mulUnit_inner1088(i64* %r2, i64 %r10)
%r12 = add i1152 %r7, %r11
%r13 = trunc i1152 %r12 to i64
%r15 = getelementptr i64, i64* %r1, i32 1
store i64 %r13, i64* %r15
%r16 = lshr i1152 %r12, 64
%r18 = getelementptr i64, i64* %r3, i32 2
%r19 = load i64, i64* %r18
%r20 = call i1152 @mulUnit_inner1088(i64* %r2, i64 %r19)
%r21 = add i1152 %r16, %r20
%r22 = trunc i1152 %r21 to i64
%r24 = getelementptr i64, i64* %r1, i32 2
store i64 %r22, i64* %r24
%r25 = lshr i1152 %r21, 64
%r27 = getelementptr i64, i64* %r3, i32 3
%r28 = load i64, i64* %r27
%r29 = call i1152 @mulUnit_inner1088(i64* %r2, i64 %r28)
%r30 = add i1152 %r25, %r29
%r31 = trunc i1152 %r30 to i64
%r33 = getelementptr i64, i64* %r1, i32 3
store i64 %r31, i64* %r33
%r34 = lshr i1152 %r30, 64
%r36 = getelementptr i64, i64* %r3, i32 4
%r37 = load i64, i64* %r36
%r38 = call i1152 @mulUnit_inner1088(i64* %r2, i64 %r37)
%r39 = add i1152 %r34, %r38
%r40 = trunc i1152 %r39 to i64
%r42 = getelementptr i64, i64* %r1, i32 4
store i64 %r40, i64* %r42
%r43 = lshr i1152 %r39, 64
%r45 = getelementptr i64, i64* %r3, i32 5
%r46 = load i64, i64* %r45
%r47 = call i1152 @mulUnit_inner1088(i64* %r2, i64 %r46)
%r48 = add i1152 %r43, %r47
%r49 = trunc i1152 %r48 to i64
%r51 = getelementptr i64, i64* %r1, i32 5
store i64 %r49, i64* %r51
%r52 = lshr i1152 %r48, 64
%r54 = getelementptr i64, i64* %r3, i32 6
%r55 = load i64, i64* %r54
%r56 = call i1152 @mulUnit_inner1088(i64* %r2, i64 %r55)
%r57 = add i1152 %r52, %r56
%r58 = trunc i1152 %r57 to i64
%r60 = getelementptr i64, i64* %r1, i32 6
store i64 %r58, i64* %r60
%r61 = lshr i1152 %r57, 64
%r63 = getelementptr i64, i64* %r3, i32 7
%r64 = load i64, i64* %r63
%r65 = call i1152 @mulUnit_inner1088(i64* %r2, i64 %r64)
%r66 = add i1152 %r61, %r65
%r67 = trunc i1152 %r66 to i64
%r69 = getelementptr i64, i64* %r1, i32 7
store i64 %r67, i64* %r69
%r70 = lshr i1152 %r66, 64
%r72 = getelementptr i64, i64* %r3, i32 8
%r73 = load i64, i64* %r72
%r74 = call i1152 @mulUnit_inner1088(i64* %r2, i64 %r73)
%r75 = add i1152 %r70, %r74
%r76 = trunc i1152 %r75 to i64
%r78 = getelementptr i64, i64* %r1, i32 8
store i64 %r76, i64* %r78
%r79 = lshr i1152 %r75, 64
%r81 = getelementptr i64, i64* %r3, i32 9
%r82 = load i64, i64* %r81
%r83 = call i1152 @mulUnit_inner1088(i64* %r2, i64 %r82)
%r84 = add i1152 %r79, %r83
%r85 = trunc i1152 %r84 to i64
%r87 = getelementptr i64, i64* %r1, i32 9
store i64 %r85, i64* %r87
%r88 = lshr i1152 %r84, 64
%r90 = getelementptr i64, i64* %r3, i32 10
%r91 = load i64, i64* %r90
%r92 = call i1152 @mulUnit_inner1088(i64* %r2, i64 %r91)
%r93 = add i1152 %r88, %r92
%r94 = trunc i1152 %r93 to i64
%r96 = getelementptr i64, i64* %r1, i32 10
store i64 %r94, i64* %r96
%r97 = lshr i1152 %r93, 64
%r99 = getelementptr i64, i64* %r3, i32 11
%r100 = load i64, i64* %r99
%r101 = call i1152 @mulUnit_inner1088(i64* %r2, i64 %r100)
%r102 = add i1152 %r97, %r101
%r103 = trunc i1152 %r102 to i64
%r105 = getelementptr i64, i64* %r1, i32 11
store i64 %r103, i64* %r105
%r106 = lshr i1152 %r102, 64
%r108 = getelementptr i64, i64* %r3, i32 12
%r109 = load i64, i64* %r108
%r110 = call i1152 @mulUnit_inner1088(i64* %r2, i64 %r109)
%r111 = add i1152 %r106, %r110
%r112 = trunc i1152 %r111 to i64
%r114 = getelementptr i64, i64* %r1, i32 12
store i64 %r112, i64* %r114
%r115 = lshr i1152 %r111, 64
%r117 = getelementptr i64, i64* %r3, i32 13
%r118 = load i64, i64* %r117
%r119 = call i1152 @mulUnit_inner1088(i64* %r2, i64 %r118)
%r120 = add i1152 %r115, %r119
%r121 = trunc i1152 %r120 to i64
%r123 = getelementptr i64, i64* %r1, i32 13
store i64 %r121, i64* %r123
%r124 = lshr i1152 %r120, 64
%r126 = getelementptr i64, i64* %r3, i32 14
%r127 = load i64, i64* %r126
%r128 = call i1152 @mulUnit_inner1088(i64* %r2, i64 %r127)
%r129 = add i1152 %r124, %r128
%r130 = trunc i1152 %r129 to i64
%r132 = getelementptr i64, i64* %r1, i32 14
store i64 %r130, i64* %r132
%r133 = lshr i1152 %r129, 64
%r135 = getelementptr i64, i64* %r3, i32 15
%r136 = load i64, i64* %r135
%r137 = call i1152 @mulUnit_inner1088(i64* %r2, i64 %r136)
%r138 = add i1152 %r133, %r137
%r139 = trunc i1152 %r138 to i64
%r141 = getelementptr i64, i64* %r1, i32 15
store i64 %r139, i64* %r141
%r142 = lshr i1152 %r138, 64
%r144 = getelementptr i64, i64* %r3, i32 16
%r145 = load i64, i64* %r144
%r146 = call i1152 @mulUnit_inner1088(i64* %r2, i64 %r145)
%r147 = add i1152 %r142, %r146
%r149 = getelementptr i64, i64* %r1, i32 16
%r151 = getelementptr i64, i64* %r149, i32 0
%r152 = trunc i1152 %r147 to i64
store i64 %r152, i64* %r151
%r153 = lshr i1152 %r147, 64
%r155 = getelementptr i64, i64* %r149, i32 1
%r156 = trunc i1152 %r153 to i64
store i64 %r156, i64* %r155
%r157 = lshr i1152 %r153, 64
%r159 = getelementptr i64, i64* %r149, i32 2
%r160 = trunc i1152 %r157 to i64
store i64 %r160, i64* %r159
%r161 = lshr i1152 %r157, 64
%r163 = getelementptr i64, i64* %r149, i32 3
%r164 = trunc i1152 %r161 to i64
store i64 %r164, i64* %r163
%r165 = lshr i1152 %r161, 64
%r167 = getelementptr i64, i64* %r149, i32 4
%r168 = trunc i1152 %r165 to i64
store i64 %r168, i64* %r167
%r169 = lshr i1152 %r165, 64
%r171 = getelementptr i64, i64* %r149, i32 5
%r172 = trunc i1152 %r169 to i64
store i64 %r172, i64* %r171
%r173 = lshr i1152 %r169, 64
%r175 = getelementptr i64, i64* %r149, i32 6
%r176 = trunc i1152 %r173 to i64
store i64 %r176, i64* %r175
%r177 = lshr i1152 %r173, 64
%r179 = getelementptr i64, i64* %r149, i32 7
%r180 = trunc i1152 %r177 to i64
store i64 %r180, i64* %r179
%r181 = lshr i1152 %r177, 64
%r183 = getelementptr i64, i64* %r149, i32 8
%r184 = trunc i1152 %r181 to i64
store i64 %r184, i64* %r183
%r185 = lshr i1152 %r181, 64
%r187 = getelementptr i64, i64* %r149, i32 9
%r188 = trunc i1152 %r185 to i64
store i64 %r188, i64* %r187
%r189 = lshr i1152 %r185, 64
%r191 = getelementptr i64, i64* %r149, i32 10
%r192 = trunc i1152 %r189 to i64
store i64 %r192, i64* %r191
%r193 = lshr i1152 %r189, 64
%r195 = getelementptr i64, i64* %r149, i32 11
%r196 = trunc i1152 %r193 to i64
store i64 %r196, i64* %r195
%r197 = lshr i1152 %r193, 64
%r199 = getelementptr i64, i64* %r149, i32 12
%r200 = trunc i1152 %r197 to i64
store i64 %r200, i64* %r199
%r201 = lshr i1152 %r197, 64
%r203 = getelementptr i64, i64* %r149, i32 13
%r204 = trunc i1152 %r201 to i64
store i64 %r204, i64* %r203
%r205 = lshr i1152 %r201, 64
%r207 = getelementptr i64, i64* %r149, i32 14
%r208 = trunc i1152 %r205 to i64
store i64 %r208, i64* %r207
%r209 = lshr i1152 %r205, 64
%r211 = getelementptr i64, i64* %r149, i32 15
%r212 = trunc i1152 %r209 to i64
store i64 %r212, i64* %r211
%r213 = lshr i1152 %r209, 64
%r215 = getelementptr i64, i64* %r149, i32 16
%r216 = trunc i1152 %r213 to i64
store i64 %r216, i64* %r215
%r217 = lshr i1152 %r213, 64
%r219 = getelementptr i64, i64* %r149, i32 17
%r220 = trunc i1152 %r217 to i64
store i64 %r220, i64* %r219
ret void
}
define void @mclb_sqr17(i64* noalias  %r1, i64* noalias  %r2)
{
%r3 = load i64, i64* %r2
%r4 = call i128 @mul64x64L(i64 %r3, i64 %r3)
%r5 = trunc i128 %r4 to i64
store i64 %r5, i64* %r1
%r6 = lshr i128 %r4, 64
%r8 = getelementptr i64, i64* %r2, i32 16
%r9 = load i64, i64* %r8
%r10 = call i128 @mul64x64L(i64 %r3, i64 %r9)
%r11 = load i64, i64* %r2
%r13 = getelementptr i64, i64* %r2, i32 15
%r14 = load i64, i64* %r13
%r15 = call i128 @mul64x64L(i64 %r11, i64 %r14)
%r17 = getelementptr i64, i64* %r2, i32 1
%r18 = load i64, i64* %r17
%r20 = getelementptr i64, i64* %r2, i32 16
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
%r32 = getelementptr i64, i64* %r2, i32 14
%r33 = load i64, i64* %r32
%r34 = call i128 @mul64x64L(i64 %r30, i64 %r33)
%r36 = getelementptr i64, i64* %r2, i32 1
%r37 = load i64, i64* %r36
%r39 = getelementptr i64, i64* %r2, i32 15
%r40 = load i64, i64* %r39
%r41 = call i128 @mul64x64L(i64 %r37, i64 %r40)
%r42 = zext i128 %r34 to i256
%r43 = zext i128 %r41 to i256
%r44 = shl i256 %r43, 128
%r45 = or i256 %r42, %r44
%r47 = getelementptr i64, i64* %r2, i32 2
%r48 = load i64, i64* %r47
%r50 = getelementptr i64, i64* %r2, i32 16
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
%r62 = getelementptr i64, i64* %r2, i32 13
%r63 = load i64, i64* %r62
%r64 = call i128 @mul64x64L(i64 %r60, i64 %r63)
%r66 = getelementptr i64, i64* %r2, i32 1
%r67 = load i64, i64* %r66
%r69 = getelementptr i64, i64* %r2, i32 14
%r70 = load i64, i64* %r69
%r71 = call i128 @mul64x64L(i64 %r67, i64 %r70)
%r72 = zext i128 %r64 to i256
%r73 = zext i128 %r71 to i256
%r74 = shl i256 %r73, 128
%r75 = or i256 %r72, %r74
%r77 = getelementptr i64, i64* %r2, i32 2
%r78 = load i64, i64* %r77
%r80 = getelementptr i64, i64* %r2, i32 15
%r81 = load i64, i64* %r80
%r82 = call i128 @mul64x64L(i64 %r78, i64 %r81)
%r83 = zext i256 %r75 to i384
%r84 = zext i128 %r82 to i384
%r85 = shl i384 %r84, 256
%r86 = or i384 %r83, %r85
%r88 = getelementptr i64, i64* %r2, i32 3
%r89 = load i64, i64* %r88
%r91 = getelementptr i64, i64* %r2, i32 16
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
%r103 = getelementptr i64, i64* %r2, i32 12
%r104 = load i64, i64* %r103
%r105 = call i128 @mul64x64L(i64 %r101, i64 %r104)
%r107 = getelementptr i64, i64* %r2, i32 1
%r108 = load i64, i64* %r107
%r110 = getelementptr i64, i64* %r2, i32 13
%r111 = load i64, i64* %r110
%r112 = call i128 @mul64x64L(i64 %r108, i64 %r111)
%r113 = zext i128 %r105 to i256
%r114 = zext i128 %r112 to i256
%r115 = shl i256 %r114, 128
%r116 = or i256 %r113, %r115
%r118 = getelementptr i64, i64* %r2, i32 2
%r119 = load i64, i64* %r118
%r121 = getelementptr i64, i64* %r2, i32 14
%r122 = load i64, i64* %r121
%r123 = call i128 @mul64x64L(i64 %r119, i64 %r122)
%r124 = zext i256 %r116 to i384
%r125 = zext i128 %r123 to i384
%r126 = shl i384 %r125, 256
%r127 = or i384 %r124, %r126
%r129 = getelementptr i64, i64* %r2, i32 3
%r130 = load i64, i64* %r129
%r132 = getelementptr i64, i64* %r2, i32 15
%r133 = load i64, i64* %r132
%r134 = call i128 @mul64x64L(i64 %r130, i64 %r133)
%r135 = zext i384 %r127 to i512
%r136 = zext i128 %r134 to i512
%r137 = shl i512 %r136, 384
%r138 = or i512 %r135, %r137
%r140 = getelementptr i64, i64* %r2, i32 4
%r141 = load i64, i64* %r140
%r143 = getelementptr i64, i64* %r2, i32 16
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
%r155 = getelementptr i64, i64* %r2, i32 11
%r156 = load i64, i64* %r155
%r157 = call i128 @mul64x64L(i64 %r153, i64 %r156)
%r159 = getelementptr i64, i64* %r2, i32 1
%r160 = load i64, i64* %r159
%r162 = getelementptr i64, i64* %r2, i32 12
%r163 = load i64, i64* %r162
%r164 = call i128 @mul64x64L(i64 %r160, i64 %r163)
%r165 = zext i128 %r157 to i256
%r166 = zext i128 %r164 to i256
%r167 = shl i256 %r166, 128
%r168 = or i256 %r165, %r167
%r170 = getelementptr i64, i64* %r2, i32 2
%r171 = load i64, i64* %r170
%r173 = getelementptr i64, i64* %r2, i32 13
%r174 = load i64, i64* %r173
%r175 = call i128 @mul64x64L(i64 %r171, i64 %r174)
%r176 = zext i256 %r168 to i384
%r177 = zext i128 %r175 to i384
%r178 = shl i384 %r177, 256
%r179 = or i384 %r176, %r178
%r181 = getelementptr i64, i64* %r2, i32 3
%r182 = load i64, i64* %r181
%r184 = getelementptr i64, i64* %r2, i32 14
%r185 = load i64, i64* %r184
%r186 = call i128 @mul64x64L(i64 %r182, i64 %r185)
%r187 = zext i384 %r179 to i512
%r188 = zext i128 %r186 to i512
%r189 = shl i512 %r188, 384
%r190 = or i512 %r187, %r189
%r192 = getelementptr i64, i64* %r2, i32 4
%r193 = load i64, i64* %r192
%r195 = getelementptr i64, i64* %r2, i32 15
%r196 = load i64, i64* %r195
%r197 = call i128 @mul64x64L(i64 %r193, i64 %r196)
%r198 = zext i512 %r190 to i640
%r199 = zext i128 %r197 to i640
%r200 = shl i640 %r199, 512
%r201 = or i640 %r198, %r200
%r203 = getelementptr i64, i64* %r2, i32 5
%r204 = load i64, i64* %r203
%r206 = getelementptr i64, i64* %r2, i32 16
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
%r218 = getelementptr i64, i64* %r2, i32 10
%r219 = load i64, i64* %r218
%r220 = call i128 @mul64x64L(i64 %r216, i64 %r219)
%r222 = getelementptr i64, i64* %r2, i32 1
%r223 = load i64, i64* %r222
%r225 = getelementptr i64, i64* %r2, i32 11
%r226 = load i64, i64* %r225
%r227 = call i128 @mul64x64L(i64 %r223, i64 %r226)
%r228 = zext i128 %r220 to i256
%r229 = zext i128 %r227 to i256
%r230 = shl i256 %r229, 128
%r231 = or i256 %r228, %r230
%r233 = getelementptr i64, i64* %r2, i32 2
%r234 = load i64, i64* %r233
%r236 = getelementptr i64, i64* %r2, i32 12
%r237 = load i64, i64* %r236
%r238 = call i128 @mul64x64L(i64 %r234, i64 %r237)
%r239 = zext i256 %r231 to i384
%r240 = zext i128 %r238 to i384
%r241 = shl i384 %r240, 256
%r242 = or i384 %r239, %r241
%r244 = getelementptr i64, i64* %r2, i32 3
%r245 = load i64, i64* %r244
%r247 = getelementptr i64, i64* %r2, i32 13
%r248 = load i64, i64* %r247
%r249 = call i128 @mul64x64L(i64 %r245, i64 %r248)
%r250 = zext i384 %r242 to i512
%r251 = zext i128 %r249 to i512
%r252 = shl i512 %r251, 384
%r253 = or i512 %r250, %r252
%r255 = getelementptr i64, i64* %r2, i32 4
%r256 = load i64, i64* %r255
%r258 = getelementptr i64, i64* %r2, i32 14
%r259 = load i64, i64* %r258
%r260 = call i128 @mul64x64L(i64 %r256, i64 %r259)
%r261 = zext i512 %r253 to i640
%r262 = zext i128 %r260 to i640
%r263 = shl i640 %r262, 512
%r264 = or i640 %r261, %r263
%r266 = getelementptr i64, i64* %r2, i32 5
%r267 = load i64, i64* %r266
%r269 = getelementptr i64, i64* %r2, i32 15
%r270 = load i64, i64* %r269
%r271 = call i128 @mul64x64L(i64 %r267, i64 %r270)
%r272 = zext i640 %r264 to i768
%r273 = zext i128 %r271 to i768
%r274 = shl i768 %r273, 640
%r275 = or i768 %r272, %r274
%r277 = getelementptr i64, i64* %r2, i32 6
%r278 = load i64, i64* %r277
%r280 = getelementptr i64, i64* %r2, i32 16
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
%r292 = getelementptr i64, i64* %r2, i32 9
%r293 = load i64, i64* %r292
%r294 = call i128 @mul64x64L(i64 %r290, i64 %r293)
%r296 = getelementptr i64, i64* %r2, i32 1
%r297 = load i64, i64* %r296
%r299 = getelementptr i64, i64* %r2, i32 10
%r300 = load i64, i64* %r299
%r301 = call i128 @mul64x64L(i64 %r297, i64 %r300)
%r302 = zext i128 %r294 to i256
%r303 = zext i128 %r301 to i256
%r304 = shl i256 %r303, 128
%r305 = or i256 %r302, %r304
%r307 = getelementptr i64, i64* %r2, i32 2
%r308 = load i64, i64* %r307
%r310 = getelementptr i64, i64* %r2, i32 11
%r311 = load i64, i64* %r310
%r312 = call i128 @mul64x64L(i64 %r308, i64 %r311)
%r313 = zext i256 %r305 to i384
%r314 = zext i128 %r312 to i384
%r315 = shl i384 %r314, 256
%r316 = or i384 %r313, %r315
%r318 = getelementptr i64, i64* %r2, i32 3
%r319 = load i64, i64* %r318
%r321 = getelementptr i64, i64* %r2, i32 12
%r322 = load i64, i64* %r321
%r323 = call i128 @mul64x64L(i64 %r319, i64 %r322)
%r324 = zext i384 %r316 to i512
%r325 = zext i128 %r323 to i512
%r326 = shl i512 %r325, 384
%r327 = or i512 %r324, %r326
%r329 = getelementptr i64, i64* %r2, i32 4
%r330 = load i64, i64* %r329
%r332 = getelementptr i64, i64* %r2, i32 13
%r333 = load i64, i64* %r332
%r334 = call i128 @mul64x64L(i64 %r330, i64 %r333)
%r335 = zext i512 %r327 to i640
%r336 = zext i128 %r334 to i640
%r337 = shl i640 %r336, 512
%r338 = or i640 %r335, %r337
%r340 = getelementptr i64, i64* %r2, i32 5
%r341 = load i64, i64* %r340
%r343 = getelementptr i64, i64* %r2, i32 14
%r344 = load i64, i64* %r343
%r345 = call i128 @mul64x64L(i64 %r341, i64 %r344)
%r346 = zext i640 %r338 to i768
%r347 = zext i128 %r345 to i768
%r348 = shl i768 %r347, 640
%r349 = or i768 %r346, %r348
%r351 = getelementptr i64, i64* %r2, i32 6
%r352 = load i64, i64* %r351
%r354 = getelementptr i64, i64* %r2, i32 15
%r355 = load i64, i64* %r354
%r356 = call i128 @mul64x64L(i64 %r352, i64 %r355)
%r357 = zext i768 %r349 to i896
%r358 = zext i128 %r356 to i896
%r359 = shl i896 %r358, 768
%r360 = or i896 %r357, %r359
%r362 = getelementptr i64, i64* %r2, i32 7
%r363 = load i64, i64* %r362
%r365 = getelementptr i64, i64* %r2, i32 16
%r366 = load i64, i64* %r365
%r367 = call i128 @mul64x64L(i64 %r363, i64 %r366)
%r368 = zext i896 %r360 to i1024
%r369 = zext i128 %r367 to i1024
%r370 = shl i1024 %r369, 896
%r371 = or i1024 %r368, %r370
%r372 = zext i896 %r289 to i1024
%r373 = shl i1024 %r372, 64
%r374 = add i1024 %r373, %r371
%r375 = load i64, i64* %r2
%r377 = getelementptr i64, i64* %r2, i32 8
%r378 = load i64, i64* %r377
%r379 = call i128 @mul64x64L(i64 %r375, i64 %r378)
%r381 = getelementptr i64, i64* %r2, i32 1
%r382 = load i64, i64* %r381
%r384 = getelementptr i64, i64* %r2, i32 9
%r385 = load i64, i64* %r384
%r386 = call i128 @mul64x64L(i64 %r382, i64 %r385)
%r387 = zext i128 %r379 to i256
%r388 = zext i128 %r386 to i256
%r389 = shl i256 %r388, 128
%r390 = or i256 %r387, %r389
%r392 = getelementptr i64, i64* %r2, i32 2
%r393 = load i64, i64* %r392
%r395 = getelementptr i64, i64* %r2, i32 10
%r396 = load i64, i64* %r395
%r397 = call i128 @mul64x64L(i64 %r393, i64 %r396)
%r398 = zext i256 %r390 to i384
%r399 = zext i128 %r397 to i384
%r400 = shl i384 %r399, 256
%r401 = or i384 %r398, %r400
%r403 = getelementptr i64, i64* %r2, i32 3
%r404 = load i64, i64* %r403
%r406 = getelementptr i64, i64* %r2, i32 11
%r407 = load i64, i64* %r406
%r408 = call i128 @mul64x64L(i64 %r404, i64 %r407)
%r409 = zext i384 %r401 to i512
%r410 = zext i128 %r408 to i512
%r411 = shl i512 %r410, 384
%r412 = or i512 %r409, %r411
%r414 = getelementptr i64, i64* %r2, i32 4
%r415 = load i64, i64* %r414
%r417 = getelementptr i64, i64* %r2, i32 12
%r418 = load i64, i64* %r417
%r419 = call i128 @mul64x64L(i64 %r415, i64 %r418)
%r420 = zext i512 %r412 to i640
%r421 = zext i128 %r419 to i640
%r422 = shl i640 %r421, 512
%r423 = or i640 %r420, %r422
%r425 = getelementptr i64, i64* %r2, i32 5
%r426 = load i64, i64* %r425
%r428 = getelementptr i64, i64* %r2, i32 13
%r429 = load i64, i64* %r428
%r430 = call i128 @mul64x64L(i64 %r426, i64 %r429)
%r431 = zext i640 %r423 to i768
%r432 = zext i128 %r430 to i768
%r433 = shl i768 %r432, 640
%r434 = or i768 %r431, %r433
%r436 = getelementptr i64, i64* %r2, i32 6
%r437 = load i64, i64* %r436
%r439 = getelementptr i64, i64* %r2, i32 14
%r440 = load i64, i64* %r439
%r441 = call i128 @mul64x64L(i64 %r437, i64 %r440)
%r442 = zext i768 %r434 to i896
%r443 = zext i128 %r441 to i896
%r444 = shl i896 %r443, 768
%r445 = or i896 %r442, %r444
%r447 = getelementptr i64, i64* %r2, i32 7
%r448 = load i64, i64* %r447
%r450 = getelementptr i64, i64* %r2, i32 15
%r451 = load i64, i64* %r450
%r452 = call i128 @mul64x64L(i64 %r448, i64 %r451)
%r453 = zext i896 %r445 to i1024
%r454 = zext i128 %r452 to i1024
%r455 = shl i1024 %r454, 896
%r456 = or i1024 %r453, %r455
%r458 = getelementptr i64, i64* %r2, i32 8
%r459 = load i64, i64* %r458
%r461 = getelementptr i64, i64* %r2, i32 16
%r462 = load i64, i64* %r461
%r463 = call i128 @mul64x64L(i64 %r459, i64 %r462)
%r464 = zext i1024 %r456 to i1152
%r465 = zext i128 %r463 to i1152
%r466 = shl i1152 %r465, 1024
%r467 = or i1152 %r464, %r466
%r468 = zext i1024 %r374 to i1152
%r469 = shl i1152 %r468, 64
%r470 = add i1152 %r469, %r467
%r471 = load i64, i64* %r2
%r473 = getelementptr i64, i64* %r2, i32 7
%r474 = load i64, i64* %r473
%r475 = call i128 @mul64x64L(i64 %r471, i64 %r474)
%r477 = getelementptr i64, i64* %r2, i32 1
%r478 = load i64, i64* %r477
%r480 = getelementptr i64, i64* %r2, i32 8
%r481 = load i64, i64* %r480
%r482 = call i128 @mul64x64L(i64 %r478, i64 %r481)
%r483 = zext i128 %r475 to i256
%r484 = zext i128 %r482 to i256
%r485 = shl i256 %r484, 128
%r486 = or i256 %r483, %r485
%r488 = getelementptr i64, i64* %r2, i32 2
%r489 = load i64, i64* %r488
%r491 = getelementptr i64, i64* %r2, i32 9
%r492 = load i64, i64* %r491
%r493 = call i128 @mul64x64L(i64 %r489, i64 %r492)
%r494 = zext i256 %r486 to i384
%r495 = zext i128 %r493 to i384
%r496 = shl i384 %r495, 256
%r497 = or i384 %r494, %r496
%r499 = getelementptr i64, i64* %r2, i32 3
%r500 = load i64, i64* %r499
%r502 = getelementptr i64, i64* %r2, i32 10
%r503 = load i64, i64* %r502
%r504 = call i128 @mul64x64L(i64 %r500, i64 %r503)
%r505 = zext i384 %r497 to i512
%r506 = zext i128 %r504 to i512
%r507 = shl i512 %r506, 384
%r508 = or i512 %r505, %r507
%r510 = getelementptr i64, i64* %r2, i32 4
%r511 = load i64, i64* %r510
%r513 = getelementptr i64, i64* %r2, i32 11
%r514 = load i64, i64* %r513
%r515 = call i128 @mul64x64L(i64 %r511, i64 %r514)
%r516 = zext i512 %r508 to i640
%r517 = zext i128 %r515 to i640
%r518 = shl i640 %r517, 512
%r519 = or i640 %r516, %r518
%r521 = getelementptr i64, i64* %r2, i32 5
%r522 = load i64, i64* %r521
%r524 = getelementptr i64, i64* %r2, i32 12
%r525 = load i64, i64* %r524
%r526 = call i128 @mul64x64L(i64 %r522, i64 %r525)
%r527 = zext i640 %r519 to i768
%r528 = zext i128 %r526 to i768
%r529 = shl i768 %r528, 640
%r530 = or i768 %r527, %r529
%r532 = getelementptr i64, i64* %r2, i32 6
%r533 = load i64, i64* %r532
%r535 = getelementptr i64, i64* %r2, i32 13
%r536 = load i64, i64* %r535
%r537 = call i128 @mul64x64L(i64 %r533, i64 %r536)
%r538 = zext i768 %r530 to i896
%r539 = zext i128 %r537 to i896
%r540 = shl i896 %r539, 768
%r541 = or i896 %r538, %r540
%r543 = getelementptr i64, i64* %r2, i32 7
%r544 = load i64, i64* %r543
%r546 = getelementptr i64, i64* %r2, i32 14
%r547 = load i64, i64* %r546
%r548 = call i128 @mul64x64L(i64 %r544, i64 %r547)
%r549 = zext i896 %r541 to i1024
%r550 = zext i128 %r548 to i1024
%r551 = shl i1024 %r550, 896
%r552 = or i1024 %r549, %r551
%r554 = getelementptr i64, i64* %r2, i32 8
%r555 = load i64, i64* %r554
%r557 = getelementptr i64, i64* %r2, i32 15
%r558 = load i64, i64* %r557
%r559 = call i128 @mul64x64L(i64 %r555, i64 %r558)
%r560 = zext i1024 %r552 to i1152
%r561 = zext i128 %r559 to i1152
%r562 = shl i1152 %r561, 1024
%r563 = or i1152 %r560, %r562
%r565 = getelementptr i64, i64* %r2, i32 9
%r566 = load i64, i64* %r565
%r568 = getelementptr i64, i64* %r2, i32 16
%r569 = load i64, i64* %r568
%r570 = call i128 @mul64x64L(i64 %r566, i64 %r569)
%r571 = zext i1152 %r563 to i1280
%r572 = zext i128 %r570 to i1280
%r573 = shl i1280 %r572, 1152
%r574 = or i1280 %r571, %r573
%r575 = zext i1152 %r470 to i1280
%r576 = shl i1280 %r575, 64
%r577 = add i1280 %r576, %r574
%r578 = load i64, i64* %r2
%r580 = getelementptr i64, i64* %r2, i32 6
%r581 = load i64, i64* %r580
%r582 = call i128 @mul64x64L(i64 %r578, i64 %r581)
%r584 = getelementptr i64, i64* %r2, i32 1
%r585 = load i64, i64* %r584
%r587 = getelementptr i64, i64* %r2, i32 7
%r588 = load i64, i64* %r587
%r589 = call i128 @mul64x64L(i64 %r585, i64 %r588)
%r590 = zext i128 %r582 to i256
%r591 = zext i128 %r589 to i256
%r592 = shl i256 %r591, 128
%r593 = or i256 %r590, %r592
%r595 = getelementptr i64, i64* %r2, i32 2
%r596 = load i64, i64* %r595
%r598 = getelementptr i64, i64* %r2, i32 8
%r599 = load i64, i64* %r598
%r600 = call i128 @mul64x64L(i64 %r596, i64 %r599)
%r601 = zext i256 %r593 to i384
%r602 = zext i128 %r600 to i384
%r603 = shl i384 %r602, 256
%r604 = or i384 %r601, %r603
%r606 = getelementptr i64, i64* %r2, i32 3
%r607 = load i64, i64* %r606
%r609 = getelementptr i64, i64* %r2, i32 9
%r610 = load i64, i64* %r609
%r611 = call i128 @mul64x64L(i64 %r607, i64 %r610)
%r612 = zext i384 %r604 to i512
%r613 = zext i128 %r611 to i512
%r614 = shl i512 %r613, 384
%r615 = or i512 %r612, %r614
%r617 = getelementptr i64, i64* %r2, i32 4
%r618 = load i64, i64* %r617
%r620 = getelementptr i64, i64* %r2, i32 10
%r621 = load i64, i64* %r620
%r622 = call i128 @mul64x64L(i64 %r618, i64 %r621)
%r623 = zext i512 %r615 to i640
%r624 = zext i128 %r622 to i640
%r625 = shl i640 %r624, 512
%r626 = or i640 %r623, %r625
%r628 = getelementptr i64, i64* %r2, i32 5
%r629 = load i64, i64* %r628
%r631 = getelementptr i64, i64* %r2, i32 11
%r632 = load i64, i64* %r631
%r633 = call i128 @mul64x64L(i64 %r629, i64 %r632)
%r634 = zext i640 %r626 to i768
%r635 = zext i128 %r633 to i768
%r636 = shl i768 %r635, 640
%r637 = or i768 %r634, %r636
%r639 = getelementptr i64, i64* %r2, i32 6
%r640 = load i64, i64* %r639
%r642 = getelementptr i64, i64* %r2, i32 12
%r643 = load i64, i64* %r642
%r644 = call i128 @mul64x64L(i64 %r640, i64 %r643)
%r645 = zext i768 %r637 to i896
%r646 = zext i128 %r644 to i896
%r647 = shl i896 %r646, 768
%r648 = or i896 %r645, %r647
%r650 = getelementptr i64, i64* %r2, i32 7
%r651 = load i64, i64* %r650
%r653 = getelementptr i64, i64* %r2, i32 13
%r654 = load i64, i64* %r653
%r655 = call i128 @mul64x64L(i64 %r651, i64 %r654)
%r656 = zext i896 %r648 to i1024
%r657 = zext i128 %r655 to i1024
%r658 = shl i1024 %r657, 896
%r659 = or i1024 %r656, %r658
%r661 = getelementptr i64, i64* %r2, i32 8
%r662 = load i64, i64* %r661
%r664 = getelementptr i64, i64* %r2, i32 14
%r665 = load i64, i64* %r664
%r666 = call i128 @mul64x64L(i64 %r662, i64 %r665)
%r667 = zext i1024 %r659 to i1152
%r668 = zext i128 %r666 to i1152
%r669 = shl i1152 %r668, 1024
%r670 = or i1152 %r667, %r669
%r672 = getelementptr i64, i64* %r2, i32 9
%r673 = load i64, i64* %r672
%r675 = getelementptr i64, i64* %r2, i32 15
%r676 = load i64, i64* %r675
%r677 = call i128 @mul64x64L(i64 %r673, i64 %r676)
%r678 = zext i1152 %r670 to i1280
%r679 = zext i128 %r677 to i1280
%r680 = shl i1280 %r679, 1152
%r681 = or i1280 %r678, %r680
%r683 = getelementptr i64, i64* %r2, i32 10
%r684 = load i64, i64* %r683
%r686 = getelementptr i64, i64* %r2, i32 16
%r687 = load i64, i64* %r686
%r688 = call i128 @mul64x64L(i64 %r684, i64 %r687)
%r689 = zext i1280 %r681 to i1408
%r690 = zext i128 %r688 to i1408
%r691 = shl i1408 %r690, 1280
%r692 = or i1408 %r689, %r691
%r693 = zext i1280 %r577 to i1408
%r694 = shl i1408 %r693, 64
%r695 = add i1408 %r694, %r692
%r696 = load i64, i64* %r2
%r698 = getelementptr i64, i64* %r2, i32 5
%r699 = load i64, i64* %r698
%r700 = call i128 @mul64x64L(i64 %r696, i64 %r699)
%r702 = getelementptr i64, i64* %r2, i32 1
%r703 = load i64, i64* %r702
%r705 = getelementptr i64, i64* %r2, i32 6
%r706 = load i64, i64* %r705
%r707 = call i128 @mul64x64L(i64 %r703, i64 %r706)
%r708 = zext i128 %r700 to i256
%r709 = zext i128 %r707 to i256
%r710 = shl i256 %r709, 128
%r711 = or i256 %r708, %r710
%r713 = getelementptr i64, i64* %r2, i32 2
%r714 = load i64, i64* %r713
%r716 = getelementptr i64, i64* %r2, i32 7
%r717 = load i64, i64* %r716
%r718 = call i128 @mul64x64L(i64 %r714, i64 %r717)
%r719 = zext i256 %r711 to i384
%r720 = zext i128 %r718 to i384
%r721 = shl i384 %r720, 256
%r722 = or i384 %r719, %r721
%r724 = getelementptr i64, i64* %r2, i32 3
%r725 = load i64, i64* %r724
%r727 = getelementptr i64, i64* %r2, i32 8
%r728 = load i64, i64* %r727
%r729 = call i128 @mul64x64L(i64 %r725, i64 %r728)
%r730 = zext i384 %r722 to i512
%r731 = zext i128 %r729 to i512
%r732 = shl i512 %r731, 384
%r733 = or i512 %r730, %r732
%r735 = getelementptr i64, i64* %r2, i32 4
%r736 = load i64, i64* %r735
%r738 = getelementptr i64, i64* %r2, i32 9
%r739 = load i64, i64* %r738
%r740 = call i128 @mul64x64L(i64 %r736, i64 %r739)
%r741 = zext i512 %r733 to i640
%r742 = zext i128 %r740 to i640
%r743 = shl i640 %r742, 512
%r744 = or i640 %r741, %r743
%r746 = getelementptr i64, i64* %r2, i32 5
%r747 = load i64, i64* %r746
%r749 = getelementptr i64, i64* %r2, i32 10
%r750 = load i64, i64* %r749
%r751 = call i128 @mul64x64L(i64 %r747, i64 %r750)
%r752 = zext i640 %r744 to i768
%r753 = zext i128 %r751 to i768
%r754 = shl i768 %r753, 640
%r755 = or i768 %r752, %r754
%r757 = getelementptr i64, i64* %r2, i32 6
%r758 = load i64, i64* %r757
%r760 = getelementptr i64, i64* %r2, i32 11
%r761 = load i64, i64* %r760
%r762 = call i128 @mul64x64L(i64 %r758, i64 %r761)
%r763 = zext i768 %r755 to i896
%r764 = zext i128 %r762 to i896
%r765 = shl i896 %r764, 768
%r766 = or i896 %r763, %r765
%r768 = getelementptr i64, i64* %r2, i32 7
%r769 = load i64, i64* %r768
%r771 = getelementptr i64, i64* %r2, i32 12
%r772 = load i64, i64* %r771
%r773 = call i128 @mul64x64L(i64 %r769, i64 %r772)
%r774 = zext i896 %r766 to i1024
%r775 = zext i128 %r773 to i1024
%r776 = shl i1024 %r775, 896
%r777 = or i1024 %r774, %r776
%r779 = getelementptr i64, i64* %r2, i32 8
%r780 = load i64, i64* %r779
%r782 = getelementptr i64, i64* %r2, i32 13
%r783 = load i64, i64* %r782
%r784 = call i128 @mul64x64L(i64 %r780, i64 %r783)
%r785 = zext i1024 %r777 to i1152
%r786 = zext i128 %r784 to i1152
%r787 = shl i1152 %r786, 1024
%r788 = or i1152 %r785, %r787
%r790 = getelementptr i64, i64* %r2, i32 9
%r791 = load i64, i64* %r790
%r793 = getelementptr i64, i64* %r2, i32 14
%r794 = load i64, i64* %r793
%r795 = call i128 @mul64x64L(i64 %r791, i64 %r794)
%r796 = zext i1152 %r788 to i1280
%r797 = zext i128 %r795 to i1280
%r798 = shl i1280 %r797, 1152
%r799 = or i1280 %r796, %r798
%r801 = getelementptr i64, i64* %r2, i32 10
%r802 = load i64, i64* %r801
%r804 = getelementptr i64, i64* %r2, i32 15
%r805 = load i64, i64* %r804
%r806 = call i128 @mul64x64L(i64 %r802, i64 %r805)
%r807 = zext i1280 %r799 to i1408
%r808 = zext i128 %r806 to i1408
%r809 = shl i1408 %r808, 1280
%r810 = or i1408 %r807, %r809
%r812 = getelementptr i64, i64* %r2, i32 11
%r813 = load i64, i64* %r812
%r815 = getelementptr i64, i64* %r2, i32 16
%r816 = load i64, i64* %r815
%r817 = call i128 @mul64x64L(i64 %r813, i64 %r816)
%r818 = zext i1408 %r810 to i1536
%r819 = zext i128 %r817 to i1536
%r820 = shl i1536 %r819, 1408
%r821 = or i1536 %r818, %r820
%r822 = zext i1408 %r695 to i1536
%r823 = shl i1536 %r822, 64
%r824 = add i1536 %r823, %r821
%r825 = load i64, i64* %r2
%r827 = getelementptr i64, i64* %r2, i32 4
%r828 = load i64, i64* %r827
%r829 = call i128 @mul64x64L(i64 %r825, i64 %r828)
%r831 = getelementptr i64, i64* %r2, i32 1
%r832 = load i64, i64* %r831
%r834 = getelementptr i64, i64* %r2, i32 5
%r835 = load i64, i64* %r834
%r836 = call i128 @mul64x64L(i64 %r832, i64 %r835)
%r837 = zext i128 %r829 to i256
%r838 = zext i128 %r836 to i256
%r839 = shl i256 %r838, 128
%r840 = or i256 %r837, %r839
%r842 = getelementptr i64, i64* %r2, i32 2
%r843 = load i64, i64* %r842
%r845 = getelementptr i64, i64* %r2, i32 6
%r846 = load i64, i64* %r845
%r847 = call i128 @mul64x64L(i64 %r843, i64 %r846)
%r848 = zext i256 %r840 to i384
%r849 = zext i128 %r847 to i384
%r850 = shl i384 %r849, 256
%r851 = or i384 %r848, %r850
%r853 = getelementptr i64, i64* %r2, i32 3
%r854 = load i64, i64* %r853
%r856 = getelementptr i64, i64* %r2, i32 7
%r857 = load i64, i64* %r856
%r858 = call i128 @mul64x64L(i64 %r854, i64 %r857)
%r859 = zext i384 %r851 to i512
%r860 = zext i128 %r858 to i512
%r861 = shl i512 %r860, 384
%r862 = or i512 %r859, %r861
%r864 = getelementptr i64, i64* %r2, i32 4
%r865 = load i64, i64* %r864
%r867 = getelementptr i64, i64* %r2, i32 8
%r868 = load i64, i64* %r867
%r869 = call i128 @mul64x64L(i64 %r865, i64 %r868)
%r870 = zext i512 %r862 to i640
%r871 = zext i128 %r869 to i640
%r872 = shl i640 %r871, 512
%r873 = or i640 %r870, %r872
%r875 = getelementptr i64, i64* %r2, i32 5
%r876 = load i64, i64* %r875
%r878 = getelementptr i64, i64* %r2, i32 9
%r879 = load i64, i64* %r878
%r880 = call i128 @mul64x64L(i64 %r876, i64 %r879)
%r881 = zext i640 %r873 to i768
%r882 = zext i128 %r880 to i768
%r883 = shl i768 %r882, 640
%r884 = or i768 %r881, %r883
%r886 = getelementptr i64, i64* %r2, i32 6
%r887 = load i64, i64* %r886
%r889 = getelementptr i64, i64* %r2, i32 10
%r890 = load i64, i64* %r889
%r891 = call i128 @mul64x64L(i64 %r887, i64 %r890)
%r892 = zext i768 %r884 to i896
%r893 = zext i128 %r891 to i896
%r894 = shl i896 %r893, 768
%r895 = or i896 %r892, %r894
%r897 = getelementptr i64, i64* %r2, i32 7
%r898 = load i64, i64* %r897
%r900 = getelementptr i64, i64* %r2, i32 11
%r901 = load i64, i64* %r900
%r902 = call i128 @mul64x64L(i64 %r898, i64 %r901)
%r903 = zext i896 %r895 to i1024
%r904 = zext i128 %r902 to i1024
%r905 = shl i1024 %r904, 896
%r906 = or i1024 %r903, %r905
%r908 = getelementptr i64, i64* %r2, i32 8
%r909 = load i64, i64* %r908
%r911 = getelementptr i64, i64* %r2, i32 12
%r912 = load i64, i64* %r911
%r913 = call i128 @mul64x64L(i64 %r909, i64 %r912)
%r914 = zext i1024 %r906 to i1152
%r915 = zext i128 %r913 to i1152
%r916 = shl i1152 %r915, 1024
%r917 = or i1152 %r914, %r916
%r919 = getelementptr i64, i64* %r2, i32 9
%r920 = load i64, i64* %r919
%r922 = getelementptr i64, i64* %r2, i32 13
%r923 = load i64, i64* %r922
%r924 = call i128 @mul64x64L(i64 %r920, i64 %r923)
%r925 = zext i1152 %r917 to i1280
%r926 = zext i128 %r924 to i1280
%r927 = shl i1280 %r926, 1152
%r928 = or i1280 %r925, %r927
%r930 = getelementptr i64, i64* %r2, i32 10
%r931 = load i64, i64* %r930
%r933 = getelementptr i64, i64* %r2, i32 14
%r934 = load i64, i64* %r933
%r935 = call i128 @mul64x64L(i64 %r931, i64 %r934)
%r936 = zext i1280 %r928 to i1408
%r937 = zext i128 %r935 to i1408
%r938 = shl i1408 %r937, 1280
%r939 = or i1408 %r936, %r938
%r941 = getelementptr i64, i64* %r2, i32 11
%r942 = load i64, i64* %r941
%r944 = getelementptr i64, i64* %r2, i32 15
%r945 = load i64, i64* %r944
%r946 = call i128 @mul64x64L(i64 %r942, i64 %r945)
%r947 = zext i1408 %r939 to i1536
%r948 = zext i128 %r946 to i1536
%r949 = shl i1536 %r948, 1408
%r950 = or i1536 %r947, %r949
%r952 = getelementptr i64, i64* %r2, i32 12
%r953 = load i64, i64* %r952
%r955 = getelementptr i64, i64* %r2, i32 16
%r956 = load i64, i64* %r955
%r957 = call i128 @mul64x64L(i64 %r953, i64 %r956)
%r958 = zext i1536 %r950 to i1664
%r959 = zext i128 %r957 to i1664
%r960 = shl i1664 %r959, 1536
%r961 = or i1664 %r958, %r960
%r962 = zext i1536 %r824 to i1664
%r963 = shl i1664 %r962, 64
%r964 = add i1664 %r963, %r961
%r965 = load i64, i64* %r2
%r967 = getelementptr i64, i64* %r2, i32 3
%r968 = load i64, i64* %r967
%r969 = call i128 @mul64x64L(i64 %r965, i64 %r968)
%r971 = getelementptr i64, i64* %r2, i32 1
%r972 = load i64, i64* %r971
%r974 = getelementptr i64, i64* %r2, i32 4
%r975 = load i64, i64* %r974
%r976 = call i128 @mul64x64L(i64 %r972, i64 %r975)
%r977 = zext i128 %r969 to i256
%r978 = zext i128 %r976 to i256
%r979 = shl i256 %r978, 128
%r980 = or i256 %r977, %r979
%r982 = getelementptr i64, i64* %r2, i32 2
%r983 = load i64, i64* %r982
%r985 = getelementptr i64, i64* %r2, i32 5
%r986 = load i64, i64* %r985
%r987 = call i128 @mul64x64L(i64 %r983, i64 %r986)
%r988 = zext i256 %r980 to i384
%r989 = zext i128 %r987 to i384
%r990 = shl i384 %r989, 256
%r991 = or i384 %r988, %r990
%r993 = getelementptr i64, i64* %r2, i32 3
%r994 = load i64, i64* %r993
%r996 = getelementptr i64, i64* %r2, i32 6
%r997 = load i64, i64* %r996
%r998 = call i128 @mul64x64L(i64 %r994, i64 %r997)
%r999 = zext i384 %r991 to i512
%r1000 = zext i128 %r998 to i512
%r1001 = shl i512 %r1000, 384
%r1002 = or i512 %r999, %r1001
%r1004 = getelementptr i64, i64* %r2, i32 4
%r1005 = load i64, i64* %r1004
%r1007 = getelementptr i64, i64* %r2, i32 7
%r1008 = load i64, i64* %r1007
%r1009 = call i128 @mul64x64L(i64 %r1005, i64 %r1008)
%r1010 = zext i512 %r1002 to i640
%r1011 = zext i128 %r1009 to i640
%r1012 = shl i640 %r1011, 512
%r1013 = or i640 %r1010, %r1012
%r1015 = getelementptr i64, i64* %r2, i32 5
%r1016 = load i64, i64* %r1015
%r1018 = getelementptr i64, i64* %r2, i32 8
%r1019 = load i64, i64* %r1018
%r1020 = call i128 @mul64x64L(i64 %r1016, i64 %r1019)
%r1021 = zext i640 %r1013 to i768
%r1022 = zext i128 %r1020 to i768
%r1023 = shl i768 %r1022, 640
%r1024 = or i768 %r1021, %r1023
%r1026 = getelementptr i64, i64* %r2, i32 6
%r1027 = load i64, i64* %r1026
%r1029 = getelementptr i64, i64* %r2, i32 9
%r1030 = load i64, i64* %r1029
%r1031 = call i128 @mul64x64L(i64 %r1027, i64 %r1030)
%r1032 = zext i768 %r1024 to i896
%r1033 = zext i128 %r1031 to i896
%r1034 = shl i896 %r1033, 768
%r1035 = or i896 %r1032, %r1034
%r1037 = getelementptr i64, i64* %r2, i32 7
%r1038 = load i64, i64* %r1037
%r1040 = getelementptr i64, i64* %r2, i32 10
%r1041 = load i64, i64* %r1040
%r1042 = call i128 @mul64x64L(i64 %r1038, i64 %r1041)
%r1043 = zext i896 %r1035 to i1024
%r1044 = zext i128 %r1042 to i1024
%r1045 = shl i1024 %r1044, 896
%r1046 = or i1024 %r1043, %r1045
%r1048 = getelementptr i64, i64* %r2, i32 8
%r1049 = load i64, i64* %r1048
%r1051 = getelementptr i64, i64* %r2, i32 11
%r1052 = load i64, i64* %r1051
%r1053 = call i128 @mul64x64L(i64 %r1049, i64 %r1052)
%r1054 = zext i1024 %r1046 to i1152
%r1055 = zext i128 %r1053 to i1152
%r1056 = shl i1152 %r1055, 1024
%r1057 = or i1152 %r1054, %r1056
%r1059 = getelementptr i64, i64* %r2, i32 9
%r1060 = load i64, i64* %r1059
%r1062 = getelementptr i64, i64* %r2, i32 12
%r1063 = load i64, i64* %r1062
%r1064 = call i128 @mul64x64L(i64 %r1060, i64 %r1063)
%r1065 = zext i1152 %r1057 to i1280
%r1066 = zext i128 %r1064 to i1280
%r1067 = shl i1280 %r1066, 1152
%r1068 = or i1280 %r1065, %r1067
%r1070 = getelementptr i64, i64* %r2, i32 10
%r1071 = load i64, i64* %r1070
%r1073 = getelementptr i64, i64* %r2, i32 13
%r1074 = load i64, i64* %r1073
%r1075 = call i128 @mul64x64L(i64 %r1071, i64 %r1074)
%r1076 = zext i1280 %r1068 to i1408
%r1077 = zext i128 %r1075 to i1408
%r1078 = shl i1408 %r1077, 1280
%r1079 = or i1408 %r1076, %r1078
%r1081 = getelementptr i64, i64* %r2, i32 11
%r1082 = load i64, i64* %r1081
%r1084 = getelementptr i64, i64* %r2, i32 14
%r1085 = load i64, i64* %r1084
%r1086 = call i128 @mul64x64L(i64 %r1082, i64 %r1085)
%r1087 = zext i1408 %r1079 to i1536
%r1088 = zext i128 %r1086 to i1536
%r1089 = shl i1536 %r1088, 1408
%r1090 = or i1536 %r1087, %r1089
%r1092 = getelementptr i64, i64* %r2, i32 12
%r1093 = load i64, i64* %r1092
%r1095 = getelementptr i64, i64* %r2, i32 15
%r1096 = load i64, i64* %r1095
%r1097 = call i128 @mul64x64L(i64 %r1093, i64 %r1096)
%r1098 = zext i1536 %r1090 to i1664
%r1099 = zext i128 %r1097 to i1664
%r1100 = shl i1664 %r1099, 1536
%r1101 = or i1664 %r1098, %r1100
%r1103 = getelementptr i64, i64* %r2, i32 13
%r1104 = load i64, i64* %r1103
%r1106 = getelementptr i64, i64* %r2, i32 16
%r1107 = load i64, i64* %r1106
%r1108 = call i128 @mul64x64L(i64 %r1104, i64 %r1107)
%r1109 = zext i1664 %r1101 to i1792
%r1110 = zext i128 %r1108 to i1792
%r1111 = shl i1792 %r1110, 1664
%r1112 = or i1792 %r1109, %r1111
%r1113 = zext i1664 %r964 to i1792
%r1114 = shl i1792 %r1113, 64
%r1115 = add i1792 %r1114, %r1112
%r1116 = load i64, i64* %r2
%r1118 = getelementptr i64, i64* %r2, i32 2
%r1119 = load i64, i64* %r1118
%r1120 = call i128 @mul64x64L(i64 %r1116, i64 %r1119)
%r1122 = getelementptr i64, i64* %r2, i32 1
%r1123 = load i64, i64* %r1122
%r1125 = getelementptr i64, i64* %r2, i32 3
%r1126 = load i64, i64* %r1125
%r1127 = call i128 @mul64x64L(i64 %r1123, i64 %r1126)
%r1128 = zext i128 %r1120 to i256
%r1129 = zext i128 %r1127 to i256
%r1130 = shl i256 %r1129, 128
%r1131 = or i256 %r1128, %r1130
%r1133 = getelementptr i64, i64* %r2, i32 2
%r1134 = load i64, i64* %r1133
%r1136 = getelementptr i64, i64* %r2, i32 4
%r1137 = load i64, i64* %r1136
%r1138 = call i128 @mul64x64L(i64 %r1134, i64 %r1137)
%r1139 = zext i256 %r1131 to i384
%r1140 = zext i128 %r1138 to i384
%r1141 = shl i384 %r1140, 256
%r1142 = or i384 %r1139, %r1141
%r1144 = getelementptr i64, i64* %r2, i32 3
%r1145 = load i64, i64* %r1144
%r1147 = getelementptr i64, i64* %r2, i32 5
%r1148 = load i64, i64* %r1147
%r1149 = call i128 @mul64x64L(i64 %r1145, i64 %r1148)
%r1150 = zext i384 %r1142 to i512
%r1151 = zext i128 %r1149 to i512
%r1152 = shl i512 %r1151, 384
%r1153 = or i512 %r1150, %r1152
%r1155 = getelementptr i64, i64* %r2, i32 4
%r1156 = load i64, i64* %r1155
%r1158 = getelementptr i64, i64* %r2, i32 6
%r1159 = load i64, i64* %r1158
%r1160 = call i128 @mul64x64L(i64 %r1156, i64 %r1159)
%r1161 = zext i512 %r1153 to i640
%r1162 = zext i128 %r1160 to i640
%r1163 = shl i640 %r1162, 512
%r1164 = or i640 %r1161, %r1163
%r1166 = getelementptr i64, i64* %r2, i32 5
%r1167 = load i64, i64* %r1166
%r1169 = getelementptr i64, i64* %r2, i32 7
%r1170 = load i64, i64* %r1169
%r1171 = call i128 @mul64x64L(i64 %r1167, i64 %r1170)
%r1172 = zext i640 %r1164 to i768
%r1173 = zext i128 %r1171 to i768
%r1174 = shl i768 %r1173, 640
%r1175 = or i768 %r1172, %r1174
%r1177 = getelementptr i64, i64* %r2, i32 6
%r1178 = load i64, i64* %r1177
%r1180 = getelementptr i64, i64* %r2, i32 8
%r1181 = load i64, i64* %r1180
%r1182 = call i128 @mul64x64L(i64 %r1178, i64 %r1181)
%r1183 = zext i768 %r1175 to i896
%r1184 = zext i128 %r1182 to i896
%r1185 = shl i896 %r1184, 768
%r1186 = or i896 %r1183, %r1185
%r1188 = getelementptr i64, i64* %r2, i32 7
%r1189 = load i64, i64* %r1188
%r1191 = getelementptr i64, i64* %r2, i32 9
%r1192 = load i64, i64* %r1191
%r1193 = call i128 @mul64x64L(i64 %r1189, i64 %r1192)
%r1194 = zext i896 %r1186 to i1024
%r1195 = zext i128 %r1193 to i1024
%r1196 = shl i1024 %r1195, 896
%r1197 = or i1024 %r1194, %r1196
%r1199 = getelementptr i64, i64* %r2, i32 8
%r1200 = load i64, i64* %r1199
%r1202 = getelementptr i64, i64* %r2, i32 10
%r1203 = load i64, i64* %r1202
%r1204 = call i128 @mul64x64L(i64 %r1200, i64 %r1203)
%r1205 = zext i1024 %r1197 to i1152
%r1206 = zext i128 %r1204 to i1152
%r1207 = shl i1152 %r1206, 1024
%r1208 = or i1152 %r1205, %r1207
%r1210 = getelementptr i64, i64* %r2, i32 9
%r1211 = load i64, i64* %r1210
%r1213 = getelementptr i64, i64* %r2, i32 11
%r1214 = load i64, i64* %r1213
%r1215 = call i128 @mul64x64L(i64 %r1211, i64 %r1214)
%r1216 = zext i1152 %r1208 to i1280
%r1217 = zext i128 %r1215 to i1280
%r1218 = shl i1280 %r1217, 1152
%r1219 = or i1280 %r1216, %r1218
%r1221 = getelementptr i64, i64* %r2, i32 10
%r1222 = load i64, i64* %r1221
%r1224 = getelementptr i64, i64* %r2, i32 12
%r1225 = load i64, i64* %r1224
%r1226 = call i128 @mul64x64L(i64 %r1222, i64 %r1225)
%r1227 = zext i1280 %r1219 to i1408
%r1228 = zext i128 %r1226 to i1408
%r1229 = shl i1408 %r1228, 1280
%r1230 = or i1408 %r1227, %r1229
%r1232 = getelementptr i64, i64* %r2, i32 11
%r1233 = load i64, i64* %r1232
%r1235 = getelementptr i64, i64* %r2, i32 13
%r1236 = load i64, i64* %r1235
%r1237 = call i128 @mul64x64L(i64 %r1233, i64 %r1236)
%r1238 = zext i1408 %r1230 to i1536
%r1239 = zext i128 %r1237 to i1536
%r1240 = shl i1536 %r1239, 1408
%r1241 = or i1536 %r1238, %r1240
%r1243 = getelementptr i64, i64* %r2, i32 12
%r1244 = load i64, i64* %r1243
%r1246 = getelementptr i64, i64* %r2, i32 14
%r1247 = load i64, i64* %r1246
%r1248 = call i128 @mul64x64L(i64 %r1244, i64 %r1247)
%r1249 = zext i1536 %r1241 to i1664
%r1250 = zext i128 %r1248 to i1664
%r1251 = shl i1664 %r1250, 1536
%r1252 = or i1664 %r1249, %r1251
%r1254 = getelementptr i64, i64* %r2, i32 13
%r1255 = load i64, i64* %r1254
%r1257 = getelementptr i64, i64* %r2, i32 15
%r1258 = load i64, i64* %r1257
%r1259 = call i128 @mul64x64L(i64 %r1255, i64 %r1258)
%r1260 = zext i1664 %r1252 to i1792
%r1261 = zext i128 %r1259 to i1792
%r1262 = shl i1792 %r1261, 1664
%r1263 = or i1792 %r1260, %r1262
%r1265 = getelementptr i64, i64* %r2, i32 14
%r1266 = load i64, i64* %r1265
%r1268 = getelementptr i64, i64* %r2, i32 16
%r1269 = load i64, i64* %r1268
%r1270 = call i128 @mul64x64L(i64 %r1266, i64 %r1269)
%r1271 = zext i1792 %r1263 to i1920
%r1272 = zext i128 %r1270 to i1920
%r1273 = shl i1920 %r1272, 1792
%r1274 = or i1920 %r1271, %r1273
%r1275 = zext i1792 %r1115 to i1920
%r1276 = shl i1920 %r1275, 64
%r1277 = add i1920 %r1276, %r1274
%r1278 = load i64, i64* %r2
%r1280 = getelementptr i64, i64* %r2, i32 1
%r1281 = load i64, i64* %r1280
%r1282 = call i128 @mul64x64L(i64 %r1278, i64 %r1281)
%r1284 = getelementptr i64, i64* %r2, i32 1
%r1285 = load i64, i64* %r1284
%r1287 = getelementptr i64, i64* %r2, i32 2
%r1288 = load i64, i64* %r1287
%r1289 = call i128 @mul64x64L(i64 %r1285, i64 %r1288)
%r1290 = zext i128 %r1282 to i256
%r1291 = zext i128 %r1289 to i256
%r1292 = shl i256 %r1291, 128
%r1293 = or i256 %r1290, %r1292
%r1295 = getelementptr i64, i64* %r2, i32 2
%r1296 = load i64, i64* %r1295
%r1298 = getelementptr i64, i64* %r2, i32 3
%r1299 = load i64, i64* %r1298
%r1300 = call i128 @mul64x64L(i64 %r1296, i64 %r1299)
%r1301 = zext i256 %r1293 to i384
%r1302 = zext i128 %r1300 to i384
%r1303 = shl i384 %r1302, 256
%r1304 = or i384 %r1301, %r1303
%r1306 = getelementptr i64, i64* %r2, i32 3
%r1307 = load i64, i64* %r1306
%r1309 = getelementptr i64, i64* %r2, i32 4
%r1310 = load i64, i64* %r1309
%r1311 = call i128 @mul64x64L(i64 %r1307, i64 %r1310)
%r1312 = zext i384 %r1304 to i512
%r1313 = zext i128 %r1311 to i512
%r1314 = shl i512 %r1313, 384
%r1315 = or i512 %r1312, %r1314
%r1317 = getelementptr i64, i64* %r2, i32 4
%r1318 = load i64, i64* %r1317
%r1320 = getelementptr i64, i64* %r2, i32 5
%r1321 = load i64, i64* %r1320
%r1322 = call i128 @mul64x64L(i64 %r1318, i64 %r1321)
%r1323 = zext i512 %r1315 to i640
%r1324 = zext i128 %r1322 to i640
%r1325 = shl i640 %r1324, 512
%r1326 = or i640 %r1323, %r1325
%r1328 = getelementptr i64, i64* %r2, i32 5
%r1329 = load i64, i64* %r1328
%r1331 = getelementptr i64, i64* %r2, i32 6
%r1332 = load i64, i64* %r1331
%r1333 = call i128 @mul64x64L(i64 %r1329, i64 %r1332)
%r1334 = zext i640 %r1326 to i768
%r1335 = zext i128 %r1333 to i768
%r1336 = shl i768 %r1335, 640
%r1337 = or i768 %r1334, %r1336
%r1339 = getelementptr i64, i64* %r2, i32 6
%r1340 = load i64, i64* %r1339
%r1342 = getelementptr i64, i64* %r2, i32 7
%r1343 = load i64, i64* %r1342
%r1344 = call i128 @mul64x64L(i64 %r1340, i64 %r1343)
%r1345 = zext i768 %r1337 to i896
%r1346 = zext i128 %r1344 to i896
%r1347 = shl i896 %r1346, 768
%r1348 = or i896 %r1345, %r1347
%r1350 = getelementptr i64, i64* %r2, i32 7
%r1351 = load i64, i64* %r1350
%r1353 = getelementptr i64, i64* %r2, i32 8
%r1354 = load i64, i64* %r1353
%r1355 = call i128 @mul64x64L(i64 %r1351, i64 %r1354)
%r1356 = zext i896 %r1348 to i1024
%r1357 = zext i128 %r1355 to i1024
%r1358 = shl i1024 %r1357, 896
%r1359 = or i1024 %r1356, %r1358
%r1361 = getelementptr i64, i64* %r2, i32 8
%r1362 = load i64, i64* %r1361
%r1364 = getelementptr i64, i64* %r2, i32 9
%r1365 = load i64, i64* %r1364
%r1366 = call i128 @mul64x64L(i64 %r1362, i64 %r1365)
%r1367 = zext i1024 %r1359 to i1152
%r1368 = zext i128 %r1366 to i1152
%r1369 = shl i1152 %r1368, 1024
%r1370 = or i1152 %r1367, %r1369
%r1372 = getelementptr i64, i64* %r2, i32 9
%r1373 = load i64, i64* %r1372
%r1375 = getelementptr i64, i64* %r2, i32 10
%r1376 = load i64, i64* %r1375
%r1377 = call i128 @mul64x64L(i64 %r1373, i64 %r1376)
%r1378 = zext i1152 %r1370 to i1280
%r1379 = zext i128 %r1377 to i1280
%r1380 = shl i1280 %r1379, 1152
%r1381 = or i1280 %r1378, %r1380
%r1383 = getelementptr i64, i64* %r2, i32 10
%r1384 = load i64, i64* %r1383
%r1386 = getelementptr i64, i64* %r2, i32 11
%r1387 = load i64, i64* %r1386
%r1388 = call i128 @mul64x64L(i64 %r1384, i64 %r1387)
%r1389 = zext i1280 %r1381 to i1408
%r1390 = zext i128 %r1388 to i1408
%r1391 = shl i1408 %r1390, 1280
%r1392 = or i1408 %r1389, %r1391
%r1394 = getelementptr i64, i64* %r2, i32 11
%r1395 = load i64, i64* %r1394
%r1397 = getelementptr i64, i64* %r2, i32 12
%r1398 = load i64, i64* %r1397
%r1399 = call i128 @mul64x64L(i64 %r1395, i64 %r1398)
%r1400 = zext i1408 %r1392 to i1536
%r1401 = zext i128 %r1399 to i1536
%r1402 = shl i1536 %r1401, 1408
%r1403 = or i1536 %r1400, %r1402
%r1405 = getelementptr i64, i64* %r2, i32 12
%r1406 = load i64, i64* %r1405
%r1408 = getelementptr i64, i64* %r2, i32 13
%r1409 = load i64, i64* %r1408
%r1410 = call i128 @mul64x64L(i64 %r1406, i64 %r1409)
%r1411 = zext i1536 %r1403 to i1664
%r1412 = zext i128 %r1410 to i1664
%r1413 = shl i1664 %r1412, 1536
%r1414 = or i1664 %r1411, %r1413
%r1416 = getelementptr i64, i64* %r2, i32 13
%r1417 = load i64, i64* %r1416
%r1419 = getelementptr i64, i64* %r2, i32 14
%r1420 = load i64, i64* %r1419
%r1421 = call i128 @mul64x64L(i64 %r1417, i64 %r1420)
%r1422 = zext i1664 %r1414 to i1792
%r1423 = zext i128 %r1421 to i1792
%r1424 = shl i1792 %r1423, 1664
%r1425 = or i1792 %r1422, %r1424
%r1427 = getelementptr i64, i64* %r2, i32 14
%r1428 = load i64, i64* %r1427
%r1430 = getelementptr i64, i64* %r2, i32 15
%r1431 = load i64, i64* %r1430
%r1432 = call i128 @mul64x64L(i64 %r1428, i64 %r1431)
%r1433 = zext i1792 %r1425 to i1920
%r1434 = zext i128 %r1432 to i1920
%r1435 = shl i1920 %r1434, 1792
%r1436 = or i1920 %r1433, %r1435
%r1438 = getelementptr i64, i64* %r2, i32 15
%r1439 = load i64, i64* %r1438
%r1441 = getelementptr i64, i64* %r2, i32 16
%r1442 = load i64, i64* %r1441
%r1443 = call i128 @mul64x64L(i64 %r1439, i64 %r1442)
%r1444 = zext i1920 %r1436 to i2048
%r1445 = zext i128 %r1443 to i2048
%r1446 = shl i2048 %r1445, 1920
%r1447 = or i2048 %r1444, %r1446
%r1448 = zext i1920 %r1277 to i2048
%r1449 = shl i2048 %r1448, 64
%r1450 = add i2048 %r1449, %r1447
%r1451 = zext i128 %r6 to i2112
%r1453 = getelementptr i64, i64* %r2, i32 1
%r1454 = load i64, i64* %r1453
%r1455 = call i128 @mul64x64L(i64 %r1454, i64 %r1454)
%r1456 = zext i128 %r1455 to i2112
%r1457 = shl i2112 %r1456, 64
%r1458 = or i2112 %r1451, %r1457
%r1460 = getelementptr i64, i64* %r2, i32 2
%r1461 = load i64, i64* %r1460
%r1462 = call i128 @mul64x64L(i64 %r1461, i64 %r1461)
%r1463 = zext i128 %r1462 to i2112
%r1464 = shl i2112 %r1463, 192
%r1465 = or i2112 %r1458, %r1464
%r1467 = getelementptr i64, i64* %r2, i32 3
%r1468 = load i64, i64* %r1467
%r1469 = call i128 @mul64x64L(i64 %r1468, i64 %r1468)
%r1470 = zext i128 %r1469 to i2112
%r1471 = shl i2112 %r1470, 320
%r1472 = or i2112 %r1465, %r1471
%r1474 = getelementptr i64, i64* %r2, i32 4
%r1475 = load i64, i64* %r1474
%r1476 = call i128 @mul64x64L(i64 %r1475, i64 %r1475)
%r1477 = zext i128 %r1476 to i2112
%r1478 = shl i2112 %r1477, 448
%r1479 = or i2112 %r1472, %r1478
%r1481 = getelementptr i64, i64* %r2, i32 5
%r1482 = load i64, i64* %r1481
%r1483 = call i128 @mul64x64L(i64 %r1482, i64 %r1482)
%r1484 = zext i128 %r1483 to i2112
%r1485 = shl i2112 %r1484, 576
%r1486 = or i2112 %r1479, %r1485
%r1488 = getelementptr i64, i64* %r2, i32 6
%r1489 = load i64, i64* %r1488
%r1490 = call i128 @mul64x64L(i64 %r1489, i64 %r1489)
%r1491 = zext i128 %r1490 to i2112
%r1492 = shl i2112 %r1491, 704
%r1493 = or i2112 %r1486, %r1492
%r1495 = getelementptr i64, i64* %r2, i32 7
%r1496 = load i64, i64* %r1495
%r1497 = call i128 @mul64x64L(i64 %r1496, i64 %r1496)
%r1498 = zext i128 %r1497 to i2112
%r1499 = shl i2112 %r1498, 832
%r1500 = or i2112 %r1493, %r1499
%r1502 = getelementptr i64, i64* %r2, i32 8
%r1503 = load i64, i64* %r1502
%r1504 = call i128 @mul64x64L(i64 %r1503, i64 %r1503)
%r1505 = zext i128 %r1504 to i2112
%r1506 = shl i2112 %r1505, 960
%r1507 = or i2112 %r1500, %r1506
%r1509 = getelementptr i64, i64* %r2, i32 9
%r1510 = load i64, i64* %r1509
%r1511 = call i128 @mul64x64L(i64 %r1510, i64 %r1510)
%r1512 = zext i128 %r1511 to i2112
%r1513 = shl i2112 %r1512, 1088
%r1514 = or i2112 %r1507, %r1513
%r1516 = getelementptr i64, i64* %r2, i32 10
%r1517 = load i64, i64* %r1516
%r1518 = call i128 @mul64x64L(i64 %r1517, i64 %r1517)
%r1519 = zext i128 %r1518 to i2112
%r1520 = shl i2112 %r1519, 1216
%r1521 = or i2112 %r1514, %r1520
%r1523 = getelementptr i64, i64* %r2, i32 11
%r1524 = load i64, i64* %r1523
%r1525 = call i128 @mul64x64L(i64 %r1524, i64 %r1524)
%r1526 = zext i128 %r1525 to i2112
%r1527 = shl i2112 %r1526, 1344
%r1528 = or i2112 %r1521, %r1527
%r1530 = getelementptr i64, i64* %r2, i32 12
%r1531 = load i64, i64* %r1530
%r1532 = call i128 @mul64x64L(i64 %r1531, i64 %r1531)
%r1533 = zext i128 %r1532 to i2112
%r1534 = shl i2112 %r1533, 1472
%r1535 = or i2112 %r1528, %r1534
%r1537 = getelementptr i64, i64* %r2, i32 13
%r1538 = load i64, i64* %r1537
%r1539 = call i128 @mul64x64L(i64 %r1538, i64 %r1538)
%r1540 = zext i128 %r1539 to i2112
%r1541 = shl i2112 %r1540, 1600
%r1542 = or i2112 %r1535, %r1541
%r1544 = getelementptr i64, i64* %r2, i32 14
%r1545 = load i64, i64* %r1544
%r1546 = call i128 @mul64x64L(i64 %r1545, i64 %r1545)
%r1547 = zext i128 %r1546 to i2112
%r1548 = shl i2112 %r1547, 1728
%r1549 = or i2112 %r1542, %r1548
%r1551 = getelementptr i64, i64* %r2, i32 15
%r1552 = load i64, i64* %r1551
%r1553 = call i128 @mul64x64L(i64 %r1552, i64 %r1552)
%r1554 = zext i128 %r1553 to i2112
%r1555 = shl i2112 %r1554, 1856
%r1556 = or i2112 %r1549, %r1555
%r1558 = getelementptr i64, i64* %r2, i32 16
%r1559 = load i64, i64* %r1558
%r1560 = call i128 @mul64x64L(i64 %r1559, i64 %r1559)
%r1561 = zext i128 %r1560 to i2112
%r1562 = shl i2112 %r1561, 1984
%r1563 = or i2112 %r1556, %r1562
%r1564 = zext i2048 %r1450 to i2112
%r1565 = add i2112 %r1564, %r1564
%r1566 = add i2112 %r1563, %r1565
%r1568 = getelementptr i64, i64* %r1, i32 1
%r1570 = getelementptr i64, i64* %r1568, i32 0
%r1571 = trunc i2112 %r1566 to i64
store i64 %r1571, i64* %r1570
%r1572 = lshr i2112 %r1566, 64
%r1574 = getelementptr i64, i64* %r1568, i32 1
%r1575 = trunc i2112 %r1572 to i64
store i64 %r1575, i64* %r1574
%r1576 = lshr i2112 %r1572, 64
%r1578 = getelementptr i64, i64* %r1568, i32 2
%r1579 = trunc i2112 %r1576 to i64
store i64 %r1579, i64* %r1578
%r1580 = lshr i2112 %r1576, 64
%r1582 = getelementptr i64, i64* %r1568, i32 3
%r1583 = trunc i2112 %r1580 to i64
store i64 %r1583, i64* %r1582
%r1584 = lshr i2112 %r1580, 64
%r1586 = getelementptr i64, i64* %r1568, i32 4
%r1587 = trunc i2112 %r1584 to i64
store i64 %r1587, i64* %r1586
%r1588 = lshr i2112 %r1584, 64
%r1590 = getelementptr i64, i64* %r1568, i32 5
%r1591 = trunc i2112 %r1588 to i64
store i64 %r1591, i64* %r1590
%r1592 = lshr i2112 %r1588, 64
%r1594 = getelementptr i64, i64* %r1568, i32 6
%r1595 = trunc i2112 %r1592 to i64
store i64 %r1595, i64* %r1594
%r1596 = lshr i2112 %r1592, 64
%r1598 = getelementptr i64, i64* %r1568, i32 7
%r1599 = trunc i2112 %r1596 to i64
store i64 %r1599, i64* %r1598
%r1600 = lshr i2112 %r1596, 64
%r1602 = getelementptr i64, i64* %r1568, i32 8
%r1603 = trunc i2112 %r1600 to i64
store i64 %r1603, i64* %r1602
%r1604 = lshr i2112 %r1600, 64
%r1606 = getelementptr i64, i64* %r1568, i32 9
%r1607 = trunc i2112 %r1604 to i64
store i64 %r1607, i64* %r1606
%r1608 = lshr i2112 %r1604, 64
%r1610 = getelementptr i64, i64* %r1568, i32 10
%r1611 = trunc i2112 %r1608 to i64
store i64 %r1611, i64* %r1610
%r1612 = lshr i2112 %r1608, 64
%r1614 = getelementptr i64, i64* %r1568, i32 11
%r1615 = trunc i2112 %r1612 to i64
store i64 %r1615, i64* %r1614
%r1616 = lshr i2112 %r1612, 64
%r1618 = getelementptr i64, i64* %r1568, i32 12
%r1619 = trunc i2112 %r1616 to i64
store i64 %r1619, i64* %r1618
%r1620 = lshr i2112 %r1616, 64
%r1622 = getelementptr i64, i64* %r1568, i32 13
%r1623 = trunc i2112 %r1620 to i64
store i64 %r1623, i64* %r1622
%r1624 = lshr i2112 %r1620, 64
%r1626 = getelementptr i64, i64* %r1568, i32 14
%r1627 = trunc i2112 %r1624 to i64
store i64 %r1627, i64* %r1626
%r1628 = lshr i2112 %r1624, 64
%r1630 = getelementptr i64, i64* %r1568, i32 15
%r1631 = trunc i2112 %r1628 to i64
store i64 %r1631, i64* %r1630
%r1632 = lshr i2112 %r1628, 64
%r1634 = getelementptr i64, i64* %r1568, i32 16
%r1635 = trunc i2112 %r1632 to i64
store i64 %r1635, i64* %r1634
%r1636 = lshr i2112 %r1632, 64
%r1638 = getelementptr i64, i64* %r1568, i32 17
%r1639 = trunc i2112 %r1636 to i64
store i64 %r1639, i64* %r1638
%r1640 = lshr i2112 %r1636, 64
%r1642 = getelementptr i64, i64* %r1568, i32 18
%r1643 = trunc i2112 %r1640 to i64
store i64 %r1643, i64* %r1642
%r1644 = lshr i2112 %r1640, 64
%r1646 = getelementptr i64, i64* %r1568, i32 19
%r1647 = trunc i2112 %r1644 to i64
store i64 %r1647, i64* %r1646
%r1648 = lshr i2112 %r1644, 64
%r1650 = getelementptr i64, i64* %r1568, i32 20
%r1651 = trunc i2112 %r1648 to i64
store i64 %r1651, i64* %r1650
%r1652 = lshr i2112 %r1648, 64
%r1654 = getelementptr i64, i64* %r1568, i32 21
%r1655 = trunc i2112 %r1652 to i64
store i64 %r1655, i64* %r1654
%r1656 = lshr i2112 %r1652, 64
%r1658 = getelementptr i64, i64* %r1568, i32 22
%r1659 = trunc i2112 %r1656 to i64
store i64 %r1659, i64* %r1658
%r1660 = lshr i2112 %r1656, 64
%r1662 = getelementptr i64, i64* %r1568, i32 23
%r1663 = trunc i2112 %r1660 to i64
store i64 %r1663, i64* %r1662
%r1664 = lshr i2112 %r1660, 64
%r1666 = getelementptr i64, i64* %r1568, i32 24
%r1667 = trunc i2112 %r1664 to i64
store i64 %r1667, i64* %r1666
%r1668 = lshr i2112 %r1664, 64
%r1670 = getelementptr i64, i64* %r1568, i32 25
%r1671 = trunc i2112 %r1668 to i64
store i64 %r1671, i64* %r1670
%r1672 = lshr i2112 %r1668, 64
%r1674 = getelementptr i64, i64* %r1568, i32 26
%r1675 = trunc i2112 %r1672 to i64
store i64 %r1675, i64* %r1674
%r1676 = lshr i2112 %r1672, 64
%r1678 = getelementptr i64, i64* %r1568, i32 27
%r1679 = trunc i2112 %r1676 to i64
store i64 %r1679, i64* %r1678
%r1680 = lshr i2112 %r1676, 64
%r1682 = getelementptr i64, i64* %r1568, i32 28
%r1683 = trunc i2112 %r1680 to i64
store i64 %r1683, i64* %r1682
%r1684 = lshr i2112 %r1680, 64
%r1686 = getelementptr i64, i64* %r1568, i32 29
%r1687 = trunc i2112 %r1684 to i64
store i64 %r1687, i64* %r1686
%r1688 = lshr i2112 %r1684, 64
%r1690 = getelementptr i64, i64* %r1568, i32 30
%r1691 = trunc i2112 %r1688 to i64
store i64 %r1691, i64* %r1690
%r1692 = lshr i2112 %r1688, 64
%r1694 = getelementptr i64, i64* %r1568, i32 31
%r1695 = trunc i2112 %r1692 to i64
store i64 %r1695, i64* %r1694
%r1696 = lshr i2112 %r1692, 64
%r1698 = getelementptr i64, i64* %r1568, i32 32
%r1699 = trunc i2112 %r1696 to i64
store i64 %r1699, i64* %r1698
ret void
}
define private i1088 @mulUnit2_inner1088(i64* noalias  %r2, i64 %r3)
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
%r41 = call i128 @mulPos64x64(i64* %r2, i64 %r3, i64 9)
%r42 = trunc i128 %r41 to i64
%r43 = call i64 @extractHigh64(i128 %r41)
%r45 = call i128 @mulPos64x64(i64* %r2, i64 %r3, i64 10)
%r46 = trunc i128 %r45 to i64
%r47 = call i64 @extractHigh64(i128 %r45)
%r49 = call i128 @mulPos64x64(i64* %r2, i64 %r3, i64 11)
%r50 = trunc i128 %r49 to i64
%r51 = call i64 @extractHigh64(i128 %r49)
%r53 = call i128 @mulPos64x64(i64* %r2, i64 %r3, i64 12)
%r54 = trunc i128 %r53 to i64
%r55 = call i64 @extractHigh64(i128 %r53)
%r57 = call i128 @mulPos64x64(i64* %r2, i64 %r3, i64 13)
%r58 = trunc i128 %r57 to i64
%r59 = call i64 @extractHigh64(i128 %r57)
%r61 = call i128 @mulPos64x64(i64* %r2, i64 %r3, i64 14)
%r62 = trunc i128 %r61 to i64
%r63 = call i64 @extractHigh64(i128 %r61)
%r65 = call i128 @mulPos64x64(i64* %r2, i64 %r3, i64 15)
%r66 = trunc i128 %r65 to i64
%r67 = call i64 @extractHigh64(i128 %r65)
%r69 = call i128 @mulPos64x64(i64* %r2, i64 %r3, i64 16)
%r70 = trunc i128 %r69 to i64
%r71 = zext i64 %r6 to i128
%r72 = zext i64 %r10 to i128
%r73 = shl i128 %r72, 64
%r74 = or i128 %r71, %r73
%r75 = zext i128 %r74 to i192
%r76 = zext i64 %r14 to i192
%r77 = shl i192 %r76, 128
%r78 = or i192 %r75, %r77
%r79 = zext i192 %r78 to i256
%r80 = zext i64 %r18 to i256
%r81 = shl i256 %r80, 192
%r82 = or i256 %r79, %r81
%r83 = zext i256 %r82 to i320
%r84 = zext i64 %r22 to i320
%r85 = shl i320 %r84, 256
%r86 = or i320 %r83, %r85
%r87 = zext i320 %r86 to i384
%r88 = zext i64 %r26 to i384
%r89 = shl i384 %r88, 320
%r90 = or i384 %r87, %r89
%r91 = zext i384 %r90 to i448
%r92 = zext i64 %r30 to i448
%r93 = shl i448 %r92, 384
%r94 = or i448 %r91, %r93
%r95 = zext i448 %r94 to i512
%r96 = zext i64 %r34 to i512
%r97 = shl i512 %r96, 448
%r98 = or i512 %r95, %r97
%r99 = zext i512 %r98 to i576
%r100 = zext i64 %r38 to i576
%r101 = shl i576 %r100, 512
%r102 = or i576 %r99, %r101
%r103 = zext i576 %r102 to i640
%r104 = zext i64 %r42 to i640
%r105 = shl i640 %r104, 576
%r106 = or i640 %r103, %r105
%r107 = zext i640 %r106 to i704
%r108 = zext i64 %r46 to i704
%r109 = shl i704 %r108, 640
%r110 = or i704 %r107, %r109
%r111 = zext i704 %r110 to i768
%r112 = zext i64 %r50 to i768
%r113 = shl i768 %r112, 704
%r114 = or i768 %r111, %r113
%r115 = zext i768 %r114 to i832
%r116 = zext i64 %r54 to i832
%r117 = shl i832 %r116, 768
%r118 = or i832 %r115, %r117
%r119 = zext i832 %r118 to i896
%r120 = zext i64 %r58 to i896
%r121 = shl i896 %r120, 832
%r122 = or i896 %r119, %r121
%r123 = zext i896 %r122 to i960
%r124 = zext i64 %r62 to i960
%r125 = shl i960 %r124, 896
%r126 = or i960 %r123, %r125
%r127 = zext i960 %r126 to i1024
%r128 = zext i64 %r66 to i1024
%r129 = shl i1024 %r128, 960
%r130 = or i1024 %r127, %r129
%r131 = zext i1024 %r130 to i1088
%r132 = zext i64 %r70 to i1088
%r133 = shl i1088 %r132, 1024
%r134 = or i1088 %r131, %r133
%r135 = zext i64 %r7 to i128
%r136 = zext i64 %r11 to i128
%r137 = shl i128 %r136, 64
%r138 = or i128 %r135, %r137
%r139 = zext i128 %r138 to i192
%r140 = zext i64 %r15 to i192
%r141 = shl i192 %r140, 128
%r142 = or i192 %r139, %r141
%r143 = zext i192 %r142 to i256
%r144 = zext i64 %r19 to i256
%r145 = shl i256 %r144, 192
%r146 = or i256 %r143, %r145
%r147 = zext i256 %r146 to i320
%r148 = zext i64 %r23 to i320
%r149 = shl i320 %r148, 256
%r150 = or i320 %r147, %r149
%r151 = zext i320 %r150 to i384
%r152 = zext i64 %r27 to i384
%r153 = shl i384 %r152, 320
%r154 = or i384 %r151, %r153
%r155 = zext i384 %r154 to i448
%r156 = zext i64 %r31 to i448
%r157 = shl i448 %r156, 384
%r158 = or i448 %r155, %r157
%r159 = zext i448 %r158 to i512
%r160 = zext i64 %r35 to i512
%r161 = shl i512 %r160, 448
%r162 = or i512 %r159, %r161
%r163 = zext i512 %r162 to i576
%r164 = zext i64 %r39 to i576
%r165 = shl i576 %r164, 512
%r166 = or i576 %r163, %r165
%r167 = zext i576 %r166 to i640
%r168 = zext i64 %r43 to i640
%r169 = shl i640 %r168, 576
%r170 = or i640 %r167, %r169
%r171 = zext i640 %r170 to i704
%r172 = zext i64 %r47 to i704
%r173 = shl i704 %r172, 640
%r174 = or i704 %r171, %r173
%r175 = zext i704 %r174 to i768
%r176 = zext i64 %r51 to i768
%r177 = shl i768 %r176, 704
%r178 = or i768 %r175, %r177
%r179 = zext i768 %r178 to i832
%r180 = zext i64 %r55 to i832
%r181 = shl i832 %r180, 768
%r182 = or i832 %r179, %r181
%r183 = zext i832 %r182 to i896
%r184 = zext i64 %r59 to i896
%r185 = shl i896 %r184, 832
%r186 = or i896 %r183, %r185
%r187 = zext i896 %r186 to i960
%r188 = zext i64 %r63 to i960
%r189 = shl i960 %r188, 896
%r190 = or i960 %r187, %r189
%r191 = zext i960 %r190 to i1024
%r192 = zext i64 %r67 to i1024
%r193 = shl i1024 %r192, 960
%r194 = or i1024 %r191, %r193
%r195 = zext i1024 %r194 to i1088
%r196 = shl i1088 %r195, 64
%r197 = add i1088 %r134, %r196
ret i1088 %r197
}
