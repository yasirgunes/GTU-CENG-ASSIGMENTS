.data



#registerlar ne için kullanılıyor?:
	#s0 : row değerini tutmak için(kalıcı)
	#s1 : column değeri kalıcı
	#s2 : n değeri kalıcı
	#s3: row*column yani grid_size'ı tutmak için kalıcı



Take_row: .asciiz "\nEnter the number of row: "
Take_column: .asciiz "\nEnter the number of column: "
Take_n: .asciiz "\nEnter the number of n: "
Take_initial_grid: .asciiz "\nEnter the initial grid: "


Printing_read_values: .asciiz "\nPrinting read values: "
Printing_size: .asciiz "\nPrinting size: "
Error_control: .asciiz "\nPASSED\n: "
Error_control2: .asciiz "\nKONTROL2\n: "
Error_control3: .asciiz "\nKONTROL3\n: "
Error_control4: .asciiz "\nKONTROL4\n: "
Error_control5: .asciiz "\nKONTROL5\n: "


grid: .space 4000
temp_grid: .space 4000  
#grid için 4000 byte'lık(200*200) alan ayırdık

	.text	

	j Main

print_grid: 
	
	#Bu fonksiyon çağrılmadan önce t0'a bastırılmak istenen grid'in adresi verilir.
	#la $t0, grid # Load the base address of grid into $t0 (BU PARAMETRE OLDU)
	li $t1, 0   # Initialize i to 0

    	loop_in_print_grid:
    		
    	    	 bge $t1, $s3, end_print_grid_loop
    	    	 
    	    	 #if(i % column == 0)
    	    	 div $t1, $s1      # Divide $s0 by $s1. Divide i by column
		 mfhi $t2          # Get the remainder (modulus) from the hi register
		 beq $t2, 0, new_line
    	    	 after_new_line:
    	    	 lb $a0, 0($t0)    # Load character from grid[i] into $a0
    	    	 li $v0, 11        # karakter bastırmak için kod 11
    	    	 syscall                   
    	    	 addi $t0, $t0, 1    # Move to the next element in grid
    	    	 addi $t1, $t1, 1    # Increment i
    	    	 j loop_in_print_grid
    	    	 
    	    	 
    	new_line:
      		li $v0, 11      # karakter okumak için kod 11
    		li $a0, '\n'    # Load ASCII value for newline character
    		syscall
    		j after_new_line   		    	 
    	    	 
    	end_print_grid_loop:
    			la $a0, Error_control
			li $v0, 4   #Burada li yerine la yazınca da çalıştı.
			syscall
    		
    		jr $ra   #jal ile tek print_grid'i çağırmıştım. O yüzden print_grid'i çağırdığım yere geri dönmesini umut ediyorum
    		#j come_here

   			
				







Copy_grid_to_temp_grid:

	la $t0, grid # Load the base address of grid into $t0
	li $t1, 0   # Initialize i to 0
	la $t2, temp_grid # Load the base address of temp_grid into $t2
	
	loop_in_copy:
		bge $t1, $s3, end_copy_loop	
		lb $a0, 0($t0)    # Load character from grid[i] into $a0
		sb $a0, 0($t2) # Store the value in a0 to the byte at the calculated address
		addi $t0, $t0, 1    # Move to the next element in grid
		addi $t2, $t2, 1    # Move to the next element in grid
		addi $t1, $t1, 1    # Increment i
		j loop_in_copy
		
		
		
		end_copy_loop:
			jr $ra






																																
Plant_bombs:

	la $t0, grid # Load the base address of grid into $t0
	li $t1, 0   # Initialize i to 0
	
	loop_in_plant_bombs:
		
		bge $t1, $s3, end_plant_bombs_loop
		lb $a0, 0($t0)    # Load character from grid[i] into $a0
		li $t2, 46          # Load the ASCII value of dot (.) into a temporary register
		beq $a0, $t2, equal_dot   # If $a0 is equal to the ASCII value of dot, branch to equal_dot
		# If not, continue executing the instructions here
		addi $t0, $t0, 1    # Move to the next element in grid
		addi $t1, $t1, 1    # Increment i
		j loop_in_plant_bombs

		equal_dot:
			li $t2, 79  # Load the ASCII value of 'O' into $t1
			sb $t2, 0($t0) # Store the ASCII value of 'O' in the byte at the calculated address
			addi $t0, $t0, 1    # Move to the next element in grid
			addi $t1, $t1, 1    # Increment i
			j loop_in_plant_bombs



		end_plant_bombs_loop:
			jr $ra
				
					

						
												
																		
																								
																														
