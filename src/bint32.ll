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
define i32 @mclb_add1(i32* noalias %r1, i32* noalias %r2, i32* noalias %r3)
{
%r5 = load i32, i32* %r2
%r6 = zext i32 %r5 to i64
%r7 = load i32, i32* %r3
%r8 = zext i32 %r7 to i64
%r9 = add i64 %r6, %r8
%r10 = trunc i64 %r9 to i32
store i32 %r10, i32* %r1
%r11 = lshr i64 %r9, 32
%r12 = trunc i64 %r11 to i32
ret i32 %r12
}
define i32 @mclb_sub1(i32* noalias %r1, i32* noalias %r2, i32* noalias %r3)
{
%r5 = load i32, i32* %r2
%r6 = zext i32 %r5 to i64
%r7 = load i32, i32* %r3
%r8 = zext i32 %r7 to i64
%r9 = sub i64 %r6, %r8
%r10 = trunc i64 %r9 to i32
store i32 %r10, i32* %r1
%r11 = lshr i64 %r9, 32
%r12 = trunc i64 %r11 to i32
%r13 = and i32 %r12, 1
ret i32 %r13
}
define void @mclb_addNF1(i32* noalias %r1, i32* noalias %r2, i32* noalias %r3)
{
%r4 = load i32, i32* %r2
%r5 = load i32, i32* %r3
%r6 = add i32 %r4, %r5
store i32 %r6, i32* %r1
ret void
}
define i32 @mclb_subNF1(i32* noalias %r1, i32* noalias %r2, i32* noalias %r3)
{
%r5 = load i32, i32* %r2
%r6 = load i32, i32* %r3
%r7 = sub i32 %r5, %r6
store i32 %r7, i32* %r1
%r8 = lshr i32 %r7, 31
%r9 = and i32 %r8, 1
ret i32 %r9
}
define i32 @mclb_add2(i32* noalias %r1, i32* noalias %r2, i32* noalias %r3)
{
%r5 = bitcast i32* %r2 to i64*
%r6 = load i64, i64* %r5
%r7 = zext i64 %r6 to i96
%r8 = bitcast i32* %r3 to i64*
%r9 = load i64, i64* %r8
%r10 = zext i64 %r9 to i96
%r11 = add i96 %r7, %r10
%r12 = trunc i96 %r11 to i64
%r13 = bitcast i32* %r1 to i64*
store i64 %r12, i64* %r13
%r14 = lshr i96 %r11, 64
%r15 = trunc i96 %r14 to i32
ret i32 %r15
}
define i32 @mclb_sub2(i32* noalias %r1, i32* noalias %r2, i32* noalias %r3)
{
%r5 = bitcast i32* %r2 to i64*
%r6 = load i64, i64* %r5
%r7 = zext i64 %r6 to i96
%r8 = bitcast i32* %r3 to i64*
%r9 = load i64, i64* %r8
%r10 = zext i64 %r9 to i96
%r11 = sub i96 %r7, %r10
%r12 = trunc i96 %r11 to i64
%r13 = bitcast i32* %r1 to i64*
store i64 %r12, i64* %r13
%r14 = lshr i96 %r11, 64
%r15 = trunc i96 %r14 to i32
%r16 = and i32 %r15, 1
ret i32 %r16
}
define void @mclb_addNF2(i32* noalias %r1, i32* noalias %r2, i32* noalias %r3)
{
%r4 = bitcast i32* %r2 to i64*
%r5 = load i64, i64* %r4
%r6 = bitcast i32* %r3 to i64*
%r7 = load i64, i64* %r6
%r8 = add i64 %r5, %r7
%r9 = bitcast i32* %r1 to i64*
store i64 %r8, i64* %r9
ret void
}
define i32 @mclb_subNF2(i32* noalias %r1, i32* noalias %r2, i32* noalias %r3)
{
%r5 = bitcast i32* %r2 to i64*
%r6 = load i64, i64* %r5
%r7 = bitcast i32* %r3 to i64*
%r8 = load i64, i64* %r7
%r9 = sub i64 %r6, %r8
%r10 = bitcast i32* %r1 to i64*
store i64 %r9, i64* %r10
%r11 = lshr i64 %r9, 63
%r12 = trunc i64 %r11 to i32
%r13 = and i32 %r12, 1
ret i32 %r13
}
define i32 @mclb_add3(i32* noalias %r1, i32* noalias %r2, i32* noalias %r3)
{
%r5 = bitcast i32* %r2 to i96*
%r6 = load i96, i96* %r5
%r7 = zext i96 %r6 to i128
%r8 = bitcast i32* %r3 to i96*
%r9 = load i96, i96* %r8
%r10 = zext i96 %r9 to i128
%r11 = add i128 %r7, %r10
%r12 = trunc i128 %r11 to i96
%r13 = bitcast i32* %r1 to i96*
store i96 %r12, i96* %r13
%r14 = lshr i128 %r11, 96
%r15 = trunc i128 %r14 to i32
ret i32 %r15
}
define i32 @mclb_sub3(i32* noalias %r1, i32* noalias %r2, i32* noalias %r3)
{
%r5 = bitcast i32* %r2 to i96*
%r6 = load i96, i96* %r5
%r7 = zext i96 %r6 to i128
%r8 = bitcast i32* %r3 to i96*
%r9 = load i96, i96* %r8
%r10 = zext i96 %r9 to i128
%r11 = sub i128 %r7, %r10
%r12 = trunc i128 %r11 to i96
%r13 = bitcast i32* %r1 to i96*
store i96 %r12, i96* %r13
%r14 = lshr i128 %r11, 96
%r15 = trunc i128 %r14 to i32
%r16 = and i32 %r15, 1
ret i32 %r16
}
define void @mclb_addNF3(i32* noalias %r1, i32* noalias %r2, i32* noalias %r3)
{
%r4 = bitcast i32* %r2 to i96*
%r5 = load i96, i96* %r4
%r6 = bitcast i32* %r3 to i96*
%r7 = load i96, i96* %r6
%r8 = add i96 %r5, %r7
%r9 = bitcast i32* %r1 to i96*
store i96 %r8, i96* %r9
ret void
}
define i32 @mclb_subNF3(i32* noalias %r1, i32* noalias %r2, i32* noalias %r3)
{
%r5 = bitcast i32* %r2 to i96*
%r6 = load i96, i96* %r5
%r7 = bitcast i32* %r3 to i96*
%r8 = load i96, i96* %r7
%r9 = sub i96 %r6, %r8
%r10 = bitcast i32* %r1 to i96*
store i96 %r9, i96* %r10
%r11 = lshr i96 %r9, 95
%r12 = trunc i96 %r11 to i32
%r13 = and i32 %r12, 1
ret i32 %r13
}
define i32 @mclb_add4(i32* noalias %r1, i32* noalias %r2, i32* noalias %r3)
{
%r5 = bitcast i32* %r2 to i128*
%r6 = load i128, i128* %r5
%r7 = zext i128 %r6 to i160
%r8 = bitcast i32* %r3 to i128*
%r9 = load i128, i128* %r8
%r10 = zext i128 %r9 to i160
%r11 = add i160 %r7, %r10
%r12 = trunc i160 %r11 to i128
%r13 = bitcast i32* %r1 to i128*
store i128 %r12, i128* %r13
%r14 = lshr i160 %r11, 128
%r15 = trunc i160 %r14 to i32
ret i32 %r15
}
define i32 @mclb_sub4(i32* noalias %r1, i32* noalias %r2, i32* noalias %r3)
{
%r5 = bitcast i32* %r2 to i128*
%r6 = load i128, i128* %r5
%r7 = zext i128 %r6 to i160
%r8 = bitcast i32* %r3 to i128*
%r9 = load i128, i128* %r8
%r10 = zext i128 %r9 to i160
%r11 = sub i160 %r7, %r10
%r12 = trunc i160 %r11 to i128
%r13 = bitcast i32* %r1 to i128*
store i128 %r12, i128* %r13
%r14 = lshr i160 %r11, 128
%r15 = trunc i160 %r14 to i32
%r16 = and i32 %r15, 1
ret i32 %r16
}
define void @mclb_addNF4(i32* noalias %r1, i32* noalias %r2, i32* noalias %r3)
{
%r4 = bitcast i32* %r2 to i128*
%r5 = load i128, i128* %r4
%r6 = bitcast i32* %r3 to i128*
%r7 = load i128, i128* %r6
%r8 = add i128 %r5, %r7
%r9 = bitcast i32* %r1 to i128*
store i128 %r8, i128* %r9
ret void
}
define i32 @mclb_subNF4(i32* noalias %r1, i32* noalias %r2, i32* noalias %r3)
{
%r5 = bitcast i32* %r2 to i128*
%r6 = load i128, i128* %r5
%r7 = bitcast i32* %r3 to i128*
%r8 = load i128, i128* %r7
%r9 = sub i128 %r6, %r8
%r10 = bitcast i32* %r1 to i128*
store i128 %r9, i128* %r10
%r11 = lshr i128 %r9, 127
%r12 = trunc i128 %r11 to i32
%r13 = and i32 %r12, 1
ret i32 %r13
}
define i32 @mclb_add5(i32* noalias %r1, i32* noalias %r2, i32* noalias %r3)
{
%r5 = bitcast i32* %r2 to i160*
%r6 = load i160, i160* %r5
%r7 = zext i160 %r6 to i192
%r8 = bitcast i32* %r3 to i160*
%r9 = load i160, i160* %r8
%r10 = zext i160 %r9 to i192
%r11 = add i192 %r7, %r10
%r12 = trunc i192 %r11 to i160
%r13 = bitcast i32* %r1 to i160*
store i160 %r12, i160* %r13
%r14 = lshr i192 %r11, 160
%r15 = trunc i192 %r14 to i32
ret i32 %r15
}
define i32 @mclb_sub5(i32* noalias %r1, i32* noalias %r2, i32* noalias %r3)
{
%r5 = bitcast i32* %r2 to i160*
%r6 = load i160, i160* %r5
%r7 = zext i160 %r6 to i192
%r8 = bitcast i32* %r3 to i160*
%r9 = load i160, i160* %r8
%r10 = zext i160 %r9 to i192
%r11 = sub i192 %r7, %r10
%r12 = trunc i192 %r11 to i160
%r13 = bitcast i32* %r1 to i160*
store i160 %r12, i160* %r13
%r14 = lshr i192 %r11, 160
%r15 = trunc i192 %r14 to i32
%r16 = and i32 %r15, 1
ret i32 %r16
}
define void @mclb_addNF5(i32* noalias %r1, i32* noalias %r2, i32* noalias %r3)
{
%r4 = bitcast i32* %r2 to i160*
%r5 = load i160, i160* %r4
%r6 = bitcast i32* %r3 to i160*
%r7 = load i160, i160* %r6
%r8 = add i160 %r5, %r7
%r9 = bitcast i32* %r1 to i160*
store i160 %r8, i160* %r9
ret void
}
define i32 @mclb_subNF5(i32* noalias %r1, i32* noalias %r2, i32* noalias %r3)
{
%r5 = bitcast i32* %r2 to i160*
%r6 = load i160, i160* %r5
%r7 = bitcast i32* %r3 to i160*
%r8 = load i160, i160* %r7
%r9 = sub i160 %r6, %r8
%r10 = bitcast i32* %r1 to i160*
store i160 %r9, i160* %r10
%r11 = lshr i160 %r9, 159
%r12 = trunc i160 %r11 to i32
%r13 = and i32 %r12, 1
ret i32 %r13
}
define i32 @mclb_add6(i32* noalias %r1, i32* noalias %r2, i32* noalias %r3)
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
define i32 @mclb_sub6(i32* noalias %r1, i32* noalias %r2, i32* noalias %r3)
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
define void @mclb_addNF6(i32* noalias %r1, i32* noalias %r2, i32* noalias %r3)
{
%r4 = bitcast i32* %r2 to i192*
%r5 = load i192, i192* %r4
%r6 = bitcast i32* %r3 to i192*
%r7 = load i192, i192* %r6
%r8 = add i192 %r5, %r7
%r9 = bitcast i32* %r1 to i192*
store i192 %r8, i192* %r9
ret void
}
define i32 @mclb_subNF6(i32* noalias %r1, i32* noalias %r2, i32* noalias %r3)
{
%r5 = bitcast i32* %r2 to i192*
%r6 = load i192, i192* %r5
%r7 = bitcast i32* %r3 to i192*
%r8 = load i192, i192* %r7
%r9 = sub i192 %r6, %r8
%r10 = bitcast i32* %r1 to i192*
store i192 %r9, i192* %r10
%r11 = lshr i192 %r9, 191
%r12 = trunc i192 %r11 to i32
%r13 = and i32 %r12, 1
ret i32 %r13
}
define i32 @mclb_add7(i32* noalias %r1, i32* noalias %r2, i32* noalias %r3)
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
define i32 @mclb_sub7(i32* noalias %r1, i32* noalias %r2, i32* noalias %r3)
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
define void @mclb_addNF7(i32* noalias %r1, i32* noalias %r2, i32* noalias %r3)
{
%r4 = bitcast i32* %r2 to i224*
%r5 = load i224, i224* %r4
%r6 = bitcast i32* %r3 to i224*
%r7 = load i224, i224* %r6
%r8 = add i224 %r5, %r7
%r9 = bitcast i32* %r1 to i224*
store i224 %r8, i224* %r9
ret void
}
define i32 @mclb_subNF7(i32* noalias %r1, i32* noalias %r2, i32* noalias %r3)
{
%r5 = bitcast i32* %r2 to i224*
%r6 = load i224, i224* %r5
%r7 = bitcast i32* %r3 to i224*
%r8 = load i224, i224* %r7
%r9 = sub i224 %r6, %r8
%r10 = bitcast i32* %r1 to i224*
store i224 %r9, i224* %r10
%r11 = lshr i224 %r9, 223
%r12 = trunc i224 %r11 to i32
%r13 = and i32 %r12, 1
ret i32 %r13
}
define i32 @mclb_add8(i32* noalias %r1, i32* noalias %r2, i32* noalias %r3)
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
define i32 @mclb_sub8(i32* noalias %r1, i32* noalias %r2, i32* noalias %r3)
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
define void @mclb_addNF8(i32* noalias %r1, i32* noalias %r2, i32* noalias %r3)
{
%r4 = bitcast i32* %r2 to i256*
%r5 = load i256, i256* %r4
%r6 = bitcast i32* %r3 to i256*
%r7 = load i256, i256* %r6
%r8 = add i256 %r5, %r7
%r9 = bitcast i32* %r1 to i256*
store i256 %r8, i256* %r9
ret void
}
define i32 @mclb_subNF8(i32* noalias %r1, i32* noalias %r2, i32* noalias %r3)
{
%r5 = bitcast i32* %r2 to i256*
%r6 = load i256, i256* %r5
%r7 = bitcast i32* %r3 to i256*
%r8 = load i256, i256* %r7
%r9 = sub i256 %r6, %r8
%r10 = bitcast i32* %r1 to i256*
store i256 %r9, i256* %r10
%r11 = lshr i256 %r9, 255
%r12 = trunc i256 %r11 to i32
%r13 = and i32 %r12, 1
ret i32 %r13
}
define i32 @mclb_add9(i32* noalias %r1, i32* noalias %r2, i32* noalias %r3)
{
%r5 = bitcast i32* %r2 to i288*
%r6 = load i288, i288* %r5
%r7 = zext i288 %r6 to i320
%r8 = bitcast i32* %r3 to i288*
%r9 = load i288, i288* %r8
%r10 = zext i288 %r9 to i320
%r11 = add i320 %r7, %r10
%r12 = trunc i320 %r11 to i288
%r13 = bitcast i32* %r1 to i288*
store i288 %r12, i288* %r13
%r14 = lshr i320 %r11, 288
%r15 = trunc i320 %r14 to i32
ret i32 %r15
}
define i32 @mclb_sub9(i32* noalias %r1, i32* noalias %r2, i32* noalias %r3)
{
%r5 = bitcast i32* %r2 to i288*
%r6 = load i288, i288* %r5
%r7 = zext i288 %r6 to i320
%r8 = bitcast i32* %r3 to i288*
%r9 = load i288, i288* %r8
%r10 = zext i288 %r9 to i320
%r11 = sub i320 %r7, %r10
%r12 = trunc i320 %r11 to i288
%r13 = bitcast i32* %r1 to i288*
store i288 %r12, i288* %r13
%r14 = lshr i320 %r11, 288
%r15 = trunc i320 %r14 to i32
%r16 = and i32 %r15, 1
ret i32 %r16
}
define void @mclb_addNF9(i32* noalias %r1, i32* noalias %r2, i32* noalias %r3)
{
%r4 = bitcast i32* %r2 to i288*
%r5 = load i288, i288* %r4
%r6 = bitcast i32* %r3 to i288*
%r7 = load i288, i288* %r6
%r8 = add i288 %r5, %r7
%r9 = bitcast i32* %r1 to i288*
store i288 %r8, i288* %r9
ret void
}
define i32 @mclb_subNF9(i32* noalias %r1, i32* noalias %r2, i32* noalias %r3)
{
%r5 = bitcast i32* %r2 to i288*
%r6 = load i288, i288* %r5
%r7 = bitcast i32* %r3 to i288*
%r8 = load i288, i288* %r7
%r9 = sub i288 %r6, %r8
%r10 = bitcast i32* %r1 to i288*
store i288 %r9, i288* %r10
%r11 = lshr i288 %r9, 287
%r12 = trunc i288 %r11 to i32
%r13 = and i32 %r12, 1
ret i32 %r13
}
define i32 @mclb_add10(i32* noalias %r1, i32* noalias %r2, i32* noalias %r3)
{
%r5 = bitcast i32* %r2 to i320*
%r6 = load i320, i320* %r5
%r7 = zext i320 %r6 to i352
%r8 = bitcast i32* %r3 to i320*
%r9 = load i320, i320* %r8
%r10 = zext i320 %r9 to i352
%r11 = add i352 %r7, %r10
%r12 = trunc i352 %r11 to i320
%r13 = bitcast i32* %r1 to i320*
store i320 %r12, i320* %r13
%r14 = lshr i352 %r11, 320
%r15 = trunc i352 %r14 to i32
ret i32 %r15
}
define i32 @mclb_sub10(i32* noalias %r1, i32* noalias %r2, i32* noalias %r3)
{
%r5 = bitcast i32* %r2 to i320*
%r6 = load i320, i320* %r5
%r7 = zext i320 %r6 to i352
%r8 = bitcast i32* %r3 to i320*
%r9 = load i320, i320* %r8
%r10 = zext i320 %r9 to i352
%r11 = sub i352 %r7, %r10
%r12 = trunc i352 %r11 to i320
%r13 = bitcast i32* %r1 to i320*
store i320 %r12, i320* %r13
%r14 = lshr i352 %r11, 320
%r15 = trunc i352 %r14 to i32
%r16 = and i32 %r15, 1
ret i32 %r16
}
define void @mclb_addNF10(i32* noalias %r1, i32* noalias %r2, i32* noalias %r3)
{
%r4 = bitcast i32* %r2 to i320*
%r5 = load i320, i320* %r4
%r6 = bitcast i32* %r3 to i320*
%r7 = load i320, i320* %r6
%r8 = add i320 %r5, %r7
%r9 = bitcast i32* %r1 to i320*
store i320 %r8, i320* %r9
ret void
}
define i32 @mclb_subNF10(i32* noalias %r1, i32* noalias %r2, i32* noalias %r3)
{
%r5 = bitcast i32* %r2 to i320*
%r6 = load i320, i320* %r5
%r7 = bitcast i32* %r3 to i320*
%r8 = load i320, i320* %r7
%r9 = sub i320 %r6, %r8
%r10 = bitcast i32* %r1 to i320*
store i320 %r9, i320* %r10
%r11 = lshr i320 %r9, 319
%r12 = trunc i320 %r11 to i32
%r13 = and i32 %r12, 1
ret i32 %r13
}
define i32 @mclb_add11(i32* noalias %r1, i32* noalias %r2, i32* noalias %r3)
{
%r5 = bitcast i32* %r2 to i352*
%r6 = load i352, i352* %r5
%r7 = zext i352 %r6 to i384
%r8 = bitcast i32* %r3 to i352*
%r9 = load i352, i352* %r8
%r10 = zext i352 %r9 to i384
%r11 = add i384 %r7, %r10
%r12 = trunc i384 %r11 to i352
%r13 = bitcast i32* %r1 to i352*
store i352 %r12, i352* %r13
%r14 = lshr i384 %r11, 352
%r15 = trunc i384 %r14 to i32
ret i32 %r15
}
define i32 @mclb_sub11(i32* noalias %r1, i32* noalias %r2, i32* noalias %r3)
{
%r5 = bitcast i32* %r2 to i352*
%r6 = load i352, i352* %r5
%r7 = zext i352 %r6 to i384
%r8 = bitcast i32* %r3 to i352*
%r9 = load i352, i352* %r8
%r10 = zext i352 %r9 to i384
%r11 = sub i384 %r7, %r10
%r12 = trunc i384 %r11 to i352
%r13 = bitcast i32* %r1 to i352*
store i352 %r12, i352* %r13
%r14 = lshr i384 %r11, 352
%r15 = trunc i384 %r14 to i32
%r16 = and i32 %r15, 1
ret i32 %r16
}
define void @mclb_addNF11(i32* noalias %r1, i32* noalias %r2, i32* noalias %r3)
{
%r4 = bitcast i32* %r2 to i352*
%r5 = load i352, i352* %r4
%r6 = bitcast i32* %r3 to i352*
%r7 = load i352, i352* %r6
%r8 = add i352 %r5, %r7
%r9 = bitcast i32* %r1 to i352*
store i352 %r8, i352* %r9
ret void
}
define i32 @mclb_subNF11(i32* noalias %r1, i32* noalias %r2, i32* noalias %r3)
{
%r5 = bitcast i32* %r2 to i352*
%r6 = load i352, i352* %r5
%r7 = bitcast i32* %r3 to i352*
%r8 = load i352, i352* %r7
%r9 = sub i352 %r6, %r8
%r10 = bitcast i32* %r1 to i352*
store i352 %r9, i352* %r10
%r11 = lshr i352 %r9, 351
%r12 = trunc i352 %r11 to i32
%r13 = and i32 %r12, 1
ret i32 %r13
}
define i32 @mclb_add12(i32* noalias %r1, i32* noalias %r2, i32* noalias %r3)
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
define i32 @mclb_sub12(i32* noalias %r1, i32* noalias %r2, i32* noalias %r3)
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
define void @mclb_addNF12(i32* noalias %r1, i32* noalias %r2, i32* noalias %r3)
{
%r4 = bitcast i32* %r2 to i384*
%r5 = load i384, i384* %r4
%r6 = bitcast i32* %r3 to i384*
%r7 = load i384, i384* %r6
%r8 = add i384 %r5, %r7
%r9 = bitcast i32* %r1 to i384*
store i384 %r8, i384* %r9
ret void
}
define i32 @mclb_subNF12(i32* noalias %r1, i32* noalias %r2, i32* noalias %r3)
{
%r5 = bitcast i32* %r2 to i384*
%r6 = load i384, i384* %r5
%r7 = bitcast i32* %r3 to i384*
%r8 = load i384, i384* %r7
%r9 = sub i384 %r6, %r8
%r10 = bitcast i32* %r1 to i384*
store i384 %r9, i384* %r10
%r11 = lshr i384 %r9, 383
%r12 = trunc i384 %r11 to i32
%r13 = and i32 %r12, 1
ret i32 %r13
}
define i32 @mclb_add13(i32* noalias %r1, i32* noalias %r2, i32* noalias %r3)
{
%r5 = bitcast i32* %r2 to i416*
%r6 = load i416, i416* %r5
%r7 = zext i416 %r6 to i448
%r8 = bitcast i32* %r3 to i416*
%r9 = load i416, i416* %r8
%r10 = zext i416 %r9 to i448
%r11 = add i448 %r7, %r10
%r12 = trunc i448 %r11 to i416
%r13 = bitcast i32* %r1 to i416*
store i416 %r12, i416* %r13
%r14 = lshr i448 %r11, 416
%r15 = trunc i448 %r14 to i32
ret i32 %r15
}
define i32 @mclb_sub13(i32* noalias %r1, i32* noalias %r2, i32* noalias %r3)
{
%r5 = bitcast i32* %r2 to i416*
%r6 = load i416, i416* %r5
%r7 = zext i416 %r6 to i448
%r8 = bitcast i32* %r3 to i416*
%r9 = load i416, i416* %r8
%r10 = zext i416 %r9 to i448
%r11 = sub i448 %r7, %r10
%r12 = trunc i448 %r11 to i416
%r13 = bitcast i32* %r1 to i416*
store i416 %r12, i416* %r13
%r14 = lshr i448 %r11, 416
%r15 = trunc i448 %r14 to i32
%r16 = and i32 %r15, 1
ret i32 %r16
}
define void @mclb_addNF13(i32* noalias %r1, i32* noalias %r2, i32* noalias %r3)
{
%r4 = bitcast i32* %r2 to i416*
%r5 = load i416, i416* %r4
%r6 = bitcast i32* %r3 to i416*
%r7 = load i416, i416* %r6
%r8 = add i416 %r5, %r7
%r9 = bitcast i32* %r1 to i416*
store i416 %r8, i416* %r9
ret void
}
define i32 @mclb_subNF13(i32* noalias %r1, i32* noalias %r2, i32* noalias %r3)
{
%r5 = bitcast i32* %r2 to i416*
%r6 = load i416, i416* %r5
%r7 = bitcast i32* %r3 to i416*
%r8 = load i416, i416* %r7
%r9 = sub i416 %r6, %r8
%r10 = bitcast i32* %r1 to i416*
store i416 %r9, i416* %r10
%r11 = lshr i416 %r9, 415
%r12 = trunc i416 %r11 to i32
%r13 = and i32 %r12, 1
ret i32 %r13
}
define i32 @mclb_add14(i32* noalias %r1, i32* noalias %r2, i32* noalias %r3)
{
%r5 = bitcast i32* %r2 to i448*
%r6 = load i448, i448* %r5
%r7 = zext i448 %r6 to i480
%r8 = bitcast i32* %r3 to i448*
%r9 = load i448, i448* %r8
%r10 = zext i448 %r9 to i480
%r11 = add i480 %r7, %r10
%r12 = trunc i480 %r11 to i448
%r13 = bitcast i32* %r1 to i448*
store i448 %r12, i448* %r13
%r14 = lshr i480 %r11, 448
%r15 = trunc i480 %r14 to i32
ret i32 %r15
}
define i32 @mclb_sub14(i32* noalias %r1, i32* noalias %r2, i32* noalias %r3)
{
%r5 = bitcast i32* %r2 to i448*
%r6 = load i448, i448* %r5
%r7 = zext i448 %r6 to i480
%r8 = bitcast i32* %r3 to i448*
%r9 = load i448, i448* %r8
%r10 = zext i448 %r9 to i480
%r11 = sub i480 %r7, %r10
%r12 = trunc i480 %r11 to i448
%r13 = bitcast i32* %r1 to i448*
store i448 %r12, i448* %r13
%r14 = lshr i480 %r11, 448
%r15 = trunc i480 %r14 to i32
%r16 = and i32 %r15, 1
ret i32 %r16
}
define void @mclb_addNF14(i32* noalias %r1, i32* noalias %r2, i32* noalias %r3)
{
%r4 = bitcast i32* %r2 to i448*
%r5 = load i448, i448* %r4
%r6 = bitcast i32* %r3 to i448*
%r7 = load i448, i448* %r6
%r8 = add i448 %r5, %r7
%r9 = bitcast i32* %r1 to i448*
store i448 %r8, i448* %r9
ret void
}
define i32 @mclb_subNF14(i32* noalias %r1, i32* noalias %r2, i32* noalias %r3)
{
%r5 = bitcast i32* %r2 to i448*
%r6 = load i448, i448* %r5
%r7 = bitcast i32* %r3 to i448*
%r8 = load i448, i448* %r7
%r9 = sub i448 %r6, %r8
%r10 = bitcast i32* %r1 to i448*
store i448 %r9, i448* %r10
%r11 = lshr i448 %r9, 447
%r12 = trunc i448 %r11 to i32
%r13 = and i32 %r12, 1
ret i32 %r13
}
define i32 @mclb_add15(i32* noalias %r1, i32* noalias %r2, i32* noalias %r3)
{
%r5 = bitcast i32* %r2 to i480*
%r6 = load i480, i480* %r5
%r7 = zext i480 %r6 to i512
%r8 = bitcast i32* %r3 to i480*
%r9 = load i480, i480* %r8
%r10 = zext i480 %r9 to i512
%r11 = add i512 %r7, %r10
%r12 = trunc i512 %r11 to i480
%r13 = bitcast i32* %r1 to i480*
store i480 %r12, i480* %r13
%r14 = lshr i512 %r11, 480
%r15 = trunc i512 %r14 to i32
ret i32 %r15
}
define i32 @mclb_sub15(i32* noalias %r1, i32* noalias %r2, i32* noalias %r3)
{
%r5 = bitcast i32* %r2 to i480*
%r6 = load i480, i480* %r5
%r7 = zext i480 %r6 to i512
%r8 = bitcast i32* %r3 to i480*
%r9 = load i480, i480* %r8
%r10 = zext i480 %r9 to i512
%r11 = sub i512 %r7, %r10
%r12 = trunc i512 %r11 to i480
%r13 = bitcast i32* %r1 to i480*
store i480 %r12, i480* %r13
%r14 = lshr i512 %r11, 480
%r15 = trunc i512 %r14 to i32
%r16 = and i32 %r15, 1
ret i32 %r16
}
define void @mclb_addNF15(i32* noalias %r1, i32* noalias %r2, i32* noalias %r3)
{
%r4 = bitcast i32* %r2 to i480*
%r5 = load i480, i480* %r4
%r6 = bitcast i32* %r3 to i480*
%r7 = load i480, i480* %r6
%r8 = add i480 %r5, %r7
%r9 = bitcast i32* %r1 to i480*
store i480 %r8, i480* %r9
ret void
}
define i32 @mclb_subNF15(i32* noalias %r1, i32* noalias %r2, i32* noalias %r3)
{
%r5 = bitcast i32* %r2 to i480*
%r6 = load i480, i480* %r5
%r7 = bitcast i32* %r3 to i480*
%r8 = load i480, i480* %r7
%r9 = sub i480 %r6, %r8
%r10 = bitcast i32* %r1 to i480*
store i480 %r9, i480* %r10
%r11 = lshr i480 %r9, 479
%r12 = trunc i480 %r11 to i32
%r13 = and i32 %r12, 1
ret i32 %r13
}
define i32 @mclb_add16(i32* noalias %r1, i32* noalias %r2, i32* noalias %r3)
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
define i32 @mclb_sub16(i32* noalias %r1, i32* noalias %r2, i32* noalias %r3)
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
define void @mclb_addNF16(i32* noalias %r1, i32* noalias %r2, i32* noalias %r3)
{
%r4 = bitcast i32* %r2 to i512*
%r5 = load i512, i512* %r4
%r6 = bitcast i32* %r3 to i512*
%r7 = load i512, i512* %r6
%r8 = add i512 %r5, %r7
%r9 = bitcast i32* %r1 to i512*
store i512 %r8, i512* %r9
ret void
}
define i32 @mclb_subNF16(i32* noalias %r1, i32* noalias %r2, i32* noalias %r3)
{
%r5 = bitcast i32* %r2 to i512*
%r6 = load i512, i512* %r5
%r7 = bitcast i32* %r3 to i512*
%r8 = load i512, i512* %r7
%r9 = sub i512 %r6, %r8
%r10 = bitcast i32* %r1 to i512*
store i512 %r9, i512* %r10
%r11 = lshr i512 %r9, 511
%r12 = trunc i512 %r11 to i32
%r13 = and i32 %r12, 1
ret i32 %r13
}
define i32 @mclb_add17(i32* noalias %r1, i32* noalias %r2, i32* noalias %r3)
{
%r5 = bitcast i32* %r2 to i544*
%r6 = load i544, i544* %r5
%r7 = zext i544 %r6 to i576
%r8 = bitcast i32* %r3 to i544*
%r9 = load i544, i544* %r8
%r10 = zext i544 %r9 to i576
%r11 = add i576 %r7, %r10
%r12 = trunc i576 %r11 to i544
%r13 = bitcast i32* %r1 to i544*
store i544 %r12, i544* %r13
%r14 = lshr i576 %r11, 544
%r15 = trunc i576 %r14 to i32
ret i32 %r15
}
define i32 @mclb_sub17(i32* noalias %r1, i32* noalias %r2, i32* noalias %r3)
{
%r5 = bitcast i32* %r2 to i544*
%r6 = load i544, i544* %r5
%r7 = zext i544 %r6 to i576
%r8 = bitcast i32* %r3 to i544*
%r9 = load i544, i544* %r8
%r10 = zext i544 %r9 to i576
%r11 = sub i576 %r7, %r10
%r12 = trunc i576 %r11 to i544
%r13 = bitcast i32* %r1 to i544*
store i544 %r12, i544* %r13
%r14 = lshr i576 %r11, 544
%r15 = trunc i576 %r14 to i32
%r16 = and i32 %r15, 1
ret i32 %r16
}
define void @mclb_addNF17(i32* noalias %r1, i32* noalias %r2, i32* noalias %r3)
{
%r4 = bitcast i32* %r2 to i544*
%r5 = load i544, i544* %r4
%r6 = bitcast i32* %r3 to i544*
%r7 = load i544, i544* %r6
%r8 = add i544 %r5, %r7
%r9 = bitcast i32* %r1 to i544*
store i544 %r8, i544* %r9
ret void
}
define i32 @mclb_subNF17(i32* noalias %r1, i32* noalias %r2, i32* noalias %r3)
{
%r5 = bitcast i32* %r2 to i544*
%r6 = load i544, i544* %r5
%r7 = bitcast i32* %r3 to i544*
%r8 = load i544, i544* %r7
%r9 = sub i544 %r6, %r8
%r10 = bitcast i32* %r1 to i544*
store i544 %r9, i544* %r10
%r11 = lshr i544 %r9, 543
%r12 = trunc i544 %r11 to i32
%r13 = and i32 %r12, 1
ret i32 %r13
}
define i32 @mclb_add18(i32* noalias %r1, i32* noalias %r2, i32* noalias %r3)
{
%r5 = bitcast i32* %r2 to i576*
%r6 = load i576, i576* %r5
%r7 = zext i576 %r6 to i608
%r8 = bitcast i32* %r3 to i576*
%r9 = load i576, i576* %r8
%r10 = zext i576 %r9 to i608
%r11 = add i608 %r7, %r10
%r12 = trunc i608 %r11 to i576
%r13 = bitcast i32* %r1 to i576*
store i576 %r12, i576* %r13
%r14 = lshr i608 %r11, 576
%r15 = trunc i608 %r14 to i32
ret i32 %r15
}
define i32 @mclb_sub18(i32* noalias %r1, i32* noalias %r2, i32* noalias %r3)
{
%r5 = bitcast i32* %r2 to i576*
%r6 = load i576, i576* %r5
%r7 = zext i576 %r6 to i608
%r8 = bitcast i32* %r3 to i576*
%r9 = load i576, i576* %r8
%r10 = zext i576 %r9 to i608
%r11 = sub i608 %r7, %r10
%r12 = trunc i608 %r11 to i576
%r13 = bitcast i32* %r1 to i576*
store i576 %r12, i576* %r13
%r14 = lshr i608 %r11, 576
%r15 = trunc i608 %r14 to i32
%r16 = and i32 %r15, 1
ret i32 %r16
}
define void @mclb_addNF18(i32* noalias %r1, i32* noalias %r2, i32* noalias %r3)
{
%r4 = bitcast i32* %r2 to i576*
%r5 = load i576, i576* %r4
%r6 = bitcast i32* %r3 to i576*
%r7 = load i576, i576* %r6
%r8 = add i576 %r5, %r7
%r9 = bitcast i32* %r1 to i576*
store i576 %r8, i576* %r9
ret void
}
define i32 @mclb_subNF18(i32* noalias %r1, i32* noalias %r2, i32* noalias %r3)
{
%r5 = bitcast i32* %r2 to i576*
%r6 = load i576, i576* %r5
%r7 = bitcast i32* %r3 to i576*
%r8 = load i576, i576* %r7
%r9 = sub i576 %r6, %r8
%r10 = bitcast i32* %r1 to i576*
store i576 %r9, i576* %r10
%r11 = lshr i576 %r9, 575
%r12 = trunc i576 %r11 to i32
%r13 = and i32 %r12, 1
ret i32 %r13
}
define i32 @mclb_add19(i32* noalias %r1, i32* noalias %r2, i32* noalias %r3)
{
%r5 = bitcast i32* %r2 to i608*
%r6 = load i608, i608* %r5
%r7 = zext i608 %r6 to i640
%r8 = bitcast i32* %r3 to i608*
%r9 = load i608, i608* %r8
%r10 = zext i608 %r9 to i640
%r11 = add i640 %r7, %r10
%r12 = trunc i640 %r11 to i608
%r13 = bitcast i32* %r1 to i608*
store i608 %r12, i608* %r13
%r14 = lshr i640 %r11, 608
%r15 = trunc i640 %r14 to i32
ret i32 %r15
}
define i32 @mclb_sub19(i32* noalias %r1, i32* noalias %r2, i32* noalias %r3)
{
%r5 = bitcast i32* %r2 to i608*
%r6 = load i608, i608* %r5
%r7 = zext i608 %r6 to i640
%r8 = bitcast i32* %r3 to i608*
%r9 = load i608, i608* %r8
%r10 = zext i608 %r9 to i640
%r11 = sub i640 %r7, %r10
%r12 = trunc i640 %r11 to i608
%r13 = bitcast i32* %r1 to i608*
store i608 %r12, i608* %r13
%r14 = lshr i640 %r11, 608
%r15 = trunc i640 %r14 to i32
%r16 = and i32 %r15, 1
ret i32 %r16
}
define void @mclb_addNF19(i32* noalias %r1, i32* noalias %r2, i32* noalias %r3)
{
%r4 = bitcast i32* %r2 to i608*
%r5 = load i608, i608* %r4
%r6 = bitcast i32* %r3 to i608*
%r7 = load i608, i608* %r6
%r8 = add i608 %r5, %r7
%r9 = bitcast i32* %r1 to i608*
store i608 %r8, i608* %r9
ret void
}
define i32 @mclb_subNF19(i32* noalias %r1, i32* noalias %r2, i32* noalias %r3)
{
%r5 = bitcast i32* %r2 to i608*
%r6 = load i608, i608* %r5
%r7 = bitcast i32* %r3 to i608*
%r8 = load i608, i608* %r7
%r9 = sub i608 %r6, %r8
%r10 = bitcast i32* %r1 to i608*
store i608 %r9, i608* %r10
%r11 = lshr i608 %r9, 607
%r12 = trunc i608 %r11 to i32
%r13 = and i32 %r12, 1
ret i32 %r13
}
define i32 @mclb_add20(i32* noalias %r1, i32* noalias %r2, i32* noalias %r3)
{
%r5 = bitcast i32* %r2 to i640*
%r6 = load i640, i640* %r5
%r7 = zext i640 %r6 to i672
%r8 = bitcast i32* %r3 to i640*
%r9 = load i640, i640* %r8
%r10 = zext i640 %r9 to i672
%r11 = add i672 %r7, %r10
%r12 = trunc i672 %r11 to i640
%r13 = bitcast i32* %r1 to i640*
store i640 %r12, i640* %r13
%r14 = lshr i672 %r11, 640
%r15 = trunc i672 %r14 to i32
ret i32 %r15
}
define i32 @mclb_sub20(i32* noalias %r1, i32* noalias %r2, i32* noalias %r3)
{
%r5 = bitcast i32* %r2 to i640*
%r6 = load i640, i640* %r5
%r7 = zext i640 %r6 to i672
%r8 = bitcast i32* %r3 to i640*
%r9 = load i640, i640* %r8
%r10 = zext i640 %r9 to i672
%r11 = sub i672 %r7, %r10
%r12 = trunc i672 %r11 to i640
%r13 = bitcast i32* %r1 to i640*
store i640 %r12, i640* %r13
%r14 = lshr i672 %r11, 640
%r15 = trunc i672 %r14 to i32
%r16 = and i32 %r15, 1
ret i32 %r16
}
define void @mclb_addNF20(i32* noalias %r1, i32* noalias %r2, i32* noalias %r3)
{
%r4 = bitcast i32* %r2 to i640*
%r5 = load i640, i640* %r4
%r6 = bitcast i32* %r3 to i640*
%r7 = load i640, i640* %r6
%r8 = add i640 %r5, %r7
%r9 = bitcast i32* %r1 to i640*
store i640 %r8, i640* %r9
ret void
}
define i32 @mclb_subNF20(i32* noalias %r1, i32* noalias %r2, i32* noalias %r3)
{
%r5 = bitcast i32* %r2 to i640*
%r6 = load i640, i640* %r5
%r7 = bitcast i32* %r3 to i640*
%r8 = load i640, i640* %r7
%r9 = sub i640 %r6, %r8
%r10 = bitcast i32* %r1 to i640*
store i640 %r9, i640* %r10
%r11 = lshr i640 %r9, 639
%r12 = trunc i640 %r11 to i32
%r13 = and i32 %r12, 1
ret i32 %r13
}
define i32 @mclb_add21(i32* noalias %r1, i32* noalias %r2, i32* noalias %r3)
{
%r5 = bitcast i32* %r2 to i672*
%r6 = load i672, i672* %r5
%r7 = zext i672 %r6 to i704
%r8 = bitcast i32* %r3 to i672*
%r9 = load i672, i672* %r8
%r10 = zext i672 %r9 to i704
%r11 = add i704 %r7, %r10
%r12 = trunc i704 %r11 to i672
%r13 = bitcast i32* %r1 to i672*
store i672 %r12, i672* %r13
%r14 = lshr i704 %r11, 672
%r15 = trunc i704 %r14 to i32
ret i32 %r15
}
define i32 @mclb_sub21(i32* noalias %r1, i32* noalias %r2, i32* noalias %r3)
{
%r5 = bitcast i32* %r2 to i672*
%r6 = load i672, i672* %r5
%r7 = zext i672 %r6 to i704
%r8 = bitcast i32* %r3 to i672*
%r9 = load i672, i672* %r8
%r10 = zext i672 %r9 to i704
%r11 = sub i704 %r7, %r10
%r12 = trunc i704 %r11 to i672
%r13 = bitcast i32* %r1 to i672*
store i672 %r12, i672* %r13
%r14 = lshr i704 %r11, 672
%r15 = trunc i704 %r14 to i32
%r16 = and i32 %r15, 1
ret i32 %r16
}
define void @mclb_addNF21(i32* noalias %r1, i32* noalias %r2, i32* noalias %r3)
{
%r4 = bitcast i32* %r2 to i672*
%r5 = load i672, i672* %r4
%r6 = bitcast i32* %r3 to i672*
%r7 = load i672, i672* %r6
%r8 = add i672 %r5, %r7
%r9 = bitcast i32* %r1 to i672*
store i672 %r8, i672* %r9
ret void
}
define i32 @mclb_subNF21(i32* noalias %r1, i32* noalias %r2, i32* noalias %r3)
{
%r5 = bitcast i32* %r2 to i672*
%r6 = load i672, i672* %r5
%r7 = bitcast i32* %r3 to i672*
%r8 = load i672, i672* %r7
%r9 = sub i672 %r6, %r8
%r10 = bitcast i32* %r1 to i672*
store i672 %r9, i672* %r10
%r11 = lshr i672 %r9, 671
%r12 = trunc i672 %r11 to i32
%r13 = and i32 %r12, 1
ret i32 %r13
}
define i32 @mclb_add22(i32* noalias %r1, i32* noalias %r2, i32* noalias %r3)
{
%r5 = bitcast i32* %r2 to i704*
%r6 = load i704, i704* %r5
%r7 = zext i704 %r6 to i736
%r8 = bitcast i32* %r3 to i704*
%r9 = load i704, i704* %r8
%r10 = zext i704 %r9 to i736
%r11 = add i736 %r7, %r10
%r12 = trunc i736 %r11 to i704
%r13 = bitcast i32* %r1 to i704*
store i704 %r12, i704* %r13
%r14 = lshr i736 %r11, 704
%r15 = trunc i736 %r14 to i32
ret i32 %r15
}
define i32 @mclb_sub22(i32* noalias %r1, i32* noalias %r2, i32* noalias %r3)
{
%r5 = bitcast i32* %r2 to i704*
%r6 = load i704, i704* %r5
%r7 = zext i704 %r6 to i736
%r8 = bitcast i32* %r3 to i704*
%r9 = load i704, i704* %r8
%r10 = zext i704 %r9 to i736
%r11 = sub i736 %r7, %r10
%r12 = trunc i736 %r11 to i704
%r13 = bitcast i32* %r1 to i704*
store i704 %r12, i704* %r13
%r14 = lshr i736 %r11, 704
%r15 = trunc i736 %r14 to i32
%r16 = and i32 %r15, 1
ret i32 %r16
}
define void @mclb_addNF22(i32* noalias %r1, i32* noalias %r2, i32* noalias %r3)
{
%r4 = bitcast i32* %r2 to i704*
%r5 = load i704, i704* %r4
%r6 = bitcast i32* %r3 to i704*
%r7 = load i704, i704* %r6
%r8 = add i704 %r5, %r7
%r9 = bitcast i32* %r1 to i704*
store i704 %r8, i704* %r9
ret void
}
define i32 @mclb_subNF22(i32* noalias %r1, i32* noalias %r2, i32* noalias %r3)
{
%r5 = bitcast i32* %r2 to i704*
%r6 = load i704, i704* %r5
%r7 = bitcast i32* %r3 to i704*
%r8 = load i704, i704* %r7
%r9 = sub i704 %r6, %r8
%r10 = bitcast i32* %r1 to i704*
store i704 %r9, i704* %r10
%r11 = lshr i704 %r9, 703
%r12 = trunc i704 %r11 to i32
%r13 = and i32 %r12, 1
ret i32 %r13
}
define i32 @mclb_add23(i32* noalias %r1, i32* noalias %r2, i32* noalias %r3)
{
%r5 = bitcast i32* %r2 to i736*
%r6 = load i736, i736* %r5
%r7 = zext i736 %r6 to i768
%r8 = bitcast i32* %r3 to i736*
%r9 = load i736, i736* %r8
%r10 = zext i736 %r9 to i768
%r11 = add i768 %r7, %r10
%r12 = trunc i768 %r11 to i736
%r13 = bitcast i32* %r1 to i736*
store i736 %r12, i736* %r13
%r14 = lshr i768 %r11, 736
%r15 = trunc i768 %r14 to i32
ret i32 %r15
}
define i32 @mclb_sub23(i32* noalias %r1, i32* noalias %r2, i32* noalias %r3)
{
%r5 = bitcast i32* %r2 to i736*
%r6 = load i736, i736* %r5
%r7 = zext i736 %r6 to i768
%r8 = bitcast i32* %r3 to i736*
%r9 = load i736, i736* %r8
%r10 = zext i736 %r9 to i768
%r11 = sub i768 %r7, %r10
%r12 = trunc i768 %r11 to i736
%r13 = bitcast i32* %r1 to i736*
store i736 %r12, i736* %r13
%r14 = lshr i768 %r11, 736
%r15 = trunc i768 %r14 to i32
%r16 = and i32 %r15, 1
ret i32 %r16
}
define void @mclb_addNF23(i32* noalias %r1, i32* noalias %r2, i32* noalias %r3)
{
%r4 = bitcast i32* %r2 to i736*
%r5 = load i736, i736* %r4
%r6 = bitcast i32* %r3 to i736*
%r7 = load i736, i736* %r6
%r8 = add i736 %r5, %r7
%r9 = bitcast i32* %r1 to i736*
store i736 %r8, i736* %r9
ret void
}
define i32 @mclb_subNF23(i32* noalias %r1, i32* noalias %r2, i32* noalias %r3)
{
%r5 = bitcast i32* %r2 to i736*
%r6 = load i736, i736* %r5
%r7 = bitcast i32* %r3 to i736*
%r8 = load i736, i736* %r7
%r9 = sub i736 %r6, %r8
%r10 = bitcast i32* %r1 to i736*
store i736 %r9, i736* %r10
%r11 = lshr i736 %r9, 735
%r12 = trunc i736 %r11 to i32
%r13 = and i32 %r12, 1
ret i32 %r13
}
define i32 @mclb_add24(i32* noalias %r1, i32* noalias %r2, i32* noalias %r3)
{
%r5 = bitcast i32* %r2 to i768*
%r6 = load i768, i768* %r5
%r7 = zext i768 %r6 to i800
%r8 = bitcast i32* %r3 to i768*
%r9 = load i768, i768* %r8
%r10 = zext i768 %r9 to i800
%r11 = add i800 %r7, %r10
%r12 = trunc i800 %r11 to i768
%r13 = bitcast i32* %r1 to i768*
store i768 %r12, i768* %r13
%r14 = lshr i800 %r11, 768
%r15 = trunc i800 %r14 to i32
ret i32 %r15
}
define i32 @mclb_sub24(i32* noalias %r1, i32* noalias %r2, i32* noalias %r3)
{
%r5 = bitcast i32* %r2 to i768*
%r6 = load i768, i768* %r5
%r7 = zext i768 %r6 to i800
%r8 = bitcast i32* %r3 to i768*
%r9 = load i768, i768* %r8
%r10 = zext i768 %r9 to i800
%r11 = sub i800 %r7, %r10
%r12 = trunc i800 %r11 to i768
%r13 = bitcast i32* %r1 to i768*
store i768 %r12, i768* %r13
%r14 = lshr i800 %r11, 768
%r15 = trunc i800 %r14 to i32
%r16 = and i32 %r15, 1
ret i32 %r16
}
define void @mclb_addNF24(i32* noalias %r1, i32* noalias %r2, i32* noalias %r3)
{
%r4 = bitcast i32* %r2 to i768*
%r5 = load i768, i768* %r4
%r6 = bitcast i32* %r3 to i768*
%r7 = load i768, i768* %r6
%r8 = add i768 %r5, %r7
%r9 = bitcast i32* %r1 to i768*
store i768 %r8, i768* %r9
ret void
}
define i32 @mclb_subNF24(i32* noalias %r1, i32* noalias %r2, i32* noalias %r3)
{
%r5 = bitcast i32* %r2 to i768*
%r6 = load i768, i768* %r5
%r7 = bitcast i32* %r3 to i768*
%r8 = load i768, i768* %r7
%r9 = sub i768 %r6, %r8
%r10 = bitcast i32* %r1 to i768*
store i768 %r9, i768* %r10
%r11 = lshr i768 %r9, 767
%r12 = trunc i768 %r11 to i32
%r13 = and i32 %r12, 1
ret i32 %r13
}
define i32 @mclb_add25(i32* noalias %r1, i32* noalias %r2, i32* noalias %r3)
{
%r5 = bitcast i32* %r2 to i800*
%r6 = load i800, i800* %r5
%r7 = zext i800 %r6 to i832
%r8 = bitcast i32* %r3 to i800*
%r9 = load i800, i800* %r8
%r10 = zext i800 %r9 to i832
%r11 = add i832 %r7, %r10
%r12 = trunc i832 %r11 to i800
%r13 = bitcast i32* %r1 to i800*
store i800 %r12, i800* %r13
%r14 = lshr i832 %r11, 800
%r15 = trunc i832 %r14 to i32
ret i32 %r15
}
define i32 @mclb_sub25(i32* noalias %r1, i32* noalias %r2, i32* noalias %r3)
{
%r5 = bitcast i32* %r2 to i800*
%r6 = load i800, i800* %r5
%r7 = zext i800 %r6 to i832
%r8 = bitcast i32* %r3 to i800*
%r9 = load i800, i800* %r8
%r10 = zext i800 %r9 to i832
%r11 = sub i832 %r7, %r10
%r12 = trunc i832 %r11 to i800
%r13 = bitcast i32* %r1 to i800*
store i800 %r12, i800* %r13
%r14 = lshr i832 %r11, 800
%r15 = trunc i832 %r14 to i32
%r16 = and i32 %r15, 1
ret i32 %r16
}
define void @mclb_addNF25(i32* noalias %r1, i32* noalias %r2, i32* noalias %r3)
{
%r4 = bitcast i32* %r2 to i800*
%r5 = load i800, i800* %r4
%r6 = bitcast i32* %r3 to i800*
%r7 = load i800, i800* %r6
%r8 = add i800 %r5, %r7
%r9 = bitcast i32* %r1 to i800*
store i800 %r8, i800* %r9
ret void
}
define i32 @mclb_subNF25(i32* noalias %r1, i32* noalias %r2, i32* noalias %r3)
{
%r5 = bitcast i32* %r2 to i800*
%r6 = load i800, i800* %r5
%r7 = bitcast i32* %r3 to i800*
%r8 = load i800, i800* %r7
%r9 = sub i800 %r6, %r8
%r10 = bitcast i32* %r1 to i800*
store i800 %r9, i800* %r10
%r11 = lshr i800 %r9, 799
%r12 = trunc i800 %r11 to i32
%r13 = and i32 %r12, 1
ret i32 %r13
}
define i32 @mclb_add26(i32* noalias %r1, i32* noalias %r2, i32* noalias %r3)
{
%r5 = bitcast i32* %r2 to i832*
%r6 = load i832, i832* %r5
%r7 = zext i832 %r6 to i864
%r8 = bitcast i32* %r3 to i832*
%r9 = load i832, i832* %r8
%r10 = zext i832 %r9 to i864
%r11 = add i864 %r7, %r10
%r12 = trunc i864 %r11 to i832
%r13 = bitcast i32* %r1 to i832*
store i832 %r12, i832* %r13
%r14 = lshr i864 %r11, 832
%r15 = trunc i864 %r14 to i32
ret i32 %r15
}
define i32 @mclb_sub26(i32* noalias %r1, i32* noalias %r2, i32* noalias %r3)
{
%r5 = bitcast i32* %r2 to i832*
%r6 = load i832, i832* %r5
%r7 = zext i832 %r6 to i864
%r8 = bitcast i32* %r3 to i832*
%r9 = load i832, i832* %r8
%r10 = zext i832 %r9 to i864
%r11 = sub i864 %r7, %r10
%r12 = trunc i864 %r11 to i832
%r13 = bitcast i32* %r1 to i832*
store i832 %r12, i832* %r13
%r14 = lshr i864 %r11, 832
%r15 = trunc i864 %r14 to i32
%r16 = and i32 %r15, 1
ret i32 %r16
}
define void @mclb_addNF26(i32* noalias %r1, i32* noalias %r2, i32* noalias %r3)
{
%r4 = bitcast i32* %r2 to i832*
%r5 = load i832, i832* %r4
%r6 = bitcast i32* %r3 to i832*
%r7 = load i832, i832* %r6
%r8 = add i832 %r5, %r7
%r9 = bitcast i32* %r1 to i832*
store i832 %r8, i832* %r9
ret void
}
define i32 @mclb_subNF26(i32* noalias %r1, i32* noalias %r2, i32* noalias %r3)
{
%r5 = bitcast i32* %r2 to i832*
%r6 = load i832, i832* %r5
%r7 = bitcast i32* %r3 to i832*
%r8 = load i832, i832* %r7
%r9 = sub i832 %r6, %r8
%r10 = bitcast i32* %r1 to i832*
store i832 %r9, i832* %r10
%r11 = lshr i832 %r9, 831
%r12 = trunc i832 %r11 to i32
%r13 = and i32 %r12, 1
ret i32 %r13
}
define i32 @mclb_add27(i32* noalias %r1, i32* noalias %r2, i32* noalias %r3)
{
%r5 = bitcast i32* %r2 to i864*
%r6 = load i864, i864* %r5
%r7 = zext i864 %r6 to i896
%r8 = bitcast i32* %r3 to i864*
%r9 = load i864, i864* %r8
%r10 = zext i864 %r9 to i896
%r11 = add i896 %r7, %r10
%r12 = trunc i896 %r11 to i864
%r13 = bitcast i32* %r1 to i864*
store i864 %r12, i864* %r13
%r14 = lshr i896 %r11, 864
%r15 = trunc i896 %r14 to i32
ret i32 %r15
}
define i32 @mclb_sub27(i32* noalias %r1, i32* noalias %r2, i32* noalias %r3)
{
%r5 = bitcast i32* %r2 to i864*
%r6 = load i864, i864* %r5
%r7 = zext i864 %r6 to i896
%r8 = bitcast i32* %r3 to i864*
%r9 = load i864, i864* %r8
%r10 = zext i864 %r9 to i896
%r11 = sub i896 %r7, %r10
%r12 = trunc i896 %r11 to i864
%r13 = bitcast i32* %r1 to i864*
store i864 %r12, i864* %r13
%r14 = lshr i896 %r11, 864
%r15 = trunc i896 %r14 to i32
%r16 = and i32 %r15, 1
ret i32 %r16
}
define void @mclb_addNF27(i32* noalias %r1, i32* noalias %r2, i32* noalias %r3)
{
%r4 = bitcast i32* %r2 to i864*
%r5 = load i864, i864* %r4
%r6 = bitcast i32* %r3 to i864*
%r7 = load i864, i864* %r6
%r8 = add i864 %r5, %r7
%r9 = bitcast i32* %r1 to i864*
store i864 %r8, i864* %r9
ret void
}
define i32 @mclb_subNF27(i32* noalias %r1, i32* noalias %r2, i32* noalias %r3)
{
%r5 = bitcast i32* %r2 to i864*
%r6 = load i864, i864* %r5
%r7 = bitcast i32* %r3 to i864*
%r8 = load i864, i864* %r7
%r9 = sub i864 %r6, %r8
%r10 = bitcast i32* %r1 to i864*
store i864 %r9, i864* %r10
%r11 = lshr i864 %r9, 863
%r12 = trunc i864 %r11 to i32
%r13 = and i32 %r12, 1
ret i32 %r13
}
define i32 @mclb_add28(i32* noalias %r1, i32* noalias %r2, i32* noalias %r3)
{
%r5 = bitcast i32* %r2 to i896*
%r6 = load i896, i896* %r5
%r7 = zext i896 %r6 to i928
%r8 = bitcast i32* %r3 to i896*
%r9 = load i896, i896* %r8
%r10 = zext i896 %r9 to i928
%r11 = add i928 %r7, %r10
%r12 = trunc i928 %r11 to i896
%r13 = bitcast i32* %r1 to i896*
store i896 %r12, i896* %r13
%r14 = lshr i928 %r11, 896
%r15 = trunc i928 %r14 to i32
ret i32 %r15
}
define i32 @mclb_sub28(i32* noalias %r1, i32* noalias %r2, i32* noalias %r3)
{
%r5 = bitcast i32* %r2 to i896*
%r6 = load i896, i896* %r5
%r7 = zext i896 %r6 to i928
%r8 = bitcast i32* %r3 to i896*
%r9 = load i896, i896* %r8
%r10 = zext i896 %r9 to i928
%r11 = sub i928 %r7, %r10
%r12 = trunc i928 %r11 to i896
%r13 = bitcast i32* %r1 to i896*
store i896 %r12, i896* %r13
%r14 = lshr i928 %r11, 896
%r15 = trunc i928 %r14 to i32
%r16 = and i32 %r15, 1
ret i32 %r16
}
define void @mclb_addNF28(i32* noalias %r1, i32* noalias %r2, i32* noalias %r3)
{
%r4 = bitcast i32* %r2 to i896*
%r5 = load i896, i896* %r4
%r6 = bitcast i32* %r3 to i896*
%r7 = load i896, i896* %r6
%r8 = add i896 %r5, %r7
%r9 = bitcast i32* %r1 to i896*
store i896 %r8, i896* %r9
ret void
}
define i32 @mclb_subNF28(i32* noalias %r1, i32* noalias %r2, i32* noalias %r3)
{
%r5 = bitcast i32* %r2 to i896*
%r6 = load i896, i896* %r5
%r7 = bitcast i32* %r3 to i896*
%r8 = load i896, i896* %r7
%r9 = sub i896 %r6, %r8
%r10 = bitcast i32* %r1 to i896*
store i896 %r9, i896* %r10
%r11 = lshr i896 %r9, 895
%r12 = trunc i896 %r11 to i32
%r13 = and i32 %r12, 1
ret i32 %r13
}
define i32 @mclb_add29(i32* noalias %r1, i32* noalias %r2, i32* noalias %r3)
{
%r5 = bitcast i32* %r2 to i928*
%r6 = load i928, i928* %r5
%r7 = zext i928 %r6 to i960
%r8 = bitcast i32* %r3 to i928*
%r9 = load i928, i928* %r8
%r10 = zext i928 %r9 to i960
%r11 = add i960 %r7, %r10
%r12 = trunc i960 %r11 to i928
%r13 = bitcast i32* %r1 to i928*
store i928 %r12, i928* %r13
%r14 = lshr i960 %r11, 928
%r15 = trunc i960 %r14 to i32
ret i32 %r15
}
define i32 @mclb_sub29(i32* noalias %r1, i32* noalias %r2, i32* noalias %r3)
{
%r5 = bitcast i32* %r2 to i928*
%r6 = load i928, i928* %r5
%r7 = zext i928 %r6 to i960
%r8 = bitcast i32* %r3 to i928*
%r9 = load i928, i928* %r8
%r10 = zext i928 %r9 to i960
%r11 = sub i960 %r7, %r10
%r12 = trunc i960 %r11 to i928
%r13 = bitcast i32* %r1 to i928*
store i928 %r12, i928* %r13
%r14 = lshr i960 %r11, 928
%r15 = trunc i960 %r14 to i32
%r16 = and i32 %r15, 1
ret i32 %r16
}
define void @mclb_addNF29(i32* noalias %r1, i32* noalias %r2, i32* noalias %r3)
{
%r4 = bitcast i32* %r2 to i928*
%r5 = load i928, i928* %r4
%r6 = bitcast i32* %r3 to i928*
%r7 = load i928, i928* %r6
%r8 = add i928 %r5, %r7
%r9 = bitcast i32* %r1 to i928*
store i928 %r8, i928* %r9
ret void
}
define i32 @mclb_subNF29(i32* noalias %r1, i32* noalias %r2, i32* noalias %r3)
{
%r5 = bitcast i32* %r2 to i928*
%r6 = load i928, i928* %r5
%r7 = bitcast i32* %r3 to i928*
%r8 = load i928, i928* %r7
%r9 = sub i928 %r6, %r8
%r10 = bitcast i32* %r1 to i928*
store i928 %r9, i928* %r10
%r11 = lshr i928 %r9, 927
%r12 = trunc i928 %r11 to i32
%r13 = and i32 %r12, 1
ret i32 %r13
}
define i32 @mclb_add30(i32* noalias %r1, i32* noalias %r2, i32* noalias %r3)
{
%r5 = bitcast i32* %r2 to i960*
%r6 = load i960, i960* %r5
%r7 = zext i960 %r6 to i992
%r8 = bitcast i32* %r3 to i960*
%r9 = load i960, i960* %r8
%r10 = zext i960 %r9 to i992
%r11 = add i992 %r7, %r10
%r12 = trunc i992 %r11 to i960
%r13 = bitcast i32* %r1 to i960*
store i960 %r12, i960* %r13
%r14 = lshr i992 %r11, 960
%r15 = trunc i992 %r14 to i32
ret i32 %r15
}
define i32 @mclb_sub30(i32* noalias %r1, i32* noalias %r2, i32* noalias %r3)
{
%r5 = bitcast i32* %r2 to i960*
%r6 = load i960, i960* %r5
%r7 = zext i960 %r6 to i992
%r8 = bitcast i32* %r3 to i960*
%r9 = load i960, i960* %r8
%r10 = zext i960 %r9 to i992
%r11 = sub i992 %r7, %r10
%r12 = trunc i992 %r11 to i960
%r13 = bitcast i32* %r1 to i960*
store i960 %r12, i960* %r13
%r14 = lshr i992 %r11, 960
%r15 = trunc i992 %r14 to i32
%r16 = and i32 %r15, 1
ret i32 %r16
}
define void @mclb_addNF30(i32* noalias %r1, i32* noalias %r2, i32* noalias %r3)
{
%r4 = bitcast i32* %r2 to i960*
%r5 = load i960, i960* %r4
%r6 = bitcast i32* %r3 to i960*
%r7 = load i960, i960* %r6
%r8 = add i960 %r5, %r7
%r9 = bitcast i32* %r1 to i960*
store i960 %r8, i960* %r9
ret void
}
define i32 @mclb_subNF30(i32* noalias %r1, i32* noalias %r2, i32* noalias %r3)
{
%r5 = bitcast i32* %r2 to i960*
%r6 = load i960, i960* %r5
%r7 = bitcast i32* %r3 to i960*
%r8 = load i960, i960* %r7
%r9 = sub i960 %r6, %r8
%r10 = bitcast i32* %r1 to i960*
store i960 %r9, i960* %r10
%r11 = lshr i960 %r9, 959
%r12 = trunc i960 %r11 to i32
%r13 = and i32 %r12, 1
ret i32 %r13
}
define i32 @mclb_add31(i32* noalias %r1, i32* noalias %r2, i32* noalias %r3)
{
%r5 = bitcast i32* %r2 to i992*
%r6 = load i992, i992* %r5
%r7 = zext i992 %r6 to i1024
%r8 = bitcast i32* %r3 to i992*
%r9 = load i992, i992* %r8
%r10 = zext i992 %r9 to i1024
%r11 = add i1024 %r7, %r10
%r12 = trunc i1024 %r11 to i992
%r13 = bitcast i32* %r1 to i992*
store i992 %r12, i992* %r13
%r14 = lshr i1024 %r11, 992
%r15 = trunc i1024 %r14 to i32
ret i32 %r15
}
define i32 @mclb_sub31(i32* noalias %r1, i32* noalias %r2, i32* noalias %r3)
{
%r5 = bitcast i32* %r2 to i992*
%r6 = load i992, i992* %r5
%r7 = zext i992 %r6 to i1024
%r8 = bitcast i32* %r3 to i992*
%r9 = load i992, i992* %r8
%r10 = zext i992 %r9 to i1024
%r11 = sub i1024 %r7, %r10
%r12 = trunc i1024 %r11 to i992
%r13 = bitcast i32* %r1 to i992*
store i992 %r12, i992* %r13
%r14 = lshr i1024 %r11, 992
%r15 = trunc i1024 %r14 to i32
%r16 = and i32 %r15, 1
ret i32 %r16
}
define void @mclb_addNF31(i32* noalias %r1, i32* noalias %r2, i32* noalias %r3)
{
%r4 = bitcast i32* %r2 to i992*
%r5 = load i992, i992* %r4
%r6 = bitcast i32* %r3 to i992*
%r7 = load i992, i992* %r6
%r8 = add i992 %r5, %r7
%r9 = bitcast i32* %r1 to i992*
store i992 %r8, i992* %r9
ret void
}
define i32 @mclb_subNF31(i32* noalias %r1, i32* noalias %r2, i32* noalias %r3)
{
%r5 = bitcast i32* %r2 to i992*
%r6 = load i992, i992* %r5
%r7 = bitcast i32* %r3 to i992*
%r8 = load i992, i992* %r7
%r9 = sub i992 %r6, %r8
%r10 = bitcast i32* %r1 to i992*
store i992 %r9, i992* %r10
%r11 = lshr i992 %r9, 991
%r12 = trunc i992 %r11 to i32
%r13 = and i32 %r12, 1
ret i32 %r13
}
define i32 @mclb_add32(i32* noalias %r1, i32* noalias %r2, i32* noalias %r3)
{
%r5 = bitcast i32* %r2 to i1024*
%r6 = load i1024, i1024* %r5
%r7 = zext i1024 %r6 to i1056
%r8 = bitcast i32* %r3 to i1024*
%r9 = load i1024, i1024* %r8
%r10 = zext i1024 %r9 to i1056
%r11 = add i1056 %r7, %r10
%r12 = trunc i1056 %r11 to i1024
%r13 = bitcast i32* %r1 to i1024*
store i1024 %r12, i1024* %r13
%r14 = lshr i1056 %r11, 1024
%r15 = trunc i1056 %r14 to i32
ret i32 %r15
}
define i32 @mclb_sub32(i32* noalias %r1, i32* noalias %r2, i32* noalias %r3)
{
%r5 = bitcast i32* %r2 to i1024*
%r6 = load i1024, i1024* %r5
%r7 = zext i1024 %r6 to i1056
%r8 = bitcast i32* %r3 to i1024*
%r9 = load i1024, i1024* %r8
%r10 = zext i1024 %r9 to i1056
%r11 = sub i1056 %r7, %r10
%r12 = trunc i1056 %r11 to i1024
%r13 = bitcast i32* %r1 to i1024*
store i1024 %r12, i1024* %r13
%r14 = lshr i1056 %r11, 1024
%r15 = trunc i1056 %r14 to i32
%r16 = and i32 %r15, 1
ret i32 %r16
}
define void @mclb_addNF32(i32* noalias %r1, i32* noalias %r2, i32* noalias %r3)
{
%r4 = bitcast i32* %r2 to i1024*
%r5 = load i1024, i1024* %r4
%r6 = bitcast i32* %r3 to i1024*
%r7 = load i1024, i1024* %r6
%r8 = add i1024 %r5, %r7
%r9 = bitcast i32* %r1 to i1024*
store i1024 %r8, i1024* %r9
ret void
}
define i32 @mclb_subNF32(i32* noalias %r1, i32* noalias %r2, i32* noalias %r3)
{
%r5 = bitcast i32* %r2 to i1024*
%r6 = load i1024, i1024* %r5
%r7 = bitcast i32* %r3 to i1024*
%r8 = load i1024, i1024* %r7
%r9 = sub i1024 %r6, %r8
%r10 = bitcast i32* %r1 to i1024*
store i1024 %r9, i1024* %r10
%r11 = lshr i1024 %r9, 1023
%r12 = trunc i1024 %r11 to i32
%r13 = and i32 %r12, 1
ret i32 %r13
}
define i64 @mulUnit_inner32(i32* noalias %r2, i32 %r3)
{
%r4 = call i64 @mulPos32x32(i32* %r2, i32 %r3, i32 0)
%r5 = trunc i64 %r4 to i32
%r6 = call i32 @extractHigh32(i64 %r4)
%r7 = zext i32 %r5 to i64
%r8 = zext i32 %r6 to i64
%r9 = shl i64 %r8, 32
%r10 = add i64 %r7, %r9
ret i64 %r10
}
define i32 @mclb_mulUnit1(i32* noalias %r1, i32* noalias %r2, i32 %r3)
{
%r5 = call i64 @mulUnit_inner32(i32* %r2, i32 %r3)
%r6 = trunc i64 %r5 to i32
store i32 %r6, i32* %r1
%r7 = lshr i64 %r5, 32
%r8 = trunc i64 %r7 to i32
ret i32 %r8
}
define i32 @mclb_mulUnitAdd1(i32* noalias %r1, i32* noalias %r2, i32 %r3)
{
%r5 = call i64 @mulPos32x32(i32* %r2, i32 %r3, i32 0)
%r6 = trunc i64 %r5 to i32
%r7 = call i32 @extractHigh32(i64 %r5)
%r8 = zext i32 %r6 to i64
%r9 = zext i32 %r7 to i64
%r10 = shl i64 %r9, 32
%r11 = add i64 %r8, %r10
%r12 = load i32, i32* %r1
%r13 = zext i32 %r12 to i64
%r14 = add i64 %r11, %r13
%r15 = trunc i64 %r14 to i32
store i32 %r15, i32* %r1
%r16 = lshr i64 %r14, 32
%r17 = trunc i64 %r16 to i32
ret i32 %r17
}
define void @mclb_mul1(i32* noalias %r1, i32* noalias %r2, i32* noalias %r3)
{
%r4 = load i32, i32* %r2
%r5 = load i32, i32* %r3
%r6 = zext i32 %r4 to i64
%r7 = zext i32 %r5 to i64
%r8 = mul i64 %r6, %r7
%r9 = bitcast i32* %r1 to i64*
store i64 %r8, i64* %r9
ret void
}
define void @mclb_sqr1(i32* noalias %r1, i32* noalias %r2)
{
%r3 = load i32, i32* %r2
%r4 = load i32, i32* %r2
%r5 = zext i32 %r3 to i64
%r6 = zext i32 %r4 to i64
%r7 = mul i64 %r5, %r6
%r8 = bitcast i32* %r1 to i64*
store i64 %r7, i64* %r8
ret void
}
define i96 @mulUnit_inner64(i32* noalias %r2, i32 %r3)
{
%r4 = call i64 @mulPos32x32(i32* %r2, i32 %r3, i32 0)
%r5 = trunc i64 %r4 to i32
%r6 = call i32 @extractHigh32(i64 %r4)
%r7 = call i64 @mulPos32x32(i32* %r2, i32 %r3, i32 1)
%r8 = trunc i64 %r7 to i32
%r9 = call i32 @extractHigh32(i64 %r7)
%r10 = zext i32 %r5 to i64
%r11 = zext i32 %r8 to i64
%r12 = shl i64 %r11, 32
%r13 = or i64 %r10, %r12
%r14 = zext i32 %r6 to i64
%r15 = zext i32 %r9 to i64
%r16 = shl i64 %r15, 32
%r17 = or i64 %r14, %r16
%r18 = zext i64 %r13 to i96
%r19 = zext i64 %r17 to i96
%r20 = shl i96 %r19, 32
%r21 = add i96 %r18, %r20
ret i96 %r21
}
define i32 @mclb_mulUnit2(i32* noalias %r1, i32* noalias %r2, i32 %r3)
{
%r5 = call i96 @mulUnit_inner64(i32* %r2, i32 %r3)
%r6 = trunc i96 %r5 to i64
%r7 = bitcast i32* %r1 to i64*
store i64 %r6, i64* %r7
%r8 = lshr i96 %r5, 64
%r9 = trunc i96 %r8 to i32
ret i32 %r9
}
define i32 @mclb_mulUnitAdd2(i32* noalias %r1, i32* noalias %r2, i32 %r3)
{
%r5 = call i64 @mulPos32x32(i32* %r2, i32 %r3, i32 0)
%r6 = trunc i64 %r5 to i32
%r7 = call i32 @extractHigh32(i64 %r5)
%r8 = call i64 @mulPos32x32(i32* %r2, i32 %r3, i32 1)
%r9 = trunc i64 %r8 to i32
%r10 = call i32 @extractHigh32(i64 %r8)
%r11 = zext i32 %r6 to i64
%r12 = zext i32 %r9 to i64
%r13 = shl i64 %r12, 32
%r14 = or i64 %r11, %r13
%r15 = zext i32 %r7 to i64
%r16 = zext i32 %r10 to i64
%r17 = shl i64 %r16, 32
%r18 = or i64 %r15, %r17
%r19 = zext i64 %r14 to i96
%r20 = zext i64 %r18 to i96
%r21 = shl i96 %r20, 32
%r22 = add i96 %r19, %r21
%r23 = bitcast i32* %r1 to i64*
%r24 = load i64, i64* %r23
%r25 = zext i64 %r24 to i96
%r26 = add i96 %r22, %r25
%r27 = trunc i96 %r26 to i64
%r28 = bitcast i32* %r1 to i64*
store i64 %r27, i64* %r28
%r29 = lshr i96 %r26, 64
%r30 = trunc i96 %r29 to i32
ret i32 %r30
}
define void @mclb_mul2(i32* noalias %r1, i32* noalias %r2, i32* noalias %r3)
{
%r4 = load i32, i32* %r3
%r5 = call i96 @mulUnit_inner64(i32* %r2, i32 %r4)
%r6 = trunc i96 %r5 to i32
store i32 %r6, i32* %r1
%r7 = lshr i96 %r5, 32
%r8 = getelementptr i32, i32* %r3, i32 1
%r9 = load i32, i32* %r8
%r10 = call i96 @mulUnit_inner64(i32* %r2, i32 %r9)
%r11 = add i96 %r7, %r10
%r12 = getelementptr i32, i32* %r1, i32 1
%r13 = bitcast i32* %r12 to i96*
store i96 %r11, i96* %r13
ret void
}
define void @mclb_sqr2(i32* noalias %r1, i32* noalias %r2)
{
%r3 = load i32, i32* %r2
%r4 = call i96 @mulUnit_inner64(i32* %r2, i32 %r3)
%r5 = trunc i96 %r4 to i32
store i32 %r5, i32* %r1
%r6 = lshr i96 %r4, 32
%r7 = getelementptr i32, i32* %r2, i32 1
%r8 = load i32, i32* %r7
%r9 = call i96 @mulUnit_inner64(i32* %r2, i32 %r8)
%r10 = add i96 %r6, %r9
%r11 = getelementptr i32, i32* %r1, i32 1
%r12 = bitcast i32* %r11 to i96*
store i96 %r10, i96* %r12
ret void
}
define i128 @mulUnit_inner96(i32* noalias %r2, i32 %r3)
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
%r13 = zext i32 %r5 to i64
%r14 = zext i32 %r8 to i64
%r15 = shl i64 %r14, 32
%r16 = or i64 %r13, %r15
%r17 = zext i64 %r16 to i96
%r18 = zext i32 %r11 to i96
%r19 = shl i96 %r18, 64
%r20 = or i96 %r17, %r19
%r21 = zext i32 %r6 to i64
%r22 = zext i32 %r9 to i64
%r23 = shl i64 %r22, 32
%r24 = or i64 %r21, %r23
%r25 = zext i64 %r24 to i96
%r26 = zext i32 %r12 to i96
%r27 = shl i96 %r26, 64
%r28 = or i96 %r25, %r27
%r29 = zext i96 %r20 to i128
%r30 = zext i96 %r28 to i128
%r31 = shl i128 %r30, 32
%r32 = add i128 %r29, %r31
ret i128 %r32
}
define i32 @mclb_mulUnit3(i32* noalias %r1, i32* noalias %r2, i32 %r3)
{
%r5 = call i128 @mulUnit_inner96(i32* %r2, i32 %r3)
%r6 = trunc i128 %r5 to i96
%r7 = bitcast i32* %r1 to i96*
store i96 %r6, i96* %r7
%r8 = lshr i128 %r5, 96
%r9 = trunc i128 %r8 to i32
ret i32 %r9
}
define i32 @mclb_mulUnitAdd3(i32* noalias %r1, i32* noalias %r2, i32 %r3)
{
%r5 = call i64 @mulPos32x32(i32* %r2, i32 %r3, i32 0)
%r6 = trunc i64 %r5 to i32
%r7 = call i32 @extractHigh32(i64 %r5)
%r8 = call i64 @mulPos32x32(i32* %r2, i32 %r3, i32 1)
%r9 = trunc i64 %r8 to i32
%r10 = call i32 @extractHigh32(i64 %r8)
%r11 = call i64 @mulPos32x32(i32* %r2, i32 %r3, i32 2)
%r12 = trunc i64 %r11 to i32
%r13 = call i32 @extractHigh32(i64 %r11)
%r14 = zext i32 %r6 to i64
%r15 = zext i32 %r9 to i64
%r16 = shl i64 %r15, 32
%r17 = or i64 %r14, %r16
%r18 = zext i64 %r17 to i96
%r19 = zext i32 %r12 to i96
%r20 = shl i96 %r19, 64
%r21 = or i96 %r18, %r20
%r22 = zext i32 %r7 to i64
%r23 = zext i32 %r10 to i64
%r24 = shl i64 %r23, 32
%r25 = or i64 %r22, %r24
%r26 = zext i64 %r25 to i96
%r27 = zext i32 %r13 to i96
%r28 = shl i96 %r27, 64
%r29 = or i96 %r26, %r28
%r30 = zext i96 %r21 to i128
%r31 = zext i96 %r29 to i128
%r32 = shl i128 %r31, 32
%r33 = add i128 %r30, %r32
%r34 = bitcast i32* %r1 to i96*
%r35 = load i96, i96* %r34
%r36 = zext i96 %r35 to i128
%r37 = add i128 %r33, %r36
%r38 = trunc i128 %r37 to i96
%r39 = bitcast i32* %r1 to i96*
store i96 %r38, i96* %r39
%r40 = lshr i128 %r37, 96
%r41 = trunc i128 %r40 to i32
ret i32 %r41
}
define void @mclb_mul3(i32* noalias %r1, i32* noalias %r2, i32* noalias %r3)
{
%r4 = load i32, i32* %r3
%r5 = call i128 @mulUnit_inner96(i32* %r2, i32 %r4)
%r6 = trunc i128 %r5 to i32
store i32 %r6, i32* %r1
%r7 = lshr i128 %r5, 32
%r8 = getelementptr i32, i32* %r3, i32 1
%r9 = load i32, i32* %r8
%r10 = call i128 @mulUnit_inner96(i32* %r2, i32 %r9)
%r11 = add i128 %r7, %r10
%r12 = trunc i128 %r11 to i32
%r13 = getelementptr i32, i32* %r1, i32 1
store i32 %r12, i32* %r13
%r14 = lshr i128 %r11, 32
%r15 = getelementptr i32, i32* %r3, i32 2
%r16 = load i32, i32* %r15
%r17 = call i128 @mulUnit_inner96(i32* %r2, i32 %r16)
%r18 = add i128 %r14, %r17
%r19 = getelementptr i32, i32* %r1, i32 2
%r20 = bitcast i32* %r19 to i128*
store i128 %r18, i128* %r20
ret void
}
define void @mclb_sqr3(i32* noalias %r1, i32* noalias %r2)
{
%r3 = load i32, i32* %r2
%r4 = call i128 @mulUnit_inner96(i32* %r2, i32 %r3)
%r5 = trunc i128 %r4 to i32
store i32 %r5, i32* %r1
%r6 = lshr i128 %r4, 32
%r7 = getelementptr i32, i32* %r2, i32 1
%r8 = load i32, i32* %r7
%r9 = call i128 @mulUnit_inner96(i32* %r2, i32 %r8)
%r10 = add i128 %r6, %r9
%r11 = trunc i128 %r10 to i32
%r12 = getelementptr i32, i32* %r1, i32 1
store i32 %r11, i32* %r12
%r13 = lshr i128 %r10, 32
%r14 = getelementptr i32, i32* %r2, i32 2
%r15 = load i32, i32* %r14
%r16 = call i128 @mulUnit_inner96(i32* %r2, i32 %r15)
%r17 = add i128 %r13, %r16
%r18 = getelementptr i32, i32* %r1, i32 2
%r19 = bitcast i32* %r18 to i128*
store i128 %r17, i128* %r19
ret void
}
define i160 @mulUnit_inner128(i32* noalias %r2, i32 %r3)
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
%r16 = zext i32 %r5 to i64
%r17 = zext i32 %r8 to i64
%r18 = shl i64 %r17, 32
%r19 = or i64 %r16, %r18
%r20 = zext i64 %r19 to i96
%r21 = zext i32 %r11 to i96
%r22 = shl i96 %r21, 64
%r23 = or i96 %r20, %r22
%r24 = zext i96 %r23 to i128
%r25 = zext i32 %r14 to i128
%r26 = shl i128 %r25, 96
%r27 = or i128 %r24, %r26
%r28 = zext i32 %r6 to i64
%r29 = zext i32 %r9 to i64
%r30 = shl i64 %r29, 32
%r31 = or i64 %r28, %r30
%r32 = zext i64 %r31 to i96
%r33 = zext i32 %r12 to i96
%r34 = shl i96 %r33, 64
%r35 = or i96 %r32, %r34
%r36 = zext i96 %r35 to i128
%r37 = zext i32 %r15 to i128
%r38 = shl i128 %r37, 96
%r39 = or i128 %r36, %r38
%r40 = zext i128 %r27 to i160
%r41 = zext i128 %r39 to i160
%r42 = shl i160 %r41, 32
%r43 = add i160 %r40, %r42
ret i160 %r43
}
define i32 @mclb_mulUnit4(i32* noalias %r1, i32* noalias %r2, i32 %r3)
{
%r5 = call i160 @mulUnit_inner128(i32* %r2, i32 %r3)
%r6 = trunc i160 %r5 to i128
%r7 = bitcast i32* %r1 to i128*
store i128 %r6, i128* %r7
%r8 = lshr i160 %r5, 128
%r9 = trunc i160 %r8 to i32
ret i32 %r9
}
define i32 @mclb_mulUnitAdd4(i32* noalias %r1, i32* noalias %r2, i32 %r3)
{
%r5 = call i64 @mulPos32x32(i32* %r2, i32 %r3, i32 0)
%r6 = trunc i64 %r5 to i32
%r7 = call i32 @extractHigh32(i64 %r5)
%r8 = call i64 @mulPos32x32(i32* %r2, i32 %r3, i32 1)
%r9 = trunc i64 %r8 to i32
%r10 = call i32 @extractHigh32(i64 %r8)
%r11 = call i64 @mulPos32x32(i32* %r2, i32 %r3, i32 2)
%r12 = trunc i64 %r11 to i32
%r13 = call i32 @extractHigh32(i64 %r11)
%r14 = call i64 @mulPos32x32(i32* %r2, i32 %r3, i32 3)
%r15 = trunc i64 %r14 to i32
%r16 = call i32 @extractHigh32(i64 %r14)
%r17 = zext i32 %r6 to i64
%r18 = zext i32 %r9 to i64
%r19 = shl i64 %r18, 32
%r20 = or i64 %r17, %r19
%r21 = zext i64 %r20 to i96
%r22 = zext i32 %r12 to i96
%r23 = shl i96 %r22, 64
%r24 = or i96 %r21, %r23
%r25 = zext i96 %r24 to i128
%r26 = zext i32 %r15 to i128
%r27 = shl i128 %r26, 96
%r28 = or i128 %r25, %r27
%r29 = zext i32 %r7 to i64
%r30 = zext i32 %r10 to i64
%r31 = shl i64 %r30, 32
%r32 = or i64 %r29, %r31
%r33 = zext i64 %r32 to i96
%r34 = zext i32 %r13 to i96
%r35 = shl i96 %r34, 64
%r36 = or i96 %r33, %r35
%r37 = zext i96 %r36 to i128
%r38 = zext i32 %r16 to i128
%r39 = shl i128 %r38, 96
%r40 = or i128 %r37, %r39
%r41 = zext i128 %r28 to i160
%r42 = zext i128 %r40 to i160
%r43 = shl i160 %r42, 32
%r44 = add i160 %r41, %r43
%r45 = bitcast i32* %r1 to i128*
%r46 = load i128, i128* %r45
%r47 = zext i128 %r46 to i160
%r48 = add i160 %r44, %r47
%r49 = trunc i160 %r48 to i128
%r50 = bitcast i32* %r1 to i128*
store i128 %r49, i128* %r50
%r51 = lshr i160 %r48, 128
%r52 = trunc i160 %r51 to i32
ret i32 %r52
}
define void @mclb_mul4(i32* noalias %r1, i32* noalias %r2, i32* noalias %r3)
{
%r4 = load i32, i32* %r3
%r5 = call i160 @mulUnit_inner128(i32* %r2, i32 %r4)
%r6 = trunc i160 %r5 to i32
store i32 %r6, i32* %r1
%r7 = lshr i160 %r5, 32
%r8 = getelementptr i32, i32* %r3, i32 1
%r9 = load i32, i32* %r8
%r10 = call i160 @mulUnit_inner128(i32* %r2, i32 %r9)
%r11 = add i160 %r7, %r10
%r12 = trunc i160 %r11 to i32
%r13 = getelementptr i32, i32* %r1, i32 1
store i32 %r12, i32* %r13
%r14 = lshr i160 %r11, 32
%r15 = getelementptr i32, i32* %r3, i32 2
%r16 = load i32, i32* %r15
%r17 = call i160 @mulUnit_inner128(i32* %r2, i32 %r16)
%r18 = add i160 %r14, %r17
%r19 = trunc i160 %r18 to i32
%r20 = getelementptr i32, i32* %r1, i32 2
store i32 %r19, i32* %r20
%r21 = lshr i160 %r18, 32
%r22 = getelementptr i32, i32* %r3, i32 3
%r23 = load i32, i32* %r22
%r24 = call i160 @mulUnit_inner128(i32* %r2, i32 %r23)
%r25 = add i160 %r21, %r24
%r26 = getelementptr i32, i32* %r1, i32 3
%r27 = bitcast i32* %r26 to i160*
store i160 %r25, i160* %r27
ret void
}
define void @mclb_sqr4(i32* noalias %r1, i32* noalias %r2)
{
%r3 = load i32, i32* %r2
%r4 = call i160 @mulUnit_inner128(i32* %r2, i32 %r3)
%r5 = trunc i160 %r4 to i32
store i32 %r5, i32* %r1
%r6 = lshr i160 %r4, 32
%r7 = getelementptr i32, i32* %r2, i32 1
%r8 = load i32, i32* %r7
%r9 = call i160 @mulUnit_inner128(i32* %r2, i32 %r8)
%r10 = add i160 %r6, %r9
%r11 = trunc i160 %r10 to i32
%r12 = getelementptr i32, i32* %r1, i32 1
store i32 %r11, i32* %r12
%r13 = lshr i160 %r10, 32
%r14 = getelementptr i32, i32* %r2, i32 2
%r15 = load i32, i32* %r14
%r16 = call i160 @mulUnit_inner128(i32* %r2, i32 %r15)
%r17 = add i160 %r13, %r16
%r18 = trunc i160 %r17 to i32
%r19 = getelementptr i32, i32* %r1, i32 2
store i32 %r18, i32* %r19
%r20 = lshr i160 %r17, 32
%r21 = getelementptr i32, i32* %r2, i32 3
%r22 = load i32, i32* %r21
%r23 = call i160 @mulUnit_inner128(i32* %r2, i32 %r22)
%r24 = add i160 %r20, %r23
%r25 = getelementptr i32, i32* %r1, i32 3
%r26 = bitcast i32* %r25 to i160*
store i160 %r24, i160* %r26
ret void
}
define i192 @mulUnit_inner160(i32* noalias %r2, i32 %r3)
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
%r19 = zext i32 %r5 to i64
%r20 = zext i32 %r8 to i64
%r21 = shl i64 %r20, 32
%r22 = or i64 %r19, %r21
%r23 = zext i64 %r22 to i96
%r24 = zext i32 %r11 to i96
%r25 = shl i96 %r24, 64
%r26 = or i96 %r23, %r25
%r27 = zext i96 %r26 to i128
%r28 = zext i32 %r14 to i128
%r29 = shl i128 %r28, 96
%r30 = or i128 %r27, %r29
%r31 = zext i128 %r30 to i160
%r32 = zext i32 %r17 to i160
%r33 = shl i160 %r32, 128
%r34 = or i160 %r31, %r33
%r35 = zext i32 %r6 to i64
%r36 = zext i32 %r9 to i64
%r37 = shl i64 %r36, 32
%r38 = or i64 %r35, %r37
%r39 = zext i64 %r38 to i96
%r40 = zext i32 %r12 to i96
%r41 = shl i96 %r40, 64
%r42 = or i96 %r39, %r41
%r43 = zext i96 %r42 to i128
%r44 = zext i32 %r15 to i128
%r45 = shl i128 %r44, 96
%r46 = or i128 %r43, %r45
%r47 = zext i128 %r46 to i160
%r48 = zext i32 %r18 to i160
%r49 = shl i160 %r48, 128
%r50 = or i160 %r47, %r49
%r51 = zext i160 %r34 to i192
%r52 = zext i160 %r50 to i192
%r53 = shl i192 %r52, 32
%r54 = add i192 %r51, %r53
ret i192 %r54
}
define i32 @mclb_mulUnit5(i32* noalias %r1, i32* noalias %r2, i32 %r3)
{
%r5 = call i192 @mulUnit_inner160(i32* %r2, i32 %r3)
%r6 = trunc i192 %r5 to i160
%r7 = bitcast i32* %r1 to i160*
store i160 %r6, i160* %r7
%r8 = lshr i192 %r5, 160
%r9 = trunc i192 %r8 to i32
ret i32 %r9
}
define i32 @mclb_mulUnitAdd5(i32* noalias %r1, i32* noalias %r2, i32 %r3)
{
%r5 = call i64 @mulPos32x32(i32* %r2, i32 %r3, i32 0)
%r6 = trunc i64 %r5 to i32
%r7 = call i32 @extractHigh32(i64 %r5)
%r8 = call i64 @mulPos32x32(i32* %r2, i32 %r3, i32 1)
%r9 = trunc i64 %r8 to i32
%r10 = call i32 @extractHigh32(i64 %r8)
%r11 = call i64 @mulPos32x32(i32* %r2, i32 %r3, i32 2)
%r12 = trunc i64 %r11 to i32
%r13 = call i32 @extractHigh32(i64 %r11)
%r14 = call i64 @mulPos32x32(i32* %r2, i32 %r3, i32 3)
%r15 = trunc i64 %r14 to i32
%r16 = call i32 @extractHigh32(i64 %r14)
%r17 = call i64 @mulPos32x32(i32* %r2, i32 %r3, i32 4)
%r18 = trunc i64 %r17 to i32
%r19 = call i32 @extractHigh32(i64 %r17)
%r20 = zext i32 %r6 to i64
%r21 = zext i32 %r9 to i64
%r22 = shl i64 %r21, 32
%r23 = or i64 %r20, %r22
%r24 = zext i64 %r23 to i96
%r25 = zext i32 %r12 to i96
%r26 = shl i96 %r25, 64
%r27 = or i96 %r24, %r26
%r28 = zext i96 %r27 to i128
%r29 = zext i32 %r15 to i128
%r30 = shl i128 %r29, 96
%r31 = or i128 %r28, %r30
%r32 = zext i128 %r31 to i160
%r33 = zext i32 %r18 to i160
%r34 = shl i160 %r33, 128
%r35 = or i160 %r32, %r34
%r36 = zext i32 %r7 to i64
%r37 = zext i32 %r10 to i64
%r38 = shl i64 %r37, 32
%r39 = or i64 %r36, %r38
%r40 = zext i64 %r39 to i96
%r41 = zext i32 %r13 to i96
%r42 = shl i96 %r41, 64
%r43 = or i96 %r40, %r42
%r44 = zext i96 %r43 to i128
%r45 = zext i32 %r16 to i128
%r46 = shl i128 %r45, 96
%r47 = or i128 %r44, %r46
%r48 = zext i128 %r47 to i160
%r49 = zext i32 %r19 to i160
%r50 = shl i160 %r49, 128
%r51 = or i160 %r48, %r50
%r52 = zext i160 %r35 to i192
%r53 = zext i160 %r51 to i192
%r54 = shl i192 %r53, 32
%r55 = add i192 %r52, %r54
%r56 = bitcast i32* %r1 to i160*
%r57 = load i160, i160* %r56
%r58 = zext i160 %r57 to i192
%r59 = add i192 %r55, %r58
%r60 = trunc i192 %r59 to i160
%r61 = bitcast i32* %r1 to i160*
store i160 %r60, i160* %r61
%r62 = lshr i192 %r59, 160
%r63 = trunc i192 %r62 to i32
ret i32 %r63
}
define void @mclb_mul5(i32* noalias %r1, i32* noalias %r2, i32* noalias %r3)
{
%r4 = load i32, i32* %r3
%r5 = call i192 @mulUnit_inner160(i32* %r2, i32 %r4)
%r6 = trunc i192 %r5 to i32
store i32 %r6, i32* %r1
%r7 = lshr i192 %r5, 32
%r8 = getelementptr i32, i32* %r3, i32 1
%r9 = load i32, i32* %r8
%r10 = call i192 @mulUnit_inner160(i32* %r2, i32 %r9)
%r11 = add i192 %r7, %r10
%r12 = trunc i192 %r11 to i32
%r13 = getelementptr i32, i32* %r1, i32 1
store i32 %r12, i32* %r13
%r14 = lshr i192 %r11, 32
%r15 = getelementptr i32, i32* %r3, i32 2
%r16 = load i32, i32* %r15
%r17 = call i192 @mulUnit_inner160(i32* %r2, i32 %r16)
%r18 = add i192 %r14, %r17
%r19 = trunc i192 %r18 to i32
%r20 = getelementptr i32, i32* %r1, i32 2
store i32 %r19, i32* %r20
%r21 = lshr i192 %r18, 32
%r22 = getelementptr i32, i32* %r3, i32 3
%r23 = load i32, i32* %r22
%r24 = call i192 @mulUnit_inner160(i32* %r2, i32 %r23)
%r25 = add i192 %r21, %r24
%r26 = trunc i192 %r25 to i32
%r27 = getelementptr i32, i32* %r1, i32 3
store i32 %r26, i32* %r27
%r28 = lshr i192 %r25, 32
%r29 = getelementptr i32, i32* %r3, i32 4
%r30 = load i32, i32* %r29
%r31 = call i192 @mulUnit_inner160(i32* %r2, i32 %r30)
%r32 = add i192 %r28, %r31
%r33 = getelementptr i32, i32* %r1, i32 4
%r34 = bitcast i32* %r33 to i192*
store i192 %r32, i192* %r34
ret void
}
define void @mclb_sqr5(i32* noalias %r1, i32* noalias %r2)
{
%r3 = load i32, i32* %r2
%r4 = call i192 @mulUnit_inner160(i32* %r2, i32 %r3)
%r5 = trunc i192 %r4 to i32
store i32 %r5, i32* %r1
%r6 = lshr i192 %r4, 32
%r7 = getelementptr i32, i32* %r2, i32 1
%r8 = load i32, i32* %r7
%r9 = call i192 @mulUnit_inner160(i32* %r2, i32 %r8)
%r10 = add i192 %r6, %r9
%r11 = trunc i192 %r10 to i32
%r12 = getelementptr i32, i32* %r1, i32 1
store i32 %r11, i32* %r12
%r13 = lshr i192 %r10, 32
%r14 = getelementptr i32, i32* %r2, i32 2
%r15 = load i32, i32* %r14
%r16 = call i192 @mulUnit_inner160(i32* %r2, i32 %r15)
%r17 = add i192 %r13, %r16
%r18 = trunc i192 %r17 to i32
%r19 = getelementptr i32, i32* %r1, i32 2
store i32 %r18, i32* %r19
%r20 = lshr i192 %r17, 32
%r21 = getelementptr i32, i32* %r2, i32 3
%r22 = load i32, i32* %r21
%r23 = call i192 @mulUnit_inner160(i32* %r2, i32 %r22)
%r24 = add i192 %r20, %r23
%r25 = trunc i192 %r24 to i32
%r26 = getelementptr i32, i32* %r1, i32 3
store i32 %r25, i32* %r26
%r27 = lshr i192 %r24, 32
%r28 = getelementptr i32, i32* %r2, i32 4
%r29 = load i32, i32* %r28
%r30 = call i192 @mulUnit_inner160(i32* %r2, i32 %r29)
%r31 = add i192 %r27, %r30
%r32 = getelementptr i32, i32* %r1, i32 4
%r33 = bitcast i32* %r32 to i192*
store i192 %r31, i192* %r33
ret void
}
define i224 @mulUnit_inner192(i32* noalias %r2, i32 %r3)
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
define i32 @mclb_mulUnit6(i32* noalias %r1, i32* noalias %r2, i32 %r3)
{
%r5 = call i224 @mulUnit_inner192(i32* %r2, i32 %r3)
%r6 = trunc i224 %r5 to i192
%r7 = bitcast i32* %r1 to i192*
store i192 %r6, i192* %r7
%r8 = lshr i224 %r5, 192
%r9 = trunc i224 %r8 to i32
ret i32 %r9
}
define i32 @mclb_mulUnitAdd6(i32* noalias %r1, i32* noalias %r2, i32 %r3)
{
%r5 = call i64 @mulPos32x32(i32* %r2, i32 %r3, i32 0)
%r6 = trunc i64 %r5 to i32
%r7 = call i32 @extractHigh32(i64 %r5)
%r8 = call i64 @mulPos32x32(i32* %r2, i32 %r3, i32 1)
%r9 = trunc i64 %r8 to i32
%r10 = call i32 @extractHigh32(i64 %r8)
%r11 = call i64 @mulPos32x32(i32* %r2, i32 %r3, i32 2)
%r12 = trunc i64 %r11 to i32
%r13 = call i32 @extractHigh32(i64 %r11)
%r14 = call i64 @mulPos32x32(i32* %r2, i32 %r3, i32 3)
%r15 = trunc i64 %r14 to i32
%r16 = call i32 @extractHigh32(i64 %r14)
%r17 = call i64 @mulPos32x32(i32* %r2, i32 %r3, i32 4)
%r18 = trunc i64 %r17 to i32
%r19 = call i32 @extractHigh32(i64 %r17)
%r20 = call i64 @mulPos32x32(i32* %r2, i32 %r3, i32 5)
%r21 = trunc i64 %r20 to i32
%r22 = call i32 @extractHigh32(i64 %r20)
%r23 = zext i32 %r6 to i64
%r24 = zext i32 %r9 to i64
%r25 = shl i64 %r24, 32
%r26 = or i64 %r23, %r25
%r27 = zext i64 %r26 to i96
%r28 = zext i32 %r12 to i96
%r29 = shl i96 %r28, 64
%r30 = or i96 %r27, %r29
%r31 = zext i96 %r30 to i128
%r32 = zext i32 %r15 to i128
%r33 = shl i128 %r32, 96
%r34 = or i128 %r31, %r33
%r35 = zext i128 %r34 to i160
%r36 = zext i32 %r18 to i160
%r37 = shl i160 %r36, 128
%r38 = or i160 %r35, %r37
%r39 = zext i160 %r38 to i192
%r40 = zext i32 %r21 to i192
%r41 = shl i192 %r40, 160
%r42 = or i192 %r39, %r41
%r43 = zext i32 %r7 to i64
%r44 = zext i32 %r10 to i64
%r45 = shl i64 %r44, 32
%r46 = or i64 %r43, %r45
%r47 = zext i64 %r46 to i96
%r48 = zext i32 %r13 to i96
%r49 = shl i96 %r48, 64
%r50 = or i96 %r47, %r49
%r51 = zext i96 %r50 to i128
%r52 = zext i32 %r16 to i128
%r53 = shl i128 %r52, 96
%r54 = or i128 %r51, %r53
%r55 = zext i128 %r54 to i160
%r56 = zext i32 %r19 to i160
%r57 = shl i160 %r56, 128
%r58 = or i160 %r55, %r57
%r59 = zext i160 %r58 to i192
%r60 = zext i32 %r22 to i192
%r61 = shl i192 %r60, 160
%r62 = or i192 %r59, %r61
%r63 = zext i192 %r42 to i224
%r64 = zext i192 %r62 to i224
%r65 = shl i224 %r64, 32
%r66 = add i224 %r63, %r65
%r67 = bitcast i32* %r1 to i192*
%r68 = load i192, i192* %r67
%r69 = zext i192 %r68 to i224
%r70 = add i224 %r66, %r69
%r71 = trunc i224 %r70 to i192
%r72 = bitcast i32* %r1 to i192*
store i192 %r71, i192* %r72
%r73 = lshr i224 %r70, 192
%r74 = trunc i224 %r73 to i32
ret i32 %r74
}
define void @mclb_mul6(i32* noalias %r1, i32* noalias %r2, i32* noalias %r3)
{
%r4 = load i32, i32* %r3
%r5 = call i224 @mulUnit_inner192(i32* %r2, i32 %r4)
%r6 = trunc i224 %r5 to i32
store i32 %r6, i32* %r1
%r7 = lshr i224 %r5, 32
%r8 = getelementptr i32, i32* %r3, i32 1
%r9 = load i32, i32* %r8
%r10 = call i224 @mulUnit_inner192(i32* %r2, i32 %r9)
%r11 = add i224 %r7, %r10
%r12 = trunc i224 %r11 to i32
%r13 = getelementptr i32, i32* %r1, i32 1
store i32 %r12, i32* %r13
%r14 = lshr i224 %r11, 32
%r15 = getelementptr i32, i32* %r3, i32 2
%r16 = load i32, i32* %r15
%r17 = call i224 @mulUnit_inner192(i32* %r2, i32 %r16)
%r18 = add i224 %r14, %r17
%r19 = trunc i224 %r18 to i32
%r20 = getelementptr i32, i32* %r1, i32 2
store i32 %r19, i32* %r20
%r21 = lshr i224 %r18, 32
%r22 = getelementptr i32, i32* %r3, i32 3
%r23 = load i32, i32* %r22
%r24 = call i224 @mulUnit_inner192(i32* %r2, i32 %r23)
%r25 = add i224 %r21, %r24
%r26 = trunc i224 %r25 to i32
%r27 = getelementptr i32, i32* %r1, i32 3
store i32 %r26, i32* %r27
%r28 = lshr i224 %r25, 32
%r29 = getelementptr i32, i32* %r3, i32 4
%r30 = load i32, i32* %r29
%r31 = call i224 @mulUnit_inner192(i32* %r2, i32 %r30)
%r32 = add i224 %r28, %r31
%r33 = trunc i224 %r32 to i32
%r34 = getelementptr i32, i32* %r1, i32 4
store i32 %r33, i32* %r34
%r35 = lshr i224 %r32, 32
%r36 = getelementptr i32, i32* %r3, i32 5
%r37 = load i32, i32* %r36
%r38 = call i224 @mulUnit_inner192(i32* %r2, i32 %r37)
%r39 = add i224 %r35, %r38
%r40 = getelementptr i32, i32* %r1, i32 5
%r41 = bitcast i32* %r40 to i224*
store i224 %r39, i224* %r41
ret void
}
define void @mclb_sqr6(i32* noalias %r1, i32* noalias %r2)
{
%r3 = load i32, i32* %r2
%r4 = call i224 @mulUnit_inner192(i32* %r2, i32 %r3)
%r5 = trunc i224 %r4 to i32
store i32 %r5, i32* %r1
%r6 = lshr i224 %r4, 32
%r7 = getelementptr i32, i32* %r2, i32 1
%r8 = load i32, i32* %r7
%r9 = call i224 @mulUnit_inner192(i32* %r2, i32 %r8)
%r10 = add i224 %r6, %r9
%r11 = trunc i224 %r10 to i32
%r12 = getelementptr i32, i32* %r1, i32 1
store i32 %r11, i32* %r12
%r13 = lshr i224 %r10, 32
%r14 = getelementptr i32, i32* %r2, i32 2
%r15 = load i32, i32* %r14
%r16 = call i224 @mulUnit_inner192(i32* %r2, i32 %r15)
%r17 = add i224 %r13, %r16
%r18 = trunc i224 %r17 to i32
%r19 = getelementptr i32, i32* %r1, i32 2
store i32 %r18, i32* %r19
%r20 = lshr i224 %r17, 32
%r21 = getelementptr i32, i32* %r2, i32 3
%r22 = load i32, i32* %r21
%r23 = call i224 @mulUnit_inner192(i32* %r2, i32 %r22)
%r24 = add i224 %r20, %r23
%r25 = trunc i224 %r24 to i32
%r26 = getelementptr i32, i32* %r1, i32 3
store i32 %r25, i32* %r26
%r27 = lshr i224 %r24, 32
%r28 = getelementptr i32, i32* %r2, i32 4
%r29 = load i32, i32* %r28
%r30 = call i224 @mulUnit_inner192(i32* %r2, i32 %r29)
%r31 = add i224 %r27, %r30
%r32 = trunc i224 %r31 to i32
%r33 = getelementptr i32, i32* %r1, i32 4
store i32 %r32, i32* %r33
%r34 = lshr i224 %r31, 32
%r35 = getelementptr i32, i32* %r2, i32 5
%r36 = load i32, i32* %r35
%r37 = call i224 @mulUnit_inner192(i32* %r2, i32 %r36)
%r38 = add i224 %r34, %r37
%r39 = getelementptr i32, i32* %r1, i32 5
%r40 = bitcast i32* %r39 to i224*
store i224 %r38, i224* %r40
ret void
}
define i256 @mulUnit_inner224(i32* noalias %r2, i32 %r3)
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
define i32 @mclb_mulUnit7(i32* noalias %r1, i32* noalias %r2, i32 %r3)
{
%r5 = call i256 @mulUnit_inner224(i32* %r2, i32 %r3)
%r6 = trunc i256 %r5 to i224
%r7 = bitcast i32* %r1 to i224*
store i224 %r6, i224* %r7
%r8 = lshr i256 %r5, 224
%r9 = trunc i256 %r8 to i32
ret i32 %r9
}
define i32 @mclb_mulUnitAdd7(i32* noalias %r1, i32* noalias %r2, i32 %r3)
{
%r5 = call i64 @mulPos32x32(i32* %r2, i32 %r3, i32 0)
%r6 = trunc i64 %r5 to i32
%r7 = call i32 @extractHigh32(i64 %r5)
%r8 = call i64 @mulPos32x32(i32* %r2, i32 %r3, i32 1)
%r9 = trunc i64 %r8 to i32
%r10 = call i32 @extractHigh32(i64 %r8)
%r11 = call i64 @mulPos32x32(i32* %r2, i32 %r3, i32 2)
%r12 = trunc i64 %r11 to i32
%r13 = call i32 @extractHigh32(i64 %r11)
%r14 = call i64 @mulPos32x32(i32* %r2, i32 %r3, i32 3)
%r15 = trunc i64 %r14 to i32
%r16 = call i32 @extractHigh32(i64 %r14)
%r17 = call i64 @mulPos32x32(i32* %r2, i32 %r3, i32 4)
%r18 = trunc i64 %r17 to i32
%r19 = call i32 @extractHigh32(i64 %r17)
%r20 = call i64 @mulPos32x32(i32* %r2, i32 %r3, i32 5)
%r21 = trunc i64 %r20 to i32
%r22 = call i32 @extractHigh32(i64 %r20)
%r23 = call i64 @mulPos32x32(i32* %r2, i32 %r3, i32 6)
%r24 = trunc i64 %r23 to i32
%r25 = call i32 @extractHigh32(i64 %r23)
%r26 = zext i32 %r6 to i64
%r27 = zext i32 %r9 to i64
%r28 = shl i64 %r27, 32
%r29 = or i64 %r26, %r28
%r30 = zext i64 %r29 to i96
%r31 = zext i32 %r12 to i96
%r32 = shl i96 %r31, 64
%r33 = or i96 %r30, %r32
%r34 = zext i96 %r33 to i128
%r35 = zext i32 %r15 to i128
%r36 = shl i128 %r35, 96
%r37 = or i128 %r34, %r36
%r38 = zext i128 %r37 to i160
%r39 = zext i32 %r18 to i160
%r40 = shl i160 %r39, 128
%r41 = or i160 %r38, %r40
%r42 = zext i160 %r41 to i192
%r43 = zext i32 %r21 to i192
%r44 = shl i192 %r43, 160
%r45 = or i192 %r42, %r44
%r46 = zext i192 %r45 to i224
%r47 = zext i32 %r24 to i224
%r48 = shl i224 %r47, 192
%r49 = or i224 %r46, %r48
%r50 = zext i32 %r7 to i64
%r51 = zext i32 %r10 to i64
%r52 = shl i64 %r51, 32
%r53 = or i64 %r50, %r52
%r54 = zext i64 %r53 to i96
%r55 = zext i32 %r13 to i96
%r56 = shl i96 %r55, 64
%r57 = or i96 %r54, %r56
%r58 = zext i96 %r57 to i128
%r59 = zext i32 %r16 to i128
%r60 = shl i128 %r59, 96
%r61 = or i128 %r58, %r60
%r62 = zext i128 %r61 to i160
%r63 = zext i32 %r19 to i160
%r64 = shl i160 %r63, 128
%r65 = or i160 %r62, %r64
%r66 = zext i160 %r65 to i192
%r67 = zext i32 %r22 to i192
%r68 = shl i192 %r67, 160
%r69 = or i192 %r66, %r68
%r70 = zext i192 %r69 to i224
%r71 = zext i32 %r25 to i224
%r72 = shl i224 %r71, 192
%r73 = or i224 %r70, %r72
%r74 = zext i224 %r49 to i256
%r75 = zext i224 %r73 to i256
%r76 = shl i256 %r75, 32
%r77 = add i256 %r74, %r76
%r78 = bitcast i32* %r1 to i224*
%r79 = load i224, i224* %r78
%r80 = zext i224 %r79 to i256
%r81 = add i256 %r77, %r80
%r82 = trunc i256 %r81 to i224
%r83 = bitcast i32* %r1 to i224*
store i224 %r82, i224* %r83
%r84 = lshr i256 %r81, 224
%r85 = trunc i256 %r84 to i32
ret i32 %r85
}
define void @mclb_mul7(i32* noalias %r1, i32* noalias %r2, i32* noalias %r3)
{
%r4 = load i32, i32* %r3
%r5 = call i256 @mulUnit_inner224(i32* %r2, i32 %r4)
%r6 = trunc i256 %r5 to i32
store i32 %r6, i32* %r1
%r7 = lshr i256 %r5, 32
%r8 = getelementptr i32, i32* %r3, i32 1
%r9 = load i32, i32* %r8
%r10 = call i256 @mulUnit_inner224(i32* %r2, i32 %r9)
%r11 = add i256 %r7, %r10
%r12 = trunc i256 %r11 to i32
%r13 = getelementptr i32, i32* %r1, i32 1
store i32 %r12, i32* %r13
%r14 = lshr i256 %r11, 32
%r15 = getelementptr i32, i32* %r3, i32 2
%r16 = load i32, i32* %r15
%r17 = call i256 @mulUnit_inner224(i32* %r2, i32 %r16)
%r18 = add i256 %r14, %r17
%r19 = trunc i256 %r18 to i32
%r20 = getelementptr i32, i32* %r1, i32 2
store i32 %r19, i32* %r20
%r21 = lshr i256 %r18, 32
%r22 = getelementptr i32, i32* %r3, i32 3
%r23 = load i32, i32* %r22
%r24 = call i256 @mulUnit_inner224(i32* %r2, i32 %r23)
%r25 = add i256 %r21, %r24
%r26 = trunc i256 %r25 to i32
%r27 = getelementptr i32, i32* %r1, i32 3
store i32 %r26, i32* %r27
%r28 = lshr i256 %r25, 32
%r29 = getelementptr i32, i32* %r3, i32 4
%r30 = load i32, i32* %r29
%r31 = call i256 @mulUnit_inner224(i32* %r2, i32 %r30)
%r32 = add i256 %r28, %r31
%r33 = trunc i256 %r32 to i32
%r34 = getelementptr i32, i32* %r1, i32 4
store i32 %r33, i32* %r34
%r35 = lshr i256 %r32, 32
%r36 = getelementptr i32, i32* %r3, i32 5
%r37 = load i32, i32* %r36
%r38 = call i256 @mulUnit_inner224(i32* %r2, i32 %r37)
%r39 = add i256 %r35, %r38
%r40 = trunc i256 %r39 to i32
%r41 = getelementptr i32, i32* %r1, i32 5
store i32 %r40, i32* %r41
%r42 = lshr i256 %r39, 32
%r43 = getelementptr i32, i32* %r3, i32 6
%r44 = load i32, i32* %r43
%r45 = call i256 @mulUnit_inner224(i32* %r2, i32 %r44)
%r46 = add i256 %r42, %r45
%r47 = getelementptr i32, i32* %r1, i32 6
%r48 = bitcast i32* %r47 to i256*
store i256 %r46, i256* %r48
ret void
}
define void @mclb_sqr7(i32* noalias %r1, i32* noalias %r2)
{
%r3 = load i32, i32* %r2
%r4 = call i64 @mul32x32L(i32 %r3, i32 %r3)
%r5 = trunc i64 %r4 to i32
store i32 %r5, i32* %r1
%r6 = lshr i64 %r4, 32
%r7 = getelementptr i32, i32* %r2, i32 6
%r8 = load i32, i32* %r7
%r9 = call i64 @mul32x32L(i32 %r3, i32 %r8)
%r10 = load i32, i32* %r2
%r11 = getelementptr i32, i32* %r2, i32 5
%r12 = load i32, i32* %r11
%r13 = call i64 @mul32x32L(i32 %r10, i32 %r12)
%r14 = getelementptr i32, i32* %r2, i32 1
%r15 = load i32, i32* %r14
%r16 = getelementptr i32, i32* %r2, i32 6
%r17 = load i32, i32* %r16
%r18 = call i64 @mul32x32L(i32 %r15, i32 %r17)
%r19 = zext i64 %r13 to i128
%r20 = zext i64 %r18 to i128
%r21 = shl i128 %r20, 64
%r22 = or i128 %r19, %r21
%r23 = zext i64 %r9 to i128
%r24 = shl i128 %r23, 32
%r25 = add i128 %r24, %r22
%r26 = load i32, i32* %r2
%r27 = getelementptr i32, i32* %r2, i32 4
%r28 = load i32, i32* %r27
%r29 = call i64 @mul32x32L(i32 %r26, i32 %r28)
%r30 = getelementptr i32, i32* %r2, i32 1
%r31 = load i32, i32* %r30
%r32 = getelementptr i32, i32* %r2, i32 5
%r33 = load i32, i32* %r32
%r34 = call i64 @mul32x32L(i32 %r31, i32 %r33)
%r35 = zext i64 %r29 to i128
%r36 = zext i64 %r34 to i128
%r37 = shl i128 %r36, 64
%r38 = or i128 %r35, %r37
%r39 = getelementptr i32, i32* %r2, i32 2
%r40 = load i32, i32* %r39
%r41 = getelementptr i32, i32* %r2, i32 6
%r42 = load i32, i32* %r41
%r43 = call i64 @mul32x32L(i32 %r40, i32 %r42)
%r44 = zext i128 %r38 to i192
%r45 = zext i64 %r43 to i192
%r46 = shl i192 %r45, 128
%r47 = or i192 %r44, %r46
%r48 = zext i128 %r25 to i192
%r49 = shl i192 %r48, 32
%r50 = add i192 %r49, %r47
%r51 = load i32, i32* %r2
%r52 = getelementptr i32, i32* %r2, i32 3
%r53 = load i32, i32* %r52
%r54 = call i64 @mul32x32L(i32 %r51, i32 %r53)
%r55 = getelementptr i32, i32* %r2, i32 1
%r56 = load i32, i32* %r55
%r57 = getelementptr i32, i32* %r2, i32 4
%r58 = load i32, i32* %r57
%r59 = call i64 @mul32x32L(i32 %r56, i32 %r58)
%r60 = zext i64 %r54 to i128
%r61 = zext i64 %r59 to i128
%r62 = shl i128 %r61, 64
%r63 = or i128 %r60, %r62
%r64 = getelementptr i32, i32* %r2, i32 2
%r65 = load i32, i32* %r64
%r66 = getelementptr i32, i32* %r2, i32 5
%r67 = load i32, i32* %r66
%r68 = call i64 @mul32x32L(i32 %r65, i32 %r67)
%r69 = zext i128 %r63 to i192
%r70 = zext i64 %r68 to i192
%r71 = shl i192 %r70, 128
%r72 = or i192 %r69, %r71
%r73 = getelementptr i32, i32* %r2, i32 3
%r74 = load i32, i32* %r73
%r75 = getelementptr i32, i32* %r2, i32 6
%r76 = load i32, i32* %r75
%r77 = call i64 @mul32x32L(i32 %r74, i32 %r76)
%r78 = zext i192 %r72 to i256
%r79 = zext i64 %r77 to i256
%r80 = shl i256 %r79, 192
%r81 = or i256 %r78, %r80
%r82 = zext i192 %r50 to i256
%r83 = shl i256 %r82, 32
%r84 = add i256 %r83, %r81
%r85 = load i32, i32* %r2
%r86 = getelementptr i32, i32* %r2, i32 2
%r87 = load i32, i32* %r86
%r88 = call i64 @mul32x32L(i32 %r85, i32 %r87)
%r89 = getelementptr i32, i32* %r2, i32 1
%r90 = load i32, i32* %r89
%r91 = getelementptr i32, i32* %r2, i32 3
%r92 = load i32, i32* %r91
%r93 = call i64 @mul32x32L(i32 %r90, i32 %r92)
%r94 = zext i64 %r88 to i128
%r95 = zext i64 %r93 to i128
%r96 = shl i128 %r95, 64
%r97 = or i128 %r94, %r96
%r98 = getelementptr i32, i32* %r2, i32 2
%r99 = load i32, i32* %r98
%r100 = getelementptr i32, i32* %r2, i32 4
%r101 = load i32, i32* %r100
%r102 = call i64 @mul32x32L(i32 %r99, i32 %r101)
%r103 = zext i128 %r97 to i192
%r104 = zext i64 %r102 to i192
%r105 = shl i192 %r104, 128
%r106 = or i192 %r103, %r105
%r107 = getelementptr i32, i32* %r2, i32 3
%r108 = load i32, i32* %r107
%r109 = getelementptr i32, i32* %r2, i32 5
%r110 = load i32, i32* %r109
%r111 = call i64 @mul32x32L(i32 %r108, i32 %r110)
%r112 = zext i192 %r106 to i256
%r113 = zext i64 %r111 to i256
%r114 = shl i256 %r113, 192
%r115 = or i256 %r112, %r114
%r116 = getelementptr i32, i32* %r2, i32 4
%r117 = load i32, i32* %r116
%r118 = getelementptr i32, i32* %r2, i32 6
%r119 = load i32, i32* %r118
%r120 = call i64 @mul32x32L(i32 %r117, i32 %r119)
%r121 = zext i256 %r115 to i320
%r122 = zext i64 %r120 to i320
%r123 = shl i320 %r122, 256
%r124 = or i320 %r121, %r123
%r125 = zext i256 %r84 to i320
%r126 = shl i320 %r125, 32
%r127 = add i320 %r126, %r124
%r128 = load i32, i32* %r2
%r129 = getelementptr i32, i32* %r2, i32 1
%r130 = load i32, i32* %r129
%r131 = call i64 @mul32x32L(i32 %r128, i32 %r130)
%r132 = getelementptr i32, i32* %r2, i32 1
%r133 = load i32, i32* %r132
%r134 = getelementptr i32, i32* %r2, i32 2
%r135 = load i32, i32* %r134
%r136 = call i64 @mul32x32L(i32 %r133, i32 %r135)
%r137 = zext i64 %r131 to i128
%r138 = zext i64 %r136 to i128
%r139 = shl i128 %r138, 64
%r140 = or i128 %r137, %r139
%r141 = getelementptr i32, i32* %r2, i32 2
%r142 = load i32, i32* %r141
%r143 = getelementptr i32, i32* %r2, i32 3
%r144 = load i32, i32* %r143
%r145 = call i64 @mul32x32L(i32 %r142, i32 %r144)
%r146 = zext i128 %r140 to i192
%r147 = zext i64 %r145 to i192
%r148 = shl i192 %r147, 128
%r149 = or i192 %r146, %r148
%r150 = getelementptr i32, i32* %r2, i32 3
%r151 = load i32, i32* %r150
%r152 = getelementptr i32, i32* %r2, i32 4
%r153 = load i32, i32* %r152
%r154 = call i64 @mul32x32L(i32 %r151, i32 %r153)
%r155 = zext i192 %r149 to i256
%r156 = zext i64 %r154 to i256
%r157 = shl i256 %r156, 192
%r158 = or i256 %r155, %r157
%r159 = getelementptr i32, i32* %r2, i32 4
%r160 = load i32, i32* %r159
%r161 = getelementptr i32, i32* %r2, i32 5
%r162 = load i32, i32* %r161
%r163 = call i64 @mul32x32L(i32 %r160, i32 %r162)
%r164 = zext i256 %r158 to i320
%r165 = zext i64 %r163 to i320
%r166 = shl i320 %r165, 256
%r167 = or i320 %r164, %r166
%r168 = getelementptr i32, i32* %r2, i32 5
%r169 = load i32, i32* %r168
%r170 = getelementptr i32, i32* %r2, i32 6
%r171 = load i32, i32* %r170
%r172 = call i64 @mul32x32L(i32 %r169, i32 %r171)
%r173 = zext i320 %r167 to i384
%r174 = zext i64 %r172 to i384
%r175 = shl i384 %r174, 320
%r176 = or i384 %r173, %r175
%r177 = zext i320 %r127 to i384
%r178 = shl i384 %r177, 32
%r179 = add i384 %r178, %r176
%r180 = zext i64 %r6 to i416
%r181 = getelementptr i32, i32* %r2, i32 1
%r182 = load i32, i32* %r181
%r183 = call i64 @mul32x32L(i32 %r182, i32 %r182)
%r184 = zext i64 %r183 to i416
%r185 = shl i416 %r184, 32
%r186 = or i416 %r180, %r185
%r187 = getelementptr i32, i32* %r2, i32 2
%r188 = load i32, i32* %r187
%r189 = call i64 @mul32x32L(i32 %r188, i32 %r188)
%r190 = zext i64 %r189 to i416
%r191 = shl i416 %r190, 96
%r192 = or i416 %r186, %r191
%r193 = getelementptr i32, i32* %r2, i32 3
%r194 = load i32, i32* %r193
%r195 = call i64 @mul32x32L(i32 %r194, i32 %r194)
%r196 = zext i64 %r195 to i416
%r197 = shl i416 %r196, 160
%r198 = or i416 %r192, %r197
%r199 = getelementptr i32, i32* %r2, i32 4
%r200 = load i32, i32* %r199
%r201 = call i64 @mul32x32L(i32 %r200, i32 %r200)
%r202 = zext i64 %r201 to i416
%r203 = shl i416 %r202, 224
%r204 = or i416 %r198, %r203
%r205 = getelementptr i32, i32* %r2, i32 5
%r206 = load i32, i32* %r205
%r207 = call i64 @mul32x32L(i32 %r206, i32 %r206)
%r208 = zext i64 %r207 to i416
%r209 = shl i416 %r208, 288
%r210 = or i416 %r204, %r209
%r211 = getelementptr i32, i32* %r2, i32 6
%r212 = load i32, i32* %r211
%r213 = call i64 @mul32x32L(i32 %r212, i32 %r212)
%r214 = zext i64 %r213 to i416
%r215 = shl i416 %r214, 352
%r216 = or i416 %r210, %r215
%r217 = zext i384 %r179 to i416
%r218 = add i416 %r217, %r217
%r219 = add i416 %r216, %r218
%r220 = getelementptr i32, i32* %r1, i32 1
%r221 = bitcast i32* %r220 to i416*
store i416 %r219, i416* %r221
ret void
}
define i288 @mulUnit_inner256(i32* noalias %r2, i32 %r3)
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
define i32 @mclb_mulUnit8(i32* noalias %r1, i32* noalias %r2, i32 %r3)
{
%r5 = call i288 @mulUnit_inner256(i32* %r2, i32 %r3)
%r6 = trunc i288 %r5 to i256
%r7 = bitcast i32* %r1 to i256*
store i256 %r6, i256* %r7
%r8 = lshr i288 %r5, 256
%r9 = trunc i288 %r8 to i32
ret i32 %r9
}
define i32 @mclb_mulUnitAdd8(i32* noalias %r1, i32* noalias %r2, i32 %r3)
{
%r5 = call i64 @mulPos32x32(i32* %r2, i32 %r3, i32 0)
%r6 = trunc i64 %r5 to i32
%r7 = call i32 @extractHigh32(i64 %r5)
%r8 = call i64 @mulPos32x32(i32* %r2, i32 %r3, i32 1)
%r9 = trunc i64 %r8 to i32
%r10 = call i32 @extractHigh32(i64 %r8)
%r11 = call i64 @mulPos32x32(i32* %r2, i32 %r3, i32 2)
%r12 = trunc i64 %r11 to i32
%r13 = call i32 @extractHigh32(i64 %r11)
%r14 = call i64 @mulPos32x32(i32* %r2, i32 %r3, i32 3)
%r15 = trunc i64 %r14 to i32
%r16 = call i32 @extractHigh32(i64 %r14)
%r17 = call i64 @mulPos32x32(i32* %r2, i32 %r3, i32 4)
%r18 = trunc i64 %r17 to i32
%r19 = call i32 @extractHigh32(i64 %r17)
%r20 = call i64 @mulPos32x32(i32* %r2, i32 %r3, i32 5)
%r21 = trunc i64 %r20 to i32
%r22 = call i32 @extractHigh32(i64 %r20)
%r23 = call i64 @mulPos32x32(i32* %r2, i32 %r3, i32 6)
%r24 = trunc i64 %r23 to i32
%r25 = call i32 @extractHigh32(i64 %r23)
%r26 = call i64 @mulPos32x32(i32* %r2, i32 %r3, i32 7)
%r27 = trunc i64 %r26 to i32
%r28 = call i32 @extractHigh32(i64 %r26)
%r29 = zext i32 %r6 to i64
%r30 = zext i32 %r9 to i64
%r31 = shl i64 %r30, 32
%r32 = or i64 %r29, %r31
%r33 = zext i64 %r32 to i96
%r34 = zext i32 %r12 to i96
%r35 = shl i96 %r34, 64
%r36 = or i96 %r33, %r35
%r37 = zext i96 %r36 to i128
%r38 = zext i32 %r15 to i128
%r39 = shl i128 %r38, 96
%r40 = or i128 %r37, %r39
%r41 = zext i128 %r40 to i160
%r42 = zext i32 %r18 to i160
%r43 = shl i160 %r42, 128
%r44 = or i160 %r41, %r43
%r45 = zext i160 %r44 to i192
%r46 = zext i32 %r21 to i192
%r47 = shl i192 %r46, 160
%r48 = or i192 %r45, %r47
%r49 = zext i192 %r48 to i224
%r50 = zext i32 %r24 to i224
%r51 = shl i224 %r50, 192
%r52 = or i224 %r49, %r51
%r53 = zext i224 %r52 to i256
%r54 = zext i32 %r27 to i256
%r55 = shl i256 %r54, 224
%r56 = or i256 %r53, %r55
%r57 = zext i32 %r7 to i64
%r58 = zext i32 %r10 to i64
%r59 = shl i64 %r58, 32
%r60 = or i64 %r57, %r59
%r61 = zext i64 %r60 to i96
%r62 = zext i32 %r13 to i96
%r63 = shl i96 %r62, 64
%r64 = or i96 %r61, %r63
%r65 = zext i96 %r64 to i128
%r66 = zext i32 %r16 to i128
%r67 = shl i128 %r66, 96
%r68 = or i128 %r65, %r67
%r69 = zext i128 %r68 to i160
%r70 = zext i32 %r19 to i160
%r71 = shl i160 %r70, 128
%r72 = or i160 %r69, %r71
%r73 = zext i160 %r72 to i192
%r74 = zext i32 %r22 to i192
%r75 = shl i192 %r74, 160
%r76 = or i192 %r73, %r75
%r77 = zext i192 %r76 to i224
%r78 = zext i32 %r25 to i224
%r79 = shl i224 %r78, 192
%r80 = or i224 %r77, %r79
%r81 = zext i224 %r80 to i256
%r82 = zext i32 %r28 to i256
%r83 = shl i256 %r82, 224
%r84 = or i256 %r81, %r83
%r85 = zext i256 %r56 to i288
%r86 = zext i256 %r84 to i288
%r87 = shl i288 %r86, 32
%r88 = add i288 %r85, %r87
%r89 = bitcast i32* %r1 to i256*
%r90 = load i256, i256* %r89
%r91 = zext i256 %r90 to i288
%r92 = add i288 %r88, %r91
%r93 = trunc i288 %r92 to i256
%r94 = bitcast i32* %r1 to i256*
store i256 %r93, i256* %r94
%r95 = lshr i288 %r92, 256
%r96 = trunc i288 %r95 to i32
ret i32 %r96
}
define void @mclb_mul8(i32* noalias %r1, i32* noalias %r2, i32* noalias %r3)
{
%r4 = load i32, i32* %r3
%r5 = call i288 @mulUnit_inner256(i32* %r2, i32 %r4)
%r6 = trunc i288 %r5 to i32
store i32 %r6, i32* %r1
%r7 = lshr i288 %r5, 32
%r8 = getelementptr i32, i32* %r3, i32 1
%r9 = load i32, i32* %r8
%r10 = call i288 @mulUnit_inner256(i32* %r2, i32 %r9)
%r11 = add i288 %r7, %r10
%r12 = trunc i288 %r11 to i32
%r13 = getelementptr i32, i32* %r1, i32 1
store i32 %r12, i32* %r13
%r14 = lshr i288 %r11, 32
%r15 = getelementptr i32, i32* %r3, i32 2
%r16 = load i32, i32* %r15
%r17 = call i288 @mulUnit_inner256(i32* %r2, i32 %r16)
%r18 = add i288 %r14, %r17
%r19 = trunc i288 %r18 to i32
%r20 = getelementptr i32, i32* %r1, i32 2
store i32 %r19, i32* %r20
%r21 = lshr i288 %r18, 32
%r22 = getelementptr i32, i32* %r3, i32 3
%r23 = load i32, i32* %r22
%r24 = call i288 @mulUnit_inner256(i32* %r2, i32 %r23)
%r25 = add i288 %r21, %r24
%r26 = trunc i288 %r25 to i32
%r27 = getelementptr i32, i32* %r1, i32 3
store i32 %r26, i32* %r27
%r28 = lshr i288 %r25, 32
%r29 = getelementptr i32, i32* %r3, i32 4
%r30 = load i32, i32* %r29
%r31 = call i288 @mulUnit_inner256(i32* %r2, i32 %r30)
%r32 = add i288 %r28, %r31
%r33 = trunc i288 %r32 to i32
%r34 = getelementptr i32, i32* %r1, i32 4
store i32 %r33, i32* %r34
%r35 = lshr i288 %r32, 32
%r36 = getelementptr i32, i32* %r3, i32 5
%r37 = load i32, i32* %r36
%r38 = call i288 @mulUnit_inner256(i32* %r2, i32 %r37)
%r39 = add i288 %r35, %r38
%r40 = trunc i288 %r39 to i32
%r41 = getelementptr i32, i32* %r1, i32 5
store i32 %r40, i32* %r41
%r42 = lshr i288 %r39, 32
%r43 = getelementptr i32, i32* %r3, i32 6
%r44 = load i32, i32* %r43
%r45 = call i288 @mulUnit_inner256(i32* %r2, i32 %r44)
%r46 = add i288 %r42, %r45
%r47 = trunc i288 %r46 to i32
%r48 = getelementptr i32, i32* %r1, i32 6
store i32 %r47, i32* %r48
%r49 = lshr i288 %r46, 32
%r50 = getelementptr i32, i32* %r3, i32 7
%r51 = load i32, i32* %r50
%r52 = call i288 @mulUnit_inner256(i32* %r2, i32 %r51)
%r53 = add i288 %r49, %r52
%r54 = getelementptr i32, i32* %r1, i32 7
%r55 = bitcast i32* %r54 to i288*
store i288 %r53, i288* %r55
ret void
}
define void @mclb_sqr8(i32* noalias %r1, i32* noalias %r2)
{
%r3 = load i32, i32* %r2
%r4 = call i64 @mul32x32L(i32 %r3, i32 %r3)
%r5 = trunc i64 %r4 to i32
store i32 %r5, i32* %r1
%r6 = lshr i64 %r4, 32
%r7 = getelementptr i32, i32* %r2, i32 7
%r8 = load i32, i32* %r7
%r9 = call i64 @mul32x32L(i32 %r3, i32 %r8)
%r10 = load i32, i32* %r2
%r11 = getelementptr i32, i32* %r2, i32 6
%r12 = load i32, i32* %r11
%r13 = call i64 @mul32x32L(i32 %r10, i32 %r12)
%r14 = getelementptr i32, i32* %r2, i32 1
%r15 = load i32, i32* %r14
%r16 = getelementptr i32, i32* %r2, i32 7
%r17 = load i32, i32* %r16
%r18 = call i64 @mul32x32L(i32 %r15, i32 %r17)
%r19 = zext i64 %r13 to i128
%r20 = zext i64 %r18 to i128
%r21 = shl i128 %r20, 64
%r22 = or i128 %r19, %r21
%r23 = zext i64 %r9 to i128
%r24 = shl i128 %r23, 32
%r25 = add i128 %r24, %r22
%r26 = load i32, i32* %r2
%r27 = getelementptr i32, i32* %r2, i32 5
%r28 = load i32, i32* %r27
%r29 = call i64 @mul32x32L(i32 %r26, i32 %r28)
%r30 = getelementptr i32, i32* %r2, i32 1
%r31 = load i32, i32* %r30
%r32 = getelementptr i32, i32* %r2, i32 6
%r33 = load i32, i32* %r32
%r34 = call i64 @mul32x32L(i32 %r31, i32 %r33)
%r35 = zext i64 %r29 to i128
%r36 = zext i64 %r34 to i128
%r37 = shl i128 %r36, 64
%r38 = or i128 %r35, %r37
%r39 = getelementptr i32, i32* %r2, i32 2
%r40 = load i32, i32* %r39
%r41 = getelementptr i32, i32* %r2, i32 7
%r42 = load i32, i32* %r41
%r43 = call i64 @mul32x32L(i32 %r40, i32 %r42)
%r44 = zext i128 %r38 to i192
%r45 = zext i64 %r43 to i192
%r46 = shl i192 %r45, 128
%r47 = or i192 %r44, %r46
%r48 = zext i128 %r25 to i192
%r49 = shl i192 %r48, 32
%r50 = add i192 %r49, %r47
%r51 = load i32, i32* %r2
%r52 = getelementptr i32, i32* %r2, i32 4
%r53 = load i32, i32* %r52
%r54 = call i64 @mul32x32L(i32 %r51, i32 %r53)
%r55 = getelementptr i32, i32* %r2, i32 1
%r56 = load i32, i32* %r55
%r57 = getelementptr i32, i32* %r2, i32 5
%r58 = load i32, i32* %r57
%r59 = call i64 @mul32x32L(i32 %r56, i32 %r58)
%r60 = zext i64 %r54 to i128
%r61 = zext i64 %r59 to i128
%r62 = shl i128 %r61, 64
%r63 = or i128 %r60, %r62
%r64 = getelementptr i32, i32* %r2, i32 2
%r65 = load i32, i32* %r64
%r66 = getelementptr i32, i32* %r2, i32 6
%r67 = load i32, i32* %r66
%r68 = call i64 @mul32x32L(i32 %r65, i32 %r67)
%r69 = zext i128 %r63 to i192
%r70 = zext i64 %r68 to i192
%r71 = shl i192 %r70, 128
%r72 = or i192 %r69, %r71
%r73 = getelementptr i32, i32* %r2, i32 3
%r74 = load i32, i32* %r73
%r75 = getelementptr i32, i32* %r2, i32 7
%r76 = load i32, i32* %r75
%r77 = call i64 @mul32x32L(i32 %r74, i32 %r76)
%r78 = zext i192 %r72 to i256
%r79 = zext i64 %r77 to i256
%r80 = shl i256 %r79, 192
%r81 = or i256 %r78, %r80
%r82 = zext i192 %r50 to i256
%r83 = shl i256 %r82, 32
%r84 = add i256 %r83, %r81
%r85 = load i32, i32* %r2
%r86 = getelementptr i32, i32* %r2, i32 3
%r87 = load i32, i32* %r86
%r88 = call i64 @mul32x32L(i32 %r85, i32 %r87)
%r89 = getelementptr i32, i32* %r2, i32 1
%r90 = load i32, i32* %r89
%r91 = getelementptr i32, i32* %r2, i32 4
%r92 = load i32, i32* %r91
%r93 = call i64 @mul32x32L(i32 %r90, i32 %r92)
%r94 = zext i64 %r88 to i128
%r95 = zext i64 %r93 to i128
%r96 = shl i128 %r95, 64
%r97 = or i128 %r94, %r96
%r98 = getelementptr i32, i32* %r2, i32 2
%r99 = load i32, i32* %r98
%r100 = getelementptr i32, i32* %r2, i32 5
%r101 = load i32, i32* %r100
%r102 = call i64 @mul32x32L(i32 %r99, i32 %r101)
%r103 = zext i128 %r97 to i192
%r104 = zext i64 %r102 to i192
%r105 = shl i192 %r104, 128
%r106 = or i192 %r103, %r105
%r107 = getelementptr i32, i32* %r2, i32 3
%r108 = load i32, i32* %r107
%r109 = getelementptr i32, i32* %r2, i32 6
%r110 = load i32, i32* %r109
%r111 = call i64 @mul32x32L(i32 %r108, i32 %r110)
%r112 = zext i192 %r106 to i256
%r113 = zext i64 %r111 to i256
%r114 = shl i256 %r113, 192
%r115 = or i256 %r112, %r114
%r116 = getelementptr i32, i32* %r2, i32 4
%r117 = load i32, i32* %r116
%r118 = getelementptr i32, i32* %r2, i32 7
%r119 = load i32, i32* %r118
%r120 = call i64 @mul32x32L(i32 %r117, i32 %r119)
%r121 = zext i256 %r115 to i320
%r122 = zext i64 %r120 to i320
%r123 = shl i320 %r122, 256
%r124 = or i320 %r121, %r123
%r125 = zext i256 %r84 to i320
%r126 = shl i320 %r125, 32
%r127 = add i320 %r126, %r124
%r128 = load i32, i32* %r2
%r129 = getelementptr i32, i32* %r2, i32 2
%r130 = load i32, i32* %r129
%r131 = call i64 @mul32x32L(i32 %r128, i32 %r130)
%r132 = getelementptr i32, i32* %r2, i32 1
%r133 = load i32, i32* %r132
%r134 = getelementptr i32, i32* %r2, i32 3
%r135 = load i32, i32* %r134
%r136 = call i64 @mul32x32L(i32 %r133, i32 %r135)
%r137 = zext i64 %r131 to i128
%r138 = zext i64 %r136 to i128
%r139 = shl i128 %r138, 64
%r140 = or i128 %r137, %r139
%r141 = getelementptr i32, i32* %r2, i32 2
%r142 = load i32, i32* %r141
%r143 = getelementptr i32, i32* %r2, i32 4
%r144 = load i32, i32* %r143
%r145 = call i64 @mul32x32L(i32 %r142, i32 %r144)
%r146 = zext i128 %r140 to i192
%r147 = zext i64 %r145 to i192
%r148 = shl i192 %r147, 128
%r149 = or i192 %r146, %r148
%r150 = getelementptr i32, i32* %r2, i32 3
%r151 = load i32, i32* %r150
%r152 = getelementptr i32, i32* %r2, i32 5
%r153 = load i32, i32* %r152
%r154 = call i64 @mul32x32L(i32 %r151, i32 %r153)
%r155 = zext i192 %r149 to i256
%r156 = zext i64 %r154 to i256
%r157 = shl i256 %r156, 192
%r158 = or i256 %r155, %r157
%r159 = getelementptr i32, i32* %r2, i32 4
%r160 = load i32, i32* %r159
%r161 = getelementptr i32, i32* %r2, i32 6
%r162 = load i32, i32* %r161
%r163 = call i64 @mul32x32L(i32 %r160, i32 %r162)
%r164 = zext i256 %r158 to i320
%r165 = zext i64 %r163 to i320
%r166 = shl i320 %r165, 256
%r167 = or i320 %r164, %r166
%r168 = getelementptr i32, i32* %r2, i32 5
%r169 = load i32, i32* %r168
%r170 = getelementptr i32, i32* %r2, i32 7
%r171 = load i32, i32* %r170
%r172 = call i64 @mul32x32L(i32 %r169, i32 %r171)
%r173 = zext i320 %r167 to i384
%r174 = zext i64 %r172 to i384
%r175 = shl i384 %r174, 320
%r176 = or i384 %r173, %r175
%r177 = zext i320 %r127 to i384
%r178 = shl i384 %r177, 32
%r179 = add i384 %r178, %r176
%r180 = load i32, i32* %r2
%r181 = getelementptr i32, i32* %r2, i32 1
%r182 = load i32, i32* %r181
%r183 = call i64 @mul32x32L(i32 %r180, i32 %r182)
%r184 = getelementptr i32, i32* %r2, i32 1
%r185 = load i32, i32* %r184
%r186 = getelementptr i32, i32* %r2, i32 2
%r187 = load i32, i32* %r186
%r188 = call i64 @mul32x32L(i32 %r185, i32 %r187)
%r189 = zext i64 %r183 to i128
%r190 = zext i64 %r188 to i128
%r191 = shl i128 %r190, 64
%r192 = or i128 %r189, %r191
%r193 = getelementptr i32, i32* %r2, i32 2
%r194 = load i32, i32* %r193
%r195 = getelementptr i32, i32* %r2, i32 3
%r196 = load i32, i32* %r195
%r197 = call i64 @mul32x32L(i32 %r194, i32 %r196)
%r198 = zext i128 %r192 to i192
%r199 = zext i64 %r197 to i192
%r200 = shl i192 %r199, 128
%r201 = or i192 %r198, %r200
%r202 = getelementptr i32, i32* %r2, i32 3
%r203 = load i32, i32* %r202
%r204 = getelementptr i32, i32* %r2, i32 4
%r205 = load i32, i32* %r204
%r206 = call i64 @mul32x32L(i32 %r203, i32 %r205)
%r207 = zext i192 %r201 to i256
%r208 = zext i64 %r206 to i256
%r209 = shl i256 %r208, 192
%r210 = or i256 %r207, %r209
%r211 = getelementptr i32, i32* %r2, i32 4
%r212 = load i32, i32* %r211
%r213 = getelementptr i32, i32* %r2, i32 5
%r214 = load i32, i32* %r213
%r215 = call i64 @mul32x32L(i32 %r212, i32 %r214)
%r216 = zext i256 %r210 to i320
%r217 = zext i64 %r215 to i320
%r218 = shl i320 %r217, 256
%r219 = or i320 %r216, %r218
%r220 = getelementptr i32, i32* %r2, i32 5
%r221 = load i32, i32* %r220
%r222 = getelementptr i32, i32* %r2, i32 6
%r223 = load i32, i32* %r222
%r224 = call i64 @mul32x32L(i32 %r221, i32 %r223)
%r225 = zext i320 %r219 to i384
%r226 = zext i64 %r224 to i384
%r227 = shl i384 %r226, 320
%r228 = or i384 %r225, %r227
%r229 = getelementptr i32, i32* %r2, i32 6
%r230 = load i32, i32* %r229
%r231 = getelementptr i32, i32* %r2, i32 7
%r232 = load i32, i32* %r231
%r233 = call i64 @mul32x32L(i32 %r230, i32 %r232)
%r234 = zext i384 %r228 to i448
%r235 = zext i64 %r233 to i448
%r236 = shl i448 %r235, 384
%r237 = or i448 %r234, %r236
%r238 = zext i384 %r179 to i448
%r239 = shl i448 %r238, 32
%r240 = add i448 %r239, %r237
%r241 = zext i64 %r6 to i480
%r242 = getelementptr i32, i32* %r2, i32 1
%r243 = load i32, i32* %r242
%r244 = call i64 @mul32x32L(i32 %r243, i32 %r243)
%r245 = zext i64 %r244 to i480
%r246 = shl i480 %r245, 32
%r247 = or i480 %r241, %r246
%r248 = getelementptr i32, i32* %r2, i32 2
%r249 = load i32, i32* %r248
%r250 = call i64 @mul32x32L(i32 %r249, i32 %r249)
%r251 = zext i64 %r250 to i480
%r252 = shl i480 %r251, 96
%r253 = or i480 %r247, %r252
%r254 = getelementptr i32, i32* %r2, i32 3
%r255 = load i32, i32* %r254
%r256 = call i64 @mul32x32L(i32 %r255, i32 %r255)
%r257 = zext i64 %r256 to i480
%r258 = shl i480 %r257, 160
%r259 = or i480 %r253, %r258
%r260 = getelementptr i32, i32* %r2, i32 4
%r261 = load i32, i32* %r260
%r262 = call i64 @mul32x32L(i32 %r261, i32 %r261)
%r263 = zext i64 %r262 to i480
%r264 = shl i480 %r263, 224
%r265 = or i480 %r259, %r264
%r266 = getelementptr i32, i32* %r2, i32 5
%r267 = load i32, i32* %r266
%r268 = call i64 @mul32x32L(i32 %r267, i32 %r267)
%r269 = zext i64 %r268 to i480
%r270 = shl i480 %r269, 288
%r271 = or i480 %r265, %r270
%r272 = getelementptr i32, i32* %r2, i32 6
%r273 = load i32, i32* %r272
%r274 = call i64 @mul32x32L(i32 %r273, i32 %r273)
%r275 = zext i64 %r274 to i480
%r276 = shl i480 %r275, 352
%r277 = or i480 %r271, %r276
%r278 = getelementptr i32, i32* %r2, i32 7
%r279 = load i32, i32* %r278
%r280 = call i64 @mul32x32L(i32 %r279, i32 %r279)
%r281 = zext i64 %r280 to i480
%r282 = shl i480 %r281, 416
%r283 = or i480 %r277, %r282
%r284 = zext i448 %r240 to i480
%r285 = add i480 %r284, %r284
%r286 = add i480 %r283, %r285
%r287 = getelementptr i32, i32* %r1, i32 1
%r288 = bitcast i32* %r287 to i480*
store i480 %r286, i480* %r288
ret void
}
define i320 @mulUnit_inner288(i32* noalias %r2, i32 %r3)
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
%r31 = zext i32 %r5 to i64
%r32 = zext i32 %r8 to i64
%r33 = shl i64 %r32, 32
%r34 = or i64 %r31, %r33
%r35 = zext i64 %r34 to i96
%r36 = zext i32 %r11 to i96
%r37 = shl i96 %r36, 64
%r38 = or i96 %r35, %r37
%r39 = zext i96 %r38 to i128
%r40 = zext i32 %r14 to i128
%r41 = shl i128 %r40, 96
%r42 = or i128 %r39, %r41
%r43 = zext i128 %r42 to i160
%r44 = zext i32 %r17 to i160
%r45 = shl i160 %r44, 128
%r46 = or i160 %r43, %r45
%r47 = zext i160 %r46 to i192
%r48 = zext i32 %r20 to i192
%r49 = shl i192 %r48, 160
%r50 = or i192 %r47, %r49
%r51 = zext i192 %r50 to i224
%r52 = zext i32 %r23 to i224
%r53 = shl i224 %r52, 192
%r54 = or i224 %r51, %r53
%r55 = zext i224 %r54 to i256
%r56 = zext i32 %r26 to i256
%r57 = shl i256 %r56, 224
%r58 = or i256 %r55, %r57
%r59 = zext i256 %r58 to i288
%r60 = zext i32 %r29 to i288
%r61 = shl i288 %r60, 256
%r62 = or i288 %r59, %r61
%r63 = zext i32 %r6 to i64
%r64 = zext i32 %r9 to i64
%r65 = shl i64 %r64, 32
%r66 = or i64 %r63, %r65
%r67 = zext i64 %r66 to i96
%r68 = zext i32 %r12 to i96
%r69 = shl i96 %r68, 64
%r70 = or i96 %r67, %r69
%r71 = zext i96 %r70 to i128
%r72 = zext i32 %r15 to i128
%r73 = shl i128 %r72, 96
%r74 = or i128 %r71, %r73
%r75 = zext i128 %r74 to i160
%r76 = zext i32 %r18 to i160
%r77 = shl i160 %r76, 128
%r78 = or i160 %r75, %r77
%r79 = zext i160 %r78 to i192
%r80 = zext i32 %r21 to i192
%r81 = shl i192 %r80, 160
%r82 = or i192 %r79, %r81
%r83 = zext i192 %r82 to i224
%r84 = zext i32 %r24 to i224
%r85 = shl i224 %r84, 192
%r86 = or i224 %r83, %r85
%r87 = zext i224 %r86 to i256
%r88 = zext i32 %r27 to i256
%r89 = shl i256 %r88, 224
%r90 = or i256 %r87, %r89
%r91 = zext i256 %r90 to i288
%r92 = zext i32 %r30 to i288
%r93 = shl i288 %r92, 256
%r94 = or i288 %r91, %r93
%r95 = zext i288 %r62 to i320
%r96 = zext i288 %r94 to i320
%r97 = shl i320 %r96, 32
%r98 = add i320 %r95, %r97
ret i320 %r98
}
define i32 @mclb_mulUnit9(i32* noalias %r1, i32* noalias %r2, i32 %r3)
{
%r5 = call i320 @mulUnit_inner288(i32* %r2, i32 %r3)
%r6 = trunc i320 %r5 to i288
%r7 = bitcast i32* %r1 to i288*
store i288 %r6, i288* %r7
%r8 = lshr i320 %r5, 288
%r9 = trunc i320 %r8 to i32
ret i32 %r9
}
define i32 @mclb_mulUnitAdd9(i32* noalias %r1, i32* noalias %r2, i32 %r3)
{
%r5 = call i64 @mulPos32x32(i32* %r2, i32 %r3, i32 0)
%r6 = trunc i64 %r5 to i32
%r7 = call i32 @extractHigh32(i64 %r5)
%r8 = call i64 @mulPos32x32(i32* %r2, i32 %r3, i32 1)
%r9 = trunc i64 %r8 to i32
%r10 = call i32 @extractHigh32(i64 %r8)
%r11 = call i64 @mulPos32x32(i32* %r2, i32 %r3, i32 2)
%r12 = trunc i64 %r11 to i32
%r13 = call i32 @extractHigh32(i64 %r11)
%r14 = call i64 @mulPos32x32(i32* %r2, i32 %r3, i32 3)
%r15 = trunc i64 %r14 to i32
%r16 = call i32 @extractHigh32(i64 %r14)
%r17 = call i64 @mulPos32x32(i32* %r2, i32 %r3, i32 4)
%r18 = trunc i64 %r17 to i32
%r19 = call i32 @extractHigh32(i64 %r17)
%r20 = call i64 @mulPos32x32(i32* %r2, i32 %r3, i32 5)
%r21 = trunc i64 %r20 to i32
%r22 = call i32 @extractHigh32(i64 %r20)
%r23 = call i64 @mulPos32x32(i32* %r2, i32 %r3, i32 6)
%r24 = trunc i64 %r23 to i32
%r25 = call i32 @extractHigh32(i64 %r23)
%r26 = call i64 @mulPos32x32(i32* %r2, i32 %r3, i32 7)
%r27 = trunc i64 %r26 to i32
%r28 = call i32 @extractHigh32(i64 %r26)
%r29 = call i64 @mulPos32x32(i32* %r2, i32 %r3, i32 8)
%r30 = trunc i64 %r29 to i32
%r31 = call i32 @extractHigh32(i64 %r29)
%r32 = zext i32 %r6 to i64
%r33 = zext i32 %r9 to i64
%r34 = shl i64 %r33, 32
%r35 = or i64 %r32, %r34
%r36 = zext i64 %r35 to i96
%r37 = zext i32 %r12 to i96
%r38 = shl i96 %r37, 64
%r39 = or i96 %r36, %r38
%r40 = zext i96 %r39 to i128
%r41 = zext i32 %r15 to i128
%r42 = shl i128 %r41, 96
%r43 = or i128 %r40, %r42
%r44 = zext i128 %r43 to i160
%r45 = zext i32 %r18 to i160
%r46 = shl i160 %r45, 128
%r47 = or i160 %r44, %r46
%r48 = zext i160 %r47 to i192
%r49 = zext i32 %r21 to i192
%r50 = shl i192 %r49, 160
%r51 = or i192 %r48, %r50
%r52 = zext i192 %r51 to i224
%r53 = zext i32 %r24 to i224
%r54 = shl i224 %r53, 192
%r55 = or i224 %r52, %r54
%r56 = zext i224 %r55 to i256
%r57 = zext i32 %r27 to i256
%r58 = shl i256 %r57, 224
%r59 = or i256 %r56, %r58
%r60 = zext i256 %r59 to i288
%r61 = zext i32 %r30 to i288
%r62 = shl i288 %r61, 256
%r63 = or i288 %r60, %r62
%r64 = zext i32 %r7 to i64
%r65 = zext i32 %r10 to i64
%r66 = shl i64 %r65, 32
%r67 = or i64 %r64, %r66
%r68 = zext i64 %r67 to i96
%r69 = zext i32 %r13 to i96
%r70 = shl i96 %r69, 64
%r71 = or i96 %r68, %r70
%r72 = zext i96 %r71 to i128
%r73 = zext i32 %r16 to i128
%r74 = shl i128 %r73, 96
%r75 = or i128 %r72, %r74
%r76 = zext i128 %r75 to i160
%r77 = zext i32 %r19 to i160
%r78 = shl i160 %r77, 128
%r79 = or i160 %r76, %r78
%r80 = zext i160 %r79 to i192
%r81 = zext i32 %r22 to i192
%r82 = shl i192 %r81, 160
%r83 = or i192 %r80, %r82
%r84 = zext i192 %r83 to i224
%r85 = zext i32 %r25 to i224
%r86 = shl i224 %r85, 192
%r87 = or i224 %r84, %r86
%r88 = zext i224 %r87 to i256
%r89 = zext i32 %r28 to i256
%r90 = shl i256 %r89, 224
%r91 = or i256 %r88, %r90
%r92 = zext i256 %r91 to i288
%r93 = zext i32 %r31 to i288
%r94 = shl i288 %r93, 256
%r95 = or i288 %r92, %r94
%r96 = zext i288 %r63 to i320
%r97 = zext i288 %r95 to i320
%r98 = shl i320 %r97, 32
%r99 = add i320 %r96, %r98
%r100 = bitcast i32* %r1 to i288*
%r101 = load i288, i288* %r100
%r102 = zext i288 %r101 to i320
%r103 = add i320 %r99, %r102
%r104 = trunc i320 %r103 to i288
%r105 = bitcast i32* %r1 to i288*
store i288 %r104, i288* %r105
%r106 = lshr i320 %r103, 288
%r107 = trunc i320 %r106 to i32
ret i32 %r107
}
define void @mclb_mul9(i32* noalias %r1, i32* noalias %r2, i32* noalias %r3)
{
%r4 = load i32, i32* %r3
%r5 = call i320 @mulUnit_inner288(i32* %r2, i32 %r4)
%r6 = trunc i320 %r5 to i32
store i32 %r6, i32* %r1
%r7 = lshr i320 %r5, 32
%r8 = getelementptr i32, i32* %r3, i32 1
%r9 = load i32, i32* %r8
%r10 = call i320 @mulUnit_inner288(i32* %r2, i32 %r9)
%r11 = add i320 %r7, %r10
%r12 = trunc i320 %r11 to i32
%r13 = getelementptr i32, i32* %r1, i32 1
store i32 %r12, i32* %r13
%r14 = lshr i320 %r11, 32
%r15 = getelementptr i32, i32* %r3, i32 2
%r16 = load i32, i32* %r15
%r17 = call i320 @mulUnit_inner288(i32* %r2, i32 %r16)
%r18 = add i320 %r14, %r17
%r19 = trunc i320 %r18 to i32
%r20 = getelementptr i32, i32* %r1, i32 2
store i32 %r19, i32* %r20
%r21 = lshr i320 %r18, 32
%r22 = getelementptr i32, i32* %r3, i32 3
%r23 = load i32, i32* %r22
%r24 = call i320 @mulUnit_inner288(i32* %r2, i32 %r23)
%r25 = add i320 %r21, %r24
%r26 = trunc i320 %r25 to i32
%r27 = getelementptr i32, i32* %r1, i32 3
store i32 %r26, i32* %r27
%r28 = lshr i320 %r25, 32
%r29 = getelementptr i32, i32* %r3, i32 4
%r30 = load i32, i32* %r29
%r31 = call i320 @mulUnit_inner288(i32* %r2, i32 %r30)
%r32 = add i320 %r28, %r31
%r33 = trunc i320 %r32 to i32
%r34 = getelementptr i32, i32* %r1, i32 4
store i32 %r33, i32* %r34
%r35 = lshr i320 %r32, 32
%r36 = getelementptr i32, i32* %r3, i32 5
%r37 = load i32, i32* %r36
%r38 = call i320 @mulUnit_inner288(i32* %r2, i32 %r37)
%r39 = add i320 %r35, %r38
%r40 = trunc i320 %r39 to i32
%r41 = getelementptr i32, i32* %r1, i32 5
store i32 %r40, i32* %r41
%r42 = lshr i320 %r39, 32
%r43 = getelementptr i32, i32* %r3, i32 6
%r44 = load i32, i32* %r43
%r45 = call i320 @mulUnit_inner288(i32* %r2, i32 %r44)
%r46 = add i320 %r42, %r45
%r47 = trunc i320 %r46 to i32
%r48 = getelementptr i32, i32* %r1, i32 6
store i32 %r47, i32* %r48
%r49 = lshr i320 %r46, 32
%r50 = getelementptr i32, i32* %r3, i32 7
%r51 = load i32, i32* %r50
%r52 = call i320 @mulUnit_inner288(i32* %r2, i32 %r51)
%r53 = add i320 %r49, %r52
%r54 = trunc i320 %r53 to i32
%r55 = getelementptr i32, i32* %r1, i32 7
store i32 %r54, i32* %r55
%r56 = lshr i320 %r53, 32
%r57 = getelementptr i32, i32* %r3, i32 8
%r58 = load i32, i32* %r57
%r59 = call i320 @mulUnit_inner288(i32* %r2, i32 %r58)
%r60 = add i320 %r56, %r59
%r61 = getelementptr i32, i32* %r1, i32 8
%r62 = bitcast i32* %r61 to i320*
store i320 %r60, i320* %r62
ret void
}
define void @mclb_sqr9(i32* noalias %r1, i32* noalias %r2)
{
%r3 = load i32, i32* %r2
%r4 = call i64 @mul32x32L(i32 %r3, i32 %r3)
%r5 = trunc i64 %r4 to i32
store i32 %r5, i32* %r1
%r6 = lshr i64 %r4, 32
%r7 = getelementptr i32, i32* %r2, i32 8
%r8 = load i32, i32* %r7
%r9 = call i64 @mul32x32L(i32 %r3, i32 %r8)
%r10 = load i32, i32* %r2
%r11 = getelementptr i32, i32* %r2, i32 7
%r12 = load i32, i32* %r11
%r13 = call i64 @mul32x32L(i32 %r10, i32 %r12)
%r14 = getelementptr i32, i32* %r2, i32 1
%r15 = load i32, i32* %r14
%r16 = getelementptr i32, i32* %r2, i32 8
%r17 = load i32, i32* %r16
%r18 = call i64 @mul32x32L(i32 %r15, i32 %r17)
%r19 = zext i64 %r13 to i128
%r20 = zext i64 %r18 to i128
%r21 = shl i128 %r20, 64
%r22 = or i128 %r19, %r21
%r23 = zext i64 %r9 to i128
%r24 = shl i128 %r23, 32
%r25 = add i128 %r24, %r22
%r26 = load i32, i32* %r2
%r27 = getelementptr i32, i32* %r2, i32 6
%r28 = load i32, i32* %r27
%r29 = call i64 @mul32x32L(i32 %r26, i32 %r28)
%r30 = getelementptr i32, i32* %r2, i32 1
%r31 = load i32, i32* %r30
%r32 = getelementptr i32, i32* %r2, i32 7
%r33 = load i32, i32* %r32
%r34 = call i64 @mul32x32L(i32 %r31, i32 %r33)
%r35 = zext i64 %r29 to i128
%r36 = zext i64 %r34 to i128
%r37 = shl i128 %r36, 64
%r38 = or i128 %r35, %r37
%r39 = getelementptr i32, i32* %r2, i32 2
%r40 = load i32, i32* %r39
%r41 = getelementptr i32, i32* %r2, i32 8
%r42 = load i32, i32* %r41
%r43 = call i64 @mul32x32L(i32 %r40, i32 %r42)
%r44 = zext i128 %r38 to i192
%r45 = zext i64 %r43 to i192
%r46 = shl i192 %r45, 128
%r47 = or i192 %r44, %r46
%r48 = zext i128 %r25 to i192
%r49 = shl i192 %r48, 32
%r50 = add i192 %r49, %r47
%r51 = load i32, i32* %r2
%r52 = getelementptr i32, i32* %r2, i32 5
%r53 = load i32, i32* %r52
%r54 = call i64 @mul32x32L(i32 %r51, i32 %r53)
%r55 = getelementptr i32, i32* %r2, i32 1
%r56 = load i32, i32* %r55
%r57 = getelementptr i32, i32* %r2, i32 6
%r58 = load i32, i32* %r57
%r59 = call i64 @mul32x32L(i32 %r56, i32 %r58)
%r60 = zext i64 %r54 to i128
%r61 = zext i64 %r59 to i128
%r62 = shl i128 %r61, 64
%r63 = or i128 %r60, %r62
%r64 = getelementptr i32, i32* %r2, i32 2
%r65 = load i32, i32* %r64
%r66 = getelementptr i32, i32* %r2, i32 7
%r67 = load i32, i32* %r66
%r68 = call i64 @mul32x32L(i32 %r65, i32 %r67)
%r69 = zext i128 %r63 to i192
%r70 = zext i64 %r68 to i192
%r71 = shl i192 %r70, 128
%r72 = or i192 %r69, %r71
%r73 = getelementptr i32, i32* %r2, i32 3
%r74 = load i32, i32* %r73
%r75 = getelementptr i32, i32* %r2, i32 8
%r76 = load i32, i32* %r75
%r77 = call i64 @mul32x32L(i32 %r74, i32 %r76)
%r78 = zext i192 %r72 to i256
%r79 = zext i64 %r77 to i256
%r80 = shl i256 %r79, 192
%r81 = or i256 %r78, %r80
%r82 = zext i192 %r50 to i256
%r83 = shl i256 %r82, 32
%r84 = add i256 %r83, %r81
%r85 = load i32, i32* %r2
%r86 = getelementptr i32, i32* %r2, i32 4
%r87 = load i32, i32* %r86
%r88 = call i64 @mul32x32L(i32 %r85, i32 %r87)
%r89 = getelementptr i32, i32* %r2, i32 1
%r90 = load i32, i32* %r89
%r91 = getelementptr i32, i32* %r2, i32 5
%r92 = load i32, i32* %r91
%r93 = call i64 @mul32x32L(i32 %r90, i32 %r92)
%r94 = zext i64 %r88 to i128
%r95 = zext i64 %r93 to i128
%r96 = shl i128 %r95, 64
%r97 = or i128 %r94, %r96
%r98 = getelementptr i32, i32* %r2, i32 2
%r99 = load i32, i32* %r98
%r100 = getelementptr i32, i32* %r2, i32 6
%r101 = load i32, i32* %r100
%r102 = call i64 @mul32x32L(i32 %r99, i32 %r101)
%r103 = zext i128 %r97 to i192
%r104 = zext i64 %r102 to i192
%r105 = shl i192 %r104, 128
%r106 = or i192 %r103, %r105
%r107 = getelementptr i32, i32* %r2, i32 3
%r108 = load i32, i32* %r107
%r109 = getelementptr i32, i32* %r2, i32 7
%r110 = load i32, i32* %r109
%r111 = call i64 @mul32x32L(i32 %r108, i32 %r110)
%r112 = zext i192 %r106 to i256
%r113 = zext i64 %r111 to i256
%r114 = shl i256 %r113, 192
%r115 = or i256 %r112, %r114
%r116 = getelementptr i32, i32* %r2, i32 4
%r117 = load i32, i32* %r116
%r118 = getelementptr i32, i32* %r2, i32 8
%r119 = load i32, i32* %r118
%r120 = call i64 @mul32x32L(i32 %r117, i32 %r119)
%r121 = zext i256 %r115 to i320
%r122 = zext i64 %r120 to i320
%r123 = shl i320 %r122, 256
%r124 = or i320 %r121, %r123
%r125 = zext i256 %r84 to i320
%r126 = shl i320 %r125, 32
%r127 = add i320 %r126, %r124
%r128 = load i32, i32* %r2
%r129 = getelementptr i32, i32* %r2, i32 3
%r130 = load i32, i32* %r129
%r131 = call i64 @mul32x32L(i32 %r128, i32 %r130)
%r132 = getelementptr i32, i32* %r2, i32 1
%r133 = load i32, i32* %r132
%r134 = getelementptr i32, i32* %r2, i32 4
%r135 = load i32, i32* %r134
%r136 = call i64 @mul32x32L(i32 %r133, i32 %r135)
%r137 = zext i64 %r131 to i128
%r138 = zext i64 %r136 to i128
%r139 = shl i128 %r138, 64
%r140 = or i128 %r137, %r139
%r141 = getelementptr i32, i32* %r2, i32 2
%r142 = load i32, i32* %r141
%r143 = getelementptr i32, i32* %r2, i32 5
%r144 = load i32, i32* %r143
%r145 = call i64 @mul32x32L(i32 %r142, i32 %r144)
%r146 = zext i128 %r140 to i192
%r147 = zext i64 %r145 to i192
%r148 = shl i192 %r147, 128
%r149 = or i192 %r146, %r148
%r150 = getelementptr i32, i32* %r2, i32 3
%r151 = load i32, i32* %r150
%r152 = getelementptr i32, i32* %r2, i32 6
%r153 = load i32, i32* %r152
%r154 = call i64 @mul32x32L(i32 %r151, i32 %r153)
%r155 = zext i192 %r149 to i256
%r156 = zext i64 %r154 to i256
%r157 = shl i256 %r156, 192
%r158 = or i256 %r155, %r157
%r159 = getelementptr i32, i32* %r2, i32 4
%r160 = load i32, i32* %r159
%r161 = getelementptr i32, i32* %r2, i32 7
%r162 = load i32, i32* %r161
%r163 = call i64 @mul32x32L(i32 %r160, i32 %r162)
%r164 = zext i256 %r158 to i320
%r165 = zext i64 %r163 to i320
%r166 = shl i320 %r165, 256
%r167 = or i320 %r164, %r166
%r168 = getelementptr i32, i32* %r2, i32 5
%r169 = load i32, i32* %r168
%r170 = getelementptr i32, i32* %r2, i32 8
%r171 = load i32, i32* %r170
%r172 = call i64 @mul32x32L(i32 %r169, i32 %r171)
%r173 = zext i320 %r167 to i384
%r174 = zext i64 %r172 to i384
%r175 = shl i384 %r174, 320
%r176 = or i384 %r173, %r175
%r177 = zext i320 %r127 to i384
%r178 = shl i384 %r177, 32
%r179 = add i384 %r178, %r176
%r180 = load i32, i32* %r2
%r181 = getelementptr i32, i32* %r2, i32 2
%r182 = load i32, i32* %r181
%r183 = call i64 @mul32x32L(i32 %r180, i32 %r182)
%r184 = getelementptr i32, i32* %r2, i32 1
%r185 = load i32, i32* %r184
%r186 = getelementptr i32, i32* %r2, i32 3
%r187 = load i32, i32* %r186
%r188 = call i64 @mul32x32L(i32 %r185, i32 %r187)
%r189 = zext i64 %r183 to i128
%r190 = zext i64 %r188 to i128
%r191 = shl i128 %r190, 64
%r192 = or i128 %r189, %r191
%r193 = getelementptr i32, i32* %r2, i32 2
%r194 = load i32, i32* %r193
%r195 = getelementptr i32, i32* %r2, i32 4
%r196 = load i32, i32* %r195
%r197 = call i64 @mul32x32L(i32 %r194, i32 %r196)
%r198 = zext i128 %r192 to i192
%r199 = zext i64 %r197 to i192
%r200 = shl i192 %r199, 128
%r201 = or i192 %r198, %r200
%r202 = getelementptr i32, i32* %r2, i32 3
%r203 = load i32, i32* %r202
%r204 = getelementptr i32, i32* %r2, i32 5
%r205 = load i32, i32* %r204
%r206 = call i64 @mul32x32L(i32 %r203, i32 %r205)
%r207 = zext i192 %r201 to i256
%r208 = zext i64 %r206 to i256
%r209 = shl i256 %r208, 192
%r210 = or i256 %r207, %r209
%r211 = getelementptr i32, i32* %r2, i32 4
%r212 = load i32, i32* %r211
%r213 = getelementptr i32, i32* %r2, i32 6
%r214 = load i32, i32* %r213
%r215 = call i64 @mul32x32L(i32 %r212, i32 %r214)
%r216 = zext i256 %r210 to i320
%r217 = zext i64 %r215 to i320
%r218 = shl i320 %r217, 256
%r219 = or i320 %r216, %r218
%r220 = getelementptr i32, i32* %r2, i32 5
%r221 = load i32, i32* %r220
%r222 = getelementptr i32, i32* %r2, i32 7
%r223 = load i32, i32* %r222
%r224 = call i64 @mul32x32L(i32 %r221, i32 %r223)
%r225 = zext i320 %r219 to i384
%r226 = zext i64 %r224 to i384
%r227 = shl i384 %r226, 320
%r228 = or i384 %r225, %r227
%r229 = getelementptr i32, i32* %r2, i32 6
%r230 = load i32, i32* %r229
%r231 = getelementptr i32, i32* %r2, i32 8
%r232 = load i32, i32* %r231
%r233 = call i64 @mul32x32L(i32 %r230, i32 %r232)
%r234 = zext i384 %r228 to i448
%r235 = zext i64 %r233 to i448
%r236 = shl i448 %r235, 384
%r237 = or i448 %r234, %r236
%r238 = zext i384 %r179 to i448
%r239 = shl i448 %r238, 32
%r240 = add i448 %r239, %r237
%r241 = load i32, i32* %r2
%r242 = getelementptr i32, i32* %r2, i32 1
%r243 = load i32, i32* %r242
%r244 = call i64 @mul32x32L(i32 %r241, i32 %r243)
%r245 = getelementptr i32, i32* %r2, i32 1
%r246 = load i32, i32* %r245
%r247 = getelementptr i32, i32* %r2, i32 2
%r248 = load i32, i32* %r247
%r249 = call i64 @mul32x32L(i32 %r246, i32 %r248)
%r250 = zext i64 %r244 to i128
%r251 = zext i64 %r249 to i128
%r252 = shl i128 %r251, 64
%r253 = or i128 %r250, %r252
%r254 = getelementptr i32, i32* %r2, i32 2
%r255 = load i32, i32* %r254
%r256 = getelementptr i32, i32* %r2, i32 3
%r257 = load i32, i32* %r256
%r258 = call i64 @mul32x32L(i32 %r255, i32 %r257)
%r259 = zext i128 %r253 to i192
%r260 = zext i64 %r258 to i192
%r261 = shl i192 %r260, 128
%r262 = or i192 %r259, %r261
%r263 = getelementptr i32, i32* %r2, i32 3
%r264 = load i32, i32* %r263
%r265 = getelementptr i32, i32* %r2, i32 4
%r266 = load i32, i32* %r265
%r267 = call i64 @mul32x32L(i32 %r264, i32 %r266)
%r268 = zext i192 %r262 to i256
%r269 = zext i64 %r267 to i256
%r270 = shl i256 %r269, 192
%r271 = or i256 %r268, %r270
%r272 = getelementptr i32, i32* %r2, i32 4
%r273 = load i32, i32* %r272
%r274 = getelementptr i32, i32* %r2, i32 5
%r275 = load i32, i32* %r274
%r276 = call i64 @mul32x32L(i32 %r273, i32 %r275)
%r277 = zext i256 %r271 to i320
%r278 = zext i64 %r276 to i320
%r279 = shl i320 %r278, 256
%r280 = or i320 %r277, %r279
%r281 = getelementptr i32, i32* %r2, i32 5
%r282 = load i32, i32* %r281
%r283 = getelementptr i32, i32* %r2, i32 6
%r284 = load i32, i32* %r283
%r285 = call i64 @mul32x32L(i32 %r282, i32 %r284)
%r286 = zext i320 %r280 to i384
%r287 = zext i64 %r285 to i384
%r288 = shl i384 %r287, 320
%r289 = or i384 %r286, %r288
%r290 = getelementptr i32, i32* %r2, i32 6
%r291 = load i32, i32* %r290
%r292 = getelementptr i32, i32* %r2, i32 7
%r293 = load i32, i32* %r292
%r294 = call i64 @mul32x32L(i32 %r291, i32 %r293)
%r295 = zext i384 %r289 to i448
%r296 = zext i64 %r294 to i448
%r297 = shl i448 %r296, 384
%r298 = or i448 %r295, %r297
%r299 = getelementptr i32, i32* %r2, i32 7
%r300 = load i32, i32* %r299
%r301 = getelementptr i32, i32* %r2, i32 8
%r302 = load i32, i32* %r301
%r303 = call i64 @mul32x32L(i32 %r300, i32 %r302)
%r304 = zext i448 %r298 to i512
%r305 = zext i64 %r303 to i512
%r306 = shl i512 %r305, 448
%r307 = or i512 %r304, %r306
%r308 = zext i448 %r240 to i512
%r309 = shl i512 %r308, 32
%r310 = add i512 %r309, %r307
%r311 = zext i64 %r6 to i544
%r312 = getelementptr i32, i32* %r2, i32 1
%r313 = load i32, i32* %r312
%r314 = call i64 @mul32x32L(i32 %r313, i32 %r313)
%r315 = zext i64 %r314 to i544
%r316 = shl i544 %r315, 32
%r317 = or i544 %r311, %r316
%r318 = getelementptr i32, i32* %r2, i32 2
%r319 = load i32, i32* %r318
%r320 = call i64 @mul32x32L(i32 %r319, i32 %r319)
%r321 = zext i64 %r320 to i544
%r322 = shl i544 %r321, 96
%r323 = or i544 %r317, %r322
%r324 = getelementptr i32, i32* %r2, i32 3
%r325 = load i32, i32* %r324
%r326 = call i64 @mul32x32L(i32 %r325, i32 %r325)
%r327 = zext i64 %r326 to i544
%r328 = shl i544 %r327, 160
%r329 = or i544 %r323, %r328
%r330 = getelementptr i32, i32* %r2, i32 4
%r331 = load i32, i32* %r330
%r332 = call i64 @mul32x32L(i32 %r331, i32 %r331)
%r333 = zext i64 %r332 to i544
%r334 = shl i544 %r333, 224
%r335 = or i544 %r329, %r334
%r336 = getelementptr i32, i32* %r2, i32 5
%r337 = load i32, i32* %r336
%r338 = call i64 @mul32x32L(i32 %r337, i32 %r337)
%r339 = zext i64 %r338 to i544
%r340 = shl i544 %r339, 288
%r341 = or i544 %r335, %r340
%r342 = getelementptr i32, i32* %r2, i32 6
%r343 = load i32, i32* %r342
%r344 = call i64 @mul32x32L(i32 %r343, i32 %r343)
%r345 = zext i64 %r344 to i544
%r346 = shl i544 %r345, 352
%r347 = or i544 %r341, %r346
%r348 = getelementptr i32, i32* %r2, i32 7
%r349 = load i32, i32* %r348
%r350 = call i64 @mul32x32L(i32 %r349, i32 %r349)
%r351 = zext i64 %r350 to i544
%r352 = shl i544 %r351, 416
%r353 = or i544 %r347, %r352
%r354 = getelementptr i32, i32* %r2, i32 8
%r355 = load i32, i32* %r354
%r356 = call i64 @mul32x32L(i32 %r355, i32 %r355)
%r357 = zext i64 %r356 to i544
%r358 = shl i544 %r357, 480
%r359 = or i544 %r353, %r358
%r360 = zext i512 %r310 to i544
%r361 = add i544 %r360, %r360
%r362 = add i544 %r359, %r361
%r363 = getelementptr i32, i32* %r1, i32 1
%r364 = bitcast i32* %r363 to i544*
store i544 %r362, i544* %r364
ret void
}
define i352 @mulUnit_inner320(i32* noalias %r2, i32 %r3)
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
%r34 = zext i32 %r5 to i64
%r35 = zext i32 %r8 to i64
%r36 = shl i64 %r35, 32
%r37 = or i64 %r34, %r36
%r38 = zext i64 %r37 to i96
%r39 = zext i32 %r11 to i96
%r40 = shl i96 %r39, 64
%r41 = or i96 %r38, %r40
%r42 = zext i96 %r41 to i128
%r43 = zext i32 %r14 to i128
%r44 = shl i128 %r43, 96
%r45 = or i128 %r42, %r44
%r46 = zext i128 %r45 to i160
%r47 = zext i32 %r17 to i160
%r48 = shl i160 %r47, 128
%r49 = or i160 %r46, %r48
%r50 = zext i160 %r49 to i192
%r51 = zext i32 %r20 to i192
%r52 = shl i192 %r51, 160
%r53 = or i192 %r50, %r52
%r54 = zext i192 %r53 to i224
%r55 = zext i32 %r23 to i224
%r56 = shl i224 %r55, 192
%r57 = or i224 %r54, %r56
%r58 = zext i224 %r57 to i256
%r59 = zext i32 %r26 to i256
%r60 = shl i256 %r59, 224
%r61 = or i256 %r58, %r60
%r62 = zext i256 %r61 to i288
%r63 = zext i32 %r29 to i288
%r64 = shl i288 %r63, 256
%r65 = or i288 %r62, %r64
%r66 = zext i288 %r65 to i320
%r67 = zext i32 %r32 to i320
%r68 = shl i320 %r67, 288
%r69 = or i320 %r66, %r68
%r70 = zext i32 %r6 to i64
%r71 = zext i32 %r9 to i64
%r72 = shl i64 %r71, 32
%r73 = or i64 %r70, %r72
%r74 = zext i64 %r73 to i96
%r75 = zext i32 %r12 to i96
%r76 = shl i96 %r75, 64
%r77 = or i96 %r74, %r76
%r78 = zext i96 %r77 to i128
%r79 = zext i32 %r15 to i128
%r80 = shl i128 %r79, 96
%r81 = or i128 %r78, %r80
%r82 = zext i128 %r81 to i160
%r83 = zext i32 %r18 to i160
%r84 = shl i160 %r83, 128
%r85 = or i160 %r82, %r84
%r86 = zext i160 %r85 to i192
%r87 = zext i32 %r21 to i192
%r88 = shl i192 %r87, 160
%r89 = or i192 %r86, %r88
%r90 = zext i192 %r89 to i224
%r91 = zext i32 %r24 to i224
%r92 = shl i224 %r91, 192
%r93 = or i224 %r90, %r92
%r94 = zext i224 %r93 to i256
%r95 = zext i32 %r27 to i256
%r96 = shl i256 %r95, 224
%r97 = or i256 %r94, %r96
%r98 = zext i256 %r97 to i288
%r99 = zext i32 %r30 to i288
%r100 = shl i288 %r99, 256
%r101 = or i288 %r98, %r100
%r102 = zext i288 %r101 to i320
%r103 = zext i32 %r33 to i320
%r104 = shl i320 %r103, 288
%r105 = or i320 %r102, %r104
%r106 = zext i320 %r69 to i352
%r107 = zext i320 %r105 to i352
%r108 = shl i352 %r107, 32
%r109 = add i352 %r106, %r108
ret i352 %r109
}
define i32 @mclb_mulUnit10(i32* noalias %r1, i32* noalias %r2, i32 %r3)
{
%r5 = call i352 @mulUnit_inner320(i32* %r2, i32 %r3)
%r6 = trunc i352 %r5 to i320
%r7 = bitcast i32* %r1 to i320*
store i320 %r6, i320* %r7
%r8 = lshr i352 %r5, 320
%r9 = trunc i352 %r8 to i32
ret i32 %r9
}
define i32 @mclb_mulUnitAdd10(i32* noalias %r1, i32* noalias %r2, i32 %r3)
{
%r5 = call i64 @mulPos32x32(i32* %r2, i32 %r3, i32 0)
%r6 = trunc i64 %r5 to i32
%r7 = call i32 @extractHigh32(i64 %r5)
%r8 = call i64 @mulPos32x32(i32* %r2, i32 %r3, i32 1)
%r9 = trunc i64 %r8 to i32
%r10 = call i32 @extractHigh32(i64 %r8)
%r11 = call i64 @mulPos32x32(i32* %r2, i32 %r3, i32 2)
%r12 = trunc i64 %r11 to i32
%r13 = call i32 @extractHigh32(i64 %r11)
%r14 = call i64 @mulPos32x32(i32* %r2, i32 %r3, i32 3)
%r15 = trunc i64 %r14 to i32
%r16 = call i32 @extractHigh32(i64 %r14)
%r17 = call i64 @mulPos32x32(i32* %r2, i32 %r3, i32 4)
%r18 = trunc i64 %r17 to i32
%r19 = call i32 @extractHigh32(i64 %r17)
%r20 = call i64 @mulPos32x32(i32* %r2, i32 %r3, i32 5)
%r21 = trunc i64 %r20 to i32
%r22 = call i32 @extractHigh32(i64 %r20)
%r23 = call i64 @mulPos32x32(i32* %r2, i32 %r3, i32 6)
%r24 = trunc i64 %r23 to i32
%r25 = call i32 @extractHigh32(i64 %r23)
%r26 = call i64 @mulPos32x32(i32* %r2, i32 %r3, i32 7)
%r27 = trunc i64 %r26 to i32
%r28 = call i32 @extractHigh32(i64 %r26)
%r29 = call i64 @mulPos32x32(i32* %r2, i32 %r3, i32 8)
%r30 = trunc i64 %r29 to i32
%r31 = call i32 @extractHigh32(i64 %r29)
%r32 = call i64 @mulPos32x32(i32* %r2, i32 %r3, i32 9)
%r33 = trunc i64 %r32 to i32
%r34 = call i32 @extractHigh32(i64 %r32)
%r35 = zext i32 %r6 to i64
%r36 = zext i32 %r9 to i64
%r37 = shl i64 %r36, 32
%r38 = or i64 %r35, %r37
%r39 = zext i64 %r38 to i96
%r40 = zext i32 %r12 to i96
%r41 = shl i96 %r40, 64
%r42 = or i96 %r39, %r41
%r43 = zext i96 %r42 to i128
%r44 = zext i32 %r15 to i128
%r45 = shl i128 %r44, 96
%r46 = or i128 %r43, %r45
%r47 = zext i128 %r46 to i160
%r48 = zext i32 %r18 to i160
%r49 = shl i160 %r48, 128
%r50 = or i160 %r47, %r49
%r51 = zext i160 %r50 to i192
%r52 = zext i32 %r21 to i192
%r53 = shl i192 %r52, 160
%r54 = or i192 %r51, %r53
%r55 = zext i192 %r54 to i224
%r56 = zext i32 %r24 to i224
%r57 = shl i224 %r56, 192
%r58 = or i224 %r55, %r57
%r59 = zext i224 %r58 to i256
%r60 = zext i32 %r27 to i256
%r61 = shl i256 %r60, 224
%r62 = or i256 %r59, %r61
%r63 = zext i256 %r62 to i288
%r64 = zext i32 %r30 to i288
%r65 = shl i288 %r64, 256
%r66 = or i288 %r63, %r65
%r67 = zext i288 %r66 to i320
%r68 = zext i32 %r33 to i320
%r69 = shl i320 %r68, 288
%r70 = or i320 %r67, %r69
%r71 = zext i32 %r7 to i64
%r72 = zext i32 %r10 to i64
%r73 = shl i64 %r72, 32
%r74 = or i64 %r71, %r73
%r75 = zext i64 %r74 to i96
%r76 = zext i32 %r13 to i96
%r77 = shl i96 %r76, 64
%r78 = or i96 %r75, %r77
%r79 = zext i96 %r78 to i128
%r80 = zext i32 %r16 to i128
%r81 = shl i128 %r80, 96
%r82 = or i128 %r79, %r81
%r83 = zext i128 %r82 to i160
%r84 = zext i32 %r19 to i160
%r85 = shl i160 %r84, 128
%r86 = or i160 %r83, %r85
%r87 = zext i160 %r86 to i192
%r88 = zext i32 %r22 to i192
%r89 = shl i192 %r88, 160
%r90 = or i192 %r87, %r89
%r91 = zext i192 %r90 to i224
%r92 = zext i32 %r25 to i224
%r93 = shl i224 %r92, 192
%r94 = or i224 %r91, %r93
%r95 = zext i224 %r94 to i256
%r96 = zext i32 %r28 to i256
%r97 = shl i256 %r96, 224
%r98 = or i256 %r95, %r97
%r99 = zext i256 %r98 to i288
%r100 = zext i32 %r31 to i288
%r101 = shl i288 %r100, 256
%r102 = or i288 %r99, %r101
%r103 = zext i288 %r102 to i320
%r104 = zext i32 %r34 to i320
%r105 = shl i320 %r104, 288
%r106 = or i320 %r103, %r105
%r107 = zext i320 %r70 to i352
%r108 = zext i320 %r106 to i352
%r109 = shl i352 %r108, 32
%r110 = add i352 %r107, %r109
%r111 = bitcast i32* %r1 to i320*
%r112 = load i320, i320* %r111
%r113 = zext i320 %r112 to i352
%r114 = add i352 %r110, %r113
%r115 = trunc i352 %r114 to i320
%r116 = bitcast i32* %r1 to i320*
store i320 %r115, i320* %r116
%r117 = lshr i352 %r114, 320
%r118 = trunc i352 %r117 to i32
ret i32 %r118
}
define void @mclb_mul10(i32* noalias %r1, i32* noalias %r2, i32* noalias %r3)
{
%r4 = getelementptr i32, i32* %r2, i32 5
%r5 = getelementptr i32, i32* %r3, i32 5
%r6 = getelementptr i32, i32* %r1, i32 10
call void @mclb_mul5(i32* %r1, i32* %r2, i32* %r3)
call void @mclb_mul5(i32* %r6, i32* %r4, i32* %r5)
%r7 = bitcast i32* %r4 to i160*
%r8 = load i160, i160* %r7
%r9 = zext i160 %r8 to i192
%r10 = bitcast i32* %r2 to i160*
%r11 = load i160, i160* %r10
%r12 = zext i160 %r11 to i192
%r13 = bitcast i32* %r5 to i160*
%r14 = load i160, i160* %r13
%r15 = zext i160 %r14 to i192
%r16 = bitcast i32* %r3 to i160*
%r17 = load i160, i160* %r16
%r18 = zext i160 %r17 to i192
%r19 = add i192 %r9, %r12
%r20 = add i192 %r15, %r18
%r21 = alloca i32, i32 10
%r22 = trunc i192 %r19 to i160
%r23 = trunc i192 %r20 to i160
%r24 = lshr i192 %r19, 160
%r25 = trunc i192 %r24 to i1
%r26 = lshr i192 %r20, 160
%r27 = trunc i192 %r26 to i1
%r28 = and i1 %r25, %r27
%r29 = select i1 %r25, i160 %r23, i160 0
%r30 = select i1 %r27, i160 %r22, i160 0
%r31 = alloca i32, i32 5
%r32 = alloca i32, i32 5
%r33 = bitcast i32* %r31 to i160*
store i160 %r22, i160* %r33
%r34 = bitcast i32* %r32 to i160*
store i160 %r23, i160* %r34
call void @mclb_mul5(i32* %r21, i32* %r31, i32* %r32)
%r35 = bitcast i32* %r21 to i320*
%r36 = load i320, i320* %r35
%r37 = zext i320 %r36 to i352
%r38 = zext i1 %r28 to i352
%r39 = shl i352 %r38, 320
%r40 = or i352 %r37, %r39
%r41 = zext i160 %r29 to i352
%r42 = zext i160 %r30 to i352
%r43 = shl i352 %r41, 160
%r44 = shl i352 %r42, 160
%r45 = add i352 %r40, %r43
%r46 = add i352 %r45, %r44
%r47 = bitcast i32* %r1 to i320*
%r48 = load i320, i320* %r47
%r49 = zext i320 %r48 to i352
%r50 = sub i352 %r46, %r49
%r51 = getelementptr i32, i32* %r1, i32 10
%r52 = bitcast i32* %r51 to i320*
%r53 = load i320, i320* %r52
%r54 = zext i320 %r53 to i352
%r55 = sub i352 %r50, %r54
%r56 = zext i352 %r55 to i480
%r57 = getelementptr i32, i32* %r1, i32 5
%r58 = bitcast i32* %r57 to i480*
%r59 = load i480, i480* %r58
%r60 = add i480 %r56, %r59
%r61 = getelementptr i32, i32* %r1, i32 5
%r62 = bitcast i32* %r61 to i480*
store i480 %r60, i480* %r62
ret void
}
define void @mclb_sqr10(i32* noalias %r1, i32* noalias %r2)
{
%r3 = getelementptr i32, i32* %r2, i32 5
%r4 = getelementptr i32, i32* %r1, i32 10
%r5 = alloca i32, i32 10
call void @mclb_mul5(i32* %r5, i32* %r2, i32* %r3)
call void @mclb_sqr5(i32* %r1, i32* %r2)
call void @mclb_sqr5(i32* %r4, i32* %r3)
%r6 = bitcast i32* %r5 to i320*
%r7 = load i320, i320* %r6
%r8 = zext i320 %r7 to i352
%r9 = add i352 %r8, %r8
%r10 = zext i352 %r9 to i480
%r11 = getelementptr i32, i32* %r1, i32 5
%r12 = bitcast i32* %r11 to i480*
%r13 = load i480, i480* %r12
%r14 = add i480 %r13, %r10
%r15 = bitcast i32* %r11 to i480*
store i480 %r14, i480* %r15
ret void
}
define i384 @mulUnit_inner352(i32* noalias %r2, i32 %r3)
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
%r37 = zext i32 %r5 to i64
%r38 = zext i32 %r8 to i64
%r39 = shl i64 %r38, 32
%r40 = or i64 %r37, %r39
%r41 = zext i64 %r40 to i96
%r42 = zext i32 %r11 to i96
%r43 = shl i96 %r42, 64
%r44 = or i96 %r41, %r43
%r45 = zext i96 %r44 to i128
%r46 = zext i32 %r14 to i128
%r47 = shl i128 %r46, 96
%r48 = or i128 %r45, %r47
%r49 = zext i128 %r48 to i160
%r50 = zext i32 %r17 to i160
%r51 = shl i160 %r50, 128
%r52 = or i160 %r49, %r51
%r53 = zext i160 %r52 to i192
%r54 = zext i32 %r20 to i192
%r55 = shl i192 %r54, 160
%r56 = or i192 %r53, %r55
%r57 = zext i192 %r56 to i224
%r58 = zext i32 %r23 to i224
%r59 = shl i224 %r58, 192
%r60 = or i224 %r57, %r59
%r61 = zext i224 %r60 to i256
%r62 = zext i32 %r26 to i256
%r63 = shl i256 %r62, 224
%r64 = or i256 %r61, %r63
%r65 = zext i256 %r64 to i288
%r66 = zext i32 %r29 to i288
%r67 = shl i288 %r66, 256
%r68 = or i288 %r65, %r67
%r69 = zext i288 %r68 to i320
%r70 = zext i32 %r32 to i320
%r71 = shl i320 %r70, 288
%r72 = or i320 %r69, %r71
%r73 = zext i320 %r72 to i352
%r74 = zext i32 %r35 to i352
%r75 = shl i352 %r74, 320
%r76 = or i352 %r73, %r75
%r77 = zext i32 %r6 to i64
%r78 = zext i32 %r9 to i64
%r79 = shl i64 %r78, 32
%r80 = or i64 %r77, %r79
%r81 = zext i64 %r80 to i96
%r82 = zext i32 %r12 to i96
%r83 = shl i96 %r82, 64
%r84 = or i96 %r81, %r83
%r85 = zext i96 %r84 to i128
%r86 = zext i32 %r15 to i128
%r87 = shl i128 %r86, 96
%r88 = or i128 %r85, %r87
%r89 = zext i128 %r88 to i160
%r90 = zext i32 %r18 to i160
%r91 = shl i160 %r90, 128
%r92 = or i160 %r89, %r91
%r93 = zext i160 %r92 to i192
%r94 = zext i32 %r21 to i192
%r95 = shl i192 %r94, 160
%r96 = or i192 %r93, %r95
%r97 = zext i192 %r96 to i224
%r98 = zext i32 %r24 to i224
%r99 = shl i224 %r98, 192
%r100 = or i224 %r97, %r99
%r101 = zext i224 %r100 to i256
%r102 = zext i32 %r27 to i256
%r103 = shl i256 %r102, 224
%r104 = or i256 %r101, %r103
%r105 = zext i256 %r104 to i288
%r106 = zext i32 %r30 to i288
%r107 = shl i288 %r106, 256
%r108 = or i288 %r105, %r107
%r109 = zext i288 %r108 to i320
%r110 = zext i32 %r33 to i320
%r111 = shl i320 %r110, 288
%r112 = or i320 %r109, %r111
%r113 = zext i320 %r112 to i352
%r114 = zext i32 %r36 to i352
%r115 = shl i352 %r114, 320
%r116 = or i352 %r113, %r115
%r117 = zext i352 %r76 to i384
%r118 = zext i352 %r116 to i384
%r119 = shl i384 %r118, 32
%r120 = add i384 %r117, %r119
ret i384 %r120
}
define i32 @mclb_mulUnit11(i32* noalias %r1, i32* noalias %r2, i32 %r3)
{
%r5 = call i384 @mulUnit_inner352(i32* %r2, i32 %r3)
%r6 = trunc i384 %r5 to i352
%r7 = bitcast i32* %r1 to i352*
store i352 %r6, i352* %r7
%r8 = lshr i384 %r5, 352
%r9 = trunc i384 %r8 to i32
ret i32 %r9
}
define i32 @mclb_mulUnitAdd11(i32* noalias %r1, i32* noalias %r2, i32 %r3)
{
%r5 = call i64 @mulPos32x32(i32* %r2, i32 %r3, i32 0)
%r6 = trunc i64 %r5 to i32
%r7 = call i32 @extractHigh32(i64 %r5)
%r8 = call i64 @mulPos32x32(i32* %r2, i32 %r3, i32 1)
%r9 = trunc i64 %r8 to i32
%r10 = call i32 @extractHigh32(i64 %r8)
%r11 = call i64 @mulPos32x32(i32* %r2, i32 %r3, i32 2)
%r12 = trunc i64 %r11 to i32
%r13 = call i32 @extractHigh32(i64 %r11)
%r14 = call i64 @mulPos32x32(i32* %r2, i32 %r3, i32 3)
%r15 = trunc i64 %r14 to i32
%r16 = call i32 @extractHigh32(i64 %r14)
%r17 = call i64 @mulPos32x32(i32* %r2, i32 %r3, i32 4)
%r18 = trunc i64 %r17 to i32
%r19 = call i32 @extractHigh32(i64 %r17)
%r20 = call i64 @mulPos32x32(i32* %r2, i32 %r3, i32 5)
%r21 = trunc i64 %r20 to i32
%r22 = call i32 @extractHigh32(i64 %r20)
%r23 = call i64 @mulPos32x32(i32* %r2, i32 %r3, i32 6)
%r24 = trunc i64 %r23 to i32
%r25 = call i32 @extractHigh32(i64 %r23)
%r26 = call i64 @mulPos32x32(i32* %r2, i32 %r3, i32 7)
%r27 = trunc i64 %r26 to i32
%r28 = call i32 @extractHigh32(i64 %r26)
%r29 = call i64 @mulPos32x32(i32* %r2, i32 %r3, i32 8)
%r30 = trunc i64 %r29 to i32
%r31 = call i32 @extractHigh32(i64 %r29)
%r32 = call i64 @mulPos32x32(i32* %r2, i32 %r3, i32 9)
%r33 = trunc i64 %r32 to i32
%r34 = call i32 @extractHigh32(i64 %r32)
%r35 = call i64 @mulPos32x32(i32* %r2, i32 %r3, i32 10)
%r36 = trunc i64 %r35 to i32
%r37 = call i32 @extractHigh32(i64 %r35)
%r38 = zext i32 %r6 to i64
%r39 = zext i32 %r9 to i64
%r40 = shl i64 %r39, 32
%r41 = or i64 %r38, %r40
%r42 = zext i64 %r41 to i96
%r43 = zext i32 %r12 to i96
%r44 = shl i96 %r43, 64
%r45 = or i96 %r42, %r44
%r46 = zext i96 %r45 to i128
%r47 = zext i32 %r15 to i128
%r48 = shl i128 %r47, 96
%r49 = or i128 %r46, %r48
%r50 = zext i128 %r49 to i160
%r51 = zext i32 %r18 to i160
%r52 = shl i160 %r51, 128
%r53 = or i160 %r50, %r52
%r54 = zext i160 %r53 to i192
%r55 = zext i32 %r21 to i192
%r56 = shl i192 %r55, 160
%r57 = or i192 %r54, %r56
%r58 = zext i192 %r57 to i224
%r59 = zext i32 %r24 to i224
%r60 = shl i224 %r59, 192
%r61 = or i224 %r58, %r60
%r62 = zext i224 %r61 to i256
%r63 = zext i32 %r27 to i256
%r64 = shl i256 %r63, 224
%r65 = or i256 %r62, %r64
%r66 = zext i256 %r65 to i288
%r67 = zext i32 %r30 to i288
%r68 = shl i288 %r67, 256
%r69 = or i288 %r66, %r68
%r70 = zext i288 %r69 to i320
%r71 = zext i32 %r33 to i320
%r72 = shl i320 %r71, 288
%r73 = or i320 %r70, %r72
%r74 = zext i320 %r73 to i352
%r75 = zext i32 %r36 to i352
%r76 = shl i352 %r75, 320
%r77 = or i352 %r74, %r76
%r78 = zext i32 %r7 to i64
%r79 = zext i32 %r10 to i64
%r80 = shl i64 %r79, 32
%r81 = or i64 %r78, %r80
%r82 = zext i64 %r81 to i96
%r83 = zext i32 %r13 to i96
%r84 = shl i96 %r83, 64
%r85 = or i96 %r82, %r84
%r86 = zext i96 %r85 to i128
%r87 = zext i32 %r16 to i128
%r88 = shl i128 %r87, 96
%r89 = or i128 %r86, %r88
%r90 = zext i128 %r89 to i160
%r91 = zext i32 %r19 to i160
%r92 = shl i160 %r91, 128
%r93 = or i160 %r90, %r92
%r94 = zext i160 %r93 to i192
%r95 = zext i32 %r22 to i192
%r96 = shl i192 %r95, 160
%r97 = or i192 %r94, %r96
%r98 = zext i192 %r97 to i224
%r99 = zext i32 %r25 to i224
%r100 = shl i224 %r99, 192
%r101 = or i224 %r98, %r100
%r102 = zext i224 %r101 to i256
%r103 = zext i32 %r28 to i256
%r104 = shl i256 %r103, 224
%r105 = or i256 %r102, %r104
%r106 = zext i256 %r105 to i288
%r107 = zext i32 %r31 to i288
%r108 = shl i288 %r107, 256
%r109 = or i288 %r106, %r108
%r110 = zext i288 %r109 to i320
%r111 = zext i32 %r34 to i320
%r112 = shl i320 %r111, 288
%r113 = or i320 %r110, %r112
%r114 = zext i320 %r113 to i352
%r115 = zext i32 %r37 to i352
%r116 = shl i352 %r115, 320
%r117 = or i352 %r114, %r116
%r118 = zext i352 %r77 to i384
%r119 = zext i352 %r117 to i384
%r120 = shl i384 %r119, 32
%r121 = add i384 %r118, %r120
%r122 = bitcast i32* %r1 to i352*
%r123 = load i352, i352* %r122
%r124 = zext i352 %r123 to i384
%r125 = add i384 %r121, %r124
%r126 = trunc i384 %r125 to i352
%r127 = bitcast i32* %r1 to i352*
store i352 %r126, i352* %r127
%r128 = lshr i384 %r125, 352
%r129 = trunc i384 %r128 to i32
ret i32 %r129
}
define void @mclb_mul11(i32* noalias %r1, i32* noalias %r2, i32* noalias %r3)
{
%r4 = load i32, i32* %r3
%r5 = call i384 @mulUnit_inner352(i32* %r2, i32 %r4)
%r6 = trunc i384 %r5 to i32
store i32 %r6, i32* %r1
%r7 = lshr i384 %r5, 32
%r8 = getelementptr i32, i32* %r3, i32 1
%r9 = load i32, i32* %r8
%r10 = call i384 @mulUnit_inner352(i32* %r2, i32 %r9)
%r11 = add i384 %r7, %r10
%r12 = trunc i384 %r11 to i32
%r13 = getelementptr i32, i32* %r1, i32 1
store i32 %r12, i32* %r13
%r14 = lshr i384 %r11, 32
%r15 = getelementptr i32, i32* %r3, i32 2
%r16 = load i32, i32* %r15
%r17 = call i384 @mulUnit_inner352(i32* %r2, i32 %r16)
%r18 = add i384 %r14, %r17
%r19 = trunc i384 %r18 to i32
%r20 = getelementptr i32, i32* %r1, i32 2
store i32 %r19, i32* %r20
%r21 = lshr i384 %r18, 32
%r22 = getelementptr i32, i32* %r3, i32 3
%r23 = load i32, i32* %r22
%r24 = call i384 @mulUnit_inner352(i32* %r2, i32 %r23)
%r25 = add i384 %r21, %r24
%r26 = trunc i384 %r25 to i32
%r27 = getelementptr i32, i32* %r1, i32 3
store i32 %r26, i32* %r27
%r28 = lshr i384 %r25, 32
%r29 = getelementptr i32, i32* %r3, i32 4
%r30 = load i32, i32* %r29
%r31 = call i384 @mulUnit_inner352(i32* %r2, i32 %r30)
%r32 = add i384 %r28, %r31
%r33 = trunc i384 %r32 to i32
%r34 = getelementptr i32, i32* %r1, i32 4
store i32 %r33, i32* %r34
%r35 = lshr i384 %r32, 32
%r36 = getelementptr i32, i32* %r3, i32 5
%r37 = load i32, i32* %r36
%r38 = call i384 @mulUnit_inner352(i32* %r2, i32 %r37)
%r39 = add i384 %r35, %r38
%r40 = trunc i384 %r39 to i32
%r41 = getelementptr i32, i32* %r1, i32 5
store i32 %r40, i32* %r41
%r42 = lshr i384 %r39, 32
%r43 = getelementptr i32, i32* %r3, i32 6
%r44 = load i32, i32* %r43
%r45 = call i384 @mulUnit_inner352(i32* %r2, i32 %r44)
%r46 = add i384 %r42, %r45
%r47 = trunc i384 %r46 to i32
%r48 = getelementptr i32, i32* %r1, i32 6
store i32 %r47, i32* %r48
%r49 = lshr i384 %r46, 32
%r50 = getelementptr i32, i32* %r3, i32 7
%r51 = load i32, i32* %r50
%r52 = call i384 @mulUnit_inner352(i32* %r2, i32 %r51)
%r53 = add i384 %r49, %r52
%r54 = trunc i384 %r53 to i32
%r55 = getelementptr i32, i32* %r1, i32 7
store i32 %r54, i32* %r55
%r56 = lshr i384 %r53, 32
%r57 = getelementptr i32, i32* %r3, i32 8
%r58 = load i32, i32* %r57
%r59 = call i384 @mulUnit_inner352(i32* %r2, i32 %r58)
%r60 = add i384 %r56, %r59
%r61 = trunc i384 %r60 to i32
%r62 = getelementptr i32, i32* %r1, i32 8
store i32 %r61, i32* %r62
%r63 = lshr i384 %r60, 32
%r64 = getelementptr i32, i32* %r3, i32 9
%r65 = load i32, i32* %r64
%r66 = call i384 @mulUnit_inner352(i32* %r2, i32 %r65)
%r67 = add i384 %r63, %r66
%r68 = trunc i384 %r67 to i32
%r69 = getelementptr i32, i32* %r1, i32 9
store i32 %r68, i32* %r69
%r70 = lshr i384 %r67, 32
%r71 = getelementptr i32, i32* %r3, i32 10
%r72 = load i32, i32* %r71
%r73 = call i384 @mulUnit_inner352(i32* %r2, i32 %r72)
%r74 = add i384 %r70, %r73
%r75 = getelementptr i32, i32* %r1, i32 10
%r76 = bitcast i32* %r75 to i384*
store i384 %r74, i384* %r76
ret void
}
define void @mclb_sqr11(i32* noalias %r1, i32* noalias %r2)
{
%r3 = load i32, i32* %r2
%r4 = call i64 @mul32x32L(i32 %r3, i32 %r3)
%r5 = trunc i64 %r4 to i32
store i32 %r5, i32* %r1
%r6 = lshr i64 %r4, 32
%r7 = getelementptr i32, i32* %r2, i32 10
%r8 = load i32, i32* %r7
%r9 = call i64 @mul32x32L(i32 %r3, i32 %r8)
%r10 = load i32, i32* %r2
%r11 = getelementptr i32, i32* %r2, i32 9
%r12 = load i32, i32* %r11
%r13 = call i64 @mul32x32L(i32 %r10, i32 %r12)
%r14 = getelementptr i32, i32* %r2, i32 1
%r15 = load i32, i32* %r14
%r16 = getelementptr i32, i32* %r2, i32 10
%r17 = load i32, i32* %r16
%r18 = call i64 @mul32x32L(i32 %r15, i32 %r17)
%r19 = zext i64 %r13 to i128
%r20 = zext i64 %r18 to i128
%r21 = shl i128 %r20, 64
%r22 = or i128 %r19, %r21
%r23 = zext i64 %r9 to i128
%r24 = shl i128 %r23, 32
%r25 = add i128 %r24, %r22
%r26 = load i32, i32* %r2
%r27 = getelementptr i32, i32* %r2, i32 8
%r28 = load i32, i32* %r27
%r29 = call i64 @mul32x32L(i32 %r26, i32 %r28)
%r30 = getelementptr i32, i32* %r2, i32 1
%r31 = load i32, i32* %r30
%r32 = getelementptr i32, i32* %r2, i32 9
%r33 = load i32, i32* %r32
%r34 = call i64 @mul32x32L(i32 %r31, i32 %r33)
%r35 = zext i64 %r29 to i128
%r36 = zext i64 %r34 to i128
%r37 = shl i128 %r36, 64
%r38 = or i128 %r35, %r37
%r39 = getelementptr i32, i32* %r2, i32 2
%r40 = load i32, i32* %r39
%r41 = getelementptr i32, i32* %r2, i32 10
%r42 = load i32, i32* %r41
%r43 = call i64 @mul32x32L(i32 %r40, i32 %r42)
%r44 = zext i128 %r38 to i192
%r45 = zext i64 %r43 to i192
%r46 = shl i192 %r45, 128
%r47 = or i192 %r44, %r46
%r48 = zext i128 %r25 to i192
%r49 = shl i192 %r48, 32
%r50 = add i192 %r49, %r47
%r51 = load i32, i32* %r2
%r52 = getelementptr i32, i32* %r2, i32 7
%r53 = load i32, i32* %r52
%r54 = call i64 @mul32x32L(i32 %r51, i32 %r53)
%r55 = getelementptr i32, i32* %r2, i32 1
%r56 = load i32, i32* %r55
%r57 = getelementptr i32, i32* %r2, i32 8
%r58 = load i32, i32* %r57
%r59 = call i64 @mul32x32L(i32 %r56, i32 %r58)
%r60 = zext i64 %r54 to i128
%r61 = zext i64 %r59 to i128
%r62 = shl i128 %r61, 64
%r63 = or i128 %r60, %r62
%r64 = getelementptr i32, i32* %r2, i32 2
%r65 = load i32, i32* %r64
%r66 = getelementptr i32, i32* %r2, i32 9
%r67 = load i32, i32* %r66
%r68 = call i64 @mul32x32L(i32 %r65, i32 %r67)
%r69 = zext i128 %r63 to i192
%r70 = zext i64 %r68 to i192
%r71 = shl i192 %r70, 128
%r72 = or i192 %r69, %r71
%r73 = getelementptr i32, i32* %r2, i32 3
%r74 = load i32, i32* %r73
%r75 = getelementptr i32, i32* %r2, i32 10
%r76 = load i32, i32* %r75
%r77 = call i64 @mul32x32L(i32 %r74, i32 %r76)
%r78 = zext i192 %r72 to i256
%r79 = zext i64 %r77 to i256
%r80 = shl i256 %r79, 192
%r81 = or i256 %r78, %r80
%r82 = zext i192 %r50 to i256
%r83 = shl i256 %r82, 32
%r84 = add i256 %r83, %r81
%r85 = load i32, i32* %r2
%r86 = getelementptr i32, i32* %r2, i32 6
%r87 = load i32, i32* %r86
%r88 = call i64 @mul32x32L(i32 %r85, i32 %r87)
%r89 = getelementptr i32, i32* %r2, i32 1
%r90 = load i32, i32* %r89
%r91 = getelementptr i32, i32* %r2, i32 7
%r92 = load i32, i32* %r91
%r93 = call i64 @mul32x32L(i32 %r90, i32 %r92)
%r94 = zext i64 %r88 to i128
%r95 = zext i64 %r93 to i128
%r96 = shl i128 %r95, 64
%r97 = or i128 %r94, %r96
%r98 = getelementptr i32, i32* %r2, i32 2
%r99 = load i32, i32* %r98
%r100 = getelementptr i32, i32* %r2, i32 8
%r101 = load i32, i32* %r100
%r102 = call i64 @mul32x32L(i32 %r99, i32 %r101)
%r103 = zext i128 %r97 to i192
%r104 = zext i64 %r102 to i192
%r105 = shl i192 %r104, 128
%r106 = or i192 %r103, %r105
%r107 = getelementptr i32, i32* %r2, i32 3
%r108 = load i32, i32* %r107
%r109 = getelementptr i32, i32* %r2, i32 9
%r110 = load i32, i32* %r109
%r111 = call i64 @mul32x32L(i32 %r108, i32 %r110)
%r112 = zext i192 %r106 to i256
%r113 = zext i64 %r111 to i256
%r114 = shl i256 %r113, 192
%r115 = or i256 %r112, %r114
%r116 = getelementptr i32, i32* %r2, i32 4
%r117 = load i32, i32* %r116
%r118 = getelementptr i32, i32* %r2, i32 10
%r119 = load i32, i32* %r118
%r120 = call i64 @mul32x32L(i32 %r117, i32 %r119)
%r121 = zext i256 %r115 to i320
%r122 = zext i64 %r120 to i320
%r123 = shl i320 %r122, 256
%r124 = or i320 %r121, %r123
%r125 = zext i256 %r84 to i320
%r126 = shl i320 %r125, 32
%r127 = add i320 %r126, %r124
%r128 = load i32, i32* %r2
%r129 = getelementptr i32, i32* %r2, i32 5
%r130 = load i32, i32* %r129
%r131 = call i64 @mul32x32L(i32 %r128, i32 %r130)
%r132 = getelementptr i32, i32* %r2, i32 1
%r133 = load i32, i32* %r132
%r134 = getelementptr i32, i32* %r2, i32 6
%r135 = load i32, i32* %r134
%r136 = call i64 @mul32x32L(i32 %r133, i32 %r135)
%r137 = zext i64 %r131 to i128
%r138 = zext i64 %r136 to i128
%r139 = shl i128 %r138, 64
%r140 = or i128 %r137, %r139
%r141 = getelementptr i32, i32* %r2, i32 2
%r142 = load i32, i32* %r141
%r143 = getelementptr i32, i32* %r2, i32 7
%r144 = load i32, i32* %r143
%r145 = call i64 @mul32x32L(i32 %r142, i32 %r144)
%r146 = zext i128 %r140 to i192
%r147 = zext i64 %r145 to i192
%r148 = shl i192 %r147, 128
%r149 = or i192 %r146, %r148
%r150 = getelementptr i32, i32* %r2, i32 3
%r151 = load i32, i32* %r150
%r152 = getelementptr i32, i32* %r2, i32 8
%r153 = load i32, i32* %r152
%r154 = call i64 @mul32x32L(i32 %r151, i32 %r153)
%r155 = zext i192 %r149 to i256
%r156 = zext i64 %r154 to i256
%r157 = shl i256 %r156, 192
%r158 = or i256 %r155, %r157
%r159 = getelementptr i32, i32* %r2, i32 4
%r160 = load i32, i32* %r159
%r161 = getelementptr i32, i32* %r2, i32 9
%r162 = load i32, i32* %r161
%r163 = call i64 @mul32x32L(i32 %r160, i32 %r162)
%r164 = zext i256 %r158 to i320
%r165 = zext i64 %r163 to i320
%r166 = shl i320 %r165, 256
%r167 = or i320 %r164, %r166
%r168 = getelementptr i32, i32* %r2, i32 5
%r169 = load i32, i32* %r168
%r170 = getelementptr i32, i32* %r2, i32 10
%r171 = load i32, i32* %r170
%r172 = call i64 @mul32x32L(i32 %r169, i32 %r171)
%r173 = zext i320 %r167 to i384
%r174 = zext i64 %r172 to i384
%r175 = shl i384 %r174, 320
%r176 = or i384 %r173, %r175
%r177 = zext i320 %r127 to i384
%r178 = shl i384 %r177, 32
%r179 = add i384 %r178, %r176
%r180 = load i32, i32* %r2
%r181 = getelementptr i32, i32* %r2, i32 4
%r182 = load i32, i32* %r181
%r183 = call i64 @mul32x32L(i32 %r180, i32 %r182)
%r184 = getelementptr i32, i32* %r2, i32 1
%r185 = load i32, i32* %r184
%r186 = getelementptr i32, i32* %r2, i32 5
%r187 = load i32, i32* %r186
%r188 = call i64 @mul32x32L(i32 %r185, i32 %r187)
%r189 = zext i64 %r183 to i128
%r190 = zext i64 %r188 to i128
%r191 = shl i128 %r190, 64
%r192 = or i128 %r189, %r191
%r193 = getelementptr i32, i32* %r2, i32 2
%r194 = load i32, i32* %r193
%r195 = getelementptr i32, i32* %r2, i32 6
%r196 = load i32, i32* %r195
%r197 = call i64 @mul32x32L(i32 %r194, i32 %r196)
%r198 = zext i128 %r192 to i192
%r199 = zext i64 %r197 to i192
%r200 = shl i192 %r199, 128
%r201 = or i192 %r198, %r200
%r202 = getelementptr i32, i32* %r2, i32 3
%r203 = load i32, i32* %r202
%r204 = getelementptr i32, i32* %r2, i32 7
%r205 = load i32, i32* %r204
%r206 = call i64 @mul32x32L(i32 %r203, i32 %r205)
%r207 = zext i192 %r201 to i256
%r208 = zext i64 %r206 to i256
%r209 = shl i256 %r208, 192
%r210 = or i256 %r207, %r209
%r211 = getelementptr i32, i32* %r2, i32 4
%r212 = load i32, i32* %r211
%r213 = getelementptr i32, i32* %r2, i32 8
%r214 = load i32, i32* %r213
%r215 = call i64 @mul32x32L(i32 %r212, i32 %r214)
%r216 = zext i256 %r210 to i320
%r217 = zext i64 %r215 to i320
%r218 = shl i320 %r217, 256
%r219 = or i320 %r216, %r218
%r220 = getelementptr i32, i32* %r2, i32 5
%r221 = load i32, i32* %r220
%r222 = getelementptr i32, i32* %r2, i32 9
%r223 = load i32, i32* %r222
%r224 = call i64 @mul32x32L(i32 %r221, i32 %r223)
%r225 = zext i320 %r219 to i384
%r226 = zext i64 %r224 to i384
%r227 = shl i384 %r226, 320
%r228 = or i384 %r225, %r227
%r229 = getelementptr i32, i32* %r2, i32 6
%r230 = load i32, i32* %r229
%r231 = getelementptr i32, i32* %r2, i32 10
%r232 = load i32, i32* %r231
%r233 = call i64 @mul32x32L(i32 %r230, i32 %r232)
%r234 = zext i384 %r228 to i448
%r235 = zext i64 %r233 to i448
%r236 = shl i448 %r235, 384
%r237 = or i448 %r234, %r236
%r238 = zext i384 %r179 to i448
%r239 = shl i448 %r238, 32
%r240 = add i448 %r239, %r237
%r241 = load i32, i32* %r2
%r242 = getelementptr i32, i32* %r2, i32 3
%r243 = load i32, i32* %r242
%r244 = call i64 @mul32x32L(i32 %r241, i32 %r243)
%r245 = getelementptr i32, i32* %r2, i32 1
%r246 = load i32, i32* %r245
%r247 = getelementptr i32, i32* %r2, i32 4
%r248 = load i32, i32* %r247
%r249 = call i64 @mul32x32L(i32 %r246, i32 %r248)
%r250 = zext i64 %r244 to i128
%r251 = zext i64 %r249 to i128
%r252 = shl i128 %r251, 64
%r253 = or i128 %r250, %r252
%r254 = getelementptr i32, i32* %r2, i32 2
%r255 = load i32, i32* %r254
%r256 = getelementptr i32, i32* %r2, i32 5
%r257 = load i32, i32* %r256
%r258 = call i64 @mul32x32L(i32 %r255, i32 %r257)
%r259 = zext i128 %r253 to i192
%r260 = zext i64 %r258 to i192
%r261 = shl i192 %r260, 128
%r262 = or i192 %r259, %r261
%r263 = getelementptr i32, i32* %r2, i32 3
%r264 = load i32, i32* %r263
%r265 = getelementptr i32, i32* %r2, i32 6
%r266 = load i32, i32* %r265
%r267 = call i64 @mul32x32L(i32 %r264, i32 %r266)
%r268 = zext i192 %r262 to i256
%r269 = zext i64 %r267 to i256
%r270 = shl i256 %r269, 192
%r271 = or i256 %r268, %r270
%r272 = getelementptr i32, i32* %r2, i32 4
%r273 = load i32, i32* %r272
%r274 = getelementptr i32, i32* %r2, i32 7
%r275 = load i32, i32* %r274
%r276 = call i64 @mul32x32L(i32 %r273, i32 %r275)
%r277 = zext i256 %r271 to i320
%r278 = zext i64 %r276 to i320
%r279 = shl i320 %r278, 256
%r280 = or i320 %r277, %r279
%r281 = getelementptr i32, i32* %r2, i32 5
%r282 = load i32, i32* %r281
%r283 = getelementptr i32, i32* %r2, i32 8
%r284 = load i32, i32* %r283
%r285 = call i64 @mul32x32L(i32 %r282, i32 %r284)
%r286 = zext i320 %r280 to i384
%r287 = zext i64 %r285 to i384
%r288 = shl i384 %r287, 320
%r289 = or i384 %r286, %r288
%r290 = getelementptr i32, i32* %r2, i32 6
%r291 = load i32, i32* %r290
%r292 = getelementptr i32, i32* %r2, i32 9
%r293 = load i32, i32* %r292
%r294 = call i64 @mul32x32L(i32 %r291, i32 %r293)
%r295 = zext i384 %r289 to i448
%r296 = zext i64 %r294 to i448
%r297 = shl i448 %r296, 384
%r298 = or i448 %r295, %r297
%r299 = getelementptr i32, i32* %r2, i32 7
%r300 = load i32, i32* %r299
%r301 = getelementptr i32, i32* %r2, i32 10
%r302 = load i32, i32* %r301
%r303 = call i64 @mul32x32L(i32 %r300, i32 %r302)
%r304 = zext i448 %r298 to i512
%r305 = zext i64 %r303 to i512
%r306 = shl i512 %r305, 448
%r307 = or i512 %r304, %r306
%r308 = zext i448 %r240 to i512
%r309 = shl i512 %r308, 32
%r310 = add i512 %r309, %r307
%r311 = load i32, i32* %r2
%r312 = getelementptr i32, i32* %r2, i32 2
%r313 = load i32, i32* %r312
%r314 = call i64 @mul32x32L(i32 %r311, i32 %r313)
%r315 = getelementptr i32, i32* %r2, i32 1
%r316 = load i32, i32* %r315
%r317 = getelementptr i32, i32* %r2, i32 3
%r318 = load i32, i32* %r317
%r319 = call i64 @mul32x32L(i32 %r316, i32 %r318)
%r320 = zext i64 %r314 to i128
%r321 = zext i64 %r319 to i128
%r322 = shl i128 %r321, 64
%r323 = or i128 %r320, %r322
%r324 = getelementptr i32, i32* %r2, i32 2
%r325 = load i32, i32* %r324
%r326 = getelementptr i32, i32* %r2, i32 4
%r327 = load i32, i32* %r326
%r328 = call i64 @mul32x32L(i32 %r325, i32 %r327)
%r329 = zext i128 %r323 to i192
%r330 = zext i64 %r328 to i192
%r331 = shl i192 %r330, 128
%r332 = or i192 %r329, %r331
%r333 = getelementptr i32, i32* %r2, i32 3
%r334 = load i32, i32* %r333
%r335 = getelementptr i32, i32* %r2, i32 5
%r336 = load i32, i32* %r335
%r337 = call i64 @mul32x32L(i32 %r334, i32 %r336)
%r338 = zext i192 %r332 to i256
%r339 = zext i64 %r337 to i256
%r340 = shl i256 %r339, 192
%r341 = or i256 %r338, %r340
%r342 = getelementptr i32, i32* %r2, i32 4
%r343 = load i32, i32* %r342
%r344 = getelementptr i32, i32* %r2, i32 6
%r345 = load i32, i32* %r344
%r346 = call i64 @mul32x32L(i32 %r343, i32 %r345)
%r347 = zext i256 %r341 to i320
%r348 = zext i64 %r346 to i320
%r349 = shl i320 %r348, 256
%r350 = or i320 %r347, %r349
%r351 = getelementptr i32, i32* %r2, i32 5
%r352 = load i32, i32* %r351
%r353 = getelementptr i32, i32* %r2, i32 7
%r354 = load i32, i32* %r353
%r355 = call i64 @mul32x32L(i32 %r352, i32 %r354)
%r356 = zext i320 %r350 to i384
%r357 = zext i64 %r355 to i384
%r358 = shl i384 %r357, 320
%r359 = or i384 %r356, %r358
%r360 = getelementptr i32, i32* %r2, i32 6
%r361 = load i32, i32* %r360
%r362 = getelementptr i32, i32* %r2, i32 8
%r363 = load i32, i32* %r362
%r364 = call i64 @mul32x32L(i32 %r361, i32 %r363)
%r365 = zext i384 %r359 to i448
%r366 = zext i64 %r364 to i448
%r367 = shl i448 %r366, 384
%r368 = or i448 %r365, %r367
%r369 = getelementptr i32, i32* %r2, i32 7
%r370 = load i32, i32* %r369
%r371 = getelementptr i32, i32* %r2, i32 9
%r372 = load i32, i32* %r371
%r373 = call i64 @mul32x32L(i32 %r370, i32 %r372)
%r374 = zext i448 %r368 to i512
%r375 = zext i64 %r373 to i512
%r376 = shl i512 %r375, 448
%r377 = or i512 %r374, %r376
%r378 = getelementptr i32, i32* %r2, i32 8
%r379 = load i32, i32* %r378
%r380 = getelementptr i32, i32* %r2, i32 10
%r381 = load i32, i32* %r380
%r382 = call i64 @mul32x32L(i32 %r379, i32 %r381)
%r383 = zext i512 %r377 to i576
%r384 = zext i64 %r382 to i576
%r385 = shl i576 %r384, 512
%r386 = or i576 %r383, %r385
%r387 = zext i512 %r310 to i576
%r388 = shl i576 %r387, 32
%r389 = add i576 %r388, %r386
%r390 = load i32, i32* %r2
%r391 = getelementptr i32, i32* %r2, i32 1
%r392 = load i32, i32* %r391
%r393 = call i64 @mul32x32L(i32 %r390, i32 %r392)
%r394 = getelementptr i32, i32* %r2, i32 1
%r395 = load i32, i32* %r394
%r396 = getelementptr i32, i32* %r2, i32 2
%r397 = load i32, i32* %r396
%r398 = call i64 @mul32x32L(i32 %r395, i32 %r397)
%r399 = zext i64 %r393 to i128
%r400 = zext i64 %r398 to i128
%r401 = shl i128 %r400, 64
%r402 = or i128 %r399, %r401
%r403 = getelementptr i32, i32* %r2, i32 2
%r404 = load i32, i32* %r403
%r405 = getelementptr i32, i32* %r2, i32 3
%r406 = load i32, i32* %r405
%r407 = call i64 @mul32x32L(i32 %r404, i32 %r406)
%r408 = zext i128 %r402 to i192
%r409 = zext i64 %r407 to i192
%r410 = shl i192 %r409, 128
%r411 = or i192 %r408, %r410
%r412 = getelementptr i32, i32* %r2, i32 3
%r413 = load i32, i32* %r412
%r414 = getelementptr i32, i32* %r2, i32 4
%r415 = load i32, i32* %r414
%r416 = call i64 @mul32x32L(i32 %r413, i32 %r415)
%r417 = zext i192 %r411 to i256
%r418 = zext i64 %r416 to i256
%r419 = shl i256 %r418, 192
%r420 = or i256 %r417, %r419
%r421 = getelementptr i32, i32* %r2, i32 4
%r422 = load i32, i32* %r421
%r423 = getelementptr i32, i32* %r2, i32 5
%r424 = load i32, i32* %r423
%r425 = call i64 @mul32x32L(i32 %r422, i32 %r424)
%r426 = zext i256 %r420 to i320
%r427 = zext i64 %r425 to i320
%r428 = shl i320 %r427, 256
%r429 = or i320 %r426, %r428
%r430 = getelementptr i32, i32* %r2, i32 5
%r431 = load i32, i32* %r430
%r432 = getelementptr i32, i32* %r2, i32 6
%r433 = load i32, i32* %r432
%r434 = call i64 @mul32x32L(i32 %r431, i32 %r433)
%r435 = zext i320 %r429 to i384
%r436 = zext i64 %r434 to i384
%r437 = shl i384 %r436, 320
%r438 = or i384 %r435, %r437
%r439 = getelementptr i32, i32* %r2, i32 6
%r440 = load i32, i32* %r439
%r441 = getelementptr i32, i32* %r2, i32 7
%r442 = load i32, i32* %r441
%r443 = call i64 @mul32x32L(i32 %r440, i32 %r442)
%r444 = zext i384 %r438 to i448
%r445 = zext i64 %r443 to i448
%r446 = shl i448 %r445, 384
%r447 = or i448 %r444, %r446
%r448 = getelementptr i32, i32* %r2, i32 7
%r449 = load i32, i32* %r448
%r450 = getelementptr i32, i32* %r2, i32 8
%r451 = load i32, i32* %r450
%r452 = call i64 @mul32x32L(i32 %r449, i32 %r451)
%r453 = zext i448 %r447 to i512
%r454 = zext i64 %r452 to i512
%r455 = shl i512 %r454, 448
%r456 = or i512 %r453, %r455
%r457 = getelementptr i32, i32* %r2, i32 8
%r458 = load i32, i32* %r457
%r459 = getelementptr i32, i32* %r2, i32 9
%r460 = load i32, i32* %r459
%r461 = call i64 @mul32x32L(i32 %r458, i32 %r460)
%r462 = zext i512 %r456 to i576
%r463 = zext i64 %r461 to i576
%r464 = shl i576 %r463, 512
%r465 = or i576 %r462, %r464
%r466 = getelementptr i32, i32* %r2, i32 9
%r467 = load i32, i32* %r466
%r468 = getelementptr i32, i32* %r2, i32 10
%r469 = load i32, i32* %r468
%r470 = call i64 @mul32x32L(i32 %r467, i32 %r469)
%r471 = zext i576 %r465 to i640
%r472 = zext i64 %r470 to i640
%r473 = shl i640 %r472, 576
%r474 = or i640 %r471, %r473
%r475 = zext i576 %r389 to i640
%r476 = shl i640 %r475, 32
%r477 = add i640 %r476, %r474
%r478 = zext i64 %r6 to i672
%r479 = getelementptr i32, i32* %r2, i32 1
%r480 = load i32, i32* %r479
%r481 = call i64 @mul32x32L(i32 %r480, i32 %r480)
%r482 = zext i64 %r481 to i672
%r483 = shl i672 %r482, 32
%r484 = or i672 %r478, %r483
%r485 = getelementptr i32, i32* %r2, i32 2
%r486 = load i32, i32* %r485
%r487 = call i64 @mul32x32L(i32 %r486, i32 %r486)
%r488 = zext i64 %r487 to i672
%r489 = shl i672 %r488, 96
%r490 = or i672 %r484, %r489
%r491 = getelementptr i32, i32* %r2, i32 3
%r492 = load i32, i32* %r491
%r493 = call i64 @mul32x32L(i32 %r492, i32 %r492)
%r494 = zext i64 %r493 to i672
%r495 = shl i672 %r494, 160
%r496 = or i672 %r490, %r495
%r497 = getelementptr i32, i32* %r2, i32 4
%r498 = load i32, i32* %r497
%r499 = call i64 @mul32x32L(i32 %r498, i32 %r498)
%r500 = zext i64 %r499 to i672
%r501 = shl i672 %r500, 224
%r502 = or i672 %r496, %r501
%r503 = getelementptr i32, i32* %r2, i32 5
%r504 = load i32, i32* %r503
%r505 = call i64 @mul32x32L(i32 %r504, i32 %r504)
%r506 = zext i64 %r505 to i672
%r507 = shl i672 %r506, 288
%r508 = or i672 %r502, %r507
%r509 = getelementptr i32, i32* %r2, i32 6
%r510 = load i32, i32* %r509
%r511 = call i64 @mul32x32L(i32 %r510, i32 %r510)
%r512 = zext i64 %r511 to i672
%r513 = shl i672 %r512, 352
%r514 = or i672 %r508, %r513
%r515 = getelementptr i32, i32* %r2, i32 7
%r516 = load i32, i32* %r515
%r517 = call i64 @mul32x32L(i32 %r516, i32 %r516)
%r518 = zext i64 %r517 to i672
%r519 = shl i672 %r518, 416
%r520 = or i672 %r514, %r519
%r521 = getelementptr i32, i32* %r2, i32 8
%r522 = load i32, i32* %r521
%r523 = call i64 @mul32x32L(i32 %r522, i32 %r522)
%r524 = zext i64 %r523 to i672
%r525 = shl i672 %r524, 480
%r526 = or i672 %r520, %r525
%r527 = getelementptr i32, i32* %r2, i32 9
%r528 = load i32, i32* %r527
%r529 = call i64 @mul32x32L(i32 %r528, i32 %r528)
%r530 = zext i64 %r529 to i672
%r531 = shl i672 %r530, 544
%r532 = or i672 %r526, %r531
%r533 = getelementptr i32, i32* %r2, i32 10
%r534 = load i32, i32* %r533
%r535 = call i64 @mul32x32L(i32 %r534, i32 %r534)
%r536 = zext i64 %r535 to i672
%r537 = shl i672 %r536, 608
%r538 = or i672 %r532, %r537
%r539 = zext i640 %r477 to i672
%r540 = add i672 %r539, %r539
%r541 = add i672 %r538, %r540
%r542 = getelementptr i32, i32* %r1, i32 1
%r543 = bitcast i32* %r542 to i672*
store i672 %r541, i672* %r543
ret void
}
define i416 @mulUnit_inner384(i32* noalias %r2, i32 %r3)
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
define i32 @mclb_mulUnit12(i32* noalias %r1, i32* noalias %r2, i32 %r3)
{
%r5 = call i416 @mulUnit_inner384(i32* %r2, i32 %r3)
%r6 = trunc i416 %r5 to i384
%r7 = bitcast i32* %r1 to i384*
store i384 %r6, i384* %r7
%r8 = lshr i416 %r5, 384
%r9 = trunc i416 %r8 to i32
ret i32 %r9
}
define i32 @mclb_mulUnitAdd12(i32* noalias %r1, i32* noalias %r2, i32 %r3)
{
%r5 = call i64 @mulPos32x32(i32* %r2, i32 %r3, i32 0)
%r6 = trunc i64 %r5 to i32
%r7 = call i32 @extractHigh32(i64 %r5)
%r8 = call i64 @mulPos32x32(i32* %r2, i32 %r3, i32 1)
%r9 = trunc i64 %r8 to i32
%r10 = call i32 @extractHigh32(i64 %r8)
%r11 = call i64 @mulPos32x32(i32* %r2, i32 %r3, i32 2)
%r12 = trunc i64 %r11 to i32
%r13 = call i32 @extractHigh32(i64 %r11)
%r14 = call i64 @mulPos32x32(i32* %r2, i32 %r3, i32 3)
%r15 = trunc i64 %r14 to i32
%r16 = call i32 @extractHigh32(i64 %r14)
%r17 = call i64 @mulPos32x32(i32* %r2, i32 %r3, i32 4)
%r18 = trunc i64 %r17 to i32
%r19 = call i32 @extractHigh32(i64 %r17)
%r20 = call i64 @mulPos32x32(i32* %r2, i32 %r3, i32 5)
%r21 = trunc i64 %r20 to i32
%r22 = call i32 @extractHigh32(i64 %r20)
%r23 = call i64 @mulPos32x32(i32* %r2, i32 %r3, i32 6)
%r24 = trunc i64 %r23 to i32
%r25 = call i32 @extractHigh32(i64 %r23)
%r26 = call i64 @mulPos32x32(i32* %r2, i32 %r3, i32 7)
%r27 = trunc i64 %r26 to i32
%r28 = call i32 @extractHigh32(i64 %r26)
%r29 = call i64 @mulPos32x32(i32* %r2, i32 %r3, i32 8)
%r30 = trunc i64 %r29 to i32
%r31 = call i32 @extractHigh32(i64 %r29)
%r32 = call i64 @mulPos32x32(i32* %r2, i32 %r3, i32 9)
%r33 = trunc i64 %r32 to i32
%r34 = call i32 @extractHigh32(i64 %r32)
%r35 = call i64 @mulPos32x32(i32* %r2, i32 %r3, i32 10)
%r36 = trunc i64 %r35 to i32
%r37 = call i32 @extractHigh32(i64 %r35)
%r38 = call i64 @mulPos32x32(i32* %r2, i32 %r3, i32 11)
%r39 = trunc i64 %r38 to i32
%r40 = call i32 @extractHigh32(i64 %r38)
%r41 = zext i32 %r6 to i64
%r42 = zext i32 %r9 to i64
%r43 = shl i64 %r42, 32
%r44 = or i64 %r41, %r43
%r45 = zext i64 %r44 to i96
%r46 = zext i32 %r12 to i96
%r47 = shl i96 %r46, 64
%r48 = or i96 %r45, %r47
%r49 = zext i96 %r48 to i128
%r50 = zext i32 %r15 to i128
%r51 = shl i128 %r50, 96
%r52 = or i128 %r49, %r51
%r53 = zext i128 %r52 to i160
%r54 = zext i32 %r18 to i160
%r55 = shl i160 %r54, 128
%r56 = or i160 %r53, %r55
%r57 = zext i160 %r56 to i192
%r58 = zext i32 %r21 to i192
%r59 = shl i192 %r58, 160
%r60 = or i192 %r57, %r59
%r61 = zext i192 %r60 to i224
%r62 = zext i32 %r24 to i224
%r63 = shl i224 %r62, 192
%r64 = or i224 %r61, %r63
%r65 = zext i224 %r64 to i256
%r66 = zext i32 %r27 to i256
%r67 = shl i256 %r66, 224
%r68 = or i256 %r65, %r67
%r69 = zext i256 %r68 to i288
%r70 = zext i32 %r30 to i288
%r71 = shl i288 %r70, 256
%r72 = or i288 %r69, %r71
%r73 = zext i288 %r72 to i320
%r74 = zext i32 %r33 to i320
%r75 = shl i320 %r74, 288
%r76 = or i320 %r73, %r75
%r77 = zext i320 %r76 to i352
%r78 = zext i32 %r36 to i352
%r79 = shl i352 %r78, 320
%r80 = or i352 %r77, %r79
%r81 = zext i352 %r80 to i384
%r82 = zext i32 %r39 to i384
%r83 = shl i384 %r82, 352
%r84 = or i384 %r81, %r83
%r85 = zext i32 %r7 to i64
%r86 = zext i32 %r10 to i64
%r87 = shl i64 %r86, 32
%r88 = or i64 %r85, %r87
%r89 = zext i64 %r88 to i96
%r90 = zext i32 %r13 to i96
%r91 = shl i96 %r90, 64
%r92 = or i96 %r89, %r91
%r93 = zext i96 %r92 to i128
%r94 = zext i32 %r16 to i128
%r95 = shl i128 %r94, 96
%r96 = or i128 %r93, %r95
%r97 = zext i128 %r96 to i160
%r98 = zext i32 %r19 to i160
%r99 = shl i160 %r98, 128
%r100 = or i160 %r97, %r99
%r101 = zext i160 %r100 to i192
%r102 = zext i32 %r22 to i192
%r103 = shl i192 %r102, 160
%r104 = or i192 %r101, %r103
%r105 = zext i192 %r104 to i224
%r106 = zext i32 %r25 to i224
%r107 = shl i224 %r106, 192
%r108 = or i224 %r105, %r107
%r109 = zext i224 %r108 to i256
%r110 = zext i32 %r28 to i256
%r111 = shl i256 %r110, 224
%r112 = or i256 %r109, %r111
%r113 = zext i256 %r112 to i288
%r114 = zext i32 %r31 to i288
%r115 = shl i288 %r114, 256
%r116 = or i288 %r113, %r115
%r117 = zext i288 %r116 to i320
%r118 = zext i32 %r34 to i320
%r119 = shl i320 %r118, 288
%r120 = or i320 %r117, %r119
%r121 = zext i320 %r120 to i352
%r122 = zext i32 %r37 to i352
%r123 = shl i352 %r122, 320
%r124 = or i352 %r121, %r123
%r125 = zext i352 %r124 to i384
%r126 = zext i32 %r40 to i384
%r127 = shl i384 %r126, 352
%r128 = or i384 %r125, %r127
%r129 = zext i384 %r84 to i416
%r130 = zext i384 %r128 to i416
%r131 = shl i416 %r130, 32
%r132 = add i416 %r129, %r131
%r133 = bitcast i32* %r1 to i384*
%r134 = load i384, i384* %r133
%r135 = zext i384 %r134 to i416
%r136 = add i416 %r132, %r135
%r137 = trunc i416 %r136 to i384
%r138 = bitcast i32* %r1 to i384*
store i384 %r137, i384* %r138
%r139 = lshr i416 %r136, 384
%r140 = trunc i416 %r139 to i32
ret i32 %r140
}
define void @mclb_mul12(i32* noalias %r1, i32* noalias %r2, i32* noalias %r3)
{
%r4 = getelementptr i32, i32* %r2, i32 6
%r5 = getelementptr i32, i32* %r3, i32 6
%r6 = getelementptr i32, i32* %r1, i32 12
call void @mclb_mul6(i32* %r1, i32* %r2, i32* %r3)
call void @mclb_mul6(i32* %r6, i32* %r4, i32* %r5)
%r7 = bitcast i32* %r4 to i192*
%r8 = load i192, i192* %r7
%r9 = zext i192 %r8 to i224
%r10 = bitcast i32* %r2 to i192*
%r11 = load i192, i192* %r10
%r12 = zext i192 %r11 to i224
%r13 = bitcast i32* %r5 to i192*
%r14 = load i192, i192* %r13
%r15 = zext i192 %r14 to i224
%r16 = bitcast i32* %r3 to i192*
%r17 = load i192, i192* %r16
%r18 = zext i192 %r17 to i224
%r19 = add i224 %r9, %r12
%r20 = add i224 %r15, %r18
%r21 = alloca i32, i32 12
%r22 = trunc i224 %r19 to i192
%r23 = trunc i224 %r20 to i192
%r24 = lshr i224 %r19, 192
%r25 = trunc i224 %r24 to i1
%r26 = lshr i224 %r20, 192
%r27 = trunc i224 %r26 to i1
%r28 = and i1 %r25, %r27
%r29 = select i1 %r25, i192 %r23, i192 0
%r30 = select i1 %r27, i192 %r22, i192 0
%r31 = alloca i32, i32 6
%r32 = alloca i32, i32 6
%r33 = bitcast i32* %r31 to i192*
store i192 %r22, i192* %r33
%r34 = bitcast i32* %r32 to i192*
store i192 %r23, i192* %r34
call void @mclb_mul6(i32* %r21, i32* %r31, i32* %r32)
%r35 = bitcast i32* %r21 to i384*
%r36 = load i384, i384* %r35
%r37 = zext i384 %r36 to i416
%r38 = zext i1 %r28 to i416
%r39 = shl i416 %r38, 384
%r40 = or i416 %r37, %r39
%r41 = zext i192 %r29 to i416
%r42 = zext i192 %r30 to i416
%r43 = shl i416 %r41, 192
%r44 = shl i416 %r42, 192
%r45 = add i416 %r40, %r43
%r46 = add i416 %r45, %r44
%r47 = bitcast i32* %r1 to i384*
%r48 = load i384, i384* %r47
%r49 = zext i384 %r48 to i416
%r50 = sub i416 %r46, %r49
%r51 = getelementptr i32, i32* %r1, i32 12
%r52 = bitcast i32* %r51 to i384*
%r53 = load i384, i384* %r52
%r54 = zext i384 %r53 to i416
%r55 = sub i416 %r50, %r54
%r56 = zext i416 %r55 to i576
%r57 = getelementptr i32, i32* %r1, i32 6
%r58 = bitcast i32* %r57 to i576*
%r59 = load i576, i576* %r58
%r60 = add i576 %r56, %r59
%r61 = getelementptr i32, i32* %r1, i32 6
%r62 = bitcast i32* %r61 to i576*
store i576 %r60, i576* %r62
ret void
}
define void @mclb_sqr12(i32* noalias %r1, i32* noalias %r2)
{
%r3 = getelementptr i32, i32* %r2, i32 6
%r4 = getelementptr i32, i32* %r1, i32 12
%r5 = alloca i32, i32 12
call void @mclb_mul6(i32* %r5, i32* %r2, i32* %r3)
call void @mclb_sqr6(i32* %r1, i32* %r2)
call void @mclb_sqr6(i32* %r4, i32* %r3)
%r6 = bitcast i32* %r5 to i384*
%r7 = load i384, i384* %r6
%r8 = zext i384 %r7 to i416
%r9 = add i416 %r8, %r8
%r10 = zext i416 %r9 to i576
%r11 = getelementptr i32, i32* %r1, i32 6
%r12 = bitcast i32* %r11 to i576*
%r13 = load i576, i576* %r12
%r14 = add i576 %r13, %r10
%r15 = bitcast i32* %r11 to i576*
store i576 %r14, i576* %r15
ret void
}
define i448 @mulUnit_inner416(i32* noalias %r2, i32 %r3)
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
%r43 = zext i32 %r5 to i64
%r44 = zext i32 %r8 to i64
%r45 = shl i64 %r44, 32
%r46 = or i64 %r43, %r45
%r47 = zext i64 %r46 to i96
%r48 = zext i32 %r11 to i96
%r49 = shl i96 %r48, 64
%r50 = or i96 %r47, %r49
%r51 = zext i96 %r50 to i128
%r52 = zext i32 %r14 to i128
%r53 = shl i128 %r52, 96
%r54 = or i128 %r51, %r53
%r55 = zext i128 %r54 to i160
%r56 = zext i32 %r17 to i160
%r57 = shl i160 %r56, 128
%r58 = or i160 %r55, %r57
%r59 = zext i160 %r58 to i192
%r60 = zext i32 %r20 to i192
%r61 = shl i192 %r60, 160
%r62 = or i192 %r59, %r61
%r63 = zext i192 %r62 to i224
%r64 = zext i32 %r23 to i224
%r65 = shl i224 %r64, 192
%r66 = or i224 %r63, %r65
%r67 = zext i224 %r66 to i256
%r68 = zext i32 %r26 to i256
%r69 = shl i256 %r68, 224
%r70 = or i256 %r67, %r69
%r71 = zext i256 %r70 to i288
%r72 = zext i32 %r29 to i288
%r73 = shl i288 %r72, 256
%r74 = or i288 %r71, %r73
%r75 = zext i288 %r74 to i320
%r76 = zext i32 %r32 to i320
%r77 = shl i320 %r76, 288
%r78 = or i320 %r75, %r77
%r79 = zext i320 %r78 to i352
%r80 = zext i32 %r35 to i352
%r81 = shl i352 %r80, 320
%r82 = or i352 %r79, %r81
%r83 = zext i352 %r82 to i384
%r84 = zext i32 %r38 to i384
%r85 = shl i384 %r84, 352
%r86 = or i384 %r83, %r85
%r87 = zext i384 %r86 to i416
%r88 = zext i32 %r41 to i416
%r89 = shl i416 %r88, 384
%r90 = or i416 %r87, %r89
%r91 = zext i32 %r6 to i64
%r92 = zext i32 %r9 to i64
%r93 = shl i64 %r92, 32
%r94 = or i64 %r91, %r93
%r95 = zext i64 %r94 to i96
%r96 = zext i32 %r12 to i96
%r97 = shl i96 %r96, 64
%r98 = or i96 %r95, %r97
%r99 = zext i96 %r98 to i128
%r100 = zext i32 %r15 to i128
%r101 = shl i128 %r100, 96
%r102 = or i128 %r99, %r101
%r103 = zext i128 %r102 to i160
%r104 = zext i32 %r18 to i160
%r105 = shl i160 %r104, 128
%r106 = or i160 %r103, %r105
%r107 = zext i160 %r106 to i192
%r108 = zext i32 %r21 to i192
%r109 = shl i192 %r108, 160
%r110 = or i192 %r107, %r109
%r111 = zext i192 %r110 to i224
%r112 = zext i32 %r24 to i224
%r113 = shl i224 %r112, 192
%r114 = or i224 %r111, %r113
%r115 = zext i224 %r114 to i256
%r116 = zext i32 %r27 to i256
%r117 = shl i256 %r116, 224
%r118 = or i256 %r115, %r117
%r119 = zext i256 %r118 to i288
%r120 = zext i32 %r30 to i288
%r121 = shl i288 %r120, 256
%r122 = or i288 %r119, %r121
%r123 = zext i288 %r122 to i320
%r124 = zext i32 %r33 to i320
%r125 = shl i320 %r124, 288
%r126 = or i320 %r123, %r125
%r127 = zext i320 %r126 to i352
%r128 = zext i32 %r36 to i352
%r129 = shl i352 %r128, 320
%r130 = or i352 %r127, %r129
%r131 = zext i352 %r130 to i384
%r132 = zext i32 %r39 to i384
%r133 = shl i384 %r132, 352
%r134 = or i384 %r131, %r133
%r135 = zext i384 %r134 to i416
%r136 = zext i32 %r42 to i416
%r137 = shl i416 %r136, 384
%r138 = or i416 %r135, %r137
%r139 = zext i416 %r90 to i448
%r140 = zext i416 %r138 to i448
%r141 = shl i448 %r140, 32
%r142 = add i448 %r139, %r141
ret i448 %r142
}
define i32 @mclb_mulUnit13(i32* noalias %r1, i32* noalias %r2, i32 %r3)
{
%r5 = call i448 @mulUnit_inner416(i32* %r2, i32 %r3)
%r6 = trunc i448 %r5 to i416
%r7 = bitcast i32* %r1 to i416*
store i416 %r6, i416* %r7
%r8 = lshr i448 %r5, 416
%r9 = trunc i448 %r8 to i32
ret i32 %r9
}
define i32 @mclb_mulUnitAdd13(i32* noalias %r1, i32* noalias %r2, i32 %r3)
{
%r5 = call i64 @mulPos32x32(i32* %r2, i32 %r3, i32 0)
%r6 = trunc i64 %r5 to i32
%r7 = call i32 @extractHigh32(i64 %r5)
%r8 = call i64 @mulPos32x32(i32* %r2, i32 %r3, i32 1)
%r9 = trunc i64 %r8 to i32
%r10 = call i32 @extractHigh32(i64 %r8)
%r11 = call i64 @mulPos32x32(i32* %r2, i32 %r3, i32 2)
%r12 = trunc i64 %r11 to i32
%r13 = call i32 @extractHigh32(i64 %r11)
%r14 = call i64 @mulPos32x32(i32* %r2, i32 %r3, i32 3)
%r15 = trunc i64 %r14 to i32
%r16 = call i32 @extractHigh32(i64 %r14)
%r17 = call i64 @mulPos32x32(i32* %r2, i32 %r3, i32 4)
%r18 = trunc i64 %r17 to i32
%r19 = call i32 @extractHigh32(i64 %r17)
%r20 = call i64 @mulPos32x32(i32* %r2, i32 %r3, i32 5)
%r21 = trunc i64 %r20 to i32
%r22 = call i32 @extractHigh32(i64 %r20)
%r23 = call i64 @mulPos32x32(i32* %r2, i32 %r3, i32 6)
%r24 = trunc i64 %r23 to i32
%r25 = call i32 @extractHigh32(i64 %r23)
%r26 = call i64 @mulPos32x32(i32* %r2, i32 %r3, i32 7)
%r27 = trunc i64 %r26 to i32
%r28 = call i32 @extractHigh32(i64 %r26)
%r29 = call i64 @mulPos32x32(i32* %r2, i32 %r3, i32 8)
%r30 = trunc i64 %r29 to i32
%r31 = call i32 @extractHigh32(i64 %r29)
%r32 = call i64 @mulPos32x32(i32* %r2, i32 %r3, i32 9)
%r33 = trunc i64 %r32 to i32
%r34 = call i32 @extractHigh32(i64 %r32)
%r35 = call i64 @mulPos32x32(i32* %r2, i32 %r3, i32 10)
%r36 = trunc i64 %r35 to i32
%r37 = call i32 @extractHigh32(i64 %r35)
%r38 = call i64 @mulPos32x32(i32* %r2, i32 %r3, i32 11)
%r39 = trunc i64 %r38 to i32
%r40 = call i32 @extractHigh32(i64 %r38)
%r41 = call i64 @mulPos32x32(i32* %r2, i32 %r3, i32 12)
%r42 = trunc i64 %r41 to i32
%r43 = call i32 @extractHigh32(i64 %r41)
%r44 = zext i32 %r6 to i64
%r45 = zext i32 %r9 to i64
%r46 = shl i64 %r45, 32
%r47 = or i64 %r44, %r46
%r48 = zext i64 %r47 to i96
%r49 = zext i32 %r12 to i96
%r50 = shl i96 %r49, 64
%r51 = or i96 %r48, %r50
%r52 = zext i96 %r51 to i128
%r53 = zext i32 %r15 to i128
%r54 = shl i128 %r53, 96
%r55 = or i128 %r52, %r54
%r56 = zext i128 %r55 to i160
%r57 = zext i32 %r18 to i160
%r58 = shl i160 %r57, 128
%r59 = or i160 %r56, %r58
%r60 = zext i160 %r59 to i192
%r61 = zext i32 %r21 to i192
%r62 = shl i192 %r61, 160
%r63 = or i192 %r60, %r62
%r64 = zext i192 %r63 to i224
%r65 = zext i32 %r24 to i224
%r66 = shl i224 %r65, 192
%r67 = or i224 %r64, %r66
%r68 = zext i224 %r67 to i256
%r69 = zext i32 %r27 to i256
%r70 = shl i256 %r69, 224
%r71 = or i256 %r68, %r70
%r72 = zext i256 %r71 to i288
%r73 = zext i32 %r30 to i288
%r74 = shl i288 %r73, 256
%r75 = or i288 %r72, %r74
%r76 = zext i288 %r75 to i320
%r77 = zext i32 %r33 to i320
%r78 = shl i320 %r77, 288
%r79 = or i320 %r76, %r78
%r80 = zext i320 %r79 to i352
%r81 = zext i32 %r36 to i352
%r82 = shl i352 %r81, 320
%r83 = or i352 %r80, %r82
%r84 = zext i352 %r83 to i384
%r85 = zext i32 %r39 to i384
%r86 = shl i384 %r85, 352
%r87 = or i384 %r84, %r86
%r88 = zext i384 %r87 to i416
%r89 = zext i32 %r42 to i416
%r90 = shl i416 %r89, 384
%r91 = or i416 %r88, %r90
%r92 = zext i32 %r7 to i64
%r93 = zext i32 %r10 to i64
%r94 = shl i64 %r93, 32
%r95 = or i64 %r92, %r94
%r96 = zext i64 %r95 to i96
%r97 = zext i32 %r13 to i96
%r98 = shl i96 %r97, 64
%r99 = or i96 %r96, %r98
%r100 = zext i96 %r99 to i128
%r101 = zext i32 %r16 to i128
%r102 = shl i128 %r101, 96
%r103 = or i128 %r100, %r102
%r104 = zext i128 %r103 to i160
%r105 = zext i32 %r19 to i160
%r106 = shl i160 %r105, 128
%r107 = or i160 %r104, %r106
%r108 = zext i160 %r107 to i192
%r109 = zext i32 %r22 to i192
%r110 = shl i192 %r109, 160
%r111 = or i192 %r108, %r110
%r112 = zext i192 %r111 to i224
%r113 = zext i32 %r25 to i224
%r114 = shl i224 %r113, 192
%r115 = or i224 %r112, %r114
%r116 = zext i224 %r115 to i256
%r117 = zext i32 %r28 to i256
%r118 = shl i256 %r117, 224
%r119 = or i256 %r116, %r118
%r120 = zext i256 %r119 to i288
%r121 = zext i32 %r31 to i288
%r122 = shl i288 %r121, 256
%r123 = or i288 %r120, %r122
%r124 = zext i288 %r123 to i320
%r125 = zext i32 %r34 to i320
%r126 = shl i320 %r125, 288
%r127 = or i320 %r124, %r126
%r128 = zext i320 %r127 to i352
%r129 = zext i32 %r37 to i352
%r130 = shl i352 %r129, 320
%r131 = or i352 %r128, %r130
%r132 = zext i352 %r131 to i384
%r133 = zext i32 %r40 to i384
%r134 = shl i384 %r133, 352
%r135 = or i384 %r132, %r134
%r136 = zext i384 %r135 to i416
%r137 = zext i32 %r43 to i416
%r138 = shl i416 %r137, 384
%r139 = or i416 %r136, %r138
%r140 = zext i416 %r91 to i448
%r141 = zext i416 %r139 to i448
%r142 = shl i448 %r141, 32
%r143 = add i448 %r140, %r142
%r144 = bitcast i32* %r1 to i416*
%r145 = load i416, i416* %r144
%r146 = zext i416 %r145 to i448
%r147 = add i448 %r143, %r146
%r148 = trunc i448 %r147 to i416
%r149 = bitcast i32* %r1 to i416*
store i416 %r148, i416* %r149
%r150 = lshr i448 %r147, 416
%r151 = trunc i448 %r150 to i32
ret i32 %r151
}
define void @mclb_mul13(i32* noalias %r1, i32* noalias %r2, i32* noalias %r3)
{
%r4 = load i32, i32* %r3
%r5 = call i448 @mulUnit_inner416(i32* %r2, i32 %r4)
%r6 = trunc i448 %r5 to i32
store i32 %r6, i32* %r1
%r7 = lshr i448 %r5, 32
%r8 = getelementptr i32, i32* %r3, i32 1
%r9 = load i32, i32* %r8
%r10 = call i448 @mulUnit_inner416(i32* %r2, i32 %r9)
%r11 = add i448 %r7, %r10
%r12 = trunc i448 %r11 to i32
%r13 = getelementptr i32, i32* %r1, i32 1
store i32 %r12, i32* %r13
%r14 = lshr i448 %r11, 32
%r15 = getelementptr i32, i32* %r3, i32 2
%r16 = load i32, i32* %r15
%r17 = call i448 @mulUnit_inner416(i32* %r2, i32 %r16)
%r18 = add i448 %r14, %r17
%r19 = trunc i448 %r18 to i32
%r20 = getelementptr i32, i32* %r1, i32 2
store i32 %r19, i32* %r20
%r21 = lshr i448 %r18, 32
%r22 = getelementptr i32, i32* %r3, i32 3
%r23 = load i32, i32* %r22
%r24 = call i448 @mulUnit_inner416(i32* %r2, i32 %r23)
%r25 = add i448 %r21, %r24
%r26 = trunc i448 %r25 to i32
%r27 = getelementptr i32, i32* %r1, i32 3
store i32 %r26, i32* %r27
%r28 = lshr i448 %r25, 32
%r29 = getelementptr i32, i32* %r3, i32 4
%r30 = load i32, i32* %r29
%r31 = call i448 @mulUnit_inner416(i32* %r2, i32 %r30)
%r32 = add i448 %r28, %r31
%r33 = trunc i448 %r32 to i32
%r34 = getelementptr i32, i32* %r1, i32 4
store i32 %r33, i32* %r34
%r35 = lshr i448 %r32, 32
%r36 = getelementptr i32, i32* %r3, i32 5
%r37 = load i32, i32* %r36
%r38 = call i448 @mulUnit_inner416(i32* %r2, i32 %r37)
%r39 = add i448 %r35, %r38
%r40 = trunc i448 %r39 to i32
%r41 = getelementptr i32, i32* %r1, i32 5
store i32 %r40, i32* %r41
%r42 = lshr i448 %r39, 32
%r43 = getelementptr i32, i32* %r3, i32 6
%r44 = load i32, i32* %r43
%r45 = call i448 @mulUnit_inner416(i32* %r2, i32 %r44)
%r46 = add i448 %r42, %r45
%r47 = trunc i448 %r46 to i32
%r48 = getelementptr i32, i32* %r1, i32 6
store i32 %r47, i32* %r48
%r49 = lshr i448 %r46, 32
%r50 = getelementptr i32, i32* %r3, i32 7
%r51 = load i32, i32* %r50
%r52 = call i448 @mulUnit_inner416(i32* %r2, i32 %r51)
%r53 = add i448 %r49, %r52
%r54 = trunc i448 %r53 to i32
%r55 = getelementptr i32, i32* %r1, i32 7
store i32 %r54, i32* %r55
%r56 = lshr i448 %r53, 32
%r57 = getelementptr i32, i32* %r3, i32 8
%r58 = load i32, i32* %r57
%r59 = call i448 @mulUnit_inner416(i32* %r2, i32 %r58)
%r60 = add i448 %r56, %r59
%r61 = trunc i448 %r60 to i32
%r62 = getelementptr i32, i32* %r1, i32 8
store i32 %r61, i32* %r62
%r63 = lshr i448 %r60, 32
%r64 = getelementptr i32, i32* %r3, i32 9
%r65 = load i32, i32* %r64
%r66 = call i448 @mulUnit_inner416(i32* %r2, i32 %r65)
%r67 = add i448 %r63, %r66
%r68 = trunc i448 %r67 to i32
%r69 = getelementptr i32, i32* %r1, i32 9
store i32 %r68, i32* %r69
%r70 = lshr i448 %r67, 32
%r71 = getelementptr i32, i32* %r3, i32 10
%r72 = load i32, i32* %r71
%r73 = call i448 @mulUnit_inner416(i32* %r2, i32 %r72)
%r74 = add i448 %r70, %r73
%r75 = trunc i448 %r74 to i32
%r76 = getelementptr i32, i32* %r1, i32 10
store i32 %r75, i32* %r76
%r77 = lshr i448 %r74, 32
%r78 = getelementptr i32, i32* %r3, i32 11
%r79 = load i32, i32* %r78
%r80 = call i448 @mulUnit_inner416(i32* %r2, i32 %r79)
%r81 = add i448 %r77, %r80
%r82 = trunc i448 %r81 to i32
%r83 = getelementptr i32, i32* %r1, i32 11
store i32 %r82, i32* %r83
%r84 = lshr i448 %r81, 32
%r85 = getelementptr i32, i32* %r3, i32 12
%r86 = load i32, i32* %r85
%r87 = call i448 @mulUnit_inner416(i32* %r2, i32 %r86)
%r88 = add i448 %r84, %r87
%r89 = getelementptr i32, i32* %r1, i32 12
%r90 = bitcast i32* %r89 to i448*
store i448 %r88, i448* %r90
ret void
}
define void @mclb_sqr13(i32* noalias %r1, i32* noalias %r2)
{
%r3 = load i32, i32* %r2
%r4 = call i64 @mul32x32L(i32 %r3, i32 %r3)
%r5 = trunc i64 %r4 to i32
store i32 %r5, i32* %r1
%r6 = lshr i64 %r4, 32
%r7 = getelementptr i32, i32* %r2, i32 12
%r8 = load i32, i32* %r7
%r9 = call i64 @mul32x32L(i32 %r3, i32 %r8)
%r10 = load i32, i32* %r2
%r11 = getelementptr i32, i32* %r2, i32 11
%r12 = load i32, i32* %r11
%r13 = call i64 @mul32x32L(i32 %r10, i32 %r12)
%r14 = getelementptr i32, i32* %r2, i32 1
%r15 = load i32, i32* %r14
%r16 = getelementptr i32, i32* %r2, i32 12
%r17 = load i32, i32* %r16
%r18 = call i64 @mul32x32L(i32 %r15, i32 %r17)
%r19 = zext i64 %r13 to i128
%r20 = zext i64 %r18 to i128
%r21 = shl i128 %r20, 64
%r22 = or i128 %r19, %r21
%r23 = zext i64 %r9 to i128
%r24 = shl i128 %r23, 32
%r25 = add i128 %r24, %r22
%r26 = load i32, i32* %r2
%r27 = getelementptr i32, i32* %r2, i32 10
%r28 = load i32, i32* %r27
%r29 = call i64 @mul32x32L(i32 %r26, i32 %r28)
%r30 = getelementptr i32, i32* %r2, i32 1
%r31 = load i32, i32* %r30
%r32 = getelementptr i32, i32* %r2, i32 11
%r33 = load i32, i32* %r32
%r34 = call i64 @mul32x32L(i32 %r31, i32 %r33)
%r35 = zext i64 %r29 to i128
%r36 = zext i64 %r34 to i128
%r37 = shl i128 %r36, 64
%r38 = or i128 %r35, %r37
%r39 = getelementptr i32, i32* %r2, i32 2
%r40 = load i32, i32* %r39
%r41 = getelementptr i32, i32* %r2, i32 12
%r42 = load i32, i32* %r41
%r43 = call i64 @mul32x32L(i32 %r40, i32 %r42)
%r44 = zext i128 %r38 to i192
%r45 = zext i64 %r43 to i192
%r46 = shl i192 %r45, 128
%r47 = or i192 %r44, %r46
%r48 = zext i128 %r25 to i192
%r49 = shl i192 %r48, 32
%r50 = add i192 %r49, %r47
%r51 = load i32, i32* %r2
%r52 = getelementptr i32, i32* %r2, i32 9
%r53 = load i32, i32* %r52
%r54 = call i64 @mul32x32L(i32 %r51, i32 %r53)
%r55 = getelementptr i32, i32* %r2, i32 1
%r56 = load i32, i32* %r55
%r57 = getelementptr i32, i32* %r2, i32 10
%r58 = load i32, i32* %r57
%r59 = call i64 @mul32x32L(i32 %r56, i32 %r58)
%r60 = zext i64 %r54 to i128
%r61 = zext i64 %r59 to i128
%r62 = shl i128 %r61, 64
%r63 = or i128 %r60, %r62
%r64 = getelementptr i32, i32* %r2, i32 2
%r65 = load i32, i32* %r64
%r66 = getelementptr i32, i32* %r2, i32 11
%r67 = load i32, i32* %r66
%r68 = call i64 @mul32x32L(i32 %r65, i32 %r67)
%r69 = zext i128 %r63 to i192
%r70 = zext i64 %r68 to i192
%r71 = shl i192 %r70, 128
%r72 = or i192 %r69, %r71
%r73 = getelementptr i32, i32* %r2, i32 3
%r74 = load i32, i32* %r73
%r75 = getelementptr i32, i32* %r2, i32 12
%r76 = load i32, i32* %r75
%r77 = call i64 @mul32x32L(i32 %r74, i32 %r76)
%r78 = zext i192 %r72 to i256
%r79 = zext i64 %r77 to i256
%r80 = shl i256 %r79, 192
%r81 = or i256 %r78, %r80
%r82 = zext i192 %r50 to i256
%r83 = shl i256 %r82, 32
%r84 = add i256 %r83, %r81
%r85 = load i32, i32* %r2
%r86 = getelementptr i32, i32* %r2, i32 8
%r87 = load i32, i32* %r86
%r88 = call i64 @mul32x32L(i32 %r85, i32 %r87)
%r89 = getelementptr i32, i32* %r2, i32 1
%r90 = load i32, i32* %r89
%r91 = getelementptr i32, i32* %r2, i32 9
%r92 = load i32, i32* %r91
%r93 = call i64 @mul32x32L(i32 %r90, i32 %r92)
%r94 = zext i64 %r88 to i128
%r95 = zext i64 %r93 to i128
%r96 = shl i128 %r95, 64
%r97 = or i128 %r94, %r96
%r98 = getelementptr i32, i32* %r2, i32 2
%r99 = load i32, i32* %r98
%r100 = getelementptr i32, i32* %r2, i32 10
%r101 = load i32, i32* %r100
%r102 = call i64 @mul32x32L(i32 %r99, i32 %r101)
%r103 = zext i128 %r97 to i192
%r104 = zext i64 %r102 to i192
%r105 = shl i192 %r104, 128
%r106 = or i192 %r103, %r105
%r107 = getelementptr i32, i32* %r2, i32 3
%r108 = load i32, i32* %r107
%r109 = getelementptr i32, i32* %r2, i32 11
%r110 = load i32, i32* %r109
%r111 = call i64 @mul32x32L(i32 %r108, i32 %r110)
%r112 = zext i192 %r106 to i256
%r113 = zext i64 %r111 to i256
%r114 = shl i256 %r113, 192
%r115 = or i256 %r112, %r114
%r116 = getelementptr i32, i32* %r2, i32 4
%r117 = load i32, i32* %r116
%r118 = getelementptr i32, i32* %r2, i32 12
%r119 = load i32, i32* %r118
%r120 = call i64 @mul32x32L(i32 %r117, i32 %r119)
%r121 = zext i256 %r115 to i320
%r122 = zext i64 %r120 to i320
%r123 = shl i320 %r122, 256
%r124 = or i320 %r121, %r123
%r125 = zext i256 %r84 to i320
%r126 = shl i320 %r125, 32
%r127 = add i320 %r126, %r124
%r128 = load i32, i32* %r2
%r129 = getelementptr i32, i32* %r2, i32 7
%r130 = load i32, i32* %r129
%r131 = call i64 @mul32x32L(i32 %r128, i32 %r130)
%r132 = getelementptr i32, i32* %r2, i32 1
%r133 = load i32, i32* %r132
%r134 = getelementptr i32, i32* %r2, i32 8
%r135 = load i32, i32* %r134
%r136 = call i64 @mul32x32L(i32 %r133, i32 %r135)
%r137 = zext i64 %r131 to i128
%r138 = zext i64 %r136 to i128
%r139 = shl i128 %r138, 64
%r140 = or i128 %r137, %r139
%r141 = getelementptr i32, i32* %r2, i32 2
%r142 = load i32, i32* %r141
%r143 = getelementptr i32, i32* %r2, i32 9
%r144 = load i32, i32* %r143
%r145 = call i64 @mul32x32L(i32 %r142, i32 %r144)
%r146 = zext i128 %r140 to i192
%r147 = zext i64 %r145 to i192
%r148 = shl i192 %r147, 128
%r149 = or i192 %r146, %r148
%r150 = getelementptr i32, i32* %r2, i32 3
%r151 = load i32, i32* %r150
%r152 = getelementptr i32, i32* %r2, i32 10
%r153 = load i32, i32* %r152
%r154 = call i64 @mul32x32L(i32 %r151, i32 %r153)
%r155 = zext i192 %r149 to i256
%r156 = zext i64 %r154 to i256
%r157 = shl i256 %r156, 192
%r158 = or i256 %r155, %r157
%r159 = getelementptr i32, i32* %r2, i32 4
%r160 = load i32, i32* %r159
%r161 = getelementptr i32, i32* %r2, i32 11
%r162 = load i32, i32* %r161
%r163 = call i64 @mul32x32L(i32 %r160, i32 %r162)
%r164 = zext i256 %r158 to i320
%r165 = zext i64 %r163 to i320
%r166 = shl i320 %r165, 256
%r167 = or i320 %r164, %r166
%r168 = getelementptr i32, i32* %r2, i32 5
%r169 = load i32, i32* %r168
%r170 = getelementptr i32, i32* %r2, i32 12
%r171 = load i32, i32* %r170
%r172 = call i64 @mul32x32L(i32 %r169, i32 %r171)
%r173 = zext i320 %r167 to i384
%r174 = zext i64 %r172 to i384
%r175 = shl i384 %r174, 320
%r176 = or i384 %r173, %r175
%r177 = zext i320 %r127 to i384
%r178 = shl i384 %r177, 32
%r179 = add i384 %r178, %r176
%r180 = load i32, i32* %r2
%r181 = getelementptr i32, i32* %r2, i32 6
%r182 = load i32, i32* %r181
%r183 = call i64 @mul32x32L(i32 %r180, i32 %r182)
%r184 = getelementptr i32, i32* %r2, i32 1
%r185 = load i32, i32* %r184
%r186 = getelementptr i32, i32* %r2, i32 7
%r187 = load i32, i32* %r186
%r188 = call i64 @mul32x32L(i32 %r185, i32 %r187)
%r189 = zext i64 %r183 to i128
%r190 = zext i64 %r188 to i128
%r191 = shl i128 %r190, 64
%r192 = or i128 %r189, %r191
%r193 = getelementptr i32, i32* %r2, i32 2
%r194 = load i32, i32* %r193
%r195 = getelementptr i32, i32* %r2, i32 8
%r196 = load i32, i32* %r195
%r197 = call i64 @mul32x32L(i32 %r194, i32 %r196)
%r198 = zext i128 %r192 to i192
%r199 = zext i64 %r197 to i192
%r200 = shl i192 %r199, 128
%r201 = or i192 %r198, %r200
%r202 = getelementptr i32, i32* %r2, i32 3
%r203 = load i32, i32* %r202
%r204 = getelementptr i32, i32* %r2, i32 9
%r205 = load i32, i32* %r204
%r206 = call i64 @mul32x32L(i32 %r203, i32 %r205)
%r207 = zext i192 %r201 to i256
%r208 = zext i64 %r206 to i256
%r209 = shl i256 %r208, 192
%r210 = or i256 %r207, %r209
%r211 = getelementptr i32, i32* %r2, i32 4
%r212 = load i32, i32* %r211
%r213 = getelementptr i32, i32* %r2, i32 10
%r214 = load i32, i32* %r213
%r215 = call i64 @mul32x32L(i32 %r212, i32 %r214)
%r216 = zext i256 %r210 to i320
%r217 = zext i64 %r215 to i320
%r218 = shl i320 %r217, 256
%r219 = or i320 %r216, %r218
%r220 = getelementptr i32, i32* %r2, i32 5
%r221 = load i32, i32* %r220
%r222 = getelementptr i32, i32* %r2, i32 11
%r223 = load i32, i32* %r222
%r224 = call i64 @mul32x32L(i32 %r221, i32 %r223)
%r225 = zext i320 %r219 to i384
%r226 = zext i64 %r224 to i384
%r227 = shl i384 %r226, 320
%r228 = or i384 %r225, %r227
%r229 = getelementptr i32, i32* %r2, i32 6
%r230 = load i32, i32* %r229
%r231 = getelementptr i32, i32* %r2, i32 12
%r232 = load i32, i32* %r231
%r233 = call i64 @mul32x32L(i32 %r230, i32 %r232)
%r234 = zext i384 %r228 to i448
%r235 = zext i64 %r233 to i448
%r236 = shl i448 %r235, 384
%r237 = or i448 %r234, %r236
%r238 = zext i384 %r179 to i448
%r239 = shl i448 %r238, 32
%r240 = add i448 %r239, %r237
%r241 = load i32, i32* %r2
%r242 = getelementptr i32, i32* %r2, i32 5
%r243 = load i32, i32* %r242
%r244 = call i64 @mul32x32L(i32 %r241, i32 %r243)
%r245 = getelementptr i32, i32* %r2, i32 1
%r246 = load i32, i32* %r245
%r247 = getelementptr i32, i32* %r2, i32 6
%r248 = load i32, i32* %r247
%r249 = call i64 @mul32x32L(i32 %r246, i32 %r248)
%r250 = zext i64 %r244 to i128
%r251 = zext i64 %r249 to i128
%r252 = shl i128 %r251, 64
%r253 = or i128 %r250, %r252
%r254 = getelementptr i32, i32* %r2, i32 2
%r255 = load i32, i32* %r254
%r256 = getelementptr i32, i32* %r2, i32 7
%r257 = load i32, i32* %r256
%r258 = call i64 @mul32x32L(i32 %r255, i32 %r257)
%r259 = zext i128 %r253 to i192
%r260 = zext i64 %r258 to i192
%r261 = shl i192 %r260, 128
%r262 = or i192 %r259, %r261
%r263 = getelementptr i32, i32* %r2, i32 3
%r264 = load i32, i32* %r263
%r265 = getelementptr i32, i32* %r2, i32 8
%r266 = load i32, i32* %r265
%r267 = call i64 @mul32x32L(i32 %r264, i32 %r266)
%r268 = zext i192 %r262 to i256
%r269 = zext i64 %r267 to i256
%r270 = shl i256 %r269, 192
%r271 = or i256 %r268, %r270
%r272 = getelementptr i32, i32* %r2, i32 4
%r273 = load i32, i32* %r272
%r274 = getelementptr i32, i32* %r2, i32 9
%r275 = load i32, i32* %r274
%r276 = call i64 @mul32x32L(i32 %r273, i32 %r275)
%r277 = zext i256 %r271 to i320
%r278 = zext i64 %r276 to i320
%r279 = shl i320 %r278, 256
%r280 = or i320 %r277, %r279
%r281 = getelementptr i32, i32* %r2, i32 5
%r282 = load i32, i32* %r281
%r283 = getelementptr i32, i32* %r2, i32 10
%r284 = load i32, i32* %r283
%r285 = call i64 @mul32x32L(i32 %r282, i32 %r284)
%r286 = zext i320 %r280 to i384
%r287 = zext i64 %r285 to i384
%r288 = shl i384 %r287, 320
%r289 = or i384 %r286, %r288
%r290 = getelementptr i32, i32* %r2, i32 6
%r291 = load i32, i32* %r290
%r292 = getelementptr i32, i32* %r2, i32 11
%r293 = load i32, i32* %r292
%r294 = call i64 @mul32x32L(i32 %r291, i32 %r293)
%r295 = zext i384 %r289 to i448
%r296 = zext i64 %r294 to i448
%r297 = shl i448 %r296, 384
%r298 = or i448 %r295, %r297
%r299 = getelementptr i32, i32* %r2, i32 7
%r300 = load i32, i32* %r299
%r301 = getelementptr i32, i32* %r2, i32 12
%r302 = load i32, i32* %r301
%r303 = call i64 @mul32x32L(i32 %r300, i32 %r302)
%r304 = zext i448 %r298 to i512
%r305 = zext i64 %r303 to i512
%r306 = shl i512 %r305, 448
%r307 = or i512 %r304, %r306
%r308 = zext i448 %r240 to i512
%r309 = shl i512 %r308, 32
%r310 = add i512 %r309, %r307
%r311 = load i32, i32* %r2
%r312 = getelementptr i32, i32* %r2, i32 4
%r313 = load i32, i32* %r312
%r314 = call i64 @mul32x32L(i32 %r311, i32 %r313)
%r315 = getelementptr i32, i32* %r2, i32 1
%r316 = load i32, i32* %r315
%r317 = getelementptr i32, i32* %r2, i32 5
%r318 = load i32, i32* %r317
%r319 = call i64 @mul32x32L(i32 %r316, i32 %r318)
%r320 = zext i64 %r314 to i128
%r321 = zext i64 %r319 to i128
%r322 = shl i128 %r321, 64
%r323 = or i128 %r320, %r322
%r324 = getelementptr i32, i32* %r2, i32 2
%r325 = load i32, i32* %r324
%r326 = getelementptr i32, i32* %r2, i32 6
%r327 = load i32, i32* %r326
%r328 = call i64 @mul32x32L(i32 %r325, i32 %r327)
%r329 = zext i128 %r323 to i192
%r330 = zext i64 %r328 to i192
%r331 = shl i192 %r330, 128
%r332 = or i192 %r329, %r331
%r333 = getelementptr i32, i32* %r2, i32 3
%r334 = load i32, i32* %r333
%r335 = getelementptr i32, i32* %r2, i32 7
%r336 = load i32, i32* %r335
%r337 = call i64 @mul32x32L(i32 %r334, i32 %r336)
%r338 = zext i192 %r332 to i256
%r339 = zext i64 %r337 to i256
%r340 = shl i256 %r339, 192
%r341 = or i256 %r338, %r340
%r342 = getelementptr i32, i32* %r2, i32 4
%r343 = load i32, i32* %r342
%r344 = getelementptr i32, i32* %r2, i32 8
%r345 = load i32, i32* %r344
%r346 = call i64 @mul32x32L(i32 %r343, i32 %r345)
%r347 = zext i256 %r341 to i320
%r348 = zext i64 %r346 to i320
%r349 = shl i320 %r348, 256
%r350 = or i320 %r347, %r349
%r351 = getelementptr i32, i32* %r2, i32 5
%r352 = load i32, i32* %r351
%r353 = getelementptr i32, i32* %r2, i32 9
%r354 = load i32, i32* %r353
%r355 = call i64 @mul32x32L(i32 %r352, i32 %r354)
%r356 = zext i320 %r350 to i384
%r357 = zext i64 %r355 to i384
%r358 = shl i384 %r357, 320
%r359 = or i384 %r356, %r358
%r360 = getelementptr i32, i32* %r2, i32 6
%r361 = load i32, i32* %r360
%r362 = getelementptr i32, i32* %r2, i32 10
%r363 = load i32, i32* %r362
%r364 = call i64 @mul32x32L(i32 %r361, i32 %r363)
%r365 = zext i384 %r359 to i448
%r366 = zext i64 %r364 to i448
%r367 = shl i448 %r366, 384
%r368 = or i448 %r365, %r367
%r369 = getelementptr i32, i32* %r2, i32 7
%r370 = load i32, i32* %r369
%r371 = getelementptr i32, i32* %r2, i32 11
%r372 = load i32, i32* %r371
%r373 = call i64 @mul32x32L(i32 %r370, i32 %r372)
%r374 = zext i448 %r368 to i512
%r375 = zext i64 %r373 to i512
%r376 = shl i512 %r375, 448
%r377 = or i512 %r374, %r376
%r378 = getelementptr i32, i32* %r2, i32 8
%r379 = load i32, i32* %r378
%r380 = getelementptr i32, i32* %r2, i32 12
%r381 = load i32, i32* %r380
%r382 = call i64 @mul32x32L(i32 %r379, i32 %r381)
%r383 = zext i512 %r377 to i576
%r384 = zext i64 %r382 to i576
%r385 = shl i576 %r384, 512
%r386 = or i576 %r383, %r385
%r387 = zext i512 %r310 to i576
%r388 = shl i576 %r387, 32
%r389 = add i576 %r388, %r386
%r390 = load i32, i32* %r2
%r391 = getelementptr i32, i32* %r2, i32 3
%r392 = load i32, i32* %r391
%r393 = call i64 @mul32x32L(i32 %r390, i32 %r392)
%r394 = getelementptr i32, i32* %r2, i32 1
%r395 = load i32, i32* %r394
%r396 = getelementptr i32, i32* %r2, i32 4
%r397 = load i32, i32* %r396
%r398 = call i64 @mul32x32L(i32 %r395, i32 %r397)
%r399 = zext i64 %r393 to i128
%r400 = zext i64 %r398 to i128
%r401 = shl i128 %r400, 64
%r402 = or i128 %r399, %r401
%r403 = getelementptr i32, i32* %r2, i32 2
%r404 = load i32, i32* %r403
%r405 = getelementptr i32, i32* %r2, i32 5
%r406 = load i32, i32* %r405
%r407 = call i64 @mul32x32L(i32 %r404, i32 %r406)
%r408 = zext i128 %r402 to i192
%r409 = zext i64 %r407 to i192
%r410 = shl i192 %r409, 128
%r411 = or i192 %r408, %r410
%r412 = getelementptr i32, i32* %r2, i32 3
%r413 = load i32, i32* %r412
%r414 = getelementptr i32, i32* %r2, i32 6
%r415 = load i32, i32* %r414
%r416 = call i64 @mul32x32L(i32 %r413, i32 %r415)
%r417 = zext i192 %r411 to i256
%r418 = zext i64 %r416 to i256
%r419 = shl i256 %r418, 192
%r420 = or i256 %r417, %r419
%r421 = getelementptr i32, i32* %r2, i32 4
%r422 = load i32, i32* %r421
%r423 = getelementptr i32, i32* %r2, i32 7
%r424 = load i32, i32* %r423
%r425 = call i64 @mul32x32L(i32 %r422, i32 %r424)
%r426 = zext i256 %r420 to i320
%r427 = zext i64 %r425 to i320
%r428 = shl i320 %r427, 256
%r429 = or i320 %r426, %r428
%r430 = getelementptr i32, i32* %r2, i32 5
%r431 = load i32, i32* %r430
%r432 = getelementptr i32, i32* %r2, i32 8
%r433 = load i32, i32* %r432
%r434 = call i64 @mul32x32L(i32 %r431, i32 %r433)
%r435 = zext i320 %r429 to i384
%r436 = zext i64 %r434 to i384
%r437 = shl i384 %r436, 320
%r438 = or i384 %r435, %r437
%r439 = getelementptr i32, i32* %r2, i32 6
%r440 = load i32, i32* %r439
%r441 = getelementptr i32, i32* %r2, i32 9
%r442 = load i32, i32* %r441
%r443 = call i64 @mul32x32L(i32 %r440, i32 %r442)
%r444 = zext i384 %r438 to i448
%r445 = zext i64 %r443 to i448
%r446 = shl i448 %r445, 384
%r447 = or i448 %r444, %r446
%r448 = getelementptr i32, i32* %r2, i32 7
%r449 = load i32, i32* %r448
%r450 = getelementptr i32, i32* %r2, i32 10
%r451 = load i32, i32* %r450
%r452 = call i64 @mul32x32L(i32 %r449, i32 %r451)
%r453 = zext i448 %r447 to i512
%r454 = zext i64 %r452 to i512
%r455 = shl i512 %r454, 448
%r456 = or i512 %r453, %r455
%r457 = getelementptr i32, i32* %r2, i32 8
%r458 = load i32, i32* %r457
%r459 = getelementptr i32, i32* %r2, i32 11
%r460 = load i32, i32* %r459
%r461 = call i64 @mul32x32L(i32 %r458, i32 %r460)
%r462 = zext i512 %r456 to i576
%r463 = zext i64 %r461 to i576
%r464 = shl i576 %r463, 512
%r465 = or i576 %r462, %r464
%r466 = getelementptr i32, i32* %r2, i32 9
%r467 = load i32, i32* %r466
%r468 = getelementptr i32, i32* %r2, i32 12
%r469 = load i32, i32* %r468
%r470 = call i64 @mul32x32L(i32 %r467, i32 %r469)
%r471 = zext i576 %r465 to i640
%r472 = zext i64 %r470 to i640
%r473 = shl i640 %r472, 576
%r474 = or i640 %r471, %r473
%r475 = zext i576 %r389 to i640
%r476 = shl i640 %r475, 32
%r477 = add i640 %r476, %r474
%r478 = load i32, i32* %r2
%r479 = getelementptr i32, i32* %r2, i32 2
%r480 = load i32, i32* %r479
%r481 = call i64 @mul32x32L(i32 %r478, i32 %r480)
%r482 = getelementptr i32, i32* %r2, i32 1
%r483 = load i32, i32* %r482
%r484 = getelementptr i32, i32* %r2, i32 3
%r485 = load i32, i32* %r484
%r486 = call i64 @mul32x32L(i32 %r483, i32 %r485)
%r487 = zext i64 %r481 to i128
%r488 = zext i64 %r486 to i128
%r489 = shl i128 %r488, 64
%r490 = or i128 %r487, %r489
%r491 = getelementptr i32, i32* %r2, i32 2
%r492 = load i32, i32* %r491
%r493 = getelementptr i32, i32* %r2, i32 4
%r494 = load i32, i32* %r493
%r495 = call i64 @mul32x32L(i32 %r492, i32 %r494)
%r496 = zext i128 %r490 to i192
%r497 = zext i64 %r495 to i192
%r498 = shl i192 %r497, 128
%r499 = or i192 %r496, %r498
%r500 = getelementptr i32, i32* %r2, i32 3
%r501 = load i32, i32* %r500
%r502 = getelementptr i32, i32* %r2, i32 5
%r503 = load i32, i32* %r502
%r504 = call i64 @mul32x32L(i32 %r501, i32 %r503)
%r505 = zext i192 %r499 to i256
%r506 = zext i64 %r504 to i256
%r507 = shl i256 %r506, 192
%r508 = or i256 %r505, %r507
%r509 = getelementptr i32, i32* %r2, i32 4
%r510 = load i32, i32* %r509
%r511 = getelementptr i32, i32* %r2, i32 6
%r512 = load i32, i32* %r511
%r513 = call i64 @mul32x32L(i32 %r510, i32 %r512)
%r514 = zext i256 %r508 to i320
%r515 = zext i64 %r513 to i320
%r516 = shl i320 %r515, 256
%r517 = or i320 %r514, %r516
%r518 = getelementptr i32, i32* %r2, i32 5
%r519 = load i32, i32* %r518
%r520 = getelementptr i32, i32* %r2, i32 7
%r521 = load i32, i32* %r520
%r522 = call i64 @mul32x32L(i32 %r519, i32 %r521)
%r523 = zext i320 %r517 to i384
%r524 = zext i64 %r522 to i384
%r525 = shl i384 %r524, 320
%r526 = or i384 %r523, %r525
%r527 = getelementptr i32, i32* %r2, i32 6
%r528 = load i32, i32* %r527
%r529 = getelementptr i32, i32* %r2, i32 8
%r530 = load i32, i32* %r529
%r531 = call i64 @mul32x32L(i32 %r528, i32 %r530)
%r532 = zext i384 %r526 to i448
%r533 = zext i64 %r531 to i448
%r534 = shl i448 %r533, 384
%r535 = or i448 %r532, %r534
%r536 = getelementptr i32, i32* %r2, i32 7
%r537 = load i32, i32* %r536
%r538 = getelementptr i32, i32* %r2, i32 9
%r539 = load i32, i32* %r538
%r540 = call i64 @mul32x32L(i32 %r537, i32 %r539)
%r541 = zext i448 %r535 to i512
%r542 = zext i64 %r540 to i512
%r543 = shl i512 %r542, 448
%r544 = or i512 %r541, %r543
%r545 = getelementptr i32, i32* %r2, i32 8
%r546 = load i32, i32* %r545
%r547 = getelementptr i32, i32* %r2, i32 10
%r548 = load i32, i32* %r547
%r549 = call i64 @mul32x32L(i32 %r546, i32 %r548)
%r550 = zext i512 %r544 to i576
%r551 = zext i64 %r549 to i576
%r552 = shl i576 %r551, 512
%r553 = or i576 %r550, %r552
%r554 = getelementptr i32, i32* %r2, i32 9
%r555 = load i32, i32* %r554
%r556 = getelementptr i32, i32* %r2, i32 11
%r557 = load i32, i32* %r556
%r558 = call i64 @mul32x32L(i32 %r555, i32 %r557)
%r559 = zext i576 %r553 to i640
%r560 = zext i64 %r558 to i640
%r561 = shl i640 %r560, 576
%r562 = or i640 %r559, %r561
%r563 = getelementptr i32, i32* %r2, i32 10
%r564 = load i32, i32* %r563
%r565 = getelementptr i32, i32* %r2, i32 12
%r566 = load i32, i32* %r565
%r567 = call i64 @mul32x32L(i32 %r564, i32 %r566)
%r568 = zext i640 %r562 to i704
%r569 = zext i64 %r567 to i704
%r570 = shl i704 %r569, 640
%r571 = or i704 %r568, %r570
%r572 = zext i640 %r477 to i704
%r573 = shl i704 %r572, 32
%r574 = add i704 %r573, %r571
%r575 = load i32, i32* %r2
%r576 = getelementptr i32, i32* %r2, i32 1
%r577 = load i32, i32* %r576
%r578 = call i64 @mul32x32L(i32 %r575, i32 %r577)
%r579 = getelementptr i32, i32* %r2, i32 1
%r580 = load i32, i32* %r579
%r581 = getelementptr i32, i32* %r2, i32 2
%r582 = load i32, i32* %r581
%r583 = call i64 @mul32x32L(i32 %r580, i32 %r582)
%r584 = zext i64 %r578 to i128
%r585 = zext i64 %r583 to i128
%r586 = shl i128 %r585, 64
%r587 = or i128 %r584, %r586
%r588 = getelementptr i32, i32* %r2, i32 2
%r589 = load i32, i32* %r588
%r590 = getelementptr i32, i32* %r2, i32 3
%r591 = load i32, i32* %r590
%r592 = call i64 @mul32x32L(i32 %r589, i32 %r591)
%r593 = zext i128 %r587 to i192
%r594 = zext i64 %r592 to i192
%r595 = shl i192 %r594, 128
%r596 = or i192 %r593, %r595
%r597 = getelementptr i32, i32* %r2, i32 3
%r598 = load i32, i32* %r597
%r599 = getelementptr i32, i32* %r2, i32 4
%r600 = load i32, i32* %r599
%r601 = call i64 @mul32x32L(i32 %r598, i32 %r600)
%r602 = zext i192 %r596 to i256
%r603 = zext i64 %r601 to i256
%r604 = shl i256 %r603, 192
%r605 = or i256 %r602, %r604
%r606 = getelementptr i32, i32* %r2, i32 4
%r607 = load i32, i32* %r606
%r608 = getelementptr i32, i32* %r2, i32 5
%r609 = load i32, i32* %r608
%r610 = call i64 @mul32x32L(i32 %r607, i32 %r609)
%r611 = zext i256 %r605 to i320
%r612 = zext i64 %r610 to i320
%r613 = shl i320 %r612, 256
%r614 = or i320 %r611, %r613
%r615 = getelementptr i32, i32* %r2, i32 5
%r616 = load i32, i32* %r615
%r617 = getelementptr i32, i32* %r2, i32 6
%r618 = load i32, i32* %r617
%r619 = call i64 @mul32x32L(i32 %r616, i32 %r618)
%r620 = zext i320 %r614 to i384
%r621 = zext i64 %r619 to i384
%r622 = shl i384 %r621, 320
%r623 = or i384 %r620, %r622
%r624 = getelementptr i32, i32* %r2, i32 6
%r625 = load i32, i32* %r624
%r626 = getelementptr i32, i32* %r2, i32 7
%r627 = load i32, i32* %r626
%r628 = call i64 @mul32x32L(i32 %r625, i32 %r627)
%r629 = zext i384 %r623 to i448
%r630 = zext i64 %r628 to i448
%r631 = shl i448 %r630, 384
%r632 = or i448 %r629, %r631
%r633 = getelementptr i32, i32* %r2, i32 7
%r634 = load i32, i32* %r633
%r635 = getelementptr i32, i32* %r2, i32 8
%r636 = load i32, i32* %r635
%r637 = call i64 @mul32x32L(i32 %r634, i32 %r636)
%r638 = zext i448 %r632 to i512
%r639 = zext i64 %r637 to i512
%r640 = shl i512 %r639, 448
%r641 = or i512 %r638, %r640
%r642 = getelementptr i32, i32* %r2, i32 8
%r643 = load i32, i32* %r642
%r644 = getelementptr i32, i32* %r2, i32 9
%r645 = load i32, i32* %r644
%r646 = call i64 @mul32x32L(i32 %r643, i32 %r645)
%r647 = zext i512 %r641 to i576
%r648 = zext i64 %r646 to i576
%r649 = shl i576 %r648, 512
%r650 = or i576 %r647, %r649
%r651 = getelementptr i32, i32* %r2, i32 9
%r652 = load i32, i32* %r651
%r653 = getelementptr i32, i32* %r2, i32 10
%r654 = load i32, i32* %r653
%r655 = call i64 @mul32x32L(i32 %r652, i32 %r654)
%r656 = zext i576 %r650 to i640
%r657 = zext i64 %r655 to i640
%r658 = shl i640 %r657, 576
%r659 = or i640 %r656, %r658
%r660 = getelementptr i32, i32* %r2, i32 10
%r661 = load i32, i32* %r660
%r662 = getelementptr i32, i32* %r2, i32 11
%r663 = load i32, i32* %r662
%r664 = call i64 @mul32x32L(i32 %r661, i32 %r663)
%r665 = zext i640 %r659 to i704
%r666 = zext i64 %r664 to i704
%r667 = shl i704 %r666, 640
%r668 = or i704 %r665, %r667
%r669 = getelementptr i32, i32* %r2, i32 11
%r670 = load i32, i32* %r669
%r671 = getelementptr i32, i32* %r2, i32 12
%r672 = load i32, i32* %r671
%r673 = call i64 @mul32x32L(i32 %r670, i32 %r672)
%r674 = zext i704 %r668 to i768
%r675 = zext i64 %r673 to i768
%r676 = shl i768 %r675, 704
%r677 = or i768 %r674, %r676
%r678 = zext i704 %r574 to i768
%r679 = shl i768 %r678, 32
%r680 = add i768 %r679, %r677
%r681 = zext i64 %r6 to i800
%r682 = getelementptr i32, i32* %r2, i32 1
%r683 = load i32, i32* %r682
%r684 = call i64 @mul32x32L(i32 %r683, i32 %r683)
%r685 = zext i64 %r684 to i800
%r686 = shl i800 %r685, 32
%r687 = or i800 %r681, %r686
%r688 = getelementptr i32, i32* %r2, i32 2
%r689 = load i32, i32* %r688
%r690 = call i64 @mul32x32L(i32 %r689, i32 %r689)
%r691 = zext i64 %r690 to i800
%r692 = shl i800 %r691, 96
%r693 = or i800 %r687, %r692
%r694 = getelementptr i32, i32* %r2, i32 3
%r695 = load i32, i32* %r694
%r696 = call i64 @mul32x32L(i32 %r695, i32 %r695)
%r697 = zext i64 %r696 to i800
%r698 = shl i800 %r697, 160
%r699 = or i800 %r693, %r698
%r700 = getelementptr i32, i32* %r2, i32 4
%r701 = load i32, i32* %r700
%r702 = call i64 @mul32x32L(i32 %r701, i32 %r701)
%r703 = zext i64 %r702 to i800
%r704 = shl i800 %r703, 224
%r705 = or i800 %r699, %r704
%r706 = getelementptr i32, i32* %r2, i32 5
%r707 = load i32, i32* %r706
%r708 = call i64 @mul32x32L(i32 %r707, i32 %r707)
%r709 = zext i64 %r708 to i800
%r710 = shl i800 %r709, 288
%r711 = or i800 %r705, %r710
%r712 = getelementptr i32, i32* %r2, i32 6
%r713 = load i32, i32* %r712
%r714 = call i64 @mul32x32L(i32 %r713, i32 %r713)
%r715 = zext i64 %r714 to i800
%r716 = shl i800 %r715, 352
%r717 = or i800 %r711, %r716
%r718 = getelementptr i32, i32* %r2, i32 7
%r719 = load i32, i32* %r718
%r720 = call i64 @mul32x32L(i32 %r719, i32 %r719)
%r721 = zext i64 %r720 to i800
%r722 = shl i800 %r721, 416
%r723 = or i800 %r717, %r722
%r724 = getelementptr i32, i32* %r2, i32 8
%r725 = load i32, i32* %r724
%r726 = call i64 @mul32x32L(i32 %r725, i32 %r725)
%r727 = zext i64 %r726 to i800
%r728 = shl i800 %r727, 480
%r729 = or i800 %r723, %r728
%r730 = getelementptr i32, i32* %r2, i32 9
%r731 = load i32, i32* %r730
%r732 = call i64 @mul32x32L(i32 %r731, i32 %r731)
%r733 = zext i64 %r732 to i800
%r734 = shl i800 %r733, 544
%r735 = or i800 %r729, %r734
%r736 = getelementptr i32, i32* %r2, i32 10
%r737 = load i32, i32* %r736
%r738 = call i64 @mul32x32L(i32 %r737, i32 %r737)
%r739 = zext i64 %r738 to i800
%r740 = shl i800 %r739, 608
%r741 = or i800 %r735, %r740
%r742 = getelementptr i32, i32* %r2, i32 11
%r743 = load i32, i32* %r742
%r744 = call i64 @mul32x32L(i32 %r743, i32 %r743)
%r745 = zext i64 %r744 to i800
%r746 = shl i800 %r745, 672
%r747 = or i800 %r741, %r746
%r748 = getelementptr i32, i32* %r2, i32 12
%r749 = load i32, i32* %r748
%r750 = call i64 @mul32x32L(i32 %r749, i32 %r749)
%r751 = zext i64 %r750 to i800
%r752 = shl i800 %r751, 736
%r753 = or i800 %r747, %r752
%r754 = zext i768 %r680 to i800
%r755 = add i800 %r754, %r754
%r756 = add i800 %r753, %r755
%r757 = getelementptr i32, i32* %r1, i32 1
%r758 = bitcast i32* %r757 to i800*
store i800 %r756, i800* %r758
ret void
}
define i480 @mulUnit_inner448(i32* noalias %r2, i32 %r3)
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
%r46 = zext i32 %r5 to i64
%r47 = zext i32 %r8 to i64
%r48 = shl i64 %r47, 32
%r49 = or i64 %r46, %r48
%r50 = zext i64 %r49 to i96
%r51 = zext i32 %r11 to i96
%r52 = shl i96 %r51, 64
%r53 = or i96 %r50, %r52
%r54 = zext i96 %r53 to i128
%r55 = zext i32 %r14 to i128
%r56 = shl i128 %r55, 96
%r57 = or i128 %r54, %r56
%r58 = zext i128 %r57 to i160
%r59 = zext i32 %r17 to i160
%r60 = shl i160 %r59, 128
%r61 = or i160 %r58, %r60
%r62 = zext i160 %r61 to i192
%r63 = zext i32 %r20 to i192
%r64 = shl i192 %r63, 160
%r65 = or i192 %r62, %r64
%r66 = zext i192 %r65 to i224
%r67 = zext i32 %r23 to i224
%r68 = shl i224 %r67, 192
%r69 = or i224 %r66, %r68
%r70 = zext i224 %r69 to i256
%r71 = zext i32 %r26 to i256
%r72 = shl i256 %r71, 224
%r73 = or i256 %r70, %r72
%r74 = zext i256 %r73 to i288
%r75 = zext i32 %r29 to i288
%r76 = shl i288 %r75, 256
%r77 = or i288 %r74, %r76
%r78 = zext i288 %r77 to i320
%r79 = zext i32 %r32 to i320
%r80 = shl i320 %r79, 288
%r81 = or i320 %r78, %r80
%r82 = zext i320 %r81 to i352
%r83 = zext i32 %r35 to i352
%r84 = shl i352 %r83, 320
%r85 = or i352 %r82, %r84
%r86 = zext i352 %r85 to i384
%r87 = zext i32 %r38 to i384
%r88 = shl i384 %r87, 352
%r89 = or i384 %r86, %r88
%r90 = zext i384 %r89 to i416
%r91 = zext i32 %r41 to i416
%r92 = shl i416 %r91, 384
%r93 = or i416 %r90, %r92
%r94 = zext i416 %r93 to i448
%r95 = zext i32 %r44 to i448
%r96 = shl i448 %r95, 416
%r97 = or i448 %r94, %r96
%r98 = zext i32 %r6 to i64
%r99 = zext i32 %r9 to i64
%r100 = shl i64 %r99, 32
%r101 = or i64 %r98, %r100
%r102 = zext i64 %r101 to i96
%r103 = zext i32 %r12 to i96
%r104 = shl i96 %r103, 64
%r105 = or i96 %r102, %r104
%r106 = zext i96 %r105 to i128
%r107 = zext i32 %r15 to i128
%r108 = shl i128 %r107, 96
%r109 = or i128 %r106, %r108
%r110 = zext i128 %r109 to i160
%r111 = zext i32 %r18 to i160
%r112 = shl i160 %r111, 128
%r113 = or i160 %r110, %r112
%r114 = zext i160 %r113 to i192
%r115 = zext i32 %r21 to i192
%r116 = shl i192 %r115, 160
%r117 = or i192 %r114, %r116
%r118 = zext i192 %r117 to i224
%r119 = zext i32 %r24 to i224
%r120 = shl i224 %r119, 192
%r121 = or i224 %r118, %r120
%r122 = zext i224 %r121 to i256
%r123 = zext i32 %r27 to i256
%r124 = shl i256 %r123, 224
%r125 = or i256 %r122, %r124
%r126 = zext i256 %r125 to i288
%r127 = zext i32 %r30 to i288
%r128 = shl i288 %r127, 256
%r129 = or i288 %r126, %r128
%r130 = zext i288 %r129 to i320
%r131 = zext i32 %r33 to i320
%r132 = shl i320 %r131, 288
%r133 = or i320 %r130, %r132
%r134 = zext i320 %r133 to i352
%r135 = zext i32 %r36 to i352
%r136 = shl i352 %r135, 320
%r137 = or i352 %r134, %r136
%r138 = zext i352 %r137 to i384
%r139 = zext i32 %r39 to i384
%r140 = shl i384 %r139, 352
%r141 = or i384 %r138, %r140
%r142 = zext i384 %r141 to i416
%r143 = zext i32 %r42 to i416
%r144 = shl i416 %r143, 384
%r145 = or i416 %r142, %r144
%r146 = zext i416 %r145 to i448
%r147 = zext i32 %r45 to i448
%r148 = shl i448 %r147, 416
%r149 = or i448 %r146, %r148
%r150 = zext i448 %r97 to i480
%r151 = zext i448 %r149 to i480
%r152 = shl i480 %r151, 32
%r153 = add i480 %r150, %r152
ret i480 %r153
}
define i32 @mclb_mulUnit14(i32* noalias %r1, i32* noalias %r2, i32 %r3)
{
%r5 = call i480 @mulUnit_inner448(i32* %r2, i32 %r3)
%r6 = trunc i480 %r5 to i448
%r7 = bitcast i32* %r1 to i448*
store i448 %r6, i448* %r7
%r8 = lshr i480 %r5, 448
%r9 = trunc i480 %r8 to i32
ret i32 %r9
}
define i32 @mclb_mulUnitAdd14(i32* noalias %r1, i32* noalias %r2, i32 %r3)
{
%r5 = call i64 @mulPos32x32(i32* %r2, i32 %r3, i32 0)
%r6 = trunc i64 %r5 to i32
%r7 = call i32 @extractHigh32(i64 %r5)
%r8 = call i64 @mulPos32x32(i32* %r2, i32 %r3, i32 1)
%r9 = trunc i64 %r8 to i32
%r10 = call i32 @extractHigh32(i64 %r8)
%r11 = call i64 @mulPos32x32(i32* %r2, i32 %r3, i32 2)
%r12 = trunc i64 %r11 to i32
%r13 = call i32 @extractHigh32(i64 %r11)
%r14 = call i64 @mulPos32x32(i32* %r2, i32 %r3, i32 3)
%r15 = trunc i64 %r14 to i32
%r16 = call i32 @extractHigh32(i64 %r14)
%r17 = call i64 @mulPos32x32(i32* %r2, i32 %r3, i32 4)
%r18 = trunc i64 %r17 to i32
%r19 = call i32 @extractHigh32(i64 %r17)
%r20 = call i64 @mulPos32x32(i32* %r2, i32 %r3, i32 5)
%r21 = trunc i64 %r20 to i32
%r22 = call i32 @extractHigh32(i64 %r20)
%r23 = call i64 @mulPos32x32(i32* %r2, i32 %r3, i32 6)
%r24 = trunc i64 %r23 to i32
%r25 = call i32 @extractHigh32(i64 %r23)
%r26 = call i64 @mulPos32x32(i32* %r2, i32 %r3, i32 7)
%r27 = trunc i64 %r26 to i32
%r28 = call i32 @extractHigh32(i64 %r26)
%r29 = call i64 @mulPos32x32(i32* %r2, i32 %r3, i32 8)
%r30 = trunc i64 %r29 to i32
%r31 = call i32 @extractHigh32(i64 %r29)
%r32 = call i64 @mulPos32x32(i32* %r2, i32 %r3, i32 9)
%r33 = trunc i64 %r32 to i32
%r34 = call i32 @extractHigh32(i64 %r32)
%r35 = call i64 @mulPos32x32(i32* %r2, i32 %r3, i32 10)
%r36 = trunc i64 %r35 to i32
%r37 = call i32 @extractHigh32(i64 %r35)
%r38 = call i64 @mulPos32x32(i32* %r2, i32 %r3, i32 11)
%r39 = trunc i64 %r38 to i32
%r40 = call i32 @extractHigh32(i64 %r38)
%r41 = call i64 @mulPos32x32(i32* %r2, i32 %r3, i32 12)
%r42 = trunc i64 %r41 to i32
%r43 = call i32 @extractHigh32(i64 %r41)
%r44 = call i64 @mulPos32x32(i32* %r2, i32 %r3, i32 13)
%r45 = trunc i64 %r44 to i32
%r46 = call i32 @extractHigh32(i64 %r44)
%r47 = zext i32 %r6 to i64
%r48 = zext i32 %r9 to i64
%r49 = shl i64 %r48, 32
%r50 = or i64 %r47, %r49
%r51 = zext i64 %r50 to i96
%r52 = zext i32 %r12 to i96
%r53 = shl i96 %r52, 64
%r54 = or i96 %r51, %r53
%r55 = zext i96 %r54 to i128
%r56 = zext i32 %r15 to i128
%r57 = shl i128 %r56, 96
%r58 = or i128 %r55, %r57
%r59 = zext i128 %r58 to i160
%r60 = zext i32 %r18 to i160
%r61 = shl i160 %r60, 128
%r62 = or i160 %r59, %r61
%r63 = zext i160 %r62 to i192
%r64 = zext i32 %r21 to i192
%r65 = shl i192 %r64, 160
%r66 = or i192 %r63, %r65
%r67 = zext i192 %r66 to i224
%r68 = zext i32 %r24 to i224
%r69 = shl i224 %r68, 192
%r70 = or i224 %r67, %r69
%r71 = zext i224 %r70 to i256
%r72 = zext i32 %r27 to i256
%r73 = shl i256 %r72, 224
%r74 = or i256 %r71, %r73
%r75 = zext i256 %r74 to i288
%r76 = zext i32 %r30 to i288
%r77 = shl i288 %r76, 256
%r78 = or i288 %r75, %r77
%r79 = zext i288 %r78 to i320
%r80 = zext i32 %r33 to i320
%r81 = shl i320 %r80, 288
%r82 = or i320 %r79, %r81
%r83 = zext i320 %r82 to i352
%r84 = zext i32 %r36 to i352
%r85 = shl i352 %r84, 320
%r86 = or i352 %r83, %r85
%r87 = zext i352 %r86 to i384
%r88 = zext i32 %r39 to i384
%r89 = shl i384 %r88, 352
%r90 = or i384 %r87, %r89
%r91 = zext i384 %r90 to i416
%r92 = zext i32 %r42 to i416
%r93 = shl i416 %r92, 384
%r94 = or i416 %r91, %r93
%r95 = zext i416 %r94 to i448
%r96 = zext i32 %r45 to i448
%r97 = shl i448 %r96, 416
%r98 = or i448 %r95, %r97
%r99 = zext i32 %r7 to i64
%r100 = zext i32 %r10 to i64
%r101 = shl i64 %r100, 32
%r102 = or i64 %r99, %r101
%r103 = zext i64 %r102 to i96
%r104 = zext i32 %r13 to i96
%r105 = shl i96 %r104, 64
%r106 = or i96 %r103, %r105
%r107 = zext i96 %r106 to i128
%r108 = zext i32 %r16 to i128
%r109 = shl i128 %r108, 96
%r110 = or i128 %r107, %r109
%r111 = zext i128 %r110 to i160
%r112 = zext i32 %r19 to i160
%r113 = shl i160 %r112, 128
%r114 = or i160 %r111, %r113
%r115 = zext i160 %r114 to i192
%r116 = zext i32 %r22 to i192
%r117 = shl i192 %r116, 160
%r118 = or i192 %r115, %r117
%r119 = zext i192 %r118 to i224
%r120 = zext i32 %r25 to i224
%r121 = shl i224 %r120, 192
%r122 = or i224 %r119, %r121
%r123 = zext i224 %r122 to i256
%r124 = zext i32 %r28 to i256
%r125 = shl i256 %r124, 224
%r126 = or i256 %r123, %r125
%r127 = zext i256 %r126 to i288
%r128 = zext i32 %r31 to i288
%r129 = shl i288 %r128, 256
%r130 = or i288 %r127, %r129
%r131 = zext i288 %r130 to i320
%r132 = zext i32 %r34 to i320
%r133 = shl i320 %r132, 288
%r134 = or i320 %r131, %r133
%r135 = zext i320 %r134 to i352
%r136 = zext i32 %r37 to i352
%r137 = shl i352 %r136, 320
%r138 = or i352 %r135, %r137
%r139 = zext i352 %r138 to i384
%r140 = zext i32 %r40 to i384
%r141 = shl i384 %r140, 352
%r142 = or i384 %r139, %r141
%r143 = zext i384 %r142 to i416
%r144 = zext i32 %r43 to i416
%r145 = shl i416 %r144, 384
%r146 = or i416 %r143, %r145
%r147 = zext i416 %r146 to i448
%r148 = zext i32 %r46 to i448
%r149 = shl i448 %r148, 416
%r150 = or i448 %r147, %r149
%r151 = zext i448 %r98 to i480
%r152 = zext i448 %r150 to i480
%r153 = shl i480 %r152, 32
%r154 = add i480 %r151, %r153
%r155 = bitcast i32* %r1 to i448*
%r156 = load i448, i448* %r155
%r157 = zext i448 %r156 to i480
%r158 = add i480 %r154, %r157
%r159 = trunc i480 %r158 to i448
%r160 = bitcast i32* %r1 to i448*
store i448 %r159, i448* %r160
%r161 = lshr i480 %r158, 448
%r162 = trunc i480 %r161 to i32
ret i32 %r162
}
define void @mclb_mul14(i32* noalias %r1, i32* noalias %r2, i32* noalias %r3)
{
%r4 = getelementptr i32, i32* %r2, i32 7
%r5 = getelementptr i32, i32* %r3, i32 7
%r6 = getelementptr i32, i32* %r1, i32 14
call void @mclb_mul7(i32* %r1, i32* %r2, i32* %r3)
call void @mclb_mul7(i32* %r6, i32* %r4, i32* %r5)
%r7 = bitcast i32* %r4 to i224*
%r8 = load i224, i224* %r7
%r9 = zext i224 %r8 to i256
%r10 = bitcast i32* %r2 to i224*
%r11 = load i224, i224* %r10
%r12 = zext i224 %r11 to i256
%r13 = bitcast i32* %r5 to i224*
%r14 = load i224, i224* %r13
%r15 = zext i224 %r14 to i256
%r16 = bitcast i32* %r3 to i224*
%r17 = load i224, i224* %r16
%r18 = zext i224 %r17 to i256
%r19 = add i256 %r9, %r12
%r20 = add i256 %r15, %r18
%r21 = alloca i32, i32 14
%r22 = trunc i256 %r19 to i224
%r23 = trunc i256 %r20 to i224
%r24 = lshr i256 %r19, 224
%r25 = trunc i256 %r24 to i1
%r26 = lshr i256 %r20, 224
%r27 = trunc i256 %r26 to i1
%r28 = and i1 %r25, %r27
%r29 = select i1 %r25, i224 %r23, i224 0
%r30 = select i1 %r27, i224 %r22, i224 0
%r31 = alloca i32, i32 7
%r32 = alloca i32, i32 7
%r33 = bitcast i32* %r31 to i224*
store i224 %r22, i224* %r33
%r34 = bitcast i32* %r32 to i224*
store i224 %r23, i224* %r34
call void @mclb_mul7(i32* %r21, i32* %r31, i32* %r32)
%r35 = bitcast i32* %r21 to i448*
%r36 = load i448, i448* %r35
%r37 = zext i448 %r36 to i480
%r38 = zext i1 %r28 to i480
%r39 = shl i480 %r38, 448
%r40 = or i480 %r37, %r39
%r41 = zext i224 %r29 to i480
%r42 = zext i224 %r30 to i480
%r43 = shl i480 %r41, 224
%r44 = shl i480 %r42, 224
%r45 = add i480 %r40, %r43
%r46 = add i480 %r45, %r44
%r47 = bitcast i32* %r1 to i448*
%r48 = load i448, i448* %r47
%r49 = zext i448 %r48 to i480
%r50 = sub i480 %r46, %r49
%r51 = getelementptr i32, i32* %r1, i32 14
%r52 = bitcast i32* %r51 to i448*
%r53 = load i448, i448* %r52
%r54 = zext i448 %r53 to i480
%r55 = sub i480 %r50, %r54
%r56 = zext i480 %r55 to i672
%r57 = getelementptr i32, i32* %r1, i32 7
%r58 = bitcast i32* %r57 to i672*
%r59 = load i672, i672* %r58
%r60 = add i672 %r56, %r59
%r61 = getelementptr i32, i32* %r1, i32 7
%r62 = bitcast i32* %r61 to i672*
store i672 %r60, i672* %r62
ret void
}
define void @mclb_sqr14(i32* noalias %r1, i32* noalias %r2)
{
%r3 = getelementptr i32, i32* %r2, i32 7
%r4 = getelementptr i32, i32* %r1, i32 14
%r5 = alloca i32, i32 14
call void @mclb_mul7(i32* %r5, i32* %r2, i32* %r3)
call void @mclb_sqr7(i32* %r1, i32* %r2)
call void @mclb_sqr7(i32* %r4, i32* %r3)
%r6 = bitcast i32* %r5 to i448*
%r7 = load i448, i448* %r6
%r8 = zext i448 %r7 to i480
%r9 = add i480 %r8, %r8
%r10 = zext i480 %r9 to i672
%r11 = getelementptr i32, i32* %r1, i32 7
%r12 = bitcast i32* %r11 to i672*
%r13 = load i672, i672* %r12
%r14 = add i672 %r13, %r10
%r15 = bitcast i32* %r11 to i672*
store i672 %r14, i672* %r15
ret void
}
define i512 @mulUnit_inner480(i32* noalias %r2, i32 %r3)
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
%r49 = zext i32 %r5 to i64
%r50 = zext i32 %r8 to i64
%r51 = shl i64 %r50, 32
%r52 = or i64 %r49, %r51
%r53 = zext i64 %r52 to i96
%r54 = zext i32 %r11 to i96
%r55 = shl i96 %r54, 64
%r56 = or i96 %r53, %r55
%r57 = zext i96 %r56 to i128
%r58 = zext i32 %r14 to i128
%r59 = shl i128 %r58, 96
%r60 = or i128 %r57, %r59
%r61 = zext i128 %r60 to i160
%r62 = zext i32 %r17 to i160
%r63 = shl i160 %r62, 128
%r64 = or i160 %r61, %r63
%r65 = zext i160 %r64 to i192
%r66 = zext i32 %r20 to i192
%r67 = shl i192 %r66, 160
%r68 = or i192 %r65, %r67
%r69 = zext i192 %r68 to i224
%r70 = zext i32 %r23 to i224
%r71 = shl i224 %r70, 192
%r72 = or i224 %r69, %r71
%r73 = zext i224 %r72 to i256
%r74 = zext i32 %r26 to i256
%r75 = shl i256 %r74, 224
%r76 = or i256 %r73, %r75
%r77 = zext i256 %r76 to i288
%r78 = zext i32 %r29 to i288
%r79 = shl i288 %r78, 256
%r80 = or i288 %r77, %r79
%r81 = zext i288 %r80 to i320
%r82 = zext i32 %r32 to i320
%r83 = shl i320 %r82, 288
%r84 = or i320 %r81, %r83
%r85 = zext i320 %r84 to i352
%r86 = zext i32 %r35 to i352
%r87 = shl i352 %r86, 320
%r88 = or i352 %r85, %r87
%r89 = zext i352 %r88 to i384
%r90 = zext i32 %r38 to i384
%r91 = shl i384 %r90, 352
%r92 = or i384 %r89, %r91
%r93 = zext i384 %r92 to i416
%r94 = zext i32 %r41 to i416
%r95 = shl i416 %r94, 384
%r96 = or i416 %r93, %r95
%r97 = zext i416 %r96 to i448
%r98 = zext i32 %r44 to i448
%r99 = shl i448 %r98, 416
%r100 = or i448 %r97, %r99
%r101 = zext i448 %r100 to i480
%r102 = zext i32 %r47 to i480
%r103 = shl i480 %r102, 448
%r104 = or i480 %r101, %r103
%r105 = zext i32 %r6 to i64
%r106 = zext i32 %r9 to i64
%r107 = shl i64 %r106, 32
%r108 = or i64 %r105, %r107
%r109 = zext i64 %r108 to i96
%r110 = zext i32 %r12 to i96
%r111 = shl i96 %r110, 64
%r112 = or i96 %r109, %r111
%r113 = zext i96 %r112 to i128
%r114 = zext i32 %r15 to i128
%r115 = shl i128 %r114, 96
%r116 = or i128 %r113, %r115
%r117 = zext i128 %r116 to i160
%r118 = zext i32 %r18 to i160
%r119 = shl i160 %r118, 128
%r120 = or i160 %r117, %r119
%r121 = zext i160 %r120 to i192
%r122 = zext i32 %r21 to i192
%r123 = shl i192 %r122, 160
%r124 = or i192 %r121, %r123
%r125 = zext i192 %r124 to i224
%r126 = zext i32 %r24 to i224
%r127 = shl i224 %r126, 192
%r128 = or i224 %r125, %r127
%r129 = zext i224 %r128 to i256
%r130 = zext i32 %r27 to i256
%r131 = shl i256 %r130, 224
%r132 = or i256 %r129, %r131
%r133 = zext i256 %r132 to i288
%r134 = zext i32 %r30 to i288
%r135 = shl i288 %r134, 256
%r136 = or i288 %r133, %r135
%r137 = zext i288 %r136 to i320
%r138 = zext i32 %r33 to i320
%r139 = shl i320 %r138, 288
%r140 = or i320 %r137, %r139
%r141 = zext i320 %r140 to i352
%r142 = zext i32 %r36 to i352
%r143 = shl i352 %r142, 320
%r144 = or i352 %r141, %r143
%r145 = zext i352 %r144 to i384
%r146 = zext i32 %r39 to i384
%r147 = shl i384 %r146, 352
%r148 = or i384 %r145, %r147
%r149 = zext i384 %r148 to i416
%r150 = zext i32 %r42 to i416
%r151 = shl i416 %r150, 384
%r152 = or i416 %r149, %r151
%r153 = zext i416 %r152 to i448
%r154 = zext i32 %r45 to i448
%r155 = shl i448 %r154, 416
%r156 = or i448 %r153, %r155
%r157 = zext i448 %r156 to i480
%r158 = zext i32 %r48 to i480
%r159 = shl i480 %r158, 448
%r160 = or i480 %r157, %r159
%r161 = zext i480 %r104 to i512
%r162 = zext i480 %r160 to i512
%r163 = shl i512 %r162, 32
%r164 = add i512 %r161, %r163
ret i512 %r164
}
define i32 @mclb_mulUnit15(i32* noalias %r1, i32* noalias %r2, i32 %r3)
{
%r5 = call i512 @mulUnit_inner480(i32* %r2, i32 %r3)
%r6 = trunc i512 %r5 to i480
%r7 = bitcast i32* %r1 to i480*
store i480 %r6, i480* %r7
%r8 = lshr i512 %r5, 480
%r9 = trunc i512 %r8 to i32
ret i32 %r9
}
define i32 @mclb_mulUnitAdd15(i32* noalias %r1, i32* noalias %r2, i32 %r3)
{
%r5 = call i64 @mulPos32x32(i32* %r2, i32 %r3, i32 0)
%r6 = trunc i64 %r5 to i32
%r7 = call i32 @extractHigh32(i64 %r5)
%r8 = call i64 @mulPos32x32(i32* %r2, i32 %r3, i32 1)
%r9 = trunc i64 %r8 to i32
%r10 = call i32 @extractHigh32(i64 %r8)
%r11 = call i64 @mulPos32x32(i32* %r2, i32 %r3, i32 2)
%r12 = trunc i64 %r11 to i32
%r13 = call i32 @extractHigh32(i64 %r11)
%r14 = call i64 @mulPos32x32(i32* %r2, i32 %r3, i32 3)
%r15 = trunc i64 %r14 to i32
%r16 = call i32 @extractHigh32(i64 %r14)
%r17 = call i64 @mulPos32x32(i32* %r2, i32 %r3, i32 4)
%r18 = trunc i64 %r17 to i32
%r19 = call i32 @extractHigh32(i64 %r17)
%r20 = call i64 @mulPos32x32(i32* %r2, i32 %r3, i32 5)
%r21 = trunc i64 %r20 to i32
%r22 = call i32 @extractHigh32(i64 %r20)
%r23 = call i64 @mulPos32x32(i32* %r2, i32 %r3, i32 6)
%r24 = trunc i64 %r23 to i32
%r25 = call i32 @extractHigh32(i64 %r23)
%r26 = call i64 @mulPos32x32(i32* %r2, i32 %r3, i32 7)
%r27 = trunc i64 %r26 to i32
%r28 = call i32 @extractHigh32(i64 %r26)
%r29 = call i64 @mulPos32x32(i32* %r2, i32 %r3, i32 8)
%r30 = trunc i64 %r29 to i32
%r31 = call i32 @extractHigh32(i64 %r29)
%r32 = call i64 @mulPos32x32(i32* %r2, i32 %r3, i32 9)
%r33 = trunc i64 %r32 to i32
%r34 = call i32 @extractHigh32(i64 %r32)
%r35 = call i64 @mulPos32x32(i32* %r2, i32 %r3, i32 10)
%r36 = trunc i64 %r35 to i32
%r37 = call i32 @extractHigh32(i64 %r35)
%r38 = call i64 @mulPos32x32(i32* %r2, i32 %r3, i32 11)
%r39 = trunc i64 %r38 to i32
%r40 = call i32 @extractHigh32(i64 %r38)
%r41 = call i64 @mulPos32x32(i32* %r2, i32 %r3, i32 12)
%r42 = trunc i64 %r41 to i32
%r43 = call i32 @extractHigh32(i64 %r41)
%r44 = call i64 @mulPos32x32(i32* %r2, i32 %r3, i32 13)
%r45 = trunc i64 %r44 to i32
%r46 = call i32 @extractHigh32(i64 %r44)
%r47 = call i64 @mulPos32x32(i32* %r2, i32 %r3, i32 14)
%r48 = trunc i64 %r47 to i32
%r49 = call i32 @extractHigh32(i64 %r47)
%r50 = zext i32 %r6 to i64
%r51 = zext i32 %r9 to i64
%r52 = shl i64 %r51, 32
%r53 = or i64 %r50, %r52
%r54 = zext i64 %r53 to i96
%r55 = zext i32 %r12 to i96
%r56 = shl i96 %r55, 64
%r57 = or i96 %r54, %r56
%r58 = zext i96 %r57 to i128
%r59 = zext i32 %r15 to i128
%r60 = shl i128 %r59, 96
%r61 = or i128 %r58, %r60
%r62 = zext i128 %r61 to i160
%r63 = zext i32 %r18 to i160
%r64 = shl i160 %r63, 128
%r65 = or i160 %r62, %r64
%r66 = zext i160 %r65 to i192
%r67 = zext i32 %r21 to i192
%r68 = shl i192 %r67, 160
%r69 = or i192 %r66, %r68
%r70 = zext i192 %r69 to i224
%r71 = zext i32 %r24 to i224
%r72 = shl i224 %r71, 192
%r73 = or i224 %r70, %r72
%r74 = zext i224 %r73 to i256
%r75 = zext i32 %r27 to i256
%r76 = shl i256 %r75, 224
%r77 = or i256 %r74, %r76
%r78 = zext i256 %r77 to i288
%r79 = zext i32 %r30 to i288
%r80 = shl i288 %r79, 256
%r81 = or i288 %r78, %r80
%r82 = zext i288 %r81 to i320
%r83 = zext i32 %r33 to i320
%r84 = shl i320 %r83, 288
%r85 = or i320 %r82, %r84
%r86 = zext i320 %r85 to i352
%r87 = zext i32 %r36 to i352
%r88 = shl i352 %r87, 320
%r89 = or i352 %r86, %r88
%r90 = zext i352 %r89 to i384
%r91 = zext i32 %r39 to i384
%r92 = shl i384 %r91, 352
%r93 = or i384 %r90, %r92
%r94 = zext i384 %r93 to i416
%r95 = zext i32 %r42 to i416
%r96 = shl i416 %r95, 384
%r97 = or i416 %r94, %r96
%r98 = zext i416 %r97 to i448
%r99 = zext i32 %r45 to i448
%r100 = shl i448 %r99, 416
%r101 = or i448 %r98, %r100
%r102 = zext i448 %r101 to i480
%r103 = zext i32 %r48 to i480
%r104 = shl i480 %r103, 448
%r105 = or i480 %r102, %r104
%r106 = zext i32 %r7 to i64
%r107 = zext i32 %r10 to i64
%r108 = shl i64 %r107, 32
%r109 = or i64 %r106, %r108
%r110 = zext i64 %r109 to i96
%r111 = zext i32 %r13 to i96
%r112 = shl i96 %r111, 64
%r113 = or i96 %r110, %r112
%r114 = zext i96 %r113 to i128
%r115 = zext i32 %r16 to i128
%r116 = shl i128 %r115, 96
%r117 = or i128 %r114, %r116
%r118 = zext i128 %r117 to i160
%r119 = zext i32 %r19 to i160
%r120 = shl i160 %r119, 128
%r121 = or i160 %r118, %r120
%r122 = zext i160 %r121 to i192
%r123 = zext i32 %r22 to i192
%r124 = shl i192 %r123, 160
%r125 = or i192 %r122, %r124
%r126 = zext i192 %r125 to i224
%r127 = zext i32 %r25 to i224
%r128 = shl i224 %r127, 192
%r129 = or i224 %r126, %r128
%r130 = zext i224 %r129 to i256
%r131 = zext i32 %r28 to i256
%r132 = shl i256 %r131, 224
%r133 = or i256 %r130, %r132
%r134 = zext i256 %r133 to i288
%r135 = zext i32 %r31 to i288
%r136 = shl i288 %r135, 256
%r137 = or i288 %r134, %r136
%r138 = zext i288 %r137 to i320
%r139 = zext i32 %r34 to i320
%r140 = shl i320 %r139, 288
%r141 = or i320 %r138, %r140
%r142 = zext i320 %r141 to i352
%r143 = zext i32 %r37 to i352
%r144 = shl i352 %r143, 320
%r145 = or i352 %r142, %r144
%r146 = zext i352 %r145 to i384
%r147 = zext i32 %r40 to i384
%r148 = shl i384 %r147, 352
%r149 = or i384 %r146, %r148
%r150 = zext i384 %r149 to i416
%r151 = zext i32 %r43 to i416
%r152 = shl i416 %r151, 384
%r153 = or i416 %r150, %r152
%r154 = zext i416 %r153 to i448
%r155 = zext i32 %r46 to i448
%r156 = shl i448 %r155, 416
%r157 = or i448 %r154, %r156
%r158 = zext i448 %r157 to i480
%r159 = zext i32 %r49 to i480
%r160 = shl i480 %r159, 448
%r161 = or i480 %r158, %r160
%r162 = zext i480 %r105 to i512
%r163 = zext i480 %r161 to i512
%r164 = shl i512 %r163, 32
%r165 = add i512 %r162, %r164
%r166 = bitcast i32* %r1 to i480*
%r167 = load i480, i480* %r166
%r168 = zext i480 %r167 to i512
%r169 = add i512 %r165, %r168
%r170 = trunc i512 %r169 to i480
%r171 = bitcast i32* %r1 to i480*
store i480 %r170, i480* %r171
%r172 = lshr i512 %r169, 480
%r173 = trunc i512 %r172 to i32
ret i32 %r173
}
define void @mclb_mul15(i32* noalias %r1, i32* noalias %r2, i32* noalias %r3)
{
%r4 = load i32, i32* %r3
%r5 = call i512 @mulUnit_inner480(i32* %r2, i32 %r4)
%r6 = trunc i512 %r5 to i32
store i32 %r6, i32* %r1
%r7 = lshr i512 %r5, 32
%r8 = getelementptr i32, i32* %r3, i32 1
%r9 = load i32, i32* %r8
%r10 = call i512 @mulUnit_inner480(i32* %r2, i32 %r9)
%r11 = add i512 %r7, %r10
%r12 = trunc i512 %r11 to i32
%r13 = getelementptr i32, i32* %r1, i32 1
store i32 %r12, i32* %r13
%r14 = lshr i512 %r11, 32
%r15 = getelementptr i32, i32* %r3, i32 2
%r16 = load i32, i32* %r15
%r17 = call i512 @mulUnit_inner480(i32* %r2, i32 %r16)
%r18 = add i512 %r14, %r17
%r19 = trunc i512 %r18 to i32
%r20 = getelementptr i32, i32* %r1, i32 2
store i32 %r19, i32* %r20
%r21 = lshr i512 %r18, 32
%r22 = getelementptr i32, i32* %r3, i32 3
%r23 = load i32, i32* %r22
%r24 = call i512 @mulUnit_inner480(i32* %r2, i32 %r23)
%r25 = add i512 %r21, %r24
%r26 = trunc i512 %r25 to i32
%r27 = getelementptr i32, i32* %r1, i32 3
store i32 %r26, i32* %r27
%r28 = lshr i512 %r25, 32
%r29 = getelementptr i32, i32* %r3, i32 4
%r30 = load i32, i32* %r29
%r31 = call i512 @mulUnit_inner480(i32* %r2, i32 %r30)
%r32 = add i512 %r28, %r31
%r33 = trunc i512 %r32 to i32
%r34 = getelementptr i32, i32* %r1, i32 4
store i32 %r33, i32* %r34
%r35 = lshr i512 %r32, 32
%r36 = getelementptr i32, i32* %r3, i32 5
%r37 = load i32, i32* %r36
%r38 = call i512 @mulUnit_inner480(i32* %r2, i32 %r37)
%r39 = add i512 %r35, %r38
%r40 = trunc i512 %r39 to i32
%r41 = getelementptr i32, i32* %r1, i32 5
store i32 %r40, i32* %r41
%r42 = lshr i512 %r39, 32
%r43 = getelementptr i32, i32* %r3, i32 6
%r44 = load i32, i32* %r43
%r45 = call i512 @mulUnit_inner480(i32* %r2, i32 %r44)
%r46 = add i512 %r42, %r45
%r47 = trunc i512 %r46 to i32
%r48 = getelementptr i32, i32* %r1, i32 6
store i32 %r47, i32* %r48
%r49 = lshr i512 %r46, 32
%r50 = getelementptr i32, i32* %r3, i32 7
%r51 = load i32, i32* %r50
%r52 = call i512 @mulUnit_inner480(i32* %r2, i32 %r51)
%r53 = add i512 %r49, %r52
%r54 = trunc i512 %r53 to i32
%r55 = getelementptr i32, i32* %r1, i32 7
store i32 %r54, i32* %r55
%r56 = lshr i512 %r53, 32
%r57 = getelementptr i32, i32* %r3, i32 8
%r58 = load i32, i32* %r57
%r59 = call i512 @mulUnit_inner480(i32* %r2, i32 %r58)
%r60 = add i512 %r56, %r59
%r61 = trunc i512 %r60 to i32
%r62 = getelementptr i32, i32* %r1, i32 8
store i32 %r61, i32* %r62
%r63 = lshr i512 %r60, 32
%r64 = getelementptr i32, i32* %r3, i32 9
%r65 = load i32, i32* %r64
%r66 = call i512 @mulUnit_inner480(i32* %r2, i32 %r65)
%r67 = add i512 %r63, %r66
%r68 = trunc i512 %r67 to i32
%r69 = getelementptr i32, i32* %r1, i32 9
store i32 %r68, i32* %r69
%r70 = lshr i512 %r67, 32
%r71 = getelementptr i32, i32* %r3, i32 10
%r72 = load i32, i32* %r71
%r73 = call i512 @mulUnit_inner480(i32* %r2, i32 %r72)
%r74 = add i512 %r70, %r73
%r75 = trunc i512 %r74 to i32
%r76 = getelementptr i32, i32* %r1, i32 10
store i32 %r75, i32* %r76
%r77 = lshr i512 %r74, 32
%r78 = getelementptr i32, i32* %r3, i32 11
%r79 = load i32, i32* %r78
%r80 = call i512 @mulUnit_inner480(i32* %r2, i32 %r79)
%r81 = add i512 %r77, %r80
%r82 = trunc i512 %r81 to i32
%r83 = getelementptr i32, i32* %r1, i32 11
store i32 %r82, i32* %r83
%r84 = lshr i512 %r81, 32
%r85 = getelementptr i32, i32* %r3, i32 12
%r86 = load i32, i32* %r85
%r87 = call i512 @mulUnit_inner480(i32* %r2, i32 %r86)
%r88 = add i512 %r84, %r87
%r89 = trunc i512 %r88 to i32
%r90 = getelementptr i32, i32* %r1, i32 12
store i32 %r89, i32* %r90
%r91 = lshr i512 %r88, 32
%r92 = getelementptr i32, i32* %r3, i32 13
%r93 = load i32, i32* %r92
%r94 = call i512 @mulUnit_inner480(i32* %r2, i32 %r93)
%r95 = add i512 %r91, %r94
%r96 = trunc i512 %r95 to i32
%r97 = getelementptr i32, i32* %r1, i32 13
store i32 %r96, i32* %r97
%r98 = lshr i512 %r95, 32
%r99 = getelementptr i32, i32* %r3, i32 14
%r100 = load i32, i32* %r99
%r101 = call i512 @mulUnit_inner480(i32* %r2, i32 %r100)
%r102 = add i512 %r98, %r101
%r103 = getelementptr i32, i32* %r1, i32 14
%r104 = bitcast i32* %r103 to i512*
store i512 %r102, i512* %r104
ret void
}
define void @mclb_sqr15(i32* noalias %r1, i32* noalias %r2)
{
%r3 = load i32, i32* %r2
%r4 = call i64 @mul32x32L(i32 %r3, i32 %r3)
%r5 = trunc i64 %r4 to i32
store i32 %r5, i32* %r1
%r6 = lshr i64 %r4, 32
%r7 = getelementptr i32, i32* %r2, i32 14
%r8 = load i32, i32* %r7
%r9 = call i64 @mul32x32L(i32 %r3, i32 %r8)
%r10 = load i32, i32* %r2
%r11 = getelementptr i32, i32* %r2, i32 13
%r12 = load i32, i32* %r11
%r13 = call i64 @mul32x32L(i32 %r10, i32 %r12)
%r14 = getelementptr i32, i32* %r2, i32 1
%r15 = load i32, i32* %r14
%r16 = getelementptr i32, i32* %r2, i32 14
%r17 = load i32, i32* %r16
%r18 = call i64 @mul32x32L(i32 %r15, i32 %r17)
%r19 = zext i64 %r13 to i128
%r20 = zext i64 %r18 to i128
%r21 = shl i128 %r20, 64
%r22 = or i128 %r19, %r21
%r23 = zext i64 %r9 to i128
%r24 = shl i128 %r23, 32
%r25 = add i128 %r24, %r22
%r26 = load i32, i32* %r2
%r27 = getelementptr i32, i32* %r2, i32 12
%r28 = load i32, i32* %r27
%r29 = call i64 @mul32x32L(i32 %r26, i32 %r28)
%r30 = getelementptr i32, i32* %r2, i32 1
%r31 = load i32, i32* %r30
%r32 = getelementptr i32, i32* %r2, i32 13
%r33 = load i32, i32* %r32
%r34 = call i64 @mul32x32L(i32 %r31, i32 %r33)
%r35 = zext i64 %r29 to i128
%r36 = zext i64 %r34 to i128
%r37 = shl i128 %r36, 64
%r38 = or i128 %r35, %r37
%r39 = getelementptr i32, i32* %r2, i32 2
%r40 = load i32, i32* %r39
%r41 = getelementptr i32, i32* %r2, i32 14
%r42 = load i32, i32* %r41
%r43 = call i64 @mul32x32L(i32 %r40, i32 %r42)
%r44 = zext i128 %r38 to i192
%r45 = zext i64 %r43 to i192
%r46 = shl i192 %r45, 128
%r47 = or i192 %r44, %r46
%r48 = zext i128 %r25 to i192
%r49 = shl i192 %r48, 32
%r50 = add i192 %r49, %r47
%r51 = load i32, i32* %r2
%r52 = getelementptr i32, i32* %r2, i32 11
%r53 = load i32, i32* %r52
%r54 = call i64 @mul32x32L(i32 %r51, i32 %r53)
%r55 = getelementptr i32, i32* %r2, i32 1
%r56 = load i32, i32* %r55
%r57 = getelementptr i32, i32* %r2, i32 12
%r58 = load i32, i32* %r57
%r59 = call i64 @mul32x32L(i32 %r56, i32 %r58)
%r60 = zext i64 %r54 to i128
%r61 = zext i64 %r59 to i128
%r62 = shl i128 %r61, 64
%r63 = or i128 %r60, %r62
%r64 = getelementptr i32, i32* %r2, i32 2
%r65 = load i32, i32* %r64
%r66 = getelementptr i32, i32* %r2, i32 13
%r67 = load i32, i32* %r66
%r68 = call i64 @mul32x32L(i32 %r65, i32 %r67)
%r69 = zext i128 %r63 to i192
%r70 = zext i64 %r68 to i192
%r71 = shl i192 %r70, 128
%r72 = or i192 %r69, %r71
%r73 = getelementptr i32, i32* %r2, i32 3
%r74 = load i32, i32* %r73
%r75 = getelementptr i32, i32* %r2, i32 14
%r76 = load i32, i32* %r75
%r77 = call i64 @mul32x32L(i32 %r74, i32 %r76)
%r78 = zext i192 %r72 to i256
%r79 = zext i64 %r77 to i256
%r80 = shl i256 %r79, 192
%r81 = or i256 %r78, %r80
%r82 = zext i192 %r50 to i256
%r83 = shl i256 %r82, 32
%r84 = add i256 %r83, %r81
%r85 = load i32, i32* %r2
%r86 = getelementptr i32, i32* %r2, i32 10
%r87 = load i32, i32* %r86
%r88 = call i64 @mul32x32L(i32 %r85, i32 %r87)
%r89 = getelementptr i32, i32* %r2, i32 1
%r90 = load i32, i32* %r89
%r91 = getelementptr i32, i32* %r2, i32 11
%r92 = load i32, i32* %r91
%r93 = call i64 @mul32x32L(i32 %r90, i32 %r92)
%r94 = zext i64 %r88 to i128
%r95 = zext i64 %r93 to i128
%r96 = shl i128 %r95, 64
%r97 = or i128 %r94, %r96
%r98 = getelementptr i32, i32* %r2, i32 2
%r99 = load i32, i32* %r98
%r100 = getelementptr i32, i32* %r2, i32 12
%r101 = load i32, i32* %r100
%r102 = call i64 @mul32x32L(i32 %r99, i32 %r101)
%r103 = zext i128 %r97 to i192
%r104 = zext i64 %r102 to i192
%r105 = shl i192 %r104, 128
%r106 = or i192 %r103, %r105
%r107 = getelementptr i32, i32* %r2, i32 3
%r108 = load i32, i32* %r107
%r109 = getelementptr i32, i32* %r2, i32 13
%r110 = load i32, i32* %r109
%r111 = call i64 @mul32x32L(i32 %r108, i32 %r110)
%r112 = zext i192 %r106 to i256
%r113 = zext i64 %r111 to i256
%r114 = shl i256 %r113, 192
%r115 = or i256 %r112, %r114
%r116 = getelementptr i32, i32* %r2, i32 4
%r117 = load i32, i32* %r116
%r118 = getelementptr i32, i32* %r2, i32 14
%r119 = load i32, i32* %r118
%r120 = call i64 @mul32x32L(i32 %r117, i32 %r119)
%r121 = zext i256 %r115 to i320
%r122 = zext i64 %r120 to i320
%r123 = shl i320 %r122, 256
%r124 = or i320 %r121, %r123
%r125 = zext i256 %r84 to i320
%r126 = shl i320 %r125, 32
%r127 = add i320 %r126, %r124
%r128 = load i32, i32* %r2
%r129 = getelementptr i32, i32* %r2, i32 9
%r130 = load i32, i32* %r129
%r131 = call i64 @mul32x32L(i32 %r128, i32 %r130)
%r132 = getelementptr i32, i32* %r2, i32 1
%r133 = load i32, i32* %r132
%r134 = getelementptr i32, i32* %r2, i32 10
%r135 = load i32, i32* %r134
%r136 = call i64 @mul32x32L(i32 %r133, i32 %r135)
%r137 = zext i64 %r131 to i128
%r138 = zext i64 %r136 to i128
%r139 = shl i128 %r138, 64
%r140 = or i128 %r137, %r139
%r141 = getelementptr i32, i32* %r2, i32 2
%r142 = load i32, i32* %r141
%r143 = getelementptr i32, i32* %r2, i32 11
%r144 = load i32, i32* %r143
%r145 = call i64 @mul32x32L(i32 %r142, i32 %r144)
%r146 = zext i128 %r140 to i192
%r147 = zext i64 %r145 to i192
%r148 = shl i192 %r147, 128
%r149 = or i192 %r146, %r148
%r150 = getelementptr i32, i32* %r2, i32 3
%r151 = load i32, i32* %r150
%r152 = getelementptr i32, i32* %r2, i32 12
%r153 = load i32, i32* %r152
%r154 = call i64 @mul32x32L(i32 %r151, i32 %r153)
%r155 = zext i192 %r149 to i256
%r156 = zext i64 %r154 to i256
%r157 = shl i256 %r156, 192
%r158 = or i256 %r155, %r157
%r159 = getelementptr i32, i32* %r2, i32 4
%r160 = load i32, i32* %r159
%r161 = getelementptr i32, i32* %r2, i32 13
%r162 = load i32, i32* %r161
%r163 = call i64 @mul32x32L(i32 %r160, i32 %r162)
%r164 = zext i256 %r158 to i320
%r165 = zext i64 %r163 to i320
%r166 = shl i320 %r165, 256
%r167 = or i320 %r164, %r166
%r168 = getelementptr i32, i32* %r2, i32 5
%r169 = load i32, i32* %r168
%r170 = getelementptr i32, i32* %r2, i32 14
%r171 = load i32, i32* %r170
%r172 = call i64 @mul32x32L(i32 %r169, i32 %r171)
%r173 = zext i320 %r167 to i384
%r174 = zext i64 %r172 to i384
%r175 = shl i384 %r174, 320
%r176 = or i384 %r173, %r175
%r177 = zext i320 %r127 to i384
%r178 = shl i384 %r177, 32
%r179 = add i384 %r178, %r176
%r180 = load i32, i32* %r2
%r181 = getelementptr i32, i32* %r2, i32 8
%r182 = load i32, i32* %r181
%r183 = call i64 @mul32x32L(i32 %r180, i32 %r182)
%r184 = getelementptr i32, i32* %r2, i32 1
%r185 = load i32, i32* %r184
%r186 = getelementptr i32, i32* %r2, i32 9
%r187 = load i32, i32* %r186
%r188 = call i64 @mul32x32L(i32 %r185, i32 %r187)
%r189 = zext i64 %r183 to i128
%r190 = zext i64 %r188 to i128
%r191 = shl i128 %r190, 64
%r192 = or i128 %r189, %r191
%r193 = getelementptr i32, i32* %r2, i32 2
%r194 = load i32, i32* %r193
%r195 = getelementptr i32, i32* %r2, i32 10
%r196 = load i32, i32* %r195
%r197 = call i64 @mul32x32L(i32 %r194, i32 %r196)
%r198 = zext i128 %r192 to i192
%r199 = zext i64 %r197 to i192
%r200 = shl i192 %r199, 128
%r201 = or i192 %r198, %r200
%r202 = getelementptr i32, i32* %r2, i32 3
%r203 = load i32, i32* %r202
%r204 = getelementptr i32, i32* %r2, i32 11
%r205 = load i32, i32* %r204
%r206 = call i64 @mul32x32L(i32 %r203, i32 %r205)
%r207 = zext i192 %r201 to i256
%r208 = zext i64 %r206 to i256
%r209 = shl i256 %r208, 192
%r210 = or i256 %r207, %r209
%r211 = getelementptr i32, i32* %r2, i32 4
%r212 = load i32, i32* %r211
%r213 = getelementptr i32, i32* %r2, i32 12
%r214 = load i32, i32* %r213
%r215 = call i64 @mul32x32L(i32 %r212, i32 %r214)
%r216 = zext i256 %r210 to i320
%r217 = zext i64 %r215 to i320
%r218 = shl i320 %r217, 256
%r219 = or i320 %r216, %r218
%r220 = getelementptr i32, i32* %r2, i32 5
%r221 = load i32, i32* %r220
%r222 = getelementptr i32, i32* %r2, i32 13
%r223 = load i32, i32* %r222
%r224 = call i64 @mul32x32L(i32 %r221, i32 %r223)
%r225 = zext i320 %r219 to i384
%r226 = zext i64 %r224 to i384
%r227 = shl i384 %r226, 320
%r228 = or i384 %r225, %r227
%r229 = getelementptr i32, i32* %r2, i32 6
%r230 = load i32, i32* %r229
%r231 = getelementptr i32, i32* %r2, i32 14
%r232 = load i32, i32* %r231
%r233 = call i64 @mul32x32L(i32 %r230, i32 %r232)
%r234 = zext i384 %r228 to i448
%r235 = zext i64 %r233 to i448
%r236 = shl i448 %r235, 384
%r237 = or i448 %r234, %r236
%r238 = zext i384 %r179 to i448
%r239 = shl i448 %r238, 32
%r240 = add i448 %r239, %r237
%r241 = load i32, i32* %r2
%r242 = getelementptr i32, i32* %r2, i32 7
%r243 = load i32, i32* %r242
%r244 = call i64 @mul32x32L(i32 %r241, i32 %r243)
%r245 = getelementptr i32, i32* %r2, i32 1
%r246 = load i32, i32* %r245
%r247 = getelementptr i32, i32* %r2, i32 8
%r248 = load i32, i32* %r247
%r249 = call i64 @mul32x32L(i32 %r246, i32 %r248)
%r250 = zext i64 %r244 to i128
%r251 = zext i64 %r249 to i128
%r252 = shl i128 %r251, 64
%r253 = or i128 %r250, %r252
%r254 = getelementptr i32, i32* %r2, i32 2
%r255 = load i32, i32* %r254
%r256 = getelementptr i32, i32* %r2, i32 9
%r257 = load i32, i32* %r256
%r258 = call i64 @mul32x32L(i32 %r255, i32 %r257)
%r259 = zext i128 %r253 to i192
%r260 = zext i64 %r258 to i192
%r261 = shl i192 %r260, 128
%r262 = or i192 %r259, %r261
%r263 = getelementptr i32, i32* %r2, i32 3
%r264 = load i32, i32* %r263
%r265 = getelementptr i32, i32* %r2, i32 10
%r266 = load i32, i32* %r265
%r267 = call i64 @mul32x32L(i32 %r264, i32 %r266)
%r268 = zext i192 %r262 to i256
%r269 = zext i64 %r267 to i256
%r270 = shl i256 %r269, 192
%r271 = or i256 %r268, %r270
%r272 = getelementptr i32, i32* %r2, i32 4
%r273 = load i32, i32* %r272
%r274 = getelementptr i32, i32* %r2, i32 11
%r275 = load i32, i32* %r274
%r276 = call i64 @mul32x32L(i32 %r273, i32 %r275)
%r277 = zext i256 %r271 to i320
%r278 = zext i64 %r276 to i320
%r279 = shl i320 %r278, 256
%r280 = or i320 %r277, %r279
%r281 = getelementptr i32, i32* %r2, i32 5
%r282 = load i32, i32* %r281
%r283 = getelementptr i32, i32* %r2, i32 12
%r284 = load i32, i32* %r283
%r285 = call i64 @mul32x32L(i32 %r282, i32 %r284)
%r286 = zext i320 %r280 to i384
%r287 = zext i64 %r285 to i384
%r288 = shl i384 %r287, 320
%r289 = or i384 %r286, %r288
%r290 = getelementptr i32, i32* %r2, i32 6
%r291 = load i32, i32* %r290
%r292 = getelementptr i32, i32* %r2, i32 13
%r293 = load i32, i32* %r292
%r294 = call i64 @mul32x32L(i32 %r291, i32 %r293)
%r295 = zext i384 %r289 to i448
%r296 = zext i64 %r294 to i448
%r297 = shl i448 %r296, 384
%r298 = or i448 %r295, %r297
%r299 = getelementptr i32, i32* %r2, i32 7
%r300 = load i32, i32* %r299
%r301 = getelementptr i32, i32* %r2, i32 14
%r302 = load i32, i32* %r301
%r303 = call i64 @mul32x32L(i32 %r300, i32 %r302)
%r304 = zext i448 %r298 to i512
%r305 = zext i64 %r303 to i512
%r306 = shl i512 %r305, 448
%r307 = or i512 %r304, %r306
%r308 = zext i448 %r240 to i512
%r309 = shl i512 %r308, 32
%r310 = add i512 %r309, %r307
%r311 = load i32, i32* %r2
%r312 = getelementptr i32, i32* %r2, i32 6
%r313 = load i32, i32* %r312
%r314 = call i64 @mul32x32L(i32 %r311, i32 %r313)
%r315 = getelementptr i32, i32* %r2, i32 1
%r316 = load i32, i32* %r315
%r317 = getelementptr i32, i32* %r2, i32 7
%r318 = load i32, i32* %r317
%r319 = call i64 @mul32x32L(i32 %r316, i32 %r318)
%r320 = zext i64 %r314 to i128
%r321 = zext i64 %r319 to i128
%r322 = shl i128 %r321, 64
%r323 = or i128 %r320, %r322
%r324 = getelementptr i32, i32* %r2, i32 2
%r325 = load i32, i32* %r324
%r326 = getelementptr i32, i32* %r2, i32 8
%r327 = load i32, i32* %r326
%r328 = call i64 @mul32x32L(i32 %r325, i32 %r327)
%r329 = zext i128 %r323 to i192
%r330 = zext i64 %r328 to i192
%r331 = shl i192 %r330, 128
%r332 = or i192 %r329, %r331
%r333 = getelementptr i32, i32* %r2, i32 3
%r334 = load i32, i32* %r333
%r335 = getelementptr i32, i32* %r2, i32 9
%r336 = load i32, i32* %r335
%r337 = call i64 @mul32x32L(i32 %r334, i32 %r336)
%r338 = zext i192 %r332 to i256
%r339 = zext i64 %r337 to i256
%r340 = shl i256 %r339, 192
%r341 = or i256 %r338, %r340
%r342 = getelementptr i32, i32* %r2, i32 4
%r343 = load i32, i32* %r342
%r344 = getelementptr i32, i32* %r2, i32 10
%r345 = load i32, i32* %r344
%r346 = call i64 @mul32x32L(i32 %r343, i32 %r345)
%r347 = zext i256 %r341 to i320
%r348 = zext i64 %r346 to i320
%r349 = shl i320 %r348, 256
%r350 = or i320 %r347, %r349
%r351 = getelementptr i32, i32* %r2, i32 5
%r352 = load i32, i32* %r351
%r353 = getelementptr i32, i32* %r2, i32 11
%r354 = load i32, i32* %r353
%r355 = call i64 @mul32x32L(i32 %r352, i32 %r354)
%r356 = zext i320 %r350 to i384
%r357 = zext i64 %r355 to i384
%r358 = shl i384 %r357, 320
%r359 = or i384 %r356, %r358
%r360 = getelementptr i32, i32* %r2, i32 6
%r361 = load i32, i32* %r360
%r362 = getelementptr i32, i32* %r2, i32 12
%r363 = load i32, i32* %r362
%r364 = call i64 @mul32x32L(i32 %r361, i32 %r363)
%r365 = zext i384 %r359 to i448
%r366 = zext i64 %r364 to i448
%r367 = shl i448 %r366, 384
%r368 = or i448 %r365, %r367
%r369 = getelementptr i32, i32* %r2, i32 7
%r370 = load i32, i32* %r369
%r371 = getelementptr i32, i32* %r2, i32 13
%r372 = load i32, i32* %r371
%r373 = call i64 @mul32x32L(i32 %r370, i32 %r372)
%r374 = zext i448 %r368 to i512
%r375 = zext i64 %r373 to i512
%r376 = shl i512 %r375, 448
%r377 = or i512 %r374, %r376
%r378 = getelementptr i32, i32* %r2, i32 8
%r379 = load i32, i32* %r378
%r380 = getelementptr i32, i32* %r2, i32 14
%r381 = load i32, i32* %r380
%r382 = call i64 @mul32x32L(i32 %r379, i32 %r381)
%r383 = zext i512 %r377 to i576
%r384 = zext i64 %r382 to i576
%r385 = shl i576 %r384, 512
%r386 = or i576 %r383, %r385
%r387 = zext i512 %r310 to i576
%r388 = shl i576 %r387, 32
%r389 = add i576 %r388, %r386
%r390 = load i32, i32* %r2
%r391 = getelementptr i32, i32* %r2, i32 5
%r392 = load i32, i32* %r391
%r393 = call i64 @mul32x32L(i32 %r390, i32 %r392)
%r394 = getelementptr i32, i32* %r2, i32 1
%r395 = load i32, i32* %r394
%r396 = getelementptr i32, i32* %r2, i32 6
%r397 = load i32, i32* %r396
%r398 = call i64 @mul32x32L(i32 %r395, i32 %r397)
%r399 = zext i64 %r393 to i128
%r400 = zext i64 %r398 to i128
%r401 = shl i128 %r400, 64
%r402 = or i128 %r399, %r401
%r403 = getelementptr i32, i32* %r2, i32 2
%r404 = load i32, i32* %r403
%r405 = getelementptr i32, i32* %r2, i32 7
%r406 = load i32, i32* %r405
%r407 = call i64 @mul32x32L(i32 %r404, i32 %r406)
%r408 = zext i128 %r402 to i192
%r409 = zext i64 %r407 to i192
%r410 = shl i192 %r409, 128
%r411 = or i192 %r408, %r410
%r412 = getelementptr i32, i32* %r2, i32 3
%r413 = load i32, i32* %r412
%r414 = getelementptr i32, i32* %r2, i32 8
%r415 = load i32, i32* %r414
%r416 = call i64 @mul32x32L(i32 %r413, i32 %r415)
%r417 = zext i192 %r411 to i256
%r418 = zext i64 %r416 to i256
%r419 = shl i256 %r418, 192
%r420 = or i256 %r417, %r419
%r421 = getelementptr i32, i32* %r2, i32 4
%r422 = load i32, i32* %r421
%r423 = getelementptr i32, i32* %r2, i32 9
%r424 = load i32, i32* %r423
%r425 = call i64 @mul32x32L(i32 %r422, i32 %r424)
%r426 = zext i256 %r420 to i320
%r427 = zext i64 %r425 to i320
%r428 = shl i320 %r427, 256
%r429 = or i320 %r426, %r428
%r430 = getelementptr i32, i32* %r2, i32 5
%r431 = load i32, i32* %r430
%r432 = getelementptr i32, i32* %r2, i32 10
%r433 = load i32, i32* %r432
%r434 = call i64 @mul32x32L(i32 %r431, i32 %r433)
%r435 = zext i320 %r429 to i384
%r436 = zext i64 %r434 to i384
%r437 = shl i384 %r436, 320
%r438 = or i384 %r435, %r437
%r439 = getelementptr i32, i32* %r2, i32 6
%r440 = load i32, i32* %r439
%r441 = getelementptr i32, i32* %r2, i32 11
%r442 = load i32, i32* %r441
%r443 = call i64 @mul32x32L(i32 %r440, i32 %r442)
%r444 = zext i384 %r438 to i448
%r445 = zext i64 %r443 to i448
%r446 = shl i448 %r445, 384
%r447 = or i448 %r444, %r446
%r448 = getelementptr i32, i32* %r2, i32 7
%r449 = load i32, i32* %r448
%r450 = getelementptr i32, i32* %r2, i32 12
%r451 = load i32, i32* %r450
%r452 = call i64 @mul32x32L(i32 %r449, i32 %r451)
%r453 = zext i448 %r447 to i512
%r454 = zext i64 %r452 to i512
%r455 = shl i512 %r454, 448
%r456 = or i512 %r453, %r455
%r457 = getelementptr i32, i32* %r2, i32 8
%r458 = load i32, i32* %r457
%r459 = getelementptr i32, i32* %r2, i32 13
%r460 = load i32, i32* %r459
%r461 = call i64 @mul32x32L(i32 %r458, i32 %r460)
%r462 = zext i512 %r456 to i576
%r463 = zext i64 %r461 to i576
%r464 = shl i576 %r463, 512
%r465 = or i576 %r462, %r464
%r466 = getelementptr i32, i32* %r2, i32 9
%r467 = load i32, i32* %r466
%r468 = getelementptr i32, i32* %r2, i32 14
%r469 = load i32, i32* %r468
%r470 = call i64 @mul32x32L(i32 %r467, i32 %r469)
%r471 = zext i576 %r465 to i640
%r472 = zext i64 %r470 to i640
%r473 = shl i640 %r472, 576
%r474 = or i640 %r471, %r473
%r475 = zext i576 %r389 to i640
%r476 = shl i640 %r475, 32
%r477 = add i640 %r476, %r474
%r478 = load i32, i32* %r2
%r479 = getelementptr i32, i32* %r2, i32 4
%r480 = load i32, i32* %r479
%r481 = call i64 @mul32x32L(i32 %r478, i32 %r480)
%r482 = getelementptr i32, i32* %r2, i32 1
%r483 = load i32, i32* %r482
%r484 = getelementptr i32, i32* %r2, i32 5
%r485 = load i32, i32* %r484
%r486 = call i64 @mul32x32L(i32 %r483, i32 %r485)
%r487 = zext i64 %r481 to i128
%r488 = zext i64 %r486 to i128
%r489 = shl i128 %r488, 64
%r490 = or i128 %r487, %r489
%r491 = getelementptr i32, i32* %r2, i32 2
%r492 = load i32, i32* %r491
%r493 = getelementptr i32, i32* %r2, i32 6
%r494 = load i32, i32* %r493
%r495 = call i64 @mul32x32L(i32 %r492, i32 %r494)
%r496 = zext i128 %r490 to i192
%r497 = zext i64 %r495 to i192
%r498 = shl i192 %r497, 128
%r499 = or i192 %r496, %r498
%r500 = getelementptr i32, i32* %r2, i32 3
%r501 = load i32, i32* %r500
%r502 = getelementptr i32, i32* %r2, i32 7
%r503 = load i32, i32* %r502
%r504 = call i64 @mul32x32L(i32 %r501, i32 %r503)
%r505 = zext i192 %r499 to i256
%r506 = zext i64 %r504 to i256
%r507 = shl i256 %r506, 192
%r508 = or i256 %r505, %r507
%r509 = getelementptr i32, i32* %r2, i32 4
%r510 = load i32, i32* %r509
%r511 = getelementptr i32, i32* %r2, i32 8
%r512 = load i32, i32* %r511
%r513 = call i64 @mul32x32L(i32 %r510, i32 %r512)
%r514 = zext i256 %r508 to i320
%r515 = zext i64 %r513 to i320
%r516 = shl i320 %r515, 256
%r517 = or i320 %r514, %r516
%r518 = getelementptr i32, i32* %r2, i32 5
%r519 = load i32, i32* %r518
%r520 = getelementptr i32, i32* %r2, i32 9
%r521 = load i32, i32* %r520
%r522 = call i64 @mul32x32L(i32 %r519, i32 %r521)
%r523 = zext i320 %r517 to i384
%r524 = zext i64 %r522 to i384
%r525 = shl i384 %r524, 320
%r526 = or i384 %r523, %r525
%r527 = getelementptr i32, i32* %r2, i32 6
%r528 = load i32, i32* %r527
%r529 = getelementptr i32, i32* %r2, i32 10
%r530 = load i32, i32* %r529
%r531 = call i64 @mul32x32L(i32 %r528, i32 %r530)
%r532 = zext i384 %r526 to i448
%r533 = zext i64 %r531 to i448
%r534 = shl i448 %r533, 384
%r535 = or i448 %r532, %r534
%r536 = getelementptr i32, i32* %r2, i32 7
%r537 = load i32, i32* %r536
%r538 = getelementptr i32, i32* %r2, i32 11
%r539 = load i32, i32* %r538
%r540 = call i64 @mul32x32L(i32 %r537, i32 %r539)
%r541 = zext i448 %r535 to i512
%r542 = zext i64 %r540 to i512
%r543 = shl i512 %r542, 448
%r544 = or i512 %r541, %r543
%r545 = getelementptr i32, i32* %r2, i32 8
%r546 = load i32, i32* %r545
%r547 = getelementptr i32, i32* %r2, i32 12
%r548 = load i32, i32* %r547
%r549 = call i64 @mul32x32L(i32 %r546, i32 %r548)
%r550 = zext i512 %r544 to i576
%r551 = zext i64 %r549 to i576
%r552 = shl i576 %r551, 512
%r553 = or i576 %r550, %r552
%r554 = getelementptr i32, i32* %r2, i32 9
%r555 = load i32, i32* %r554
%r556 = getelementptr i32, i32* %r2, i32 13
%r557 = load i32, i32* %r556
%r558 = call i64 @mul32x32L(i32 %r555, i32 %r557)
%r559 = zext i576 %r553 to i640
%r560 = zext i64 %r558 to i640
%r561 = shl i640 %r560, 576
%r562 = or i640 %r559, %r561
%r563 = getelementptr i32, i32* %r2, i32 10
%r564 = load i32, i32* %r563
%r565 = getelementptr i32, i32* %r2, i32 14
%r566 = load i32, i32* %r565
%r567 = call i64 @mul32x32L(i32 %r564, i32 %r566)
%r568 = zext i640 %r562 to i704
%r569 = zext i64 %r567 to i704
%r570 = shl i704 %r569, 640
%r571 = or i704 %r568, %r570
%r572 = zext i640 %r477 to i704
%r573 = shl i704 %r572, 32
%r574 = add i704 %r573, %r571
%r575 = load i32, i32* %r2
%r576 = getelementptr i32, i32* %r2, i32 3
%r577 = load i32, i32* %r576
%r578 = call i64 @mul32x32L(i32 %r575, i32 %r577)
%r579 = getelementptr i32, i32* %r2, i32 1
%r580 = load i32, i32* %r579
%r581 = getelementptr i32, i32* %r2, i32 4
%r582 = load i32, i32* %r581
%r583 = call i64 @mul32x32L(i32 %r580, i32 %r582)
%r584 = zext i64 %r578 to i128
%r585 = zext i64 %r583 to i128
%r586 = shl i128 %r585, 64
%r587 = or i128 %r584, %r586
%r588 = getelementptr i32, i32* %r2, i32 2
%r589 = load i32, i32* %r588
%r590 = getelementptr i32, i32* %r2, i32 5
%r591 = load i32, i32* %r590
%r592 = call i64 @mul32x32L(i32 %r589, i32 %r591)
%r593 = zext i128 %r587 to i192
%r594 = zext i64 %r592 to i192
%r595 = shl i192 %r594, 128
%r596 = or i192 %r593, %r595
%r597 = getelementptr i32, i32* %r2, i32 3
%r598 = load i32, i32* %r597
%r599 = getelementptr i32, i32* %r2, i32 6
%r600 = load i32, i32* %r599
%r601 = call i64 @mul32x32L(i32 %r598, i32 %r600)
%r602 = zext i192 %r596 to i256
%r603 = zext i64 %r601 to i256
%r604 = shl i256 %r603, 192
%r605 = or i256 %r602, %r604
%r606 = getelementptr i32, i32* %r2, i32 4
%r607 = load i32, i32* %r606
%r608 = getelementptr i32, i32* %r2, i32 7
%r609 = load i32, i32* %r608
%r610 = call i64 @mul32x32L(i32 %r607, i32 %r609)
%r611 = zext i256 %r605 to i320
%r612 = zext i64 %r610 to i320
%r613 = shl i320 %r612, 256
%r614 = or i320 %r611, %r613
%r615 = getelementptr i32, i32* %r2, i32 5
%r616 = load i32, i32* %r615
%r617 = getelementptr i32, i32* %r2, i32 8
%r618 = load i32, i32* %r617
%r619 = call i64 @mul32x32L(i32 %r616, i32 %r618)
%r620 = zext i320 %r614 to i384
%r621 = zext i64 %r619 to i384
%r622 = shl i384 %r621, 320
%r623 = or i384 %r620, %r622
%r624 = getelementptr i32, i32* %r2, i32 6
%r625 = load i32, i32* %r624
%r626 = getelementptr i32, i32* %r2, i32 9
%r627 = load i32, i32* %r626
%r628 = call i64 @mul32x32L(i32 %r625, i32 %r627)
%r629 = zext i384 %r623 to i448
%r630 = zext i64 %r628 to i448
%r631 = shl i448 %r630, 384
%r632 = or i448 %r629, %r631
%r633 = getelementptr i32, i32* %r2, i32 7
%r634 = load i32, i32* %r633
%r635 = getelementptr i32, i32* %r2, i32 10
%r636 = load i32, i32* %r635
%r637 = call i64 @mul32x32L(i32 %r634, i32 %r636)
%r638 = zext i448 %r632 to i512
%r639 = zext i64 %r637 to i512
%r640 = shl i512 %r639, 448
%r641 = or i512 %r638, %r640
%r642 = getelementptr i32, i32* %r2, i32 8
%r643 = load i32, i32* %r642
%r644 = getelementptr i32, i32* %r2, i32 11
%r645 = load i32, i32* %r644
%r646 = call i64 @mul32x32L(i32 %r643, i32 %r645)
%r647 = zext i512 %r641 to i576
%r648 = zext i64 %r646 to i576
%r649 = shl i576 %r648, 512
%r650 = or i576 %r647, %r649
%r651 = getelementptr i32, i32* %r2, i32 9
%r652 = load i32, i32* %r651
%r653 = getelementptr i32, i32* %r2, i32 12
%r654 = load i32, i32* %r653
%r655 = call i64 @mul32x32L(i32 %r652, i32 %r654)
%r656 = zext i576 %r650 to i640
%r657 = zext i64 %r655 to i640
%r658 = shl i640 %r657, 576
%r659 = or i640 %r656, %r658
%r660 = getelementptr i32, i32* %r2, i32 10
%r661 = load i32, i32* %r660
%r662 = getelementptr i32, i32* %r2, i32 13
%r663 = load i32, i32* %r662
%r664 = call i64 @mul32x32L(i32 %r661, i32 %r663)
%r665 = zext i640 %r659 to i704
%r666 = zext i64 %r664 to i704
%r667 = shl i704 %r666, 640
%r668 = or i704 %r665, %r667
%r669 = getelementptr i32, i32* %r2, i32 11
%r670 = load i32, i32* %r669
%r671 = getelementptr i32, i32* %r2, i32 14
%r672 = load i32, i32* %r671
%r673 = call i64 @mul32x32L(i32 %r670, i32 %r672)
%r674 = zext i704 %r668 to i768
%r675 = zext i64 %r673 to i768
%r676 = shl i768 %r675, 704
%r677 = or i768 %r674, %r676
%r678 = zext i704 %r574 to i768
%r679 = shl i768 %r678, 32
%r680 = add i768 %r679, %r677
%r681 = load i32, i32* %r2
%r682 = getelementptr i32, i32* %r2, i32 2
%r683 = load i32, i32* %r682
%r684 = call i64 @mul32x32L(i32 %r681, i32 %r683)
%r685 = getelementptr i32, i32* %r2, i32 1
%r686 = load i32, i32* %r685
%r687 = getelementptr i32, i32* %r2, i32 3
%r688 = load i32, i32* %r687
%r689 = call i64 @mul32x32L(i32 %r686, i32 %r688)
%r690 = zext i64 %r684 to i128
%r691 = zext i64 %r689 to i128
%r692 = shl i128 %r691, 64
%r693 = or i128 %r690, %r692
%r694 = getelementptr i32, i32* %r2, i32 2
%r695 = load i32, i32* %r694
%r696 = getelementptr i32, i32* %r2, i32 4
%r697 = load i32, i32* %r696
%r698 = call i64 @mul32x32L(i32 %r695, i32 %r697)
%r699 = zext i128 %r693 to i192
%r700 = zext i64 %r698 to i192
%r701 = shl i192 %r700, 128
%r702 = or i192 %r699, %r701
%r703 = getelementptr i32, i32* %r2, i32 3
%r704 = load i32, i32* %r703
%r705 = getelementptr i32, i32* %r2, i32 5
%r706 = load i32, i32* %r705
%r707 = call i64 @mul32x32L(i32 %r704, i32 %r706)
%r708 = zext i192 %r702 to i256
%r709 = zext i64 %r707 to i256
%r710 = shl i256 %r709, 192
%r711 = or i256 %r708, %r710
%r712 = getelementptr i32, i32* %r2, i32 4
%r713 = load i32, i32* %r712
%r714 = getelementptr i32, i32* %r2, i32 6
%r715 = load i32, i32* %r714
%r716 = call i64 @mul32x32L(i32 %r713, i32 %r715)
%r717 = zext i256 %r711 to i320
%r718 = zext i64 %r716 to i320
%r719 = shl i320 %r718, 256
%r720 = or i320 %r717, %r719
%r721 = getelementptr i32, i32* %r2, i32 5
%r722 = load i32, i32* %r721
%r723 = getelementptr i32, i32* %r2, i32 7
%r724 = load i32, i32* %r723
%r725 = call i64 @mul32x32L(i32 %r722, i32 %r724)
%r726 = zext i320 %r720 to i384
%r727 = zext i64 %r725 to i384
%r728 = shl i384 %r727, 320
%r729 = or i384 %r726, %r728
%r730 = getelementptr i32, i32* %r2, i32 6
%r731 = load i32, i32* %r730
%r732 = getelementptr i32, i32* %r2, i32 8
%r733 = load i32, i32* %r732
%r734 = call i64 @mul32x32L(i32 %r731, i32 %r733)
%r735 = zext i384 %r729 to i448
%r736 = zext i64 %r734 to i448
%r737 = shl i448 %r736, 384
%r738 = or i448 %r735, %r737
%r739 = getelementptr i32, i32* %r2, i32 7
%r740 = load i32, i32* %r739
%r741 = getelementptr i32, i32* %r2, i32 9
%r742 = load i32, i32* %r741
%r743 = call i64 @mul32x32L(i32 %r740, i32 %r742)
%r744 = zext i448 %r738 to i512
%r745 = zext i64 %r743 to i512
%r746 = shl i512 %r745, 448
%r747 = or i512 %r744, %r746
%r748 = getelementptr i32, i32* %r2, i32 8
%r749 = load i32, i32* %r748
%r750 = getelementptr i32, i32* %r2, i32 10
%r751 = load i32, i32* %r750
%r752 = call i64 @mul32x32L(i32 %r749, i32 %r751)
%r753 = zext i512 %r747 to i576
%r754 = zext i64 %r752 to i576
%r755 = shl i576 %r754, 512
%r756 = or i576 %r753, %r755
%r757 = getelementptr i32, i32* %r2, i32 9
%r758 = load i32, i32* %r757
%r759 = getelementptr i32, i32* %r2, i32 11
%r760 = load i32, i32* %r759
%r761 = call i64 @mul32x32L(i32 %r758, i32 %r760)
%r762 = zext i576 %r756 to i640
%r763 = zext i64 %r761 to i640
%r764 = shl i640 %r763, 576
%r765 = or i640 %r762, %r764
%r766 = getelementptr i32, i32* %r2, i32 10
%r767 = load i32, i32* %r766
%r768 = getelementptr i32, i32* %r2, i32 12
%r769 = load i32, i32* %r768
%r770 = call i64 @mul32x32L(i32 %r767, i32 %r769)
%r771 = zext i640 %r765 to i704
%r772 = zext i64 %r770 to i704
%r773 = shl i704 %r772, 640
%r774 = or i704 %r771, %r773
%r775 = getelementptr i32, i32* %r2, i32 11
%r776 = load i32, i32* %r775
%r777 = getelementptr i32, i32* %r2, i32 13
%r778 = load i32, i32* %r777
%r779 = call i64 @mul32x32L(i32 %r776, i32 %r778)
%r780 = zext i704 %r774 to i768
%r781 = zext i64 %r779 to i768
%r782 = shl i768 %r781, 704
%r783 = or i768 %r780, %r782
%r784 = getelementptr i32, i32* %r2, i32 12
%r785 = load i32, i32* %r784
%r786 = getelementptr i32, i32* %r2, i32 14
%r787 = load i32, i32* %r786
%r788 = call i64 @mul32x32L(i32 %r785, i32 %r787)
%r789 = zext i768 %r783 to i832
%r790 = zext i64 %r788 to i832
%r791 = shl i832 %r790, 768
%r792 = or i832 %r789, %r791
%r793 = zext i768 %r680 to i832
%r794 = shl i832 %r793, 32
%r795 = add i832 %r794, %r792
%r796 = load i32, i32* %r2
%r797 = getelementptr i32, i32* %r2, i32 1
%r798 = load i32, i32* %r797
%r799 = call i64 @mul32x32L(i32 %r796, i32 %r798)
%r800 = getelementptr i32, i32* %r2, i32 1
%r801 = load i32, i32* %r800
%r802 = getelementptr i32, i32* %r2, i32 2
%r803 = load i32, i32* %r802
%r804 = call i64 @mul32x32L(i32 %r801, i32 %r803)
%r805 = zext i64 %r799 to i128
%r806 = zext i64 %r804 to i128
%r807 = shl i128 %r806, 64
%r808 = or i128 %r805, %r807
%r809 = getelementptr i32, i32* %r2, i32 2
%r810 = load i32, i32* %r809
%r811 = getelementptr i32, i32* %r2, i32 3
%r812 = load i32, i32* %r811
%r813 = call i64 @mul32x32L(i32 %r810, i32 %r812)
%r814 = zext i128 %r808 to i192
%r815 = zext i64 %r813 to i192
%r816 = shl i192 %r815, 128
%r817 = or i192 %r814, %r816
%r818 = getelementptr i32, i32* %r2, i32 3
%r819 = load i32, i32* %r818
%r820 = getelementptr i32, i32* %r2, i32 4
%r821 = load i32, i32* %r820
%r822 = call i64 @mul32x32L(i32 %r819, i32 %r821)
%r823 = zext i192 %r817 to i256
%r824 = zext i64 %r822 to i256
%r825 = shl i256 %r824, 192
%r826 = or i256 %r823, %r825
%r827 = getelementptr i32, i32* %r2, i32 4
%r828 = load i32, i32* %r827
%r829 = getelementptr i32, i32* %r2, i32 5
%r830 = load i32, i32* %r829
%r831 = call i64 @mul32x32L(i32 %r828, i32 %r830)
%r832 = zext i256 %r826 to i320
%r833 = zext i64 %r831 to i320
%r834 = shl i320 %r833, 256
%r835 = or i320 %r832, %r834
%r836 = getelementptr i32, i32* %r2, i32 5
%r837 = load i32, i32* %r836
%r838 = getelementptr i32, i32* %r2, i32 6
%r839 = load i32, i32* %r838
%r840 = call i64 @mul32x32L(i32 %r837, i32 %r839)
%r841 = zext i320 %r835 to i384
%r842 = zext i64 %r840 to i384
%r843 = shl i384 %r842, 320
%r844 = or i384 %r841, %r843
%r845 = getelementptr i32, i32* %r2, i32 6
%r846 = load i32, i32* %r845
%r847 = getelementptr i32, i32* %r2, i32 7
%r848 = load i32, i32* %r847
%r849 = call i64 @mul32x32L(i32 %r846, i32 %r848)
%r850 = zext i384 %r844 to i448
%r851 = zext i64 %r849 to i448
%r852 = shl i448 %r851, 384
%r853 = or i448 %r850, %r852
%r854 = getelementptr i32, i32* %r2, i32 7
%r855 = load i32, i32* %r854
%r856 = getelementptr i32, i32* %r2, i32 8
%r857 = load i32, i32* %r856
%r858 = call i64 @mul32x32L(i32 %r855, i32 %r857)
%r859 = zext i448 %r853 to i512
%r860 = zext i64 %r858 to i512
%r861 = shl i512 %r860, 448
%r862 = or i512 %r859, %r861
%r863 = getelementptr i32, i32* %r2, i32 8
%r864 = load i32, i32* %r863
%r865 = getelementptr i32, i32* %r2, i32 9
%r866 = load i32, i32* %r865
%r867 = call i64 @mul32x32L(i32 %r864, i32 %r866)
%r868 = zext i512 %r862 to i576
%r869 = zext i64 %r867 to i576
%r870 = shl i576 %r869, 512
%r871 = or i576 %r868, %r870
%r872 = getelementptr i32, i32* %r2, i32 9
%r873 = load i32, i32* %r872
%r874 = getelementptr i32, i32* %r2, i32 10
%r875 = load i32, i32* %r874
%r876 = call i64 @mul32x32L(i32 %r873, i32 %r875)
%r877 = zext i576 %r871 to i640
%r878 = zext i64 %r876 to i640
%r879 = shl i640 %r878, 576
%r880 = or i640 %r877, %r879
%r881 = getelementptr i32, i32* %r2, i32 10
%r882 = load i32, i32* %r881
%r883 = getelementptr i32, i32* %r2, i32 11
%r884 = load i32, i32* %r883
%r885 = call i64 @mul32x32L(i32 %r882, i32 %r884)
%r886 = zext i640 %r880 to i704
%r887 = zext i64 %r885 to i704
%r888 = shl i704 %r887, 640
%r889 = or i704 %r886, %r888
%r890 = getelementptr i32, i32* %r2, i32 11
%r891 = load i32, i32* %r890
%r892 = getelementptr i32, i32* %r2, i32 12
%r893 = load i32, i32* %r892
%r894 = call i64 @mul32x32L(i32 %r891, i32 %r893)
%r895 = zext i704 %r889 to i768
%r896 = zext i64 %r894 to i768
%r897 = shl i768 %r896, 704
%r898 = or i768 %r895, %r897
%r899 = getelementptr i32, i32* %r2, i32 12
%r900 = load i32, i32* %r899
%r901 = getelementptr i32, i32* %r2, i32 13
%r902 = load i32, i32* %r901
%r903 = call i64 @mul32x32L(i32 %r900, i32 %r902)
%r904 = zext i768 %r898 to i832
%r905 = zext i64 %r903 to i832
%r906 = shl i832 %r905, 768
%r907 = or i832 %r904, %r906
%r908 = getelementptr i32, i32* %r2, i32 13
%r909 = load i32, i32* %r908
%r910 = getelementptr i32, i32* %r2, i32 14
%r911 = load i32, i32* %r910
%r912 = call i64 @mul32x32L(i32 %r909, i32 %r911)
%r913 = zext i832 %r907 to i896
%r914 = zext i64 %r912 to i896
%r915 = shl i896 %r914, 832
%r916 = or i896 %r913, %r915
%r917 = zext i832 %r795 to i896
%r918 = shl i896 %r917, 32
%r919 = add i896 %r918, %r916
%r920 = zext i64 %r6 to i928
%r921 = getelementptr i32, i32* %r2, i32 1
%r922 = load i32, i32* %r921
%r923 = call i64 @mul32x32L(i32 %r922, i32 %r922)
%r924 = zext i64 %r923 to i928
%r925 = shl i928 %r924, 32
%r926 = or i928 %r920, %r925
%r927 = getelementptr i32, i32* %r2, i32 2
%r928 = load i32, i32* %r927
%r929 = call i64 @mul32x32L(i32 %r928, i32 %r928)
%r930 = zext i64 %r929 to i928
%r931 = shl i928 %r930, 96
%r932 = or i928 %r926, %r931
%r933 = getelementptr i32, i32* %r2, i32 3
%r934 = load i32, i32* %r933
%r935 = call i64 @mul32x32L(i32 %r934, i32 %r934)
%r936 = zext i64 %r935 to i928
%r937 = shl i928 %r936, 160
%r938 = or i928 %r932, %r937
%r939 = getelementptr i32, i32* %r2, i32 4
%r940 = load i32, i32* %r939
%r941 = call i64 @mul32x32L(i32 %r940, i32 %r940)
%r942 = zext i64 %r941 to i928
%r943 = shl i928 %r942, 224
%r944 = or i928 %r938, %r943
%r945 = getelementptr i32, i32* %r2, i32 5
%r946 = load i32, i32* %r945
%r947 = call i64 @mul32x32L(i32 %r946, i32 %r946)
%r948 = zext i64 %r947 to i928
%r949 = shl i928 %r948, 288
%r950 = or i928 %r944, %r949
%r951 = getelementptr i32, i32* %r2, i32 6
%r952 = load i32, i32* %r951
%r953 = call i64 @mul32x32L(i32 %r952, i32 %r952)
%r954 = zext i64 %r953 to i928
%r955 = shl i928 %r954, 352
%r956 = or i928 %r950, %r955
%r957 = getelementptr i32, i32* %r2, i32 7
%r958 = load i32, i32* %r957
%r959 = call i64 @mul32x32L(i32 %r958, i32 %r958)
%r960 = zext i64 %r959 to i928
%r961 = shl i928 %r960, 416
%r962 = or i928 %r956, %r961
%r963 = getelementptr i32, i32* %r2, i32 8
%r964 = load i32, i32* %r963
%r965 = call i64 @mul32x32L(i32 %r964, i32 %r964)
%r966 = zext i64 %r965 to i928
%r967 = shl i928 %r966, 480
%r968 = or i928 %r962, %r967
%r969 = getelementptr i32, i32* %r2, i32 9
%r970 = load i32, i32* %r969
%r971 = call i64 @mul32x32L(i32 %r970, i32 %r970)
%r972 = zext i64 %r971 to i928
%r973 = shl i928 %r972, 544
%r974 = or i928 %r968, %r973
%r975 = getelementptr i32, i32* %r2, i32 10
%r976 = load i32, i32* %r975
%r977 = call i64 @mul32x32L(i32 %r976, i32 %r976)
%r978 = zext i64 %r977 to i928
%r979 = shl i928 %r978, 608
%r980 = or i928 %r974, %r979
%r981 = getelementptr i32, i32* %r2, i32 11
%r982 = load i32, i32* %r981
%r983 = call i64 @mul32x32L(i32 %r982, i32 %r982)
%r984 = zext i64 %r983 to i928
%r985 = shl i928 %r984, 672
%r986 = or i928 %r980, %r985
%r987 = getelementptr i32, i32* %r2, i32 12
%r988 = load i32, i32* %r987
%r989 = call i64 @mul32x32L(i32 %r988, i32 %r988)
%r990 = zext i64 %r989 to i928
%r991 = shl i928 %r990, 736
%r992 = or i928 %r986, %r991
%r993 = getelementptr i32, i32* %r2, i32 13
%r994 = load i32, i32* %r993
%r995 = call i64 @mul32x32L(i32 %r994, i32 %r994)
%r996 = zext i64 %r995 to i928
%r997 = shl i928 %r996, 800
%r998 = or i928 %r992, %r997
%r999 = getelementptr i32, i32* %r2, i32 14
%r1000 = load i32, i32* %r999
%r1001 = call i64 @mul32x32L(i32 %r1000, i32 %r1000)
%r1002 = zext i64 %r1001 to i928
%r1003 = shl i928 %r1002, 864
%r1004 = or i928 %r998, %r1003
%r1005 = zext i896 %r919 to i928
%r1006 = add i928 %r1005, %r1005
%r1007 = add i928 %r1004, %r1006
%r1008 = getelementptr i32, i32* %r1, i32 1
%r1009 = bitcast i32* %r1008 to i928*
store i928 %r1007, i928* %r1009
ret void
}
define i544 @mulUnit_inner512(i32* noalias %r2, i32 %r3)
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
define i32 @mclb_mulUnit16(i32* noalias %r1, i32* noalias %r2, i32 %r3)
{
%r5 = call i544 @mulUnit_inner512(i32* %r2, i32 %r3)
%r6 = trunc i544 %r5 to i512
%r7 = bitcast i32* %r1 to i512*
store i512 %r6, i512* %r7
%r8 = lshr i544 %r5, 512
%r9 = trunc i544 %r8 to i32
ret i32 %r9
}
define i32 @mclb_mulUnitAdd16(i32* noalias %r1, i32* noalias %r2, i32 %r3)
{
%r5 = call i64 @mulPos32x32(i32* %r2, i32 %r3, i32 0)
%r6 = trunc i64 %r5 to i32
%r7 = call i32 @extractHigh32(i64 %r5)
%r8 = call i64 @mulPos32x32(i32* %r2, i32 %r3, i32 1)
%r9 = trunc i64 %r8 to i32
%r10 = call i32 @extractHigh32(i64 %r8)
%r11 = call i64 @mulPos32x32(i32* %r2, i32 %r3, i32 2)
%r12 = trunc i64 %r11 to i32
%r13 = call i32 @extractHigh32(i64 %r11)
%r14 = call i64 @mulPos32x32(i32* %r2, i32 %r3, i32 3)
%r15 = trunc i64 %r14 to i32
%r16 = call i32 @extractHigh32(i64 %r14)
%r17 = call i64 @mulPos32x32(i32* %r2, i32 %r3, i32 4)
%r18 = trunc i64 %r17 to i32
%r19 = call i32 @extractHigh32(i64 %r17)
%r20 = call i64 @mulPos32x32(i32* %r2, i32 %r3, i32 5)
%r21 = trunc i64 %r20 to i32
%r22 = call i32 @extractHigh32(i64 %r20)
%r23 = call i64 @mulPos32x32(i32* %r2, i32 %r3, i32 6)
%r24 = trunc i64 %r23 to i32
%r25 = call i32 @extractHigh32(i64 %r23)
%r26 = call i64 @mulPos32x32(i32* %r2, i32 %r3, i32 7)
%r27 = trunc i64 %r26 to i32
%r28 = call i32 @extractHigh32(i64 %r26)
%r29 = call i64 @mulPos32x32(i32* %r2, i32 %r3, i32 8)
%r30 = trunc i64 %r29 to i32
%r31 = call i32 @extractHigh32(i64 %r29)
%r32 = call i64 @mulPos32x32(i32* %r2, i32 %r3, i32 9)
%r33 = trunc i64 %r32 to i32
%r34 = call i32 @extractHigh32(i64 %r32)
%r35 = call i64 @mulPos32x32(i32* %r2, i32 %r3, i32 10)
%r36 = trunc i64 %r35 to i32
%r37 = call i32 @extractHigh32(i64 %r35)
%r38 = call i64 @mulPos32x32(i32* %r2, i32 %r3, i32 11)
%r39 = trunc i64 %r38 to i32
%r40 = call i32 @extractHigh32(i64 %r38)
%r41 = call i64 @mulPos32x32(i32* %r2, i32 %r3, i32 12)
%r42 = trunc i64 %r41 to i32
%r43 = call i32 @extractHigh32(i64 %r41)
%r44 = call i64 @mulPos32x32(i32* %r2, i32 %r3, i32 13)
%r45 = trunc i64 %r44 to i32
%r46 = call i32 @extractHigh32(i64 %r44)
%r47 = call i64 @mulPos32x32(i32* %r2, i32 %r3, i32 14)
%r48 = trunc i64 %r47 to i32
%r49 = call i32 @extractHigh32(i64 %r47)
%r50 = call i64 @mulPos32x32(i32* %r2, i32 %r3, i32 15)
%r51 = trunc i64 %r50 to i32
%r52 = call i32 @extractHigh32(i64 %r50)
%r53 = zext i32 %r6 to i64
%r54 = zext i32 %r9 to i64
%r55 = shl i64 %r54, 32
%r56 = or i64 %r53, %r55
%r57 = zext i64 %r56 to i96
%r58 = zext i32 %r12 to i96
%r59 = shl i96 %r58, 64
%r60 = or i96 %r57, %r59
%r61 = zext i96 %r60 to i128
%r62 = zext i32 %r15 to i128
%r63 = shl i128 %r62, 96
%r64 = or i128 %r61, %r63
%r65 = zext i128 %r64 to i160
%r66 = zext i32 %r18 to i160
%r67 = shl i160 %r66, 128
%r68 = or i160 %r65, %r67
%r69 = zext i160 %r68 to i192
%r70 = zext i32 %r21 to i192
%r71 = shl i192 %r70, 160
%r72 = or i192 %r69, %r71
%r73 = zext i192 %r72 to i224
%r74 = zext i32 %r24 to i224
%r75 = shl i224 %r74, 192
%r76 = or i224 %r73, %r75
%r77 = zext i224 %r76 to i256
%r78 = zext i32 %r27 to i256
%r79 = shl i256 %r78, 224
%r80 = or i256 %r77, %r79
%r81 = zext i256 %r80 to i288
%r82 = zext i32 %r30 to i288
%r83 = shl i288 %r82, 256
%r84 = or i288 %r81, %r83
%r85 = zext i288 %r84 to i320
%r86 = zext i32 %r33 to i320
%r87 = shl i320 %r86, 288
%r88 = or i320 %r85, %r87
%r89 = zext i320 %r88 to i352
%r90 = zext i32 %r36 to i352
%r91 = shl i352 %r90, 320
%r92 = or i352 %r89, %r91
%r93 = zext i352 %r92 to i384
%r94 = zext i32 %r39 to i384
%r95 = shl i384 %r94, 352
%r96 = or i384 %r93, %r95
%r97 = zext i384 %r96 to i416
%r98 = zext i32 %r42 to i416
%r99 = shl i416 %r98, 384
%r100 = or i416 %r97, %r99
%r101 = zext i416 %r100 to i448
%r102 = zext i32 %r45 to i448
%r103 = shl i448 %r102, 416
%r104 = or i448 %r101, %r103
%r105 = zext i448 %r104 to i480
%r106 = zext i32 %r48 to i480
%r107 = shl i480 %r106, 448
%r108 = or i480 %r105, %r107
%r109 = zext i480 %r108 to i512
%r110 = zext i32 %r51 to i512
%r111 = shl i512 %r110, 480
%r112 = or i512 %r109, %r111
%r113 = zext i32 %r7 to i64
%r114 = zext i32 %r10 to i64
%r115 = shl i64 %r114, 32
%r116 = or i64 %r113, %r115
%r117 = zext i64 %r116 to i96
%r118 = zext i32 %r13 to i96
%r119 = shl i96 %r118, 64
%r120 = or i96 %r117, %r119
%r121 = zext i96 %r120 to i128
%r122 = zext i32 %r16 to i128
%r123 = shl i128 %r122, 96
%r124 = or i128 %r121, %r123
%r125 = zext i128 %r124 to i160
%r126 = zext i32 %r19 to i160
%r127 = shl i160 %r126, 128
%r128 = or i160 %r125, %r127
%r129 = zext i160 %r128 to i192
%r130 = zext i32 %r22 to i192
%r131 = shl i192 %r130, 160
%r132 = or i192 %r129, %r131
%r133 = zext i192 %r132 to i224
%r134 = zext i32 %r25 to i224
%r135 = shl i224 %r134, 192
%r136 = or i224 %r133, %r135
%r137 = zext i224 %r136 to i256
%r138 = zext i32 %r28 to i256
%r139 = shl i256 %r138, 224
%r140 = or i256 %r137, %r139
%r141 = zext i256 %r140 to i288
%r142 = zext i32 %r31 to i288
%r143 = shl i288 %r142, 256
%r144 = or i288 %r141, %r143
%r145 = zext i288 %r144 to i320
%r146 = zext i32 %r34 to i320
%r147 = shl i320 %r146, 288
%r148 = or i320 %r145, %r147
%r149 = zext i320 %r148 to i352
%r150 = zext i32 %r37 to i352
%r151 = shl i352 %r150, 320
%r152 = or i352 %r149, %r151
%r153 = zext i352 %r152 to i384
%r154 = zext i32 %r40 to i384
%r155 = shl i384 %r154, 352
%r156 = or i384 %r153, %r155
%r157 = zext i384 %r156 to i416
%r158 = zext i32 %r43 to i416
%r159 = shl i416 %r158, 384
%r160 = or i416 %r157, %r159
%r161 = zext i416 %r160 to i448
%r162 = zext i32 %r46 to i448
%r163 = shl i448 %r162, 416
%r164 = or i448 %r161, %r163
%r165 = zext i448 %r164 to i480
%r166 = zext i32 %r49 to i480
%r167 = shl i480 %r166, 448
%r168 = or i480 %r165, %r167
%r169 = zext i480 %r168 to i512
%r170 = zext i32 %r52 to i512
%r171 = shl i512 %r170, 480
%r172 = or i512 %r169, %r171
%r173 = zext i512 %r112 to i544
%r174 = zext i512 %r172 to i544
%r175 = shl i544 %r174, 32
%r176 = add i544 %r173, %r175
%r177 = bitcast i32* %r1 to i512*
%r178 = load i512, i512* %r177
%r179 = zext i512 %r178 to i544
%r180 = add i544 %r176, %r179
%r181 = trunc i544 %r180 to i512
%r182 = bitcast i32* %r1 to i512*
store i512 %r181, i512* %r182
%r183 = lshr i544 %r180, 512
%r184 = trunc i544 %r183 to i32
ret i32 %r184
}
define void @mclb_mul16(i32* noalias %r1, i32* noalias %r2, i32* noalias %r3)
{
%r4 = getelementptr i32, i32* %r2, i32 8
%r5 = getelementptr i32, i32* %r3, i32 8
%r6 = getelementptr i32, i32* %r1, i32 16
call void @mclb_mul8(i32* %r1, i32* %r2, i32* %r3)
call void @mclb_mul8(i32* %r6, i32* %r4, i32* %r5)
%r7 = bitcast i32* %r4 to i256*
%r8 = load i256, i256* %r7
%r9 = zext i256 %r8 to i288
%r10 = bitcast i32* %r2 to i256*
%r11 = load i256, i256* %r10
%r12 = zext i256 %r11 to i288
%r13 = bitcast i32* %r5 to i256*
%r14 = load i256, i256* %r13
%r15 = zext i256 %r14 to i288
%r16 = bitcast i32* %r3 to i256*
%r17 = load i256, i256* %r16
%r18 = zext i256 %r17 to i288
%r19 = add i288 %r9, %r12
%r20 = add i288 %r15, %r18
%r21 = alloca i32, i32 16
%r22 = trunc i288 %r19 to i256
%r23 = trunc i288 %r20 to i256
%r24 = lshr i288 %r19, 256
%r25 = trunc i288 %r24 to i1
%r26 = lshr i288 %r20, 256
%r27 = trunc i288 %r26 to i1
%r28 = and i1 %r25, %r27
%r29 = select i1 %r25, i256 %r23, i256 0
%r30 = select i1 %r27, i256 %r22, i256 0
%r31 = alloca i32, i32 8
%r32 = alloca i32, i32 8
%r33 = bitcast i32* %r31 to i256*
store i256 %r22, i256* %r33
%r34 = bitcast i32* %r32 to i256*
store i256 %r23, i256* %r34
call void @mclb_mul8(i32* %r21, i32* %r31, i32* %r32)
%r35 = bitcast i32* %r21 to i512*
%r36 = load i512, i512* %r35
%r37 = zext i512 %r36 to i544
%r38 = zext i1 %r28 to i544
%r39 = shl i544 %r38, 512
%r40 = or i544 %r37, %r39
%r41 = zext i256 %r29 to i544
%r42 = zext i256 %r30 to i544
%r43 = shl i544 %r41, 256
%r44 = shl i544 %r42, 256
%r45 = add i544 %r40, %r43
%r46 = add i544 %r45, %r44
%r47 = bitcast i32* %r1 to i512*
%r48 = load i512, i512* %r47
%r49 = zext i512 %r48 to i544
%r50 = sub i544 %r46, %r49
%r51 = getelementptr i32, i32* %r1, i32 16
%r52 = bitcast i32* %r51 to i512*
%r53 = load i512, i512* %r52
%r54 = zext i512 %r53 to i544
%r55 = sub i544 %r50, %r54
%r56 = zext i544 %r55 to i768
%r57 = getelementptr i32, i32* %r1, i32 8
%r58 = bitcast i32* %r57 to i768*
%r59 = load i768, i768* %r58
%r60 = add i768 %r56, %r59
%r61 = getelementptr i32, i32* %r1, i32 8
%r62 = bitcast i32* %r61 to i768*
store i768 %r60, i768* %r62
ret void
}
define void @mclb_sqr16(i32* noalias %r1, i32* noalias %r2)
{
%r3 = getelementptr i32, i32* %r2, i32 8
%r4 = getelementptr i32, i32* %r1, i32 16
%r5 = alloca i32, i32 16
call void @mclb_mul8(i32* %r5, i32* %r2, i32* %r3)
call void @mclb_sqr8(i32* %r1, i32* %r2)
call void @mclb_sqr8(i32* %r4, i32* %r3)
%r6 = bitcast i32* %r5 to i512*
%r7 = load i512, i512* %r6
%r8 = zext i512 %r7 to i544
%r9 = add i544 %r8, %r8
%r10 = zext i544 %r9 to i768
%r11 = getelementptr i32, i32* %r1, i32 8
%r12 = bitcast i32* %r11 to i768*
%r13 = load i768, i768* %r12
%r14 = add i768 %r13, %r10
%r15 = bitcast i32* %r11 to i768*
store i768 %r14, i768* %r15
ret void
}
define i576 @mulUnit_inner544(i32* noalias %r2, i32 %r3)
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
%r52 = call i64 @mulPos32x32(i32* %r2, i32 %r3, i32 16)
%r53 = trunc i64 %r52 to i32
%r54 = call i32 @extractHigh32(i64 %r52)
%r55 = zext i32 %r5 to i64
%r56 = zext i32 %r8 to i64
%r57 = shl i64 %r56, 32
%r58 = or i64 %r55, %r57
%r59 = zext i64 %r58 to i96
%r60 = zext i32 %r11 to i96
%r61 = shl i96 %r60, 64
%r62 = or i96 %r59, %r61
%r63 = zext i96 %r62 to i128
%r64 = zext i32 %r14 to i128
%r65 = shl i128 %r64, 96
%r66 = or i128 %r63, %r65
%r67 = zext i128 %r66 to i160
%r68 = zext i32 %r17 to i160
%r69 = shl i160 %r68, 128
%r70 = or i160 %r67, %r69
%r71 = zext i160 %r70 to i192
%r72 = zext i32 %r20 to i192
%r73 = shl i192 %r72, 160
%r74 = or i192 %r71, %r73
%r75 = zext i192 %r74 to i224
%r76 = zext i32 %r23 to i224
%r77 = shl i224 %r76, 192
%r78 = or i224 %r75, %r77
%r79 = zext i224 %r78 to i256
%r80 = zext i32 %r26 to i256
%r81 = shl i256 %r80, 224
%r82 = or i256 %r79, %r81
%r83 = zext i256 %r82 to i288
%r84 = zext i32 %r29 to i288
%r85 = shl i288 %r84, 256
%r86 = or i288 %r83, %r85
%r87 = zext i288 %r86 to i320
%r88 = zext i32 %r32 to i320
%r89 = shl i320 %r88, 288
%r90 = or i320 %r87, %r89
%r91 = zext i320 %r90 to i352
%r92 = zext i32 %r35 to i352
%r93 = shl i352 %r92, 320
%r94 = or i352 %r91, %r93
%r95 = zext i352 %r94 to i384
%r96 = zext i32 %r38 to i384
%r97 = shl i384 %r96, 352
%r98 = or i384 %r95, %r97
%r99 = zext i384 %r98 to i416
%r100 = zext i32 %r41 to i416
%r101 = shl i416 %r100, 384
%r102 = or i416 %r99, %r101
%r103 = zext i416 %r102 to i448
%r104 = zext i32 %r44 to i448
%r105 = shl i448 %r104, 416
%r106 = or i448 %r103, %r105
%r107 = zext i448 %r106 to i480
%r108 = zext i32 %r47 to i480
%r109 = shl i480 %r108, 448
%r110 = or i480 %r107, %r109
%r111 = zext i480 %r110 to i512
%r112 = zext i32 %r50 to i512
%r113 = shl i512 %r112, 480
%r114 = or i512 %r111, %r113
%r115 = zext i512 %r114 to i544
%r116 = zext i32 %r53 to i544
%r117 = shl i544 %r116, 512
%r118 = or i544 %r115, %r117
%r119 = zext i32 %r6 to i64
%r120 = zext i32 %r9 to i64
%r121 = shl i64 %r120, 32
%r122 = or i64 %r119, %r121
%r123 = zext i64 %r122 to i96
%r124 = zext i32 %r12 to i96
%r125 = shl i96 %r124, 64
%r126 = or i96 %r123, %r125
%r127 = zext i96 %r126 to i128
%r128 = zext i32 %r15 to i128
%r129 = shl i128 %r128, 96
%r130 = or i128 %r127, %r129
%r131 = zext i128 %r130 to i160
%r132 = zext i32 %r18 to i160
%r133 = shl i160 %r132, 128
%r134 = or i160 %r131, %r133
%r135 = zext i160 %r134 to i192
%r136 = zext i32 %r21 to i192
%r137 = shl i192 %r136, 160
%r138 = or i192 %r135, %r137
%r139 = zext i192 %r138 to i224
%r140 = zext i32 %r24 to i224
%r141 = shl i224 %r140, 192
%r142 = or i224 %r139, %r141
%r143 = zext i224 %r142 to i256
%r144 = zext i32 %r27 to i256
%r145 = shl i256 %r144, 224
%r146 = or i256 %r143, %r145
%r147 = zext i256 %r146 to i288
%r148 = zext i32 %r30 to i288
%r149 = shl i288 %r148, 256
%r150 = or i288 %r147, %r149
%r151 = zext i288 %r150 to i320
%r152 = zext i32 %r33 to i320
%r153 = shl i320 %r152, 288
%r154 = or i320 %r151, %r153
%r155 = zext i320 %r154 to i352
%r156 = zext i32 %r36 to i352
%r157 = shl i352 %r156, 320
%r158 = or i352 %r155, %r157
%r159 = zext i352 %r158 to i384
%r160 = zext i32 %r39 to i384
%r161 = shl i384 %r160, 352
%r162 = or i384 %r159, %r161
%r163 = zext i384 %r162 to i416
%r164 = zext i32 %r42 to i416
%r165 = shl i416 %r164, 384
%r166 = or i416 %r163, %r165
%r167 = zext i416 %r166 to i448
%r168 = zext i32 %r45 to i448
%r169 = shl i448 %r168, 416
%r170 = or i448 %r167, %r169
%r171 = zext i448 %r170 to i480
%r172 = zext i32 %r48 to i480
%r173 = shl i480 %r172, 448
%r174 = or i480 %r171, %r173
%r175 = zext i480 %r174 to i512
%r176 = zext i32 %r51 to i512
%r177 = shl i512 %r176, 480
%r178 = or i512 %r175, %r177
%r179 = zext i512 %r178 to i544
%r180 = zext i32 %r54 to i544
%r181 = shl i544 %r180, 512
%r182 = or i544 %r179, %r181
%r183 = zext i544 %r118 to i576
%r184 = zext i544 %r182 to i576
%r185 = shl i576 %r184, 32
%r186 = add i576 %r183, %r185
ret i576 %r186
}
define i32 @mclb_mulUnit17(i32* noalias %r1, i32* noalias %r2, i32 %r3)
{
%r5 = call i576 @mulUnit_inner544(i32* %r2, i32 %r3)
%r6 = trunc i576 %r5 to i544
%r7 = bitcast i32* %r1 to i544*
store i544 %r6, i544* %r7
%r8 = lshr i576 %r5, 544
%r9 = trunc i576 %r8 to i32
ret i32 %r9
}
define i32 @mclb_mulUnitAdd17(i32* noalias %r1, i32* noalias %r2, i32 %r3)
{
%r5 = call i64 @mulPos32x32(i32* %r2, i32 %r3, i32 0)
%r6 = trunc i64 %r5 to i32
%r7 = call i32 @extractHigh32(i64 %r5)
%r8 = call i64 @mulPos32x32(i32* %r2, i32 %r3, i32 1)
%r9 = trunc i64 %r8 to i32
%r10 = call i32 @extractHigh32(i64 %r8)
%r11 = call i64 @mulPos32x32(i32* %r2, i32 %r3, i32 2)
%r12 = trunc i64 %r11 to i32
%r13 = call i32 @extractHigh32(i64 %r11)
%r14 = call i64 @mulPos32x32(i32* %r2, i32 %r3, i32 3)
%r15 = trunc i64 %r14 to i32
%r16 = call i32 @extractHigh32(i64 %r14)
%r17 = call i64 @mulPos32x32(i32* %r2, i32 %r3, i32 4)
%r18 = trunc i64 %r17 to i32
%r19 = call i32 @extractHigh32(i64 %r17)
%r20 = call i64 @mulPos32x32(i32* %r2, i32 %r3, i32 5)
%r21 = trunc i64 %r20 to i32
%r22 = call i32 @extractHigh32(i64 %r20)
%r23 = call i64 @mulPos32x32(i32* %r2, i32 %r3, i32 6)
%r24 = trunc i64 %r23 to i32
%r25 = call i32 @extractHigh32(i64 %r23)
%r26 = call i64 @mulPos32x32(i32* %r2, i32 %r3, i32 7)
%r27 = trunc i64 %r26 to i32
%r28 = call i32 @extractHigh32(i64 %r26)
%r29 = call i64 @mulPos32x32(i32* %r2, i32 %r3, i32 8)
%r30 = trunc i64 %r29 to i32
%r31 = call i32 @extractHigh32(i64 %r29)
%r32 = call i64 @mulPos32x32(i32* %r2, i32 %r3, i32 9)
%r33 = trunc i64 %r32 to i32
%r34 = call i32 @extractHigh32(i64 %r32)
%r35 = call i64 @mulPos32x32(i32* %r2, i32 %r3, i32 10)
%r36 = trunc i64 %r35 to i32
%r37 = call i32 @extractHigh32(i64 %r35)
%r38 = call i64 @mulPos32x32(i32* %r2, i32 %r3, i32 11)
%r39 = trunc i64 %r38 to i32
%r40 = call i32 @extractHigh32(i64 %r38)
%r41 = call i64 @mulPos32x32(i32* %r2, i32 %r3, i32 12)
%r42 = trunc i64 %r41 to i32
%r43 = call i32 @extractHigh32(i64 %r41)
%r44 = call i64 @mulPos32x32(i32* %r2, i32 %r3, i32 13)
%r45 = trunc i64 %r44 to i32
%r46 = call i32 @extractHigh32(i64 %r44)
%r47 = call i64 @mulPos32x32(i32* %r2, i32 %r3, i32 14)
%r48 = trunc i64 %r47 to i32
%r49 = call i32 @extractHigh32(i64 %r47)
%r50 = call i64 @mulPos32x32(i32* %r2, i32 %r3, i32 15)
%r51 = trunc i64 %r50 to i32
%r52 = call i32 @extractHigh32(i64 %r50)
%r53 = call i64 @mulPos32x32(i32* %r2, i32 %r3, i32 16)
%r54 = trunc i64 %r53 to i32
%r55 = call i32 @extractHigh32(i64 %r53)
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
%r84 = zext i256 %r83 to i288
%r85 = zext i32 %r30 to i288
%r86 = shl i288 %r85, 256
%r87 = or i288 %r84, %r86
%r88 = zext i288 %r87 to i320
%r89 = zext i32 %r33 to i320
%r90 = shl i320 %r89, 288
%r91 = or i320 %r88, %r90
%r92 = zext i320 %r91 to i352
%r93 = zext i32 %r36 to i352
%r94 = shl i352 %r93, 320
%r95 = or i352 %r92, %r94
%r96 = zext i352 %r95 to i384
%r97 = zext i32 %r39 to i384
%r98 = shl i384 %r97, 352
%r99 = or i384 %r96, %r98
%r100 = zext i384 %r99 to i416
%r101 = zext i32 %r42 to i416
%r102 = shl i416 %r101, 384
%r103 = or i416 %r100, %r102
%r104 = zext i416 %r103 to i448
%r105 = zext i32 %r45 to i448
%r106 = shl i448 %r105, 416
%r107 = or i448 %r104, %r106
%r108 = zext i448 %r107 to i480
%r109 = zext i32 %r48 to i480
%r110 = shl i480 %r109, 448
%r111 = or i480 %r108, %r110
%r112 = zext i480 %r111 to i512
%r113 = zext i32 %r51 to i512
%r114 = shl i512 %r113, 480
%r115 = or i512 %r112, %r114
%r116 = zext i512 %r115 to i544
%r117 = zext i32 %r54 to i544
%r118 = shl i544 %r117, 512
%r119 = or i544 %r116, %r118
%r120 = zext i32 %r7 to i64
%r121 = zext i32 %r10 to i64
%r122 = shl i64 %r121, 32
%r123 = or i64 %r120, %r122
%r124 = zext i64 %r123 to i96
%r125 = zext i32 %r13 to i96
%r126 = shl i96 %r125, 64
%r127 = or i96 %r124, %r126
%r128 = zext i96 %r127 to i128
%r129 = zext i32 %r16 to i128
%r130 = shl i128 %r129, 96
%r131 = or i128 %r128, %r130
%r132 = zext i128 %r131 to i160
%r133 = zext i32 %r19 to i160
%r134 = shl i160 %r133, 128
%r135 = or i160 %r132, %r134
%r136 = zext i160 %r135 to i192
%r137 = zext i32 %r22 to i192
%r138 = shl i192 %r137, 160
%r139 = or i192 %r136, %r138
%r140 = zext i192 %r139 to i224
%r141 = zext i32 %r25 to i224
%r142 = shl i224 %r141, 192
%r143 = or i224 %r140, %r142
%r144 = zext i224 %r143 to i256
%r145 = zext i32 %r28 to i256
%r146 = shl i256 %r145, 224
%r147 = or i256 %r144, %r146
%r148 = zext i256 %r147 to i288
%r149 = zext i32 %r31 to i288
%r150 = shl i288 %r149, 256
%r151 = or i288 %r148, %r150
%r152 = zext i288 %r151 to i320
%r153 = zext i32 %r34 to i320
%r154 = shl i320 %r153, 288
%r155 = or i320 %r152, %r154
%r156 = zext i320 %r155 to i352
%r157 = zext i32 %r37 to i352
%r158 = shl i352 %r157, 320
%r159 = or i352 %r156, %r158
%r160 = zext i352 %r159 to i384
%r161 = zext i32 %r40 to i384
%r162 = shl i384 %r161, 352
%r163 = or i384 %r160, %r162
%r164 = zext i384 %r163 to i416
%r165 = zext i32 %r43 to i416
%r166 = shl i416 %r165, 384
%r167 = or i416 %r164, %r166
%r168 = zext i416 %r167 to i448
%r169 = zext i32 %r46 to i448
%r170 = shl i448 %r169, 416
%r171 = or i448 %r168, %r170
%r172 = zext i448 %r171 to i480
%r173 = zext i32 %r49 to i480
%r174 = shl i480 %r173, 448
%r175 = or i480 %r172, %r174
%r176 = zext i480 %r175 to i512
%r177 = zext i32 %r52 to i512
%r178 = shl i512 %r177, 480
%r179 = or i512 %r176, %r178
%r180 = zext i512 %r179 to i544
%r181 = zext i32 %r55 to i544
%r182 = shl i544 %r181, 512
%r183 = or i544 %r180, %r182
%r184 = zext i544 %r119 to i576
%r185 = zext i544 %r183 to i576
%r186 = shl i576 %r185, 32
%r187 = add i576 %r184, %r186
%r188 = bitcast i32* %r1 to i544*
%r189 = load i544, i544* %r188
%r190 = zext i544 %r189 to i576
%r191 = add i576 %r187, %r190
%r192 = trunc i576 %r191 to i544
%r193 = bitcast i32* %r1 to i544*
store i544 %r192, i544* %r193
%r194 = lshr i576 %r191, 544
%r195 = trunc i576 %r194 to i32
ret i32 %r195
}
define void @mclb_mul17(i32* noalias %r1, i32* noalias %r2, i32* noalias %r3)
{
%r4 = load i32, i32* %r3
%r5 = call i576 @mulUnit_inner544(i32* %r2, i32 %r4)
%r6 = trunc i576 %r5 to i32
store i32 %r6, i32* %r1
%r7 = lshr i576 %r5, 32
%r8 = getelementptr i32, i32* %r3, i32 1
%r9 = load i32, i32* %r8
%r10 = call i576 @mulUnit_inner544(i32* %r2, i32 %r9)
%r11 = add i576 %r7, %r10
%r12 = trunc i576 %r11 to i32
%r13 = getelementptr i32, i32* %r1, i32 1
store i32 %r12, i32* %r13
%r14 = lshr i576 %r11, 32
%r15 = getelementptr i32, i32* %r3, i32 2
%r16 = load i32, i32* %r15
%r17 = call i576 @mulUnit_inner544(i32* %r2, i32 %r16)
%r18 = add i576 %r14, %r17
%r19 = trunc i576 %r18 to i32
%r20 = getelementptr i32, i32* %r1, i32 2
store i32 %r19, i32* %r20
%r21 = lshr i576 %r18, 32
%r22 = getelementptr i32, i32* %r3, i32 3
%r23 = load i32, i32* %r22
%r24 = call i576 @mulUnit_inner544(i32* %r2, i32 %r23)
%r25 = add i576 %r21, %r24
%r26 = trunc i576 %r25 to i32
%r27 = getelementptr i32, i32* %r1, i32 3
store i32 %r26, i32* %r27
%r28 = lshr i576 %r25, 32
%r29 = getelementptr i32, i32* %r3, i32 4
%r30 = load i32, i32* %r29
%r31 = call i576 @mulUnit_inner544(i32* %r2, i32 %r30)
%r32 = add i576 %r28, %r31
%r33 = trunc i576 %r32 to i32
%r34 = getelementptr i32, i32* %r1, i32 4
store i32 %r33, i32* %r34
%r35 = lshr i576 %r32, 32
%r36 = getelementptr i32, i32* %r3, i32 5
%r37 = load i32, i32* %r36
%r38 = call i576 @mulUnit_inner544(i32* %r2, i32 %r37)
%r39 = add i576 %r35, %r38
%r40 = trunc i576 %r39 to i32
%r41 = getelementptr i32, i32* %r1, i32 5
store i32 %r40, i32* %r41
%r42 = lshr i576 %r39, 32
%r43 = getelementptr i32, i32* %r3, i32 6
%r44 = load i32, i32* %r43
%r45 = call i576 @mulUnit_inner544(i32* %r2, i32 %r44)
%r46 = add i576 %r42, %r45
%r47 = trunc i576 %r46 to i32
%r48 = getelementptr i32, i32* %r1, i32 6
store i32 %r47, i32* %r48
%r49 = lshr i576 %r46, 32
%r50 = getelementptr i32, i32* %r3, i32 7
%r51 = load i32, i32* %r50
%r52 = call i576 @mulUnit_inner544(i32* %r2, i32 %r51)
%r53 = add i576 %r49, %r52
%r54 = trunc i576 %r53 to i32
%r55 = getelementptr i32, i32* %r1, i32 7
store i32 %r54, i32* %r55
%r56 = lshr i576 %r53, 32
%r57 = getelementptr i32, i32* %r3, i32 8
%r58 = load i32, i32* %r57
%r59 = call i576 @mulUnit_inner544(i32* %r2, i32 %r58)
%r60 = add i576 %r56, %r59
%r61 = trunc i576 %r60 to i32
%r62 = getelementptr i32, i32* %r1, i32 8
store i32 %r61, i32* %r62
%r63 = lshr i576 %r60, 32
%r64 = getelementptr i32, i32* %r3, i32 9
%r65 = load i32, i32* %r64
%r66 = call i576 @mulUnit_inner544(i32* %r2, i32 %r65)
%r67 = add i576 %r63, %r66
%r68 = trunc i576 %r67 to i32
%r69 = getelementptr i32, i32* %r1, i32 9
store i32 %r68, i32* %r69
%r70 = lshr i576 %r67, 32
%r71 = getelementptr i32, i32* %r3, i32 10
%r72 = load i32, i32* %r71
%r73 = call i576 @mulUnit_inner544(i32* %r2, i32 %r72)
%r74 = add i576 %r70, %r73
%r75 = trunc i576 %r74 to i32
%r76 = getelementptr i32, i32* %r1, i32 10
store i32 %r75, i32* %r76
%r77 = lshr i576 %r74, 32
%r78 = getelementptr i32, i32* %r3, i32 11
%r79 = load i32, i32* %r78
%r80 = call i576 @mulUnit_inner544(i32* %r2, i32 %r79)
%r81 = add i576 %r77, %r80
%r82 = trunc i576 %r81 to i32
%r83 = getelementptr i32, i32* %r1, i32 11
store i32 %r82, i32* %r83
%r84 = lshr i576 %r81, 32
%r85 = getelementptr i32, i32* %r3, i32 12
%r86 = load i32, i32* %r85
%r87 = call i576 @mulUnit_inner544(i32* %r2, i32 %r86)
%r88 = add i576 %r84, %r87
%r89 = trunc i576 %r88 to i32
%r90 = getelementptr i32, i32* %r1, i32 12
store i32 %r89, i32* %r90
%r91 = lshr i576 %r88, 32
%r92 = getelementptr i32, i32* %r3, i32 13
%r93 = load i32, i32* %r92
%r94 = call i576 @mulUnit_inner544(i32* %r2, i32 %r93)
%r95 = add i576 %r91, %r94
%r96 = trunc i576 %r95 to i32
%r97 = getelementptr i32, i32* %r1, i32 13
store i32 %r96, i32* %r97
%r98 = lshr i576 %r95, 32
%r99 = getelementptr i32, i32* %r3, i32 14
%r100 = load i32, i32* %r99
%r101 = call i576 @mulUnit_inner544(i32* %r2, i32 %r100)
%r102 = add i576 %r98, %r101
%r103 = trunc i576 %r102 to i32
%r104 = getelementptr i32, i32* %r1, i32 14
store i32 %r103, i32* %r104
%r105 = lshr i576 %r102, 32
%r106 = getelementptr i32, i32* %r3, i32 15
%r107 = load i32, i32* %r106
%r108 = call i576 @mulUnit_inner544(i32* %r2, i32 %r107)
%r109 = add i576 %r105, %r108
%r110 = trunc i576 %r109 to i32
%r111 = getelementptr i32, i32* %r1, i32 15
store i32 %r110, i32* %r111
%r112 = lshr i576 %r109, 32
%r113 = getelementptr i32, i32* %r3, i32 16
%r114 = load i32, i32* %r113
%r115 = call i576 @mulUnit_inner544(i32* %r2, i32 %r114)
%r116 = add i576 %r112, %r115
%r117 = getelementptr i32, i32* %r1, i32 16
%r118 = bitcast i32* %r117 to i576*
store i576 %r116, i576* %r118
ret void
}
define void @mclb_sqr17(i32* noalias %r1, i32* noalias %r2)
{
%r3 = load i32, i32* %r2
%r4 = call i64 @mul32x32L(i32 %r3, i32 %r3)
%r5 = trunc i64 %r4 to i32
store i32 %r5, i32* %r1
%r6 = lshr i64 %r4, 32
%r7 = getelementptr i32, i32* %r2, i32 16
%r8 = load i32, i32* %r7
%r9 = call i64 @mul32x32L(i32 %r3, i32 %r8)
%r10 = load i32, i32* %r2
%r11 = getelementptr i32, i32* %r2, i32 15
%r12 = load i32, i32* %r11
%r13 = call i64 @mul32x32L(i32 %r10, i32 %r12)
%r14 = getelementptr i32, i32* %r2, i32 1
%r15 = load i32, i32* %r14
%r16 = getelementptr i32, i32* %r2, i32 16
%r17 = load i32, i32* %r16
%r18 = call i64 @mul32x32L(i32 %r15, i32 %r17)
%r19 = zext i64 %r13 to i128
%r20 = zext i64 %r18 to i128
%r21 = shl i128 %r20, 64
%r22 = or i128 %r19, %r21
%r23 = zext i64 %r9 to i128
%r24 = shl i128 %r23, 32
%r25 = add i128 %r24, %r22
%r26 = load i32, i32* %r2
%r27 = getelementptr i32, i32* %r2, i32 14
%r28 = load i32, i32* %r27
%r29 = call i64 @mul32x32L(i32 %r26, i32 %r28)
%r30 = getelementptr i32, i32* %r2, i32 1
%r31 = load i32, i32* %r30
%r32 = getelementptr i32, i32* %r2, i32 15
%r33 = load i32, i32* %r32
%r34 = call i64 @mul32x32L(i32 %r31, i32 %r33)
%r35 = zext i64 %r29 to i128
%r36 = zext i64 %r34 to i128
%r37 = shl i128 %r36, 64
%r38 = or i128 %r35, %r37
%r39 = getelementptr i32, i32* %r2, i32 2
%r40 = load i32, i32* %r39
%r41 = getelementptr i32, i32* %r2, i32 16
%r42 = load i32, i32* %r41
%r43 = call i64 @mul32x32L(i32 %r40, i32 %r42)
%r44 = zext i128 %r38 to i192
%r45 = zext i64 %r43 to i192
%r46 = shl i192 %r45, 128
%r47 = or i192 %r44, %r46
%r48 = zext i128 %r25 to i192
%r49 = shl i192 %r48, 32
%r50 = add i192 %r49, %r47
%r51 = load i32, i32* %r2
%r52 = getelementptr i32, i32* %r2, i32 13
%r53 = load i32, i32* %r52
%r54 = call i64 @mul32x32L(i32 %r51, i32 %r53)
%r55 = getelementptr i32, i32* %r2, i32 1
%r56 = load i32, i32* %r55
%r57 = getelementptr i32, i32* %r2, i32 14
%r58 = load i32, i32* %r57
%r59 = call i64 @mul32x32L(i32 %r56, i32 %r58)
%r60 = zext i64 %r54 to i128
%r61 = zext i64 %r59 to i128
%r62 = shl i128 %r61, 64
%r63 = or i128 %r60, %r62
%r64 = getelementptr i32, i32* %r2, i32 2
%r65 = load i32, i32* %r64
%r66 = getelementptr i32, i32* %r2, i32 15
%r67 = load i32, i32* %r66
%r68 = call i64 @mul32x32L(i32 %r65, i32 %r67)
%r69 = zext i128 %r63 to i192
%r70 = zext i64 %r68 to i192
%r71 = shl i192 %r70, 128
%r72 = or i192 %r69, %r71
%r73 = getelementptr i32, i32* %r2, i32 3
%r74 = load i32, i32* %r73
%r75 = getelementptr i32, i32* %r2, i32 16
%r76 = load i32, i32* %r75
%r77 = call i64 @mul32x32L(i32 %r74, i32 %r76)
%r78 = zext i192 %r72 to i256
%r79 = zext i64 %r77 to i256
%r80 = shl i256 %r79, 192
%r81 = or i256 %r78, %r80
%r82 = zext i192 %r50 to i256
%r83 = shl i256 %r82, 32
%r84 = add i256 %r83, %r81
%r85 = load i32, i32* %r2
%r86 = getelementptr i32, i32* %r2, i32 12
%r87 = load i32, i32* %r86
%r88 = call i64 @mul32x32L(i32 %r85, i32 %r87)
%r89 = getelementptr i32, i32* %r2, i32 1
%r90 = load i32, i32* %r89
%r91 = getelementptr i32, i32* %r2, i32 13
%r92 = load i32, i32* %r91
%r93 = call i64 @mul32x32L(i32 %r90, i32 %r92)
%r94 = zext i64 %r88 to i128
%r95 = zext i64 %r93 to i128
%r96 = shl i128 %r95, 64
%r97 = or i128 %r94, %r96
%r98 = getelementptr i32, i32* %r2, i32 2
%r99 = load i32, i32* %r98
%r100 = getelementptr i32, i32* %r2, i32 14
%r101 = load i32, i32* %r100
%r102 = call i64 @mul32x32L(i32 %r99, i32 %r101)
%r103 = zext i128 %r97 to i192
%r104 = zext i64 %r102 to i192
%r105 = shl i192 %r104, 128
%r106 = or i192 %r103, %r105
%r107 = getelementptr i32, i32* %r2, i32 3
%r108 = load i32, i32* %r107
%r109 = getelementptr i32, i32* %r2, i32 15
%r110 = load i32, i32* %r109
%r111 = call i64 @mul32x32L(i32 %r108, i32 %r110)
%r112 = zext i192 %r106 to i256
%r113 = zext i64 %r111 to i256
%r114 = shl i256 %r113, 192
%r115 = or i256 %r112, %r114
%r116 = getelementptr i32, i32* %r2, i32 4
%r117 = load i32, i32* %r116
%r118 = getelementptr i32, i32* %r2, i32 16
%r119 = load i32, i32* %r118
%r120 = call i64 @mul32x32L(i32 %r117, i32 %r119)
%r121 = zext i256 %r115 to i320
%r122 = zext i64 %r120 to i320
%r123 = shl i320 %r122, 256
%r124 = or i320 %r121, %r123
%r125 = zext i256 %r84 to i320
%r126 = shl i320 %r125, 32
%r127 = add i320 %r126, %r124
%r128 = load i32, i32* %r2
%r129 = getelementptr i32, i32* %r2, i32 11
%r130 = load i32, i32* %r129
%r131 = call i64 @mul32x32L(i32 %r128, i32 %r130)
%r132 = getelementptr i32, i32* %r2, i32 1
%r133 = load i32, i32* %r132
%r134 = getelementptr i32, i32* %r2, i32 12
%r135 = load i32, i32* %r134
%r136 = call i64 @mul32x32L(i32 %r133, i32 %r135)
%r137 = zext i64 %r131 to i128
%r138 = zext i64 %r136 to i128
%r139 = shl i128 %r138, 64
%r140 = or i128 %r137, %r139
%r141 = getelementptr i32, i32* %r2, i32 2
%r142 = load i32, i32* %r141
%r143 = getelementptr i32, i32* %r2, i32 13
%r144 = load i32, i32* %r143
%r145 = call i64 @mul32x32L(i32 %r142, i32 %r144)
%r146 = zext i128 %r140 to i192
%r147 = zext i64 %r145 to i192
%r148 = shl i192 %r147, 128
%r149 = or i192 %r146, %r148
%r150 = getelementptr i32, i32* %r2, i32 3
%r151 = load i32, i32* %r150
%r152 = getelementptr i32, i32* %r2, i32 14
%r153 = load i32, i32* %r152
%r154 = call i64 @mul32x32L(i32 %r151, i32 %r153)
%r155 = zext i192 %r149 to i256
%r156 = zext i64 %r154 to i256
%r157 = shl i256 %r156, 192
%r158 = or i256 %r155, %r157
%r159 = getelementptr i32, i32* %r2, i32 4
%r160 = load i32, i32* %r159
%r161 = getelementptr i32, i32* %r2, i32 15
%r162 = load i32, i32* %r161
%r163 = call i64 @mul32x32L(i32 %r160, i32 %r162)
%r164 = zext i256 %r158 to i320
%r165 = zext i64 %r163 to i320
%r166 = shl i320 %r165, 256
%r167 = or i320 %r164, %r166
%r168 = getelementptr i32, i32* %r2, i32 5
%r169 = load i32, i32* %r168
%r170 = getelementptr i32, i32* %r2, i32 16
%r171 = load i32, i32* %r170
%r172 = call i64 @mul32x32L(i32 %r169, i32 %r171)
%r173 = zext i320 %r167 to i384
%r174 = zext i64 %r172 to i384
%r175 = shl i384 %r174, 320
%r176 = or i384 %r173, %r175
%r177 = zext i320 %r127 to i384
%r178 = shl i384 %r177, 32
%r179 = add i384 %r178, %r176
%r180 = load i32, i32* %r2
%r181 = getelementptr i32, i32* %r2, i32 10
%r182 = load i32, i32* %r181
%r183 = call i64 @mul32x32L(i32 %r180, i32 %r182)
%r184 = getelementptr i32, i32* %r2, i32 1
%r185 = load i32, i32* %r184
%r186 = getelementptr i32, i32* %r2, i32 11
%r187 = load i32, i32* %r186
%r188 = call i64 @mul32x32L(i32 %r185, i32 %r187)
%r189 = zext i64 %r183 to i128
%r190 = zext i64 %r188 to i128
%r191 = shl i128 %r190, 64
%r192 = or i128 %r189, %r191
%r193 = getelementptr i32, i32* %r2, i32 2
%r194 = load i32, i32* %r193
%r195 = getelementptr i32, i32* %r2, i32 12
%r196 = load i32, i32* %r195
%r197 = call i64 @mul32x32L(i32 %r194, i32 %r196)
%r198 = zext i128 %r192 to i192
%r199 = zext i64 %r197 to i192
%r200 = shl i192 %r199, 128
%r201 = or i192 %r198, %r200
%r202 = getelementptr i32, i32* %r2, i32 3
%r203 = load i32, i32* %r202
%r204 = getelementptr i32, i32* %r2, i32 13
%r205 = load i32, i32* %r204
%r206 = call i64 @mul32x32L(i32 %r203, i32 %r205)
%r207 = zext i192 %r201 to i256
%r208 = zext i64 %r206 to i256
%r209 = shl i256 %r208, 192
%r210 = or i256 %r207, %r209
%r211 = getelementptr i32, i32* %r2, i32 4
%r212 = load i32, i32* %r211
%r213 = getelementptr i32, i32* %r2, i32 14
%r214 = load i32, i32* %r213
%r215 = call i64 @mul32x32L(i32 %r212, i32 %r214)
%r216 = zext i256 %r210 to i320
%r217 = zext i64 %r215 to i320
%r218 = shl i320 %r217, 256
%r219 = or i320 %r216, %r218
%r220 = getelementptr i32, i32* %r2, i32 5
%r221 = load i32, i32* %r220
%r222 = getelementptr i32, i32* %r2, i32 15
%r223 = load i32, i32* %r222
%r224 = call i64 @mul32x32L(i32 %r221, i32 %r223)
%r225 = zext i320 %r219 to i384
%r226 = zext i64 %r224 to i384
%r227 = shl i384 %r226, 320
%r228 = or i384 %r225, %r227
%r229 = getelementptr i32, i32* %r2, i32 6
%r230 = load i32, i32* %r229
%r231 = getelementptr i32, i32* %r2, i32 16
%r232 = load i32, i32* %r231
%r233 = call i64 @mul32x32L(i32 %r230, i32 %r232)
%r234 = zext i384 %r228 to i448
%r235 = zext i64 %r233 to i448
%r236 = shl i448 %r235, 384
%r237 = or i448 %r234, %r236
%r238 = zext i384 %r179 to i448
%r239 = shl i448 %r238, 32
%r240 = add i448 %r239, %r237
%r241 = load i32, i32* %r2
%r242 = getelementptr i32, i32* %r2, i32 9
%r243 = load i32, i32* %r242
%r244 = call i64 @mul32x32L(i32 %r241, i32 %r243)
%r245 = getelementptr i32, i32* %r2, i32 1
%r246 = load i32, i32* %r245
%r247 = getelementptr i32, i32* %r2, i32 10
%r248 = load i32, i32* %r247
%r249 = call i64 @mul32x32L(i32 %r246, i32 %r248)
%r250 = zext i64 %r244 to i128
%r251 = zext i64 %r249 to i128
%r252 = shl i128 %r251, 64
%r253 = or i128 %r250, %r252
%r254 = getelementptr i32, i32* %r2, i32 2
%r255 = load i32, i32* %r254
%r256 = getelementptr i32, i32* %r2, i32 11
%r257 = load i32, i32* %r256
%r258 = call i64 @mul32x32L(i32 %r255, i32 %r257)
%r259 = zext i128 %r253 to i192
%r260 = zext i64 %r258 to i192
%r261 = shl i192 %r260, 128
%r262 = or i192 %r259, %r261
%r263 = getelementptr i32, i32* %r2, i32 3
%r264 = load i32, i32* %r263
%r265 = getelementptr i32, i32* %r2, i32 12
%r266 = load i32, i32* %r265
%r267 = call i64 @mul32x32L(i32 %r264, i32 %r266)
%r268 = zext i192 %r262 to i256
%r269 = zext i64 %r267 to i256
%r270 = shl i256 %r269, 192
%r271 = or i256 %r268, %r270
%r272 = getelementptr i32, i32* %r2, i32 4
%r273 = load i32, i32* %r272
%r274 = getelementptr i32, i32* %r2, i32 13
%r275 = load i32, i32* %r274
%r276 = call i64 @mul32x32L(i32 %r273, i32 %r275)
%r277 = zext i256 %r271 to i320
%r278 = zext i64 %r276 to i320
%r279 = shl i320 %r278, 256
%r280 = or i320 %r277, %r279
%r281 = getelementptr i32, i32* %r2, i32 5
%r282 = load i32, i32* %r281
%r283 = getelementptr i32, i32* %r2, i32 14
%r284 = load i32, i32* %r283
%r285 = call i64 @mul32x32L(i32 %r282, i32 %r284)
%r286 = zext i320 %r280 to i384
%r287 = zext i64 %r285 to i384
%r288 = shl i384 %r287, 320
%r289 = or i384 %r286, %r288
%r290 = getelementptr i32, i32* %r2, i32 6
%r291 = load i32, i32* %r290
%r292 = getelementptr i32, i32* %r2, i32 15
%r293 = load i32, i32* %r292
%r294 = call i64 @mul32x32L(i32 %r291, i32 %r293)
%r295 = zext i384 %r289 to i448
%r296 = zext i64 %r294 to i448
%r297 = shl i448 %r296, 384
%r298 = or i448 %r295, %r297
%r299 = getelementptr i32, i32* %r2, i32 7
%r300 = load i32, i32* %r299
%r301 = getelementptr i32, i32* %r2, i32 16
%r302 = load i32, i32* %r301
%r303 = call i64 @mul32x32L(i32 %r300, i32 %r302)
%r304 = zext i448 %r298 to i512
%r305 = zext i64 %r303 to i512
%r306 = shl i512 %r305, 448
%r307 = or i512 %r304, %r306
%r308 = zext i448 %r240 to i512
%r309 = shl i512 %r308, 32
%r310 = add i512 %r309, %r307
%r311 = load i32, i32* %r2
%r312 = getelementptr i32, i32* %r2, i32 8
%r313 = load i32, i32* %r312
%r314 = call i64 @mul32x32L(i32 %r311, i32 %r313)
%r315 = getelementptr i32, i32* %r2, i32 1
%r316 = load i32, i32* %r315
%r317 = getelementptr i32, i32* %r2, i32 9
%r318 = load i32, i32* %r317
%r319 = call i64 @mul32x32L(i32 %r316, i32 %r318)
%r320 = zext i64 %r314 to i128
%r321 = zext i64 %r319 to i128
%r322 = shl i128 %r321, 64
%r323 = or i128 %r320, %r322
%r324 = getelementptr i32, i32* %r2, i32 2
%r325 = load i32, i32* %r324
%r326 = getelementptr i32, i32* %r2, i32 10
%r327 = load i32, i32* %r326
%r328 = call i64 @mul32x32L(i32 %r325, i32 %r327)
%r329 = zext i128 %r323 to i192
%r330 = zext i64 %r328 to i192
%r331 = shl i192 %r330, 128
%r332 = or i192 %r329, %r331
%r333 = getelementptr i32, i32* %r2, i32 3
%r334 = load i32, i32* %r333
%r335 = getelementptr i32, i32* %r2, i32 11
%r336 = load i32, i32* %r335
%r337 = call i64 @mul32x32L(i32 %r334, i32 %r336)
%r338 = zext i192 %r332 to i256
%r339 = zext i64 %r337 to i256
%r340 = shl i256 %r339, 192
%r341 = or i256 %r338, %r340
%r342 = getelementptr i32, i32* %r2, i32 4
%r343 = load i32, i32* %r342
%r344 = getelementptr i32, i32* %r2, i32 12
%r345 = load i32, i32* %r344
%r346 = call i64 @mul32x32L(i32 %r343, i32 %r345)
%r347 = zext i256 %r341 to i320
%r348 = zext i64 %r346 to i320
%r349 = shl i320 %r348, 256
%r350 = or i320 %r347, %r349
%r351 = getelementptr i32, i32* %r2, i32 5
%r352 = load i32, i32* %r351
%r353 = getelementptr i32, i32* %r2, i32 13
%r354 = load i32, i32* %r353
%r355 = call i64 @mul32x32L(i32 %r352, i32 %r354)
%r356 = zext i320 %r350 to i384
%r357 = zext i64 %r355 to i384
%r358 = shl i384 %r357, 320
%r359 = or i384 %r356, %r358
%r360 = getelementptr i32, i32* %r2, i32 6
%r361 = load i32, i32* %r360
%r362 = getelementptr i32, i32* %r2, i32 14
%r363 = load i32, i32* %r362
%r364 = call i64 @mul32x32L(i32 %r361, i32 %r363)
%r365 = zext i384 %r359 to i448
%r366 = zext i64 %r364 to i448
%r367 = shl i448 %r366, 384
%r368 = or i448 %r365, %r367
%r369 = getelementptr i32, i32* %r2, i32 7
%r370 = load i32, i32* %r369
%r371 = getelementptr i32, i32* %r2, i32 15
%r372 = load i32, i32* %r371
%r373 = call i64 @mul32x32L(i32 %r370, i32 %r372)
%r374 = zext i448 %r368 to i512
%r375 = zext i64 %r373 to i512
%r376 = shl i512 %r375, 448
%r377 = or i512 %r374, %r376
%r378 = getelementptr i32, i32* %r2, i32 8
%r379 = load i32, i32* %r378
%r380 = getelementptr i32, i32* %r2, i32 16
%r381 = load i32, i32* %r380
%r382 = call i64 @mul32x32L(i32 %r379, i32 %r381)
%r383 = zext i512 %r377 to i576
%r384 = zext i64 %r382 to i576
%r385 = shl i576 %r384, 512
%r386 = or i576 %r383, %r385
%r387 = zext i512 %r310 to i576
%r388 = shl i576 %r387, 32
%r389 = add i576 %r388, %r386
%r390 = load i32, i32* %r2
%r391 = getelementptr i32, i32* %r2, i32 7
%r392 = load i32, i32* %r391
%r393 = call i64 @mul32x32L(i32 %r390, i32 %r392)
%r394 = getelementptr i32, i32* %r2, i32 1
%r395 = load i32, i32* %r394
%r396 = getelementptr i32, i32* %r2, i32 8
%r397 = load i32, i32* %r396
%r398 = call i64 @mul32x32L(i32 %r395, i32 %r397)
%r399 = zext i64 %r393 to i128
%r400 = zext i64 %r398 to i128
%r401 = shl i128 %r400, 64
%r402 = or i128 %r399, %r401
%r403 = getelementptr i32, i32* %r2, i32 2
%r404 = load i32, i32* %r403
%r405 = getelementptr i32, i32* %r2, i32 9
%r406 = load i32, i32* %r405
%r407 = call i64 @mul32x32L(i32 %r404, i32 %r406)
%r408 = zext i128 %r402 to i192
%r409 = zext i64 %r407 to i192
%r410 = shl i192 %r409, 128
%r411 = or i192 %r408, %r410
%r412 = getelementptr i32, i32* %r2, i32 3
%r413 = load i32, i32* %r412
%r414 = getelementptr i32, i32* %r2, i32 10
%r415 = load i32, i32* %r414
%r416 = call i64 @mul32x32L(i32 %r413, i32 %r415)
%r417 = zext i192 %r411 to i256
%r418 = zext i64 %r416 to i256
%r419 = shl i256 %r418, 192
%r420 = or i256 %r417, %r419
%r421 = getelementptr i32, i32* %r2, i32 4
%r422 = load i32, i32* %r421
%r423 = getelementptr i32, i32* %r2, i32 11
%r424 = load i32, i32* %r423
%r425 = call i64 @mul32x32L(i32 %r422, i32 %r424)
%r426 = zext i256 %r420 to i320
%r427 = zext i64 %r425 to i320
%r428 = shl i320 %r427, 256
%r429 = or i320 %r426, %r428
%r430 = getelementptr i32, i32* %r2, i32 5
%r431 = load i32, i32* %r430
%r432 = getelementptr i32, i32* %r2, i32 12
%r433 = load i32, i32* %r432
%r434 = call i64 @mul32x32L(i32 %r431, i32 %r433)
%r435 = zext i320 %r429 to i384
%r436 = zext i64 %r434 to i384
%r437 = shl i384 %r436, 320
%r438 = or i384 %r435, %r437
%r439 = getelementptr i32, i32* %r2, i32 6
%r440 = load i32, i32* %r439
%r441 = getelementptr i32, i32* %r2, i32 13
%r442 = load i32, i32* %r441
%r443 = call i64 @mul32x32L(i32 %r440, i32 %r442)
%r444 = zext i384 %r438 to i448
%r445 = zext i64 %r443 to i448
%r446 = shl i448 %r445, 384
%r447 = or i448 %r444, %r446
%r448 = getelementptr i32, i32* %r2, i32 7
%r449 = load i32, i32* %r448
%r450 = getelementptr i32, i32* %r2, i32 14
%r451 = load i32, i32* %r450
%r452 = call i64 @mul32x32L(i32 %r449, i32 %r451)
%r453 = zext i448 %r447 to i512
%r454 = zext i64 %r452 to i512
%r455 = shl i512 %r454, 448
%r456 = or i512 %r453, %r455
%r457 = getelementptr i32, i32* %r2, i32 8
%r458 = load i32, i32* %r457
%r459 = getelementptr i32, i32* %r2, i32 15
%r460 = load i32, i32* %r459
%r461 = call i64 @mul32x32L(i32 %r458, i32 %r460)
%r462 = zext i512 %r456 to i576
%r463 = zext i64 %r461 to i576
%r464 = shl i576 %r463, 512
%r465 = or i576 %r462, %r464
%r466 = getelementptr i32, i32* %r2, i32 9
%r467 = load i32, i32* %r466
%r468 = getelementptr i32, i32* %r2, i32 16
%r469 = load i32, i32* %r468
%r470 = call i64 @mul32x32L(i32 %r467, i32 %r469)
%r471 = zext i576 %r465 to i640
%r472 = zext i64 %r470 to i640
%r473 = shl i640 %r472, 576
%r474 = or i640 %r471, %r473
%r475 = zext i576 %r389 to i640
%r476 = shl i640 %r475, 32
%r477 = add i640 %r476, %r474
%r478 = load i32, i32* %r2
%r479 = getelementptr i32, i32* %r2, i32 6
%r480 = load i32, i32* %r479
%r481 = call i64 @mul32x32L(i32 %r478, i32 %r480)
%r482 = getelementptr i32, i32* %r2, i32 1
%r483 = load i32, i32* %r482
%r484 = getelementptr i32, i32* %r2, i32 7
%r485 = load i32, i32* %r484
%r486 = call i64 @mul32x32L(i32 %r483, i32 %r485)
%r487 = zext i64 %r481 to i128
%r488 = zext i64 %r486 to i128
%r489 = shl i128 %r488, 64
%r490 = or i128 %r487, %r489
%r491 = getelementptr i32, i32* %r2, i32 2
%r492 = load i32, i32* %r491
%r493 = getelementptr i32, i32* %r2, i32 8
%r494 = load i32, i32* %r493
%r495 = call i64 @mul32x32L(i32 %r492, i32 %r494)
%r496 = zext i128 %r490 to i192
%r497 = zext i64 %r495 to i192
%r498 = shl i192 %r497, 128
%r499 = or i192 %r496, %r498
%r500 = getelementptr i32, i32* %r2, i32 3
%r501 = load i32, i32* %r500
%r502 = getelementptr i32, i32* %r2, i32 9
%r503 = load i32, i32* %r502
%r504 = call i64 @mul32x32L(i32 %r501, i32 %r503)
%r505 = zext i192 %r499 to i256
%r506 = zext i64 %r504 to i256
%r507 = shl i256 %r506, 192
%r508 = or i256 %r505, %r507
%r509 = getelementptr i32, i32* %r2, i32 4
%r510 = load i32, i32* %r509
%r511 = getelementptr i32, i32* %r2, i32 10
%r512 = load i32, i32* %r511
%r513 = call i64 @mul32x32L(i32 %r510, i32 %r512)
%r514 = zext i256 %r508 to i320
%r515 = zext i64 %r513 to i320
%r516 = shl i320 %r515, 256
%r517 = or i320 %r514, %r516
%r518 = getelementptr i32, i32* %r2, i32 5
%r519 = load i32, i32* %r518
%r520 = getelementptr i32, i32* %r2, i32 11
%r521 = load i32, i32* %r520
%r522 = call i64 @mul32x32L(i32 %r519, i32 %r521)
%r523 = zext i320 %r517 to i384
%r524 = zext i64 %r522 to i384
%r525 = shl i384 %r524, 320
%r526 = or i384 %r523, %r525
%r527 = getelementptr i32, i32* %r2, i32 6
%r528 = load i32, i32* %r527
%r529 = getelementptr i32, i32* %r2, i32 12
%r530 = load i32, i32* %r529
%r531 = call i64 @mul32x32L(i32 %r528, i32 %r530)
%r532 = zext i384 %r526 to i448
%r533 = zext i64 %r531 to i448
%r534 = shl i448 %r533, 384
%r535 = or i448 %r532, %r534
%r536 = getelementptr i32, i32* %r2, i32 7
%r537 = load i32, i32* %r536
%r538 = getelementptr i32, i32* %r2, i32 13
%r539 = load i32, i32* %r538
%r540 = call i64 @mul32x32L(i32 %r537, i32 %r539)
%r541 = zext i448 %r535 to i512
%r542 = zext i64 %r540 to i512
%r543 = shl i512 %r542, 448
%r544 = or i512 %r541, %r543
%r545 = getelementptr i32, i32* %r2, i32 8
%r546 = load i32, i32* %r545
%r547 = getelementptr i32, i32* %r2, i32 14
%r548 = load i32, i32* %r547
%r549 = call i64 @mul32x32L(i32 %r546, i32 %r548)
%r550 = zext i512 %r544 to i576
%r551 = zext i64 %r549 to i576
%r552 = shl i576 %r551, 512
%r553 = or i576 %r550, %r552
%r554 = getelementptr i32, i32* %r2, i32 9
%r555 = load i32, i32* %r554
%r556 = getelementptr i32, i32* %r2, i32 15
%r557 = load i32, i32* %r556
%r558 = call i64 @mul32x32L(i32 %r555, i32 %r557)
%r559 = zext i576 %r553 to i640
%r560 = zext i64 %r558 to i640
%r561 = shl i640 %r560, 576
%r562 = or i640 %r559, %r561
%r563 = getelementptr i32, i32* %r2, i32 10
%r564 = load i32, i32* %r563
%r565 = getelementptr i32, i32* %r2, i32 16
%r566 = load i32, i32* %r565
%r567 = call i64 @mul32x32L(i32 %r564, i32 %r566)
%r568 = zext i640 %r562 to i704
%r569 = zext i64 %r567 to i704
%r570 = shl i704 %r569, 640
%r571 = or i704 %r568, %r570
%r572 = zext i640 %r477 to i704
%r573 = shl i704 %r572, 32
%r574 = add i704 %r573, %r571
%r575 = load i32, i32* %r2
%r576 = getelementptr i32, i32* %r2, i32 5
%r577 = load i32, i32* %r576
%r578 = call i64 @mul32x32L(i32 %r575, i32 %r577)
%r579 = getelementptr i32, i32* %r2, i32 1
%r580 = load i32, i32* %r579
%r581 = getelementptr i32, i32* %r2, i32 6
%r582 = load i32, i32* %r581
%r583 = call i64 @mul32x32L(i32 %r580, i32 %r582)
%r584 = zext i64 %r578 to i128
%r585 = zext i64 %r583 to i128
%r586 = shl i128 %r585, 64
%r587 = or i128 %r584, %r586
%r588 = getelementptr i32, i32* %r2, i32 2
%r589 = load i32, i32* %r588
%r590 = getelementptr i32, i32* %r2, i32 7
%r591 = load i32, i32* %r590
%r592 = call i64 @mul32x32L(i32 %r589, i32 %r591)
%r593 = zext i128 %r587 to i192
%r594 = zext i64 %r592 to i192
%r595 = shl i192 %r594, 128
%r596 = or i192 %r593, %r595
%r597 = getelementptr i32, i32* %r2, i32 3
%r598 = load i32, i32* %r597
%r599 = getelementptr i32, i32* %r2, i32 8
%r600 = load i32, i32* %r599
%r601 = call i64 @mul32x32L(i32 %r598, i32 %r600)
%r602 = zext i192 %r596 to i256
%r603 = zext i64 %r601 to i256
%r604 = shl i256 %r603, 192
%r605 = or i256 %r602, %r604
%r606 = getelementptr i32, i32* %r2, i32 4
%r607 = load i32, i32* %r606
%r608 = getelementptr i32, i32* %r2, i32 9
%r609 = load i32, i32* %r608
%r610 = call i64 @mul32x32L(i32 %r607, i32 %r609)
%r611 = zext i256 %r605 to i320
%r612 = zext i64 %r610 to i320
%r613 = shl i320 %r612, 256
%r614 = or i320 %r611, %r613
%r615 = getelementptr i32, i32* %r2, i32 5
%r616 = load i32, i32* %r615
%r617 = getelementptr i32, i32* %r2, i32 10
%r618 = load i32, i32* %r617
%r619 = call i64 @mul32x32L(i32 %r616, i32 %r618)
%r620 = zext i320 %r614 to i384
%r621 = zext i64 %r619 to i384
%r622 = shl i384 %r621, 320
%r623 = or i384 %r620, %r622
%r624 = getelementptr i32, i32* %r2, i32 6
%r625 = load i32, i32* %r624
%r626 = getelementptr i32, i32* %r2, i32 11
%r627 = load i32, i32* %r626
%r628 = call i64 @mul32x32L(i32 %r625, i32 %r627)
%r629 = zext i384 %r623 to i448
%r630 = zext i64 %r628 to i448
%r631 = shl i448 %r630, 384
%r632 = or i448 %r629, %r631
%r633 = getelementptr i32, i32* %r2, i32 7
%r634 = load i32, i32* %r633
%r635 = getelementptr i32, i32* %r2, i32 12
%r636 = load i32, i32* %r635
%r637 = call i64 @mul32x32L(i32 %r634, i32 %r636)
%r638 = zext i448 %r632 to i512
%r639 = zext i64 %r637 to i512
%r640 = shl i512 %r639, 448
%r641 = or i512 %r638, %r640
%r642 = getelementptr i32, i32* %r2, i32 8
%r643 = load i32, i32* %r642
%r644 = getelementptr i32, i32* %r2, i32 13
%r645 = load i32, i32* %r644
%r646 = call i64 @mul32x32L(i32 %r643, i32 %r645)
%r647 = zext i512 %r641 to i576
%r648 = zext i64 %r646 to i576
%r649 = shl i576 %r648, 512
%r650 = or i576 %r647, %r649
%r651 = getelementptr i32, i32* %r2, i32 9
%r652 = load i32, i32* %r651
%r653 = getelementptr i32, i32* %r2, i32 14
%r654 = load i32, i32* %r653
%r655 = call i64 @mul32x32L(i32 %r652, i32 %r654)
%r656 = zext i576 %r650 to i640
%r657 = zext i64 %r655 to i640
%r658 = shl i640 %r657, 576
%r659 = or i640 %r656, %r658
%r660 = getelementptr i32, i32* %r2, i32 10
%r661 = load i32, i32* %r660
%r662 = getelementptr i32, i32* %r2, i32 15
%r663 = load i32, i32* %r662
%r664 = call i64 @mul32x32L(i32 %r661, i32 %r663)
%r665 = zext i640 %r659 to i704
%r666 = zext i64 %r664 to i704
%r667 = shl i704 %r666, 640
%r668 = or i704 %r665, %r667
%r669 = getelementptr i32, i32* %r2, i32 11
%r670 = load i32, i32* %r669
%r671 = getelementptr i32, i32* %r2, i32 16
%r672 = load i32, i32* %r671
%r673 = call i64 @mul32x32L(i32 %r670, i32 %r672)
%r674 = zext i704 %r668 to i768
%r675 = zext i64 %r673 to i768
%r676 = shl i768 %r675, 704
%r677 = or i768 %r674, %r676
%r678 = zext i704 %r574 to i768
%r679 = shl i768 %r678, 32
%r680 = add i768 %r679, %r677
%r681 = load i32, i32* %r2
%r682 = getelementptr i32, i32* %r2, i32 4
%r683 = load i32, i32* %r682
%r684 = call i64 @mul32x32L(i32 %r681, i32 %r683)
%r685 = getelementptr i32, i32* %r2, i32 1
%r686 = load i32, i32* %r685
%r687 = getelementptr i32, i32* %r2, i32 5
%r688 = load i32, i32* %r687
%r689 = call i64 @mul32x32L(i32 %r686, i32 %r688)
%r690 = zext i64 %r684 to i128
%r691 = zext i64 %r689 to i128
%r692 = shl i128 %r691, 64
%r693 = or i128 %r690, %r692
%r694 = getelementptr i32, i32* %r2, i32 2
%r695 = load i32, i32* %r694
%r696 = getelementptr i32, i32* %r2, i32 6
%r697 = load i32, i32* %r696
%r698 = call i64 @mul32x32L(i32 %r695, i32 %r697)
%r699 = zext i128 %r693 to i192
%r700 = zext i64 %r698 to i192
%r701 = shl i192 %r700, 128
%r702 = or i192 %r699, %r701
%r703 = getelementptr i32, i32* %r2, i32 3
%r704 = load i32, i32* %r703
%r705 = getelementptr i32, i32* %r2, i32 7
%r706 = load i32, i32* %r705
%r707 = call i64 @mul32x32L(i32 %r704, i32 %r706)
%r708 = zext i192 %r702 to i256
%r709 = zext i64 %r707 to i256
%r710 = shl i256 %r709, 192
%r711 = or i256 %r708, %r710
%r712 = getelementptr i32, i32* %r2, i32 4
%r713 = load i32, i32* %r712
%r714 = getelementptr i32, i32* %r2, i32 8
%r715 = load i32, i32* %r714
%r716 = call i64 @mul32x32L(i32 %r713, i32 %r715)
%r717 = zext i256 %r711 to i320
%r718 = zext i64 %r716 to i320
%r719 = shl i320 %r718, 256
%r720 = or i320 %r717, %r719
%r721 = getelementptr i32, i32* %r2, i32 5
%r722 = load i32, i32* %r721
%r723 = getelementptr i32, i32* %r2, i32 9
%r724 = load i32, i32* %r723
%r725 = call i64 @mul32x32L(i32 %r722, i32 %r724)
%r726 = zext i320 %r720 to i384
%r727 = zext i64 %r725 to i384
%r728 = shl i384 %r727, 320
%r729 = or i384 %r726, %r728
%r730 = getelementptr i32, i32* %r2, i32 6
%r731 = load i32, i32* %r730
%r732 = getelementptr i32, i32* %r2, i32 10
%r733 = load i32, i32* %r732
%r734 = call i64 @mul32x32L(i32 %r731, i32 %r733)
%r735 = zext i384 %r729 to i448
%r736 = zext i64 %r734 to i448
%r737 = shl i448 %r736, 384
%r738 = or i448 %r735, %r737
%r739 = getelementptr i32, i32* %r2, i32 7
%r740 = load i32, i32* %r739
%r741 = getelementptr i32, i32* %r2, i32 11
%r742 = load i32, i32* %r741
%r743 = call i64 @mul32x32L(i32 %r740, i32 %r742)
%r744 = zext i448 %r738 to i512
%r745 = zext i64 %r743 to i512
%r746 = shl i512 %r745, 448
%r747 = or i512 %r744, %r746
%r748 = getelementptr i32, i32* %r2, i32 8
%r749 = load i32, i32* %r748
%r750 = getelementptr i32, i32* %r2, i32 12
%r751 = load i32, i32* %r750
%r752 = call i64 @mul32x32L(i32 %r749, i32 %r751)
%r753 = zext i512 %r747 to i576
%r754 = zext i64 %r752 to i576
%r755 = shl i576 %r754, 512
%r756 = or i576 %r753, %r755
%r757 = getelementptr i32, i32* %r2, i32 9
%r758 = load i32, i32* %r757
%r759 = getelementptr i32, i32* %r2, i32 13
%r760 = load i32, i32* %r759
%r761 = call i64 @mul32x32L(i32 %r758, i32 %r760)
%r762 = zext i576 %r756 to i640
%r763 = zext i64 %r761 to i640
%r764 = shl i640 %r763, 576
%r765 = or i640 %r762, %r764
%r766 = getelementptr i32, i32* %r2, i32 10
%r767 = load i32, i32* %r766
%r768 = getelementptr i32, i32* %r2, i32 14
%r769 = load i32, i32* %r768
%r770 = call i64 @mul32x32L(i32 %r767, i32 %r769)
%r771 = zext i640 %r765 to i704
%r772 = zext i64 %r770 to i704
%r773 = shl i704 %r772, 640
%r774 = or i704 %r771, %r773
%r775 = getelementptr i32, i32* %r2, i32 11
%r776 = load i32, i32* %r775
%r777 = getelementptr i32, i32* %r2, i32 15
%r778 = load i32, i32* %r777
%r779 = call i64 @mul32x32L(i32 %r776, i32 %r778)
%r780 = zext i704 %r774 to i768
%r781 = zext i64 %r779 to i768
%r782 = shl i768 %r781, 704
%r783 = or i768 %r780, %r782
%r784 = getelementptr i32, i32* %r2, i32 12
%r785 = load i32, i32* %r784
%r786 = getelementptr i32, i32* %r2, i32 16
%r787 = load i32, i32* %r786
%r788 = call i64 @mul32x32L(i32 %r785, i32 %r787)
%r789 = zext i768 %r783 to i832
%r790 = zext i64 %r788 to i832
%r791 = shl i832 %r790, 768
%r792 = or i832 %r789, %r791
%r793 = zext i768 %r680 to i832
%r794 = shl i832 %r793, 32
%r795 = add i832 %r794, %r792
%r796 = load i32, i32* %r2
%r797 = getelementptr i32, i32* %r2, i32 3
%r798 = load i32, i32* %r797
%r799 = call i64 @mul32x32L(i32 %r796, i32 %r798)
%r800 = getelementptr i32, i32* %r2, i32 1
%r801 = load i32, i32* %r800
%r802 = getelementptr i32, i32* %r2, i32 4
%r803 = load i32, i32* %r802
%r804 = call i64 @mul32x32L(i32 %r801, i32 %r803)
%r805 = zext i64 %r799 to i128
%r806 = zext i64 %r804 to i128
%r807 = shl i128 %r806, 64
%r808 = or i128 %r805, %r807
%r809 = getelementptr i32, i32* %r2, i32 2
%r810 = load i32, i32* %r809
%r811 = getelementptr i32, i32* %r2, i32 5
%r812 = load i32, i32* %r811
%r813 = call i64 @mul32x32L(i32 %r810, i32 %r812)
%r814 = zext i128 %r808 to i192
%r815 = zext i64 %r813 to i192
%r816 = shl i192 %r815, 128
%r817 = or i192 %r814, %r816
%r818 = getelementptr i32, i32* %r2, i32 3
%r819 = load i32, i32* %r818
%r820 = getelementptr i32, i32* %r2, i32 6
%r821 = load i32, i32* %r820
%r822 = call i64 @mul32x32L(i32 %r819, i32 %r821)
%r823 = zext i192 %r817 to i256
%r824 = zext i64 %r822 to i256
%r825 = shl i256 %r824, 192
%r826 = or i256 %r823, %r825
%r827 = getelementptr i32, i32* %r2, i32 4
%r828 = load i32, i32* %r827
%r829 = getelementptr i32, i32* %r2, i32 7
%r830 = load i32, i32* %r829
%r831 = call i64 @mul32x32L(i32 %r828, i32 %r830)
%r832 = zext i256 %r826 to i320
%r833 = zext i64 %r831 to i320
%r834 = shl i320 %r833, 256
%r835 = or i320 %r832, %r834
%r836 = getelementptr i32, i32* %r2, i32 5
%r837 = load i32, i32* %r836
%r838 = getelementptr i32, i32* %r2, i32 8
%r839 = load i32, i32* %r838
%r840 = call i64 @mul32x32L(i32 %r837, i32 %r839)
%r841 = zext i320 %r835 to i384
%r842 = zext i64 %r840 to i384
%r843 = shl i384 %r842, 320
%r844 = or i384 %r841, %r843
%r845 = getelementptr i32, i32* %r2, i32 6
%r846 = load i32, i32* %r845
%r847 = getelementptr i32, i32* %r2, i32 9
%r848 = load i32, i32* %r847
%r849 = call i64 @mul32x32L(i32 %r846, i32 %r848)
%r850 = zext i384 %r844 to i448
%r851 = zext i64 %r849 to i448
%r852 = shl i448 %r851, 384
%r853 = or i448 %r850, %r852
%r854 = getelementptr i32, i32* %r2, i32 7
%r855 = load i32, i32* %r854
%r856 = getelementptr i32, i32* %r2, i32 10
%r857 = load i32, i32* %r856
%r858 = call i64 @mul32x32L(i32 %r855, i32 %r857)
%r859 = zext i448 %r853 to i512
%r860 = zext i64 %r858 to i512
%r861 = shl i512 %r860, 448
%r862 = or i512 %r859, %r861
%r863 = getelementptr i32, i32* %r2, i32 8
%r864 = load i32, i32* %r863
%r865 = getelementptr i32, i32* %r2, i32 11
%r866 = load i32, i32* %r865
%r867 = call i64 @mul32x32L(i32 %r864, i32 %r866)
%r868 = zext i512 %r862 to i576
%r869 = zext i64 %r867 to i576
%r870 = shl i576 %r869, 512
%r871 = or i576 %r868, %r870
%r872 = getelementptr i32, i32* %r2, i32 9
%r873 = load i32, i32* %r872
%r874 = getelementptr i32, i32* %r2, i32 12
%r875 = load i32, i32* %r874
%r876 = call i64 @mul32x32L(i32 %r873, i32 %r875)
%r877 = zext i576 %r871 to i640
%r878 = zext i64 %r876 to i640
%r879 = shl i640 %r878, 576
%r880 = or i640 %r877, %r879
%r881 = getelementptr i32, i32* %r2, i32 10
%r882 = load i32, i32* %r881
%r883 = getelementptr i32, i32* %r2, i32 13
%r884 = load i32, i32* %r883
%r885 = call i64 @mul32x32L(i32 %r882, i32 %r884)
%r886 = zext i640 %r880 to i704
%r887 = zext i64 %r885 to i704
%r888 = shl i704 %r887, 640
%r889 = or i704 %r886, %r888
%r890 = getelementptr i32, i32* %r2, i32 11
%r891 = load i32, i32* %r890
%r892 = getelementptr i32, i32* %r2, i32 14
%r893 = load i32, i32* %r892
%r894 = call i64 @mul32x32L(i32 %r891, i32 %r893)
%r895 = zext i704 %r889 to i768
%r896 = zext i64 %r894 to i768
%r897 = shl i768 %r896, 704
%r898 = or i768 %r895, %r897
%r899 = getelementptr i32, i32* %r2, i32 12
%r900 = load i32, i32* %r899
%r901 = getelementptr i32, i32* %r2, i32 15
%r902 = load i32, i32* %r901
%r903 = call i64 @mul32x32L(i32 %r900, i32 %r902)
%r904 = zext i768 %r898 to i832
%r905 = zext i64 %r903 to i832
%r906 = shl i832 %r905, 768
%r907 = or i832 %r904, %r906
%r908 = getelementptr i32, i32* %r2, i32 13
%r909 = load i32, i32* %r908
%r910 = getelementptr i32, i32* %r2, i32 16
%r911 = load i32, i32* %r910
%r912 = call i64 @mul32x32L(i32 %r909, i32 %r911)
%r913 = zext i832 %r907 to i896
%r914 = zext i64 %r912 to i896
%r915 = shl i896 %r914, 832
%r916 = or i896 %r913, %r915
%r917 = zext i832 %r795 to i896
%r918 = shl i896 %r917, 32
%r919 = add i896 %r918, %r916
%r920 = load i32, i32* %r2
%r921 = getelementptr i32, i32* %r2, i32 2
%r922 = load i32, i32* %r921
%r923 = call i64 @mul32x32L(i32 %r920, i32 %r922)
%r924 = getelementptr i32, i32* %r2, i32 1
%r925 = load i32, i32* %r924
%r926 = getelementptr i32, i32* %r2, i32 3
%r927 = load i32, i32* %r926
%r928 = call i64 @mul32x32L(i32 %r925, i32 %r927)
%r929 = zext i64 %r923 to i128
%r930 = zext i64 %r928 to i128
%r931 = shl i128 %r930, 64
%r932 = or i128 %r929, %r931
%r933 = getelementptr i32, i32* %r2, i32 2
%r934 = load i32, i32* %r933
%r935 = getelementptr i32, i32* %r2, i32 4
%r936 = load i32, i32* %r935
%r937 = call i64 @mul32x32L(i32 %r934, i32 %r936)
%r938 = zext i128 %r932 to i192
%r939 = zext i64 %r937 to i192
%r940 = shl i192 %r939, 128
%r941 = or i192 %r938, %r940
%r942 = getelementptr i32, i32* %r2, i32 3
%r943 = load i32, i32* %r942
%r944 = getelementptr i32, i32* %r2, i32 5
%r945 = load i32, i32* %r944
%r946 = call i64 @mul32x32L(i32 %r943, i32 %r945)
%r947 = zext i192 %r941 to i256
%r948 = zext i64 %r946 to i256
%r949 = shl i256 %r948, 192
%r950 = or i256 %r947, %r949
%r951 = getelementptr i32, i32* %r2, i32 4
%r952 = load i32, i32* %r951
%r953 = getelementptr i32, i32* %r2, i32 6
%r954 = load i32, i32* %r953
%r955 = call i64 @mul32x32L(i32 %r952, i32 %r954)
%r956 = zext i256 %r950 to i320
%r957 = zext i64 %r955 to i320
%r958 = shl i320 %r957, 256
%r959 = or i320 %r956, %r958
%r960 = getelementptr i32, i32* %r2, i32 5
%r961 = load i32, i32* %r960
%r962 = getelementptr i32, i32* %r2, i32 7
%r963 = load i32, i32* %r962
%r964 = call i64 @mul32x32L(i32 %r961, i32 %r963)
%r965 = zext i320 %r959 to i384
%r966 = zext i64 %r964 to i384
%r967 = shl i384 %r966, 320
%r968 = or i384 %r965, %r967
%r969 = getelementptr i32, i32* %r2, i32 6
%r970 = load i32, i32* %r969
%r971 = getelementptr i32, i32* %r2, i32 8
%r972 = load i32, i32* %r971
%r973 = call i64 @mul32x32L(i32 %r970, i32 %r972)
%r974 = zext i384 %r968 to i448
%r975 = zext i64 %r973 to i448
%r976 = shl i448 %r975, 384
%r977 = or i448 %r974, %r976
%r978 = getelementptr i32, i32* %r2, i32 7
%r979 = load i32, i32* %r978
%r980 = getelementptr i32, i32* %r2, i32 9
%r981 = load i32, i32* %r980
%r982 = call i64 @mul32x32L(i32 %r979, i32 %r981)
%r983 = zext i448 %r977 to i512
%r984 = zext i64 %r982 to i512
%r985 = shl i512 %r984, 448
%r986 = or i512 %r983, %r985
%r987 = getelementptr i32, i32* %r2, i32 8
%r988 = load i32, i32* %r987
%r989 = getelementptr i32, i32* %r2, i32 10
%r990 = load i32, i32* %r989
%r991 = call i64 @mul32x32L(i32 %r988, i32 %r990)
%r992 = zext i512 %r986 to i576
%r993 = zext i64 %r991 to i576
%r994 = shl i576 %r993, 512
%r995 = or i576 %r992, %r994
%r996 = getelementptr i32, i32* %r2, i32 9
%r997 = load i32, i32* %r996
%r998 = getelementptr i32, i32* %r2, i32 11
%r999 = load i32, i32* %r998
%r1000 = call i64 @mul32x32L(i32 %r997, i32 %r999)
%r1001 = zext i576 %r995 to i640
%r1002 = zext i64 %r1000 to i640
%r1003 = shl i640 %r1002, 576
%r1004 = or i640 %r1001, %r1003
%r1005 = getelementptr i32, i32* %r2, i32 10
%r1006 = load i32, i32* %r1005
%r1007 = getelementptr i32, i32* %r2, i32 12
%r1008 = load i32, i32* %r1007
%r1009 = call i64 @mul32x32L(i32 %r1006, i32 %r1008)
%r1010 = zext i640 %r1004 to i704
%r1011 = zext i64 %r1009 to i704
%r1012 = shl i704 %r1011, 640
%r1013 = or i704 %r1010, %r1012
%r1014 = getelementptr i32, i32* %r2, i32 11
%r1015 = load i32, i32* %r1014
%r1016 = getelementptr i32, i32* %r2, i32 13
%r1017 = load i32, i32* %r1016
%r1018 = call i64 @mul32x32L(i32 %r1015, i32 %r1017)
%r1019 = zext i704 %r1013 to i768
%r1020 = zext i64 %r1018 to i768
%r1021 = shl i768 %r1020, 704
%r1022 = or i768 %r1019, %r1021
%r1023 = getelementptr i32, i32* %r2, i32 12
%r1024 = load i32, i32* %r1023
%r1025 = getelementptr i32, i32* %r2, i32 14
%r1026 = load i32, i32* %r1025
%r1027 = call i64 @mul32x32L(i32 %r1024, i32 %r1026)
%r1028 = zext i768 %r1022 to i832
%r1029 = zext i64 %r1027 to i832
%r1030 = shl i832 %r1029, 768
%r1031 = or i832 %r1028, %r1030
%r1032 = getelementptr i32, i32* %r2, i32 13
%r1033 = load i32, i32* %r1032
%r1034 = getelementptr i32, i32* %r2, i32 15
%r1035 = load i32, i32* %r1034
%r1036 = call i64 @mul32x32L(i32 %r1033, i32 %r1035)
%r1037 = zext i832 %r1031 to i896
%r1038 = zext i64 %r1036 to i896
%r1039 = shl i896 %r1038, 832
%r1040 = or i896 %r1037, %r1039
%r1041 = getelementptr i32, i32* %r2, i32 14
%r1042 = load i32, i32* %r1041
%r1043 = getelementptr i32, i32* %r2, i32 16
%r1044 = load i32, i32* %r1043
%r1045 = call i64 @mul32x32L(i32 %r1042, i32 %r1044)
%r1046 = zext i896 %r1040 to i960
%r1047 = zext i64 %r1045 to i960
%r1048 = shl i960 %r1047, 896
%r1049 = or i960 %r1046, %r1048
%r1050 = zext i896 %r919 to i960
%r1051 = shl i960 %r1050, 32
%r1052 = add i960 %r1051, %r1049
%r1053 = load i32, i32* %r2
%r1054 = getelementptr i32, i32* %r2, i32 1
%r1055 = load i32, i32* %r1054
%r1056 = call i64 @mul32x32L(i32 %r1053, i32 %r1055)
%r1057 = getelementptr i32, i32* %r2, i32 1
%r1058 = load i32, i32* %r1057
%r1059 = getelementptr i32, i32* %r2, i32 2
%r1060 = load i32, i32* %r1059
%r1061 = call i64 @mul32x32L(i32 %r1058, i32 %r1060)
%r1062 = zext i64 %r1056 to i128
%r1063 = zext i64 %r1061 to i128
%r1064 = shl i128 %r1063, 64
%r1065 = or i128 %r1062, %r1064
%r1066 = getelementptr i32, i32* %r2, i32 2
%r1067 = load i32, i32* %r1066
%r1068 = getelementptr i32, i32* %r2, i32 3
%r1069 = load i32, i32* %r1068
%r1070 = call i64 @mul32x32L(i32 %r1067, i32 %r1069)
%r1071 = zext i128 %r1065 to i192
%r1072 = zext i64 %r1070 to i192
%r1073 = shl i192 %r1072, 128
%r1074 = or i192 %r1071, %r1073
%r1075 = getelementptr i32, i32* %r2, i32 3
%r1076 = load i32, i32* %r1075
%r1077 = getelementptr i32, i32* %r2, i32 4
%r1078 = load i32, i32* %r1077
%r1079 = call i64 @mul32x32L(i32 %r1076, i32 %r1078)
%r1080 = zext i192 %r1074 to i256
%r1081 = zext i64 %r1079 to i256
%r1082 = shl i256 %r1081, 192
%r1083 = or i256 %r1080, %r1082
%r1084 = getelementptr i32, i32* %r2, i32 4
%r1085 = load i32, i32* %r1084
%r1086 = getelementptr i32, i32* %r2, i32 5
%r1087 = load i32, i32* %r1086
%r1088 = call i64 @mul32x32L(i32 %r1085, i32 %r1087)
%r1089 = zext i256 %r1083 to i320
%r1090 = zext i64 %r1088 to i320
%r1091 = shl i320 %r1090, 256
%r1092 = or i320 %r1089, %r1091
%r1093 = getelementptr i32, i32* %r2, i32 5
%r1094 = load i32, i32* %r1093
%r1095 = getelementptr i32, i32* %r2, i32 6
%r1096 = load i32, i32* %r1095
%r1097 = call i64 @mul32x32L(i32 %r1094, i32 %r1096)
%r1098 = zext i320 %r1092 to i384
%r1099 = zext i64 %r1097 to i384
%r1100 = shl i384 %r1099, 320
%r1101 = or i384 %r1098, %r1100
%r1102 = getelementptr i32, i32* %r2, i32 6
%r1103 = load i32, i32* %r1102
%r1104 = getelementptr i32, i32* %r2, i32 7
%r1105 = load i32, i32* %r1104
%r1106 = call i64 @mul32x32L(i32 %r1103, i32 %r1105)
%r1107 = zext i384 %r1101 to i448
%r1108 = zext i64 %r1106 to i448
%r1109 = shl i448 %r1108, 384
%r1110 = or i448 %r1107, %r1109
%r1111 = getelementptr i32, i32* %r2, i32 7
%r1112 = load i32, i32* %r1111
%r1113 = getelementptr i32, i32* %r2, i32 8
%r1114 = load i32, i32* %r1113
%r1115 = call i64 @mul32x32L(i32 %r1112, i32 %r1114)
%r1116 = zext i448 %r1110 to i512
%r1117 = zext i64 %r1115 to i512
%r1118 = shl i512 %r1117, 448
%r1119 = or i512 %r1116, %r1118
%r1120 = getelementptr i32, i32* %r2, i32 8
%r1121 = load i32, i32* %r1120
%r1122 = getelementptr i32, i32* %r2, i32 9
%r1123 = load i32, i32* %r1122
%r1124 = call i64 @mul32x32L(i32 %r1121, i32 %r1123)
%r1125 = zext i512 %r1119 to i576
%r1126 = zext i64 %r1124 to i576
%r1127 = shl i576 %r1126, 512
%r1128 = or i576 %r1125, %r1127
%r1129 = getelementptr i32, i32* %r2, i32 9
%r1130 = load i32, i32* %r1129
%r1131 = getelementptr i32, i32* %r2, i32 10
%r1132 = load i32, i32* %r1131
%r1133 = call i64 @mul32x32L(i32 %r1130, i32 %r1132)
%r1134 = zext i576 %r1128 to i640
%r1135 = zext i64 %r1133 to i640
%r1136 = shl i640 %r1135, 576
%r1137 = or i640 %r1134, %r1136
%r1138 = getelementptr i32, i32* %r2, i32 10
%r1139 = load i32, i32* %r1138
%r1140 = getelementptr i32, i32* %r2, i32 11
%r1141 = load i32, i32* %r1140
%r1142 = call i64 @mul32x32L(i32 %r1139, i32 %r1141)
%r1143 = zext i640 %r1137 to i704
%r1144 = zext i64 %r1142 to i704
%r1145 = shl i704 %r1144, 640
%r1146 = or i704 %r1143, %r1145
%r1147 = getelementptr i32, i32* %r2, i32 11
%r1148 = load i32, i32* %r1147
%r1149 = getelementptr i32, i32* %r2, i32 12
%r1150 = load i32, i32* %r1149
%r1151 = call i64 @mul32x32L(i32 %r1148, i32 %r1150)
%r1152 = zext i704 %r1146 to i768
%r1153 = zext i64 %r1151 to i768
%r1154 = shl i768 %r1153, 704
%r1155 = or i768 %r1152, %r1154
%r1156 = getelementptr i32, i32* %r2, i32 12
%r1157 = load i32, i32* %r1156
%r1158 = getelementptr i32, i32* %r2, i32 13
%r1159 = load i32, i32* %r1158
%r1160 = call i64 @mul32x32L(i32 %r1157, i32 %r1159)
%r1161 = zext i768 %r1155 to i832
%r1162 = zext i64 %r1160 to i832
%r1163 = shl i832 %r1162, 768
%r1164 = or i832 %r1161, %r1163
%r1165 = getelementptr i32, i32* %r2, i32 13
%r1166 = load i32, i32* %r1165
%r1167 = getelementptr i32, i32* %r2, i32 14
%r1168 = load i32, i32* %r1167
%r1169 = call i64 @mul32x32L(i32 %r1166, i32 %r1168)
%r1170 = zext i832 %r1164 to i896
%r1171 = zext i64 %r1169 to i896
%r1172 = shl i896 %r1171, 832
%r1173 = or i896 %r1170, %r1172
%r1174 = getelementptr i32, i32* %r2, i32 14
%r1175 = load i32, i32* %r1174
%r1176 = getelementptr i32, i32* %r2, i32 15
%r1177 = load i32, i32* %r1176
%r1178 = call i64 @mul32x32L(i32 %r1175, i32 %r1177)
%r1179 = zext i896 %r1173 to i960
%r1180 = zext i64 %r1178 to i960
%r1181 = shl i960 %r1180, 896
%r1182 = or i960 %r1179, %r1181
%r1183 = getelementptr i32, i32* %r2, i32 15
%r1184 = load i32, i32* %r1183
%r1185 = getelementptr i32, i32* %r2, i32 16
%r1186 = load i32, i32* %r1185
%r1187 = call i64 @mul32x32L(i32 %r1184, i32 %r1186)
%r1188 = zext i960 %r1182 to i1024
%r1189 = zext i64 %r1187 to i1024
%r1190 = shl i1024 %r1189, 960
%r1191 = or i1024 %r1188, %r1190
%r1192 = zext i960 %r1052 to i1024
%r1193 = shl i1024 %r1192, 32
%r1194 = add i1024 %r1193, %r1191
%r1195 = zext i64 %r6 to i1056
%r1196 = getelementptr i32, i32* %r2, i32 1
%r1197 = load i32, i32* %r1196
%r1198 = call i64 @mul32x32L(i32 %r1197, i32 %r1197)
%r1199 = zext i64 %r1198 to i1056
%r1200 = shl i1056 %r1199, 32
%r1201 = or i1056 %r1195, %r1200
%r1202 = getelementptr i32, i32* %r2, i32 2
%r1203 = load i32, i32* %r1202
%r1204 = call i64 @mul32x32L(i32 %r1203, i32 %r1203)
%r1205 = zext i64 %r1204 to i1056
%r1206 = shl i1056 %r1205, 96
%r1207 = or i1056 %r1201, %r1206
%r1208 = getelementptr i32, i32* %r2, i32 3
%r1209 = load i32, i32* %r1208
%r1210 = call i64 @mul32x32L(i32 %r1209, i32 %r1209)
%r1211 = zext i64 %r1210 to i1056
%r1212 = shl i1056 %r1211, 160
%r1213 = or i1056 %r1207, %r1212
%r1214 = getelementptr i32, i32* %r2, i32 4
%r1215 = load i32, i32* %r1214
%r1216 = call i64 @mul32x32L(i32 %r1215, i32 %r1215)
%r1217 = zext i64 %r1216 to i1056
%r1218 = shl i1056 %r1217, 224
%r1219 = or i1056 %r1213, %r1218
%r1220 = getelementptr i32, i32* %r2, i32 5
%r1221 = load i32, i32* %r1220
%r1222 = call i64 @mul32x32L(i32 %r1221, i32 %r1221)
%r1223 = zext i64 %r1222 to i1056
%r1224 = shl i1056 %r1223, 288
%r1225 = or i1056 %r1219, %r1224
%r1226 = getelementptr i32, i32* %r2, i32 6
%r1227 = load i32, i32* %r1226
%r1228 = call i64 @mul32x32L(i32 %r1227, i32 %r1227)
%r1229 = zext i64 %r1228 to i1056
%r1230 = shl i1056 %r1229, 352
%r1231 = or i1056 %r1225, %r1230
%r1232 = getelementptr i32, i32* %r2, i32 7
%r1233 = load i32, i32* %r1232
%r1234 = call i64 @mul32x32L(i32 %r1233, i32 %r1233)
%r1235 = zext i64 %r1234 to i1056
%r1236 = shl i1056 %r1235, 416
%r1237 = or i1056 %r1231, %r1236
%r1238 = getelementptr i32, i32* %r2, i32 8
%r1239 = load i32, i32* %r1238
%r1240 = call i64 @mul32x32L(i32 %r1239, i32 %r1239)
%r1241 = zext i64 %r1240 to i1056
%r1242 = shl i1056 %r1241, 480
%r1243 = or i1056 %r1237, %r1242
%r1244 = getelementptr i32, i32* %r2, i32 9
%r1245 = load i32, i32* %r1244
%r1246 = call i64 @mul32x32L(i32 %r1245, i32 %r1245)
%r1247 = zext i64 %r1246 to i1056
%r1248 = shl i1056 %r1247, 544
%r1249 = or i1056 %r1243, %r1248
%r1250 = getelementptr i32, i32* %r2, i32 10
%r1251 = load i32, i32* %r1250
%r1252 = call i64 @mul32x32L(i32 %r1251, i32 %r1251)
%r1253 = zext i64 %r1252 to i1056
%r1254 = shl i1056 %r1253, 608
%r1255 = or i1056 %r1249, %r1254
%r1256 = getelementptr i32, i32* %r2, i32 11
%r1257 = load i32, i32* %r1256
%r1258 = call i64 @mul32x32L(i32 %r1257, i32 %r1257)
%r1259 = zext i64 %r1258 to i1056
%r1260 = shl i1056 %r1259, 672
%r1261 = or i1056 %r1255, %r1260
%r1262 = getelementptr i32, i32* %r2, i32 12
%r1263 = load i32, i32* %r1262
%r1264 = call i64 @mul32x32L(i32 %r1263, i32 %r1263)
%r1265 = zext i64 %r1264 to i1056
%r1266 = shl i1056 %r1265, 736
%r1267 = or i1056 %r1261, %r1266
%r1268 = getelementptr i32, i32* %r2, i32 13
%r1269 = load i32, i32* %r1268
%r1270 = call i64 @mul32x32L(i32 %r1269, i32 %r1269)
%r1271 = zext i64 %r1270 to i1056
%r1272 = shl i1056 %r1271, 800
%r1273 = or i1056 %r1267, %r1272
%r1274 = getelementptr i32, i32* %r2, i32 14
%r1275 = load i32, i32* %r1274
%r1276 = call i64 @mul32x32L(i32 %r1275, i32 %r1275)
%r1277 = zext i64 %r1276 to i1056
%r1278 = shl i1056 %r1277, 864
%r1279 = or i1056 %r1273, %r1278
%r1280 = getelementptr i32, i32* %r2, i32 15
%r1281 = load i32, i32* %r1280
%r1282 = call i64 @mul32x32L(i32 %r1281, i32 %r1281)
%r1283 = zext i64 %r1282 to i1056
%r1284 = shl i1056 %r1283, 928
%r1285 = or i1056 %r1279, %r1284
%r1286 = getelementptr i32, i32* %r2, i32 16
%r1287 = load i32, i32* %r1286
%r1288 = call i64 @mul32x32L(i32 %r1287, i32 %r1287)
%r1289 = zext i64 %r1288 to i1056
%r1290 = shl i1056 %r1289, 992
%r1291 = or i1056 %r1285, %r1290
%r1292 = zext i1024 %r1194 to i1056
%r1293 = add i1056 %r1292, %r1292
%r1294 = add i1056 %r1291, %r1293
%r1295 = getelementptr i32, i32* %r1, i32 1
%r1296 = bitcast i32* %r1295 to i1056*
store i1056 %r1294, i1056* %r1296
ret void
}
