.section .data
.globl brojevi
brojevi: .word 1 , 3 , 4 , 66 , 8 , 19 , 2 , 18 , 100 , 45 , 24 , 15
.globl rezultat
rezultat: .word 0 , 0 , 0 

.section .text
.set noreorder
.globl main
main:

addi $t0 , $0 , 0		#Postavljamo brojac na 0 u registur $t0

uslov:
sltiu $t1 , $t0 , 3
beq $t1 , $0 , kraj
nop

la $t1 , brojevi		#Ucitavamo adresu od brojevi u $t1
sll $t2 , $t0 , 4		#Siftamo brojac za 16 u lijevo i spremamo u $t2
add $t1 , $t2 , $t1		#Pristupamo trenutnoj adresi 
		
	#Ucitavamo vrijednosti elemenata niza  brojevi u $a0, $a1, $a2, $a3 sa razmakom od 4

lw $a0 , ($t1)			
lw $a1 , 4($t1)	
lw $a2 , 8($t1)
lw $a3 , 12($t1)

addi $sp , $sp , -4
sw $ra , ($sp)

jal funkcija
nop

lw $ra , ($sp)
addi $sp , $sp , 4

la $t1 , rezultat		#Ucitavamo adresu od rezultat
sll $t2 , $t0 , 2		#Siftamo brojac za 4 i spremamo u registar $t2
add $t1 , $t2 , $t1		#Pristupamo trenutnoj poziciji
sw $v0 , ($t1)			#Snimamo vrijednost $v0 na trenutnu adresu

addi $t0 , $t0 , 1		#Inkrementiramo brojac
j uslov
nop

kraj:		
addi $v0 , $0 ,0
jr $ra
nop

#####################################

funkcija:

add $t1 , $a0 , $a1		#a+b
add $t2 , $a2 , $a3		#c+d
sub $t1 , $t1 , $t2		#(a+b)-(c+d)
addi $v0 , $t1 , -6		#(a+b)-(c+d)-6

jr $ra
nop
