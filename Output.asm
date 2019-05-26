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
mov [esp], ebx
; loading a reference!
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

;Declaring [0 -1
;Adding return value 
add esp, -1
;Loading [0 -2
add esp, -4
mov ebx, ebp
add ebx, -1
mov [esp], ebx
;Loading a Byte object
add esp, -4
mov ebx, ebp
add ebx, 8
mov ebx, [ebx]
mov [esp], ebx
; loading a reference!
call Byte__On_Plus
add esp, 8
;Loading [1 -2
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
mov [esp], ebx
; loading a reference!
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


add esp, -1

mov byte [esp], 65

;Declaring [5 -1
;Loading [5 -1
add esp, -4
mov ebx, ebp
add ebx, -1
mov [esp], ebx
;Loading a Byte object
add esp, -4
mov ebx, ebp
add ebx, 8
mov ebx, [ebx]
mov [esp], ebx
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

;Declaring [6 -2
;Loading [6 -2
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
add esp, -1

mov byte [esp], 66

;Declaring [8 -3
;Loading [8 -3
add esp, -4
mov ebx, ebp
add ebx, -3
mov [esp], ebx
;Loading a Byte object
add esp, -4
mov ebx, ebp
add ebx, 8
mov [esp], ebx
call Byte__On_Equals
add esp, 8


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

;Declaring [9 -2
;Loading [9 -2
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

;Declaring [10 -3
;Loading [10 -3
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

;Declaring [11 -4
;Loading [11 -4
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

;Declaring [12 -6
;Loading [12 -6
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

;Declaring [13 -7
;Loading [13 -7
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

;Declaring [14 -8
;Loading [14 -8
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

;Declaring [15 -12
;Loading [15 -12
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

;Declaring [16 -13
;Loading [16 -13
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

;Declaring [17 -14
;Loading [17 -14
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

;Declaring [18 -15
;Loading [18 -15
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

;Declaring [19 -16
;Loading [19 -16
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
;Loading L -20
add esp, -4
mov ebx, ebp
add ebx, -1
mov [esp], ebx
;Loading B2 -24
add esp, -4
mov ebx, ebp
add ebx, -5
mov [esp], ebx
;Loading B3 -28
add esp, -4
mov ebx, ebp
add ebx, -9
mov [esp], ebx
;Loading B4 -32
add esp, -4
mov ebx, ebp
add ebx, -10
mov [esp], ebx
call OutputByte5
add esp, 20
add esp, -1

mov byte [esp], 32

;Declaring [20 -17
;Loading [20 -17
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

;Declaring [21 -21
;Loading [21 -21
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

;Declaring [22 -22
;Loading [22 -22
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

;Declaring [23 -23
;Adding return value 
add esp, -1
;Loading [23 -24
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
;Loading [24 -24
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

;Declaring [25 -25
;Adding return value 
add esp, -1
;Loading [25 -26
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
;Loading [26 -26
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

;Declaring [27 -27
;Adding return value 
add esp, -1
;Loading [27 -28
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
;Loading [28 -28
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

;Declaring [29 -29
;Adding return value 
add esp, -1
;Loading [29 -30
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
;Loading [30 -30
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

;Declaring [31 -31
;Adding return value 
add esp, -1
;Loading [31 -32
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
;Loading [32 -32
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

;Declaring [33 -33
;Adding return value 
add esp, -1
;Loading [33 -34
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
;Loading [34 -34
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

;Declaring [35 -35
;Adding return value 
add esp, -1
;Loading [35 -36
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
;Loading [36 -36
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

;Declaring [37 -37
;Adding return value 
add esp, -1
;Loading [37 -38
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
;Loading [38 -38
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

;Declaring [39 -39
;Adding return value 
add esp, -1
;Loading [39 -40
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
;Loading [40 -40
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

;Declaring [41 -41
;Adding return value 
add esp, -1
;Loading [41 -42
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
;Loading [42 -42
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

;Declaring [43 -43
;Adding return value 
add esp, -1
;Loading [43 -44
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
;Loading [44 -44
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

;Declaring [45 -45
;Adding return value 
add esp, -1
;Loading [45 -46
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
;Loading [46 -46
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

;Declaring [47 -47
;Adding return value 
add esp, -1
;Loading [47 -48
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
;Loading [48 -48
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

;Declaring [49 -49
;Adding return value 
add esp, -1
;Loading [49 -50
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

;Declaring [51 -51
;Adding return value 
add esp, -1
;Loading [51 -52
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

;Declaring [53 -53
;Adding return value 
add esp, -1
;Loading [53 -54
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

;Declaring [55 -55
;Adding return value 
add esp, -1
;Loading [55 -56
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
;Loading [56 -56
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

;Declaring [57 -57
;Adding return value 
add esp, -1
;Loading [57 -58
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
;Loading [58 -58
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

;Declaring [59 -60
;Loading [59 -60
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
;Loading [60 -61
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

;Declaring [61 -63
;Loading [61 -63
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

;Declaring [62 -65
;Adding return value 
add esp, -1
;Loading [62 -66
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
;Loading [63 -66
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

;Declaring [64 -67
;Loading [64 -67
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

;Declaring [65 -69
;Loading [65 -69
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

;Declaring [66 -71
;Loading [66 -71
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
S0:
add esp, -1

mov byte [esp], 65

;Declaring [67 -72
;Adding return value 
add esp, -1
;Loading [67 -73
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
je S1

;Loading S6 -73
add esp, -4
mov ebx, ebp
add ebx, -64
mov [esp], ebx
call OutputByte
add esp, 4
add esp, -1

mov byte [esp], 1

;Declaring [69 -74
;Adding return value 
add esp, -1
;Loading [69 -75
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
;Loading [70 -75
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
jmp S0
S1:
add esp, 2
add esp, -1

mov byte [esp], 65

;Declaring [71 -72
;Loading [71 -72
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
S2:
add esp, -1

mov byte [esp], 121

;Declaring [72 -73
;Adding return value 
add esp, -1
;Loading [72 -74
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
jne S3

;Loading S6 -74
add esp, -4
mov ebx, ebp
add ebx, -64
mov [esp], ebx
call OutputByte
add esp, 4
add esp, -1

mov byte [esp], 1

;Declaring [74 -75
;Adding return value 
add esp, -1
;Loading [74 -76
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
;Loading [75 -76
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
jmp S2
S3:
add esp, 2
S4:
add esp, -1

mov byte [esp], 65

;Declaring [76 -73
;Adding return value 
add esp, -1
;Loading [76 -74
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
jne S5

;Loading S6 -74
add esp, -4
mov ebx, ebp
add ebx, -64
mov [esp], ebx
call OutputByte
add esp, 4
add esp, -1

mov byte [esp], 1

;Declaring [78 -75
;Adding return value 
add esp, -1
;Loading [78 -76
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
;Loading [79 -76
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
jmp S4
S5:
add esp, 2
S6:
add esp, -1

mov byte [esp], 122

;Declaring [80 -73
;Adding return value 
add esp, -1
;Loading [80 -74
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
jne S7

;Loading S6 -74
add esp, -4
mov ebx, ebp
add ebx, -64
mov [esp], ebx
call OutputByte
add esp, 4
add esp, -1

mov byte [esp], 1

;Declaring [82 -75
;Adding return value 
add esp, -1
;Loading [82 -76
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
;Loading [83 -76
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
jmp S6
S7:
add esp, 2
S8:
add esp, -1

mov byte [esp], 65

;Declaring [84 -73
;Adding return value 
add esp, -1
;Loading [84 -74
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
jne S9

;Loading S6 -74
add esp, -4
mov ebx, ebp
add ebx, -64
mov [esp], ebx
call OutputByte
add esp, 4
add esp, -1

mov byte [esp], 1

;Declaring [86 -75
;Adding return value 
add esp, -1
;Loading [86 -76
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
;Loading [87 -76
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
jmp S8
S9:
add esp, 2
S10:
add esp, -1

mov byte [esp], 122

;Declaring [88 -73
;Adding return value 
add esp, -1
;Loading [88 -74
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
je S11

;Loading S6 -74
add esp, -4
mov ebx, ebp
add ebx, -64
mov [esp], ebx
call OutputByte
add esp, 4
add esp, -1

mov byte [esp], 1

;Declaring [90 -75
;Adding return value 
add esp, -1
;Loading [90 -76
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
;Loading [91 -76
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
jmp S10
S11:
add esp, 2
S12:
add esp, -1

mov byte [esp], 65

;Declaring [92 -73
;Adding return value 
add esp, -1
;Loading [92 -74
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
je S13

;Loading S6 -74
add esp, -4
mov ebx, ebp
add ebx, -64
mov [esp], ebx
call OutputByte
add esp, 4
add esp, -1

mov byte [esp], 1

;Declaring [94 -75
;Adding return value 
add esp, -1
;Loading [94 -76
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
;Loading [95 -76
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
jmp S12
S13:
add esp, 2
add esp, -1

mov byte [esp], 65

;Declaring [96 -73
;Loading [96 -73
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

;Declaring [97 -74
;Adding return value 
add esp, -1
;Loading [97 -75
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
je S14

add esp, -1

mov byte [esp], 67

;Declaring [99 -76
;Loading [99 -76
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
jmp S15
S14:
add esp, 2
S15:
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

;Declaring [100 -75
;Loading [100 -75
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

;Declaring [101 -76
;Adding return value 
add esp, -1
;Loading [101 -77
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
je S16

add esp, -1

mov byte [esp], 89

;Declaring [103 -78
;Loading [103 -78
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

;Declaring [104 -79
;Loading [104 -79
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

;Declaring [105 -80
;Loading [105 -80
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
jmp S17
S16:
add esp, 2
S17:
add esp, -1

mov byte [esp], 65

;Declaring [106 -76
;Adding return value 
add esp, -1
;Loading [106 -77
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
je S18

add esp, -1

mov byte [esp], 78

;Declaring [108 -78
;Loading [108 -78
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

;Declaring [109 -79
;Loading [109 -79
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
jmp S19
S18:
add esp, 2
S19:
add esp, -1

mov byte [esp], 65

;Declaring [110 -76
;Adding return value 
add esp, -1
;Loading [110 -77
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
je S20

add esp, -1

mov byte [esp], 89

;Declaring [112 -78
;Loading [112 -78
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

;Declaring [113 -79
;Loading [113 -79
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

;Declaring [114 -80
;Loading [114 -80
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
jmp S21
S20:
add esp, 2
add esp, -1

mov byte [esp], 65

;Declaring [115 -76
;Adding return value 
add esp, -1
;Loading [115 -77
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
je S22

add esp, -1

mov byte [esp], 78

;Declaring [117 -78
;Loading [117 -78
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

;Declaring [118 -79
;Loading [118 -79
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
jmp S21
S22:
add esp, 2
add esp, -1

mov byte [esp], 77

;Declaring [119 -76
;Loading [119 -76
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

;Declaring [120 -77
;Loading [120 -77
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
jmp S21
S23:
add esp, 0
S21:
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

;Declaring [121 -76
;Adding return value 
add esp, -1
;Loading [121 -77
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
;Loading [122 -77
add esp, -4
mov ebx, ebp
add ebx, -77
mov [esp], ebx
call OutputByte
add esp, 4
add esp, -1

mov byte [esp], 1

;Declaring [123 -78
;Adding return value 
add esp, -1
;Loading [123 -79
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
;Loading [124 -83
add esp, -4
mov ebx, ebp
add ebx, -79
mov [esp], ebx
;Loading B2 -87
add esp, -4
mov ebx, ebp
add ebx, -5
mov [esp], ebx
;Loading B3 -91
add esp, -4
mov ebx, ebp
add ebx, -9
mov [esp], ebx
;Loading B4 -95
add esp, -4
mov ebx, ebp
add ebx, -10
mov [esp], ebx
call OutputByte5
add esp, 20
add esp, -1

mov byte [esp], 1

;Declaring [125 -80
;Adding return value 
add esp, -1
;Loading [125 -81
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

;Declaring [127 -82
;Adding return value 
add esp, -1
;Loading [127 -83
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

;Declaring [129 -84
;Adding return value 
add esp, -1
;Loading [129 -85
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

;Declaring [131 -86
;Adding return value 
add esp, -1
;Loading [131 -87
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

;Declaring [133 -88
;Adding return value 
add esp, -1
;Loading [133 -89
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
;Loading [134 -89
add esp, -4
mov ebx, ebp
add ebx, -89
mov [esp], ebx
;Loading [132 -93
add esp, -4
mov ebx, ebp
add ebx, -87
mov [esp], ebx
;Loading [130 -97
add esp, -4
mov ebx, ebp
add ebx, -85
mov [esp], ebx
;Loading [128 -101
add esp, -4
mov ebx, ebp
add ebx, -83
mov [esp], ebx
;Loading [126 -105
add esp, -4
mov ebx, ebp
add ebx, -81
mov [esp], ebx
call OutputByte5
add esp, 20
add esp, -1

mov byte [esp], 1

;Declaring [135 -90
;Adding return value 
add esp, -1
;Loading [135 -91
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

;Declaring [137 -92
;Adding return value 
add esp, -1
;Loading [137 -93
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
;Loading [138 -93
add esp, -4
mov ebx, ebp
add ebx, -93
mov [esp], ebx
;Loading [136 -97
add esp, -4
mov ebx, ebp
add ebx, -91
mov [esp], ebx
;Loading S6 -101
add esp, -4
mov ebx, ebp
add ebx, -64
mov [esp], ebx
call OutputByte3
add esp, 12
add esp, -1

mov byte [esp], 1

;Declaring [139 -94
;Adding return value 
add esp, -1
;Loading [139 -95
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

;Declaring [141 -96
;Adding return value 
add esp, -1
;Loading [141 -97
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

;Declaring [143 -98
;Adding return value 
add esp, -1
;Loading [143 -99
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

;Declaring [145 -100
;Adding return value 
add esp, -1
;Loading [145 -101
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

;Declaring [147 -102
;Adding return value 
add esp, -1
;Loading [147 -103
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

;Declaring [149 -104
;Adding return value 
add esp, -1
;Loading [149 -105
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

;Declaring [151 -106
;Adding return value 
add esp, -1
;Loading [151 -107
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

;Declaring [153 -108
;Adding return value 
add esp, -1
;Loading [153 -109
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
;Loading [154 -109
add esp, -4
mov ebx, ebp
add ebx, -109
mov [esp], ebx
;Loading [152 -113
add esp, -4
mov ebx, ebp
add ebx, -107
mov [esp], ebx
;Loading [150 -117
add esp, -4
mov ebx, ebp
add ebx, -105
mov [esp], ebx
;Loading [144 -121
add esp, -4
mov ebx, ebp
add ebx, -99
mov [esp], ebx
;Loading [140 -125
add esp, -4
mov ebx, ebp
add ebx, -95
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

;Declaring [155 -110
;Adding return value 
add esp, -1
;Loading [155 -111
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
;Loading [156 -111
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

;Declaring [157 -114
;Loading [157 -114
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
;Loading [158 -115
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
;Loading [159 -116
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
add esp, -1

mov byte [esp], 65

;Declaring [161 -119
;Loading [161 -119
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
;Loading [162 -119
add esp, -4
mov ebx, ebp
add ebx, -118
mov [esp], ebx
call OutputByte
add esp, 4
add esp, -1

mov byte [esp], 4

;Declaring [164 -120
;Loading [164 -120
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
;Adding return value 
add esp, -1
;Loading [167 -121
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
;Loading [168 -121
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
;Loading [169 -121
add esp, -4
mov ebx, ebp
add ebx, -118
mov [esp], ebx
call OutputByte
add esp, 4
;Loading [170 -121
add esp, -4
mov ebx, ebp
add ebx, -118
mov [esp], ebx
call OutputByte
add esp, 4
;Loading [171 -121
add esp, -4
mov ebx, ebp
add ebx, -118
mov [esp], ebx
call OutputByte
add esp, 4
;Loading [172 -121
add esp, -4
mov ebx, ebp
add ebx, -118
mov [esp], ebx
call OutputByte
add esp, 4
;Loading [173 -121
add esp, -4
mov ebx, ebp
add ebx, -118
mov [esp], ebx
call OutputByte
add esp, 4
;Loading [174 -121
add esp, -4
mov ebx, ebp
add ebx, -118
mov [esp], ebx
call OutputByte
add esp, 4
;Loading [175 -121
add esp, -4
mov ebx, ebp
add ebx, -118
mov [esp], ebx
call OutputByte
add esp, 4
;Loading [176 -121
add esp, -4
mov ebx, ebp
add ebx, -118
mov [esp], ebx
call OutputByte
add esp, 4
;Loading [177 -121
add esp, -4
mov ebx, ebp
add ebx, -118
mov [esp], ebx
call OutputByte
add esp, 4
;Adding return value 
add esp, -1
;Loading [180 -122
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
;Loading [181 -122
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
;Loading [182 -122
add esp, -4
mov ebx, ebp
add ebx, -118
mov [esp], ebx
call OutputByte
add esp, 4
;Loading [183 -122
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
;Loading [186 -126
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
;Loading [187 -126
add esp, -4
mov ebx, ebp
add ebx, -118
mov [esp], ebx
call OutputByte
add esp, 4
;Loading [189 -126
add esp, -4
mov ebx, ebp
add ebx, -126
mov [esp], ebx
call OutputByte
add esp, 4
;Adding return value 
add esp, -1
;Loading [194 -127
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
;Loading [195 -127
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
;Loading [197 -127
add esp, -4
mov ebx, ebp
add ebx, -126
mov [esp], ebx
call OutputByte
add esp, 4
;Loading [198 -127
add esp, -4
mov ebx, ebp
add ebx, -118
mov [esp], ebx
call OutputByte
add esp, 4
;Adding return value 
add esp, -1
;Loading [203 -128
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
;Loading [204 -128
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
;Loading [206 -128
add esp, -4
mov ebx, ebp
add ebx, -123
mov [esp], ebx
call OutputByte
add esp, 4
;Loading [208 -128
add esp, -4
mov ebx, ebp
add ebx, -123
mov [esp], ebx
call OutputByte
add esp, 4
;Loading [209 -128
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
;Loading [210 -130
add esp, -4
mov ebx, ebp
add ebx, -130
mov [esp], ebx
call OutputByte
add esp, 4
;Loading [211 -130
add esp, -4
mov ebx, ebp
add ebx, -118
mov [esp], ebx
call OutputByte
add esp, 4
add esp, -1

mov byte [esp], 65

;Declaring [212 -131
;Adding return value 
add esp, -1
;Loading [212 -132
add esp, -4
mov ebx, ebp
add ebx, -131
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
je S24

;Declaring MeByte -133
add esp, -1

add esp, -4
mov ebx, ebp
add ebx, -133
mov [esp], ebx
call Byte__On_Create
add esp, 4
add esp, -1

mov byte [esp], 2

;Declaring [214 -134
;Adding return value 
add esp, -1
;Loading [214 -135
add esp, -4
mov ebx, ebp
add ebx, -134
mov [esp], ebx
;Loading a Byte object
add esp, -4
mov ebx, ebp
add ebx, -133
mov [esp], ebx
call Byte__On_Plus
add esp, 8
;Loading [215 -135
add esp, -4
mov ebx, ebp
add ebx, -135
mov [esp], ebx
;Loading a Byte object
add esp, -4
mov ebx, ebp
add ebx, -133
mov [esp], ebx
call Byte__On_Equals
add esp, 8
add esp, 5
jmp S25
S24:
add esp, 2
S25:
;Declaring joe -134
add esp, -4

add esp, -4
mov ebx, ebp
add ebx, -134
mov [esp], ebx
call Pointer__On_Create
add esp, 4


mov esp, ebp
pop ebp
ret

