program test_parallel_matrix
  use parallel_matrix, only : dp, column_l2_serial, column_l2_openmp
  implicit none

  real(dp) :: matrix(3, 3)
  real(dp) :: expected(3)
  real(dp) :: serial_norms(3)
  real(dp) :: parallel_norms(3)
  real(dp), parameter :: tolerance = 100.0_dp * epsilon(1.0_dp)
  integer :: failures

  failures = 0

  matrix(:, 1) = [3.0_dp, 4.0_dp, 0.0_dp]
  matrix(:, 2) = [1.0_dp, 2.0_dp, 2.0_dp]
  matrix(:, 3) = [0.0_dp, 0.0_dp, 0.0_dp]
  expected = [5.0_dp, 3.0_dp, 0.0_dp]

  call column_l2_serial(matrix, serial_norms)
  call column_l2_openmp(matrix, parallel_norms)

  call check_vector("serial known values", serial_norms, expected, &
                    tolerance, failures)
  call check_vector("parallel matches serial", parallel_norms, serial_norms, &
                    tolerance, failures)

  if (failures > 0) then
    print '(a, i0)', 'FAILURES: ', failures
    error stop 1
  end if

  print '(a)', 'parallel-matrix tests passed'

contains

  subroutine check_vector(label, actual, reference, tol, failure_count)
    character(len=*), intent(in) :: label
    real(dp), intent(in) :: actual(:)
    real(dp), intent(in) :: reference(:)
    real(dp), intent(in) :: tol
    integer, intent(inout) :: failure_count
    real(dp) :: error

    error = maxval(abs(actual - reference))
    if (error > tol) then
      failure_count = failure_count + 1
      print '(a, a, es12.4)', 'FAILED: ', label, error
    else
      print '(a, a)', 'PASSED: ', label
    end if
  end subroutine check_vector

end program test_parallel_matrix
