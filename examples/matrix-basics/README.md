# matrix-basics

Demonstrates 2D array creation, row/column operations, identity matrices,
matrix multiplication, and transposition using Fortran intrinsics.

## What it demonstrates

- 2D array creation with `reshape`
- Row and column slicing: `a(i, :)`, `a(:, j)`
- Row and column sums with `sum`
- Building an identity matrix with a loop
- `matmul` for matrix-matrix and matrix-vector multiplication
- `transpose` intrinsic

## Source files

| File | Purpose |
| ---- | ------- |
| `app/main.f90` | All demonstrations in one program |
| `fpm.toml` | Project metadata |

## Build and run

```bash
cd examples/matrix-basics
fpm run
```

## Expected output

```text
 === Matrix A ===
    1.00    2.00    3.00
    4.00    5.00    6.00
    7.00    8.00    9.00

 === Row and column sums ===
  Row 1 sum:    6.00
  Row 2 sum:   15.00
  Row 3 sum:   24.00
  Col 1 sum:   12.00
  Col 2 sum:   15.00
  Col 3 sum:   18.00

 === A * [1, 0, 0] (first column of A) ===
    1.00    4.00    7.00

 === Transpose of A ===
    1.00    4.00    7.00
    2.00    5.00    8.00
    3.00    6.00    9.00
```
