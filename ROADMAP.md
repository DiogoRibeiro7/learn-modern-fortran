# Roadmap

## Vision

Build a modern Fortran repository that starts with the language but ultimately
demonstrates scientific-computing engineering: numerical correctness, reusable
modules, testing, performance awareness, parallel execution, and reproducibility.

## Phase 1 — Language foundations (complete)

- [x] setup and `fpm` workflow
- [x] variables, kinds, expressions, control flow, and I/O
- [x] arrays, slicing, procedures, and intent
- [x] beginner exercises and solutions

## Phase 2 — Software structure (complete)

- [x] modules and derived types
- [x] file I/O and error/status handling
- [x] `fpm test` patterns and floating-point tolerances
- [x] reusable example modules with automated tests
- [x] CI for representative packages

## Phase 3 — Numerical programming (complete baseline)

- [x] Monte Carlo pi project
- [x] forward Euler ODE project
- [x] matrix toolkit project
- [x] project tests and walkthroughs
- [x] numerical-error and convergence guidance

## Phase 4 — Interoperability and modernization (complete baseline)

- [x] C interoperability with `iso_c_binding`
- [x] fixed-form and legacy-code orientation
- [x] `COMMON`-to-module modernization examples
- [x] guidance on explicit interfaces and numerical-risk preservation

## Phase 5 — Parallel and performance engineering (in progress)

- [x] lesson 10 parallel-programming concepts
- [x] tested OpenMP matrix example
- [x] column-major traversal and data-layout guidance
- [x] OpenMP package included in CI
- [x] coarray programming model introduction
- [ ] controlled benchmark harness with repeated measurements and machine metadata
- [ ] multi-image coarray test environment
- [ ] vectorization/profiling workflow and optimization-report guidance

## Phase 6 — Portfolio-grade scientific system (in progress)

- [x] choose a substantial numerical problem with a known verification target: 1D heat equation
- [x] serial FTCS reference implementation
- [x] OpenMP stencil implementation
- [x] analytical sine-mode verification target
- [x] deterministic test fixtures
- [x] grid-convergence test with `dt = O(dx^2)`
- [x] architecture and numerical-method documentation
- [ ] controlled benchmark protocol
- [ ] repeated benchmark results with machine/compiler metadata
- [ ] optional restart/checkpoint demonstration

## Optional ecosystem depth

These are useful additions, but they are no longer blockers for the main portfolio
story:

- BLAS/LAPACK integration;
- MPI example;
- pFUnit comparison;
- HDF5/NetCDF I/O;
- richer coarray runtime demonstrations;
- additional compiler families and platform matrices.

## Release direction

The repository has enough language breadth. New work should deepen the
`heat-diffusion` system, especially reproducible performance measurement and
operational features, before adding more standalone language lessons.
