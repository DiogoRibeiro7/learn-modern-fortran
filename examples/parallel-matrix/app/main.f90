program parallel_matrix_demo
  use omp_lib, only : omp_get_wtime
  use parallel_matrix, only : dp, column_l2_serial, column_l2_openmp, &
                              max_openmp_threads
  implicit none

  integer, parameter :: n_rows = 4000
  integer, parameter :: n_columns = 256

  real(dp), allocatable :: matrix(:, :)
  real(dp), allocatable :: serial_norms(:)
  real(dp), allocatable :: parallel_norms(:)
  real(dp) :: serial_start
  real(dp) :: serial_end
  real(dp) :: parallel_start
  real(dp) :: parallel_end
  real(dp) :: max_abs_difference
  integer :: i
  integer :: j

  allocate(matrix(n_rows, n_columns))
  allocate(serial_norms(n_columns))
  allocate(parallel_norms(n_columns))

  do j = 1, n_columns
    do i = 1, n_rows
      matrix(i, j) = sin(0.001_dp * real(i, dp)) + &
                     cos(0.01_dp * real(j, dp))
    end do
  end do

  serial_start = omp_get_wtime()
  call column_l2_serial(matrix, serial_norms)
  serial_end = omp_get_wtime()

  parallel_start = omp_get_wtime()
  call column_l2_openmp(matrix, parallel_norms)
  parallel_end = omp_get_wtime()

  max_abs_difference = maxval(abs(serial_norms - parallel_norms))

  print '(a, i0)', 'OpenMP max threads: ', max_openmp_threads()
  print '(a, f10.6, a)', 'Serial wall time:   ', &
                         serial_end - serial_start, ' s'
  print '(a, f10.6, a)', 'Parallel wall time: ', &
                         parallel_end - parallel_start, ' s'
  print '(a, es12.4)', 'Maximum absolute difference: ', max_abs_difference
  print '(a)', 'Timing is diagnostic only; correctness is tested separately.'

  if (max_abs_difference > 100.0_dp * epsilon(1.0_dp)) then
    error stop "parallel and serial results disagree"
  end if
end program parallel_matrix_demo
