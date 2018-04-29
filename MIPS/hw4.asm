
##############################################################
# Homework #4
# name: Qi Yuan Fang
# sbuid: 111054484
##############################################################
.text

##############################
# PART 1 FUNCTIONS
##############################

clear_board:
    #Define your code here
	############################################
	move $t0, $a0 # $t0 = starting address of 2D array holding state of game
	move $t1, $a1 #t1 = num row in board
	move $t2, $a2 #t2 = num col in board 
	
	li $t3, 2
	#branch if either row or col less than 2
	blt $t1, $t3, fail1_1
	blt $t2, $t3, fail1_1
	
	li $t4, 0 # t4 = row counter (i)
	li $t9, -1 #t9 = -1
	j rowloop1_1
	############################################
	jr $ra
rowloop1_1:
	li $t5, 0 # t5 is our column counter (j)
	j col_loop
col_loop:
	mul $t6, $t4, $t2 # multiply i with num of col
	add $t6, $t6, $t5 # add column counter
	#sll $t6, $t6, 1
	mul $t6,$t6,$t3
	add $t6,$t6,$t0
	sh $t9, 0($t6)
	addi $t5,$t5,1
	blt $t5,$t2, col_loop
	j col_loopdone
col_loopdone:
	addi $t4,$t4, 1
	blt $t4,$t1, rowloop1_1
	j done1_1
done1_1:
	li $v0, 0
	jr $ra
	
	
fail1_1:
	li $v0, -1
	jr $ra

place:
    #Define your code here
	############################################
	lw $t0, 0($sp)	#t0 = col of set
	lhu $t1 4($sp)	#$t1 = value being added to row,col
	#addi $sp,$sp,4
	
	#save used s registers
	addi $sp, $sp, -16
	sw $s0, 0($sp)
	sw $s1, 4($sp)
	sw $s2, 8($sp)
	sw $s3, 12($sp)
	
	move $s0, $a0	#s0 = board addr
	move $s1, $a1	#$s1 = num rows in board
	move $s2, $a2	#s2 = num cols in board
	move $s3, $a3	#s3 = row of set
    	
    	li $t2, 2	#check register
    	#check part 1 (n_row,n_col)
    	blt $s1,$t2, fail1_2
    	blt $s2, $t2, fail1_2
    	#check part 2 (row,col)
    	addi $t2, $s1, -1	#t2 set to n_row-1
    	bltz $s3, fail1_2
    	bgt $s3, $t2, fail1_2
    	addi $t2, $s2, -1
    	bltz $t0, fail1_2
    	bgt $t0, $t2, fail1_2
    	
    	#check part 3 (value)
    	li $t2, -1
    	bne $t1, $t2, notNeg1
    	j addTo1_2
    	
    	#li $v0, 0
    	jr $ra
    	
	############################################
   
notNeg1:
	#if its not neg one it must be a power of two
    	addi $t2, $t1, -1
    	and $t2, $t2, $t1
    	bnez $t2, fail1_2
    	j addTo1_2
addTo1_2:
	#to continue onwards..
	
	#now we set the value at the specified cell
	li $t9, 2
	mul $t4, $s3, $s2
	mul $t4, $t4, $t9
	mul $t5, $t0,$t9
	add $t6,$s0,$t4
	add $t6,$t6,$t5
	sh $t1, 0($t6)
	j sucess1_2

	
	
 fail1_2:
 	li $v0, -1
 	#load back the registers
 	lw $s0, 0($sp)
 	lw $s1, 4($sp)
 	lw $s2, 8($sp)
 	lw $s3, 12($sp)
 	addi $sp,$sp, 16
 	
 	jr $ra
sucess1_2:
	li $v0,0
	lw $s0, 0($sp)
 	lw $s1, 4($sp)
 	lw $s2, 8($sp)
 	lw $s3, 12($sp)
 	addi $sp,$sp, 16
	jr $ra

