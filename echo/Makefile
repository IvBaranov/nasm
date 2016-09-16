all:
	nasm -f macho64 echo.asm
	ld -macosx_version_min 10.10 -lSystem -o echo echo.o
clear:
	rm echo echo.o
