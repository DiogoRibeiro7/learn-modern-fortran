! Exercise 8 — Clamp with where

program clamp
  implicit none

  real :: x(7)

  x = [-3.0, 1.0, -7.0, 4.0, 0.0, -2.0, 8.0]

  print *, "Before:", x

  where (x < 0.0)
    x = 0.0
  end where

  print *, "After: ", x
end program clamp
