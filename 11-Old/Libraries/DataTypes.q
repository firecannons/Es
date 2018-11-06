// comment test
/* comment test 2 */
/* comment
test 3*/
class Byte size 1
        
        action asm on create
        end
        
        action asm on == ( Byte Source )
            mov ecx, rbp
	    add ecx, 17
            movb eax, [ecx]
	    sub ecx, 1
	    mov [ecx], eax
        end
end
