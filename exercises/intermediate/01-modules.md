# Intermediate exercises — Modules and derived types

**Companion lesson:** [Lesson 04 — Modules and derived types](../../lessons/04-modules-types/README.md)

**What you will practice:**

- Creating modules with `contains`
- Selective imports with `use ... only`
- Controlling visibility with `public` and `private`
- Defining derived types with components
- Structure constructors
- Type-bound procedures
- Encapsulation with private components
- Multi-file `fpm` project structure

Exercises are ordered by difficulty. Try each on your own before checking
the solutions.

---

## Exercise 1 — Circle module ★

**Learning goal:** Write your first module with constants and functions.

Create a module named `circle_mod` that contains:

- A constant `pi` (use `parameter`).
- A function `circle_area(r)` that returns the area.
- A function `circle_circumference(r)` that returns the circumference.

Write a program that imports the module with `use ... only` and calls both
functions. Print the results for radius = 5.0.

---

## Exercise 2 — Selective imports ★

**Learning goal:** See why `use ... only` matters for readability.

Given a module that exports `mean`, `stddev`, and `variance`, write a
program that imports only `mean` and uses it. Then try to call `stddev`
without importing it — what error does the compiler give?

**Hint:** You can use the `stats_utils` module from the lesson examples,
or write your own with a single `mean` function.

---

## Exercise 3 — Public and private ★★

**Learning goal:** Hide implementation details with `private`.

Create a module `temperature_mod` with:

- A public function `celsius_to_fahrenheit(c)`.
- A public function `fahrenheit_to_celsius(f)`.
- A private helper function `scale_factor()` that returns `9.0 / 5.0`.

Write a program that uses the two public functions. Verify that calling
`scale_factor` directly causes a compile error.

---

## Exercise 4 — Point2D type ★★

**Learning goal:** Define a derived type with components and a standalone function.

Create a module `geometry_mod` that defines a derived type `point2d_t` with
`real` components `x` and `y`.

Add a function `distance(a, b)` that computes the Euclidean distance between
two points.

Write a program that creates two points, prints their coordinates, and
prints the distance between them.

**Test:** distance between (0, 0) and (3, 4) should be 5.0.

---

## Exercise 5 — Structure constructor ★★

**Learning goal:** Use named arguments to construct derived type values.

Using the `point2d_t` type from Exercise 4, create three points using the
structure constructor syntax:

```fortran
type(point2d_t) :: origin, p1, p2
origin = point2d_t(x=0.0, y=0.0)
```

Compute and print the distance from each point to the origin.

---

## Exercise 6 — Rectangle type with type-bound procedures ★★★

**Learning goal:** Attach procedures to a type with `contains` and `class`.

Create a module `rectangle_mod` with a derived type `rect_t` that has:

- Components: `width` and `height` (both `real`).
- Type-bound procedures: `area()` and `is_square()`.
- `is_square()` should return `.true.` if width equals height (within a
  small tolerance like 1.0e-6).

Write a program that creates two rectangles — one square and one
non-square — and calls both methods on each.

---

## Exercise 7 — Statistics module as an fpm project ★★

**Learning goal:** Build a multi-file fpm project with a module in `src/`.

Create a small fpm project from scratch:

```text
my-stats/
├── fpm.toml
├── src/
│   └── stats_utils.f90
└── app/
    └── main.f90
```

The module should provide `mean` and `stddev`. The main program should
import them and compute statistics on a test vector.

Build and run with `fpm run`.

---

## Exercise 8 — Counter with encapsulation ★★★

**Learning goal:** Use private components to enforce invariants.

Create a module `counter_mod` with a derived type `counter_t` whose
internal count is private.

Provide type-bound procedures:

- `increment()` — adds 1
- `add(n)` — adds `n`
- `get_value()` — returns the current count
- `reset()` — sets the count back to 0

Write a program that increments 3 times, adds 10, prints the value (13),
then resets and prints again (0).

---

## Exercise 9 — Interval type ★★★

**Learning goal:** Design a type with multiple type-bound procedures.

Create a module `interval_mod` with a type `interval_t` that has `lo` and
`hi` components (both `real`).

Add type-bound procedures:

- `width()` — returns `hi - lo`
- `contains_point(x)` — returns `.true.` if `lo <= x <= hi`
- `overlaps(other)` — returns `.true.` if two intervals share any points

Write a program that tests all three methods.

**Test values:**

- Interval [1.0, 5.0] has width 4.0.
- It contains 3.0 but not 6.0.
- It overlaps [4.0, 8.0] but not [6.0, 9.0].

---

## Exercise 10 — Refactor into a module ★★

**Learning goal:** Practice the mechanical step of moving code into a module.

Take the `vec_mean` and `vec_stddev` functions from
[Lesson 03](../../lessons/03-arrays-procedures/README.md) (which were defined
after `contains` in a `program`) and refactor them into a proper module.

Then write a program that uses the module. Verify the output is unchanged.

This exercise is about mechanical refactoring, not new logic.

---

## Reflection

After completing these exercises, think about:

- How does `private` / `public` affect your ability to change internals later?
- When is a type-bound procedure better than a standalone function in a module?
- How does `use ... only` help when you read code months later?

---

## Solutions

Worked solutions are in
[exercises/solutions/intermediate/](../solutions/intermediate/).
Each solution file name starts with `modules_`.
