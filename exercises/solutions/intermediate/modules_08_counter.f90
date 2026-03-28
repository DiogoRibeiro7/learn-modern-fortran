! Exercise 8 — Counter with encapsulation

module counter_mod
  implicit none
  private
  public :: counter_t

  type :: counter_t
    private
    integer :: n = 0
  contains
    procedure :: increment
    procedure :: add
    procedure :: get_value
    procedure :: reset
  end type counter_t

contains

  subroutine increment(self)
    class(counter_t), intent(inout) :: self
    self%n = self%n + 1
  end subroutine increment

  subroutine add(self, amount)
    class(counter_t), intent(inout) :: self
    integer, intent(in) :: amount
    self%n = self%n + amount
  end subroutine add

  integer function get_value(self)
    class(counter_t), intent(in) :: self
    get_value = self%n
  end function get_value

  subroutine reset(self)
    class(counter_t), intent(inout) :: self
    self%n = 0
  end subroutine reset

end module counter_mod


program test_counter
  use counter_mod, only: counter_t
  implicit none

  type(counter_t) :: c

  call c%increment()
  call c%increment()
  call c%increment()
  call c%add(10)

  print *, "Value:", c%get_value()    ! expected: 13

  call c%reset()
  print *, "After reset:", c%get_value()    ! expected: 0
end program test_counter
