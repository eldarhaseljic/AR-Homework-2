.section .data
n: .word 10
niz1: .byte 3, 4, -44, 34, -34, 0, -43, -3, 34, 55, 34, 34, 33, 4, 54, 4, 5, 0, 0, 34
niz2: .word 34, 4, 3, 4, 4, 43, 2, 23, 4, 4, 4, 4, -43, 0, 0, 0, 0, 3243, 33, 12
niz3: .word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0


.section .text
.set noreorder
.globl main

main:
la $t0 , n		#Ucitavamo adresu od n u $t0	
lw $t0 , ($t0)		#Ucitavamo vrijednost n u $t0
addi $t1 , $0 , 0	#Postavljamo brojac na nulu $t1 za niz 1
addi $t2 , $0 , 0	#Postavljamo brojac na nulu $t2 za niz 2

provjera:
slt $t3 , $t1 , $t0	#Provjeravamo da li je vrijednost brojaca $t1 manja od $t0
beq $t3 , $0 , kraj	
nop

la $t3 , niz1		#Ucitavamo adresu niza1 u $t3
la $t4 , niz2		#Ucitavamo adresu niza2 u $t4
add $t3 , $t3 , $t1	#Postavljamo se na zeljeni element u nizu1
add $t4 , $t4 , $t2	#Postavljamo se na zeljeni element u nizu2
lb $t3 , ($t3)		#Ucitavamo element niza1 
lw $t4 , ($t4)		#Ucitavamo element niza2
add $t4 , $t3 , $t4	#Sabiramo elemente
la $t3 , niz3		#Adresa od niza3
add $t3 , $t3 , $t2	#Trenutna adresa od niza3
sw $t4 , ($t3)		#Snimamo vrijednost
addi $t1 , $t1 , 1	#Inkrementiramo brojace
addi $t2 , $t2 , 4	
j provjera
nop

kraj:
addi $v0 , $0 , 0
jr $ra 
nop

