# Lesson 03 — Arrays, control flow, and procedures

## Learning objectives

By the end of this lesson you will be able to:

- Declare and initialize one-dimensional and two-dimensional arrays.
- Use array constructors, slicing, and intrinsic functions.
- Write element-wise operations without explicit loops.
- Use `do`, `do while`, `exit`, and `cycle` for looping.
- Use `if`/`else` and `select case` for branching.
- Write functions that return a value and subroutines that modify arguments.
- Explain the difference between `intent(in)`, `intent(out)`, and `intent(inout)`.
- Explain why explicit interfaces matter and how internal procedures provide them.

---

## The idea in one paragraph

Fortran was designed for numerical work, and arrays are where that shows most
clearly. Arithmetic on whole arrays works without loops, intrinsic functions
like `sum` and `maxval` operate on entire vectors in a single call, and the
compiler can optimize array operations aggressively. When you do need loops,
Fortran's `do` construct is straightforward. Procedures — functions and
subroutines — let you break programs into reusable pieces. Together, arrays
and procedures form the backbone of every serious Fortran program.

---

## One-dimensional arrays

An array holds a fixed number of values of the same type. You declare it with
its size in parentheses and fill it with an array constructor `[...]`.

```fortran
program array_1d
  implicit none

  real :: temps(5)
  integer :: i

  temps = [18.2, 21.5, 19.7, 22.1, 20.3]

  print *, "All temperatures:", temps
  print *, "First:           ", temps(1)
  print *, "Last:            ", temps(5)
  print *, "Count:           ", size(temps)
end program array_1d
```

Fortran arrays are **1-indexed** by default. `temps(1)` is the first element,
not `temps(0)`. This matches how scientists number things and avoids
off-by-one errors common in 0-indexed languages.

---

## Array constructors

The `[...]` syntax builds an array literal. For patterns, use an **implied
do loop** — a compact way to generate a sequence.

```fortran
program constructors
  implicit none

  integer :: i
  real :: squares(10)
  real :: zeros(5)
  integer :: evens(6)

  ! Implied do loop: generates [1, 4, 9, 16, ..., 100]
  squares = [(real(i ** 2), i = 1, 10)]

  ! Scalar broadcast: every element set to the same value
  zeros = 0.0

  ! Implied do with step: generates [2, 4, 6, 8, 10, 12]
  evens = [(i, i = 2, 12, 2)]

  print *, "Squares:", squares
  print *, "Zeros:  ", zeros
  print *, "Evens:  ", evens
end program constructors
```

The implied do loop `[(expr, i = start, end, step)]` is the standard way to
build arrays from a formula. The step is optional and defaults to 1.

---

## Array slicing

Fortran supports slicing with `start:end` and `start:end:step` notation.
A slice selects a contiguous (or strided) portion of an array.

```fortran
program slicing
  implicit none

  integer :: v(10), i

  v = [(i, i = 1, 10)]

  print *, "All:     ", v
  print *, "First 3: ", v(1:3)       ! [1, 2, 3]
  print *, "Last 3:  ", v(8:10)      ! [8, 9, 10]
  print *, "Evens:   ", v(2:10:2)    ! [2, 4, 6, 8, 10]
  print *, "Reversed:", v(10:1:-1)   ! [10, 9, ..., 1]
end program slicing
```

Slices produce a **new array** (a copy). Modifying a slice does not change
the original.

---

## Element-wise operations

Arithmetic on arrays works element by element, just like NumPy or MATLAB.
The compiler handles the loop internally, and the code reads cleanly.

```fortran
program elementwise
  implicit none

  real :: a(4), b(4), c(4)

  a = [1.0, 2.0, 3.0, 4.0]
  b = [10.0, 20.0, 30.0, 40.0]

  c = a + b           ! [11.0, 22.0, 33.0, 44.0]
  print *, "a + b =", c

  c = a * b           ! [10.0, 40.0, 90.0, 160.0]
  print *, "a * b =", c

  c = 2.0 * a + 1.0   ! [3.0, 5.0, 7.0, 9.0]
  print *, "2a+1  =", c

  ! Intrinsic functions also work element-wise
  c = sqrt(a)         ! [1.0, 1.414, 1.732, 2.0]
  print *, "sqrt  =", c
end program elementwise
```

This is one of Fortran's core strengths. You express the mathematics directly
and let the compiler decide how to execute it efficiently. For simple
operations, prefer array expressions over explicit loops.

---

## Intrinsic array functions

Fortran provides a rich set of built-in functions that operate on whole arrays.

