! Exercise 2 — Subroutine: swap two values

program swap_test
  implicit none

  real :: a, b

  a = 3.0
  b = 7.0

  print *, "Before: a =", a, " b =", b
  call swap(a, b)
  print *, "After:  a =", a, " b =", b

contains

  subroutine swap(x, y)
    real, intent(inout) :: x, y
    real :: temp
    temp = x
    x = y
    y = temp
  end subroutine swap

end program swap_test
