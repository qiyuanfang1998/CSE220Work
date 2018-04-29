

.data
start_Address: .word 0xffff0000
newline:  .asciiz "\n"
lchar: .asciiz "L"
rchar: .asciiz "R"
uchar: .asciiz "U"
dchar: .asciiz "D"
.text
.globl_start

_start:
##########
#1_1 test
##########
li $a0, 0xffff0000
li $a1, 5
li $a2, 4
jal clear_board

move $a0, $v0
li $v0,1
syscall
li $v0, 4
la $a0, newline
syscall



#########
#1_2 test
##@######
li $a0, 0xffff0000
li $a1, 5
li $a2, 4
li $a3, 4
li $t0, 1
li $t1, 128
addi $sp,$sp,-8
sw $t0, 0($sp)
sw $t1, 4($sp)
jal place
addi $sp,$sp,8

move $a0, $v0
li $v0,1
syscall
li $v0, 4
la $a0, newline
syscall


#########
#1_3 test
##@######
li $a0, 0xffff0000
li $a1, 5
li $a2, 4
li $a3, 0
li $t0, 0
li $t1, 0
li $t2, 1
addi $sp,$sp, -12
sw $t0, 0($sp)
sw $t1, 4($sp)
sw $t2, 8 ($sp)
jal start_game
addi $sp,$sp, 12

move $a0, $v0
li $v0,1
syscall
li $v0, 4
la $a0, newline
syscall


li $a0,	0xffff0000
li $a1, 5
li $a2, 4
li $a3, 'U'
jal user_move
move $a0, $v0
li $v0,1
syscall
move $a0, $v1
li $v0,1
syscall
li $v0, 4
la $a0, newline
syscall

li $a0,	0xffff0000
li $a1, 5
li $a2, 4
li $a3, 'D'
jal user_move

li $a0,	0xffff0000
li $a1, 5
li $a2, 4
li $a3, 'R'
jal user_move





###lol
li $a0, 0xffff0000
li $a1, 5
li $a2, 4
li $a3, 2
li $t0, 2
li $t1, 8
addi $sp,$sp,-8
sw $t0, 0($sp)
sw $t1, 4($sp)
jal place
addi $sp,$sp,8

move $a0, $v0
li $v0,1
syscall
li $v0, 4
la $a0, newline
syscall

###lol
li $a0, 0xffff0000
li $a1, 5
li $a2, 4
li $a3, 3
li $t0, 0
li $t1, 8
addi $sp,$sp,-8
sw $t0, 0($sp)
sw $t1, 4($sp)
jal place
addi $sp,$sp,8

move $a0, $v0
li $v0,1
syscall
li $v0, 4
la $a0, newline
syscall

###lol
li $a0, 0xffff0000
li $a1, 5
li $a2, 4
li $a3, 3
li $t0, 1
li $t1, 8
addi $sp,$sp,-8
sw $t0, 0($sp)
sw $t1, 4($sp)
jal place
addi $sp,$sp,8

move $a0, $v0
li $v0,1
syscall
li $v0, 4
la $a0, newline
syscall
###lol
li $a0, 0xffff0000
li $a1, 5
li $a2, 4
li $a3, 3
li $t0, 2
li $t1, 8
addi $sp,$sp,-8
sw $t0, 0($sp)
sw $t1, 4($sp)
jal place
addi $sp,$sp,8

move $a0, $v0
li $v0,1
syscall
li $v0, 4
la $a0, newline
syscall




#########
#1_4 test
##@######
li $a0, 0xffff0000
li $a1, 5
li $a2, 4
li $a3, 3
li $t0, 0
addi $sp,$sp,-4
sw $t0, 0($sp)
jal merge_row
addi $sp,$sp, 4

move $a0, $v0
li $v0,1
syscall
li $v0, 4
la $a0, newline
syscall



###lol
li $a0, 0xffff0000
li $a1, 5
li $a2, 4
li $a3, 2
li $t0, 1
li $t1, 8
addi $sp,$sp,-8
sw $t0, 0($sp)
sw $t1, 4($sp)
jal place
addi $sp,$sp,8

move $a0, $v0
li $v0,1
syscall
li $v0, 4
la $a0, newline
syscall



###lol
li $a0, 0xffff0000
li $a1, 5
li $a2, 4
li $a3, 2
li $t0, 3
li $t1, 8
addi $sp,$sp,-8
sw $t0, 0($sp)
sw $t1, 4($sp)
jal place
addi $sp,$sp,8

move $a0, $v0
li $v0,1
syscall
li $v0, 4
la $a0, newline
syscall




