class Byte size 1
        
        asm on create
        end
        
        asm operator= ( Byte Source )
            mov ecx, rbp
	    add ecx, 8
            movb eax, [ecx]
	    add ecx, 4
	    mov [ecx], eax
        end
end
