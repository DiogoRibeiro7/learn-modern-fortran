module ode_euler
  use iso_fortran_env, only: real64
  implicit none
  private

  public :: rhs_function
  public :: integrate_euler
  public :: max_abs_error

  abstract interface
    function rhs_function(t, y) result(dydt)
      import :: real64
      real(real64), intent(in) :: t
      real(real64), intent(in) :: y
      real(real64) :: dydt
    end function rhs_function
  end interface

contains

  subroutine integrate_euler(rhs, t0, y0, dt, n_steps, t_values, y_values)
    procedure(rhs_function) :: rhs
    real(real64), intent(in) :: t0
    real(real64), intent(in) :: y0
    real(real64), intent(in) :: dt
    integer, intent(in) :: n_steps
    real(real64), intent(out) :: t_values(0:n_steps)
    real(real64), intent(out) :: y_values(0:n_steps)

    integer :: k

    if (dt <= 0.0_real64) then
      error stop "dt must be positive."
    end if

    if (n_steps < 0) then
      error stop "n_steps must be non-negative."
    end if

    t_values(0) = t0
    y_values(0) = y0

    do k = 1, n_steps
      t_values(k) = t_values(k - 1) + dt
      y_values(k) = y_values(k - 1) + dt * rhs(t_values(k - 1), y_values(k - 1))
    end do
  end subroutine integrate_euler

  function max_abs_error(approximate, exact) result(error_value)
    real(real64), intent(in) :: approximate(:)
    real(real64), intent(in) :: exact(:)
    real(real64) :: error_value

    if (size(approximate) /= size(exact)) then
      error stop "Arrays must have the same size."
    end if

    error_value = maxval(abs(approximate - exact))
  end function max_abs_error

end module ode_euler
