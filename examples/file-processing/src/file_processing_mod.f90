module file_processing_mod
  implicit none
  private
  public :: read_measurements, compute_statistics

contains

  subroutine read_measurements(filepath, values, n, ios)
    character(len=*), intent(in) :: filepath
    real, intent(out) :: values(:)
    integer, intent(out) :: n
    integer, intent(out) :: ios

    integer :: unit
    n = 0

    open(newunit=unit, file=filepath, status='old', action='read', iostat=ios)
    if (ios /= 0) return

    do
      read(unit, *, iostat=ios) values(n + 1)
      if (ios /= 0) exit
      n = n + 1
      if (n >= size(values)) exit
    end do

    if (ios == 62) then
      ios = 0  ! end-of-file reached normally
    end if

    close(unit)
  end subroutine read_measurements

  subroutine compute_statistics(values, n, mean_val, min_val, max_val, std_val)
    real, intent(in) :: values(:)
    integer, intent(in) :: n
    real, intent(out) :: mean_val, min_val, max_val, std_val

    if (n <= 0) then
      mean_val = 0.0
      min_val = 0.0
      max_val = 0.0
      std_val = 0.0
      return
    end if

    mean_val = sum(values(1:n)) / real(n)
    min_val = minval(values(1:n))
    max_val = maxval(values(1:n))
    std_val = sqrt(sum((values(1:n) - mean_val)**2) / real(n))
  end subroutine compute_statistics

end module file_processing_mod
