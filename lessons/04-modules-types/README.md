# Lesson 04 — Modules and derived types

## Learning objectives

By the end of this lesson you will be able to:

- Create a module that contains procedures and constants.
- Import a module with `use` and `use ... only`.
- Control visibility with `public` and `private`.
- Explain why modules are the preferred organizational unit in modern Fortran.
- Define a derived type that groups related data.
- Add type-bound procedures to a derived type.
- Organize a multi-file project with one module per file.

---

## The idea in one paragraph

In Lesson 03 you wrote procedures inside the `contains` block of a `program`.
That works for small scripts, but real projects need code that can be shared
across programs and tested independently. In modern Fortran, the **module** is
the standard unit of reuse. A module collects related procedures, constants,
and types into one named unit that other code imports with `use`. **Derived
types** extend the idea by letting you group related data — and the procedures
that operate on it — into a single, clean abstraction.

---

## Your first module

A module starts with `module`, ends with `end module`, and puts its
procedures after `contains`. Any program can import it with `use`.

```fortran
module math_constants
  implicit none
  private                           ! hide everything by default
  public :: pi, e, deg_to_rad       ! then export only what users need

  real, parameter :: pi = 3.14159265
  real, parameter :: e  = 2.71828183

contains

  real function deg_to_rad(degrees)
    real, intent(in) :: degrees
    deg_to_rad = degrees * pi / 180.0
  end function deg_to_rad

end module math_constants


program use_constants
  use math_constants, only: pi, deg_to_rad
  implicit none

  print *, "pi      =", pi
  print *, "45 deg  =", deg_to_rad(45.0), "rad"
end program use_constants
```

**What to notice:**

- `implicit none` in the module applies to all procedures inside it.
- `private` at the top makes everything hidden by default.
- `public ::` lists exactly what callers can see.
- The program uses `use math_constants, only: pi, deg_to_rad` to import
  only what it needs.
- The module and program can live in the same file for learning, but in
  real projects you put one module per file.

---

## Selective imports with `use ... only`

Always import with `only:` to make dependencies explicit.

```fortran
program selective_import
  use math_constants, only: pi       ! import only pi, nothing else
  implicit none

  real :: radius, area

  radius = 5.0
  area = pi * radius ** 2

  print *, "Radius:", radius
  print *, "Area:  ", area
end program selective_import
```

Without `only:`, the `use` statement imports everything the module exports.
That works, but it hides where names come from. In a program that uses five
modules, a reader cannot tell which module provides `pi` unless every `use`
has `only:`. This matters in real codebases with hundreds of modules.

---

## `public` and `private`

Modules control visibility with two mechanisms:

**Default visibility** — place `private` or `public` at the top of the module.
Then override for specific items.

```fortran
module stats_utils
  implicit none
  private                   ! default: hide everything

  public :: mean            ! export only mean
  public :: stddev          ! export only stddev

contains

  real function mean(x)
    real, intent(in) :: x(:)
    mean = sum(x) / real(size(x))
  end function mean

  real function stddev(x)
    real, intent(in) :: x(:)
    stddev = sqrt(variance(x))
  end function stddev

  ! variance is private — it is a helper, not part of the public API
  real function variance(x)
    real, intent(in) :: x(:)
    real :: m
    m = mean(x)
    variance = sum((x - m) ** 2) / real(size(x))
  end function variance

end module stats_utils


program test_stats
  use stats_utils, only: mean, stddev
  implicit none

  real :: data(6)
  data = [2.0, 4.0, 4.0, 4.0, 5.0, 5.0]

  print *, "Mean:  ", mean(data)
  print *, "Stddev:", stddev(data)

  ! print *, variance(data)   ! would not compile: variance is private
end program test_stats
```

**Why this matters:** `private` lets you change internal helpers without
breaking code that uses the module. The public names are the stable contract.
Everything else is an implementation detail.

---

## Why modules matter in real codebases

In a small script, putting everything in one file works fine. In a real
project — a climate model, a finite-element solver, a data analysis pipeline —
modules solve problems that no other Fortran feature addresses:

**1. Explicit interfaces.** When a program calls a procedure defined in a
module, the compiler knows the full signature: argument types, intents, array
shapes. If you pass the wrong type or the wrong number of arguments, you get
a compile-time error instead of a silent wrong answer. Without modules, Fortran
procedures have *implicit* interfaces and the compiler cannot check calls.

**2. Namespace control.** Modules give each unit of code its own namespace.
Two modules can both define a `solve` function without conflict. `use ... only`
makes every dependency visible at the import site.

**3. Reuse across programs.** A module compiled once can be used by many
programs and test drivers. In `fpm`, every `.f90` file in `src/` is available
to all programs in `app/` and all tests in `test/`.

**4. Encapsulation.** `private` hides implementation details so you can
refactor internal helpers without breaking callers.

**5. Incremental compilation.** The compiler can skip recompiling a module
that has not changed, speeding up builds in large projects.

The rule in modern Fortran is simple: **put reusable code in modules, not in
loose files or inside programs.**

---

## Splitting code into files — the fpm layout

In a real `fpm` project, you put one module per file in `src/`:

```text
my-project/
├── fpm.toml
├── app/
│   └── main.f90          uses modules from src/
├── src/
│   ├── math_constants.f90    module math_constants
│   └── stats_utils.f90       module stats_utils
└── test/
    └── test_stats.f90        test program using the modules
```

`fpm` compiles all modules in `src/` first, then compiles `app/` and `test/`
programs that `use` them. You do not need to specify a build order — `fpm`
figures out module dependencies automatically.

**Convention:** the file name should match the module name.
`stats_utils.f90` contains `module stats_utils`.

---

## Derived types — grouping related data

A derived type defines a new data structure. Think of it as a `struct` in C
or a simple `class` in Python — it groups related values under one name.

```fortran
module particle_mod
  implicit none
  private
  public :: particle_t, kinetic_energy

  type :: particle_t
    real :: x       = 0.0    ! position
    real :: y       = 0.0
    real :: vx      = 0.0    ! velocity
    real :: vy      = 0.0
    real :: mass    = 1.0
  end type particle_t

contains

  real function kinetic_energy(p)
    type(particle_t), intent(in) :: p
    kinetic_energy = 0.5 * p%mass * (p%vx ** 2 + p%vy ** 2)
  end function kinetic_energy

end module particle_mod


program particles
  use particle_mod, only: particle_t, kinetic_energy
  implicit none

  type(particle_t) :: ball

  ! Set fields with the % operator
  ball%x    = 0.0
  ball%y    = 10.0
  ball%vx   = 3.0
  ball%vy   = -4.0
  ball%mass = 2.0

  print *, "Position:", ball%x, ball%y
  print *, "Velocity:", ball%vx, ball%vy
  print *, "Mass:    ", ball%mass
  print *, "KE:      ", kinetic_energy(ball)
end program particles
```

**What to notice:**

- `type :: particle_t` defines the type. The `_t` suffix is a common
  convention (not required) that makes type names easy to spot.
- Components have default values (`= 0.0`) so you can create a particle
  without setting every field.
- Access components with `%`: `ball%mass`.
- The `kinetic_energy` function takes a `particle_t` argument. The type
  provides an explicit interface automatically because it is in a module.

---

## Constructing derived type values

You can also create a derived type value in one expression using the
**structure constructor** — the type name followed by component values:

```fortran
program constructor_demo
  use particle_mod, only: particle_t, kinetic_energy
  implicit none

  type(particle_t) :: p

  ! Structure constructor: values in declaration order
  p = particle_t(x=1.0, y=2.0, vx=5.0, vy=0.0, mass=0.5)

  print *, "KE =", kinetic_energy(p)
end program constructor_demo
```

Named arguments (`x=1.0`) make the constructor readable. You can omit
components that have default values — they keep their defaults.

---

## Type-bound procedures

Instead of passing a type to a standalone function, you can attach the
procedure directly to the type. This is Fortran's approach to methods.

