.data		     
grid1:	  .space 40000 # grid to have the first bomb placement from user
grid2: 	  .space 40000 # grid to implement bomberMan and explodeBombs functions and copy it to grid1
row:	  .word 0      # row size which is taken from user => initially zero
column:   .word 0      # column size which is taken from user => initially zero
seconds:  .word 0      # till this second we print the map every second. It is taken from user. => initially zero
prompt1:  .asciiz "Enter the row size:\n"
prompt2:  .asciiz "Enter the column size:\n"
prompt3:  .asciiz "Enter the seconds: "
prompt4:  .asciiz "Enter the grid:\n"
first_s:  .asciiz "1. second: \n"
str_grid: .asciiz "Grid:\n"
str_bomb: .asciiz "BomberMan planting the bombs...\n"
str_second: .asciiz ". second: \n"
str_explode: .asciiz "Exploding the bombs!\n"
.text
	.globl main
	
main:
    # Print prompt1
    li $v0, 4              # Load immediate value 4 into $v0 for print_string syscall
    la $a0, prompt1        # Load address of prompt1 string into $a0
    syscall                # Execute syscall

    # Read row
    li $v0, 5              # Load immediate value 5 into $v0 for read_integer syscall
    syscall                # Execute syscall
    sw $v0, row            # Store the read integer (in $v0) into memory location of row
    
    # Print prompt2
    li $v0, 4              # Load immediate value 4 into $v0 for print_string syscall
    la $a0, prompt2        # Load address of prompt12string into $a0
    syscall                # Execute syscall

    # Read column
    li $v0, 5              # Load immediate value 5 into $v0 for read_integer syscall
    syscall                # Execute syscall
    sw $v0, column         # Store the read integer (in $v0) into memory location of column

    # Print prompt3
    li $v0, 4              # Load immediate value 4 into $v0 for print_string syscall
    la $a0, prompt3        # Load address of prompt2 string into $a0
    syscall                # Execute syscall

    # Read seconds
    li $v0, 5              # Load immediate value 5 into $v0 for read_integer syscall
    syscall                # Execute syscall
    sw $v0, seconds        # Store the read integer (in $v0) into memory location of seconds

    # Print prompt4
    li $v0, 4           # Load immediate value 4 into $v0 for print_string syscall
    la $a0, prompt4     # Load address of prompt4 string into $a0
    syscall             # Execute syscall

    # Read grid as a string
    li $v0, 8           # Load immediate value 8 into $v0 for read_string syscall
    la $a0, grid1       # Load address of grid1 to store the string
    la $a1, 40000       # Load the maximum length of the string
    syscall             # Execute syscall

    # At this point, the grid is stored in the grid1 memory location as a string


    
    la $a0, grid1 # passing grid1 as the argument of copyGrid as source array.
    la $a1, grid2 # passing grid2 as the argument of copyGrid as destination array.
    jal copyGrid  # call copyGrid function to copy the grid1 to grid2 and come back here.
    # we copy the grid1 to grid2 because we should store the initial condition of bombs on grid1
    # and do the explodation in grid2. After the explose we will copy the grid2 to grid1
    # to start again from the grid1.
    
 
    # print the first state of the grid
    li $v0, 4		# load v0 with 4 to print string.
    la $a0, first_s	# load a0 with the adress of the string we want to print.
    syscall		# execute syscall.
    
    la $a0, grid1  # passing grid1 as argument for printGrid function.
    jal printGrid # call the printArray function.
    
################################## WHILE LOOP ###################################

    la $a0, grid1 # loading address of grid1 to $a0
    la $a1, grid2 # loading address of grid2 to $a1
    
    # Initialize counter to 1
    li $s6, 1  # counter = s6. Counter is second counter, it starts from 1.
    # because we handled the first second.
    
    # Load the value of 'seconds' into $s7
    lw $s7, seconds
    
