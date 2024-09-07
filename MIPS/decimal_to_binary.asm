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
    bltz $t0, print_error   # Jump to error if negative

    # If number is zero, print 0 directly
    beqz $t0, print_zero

    li $t1, 0           	    # Initialize $t1 to 0 (index for binary array)

convert:
    beqz $t0, print          # If $t0 is zero, we are done
    rem $t2, $t0, 2          # $t2 = $t0 % 2
    sb $t2, binary($t1)      # Store the bit in binary[$t1]
    addi $t1, $t1, 1         # Increment index
    srl $t0, $t0, 1          # $t0 = $t0 >> 1 (divide by 2)
    j convert                # Repeat the conversion

print:
    # Display prompt2
    li $v0, 4
    la $a0, prompt2
    syscall

    # Print the binary number
    addi $t1, $t1, -1        # Set $t1 to last index (one less)
    
printLoop:
    bltz $t1, exit_main      # Exit if $t1 is negative
    lb $t2, binary($t1)      # Load the bit
    addi $t1, $t1, -1        # Decrement index

    # Convert binary bit to ASCII '0' or '1'
    addi $t2, $t2, 48        # 48 is ASCII code for '0'
    move $a0, $t2
    li $v0, 11               # Syscall for printing a character
    syscall

    j printLoop              # Repeat

print_zero:
    # Special case to print '0' for input 0
    li $v0, 4
    la $a0, prompt2
    syscall

    li $a0, '0'
    li $v0, 11
    syscall

    j exit_main

print_error:
    # Display error message
    li $v0, 4
    la $a0, errorMsg
    syscall

exit_main:
    li $v0, 10
    syscall
