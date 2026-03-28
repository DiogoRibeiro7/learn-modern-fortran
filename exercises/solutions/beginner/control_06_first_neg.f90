! Exercise 6 — Find first negative

program first_negative
  implicit none

  real :: x(5)
  integer :: i
  logical :: found

  x = [3.0, 1.0, -2.0, 5.0, -1.0]
  found = .false.

  do i = 1, size(x)
    if (x(i) < 0.0) then
      print *, "First negative at index", i, "value =", x(i)
      found = .true.
      exit
    end if
  end do

  if (.not. found) print *, "No negatives found."
end program first_negative
