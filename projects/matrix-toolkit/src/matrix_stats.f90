module matrix_stats
  implicit none
  private

  public :: row_sums
  public :: column_sums

contains

  function row_sums(x) result(values)
    real, intent(in) :: x(:, :)
    real :: values(size(x, 1))

    integer :: i

    do i = 1, size(x, 1)
      values(i) = sum(x(i, :))
    end do
  end function row_sums

  function column_sums(x) result(values)
    real, intent(in) :: x(:, :)
    real :: values(size(x, 2))

    integer :: j

    do j = 1, size(x, 2)
      values(j) = sum(x(:, j))
    end do
  end function column_sums

end module matrix_stats
