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
%r16 = bitcast i64* %r2 to i128*
store i128 %r14, i128* %r16
%r17 = lshr i192 %r13, 128
%r18 = trunc i192 %r17 to i64
ret i64 %r18
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
%r16 = bitcast i64* %r2 to i128*
store i128 %r14, i128* %r16
%r17 = lshr i192 %r13, 128
%r18 = trunc i192 %r17 to i64
%r20 = and i64 %r18, 1
ret i64 %r20
}
define void @mclb_addNF2(i64* noalias  %r1, i64* noalias  %r2, i64* noalias  %r3)
{
%r5 = bitcast i64* %r2 to i128*
%r6 = load i128, i128* %r5
%r8 = bitcast i64* %r3 to i128*
%r9 = load i128, i128* %r8
%r10 = add i128 %r6, %r9
%r12 = bitcast i64* %r1 to i128*
store i128 %r10, i128* %r12
ret void
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
%r16 = bitcast i64* %r2 to i192*
store i192 %r14, i192* %r16
%r17 = lshr i256 %r13, 192
%r18 = trunc i256 %r17 to i64
ret i64 %r18
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
%r16 = bitcast i64* %r2 to i192*
store i192 %r14, i192* %r16
%r17 = lshr i256 %r13, 192
%r18 = trunc i256 %r17 to i64
%r20 = and i64 %r18, 1
ret i64 %r20
}
define void @mclb_addNF3(i64* noalias  %r1, i64* noalias  %r2, i64* noalias  %r3)
{
%r5 = bitcast i64* %r2 to i192*
%r6 = load i192, i192* %r5
%r8 = bitcast i64* %r3 to i192*
%r9 = load i192, i192* %r8
%r10 = add i192 %r6, %r9
%r12 = bitcast i64* %r1 to i192*
store i192 %r10, i192* %r12
ret void
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
%r16 = bitcast i64* %r2 to i256*
store i256 %r14, i256* %r16
%r17 = lshr i320 %r13, 256
%r18 = trunc i320 %r17 to i64
ret i64 %r18
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
%r16 = bitcast i64* %r2 to i256*
store i256 %r14, i256* %r16
%r17 = lshr i320 %r13, 256
%r18 = trunc i320 %r17 to i64
%r20 = and i64 %r18, 1
ret i64 %r20
}
define void @mclb_addNF4(i64* noalias  %r1, i64* noalias  %r2, i64* noalias  %r3)
{
%r5 = bitcast i64* %r2 to i256*
%r6 = load i256, i256* %r5
%r8 = bitcast i64* %r3 to i256*
%r9 = load i256, i256* %r8
%r10 = add i256 %r6, %r9
%r12 = bitcast i64* %r1 to i256*
store i256 %r10, i256* %r12
ret void
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
%r16 = bitcast i64* %r2 to i320*
store i320 %r14, i320* %r16
%r17 = lshr i384 %r13, 320
%r18 = trunc i384 %r17 to i64
ret i64 %r18
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
%r16 = bitcast i64* %r2 to i320*
store i320 %r14, i320* %r16
%r17 = lshr i384 %r13, 320
%r18 = trunc i384 %r17 to i64
%r20 = and i64 %r18, 1
ret i64 %r20
}
define void @mclb_addNF5(i64* noalias  %r1, i64* noalias  %r2, i64* noalias  %r3)
{
%r5 = bitcast i64* %r2 to i320*
%r6 = load i320, i320* %r5
%r8 = bitcast i64* %r3 to i320*
%r9 = load i320, i320* %r8
%r10 = add i320 %r6, %r9
%r12 = bitcast i64* %r1 to i320*
store i320 %r10, i320* %r12
ret void
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
%r16 = bitcast i64* %r2 to i384*
store i384 %r14, i384* %r16
%r17 = lshr i448 %r13, 384
%r18 = trunc i448 %r17 to i64
ret i64 %r18
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
%r16 = bitcast i64* %r2 to i384*
store i384 %r14, i384* %r16
%r17 = lshr i448 %r13, 384
%r18 = trunc i448 %r17 to i64
%r20 = and i64 %r18, 1
ret i64 %r20
}
define void @mclb_addNF6(i64* noalias  %r1, i64* noalias  %r2, i64* noalias  %r3)
{
%r5 = bitcast i64* %r2 to i384*
%r6 = load i384, i384* %r5
%r8 = bitcast i64* %r3 to i384*
%r9 = load i384, i384* %r8
%r10 = add i384 %r6, %r9
%r12 = bitcast i64* %r1 to i384*
store i384 %r10, i384* %r12
ret void
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
%r16 = bitcast i64* %r2 to i448*
store i448 %r14, i448* %r16
%r17 = lshr i512 %r13, 448
%r18 = trunc i512 %r17 to i64
ret i64 %r18
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
%r16 = bitcast i64* %r2 to i448*
store i448 %r14, i448* %r16
%r17 = lshr i512 %r13, 448
%r18 = trunc i512 %r17 to i64
%r20 = and i64 %r18, 1
ret i64 %r20
}
define void @mclb_addNF7(i64* noalias  %r1, i64* noalias  %r2, i64* noalias  %r3)
{
%r5 = bitcast i64* %r2 to i448*
%r6 = load i448, i448* %r5
%r8 = bitcast i64* %r3 to i448*
%r9 = load i448, i448* %r8
%r10 = add i448 %r6, %r9
%r12 = bitcast i64* %r1 to i448*
store i448 %r10, i448* %r12
ret void
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
%r16 = bitcast i64* %r2 to i512*
store i512 %r14, i512* %r16
%r17 = lshr i576 %r13, 512
%r18 = trunc i576 %r17 to i64
ret i64 %r18
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
%r16 = bitcast i64* %r2 to i512*
store i512 %r14, i512* %r16
%r17 = lshr i576 %r13, 512
%r18 = trunc i576 %r17 to i64
%r20 = and i64 %r18, 1
ret i64 %r20
}
define void @mclb_addNF8(i64* noalias  %r1, i64* noalias  %r2, i64* noalias  %r3)
{
%r5 = bitcast i64* %r2 to i512*
%r6 = load i512, i512* %r5
%r8 = bitcast i64* %r3 to i512*
%r9 = load i512, i512* %r8
%r10 = add i512 %r6, %r9
%r12 = bitcast i64* %r1 to i512*
store i512 %r10, i512* %r12
ret void
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
%r16 = bitcast i64* %r2 to i576*
store i576 %r14, i576* %r16
%r17 = lshr i640 %r13, 576
%r18 = trunc i640 %r17 to i64
ret i64 %r18
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
%r16 = bitcast i64* %r2 to i576*
store i576 %r14, i576* %r16
%r17 = lshr i640 %r13, 576
%r18 = trunc i640 %r17 to i64
%r20 = and i64 %r18, 1
ret i64 %r20
}
define void @mclb_addNF9(i64* noalias  %r1, i64* noalias  %r2, i64* noalias  %r3)
{
%r5 = bitcast i64* %r2 to i576*
%r6 = load i576, i576* %r5
%r8 = bitcast i64* %r3 to i576*
%r9 = load i576, i576* %r8
%r10 = add i576 %r6, %r9
%r12 = bitcast i64* %r1 to i576*
store i576 %r10, i576* %r12
ret void
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
%r16 = bitcast i64* %r2 to i640*
store i640 %r14, i640* %r16
%r17 = lshr i704 %r13, 640
%r18 = trunc i704 %r17 to i64
ret i64 %r18
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
%r16 = bitcast i64* %r2 to i640*
store i640 %r14, i640* %r16
%r17 = lshr i704 %r13, 640
%r18 = trunc i704 %r17 to i64
%r20 = and i64 %r18, 1
ret i64 %r20
}
define void @mclb_addNF10(i64* noalias  %r1, i64* noalias  %r2, i64* noalias  %r3)
{
%r5 = bitcast i64* %r2 to i640*
%r6 = load i640, i640* %r5
%r8 = bitcast i64* %r3 to i640*
%r9 = load i640, i640* %r8
%r10 = add i640 %r6, %r9
%r12 = bitcast i64* %r1 to i640*
store i640 %r10, i640* %r12
ret void
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
%r16 = bitcast i64* %r2 to i704*
store i704 %r14, i704* %r16
%r17 = lshr i768 %r13, 704
%r18 = trunc i768 %r17 to i64
ret i64 %r18
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
%r16 = bitcast i64* %r2 to i704*
store i704 %r14, i704* %r16
%r17 = lshr i768 %r13, 704
%r18 = trunc i768 %r17 to i64
%r20 = and i64 %r18, 1
ret i64 %r20
}
define void @mclb_addNF11(i64* noalias  %r1, i64* noalias  %r2, i64* noalias  %r3)
{
%r5 = bitcast i64* %r2 to i704*
%r6 = load i704, i704* %r5
%r8 = bitcast i64* %r3 to i704*
%r9 = load i704, i704* %r8
%r10 = add i704 %r6, %r9
%r12 = bitcast i64* %r1 to i704*
store i704 %r10, i704* %r12
ret void
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
%r16 = bitcast i64* %r2 to i768*
store i768 %r14, i768* %r16
%r17 = lshr i832 %r13, 768
%r18 = trunc i832 %r17 to i64
ret i64 %r18
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
%r16 = bitcast i64* %r2 to i768*
store i768 %r14, i768* %r16
%r17 = lshr i832 %r13, 768
%r18 = trunc i832 %r17 to i64
%r20 = and i64 %r18, 1
ret i64 %r20
}
define void @mclb_addNF12(i64* noalias  %r1, i64* noalias  %r2, i64* noalias  %r3)
{
%r5 = bitcast i64* %r2 to i768*
%r6 = load i768, i768* %r5
%r8 = bitcast i64* %r3 to i768*
%r9 = load i768, i768* %r8
%r10 = add i768 %r6, %r9
%r12 = bitcast i64* %r1 to i768*
store i768 %r10, i768* %r12
ret void
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
%r16 = bitcast i64* %r2 to i832*
store i832 %r14, i832* %r16
%r17 = lshr i896 %r13, 832
%r18 = trunc i896 %r17 to i64
ret i64 %r18
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
%r16 = bitcast i64* %r2 to i832*
store i832 %r14, i832* %r16
%r17 = lshr i896 %r13, 832
%r18 = trunc i896 %r17 to i64
%r20 = and i64 %r18, 1
ret i64 %r20
}
define void @mclb_addNF13(i64* noalias  %r1, i64* noalias  %r2, i64* noalias  %r3)
{
%r5 = bitcast i64* %r2 to i832*
%r6 = load i832, i832* %r5
%r8 = bitcast i64* %r3 to i832*
%r9 = load i832, i832* %r8
%r10 = add i832 %r6, %r9
%r12 = bitcast i64* %r1 to i832*
store i832 %r10, i832* %r12
ret void
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
%r16 = bitcast i64* %r2 to i896*
store i896 %r14, i896* %r16
%r17 = lshr i960 %r13, 896
%r18 = trunc i960 %r17 to i64
ret i64 %r18
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
%r16 = bitcast i64* %r2 to i896*
store i896 %r14, i896* %r16
%r17 = lshr i960 %r13, 896
%r18 = trunc i960 %r17 to i64
%r20 = and i64 %r18, 1
ret i64 %r20
}
define void @mclb_addNF14(i64* noalias  %r1, i64* noalias  %r2, i64* noalias  %r3)
{
%r5 = bitcast i64* %r2 to i896*
%r6 = load i896, i896* %r5
%r8 = bitcast i64* %r3 to i896*
%r9 = load i896, i896* %r8
%r10 = add i896 %r6, %r9
%r12 = bitcast i64* %r1 to i896*
store i896 %r10, i896* %r12
ret void
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
%r16 = bitcast i64* %r2 to i960*
store i960 %r14, i960* %r16
%r17 = lshr i1024 %r13, 960
%r18 = trunc i1024 %r17 to i64
ret i64 %r18
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
%r16 = bitcast i64* %r2 to i960*
store i960 %r14, i960* %r16
%r17 = lshr i1024 %r13, 960
%r18 = trunc i1024 %r17 to i64
%r20 = and i64 %r18, 1
ret i64 %r20
}
define void @mclb_addNF15(i64* noalias  %r1, i64* noalias  %r2, i64* noalias  %r3)
{
%r5 = bitcast i64* %r2 to i960*
%r6 = load i960, i960* %r5
%r8 = bitcast i64* %r3 to i960*
%r9 = load i960, i960* %r8
%r10 = add i960 %r6, %r9
%r12 = bitcast i64* %r1 to i960*
store i960 %r10, i960* %r12
ret void
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
%r16 = bitcast i64* %r2 to i1024*
store i1024 %r14, i1024* %r16
%r17 = lshr i1088 %r13, 1024
%r18 = trunc i1088 %r17 to i64
ret i64 %r18
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
%r16 = bitcast i64* %r2 to i1024*
store i1024 %r14, i1024* %r16
%r17 = lshr i1088 %r13, 1024
%r18 = trunc i1088 %r17 to i64
%r20 = and i64 %r18, 1
ret i64 %r20
}
define void @mclb_addNF16(i64* noalias  %r1, i64* noalias  %r2, i64* noalias  %r3)
{
%r5 = bitcast i64* %r2 to i1024*
%r6 = load i1024, i1024* %r5
%r8 = bitcast i64* %r3 to i1024*
%r9 = load i1024, i1024* %r8
%r10 = add i1024 %r6, %r9
%r12 = bitcast i64* %r1 to i1024*
store i1024 %r10, i1024* %r12
ret void
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
%r16 = bitcast i64* %r2 to i1088*
store i1088 %r14, i1088* %r16
%r17 = lshr i1152 %r13, 1088
%r18 = trunc i1152 %r17 to i64
ret i64 %r18
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
%r16 = bitcast i64* %r2 to i1088*
store i1088 %r14, i1088* %r16
%r17 = lshr i1152 %r13, 1088
%r18 = trunc i1152 %r17 to i64
%r20 = and i64 %r18, 1
ret i64 %r20
}
define void @mclb_addNF17(i64* noalias  %r1, i64* noalias  %r2, i64* noalias  %r3)
{
%r5 = bitcast i64* %r2 to i1088*
%r6 = load i1088, i1088* %r5
%r8 = bitcast i64* %r3 to i1088*
%r9 = load i1088, i1088* %r8
%r10 = add i1088 %r6, %r9
%r12 = bitcast i64* %r1 to i1088*
store i1088 %r10, i1088* %r12
ret void
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
%r16 = bitcast i64* %r2 to i1152*
store i1152 %r14, i1152* %r16
%r17 = lshr i1216 %r13, 1152
%r18 = trunc i1216 %r17 to i64
ret i64 %r18
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
%r16 = bitcast i64* %r2 to i1152*
store i1152 %r14, i1152* %r16
%r17 = lshr i1216 %r13, 1152
%r18 = trunc i1216 %r17 to i64
%r20 = and i64 %r18, 1
ret i64 %r20
}
define void @mclb_addNF18(i64* noalias  %r1, i64* noalias  %r2, i64* noalias  %r3)
{
%r5 = bitcast i64* %r2 to i1152*
%r6 = load i1152, i1152* %r5
%r8 = bitcast i64* %r3 to i1152*
%r9 = load i1152, i1152* %r8
%r10 = add i1152 %r6, %r9
%r12 = bitcast i64* %r1 to i1152*
store i1152 %r10, i1152* %r12
ret void
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
%r16 = bitcast i64* %r2 to i1216*
store i1216 %r14, i1216* %r16
%r17 = lshr i1280 %r13, 1216
%r18 = trunc i1280 %r17 to i64
ret i64 %r18
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
%r16 = bitcast i64* %r2 to i1216*
store i1216 %r14, i1216* %r16
%r17 = lshr i1280 %r13, 1216
%r18 = trunc i1280 %r17 to i64
%r20 = and i64 %r18, 1
ret i64 %r20
}
define void @mclb_addNF19(i64* noalias  %r1, i64* noalias  %r2, i64* noalias  %r3)
{
%r5 = bitcast i64* %r2 to i1216*
%r6 = load i1216, i1216* %r5
%r8 = bitcast i64* %r3 to i1216*
%r9 = load i1216, i1216* %r8
%r10 = add i1216 %r6, %r9
%r12 = bitcast i64* %r1 to i1216*
store i1216 %r10, i1216* %r12
ret void
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
%r16 = bitcast i64* %r2 to i1280*
store i1280 %r14, i1280* %r16
%r17 = lshr i1344 %r13, 1280
%r18 = trunc i1344 %r17 to i64
ret i64 %r18
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
%r16 = bitcast i64* %r2 to i1280*
store i1280 %r14, i1280* %r16
%r17 = lshr i1344 %r13, 1280
%r18 = trunc i1344 %r17 to i64
%r20 = and i64 %r18, 1
ret i64 %r20
}
define void @mclb_addNF20(i64* noalias  %r1, i64* noalias  %r2, i64* noalias  %r3)
{
%r5 = bitcast i64* %r2 to i1280*
%r6 = load i1280, i1280* %r5
%r8 = bitcast i64* %r3 to i1280*
%r9 = load i1280, i1280* %r8
%r10 = add i1280 %r6, %r9
%r12 = bitcast i64* %r1 to i1280*
store i1280 %r10, i1280* %r12
ret void
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
%r16 = bitcast i64* %r2 to i1344*
store i1344 %r14, i1344* %r16
%r17 = lshr i1408 %r13, 1344
%r18 = trunc i1408 %r17 to i64
ret i64 %r18
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
%r16 = bitcast i64* %r2 to i1344*
store i1344 %r14, i1344* %r16
%r17 = lshr i1408 %r13, 1344
%r18 = trunc i1408 %r17 to i64
%r20 = and i64 %r18, 1
ret i64 %r20
}
define void @mclb_addNF21(i64* noalias  %r1, i64* noalias  %r2, i64* noalias  %r3)
{
%r5 = bitcast i64* %r2 to i1344*
%r6 = load i1344, i1344* %r5
%r8 = bitcast i64* %r3 to i1344*
%r9 = load i1344, i1344* %r8
%r10 = add i1344 %r6, %r9
%r12 = bitcast i64* %r1 to i1344*
store i1344 %r10, i1344* %r12
ret void
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
%r16 = bitcast i64* %r2 to i1408*
store i1408 %r14, i1408* %r16
%r17 = lshr i1472 %r13, 1408
%r18 = trunc i1472 %r17 to i64
ret i64 %r18
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
%r16 = bitcast i64* %r2 to i1408*
store i1408 %r14, i1408* %r16
%r17 = lshr i1472 %r13, 1408
%r18 = trunc i1472 %r17 to i64
%r20 = and i64 %r18, 1
ret i64 %r20
}
define void @mclb_addNF22(i64* noalias  %r1, i64* noalias  %r2, i64* noalias  %r3)
{
%r5 = bitcast i64* %r2 to i1408*
%r6 = load i1408, i1408* %r5
%r8 = bitcast i64* %r3 to i1408*
%r9 = load i1408, i1408* %r8
%r10 = add i1408 %r6, %r9
%r12 = bitcast i64* %r1 to i1408*
store i1408 %r10, i1408* %r12
ret void
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
%r16 = bitcast i64* %r2 to i1472*
store i1472 %r14, i1472* %r16
%r17 = lshr i1536 %r13, 1472
%r18 = trunc i1536 %r17 to i64
ret i64 %r18
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
%r16 = bitcast i64* %r2 to i1472*
store i1472 %r14, i1472* %r16
%r17 = lshr i1536 %r13, 1472
%r18 = trunc i1536 %r17 to i64
%r20 = and i64 %r18, 1
ret i64 %r20
}
define void @mclb_addNF23(i64* noalias  %r1, i64* noalias  %r2, i64* noalias  %r3)
{
%r5 = bitcast i64* %r2 to i1472*
%r6 = load i1472, i1472* %r5
%r8 = bitcast i64* %r3 to i1472*
%r9 = load i1472, i1472* %r8
%r10 = add i1472 %r6, %r9
%r12 = bitcast i64* %r1 to i1472*
store i1472 %r10, i1472* %r12
ret void
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
%r16 = bitcast i64* %r2 to i1536*
store i1536 %r14, i1536* %r16
%r17 = lshr i1600 %r13, 1536
%r18 = trunc i1600 %r17 to i64
ret i64 %r18
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
%r16 = bitcast i64* %r2 to i1536*
store i1536 %r14, i1536* %r16
%r17 = lshr i1600 %r13, 1536
%r18 = trunc i1600 %r17 to i64
%r20 = and i64 %r18, 1
ret i64 %r20
}
define void @mclb_addNF24(i64* noalias  %r1, i64* noalias  %r2, i64* noalias  %r3)
{
%r5 = bitcast i64* %r2 to i1536*
%r6 = load i1536, i1536* %r5
%r8 = bitcast i64* %r3 to i1536*
%r9 = load i1536, i1536* %r8
%r10 = add i1536 %r6, %r9
%r12 = bitcast i64* %r1 to i1536*
store i1536 %r10, i1536* %r12
ret void
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
%r16 = bitcast i64* %r2 to i1600*
store i1600 %r14, i1600* %r16
%r17 = lshr i1664 %r13, 1600
%r18 = trunc i1664 %r17 to i64
ret i64 %r18
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
%r16 = bitcast i64* %r2 to i1600*
store i1600 %r14, i1600* %r16
%r17 = lshr i1664 %r13, 1600
%r18 = trunc i1664 %r17 to i64
%r20 = and i64 %r18, 1
ret i64 %r20
}
define void @mclb_addNF25(i64* noalias  %r1, i64* noalias  %r2, i64* noalias  %r3)
{
%r5 = bitcast i64* %r2 to i1600*
%r6 = load i1600, i1600* %r5
%r8 = bitcast i64* %r3 to i1600*
%r9 = load i1600, i1600* %r8
%r10 = add i1600 %r6, %r9
%r12 = bitcast i64* %r1 to i1600*
store i1600 %r10, i1600* %r12
ret void
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
%r16 = bitcast i64* %r2 to i1664*
store i1664 %r14, i1664* %r16
%r17 = lshr i1728 %r13, 1664
%r18 = trunc i1728 %r17 to i64
ret i64 %r18
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
%r16 = bitcast i64* %r2 to i1664*
store i1664 %r14, i1664* %r16
%r17 = lshr i1728 %r13, 1664
%r18 = trunc i1728 %r17 to i64
%r20 = and i64 %r18, 1
ret i64 %r20
}
define void @mclb_addNF26(i64* noalias  %r1, i64* noalias  %r2, i64* noalias  %r3)
{
%r5 = bitcast i64* %r2 to i1664*
%r6 = load i1664, i1664* %r5
%r8 = bitcast i64* %r3 to i1664*
%r9 = load i1664, i1664* %r8
%r10 = add i1664 %r6, %r9
%r12 = bitcast i64* %r1 to i1664*
store i1664 %r10, i1664* %r12
ret void
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
%r16 = bitcast i64* %r2 to i1728*
store i1728 %r14, i1728* %r16
%r17 = lshr i1792 %r13, 1728
%r18 = trunc i1792 %r17 to i64
ret i64 %r18
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
%r16 = bitcast i64* %r2 to i1728*
store i1728 %r14, i1728* %r16
%r17 = lshr i1792 %r13, 1728
%r18 = trunc i1792 %r17 to i64
%r20 = and i64 %r18, 1
ret i64 %r20
}
define void @mclb_addNF27(i64* noalias  %r1, i64* noalias  %r2, i64* noalias  %r3)
{
%r5 = bitcast i64* %r2 to i1728*
%r6 = load i1728, i1728* %r5
%r8 = bitcast i64* %r3 to i1728*
%r9 = load i1728, i1728* %r8
%r10 = add i1728 %r6, %r9
%r12 = bitcast i64* %r1 to i1728*
store i1728 %r10, i1728* %r12
ret void
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
%r16 = bitcast i64* %r2 to i1792*
store i1792 %r14, i1792* %r16
%r17 = lshr i1856 %r13, 1792
%r18 = trunc i1856 %r17 to i64
ret i64 %r18
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
%r16 = bitcast i64* %r2 to i1792*
store i1792 %r14, i1792* %r16
%r17 = lshr i1856 %r13, 1792
%r18 = trunc i1856 %r17 to i64
%r20 = and i64 %r18, 1
ret i64 %r20
}
define void @mclb_addNF28(i64* noalias  %r1, i64* noalias  %r2, i64* noalias  %r3)
{
%r5 = bitcast i64* %r2 to i1792*
%r6 = load i1792, i1792* %r5
%r8 = bitcast i64* %r3 to i1792*
%r9 = load i1792, i1792* %r8
%r10 = add i1792 %r6, %r9
%r12 = bitcast i64* %r1 to i1792*
store i1792 %r10, i1792* %r12
ret void
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
%r16 = bitcast i64* %r2 to i1856*
store i1856 %r14, i1856* %r16
%r17 = lshr i1920 %r13, 1856
%r18 = trunc i1920 %r17 to i64
ret i64 %r18
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
%r16 = bitcast i64* %r2 to i1856*
store i1856 %r14, i1856* %r16
%r17 = lshr i1920 %r13, 1856
%r18 = trunc i1920 %r17 to i64
%r20 = and i64 %r18, 1
ret i64 %r20
}
define void @mclb_addNF29(i64* noalias  %r1, i64* noalias  %r2, i64* noalias  %r3)
{
%r5 = bitcast i64* %r2 to i1856*
%r6 = load i1856, i1856* %r5
%r8 = bitcast i64* %r3 to i1856*
%r9 = load i1856, i1856* %r8
%r10 = add i1856 %r6, %r9
%r12 = bitcast i64* %r1 to i1856*
store i1856 %r10, i1856* %r12
ret void
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
%r16 = bitcast i64* %r2 to i1920*
store i1920 %r14, i1920* %r16
%r17 = lshr i1984 %r13, 1920
%r18 = trunc i1984 %r17 to i64
ret i64 %r18
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
%r16 = bitcast i64* %r2 to i1920*
store i1920 %r14, i1920* %r16
%r17 = lshr i1984 %r13, 1920
%r18 = trunc i1984 %r17 to i64
%r20 = and i64 %r18, 1
ret i64 %r20
}
define void @mclb_addNF30(i64* noalias  %r1, i64* noalias  %r2, i64* noalias  %r3)
{
%r5 = bitcast i64* %r2 to i1920*
%r6 = load i1920, i1920* %r5
%r8 = bitcast i64* %r3 to i1920*
%r9 = load i1920, i1920* %r8
%r10 = add i1920 %r6, %r9
%r12 = bitcast i64* %r1 to i1920*
store i1920 %r10, i1920* %r12
ret void
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
%r16 = bitcast i64* %r2 to i1984*
store i1984 %r14, i1984* %r16
%r17 = lshr i2048 %r13, 1984
%r18 = trunc i2048 %r17 to i64
ret i64 %r18
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
%r16 = bitcast i64* %r2 to i1984*
store i1984 %r14, i1984* %r16
%r17 = lshr i2048 %r13, 1984
%r18 = trunc i2048 %r17 to i64
%r20 = and i64 %r18, 1
ret i64 %r20
}
define void @mclb_addNF31(i64* noalias  %r1, i64* noalias  %r2, i64* noalias  %r3)
{
%r5 = bitcast i64* %r2 to i1984*
%r6 = load i1984, i1984* %r5
%r8 = bitcast i64* %r3 to i1984*
%r9 = load i1984, i1984* %r8
%r10 = add i1984 %r6, %r9
%r12 = bitcast i64* %r1 to i1984*
store i1984 %r10, i1984* %r12
ret void
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
%r16 = bitcast i64* %r2 to i2048*
store i2048 %r14, i2048* %r16
%r17 = lshr i2112 %r13, 2048
%r18 = trunc i2112 %r17 to i64
ret i64 %r18
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
%r16 = bitcast i64* %r2 to i2048*
store i2048 %r14, i2048* %r16
%r17 = lshr i2112 %r13, 2048
%r18 = trunc i2112 %r17 to i64
%r20 = and i64 %r18, 1
ret i64 %r20
}
define void @mclb_addNF32(i64* noalias  %r1, i64* noalias  %r2, i64* noalias  %r3)
{
%r5 = bitcast i64* %r2 to i2048*
%r6 = load i2048, i2048* %r5
%r8 = bitcast i64* %r3 to i2048*
%r9 = load i2048, i2048* %r8
%r10 = add i2048 %r6, %r9
%r12 = bitcast i64* %r1 to i2048*
store i2048 %r10, i2048* %r12
ret void
}
define i64 @mclb_mulUnit1(i64* noalias  %r2, i64* noalias  %r3, i64 %r4)
{
%r6 = call i128 @mulPos64x64(i64* %r3, i64 %r4, i64 0)
%r7 = trunc i128 %r6 to i64
%r8 = call i64 @extractHigh64(i128 %r6)
%r9 = zext i64 %r7 to i128
%r10 = zext i64 %r8 to i128
%r11 = shl i128 %r10, 64
%r12 = add i128 %r9, %r11
%r13 = trunc i128 %r12 to i64
store i64 %r13, i64* %r2
%r14 = lshr i128 %r12, 64
%r15 = trunc i128 %r14 to i64
ret i64 %r15
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
define i64 @mclb_mulUnit2(i64* noalias  %r2, i64* noalias  %r3, i64 %r4)
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
%r25 = trunc i192 %r24 to i128
%r27 = bitcast i64* %r2 to i128*
store i128 %r25, i128* %r27
%r28 = lshr i192 %r24, 128
%r29 = trunc i192 %r28 to i64
ret i64 %r29
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
%r32 = bitcast i64* %r2 to i128*
store i128 %r30, i128* %r32
%r33 = lshr i192 %r29, 128
%r34 = trunc i192 %r33 to i64
ret i64 %r34
}
define i64 @mclb_mulUnit3(i64* noalias  %r2, i64* noalias  %r3, i64 %r4)
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
%r37 = trunc i256 %r36 to i192
%r39 = bitcast i64* %r2 to i192*
store i192 %r37, i192* %r39
%r40 = lshr i256 %r36, 192
%r41 = trunc i256 %r40 to i64
ret i64 %r41
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
%r44 = bitcast i64* %r2 to i192*
store i192 %r42, i192* %r44
%r45 = lshr i256 %r41, 192
%r46 = trunc i256 %r45 to i64
ret i64 %r46
}
define i64 @mclb_mulUnit4(i64* noalias  %r2, i64* noalias  %r3, i64 %r4)
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
%r49 = trunc i320 %r48 to i256
%r51 = bitcast i64* %r2 to i256*
store i256 %r49, i256* %r51
%r52 = lshr i320 %r48, 256
%r53 = trunc i320 %r52 to i64
ret i64 %r53
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
%r56 = bitcast i64* %r2 to i256*
store i256 %r54, i256* %r56
%r57 = lshr i320 %r53, 256
%r58 = trunc i320 %r57 to i64
ret i64 %r58
}
define i64 @mclb_mulUnit5(i64* noalias  %r2, i64* noalias  %r3, i64 %r4)
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
%r61 = trunc i384 %r60 to i320
%r63 = bitcast i64* %r2 to i320*
store i320 %r61, i320* %r63
%r64 = lshr i384 %r60, 320
%r65 = trunc i384 %r64 to i64
ret i64 %r65
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
%r68 = bitcast i64* %r2 to i320*
store i320 %r66, i320* %r68
%r69 = lshr i384 %r65, 320
%r70 = trunc i384 %r69 to i64
ret i64 %r70
}
define i64 @mclb_mulUnit6(i64* noalias  %r2, i64* noalias  %r3, i64 %r4)
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
%r73 = trunc i448 %r72 to i384
%r75 = bitcast i64* %r2 to i384*
store i384 %r73, i384* %r75
%r76 = lshr i448 %r72, 384
%r77 = trunc i448 %r76 to i64
ret i64 %r77
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
%r80 = bitcast i64* %r2 to i384*
store i384 %r78, i384* %r80
%r81 = lshr i448 %r77, 384
%r82 = trunc i448 %r81 to i64
ret i64 %r82
}
define i64 @mclb_mulUnit7(i64* noalias  %r2, i64* noalias  %r3, i64 %r4)
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
%r85 = trunc i512 %r84 to i448
%r87 = bitcast i64* %r2 to i448*
store i448 %r85, i448* %r87
%r88 = lshr i512 %r84, 448
%r89 = trunc i512 %r88 to i64
ret i64 %r89
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
%r92 = bitcast i64* %r2 to i448*
store i448 %r90, i448* %r92
%r93 = lshr i512 %r89, 448
%r94 = trunc i512 %r93 to i64
ret i64 %r94
}
define i64 @mclb_mulUnit8(i64* noalias  %r2, i64* noalias  %r3, i64 %r4)
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
%r97 = trunc i576 %r96 to i512
%r99 = bitcast i64* %r2 to i512*
store i512 %r97, i512* %r99
%r100 = lshr i576 %r96, 512
%r101 = trunc i576 %r100 to i64
ret i64 %r101
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
%r104 = bitcast i64* %r2 to i512*
store i512 %r102, i512* %r104
%r105 = lshr i576 %r101, 512
%r106 = trunc i576 %r105 to i64
ret i64 %r106
}
define i64 @mclb_mulUnit9(i64* noalias  %r2, i64* noalias  %r3, i64 %r4)
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
%r109 = trunc i640 %r108 to i576
%r111 = bitcast i64* %r2 to i576*
store i576 %r109, i576* %r111
%r112 = lshr i640 %r108, 576
%r113 = trunc i640 %r112 to i64
ret i64 %r113
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
%r116 = bitcast i64* %r2 to i576*
store i576 %r114, i576* %r116
%r117 = lshr i640 %r113, 576
%r118 = trunc i640 %r117 to i64
ret i64 %r118
}
define i64 @mclb_mulUnit10(i64* noalias  %r2, i64* noalias  %r3, i64 %r4)
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
%r121 = trunc i704 %r120 to i640
%r123 = bitcast i64* %r2 to i640*
store i640 %r121, i640* %r123
%r124 = lshr i704 %r120, 640
%r125 = trunc i704 %r124 to i64
ret i64 %r125
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
%r128 = bitcast i64* %r2 to i640*
store i640 %r126, i640* %r128
%r129 = lshr i704 %r125, 640
%r130 = trunc i704 %r129 to i64
ret i64 %r130
}
define i64 @mclb_mulUnit11(i64* noalias  %r2, i64* noalias  %r3, i64 %r4)
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
%r133 = trunc i768 %r132 to i704
%r135 = bitcast i64* %r2 to i704*
store i704 %r133, i704* %r135
%r136 = lshr i768 %r132, 704
%r137 = trunc i768 %r136 to i64
ret i64 %r137
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
%r140 = bitcast i64* %r2 to i704*
store i704 %r138, i704* %r140
%r141 = lshr i768 %r137, 704
%r142 = trunc i768 %r141 to i64
ret i64 %r142
}
define i64 @mclb_mulUnit12(i64* noalias  %r2, i64* noalias  %r3, i64 %r4)
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
%r145 = trunc i832 %r144 to i768
%r147 = bitcast i64* %r2 to i768*
store i768 %r145, i768* %r147
%r148 = lshr i832 %r144, 768
%r149 = trunc i832 %r148 to i64
ret i64 %r149
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
%r152 = bitcast i64* %r2 to i768*
store i768 %r150, i768* %r152
%r153 = lshr i832 %r149, 768
%r154 = trunc i832 %r153 to i64
ret i64 %r154
}
define i64 @mclb_mulUnit13(i64* noalias  %r2, i64* noalias  %r3, i64 %r4)
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
%r157 = trunc i896 %r156 to i832
%r159 = bitcast i64* %r2 to i832*
store i832 %r157, i832* %r159
%r160 = lshr i896 %r156, 832
%r161 = trunc i896 %r160 to i64
ret i64 %r161
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
%r164 = bitcast i64* %r2 to i832*
store i832 %r162, i832* %r164
%r165 = lshr i896 %r161, 832
%r166 = trunc i896 %r165 to i64
ret i64 %r166
}
define i64 @mclb_mulUnit14(i64* noalias  %r2, i64* noalias  %r3, i64 %r4)
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
%r169 = trunc i960 %r168 to i896
%r171 = bitcast i64* %r2 to i896*
store i896 %r169, i896* %r171
%r172 = lshr i960 %r168, 896
%r173 = trunc i960 %r172 to i64
ret i64 %r173
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
%r176 = bitcast i64* %r2 to i896*
store i896 %r174, i896* %r176
%r177 = lshr i960 %r173, 896
%r178 = trunc i960 %r177 to i64
ret i64 %r178
}
define i64 @mclb_mulUnit15(i64* noalias  %r2, i64* noalias  %r3, i64 %r4)
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
%r181 = trunc i1024 %r180 to i960
%r183 = bitcast i64* %r2 to i960*
store i960 %r181, i960* %r183
%r184 = lshr i1024 %r180, 960
%r185 = trunc i1024 %r184 to i64
ret i64 %r185
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
%r188 = bitcast i64* %r2 to i960*
store i960 %r186, i960* %r188
%r189 = lshr i1024 %r185, 960
%r190 = trunc i1024 %r189 to i64
ret i64 %r190
}
define i64 @mclb_mulUnit16(i64* noalias  %r2, i64* noalias  %r3, i64 %r4)
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
%r193 = trunc i1088 %r192 to i1024
%r195 = bitcast i64* %r2 to i1024*
store i1024 %r193, i1024* %r195
%r196 = lshr i1088 %r192, 1024
%r197 = trunc i1088 %r196 to i64
ret i64 %r197
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
%r200 = bitcast i64* %r2 to i1024*
store i1024 %r198, i1024* %r200
%r201 = lshr i1088 %r197, 1024
%r202 = trunc i1088 %r201 to i64
ret i64 %r202
}
define i64 @mclb_mulUnit17(i64* noalias  %r2, i64* noalias  %r3, i64 %r4)
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
%r205 = trunc i1152 %r204 to i1088
%r207 = bitcast i64* %r2 to i1088*
store i1088 %r205, i1088* %r207
%r208 = lshr i1152 %r204, 1088
%r209 = trunc i1152 %r208 to i64
ret i64 %r209
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
%r212 = bitcast i64* %r2 to i1088*
store i1088 %r210, i1088* %r212
%r213 = lshr i1152 %r209, 1088
%r214 = trunc i1152 %r213 to i64
ret i64 %r214
}
