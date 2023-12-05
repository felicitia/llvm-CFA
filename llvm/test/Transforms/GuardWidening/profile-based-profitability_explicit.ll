; NOTE: Assertions have been autogenerated by utils/update_test_checks.py UTC_ARGS: --version 2
; RUN: opt -S -passes=guard-widening < %s | FileCheck %s

; Hot loop, frequently entered, should widen.
define i32 @test_intrinsic_very_profitable(i32 %n, i1 %cond.1, i1 %cond.2) {
; CHECK-LABEL: define i32 @test_intrinsic_very_profitable
; CHECK-SAME: (i32 [[N:%.*]], i1 [[COND_1:%.*]], i1 [[COND_2:%.*]]) {
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[COND_2_GW_FR:%.*]] = freeze i1 [[COND_2]]
; CHECK-NEXT:    [[WIDE_CHK:%.*]] = and i1 [[COND_1]], [[COND_2_GW_FR]]
; CHECK-NEXT:    [[WIDENABLE_COND:%.*]] = call i1 @llvm.experimental.widenable.condition()
; CHECK-NEXT:    [[EXIPLICIT_GUARD_COND:%.*]] = and i1 [[WIDE_CHK]], [[WIDENABLE_COND]]
; CHECK-NEXT:    br i1 [[EXIPLICIT_GUARD_COND]], label [[GUARDED:%.*]], label [[DEOPT:%.*]], !prof [[PROF0:![0-9]+]]
; CHECK:       deopt:
; CHECK-NEXT:    [[DEOPTCALL:%.*]] = call i32 (...) @llvm.experimental.deoptimize.i32() [ "deopt"() ]
; CHECK-NEXT:    ret i32 [[DEOPTCALL]]
; CHECK:       guarded:
; CHECK-NEXT:    [[LOOP_PRECONDITION:%.*]] = icmp uge i32 [[N]], 100
; CHECK-NEXT:    br i1 [[LOOP_PRECONDITION]], label [[LOOP:%.*]], label [[FAILED:%.*]], !prof [[PROF0]]
; CHECK:       loop:
; CHECK-NEXT:    [[IV:%.*]] = phi i32 [ 0, [[GUARDED]] ], [ [[IV_NEXT:%.*]], [[GUARDED1:%.*]] ]
; CHECK-NEXT:    [[WIDENABLE_COND4:%.*]] = call i1 @llvm.experimental.widenable.condition()
; CHECK-NEXT:    [[EXIPLICIT_GUARD_COND5:%.*]] = and i1 [[COND_2_GW_FR]], [[WIDENABLE_COND4]]
; CHECK-NEXT:    br i1 true, label [[GUARDED1]], label [[DEOPT2:%.*]], !prof [[PROF0]]
; CHECK:       deopt2:
; CHECK-NEXT:    [[DEOPTCALL3:%.*]] = call i32 (...) @llvm.experimental.deoptimize.i32() [ "deopt"() ]
; CHECK-NEXT:    ret i32 [[DEOPTCALL3]]
; CHECK:       guarded1:
; CHECK-NEXT:    [[IV_NEXT]] = add nuw nsw i32 [[IV]], 1
; CHECK-NEXT:    [[LOOP_COND:%.*]] = icmp ult i32 [[IV_NEXT]], 100
; CHECK-NEXT:    br i1 [[LOOP_COND]], label [[LOOP]], label [[EXIT:%.*]], !prof [[PROF1:![0-9]+]]
; CHECK:       exit:
; CHECK-NEXT:    ret i32 0
; CHECK:       failed:
; CHECK-NEXT:    ret i32 -1
;
entry:
  %widenable_cond = call i1 @llvm.experimental.widenable.condition()
  %exiplicit_guard_cond = and i1 %cond.1, %widenable_cond
  br i1 %exiplicit_guard_cond, label %guarded, label %deopt, !prof !0

deopt:                                            ; preds = %entry
  %deoptcall = call i32 (...) @llvm.experimental.deoptimize.i32() [ "deopt"() ]
  ret i32 %deoptcall

guarded:                                          ; preds = %entry
  %loop.precondition = icmp uge i32 %n, 100
  br i1 %loop.precondition, label %loop, label %failed, !prof !0

loop:                                             ; preds = %guarded1, %guarded
  %iv = phi i32 [ 0, %guarded ], [ %iv.next, %guarded1 ]
  %widenable_cond4 = call i1 @llvm.experimental.widenable.condition()
  %exiplicit_guard_cond5 = and i1 %cond.2, %widenable_cond4
  br i1 %exiplicit_guard_cond5, label %guarded1, label %deopt2, !prof !0

deopt2:                                           ; preds = %loop
  %deoptcall3 = call i32 (...) @llvm.experimental.deoptimize.i32() [ "deopt"() ]
  ret i32 %deoptcall3

guarded1:                                         ; preds = %loop
  %iv.next = add nuw nsw i32 %iv, 1
  %loop.cond = icmp ult i32 %iv.next, 100
  br i1 %loop.cond, label %loop, label %exit, !prof !1

exit:                                             ; preds = %guarded1
  ret i32 0

failed:                                           ; preds = %guarded
  ret i32 -1
}

