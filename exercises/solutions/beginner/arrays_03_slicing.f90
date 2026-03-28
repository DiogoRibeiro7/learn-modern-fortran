! Exercise 3 — Array slicing

program slicing
  implicit none

  integer :: v(10), i

  v = [(i, i = 1, 10)]

  print *, "Elements 3-7:  ", v(3:7)
  print *, "Every other:   ", v(1:9:2)
  print *, "Reversed:      ", v(10:1:-1)
end program slicing
