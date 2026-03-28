program main
  use iso_fortran_env, only: real64
  implicit none

  ! --- Intrinsic types ---
  integer :: count
  integer :: numerator
  integer :: denominator
  real :: temperature
  logical :: is_freezing
  character(len=20) :: city

  ! --- Constants ---
  real, parameter :: freezing_point = 0.0

  ! --- Kind selection ---
  real(real64) :: precise

  count = 42
  numerator = 7
  denominator = 2
  temperature = -3.5
  city = "Reykjavik"
  is_freezing = temperature < freezing_point
  precise = 1.0_real64 / 3.0_real64

  print *, "=== Types and variables ==="
  print *, "count:      ", count
  print *, "temperature:", temperature
  print *, "city:       ", trim(city)
  print *, "is_freezing:", is_freezing
  print *

  ! --- Integer division pitfall ---
  print *, "=== Integer division ==="
  print *, "7 / 2 (integer):  ", numerator / denominator
  print *, "7.0 / 2.0 (real): ", 7.0 / 2.0
  print *

  ! --- Kind comparison ---
  print *, "=== Precision ==="
  print *, "1/3 default real:", real(1.0 / 3.0)
  print *, "1/3 real64:      ", precise
  print *

  ! --- Relational and logical operators ---
  print *, "=== Operators ==="
  print *, "count == 42: ", count == 42
  print *, "count /= 0:  ", count /= 0
  print *, "temp < 0:    ", temperature < 0.0
  print *

  ! --- Formatted output ---
  print *, "=== Formatted output ==="
  print '(A, I6)',    "  count:       ", count
  print '(A, F8.2)',  "  temperature: ", temperature
  print '(A, A)',     "  city:        ", trim(city)
  print '(A, L2)',    "  is_freezing: ", is_freezing
end program main
