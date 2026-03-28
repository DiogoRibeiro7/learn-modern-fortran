! Exercise 3 — Integer division predictions
!
! Answers:
!   9 / 4       -> 2       (integer division, truncated)
!   9.0 / 4.0   -> 2.25    (real division)
!   9 / 4.0     -> 2.25    (mixed: integer promoted to real first)
!   x = 9 / 4   -> 2.0     (integer division gives 2, then converted to real)
!   real(9)/real(4) -> 2.25 (explicit conversion to real before division)

program division_quiz
  implicit none

  real :: x

  print *, "9 / 4       =", 9 / 4
  print *, "9.0 / 4.0   =", 9.0 / 4.0
  print *, "9 / 4.0     =", 9 / 4.0
  x = 9 / 4
  print *, "x = 9 / 4   =", x
  x = real(9) / real(4)
  print *, "real/real    =", x
end program division_quiz
