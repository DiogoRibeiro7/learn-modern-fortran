! Solution: Exercise 2 — Test vector_mean with edge cases
! Uses the assert_close pattern for tolerance-based floating-point checks.

program test_vector_mean_edges
  implicit none

  real, parameter :: tol = 1.0e-6

  ! Normal case
  call assert_close(vec_mean([1.0, 2.0, 3.0, 4.0, 5.0]), 3.0, tol, &
    "mean of [1,2,3,4,5]")

  ! Single element
  call assert_close(vec_mean([42.0]), 42.0, tol, "mean of single element")

  ! Negative values
  call assert_close(vec_mean([-1.0, -2.0, -3.0]), -2.0, tol, "mean of negatives")

  print *, "All vector_mean tests passed."

contains

  real function vec_mean(x) result(m)
    real, intent(in) :: x(:)
    m = sum(x) / real(size(x))
  end function vec_mean

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

end program test_vector_mean_edges
