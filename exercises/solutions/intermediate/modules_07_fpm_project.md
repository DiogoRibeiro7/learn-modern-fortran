# Exercise 7 — Statistics module as an fpm project (solution walkthrough)

## Directory structure

```text
my-stats/
├── fpm.toml
├── src/
│   └── stats_utils.f90
└── app/
    └── main.f90
```

## fpm.toml

```toml
name = "my_stats"
version = "0.1.0"
```

## src/stats_utils.f90

```fortran
module stats_utils
  implicit none
  private
  public :: mean, stddev

contains

  real function mean(x)
    real, intent(in) :: x(:)
    mean = sum(x) / real(size(x))
  end function mean

  real function stddev(x)
    real, intent(in) :: x(:)
    real :: m
    m = mean(x)
    stddev = sqrt(sum((x - m) ** 2) / real(size(x)))
  end function stddev

end module stats_utils
```

## app/main.f90

```fortran
program main
  use stats_utils, only: mean, stddev
  implicit none

  real :: data(5)
  data = [1.0, 3.0, 5.0, 7.0, 9.0]

  print *, "Mean:  ", mean(data)
  print *, "Stddev:", stddev(data)
end program main
```

## Build and run

```bash
cd my-stats
fpm run
```