; Even though the loop is rarely entered, it has so many iterations that the widening
; is still profitable.
define i32 @test_intrinsic_profitable(i32 %n, i1 %cond.1, i1 %cond.2) {
; CHECK-LABEL: define i32 @test_intrinsic_profitable
; CHECK-SAME: (i32 [[N:%.*]], i1 [[COND_1:%.*]], i1 [[COND_2:%.*]]) {
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[COND_2_GW_FR:%.*]] = freeze i1 [[COND_2]]
; CHECK-NEXT:    [[WIDE_CHK:%.*]] = and i1 [[COND_1]], [[COND_2_GW_FR]]
; CHECK-NEXT:    [[WIDENABLE_COND:%.*]] = call i1 @llvm.experimental.widenable.condition()
; CHECK-NEXT:    [[EXIPLICIT_GUARD_COND:%.*]] = and i1 [[WIDE_CHK]], [[WIDENABLE_COND]]
; CHECK-NEXT:    br i1 [[EXIPLICIT_GUARD_COND]], label [[GUARDED:%.*]], label [[DEOPT:%.*]], !prof [[PROF0]]
; CHECK:       deopt:
; CHECK-NEXT:    [[DEOPTCALL:%.*]] = call i32 (...) @llvm.experimental.deoptimize.i32() [ "deopt"() ]
; CHECK-NEXT:    ret i32 [[DEOPTCALL]]
; CHECK:       guarded:
; CHECK-NEXT:    [[LOOP_PRECONDITION:%.*]] = icmp uge i32 [[N]], 100
; CHECK-NEXT:    br i1 [[LOOP_PRECONDITION]], label [[LOOP:%.*]], label [[FAILED:%.*]], !prof [[PROF2:![0-9]+]]
; CHECK:       loop:
; CHECK-NEXT:    [[IV:%.*]] = phi i32 [ 0, [[GUARDED]] ], [ [[IV_NEXT:%.*]], [[GUARDED1:%.*]] ]
; CHECK-NEXT:    [[WIDENABLE_COND4:%.*]] = call i1 @llvm.experimental.widenable.condition()
; CHECK-NEXT:    [[EXIPLICIT_GUARD_COND5:%.*]] = and i1 [[COND_2_GW_FR]], [[WIDENABLE_COND4]]
; CHECK-NEXT:    br i1 true, label [[GUARDED1]], label [[DEOPT2:%.*]], !prof [[PROF0]]
; CHECK:       deopt2:
; CHECK-NEXT:    [[DEOPTCALL3:%.*]] = call i32 (...) @llvm.experimental.deoptimize.i32() [ "deopt"() ]
; CHECK-NEXT:    ret i32 [[DEOPTCALL3]]
; CHECK:       guarded1:
; CHECK-NEXT:    [[IV_NEXT]] = add nuw nsw i32 [[IV]], 1
; CHECK-NEXT:    [[LOOP_COND:%.*]] = icmp ult i32 [[IV_NEXT]], 100
; CHECK-NEXT:    br i1 [[LOOP_COND]], label [[LOOP]], label [[EXIT:%.*]], !prof [[PROF1]]
; CHECK:       exit:
; CHECK-NEXT:    ret i32 0
; CHECK:       failed:
; CHECK-NEXT:    ret i32 -1
;
entry:
  %widenable_cond = call i1 @llvm.experimental.widenable.condition()
  %exiplicit_guard_cond = and i1 %cond.1, %widenable_cond
  br i1 %exiplicit_guard_cond, label %guarded, label %deopt, !prof !0

deopt:                                            ; preds = %entry
  %deoptcall = call i32 (...) @llvm.experimental.deoptimize.i32() [ "deopt"() ]
  ret i32 %deoptcall

guarded:                                          ; preds = %entry
  %loop.precondition = icmp uge i32 %n, 100
  br i1 %loop.precondition, label %loop, label %failed, !prof !2

loop:                                             ; preds = %guarded1, %guarded
  %iv = phi i32 [ 0, %guarded ], [ %iv.next, %guarded1 ]
  %widenable_cond4 = call i1 @llvm.experimental.widenable.condition()
  %exiplicit_guard_cond5 = and i1 %cond.2, %widenable_cond4
  br i1 %exiplicit_guard_cond5, label %guarded1, label %deopt2, !prof !0

deopt2:                                           ; preds = %loop
  %deoptcall3 = call i32 (...) @llvm.experimental.deoptimize.i32() [ "deopt"() ]
  ret i32 %deoptcall3

guarded1:                                         ; preds = %loop
  %iv.next = add nuw nsw i32 %iv, 1
  %loop.cond = icmp ult i32 %iv.next, 100
  br i1 %loop.cond, label %loop, label %exit, !prof !1

exit:                                             ; preds = %guarded1
  ret i32 0

failed:                                           ; preds = %guarded
  ret i32 -1
}

