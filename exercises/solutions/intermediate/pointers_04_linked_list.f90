program pointers_04_linked_list
  implicit none

  type :: node_t
    integer :: value
    type(node_t), pointer :: next => null()
  end type node_t

  type(node_t), pointer :: head, n1, n2, n3, walker

  ! Create nodes
  allocate(n1); n1%value = 10
  allocate(n2); n2%value = 20
  allocate(n3); n3%value = 30

  n1%next => n2
  n2%next => n3
  n3%next => null()

  head => n1

  ! Traverse and print
  walker => head
  print *, 'Linked list values:'
  do while (associated(walker))
    print '(I0)', walker%value
    walker => walker%next
  end do

  ! Release nodes
  nullify(n1, n2, n3, head, walker)

end program pointers_04_linked_list
