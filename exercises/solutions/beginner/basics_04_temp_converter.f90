! Exercise 4 — Temperature converter
! Converts Celsius to Fahrenheit using F = C * 9.0 / 5.0 + 32.0.

program temp_converter
  implicit none

  real :: celsius, fahrenheit

  ! Test value: water freezes at 0 C = 32 F
  celsius = 0.0
  fahrenheit = celsius * 9.0 / 5.0 + 32.0
  print *, "Celsius:", celsius, " -> Fahrenheit:", fahrenheit

  ! Test value: water boils at 100 C = 212 F
  celsius = 100.0
  fahrenheit = celsius * 9.0 / 5.0 + 32.0
  print *, "Celsius:", celsius, " -> Fahrenheit:", fahrenheit

  ! Test value: -40 is the same in both scales
  celsius = -40.0
  fahrenheit = celsius * 9.0 / 5.0 + 32.0
  print *, "Celsius:", celsius, " -> Fahrenheit:", fahrenheit
end program temp_converter
