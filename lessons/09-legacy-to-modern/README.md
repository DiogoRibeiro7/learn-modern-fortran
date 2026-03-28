# Lesson 09 — Legacy to modern

## Why this lesson matters

Many real Fortran programs were written over decades, often by teams working
under different language standards, compiler limits, and project pressures.
You do not need to mock that history to work effectively with it.

You do need to read old code without panic, recognize what is risky, and
improve it in ways that protect numerical behavior.

This lesson is about **reading and refactoring legacy Fortran**, not about
teaching legacy style as the default.

## What you should learn

- how older Fortran code often looks at first glance
- the practical difference between legacy patterns and modern style
- safe modernization steps that preserve behavior
- why numerical code needs extra care during refactoring

## Respect the context

Legacy Fortran systems often exist because they solved real problems well and
kept doing so for years. Some were written before modules, `fpm`, or modern
compiler tooling were widely available.

A respectful modernization mindset is:

- understand the code before changing it
- preserve behavior before improving structure
- measure results after each significant refactor
- prefer small safe steps over a dramatic rewrite

## High-level signs of older style

You may see some of these patterns in older codebases:

- files ending in `.f` or `.for` instead of `.f90`
- fixed-form layout with meaning attached to columns
- no `implicit none`
- shared state through `COMMON`
- subroutines and functions declared separately without modules
- long files containing many unrelated routines
- heavy use of global variables or hidden assumptions

None of these automatically makes a codebase bad. They do mean you should read
carefully before changing interfaces or data flow.

## Fixed-form vs free-form

At a high level:

- **fixed-form** is the older source layout, where columns matter
- **free-form** is the modern layout used in `.f90` and later files

Typical fixed-form features:

- statement text usually starts after column 6
- column 1 may be used for comments
- column 6 may be used for continuation
- long statements are harder to read and edit safely

Example of old fixed-form style:

```fortran
      PROGRAM AREA
      REAL RADIUS, AREA
      RADIUS = 2.0
      AREA = 3.14159 * RADIUS * RADIUS
      PRINT *, AREA
      END
```

The same idea in free-form:

```fortran
program area
  implicit none

  real :: radius
  real :: area_value

  radius = 2.0
  area_value = acos(-1.0) * radius * radius

  print *, area_value
end program area
```

What to notice:

- free-form does not depend on source columns
- names can be clearer
- `implicit none` forces declarations
- modern intrinsics can remove magic constants

## `COMMON` blocks vs modules

`COMMON` was an old way to share variables across program units.
It works, but it hides data flow and makes refactoring harder.

Legacy style:

```fortran
      REAL DT, TMAX
      COMMON /TIMECTRL/ DT, TMAX
```

Modern style prefers a module:

```fortran
module time_control
  implicit none
  private

  public :: dt
  public :: tmax

  real :: dt = 0.1
  real :: tmax = 10.0
end module time_control
```

Why modules are preferred now:

- they provide explicit interfaces naturally
- shared names come from a visible `use` statement
- `public` and `private` give better control
- declarations live in one place instead of being repeated exactly everywhere

Important caution:

When replacing a `COMMON` block, do not assume you understand its lifetime or
all its users after reading one file. Search the whole codebase first.

## Implicit typing vs `implicit none`

Older Fortran often relied on implicit typing rules:

- names starting with `I` through `N` defaulted to integer
- most other names defaulted to real

That saved typing decades ago. It now causes fragile code.

Legacy-style example:

```fortran
      PROGRAM TOTAL
      SUM = 0.0
      DO 10 I = 1, 5
         SUM = SUM + I
   10 CONTINUE
      AVREAGE = SUM / 5.0
      PRINT *, AVERAGE
      END
```

This code has a typo: `AVREAGE` and `AVERAGE` are different names.
Without `implicit none`, the compiler may accept both as implicitly typed reals.

Modern style:

```fortran
program total
  implicit none

  integer :: i
  real :: sum_value
  real :: average_value

  sum_value = 0.0

  do i = 1, 5
    sum_value = sum_value + real(i)
  end do

  average_value = sum_value / 5.0
  print *, average_value
end program total
```

What to notice:

- every variable is declared explicitly
- typos become compile-time errors
- the code says what each variable is for

## Older procedure organization vs modules

Older code often stored procedures in separate files without modules.
That can work, but it weakens interface checking.

Legacy style:

```fortran
      PROGRAM DRIVER
      REAL X(3), Y(3), DOT
      DATA X /1.0, 2.0, 3.0/
      DATA Y /4.0, 5.0, 6.0/
      DOT = DOTPROD(X, Y, 3)
      PRINT *, DOT
      END

      REAL FUNCTION DOTPROD(X, Y, N)
      INTEGER N, I
      REAL X(N), Y(N)
      DOTPROD = 0.0
      DO 20 I = 1, N
         DOTPROD = DOTPROD + X(I) * Y(I)
   20 CONTINUE
      END
```

Modern style:

```fortran
module vector_ops
  implicit none
  private

  public :: dot_product_safe

contains

  real function dot_product_safe(x, y) result(value)
    real, intent(in) :: x(:)
    real, intent(in) :: y(:)

    if (size(x) /= size(y)) then
      error stop "Vectors must have the same length."
    end if

    value = sum(x * y)
  end function dot_product_safe

end module vector_ops

program driver
  use vector_ops, only: dot_product_safe
  implicit none

  real :: x(3)
  real :: y(3)

  x = [1.0, 2.0, 3.0]
  y = [4.0, 5.0, 6.0]

  print *, dot_product_safe(x, y)
end program driver
```

What modules improve:

- interface checking
- argument intent
- reuse across many callers
- clearer separation between reusable logic and the driver program

