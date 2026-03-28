# Lesson 01 — Your first Fortran program

## Learning objectives

By the end of this lesson you will be able to:

- Explain what Fortran is and why it is still used.
- Explain what "modern Fortran" means.
- Install a Fortran compiler and `fpm` on your operating system.
- Write, compile, and run a small Fortran program.
- Describe the basic structure of a Fortran source file.
- Explain why `implicit none` matters.
- Declare a simple variable and print its value.

---

## What is Fortran today

Fortran is one of the oldest programming languages still in active use.
It was created in the 1950s for scientific and engineering computation,
and it remains a first-class choice for that work today.

Modern Fortran code powers:

- weather and climate models
- computational fluid dynamics
- structural and finite-element analysis
- high-energy physics simulations
- linear algebra libraries (LAPACK, BLAS)

Fortran is not a museum language. It received major standard updates in 1990,
1995, 2003, 2008, 2018, and 2023. Each one added features that other modern
languages also have: modules, derived types, array operations, generics,
and concurrency primitives.

## What "modern Fortran" means

In this repository, "modern Fortran" means:

- **Free-form source** — no fixed-column rules from the 1960s.
- **`implicit none`** — every variable must be declared explicitly.
- **Modules** — organize code into reusable units instead of loose files.
- **`fpm`** — use the Fortran Package Manager to build, run, and test projects.
- **Explicit interfaces** — the compiler can check your function calls.

We teach these practices from the start. Legacy patterns (fixed-form, common
blocks, implicit typing) are covered later in [Lesson 09](../09-legacy-to-modern/README.md)
so you can read old code, but they are never the default style.

---

## Setting up your environment

You need two tools: a compiler and `fpm`. A language server is optional but
helpful.

| Tool | Purpose |
| ---- | ------- |
| `gfortran` | Compiles Fortran source code into executables (part of GCC) |
| `fpm` | Builds, runs, and tests Fortran projects with a single command |
| `fortls` | Language server that gives your editor hover info and diagnostics (optional) |

### Install a compiler

#### Linux (Debian / Ubuntu)

```bash
sudo apt update
sudo apt install gfortran
```

#### Linux (Fedora)

```bash
sudo dnf install gcc-gfortran
```

#### macOS

```bash
brew install gcc
```

This installs `gfortran` as part of the GCC package.

#### Windows

