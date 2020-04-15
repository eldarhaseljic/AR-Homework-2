.section .data
.globl brojevi
brojevi: .word 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21 
.globl	rezultat
rezultat: .word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0

.section .text
.set noreorder
.globl main
main:

addi $t0 , $0 , 0		#Brojac stavljamo na 0 i spremamo u $t0

provjera:
sltiu $t1 , $t0 , 20		#Provjeravamo da li je vrijednost brojaca manja od 20
beq $t1 , $0 , kraj
nop

la $t1 , brojevi		#Ucitavamo adresu niza brojevi
sll $t2 , $t0 , 2		#Mnozimo brojac sa 4 i spreamo u $t2
add $t2 , $t1 , $t2		#Pristupamo adresi trenutnog elementa
lw $a0, ($t2)			#Ucitavamo trenutni element
 
addi $sp , $sp , -4
sw $ra , ($sp)

jal fr
nop

lw $ra , ($sp)
addi $sp , $sp , 4

la $t1 , rezultat		#Ucitavamo adresu niza rezultat
sll $t2 , $t0 , 2		#Mnozimo brojac sa 4 i spremamo u $t2
add $t2 , $t1 , $t2 		#Pristupamo adresi trenutnog clana
sw $v0 , ($t2)			#Spremamo rezultat u niz

addi $t0 , $t0 , 1		#Inkrementiramo brojac za 1

j provjera			#Vracamo se na provjeru 
nop

kraj:
addi $v0 , $0 ,0
jr $ra
nop

#################################################

fr:
addi $t1 , $0 , 1

beq $a0 , $t1 , fr_1		#Ako je vrijednost n = 1 
nop

beq $a0 , $0 , fr_0		#Ako je vrijednost n = 0
nop

addi $sp , $sp , -12
sw $ra , 8($sp)
sw $a0 , 4($sp)

jal suma_n			#Poziv funkcije suma
nop

lw $a0 , 4($sp)
sw $v0 , ($sp)
addi $a0 , $a0 , -2

jal fr				#Rekurzivno pozivamo fr
nop

lw $t3 , ($sp)
lw $ra , 8($sp)
addi $sp , $sp , 12

add $v0 , $t3 , $v0		#suma_n+fr(n-2)
jr $ra 
nop

##########################

suma_n:
beq $a0 , $0 , end
nop

addi $sp , $sp , -8
sw $ra , 4($sp)
sw $a0 , ($sp)

addi $a0 , $a0 , -1

jal suma_n
nop

lw $a0 , ($sp)
lw $ra , 4($sp)
addi $sp , $sp , 8
add $v0 , $v0 , $a0

jr $ra
nop

end:
add $v0 , $0 , $0
jr $ra
nop

##########################

fr_1:
addi $v0 , $0 , 1
jr $ra
nop

fr_0:
addi $v0 , $0 , 0
jr $ra
nop
