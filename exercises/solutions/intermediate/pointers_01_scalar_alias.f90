program pointers_01_scalar_alias
  implicit none

  real :: x
  real, pointer :: p

  x = 3.14
  p => x

  print *, 'Before: x=', x, ' p=', p

  p = 2.718

  print *, 'After : x=', x, ' p=', p

end program pointers_01_scalar_alias
