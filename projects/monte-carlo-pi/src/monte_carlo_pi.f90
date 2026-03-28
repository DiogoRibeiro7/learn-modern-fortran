module monte_carlo_pi
  use iso_fortran_env, only: real64
  implicit none
  private

  public :: pi_true
  public :: estimate_pi_from_points
  public :: run_monte_carlo

  real(real64), parameter :: pi_true = acos(-1.0_real64)

contains

  function estimate_pi_from_points(x, y) result(pi_estimate)
    real(real64), intent(in) :: x(:)
    real(real64), intent(in) :: y(:)
    real(real64) :: pi_estimate

    integer :: inside_circle

    if (size(x) /= size(y)) then
      error stop "x and y must have the same length."
    end if

    if (size(x) == 0) then
      error stop "At least one sample is required."
    end if

    inside_circle = count(x * x + y * y <= 1.0_real64)
    pi_estimate = 4.0_real64 * real(inside_circle, real64) / real(size(x), real64)
  end function estimate_pi_from_points

  subroutine run_monte_carlo(n_samples, report_interval, sample_counts, estimates)
    integer, intent(in) :: n_samples
    integer, intent(in) :: report_interval
    integer, allocatable, intent(out) :: sample_counts(:)
    real(real64), allocatable, intent(out) :: estimates(:)

    integer :: i
    integer :: inside_circle
    integer :: report_index
    integer :: n_reports
    real(real64) :: x
    real(real64) :: y

    if (n_samples <= 0) then
      error stop "n_samples must be positive."
    end if

    if (report_interval <= 0) then
      error stop "report_interval must be positive."
    end if

    n_reports = (n_samples - 1) / report_interval + 1
    allocate(sample_counts(n_reports), estimates(n_reports))

    call random_seed()
    inside_circle = 0
    report_index = 0

    do i = 1, n_samples
      call random_number(x)
      call random_number(y)

      if (x * x + y * y <= 1.0_real64) then
        inside_circle = inside_circle + 1
      end if

      if (mod(i, report_interval) == 0 .or. i == n_samples) then
        report_index = report_index + 1
        sample_counts(report_index) = i
        estimates(report_index) = 4.0_real64 * real(inside_circle, real64) / real(i, real64)
      end if
    end do
  end subroutine run_monte_carlo

end module monte_carlo_pi
