! Exercise 1 — Array creation and printing

program array_creation
  implicit none

  integer :: a(5)

  a = [10, 20, 30, 40, 50]

  print *, "Array: ", a
  print *, "First: ", a(1)
  print *, "Last:  ", a(5)
  print *, "Size:  ", size(a)
end program array_creation
