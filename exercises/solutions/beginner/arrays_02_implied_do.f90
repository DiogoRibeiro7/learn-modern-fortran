! Exercise 2 — Implied do loop for cubes

program cubes
  implicit none

  integer :: i
  real :: c(8)

  c = [(real(i ** 3), i = 1, 8)]

  print *, "Cubes:", c
end program cubes
