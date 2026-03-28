program test_ode_euler
  use iso_fortran_env, only: real64
  use ode_euler, only: integrate_euler, max_abs_error
  implicit none

  real(real64), parameter :: tol = 1.0e-12_real64
  real(real64), parameter :: dt = 0.1_real64
  real(real64) :: t_values(0:3)
  real(real64) :: y_values(0:3)
  real(real64) :: expected(0:3)
  real(real64) :: exact_decay(0:3)

  call integrate_euler(decay_rhs, 0.0_real64, 1.0_real64, dt, 3, t_values, y_values)

  expected = [1.0_real64, 0.9_real64, 0.81_real64, 0.729_real64]
  call assert_close(t_values(3), 0.3_real64, tol, "Time grid did not advance correctly.")
  call assert_array_close(y_values, expected, tol, "Euler updates do not match the expected sequence.")

  exact_decay = exp(-t_values)
  call assert_close(max_abs_error(y_values, exact_decay), maxval(abs(expected - exact_decay)), tol, &
    "max_abs_error returned an unexpected value.")

  print *, "All ode_euler tests passed."

contains

  function decay_rhs(t, y) result(dydt)
    real(real64), intent(in) :: t
    real(real64), intent(in) :: y
    real(real64) :: dydt

    dydt = -y
  end function decay_rhs

  subroutine assert_close(actual, expected, tolerance, message)
    real(real64), intent(in) :: actual
    real(real64), intent(in) :: expected
    real(real64), intent(in) :: tolerance
    character(len=*), intent(in) :: message

    if (abs(actual - expected) > tolerance) then
      print *, trim(message)
      print *, "actual   =", actual
      print *, "expected =", expected
      error stop 1
    end if
  end subroutine assert_close

  subroutine assert_array_close(actual, expected, tolerance, message)
    real(real64), intent(in) :: actual(:)
    real(real64), intent(in) :: expected(:)
    real(real64), intent(in) :: tolerance
    character(len=*), intent(in) :: message

    if (size(actual) /= size(expected)) then
      error stop "Array sizes must match in assert_array_close."
    end if

    if (any(abs(actual - expected) > tolerance)) then
      print *, trim(message)
      print *, "actual   =", actual
      print *, "expected =", expected
      error stop 1
    end if
  end subroutine assert_array_close

end program test_ode_euler
