! Solution: Exercise 6 — Test a derived type
! Tests type-bound procedures on particle_t.

program test_particle_type
  implicit none

  real, parameter :: tol = 1.0e-6
  type :: particle_t
    real :: x = 0.0, y = 0.0
    real :: vx = 0.0, vy = 0.0
    real :: mass = 1.0
  end type particle_t

  type(particle_t) :: p1, p2

  ! Particle with vx=3, vy=4, mass=2
  ! speed = sqrt(9 + 16) = 5.0
  ! KE = 0.5 * 2.0 * 25.0 = 25.0
  p1 = particle_t(vx=3.0, vy=4.0, mass=2.0)
  call assert_close(speed(p1), 5.0, tol, "speed of 3-4-5 particle")
  call assert_close(kinetic_energy(p1), 25.0, tol, "KE of 3-4-5 particle")

  ! Stationary particle — speed and KE should be zero
  p2 = particle_t(vx=0.0, vy=0.0, mass=1.0)
  call assert_close(speed(p2), 0.0, tol, "speed of stationary particle")
  call assert_close(kinetic_energy(p2), 0.0, tol, "KE of stationary particle")

  print *, "All particle tests passed."

contains

  real function speed(p) result(s)
    type(particle_t), intent(in) :: p
    s = sqrt(p%vx**2 + p%vy**2)
  end function speed

  real function kinetic_energy(p) result(ke)
    type(particle_t), intent(in) :: p
    ke = 0.5 * p%mass * (p%vx**2 + p%vy**2)
  end function kinetic_energy

  subroutine assert_close(actual, expected, tolerance, message)
    real, intent(in) :: actual, expected, tolerance
    character(len=*), intent(in) :: message

    if (abs(actual - expected) > tolerance) then
      print *, "FAIL:", trim(message)
      print *, "  actual   =", actual
      print *, "  expected =", expected
      error stop 1
    end if
  end subroutine assert_close

end program test_particle_type