start_game:
    #Define your code here
	############################################
	lw $t0, 0($sp)	#t0 = c1
	lw $t1, 4($sp)  #t1 = r2
	lw $t2, 8($sp) #t2 = c2
	
	addi $sp,$sp, -32
	sw $s0, 0($sp)
	sw $s1,4($sp)
	sw $s2, 8($sp)
	sw $s3, 12($sp)
	sw $ra, 16($sp)
	sw $s4, 20($sp)
	sw $s5, 24($sp)
	sw $s6, 28($sp)
	
	move $s0, $a0 #s0 = board add
	move $s1, $a1 #s1 = num rows
	move $s2, $a2 #s2 = num cols
	move $s3, $a3 #s3  = r1
	move $s4, $t0 #s4 = c1
	move $s5, $t1 #s5 = r2
	move $s6, $t2 #s6 = c2
	
	li $t3, 2
	blt $s1, $t3, failstartgame
    	blt $s2, $t3, failstartgame
    	addi $t3, $s1, -1
    	bltz $s3, failstartgame
    	bgt $s3, $t3, failstartgame
    	bltz $s5, failstartgame
    	bgt $s5, $t3, failstartgame
    	addi $t3, $s2, -1
    	bltz $s4, failstartgame
    	bgt $s4, $t3, failstartgame
    	bltz $s6, failstartgame
    	bgt $s6, $t3, failstartgame
    	
    	#clear the board
    	move $a0, $s0
    	move $a1, $s1
    	move $a2, $s2
    	jal clear_board
    	#first add
    	li $t9, 2
    	move $a0, $s0
    	move $a1, $s1
    	move $a2, $s2
    	move $a3, $s3
    	addi $sp, $sp, -8
    	sw $s4, 0($sp)
    	sw $t9, 4($sp)
    	jal place
    	addi $sp,$sp, 8
    	#second add
    	li $t9, 2
    	move $a0, $s0
    	move $a1, $s1
    	move $a2, $s2
    	move $a3, $s5
    	addi $sp, $sp, -8
    	sw $s6, 0($sp)
    	sw $t9, 4($sp)
    	jal place
    	addi $sp,$sp, 8
    	li $v0, 0
    	lw $s0, 0($sp)
	lw $s1,4($sp)
	lw $s2, 8($sp)
	lw $s3, 12($sp)
	lw $ra, 16($sp)
	lw $s4, 20($sp)
	lw $s5, 24($sp)
	lw $s6, 28($sp)
	addi $sp,$sp,32
	############################################
    jr $ra

failstartgame:
	li $v0, -1
	lw $s0, 0($sp)
	lw $s1,4($sp)
	lw $s2, 8($sp)
	lw $s3, 12($sp)
	lw $ra, 16($sp)
	lw $s4, 20($sp)
	lw $s5, 24($sp)
	lw $s6, 28($sp)
	addi $sp,$sp,32
	jr $ra

##############################
# PART 2 FUNCTIONS
##############################

merge_row:
    #Define your code here
    ############################################
    lw $t0, 0($sp)		# set t0 equal to the int dir
    
    addi $sp,$sp, -20
    sw $s0, 0($sp)
    sw $s1, 4($sp)
    sw $s2, 8($sp)
    sw $s3, 12($sp)
    sw $s4, 16($sp)
    
    move $s0, $a0	#s0 = board addr
    move $s1, $a1	#s1 = num rows
    move $s2, $a2	#s2 = num cols
    move $s3, $a3	#s3 = row for merge
    move $s4, $t0 	#s4 = int dir
    
    li $t9, 0
    bne $s4, $t9, checkifis1
    
    j part2_1continuecheck
    ############################################

checkifis1:
	li $t9, 1
	bne $s4, $t9, fail2_1
	j part2_1continuecheck
	
part2_1continuecheck:
	# now we have to check if num rows or num cols is less than 2
	li $t9, 2
	blt $s1, $t9, fail2_1
	blt $s2, $t9, fail2_1
	# now we check if the row for merge is within range 0 to num rows -1
	addi $t8, $s1, -1
	bltz $s3, fail2_1
	bgt $s3, $t8, fail2_1
	
	#now we are done with checking if all the pre-conditions are valid. Lets proceed on to merge row
	
	#now we get the starting addr of the row we are checking
	beqz $s4, rowleftright
	j rowrightleft
	#j done2_1
rowleftright:
	li $t9, 2
	mul $t6, $s3, $s2	#multiply row of set x col in board
	mul $t6,$t6,$t9	#mul by size in bytes
	add $t6,$t6,$s0	#t6 is now the start 
	#sh $t9,0($t6)
	li $t8,0 #t8 counter of cols to check up to max num col -1
	addi $t0, $s2,-1
	li $t1, 0	#counter to return
	#j done2_1
	#now we have the right address, we now go to checking and combibing
	j maniprowleftright
maniprowleftright:
	beq $t8, $t0, done2_1
	
	addi $t8,$t8,1
	add $t5, $t6,$t9	#i+1 of col
	lhu $t4, 0($t6)		#value at i
	lhu $t3, 0($t5)		#value at i+1
	add $t6, $t6,$t9	#i of col
	beq $t4, $t3, checknotneg1rowleftright
	j maniprowleftright

