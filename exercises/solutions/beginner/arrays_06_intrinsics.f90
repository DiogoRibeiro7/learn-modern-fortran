! Exercise 6 — Array intrinsics

program intrinsics
  implicit none

  real :: x(8)

  x = [3.0, 1.0, 4.0, 1.0, 5.0, 9.0, 2.0, 6.0]

  print *, "sum    =", sum(x)
  print *, "product=", product(x)
  print *, "minval =", minval(x)
  print *, "maxval =", maxval(x)
  print *, "count>3=", count(x > 3.0)
  print *, "any<0  =", any(x < 0.0)
  print *, "all>0  =", all(x > 0.0)
end program intrinsics
