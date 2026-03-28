! Exercise 4 — Spot the bug (fixed version)
!
! The original program was missing implicit none and had a typo:
!   "distnace" instead of "distance"
!
! Without implicit none the program compiles and prints 0.0
! because "distnace" is silently created as a new real variable.
!
! With implicit none the compiler reports:
!   Error: Symbol 'distnace' has no IMPLICIT type
!
! This version includes implicit none and the corrected variable name.

program spot_the_bug
  implicit none

  real :: distance
  distance = 100.0

  print *, "Distance =", distance
end program spot_the_bug
