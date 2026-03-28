# Lesson 02 — Types, variables, and expressions

## Learning objectives

By the end of this lesson you will be able to:

- Declare variables of all four common intrinsic types.
- Explain the difference between `integer`, `real`, `logical`, and `character`.
- Use `parameter` to define named constants.
- Write arithmetic expressions and predict their results.
- Use relational and logical operators.
- Explain why integer division truncates and how to avoid it.
- Choose a numeric kind for the precision you need.
- Print output with both list-directed and simple formatted styles.

---

## The idea in one paragraph

Every value in a Fortran program has a type. The type determines what the value
looks like in memory, what operations are valid, and how it prints. Fortran has
five intrinsic types — `integer`, `real`, `complex`, `logical`, and
`character` — but you can get very far with just four. This lesson teaches you
each type, how to declare and assign variables, how to build expressions, and
how to print results clearly.

---

## Integer

An `integer` holds a whole number with no fractional part.

```fortran
program integer_demo
  implicit none

  integer :: apples, oranges, total

  apples = 12
  oranges = 7
  total = apples + oranges

  print *, "Apples: ", apples
  print *, "Oranges:", oranges
  print *, "Total:  ", total
end program integer_demo
```

Expected output:

```text
 Apples:           12
 Oranges:           7
 Total:            19
```

Common integer operations: `+`, `-`, `*`, `/`, `**` (power), `mod(a, b)` (remainder).

---

## Real

A `real` holds a number with a fractional part (a floating-point number).

```fortran
program real_demo
  implicit none

  real :: mass, velocity, kinetic_energy

  mass = 2.5
  velocity = 10.0
  kinetic_energy = 0.5 * mass * velocity ** 2

  print *, "Mass:           ", mass
  print *, "Velocity:       ", velocity
  print *, "Kinetic energy: ", kinetic_energy
end program real_demo
```

Expected output:

```text
 Mass:              2.50000000
 Velocity:          10.0000000
 Kinetic energy:    125.000000
```

Real literals must include a decimal point: `10.0`, not `10`. Writing `10`
gives you an integer, which changes how arithmetic works (see the integer
division section below).

---

## Logical

A `logical` holds `.true.` or `.false.`. The dots are required.

```fortran
program logical_demo
  implicit none

  logical :: is_raining, has_umbrella, will_get_wet

  is_raining = .true.
  has_umbrella = .false.
  will_get_wet = is_raining .and. (.not. has_umbrella)

  print *, "Raining:     ", is_raining
  print *, "Has umbrella:", has_umbrella
  print *, "Gets wet:    ", will_get_wet
end program logical_demo
```

Expected output:

```text
 Raining:      T
 Has umbrella: F
 Gets wet:     T
```

Fortran prints `.true.` as `T` and `.false.` as `F` in list-directed output.

---

## Character

A `character` variable holds a fixed-length string. You must specify the
maximum length with `len=`.

```fortran
program character_demo
  implicit none

  character(len=10) :: first, last
  character(len=30) :: full

  first = "Grace"
  last = "Hopper"

  ! Concatenation uses the // operator.
  ! trim() removes trailing spaces from a fixed-length string.
  full = trim(first) // " " // trim(last)

  print *, "First:", first          ! padded to 10 characters
  print *, "Last: ", last
  print *, "Full: ", trim(full)     ! trimmed
end program character_demo
```

Expected output:

```text
 First:Grace
 Last: Hopper
 Full: Grace Hopper
```

**What to notice:**

- A `character(len=10)` variable always occupies 10 characters. Shorter strings
  are padded with spaces on the right.
- Use `trim()` to remove the padding before concatenation or printing.
- The `//` operator joins strings end to end.

---

## Declaration rules

All declarations go between `implicit none` and the first executable statement.
Once the first executable line runs, you cannot declare more variables.

```fortran
program declaration_rules
  implicit none

  ! Declarations go here
  integer :: a, b, c         ! multiple variables on one line
  real :: x = 1.5            ! declaration with initialization
  character(len=5) :: tag

  ! Executable statements start here
  a = 1
  b = 2
  c = a + b
  tag = "hello"

  print *, c, x, tag
end program declaration_rules
```

The `::` is required when you use any attribute (`parameter`, initialization,
`intent`, etc.). It is good practice to use `::` always for consistency.

---

## Constants with `parameter`

A `parameter` is a named constant. The compiler forbids changing its value
after the declaration.

```fortran
program constants_demo
  implicit none

  real, parameter :: pi = 3.14159265
  real, parameter :: e  = 2.71828183
  integer, parameter :: max_iterations = 1000

  real :: radius, area

  radius = 5.0
  area = pi * radius ** 2

  print *, "pi =", pi
  print *, "Radius:", radius
  print *, "Area:  ", area
  print *, "Max iterations:", max_iterations
end program constants_demo
```

