program main
  use iso_fortran_env, only: real64
  use matrix_stats, only: row_sums, column_sums
  implicit none

  real(real64) :: x(2, 3)

  x(1, :) = [1.0_real64, 2.0_real64, 3.0_real64]
  x(2, :) = [4.0_real64, 5.0_real64, 6.0_real64]

  print *, "Row sums    =", row_sums(x)
  print *, "Column sums =", column_sums(x)

  ! TODO:
  ! 1. Add a column_means procedure to the module.
  ! 2. Add a matrix_vector_product procedure.
  ! 3. Compare your result against the intrinsic matmul.
end program main