Detonate_bombs:																																								
		
	la $t0, grid # Load the base address of grid into $t0
	li $t1, 0   # Initialize i to 0
	la $t2, temp_grid # Load the base address of temp_grid into $t2
	
	loop_in_detonate_bombs:
		bge $t1, $s3, end_detoante_bombs_loop  #t1, s3'e eşit ya da büyük ise yani !(i<size) ise end_detoante_bombs_loop label'ına gidilir
		lb $a1, 0($t0)    # Load character from grid[i] into $a1
		lb $a2, 0($t2)    # Load character from temp_grid[i] into $a2
		li $t3, 79          # Load the ASCII value of (O) into a temporary register	
		li $t4, 46          # Load the ASCII value of dot(.) into a temporary register
		li $t7, 65          # Load the ASCII value of A into a temporary register SİLİNECEK
		
		beq $a2, $t3, equal_O   # If $a2 is equal to the ASCII value of 'O', branch to equal_O   if(temp_grid[i] == 'O')
		back_from_label_1:
		
		#to perform: if((i+1) % column != 0){ grid[i+1] = '.'; }
		addi $t5, $t1, 1    # i+1 Increment i and save it in t5
		div $t5, $s1      # Divide $t5 by $t1
		mfhi $t6          # Get the remainder (modulus) from the hi register. (i+1) % column
		bne $t6, $zero, label_2    #  if((i+1) % column != 0) # i satırın sonunda değilse label_2'ye geç
		back_from_label2:
		
		#to perform if(i < size-column){ grid[i+column] = '.'; }
		sub $t5, $s3, $s1  # size-column Subtract the value in $s1 from $s3 and store the result in $t5
		bge $t1, $t5, label_3  #t1, t5'e eşit ya da büyük ise yani !(i<size-column) ise label_3 label'ına gidilir
		back_from_label3:
		
		
		#t0,t1,t2 arttırılmalı ve döngünün başına dönmeli
		addi $t0, $t0, 1    # Move to the next element in grid
		addi $t2, $t2, 1    # Move to the next element in temp_grid
		addi $t1, $t1, 1    # Increment i
		j loop_in_detonate_bombs
		
		equal_O:
			
			sb $t4, 0($t0)  #  grid[i] = '.'; Store the ASCII value of dot in the byte at the calculated address 
			
			#to perform: if((i+1) % column != 0){ grid[i+1] = '.'; }
			addi $t5, $t1, 1    # i+1 Increment i and save it in t5
			div $t5, $s1      # Divide $t0 by $t1
			mfhi $t6          # Get the remainder (modulus) from the hi register. (i+1) % column
			bne $t6, $zero, label_1_1    #  if((i+1) % column != 0)
			back_from_label_1_1:
			
			#to perform if(i < size-column){ grid[i+column] = '.'; }
			sub $t5, $s3, $s1  # size-column Subtract the value in $s1 from $s3 and store the result in $t5
			bge $t5, $t1, label_1_2  #t1, t5'e eşit ya da büyük ise yani !(i<size-column) ise label_1_2 label'ına gidilir
			back_from_label_1_2:
			j back_from_label_1
			
			
			
			label_1_1:
				sb $t4, 1($t0)  #  grid[i+1] = '.'; Store the ASCII value of dot in the byte at the calculated address 
				j back_from_label_1_1
				
			label_1_2:
				la $a0, Error_control2
				li $v0, 4 
				syscall
				
				add $t5, $t1, $s1 # i+column
				add $t6, $t0, $t5  # grid[i+column]  Calculate the effective address by adding the base address and the offset
				sb $t7, 0($t6)     # grid[i+column] = '.' Store the byte from $t4 at the calculated effective address
				j back_from_label_1_2

		
		label_2:
			#if(temp_grid[i+1] == 'O'){ grid[i] = '.'; }
			#temp_grid'in şu anki adresinin 1 fazlasına gitmeli oradaki elemanı okumalı.
			lb $t5, 1($t2)  #temp_grid[i+1] #temp_grid'in şu  anki adresinin 1 byte fazlasında bulunan karakteri okuduk.
			beq $t5, $t3, label_2_1   # If $t5 is equal to the ASCII value of 'O', branch to equal_O   if(temp_grid[i] == 'O')
			back_from_label_2_1:
			j back_from_label2
			
				
			label_2_1:
				sb $t4, 0($t0)  #  grid[i+1] = '.'; Store the ASCII value of dot in the byte at the calculated address 	
				j back_from_label_2_1
			
			
		
		label_3:
			la $a0, Error_control3
			li $v0, 4 
			syscall
			#to perform if(temp_grid[i+column] == 'O'){ grid[i] = '.'; }
			add $t5, $t1, $s1 # i+column
			add $t6, $t2, $t5  # temp_grid[i+column]'in adresini t6'ya koyduk  Calculate the effective address by adding the base address and the offset
			lb $t5, 0($t6)  #temp_grid[i+1]'deki değeri t5'e koyduk
			beq $t5, $t3, label_3_1 #t5 t3'e eşitse label_3_1'e git. t3'te 'O' tutuluyor.
			back_from_label_3_1:
			j back_from_label3
			
			label_3_1:
				la $a0, Error_control4
				li $v0, 4 
				syscall
				sb $t4, 0($t0)  #  grid[i+1] = '.'; Store the ASCII value of dot in the byte at the calculated address 
				j back_from_label_3_1
			
		
		
		
		end_detoante_bombs_loop	:
			jr $ra
		
		







								
										
	#Take_row ekrana bastırılıyor
