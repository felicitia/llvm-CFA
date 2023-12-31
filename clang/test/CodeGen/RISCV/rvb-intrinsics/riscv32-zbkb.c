// NOTE: Assertions have been autogenerated by utils/update_cc_test_checks.py
// RUN: %clang_cc1 -triple riscv32 -target-feature +zbkb -emit-llvm %s -o - \
// RUN:     -disable-O0-optnone | opt -S -passes=mem2reg \
// RUN:     | FileCheck %s  -check-prefix=RV32ZBKB

#include <stdint.h>

// RV32ZBKB-LABEL: @brev8(
// RV32ZBKB-NEXT:  entry:
// RV32ZBKB-NEXT:    [[TMP0:%.*]] = call i32 @llvm.riscv.brev8.i32(i32 [[RS1:%.*]])
// RV32ZBKB-NEXT:    ret i32 [[TMP0]]
//
uint32_t brev8(uint32_t rs1)
{
  return __builtin_riscv_brev8_32(rs1);
}

// RV32ZBKB-LABEL: @zip(
// RV32ZBKB-NEXT:  entry:
// RV32ZBKB-NEXT:    [[TMP0:%.*]] = call i32 @llvm.riscv.zip.i32(i32 [[RS1:%.*]])
// RV32ZBKB-NEXT:    ret i32 [[TMP0]]
//
uint32_t zip(uint32_t rs1)
{
  return __builtin_riscv_zip_32(rs1);
}

// RV32ZBKB-LABEL: @unzip(
// RV32ZBKB-NEXT:  entry:
// RV32ZBKB-NEXT:    [[TMP0:%.*]] = call i32 @llvm.riscv.unzip.i32(i32 [[RS1:%.*]])
// RV32ZBKB-NEXT:    ret i32 [[TMP0]]
//
uint32_t unzip(uint32_t rs1)
{
  return __builtin_riscv_unzip_32(rs1);
}