checknotneg1rowleftright:
	li $t2, -1
	srl $t2,$t2, 16
	bne $t4,$t2,mergeleftright
	j maniprowleftright
mergeleftright:
	sll $t4, $t4, 1
	addi $t6,$t6,-2
	sh $t4, 0($t6)
	addi $t6,$t6,2
	li $t2,-1
	sh $t2, 0($t5)
	addi $t1,$t1,1
	j maniprowleftright
rowrightleft:
	li $t9, 2
	mul $t6, $s3, $s2	#multiply row of set x col of set
	mul $t6,$t6,$t9	#mul by size in bytes
	addi $t9, $s2,-1
	li $t4, 2
	mul $t8, $t4, $t9
	add $t6,$t6,$t8
	add $t6,$t6,$s0	#t6 now start addr at end of row
	li $t9, -2
	#j done2_1
	li $t8,0 #t8 counter of cols to check up to max num col -1
	addi $t0, $s2,-1
	li $t1, 0	#counter to return
	
	j rowrightleftloop

rowrightleftloop:
	beq $t8, $t0, done2_1
	addi $t8,$t8, 1
	add $t5, $t6, $t9	#t5 = previous row index
	lhu $t4, 0($t6)		#value at i
	lhu $t3, 0($t5)		#value at i+1
	add $t6, $t6,$t9	#i of col
	beq $t4, $t3, checknotneg1rowrightleft
	j rowrightleftloop
checknotneg1rowrightleft:
	li $t2, -1
	srl $t2,$t2, 16
	bne $t4,$t2,mergerightleft
	j rowrightleftloop

mergerightleft:
	sll $t4, $t4, 1
	addi $t6,$t6,2
	sh $t4, 0($t6)
	addi $t6,$t6,-2
	li $t2,-1
	sh $t2, 0($t5)
	addi $t1,$t1,1
	j rowrightleftloop

done2_1:
	move $v0, $t1
	lw $s0, 0($sp)
    	lw $s1, 4($sp)
    	lw $s2, 8($sp)
    	lw $s3, 12($sp)
    	lw $s4, 16($sp)
    	addi $sp,$sp, 20
    	jr $ra

fail2_1:
	li $v0, -1
	lw $s0, 0($sp)
    	lw $s1, 4($sp)
    	lw $s2, 8($sp)
    	lw $s3, 12($sp)
    	lw $s4, 16($sp)
    	addi $sp,$sp, 20
    	jr $ra
    

merge_col:
    #Define your code here
    ############################################
    lw $t0, 0($sp)	#set t0 equal to the int dir
    
    addi $sp,$sp,-20
    sw $s0, 0($sp)
    sw $s1, 4($sp)
    sw $s2, 8($sp)
    sw $s3, 12($sp)
    sw $s4, 16($sp)
    
    move $s0, $a0 # s0 = board addr
    move $s1, $a1 #s1 = num rows
    move $s2, $a2 #s2 = num cols
    move $s3, $a3 #s3 = col for merge
    move $s4, $t0 # s4 = int dir
    
    li $t9, 0
    bne $s4, $t9, checkifis1col
    
    ############################################
    j part2_2continuecheck
    
checkifis1col:
	li $t9, 1
	bne $s4, $t9, fail2_2
	j part2_2continuecheck

part2_2continuecheck:
	li $t9, 2
	blt $s1, $t9, fail2_2
	blt $s2, $t9, fail2_2
	addi $t8,$s2, -1
	bltz $s3, fail2_2
	bgt $s3, $t8, fail2_2
	beqz $s4, colbottomtop
	j coltopbottom

colbottomtop:
	li $t9, 2
	addi $t8,$s1,-1
	mul $t6,$t8,$s2
	mul $t6,$t6,$t9
	mul $t7, $s3,$t9
	add $t6,$t6,$t7
	add $t6,$t6, $s0
	#sh $t9, 0($t6)
	mul $t9, $s2,$t9
	li $t8, 0 #t8 num ows to check up to max num col
	addi $t0, $s1, -1
	li $t1, 0 #counter to return
	
	j loopbottomtop

loopbottomtop:
	beq $t8,$t0, done2_2
	addi $t8,$t8,1
	sub $t5,$t6,$t9	#t5 is now i-1
	lhu $t4, 0($t6)
	lhu $t3, 0($t5)
	sub $t6,$t6,$t9
	beq $t4,$t3,checknotneg1bottomtop
	j loopbottomtop
	
checknotneg1bottomtop:
	li $t2, -1
	srl $t2,$t2,16
	bne $t4,$t2,mergebottomtop
	j loopbottomtop
