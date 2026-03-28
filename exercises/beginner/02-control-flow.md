# Beginner exercises — Control flow

**Companion lesson:** [Lesson 03 — Arrays, control flow, and procedures](../../lessons/03-arrays-procedures/README.md)

**What you will practice:**

- `if` / `else if` / `else` branching
- `select case` for discrete values
- `do` counted loops
- `do while` condition-based loops
- `exit` and `cycle` for loop control
- Nested loops

---

## Exercise 1 — Grade classifier ★

Write a program that assigns a letter grade to a numeric score using
`if` / `else if` / `else`.

**Rules:** 90+: A, 80-89: B, 70-79: C, 60-69: D, below 60: F.

**Learning goal:** Practice multi-branch `if` logic.

**Expected output for score = 85:**

```text
 Score: 85  Grade: B
```

Test with at least three different scores.

---

## Exercise 2 — Day of week ★

Write a program that stores an integer (1-7) and prints the day name using
`select case`.

**Learning goal:** Use `select case` with integer values and a `default` branch.

**Hint:** `case (6, 7)` can match Saturday and Sunday together.

---

## Exercise 3 — Countdown ★

Write a `do` loop that prints the integers from 10 down to 1, then prints
"Liftoff!".

**Learning goal:** Use a counted `do` loop with a negative step.

**Expected output:**

```text
 10
 9
 ...
 1
 Liftoff!
```

---

## Exercise 4 — Power of 2 ★★

Use a `do while` loop to find the smallest power of 2 that is greater than
or equal to a given integer `n`.

**Learning goal:** Use `do while` for a computation where the number of
iterations is not known in advance.

**Test values:** n = 50 (answer: 64), n = 128 (answer: 128), n = 1 (answer: 1).

**Hint:** Start with `p = 1` and double `p` while `p < n`.

---

## Exercise 5 — Count above threshold ★★

Write a program that counts how many elements in a real array are strictly
greater than a given threshold. Use an explicit loop with `if`.

**Learning goal:** Combine a loop with a conditional to accumulate a count.

**Test data:** `x = [1.5, 3.2, 0.8, 4.1, 2.9, 5.0]`, threshold = 3.0.
Expected count: 3.

---

## Exercise 6 — Find first negative ★★

Write a program that loops through an array and prints the index and value
of the **first** negative element. Use `exit` to stop the loop immediately.

If no negative element exists, print "No negatives found."

**Learning goal:** Use `exit` to break out of a loop early.

**Test data:** `x = [3.0, 1.0, -2.0, 5.0, -1.0]`.
Expected: index 3, value -2.0.

---

## Exercise 7 — Sum positives only ★★

Write a program that sums only the positive values in a real array, skipping
negatives and zeros. Use `cycle` to skip unwanted elements.

**Learning goal:** Use `cycle` to skip iterations.

**Test data:** `x = [4.0, -2.0, 7.0, 0.0, -3.0, 8.0]`.
Expected sum: 19.0 (4 + 7 + 8).

---

## Exercise 8 — Multiplication table ★★★

Write a program using nested `do` loops that prints a 5-by-5 multiplication
table with aligned columns.

**Learning goal:** Nest loops and use formatted output for alignment.

**Expected output:**

```text
   1   2   3   4   5
   2   4   6   8  10
   3   6   9  12  15
   4   8  12  16  20
   5  10  15  20  25
```

**Hint:** Use format `'(5I4)'` to print one row at a time.

---

## Solutions

Worked solutions are in
[exercises/solutions/beginner/](../solutions/beginner/).
Files are named `control_01_grades.f90` through `control_08_mul_table.f90`.
