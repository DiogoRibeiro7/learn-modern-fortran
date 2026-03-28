# Editor setup

## Recommended default

A practical beginner setup is:

- `gfortran`
- `fpm`
- `fortls`
- VS Code with Fortran support

This combination is simple and gives you:

- syntax highlighting
- hover information
- symbol navigation
- package-based builds
- an easier path to tests and larger examples

## What to configure

### Compiler
Install a recent Fortran compiler first.

### `fpm`
Install the Fortran Package Manager and confirm it works:

```bash
fpm --version
```

### Language server
Install `fortls` and connect it in your editor.

### Suggested editor features
Look for:

- format support
- symbol outline
- go to definition
- diagnostics
- integrated terminal

## Good beginner habit

Always compile and run small examples early. Do not wait until you have written a large file to test whether your setup works.