mergebottomtop:
	sll $t4,$t4,1
	add $t6,$t6,$t9
	sh $t4,0($t6)
	sub $t6,$t6,$t9
	li $t2,-1
	sh $t2,0($t5)
	addi $t1,$t1,1
	j loopbottomtop
coltopbottom:
	#the purpose of this is to set our starting addr
	li $t9, 2
	mul $t6, $t9,$s3
	add $t6,$t6,$s0
	#sh $t9, 0($t6)
	li $t8, 0 #t8 num ows to check up to max num col
	addi $t0, $s1, -1
	li $t1, 0 #counter to return
	mul $t9, $s2,$t9
	j looptopbottom

looptopbottom:
	beq $t8,$t0, done2_2
	addi $t8,$t8,1
	add $t5, $t6, $t9 #t5 is now i+1 
	lhu $t4, 0($t6)	#value at i
	lhu $t3, 0($t5) #value at i+1
	add $t6,$t6,$t9
	beq $t4,$t3, checknotneg1topbottom
	j looptopbottom
	
checknotneg1topbottom:
	li $t2, -1
	srl $t2,$t2,16
	bne $t4,$t2,mergetopbottom
	j looptopbottom
mergetopbottom:
	sll $t4,$t4,1
	sub $t6,$t6,$t9
	sh $t4,0($t6)
	add $t6,$t6,$t9
	li $t2,-1
	sh $t2,0($t5)
	addi $t1,$t1,1
	j looptopbottom
	
done2_2:
	move $v0, $t1
	lw $s0, 0($sp)
    	lw $s1, 4($sp)
    	lw $s2, 8($sp)
    	lw $s3, 12($sp)
    	lw $s4, 16($sp)
    	addi $sp,$sp, 20
    	jr $ra

fail2_2:
	li $v0, -1
	lw $s0, 0($sp)
    	lw $s1, 4($sp)
    	lw $s2, 8($sp)
    	lw $s3, 12($sp)
    	lw $s4, 16($sp)
    	addi $sp,$sp, 20
    	jr $ra
shift_row:
    #Define your code here
    ############################################
    lw $t0, 0($sp)	#dir = t0
    
    addi $sp,$sp, -28
    sw $s0, 0($sp)
    sw $s1, 4($sp)
    sw $s2, 8($sp)
    sw $s3, 12($sp)
    sw $s4, 16($sp)
    sw $s5, 20($sp)
    sw $s6, 24($sp)
    
    move $s0, $a0	# board adr
    move $s1, $a1	# num rows
    move $s2, $a2	#num cols
    move $s3, $a3	#row to be shifted
    move $s4, $t0	#dir
    
    li $t9, 0
    bne $s4, $t9, checkif1_shift_row
    j shift_rowcontinuecheck
    ############################################
    
checkif1_shift_row:
	li $t9, 1
	bne $s4, $t9, fail_2_3
	j shift_rowcontinuecheck
shift_rowcontinuecheck:
	li $t9, 2
	blt $s1, $t9, fail_2_3
	blt $s2, $t9, fail_2_3
	addi $t8, $s1, -1
	bgt $s3, $t8, fail_2_3
	bltz $s3, fail_2_3
	beqz $s4, shift_row_left
	j shift_row_right

shift_row_left:
	li $t9, 2
	mul $t6, $s3, $s2
	mul $t6,$t6, $t9
	addi $t6,$t6,2
	add $t6,$t6,$s0		#now t6 has the start addr of shift row left
	li $t8, 0	#counter cols to check
	addi $t0, $s2,-1
	li $t1, 0 #counter of shifts to return
	li $t2, 0 #allowed left shift checks
	#sh $t9,0($t6)
	j loop_1_shiftleft
	
loop_1_shiftleft:
	beq $t8,$t0, done_2_3
	addi $t8,$t8, 1
	addi $t2,$t2, 1
	li $t9, 2
	li $t7, -1
	srl $t7,$t7,16
	#sub $t5, $t6,$t9
	#lhu $t4,0($t6)	#i
	#lhu $t3, 0($t5)	#i-1
	move $s6, $t6
	
	li $s5, 0 #counter for the amount of possible shifts left relies on t2
	j loop_2_shiftleft

loop_2_shiftleft:
	beq $s5, $t2, loop_1_shiftleft2
	addi $s5,$s5,1
	sub $t5, $s6, $t9
	lhu $t4, 0($s6)
	beq $t4,$t7,loop_1_shiftleft2
	lhu $t3,0($t5)
	beq $t3, $t7, changeloop2_shiftleft
	add $t6,$t6,$t9
	j loop_1_shiftleft