loop:
    lw $s7, seconds # load seconds word to $s7 register again.
    # Check if counter ($s6) is less than 'seconds' ($s7), result is stored in $t2
    slt $t2, $s6, $s7
    # If counter is not less than 'seconds', jump to end_loop
    beq $t2, $zero, end_loop

    # Call the bomberMan function which fills the empty spaces with bombs.
    # fill the grid2's empty spaces with bombs.
    la $a0, grid2  # load $a0 with the address of the grid2 to fill it with bombs.
    lw $a1, row    # load $a1 with the row size.
    lw $a2, column # load $a2 with the column size.
    jal bomberMan
	

    ## Print "%d. second:\n"
    # Print %d => %d is counter + 1
    addi $t0, $s6, 1  # to represent counter + 1
    move $a0, $t0     # move the counter+1 to a0
    li $v0, 1	      # load v0 with 1 to print integer.
    syscall	      # execute syscall
    # Print ". second:\n"
    la $a0, str_second  # load the address of str_second to $a0 to print
    li $v0, 4		# load v0 with 4 to print string.
    syscall		# execute syscall.
    
    
    # Call printGrid to print the grid
    la $a0, grid2 # set grid2 as argument to print.
    jal printGrid 
    
    # Increment counter
    addiu $s6, $s6, 1
    

    # Check if counter is equal to 'seconds'
    lw $t1, seconds
    # If counter is equal to 'seconds', jump to end_loop
    beq $s6, $t1, end_loop


    move $t5, $s6 # store the counter in $t5 not to lose it in explodeBombs
    # Call the explodeBombs function
    la $a0, grid1
    la $a1, grid2
    lw $a2, row
    lw $a3, column
    jal explodeBombs
    move $s6, $t5

    ## Print "%d. second:\n"
    # Print %d => %d is counter + 1
    addi $t0, $s6, 1  # to represent counter + 1
    move $a0, $t0  # move the counter to a0
    li $v0, 1	   # load v0 with 1 to print integer.
    syscall	   # execute syscall
    
    # Print ". second:\n"
    la $a0, str_second  # load the address of str_second to $a0 to print
    li $v0, 4		# load v0 with 4 to print string.
    syscall		# execute syscall.
    
    
    # Call printGrid to print the grid
    la $a0, grid2  # to print the grid2
    jal printGrid
    # Increment counter
    addiu $s6, $s6, 1

    # Call copyGrid to copy grid2 to grid
    # set grid2 as source and grid1 as destination as arguments.
    la $a0, grid2  # load the adress of grid2 to $a0 as a parameter.
    la $a1, grid1  # load the adress of grid1 to $a1 as a parameter.
    jal copyGrid

    # Jump back to the start of the loop
    j loop

end_loop:
    # End of the loop
    
    
    j exit
    
################## FUNCTIONS ####################
	
copyGrid: # subroutine copyGrid which copies arrays grid1 to grid2
    # arguments: $a0 => source grid, $a1 => destination grid.
    # Load addresses of grid and grid2 into $a0 and $a1 to pass grids as arguments.
    # before calling the function.
    
    move $s0, $a0 # move the adress of the source grid to $s0
    move $s1, $a1 # move the adress of the destination grid to $s1

    # Load row and column into $t0 and $t1
    lw $t0, row
    lw $t1, column

    # Calculate total number of elements and store in $t2
    mul $t2, $t0, $t1

copy_loop:             # Start of copy loop
    beq $t2, $zero, end_copy_loop  # If total number of elements is zero, end loop

    # Load byte from source array and store in destination array
    lb $t3, 0($s0)      # Load byte from source array
    sb $t3, 0($s1)      # Store byte in destination array

    # Increment array addresses and decrement total number of elements
    addiu $s0, $s0, 1   # increment the adress of grid1 1.
    addiu $s1, $s1, 1	# increment the adress of grid2 1.
    addiu $t2, $t2, -1  # decrease the total number of elements left to copy 1.

    j copy_loop         # Jump to start of loop

end_copy_loop:         # End of copy loop
    jr $ra              # Return from subroutine
	
printGrid:	# print the grid with . and O
    # arguments: $a0 => grid to print.	
    
    # Load address of grid into $a0 as parameter before calling this functions.
    move $s0, $a0  # move the address of the grid to $s0
    
    
    # Print the string "Grid: \n"
    la $a0, str_grid      # Load address of string into $a0
    li $v0, 4             # Load immediate value 4 into $v0 for print_string syscall
    syscall               # Execute syscall

    # Load row and column into $t0 and $t1
    lw $t0, row
    lw $t1, column

    # Calculate total number of elements and store in $t2
    mul $t2, $t0, $t1


print_loop:             # Start of print loop
    beq $t2, $zero, end_print_loop  # If total number of elements is zero, end loop

    # Load byte from grid and print it
    lb $t3, 0($s0)       # Load byte from grid
    move $a0, $t3        # Move byte into $a0
    li $v0, 11           # Load immediate value 11 into $v0 for print_character syscall
    syscall              # Execute syscall

    # Increment address of current grid element
    addiu $s0, $s0, 1

    # Decrement total number of elements
    addiu $t2, $t2, -1

    # If end of row, print newline
    rem $t4, $t2, $t1    # Calculate remainder of total number of elements divided by column size
    beq $t4, $zero, print_newline2
    j print_loop         # Jump to start of loop


print_newline2:
    li $v0, 11           # Load immediate value 11 into $v0 for print_character syscall
    li $a0, '\n'         # Load ASCII value of newline into $a0
    syscall              # Execute syscall
    j print_loop         # Jump back to start of loop      # Jump back to start of loop

end_print_loop:         # End of print loop
    jr $ra               # Return from subroutine


