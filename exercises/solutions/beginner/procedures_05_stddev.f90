! Exercise 5 — Standard deviation (calling mean internally)

program stddev_test
  implicit none

  real :: x(8)

  x = [2.0, 4.0, 4.0, 4.0, 5.0, 5.0, 7.0, 9.0]

  print *, "Mean:  ", mean(x)
  print *, "Stddev:", stddev(x)    ! expected: ~2.0

contains

  real function mean(v)
    real, intent(in) :: v(:)
    mean = sum(v) / real(size(v))
  end function mean

  real function stddev(v)
    real, intent(in) :: v(:)
    real :: m
    m = mean(v)
    stddev = sqrt(sum((v - m) ** 2) / real(size(v)))
  end function stddev

end program stddev_test
