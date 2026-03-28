! Exercise 6 — Normalize a vector in place

program normalize_test
  implicit none

  real :: v(3)

  v = [3.0, 4.0, 0.0]
  print *, "Before:", v

  call normalize(v)
  print *, "After: ", v
  print *, "Norm:  ", sqrt(sum(v * v))    ! expected: ~1.0

contains

  subroutine normalize(x)
    real, intent(inout) :: x(:)
    real :: n
    n = sqrt(sum(x * x))
    if (n > 0.0) x = x / n
  end subroutine normalize

end program normalize_test