changeloop2_shiftleft:
	sh $t4, 0($t5)
	sh $t7, 0($s6)
	sub $s6, $s6, $t9
	addi $t1,$t1,1
	j loop_2_shiftleft
loop_1_shiftleft2:
	add $t6,$t6,$t9
	j loop_1_shiftleft

shift_row_right:
	li $t9,2
	mul $t6,$s3,$s2
	mul $t6,$t6,$t9
	addi $t5,$s2,-2
	mul $t5,$t5,$t9
	add $t6,$t6,$t5
	add $t6,$t6,$s0	#now t6 has our starting addr
	#sh $t9, 0($t6)
	#j done_2_3
	li $t8, 0 #counter cols to check
	addi $t0,$s2,-1
	li $t1, 0	#counter of shifts to return
	li $t2, 0 	#allowed left shift checks
	j loop_1_shiftright
	
loop_1_shiftright:
	beq $t8,$t0, done_2_3
	addi $t8,$t8,1
	addi $t2,$t2,1
	li $t9, -2
	li $t7, -1
	srl $t7,$t7,16
	move $s6,$t6
	li $s5,0
	j loop_2_shiftright
loop_2_shiftright:
	beq $s5,$t2, loop_2_shiftright2
	addi $s5,$s5,1
	sub $t5,$s6,$t9
	lhu $t4,0($s6)
	beq $t4,$t7, loop_2_shiftright2
	lhu $t3, 0($t5)
	beq $t3,$t7, changeloop2_shiftright
	add $t6,$t6,$t9
	j loop_1_shiftright
changeloop2_shiftright:
	sh $t4, 0($t5)
	sh $t7,0($s6)
	sub $s6, $s6,$t9
	addi $t1,$t1, 1
	j loop_2_shiftright

loop_2_shiftright2:
	add $t6,$t6,$t9
	j loop_1_shiftright

fail_2_3:
	li $v0, -1
	lw $s0, 0($sp)
    	lw $s1, 4($sp)
    	lw $s2, 8($sp)
    	lw $s3, 12($sp)
    	lw $s4, 16($sp)
    	lw $s5, 20($sp)
    	lw $s6, 24($sp)
    	addi $sp,$sp, 28
	jr $ra
done_2_3:
	move $v0,$t1
	lw $s0, 0($sp)
    	lw $s1, 4($sp)
    	lw $s2, 8($sp)
    	lw $s3, 12($sp)
    	lw $s4, 16($sp)
    	lw $s5, 20($sp)
    	lw $s6, 24($sp)
    	addi $sp,$sp, 28
	jr $ra
shift_col:
    #Define your code here
    ############################################
    lw $t0, 0($sp)
    
    addi $sp,$sp, -28
    sw $s0, 0($sp)
    sw $s1, 4($sp)
    sw $s2, 8($sp)
    sw $s3, 12($sp)
    sw $s4, 16($sp)
    sw $s5, 20($sp)
    sw $s6, 24($sp)
    
    move $s0, $a0	#board addr
    move $s1, $a1	#num rows
    move $s2, $a2	#num cols
    move $s3, $a3	#rows to be shifted
    move $s4, $t0	#dir
    
    li $t9, 0 
    bne $s4, $t9, checkif1_shift_col
    ############################################
    j shift_colcontinuecheck
checkif1_shift_col:
	li $t9, 1
	bne $s4, $t9, fail_2_4
	j shift_colcontinuecheck

shift_colcontinuecheck:
	li $t9, 2
	blt $s1, $t9, fail_2_4
	blt $s2, $t9, fail_2_4
	addi $t8,$s2, -1
	bgt $s3, $t8, fail_2_4
	bltz $s3, fail_2_4
	beqz $s4, shiftcolup
	j shiftcoldown
shiftcolup:
	li $t9, 2
	mul $t6, $s3,$t9
	mul $t5, $s2,$t9
	add $t6,$t6,$t5
	add $t6,$t6,$s0
	move $t9, $t5
	
	li $t8, 0 #counter rows to check
	addi $t0, $s1, -1
	li $t1, 0	#counter shifts to return
	li $t2, 0	#allowed up shift checks
	
	j loop1shiftup
	
loop1shiftup:
	beq $t8,$t0, done_2_4
	addi $t8,$t8, 1
	addi $t2,$t2, 1
	li $t7, -1
	srl $t7,$t7, 16
	move $s6,$t6
	li $s5, 0 
	j loop2shiftup

