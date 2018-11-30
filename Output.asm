format ELF executable 3
segment readable executable
entry Main


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

Main:

push ebp
mov ebp, esp


;Declaring L
add esp, -1

add esp, -4
mov ebx, ebp
add ebx, -1
mov [esp], ebx
call Byte__On_Create
add esp, 4
;Loading L
add esp, -4
mov ebx, ebp
add ebx, -1
mov [esp], ebx
call OutputByte
add esp, 4
;Loading 100
add esp, -1

mov byte [esp], 100

add esp, -4
mov ebx, ebp
add ebx, -2
mov [esp], ebx
;Loading L
add esp, -4
mov ebx, ebp
add ebx, -1
mov [esp], ebx
call Byte__On_Equals
add esp, 9
;Loading 120
add esp, -1

mov byte [esp], 120

add esp, -4
mov ebx, ebp
add ebx, -2
mov [esp], ebx
;Loading L
add esp, -4
mov ebx, ebp
add ebx, -1
mov [esp], ebx
call Byte__On_Equals
add esp, 9
;Loading L
add esp, -4
mov ebx, ebp
add ebx, -1
mov [esp], ebx
call OutputByte
add esp, 4
;Declaring B2
add esp, -1

add esp, -4
mov ebx, ebp
add ebx, -2
mov [esp], ebx
call Byte__On_Create
add esp, 4
;Loading L
add esp, -4
mov ebx, ebp
add ebx, -1
mov [esp], ebx
call OutputByte
add esp, 4
;Loading 110
add esp, -1

mov byte [esp], 110

add esp, -4
mov ebx, ebp
add ebx, -3
mov [esp], ebx
;Loading B2
add esp, -4
mov ebx, ebp
add ebx, -2
mov [esp], ebx
call Byte__On_Equals
add esp, 9
;Loading L
add esp, -4
mov ebx, ebp
add ebx, -1
mov [esp], ebx
call OutputByte
add esp, 4
;Loading L
add esp, -4
mov ebx, ebp
add ebx, -1
mov [esp], ebx
;Loading B2
add esp, -4
mov ebx, ebp
add ebx, -2
mov [esp], ebx
call Byte__On_Equals
add esp, 8
;Loading L
add esp, -4
mov ebx, ebp
add ebx, -1
mov [esp], ebx
call OutputByte
add esp, 4
;Loading B2
add esp, -4
mov ebx, ebp
add ebx, -2
mov [esp], ebx
;Loading L
add esp, -4
mov ebx, ebp
add ebx, -1
mov [esp], ebx
call OutputByte2
add esp, 8
;Loading 121
add esp, -1

mov byte [esp], 121

add esp, -4
mov ebx, ebp
add ebx, -3
mov [esp], ebx
;Loading B2
add esp, -4
mov ebx, ebp
add ebx, -2
mov [esp], ebx
call Byte__On_Equals
add esp, 9
;Loading 119
add esp, -1

mov byte [esp], 119

add esp, -4
mov ebx, ebp
add ebx, -3
mov [esp], ebx
;Loading L
add esp, -4
mov ebx, ebp
add ebx, -1
mov [esp], ebx
call Byte__On_Equals
add esp, 9
;Loading B2
add esp, -4
mov ebx, ebp
add ebx, -2
mov [esp], ebx
;Loading L
add esp, -4
mov ebx, ebp
add ebx, -1
mov [esp], ebx
call OutputByte2
add esp, 8


mov esp, ebp
pop ebp
ret

