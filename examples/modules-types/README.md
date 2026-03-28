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
