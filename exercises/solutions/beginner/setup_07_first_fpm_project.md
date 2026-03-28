# Exercise 7 — Your first fpm project (solution walkthrough)

## Directory structure

```text
my-first-project/
├── fpm.toml
└── app/
    └── main.f90
```

## fpm.toml

```toml
name = "my_first_project"
version = "0.1.0"
```

## app/main.f90

```fortran
program main
  implicit none

  print *, "This is my first fpm project."
  print *, "It works!"
end program main
```

## Build and run

```bash
cd my-first-project
fpm run
```

## Expected output

```text
 This is my first fpm project.
 It works!
```

## What fpm did

1. Read `fpm.toml` to find the project name and settings.
2. Compiled `app/main.f90` using the system Fortran compiler.
3. Linked the compiled object into an executable.
4. Ran the executable and printed its output.

No Makefile, no CMake, no manual compiler flags needed.
