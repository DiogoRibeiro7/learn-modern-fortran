! Solution: Exercise 4 — Test a statistics pair
! Tests mean, variance, and stddev with hand-computable inputs.

program test_stats_pair
  implicit none

  real, parameter :: tol = 1.0e-6
  real :: v1(4), v2(3)

  ! Data set 1: [2, 4, 6, 8]
  ! mean = 20/4 = 5.0
  ! variance = ((2-5)^2 + (4-5)^2 + (6-5)^2 + (8-5)^2) / 4 = (9+1+1+9)/4 = 5.0
  ! stddev = sqrt(5.0)
  v1 = [2.0, 4.0, 6.0, 8.0]
  call assert_close(vec_mean(v1), 5.0, tol, "mean of [2,4,6,8]")
  call assert_close(vec_variance(v1), 5.0, tol, "variance of [2,4,6,8]")
  call assert_close(vec_stddev(v1), sqrt(5.0), tol, "stddev of [2,4,6,8]")

  ! Data set 2: [10, 10, 10] — constant, variance and stddev should be 0
  v2 = [10.0, 10.0, 10.0]
  call assert_close(vec_mean(v2), 10.0, tol, "mean of constant array")
  call assert_close(vec_variance(v2), 0.0, tol, "variance of constant array")
  call assert_close(vec_stddev(v2), 0.0, tol, "stddev of constant array")

  print *, "All stats_pair tests passed."

contains

  real function vec_mean(x) result(m)
    real, intent(in) :: x(:)
    m = sum(x) / real(size(x))
  end function vec_mean

  real function vec_variance(x) result(v)
    real, intent(in) :: x(:)
    real :: m
    m = sum(x) / real(size(x))
    v = sum((x - m)**2) / real(size(x))
  end function vec_variance

  real function vec_stddev(x) result(s)
    real, intent(in) :: x(:)
    s = sqrt(vec_variance(x))
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

end program test_stats_pair
