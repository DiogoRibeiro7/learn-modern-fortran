# AGENTS.md

## Purpose

This file gives instructions to coding agents and contributors working on this repository.

The repository teaches **modern Fortran**, with a focus on clarity, correctness, and educational value.

## High-level rules

1. Prefer modern Fortran style.
2. Do not introduce outdated patterns as defaults.
3. Keep lessons educational and incremental.
4. Keep examples small, runnable, and well scoped.
5. Add comments only where they help understanding.
6. Preserve a clean structure across lessons, examples, exercises, and projects.

## Style expectations

- use `implicit none`
- prefer free-form source
- use modules for reusable logic
- keep one main concept per file when possible
- use descriptive variable names
- keep executable programs thin and move logic into modules
- use explicit interfaces naturally through modules
- use `private` by default in modules when it improves clarity

## Educational expectations

When adding content:

- explain what problem the code solves
- explain what the learner should notice
- keep code short enough to read in one pass
- add one or two reflective questions where useful
- prefer worked examples before advanced abstractions

## Testing expectations

- when an example grows into reusable logic, add tests
- use tolerance-aware checks for floating-point comparisons
- avoid brittle tests tied to exact floating-point printing

## What to avoid

Do not add these as recommended defaults:

- implicit typing
- fixed-form source as the main teaching style
- common blocks in beginner content
- large monolithic files
- hidden global state
- unnecessary preprocessor tricks

## Folder responsibilities

- `lessons/`: concept explanations and guided code reading
- `examples/`: runnable, minimal teaching examples
- `exercises/`: learner tasks
- `projects/`: larger educational builds
- `resources/`: cheat sheets, glossary, references
- `docs/`: repo-level documentation

## Preferred contribution pattern

1. add or refine a lesson
2. attach or update a runnable example
3. add or update exercises
4. add tests when logic is reusable
5. update the README or ROADMAP if structure changed
