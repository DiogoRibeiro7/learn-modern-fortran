! Exercise 9 — Interval type

module interval_mod
  implicit none
  private
  public :: interval_t

  type :: interval_t
    real :: lo = 0.0
    real :: hi = 0.0
  contains
    procedure :: width
    procedure :: contains_point
    procedure :: overlaps
  end type interval_t

contains

  real function width(self)
    class(interval_t), intent(in) :: self
    width = self%hi - self%lo
  end function width

  logical function contains_point(self, x)
    class(interval_t), intent(in) :: self
    real, intent(in) :: x
    contains_point = (x >= self%lo) .and. (x <= self%hi)
  end function contains_point

  logical function overlaps(self, other)
    class(interval_t), intent(in) :: self
    class(interval_t), intent(in) :: other
    overlaps = (self%lo <= other%hi) .and. (self%hi >= other%lo)
  end function overlaps

end module interval_mod


program test_interval
  use interval_mod, only: interval_t
  implicit none

  type(interval_t) :: a, b, c

  a = interval_t(lo=1.0, hi=5.0)
  b = interval_t(lo=4.0, hi=8.0)
  c = interval_t(lo=6.0, hi=9.0)

  print *, "Width of a:     ", a%width()               ! 4.0
  print *, "a contains 3.0: ", a%contains_point(3.0)    ! T
  print *, "a contains 6.0: ", a%contains_point(6.0)    ! F
  print *, "a overlaps b:   ", a%overlaps(b)            ! T
  print *, "a overlaps c:   ", a%overlaps(c)            ! F
end program test_interval
