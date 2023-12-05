; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt -passes='loop(indvars),verify' -S < %s | FileCheck %s

target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128-ni:1-p2:32:8:8:32-ni:2"
target triple = "x86_64-unknown-linux-gnu"

define void @test() {
; CHECK-LABEL: @test(
; CHECK-NEXT:  bb:
; CHECK-NEXT:    [[VAR:%.*]] = load atomic i32, ptr addrspace(1) poison unordered, align 8, !range [[RNG0:![0-9]+]], !invariant.load !1, !noundef !1
; CHECK-NEXT:    [[VAR2:%.*]] = icmp eq i32 [[VAR]], 0
; CHECK-NEXT:    br i1 [[VAR2]], label [[BB18:%.*]], label [[BB19:%.*]]
; CHECK:       bb3:
; CHECK-NEXT:    [[INDVARS_IV:%.*]] = phi i64 [ 0, [[BB19]] ], [ [[INDVARS_IV_NEXT:%.*]], [[BB12:%.*]] ]
; CHECK-NEXT:    br i1 true, label [[BB8:%.*]], label [[BB7:%.*]]
; CHECK:       bb7:
; CHECK-NEXT:    ret void
; CHECK:       bb8:
; CHECK-NEXT:    [[VAR9:%.*]] = load atomic i32, ptr addrspace(1) poison unordered, align 8, !range [[RNG0]], !invariant.load !1, !noundef !1
; CHECK-NEXT:    [[TMP0:%.*]] = zext i32 [[VAR9]] to i64
; CHECK-NEXT:    [[VAR10:%.*]] = icmp ult i64 [[INDVARS_IV]], [[TMP0]]
; CHECK-NEXT:    br i1 [[VAR10]], label [[BB12]], label [[BB11:%.*]]
; CHECK:       bb11:
; CHECK-NEXT:    ret void
; CHECK:       bb12:
; CHECK-NEXT:    [[INDVARS_IV_NEXT]] = add nuw nsw i64 [[INDVARS_IV]], 1
; CHECK-NEXT:    [[EXITCOND:%.*]] = icmp ne i64 [[INDVARS_IV_NEXT]], [[TMP1:%.*]]
; CHECK-NEXT:    br i1 [[EXITCOND]], label [[BB3:%.*]], label [[BB17:%.*]]
; CHECK:       bb17:
; CHECK-NEXT:    unreachable
; CHECK:       bb18:
; CHECK-NEXT:    ret void
; CHECK:       bb19:
; CHECK-NEXT:    [[TMP1]] = zext i32 [[VAR]] to i64
; CHECK-NEXT:    br label [[BB3]]
;
bb:
  %var = load atomic i32, ptr addrspace(1) poison unordered, align 8, !range !0, !invariant.load !1, !noundef !1
  %var1 = add nsw i32 %var, -1
  %var2 = icmp eq i32 %var, 0
  br i1 %var2, label %bb18, label %bb19

bb3:                                              ; preds = %bb19, %bb12
  %var4 = phi i32 [ %var15, %bb12 ], [ 0, %bb19 ]
  %var5 = sub nsw i32 %var1, %var4
  %var6 = icmp ult i32 %var5, %var
  br i1 %var6, label %bb8, label %bb7

bb7:                                              ; preds = %bb3
  ret void

bb8:                                              ; preds = %bb3
  %var9 = load atomic i32, ptr addrspace(1) poison unordered, align 8, !range !0, !invariant.load !1, !noundef !1
  %var10 = icmp ult i32 %var4, %var9
  br i1 %var10, label %bb12, label %bb11

bb11:                                             ; preds = %bb8
  ret void

bb12:                                             ; preds = %bb8
  %var13 = zext i32 %var4 to i64
  %var14 = getelementptr inbounds i32, ptr addrspace(1) poison, i64 %var13
  %var15 = add nuw nsw i32 %var4, 1
  %var16 = icmp ult i32 %var15, %var
  br i1 %var16, label %bb3, label %bb17

bb17:                                             ; preds = %bb12
  unreachable

bb18:                                             ; preds = %bb
  ret void

bb19:                                             ; preds = %bb
  br label %bb3
}

!0 = !{i32 0, i32 2147483646}
!1 = !{}