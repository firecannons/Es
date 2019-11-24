MISMATCH: "format ELF executable 3"
MISMATCH: "segment readable executable"
MISMATCH: "entry L29"

.L0:  # Bool:Bool

        pushl %ebp
        movl %esp,%ebp

        # asm comment
        # mov address of the object into
        movl %ebp,%ebx
        addl $8,%ebx
        movl (%ebx),%eax

        # Automatically assign true
        movb $1,(%eax)

        movl %ebp,%esp
        popl %ebp


ret

.L1:  # Integer:Integer



ret

.L2:  # Integer:=

            pushl %ebp
            movl %esp,%ebp

            # mov value of Source into eax
            movl %ebp,%ebx
            addl $12,%ebx
            movl (%ebx),%eax
            movl (%eax),%eax

            # mov address of return dword into ebx
            subl $4,%ebx
            movl (%ebx),%ebx

            # mov value of eax into position of [ebx]
MISMATCH: "            mov dword [ebx], eax"





            #mov ecx, ebx
            # Set other values
            #mov        eax, 4
            #mov        ebx, 1
            #mov        edx, 1
            #int        0x80

            movl %ebp,%esp
            popl %ebp

ret

.L3:  # Integer:+

            pushl %ebp
            movl %esp,%ebp

            # mov value of Source into eax
            movl %ebp,%ebx
            addl $12,%ebx
            movl (%ebx),%eax
MISMATCH: "            mov dword eax, [eax]"

            # load in the object into ecx
            subl $4,%ebx
            movl (%ebx),%ecx
MISMATCH: "            mov dword ecx, [ecx]"

            # perform addition
MISMATCH: "            add dword ecx, eax"

            # mov value into return area
            addl $8,%ebx
MISMATCH: "            mov dword [ebx], ecx"

            movl %ebp,%esp
            popl %ebp

ret

.L4:  # Integer:-

            pushl %ebp
            movl %esp,%ebp

            # mov value of Source into eax
            movl %ebp,%ebx
            addl $12,%ebx
            movl (%ebx),%eax
MISMATCH: "            mov dword eax, [eax]"

            # load in the object into ecx
            subl $4,%ebx
            movl (%ebx),%ecx
MISMATCH: "            mov dword ecx, [ecx]"

            # perform addition
MISMATCH: "            sub dword ecx, eax"

            # mov value into return area
            addl $8,%ebx
MISMATCH: "            mov dword [ebx], ecx"

            movl %ebp,%esp
            popl %ebp

ret

.L5:  # Integer:>

            pushl %ebp
            movl %esp,%ebp

            # mov value of Source into eax
            movl %ebp,%ebx
            addl $12,%ebx
            movl (%ebx),%eax
MISMATCH: "            mov dword eax, [eax]"

            # load in the object into ecx
            subl $4,%ebx
            movl (%ebx),%ecx
MISMATCH: "            mov dword ecx, [ecx]"

            # perform comparison
MISMATCH: "            cmp dword ecx, eax"
MISMATCH: "            setg byte al"

            # move resultto stack
            addl $8,%ebx
MISMATCH: "            mov byte [ebx], al"

            movl %ebp,%esp
            popl %ebp


ret

.L6:  # Integer:>=

            pushl %ebp
            movl %esp,%ebp

            # mov value of Source into eax
            movl %ebp,%ebx
            addl $12,%ebx
            movl (%ebx),%eax
MISMATCH: "            mov dword eax, [eax]"

            # load in the object into ecx
            subl $4,%ebx
            movl (%ebx),%ecx
MISMATCH: "            mov dword ecx, [ecx]"

            # perform comparison
MISMATCH: "            cmp dword ecx, eax"
MISMATCH: "            setge byte al"

            # move resultto stack
            addl $8,%ebx
MISMATCH: "            mov byte [ebx], al"

            movl %ebp,%esp
            popl %ebp


ret

.L7:  # Integer:==

            pushl %ebp
            movl %esp,%ebp

            # mov value of Source into eax
            movl %ebp,%ebx
            addl $12,%ebx
            movl (%ebx),%eax
