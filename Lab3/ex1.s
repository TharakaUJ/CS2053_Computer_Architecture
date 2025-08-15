.equ N 3

.data
A: .word 7,3,25,4,75,2,1,1, 2
newline: .string "\n"

.bss
B: .word 0, 0, 0

.text
.globl main

jal main
li a0,0
li a7,93
ecall

abs:
    addi sp, sp, -16
    sw ra, 0(sp)

    bge a0, zero, abs_done
    sub a0, zero, a0
    abs_done:


    lw ra, 0(sp)
    addi sp, sp, 16
    ret

res_triplet:
    addi sp, sp, -16
    sw ra, 0(sp)
    sw s0, 4(sp)
    sw s1, 8(sp)
    sw s2, 12(sp)

    li s0, 0
    li s1, 12
    li t0, 0

    loop2:
        beq s0, s1, endloop2
        add t1, s0, a0
        add t1, t1, a1
        lw t2, 0(t1)
        add t0, t0, t2
        addi s0, s0, 4
        j loop2

    endloop2:
    mv a0, t0
    jal abs
    lw ra, 0(sp)
    lw s0, 4(sp)
    lw s1, 8(sp)
    lw s2, 12(sp)
    addi sp, sp, 16
    ret

    
main:
    addi sp, sp, -16
    sw ra, 0(sp)

    la s0, A
    li s1, 0
    li s2, 0

    addi s3, zero, N
    li s4, 0


    loop1:

        beq s2, s3, endloop1
        mv a0, s0
        mv a1, s1
        jal res_triplet
        addi s2, s2, 1
        addi s1, s1, 12
        la t1, B
        add t1, t1, s4
        addi s4, s4, 4
        sw a0, 0(t1)

        
        j loop1
    endloop1:


    li a0 0
    lw ra, 0(sp)
    addi sp, sp, 16
    ret
    