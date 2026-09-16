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

## Phase 6 — Portfolio-grade scientific system (next)

- [ ] choose one substantial numerical problem with a known verification target
- [ ] serial reference implementation
- [ ] optimized/parallel implementation
- [ ] convergence or residual-based verification
- [ ] deterministic test fixtures
- [ ] reproducible benchmark protocol
- [ ] architecture and numerical-method documentation

Candidate systems:

- finite-difference heat/diffusion solver;
- conjugate-gradient solver for sparse symmetric positive-definite systems;
- tiled stencil computation with OpenMP;
- small N-body or particle simulation with conservation checks.

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

The repository already has enough breadth for a teaching release. New work should
prefer **depth over additional language coverage**. A strong next release should be
defined by one serious verified scientific-computing project rather than another
sequence of small syntax lessons.
