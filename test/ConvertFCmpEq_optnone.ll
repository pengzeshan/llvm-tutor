; RUN: opt -load %shlibdir/libFindFCmpEq%shlibext  -load %shlibdir/libConvertFCmpEq%shlibext -convert-fcmp-eq  -S %s \
; RUN:  | FileCheck %s
; RUN: opt -load-pass-plugin=%shlibdir/libFindFCmpEq%shlibext  -load-pass-plugin=%shlibdir/libConvertFCmpEq%shlibext --passes=convert-fcmp-eq  -S %s \
; RUN:  | FileCheck %s

; Verify that `optnone` means that `ConvertFCmpEq` will skip the corresponding function

define i32 @fcmp_oeq(double %a, double %b) optnone noinline {
; CHECK-LABEL: @fcmp_oeq
; CHECK-NEXT: %cmp = fcmp oeq double %a, %b
; CHECK-NEXT: %conv = zext i1 %cmp to i32
; CHECK-NEXT: ret i32 %conv

  ; a == b
  %cmp = fcmp oeq double %a, %b
  %conv = zext i1 %cmp to i32
  ret i32 %conv
}
