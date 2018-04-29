
##############################################################
# Homework #3
# name: Qi Yuan Fang
# sbuid: 111054484
##############################################################
.text

#################################################################
#Fixed Hw 2 functions
#################################################################

##############################
# PART 1 FUNCTIONS
##############################

replace1st:
    #Define your code here
	############################################
	li $t0, 0x00 #lesser bound of ascii arguments
	li $t1, 0x7F #Upper bound of ascii characters
	#Check for invalid characters
	blt $a1, $t0, failedArgsPart1a
	bgt $a1, $t1, failedArgsPart1a
	blt $a2, $t0, failedArgsPart1a
	bgt $a2, $t1, failedArgsPart1a
	#loop to replace first occurence
	# store return address & jump to loop1
	addi $sp, $sp, -4
	sw $ra, 0 ($sp)
	jal loop1
	#load $ra and add to stack
	lw $ra, 0($sp)
	addi $sp, $sp, 4
	############################################
	jr $ra

failedArgsPart1a:
	li $v0, -1
	jr $ra
loop1:
	lbu $t2, 0($a0)
	beq $t2, $a1, replaceLetter
	beqz $t2, nullLetter
	addi $a0, $a0, 1
	j loop1
	jr $ra
replaceLetter:
	sb $a2, 0($a0)
	addi $a0, $a0, 1
	move $v0, $a0
	jr $ra
nullLetter:
	li $v0, 0
	jr $ra

printStringArray:
    #Define your code here
	############################################
	#check for invalid args
	blt $a3, 1, failedArgsPart1b
	blt $a1, 0, failedArgsPart1b
	blt $a2, 0, failedArgsPart1b
	bge $a1, $a3, failedArgsPart1b
	bge $a2, $a3, failedArgsPart1b
	blt $a2, $a1, failedArgsPart1b
	#move to correct startpoint
	addi $sp, $sp -4
	sw $ra, 0($sp)
	jal getToStart1b
	lw $ra, 0($sp)
	addi $sp, $sp, 4
	addi $sp, $sp, -4
	sw $ra, 0($sp)
	#t0 = counter
	li $t0, 0
	jal print1b
	lw $ra, 0($sp)
	addi $sp, $sp, 4
	move $v0, $t0
	############################################
    jr $ra
failedArgsPart1b:
	li $v0, -1
	jr $ra
getToStart1b:
	li $t1, 4
	mul $t2, $a1, $t1
	add $a0, $a0, $t2
	jr $ra
print1b:
	bgt $a1, $a2, jrra
	addi $a1, $a1, 1
	addi $sp, $sp, -4
	sw $ra, 0($sp)
	jal print1bhelper
	addi $t0, $t0, 1
	addi $a0, $a0, 4
	lw $ra, 0 ($sp)
	addi $sp, $sp, 4
	j print1b
print1bhelper:
	addi $sp, $sp, -4
	sw $a0, 0($sp)
	lw $t2, ($a0)
	li $v0, 4
	move $a0, $t2
	syscall
	la $a0, newline2
	syscall
	syscall
	lw $a0, 0($sp)
	addi $sp, $sp, 4
	j jrra

jrra:
	jr $ra
verifyIPv4Checksum:
    #Define your code here
	############################################
	addi $sp, $sp, -8
	sw $s1, 0($sp)
	sw $s2, 4 ($sp)
	#First we will calculate the header length
	#load third byte of $s0
	move $t7 , $a0
	lbu $t0, 3($t7)
	#gets the half words needed to be summed and puts into $t2
	andi $t0, $t0, 0x0F
	li $t1, 2
	mul $t2, $t1, $t0
	#set a counter equal to 0 t3 to count the number of half words added.
	li $t3, 0
	#sum t4
	li $t4, 0
	addi $sp, $sp, -4
	sw $ra, 0($sp)
	#jump to the "start" counter
	jal summation
	lw $ra, 0($sp)
	addi $sp, $sp, 4

	addi $sp, $sp, -4
	sw $ra, 0($sp)
	jal interCheckSum
	lw $ra, 0($sp)
	addi $sp, $sp, 4

	lw $s1,0($sp)
	lw $s2, 4($sp)
	addi $sp, $sp, 8



	############################################
    jr $ra
	############################################Helper methods
