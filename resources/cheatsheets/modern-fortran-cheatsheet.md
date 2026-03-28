# Modern Fortran cheat sheet

## Skeleton program

```fortran
program main
  implicit none

  print *, "Hello, Modern Fortran"
end program main
```

## Variables

```fortran
integer :: n
real :: x
logical :: ok
character(len=20) :: name
```

## Conditionals

```fortran
if (n > 0) then
  print *, "positive"
else
  print *, "not positive"
end if
```

## Loops

```fortran
integer :: i

do i = 1, 5
  print *, i
end do
```

## Arrays

```fortran
real :: x(5)
x = [1.0, 2.0, 3.0, 4.0, 5.0]
print *, sum(x)
```

## Procedures in modules

```fortran
module math_utils
  implicit none
contains
  real function square(x)
    real, intent(in) :: x
    square = x * x
  end function square
end module math_utils
```

## Use a module

```fortran
program demo
  use math_utils, only: square
  implicit none

  print *, square(3.0)
end program demo
```

## Good defaults

- always write `implicit none`
- keep reusable logic in modules
- prefer explicit imports with `only:`
- keep `program` blocks small
