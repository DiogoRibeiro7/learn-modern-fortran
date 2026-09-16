program heat_diffusion_demo
  use heat_diffusion, only : dp, make_grid, sine_initial_condition, &
                             sine_exact_solution, evolve_serial, evolve_openmp, &
                             l2_error
  implicit none

  integer, parameter :: n_points = 201
  real(dp), parameter :: alpha = 0.1_dp
  real(dp), parameter :: final_time = 0.1_dp
  real(dp), parameter :: target_r = 0.4_dp

  real(dp), allocatable :: x(:)
  real(dp), allocatable :: serial_u(:)
  real(dp), allocatable :: parallel_u(:)
  real(dp), allocatable :: exact_u(:)
  real(dp) :: dx
  real(dp) :: dt
  real(dp) :: r
  real(dp) :: serial_error
  real(dp) :: parallel_error
  real(dp) :: serial_parallel_difference
  integer :: n_steps

  allocate(x(n_points), serial_u(n_points), parallel_u(n_points), exact_u(n_points))

  call make_grid(x)
  call sine_initial_condition(x, serial_u)
  parallel_u = serial_u

  dx = 1.0_dp / real(n_points - 1, dp)
  n_steps = ceiling(final_time / (target_r * dx * dx / alpha))
  dt = final_time / real(n_steps, dp)
  r = alpha * dt / (dx * dx)

  call evolve_serial(serial_u, alpha, dx, dt, n_steps)
  call evolve_openmp(parallel_u, alpha, dx, dt, n_steps)
  call sine_exact_solution(x, alpha, final_time, exact_u)

  serial_error = l2_error(serial_u, exact_u, dx)
  parallel_error = l2_error(parallel_u, exact_u, dx)
  serial_parallel_difference = maxval(abs(serial_u - parallel_u))

  print '(a)', '1D heat equation: explicit FTCS verification run'
  print '(a, i0)', 'Grid points:                 ', n_points
  print '(a, i0)', 'Time steps:                  ', n_steps
  print '(a, es12.4)', 'dx:                          ', dx
  print '(a, es12.4)', 'dt:                          ', dt
  print '(a, f8.5)', 'alpha*dt/dx^2:               ', r
  print '(a, es12.4)', 'Serial L2 error:             ', serial_error
  print '(a, es12.4)', 'OpenMP L2 error:             ', parallel_error
  print '(a, es12.4)', 'Serial/OpenMP max difference:', serial_parallel_difference

  if (serial_parallel_difference > 100.0_dp * epsilon(1.0_dp)) then
    error stop "serial and OpenMP solutions disagree"
  end if
end program heat_diffusion_demo
