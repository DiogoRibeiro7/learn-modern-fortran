! Companion example for Lesson 05 — File I/O.
! Reads measurement data, computes statistics, writes a report.
!
! Run from the examples/file-processing/ directory so the data/ path resolves:
!   fpm run

program main
  use file_processing_mod, only: read_measurements, compute_statistics
  implicit none

  integer, parameter :: max_values = 1000
  real :: values(max_values)
  integer :: ios, n, u_out
  real :: mean_val, min_val, max_val, std_val

  ! --- Read data ---
  call read_measurements("data/measurements.txt", values, n, ios)
  if (ios /= 0) then
    print *, "Error: could not open data/measurements.txt"
    print *, "Make sure you run from the examples/file-processing/ directory."
    error stop 1
  end if

  if (n == 0) then
    print *, "No data read."
    error stop 1
  end if

  ! --- Compute statistics ---
  call compute_statistics(values, n, mean_val, min_val, max_val, std_val)

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
