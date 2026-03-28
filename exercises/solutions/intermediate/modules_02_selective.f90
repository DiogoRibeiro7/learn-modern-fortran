! Exercise 2 — Selective imports
!
! When you try to call stddev without importing it, the compiler reports:
!   Error: Function 'stddev' has no IMPLICIT type
!
! This happens because use...only restricts what names are visible.

module my_stats
  implicit none
  private
  public :: mean, stddev

contains

  real function mean(x)
    real, intent(in) :: x(:)
    mean = sum(x) / real(size(x))
  end function mean

  real function stddev(x)
    real, intent(in) :: x(:)
    real :: m
    m = mean(x)
    stddev = sqrt(sum((x - m) ** 2) / real(size(x)))
  end function stddev

end module my_stats


program test_selective
  use my_stats, only: mean        ! only mean, not stddev
  implicit none

  real :: data(5)
  data = [1.0, 2.0, 3.0, 4.0, 5.0]

  print *, "Mean:", mean(data)

  ! Uncommenting the next line causes a compile error:
  ! print *, "Stddev:", stddev(data)
end program test_selective
