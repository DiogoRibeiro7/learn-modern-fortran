program main
  use array_utils, only: vec_mean, vec_stddev, euclidean_norm, &
                         clamp_negatives, find_extremes
  implicit none

  real :: data(8), mixed(5)
  real :: lo, hi

  data = [4.0, -2.0, 7.0, 1.0, -3.0, 8.0, 5.0, 0.0]

  ! --- Array basics ---
  print *, "=== Array operations ==="
  print *, "Data:  ", data
  print *, "Sum:   ", sum(data)
  print *, "Size:  ", size(data)
  print *

  ! --- Slicing ---
  print *, "=== Slicing ==="
  print *, "First 3: ", data(1:3)
  print *, "Last 3:  ", data(6:8)
  print *, "Reversed:", data(8:1:-1)
  print *

  ! --- Element-wise operations ---
  print *, "=== Element-wise ==="
  print *, "data + 10:", data + 10.0
  print *, "data ** 2:", data ** 2
  print *

  ! --- Statistics from module procedures ---
  print *, "=== Statistics ==="
  print '(A, F8.3)', " Mean:   ", vec_mean(data)
  print '(A, F8.3)', " Std dev:", vec_stddev(data)
  print '(A, F8.3)', " Norm:   ", euclidean_norm(data)

  call find_extremes(data, lo, hi)
  print '(A, F8.3)', " Min:    ", lo
  print '(A, F8.3)', " Max:    ", hi
  print *

  ! --- Subroutine with intent(inout) ---
  mixed = [-2.0, 3.0, -1.0, 4.0, 0.0]
  print *, "=== Clamp negatives ==="
  print *, "Before:", mixed
  call clamp_negatives(mixed)
  print *, "After: ", mixed
  print *

  ! --- Loops ---
  print *, "=== Counting positives (loop) ==="
  print *, "Positive count:", count_positive(data)

contains

  integer function count_positive(x)
    real, intent(in) :: x(:)
    integer :: j

    count_positive = 0
    do j = 1, size(x)
      if (x(j) > 0.0) count_positive = count_positive + 1
    end do
  end function count_positive

end program main
