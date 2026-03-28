! Exercise 1 — Hello with your name
! Stores a name in a character variable and prints a greeting.

program greet
  implicit none

  character(len=30) :: name

  name = "Alice"

  print *, "Hello, " // trim(name) // "!"
end program greet
