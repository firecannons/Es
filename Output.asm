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
;Names: [12 : B2 -> 1
;ok-4
add esp, -1

mov byte [esp], 72

;Declaring [14 -5
;Loading [14 -5
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
; loading a reference![13
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

;Declaring [15 -2
;Loading [15 -2
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

;Declaring [16 -3
;Loading [16 -3
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

;Declaring [17 -4
;Loading [17 -4
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

;Declaring [18 -6
;Loading [18 -6
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

;Declaring [19 -7
;Loading [19 -7
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

;Declaring [20 -8
;Loading [20 -8
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

;Declaring [21 -12
;Loading [21 -12
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

;Declaring [22 -13
;Loading [22 -13
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

;Declaring [23 -14
;Loading [23 -14
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

;Declaring [24 -15
;Loading [24 -15
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

;Declaring [25 -16
;Loading [25 -16
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

;Declaring [26 -17
;Loading [26 -17
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

;Declaring [27 -21
;Loading [27 -21
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

;Declaring [28 -22
;Loading [28 -22
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

;Declaring [29 -23
;Adding return value 
add esp, -1
;Loading [29 -24
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
;Loading [30 -24
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

;Declaring [31 -25
;Adding return value 
add esp, -1
;Loading [31 -26
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
;Loading [32 -26
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

;Declaring [33 -27
;Adding return value 
add esp, -1
;Loading [33 -28
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
;Loading [34 -28
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

;Declaring [35 -29
;Adding return value 
add esp, -1
;Loading [35 -30
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
;Loading [36 -30
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

;Declaring [37 -31
;Adding return value 
add esp, -1
;Loading [37 -32
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
;Loading [38 -32
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

;Declaring [39 -33
;Adding return value 
add esp, -1
;Loading [39 -34
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
;Loading [40 -34
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

;Declaring [41 -35
;Adding return value 
add esp, -1
;Loading [41 -36
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
;Loading [42 -36
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

;Declaring [43 -37
;Adding return value 
add esp, -1
;Loading [43 -38
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
;Loading [44 -38
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

;Declaring [45 -39
;Adding return value 
add esp, -1
;Loading [45 -40
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
;Loading [46 -40
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

;Declaring [47 -41
;Adding return value 
add esp, -1
;Loading [47 -42
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
;Loading [48 -42
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

;Declaring [49 -43
;Adding return value 
add esp, -1
;Loading [49 -44
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
;Loading [50 -44
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

;Declaring [51 -45
;Adding return value 
add esp, -1
;Loading [51 -46
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
;Loading [52 -46
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

;Declaring [53 -47
;Adding return value 
add esp, -1
;Loading [53 -48
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
;Loading [54 -48
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

;Declaring [55 -49
;Adding return value 
add esp, -1
;Loading [55 -50
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

;Declaring [57 -51
;Adding return value 
add esp, -1
;Loading [57 -52
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

;Declaring [59 -53
;Adding return value 
add esp, -1
;Loading [59 -54
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

;Declaring [61 -55
;Adding return value 
add esp, -1
;Loading [61 -56
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
;Loading [62 -56
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

;Declaring [63 -57
;Adding return value 
add esp, -1
;Loading [63 -58
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
;Loading [64 -58
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

;Declaring [65 -60
;Loading [65 -60
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
;Loading [66 -61
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

;Declaring [67 -63
;Loading [67 -63
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

;Declaring [68 -65
;Adding return value 
add esp, -1
;Loading [68 -66
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
;Loading [69 -66
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

;Declaring [70 -67
;Loading [70 -67
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

;Declaring [71 -69
;Loading [71 -69
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

;Declaring [72 -71
;Loading [72 -71
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

;Declaring [73 -72
;Adding return value 
add esp, -1
;Loading [73 -73
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

;Declaring [75 -74
;Adding return value 
add esp, -1
;Loading [75 -75
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
;Loading [76 -75
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

;Declaring [77 -72
;Loading [77 -72
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

;Declaring [78 -73
;Adding return value 
add esp, -1
;Loading [78 -74
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

;Declaring [80 -75
;Adding return value 
add esp, -1
;Loading [80 -76
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
;Loading [81 -76
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

;Declaring [82 -73
;Adding return value 
add esp, -1
;Loading [82 -74
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

;Declaring [84 -75
;Adding return value 
add esp, -1
;Loading [84 -76
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
;Loading [85 -76
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

;Declaring [86 -73
;Adding return value 
add esp, -1
;Loading [86 -74
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

;Declaring [88 -75
;Adding return value 
add esp, -1
;Loading [88 -76
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
;Loading [89 -76
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

;Declaring [90 -73
;Adding return value 
add esp, -1
;Loading [90 -74
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

;Declaring [92 -75
;Adding return value 
add esp, -1
;Loading [92 -76
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
;Loading [93 -76
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

;Declaring [94 -73
;Adding return value 
add esp, -1
;Loading [94 -74
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

;Declaring [96 -75
;Adding return value 
add esp, -1
;Loading [96 -76
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
;Loading [97 -76
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

;Declaring [98 -73
;Adding return value 
add esp, -1
;Loading [98 -74
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

;Declaring [100 -75
;Adding return value 
add esp, -1
;Loading [100 -76
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
;Loading [101 -76
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

;Declaring [102 -73
;Loading [102 -73
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

;Declaring [103 -74
;Adding return value 
add esp, -1
;Loading [103 -75
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

;Declaring [105 -76
;Loading [105 -76
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

;Declaring [106 -75
;Loading [106 -75
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

;Declaring [107 -76
;Adding return value 
add esp, -1
;Loading [107 -77
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

;Declaring [109 -78
;Loading [109 -78
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

;Declaring [110 -79
;Loading [110 -79
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

;Declaring [111 -80
;Loading [111 -80
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

;Declaring [112 -76
;Adding return value 
add esp, -1
;Loading [112 -77
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

;Declaring [114 -78
;Loading [114 -78
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

;Declaring [115 -79
;Loading [115 -79
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

;Declaring [116 -76
;Adding return value 
add esp, -1
;Loading [116 -77
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

;Declaring [118 -78
;Loading [118 -78
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

;Declaring [119 -79
;Loading [119 -79
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

;Declaring [120 -80
;Loading [120 -80
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
call Byte__On_If_Equal
add esp, 8
mov byte cl, [esp]
test cl, cl
je S22

add esp, -1

mov byte [esp], 78

;Declaring [123 -78
;Loading [123 -78
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

;Declaring [124 -79
;Loading [124 -79
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

;Declaring [125 -76
;Loading [125 -76
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

;Declaring [126 -77
;Loading [126 -77
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

;Declaring [127 -76
;Adding return value 
add esp, -1
;Loading [127 -77
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
;Loading [128 -77
add esp, -4
mov ebx, ebp
add ebx, -77
mov [esp], ebx
call OutputByte
add esp, 4
add esp, -1

mov byte [esp], 1

;Declaring [129 -78
;Adding return value 
add esp, -1
;Loading [129 -79
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
;Loading [130 -83
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

;Declaring [131 -80
;Adding return value 
add esp, -1
;Loading [131 -81
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

;Declaring [133 -82
;Adding return value 
add esp, -1
;Loading [133 -83
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

;Declaring [135 -84
;Adding return value 
add esp, -1
;Loading [135 -85
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

;Declaring [137 -86
;Adding return value 
add esp, -1
;Loading [137 -87
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

;Declaring [139 -88
;Adding return value 
add esp, -1
;Loading [139 -89
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
;Loading [140 -89
add esp, -4
mov ebx, ebp
add ebx, -89
mov [esp], ebx
;Loading [138 -93
add esp, -4
mov ebx, ebp
add ebx, -87
mov [esp], ebx
;Loading [136 -97
add esp, -4
mov ebx, ebp
add ebx, -85
mov [esp], ebx
;Loading [134 -101
add esp, -4
mov ebx, ebp
add ebx, -83
mov [esp], ebx
;Loading [132 -105
add esp, -4
mov ebx, ebp
add ebx, -81
mov [esp], ebx
call OutputByte5
add esp, 20
add esp, -1

mov byte [esp], 1

;Declaring [141 -90
;Adding return value 
add esp, -1
;Loading [141 -91
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

;Declaring [143 -92
;Adding return value 
add esp, -1
;Loading [143 -93
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
;Loading [144 -93
add esp, -4
mov ebx, ebp
add ebx, -93
mov [esp], ebx
;Loading [142 -97
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

;Declaring [145 -94
;Adding return value 
add esp, -1
;Loading [145 -95
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

;Declaring [147 -96
;Adding return value 
add esp, -1
;Loading [147 -97
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

;Declaring [149 -98
;Adding return value 
add esp, -1
;Loading [149 -99
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

;Declaring [151 -100
;Adding return value 
add esp, -1
;Loading [151 -101
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

;Declaring [153 -102
;Adding return value 
add esp, -1
;Loading [153 -103
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

;Declaring [155 -104
;Adding return value 
add esp, -1
;Loading [155 -105
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

;Declaring [157 -106
;Adding return value 
add esp, -1
;Loading [157 -107
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

;Declaring [159 -108
;Adding return value 
add esp, -1
;Loading [159 -109
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
;Loading [160 -109
add esp, -4
mov ebx, ebp
add ebx, -109
mov [esp], ebx
;Loading [158 -113
add esp, -4
mov ebx, ebp
add ebx, -107
mov [esp], ebx
;Loading [156 -117
add esp, -4
mov ebx, ebp
add ebx, -105
mov [esp], ebx
;Loading [150 -121
add esp, -4
mov ebx, ebp
add ebx, -99
mov [esp], ebx
;Loading [146 -125
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

;Declaring [161 -110
;Adding return value 
add esp, -1
;Loading [161 -111
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
;Loading [162 -111
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

;Declaring [163 -114
;Loading [163 -114
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
;Loading [164 -115
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
;Loading [165 -116
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

;Declaring [167 -119
;Loading [167 -119
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
;Loading [168 -119
add esp, -4
mov ebx, ebp
add ebx, -118
mov [esp], ebx
call OutputByte
add esp, 4
;ok-117
add esp, -1

mov byte [esp], 4

;Declaring [170 -120
;Loading [170 -120
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
;Loading [173 -121
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
;Loading [174 -121
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
;Loading [181 -121
add esp, -4
mov ebx, ebp
add ebx, -118
mov [esp], ebx
call OutputByte
add esp, 4
;ok-118
;Loading [182 -121
add esp, -4
mov ebx, ebp
add ebx, -118
mov [esp], ebx
call OutputByte
add esp, 4
;ok-118
;Loading [183 -121
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
;Loading [186 -122
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
;Loading [187 -122
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
;Loading [188 -122
add esp, -4
mov ebx, ebp
add ebx, -118
mov [esp], ebx
call OutputByte
add esp, 4
;ok-118
;Loading [189 -122
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
;Loading [192 -126
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
;Loading [193 -126
add esp, -4
mov ebx, ebp
add ebx, -118
mov [esp], ebx
call OutputByte
add esp, 4
;ok-126
;ok-126
;Loading [195 -126
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
;Loading [200 -127
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
;Loading [201 -127
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
;Loading [203 -127
add esp, -4
mov ebx, ebp
add ebx, -126
mov [esp], ebx
call OutputByte
add esp, 4
;ok-118
;Loading [204 -127
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
;Loading [209 -128
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
;Loading [210 -128
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
;Loading [212 -128
add esp, -4
mov ebx, ebp
add ebx, -123
mov [esp], ebx
call OutputByte
add esp, 4
;ok-124
;ok-123
;Loading [214 -128
add esp, -4
mov ebx, ebp
add ebx, -123
mov [esp], ebx
call OutputByte
add esp, 4
;ok-118
;Loading [215 -128
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
;Loading [216 -130
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
;Loading [217 -130
add esp, -4
mov ebx, ebp
add ebx, -130
mov [esp], ebx
call OutputByte
add esp, 4
;ok-118
;Loading [218 -130
add esp, -4
mov ebx, ebp
add ebx, -118
mov [esp], ebx
call OutputByte
add esp, 4
add esp, -1

mov byte [esp], 66

;Declaring [219 -131
;Loading [219 -131
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
;Loading [220 -133
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
;Loading [222 -135
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

;Declaring [225 -136
;Loading [225 -136
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
;Loading [227 -136
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

;Declaring [230 -137
;Loading [230 -137
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
;Loading [232 -137
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
;Loading [234 -137
add esp, -4
mov ebx, ebp
add ebx, -134
mov [esp], ebx
call OutputByte
add esp, 4
add esp, -1

mov byte [esp], 66

;Declaring [235 -138
;Loading [235 -138
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
add esp, -1

mov byte [esp], 65

;Declaring [238 -143
;Adding return value 
add esp, -1
;Loading [238 -144
add esp, -4
mov ebx, ebp
add ebx, -143
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

;Declaring MeByte -145
add esp, -1

add esp, -4
mov ebx, ebp
add ebx, -145
mov [esp], ebx
call Byte__On_Create
add esp, 4
add esp, -1

mov byte [esp], 2

;Declaring [240 -146
;Adding return value 
add esp, -1
;Loading [240 -147
add esp, -4
mov ebx, ebp
add ebx, -146
mov [esp], ebx
;Loading a Byte object
add esp, -4
mov ebx, ebp
add ebx, -145
mov [esp], ebx
call Byte__On_Plus
add esp, 8
;Loading [241 -147
add esp, -4
mov ebx, ebp
add ebx, -147
mov [esp], ebx
;Loading a Byte object
add esp, -4
mov ebx, ebp
add ebx, -145
mov [esp], ebx
call Byte__On_Equals
add esp, 8
add esp, 5
jmp S25
S24:
add esp, 2
S25:
;Declaring joe -146
add esp, -4

add esp, -4
mov ebx, ebp
add ebx, -146
mov [esp], ebx
call Pointer__On_Create
add esp, 4


mov esp, ebp
pop ebp
ret

