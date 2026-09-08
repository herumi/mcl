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
define i64 @mclb_add13(i64* noalias %r1, i64* noalias %r2, i64* noalias %r3)
{
%r5 = bitcast i64* %r2 to i832*
%r6 = load i832, i832* %r5
%r7 = zext i832 %r6 to i896
%r8 = bitcast i64* %r3 to i832*
%r9 = load i832, i832* %r8
%r10 = zext i832 %r9 to i896
%r11 = add i896 %r7, %r10
%r12 = trunc i896 %r11 to i832
%r13 = bitcast i64* %r1 to i832*
store i832 %r12, i832* %r13
%r14 = lshr i896 %r11, 832
%r15 = trunc i896 %r14 to i64
ret i64 %r15
}
define i64 @mclb_sub13(i64* noalias %r1, i64* noalias %r2, i64* noalias %r3)
{
%r5 = bitcast i64* %r2 to i832*
%r6 = load i832, i832* %r5
%r7 = zext i832 %r6 to i896
%r8 = bitcast i64* %r3 to i832*
%r9 = load i832, i832* %r8
%r10 = zext i832 %r9 to i896
%r11 = sub i896 %r7, %r10
%r12 = trunc i896 %r11 to i832
%r13 = bitcast i64* %r1 to i832*
store i832 %r12, i832* %r13
%r14 = lshr i896 %r11, 832
%r15 = trunc i896 %r14 to i64
%r16 = and i64 %r15, 1
ret i64 %r16
}
define void @mclb_addNF13(i64* noalias %r1, i64* noalias %r2, i64* noalias %r3)
{
%r4 = bitcast i64* %r2 to i832*
%r5 = load i832, i832* %r4
%r6 = bitcast i64* %r3 to i832*
%r7 = load i832, i832* %r6
%r8 = add i832 %r5, %r7
%r9 = bitcast i64* %r1 to i832*
store i832 %r8, i832* %r9
ret void
}
define i64 @mclb_subNF13(i64* noalias %r1, i64* noalias %r2, i64* noalias %r3)
{
%r5 = bitcast i64* %r2 to i832*
%r6 = load i832, i832* %r5
%r7 = bitcast i64* %r3 to i832*
%r8 = load i832, i832* %r7
%r9 = sub i832 %r6, %r8
%r10 = bitcast i64* %r1 to i832*
store i832 %r9, i832* %r10
%r11 = lshr i832 %r9, 831
%r12 = trunc i832 %r11 to i64
%r13 = and i64 %r12, 1
ret i64 %r13
}
define i64 @mclb_add14(i64* noalias %r1, i64* noalias %r2, i64* noalias %r3)
{
%r5 = bitcast i64* %r2 to i896*
%r6 = load i896, i896* %r5
%r7 = zext i896 %r6 to i960
%r8 = bitcast i64* %r3 to i896*
%r9 = load i896, i896* %r8
%r10 = zext i896 %r9 to i960
%r11 = add i960 %r7, %r10
%r12 = trunc i960 %r11 to i896
%r13 = bitcast i64* %r1 to i896*
store i896 %r12, i896* %r13
%r14 = lshr i960 %r11, 896
%r15 = trunc i960 %r14 to i64
ret i64 %r15
}
define i64 @mclb_sub14(i64* noalias %r1, i64* noalias %r2, i64* noalias %r3)
{
%r5 = bitcast i64* %r2 to i896*
%r6 = load i896, i896* %r5
%r7 = zext i896 %r6 to i960
%r8 = bitcast i64* %r3 to i896*
%r9 = load i896, i896* %r8
%r10 = zext i896 %r9 to i960
%r11 = sub i960 %r7, %r10
%r12 = trunc i960 %r11 to i896
%r13 = bitcast i64* %r1 to i896*
store i896 %r12, i896* %r13
%r14 = lshr i960 %r11, 896
%r15 = trunc i960 %r14 to i64
%r16 = and i64 %r15, 1
ret i64 %r16
}
define void @mclb_addNF14(i64* noalias %r1, i64* noalias %r2, i64* noalias %r3)
{
%r4 = bitcast i64* %r2 to i896*
%r5 = load i896, i896* %r4
%r6 = bitcast i64* %r3 to i896*
%r7 = load i896, i896* %r6
%r8 = add i896 %r5, %r7
%r9 = bitcast i64* %r1 to i896*
store i896 %r8, i896* %r9
ret void
}
define i64 @mclb_subNF14(i64* noalias %r1, i64* noalias %r2, i64* noalias %r3)
{
%r5 = bitcast i64* %r2 to i896*
%r6 = load i896, i896* %r5
%r7 = bitcast i64* %r3 to i896*
%r8 = load i896, i896* %r7
%r9 = sub i896 %r6, %r8
%r10 = bitcast i64* %r1 to i896*
store i896 %r9, i896* %r10
%r11 = lshr i896 %r9, 895
%r12 = trunc i896 %r11 to i64
%r13 = and i64 %r12, 1
ret i64 %r13
}
define i64 @mclb_add15(i64* noalias %r1, i64* noalias %r2, i64* noalias %r3)
{
%r5 = bitcast i64* %r2 to i960*
%r6 = load i960, i960* %r5
%r7 = zext i960 %r6 to i1024
%r8 = bitcast i64* %r3 to i960*
%r9 = load i960, i960* %r8
%r10 = zext i960 %r9 to i1024
%r11 = add i1024 %r7, %r10
%r12 = trunc i1024 %r11 to i960
%r13 = bitcast i64* %r1 to i960*
store i960 %r12, i960* %r13
%r14 = lshr i1024 %r11, 960
%r15 = trunc i1024 %r14 to i64
ret i64 %r15
}
define i64 @mclb_sub15(i64* noalias %r1, i64* noalias %r2, i64* noalias %r3)
{
%r5 = bitcast i64* %r2 to i960*
%r6 = load i960, i960* %r5
%r7 = zext i960 %r6 to i1024
%r8 = bitcast i64* %r3 to i960*
%r9 = load i960, i960* %r8
%r10 = zext i960 %r9 to i1024
%r11 = sub i1024 %r7, %r10
%r12 = trunc i1024 %r11 to i960
%r13 = bitcast i64* %r1 to i960*
store i960 %r12, i960* %r13
%r14 = lshr i1024 %r11, 960
%r15 = trunc i1024 %r14 to i64
%r16 = and i64 %r15, 1
ret i64 %r16
}
define void @mclb_addNF15(i64* noalias %r1, i64* noalias %r2, i64* noalias %r3)
{
%r4 = bitcast i64* %r2 to i960*
%r5 = load i960, i960* %r4
%r6 = bitcast i64* %r3 to i960*
%r7 = load i960, i960* %r6
%r8 = add i960 %r5, %r7
%r9 = bitcast i64* %r1 to i960*
store i960 %r8, i960* %r9
ret void
}
define i64 @mclb_subNF15(i64* noalias %r1, i64* noalias %r2, i64* noalias %r3)
{
%r5 = bitcast i64* %r2 to i960*
%r6 = load i960, i960* %r5
%r7 = bitcast i64* %r3 to i960*
%r8 = load i960, i960* %r7
%r9 = sub i960 %r6, %r8
%r10 = bitcast i64* %r1 to i960*
store i960 %r9, i960* %r10
%r11 = lshr i960 %r9, 959
%r12 = trunc i960 %r11 to i64
%r13 = and i64 %r12, 1
ret i64 %r13
}
define i64 @mclb_add16(i64* noalias %r1, i64* noalias %r2, i64* noalias %r3)
{
%r5 = bitcast i64* %r2 to i1024*
%r6 = load i1024, i1024* %r5
%r7 = zext i1024 %r6 to i1088
%r8 = bitcast i64* %r3 to i1024*
%r9 = load i1024, i1024* %r8
%r10 = zext i1024 %r9 to i1088
%r11 = add i1088 %r7, %r10
%r12 = trunc i1088 %r11 to i1024
%r13 = bitcast i64* %r1 to i1024*
store i1024 %r12, i1024* %r13
%r14 = lshr i1088 %r11, 1024
%r15 = trunc i1088 %r14 to i64
ret i64 %r15
}
define i64 @mclb_sub16(i64* noalias %r1, i64* noalias %r2, i64* noalias %r3)
{
%r5 = bitcast i64* %r2 to i1024*
%r6 = load i1024, i1024* %r5
%r7 = zext i1024 %r6 to i1088
%r8 = bitcast i64* %r3 to i1024*
%r9 = load i1024, i1024* %r8
%r10 = zext i1024 %r9 to i1088
%r11 = sub i1088 %r7, %r10
%r12 = trunc i1088 %r11 to i1024
%r13 = bitcast i64* %r1 to i1024*
store i1024 %r12, i1024* %r13
%r14 = lshr i1088 %r11, 1024
%r15 = trunc i1088 %r14 to i64
%r16 = and i64 %r15, 1
ret i64 %r16
}
define void @mclb_addNF16(i64* noalias %r1, i64* noalias %r2, i64* noalias %r3)
{
%r4 = bitcast i64* %r2 to i1024*
%r5 = load i1024, i1024* %r4
%r6 = bitcast i64* %r3 to i1024*
%r7 = load i1024, i1024* %r6
%r8 = add i1024 %r5, %r7
%r9 = bitcast i64* %r1 to i1024*
store i1024 %r8, i1024* %r9
ret void
}
define i64 @mclb_subNF16(i64* noalias %r1, i64* noalias %r2, i64* noalias %r3)
{
%r5 = bitcast i64* %r2 to i1024*
%r6 = load i1024, i1024* %r5
%r7 = bitcast i64* %r3 to i1024*
%r8 = load i1024, i1024* %r7
%r9 = sub i1024 %r6, %r8
%r10 = bitcast i64* %r1 to i1024*
store i1024 %r9, i1024* %r10
%r11 = lshr i1024 %r9, 1023
%r12 = trunc i1024 %r11 to i64
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
define void @mclb_mul7(i64* noalias %r1, i64* noalias %r2, i64* noalias %r3)
{
%r4 = load i64, i64* %r3
%r5 = call i512 @mulUnit_inner448(i64* %r2, i64 %r4)
%r6 = trunc i512 %r5 to i64
store i64 %r6, i64* %r1
%r7 = lshr i512 %r5, 64
%r8 = getelementptr i64, i64* %r3, i32 1
%r9 = load i64, i64* %r8
%r10 = call i512 @mulUnit_inner448(i64* %r2, i64 %r9)
%r11 = add i512 %r7, %r10
%r12 = trunc i512 %r11 to i64
%r13 = getelementptr i64, i64* %r1, i32 1
store i64 %r12, i64* %r13
%r14 = lshr i512 %r11, 64
%r15 = getelementptr i64, i64* %r3, i32 2
%r16 = load i64, i64* %r15
%r17 = call i512 @mulUnit_inner448(i64* %r2, i64 %r16)
%r18 = add i512 %r14, %r17
%r19 = trunc i512 %r18 to i64
%r20 = getelementptr i64, i64* %r1, i32 2
store i64 %r19, i64* %r20
%r21 = lshr i512 %r18, 64
%r22 = getelementptr i64, i64* %r3, i32 3
%r23 = load i64, i64* %r22
%r24 = call i512 @mulUnit_inner448(i64* %r2, i64 %r23)
%r25 = add i512 %r21, %r24
%r26 = trunc i512 %r25 to i64
%r27 = getelementptr i64, i64* %r1, i32 3
store i64 %r26, i64* %r27
%r28 = lshr i512 %r25, 64
%r29 = getelementptr i64, i64* %r3, i32 4
%r30 = load i64, i64* %r29
%r31 = call i512 @mulUnit_inner448(i64* %r2, i64 %r30)
%r32 = add i512 %r28, %r31
%r33 = trunc i512 %r32 to i64
%r34 = getelementptr i64, i64* %r1, i32 4
store i64 %r33, i64* %r34
%r35 = lshr i512 %r32, 64
%r36 = getelementptr i64, i64* %r3, i32 5
%r37 = load i64, i64* %r36
%r38 = call i512 @mulUnit_inner448(i64* %r2, i64 %r37)
%r39 = add i512 %r35, %r38
%r40 = trunc i512 %r39 to i64
%r41 = getelementptr i64, i64* %r1, i32 5
store i64 %r40, i64* %r41
%r42 = lshr i512 %r39, 64
%r43 = getelementptr i64, i64* %r3, i32 6
%r44 = load i64, i64* %r43
%r45 = call i512 @mulUnit_inner448(i64* %r2, i64 %r44)
%r46 = add i512 %r42, %r45
%r47 = getelementptr i64, i64* %r1, i32 6
%r48 = bitcast i64* %r47 to i512*
store i512 %r46, i512* %r48
ret void
}
define void @mclb_sqr7(i64* noalias %r1, i64* noalias %r2)
{
%r3 = load i64, i64* %r2
%r4 = call i128 @mul64x64L(i64 %r3, i64 %r3)
%r5 = trunc i128 %r4 to i64
store i64 %r5, i64* %r1
%r6 = lshr i128 %r4, 64
%r7 = getelementptr i64, i64* %r2, i32 6
%r8 = load i64, i64* %r7
%r9 = call i128 @mul64x64L(i64 %r3, i64 %r8)
%r10 = load i64, i64* %r2
%r11 = getelementptr i64, i64* %r2, i32 5
%r12 = load i64, i64* %r11
%r13 = call i128 @mul64x64L(i64 %r10, i64 %r12)
%r14 = getelementptr i64, i64* %r2, i32 1
%r15 = load i64, i64* %r14
%r16 = getelementptr i64, i64* %r2, i32 6
%r17 = load i64, i64* %r16
%r18 = call i128 @mul64x64L(i64 %r15, i64 %r17)
%r19 = zext i128 %r13 to i256
%r20 = zext i128 %r18 to i256
%r21 = shl i256 %r20, 128
%r22 = or i256 %r19, %r21
%r23 = zext i128 %r9 to i256
%r24 = shl i256 %r23, 64
%r25 = add i256 %r24, %r22
%r26 = load i64, i64* %r2
%r27 = getelementptr i64, i64* %r2, i32 4
%r28 = load i64, i64* %r27
%r29 = call i128 @mul64x64L(i64 %r26, i64 %r28)
%r30 = getelementptr i64, i64* %r2, i32 1
%r31 = load i64, i64* %r30
%r32 = getelementptr i64, i64* %r2, i32 5
%r33 = load i64, i64* %r32
%r34 = call i128 @mul64x64L(i64 %r31, i64 %r33)
%r35 = zext i128 %r29 to i256
%r36 = zext i128 %r34 to i256
%r37 = shl i256 %r36, 128
%r38 = or i256 %r35, %r37
%r39 = getelementptr i64, i64* %r2, i32 2
%r40 = load i64, i64* %r39
%r41 = getelementptr i64, i64* %r2, i32 6
%r42 = load i64, i64* %r41
%r43 = call i128 @mul64x64L(i64 %r40, i64 %r42)
%r44 = zext i256 %r38 to i384
%r45 = zext i128 %r43 to i384
%r46 = shl i384 %r45, 256
%r47 = or i384 %r44, %r46
%r48 = zext i256 %r25 to i384
%r49 = shl i384 %r48, 64
%r50 = add i384 %r49, %r47
%r51 = load i64, i64* %r2
%r52 = getelementptr i64, i64* %r2, i32 3
%r53 = load i64, i64* %r52
%r54 = call i128 @mul64x64L(i64 %r51, i64 %r53)
%r55 = getelementptr i64, i64* %r2, i32 1
%r56 = load i64, i64* %r55
%r57 = getelementptr i64, i64* %r2, i32 4
%r58 = load i64, i64* %r57
%r59 = call i128 @mul64x64L(i64 %r56, i64 %r58)
%r60 = zext i128 %r54 to i256
%r61 = zext i128 %r59 to i256
%r62 = shl i256 %r61, 128
%r63 = or i256 %r60, %r62
%r64 = getelementptr i64, i64* %r2, i32 2
%r65 = load i64, i64* %r64
%r66 = getelementptr i64, i64* %r2, i32 5
%r67 = load i64, i64* %r66
%r68 = call i128 @mul64x64L(i64 %r65, i64 %r67)
%r69 = zext i256 %r63 to i384
%r70 = zext i128 %r68 to i384
%r71 = shl i384 %r70, 256
%r72 = or i384 %r69, %r71
%r73 = getelementptr i64, i64* %r2, i32 3
%r74 = load i64, i64* %r73
%r75 = getelementptr i64, i64* %r2, i32 6
%r76 = load i64, i64* %r75
%r77 = call i128 @mul64x64L(i64 %r74, i64 %r76)
%r78 = zext i384 %r72 to i512
%r79 = zext i128 %r77 to i512
%r80 = shl i512 %r79, 384
%r81 = or i512 %r78, %r80
%r82 = zext i384 %r50 to i512
%r83 = shl i512 %r82, 64
%r84 = add i512 %r83, %r81
%r85 = load i64, i64* %r2
%r86 = getelementptr i64, i64* %r2, i32 2
%r87 = load i64, i64* %r86
%r88 = call i128 @mul64x64L(i64 %r85, i64 %r87)
%r89 = getelementptr i64, i64* %r2, i32 1
%r90 = load i64, i64* %r89
%r91 = getelementptr i64, i64* %r2, i32 3
%r92 = load i64, i64* %r91
%r93 = call i128 @mul64x64L(i64 %r90, i64 %r92)
%r94 = zext i128 %r88 to i256
%r95 = zext i128 %r93 to i256
%r96 = shl i256 %r95, 128
%r97 = or i256 %r94, %r96
%r98 = getelementptr i64, i64* %r2, i32 2
%r99 = load i64, i64* %r98
%r100 = getelementptr i64, i64* %r2, i32 4
%r101 = load i64, i64* %r100
%r102 = call i128 @mul64x64L(i64 %r99, i64 %r101)
%r103 = zext i256 %r97 to i384
%r104 = zext i128 %r102 to i384
%r105 = shl i384 %r104, 256
%r106 = or i384 %r103, %r105
%r107 = getelementptr i64, i64* %r2, i32 3
%r108 = load i64, i64* %r107
%r109 = getelementptr i64, i64* %r2, i32 5
%r110 = load i64, i64* %r109
%r111 = call i128 @mul64x64L(i64 %r108, i64 %r110)
%r112 = zext i384 %r106 to i512
%r113 = zext i128 %r111 to i512
%r114 = shl i512 %r113, 384
%r115 = or i512 %r112, %r114
%r116 = getelementptr i64, i64* %r2, i32 4
%r117 = load i64, i64* %r116
%r118 = getelementptr i64, i64* %r2, i32 6
%r119 = load i64, i64* %r118
%r120 = call i128 @mul64x64L(i64 %r117, i64 %r119)
%r121 = zext i512 %r115 to i640
%r122 = zext i128 %r120 to i640
%r123 = shl i640 %r122, 512
%r124 = or i640 %r121, %r123
%r125 = zext i512 %r84 to i640
%r126 = shl i640 %r125, 64
%r127 = add i640 %r126, %r124
%r128 = load i64, i64* %r2
%r129 = getelementptr i64, i64* %r2, i32 1
%r130 = load i64, i64* %r129
%r131 = call i128 @mul64x64L(i64 %r128, i64 %r130)
%r132 = getelementptr i64, i64* %r2, i32 1
%r133 = load i64, i64* %r132
%r134 = getelementptr i64, i64* %r2, i32 2
%r135 = load i64, i64* %r134
%r136 = call i128 @mul64x64L(i64 %r133, i64 %r135)
%r137 = zext i128 %r131 to i256
%r138 = zext i128 %r136 to i256
%r139 = shl i256 %r138, 128
%r140 = or i256 %r137, %r139
%r141 = getelementptr i64, i64* %r2, i32 2
%r142 = load i64, i64* %r141
%r143 = getelementptr i64, i64* %r2, i32 3
%r144 = load i64, i64* %r143
%r145 = call i128 @mul64x64L(i64 %r142, i64 %r144)
%r146 = zext i256 %r140 to i384
%r147 = zext i128 %r145 to i384
%r148 = shl i384 %r147, 256
%r149 = or i384 %r146, %r148
%r150 = getelementptr i64, i64* %r2, i32 3
%r151 = load i64, i64* %r150
%r152 = getelementptr i64, i64* %r2, i32 4
%r153 = load i64, i64* %r152
%r154 = call i128 @mul64x64L(i64 %r151, i64 %r153)
%r155 = zext i384 %r149 to i512
%r156 = zext i128 %r154 to i512
%r157 = shl i512 %r156, 384
%r158 = or i512 %r155, %r157
%r159 = getelementptr i64, i64* %r2, i32 4
%r160 = load i64, i64* %r159
%r161 = getelementptr i64, i64* %r2, i32 5
%r162 = load i64, i64* %r161
%r163 = call i128 @mul64x64L(i64 %r160, i64 %r162)
%r164 = zext i512 %r158 to i640
%r165 = zext i128 %r163 to i640
%r166 = shl i640 %r165, 512
%r167 = or i640 %r164, %r166
%r168 = getelementptr i64, i64* %r2, i32 5
%r169 = load i64, i64* %r168
%r170 = getelementptr i64, i64* %r2, i32 6
%r171 = load i64, i64* %r170
%r172 = call i128 @mul64x64L(i64 %r169, i64 %r171)
%r173 = zext i640 %r167 to i768
%r174 = zext i128 %r172 to i768
%r175 = shl i768 %r174, 640
%r176 = or i768 %r173, %r175
%r177 = zext i640 %r127 to i768
%r178 = shl i768 %r177, 64
%r179 = add i768 %r178, %r176
%r180 = zext i128 %r6 to i832
%r181 = getelementptr i64, i64* %r2, i32 1
%r182 = load i64, i64* %r181
%r183 = call i128 @mul64x64L(i64 %r182, i64 %r182)
%r184 = zext i128 %r183 to i832
%r185 = shl i832 %r184, 64
%r186 = or i832 %r180, %r185
%r187 = getelementptr i64, i64* %r2, i32 2
%r188 = load i64, i64* %r187
%r189 = call i128 @mul64x64L(i64 %r188, i64 %r188)
%r190 = zext i128 %r189 to i832
%r191 = shl i832 %r190, 192
%r192 = or i832 %r186, %r191
%r193 = getelementptr i64, i64* %r2, i32 3
%r194 = load i64, i64* %r193
%r195 = call i128 @mul64x64L(i64 %r194, i64 %r194)
%r196 = zext i128 %r195 to i832
%r197 = shl i832 %r196, 320
%r198 = or i832 %r192, %r197
%r199 = getelementptr i64, i64* %r2, i32 4
%r200 = load i64, i64* %r199
%r201 = call i128 @mul64x64L(i64 %r200, i64 %r200)
%r202 = zext i128 %r201 to i832
%r203 = shl i832 %r202, 448
%r204 = or i832 %r198, %r203
%r205 = getelementptr i64, i64* %r2, i32 5
%r206 = load i64, i64* %r205
%r207 = call i128 @mul64x64L(i64 %r206, i64 %r206)
%r208 = zext i128 %r207 to i832
%r209 = shl i832 %r208, 576
%r210 = or i832 %r204, %r209
%r211 = getelementptr i64, i64* %r2, i32 6
%r212 = load i64, i64* %r211
%r213 = call i128 @mul64x64L(i64 %r212, i64 %r212)
%r214 = zext i128 %r213 to i832
%r215 = shl i832 %r214, 704
%r216 = or i832 %r210, %r215
%r217 = zext i768 %r179 to i832
%r218 = add i832 %r217, %r217
%r219 = add i832 %r216, %r218
%r220 = getelementptr i64, i64* %r1, i32 1
%r221 = bitcast i64* %r220 to i832*
store i832 %r219, i832* %r221
ret void
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
define void @mclb_mul8(i64* noalias %r1, i64* noalias %r2, i64* noalias %r3)
{
%r4 = load i64, i64* %r3
%r5 = call i576 @mulUnit_inner512(i64* %r2, i64 %r4)
%r6 = trunc i576 %r5 to i64
store i64 %r6, i64* %r1
%r7 = lshr i576 %r5, 64
%r8 = getelementptr i64, i64* %r3, i32 1
%r9 = load i64, i64* %r8
%r10 = call i576 @mulUnit_inner512(i64* %r2, i64 %r9)
%r11 = add i576 %r7, %r10
%r12 = trunc i576 %r11 to i64
%r13 = getelementptr i64, i64* %r1, i32 1
store i64 %r12, i64* %r13
%r14 = lshr i576 %r11, 64
%r15 = getelementptr i64, i64* %r3, i32 2
%r16 = load i64, i64* %r15
%r17 = call i576 @mulUnit_inner512(i64* %r2, i64 %r16)
%r18 = add i576 %r14, %r17
%r19 = trunc i576 %r18 to i64
%r20 = getelementptr i64, i64* %r1, i32 2
store i64 %r19, i64* %r20
%r21 = lshr i576 %r18, 64
%r22 = getelementptr i64, i64* %r3, i32 3
%r23 = load i64, i64* %r22
%r24 = call i576 @mulUnit_inner512(i64* %r2, i64 %r23)
%r25 = add i576 %r21, %r24
%r26 = trunc i576 %r25 to i64
%r27 = getelementptr i64, i64* %r1, i32 3
store i64 %r26, i64* %r27
%r28 = lshr i576 %r25, 64
%r29 = getelementptr i64, i64* %r3, i32 4
%r30 = load i64, i64* %r29
%r31 = call i576 @mulUnit_inner512(i64* %r2, i64 %r30)
%r32 = add i576 %r28, %r31
%r33 = trunc i576 %r32 to i64
%r34 = getelementptr i64, i64* %r1, i32 4
store i64 %r33, i64* %r34
%r35 = lshr i576 %r32, 64
%r36 = getelementptr i64, i64* %r3, i32 5
%r37 = load i64, i64* %r36
%r38 = call i576 @mulUnit_inner512(i64* %r2, i64 %r37)
%r39 = add i576 %r35, %r38
%r40 = trunc i576 %r39 to i64
%r41 = getelementptr i64, i64* %r1, i32 5
store i64 %r40, i64* %r41
%r42 = lshr i576 %r39, 64
%r43 = getelementptr i64, i64* %r3, i32 6
%r44 = load i64, i64* %r43
%r45 = call i576 @mulUnit_inner512(i64* %r2, i64 %r44)
%r46 = add i576 %r42, %r45
%r47 = trunc i576 %r46 to i64
%r48 = getelementptr i64, i64* %r1, i32 6
store i64 %r47, i64* %r48
%r49 = lshr i576 %r46, 64
%r50 = getelementptr i64, i64* %r3, i32 7
%r51 = load i64, i64* %r50
%r52 = call i576 @mulUnit_inner512(i64* %r2, i64 %r51)
%r53 = add i576 %r49, %r52
%r54 = getelementptr i64, i64* %r1, i32 7
%r55 = bitcast i64* %r54 to i576*
store i576 %r53, i576* %r55
ret void
}
define void @mclb_sqr8(i64* noalias %r1, i64* noalias %r2)
{
%r3 = load i64, i64* %r2
%r4 = call i128 @mul64x64L(i64 %r3, i64 %r3)
%r5 = trunc i128 %r4 to i64
store i64 %r5, i64* %r1
%r6 = lshr i128 %r4, 64
%r7 = getelementptr i64, i64* %r2, i32 7
%r8 = load i64, i64* %r7
%r9 = call i128 @mul64x64L(i64 %r3, i64 %r8)
%r10 = load i64, i64* %r2
%r11 = getelementptr i64, i64* %r2, i32 6
%r12 = load i64, i64* %r11
%r13 = call i128 @mul64x64L(i64 %r10, i64 %r12)
%r14 = getelementptr i64, i64* %r2, i32 1
%r15 = load i64, i64* %r14
%r16 = getelementptr i64, i64* %r2, i32 7
%r17 = load i64, i64* %r16
%r18 = call i128 @mul64x64L(i64 %r15, i64 %r17)
%r19 = zext i128 %r13 to i256
%r20 = zext i128 %r18 to i256
%r21 = shl i256 %r20, 128
%r22 = or i256 %r19, %r21
%r23 = zext i128 %r9 to i256
%r24 = shl i256 %r23, 64
%r25 = add i256 %r24, %r22
%r26 = load i64, i64* %r2
%r27 = getelementptr i64, i64* %r2, i32 5
%r28 = load i64, i64* %r27
%r29 = call i128 @mul64x64L(i64 %r26, i64 %r28)
%r30 = getelementptr i64, i64* %r2, i32 1
%r31 = load i64, i64* %r30
%r32 = getelementptr i64, i64* %r2, i32 6
%r33 = load i64, i64* %r32
%r34 = call i128 @mul64x64L(i64 %r31, i64 %r33)
%r35 = zext i128 %r29 to i256
%r36 = zext i128 %r34 to i256
%r37 = shl i256 %r36, 128
%r38 = or i256 %r35, %r37
%r39 = getelementptr i64, i64* %r2, i32 2
%r40 = load i64, i64* %r39
%r41 = getelementptr i64, i64* %r2, i32 7
%r42 = load i64, i64* %r41
%r43 = call i128 @mul64x64L(i64 %r40, i64 %r42)
%r44 = zext i256 %r38 to i384
%r45 = zext i128 %r43 to i384
%r46 = shl i384 %r45, 256
%r47 = or i384 %r44, %r46
%r48 = zext i256 %r25 to i384
%r49 = shl i384 %r48, 64
%r50 = add i384 %r49, %r47
%r51 = load i64, i64* %r2
%r52 = getelementptr i64, i64* %r2, i32 4
%r53 = load i64, i64* %r52
%r54 = call i128 @mul64x64L(i64 %r51, i64 %r53)
%r55 = getelementptr i64, i64* %r2, i32 1
%r56 = load i64, i64* %r55
%r57 = getelementptr i64, i64* %r2, i32 5
%r58 = load i64, i64* %r57
%r59 = call i128 @mul64x64L(i64 %r56, i64 %r58)
%r60 = zext i128 %r54 to i256
%r61 = zext i128 %r59 to i256
%r62 = shl i256 %r61, 128
%r63 = or i256 %r60, %r62
%r64 = getelementptr i64, i64* %r2, i32 2
%r65 = load i64, i64* %r64
%r66 = getelementptr i64, i64* %r2, i32 6
%r67 = load i64, i64* %r66
%r68 = call i128 @mul64x64L(i64 %r65, i64 %r67)
%r69 = zext i256 %r63 to i384
%r70 = zext i128 %r68 to i384
%r71 = shl i384 %r70, 256
%r72 = or i384 %r69, %r71
%r73 = getelementptr i64, i64* %r2, i32 3
%r74 = load i64, i64* %r73
%r75 = getelementptr i64, i64* %r2, i32 7
%r76 = load i64, i64* %r75
%r77 = call i128 @mul64x64L(i64 %r74, i64 %r76)
%r78 = zext i384 %r72 to i512
%r79 = zext i128 %r77 to i512
%r80 = shl i512 %r79, 384
%r81 = or i512 %r78, %r80
%r82 = zext i384 %r50 to i512
%r83 = shl i512 %r82, 64
%r84 = add i512 %r83, %r81
%r85 = load i64, i64* %r2
%r86 = getelementptr i64, i64* %r2, i32 3
%r87 = load i64, i64* %r86
%r88 = call i128 @mul64x64L(i64 %r85, i64 %r87)
%r89 = getelementptr i64, i64* %r2, i32 1
%r90 = load i64, i64* %r89
%r91 = getelementptr i64, i64* %r2, i32 4
%r92 = load i64, i64* %r91
%r93 = call i128 @mul64x64L(i64 %r90, i64 %r92)
%r94 = zext i128 %r88 to i256
%r95 = zext i128 %r93 to i256
%r96 = shl i256 %r95, 128
%r97 = or i256 %r94, %r96
%r98 = getelementptr i64, i64* %r2, i32 2
%r99 = load i64, i64* %r98
%r100 = getelementptr i64, i64* %r2, i32 5
%r101 = load i64, i64* %r100
%r102 = call i128 @mul64x64L(i64 %r99, i64 %r101)
%r103 = zext i256 %r97 to i384
%r104 = zext i128 %r102 to i384
%r105 = shl i384 %r104, 256
%r106 = or i384 %r103, %r105
%r107 = getelementptr i64, i64* %r2, i32 3
%r108 = load i64, i64* %r107
%r109 = getelementptr i64, i64* %r2, i32 6
%r110 = load i64, i64* %r109
%r111 = call i128 @mul64x64L(i64 %r108, i64 %r110)
%r112 = zext i384 %r106 to i512
%r113 = zext i128 %r111 to i512
%r114 = shl i512 %r113, 384
%r115 = or i512 %r112, %r114
%r116 = getelementptr i64, i64* %r2, i32 4
%r117 = load i64, i64* %r116
%r118 = getelementptr i64, i64* %r2, i32 7
%r119 = load i64, i64* %r118
%r120 = call i128 @mul64x64L(i64 %r117, i64 %r119)
%r121 = zext i512 %r115 to i640
%r122 = zext i128 %r120 to i640
%r123 = shl i640 %r122, 512
%r124 = or i640 %r121, %r123
%r125 = zext i512 %r84 to i640
%r126 = shl i640 %r125, 64
%r127 = add i640 %r126, %r124
%r128 = load i64, i64* %r2
%r129 = getelementptr i64, i64* %r2, i32 2
%r130 = load i64, i64* %r129
%r131 = call i128 @mul64x64L(i64 %r128, i64 %r130)
%r132 = getelementptr i64, i64* %r2, i32 1
%r133 = load i64, i64* %r132
%r134 = getelementptr i64, i64* %r2, i32 3
%r135 = load i64, i64* %r134
%r136 = call i128 @mul64x64L(i64 %r133, i64 %r135)
%r137 = zext i128 %r131 to i256
%r138 = zext i128 %r136 to i256
%r139 = shl i256 %r138, 128
%r140 = or i256 %r137, %r139
%r141 = getelementptr i64, i64* %r2, i32 2
%r142 = load i64, i64* %r141
%r143 = getelementptr i64, i64* %r2, i32 4
%r144 = load i64, i64* %r143
%r145 = call i128 @mul64x64L(i64 %r142, i64 %r144)
%r146 = zext i256 %r140 to i384
%r147 = zext i128 %r145 to i384
%r148 = shl i384 %r147, 256
%r149 = or i384 %r146, %r148
%r150 = getelementptr i64, i64* %r2, i32 3
%r151 = load i64, i64* %r150
%r152 = getelementptr i64, i64* %r2, i32 5
%r153 = load i64, i64* %r152
%r154 = call i128 @mul64x64L(i64 %r151, i64 %r153)
%r155 = zext i384 %r149 to i512
%r156 = zext i128 %r154 to i512
%r157 = shl i512 %r156, 384
%r158 = or i512 %r155, %r157
%r159 = getelementptr i64, i64* %r2, i32 4
%r160 = load i64, i64* %r159
%r161 = getelementptr i64, i64* %r2, i32 6
%r162 = load i64, i64* %r161
%r163 = call i128 @mul64x64L(i64 %r160, i64 %r162)
%r164 = zext i512 %r158 to i640
%r165 = zext i128 %r163 to i640
%r166 = shl i640 %r165, 512
%r167 = or i640 %r164, %r166
%r168 = getelementptr i64, i64* %r2, i32 5
%r169 = load i64, i64* %r168
%r170 = getelementptr i64, i64* %r2, i32 7
%r171 = load i64, i64* %r170
%r172 = call i128 @mul64x64L(i64 %r169, i64 %r171)
%r173 = zext i640 %r167 to i768
%r174 = zext i128 %r172 to i768
%r175 = shl i768 %r174, 640
%r176 = or i768 %r173, %r175
%r177 = zext i640 %r127 to i768
%r178 = shl i768 %r177, 64
%r179 = add i768 %r178, %r176
%r180 = load i64, i64* %r2
%r181 = getelementptr i64, i64* %r2, i32 1
%r182 = load i64, i64* %r181
%r183 = call i128 @mul64x64L(i64 %r180, i64 %r182)
%r184 = getelementptr i64, i64* %r2, i32 1
%r185 = load i64, i64* %r184
%r186 = getelementptr i64, i64* %r2, i32 2
%r187 = load i64, i64* %r186
%r188 = call i128 @mul64x64L(i64 %r185, i64 %r187)
%r189 = zext i128 %r183 to i256
%r190 = zext i128 %r188 to i256
%r191 = shl i256 %r190, 128
%r192 = or i256 %r189, %r191
%r193 = getelementptr i64, i64* %r2, i32 2
%r194 = load i64, i64* %r193
%r195 = getelementptr i64, i64* %r2, i32 3
%r196 = load i64, i64* %r195
%r197 = call i128 @mul64x64L(i64 %r194, i64 %r196)
%r198 = zext i256 %r192 to i384
%r199 = zext i128 %r197 to i384
%r200 = shl i384 %r199, 256
%r201 = or i384 %r198, %r200
%r202 = getelementptr i64, i64* %r2, i32 3
%r203 = load i64, i64* %r202
%r204 = getelementptr i64, i64* %r2, i32 4
%r205 = load i64, i64* %r204
%r206 = call i128 @mul64x64L(i64 %r203, i64 %r205)
%r207 = zext i384 %r201 to i512
%r208 = zext i128 %r206 to i512
%r209 = shl i512 %r208, 384
%r210 = or i512 %r207, %r209
%r211 = getelementptr i64, i64* %r2, i32 4
%r212 = load i64, i64* %r211
%r213 = getelementptr i64, i64* %r2, i32 5
%r214 = load i64, i64* %r213
%r215 = call i128 @mul64x64L(i64 %r212, i64 %r214)
%r216 = zext i512 %r210 to i640
%r217 = zext i128 %r215 to i640
%r218 = shl i640 %r217, 512
%r219 = or i640 %r216, %r218
%r220 = getelementptr i64, i64* %r2, i32 5
%r221 = load i64, i64* %r220
%r222 = getelementptr i64, i64* %r2, i32 6
%r223 = load i64, i64* %r222
%r224 = call i128 @mul64x64L(i64 %r221, i64 %r223)
%r225 = zext i640 %r219 to i768
%r226 = zext i128 %r224 to i768
%r227 = shl i768 %r226, 640
%r228 = or i768 %r225, %r227
%r229 = getelementptr i64, i64* %r2, i32 6
%r230 = load i64, i64* %r229
%r231 = getelementptr i64, i64* %r2, i32 7
%r232 = load i64, i64* %r231
%r233 = call i128 @mul64x64L(i64 %r230, i64 %r232)
%r234 = zext i768 %r228 to i896
%r235 = zext i128 %r233 to i896
%r236 = shl i896 %r235, 768
%r237 = or i896 %r234, %r236
%r238 = zext i768 %r179 to i896
%r239 = shl i896 %r238, 64
%r240 = add i896 %r239, %r237
%r241 = zext i128 %r6 to i960
%r242 = getelementptr i64, i64* %r2, i32 1
%r243 = load i64, i64* %r242
%r244 = call i128 @mul64x64L(i64 %r243, i64 %r243)
%r245 = zext i128 %r244 to i960
%r246 = shl i960 %r245, 64
%r247 = or i960 %r241, %r246
%r248 = getelementptr i64, i64* %r2, i32 2
%r249 = load i64, i64* %r248
%r250 = call i128 @mul64x64L(i64 %r249, i64 %r249)
%r251 = zext i128 %r250 to i960
%r252 = shl i960 %r251, 192
%r253 = or i960 %r247, %r252
%r254 = getelementptr i64, i64* %r2, i32 3
%r255 = load i64, i64* %r254
%r256 = call i128 @mul64x64L(i64 %r255, i64 %r255)
%r257 = zext i128 %r256 to i960
%r258 = shl i960 %r257, 320
%r259 = or i960 %r253, %r258
%r260 = getelementptr i64, i64* %r2, i32 4
%r261 = load i64, i64* %r260
%r262 = call i128 @mul64x64L(i64 %r261, i64 %r261)
%r263 = zext i128 %r262 to i960
%r264 = shl i960 %r263, 448
%r265 = or i960 %r259, %r264
%r266 = getelementptr i64, i64* %r2, i32 5
%r267 = load i64, i64* %r266
%r268 = call i128 @mul64x64L(i64 %r267, i64 %r267)
%r269 = zext i128 %r268 to i960
%r270 = shl i960 %r269, 576
%r271 = or i960 %r265, %r270
%r272 = getelementptr i64, i64* %r2, i32 6
%r273 = load i64, i64* %r272
%r274 = call i128 @mul64x64L(i64 %r273, i64 %r273)
%r275 = zext i128 %r274 to i960
%r276 = shl i960 %r275, 704
%r277 = or i960 %r271, %r276
%r278 = getelementptr i64, i64* %r2, i32 7
%r279 = load i64, i64* %r278
%r280 = call i128 @mul64x64L(i64 %r279, i64 %r279)
%r281 = zext i128 %r280 to i960
%r282 = shl i960 %r281, 832
%r283 = or i960 %r277, %r282
%r284 = zext i896 %r240 to i960
%r285 = add i960 %r284, %r284
%r286 = add i960 %r283, %r285
%r287 = getelementptr i64, i64* %r1, i32 1
%r288 = bitcast i64* %r287 to i960*
store i960 %r286, i960* %r288
ret void
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
define void @mclb_mul9(i64* noalias %r1, i64* noalias %r2, i64* noalias %r3)
{
%r4 = load i64, i64* %r3
%r5 = call i640 @mulUnit_inner576(i64* %r2, i64 %r4)
%r6 = trunc i640 %r5 to i64
store i64 %r6, i64* %r1
%r7 = lshr i640 %r5, 64
%r8 = getelementptr i64, i64* %r3, i32 1
%r9 = load i64, i64* %r8
%r10 = call i640 @mulUnit_inner576(i64* %r2, i64 %r9)
%r11 = add i640 %r7, %r10
%r12 = trunc i640 %r11 to i64
%r13 = getelementptr i64, i64* %r1, i32 1
store i64 %r12, i64* %r13
%r14 = lshr i640 %r11, 64
%r15 = getelementptr i64, i64* %r3, i32 2
%r16 = load i64, i64* %r15
%r17 = call i640 @mulUnit_inner576(i64* %r2, i64 %r16)
%r18 = add i640 %r14, %r17
%r19 = trunc i640 %r18 to i64
%r20 = getelementptr i64, i64* %r1, i32 2
store i64 %r19, i64* %r20
%r21 = lshr i640 %r18, 64
%r22 = getelementptr i64, i64* %r3, i32 3
%r23 = load i64, i64* %r22
%r24 = call i640 @mulUnit_inner576(i64* %r2, i64 %r23)
%r25 = add i640 %r21, %r24
%r26 = trunc i640 %r25 to i64
%r27 = getelementptr i64, i64* %r1, i32 3
store i64 %r26, i64* %r27
%r28 = lshr i640 %r25, 64
%r29 = getelementptr i64, i64* %r3, i32 4
%r30 = load i64, i64* %r29
%r31 = call i640 @mulUnit_inner576(i64* %r2, i64 %r30)
%r32 = add i640 %r28, %r31
%r33 = trunc i640 %r32 to i64
%r34 = getelementptr i64, i64* %r1, i32 4
store i64 %r33, i64* %r34
%r35 = lshr i640 %r32, 64
%r36 = getelementptr i64, i64* %r3, i32 5
%r37 = load i64, i64* %r36
%r38 = call i640 @mulUnit_inner576(i64* %r2, i64 %r37)
%r39 = add i640 %r35, %r38
%r40 = trunc i640 %r39 to i64
%r41 = getelementptr i64, i64* %r1, i32 5
store i64 %r40, i64* %r41
%r42 = lshr i640 %r39, 64
%r43 = getelementptr i64, i64* %r3, i32 6
%r44 = load i64, i64* %r43
%r45 = call i640 @mulUnit_inner576(i64* %r2, i64 %r44)
%r46 = add i640 %r42, %r45
%r47 = trunc i640 %r46 to i64
%r48 = getelementptr i64, i64* %r1, i32 6
store i64 %r47, i64* %r48
%r49 = lshr i640 %r46, 64
%r50 = getelementptr i64, i64* %r3, i32 7
%r51 = load i64, i64* %r50
%r52 = call i640 @mulUnit_inner576(i64* %r2, i64 %r51)
%r53 = add i640 %r49, %r52
%r54 = trunc i640 %r53 to i64
%r55 = getelementptr i64, i64* %r1, i32 7
store i64 %r54, i64* %r55
%r56 = lshr i640 %r53, 64
%r57 = getelementptr i64, i64* %r3, i32 8
%r58 = load i64, i64* %r57
%r59 = call i640 @mulUnit_inner576(i64* %r2, i64 %r58)
%r60 = add i640 %r56, %r59
%r61 = getelementptr i64, i64* %r1, i32 8
%r62 = bitcast i64* %r61 to i640*
store i640 %r60, i640* %r62
ret void
}
define void @mclb_sqr9(i64* noalias %r1, i64* noalias %r2)
{
%r3 = load i64, i64* %r2
%r4 = call i128 @mul64x64L(i64 %r3, i64 %r3)
%r5 = trunc i128 %r4 to i64
store i64 %r5, i64* %r1
%r6 = lshr i128 %r4, 64
%r7 = getelementptr i64, i64* %r2, i32 8
%r8 = load i64, i64* %r7
%r9 = call i128 @mul64x64L(i64 %r3, i64 %r8)
%r10 = load i64, i64* %r2
%r11 = getelementptr i64, i64* %r2, i32 7
%r12 = load i64, i64* %r11
%r13 = call i128 @mul64x64L(i64 %r10, i64 %r12)
%r14 = getelementptr i64, i64* %r2, i32 1
%r15 = load i64, i64* %r14
%r16 = getelementptr i64, i64* %r2, i32 8
%r17 = load i64, i64* %r16
%r18 = call i128 @mul64x64L(i64 %r15, i64 %r17)
%r19 = zext i128 %r13 to i256
%r20 = zext i128 %r18 to i256
%r21 = shl i256 %r20, 128
%r22 = or i256 %r19, %r21
%r23 = zext i128 %r9 to i256
%r24 = shl i256 %r23, 64
%r25 = add i256 %r24, %r22
%r26 = load i64, i64* %r2
%r27 = getelementptr i64, i64* %r2, i32 6
%r28 = load i64, i64* %r27
%r29 = call i128 @mul64x64L(i64 %r26, i64 %r28)
%r30 = getelementptr i64, i64* %r2, i32 1
%r31 = load i64, i64* %r30
%r32 = getelementptr i64, i64* %r2, i32 7
%r33 = load i64, i64* %r32
%r34 = call i128 @mul64x64L(i64 %r31, i64 %r33)
%r35 = zext i128 %r29 to i256
%r36 = zext i128 %r34 to i256
%r37 = shl i256 %r36, 128
%r38 = or i256 %r35, %r37
%r39 = getelementptr i64, i64* %r2, i32 2
%r40 = load i64, i64* %r39
%r41 = getelementptr i64, i64* %r2, i32 8
%r42 = load i64, i64* %r41
%r43 = call i128 @mul64x64L(i64 %r40, i64 %r42)
%r44 = zext i256 %r38 to i384
%r45 = zext i128 %r43 to i384
%r46 = shl i384 %r45, 256
%r47 = or i384 %r44, %r46
%r48 = zext i256 %r25 to i384
%r49 = shl i384 %r48, 64
%r50 = add i384 %r49, %r47
%r51 = load i64, i64* %r2
%r52 = getelementptr i64, i64* %r2, i32 5
%r53 = load i64, i64* %r52
%r54 = call i128 @mul64x64L(i64 %r51, i64 %r53)
%r55 = getelementptr i64, i64* %r2, i32 1
%r56 = load i64, i64* %r55
%r57 = getelementptr i64, i64* %r2, i32 6
%r58 = load i64, i64* %r57
%r59 = call i128 @mul64x64L(i64 %r56, i64 %r58)
%r60 = zext i128 %r54 to i256
%r61 = zext i128 %r59 to i256
%r62 = shl i256 %r61, 128
%r63 = or i256 %r60, %r62
%r64 = getelementptr i64, i64* %r2, i32 2
%r65 = load i64, i64* %r64
%r66 = getelementptr i64, i64* %r2, i32 7
%r67 = load i64, i64* %r66
%r68 = call i128 @mul64x64L(i64 %r65, i64 %r67)
%r69 = zext i256 %r63 to i384
%r70 = zext i128 %r68 to i384
%r71 = shl i384 %r70, 256
%r72 = or i384 %r69, %r71
%r73 = getelementptr i64, i64* %r2, i32 3
%r74 = load i64, i64* %r73
%r75 = getelementptr i64, i64* %r2, i32 8
%r76 = load i64, i64* %r75
%r77 = call i128 @mul64x64L(i64 %r74, i64 %r76)
%r78 = zext i384 %r72 to i512
%r79 = zext i128 %r77 to i512
%r80 = shl i512 %r79, 384
%r81 = or i512 %r78, %r80
%r82 = zext i384 %r50 to i512
%r83 = shl i512 %r82, 64
%r84 = add i512 %r83, %r81
%r85 = load i64, i64* %r2
%r86 = getelementptr i64, i64* %r2, i32 4
%r87 = load i64, i64* %r86
%r88 = call i128 @mul64x64L(i64 %r85, i64 %r87)
%r89 = getelementptr i64, i64* %r2, i32 1
%r90 = load i64, i64* %r89
%r91 = getelementptr i64, i64* %r2, i32 5
%r92 = load i64, i64* %r91
%r93 = call i128 @mul64x64L(i64 %r90, i64 %r92)
%r94 = zext i128 %r88 to i256
%r95 = zext i128 %r93 to i256
%r96 = shl i256 %r95, 128
%r97 = or i256 %r94, %r96
%r98 = getelementptr i64, i64* %r2, i32 2
%r99 = load i64, i64* %r98
%r100 = getelementptr i64, i64* %r2, i32 6
%r101 = load i64, i64* %r100
%r102 = call i128 @mul64x64L(i64 %r99, i64 %r101)
%r103 = zext i256 %r97 to i384
%r104 = zext i128 %r102 to i384
%r105 = shl i384 %r104, 256
%r106 = or i384 %r103, %r105
%r107 = getelementptr i64, i64* %r2, i32 3
%r108 = load i64, i64* %r107
%r109 = getelementptr i64, i64* %r2, i32 7
%r110 = load i64, i64* %r109
%r111 = call i128 @mul64x64L(i64 %r108, i64 %r110)
%r112 = zext i384 %r106 to i512
%r113 = zext i128 %r111 to i512
%r114 = shl i512 %r113, 384
%r115 = or i512 %r112, %r114
%r116 = getelementptr i64, i64* %r2, i32 4
%r117 = load i64, i64* %r116
%r118 = getelementptr i64, i64* %r2, i32 8
%r119 = load i64, i64* %r118
%r120 = call i128 @mul64x64L(i64 %r117, i64 %r119)
%r121 = zext i512 %r115 to i640
%r122 = zext i128 %r120 to i640
%r123 = shl i640 %r122, 512
%r124 = or i640 %r121, %r123
%r125 = zext i512 %r84 to i640
%r126 = shl i640 %r125, 64
%r127 = add i640 %r126, %r124
%r128 = load i64, i64* %r2
%r129 = getelementptr i64, i64* %r2, i32 3
%r130 = load i64, i64* %r129
%r131 = call i128 @mul64x64L(i64 %r128, i64 %r130)
%r132 = getelementptr i64, i64* %r2, i32 1
%r133 = load i64, i64* %r132
%r134 = getelementptr i64, i64* %r2, i32 4
%r135 = load i64, i64* %r134
%r136 = call i128 @mul64x64L(i64 %r133, i64 %r135)
%r137 = zext i128 %r131 to i256
%r138 = zext i128 %r136 to i256
%r139 = shl i256 %r138, 128
%r140 = or i256 %r137, %r139
%r141 = getelementptr i64, i64* %r2, i32 2
%r142 = load i64, i64* %r141
%r143 = getelementptr i64, i64* %r2, i32 5
%r144 = load i64, i64* %r143
%r145 = call i128 @mul64x64L(i64 %r142, i64 %r144)
%r146 = zext i256 %r140 to i384
%r147 = zext i128 %r145 to i384
%r148 = shl i384 %r147, 256
%r149 = or i384 %r146, %r148
%r150 = getelementptr i64, i64* %r2, i32 3
%r151 = load i64, i64* %r150
%r152 = getelementptr i64, i64* %r2, i32 6
%r153 = load i64, i64* %r152
%r154 = call i128 @mul64x64L(i64 %r151, i64 %r153)
%r155 = zext i384 %r149 to i512
%r156 = zext i128 %r154 to i512
%r157 = shl i512 %r156, 384
%r158 = or i512 %r155, %r157
%r159 = getelementptr i64, i64* %r2, i32 4
%r160 = load i64, i64* %r159
%r161 = getelementptr i64, i64* %r2, i32 7
%r162 = load i64, i64* %r161
%r163 = call i128 @mul64x64L(i64 %r160, i64 %r162)
%r164 = zext i512 %r158 to i640
%r165 = zext i128 %r163 to i640
%r166 = shl i640 %r165, 512
%r167 = or i640 %r164, %r166
%r168 = getelementptr i64, i64* %r2, i32 5
%r169 = load i64, i64* %r168
%r170 = getelementptr i64, i64* %r2, i32 8
%r171 = load i64, i64* %r170
%r172 = call i128 @mul64x64L(i64 %r169, i64 %r171)
%r173 = zext i640 %r167 to i768
%r174 = zext i128 %r172 to i768
%r175 = shl i768 %r174, 640
%r176 = or i768 %r173, %r175
%r177 = zext i640 %r127 to i768
%r178 = shl i768 %r177, 64
%r179 = add i768 %r178, %r176
%r180 = load i64, i64* %r2
%r181 = getelementptr i64, i64* %r2, i32 2
%r182 = load i64, i64* %r181
%r183 = call i128 @mul64x64L(i64 %r180, i64 %r182)
%r184 = getelementptr i64, i64* %r2, i32 1
%r185 = load i64, i64* %r184
%r186 = getelementptr i64, i64* %r2, i32 3
%r187 = load i64, i64* %r186
%r188 = call i128 @mul64x64L(i64 %r185, i64 %r187)
%r189 = zext i128 %r183 to i256
%r190 = zext i128 %r188 to i256
%r191 = shl i256 %r190, 128
%r192 = or i256 %r189, %r191
%r193 = getelementptr i64, i64* %r2, i32 2
%r194 = load i64, i64* %r193
%r195 = getelementptr i64, i64* %r2, i32 4
%r196 = load i64, i64* %r195
%r197 = call i128 @mul64x64L(i64 %r194, i64 %r196)
%r198 = zext i256 %r192 to i384
%r199 = zext i128 %r197 to i384
%r200 = shl i384 %r199, 256
%r201 = or i384 %r198, %r200
%r202 = getelementptr i64, i64* %r2, i32 3
%r203 = load i64, i64* %r202
%r204 = getelementptr i64, i64* %r2, i32 5
%r205 = load i64, i64* %r204
%r206 = call i128 @mul64x64L(i64 %r203, i64 %r205)
%r207 = zext i384 %r201 to i512
%r208 = zext i128 %r206 to i512
%r209 = shl i512 %r208, 384
%r210 = or i512 %r207, %r209
%r211 = getelementptr i64, i64* %r2, i32 4
%r212 = load i64, i64* %r211
%r213 = getelementptr i64, i64* %r2, i32 6
%r214 = load i64, i64* %r213
%r215 = call i128 @mul64x64L(i64 %r212, i64 %r214)
%r216 = zext i512 %r210 to i640
%r217 = zext i128 %r215 to i640
%r218 = shl i640 %r217, 512
%r219 = or i640 %r216, %r218
%r220 = getelementptr i64, i64* %r2, i32 5
%r221 = load i64, i64* %r220
%r222 = getelementptr i64, i64* %r2, i32 7
%r223 = load i64, i64* %r222
%r224 = call i128 @mul64x64L(i64 %r221, i64 %r223)
%r225 = zext i640 %r219 to i768
%r226 = zext i128 %r224 to i768
%r227 = shl i768 %r226, 640
%r228 = or i768 %r225, %r227
%r229 = getelementptr i64, i64* %r2, i32 6
%r230 = load i64, i64* %r229
%r231 = getelementptr i64, i64* %r2, i32 8
%r232 = load i64, i64* %r231
%r233 = call i128 @mul64x64L(i64 %r230, i64 %r232)
%r234 = zext i768 %r228 to i896
%r235 = zext i128 %r233 to i896
%r236 = shl i896 %r235, 768
%r237 = or i896 %r234, %r236
%r238 = zext i768 %r179 to i896
%r239 = shl i896 %r238, 64
%r240 = add i896 %r239, %r237
%r241 = load i64, i64* %r2
%r242 = getelementptr i64, i64* %r2, i32 1
%r243 = load i64, i64* %r242
%r244 = call i128 @mul64x64L(i64 %r241, i64 %r243)
%r245 = getelementptr i64, i64* %r2, i32 1
%r246 = load i64, i64* %r245
%r247 = getelementptr i64, i64* %r2, i32 2
%r248 = load i64, i64* %r247
%r249 = call i128 @mul64x64L(i64 %r246, i64 %r248)
%r250 = zext i128 %r244 to i256
%r251 = zext i128 %r249 to i256
%r252 = shl i256 %r251, 128
%r253 = or i256 %r250, %r252
%r254 = getelementptr i64, i64* %r2, i32 2
%r255 = load i64, i64* %r254
%r256 = getelementptr i64, i64* %r2, i32 3
%r257 = load i64, i64* %r256
%r258 = call i128 @mul64x64L(i64 %r255, i64 %r257)
%r259 = zext i256 %r253 to i384
%r260 = zext i128 %r258 to i384
%r261 = shl i384 %r260, 256
%r262 = or i384 %r259, %r261
%r263 = getelementptr i64, i64* %r2, i32 3
%r264 = load i64, i64* %r263
%r265 = getelementptr i64, i64* %r2, i32 4
%r266 = load i64, i64* %r265
%r267 = call i128 @mul64x64L(i64 %r264, i64 %r266)
%r268 = zext i384 %r262 to i512
%r269 = zext i128 %r267 to i512
%r270 = shl i512 %r269, 384
%r271 = or i512 %r268, %r270
%r272 = getelementptr i64, i64* %r2, i32 4
%r273 = load i64, i64* %r272
%r274 = getelementptr i64, i64* %r2, i32 5
%r275 = load i64, i64* %r274
%r276 = call i128 @mul64x64L(i64 %r273, i64 %r275)
%r277 = zext i512 %r271 to i640
%r278 = zext i128 %r276 to i640
%r279 = shl i640 %r278, 512
%r280 = or i640 %r277, %r279
%r281 = getelementptr i64, i64* %r2, i32 5
%r282 = load i64, i64* %r281
%r283 = getelementptr i64, i64* %r2, i32 6
%r284 = load i64, i64* %r283
%r285 = call i128 @mul64x64L(i64 %r282, i64 %r284)
%r286 = zext i640 %r280 to i768
%r287 = zext i128 %r285 to i768
%r288 = shl i768 %r287, 640
%r289 = or i768 %r286, %r288
%r290 = getelementptr i64, i64* %r2, i32 6
%r291 = load i64, i64* %r290
%r292 = getelementptr i64, i64* %r2, i32 7
%r293 = load i64, i64* %r292
%r294 = call i128 @mul64x64L(i64 %r291, i64 %r293)
%r295 = zext i768 %r289 to i896
%r296 = zext i128 %r294 to i896
%r297 = shl i896 %r296, 768
%r298 = or i896 %r295, %r297
%r299 = getelementptr i64, i64* %r2, i32 7
%r300 = load i64, i64* %r299
%r301 = getelementptr i64, i64* %r2, i32 8
%r302 = load i64, i64* %r301
%r303 = call i128 @mul64x64L(i64 %r300, i64 %r302)
%r304 = zext i896 %r298 to i1024
%r305 = zext i128 %r303 to i1024
%r306 = shl i1024 %r305, 896
%r307 = or i1024 %r304, %r306
%r308 = zext i896 %r240 to i1024
%r309 = shl i1024 %r308, 64
%r310 = add i1024 %r309, %r307
%r311 = zext i128 %r6 to i1088
%r312 = getelementptr i64, i64* %r2, i32 1
%r313 = load i64, i64* %r312
%r314 = call i128 @mul64x64L(i64 %r313, i64 %r313)
%r315 = zext i128 %r314 to i1088
%r316 = shl i1088 %r315, 64
%r317 = or i1088 %r311, %r316
%r318 = getelementptr i64, i64* %r2, i32 2
%r319 = load i64, i64* %r318
%r320 = call i128 @mul64x64L(i64 %r319, i64 %r319)
%r321 = zext i128 %r320 to i1088
%r322 = shl i1088 %r321, 192
%r323 = or i1088 %r317, %r322
%r324 = getelementptr i64, i64* %r2, i32 3
%r325 = load i64, i64* %r324
%r326 = call i128 @mul64x64L(i64 %r325, i64 %r325)
%r327 = zext i128 %r326 to i1088
%r328 = shl i1088 %r327, 320
%r329 = or i1088 %r323, %r328
%r330 = getelementptr i64, i64* %r2, i32 4
%r331 = load i64, i64* %r330
%r332 = call i128 @mul64x64L(i64 %r331, i64 %r331)
%r333 = zext i128 %r332 to i1088
%r334 = shl i1088 %r333, 448
%r335 = or i1088 %r329, %r334
%r336 = getelementptr i64, i64* %r2, i32 5
%r337 = load i64, i64* %r336
%r338 = call i128 @mul64x64L(i64 %r337, i64 %r337)
%r339 = zext i128 %r338 to i1088
%r340 = shl i1088 %r339, 576
%r341 = or i1088 %r335, %r340
%r342 = getelementptr i64, i64* %r2, i32 6
%r343 = load i64, i64* %r342
%r344 = call i128 @mul64x64L(i64 %r343, i64 %r343)
%r345 = zext i128 %r344 to i1088
%r346 = shl i1088 %r345, 704
%r347 = or i1088 %r341, %r346
%r348 = getelementptr i64, i64* %r2, i32 7
%r349 = load i64, i64* %r348
%r350 = call i128 @mul64x64L(i64 %r349, i64 %r349)
%r351 = zext i128 %r350 to i1088
%r352 = shl i1088 %r351, 832
%r353 = or i1088 %r347, %r352
%r354 = getelementptr i64, i64* %r2, i32 8
%r355 = load i64, i64* %r354
%r356 = call i128 @mul64x64L(i64 %r355, i64 %r355)
%r357 = zext i128 %r356 to i1088
%r358 = shl i1088 %r357, 960
%r359 = or i1088 %r353, %r358
%r360 = zext i1024 %r310 to i1088
%r361 = add i1088 %r360, %r360
%r362 = add i1088 %r359, %r361
%r363 = getelementptr i64, i64* %r1, i32 1
%r364 = bitcast i64* %r363 to i1088*
store i1088 %r362, i1088* %r364
ret void
}
