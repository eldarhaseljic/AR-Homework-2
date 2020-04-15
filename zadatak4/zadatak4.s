.section .data
brojevi: .word 2, 4, 8, 9, 5, 1, 4, 2, 5, 7, 4, 1, 3, 5, 6
rezultat: .word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0

.section .text
.set noreorder
.globl main
main:

la $t0, brojevi		 	#Ucitavamo adresu od brojevi u $t0
la $t1, rezultat		#Ucitavamo adresu od rezultat u $t1
addi $t2, $0, 0			#Brojac postavljamo na 0 i spremamo i $t2

j uslov
nop

tijelo:
sll $t3, $t2, 2			#Siftamo vrijednost u registru $t2 za 4
add $t4, $t3, $t0		#Pristupamo trenutnoj adresi u nizu brojevi
add $t5, $t3, $t1		#Pristupamo trenutnoj adresu u nizu rezultat 
lw $a0, 0($t4)			#Ucitavamo broj sa adrese

addi $sp , $sp , -20
sw $t0 , 16($sp)
sw $t1 , 12($sp)
sw $t2 , 8($sp)
sw $t5 , 4($sp)
sw $ra , ($sp)

jal f_rezultat
nop

lw $ra , ($sp)
lw $t5 , 4($sp)
lw $t2 , 8($sp)
lw $t1 , 12($sp)
lw $t0 , 16($sp)
addi $sp , $sp , 20

sw $v0, 0($t5)
addi $t2, $t2, 1


uslov:
slti $s0, $t2, 13		#Provjeravamo da li je vrijednost brojaca manja od 13
bne $s0, $0, tijelo		
nop

addi $v0, $0, 0
jr $ra
nop
