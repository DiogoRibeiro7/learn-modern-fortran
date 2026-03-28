! Exercise 6 — Multi-column data (students and scores)

program students
  implicit none

  integer :: u, ios, n
  character(len=20) :: name
  real :: score, total

  open(newunit=u, file="students.txt", status="old", action="read", iostat=ios)
  if (ios /= 0) then
    print *, "Error: could not open students.txt"
    stop 1
  end if

  n = 0
  total = 0.0
  do
    read(u, *, iostat=ios) name, score
    if (ios /= 0) exit
    print *, trim(name), ":", score
    total = total + score
    n = n + 1
  end do
  close(u)

  if (n > 0) then
    print '(A, F7.1)', "Average:", total / real(n)
  end if
end program students
