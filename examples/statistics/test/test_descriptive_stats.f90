program test_descriptive_stats
  use descriptive_stats, only: mean, median, variance, stddev
  implicit none

  real, parameter :: tol = 1.0e-6
  real :: x_even(4)
  real :: x_odd(5)

  x_even = [1.0, 2.0, 3.0, 4.0]
  x_odd = [9.0, 2.0, 5.0, 7.0, 1.0]

  call assert_close(mean(x_even), 2.5, tol, "mean returned the wrong value.")
  call assert_close(median(x_even), 2.5, tol, "median failed on even-length input.")
  call assert_close(variance(x_even), 1.25, tol, "variance returned the wrong value.")
  call assert_close(stddev(x_even), sqrt(1.25), tol, "stddev returned the wrong value.")
  call assert_close(median(x_odd), 5.0, tol, "median failed on odd-length input.")

  print *, "All descriptive_stats tests passed."

contains

  subroutine assert_close(actual, expected, tolerance, message)
    real, intent(in) :: actual
    real, intent(in) :: expected
    real, intent(in) :: tolerance
    character(len=*), intent(in) :: message

    if (abs(actual - expected) > tolerance) then
      print *, trim(message)
      print *, "actual   =", actual
      print *, "expected =", expected
      error stop 1
    end if
  end subroutine assert_close

end program test_descriptive_stats
