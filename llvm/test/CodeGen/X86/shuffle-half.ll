; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py UTC_ARGS: --version 2
; RUN: llc < %s -mtriple=x86_64-linux-gnu -mattr=avx512vl | FileCheck %s

define <32 x half> @dump_vec() {
; CHECK-LABEL: dump_vec:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vpxor %xmm0, %xmm0, %xmm0
; CHECK-NEXT:    xorl %eax, %eax
; CHECK-NEXT:    testb %al, %al
; CHECK-NEXT:    jne .LBB0_2
; CHECK-NEXT:  # %bb.1: # %cond.load
; CHECK-NEXT:    vpinsrw $0, (%rax), %xmm0, %xmm0
; CHECK-NEXT:    vmovdqa {{.*#+}} xmm1 = [65535,0,0,0]
; CHECK-NEXT:    vpand %ymm0, %ymm1, %ymm0
; CHECK-NEXT:    vpxor %xmm1, %xmm1, %xmm1
; CHECK-NEXT:    vinserti64x4 $0, %ymm0, %zmm1, %zmm0
; CHECK-NEXT:  .LBB0_2: # %else
; CHECK-NEXT:    xorl %eax, %eax
; CHECK-NEXT:    testb %al, %al
; CHECK-NEXT:    jne .LBB0_4
; CHECK-NEXT:  # %bb.3: # %cond.load1
; CHECK-NEXT:    vpbroadcastw (%rax), %xmm1
; CHECK-NEXT:    vpblendw {{.*#+}} xmm1 = xmm0[0],xmm1[1],xmm0[2,3,4,5,6,7]
; CHECK-NEXT:    vinserti32x4 $0, %xmm1, %zmm0, %zmm0
; CHECK-NEXT:  .LBB0_4: # %else2
; CHECK-NEXT:    xorl %eax, %eax
; CHECK-NEXT:    testb %al, %al
; CHECK-NEXT:    jne .LBB0_6
; CHECK-NEXT:  # %bb.5: # %cond.load4
; CHECK-NEXT:    vpbroadcastw (%rax), %xmm1
; CHECK-NEXT:    vpblendw {{.*#+}} xmm1 = xmm0[0,1],xmm1[2],xmm0[3,4,5,6,7]
; CHECK-NEXT:    vinserti32x4 $0, %xmm1, %zmm0, %zmm0
; CHECK-NEXT:  .LBB0_6: # %else5
; CHECK-NEXT:    xorl %eax, %eax
; CHECK-NEXT:    testb %al, %al
; CHECK-NEXT:    jne .LBB0_8
; CHECK-NEXT:  # %bb.7: # %cond.load7
; CHECK-NEXT:    vpbroadcastw (%rax), %xmm1
; CHECK-NEXT:    vpblendw {{.*#+}} xmm1 = xmm0[0,1,2],xmm1[3],xmm0[4,5,6,7]
; CHECK-NEXT:    vinserti32x4 $0, %xmm1, %zmm0, %zmm0
; CHECK-NEXT:  .LBB0_8: # %else8
; CHECK-NEXT:    xorl %eax, %eax
; CHECK-NEXT:    testb %al, %al
; CHECK-NEXT:    jne .LBB0_10
; CHECK-NEXT:  # %bb.9: # %cond.load10
; CHECK-NEXT:    vpbroadcastw (%rax), %xmm1
; CHECK-NEXT:    vpblendw {{.*#+}} xmm1 = xmm0[0,1,2,3],xmm1[4],xmm0[5,6,7]
; CHECK-NEXT:    vinserti32x4 $0, %xmm1, %zmm0, %zmm0
; CHECK-NEXT:  .LBB0_10: # %else11
; CHECK-NEXT:    xorl %eax, %eax
; CHECK-NEXT:    testb %al, %al
; CHECK-NEXT:    jne .LBB0_12
; CHECK-NEXT:  # %bb.11: # %cond.load13
; CHECK-NEXT:    vpbroadcastw (%rax), %xmm1
; CHECK-NEXT:    vpblendw {{.*#+}} xmm1 = xmm0[0,1,2,3,4],xmm1[5],xmm0[6,7]
; CHECK-NEXT:    vinserti32x4 $0, %xmm1, %zmm0, %zmm0
; CHECK-NEXT:  .LBB0_12: # %else14
; CHECK-NEXT:    xorl %eax, %eax
; CHECK-NEXT:    testb %al, %al
; CHECK-NEXT:    jne .LBB0_14
; CHECK-NEXT:  # %bb.13: # %cond.load16
; CHECK-NEXT:    vpbroadcastw (%rax), %xmm1
; CHECK-NEXT:    vpblendw {{.*#+}} xmm1 = xmm0[0,1,2,3,4,5],xmm1[6],xmm0[7]
; CHECK-NEXT:    vinserti32x4 $0, %xmm1, %zmm0, %zmm0
; CHECK-NEXT:  .LBB0_14: # %else17
; CHECK-NEXT:    xorl %eax, %eax
; CHECK-NEXT:    testb %al, %al
; CHECK-NEXT:    jne .LBB0_16
; CHECK-NEXT:  # %bb.15: # %cond.load19
; CHECK-NEXT:    vpbroadcastw (%rax), %xmm1
; CHECK-NEXT:    vpblendw {{.*#+}} xmm1 = xmm0[0,1,2,3,4,5,6],xmm1[7]
; CHECK-NEXT:    vinserti32x4 $0, %xmm1, %zmm0, %zmm0
; CHECK-NEXT:  .LBB0_16: # %else20
; CHECK-NEXT:    xorl %eax, %eax
; CHECK-NEXT:    testb %al, %al
; CHECK-NEXT:    jne .LBB0_18
; CHECK-NEXT:  # %bb.17: # %cond.load22
; CHECK-NEXT:    vpbroadcastw (%rax), %ymm1
; CHECK-NEXT:    vpblendw {{.*#+}} ymm1 = ymm1[0],ymm0[1,2,3,4,5,6,7],ymm1[8],ymm0[9,10,11,12,13,14,15]
; CHECK-NEXT:    vpblendd {{.*#+}} ymm1 = ymm0[0,1,2,3],ymm1[4,5,6,7]
; CHECK-NEXT:    vshuff64x2 {{.*#+}} zmm0 = zmm1[0,1,2,3],zmm0[4,5,6,7]
; CHECK-NEXT:  .LBB0_18: # %else23
; CHECK-NEXT:    xorl %eax, %eax
; CHECK-NEXT:    testb %al, %al
; CHECK-NEXT:    jne .LBB0_20
; CHECK-NEXT:  # %bb.19: # %cond.load25
; CHECK-NEXT:    vpbroadcastw (%rax), %ymm1
; CHECK-NEXT:    vpblendw {{.*#+}} ymm1 = ymm0[0],ymm1[1],ymm0[2,3,4,5,6,7,8],ymm1[9],ymm0[10,11,12,13,14,15]
; CHECK-NEXT:    vpblendd {{.*#+}} ymm1 = ymm0[0,1,2,3],ymm1[4,5,6,7]
; CHECK-NEXT:    vshuff64x2 {{.*#+}} zmm0 = zmm1[0,1,2,3],zmm0[4,5,6,7]
; CHECK-NEXT:  .LBB0_20: # %else26
; CHECK-NEXT:    xorl %eax, %eax
; CHECK-NEXT:    testb %al, %al
; CHECK-NEXT:    jne .LBB0_22
; CHECK-NEXT:  # %bb.21: # %cond.load28
; CHECK-NEXT:    vpbroadcastw (%rax), %ymm1
; CHECK-NEXT:    vpblendw {{.*#+}} ymm1 = ymm0[0,1],ymm1[2],ymm0[3,4,5,6,7,8,9],ymm1[10],ymm0[11,12,13,14,15]
; CHECK-NEXT:    vpblendd {{.*#+}} ymm1 = ymm0[0,1,2,3],ymm1[4,5,6,7]
; CHECK-NEXT:    vshuff64x2 {{.*#+}} zmm0 = zmm1[0,1,2,3],zmm0[4,5,6,7]
; CHECK-NEXT:  .LBB0_22: # %else29
; CHECK-NEXT:    xorl %eax, %eax
; CHECK-NEXT:    testb %al, %al
; CHECK-NEXT:    jne .LBB0_24
; CHECK-NEXT:  # %bb.23: # %cond.load31
; CHECK-NEXT:    vpbroadcastw (%rax), %ymm1
; CHECK-NEXT:    vpblendw {{.*#+}} ymm1 = ymm0[0,1,2],ymm1[3],ymm0[4,5,6,7,8,9,10],ymm1[11],ymm0[12,13,14,15]
; CHECK-NEXT:    vpblendd {{.*#+}} ymm1 = ymm0[0,1,2,3],ymm1[4,5,6,7]
; CHECK-NEXT:    vshuff64x2 {{.*#+}} zmm0 = zmm1[0,1,2,3],zmm0[4,5,6,7]
; CHECK-NEXT:  .LBB0_24: # %else32
; CHECK-NEXT:    xorl %eax, %eax
; CHECK-NEXT:    testb %al, %al
; CHECK-NEXT:    jne .LBB0_26
; CHECK-NEXT:  # %bb.25: # %cond.load34
; CHECK-NEXT:    vpbroadcastw (%rax), %ymm1
; CHECK-NEXT:    vpblendw {{.*#+}} ymm1 = ymm0[0,1,2,3],ymm1[4],ymm0[5,6,7,8,9,10,11],ymm1[12],ymm0[13,14,15]
; CHECK-NEXT:    vpblendd {{.*#+}} ymm1 = ymm0[0,1,2,3],ymm1[4,5,6,7]
; CHECK-NEXT:    vshuff64x2 {{.*#+}} zmm0 = zmm1[0,1,2,3],zmm0[4,5,6,7]
; CHECK-NEXT:  .LBB0_26: # %else35
; CHECK-NEXT:    xorl %eax, %eax
; CHECK-NEXT:    testb %al, %al
; CHECK-NEXT:    jne .LBB0_28
; CHECK-NEXT:  # %bb.27: # %cond.load37
; CHECK-NEXT:    vpbroadcastw (%rax), %ymm1
; CHECK-NEXT:    vpblendw {{.*#+}} ymm1 = ymm0[0,1,2,3,4],ymm1[5],ymm0[6,7,8,9,10,11,12],ymm1[13],ymm0[14,15]
; CHECK-NEXT:    vpblendd {{.*#+}} ymm1 = ymm0[0,1,2,3],ymm1[4,5,6,7]
; CHECK-NEXT:    vshuff64x2 {{.*#+}} zmm0 = zmm1[0,1,2,3],zmm0[4,5,6,7]
; CHECK-NEXT:  .LBB0_28: # %else38
; CHECK-NEXT:    xorl %eax, %eax
; CHECK-NEXT:    testb %al, %al
; CHECK-NEXT:    jne .LBB0_30
; CHECK-NEXT:  # %bb.29: # %cond.load40
; CHECK-NEXT:    vpbroadcastw (%rax), %ymm1
; CHECK-NEXT:    vpblendw {{.*#+}} ymm1 = ymm0[0,1,2,3,4,5],ymm1[6],ymm0[7,8,9,10,11,12,13],ymm1[14],ymm0[15]
; CHECK-NEXT:    vpblendd {{.*#+}} ymm1 = ymm0[0,1,2,3],ymm1[4,5,6,7]
; CHECK-NEXT:    vshuff64x2 {{.*#+}} zmm0 = zmm1[0,1,2,3],zmm0[4,5,6,7]
; CHECK-NEXT:  .LBB0_30: # %else41
; CHECK-NEXT:    xorl %eax, %eax
; CHECK-NEXT:    testb %al, %al
; CHECK-NEXT:    jne .LBB0_32
; CHECK-NEXT:  # %bb.31: # %cond.load43
; CHECK-NEXT:    vpbroadcastw (%rax), %ymm1
; CHECK-NEXT:    vpblendw {{.*#+}} ymm1 = ymm0[0,1,2,3,4,5,6],ymm1[7],ymm0[8,9,10,11,12,13,14],ymm1[15]
; CHECK-NEXT:    vpblendd {{.*#+}} ymm1 = ymm0[0,1,2,3],ymm1[4,5,6,7]
; CHECK-NEXT:    vshuff64x2 {{.*#+}} zmm0 = zmm1[0,1,2,3],zmm0[4,5,6,7]
; CHECK-NEXT:  .LBB0_32: # %else44
; CHECK-NEXT:    xorl %eax, %eax
; CHECK-NEXT:    testb %al, %al
; CHECK-NEXT:    jne .LBB0_34
; CHECK-NEXT:  # %bb.33: # %cond.load46
; CHECK-NEXT:    vpbroadcastw (%rax), %xmm1
; CHECK-NEXT:    vextractf64x4 $1, %zmm0, %ymm2
; CHECK-NEXT:    vpblendw {{.*#+}} xmm1 = xmm1[0],xmm2[1,2,3,4,5,6,7]
; CHECK-NEXT:    vpblendd {{.*#+}} ymm1 = ymm1[0,1,2,3],ymm2[4,5,6,7]
; CHECK-NEXT:    vinsertf64x4 $1, %ymm1, %zmm0, %zmm0
; CHECK-NEXT:  .LBB0_34: # %else47
; CHECK-NEXT:    xorl %eax, %eax
; CHECK-NEXT:    testb %al, %al
; CHECK-NEXT:    jne .LBB0_36
; CHECK-NEXT:  # %bb.35: # %cond.load49
; CHECK-NEXT:    vpbroadcastw (%rax), %xmm1
; CHECK-NEXT:    vextractf64x4 $1, %zmm0, %ymm2
; CHECK-NEXT:    vpblendw {{.*#+}} xmm1 = xmm2[0],xmm1[1],xmm2[2,3,4,5,6,7]
; CHECK-NEXT:    vpblendd {{.*#+}} ymm1 = ymm1[0,1,2,3],ymm2[4,5,6,7]
; CHECK-NEXT:    vinsertf64x4 $1, %ymm1, %zmm0, %zmm0
; CHECK-NEXT:  .LBB0_36: # %else50
; CHECK-NEXT:    xorl %eax, %eax
; CHECK-NEXT:    testb %al, %al
; CHECK-NEXT:    jne .LBB0_38
; CHECK-NEXT:  # %bb.37: # %cond.load52
; CHECK-NEXT:    vpbroadcastw (%rax), %xmm1
; CHECK-NEXT:    vextractf64x4 $1, %zmm0, %ymm2
; CHECK-NEXT:    vpblendw {{.*#+}} xmm1 = xmm2[0,1],xmm1[2],xmm2[3,4,5,6,7]
; CHECK-NEXT:    vpblendd {{.*#+}} ymm1 = ymm1[0,1,2,3],ymm2[4,5,6,7]
; CHECK-NEXT:    vinsertf64x4 $1, %ymm1, %zmm0, %zmm0
; CHECK-NEXT:  .LBB0_38: # %else53
; CHECK-NEXT:    xorl %eax, %eax
; CHECK-NEXT:    testb %al, %al
; CHECK-NEXT:    jne .LBB0_40
; CHECK-NEXT:  # %bb.39: # %cond.load55
; CHECK-NEXT:    vpbroadcastw (%rax), %xmm1
; CHECK-NEXT:    vextractf64x4 $1, %zmm0, %ymm2
; CHECK-NEXT:    vpblendw {{.*#+}} xmm1 = xmm2[0,1,2],xmm1[3],xmm2[4,5,6,7]
; CHECK-NEXT:    vpblendd {{.*#+}} ymm1 = ymm1[0,1,2,3],ymm2[4,5,6,7]
; CHECK-NEXT:    vinsertf64x4 $1, %ymm1, %zmm0, %zmm0
; CHECK-NEXT:  .LBB0_40: # %else56
; CHECK-NEXT:    xorl %eax, %eax
; CHECK-NEXT:    testb %al, %al
; CHECK-NEXT:    jne .LBB0_42
; CHECK-NEXT:  # %bb.41: # %cond.load58
; CHECK-NEXT:    vpbroadcastw (%rax), %xmm1
; CHECK-NEXT:    vextractf64x4 $1, %zmm0, %ymm2
; CHECK-NEXT:    vpblendw {{.*#+}} xmm1 = xmm2[0,1,2,3],xmm1[4],xmm2[5,6,7]
; CHECK-NEXT:    vpblendd {{.*#+}} ymm1 = ymm1[0,1,2,3],ymm2[4,5,6,7]
; CHECK-NEXT:    vinsertf64x4 $1, %ymm1, %zmm0, %zmm0
; CHECK-NEXT:  .LBB0_42: # %else59
; CHECK-NEXT:    xorl %eax, %eax
; CHECK-NEXT:    testb %al, %al
; CHECK-NEXT:    jne .LBB0_44
; CHECK-NEXT:  # %bb.43: # %cond.load61
; CHECK-NEXT:    vpbroadcastw (%rax), %xmm1
; CHECK-NEXT:    vextractf64x4 $1, %zmm0, %ymm2
; CHECK-NEXT:    vpblendw {{.*#+}} xmm1 = xmm2[0,1,2,3,4],xmm1[5],xmm2[6,7]
; CHECK-NEXT:    vpblendd {{.*#+}} ymm1 = ymm1[0,1,2,3],ymm2[4,5,6,7]
; CHECK-NEXT:    vinsertf64x4 $1, %ymm1, %zmm0, %zmm0
; CHECK-NEXT:  .LBB0_44: # %else62
; CHECK-NEXT:    xorl %eax, %eax
; CHECK-NEXT:    testb %al, %al
; CHECK-NEXT:    jne .LBB0_46
; CHECK-NEXT:  # %bb.45: # %cond.load64
; CHECK-NEXT:    vpbroadcastw (%rax), %xmm1
; CHECK-NEXT:    vextractf64x4 $1, %zmm0, %ymm2
; CHECK-NEXT:    vpblendw {{.*#+}} xmm1 = xmm2[0,1,2,3,4,5],xmm1[6],xmm2[7]
; CHECK-NEXT:    vpblendd {{.*#+}} ymm1 = ymm1[0,1,2,3],ymm2[4,5,6,7]
; CHECK-NEXT:    vinsertf64x4 $1, %ymm1, %zmm0, %zmm0
; CHECK-NEXT:  .LBB0_46: # %else65
; CHECK-NEXT:    xorl %eax, %eax
; CHECK-NEXT:    testb %al, %al
; CHECK-NEXT:    jne .LBB0_48
; CHECK-NEXT:  # %bb.47: # %cond.load67
; CHECK-NEXT:    vpbroadcastw (%rax), %xmm1
; CHECK-NEXT:    vextractf64x4 $1, %zmm0, %ymm2
; CHECK-NEXT:    vpblendw {{.*#+}} xmm1 = xmm2[0,1,2,3,4,5,6],xmm1[7]
; CHECK-NEXT:    vpblendd {{.*#+}} ymm1 = ymm1[0,1,2,3],ymm2[4,5,6,7]
; CHECK-NEXT:    vinsertf64x4 $1, %ymm1, %zmm0, %zmm0
; CHECK-NEXT:  .LBB0_48: # %else68
; CHECK-NEXT:    xorl %eax, %eax
; CHECK-NEXT:    testb %al, %al
; CHECK-NEXT:    jne .LBB0_50
; CHECK-NEXT:  # %bb.49: # %cond.load70
; CHECK-NEXT:    vpbroadcastw (%rax), %ymm1
; CHECK-NEXT:    vextractf64x4 $1, %zmm0, %ymm2
; CHECK-NEXT:    vpblendw {{.*#+}} ymm1 = ymm1[0],ymm2[1,2,3,4,5,6,7],ymm1[8],ymm2[9,10,11,12,13,14,15]
; CHECK-NEXT:    vpblendd {{.*#+}} ymm1 = ymm2[0,1,2,3],ymm1[4,5,6,7]
; CHECK-NEXT:    vinsertf64x4 $1, %ymm1, %zmm0, %zmm0
; CHECK-NEXT:  .LBB0_50: # %else71
; CHECK-NEXT:    xorl %eax, %eax
; CHECK-NEXT:    testb %al, %al
; CHECK-NEXT:    jne .LBB0_52
; CHECK-NEXT:  # %bb.51: # %cond.load73
; CHECK-NEXT:    vpbroadcastw (%rax), %ymm1
; CHECK-NEXT:    vextractf64x4 $1, %zmm0, %ymm2
; CHECK-NEXT:    vpblendw {{.*#+}} ymm1 = ymm2[0],ymm1[1],ymm2[2,3,4,5,6,7,8],ymm1[9],ymm2[10,11,12,13,14,15]
; CHECK-NEXT:    vpblendd {{.*#+}} ymm1 = ymm2[0,1,2,3],ymm1[4,5,6,7]
; CHECK-NEXT:    vinsertf64x4 $1, %ymm1, %zmm0, %zmm0
; CHECK-NEXT:  .LBB0_52: # %else74
; CHECK-NEXT:    xorl %eax, %eax
; CHECK-NEXT:    testb %al, %al
; CHECK-NEXT:    jne .LBB0_54
; CHECK-NEXT:  # %bb.53: # %cond.load76
; CHECK-NEXT:    vpbroadcastw (%rax), %ymm1
; CHECK-NEXT:    vextractf64x4 $1, %zmm0, %ymm2
; CHECK-NEXT:    vpblendw {{.*#+}} ymm1 = ymm2[0,1],ymm1[2],ymm2[3,4,5,6,7,8,9],ymm1[10],ymm2[11,12,13,14,15]
; CHECK-NEXT:    vpblendd {{.*#+}} ymm1 = ymm2[0,1,2,3],ymm1[4,5,6,7]
; CHECK-NEXT:    vinsertf64x4 $1, %ymm1, %zmm0, %zmm0
; CHECK-NEXT:  .LBB0_54: # %else77
; CHECK-NEXT:    xorl %eax, %eax
; CHECK-NEXT:    testb %al, %al
; CHECK-NEXT:    jne .LBB0_56
; CHECK-NEXT:  # %bb.55: # %cond.load79
; CHECK-NEXT:    vpbroadcastw (%rax), %ymm1
; CHECK-NEXT:    vextractf64x4 $1, %zmm0, %ymm2
; CHECK-NEXT:    vpblendw {{.*#+}} ymm1 = ymm2[0,1,2],ymm1[3],ymm2[4,5,6,7,8,9,10],ymm1[11],ymm2[12,13,14,15]
; CHECK-NEXT:    vpblendd {{.*#+}} ymm1 = ymm2[0,1,2,3],ymm1[4,5,6,7]
; CHECK-NEXT:    vinsertf64x4 $1, %ymm1, %zmm0, %zmm0
; CHECK-NEXT:  .LBB0_56: # %else80
; CHECK-NEXT:    xorl %eax, %eax
; CHECK-NEXT:    testb %al, %al
; CHECK-NEXT:    jne .LBB0_58
; CHECK-NEXT:  # %bb.57: # %cond.load82
; CHECK-NEXT:    vpbroadcastw (%rax), %ymm1
; CHECK-NEXT:    vextractf64x4 $1, %zmm0, %ymm2
; CHECK-NEXT:    vpblendw {{.*#+}} ymm1 = ymm2[0,1,2,3],ymm1[4],ymm2[5,6,7,8,9,10,11],ymm1[12],ymm2[13,14,15]
; CHECK-NEXT:    vpblendd {{.*#+}} ymm1 = ymm2[0,1,2,3],ymm1[4,5,6,7]
; CHECK-NEXT:    vinsertf64x4 $1, %ymm1, %zmm0, %zmm0
; CHECK-NEXT:  .LBB0_58: # %else83
; CHECK-NEXT:    xorl %eax, %eax
; CHECK-NEXT:    testb %al, %al
; CHECK-NEXT:    jne .LBB0_60
; CHECK-NEXT:  # %bb.59: # %cond.load85
; CHECK-NEXT:    vpbroadcastw (%rax), %ymm1
; CHECK-NEXT:    vextractf64x4 $1, %zmm0, %ymm2
; CHECK-NEXT:    vpblendw {{.*#+}} ymm1 = ymm2[0,1,2,3,4],ymm1[5],ymm2[6,7,8,9,10,11,12],ymm1[13],ymm2[14,15]
; CHECK-NEXT:    vpblendd {{.*#+}} ymm1 = ymm2[0,1,2,3],ymm1[4,5,6,7]
; CHECK-NEXT:    vinsertf64x4 $1, %ymm1, %zmm0, %zmm0
; CHECK-NEXT:  .LBB0_60: # %else86
; CHECK-NEXT:    xorl %eax, %eax
; CHECK-NEXT:    testb %al, %al
; CHECK-NEXT:    jne .LBB0_62
; CHECK-NEXT:  # %bb.61: # %cond.load88
; CHECK-NEXT:    vpbroadcastw (%rax), %ymm1
; CHECK-NEXT:    vextractf64x4 $1, %zmm0, %ymm2
; CHECK-NEXT:    vpblendw {{.*#+}} ymm1 = ymm2[0,1,2,3,4,5],ymm1[6],ymm2[7,8,9,10,11,12,13],ymm1[14],ymm2[15]
; CHECK-NEXT:    vpblendd {{.*#+}} ymm1 = ymm2[0,1,2,3],ymm1[4,5,6,7]
; CHECK-NEXT:    vinsertf64x4 $1, %ymm1, %zmm0, %zmm0
; CHECK-NEXT:  .LBB0_62: # %else89
; CHECK-NEXT:    xorl %eax, %eax
; CHECK-NEXT:    testb %al, %al
; CHECK-NEXT:    jne .LBB0_64
; CHECK-NEXT:  # %bb.63: # %cond.load91
; CHECK-NEXT:    vpbroadcastw (%rax), %ymm1
; CHECK-NEXT:    vextractf64x4 $1, %zmm0, %ymm2
; CHECK-NEXT:    vpblendw {{.*#+}} ymm1 = ymm2[0,1,2,3,4,5,6],ymm1[7],ymm2[8,9,10,11,12,13,14],ymm1[15]
; CHECK-NEXT:    vpblendd {{.*#+}} ymm1 = ymm2[0,1,2,3],ymm1[4,5,6,7]
; CHECK-NEXT:    vinsertf64x4 $1, %ymm1, %zmm0, %zmm0
; CHECK-NEXT:  .LBB0_64: # %else92
; CHECK-NEXT:    retq
  %1 = call <32 x half> @llvm.masked.load.v32f16.p0(ptr poison, i32 2, <32 x i1> poison, <32 x half> <half 0.0, half 0.0, half 0.0, half 0.0, half 0.0, half 0.0, half 0.0, half 0.0, half 0.0, half 0.0, half 0.0, half 0.0, half 0.0, half 0.0, half 0.0, half 0.0, half 0.0, half 0.0, half 0.0, half 0.0, half 0.0, half 0.0, half 0.0, half 0.0, half 0.0, half 0.0, half 0.0, half 0.0, half 0.0, half 0.0, half 0.0, half 0.0>)
  ret <32 x half> %1
}

declare <32 x half> @llvm.masked.load.v32f16.p0(ptr, i32, <32 x i1>, <32 x half>)
