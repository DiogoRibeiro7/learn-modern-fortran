# Lesson 07 — Numerical mini-projects

## Why this lesson matters

This lesson shows how Fortran becomes a real scientific tool through small, testable applications. Learners move from toy examples to structured projects with explicit numerical validation.

## What you should learn

- translate a numerical idea into a package with `src`, `test`, and `app`
- implement and test basic methods: Monte Carlo, ODE integration, matrix summaries
- diagnose convergence and numerical stability issues
- document assumptions, inputs, and outputs

## Project 1: Monte Carlo π estimation (`projects/monte-carlo-pi`)

1. Implement a worker module in `src/monte_carlo_pi_mod.f90`.
2. Expose functions:
   - `approximate_pi(n_samples, seed)`
   - `estimate_error(n_samples)`
3. Create tests in `test/test_monte_carlo_pi.f90` with fixed seed and repeated trials.
4. Validate with law of large numbers: error should shrink as `1/sqrt(n_samples)`.

Key ideas:
- reproducible RNG seeds
- simple geometric probability ratio
- statistical / Monte Carlo uncertainty

## Project 2: Euler ODE solver (`projects/ode-solver`)

1. Implement `src/euler_mod.f90` with:
   - `step_euler(y, t, dt, derivative)`
   - `solve_euler(f, y0, t0, t_final, dt)`
2. Example driver `app/main.f90` solves `dy/dt = -y` with `y(0)=1`.
3. Tests in `test/test_ode_solver.f90` compare to analytical solution `exp(-t)`.
4. Add refinement test: halving `dt` should reduce maximum error by ~2x (first-order behavior).

## Project 3: Matrix toolkit (`projects/matrix-toolkit`)

1. Implement `src/matrix_toolkit_mod.f90` with:
   - `row_sum(matrix)`, `col_sum(matrix)`, `matrix_transpose`
   - `matrix_norm_2`, `matrix_trace`
2. Write tests in `test/test_matrix_toolkit.f90`.
3. Include edge tests for empty matrices (shape [0, n], [n, 0]) and non-square matrices.

## How to map structure to learning outcomes

- `src/` encapsulates reusable logic
- `app/` sidecar programs demonstrate end-to-end usage
- `test/` ensuring correctness and regression coverage
- cross-link findings with `docs/` and the exercise solutions

## Validation strategy

- run `fpm test` in each project and confirm all tests pass
- compare numeric results against closed-form assertions or known constants
- add comments for units, precision, and expected default behavior

## Suggested next step

Move to [Lesson 08 — C interoperability](../08-c-interop/README.md) once these projects are stable.

