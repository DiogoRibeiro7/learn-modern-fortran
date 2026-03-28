! Exercise 4 — Smallest power of 2 >= n

program power_of_2
  implicit none

  call find_power(50)    ! expected: 64
  call find_power(128)   ! expected: 128
  call find_power(1)     ! expected: 1

contains

  subroutine find_power(n)
    integer, intent(in) :: n
    integer :: p

    p = 1
    do while (p < n)
      p = p * 2
    end do
    print *, "n =", n, " -> power of 2:", p
  end subroutine find_power

end program power_of_2
