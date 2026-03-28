program main
  use stats_utils, only: mean, stddev
  use particle_mod, only: particle_t
  implicit none

  real :: velocities(5)
  type(particle_t) :: ball

  ! --- Statistics module ---
  velocities = [3.2, 4.1, 2.8, 5.5, 3.9]

  print *, "=== Statistics module ==="
  print '(A, F7.3)', " Mean speed:   ", mean(velocities)
  print '(A, F7.3)', " Std deviation:", stddev(velocities)
  print *

  ! --- Particle derived type ---
  ball = particle_t(x=0.0, y=10.0, vx=3.0, vy=-4.0, mass=2.0)

  print *, "=== Particle type ==="
  call ball%describe()
end program main
