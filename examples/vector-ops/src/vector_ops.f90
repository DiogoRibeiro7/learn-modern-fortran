module vector_ops
  implicit none
  private

  public :: vector_mean
  public :: dot_product_safe
  public :: euclidean_norm

contains

  real function vector_mean(x) result(mean_value)
    real, intent(in) :: x(:)

    if (size(x) == 0) then
      error stop "vector_mean requires a non-empty vector"
    end if

    mean_value = sum(x) / real(size(x))
  end function vector_mean

  real function dot_product_safe(x, y) result(value)
    real, intent(in) :: x(:)
    real, intent(in) :: y(:)

    if (size(x) /= size(y)) then
      error stop "dot_product_safe requires vectors of the same size"
    end if

    value = sum(x * y)
  end function dot_product_safe

  real function euclidean_norm(x) result(value)
    real, intent(in) :: x(:)

    value = sqrt(sum(x * x))
  end function euclidean_norm

end module vector_ops
