! Solution: Exercise 5 — Add boundary tests
! Tests edge cases: single element, identical values, large values, mixed signs.

program test_boundary_cases
  implicit none

  real, parameter :: tol = 1.0e-6

  ! Single-element array
  call assert_close(vec_mean([7.0]), 7.0, tol, "mean of single element")
  call assert_close(vec_stddev([7.0]), 0.0, tol, "stddev of single element")

  ! Two identical elements
  call assert_close(vec_mean([3.0, 3.0]), 3.0, tol, "mean of identical pair")
  call assert_close(vec_stddev([3.0, 3.0]), 0.0, tol, "stddev of identical pair")

  ! Large values
  call assert_close(vec_mean([1.0e6, 2.0e6, 3.0e6]), 2.0e6, 1.0, &
    "mean of large values")

  ! Mix of positive and negative (cancel out)
  call assert_close(vec_mean([-10.0, 10.0]), 0.0, tol, "mean of +/- pair")

  print *, "All boundary tests passed."

contains

  real function vec_mean(x) result(m)
    real, intent(in) :: x(:)
    m = sum(x) / real(size(x))
  end function vec_mean

  real function vec_stddev(x) result(s)
    real, intent(in) :: x(:)
    real :: m
    m = sum(x) / real(size(x))
    s = sqrt(sum((x - m)**2) / real(size(x)))
  end function vec_stddev

  subroutine assert_close(actual, expected, tolerance, message)
    real, intent(in) :: actual, expected, tolerance
    character(len=*), intent(in) :: message

    if (abs(actual - expected) > tolerance) then
      print *, "FAIL:", trim(message)
      print *, "  actual   =", actual
      print *, "  expected =", expected
      error stop 1
    end if
  end subroutine assert_close

end program test_boundary_cases
