.section .text
.set noreorder
.globl test
test:

#$a0 => a
#$a1 => b
addi $sp , $sp , -12
sw $ra , 8($sp)
sh $a0 , 4($sp)
sh $a1 , ($sp)

#################################

if1:
sltiu $t0 , $a0 , 2
beq $t0 , $0 , else1
nop

lh $a1 , ($sp)
lh $a0 , 4($sp)
lw $ra , 8($sp)
addi $sp , $sp , 12

addi $v0 , $0 , 1
jr $ra
nop

else1:
sltiu $t0 , $a1 , 3
beq $t0 , $0 , if2
nop

lh $a1 , ($sp)
lh $a0 , 4($sp)
lw $ra , 8($sp)
addi $sp , $sp , 12

addi $v0 , $0 , 1
jr $ra 
nop

###################################

if2:
slt $t0 , $a0 , $a1
beq $t0 , $0 , else2
nop

addi $a0 , $a0 , -1
addi $a1 , $a1 , -3

jal test
nop

lh $a1 , ($sp)
lh $a0 , 4($sp)
lw $ra , 8($sp)
addi $sp , $sp , 12
add $v0 , $v0 , $a0
jr $ra 
nop

else2:

addi $a0 , $a0 , -2
addi $a1 , $a1 , -1

jal test
nop

lh $a1 , ($sp)
lh $a0 , 4($sp)
lw $ra , 8($sp)
addi $sp , $sp , 12

sub $a1 , $0 , $a1
add $t1 , $a1 , $a0
add $v0 , $v0 , $t1
jr $ra 
nop
