# Cosine-Similarity-Using-MIPS-Assembly-language
Course name: Computer Architecture and Organization CE201 </br>
Dr. Mahmoud Alsarayreh</br>
Yousef Talat AbuZanoneh 20231502036</br>
Submission date</br>
German Jordanian University</br>


## Objective
The objective of this assignment is to develop a MIPS assembly program that calculates the cosine similarity between two vectors, the user specifies the size of the vectors (between 5 and 10) and inputs each element then the program computes the cosine similarity by calling three modular procedures, the dot product, the Euclidean norm, and the cosine similarity modular.
## Theory
This section presents the theoretical part to understand the design and implementation of the cosine similarity program.
### __MIPS Instructions Set and SImulation Tools__
MIPS is a reduced Instruction Set Computer architecture, each instruction is a 32-bit word and generally follows three formats: R-type, I-type and J-type. </br>
For this assignment, I used MARS simulator, an IDE that supports MIPS assembly coding, MIPS floating-point instructions were implemented too for mathematical usage.
### __Vector Mathematics and Cosine Similarity__
Vectors represent quantities that have both a magnitude and a direction, we tend to compare between those vectors, one common approach is cosine similarity measure, an approach widely used in fields such as machine learning and information retrieval. </br>
Cosine Similarity measures the cosine of the angle between two vectors. The value ranges between -1 and 1, 1 indicating maximum similarity and -1 indicating diametrically opposite vectors.
### __Mathematical Background and Formulas__
Let two vectors be
##### A=[a1,a2,…,an]                               B=[b1,b2,…,bn]
The Dot Product: </br>
![alt text](https://github.com/Atclock/Cosine-Similarity-Using-MIPS-Assembly-language/blob/main/Images/Dot%20Product%20formula.png "Dot Product Formula") </br>
The Euclidean Norm (Magnitude) of a vector is: </br>
![alt text](https://github.com/Atclock/Cosine-Similarity-Using-MIPS-Assembly-language/blob/main/Images/Euclidean%20Norm%20formula.png "Euclidean Norm Formula") </br>
The Cosine Similarity: </br>
![alt text](https://github.com/Atclock/Cosine-Similarity-Using-MIPS-Assembly-language/blob/main/Images/Cosine%20similarity.png "The Cosine Similarity") </br>
This formula captures the degree of alignment between two vectors.
### __Technical Concepts and justifications__
For Floating-point operations, MIPS uses $f registers, “.s” instructions, which are special instructions for single precision, were used to handle real number computations. </br>
Static memory addresses are used to store vector data and results. Ensuring predictable access and ease of debugging. Base addresses are stored in “$a0” (vector A) and “$a1” (vector B). 
## Design
This section is dedicated to explaining the approach and planning strategy followed to implement the cosine similarity computation in MIPS. How the theoretical section was understood and turned into testable code logic.
### __Main Module__ </br>
![alt text](https://github.com/Atclock/Cosine-Similarity-Using-MIPS-Assembly-language/blob/main/Images/Main%20Module%20diagram.png "Main Module Diagram") </br>
Basic implementation, displays welcome message then prompts the user for vector sizes, checks the validity of the size, then calls the cosine similarity module.
### __Cosine Similarity Module__ </br>
![alt text](https://github.com/Atclock/Cosine-Similarity-Using-MIPS-Assembly-language/blob/main/Images/Cosine%20similarity%20Module%20Diagram.png "Cosine Similarity Module") </br>
In this module, it calls the Dot Product and the Euclidean Norm modules, multiplies vector norm A with vector norm B and checks if the result is 0, then returns the result.
### __Dot Product Module__ </br>
![alt text](https://github.com/Atclock/Cosine-Similarity-Using-MIPS-Assembly-language/blob/main/Images/Dot%20Product%20Module%20diagram.png "Dot Product Module") </br>
This Module implements the Dot Product procedure, initialize “$f30” and counter to zero, then checks if counter is equal to vector size. If it is false, vector A and vector B are loaded from the memory then multiplied and stored in “$f10”, added to the accumulator “$f30”, finally counter is incremented and the loop is repeated until the condition is true, returning “f30” at last.
### __Euclidean Norm Module__ </br>
![alt text](https://github.com/Atclock/Cosine-Similarity-Using-MIPS-Assembly-language/blob/main/Images/Euclidean%20Norm%20Module%20Diagram.png "Euclidean Norm Module") </br>
The last Module initializes $f30 again (To ensure no data is overwritten), as well as the counter and checks if the counter is equal to the vector size, then loads vector[i] from memory, multiplies the value by itself then stores in if “$f10”, adds it to the accumulator “$f30” and increments the counter, this process is repeated until the loop is true, it takes the square root of “$f30” and returns to the same register. Lastly returns $f30 and ends. 
#
The diagrams show the exact algorithms used to implement the code, but for the cases of the study, pseudocodes were written.
### __Main Program__
1.	Print welcome message.
2.	Ask user for vector size (Stored in $s0).
3.	Initialize base memory addresses for vector A and B.
4.	Loop m times to input vector A.
5.	Loop m times to input vector B.
6.	Call cosine similarity.
7.	Stores result and prints it.
### __Cosine Similarity__
1.	Call DotProduct and returns dot.
2.	Call EuclideanNorm and return norm_a.
3.	Call EuclideanNorm and return norm_b.
4.	If norm_a * norm_b ==0, return 0.
5.	Else return Dot/(norm_a * norm_b).
### __Dot Product__
1.	Initialize dot_product.
2.	For i in 0 to size-1:
Load A[i] and B[i].
Multiply.
Accumulate into dot_product.
3.	Return dot_product.
### __Euclidean Norm__
1.	Initialize sum_of_squares.
2.	For I in 0 to size-1
Load A[i]
Multiply A[i] by itself
Accumulate
3.	Return sqrt(sum_of_squares) </br>
The table below shows the data structures used, their purpose and where they were saved in memory.

| Purpose                    | Register/Memory Used     |
|----------------------------|--------------------------|
| Vector Size                | `$s0`                    |
| Vector A Base Address      | `$a0` *                  |
| Vector B Base Address      | `$a1` *                  |
| Vector A                   | `0x10010000`             |
| Vector B                   | `0x10010040`             |
| Result Storage             | `0x10010080`             |
| Temp Registers (Integers)  | `$t5`, `$t6`             |
| Temp Registers (Floats)    | `$f10`, `$f20`           |
| Return Float Value         | `$f30`                   |
| Return Int Value           | `$v1`                    |

\*: Registers used are based on the spricifications requested, some data were later moved to different registers after debugging. </br>

I implemented the mathematical formula for the cosine similarity, mentioned in the theoretical section.
Relied on MIPS floating-point instructions for multiplication (mul.s), square root (sqrt.s) and division (div.s). Proper register usage was implemented to keep computations clean.

## Implementation
This section is dedicated to translating the design section from diagrams and pseudocodes, into a functional working code.

### __Program Structure__
I used a modular design approach, splitting each computation task into separate procedures, making the code more readable, reusable and easier to debug. </br>
The module was turned into 4 different structures: </br>

* __Main:__ Handles inputs and outputs, also calls computational procedures. </br>
* __DotProduct:__ Calculates the dot product of two vectors. </br>
* __EuclideanNorm:__ Computes the magnitude (norm) of a given vector. </br>
* __CosineSimilarity:__ Uses the other two procedures to compute cosine similarity. </br>
__Main__ begins by displaying a welcome message, then requests the user to enter the vector size. It checks if the size is valid or not, then collects elements for vectors A and B. Setting the addresses using “$a0” and “$a1” for the vectors, then calls __CosineSimilarity.__ </br>
__Dot Product__ Accepts pointers to both vectors and computes the sum of the product of each element using floating-point instructions and temp registers ($f10 and $f20), The result is returned in “$f30”. </br>
__Euclidean Norm__ takes one vector and calculates the sum of the squares of its elements, then applies a square root operation to get the final magnitude and returns it in “f30”. </br>
__Cosine Similarity__ Calls both Dot Product and Euclidean Norm twice, once for each vector, then performs a division to compute the cosine similarity. For best practices, checking for any exception is essential, so a division-by-zero check up occurs. Finally, the result is returned in $f30. </br>
### __Coding Practices__
To ensure best practices, I added Comments before major blocks or instruction sequences to explain the logic behind them. I also used registers given in the specifications, you can check them in the design section. Briefly, Temporary values were stored in memory or saved registers when needed, to preserve state between procedure calls. </br>
Lastly, I used conditional floating-point instructions like “c.eq.s” and “bc1t” for input validation, branching and error prevention.
### __Development Tools and Environment__
The code was written and tested using the MARS environment. MARS was chosen (Over online IDEs) for its support of both integer and floating-point instructions, and integrated debugging features. </br>
Development and testing were performed on Windows 10, MARS editor was primarily used, and notepad was used for writing pseudocode.
## Debugging and Test Run
This section explains how debugging and testing were made, what errors encountered me and how did I fix it. </br>
I started by splitting the code into Modules, having a modular debugging approach. This approach allows more flexibility to identify errors, especially in a language like Assembly. To make it even simpler, debugging was made into parts, each part explaining an event. </br>
Some data mentioned in the code
```assembly
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
```
### __Part 1: Welcome Message and Input Prompt__

```assembly
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

```
I printed the welcome message string using syscall, then asked the user for vector size and validated that it must be between 5 and 10. </br>
Then I tested it by entering a vector of size 5, verified the value is saved in “$s0” correctly, and confirmed “ask_size” is triggered on invalid input. </br>
Error encountered: using “li $a0, msg_welcome” instead of la, causing invalid string printing.
I checked “syscall” number and string printing, finding out the error and debugging it using “la $a0, msg_welcome” instead. </br>

### __Part 2: Memory Address Initialization__
In this part, I wanted to load base address for vectors a and b, when I ran into this error
```
Assemble: assembling D:\Yousof\downalods\mips1.asm

Assemble: operation completed successfully.

Go: running mips1.asm

Error in D:\Yousof\downloads\mips1.asm line 57: Runtime exception at 0x00400090: address out of range 0x50050004
```
I traced the bug to an incorrect base address, due to calculating the address incorrectly, also found out that “li” overwrote “$a0” causing indirect bugs later.
### __Part 3: Vector element Input__
```assembly
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

```
In this section I want to read a float input and store it in memory, using “$f0” to loaded float input and stored input in memory with calculated address using “$t5” index and offset. </br>

Error encountered: mistakenly calculated memory address again, “$t6” was misused and not multiplied correctly causing the input to be saved in a non-allocated memory region. </br>
I added print statements after computing addresses to check whether they were saved correctly or not, also rechecked multiplication with element size of “4”. </br>

### __Part 4: Dot Product Procedure__
```assembly
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
```
In this part, I calculated dot product using the formula mentioned earlier in the theoritical part using “$f10” and “$f20” for temp float registers, also using “$f30” to return the result.
No errors encountered, but as a testing example, I used the following vectors of size 5 </br>

Vector A: [1.0,2.0,3.0,4.0,5.0]                    Vector B: [5.0,4,0,3.0,2.0,1.0] </br>

The expected result must be “35.0” and as shown, the code passed the test successfully.
```
Dot Product: 35.0
-- program is finished running --
```
### __Part 5: Euclidean Norm Procedure__
```assembly
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
```
In this part, we calculate the Euclidean Norm, also using the formula mentioned in the theoretical section earlier, I didn’t encounter any bugs here, but tested the procedure by applying the formula separately, the following vector of size 5 was used to calculate the norm. </br>
Vector C: [3.0,4.0,0.0,0.0,0.0] </br>
The expected answer based on the formula is 5, and as shown, coded passed successfully.
```
Euclidean Norm: 5.0
-- program is finished running --
```
### __Part 6: Cosine Similarity Procedure__
```assembly
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
```
In this part, the cosine similarity is calculated, using the Dot product and Euclidean Norm for both vectors, applying the formula of cosine similarity mentioned earlier in the theory section, used “$f30” to return the result. </br>

Bug encountered: filling two 5 sized vectors with [1.0,1.0,1.0,1.0,1.0], the result was surprisingly 0.04 when it should be 1.0. 
```
Enter the size of the vectors (between 5 and 10): 5
Enter element of vector a: 5
Enter element of vector a: 5
Enter element of vector a: 5
Enter element of vector a: 5
Enter element of vector a: 5
Enter element of vector b: 5
Enter element of vector b: 5
Enter element of vector b: 5
Enter element of vector b: 5
Enter element of vector b: 5
The Cosine Similarity between vector a and b is: 0.040000003
```
First off I verified that the inputs were all 5, then I recomputed dot product and norms manually, found flow division was flawed, fixed by standardizing all float temp regs to only “$f10” and “f20” and reordered “mov.s” and “div.s” usage to isolate return reg “$f30”.
### __Part 7: Storing and Printing Result__
In the last part, we store the result and print it using msg_result, no critical bugs happened here.

### __Final Test Case and Validation__
Inputs used in the final test </br>
Size: </br>
Vector A: [1.0,2.0,3.0,4.0,5.0] </br>
Vector B: [1.0,2.0,3.0,4.0,5.0] </br>
Expected output “The Cosine Similarity between vector a and b is: 1.0” </br>
Testing: </br>
![alt text](https://github.com/Atclock/Cosine-Similarity-Using-MIPS-Assembly-language/blob/main/Images/FinalResult.png "FinalTestResult") </br>
Code passed the test successfully, with an error percentage of 0.000001%, that is due to the expected output (when manually calculated) getting rounded.

## Conclusion and Future Improvements
To sum it all up, the project is an implementation of a MIPS program to compute the cosine similarity between two user-defined vectors. It handled inputs, performed floating-point operations and organized the code into modular procedures. I implemented the project using MARS simulator. </br>
Despite the restrictions and specifications the project had, I was able to develop the whole program, fully structured to implement the cosine similarity formula, also developed a new strategy (on a personal scale) in debugging which helped me be more accurate. </br>
Surely Challenges occurred, the results in some tests had a minor rounding at first, due to limitations in floating-point precision. I found debugging a language like assembly more complicated, at some point I had to manually print to trace the values and ensure they are correct. I also found calculating offsets when storing/loading elements from memory a bit complicated too, which led to a runtime error earlier. Lastly, the restrictions on the registers made things more complicated, but the reasons were logical enough. As an improvement I would make it more dynamic by accepting sizes larger than 10. </br>
This module could be used in any field, as a lot of fields rely on cosine similarity. In machine learning, this module could be applied in recommendation systems and clustering algorithms. In embedded systems, it could be applied in low level systems, and it could even be a small calculator, offered as an educational tool. </br>
## Contributions
This project was a mixture of manual development and the usage of ChatGPT. As an AI tool, it was essential in researching the mathematical facts and understanding some new instructions that were needed to write the code. It also suggested some improvements in the design of the code and helped me develop new debugging methods. I would say that AI was helpful and a crucial tool to gain resources. </br>
Some of the testing happened using AI as well, it is essentially more accurate in defining errors and providing enough information on why a snippet might be wrong. At last, I asked AI to check if the specifications the project had were satisfied after manually checking. </br>
## Appendix A: Full code
Click this [Link](https://github.com/Atclock/Cosine-Similarity-Using-MIPS-Assembly-language/blob/main/mips1.asm) to get the file in .asm
## Appendix B: Critical Conversations with AI Tool
As mentioned earlier, AI was used as a learning assistant. It clarified the logic and structure as well as its contributions in debugging. </br>
Although I had initially written the code, the assistant helped ensure there were no unintentional logic errors or mismatches in register usage, it explained how and why a register should be saved or loaded, I checked if the code I wrote was fully ideal to the specifications and satisfies them.</br>
It also helped me learn how to document and write my comments clearly for others to understand. </br>
Besides the logic and structure, it helped me understand the theoretical part of the code and how to implement it in different life situations, and where my program could be used. </br>
