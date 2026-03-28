# Beginner exercises — Arrays

**Companion lesson:** [Lesson 03 — Arrays, control flow, and procedures](../../lessons/03-arrays-procedures/README.md)

**What you will practice:**

- Declaring and initializing 1D arrays
- Implied do loops for array construction
- Array slicing with `start:end:step`
- Intrinsic array functions (`sum`, `size`, `maxval`, `minval`, `count`)
- Element-wise arithmetic
- 2D arrays with `reshape`

---

## Exercise 1 — Array creation and printing ★

Create an integer array containing the values 10, 20, 30, 40, 50.
Print the whole array, the first element, the last element, and the size.

**Learning goal:** Declare an array, assign values with a constructor, and
access individual elements.

---

## Exercise 2 — Implied do loop ★

Use an implied do loop to create a real array containing the first 8 cubes:
1, 8, 27, 64, 125, 216, 343, 512.

**Learning goal:** Build arrays from formulas with `[(expr, i = start, end)]`.

**Hint:** `[(real(i ** 3), i = 1, 8)]`

---

## Exercise 3 — Array slicing ★

Create an array `v = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]` and print:

- elements 3 through 7
- every other element (1, 3, 5, 7, 9)
- the array in reverse order

**Learning goal:** Use `start:end` and `start:end:step` slice notation.

---

## Exercise 4 — Sum with a loop vs intrinsic ★★

Compute the sum of a real array two ways: with an explicit `do` loop and
with the `sum` intrinsic. Print both to verify they match.

**Learning goal:** Understand that `sum(x)` replaces a common loop pattern.

**Test data:** `x = [3.0, 7.0, 1.0, 9.0, 4.0]`. Expected sum: 24.0.

---

## Exercise 5 — Element-wise operations ★★

Create two real arrays `a = [1, 2, 3, 4]` and `b = [10, 20, 30, 40]`.
Compute and print:

- `a + b`
- `a * b`
- `2.0 * a + 1.0`
- `sqrt(a)`

**Learning goal:** See that arithmetic on arrays works element by element,
without loops.

---

## Exercise 6 — Array intrinsics ★★

Create `x = [3.0, 1.0, 4.0, 1.0, 5.0, 9.0, 2.0, 6.0]` and print:

- `sum(x)`, `product(x)`
- `minval(x)`, `maxval(x)`
- `count(x > 3.0)`
- `any(x < 0.0)`, `all(x > 0.0)`

**Learning goal:** Use the full set of intrinsic reduction functions.

---

## Exercise 7 — Matrix row sums ★★★

Create a 3-by-4 matrix using `reshape` and compute the sum of each row.
Print each row and its sum.

**Learning goal:** Work with 2D arrays, `reshape`, and row slicing.

**Test data:** `reshape([1,2,3,4,5,6,7,8,9,10,11,12], [3,4])`

**Hint:** `sum(mat(i, :))` gives the sum of row `i`.

---

## Exercise 8 — Clamp with `where` ★★★

Create `x = [-3.0, 1.0, -7.0, 4.0, 0.0, -2.0, 8.0]`. Use a `where`
statement to clamp all negative values to zero, then print the result.

**Learning goal:** Use `where` for conditional element-wise operations.

**Expected output:** `[0.0, 1.0, 0.0, 4.0, 0.0, 0.0, 8.0]`

---

## Solutions

Worked solutions are in
[exercises/solutions/beginner/](../solutions/beginner/).
Files are named `arrays_01_creation.f90` through `arrays_08_clamp.f90`.
