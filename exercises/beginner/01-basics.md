# Beginner exercises — Types, variables, and expressions

**Companion lesson:** [Lesson 02 — Types, variables, and expressions](../../lessons/02-basics/README.md)

**What you will practice:**

- Declaring and using all four intrinsic types
- Constants with `parameter`
- Integer vs real division
- Relational and logical operators
- Kind selection for precision
- Formatted output

Try each exercise on your own before checking the solutions.

---

## Exercise 1 — All four types ★

**Learning goal:** Declare and use `integer`, `real`, `logical`, `character`.

Declare one variable of each common type (`integer`, `real`, `logical`,
`character`), assign a value to each, and print them all.

**Requirements:**

- Use `implicit none`.
- Use meaningful variable names.

**Starter code:**

```fortran
program all_types
  implicit none

  ! Declare one integer, one real, one logical, one character variable
  ! Assign values and print them
end program all_types
```

---

## Exercise 2 — Circle area with `parameter` ★

**Learning goal:** Use `parameter` for named constants.

Write a program that computes the area of a circle given a radius.
Define pi as a named constant using `parameter`.

**Requirements:**

- `real, parameter :: pi = 3.14159265`
- Area = pi * radius^2
- Print both the radius and the area.

---

## Exercise 3 — Integer division predictions ★★

**Learning goal:** Predict and explain integer division behavior.

Before running this program, predict the output of each `print` statement
on paper. Then compile and run to check your predictions.

```fortran
program division_quiz
  implicit none

  real :: x

  print *, 9 / 4
  print *, 9.0 / 4.0
  print *, 9 / 4.0
  x = 9 / 4
  print *, x
  x = real(9) / real(4)
  print *, x
end program division_quiz
```

**Questions:**

1. Why does `9 / 4` produce a different result from `9.0 / 4.0`?
2. Why does `x = 9 / 4` give `2.0` instead of `2.25`?
3. What does `real()` do in the last expression?

---

## Exercise 4 — Temperature converter ★

**Learning goal:** Apply a formula using real arithmetic.

Write a program that converts a temperature from Celsius to Fahrenheit
and prints both values.

**Formula:** F = C * 9.0 / 5.0 + 32.0

**Requirements:**

- Store the Celsius value in a `real` variable.
- Use the formula above (be careful not to use integer division).
- Print both temperatures.
- Test with 0, 100, and -40 (which is the same in both scales).

---

## Exercise 5 — Leap year checker ★★

**Learning goal:** Combine logical operators (`.and.`, `.or.`) in one expression.

Write a program that stores a year in an integer variable and determines
whether it is a leap year using logical operators.

**Leap year rules:**

- A year is a leap year if it is divisible by 4.
- Exception: years divisible by 100 are not leap years.
- Exception to the exception: years divisible by 400 are leap years.

**Hints:**

- `mod(year, 4) == 0` tests divisibility by 4.
- Combine the three conditions with `.and.` and `.or.`.
- Store the result in a `logical` variable and print it.

**Test values:** 2024 (leap), 1900 (not leap), 2000 (leap), 2023 (not leap).

---

## Exercise 6 — Full name builder ★★

**Learning goal:** Use `trim()` and `//` for string manipulation.

Write a program that stores a first name and a last name in separate
`character` variables, concatenates them into a full name with a space in
between, and prints all three.

**Requirements:**

- Use `character(len=20)` for each name.
- Use `trim()` to remove trailing spaces before concatenating.
- Use `//` for concatenation.

---

## Exercise 7 — Precision comparison ★★

**Learning goal:** See the effect of kind selection on numeric precision.

Write a program that computes `1.0 / 3.0` in both default `real` and
`real64`, and prints both results to show the difference in precision.

**Requirements:**

- `use iso_fortran_env, only: real64`
- Use the `_real64` suffix on the 64-bit literals.
- Print both results and compare the number of significant digits.

**Question:** What happens if you write `x = 1.0 / 3.0` where `x` is
`real(real64)` but the literals have no kind suffix?

---

## Exercise 8 — Formatted multiplication table ★★★

**Learning goal:** Use format strings for aligned columnar output.

Write a program that prints a 5-by-5 multiplication table using formatted
output so the columns are aligned.

**Requirements:**

- Use a format string with `I4` descriptors.
- The output should look roughly like:

```text
   1   2   3   4   5
   2   4   6   8  10
   3   6   9  12  15
   4   8  12  16  20
   5  10  15  20  25
```

**Hint:** You can print a whole row in one `print` statement using the format
`'(5I4)'` which repeats the `I4` descriptor five times.

This exercise requires a `do` loop (covered briefly in the starter code below
if you have not seen loops yet):

```fortran
program mul_table
  implicit none

  integer :: row, col, values(5)

  do row = 1, 5
    do col = 1, 5
      values(col) = row * col
    end do
    print '(5I4)', values
  end do
end program mul_table
```

---

## Exercise 9 — Body mass index ★★★

**Learning goal:** Combine real arithmetic with formatted output.

Write a program that computes body mass index (BMI) from a weight in
kilograms and a height in meters, then prints the result with one decimal
place using formatted output.

**Formula:** BMI = weight / height^2

**Requirements:**

- Use `real` variables for weight, height, and bmi.
- Use formatted output: `print '(A, F6.1)', "BMI: ", bmi`
- Test with weight = 70.0 kg, height = 1.75 m (expected BMI: 22.9).

---

## Reflection

After completing these exercises, think about:

- Where did integer division cause unexpected results?
- When would you choose `real64` over default `real`?
- How does formatted output compare to `print *` for readability?

---

## Solutions

Worked solutions are in
[exercises/solutions/beginner/](../solutions/beginner/).
Each solution file name starts with `basics_` to distinguish them from other
exercise sets.
