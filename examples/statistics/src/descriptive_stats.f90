module descriptive_stats
  implicit none
  private

  public :: mean, median, variance, stddev, describe

contains

  real function mean(x)
    real, intent(in) :: x(:)
    mean = sum(x) / real(size(x))
  end function mean

  real function median(x)
    real, intent(in) :: x(:)
    real :: sorted(size(x))
    integer :: n

    sorted = x
    call bubble_sort(sorted)
    n = size(sorted)

    if (mod(n, 2) == 1) then
      median = sorted((n + 1) / 2)
    else
      median = (sorted(n / 2) + sorted(n / 2 + 1)) / 2.0
    end if
  end function median

  real function variance(x)
    real, intent(in) :: x(:)
    real :: m
    m = mean(x)
    variance = sum((x - m) ** 2) / real(size(x))
  end function variance

  real function stddev(x)
    real, intent(in) :: x(:)
    stddev = sqrt(variance(x))
  end function stddev

  subroutine describe(x)
    real, intent(in) :: x(:)

    print '(A, I6)',    "  Count:  ", size(x)
    print '(A, F10.3)', "  Mean:   ", mean(x)
    print '(A, F10.3)', "  Median: ", median(x)
    print '(A, F10.3)', "  Stddev: ", stddev(x)
    print '(A, F10.3)', "  Min:    ", minval(x)
    print '(A, F10.3)', "  Max:    ", maxval(x)
  end subroutine describe

  ! Simple sort used only by median. Not meant to be fast.
  subroutine bubble_sort(arr)
    real, intent(inout) :: arr(:)
    real :: temp
    integer :: i, j, n
    logical :: swapped

    n = size(arr)
    do i = 1, n - 1
      swapped = .false.
      do j = 1, n - i
        if (arr(j) > arr(j + 1)) then
          temp = arr(j)
          arr(j) = arr(j + 1)
          arr(j + 1) = temp
          swapped = .true.
        end if
      end do
      if (.not. swapped) exit
    end do
  end subroutine bubble_sort

end module descriptive_stats
