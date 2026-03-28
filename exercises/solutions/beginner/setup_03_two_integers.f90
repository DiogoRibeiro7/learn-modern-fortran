! Exercise 3 — Two integers
! Computes sum, difference, product, and quotient of two integers.

program two_integers
  implicit none

  integer :: a, b

  a = 17
  b = 5

  print *, "a     =", a
  print *, "b     =", b
  print *, "a + b =", a + b
  print *, "a - b =", a - b
  print *, "a * b =", a * b
  print *, "a / b =", a / b

  ! a / b gives 3, not 3.4, because both operands are integers.
  ! Fortran truncates toward zero for integer division.
end program two_integers
