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
