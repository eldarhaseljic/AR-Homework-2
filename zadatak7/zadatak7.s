.section .data
tekst: .asciiz "Ovo je neki tekst KOJI SLUzi za prOBU. 1 2 3 itd."
kodovi: .byte 'a', 'O', 'A', '1', 32, 'e', 98
test: .word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0

.section .text
.set noreorder
.globl main
main:
addi $t0 , $0 , 0		#Brojac stavljamo na 0 i spremamo u registar $t0

provjera:		
sltiu $t1 , $t0 , 7		#Provjeravamo da li je vrijednost brojaca manja od 7
beq $t1 , $0 , kraj
nop


la $a0 , tekst			#Ucitavamo adresu niza tekst
la $t1 , kodovi			#Ucitavamo adresu kodova
add $t1 , $t0 , $t1		#Pristupamo trenutnom karakteru
lb $a1 , ($t1)			#Ucitavamo vrijednost karaktera

addi $sp , $sp , -4
sw $ra , ($sp)

jal postoji_znak
nop

lw $ra , ($sp)
addi $sp , $sp , 4

la $t2 , test			#Ucitavamo adresu niza test
sll $t3 , $t0 , 2		#Povecavamo brojac za 4 za pristup trenutnoj adresi u testu
add $t2 , $t3 , $t2		#Pristupamo trenutnoj adresi u nizu
sw $v0 , ($t2)			#Snimamo vrijednost na adresu 
addi $t0 , $t0 , 1		#Povecavamo brojac za 1	
	
j provjera			
nop

kraj:
addi $v0 , $0 , 0
jr $ra
nop

########################


postoji_znak:
addi $t1 , $0 , 0		#Brojac koji se krece kroz niy
addi $t2 , $0 , 00

find:
add $t3 , $t1 , $a0		#Pristupamo adresi trenutnog clana u tekstu
lb $t4 , ($t3)			#Ucitavamo vrijednost clana trenutnog u tekstu

beq $t4 , $t2 , krajniza	#Ako je trenutni clan u nizu \0 tj (00) idi na kraj niza
nop

beq $t4 , $a1 , postoji	   #Ako je trenutni clan jednak trezenom clanu onda on postoji u nizu
nop

addi $t1 , $t1 , 1		#Inkrementiramo brojac za 1
j find
nop

postoji:
addi $v0 , $0 , 1		#Posto clan se nalazi u tekstu vracamo 1
j end
nop

krajniza:
addi $v0 , $0 ,0		#Posto se clan ne nalazi u tekstu vracamo 0

end:
jr $ra 
nop