MISMATCH: "            mov dword eax, [eax]"

            # load in the object into ecx
            subl $4,%ebx
            movl (%ebx),%ecx
MISMATCH: "            mov dword ecx, [ecx]"

            # perform comparison
MISMATCH: "            cmp dword ecx, eax"
MISMATCH: "            sete byte al"

            # move resultto stack
            addl $8,%ebx
MISMATCH: "            mov byte [ebx], al"

            movl %ebp,%esp
            popl %ebp

ret

.L8:  # Integer:<

            pushl %ebp
            movl %esp,%ebp

            # mov value of Source into eax
            movl %ebp,%ebx
            addl $12,%ebx
            movl (%ebx),%eax
MISMATCH: "            mov dword eax, [eax]"

            # load in the object into ecx
            subl $4,%ebx
            movl (%ebx),%ecx
MISMATCH: "            mov dword ecx, [ecx]"

            # perform comparison
MISMATCH: "            cmp dword ecx, eax"
MISMATCH: "            setl byte al"

            # move result onto stack
            addl $8,%ebx
MISMATCH: "            mov byte [ebx], al"

            movl %ebp,%esp
            popl %ebp

ret

.L9:  # Integer:<=

            pushl %ebp
            movl %esp,%ebp

            # mov value of Source into eax
            movl %ebp,%ebx
            addl $12,%ebx
            movl (%ebx),%eax
MISMATCH: "            mov dword eax, [eax]"

            # load in the object into ecx
            subl $4,%ebx
            movl (%ebx),%ecx
MISMATCH: "            mov dword ecx, [ecx]"

            # perform comparison
MISMATCH: "            cmp dword ecx, eax"
MISMATCH: "            setle byte al"

            # move result onto stack
            addl $8,%ebx
MISMATCH: "            mov byte [ebx], al"

            movl %ebp,%esp
            popl %ebp

ret

.L10:  # Integer:!=

            pushl %ebp
            movl %esp,%ebp

            # mov value of Source into eax
            movl %ebp,%ebx
            addl $12,%ebx
            movl (%ebx),%eax
MISMATCH: "            mov dword eax, [eax]"

            # load in the object into ecx
            subl $4,%ebx
            movl (%ebx),%ecx
MISMATCH: "            mov dword ecx, [ecx]"

            # perform comparison
MISMATCH: "            cmp dword ecx, eax"
MISMATCH: "            setne byte al"

            # move resultto stack
            addl $8,%ebx
MISMATCH: "            mov byte [ebx], al"

            movl %ebp,%esp
            popl %ebp

ret

.L11:  # Byte:Byte

            pushl %ebp
            movl %esp,%ebp

            # asm comment
            # mov address of the object into
            movl %ebp,%ebx
            addl $8,%ebx
            movl (%ebx),%eax

            movb $101,(%eax)

            movl %ebp,%esp
            popl %ebp

ret

.L12:  # Byte:=

            pushl %ebp
            movl %esp,%ebp

            # mov value of Source into eax
            movl %ebp,%ebx
            addl $12,%ebx
            movl (%ebx),%eax
            movl (%eax),%eax

            # mov address of return byte into ebx
            subl $4,%ebx
            movl (%ebx),%ebx

            # mov value of eax into position of [ebx]
MISMATCH: "            mov byte [ebx], al"





            #mov ecx, ebx
            # Set other values
            #mov        eax, 4
            #mov        ebx, 1
            #mov        edx, 1
            #int        0x80

            movl %ebp,%esp
            popl %ebp

ret

.L13:  # Byte:+

            pushl %ebp
            movl %esp,%ebp

            # mov value of Source into eax
            movl %ebp,%ebx
            addl $12,%ebx
            movl (%ebx),%eax
MISMATCH: "            mov byte al, [eax]"

            # load in the object into ecx
            subl $4,%ebx
            movl (%ebx),%ecx
