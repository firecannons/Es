format ELF64 executable 3
segment readable executable
entry Main



On_Create:
ret

On_Equals:
add rsp , 1
ret

On_Create:
ret

On_Equals:
add rsp , 1
ret

On_Create:
ret

On_Create:
ret

hello:
add rsp , 1
add rsp , 1
add rsp , 1
ret

nothing:
add rsp , 1
ret

Main:
ret