# Assuming that the base address of grid is in $a0,
# and the values of row and column are in $a1 and $a2 respectively.
bomberMan:

    # Calculate total number of cells in the grid
    mul $t0, $a1, $a2  # t0 => row * column

    # Initialize index to 0
    move $t1, $zero    # t1 = index = 0

loop_bomberMan:
    # Check if index < total number of cells
    slt $t2, $t1, $t0                   # if t1 is less than t0 set t2 = 1 else set t2 = 0
    beq $t2, $zero, end_loop_bomberMan  # if index == row*column end the loop.

    # Load byte from grid
    add $t3, $a0, $t1		# increment the grid's adress for $t1 amount and set it to $t3
    lb $t4, 0($t3)		# $t4 = grid[$t1]

    # Check if byte is '.'
    li $t5, '.'                # load $t5 with "." to compare it with grid[$t1] == $t4
    bne $t4, $t5, skip_fill    # compare if the grid1[$t1] has bomb or empty. If has bomb skip fill.

    # Fill cell in grid with 'O'
    li $t5, 'O'		# load $t5 with 'O' to fill
    sb $t5, 0($t3)	# implement the filling on grind

skip_fill:
    # Increment index
    addiu $t1, $t1, 1
    j loop_bomberMan  # jump to the loop and start again.

end_loop_bomberMan:
    jr $ra	      # go to where the function called.
	

explodeBombs:
    # arguments: $a0 = grid1, $a1 = grid2, $a2 = row, $a3 = column

    # Calculate total number of cells in the grid
    mul $t0, $a2, $a3  # t0 => row * column

    # Initialize index to 0
    move $t1, $zero    # t1 = index = 0

loop_explodeBombs:
    # Check if index < total number of cells
    slt $t2, $t1, $t0
    beq $t2, $zero, end_loop_explodeBombs   # if index >== total number of cells end the loop.

    # Load byte from grid1
    add $t3, $a0, $t1  # $t3 = address of grid1[index]
    lb $t4, 0($t3)     # $t4 = grid1[index]

    # Check if byte is 'O'
    li $t3, 'O' ## t5 was here. t5 -> t3 then the bug fixed. # load $t3 with 'O'
    bne $t4, $t3, skip_explode  # if grid1[index] == 'O' => explode the bomb. else skip.

    # Explode bomb in grid2
    add $t6, $a1, $t1	# $t6 = address of grid2[t1]
    li $t7, '.'		# load $t7 with "." which will be replaced with "O".
    sb $t7, 0($t6)	# grid2[$t1] = "."

    # Calculate i and js
    div $t1, $a3 # to track the row and column of the grid.
    mflo $t8     # i = index / column => current row of the grid
    mfhi $t9     # j = index % column => current column of the grid.

    # Explode bomb in grid2[index - column] if i > 0
    bgtz $t8, explode_up # if current row is bigger than 0
    j skip_up		 # if current row is 0 that means there is up.
explode_up:
    sub $s0, $t1, $a3	 # $s0 = index - current_row
    add $s1, $a1, $s0   # $s1 = address of grid2[$s0]
    sb $t7, 0($s1)	# grid2[$s0] = "."
skip_up:
    # Explode bomb in grid2[index - 1] if j > 0
    bgtz $t9, explode_left # if current column > 0. explode left.
    j skip_left		   # if current_column <= 0. skip left.
explode_left:
    sub $s2, $t1, 1	   # $s2 = index - 1
    add $s3, $a1, $s2	   # $s3 = address of grid2[$s2]
    sb $t7, 0($s3)	   # grid2[$s2] = "."
skip_left:
    # This label is used to skip the code for exploding bomb in grid2[index - 1]
    # if the current column is less than or equal to 0.
    
    slt $s4, $t8, $a2		# Check if current row is less than row - 1
    beq $s4, $zero, skip_down  # If not, skip the explosion in the down direction
    add $s5, $t1, $a3	       # Calculate the index of grid2[index + column]
    add $s6, $a1, $s5	       # Calculate the address of grid2[index + column]
    sb $t7, 0($s6)	       # Set grid2[index + column] to '.'
skip_down:
    # This label is used to skip the code for exploding bomb in grid2[index + column]
    # if the current row is greater than or equal to row - 1.
    
    # Explode bomb in grid2[index + 1] if j < column - 1
    slt $s4, $t9, $a3 		 # Check if current column is less than column - 1
    beq $s4, $zero, skip_right  # If not, skip the explosion in the right direction
    add $s5, $t1, 1		 # Calculate the index of grid2[index + 1]
    add $s6, $a1, $s5		# Calculate the address of grid2[index + 1]
    sb $t7, 0($s6)		# Set grid2[index + 1] to '.'
skip_right:

skip_explode:
    # Increment index
    addiu $t1, $t1, 1
    j loop_explodeBombs  # jump to the loop and start again.

end_loop_explodeBombs:
    jr $ra

########################### END OF FUNCTIONS #########################

exit:
    li $v0, 10
