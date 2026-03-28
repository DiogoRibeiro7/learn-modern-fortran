! Exercise 5 — Structure constructor

module geometry_mod
  implicit none
  private
  public :: point2d_t, distance

  type :: point2d_t
    real :: x = 0.0
    real :: y = 0.0
  end type point2d_t

contains

  real function distance(a, b)
    type(point2d_t), intent(in) :: a, b
    distance = sqrt((a%x - b%x) ** 2 + (a%y - b%y) ** 2)
  end function distance

end module geometry_mod


program test_constructor
  use geometry_mod, only: point2d_t, distance
  implicit none

  type(point2d_t) :: origin, p1, p2

  origin = point2d_t(x=0.0, y=0.0)
  p1 = point2d_t(x=3.0, y=4.0)
  p2 = point2d_t(x=-1.0, y=1.0)

  print *, "Distance origin -> p1:", distance(origin, p1)  ! 5.0
  print *, "Distance origin -> p2:", distance(origin, p2)  ! ~1.414
  print *, "Distance p1 -> p2:    ", distance(p1, p2)      ! 5.0
end program test_constructor