```fortran
module shape_mod
  implicit none
  private
  public :: rectangle_t

  type :: rectangle_t
    real :: width  = 0.0
    real :: height = 0.0
  contains
    procedure :: area
    procedure :: perimeter
    procedure :: describe
  end type rectangle_t

contains

  real function area(self)
    class(rectangle_t), intent(in) :: self
    area = self%width * self%height
  end function area

  real function perimeter(self)
    class(rectangle_t), intent(in) :: self
    perimeter = 2.0 * (self%width + self%height)
  end function perimeter

  subroutine describe(self)
    class(rectangle_t), intent(in) :: self
    print '(A, F6.2, A, F6.2)', " Rectangle: ", self%width, " x ", self%height
    print '(A, F8.2)', " Area:      ", self%area()
    print '(A, F8.2)', " Perimeter: ", self%perimeter()
  end subroutine describe

end module shape_mod


program shapes
  use shape_mod, only: rectangle_t
  implicit none

  type(rectangle_t) :: r

  r = rectangle_t(width=4.0, height=7.0)
  call r%describe()
end program shapes
```

**What to notice:**

- `contains` inside the `type` block lists the type-bound procedures.
- The first argument uses `class(rectangle_t)` instead of `type(rectangle_t)`.
  This is required for type-bound procedures (it enables inheritance, though
  we do not use inheritance in this lesson).
- Call with `r%area()` — the object itself is passed automatically as the
  first argument.
- `describe` is a subroutine, so it is called with `call r%describe()`.

Type-bound procedures are optional. For beginners, standalone procedures in
the same module work perfectly well. Use type-bound procedures when the
connection between data and operations is strong — like shapes and their
geometry, or particles and their physics.

---

## Encapsulation — private components

You can make individual components of a type private, so only the module's
own procedures can access them directly. External code must use the public
procedures.

```fortran
module counter_mod
  implicit none
  private
  public :: counter_t

  type :: counter_t
    private                   ! all components are private
    integer :: n = 0
  contains
    procedure :: increment
    procedure :: get_value
    procedure :: reset
  end type counter_t

contains

  subroutine increment(self)
    class(counter_t), intent(inout) :: self
    self%n = self%n + 1
  end subroutine increment

  integer function get_value(self)
    class(counter_t), intent(in) :: self
    get_value = self%n
  end function get_value

  subroutine reset(self)
    class(counter_t), intent(inout) :: self
    self%n = 0
  end subroutine reset

end module counter_mod


program use_counter
  use counter_mod, only: counter_t
  implicit none

  type(counter_t) :: c

  call c%increment()
  call c%increment()
  call c%increment()

  print *, "Count:", c%get_value()    ! 3

  call c%reset()
  print *, "After reset:", c%get_value()    ! 0

  ! print *, c%n   ! would not compile: n is private
end program use_counter
```

Encapsulation protects invariants. A counter that must never go negative can
enforce that rule inside its own module, and no outside code can break it by
writing to `n` directly.

---

## Running the companion examples

Two `fpm` projects demonstrate the concepts from this lesson:

- `examples/modules-types/` — a multi-file project with a statistics module
  and a particle type
- `examples/vector-ops/` — a vector operations module with tests

```bash
cd examples/modules-types
fpm run
```

---

## Exercises

See [exercises/intermediate/01-modules.md](../../exercises/intermediate/01-modules.md)
for practice problems based on this lesson.

---

## Key takeaways

- Modules are the standard unit of code organization in modern Fortran.
- `use ... only` makes imports explicit — always use it.
- Default to `private` in modules, then `public` only what callers need.
- Put one module per file. Name the file after the module.
- Derived types group related data under one name. Access fields with `%`.
- Type-bound procedures attach operations to types with `class` arguments.
- `private` on type components enforces encapsulation.
- `fpm` handles module compilation order automatically.

---

## Next step

Move to [Lesson 05 — File I/O](../05-file-io/README.md) to learn how to
read and write data files.
