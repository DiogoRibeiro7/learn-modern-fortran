# Architecture and Numerical Contract

## Components

`src/heat_diffusion.f90` owns the numerical model and exposes a small API:

- `make_grid`
- `sine_initial_condition`
- `sine_exact_solution`
- `evolve_serial`
- `evolve_openmp`
- `l2_error`

`app/main.f90` is an executable verification run. It chooses one reproducible
configuration and reports numerical diagnostics.

`test/test_heat_diffusion.f90` verifies the numerical contract independently of
the demonstration executable.

## State model

Both evolution routines update a one-dimensional state vector `u(:)` in place.
A second array stores the next time level. Boundary values are imposed explicitly
at every step.

The serial and OpenMP routines intentionally share the same finite-difference
formula. That makes the serial path a reference implementation for testing the
parallel decomposition.

## Parallel decomposition

Each interior grid point at time `n+1` depends only on three values from time `n`:

```text
u(i-1), u(i), u(i+1).
```

Because all reads come from the old state and every loop iteration writes to a
distinct `next(i)`, the interior update is data-parallel and race-free.

The OpenMP region parallelizes only the interior stencil. Boundary updates and the
state swap/copy remain outside the parallel loop.

## Numerical invariants

The current project treats these as executable contracts:

1. `alpha > 0`;
2. `dx > 0` and `dt > 0`;
3. at least three spatial grid points;
4. `alpha*dt/dx^2 <= 0.5`;
5. zero Dirichlet boundaries remain zero;
6. serial and OpenMP kernels agree within floating-point tolerance;
7. refinement decreases error against the analytical solution.

## Verification versus validation

This project performs **verification**: it checks whether the discretization and
implementation reproduce a problem with a known analytical solution.

It does not claim physical validation against experimental heat-transfer data.
The distinction matters: agreement with the manufactured/analytical problem is
evidence about numerical correctness, not about a particular material model.

## Future engineering layers

The next useful additions are operational rather than more syntax:

- reproducible benchmark runner with warm-up and repeated timings;
- CSV/JSON metadata recording compiler, flags, thread count, and machine details;
- optional checkpoint files for long runs;
- stronger conservation/energy diagnostics for more general boundary conditions.
