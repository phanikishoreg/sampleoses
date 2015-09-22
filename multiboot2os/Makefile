#LDFLAGS=-nostdlib -nostartfiles -nostdinc -nodefaultlibs
#CFLAGS=-g3 -Werror -ffreestanding -Wno-unused-function -Wno-unused-variable -Wno-unused-but-set-variable -nostdlib -mno-red-zone -I.

kernel.o: kernel.c multiboot2.h
	gcc -I. -c kernel.c -o kernel.o -std=gnu99 -ffreestanding -O2 -Wall -Wextra

boot.o: boot.s
	as boot.s -o boot.o

all: boot.o kernel.o linker.ld
	ld -m elf_i386 -T linker.ld -O2 -nostdlib -nostdinc -o multiboot2os.bin boot.o kernel.o

clean: 
	rm -f *.o multiboot2os.bin
