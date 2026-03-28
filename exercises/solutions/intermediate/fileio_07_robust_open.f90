! Exercise 7 — Robust file open

program robust_open
  implicit none

  integer :: u, ios
  character(len=50) :: filename

  filename = "nonexistent_file.txt"

  open(newunit=u, file=filename, status="old", action="read", iostat=ios)

  if (ios /= 0) then
    print *, "Error: could not open " // trim(filename)
    stop 1
  end if

  print *, "File opened successfully."
  close(u)
end program robust_open
