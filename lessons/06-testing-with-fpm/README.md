# Lesson 06 — Testing with fpm

## Why this lesson matters

Numerical code becomes brittle fast. A formula that worked yesterday can break
after a small refactor, a sign change, or a different compiler flag. Testing
turns assumptions into executable checks that run in seconds.

`fpm` makes testing low-friction: put a program in `test/`, run `fpm test`,
and any nonzero exit code means a failure. No framework installation, no
configuration — just Fortran.

This lesson shows you how to write, organize, and run tests for the modules
and types you built in earlier lessons.

## Learning objectives

By the end of this lesson you will be able to:

- explain how `fpm test` discovers and runs test programs
- write a test program that imports a module and checks its public API
- compare integer results exactly and real results with a tolerance
- write reusable assertion helpers using `contains`
- test edge cases, array operations, and error conditions
- organize tests as your project grows

## Prerequisites

You should be comfortable with:

- modules and `use ... only` (Lesson 04)
- the `fpm` project layout: `src/`, `app/`, `test/` (Lessons 01 and 04)
- subroutines with `intent` (Lesson 03)

## How `fpm test` works

When you run `fpm test`, fpm does three things:

1. Compiles every module in `src/` into a library.
2. Compiles every Fortran program in `test/` and links it against the library.
3. Runs each test program. If any program calls `error stop` or returns a
   nonzero exit code, fpm reports a failure.

That's it. There is no special test framework, no annotations, no macros. A
test is just a program that either finishes cleanly (pass) or stops with an
error (fail).

### Project layout

```text
my_project/
├── fpm.toml
├── src/
│   └── my_module.f90      ← reusable module
├── app/
│   └── main.f90           ← driver program (fpm run)
└── test/
    └── test_my_module.f90  ← test program (fpm test)
```

The `test/` directory mirrors `app/` — each `.f90` file in it becomes an
executable that fpm builds and runs. You can have multiple test programs.

### Running tests

```bash
cd examples/vector-ops
fpm test
```

Output on success:

```text
 All vector_ops tests passed.
```

If a check fails, `error stop 1` terminates the program with a nonzero exit
code, and fpm reports the failure.

## Your first test program

Here is the simplest useful test. It imports a module, calls a function, and
checks the result.

```fortran
program test_example
  use my_math, only: square
  implicit none

  if (square(3) /= 9) then
    print *, "FAIL: square(3) should be 9"
    error stop 1
  end if

  if (square(0) /= 0) then
    print *, "FAIL: square(0) should be 0"
    error stop 1
  end if

  if (square(-4) /= 16) then
    print *, "FAIL: square(-4) should be 16"
    error stop 1
  end if

  print *, "All tests passed."
end program test_example
```

Key points:

- `use my_math, only: square` imports only what you need.
- Each check is an `if` with a diagnostic message and `error stop 1`.
- The program prints a success message at the end — if you see it, every check
  passed.

### Why integers use exact comparison

Integer arithmetic is exact in Fortran. `3 * 3` is always `9`, so `/=` works:

```fortran
if (square(3) /= 9) error stop 1
```

Floating-point numbers are different. We'll handle them next.

## Comparing floating-point results

Real numbers are stored with finite precision. Even simple operations can
introduce tiny rounding differences:

```fortran
real :: x
x = 1.0 / 3.0
! x is approximately 0.33333334, not exactly 1/3
```

Never test reals with `==` or `/=`. Use a tolerance instead:

```fortran
real, parameter :: tol = 1.0e-6

if (abs(actual - expected) > tol) then
  print *, "FAIL: result out of tolerance"
  print *, "  actual   =", actual
  print *, "  expected =", expected
  error stop 1
end if
```

### Absolute vs relative tolerance

**Absolute tolerance** works well when you know the magnitude of the result:

```fortran
! Values near 1.0 — absolute tolerance is fine
if (abs(mean_val - 2.5) > 1.0e-6) error stop 1
```

**Relative tolerance** is better when results span many orders of magnitude:

```fortran
real, parameter :: rel_tol = 1.0e-6

if (abs(actual - expected) > rel_tol * max(1.0, abs(expected))) then
  error stop 1
end if
```

The `max(1.0, abs(expected))` prevents division-by-zero when the expected
value is zero and keeps the tolerance meaningful for small values.