; Loop's hotness compensates rareness of its entrance. We still want to widen, because
; it may open up some optimization opportunities.
define i32 @test_intrinsic_neutral(i32 %n, i1 %cond.1, i1 %cond.2) {
; CHECK-LABEL: define i32 @test_intrinsic_neutral
; CHECK-SAME: (i32 [[N:%.*]], i1 [[COND_1:%.*]], i1 [[COND_2:%.*]]) {
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[COND_2_GW_FR:%.*]] = freeze i1 [[COND_2]]
; CHECK-NEXT:    [[WIDE_CHK:%.*]] = and i1 [[COND_1]], [[COND_2_GW_FR]]
; CHECK-NEXT:    [[WIDENABLE_COND:%.*]] = call i1 @llvm.experimental.widenable.condition()
; CHECK-NEXT:    [[EXIPLICIT_GUARD_COND:%.*]] = and i1 [[WIDE_CHK]], [[WIDENABLE_COND]]
; CHECK-NEXT:    br i1 [[EXIPLICIT_GUARD_COND]], label [[GUARDED:%.*]], label [[DEOPT:%.*]], !prof [[PROF0]]
; CHECK:       deopt:
; CHECK-NEXT:    [[DEOPTCALL:%.*]] = call i32 (...) @llvm.experimental.deoptimize.i32() [ "deopt"() ]
; CHECK-NEXT:    ret i32 [[DEOPTCALL]]
; CHECK:       guarded:
; CHECK-NEXT:    [[LOOP_PRECONDITION:%.*]] = icmp uge i32 [[N]], 100
; CHECK-NEXT:    br i1 [[LOOP_PRECONDITION]], label [[LOOP:%.*]], label [[FAILED:%.*]], !prof [[PROF3:![0-9]+]]
; CHECK:       loop:
; CHECK-NEXT:    [[IV:%.*]] = phi i32 [ 0, [[GUARDED]] ], [ [[IV_NEXT:%.*]], [[GUARDED1:%.*]] ]
; CHECK-NEXT:    [[WIDENABLE_COND4:%.*]] = call i1 @llvm.experimental.widenable.condition()
; CHECK-NEXT:    [[EXIPLICIT_GUARD_COND5:%.*]] = and i1 [[COND_2_GW_FR]], [[WIDENABLE_COND4]]
; CHECK-NEXT:    br i1 true, label [[GUARDED1]], label [[DEOPT2:%.*]], !prof [[PROF0]]
; CHECK:       deopt2:
; CHECK-NEXT:    [[DEOPTCALL3:%.*]] = call i32 (...) @llvm.experimental.deoptimize.i32() [ "deopt"() ]
; CHECK-NEXT:    ret i32 [[DEOPTCALL3]]
; CHECK:       guarded1:
; CHECK-NEXT:    [[IV_NEXT]] = add nuw nsw i32 [[IV]], 1
; CHECK-NEXT:    [[LOOP_COND:%.*]] = icmp ult i32 [[IV_NEXT]], 100
; CHECK-NEXT:    br i1 [[LOOP_COND]], label [[LOOP]], label [[EXIT:%.*]], !prof [[PROF1]]
; CHECK:       exit:
; CHECK-NEXT:    ret i32 0
; CHECK:       failed:
; CHECK-NEXT:    ret i32 -1
;
entry:
  %widenable_cond = call i1 @llvm.experimental.widenable.condition()
  %exiplicit_guard_cond = and i1 %cond.1, %widenable_cond
  br i1 %exiplicit_guard_cond, label %guarded, label %deopt, !prof !0

deopt:                                            ; preds = %entry
  %deoptcall = call i32 (...) @llvm.experimental.deoptimize.i32() [ "deopt"() ]
  ret i32 %deoptcall

guarded:                                          ; preds = %entry
  %loop.precondition = icmp uge i32 %n, 100
  br i1 %loop.precondition, label %loop, label %failed, !prof !3

loop:                                             ; preds = %guarded1, %guarded
  %iv = phi i32 [ 0, %guarded ], [ %iv.next, %guarded1 ]
  %widenable_cond4 = call i1 @llvm.experimental.widenable.condition()
  %exiplicit_guard_cond5 = and i1 %cond.2, %widenable_cond4
  br i1 %exiplicit_guard_cond5, label %guarded1, label %deopt2, !prof !0

deopt2:                                           ; preds = %loop
  %deoptcall3 = call i32 (...) @llvm.experimental.deoptimize.i32() [ "deopt"() ]
  ret i32 %deoptcall3

guarded1:                                         ; preds = %loop
  %iv.next = add nuw nsw i32 %iv, 1
  %loop.cond = icmp ult i32 %iv.next, 100
  br i1 %loop.cond, label %loop, label %exit, !prof !1

exit:                                             ; preds = %guarded1
  ret i32 0

failed:                                           ; preds = %guarded
  ret i32 -1
}

