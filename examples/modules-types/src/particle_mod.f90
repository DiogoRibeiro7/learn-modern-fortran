module particle_mod
  implicit none
  private
  public :: particle_t

  type :: particle_t
    real :: x    = 0.0
    real :: y    = 0.0
    real :: vx   = 0.0
    real :: vy   = 0.0
    real :: mass = 1.0
  contains
    procedure :: kinetic_energy
    procedure :: speed
    procedure :: describe
  end type particle_t

contains

  real function kinetic_energy(self)
    class(particle_t), intent(in) :: self
    kinetic_energy = 0.5 * self%mass * (self%vx ** 2 + self%vy ** 2)
  end function kinetic_energy

  real function speed(self)
    class(particle_t), intent(in) :: self
    speed = sqrt(self%vx ** 2 + self%vy ** 2)
  end function speed

  subroutine describe(self)
    class(particle_t), intent(in) :: self

    print '(A, F7.2, A, F7.2)', " Position: (", self%x, ",", self%y
    print '(A, F7.2, A, F7.2)', " Velocity: (", self%vx, ",", self%vy
    print '(A, F7.2)',          " Mass:      ", self%mass
    print '(A, F7.2)',          " Speed:     ", self%speed()
    print '(A, F7.2)',          " KE:        ", self%kinetic_energy()
  end subroutine describe

end module particle_mod