MISMATCH: "            mov byte cl, [ecx]"

            # perform addition
MISMATCH: "            add byte cl, al"

            # mov value into return area
            addl $8,%ebx
MISMATCH: "            mov byte [ebx], cl"

            movl %ebp,%esp
            popl %ebp

ret

.L14:  # Byte:-

            pushl %ebp
            movl %esp,%ebp

            # mov value of Source into eax
            movl %ebp,%ebx
            addl $12,%ebx
            movl (%ebx),%eax
MISMATCH: "            mov byte al, [eax]"

            # load in the object into ecx
            subl $4,%ebx
            movl (%ebx),%ecx
MISMATCH: "            mov byte cl, [ecx]"

            # perform addition
MISMATCH: "            sub byte cl, al"

            # mov value into return area
            addl $8,%ebx
MISMATCH: "            mov byte [ebx], cl"

            movl %ebp,%esp
            popl %ebp

ret

.L15:  # Byte:>

            pushl %ebp
            movl %esp,%ebp

            # mov value of Source into eax
            movl %ebp,%ebx
            addl $12,%ebx
            movl (%ebx),%eax
MISMATCH: "            mov byte al, [eax]"

            # load in the object into ecx
            subl $4,%ebx
            movl (%ebx),%ecx
MISMATCH: "            mov byte cl, [ecx]"

            # perform comparison
MISMATCH: "            cmp byte cl, al"
MISMATCH: "            setg byte al"

            # move result onto stack
            addl $8,%ebx
MISMATCH: "            mov byte [ebx], al"

            movl %ebp,%esp
            popl %ebp


ret

.L16:  # Byte:>=

            pushl %ebp
            movl %esp,%ebp

            # mov value of Source into eax
            movl %ebp,%ebx
            addl $12,%ebx
            movl (%ebx),%eax
MISMATCH: "            mov byte al, [eax]"

            # load in the object into ecx
            subl $4,%ebx
            movl (%ebx),%ecx
MISMATCH: "            mov byte cl, [ecx]"

            # perform comparison
MISMATCH: "            cmp byte cl, al"
MISMATCH: "            setge byte al"

            # move result onto stack
            addl $8,%ebx
MISMATCH: "            mov byte [ebx], al"

            movl %ebp,%esp
            popl %ebp

ret

.L17:  # Byte:==

            pushl %ebp
            movl %esp,%ebp

            # mov value of Source into eax
            movl %ebp,%ebx
            addl $12,%ebx
            movl (%ebx),%eax
MISMATCH: "            mov byte al, [eax]"

            # load in the object into ecx
            subl $4,%ebx
            movl (%ebx),%ecx
MISMATCH: "            mov byte cl, [ecx]"

            # perform comparison
MISMATCH: "            cmp byte cl, al"
MISMATCH: "            sete byte al"

            # move result onto stack
            addl $8,%ebx
MISMATCH: "            mov byte [ebx], al"

            movl %ebp,%esp
            popl %ebp

ret

.L18:  # Byte:<

            pushl %ebp
            movl %esp,%ebp

            # mov value of Source into eax
            movl %ebp,%ebx
            addl $12,%ebx
            movl (%ebx),%eax
MISMATCH: "            mov byte al, [eax]"

            # load in the object into ecx
            subl $4,%ebx
            movl (%ebx),%ecx
MISMATCH: "            mov byte cl, [ecx]"

            # perform comparison
MISMATCH: "            cmp byte cl, al"
MISMATCH: "            setl byte al"

            # move result onto stack
            addl $8,%ebx
MISMATCH: "            mov byte [ebx], al"

            movl %ebp,%esp
            popl %ebp


ret

.L19:  # Byte:<=

            pushl %ebp
            movl %esp,%ebp

            # mov value of Source into eax
            movl %ebp,%ebx
            addl $12,%ebx
            movl (%ebx),%eax
MISMATCH: "            mov byte al, [eax]"

            # load in the object into ecx
            subl $4,%ebx
            movl (%ebx),%ecx
