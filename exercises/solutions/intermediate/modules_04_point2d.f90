! Exercise 4 — Point2D type

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


program test_point2d
  use geometry_mod, only: point2d_t, distance
  implicit none

  type(point2d_t) :: origin, p

  origin = point2d_t(x=0.0, y=0.0)
  p = point2d_t(x=3.0, y=4.0)

  print *, "Origin:", origin%x, origin%y
  print *, "Point: ", p%x, p%y
  print *, "Distance:", distance(origin, p)    ! expected: 5.0
end program test_point2d
