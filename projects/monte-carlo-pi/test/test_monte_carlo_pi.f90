program test_monte_carlo_pi
  use iso_fortran_env, only: real64
  use monte_carlo_pi, only: estimate_pi_from_points
  implicit none

  real(real64), parameter :: tol = 1.0e-12_real64
  real(real64) :: x1(4)
  real(real64) :: y1(4)
  real(real64) :: x2(5)
  real(real64) :: y2(5)

  x1 = [0.0_real64, 0.5_real64, 0.8_real64, 0.95_real64]
  y1 = [0.0_real64, 0.5_real64, 0.3_real64, 0.6_real64]
  call assert_close(estimate_pi_from_points(x1, y1), 3.0_real64, tol, &
    "Expected 3 of 4 points inside the quarter circle.")

  x2 = [0.1_real64, 0.4_real64, 0.7_real64, 0.95_real64, 0.99_real64]
  y2 = [0.1_real64, 0.8_real64, 0.2_real64, 0.1_real64, 0.5_real64]
  call assert_close(estimate_pi_from_points(x2, y2), 3.2_real64, tol, &
    "Expected 4 of 5 points inside the quarter circle.")

  print *, "All monte_carlo_pi tests passed."

contains

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

end program test_monte_carlo_pi
