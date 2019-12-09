format ELF executable 3
segment readable executable
entry L28

L0: ; Integer:Integer

            
        
ret

L1: ; Integer:=

            push ebp
            mov ebp, esp
            
            ; mov value of Source into eax
            mov ebx, ebp
            add ebx, 12
            mov eax, [ebx]
            mov eax, [eax]
            
            ; mov address of return dword into ebx
            sub ebx, 4
            mov ebx, [ebx]
            
            ; mov value of eax into position of [ebx]
            mov dword [ebx], eax
            
            
            
            
            
            ;mov ecx, ebx
            ; Set other values
            ;mov	eax, 4
            ;mov	ebx, 1
            ;mov	edx, 1
            ;int	0x80
            
            mov esp, ebp
            pop ebp
        
ret

L2: ; Integer:+

            push ebp
            mov ebp, esp
            
            ; mov value of Source into eax
            mov ebx, ebp
            add ebx, 12
            mov eax, [ebx]
            mov dword eax, [eax]
            
            ; load in the object into ecx
            sub ebx, 4
            mov ecx, [ebx]
            mov dword ecx, [ecx]
            
            ; perform addition
            add dword ecx, eax
            
            ; mov value into return area
            add ebx, 8
            mov dword [ebx], ecx
            
            mov esp, ebp
            pop ebp
        
ret

L3: ; Integer:-

            push ebp
            mov ebp, esp
            
            ; mov value of Source into eax
            mov ebx, ebp
            add ebx, 12
            mov eax, [ebx]
            mov dword eax, [eax]
            
            ; load in the object into ecx
            sub ebx, 4
            mov ecx, [ebx]
            mov dword ecx, [ecx]
            
            ; perform addition
            sub dword ecx, eax
            
            ; mov value into return area
            add ebx, 8
            mov dword [ebx], ecx
            
            mov esp, ebp
            pop ebp
        
ret

L4: ; Integer:>

            push ebp
            mov ebp, esp
            
            ; mov value of Source into eax
            mov ebx, ebp
            add ebx, 12
            mov eax, [ebx]
            mov dword eax, [eax]
            
            ; load in the object into ecx
            sub ebx, 4
            mov ecx, [ebx]
            mov dword ecx, [ecx]
            
            ; perform comparison
            cmp dword ecx, eax
            setg byte al
            
            ; move resultto stack
            add ebx, 8
            mov byte [ebx], al
            
            mov esp, ebp
            pop ebp
            
        
ret

L5: ; Integer:>=

            push ebp
            mov ebp, esp
            
            ; mov value of Source into eax
            mov ebx, ebp
            add ebx, 12
            mov eax, [ebx]
            mov dword eax, [eax]
            
            ; load in the object into ecx
            sub ebx, 4
            mov ecx, [ebx]
            mov dword ecx, [ecx]
            
            ; perform comparison
            cmp dword ecx, eax
            setge byte al
            
            ; move resultto stack
            add ebx, 8
            mov byte [ebx], al
            
            mov esp, ebp
            pop ebp
            
        
ret

L6: ; Integer:==

            push ebp
            mov ebp, esp
            
            ; mov value of Source into eax
            mov ebx, ebp
            add ebx, 12
            mov eax, [ebx]
            mov dword eax, [eax]
            
            ; load in the object into ecx
            sub ebx, 4
            mov ecx, [ebx]
            mov dword ecx, [ecx]
            
            ; perform comparison
            cmp dword ecx, eax
            sete byte al
            
            ; move resultto stack
            add ebx, 8
            mov byte [ebx], al
            
            mov esp, ebp
            pop ebp
        
ret

L7: ; Integer:<

            push ebp
            mov ebp, esp
            
            ; mov value of Source into eax
            mov ebx, ebp
            add ebx, 12
            mov eax, [ebx]
            mov dword eax, [eax]
            
            ; load in the object into ecx
            sub ebx, 4
            mov ecx, [ebx]
            mov dword ecx, [ecx]
            
            ; perform comparison
            cmp dword ecx, eax
            setl byte al
            
            ; move result onto stack
            add ebx, 8
            mov byte [ebx], al
            
            mov esp, ebp
            pop ebp
        
ret

L8: ; Integer:<=

            push ebp
            mov ebp, esp
            
            ; mov value of Source into eax
            mov ebx, ebp
            add ebx, 12
            mov eax, [ebx]
            mov dword eax, [eax]
            
            ; load in the object into ecx
            sub ebx, 4
            mov ecx, [ebx]
            mov dword ecx, [ecx]
            
            ; perform comparison
            cmp dword ecx, eax
            setle byte al
            
            ; move result onto stack
            add ebx, 8
            mov byte [ebx], al
            
            mov esp, ebp
            pop ebp
        
