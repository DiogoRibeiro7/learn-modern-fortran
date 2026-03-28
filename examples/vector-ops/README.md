# vector-ops

A module-based vector operations library with an executable driver and a test
suite. This is the repo's primary example of a properly structured `fpm`
project with `src/`, `app/`, and `test/` directories.

**Companion lesson:** [04 — Modules and derived types](../../lessons/04-modules-types/)

## What it demonstrates

- Module with `private` default and explicit `public` exports
- Assumed-shape array arguments `x(:)`
- Input validation with `error stop`
- `fpm test` workflow
- Tolerance-based floating-point assertion

## Source files

| File | Purpose |
| ---- | ------- |
| `src/vector_ops.f90` | Module: `vector_mean`, `dot_product_safe`, `euclidean_norm` |
| `app/main.f90` | Driver that exercises the module |
| `test/test_vector_ops.f90` | Test program with `assert_close` helper |
| `fpm.toml` | Project metadata |

## Build and run

```bash
cd examples/vector-ops
fpm run
fpm test
```

## Expected output

```text
 x mean         =   2.00000000
 x dot y        =   32.0000000
 norm of x      =   3.74165750
```

```text
 All vector_ops tests passed.
```
