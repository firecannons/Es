using Libraries . DataTypes

class Letter
        Byte c
        
        on create
        end
        
        operator= ( Letter Source )
            c = Source . c
        end
end