### Choosing a tolerance

| Precision | Typical tolerance | When to use |
| --------- | ----------------- | ----------- |
| Default `real` | `1.0e-6` | Most single-precision calculations |
| `real64` | `1.0e-12` | Double-precision scientific computing |
| Iterative algorithms | `1.0e-3` or larger | When the algorithm itself has limited accuracy |

## Writing assertion helpers

Repeating the `if / print / error stop` pattern for every check gets verbose.
Move it into a subroutine using the `contains` block:

```fortran
program test_stats
  use stats_utils, only: mean, variance
  implicit none

  real, parameter :: tol = 1.0e-6
  real :: values(4)

  values = [1.0, 2.0, 3.0, 4.0]

  call assert_close(mean(values), 2.5, tol, "mean failed")
  call assert_close(variance(values), 1.25, tol, "variance failed")

  print *, "All stats tests passed."

contains

  subroutine assert_close(actual, expected, tolerance, message)
    real, intent(in) :: actual
    real, intent(in) :: expected
    real, intent(in) :: tolerance
    character(len=*), intent(in) :: message

    if (abs(actual - expected) > tolerance) then
      print *, "FAIL:", trim(message)
      print *, "  actual   =", actual
      print *, "  expected =", expected
      error stop 1
    end if
  end subroutine assert_close

end program test_stats
```

This pattern appears throughout the repository. Every test program defines its
helpers in `contains` so they stay self-contained — no extra module needed.

### Useful assertion helpers

Here are three helpers that cover most testing needs:

**Scalar real comparison** — `assert_close`:

```fortran
subroutine assert_close(actual, expected, tolerance, message)
  real, intent(in) :: actual, expected, tolerance
  character(len=*), intent(in) :: message

  if (abs(actual - expected) > tolerance) then
    print *, "FAIL:", trim(message)
    print *, "  actual   =", actual
    print *, "  expected =", expected
    error stop 1
  end if
end subroutine assert_close
```

**Array comparison** — `assert_array_close`:

```fortran
subroutine assert_array_close(actual, expected, tolerance, message)
  real, intent(in) :: actual(:), expected(:)
  real, intent(in) :: tolerance
  character(len=*), intent(in) :: message

  if (size(actual) /= size(expected)) then
    print *, "FAIL:", trim(message), " (size mismatch)"
    error stop 1
  end if

  if (any(abs(actual - expected) > tolerance)) then
    print *, "FAIL:", trim(message)
    print *, "  actual   =", actual
    print *, "  expected =", expected
    error stop 1
  end if
end subroutine assert_array_close
```

**Integer equality** — `assert_equal`:

```fortran
subroutine assert_equal(actual, expected, message)
  integer, intent(in) :: actual, expected
  character(len=*), intent(in) :: message

  if (actual /= expected) then
    print *, "FAIL:", trim(message)
    print *, "  actual   =", actual
    print *, "  expected =", expected
    error stop 1
  end if
end subroutine assert_equal
```

## What to test

### Test the public API, not internals

Import the module's public routines and test them through their documented
interface. Do not try to test private helper functions — if the public API
works correctly, the internals are doing their job.

```fortran
! Good: test the module's public function
use vector_ops, only: euclidean_norm
call assert_close(euclidean_norm([3.0, 4.0]), 5.0, tol, "norm of 3-4-5")

! Bad: trying to access a private helper
! use vector_ops, only: sum_squares  ← won't compile if private
```

### Test boundary and edge cases

The most useful tests catch problems at the edges:

```fortran
! Single-element array
call assert_close(vector_mean([7.0]), 7.0, tol, "mean of single element")

! Two identical values — standard deviation should be zero
call assert_close(stddev([5.0, 5.0, 5.0]), 0.0, tol, "stddev of constant array")

! Negative values
call assert_close(vector_mean([-1.0, -2.0, -3.0]), -2.0, tol, "mean of negatives")
```

### Test with known analytical results

When possible, choose inputs whose correct answer you can compute by hand:

```fortran
! Euclidean norm of [3, 4] is exactly 5 (Pythagorean triple)
call assert_close(euclidean_norm([3.0, 4.0]), 5.0, tol, "3-4-5 triangle")

! Dot product of orthogonal vectors is zero
call assert_close(dot_product_safe([1.0, 0.0], [0.0, 1.0]), 0.0, tol, "orthogonal dot")
```

