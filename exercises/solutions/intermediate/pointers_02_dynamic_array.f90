program pointers_02_dynamic_array
  implicit none
  integer :: n, i
  real, pointer :: arr(:)

  print *, 'Enter n (e.g., 5):'
  read *, n

  allocate(arr(n))

  do i = 1, n
    arr(i) = real(i * i)
  end do

  print *, 'arr =', arr

  deallocate(arr)
  print *, 'associated(arr)=', associated(arr)

end program pointers_02_dynamic_array
