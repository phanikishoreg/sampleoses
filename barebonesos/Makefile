
kernel.o: kernel.c
	gcc -c kernel.c -o kernel.o -std=gnu99 -ffreestanding -O2 -Wall -Wextra

boot.o: boot.s
	as boot.s -o boot.o

all: boot.o kernel.o linker.ld
	ld -m elf_i386 -T linker.ld -o barebonesos.bin -O2 -nostdlib boot.o kernel.o

clean: 
	rm -f *.o barebonesos.bin
