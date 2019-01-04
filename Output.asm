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
            mov ebx, [ebx]
            mov byte [ebx], al
            
        

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


;Declaring L
add esp, -1

add esp, -4
mov ebx, ebp
add ebx, -1
mov [esp], ebx
call Byte__On_Create
add esp, 4
add esp, -1

mov byte [esp], 102

;Declaring [0
;Loading [0
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
add esp, 8
;Loading L
add esp, -4
mov ebx, ebp
add ebx, -1
mov [esp], ebx
call OutputByte
add esp, 4
add esp, -1

mov byte [esp], 100

;Declaring [1
;Loading [1
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
add esp, 8
add esp, -1

mov byte [esp], 120

;Declaring [2
;Loading [2
add esp, -4
mov ebx, ebp
add ebx, -4
mov [esp], ebx
;Loading L
add esp, -4
mov ebx, ebp
add ebx, -1
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
;Declaring B2
add esp, -1

add esp, -4
mov ebx, ebp
add ebx, -5
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
add esp, -1

mov byte [esp], 110

;Declaring [3
;Loading [3
add esp, -4
mov ebx, ebp
add ebx, -6
mov [esp], ebx
;Loading B2
add esp, -4
mov ebx, ebp
add ebx, -5
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
;Loading L
add esp, -4
mov ebx, ebp
add ebx, -1
mov [esp], ebx
;Loading B2
add esp, -4
mov ebx, ebp
add ebx, -5
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
add ebx, -5
mov [esp], ebx
;Loading L
add esp, -4
mov ebx, ebp
add ebx, -1
mov [esp], ebx
call OutputByte2
add esp, 8
add esp, -1

mov byte [esp], 121

;Declaring [4
;Loading [4
add esp, -4
mov ebx, ebp
add ebx, -7
mov [esp], ebx
;Loading B2
add esp, -4
mov ebx, ebp
add ebx, -5
mov [esp], ebx
call Byte__On_Equals
add esp, 8
add esp, -1

mov byte [esp], 119

;Declaring [5
;Loading [5
add esp, -4
mov ebx, ebp
add ebx, -8
mov [esp], ebx
;Loading L
add esp, -4
mov ebx, ebp
add ebx, -1
mov [esp], ebx
call Byte__On_Equals
add esp, 8
;Loading B2
add esp, -4
mov ebx, ebp
add ebx, -5
mov [esp], ebx
;Loading L
add esp, -4
mov ebx, ebp
add ebx, -1
mov [esp], ebx
call OutputByte2
add esp, 8
;Declaring B3
add esp, -1

add esp, -4
mov ebx, ebp
add ebx, -9
mov [esp], ebx
call Byte__On_Create
add esp, 4
;Declaring B4
add esp, -1

add esp, -4
mov ebx, ebp
add ebx, -10
mov [esp], ebx
call Byte__On_Create
add esp, 4
;Declaring B5
add esp, -1

add esp, -4
mov ebx, ebp
add ebx, -11
mov [esp], ebx
call Byte__On_Create
add esp, 4
add esp, -1

mov byte [esp], 100

;Declaring [6
;Loading [6
add esp, -4
mov ebx, ebp
add ebx, -12
mov [esp], ebx
;Loading L
add esp, -4
mov ebx, ebp
add ebx, -1
mov [esp], ebx
call Byte__On_Equals
add esp, 8
add esp, -1

mov byte [esp], 101

;Declaring [7
;Loading [7
add esp, -4
mov ebx, ebp
add ebx, -13
mov [esp], ebx
;Loading B2
add esp, -4
mov ebx, ebp
add ebx, -5
mov [esp], ebx
call Byte__On_Equals
add esp, 8
add esp, -1

mov byte [esp], 102

;Declaring [8
;Loading [8
add esp, -4
mov ebx, ebp
add ebx, -14
mov [esp], ebx
;Loading B3
add esp, -4
mov ebx, ebp
add ebx, -9
mov [esp], ebx
call Byte__On_Equals
add esp, 8
add esp, -1

mov byte [esp], 103

;Declaring [9
;Loading [9
add esp, -4
mov ebx, ebp
add ebx, -15
mov [esp], ebx
;Loading B4
add esp, -4
mov ebx, ebp
add ebx, -10
mov [esp], ebx
call Byte__On_Equals
add esp, 8
add esp, -1

mov byte [esp], 104

;Declaring [10
;Loading [10
add esp, -4
mov ebx, ebp
add ebx, -16
mov [esp], ebx
;Loading B5
add esp, -4
mov ebx, ebp
add ebx, -11
mov [esp], ebx
call Byte__On_Equals
add esp, 8
;Loading B5
add esp, -4
mov ebx, ebp
add ebx, -11
mov [esp], ebx
;Loading B4
add esp, -4
mov ebx, ebp
add ebx, -10
mov [esp], ebx
;Loading B3
add esp, -4
mov ebx, ebp
add ebx, -9
mov [esp], ebx
;Loading B2
add esp, -4
mov ebx, ebp
add ebx, -5
mov [esp], ebx
;Loading L
add esp, -4
mov ebx, ebp
add ebx, -1
mov [esp], ebx
call OutputByte5
add esp, 20
add esp, -1

mov byte [esp], 32

;Declaring [11
;Loading [11
add esp, -4
mov ebx, ebp
add ebx, -17
mov [esp], ebx
;Loading B5
add esp, -4
mov ebx, ebp
add ebx, -11
mov [esp], ebx
call Byte__On_Equals
add esp, 8
;Loading B5
add esp, -4
mov ebx, ebp
add ebx, -11
mov [esp], ebx
call OutputByte
add esp, 4
;Loading B5
add esp, -4
mov ebx, ebp
add ebx, -11
mov [esp], ebx
call OutputByte
add esp, 4
;Loading B5
add esp, -4
mov ebx, ebp
add ebx, -11
mov [esp], ebx
call OutputByte
add esp, 4
;Loading B5
add esp, -4
mov ebx, ebp
add ebx, -11
mov [esp], ebx
call OutputByte
add esp, 4
;Loading B5
add esp, -4
mov ebx, ebp
add ebx, -11
mov [esp], ebx
call OutputByte
add esp, 4
;Declaring S1
add esp, -1

add esp, -4
mov ebx, ebp
add ebx, -18
mov [esp], ebx
call Byte__On_Create
add esp, 4
;Declaring S2
add esp, -1

add esp, -4
mov ebx, ebp
add ebx, -19
mov [esp], ebx
call Byte__On_Create
add esp, 4
;Declaring S3
add esp, -1

add esp, -4
mov ebx, ebp
add ebx, -20
mov [esp], ebx
call Byte__On_Create
add esp, 4
add esp, -1

mov byte [esp], 100

;Declaring [12
;Loading [12
add esp, -4
mov ebx, ebp
add ebx, -21
mov [esp], ebx
;Loading S1
add esp, -4
mov ebx, ebp
add ebx, -18
mov [esp], ebx
call Byte__On_Equals
add esp, 8
add esp, -1

mov byte [esp], 101

;Declaring [13
;Loading [13
add esp, -4
mov ebx, ebp
add ebx, -22
mov [esp], ebx
;Loading S2
add esp, -4
mov ebx, ebp
add ebx, -19
mov [esp], ebx
call Byte__On_Equals
add esp, 8
;Loading S1
add esp, -4
mov ebx, ebp
add ebx, -18
mov [esp], ebx
;Loading S3
add esp, -4
mov ebx, ebp
add ebx, -20
mov [esp], ebx
call Byte__On_Equals
add esp, 8
;Loading S2
add esp, -4
mov ebx, ebp
add ebx, -19
mov [esp], ebx
;Loading S1
add esp, -4
mov ebx, ebp
add ebx, -18
mov [esp], ebx
call Byte__On_Equals
add esp, 8
;Loading S3
add esp, -4
mov ebx, ebp
add ebx, -20
mov [esp], ebx
;Loading S2
add esp, -4
mov ebx, ebp
add ebx, -19
mov [esp], ebx
call Byte__On_Equals
add esp, 8
;Loading S1
add esp, -4
mov ebx, ebp
add ebx, -18
mov [esp], ebx
call OutputByte
add esp, 4
;Loading S2
add esp, -4
mov ebx, ebp
add ebx, -19
mov [esp], ebx
call OutputByte
add esp, 4
;Loading S3
add esp, -4
mov ebx, ebp
add ebx, -20
mov [esp], ebx
call OutputByte
add esp, 4
add esp, -1

mov byte [esp], 1

;Declaring [14
;Adding return value 
add esp, -1
;Loading [14
add esp, -4
mov ebx, ebp
add ebx, -23
mov [esp], ebx
;Loading S3
add esp, -4
mov ebx, ebp
add ebx, -20
mov [esp], ebx
call Byte__On_Plus
add esp, 8
;Loading [15
add esp, -4
mov ebx, ebp
add ebx, -24
mov [esp], ebx
;Loading S3
add esp, -4
mov ebx, ebp
add ebx, -20
mov [esp], ebx
call Byte__On_Equals
add esp, 8
;Loading S3
add esp, -4
mov ebx, ebp
add ebx, -20
mov [esp], ebx
call OutputByte
add esp, 4
add esp, -1

mov byte [esp], 1

;Declaring [16
;Adding return value 
add esp, -1
;Loading [16
add esp, -4
mov ebx, ebp
add ebx, -25
mov [esp], ebx
;Loading S3
add esp, -4
mov ebx, ebp
add ebx, -20
mov [esp], ebx
call Byte__On_Plus
add esp, 8
;Loading [17
add esp, -4
mov ebx, ebp
add ebx, -26
mov [esp], ebx
;Loading S3
add esp, -4
mov ebx, ebp
add ebx, -20
mov [esp], ebx
call Byte__On_Equals
add esp, 8
;Loading S3
add esp, -4
mov ebx, ebp
add ebx, -20
mov [esp], ebx
call OutputByte
add esp, 4
add esp, -1

mov byte [esp], 1

;Declaring [18
;Adding return value 
add esp, -1
;Loading [18
add esp, -4
mov ebx, ebp
add ebx, -27
mov [esp], ebx
;Loading S3
add esp, -4
mov ebx, ebp
add ebx, -20
mov [esp], ebx
call Byte__On_Plus
add esp, 8
;Loading [19
add esp, -4
mov ebx, ebp
add ebx, -28
mov [esp], ebx
;Loading S3
add esp, -4
mov ebx, ebp
add ebx, -20
mov [esp], ebx
call Byte__On_Equals
add esp, 8
;Loading S3
add esp, -4
mov ebx, ebp
add ebx, -20
mov [esp], ebx
call OutputByte
add esp, 4
add esp, -1

mov byte [esp], 1

;Declaring [20
;Adding return value 
add esp, -1
;Loading [20
add esp, -4
mov ebx, ebp
add ebx, -29
mov [esp], ebx
;Loading S3
add esp, -4
mov ebx, ebp
add ebx, -20
mov [esp], ebx
call Byte__On_Plus
add esp, 8
;Loading [21
add esp, -4
mov ebx, ebp
add ebx, -30
mov [esp], ebx
;Loading S3
add esp, -4
mov ebx, ebp
add ebx, -20
mov [esp], ebx
call Byte__On_Equals
add esp, 8
;Loading S3
add esp, -4
mov ebx, ebp
add ebx, -20
mov [esp], ebx
call OutputByte
add esp, 4
add esp, -1

mov byte [esp], 1

;Declaring [22
;Adding return value 
add esp, -1
;Loading [22
add esp, -4
mov ebx, ebp
add ebx, -31
mov [esp], ebx
;Loading S3
add esp, -4
mov ebx, ebp
add ebx, -20
mov [esp], ebx
call Byte__On_Plus
add esp, 8
;Loading [23
add esp, -4
mov ebx, ebp
add ebx, -32
mov [esp], ebx
;Loading S3
add esp, -4
mov ebx, ebp
add ebx, -20
mov [esp], ebx
call Byte__On_Equals
add esp, 8
;Loading S3
add esp, -4
mov ebx, ebp
add ebx, -20
mov [esp], ebx
call OutputByte
add esp, 4
add esp, -1

mov byte [esp], 1

;Declaring [24
;Adding return value 
add esp, -1
;Loading [24
add esp, -4
mov ebx, ebp
add ebx, -33
mov [esp], ebx
;Loading S3
add esp, -4
mov ebx, ebp
add ebx, -20
mov [esp], ebx
call Byte__On_Plus
add esp, 8
;Loading [25
add esp, -4
mov ebx, ebp
add ebx, -34
mov [esp], ebx
;Loading S3
add esp, -4
mov ebx, ebp
add ebx, -20
mov [esp], ebx
call Byte__On_Equals
add esp, 8
;Loading S3
add esp, -4
mov ebx, ebp
add ebx, -20
mov [esp], ebx
call OutputByte
add esp, 4
add esp, -1

mov byte [esp], 1

;Declaring [26
;Adding return value 
add esp, -1
;Loading [26
add esp, -4
mov ebx, ebp
add ebx, -35
mov [esp], ebx
;Loading S3
add esp, -4
mov ebx, ebp
add ebx, -20
mov [esp], ebx
call Byte__On_Plus
add esp, 8
;Loading [27
add esp, -4
mov ebx, ebp
add ebx, -36
mov [esp], ebx
;Loading S3
add esp, -4
mov ebx, ebp
add ebx, -20
mov [esp], ebx
call Byte__On_Equals
add esp, 8
;Loading S3
add esp, -4
mov ebx, ebp
add ebx, -20
mov [esp], ebx
call OutputByte
add esp, 4
add esp, -1

mov byte [esp], 1

;Declaring [28
;Adding return value 
add esp, -1
;Loading [28
add esp, -4
mov ebx, ebp
add ebx, -37
mov [esp], ebx
;Loading S3
add esp, -4
mov ebx, ebp
add ebx, -20
mov [esp], ebx
call Byte__On_Plus
add esp, 8
;Loading [29
add esp, -4
mov ebx, ebp
add ebx, -38
mov [esp], ebx
;Loading S3
add esp, -4
mov ebx, ebp
add ebx, -20
mov [esp], ebx
call Byte__On_Equals
add esp, 8
;Loading S3
add esp, -4
mov ebx, ebp
add ebx, -20
mov [esp], ebx
call OutputByte
add esp, 4
add esp, -1

mov byte [esp], 1

;Declaring [30
;Adding return value 
add esp, -1
;Loading [30
add esp, -4
mov ebx, ebp
add ebx, -39
mov [esp], ebx
;Loading S3
add esp, -4
mov ebx, ebp
add ebx, -20
mov [esp], ebx
call Byte__On_Minus
add esp, 8
;Loading [31
add esp, -4
mov ebx, ebp
add ebx, -40
mov [esp], ebx
;Loading S3
add esp, -4
mov ebx, ebp
add ebx, -20
mov [esp], ebx
call Byte__On_Equals
add esp, 8
;Loading S3
add esp, -4
mov ebx, ebp
add ebx, -20
mov [esp], ebx
call OutputByte
add esp, 4
add esp, -1

mov byte [esp], 1

;Declaring [32
;Adding return value 
add esp, -1
;Loading [32
add esp, -4
mov ebx, ebp
add ebx, -41
mov [esp], ebx
;Loading S3
add esp, -4
mov ebx, ebp
add ebx, -20
mov [esp], ebx
call Byte__On_Minus
add esp, 8
;Loading [33
add esp, -4
mov ebx, ebp
add ebx, -42
mov [esp], ebx
;Loading S3
add esp, -4
mov ebx, ebp
add ebx, -20
mov [esp], ebx
call Byte__On_Equals
add esp, 8
;Loading S3
add esp, -4
mov ebx, ebp
add ebx, -20
mov [esp], ebx
call OutputByte
add esp, 4
add esp, -1

mov byte [esp], 1

;Declaring [34
;Adding return value 
add esp, -1
;Loading [34
add esp, -4
mov ebx, ebp
add ebx, -43
mov [esp], ebx
;Loading S3
add esp, -4
mov ebx, ebp
add ebx, -20
mov [esp], ebx
call Byte__On_Minus
add esp, 8
;Loading [35
add esp, -4
mov ebx, ebp
add ebx, -44
mov [esp], ebx
;Loading S3
add esp, -4
mov ebx, ebp
add ebx, -20
mov [esp], ebx
call Byte__On_Equals
add esp, 8
;Loading S3
add esp, -4
mov ebx, ebp
add ebx, -20
mov [esp], ebx
call OutputByte
add esp, 4
add esp, -1

mov byte [esp], 1

;Declaring [36
;Adding return value 
add esp, -1
;Loading [36
add esp, -4
mov ebx, ebp
add ebx, -45
mov [esp], ebx
;Loading S3
add esp, -4
mov ebx, ebp
add ebx, -20
mov [esp], ebx
call Byte__On_Minus
add esp, 8
;Loading [37
add esp, -4
mov ebx, ebp
add ebx, -46
mov [esp], ebx
;Loading S3
add esp, -4
mov ebx, ebp
add ebx, -20
mov [esp], ebx
call Byte__On_Equals
add esp, 8
;Loading S3
add esp, -4
mov ebx, ebp
add ebx, -20
mov [esp], ebx
call OutputByte
add esp, 4
add esp, -1

mov byte [esp], 1

;Declaring [38
;Adding return value 
add esp, -1
;Loading [38
add esp, -4
mov ebx, ebp
add ebx, -47
mov [esp], ebx
;Loading S3
add esp, -4
mov ebx, ebp
add ebx, -20
mov [esp], ebx
call Byte__On_Minus
add esp, 8
;Loading [39
add esp, -4
mov ebx, ebp
add ebx, -48
mov [esp], ebx
;Loading S3
add esp, -4
mov ebx, ebp
add ebx, -20
mov [esp], ebx
call Byte__On_Equals
add esp, 8
;Loading S3
add esp, -4
mov ebx, ebp
add ebx, -20
mov [esp], ebx
call OutputByte
add esp, 4
add esp, -1

mov byte [esp], 1

;Declaring [40
;Adding return value 
add esp, -1
;Loading [40
add esp, -4
mov ebx, ebp
add ebx, -49
mov [esp], ebx
;Loading S3
add esp, -4
mov ebx, ebp
add ebx, -20
mov [esp], ebx
call Byte__On_Minus
add esp, 8
add esp, -1

mov byte [esp], 1

;Declaring [42
;Adding return value 
add esp, -1
;Loading [42
add esp, -4
mov ebx, ebp
add ebx, -51
mov [esp], ebx
;Loading [41
add esp, -4
mov ebx, ebp
add ebx, -50
mov [esp], ebx
call Byte__On_Minus
add esp, 8
add esp, -1

mov byte [esp], 1

;Declaring [44
;Adding return value 
add esp, -1
;Loading [44
add esp, -4
mov ebx, ebp
add ebx, -53
mov [esp], ebx
;Loading [43
add esp, -4
mov ebx, ebp
add ebx, -52
mov [esp], ebx
call Byte__On_Minus
add esp, 8
add esp, -1

mov byte [esp], 1

;Declaring [46
;Adding return value 
add esp, -1
;Loading [46
add esp, -4
mov ebx, ebp
add ebx, -55
mov [esp], ebx
;Loading [45
add esp, -4
mov ebx, ebp
add ebx, -54
mov [esp], ebx
call Byte__On_Minus
add esp, 8
;Loading [47
add esp, -4
mov ebx, ebp
add ebx, -56
mov [esp], ebx
;Loading S3
add esp, -4
mov ebx, ebp
add ebx, -20
mov [esp], ebx
call Byte__On_Equals
add esp, 8
;Loading S3
add esp, -4
mov ebx, ebp
add ebx, -20
mov [esp], ebx
call OutputByte
add esp, 4
add esp, -1

mov byte [esp], 1

;Declaring [48
;Adding return value 
add esp, -1
;Loading [48
add esp, -4
mov ebx, ebp
add ebx, -57
mov [esp], ebx
;Loading S3
add esp, -4
mov ebx, ebp
add ebx, -20
mov [esp], ebx
call Byte__On_Minus
add esp, 8
;Loading [49
add esp, -4
mov ebx, ebp
add ebx, -58
mov [esp], ebx
;Loading S3
add esp, -4
mov ebx, ebp
add ebx, -20
mov [esp], ebx
call Byte__On_Equals
add esp, 8
;Loading S3
add esp, -4
mov ebx, ebp
add ebx, -20
mov [esp], ebx
call OutputByte
add esp, 4
;Declaring S4
add esp, -1

add esp, -4
mov ebx, ebp
add ebx, -59
mov [esp], ebx
call Byte__On_Create
add esp, 4
add esp, -1

mov byte [esp], 1

;Declaring [50
;Loading [50
add esp, -4
mov ebx, ebp
add ebx, -60
mov [esp], ebx
;Loading S4
add esp, -4
mov ebx, ebp
add ebx, -59
mov [esp], ebx
call Byte__On_Equals
add esp, 8
;Adding return value 
add esp, -1
;Loading S4
add esp, -4
mov ebx, ebp
add ebx, -59
mov [esp], ebx
;Loading S3
add esp, -4
mov ebx, ebp
add ebx, -20
mov [esp], ebx
call Byte__On_Minus
add esp, 8
;Loading [51
add esp, -4
mov ebx, ebp
add ebx, -61
mov [esp], ebx
;Loading S3
add esp, -4
mov ebx, ebp
add ebx, -20
mov [esp], ebx
call Byte__On_Equals
add esp, 8
;Loading S3
add esp, -4
mov ebx, ebp
add ebx, -20
mov [esp], ebx
call OutputByte
add esp, 4
;Declaring S5
add esp, -1

add esp, -4
mov ebx, ebp
add ebx, -62
mov [esp], ebx
call Byte__On_Create
add esp, 4
add esp, -1

mov byte [esp], 115

;Declaring [52
;Loading [52
add esp, -4
mov ebx, ebp
add ebx, -63
mov [esp], ebx
;Loading S5
add esp, -4
mov ebx, ebp
add ebx, -62
mov [esp], ebx
call Byte__On_Equals
add esp, 8
;Loading S5
add esp, -4
mov ebx, ebp
add ebx, -62
mov [esp], ebx
call OutputByte
add esp, 4
;Declaring S6
add esp, -1

add esp, -4
mov ebx, ebp
add ebx, -64
mov [esp], ebx
call Byte__On_Create
add esp, 4
;Loading S5
add esp, -4
mov ebx, ebp
add ebx, -62
mov [esp], ebx
;Loading S6
add esp, -4
mov ebx, ebp
add ebx, -64
mov [esp], ebx
call Byte__On_Equals
add esp, 8
;Loading S6
add esp, -4
mov ebx, ebp
add ebx, -64
mov [esp], ebx
call OutputByte
add esp, 4
add esp, -1

mov byte [esp], 5

;Declaring [53
;Adding return value 
add esp, -1
;Loading [53
add esp, -4
mov ebx, ebp
add ebx, -65
mov [esp], ebx
;Loading S6
add esp, -4
mov ebx, ebp
add ebx, -64
mov [esp], ebx
call Byte__On_Minus
add esp, 8
;Loading [54
add esp, -4
mov ebx, ebp
add ebx, -66
mov [esp], ebx
;Loading S6
add esp, -4
mov ebx, ebp
add ebx, -64
mov [esp], ebx
call Byte__On_Equals
add esp, 8
;Loading S6
add esp, -4
mov ebx, ebp
add ebx, -64
mov [esp], ebx
call OutputByte
add esp, 4
R0:
add esp, -1

mov byte [esp], 105

;Declaring [55
;Adding return value 
add esp, -1
;Loading [55
add esp, -4
mov ebx, ebp
add ebx, -67
mov [esp], ebx
;Loading S6
add esp, -4
mov ebx, ebp
add ebx, -64
mov [esp], ebx
call Byte__On_Greater_Than
add esp, 8
test cl, cl
	jne R1