### One assertion per logical property

Each `assert_close` call should test one thing. This makes failures easy to
diagnose — the message tells you exactly what broke.

```fortran
! Good: separate assertions
call assert_close(mean(x), 2.5, tol, "mean value")
call assert_close(variance(x), 1.25, tol, "variance value")

! Bad: combining checks into one conditional
if (abs(mean(x) - 2.5) > tol .or. abs(variance(x) - 1.25) > tol) error stop 1
```

## Worked example — testing a statistics module

Let's walk through writing a test for the statistics module in
`examples/statistics/`. The module provides `mean`, `median`, `variance`, and
`stddev`.

### Step 1: identify what to test

| Function | Test strategy |
| -------- | ------------- |
| `mean` | Known values: `[1,2,3,4]` → 2.5 |
| `median` | Even-length and odd-length arrays |
| `variance` | Known values: `[1,2,3,4]` → 1.25 |
| `stddev` | Should equal `sqrt(variance)` |

### Step 2: write the test program

```fortran
program test_descriptive_stats
  use descriptive_stats, only: mean, median, variance, stddev
  implicit none

  real, parameter :: tol = 1.0e-6
  real :: x_even(4), x_odd(5)

  x_even = [1.0, 2.0, 3.0, 4.0]
  x_odd  = [9.0, 2.0, 5.0, 7.0, 1.0]

  ! Mean
  call assert_close(mean(x_even), 2.5, tol, "mean of [1,2,3,4]")

  ! Median — even length (average of middle two)
  call assert_close(median(x_even), 2.5, tol, "median of even-length array")

  ! Median — odd length (middle element after sorting)
  call assert_close(median(x_odd), 5.0, tol, "median of odd-length array")

  ! Variance
  call assert_close(variance(x_even), 1.25, tol, "variance of [1,2,3,4]")

  ! Standard deviation = sqrt(variance)
  call assert_close(stddev(x_even), sqrt(1.25), tol, "stddev of [1,2,3,4]")

  print *, "All descriptive_stats tests passed."

contains

  subroutine assert_close(actual, expected, tolerance, message)
    real, intent(in) :: actual, expected, tolerance
    character(len=*), intent(in) :: message

    if (abs(actual - expected) > tolerance) then
      print *, "FAIL:", trim(message)
      print *, "  actual   =", actual
      print *, "  expected =", expected
      error stop 1
    end if
  end subroutine assert_close

end program test_descriptive_stats
```

### Step 3: run it

```bash
cd examples/statistics
fpm test
```

```text
 All descriptive_stats tests passed.
```

If you change the `expected` value to something wrong (say `2.6` instead of
`2.5`), fpm shows the failure:

```text
 FAIL: mean of [1,2,3,4]
   actual   =   2.50000000
   expected =   2.59999990
STOP 1
<ERROR> Execution for object "test_descriptive_stats" returned exit code 1
```

The diagnostic message, actual value, and expected value tell you exactly where
to look.

## Testing with double precision

The projects in this repository use `real(real64)` from `iso_fortran_env` for
higher accuracy. When testing double-precision code, adjust the tolerance and
the assertion helper:

```fortran
program test_double
  use iso_fortran_env, only: real64
  use ode_euler, only: integrate_euler
  implicit none

  real(real64), parameter :: tol = 1.0e-12_real64
  ! ... test code ...

contains

  subroutine assert_close(actual, expected, tolerance, message)
    real(real64), intent(in) :: actual, expected, tolerance
    character(len=*), intent(in) :: message

    if (abs(actual - expected) > tolerance) then
      print *, "FAIL:", trim(message)
      print *, "  actual   =", actual
      print *, "  expected =", expected
      error stop 1
    end if
  end subroutine assert_close

end program test_double
```

The only changes are the kind declarations (`real64`) and a tighter tolerance
(`1.0e-12`). The structure is identical.

## Extending your tests

Once you have basic tests working, consider these patterns:

### Add more edge cases

