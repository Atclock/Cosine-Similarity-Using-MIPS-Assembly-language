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
MIPS is a reduced Instruction Set Computer architecture, each instruction is a 32-bit word and generally follows three formats: R-type, I-type and J-type.
For this assignment, I used MARS simulator, an IDE that supports MIPS assembly coding, MIPS floating-point instructions were implemented too for mathematical usage.
### __Vector Mathematics and Cosine Similarity__
Vectors represent quantities that have both a magnitude and a direction, we tend to compare between those vectors, one common approach is cosine similarity measure, an approach widely used in fields such as machine learning and information retrieval.
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
For Floating-point operations, MIPS uses $f registers, “.s” instructions, which are special instructions for single precision, were used to handle real number computations.
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