; FIXME: This loop is so rarely entered, that we don't want to widen here.
define i32 @test_intrinsic_very_unprofitable(i32 %n, i1 %cond.1, i1 %cond.2) {
; CHECK-LABEL: define i32 @test_intrinsic_very_unprofitable
; CHECK-SAME: (i32 [[N:%.*]], i1 [[COND_1:%.*]], i1 [[COND_2:%.*]]) {
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[COND_2_GW_FR:%.*]] = freeze i1 [[COND_2]]
; CHECK-NEXT:    [[WIDE_CHK:%.*]] = and i1 [[COND_1]], [[COND_2_GW_FR]]
; CHECK-NEXT:    [[WIDENABLE_COND:%.*]] = call i1 @llvm.experimental.widenable.condition()
; CHECK-NEXT:    [[EXIPLICIT_GUARD_COND:%.*]] = and i1 [[WIDE_CHK]], [[WIDENABLE_COND]]
; CHECK-NEXT:    br i1 [[EXIPLICIT_GUARD_COND]], label [[GUARDED:%.*]], label [[DEOPT:%.*]], !prof [[PROF0]]
; CHECK:       deopt:
; CHECK-NEXT:    [[DEOPTCALL:%.*]] = call i32 (...) @llvm.experimental.deoptimize.i32() [ "deopt"() ]
; CHECK-NEXT:    ret i32 [[DEOPTCALL]]
; CHECK:       guarded:
; CHECK-NEXT:    [[LOOP_PRECONDITION:%.*]] = icmp uge i32 [[N]], 100
; CHECK-NEXT:    br i1 [[LOOP_PRECONDITION]], label [[LOOP:%.*]], label [[FAILED:%.*]], !prof [[PROF4:![0-9]+]]
; CHECK:       loop:
; CHECK-NEXT:    [[IV:%.*]] = phi i32 [ 0, [[GUARDED]] ], [ [[IV_NEXT:%.*]], [[GUARDED1:%.*]] ]
; CHECK-NEXT:    [[WIDENABLE_COND4:%.*]] = call i1 @llvm.experimental.widenable.condition()
; CHECK-NEXT:    [[EXIPLICIT_GUARD_COND5:%.*]] = and i1 [[COND_2_GW_FR]], [[WIDENABLE_COND4]]
; CHECK-NEXT:    br i1 true, label [[GUARDED1]], label [[DEOPT2:%.*]], !prof [[PROF0]]
; CHECK:       deopt2:
; CHECK-NEXT:    [[DEOPTCALL3:%.*]] = call i32 (...) @llvm.experimental.deoptimize.i32() [ "deopt"() ]
; CHECK-NEXT:    ret i32 [[DEOPTCALL3]]
; CHECK:       guarded1:
; CHECK-NEXT:    [[IV_NEXT]] = add nuw nsw i32 [[IV]], 1
; CHECK-NEXT:    [[LOOP_COND:%.*]] = icmp ult i32 [[IV_NEXT]], 100
; CHECK-NEXT:    br i1 [[LOOP_COND]], label [[LOOP]], label [[EXIT:%.*]], !prof [[PROF1]]
; CHECK:       exit:
; CHECK-NEXT:    ret i32 0
; CHECK:       failed:
; CHECK-NEXT:    ret i32 -1
;
entry:
  %widenable_cond = call i1 @llvm.experimental.widenable.condition()
  %exiplicit_guard_cond = and i1 %cond.1, %widenable_cond
  br i1 %exiplicit_guard_cond, label %guarded, label %deopt, !prof !0

deopt:                                            ; preds = %entry
  %deoptcall = call i32 (...) @llvm.experimental.deoptimize.i32() [ "deopt"() ]
  ret i32 %deoptcall

guarded:                                          ; preds = %entry
  %loop.precondition = icmp uge i32 %n, 100
  br i1 %loop.precondition, label %loop, label %failed, !prof !4

loop:                                             ; preds = %guarded1, %guarded
  %iv = phi i32 [ 0, %guarded ], [ %iv.next, %guarded1 ]
  %widenable_cond4 = call i1 @llvm.experimental.widenable.condition()
  %exiplicit_guard_cond5 = and i1 %cond.2, %widenable_cond4
  br i1 %exiplicit_guard_cond5, label %guarded1, label %deopt2, !prof !0

deopt2:                                           ; preds = %loop
  %deoptcall3 = call i32 (...) @llvm.experimental.deoptimize.i32() [ "deopt"() ]
  ret i32 %deoptcall3

guarded1:                                         ; preds = %loop
  %iv.next = add nuw nsw i32 %iv, 1
  %loop.cond = icmp ult i32 %iv.next, 100
  br i1 %loop.cond, label %loop, label %exit, !prof !1

exit:                                             ; preds = %guarded1
  ret i32 0

failed:                                           ; preds = %guarded
  ret i32 -1
}

