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
define i64 @mclb_add1(i64* noalias %r1, i64* noalias %r2, i64* noalias %r3)
{
%r5 = load i64, i64* %r2
%r6 = zext i64 %r5 to i128
%r7 = load i64, i64* %r3
%r8 = zext i64 %r7 to i128
%r9 = add i128 %r6, %r8
%r10 = trunc i128 %r9 to i64
store i64 %r10, i64* %r1
%r11 = lshr i128 %r9, 64
%r12 = trunc i128 %r11 to i64
ret i64 %r12
}
define i64 @mclb_sub1(i64* noalias %r1, i64* noalias %r2, i64* noalias %r3)
{
%r5 = load i64, i64* %r2
%r6 = zext i64 %r5 to i128
%r7 = load i64, i64* %r3
%r8 = zext i64 %r7 to i128
%r9 = sub i128 %r6, %r8
%r10 = trunc i128 %r9 to i64
store i64 %r10, i64* %r1
%r11 = lshr i128 %r9, 64
%r12 = trunc i128 %r11 to i64
%r13 = and i64 %r12, 1
ret i64 %r13
}
define void @mclb_addNF1(i64* noalias %r1, i64* noalias %r2, i64* noalias %r3)
{
%r4 = load i64, i64* %r2
%r5 = load i64, i64* %r3
%r6 = add i64 %r4, %r5
store i64 %r6, i64* %r1
ret void
}
define i64 @mclb_subNF1(i64* noalias %r1, i64* noalias %r2, i64* noalias %r3)
{
%r5 = load i64, i64* %r2
%r6 = load i64, i64* %r3
%r7 = sub i64 %r5, %r6
store i64 %r7, i64* %r1
%r8 = lshr i64 %r7, 63
%r9 = and i64 %r8, 1
ret i64 %r9
}
define i64 @mclb_add2(i64* noalias %r1, i64* noalias %r2, i64* noalias %r3)
{
%r5 = bitcast i64* %r2 to i128*
%r6 = load i128, i128* %r5
%r7 = zext i128 %r6 to i192
%r8 = bitcast i64* %r3 to i128*
%r9 = load i128, i128* %r8
%r10 = zext i128 %r9 to i192
%r11 = add i192 %r7, %r10
%r12 = trunc i192 %r11 to i128
%r13 = bitcast i64* %r1 to i128*
store i128 %r12, i128* %r13
%r14 = lshr i192 %r11, 128
%r15 = trunc i192 %r14 to i64
ret i64 %r15
}
define i64 @mclb_sub2(i64* noalias %r1, i64* noalias %r2, i64* noalias %r3)
{
%r5 = bitcast i64* %r2 to i128*
%r6 = load i128, i128* %r5
%r7 = zext i128 %r6 to i192
%r8 = bitcast i64* %r3 to i128*
%r9 = load i128, i128* %r8
%r10 = zext i128 %r9 to i192
%r11 = sub i192 %r7, %r10
%r12 = trunc i192 %r11 to i128
%r13 = bitcast i64* %r1 to i128*
store i128 %r12, i128* %r13
%r14 = lshr i192 %r11, 128
%r15 = trunc i192 %r14 to i64
%r16 = and i64 %r15, 1
ret i64 %r16
}
define void @mclb_addNF2(i64* noalias %r1, i64* noalias %r2, i64* noalias %r3)
{
%r4 = bitcast i64* %r2 to i128*
%r5 = load i128, i128* %r4
%r6 = bitcast i64* %r3 to i128*
%r7 = load i128, i128* %r6
%r8 = add i128 %r5, %r7
%r9 = bitcast i64* %r1 to i128*
store i128 %r8, i128* %r9
ret void
}
define i64 @mclb_subNF2(i64* noalias %r1, i64* noalias %r2, i64* noalias %r3)
{
%r5 = bitcast i64* %r2 to i128*
%r6 = load i128, i128* %r5
%r7 = bitcast i64* %r3 to i128*
%r8 = load i128, i128* %r7
%r9 = sub i128 %r6, %r8
%r10 = bitcast i64* %r1 to i128*
store i128 %r9, i128* %r10
%r11 = lshr i128 %r9, 127
%r12 = trunc i128 %r11 to i64
%r13 = and i64 %r12, 1
ret i64 %r13
}
define i64 @mclb_add3(i64* noalias %r1, i64* noalias %r2, i64* noalias %r3)
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
define i64 @mclb_sub3(i64* noalias %r1, i64* noalias %r2, i64* noalias %r3)
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
define void @mclb_addNF3(i64* noalias %r1, i64* noalias %r2, i64* noalias %r3)
{
%r4 = bitcast i64* %r2 to i192*
%r5 = load i192, i192* %r4
%r6 = bitcast i64* %r3 to i192*
%r7 = load i192, i192* %r6
%r8 = add i192 %r5, %r7
%r9 = bitcast i64* %r1 to i192*
store i192 %r8, i192* %r9
ret void
}
define i64 @mclb_subNF3(i64* noalias %r1, i64* noalias %r2, i64* noalias %r3)
{
%r5 = bitcast i64* %r2 to i192*
%r6 = load i192, i192* %r5
%r7 = bitcast i64* %r3 to i192*
%r8 = load i192, i192* %r7
%r9 = sub i192 %r6, %r8
%r10 = bitcast i64* %r1 to i192*
store i192 %r9, i192* %r10
%r11 = lshr i192 %r9, 191
%r12 = trunc i192 %r11 to i64
%r13 = and i64 %r12, 1
ret i64 %r13
}
define i64 @mclb_add4(i64* noalias %r1, i64* noalias %r2, i64* noalias %r3)
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
define i64 @mclb_sub4(i64* noalias %r1, i64* noalias %r2, i64* noalias %r3)
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
define void @mclb_addNF4(i64* noalias %r1, i64* noalias %r2, i64* noalias %r3)
{
%r4 = bitcast i64* %r2 to i256*
%r5 = load i256, i256* %r4
%r6 = bitcast i64* %r3 to i256*
%r7 = load i256, i256* %r6
%r8 = add i256 %r5, %r7
%r9 = bitcast i64* %r1 to i256*
store i256 %r8, i256* %r9
ret void
}
define i64 @mclb_subNF4(i64* noalias %r1, i64* noalias %r2, i64* noalias %r3)
{
%r5 = bitcast i64* %r2 to i256*
%r6 = load i256, i256* %r5
%r7 = bitcast i64* %r3 to i256*
%r8 = load i256, i256* %r7
%r9 = sub i256 %r6, %r8
%r10 = bitcast i64* %r1 to i256*
store i256 %r9, i256* %r10
%r11 = lshr i256 %r9, 255
%r12 = trunc i256 %r11 to i64
%r13 = and i64 %r12, 1
ret i64 %r13
}
define i64 @mclb_add5(i64* noalias %r1, i64* noalias %r2, i64* noalias %r3)
{
%r5 = bitcast i64* %r2 to i320*
%r6 = load i320, i320* %r5
%r7 = zext i320 %r6 to i384
%r8 = bitcast i64* %r3 to i320*
%r9 = load i320, i320* %r8
%r10 = zext i320 %r9 to i384
%r11 = add i384 %r7, %r10
%r12 = trunc i384 %r11 to i320
%r13 = bitcast i64* %r1 to i320*
store i320 %r12, i320* %r13
%r14 = lshr i384 %r11, 320
%r15 = trunc i384 %r14 to i64
ret i64 %r15
}
define i64 @mclb_sub5(i64* noalias %r1, i64* noalias %r2, i64* noalias %r3)
{
%r5 = bitcast i64* %r2 to i320*
%r6 = load i320, i320* %r5
%r7 = zext i320 %r6 to i384
%r8 = bitcast i64* %r3 to i320*
%r9 = load i320, i320* %r8
%r10 = zext i320 %r9 to i384
%r11 = sub i384 %r7, %r10
%r12 = trunc i384 %r11 to i320
%r13 = bitcast i64* %r1 to i320*
store i320 %r12, i320* %r13
%r14 = lshr i384 %r11, 320
%r15 = trunc i384 %r14 to i64
%r16 = and i64 %r15, 1
ret i64 %r16
}
define void @mclb_addNF5(i64* noalias %r1, i64* noalias %r2, i64* noalias %r3)
{
%r4 = bitcast i64* %r2 to i320*
%r5 = load i320, i320* %r4
%r6 = bitcast i64* %r3 to i320*
%r7 = load i320, i320* %r6
%r8 = add i320 %r5, %r7
%r9 = bitcast i64* %r1 to i320*
store i320 %r8, i320* %r9
ret void
}
define i64 @mclb_subNF5(i64* noalias %r1, i64* noalias %r2, i64* noalias %r3)
{
%r5 = bitcast i64* %r2 to i320*
%r6 = load i320, i320* %r5
%r7 = bitcast i64* %r3 to i320*
%r8 = load i320, i320* %r7
%r9 = sub i320 %r6, %r8
%r10 = bitcast i64* %r1 to i320*
store i320 %r9, i320* %r10
%r11 = lshr i320 %r9, 319
%r12 = trunc i320 %r11 to i64
%r13 = and i64 %r12, 1
ret i64 %r13
}
define i64 @mclb_add6(i64* noalias %r1, i64* noalias %r2, i64* noalias %r3)
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
define i64 @mclb_sub6(i64* noalias %r1, i64* noalias %r2, i64* noalias %r3)
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
define void @mclb_addNF6(i64* noalias %r1, i64* noalias %r2, i64* noalias %r3)
{
%r4 = bitcast i64* %r2 to i384*
%r5 = load i384, i384* %r4
%r6 = bitcast i64* %r3 to i384*
%r7 = load i384, i384* %r6
%r8 = add i384 %r5, %r7
%r9 = bitcast i64* %r1 to i384*
store i384 %r8, i384* %r9
ret void
}
define i64 @mclb_subNF6(i64* noalias %r1, i64* noalias %r2, i64* noalias %r3)
{
%r5 = bitcast i64* %r2 to i384*
%r6 = load i384, i384* %r5
%r7 = bitcast i64* %r3 to i384*
%r8 = load i384, i384* %r7
%r9 = sub i384 %r6, %r8
%r10 = bitcast i64* %r1 to i384*
store i384 %r9, i384* %r10
%r11 = lshr i384 %r9, 383
%r12 = trunc i384 %r11 to i64
%r13 = and i64 %r12, 1
ret i64 %r13
}
define i64 @mclb_add7(i64* noalias %r1, i64* noalias %r2, i64* noalias %r3)
{
%r5 = bitcast i64* %r2 to i448*
%r6 = load i448, i448* %r5
%r7 = zext i448 %r6 to i512
%r8 = bitcast i64* %r3 to i448*
%r9 = load i448, i448* %r8
%r10 = zext i448 %r9 to i512
%r11 = add i512 %r7, %r10
%r12 = trunc i512 %r11 to i448
%r13 = bitcast i64* %r1 to i448*
store i448 %r12, i448* %r13
%r14 = lshr i512 %r11, 448
%r15 = trunc i512 %r14 to i64
ret i64 %r15
}
define i64 @mclb_sub7(i64* noalias %r1, i64* noalias %r2, i64* noalias %r3)
{
%r5 = bitcast i64* %r2 to i448*
%r6 = load i448, i448* %r5
%r7 = zext i448 %r6 to i512
%r8 = bitcast i64* %r3 to i448*
%r9 = load i448, i448* %r8
%r10 = zext i448 %r9 to i512
%r11 = sub i512 %r7, %r10
%r12 = trunc i512 %r11 to i448
%r13 = bitcast i64* %r1 to i448*
store i448 %r12, i448* %r13
%r14 = lshr i512 %r11, 448
%r15 = trunc i512 %r14 to i64
%r16 = and i64 %r15, 1
ret i64 %r16
}
define void @mclb_addNF7(i64* noalias %r1, i64* noalias %r2, i64* noalias %r3)
{
%r4 = bitcast i64* %r2 to i448*
%r5 = load i448, i448* %r4
%r6 = bitcast i64* %r3 to i448*
%r7 = load i448, i448* %r6
%r8 = add i448 %r5, %r7
%r9 = bitcast i64* %r1 to i448*
store i448 %r8, i448* %r9
ret void
}
define i64 @mclb_subNF7(i64* noalias %r1, i64* noalias %r2, i64* noalias %r3)
{
%r5 = bitcast i64* %r2 to i448*
%r6 = load i448, i448* %r5
%r7 = bitcast i64* %r3 to i448*
%r8 = load i448, i448* %r7
%r9 = sub i448 %r6, %r8
%r10 = bitcast i64* %r1 to i448*
store i448 %r9, i448* %r10
%r11 = lshr i448 %r9, 447
%r12 = trunc i448 %r11 to i64
%r13 = and i64 %r12, 1
ret i64 %r13
}
define i64 @mclb_add8(i64* noalias %r1, i64* noalias %r2, i64* noalias %r3)
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
define i64 @mclb_sub8(i64* noalias %r1, i64* noalias %r2, i64* noalias %r3)
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
define void @mclb_addNF8(i64* noalias %r1, i64* noalias %r2, i64* noalias %r3)
{
%r4 = bitcast i64* %r2 to i512*
%r5 = load i512, i512* %r4
%r6 = bitcast i64* %r3 to i512*
%r7 = load i512, i512* %r6
%r8 = add i512 %r5, %r7
%r9 = bitcast i64* %r1 to i512*
store i512 %r8, i512* %r9
ret void
}
define i64 @mclb_subNF8(i64* noalias %r1, i64* noalias %r2, i64* noalias %r3)
{
%r5 = bitcast i64* %r2 to i512*
%r6 = load i512, i512* %r5
%r7 = bitcast i64* %r3 to i512*
%r8 = load i512, i512* %r7
%r9 = sub i512 %r6, %r8
%r10 = bitcast i64* %r1 to i512*
store i512 %r9, i512* %r10
%r11 = lshr i512 %r9, 511
%r12 = trunc i512 %r11 to i64
%r13 = and i64 %r12, 1
ret i64 %r13
}
define i64 @mclb_add9(i64* noalias %r1, i64* noalias %r2, i64* noalias %r3)
{
%r5 = bitcast i64* %r2 to i576*
%r6 = load i576, i576* %r5
%r7 = zext i576 %r6 to i640
%r8 = bitcast i64* %r3 to i576*
%r9 = load i576, i576* %r8
%r10 = zext i576 %r9 to i640
%r11 = add i640 %r7, %r10
%r12 = trunc i640 %r11 to i576
%r13 = bitcast i64* %r1 to i576*
store i576 %r12, i576* %r13
%r14 = lshr i640 %r11, 576
%r15 = trunc i640 %r14 to i64
ret i64 %r15
}
define i64 @mclb_sub9(i64* noalias %r1, i64* noalias %r2, i64* noalias %r3)
{
%r5 = bitcast i64* %r2 to i576*
%r6 = load i576, i576* %r5
%r7 = zext i576 %r6 to i640
%r8 = bitcast i64* %r3 to i576*
%r9 = load i576, i576* %r8
%r10 = zext i576 %r9 to i640
%r11 = sub i640 %r7, %r10
%r12 = trunc i640 %r11 to i576
%r13 = bitcast i64* %r1 to i576*
store i576 %r12, i576* %r13
%r14 = lshr i640 %r11, 576
%r15 = trunc i640 %r14 to i64
%r16 = and i64 %r15, 1
ret i64 %r16
}
define void @mclb_addNF9(i64* noalias %r1, i64* noalias %r2, i64* noalias %r3)
{
%r4 = bitcast i64* %r2 to i576*
%r5 = load i576, i576* %r4
%r6 = bitcast i64* %r3 to i576*
%r7 = load i576, i576* %r6
%r8 = add i576 %r5, %r7
%r9 = bitcast i64* %r1 to i576*
store i576 %r8, i576* %r9
ret void
}
define i64 @mclb_subNF9(i64* noalias %r1, i64* noalias %r2, i64* noalias %r3)
{
%r5 = bitcast i64* %r2 to i576*
%r6 = load i576, i576* %r5
%r7 = bitcast i64* %r3 to i576*
%r8 = load i576, i576* %r7
%r9 = sub i576 %r6, %r8
%r10 = bitcast i64* %r1 to i576*
store i576 %r9, i576* %r10
%r11 = lshr i576 %r9, 575
%r12 = trunc i576 %r11 to i64
%r13 = and i64 %r12, 1
ret i64 %r13
}
define i64 @mclb_add10(i64* noalias %r1, i64* noalias %r2, i64* noalias %r3)
{
%r5 = bitcast i64* %r2 to i640*
%r6 = load i640, i640* %r5
%r7 = zext i640 %r6 to i704
%r8 = bitcast i64* %r3 to i640*
%r9 = load i640, i640* %r8
%r10 = zext i640 %r9 to i704
%r11 = add i704 %r7, %r10
%r12 = trunc i704 %r11 to i640
%r13 = bitcast i64* %r1 to i640*
store i640 %r12, i640* %r13
%r14 = lshr i704 %r11, 640
%r15 = trunc i704 %r14 to i64
ret i64 %r15
}
define i64 @mclb_sub10(i64* noalias %r1, i64* noalias %r2, i64* noalias %r3)
{
%r5 = bitcast i64* %r2 to i640*
%r6 = load i640, i640* %r5
%r7 = zext i640 %r6 to i704
%r8 = bitcast i64* %r3 to i640*
%r9 = load i640, i640* %r8
%r10 = zext i640 %r9 to i704
%r11 = sub i704 %r7, %r10
%r12 = trunc i704 %r11 to i640
%r13 = bitcast i64* %r1 to i640*
store i640 %r12, i640* %r13
%r14 = lshr i704 %r11, 640
%r15 = trunc i704 %r14 to i64
%r16 = and i64 %r15, 1
ret i64 %r16
}
define void @mclb_addNF10(i64* noalias %r1, i64* noalias %r2, i64* noalias %r3)
{
%r4 = bitcast i64* %r2 to i640*
%r5 = load i640, i640* %r4
%r6 = bitcast i64* %r3 to i640*
%r7 = load i640, i640* %r6
%r8 = add i640 %r5, %r7
%r9 = bitcast i64* %r1 to i640*
store i640 %r8, i640* %r9
ret void
}
define i64 @mclb_subNF10(i64* noalias %r1, i64* noalias %r2, i64* noalias %r3)
{
%r5 = bitcast i64* %r2 to i640*
%r6 = load i640, i640* %r5
%r7 = bitcast i64* %r3 to i640*
%r8 = load i640, i640* %r7
%r9 = sub i640 %r6, %r8
%r10 = bitcast i64* %r1 to i640*
store i640 %r9, i640* %r10
%r11 = lshr i640 %r9, 639
%r12 = trunc i640 %r11 to i64
%r13 = and i64 %r12, 1
ret i64 %r13
}
define i64 @mclb_add11(i64* noalias %r1, i64* noalias %r2, i64* noalias %r3)
{
%r5 = bitcast i64* %r2 to i704*
%r6 = load i704, i704* %r5
%r7 = zext i704 %r6 to i768
%r8 = bitcast i64* %r3 to i704*
%r9 = load i704, i704* %r8
%r10 = zext i704 %r9 to i768
%r11 = add i768 %r7, %r10
%r12 = trunc i768 %r11 to i704
%r13 = bitcast i64* %r1 to i704*
store i704 %r12, i704* %r13
%r14 = lshr i768 %r11, 704
%r15 = trunc i768 %r14 to i64
ret i64 %r15
}
define i64 @mclb_sub11(i64* noalias %r1, i64* noalias %r2, i64* noalias %r3)
{
%r5 = bitcast i64* %r2 to i704*
%r6 = load i704, i704* %r5
%r7 = zext i704 %r6 to i768
%r8 = bitcast i64* %r3 to i704*
%r9 = load i704, i704* %r8
%r10 = zext i704 %r9 to i768
%r11 = sub i768 %r7, %r10
%r12 = trunc i768 %r11 to i704
%r13 = bitcast i64* %r1 to i704*
store i704 %r12, i704* %r13
%r14 = lshr i768 %r11, 704
%r15 = trunc i768 %r14 to i64
%r16 = and i64 %r15, 1
ret i64 %r16
}
define void @mclb_addNF11(i64* noalias %r1, i64* noalias %r2, i64* noalias %r3)
{
%r4 = bitcast i64* %r2 to i704*
%r5 = load i704, i704* %r4
%r6 = bitcast i64* %r3 to i704*
%r7 = load i704, i704* %r6
%r8 = add i704 %r5, %r7
%r9 = bitcast i64* %r1 to i704*
store i704 %r8, i704* %r9
ret void
}
define i64 @mclb_subNF11(i64* noalias %r1, i64* noalias %r2, i64* noalias %r3)
{
%r5 = bitcast i64* %r2 to i704*
%r6 = load i704, i704* %r5
%r7 = bitcast i64* %r3 to i704*
%r8 = load i704, i704* %r7
%r9 = sub i704 %r6, %r8
%r10 = bitcast i64* %r1 to i704*
store i704 %r9, i704* %r10
%r11 = lshr i704 %r9, 703
%r12 = trunc i704 %r11 to i64
%r13 = and i64 %r12, 1
ret i64 %r13
}
define i64 @mclb_add12(i64* noalias %r1, i64* noalias %r2, i64* noalias %r3)
{
%r5 = bitcast i64* %r2 to i768*
%r6 = load i768, i768* %r5
%r7 = zext i768 %r6 to i832
%r8 = bitcast i64* %r3 to i768*
%r9 = load i768, i768* %r8
%r10 = zext i768 %r9 to i832
%r11 = add i832 %r7, %r10
%r12 = trunc i832 %r11 to i768
%r13 = bitcast i64* %r1 to i768*
store i768 %r12, i768* %r13
%r14 = lshr i832 %r11, 768
%r15 = trunc i832 %r14 to i64
ret i64 %r15
}
define i64 @mclb_sub12(i64* noalias %r1, i64* noalias %r2, i64* noalias %r3)
{
%r5 = bitcast i64* %r2 to i768*
%r6 = load i768, i768* %r5
%r7 = zext i768 %r6 to i832
%r8 = bitcast i64* %r3 to i768*
%r9 = load i768, i768* %r8
%r10 = zext i768 %r9 to i832
%r11 = sub i832 %r7, %r10
%r12 = trunc i832 %r11 to i768
%r13 = bitcast i64* %r1 to i768*
store i768 %r12, i768* %r13
%r14 = lshr i832 %r11, 768
%r15 = trunc i832 %r14 to i64
%r16 = and i64 %r15, 1
ret i64 %r16
}
define void @mclb_addNF12(i64* noalias %r1, i64* noalias %r2, i64* noalias %r3)
{
%r4 = bitcast i64* %r2 to i768*
%r5 = load i768, i768* %r4
%r6 = bitcast i64* %r3 to i768*
%r7 = load i768, i768* %r6
%r8 = add i768 %r5, %r7
%r9 = bitcast i64* %r1 to i768*
store i768 %r8, i768* %r9
ret void
}
define i64 @mclb_subNF12(i64* noalias %r1, i64* noalias %r2, i64* noalias %r3)
{
%r5 = bitcast i64* %r2 to i768*
%r6 = load i768, i768* %r5
%r7 = bitcast i64* %r3 to i768*
%r8 = load i768, i768* %r7
%r9 = sub i768 %r6, %r8
%r10 = bitcast i64* %r1 to i768*
store i768 %r9, i768* %r10
%r11 = lshr i768 %r9, 767
%r12 = trunc i768 %r11 to i64
%r13 = and i64 %r12, 1
ret i64 %r13
}
define i128 @mulUnit_inner64(i64* noalias %r2, i64 %r3)
{
%r4 = call i128 @mulPos64x64(i64* %r2, i64 %r3, i64 0)
%r5 = trunc i128 %r4 to i64
%r6 = call i64 @extractHigh64(i128 %r4)
%r7 = zext i64 %r5 to i128
%r8 = zext i64 %r6 to i128
%r9 = shl i128 %r8, 64
%r10 = add i128 %r7, %r9
ret i128 %r10
}
define i64 @mclb_mulUnit1(i64* noalias %r1, i64* noalias %r2, i64 %r3)
{
%r5 = call i128 @mulUnit_inner64(i64* %r2, i64 %r3)
%r6 = trunc i128 %r5 to i64
store i64 %r6, i64* %r1
%r7 = lshr i128 %r5, 64
%r8 = trunc i128 %r7 to i64
ret i64 %r8
}
define i64 @mclb_mulUnitAdd1(i64* noalias %r1, i64* noalias %r2, i64 %r3)
{
%r5 = call i128 @mulPos64x64(i64* %r2, i64 %r3, i64 0)
%r6 = trunc i128 %r5 to i64
%r7 = call i64 @extractHigh64(i128 %r5)
%r8 = zext i64 %r6 to i128
%r9 = zext i64 %r7 to i128
%r10 = shl i128 %r9, 64
%r11 = add i128 %r8, %r10
%r12 = load i64, i64* %r1
%r13 = zext i64 %r12 to i128
%r14 = add i128 %r11, %r13
%r15 = trunc i128 %r14 to i64
store i64 %r15, i64* %r1
%r16 = lshr i128 %r14, 64
%r17 = trunc i128 %r16 to i64
ret i64 %r17
}
define i192 @mulUnit_inner128(i64* noalias %r2, i64 %r3)
{
%r4 = call i128 @mulPos64x64(i64* %r2, i64 %r3, i64 0)
%r5 = trunc i128 %r4 to i64
%r6 = call i64 @extractHigh64(i128 %r4)
%r7 = call i128 @mulPos64x64(i64* %r2, i64 %r3, i64 1)
%r8 = trunc i128 %r7 to i64
%r9 = call i64 @extractHigh64(i128 %r7)
%r10 = zext i64 %r5 to i128
%r11 = zext i64 %r8 to i128
%r12 = shl i128 %r11, 64
%r13 = or i128 %r10, %r12
%r14 = zext i64 %r6 to i128
%r15 = zext i64 %r9 to i128
%r16 = shl i128 %r15, 64
%r17 = or i128 %r14, %r16
%r18 = zext i128 %r13 to i192
%r19 = zext i128 %r17 to i192
%r20 = shl i192 %r19, 64
%r21 = add i192 %r18, %r20
ret i192 %r21
}
define i64 @mclb_mulUnit2(i64* noalias %r1, i64* noalias %r2, i64 %r3)
{
%r5 = call i192 @mulUnit_inner128(i64* %r2, i64 %r3)
%r6 = trunc i192 %r5 to i128
%r7 = bitcast i64* %r1 to i128*
store i128 %r6, i128* %r7
%r8 = lshr i192 %r5, 128
%r9 = trunc i192 %r8 to i64
ret i64 %r9
}
define i64 @mclb_mulUnitAdd2(i64* noalias %r1, i64* noalias %r2, i64 %r3)
{
%r5 = call i128 @mulPos64x64(i64* %r2, i64 %r3, i64 0)
%r6 = trunc i128 %r5 to i64
%r7 = call i64 @extractHigh64(i128 %r5)
%r8 = call i128 @mulPos64x64(i64* %r2, i64 %r3, i64 1)
%r9 = trunc i128 %r8 to i64
%r10 = call i64 @extractHigh64(i128 %r8)
%r11 = zext i64 %r6 to i128
%r12 = zext i64 %r9 to i128
%r13 = shl i128 %r12, 64
%r14 = or i128 %r11, %r13
%r15 = zext i64 %r7 to i128
%r16 = zext i64 %r10 to i128
%r17 = shl i128 %r16, 64
%r18 = or i128 %r15, %r17
%r19 = zext i128 %r14 to i192
%r20 = zext i128 %r18 to i192
%r21 = shl i192 %r20, 64
%r22 = add i192 %r19, %r21
%r23 = bitcast i64* %r1 to i128*
%r24 = load i128, i128* %r23
%r25 = zext i128 %r24 to i192
%r26 = add i192 %r22, %r25
%r27 = trunc i192 %r26 to i128
%r28 = bitcast i64* %r1 to i128*
store i128 %r27, i128* %r28
%r29 = lshr i192 %r26, 128
%r30 = trunc i192 %r29 to i64
ret i64 %r30
}
define i256 @mulUnit_inner192(i64* noalias %r2, i64 %r3)
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
define i64 @mclb_mulUnit3(i64* noalias %r1, i64* noalias %r2, i64 %r3)
{
%r5 = call i256 @mulUnit_inner192(i64* %r2, i64 %r3)
%r6 = trunc i256 %r5 to i192
%r7 = bitcast i64* %r1 to i192*
store i192 %r6, i192* %r7
%r8 = lshr i256 %r5, 192
%r9 = trunc i256 %r8 to i64
ret i64 %r9
}
define i64 @mclb_mulUnitAdd3(i64* noalias %r1, i64* noalias %r2, i64 %r3)
{
%r5 = call i128 @mulPos64x64(i64* %r2, i64 %r3, i64 0)
%r6 = trunc i128 %r5 to i64
%r7 = call i64 @extractHigh64(i128 %r5)
%r8 = call i128 @mulPos64x64(i64* %r2, i64 %r3, i64 1)
%r9 = trunc i128 %r8 to i64
%r10 = call i64 @extractHigh64(i128 %r8)
%r11 = call i128 @mulPos64x64(i64* %r2, i64 %r3, i64 2)
%r12 = trunc i128 %r11 to i64
%r13 = call i64 @extractHigh64(i128 %r11)
%r14 = zext i64 %r6 to i128
%r15 = zext i64 %r9 to i128
%r16 = shl i128 %r15, 64
%r17 = or i128 %r14, %r16
%r18 = zext i128 %r17 to i192
%r19 = zext i64 %r12 to i192
%r20 = shl i192 %r19, 128
%r21 = or i192 %r18, %r20
%r22 = zext i64 %r7 to i128
%r23 = zext i64 %r10 to i128
%r24 = shl i128 %r23, 64
%r25 = or i128 %r22, %r24
%r26 = zext i128 %r25 to i192
%r27 = zext i64 %r13 to i192
%r28 = shl i192 %r27, 128
%r29 = or i192 %r26, %r28
%r30 = zext i192 %r21 to i256
%r31 = zext i192 %r29 to i256
%r32 = shl i256 %r31, 64
%r33 = add i256 %r30, %r32
%r34 = bitcast i64* %r1 to i192*
%r35 = load i192, i192* %r34
%r36 = zext i192 %r35 to i256
%r37 = add i256 %r33, %r36
%r38 = trunc i256 %r37 to i192
%r39 = bitcast i64* %r1 to i192*
store i192 %r38, i192* %r39
%r40 = lshr i256 %r37, 192
%r41 = trunc i256 %r40 to i64
ret i64 %r41
}
define i320 @mulUnit_inner256(i64* noalias %r2, i64 %r3)
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
define i64 @mclb_mulUnit4(i64* noalias %r1, i64* noalias %r2, i64 %r3)
{
%r5 = call i320 @mulUnit_inner256(i64* %r2, i64 %r3)
%r6 = trunc i320 %r5 to i256
%r7 = bitcast i64* %r1 to i256*
store i256 %r6, i256* %r7
%r8 = lshr i320 %r5, 256
%r9 = trunc i320 %r8 to i64
ret i64 %r9
}
define i64 @mclb_mulUnitAdd4(i64* noalias %r1, i64* noalias %r2, i64 %r3)
{
%r5 = call i128 @mulPos64x64(i64* %r2, i64 %r3, i64 0)
%r6 = trunc i128 %r5 to i64
%r7 = call i64 @extractHigh64(i128 %r5)
%r8 = call i128 @mulPos64x64(i64* %r2, i64 %r3, i64 1)
%r9 = trunc i128 %r8 to i64
%r10 = call i64 @extractHigh64(i128 %r8)
%r11 = call i128 @mulPos64x64(i64* %r2, i64 %r3, i64 2)
%r12 = trunc i128 %r11 to i64
%r13 = call i64 @extractHigh64(i128 %r11)
%r14 = call i128 @mulPos64x64(i64* %r2, i64 %r3, i64 3)
%r15 = trunc i128 %r14 to i64
%r16 = call i64 @extractHigh64(i128 %r14)
%r17 = zext i64 %r6 to i128
%r18 = zext i64 %r9 to i128
%r19 = shl i128 %r18, 64
%r20 = or i128 %r17, %r19
%r21 = zext i128 %r20 to i192
%r22 = zext i64 %r12 to i192
%r23 = shl i192 %r22, 128
%r24 = or i192 %r21, %r23
%r25 = zext i192 %r24 to i256
%r26 = zext i64 %r15 to i256
%r27 = shl i256 %r26, 192
%r28 = or i256 %r25, %r27
%r29 = zext i64 %r7 to i128
%r30 = zext i64 %r10 to i128
%r31 = shl i128 %r30, 64
%r32 = or i128 %r29, %r31
%r33 = zext i128 %r32 to i192
%r34 = zext i64 %r13 to i192
%r35 = shl i192 %r34, 128
%r36 = or i192 %r33, %r35
%r37 = zext i192 %r36 to i256
%r38 = zext i64 %r16 to i256
%r39 = shl i256 %r38, 192
%r40 = or i256 %r37, %r39
%r41 = zext i256 %r28 to i320
%r42 = zext i256 %r40 to i320
%r43 = shl i320 %r42, 64
%r44 = add i320 %r41, %r43
%r45 = bitcast i64* %r1 to i256*
%r46 = load i256, i256* %r45
%r47 = zext i256 %r46 to i320
%r48 = add i320 %r44, %r47
%r49 = trunc i320 %r48 to i256
%r50 = bitcast i64* %r1 to i256*
store i256 %r49, i256* %r50
%r51 = lshr i320 %r48, 256
%r52 = trunc i320 %r51 to i64
ret i64 %r52
}
define i384 @mulUnit_inner320(i64* noalias %r2, i64 %r3)
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
%r19 = zext i64 %r5 to i128
%r20 = zext i64 %r8 to i128
%r21 = shl i128 %r20, 64
%r22 = or i128 %r19, %r21
%r23 = zext i128 %r22 to i192
%r24 = zext i64 %r11 to i192
%r25 = shl i192 %r24, 128
%r26 = or i192 %r23, %r25
%r27 = zext i192 %r26 to i256
%r28 = zext i64 %r14 to i256
%r29 = shl i256 %r28, 192
%r30 = or i256 %r27, %r29
%r31 = zext i256 %r30 to i320
%r32 = zext i64 %r17 to i320
%r33 = shl i320 %r32, 256
%r34 = or i320 %r31, %r33
%r35 = zext i64 %r6 to i128
%r36 = zext i64 %r9 to i128
%r37 = shl i128 %r36, 64
%r38 = or i128 %r35, %r37
%r39 = zext i128 %r38 to i192
%r40 = zext i64 %r12 to i192
%r41 = shl i192 %r40, 128
%r42 = or i192 %r39, %r41
%r43 = zext i192 %r42 to i256
%r44 = zext i64 %r15 to i256
%r45 = shl i256 %r44, 192
%r46 = or i256 %r43, %r45
%r47 = zext i256 %r46 to i320
%r48 = zext i64 %r18 to i320
%r49 = shl i320 %r48, 256
%r50 = or i320 %r47, %r49
%r51 = zext i320 %r34 to i384
%r52 = zext i320 %r50 to i384
%r53 = shl i384 %r52, 64
%r54 = add i384 %r51, %r53
ret i384 %r54
}
define i64 @mclb_mulUnit5(i64* noalias %r1, i64* noalias %r2, i64 %r3)
{
%r5 = call i384 @mulUnit_inner320(i64* %r2, i64 %r3)
%r6 = trunc i384 %r5 to i320
%r7 = bitcast i64* %r1 to i320*
store i320 %r6, i320* %r7
%r8 = lshr i384 %r5, 320
%r9 = trunc i384 %r8 to i64
ret i64 %r9
}
define i64 @mclb_mulUnitAdd5(i64* noalias %r1, i64* noalias %r2, i64 %r3)
{
%r5 = call i128 @mulPos64x64(i64* %r2, i64 %r3, i64 0)
%r6 = trunc i128 %r5 to i64
%r7 = call i64 @extractHigh64(i128 %r5)
%r8 = call i128 @mulPos64x64(i64* %r2, i64 %r3, i64 1)
%r9 = trunc i128 %r8 to i64
%r10 = call i64 @extractHigh64(i128 %r8)
%r11 = call i128 @mulPos64x64(i64* %r2, i64 %r3, i64 2)
%r12 = trunc i128 %r11 to i64
%r13 = call i64 @extractHigh64(i128 %r11)
%r14 = call i128 @mulPos64x64(i64* %r2, i64 %r3, i64 3)
%r15 = trunc i128 %r14 to i64
%r16 = call i64 @extractHigh64(i128 %r14)
%r17 = call i128 @mulPos64x64(i64* %r2, i64 %r3, i64 4)
%r18 = trunc i128 %r17 to i64
%r19 = call i64 @extractHigh64(i128 %r17)
%r20 = zext i64 %r6 to i128
%r21 = zext i64 %r9 to i128
%r22 = shl i128 %r21, 64
%r23 = or i128 %r20, %r22
%r24 = zext i128 %r23 to i192
%r25 = zext i64 %r12 to i192
%r26 = shl i192 %r25, 128
%r27 = or i192 %r24, %r26
%r28 = zext i192 %r27 to i256
%r29 = zext i64 %r15 to i256
%r30 = shl i256 %r29, 192
%r31 = or i256 %r28, %r30
%r32 = zext i256 %r31 to i320
%r33 = zext i64 %r18 to i320
%r34 = shl i320 %r33, 256
%r35 = or i320 %r32, %r34
%r36 = zext i64 %r7 to i128
%r37 = zext i64 %r10 to i128
%r38 = shl i128 %r37, 64
%r39 = or i128 %r36, %r38
%r40 = zext i128 %r39 to i192
%r41 = zext i64 %r13 to i192
%r42 = shl i192 %r41, 128
%r43 = or i192 %r40, %r42
%r44 = zext i192 %r43 to i256
%r45 = zext i64 %r16 to i256
%r46 = shl i256 %r45, 192
%r47 = or i256 %r44, %r46
%r48 = zext i256 %r47 to i320
%r49 = zext i64 %r19 to i320
%r50 = shl i320 %r49, 256
%r51 = or i320 %r48, %r50
%r52 = zext i320 %r35 to i384
%r53 = zext i320 %r51 to i384
%r54 = shl i384 %r53, 64
%r55 = add i384 %r52, %r54
%r56 = bitcast i64* %r1 to i320*
%r57 = load i320, i320* %r56
%r58 = zext i320 %r57 to i384
%r59 = add i384 %r55, %r58
%r60 = trunc i384 %r59 to i320
%r61 = bitcast i64* %r1 to i320*
store i320 %r60, i320* %r61
%r62 = lshr i384 %r59, 320
%r63 = trunc i384 %r62 to i64
ret i64 %r63
}
define i448 @mulUnit_inner384(i64* noalias %r2, i64 %r3)
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
define i64 @mclb_mulUnit6(i64* noalias %r1, i64* noalias %r2, i64 %r3)
{
%r5 = call i448 @mulUnit_inner384(i64* %r2, i64 %r3)
%r6 = trunc i448 %r5 to i384
%r7 = bitcast i64* %r1 to i384*
store i384 %r6, i384* %r7
%r8 = lshr i448 %r5, 384
%r9 = trunc i448 %r8 to i64
ret i64 %r9
}
define i64 @mclb_mulUnitAdd6(i64* noalias %r1, i64* noalias %r2, i64 %r3)
{
%r5 = call i128 @mulPos64x64(i64* %r2, i64 %r3, i64 0)
%r6 = trunc i128 %r5 to i64
%r7 = call i64 @extractHigh64(i128 %r5)
%r8 = call i128 @mulPos64x64(i64* %r2, i64 %r3, i64 1)
%r9 = trunc i128 %r8 to i64
%r10 = call i64 @extractHigh64(i128 %r8)
%r11 = call i128 @mulPos64x64(i64* %r2, i64 %r3, i64 2)
%r12 = trunc i128 %r11 to i64
%r13 = call i64 @extractHigh64(i128 %r11)
%r14 = call i128 @mulPos64x64(i64* %r2, i64 %r3, i64 3)
%r15 = trunc i128 %r14 to i64
%r16 = call i64 @extractHigh64(i128 %r14)
%r17 = call i128 @mulPos64x64(i64* %r2, i64 %r3, i64 4)
%r18 = trunc i128 %r17 to i64
%r19 = call i64 @extractHigh64(i128 %r17)
%r20 = call i128 @mulPos64x64(i64* %r2, i64 %r3, i64 5)
%r21 = trunc i128 %r20 to i64
%r22 = call i64 @extractHigh64(i128 %r20)
%r23 = zext i64 %r6 to i128
%r24 = zext i64 %r9 to i128
%r25 = shl i128 %r24, 64
%r26 = or i128 %r23, %r25
%r27 = zext i128 %r26 to i192
%r28 = zext i64 %r12 to i192
%r29 = shl i192 %r28, 128
%r30 = or i192 %r27, %r29
%r31 = zext i192 %r30 to i256
%r32 = zext i64 %r15 to i256
%r33 = shl i256 %r32, 192
%r34 = or i256 %r31, %r33
%r35 = zext i256 %r34 to i320
%r36 = zext i64 %r18 to i320
%r37 = shl i320 %r36, 256
%r38 = or i320 %r35, %r37
%r39 = zext i320 %r38 to i384
%r40 = zext i64 %r21 to i384
%r41 = shl i384 %r40, 320
%r42 = or i384 %r39, %r41
%r43 = zext i64 %r7 to i128
%r44 = zext i64 %r10 to i128
%r45 = shl i128 %r44, 64
%r46 = or i128 %r43, %r45
%r47 = zext i128 %r46 to i192
%r48 = zext i64 %r13 to i192
%r49 = shl i192 %r48, 128
%r50 = or i192 %r47, %r49
%r51 = zext i192 %r50 to i256
%r52 = zext i64 %r16 to i256
%r53 = shl i256 %r52, 192
%r54 = or i256 %r51, %r53
%r55 = zext i256 %r54 to i320
%r56 = zext i64 %r19 to i320
%r57 = shl i320 %r56, 256
%r58 = or i320 %r55, %r57
%r59 = zext i320 %r58 to i384
%r60 = zext i64 %r22 to i384
%r61 = shl i384 %r60, 320
%r62 = or i384 %r59, %r61
%r63 = zext i384 %r42 to i448
%r64 = zext i384 %r62 to i448
%r65 = shl i448 %r64, 64
%r66 = add i448 %r63, %r65
%r67 = bitcast i64* %r1 to i384*
%r68 = load i384, i384* %r67
%r69 = zext i384 %r68 to i448
%r70 = add i448 %r66, %r69
%r71 = trunc i448 %r70 to i384
%r72 = bitcast i64* %r1 to i384*
store i384 %r71, i384* %r72
%r73 = lshr i448 %r70, 384
%r74 = trunc i448 %r73 to i64
ret i64 %r74
}
define i512 @mulUnit_inner448(i64* noalias %r2, i64 %r3)
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
%r25 = zext i64 %r5 to i128
%r26 = zext i64 %r8 to i128
%r27 = shl i128 %r26, 64
%r28 = or i128 %r25, %r27
%r29 = zext i128 %r28 to i192
%r30 = zext i64 %r11 to i192
%r31 = shl i192 %r30, 128
%r32 = or i192 %r29, %r31
%r33 = zext i192 %r32 to i256
%r34 = zext i64 %r14 to i256
%r35 = shl i256 %r34, 192
%r36 = or i256 %r33, %r35
%r37 = zext i256 %r36 to i320
%r38 = zext i64 %r17 to i320
%r39 = shl i320 %r38, 256
%r40 = or i320 %r37, %r39
%r41 = zext i320 %r40 to i384
%r42 = zext i64 %r20 to i384
%r43 = shl i384 %r42, 320
%r44 = or i384 %r41, %r43
%r45 = zext i384 %r44 to i448
%r46 = zext i64 %r23 to i448
%r47 = shl i448 %r46, 384
%r48 = or i448 %r45, %r47
%r49 = zext i64 %r6 to i128
%r50 = zext i64 %r9 to i128
%r51 = shl i128 %r50, 64
%r52 = or i128 %r49, %r51
%r53 = zext i128 %r52 to i192
%r54 = zext i64 %r12 to i192
%r55 = shl i192 %r54, 128
%r56 = or i192 %r53, %r55
%r57 = zext i192 %r56 to i256
%r58 = zext i64 %r15 to i256
%r59 = shl i256 %r58, 192
%r60 = or i256 %r57, %r59
%r61 = zext i256 %r60 to i320
%r62 = zext i64 %r18 to i320
%r63 = shl i320 %r62, 256
%r64 = or i320 %r61, %r63
%r65 = zext i320 %r64 to i384
%r66 = zext i64 %r21 to i384
%r67 = shl i384 %r66, 320
%r68 = or i384 %r65, %r67
%r69 = zext i384 %r68 to i448
%r70 = zext i64 %r24 to i448
%r71 = shl i448 %r70, 384
%r72 = or i448 %r69, %r71
%r73 = zext i448 %r48 to i512
%r74 = zext i448 %r72 to i512
%r75 = shl i512 %r74, 64
%r76 = add i512 %r73, %r75
ret i512 %r76
}
define i64 @mclb_mulUnit7(i64* noalias %r1, i64* noalias %r2, i64 %r3)
{
%r5 = call i512 @mulUnit_inner448(i64* %r2, i64 %r3)
%r6 = trunc i512 %r5 to i448
%r7 = bitcast i64* %r1 to i448*
store i448 %r6, i448* %r7
%r8 = lshr i512 %r5, 448
%r9 = trunc i512 %r8 to i64
ret i64 %r9
}
define i64 @mclb_mulUnitAdd7(i64* noalias %r1, i64* noalias %r2, i64 %r3)
{
%r5 = call i128 @mulPos64x64(i64* %r2, i64 %r3, i64 0)
%r6 = trunc i128 %r5 to i64
%r7 = call i64 @extractHigh64(i128 %r5)
%r8 = call i128 @mulPos64x64(i64* %r2, i64 %r3, i64 1)
%r9 = trunc i128 %r8 to i64
%r10 = call i64 @extractHigh64(i128 %r8)
%r11 = call i128 @mulPos64x64(i64* %r2, i64 %r3, i64 2)
%r12 = trunc i128 %r11 to i64
%r13 = call i64 @extractHigh64(i128 %r11)
%r14 = call i128 @mulPos64x64(i64* %r2, i64 %r3, i64 3)
%r15 = trunc i128 %r14 to i64
%r16 = call i64 @extractHigh64(i128 %r14)
%r17 = call i128 @mulPos64x64(i64* %r2, i64 %r3, i64 4)
%r18 = trunc i128 %r17 to i64
%r19 = call i64 @extractHigh64(i128 %r17)
%r20 = call i128 @mulPos64x64(i64* %r2, i64 %r3, i64 5)
%r21 = trunc i128 %r20 to i64
%r22 = call i64 @extractHigh64(i128 %r20)
%r23 = call i128 @mulPos64x64(i64* %r2, i64 %r3, i64 6)
%r24 = trunc i128 %r23 to i64
%r25 = call i64 @extractHigh64(i128 %r23)
%r26 = zext i64 %r6 to i128
%r27 = zext i64 %r9 to i128
%r28 = shl i128 %r27, 64
%r29 = or i128 %r26, %r28
%r30 = zext i128 %r29 to i192
%r31 = zext i64 %r12 to i192
%r32 = shl i192 %r31, 128
%r33 = or i192 %r30, %r32
%r34 = zext i192 %r33 to i256
%r35 = zext i64 %r15 to i256
%r36 = shl i256 %r35, 192
%r37 = or i256 %r34, %r36
%r38 = zext i256 %r37 to i320
%r39 = zext i64 %r18 to i320
%r40 = shl i320 %r39, 256
%r41 = or i320 %r38, %r40
%r42 = zext i320 %r41 to i384
%r43 = zext i64 %r21 to i384
%r44 = shl i384 %r43, 320
%r45 = or i384 %r42, %r44
%r46 = zext i384 %r45 to i448
%r47 = zext i64 %r24 to i448
%r48 = shl i448 %r47, 384
%r49 = or i448 %r46, %r48
%r50 = zext i64 %r7 to i128
%r51 = zext i64 %r10 to i128
%r52 = shl i128 %r51, 64
%r53 = or i128 %r50, %r52
%r54 = zext i128 %r53 to i192
%r55 = zext i64 %r13 to i192
%r56 = shl i192 %r55, 128
%r57 = or i192 %r54, %r56
%r58 = zext i192 %r57 to i256
%r59 = zext i64 %r16 to i256
%r60 = shl i256 %r59, 192
%r61 = or i256 %r58, %r60
%r62 = zext i256 %r61 to i320
%r63 = zext i64 %r19 to i320
%r64 = shl i320 %r63, 256
%r65 = or i320 %r62, %r64
%r66 = zext i320 %r65 to i384
%r67 = zext i64 %r22 to i384
%r68 = shl i384 %r67, 320
%r69 = or i384 %r66, %r68
%r70 = zext i384 %r69 to i448
%r71 = zext i64 %r25 to i448
%r72 = shl i448 %r71, 384
%r73 = or i448 %r70, %r72
%r74 = zext i448 %r49 to i512
%r75 = zext i448 %r73 to i512
%r76 = shl i512 %r75, 64
%r77 = add i512 %r74, %r76
%r78 = bitcast i64* %r1 to i448*
%r79 = load i448, i448* %r78
%r80 = zext i448 %r79 to i512
%r81 = add i512 %r77, %r80
%r82 = trunc i512 %r81 to i448
%r83 = bitcast i64* %r1 to i448*
store i448 %r82, i448* %r83
%r84 = lshr i512 %r81, 448
%r85 = trunc i512 %r84 to i64
ret i64 %r85
}
define i576 @mulUnit_inner512(i64* noalias %r2, i64 %r3)
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
define i64 @mclb_mulUnit8(i64* noalias %r1, i64* noalias %r2, i64 %r3)
{
%r5 = call i576 @mulUnit_inner512(i64* %r2, i64 %r3)
%r6 = trunc i576 %r5 to i512
%r7 = bitcast i64* %r1 to i512*
store i512 %r6, i512* %r7
%r8 = lshr i576 %r5, 512
%r9 = trunc i576 %r8 to i64
ret i64 %r9
}
define i64 @mclb_mulUnitAdd8(i64* noalias %r1, i64* noalias %r2, i64 %r3)
{
%r5 = call i128 @mulPos64x64(i64* %r2, i64 %r3, i64 0)
%r6 = trunc i128 %r5 to i64
%r7 = call i64 @extractHigh64(i128 %r5)
%r8 = call i128 @mulPos64x64(i64* %r2, i64 %r3, i64 1)
%r9 = trunc i128 %r8 to i64
%r10 = call i64 @extractHigh64(i128 %r8)
%r11 = call i128 @mulPos64x64(i64* %r2, i64 %r3, i64 2)
%r12 = trunc i128 %r11 to i64
%r13 = call i64 @extractHigh64(i128 %r11)
%r14 = call i128 @mulPos64x64(i64* %r2, i64 %r3, i64 3)
%r15 = trunc i128 %r14 to i64
%r16 = call i64 @extractHigh64(i128 %r14)
%r17 = call i128 @mulPos64x64(i64* %r2, i64 %r3, i64 4)
%r18 = trunc i128 %r17 to i64
%r19 = call i64 @extractHigh64(i128 %r17)
%r20 = call i128 @mulPos64x64(i64* %r2, i64 %r3, i64 5)
%r21 = trunc i128 %r20 to i64
%r22 = call i64 @extractHigh64(i128 %r20)
%r23 = call i128 @mulPos64x64(i64* %r2, i64 %r3, i64 6)
%r24 = trunc i128 %r23 to i64
%r25 = call i64 @extractHigh64(i128 %r23)
%r26 = call i128 @mulPos64x64(i64* %r2, i64 %r3, i64 7)
%r27 = trunc i128 %r26 to i64
%r28 = call i64 @extractHigh64(i128 %r26)
%r29 = zext i64 %r6 to i128
%r30 = zext i64 %r9 to i128
%r31 = shl i128 %r30, 64
%r32 = or i128 %r29, %r31
%r33 = zext i128 %r32 to i192
%r34 = zext i64 %r12 to i192
%r35 = shl i192 %r34, 128
%r36 = or i192 %r33, %r35
%r37 = zext i192 %r36 to i256
%r38 = zext i64 %r15 to i256
%r39 = shl i256 %r38, 192
%r40 = or i256 %r37, %r39
%r41 = zext i256 %r40 to i320
%r42 = zext i64 %r18 to i320
%r43 = shl i320 %r42, 256
%r44 = or i320 %r41, %r43
%r45 = zext i320 %r44 to i384
%r46 = zext i64 %r21 to i384
%r47 = shl i384 %r46, 320
%r48 = or i384 %r45, %r47
%r49 = zext i384 %r48 to i448
%r50 = zext i64 %r24 to i448
%r51 = shl i448 %r50, 384
%r52 = or i448 %r49, %r51
%r53 = zext i448 %r52 to i512
%r54 = zext i64 %r27 to i512
%r55 = shl i512 %r54, 448
%r56 = or i512 %r53, %r55
%r57 = zext i64 %r7 to i128
%r58 = zext i64 %r10 to i128
%r59 = shl i128 %r58, 64
%r60 = or i128 %r57, %r59
%r61 = zext i128 %r60 to i192
%r62 = zext i64 %r13 to i192
%r63 = shl i192 %r62, 128
%r64 = or i192 %r61, %r63
%r65 = zext i192 %r64 to i256
%r66 = zext i64 %r16 to i256
%r67 = shl i256 %r66, 192
%r68 = or i256 %r65, %r67
%r69 = zext i256 %r68 to i320
%r70 = zext i64 %r19 to i320
%r71 = shl i320 %r70, 256
%r72 = or i320 %r69, %r71
%r73 = zext i320 %r72 to i384
%r74 = zext i64 %r22 to i384
%r75 = shl i384 %r74, 320
%r76 = or i384 %r73, %r75
%r77 = zext i384 %r76 to i448
%r78 = zext i64 %r25 to i448
%r79 = shl i448 %r78, 384
%r80 = or i448 %r77, %r79
%r81 = zext i448 %r80 to i512
%r82 = zext i64 %r28 to i512
%r83 = shl i512 %r82, 448
%r84 = or i512 %r81, %r83
%r85 = zext i512 %r56 to i576
%r86 = zext i512 %r84 to i576
%r87 = shl i576 %r86, 64
%r88 = add i576 %r85, %r87
%r89 = bitcast i64* %r1 to i512*
%r90 = load i512, i512* %r89
%r91 = zext i512 %r90 to i576
%r92 = add i576 %r88, %r91
%r93 = trunc i576 %r92 to i512
%r94 = bitcast i64* %r1 to i512*
store i512 %r93, i512* %r94
%r95 = lshr i576 %r92, 512
%r96 = trunc i576 %r95 to i64
ret i64 %r96
}
define i640 @mulUnit_inner576(i64* noalias %r2, i64 %r3)
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
%r28 = call i128 @mulPos64x64(i64* %r2, i64 %r3, i64 8)
%r29 = trunc i128 %r28 to i64
%r30 = call i64 @extractHigh64(i128 %r28)
%r31 = zext i64 %r5 to i128
%r32 = zext i64 %r8 to i128
%r33 = shl i128 %r32, 64
%r34 = or i128 %r31, %r33
%r35 = zext i128 %r34 to i192
%r36 = zext i64 %r11 to i192
%r37 = shl i192 %r36, 128
%r38 = or i192 %r35, %r37
%r39 = zext i192 %r38 to i256
%r40 = zext i64 %r14 to i256
%r41 = shl i256 %r40, 192
%r42 = or i256 %r39, %r41
%r43 = zext i256 %r42 to i320
%r44 = zext i64 %r17 to i320
%r45 = shl i320 %r44, 256
%r46 = or i320 %r43, %r45
%r47 = zext i320 %r46 to i384
%r48 = zext i64 %r20 to i384
%r49 = shl i384 %r48, 320
%r50 = or i384 %r47, %r49
%r51 = zext i384 %r50 to i448
%r52 = zext i64 %r23 to i448
%r53 = shl i448 %r52, 384
%r54 = or i448 %r51, %r53
%r55 = zext i448 %r54 to i512
%r56 = zext i64 %r26 to i512
%r57 = shl i512 %r56, 448
%r58 = or i512 %r55, %r57
%r59 = zext i512 %r58 to i576
%r60 = zext i64 %r29 to i576
%r61 = shl i576 %r60, 512
%r62 = or i576 %r59, %r61
%r63 = zext i64 %r6 to i128
%r64 = zext i64 %r9 to i128
%r65 = shl i128 %r64, 64
%r66 = or i128 %r63, %r65
%r67 = zext i128 %r66 to i192
%r68 = zext i64 %r12 to i192
%r69 = shl i192 %r68, 128
%r70 = or i192 %r67, %r69
%r71 = zext i192 %r70 to i256
%r72 = zext i64 %r15 to i256
%r73 = shl i256 %r72, 192
%r74 = or i256 %r71, %r73
%r75 = zext i256 %r74 to i320
%r76 = zext i64 %r18 to i320
%r77 = shl i320 %r76, 256
%r78 = or i320 %r75, %r77
%r79 = zext i320 %r78 to i384
%r80 = zext i64 %r21 to i384
%r81 = shl i384 %r80, 320
%r82 = or i384 %r79, %r81
%r83 = zext i384 %r82 to i448
%r84 = zext i64 %r24 to i448
%r85 = shl i448 %r84, 384
%r86 = or i448 %r83, %r85
%r87 = zext i448 %r86 to i512
%r88 = zext i64 %r27 to i512
%r89 = shl i512 %r88, 448
%r90 = or i512 %r87, %r89
%r91 = zext i512 %r90 to i576
%r92 = zext i64 %r30 to i576
%r93 = shl i576 %r92, 512
%r94 = or i576 %r91, %r93
%r95 = zext i576 %r62 to i640
%r96 = zext i576 %r94 to i640
%r97 = shl i640 %r96, 64
%r98 = add i640 %r95, %r97
ret i640 %r98
}
define i64 @mclb_mulUnit9(i64* noalias %r1, i64* noalias %r2, i64 %r3)
{
%r5 = call i640 @mulUnit_inner576(i64* %r2, i64 %r3)
%r6 = trunc i640 %r5 to i576
%r7 = bitcast i64* %r1 to i576*
store i576 %r6, i576* %r7
%r8 = lshr i640 %r5, 576
%r9 = trunc i640 %r8 to i64
ret i64 %r9
}
define i64 @mclb_mulUnitAdd9(i64* noalias %r1, i64* noalias %r2, i64 %r3)
{
%r5 = call i128 @mulPos64x64(i64* %r2, i64 %r3, i64 0)
%r6 = trunc i128 %r5 to i64
%r7 = call i64 @extractHigh64(i128 %r5)
%r8 = call i128 @mulPos64x64(i64* %r2, i64 %r3, i64 1)
%r9 = trunc i128 %r8 to i64
%r10 = call i64 @extractHigh64(i128 %r8)
%r11 = call i128 @mulPos64x64(i64* %r2, i64 %r3, i64 2)
%r12 = trunc i128 %r11 to i64
%r13 = call i64 @extractHigh64(i128 %r11)
%r14 = call i128 @mulPos64x64(i64* %r2, i64 %r3, i64 3)
%r15 = trunc i128 %r14 to i64
%r16 = call i64 @extractHigh64(i128 %r14)
%r17 = call i128 @mulPos64x64(i64* %r2, i64 %r3, i64 4)
%r18 = trunc i128 %r17 to i64
%r19 = call i64 @extractHigh64(i128 %r17)
%r20 = call i128 @mulPos64x64(i64* %r2, i64 %r3, i64 5)
%r21 = trunc i128 %r20 to i64
%r22 = call i64 @extractHigh64(i128 %r20)
%r23 = call i128 @mulPos64x64(i64* %r2, i64 %r3, i64 6)
%r24 = trunc i128 %r23 to i64
%r25 = call i64 @extractHigh64(i128 %r23)
%r26 = call i128 @mulPos64x64(i64* %r2, i64 %r3, i64 7)
%r27 = trunc i128 %r26 to i64
%r28 = call i64 @extractHigh64(i128 %r26)
%r29 = call i128 @mulPos64x64(i64* %r2, i64 %r3, i64 8)
%r30 = trunc i128 %r29 to i64
%r31 = call i64 @extractHigh64(i128 %r29)
%r32 = zext i64 %r6 to i128
%r33 = zext i64 %r9 to i128
%r34 = shl i128 %r33, 64
%r35 = or i128 %r32, %r34
%r36 = zext i128 %r35 to i192
%r37 = zext i64 %r12 to i192
%r38 = shl i192 %r37, 128
%r39 = or i192 %r36, %r38
%r40 = zext i192 %r39 to i256
%r41 = zext i64 %r15 to i256
%r42 = shl i256 %r41, 192
%r43 = or i256 %r40, %r42
%r44 = zext i256 %r43 to i320
%r45 = zext i64 %r18 to i320
%r46 = shl i320 %r45, 256
%r47 = or i320 %r44, %r46
%r48 = zext i320 %r47 to i384
%r49 = zext i64 %r21 to i384
%r50 = shl i384 %r49, 320
%r51 = or i384 %r48, %r50
%r52 = zext i384 %r51 to i448
%r53 = zext i64 %r24 to i448
%r54 = shl i448 %r53, 384
%r55 = or i448 %r52, %r54
%r56 = zext i448 %r55 to i512
%r57 = zext i64 %r27 to i512
%r58 = shl i512 %r57, 448
%r59 = or i512 %r56, %r58
%r60 = zext i512 %r59 to i576
%r61 = zext i64 %r30 to i576
%r62 = shl i576 %r61, 512
%r63 = or i576 %r60, %r62
%r64 = zext i64 %r7 to i128
%r65 = zext i64 %r10 to i128
%r66 = shl i128 %r65, 64
%r67 = or i128 %r64, %r66
%r68 = zext i128 %r67 to i192
%r69 = zext i64 %r13 to i192
%r70 = shl i192 %r69, 128
%r71 = or i192 %r68, %r70
%r72 = zext i192 %r71 to i256
%r73 = zext i64 %r16 to i256
%r74 = shl i256 %r73, 192
%r75 = or i256 %r72, %r74
%r76 = zext i256 %r75 to i320
%r77 = zext i64 %r19 to i320
%r78 = shl i320 %r77, 256
%r79 = or i320 %r76, %r78
%r80 = zext i320 %r79 to i384
%r81 = zext i64 %r22 to i384
%r82 = shl i384 %r81, 320
%r83 = or i384 %r80, %r82
%r84 = zext i384 %r83 to i448
%r85 = zext i64 %r25 to i448
%r86 = shl i448 %r85, 384
%r87 = or i448 %r84, %r86
%r88 = zext i448 %r87 to i512
%r89 = zext i64 %r28 to i512
%r90 = shl i512 %r89, 448
%r91 = or i512 %r88, %r90
%r92 = zext i512 %r91 to i576
%r93 = zext i64 %r31 to i576
%r94 = shl i576 %r93, 512
%r95 = or i576 %r92, %r94
%r96 = zext i576 %r63 to i640
%r97 = zext i576 %r95 to i640
%r98 = shl i640 %r97, 64
%r99 = add i640 %r96, %r98
%r100 = bitcast i64* %r1 to i576*
%r101 = load i576, i576* %r100
%r102 = zext i576 %r101 to i640
%r103 = add i640 %r99, %r102
%r104 = trunc i640 %r103 to i576
%r105 = bitcast i64* %r1 to i576*
store i576 %r104, i576* %r105
%r106 = lshr i640 %r103, 576
%r107 = trunc i640 %r106 to i64
ret i64 %r107
}
define i704 @mulUnit_inner640(i64* noalias %r2, i64 %r3)
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
%r28 = call i128 @mulPos64x64(i64* %r2, i64 %r3, i64 8)
%r29 = trunc i128 %r28 to i64
%r30 = call i64 @extractHigh64(i128 %r28)
%r31 = call i128 @mulPos64x64(i64* %r2, i64 %r3, i64 9)
%r32 = trunc i128 %r31 to i64
%r33 = call i64 @extractHigh64(i128 %r31)
%r34 = zext i64 %r5 to i128
%r35 = zext i64 %r8 to i128
%r36 = shl i128 %r35, 64
%r37 = or i128 %r34, %r36
%r38 = zext i128 %r37 to i192
%r39 = zext i64 %r11 to i192
%r40 = shl i192 %r39, 128
%r41 = or i192 %r38, %r40
%r42 = zext i192 %r41 to i256
%r43 = zext i64 %r14 to i256
%r44 = shl i256 %r43, 192
%r45 = or i256 %r42, %r44
%r46 = zext i256 %r45 to i320
%r47 = zext i64 %r17 to i320
%r48 = shl i320 %r47, 256
%r49 = or i320 %r46, %r48
%r50 = zext i320 %r49 to i384
%r51 = zext i64 %r20 to i384
%r52 = shl i384 %r51, 320
%r53 = or i384 %r50, %r52
%r54 = zext i384 %r53 to i448
%r55 = zext i64 %r23 to i448
%r56 = shl i448 %r55, 384
%r57 = or i448 %r54, %r56
%r58 = zext i448 %r57 to i512
%r59 = zext i64 %r26 to i512
%r60 = shl i512 %r59, 448
%r61 = or i512 %r58, %r60
%r62 = zext i512 %r61 to i576
%r63 = zext i64 %r29 to i576
%r64 = shl i576 %r63, 512
%r65 = or i576 %r62, %r64
%r66 = zext i576 %r65 to i640
%r67 = zext i64 %r32 to i640
%r68 = shl i640 %r67, 576
%r69 = or i640 %r66, %r68
%r70 = zext i64 %r6 to i128
%r71 = zext i64 %r9 to i128
%r72 = shl i128 %r71, 64
%r73 = or i128 %r70, %r72
%r74 = zext i128 %r73 to i192
%r75 = zext i64 %r12 to i192
%r76 = shl i192 %r75, 128
%r77 = or i192 %r74, %r76
%r78 = zext i192 %r77 to i256
%r79 = zext i64 %r15 to i256
%r80 = shl i256 %r79, 192
%r81 = or i256 %r78, %r80
%r82 = zext i256 %r81 to i320
%r83 = zext i64 %r18 to i320
%r84 = shl i320 %r83, 256
%r85 = or i320 %r82, %r84
%r86 = zext i320 %r85 to i384
%r87 = zext i64 %r21 to i384
%r88 = shl i384 %r87, 320
%r89 = or i384 %r86, %r88
%r90 = zext i384 %r89 to i448
%r91 = zext i64 %r24 to i448
%r92 = shl i448 %r91, 384
%r93 = or i448 %r90, %r92
%r94 = zext i448 %r93 to i512
%r95 = zext i64 %r27 to i512
%r96 = shl i512 %r95, 448
%r97 = or i512 %r94, %r96
%r98 = zext i512 %r97 to i576
%r99 = zext i64 %r30 to i576
%r100 = shl i576 %r99, 512
%r101 = or i576 %r98, %r100
%r102 = zext i576 %r101 to i640
%r103 = zext i64 %r33 to i640
%r104 = shl i640 %r103, 576
%r105 = or i640 %r102, %r104
%r106 = zext i640 %r69 to i704
%r107 = zext i640 %r105 to i704
%r108 = shl i704 %r107, 64
%r109 = add i704 %r106, %r108
ret i704 %r109
}
define i64 @mclb_mulUnit10(i64* noalias %r1, i64* noalias %r2, i64 %r3)
{
%r5 = call i704 @mulUnit_inner640(i64* %r2, i64 %r3)
%r6 = trunc i704 %r5 to i640
%r7 = bitcast i64* %r1 to i640*
store i640 %r6, i640* %r7
%r8 = lshr i704 %r5, 640
%r9 = trunc i704 %r8 to i64
ret i64 %r9
}
define i64 @mclb_mulUnitAdd10(i64* noalias %r1, i64* noalias %r2, i64 %r3)
{
%r5 = call i128 @mulPos64x64(i64* %r2, i64 %r3, i64 0)
%r6 = trunc i128 %r5 to i64
%r7 = call i64 @extractHigh64(i128 %r5)
%r8 = call i128 @mulPos64x64(i64* %r2, i64 %r3, i64 1)
%r9 = trunc i128 %r8 to i64
%r10 = call i64 @extractHigh64(i128 %r8)
%r11 = call i128 @mulPos64x64(i64* %r2, i64 %r3, i64 2)
%r12 = trunc i128 %r11 to i64
%r13 = call i64 @extractHigh64(i128 %r11)
%r14 = call i128 @mulPos64x64(i64* %r2, i64 %r3, i64 3)
%r15 = trunc i128 %r14 to i64
%r16 = call i64 @extractHigh64(i128 %r14)
%r17 = call i128 @mulPos64x64(i64* %r2, i64 %r3, i64 4)
%r18 = trunc i128 %r17 to i64
%r19 = call i64 @extractHigh64(i128 %r17)
%r20 = call i128 @mulPos64x64(i64* %r2, i64 %r3, i64 5)
%r21 = trunc i128 %r20 to i64
%r22 = call i64 @extractHigh64(i128 %r20)
%r23 = call i128 @mulPos64x64(i64* %r2, i64 %r3, i64 6)
%r24 = trunc i128 %r23 to i64
%r25 = call i64 @extractHigh64(i128 %r23)
%r26 = call i128 @mulPos64x64(i64* %r2, i64 %r3, i64 7)
%r27 = trunc i128 %r26 to i64
%r28 = call i64 @extractHigh64(i128 %r26)
%r29 = call i128 @mulPos64x64(i64* %r2, i64 %r3, i64 8)
%r30 = trunc i128 %r29 to i64
%r31 = call i64 @extractHigh64(i128 %r29)
%r32 = call i128 @mulPos64x64(i64* %r2, i64 %r3, i64 9)
%r33 = trunc i128 %r32 to i64
%r34 = call i64 @extractHigh64(i128 %r32)
%r35 = zext i64 %r6 to i128
%r36 = zext i64 %r9 to i128
%r37 = shl i128 %r36, 64
%r38 = or i128 %r35, %r37
%r39 = zext i128 %r38 to i192
%r40 = zext i64 %r12 to i192
%r41 = shl i192 %r40, 128
%r42 = or i192 %r39, %r41
%r43 = zext i192 %r42 to i256
%r44 = zext i64 %r15 to i256
%r45 = shl i256 %r44, 192
%r46 = or i256 %r43, %r45
%r47 = zext i256 %r46 to i320
%r48 = zext i64 %r18 to i320
%r49 = shl i320 %r48, 256
%r50 = or i320 %r47, %r49
%r51 = zext i320 %r50 to i384
%r52 = zext i64 %r21 to i384
%r53 = shl i384 %r52, 320
%r54 = or i384 %r51, %r53
%r55 = zext i384 %r54 to i448
%r56 = zext i64 %r24 to i448
%r57 = shl i448 %r56, 384
%r58 = or i448 %r55, %r57
%r59 = zext i448 %r58 to i512
%r60 = zext i64 %r27 to i512
%r61 = shl i512 %r60, 448
%r62 = or i512 %r59, %r61
%r63 = zext i512 %r62 to i576
%r64 = zext i64 %r30 to i576
%r65 = shl i576 %r64, 512
%r66 = or i576 %r63, %r65
%r67 = zext i576 %r66 to i640
%r68 = zext i64 %r33 to i640
%r69 = shl i640 %r68, 576
%r70 = or i640 %r67, %r69
%r71 = zext i64 %r7 to i128
%r72 = zext i64 %r10 to i128
%r73 = shl i128 %r72, 64
%r74 = or i128 %r71, %r73
%r75 = zext i128 %r74 to i192
%r76 = zext i64 %r13 to i192
%r77 = shl i192 %r76, 128
%r78 = or i192 %r75, %r77
%r79 = zext i192 %r78 to i256
%r80 = zext i64 %r16 to i256
%r81 = shl i256 %r80, 192
%r82 = or i256 %r79, %r81
%r83 = zext i256 %r82 to i320
%r84 = zext i64 %r19 to i320
%r85 = shl i320 %r84, 256
%r86 = or i320 %r83, %r85
%r87 = zext i320 %r86 to i384
%r88 = zext i64 %r22 to i384
%r89 = shl i384 %r88, 320
%r90 = or i384 %r87, %r89
%r91 = zext i384 %r90 to i448
%r92 = zext i64 %r25 to i448
%r93 = shl i448 %r92, 384
%r94 = or i448 %r91, %r93
%r95 = zext i448 %r94 to i512
%r96 = zext i64 %r28 to i512
%r97 = shl i512 %r96, 448
%r98 = or i512 %r95, %r97
%r99 = zext i512 %r98 to i576
%r100 = zext i64 %r31 to i576
%r101 = shl i576 %r100, 512
%r102 = or i576 %r99, %r101
%r103 = zext i576 %r102 to i640
%r104 = zext i64 %r34 to i640
%r105 = shl i640 %r104, 576
%r106 = or i640 %r103, %r105
%r107 = zext i640 %r70 to i704
%r108 = zext i640 %r106 to i704
%r109 = shl i704 %r108, 64
%r110 = add i704 %r107, %r109
%r111 = bitcast i64* %r1 to i640*
%r112 = load i640, i640* %r111
%r113 = zext i640 %r112 to i704
%r114 = add i704 %r110, %r113
%r115 = trunc i704 %r114 to i640
%r116 = bitcast i64* %r1 to i640*
store i640 %r115, i640* %r116
%r117 = lshr i704 %r114, 640
%r118 = trunc i704 %r117 to i64
ret i64 %r118
}
define i768 @mulUnit_inner704(i64* noalias %r2, i64 %r3)
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
%r28 = call i128 @mulPos64x64(i64* %r2, i64 %r3, i64 8)
%r29 = trunc i128 %r28 to i64
%r30 = call i64 @extractHigh64(i128 %r28)
%r31 = call i128 @mulPos64x64(i64* %r2, i64 %r3, i64 9)
%r32 = trunc i128 %r31 to i64
%r33 = call i64 @extractHigh64(i128 %r31)
%r34 = call i128 @mulPos64x64(i64* %r2, i64 %r3, i64 10)
%r35 = trunc i128 %r34 to i64
%r36 = call i64 @extractHigh64(i128 %r34)
%r37 = zext i64 %r5 to i128
%r38 = zext i64 %r8 to i128
%r39 = shl i128 %r38, 64
%r40 = or i128 %r37, %r39
%r41 = zext i128 %r40 to i192
%r42 = zext i64 %r11 to i192
%r43 = shl i192 %r42, 128
%r44 = or i192 %r41, %r43
%r45 = zext i192 %r44 to i256
%r46 = zext i64 %r14 to i256
%r47 = shl i256 %r46, 192
%r48 = or i256 %r45, %r47
%r49 = zext i256 %r48 to i320
%r50 = zext i64 %r17 to i320
%r51 = shl i320 %r50, 256
%r52 = or i320 %r49, %r51
%r53 = zext i320 %r52 to i384
%r54 = zext i64 %r20 to i384
%r55 = shl i384 %r54, 320
%r56 = or i384 %r53, %r55
%r57 = zext i384 %r56 to i448
%r58 = zext i64 %r23 to i448
%r59 = shl i448 %r58, 384
%r60 = or i448 %r57, %r59
%r61 = zext i448 %r60 to i512
%r62 = zext i64 %r26 to i512
%r63 = shl i512 %r62, 448
%r64 = or i512 %r61, %r63
%r65 = zext i512 %r64 to i576
%r66 = zext i64 %r29 to i576
%r67 = shl i576 %r66, 512
%r68 = or i576 %r65, %r67
%r69 = zext i576 %r68 to i640
%r70 = zext i64 %r32 to i640
%r71 = shl i640 %r70, 576
%r72 = or i640 %r69, %r71
%r73 = zext i640 %r72 to i704
%r74 = zext i64 %r35 to i704
%r75 = shl i704 %r74, 640
%r76 = or i704 %r73, %r75
%r77 = zext i64 %r6 to i128
%r78 = zext i64 %r9 to i128
%r79 = shl i128 %r78, 64
%r80 = or i128 %r77, %r79
%r81 = zext i128 %r80 to i192
%r82 = zext i64 %r12 to i192
%r83 = shl i192 %r82, 128
%r84 = or i192 %r81, %r83
%r85 = zext i192 %r84 to i256
%r86 = zext i64 %r15 to i256
%r87 = shl i256 %r86, 192
%r88 = or i256 %r85, %r87
%r89 = zext i256 %r88 to i320
%r90 = zext i64 %r18 to i320
%r91 = shl i320 %r90, 256
%r92 = or i320 %r89, %r91
%r93 = zext i320 %r92 to i384
%r94 = zext i64 %r21 to i384
%r95 = shl i384 %r94, 320
%r96 = or i384 %r93, %r95
%r97 = zext i384 %r96 to i448
%r98 = zext i64 %r24 to i448
%r99 = shl i448 %r98, 384
%r100 = or i448 %r97, %r99
%r101 = zext i448 %r100 to i512
%r102 = zext i64 %r27 to i512
%r103 = shl i512 %r102, 448
%r104 = or i512 %r101, %r103
%r105 = zext i512 %r104 to i576
%r106 = zext i64 %r30 to i576
%r107 = shl i576 %r106, 512
%r108 = or i576 %r105, %r107
%r109 = zext i576 %r108 to i640
%r110 = zext i64 %r33 to i640
%r111 = shl i640 %r110, 576
%r112 = or i640 %r109, %r111
%r113 = zext i640 %r112 to i704
%r114 = zext i64 %r36 to i704
%r115 = shl i704 %r114, 640
%r116 = or i704 %r113, %r115
%r117 = zext i704 %r76 to i768
%r118 = zext i704 %r116 to i768
%r119 = shl i768 %r118, 64
%r120 = add i768 %r117, %r119
ret i768 %r120
}
define i64 @mclb_mulUnit11(i64* noalias %r1, i64* noalias %r2, i64 %r3)
{
%r5 = call i768 @mulUnit_inner704(i64* %r2, i64 %r3)
%r6 = trunc i768 %r5 to i704
%r7 = bitcast i64* %r1 to i704*
store i704 %r6, i704* %r7
%r8 = lshr i768 %r5, 704
%r9 = trunc i768 %r8 to i64
ret i64 %r9
}
define i64 @mclb_mulUnitAdd11(i64* noalias %r1, i64* noalias %r2, i64 %r3)
{
%r5 = call i128 @mulPos64x64(i64* %r2, i64 %r3, i64 0)
%r6 = trunc i128 %r5 to i64
%r7 = call i64 @extractHigh64(i128 %r5)
%r8 = call i128 @mulPos64x64(i64* %r2, i64 %r3, i64 1)
%r9 = trunc i128 %r8 to i64
%r10 = call i64 @extractHigh64(i128 %r8)
%r11 = call i128 @mulPos64x64(i64* %r2, i64 %r3, i64 2)
%r12 = trunc i128 %r11 to i64
%r13 = call i64 @extractHigh64(i128 %r11)
%r14 = call i128 @mulPos64x64(i64* %r2, i64 %r3, i64 3)
%r15 = trunc i128 %r14 to i64
%r16 = call i64 @extractHigh64(i128 %r14)
%r17 = call i128 @mulPos64x64(i64* %r2, i64 %r3, i64 4)
%r18 = trunc i128 %r17 to i64
%r19 = call i64 @extractHigh64(i128 %r17)
%r20 = call i128 @mulPos64x64(i64* %r2, i64 %r3, i64 5)
%r21 = trunc i128 %r20 to i64
%r22 = call i64 @extractHigh64(i128 %r20)
%r23 = call i128 @mulPos64x64(i64* %r2, i64 %r3, i64 6)
%r24 = trunc i128 %r23 to i64
%r25 = call i64 @extractHigh64(i128 %r23)
%r26 = call i128 @mulPos64x64(i64* %r2, i64 %r3, i64 7)
%r27 = trunc i128 %r26 to i64
%r28 = call i64 @extractHigh64(i128 %r26)
%r29 = call i128 @mulPos64x64(i64* %r2, i64 %r3, i64 8)
%r30 = trunc i128 %r29 to i64
%r31 = call i64 @extractHigh64(i128 %r29)
%r32 = call i128 @mulPos64x64(i64* %r2, i64 %r3, i64 9)
%r33 = trunc i128 %r32 to i64
%r34 = call i64 @extractHigh64(i128 %r32)
%r35 = call i128 @mulPos64x64(i64* %r2, i64 %r3, i64 10)
%r36 = trunc i128 %r35 to i64
%r37 = call i64 @extractHigh64(i128 %r35)
%r38 = zext i64 %r6 to i128
%r39 = zext i64 %r9 to i128
%r40 = shl i128 %r39, 64
%r41 = or i128 %r38, %r40
%r42 = zext i128 %r41 to i192
%r43 = zext i64 %r12 to i192
%r44 = shl i192 %r43, 128
%r45 = or i192 %r42, %r44
%r46 = zext i192 %r45 to i256
%r47 = zext i64 %r15 to i256
%r48 = shl i256 %r47, 192
%r49 = or i256 %r46, %r48
%r50 = zext i256 %r49 to i320
%r51 = zext i64 %r18 to i320
%r52 = shl i320 %r51, 256
%r53 = or i320 %r50, %r52
%r54 = zext i320 %r53 to i384
%r55 = zext i64 %r21 to i384
%r56 = shl i384 %r55, 320
%r57 = or i384 %r54, %r56
%r58 = zext i384 %r57 to i448
%r59 = zext i64 %r24 to i448
%r60 = shl i448 %r59, 384
%r61 = or i448 %r58, %r60
%r62 = zext i448 %r61 to i512
%r63 = zext i64 %r27 to i512
%r64 = shl i512 %r63, 448
%r65 = or i512 %r62, %r64
%r66 = zext i512 %r65 to i576
%r67 = zext i64 %r30 to i576
%r68 = shl i576 %r67, 512
%r69 = or i576 %r66, %r68
%r70 = zext i576 %r69 to i640
%r71 = zext i64 %r33 to i640
%r72 = shl i640 %r71, 576
%r73 = or i640 %r70, %r72
%r74 = zext i640 %r73 to i704
%r75 = zext i64 %r36 to i704
%r76 = shl i704 %r75, 640
%r77 = or i704 %r74, %r76
%r78 = zext i64 %r7 to i128
%r79 = zext i64 %r10 to i128
%r80 = shl i128 %r79, 64
%r81 = or i128 %r78, %r80
%r82 = zext i128 %r81 to i192
%r83 = zext i64 %r13 to i192
%r84 = shl i192 %r83, 128
%r85 = or i192 %r82, %r84
%r86 = zext i192 %r85 to i256
%r87 = zext i64 %r16 to i256
%r88 = shl i256 %r87, 192
%r89 = or i256 %r86, %r88
%r90 = zext i256 %r89 to i320
%r91 = zext i64 %r19 to i320
%r92 = shl i320 %r91, 256
%r93 = or i320 %r90, %r92
%r94 = zext i320 %r93 to i384
%r95 = zext i64 %r22 to i384
%r96 = shl i384 %r95, 320
%r97 = or i384 %r94, %r96
%r98 = zext i384 %r97 to i448
%r99 = zext i64 %r25 to i448
%r100 = shl i448 %r99, 384
%r101 = or i448 %r98, %r100
%r102 = zext i448 %r101 to i512
%r103 = zext i64 %r28 to i512
%r104 = shl i512 %r103, 448
%r105 = or i512 %r102, %r104
%r106 = zext i512 %r105 to i576
%r107 = zext i64 %r31 to i576
%r108 = shl i576 %r107, 512
%r109 = or i576 %r106, %r108
%r110 = zext i576 %r109 to i640
%r111 = zext i64 %r34 to i640
%r112 = shl i640 %r111, 576
%r113 = or i640 %r110, %r112
%r114 = zext i640 %r113 to i704
%r115 = zext i64 %r37 to i704
%r116 = shl i704 %r115, 640
%r117 = or i704 %r114, %r116
%r118 = zext i704 %r77 to i768
%r119 = zext i704 %r117 to i768
%r120 = shl i768 %r119, 64
%r121 = add i768 %r118, %r120
%r122 = bitcast i64* %r1 to i704*
%r123 = load i704, i704* %r122
%r124 = zext i704 %r123 to i768
%r125 = add i768 %r121, %r124
%r126 = trunc i768 %r125 to i704
%r127 = bitcast i64* %r1 to i704*
store i704 %r126, i704* %r127
%r128 = lshr i768 %r125, 704
%r129 = trunc i768 %r128 to i64
ret i64 %r129
}
define i832 @mulUnit_inner768(i64* noalias %r2, i64 %r3)
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
%r28 = call i128 @mulPos64x64(i64* %r2, i64 %r3, i64 8)
%r29 = trunc i128 %r28 to i64
%r30 = call i64 @extractHigh64(i128 %r28)
%r31 = call i128 @mulPos64x64(i64* %r2, i64 %r3, i64 9)
%r32 = trunc i128 %r31 to i64
%r33 = call i64 @extractHigh64(i128 %r31)
%r34 = call i128 @mulPos64x64(i64* %r2, i64 %r3, i64 10)
%r35 = trunc i128 %r34 to i64
%r36 = call i64 @extractHigh64(i128 %r34)
%r37 = call i128 @mulPos64x64(i64* %r2, i64 %r3, i64 11)
%r38 = trunc i128 %r37 to i64
%r39 = call i64 @extractHigh64(i128 %r37)
%r40 = zext i64 %r5 to i128
%r41 = zext i64 %r8 to i128
%r42 = shl i128 %r41, 64
%r43 = or i128 %r40, %r42
%r44 = zext i128 %r43 to i192
%r45 = zext i64 %r11 to i192
%r46 = shl i192 %r45, 128
%r47 = or i192 %r44, %r46
%r48 = zext i192 %r47 to i256
%r49 = zext i64 %r14 to i256
%r50 = shl i256 %r49, 192
%r51 = or i256 %r48, %r50
%r52 = zext i256 %r51 to i320
%r53 = zext i64 %r17 to i320
%r54 = shl i320 %r53, 256
%r55 = or i320 %r52, %r54
%r56 = zext i320 %r55 to i384
%r57 = zext i64 %r20 to i384
%r58 = shl i384 %r57, 320
%r59 = or i384 %r56, %r58
%r60 = zext i384 %r59 to i448
%r61 = zext i64 %r23 to i448
%r62 = shl i448 %r61, 384
%r63 = or i448 %r60, %r62
%r64 = zext i448 %r63 to i512
%r65 = zext i64 %r26 to i512
%r66 = shl i512 %r65, 448
%r67 = or i512 %r64, %r66
%r68 = zext i512 %r67 to i576
%r69 = zext i64 %r29 to i576
%r70 = shl i576 %r69, 512
%r71 = or i576 %r68, %r70
%r72 = zext i576 %r71 to i640
%r73 = zext i64 %r32 to i640
%r74 = shl i640 %r73, 576
%r75 = or i640 %r72, %r74
%r76 = zext i640 %r75 to i704
%r77 = zext i64 %r35 to i704
%r78 = shl i704 %r77, 640
%r79 = or i704 %r76, %r78
%r80 = zext i704 %r79 to i768
%r81 = zext i64 %r38 to i768
%r82 = shl i768 %r81, 704
%r83 = or i768 %r80, %r82
%r84 = zext i64 %r6 to i128
%r85 = zext i64 %r9 to i128
%r86 = shl i128 %r85, 64
%r87 = or i128 %r84, %r86
%r88 = zext i128 %r87 to i192
%r89 = zext i64 %r12 to i192
%r90 = shl i192 %r89, 128
%r91 = or i192 %r88, %r90
%r92 = zext i192 %r91 to i256
%r93 = zext i64 %r15 to i256
%r94 = shl i256 %r93, 192
%r95 = or i256 %r92, %r94
%r96 = zext i256 %r95 to i320
%r97 = zext i64 %r18 to i320
%r98 = shl i320 %r97, 256
%r99 = or i320 %r96, %r98
%r100 = zext i320 %r99 to i384
%r101 = zext i64 %r21 to i384
%r102 = shl i384 %r101, 320
%r103 = or i384 %r100, %r102
%r104 = zext i384 %r103 to i448
%r105 = zext i64 %r24 to i448
%r106 = shl i448 %r105, 384
%r107 = or i448 %r104, %r106
%r108 = zext i448 %r107 to i512
%r109 = zext i64 %r27 to i512
%r110 = shl i512 %r109, 448
%r111 = or i512 %r108, %r110
%r112 = zext i512 %r111 to i576
%r113 = zext i64 %r30 to i576
%r114 = shl i576 %r113, 512
%r115 = or i576 %r112, %r114
%r116 = zext i576 %r115 to i640
%r117 = zext i64 %r33 to i640
%r118 = shl i640 %r117, 576
%r119 = or i640 %r116, %r118
%r120 = zext i640 %r119 to i704
%r121 = zext i64 %r36 to i704
%r122 = shl i704 %r121, 640
%r123 = or i704 %r120, %r122
%r124 = zext i704 %r123 to i768
%r125 = zext i64 %r39 to i768
%r126 = shl i768 %r125, 704
%r127 = or i768 %r124, %r126
%r128 = zext i768 %r83 to i832
%r129 = zext i768 %r127 to i832
%r130 = shl i832 %r129, 64
%r131 = add i832 %r128, %r130
ret i832 %r131
}
define i64 @mclb_mulUnit12(i64* noalias %r1, i64* noalias %r2, i64 %r3)
{
%r5 = call i832 @mulUnit_inner768(i64* %r2, i64 %r3)
%r6 = trunc i832 %r5 to i768
%r7 = bitcast i64* %r1 to i768*
store i768 %r6, i768* %r7
%r8 = lshr i832 %r5, 768
%r9 = trunc i832 %r8 to i64
ret i64 %r9
}
define i64 @mclb_mulUnitAdd12(i64* noalias %r1, i64* noalias %r2, i64 %r3)
{
%r5 = call i128 @mulPos64x64(i64* %r2, i64 %r3, i64 0)
%r6 = trunc i128 %r5 to i64
%r7 = call i64 @extractHigh64(i128 %r5)
%r8 = call i128 @mulPos64x64(i64* %r2, i64 %r3, i64 1)
%r9 = trunc i128 %r8 to i64
%r10 = call i64 @extractHigh64(i128 %r8)
%r11 = call i128 @mulPos64x64(i64* %r2, i64 %r3, i64 2)
%r12 = trunc i128 %r11 to i64
%r13 = call i64 @extractHigh64(i128 %r11)
%r14 = call i128 @mulPos64x64(i64* %r2, i64 %r3, i64 3)
%r15 = trunc i128 %r14 to i64
%r16 = call i64 @extractHigh64(i128 %r14)
%r17 = call i128 @mulPos64x64(i64* %r2, i64 %r3, i64 4)
%r18 = trunc i128 %r17 to i64
%r19 = call i64 @extractHigh64(i128 %r17)
%r20 = call i128 @mulPos64x64(i64* %r2, i64 %r3, i64 5)
%r21 = trunc i128 %r20 to i64
%r22 = call i64 @extractHigh64(i128 %r20)
%r23 = call i128 @mulPos64x64(i64* %r2, i64 %r3, i64 6)
%r24 = trunc i128 %r23 to i64
%r25 = call i64 @extractHigh64(i128 %r23)
%r26 = call i128 @mulPos64x64(i64* %r2, i64 %r3, i64 7)
%r27 = trunc i128 %r26 to i64
%r28 = call i64 @extractHigh64(i128 %r26)
%r29 = call i128 @mulPos64x64(i64* %r2, i64 %r3, i64 8)
%r30 = trunc i128 %r29 to i64
%r31 = call i64 @extractHigh64(i128 %r29)
%r32 = call i128 @mulPos64x64(i64* %r2, i64 %r3, i64 9)
%r33 = trunc i128 %r32 to i64
%r34 = call i64 @extractHigh64(i128 %r32)
%r35 = call i128 @mulPos64x64(i64* %r2, i64 %r3, i64 10)
%r36 = trunc i128 %r35 to i64
%r37 = call i64 @extractHigh64(i128 %r35)
%r38 = call i128 @mulPos64x64(i64* %r2, i64 %r3, i64 11)
%r39 = trunc i128 %r38 to i64
%r40 = call i64 @extractHigh64(i128 %r38)
%r41 = zext i64 %r6 to i128
%r42 = zext i64 %r9 to i128
%r43 = shl i128 %r42, 64
%r44 = or i128 %r41, %r43
%r45 = zext i128 %r44 to i192
%r46 = zext i64 %r12 to i192
%r47 = shl i192 %r46, 128
%r48 = or i192 %r45, %r47
%r49 = zext i192 %r48 to i256
%r50 = zext i64 %r15 to i256
%r51 = shl i256 %r50, 192
%r52 = or i256 %r49, %r51
%r53 = zext i256 %r52 to i320
%r54 = zext i64 %r18 to i320
%r55 = shl i320 %r54, 256
%r56 = or i320 %r53, %r55
%r57 = zext i320 %r56 to i384
%r58 = zext i64 %r21 to i384
%r59 = shl i384 %r58, 320
%r60 = or i384 %r57, %r59
%r61 = zext i384 %r60 to i448
%r62 = zext i64 %r24 to i448
%r63 = shl i448 %r62, 384
%r64 = or i448 %r61, %r63
%r65 = zext i448 %r64 to i512
%r66 = zext i64 %r27 to i512
%r67 = shl i512 %r66, 448
%r68 = or i512 %r65, %r67
%r69 = zext i512 %r68 to i576
%r70 = zext i64 %r30 to i576
%r71 = shl i576 %r70, 512
%r72 = or i576 %r69, %r71
%r73 = zext i576 %r72 to i640
%r74 = zext i64 %r33 to i640
%r75 = shl i640 %r74, 576
%r76 = or i640 %r73, %r75
%r77 = zext i640 %r76 to i704
%r78 = zext i64 %r36 to i704
%r79 = shl i704 %r78, 640
%r80 = or i704 %r77, %r79
%r81 = zext i704 %r80 to i768
%r82 = zext i64 %r39 to i768
%r83 = shl i768 %r82, 704
%r84 = or i768 %r81, %r83
%r85 = zext i64 %r7 to i128
%r86 = zext i64 %r10 to i128
%r87 = shl i128 %r86, 64
%r88 = or i128 %r85, %r87
%r89 = zext i128 %r88 to i192
%r90 = zext i64 %r13 to i192
%r91 = shl i192 %r90, 128
%r92 = or i192 %r89, %r91
%r93 = zext i192 %r92 to i256
%r94 = zext i64 %r16 to i256
%r95 = shl i256 %r94, 192
%r96 = or i256 %r93, %r95
%r97 = zext i256 %r96 to i320
%r98 = zext i64 %r19 to i320
%r99 = shl i320 %r98, 256
%r100 = or i320 %r97, %r99
%r101 = zext i320 %r100 to i384
%r102 = zext i64 %r22 to i384
%r103 = shl i384 %r102, 320
%r104 = or i384 %r101, %r103
%r105 = zext i384 %r104 to i448
%r106 = zext i64 %r25 to i448
%r107 = shl i448 %r106, 384
%r108 = or i448 %r105, %r107
%r109 = zext i448 %r108 to i512
%r110 = zext i64 %r28 to i512
%r111 = shl i512 %r110, 448
%r112 = or i512 %r109, %r111
%r113 = zext i512 %r112 to i576
%r114 = zext i64 %r31 to i576
%r115 = shl i576 %r114, 512
%r116 = or i576 %r113, %r115
%r117 = zext i576 %r116 to i640
%r118 = zext i64 %r34 to i640
%r119 = shl i640 %r118, 576
%r120 = or i640 %r117, %r119
%r121 = zext i640 %r120 to i704
%r122 = zext i64 %r37 to i704
%r123 = shl i704 %r122, 640
%r124 = or i704 %r121, %r123
%r125 = zext i704 %r124 to i768
%r126 = zext i64 %r40 to i768
%r127 = shl i768 %r126, 704
%r128 = or i768 %r125, %r127
%r129 = zext i768 %r84 to i832
%r130 = zext i768 %r128 to i832
%r131 = shl i832 %r130, 64
%r132 = add i832 %r129, %r131
%r133 = bitcast i64* %r1 to i768*
%r134 = load i768, i768* %r133
%r135 = zext i768 %r134 to i832
%r136 = add i832 %r132, %r135
%r137 = trunc i832 %r136 to i768
%r138 = bitcast i64* %r1 to i768*
store i768 %r137, i768* %r138
%r139 = lshr i832 %r136, 768
%r140 = trunc i832 %r139 to i64
ret i64 %r140
}
define void @mclb_mul1(i64* noalias %r1, i64* noalias %r2, i64* noalias %r3)
{
%r4 = load i64, i64* %r2
%r5 = load i64, i64* %r3
%r6 = zext i64 %r4 to i128
%r7 = zext i64 %r5 to i128
%r8 = mul i128 %r6, %r7
%r9 = bitcast i64* %r1 to i128*
store i128 %r8, i128* %r9
ret void
}
define void @mclb_sqr1(i64* noalias %r1, i64* noalias %r2)
{
%r3 = load i64, i64* %r2
%r4 = load i64, i64* %r2
%r5 = zext i64 %r3 to i128
%r6 = zext i64 %r4 to i128
%r7 = mul i128 %r5, %r6
%r8 = bitcast i64* %r1 to i128*
store i128 %r7, i128* %r8
ret void
}
define void @mclb_mul2(i64* noalias %r1, i64* noalias %r2, i64* noalias %r3)
{
%r4 = load i64, i64* %r3
%r5 = call i192 @mulUnit_inner128(i64* %r2, i64 %r4)
%r6 = trunc i192 %r5 to i64
store i64 %r6, i64* %r1
%r7 = lshr i192 %r5, 64
%r8 = getelementptr i64, i64* %r3, i32 1
%r9 = load i64, i64* %r8
%r10 = call i192 @mulUnit_inner128(i64* %r2, i64 %r9)
%r11 = add i192 %r7, %r10
%r12 = getelementptr i64, i64* %r1, i32 1
%r13 = bitcast i64* %r12 to i192*
store i192 %r11, i192* %r13
ret void
}
define void @mclb_sqr2(i64* noalias %r1, i64* noalias %r2)
{
%r3 = load i64, i64* %r2
%r4 = call i192 @mulUnit_inner128(i64* %r2, i64 %r3)
%r5 = trunc i192 %r4 to i64
store i64 %r5, i64* %r1
%r6 = lshr i192 %r4, 64
%r7 = getelementptr i64, i64* %r2, i32 1
%r8 = load i64, i64* %r7
%r9 = call i192 @mulUnit_inner128(i64* %r2, i64 %r8)
%r10 = add i192 %r6, %r9
%r11 = getelementptr i64, i64* %r1, i32 1
%r12 = bitcast i64* %r11 to i192*
store i192 %r10, i192* %r12
ret void
}
define void @mclb_mul3(i64* noalias %r1, i64* noalias %r2, i64* noalias %r3)
{
%r4 = load i64, i64* %r3
%r5 = call i256 @mulUnit_inner192(i64* %r2, i64 %r4)
%r6 = trunc i256 %r5 to i64
store i64 %r6, i64* %r1
%r7 = lshr i256 %r5, 64
%r8 = getelementptr i64, i64* %r3, i32 1
%r9 = load i64, i64* %r8
%r10 = call i256 @mulUnit_inner192(i64* %r2, i64 %r9)
%r11 = add i256 %r7, %r10
%r12 = trunc i256 %r11 to i64
%r13 = getelementptr i64, i64* %r1, i32 1
store i64 %r12, i64* %r13
%r14 = lshr i256 %r11, 64
%r15 = getelementptr i64, i64* %r3, i32 2
%r16 = load i64, i64* %r15
%r17 = call i256 @mulUnit_inner192(i64* %r2, i64 %r16)
%r18 = add i256 %r14, %r17
%r19 = getelementptr i64, i64* %r1, i32 2
%r20 = bitcast i64* %r19 to i256*
store i256 %r18, i256* %r20
ret void
}
define void @mclb_sqr3(i64* noalias %r1, i64* noalias %r2)
{
%r3 = load i64, i64* %r2
%r4 = call i256 @mulUnit_inner192(i64* %r2, i64 %r3)
%r5 = trunc i256 %r4 to i64
store i64 %r5, i64* %r1
%r6 = lshr i256 %r4, 64
%r7 = getelementptr i64, i64* %r2, i32 1
%r8 = load i64, i64* %r7
%r9 = call i256 @mulUnit_inner192(i64* %r2, i64 %r8)
%r10 = add i256 %r6, %r9
%r11 = trunc i256 %r10 to i64
%r12 = getelementptr i64, i64* %r1, i32 1
store i64 %r11, i64* %r12
%r13 = lshr i256 %r10, 64
%r14 = getelementptr i64, i64* %r2, i32 2
%r15 = load i64, i64* %r14
%r16 = call i256 @mulUnit_inner192(i64* %r2, i64 %r15)
%r17 = add i256 %r13, %r16
%r18 = getelementptr i64, i64* %r1, i32 2
%r19 = bitcast i64* %r18 to i256*
store i256 %r17, i256* %r19
ret void
}
define void @mclb_mul4(i64* noalias %r1, i64* noalias %r2, i64* noalias %r3)
{
%r4 = load i64, i64* %r3
%r5 = call i320 @mulUnit_inner256(i64* %r2, i64 %r4)
%r6 = trunc i320 %r5 to i64
store i64 %r6, i64* %r1
%r7 = lshr i320 %r5, 64
%r8 = getelementptr i64, i64* %r3, i32 1
%r9 = load i64, i64* %r8
%r10 = call i320 @mulUnit_inner256(i64* %r2, i64 %r9)
%r11 = add i320 %r7, %r10
%r12 = trunc i320 %r11 to i64
%r13 = getelementptr i64, i64* %r1, i32 1
store i64 %r12, i64* %r13
%r14 = lshr i320 %r11, 64
%r15 = getelementptr i64, i64* %r3, i32 2
%r16 = load i64, i64* %r15
%r17 = call i320 @mulUnit_inner256(i64* %r2, i64 %r16)
%r18 = add i320 %r14, %r17
%r19 = trunc i320 %r18 to i64
%r20 = getelementptr i64, i64* %r1, i32 2
store i64 %r19, i64* %r20
%r21 = lshr i320 %r18, 64
%r22 = getelementptr i64, i64* %r3, i32 3
%r23 = load i64, i64* %r22
%r24 = call i320 @mulUnit_inner256(i64* %r2, i64 %r23)
%r25 = add i320 %r21, %r24
%r26 = getelementptr i64, i64* %r1, i32 3
%r27 = bitcast i64* %r26 to i320*
store i320 %r25, i320* %r27
ret void
}
define void @mclb_sqr4(i64* noalias %r1, i64* noalias %r2)
{
%r3 = load i64, i64* %r2
%r4 = call i320 @mulUnit_inner256(i64* %r2, i64 %r3)
%r5 = trunc i320 %r4 to i64
store i64 %r5, i64* %r1
%r6 = lshr i320 %r4, 64
%r7 = getelementptr i64, i64* %r2, i32 1
%r8 = load i64, i64* %r7
%r9 = call i320 @mulUnit_inner256(i64* %r2, i64 %r8)
%r10 = add i320 %r6, %r9
%r11 = trunc i320 %r10 to i64
%r12 = getelementptr i64, i64* %r1, i32 1
store i64 %r11, i64* %r12
%r13 = lshr i320 %r10, 64
%r14 = getelementptr i64, i64* %r2, i32 2
%r15 = load i64, i64* %r14
%r16 = call i320 @mulUnit_inner256(i64* %r2, i64 %r15)
%r17 = add i320 %r13, %r16
%r18 = trunc i320 %r17 to i64
%r19 = getelementptr i64, i64* %r1, i32 2
store i64 %r18, i64* %r19
%r20 = lshr i320 %r17, 64
%r21 = getelementptr i64, i64* %r2, i32 3
%r22 = load i64, i64* %r21
%r23 = call i320 @mulUnit_inner256(i64* %r2, i64 %r22)
%r24 = add i320 %r20, %r23
%r25 = getelementptr i64, i64* %r1, i32 3
%r26 = bitcast i64* %r25 to i320*
store i320 %r24, i320* %r26
ret void
}
define void @mclb_mul5(i64* noalias %r1, i64* noalias %r2, i64* noalias %r3)
{
%r4 = load i64, i64* %r3
%r5 = call i384 @mulUnit_inner320(i64* %r2, i64 %r4)
%r6 = trunc i384 %r5 to i64
store i64 %r6, i64* %r1
%r7 = lshr i384 %r5, 64
%r8 = getelementptr i64, i64* %r3, i32 1
%r9 = load i64, i64* %r8
%r10 = call i384 @mulUnit_inner320(i64* %r2, i64 %r9)
%r11 = add i384 %r7, %r10
%r12 = trunc i384 %r11 to i64
%r13 = getelementptr i64, i64* %r1, i32 1
store i64 %r12, i64* %r13
%r14 = lshr i384 %r11, 64
%r15 = getelementptr i64, i64* %r3, i32 2
%r16 = load i64, i64* %r15
%r17 = call i384 @mulUnit_inner320(i64* %r2, i64 %r16)
%r18 = add i384 %r14, %r17
%r19 = trunc i384 %r18 to i64
%r20 = getelementptr i64, i64* %r1, i32 2
store i64 %r19, i64* %r20
%r21 = lshr i384 %r18, 64
%r22 = getelementptr i64, i64* %r3, i32 3
%r23 = load i64, i64* %r22
%r24 = call i384 @mulUnit_inner320(i64* %r2, i64 %r23)
%r25 = add i384 %r21, %r24
%r26 = trunc i384 %r25 to i64
%r27 = getelementptr i64, i64* %r1, i32 3
store i64 %r26, i64* %r27
%r28 = lshr i384 %r25, 64
%r29 = getelementptr i64, i64* %r3, i32 4
%r30 = load i64, i64* %r29
%r31 = call i384 @mulUnit_inner320(i64* %r2, i64 %r30)
%r32 = add i384 %r28, %r31
%r33 = getelementptr i64, i64* %r1, i32 4
%r34 = bitcast i64* %r33 to i384*
store i384 %r32, i384* %r34
ret void
}
define void @mclb_sqr5(i64* noalias %r1, i64* noalias %r2)
{
%r3 = load i64, i64* %r2
%r4 = call i384 @mulUnit_inner320(i64* %r2, i64 %r3)
%r5 = trunc i384 %r4 to i64
store i64 %r5, i64* %r1
%r6 = lshr i384 %r4, 64
%r7 = getelementptr i64, i64* %r2, i32 1
%r8 = load i64, i64* %r7
%r9 = call i384 @mulUnit_inner320(i64* %r2, i64 %r8)
%r10 = add i384 %r6, %r9
%r11 = trunc i384 %r10 to i64
%r12 = getelementptr i64, i64* %r1, i32 1
store i64 %r11, i64* %r12
%r13 = lshr i384 %r10, 64
%r14 = getelementptr i64, i64* %r2, i32 2
%r15 = load i64, i64* %r14
%r16 = call i384 @mulUnit_inner320(i64* %r2, i64 %r15)
%r17 = add i384 %r13, %r16
%r18 = trunc i384 %r17 to i64
%r19 = getelementptr i64, i64* %r1, i32 2
store i64 %r18, i64* %r19
%r20 = lshr i384 %r17, 64
%r21 = getelementptr i64, i64* %r2, i32 3
%r22 = load i64, i64* %r21
%r23 = call i384 @mulUnit_inner320(i64* %r2, i64 %r22)
%r24 = add i384 %r20, %r23
%r25 = trunc i384 %r24 to i64
%r26 = getelementptr i64, i64* %r1, i32 3
store i64 %r25, i64* %r26
%r27 = lshr i384 %r24, 64
%r28 = getelementptr i64, i64* %r2, i32 4
%r29 = load i64, i64* %r28
%r30 = call i384 @mulUnit_inner320(i64* %r2, i64 %r29)
%r31 = add i384 %r27, %r30
%r32 = getelementptr i64, i64* %r1, i32 4
%r33 = bitcast i64* %r32 to i384*
store i384 %r31, i384* %r33
ret void
}
define void @mclb_mul6(i64* noalias %r1, i64* noalias %r2, i64* noalias %r3)
{
%r4 = load i64, i64* %r3
%r5 = call i448 @mulUnit_inner384(i64* %r2, i64 %r4)
%r6 = trunc i448 %r5 to i64
store i64 %r6, i64* %r1
%r7 = lshr i448 %r5, 64
%r8 = getelementptr i64, i64* %r3, i32 1
%r9 = load i64, i64* %r8
%r10 = call i448 @mulUnit_inner384(i64* %r2, i64 %r9)
%r11 = add i448 %r7, %r10
%r12 = trunc i448 %r11 to i64
%r13 = getelementptr i64, i64* %r1, i32 1
store i64 %r12, i64* %r13
%r14 = lshr i448 %r11, 64
%r15 = getelementptr i64, i64* %r3, i32 2
%r16 = load i64, i64* %r15
%r17 = call i448 @mulUnit_inner384(i64* %r2, i64 %r16)
%r18 = add i448 %r14, %r17
%r19 = trunc i448 %r18 to i64
%r20 = getelementptr i64, i64* %r1, i32 2
store i64 %r19, i64* %r20
%r21 = lshr i448 %r18, 64
%r22 = getelementptr i64, i64* %r3, i32 3
%r23 = load i64, i64* %r22
%r24 = call i448 @mulUnit_inner384(i64* %r2, i64 %r23)
%r25 = add i448 %r21, %r24
%r26 = trunc i448 %r25 to i64
%r27 = getelementptr i64, i64* %r1, i32 3
store i64 %r26, i64* %r27
%r28 = lshr i448 %r25, 64
%r29 = getelementptr i64, i64* %r3, i32 4
%r30 = load i64, i64* %r29
%r31 = call i448 @mulUnit_inner384(i64* %r2, i64 %r30)
%r32 = add i448 %r28, %r31
%r33 = trunc i448 %r32 to i64
%r34 = getelementptr i64, i64* %r1, i32 4
store i64 %r33, i64* %r34
%r35 = lshr i448 %r32, 64
%r36 = getelementptr i64, i64* %r3, i32 5
%r37 = load i64, i64* %r36
%r38 = call i448 @mulUnit_inner384(i64* %r2, i64 %r37)
%r39 = add i448 %r35, %r38
%r40 = getelementptr i64, i64* %r1, i32 5
%r41 = bitcast i64* %r40 to i448*
store i448 %r39, i448* %r41
ret void
}
define void @mclb_sqr6(i64* noalias %r1, i64* noalias %r2)
{
%r3 = load i64, i64* %r2
%r4 = call i448 @mulUnit_inner384(i64* %r2, i64 %r3)
%r5 = trunc i448 %r4 to i64
store i64 %r5, i64* %r1
%r6 = lshr i448 %r4, 64
%r7 = getelementptr i64, i64* %r2, i32 1
%r8 = load i64, i64* %r7
%r9 = call i448 @mulUnit_inner384(i64* %r2, i64 %r8)
%r10 = add i448 %r6, %r9
%r11 = trunc i448 %r10 to i64
%r12 = getelementptr i64, i64* %r1, i32 1
store i64 %r11, i64* %r12
%r13 = lshr i448 %r10, 64
%r14 = getelementptr i64, i64* %r2, i32 2
%r15 = load i64, i64* %r14
%r16 = call i448 @mulUnit_inner384(i64* %r2, i64 %r15)
%r17 = add i448 %r13, %r16
%r18 = trunc i448 %r17 to i64
%r19 = getelementptr i64, i64* %r1, i32 2
store i64 %r18, i64* %r19
%r20 = lshr i448 %r17, 64
%r21 = getelementptr i64, i64* %r2, i32 3
%r22 = load i64, i64* %r21
%r23 = call i448 @mulUnit_inner384(i64* %r2, i64 %r22)
%r24 = add i448 %r20, %r23
%r25 = trunc i448 %r24 to i64
%r26 = getelementptr i64, i64* %r1, i32 3
store i64 %r25, i64* %r26
%r27 = lshr i448 %r24, 64
%r28 = getelementptr i64, i64* %r2, i32 4
%r29 = load i64, i64* %r28
%r30 = call i448 @mulUnit_inner384(i64* %r2, i64 %r29)
%r31 = add i448 %r27, %r30
%r32 = trunc i448 %r31 to i64
%r33 = getelementptr i64, i64* %r1, i32 4
store i64 %r32, i64* %r33
%r34 = lshr i448 %r31, 64
%r35 = getelementptr i64, i64* %r2, i32 5
%r36 = load i64, i64* %r35
%r37 = call i448 @mulUnit_inner384(i64* %r2, i64 %r36)
%r38 = add i448 %r34, %r37
%r39 = getelementptr i64, i64* %r1, i32 5
%r40 = bitcast i64* %r39 to i448*
store i448 %r38, i448* %r40
ret void
}
