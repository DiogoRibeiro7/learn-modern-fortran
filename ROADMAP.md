# ROADMAP

## Vision

Build a serious learning repository for **modern Fortran 2023** that teaches both language fundamentals and project-level practice.

The repository should help a learner move from:

- first contact with Fortran
- to clean modular code
- to packaged and tested projects
- to practical numerical programs
- to reading and modernizing legacy Fortran

---

## v0.1 — Foundations

### Goal
Give the learner a clean on-ramp.

### Content
- repository structure
- setup lesson
- basics lesson
- arrays and procedures lesson
- `hello-fpm` example
- first beginner exercises

### Done in this scaffold
- yes

---

## v0.2 — Structure and reuse

### Goal
Teach how to write maintainable code.

### Content
- modules and derived types
- file I/O
- `fpm` testing
- vector operations example with tests
- intermediate exercises

### Done in this scaffold
- partially

---

## v0.3 — Applied numerical work

### Goal
Move from syntax to scientific programming.

### Content
- Monte Carlo estimation
- Euler ODE solver
- matrix utilities
- lesson on numerical mini-projects
- error analysis and validation notes

### Done in this scaffold
- starter projects included

---

## v0.4 — Better engineering practice

### Goal
Teach learners how to work like developers, not only like script writers.

### Planned additions
- formatting and style guide
- documentation conventions
- testing numerical tolerances
- debug patterns
- simple CI for example projects
- issue templates and GitHub labels

---

## v0.5 — Interoperability and performance

### Goal
Show where Fortran becomes especially useful in larger systems.

### Planned additions
- ISO C binding examples
- memory layout discussion
- profiling basics
- vectorization notes
- compiler flags by compiler family
- notes on numerical precision and stability

---

## v0.6 — Legacy to modern

### Goal
Help learners read existing codebases without adopting poor style.

### Planned additions
- fixed-form overview
- common legacy patterns
- refactoring recipes
- replacing common blocks with modules
- safer interfaces
- migration exercises

---

## v1.0 — Complete learning track

### Success criteria
- all lessons expanded
- all examples runnable
- all exercises have solutions
- mini-projects have walkthroughs
- documentation polished
- repository ready for public teaching use

---

## Nice-to-have additions

- coarrays overview
- OpenMP introduction
- LAPACK and BLAS lesson
- testing with pFUnit or similar tools
- larger capstone project
- notebooks or visual diagrams to support explanations

---

## Content design principles

- teach modern defaults first
- keep examples small but real
- prefer one concept per lesson
- include exercises early
- show project structure from the start
- do not hide the engineering side of scientific code
