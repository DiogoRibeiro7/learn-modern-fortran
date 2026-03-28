program main
  use iso_fortran_env, only: real64
  use matrix_stats, only: row_sums, column_sums, column_means, matrix_vector_product, &
    frobenius_norm
  implicit none

  real(real64) :: x(3, 3)
  real(real64) :: weights(3)

  x(1, :) = [2.0_real64, 4.0_real64, 6.0_real64]
  x(2, :) = [1.0_real64, 3.0_real64, 5.0_real64]
  x(3, :) = [0.0_real64, 2.0_real64, 4.0_real64]
  weights = [1.0_real64, 0.5_real64, -1.0_real64]

  print *, "Matrix:"
  print '(3f8.2)', x(1, :)
  print '(3f8.2)', x(2, :)
  print '(3f8.2)', x(3, :)

  print *, ""
  print *, "Row sums           =", row_sums(x)
  print *, "Column sums        =", column_sums(x)
  print *, "Column means       =", column_means(x)
  print *, "A * weights        =", matrix_vector_product(x, weights)
  print *, "Frobenius norm     =", frobenius_norm(x)
end program main
