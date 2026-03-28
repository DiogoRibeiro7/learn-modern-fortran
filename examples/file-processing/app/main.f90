! Companion example for Lesson 05 — File I/O.
! Reads measurement data, computes statistics, writes a report.
!
! Run from the examples/file-processing/ directory so the data/ path resolves:
!   fpm run

program main
  implicit none

  integer, parameter :: max_values = 1000
  real :: values(max_values)
  integer :: u_in, u_out, ios, n
  real :: mean_val, min_val, max_val, std_val

  ! --- Read data ---
  open(newunit=u_in, file="data/measurements.txt", status="old", &
       action="read", iostat=ios)
  if (ios /= 0) then
    print *, "Error: could not open data/measurements.txt"
    print *, "Make sure you run from the examples/file-processing/ directory."
    error stop 1
  end if

  n = 0
  do
    read(u_in, *, iostat=ios) values(n + 1)
    if (ios /= 0) exit
    n = n + 1
    if (n >= max_values) exit
  end do
  close(u_in)

  if (n == 0) then
    print *, "No data read."
    error stop 1
  end if

  ! --- Compute statistics ---
  mean_val = sum(values(1:n)) / real(n)
  min_val  = minval(values(1:n))
  max_val  = maxval(values(1:n))
  std_val  = sqrt(sum((values(1:n) - mean_val) ** 2) / real(n))

  ! --- Print to screen ---
  print '(A, I4, A)', "Read ", n, " measurements."
  print '(A, F8.3)', "Mean:   ", mean_val
  print '(A, F8.3)', "Min:    ", min_val
  print '(A, F8.3)', "Max:    ", max_val
  print '(A, F8.3)', "Stddev: ", std_val

  ! --- Write report file ---
  open(newunit=u_out, file="report.txt", status="replace", action="write")
  write(u_out, '(A)')        "=== Measurement Report ==="
  write(u_out, '(A, I6)')    "Count:  ", n
  write(u_out, '(A, F10.3)') "Mean:   ", mean_val
  write(u_out, '(A, F10.3)') "Min:    ", min_val
  write(u_out, '(A, F10.3)') "Max:    ", max_val
  write(u_out, '(A, F10.3)') "Stddev: ", std_val
  close(u_out)

  print *, "Report written to report.txt"
end program main
