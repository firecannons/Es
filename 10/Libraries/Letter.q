using Libraries . DataTypes

class Letter
        Byte c
        
        action on create
        end
        
        action operator = ( Letter Source )
            c = Source . c
        end
end
