# Release Notes — v1.0

## Summary

`learn-modern-fortran` is now in a coherent, publishable state as a serious
teaching repository for modern Fortran. The repository combines lessons,
runnable `fpm` examples, exercises with worked solutions, and small
numerical mini-projects.

This is a **release-quality teaching resource**, not a claim that every planned
lesson is equally deep. The strongest parts of the repository are the core
language lessons, the example packages, the exercises, and the tested
mini-projects.

## What this release includes

- fully expanded lessons for setup, basics, arrays and procedures, modules and
  derived types, file I/O, and legacy-to-modern refactoring
- concise guidance lessons for testing with `fpm`, numerical mini-projects, and
  C interoperability
- runnable standalone `fpm` examples across the main teaching topics
- exercise sets with worked solutions for beginner and intermediate material
- mini-projects with starter code, reference implementations, and tests
- lightweight CI to build key examples and run `fpm test` where available

## Release readiness checklist

- [x] top-level README reflects the current repository structure
- [x] major folder indexes exist for lessons, examples, exercises, projects, and resources
- [x] stale high-visibility links were corrected
- [x] reusable example modules have lightweight tests where appropriate
- [x] mini-projects include documentation, starter code, and tests
- [x] CI validates representative builds and package tests
- [x] contributor guidance includes a repository style guide
- [x] legacy-modernization content is present and practical
- [x] lessons 06-08 are fully expanded to the same depth as lessons 01-05 and 09

## What CI validates

- `fpm build` for representative example packages
- `fpm test` for tested example packages
- `fpm test` for the three mini-project packages

CI is intentionally simple. It mirrors the commands learners are expected to run
locally instead of introducing a large or opaque build matrix.

## Remaining gaps

These are real gaps, not hidden caveats:

- lessons 06-08 are still short guidance lessons rather than full long-form chapters
- there is not yet a capstone project beyond the current mini-project set
- some examples are intentionally run-only and do not yet have tests because they
  are demonstration drivers rather than reusable modules
- the release has been checked locally and through CI configuration, but the
  repository still depends on learners having a working Fortran toolchain installed

## Recommended publication framing

Describe this repository as:

- a structured modern Fortran learning track
- strongest on foundations, code organization, exercises, and applied mini-projects
- still open to future expansion in testing depth, interop depth, and advanced topics

## Next improvements after v1.0

- plan and implement v0.9 with advanced parallelism, performance, and coarray/OpenMP content
- expand lessons 06-08 to match the depth of the earlier lessons
- add one larger capstone project
- extend the reading list and glossary with more cross-links
- add more numerical validation examples and debugging workflows
