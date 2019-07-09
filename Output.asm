format ELF executable 3
segment readable executable
entry Main


Bool__On_Create:

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

Integer__On_Create:

push ebp
mov ebp, esp


            
        

mov esp, ebp
pop ebp
ret

Integer__On_Equals:

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

Integer__On_Plus:

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

Integer__On_Minus:

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

Integer__On_Greater_Than:

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
            
            ; move result onto stack
            add ebx, 8
            mov byte [ebx], al
            
        

mov esp, ebp
pop ebp
ret

Integer__On_Greater_Equal:

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
            
            ; move result onto stack
            add ebx, 8
            mov byte [ebx], al
            
        

mov esp, ebp
pop ebp
ret

Integer__On_If_Equal:

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
            
            ; move result onto stack
            add ebx, 8
            mov byte [ebx], al
        

mov esp, ebp
pop ebp
ret

Integer__On_Less_Than:

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

Integer__On_Less_Or_Equal:

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

Integer__On_Not_Equal:

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
            
            ; move result onto stack
            add ebx, 8
            mov byte [ebx], al
            
        

mov esp, ebp
pop ebp
ret

Byte__On_Create:

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

Byte__On_Equals:

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

Byte__On_Plus:

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

Byte__On_Minus:

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

Byte__On_Greater_Than:

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

Byte__On_Greater_Equal:

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

Byte__On_If_Equal:

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

Byte__On_Less_Than:

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

Byte__On_Less_Or_Equal:

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

Byte__On_Not_Equal:

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

Pointer__On_Create:

push ebp
mov ebp, esp




mov esp, ebp
pop ebp
ret

Pointer__On_Equals:

push ebp
mov ebp, esp


