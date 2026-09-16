module heat_diffusion
  use, intrinsic :: iso_fortran_env, only : real64
  implicit none
  private

  integer, parameter, public :: dp = real64
  real(dp), parameter, public :: pi = acos(-1.0_dp)

  public :: make_grid
  public :: sine_initial_condition
  public :: sine_exact_solution
  public :: evolve_serial
  public :: evolve_openmp
  public :: l2_error

contains

  subroutine make_grid(x)
    real(dp), intent(out) :: x(:)
    integer :: i
    integer :: n

    n = size(x)
    if (n < 3) error stop "grid requires at least three points"

    do i = 1, n
      x(i) = real(i - 1, dp) / real(n - 1, dp)
    end do
  end subroutine make_grid


  subroutine sine_initial_condition(x, u)
    real(dp), intent(in) :: x(:)
    real(dp), intent(out) :: u(:)

    if (size(u) /= size(x)) error stop "state/grid size mismatch"

    u = sin(pi * x)
    u(1) = 0.0_dp
    u(size(u)) = 0.0_dp
  end subroutine sine_initial_condition


  subroutine sine_exact_solution(x, alpha, time, u)
    real(dp), intent(in) :: x(:)
    real(dp), intent(in) :: alpha
    real(dp), intent(in) :: time
    real(dp), intent(out) :: u(:)
    real(dp) :: amplitude

    if (alpha <= 0.0_dp) error stop "alpha must be positive"
    if (time < 0.0_dp) error stop "time must be non-negative"
    if (size(u) /= size(x)) error stop "state/grid size mismatch"

    amplitude = exp(-alpha * pi * pi * time)
    u = amplitude * sin(pi * x)
    u(1) = 0.0_dp
    u(size(u)) = 0.0_dp
  end subroutine sine_exact_solution


  subroutine evolve_serial(u, alpha, dx, dt, n_steps)
    real(dp), intent(inout) :: u(:)
    real(dp), intent(in) :: alpha
    real(dp), intent(in) :: dx
    real(dp), intent(in) :: dt
    integer, intent(in) :: n_steps

    real(dp), allocatable :: next(:)
    real(dp) :: r
    integer :: i
    integer :: step
    integer :: n

    call validate_evolution(u, alpha, dx, dt, n_steps, r)

    n = size(u)
    allocate(next(n))
    next = u

    do step = 1, n_steps
      next(1) = 0.0_dp
      next(n) = 0.0_dp
      do i = 2, n - 1
        next(i) = u(i) + r * (u(i - 1) - 2.0_dp * u(i) + u(i + 1))
      end do
      u = next
    end do
  end subroutine evolve_serial


  subroutine evolve_openmp(u, alpha, dx, dt, n_steps)
    real(dp), intent(inout) :: u(:)
    real(dp), intent(in) :: alpha
    real(dp), intent(in) :: dx
    real(dp), intent(in) :: dt
    integer, intent(in) :: n_steps

    real(dp), allocatable :: next(:)
    real(dp) :: r
    integer :: i
    integer :: step
    integer :: n

    call validate_evolution(u, alpha, dx, dt, n_steps, r)

    n = size(u)
    allocate(next(n))
    next = u

    do step = 1, n_steps
      next(1) = 0.0_dp
      next(n) = 0.0_dp

      !$omp parallel do default(none) shared(u, next, n, r) private(i)
      do i = 2, n - 1
        next(i) = u(i) + r * (u(i - 1) - 2.0_dp * u(i) + u(i + 1))
      end do
      !$omp end parallel do

      u = next
    end do
  end subroutine evolve_openmp


  real(dp) function l2_error(numerical, reference, dx) result(error)
    real(dp), intent(in) :: numerical(:)
    real(dp), intent(in) :: reference(:)
    real(dp), intent(in) :: dx

    if (size(numerical) /= size(reference)) then
      error stop "error vectors must have matching sizes"
    end if
    if (dx <= 0.0_dp) error stop "dx must be positive"

    error = sqrt(dx * sum((numerical - reference) ** 2))
  end function l2_error


  subroutine validate_evolution(u, alpha, dx, dt, n_steps, r)
    real(dp), intent(in) :: u(:)
    real(dp), intent(in) :: alpha
    real(dp), intent(in) :: dx
    real(dp), intent(in) :: dt
    integer, intent(in) :: n_steps
    real(dp), intent(out) :: r

    if (size(u) < 3) error stop "state requires at least three points"
    if (alpha <= 0.0_dp) error stop "alpha must be positive"
    if (dx <= 0.0_dp) error stop "dx must be positive"
    if (dt <= 0.0_dp) error stop "dt must be positive"
    if (n_steps < 0) error stop "n_steps must be non-negative"

    r = alpha * dt / (dx * dx)
    if (r > 0.5_dp + 100.0_dp * epsilon(1.0_dp)) then
      error stop "unstable FTCS configuration: alpha*dt/dx^2 exceeds 0.5"
    end if
  end subroutine validate_evolution

end module heat_diffusion
