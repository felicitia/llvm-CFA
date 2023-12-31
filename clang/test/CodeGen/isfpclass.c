// NOTE: Assertions have been autogenerated by utils/update_cc_test_checks.py UTC_ARGS: --version 2
// RUN: %clang_cc1 -triple aarch64-linux-gnu -S -O1 -emit-llvm %s -o - | FileCheck %s

// CHECK-LABEL: define dso_local i1 @check_isfpclass_finite
// CHECK-SAME: (float noundef [[X:%.*]]) local_unnamed_addr #[[ATTR0:[0-9]+]] {
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = tail call i1 @llvm.is.fpclass.f32(float [[X]], i32 504)
// CHECK-NEXT:    ret i1 [[TMP0]]
//
_Bool check_isfpclass_finite(float x) {
  return __builtin_isfpclass(x, 504 /*Finite*/);
}

// CHECK-LABEL: define dso_local i1 @check_isfpclass_finite_strict
// CHECK-SAME: (float noundef [[X:%.*]]) local_unnamed_addr #[[ATTR2:[0-9]+]] {
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = tail call i1 @llvm.is.fpclass.f32(float [[X]], i32 504) #[[ATTR4:[0-9]+]]
// CHECK-NEXT:    ret i1 [[TMP0]]
//
_Bool check_isfpclass_finite_strict(float x) {
#pragma STDC FENV_ACCESS ON
  return __builtin_isfpclass(x, 504 /*Finite*/);
}

// CHECK-LABEL: define dso_local i1 @check_isfpclass_nan_f32
// CHECK-SAME: (float noundef [[X:%.*]]) local_unnamed_addr #[[ATTR3:[0-9]+]] {
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = fcmp uno float [[X]], 0.000000e+00
// CHECK-NEXT:    ret i1 [[TMP0]]
//
_Bool check_isfpclass_nan_f32(float x) {
  return __builtin_isfpclass(x, 3 /*NaN*/);
}

// CHECK-LABEL: define dso_local i1 @check_isfpclass_nan_f32_strict
// CHECK-SAME: (float noundef [[X:%.*]]) local_unnamed_addr #[[ATTR2]] {
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = tail call i1 @llvm.is.fpclass.f32(float [[X]], i32 3) #[[ATTR4]]
// CHECK-NEXT:    ret i1 [[TMP0]]
//
_Bool check_isfpclass_nan_f32_strict(float x) {
#pragma STDC FENV_ACCESS ON
  return __builtin_isfpclass(x, 3 /*NaN*/);
}

// CHECK-LABEL: define dso_local i1 @check_isfpclass_snan_f64
// CHECK-SAME: (double noundef [[X:%.*]]) local_unnamed_addr #[[ATTR0]] {
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = tail call i1 @llvm.is.fpclass.f64(double [[X]], i32 1)
// CHECK-NEXT:    ret i1 [[TMP0]]
//
_Bool check_isfpclass_snan_f64(double x) {
  return __builtin_isfpclass(x, 1 /*SNaN*/);
}

// CHECK-LABEL: define dso_local i1 @check_isfpclass_snan_f64_strict
// CHECK-SAME: (double noundef [[X:%.*]]) local_unnamed_addr #[[ATTR2]] {
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = tail call i1 @llvm.is.fpclass.f64(double [[X]], i32 1) #[[ATTR4]]
// CHECK-NEXT:    ret i1 [[TMP0]]
//
_Bool check_isfpclass_snan_f64_strict(double x) {
#pragma STDC FENV_ACCESS ON
  return __builtin_isfpclass(x, 1 /*NaN*/);
}

// CHECK-LABEL: define dso_local i1 @check_isfpclass_zero_f16
// CHECK-SAME: (half noundef [[X:%.*]]) local_unnamed_addr #[[ATTR3]] {
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = fcmp oeq half [[X]], 0xH0000
// CHECK-NEXT:    ret i1 [[TMP0]]
//
_Bool check_isfpclass_zero_f16(_Float16 x) {
  return __builtin_isfpclass(x, 96 /*Zero*/);
}

// CHECK-LABEL: define dso_local i1 @check_isfpclass_zero_f16_strict
// CHECK-SAME: (half noundef [[X:%.*]]) local_unnamed_addr #[[ATTR2]] {
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = tail call i1 @llvm.is.fpclass.f16(half [[X]], i32 96) #[[ATTR4]]
// CHECK-NEXT:    ret i1 [[TMP0]]
//
_Bool check_isfpclass_zero_f16_strict(_Float16 x) {
#pragma STDC FENV_ACCESS ON
  return __builtin_isfpclass(x, 96 /*Zero*/);
}

_Bool check_isnan(float x) {
#pragma STDC FENV_ACCESS ON
  return __builtin_isnan(x);
}

_Bool check_isinf(float x) {
#pragma STDC FENV_ACCESS ON
  return __builtin_isinf(x);
}

_Bool check_isfinite(float x) {
#pragma STDC FENV_ACCESS ON
  return __builtin_isfinite(x);
}

_Bool check_isnormal(float x) {
#pragma STDC FENV_ACCESS ON
  return __builtin_isnormal(x);
}