loop2shiftup:
	beq $s5,$t2, loop1shiftup2
	addi $s5,$s5,1
	sub $t5,$s6,$t9
	lhu $t4,0($s6)
	beq $t4,$t7, loop1shiftup2
	lhu $t3,0($t5)
	beq $t3,$t7,changeloop2shiftup
	add $t6,$t6,$t9
	j loop1shiftup
changeloop2shiftup:
	sh $t4,0($t5)
	sh $t7, 0($s6)
	sub $s6,$s6,$t9
	addi $t1,$t1,1
	j loop2shiftup
loop1shiftup2:
	add $t6,$t6,$t9
	j loop1shiftup
	
shiftcoldown:
	li $t9, 2
	mul $t6, $s3, $t9
	mul $t5,$s2,$t9
	addi $t4, $s1, -2
	mul $t4,$t5, $t4
	add $t6,$t6,$t4
	add $t6,$t6,$s0		#t6 now has the starting addrr
	#addi $t5,$t5, -2
	move $t9, $t5
	
	li $t8, 0
	addi $t0,$s1, -1
	li $t1, 0
	li $t2, 0
	
	j loop1shiftdown

loop1shiftdown:
	beq $t8,$t0, done_2_4
	addi $t8,$t8,1
	addi $t2,$t2, 1
	li $t7, -1
	srl $t7,$t7, 16
	move $s6,$t6
	li $s5, 0
	j loop2shiftdown

loop2shiftdown:
	beq $s5,$t2, loop1shiftdown2
	addi $s5,$s5,1
	add $t5,$s6, $t9
	lhu $t4,0($s6)
	beq $t4,$t7, loop1shiftdown2
	lhu $t3, 0($t5)
	beq $t3,$t7, changeloop2shiftdown
	sub $t6,$t6, $t9
	j loop1shiftdown
	
changeloop2shiftdown:
	sh $t4, 0($t5)
	sh $t7, 0($s6)
	add $s6,$s6,$t9
	addi $t1,$t1,1
	j loop2shiftdown

loop1shiftdown2:
	sub $t6,$t6,$t9
	j loop1shiftdown
	

fail_2_4:
	li $v0, -1
	lw $s0, 0($sp)
    	lw $s1, 4($sp)
    	lw $s2, 8($sp)
    	lw $s3, 12($sp)
    	lw $s4, 16($sp)
    	lw $s5, 20($sp)
    	lw $s6, 24($sp)
    	addi $sp,$sp, 28
	jr $ra
done_2_4:
	move $v0,$t1
	lw $s0, 0($sp)
    	lw $s1, 4($sp)
    	lw $s2, 8($sp)
    	lw $s3, 12($sp)
    	lw $s4, 16($sp)
    	lw $s5, 20($sp)
    	lw $s6, 24($sp)
    	addi $sp,$sp, 28
	jr $ra

check_state:
    #Define your code here
    ############################################
    addi $sp,$sp, -12
    sw $s0, 0($sp)
    sw $s1, 4($sp)
    sw $s2, 8($sp)
    
    li $t3, 2
    
    move $s0, $a0		#addr
    move $s1, $a1	#num rows
    move $s2, $a2	#num cols
    
    j checkfor2048
    
    ############################################
    
checkfor2048:
	li $t4, 0 #t4 is our row counter
	li $t9, 2048	#t9 is the value we are checking for
	j checkfor2048loop

checkfor2048loop:
	li $t5, 0 #t5 is our col counter
	j checkfor2048colloop
checkfor2048colloop:
	mul $t6, $t4,$s2
	add $t6,$t6,$t5
	mul $t6,$t6,$t3
	add $t6,$t6,$s0
	#sh $t3,0($t6)
	lhu $t8, 0($t6)
	beq $t8,$t9, youwin
	addi $t5,$t5, 1
	blt $t5,$s2, checkfor2048colloop
	j checkfor2048colloopdone
	
checkfor2048colloopdone:
	addi $t4,$t4,1
	blt $t4,$s1, 	checkfor2048loop
	j inconclusive
	
inconclusive:
	# now we have to check if moves are still possible
	
	#to do this we have to check if all cells are full first
	li $t4, 0 
	li $t9, -1
	srl $t9,$t9,16
	j checkforblanksloop
	
	
checkforblanksloop:
	li $t5, 0	#t5 is our col counter
	j checkforblankcolloop
checkforblankcolloop:
	mul $t6, $t4, $s2
	add $t6, $t6, $t5
	mul $t6,$t6, $t3
	add $t6,$t6,$s0
	lhu $t8, 0($t6)
	#sh $t3,0($t6)
	beq $t8,$t9, existsblank
	addi $t5,$t5, 1
	blt $t5,$s2, checkforblankcolloop
	j checkforblankloopdone