#########
#1_5 test
##@######
li $a0, 0xffff0000
li $a1, 4
li $a2, 4
li $a3, 2
li $t0, 1
addi $sp,$sp,-4
sw $t0, 0($sp)
jal merge_col
addi $sp,$sp, 4

move $a0, $v0
li $v0,1
syscall
li $v0, 4
la $a0, newline
syscall



###lol
li $a0, 0xffff0000
li $a1, 5
li $a2, 4
li $a3, 1
li $t0, 0
li $t1, 8
addi $sp,$sp,-8
sw $t0, 0($sp)
sw $t1, 4($sp)
jal place
addi $sp,$sp,8

move $a0, $v0
li $v0,1
syscall
li $v0, 4
la $a0, newline
syscall

###lol
li $a0, 0xffff0000
li $a1, 4
li $a2, 4
li $a3, 1
li $t0, 1
li $t1, 8
addi $sp,$sp,-8
sw $t0, 0($sp)
sw $t1, 4($sp)
jal place
addi $sp,$sp,8

move $a0, $v0
li $v0,1
syscall
li $v0, 4
la $a0, newline
syscall





#######
#1_6 test
#########
li $a0, 0xffff0000
li $a1, 5
li $a2, 4
li $a3, 2
li $t0, 0
addi $sp,$sp,-4
sw $t0, 0($sp)
jal shift_row
addi $sp,$sp, 4

move $a0, $v0
li $v0,1
syscall
li $v0, 4
la $a0, newline
syscall


###lol
li $a0, 0xffff0000
li $a1, 5
li $a2, 4
li $a3, 4
li $t0, 1
li $t1, 8
addi $sp,$sp,-8
sw $t0, 0($sp)
sw $t1, 4($sp)
jal place
addi $sp,$sp,8

move $a0, $v0
li $v0,1
syscall
li $v0, 4
la $a0, newline
syscall


#######
#1_7 test
#########
li $a0, 0xffff0000
li $a1, 5
li $a2, 4
li $a3, 0
li $t0, 1
addi $sp,$sp,-4
sw $t0, 0($sp)
jal shift_col
addi $sp,$sp, 4

move $a0, $v0
li $v0,1
syscall
li $v0, 4
la $a0, newline
syscall



li $a0, 0xffff0000
li $a1, 5
li $a2, 4
li $a3, 0
li $t0, 0
addi $sp,$sp,-4
sw $t0, 0($sp)
jal shift_col
addi $sp,$sp, 4

move $a0, $v0
li $v0,1
syscall
li $v0, 4
la $a0, newline
syscall


li $a0, 0xffff0000
li $a1, 5
li $a2, 4
li $a3, 1
li $t0, 1
addi $sp,$sp,-4
sw $t0, 0($sp)
jal shift_col
addi $sp,$sp, 4

move $a0, $v0
li $v0,1
syscall
li $v0, 4
la $a0, newline
syscall

li $a0, 0xffff0000
li $a1, 5
li $a2, 4
li $a3, 2
li $t0, 1
addi $sp,$sp,-4
sw $t0, 0($sp)
jal shift_col
addi $sp,$sp, 4

move $a0, $v0
li $v0,1
syscall
li $v0, 4
la $a0, newline
syscall

###lol
li $a0, 0xffff0000
li $a1, 5
li $a2, 4
li $a3, 3
li $t0, 0
li $t1, 8
addi $sp,$sp,-8
sw $t0, 0($sp)
sw $t1, 4($sp)
jal place
addi $sp,$sp,8

move $a0, $v0
li $v0,1
syscall
li $v0, 4
la $a0, newline
syscall


###lol
li $a0, 0xffff0000
li $a1, 5
li $a2, 4
li $a3, 4
li $t0, 0
li $t1, 8
addi $sp,$sp,-8
sw $t0, 0($sp)
sw $t1, 4($sp)
jal place
addi $sp,$sp,8

move $a0, $v0
li $v0,1
syscall
li $v0, 4
la $a0, newline
syscall

li $a0, 0xffff0000
li $a1, 5
li $a2, 4
li $a3, 0
li $t0, 1
addi $sp,$sp,-4
sw $t0, 0($sp)
jal shift_col
addi $sp,$sp, 4

move $a0, $v0
li $v0,1
syscall
li $v0, 4
la $a0, newline
syscall






###
li $a0, 0xffff0000
li $a1, 5
li $a2, 4
li $a3, 0
li $t0, 0
addi $sp,$sp,-4
sw $t0, 0($sp)
jal merge_col
addi $sp,$sp, 4

