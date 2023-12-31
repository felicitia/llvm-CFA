; Verify that incompatible declarations of known library functions are
; not annotated with argument attributes.  This negative test complements
; annotate.ll.
;
; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt < %s -passes=inferattrs -S | FileCheck %s --match-full-lines


; Exercise <math.h> function declarations.

; Expect double fabs(double).
declare float @fabs(float)
; CHECK: declare float @fabs(float)


; Exercise <stdio.h> function declarations.

; Expect int fgetc(FILE*).
declare i32 @fgetc(ptr, i32)
; CHECK: declare i32 @fgetc(ptr, i32)

; Expect char* fgets(char*, int, FILE*).
declare i32 @fgets(ptr, i32, ptr)
; CHECK: declare i32 @fgets(ptr, i32, ptr)

; Expect int sprintf(char*, const char*, ...).
declare i32 @sprintf(ptr, i64, ptr, ...)
; CHECK: declare i32 @sprintf(ptr, i64, ptr, ...)

; Expect int snprintf(char*, size_t, const char*, ...).
declare i32 @snprintf(ptr, i64, ptr)
; CHECK: declare i32 @snprintf(ptr, i64, ptr)

; Expect int sscanf(const char*, const char*, ...).
declare i32 @sscanf(ptr, ...)
; CHECK: declare i32 @sscanf(ptr, ...)


; Exercise <stdlib.h> function declarations.

; Expect int atoi(const char*).
declare i8 @atoi(ptr)
; CHECK: declare i8 @atoi(ptr)

; Expect long long atoll(const char*).
declare i1 @atoll(ptr)
; CHECK: declare i1 @atoll(ptr)

; Expect double atof(const char*).
declare float @atof(ptr)
; CHECK: declare float @atof(ptr)

; Expect double strtod(const char*, char**).
declare double @strtod(ptr, ptr, i32)
; CHECK: declare double @strtod(ptr, ptr, i32)

; Expect float strtof(const char*, char**).
declare double @strtof(ptr, ptr)
; CHECK: declare double @strtof(ptr, ptr)


; Exercise <string.h> function declarations.

; Expect void* memccpy(void*, const void*, int, size_t).
declare ptr @memccpy(ptr, ptr, i64, i64)
; CHECK: declare ptr @memccpy(ptr, ptr, i64, i64)

; Expect int strcasecmp(const char*, const char*).
declare i1 @strcasecmp(ptr, ptr)
; CHECK: declare i1 @strcasecmp(ptr, ptr)

; Expect int strcoll(const char*, const char*).
declare ptr @strcoll(ptr, ptr)
; CHECK: declare ptr @strcoll(ptr, ptr)

; Expect int strncasecmp(const char*, const char*, size_t).
declare i32 @strncasecmp(ptr, ptr, i64, i64)
; CHECK: declare i32 @strncasecmp(ptr, ptr, i64, i64)

; Expect int strxfrm(const char*, const char*).
declare i16 @strxfrm(ptr, ptr)
; CHECK: declare i16 @strxfrm(ptr, ptr)

; Expect char* strtok(const char*, const char*).
declare ptr @strtok(ptr, i8)
; CHECK: declare ptr @strtok(ptr, i8)

; Expect char* strtok_r(const char*, const char*, char**).
declare ptr @strtok_r(ptr, ptr, i64)
; CHECK: declare ptr @strtok_r(ptr, ptr, i64)

; Expect char* strdup(const char*).
declare ptr @strdup(ptr, i64)
; CHECK: declare ptr @strdup(ptr, i64)

; Expect char* strndup(const char*, size_t).
declare ptr @strndup(ptr, i64, i64)
; CHECK: declare ptr @strndup(ptr, i64, i64)


; Exercise <sys/stat.h> and <sys/statvfs.h> function declarations.

; Expect int stat(const char*, struct stat*).
declare i32 @stat(ptr, ptr, i64)
; CHECK: declare i32 @stat(ptr, ptr, i64)

; Expect int statvfs(const char*, struct statvfs*).
declare i32 @statvfs(ptr, ptr, i64)
; CHECK: declare i32 @statvfs(ptr, ptr, i64)
