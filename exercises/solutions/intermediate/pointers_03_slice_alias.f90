program pointers_03_slice_alias
  implicit none
  real, target :: data(10)
  real, pointer :: sub(:)
  integer :: i

  data = [(real(i), i = 1, 10)]
  sub => data(4:7)

  print *, 'Before data =', data

  sub = sub * 10.0

  print *, 'After data  =', data
  print *, 'sub =', sub

end program pointers_03_slice_alias
