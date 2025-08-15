.equ N 6

.data
A: .word 48,64,56,80,96,48

.bss
B: .word 0, 0, 0, 0, 0

.text
.globl main

jal main
li a0, 0
li a7, 93
ecall


myFilter:
    addi sp, sp, -16
    sw ra, 0(sp)

    li t0, 15
    and t0, t0, a0
    bne t0, zero, returnFalse
    blt a1, a0, returnFalse
    li a0, 1
    j 8
    returnFalse:
    li a0, 0

    lw ra, 0(sp)
    addi sp, sp, 16
    ret


main:
    addi sp, sp, -16
    sw ra, 0(sp)
    sw s0, 4(sp)
    sw s1, 8(sp)
    sw s2, 12(sp)
    sw s3, 16(sp)
    sw s4, 20(sp)

    la s0, A
    li s1, 0
    li s2, 0

    li t0, N
    addi t0, t0, -1
    li t1, 4
    mul s3, t0, t1
    la s4, B

    loop:
        beq s1, s3, endloop
        add t0, s0, s1
        lw a0, 0(t0)
        lw a1, 4(t0)
        jal myFilter
        beq a0, zero, passLoop
        
        add t3, s4, s2
        addi s2, s2, 4

        add t0, s0, s1
        lw t4, 0(t0)
        lw t5, 4(t0)

        add t4, t4, t5
        sw t4, 0(t3)

        passLoop:
        addi s1, s1, 4
        j loop


    endloop:

    li a0 0
    lw ra, 0(sp)
    lw s0, 4(sp)
    lw s1, 8(sp)
    lw s2, 12(sp)
    lw s3, 16(sp)
    lw s4, 20(sp)
    addi sp, sp, 16
    ret