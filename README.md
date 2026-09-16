# Learn Modern Fortran

A structured repository for learning modern Fortran through tested numerical and
scientific-computing examples built with `fpm`.

## Current scope

The repository now spans:

- language foundations and array programming;
- modules, derived types, file I/O, and testing;
- Monte Carlo simulation, ODE solving, and matrix computation;
- C interoperability and legacy-code modernization;
- OpenMP shared-memory programming with a tested numerical example;
- introductory coarray concepts and the distinction between shared-memory and image-based parallel models.

The code is organized as many small standalone `fpm` packages rather than one
monolithic package. That keeps each numerical idea inspectable and independently
testable.

## Learning path

| # | Lesson | Companion code |
| ---: | --- | --- |
| 01 | [Setup](lessons/01-setup/README.md) | [hello](examples/hello/) |
| 02 | [Types, variables, expressions](lessons/02-basics/README.md) | [basics](examples/basics/) |
| 03 | [Arrays, control flow, procedures](lessons/03-arrays-procedures/README.md) | [arrays-procedures](examples/arrays-procedures/) |
| 04 | [Modules and derived types](lessons/04-modules-types/README.md) | [modules-types](examples/modules-types/) |
| 05 | [File I/O](lessons/05-file-io/README.md) | [file-processing](examples/file-processing/) |
| 06 | [Testing with fpm](lessons/06-testing-with-fpm/README.md) | [vector-ops](examples/vector-ops/) |
| 07 | [Numerical mini-projects](lessons/07-numerical-mini-projects/README.md) | [projects](projects/README.md) |
| 08 | [C interoperability](lessons/08-c-interop/README.md) | lesson examples |
| 09 | [Legacy to modern](lessons/09-legacy-to-modern/README.md) | modernization examples |
| 10 | [Parallel performance](lessons/10-parallel-performance/README.md) | [parallel-matrix](examples/parallel-matrix/) |

## Scientific-computing projects

The standalone project set currently includes:

- [monte-carlo-pi](projects/monte-carlo-pi/) — stochastic estimation and convergence;
- [ode-solver](projects/ode-solver/) — forward Euler integration and error analysis;
- [matrix-toolkit](projects/matrix-toolkit/) — reusable matrix operations and tests.

The next portfolio milestone should be a larger numerical system rather than more
introductory syntax: for example, a verified PDE/stencil solver or iterative linear
solver with serial/parallel implementations and a reproducible benchmark harness.

## Parallel example

The [parallel-matrix](examples/parallel-matrix/) package demonstrates an explicit
engineering pattern:

\[
\text{serial reference}
\rightarrow
\text{OpenMP implementation}
\rightarrow
\text{numerical equivalence test}
\rightarrow
\text{diagnostic timing}
\]

The tests verify mathematics, not speed. Shared GitHub runners are suitable for
build and correctness checks but not for defensible performance claims.

## `fpm` workflow

Inside any example or project package:

```bash
fpm build
fpm run
fpm test
```

Not every introductory package needs a test target, but reusable numerical modules
and portfolio-level projects should have one.

## Repository structure

```text
learn-modern-fortran/
├── lessons/          Language, engineering, interop, and performance lessons
├── examples/         Small runnable/tested fpm packages
├── exercises/        Practice problems and solutions
├── projects/         Larger numerical projects
├── resources/        Reference material
├── docs/             Tooling and style guidance
└── .github/          Build and test workflows
```

## CI

GitHub Actions builds and tests representative `fpm` packages. The v0.9 validation
matrix includes the OpenMP `parallel-matrix` package so parallel code is compiled
and numerically checked on every relevant pull request.

## Status

The teaching baseline is mature. Current development is shifting toward deeper
scientific-computing engineering: performance-aware numerical kernels, parallel
correctness, verification, and larger reproducible numerical systems.

See [ROADMAP.md](ROADMAP.md) for the development plan.

## Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md) and `AGENTS.md`.

## License

[MIT](LICENSE)
