program test_array_utils
  use array_utils, only: vec_mean, vec_stddev, euclidean_norm, clamp_negatives, &
                         find_extremes
  implicit none

  real, parameter :: tol = 1.0e-6
  real :: x(4)
  real :: y(4)
  real :: lo
  real :: hi

  x = [1.0, 2.0, 3.0, 4.0]
  call assert_close(vec_mean(x), 2.5, tol, "vec_mean returned the wrong value.")
  call assert_close(vec_stddev(x), sqrt(1.25), tol, "vec_stddev returned the wrong value.")
  call assert_close(euclidean_norm(x), sqrt(30.0), tol, "euclidean_norm returned the wrong value.")

  y = [-2.0, 5.0, -1.0, 0.0]
  call clamp_negatives(y)
  call assert_array_close(y, [0.0, 5.0, 0.0, 0.0], tol, "clamp_negatives did not zero out negatives.")

  call find_extremes(x, lo, hi)
  call assert_close(lo, 1.0, tol, "find_extremes returned the wrong minimum.")
  call assert_close(hi, 4.0, tol, "find_extremes returned the wrong maximum.")

  print *, "All array_utils tests passed."

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

  subroutine assert_array_close(actual, expected, tolerance, message)
    real, intent(in) :: actual(:)
    real, intent(in) :: expected(:)
    real, intent(in) :: tolerance
    character(len=*), intent(in) :: message

    if (size(actual) /= size(expected)) then
      error stop "Array sizes must match in assert_array_close."
    end if

    if (any(abs(actual - expected) > tolerance)) then
      print *, trim(message)
      print *, "actual   =", actual
      print *, "expected =", expected
      error stop 1
    end if
  end subroutine assert_array_close

end program test_array_utils
