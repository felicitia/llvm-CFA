// RUN: %clang_cc1 -fsyntax-only -Wno-unused-value -fno-diagnostics-show-line-numbers %s 2>&1 | FileCheck %s
// REQUIRES: asserts

void foo(void) {

  "��"; // �
// CHECK: {{^  "<A7><C3>"; // <F8>}}
// CHECK: {{^   \^~~~~~~}}

  /* �� */ const char *d = "�";

// CHECK: {{^  /\* <FE><AB> \*/ const char \*d = "<A5>";}}
// CHECK: {{^                                  \^~~~}}

  "xx鿿�d";
// CHECK: {{^  "xx鿿<BF>d";}}
// CHECK: {{^             \^~~~}}

  "xx�bcd";
// CHECK: {{^  "xx<E9><BF>bcd";}}
// CHECK: {{^     \^~~~~~~~}}

  "xx�abcd";
// CHECK: {{^  "xx<E9>abcd";}}
// CHECK: {{^     \^~~~}}

  "xx��d";
// CHECK: {{^  "xx<E9><BF><E9><BF>d";}}
// CHECK: {{^     \^~~~~~~~~~~~~~~}}

  "xx�xxxxxxxxxxxxxxxxxxxxx�xx";
// CHECK: {{^  "xx<E9><BF>xxxxxxxxxxxxxxxxxxxxx<E9><BF>xx";}}
// CHECK: {{^     \^~~~~~~~                     ~~~~~~~~}}

  "�?k��S���g�7�,	2,D�u��*�,p���&��(�K�:�'1��jOŰ<:";

  "x�x�x�x�x�x�x�x�x�x�x�x�x";
}
// CHECK-NOT:Assertion