ret

L9: ; Integer:!=

            push ebp
            mov ebp, esp
            
            ; mov value of Source into eax
            mov ebx, ebp
            add ebx, 12
            mov eax, [ebx]
            mov dword eax, [eax]
            
            ; load in the object into ecx
            sub ebx, 4
            mov ecx, [ebx]
            mov dword ecx, [ecx]
            
            ; perform comparison
            cmp dword ecx, eax
            setne byte al
            
            ; move resultto stack
            add ebx, 8
            mov byte [ebx], al
            
            mov esp, ebp
            pop ebp
        
ret

L10: ; Byte:Byte

            push ebp
            mov ebp, esp
            
            ; asm comment
            ; mov address of the object into
            mov ebx, ebp
            add ebx, 8
            mov eax, [ebx]
            
            mov byte [eax], 101
            
            mov esp, ebp
            pop ebp
        
ret

L11: ; Byte:=

            push ebp
            mov ebp, esp
            
            ; mov value of Source into eax
            mov ebx, ebp
            add ebx, 12
            mov eax, [ebx]
            mov eax, [eax]
            
            ; mov address of return byte into ebx
            sub ebx, 4
            mov ebx, [ebx]
            
            ; mov value of eax into position of [ebx]
            mov byte [ebx], al
            
            
            
            
            
            ;mov ecx, ebx
            ; Set other values
            ;mov	eax, 4
            ;mov	ebx, 1
            ;mov	edx, 1
            ;int	0x80
            
            mov esp, ebp
            pop ebp
        
ret

L12: ; Byte:+

            push ebp
            mov ebp, esp
            
            ; mov value of Source into eax
            mov ebx, ebp
            add ebx, 12
            mov eax, [ebx]
            mov byte al, [eax]
            
            ; load in the object into ecx
            sub ebx, 4
            mov ecx, [ebx]
            mov byte cl, [ecx]
            
            ; perform addition
            add byte cl, al
            
            ; mov value into return area
            add ebx, 8
            mov byte [ebx], cl
            
            mov esp, ebp
            pop ebp
        
ret

L13: ; Byte:-

            push ebp
            mov ebp, esp
            
            ; mov value of Source into eax
            mov ebx, ebp
            add ebx, 12
            mov eax, [ebx]
            mov byte al, [eax]
            
            ; load in the object into ecx
            sub ebx, 4
            mov ecx, [ebx]
            mov byte cl, [ecx]
            
            ; perform addition
            sub byte cl, al
            
            ; mov value into return area
            add ebx, 8
            mov byte [ebx], cl
            
            mov esp, ebp
            pop ebp
        
ret

L14: ; Byte:>

            push ebp
            mov ebp, esp
            
            ; mov value of Source into eax
            mov ebx, ebp
            add ebx, 12
            mov eax, [ebx]
            mov byte al, [eax]
            
            ; load in the object into ecx
            sub ebx, 4
            mov ecx, [ebx]
            mov byte cl, [ecx]
            
            ; perform comparison
            cmp byte cl, al
            setg byte al
            
            ; move result onto stack
            add ebx, 8
            mov byte [ebx], al
            
            mov esp, ebp
            pop ebp
            
        
ret

L15: ; Byte:>=

            push ebp
            mov ebp, esp
            
            ; mov value of Source into eax
            mov ebx, ebp
            add ebx, 12
            mov eax, [ebx]
            mov byte al, [eax]
            
            ; load in the object into ecx
            sub ebx, 4
            mov ecx, [ebx]
            mov byte cl, [ecx]
            
            ; perform comparison
            cmp byte cl, al
            setge byte al
            
            ; move result onto stack
            add ebx, 8
            mov byte [ebx], al
            
            mov esp, ebp
            pop ebp
        
ret

L16: ; Byte:==

            push ebp
            mov ebp, esp
            
            ; mov value of Source into eax
            mov ebx, ebp
            add ebx, 12
            mov eax, [ebx]
            mov byte al, [eax]
            
            ; load in the object into ecx
            sub ebx, 4
            mov ecx, [ebx]
            mov byte cl, [ecx]
            
            ; perform comparison
            cmp byte cl, al
            sete byte al
            
            ; move result onto stack
            add ebx, 8
            mov byte [ebx], al
            
            mov esp, ebp
            pop ebp
        
ret

