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
add ebx, 0
mov [esp], ebx
; loading a reference!L
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

;Declaring [5 -5
;Loading [5 -5
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
; loading a reference![4
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

;Declaring [8 -7
;Loading [8 -7
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
; loading a reference![7
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
;Names: [9 : B2 -> 1
;ok-4
add esp, -1

mov byte [esp], 68

;Declaring [11 -5
;Loading [11 -5
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
; loading a reference![10
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

;Declaring [12 -2
;Loading [12 -2
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

;Declaring [13 -3
;Loading [13 -3
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

;Declaring [14 -4
;Loading [14 -4
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

;Declaring [15 -6
;Loading [15 -6
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

;Declaring [16 -7
;Loading [16 -7
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

;Declaring [17 -8
;Loading [17 -8
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

;Declaring [18 -12
;Loading [18 -12
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

;Declaring [19 -13
;Loading [19 -13
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

;Declaring [20 -14
;Loading [20 -14
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

;Declaring [21 -15
;Loading [21 -15
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

;Declaring [22 -16
;Loading [22 -16
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

;Declaring [23 -17
;Loading [23 -17
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

;Declaring [24 -21
;Loading [24 -21
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

;Declaring [25 -22
;Loading [25 -22
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

;Declaring [26 -23
;Adding return value 
add esp, -1
;Loading [26 -24
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
;Loading [27 -24
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

;Declaring [28 -25
;Adding return value 
add esp, -1
;Loading [28 -26
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
;Loading [29 -26
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

;Declaring [30 -27
;Adding return value 
add esp, -1
;Loading [30 -28
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
;Loading [31 -28
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

;Declaring [32 -29
;Adding return value 
add esp, -1
;Loading [32 -30
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
;Loading [33 -30
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

;Declaring [34 -31
;Adding return value 
add esp, -1
;Loading [34 -32
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
;Loading [35 -32
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

;Declaring [36 -33
;Adding return value 
add esp, -1
;Loading [36 -34
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
;Loading [37 -34
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

;Declaring [38 -35
;Adding return value 
add esp, -1
;Loading [38 -36
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
;Loading [39 -36
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

;Declaring [40 -37
;Adding return value 
add esp, -1
;Loading [40 -38
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
;Loading [41 -38
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

;Declaring [42 -39
;Adding return value 
add esp, -1
;Loading [42 -40
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
;Loading [43 -40
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

;Declaring [44 -41
;Adding return value 
add esp, -1
;Loading [44 -42
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
;Loading [45 -42
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

;Declaring [46 -43
;Adding return value 
add esp, -1
;Loading [46 -44
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
;Loading [47 -44
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

;Declaring [48 -45
;Adding return value 
add esp, -1
;Loading [48 -46
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
;Loading [49 -46
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

;Declaring [50 -47
;Adding return value 
add esp, -1
;Loading [50 -48
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
;Loading [51 -48
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

;Declaring [52 -49
;Adding return value 
add esp, -1
;Loading [52 -50
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

;Declaring [54 -51
;Adding return value 
add esp, -1
;Loading [54 -52
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

;Declaring [56 -53
;Adding return value 
add esp, -1
;Loading [56 -54
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

;Declaring [58 -55
;Adding return value 
add esp, -1
;Loading [58 -56
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
;Loading [59 -56
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

;Declaring [60 -57
;Adding return value 
add esp, -1
;Loading [60 -58
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
;Loading [61 -58
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

;Declaring [62 -60
;Loading [62 -60
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
;Loading [63 -61
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

;Declaring [64 -63
;Loading [64 -63
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

;Declaring [65 -65
;Adding return value 
add esp, -1
;Loading [65 -66
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
;Loading [66 -66
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

;Declaring [67 -67
;Loading [67 -67
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

;Declaring [68 -69
;Loading [68 -69
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

;Declaring [69 -71
;Loading [69 -71
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

;Declaring [70 -72
;Adding return value 
add esp, -1
;Loading [70 -73
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

;Declaring [72 -74
;Adding return value 
add esp, -1
;Loading [72 -75
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
;Loading [73 -75
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

;Declaring [74 -72
;Loading [74 -72
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

;Declaring [75 -73
;Adding return value 
add esp, -1
;Loading [75 -74
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

;Declaring [77 -75
;Adding return value 
add esp, -1
;Loading [77 -76
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
;Loading [78 -76
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

;Declaring [79 -73
;Adding return value 
add esp, -1
;Loading [79 -74
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

;Declaring [81 -75
;Adding return value 
add esp, -1
;Loading [81 -76
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
;Loading [82 -76
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

;Declaring [83 -73
;Adding return value 
add esp, -1
;Loading [83 -74
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

;Declaring [85 -75
;Adding return value 
add esp, -1
;Loading [85 -76
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
;Loading [86 -76
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

;Declaring [87 -73
;Adding return value 
add esp, -1
;Loading [87 -74
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

;Declaring [89 -75
;Adding return value 
add esp, -1
;Loading [89 -76
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
;Loading [90 -76
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

;Declaring [91 -73
;Adding return value 
add esp, -1
;Loading [91 -74
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

;Declaring [93 -75
;Adding return value 
add esp, -1
;Loading [93 -76
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
;Loading [94 -76
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

;Declaring [95 -73
;Adding return value 
add esp, -1
;Loading [95 -74
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

;Declaring [97 -75
;Adding return value 
add esp, -1
;Loading [97 -76
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
;Loading [98 -76
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

;Declaring [99 -73
;Loading [99 -73
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

;Declaring [100 -74
;Adding return value 
add esp, -1
;Loading [100 -75
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

;Declaring [102 -76
;Loading [102 -76
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

;Declaring [103 -75
;Loading [103 -75
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

;Declaring [104 -76
;Adding return value 
add esp, -1
;Loading [104 -77
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

;Declaring [106 -78
;Loading [106 -78
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

;Declaring [107 -79
;Loading [107 -79
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

;Declaring [108 -80
;Loading [108 -80
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

;Declaring [109 -76
;Adding return value 
add esp, -1
;Loading [109 -77
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

;Declaring [111 -78
;Loading [111 -78
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

;Declaring [112 -79
;Loading [112 -79
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

;Declaring [113 -76
;Adding return value 
add esp, -1
;Loading [113 -77
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

;Declaring [115 -78
;Loading [115 -78
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

;Declaring [116 -79
;Loading [116 -79
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

;Declaring [117 -80
;Loading [117 -80
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

;Declaring [118 -76
;Adding return value 
add esp, -1
;Loading [118 -77
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

;Declaring [120 -78
;Loading [120 -78
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

;Declaring [121 -79
;Loading [121 -79
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

;Declaring [122 -76
;Loading [122 -76
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

;Declaring [123 -77
;Loading [123 -77
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

;Declaring [124 -76
;Adding return value 
add esp, -1
;Loading [124 -77
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
;Loading [125 -77
add esp, -4
mov ebx, ebp
add ebx, -77
mov [esp], ebx
call OutputByte
add esp, 4
add esp, -1

mov byte [esp], 1

;Declaring [126 -78
;Adding return value 
add esp, -1
;Loading [126 -79
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
;Loading [127 -83
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

;Declaring [128 -80
;Adding return value 
add esp, -1
;Loading [128 -81
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

;Declaring [130 -82
;Adding return value 
add esp, -1
;Loading [130 -83
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

;Declaring [132 -84
;Adding return value 
add esp, -1
;Loading [132 -85
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

;Declaring [134 -86
;Adding return value 
add esp, -1
;Loading [134 -87
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

;Declaring [136 -88
;Adding return value 
add esp, -1
;Loading [136 -89
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
;Loading [137 -89
add esp, -4
mov ebx, ebp
add ebx, -89
mov [esp], ebx
;Loading [135 -93
add esp, -4
mov ebx, ebp
add ebx, -87
mov [esp], ebx
;Loading [133 -97
add esp, -4
mov ebx, ebp
add ebx, -85
mov [esp], ebx
;Loading [131 -101
add esp, -4
mov ebx, ebp
add ebx, -83
mov [esp], ebx
;Loading [129 -105
add esp, -4
mov ebx, ebp
add ebx, -81
mov [esp], ebx
call OutputByte5
add esp, 20
add esp, -1

mov byte [esp], 1

;Declaring [138 -90
;Adding return value 
add esp, -1
;Loading [138 -91
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

;Declaring [140 -92
;Adding return value 
add esp, -1
;Loading [140 -93
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
;Loading [141 -93
add esp, -4
mov ebx, ebp
add ebx, -93
mov [esp], ebx
;Loading [139 -97
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

;Declaring [142 -94
;Adding return value 
add esp, -1
;Loading [142 -95
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

;Declaring [144 -96
;Adding return value 
add esp, -1
;Loading [144 -97
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

;Declaring [146 -98
;Adding return value 
add esp, -1
;Loading [146 -99
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

;Declaring [148 -100
;Adding return value 
add esp, -1
;Loading [148 -101
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

;Declaring [150 -102
;Adding return value 
add esp, -1
;Loading [150 -103
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

;Declaring [152 -104
;Adding return value 
add esp, -1
;Loading [152 -105
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

;Declaring [154 -106
;Adding return value 
add esp, -1
;Loading [154 -107
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

;Declaring [156 -108
;Adding return value 
add esp, -1
;Loading [156 -109
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
;Loading [157 -109
add esp, -4
mov ebx, ebp
add ebx, -109
mov [esp], ebx
;Loading [155 -113
add esp, -4
mov ebx, ebp
add ebx, -107
mov [esp], ebx
;Loading [153 -117
add esp, -4
mov ebx, ebp
add ebx, -105
mov [esp], ebx
;Loading [147 -121
add esp, -4
mov ebx, ebp
add ebx, -99
mov [esp], ebx
;Loading [143 -125
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

;Declaring [158 -110
;Adding return value 
add esp, -1
;Loading [158 -111
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
;Loading [159 -111
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

;Declaring [160 -114
;Loading [160 -114
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
;Loading [161 -115
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
;Loading [162 -116
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

;Declaring [164 -119
;Loading [164 -119
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
;Loading [165 -119
add esp, -4
mov ebx, ebp
add ebx, -118
mov [esp], ebx
call OutputByte
add esp, 4
;ok-117
add esp, -1

mov byte [esp], 4

;Declaring [167 -120
;Loading [167 -120
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
;Loading [170 -121
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
;Loading [171 -121
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
;Loading [172 -121
add esp, -4
mov ebx, ebp
add ebx, -118
mov [esp], ebx
call OutputByte
add esp, 4
;ok-118
;Loading [173 -121
add esp, -4
mov ebx, ebp
add ebx, -118
mov [esp], ebx
call OutputByte
add esp, 4
;ok-118
;Loading [174 -121
add esp, -4
mov ebx, ebp
add ebx, -118
mov [esp], ebx
call OutputByte
add esp, 4
;ok-118
;Loading [175 -121
add esp, -4
mov ebx, ebp
add ebx, -118
mov [esp], ebx
call OutputByte
add esp, 4
;ok-118
;Loading [176 -121
add esp, -4
mov ebx, ebp
add ebx, -118
mov [esp], ebx
call OutputByte
add esp, 4
;ok-118
;Loading [177 -121
add esp, -4
mov ebx, ebp
add ebx, -118
mov [esp], ebx
call OutputByte
add esp, 4
;ok-118
;Loading [178 -121
add esp, -4
mov ebx, ebp
add ebx, -118
mov [esp], ebx
call OutputByte
add esp, 4
;ok-118
;Loading [179 -121
add esp, -4
mov ebx, ebp
add ebx, -118
mov [esp], ebx
call OutputByte
add esp, 4
;ok-118
;Loading [180 -121
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
;Loading [183 -122
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
;Loading [184 -122
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
;Loading [185 -122
add esp, -4
mov ebx, ebp
add ebx, -118
mov [esp], ebx
call OutputByte
add esp, 4
;ok-118
;Loading [186 -122
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
;Loading [189 -126
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
;Loading [190 -126
add esp, -4
mov ebx, ebp
add ebx, -118
mov [esp], ebx
call OutputByte
add esp, 4
;ok-126
;ok-126
;Loading [192 -126
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
;Loading [197 -127
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
;Loading [198 -127
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
;Loading [200 -127
add esp, -4
mov ebx, ebp
add ebx, -126
mov [esp], ebx
call OutputByte
add esp, 4
;ok-118
;Loading [201 -127
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
;Loading [206 -128
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
;Loading [207 -128
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
;Loading [209 -128
add esp, -4
mov ebx, ebp
add ebx, -123
mov [esp], ebx
call OutputByte
add esp, 4
;ok-124
;ok-123
;Loading [211 -128
add esp, -4
mov ebx, ebp
add ebx, -123
mov [esp], ebx
call OutputByte
add esp, 4
;ok-118
;Loading [212 -128
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
;Loading [213 -130
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
;Loading [214 -130
add esp, -4
mov ebx, ebp
add ebx, -130
mov [esp], ebx
call OutputByte
add esp, 4
;ok-118
;Loading [215 -130
add esp, -4
mov ebx, ebp
add ebx, -118
mov [esp], ebx
call OutputByte
add esp, 4
add esp, -1

mov byte [esp], 66

;Declaring [216 -131
;Loading [216 -131
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
;Loading [217 -133
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
;Loading [219 -135
add esp, -4
mov ebx, ebp
add ebx, -134
mov [esp], ebx
call OutputByte
add esp, 4
add esp, -1

mov byte [esp], 66

;Declaring [220 -136
;Loading [220 -136
add esp, -4
mov ebx, ebp
add ebx, -136
mov [esp], ebx
call OutputByte
add esp, 4
add esp, -1

mov byte [esp], 65

;Declaring [221 -137
;Adding return value 
add esp, -1
;Loading [221 -138
add esp, -4
mov ebx, ebp
add ebx, -137
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

;Declaring MeByte -139
add esp, -1

add esp, -4
mov ebx, ebp
add ebx, -139
mov [esp], ebx
call Byte__On_Create
add esp, 4
add esp, -1

mov byte [esp], 2

;Declaring [223 -140
;Adding return value 
add esp, -1
;Loading [223 -141
add esp, -4
mov ebx, ebp
add ebx, -140
mov [esp], ebx
;Loading a Byte object
add esp, -4
mov ebx, ebp
add ebx, -139
mov [esp], ebx
call Byte__On_Plus
add esp, 8
;Loading [224 -141
add esp, -4
mov ebx, ebp
add ebx, -141
mov [esp], ebx
;Loading a Byte object
add esp, -4
mov ebx, ebp
add ebx, -139
mov [esp], ebx
call Byte__On_Equals
add esp, 8
add esp, 5
jmp S25
S24:
add esp, 2
S25:
;Declaring joe -140
add esp, -4

add esp, -4
mov ebx, ebp
add ebx, -140
mov [esp], ebx
call Pointer__On_Create
add esp, 4


mov esp, ebp
pop ebp
ret

