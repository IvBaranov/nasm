; Echo program that waits for user to enter a character and than echoing it.
; NASM assembly for Mac OS X x64.
; Differes from 'echo' program by using procedures.

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
	call	show_msg_enter
	call	read_char
	call	show_msg_entered
	call	show_char
	call	exit

show_msg_enter:
	mov	rax, 0x2000004		; put the write-system-call-code into register rax
	mov	rdi, 1			; tell kernel to use stdout
	mov	rsi, msg_enter		; rsi is where the kernel expects to find the address of the message
	mov	rdx, msg_enter.len	; and rdx is where the kernel expects to find the length of the message
	syscall
	ret

read_char:
	mov	rax, 0x2000003		; put the read-system-call-code into register rax
	mov	rdi, 0			; tell kernel to use stdin
	mov	rsi, char		; address of storage, declared in section .bss
	mov	rdx, 2			; get 2 bytes from the kernel's buffer (one for the carriage return)
	syscall
	ret

show_msg_entered:
	mov	rax, 0x2000004		; put the write-system-call-code into register rax
	mov	rdi, 1			; tell kernel to use stdout
	mov	rsi, msg_entered	; rsi is where the kernel expects to find the address of the message
	mov	rdx, msg_entered.len	; and rdx is where the kernel expects to find the length of the message
	syscall
	ret

show_char:
	mov	rax, 0x2000004		; put the write-system-call-code into register rax
	mov	rdi, 1			; tell kernel to use stdout
	mov	rsi, char		; address of storage of char
	mov	rdx, 2			; the second byte is to apply the carriage return expected in the string
	syscall
	ret

exit:
	mov	rax, 0x2000001		; exit system call
	xor	rdi, rdi		; equivalent to "mov rdi, 0", however xor is preferred pattern on modern
					; CPUs
	syscall
