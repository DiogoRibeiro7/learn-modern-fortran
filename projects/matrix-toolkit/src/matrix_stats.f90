module matrix_stats
  use iso_fortran_env, only: real64
  implicit none
  private

  public :: row_sums
  public :: column_sums
  public :: column_means
  public :: matrix_vector_product
  public :: frobenius_norm

contains

  function row_sums(x) result(values)
    real(real64), intent(in) :: x(:, :)
    real(real64) :: values(size(x, 1))

    integer :: i

    do i = 1, size(x, 1)
      values(i) = sum(x(i, :))
    end do
  end function row_sums

  function column_sums(x) result(values)
    real(real64), intent(in) :: x(:, :)
    real(real64) :: values(size(x, 2))

    integer :: j

    do j = 1, size(x, 2)
      values(j) = sum(x(:, j))
    end do
  end function column_sums

  function column_means(x) result(values)
    real(real64), intent(in) :: x(:, :)
    real(real64) :: values(size(x, 2))

    if (size(x, 1) == 0) then
      error stop "column_means requires at least one row."
    end if

    values = column_sums(x) / real(size(x, 1), real64)
  end function column_means

  function matrix_vector_product(x, vector) result(values)
    real(real64), intent(in) :: x(:, :)
    real(real64), intent(in) :: vector(:)
    real(real64) :: values(size(x, 1))

    integer :: i

    if (size(x, 2) /= size(vector)) then
      error stop "The vector length must match the number of matrix columns."
    end if

    do i = 1, size(x, 1)
      values(i) = sum(x(i, :) * vector)
    end do
  end function matrix_vector_product

  function frobenius_norm(x) result(value)
    real(real64), intent(in) :: x(:, :)
    real(real64) :: value

    value = sqrt(sum(x * x))
  end function frobenius_norm

end module matrix_stats
