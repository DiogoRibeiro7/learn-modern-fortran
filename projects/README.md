# Projects

Standalone `fpm` projects that turn lesson topics into small but realistic
teaching artifacts. Each project now includes a runnable reference
implementation, a project README, a starter scaffold, and at least one test for
the reusable logic.

## How to run a project

```bash
cd projects/<project-name>
fpm run
fpm test
```

## Project index

| Folder | Problem | Highlights |
| ------ | ------- | ---------- |
| [monte-carlo-pi](monte-carlo-pi/) | Estimate `pi` from random sampling in the unit square | random sampling, convergence reporting, simple CLI, deterministic geometric test |
| [ode-solver](ode-solver/) | Approximate an initial value problem with forward Euler | mathematical update rule, reusable solver, exact-solution comparison, solver test |
| [matrix-toolkit](matrix-toolkit/) | Build reusable helpers for small numeric tables | 2D arrays, row/column handling, procedure design, array-result tests |

## When to use these

These projects are best attempted after completing lessons 01-06.
They connect to [Lesson 07 — Numerical mini-projects](../lessons/07-numerical-mini-projects/).

## Teaching pattern

Each project is organized to support several kinds of learning:

- read the root `README.md` for the problem statement and design notes
- run the completed implementation in `app/` and `src/`
- inspect `test/` to see what reusable logic should be checked automatically
- attempt the `starter/` scaffold before comparing against the reference code
