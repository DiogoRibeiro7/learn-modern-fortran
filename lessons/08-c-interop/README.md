# Lesson 08 — C interoperability

## Why this lesson matters

Fortran is frequently embedded in C applications or needs to call C libraries. A robust `iso_c_binding` interface is essential to build mixed-language software.

## What you should learn

- the purpose and usage of `iso_c_binding`
- mapping Fortran types to C types safely
- how to write callable subroutines/functions for C and call C from Fortran
- how to compile and link mixed C/Fortran code

## `iso_c_binding` essentials

- `integer(c_int)` maps to C `int`
- `real(c_double)` maps to C `double`
- `character(kind=c_char)` maps to C `char`
- use `bind(c, name='...')` for stable symbol names

## Example: Fortran function called from C

Fortran (`src/c_interop_mod.f90`):

```fortran
module c_interop_mod
  use iso_c_binding
  implicit none
contains
  function c_add(a, b) result(r) bind(c, name='c_add')
    integer(c_int), value :: a, b
    integer(c_int) :: r
    r = a + b
  end function c_add
end module c_interop_mod
```

C (`app/caller.c`):

```c
#include <stdio.h>

extern int c_add(int *a, int *b); // if no value attribute fruitless
// or with modern gfortran ABI: int c_add(int a, int b);

int main(void) {
    int x = 2, y = 3;
    int r = c_add(x, y);
    printf("c_add(%d,%d)=%d\n", x, y, r);
    return 0;
}
```

Build:

```bash
gfortran -c src/c_interop_mod.f90
gcc -c app/caller.c
gfortran -o c_interop app/c_interop_mod.o caller.o
./c_interop
```

## Example: Fortran calls C with arrays

C helper (`src/c_utils.c`):

```c
#include <stddef.h>

double c_dot(const double *a, const double *b, size_t n) {
    double sum = 0.0;
    for (size_t i = 0; i < n; ++i) {
        sum += a[i] * b[i];
    }
    return sum;
}
```

Fortran wrapper (`src/c_utils_mod.f90`):

```fortran
module c_utils_mod
  use iso_c_binding
  implicit none
contains
  function dot_from_c(a, b, n) result(r)
    real(c_double), intent(in) :: a(:), b(:)
    integer(c_size_t), value :: n
    real(c_double) :: r
    r = c_dot(a, b, n)
  end function dot_from_c
end module
```

Notes:
- Fortran arrays are column-major. When passing 1D arrays, layout is contiguous and compatible.
- For 2D arrays, flatten with `reshape` or pass explicit strides carefully.

## Error handling and debugging

- check compile and link symbols with `nm`/`objdump` for name mangling.
- use `bind(c, name='...')` to avoid compiler-dependent symbol decoration.
- validate pointer and array bounds, especially with `c_ptr` and `c_f_pointer`.

## Suggested practice

- implement a `projects/matrix-toolkit` wrapper that calls a tiny C routine for `dot` and `matmul` on 1D arrays
- add tests in `projects/matrix-toolkit/test` for C-interoperable implementations
- expand `lessons/09-legacy-to-modern` with a quick interop recipe

## Suggested next step

Move to [Lesson 09 — Legacy to modern](../09-legacy-to-modern/README.md).