L17: ; Byte:<

            push ebp
            mov ebp, esp
            
            ; mov value of Source into eax
            mov ebx, ebp
            add ebx, 12
            mov eax, [ebx]
            mov byte al, [eax]
            
            ; load in the object into ecx
            sub ebx, 4
            mov ecx, [ebx]
            mov byte cl, [ecx]
            
            ; perform comparison
            cmp byte cl, al
            setl byte al
            
            ; move result onto stack
            add ebx, 8
            mov byte [ebx], al
            
            mov esp, ebp
            pop ebp
            
        
ret

L18: ; Byte:<=

            push ebp
            mov ebp, esp
            
            ; mov value of Source into eax
            mov ebx, ebp
            add ebx, 12
            mov eax, [ebx]
            mov byte al, [eax]
            
            ; load in the object into ecx
            sub ebx, 4
            mov ecx, [ebx]
            mov byte cl, [ecx]
            
            ; perform comparison
            cmp byte cl, al
            setle byte al
            
            ; move result onto stack
            add ebx, 8
            mov byte [ebx], al
            
            mov esp, ebp
            pop ebp
        
ret

L19: ; Byte:!=

            push ebp
            mov ebp, esp
            
            ; mov value of Source into eax
            mov ebx, ebp
            add ebx, 12
            mov eax, [ebx]
            mov byte al, [eax]
            
            ; load in the object into ecx
            sub ebx, 4
            mov ecx, [ebx]
            mov byte cl, [ecx]
            
            ; perform comparison
            cmp byte cl, al
            setne byte al
            
            ; move result onto stack
            add ebx, 8
            mov byte [ebx], al
            
            mov esp, ebp
            pop ebp
            
        
ret

L20: ; Byte:OutputToConsole

            push ebp
            mov ebp, esp
            
            ; load a pointer to the byte in ecx
            mov ecx, ebp
            add ecx, 8
            mov ecx, [ecx]
            
            ; Set other values
            mov	eax, 4
            mov	ebx, 1
            mov	edx, 1
            int	0x80
            
            mov esp, ebp
            pop ebp
        
ret

L21: ; Bool:Bool

        push ebp
        mov ebp, esp
    
        ; asm comment
        ; mov address of the object into
        mov ebx, ebp
        add ebx, 8
        mov eax, [ebx]
        
        ; Automatically assign true
        mov byte [eax], 1
        
        mov esp, ebp
        pop ebp
        
    
ret

L22: ; CapTest:CapTest

push ebp
mov ebp, esp

mov esp, ebp
pop ebp

ret

L23: ; CapTest2:CapTest2

push ebp
mov ebp, esp

mov esp, ebp
pop ebp

ret

L24: ; CapTest3:CapTest3

push ebp
mov ebp, esp

mov esp, ebp
pop ebp

ret

L25: ; :OutputByte

    push ebp
    mov ebp, esp
    
    ; load a pointer to the byte in ecx
    mov ecx, ebp
    add ecx, 8
    mov ecx, [ecx]
    
    ; Set other values
    mov	eax, 4
    mov	ebx, 1
	mov	edx, 1
	int	0x80
    
    mov esp, ebp
    pop ebp

ret

L26: ; :OutputByte2

    push ebp
    mov ebp, esp
    
    ; load a pointer to the byte in ecx
    mov ecx, ebp
    add ecx, 8
    mov ecx, [ecx]
    
    ; Set other values
    mov	eax, 4
    mov	ebx, 1
	mov	edx, 1
	int	0x80
    
    mov ecx, ebp
    add ecx, 12
    mov ecx, [ecx]
    
    ; Set other values
    mov	eax, 4
    mov	ebx, 1
	mov	edx, 1
	int	0x80
    
    mov esp, ebp
    pop ebp
    

ret

L27: ; :OutputByte5

    push ebp
    mov ebp, esp
    
    ; load a pointer to the byte in ecx
    mov ecx, ebp
    add ecx, 8
    mov ecx, [ecx]
    
    ; Set other values
    mov	eax, 4
    mov	ebx, 1
	mov	edx, 1
	int	0x80
    
    mov ecx, ebp
    add ecx, 12
    mov ecx, [ecx]
    
    ; Set other values
    mov	eax, 4
    mov	ebx, 1
	mov	edx, 1
	int	0x80
    
    mov ecx, ebp
    add ecx, 16
    mov ecx, [ecx]
    
    ; Set other values
    mov	eax, 4
    mov	ebx, 1
	mov	edx, 1
	int	0x80
    
    mov ecx, ebp
    add ecx, 20
    mov ecx, [ecx]
    
    ; Set other values
    mov	eax, 4
    mov	ebx, 1
	mov	edx, 1
	int	0x80
    
    mov ecx, ebp
    add ecx, 24
    mov ecx, [ecx]
    
    ; Set other values
    mov	eax, 4
    mov	ebx, 1
	mov	edx, 1
	int	0x80
    
    mov esp, ebp
    pop ebp
    

