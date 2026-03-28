! Exercise 3 — Public and private (temperature module)

module temperature_mod
  implicit none
  private
  public :: celsius_to_fahrenheit, fahrenheit_to_celsius

contains

  real function celsius_to_fahrenheit(c)
    real, intent(in) :: c
    celsius_to_fahrenheit = c * scale_factor() + 32.0
  end function celsius_to_fahrenheit

  real function fahrenheit_to_celsius(f)
    real, intent(in) :: f
    fahrenheit_to_celsius = (f - 32.0) / scale_factor()
  end function fahrenheit_to_celsius

  ! Private helper — not accessible outside the module
  real function scale_factor()
    scale_factor = 9.0 / 5.0
  end function scale_factor

end module temperature_mod


program test_temp
  use temperature_mod, only: celsius_to_fahrenheit, fahrenheit_to_celsius
  implicit none

  print *, "  0 C ->", celsius_to_fahrenheit(0.0), "F"
  print *, "100 C ->", celsius_to_fahrenheit(100.0), "F"
  print *, " 32 F ->", fahrenheit_to_celsius(32.0), "C"
  print *, "212 F ->", fahrenheit_to_celsius(212.0), "C"

  ! Uncommenting the next line causes a compile error:
  ! print *, scale_factor()
end program test_temp
