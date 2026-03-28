! Exercise 4 — Sum with a loop vs intrinsic

program loop_sum
  implicit none

  real :: x(5)
  real :: total
  integer :: i

  x = [3.0, 7.0, 1.0, 9.0, 4.0]
  total = 0.0

  do i = 1, size(x)
    total = total + x(i)
  end do

  print *, "Loop sum:     ", total
  print *, "Intrinsic sum:", sum(x)
end program loop_sum
