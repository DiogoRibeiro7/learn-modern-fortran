! Exercise 2 — Count lines in a file

program count_lines
  implicit none

  integer :: u, ios, n
  character(len=200) :: line

  open(newunit=u, file="numbers.txt", status="old", action="read", iostat=ios)
  if (ios /= 0) then
    print *, "Error: could not open numbers.txt"
    stop 1
  end if

  n = 0
  do
    read(u, '(A)', iostat=ios) line
    if (ios /= 0) exit
    n = n + 1
  end do
  close(u)

  print *, "Lines:", n
end program count_lines
