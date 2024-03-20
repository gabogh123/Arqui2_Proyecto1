.global main

main:
    # Initialize registers
    
    mov r0, #10     # Load 10 in r0
    mov r1, #5      # Load 5 in r1
    mov r2, #2      # Load 2 in r2
    mov r3, $zero   # Load 0 in r3
    mov r4, $zero   # Load 0 in r4
    mov r5, $zero   # Load 0 in r5
    mov r6, $zero   # Load 0 in r6

    # Sum instruction
    add r4, r0, r1  # r4 = r0 + r1 ---> 15 = 10 + 5

    # Sub instruction
    sub r5, r0, r1  # r5 = r0 - r1 ---> 5 = 10 - 5 

    # Mul instruction
    mul r6, r1, r2  # r6 = r1 * r2 ---> 10 = 2 * 5

    # Sumi instruction
    add r6, r6, #2  # r6 = r6 + 5 ---> 12 = 10 + 2 

    # Subi instruction
    sub r5, r6, #5  # r5 = r6 - 5 ---> 7 = 12 - 5

    # Str instruction
    str r6, [sp]    # str r6 value in sp ---> sp = 7

    # Ldr instruction
    mov r3, [sp]    # load in r3 sp's value ---> r3 = 7

    b end


end:
    # Exit code
    mov r7, #0x18  # Loads exit code
    syscall      # Syscall to exit program


/*


    # Compares
    cmp r7, r2      # Comparar r7 con r2

    beq equal       # Branch si r7 == r2
    bgt greater     # Branch si r7 > r2
    blt less        # Branch si r7 < r2

 */





