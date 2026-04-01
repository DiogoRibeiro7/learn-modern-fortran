# Learn Modern Fortran

A structured, example-driven course for learning **modern Fortran** from scratch.
Covers language fundamentals, code organization, testing, and applied numerical programming
using `fpm` (Fortran Package Manager) as the default workflow.

## Current status

The repository is coherent and usable as a teaching resource today, but it is
important to be precise about scope:

- lessons 01-06 and 09 are fully expanded
- lessons 07-08 are shorter guidance lessons rather than full deep-dive chapters
- examples and mini-projects are runnable standalone `fpm` packages
- reusable modules in examples and projects have lightweight tests where that is practical

See [lessons/README.md](lessons/README.md) for the per-lesson status table and
[RELEASE_NOTES_v1.0.md](RELEASE_NOTES_v1.0.md) for the publication-oriented summary.

## The role of `fpm`

This repository uses `fpm` as the default way to build, run, and test code, but
it does not force the whole course into one giant package. That is deliberate.

- `examples/` contains many small standalone `fpm` packages so learners can open
  one concept at a time
- `projects/` contains larger standalone `fpm` packages that feel closer to real
  numerical work
- lessons explain the concepts, while `fpm` gives a consistent hands-on workflow

This keeps the repo easy to understand: each example or project has its own
`fpm.toml`, its own entry point, and its own optional tests.

## Who this repo is for

- **Beginners** who want to learn Fortran with modern practices from day one.
- **Scientists and engineers** coming from Python, MATLAB, C, or Julia who need Fortran for performance-critical work.
- **Developers** who must read or modernize existing Fortran codebases.
- **Students** looking for a structured path rather than scattered tutorials.

## Prerequisites

- Basic programming experience in any language (variables, loops, functions).
- A computer where you can install command-line tools.
- No prior Fortran knowledge required.

## What you will learn

| Stage | Topics |
| ----- | ------ |
| Foundations | Compiler setup, `fpm`, variables, types, control flow, loops, I/O |
| Arrays and procedures | Array slicing, intrinsics, functions, subroutines, intent |
| Code structure | Modules, derived types, file I/O, testing with `fpm` |
| Applied work | Monte Carlo simulation, ODE solving, matrix operations |
| Advanced | C interoperability, reading and modernizing legacy Fortran |

## Quick start

```bash
# 1. Clone the repository
git clone https://github.com/your-user/learn-modern-fortran.git
cd learn-modern-fortran

# 2. Run the first example (requires gfortran and fpm)
cd examples/hello
fpm run

# 3. Start learning
# Open lessons/01-setup/README.md
```

If you do not have `gfortran` or `fpm` installed yet,
begin with [Lesson 01 — Setup](lessons/01-setup/README.md).

## `fpm` quick guide

These are the four commands learners will use most often.

### `fpm new`

Create a new project scaffold:

```bash
fpm new my_first_project
cd my_first_project
```

Use this when you want a clean starting point with an `fpm.toml` file and the
standard `app/`, `src/`, and optional `test/` layout.

### `fpm build`

Compile a project without running it:

```bash
cd examples/hello
fpm build
```

This is useful when you want to check whether code compiles cleanly.

### `fpm run`

Build and run the default executable:

```bash
cd examples/hello
fpm run
```

Some projects also accept command-line arguments:

```bash
cd projects/ode-solver
fpm run -- 0.05 20
```

### `fpm test`

Build and run test programs in the local package:

```bash
cd examples/vector-ops
fpm test
```

Use this for examples and projects that expose reusable logic through `src/`.
Folders that are currently demonstration-only may compile and run cleanly with
`fpm run` but intentionally do not have tests yet.

## Recommended learning path

Work through the lessons in order. Each lesson includes explanations, inline code,
and links to a companion example you can build and run.

