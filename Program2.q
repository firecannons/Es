using Libraries . DataTypes

action asm OutputLetter ( Byte L )
    mov ecx, ebp
    add ecx, 9
    mov eax, [ecx]
    mov	eax,4
	mov	ebx,1
	;mov	ecx,msg
	mov	edx,1
	int	0x80
end

action Main
    Byte L
    L = 97
    OutputByte ( L )
end
