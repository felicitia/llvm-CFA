// RUN: %clang_cc1 -triple x86_64-linux-gnu -std=c++2a %s -emit-llvm -o - | FileCheck --check-prefix=CHECK --check-prefix=LINUX %s
// RUN: %clang_cc1 -triple x86_64-apple-darwin12  -std=c++2a %s -emit-llvm -o - | FileCheck --check-prefix=CHECK --check-prefix=DARWIN %s

// Check variable definitions/declarations. Note that on Darwin, typically the
// variable's symbol is marked internal, and only the _ZTW function is
// exported. Except: constinit variables do get exported, even on darwin.

// CHECK-DAG:  @a = external thread_local global i32
// CHECK-DAG:  @b = external thread_local global i32
// LINUX-DAG:  @c ={{.*}} thread_local global i32 0, align 4
// DARWIN-DAG: @c = internal thread_local global i32 0, align 4
// LINUX-DAG:  @d ={{.*}} thread_local global i32 0, align 4
// DARWIN-DAG: @d = internal thread_local global i32 0, align 4
// CHECK-DAG:  @e = external thread_local global %struct.Destructed, align 4
// CHECK-DAG:  @e2 ={{.*}} thread_local global %struct.Destructed zeroinitializer, align 4
// CHECK-DAG:  @f ={{.*}} thread_local global i32 4, align 4

extern thread_local int a;
extern thread_local constinit int b;

// CHECK-LABEL: define{{.*}} i32 @_Z5get_av()
// CHECK: call {{(cxx_fast_tlscc )?}}ptr @_ZTW1a()
// CHECK: }
int get_a() { return a; }

// LINUX-LABEL: define linkonce_odr {{.*}} @_ZTW1a()
// LINUX: br i1
// LINUX: call void @_ZTH1a()
// LINUX: }
// DARWIN-NOT: define {{.*}}@_ZTW1a()

// CHECK-LABEL: define{{.*}} i32 @_Z5get_bv()
// CHECK-NOT: call
// CHECK: [[B_ADDR:%.+]] = call align 4 ptr @llvm.threadlocal.address.p0(ptr align 4 @b)
// CHECK: load i32, ptr [[B_ADDR]]
// CHECK-NOT: call
// CHECK: }
int get_b() { return b; }

// CHECK-NOT: define {{.*}} @_ZTW1b()

extern thread_local int c;

// CHECK-LABEL: define{{.*}} i32 @_Z5get_cv()
// LINUX: call {{(cxx_fast_tlscc )?}}ptr @_ZTW1c()
// CHECK: load i32, ptr %
// CHECK: }
int get_c() { return c; }

// Note: use of 'c' does not trigger initialization of 'd', because 'c' has a
// constant initializer.
// DARWIN-LABEL: define cxx_fast_tlscc {{.*}} @_ZTW1c()
// LINUX-LABEL: define weak_odr {{.*}} @_ZTW1c()
// CHECK-NOT: br i1
// CHECK-NOT: call
// CHECK: [[C_ADDR:%.+]] = call align 4 ptr @llvm.threadlocal.address.p0(ptr align 4 @c)
// CHECK: ret ptr [[C_ADDR]]
// CHECK: }

thread_local int c = 0;

// PR51079: We must assume an incomplete class type might have non-trivial
// destruction, and so speculatively call the thread wrapper.

// CHECK-LABEL: define {{.*}} @_Z6get_e3v(
// CHECK: call {{(cxx_fast_tlscc )?}}ptr @_ZTW2e3()
// CHECK-LABEL: }
extern thread_local constinit struct DestructedFwdDecl e3;
DestructedFwdDecl &get_e3() { return e3; }

int d_init();

// CHECK: define {{.*}}[[D_INIT:@__cxx_global_var_init[^(]*]](
// CHECK: call {{.*}} @_Z6d_initv()
thread_local int d = d_init();

struct Destructed {
  int n = 0;
  ~Destructed();
};

extern thread_local constinit Destructed e;
// CHECK-LABEL: define{{.*}} i32 @_Z5get_ev()
// CHECK: call {{(cxx_fast_tlscc )?}}ptr @_ZTW1e()
// CHECK: }
int get_e() { return e.n; }

// CHECK: define {{.*}}[[E2_INIT:@__cxx_global_var_init[^(]*]](
// LINUX: call {{.*}} @__cxa_thread_atexit({{.*}} @_ZN10DestructedD1Ev, {{.*}} @e2
// DARWIN: call {{.*}} @_tlv_atexit({{.*}} @_ZN10DestructedD1Ev, {{.*}} @e2
thread_local constinit Destructed e2;

thread_local constinit int f = 4;

// CHECK-LABEL: define {{.*}}__tls_init
// CHECK: call {{.*}} [[D_INIT]]
// CHECK: call {{.*}} [[E2_INIT]]

// Because the call wrapper may be called speculatively (and simply because
// it's required by the ABI), it must always be emitted for an external linkage
// variable, even if the variable has constant initialization and constant
// destruction.
struct NotDestructed { int n = 0; };
thread_local constinit NotDestructed nd;
// CHECK-LABEL: define {{.*}} @_ZTW2nd
