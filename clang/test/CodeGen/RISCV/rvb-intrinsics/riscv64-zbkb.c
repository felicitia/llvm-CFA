// NOTE: Assertions have been autogenerated by utils/update_cc_test_checks.py
// RUN: %clang_cc1 -triple riscv64 -target-feature +zbkb -emit-llvm %s -o - \
// RUN:     -disable-O0-optnone | opt -S -passes=mem2reg \
// RUN:     | FileCheck %s  -check-prefix=RV64ZBKB

#include <stdint.h>

// RV64ZBKB-LABEL: @brev8_32(
// RV64ZBKB-NEXT:  entry:
// RV64ZBKB-NEXT:    [[TMP0:%.*]] = call i32 @llvm.riscv.brev8.i32(i32 [[RS1:%.*]])
// RV64ZBKB-NEXT:    ret i32 [[TMP0]]
//
uint32_t brev8_32(uint32_t rs1)
{
  return __builtin_riscv_brev8_32(rs1);
}

// RV64ZBKB-LABEL: @brev8_64(
// RV64ZBKB-NEXT:  entry:
// RV64ZBKB-NEXT:    [[TMP0:%.*]] = call i64 @llvm.riscv.brev8.i64(i64 [[RS1:%.*]])
// RV64ZBKB-NEXT:    ret i64 [[TMP0]]
//
uint64_t brev8_64(uint64_t rs1)
{
  return __builtin_riscv_brev8_64(rs1);
}
