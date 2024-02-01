#int main() {
#  int a, b, selection;

#  printf("Please enter a number\n");
#  scanf("%d", &a);

#  printf("Please enter a number\n");
#  scanf("%d", &b);

#  printf("Please enter I for addition, 2 for sub, 3 for bitwise-and, 4 for bitwise-or, 5 for exit\n");
#  scanf("%d", &selection);

#  if (selection == 1) {
#    addition(a, b);
#  } else if (selection == 2) {
#    subtract(a, b);
#  } else if (selection == 3) {
#    bitwise_and(a, b);
#  } else if (selection == 4) {
#    bitwise_or(a, b);
#  } else {
#    exit(0);
#  }
	.data
a:		.space 1
b:		.space 1
selection: 	.space 1
result:		.space 2
ask_for_number:	.asciiz  "Please enter a number\n"
menu_str:	.asciiz	 "Please enter 1 for addition, 2 for substraction, 3 for bitwise-and, 4 for bitwise-or, 5 for exit\n"
result_str:		.asciiz "the result is: "
		
		.text
	# print the asking for number
	li $v0, 4
	la $a0, ask_for_number
	syscall
	
	# read int a from user
	li $v0, 5
	syscall
	move $s0, $v0 # s0 = a
	
	# print the asking for number
	li $v0, 4
	la $a0, ask_for_number
	syscall
	
	# read int b from user
	li $v0, 5
	syscall
	move $s1, $v0 # s1 = b
	
	# print menu
	li $v0, 4
	la $a0, menu_str
	syscall
	
	# read selection int from user
	li $v0, 5
	syscall
	move $s2, $v0 # s2 = selection
	
	
	# compare the selection and branch to that part.
	beq $s2, 1, addition
	beq $s2, 2, substraction
	beq $s2, 3, bitwise_and
	beq $s2, 4, bitwise_or
	beq $s2, 5, exit
	li $v0, 10
addition:
	add $s3, $s1, $s0 # make the operation
	jal fun  # jal = jump and link => jumps to fun and goes back here to continue.
	j exit
substraction:
	sub $s3, $s0, $s1
	jal fun
	j exit
bitwise_and:
	and $s3, $s1, $s0
	j exit
bitwise_or:
	or $s3, $s1, $s0
	j exit
fun:
	li $v0, 4
	la $a0, result_str
	syscall
	li $v0, 1
	move $a0, $s3
	syscall 
	jr $ra
exit:
	
	
	
	
	
	
	
	
	