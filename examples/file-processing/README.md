# file-processing

Reads numeric measurements from a data file, computes summary statistics,
and writes a formatted report to an output file.

**Companion lesson:** [05 — File I/O](../../lessons/05-file-io/)

## What it demonstrates

- `open` with `newunit=`, `status=`, `action=`
- Reading an unknown number of values with `iostat`
- Computing mean, min, max, and standard deviation
- Writing formatted results to a file
- Error handling on file open

## Source files

| File | Purpose |
| ---- | ------- |
| `app/main.f90` | Read-process-write pipeline |
| `data/measurements.txt` | Input: 7 temperature measurements |
| `data/particles.txt` | Input: x, y, mass columns (bonus data) |
| `fpm.toml` | Project metadata |

**Important:** run from the `examples/file-processing/` directory so the
`data/` path resolves correctly.

## Build and run

```bash
cd examples/file-processing
fpm run
```

## Expected output

```text
Read    7 measurements.
Mean:     22.114
Min:      18.500
Max:      25.400
Stddev:    2.321
 Report written to report.txt
```

After running, `report.txt` is created in the current directory.
