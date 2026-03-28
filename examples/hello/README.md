# hello

The simplest possible `fpm` project. Prints a greeting to the terminal.

**Companion lesson:** [01 — Setup](../../lessons/01-setup/)

## What it demonstrates

- Minimal `program` / `end program` structure
- `implicit none`
- `print *` for terminal output
- `fpm.toml` project configuration

## Source files

| File | Purpose |
| ---- | ------- |
| `app/main.f90` | Program entry point |
| `fpm.toml` | Project metadata |

## Build and run

```bash
cd examples/hello
fpm run
```

## Expected output

```text
 Hello from learn-modern-fortran
 This is a small fpm project.
```
