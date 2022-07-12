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
%r12 = lshr i64 %r9, 32
%r13 = trunc i64 %r12 to i32
%r14 = and i32 %r13, 1
ret i32 %r14
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
%r16 = bitcast i32* %r2 to i64*
store i64 %r14, i64* %r16
%r17 = lshr i96 %r13, 64
%r18 = trunc i96 %r17 to i32
ret i32 %r18
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
%r16 = bitcast i32* %r2 to i64*
store i64 %r14, i64* %r16
%r18 = lshr i96 %r13, 64
%r19 = trunc i96 %r18 to i32
%r20 = and i32 %r19, 1
ret i32 %r20
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
%r16 = bitcast i32* %r2 to i96*
store i96 %r14, i96* %r16
%r17 = lshr i128 %r13, 96
%r18 = trunc i128 %r17 to i32
ret i32 %r18
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
%r16 = bitcast i32* %r2 to i96*
store i96 %r14, i96* %r16
%r18 = lshr i128 %r13, 96
%r19 = trunc i128 %r18 to i32
%r20 = and i32 %r19, 1
ret i32 %r20
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
%r16 = bitcast i32* %r2 to i128*
store i128 %r14, i128* %r16
%r17 = lshr i160 %r13, 128
%r18 = trunc i160 %r17 to i32
ret i32 %r18
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
%r16 = bitcast i32* %r2 to i128*
store i128 %r14, i128* %r16
%r18 = lshr i160 %r13, 128
%r19 = trunc i160 %r18 to i32
%r20 = and i32 %r19, 1
ret i32 %r20
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
%r16 = bitcast i32* %r2 to i160*
store i160 %r14, i160* %r16
%r17 = lshr i192 %r13, 160
%r18 = trunc i192 %r17 to i32
ret i32 %r18
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
%r16 = bitcast i32* %r2 to i160*
store i160 %r14, i160* %r16
%r18 = lshr i192 %r13, 160
%r19 = trunc i192 %r18 to i32
%r20 = and i32 %r19, 1
ret i32 %r20
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
%r16 = bitcast i32* %r2 to i192*
store i192 %r14, i192* %r16
%r17 = lshr i224 %r13, 192
%r18 = trunc i224 %r17 to i32
ret i32 %r18
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
%r16 = bitcast i32* %r2 to i192*
store i192 %r14, i192* %r16
%r18 = lshr i224 %r13, 192
%r19 = trunc i224 %r18 to i32
%r20 = and i32 %r19, 1
ret i32 %r20
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
%r16 = bitcast i32* %r2 to i224*
store i224 %r14, i224* %r16
%r17 = lshr i256 %r13, 224
%r18 = trunc i256 %r17 to i32
ret i32 %r18
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
%r16 = bitcast i32* %r2 to i224*
store i224 %r14, i224* %r16
%r18 = lshr i256 %r13, 224
%r19 = trunc i256 %r18 to i32
%r20 = and i32 %r19, 1
ret i32 %r20
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
%r16 = bitcast i32* %r2 to i256*
store i256 %r14, i256* %r16
%r17 = lshr i288 %r13, 256
%r18 = trunc i288 %r17 to i32
ret i32 %r18
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
%r16 = bitcast i32* %r2 to i256*
store i256 %r14, i256* %r16
%r18 = lshr i288 %r13, 256
%r19 = trunc i288 %r18 to i32
%r20 = and i32 %r19, 1
ret i32 %r20
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
%r16 = bitcast i32* %r2 to i288*
store i288 %r14, i288* %r16
%r17 = lshr i320 %r13, 288
%r18 = trunc i320 %r17 to i32
ret i32 %r18
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
%r16 = bitcast i32* %r2 to i288*
store i288 %r14, i288* %r16
%r18 = lshr i320 %r13, 288
%r19 = trunc i320 %r18 to i32
%r20 = and i32 %r19, 1
ret i32 %r20
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
%r16 = bitcast i32* %r2 to i320*
store i320 %r14, i320* %r16
%r17 = lshr i352 %r13, 320
%r18 = trunc i352 %r17 to i32
ret i32 %r18
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
%r16 = bitcast i32* %r2 to i320*
store i320 %r14, i320* %r16
%r18 = lshr i352 %r13, 320
%r19 = trunc i352 %r18 to i32
%r20 = and i32 %r19, 1
ret i32 %r20
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
%r16 = bitcast i32* %r2 to i352*
store i352 %r14, i352* %r16
%r17 = lshr i384 %r13, 352
%r18 = trunc i384 %r17 to i32
ret i32 %r18
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
%r16 = bitcast i32* %r2 to i352*
store i352 %r14, i352* %r16
%r18 = lshr i384 %r13, 352
%r19 = trunc i384 %r18 to i32
%r20 = and i32 %r19, 1
ret i32 %r20
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
%r16 = bitcast i32* %r2 to i384*
store i384 %r14, i384* %r16
%r17 = lshr i416 %r13, 384
%r18 = trunc i416 %r17 to i32
ret i32 %r18
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
%r16 = bitcast i32* %r2 to i384*
store i384 %r14, i384* %r16
%r18 = lshr i416 %r13, 384
%r19 = trunc i416 %r18 to i32
%r20 = and i32 %r19, 1
ret i32 %r20
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
%r16 = bitcast i32* %r2 to i416*
store i416 %r14, i416* %r16
%r17 = lshr i448 %r13, 416
%r18 = trunc i448 %r17 to i32
ret i32 %r18
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
%r16 = bitcast i32* %r2 to i416*
store i416 %r14, i416* %r16
%r18 = lshr i448 %r13, 416
%r19 = trunc i448 %r18 to i32
%r20 = and i32 %r19, 1
ret i32 %r20
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
%r16 = bitcast i32* %r2 to i448*
store i448 %r14, i448* %r16
%r17 = lshr i480 %r13, 448
%r18 = trunc i480 %r17 to i32
ret i32 %r18
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
%r16 = bitcast i32* %r2 to i448*
store i448 %r14, i448* %r16
%r18 = lshr i480 %r13, 448
%r19 = trunc i480 %r18 to i32
%r20 = and i32 %r19, 1
ret i32 %r20
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
%r16 = bitcast i32* %r2 to i480*
store i480 %r14, i480* %r16
%r17 = lshr i512 %r13, 480
%r18 = trunc i512 %r17 to i32
ret i32 %r18
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
%r16 = bitcast i32* %r2 to i480*
store i480 %r14, i480* %r16
%r18 = lshr i512 %r13, 480
%r19 = trunc i512 %r18 to i32
%r20 = and i32 %r19, 1
ret i32 %r20
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
%r16 = bitcast i32* %r2 to i512*
store i512 %r14, i512* %r16
%r17 = lshr i544 %r13, 512
%r18 = trunc i544 %r17 to i32
ret i32 %r18
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
%r16 = bitcast i32* %r2 to i512*
store i512 %r14, i512* %r16
%r18 = lshr i544 %r13, 512
%r19 = trunc i544 %r18 to i32
%r20 = and i32 %r19, 1
ret i32 %r20
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
%r16 = bitcast i32* %r2 to i544*
store i544 %r14, i544* %r16
%r17 = lshr i576 %r13, 544
%r18 = trunc i576 %r17 to i32
ret i32 %r18
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
%r16 = bitcast i32* %r2 to i544*
store i544 %r14, i544* %r16
%r18 = lshr i576 %r13, 544
%r19 = trunc i576 %r18 to i32
%r20 = and i32 %r19, 1
ret i32 %r20
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
%r16 = bitcast i32* %r2 to i576*
store i576 %r14, i576* %r16
%r17 = lshr i608 %r13, 576
%r18 = trunc i608 %r17 to i32
ret i32 %r18
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
%r16 = bitcast i32* %r2 to i576*
store i576 %r14, i576* %r16
%r18 = lshr i608 %r13, 576
%r19 = trunc i608 %r18 to i32
%r20 = and i32 %r19, 1
ret i32 %r20
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
%r16 = bitcast i32* %r2 to i608*
store i608 %r14, i608* %r16
%r17 = lshr i640 %r13, 608
%r18 = trunc i640 %r17 to i32
ret i32 %r18
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
%r16 = bitcast i32* %r2 to i608*
store i608 %r14, i608* %r16
%r18 = lshr i640 %r13, 608
%r19 = trunc i640 %r18 to i32
%r20 = and i32 %r19, 1
ret i32 %r20
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
%r16 = bitcast i32* %r2 to i640*
store i640 %r14, i640* %r16
%r17 = lshr i672 %r13, 640
%r18 = trunc i672 %r17 to i32
ret i32 %r18
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
%r16 = bitcast i32* %r2 to i640*
store i640 %r14, i640* %r16
%r18 = lshr i672 %r13, 640
%r19 = trunc i672 %r18 to i32
%r20 = and i32 %r19, 1
ret i32 %r20
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
%r16 = bitcast i32* %r2 to i672*
store i672 %r14, i672* %r16
%r17 = lshr i704 %r13, 672
%r18 = trunc i704 %r17 to i32
ret i32 %r18
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
%r16 = bitcast i32* %r2 to i672*
store i672 %r14, i672* %r16
%r18 = lshr i704 %r13, 672
%r19 = trunc i704 %r18 to i32
%r20 = and i32 %r19, 1
ret i32 %r20
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
%r16 = bitcast i32* %r2 to i704*
store i704 %r14, i704* %r16
%r17 = lshr i736 %r13, 704
%r18 = trunc i736 %r17 to i32
ret i32 %r18
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
%r16 = bitcast i32* %r2 to i704*
store i704 %r14, i704* %r16
%r18 = lshr i736 %r13, 704
%r19 = trunc i736 %r18 to i32
%r20 = and i32 %r19, 1
ret i32 %r20
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
%r16 = bitcast i32* %r2 to i736*
store i736 %r14, i736* %r16
%r17 = lshr i768 %r13, 736
%r18 = trunc i768 %r17 to i32
ret i32 %r18
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
%r16 = bitcast i32* %r2 to i736*
store i736 %r14, i736* %r16
%r18 = lshr i768 %r13, 736
%r19 = trunc i768 %r18 to i32
%r20 = and i32 %r19, 1
ret i32 %r20
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
%r16 = bitcast i32* %r2 to i768*
store i768 %r14, i768* %r16
%r17 = lshr i800 %r13, 768
%r18 = trunc i800 %r17 to i32
ret i32 %r18
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
%r16 = bitcast i32* %r2 to i768*
store i768 %r14, i768* %r16
%r18 = lshr i800 %r13, 768
%r19 = trunc i800 %r18 to i32
%r20 = and i32 %r19, 1
ret i32 %r20
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
%r16 = bitcast i32* %r2 to i800*
store i800 %r14, i800* %r16
%r17 = lshr i832 %r13, 800
%r18 = trunc i832 %r17 to i32
ret i32 %r18
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
%r16 = bitcast i32* %r2 to i800*
store i800 %r14, i800* %r16
%r18 = lshr i832 %r13, 800
%r19 = trunc i832 %r18 to i32
%r20 = and i32 %r19, 1
ret i32 %r20
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
%r16 = bitcast i32* %r2 to i832*
store i832 %r14, i832* %r16
%r17 = lshr i864 %r13, 832
%r18 = trunc i864 %r17 to i32
ret i32 %r18
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
%r16 = bitcast i32* %r2 to i832*
store i832 %r14, i832* %r16
%r18 = lshr i864 %r13, 832
%r19 = trunc i864 %r18 to i32
%r20 = and i32 %r19, 1
ret i32 %r20
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
%r16 = bitcast i32* %r2 to i864*
store i864 %r14, i864* %r16
%r17 = lshr i896 %r13, 864
%r18 = trunc i896 %r17 to i32
ret i32 %r18
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
%r16 = bitcast i32* %r2 to i864*
store i864 %r14, i864* %r16
%r18 = lshr i896 %r13, 864
%r19 = trunc i896 %r18 to i32
%r20 = and i32 %r19, 1
ret i32 %r20
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
%r16 = bitcast i32* %r2 to i896*
store i896 %r14, i896* %r16
%r17 = lshr i928 %r13, 896
%r18 = trunc i928 %r17 to i32
ret i32 %r18
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
%r16 = bitcast i32* %r2 to i896*
store i896 %r14, i896* %r16
%r18 = lshr i928 %r13, 896
%r19 = trunc i928 %r18 to i32
%r20 = and i32 %r19, 1
ret i32 %r20
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
%r16 = bitcast i32* %r2 to i928*
store i928 %r14, i928* %r16
%r17 = lshr i960 %r13, 928
%r18 = trunc i960 %r17 to i32
ret i32 %r18
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
%r16 = bitcast i32* %r2 to i928*
store i928 %r14, i928* %r16
%r18 = lshr i960 %r13, 928
%r19 = trunc i960 %r18 to i32
%r20 = and i32 %r19, 1
ret i32 %r20
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
%r16 = bitcast i32* %r2 to i960*
store i960 %r14, i960* %r16
%r17 = lshr i992 %r13, 960
%r18 = trunc i992 %r17 to i32
ret i32 %r18
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
%r16 = bitcast i32* %r2 to i960*
store i960 %r14, i960* %r16
%r18 = lshr i992 %r13, 960
%r19 = trunc i992 %r18 to i32
%r20 = and i32 %r19, 1
ret i32 %r20
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
%r16 = bitcast i32* %r2 to i992*
store i992 %r14, i992* %r16
%r17 = lshr i1024 %r13, 992
%r18 = trunc i1024 %r17 to i32
ret i32 %r18
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
%r16 = bitcast i32* %r2 to i992*
store i992 %r14, i992* %r16
%r18 = lshr i1024 %r13, 992
%r19 = trunc i1024 %r18 to i32
%r20 = and i32 %r19, 1
ret i32 %r20
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
%r16 = bitcast i32* %r2 to i1024*
store i1024 %r14, i1024* %r16
%r17 = lshr i1056 %r13, 1024
%r18 = trunc i1056 %r17 to i32
ret i32 %r18
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
%r16 = bitcast i32* %r2 to i1024*
store i1024 %r14, i1024* %r16
%r18 = lshr i1056 %r13, 1024
%r19 = trunc i1056 %r18 to i32
%r20 = and i32 %r19, 1
ret i32 %r20
}
define i32 @mclb_mulUnit1(i32* noalias  %r2, i32* noalias  %r3, i32 %r4)
{
%r6 = call i64 @mulPos32x32(i32* %r3, i32 %r4, i32 0)
%r7 = trunc i64 %r6 to i32
%r8 = call i32 @extractHigh32(i64 %r6)
%r9 = zext i32 %r7 to i64
%r10 = zext i32 %r8 to i64
%r11 = shl i64 %r10, 32
%r12 = add i64 %r9, %r11
%r13 = trunc i64 %r12 to i32
store i32 %r13, i32* %r2
%r14 = lshr i64 %r12, 32
%r15 = trunc i64 %r14 to i32
ret i32 %r15
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
define i32 @mclb_mulUnit2(i32* noalias  %r2, i32* noalias  %r3, i32 %r4)
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
%r25 = trunc i96 %r24 to i64
%r27 = bitcast i32* %r2 to i64*
store i64 %r25, i64* %r27
%r28 = lshr i96 %r24, 64
%r29 = trunc i96 %r28 to i32
ret i32 %r29
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
%r32 = bitcast i32* %r2 to i64*
store i64 %r30, i64* %r32
%r33 = lshr i96 %r29, 64
%r34 = trunc i96 %r33 to i32
ret i32 %r34
}
define i32 @mclb_mulUnit3(i32* noalias  %r2, i32* noalias  %r3, i32 %r4)
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
%r37 = trunc i128 %r36 to i96
%r39 = bitcast i32* %r2 to i96*
store i96 %r37, i96* %r39
%r40 = lshr i128 %r36, 96
%r41 = trunc i128 %r40 to i32
ret i32 %r41
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
%r44 = bitcast i32* %r2 to i96*
store i96 %r42, i96* %r44
%r45 = lshr i128 %r41, 96
%r46 = trunc i128 %r45 to i32
ret i32 %r46
}
define i32 @mclb_mulUnit4(i32* noalias  %r2, i32* noalias  %r3, i32 %r4)
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
%r49 = trunc i160 %r48 to i128
%r51 = bitcast i32* %r2 to i128*
store i128 %r49, i128* %r51
%r52 = lshr i160 %r48, 128
%r53 = trunc i160 %r52 to i32
ret i32 %r53
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
%r56 = bitcast i32* %r2 to i128*
store i128 %r54, i128* %r56
%r57 = lshr i160 %r53, 128
%r58 = trunc i160 %r57 to i32
ret i32 %r58
}
define i32 @mclb_mulUnit5(i32* noalias  %r2, i32* noalias  %r3, i32 %r4)
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
%r61 = trunc i192 %r60 to i160
%r63 = bitcast i32* %r2 to i160*
store i160 %r61, i160* %r63
%r64 = lshr i192 %r60, 160
%r65 = trunc i192 %r64 to i32
ret i32 %r65
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
%r68 = bitcast i32* %r2 to i160*
store i160 %r66, i160* %r68
%r69 = lshr i192 %r65, 160
%r70 = trunc i192 %r69 to i32
ret i32 %r70
}
define i32 @mclb_mulUnit6(i32* noalias  %r2, i32* noalias  %r3, i32 %r4)
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
%r73 = trunc i224 %r72 to i192
%r75 = bitcast i32* %r2 to i192*
store i192 %r73, i192* %r75
%r76 = lshr i224 %r72, 192
%r77 = trunc i224 %r76 to i32
ret i32 %r77
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
%r80 = bitcast i32* %r2 to i192*
store i192 %r78, i192* %r80
%r81 = lshr i224 %r77, 192
%r82 = trunc i224 %r81 to i32
ret i32 %r82
}
define i32 @mclb_mulUnit7(i32* noalias  %r2, i32* noalias  %r3, i32 %r4)
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
%r85 = trunc i256 %r84 to i224
%r87 = bitcast i32* %r2 to i224*
store i224 %r85, i224* %r87
%r88 = lshr i256 %r84, 224
%r89 = trunc i256 %r88 to i32
ret i32 %r89
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
%r92 = bitcast i32* %r2 to i224*
store i224 %r90, i224* %r92
%r93 = lshr i256 %r89, 224
%r94 = trunc i256 %r93 to i32
ret i32 %r94
}
define i32 @mclb_mulUnit8(i32* noalias  %r2, i32* noalias  %r3, i32 %r4)
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
%r97 = trunc i288 %r96 to i256
%r99 = bitcast i32* %r2 to i256*
store i256 %r97, i256* %r99
%r100 = lshr i288 %r96, 256
%r101 = trunc i288 %r100 to i32
ret i32 %r101
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
%r104 = bitcast i32* %r2 to i256*
store i256 %r102, i256* %r104
%r105 = lshr i288 %r101, 256
%r106 = trunc i288 %r105 to i32
ret i32 %r106
}
define i32 @mclb_mulUnit9(i32* noalias  %r2, i32* noalias  %r3, i32 %r4)
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
%r109 = trunc i320 %r108 to i288
%r111 = bitcast i32* %r2 to i288*
store i288 %r109, i288* %r111
%r112 = lshr i320 %r108, 288
%r113 = trunc i320 %r112 to i32
ret i32 %r113
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
%r116 = bitcast i32* %r2 to i288*
store i288 %r114, i288* %r116
%r117 = lshr i320 %r113, 288
%r118 = trunc i320 %r117 to i32
ret i32 %r118
}
define i32 @mclb_mulUnit10(i32* noalias  %r2, i32* noalias  %r3, i32 %r4)
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
%r121 = trunc i352 %r120 to i320
%r123 = bitcast i32* %r2 to i320*
store i320 %r121, i320* %r123
%r124 = lshr i352 %r120, 320
%r125 = trunc i352 %r124 to i32
ret i32 %r125
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
%r128 = bitcast i32* %r2 to i320*
store i320 %r126, i320* %r128
%r129 = lshr i352 %r125, 320
%r130 = trunc i352 %r129 to i32
ret i32 %r130
}
define i32 @mclb_mulUnit11(i32* noalias  %r2, i32* noalias  %r3, i32 %r4)
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
%r133 = trunc i384 %r132 to i352
%r135 = bitcast i32* %r2 to i352*
store i352 %r133, i352* %r135
%r136 = lshr i384 %r132, 352
%r137 = trunc i384 %r136 to i32
ret i32 %r137
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
%r140 = bitcast i32* %r2 to i352*
store i352 %r138, i352* %r140
%r141 = lshr i384 %r137, 352
%r142 = trunc i384 %r141 to i32
ret i32 %r142
}
define i32 @mclb_mulUnit12(i32* noalias  %r2, i32* noalias  %r3, i32 %r4)
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
%r145 = trunc i416 %r144 to i384
%r147 = bitcast i32* %r2 to i384*
store i384 %r145, i384* %r147
%r148 = lshr i416 %r144, 384
%r149 = trunc i416 %r148 to i32
ret i32 %r149
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
%r152 = bitcast i32* %r2 to i384*
store i384 %r150, i384* %r152
%r153 = lshr i416 %r149, 384
%r154 = trunc i416 %r153 to i32
ret i32 %r154
}
define i32 @mclb_mulUnit13(i32* noalias  %r2, i32* noalias  %r3, i32 %r4)
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
%r157 = trunc i448 %r156 to i416
%r159 = bitcast i32* %r2 to i416*
store i416 %r157, i416* %r159
%r160 = lshr i448 %r156, 416
%r161 = trunc i448 %r160 to i32
ret i32 %r161
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
%r164 = bitcast i32* %r2 to i416*
store i416 %r162, i416* %r164
%r165 = lshr i448 %r161, 416
%r166 = trunc i448 %r165 to i32
ret i32 %r166
}
define i32 @mclb_mulUnit14(i32* noalias  %r2, i32* noalias  %r3, i32 %r4)
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
%r169 = trunc i480 %r168 to i448
%r171 = bitcast i32* %r2 to i448*
store i448 %r169, i448* %r171
%r172 = lshr i480 %r168, 448
%r173 = trunc i480 %r172 to i32
ret i32 %r173
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
%r176 = bitcast i32* %r2 to i448*
store i448 %r174, i448* %r176
%r177 = lshr i480 %r173, 448
%r178 = trunc i480 %r177 to i32
ret i32 %r178
}
define i32 @mclb_mulUnit15(i32* noalias  %r2, i32* noalias  %r3, i32 %r4)
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
%r181 = trunc i512 %r180 to i480
%r183 = bitcast i32* %r2 to i480*
store i480 %r181, i480* %r183
%r184 = lshr i512 %r180, 480
%r185 = trunc i512 %r184 to i32
ret i32 %r185
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
%r188 = bitcast i32* %r2 to i480*
store i480 %r186, i480* %r188
%r189 = lshr i512 %r185, 480
%r190 = trunc i512 %r189 to i32
ret i32 %r190
}
define i32 @mclb_mulUnit16(i32* noalias  %r2, i32* noalias  %r3, i32 %r4)
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
%r193 = trunc i544 %r192 to i512
%r195 = bitcast i32* %r2 to i512*
store i512 %r193, i512* %r195
%r196 = lshr i544 %r192, 512
%r197 = trunc i544 %r196 to i32
ret i32 %r197
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
%r200 = bitcast i32* %r2 to i512*
store i512 %r198, i512* %r200
%r201 = lshr i544 %r197, 512
%r202 = trunc i544 %r201 to i32
ret i32 %r202
}
define i32 @mclb_mulUnit17(i32* noalias  %r2, i32* noalias  %r3, i32 %r4)
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
%r205 = trunc i576 %r204 to i544
%r207 = bitcast i32* %r2 to i544*
store i544 %r205, i544* %r207
%r208 = lshr i576 %r204, 544
%r209 = trunc i576 %r208 to i32
ret i32 %r209
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
%r212 = bitcast i32* %r2 to i544*
store i544 %r210, i544* %r212
%r213 = lshr i576 %r209, 544
%r214 = trunc i576 %r213 to i32
ret i32 %r214
}