| # | Lesson | Example | Exercises |
| - | ------ | ------- | --------- |
| 01 | [Setup](lessons/01-setup/README.md) | [hello](examples/hello/) | [beginner/00](exercises/beginner/00-setup.md) |
| 02 | [Types, variables, expressions](lessons/02-basics/README.md) | [basics](examples/basics/) | [beginner/01](exercises/beginner/01-basics.md) |
| 03 | [Arrays, control flow, procedures](lessons/03-arrays-procedures/README.md) | [arrays-procedures](examples/arrays-procedures/) | [beginner/02-04](exercises/README.md) |
| 04 | [Modules and derived types](lessons/04-modules-types/README.md) | [modules-types](examples/modules-types/) | [intermediate/01](exercises/intermediate/01-modules.md) |
| 05 | [File I/O](lessons/05-file-io/README.md) | [file-processing](examples/file-processing/) | [intermediate/02](exercises/intermediate/02-file-io.md) |
| 06 | [Testing with fpm](lessons/06-testing-with-fpm/README.md) | [vector-ops](examples/vector-ops/) | [intermediate/04](exercises/intermediate/04-testing.md) |
| 07 | [Numerical mini-projects](lessons/07-numerical-mini-projects/README.md) | -- | -- |
| 08 | [C interoperability](lessons/08-c-interop/README.md) | -- | -- |
| 09 | [Legacy to modern](lessons/09-legacy-to-modern/README.md) | -- | -- |

After lesson 07, explore the standalone projects:

- [monte-carlo-pi](projects/monte-carlo-pi/) — random sampling and convergence
- [ode-solver](projects/ode-solver/) — forward Euler method for ODEs
- [matrix-toolkit](projects/matrix-toolkit/) — 2D array operations and module design

## How to use this repo

### Self-study

Read a lesson, run its companion example with `fpm run`, solve the exercises,
then move to the next lesson.

### Classroom

Use each lesson folder as a weekly module. Assign the matching exercises as homework.
The `projects/` folder works well for end-of-unit assignments.

### Technical onboarding

If you already know another language, skim lessons 01-03, focus on lessons 04-06
for Fortran-specific structure, then jump into the projects.

## Repository structure

```text
learn-modern-fortran/
├── lessons/          Concept explanations with inline code
├── examples/         Runnable fpm projects that accompany lessons
├── exercises/        Practice problems with starter code and solutions
├── projects/         Larger standalone fpm projects
├── resources/        Cheat sheets, glossary, reading list
├── docs/             Editor setup, tooling notes, and style guide
├── ROADMAP.md        Development plan and progress
├── CONTRIBUTING.md   Contribution guidelines
└── AGENTS.md         Instructions for coding agents
```

Each major folder has its own `README.md` with a table of contents.

## Recommended toolchain

| Tool | Purpose |
| ---- | ------- |
| `gfortran` | Fortran compiler (GCC) |
| `fpm` | Build, run, and test projects |
| `fortls` | Language server for editor support |
| VS Code | Editor (with Modern Fortran extension) |

Full installation instructions are in [Lesson 01](lessons/01-setup/README.md).

## Running examples and tests

- Run an example or project with `fpm run` inside its folder.
- Compile without running via `fpm build`.
- Run automated checks with `fpm test` in folders that include a `test/`
  directory.
- See [examples/README.md](examples/README.md) for which examples are currently
  run-only versus tested.
- See [projects/README.md](projects/README.md) for the standalone mini-projects.

## Continuous integration

GitHub Actions provides lightweight CI for this repository. The workflows do two
simple things:

- build a set of key example packages with `fpm build`
- run `fpm test` in the examples and mini-projects that have reusable logic and
  test programs

The CI intentionally mirrors the commands learners run locally. It does not try
to turn the whole repository into one package, and it does not add a large build
matrix that would make the workflows harder to read than the lessons themselves.

## Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md) and [AGENTS.md](AGENTS.md).

## Roadmap

See [ROADMAP.md](ROADMAP.md) for the development plan and current progress.

## Release notes

- [CHANGELOG.md](CHANGELOG.md) tracks repository-level changes.
- [RELEASE_NOTES_v1.0.md](RELEASE_NOTES_v1.0.md) summarizes release readiness, strengths, and remaining gaps.

## License

[MIT](LICENSE)