checkforblankloopdone:
	addi $t4,$t4, 1
	blt $t4,$s1, checkforblanksloop
	j doesnotexistblank
existsblank:
	lw $s0, 0($sp)
	lw $s1, 4($sp)
	lw $s2, 8($sp)
	addi $sp,$sp,12
	li $v0, 0
	jr $ra
doesnotexistblank:
	#li $v0, -1
	#jr $ra
	#now we have to check if the adjacent cells of the board can be added together.. (last part of check)
	 
	 #first we will check each row with a fake merge
	 li $t7,0	#t7 is num of rows we have checked
	 j checkrows
	
checkrows:
	beq $t7,$s1, checkcolspre
	#addi $t7,$t7,1
	j checkrows2

checkrows2:
	li $t9, 2
	mul $t6,$t7,$s2
	mul $t6,$t6,$t9
	add $t6,$t6,$s0
	li $t8, 0	#counter of cols to check up to
	addi $t0,$s2,-1
	j checkrows3
checkrows3:
	beq $t8,$t0, advancerow
	
	addi $t8,$t8,1
	add $t5,$t6,$t9
	lhu $t4,0($t6)
	lhu $t3,0($t5)
	add $t6,$t6,$t9
	beq $t4,$t3, inconclusivefull
	j checkrows3
advancerow:
	addi $t7,$t7,1
	j checkrows
	
checkcolspre:
	li $t7, 0 #t7 is the num of cols we have checked
	j checkcols	
checkcols:
	 #j inconclusivefull
	 beq $t7, $s2, youlose
	 j checkcols2
checkcols2:
	li $t9, 2
	mul $t6, $t9, $t7
	add $t6,$t6,$s0
	li $t8, 0 
	addi $t0, $s1, -1
	mul $t9,$s2,$t9
	j checkcols3
checkcols3:
	beq $t8,$t0, advancecol
	addi $t8,$t8,1
	add $t5,$t6,$t9
	lhu $t4,0($t6)
	lhu $t3,0($t5)
	add $t6,$t6,$t9
	beq $t4,$t3, inconclusivefull
	j checkcols3
advancecol:
	addi $t7,$t7,1
	j checkcols

inconclusivefull:
	lw $s0, 0($sp)
	lw $s1, 4($sp)
	lw $s2, 8($sp)
	addi $sp,$sp,12
	li $v0,0
	jr $ra

youlose:
	lw $s0, 0($sp)
	lw $s1, 4($sp)
	lw $s2, 8($sp)
	addi $sp,$sp,12
	li $v0, -1
	jr $ra
	 
	
youwin:
	lw $s0, 0($sp)
	lw $s1, 4($sp)
	lw $s2, 8($sp)
	addi $sp,$sp,12
	li $v0, 1
	jr $ra
	
	

user_move:
    #Define your code here
    ############################################
    addi $sp,$sp, -24
    sw $s0, 0($sp)
    sw $s1, 4($sp)
    sw $s2, 8($sp)
    sw $s3, 12($sp)
    sw $ra,16($sp)
    sw $s4, 20($sp)
    
    move $s0,$a0	#board addr
    move $s1,$a1	#num rows
    move $s2, $a2	#num cols
    move $s3,$a3	#dir
    
    li $t0, 'L'
    beq $s3, $t0, usermoveleft
    li $t0, 'R'
    beq $s3,$t0, usermoveright
    li $t0, 'U'
    beq $s3,$t0, usermoveup
    li $t0, 'D'
    beq $s3,$t0, usermovedown
    
    #clearly someone can't type L R U D
    li $v0, -1
    li $v1, -1
    lw $s0, 0($sp)
    lw $s1, 4($sp)
    lw $s2, 8($sp)
    lw $s3, 12($sp)
    lw $ra, 16($sp)
    lw $s4, 20($sp)
    addi $sp,$sp, 24
    jr $ra
    
errorusermove:
	li $v0, -1
    	li $v1, -1
    	lw $s0, 0($sp)
    	lw $s1, 4($sp)
    	lw $s2, 8($sp)
    	lw $s3, 12($sp)
    	lw $ra, 16($sp)
    	lw $s4, 20($sp)
    	addi $sp,$sp, 24
    	jr $ra    
    
