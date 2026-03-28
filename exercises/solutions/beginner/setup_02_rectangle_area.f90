! Exercise 2 — Rectangle area
! Computes and prints the area of a rectangle.

program rectangle_area
  implicit none

  real :: width, height, area

  width = 5.0
  height = 3.0
  area = width * height

  print *, "Width: ", width
  print *, "Height:", height
  print *, "Area:  ", area
end program rectangle_area
