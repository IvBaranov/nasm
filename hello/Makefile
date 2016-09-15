all:
	nasm -f macho64 hello.asm
	ld -macosx_version_min 10.10 -lSystem -o hello hello.o
clear:
	rm hello hello.o
