program main
  use iso_fortran_env, only: real64
  use ode_euler, only: integrate_euler, max_abs_error
  implicit none

  integer :: n_steps
  integer :: k
  real(real64) :: dt
  real(real64), allocatable :: t_values(:)
  real(real64), allocatable :: y_values(:)
  real(real64), allocatable :: exact_values(:)

  dt = 0.1_real64
  n_steps = 10

  call read_positive_real_argument(1, dt)
  call read_positive_integer_argument(2, n_steps)

  allocate(t_values(0:n_steps), y_values(0:n_steps), exact_values(0:n_steps))

  call integrate_euler(decay_rhs, 0.0_real64, 1.0_real64, dt, n_steps, t_values, y_values)
  exact_values = exact_decay(t_values)

  write (*, '(a,f8.4)') "dt             : ", dt
  write (*, '(a,i0)') "n_steps        : ", n_steps
  write (*, '(a,es12.4)') "max abs error  : ", max_abs_error(y_values, exact_values)
  write (*, '(a)') ""
  write (*, '(a)') "t        y_euler       exact        abs error"

  do k = 0, n_steps
    write (*, '(f6.2,2x,f12.8,2x,f12.8,2x,es12.4)') t_values(k), y_values(k), &
      exact_values(k), abs(y_values(k) - exact_values(k))
  end do

contains

  function decay_rhs(t, y) result(dydt)
    real(real64), intent(in) :: t
    real(real64), intent(in) :: y
    real(real64) :: dydt

    dydt = -y
  end function decay_rhs

  function exact_decay(t) result(values)
    real(real64), intent(in) :: t(:)
    real(real64) :: values(size(t))

    values = exp(-t)
  end function exact_decay

  subroutine read_positive_real_argument(position, value)
    integer, intent(in) :: position
    real(real64), intent(inout) :: value

    character(len=32) :: argument
    integer :: status
    real(real64) :: parsed_value

    if (command_argument_count() < position) return

    call get_command_argument(position, argument)
    read (argument, *, iostat=status) parsed_value

    if (status /= 0 .or. parsed_value <= 0.0_real64) then
      error stop "dt must be a positive real number."
    end if

    value = parsed_value
  end subroutine read_positive_real_argument

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
      error stop "n_steps must be a positive integer."
    end if

    value = parsed_value
  end subroutine read_positive_integer_argument

end program main