MISMATCH: "            mov byte cl, [ecx]"

            # perform comparison
MISMATCH: "            cmp byte cl, al"
MISMATCH: "            setle byte al"

            # move result onto stack
            addl $8,%ebx
MISMATCH: "            mov byte [ebx], al"

            movl %ebp,%esp
            popl %ebp

ret

.L20:  # Byte:!=

            pushl %ebp
            movl %esp,%ebp

            # mov value of Source into eax
            movl %ebp,%ebx
            addl $12,%ebx
            movl (%ebx),%eax
MISMATCH: "            mov byte al, [eax]"

            # load in the object into ecx
            subl $4,%ebx
            movl (%ebx),%ecx
MISMATCH: "            mov byte cl, [ecx]"

            # perform comparison
MISMATCH: "            cmp byte cl, al"
MISMATCH: "            setne byte al"

            # move result onto stack
            addl $8,%ebx
MISMATCH: "            mov byte [ebx], al"

            movl %ebp,%esp
            popl %ebp


ret

.L21:  # Pointer:create

pushl %ebp
movl %esp,%ebp

movl %ebp,%esp
popl %ebp

ret

.L22:  # Pointer:=

pushl %ebp
movl %esp,%ebp

addl $-4,%esp
movl %ebp,%ebx
addl $12,%ebx
movl %ebx,(%esp) # Pushing reference to [T1 from offset 12


movl %ebp,%ebx
addl $8,%ebx
movl (%ebx),%ebx # Dereferencing before push [T0 from reference offset 8

addl $-4,%esp
addl $0,%ebx
movl %ebx,(%esp) # Pushing reference to [T0 from offset 0

call L2 # Calling =
addl $8,%esp

movl %ebp,%esp
popl %ebp

ret

.L23:  # CapTest:CapTest

pushl %ebp
movl %esp,%ebp

movl %ebp,%esp
popl %ebp

ret

.L24:  # CapTest2:CapTest2

pushl %ebp
movl %esp,%ebp

movl %ebp,%esp
popl %ebp

ret

.L25:  # CapTest3:CapTest3

pushl %ebp
movl %esp,%ebp

movl %ebp,%esp
popl %ebp

ret

.L26:  # :OutputByte

    pushl %ebp
    movl %esp,%ebp

    # load a pointer to the byte in ecx
    movl %ebp,%ecx
    addl $8,%ecx
    movl (%ecx),%ecx

    # Set other values
    movl $4,%eax
    movl $1,%ebx
        movl    $1,%edx
        int     $0x80

    movl %ebp,%esp
    popl %ebp

ret

.L27:  # :OutputByte2

    pushl %ebp
    movl %esp,%ebp

    # load a pointer to the byte in ecx
    movl %ebp,%ecx
    addl $8,%ecx
    movl (%ecx),%ecx

    # Set other values
    movl $4,%eax
    movl $1,%ebx
        movl    $1,%edx
        int     $0x80

    movl %ebp,%ecx
    addl $12,%ecx
    movl (%ecx),%ecx

    # Set other values
    movl $4,%eax
    movl $1,%ebx
        movl    $1,%edx
        int     $0x80

    movl %ebp,%esp
    popl %ebp


ret

.L28:  # :OutputByte5

    pushl %ebp
    movl %esp,%ebp

    # load a pointer to the byte in ecx
    movl %ebp,%ecx
    addl $8,%ecx
    movl (%ecx),%ecx

    # Set other values
    movl $4,%eax
    movl $1,%ebx
        movl    $1,%edx
        int     $0x80

    movl %ebp,%ecx
    addl $12,%ecx
    movl (%ecx),%ecx

    # Set other values
    movl $4,%eax
    movl $1,%ebx
        movl    $1,%edx
        int     $0x80

    movl %ebp,%ecx
    addl $16,%ecx
    movl (%ecx),%ecx

    # Set other values
    movl $4,%eax
    movl $1,%ebx
        movl    $1,%edx
        int     $0x80

    movl %ebp,%ecx
    addl $20,%ecx
    movl (%ecx),%ecx

    # Set other values
    movl $4,%eax
    movl $1,%ebx
        movl    $1,%edx
        int     $0x80

    movl %ebp,%ecx
    addl $24,%ecx
    movl (%ecx),%ecx

    # Set other values
    movl $4,%eax
    movl $1,%ebx
        movl    $1,%edx
        int     $0x80

    movl %ebp,%esp
    popl %ebp