Use `parameter` for values that should never change: mathematical constants,
physical constants, configuration limits. If you accidentally try to assign to
a parameter, the compiler reports an error immediately.

---

## Kind selection — choosing your precision

The default `real` is typically 32-bit (about 7 decimal digits). For scientific
work you almost always need 64-bit (about 15 decimal digits).

Fortran controls precision through a mechanism called **kind**. Each numeric
type can have multiple kinds that differ in size and range.

The portable way to request a specific kind is through `iso_fortran_env`:

```fortran
program kind_demo
  use iso_fortran_env, only: int32, int64, real32, real64
  implicit none

  integer(int32) :: small_int
  integer(int64) :: big_int
  real(real32) :: low_precision
  real(real64) :: high_precision

  small_int = 100
  big_int = 10000000000_int64

  low_precision  = 1.0 / 3.0
  high_precision = 1.0_real64 / 3.0_real64

  print *, "small_int:      ", small_int
  print *, "big_int:        ", big_int
  print *, "low_precision:  ", low_precision
  print *, "high_precision: ", high_precision
end program kind_demo
```

Expected output:

```text
 small_int:                100
 big_int:          10000000000
 low_precision:     0.333333343
 high_precision:    0.33333333333333331
```

**What to notice:**

- `real32` gives roughly 7 digits. `real64` gives roughly 15 digits.
- Literal constants need the kind suffix: `1.0_real64`. Without it, the literal
  is computed in default (32-bit) precision and then stored in the 64-bit
  variable — you lose precision before the assignment even happens.
- `int64` is needed for integers larger than about 2 billion.

A simple rule for scientific code: **use `real64` unless you have a reason not to.**

---

## Arithmetic operators

| Operator | Meaning | Example | Result |
| -------- | ------- | ------- | ------ |
| `+` | addition | `3 + 4` | `7` |
| `-` | subtraction | `10 - 3` | `7` |
| `*` | multiplication | `5 * 6` | `30` |
| `/` | division | `15.0 / 4.0` | `3.75` |
| `**` | exponentiation | `2 ** 10` | `1024` |

Precedence from highest to lowest: `**`, then `* /`, then `+ -`.
Use parentheses to make the order explicit when in doubt.

### The `mod` function

`mod(a, b)` returns the remainder of dividing `a` by `b`:

```fortran
print *, mod(17, 5)    ! 2
print *, mod(20, 4)    ! 0
```

---

## Integer division — the biggest beginner trap

When both operands are integers, Fortran performs integer division and
**truncates toward zero**. No rounding. No warning.

```fortran
program division_demo
  implicit none

  integer :: a, b
  real :: x

  a = 7
  b = 2

  print *, "7 / 2           =", a / b             ! 3, not 3.5
  print *, "7.0 / 2.0       =", 7.0 / 2.0         ! 3.5
  print *, "real(7) / real(2)=", real(a) / real(b)  ! 3.5

  ! A common bug: assigning integer division to a real variable
  x = 7 / 2            ! computed as 3, then converted to 3.0
  print *, "x = 7 / 2  gives", x
end program division_demo
```

Expected output:

```text
 7 / 2           =           3
 7.0 / 2.0       =   3.50000000
 real(7) / real(2)=   3.50000000
 x = 7 / 2  gives   3.00000000
```

**The rule:** if you want a decimal result, make at least one operand a real —
either by using a literal with a decimal point (`7.0 / 2`) or by converting
with `real()`.

---

## Relational operators

Relational operators compare two values and produce a `logical` result.

| Operator | Meaning |
| -------- | ------- |
| `==` | equal to |
| `/=` | not equal to |
| `<` | less than |
| `>` | greater than |
| `<=` | less than or equal to |
| `>=` | greater than or equal to |

```fortran
program relational_demo
  implicit none

  integer :: a, b

  a = 10
  b = 20

  print *, "a == b:", a == b     ! F
  print *, "a /= b:", a /= b    ! T
  print *, "a < b: ", a < b     ! T
  print *, "a >= b:", a >= b    ! F
end program relational_demo
```

Note that Fortran uses `/=` for "not equal," not `!=`.

---

## Logical operators

Logical operators combine or negate `logical` values.

| Operator | Meaning | Example | Result |
| -------- | ------- | ------- | ------ |
| `.and.` | both true | `.true. .and. .false.` | `.false.` |
| `.or.` | at least one true | `.true. .or. .false.` | `.true.` |
| `.not.` | negation | `.not. .true.` | `.false.` |
| `.eqv.` | both same | `.true. .eqv. .false.` | `.false.` |
| `.neqv.` | both different | `.true. .neqv. .false.` | `.true.` |