; FIXME: This loop is so rarely entered, that we don't want to widen here.
define i32 @test_intrinsic_unprofitable(i32 %n, i1 %cond.1, i1 %cond.2) {
; CHECK-LABEL: define i32 @test_intrinsic_unprofitable
; CHECK-SAME: (i32 [[N:%.*]], i1 [[COND_1:%.*]], i1 [[COND_2:%.*]]) {
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[COND_2_GW_FR:%.*]] = freeze i1 [[COND_2]]
; CHECK-NEXT:    [[WIDE_CHK:%.*]] = and i1 [[COND_1]], [[COND_2_GW_FR]]
; CHECK-NEXT:    [[WIDENABLE_COND:%.*]] = call i1 @llvm.experimental.widenable.condition()
; CHECK-NEXT:    [[EXIPLICIT_GUARD_COND:%.*]] = and i1 [[WIDE_CHK]], [[WIDENABLE_COND]]
; CHECK-NEXT:    br i1 [[EXIPLICIT_GUARD_COND]], label [[GUARDED:%.*]], label [[DEOPT:%.*]], !prof [[PROF0]]
; CHECK:       deopt:
; CHECK-NEXT:    [[DEOPTCALL:%.*]] = call i32 (...) @llvm.experimental.deoptimize.i32() [ "deopt"() ]
; CHECK-NEXT:    ret i32 [[DEOPTCALL]]
; CHECK:       guarded:
; CHECK-NEXT:    [[LOOP_PRECONDITION:%.*]] = icmp uge i32 [[N]], 100
; CHECK-NEXT:    br i1 [[LOOP_PRECONDITION]], label [[LOOP:%.*]], label [[FAILED:%.*]], !prof [[PROF5:![0-9]+]]
; CHECK:       loop:
; CHECK-NEXT:    [[IV:%.*]] = phi i32 [ 0, [[GUARDED]] ], [ [[IV_NEXT:%.*]], [[GUARDED1:%.*]] ]
; CHECK-NEXT:    [[WIDENABLE_COND4:%.*]] = call i1 @llvm.experimental.widenable.condition()
; CHECK-NEXT:    [[EXIPLICIT_GUARD_COND5:%.*]] = and i1 [[COND_2_GW_FR]], [[WIDENABLE_COND4]]
; CHECK-NEXT:    br i1 true, label [[GUARDED1]], label [[DEOPT2:%.*]], !prof [[PROF0]]
; CHECK:       deopt2:
; CHECK-NEXT:    [[DEOPTCALL3:%.*]] = call i32 (...) @llvm.experimental.deoptimize.i32() [ "deopt"() ]
; CHECK-NEXT:    ret i32 [[DEOPTCALL3]]
; CHECK:       guarded1:
; CHECK-NEXT:    [[IV_NEXT]] = add nuw nsw i32 [[IV]], 1
; CHECK-NEXT:    [[LOOP_COND:%.*]] = icmp ult i32 [[IV_NEXT]], 100
; CHECK-NEXT:    br i1 [[LOOP_COND]], label [[LOOP]], label [[EXIT:%.*]], !prof [[PROF1]]
; CHECK:       exit:
; CHECK-NEXT:    ret i32 0
; CHECK:       failed:
; CHECK-NEXT:    ret i32 -1
;
entry:
  %widenable_cond = call i1 @llvm.experimental.widenable.condition()
  %exiplicit_guard_cond = and i1 %cond.1, %widenable_cond
  br i1 %exiplicit_guard_cond, label %guarded, label %deopt, !prof !0

deopt:                                            ; preds = %entry
  %deoptcall = call i32 (...) @llvm.experimental.deoptimize.i32() [ "deopt"() ]
  ret i32 %deoptcall

guarded:                                          ; preds = %entry
  %loop.precondition = icmp uge i32 %n, 100
  br i1 %loop.precondition, label %loop, label %failed, !prof !5

loop:                                             ; preds = %guarded1, %guarded
  %iv = phi i32 [ 0, %guarded ], [ %iv.next, %guarded1 ]
  %widenable_cond4 = call i1 @llvm.experimental.widenable.condition()
  %exiplicit_guard_cond5 = and i1 %cond.2, %widenable_cond4
  br i1 %exiplicit_guard_cond5, label %guarded1, label %deopt2, !prof !0

deopt2:                                           ; preds = %loop
  %deoptcall3 = call i32 (...) @llvm.experimental.deoptimize.i32() [ "deopt"() ]
  ret i32 %deoptcall3

guarded1:                                         ; preds = %loop
  %iv.next = add nuw nsw i32 %iv, 1
  %loop.cond = icmp ult i32 %iv.next, 100
  br i1 %loop.cond, label %loop, label %exit, !prof !1

exit:                                             ; preds = %guarded1
  ret i32 0

failed:                                           ; preds = %guarded
  ret i32 -1
}

declare i32 @llvm.experimental.deoptimize.i32(...)

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(inaccessiblemem: readwrite)
declare noundef i1 @llvm.experimental.widenable.condition() #1

attributes #0 = { nocallback nofree nosync willreturn }
attributes #1 = { nocallback nofree nosync nounwind speculatable willreturn memory(inaccessiblemem: readwrite) }

!0 = !{!"branch_weights", i32 1048576, i32 1}
!1 = !{!"branch_weights", i32 99, i32 1}
!2 = !{!"branch_weights", i32 1, i32 10}
!3 = !{!"branch_weights", i32 1, i32 99}
!4 = !{!"branch_weights", i32 1, i32 1048576}
!5 = !{!"branch_weights", i32 1, i32 1000}