! Exercise 7 — Linear search with early exit

program search_test
  implicit none

  integer :: idx

  idx = find_first([10, 20, 30, 40, 50], 30)
  print *, "find 30: index =", idx    ! expected: 3

  idx = find_first([10, 20, 30, 40, 50], 99)
  print *, "find 99: index =", idx    ! expected: 0

contains

  integer function find_first(x, target)
    integer, intent(in) :: x(:)
    integer, intent(in) :: target
    integer :: i

    find_first = 0
    do i = 1, size(x)
      if (x(i) == target) then
        find_first = i
        exit
      end if
    end do
  end function find_first

end program search_test
