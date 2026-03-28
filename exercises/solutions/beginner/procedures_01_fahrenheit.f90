! Exercise 1 — Function: Celsius to Fahrenheit

program convert
  implicit none

  print *, "  0 C =", to_fahrenheit(0.0), "F"
  print *, "100 C =", to_fahrenheit(100.0), "F"
  print *, "-40 C =", to_fahrenheit(-40.0), "F"

contains

  real function to_fahrenheit(c)
    real, intent(in) :: c
    to_fahrenheit = c * 9.0 / 5.0 + 32.0
  end function to_fahrenheit

end program convert
