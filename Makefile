all:
	nasm boot.asm
	qemu-system-i386 boot