summation:
	lhu $t5,0($t7)
	beq $t2, $t3, jumpBack2
	add $t4, $t4, $t5
	addi $t7, $t7, 2
	addi $t3, $t3, 1
	j summation
jumpBack2:
	jr $ra

interCheckSum:
	li $t6, 65536
	bgt $t4, $t6 , carry
	j flipBits

carry:
	andi $s1, $t4, 0xFFFF
	andi $s2, $t4, 0xF0000
	srl $s2, $s2, 16
	add $t4, $s1,$s2
	j flipBits

flipBits:
	xori $t4, $t4, 0xFFFF
	j compare
compare:
	li $t6, 0
	beq $t4, $t6, return0
	move $v0, $t4
	j jumpBack2
return0:
	li $t6, 0
	move $v0, $t6
	j jumpBack2

##############################
# PART 2 FUNCTIONS
##############################

extractData:
    #Define your code here
	############################################
	addi $sp, $sp, -24
	sw $s0, 0($sp)
	sw $s1, 4 ($sp)
	sw $s2, 8($sp)
	sw $s3, 12($sp)
	sw $s4, 16($sp)
	sw $ra, 20($sp)


	move $s0, $a0 #parray add
	move $s1, $a1 #num packet
	move $s2, $a2 #msg add
	li $s3, 0 # m
	li $s4, 0 #counter
	jal loop
	lw $s0, 0($sp)
	lw $s1, 4($sp)
	lw $s2, 8($sp)
	lw $s3, 12($sp)
	lw $s4, 16($sp)
	lw $ra, 20($sp)
	addi $sp, $sp, 24
	jr $ra

loop:
	beq $s3,$s1, done
	#check if valid checksum
	addi $sp, $sp, -20
	sw $s3, 0 ($sp)
	sw $s0, 4 ($sp)
	sw $ra, 8 ($sp)
	sw $s1, 12 ($sp)
	sw $s2, 16 ($sp)
	move $a0, $s0
	jal verifyIPv4Checksum
	lw $s3, 0 ($sp)
	lw $s0, 4 ($sp)
	lw $ra, 8 ($sp)
	lw $s1, 12 ($sp)
	lw $s2, 16 ($sp)
	addi $sp, $sp, 20
	li $t6, 0
	bne $v0, 0, uhoh

	addi $s3, $s3,1
	lhu $t1, 0($s0)
	addi $t1, $t1, -20
	addi $sp, $sp, -8
	sw $s3, 0 ($sp)
	sw $s0, 4 ($sp)
	addi $s0,$s0, 20
	li $t3, 0
	j loop2
loopPart2:
	lw $s3, 0($sp)
	lw $s0, 4 ($sp)
	addi $sp, $sp, 8
	addi $s0,$s0, 60
	j loop
loop2:
	beq $t1, $t3,loopPart2
	addi $t3,$t3,1
	addi $s4, $s4,1
	lbu $t4, 0($s0)
	addi $s0,$s0,1
	sb $t4, ($s2)
	addi $s2, $s2,1
	j loop2


done:
	li $t5, 0
	move $v0, $t5
	move $v1, $s4
	jr $ra
uhoh:
	li $t5, -1
	move $v0, $t5
	move $v1, $s3
	jr $ra

