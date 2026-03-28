# learn-modern-fortran

Modern Fortran 2023 learning repository with lessons, exercises, `fpm`-based projects, and practical scientific programming examples.

## Goal

This repository is meant to teach **modern Fortran**, not old fixed-form habits first.

The focus is:

- Fortran with a modern style
- `fpm` from day one
- modules, derived types, and reusable code
- numerical and scientific programming patterns
- a small section on reading legacy Fortran later on

The intent is simple: a learner should be able to go from zero to writing, testing, and structuring real Fortran projects.

## Who this is for

This repo is a good fit for:

- beginners who want to learn Fortran seriously
- scientists and engineers coming from Python, MATLAB, C, or Julia
- developers who need to read or modernize existing Fortran code
- students who want a structured path instead of scattered examples

## What “modern Fortran” means here

This repository is organized around:

- free-form source
- `implicit none`
- modules instead of loose global procedures
- explicit `public` and `private`
- derived types for clean data structures
- `fpm` for builds and tests
- clean folder layout
- numerical examples that resemble real work

## Repository map

```text
learn-modern-fortran/
├── README.md
├── ROADMAP.md
├── AGENTS.md
├── CONTRIBUTING.md
├── LICENSE
├── lessons/
├── examples/
├── exercises/
├── projects/
├── resources/
└── docs/
```

## Learning path

### 1. Setup
Learn how to install a compiler, `fpm`, and an editor setup that makes Fortran pleasant to use.

Start here:

- `lessons/01-setup/README.md`
- `docs/editor-setup.md`

### 2. Core language
Learn variables, kinds, control flow, arrays, procedures, and strings.

Continue with:

- `lessons/02-basics/README.md`
- `lessons/03-arrays-procedures/README.md`

### 3. Real code structure
Learn modules, derived types, file I/O, and testing.

Then move to:

- `lessons/04-modules-types/README.md`
- `lessons/05-file-io/README.md`
- `lessons/06-testing-with-fpm/README.md`

### 4. Applied numerical work
Build small but real scientific computing examples.

Use:

- `lessons/07-numerical-mini-projects/README.md`
- `projects/monte-carlo-pi/`
- `projects/ode-solver/`
- `projects/matrix-toolkit/`

### 5. Advanced and transition topics
Read about C interoperability and how to approach legacy code safely.

Finish with:

- `lessons/08-c-interop/README.md`
- `lessons/09-legacy-to-modern/README.md`

## Included examples

### `examples/hello-fpm`
Your first small `fpm` project.

### `examples/vector-ops`
A slightly more realistic package with:

- a module
- an executable
- a test target

### Mini-projects
The `projects/` folder contains starter educational projects that can become full teaching units.

## Quick start

### 1. Enter the first example

```bash
cd examples/hello-fpm
```

### 2. Run it

```bash
fpm run
```

### 3. Try the vector example

```bash
cd ../vector-ops
fpm test
fpm run
```

## Recommended toolchain

A good default stack is:

- `gfortran`
- `fpm`
- `fortls`
- Visual Studio Code or another editor with Fortran support

See `lessons/01-setup/README.md` and `docs/editor-setup.md`.

## Teaching philosophy

This repository does **not** start by teaching outdated patterns as the default.

Instead, it teaches:

1. how to write clean code now
2. how to structure code for reuse
3. how to test and package it
4. how to read older code once the foundations are already solid

## Suggested usage

A learner can move through the repo in three ways:

### Path A — self-study
Read a lesson, run the example, solve the exercise, then move on.

### Path B — classroom
Use each lesson folder as a weekly module and each exercise folder as homework.

### Path C — fast technical onboarding
Read the setup lesson, basics lesson, modules lesson, and then jump into the mini-projects.

## Push to GitHub

From inside the repository root:

```bash
gh repo create learn-modern-fortran \
  --public \
  --source=. \
  --remote=origin \
  --push \
  --description "Modern Fortran 2023 learning repository with lessons, exercises, fpm-based projects, and practical scientific programming examples."
```

Suggested topics:

```text
fortran modern-fortran fortran-2023 scientific-computing numerical-methods hpc fpm education tutorial programming-language
```

## What to build next

See `ROADMAP.md`.

The next natural step is:

- expand every lesson with worked examples
- add solutions for all exercises
- add benchmark and profiling lessons
- add a section on testing numerical code
- add one larger scientific project at the end

## Contributing

Please read `CONTRIBUTING.md` and `AGENTS.md`.
