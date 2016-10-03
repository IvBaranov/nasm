; Echo program that waits for user to enter a character and than echoing it.
; NASM assembly for Mac OS X x64.
; Differes from 'echo-procedural' program by passing parameters to procedures
; using registers.

section .data
	msg_enter:	db	"Please, enter a char: "
	.len:		equ	$ - msg_enter
	msg_entered:	db	"You have entered: "
	.len:		equ	$ - msg_entered

section .bss
	char:		resb	1	; reserve one byte for one char

section .text
	global		_main
_main:
	mov	rbx, msg_enter
	mov	rcx, msg_enter.len
	call	show_string
	call	read_char
	mov	rbx, msg_entered
	mov	rcx, msg_entered.len
	call	show_string
	mov	rbx, char
	mov	rcx, 2
	call	show_string
	call	exit

show_string:
	mov	rax, 0x2000004		; put the write-system-call-code into register rax
	mov	rdi, 1			; tell kernel to use stdout
	mov	rsi, rbx		; rsi is where the kernel expects to find the address of the message
	mov	rdx, rcx		; and rdx is where the kernel expects to find the length of the message
	syscall
	ret

read_char:
	mov	rax, 0x2000003		; put the read-system-call-code into register rax
	mov	rdi, 0			; tell kernel to use stdin
	mov	rsi, char		; address of storage, declared in section .bss
	mov	rdx, 2			; get 2 bytes from the kernel's buffer (one for the carriage return)
	syscall
	ret

exit:
	mov	rax, 0x2000001		; exit system call
	xor	rdi, rdi		; equivalent to "mov rdi, 0", however xor is preferred pattern on modern
					; CPUs
	syscall