move $a0, $v0
li $v0,1
syscall
li $v0, 4
la $a0, newline
syscall



li $a0, 0xffff0000
li $a1, 5
li $a2, 4
li $a3, 0
li $t0, 1
addi $sp,$sp,-4
sw $t0, 0($sp)
jal shift_col
addi $sp,$sp, 4

move $a0, $v0
li $v0,1
syscall
li $v0, 4
la $a0, newline
syscall

li $a0, 0xffff0000
li $a1, 5
li $a2, 4
li $a3, 3
li $t0, 0
addi $sp,$sp,-4
sw $t0, 0($sp)
jal shift_row
addi $sp,$sp, 4

move $a0, $v0
li $v0,1
syscall
li $v0, 4
la $a0, newline
syscall
#####fuckmylifecheckcoltest
###lol
li $a0, 0xffff0000
li $a1, 5
li $a2, 4
li $a3, 0
li $t0, 0
li $t1, 2
addi $sp,$sp,-8
sw $t0, 0($sp)
sw $t1, 4($sp)
jal place
addi $sp,$sp,8

li $a0, 0xffff0000
li $a1, 5
li $a2, 4
li $a3, 0
li $t0, 1
li $t1, 4
addi $sp,$sp,-8
sw $t0, 0($sp)
sw $t1, 4($sp)
jal place
addi $sp,$sp,8

li $a0, 0xffff0000
li $a1, 5
li $a2, 4
li $a3, 0
li $t0, 2
li $t1, 8
addi $sp,$sp,-8
sw $t0, 0($sp)
sw $t1, 4($sp)
jal place
addi $sp,$sp,8

li $a0, 0xffff0000
li $a1, 5
li $a2, 4
li $a3, 0
li $t0, 3
li $t1, 16
addi $sp,$sp,-8
sw $t0, 0($sp)
sw $t1, 4($sp)
jal place
addi $sp,$sp,8

li $a0, 0xffff0000
li $a1, 5
li $a2, 4
li $a3, 1
li $t0, 0
li $t1, 16
addi $sp,$sp,-8
sw $t0, 0($sp)
sw $t1, 4($sp)
jal place
addi $sp,$sp,8

li $a0, 0xffff0000
li $a1, 5
li $a2, 4
li $a3, 1
li $t0, 1
li $t1, 8
addi $sp,$sp,-8
sw $t0, 0($sp)
sw $t1, 4($sp)
jal place
addi $sp,$sp,8

li $a0, 0xffff0000
li $a1, 5
li $a2, 4
li $a3, 1
li $t0, 2
li $t1, 4
addi $sp,$sp,-8
sw $t0, 0($sp)
sw $t1, 4($sp)
jal place
addi $sp,$sp,8

li $a0, 0xffff0000
li $a1, 5
li $a2, 4
li $a3, 1
li $t0, 3
li $t1, 2
addi $sp,$sp,-8
sw $t0, 0($sp)
sw $t1, 4($sp)
jal place
addi $sp,$sp,8

li $a0, 0xffff0000
li $a1, 5
li $a2, 4
li $a3, 2
li $t0, 0
li $t1, 2
addi $sp,$sp,-8
sw $t0, 0($sp)
sw $t1, 4($sp)
jal place
addi $sp,$sp,8

li $a0, 0xffff0000
li $a1, 5
li $a2, 4
li $a3, 2
li $t0, 1
li $t1, 4
addi $sp,$sp,-8
sw $t0, 0($sp)
sw $t1, 4($sp)
jal place
addi $sp,$sp,8

li $a0, 0xffff0000
li $a1, 5
li $a2, 4
li $a3, 2
li $t0, 2
li $t1, 8
addi $sp,$sp,-8
sw $t0, 0($sp)
sw $t1, 4($sp)
jal place
addi $sp,$sp,8

li $a0, 0xffff0000
li $a1, 5
li $a2, 4
li $a3, 2
li $t0, 3
li $t1, 16
addi $sp,$sp,-8
sw $t0, 0($sp)
sw $t1, 4($sp)
jal place
addi $sp,$sp,8

li $a0, 0xffff0000
li $a1, 5
li $a2, 4
li $a3, 3
li $t0, 0
li $t1, 16
addi $sp,$sp,-8
sw $t0, 0($sp)
sw $t1, 4($sp)
jal place
addi $sp,$sp,8

li $a0, 0xffff0000
li $a1, 5
li $a2, 4
li $a3, 3
li $t0, 1
li $t1, 8
addi $sp,$sp,-8
sw $t0, 0($sp)
sw $t1, 4($sp)
jal place
addi $sp,$sp,8

