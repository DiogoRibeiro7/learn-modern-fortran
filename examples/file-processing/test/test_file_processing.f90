program test_file_processing
  use file_processing_mod, only: read_measurements, compute_statistics
  implicit none

  real, allocatable :: values(:)
  real :: mean_val, min_val, max_val, std_val
  real, parameter :: tol = 1.0e-6
  integer :: n, ios, i
  character(len=128) :: path

  ! Test 1: compute_statistics normal case
  allocate(values(3))
  values = [1.0, 2.0, 3.0]
  call compute_statistics(values, 3, mean_val, min_val, max_val, std_val)
  if (abs(mean_val - 2.0) > tol .or. min_val /= 1.0 .or. max_val /= 3.0 .or. abs(std_val - sqrt(2.0/3.0)) > tol) then
    print *, 'FAIL: compute_statistics normal case'
    error stop 1
  end if

  ! Test 2: compute_statistics with n=0
  call compute_statistics(values, 0, mean_val, min_val, max_val, std_val)
  if (mean_val /= 0.0 .or. min_val /= 0.0 .or. max_val /= 0.0 .or. std_val /= 0.0) then
    print *, 'FAIL: compute_statistics n=0'
    error stop 1
  end if

  deallocate(values)

  ! Test 3: read_measurements valid file
  path = 'test_data_measurements.txt'
  open(newunit=i, file=path, status='replace', action='write')
  write(i,*) 10.0, 20.0, 30.0, 40.0, 50.0
  close(i)

  allocate(values(10))
  call read_measurements(path, values, n, ios)
  if (ios /= 0 .or. n /= 5) then
    print *, 'FAIL: read_measurements valid file (open/read) - ios=', ios, 'n=', n
    error stop 1
  end if
  if (any(abs(values(1:n) - [10.0,20.0,30.0,40.0,50.0]) > tol)) then
    print *, 'FAIL: read_measurements valid file values mismatch'
    error stop 1
  end if
  deallocate(values)

  ! clean up temporary file (cross-platform no shell command)
  ! We rely on CI to use ephemeral workspaces; no explicit deletion required

  ! Test 4: read_measurements nonexistent file
  call read_measurements('no_such_file.txt', values, n, ios)
  if (ios == 0) then
    print *, 'FAIL: read_measurements nonexistent file should set ios nonzero'
    error stop 1
  end if

  print *, 'PASS: file-processing tests'
end program test_file_processing
