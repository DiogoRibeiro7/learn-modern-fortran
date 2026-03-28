# Style Guide

This guide keeps contributions consistent across code, lessons, examples,
exercises, and projects. It is intentionally practical rather than exhaustive.

## Principles

- teach modern Fortran by default
- optimize for clarity before cleverness
- keep examples small enough to read in one pass
- separate reusable logic from driver programs
- prefer consistency across the repository over personal style

## Fortran code style

### Source form and layout

- use free-form source
- use `.f90` file names
- use spaces for indentation, not tabs
- use two-space indentation inside programs, modules, procedures, loops, and conditionals
- leave a blank line between logical sections when it improves readability

### Required defaults

- always use `implicit none`
- prefer modules for reusable logic
- keep executable `program` files thin and move logic into `src/` modules when appropriate
- use `use ..., only:` for imports

### Naming

- use lowercase names with underscores for files, modules, procedures, and variables
- use descriptive names over short names when the meaning is not obvious
- match the file name to the main module name

Preferred:

```fortran
module matrix_stats
  implicit none
  private

  public :: column_means

contains

  function column_means(x) result(values)
    real, intent(in) :: x(:, :)
    real :: values(size(x, 2))

    values = sum(x, dim=1) / real(size(x, 1))
  end function column_means

end module matrix_stats
```

Avoid:

```fortran
module STATS
implicit none
contains
real function CM(X)
real :: X(:,:)
CM = sum(X, dim=1) / real(size(X,1))
end function
end module
```

### Module naming

- name modules after the concept or responsibility they own
- prefer one main concept per module
- use names like `vector_ops`, `descriptive_stats`, `ode_euler`
- use `_mod` only when it adds clarity or matches an established pattern in the lesson

### File naming

- use lowercase hyphenated folder names for examples and projects: `matrix-toolkit`
- use lowercase underscore file names for Fortran source: `matrix_stats.f90`
- keep one main module per file when possible
- use `main.f90` for small executable drivers inside `app/`
- use `test_*.f90` for test programs

### Procedures

- declare `intent(in)`, `intent(out)`, or `intent(inout)` for dummy arguments
- validate inputs when a bad shape or size would make the result meaningless
- prefer assumed-shape arrays in module procedures when that matches the lesson level
- keep procedures short and focused on one job

Preferred:

```fortran
real function vector_mean(x) result(mean_value)
  real, intent(in) :: x(:)

  if (size(x) == 0) then
    error stop "vector_mean requires a non-empty vector"
  end if

  mean_value = sum(x) / real(size(x))
end function vector_mean
```

### Comments

- write comments to explain intent, assumptions, or why a step matters
- do not comment obvious line-by-line mechanics
- keep comments short and factual
- use section comments sparingly in teaching drivers when they help readers scan the example

Preferred:

```fortran
! Compare against the exact solution to see the effect of dt.
exact_values = exp(-t_values)
```

Avoid:

```fortran
! Assign exp of minus t_values to exact_values.
exact_values = exp(-t_values)
```

### Modern defaults to prefer

- `implicit none`
- modules instead of `COMMON`
- free-form source instead of fixed-form
- array intrinsics when they improve clarity
- `private` by default in reusable modules when it helps define a clear API

### Patterns to avoid as recommended defaults

- implicit typing
- fixed-form source for new teaching material
- large monolithic files
- hidden global state
- unexplained advanced features in beginner material

## Test style

- add tests when logic becomes reusable or numerically meaningful
- keep tests small and direct
- test module logic, not printed formatting
- use tolerance-aware checks for floating-point results
- prefer simple local helpers such as `assert_close` over heavy frameworks

Preferred test shape:

```fortran
call assert_close(vector_mean(x), 2.0, tol, "vector_mean failed")
```

## Documentation style

- write for learners who are new to both Fortran and this repository
- prefer short sections with clear headings
- explain what problem the code solves before discussing details
- keep terminology consistent across lessons, examples, and exercises
- use fenced code blocks for commands and Fortran snippets
- show commands from the repository root or clearly name the target folder

## Lesson writing style

- begin with why the lesson matters
- state learning objectives early
- move from simple explanation to short worked examples
- explain what the learner should notice after code blocks
- teach one main idea at a time
- connect to examples, exercises, or projects when relevant
- avoid turning lessons into reference manuals

Preferred lesson flow:

1. motivation
2. core idea
3. short code example
4. what to notice
5. practice or next step

## Exercise writing style

- state the learning goal near the top
- make the task concrete and runnable
- list clear requirements
- provide starter code when it helps the learner begin
- keep difficulty appropriate to the lesson level
- use reflective questions when they deepen understanding

Preferred exercise structure:

- title with difficulty marker if useful
- learning goal
- task description
- requirements
- starter code or hints

## Repository-specific conventions

- `lessons/` explains concepts and guided reading
- `examples/` contains small runnable `fpm` packages
- `projects/` contains larger teaching artifacts with README, starter code, and tests where appropriate
- `exercises/` contains learner tasks and worked solutions
- `docs/` contains repo-level guides such as this one

## When in doubt

- choose the clearer name
- choose the smaller example
- choose the more explicit interface
- choose the version that best supports teaching modern Fortran