processDatagram:
    #Define your code here
    	beqz $a1, failedprocessDatagram
    	bltz $a1, failedprocessDatagram

    	addi $sp, $sp, -24
    	sw $s0, 0($sp)
    	sw $s1, 4($sp)
    	sw $s2, 8($sp)
    	sw $s3, 12($sp)
    	sw $s4, 16($sp)
    	sw $ra, 20($sp)

	move $s0, $a0 # msg address
	move $s1, $a1 # total number of bytes in msg
	move $s2, $a2 # starting address of array hold addresses of ASCII in mem

	li $s3, 0 # counter (up to s1)
	li $s4, 0 # counter of addresses written to sarray


	sw $s0, ($s2)
	addi $s0, $s0, 1
	addi $s2, $s2, 4
	addi $s3, $s3, 1
	addi $s4, $s4, 1

	#write 0x00 at pos msg[m]
	move $t0, $s0
	add $t0, $t0, $s1
	li $t1, 0x00
	sb $t1, -1($t0)

	jal sarrayLoop

	lw $s0, 0($sp)
	lw $s1, 4($sp)
	lw $s2, 8 ($sp)
	lw $s3, 12($sp)
	lw $s4, 16($sp)
	lw $ra, 20($sp)
	addi $sp, $sp, 24
    	jr $ra
 sarrayLoop:
 	beq $s3, $s1, done2

 	#addi $s3, $s3, 1



 	#addi $s0, $s0, 1
 	la $t3, newline2
 	lbu $t5, 0($t3)
	move $a0, $s0
 	move $a1, $t5
 	li $a2, 0x00

 	addi $sp, $sp, -4
 	sw $ra, 0($sp)
 	jal replace1st
 	lw $ra, 0($sp)
 	addi $sp, $sp , 4
 	beqz $v0, done2
 	sub $t0, $v0, $s0
 	move $s0, $v0
 	sw $s0, 0($s2)
 	addi $s2,$s2, 4
 	add $s3, $s3, $t0
 	lbu $t0,0($s0)
 	beqz $t0, done2
 	addi $s4, $s4, 1

 	j sarrayLoop


 done2:
 	move $v0, $s4
 	jr $ra
 done3:
 	addi $s4, $s4,-1
 	move $v0, $s4
 	jr $ra


 failedprocessDatagram:
 	li $v0, -1
 	jr $ra

##############################
# PART 3 FUNCTIONS
##############################

printDatagram:
    #Define your code here
    ############################################
    #li $v0, -555

    addi $sp, $sp, -28
    sw $ra, 0($sp)
    sw $s0, 4($sp)
    sw $s1, 8($sp)
    sw $s2, 12($sp)
    sw $s3, 16($sp)
    sw $s4, 20($sp)
    sw $s5, 24($sp)

    move $s0, $a0 # parray addr
    move $s1, $a1 # num packets in parray
    move $s2, $a2 #byte []
    move $s3, $a3 #sarray[]

    move $a0, $s0
    move $a1, $s1
    move $a2, $s2
    jal extractData
    bnez $v0, extractFailed
    move $s4, $v1 # total amnt of byte stored in msg
    move $a0, $s2
    move $a1, $s4
    move $a2, $s3
    jal processDatagram
    bltz $v0, processFailed

    move $s5, $v0 # total amount of null terminated strings written to sarr
    addi $t0, $s5, -1
    move $a0, $s3
    li $a1, 0
    move $a2, $t0
    move $a3, $s5

    jal printStringArray

    lw $ra, 0 ($sp)
    lw $ra, 0($sp)
    lw $s0, 4($sp)
    lw $s1, 8($sp)
    lw $s2, 12($sp)
    lw $s3, 16($sp)
    lw $s4, 20($sp)
    lw $s5, 24($sp)
    addi $sp, $sp, 28
    li $v0, 0



    ############################################
    jr $ra


extractFailed:

	lw $ra, 0 ($sp)
    lw $ra, 0($sp)
    lw $s0, 4($sp)
    lw $s1, 8($sp)
    lw $s2, 12($sp)
    lw $s3, 16($sp)
    addi $sp, $sp, 20
	li $v0, -1
	jr $ra

processFailed:
	lw $ra, 0 ($sp)
    lw $ra, 0($sp)
    lw $s0, 4($sp)
    lw $s1, 8($sp)
    lw $s2, 12($sp)
    lw $s3, 16($sp)
    addi $sp, $sp, 20
	li $v0, -1
	jr $ra


