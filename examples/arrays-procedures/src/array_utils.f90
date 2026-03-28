module array_utils
  implicit none
  private

  public :: vec_mean
  public :: vec_stddev
  public :: euclidean_norm
  public :: clamp_negatives
  public :: find_extremes

contains

  real function vec_mean(x) result(value)
    real, intent(in) :: x(:)

    if (size(x) == 0) error stop "vec_mean: empty array"
    value = sum(x) / real(size(x))
  end function vec_mean

  real function vec_stddev(x) result(value)
    real, intent(in) :: x(:)
    real :: m

    if (size(x) == 0) error stop "vec_stddev: empty array"
    m = vec_mean(x)
    value = sqrt(sum((x - m) ** 2) / real(size(x)))
  end function vec_stddev

  real function euclidean_norm(x) result(value)
    real, intent(in) :: x(:)

    value = sqrt(sum(x * x))
  end function euclidean_norm

  subroutine clamp_negatives(x)
    real, intent(inout) :: x(:)

    where (x < 0.0)
      x = 0.0
    end where
  end subroutine clamp_negatives

  subroutine find_extremes(x, lo, hi)
    real, intent(in) :: x(:)
    real, intent(out) :: lo, hi

    lo = minval(x)
    hi = maxval(x)
  end subroutine find_extremes

end module array_utils
