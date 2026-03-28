program test_modules_types
  use stats_utils, only: mean, variance, stddev
  use particle_mod, only: particle_t
  implicit none

  real, parameter :: tol = 1.0e-6
  real :: values(4)
  type(particle_t) :: particle

  values = [1.0, 2.0, 3.0, 4.0]
  call assert_close(mean(values), 2.5, tol, "mean returned the wrong value.")
  call assert_close(variance(values), 1.25, tol, "variance returned the wrong value.")
  call assert_close(stddev(values), sqrt(1.25), tol, "stddev returned the wrong value.")

  particle = particle_t(vx=3.0, vy=4.0, mass=2.0)
  call assert_close(particle%speed(), 5.0, tol, "particle speed returned the wrong value.")
  call assert_close(particle%kinetic_energy(), 25.0, tol, &
    "particle kinetic_energy returned the wrong value.")

  print *, "All modules_types tests passed."

contains

  subroutine assert_close(actual, expected, tolerance, message)
    real, intent(in) :: actual
    real, intent(in) :: expected
    real, intent(in) :: tolerance
    character(len=*), intent(in) :: message

    if (abs(actual - expected) > tolerance) then
      print *, trim(message)
      print *, "actual   =", actual
      print *, "expected =", expected
      error stop 1
    end if
  end subroutine assert_close

end program test_modules_types
