! Exercise 1 — Write a greeting file

program greeting
  implicit none

  integer :: u

  open(newunit=u, file="greeting.txt", status="replace", action="write")
  write(u, *) "Hello from Fortran!"
  write(u, *) "This file was created by a program."
  write(u, *) "File I/O is straightforward."
  close(u)

  print *, "Wrote greeting.txt"
end program greeting
