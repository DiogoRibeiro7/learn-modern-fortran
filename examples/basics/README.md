# basics

Demonstrates intrinsic types, variable declarations, constants, integer vs
real division, kind selection, relational operators, and formatted output.

**Companion lesson:** [02 — Types, variables, expressions](../../lessons/02-basics/)

## What it demonstrates

- `integer`, `real`, `logical`, `character` declarations
- `parameter` for named constants
- Integer division pitfall (`7 / 2` gives `3`)
- `real64` precision from `iso_fortran_env`
- Relational operators (`==`, `/=`, `<`)
- Formatted output with `print '(...)'`

## Source files

| File | Purpose |
| ---- | ------- |
| `app/main.f90` | All demonstrations in one program |
| `fpm.toml` | Project metadata |

## Build and run

```bash
cd examples/basics
fpm run
```

## Expected output (excerpt)

```text
 === Types and variables ===
 count:                42
 temperature:  -3.50000000
 city:        Reykjavik
 is_freezing: T

 === Integer division ===
 7 / 2 (integer):            3
 7.0 / 2.0 (real):    3.50000000

 === Formatted output ===
  count:           42
  temperature:    -3.50
  city:        Reykjavik
  is_freezing:  T
```
