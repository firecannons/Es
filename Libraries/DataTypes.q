// comment test
/* comment test 2 */
/* comment
test 3*/
class Byte size 1
        
        action asm on create
            ; asm comment
        end
        
        action asm on = ( Byte Source )
            mov ecx, rbp
            add ecx, 9
            movb eax, [ecx]
            sub ecx, 1
            mov [ecx], eax
        end
end