#################################################################
#Hw 3 specific functions
#################################################################
extractUnorderedData:
	#store used S registers
	addi $sp, $sp, -28
	sw $ra, 0($sp)
	sw $s0, 4($sp)
	sw $s1, 8($sp)
	sw $s2, 12($sp)
	sw $s3 16($sp)
	sw $s4, 20($sp)
	sw $s5, 24($sp)

	move $s0, $a0 #address parray
	move $s1, $a1 # number of packets in parray
	move $s2, $a2 # starting address of 1D array of bytes for message
	move $s3, $a3 # packetEntrySize
	li $s4, 0 # counter m for number of bytes added to msg[]
	li $s5, 0 # address of highest byte
	# load back stored S registers, deallocated stack space.
	#move $s6, $s2
	jal checkparray
	bnez $v0, doneinvalid
	li $s5, 0
	jal checkValidity
	bnez $v0, doneinvalid
	li $s5, 0
	jal extractToMemory
	sub $v1, $v1, $s2
	lw $ra, 0($sp)
	lw $s0, 4($sp)
	lw $s1, 8($sp)
	lw $s2, 12($sp)
	lw $s3, 16($sp)
	lw $s4, 20($sp)
	lw $s5, 24($sp)
	addi $sp, $sp, 24

	jr $ra

doneinvalid:
	lw $ra, 0($sp)
	lw $s0, 4($sp)
	lw $s1, 8($sp)
	lw $s2, 12($sp)
	lw $s3, 16($sp)
	lw $s4, 20($sp)
	lw $s5, 24($sp)
	addi $sp, $sp, 24
	jr $ra

checkValidity:
	li $t0, 1
	move $t1, $s0
	blt $s1, $t0, neg1neg1
 	beq $s1,$t0, onee
 	li $s6, 0
 	li $t3, 0
 	bgt $s1, $t0, morethanone
	jr $ra
onee:
	beq $s5, $s1, doneee
	lw $t4, 4($t1) # load into t4 flags+ flag offset
	sll $t4, $t4, 16
	srl $t4,$t4, 16
	srl $t5,$t4, 13 # t5 = flags
	sll $t6, $t4, 19
	srl $t6, $t6, 19	#t6 = Fragment offset
	add $t1,$t1,$s3
	addi $s5,$s5,1
	li $t2, 4
	beq $t5, $t2,neg1neg1
	beqz $t5, oneFragOffcheck
	j onee
oneFragOffcheck:
	bnez $t6,neg1neg1
	j onee
	
morethanone:
	beq $s5, $s1, doneeee
	lw $t4, 4($t1) # load into t4 flags+ flag offset
	sll $t4, $t4, 16
	srl $t4,$t4, 16
	srl $t5,$t4, 13 # t5 = flags
	sll $t6, $t4, 19
	srl $t6, $t6, 19	#t6 = Fragment offset
	add $t1,$t1,$s3
	addi $s5,$s5, 1
	li $t2, 2 # 010
	#li $t3, 4
	beq $t5, $t2, neg1neg1
	addi $t2,$t2,2
	beq $t5, $t2, fragequalzerocheck
	beqz $t5, fragnotequalzerocheck
	
	j morethanone
fragequalzerocheck:
	beqz $t6, addii
	j morethanone

fragnotequalzerocheck:
	bnez $t6, addiii
	j morethanone
addii:
	addi $s6,$s6,1
	j morethanone
addiii:
	addi $t3,$t3,1
	j morethanone

	
doneee:
	
	jr $ra
doneeee:
	li $t0, 1
	bne $s6, $t0, neg1neg1
	bne $t3, $t0, neg1neg1
	jr $ra

checkparray:
	addi $sp, $sp -16
	sw $s0, 0($sp)
	sw $s1, 4($sp)
	sw $s3, 8($sp)
	sw $s5, 12($sp)
	j loopcheckparray
loopcheckparray:
	beq $s5, $s1, jrra9
	move $a0, $s0
	addi $sp, $sp, -4
	sw $ra, 0($sp)
	jal verifyIPv4Checksum
	lw $ra, 0($sp)
	addi $sp, $sp, 4
	bnez $v0, failedCheckparray
	addi $s5, $s5, 1
	add $s0, $s0, $s3
	j loopcheckparray

