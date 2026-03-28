! Exercise 1 — Circle module

module circle_mod
  implicit none
  private
  public :: pi, circle_area, circle_circumference

  real, parameter :: pi = 3.14159265

contains

  real function circle_area(r)
    real, intent(in) :: r
    circle_area = pi * r ** 2
  end function circle_area

  real function circle_circumference(r)
    real, intent(in) :: r
    circle_circumference = 2.0 * pi * r
  end function circle_circumference

end module circle_mod


program test_circle
  use circle_mod, only: circle_area, circle_circumference
  implicit none

  real :: r
  r = 5.0

  print *, "Radius:       ", r
  print *, "Area:         ", circle_area(r)
  print *, "Circumference:", circle_circumference(r)
end program test_circle
