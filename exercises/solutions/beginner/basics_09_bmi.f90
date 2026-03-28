! Exercise 9 — Body mass index
! Computes BMI from weight (kg) and height (m) and prints with one decimal.

program bmi_calculator
  implicit none

  real :: weight, height, bmi

  weight = 70.0
  height = 1.75
  bmi = weight / height ** 2

  print '(A, F6.1, A)', "Weight: ", weight, " kg"
  print '(A, F5.2, A)', "Height: ", height, " m"
  print '(A, F6.1)',    "BMI:    ", bmi
end program bmi_calculator