checkstateuser:
	move $a0, $s0
	move $a1, $s1
	move $a2, $s2
	jal check_state
	move $v1, $v0
	li $v0 , 0
	lw $s0, 0($sp)
    	lw $s1, 4($sp)
    	lw $s2, 8($sp)
    	lw $s3, 12($sp)
    	lw $ra, 16($sp)
    	lw $s4, 20($sp)
    	addi $sp,$sp, 24
    	jr $ra   
   	
usermoveleft:
	li $s4, 0	#t7 counter of how many rows 
	j usermoveleft2
	
usermoveleft2:
	beq $s4, $s1, checkstateuser
	move $a0, $s0
	move $a1, $s1
	move $a2, $s2
	move $a3, $s4
	li $t0, 0
	addi $sp,$sp, -4
	sw $t0, 0($sp)
	
	jal shift_row
	addi $sp,$sp, 4
	move $t1, $v0
	li $t2, -1
	beq $t1, $t2, errorusermove2
	li $t0, 0
	addi $sp,$sp, -4
	sw $t0, 0($sp)
	jal merge_row
	addi $sp,$sp, 4
	move $t1, $v0
	li $t2, -1
	beq $t1, $t2, errorusermove2
	li $t0, 0
	addi $sp,$sp, -4
	sw $t0, 0($sp)
	jal shift_row
	addi $sp,$sp, 4
	move $t1, $v0
	li $t2, -1
	beq $t1, $t2, errorusermove2
	addi $s4,$s4,1
	
	j usermoveleft2
errorusermove2:
	
	j errorusermove

usermoveright:
	li $s4, 0
	j usermoveright2
usermoveright2:
	beq $s4, $s1, checkstateuser
	move $a0, $s0
	move $a1, $s1
	move $a2, $s2
	move $a3, $s4
	li $t0, 1
	addi $sp,$sp, -4
	sw $t0, 0($sp)
	
	jal shift_row
	addi $sp,$sp, 4
	move $t1, $v0
	li $t2, -1
	beq $t1, $t2, errorusermove2
	li $t0, 1
	addi $sp,$sp, -4
	sw $t0, 0($sp)
	jal merge_row
	addi $sp,$sp, 4
	move $t1, $v0
	li $t2, -1
	beq $t1, $t2, errorusermove2
	li $t0, 1
	addi $sp,$sp, -4
	sw $t0, 0($sp)
	jal shift_row
	addi $sp,$sp, 4
	move $t1, $v0
	li $t2, -1
	beq $t1, $t2, errorusermove2
	addi $s4,$s4,1
	j usermoveright2
usermoveup:
	li $s4, 0
	j usermoveup2
usermoveup2:
	beq $s4, $s2, checkstateuser
	move $a0, $s0
	move $a1, $s1
	move $a2, $s2
	move $a3, $s4
	li $t0, 0
	addi $sp,$sp, -4
	sw $t0, 0($sp)
	
	jal shift_col
	addi $sp,$sp, 4
	move $t1, $v0
	li $t2, -1
	beq $t1, $t2, errorusermove2
	li $t0, 0
	addi $sp,$sp, -4
	sw $t0, 0($sp)
	jal merge_col
	addi $sp,$sp, 4
	move $t1, $v0
	li $t2, -1
	beq $t1, $t2, errorusermove2
	li $t0, 0
	addi $sp,$sp, -4
	sw $t0, 0($sp)
	jal shift_col
	addi $sp,$sp, 4
	move $t1, $v0
	li $t2, -1
	beq $t1, $t2, errorusermove2
	addi $s4,$s4,1
	j usermoveup2

usermovedown:	
	li $s4,0
	j usermovedown2
usermovedown2:
	beq $s4, $s2, checkstateuser
	move $a0, $s0
	move $a1, $s1
	move $a2, $s2
	move $a3, $s4
	li $t0, 1
	addi $sp,$sp, -4
	sw $t0, 0($sp)
	
	jal shift_col
	addi $sp,$sp, 4
	move $t1, $v0
	li $t2, -1
	beq $t1, $t2, errorusermove2
	li $t0, 1
	addi $sp,$sp, -4
	sw $t0, 0($sp)
	jal merge_col
	addi $sp,$sp, 4
	move $t1, $v0
	li $t2, -1
	beq $t1, $t2, errorusermove2
	li $t0, 1
	addi $sp,$sp, -4
	sw $t0, 0($sp)
	jal shift_col
	addi $sp,$sp, 4
	move $t1, $v0
	li $t2, -1
	beq $t1, $t2, errorusermove2
	addi $s4,$s4,1
	j usermovedown2
    
   

    
    ############################################
    

#################################################################
# Student defined data section
#################################################################
.data
.align 2  # Align next items to word boundary

#place all data declarations here


