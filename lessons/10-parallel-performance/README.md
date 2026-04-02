# Lesson 10: Parallel performance with coarrays and OpenMP

This lesson introduces advanced Fortran topics for performance, scaling, and modern HPC patterns.

## Learning objectives

- Understand the coarray Fortran programming model and its key syntax
- Learn to use OpenMP directives for shared-memory parallelism
- Apply memory layout and array traversal patterns for performance
- Design deterministic parallel tests and benchmark validation scripts

## Sections

1. Coarray basics
   - `[dim]` declaration, `sync all`, `this_image()`, `num_images()`
   - simple data distribution and reduction example
2. OpenMP in Fortran
   - `!$omp parallel` and worksharing constructs
   - `shared` vs `private`, race conditions, atomic updates
3. Array performance patterns
   - contiguous arrays, stride, and cache-friendly loops
   - vectorization hints and `!DIR$` directives (compiler-specific)
4. Testing and benchmarking
   - `fpm test` setup for parallel examples
   - tolerance-guarded correctness checks (parallel nondeterminism)

## Next steps

- Add example project `examples/parallel-matrix` with `fpm test` targets
- Add intermediate exercise in `exercises/intermediate` for coarray/OpenMP code
- Update `CHANGELOG.md` and `RELEASE_NOTES_v1.0.md` when complete
