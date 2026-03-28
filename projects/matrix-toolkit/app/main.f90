program main
  use matrix_stats, only: row_sums, column_sums
  implicit none

  real :: x(2, 3)
  real :: rs(2)
  real :: cs(3)

  x = reshape([1.0, 2.0, 3.0, 4.0, 5.0, 6.0], shape(x))

  rs = row_sums(x)
  cs = column_sums(x)

  print *, "Row sums    =", rs
  print *, "Column sums =", cs
end program main
