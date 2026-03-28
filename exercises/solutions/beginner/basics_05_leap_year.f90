! Exercise 5 — Leap year checker
! Determines whether a year is a leap year using logical operators.
!
! Rules:
!   Divisible by 4          -> leap year
!   BUT divisible by 100    -> not a leap year
!   BUT divisible by 400    -> leap year again

program leap_year
  implicit none

  integer :: year
  logical :: is_leap

  ! Test: 2024 (leap)
  year = 2024
  is_leap = (mod(year, 4) == 0 .and. mod(year, 100) /= 0) &
            .or. (mod(year, 400) == 0)
  print *, "Year:", year, " Leap:", is_leap

  ! Test: 1900 (not leap — divisible by 100 but not 400)
  year = 1900
  is_leap = (mod(year, 4) == 0 .and. mod(year, 100) /= 0) &
            .or. (mod(year, 400) == 0)
  print *, "Year:", year, " Leap:", is_leap

  ! Test: 2000 (leap — divisible by 400)
  year = 2000
  is_leap = (mod(year, 4) == 0 .and. mod(year, 100) /= 0) &
            .or. (mod(year, 400) == 0)
  print *, "Year:", year, " Leap:", is_leap

  ! Test: 2023 (not leap)
  year = 2023
  is_leap = (mod(year, 4) == 0 .and. mod(year, 100) /= 0) &
            .or. (mod(year, 400) == 0)
  print *, "Year:", year, " Leap:", is_leap
end program leap_year
