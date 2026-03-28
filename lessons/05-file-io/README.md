# Lesson 05 — File I/O

## Learning objectives

By the end of this lesson you will be able to:

- Open a file for reading or writing.
- Read numeric data from a text file line by line.
- Write formatted results to an output file.
- Handle end-of-file and errors with `iostat`.
- Explain what file units are and how `newunit` replaces hard-coded numbers.
- Build a complete read-process-write pipeline.

---

## The idea in one paragraph

Scientific programs rarely live on keyboard input alone. Real work starts with
data files — measurements, configurations, simulation parameters — and ends
with output files that other tools can plot or post-process. Fortran's I/O
system is designed around numbered **units** that connect your program to files
on disk. Modern Fortran simplifies this with `newunit`, which assigns unit
numbers automatically so you never hard-code magic numbers like `10` or `42`.

---

## File units — what they are

Every open file is associated with an integer called a **unit number**. Three
units are pre-connected:

| Unit | Connected to | Fortran name |
| ---- | ------------ | ------------ |
| 5 | Standard input (keyboard) | `input_unit` |
| 6 | Standard output (terminal) | `output_unit` |
| 0 | Standard error | `error_unit` |

These constants live in `iso_fortran_env`. For your own files, use `newunit=`
in the `open` statement and let the compiler pick a number.

---

## Opening and closing files

```fortran
program open_close
  implicit none

  integer :: u

  ! Open a file for writing. newunit assigns a unit number automatically.
  open(newunit=u, file="output.txt", status="replace", action="write")
  write(u, *) "Hello from Fortran"
  write(u, *) "This line goes to the file, not the screen."
  close(u)

  print *, "Wrote output.txt"
end program open_close
```

After running this, `output.txt` contains two lines. The key parts of `open`:

| Keyword | Meaning |
| ------- | ------- |
| `newunit=u` | Assign a fresh unit number to `u` |
| `file="output.txt"` | File name on disk |
| `status="replace"` | Create the file, or overwrite if it exists |
| `action="write"` | Open for writing only |

Other useful `status` values:

- `"old"` — file must already exist (use for reading).
- `"new"` — file must not already exist.
- `"unknown"` — compiler decides (the default, but less clear).

Always `close(u)` when you are done. It flushes buffers and frees the unit.

---

## Reading a file line by line

Suppose you have a file `temperatures.txt` with one number per line:

```text
18.2
21.5
19.7
22.1
20.3
```

The following program reads all values into an array and prints the mean.

```fortran
program read_temps
  implicit none

  integer :: u, ios, n, i
  real :: temp
  real :: total

  ! First pass: count lines
  open(newunit=u, file="temperatures.txt", status="old", action="read")
  n = 0
  do
    read(u, *, iostat=ios) temp
    if (ios /= 0) exit
    n = n + 1
  end do
  close(u)

  ! Second pass: read values
  open(newunit=u, file="temperatures.txt", status="old", action="read")
  total = 0.0
  do i = 1, n
    read(u, *) temp
    total = total + temp
  end do
  close(u)

  print *, "Read", n, "values"
  print *, "Mean:", total / real(n)
end program read_temps
```

**What to notice:**

- `status="old"` means the file must already exist.
- `action="read"` opens for reading only.
- `read(u, *, iostat=ios)` reads one value with list-directed formatting.
  When the file ends, `ios` becomes nonzero and the loop exits.
- The two-pass approach (count then read) is simple and works for small files.
  For large files you would use allocatable arrays or read into a fixed buffer.

---

## `iostat` — handling errors and end-of-file

The `iostat=` specifier captures the status of a read or write operation.

| Value of `iostat` | Meaning |
| ------------------ | ------- |
| `0` | Success |
| Negative | End-of-file reached |
| Positive | An error occurred (bad format, disk problem, etc.) |

```fortran
program iostat_demo
  implicit none

  integer :: u, ios
  real :: value

  open(newunit=u, file="data.txt", status="old", action="read", iostat=ios)
  if (ios /= 0) then
    print *, "Error: could not open data.txt"
    stop 1
  end if

  do
    read(u, *, iostat=ios) value
    if (ios < 0) then
      print *, "End of file reached."
      exit
    else if (ios > 0) then
      print *, "Warning: skipping a bad line."
      cycle
    end if
    print *, "Read:", value
  end do

  close(u)
end program iostat_demo
```

This pattern — check `iostat`, exit on EOF, skip or stop on errors — is the
standard way to process files of unknown length.

---

## Writing formatted output to a file

List-directed output (`write(u, *)`) works but the formatting is
compiler-dependent. For clean, reproducible output, use format strings.

```fortran
program write_formatted
  implicit none

  integer :: u, i
  real :: x

  open(newunit=u, file="squares.txt", status="replace", action="write")

  ! Header line
  write(u, '(A6, 2X, A12)') "n", "n_squared"

  do i = 1, 10
    x = real(i ** 2)
    write(u, '(I6, 2X, F12.2)') i, x
  end do

  close(u)
  print *, "Wrote squares.txt"
end program write_formatted
```

