! Exercise 8 — Multiplication table

program mul_table
  implicit none

  integer :: row, col, values(5)

  do row = 1, 5
    do col = 1, 5
      values(col) = row * col
    end do
    print '(5I4)', values
  end do
end program mul_table
