# Intermediate exercises — Testing with fpm

**Companion lesson:** [Lesson 06 — Testing with fpm](../../lessons/06-testing-with-fpm/README.md)

**What you will practice:**

- Writing test programs that import and verify module routines
- Using `assert_close` for floating-point comparisons with tolerance
- Using `assert_equal` for integer comparisons
- Testing edge cases (single-element arrays, zeros, negatives)
- Organizing assertion helpers in a `contains` block
- Running tests with `fpm test`

Exercises are ordered by difficulty. Complete them before reading solutions.

---

## Exercise 1 — Test a square function ★

**Learning goal:** Write your first test program with exact integer checks.

1. Create a small fpm project with a module `math_basics` in `src/` that
   provides a `square(n)` function (returns `n * n` as an integer).
2. Write a test program in `test/` that checks `square(0)`, `square(3)`,
   `square(-5)`, and `square(1)`.
3. Use `if (result /= expected) error stop 1` for each check.
4. Run `fpm test` and confirm all checks pass.

**Hint:** Integer arithmetic is exact — use `/=` directly, no tolerance needed.

---

## Exercise 2 — Test vector_mean with edge cases ★

**Learning goal:** Write tolerance-based assertions for real results.

Using the `vector_ops` module from `examples/vector-ops/`:

1. Copy the project or work inside it.
2. Add tests for `vector_mean` with these inputs:
   - `[1.0, 2.0, 3.0, 4.0, 5.0]` → expected 3.0
   - `[42.0]` → expected 42.0 (single element)
   - `[-1.0, -2.0, -3.0]` → expected -2.0 (negative values)
3. Use an `assert_close` helper with tolerance `1.0e-6`.

**Hint:** Define `assert_close` in the `contains` block of your test program.

**Expected output:**

```text
 All vector_mean tests passed.
```

---

## Exercise 3 — Test an array operation ★★

**Learning goal:** Write `assert_array_close` for element-wise array checks.

1. Create a module `array_tools` with a subroutine `scale(x, factor)` that
   multiplies each element of a real array `x(:)` by `factor` in-place.
2. Write a test program with:
   - `x = [1.0, 2.0, 3.0]`, scale by 2.0 → expected `[2.0, 4.0, 6.0]`
   - `x = [10.0, -5.0, 0.0]`, scale by 0.0 → expected `[0.0, 0.0, 0.0]`
3. Write an `assert_array_close` helper that:
   - Checks `size(actual) == size(expected)`
   - Uses `any(abs(actual - expected) > tol)` for element-wise comparison
   - Prints actual and expected arrays on failure

**Hint:** The helper needs assumed-shape arguments `actual(:)` and `expected(:)`.

---

## Exercise 4 — Test a statistics pair ★★

**Learning goal:** Test multiple related functions with hand-computable inputs.

1. Use the `stats_utils` module from `examples/modules-types/` (provides
   `mean`, `variance`, `stddev`).
2. Write a test program that verifies all three functions using
   `values = [2.0, 4.0, 6.0, 8.0]`:
   - `mean` → 5.0
   - `variance` → 5.0
   - `stddev` → `sqrt(5.0)`
3. Add a second data set: `[10.0, 10.0, 10.0]` where variance and stddev
   should be 0.0.

**Hint:** Computing expected values by hand first makes your tests trustworthy.

---

## Exercise 5 — Add boundary tests ★★

**Learning goal:** Identify and test edge cases that expose hidden bugs.

Using any module that operates on arrays (e.g., `vector_ops` or `stats_utils`):

1. Write tests for these edge cases:
   - Single-element array: `[7.0]`
   - Two identical elements: `[3.0, 3.0]`
   - Large values: `[1.0e6, 2.0e6, 3.0e6]`
   - Mix of positive and negative: `[-10.0, 10.0]` (mean should be 0.0)
2. Run all tests with `fpm test`.

**Hint:** Edge cases often reveal off-by-one errors in size calculations or
division-by-zero in standard deviation formulas.

---

## Exercise 6 — Test a derived type ★★

**Learning goal:** Test type-bound procedures on a derived type.

1. Use the `particle_mod` module from `examples/modules-types/` (provides
   `particle_t` with `speed()` and `kinetic_energy()`).
2. Write a test program that creates a particle with `vx=3.0`, `vy=4.0`,
   `mass=2.0` and checks:
   - `speed()` → 5.0 (3-4-5 triangle)
   - `kinetic_energy()` → 25.0 (0.5 * mass * speed^2)
3. Create a second particle with `vx=0.0`, `vy=0.0` and verify speed is 0.0.

**Hint:** Use the structure constructor: `particle_t(vx=3.0, vy=4.0, mass=2.0)`.

---

## Exercise 7 — Diagnostic messages ★★★

**Learning goal:** Write assertion helpers that produce clear failure output.

1. Take any passing test program from an earlier exercise.
2. Temporarily change one expected value to be wrong.
3. Run `fpm test` and read the failure output.
4. Improve your `assert_close` helper so it prints:
   - The test name/message
   - The actual value
   - The expected value
   - The absolute difference `abs(actual - expected)`
5. Revert the expected value and confirm all tests pass again.

**Expected failure output format:**

```text
 FAIL: mean of [2,4,6,8]
   actual   =   5.00000000
   expected =   4.00000000
   diff     =   1.00000000
```

---

## Exercise 8 — Full test suite for a module ★★★

**Learning goal:** Combine all testing techniques into a comprehensive suite.

1. Create a new fpm project with a module `geometry` that provides:
   - `circle_area(r)` → `pi * r * r`
   - `rectangle_area(w, h)` → `w * h`
   - `triangle_area(b, h)` → `0.5 * b * h`
2. Write a test program that covers:
   - Normal cases for all three functions
   - Zero dimensions (area should be 0.0)
   - Known values: `circle_area(1.0)` → pi, `rectangle_area(3.0, 4.0)` → 12.0
   - Consistency: `rectangle_area(s, s)` should equal `s * s`
3. Include both `assert_close` and `assert_equal` (for integer-like checks like
   `rectangle_area(3.0, 4.0) ≈ 12.0`).
4. Run `fpm test` and verify all checks pass.

**Hint:** Use `acos(-1.0)` for pi since Fortran has no built-in pi constant.
