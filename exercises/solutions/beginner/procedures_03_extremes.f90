! Exercise 3 — Subroutine: min and max with intent(out)

program extremes_test
  implicit none

  real :: x(4), lo, hi

  x = [4.0, -2.0, 7.0, 1.0]

  call find_extremes(x, lo, hi)
  print *, "Min:", lo    ! expected: -2.0
  print *, "Max:", hi    ! expected: 7.0

contains

  subroutine find_extremes(arr, minimum, maximum)
    real, intent(in) :: arr(:)
    real, intent(out) :: minimum, maximum
    minimum = minval(arr)
    maximum = maxval(arr)
  end subroutine find_extremes

end program extremes_test
