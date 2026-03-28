! Exercise 5 — Read and write: squared values

program squared
  implicit none

  integer :: u_in, u_out, ios
  real :: value

  open(newunit=u_in, file="input.txt", status="old", action="read", iostat=ios)
  if (ios /= 0) then
    print *, "Error: could not open input.txt"
    stop 1
  end if

  open(newunit=u_out, file="output.txt", status="replace", action="write")

  do
    read(u_in, *, iostat=ios) value
    if (ios /= 0) exit
    write(u_out, '(F6.2, 2X, F9.2)') value, value ** 2
  end do

  close(u_in)
  close(u_out)

  print *, "Wrote output.txt"
end program squared
