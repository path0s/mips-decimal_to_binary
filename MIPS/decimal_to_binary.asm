.data
    prompt1: .asciiz "Enter a positive decimal number--> "
    prompt2: .asciiz "The binary number is--> "
    errorMsg: .asciiz "Error! Enter a positive decimal number!"

    num:    .word   0
    binary: .space  32     # Space to store binary bits

.text
.globl main
main:
	# Display prompt1
    	li $v0, 4
    	la $a0, prompt1
    	syscall

    	# Read an integer
    	li $v0, 5
    	syscall
    	move $t0, $v0       # Copy the entered number to $t0

    	# Check if the number is positive (greater than or equal to zero)
    	bgez $t0, convert
    	# (Else) Display an error message if the number is negative
    	li $v0, 4
    	la $a0, errorMsg
    	syscall

    	j exit_main         # Jump to program exit

exit_main:
    	li $v0, 10
    	syscall

convert:
    	li $t1, 0           	    # Initialize $t1 to 0 (index for binary array)

	loop:
    		beqz $t0, print     # Jump to print if $t0 is zero
    		# (Else)
    		rem $t2, $t0, 2     # $t2 = $t0 % 2 (calculate remainder of division by 2)
    		sb $t2, binary($t1) # Store the binary bit in binary[$t1]

    		addi $t1, $t1, 1    # Increment the array index
    		srl $t0, $t0, 1     # Shift right logical: $t0 = $t0 >> 1 (divisione intera per 2)

    		j loop              # Jump back to loop

	print:
    		# Display prompt2
    		li $v0, 4
    		la $a0, prompt2
    		syscall

    		j printLoop

		printLoop:
    			bgez $t1, printBit  # Jump to printBit if $t1 is non-negative
    			
    			j exit_main         # Jump to program exit

		printBit:
    			lb $t2, binary($t1) # Load the binary bit from binary[$t1]
    			addi $t1, $t1, -1   # Decrement the array index

    			move $a0, $t2       # Load the bit to print
    			li $v0, 1           # Set the syscall code for printing an integer
    			syscall             # Execute the syscall

    			j printLoop         # Jump back to printLoop

