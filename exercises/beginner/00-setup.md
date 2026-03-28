# Beginner exercises — Setup and first programs

**Companion lesson:** [Lesson 01 — Your first Fortran program](../../lessons/01-setup/README.md)

**What you will practice:**

- Writing and compiling a complete Fortran program
- Using `implicit none` to catch bugs
- Declaring variables and printing output
- Using `fpm` to build projects

Each exercise asks you to write a small, complete program. Try on your own
before checking the solutions.

---

## Exercise 1 — Hello with your name ★

Write a program that prints a greeting with your name.

**Learning goal:** Write a complete program with `implicit none` and `print`.

**Requirements:**

- Store your name in a `character` variable.
- Print a greeting that includes the name.

**Starter code:**

```fortran
program greet
  implicit none

  character(len=30) :: name

  name = "Alice"

  ! Print a greeting that includes the name variable
end program greet
```

**Expected output (example):**

```text
 Hello, Alice!
```

---

## Exercise 2 — Rectangle area ★

Write a program that stores a width and height, computes the area of a
rectangle, and prints all three values.

**Learning goal:** Declare `real` variables and use arithmetic.

**Requirements:**

- Use `real` variables for width, height, and area.
- Compute `area = width * height`.

**Starter code:**

```fortran
program rectangle_area
  implicit none

  real :: width, height, area

  width = 5.0
  height = 3.0

  ! Compute area and print width, height, and area
end program rectangle_area
```

---

## Exercise 3 — Two integers ★

Write a program that stores two integers, computes their sum, difference,
product, and quotient, and prints all four results.

**Learning goal:** See that integer division truncates.

**Requirements:**

- Use `integer` variables.
- Notice what happens with integer division when the result is not exact.

**Starter code:**

```fortran
program two_integers
  implicit none

  integer :: a, b

  a = 17
  b = 5

  ! Compute and print: sum, difference, product, quotient
  ! What value does a / b produce? Why?
end program two_integers
```

---

## Exercise 4 — Spot the bug ★★

**Learning goal:** Understand why `implicit none` catches real bugs.

The following program has a bug caused by missing `implicit none`.
Read it carefully, predict what it will print, then compile and run it
to check your prediction.

After that, add `implicit none` and compile again. What error does the
compiler report?

```fortran
program spot_the_bug
  ! implicit none is missing on purpose

  real :: distance
  distance = 100.0

  print *, "Distance =", distnace
end program spot_the_bug
```

**Questions:**

1. What does the program print without `implicit none`?
2. What error does the compiler produce after you add `implicit none`?
3. Why is this dangerous in a larger program?

---

## Exercise 5 — Circle circumference ★

Write a program that computes the circumference of a circle given its radius.

**Learning goal:** Use `parameter` to define a named constant.

**Requirements:**

- Use `real, parameter :: pi = 3.14159265` to define pi as a constant.
- Store the radius in a `real` variable.
- Circumference = 2 * pi * radius.
- Print both the radius and the circumference.

---

## Exercise 6 — Compile with warnings ★★

**Learning goal:** Learn compiler warning flags and how they catch bugs.

Take any of the programs you wrote above and compile it with extra warnings:

```bash
gfortran -Wall -Wextra -fcheck=all your_program.f90 -o your_program
```

**Questions:**

1. Does the compiler report any new warnings?
2. Try deliberately creating a warning — for example, declare a variable
   but never use it. What message do you get?

---

## Exercise 7 — Your first fpm project ★★

**Learning goal:** Create a project with `fpm.toml` and `app/main.f90`.

Create a new `fpm` project from scratch and run it.

**Steps:**

1. Create a new directory called `my-first-project`.
2. Inside it, create `fpm.toml`:

```toml
name = "my_first_project"
version = "0.1.0"
```

3. Create the directory `app/` and a file `app/main.f90` containing a program
   that prints two lines of output.
4. Run `fpm run` and verify the output.

---

## Reflection

After completing these exercises, think about:

- How does the compile-then-run cycle compare to interpreted languages?
- What would happen in a large program if you forgot `implicit none`?
- When would you use `fpm` vs compiling manually with `gfortran`?

---

## Solutions

Worked solutions are in
[exercises/solutions/beginner/](../solutions/beginner/).
Each solution file name starts with `setup_` to distinguish them from the
basics exercises.
