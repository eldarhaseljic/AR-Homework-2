.section .data
.globl brojevi
brojevi: .word 1 , 2 , 3 , 10 , 20  , 5  , 4 , 11 , 9 , 54
.globl rezultat
rez: .word 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0

.section .text
.set noreorder
.globl main
main:

addi $t0 , $0 , 0		#Brojac elemenata postavljamo na 0

provjera:
sltiu $t1 , $t0 , 40		#Provjeravamo da li je brojac manji od broja elemenata
beq $t1 , $0 , kraj 
nop

la $t1 , brojevi		#U $t1 ucitavamo adresu od brojevi
add $t1 , $t0 , $t1		#Postavljamo se na trenutnu adresu u nizu
lw $a0 , ($t1)			#Ucitavamo element  sa adrese

addi $sp , $sp , -4		
sw $ra , ($sp)

jal funkcija
nop

lw $ra , ($sp)
addi $sp , $sp , 4

la $t1 , rez			#U $t1 ucitavamo adresu od rezultal
add $t1 , $t0 , $t1		#Postavljamo se na trenutnu adersu u nizu
sw $v0 , ($t1)			#Snimamo vrijednost $v0 na adresu
addi $t0 , $t0 , 4		#Inkrementiramo brojac za 4
j provjera
nop

kraj:
addi $v0 , $0 , 0
jr $ra
nop

####################################################################

funkcija:
andi $t2 , $a0 , 1		#Provjeravamo da li je broj neparan/paran
bne $t2 , $0 , neparan		
nop
	
addi $t3 , $0 , 3		#Dodajemo vrijednost 3 u reg $t3
mult $t3 , $a0			#Mnozimo 3*x
mflo $t3			#Rezultat mnozenja spremimo u $t3

sll $a1 , $a0 , 1		#Siftujemo x za 2 u lijevo
addi $a1 , $a1 , -3		#y=2*x-3

addi $sp , $sp , -4		
sw $ra , ($sp)

jal funkcija2
nop

lw $ra , ($sp)
addi $sp , $sp , 4

add $v0 , $t3 , $v0		#3x + f2(x,2x-3)
jr $ra
nop

###################################

neparan:
sll $a0 , $a0 , 1		#Siftamo broj za 2 u lijevo 

addi $sp , $sp , -4		
sw $ra , ($sp)

jal funkcija1			
nop

lw $ra , ($sp)
addi $sp , $sp , 4

add $v0 , $a0 , $v0 		#2x+f1(2x)
j $ra
nop

#####################################

funkcija2:
addi $t4 , $0 , 5
bne $a0 , $t4 , razlicito
nop 

sll $t4 , $a0 , 2		#Siftamo broj za 2
add $v0 , $a1 , $t4		#y+4x
jr $ra
nop

###################################

funkcija1:
slti $t2 , $a0 , 10		#Provjeravamo da li je broj manji od 10
beq $t2 , $0 , vece10		
nop

add $t3 , $0 , 5		#Dodajemo broj 5 u registar $t3
add $t4 , $a0 , $0		#Dodajemo vrijednost a0 u registar
mult $t3 , $t4			#Mnozimo 5*x
mflo $t4
addi $v0 , $t4 , 7		#5X+7
jr $ra				
nop

##################################

razlicito:

addi $t4 , $0 , 5
mult $t4 , $a0
mflo $t4
sll $a1 , $a1 , 1		
add $v0 , $a1 , $t4		#5x+2y
jr $ra
nop

vece10:
addi $v0 , $a0 , -17	 	#x-17
j $ra
nop


