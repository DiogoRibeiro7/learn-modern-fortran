! Exercise 4 — File statistics

program file_stats
  implicit none

  integer, parameter :: max_n = 1000
  real :: data(max_n)
  integer :: u, ios, n
  real :: total, mean_val

  open(newunit=u, file="scores.txt", status="old", action="read", iostat=ios)
  if (ios /= 0) then
    print *, "Error: could not open scores.txt"
    stop 1
  end if

  n = 0
  do
    read(u, *, iostat=ios) data(n + 1)
    if (ios /= 0) exit
    n = n + 1
    if (n >= max_n) exit
  end do
  close(u)

  total = sum(data(1:n))
  mean_val = total / real(n)

  print '(A, I6)',    "Count:", n
  print '(A, F10.3)', "Sum:  ", total
  print '(A, F10.3)', "Mean: ", mean_val
  print '(A, F10.3)', "Min:  ", minval(data(1:n))
  print '(A, F10.3)', "Max:  ", maxval(data(1:n))
end program file_stats
