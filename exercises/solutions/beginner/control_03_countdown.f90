! Exercise 3 — Countdown

program countdown
  implicit none

  integer :: i

  do i = 10, 1, -1
    print *, i
  end do
  print *, "Liftoff!"
end program countdown