## Three before/after modernization examples

These are not giant rewrites. They are controlled transformations.

### Example 1: fixed-form and implicit typing to free-form and explicit declarations

Before:

```fortran
      PROGRAM ENERGY
      MASS = 2.0
      VELOC = 3.0
      KE = 0.5 * MASS * VELOC * VELOC
      PRINT *, KE
      END
```

After:

```fortran
program energy
  implicit none

  real :: mass
  real :: velocity
  real :: kinetic_energy

  mass = 2.0
  velocity = 3.0
  kinetic_energy = 0.5 * mass * velocity * velocity

  print *, kinetic_energy
end program energy
```

Safe change:

- move to free-form layout
- add `implicit none`
- declare variables without changing the arithmetic

### Example 2: `COMMON` block to module data

Before:

```fortran
      PROGRAM DRIVER
      REAL DT, TMAX
      COMMON /TIMECTRL/ DT, TMAX
      DT = 0.1
      TMAX = 1.0
      CALL RUN()
      END

      SUBROUTINE RUN()
      REAL DT, TMAX, T
      COMMON /TIMECTRL/ DT, TMAX
      T = 0.0
   10 IF (T .LT. TMAX) THEN
         PRINT *, T
         T = T + DT
         GOTO 10
      END IF
      END
```

After:

```fortran
module time_control
  implicit none
  private

  public :: dt
  public :: tmax

  real :: dt = 0.1
  real :: tmax = 1.0
end module time_control

module runner
  use time_control, only: dt, tmax
  implicit none
  private

  public :: run

contains

  subroutine run()
    real :: t

    t = 0.0
    do while (t < tmax)
      print *, t
      t = t + dt
    end do
  end subroutine run

end module runner

program driver
  use runner, only: run
  implicit none

  call run()
end program driver
```

Safe change:

- move shared variables into one module
- replace `GOTO` loop control with `do while`
- keep the same time-stepping behavior before deeper redesign

### Example 3: external procedure to module procedure with explicit interface

Before:

```fortran
      PROGRAM SCALEIT
      REAL X(3)
      DATA X /1.0, 2.0, 3.0/
      CALL SCALE(X, 3, 10.0)
      PRINT *, X
      END

      SUBROUTINE SCALE(X, N, FACTOR)
      INTEGER N, I
      REAL X(N), FACTOR
      DO 10 I = 1, N
         X(I) = X(I) * FACTOR
   10 CONTINUE
      END
```

After:

```fortran
module scaling
  implicit none
  private

  public :: scale_vector

contains

  subroutine scale_vector(x, factor)
    real, intent(inout) :: x(:)
    real, intent(in) :: factor

    x = x * factor
  end subroutine scale_vector

end module scaling

program scaleit
  use scaling, only: scale_vector
  implicit none

  real :: x(3)

  x = [1.0, 2.0, 3.0]
  call scale_vector(x, 10.0)
  print *, x
end program scaleit
```

Safe change:

- keep the same mathematical operation
- remove manual length handling when assumed-shape is enough
- make data flow explicit through `intent(inout)`

## Safe modernization patterns

Good first refactors:

- convert fixed-form files to free-form one file at a time
- add `implicit none`
- introduce tests before major structural changes when possible
- move external procedures into modules
- replace `COMMON` with modules after mapping every use site
- separate reusable numerical logic from printing and file I/O

Changes to delay until later:

- changing floating-point kinds everywhere
- changing loop order in performance-sensitive kernels
- replacing all control flow at once
- mixing style cleanup with algorithm changes

## Risks when changing legacy numerical code

Numerical software can change behavior even when the code looks "cleaner."
Be careful with:

- **evaluation order**: algebraically equivalent expressions can round differently
- **precision changes**: moving from one kind or compiler default to another may shift results
- **loop restructuring**: reordering sums can change floating-point accumulation error
- **hidden state**: `COMMON`, `SAVE`, and shared arrays may affect many routines
- **I/O formats**: changing read or write formats can break downstream workflows
- **boundary assumptions**: old code may rely on exact array sizes, indexing patterns, or sentinel values

Practical rule:

When modernizing numerical code, treat "same numbers within acceptable tolerance"
as a requirement you check, not an assumption you make.

## A short modernization checklist

Before editing:

- identify the input data, outputs, and expected behavior
- find existing tests, sample runs, or trusted output files
- search for every use of shared variables and external procedures

During modernization:

- change one concern at a time
- keep numerical formulas unchanged unless that is the explicit task
- compile and run after each small step
- record any intended behavior changes clearly

After each change:

- compare outputs against a known baseline
- use tolerance-aware checks for floating-point results
- review whether interfaces became clearer and safer

## A practical modernization sequence

For a real legacy codebase, a reasonable order is:

1. get the original code compiling and running
2. capture baseline outputs for small trusted cases
3. add `implicit none` and missing declarations
4. convert fixed-form files to free-form
5. move reusable routines into modules
6. replace `COMMON` with module data or explicit arguments
7. add tests around numerical kernels
8. only then consider deeper redesign

## Suggested practice

- take a short fixed-form example and rewrite it in free-form without changing the math
- replace one `COMMON` block with a module and verify the outputs stay the same
- move one external function into a module and add `intent` declarations
- explain which modernization changes are structural and which might change results

## Key takeaways

- legacy Fortran is part of real engineering work, not something to dismiss
- modern style improves readability, checking, and maintainability
- the safest modernization strategy is incremental
- numerical behavior must be validated after each important refactor
- modules, `implicit none`, and free-form source are good defaults today

## Suggested next step

Return to the `examples/` and `projects/` folders and notice how their modern
structure avoids many of the risks shown here.
