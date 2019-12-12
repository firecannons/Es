format ELF executable 3
segment readable executable
entry L29

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

L12: ; Byte:=

push ebp
mov ebp, esp

mov esp, ebp
pop ebp

ret

L13: ; Byte:+

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

L14: ; Byte:-

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

L15: ; Byte:>

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

L16: ; Byte:>=

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

L17: ; Byte:==

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

L18: ; Byte:<

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

L19: ; Byte:<=

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

L20: ; Byte:!=

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

L21: ; Byte:OutputToConsole

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

L22: ; Bool:Bool

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

L23: ; CapTest:CapTest

push ebp
mov ebp, esp

mov esp, ebp
pop ebp

ret

L24: ; CapTest2:CapTest2

push ebp
mov ebp, esp

mov esp, ebp
pop ebp

ret

L25: ; CapTest3:CapTest3

push ebp
mov ebp, esp

mov esp, ebp
pop ebp

ret

L26: ; :OutputByte

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

L27: ; :OutputByte2

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

L28: ; :OutputByte5

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

L29: ; :Main

push ebp
mov ebp, esp

add esp, -4 ; Declaring MyArray
add esp, -4 ; Declaring [T4
mov [esp], 4
add esp, -4
mov ebx, ebp
add ebx, -8
mov [esp], ebx ; Pushing reference to [T4 from offset -8

add esp, -4
mov ebx, ebp
add ebx, -4
mov [esp], ebx ; Pushing reference to MyArray from offset -4

call L33 ; Calling Resize
add esp, 8

mov esp, ebp
pop ebp

ret

L30: ; Pointer<Byte>:Pointer

push ebp
mov ebp, esp

mov esp, ebp
pop ebp

ret

L31: ; Pointer<Byte>:=

push ebp
mov ebp, esp


mov ebx, ebp
add ebx, 12
mov ebx, [ebx] ; Dereferencing before push [T1 from reference offset 12

add esp, -4
add ebx, 0
mov [esp], ebx ; Pushing reference to [T1 from offset 0


mov ebx, ebp
add ebx, 8
mov ebx, [ebx] ; Dereferencing before push [T0 from reference offset 8

add esp, -4
add ebx, 0
mov [esp], ebx ; Pushing reference to [T0 from offset 0

call L1 ; Calling =
add esp, 8

mov esp, ebp
pop ebp

ret

L34: ; DynamicMemory<Byte>:AllocateHeapMemory

        push ebp
        mov ebp, esp
        
        ; Must build the struct in reverse order
        ; offset
        add esp, -4
        mov dword [esp], 0
        
        ; fd
        add esp, -4
        mov dword [esp], -1
        
        ; flags
        add esp, -4
        mov dword [esp], 34
        
        ; prot
        add esp, -4
        mov dword [esp], 3
        
        ; len
        xor ecx, ecx
        mov ebx, ebp
        add ebx, 8
        mov byte cl, [ebx]
        add esp, -4
        mov dword [esp], ecx
        
        ; addr
        add esp, -4
        mov dword [esp], 0
        
        ; call mmap
        mov eax, 90
        mov ebx, esp
        ;lea ebx, [mmap_arg]
        int	0x80
        
        add esp, 24
        
        ;ope:
        ;
        ;push eax
        ;mov byte [eax], 85
        ;add esp, -4
        ;mov [esp], eax
        ;call OutputByte
        ;pop eax
        ;
        ;add esp, 4
        ;
        ;add eax, 1
        ;
        ;jmp ope
        
        ;test eax, eax
        ;jnz cont
        
        ;mov	eax,1
        ;xor	ebx,ebx
        ;int	0x80
        
        ;cont:

        
        ; move new memory location to return position
        mov ebx, ebp
        add ebx, 12
        mov [ebx], eax
        
        mov esp, ebp
        pop ebp
    
ret

L35: ; DynamicMemory<Byte>:DeallocateHeapMemory

        push ebp
        mov ebp, esp
        
        ; len to ecx
        xor ecx, ecx
        mov ebx, ebp
        add ebx, 12
        mov byte cl, [ebx]
        
        ; addr to ebx
        mov ebx, ebp
        add ebx, 8
        mov ebx, [ebx]
        mov ebx, [ebx]
        
        ; call mmap
        mov eax, 90
        mov ebx, esp
        ;lea ebx, [mmap_arg]
        int	0x80
        
        mov esp, ebp
        pop ebp
    
ret

L32: ; Array<Byte>:Array

push ebp
mov ebp, esp

mov esp, ebp
pop ebp

ret

L33: ; Array<Byte>:Resize

push ebp
mov ebp, esp

add esp, 0 ; Declaring DM
add esp, -4 ; Declaring [T3

mov ebx, ebp
add ebx, 12
mov ebx, [ebx] ; Dereferencing before push Size from reference offset 12

add esp, -4
add ebx, 0
mov [esp], ebx ; Pushing reference to Size from offset 0

add esp, -4
mov ebx, ebp
add ebx, 0
mov [esp], ebx ; Pushing reference to DM from offset 0

call L34 ; Calling AllocateHeapMemory
add esp, 8

add esp, -4
mov ebx, ebp
add ebx, -4
mov [esp], ebx ; Pushing reference to [T3 from offset -4


mov ebx, ebp
add ebx, 8
mov ebx, [ebx] ; Dereferencing before push [T2 from reference offset 8

add esp, -4
add ebx, 0
mov [esp], ebx ; Pushing reference to [T2 from offset 0

call L31 ; Calling =
add esp, 8

mov esp, ebp
pop ebp

ret

L36: ; Array<Byte>:GetAt

push ebp
mov ebp, esp

mov esp, ebp
pop ebp

ret

