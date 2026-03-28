program main
  use vector_ops, only: vector_mean, dot_product_safe, euclidean_norm
  implicit none

  real :: x(3)
  real :: y(3)

  x = [1.0, 2.0, 3.0]
  y = [4.0, 5.0, 6.0]

  print *, "x mean         =", vector_mean(x)
  print *, "x dot y        =", dot_product_safe(x, y)
  print *, "norm of x      =", euclidean_norm(x)
end program main
