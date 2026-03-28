program main
  use ode_euler, only: forward_euler_decay
  implicit none

  integer, parameter :: n_steps = 10
  real, parameter :: y0 = 1.0
  real, parameter :: dt = 0.1
  real :: y_values(0:n_steps)
  integer :: k

  call forward_euler_decay(y0, dt, n_steps, y_values)

  do k = 0, n_steps
    print *, "step =", k, " value =", y_values(k)
  end do
end program main
