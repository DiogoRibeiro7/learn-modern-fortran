program test_heat_diffusion
  use heat_diffusion, only : dp, make_grid, sine_initial_condition, &
                             sine_exact_solution, evolve_serial, evolve_openmp, &
                             l2_error
  implicit none

  integer :: failures

  failures = 0

  call test_initial_condition(failures)
  call test_serial_parallel_equivalence(failures)
  call test_grid_convergence(failures)

  if (failures > 0) then
    print '(a, i0)', 'FAILURES: ', failures
    error stop 1
  end if

  print '(a)', 'heat-diffusion tests passed'

contains

  subroutine test_initial_condition(failure_count)
    integer, intent(inout) :: failure_count
    real(dp) :: x(5)
    real(dp) :: u(5)
    real(dp), parameter :: tol = 100.0_dp * epsilon(1.0_dp)

    call make_grid(x)
    call sine_initial_condition(x, u)

    call check_close("left boundary", u(1), 0.0_dp, tol, failure_count)
    call check_close("midpoint", u(3), 1.0_dp, tol, failure_count)
    call check_close("right boundary", u(5), 0.0_dp, tol, failure_count)
  end subroutine test_initial_condition


  subroutine test_serial_parallel_equivalence(failure_count)
    integer, intent(inout) :: failure_count
    integer, parameter :: n = 65
    real(dp), parameter :: alpha = 0.1_dp
    real(dp), parameter :: final_time = 0.02_dp
    real(dp), parameter :: target_r = 0.4_dp
    real(dp) :: x(n)
    real(dp) :: serial_u(n)
    real(dp) :: parallel_u(n)
    real(dp) :: dx
    real(dp) :: dt
    real(dp) :: difference
    integer :: n_steps

    call make_grid(x)
    call sine_initial_condition(x, serial_u)
    parallel_u = serial_u

    dx = 1.0_dp / real(n - 1, dp)
    n_steps = ceiling(final_time / (target_r * dx * dx / alpha))
    dt = final_time / real(n_steps, dp)

    call evolve_serial(serial_u, alpha, dx, dt, n_steps)
    call evolve_openmp(parallel_u, alpha, dx, dt, n_steps)

    difference = maxval(abs(serial_u - parallel_u))
    if (difference > 100.0_dp * epsilon(1.0_dp)) then
      failure_count = failure_count + 1
      print '(a, es12.4)', 'FAILED: serial/OpenMP difference ', difference
    else
      print '(a)', 'PASSED: serial/OpenMP equivalence'
    end if
  end subroutine test_serial_parallel_equivalence


  subroutine test_grid_convergence(failure_count)
    integer, intent(inout) :: failure_count
    real(dp) :: coarse_error
    real(dp) :: medium_error
    real(dp) :: fine_error
    real(dp) :: ratio_1
    real(dp) :: ratio_2

    coarse_error = solve_error(21)
    medium_error = solve_error(41)
    fine_error = solve_error(81)

    ratio_1 = coarse_error / medium_error
    ratio_2 = medium_error / fine_error

    print '(a, 3(es12.4, 1x))', 'Convergence errors: ', &
      coarse_error, medium_error, fine_error
    print '(a, 2(f8.4, 1x))', 'Error ratios: ', ratio_1, ratio_2

    if (.not. (coarse_error > medium_error .and. medium_error > fine_error)) then
      failure_count = failure_count + 1
      print '(a)', 'FAILED: refinement did not reduce L2 error'
    else
      print '(a)', 'PASSED: refinement reduces L2 error'
    end if

    if (ratio_1 < 3.0_dp .or. ratio_2 < 3.0_dp) then
      failure_count = failure_count + 1
      print '(a)', 'FAILED: observed refinement ratio is too small for second-order behaviour'
    else
      print '(a)', 'PASSED: refinement ratios are consistent with O(dx^2) error'
    end if
  end subroutine test_grid_convergence


  real(dp) function solve_error(n) result(error)
    integer, intent(in) :: n
    real(dp), parameter :: alpha = 0.1_dp
    real(dp), parameter :: final_time = 0.05_dp
    real(dp), parameter :: target_r = 0.4_dp
    real(dp), allocatable :: x(:)
    real(dp), allocatable :: u(:)
    real(dp), allocatable :: exact(:)
    real(dp) :: dx
    real(dp) :: dt
    integer :: n_steps

    allocate(x(n), u(n), exact(n))

    call make_grid(x)
    call sine_initial_condition(x, u)

    dx = 1.0_dp / real(n - 1, dp)
    n_steps = ceiling(final_time / (target_r * dx * dx / alpha))
    dt = final_time / real(n_steps, dp)

    call evolve_serial(u, alpha, dx, dt, n_steps)
    call sine_exact_solution(x, alpha, final_time, exact)

    error = l2_error(u, exact, dx)
  end function solve_error


  subroutine check_close(label, actual, expected, tolerance, failure_count)
    character(len=*), intent(in) :: label
    real(dp), intent(in) :: actual
    real(dp), intent(in) :: expected
    real(dp), intent(in) :: tolerance
    integer, intent(inout) :: failure_count

    if (abs(actual - expected) > tolerance) then
      failure_count = failure_count + 1
      print '(a, a, 2(es12.4, 1x))', 'FAILED: ', label, actual, expected
    else
      print '(a, a)', 'PASSED: ', label
    end if
  end subroutine check_close

end program test_heat_diffusion
