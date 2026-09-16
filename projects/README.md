# Projects

Standalone `fpm` projects that move from small teaching problems toward verified
scientific-computing systems.

## How to run a project

```bash
cd projects/<project-name>
fpm run
fpm test
```

## Project index

| Folder | Problem | Highlights |
| ------ | ------- | ---------- |
| [monte-carlo-pi](monte-carlo-pi/) | Estimate `pi` from random sampling | random sampling, convergence reporting, deterministic geometric test |
| [ode-solver](ode-solver/) | Forward Euler initial-value solver | reusable solver, exact-solution comparison, numerical test |
| [matrix-toolkit](matrix-toolkit/) | Small matrix/statistics toolkit | 2D arrays, reusable module design, array-result tests |
| [heat-diffusion](heat-diffusion/) | 1D heat equation with finite differences | FTCS stability, analytical verification, OpenMP stencil, grid convergence |

## Project progression

The first three projects are compact teaching artifacts. `heat-diffusion` is the
first portfolio-grade scientific system in the repository: the method, stability
restriction, reference solution, parallel equivalence, and convergence evidence
are all part of the executable contract.

## Engineering pattern

For substantial numerical projects, prefer this structure:

```text
mathematical problem
    -> discretization
    -> serial reference
    -> verified implementation
    -> parallel/optimized implementation
    -> convergence or residual evidence
    -> controlled benchmarking
```

Performance claims should come after correctness and should be supported by a
reproducible benchmark protocol rather than a single timing measurement.
