/* boot.S - bootstrap the kernel */
/* Copyright (C) 1999, 2001, 2010  Free Software Foundation, Inc.
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

#define ASM_FILE	1

.set STACKSIZE, 0x4000
	.text

	.globl	start, _start
start:
_start:
	jmp	multiboot_entry

	/* Align 64 bits boundary.  */
	.align	8
	
	/* Multiboot header.  */
multiboot_header:
	/* magic */
	.long 0xe85250d6
	/* ISA: i386 */
	.long 0
	/* Header length.  */
	.long	multiboot_header_end - multiboot_header
	/* checksum */
	.long	-(0xe85250d6 + (multiboot_header_end - multiboot_header))
	.short 0
	.short 0
	.long 8
multiboot_header_end:
multiboot_entry:
	/* Initialize the stack pointer.  */
	movl	$(stack + STACKSIZE), %esp

	/* Reset EFLAGS.  */
	pushl	$0
	popf

	/* Push the pointer to the Multiboot information structure.  */
	pushl	%ebx
	/* Push the magic value.  */
	pushl	%eax

	/* Now enter the C main function...  */
	call	cmain

	/* Halt.  */
	pushl	$halt_message
	call	printf
	
loop:	hlt
	jmp	loop

halt_message:
	.asciz	"Halted."

	/* Our stack area.  */
	.comm	stack, STACKSIZE

