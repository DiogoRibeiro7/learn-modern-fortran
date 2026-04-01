# Intermediate exercises — Pointers and dynamic memory

**Companion lesson:** [Lesson 05 — File I/O](../../lessons/05-file-io/README.md) (pointer use is cross-cutting in Fortran)

**What you will practice:**

- Declaring pointers with `pointer` attribute
- Using `target` attribute for pointer targets
- Allocating/deallocating pointer arrays
- Pointer association status and `null()` testing
- Pointer-based linked data structures

Exercises are ordered by difficulty. Complete them before reading solutions.

---

## Exercise 1 — Scalar pointer alias ★

**Learning goal:** Understand pointer association and value updates.

1. Declare a real variable `x` and set `x = 3.14`.
2. Declare a real pointer `p` and associate it with `x`.
3. Use `p` to set `x = 2.718`.
4. Print `x` and `p` (they should both show `2.718`).

---

## Exercise 2 — Pointer to allocatable vector ★★

**Learning goal:** Create and resize dynamic arrays through pointers.

1. Declare `real, pointer :: arr(:)` and `integer :: n`.
2. Read `n` from the user (e.g., 5).
3. Allocate `arr(n)` and fill with `arr(i) = i**2`.
4. Print the array contents.
5. Deallocate `arr` and confirm `associated(arr)` is `.false.`.

---

## Exercise 3 — Pointer alias for array slice ★★

**Learning goal:** Use a pointer to refer to a subset of an array.

1. Create `real, target :: data(10)` with values 1..10.
2. Declare `real, pointer :: sub(:)` and associate with `data(4:7)`.
3. Multiply `sub` elements by 10.
4. Print `data` to show indices 4..7 were updated.

---

## Exercise 4 — Simple linked list nodes ★★★

**Learning goal:** Practice derived type with recursive pointer component.

1. Define:

```fortran
   type :: node_t
     integer :: value
     type(node_t), pointer :: next => null()
   end type node_t
```

2. Create three linked nodes with values 10, 20, 30.
3. Traverse the list from head and print each value.
4. Deallocate nodes by setting `head => null()` and `nullify` on pointers.
