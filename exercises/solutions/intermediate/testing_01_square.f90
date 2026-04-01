! Solution: Exercise 1 — Test a square function
! This solution includes both the module and the test program.
! In a real fpm project, the module goes in src/ and the test in test/.

! --- src/math_basics.f90 ---
! module math_basics
!   implicit none
!   private
!   public :: square
! contains
!   integer function square(n) result(res)
!     integer, intent(in) :: n
!     res = n * n
!   end function square
! end module math_basics

! --- test/test_math_basics.f90 ---
program test_math_basics
  ! In a real fpm project, uncomment the use statement:
  ! use math_basics, only: square
  implicit none

  ! Inline square function for standalone compilation
  if (square(0) /= 0) then
    print *, "FAIL: square(0) should be 0"
    error stop 1
  end if

  if (square(3) /= 9) then
    print *, "FAIL: square(3) should be 9"
    error stop 1
  end if

  if (square(-5) /= 25) then
    print *, "FAIL: square(-5) should be 25"
    error stop 1
  end if

  if (square(1) /= 1) then
    print *, "FAIL: square(1) should be 1"
    error stop 1
  end if

  print *, "All math_basics tests passed."

contains

  integer function square(n) result(res)
    integer, intent(in) :: n
    res = n * n
  end function square

end program test_math_basics
