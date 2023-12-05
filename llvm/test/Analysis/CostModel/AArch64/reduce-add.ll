; NOTE: Assertions have been autogenerated by utils/update_analyze_test_checks.py
; RUN: opt < %s -mtriple=aarch64-unknown-linux-gnu -passes="print<cost-model>" -cost-kind=throughput 2>&1 -disable-output | FileCheck %s

target datalayout = "e-m:e-i8:8:32-i16:16:32-i64:64-i128:128-n32:64-S128"

define void @reduce() {
; CHECK-LABEL: 'reduce'
; CHECK-NEXT:  Cost Model: Found an estimated cost of 2 for instruction: %V1i8 = call i8 @llvm.vector.reduce.add.v1i8(<1 x i8> undef)
; CHECK-NEXT:  Cost Model: Found an estimated cost of 2 for instruction: %V3i8 = call i8 @llvm.vector.reduce.add.v3i8(<3 x i8> undef)
; CHECK-NEXT:  Cost Model: Found an estimated cost of 2 for instruction: %V4i8 = call i8 @llvm.vector.reduce.add.v4i8(<4 x i8> undef)
; CHECK-NEXT:  Cost Model: Found an estimated cost of 2 for instruction: %V8i8 = call i8 @llvm.vector.reduce.add.v8i8(<8 x i8> undef)
; CHECK-NEXT:  Cost Model: Found an estimated cost of 2 for instruction: %V16i8 = call i8 @llvm.vector.reduce.add.v16i8(<16 x i8> undef)
; CHECK-NEXT:  Cost Model: Found an estimated cost of 3 for instruction: %V32i8 = call i8 @llvm.vector.reduce.add.v32i8(<32 x i8> undef)
; CHECK-NEXT:  Cost Model: Found an estimated cost of 5 for instruction: %V64i8 = call i8 @llvm.vector.reduce.add.v64i8(<64 x i8> undef)
; CHECK-NEXT:  Cost Model: Found an estimated cost of 2 for instruction: %V2i16 = call i16 @llvm.vector.reduce.add.v2i16(<2 x i16> undef)
; CHECK-NEXT:  Cost Model: Found an estimated cost of 2 for instruction: %V4i16 = call i16 @llvm.vector.reduce.add.v4i16(<4 x i16> undef)
; CHECK-NEXT:  Cost Model: Found an estimated cost of 2 for instruction: %V8i16 = call i16 @llvm.vector.reduce.add.v8i16(<8 x i16> undef)
; CHECK-NEXT:  Cost Model: Found an estimated cost of 3 for instruction: %V16i16 = call i16 @llvm.vector.reduce.add.v16i16(<16 x i16> undef)
; CHECK-NEXT:  Cost Model: Found an estimated cost of 2 for instruction: %V2i32 = call i32 @llvm.vector.reduce.add.v2i32(<2 x i32> undef)
; CHECK-NEXT:  Cost Model: Found an estimated cost of 2 for instruction: %V4i32 = call i32 @llvm.vector.reduce.add.v4i32(<4 x i32> undef)
; CHECK-NEXT:  Cost Model: Found an estimated cost of 3 for instruction: %V8i32 = call i32 @llvm.vector.reduce.add.v8i32(<8 x i32> undef)
; CHECK-NEXT:  Cost Model: Found an estimated cost of 2 for instruction: %V2i64 = call i64 @llvm.vector.reduce.add.v2i64(<2 x i64> undef)
; CHECK-NEXT:  Cost Model: Found an estimated cost of 3 for instruction: %V4i64 = call i64 @llvm.vector.reduce.add.v4i64(<4 x i64> undef)
; CHECK-NEXT:  Cost Model: Found an estimated cost of 0 for instruction: ret void
;
  %V1i8 = call i8 @llvm.vector.reduce.add.v1i8(<1 x i8> undef)
  %V3i8 = call i8 @llvm.vector.reduce.add.v3i8(<3 x i8> undef)
  %V4i8 = call i8 @llvm.vector.reduce.add.v4i8(<4 x i8> undef)
  %V8i8 = call i8 @llvm.vector.reduce.add.v8i8(<8 x i8> undef)
  %V16i8 = call i8 @llvm.vector.reduce.add.v16i8(<16 x i8> undef)
  %V32i8 = call i8 @llvm.vector.reduce.add.v32i8(<32 x i8> undef)
  %V64i8 = call i8 @llvm.vector.reduce.add.v64i8(<64 x i8> undef)
  %V2i16 = call i16 @llvm.vector.reduce.add.v2i16(<2 x i16> undef)
  %V4i16 = call i16 @llvm.vector.reduce.add.v4i16(<4 x i16> undef)
  %V8i16 = call i16 @llvm.vector.reduce.add.v8i16(<8 x i16> undef)
  %V16i16 = call i16 @llvm.vector.reduce.add.v16i16(<16 x i16> undef)
  %V2i32 = call i32 @llvm.vector.reduce.add.v2i32(<2 x i32> undef)
  %V4i32 = call i32 @llvm.vector.reduce.add.v4i32(<4 x i32> undef)
  %V8i32 = call i32 @llvm.vector.reduce.add.v8i32(<8 x i32> undef)
  %V2i64 = call i64 @llvm.vector.reduce.add.v2i64(<2 x i64> undef)
  %V4i64 = call i64 @llvm.vector.reduce.add.v4i64(<4 x i64> undef)
  ret void
}

declare i8 @llvm.vector.reduce.add.v1i8(<1 x i8>)
declare i8 @llvm.vector.reduce.add.v3i8(<3 x i8>)
declare i8 @llvm.vector.reduce.add.v4i8(<4 x i8>)
declare i8 @llvm.vector.reduce.add.v8i8(<8 x i8>)
declare i8 @llvm.vector.reduce.add.v16i8(<16 x i8>)
declare i8 @llvm.vector.reduce.add.v32i8(<32 x i8>)
declare i8 @llvm.vector.reduce.add.v64i8(<64 x i8>)
declare i16 @llvm.vector.reduce.add.v2i16(<2 x i16>)
declare i16 @llvm.vector.reduce.add.v4i16(<4 x i16>)
declare i16 @llvm.vector.reduce.add.v8i16(<8 x i16>)
declare i16 @llvm.vector.reduce.add.v16i16(<16 x i16>)
declare i32 @llvm.vector.reduce.add.v2i32(<2 x i32>)
declare i32 @llvm.vector.reduce.add.v4i32(<4 x i32>)
declare i32 @llvm.vector.reduce.add.v8i32(<8 x i32>)
declare i64 @llvm.vector.reduce.add.v2i64(<2 x i64>)
declare i64 @llvm.vector.reduce.add.v4i64(<4 x i64>)