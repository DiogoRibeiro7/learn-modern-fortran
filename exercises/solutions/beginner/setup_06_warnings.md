# Exercise 6 — Compile with warnings (solution notes)

## Compiling with warnings

```bash
gfortran -Wall -Wextra -fcheck=all your_program.f90 -o your_program
```

## What you should observe

If your program is clean, the compiler produces no extra output beyond the
normal compilation.

## Creating a deliberate warning

Add a variable that is declared but never used:

```fortran
program warning_test
  implicit none

  integer :: x
  integer :: unused_var

  x = 10
  print *, "x =", x
end program warning_test
```

Compile with:

```bash
gfortran -Wall -Wextra warning_test.f90 -o warning_test
```

The compiler reports something like:

```text
Warning: Unused variable 'unused_var' declared at (1)
```

## Why this matters

- `-Wall` and `-Wextra` catch unused variables, uninitialized values, and
  suspicious patterns.
- `-fcheck=all` adds runtime checks for array bounds, null pointers, and
  integer overflow.
- Turning on warnings while learning is one of the fastest ways to find bugs.
