# Lessons

Each lesson is a self-contained folder with a `README.md` that explains one topic
through short prose, inline code examples, and links to companion material.

Work through them in order. Lessons 01-05 and 09 are fully expanded.
Lessons 06-08 are outlines that will be expanded in future updates.

## Lesson index

| # | Folder | Topic | Status |
| - | ------ | ----- | ------ |
| 01 | [01-setup](01-setup/) | What is Fortran, setup, first program, `implicit none`, variables | Complete |
| 02 | [02-basics](02-basics/) | Intrinsic types, variables, constants, arithmetic, operators, output | Complete |
| 03 | [03-arrays-procedures](03-arrays-procedures/) | Arrays, loops, conditionals, functions, subroutines, intent | Complete |
| 04 | [04-modules-types](04-modules-types/) | Modules, `use`/`only`, `public`/`private`, derived types, type-bound procedures | Complete |
| 05 | [05-file-io](05-file-io/) | File units, `open`/`close`, reading, writing, `iostat`, formatting | Complete |
| 06 | [06-testing-with-fpm](06-testing-with-fpm/) | Test targets and floating-point checks | Outline |
| 07 | [07-numerical-mini-projects](07-numerical-mini-projects/) | Translating numerical ideas into programs | Outline |
| 08 | [08-c-interop](08-c-interop/) | ISO C binding basics | Outline |
| 09 | [09-legacy-to-modern](09-legacy-to-modern/) | Reading and refactoring old Fortran | Complete |

## How each lesson is structured

A fully expanded lesson includes:

- **Why this lesson matters** — motivation and context
- **Concept sections** — short explanations with inline Fortran code
- **Worked example** — a complete program that ties the concepts together
- **Link to companion example** — a runnable `fpm` project in `examples/`
- **Link to exercises** — practice problems in `exercises/`
- **Key takeaways** — summary of the main points
- **Next step** — link to the following lesson
