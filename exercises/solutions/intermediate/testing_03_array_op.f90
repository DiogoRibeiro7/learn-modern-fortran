! Solution: Exercise 3 — Test an array operation
! Demonstrates assert_array_close for element-wise array comparison.

program test_array_scale
  implicit none

  real, parameter :: tol = 1.0e-6
  real :: x1(3), x2(3)

  ! Test 1: scale by 2.0
  x1 = [1.0, 2.0, 3.0]
  call scale(x1, 2.0)
  call assert_array_close(x1, [2.0, 4.0, 6.0], tol, "scale by 2.0")

  ! Test 2: scale by 0.0
  x2 = [10.0, -5.0, 0.0]
  call scale(x2, 0.0)
  call assert_array_close(x2, [0.0, 0.0, 0.0], tol, "scale by 0.0")

  print *, "All array_scale tests passed."

contains

  subroutine scale(x, factor)
    real, intent(inout) :: x(:)
    real, intent(in) :: factor
    x = x * factor
  end subroutine scale

  subroutine assert_array_close(actual, expected, tolerance, message)
    real, intent(in) :: actual(:), expected(:)
    real, intent(in) :: tolerance
    character(len=*), intent(in) :: message

    if (size(actual) /= size(expected)) then
      print *, "FAIL:", trim(message), " (size mismatch)"
      error stop 1
    end if

    if (any(abs(actual - expected) > tolerance)) then
      print *, "FAIL:", trim(message)
      print *, "  actual   =", actual
      print *, "  expected =", expected
      error stop 1
    end if
  end subroutine assert_array_close

end program test_array_scale
