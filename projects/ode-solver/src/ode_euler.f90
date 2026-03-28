module ode_euler
  implicit none
  private

  public :: forward_euler_decay

contains

  subroutine forward_euler_decay(y0, dt, n_steps, y_values)
    real, intent(in) :: y0
    real, intent(in) :: dt
    integer, intent(in) :: n_steps
    real, intent(out) :: y_values(0:n_steps)

    integer :: k

    y_values(0) = y0

    do k = 1, n_steps
      y_values(k) = y_values(k - 1) - dt * y_values(k - 1)
    end do
  end subroutine forward_euler_decay

end module ode_euler