ret

.L29:  # :Main

pushl %ebp
movl %esp,%ebp

addl $-1,%esp # Declaring L
addl $-1,%esp # Declaring [T2
movb $102,(%esp)
addl $-4,%esp
movl %ebp,%ebx
addl $-2,%ebx
movl %ebx,(%esp) # Pushing reference to [T2 from offset -2

addl $-4,%esp
movl %ebp,%ebx
addl $-1,%ebx
movl %ebx,(%esp) # Pushing reference to L from offset -1

call L12 # Calling =
addl $8,%esp

addl $-4,%esp
movl %ebp,%ebx
addl $-1,%ebx
movl %ebx,(%esp) # Pushing reference to L from offset -1

call L26 # Calling OutputByte
addl $4,%esp

addl $-1,%esp # Declaring I1
addl $-1,%esp # Declaring [T3
movb $100,(%esp)
addl $-4,%esp
movl %ebp,%ebx
addl $-4,%ebx
movl %ebx,(%esp) # Pushing reference to [T3 from offset -4

addl $-4,%esp
movl %ebp,%ebx
addl $-3,%ebx
movl %ebx,(%esp) # Pushing reference to I1 from offset -3

call L12 # Calling =
addl $8,%esp

addl $-4,%esp
movl %ebp,%ebx
addl $-1,%ebx
movl %ebx,(%esp) # Pushing reference to L from offset -1

addl $-4,%esp
movl %ebp,%ebx
addl $-3,%ebx
movl %ebx,(%esp) # Pushing reference to I1 from offset -3

call L12 # Calling =
addl $8,%esp

addl $-4,%esp
movl %ebp,%ebx
addl $-3,%ebx
movl %ebx,(%esp) # Pushing reference to I1 from offset -3

addl $-4,%esp
movl %ebp,%ebx
addl $-1,%ebx
movl %ebx,(%esp) # Pushing reference to L from offset -1

call L12 # Calling =
addl $8,%esp

addl $-4,%esp
movl %ebp,%ebx
addl $-3,%ebx
movl %ebx,(%esp) # Pushing reference to I1 from offset -3

call L26 # Calling OutputByte
addl $4,%esp

addl $-4,%esp
movl %ebp,%ebx
addl $-1,%ebx
movl %ebx,(%esp) # Pushing reference to L from offset -1

call L26 # Calling OutputByte
addl $4,%esp

addl $-1,%esp # Declaring CST_1
addl $-4,%esp
movl %ebp,%ebx
addl $-3,%ebx
movl %ebx,(%esp) # Pushing reference to I1 from offset -3

addl $-4,%esp
movl %ebp,%ebx
addl $-5,%ebx
movl %ebx,(%esp) # Pushing reference to CST_1 from offset -5

call L12 # Calling =
addl $8,%esp

addl $-2,%esp # Declaring ET
addl $-1,%esp # Declaring [T5
movb $102,(%esp)
addl $-4,%esp
movl %ebp,%ebx
addl $-8,%ebx
movl %ebx,(%esp) # Pushing reference to [T5 from offset -8

addl $-4,%esp
movl %ebp,%ebx
addl $-7,%ebx
movl %ebx,(%esp) # Pushing reference to [T4 from offset -7

call L12 # Calling =
addl $8,%esp

addl $-4,%esp
movl %ebp,%ebx
addl $-7,%ebx
movl %ebx,(%esp) # Pushing reference to [T6 from offset -7

call L26 # Calling OutputByte
addl $4,%esp

movl %ebp,%esp
popl %ebp

ret


