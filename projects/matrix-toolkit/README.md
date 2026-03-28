# Matrix Toolkit

Build a small toolkit for common matrix summaries and matrix-vector products.

This project is framed as a reusable helper library for small numeric tables,
such as measurements stored in rows and columns.

## Problem statement

Given a 2D real array, we often want a few basic operations before moving on to
heavier numerical work:

- row sums
- column sums
- column means
- matrix-vector products
- an overall matrix size measure such as the Frobenius norm

The goal here is not to compete with large libraries. It is to practice clean
array handling and procedure design in modern Fortran.

## Learning goals

- work with assumed-shape 2D arrays `x(:, :)`
- distinguish row access `x(i, :)` from column access `x(:, j)`
- design small reusable procedures with clear responsibilities
- write tests for array-valued results

## Project layout

| File | Purpose |
| ---- | ------- |
| `src/matrix_stats.f90` | Reusable matrix procedures |
| `app/main.f90` | Driver using a small data matrix |
| `test/test_matrix_stats.f90` | Checks array and scalar results |
| `starter/main.f90` | Smaller scaffold for learners |

## Build and run

```bash
cd projects/matrix-toolkit
fpm run
fpm test
```

## What to notice

- The matrix is filled row by row in the driver so the layout is easy to read.
- Procedures use assumed-shape arguments, so they work for many matrix sizes.
- `matrix_vector_product` is implemented with loops on purpose. Beginners should
  see the indexing clearly before relying on `matmul`.

## Key design choices

- Keep each procedure focused on one task.
- Validate dimensions where a mismatch would silently produce nonsense.
- Include both scalar and array results so learners practice testing both forms.

## Starter code

`starter/main.f90` is a minimal scaffold. Good follow-up tasks are:

- add `column_means`
- replace the hard-coded matrix with user input or file input
- compare your explicit matrix-vector product against `matmul`

## Suggested extensions

- add row means and row standardization
- read a matrix from a simple text file
- implement matrix transpose as a separate teaching exercise
- compare loop-based code against intrinsic array operations
