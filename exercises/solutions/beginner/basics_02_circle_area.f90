! Exercise 2 — Circle area with parameter
! Computes the area of a circle using pi as a named constant.

program circle_area
  implicit none

  real, parameter :: pi = 3.14159265
  real :: radius, area

  radius = 5.0
  area = pi * radius ** 2

  print *, "Radius:", radius
  print *, "Area:  ", area
end program circle_area