```fortran
! Empty-like edge cases
call assert_close(mean([42.0]), 42.0, tol, "mean of single element")

! All-same values
call assert_close(stddev([3.0, 3.0, 3.0, 3.0]), 0.0, tol, "stddev of constant")

! Large array
real :: big(1000)
call random_number(big)
! mean of uniform [0,1) should be near 0.5
call assert_close(mean(big), 0.5, 0.05, "mean of 1000 random values near 0.5")
```

### Test error handling

If your module uses `error stop` for invalid input, you can note this in
comments. Fortran does not have `try/catch`, so testing that `error stop`
fires correctly requires running a separate program and checking its exit code
— a shell-level check rather than an in-program assertion.

```fortran
! Document the expected behavior rather than testing it inline:
! vector_mean([]) should call error stop — tested by:
!   echo "" | fpm run test_empty_mean && echo "FAIL" || echo "PASS"
```

For most learning projects, documenting these expectations is sufficient.

### Use `random_number` for stress tests

```fortran
real :: data(500)
call random_number(data)
! Verify statistical properties hold for random inputs
if (mean(data) < 0.0 .or. mean(data) > 1.0) then
  print *, "FAIL: mean of random [0,1) out of range"
  error stop 1
end if
```

### Multiple test programs

As a project grows, you can split tests into multiple files:

```text
test/
├── test_mean.f90
├── test_median.f90
└── test_variance.f90
```

`fpm test` discovers and runs all of them. Each is an independent program with
its own assertions.

To run a specific test:

```bash
fpm test test_mean
```

## Best practices

| Practice | Why |
| -------- | --- |
| Test the public API | If public functions work, internals are correct |
| Use tolerances for reals | Floating-point math is inexact |
| Print diagnostics on failure | Actual vs expected makes debugging fast |
| One assertion per property | Pinpoints exactly what broke |
| Keep tests small | A 20-line test is easier to understand than a 200-line one |
| Run tests after every change | `fpm test` takes seconds — use it often |
| Choose hand-computable inputs | `[3,4]` → norm 5 is better than random values for basic checks |
| Test edge cases | Single elements, zeros, negatives, identical values |

## Common mistakes

**Using `==` for real comparison:**

```fortran
! Wrong — may fail due to rounding
if (mean(x) == 2.5) ...

! Correct — use a tolerance
if (abs(mean(x) - 2.5) > 1.0e-6) error stop 1
```

**Forgetting `error stop`:**

```fortran
! Wrong — prints a message but test still passes
if (abs(result - expected) > tol) then
  print *, "FAIL"
end if

! Correct — nonzero exit code signals failure to fpm
if (abs(result - expected) > tol) then
  print *, "FAIL"
  error stop 1
end if
```

**Testing too much at once:**

```fortran
! Hard to debug — which check failed?
if (abs(mean(x) - 2.5) > tol .or. abs(stddev(x) - 1.12) > tol &
    .or. abs(variance(x) - 1.25) > tol) error stop 1

! Better — separate assertions with messages
call assert_close(mean(x), 2.5, tol, "mean")
call assert_close(stddev(x), sqrt(1.25), tol, "stddev")
call assert_close(variance(x), 1.25, tol, "variance")
```

## Companion example

Run the fully tested example to see everything in action:

```bash
cd examples/vector-ops
fpm test
```

This project demonstrates the complete testing pattern: a module in `src/`, a
driver in `app/`, and a test program in `test/` with `assert_close` helpers.

See also:

- [examples/statistics/](../../examples/statistics/) — tests for mean, median, variance, stddev
- [examples/modules-types/](../../examples/modules-types/) — tests for stats and particle type
- [projects/monte-carlo-pi/](../../projects/monte-carlo-pi/) — double-precision tests for numerical algorithms

## Exercises

Practice writing tests: [intermediate/04-testing.md](../../exercises/intermediate/04-testing.md)

## Key takeaways

- `fpm test` builds and runs every program in `test/`. No framework needed.
- Use `error stop 1` to signal failure — fpm checks the exit code.
- Never compare reals with `==`. Use `abs(actual - expected) > tol`.
- Write `assert_close` and `assert_array_close` helpers in `contains` to keep
  tests readable.
- Test public APIs, use hand-computable inputs, and cover edge cases.
- Keep each test small and focused on one property.

## Suggested next step

Move to [Lesson 07 — Numerical mini-projects](../07-numerical-mini-projects/README.md).
