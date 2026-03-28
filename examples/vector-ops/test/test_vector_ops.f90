program test_vector_ops
  use vector_ops, only: vector_mean, dot_product_safe, euclidean_norm
  implicit none

  real, parameter :: tol = 1.0e-6
  real :: x(3)
  real :: y(3)

  x = [1.0, 2.0, 3.0]
  y = [4.0, 5.0, 6.0]

  call assert_close(vector_mean(x), 2.0, tol, "vector_mean failed")
  call assert_close(dot_product_safe(x, y), 32.0, tol, "dot_product_safe failed")
  call assert_close(euclidean_norm(x), sqrt(14.0), tol, "euclidean_norm failed")

  print *, "All vector_ops tests passed."

contains

  subroutine assert_close(actual, expected, tolerance, message)
    real, intent(in) :: actual
    real, intent(in) :: expected
    real, intent(in) :: tolerance
    character(len=*), intent(in) :: message

    if (abs(actual - expected) > tolerance) then
      print *, trim(message)
      print *, "actual   =", actual
      print *, "expected =", expected
      error stop 1
    end if
  end subroutine assert_close

end program test_vector_ops
