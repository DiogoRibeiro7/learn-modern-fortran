! Exercise 7 — Matrix row sums

program row_sums
  implicit none

  real :: mat(3, 4)
  integer :: i

  mat = reshape([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, &
                 7.0, 8.0, 9.0, 10.0, 11.0, 12.0], [3, 4])

  do i = 1, 3
    print *, "Row", i, ":", mat(i, :), " Sum:", sum(mat(i, :))
  end do
end program row_sums