```fortran
program intrinsics
  implicit none

  real :: x(6)

  x = [3.0, 1.0, 4.0, 1.0, 5.0, 9.0]

  print *, "sum    =", sum(x)        ! 23.0
  print *, "product=", product(x)    ! 540.0
  print *, "minval =", minval(x)     ! 1.0
  print *, "maxval =", maxval(x)     ! 9.0
  print *, "size   =", size(x)       ! 6
  print *, "count>3=", count(x > 3.0) ! 3
end program intrinsics
```

Other useful intrinsics to know:

| Function | What it does |
| -------- | ------------ |
| `dot_product(a, b)` | Dot product of two vectors |
| `matmul(a, b)` | Matrix multiplication |
| `reshape(source, shape)` | Change array dimensions |
| `any(mask)` | `.true.` if any element is `.true.` |
| `all(mask)` | `.true.` if every element is `.true.` |
| `pack(array, mask)` | Extract elements that satisfy a condition |

These functions replace many loops you would write by hand in C or Python.

---

## Two-dimensional arrays

A 2D array is declared with two sizes. Fortran stores 2D arrays in
**column-major** order: elements in the same column are contiguous in memory.

```fortran
program arrays_2d
  implicit none

  real :: mat(3, 4)
  integer :: i, j

  ! Fill: mat(i,j) = 10*i + j
  do j = 1, 4
    do i = 1, 3
      mat(i, j) = real(10 * i + j)
    end do
  end do

  print *, "Row 1:   ", mat(1, :)     ! [11, 12, 13, 14]
  print *, "Column 2:", mat(:, 2)     ! [12, 22, 32]
  print *, "Rows:    ", size(mat, 1)  ! 3
  print *, "Columns: ", size(mat, 2)  ! 4

  ! reshape builds a 2D array from a flat list
  mat = reshape([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, &
                 7.0, 8.0, 9.0, 10.0, 11.0, 12.0], [3, 4])
  print *, "After reshape, row 1:", mat(1, :)
end program arrays_2d
```

**Column-major performance rule:** when looping over a 2D array, the inner
loop should vary the **first** (row) index. This accesses memory sequentially.
The example above follows this rule — `i` varies in the inner loop, `j` in
the outer.

---

## Loops — `do`

The `do` loop is Fortran's basic counted loop.

```fortran
program do_loops
  implicit none

  integer :: i, total
  real :: values(5)

  ! Basic counted loop
  values = [2.0, 4.0, 6.0, 8.0, 10.0]
  total = 0
  do i = 1, 5
    total = total + int(values(i))
  end do
  print *, "Sum (loop):", total

  ! Loop with step
  print *, "Countdown:"
  do i = 10, 1, -2
    print *, i
  end do

  ! Nested loops — multiplication table
  print *, "3x3 products:"
  do i = 1, 3
    print *, (i * 1), (i * 2), (i * 3)
  end do
end program do_loops
```

The counted `do` loop runs from start to end with an optional step.
Negative steps count downward. The loop variable is read-only inside the
loop body — you cannot reassign `i`.

### `exit` and `cycle`

`exit` breaks out of a loop immediately. `cycle` skips to the next iteration.

```fortran
! Find the first value greater than 100
do i = 1, size(data)
  if (data(i) > 100.0) exit
end do

! Sum only positive values
total = 0.0
do i = 1, size(data)
  if (data(i) <= 0.0) cycle
  total = total + data(i)
end do
```

---

## Loops — `do while`

A `do while` loop runs as long as a condition is true. Use it when you do
not know the number of iterations in advance.

```fortran
program do_while_demo
  implicit none

  integer :: n, steps

  ! Find the smallest power of 2 that exceeds 1000
  n = 1
  steps = 0
  do while (n <= 1000)
    n = n * 2
    steps = steps + 1
  end do

  print *, "Result:", n       ! 1024
  print *, "Steps: ", steps   ! 10
end program do_while_demo
```

The condition is checked **before** each iteration. If the condition is false
on the first check, the loop body never runs.

---

## Conditionals — `if`/`else`

Fortran's `if` construct evaluates a logical expression and executes the
matching branch.

```fortran
program conditionals
  implicit none

  real :: score
  character(len=2) :: grade

  score = 85.0

  if (score >= 90.0) then
    grade = "A"
  else if (score >= 80.0) then
    grade = "B"
  else if (score >= 70.0) then
    grade = "C"
  else
    grade = "F"
  end if

  print *, "Score:", score, " Grade:", grade
end program conditionals
```

