all:
	nasm -f macho64 echo-parameters-via-registers.asm
	ld -macosx_version_min 10.10 -lSystem -o echo-parameters-via-registers echo-parameters-via-registers.o
clear:
	rm echo-parameters-via-registers echo-parameters-via-registers.o
