module stats_utils
  implicit none
  private

  public :: mean
  public :: stddev
  public :: variance

contains

  real function mean(x)
    real, intent(in) :: x(:)

    if (size(x) == 0) error stop "mean: empty array"
    mean = sum(x) / real(size(x))
  end function mean

  real function variance(x)
    real, intent(in) :: x(:)
    real :: m

    if (size(x) == 0) error stop "variance: empty array"
    m = mean(x)
    variance = sum((x - m) ** 2) / real(size(x))
  end function variance

  real function stddev(x)
    real, intent(in) :: x(:)

    stddev = sqrt(variance(x))
  end function stddev

end module stats_utils
