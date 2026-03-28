# modules-types

A multi-file project demonstrating modules and derived types. Contains a
statistics module and a particle type with type-bound procedures.

**Companion lesson:** [04 — Modules and derived types](../../lessons/04-modules-types/)

## What it demonstrates

- Two modules in separate files (`src/stats_utils.f90`, `src/particle_mod.f90`)
- `use ... only` for selective imports
- `public` / `private` visibility control
- Derived type with default component values
- Structure constructor with named arguments
- Type-bound procedures (`describe`, `speed`, `kinetic_energy`)

## Source files

| File | Purpose |
| ---- | ------- |
| `src/stats_utils.f90` | Module: `mean`, `stddev`, `variance` |
| `src/particle_mod.f90` | Module: `particle_t` type with methods |
| `app/main.f90` | Driver using both modules |
| `test/test_modules_types.f90` | Test program for the statistics functions and particle methods |
| `fpm.toml` | Project metadata |

## Build and run

```bash
cd examples/modules-types
fpm run
fpm test
```

## Derived type constructor example

The `particle_t` type in `src/particle_mod.f90` uses default component values and supports structure construction:

```fortran
use particle_mod, only: particle_t

! Default constructor (all defaults)
real :: m
m = particle_t%mass  ! compile-time default doesn't work this way; example is from data fields below

! Instantiate using positional constructor
type(particle_t) :: p1
p1 = particle_t(0.0, 10.0, 3.0, -4.0, 2.0)

! Instantiate using named constructor arguments (recommended for clarity)
type(particle_t) :: p2
p2 = particle_t(x = 1.0, y = 2.0, vx = 1.5, vy = -2.0, mass = 1.5)

call p1%describe()
call p2%describe()
```

`particle_t` also allows partial updates through component assignment while preserving defaults:

```fortran
p2 = particle_t(vx = 1.0, vy = 1.0)
call p2%describe()
```

## Expected output

```text
 === Statistics module ===
 Mean speed:     3.900
 Std deviation:  0.874

 === Particle type ===
 Position: (   0.00,  10.00
 Velocity: (   3.00,  -4.00
 Mass:        2.00
 Speed:       5.00
 KE:         25.00
```
