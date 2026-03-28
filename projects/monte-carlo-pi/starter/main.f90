program main
  use iso_fortran_env, only: real64
  use monte_carlo_pi, only: estimate_pi_from_points
  implicit none

  integer, parameter :: n_samples = 20
  real(real64) :: x(n_samples)
  real(real64) :: y(n_samples)

  call random_seed()
  call random_number(x)
  call random_number(y)

  print *, "Starter estimate =", estimate_pi_from_points(x, y)

  ! TODO:
  ! 1. Replace n_samples with a command-line argument.
  ! 2. Print the absolute error against acos(-1.0_real64).
  ! 3. Repeat the experiment for larger sample sizes and compare the estimates.
end program main
