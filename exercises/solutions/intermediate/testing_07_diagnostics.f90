! Solution: Exercise 7 — Diagnostic messages
! Enhanced assert_close that prints actual, expected, and difference.

program test_diagnostics
  implicit none

  real, parameter :: tol = 1.0e-6
  real :: values(4)

  values = [2.0, 4.0, 6.0, 8.0]

  call assert_close(vec_mean(values), 5.0, tol, "mean of [2,4,6,8]")
  call assert_close(vec_variance(values), 5.0, tol, "variance of [2,4,6,8]")
  call assert_close(vec_stddev(values), sqrt(5.0), tol, "stddev of [2,4,6,8]")

  print *, "All diagnostic tests passed."

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

  ! Enhanced assert_close with diff reporting
  subroutine assert_close(actual, expected, tolerance, message)
    real, intent(in) :: actual, expected, tolerance
    character(len=*), intent(in) :: message

    if (abs(actual - expected) > tolerance) then
      print *, "FAIL:", trim(message)
      print *, "  actual   =", actual
      print *, "  expected =", expected
      print *, "  diff     =", abs(actual - expected)
      error stop 1
    end if
  end subroutine assert_close

end program test_diagnostics