Main:	la $a0, Take_row 
	li $v0, 4 
	syscall
	
	# inputu alınıyor ve s0'a konuluyor
	li $v0, 5
	syscall
	move $s0, $v0
	
	
	#Take_column ekrana bastırılıyor
	la $a0, Take_column
	li $v0, 4 
	syscall
	
	#column inputu alınıyor ve s1'a konuluyor
	li $v0, 5
	syscall
	move $s1, $v0
	
	#Take_n ekrana bastırılıyor.
	la $a0, Take_n
	li $v0, 4 
	syscall
	
	#n inputu alınıyor ve s2'ye konuluyor
	li $v0, 5
	syscall
	move $s2, $v0
	
	#okunan değerler doğru okunmuş mu diye bi ekrana basalım
	la $a0, Printing_read_values
	li $v0, 4 
	syscall	
	
  	move $a0, $s0
  	li $v0, 1 
    	syscall
    	
  	move $a0, $s1
  	li $v0, 1 
    	syscall
    	
  	move $a0, $s2
  	li $v0, 1 
    	syscall
    	#Row, column ve n doğru okunmuş    
    	
    		
    	#Şimdi row ve column'u çarpıp bu değeri s3'e koyacağız. Böylece grid_size elimizde olacak
    	#r ve c değeri 200'den küçük olduğu için mfhi'yi dikkate almaya gerek yok. 
    	mult $s0, $s1	
    	mflo $s3
    	
    	#çarpım doğru oldu mu diye ölçelim:
	la $a0, Printing_size
	li $v0, 4 
	syscall	
	
  	move $a0, $s3
  	li $v0, 1 
    	syscall    
    	#çarpım doğru	
    	
    	
    	#Ekrana "Enter the initial grid:" bastıracağım
	la $a0, Take_initial_grid
	li $v0, 4 
	syscall	    	
    	
    	#kullanıcıdan initial grid'i tek satır halinde alalım
	la $a0, grid   #okuma için input buffer'ın adresini a0'a gireriz. 
	addi $t0, $s3, 2    #Direkt move a1, s3 desek örneğin s3'teki değer 20 olduğu için, sistem 19 ve 20. elemanı kendisi kullanır /0 koymak için. Eğer 20 karakter okumak istiyorsak +2 fazladan alan vermeliyiz.
	move $a1, $t0  #maximum number of characters to read değerini de a1'e gireriz
	li $v0, 8
	syscall
	
	
	#Stringi Buffer'a koyabildik	
	#Okuduğumuz şeyi print edelim tek satır halinde
	la $a0, grid 
	li $v0, 4 
	syscall    	
	
	#Şimdi print_grid fonksiyonuna gönderelim
	la $t0, grid # Load the base address of grid into $t0
	jal print_grid
	
	jal Copy_grid_to_temp_grid
	
	
	jal Plant_bombs
	
	la $t0, grid # Load the base address of grid into $t0
	jal print_grid
	
	jal Detonate_bombs
	
	la $t0, grid # Load the base address of grid into $t0
	jal print_grid
	
	#la $t0, temp_grid # Load the base address of temp_grid into $t0
	#jal print_grid