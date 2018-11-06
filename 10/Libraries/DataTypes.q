class Byte size 1
        
        action asm on create
        end
        
        action asm operator = ( Byte Source )
            mov ecx, rbp
	    add ecx, 17
            movb eax, [ecx]
	    sub ecx, 1
	    mov [ecx], eax
        end
end