You can combine relational and logical operators:

```fortran
program combined_logic
  implicit none

  integer :: age
  logical :: has_ticket, can_enter

  age = 25
  has_ticket = .true.

  can_enter = (age >= 18) .and. has_ticket
  print *, "Can enter:", can_enter    ! T
end program combined_logic
```

---

## Output — list-directed vs formatted

### List-directed output (`print *`)

```fortran
print *, "x =", x
```

The compiler chooses the field widths and decimal places. Simple and useful
for debugging, but the alignment is unpredictable.

### Formatted output (`print '(format)'`)

You can control the layout with a format string:

```fortran
program formatted_demo
  implicit none

  integer :: i
  real :: x
  character(len=10) :: name

  i = 42
  x = 3.14159
  name = "Fortran"

  ! Format descriptors:
  !   A   = character string
  !   I4  = integer, 4 characters wide
  !   F8.3 = real, 8 characters wide, 3 decimal places
  print '(A, I4)',    "Integer:   ", i
  print '(A, F8.3)',  "Real:      ", x
  print '(A, A)',     "Name:      ", trim(name)
end program formatted_demo
```

Expected output:

```text
Integer:     42
Real:        3.142
Name:      Fortran
```

**Common format descriptors:**

| Descriptor | Meaning | Example output |
| ---------- | ------- | -------------- |
| `I5` | Integer, 5 characters wide | 42 right-aligned in 5 columns |
| `F8.2` | Real, 8 wide, 2 decimals | 3.14 right-aligned in 8 columns |
| `E12.4` | Scientific notation, 12 wide, 4 decimals | 0.3142E+01 |
| `A` | Character string (auto width) | hello |
| `A10` | Character string, 10 wide | hello padded to 10 |
| `1X` | One blank space | (one space) |
| `/` | New line | (line break) |

You do not need to memorize these now. The important idea is that Fortran gives
you precise control over output layout when you need it. `print *` is fine for
learning.

---

## What beginners usually get wrong

### 1. Integer division surprise

`7 / 2` gives `3`, not `3.5`. This is the single most common source of wrong
answers in beginner Fortran programs. Make one operand real: `7.0 / 2` or
`real(a) / real(b)`.

### 2. Forgetting `implicit none`

Without it, a misspelled variable name silently creates a new variable with
the wrong type. The program compiles and produces wrong results. Always include
`implicit none` — there is no exception.

### 3. Missing kind suffix on real literals

```fortran
real(real64) :: x
x = 1.0 / 3.0           ! WRONG: 1.0 and 3.0 are 32-bit
x = 1.0_real64 / 3.0_real64  ! correct: full 64-bit precision
```

The division happens at the precision of the operands, not the variable being
assigned to. By the time the result is stored in `x`, the precision is already
lost.

### 4. Confusing `=` and `==`

`=` is assignment. `==` is comparison. Writing `if (x = 5)` is a compilation
error in Fortran (unlike C, where it would silently compile). Fortran catches
this one for you, but it still confuses beginners reading error messages.

### 5. Forgetting `trim()` when concatenating strings

```fortran
character(len=10) :: a, b
a = "Hello"
b = "World"
print *, a // b       ! "Hello     World     " — 10 extra spaces
print *, trim(a) // " " // trim(b)  ! "Hello World"
```

Fixed-length character variables are padded with spaces. Always `trim()` before
concatenation.

### 6. Using `.f` instead of `.f90`

Files ending in `.f` are treated as fixed-form source (the 1960s column
layout). Use `.f90` for all modern Fortran code.

---

## Running the companion example

A runnable `fpm` project demonstrating the concepts from this lesson is at
`examples/basics/`:

```bash
cd examples/basics
fpm run
```

---

## Exercises

See [exercises/beginner/01-basics.md](../../exercises/beginner/01-basics.md)
for practice problems based on this lesson.

---

## Key takeaways

- Fortran has four common types: `integer`, `real`, `logical`, `character`.
- Use `::` in every declaration. Put all declarations before executable code.
- Use `parameter` for named constants that must never change.
- Integer division truncates — cast with `real()` or use decimal literals.
- Relational operators produce logical values: `==`, `/=`, `<`, `>`, `<=`, `>=`.
- Logical operators combine them: `.and.`, `.or.`, `.not.`.
- `print *` is fine for learning. `print '(format)'` gives you precise control.
- Use `real64` from `iso_fortran_env` for scientific work. Add the `_real64`
  suffix to every literal.

---

## Next step

Move to [Lesson 03 — Arrays and procedures](../03-arrays-procedures/README.md).
