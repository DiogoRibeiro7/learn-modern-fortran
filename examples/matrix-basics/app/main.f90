program main
  implicit none

  real :: a(3, 3), b(3, 3), c(3, 3)
  real :: a_transpose(3, 3)
  real :: v(3), result_v(3)
  integer :: i

  ! --- Build a 3x3 matrix ---
  a = reshape([ 1.0, 4.0, 7.0, &
                2.0, 5.0, 8.0, &
                3.0, 6.0, 9.0 ], [3, 3])

  print *, "=== Matrix A ==="
  do i = 1, 3
    print '(3F8.2)', a(i, :)
  end do
  print *

  ! --- Row and column operations ---
  print *, "=== Row and column sums ==="
  do i = 1, 3
    print '(A, I1, A, F8.2)', "  Row ", i, " sum:", sum(a(i, :))
  end do
  do i = 1, 3
    print '(A, I1, A, F8.2)', "  Col ", i, " sum:", sum(a(:, i))
  end do
  print *

  ! --- Identity matrix ---
  b = 0.0
  do i = 1, 3
    b(i, i) = 1.0
  end do

  print *, "=== Identity matrix ==="
  do i = 1, 3
    print '(3F8.2)', b(i, :)
  end do
  print *

  ! --- Matrix multiplication with matmul ---
  c = matmul(a, b)

  print *, "=== A * I (should equal A) ==="
  do i = 1, 3
    print '(3F8.2)', c(i, :)
  end do
  print *

  ! --- Matrix-vector multiplication ---
  v = [1.0, 0.0, 0.0]
  result_v = matmul(a, v)

  print *, "=== A * [1, 0, 0] (first column of A) ==="
  print '(3F8.2)', result_v
  print *

  ! --- Transpose ---
  a_transpose = transpose(a)

  print *, "=== Transpose of A ==="
  do i = 1, 3
    print '(3F8.2)', a_transpose(i, :)
  end do
end program main