### `select case`

When branching on discrete values, `select case` is cleaner than chained `if`:

```fortran
integer :: month
month = 3

select case (month)
case (1)
  print *, "January"
case (2)
  print *, "February"
case (3:5)       ! range: March through May
  print *, "Spring"
case (12)
  print *, "December"
case default
  print *, "Other"
end select
```

`select case` works with integers, characters, and logical values — not reals.

---

## Functions

A function computes and returns a single value. Arguments declared with
`intent(in)` are read-only — the function promises not to modify them.

The following function computes the mean of a real vector. It accepts any
array size through the assumed-shape argument `x(:)`.

```fortran
program function_demo
  implicit none

  real :: data(6)

  data = [2.0, 4.0, 4.0, 4.0, 5.0, 5.0]

  print *, "Data:", data
  print *, "Mean:", vec_mean(data)
  print *, "Norm:", euclidean_norm(data)

contains

  real function vec_mean(x)
    real, intent(in) :: x(:)

    vec_mean = sum(x) / real(size(x))
  end function vec_mean

  real function euclidean_norm(x) result(value)
    real, intent(in) :: x(:)

    value = sqrt(sum(x * x))
  end function euclidean_norm

end program function_demo
```

Two function styles are shown: in `vec_mean` the function name is the result
variable; in `euclidean_norm` a `result(value)` clause gives the return
variable a separate name. Both are equivalent.

---

## Subroutines

A subroutine does not return a value. It communicates through its arguments
using `intent(out)` or `intent(inout)`.

This subroutine normalizes a vector in place. The argument is `intent(inout)`
because it is both read and written.

```fortran
program subroutine_demo
  implicit none

  real :: v(4)

  v = [3.0, 4.0, 0.0, 0.0]
  print *, "Before:", v

  call normalize(v)
  print *, "After: ", v
  print *, "Norm:  ", sqrt(sum(v * v))   ! should be ~1.0

contains

  subroutine normalize(x)
    real, intent(inout) :: x(:)
    real :: n

    n = sqrt(sum(x * x))
    if (n > 0.0) x = x / n
  end subroutine normalize

end program subroutine_demo
```

After normalization, `v` has the same direction but a length (norm) of 1.0.
Subroutines are invoked with `call`.

---

## Intent — the full picture

`intent` tells the compiler how each argument will be used. It catches bugs
at compile time and makes the code self-documenting.

| Intent | Meaning | When to use |
| ------ | ------- | ----------- |
| `intent(in)` | Read-only | Function inputs, data you only need to inspect |
| `intent(out)` | Write-only | Values the procedure creates and returns through arguments |
| `intent(inout)` | Read and write | Data the procedure modifies in place |

This subroutine uses all three intents to compute the mean and variance of
a vector.

```fortran
program intent_demo
  implicit none

  real :: data(5)
  real :: m, v

  data = [10.0, 20.0, 30.0, 40.0, 50.0]

  call mean_and_variance(data, m, v)
  print *, "Mean:    ", m    ! 30.0
  print *, "Variance:", v    ! 200.0

contains

  subroutine mean_and_variance(x, mean_out, var_out)
    real, intent(in) :: x(:)          ! read-only input
    real, intent(out) :: mean_out     ! result: mean
    real, intent(out) :: var_out      ! result: variance

    mean_out = sum(x) / real(size(x))
    var_out = sum((x - mean_out) ** 2) / real(size(x))
  end subroutine mean_and_variance

end program intent_demo
```

**Always declare intent.** If you forget `intent(in)` on a function argument
and accidentally modify it, the compiler will not warn you — but with intent
declared, it becomes a compile-time error.

---

## Internal procedures and why interfaces matter

Procedures placed after `contains` inside a `program` are called **internal
procedures**. The compiler can see their full signature — argument types,
intents, and return type. This is called having an **explicit interface**.

With an explicit interface, the compiler checks:

- number of arguments
- types of each argument
- array shapes

If any of these are wrong, you get a compile-time error instead of a runtime
crash.

```fortran
program interface_demo
  implicit none

  print *, "Double of 5:", double(5)
  ! print *, double(5.0)   ! compile error: wrong type
  ! print *, double(5, 3)  ! compile error: wrong number of arguments

contains

  integer function double(n)
    integer, intent(in) :: n
    double = n * 2
  end function double

end program interface_demo
```

The compiler rejects wrong calls because it can see the interface.
Without an explicit interface (for example, calling a procedure in a separate
file without a module), the compiler cannot check and you get undefined
behavior. This is why **modules** (covered in Lesson 04) are the standard
way to organize reusable procedures.

