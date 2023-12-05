; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt -aa-pipeline=basic-aa -passes="gvn" -S %s | FileCheck --check-prefixes=CHECK,LIMIT %s
; RUN: opt -aa-pipeline=basic-aa -passes="gvn" -S -capture-tracking-max-uses-to-explore=20 %s | FileCheck --check-prefixes=CHECK,LIMIT-TOO-SMALL %s
; RUN: opt -aa-pipeline=basic-aa -passes="gvn" -S -capture-tracking-max-uses-to-explore=21 %s | FileCheck --check-prefixes=CHECK,LIMIT %s

define i32 @test1(ptr %p, i1 %C) {
; CHECK-LABEL: @test1(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[A:%.*]] = alloca i32, align 4
; CHECK-NEXT:    call void @dont_capture(ptr [[A]])
; CHECK-NEXT:    call void @dont_capture(ptr [[A]])
; CHECK-NEXT:    call void @dont_capture(ptr [[A]])
; CHECK-NEXT:    call void @dont_capture(ptr [[A]])
; CHECK-NEXT:    call void @dont_capture(ptr [[A]])
; CHECK-NEXT:    call void @dont_capture(ptr [[A]])
; CHECK-NEXT:    call void @dont_capture(ptr [[A]])
; CHECK-NEXT:    call void @dont_capture(ptr [[A]])
; CHECK-NEXT:    call void @dont_capture(ptr [[A]])
; CHECK-NEXT:    call void @dont_capture(ptr [[A]])
; CHECK-NEXT:    call void @dont_capture(ptr [[A]])
; CHECK-NEXT:    call void @dont_capture(ptr [[A]])
; CHECK-NEXT:    call void @dont_capture(ptr [[A]])
; CHECK-NEXT:    call void @dont_capture(ptr [[A]])
; CHECK-NEXT:    call void @dont_capture(ptr [[A]])
; CHECK-NEXT:    call void @dont_capture(ptr [[A]])
; CHECK-NEXT:    call void @dont_capture(ptr [[A]])
; CHECK-NEXT:    call void @dont_capture(ptr [[A]])
; CHECK-NEXT:    call void @dont_capture(ptr [[A]])
; CHECK-NEXT:    store i32 1, ptr [[A]], align 4
; CHECK-NEXT:    call void @may_write()
; LIMIT-TOO-SMALL-NEXT:    [[L:%.*]] = load i32, ptr [[A]], align 4
; LIMIT-TOO-SMALL-NEXT:    ret i32 [[L]]
; LIMIT-NEXT:    ret i32 1
;
entry:
  %a = alloca i32
  call void @dont_capture(ptr %a)
  call void @dont_capture(ptr %a)
  call void @dont_capture(ptr %a)
  call void @dont_capture(ptr %a)
  call void @dont_capture(ptr %a)
  call void @dont_capture(ptr %a)
  call void @dont_capture(ptr %a)
  call void @dont_capture(ptr %a)
  call void @dont_capture(ptr %a)
  call void @dont_capture(ptr %a)
  call void @dont_capture(ptr %a)
  call void @dont_capture(ptr %a)
  call void @dont_capture(ptr %a)
  call void @dont_capture(ptr %a)
  call void @dont_capture(ptr %a)
  call void @dont_capture(ptr %a)
  call void @dont_capture(ptr %a)
  call void @dont_capture(ptr %a)
  call void @dont_capture(ptr %a)
  store i32 1, ptr %a
  call void @may_write()
  %l = load i32, ptr %a
  ret i32 %l
}

declare void @dont_capture(ptr nocapture)

declare void @may_write()