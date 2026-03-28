! Exercise 5 — Element-wise operations

program elementwise
  implicit none

  real :: a(4), b(4)

  a = [1.0, 2.0, 3.0, 4.0]
  b = [10.0, 20.0, 30.0, 40.0]

  print *, "a + b  =", a + b
  print *, "a * b  =", a * b
  print *, "2a + 1 =", 2.0 * a + 1.0
  print *, "sqrt(a)=", sqrt(a)
end program elementwise
