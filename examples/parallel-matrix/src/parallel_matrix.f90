module parallel_matrix
  use, intrinsic :: iso_fortran_env, only : real64
  use omp_lib, only : omp_get_max_threads
  implicit none
  private

  integer, parameter, public :: dp = real64

  public :: column_l2_serial
  public :: column_l2_openmp
  public :: max_openmp_threads

contains

  subroutine column_l2_serial(matrix, norms)
    real(dp), intent(in) :: matrix(:, :)
    real(dp), intent(out) :: norms(:)

    integer :: i
    integer :: j
    real(dp) :: accumulator

    call validate_shapes(matrix, norms)

    do j = 1, size(matrix, dim=2)
      accumulator = 0.0_dp
      do i = 1, size(matrix, dim=1)
        accumulator = accumulator + matrix(i, j) * matrix(i, j)
      end do
      norms(j) = sqrt(accumulator)
    end do
  end subroutine column_l2_serial


  subroutine column_l2_openmp(matrix, norms)
    real(dp), intent(in) :: matrix(:, :)
    real(dp), intent(out) :: norms(:)

    integer :: i
    integer :: j
    integer :: n_rows
    integer :: n_columns
    real(dp) :: accumulator

    call validate_shapes(matrix, norms)

    n_rows = size(matrix, dim=1)
    n_columns = size(matrix, dim=2)

    !$omp parallel do default(none) &
    !$omp shared(matrix, norms, n_rows, n_columns) private(i, accumulator)
    do j = 1, n_columns
      accumulator = 0.0_dp
      do i = 1, n_rows
        accumulator = accumulator + matrix(i, j) * matrix(i, j)
      end do
      norms(j) = sqrt(accumulator)
    end do
    !$omp end parallel do
  end subroutine column_l2_openmp


  integer function max_openmp_threads() result(thread_count)
    thread_count = omp_get_max_threads()
  end function max_openmp_threads


  subroutine validate_shapes(matrix, norms)
    real(dp), intent(in) :: matrix(:, :)
    real(dp), intent(out) :: norms(:)

    if (size(norms) /= size(matrix, dim=2)) then
      error stop "norm output must have one element per matrix column"
    end if
  end subroutine validate_shapes

end module parallel_matrix
