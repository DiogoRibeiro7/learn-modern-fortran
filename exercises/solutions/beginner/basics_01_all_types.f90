! Exercise 1 — All four types
! Declares one variable of each common type, assigns a value, and prints it.

program all_types
  implicit none

  integer :: year
  real :: temperature
  logical :: is_sunny
  character(len=20) :: city

  year = 2026
  temperature = 21.5
  is_sunny = .true.
  city = "Lisbon"

  print *, "Year:       ", year
  print *, "Temperature:", temperature
  print *, "Sunny:      ", is_sunny
  print *, "City:       ", trim(city)
end program all_types
