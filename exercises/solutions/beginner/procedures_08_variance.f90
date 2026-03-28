! Exercise 8 — Procedure calling procedure (mean + variance)

program variance_test
  implicit none

  real :: x(6)

  x = [2.0, 4.0, 4.0, 4.0, 5.0, 5.0]

  print *, "Mean:    ", vec_mean(x)       ! expected: 4.0
  print *, "Variance:", vec_variance(x)   ! expected: 1.0

contains

  real function vec_mean(v)
    real, intent(in) :: v(:)
    vec_mean = sum(v) / real(size(v))
  end function vec_mean

  real function vec_variance(v)
    real, intent(in) :: v(:)
    real :: m
    m = vec_mean(v)
    vec_variance = sum((v - m) ** 2) / real(size(v))
  end function vec_variance

end program variance_test
