# ODE Solver

Solve a first-order initial value problem with the forward Euler method.

The reference program uses the decay model

```text
y'(t) = -y(t),   y(0) = 1
```

because its exact solution, `exp(-t)`, is known. That makes it easy to compare
the numerical approximation against the true answer.

## Problem statement

We want to approximate the solution of an ordinary differential equation when we
cannot or do not want to solve it by hand. For forward Euler, the update rule is

```text
y_(n+1) = y_n + dt * f(t_n, y_n)
```

It uses the slope at the current point to take one small step forward.

## Learning goals

- represent a mathematical model as a Fortran procedure
- separate a reusable solver from a problem-specific driver
- understand what `dt` and `n_steps` do to accuracy
- compare a numerical result against an exact solution

## Project layout

| File | Purpose |
| ---- | ------- |
| `src/ode_euler.f90` | Reusable forward Euler integrator |
| `app/main.f90` | Driver for the decay equation with error reporting |
| `test/test_ode_euler.f90` | Checks the update rule and error helper |
| `starter/main.f90` | Smaller scaffold with TODO markers |

## Build and run

```bash
cd projects/ode-solver
fpm run
fpm run -- 0.05 20
fpm test
```

The optional command-line arguments are:

1. `dt`
2. `n_steps`

## What to notice

- The solver does not know anything about exponential decay. It only knows how
  to apply the Euler step once a derivative function `f(t, y)` is provided.
- The driver defines both the differential equation and the exact solution.
- Smaller `dt` usually improves the result, but it also requires more steps.

## Key design choices

- Keep the solver generic enough to reuse on other one-equation problems.
- Use a procedure argument for the derivative function so the numerical method
  and the physical model stay separate.
- Include a small error helper because comparing approximate and exact arrays is
  a recurring task in numerical work.

## Starter code

`starter/main.f90` gives a narrower version to complete. Suggested learner tasks:

- print the exact value next to the numerical one
- experiment with two different step sizes
- replace the decay equation with another simple right-hand side

## Suggested extensions

- add a second method such as classical RK4
- write results to a text file for plotting
- solve logistic growth instead of exponential decay
- stop when the solution crosses a threshold instead of after a fixed step count
