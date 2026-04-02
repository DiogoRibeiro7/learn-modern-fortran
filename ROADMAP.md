# Roadmap

## Vision

Build a complete learning repository for **modern Fortran** that teaches
language fundamentals, code organization, testing, and applied numerical programming.

A learner should be able to move from first contact with Fortran
to writing structured, tested, and packaged projects.

Current status: release-quality candidate toward v1.0.

---

## v0.1 — Foundations (complete)

Give the learner a working environment and the core language building blocks.

### v0.1 deliverables

- Full setup lesson with installation instructions for Linux, macOS, and Windows
- Basics lesson with variables, types, kinds, control flow, loops, and I/O
- Arrays and procedures lesson with slicing, intrinsics, functions, subroutines, and intent
- Three companion example projects: `hello`, `basics`, `arrays-procedures`
- Beginner exercises with hints, starter code, and worked solutions
- Repository structure, README, ROADMAP, CONTRIBUTING, and AGENTS documentation

---

## v0.2 — Structure and reuse (substantially complete)

Teach how to organize code into modules, define custom types, and test with `fpm`.

### v0.2 planned content

- Expand lesson 04 (modules and derived types) with inline code and worked examples
- Expand lesson 05 (file I/O) with reading, writing, and status handling
- Expand lesson 06 (testing with fpm) with test structure and floating-point tolerances
- `vector-ops` example with module, executable, and test target (exists, needs lesson linkage)
- Intermediate exercises with solutions

### v0.2 current state

- Lessons 04, 05, and 06 are fully expanded
- `modules-types`, `statistics`, and `vector-ops` examples reinforce module structure
- Intermediate exercises and worked solutions are present, including 8 testing exercises

---

## v0.3 — Applied numerical work (substantially complete)

Move from syntax to scientific programming through small, complete projects.

### v0.3 planned content

- Expand lesson 07 (numerical mini-projects) with method explanations and validation
- Monte Carlo pi estimation walkthrough
- Forward Euler ODE solver walkthrough
- Matrix toolkit walkthrough
- Error analysis and convergence notes
- Tests for all three projects

### v0.3 current state

- `monte-carlo-pi`, `ode-solver`, and `matrix-toolkit` are documented teaching projects
- All three projects include starter code, reference implementations, and tests
- Lesson 07 exists as a concise bridge into the project set

---

## v0.4 — Engineering practice (partially complete)

Teach learners to work like developers, not only like script writers.

### v0.4 planned content

- Style guide and formatting conventions
- Documentation conventions
- Testing numerical tolerances in depth
- Debugging patterns and compiler flags
- Simple CI configuration for example projects

### v0.4 current state

- style guide added
- lightweight CI added for builds and tested `fpm` packages
- repository documentation is more consistent, though advanced debugging guidance is still pending

---

## v0.8 — Testing, projects, and interop (in progress)

Button up the final pre-v1.0 chapter depth by expanding lessons 06, 07, and 08 with practical, tested content.

### v0.8 deliverables

- Fully expanded lesson 06 with explicit `fpm test` patterns, assertion helpers, and tolerance guidance
- Fully expanded lesson 07 with mini-project walkthroughs (Monte Carlo π, Euler ODE, matrix toolkit) and test strategy
- Fully expanded lesson 08 with `iso_c_binding`, Fortran↔C call examples, array layout notes, and build/link commands
- Update release notes and roadmap with v0.8 success markers
- Confirm CI test matrix includes `fpm test` for vector-ops and all three projects

### v0.8 current state

- content expanded in lessons 06-08
- release notes updated with v0.8 section
- roadmap now includes a v0.8 milestone
- pending: CI baseline verification in workflow

---

## v0.5 — Interoperability and performance (partially complete)

Show where Fortran fits into larger systems and how to get the best performance.

### v0.5 planned content

- Expand lesson 08 (C interoperability) with `iso_c_binding` examples
- Memory layout and column-major performance implications
- Profiling basics
- Compiler flags by compiler family (gfortran, ifort, ifx)
- Numerical precision and stability notes

### v0.5 current state

- lesson 08 exists as a short orientation lesson
- deeper interop and performance coverage is still a future improvement

---

## v0.6 — Legacy to modern (complete)

Help learners read existing Fortran codebases without adopting poor style.

### v0.6 planned content

- Expand lesson 09 (legacy to modern) with side-by-side examples
- Fixed-form overview
- Common legacy patterns and their modern replacements
- Refactoring recipes: common blocks to modules, implicit to explicit
- Migration exercises

### v0.6 current state

- Lesson 09 expanded with practical reading and modernization guidance
- Side-by-side before/after examples for fixed-form, `COMMON`, and procedure organization
- Modernization checklist and numerical-risk notes added

---

## v0.9 — Advanced performance and parallelism (planned)

Extend the learning path with deeper performance engineering and parallel programming topics.

### v0.9 planned content

- New lesson 10 and examples for coarrays and OpenMP
- Performance patterns for array memory layout and vectorization
- Provide hands-on project: `examples/parallel-matrix` with `fpm` tests
- Add intermediate exercises with solutions for coarrays/OpenMP
- Enhance CI with a v0.9 validation workflow and benchmark checks

### v0.9 current state

- roadmap and initial direction defined
- v0.8 complete, transition to v0.9 in progress

---

## v1.0 — Complete learning track

### v1.0 success criteria

- All nine lessons fully expanded with inline code and explanations
- All examples compile and run
- All exercises have worked solutions
- All projects have walkthroughs
- Documentation polished and cross-linked
- Repository ready for public teaching use

### Current assessment against v1.0

- examples, exercises, projects, and repository documentation are in strong shape
- lessons 01-05, 06-08, and 09 now meet the "fully expanded" bar
- the repository is publishable now with a strong v0.8 delivery and v1.0 stabilization checklist
- future work can focus on capstone projects, advanced performance topics, and optional tools (pFUnit, LAPACK/BLAS)

---

## Nice-to-have additions (beyond v1.0)

- Coarrays overview
- OpenMP introduction
- LAPACK and BLAS integration lesson
- Testing with pFUnit or similar frameworks
- Larger capstone project
- Visual diagrams for memory layout and array storage
