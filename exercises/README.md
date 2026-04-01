# Exercises

A progressive practice track for self-learners. Each exercise set targets
one topic, maps to a specific lesson, and is ordered from easy to hard.

**Difficulty scale:** ★ easy, ★★ moderate, ★★★ challenging.

## How to use

1. Read the exercise description, learning goal, and hints.
2. Write your solution as a standalone `.f90` file or a small `fpm` project.
3. Compile and test. Use `gfortran -Wall -Wextra -fcheck=all` to catch bugs.
4. Compare with the worked solutions only after you have tried on your own.

## Lesson-to-exercise mapping

| Lesson | Exercise set | Topic focus | Exercises |
| ------ | ------------ | ----------- | --------- |
| [01 — Setup](../lessons/01-setup/) | [beginner/00-setup.md](beginner/00-setup.md) | First programs, `implicit none`, compiling | 7 |
| [02 — Basics](../lessons/02-basics/) | [beginner/01-basics.md](beginner/01-basics.md) | Variables, arithmetic, operators, formatting | 9 |
| [03 — Arrays, control flow, procedures](../lessons/03-arrays-procedures/) | [beginner/02-control-flow.md](beginner/02-control-flow.md) | `if`/`else`, `select case`, `do`, `do while`, `exit`, `cycle` | 8 |
| [03 — Arrays, control flow, procedures](../lessons/03-arrays-procedures/) | [beginner/03-arrays.md](beginner/03-arrays.md) | Array creation, slicing, intrinsics, element-wise ops, 2D | 8 |
| [03 — Arrays, control flow, procedures](../lessons/03-arrays-procedures/) | [beginner/04-procedures.md](beginner/04-procedures.md) | Functions, subroutines, `intent`, `result`, assumed-shape | 8 |
| [04 — Modules](../lessons/04-modules-types/) | [intermediate/01-modules.md](intermediate/01-modules.md) | Modules, `use`/`only`, derived types, type-bound procedures | 10 |
| [05 — File I/O](../lessons/05-file-io/) | [intermediate/02-file-io.md](intermediate/02-file-io.md) | File reading, writing, `iostat`, data pipelines | 8 |
| [Core Fortran pointers](../lessons/03-arrays-procedures/) | [intermediate/03-pointers.md](intermediate/03-pointers.md) | Pointer association, target, allocatable, recursive objects | 4 |

**Total: 58 exercises across 7 sets.**

## By topic

| Topic | Exercise set |
| ----- | ------------ |
| Variables and arithmetic | [01-basics.md](beginner/01-basics.md) |
| Control flow | [02-control-flow.md](beginner/02-control-flow.md) |
| Arrays | [03-arrays.md](beginner/03-arrays.md) |
| Procedures | [04-procedures.md](beginner/04-procedures.md) |
| Modules | [01-modules.md](intermediate/01-modules.md) |
| File I/O | [02-file-io.md](intermediate/02-file-io.md) |
| Pointers | [03-pointers.md](intermediate/03-pointers.md) |

## Solutions

Worked solutions are in [solutions/](solutions/).
Each solution is a complete, runnable program with comments on key decisions.

See [solutions/README.md](solutions/README.md) for a full listing.
