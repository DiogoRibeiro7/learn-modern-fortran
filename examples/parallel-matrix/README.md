# Parallel Matrix Example

This `fpm` package demonstrates a small, testable OpenMP pattern in modern Fortran.
It computes the Euclidean norm of every matrix column using both a serial routine
and an OpenMP routine, then verifies that the numerical results agree.

## Why this example

Fortran stores arrays in column-major order. Traversing `matrix(i, j)` with `i`
as the inner loop walks contiguous elements of a column. Each column norm is also
independent, so columns can be distributed across OpenMP threads without a shared
floating-point reduction.

That gives a useful teaching example with three properties:

1. the serial algorithm is simple enough to audit;
2. the parallel decomposition follows the data layout;
3. correctness can be tested independently of timing.

## Package structure

```text
parallel-matrix/
├── app/
│   └── main.f90
├── src/
│   └── parallel_matrix.f90
├── test/
│   └── test_parallel_matrix.f90
└── fpm.toml
```

The package enables OpenMP through the `fpm` OpenMP metapackage:

```toml
[dependencies]
openmp = "*"
```

## Run

```bash
cd examples/parallel-matrix
fpm run
```

The executable reports the OpenMP thread limit, serial and parallel wall-clock
times, and the maximum absolute difference between the two implementations.

Do not interpret a single timing run as a benchmark. Thread start-up costs,
machine load, matrix size, compiler optimization, and CPU topology all affect
timing.

## Test

```bash
fpm test
```

The test uses a matrix with known column norms and checks:

- the serial implementation against exact reference values;
- the OpenMP implementation against the serial implementation.

No test asserts that the parallel version is faster. Shared CI runners are not a
controlled benchmarking environment.

## Core OpenMP pattern

```fortran
!$omp parallel do default(none) &
!$omp shared(matrix, norms, n_rows, n_columns) private(i, accumulator)
do j = 1, n_columns
  accumulator = 0.0_dp
  do i = 1, n_rows
    accumulator = accumulator + matrix(i, j) * matrix(i, j)
  end do
  norms(j) = sqrt(accumulator)
end do
!$omp end parallel do
```

`default(none)` makes data-sharing intent explicit. Each thread receives private
loop-local state, while the input matrix and output vector are shared. Distinct
iterations write to distinct `norms(j)` elements.

## What this does not prove

This example demonstrates correct shared-memory parallelization. It does not show
strong scaling, distributed-memory execution, NUMA behavior, or accelerator
offloading. Those require controlled experiments and different execution models.
