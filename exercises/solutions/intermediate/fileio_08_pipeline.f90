! Exercise 8 — Complete pipeline (points to distances)

program pipeline
  implicit none

  integer, parameter :: max_n = 1000
  real :: xs(max_n), ys(max_n), dists(max_n)
  integer :: u_in, u_out, ios, n, i
  real :: max_dist

  ! --- Read ---
  open(newunit=u_in, file="points.txt", status="old", action="read", iostat=ios)
  if (ios /= 0) then
    print *, "Error: could not open points.txt"
    stop 1
  end if

  n = 0
  do
    read(u_in, *, iostat=ios) xs(n + 1), ys(n + 1)
    if (ios /= 0) exit
    n = n + 1
    if (n >= max_n) exit
  end do
  close(u_in)

  ! --- Process ---
  do i = 1, n
    dists(i) = sqrt(xs(i) ** 2 + ys(i) ** 2)
  end do
  max_dist = maxval(dists(1:n))

  ! --- Write ---
  open(newunit=u_out, file="distances.txt", status="replace", action="write")
  write(u_out, '(A6, 2X, A6, 2X, A8)') "x", "y", "distance"
  do i = 1, n
    write(u_out, '(F6.2, 2X, F6.2, 2X, F8.2)') xs(i), ys(i), dists(i)
  end do
  write(u_out, '(A, F9.2)') "Max distance:", max_dist
  close(u_out)

  print '(A, I3, A)', "Processed ", n, " points."
  print '(A, F8.2)',  "Max distance:", max_dist
  print *, "Wrote distances.txt"
end program pipeline