The file `squares.txt` will contain:

```text
     n     n_squared
     1         1.00
     2         4.00
     3         9.00
...
    10       100.00
```

**Format descriptors used:**

| Descriptor | Meaning |
| ---------- | ------- |
| `A6` | Character string, 6 columns |
| `I6` | Integer, 6 columns |
| `F12.2` | Real, 12 columns, 2 decimal places |
| `2X` | 2 blank spaces |

---

## End-to-end example: read, process, write

This is the core pattern for scientific data processing. The program reads
measurement data from one file, computes summary statistics, and writes a
report to another file.

**Input file `measurements.txt`:**

```text
23.1
19.8
25.4
22.0
18.5
24.7
21.3
```

**Program:**

```fortran
program process_data
  implicit none

  integer, parameter :: max_values = 1000
  real :: values(max_values)
  integer :: u_in, u_out, ios, n
  real :: mean_val, min_val, max_val

  ! --- Read ---
  open(newunit=u_in, file="measurements.txt", status="old", action="read")
  n = 0
  do
    read(u_in, *, iostat=ios) values(n + 1)
    if (ios /= 0) exit
    n = n + 1
    if (n >= max_values) exit
  end do
  close(u_in)

  if (n == 0) then
    print *, "No data read."
    stop 1
  end if

  ! --- Process ---
  mean_val = sum(values(1:n)) / real(n)
  min_val  = minval(values(1:n))
  max_val  = maxval(values(1:n))

  ! --- Write ---
  open(newunit=u_out, file="report.txt", status="replace", action="write")
  write(u_out, '(A, I6)')    "Count: ", n
  write(u_out, '(A, F10.3)') "Mean:  ", mean_val
  write(u_out, '(A, F10.3)') "Min:   ", min_val
  write(u_out, '(A, F10.3)') "Max:   ", max_val
  close(u_out)

  ! Also print to screen
  print '(A, I4, A)', "Processed ", n, " values."
  print '(A, F8.3)',  "Mean: ", mean_val
  print *, "Report written to report.txt"
end program process_data
```

**Output file `report.txt`:**

```text
Count:      7
Mean:     22.114
Min:      18.500
Max:      25.400
```

This read-process-write pattern scales from five-line scripts to thousand-line
analysis tools. The structure stays the same: open input, read in a loop,
close, compute, open output, write, close.

---

## Reading multi-column data

Many data files have several values per line. Read them all in one
`read` statement.

**Input file `particles.txt`:**

```text
1.0  2.0  0.5
3.0  4.0  1.0
5.0  6.0  1.5
```

Each line has x, y, and mass.

```fortran
program read_columns
  implicit none

  integer :: u, ios
  real :: x, y, mass

  open(newunit=u, file="particles.txt", status="old", action="read")

  do
    read(u, *, iostat=ios) x, y, mass
    if (ios /= 0) exit
    print '(A, F5.1, A, F5.1, A, F5.1)', &
      "  x=", x, "  y=", y, "  mass=", mass
  end do

  close(u)
end program read_columns
```

List-directed input (`*`) splits each line on spaces or commas automatically.
It handles most simple data formats without writing a custom parser.

---

## Best practices

- **Always use `newunit=`** instead of hard-coded unit numbers. It avoids
  conflicts when multiple parts of a program open files.
- **Always use `iostat=`** on reads from external files. Without it, a bad
  line or missing file causes your program to crash with no useful message.
- **Always `close()` files** when done. It flushes data and frees resources.
- **Use `status="old"` for input files** and `status="replace"` for output
  files. This makes intent clear and avoids silently creating files you meant
  to read.
- **Separate I/O from computation.** Read all data first, then process,
  then write results. This makes the code easier to test and refactor.

---

## Running the companion example

A runnable `fpm` project with sample data files is at `examples/file-processing/`:

```bash
cd examples/file-processing
fpm run
```

The project reads `data/measurements.txt`, computes statistics, and writes
`report.txt`.

---

## Exercises

See [exercises/intermediate/02-file-io.md](../../exercises/intermediate/02-file-io.md)
for practice problems based on this lesson.

---

## Key takeaways

- Files are connected to **unit numbers**. Use `newunit=` to get one automatically.
- `open` connects a file; `close` disconnects it.
- `read(u, *, iostat=ios)` reads with list-directed format and captures errors.
- `iostat` returns 0 for success, negative for EOF, positive for errors.
- Use `status="old"` for reading, `status="replace"` for writing.
- Format strings (`'(I6, F10.3)'`) give you precise control over output layout.
- The read-process-write pattern is the backbone of scientific data programs.

---

## Next step

Move to [Lesson 06 — Testing with fpm](../06-testing-with-fpm/README.md) to
learn how to add automated tests to your projects.
