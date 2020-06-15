	.data
	.asciiz "Suma de 2 y 2 = %d\n"
	.byte 10
	.byte 11
	.byte 12
	.byte 13
	.byte 14
	.byte 15
	.byte 16
	.byte 17
	.byte 18
	.byte 19
	.byte 0
	.word 0xCAFECAFE
	
str:	.asciiz "Hola Mundo en MIPS32\n"

	.text
main:	
	la $a0, str
	li $v0, 4
	syscall
	li $v0, 10
	syscall
	
