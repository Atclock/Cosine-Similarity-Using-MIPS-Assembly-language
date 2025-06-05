.data #Data used in the project
msg_welcome:    .asciiz "\nWelcome to MIPS Assembly using MARS Simulator\nAn assembly program to compute the cosine similarity between two variables\nWritten by: Yousef AbuZanoneh; 20231502036\n"
msg_size:       .asciiz "Enter the size of the vectors (between 5 and 10): "
msg_invalid:    .asciiz "Invalid size! Please enter a number between 5 and 10.\n"
msg_inputA:     .asciiz "Enter element of vector a: "
msg_inputB:     .asciiz "Enter element of vector b: "
msg_result:     .asciiz "The Cosine Similarity between vector a and b is: "
newline:        .asciiz "\n"

.align 2
vector_a:       .space 64            # Space for vector a
vector_b:       .space 64            # Space for vector b
result:         .float 0.0           # Space to store the result

.text
.globl main

main:
    # Prints the welcome message
    li $v0, 4
    la $a0, msg_welcome
    syscall

ask_size:
    # Asks the user to enter the size of both vectors
    li $v0, 4
    la $a0, msg_size
    syscall

    # Reads an integer input here
    li $v0, 5
    syscall
    move $s0, $v0                

    # Checks if the size is valid
    li $t5, 5
    li $t6, 10
    blt $s0, $t5, invalid_size
    bgt $s0, $t6, invalid_size

input_a:
    li $t5, 0                    # Counter

input_loop_a:
    beq $t5, $s0, input_b        # Loop condition -> counter == size

    li $v0, 4
    la $a0, msg_inputA
    syscall

    li $v0, 6                    # Reads float input
    syscall

    li $t6, 4
    mul $t6, $t5, $t6            # Calculate byte offset
    la $t7, vector_a
    add $t6, $t6, $t7
    s.s $f0, 0($t6)              # Store input in vector a

    addi $t5, $t5, 1
    j input_loop_a

input_b:
    li $t5, 0                    # Counter

input_loop_b:
    beq $t5, $s0, compute_cosine # Loop condition -> counter == size

    li $v0, 4
    la $a0, msg_inputB
    syscall

    li $v0, 6                   # Reads float input
    syscall

    li $t6, 4
    mul $t6, $t5, $t6           # Reads float input
    la $t7, vector_b
    add $t6, $t6, $t7
    s.s $f0, 0($t6)             # Stores input in vector b

    addi $t5, $t5, 1
    j input_loop_b

compute_cosine:
    # Calls CosineSimilarity with vector_a, vector_b, size
    la $a0, vector_a
    la $a1, vector_b
    move $a2, $s0
    jal CosineSimilarity

    # Stores the result after the call
    la $t5, result
    s.s $f30, 0($t5)

    # Prints result message
    li $v0, 4
    la $a0, msg_result
    syscall

    # Prints float result
    mov.s $f12, $f30
    li $v0, 2
    syscall

    li $v0, 4
    la $a0, newline
    syscall

    li $v0, 10                   # Exits here
    syscall

invalid_size:
    # This part is to handle any invalid size
    li $v0, 4
    la $a0, msg_invalid
    syscall
    j ask_size


# DotProduct Procedure
# Inputs: $a0 = address of vector a, $a1 = address of vector b, $s0 = size
# Output: $f30 = dot product result
DotProduct:
    addi $sp, $sp, -12
    sw $ra, 0($sp)
    sw $s1, 4($sp)
    sw $s0, 8($sp)

    li $t5, 0                   # Loop counter
    mtc1 $zero, $f30           # Initializes the result to 0.0

dp_loop:
    beq $t5, $s0, dp_end

    li $t6, 4
    mul $t6, $t5, $t6

    add $t7, $a0, $t6
    l.s $f10, 0($t7)            # Loads vector a element

    add $t8, $a1, $t6
    l.s $f20, 0($t8)            # Loads vector b element

    mul.s $f10, $f10, $f20
    add.s $f30, $f30, $f10      # accumulate product

    addi $t5, $t5, 1
    j dp_loop

dp_end:
    lw $s0, 8($sp)
    lw $ra, 0($sp)
    lw $s1, 4($sp)
    addi $sp, $sp, 12
    jr $ra


# EuclideanNorm Procedure
# Input: $a0 = address of vector, $s0 = size
# Output: $f30 = norm result
EuclideanNorm:
    addi $sp, $sp, -12
    sw $ra, 0($sp)
    sw $s1, 4($sp)
    sw $s0, 8($sp)

    li $t5, 0
    mtc1 $zero, $f30           # Initializes sum to 0.0

norm_loop:
    beq $t5, $s0, norm_end

    li $t6, 4
    mul $t6, $t5, $t6
    add $t7, $a0, $t6
    l.s $f10, 0($t7)

    mul.s $f10, $f10, $f10     # Square
    add.s $f30, $f30, $f10     # Accumulate

    addi $t5, $t5, 1
    j norm_loop

norm_end:
    sqrt.s $f30, $f30          # Square root of the result

    lw $s0, 8($sp)
    lw $ra, 0($sp)
    lw $s1, 4($sp)
    addi $sp, $sp, 12
    jr $ra

# CosineSimilarity Procedure
# Inputs: $a0 = vector a, $a1 = vector b, $a2 = size
# Output: $f30 = cosine similarity result
CosineSimilarity:
    addi $sp, $sp, -16
    sw $ra, 0($sp)
    sw $a0, 4($sp)
    sw $a1, 8($sp)
    sw $a2, 12($sp)

    move $s0, $a2              # Copies the size

    # Computes dot product
    jal DotProduct
    mov.s $f12, $f30           # Stores dot product

    # Computes the norm of vector a
    lw $a0, 4($sp)
    jal EuclideanNorm
    mov.s $f14, $f30

    # Computes the norm of vector b
    lw $a0, 8($sp)
    jal EuclideanNorm
    mov.s $f16, $f30

    # Multiplies norms
    mul.s $f18, $f14, $f16

    # Checks for division by zero
    li $t5, 0
    mtc1 $t5, $f20
    c.eq.s $f18, $f20
    bc1t div_by_zero

    # Computes cosine similarity
    div.s $f30, $f12, $f18
    j cos_end

div_by_zero:
    mtc1 $zero, $f30           # Sets the result to 0.0 if divide by zero was true

cos_end:
    lw $ra, 0($sp)
    lw $a0, 4($sp)
    lw $a1, 8($sp)
    lw $a2, 12($sp)
    addi $sp, $sp, 16
    jr $ra