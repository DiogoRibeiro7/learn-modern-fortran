# arrays-procedures

Shows array operations, slicing, element-wise math, and reusable procedures
organized in a module.

**Companion lesson:** [03 — Arrays, control flow, procedures](../../lessons/03-arrays-procedures/)

## What it demonstrates

- Array intrinsics: `sum`, `size`, `minval`, `maxval`
- Array slicing: `data(1:3)`, `data(8:1:-1)`
- Element-wise arithmetic: `data + 10.0`, `data ** 2`
- Module with procedures: `vec_mean`, `vec_stddev`, `euclidean_norm`
- `intent(in)`, `intent(out)`, `intent(inout)`
- `where` statement for conditional element-wise operations
- Internal function with explicit loop

## Source files

| File | Purpose |
| ---- | ------- |
| `app/main.f90` | Driver program |
| `src/array_utils.f90` | Module with statistics and utility functions |
| `test/test_array_utils.f90` | Small test program for the reusable module procedures |
| `fpm.toml` | Project metadata |

## Build and run

```bash
cd examples/arrays-procedures
fpm run
fpm test
```

The example now includes tests because `src/array_utils.f90` contains reusable
logic that is easy to validate independently of the printed demo output.

## Expected output (excerpt)

```text
 === Array operations ===
 Data:     4.000  -2.000   7.000   1.000  -3.000   8.000   5.000   0.000
 Sum:      20.000
 Size:            8

 === Statistics ===
 Mean:      2.500
 Std dev:   3.640
 Norm:      11.874
 Min:      -3.000
 Max:       8.000
```