failedCheckparray:
	move $v1, $s5
	lw $s0, 0($sp)
	lw $s1, 4($sp)
	lw $s3, 8($sp)
	lw $s5, 12($sp)
	addi $sp, $sp, 16
	li $v0, -1

	jr $ra

neg1neg1:
	li $v0, -1
	li $v1, -1
	jr $ra
jrra9:
	lw $s0, 0($sp)
	lw $s1, 4($sp)
	lw $s3, 8($sp)
	lw $s5, 12($sp)
	addi $sp, $sp, 16
	li $v0, 0
	li $v1, 0
	jr $ra
extractToMemory:
	lhu $t0, 0($s0) # t0 = total length
	bgt $t0, $s3, totalLengthGreaterThanPacketSize
	beq $s1, $s5, done5
	lbu $t1, 3($s0)
	andi $t1, $t1, 0x0F # $t1 = header length
	li $t2, 4
	mul $t1, $t1, $t2 #t1 = size of header
	sub $t3, $t0, $t1 # $t3 = max length of payload size of a packet
	lw $t4, 4($s0) # load into t4 flags+ flag offset
	sll $t4, $t4, 16
	srl $t4,$t4, 16
	srl $t5,$t4, 13 # t5 = flags
	sll $t6, $t4, 19
	srl $t6, $t6, 19	#t6 = Fragment offset
	addi $sp, $sp, -12
	sw $ra, 0($sp)
	#sw $s0, 4($sp)
	sw $s7, 8($sp)
	li $s7, 0 #s7 = current bytes added of packet
	jal addToHandler
	addi $s5, $s5, 1
	lw $ra, 0($sp)
	add $s0,$s0, $s3
	#lw $s0, 4($sp)
	lw $s7, 8($sp)
	addi $sp, $sp, 12

	j extractToMemory
totalLengthGreaterThanPacketSize:
	li $v0, -1
	move $v1, $s5
	jr $ra
addToHandler:
	addi $sp, $sp, -8
	sw $s2, 0($sp)
	sw $s7, 4($sp)
	move $t2, $s0
	beq $t5, 0x0F0, msg0
	bnez $t6, msgoffset
	j msg0
msg0:
	add $t2, $t2, $t1
	j addLoop
msgoffset:
	add $t2, $t2, $t1
	add $s2, $s2, $t6
	j addLoop
addLoop:
	beq $s7, $t3, done4
	addi $s7, $s7,1
	lbu $t6, 0($t2)
	sb $t6, 0($s2)
	addi $t2,$t2,1
	addi $s2, $s2, 1
	bgt $s2, $s4, newHighest
	j addLoop

newHighest:
	move $s4, $s2
	j addLoop
done4:
	lw $s2, 0($sp)
	lw $s7, 4($sp)
	addi $sp, $sp, 8
	jr $ra
done5:
	li $v0, 0
	move $v1, $s4
	jr $ra
#####################################
printUnorderedDatagram:

	lw $t0, 0($sp) #packageentrysize
	addi $sp,$sp, 4

	addi $sp, $sp, -28
	sw $s0, 0($sp)
	sw $s1, 4($sp)
	sw $s2, 8($sp)
	sw $s3 12($sp)
	sw $s4, 16($sp)
	sw $s5, 20($sp)
	sw $ra, 24($sp)


	move $s0, $a0 #packet array address
	move $s1, $a1 # int n (num packets in arr)
	move $s2, $a2 # byte []
	move $s3, $a3 #sarray[]
	move $s7, $ra


	move $a0, $s0
	move $a1, $s1
	move $a2, $s2
	move $a3, $t0
	jal extractUnorderedData
	bnez $v0, failedExtractionHw3
	move $s4, $v1 # total amnt bytes stored in msg
	move $a0,$s2
	move $a1, $s4
	move $a2, $s3
	jal processDatagram
	bltz $v0, processFailed3

	move $s5, $v0
	addi $t0, $s5, -1
	move $a0, $s3
	li $a1, 0
	move $a2, $t0
	move $a3, $s5
	jal printStringArray
	lw $s0, 0($sp)
	lw $s1, 4($sp)
	lw $s2, 8($sp)
	lw $s3 12($sp)
	lw $s4, 16($sp)
	lw $s5, 20($sp)
	lw $ra, 24($sp)
	addi $sp, $sp, 28
	li $v0, 0
	move $ra, $s7
	jr $ra
