program test_matrix_stats
  use iso_fortran_env, only: real64
  use matrix_stats, only: row_sums, column_sums, column_means, matrix_vector_product, &
    frobenius_norm
  implicit none

  real(real64), parameter :: tol = 1.0e-12_real64
  real(real64) :: x(3, 3)
  real(real64) :: weights(3)

  x(1, :) = [2.0_real64, 4.0_real64, 6.0_real64]
  x(2, :) = [1.0_real64, 3.0_real64, 5.0_real64]
  x(3, :) = [0.0_real64, 2.0_real64, 4.0_real64]
  weights = [1.0_real64, 0.5_real64, -1.0_real64]

  call assert_array_close(row_sums(x), [12.0_real64, 9.0_real64, 6.0_real64], tol, &
    "row_sums returned the wrong values.")
  call assert_array_close(column_sums(x), [3.0_real64, 9.0_real64, 15.0_real64], tol, &
    "column_sums returned the wrong values.")
  call assert_array_close(column_means(x), [1.0_real64, 3.0_real64, 5.0_real64], tol, &
    "column_means returned the wrong values.")
  call assert_array_close(matrix_vector_product(x, weights), [-2.0_real64, -2.5_real64, -3.0_real64], &
    tol, "matrix_vector_product returned the wrong values.")
  call assert_close(frobenius_norm(x), sqrt(111.0_real64), tol, &
    "frobenius_norm returned the wrong value.")

  print *, "All matrix_stats tests passed."

contains

  subroutine assert_close(actual, expected, tolerance, message)
    real(real64), intent(in) :: actual
    real(real64), intent(in) :: expected
    real(real64), intent(in) :: tolerance
    character(len=*), intent(in) :: message

    if (abs(actual - expected) > tolerance) then
      print *, trim(message)
      print *, "actual   =", actual
      print *, "expected =", expected
      error stop 1
    end if
  end subroutine assert_close

  subroutine assert_array_close(actual, expected, tolerance, message)
    real(real64), intent(in) :: actual(:)
    real(real64), intent(in) :: expected(:)
    real(real64), intent(in) :: tolerance
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

end program test_matrix_stats
