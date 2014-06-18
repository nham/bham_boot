all: os-image
	qemu-system-i386 os-image

os-image: kernel boot
	cat boot_sect.bin kernel.bin > os-image

kernel: kernel.c
	gcc -ffreestanding -c kernel.c -o kernel.o
	ld  -o kernel.bin -Ttext 0x1000 kernel.o --oformat binary

boot: boot.asm
	nasm boot.asm -o boot_sect.bin