failedExtractionHw3:
	lw $s0, 0($sp)
	lw $s1, 4($sp)
	lw $s2, 8($sp)
	lw $s3 12($sp)
	lw $s4, 16($sp)
	lw $s5, 20($sp)
	lw $ra, 24($sp)
	addi $sp, $sp, 28
	li $v0, -1
	move $ra, $s7
	jr $ra
processFailed3:
 	lw $s0, 0($sp)
	lw $s1, 4($sp)
	lw $s2, 8($sp)
	lw $s3 12($sp)
	lw $s4, 16($sp)
	lw $s4, 20($sp)
	addi $sp, $sp, 24
	li $v0, -1
	jr $ra

editDistance:
	#register conventions
  	addi $sp, $sp, -20
	sw $ra, 0($sp)
	sw $a0, 4($sp)
	sw $a1, 8($sp)
	sw $a2, 12($sp)
	sw $a3, 16($sp)
	bltz $a2, editDistanceFail
	bltz $a3, editDistanceFail

	#print sequence
	la $a0, mString
	li $v0, 4
	syscall
	move $a0, $a2
	li $v0, 1
	syscall
	la $a0, nString
	li $v0, 4
	syscall
	move $a0, $a3
	li $v0, 1
	syscall
	la $a0, newline2
	li $v0, 4
	syscall
	# if equal to zero return
	beqz $a2, returnn
	beqz $a3, returnm

	#check if char equal
	addi $a2, $a2, -1 
	addi $a3, $a3, -1 
	lw $a0, 4($sp)
	add $t0, $a0, $a2 
	add $t1, $a1, $a3 
	lbu $t2, ($t0) 
	lbu $t3, ($t1) 

	beq $t2, $t3, lastCharacterSame
	#insert
	lw $a0, 4($sp)
	lw $a1, 8($sp)
	lw $a2, 12($sp)
	lw $a3, 16($sp)
	addi $a3, $a3, -1
	jal editDistance
	move $t4, $v0 
	#replace
	lw $a0, 4($sp)
	lw $a1, 8($sp)
	lw $a2, 12($sp)
	lw $a3, 16($sp)
	addi $a2, $a2, -1 
	jal editDistance
	move $t5, $v0 
	#remove
	lw $a0, 4($sp)
	lw $a1, 8($sp)
	lw $a2, 12($sp)
	lw $a3, 16($sp)
	addi $a2, $a2, -1
	addi $a3, $a3, -1 
	jal editDistance
	move $t6, $v0
	#compare
	blt $t6, $t5, min
	blt $t5, $t4, min3 

continue:
	addi $v0, $t7, 1
	j editDistanceDone

lastCharacterSame:
	jal editDistance

min:
	blt $t6, $t4, min2
	move $t7, $t4
	j continue

min2:
	move $t7, $t6
	j continue

min3:
	blt $t5, $t6, min4
	move $t7, $t6
	j continue

min4:
	move $t7, $t5
	j continue

editDistanceFail:
	li $v0, -1
	j editDistanceDone

editDistanceDone:
	lw $ra, 0($sp)
	addi $sp, $sp, 20
	jr $ra

returnm:
	move $v0, $a2
	lw $ra, 0($sp)
	addi $sp, $sp, 20
	jr $ra

returnn:
	move $v0, $a3
	lw $ra, 0($sp)
	addi $sp, $sp, 20
	jr $ra





#################################################################
# Student defined data section
#################################################################
.data
.align 2  # Align next items to word boundary

#place all data declarations here
newline2:  .asciiz "\n"
other: .asciiz "\0"
mString: .asciiz "m:"
nString: .asciiz ",n:"
