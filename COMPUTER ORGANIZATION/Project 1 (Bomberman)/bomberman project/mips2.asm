.text
.globl main

main:
    # Print prompt for grid
    la $a0, prompt
    li $v0, 4
    syscall

    # Read grid from user
    la $t3, grid  # t3 = address of grid
    li $s0, 16  # s0 = row
    li $s1, 16  # s1 = column
    mul $t0, $s0, $s1  # t0 = row * column
    move $t1, $zero  # t1 = index = 0
loop_read_grid:
    slt $t2, $t1, $t0
    beq $t2, $zero, end_loop_read_grid
    move $a0, $t3  # buffer
    li $a1, 2  # length = 2 (for character and newline)
    li $v0, 8
    syscall
    add $t3, $t3, $a1
    addiu $t1, $t1, 1
    j loop_read_grid

end_loop_read_grid:
    jr $ra

.data
prompt: .asciiz "Enter the grid: \n"
grid:   .space 256  # 16 * 16