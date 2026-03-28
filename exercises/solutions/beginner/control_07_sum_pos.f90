! Exercise 7 — Sum positives only (using cycle)

program sum_positives
  implicit none

  real :: x(6)
  real :: total
  integer :: i

  x = [4.0, -2.0, 7.0, 0.0, -3.0, 8.0]
  total = 0.0

  do i = 1, size(x)
    if (x(i) <= 0.0) cycle
    total = total + x(i)
  end do

  print *, "Sum of positives:", total    ! expected: 19.0
end program sum_positives
