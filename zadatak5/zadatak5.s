.section .text
.set noreorder
.globl test
test:
addi $sp , $sp , -8
sw $s3 , 4($sp)
sw $s6 , ($sp)

slti $s3, $a0, 4
beq $s3, $0, else
nop

addi $v0, $0, 0
j kraj
nop

else:
sll $s6, $a0, 1
addi $v0, $s6, 6

kraj:

lw $s6 , ($sp)
lw $s3 , 4($sp)
addi $sp , $sp , 8

jr $ra
nop
