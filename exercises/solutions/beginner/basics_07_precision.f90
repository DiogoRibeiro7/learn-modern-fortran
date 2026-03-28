! Exercise 7 — Precision comparison
! Computes 1/3 in default real and real64 to show the precision difference.
!
! If you write x64 = 1.0 / 3.0 without the _real64 suffix, the division
! happens in 32-bit precision first. The result is then promoted to 64-bit,
! but the lost digits are already gone. You get 0.33333334... instead of
! 0.33333333333333331.

program precision
  use iso_fortran_env, only: real64
  implicit none

  real :: x32
  real(real64) :: x64, x64_wrong

  x32 = 1.0 / 3.0
  x64 = 1.0_real64 / 3.0_real64
  x64_wrong = 1.0 / 3.0   ! no suffix: precision already lost

  print *, "default real: ", x32
  print *, "real64:       ", x64
  print *, "real64 wrong: ", x64_wrong
end program precision
