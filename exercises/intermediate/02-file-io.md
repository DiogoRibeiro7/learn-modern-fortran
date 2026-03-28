# Intermediate exercises — File I/O

**Companion lesson:** [Lesson 05 — File I/O](../../lessons/05-file-io/README.md)

**What you will practice:**

- Opening and closing files with `newunit`
- Reading data line by line with `iostat`
- Writing formatted results to output files
- Handling end-of-file and errors
- Building a complete read-process-write pipeline

Several exercises require small input files. Create them by hand or use the
sample files provided in the solutions folder.

---

## Exercise 1 — Write a greeting file ★

**Learning goal:** Open a file for writing and close it.

Write a program that opens a file called `greeting.txt`, writes three lines
to it, and closes it. After running, verify the file exists and contains the
expected text.

**Requirements:**

- Use `newunit=` and `status="replace"`.
- Write at least three lines using `write(u, *)`.

---

## Exercise 2 — Count lines in a file ★

**Learning goal:** Read until end-of-file using `iostat`.

Write a program that opens a text file and counts how many lines it contains.
Use `iostat` to detect the end of the file. Print the count.

**Test file `numbers.txt`:**

```text
10.0
20.0
30.0
40.0
50.0
```

Expected output: 5 lines.

---

## Exercise 3 — Sum from a file ★★

**Learning goal:** Accumulate values read from a file in a loop.

Write a program that reads real numbers from a file (one per line), computes
their sum, and prints the result. Use `iostat` to handle end-of-file.

**Test file `values.txt`:**

```text
3.5
7.2
1.8
4.5
```

Expected sum: 17.0.

---

## Exercise 4 — File statistics ★★

**Learning goal:** Read into an array and compute summary statistics.

Write a program that reads a file of real numbers and computes the count,
sum, mean, min, and max. Print the results with formatted output.

**Test file `scores.txt`:**

```text
85.0
92.0
78.0
95.0
88.0
70.0
```

Expected mean: 84.667.

---

## Exercise 5 — Read and write: squared values ★★

**Learning goal:** Read from one file and write transformed data to another.

Write a program that reads numbers from `input.txt`, computes the square of
each, and writes the results to `output.txt`. Each line of the output should
contain both the original value and its square.

**Input file `input.txt`:**

```text
2.0
5.0
8.0
```

**Expected output file `output.txt`:**

```text
  2.00      4.00
  5.00     25.00
  8.00     64.00
```

**Hint:** Use a format string like `'(F6.2, 2X, F9.2)'`.

---

## Exercise 6 — Multi-column data ★★

**Learning goal:** Read multiple values per line with list-directed input.

Write a program that reads a file where each line has a student name and a
score, separated by spaces. Compute and print the average score.

**Test file `students.txt`:**

```text
Alice 88.0
Bob 72.0
Carol 95.0
David 81.0
```

**Hint:** Use `character(len=20) :: name` and `real :: score` in one
`read` statement: `read(u, *, iostat=ios) name, score`.

Expected average: 84.0.

---

## Exercise 7 — Robust file open ★★

**Learning goal:** Use `iostat` on `open` for graceful error handling.

Write a program that attempts to open a file. If the file does not exist,
print a clear error message and stop gracefully instead of crashing.

**Requirements:**

- Use `iostat=` on the `open` statement.
- Test with a file name that does not exist.
- Print: `"Error: could not open <filename>"`.

---

## Exercise 8 — Complete pipeline ★★★

**Learning goal:** Build a full read-process-write data pipeline.

Write a complete read-process-write program:

1. Read x-y coordinate pairs from `points.txt` (two values per line).
2. Compute the distance from the origin for each point.
3. Write a table to `distances.txt` with columns: x, y, distance.
4. Also write the maximum distance at the bottom of the file.

**Test file `points.txt`:**

```text
3.0  4.0
1.0  1.0
6.0  8.0
0.0  5.0
```

**Expected output file `distances.txt`:**

```text
     x       y  distance
  3.00    4.00      5.00
  1.00    1.00      1.41
  6.00    8.00     10.00
  0.00    5.00      5.00
Max distance:     10.00
```

---

## Reflection

After completing these exercises, think about:

- How does `iostat` change the way your programs handle unexpected data?
- When would you use formatted output vs list-directed output?
- What is the advantage of reading all data first, then processing?

---

## Solutions

Worked solutions are in
[exercises/solutions/intermediate/](../solutions/intermediate/).
Each solution file name starts with `fileio_`. Sample data files are provided
alongside the solutions.
