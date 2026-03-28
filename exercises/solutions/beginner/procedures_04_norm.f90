! Exercise 4 — Function with result clause

program norm_test
  implicit none

  real :: v(2)

  v = [3.0, 4.0]
  print *, "Norm:", euclidean_norm(v)    ! expected: 5.0

contains

  real function euclidean_norm(x) result(value)
    real, intent(in) :: x(:)
    value = sqrt(sum(x * x))
  end function euclidean_norm

end program norm_test
