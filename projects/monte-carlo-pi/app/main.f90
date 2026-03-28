program main
  implicit none

  integer, parameter :: n_samples = 100000
  integer :: i
  integer :: inside_circle
  real :: x
  real :: y
  real :: pi_estimate

  call random_seed()
  inside_circle = 0

  do i = 1, n_samples
    call random_number(x)
    call random_number(y)

    if (x * x + y * y <= 1.0) then
      inside_circle = inside_circle + 1
    end if
  end do

  pi_estimate = 4.0 * real(inside_circle) / real(n_samples)

  print *, "Samples      =", n_samples
  print *, "Pi estimate  =", pi_estimate
end program main
