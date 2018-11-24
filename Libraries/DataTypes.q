// comment test
/* comment test 2 */
/* comment
test 3*/
class Byte size 1
        
        action asm on create
            ; asm comment
        end
        
        action asm on = ( Byte Source )
            
            ; mov value of Source into eax
            mov ebx, ebp
            add ebx, 12
            mov eax, [ebx]
            mov eax, [eax]
            
            ; mov address of return byte into ebx
            sub ebx, 4
            mov ebx, [ebx]
            
            ; mov value of eax into position of [ebx]
            mov [ebx], eax
        end
end
