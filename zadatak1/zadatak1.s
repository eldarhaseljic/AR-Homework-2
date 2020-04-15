.section .data
.globl niz
niz: .word -1 , 2 , 3 , -4 , 15 , -6 , 7 , -8 , 0 , -10
.globl rez
rez: .word 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0

.section .text
.set noreorder
.globl main
main:
addi $t0 , $0 , 0		#Postavljamo vrijednost brojaca $t0 na 0

petlja:
la $t1 , niz			#U $t1 ucitavamo adresu od niz
sltiu $t3 , $t0 , 40		#Brojac ide kroz cijeli niz
beq $t3 , $0 , kraj	
nop	

add $t1 , $t0 , $t1		#Pristupamo adresi od clana
lw $t4 , ($t1)			#Ucitavamo vrijednost clana sa adrese u $t4
andi $t5 , $t4 , 1 		#x%2
bne $t5 , $0 , neparan		#Provjeravamo da li je broj neparan/neparan
nop
sra $t4 , $t4 , 1		#Broj u $t4 je paran, dijelomo ga sa 2

abs:
slti $t5 , $t4 , 0		#Provjeravamo dali je broj pozitivan/negativan 
bne $t5 , $0 , negativan	
nop

save:
la $t2 , rez 			#U $t2 ucitavamo adresu od rez
add $t2 , $t0 , $t2		#Prustupamo trenutnoj adresi u nizu rez
sw $t4 , ($t2)			#Snimamo vrijednost
addi $t0 , $t0 , 4		#Inkrementiramo brojac za 4
j petlja
nop

neparan:			
sll $t4 , $t4 , 1		#Broj u $t4 je neparan mnozimo ga sa 2
j abs
nop

negativan:
addi $t4 , $t4 , -1		
nor $t4 , $t4 , $0		
j save
nop

kraj:
addi $v0 , $0 , 0
jr $ra
nop
