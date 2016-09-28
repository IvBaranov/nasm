all:
	nasm -f macho64 echo-procedural.asm
	ld -macosx_version_min 10.10 -lSystem -o echo-procedural echo-procedural.o
clear:
	rm echo-procedural echo-procedural.o
