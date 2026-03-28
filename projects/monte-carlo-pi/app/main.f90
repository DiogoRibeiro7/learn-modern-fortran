program main
  use iso_fortran_env, only: real64
  use monte_carlo_pi, only: run_monte_carlo, pi_true
  implicit none

  integer :: n_samples
  integer :: report_interval
  integer :: i
  integer, allocatable :: sample_counts(:)
  real(real64), allocatable :: estimates(:)
  real(real64) :: final_estimate

  n_samples = 100000
  report_interval = 20000

  call read_positive_integer_argument(1, n_samples)
  call read_positive_integer_argument(2, report_interval)

  report_interval = min(report_interval, n_samples)

  call run_monte_carlo(n_samples, report_interval, sample_counts, estimates)
  final_estimate = estimates(size(estimates))

  write (*, '(a,i0)') "Samples          : ", n_samples
  write (*, '(a,i0)') "Report interval  : ", report_interval
  write (*, '(a,f12.8)') "Final estimate   : ", final_estimate
  write (*, '(a,es12.4)') "Absolute error   : ", abs(final_estimate - pi_true)
  write (*, '(a)') ""
  write (*, '(a)') "Convergence history"
  write (*, '(a)') "count        estimate        abs error"

  do i = 1, size(sample_counts)
    write (*, '(i8,2x,f12.8,2x,es12.4)') sample_counts(i), estimates(i), &
      abs(estimates(i) - pi_true)
  end do

contains

  subroutine read_positive_integer_argument(position, value)
    integer, intent(in) :: position
    integer, intent(inout) :: value

    character(len=32) :: argument
    integer :: status
    integer :: parsed_value

    if (command_argument_count() < position) return

    call get_command_argument(position, argument)
    read (argument, *, iostat=status) parsed_value

    if (status /= 0 .or. parsed_value <= 0) then
      error stop "Command-line arguments must be positive integers."
    end if

    value = parsed_value
  end subroutine read_positive_integer_argument

end program main
