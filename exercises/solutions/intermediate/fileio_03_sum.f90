! Exercise 3 — Sum from a file

program file_sum
  implicit none

  integer :: u, ios
  real :: value, total

  open(newunit=u, file="values.txt", status="old", action="read", iostat=ios)
  if (ios /= 0) then
    print *, "Error: could not open values.txt"
    stop 1
  end if

  total = 0.0
  do
    read(u, *, iostat=ios) value
    if (ios /= 0) exit
    total = total + value
  end do
  close(u)

  print *, "Sum:", total    ! expected: 17.0
end program file_sum
