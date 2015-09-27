extern printf
global main

section .data
  a: dq 3
  b: dq 10

fmt: db "%f",10,0   ; format string for printf

section .bss
  c: resq 1

section .text

  main:

  ; resetting all the registers because i'm paranoid
  mov rax, 0
  mov rbx, 0
  mov rcx, 0
  mov rdx, 0

  ; learn about FPU register at : https://en.wikibooks.org/wiki/X86_Assembly/Floating_Point#FPU_Register_Stack
  fld qword [a]           ; loads [a] into st0 register which is on the FPU stack

  fdiv qword [b]          ; divides st0 by [b] and stores result in st0

  fst qword [c]           ; stores the value of st0 into [c]

  ; printing float in 64 bit assembly: http://stackoverflow.com/questions/20594800/printf-float-in-nasm-assembly-64-bit
  sub rsp, 8              ; make 8 bytes of space  in the stack
  movq xmm0, qword [c]    ; moves to xmm0 register which are unique to 64 bit processors
  mov rdi, fmt            ; move the format string defined earlier to the stack
  mov rax, 1              ; move 1 to rax
  call printf
  add rsp, 8


  mov rax, 0
  ret