The simplest option is [MSYS2](https://www.msys2.org/):

1. Download and install MSYS2 from the official site.
2. Open the **MSYS2 UCRT64** terminal.
3. Run:

```bash
pacman -S mingw-w64-ucrt-x86_64-gcc-fortran
```

Alternatively, install [WSL](https://learn.microsoft.com/en-us/windows/wsl/)
and follow the Linux instructions.

#### Verify the compiler

```bash
gfortran --version
```

You should see something like:

```text
GNU Fortran (GCC) 13.x.x
```

Any recent version (12 or later) works.

### Install fpm

`fpm` is the Fortran Package Manager. It replaces Makefiles and manual
compiler commands with a single tool.

```bash
# Conda — works on all platforms
conda install -c conda-forge fpm

# Homebrew — macOS and Linux
brew install fpm
```

On Windows with MSYS2:

```bash
pacman -S mingw-w64-ucrt-x86_64-fpm
```

You can also download a binary from the
[fpm releases page](https://github.com/fortran-lang/fpm/releases).

#### Verify fpm

```bash
fpm --version
```

### Install a language server (optional)

`fortls` gives your editor hover information, go-to-definition, and diagnostics.

```bash
pip install fortls
```

See [docs/editor-setup.md](../../docs/editor-setup.md) for VS Code, Neovim,
and Emacs configuration.

---

## Your first program

Create a file called `hello.f90`:

```fortran
program hello
  implicit none

  print *, "Hello, Modern Fortran!"
end program hello
```

Every line has a purpose:

| Line | What it does |
| ---- | ------------ |
| `program hello` | Starts a program unit named `hello` |
| `implicit none` | Requires every variable to be declared — no guessing |
| `print *, "..."` | Prints text to the terminal |
| `end program hello` | Ends the program unit |

### Compile and run manually

```bash
gfortran hello.f90 -o hello
./hello
```

Expected output:

```text
 Hello, Modern Fortran!
```

The leading space in the output is normal. Fortran's list-directed formatting
(`print *`) adds a space at the beginning of each line.

### Compile and run with fpm

Navigate to the companion example:

```bash
cd examples/hello
fpm run
```

Expected output:

```text
 Hello from learn-modern-fortran
 This is a small fpm project.
```

When you run `fpm run`, fpm reads `fpm.toml`, compiles `app/main.f90`,
links the result, and runs it. No Makefile needed.

---

## The fpm project layout

```text
hello/
├── fpm.toml        Project metadata
└── app/
    └── main.f90    Program entry point
```

The `fpm.toml` file describes the project:

```toml
name = "hello_fpm"
version = "0.1.0"
license = "MIT"
author = "Diogo Ribeiro"
```

As projects grow you add `src/` for modules and `test/` for test programs.

---

## Why `implicit none` matters

Without `implicit none`, Fortran uses an old rule: variables starting with
`i` through `n` are integers, and everything else is a real number. The
compiler will not warn you if you mistype a variable name — it will silently
create a new variable with the default type.

Here is what that looks like:

```fortran
! WARNING: this program has a bug caused by implicit typing.
! Do not copy this style.
program no_implicit_none
  ! implicit none is missing on purpose

  real :: velocity
  velocity = 10.0
  print *, "velocity =", velocty    ! typo: "velocty" instead of "velocity"
end program no_implicit_none
```

This program compiles without errors. The misspelled `velocty` is silently
created as a new variable initialized to `0.0`. The output is:

```text
 velocity =   0.00000000
```

Adding `implicit none` turns this into a compile-time error:

```text
Error: Symbol 'velocty' has no IMPLICIT type
```

**Rule: always write `implicit none` on the line after `program`.**
This catches typos, undeclared variables, and type mismatches at compile time
instead of at runtime.

---

## Introducing variables

Declare variables between `implicit none` and the first executable statement.
The `::` separates the type from the name.

```fortran
program variables_demo
  implicit none

  integer :: year
  real :: temperature
  character(len=20) :: city

  year = 2026
  temperature = 18.5
  city = "Lisbon"

  print *, "Year:       ", year
  print *, "Temperature:", temperature
  print *, "City:       ", trim(city)
end program variables_demo
```

Compile and run:

```bash
gfortran variables_demo.f90 -o variables_demo
./variables_demo
```

Expected output:

```text
 Year:                2026
 Temperature:   18.5000000
 City:        Lisbon
```

**What to notice:**

- `integer` holds whole numbers: 0, 1, -42.
- `real` holds decimal numbers: 3.14, -0.001.
- `character(len=20)` holds a string of up to 20 characters. Use `trim()` to
  remove the trailing spaces when printing.
- Every variable must be declared before use. This is what `implicit none` enforces.

The full set of Fortran types (including `logical`, `complex`, and kind
parameters) is covered in [Lesson 02](../02-basics/README.md).

---

## Printing output

`print *` uses list-directed formatting — the compiler chooses the layout:

```fortran
program print_demo
  implicit none

  integer :: a
  real :: b

  a = 42
  b = 3.14

  print *, "a =", a
  print *, "b =", b
  print *, "a and b:", a, b
end program print_demo
```

Expected output:

```text
 a =          42
 b =   3.14000010
 a and b:          42   3.14000010
```

The `*` in `print *` means "use free format." The extra spaces and the number
of decimal places are chosen by the compiler. This is fine for learning and
quick checks. Formatted output is covered in later lessons.

---

## Compiler options worth knowing

When compiling with `gfortran`, these flags help catch bugs early:

```bash
gfortran -Wall -Wextra -fcheck=all -g hello.f90 -o hello
```

| Flag | What it does |
| ---- | ------------ |
| `-Wall` | Enable common warnings |
| `-Wextra` | Enable additional warnings |
| `-fcheck=all` | Add runtime checks (array bounds, integer overflow) |
| `-g` | Include debug symbols for use with a debugger |
| `-O2` | Optimize for speed (use for final builds, not debugging) |
| `-std=f2018` | Enforce compliance with the Fortran 2018 standard |

If you use `fpm`, you can pass flags through the `fpm.toml` file or on the command line:

```bash
fpm run --flag "-Wall -Wextra -fcheck=all"
```

Other compilers use different flag names:

| Compiler | Warnings | Runtime checks | Standard compliance |
| -------- | -------- | -------------- | ------------------- |
| `gfortran` | `-Wall -Wextra` | `-fcheck=all` | `-std=f2018` |
| `ifx` (Intel) | `-warn all` | `-check all` | `-stand f18` |
| `nvfortran` (NVIDIA) | `-Minform=warn` | `-Mbounds` | (no direct flag) |

You do not need to memorize these now. The important habit is: **turn on
warnings while learning.** They catch real bugs.

---

## Common beginner mistakes

### Forgetting `implicit none`

Without it, typos silently create new variables (see the example above).
Always include it.

### Missing `end program`

Every `program` block must close with `end program`:

```fortran
program oops
  implicit none
  print *, "Where is the end?"
  ! Compiler error: missing 'end program'
```

### Using the wrong file extension

Fortran compilers treat `.f90` as free-form source and `.f` as old fixed-form.
Always use `.f90` for modern Fortran.

### Forgetting that `print *` adds a leading space

```text
 Hello, Modern Fortran!
^
This space is normal. Do not try to remove it — it comes from list-directed output.
```

### Using `=` instead of `==` in comparisons

`=` is assignment. `==` is comparison. This is the same rule as C and Python.

```fortran
! Assignment — sets x to 5
x = 5

! Comparison — tests whether x equals 5
if (x == 5) print *, "five"
```

---

## Putting it together

This example combines everything from the lesson: program structure,
`implicit none`, variables, simple arithmetic, and printed output.

```fortran
program rectangle
  implicit none

  real :: width, height, area, perimeter

  width = 4.0
  height = 7.0
  area = width * height
  perimeter = 2.0 * (width + height)

  print *, "Width:    ", width
  print *, "Height:   ", height
  print *, "Area:     ", area
  print *, "Perimeter:", perimeter
end program rectangle
```

Expected output:

```text
 Width:       4.00000000
 Height:      7.00000000
 Area:        28.0000000
 Perimeter:   22.0000000
```

---

## Running the companion example

A runnable `fpm` project for this lesson is at `examples/hello/`:

```bash
cd examples/hello
fpm run
```

---

## Exercises

See [exercises/beginner/00-setup.md](../../exercises/beginner/00-setup.md) for
practice problems based on this lesson.

---

## Key takeaways

- Fortran is a modern, actively maintained language used for scientific and
  high-performance computing.
- "Modern Fortran" means free-form source, `implicit none`, modules, and `fpm`.
- Every program starts with `program` and ends with `end program`.
- `implicit none` is required on the second line — it catches typos and
  undeclared variables at compile time.
- Use `print *` for quick output.
- Declare variables with their type and `::` before using them.
- Use `-Wall -Wextra -fcheck=all` (gfortran) to catch bugs while learning.
- Use `.f90` as the file extension for all modern Fortran source.

---

## Next step

Move to [Lesson 02 — Basics](../02-basics/README.md) to learn about all the
built-in types, control flow, and loops.
