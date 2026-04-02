# Changelog

All notable repository-level changes are recorded here.

## [v0.8] - 2026-03-15

### Added

- new lesson 06: testing with `fpm`, custom assertion patterns, and numeric tolerance strategies
- new lesson 07: numerical mini-projects (Monte Carlo π, ODE solver, matrix toolkit) with testing discipline
- new lesson 08: C interop using `iso_c_binding`, Fortran/C call examples, and build/link guidance
- release planning notes in [ROADMAP.md](ROADMAP.md) and milestone definition for v0.8
- release summary in [RELEASE_NOTES_v1.0.md](RELEASE_NOTES_v1.0.md) covering v0.8 work

### Changed

- updated project and lesson structure to make 06-08 explicit milestone path in README

### Fixed

- (no functional code changes in v0.8 docs work)

## [v0.9] - 2026-04-02

### Added

- plan for lesson 10: advanced performance and parallel programming
- roadmap entry describing coarrays/OpenMP and benchmark projects
- new CI workflow for v0.9 package matrix validation

### Changed

- added v0.9 planning checkpoint in ROADMAP

### Fixed

- N/A (planning update only)

## [v1.0] - 2026-03-28

### Added

- expanded project teaching artifacts for `monte-carlo-pi`, `ode-solver`, and `matrix-toolkit`
- tests for reusable logic in multiple examples and all three mini-projects
- lightweight GitHub Actions CI for build checks and `fpm test`
- lesson 09 on reading and modernizing legacy Fortran
- repository style guide in [docs/style-guide.md](docs/style-guide.md)
- release documentation in [RELEASE_NOTES_v1.0.md](RELEASE_NOTES_v1.0.md)

### Changed

- improved top-level README with clearer `fpm` guidance, CI explanation, and current-status notes
- standardized `fpm.toml` usage across examples and projects
- improved project READMEs with problem statements, learning goals, starter code, and extensions
- strengthened the examples index to distinguish run-only packages from tested packages
- updated lessons, exercises, and resource links for better internal navigation

### Fixed

- corrected stale links to removed or renamed exercise files
- fixed compile-cleanliness issues in representative example drivers
- aligned lesson and project indexes with the repository's current teaching structure
