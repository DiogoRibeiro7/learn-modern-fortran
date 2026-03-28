# Beginner exercises — Procedures

**Companion lesson:** [Lesson 03 — Arrays, control flow, and procedures](../../lessons/03-arrays-procedures/README.md)

**What you will practice:**

- Writing functions that return a value
- Writing subroutines that modify arguments
- `intent(in)`, `intent(out)`, `intent(inout)`
- Assumed-shape array arguments `x(:)`
- The `result()` clause
- Internal procedures after `contains`

---

## Exercise 1 — Function: Celsius to Fahrenheit ★

Write a function `to_fahrenheit(c)` that converts Celsius to Fahrenheit.
Call it from a main program to convert 0, 100, and -40.

**Learning goal:** Write a basic function with `intent(in)`.

**Formula:** F = C * 9.0 / 5.0 + 32.0

**Hint:** Place the function after `contains` in the program.

---

## Exercise 2 — Subroutine: swap two values ★

Write a subroutine `swap(a, b)` that swaps two real values.
Both arguments must be `intent(inout)`.

**Learning goal:** Understand `intent(inout)` and the difference between
functions and subroutines.

**Test:** `a = 3.0, b = 7.0` becomes `a = 7.0, b = 3.0`.

---

## Exercise 3 — Subroutine: min and max ★★

Write a subroutine `find_extremes(x, lo, hi)` that takes a real array
(`intent(in)`) and returns the minimum and maximum through two `intent(out)`
arguments.

**Learning goal:** Use `intent(out)` to return multiple values.

**Test data:** `x = [4.0, -2.0, 7.0, 1.0]`. Expected: lo = -2.0, hi = 7.0.

---

## Exercise 4 — Function with result clause ★★

Write a function `euclidean_norm(x)` that computes the Euclidean norm of a
vector. Use the `result(value)` clause to name the return variable.

**Learning goal:** Use `result()` syntax and assumed-shape arrays.

**Formula:** norm = sqrt(sum(x * x))

**Test data:** `x = [3.0, 4.0]`. Expected: 5.0.

---

## Exercise 5 — Standard deviation ★★

Write a function `stddev(x)` that computes the population standard deviation.
You may call a separate `mean` function from the same `contains` block.

**Learning goal:** Build procedures that call other procedures.

**Formula:** stddev = sqrt(sum((x - mean)^2) / n)

**Test data:** `x = [2.0, 4.0, 4.0, 4.0, 5.0, 5.0, 7.0, 9.0]`.
Expected stddev: approximately 2.0.

---

## Exercise 6 — Normalize a vector ★★

Write a subroutine `normalize(x)` that divides every element of a real
vector by its Euclidean norm, modifying the array in place.

**Learning goal:** Use `intent(inout)` on an array argument.

**Test:** `x = [3.0, 4.0, 0.0]` becomes `[0.6, 0.8, 0.0]`.
After normalization, `sqrt(sum(x*x))` should be approximately 1.0.

**Hint:** Compute the norm first, check it is not zero, then divide.

---

## Exercise 7 — Linear search with early exit ★★★

Write a function `find_first(x, target)` that returns the index of the first
element in an integer array that equals `target`. Return 0 if not found.
Use `exit` to stop the loop as soon as the value is found.

**Learning goal:** Combine a function, a loop, and `exit`.

**Test:**

```text
find_first([10, 20, 30, 40, 50], 30)  → 3
find_first([10, 20, 30, 40, 50], 99)  → 0
```

---

## Exercise 8 — Procedure calling procedure ★★★

Write two functions in the same `contains` block: `vec_mean(x)` and
`vec_variance(x)`. The variance function should call the mean function
internally.

**Learning goal:** See that internal procedures can call each other.

**Formula:** variance = sum((x - mean)^2) / n

**Test data:** `x = [2.0, 4.0, 4.0, 4.0, 5.0, 5.0]`.
Expected: mean = 4.0, variance = 1.0.

---

## Solutions

Worked solutions are in
[exercises/solutions/beginner/](../solutions/beginner/).
Files are named `procedures_01_fahrenheit.f90` through `procedures_08_variance.f90`.