ret

L28: ; :Main

push ebp
mov ebp, esp

add esp, -1 ; Declaring L
add esp, -1 ; Declaring [T0
mov byte [esp], 102
add esp, -4
mov ebx, ebp
add ebx, -2
mov [esp], ebx ; Pushing reference to [T0 from offset -2

add esp, -4
mov ebx, ebp
add ebx, -1
mov [esp], ebx ; Pushing reference to L from offset -1

call L11 ; Calling =
add esp, 8

add esp, -4
mov ebx, ebp
add ebx, -1
mov [esp], ebx ; Pushing reference to L from offset -1

call L25 ; Calling OutputByte
add esp, 4

add esp, -1 ; Declaring I1
add esp, -1 ; Declaring [T1
mov byte [esp], 100
add esp, -4
mov ebx, ebp
add ebx, -4
mov [esp], ebx ; Pushing reference to [T1 from offset -4

add esp, -4
mov ebx, ebp
add ebx, -3
mov [esp], ebx ; Pushing reference to I1 from offset -3

call L11 ; Calling =
add esp, 8

add esp, -4
mov ebx, ebp
add ebx, -1
mov [esp], ebx ; Pushing reference to L from offset -1

add esp, -4
mov ebx, ebp
add ebx, -3
mov [esp], ebx ; Pushing reference to I1 from offset -3

call L11 ; Calling =
add esp, 8

add esp, -4
mov ebx, ebp
add ebx, -3
mov [esp], ebx ; Pushing reference to I1 from offset -3

add esp, -4
mov ebx, ebp
add ebx, -1
mov [esp], ebx ; Pushing reference to L from offset -1

call L11 ; Calling =
add esp, 8

add esp, -4
mov ebx, ebp
add ebx, -3
mov [esp], ebx ; Pushing reference to I1 from offset -3

call L25 ; Calling OutputByte
add esp, 4

add esp, -4
mov ebx, ebp
add ebx, -1
mov [esp], ebx ; Pushing reference to L from offset -1

call L25 ; Calling OutputByte
add esp, 4

add esp, -1 ; Declaring CST_1
add esp, -4
mov ebx, ebp
add ebx, -3
mov [esp], ebx ; Pushing reference to I1 from offset -3

add esp, -4
mov ebx, ebp
add ebx, -5
mov [esp], ebx ; Pushing reference to CST_1 from offset -5

call L11 ; Calling =
add esp, 8

add esp, -2 ; Declaring ET
add esp, -1 ; Declaring [T3
mov byte [esp], 102
add esp, -4
mov ebx, ebp
add ebx, -8
mov [esp], ebx ; Pushing reference to [T3 from offset -8

add esp, -4
mov ebx, ebp
add ebx, -7
mov [esp], ebx ; Pushing reference to [T2 from offset -7

call L11 ; Calling =
add esp, 8

add esp, -4
mov ebx, ebp
add ebx, -7
mov [esp], ebx ; Pushing reference to [T4 from offset -7

call L25 ; Calling OutputByte
add esp, 4

add esp, -1 ; Declaring A
add esp, -1 ; Declaring [T6
mov byte [esp], 102
add esp, -4
mov ebx, ebp
add ebx, -10
mov [esp], ebx ; Pushing reference to [T6 from offset -10

add esp, -4
mov ebx, ebp
add ebx, -9
mov [esp], ebx ; Pushing reference to [T5 from offset -9

call L11 ; Calling =
add esp, 8

add esp, -4
mov ebx, ebp
add ebx, -9
mov [esp], ebx ; Pushing reference to [T7 from offset -9

call L25 ; Calling OutputByte
add esp, 4

add esp, -4 ; Declaring Pb
add esp, -4 ; Declaring Pi
add esp, -8 ; Declaring Bi
add esp, -5 ; Declaring Bb
add esp, -1 ; Declaring MyByte
add esp, -1 ; Declaring [T16
mov byte [esp], 101
add esp, -4
mov ebx, ebp
add ebx, -33
mov [esp], ebx ; Pushing reference to [T16 from offset -33

add esp, -4
mov ebx, ebp
add ebx, -32
mov [esp], ebx ; Pushing reference to MyByte from offset -32

call L11 ; Calling =
add esp, 8

add esp, -4
mov ebx, ebp
add ebx, -32
mov [esp], ebx ; Pushing reference to MyByte from offset -32

call L20 ; Calling OutputToConsole
add esp, 4

add esp, -1 ; Declaring [T18
mov byte [esp], 103
add esp, -4
mov ebx, ebp
add ebx, -34
mov [esp], ebx ; Pushing reference to [T18 from offset -34

add esp, -4
mov ebx, ebp
add ebx, -31
mov [esp], ebx ; Pushing reference to [T17 from offset -31

call L11 ; Calling =
add esp, 8

add esp, -4
mov ebx, ebp
add ebx, -31
mov [esp], ebx ; Pushing reference to [T19 from offset -31

call L20 ; Calling OutputToConsole
add esp, 4

add esp, -5 ; Declaring Bb2
add esp, -4
mov ebx, ebp
add ebx, -31
mov [esp], ebx ; Pushing reference to Bb from offset -31

add esp, -4
mov ebx, ebp
add ebx, -39
mov [esp], ebx ; Pushing reference to Bb2 from offset -39

call L38 ; Calling =
add esp, 8

add esp, -4
mov ebx, ebp
add ebx, -39
mov [esp], ebx ; Pushing reference to [T20 from offset -39

call L20 ; Calling OutputToConsole
add esp, 4

mov esp, ebp
pop ebp

ret

L29: ; Pointer<Byte>:Pointer

push ebp
mov ebp, esp

mov esp, ebp
pop ebp

ret

L30: ; Pointer<Byte>:=

push ebp
mov ebp, esp


mov ebx, ebp
add ebx, 12
mov ebx, [ebx] ; Dereferencing before push [T9 from reference offset 12

add esp, -4
add ebx, 0
mov [esp], ebx ; Pushing reference to [T9 from offset 0


mov ebx, ebp
add ebx, 8
mov ebx, [ebx] ; Dereferencing before push [T8 from reference offset 8

add esp, -4
add ebx, 0
mov [esp], ebx ; Pushing reference to [T8 from offset 0

call L1 ; Calling =
add esp, 8

mov esp, ebp
pop ebp

ret

L31: ; Pointer<Byte>:Deref

push ebp
mov ebp, esp

mov esp, ebp
pop ebp

ret

L32: ; Pointer<Integer>:Pointer

push ebp
mov ebp, esp

mov esp, ebp
pop ebp

ret

L33: ; Pointer<Integer>:=

push ebp
mov ebp, esp


mov ebx, ebp
add ebx, 12
mov ebx, [ebx] ; Dereferencing before push [T11 from reference offset 12

add esp, -4
add ebx, 0
mov [esp], ebx ; Pushing reference to [T11 from offset 0


mov ebx, ebp
add ebx, 8
mov ebx, [ebx] ; Dereferencing before push [T10 from reference offset 8

add esp, -4
add ebx, 0
mov [esp], ebx ; Pushing reference to [T10 from offset 0

call L1 ; Calling =
add esp, 8

mov esp, ebp
pop ebp

ret

L34: ; Pointer<Integer>:Deref

push ebp
mov ebp, esp

mov esp, ebp
pop ebp

ret

L35: ; Box<Integer>:Box

push ebp
mov ebp, esp

mov esp, ebp
pop ebp

ret

L36: ; Box<Integer>:=

push ebp
mov ebp, esp


mov ebx, ebp
add ebx, 12
mov ebx, [ebx] ; Dereferencing before push [T13 from reference offset 12

add esp, -4
add ebx, 0
mov [esp], ebx ; Pushing reference to [T13 from offset 0


mov ebx, ebp
add ebx, 8
mov ebx, [ebx] ; Dereferencing before push [T12 from reference offset 8

add esp, -4
add ebx, 0
mov [esp], ebx ; Pushing reference to [T12 from offset 0

call L1 ; Calling =
add esp, 8

mov esp, ebp
pop ebp

ret

L37: ; Box<Byte>:Box

push ebp
mov ebp, esp

mov esp, ebp
pop ebp

ret

L38: ; Box<Byte>:=

push ebp
mov ebp, esp


mov ebx, ebp
add ebx, 12
mov ebx, [ebx] ; Dereferencing before push [T15 from reference offset 12

add esp, -4
add ebx, 0
mov [esp], ebx ; Pushing reference to [T15 from offset 0


mov ebx, ebp
add ebx, 8
mov ebx, [ebx] ; Dereferencing before push [T14 from reference offset 8

add esp, -4
add ebx, 0
mov [esp], ebx ; Pushing reference to [T14 from offset 0

call L11 ; Calling =
add esp, 8

mov esp, ebp
pop ebp

ret

