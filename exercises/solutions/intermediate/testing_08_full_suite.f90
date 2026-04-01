! Solution: Exercise 8 — Full test suite for a geometry module
! Comprehensive test covering circle_area, rectangle_area, triangle_area.
!
! In a real fpm project:
!   src/geometry.f90  — the module
!   test/test_geometry.f90  — this test program (with use geometry, only: ...)

program test_geometry_suite
  implicit none

  real, parameter :: tol = 1.0e-6
  real, parameter :: pi = acos(-1.0)

  ! --- circle_area tests ---
  call assert_close(circle_area(1.0), pi, tol, "circle_area(1) = pi")
  call assert_close(circle_area(0.0), 0.0, tol, "circle_area(0) = 0")
  call assert_close(circle_area(2.0), 4.0 * pi, tol, "circle_area(2) = 4*pi")

  ! --- rectangle_area tests ---
  call assert_close(rectangle_area(3.0, 4.0), 12.0, tol, "rect 3x4 = 12")
  call assert_close(rectangle_area(0.0, 5.0), 0.0, tol, "rect 0x5 = 0")
  call assert_close(rectangle_area(5.0, 0.0), 0.0, tol, "rect 5x0 = 0")

  ! Consistency: square is a special rectangle
  call assert_close(rectangle_area(7.0, 7.0), 49.0, tol, "rect 7x7 = 49")

  ! --- triangle_area tests ---
  call assert_close(triangle_area(6.0, 4.0), 12.0, tol, "tri b=6 h=4 = 12")
  call assert_close(triangle_area(0.0, 10.0), 0.0, tol, "tri b=0 h=10 = 0")
  call assert_close(triangle_area(10.0, 0.0), 0.0, tol, "tri b=10 h=0 = 0")

  ! --- cross-check ---
  ! A rectangle split diagonally gives two triangles of equal area
  call assert_close(2.0 * triangle_area(3.0, 4.0), rectangle_area(3.0, 4.0), &
    tol, "2 * triangle = rectangle")

  print *, "All geometry tests passed."

contains

  real function circle_area(r) result(a)
    real, intent(in) :: r
    a = pi * r * r
  end function circle_area

  real function rectangle_area(w, h) result(a)
    real, intent(in) :: w, h
    a = w * h
  end function rectangle_area

  real function triangle_area(b, h) result(a)
    real, intent(in) :: b, h
    a = 0.5 * b * h
  end function triangle_area

  subroutine assert_close(actual, expected, tolerance, message)
    real, intent(in) :: actual, expected, tolerance
    character(len=*), intent(in) :: message

    if (abs(actual - expected) > tolerance) then
      print *, "FAIL:", trim(message)
      print *, "  actual   =", actual
      print *, "  expected =", expected
      print *, "  diff     =", abs(actual - expected)
      error stop 1
    end if
  end subroutine assert_close

end program test_geometry_suite
