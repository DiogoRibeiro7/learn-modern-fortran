# statistics

A descriptive statistics module that computes mean, median, variance,
standard deviation, and a summary report for any real array.

## What it demonstrates

- Module with `private` default and selective `public` exports
- Functions operating on assumed-shape arrays
- A `describe` subroutine that prints a complete statistical summary
- A private helper (`bubble_sort`) used only by `median`
- Practical numerical computation on realistic data sets

## Source files

| File | Purpose |
| ---- | ------- |
| `src/descriptive_stats.f90` | Module: `mean`, `median`, `variance`, `stddev`, `describe` |
| `app/main.f90` | Driver: statistics on student scores and daily temperatures |
| `test/test_descriptive_stats.f90` | Test program for the reusable statistics functions |
| `fpm.toml` | Project metadata |

## Build and run

```bash
cd examples/statistics
fpm run
fpm test
```

## Expected output

```text
 === Student scores ===
  Count:      10
  Mean:       84.600
  Median:     86.500
  Stddev:      7.476
  Min:        70.000
  Max:        95.000

 === Daily temperatures ===
  Count:       7
  Mean:       20.371
  Median:     20.300
  Stddev:      1.688
  Min:        17.800
  Max:        23.000

Score mean:  84.600
Score median: 86.500
Temp stddev:   1.688
```