---

## Loops vs array expressions — when to use which

Fortran gives you two ways to operate on arrays:

```fortran
program loop_vs_expression
  implicit none

  real :: x(5), y(5)
  integer :: i

  x = [1.0, 2.0, 3.0, 4.0, 5.0]

  ! Array expression — concise and clear
  y = x ** 2 + 1.0
  print *, "Expression:", y

  ! Explicit loop — equivalent but more verbose
  do i = 1, 5
    y(i) = x(i) ** 2 + 1.0
  end do
  print *, "Loop:      ", y
end program loop_vs_expression
```

**Prefer array expressions** when the operation is a simple element-wise
formula. The code is shorter, the intent is clearer, and the compiler can
optimize it freely.

**Use explicit loops** when:

- the computation for element `i` depends on element `i-1` (recurrence)
- you need `exit` or `cycle` to stop early
- the logic involves conditionals that differ per element and `where` is not enough

---

## Putting it together — vector statistics

This example ties together arrays, intrinsic functions, an explicit loop,
functions, and a subroutine to build a small statistics toolkit.

```fortran
program vector_statistics
  implicit none

  real :: data(8)
  real :: mean_val, std_val, min_val, max_val
  integer :: n_positive

  data = [4.0, -2.0, 7.0, 1.0, -3.0, 8.0, 5.0, 0.0]

  mean_val = vec_mean(data)
  std_val = vec_stddev(data)
  call find_extremes(data, min_val, max_val)
  n_positive = count_positive(data)

  print '(A, F8.3)', "Mean:      ", mean_val
  print '(A, F8.3)', "Std dev:   ", std_val
  print '(A, F8.3)', "Min:       ", min_val
  print '(A, F8.3)', "Max:       ", max_val
  print '(A, I4)',   "# positive:", n_positive

contains

  real function vec_mean(x)
    real, intent(in) :: x(:)
    vec_mean = sum(x) / real(size(x))
  end function vec_mean

  real function vec_stddev(x)
    real, intent(in) :: x(:)
    real :: m
    m = vec_mean(x)
    vec_stddev = sqrt(sum((x - m) ** 2) / real(size(x)))
  end function vec_stddev

  subroutine find_extremes(x, lo, hi)
    real, intent(in) :: x(:)
    real, intent(out) :: lo, hi
    lo = minval(x)
    hi = maxval(x)
  end subroutine find_extremes

  integer function count_positive(x)
    real, intent(in) :: x(:)
    integer :: i

    count_positive = 0
    do i = 1, size(x)
      if (x(i) > 0.0) count_positive = count_positive + 1
    end do
  end function count_positive

end program vector_statistics
```

This program prints a five-line summary of the data. It demonstrates functions
for values that are naturally a single return value (mean, standard deviation,
count) and a subroutine for returning two values at once (min and max). The
`count_positive` function uses an explicit loop because the counting logic
requires per-element conditional logic — though `count(x > 0.0)` would also
work here and is simpler.

---

## Running the companion example

A runnable `fpm` project demonstrating these concepts is at
`examples/arrays-procedures/`:

```bash
cd examples/arrays-procedures
fpm run
```

A more complete module-based version with tests is at `examples/vector-ops/`.

---

## Exercises

This lesson maps to three exercise sets:

- [02-control-flow.md](../../exercises/beginner/02-control-flow.md)
- [03-arrays.md](../../exercises/beginner/03-arrays.md)
- [04-procedures.md](../../exercises/beginner/04-procedures.md)

---

## Key takeaways

- Arrays are first-class in Fortran — declare with a size, fill with `[...]`.
- Use implied do loops `[(expr, i = start, end)]` to build arrays from patterns.
- Prefer element-wise expressions over explicit loops for simple math.
- Use `sum`, `maxval`, `minval`, `size`, `count` instead of writing loops.
- Fortran arrays are 1-indexed and stored in column-major order.
- `do` for counted loops, `do while` for condition-based loops.
- `exit` breaks a loop, `cycle` skips an iteration.
- `if`/`else` for branching, `select case` for discrete values.
- Functions return one value. Subroutines communicate through arguments.
- Always declare `intent(in)`, `intent(out)`, or `intent(inout)`.
- Internal procedures (after `contains`) give the compiler an explicit interface.

---

## Next step

Move to [Lesson 04 — Modules and derived types](../04-modules-types/README.md)
to learn how to organize procedures into reusable modules.
