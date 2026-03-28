# Examples

A curated library of runnable modern Fortran examples. Each example is a
standalone `fpm` project that you can build and run independently.

Every example folder contains:

- Source files (`.f90`)
- A `README.md` with description, build instructions, and expected output
- An `fpm.toml` project file

Some examples are intentionally run-only. Others include `src/` modules and
`test/` programs when the logic is reusable enough to benefit from automated
checks.

## How to run any example

```bash
cd examples/<example-name>
fpm run
```

Some examples also have tests:

```bash
fpm test
```

Examples with current test coverage:

- `arrays-procedures`
- `modules-types`
- `statistics`
- `vector-ops`

## Example index

Examples are listed from simplest to most complex.

### Fundamentals

| Folder | Topic | Companion lesson |
| ------ | ----- | ---------------- |
| [hello](hello/) | Minimal program, first `fpm` build | [01 — Setup](../lessons/01-setup/) |
| [basics](basics/) | Types, variables, constants, operators, formatted output | [02 — Basics](../lessons/02-basics/) |

### Arrays and numerical work

| Folder | Topic | Companion lesson |
| ------ | ----- | ---------------- |
| [arrays-procedures](arrays-procedures/) | Array operations, slicing, procedures in a module | [03 — Arrays and procedures](../lessons/03-arrays-procedures/) |
| [matrix-basics](matrix-basics/) | 2D arrays, `reshape`, `matmul`, `transpose` | -- |
| [statistics](statistics/) | Descriptive statistics module (mean, median, stddev) | -- |

### Modules and structure

| Folder | Topic | Companion lesson |
| ------ | ----- | ---------------- |
| [vector-ops](vector-ops/) | Module with public API, driver, and test suite | [04 — Modules](../lessons/04-modules-types/) |
| [modules-types](modules-types/) | Multi-file project with derived types | [04 — Modules](../lessons/04-modules-types/) |

### File I/O

| Folder | Topic | Companion lesson |
| ------ | ----- | ---------------- |
| [file-processing](file-processing/) | Read data, compute statistics, write report | [05 — File I/O](../lessons/05-file-io/) |

## Topic coverage

| Topic | Example |
| ----- | ------- |
| Hello world | [hello](hello/) |
| Variables and types | [basics](basics/) |
| Arrays and slicing | [arrays-procedures](arrays-procedures/) |
| 2D arrays and matrices | [matrix-basics](matrix-basics/) |
| Functions and subroutines | [arrays-procedures](arrays-procedures/) |
| Modules and visibility | [vector-ops](vector-ops/) |
| Derived types | [modules-types](modules-types/) |
| Statistical computation | [statistics](statistics/) |
| File reading and writing | [file-processing](file-processing/) |
| Testing with `fpm test` | [vector-ops](vector-ops/), [arrays-procedures](arrays-procedures/), [modules-types](modules-types/), [statistics](statistics/) |

## Test status

| Example | `fpm` status | Notes |
| ------- | ------------ | ----- |
| [hello](hello/) | Run-only | Minimal first program; no reusable module yet |
| [basics](basics/) | Run-only | Focuses on syntax and formatted output |
| [arrays-procedures](arrays-procedures/) | Tested | Reusable array utilities in `src/` |
| [matrix-basics](matrix-basics/) | Run-only | Matrix concepts are shown directly in the driver |
| [statistics](statistics/) | Tested | Reusable statistics functions in `src/` |
| [vector-ops](vector-ops/) | Tested | Primary testing example used by lesson 06 |
| [modules-types](modules-types/) | Tested | Reusable module functions and type-bound procedures |
| [file-processing](file-processing/) | Run-only | File I/O flow is currently demonstrated in `app/main.f90` |

## Project layout convention

Every example follows the standard `fpm` layout:

```text
example-name/
├── fpm.toml          Project metadata
├── README.md         Description and expected output
├── app/
│   └── main.f90      Executable entry point
├── src/              (optional) Modules and reusable code
│   └── *.f90
├── test/             (optional) Test programs
│   └── *.f90
└── data/             (optional) Input data files
    └── *.txt
```
