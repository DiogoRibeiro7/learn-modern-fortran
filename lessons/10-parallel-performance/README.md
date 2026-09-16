# Lesson 10: Parallel performance with OpenMP and coarrays

This lesson introduces the two parallel models most useful to understand in modern Fortran:

- **OpenMP** for shared-memory parallelism inside one process;
- **coarrays** for Fortran's image-based parallel programming model.

The runnable companion package is [parallel-matrix](../../examples/parallel-matrix/).
It uses OpenMP to parallelize independent matrix-column work and tests the parallel
result against a serial reference implementation.

## Learning objectives

By the end of this lesson you should be able to:

- explain when shared-memory OpenMP is appropriate;
- explain the basic coarray image model;
- reason about Fortran column-major layout before parallelizing array loops;
- make OpenMP data-sharing intent explicit with `default(none)`;
- test numerical equivalence separately from performance;
- recognize why CI timing is not a reliable scalability benchmark.

## 1. Start from the data layout

Fortran arrays are column-major. For a two-dimensional array `a(i, j)`, varying
`i` in the inner loop walks contiguous elements of a column:

```fortran
do j = 1, n_columns
  do i = 1, n_rows
    work = work + a(i, j) * a(i, j)
  end do
end do
```

This is the traversal used by the companion example. Each column norm is
independent, so the outer `j` loop is also a natural shared-memory worksharing
boundary.

## 2. OpenMP shared-memory parallelism

The package parallelizes the outer loop:

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

The important engineering details are not the directive alone:

- each thread writes to a distinct `norms(j)` element;
- `accumulator` is private to each iteration/thread;
- the input matrix is read-only;
- `default(none)` forces data-sharing choices to be explicit.

The `fpm` package enables OpenMP through its built-in metapackage:

```toml
[dependencies]
openmp = "*"
```

Run it with:

```bash
cd examples/parallel-matrix
fpm run
fpm test
```

## 3. Correctness before speed

Parallel numerical code should first reproduce the serial mathematics within an
appropriate tolerance.

The companion test checks two things:

1. the serial implementation matches known column norms;
2. the OpenMP implementation matches the serial implementation.

It deliberately does **not** assert a speedup. Shared CI machines vary in CPU
allocation, background load, topology, and thread scheduling. A wall-time
threshold would make the test noisy rather than rigorous.

For controlled performance work, record at least:

- compiler and version;
- optimization profile;
- matrix dimensions;
- number of OpenMP threads;
- CPU model/topology;
- repeated timing samples;
- serial baseline;
- correctness error relative to the baseline.

## 4. Coarrays: a different model

Coarrays extend normal Fortran variables with image dimensions. A minimal scalar
example looks like:

```fortran
program coarray_identity
  implicit none
  integer :: value[*]

  value = this_image()
  sync all

  if (this_image() == 1) then
    print *, "number of images:", num_images()
  end if
end program coarray_identity
```

Each executing image has its own local `value`, and coindexed syntax such as
`value[2]` refers to the variable on another image.

Conceptually:

- **OpenMP** shares memory among threads and distributes loop work;
- **coarrays** expose multiple Fortran images and explicit cross-image data access.

A single-image compile or CI run is useful for syntax, but it is not evidence of
correct multi-image behaviour. Distributed correctness needs a runtime and tests
that actually launch multiple images.

## 5. Choosing between them

Use OpenMP when the problem is naturally shared-memory and you want to parallelize
loops or regions with relatively small changes to an existing codebase.

Use coarrays when the program architecture benefits from Fortran's image model and
explicit remote data access. For larger distributed systems, MPI remains another
important model and should be evaluated separately rather than treated as
interchangeable with coarrays.

## 6. Common mistakes

### Parallelizing the wrong loop

Parallelizing a loop that conflicts with Fortran's memory layout can increase
cache misses and erase any benefit from threads.

### Shared temporary state

A temporary scalar such as an accumulator must not accidentally be shared across
threads when each iteration requires its own value.

### Treating different answers as "parallel noise"

Parallel execution does not excuse unexplained numerical disagreement. Determine
whether differences come from changed reduction order, a race condition, or an
actual algorithmic error.

### Benchmarking in CI

CI should verify buildability and correctness. Performance claims need a controlled
benchmark protocol.

## Companion example

See [examples/parallel-matrix](../../examples/parallel-matrix/) for the complete
module, executable, and `fpm test` target.

## Next step

A stronger HPC portfolio project should move beyond one parallel loop. Good next
candidates are a tiled stencil solver, conjugate-gradient solver, or finite-difference
PDE code with explicit verification and a reproducible scaling harness.
