! Exercise 5 — Count above threshold

program count_above
  implicit none

  real :: x(6)
  real :: threshold
  integer :: n, i

  x = [1.5, 3.2, 0.8, 4.1, 2.9, 5.0]
  threshold = 3.0
  n = 0

  do i = 1, size(x)
    if (x(i) > threshold) n = n + 1
  end do

  print *, "Count above", threshold, ":", n    ! expected: 3
end program count_above
