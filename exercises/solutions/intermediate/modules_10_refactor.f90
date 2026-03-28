! Exercise 10 — Refactor internal procedures into a module
!
! Before: vec_mean and vec_stddev lived inside a program's contains block.
! After: they live in a module that any program can import.

module vec_stats_mod
  implicit none
  private
  public :: vec_mean, vec_stddev

contains

  real function vec_mean(x)
    real, intent(in) :: x(:)
    vec_mean = sum(x) / real(size(x))
  end function vec_mean

  real function vec_stddev(x)
    real, intent(in) :: x(:)
    real :: m
    m = vec_mean(x)
    vec_stddev = sqrt(sum((x - m) ** 2) / real(size(x)))
  end function vec_stddev

end module vec_stats_mod


program test_refactor
  use vec_stats_mod, only: vec_mean, vec_stddev
  implicit none

  real :: data(8)
  data = [4.0, -2.0, 7.0, 1.0, -3.0, 8.0, 5.0, 0.0]

  print *, "Mean:  ", vec_mean(data)
  print *, "Stddev:", vec_stddev(data)
end program test_refactor
