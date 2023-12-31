// NOTE: Assertions have been autogenerated by utils/update_cc_test_checks.py
// RUN: %clang_cc1 -triple riscv64 -target-feature +zbkx -emit-llvm %s -o - \
// RUN:     -disable-O0-optnone | opt -S -passes=mem2reg \
// RUN:     | FileCheck %s  -check-prefix=RV64ZBKX

#include <stdint.h>

// RV64ZBKX-LABEL: @xperm8(
// RV64ZBKX-NEXT:  entry:
// RV64ZBKX-NEXT:    [[TMP0:%.*]] = call i64 @llvm.riscv.xperm8.i64(i64 [[RS1:%.*]], i64 [[RS2:%.*]])
// RV64ZBKX-NEXT:    ret i64 [[TMP0]]
//
uint64_t xperm8(uint64_t rs1, uint64_t rs2)
{
  return __builtin_riscv_xperm8_64(rs1, rs2);
}

// RV64ZBKX-LABEL: @xperm4(
// RV64ZBKX-NEXT:  entry:
// RV64ZBKX-NEXT:    [[TMP0:%.*]] = call i64 @llvm.riscv.xperm4.i64(i64 [[RS1:%.*]], i64 [[RS2:%.*]])
// RV64ZBKX-NEXT:    ret i64 [[TMP0]]
//
uint64_t xperm4(uint64_t rs1, uint64_t rs2)
{
  return __builtin_riscv_xperm4_64(rs1, rs2);
}
