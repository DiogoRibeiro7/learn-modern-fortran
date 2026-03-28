# ODE solver

## Goal

Solve a very small initial value problem using the forward Euler method.

## What this teaches

- state update loops
- numerical approximation
- separating reusable numerical logic from the driver program

## Suggested first equation

Use:

- y'(t) = -y(t)
- y(0) = 1

The exact solution is `exp(-t)`, so it is a good teaching case.
