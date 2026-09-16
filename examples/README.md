# Examples

A curated library of standalone `fpm` packages, from language fundamentals to
numerical and parallel programming.

## Run and test

```bash
cd examples/<example-name>
fpm run
```

Packages with reusable logic also expose tests:

```bash
fpm test
```

## Example index

| Example | Main topic | Tested |
| --- | --- | :---: |
| [hello](hello/) | Minimal program and first `fpm` build | No |
| [basics](basics/) | Types, variables, expressions | No |
| [arrays-procedures](arrays-procedures/) | Arrays, slicing, procedures | Yes |
| [matrix-basics](matrix-basics/) | 2D arrays, `matmul`, `transpose` | No |
| [statistics](statistics/) | Reusable descriptive statistics | Yes |
| [vector-ops](vector-ops/) | Modules, public APIs, testing | Yes |
| [modules-types](modules-types/) | Derived types and multi-file structure | Yes |
| [file-processing](file-processing/) | File I/O and reusable processing logic | Yes |
| [parallel-matrix](parallel-matrix/) | OpenMP, memory layout, parallel numerical equivalence | Yes |

## Parallel example

`parallel-matrix` is the companion package for
[Lesson 10](../lessons/10-parallel-performance/). It computes independent column
norms using serial and OpenMP implementations and verifies numerical equivalence
with `fpm test`.

The example reports timing for inspection, but the tests do not assert speedup.
Performance claims require a controlled benchmark environment rather than a shared
CI runner.

## Layout convention

```text
example-name/
├── fpm.toml
├── README.md
├── app/
│   └── main.f90
├── src/              # optional reusable modules
├── test/             # optional fpm tests
└── data/             # optional fixtures
```
