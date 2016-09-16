; Hello world in NASM assembly for Mac OS X x64

section .data
	msg:	db	"hello", 0xA	; text to print ("hello\n")
	.len:	equ	$ - msg		; text length

section .text
	global _main
_main:
	mov	rax, 0x2000004		; put the write-system-call-code into register rax
	mov	rdi, 1			; tell kernel to use stdout
	mov	rsi, msg		; put address of the text into register rsi
	mov	rdx, msg.len		; put the length of the text into register rdx
	syscall
	mov	rax, 0x2000001		; exit system call
	mov	rdi, 0			; out error code 0 to exit successfully
	syscall
