! Exercise 6 — Rectangle type with type-bound procedures

module rectangle_mod
  implicit none
  private
  public :: rect_t

  type :: rect_t
    real :: width  = 0.0
    real :: height = 0.0
  contains
    procedure :: area
    procedure :: is_square
  end type rect_t

contains

  real function area(self)
    class(rect_t), intent(in) :: self
    area = self%width * self%height
  end function area

  logical function is_square(self)
    class(rect_t), intent(in) :: self
    is_square = abs(self%width - self%height) < 1.0e-6
  end function is_square

end module rectangle_mod


program test_rectangle
  use rectangle_mod, only: rect_t
  implicit none

  type(rect_t) :: sq, r

  sq = rect_t(width=5.0, height=5.0)
  r  = rect_t(width=3.0, height=7.0)

  print *, "Square:    area =", sq%area(), " is_square:", sq%is_square()
  print *, "Rectangle: area =", r%area(), " is_square:", r%is_square()
end program test_rectangle
