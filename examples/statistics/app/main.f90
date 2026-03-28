program main
  use descriptive_stats, only: mean, median, stddev, describe
  implicit none

  real :: scores(10)
  real :: temps(7)

  ! --- Student scores ---
  scores = [85.0, 92.0, 78.0, 95.0, 88.0, 70.0, 82.0, 91.0, 76.0, 89.0]

  print *, "=== Student scores ==="
  call describe(scores)
  print *

  ! --- Daily temperatures ---
  temps = [18.2, 21.5, 19.7, 22.1, 20.3, 17.8, 23.0]

  print *, "=== Daily temperatures ==="
  call describe(temps)
  print *

  ! --- Comparison ---
  print '(A, F7.3)', "Score mean:  ", mean(scores)
  print '(A, F7.3)', "Score median:", median(scores)
  print '(A, F7.3)', "Temp stddev: ", stddev(temps)
end program main
