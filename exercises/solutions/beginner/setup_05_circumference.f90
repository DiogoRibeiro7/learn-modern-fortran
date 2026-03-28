! Exercise 5 — Circle circumference
! Computes and prints the circumference of a circle.

program circumference
  implicit none

  real, parameter :: pi = 3.14159265
  real :: radius, circ

  radius = 4.0
  circ = 2.0 * pi * radius

  print *, "Radius:       ", radius
  print *, "Circumference:", circ
end program circumference
