program main
  use iso_fortran_env, only: real64
  use ode_euler, only: integrate_euler
  implicit none

  real(real64) :: t_values(0:10)
  real(real64) :: y_values(0:10)
  integer :: k

  call integrate_euler(decay_rhs, 0.0_real64, 1.0_real64, 0.1_real64, 10, t_values, y_values)

  do k = 0, 10
    print *, t_values(k), y_values(k)
  end do

  ! TODO:
  ! 1. Print the exact solution exp(-t) beside the numerical one.
  ! 2. Compute the absolute error at each step.
  ! 3. Try a smaller dt and compare the final error.

contains

  function decay_rhs(t, y) result(dydt)
    real(real64), intent(in) :: t
    real(real64), intent(in) :: y
    real(real64) :: dydt

    dydt = -y
  end function decay_rhs

end program main
