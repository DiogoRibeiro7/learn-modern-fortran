! Exercise 6 — Full name builder
! Concatenates first and last name with trim() and //.

program full_name
  implicit none

  character(len=20) :: first, last, full

  first = "Grace"
  last = "Hopper"
  full = trim(first) // " " // trim(last)

  print *, "First:", trim(first)
  print *, "Last: ", trim(last)
  print *, "Full: ", trim(full)
end program full_name