add esp, -4
mov ebx, ebp
add ebx, 8
mov ebx, [ebx]
add ebx, 0
mov [esp], ebx
; loading a reference!Me
;Shifting Deref Offset0 = 0 + 0
;Names: Me : Position -> 0
;ok-4
add esp, -4
mov ebx, ebp
add ebx, 12
mov ebx, [ebx]
add ebx, 0
mov [esp], ebx
; loading a reference!Source
;Shifting Deref Offset0 = 0 + 0
;Names: Source : Position -> 0
;ok-8
;Loading [1 -8
add esp, -4
mov ebx, ebp
add ebx, -8
mov ebx, [ebx]
add ebx, 0
mov [esp], ebx
; loading a reference![1
;Loading a Integer object
add esp, -4
mov ebx, ebp
add ebx, -4
mov ebx, [ebx]
add ebx, 0
mov [esp], ebx
; loading a reference![0
call Integer__On_Equals
add esp, 8


mov esp, ebp
pop ebp
ret

CapTest__On_Create:

push ebp
mov ebp, esp




mov esp, ebp
pop ebp
ret

CapTest2__On_Create:

push ebp
mov ebp, esp




mov esp, ebp
pop ebp
ret

CapTest3__On_Create:

push ebp
mov ebp, esp




mov esp, ebp
pop ebp
ret

AllocateHeapMemory:

push ebp
mov ebp, esp


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
    
    test eax, eax
    jnz cont
    
    mov	eax,1
	xor	ebx,ebx
	int	0x80
    
    cont:

    
    ; move new memory location to return position
    mov ebx, ebp
    add ebx, 12
    mov [ebx], eax
    
    ; --- Testing OutputByte ---
    ;mov [esp], eax
    ;mov byte [eax], 122
    ;call OutputByte
    
    mov esp, ebp
    pop ebp


mov esp, ebp
pop ebp
ret

DeallocateHeapMemory:

push ebp
mov ebp, esp


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


mov esp, ebp
pop ebp
ret

OutputByte:

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

OutputByteReference:

push ebp
mov ebp, esp


    ; load a pointer to the byte in ecx
    mov ecx, ebp
    add ecx, 8
    mov ecx, [ecx]
    mov ecx, [ecx]
    
    ; Set other values
    mov	eax, 4
    mov	ebx, 1
	mov	edx, 1
	int	0x80


mov esp, ebp
pop ebp
ret

OutputByte3:

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
    


mov esp, ebp
pop ebp
ret

IndirectionOutput:

push ebp
mov ebp, esp


;Loading L 0
add esp, -4
mov ebx, ebp
add ebx, 8
mov ebx, [ebx]
add ebx, 0
mov [esp], ebx
; loading a reference!L
call OutputByte
add esp, 4


mov esp, ebp
pop ebp
ret

IndirectionAddOutput:

push ebp
mov ebp, esp


add esp, -1

mov byte [esp], 1

;Declaring [2 -1
;Adding return value 
add esp, -1
;Loading [2 -2
add esp, -4
mov ebx, ebp
add ebx, -1
mov [esp], ebx
;Loading a Byte object
add esp, -4
mov ebx, ebp
add ebx, 8
mov ebx, [ebx]
add ebx, 0
mov [esp], ebx
; loading a reference!L
call Byte__On_Plus
add esp, 8
;Loading [3 -2
add esp, -4
mov ebx, ebp
add ebx, -2
mov [esp], ebx
call OutputByte
add esp, 4


mov esp, ebp
pop ebp
ret

IndirectionAddTwoOutput:

push ebp
mov ebp, esp


add esp, -1

mov byte [esp], 2

;Declaring [4 -1
;Adding return value 
add esp, -1
;Loading [4 -2
add esp, -4
mov ebx, ebp
add ebx, -1
mov [esp], ebx
;Loading a Byte object
add esp, -4
mov ebx, ebp
add ebx, 8
mov ebx, [ebx]
add ebx, 0
mov [esp], ebx
; loading a reference!L
call Byte__On_Plus
add esp, 8
;Loading [5 -2
add esp, -4
mov ebx, ebp
add ebx, -2
mov [esp], ebx
call OutputByte
add esp, 4


mov esp, ebp
pop ebp
ret

OutputByte2:

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

ClassScopeTest__On_Create:

push ebp
mov ebp, esp


add esp, -4
mov ebx, ebp
add ebx, 8
mov ebx, [ebx]
add ebx, 0
mov [esp], ebx
; loading a reference!Me
;Shifting Deref Offset0 = 0 + 0
;Names: Me : B2 -> 0
;ok-4
add esp, -1

mov byte [esp], 65

;Declaring [7 -5
;Loading [7 -5
add esp, -4
mov ebx, ebp
add ebx, -5
mov [esp], ebx
;Loading a Byte object
add esp, -4
mov ebx, ebp
add ebx, -4
mov ebx, [ebx]
add ebx, 0
mov [esp], ebx
; loading a reference![6
call Byte__On_Equals
add esp, 8


mov esp, ebp
pop ebp
ret

ClassScopeTest__RunTest:

push ebp
mov ebp, esp


;Declaring B1 -1
add esp, -1

add esp, -4
mov ebx, ebp
add ebx, -1
mov [esp], ebx
call Byte__On_Create
add esp, 4
add esp, -1

mov byte [esp], 5

;Declaring [8 -2
;Loading [8 -2
add esp, -4
mov ebx, ebp
add ebx, -2
mov [esp], ebx
;Loading a Byte object
add esp, -4
mov ebx, ebp
add ebx, -1
mov [esp], ebx
call Byte__On_Equals
add esp, 8
add esp, -4
mov ebx, ebp
add ebx, 8
mov ebx, [ebx]
add ebx, 0
mov [esp], ebx
; loading a reference!Me
;Shifting Deref Offset0 = 0 + 0
;Names: Me : B2 -> 0
;ok-6
add esp, -1

mov byte [esp], 66

;Declaring [10 -7
;Loading [10 -7
add esp, -4
mov ebx, ebp
add ebx, -7
mov [esp], ebx
;Loading a Byte object
add esp, -4
mov ebx, ebp
add ebx, -6
mov ebx, [ebx]
add ebx, 0
mov [esp], ebx
; loading a reference![9
call Byte__On_Equals
add esp, 8


mov esp, ebp
pop ebp
ret

ClassScopeTestTwo__On_Create:

push ebp
mov ebp, esp


add esp, -4
mov ebx, ebp
add ebx, 8
mov ebx, [ebx]
add ebx, 0
mov [esp], ebx
; loading a reference!Me
;Shifting Deref Offset0 = 0 + 0
;Names: Me : C1 -> 0
;ok-4
;Shifting Deref Offset1 = 0 + 1
;Names: [11 : B2 -> 1
;ok-4
add esp, -1

mov byte [esp], 68

;Declaring [13 -5
;Loading [13 -5
add esp, -4
mov ebx, ebp
add ebx, -5
mov [esp], ebx
;Loading a Byte object
add esp, -4
mov ebx, ebp
add ebx, -4
mov ebx, [ebx]
add ebx, 1
mov [esp], ebx
; loading a reference![12
call Byte__On_Equals
add esp, 8


mov esp, ebp
pop ebp
ret

ClassScopeTestTwo__RunTest:

push ebp
mov ebp, esp


add esp, -4
mov ebx, ebp
add ebx, 8
mov ebx, [ebx]
add ebx, 0
mov [esp], ebx
; loading a reference!Me
;Shifting Deref Offset0 = 0 + 0
;Names: Me : C1 -> 0
;ok-4
;Shifting Deref Offset1 = 0 + 1
;Names: [14 : B2 -> 1
;ok-4
add esp, -1

mov byte [esp], 72

;Declaring [16 -5
;Loading [16 -5
add esp, -4
mov ebx, ebp
add ebx, -5
mov [esp], ebx
;Loading a Byte object
add esp, -4
mov ebx, ebp
add ebx, -4
mov ebx, [ebx]
add ebx, 1
mov [esp], ebx
; loading a reference![15
call Byte__On_Equals
add esp, 8


mov esp, ebp
pop ebp
ret

NoParamTest:

push ebp
mov ebp, esp




mov esp, ebp
pop ebp
ret

DoubleMethodTest__On_Create:

push ebp
mov ebp, esp




mov esp, ebp
pop ebp
ret

DoubleMethodTest__Method1:

push ebp
mov ebp, esp


add esp, -1

mov byte [esp], 82

;Declaring [17 -1
;Loading [17 -1
add esp, -4
mov ebx, ebp
add ebx, -1
mov [esp], ebx
call OutputByte
add esp, 4


mov esp, ebp
pop ebp
ret

DoubleMethodTest__Method2:

push ebp
mov ebp, esp


;Loading a DoubleMethodTest object
add esp, -4
mov ebx, ebp
add ebx, 8
mov ebx, [ebx]
add ebx, 0
mov [esp], ebx
; loading a reference!Me
call DoubleMethodTest__Method1
add esp, 4


mov esp, ebp
pop ebp
ret

ReturnTest:

push ebp
mov ebp, esp


;Declaring B -1
add esp, -1

add esp, -4
mov ebx, ebp
add ebx, -1
mov [esp], ebx
call Byte__On_Create
add esp, 4
add esp, -1

mov byte [esp], 70

;Declaring [18 -2
;Loading [18 -2
add esp, -4
mov ebx, ebp
add ebx, -2
mov [esp], ebx
;Loading a Byte object
add esp, -4
mov ebx, ebp
add ebx, -1
mov [esp], ebx
call Byte__On_Equals
add esp, 8
add esp, -4
mov ebx, ebp
add ebx, -1
mov [esp], ebx
add esp, -4
mov ebx, ebp
add ebx, 8
mov [esp], ebx
call Byte__On_Equals
add esp, 4


mov esp, ebp
pop ebp
ret

RetTestCls__On_Create:

push ebp
mov ebp, esp




mov esp, ebp
pop ebp
ret

RetTestCls__RetTe:

push ebp
mov ebp, esp


;Declaring B -1
add esp, -1

add esp, -4
mov ebx, ebp
add ebx, -1
mov [esp], ebx
call Byte__On_Create
add esp, 4
add esp, -1

mov byte [esp], 66

;Declaring [19 -2
;Loading [19 -2
add esp, -4
mov ebx, ebp
add ebx, -2
mov [esp], ebx
;Loading a Byte object
add esp, -4
mov ebx, ebp
add ebx, -1
mov [esp], ebx
call Byte__On_Equals
add esp, 8
add esp, -4
mov ebx, ebp
add ebx, -1
mov [esp], ebx
add esp, -4
mov ebx, ebp
add ebx, 16
mov [esp], ebx
call Byte__On_Equals
add esp, 4


mov esp, ebp
pop ebp
ret

ReturnTest2:

push ebp
mov ebp, esp


;Declaring B -1
add esp, -1

add esp, -4
mov ebx, ebp
add ebx, -1
mov [esp], ebx
call Byte__On_Create
add esp, 4
;Loading B2 -1
add esp, -4
mov ebx, ebp
add ebx, 8
mov ebx, [ebx]
add ebx, 0
mov [esp], ebx
; loading a reference!B2
;Loading a Byte object
add esp, -4
mov ebx, ebp
add ebx, -1
mov [esp], ebx
call Byte__On_Equals
add esp, 8
add esp, -4
mov ebx, ebp
add ebx, -1
mov [esp], ebx
add esp, -4
mov ebx, ebp
add ebx, 12
mov [esp], ebx
call Byte__On_Equals
add esp, 4


mov esp, ebp
pop ebp
ret

OutputByte5:

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

SetByteInDynam:

push ebp
mov ebp, esp


    ; load DP into edx
    mov ebx, ebp
    add ebx, 8
    mov ecx, [ebx]
        
    ; load Position into edx
    mov edx, ebp
    add edx, 12
    mov edx, [edx]
    mov byte dl, [edx]
    
    ; Perform arithmetic to find correct memory position into ebx
    mov eax, 1
    mul dl
    add ecx, eax
    
    ; Load the return position
    mov ebx, ebp
    add ebx, 16
    mov ebx, [ebx]
    add esp, -4
    mov [esp], ebx
    
    ; Load the ebx position onto the stack
    add esp, -4
    mov [esp], ecx
    
    call Byte__On_Equals
    
    ; Move the stack pointer back up
    add esp, 8


mov esp, ebp
pop ebp
ret

SetFirstByteInDynam:

push ebp
mov ebp, esp


    ; load DP into edx
    mov ebx, ebp
    add ebx, 8
    mov ebx, [ebx]
    
    mov byte [ebx], 86
    
    add esp, -4
    mov [esp], ebx
    call OutputByte
    add esp, 4
    
    ; Move the stack pointer back up
    add esp, 8


mov esp, ebp
pop ebp
ret

GetFirstByteInDynam:

push ebp
mov ebp, esp


    ; load DP into edx
    mov ebx, ebp
    add ebx, 8
    mov ebx, [ebx]
    
    add esp, -4
    mov [esp], ebx
    call OutputByte
    add esp, 4
    
    ; Move the stack pointer back up
    add esp, 8


mov esp, ebp
pop ebp
ret

GetPointerPart:

push ebp
mov ebp, esp


    ; load I into ebx
    mov ebx, ebp
    add ebx, 8
    mov ebx, [ebx]
    mov ebx, ebx
    
    ; load Index into ecx
    xor ecx, ecx
    mov eax, ebp
    add eax, 12
    mov eax, [eax]
    mov byte cl, [eax]
    
    ; Do shifting arithmetic
    mov byte dl, 7
    sub byte dl, cl
    xor eax, eax
    mov byte al, dl
    mov dl, 4
    mul dl
    
    ; Do shift
    mov cl, al
    shr ebx, cl
    
    ; Perform modulus by 16 to get lower 4 bits and edx has the remainder
    xor edx, edx
    mov eax, ebx
    mov ebx, 16
    div ebx
    
    ; Move result in bl into return location
    mov eax, ebp
    add eax, 16
    mov [eax], dl
    


mov esp, ebp
pop ebp
ret

OutputAsHex:

push ebp
mov ebp, esp


;Declaring NewByte -1
add esp, -1

add esp, -4
mov ebx, ebp
add ebx, -1
mov [esp], ebx
call Byte__On_Create
add esp, 4
;Loading InByte -1
add esp, -4
mov ebx, ebp
add ebx, 8
mov ebx, [ebx]
add ebx, 0
mov [esp], ebx
; loading a reference!InByte
;Loading a Byte object
add esp, -4
mov ebx, ebp
add ebx, -1
mov [esp], ebx
call Byte__On_Equals
add esp, 8
add esp, -1

mov byte [esp], 10

;Declaring [20 -2
;Adding return value 
add esp, -1
;Loading [20 -3
add esp, -4
mov ebx, ebp
add ebx, -2
mov [esp], ebx
;Loading a Byte object
add esp, -4
mov ebx, ebp
add ebx, -1
mov [esp], ebx
call Byte__On_Less_Than
add esp, 8
mov byte cl, [esp]
test cl, cl
je S0

add esp, -1

mov byte [esp], 48

;Declaring [22 -4
;Adding return value 
add esp, -1
;Loading [22 -5
add esp, -4
mov ebx, ebp
add ebx, -4
mov [esp], ebx
;Loading a Byte object
add esp, -4
mov ebx, ebp
add ebx, -1
mov [esp], ebx
call Byte__On_Plus
add esp, 8
;Loading [23 -5
add esp, -4
mov ebx, ebp
add ebx, -5
mov [esp], ebx
;Loading a Byte object
add esp, -4
mov ebx, ebp
add ebx, -1
mov [esp], ebx
call Byte__On_Equals
add esp, 8
add esp, 4
jmp S1
S0:
add esp, 2
add esp, -1

mov byte [esp], 55

;Declaring [24 -2
;Adding return value 
add esp, -1
;Loading [24 -3
add esp, -4
mov ebx, ebp
add ebx, -2
mov [esp], ebx
;Loading a Byte object
add esp, -4
mov ebx, ebp
add ebx, -1
mov [esp], ebx
call Byte__On_Plus
add esp, 8
;Loading [25 -3
add esp, -4
mov ebx, ebp
add ebx, -3
mov [esp], ebx
;Loading a Byte object
add esp, -4
mov ebx, ebp
add ebx, -1
mov [esp], ebx
call Byte__On_Equals
add esp, 8
add esp, 2
jmp S1
S2:
add esp, 0
S1:
;Loading NewByte -1
add esp, -4
mov ebx, ebp
add ebx, -1
mov [esp], ebx
call OutputByte
add esp, 4


mov esp, ebp
pop ebp
ret

PrintPointer:

push ebp
mov ebp, esp


add esp, -1

mov byte [esp], 48

;Declaring [26 -1
;Loading [26 -1
add esp, -4
mov ebx, ebp
add ebx, -1
mov [esp], ebx
call OutputByte
add esp, 4
add esp, -1

mov byte [esp], 120

;Declaring [27 -2
;Loading [27 -2
add esp, -4
mov ebx, ebp
add ebx, -2
mov [esp], ebx
call OutputByte
add esp, 4
;Declaring Index -3
add esp, -1

add esp, -4
mov ebx, ebp
add ebx, -3
mov [esp], ebx
call Byte__On_Create
add esp, 4
add esp, -1

mov byte [esp], 0

;Declaring [28 -4
;Loading [28 -4
add esp, -4
mov ebx, ebp
add ebx, -4
mov [esp], ebx
;Loading a Byte object
add esp, -4
mov ebx, ebp
add ebx, -3
mov [esp], ebx
call Byte__On_Equals
add esp, 8
S3:
add esp, -1

mov byte [esp], 8

;Declaring [29 -5
;Adding return value 
add esp, -1
;Loading [29 -6
add esp, -4
mov ebx, ebp
add ebx, -5
mov [esp], ebx
;Loading a Byte object
add esp, -4
mov ebx, ebp
add ebx, -3
mov [esp], ebx
call Byte__On_Less_Than
add esp, 8
mov byte cl, [esp]
test cl, cl
je S4

;Declaring TempByte -7
add esp, -1

add esp, -4
mov ebx, ebp
add ebx, -7
mov [esp], ebx
call Byte__On_Create
add esp, 4
;Adding return value 
add esp, -1
;Loading Index -8
add esp, -4
mov ebx, ebp
add ebx, -3
mov [esp], ebx
;Loading I -12
add esp, -4
mov ebx, ebp
add ebx, 8
mov ebx, [ebx]
add ebx, 0
mov [esp], ebx
; loading a reference!I
call GetPointerPart
add esp, 8
;Loading [31 -8
add esp, -4
mov ebx, ebp
add ebx, -8
mov [esp], ebx
;Loading a Byte object
add esp, -4
mov ebx, ebp
add ebx, -7
mov [esp], ebx
call Byte__On_Equals
add esp, 8
;Loading TempByte -8
add esp, -4
mov ebx, ebp
add ebx, -7
mov [esp], ebx
call OutputAsHex
add esp, 4
add esp, -1

mov byte [esp], 1

;Declaring [32 -9
;Adding return value 
add esp, -1
;Loading [32 -10
add esp, -4
mov ebx, ebp
add ebx, -9
mov [esp], ebx
;Loading a Byte object
add esp, -4
mov ebx, ebp
add ebx, -3
mov [esp], ebx
call Byte__On_Plus
add esp, 8
;Loading [33 -10
add esp, -4
mov ebx, ebp
add ebx, -10
mov [esp], ebx
;Loading a Byte object
add esp, -4
mov ebx, ebp
add ebx, -3
mov [esp], ebx
call Byte__On_Equals
add esp, 8
add esp, 6
jmp S3
S4:
add esp, 2


mov esp, ebp
pop ebp
ret

TemplateTest__Byte__On_Create:

push ebp
mov ebp, esp


add esp, -4
mov ebx, ebp
add ebx, 8
mov ebx, [ebx]
add ebx, 0
mov [esp], ebx
; loading a reference!Me
;Shifting Deref Offset0 = 0 + 0
;Names: Me : MyT -> 0
;ok-4
add esp, -1

mov byte [esp], 67

;Declaring [280 -5
;Loading [280 -5
add esp, -4
mov ebx, ebp
add ebx, -5
mov [esp], ebx
;Loading a Byte object
add esp, -4
mov ebx, ebp
add ebx, -4
mov ebx, [ebx]
add ebx, 0
mov [esp], ebx
; loading a reference![279
call Byte__On_Equals
add esp, 8
add esp, -4
mov ebx, ebp
add ebx, 8
mov ebx, [ebx]
add ebx, 0
mov [esp], ebx
; loading a reference!Me
;Shifting Deref Offset0 = 0 + 0
;Names: Me : MyT -> 0
;ok-9
;Loading [281 -9
add esp, -4
mov ebx, ebp
add ebx, -9
mov ebx, [ebx]
add ebx, 0
mov [esp], ebx
; loading a reference![281
call OutputByte
add esp, 4


mov esp, ebp
pop ebp
ret

MultiTemplateTest__Byte__Byte__Integer__On_Create:

push ebp
mov ebp, esp


add esp, -4
mov ebx, ebp
add ebx, 8
mov ebx, [ebx]
add ebx, 0
mov [esp], ebx
; loading a reference!Me
;Shifting Deref Offset0 = 0 + 0
;Names: Me : MyT -> 0
;ok-4
add esp, -1

mov byte [esp], 67

;Declaring [283 -5
;Loading [283 -5
add esp, -4
mov ebx, ebp
add ebx, -5
mov [esp], ebx
;Loading a Byte object
add esp, -4
mov ebx, ebp
add ebx, -4
mov ebx, [ebx]
add ebx, 0
mov [esp], ebx
; loading a reference![282
call Byte__On_Equals
add esp, 8
add esp, -4
mov ebx, ebp
add ebx, 8
mov ebx, [ebx]
add ebx, 0
mov [esp], ebx
; loading a reference!Me
;Shifting Deref Offset1 = 0 + 1
;Names: Me : MyT2 -> 1
;ok-9
add esp, -1

mov byte [esp], 68

;Declaring [285 -10
;Loading [285 -10
add esp, -4
mov ebx, ebp
add ebx, -10
mov [esp], ebx
;Loading a Byte object
add esp, -4
mov ebx, ebp
add ebx, -9
mov ebx, [ebx]
add ebx, 1
mov [esp], ebx
; loading a reference![284
call Byte__On_Equals
add esp, 8
add esp, -4
mov ebx, ebp
add ebx, 8
mov ebx, [ebx]
add ebx, 0
mov [esp], ebx
; loading a reference!Me
;Shifting Deref Offset1 = 0 + 1
;Names: Me : MyT2 -> 1
;ok-14
;Loading [286 -14
add esp, -4
mov ebx, ebp
add ebx, -14
mov ebx, [ebx]
add ebx, 1
mov [esp], ebx
; loading a reference![286
call OutputByte
add esp, 4


mov esp, ebp
pop ebp
ret

RefTemplateTest__Byte__Byte__Integer__On_Create:

push ebp
mov ebp, esp


add esp, -4
mov ebx, ebp
add ebx, 8
mov ebx, [ebx]
add ebx, 0
mov [esp], ebx
; loading a reference!Me
;Shifting Deref Offset0 = 0 + 0
;Names: Me : MyT -> 0
;ok-4
add esp, -1

mov byte [esp], 67

;Declaring [288 -5
;Loading [288 -5
add esp, -4
mov ebx, ebp
add ebx, -5
mov [esp], ebx
;Loading a Byte object
add esp, -4
mov ebx, ebp
add ebx, -4
mov ebx, [ebx]
add ebx, 0
mov [esp], ebx
; loading a reference![287
call Byte__On_Equals
add esp, 8
add esp, -4
mov ebx, ebp
add ebx, 8
mov ebx, [ebx]
add ebx, 0
mov [esp], ebx
; loading a reference!Me
;Shifting Deref Offset1 = 0 + 1
;Names: Me : MyT2 -> 1
;ok-9
add esp, -1

mov byte [esp], 68

;Declaring [290 -10
;Loading [290 -10
add esp, -4
mov ebx, ebp
add ebx, -10
mov [esp], ebx
;Loading a Byte object
add esp, -4
mov ebx, ebp
add ebx, -9
mov ebx, [ebx]
add ebx, 1
mov [esp], ebx
; loading a reference![289
call Byte__On_Equals
add esp, 8
add esp, -4
mov ebx, ebp
add ebx, 8
mov ebx, [ebx]
add ebx, 0
mov [esp], ebx
; loading a reference!Me
;Shifting Deref Offset1 = 0 + 1
;Names: Me : MyT2 -> 1
;ok-14
;Loading [291 -14
add esp, -4
mov ebx, ebp
add ebx, -14
mov ebx, [ebx]
add ebx, 1
mov [esp], ebx
; loading a reference![291
call OutputByte
add esp, 4


mov esp, ebp
pop ebp
ret

Array__Byte__On_Create:

push ebp
mov ebp, esp


add esp, -4
mov ebx, ebp
add ebx, 8
mov ebx, [ebx]
add ebx, 0
mov [esp], ebx
; loading a reference!Me
;Shifting Deref Offset0 = 0 + 0
;Names: Me : Size -> 0
;ok-4
add esp, -1

mov byte [esp], 0

;Declaring [294 -5
;Loading [294 -5
add esp, -4
mov ebx, ebp
add ebx, -5
mov [esp], ebx
;Loading a Byte object
add esp, -4
mov ebx, ebp
add ebx, -4
mov ebx, [ebx]
add ebx, 0
mov [esp], ebx
; loading a reference![293
call Byte__On_Equals
add esp, 8
add esp, -4
mov ebx, ebp
add ebx, 8
mov ebx, [ebx]
add ebx, 0
mov [esp], ebx
; loading a reference!Me
;Shifting Deref Offset5 = 0 + 5
;Names: Me : MemorySize -> 5
;ok-9
add esp, -1

mov byte [esp], 0

;Declaring [296 -10
;Loading [296 -10
add esp, -4
mov ebx, ebp
add ebx, -10
mov [esp], ebx
;Loading a Byte object
add esp, -4
mov ebx, ebp
add ebx, -9
mov ebx, [ebx]
add ebx, 5
mov [esp], ebx
; loading a reference![295
call Byte__On_Equals
add esp, 8
add esp, -4
mov ebx, ebp
add ebx, 8
mov ebx, [ebx]
add ebx, 0
mov [esp], ebx
; loading a reference!Me
;Shifting Deref Offset1 = 0 + 1
;Names: Me : DP -> 1
;ok-14
add esp, -4
mov ebx, ebp
add ebx, 8
mov ebx, [ebx]
add ebx, 0
mov [esp], ebx
; loading a reference!Me
;Shifting Deref Offset5 = 0 + 5
;Names: Me : MemorySize -> 5
;ok-18
;Adding return value 
add esp, -4
;Loading [298 -22
add esp, -4
mov ebx, ebp
add ebx, -18
mov ebx, [ebx]
add ebx, 5
mov [esp], ebx
; loading a reference![298
call AllocateHeapMemory
add esp, 4
;Loading [299 -22
add esp, -4
mov ebx, ebp
add ebx, -22
mov [esp], ebx
;Loading a Pointer object
add esp, -4
mov ebx, ebp
add ebx, -14
mov ebx, [ebx]
add ebx, 1
mov [esp], ebx
; loading a reference![297
call Pointer__On_Equals
add esp, 8


mov esp, ebp
pop ebp
ret

Array__Byte__SetAt:

push ebp
mov ebp, esp


        ; load DP into edx
        mov ebx, ebp
        add ebx, 8
        mov ebx, [ebx]
        add ebx, 1
        mov ecx, ebx
        
        mov byte [ecx], 85
        
        ;push ecx
        ;add esp, -4
        ;mov [esp], ecx
        ;call OutputByte
        ;add esp, 4
        ;pop ecx
        
        ; load Position into edx
        mov edx, ebp
        add edx, 12
        mov edx, [edx]
        mov byte dl, [edx]
        
        ; Perform arithmetic to find correct memory position into ebx
        mov eax, 1
        mul dl
        add ecx, eax
        
        ;push ecx
        ;add esp, -4
        ;mov [esp], ebx
        ;call OutputByte
        ;add esp, 4
        ;pop ecx
        
        
        ; Load the ebx position onto the stack
        mov ebx, ebp
        add ebx, 16
        mov ebx, [ebx]
        add esp, -4
        mov [esp], ebx
        
        ; Load the ebx position onto the stack
        add esp, -4
        mov [esp], ecx
        call Byte__On_Equals
        
        ; Move the stack pointer back up
        add esp, 8
        
        ;push ecx
        ;add esp, -4
        ;mov [esp], ebx
        ;call OutputByte
        ;add esp, 4
        ;pop ecx
        
    

mov esp, ebp
pop ebp
ret

Array__Byte__GetAt:

push ebp
mov ebp, esp


        ; load DP into edx
        mov ebx, ebp
        add ebx, 8
        mov ebx, [ebx]
        add ebx, 1
        mov ecx, ebx
        
        ;add esp, -4
        ;mov [esp], ecx
        ;call OutputByte
        ;add esp, 4
        
        ; load Position into edx
        mov edx, ebp
        add edx, 12
        mov edx, [edx]
        mov byte dl, [edx]
        
        ; Perform arithmetic to find correct memory position into ebx
        mov eax, 1
        mul dl
        add ecx, eax
        
        ;add esp, -4
        ;mov [esp], ecx
        ;call OutputByte
        ;add esp, 4
        
        ; Load the ebx position onto the stack
        add esp, -4
        mov [esp], ecx
        
        ; Load the return position
        mov ebx, ebp
        add ebx, 16
        add esp, -4
        mov [esp], ebx
        
        call Byte__On_Equals
        
        ; Move the stack pointer back up
        add esp, 8
        
        
    

mov esp, ebp
pop ebp
ret

Array__Byte__Append:

push ebp
mov ebp, esp


;Declaring testy -1
add esp, -1

add esp, -4
mov ebx, ebp
add ebx, -1
mov [esp], ebx
call Byte__On_Create
add esp, 4
add esp, -1

mov byte [esp], 70

;Declaring [300 -2
;Loading [300 -2
add esp, -4
mov ebx, ebp
add ebx, -2
mov [esp], ebx
;Loading a Byte object
add esp, -4
mov ebx, ebp
add ebx, -1
mov [esp], ebx
call Byte__On_Equals
add esp, 8
;Loading testy -2
add esp, -4
mov ebx, ebp
add ebx, -1
mov [esp], ebx
call OutputByte
add esp, 4
;Loading testy -2
add esp, -4
mov ebx, ebp
add ebx, -1
mov [esp], ebx
call OutputByte
add esp, 4
add esp, -4
mov ebx, ebp
add ebx, 8
mov ebx, [ebx]
add ebx, 0
mov [esp], ebx
; loading a reference!Me
;Shifting Deref Offset0 = 0 + 0
;Names: Me : Size -> 0
;ok-6
add esp, -4
mov ebx, ebp
add ebx, 8
mov ebx, [ebx]
add ebx, 0
mov [esp], ebx
; loading a reference!Me
;Shifting Deref Offset0 = 0 + 0
;Names: Me : Size -> 0
;ok-10
add esp, -1

mov byte [esp], 1

;Declaring [303 -11
;Adding return value 
add esp, -1
;Loading [303 -12
add esp, -4
mov ebx, ebp
add ebx, -11
mov [esp], ebx
;Loading a Byte object
add esp, -4
mov ebx, ebp
add ebx, -10
mov ebx, [ebx]
add ebx, 0
mov [esp], ebx
; loading a reference![302
call Byte__On_Plus
add esp, 8
;Loading [304 -12
add esp, -4
mov ebx, ebp
add ebx, -12
mov [esp], ebx
;Loading a Byte object
add esp, -4
mov ebx, ebp
add ebx, -6
mov ebx, [ebx]
add ebx, 0
mov [esp], ebx
; loading a reference![301
call Byte__On_Equals
add esp, 8
add esp, -4
mov ebx, ebp
add ebx, 8
mov ebx, [ebx]
add ebx, 0
mov [esp], ebx
; loading a reference!Me
;Shifting Deref Offset0 = 0 + 0
;Names: Me : Size -> 0
;ok-16
add esp, -1

mov byte [esp], 65

;Declaring [306 -17
;Adding return value 
add esp, -1
;Loading [306 -18
add esp, -4
mov ebx, ebp
add ebx, -17
mov [esp], ebx
;Loading a Byte object
add esp, -4
mov ebx, ebp
add ebx, -16
mov ebx, [ebx]
add ebx, 0
mov [esp], ebx
; loading a reference![305
call Byte__On_Plus
add esp, 8
;Loading [307 -18
add esp, -4
mov ebx, ebp
add ebx, -18
mov [esp], ebx
call OutputByte
add esp, 4
add esp, -4
mov ebx, ebp
add ebx, 8
mov ebx, [ebx]
add ebx, 0
mov [esp], ebx
; loading a reference!Me
;Shifting Deref Offset0 = 0 + 0
;Names: Me : Size -> 0
;ok-22
add esp, -4
mov ebx, ebp
add ebx, 8
mov ebx, [ebx]
add ebx, 0
mov [esp], ebx
; loading a reference!Me
;Shifting Deref Offset5 = 0 + 5
;Names: Me : MemorySize -> 5
;ok-26
;Adding return value 
add esp, -1
;Loading [309 -27
add esp, -4
mov ebx, ebp
add ebx, -26
mov ebx, [ebx]
add ebx, 5
mov [esp], ebx
; loading a reference![309
;Loading a Byte object
add esp, -4
mov ebx, ebp
add ebx, -22
mov ebx, [ebx]
add ebx, 0
mov [esp], ebx
; loading a reference![308
call Byte__On_Greater_Than
add esp, 8
mov byte cl, [esp]
test cl, cl
je S33

add esp, -4
mov ebx, ebp
add ebx, 8
mov ebx, [ebx]
add ebx, 0
mov [esp], ebx
; loading a reference!Me
;Shifting Deref Offset5 = 0 + 5
;Names: Me : MemorySize -> 5
;ok-31
add esp, -4
mov ebx, ebp
add ebx, 8
mov ebx, [ebx]
add ebx, 0
mov [esp], ebx
; loading a reference!Me
;Shifting Deref Offset0 = 0 + 0
;Names: Me : Size -> 0
;ok-35
;Loading [312 -35
add esp, -4
mov ebx, ebp
add ebx, -35
mov ebx, [ebx]
add ebx, 0
mov [esp], ebx
; loading a reference![312
;Loading a Byte object
add esp, -4
mov ebx, ebp
add ebx, -31
mov ebx, [ebx]
add ebx, 5
mov [esp], ebx
; loading a reference![311
call Byte__On_Equals
add esp, 8
add esp, -4
mov ebx, ebp
add ebx, 8
mov ebx, [ebx]
add ebx, 0
mov [esp], ebx
; loading a reference!Me
;Shifting Deref Offset1 = 0 + 1
;Names: Me : DP -> 1
;ok-39
add esp, -4
mov ebx, ebp
add ebx, 8
mov ebx, [ebx]
add ebx, 0
mov [esp], ebx
; loading a reference!Me
;Shifting Deref Offset5 = 0 + 5
;Names: Me : MemorySize -> 5
;ok-43
;Adding return value 
add esp, -4
;Loading [314 -47
add esp, -4
mov ebx, ebp
add ebx, -43
mov ebx, [ebx]
add ebx, 5
mov [esp], ebx
; loading a reference![314
call AllocateHeapMemory
add esp, 4
;Loading [315 -47
add esp, -4
mov ebx, ebp
add ebx, -47
mov [esp], ebx
;Loading a Pointer object
add esp, -4
mov ebx, ebp
add ebx, -39
mov ebx, [ebx]
add ebx, 1
mov [esp], ebx
; loading a reference![313
call Pointer__On_Equals
add esp, 8
add esp, 29
jmp S34
S33:
add esp, 9
S34:
;Declaring NewSize -19
add esp, -1

add esp, -4
mov ebx, ebp
add ebx, -19
mov [esp], ebx
call Byte__On_Create
add esp, 4
add esp, -4
mov ebx, ebp
add ebx, 8
mov ebx, [ebx]
add ebx, 0
mov [esp], ebx
; loading a reference!Me
;Shifting Deref Offset0 = 0 + 0
;Names: Me : Size -> 0
;ok-23
add esp, -1

mov byte [esp], 1

;Declaring [317 -24
;Adding return value 
add esp, -1
;Loading [317 -25
add esp, -4
mov ebx, ebp
add ebx, -24
mov [esp], ebx
;Loading a Byte object
add esp, -4
mov ebx, ebp
add ebx, -23
mov ebx, [ebx]
add ebx, 0
mov [esp], ebx
; loading a reference![316
call Byte__On_Minus
add esp, 8
;Loading [318 -25
add esp, -4
mov ebx, ebp
add ebx, -25
mov [esp], ebx
;Loading a Byte object
add esp, -4
mov ebx, ebp
add ebx, -19
mov [esp], ebx
call Byte__On_Equals
add esp, 8
;Declaring PrintSize -26
add esp, -1

add esp, -4
mov ebx, ebp
add ebx, -26
mov [esp], ebx
call Byte__On_Create
add esp, 4
add esp, -1

mov byte [esp], 65

;Declaring [319 -27
;Adding return value 
add esp, -1
;Loading [319 -28
add esp, -4
mov ebx, ebp
add ebx, -27
mov [esp], ebx
;Loading a Byte object
add esp, -4
mov ebx, ebp
add ebx, -19
mov [esp], ebx
call Byte__On_Plus
add esp, 8
;Loading [320 -28
add esp, -4
mov ebx, ebp
add ebx, -28
mov [esp], ebx
;Loading a Byte object
add esp, -4
mov ebx, ebp
add ebx, -26
mov [esp], ebx
call Byte__On_Equals
add esp, 8
;Loading NewElem -28
add esp, -4
mov ebx, ebp
add ebx, 12
mov ebx, [ebx]
add ebx, 0
mov [esp], ebx
; loading a reference!NewElem
;Loading NewSize -32
add esp, -4
mov ebx, ebp
add ebx, -19
mov [esp], ebx
;Loading a Array object
add esp, -4
mov ebx, ebp
add ebx, 8
mov ebx, [ebx]
add ebx, 0
mov [esp], ebx
; loading a reference!Me
call Array__Byte__SetAt
add esp, 12


mov esp, ebp
pop ebp
ret

Array__Byte__Resize:

push ebp
mov ebp, esp


add esp, -4
mov ebx, ebp
add ebx, 8
mov ebx, [ebx]
add ebx, 0
mov [esp], ebx
; loading a reference!Me
;Shifting Deref Offset0 = 0 + 0
;Names: Me : Size -> 0
;ok-4
;Loading Size -4
add esp, -4
mov ebx, ebp
add ebx, 12
mov ebx, [ebx]
add ebx, 0
mov [esp], ebx
; loading a reference!Size
;Loading a Byte object
add esp, -4
mov ebx, ebp
add ebx, -4
mov ebx, [ebx]
add ebx, 0
mov [esp], ebx
; loading a reference![321
call Byte__On_Equals
add esp, 8
add esp, -4
mov ebx, ebp
add ebx, 8
mov ebx, [ebx]
add ebx, 0
mov [esp], ebx
; loading a reference!Me
;Shifting Deref Offset5 = 0 + 5
;Names: Me : MemorySize -> 5
;ok-8
;Loading Size -8
add esp, -4
mov ebx, ebp
add ebx, 12
mov ebx, [ebx]
add ebx, 0
mov [esp], ebx
; loading a reference!Size
;Loading a Byte object
add esp, -4
mov ebx, ebp
add ebx, -8
mov ebx, [ebx]
add ebx, 5
mov [esp], ebx
; loading a reference![322
call Byte__On_Equals
add esp, 8
add esp, -4
mov ebx, ebp
add ebx, 8
mov ebx, [ebx]
add ebx, 0
mov [esp], ebx
; loading a reference!Me
;Shifting Deref Offset1 = 0 + 1
;Names: Me : DP -> 1
;ok-12
add esp, -4
mov ebx, ebp
add ebx, 8
mov ebx, [ebx]
add ebx, 0
mov [esp], ebx
; loading a reference!Me
;Shifting Deref Offset5 = 0 + 5
;Names: Me : MemorySize -> 5
;ok-16
;Adding return value 
add esp, -4
;Loading [324 -20
add esp, -4
mov ebx, ebp
add ebx, -16
mov ebx, [ebx]
add ebx, 5
mov [esp], ebx
; loading a reference![324
call AllocateHeapMemory
add esp, 4
;Loading [325 -20
add esp, -4
mov ebx, ebp
add ebx, -20
mov [esp], ebx
;Loading a Pointer object
add esp, -4
mov ebx, ebp
add ebx, -12
mov ebx, [ebx]
add ebx, 1
mov [esp], ebx
; loading a reference![323
call Pointer__On_Equals
add esp, 8
;Declaring B -21
add esp, -1

add esp, -4
mov ebx, ebp
add ebx, -21
mov [esp], ebx
call Byte__On_Create
add esp, 4
add esp, -1

mov byte [esp], 0

;Declaring [326 -22
;Loading [326 -22
add esp, -4
mov ebx, ebp
add ebx, -22
mov [esp], ebx
;Loading a Byte object
add esp, -4
mov ebx, ebp
add ebx, -21
mov [esp], ebx
call Byte__On_Equals
add esp, 8
add esp, -1

mov byte [esp], 90

;Declaring [327 -23
;Loading [327 -23
add esp, -4
mov ebx, ebp
add ebx, -23
mov [esp], ebx
call OutputByte
add esp, 4
add esp, -4
mov ebx, ebp
add ebx, 8
mov ebx, [ebx]
add ebx, 0
mov [esp], ebx
; loading a reference!Me
;Shifting Deref Offset1 = 0 + 1
;Names: Me : DP -> 1
;ok-27
;Loading [328 -27
add esp, -4
mov ebx, ebp
add ebx, -27
mov ebx, [ebx]
add ebx, 1
mov [esp], ebx
; loading a reference![328
call SetFirstByteInDynam
add esp, 4
add esp, -4
mov ebx, ebp
add ebx, 8
mov ebx, [ebx]
add ebx, 0
mov [esp], ebx
; loading a reference!Me
;Shifting Deref Offset1 = 0 + 1
;Names: Me : DP -> 1
;ok-31
add esp, -1

mov byte [esp], 78

;Declaring [330 -32
;Loading [330 -32
add esp, -4
mov ebx, ebp
add ebx, -32
mov [esp], ebx
;Loading B -36
add esp, -4
mov ebx, ebp
add ebx, -21
mov [esp], ebx
;Loading [329 -40
add esp, -4
mov ebx, ebp
add ebx, -31
mov ebx, [ebx]
add ebx, 1
mov [esp], ebx
; loading a reference![329
call SetByteInDynam
add esp, 12
add esp, -4
mov ebx, ebp
add ebx, 8
mov ebx, [ebx]
add ebx, 0
mov [esp], ebx
; loading a reference!Me
;Shifting Deref Offset1 = 0 + 1
;Names: Me : DP -> 1
;ok-36
;Loading [331 -36
add esp, -4
mov ebx, ebp
add ebx, -36
mov ebx, [ebx]
add ebx, 1
mov [esp], ebx
; loading a reference![331
call GetFirstByteInDynam
add esp, 4
;Declaring test -37
add esp, -1

add esp, -4
mov ebx, ebp
add ebx, -37
mov [esp], ebx
call Byte__On_Create
add esp, 4
add esp, -1

mov byte [esp], 0

;Declaring [332 -38
;Adding return value 
add esp, -1
;Loading [332 -39
add esp, -4
mov ebx, ebp
add ebx, -38
mov [esp], ebx
;Loading a Array object
add esp, -4
mov ebx, ebp
add ebx, 8
mov ebx, [ebx]
add ebx, 0
mov [esp], ebx
; loading a reference!Me
call Array__Byte__GetAt
add esp, 8
;Loading [333 -39
add esp, -4
mov ebx, ebp
add ebx, -39
mov [esp], ebx
;Loading a Byte object
add esp, -4
mov ebx, ebp
add ebx, -37
mov [esp], ebx
call Byte__On_Equals
add esp, 8
;Loading test -39
add esp, -4
mov ebx, ebp
add ebx, -37
mov [esp], ebx
call OutputByte
add esp, 4


mov esp, ebp
pop ebp
ret

Main:

push ebp
mov ebp, esp


;Declaring L -1
add esp, -1

add esp, -4
mov ebx, ebp
add ebx, -1
mov [esp], ebx
call Byte__On_Create
add esp, 4
add esp, -1

mov byte [esp], 102

;Declaring [34 -2
;Loading [34 -2
add esp, -4
mov ebx, ebp
add ebx, -2
mov [esp], ebx
;Loading a Byte object
add esp, -4
mov ebx, ebp
add ebx, -1
mov [esp], ebx
call Byte__On_Equals
add esp, 8
;Loading L -2
add esp, -4
mov ebx, ebp
add ebx, -1
mov [esp], ebx
call OutputByte
add esp, 4
add esp, -1

mov byte [esp], 100

;Declaring [35 -3
;Loading [35 -3
add esp, -4
mov ebx, ebp
add ebx, -3
mov [esp], ebx
;Loading a Byte object
add esp, -4
mov ebx, ebp
add ebx, -1
mov [esp], ebx
call Byte__On_Equals
add esp, 8
add esp, -1

mov byte [esp], 120

;Declaring [36 -4
;Loading [36 -4
add esp, -4
mov ebx, ebp
add ebx, -4
mov [esp], ebx
;Loading a Byte object
add esp, -4
mov ebx, ebp
add ebx, -1
mov [esp], ebx
call Byte__On_Equals
add esp, 8
;Loading L -4
add esp, -4
mov ebx, ebp
add ebx, -1
mov [esp], ebx
call OutputByte
add esp, 4
;Declaring B2 -5
add esp, -1

add esp, -4
mov ebx, ebp
add ebx, -5
mov [esp], ebx
call Byte__On_Create
add esp, 4
;Loading L -5
add esp, -4
mov ebx, ebp
add ebx, -1
mov [esp], ebx
call OutputByte
add esp, 4
add esp, -1

mov byte [esp], 110

;Declaring [37 -6
;Loading [37 -6
add esp, -4
mov ebx, ebp
add ebx, -6
mov [esp], ebx
;Loading a Byte object
add esp, -4
mov ebx, ebp
add ebx, -5
mov [esp], ebx
call Byte__On_Equals
add esp, 8
;Loading L -6
add esp, -4
mov ebx, ebp
add ebx, -1
mov [esp], ebx
call OutputByte
add esp, 4
;Loading L -6
add esp, -4
mov ebx, ebp
add ebx, -1
mov [esp], ebx
;Loading a Byte object
add esp, -4
mov ebx, ebp
add ebx, -5
mov [esp], ebx
call Byte__On_Equals
add esp, 8
;Loading L -6
add esp, -4
mov ebx, ebp
add ebx, -1
mov [esp], ebx
call OutputByte
add esp, 4
;Loading B2 -6
add esp, -4
mov ebx, ebp
add ebx, -5
mov [esp], ebx
;Loading L -10
add esp, -4
mov ebx, ebp
add ebx, -1
mov [esp], ebx
call OutputByte2
add esp, 8
add esp, -1

mov byte [esp], 121

;Declaring [38 -7
;Loading [38 -7
add esp, -4
mov ebx, ebp
add ebx, -7
mov [esp], ebx
;Loading a Byte object
add esp, -4
mov ebx, ebp
add ebx, -5
mov [esp], ebx
call Byte__On_Equals
add esp, 8
add esp, -1

mov byte [esp], 119

;Declaring [39 -8
;Loading [39 -8
add esp, -4
mov ebx, ebp
add ebx, -8
mov [esp], ebx
;Loading a Byte object
add esp, -4
mov ebx, ebp
add ebx, -1
mov [esp], ebx
call Byte__On_Equals
add esp, 8
;Loading B2 -8
add esp, -4
mov ebx, ebp
add ebx, -5
mov [esp], ebx
;Loading L -12
add esp, -4
mov ebx, ebp
add ebx, -1
mov [esp], ebx
call OutputByte2
add esp, 8
;Declaring B3 -9
add esp, -1

add esp, -4
mov ebx, ebp
add ebx, -9
mov [esp], ebx
call Byte__On_Create
add esp, 4
;Declaring B4 -10
add esp, -1

add esp, -4
mov ebx, ebp
add ebx, -10
mov [esp], ebx
call Byte__On_Create
add esp, 4
;Declaring B5 -11
add esp, -1

add esp, -4
mov ebx, ebp
add ebx, -11
mov [esp], ebx
call Byte__On_Create
add esp, 4
add esp, -1

mov byte [esp], 100

;Declaring [40 -12
;Loading [40 -12
add esp, -4
mov ebx, ebp
add ebx, -12
mov [esp], ebx
;Loading a Byte object
add esp, -4
mov ebx, ebp
add ebx, -1
mov [esp], ebx
call Byte__On_Equals
add esp, 8
add esp, -1

mov byte [esp], 101

;Declaring [41 -13
;Loading [41 -13
add esp, -4
mov ebx, ebp
add ebx, -13
mov [esp], ebx
;Loading a Byte object
add esp, -4
mov ebx, ebp
add ebx, -5
mov [esp], ebx
call Byte__On_Equals
add esp, 8
add esp, -1

mov byte [esp], 102

;Declaring [42 -14
;Loading [42 -14
add esp, -4
mov ebx, ebp
add ebx, -14
mov [esp], ebx
;Loading a Byte object
add esp, -4
mov ebx, ebp
add ebx, -9
mov [esp], ebx
call Byte__On_Equals
add esp, 8
add esp, -1

mov byte [esp], 103

;Declaring [43 -15
;Loading [43 -15
add esp, -4
mov ebx, ebp
add ebx, -15
mov [esp], ebx
;Loading a Byte object
add esp, -4
mov ebx, ebp
add ebx, -10
mov [esp], ebx
call Byte__On_Equals
add esp, 8
add esp, -1

mov byte [esp], 104

;Declaring [44 -16
;Loading [44 -16
add esp, -4
mov ebx, ebp
add ebx, -16
mov [esp], ebx
;Loading a Byte object
add esp, -4
mov ebx, ebp
add ebx, -11
mov [esp], ebx
call Byte__On_Equals
add esp, 8
;Loading B5 -16
add esp, -4
mov ebx, ebp
add ebx, -11
mov [esp], ebx
;Loading B4 -20
add esp, -4
mov ebx, ebp
add ebx, -10
mov [esp], ebx
;Loading B3 -24
add esp, -4
mov ebx, ebp
add ebx, -9
mov [esp], ebx
;Loading B2 -28
add esp, -4
mov ebx, ebp
add ebx, -5
mov [esp], ebx
;Loading L -32
add esp, -4
mov ebx, ebp
add ebx, -1
mov [esp], ebx
call OutputByte5
add esp, 20
add esp, -1

mov byte [esp], 32

;Declaring [45 -17
;Loading [45 -17
add esp, -4
mov ebx, ebp
add ebx, -17
mov [esp], ebx
;Loading a Byte object
add esp, -4
mov ebx, ebp
add ebx, -11
mov [esp], ebx
call Byte__On_Equals
add esp, 8
;Loading B5 -17
add esp, -4
mov ebx, ebp
add ebx, -11
mov [esp], ebx
call OutputByte
add esp, 4
;Loading B5 -17
add esp, -4
mov ebx, ebp
add ebx, -11
mov [esp], ebx
call OutputByte
add esp, 4
;Loading B5 -17
add esp, -4
mov ebx, ebp
add ebx, -11
mov [esp], ebx
call OutputByte
add esp, 4
;Loading B5 -17
add esp, -4
mov ebx, ebp
add ebx, -11
mov [esp], ebx
call OutputByte
add esp, 4
;Loading B5 -17
add esp, -4
mov ebx, ebp
add ebx, -11
mov [esp], ebx
call OutputByte
add esp, 4
;Declaring S1 -18
add esp, -1

add esp, -4
mov ebx, ebp
add ebx, -18
mov [esp], ebx
call Byte__On_Create
add esp, 4
;Declaring S2 -19
add esp, -1

add esp, -4
mov ebx, ebp
add ebx, -19
mov [esp], ebx
call Byte__On_Create
add esp, 4
;Declaring S3 -20
add esp, -1

add esp, -4
mov ebx, ebp
add ebx, -20
mov [esp], ebx
call Byte__On_Create
add esp, 4
add esp, -1

mov byte [esp], 100

;Declaring [46 -21
;Loading [46 -21
add esp, -4
mov ebx, ebp
add ebx, -21
mov [esp], ebx
;Loading a Byte object
add esp, -4
mov ebx, ebp
add ebx, -18
mov [esp], ebx
call Byte__On_Equals
add esp, 8
add esp, -1

mov byte [esp], 101

;Declaring [47 -22
;Loading [47 -22
add esp, -4
mov ebx, ebp
add ebx, -22
mov [esp], ebx
;Loading a Byte object
add esp, -4
mov ebx, ebp
add ebx, -19
mov [esp], ebx
call Byte__On_Equals
add esp, 8
;Loading S1 -22
add esp, -4
mov ebx, ebp
add ebx, -18
mov [esp], ebx
;Loading a Byte object
add esp, -4
mov ebx, ebp
add ebx, -20
mov [esp], ebx
call Byte__On_Equals
add esp, 8
;Loading S2 -22
add esp, -4
mov ebx, ebp
add ebx, -19
mov [esp], ebx
;Loading a Byte object
add esp, -4
mov ebx, ebp
add ebx, -18
mov [esp], ebx
call Byte__On_Equals
add esp, 8
;Loading S3 -22
add esp, -4
mov ebx, ebp
add ebx, -20
mov [esp], ebx
;Loading a Byte object
add esp, -4
mov ebx, ebp
add ebx, -19
mov [esp], ebx
call Byte__On_Equals
add esp, 8
;Loading S1 -22
add esp, -4
mov ebx, ebp
add ebx, -18
mov [esp], ebx
call OutputByte
add esp, 4
;Loading S2 -22
add esp, -4
mov ebx, ebp
add ebx, -19
mov [esp], ebx
call OutputByte
add esp, 4
;Loading S3 -22
add esp, -4
mov ebx, ebp
add ebx, -20
mov [esp], ebx
call OutputByte
add esp, 4
add esp, -1

mov byte [esp], 1

;Declaring [48 -23
;Adding return value 
add esp, -1
;Loading [48 -24
add esp, -4
mov ebx, ebp
add ebx, -23
mov [esp], ebx
;Loading a Byte object
add esp, -4
mov ebx, ebp
add ebx, -20
mov [esp], ebx
call Byte__On_Plus
add esp, 8
;Loading [49 -24
add esp, -4
mov ebx, ebp
add ebx, -24
mov [esp], ebx
;Loading a Byte object
add esp, -4
mov ebx, ebp
add ebx, -20
mov [esp], ebx
call Byte__On_Equals
add esp, 8
;Loading S3 -24
add esp, -4
mov ebx, ebp
add ebx, -20
mov [esp], ebx
call OutputByte
add esp, 4
add esp, -1

mov byte [esp], 1

;Declaring [50 -25
;Adding return value 
add esp, -1
;Loading [50 -26
add esp, -4
mov ebx, ebp
add ebx, -25
mov [esp], ebx
;Loading a Byte object
add esp, -4
mov ebx, ebp
add ebx, -20
mov [esp], ebx
call Byte__On_Plus
add esp, 8
;Loading [51 -26
add esp, -4
mov ebx, ebp
add ebx, -26
mov [esp], ebx
;Loading a Byte object
add esp, -4
mov ebx, ebp
add ebx, -20
mov [esp], ebx
call Byte__On_Equals
add esp, 8
;Loading S3 -26
add esp, -4
mov ebx, ebp
add ebx, -20
mov [esp], ebx
call OutputByte
add esp, 4
add esp, -1

mov byte [esp], 1

;Declaring [52 -27
;Adding return value 
add esp, -1
;Loading [52 -28
add esp, -4
mov ebx, ebp
add ebx, -27
mov [esp], ebx
;Loading a Byte object
add esp, -4
mov ebx, ebp
add ebx, -20
mov [esp], ebx
call Byte__On_Plus
add esp, 8
;Loading [53 -28
add esp, -4
mov ebx, ebp
add ebx, -28
mov [esp], ebx
;Loading a Byte object
add esp, -4
mov ebx, ebp
add ebx, -20
mov [esp], ebx
call Byte__On_Equals
add esp, 8
;Loading S3 -28
add esp, -4
mov ebx, ebp
add ebx, -20
mov [esp], ebx
call OutputByte
add esp, 4
add esp, -1

mov byte [esp], 1

;Declaring [54 -29
;Adding return value 
add esp, -1
;Loading [54 -30
add esp, -4
mov ebx, ebp
add ebx, -29
mov [esp], ebx
;Loading a Byte object
add esp, -4
mov ebx, ebp
add ebx, -20
mov [esp], ebx
call Byte__On_Plus
add esp, 8
;Loading [55 -30
add esp, -4
mov ebx, ebp
add ebx, -30
mov [esp], ebx
;Loading a Byte object
add esp, -4
mov ebx, ebp
add ebx, -20
mov [esp], ebx
call Byte__On_Equals
add esp, 8
;Loading S3 -30
add esp, -4
mov ebx, ebp
add ebx, -20
mov [esp], ebx
call OutputByte
add esp, 4
add esp, -1

mov byte [esp], 1

;Declaring [56 -31
;Adding return value 
add esp, -1
;Loading [56 -32
add esp, -4
mov ebx, ebp
add ebx, -31
mov [esp], ebx
;Loading a Byte object
add esp, -4
mov ebx, ebp
add ebx, -20
mov [esp], ebx
call Byte__On_Plus
add esp, 8
;Loading [57 -32
add esp, -4
mov ebx, ebp
add ebx, -32
mov [esp], ebx
;Loading a Byte object
add esp, -4
mov ebx, ebp
add ebx, -20
mov [esp], ebx
call Byte__On_Equals
add esp, 8
;Loading S3 -32
add esp, -4
mov ebx, ebp
add ebx, -20
mov [esp], ebx
call OutputByte
add esp, 4
add esp, -1

mov byte [esp], 1

;Declaring [58 -33
;Adding return value 
add esp, -1
;Loading [58 -34
add esp, -4
mov ebx, ebp
add ebx, -33
mov [esp], ebx
;Loading a Byte object
add esp, -4
mov ebx, ebp
add ebx, -20
mov [esp], ebx
call Byte__On_Plus
add esp, 8
;Loading [59 -34
add esp, -4
mov ebx, ebp
add ebx, -34
mov [esp], ebx
;Loading a Byte object
add esp, -4
mov ebx, ebp
add ebx, -20
mov [esp], ebx
call Byte__On_Equals
add esp, 8
;Loading S3 -34
add esp, -4
mov ebx, ebp
add ebx, -20
mov [esp], ebx
call OutputByte
add esp, 4
add esp, -1

mov byte [esp], 1

;Declaring [60 -35
;Adding return value 
add esp, -1
;Loading [60 -36
add esp, -4
mov ebx, ebp
add ebx, -35
mov [esp], ebx
;Loading a Byte object
add esp, -4
mov ebx, ebp
add ebx, -20
mov [esp], ebx
call Byte__On_Plus
add esp, 8
;Loading [61 -36
add esp, -4
mov ebx, ebp
add ebx, -36
mov [esp], ebx
;Loading a Byte object
add esp, -4
mov ebx, ebp
add ebx, -20
mov [esp], ebx
call Byte__On_Equals
add esp, 8
;Loading S3 -36
add esp, -4
mov ebx, ebp
add ebx, -20
mov [esp], ebx
call OutputByte
add esp, 4
add esp, -1

mov byte [esp], 1

;Declaring [62 -37
;Adding return value 
add esp, -1
;Loading [62 -38
add esp, -4
mov ebx, ebp
add ebx, -37
mov [esp], ebx
;Loading a Byte object
add esp, -4
mov ebx, ebp
add ebx, -20
mov [esp], ebx
call Byte__On_Plus
add esp, 8
;Loading [63 -38
add esp, -4
mov ebx, ebp
add ebx, -38
mov [esp], ebx
;Loading a Byte object
add esp, -4
mov ebx, ebp
add ebx, -20
mov [esp], ebx
call Byte__On_Equals
add esp, 8
;Loading S3 -38
add esp, -4
mov ebx, ebp
add ebx, -20
mov [esp], ebx
call OutputByte
add esp, 4
add esp, -1

mov byte [esp], 1

;Declaring [64 -39
;Adding return value 
add esp, -1
;Loading [64 -40
add esp, -4
mov ebx, ebp
add ebx, -39
mov [esp], ebx
;Loading a Byte object
add esp, -4
mov ebx, ebp
add ebx, -20
mov [esp], ebx
call Byte__On_Minus
add esp, 8
;Loading [65 -40
add esp, -4
mov ebx, ebp
add ebx, -40
mov [esp], ebx
;Loading a Byte object
add esp, -4
mov ebx, ebp
add ebx, -20
mov [esp], ebx
call Byte__On_Equals
add esp, 8
;Loading S3 -40
add esp, -4
mov ebx, ebp
add ebx, -20
mov [esp], ebx
call OutputByte
add esp, 4
add esp, -1

mov byte [esp], 1

;Declaring [66 -41
;Adding return value 
add esp, -1
;Loading [66 -42
add esp, -4
mov ebx, ebp
add ebx, -41
mov [esp], ebx
;Loading a Byte object
add esp, -4
mov ebx, ebp
add ebx, -20
mov [esp], ebx
call Byte__On_Minus
add esp, 8
;Loading [67 -42
add esp, -4
mov ebx, ebp
add ebx, -42
mov [esp], ebx
;Loading a Byte object
add esp, -4
mov ebx, ebp
add ebx, -20
mov [esp], ebx
call Byte__On_Equals
add esp, 8
;Loading S3 -42
add esp, -4
mov ebx, ebp
add ebx, -20
mov [esp], ebx
call OutputByte
add esp, 4
add esp, -1

mov byte [esp], 1

;Declaring [68 -43
;Adding return value 
add esp, -1
;Loading [68 -44
add esp, -4
mov ebx, ebp
add ebx, -43
mov [esp], ebx
;Loading a Byte object
add esp, -4
mov ebx, ebp
add ebx, -20
mov [esp], ebx
call Byte__On_Minus
add esp, 8
;Loading [69 -44
add esp, -4
mov ebx, ebp
add ebx, -44
mov [esp], ebx
;Loading a Byte object
add esp, -4
mov ebx, ebp
add ebx, -20
mov [esp], ebx
call Byte__On_Equals
add esp, 8
;Loading S3 -44
add esp, -4
mov ebx, ebp
add ebx, -20
mov [esp], ebx
call OutputByte
add esp, 4
add esp, -1

mov byte [esp], 1

;Declaring [70 -45
;Adding return value 
add esp, -1
;Loading [70 -46
add esp, -4
mov ebx, ebp
add ebx, -45
mov [esp], ebx
;Loading a Byte object
add esp, -4
mov ebx, ebp
add ebx, -20
mov [esp], ebx
call Byte__On_Minus
add esp, 8
;Loading [71 -46
add esp, -4
mov ebx, ebp
add ebx, -46
mov [esp], ebx
;Loading a Byte object
add esp, -4
mov ebx, ebp
add ebx, -20
mov [esp], ebx
call Byte__On_Equals
add esp, 8
;Loading S3 -46
add esp, -4
mov ebx, ebp
add ebx, -20
mov [esp], ebx
call OutputByte
add esp, 4
add esp, -1

mov byte [esp], 1

;Declaring [72 -47
;Adding return value 
add esp, -1
;Loading [72 -48
add esp, -4
mov ebx, ebp
add ebx, -47
mov [esp], ebx
;Loading a Byte object
add esp, -4
mov ebx, ebp
add ebx, -20
mov [esp], ebx
call Byte__On_Minus
add esp, 8
;Loading [73 -48
add esp, -4
mov ebx, ebp
add ebx, -48
mov [esp], ebx
;Loading a Byte object
add esp, -4
mov ebx, ebp
add ebx, -20
mov [esp], ebx
call Byte__On_Equals
add esp, 8
;Loading S3 -48
add esp, -4
mov ebx, ebp
add ebx, -20
mov [esp], ebx
call OutputByte
add esp, 4
add esp, -1

mov byte [esp], 1

;Declaring [74 -49
;Adding return value 
add esp, -1
;Loading [74 -50
add esp, -4
mov ebx, ebp
add ebx, -49
mov [esp], ebx
;Loading a Byte object
add esp, -4
mov ebx, ebp
add ebx, -20
mov [esp], ebx
call Byte__On_Minus
add esp, 8
add esp, -1

mov byte [esp], 1

;Declaring [76 -51
;Adding return value 
add esp, -1
;Loading [76 -52
add esp, -4
mov ebx, ebp
add ebx, -51
mov [esp], ebx
;Loading a Byte object
add esp, -4
mov ebx, ebp
add ebx, -50
mov [esp], ebx
call Byte__On_Minus
add esp, 8
add esp, -1

mov byte [esp], 1

;Declaring [78 -53
;Adding return value 
add esp, -1
;Loading [78 -54
add esp, -4
mov ebx, ebp
add ebx, -53
mov [esp], ebx
;Loading a Byte object
add esp, -4
mov ebx, ebp
add ebx, -52
mov [esp], ebx
call Byte__On_Minus
add esp, 8
add esp, -1

mov byte [esp], 1

;Declaring [80 -55
;Adding return value 
add esp, -1
;Loading [80 -56
add esp, -4
mov ebx, ebp
add ebx, -55
mov [esp], ebx
;Loading a Byte object
add esp, -4
mov ebx, ebp
add ebx, -54
mov [esp], ebx
call Byte__On_Minus
add esp, 8
;Loading [81 -56
add esp, -4
mov ebx, ebp
add ebx, -56
mov [esp], ebx
;Loading a Byte object
add esp, -4
mov ebx, ebp
add ebx, -20
mov [esp], ebx
call Byte__On_Equals
add esp, 8
;Loading S3 -56
add esp, -4
mov ebx, ebp
add ebx, -20
mov [esp], ebx
call OutputByte
add esp, 4
add esp, -1

mov byte [esp], 1

;Declaring [82 -57
;Adding return value 
add esp, -1
;Loading [82 -58
add esp, -4
mov ebx, ebp
add ebx, -57
mov [esp], ebx
;Loading a Byte object
add esp, -4
mov ebx, ebp
add ebx, -20
mov [esp], ebx
call Byte__On_Minus
add esp, 8
;Loading [83 -58
add esp, -4
mov ebx, ebp
add ebx, -58
mov [esp], ebx
;Loading a Byte object
add esp, -4
mov ebx, ebp
add ebx, -20
mov [esp], ebx
call Byte__On_Equals
add esp, 8
;Loading S3 -58
add esp, -4
mov ebx, ebp
add ebx, -20
mov [esp], ebx
call OutputByte
add esp, 4
;Declaring S4 -59
add esp, -1

add esp, -4
mov ebx, ebp
add ebx, -59
mov [esp], ebx
call Byte__On_Create
add esp, 4
add esp, -1

mov byte [esp], 1

;Declaring [84 -60
;Loading [84 -60
add esp, -4
mov ebx, ebp
add ebx, -60
mov [esp], ebx
;Loading a Byte object
add esp, -4
mov ebx, ebp
add ebx, -59
mov [esp], ebx
call Byte__On_Equals
add esp, 8
;Adding return value 
add esp, -1
;Loading S4 -61
add esp, -4
mov ebx, ebp
add ebx, -59
mov [esp], ebx
;Loading a Byte object
add esp, -4
mov ebx, ebp
add ebx, -20
mov [esp], ebx
call Byte__On_Minus
add esp, 8
;Loading [85 -61
add esp, -4
mov ebx, ebp
add ebx, -61
mov [esp], ebx
;Loading a Byte object
add esp, -4
mov ebx, ebp
add ebx, -20
mov [esp], ebx
call Byte__On_Equals
add esp, 8
;Loading S3 -61
add esp, -4
mov ebx, ebp
add ebx, -20
mov [esp], ebx
call OutputByte
add esp, 4
;Declaring S5 -62
add esp, -1

add esp, -4
mov ebx, ebp
add ebx, -62
mov [esp], ebx
call Byte__On_Create
add esp, 4
add esp, -1

mov byte [esp], 115

;Declaring [86 -63
;Loading [86 -63
add esp, -4
mov ebx, ebp
add ebx, -63
mov [esp], ebx
;Loading a Byte object
add esp, -4
mov ebx, ebp
add ebx, -62
mov [esp], ebx
call Byte__On_Equals
add esp, 8
;Loading S5 -63
add esp, -4
mov ebx, ebp
add ebx, -62
mov [esp], ebx
call OutputByte
add esp, 4
;Declaring S6 -64
add esp, -1

add esp, -4
mov ebx, ebp
add ebx, -64
mov [esp], ebx
call Byte__On_Create
add esp, 4
;Loading S5 -64
add esp, -4
mov ebx, ebp
add ebx, -62
mov [esp], ebx
;Loading a Byte object
add esp, -4
mov ebx, ebp
add ebx, -64
mov [esp], ebx
call Byte__On_Equals
add esp, 8
;Loading S6 -64
add esp, -4
mov ebx, ebp
add ebx, -64
mov [esp], ebx
call OutputByte
add esp, 4
add esp, -1

mov byte [esp], 5

;Declaring [87 -65
;Adding return value 
add esp, -1
;Loading [87 -66
add esp, -4
mov ebx, ebp
add ebx, -65
mov [esp], ebx
;Loading a Byte object
add esp, -4
mov ebx, ebp
add ebx, -64
mov [esp], ebx
call Byte__On_Minus
add esp, 8
;Loading [88 -66
add esp, -4
mov ebx, ebp
add ebx, -66
mov [esp], ebx
;Loading a Byte object
add esp, -4
mov ebx, ebp
add ebx, -64
mov [esp], ebx
call Byte__On_Equals
add esp, 8
;Loading S6 -66
add esp, -4
mov ebx, ebp
add ebx, -64
mov [esp], ebx
call OutputByte
add esp, 4
;Loading S6 -66
add esp, -4
mov ebx, ebp
add ebx, -64
mov [esp], ebx
call OutputByte
add esp, 4
add esp, -1

mov byte [esp], 122

;Declaring [89 -67
;Loading [89 -67
add esp, -4
mov ebx, ebp
add ebx, -67
mov [esp], ebx
;Loading a Byte object
add esp, -4
mov ebx, ebp
add ebx, -64
mov [esp], ebx
call Byte__On_Equals
add esp, 8
;Declaring S7 -68
add esp, -1

add esp, -4
mov ebx, ebp
add ebx, -68
mov [esp], ebx
call Byte__On_Create
add esp, 4
add esp, -1

mov byte [esp], 65

;Declaring [90 -69
;Loading [90 -69
add esp, -4
mov ebx, ebp
add ebx, -69
mov [esp], ebx
;Loading a Byte object
add esp, -4
mov ebx, ebp
add ebx, -68
mov [esp], ebx
call Byte__On_Equals
add esp, 8
;Declaring S8 -70
add esp, -1

add esp, -4
mov ebx, ebp
add ebx, -70
mov [esp], ebx
call Byte__On_Create
add esp, 4
add esp, -1

mov byte [esp], 121

;Declaring [91 -71
;Loading [91 -71
add esp, -4
mov ebx, ebp
add ebx, -71
mov [esp], ebx
;Loading a Byte object
add esp, -4
mov ebx, ebp
add ebx, -70
mov [esp], ebx
call Byte__On_Equals
add esp, 8
S5:
add esp, -1

mov byte [esp], 65

;Declaring [92 -72
;Adding return value 
add esp, -1
;Loading [92 -73
add esp, -4
mov ebx, ebp
add ebx, -72
mov [esp], ebx
;Loading a Byte object
add esp, -4
mov ebx, ebp
add ebx, -64
mov [esp], ebx
call Byte__On_Greater_Than
add esp, 8
mov byte cl, [esp]
test cl, cl
je S6

;Loading S6 -73
add esp, -4
mov ebx, ebp
add ebx, -64
mov [esp], ebx
call OutputByte
add esp, 4
add esp, -1

mov byte [esp], 1

;Declaring [94 -74
;Adding return value 
add esp, -1
;Loading [94 -75
add esp, -4
mov ebx, ebp
add ebx, -74
mov [esp], ebx
;Loading a Byte object
add esp, -4
mov ebx, ebp
add ebx, -64
mov [esp], ebx
call Byte__On_Minus
add esp, 8
;Loading [95 -75
add esp, -4
mov ebx, ebp
add ebx, -75
mov [esp], ebx
;Loading a Byte object
add esp, -4
mov ebx, ebp
add ebx, -64
mov [esp], ebx
call Byte__On_Equals
add esp, 8
add esp, 4
jmp S5
S6:
add esp, 2
add esp, -1

mov byte [esp], 65

;Declaring [96 -72
;Loading [96 -72
add esp, -4
mov ebx, ebp
add ebx, -72
mov [esp], ebx
;Loading a Byte object
add esp, -4
mov ebx, ebp
add ebx, -64
mov [esp], ebx
call Byte__On_Equals
add esp, 8
S7:
add esp, -1

mov byte [esp], 121

;Declaring [97 -73
;Adding return value 
add esp, -1
;Loading [97 -74
add esp, -4
mov ebx, ebp
add ebx, -73
mov [esp], ebx
;Loading a Byte object
add esp, -4
mov ebx, ebp
add ebx, -64
mov [esp], ebx
call Byte__On_Greater_Than
add esp, 8
mov byte cl, [esp]
test cl, cl
jne S8

;Loading S6 -74
add esp, -4
mov ebx, ebp
add ebx, -64
mov [esp], ebx
call OutputByte
add esp, 4
add esp, -1

mov byte [esp], 1

;Declaring [99 -75
;Adding return value 
add esp, -1
;Loading [99 -76
add esp, -4
mov ebx, ebp
add ebx, -75
mov [esp], ebx
;Loading a Byte object
add esp, -4
mov ebx, ebp
add ebx, -64
mov [esp], ebx
call Byte__On_Plus
add esp, 8
;Loading [100 -76
add esp, -4
mov ebx, ebp
add ebx, -76
mov [esp], ebx
;Loading a Byte object
add esp, -4
mov ebx, ebp
add ebx, -64
mov [esp], ebx
call Byte__On_Equals
add esp, 8
add esp, 4
jmp S7
S8:
add esp, 2
S9:
add esp, -1

mov byte [esp], 65

;Declaring [101 -73
;Adding return value 
add esp, -1
;Loading [101 -74
add esp, -4
mov ebx, ebp
add ebx, -73
mov [esp], ebx
;Loading a Byte object
add esp, -4
mov ebx, ebp
add ebx, -64
mov [esp], ebx
call Byte__On_Less_Or_Equal
add esp, 8
mov byte cl, [esp]
test cl, cl
jne S10

;Loading S6 -74
add esp, -4
mov ebx, ebp
add ebx, -64
mov [esp], ebx
call OutputByte
add esp, 4
add esp, -1

mov byte [esp], 1

;Declaring [103 -75
;Adding return value 
add esp, -1
;Loading [103 -76
add esp, -4
mov ebx, ebp
add ebx, -75
mov [esp], ebx
;Loading a Byte object
add esp, -4
mov ebx, ebp
add ebx, -64
mov [esp], ebx
call Byte__On_Minus
add esp, 8
;Loading [104 -76
add esp, -4
mov ebx, ebp
add ebx, -76
mov [esp], ebx
;Loading a Byte object
add esp, -4
mov ebx, ebp
add ebx, -64
mov [esp], ebx
call Byte__On_Equals
add esp, 8
add esp, 4
jmp S9
S10:
add esp, 2
S11:
add esp, -1

mov byte [esp], 122

;Declaring [105 -73
;Adding return value 
add esp, -1
;Loading [105 -74
add esp, -4
mov ebx, ebp
add ebx, -73
mov [esp], ebx
;Loading a Byte object
add esp, -4
mov ebx, ebp
add ebx, -64
mov [esp], ebx
call Byte__On_Greater_Equal
add esp, 8
mov byte cl, [esp]
test cl, cl
jne S12

;Loading S6 -74
add esp, -4
mov ebx, ebp
add ebx, -64
mov [esp], ebx
call OutputByte
add esp, 4
add esp, -1

mov byte [esp], 1

;Declaring [107 -75
;Adding return value 
add esp, -1
;Loading [107 -76
add esp, -4
mov ebx, ebp
add ebx, -75
mov [esp], ebx
;Loading a Byte object
add esp, -4
mov ebx, ebp
add ebx, -64
mov [esp], ebx
call Byte__On_Plus
add esp, 8
;Loading [108 -76
add esp, -4
mov ebx, ebp
add ebx, -76
mov [esp], ebx
;Loading a Byte object
add esp, -4
mov ebx, ebp
add ebx, -64
mov [esp], ebx
call Byte__On_Equals
add esp, 8
add esp, 4
jmp S11
S12:
add esp, 2
S13:
add esp, -1

mov byte [esp], 65

;Declaring [109 -73
;Adding return value 
add esp, -1
;Loading [109 -74
add esp, -4
mov ebx, ebp
add ebx, -73
mov [esp], ebx
;Loading a Byte object
add esp, -4
mov ebx, ebp
add ebx, -64
mov [esp], ebx
call Byte__On_If_Equal
add esp, 8
mov byte cl, [esp]
test cl, cl
jne S14

;Loading S6 -74
add esp, -4
mov ebx, ebp
add ebx, -64
mov [esp], ebx
call OutputByte
add esp, 4
add esp, -1

mov byte [esp], 1

;Declaring [111 -75
;Adding return value 
add esp, -1
;Loading [111 -76
add esp, -4
mov ebx, ebp
add ebx, -75
mov [esp], ebx
;Loading a Byte object
add esp, -4
mov ebx, ebp
add ebx, -64
mov [esp], ebx
call Byte__On_Minus
add esp, 8
;Loading [112 -76
add esp, -4
mov ebx, ebp
add ebx, -76
mov [esp], ebx
;Loading a Byte object
add esp, -4
mov ebx, ebp
add ebx, -64
mov [esp], ebx
call Byte__On_Equals
add esp, 8
add esp, 4
jmp S13
S14:
add esp, 2
S15:
add esp, -1

mov byte [esp], 122

;Declaring [113 -73
;Adding return value 
add esp, -1
;Loading [113 -74
add esp, -4
mov ebx, ebp
add ebx, -73
mov [esp], ebx
;Loading a Byte object
add esp, -4
mov ebx, ebp
add ebx, -64
mov [esp], ebx
call Byte__On_Less_Than
add esp, 8
mov byte cl, [esp]
test cl, cl
je S16

;Loading S6 -74
add esp, -4
mov ebx, ebp
add ebx, -64
mov [esp], ebx
call OutputByte
add esp, 4
add esp, -1

mov byte [esp], 1

;Declaring [115 -75
;Adding return value 
add esp, -1
;Loading [115 -76
add esp, -4
mov ebx, ebp
add ebx, -75
mov [esp], ebx
;Loading a Byte object
add esp, -4
mov ebx, ebp
add ebx, -64
mov [esp], ebx
call Byte__On_Plus
add esp, 8
;Loading [116 -76
add esp, -4
mov ebx, ebp
add ebx, -76
mov [esp], ebx
;Loading a Byte object
add esp, -4
mov ebx, ebp
add ebx, -64
mov [esp], ebx
call Byte__On_Equals
add esp, 8
add esp, 4
jmp S15
S16:
add esp, 2
S17:
add esp, -1

mov byte [esp], 65

;Declaring [117 -73
;Adding return value 
add esp, -1
;Loading [117 -74
add esp, -4
mov ebx, ebp
add ebx, -73
mov [esp], ebx
;Loading a Byte object
add esp, -4
mov ebx, ebp
add ebx, -64
mov [esp], ebx
call Byte__On_Not_Equal
add esp, 8
mov byte cl, [esp]
test cl, cl
je S18

;Loading S6 -74
add esp, -4
mov ebx, ebp
add ebx, -64
mov [esp], ebx
call OutputByte
add esp, 4
add esp, -1

mov byte [esp], 1

;Declaring [119 -75
;Adding return value 
add esp, -1
;Loading [119 -76
add esp, -4
mov ebx, ebp
add ebx, -75
mov [esp], ebx
;Loading a Byte object
add esp, -4
mov ebx, ebp
add ebx, -64
mov [esp], ebx
call Byte__On_Minus
add esp, 8
;Loading [120 -76
add esp, -4
mov ebx, ebp
add ebx, -76
mov [esp], ebx
;Loading a Byte object
add esp, -4
mov ebx, ebp
add ebx, -64
mov [esp], ebx
call Byte__On_Equals
add esp, 8
add esp, 4
jmp S17
S18:
add esp, 2
add esp, -1

mov byte [esp], 65

;Declaring [121 -73
;Loading [121 -73
add esp, -4
mov ebx, ebp
add ebx, -73
mov [esp], ebx
;Loading a Byte object
add esp, -4
mov ebx, ebp
add ebx, -64
mov [esp], ebx
call Byte__On_Equals
add esp, 8
;Loading S6 -73
add esp, -4
mov ebx, ebp
add ebx, -64
mov [esp], ebx
call OutputByte
add esp, 4
add esp, -1

mov byte [esp], 66

;Declaring [122 -74
;Adding return value 
add esp, -1
;Loading [122 -75
add esp, -4
mov ebx, ebp
add ebx, -74
mov [esp], ebx
;Loading a Byte object
add esp, -4
mov ebx, ebp
add ebx, -64
mov [esp], ebx
call Byte__On_If_Equal
add esp, 8
mov byte cl, [esp]
test cl, cl
je S19

add esp, -1

mov byte [esp], 67

;Declaring [124 -76
;Loading [124 -76
add esp, -4
mov ebx, ebp
add ebx, -76
mov [esp], ebx
;Loading a Byte object
add esp, -4
mov ebx, ebp
add ebx, -64
mov [esp], ebx
call Byte__On_Equals
add esp, 8
add esp, 3
jmp S20
S19:
add esp, 2
S20:
;Declaring WriteByte -74
add esp, -1

add esp, -4
mov ebx, ebp
add ebx, -74
mov [esp], ebx
call Byte__On_Create
add esp, 4
add esp, -1

mov byte [esp], 0

;Declaring [125 -75
;Loading [125 -75
add esp, -4
mov ebx, ebp
add ebx, -75
mov [esp], ebx
;Loading a Byte object
add esp, -4
mov ebx, ebp
add ebx, -74
mov [esp], ebx
call Byte__On_Equals
add esp, 8
add esp, -1

mov byte [esp], 65

;Declaring [126 -76
;Adding return value 
add esp, -1
;Loading [126 -77
add esp, -4
mov ebx, ebp
add ebx, -76
mov [esp], ebx
;Loading a Byte object
add esp, -4
mov ebx, ebp
add ebx, -64
mov [esp], ebx
call Byte__On_If_Equal
add esp, 8
mov byte cl, [esp]
test cl, cl
je S21

add esp, -1

mov byte [esp], 89

;Declaring [128 -78
;Loading [128 -78
add esp, -4
mov ebx, ebp
add ebx, -78
mov [esp], ebx
;Loading a Byte object
add esp, -4
mov ebx, ebp
add ebx, -74
mov [esp], ebx
call Byte__On_Equals
add esp, 8
;Loading WriteByte -78
add esp, -4
mov ebx, ebp
add ebx, -74
mov [esp], ebx
call OutputByte
add esp, 4
add esp, -1

mov byte [esp], 69

;Declaring [129 -79
;Loading [129 -79
add esp, -4
mov ebx, ebp
add ebx, -79
mov [esp], ebx
;Loading a Byte object
add esp, -4
mov ebx, ebp
add ebx, -74
mov [esp], ebx
call Byte__On_Equals
add esp, 8
;Loading WriteByte -79
add esp, -4
mov ebx, ebp
add ebx, -74
mov [esp], ebx
call OutputByte
add esp, 4
add esp, -1

mov byte [esp], 83

;Declaring [130 -80
;Loading [130 -80
add esp, -4
mov ebx, ebp
add ebx, -80
mov [esp], ebx
;Loading a Byte object
add esp, -4
mov ebx, ebp
add ebx, -74
mov [esp], ebx
call Byte__On_Equals
add esp, 8
;Loading WriteByte -80
add esp, -4
mov ebx, ebp
add ebx, -74
mov [esp], ebx
call OutputByte
add esp, 4
add esp, 5
jmp S22
S21:
add esp, 2
S22:
add esp, -1

mov byte [esp], 65

;Declaring [131 -76
;Adding return value 
add esp, -1
;Loading [131 -77
add esp, -4
mov ebx, ebp
add ebx, -76
mov [esp], ebx
;Loading a Byte object
add esp, -4
mov ebx, ebp
add ebx, -64
mov [esp], ebx
call Byte__On_Not_Equal
add esp, 8
mov byte cl, [esp]
test cl, cl
je S23

add esp, -1

mov byte [esp], 78

;Declaring [133 -78
;Loading [133 -78
add esp, -4
mov ebx, ebp
add ebx, -78
mov [esp], ebx
;Loading a Byte object
add esp, -4
mov ebx, ebp
add ebx, -74
mov [esp], ebx
call Byte__On_Equals
add esp, 8
;Loading WriteByte -78
add esp, -4
mov ebx, ebp
add ebx, -74
mov [esp], ebx
call OutputByte
add esp, 4
add esp, -1

mov byte [esp], 79

;Declaring [134 -79
;Loading [134 -79
add esp, -4
mov ebx, ebp
add ebx, -79
mov [esp], ebx
;Loading a Byte object
add esp, -4
mov ebx, ebp
add ebx, -74
mov [esp], ebx
call Byte__On_Equals
add esp, 8
;Loading WriteByte -79
add esp, -4
mov ebx, ebp
add ebx, -74
mov [esp], ebx
call OutputByte
add esp, 4
add esp, 4
jmp S24
S23:
add esp, 2
S24:
add esp, -1

mov byte [esp], 65

;Declaring [135 -76
;Adding return value 
add esp, -1
;Loading [135 -77
add esp, -4
mov ebx, ebp
add ebx, -76
mov [esp], ebx
;Loading a Byte object
add esp, -4
mov ebx, ebp
add ebx, -64
mov [esp], ebx
call Byte__On_If_Equal
add esp, 8
mov byte cl, [esp]
test cl, cl
je S25

add esp, -1

mov byte [esp], 89

;Declaring [137 -78
;Loading [137 -78
add esp, -4
mov ebx, ebp
add ebx, -78
mov [esp], ebx
;Loading a Byte object
add esp, -4
mov ebx, ebp
add ebx, -74
mov [esp], ebx
call Byte__On_Equals
add esp, 8
;Loading WriteByte -78
add esp, -4
mov ebx, ebp
add ebx, -74
mov [esp], ebx
call OutputByte
add esp, 4
add esp, -1

mov byte [esp], 69

;Declaring [138 -79
;Loading [138 -79
add esp, -4
mov ebx, ebp
add ebx, -79
mov [esp], ebx
;Loading a Byte object
add esp, -4
mov ebx, ebp
add ebx, -74
mov [esp], ebx
call Byte__On_Equals
add esp, 8
;Loading WriteByte -79
add esp, -4
mov ebx, ebp
add ebx, -74
mov [esp], ebx
call OutputByte
add esp, 4
add esp, -1

mov byte [esp], 83

;Declaring [139 -80
;Loading [139 -80
add esp, -4
mov ebx, ebp
add ebx, -80
mov [esp], ebx
;Loading a Byte object
add esp, -4
mov ebx, ebp
add ebx, -74
mov [esp], ebx
call Byte__On_Equals
add esp, 8
;Loading WriteByte -80
add esp, -4
mov ebx, ebp
add ebx, -74
mov [esp], ebx
call OutputByte
add esp, 4
add esp, 5
jmp S26
S25:
add esp, 2
add esp, -1

mov byte [esp], 65

;Declaring [140 -76
;Adding return value 
add esp, -1
;Loading [140 -77
add esp, -4
mov ebx, ebp
add ebx, -76
mov [esp], ebx
;Loading a Byte object
add esp, -4
mov ebx, ebp
add ebx, -64
mov [esp], ebx
call Byte__On_If_Equal
add esp, 8
mov byte cl, [esp]
test cl, cl
je S27

add esp, -1

mov byte [esp], 78

;Declaring [142 -78
;Loading [142 -78
add esp, -4
mov ebx, ebp
add ebx, -78
mov [esp], ebx
;Loading a Byte object
add esp, -4
mov ebx, ebp
add ebx, -74
mov [esp], ebx
call Byte__On_Equals
add esp, 8
;Loading WriteByte -78
add esp, -4
mov ebx, ebp
add ebx, -74
mov [esp], ebx
call OutputByte
add esp, 4
add esp, -1

mov byte [esp], 79

;Declaring [143 -79
;Loading [143 -79
add esp, -4
mov ebx, ebp
add ebx, -79
mov [esp], ebx
;Loading a Byte object
add esp, -4
mov ebx, ebp
add ebx, -74
mov [esp], ebx
call Byte__On_Equals
add esp, 8
;Loading WriteByte -79
add esp, -4
mov ebx, ebp
add ebx, -74
mov [esp], ebx
call OutputByte
add esp, 4
add esp, 4
jmp S26
S27:
add esp, 2
add esp, -1

mov byte [esp], 77

;Declaring [144 -76
;Loading [144 -76
add esp, -4
mov ebx, ebp
add ebx, -76
mov [esp], ebx
;Loading a Byte object
add esp, -4
mov ebx, ebp
add ebx, -74
mov [esp], ebx
call Byte__On_Equals
add esp, 8
;Loading WriteByte -76
add esp, -4
mov ebx, ebp
add ebx, -74
mov [esp], ebx
call OutputByte
add esp, 4
add esp, -1

mov byte [esp], 65

;Declaring [145 -77
;Loading [145 -77
add esp, -4
mov ebx, ebp
add ebx, -77
mov [esp], ebx
;Loading a Byte object
add esp, -4
mov ebx, ebp
add ebx, -74
mov [esp], ebx
call Byte__On_Equals
add esp, 8
;Loading WriteByte -77
add esp, -4
mov ebx, ebp
add ebx, -74
mov [esp], ebx
call OutputByte
add esp, 4
add esp, 2
jmp S26
S28:
add esp, 0
S26:
;Loading S6 -75
add esp, -4
mov ebx, ebp
add ebx, -64
mov [esp], ebx
call OutputByte
add esp, 4
;Loading S6 -75
add esp, -4
mov ebx, ebp
add ebx, -64
mov [esp], ebx
call OutputByte
add esp, 4
;Loading S6 -75
add esp, -4
mov ebx, ebp
add ebx, -64
mov [esp], ebx
call OutputByte
add esp, 4
;Loading S6 -75
add esp, -4
mov ebx, ebp
add ebx, -64
mov [esp], ebx
call OutputByte
add esp, 4
add esp, -1

mov byte [esp], 2

;Declaring [146 -76
;Adding return value 
add esp, -1
;Loading [146 -77
add esp, -4
mov ebx, ebp
add ebx, -76
mov [esp], ebx
;Loading a Byte object
add esp, -4
mov ebx, ebp
add ebx, -64
mov [esp], ebx
call Byte__On_Plus
add esp, 8
;Loading [147 -77
add esp, -4
mov ebx, ebp
add ebx, -77
mov [esp], ebx
call OutputByte
add esp, 4
add esp, -1

mov byte [esp], 1

;Declaring [148 -78
;Adding return value 
add esp, -1
;Loading [148 -79
add esp, -4
mov ebx, ebp
add ebx, -78
mov [esp], ebx
;Loading a Byte object
add esp, -4
mov ebx, ebp
add ebx, -64
mov [esp], ebx
call Byte__On_Plus
add esp, 8
;Loading B5 -79
add esp, -4
mov ebx, ebp
add ebx, -11
mov [esp], ebx
;Loading B4 -83
add esp, -4
mov ebx, ebp
add ebx, -10
mov [esp], ebx
;Loading B3 -87
add esp, -4
mov ebx, ebp
add ebx, -9
mov [esp], ebx
;Loading B2 -91
add esp, -4
mov ebx, ebp
add ebx, -5
mov [esp], ebx
;Loading [149 -95
add esp, -4
mov ebx, ebp
add ebx, -79
mov [esp], ebx
call OutputByte5
add esp, 20
add esp, -1

mov byte [esp], 1

;Declaring [150 -80
;Adding return value 
add esp, -1
;Loading [150 -81
add esp, -4
mov ebx, ebp
add ebx, -80
mov [esp], ebx
;Loading a Byte object
add esp, -4
mov ebx, ebp
add ebx, -64
mov [esp], ebx
call Byte__On_Plus
add esp, 8
add esp, -1

mov byte [esp], 2

;Declaring [152 -82
;Adding return value 
add esp, -1
;Loading [152 -83
add esp, -4
mov ebx, ebp
add ebx, -82
mov [esp], ebx
;Loading a Byte object
add esp, -4
mov ebx, ebp
add ebx, -64
mov [esp], ebx
call Byte__On_Plus
add esp, 8
add esp, -1

mov byte [esp], 3

;Declaring [154 -84
;Adding return value 
add esp, -1
;Loading [154 -85
add esp, -4
mov ebx, ebp
add ebx, -84
mov [esp], ebx
;Loading a Byte object
add esp, -4
mov ebx, ebp
add ebx, -64
mov [esp], ebx
call Byte__On_Plus
add esp, 8
add esp, -1

mov byte [esp], 4

;Declaring [156 -86
;Adding return value 
add esp, -1
;Loading [156 -87
add esp, -4
mov ebx, ebp
add ebx, -86
mov [esp], ebx
;Loading a Byte object
add esp, -4
mov ebx, ebp
add ebx, -64
mov [esp], ebx
call Byte__On_Plus
add esp, 8
add esp, -1

mov byte [esp], 5

;Declaring [158 -88
;Adding return value 
add esp, -1
;Loading [158 -89
add esp, -4
mov ebx, ebp
add ebx, -88
mov [esp], ebx
;Loading a Byte object
add esp, -4
mov ebx, ebp
add ebx, -64
mov [esp], ebx
call Byte__On_Plus
add esp, 8
;Loading [159 -89
add esp, -4
mov ebx, ebp
add ebx, -89
mov [esp], ebx
;Loading [151 -93
add esp, -4
mov ebx, ebp
add ebx, -81
mov [esp], ebx
;Loading [153 -97
add esp, -4
mov ebx, ebp
add ebx, -83
mov [esp], ebx
;Loading [155 -101
add esp, -4
mov ebx, ebp
add ebx, -85
mov [esp], ebx
;Loading [157 -105
add esp, -4
mov ebx, ebp
add ebx, -87
mov [esp], ebx
call OutputByte5
add esp, 20
add esp, -1

mov byte [esp], 1

;Declaring [160 -90
;Adding return value 
add esp, -1
;Loading [160 -91
add esp, -4
mov ebx, ebp
add ebx, -90
mov [esp], ebx
;Loading a Byte object
add esp, -4
mov ebx, ebp
add ebx, -64
mov [esp], ebx
call Byte__On_Plus
add esp, 8
add esp, -1

mov byte [esp], 2

;Declaring [162 -92
;Adding return value 
add esp, -1
;Loading [162 -93
add esp, -4
mov ebx, ebp
add ebx, -92
mov [esp], ebx
;Loading a Byte object
add esp, -4
mov ebx, ebp
add ebx, -64
mov [esp], ebx
call Byte__On_Plus
add esp, 8
;Loading [163 -93
add esp, -4
mov ebx, ebp
add ebx, -93
mov [esp], ebx
;Loading S6 -97
add esp, -4
mov ebx, ebp
add ebx, -64
mov [esp], ebx
;Loading [161 -101
add esp, -4
mov ebx, ebp
add ebx, -91
mov [esp], ebx
call OutputByte3
add esp, 12
add esp, -1

mov byte [esp], 1

;Declaring [164 -94
;Adding return value 
add esp, -1
;Loading [164 -95
add esp, -4
mov ebx, ebp
add ebx, -94
mov [esp], ebx
;Loading a Byte object
add esp, -4
mov ebx, ebp
add ebx, -64
mov [esp], ebx
call Byte__On_Plus
add esp, 8
add esp, -1

mov byte [esp], 1

;Declaring [166 -96
;Adding return value 
add esp, -1
;Loading [166 -97
add esp, -4
mov ebx, ebp
add ebx, -96
mov [esp], ebx
;Loading a Byte object
add esp, -4
mov ebx, ebp
add ebx, -64
mov [esp], ebx
call Byte__On_Plus
add esp, 8
add esp, -1

mov byte [esp], 1

;Declaring [168 -98
;Adding return value 
add esp, -1
;Loading [168 -99
add esp, -4
mov ebx, ebp
add ebx, -98
mov [esp], ebx
;Loading a Byte object
add esp, -4
mov ebx, ebp
add ebx, -97
mov [esp], ebx
call Byte__On_Plus
add esp, 8
add esp, -1

mov byte [esp], 1

;Declaring [170 -100
;Adding return value 
add esp, -1
;Loading [170 -101
add esp, -4
mov ebx, ebp
add ebx, -100
mov [esp], ebx
;Loading a Byte object
add esp, -4
mov ebx, ebp
add ebx, -64
mov [esp], ebx
call Byte__On_Plus
add esp, 8
add esp, -1

mov byte [esp], 1

;Declaring [172 -102
;Adding return value 
add esp, -1
;Loading [172 -103
add esp, -4
mov ebx, ebp
add ebx, -102
mov [esp], ebx
;Loading a Byte object
add esp, -4
mov ebx, ebp
add ebx, -101
mov [esp], ebx
call Byte__On_Plus
add esp, 8
add esp, -1

mov byte [esp], 1

;Declaring [174 -104
;Adding return value 
add esp, -1
;Loading [174 -105
add esp, -4
mov ebx, ebp
add ebx, -104
mov [esp], ebx
;Loading a Byte object
add esp, -4
mov ebx, ebp
add ebx, -103
mov [esp], ebx
call Byte__On_Plus
add esp, 8
add esp, -1

mov byte [esp], 4

;Declaring [176 -106
;Adding return value 
add esp, -1
;Loading [176 -107
add esp, -4
mov ebx, ebp
add ebx, -106
mov [esp], ebx
;Loading a Byte object
add esp, -4
mov ebx, ebp
add ebx, -64
mov [esp], ebx
call Byte__On_Plus
add esp, 8
add esp, -1

mov byte [esp], 5

;Declaring [178 -108
;Adding return value 
add esp, -1
;Loading [178 -109
add esp, -4
mov ebx, ebp
add ebx, -108
mov [esp], ebx
;Loading a Byte object
add esp, -4
mov ebx, ebp
add ebx, -64
mov [esp], ebx
call Byte__On_Plus
add esp, 8
;Loading [179 -109
add esp, -4
mov ebx, ebp
add ebx, -109
mov [esp], ebx
;Loading [165 -113
add esp, -4
mov ebx, ebp
add ebx, -95
mov [esp], ebx
;Loading [169 -117
add esp, -4
mov ebx, ebp
add ebx, -99
mov [esp], ebx
;Loading [175 -121
add esp, -4
mov ebx, ebp
add ebx, -105
mov [esp], ebx
;Loading [177 -125
add esp, -4
mov ebx, ebp
add ebx, -107
mov [esp], ebx
call OutputByte5
add esp, 20
;Loading S6 -109
add esp, -4
mov ebx, ebp
add ebx, -64
mov [esp], ebx
call OutputByte
add esp, 4
;Loading S6 -109
add esp, -4
mov ebx, ebp
add ebx, -64
mov [esp], ebx
call OutputByte
add esp, 4
add esp, -1

mov byte [esp], 1

;Declaring [180 -110
;Adding return value 
add esp, -1
;Loading [180 -111
add esp, -4
mov ebx, ebp
add ebx, -110
mov [esp], ebx
;Loading a Byte object
add esp, -4
mov ebx, ebp
add ebx, -64
mov [esp], ebx
call Byte__On_Plus
add esp, 8
;Loading [181 -111
add esp, -4
mov ebx, ebp
add ebx, -111
mov [esp], ebx
call OutputByte
add esp, 4
;Loading S6 -111
add esp, -4
mov ebx, ebp
add ebx, -64
mov [esp], ebx
call IndirectionOutput
add esp, 4
;Loading S6 -111
add esp, -4
mov ebx, ebp
add ebx, -64
mov [esp], ebx
call IndirectionAddOutput
add esp, 4
;Loading S6 -111
add esp, -4
mov ebx, ebp
add ebx, -64
mov [esp], ebx
call IndirectionAddTwoOutput
add esp, 4
;Declaring T1 -112
add esp, -1

add esp, -4
mov ebx, ebp
add ebx, -112
mov [esp], ebx
call Byte__On_Create
add esp, 4
;Loading S6 -112
add esp, -4
mov ebx, ebp
add ebx, -64
mov [esp], ebx
;Loading a Byte object
add esp, -4
mov ebx, ebp
add ebx, -112
mov [esp], ebx
call Byte__On_Equals
add esp, 8
;Declaring T2 -113
add esp, -1

add esp, -4
mov ebx, ebp
add ebx, -113
mov [esp], ebx
call Byte__On_Create
add esp, 4
add esp, -1

mov byte [esp], 1

;Declaring [182 -114
;Loading [182 -114
add esp, -4
mov ebx, ebp
add ebx, -114
mov [esp], ebx
;Loading a Byte object
add esp, -4
mov ebx, ebp
add ebx, -113
mov [esp], ebx
call Byte__On_Equals
add esp, 8
;Loading T1 -114
add esp, -4
mov ebx, ebp
add ebx, -112
mov [esp], ebx
call OutputByte
add esp, 4
;Adding return value 
add esp, -1
;Loading T2 -115
add esp, -4
mov ebx, ebp
add ebx, -113
mov [esp], ebx
;Loading a Byte object
add esp, -4
mov ebx, ebp
add ebx, -64
mov [esp], ebx
call Byte__On_Plus
add esp, 8
;Loading [183 -115
add esp, -4
mov ebx, ebp
add ebx, -115
mov [esp], ebx
call OutputByte
add esp, 4
;Adding return value 
add esp, -1
;Loading T2 -116
add esp, -4
mov ebx, ebp
add ebx, -113
mov [esp], ebx
;Loading a Byte object
add esp, -4
mov ebx, ebp
add ebx, -64
mov [esp], ebx
call Byte__On_Plus
add esp, 8
;Loading [184 -116
add esp, -4
mov ebx, ebp
add ebx, -116
mov [esp], ebx
call IndirectionAddOutput
add esp, 4
;Declaring c -118
add esp, -2

add esp, -4
mov ebx, ebp
add ebx, -118
mov [esp], ebx
call CapTest__On_Create
add esp, 4
;ok-118
add esp, -1

mov byte [esp], 65

;Declaring [186 -119
;Loading [186 -119
add esp, -4
mov ebx, ebp
add ebx, -119
mov [esp], ebx
;Loading a Byte object
add esp, -4
mov ebx, ebp
add ebx, -118
mov [esp], ebx
call Byte__On_Equals
add esp, 8
;ok-118
;Loading [187 -119
add esp, -4
mov ebx, ebp
add ebx, -118
mov [esp], ebx
call OutputByte
add esp, 4
;ok-117
add esp, -1

mov byte [esp], 4

;Declaring [189 -120
;Loading [189 -120
add esp, -4
mov ebx, ebp
add ebx, -120
mov [esp], ebx
;Loading a Byte object
add esp, -4
mov ebx, ebp
add ebx, -117
mov [esp], ebx
call Byte__On_Equals
add esp, 8
;ok-118
;ok-118
;ok-117
;Adding return value 
add esp, -1
;Loading [192 -121
add esp, -4
mov ebx, ebp
add ebx, -117
mov [esp], ebx
;Loading a Byte object
add esp, -4
mov ebx, ebp
add ebx, -118
mov [esp], ebx
call Byte__On_Plus
add esp, 8
;Loading [193 -121
add esp, -4
mov ebx, ebp
add ebx, -121
mov [esp], ebx
;Loading a Byte object
add esp, -4
mov ebx, ebp
add ebx, -118
mov [esp], ebx
call Byte__On_Equals
add esp, 8
;ok-118
;Loading [194 -121
add esp, -4
mov ebx, ebp
add ebx, -118
mov [esp], ebx
call OutputByte
add esp, 4
;ok-118
;Loading [195 -121
add esp, -4
mov ebx, ebp
add ebx, -118
mov [esp], ebx
call OutputByte
add esp, 4
;ok-118
;Loading [196 -121
add esp, -4
mov ebx, ebp
add ebx, -118
mov [esp], ebx
call OutputByte
add esp, 4
;ok-118
;Loading [197 -121
add esp, -4
mov ebx, ebp
add ebx, -118
mov [esp], ebx
call OutputByte
add esp, 4
;ok-118
;Loading [198 -121
add esp, -4
mov ebx, ebp
add ebx, -118
mov [esp], ebx
call OutputByte
add esp, 4
;ok-118
;Loading [199 -121
add esp, -4
mov ebx, ebp
add ebx, -118
mov [esp], ebx
call OutputByte
add esp, 4
;ok-118
;Loading [200 -121
add esp, -4
mov ebx, ebp
add ebx, -118
mov [esp], ebx
call OutputByte
add esp, 4
;ok-118
;Loading [201 -121
add esp, -4
mov ebx, ebp
add ebx, -118
mov [esp], ebx
call OutputByte
add esp, 4
;ok-118
;Loading [202 -121
add esp, -4
mov ebx, ebp
add ebx, -118
mov [esp], ebx
call OutputByte
add esp, 4
;ok-118
;ok-118
;ok-117
;Adding return value 
add esp, -1
;Loading [205 -122
add esp, -4
mov ebx, ebp
add ebx, -117
mov [esp], ebx
;Loading a Byte object
add esp, -4
mov ebx, ebp
add ebx, -118
mov [esp], ebx
call Byte__On_Plus
add esp, 8
;Loading [206 -122
add esp, -4
mov ebx, ebp
add ebx, -122
mov [esp], ebx
;Loading a Byte object
add esp, -4
mov ebx, ebp
add ebx, -118
mov [esp], ebx
call Byte__On_Equals
add esp, 8
;ok-118
;Loading [207 -122
add esp, -4
mov ebx, ebp
add ebx, -118
mov [esp], ebx
call OutputByte
add esp, 4
;ok-118
;Loading [208 -122
add esp, -4
mov ebx, ebp
add ebx, -118
mov [esp], ebx
call OutputByte
add esp, 4
;Declaring ct -126
add esp, -4

add esp, -4
mov ebx, ebp
add ebx, -126
mov [esp], ebx
call CapTest2__On_Create
add esp, 4
;ok-126
;ok-126
;ok-118
;Loading [211 -126
add esp, -4
mov ebx, ebp
add ebx, -118
mov [esp], ebx
;Loading a Byte object
add esp, -4
mov ebx, ebp
add ebx, -126
mov [esp], ebx
call Byte__On_Equals
add esp, 8
;ok-118
;Loading [212 -126
add esp, -4
mov ebx, ebp
add ebx, -118
mov [esp], ebx
call OutputByte
add esp, 4
;ok-126
;ok-126
;Loading [214 -126
add esp, -4
mov ebx, ebp
add ebx, -126
mov [esp], ebx
call OutputByte
add esp, 4
;ok-126
;ok-126
;ok-126
;ok-126
;ok-117
;Adding return value 
add esp, -1
;Loading [219 -127
add esp, -4
mov ebx, ebp
add ebx, -117
mov [esp], ebx
;Loading a Byte object
add esp, -4
mov ebx, ebp
add ebx, -126
mov [esp], ebx
call Byte__On_Plus
add esp, 8
;Loading [220 -127
add esp, -4
mov ebx, ebp
add ebx, -127
mov [esp], ebx
;Loading a Byte object
add esp, -4
mov ebx, ebp
add ebx, -126
mov [esp], ebx
call Byte__On_Equals
add esp, 8
;ok-126
;ok-126
;Loading [222 -127
add esp, -4
mov ebx, ebp
add ebx, -126
mov [esp], ebx
call OutputByte
add esp, 4
;ok-118
;Loading [223 -127
add esp, -4
mov ebx, ebp
add ebx, -118
mov [esp], ebx
call OutputByte
add esp, 4
;ok-124
;ok-123
;ok-126
;ok-126
;ok-117
;Adding return value 
add esp, -1
;Loading [228 -128
add esp, -4
mov ebx, ebp
add ebx, -117
mov [esp], ebx
;Loading a Byte object
add esp, -4
mov ebx, ebp
add ebx, -126
mov [esp], ebx
call Byte__On_Plus
add esp, 8
;Loading [229 -128
add esp, -4
mov ebx, ebp
add ebx, -128
mov [esp], ebx
;Loading a Byte object
add esp, -4
mov ebx, ebp
add ebx, -123
mov [esp], ebx
call Byte__On_Equals
add esp, 8
;ok-124
;ok-123
;Loading [231 -128
add esp, -4
mov ebx, ebp
add ebx, -123
mov [esp], ebx
call OutputByte
add esp, 4
;ok-124
;ok-123
;Loading [233 -128
add esp, -4
mov ebx, ebp
add ebx, -123
mov [esp], ebx
call OutputByte
add esp, 4
;ok-118
;Loading [234 -128
add esp, -4
mov ebx, ebp
add ebx, -118
mov [esp], ebx
call OutputByte
add esp, 4
;Declaring CST -130
add esp, -2

add esp, -4
mov ebx, ebp
add ebx, -130
mov [esp], ebx
call ClassScopeTest__On_Create
add esp, 4
;ok-130
;Loading [235 -130
add esp, -4
mov ebx, ebp
add ebx, -130
mov [esp], ebx
call OutputByte
add esp, 4
;Loading S6 -130
add esp, -4
mov ebx, ebp
add ebx, -64
mov [esp], ebx
;Loading a ClassScopeTest object
add esp, -4
mov ebx, ebp
add ebx, -130
mov [esp], ebx
call ClassScopeTest__RunTest
add esp, 8
;ok-130
;Loading [236 -130
add esp, -4
mov ebx, ebp
add ebx, -130
mov [esp], ebx
call OutputByte
add esp, 4
;ok-118
;Loading [237 -130
add esp, -4
mov ebx, ebp
add ebx, -118
mov [esp], ebx
call OutputByte
add esp, 4
add esp, -1

mov byte [esp], 66

;Declaring [238 -131
;Loading [238 -131
add esp, -4
mov ebx, ebp
add ebx, -131
mov [esp], ebx
call OutputByte
add esp, 4
;Declaring CST2 -133
add esp, -2

add esp, -4
mov ebx, ebp
add ebx, -133
mov [esp], ebx
call ClassScopeTest__On_Create
add esp, 4
;ok-133
;Loading [239 -133
add esp, -4
mov ebx, ebp
add ebx, -133
mov [esp], ebx
call OutputByte
add esp, 4
;Declaring CST2_1 -135
add esp, -2

add esp, -4
mov ebx, ebp
add ebx, -135
mov [esp], ebx
call ClassScopeTestTwo__On_Create
add esp, 4
;ok-135
;ok-134
;Loading [241 -135
add esp, -4
mov ebx, ebp
add ebx, -134
mov [esp], ebx
call OutputByte
add esp, 4
;ok-135
;ok-135
add esp, -1

mov byte [esp], 69

;Declaring [244 -136
;Loading [244 -136
add esp, -4
mov ebx, ebp
add ebx, -136
mov [esp], ebx
;Loading a Byte object
add esp, -4
mov ebx, ebp
add ebx, -135
mov [esp], ebx
call Byte__On_Equals
add esp, 8
;ok-135
;ok-135
;Loading [246 -136
add esp, -4
mov ebx, ebp
add ebx, -135
mov [esp], ebx
call OutputByte
add esp, 4
;ok-135
;ok-135
add esp, -1

mov byte [esp], 70

;Declaring [249 -137
;Loading [249 -137
add esp, -4
mov ebx, ebp
add ebx, -137
mov [esp], ebx
;Loading a Byte object
add esp, -4
mov ebx, ebp
add ebx, -135
mov [esp], ebx
call Byte__On_Equals
add esp, 8
;ok-135
;ok-135
;Loading [251 -137
add esp, -4
mov ebx, ebp
add ebx, -135
mov [esp], ebx
call OutputByte
add esp, 4
;Loading S6 -137
add esp, -4
mov ebx, ebp
add ebx, -64
mov [esp], ebx
;Loading a ClassScopeTestTwo object
add esp, -4
mov ebx, ebp
add ebx, -135
mov [esp], ebx
call ClassScopeTestTwo__RunTest
add esp, 8
;ok-135
;ok-134
;Loading [253 -137
add esp, -4
mov ebx, ebp
add ebx, -134
mov [esp], ebx
call OutputByte
add esp, 4
add esp, -1

mov byte [esp], 66

;Declaring [254 -138
;Loading [254 -138
add esp, -4
mov ebx, ebp
add ebx, -138
mov [esp], ebx
call OutputByte
add esp, 4
;Declaring BR1 -142
add esp, -4

;ok-135
;ok-134
mov ebx, ebp
add ebx, -134
mov ecx, ebx
mov ebx, ebp
add ebx, -142
mov [ebx], ecx
;Loading BR1 -142
add esp, -4
mov ebx, ebp
add ebx, -142
mov ebx, [ebx]
add ebx, 0
mov [esp], ebx
; loading a reference!BR1
call OutputByte
add esp, 4
;Declaring BR2 -146
add esp, -4

mov ebx, ebp
add ebx, -142
mov ebx, [ebx]
mov ecx, ebx
mov ebx, ebp
add ebx, -146
mov [ebx], ecx
;Loading BR2 -146
add esp, -4
mov ebx, ebp
add ebx, -146
mov ebx, [ebx]
add ebx, 0
mov [esp], ebx
; loading a reference!BR2
call OutputByte
add esp, 4
;Declaring TestCST -148
add esp, -2

add esp, -4
mov ebx, ebp
add ebx, -148
mov [esp], ebx
call ClassScopeTest__On_Create
add esp, 4
;Declaring CSTR -152
add esp, -4

mov ebx, ebp
add ebx, -148
mov ecx, ebx
mov ebx, ebp
add ebx, -152
mov [ebx], ecx
;ok-148
add esp, -1

mov byte [esp], 100

;Declaring [258 -153
;Loading [258 -153
add esp, -4
mov ebx, ebp
add ebx, -153
mov [esp], ebx
;Loading a Byte object
add esp, -4
mov ebx, ebp
add ebx, -148
mov [esp], ebx
call Byte__On_Equals
add esp, 8
;ok-148
;Loading [259 -153
add esp, -4
mov ebx, ebp
add ebx, -148
mov [esp], ebx
call OutputByte
add esp, 4
add esp, -1

mov byte [esp], 66

;Declaring [260 -154
;Loading [260 -154
add esp, -4
mov ebx, ebp
add ebx, -154
mov [esp], ebx
;Loading a ClassScopeTest object
add esp, -4
mov ebx, ebp
add ebx, -152
mov ebx, [ebx]
add ebx, 0
mov [esp], ebx
; loading a reference!CSTR
call ClassScopeTest__RunTest
add esp, 8
;ok-148
;Loading [261 -154
add esp, -4
mov ebx, ebp
add ebx, -148
mov [esp], ebx
call OutputByte
add esp, 4
call NoParamTest
add esp, 0
;Declaring DMT -154
add esp, 0

add esp, -4
mov ebx, ebp
add ebx, -154
mov [esp], ebx
call DoubleMethodTest__On_Create
add esp, 4
;Loading a DoubleMethodTest object
add esp, -4
mov ebx, ebp
add ebx, -154
mov [esp], ebx
call DoubleMethodTest__Method2
add esp, 4
;Declaring RetTest -155
add esp, -1

add esp, -4
mov ebx, ebp
add ebx, -155
mov [esp], ebx
call Byte__On_Create
add esp, 4
;Adding return value 
add esp, -1
call ReturnTest
add esp, 0
;Loading [262 -156
add esp, -4
mov ebx, ebp
add ebx, -156
mov [esp], ebx
;Loading a Byte object
add esp, -4
mov ebx, ebp
add ebx, -155
mov [esp], ebx
call Byte__On_Equals
add esp, 8
;Loading RetTest -156
add esp, -4
mov ebx, ebp
add ebx, -155
mov [esp], ebx
call OutputByte
add esp, 4
;Declaring RTC -156
add esp, 0

add esp, -4
mov ebx, ebp
add ebx, -156
mov [esp], ebx
call RetTestCls__On_Create
add esp, 4
;Adding return value 
add esp, -1
;Loading a RetTestCls object
add esp, -4
mov ebx, ebp
add ebx, -156
mov [esp], ebx
call RetTestCls__RetTe
add esp, 4
;Loading [263 -157
add esp, -4
mov ebx, ebp
add ebx, -157
mov [esp], ebx
;Loading a Byte object
add esp, -4
mov ebx, ebp
add ebx, -155
mov [esp], ebx
call Byte__On_Equals
add esp, 8
;Loading RetTest -157
add esp, -4
mov ebx, ebp
add ebx, -155
mov [esp], ebx
call OutputByte
add esp, 4
;Declaring RetTest2 -158
add esp, -1

add esp, -4
mov ebx, ebp
add ebx, -158
mov [esp], ebx
call Byte__On_Create
add esp, 4
add esp, -1

mov byte [esp], 72

;Declaring [264 -159
;Adding return value 
add esp, -1
;Loading [264 -160
add esp, -4
mov ebx, ebp
add ebx, -159
mov [esp], ebx
call ReturnTest2
add esp, 4
;Loading [265 -160
add esp, -4
mov ebx, ebp
add ebx, -160
mov [esp], ebx
;Loading a Byte object
add esp, -4
mov ebx, ebp
add ebx, -158
mov [esp], ebx
call Byte__On_Equals
add esp, 8
;Loading RetTest2 -160
add esp, -4
mov ebx, ebp
add ebx, -158
mov [esp], ebx
call OutputByte
add esp, 4
add esp, -1

mov byte [esp], 65

;Declaring [266 -161
;Adding return value 
add esp, -1
;Loading [266 -162
add esp, -4
mov ebx, ebp
add ebx, -161
mov [esp], ebx
;Loading a Byte object
add esp, -4
mov ebx, ebp
add ebx, -64
mov [esp], ebx
call Byte__On_If_Equal
add esp, 8
mov byte cl, [esp]
test cl, cl
je S29

;Declaring MeByte -163
add esp, -1

add esp, -4
mov ebx, ebp
add ebx, -163
mov [esp], ebx
call Byte__On_Create
add esp, 4
add esp, -1

mov byte [esp], 2

;Declaring [268 -164
;Adding return value 
add esp, -1
;Loading [268 -165
add esp, -4
mov ebx, ebp
add ebx, -164
mov [esp], ebx
;Loading a Byte object
add esp, -4
mov ebx, ebp
add ebx, -163
mov [esp], ebx
call Byte__On_Plus
add esp, 8
;Loading [269 -165
add esp, -4
mov ebx, ebp
add ebx, -165
mov [esp], ebx
;Loading a Byte object
add esp, -4
mov ebx, ebp
add ebx, -163
mov [esp], ebx
call Byte__On_Equals
add esp, 8
add esp, 5
jmp S30
S29:
add esp, 2
S30:
;Declaring joe -164
add esp, -4

add esp, -4
mov ebx, ebp
add ebx, -164
mov [esp], ebx
call Pointer__On_Create
add esp, 4
;Declaring Size -165
add esp, -1

add esp, -4
mov ebx, ebp
add ebx, -165
mov [esp], ebx
call Byte__On_Create
add esp, 4
add esp, -1

mov byte [esp], 128

;Declaring [270 -166
;Loading [270 -166
add esp, -4
mov ebx, ebp
add ebx, -166
mov [esp], ebx
;Loading a Byte object
add esp, -4
mov ebx, ebp
add ebx, -165
mov [esp], ebx
call Byte__On_Equals
add esp, 8
;Declaring TestSize -170
add esp, -4

add esp, -4
mov ebx, ebp
add ebx, -170
mov [esp], ebx
call Integer__On_Create
add esp, 4
add esp, -1

mov byte [esp], 85

;Declaring [271 -171
;Loading [271 -171
add esp, -4
mov ebx, ebp
add ebx, -171
mov [esp], ebx
call OutputByte
add esp, 4
;Declaring DB -175
add esp, -4

add esp, -4
mov ebx, ebp
add ebx, -175
mov [esp], ebx
call Pointer__On_Create
add esp, 4
;Adding return value 
add esp, -4
;Loading Size -179
add esp, -4
mov ebx, ebp
add ebx, -165
mov [esp], ebx
call AllocateHeapMemory
add esp, 4
;Loading [272 -179
add esp, -4
mov ebx, ebp
add ebx, -179
mov [esp], ebx
;Loading a Pointer object
add esp, -4
mov ebx, ebp
add ebx, -175
mov [esp], ebx
call Pointer__On_Equals
add esp, 8
add esp, -1

mov byte [esp], 0

;Declaring [273 -180
;Loading [273 -180
add esp, -4
mov ebx, ebp
add ebx, -180
mov [esp], ebx
;Loading a Byte object
add esp, -4
mov ebx, ebp
add ebx, -64
mov [esp], ebx
call Byte__On_Equals
add esp, 8
S31:
add esp, -1

mov byte [esp], 10

;Declaring [274 -181
;Adding return value 
add esp, -1
;Loading [274 -182
add esp, -4
mov ebx, ebp
add ebx, -181
mov [esp], ebx
;Loading a Byte object
add esp, -4
mov ebx, ebp
add ebx, -64
mov [esp], ebx
call Byte__On_Less_Than
add esp, 8
mov byte cl, [esp]
test cl, cl
je S32

;Declaring NewByte -183
add esp, -1

add esp, -4
mov ebx, ebp
add ebx, -183
mov [esp], ebx
call Byte__On_Create
add esp, 4
add esp, -1

mov byte [esp], 65

;Declaring [276 -184
;Loading [276 -184
add esp, -4
mov ebx, ebp
add ebx, -184
mov [esp], ebx
;Loading a Byte object
add esp, -4
mov ebx, ebp
add ebx, -183
mov [esp], ebx
call Byte__On_Equals
add esp, 8
;Loading NewByte -184
add esp, -4
mov ebx, ebp
add ebx, -183
mov [esp], ebx
;Loading S6 -188
add esp, -4
mov ebx, ebp
add ebx, -64
mov [esp], ebx
;Loading DB -192
add esp, -4
mov ebx, ebp
add ebx, -175
mov [esp], ebx
call SetByteInDynam
add esp, 12
;Loading NewByte -184
add esp, -4
mov ebx, ebp
add ebx, -183
mov [esp], ebx
call OutputByte
add esp, 4
add esp, -1

mov byte [esp], 1

;Declaring [277 -185
;Adding return value 
add esp, -1
;Loading [277 -186
add esp, -4
mov ebx, ebp
add ebx, -185
mov [esp], ebx
;Loading a Byte object
add esp, -4
mov ebx, ebp
add ebx, -64
mov [esp], ebx
call Byte__On_Plus
add esp, 8
;Loading [278 -186
add esp, -4
mov ebx, ebp
add ebx, -186
mov [esp], ebx
;Loading a Byte object
add esp, -4
mov ebx, ebp
add ebx, -64
mov [esp], ebx
call Byte__On_Equals
add esp, 8
add esp, 6
jmp S31
S32:
add esp, 2
;Declaring TeTe -181
add esp, -1

add esp, -4
mov ebx, ebp
add ebx, -181
mov [esp], ebx
call TemplateTest__Byte__On_Create
add esp, 4
;Declaring MuTeTe -187
add esp, -6

add esp, -4
mov ebx, ebp
add ebx, -187
mov [esp], ebx
call MultiTemplateTest__Byte__Byte__Integer__On_Create
add esp, 4
;Declaring RefTeTe -193
add esp, -6

add esp, -4
mov ebx, ebp
add ebx, -193
mov [esp], ebx
call RefTemplateTest__Byte__Byte__Integer__On_Create
add esp, 4
;Declaring MyByte -194
add esp, -1

add esp, -4
mov ebx, ebp
add ebx, -194
mov [esp], ebx
call Byte__On_Create
add esp, 4
add esp, -1

mov byte [esp], 67

;Declaring [292 -195
;Loading [292 -195
add esp, -4
mov ebx, ebp
add ebx, -195
mov [esp], ebx
;Loading a Byte object
add esp, -4
mov ebx, ebp
add ebx, -194
mov [esp], ebx
call Byte__On_Equals
add esp, 8
;Declaring MyByteArray -201
add esp, -6

add esp, -4
mov ebx, ebp
add ebx, -201
mov [esp], ebx
call Array__Byte__On_Create
add esp, 4
;Loading MyByte -201
add esp, -4
mov ebx, ebp
add ebx, -194
mov [esp], ebx
call OutputByte
add esp, 4
add esp, -1

mov byte [esp], 10

;Declaring [334 -202
;Loading [334 -202
add esp, -4
mov ebx, ebp
add ebx, -202
mov [esp], ebx
;Loading a Array object
add esp, -4
mov ebx, ebp
add ebx, -201
mov [esp], ebx
call Array__Byte__Resize
add esp, 8
add esp, -1

mov byte [esp], 70

;Declaring [335 -203
;Loading [335 -203
add esp, -4
mov ebx, ebp
add ebx, -203
mov [esp], ebx
;Loading a Byte object
add esp, -4
mov ebx, ebp
add ebx, -194
mov [esp], ebx
call Byte__On_Equals
add esp, 8
;Loading MyByte -203
add esp, -4
mov ebx, ebp
add ebx, -194
mov [esp], ebx
call OutputByte
add esp, 4
;Loading MyByte -203
add esp, -4
mov ebx, ebp
add ebx, -194
mov [esp], ebx
call OutputByte
add esp, 4
;Loading MyByte -203
add esp, -4
mov ebx, ebp
add ebx, -194
mov [esp], ebx
call OutputByte
add esp, 4
add esp, -1

mov byte [esp], 0

;Declaring [336 -204
add esp, -1

mov byte [esp], 68

;Declaring [337 -205
;Loading [337 -205
add esp, -4
mov ebx, ebp
add ebx, -205
mov [esp], ebx
;Loading [336 -209
add esp, -4
mov ebx, ebp
add ebx, -204
mov [esp], ebx
;Loading a Array object
add esp, -4
mov ebx, ebp
add ebx, -201
mov [esp], ebx
call Array__Byte__SetAt
add esp, 12
;Loading MyByte -205
add esp, -4
mov ebx, ebp
add ebx, -194
mov [esp], ebx
call OutputByte
add esp, 4
add esp, -1

mov byte [esp], 1

;Declaring [338 -206
add esp, -1

mov byte [esp], 69

;Declaring [339 -207
;Loading [339 -207
add esp, -4
mov ebx, ebp
add ebx, -207
mov [esp], ebx
;Loading [338 -211
add esp, -4
mov ebx, ebp
add ebx, -206
mov [esp], ebx
;Loading a Array object
add esp, -4
mov ebx, ebp
add ebx, -201
mov [esp], ebx
call Array__Byte__SetAt
add esp, 12
add esp, -1

mov byte [esp], 2

;Declaring [340 -208
add esp, -1

mov byte [esp], 70

;Declaring [341 -209
;Loading [341 -209
add esp, -4
mov ebx, ebp
add ebx, -209
mov [esp], ebx
;Loading [340 -213
add esp, -4
mov ebx, ebp
add ebx, -208
mov [esp], ebx
;Loading a Array object
add esp, -4
mov ebx, ebp
add ebx, -201
mov [esp], ebx
call Array__Byte__SetAt
add esp, 12
add esp, -1

mov byte [esp], 3

;Declaring [342 -210
add esp, -1

mov byte [esp], 68

;Declaring [343 -211
;Loading [343 -211
add esp, -4
mov ebx, ebp
add ebx, -211
mov [esp], ebx
;Loading [342 -215
add esp, -4
mov ebx, ebp
add ebx, -210
mov [esp], ebx
;Loading a Array object
add esp, -4
mov ebx, ebp
add ebx, -201
mov [esp], ebx
call Array__Byte__SetAt
add esp, 12
add esp, -1

mov byte [esp], 4

;Declaring [344 -212
add esp, -1

mov byte [esp], 65

;Declaring [345 -213
;Loading [345 -213
add esp, -4
mov ebx, ebp
add ebx, -213
mov [esp], ebx
;Loading [344 -217
add esp, -4
mov ebx, ebp
add ebx, -212
mov [esp], ebx
;Loading a Array object
add esp, -4
mov ebx, ebp
add ebx, -201
mov [esp], ebx
call Array__Byte__SetAt
add esp, 12
add esp, -1

mov byte [esp], 5

;Declaring [346 -214
add esp, -1

mov byte [esp], 68

;Declaring [347 -215
;Loading [347 -215
add esp, -4
mov ebx, ebp
add ebx, -215
mov [esp], ebx
;Loading [346 -219
add esp, -4
mov ebx, ebp
add ebx, -214
mov [esp], ebx
;Loading a Array object
add esp, -4
mov ebx, ebp
add ebx, -201
mov [esp], ebx
call Array__Byte__SetAt
add esp, 12
add esp, -1

mov byte [esp], 0

;Declaring [348 -216
;Adding return value 
add esp, -1
;Loading [348 -217
add esp, -4
mov ebx, ebp
add ebx, -216
mov [esp], ebx
;Loading a Array object
add esp, -4
mov ebx, ebp
add ebx, -201
mov [esp], ebx
call Array__Byte__GetAt
add esp, 8
;Loading [349 -217
add esp, -4
mov ebx, ebp
add ebx, -217
mov [esp], ebx
;Loading a Byte object
add esp, -4
mov ebx, ebp
add ebx, -194
mov [esp], ebx
call Byte__On_Equals
add esp, 8
;Loading MyByte -217
add esp, -4
mov ebx, ebp
add ebx, -194
mov [esp], ebx
call OutputByte
add esp, 4
add esp, -1

mov byte [esp], 1

;Declaring [350 -218
;Adding return value 
add esp, -1
;Loading [350 -219
add esp, -4
mov ebx, ebp
add ebx, -218
mov [esp], ebx
;Loading a Array object
add esp, -4
mov ebx, ebp
add ebx, -201
mov [esp], ebx
call Array__Byte__GetAt
add esp, 8
;Loading [351 -219
add esp, -4
mov ebx, ebp
add ebx, -219
mov [esp], ebx
;Loading a Byte object
add esp, -4
mov ebx, ebp
add ebx, -194
mov [esp], ebx
call Byte__On_Equals
add esp, 8
;Loading MyByte -219
add esp, -4
mov ebx, ebp
add ebx, -194
mov [esp], ebx
call OutputByte
add esp, 4
add esp, -1

mov byte [esp], 2

;Declaring [352 -220
;Adding return value 
add esp, -1
;Loading [352 -221
add esp, -4
mov ebx, ebp
add ebx, -220
mov [esp], ebx
;Loading a Array object
add esp, -4
mov ebx, ebp
add ebx, -201
mov [esp], ebx
call Array__Byte__GetAt
add esp, 8
;Loading [353 -221
add esp, -4
mov ebx, ebp
add ebx, -221
mov [esp], ebx
;Loading a Byte object
add esp, -4
mov ebx, ebp
add ebx, -194
mov [esp], ebx
call Byte__On_Equals
add esp, 8
;Loading MyByte -221
add esp, -4
mov ebx, ebp
add ebx, -194
mov [esp], ebx
call OutputByte
add esp, 4
add esp, -1

mov byte [esp], 3

;Declaring [354 -222
;Adding return value 
add esp, -1
;Loading [354 -223
add esp, -4
mov ebx, ebp
add ebx, -222
mov [esp], ebx
;Loading a Array object
add esp, -4
mov ebx, ebp
add ebx, -201
mov [esp], ebx
call Array__Byte__GetAt
add esp, 8
;Loading [355 -223
add esp, -4
mov ebx, ebp
add ebx, -223
mov [esp], ebx
;Loading a Byte object
add esp, -4
mov ebx, ebp
add ebx, -194
mov [esp], ebx
call Byte__On_Equals
add esp, 8
;Loading MyByte -223
add esp, -4
mov ebx, ebp
add ebx, -194
mov [esp], ebx
call OutputByte
add esp, 4
add esp, -1

mov byte [esp], 4

;Declaring [356 -224
;Adding return value 
add esp, -1
;Loading [356 -225
add esp, -4
mov ebx, ebp
add ebx, -224
mov [esp], ebx
;Loading a Array object
add esp, -4
mov ebx, ebp
add ebx, -201
mov [esp], ebx
call Array__Byte__GetAt
add esp, 8
;Loading [357 -225
add esp, -4
mov ebx, ebp
add ebx, -225
mov [esp], ebx
;Loading a Byte object
add esp, -4
mov ebx, ebp
add ebx, -194
mov [esp], ebx
call Byte__On_Equals
add esp, 8
;Loading MyByte -225
add esp, -4
mov ebx, ebp
add ebx, -194
mov [esp], ebx
call OutputByte
add esp, 4
add esp, -1

mov byte [esp], 5

;Declaring [358 -226
;Adding return value 
add esp, -1
;Loading [358 -227
add esp, -4
mov ebx, ebp
add ebx, -226
mov [esp], ebx
;Loading a Array object
add esp, -4
mov ebx, ebp
add ebx, -201
mov [esp], ebx
call Array__Byte__GetAt
add esp, 8
;Loading [359 -227
add esp, -4
mov ebx, ebp
add ebx, -227
mov [esp], ebx
;Loading a Byte object
add esp, -4
mov ebx, ebp
add ebx, -194
mov [esp], ebx
call Byte__On_Equals
add esp, 8
;Loading MyByte -227
add esp, -4
mov ebx, ebp
add ebx, -194
mov [esp], ebx
call OutputByte
add esp, 4
;ok-200
;Loading [360 -227
add esp, -4
mov ebx, ebp
add ebx, -200
mov [esp], ebx
call PrintPointer
add esp, 4
add esp, -1

mov byte [esp], 0

;Declaring [361 -228
;Loading [361 -228
add esp, -4
mov ebx, ebp
add ebx, -228
mov [esp], ebx
;Loading a Byte object
add esp, -4
mov ebx, ebp
add ebx, -64
mov [esp], ebx
call Byte__On_Equals
add esp, 8
S35:
add esp, -1

mov byte [esp], 10

;Declaring [362 -229
;Adding return value 
add esp, -1
;Loading [362 -230
add esp, -4
mov ebx, ebp
add ebx, -229
mov [esp], ebx
;Loading a Byte object
add esp, -4
mov ebx, ebp
add ebx, -64
mov [esp], ebx
call Byte__On_Less_Than
add esp, 8
mov byte cl, [esp]
test cl, cl
je S36

add esp, -1

mov byte [esp], 1

;Declaring [364 -231
;Adding return value 
add esp, -1
;Loading [364 -232
add esp, -4
mov ebx, ebp
add ebx, -231
mov [esp], ebx
;Loading a Byte object
add esp, -4
mov ebx, ebp
add ebx, -64
mov [esp], ebx
call Byte__On_Plus
add esp, 8
;Loading [365 -232
add esp, -4
mov ebx, ebp
add ebx, -232
mov [esp], ebx
;Loading a Array object
add esp, -4
mov ebx, ebp
add ebx, -201
mov [esp], ebx
call Array__Byte__Resize
add esp, 8
add esp, -1

mov byte [esp], 65

;Declaring [366 -233
;Loading [366 -233
add esp, -4
mov ebx, ebp
add ebx, -233
mov [esp], ebx
;Loading S6 -237
add esp, -4
mov ebx, ebp
add ebx, -64
mov [esp], ebx
;Loading a Array object
add esp, -4
mov ebx, ebp
add ebx, -201
mov [esp], ebx
call Array__Byte__SetAt
add esp, 12
;ok-200
;Loading [367 -233
add esp, -4
mov ebx, ebp
add ebx, -200
mov [esp], ebx
call GetFirstByteInDynam
add esp, 4
;Declaring NewByte -234
add esp, -1

add esp, -4
mov ebx, ebp
add ebx, -234
mov [esp], ebx
call Byte__On_Create
add esp, 4
;Adding return value 
add esp, -1
;Loading S6 -235
add esp, -4
mov ebx, ebp
add ebx, -64
mov [esp], ebx
;Loading a Array object
add esp, -4
mov ebx, ebp
add ebx, -201
mov [esp], ebx
call Array__Byte__GetAt
add esp, 8
;Loading [368 -235
add esp, -4
mov ebx, ebp
add ebx, -235
mov [esp], ebx
;Loading a Byte object
add esp, -4
mov ebx, ebp
add ebx, -234
mov [esp], ebx
call Byte__On_Equals
add esp, 8
;Loading NewByte -235
add esp, -4
mov ebx, ebp
add ebx, -234
mov [esp], ebx
call OutputByte
add esp, 4
add esp, -1

mov byte [esp], 1

;Declaring [369 -236
;Adding return value 
add esp, -1
;Loading [369 -237
add esp, -4
mov ebx, ebp
add ebx, -236
mov [esp], ebx
;Loading a Byte object
add esp, -4
mov ebx, ebp
add ebx, -64
mov [esp], ebx
call Byte__On_Plus
add esp, 8
;Loading [370 -237
add esp, -4
mov ebx, ebp
add ebx, -237
mov [esp], ebx
;Loading a Byte object
add esp, -4
mov ebx, ebp
add ebx, -64
mov [esp], ebx
call Byte__On_Equals
add esp, 8
add esp, 9
jmp S35
S36:
add esp, 2


mov esp, ebp
pop ebp
ret

