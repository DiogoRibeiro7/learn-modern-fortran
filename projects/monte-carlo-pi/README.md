# Monte Carlo Pi

Estimate `pi` by throwing random points into the unit square and counting how
many land inside the quarter circle.

This project turns a familiar classroom example into a small experiment you can
build, run, test, and extend.

## Problem statement

If `(x, y)` is sampled uniformly from `[0, 1] x [0, 1]`, then the fraction of
points inside the quarter circle `x^2 + y^2 <= 1` should approach `pi / 4`.
That gives the estimator

```text
pi ~= 4 * (points inside circle) / (total points)
```

The estimate is noisy for small sample counts and becomes more stable as the
sample count grows.

## Learning goals

- use `random_number` for simple simulation work
- separate reusable simulation logic from the command-line driver
- observe convergence instead of trusting a single run
- test deterministic core logic even when the full program is random

## Project layout

| File | Purpose |
| ---- | ------- |
| `src/monte_carlo_pi.f90` | Reusable simulation logic |
| `app/main.f90` | CLI driver with convergence reporting |
| `test/test_monte_carlo_pi.f90` | Deterministic test for the geometric counting logic |
| `starter/main.f90` | Smaller scaffold for learners to complete |

## Build and run

```bash
cd projects/monte-carlo-pi
fpm run
fpm run -- 200000 40000
fpm test
```

The optional command-line arguments are:

1. `n_samples`
2. `report_interval`

So `fpm run -- 200000 40000` uses 200,000 random points and prints a progress
line every 40,000 samples.

## What to notice

- The reusable module does not print anything. It only computes data.
- The driver handles user input and presentation.
- The test targets `estimate_pi_from_points`, which is deterministic and easy to
  reason about.
- The convergence table shows that Monte Carlo estimates improve slowly:
  doubling the sample count does not halve the error.

## Key design choices

- Keep the random experiment in a module so the same logic can later be reused
  by exercises or benchmarks.
- Expose a deterministic helper based on arrays of points. That gives us a clean
  test target without trying to make the random number generator predictable.
- Report intermediate estimates, because convergence is part of the lesson, not
  just the final answer.

## Starter code

`starter/main.f90` gives a smaller version with TODO markers. A learner can:

- replace the fixed sample count with command-line input
- print the absolute error against `acos(-1.0_real64)`
- extend the single estimate into a convergence study

## Suggested extensions

- repeat the experiment several times and compare the spread of results
- write convergence data to a file for plotting
- compare one large run against many smaller runs with the same total work
- estimate the area of a different 2D shape
