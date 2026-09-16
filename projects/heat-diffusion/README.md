# 1D Heat/Diffusion Solver

A verified finite-difference solver for the one-dimensional heat equation,
implemented in modern Fortran with both serial and OpenMP update kernels.

This project is intended as a scientific-computing artifact rather than a syntax
exercise. The numerical method, stability restriction, analytical verification
target, convergence behaviour, and parallel correctness are all explicit.

## Problem

We solve

```text
u_t = alpha u_xx,       0 < x < 1, t > 0
u(0,t) = u(1,t) = 0
u(x,0) = sin(pi x)
```

For this initial condition the exact solution is

```text
u(x,t) = exp(-alpha*pi^2*t) sin(pi*x).
```

That gives a direct verification target at every grid point and every output time.

## Numerical method

The solver uses the explicit forward-time centered-space scheme

```text
u_i^{n+1} = u_i^n + r (u_{i-1}^n - 2u_i^n + u_{i+1}^n),
```

where

```text
r = alpha*dt/dx^2.
```

For the 1D heat equation, the standard FTCS stability condition is

```text
r <= 1/2.
```

The project rejects configurations that violate that condition.

## Verification strategy

The automated tests check three different claims:

1. the initial/boundary condition is represented correctly;
2. serial and OpenMP kernels produce the same numerical solution;
3. grid refinement reduces the L2 error with ratios consistent with second-order
   behaviour when `dt` is chosen proportional to `dx^2`.

The third test is important. A solver can be stable and still be implemented
incorrectly. Convergence against a known analytical solution checks the numerical
method as a whole.

## Why the expected order is two

FTCS is first order in time and second order in space:

```text
error = O(dt) + O(dx^2).
```

The convergence test keeps the nondimensional number `r` approximately fixed, so

```text
dt = O(dx^2).
```

Both error contributions are therefore `O(dx^2)`. Halving `dx` should reduce the
error by roughly a factor of four once the grid is in the asymptotic regime.

The test deliberately uses a tolerant lower bound rather than asserting an exact
ratio of four.

## Package structure

```text
heat-diffusion/
├── app/
│   └── main.f90
├── src/
│   └── heat_diffusion.f90
├── test/
│   └── test_heat_diffusion.f90
├── ARCHITECTURE.md
└── fpm.toml
```

## Run

```bash
cd projects/heat-diffusion
fpm run
```

The executable reports grid spacing, time step, stability number, L2 error against
the analytical solution, and the maximum difference between serial and OpenMP
solutions.

## Test

```bash
fpm test
```

CI tests numerical correctness. It does **not** claim OpenMP speedup.
Performance measurements belong in a controlled benchmark harness with machine,
compiler, optimization, thread-count, and repetition metadata.

## Current scope

Included now:

- homogeneous Dirichlet boundary conditions;
- explicit FTCS integration;
- analytical sine-mode verification;
- serial reference kernel;
- OpenMP stencil kernel;
- L2 error metric;
- automated grid-convergence test.

Deliberately deferred:

- benchmark harness;
- multiple initial conditions;
- non-zero or time-dependent boundaries;
- implicit schemes;
- 2D domains;
- checkpoint/restart and scientific file formats.

Those should be added only when they deepen the engineering story rather than
turning the project into an unbounded PDE library.
