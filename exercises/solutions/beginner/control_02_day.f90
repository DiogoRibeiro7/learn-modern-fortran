! Exercise 2 — Day of week with select case

program day_of_week
  implicit none

  integer :: day

  do day = 1, 8
    select case (day)
    case (1)
      print *, day, "Monday"
    case (2)
      print *, day, "Tuesday"
    case (3)
      print *, day, "Wednesday"
    case (4)
      print *, day, "Thursday"
    case (5)
      print *, day, "Friday"
    case (6, 7)
      print *, day, "Weekend"
    case default
      print *, day, "Invalid day"
    end select
  end do
end program day_of_week