li $a0, 0xffff0000
li $a1, 5
li $a2, 4
li $a3, 3
li $t0, 2
li $t1, 4
addi $sp,$sp,-8
sw $t0, 0($sp)
sw $t1, 4($sp)
jal place
addi $sp,$sp,8

li $a0, 0xffff0000
li $a1, 5
li $a2, 4
li $a3, 3
li $t0, 3
li $t1, 2
addi $sp,$sp,-8
sw $t0, 0($sp)
sw $t1, 4($sp)
jal place
addi $sp,$sp,8

li $a0, 0xffff0000
li $a1, 5
li $a2, 4
li $a3, 4
li $t0, 0
li $t1, 2
addi $sp,$sp,-8
sw $t0, 0($sp)
sw $t1, 4($sp)
jal place
addi $sp,$sp,8
li $a0, 0xffff0000
li $a1, 5
li $a2, 4
li $a3, 4
li $t0, 1
li $t1, 4
addi $sp,$sp,-8
sw $t0, 0($sp)
sw $t1, 4($sp)
jal place
addi $sp,$sp,8

li $a0, 0xffff0000
li $a1, 5
li $a2, 4
li $a3, 4
li $t0, 2
li $t1, 8
addi $sp,$sp,-8
sw $t0, 0($sp)
sw $t1, 4($sp)
jal place
addi $sp,$sp,8

li $a0, 0xffff0000
li $a1, 5
li $a2, 4
li $a3, 4
li $t0, 3
li $t1, 8
addi $sp,$sp,-8
sw $t0, 0($sp)
sw $t1, 4($sp)
jal place
addi $sp,$sp,8



########### 1.8 test
li $a0, 0xffff0000
li $a1, 5
li $a2, 4
jal check_state

move $a0, $v0
li $v0,1
syscall
li $v0, 4
la $a0, newline
syscall








li $a0,	0xffff0000
li $a1, 5
li $a2, 4
li $a3, 'U'
jal user_move

move $a0, $v0
li $v0,1
syscall
move $a0, $v1
li $v0,1
syscall
li $v0, 4
la $a0, newline
syscall





li $a0,	0xffff0000
li $a1, 5
li $a2, 4
li $a3, 'L'
jal user_move



li $a0,	0xffff0000
li $a1, 5
li $a2, 4
li $a3, 'R'
jal user_move


li $a0,	0xffff0000
li $a1, 5
li $a2, 4
li $a3, 'U'
jal user_move



move $a0, $v0
li $v0,1
syscall
move $a0, $v1
li $v0,1
syscall
li $v0, 4
la $a0, newline
syscall

li $a0,	0xffff0000
li $a1, 5
li $a2, 4
li $a3, 'U'
jal user_move



li $a0,	0xffff0000
li $a1, 5
li $a2, 4
li $a3, 'R'
jal user_move



li $a0,	0xffff0000
li $a1, 5
li $a2, 4
li $a3, 'U'
jal user_move






li $a0,	0xffff0000
li $a1, 5
li $a2, 4
li $a3, 'D'
jal user_move

li $v0, 10
syscall

move $a0, $v0
li $v0,1
syscall
move $a0, $v1
li $v0,1
syscall
li $v0, 4
la $a0, newline
syscall


li $a0, 0xffff0000
li $a1, 5
li $a2, 4
li $a3, 1
li $t0, 0
addi $sp,$sp,-4
sw $t0, 0($sp)
jal merge_row
addi $sp,$sp, 4



li $a0, 0xffff0000
li $a1, 5
li $a2, 4
li $a3, 2
li $t0, 0
addi $sp,$sp,-4
sw $t0, 0($sp)
jal shift_row
addi $sp,$sp, 4
move $a0, $v0
li $v0,1
syscall
li $v0, 4
la $a0, newline
syscall

li $a0,	0xffff0000
li $a1, 5
li $a2, 4
li $a3, 'U'
jal user_move


li $v0, 10
syscall

li $a0, 0xffff0000
li $a1, 5
li $a2, 4
li $a3, 0
li $t0, 2
li $t1, 1
li $t2, 2
addi $sp,$sp, -12
sw $t0, 0($sp)
sw $t1, 4($sp)
sw $t2, 8 ($sp)
jal start_game
addi $sp,$sp, 12

move $a0, $v0
li $v0,1
syscall
li $v0, 4
la $a0, newline
syscall


li $v0, 10
syscall


.include "hw4.asm"
