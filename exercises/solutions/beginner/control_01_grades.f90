! Exercise 1 — Grade classifier

program grades
  implicit none

  call classify(95)
  call classify(85)
  call classify(73)
  call classify(62)
  call classify(41)

contains

  subroutine classify(score)
    integer, intent(in) :: score
    character(len=1) :: grade

    if (score >= 90) then
      grade = "A"
    else if (score >= 80) then
      grade = "B"
    else if (score >= 70) then
      grade = "C"
    else if (score >= 60) then
      grade = "D"
    else
      grade = "F"
    end if

    print *, "Score:", score, " Grade:", grade
  end subroutine classify

end program grades
