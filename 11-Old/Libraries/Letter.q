using Libraries . DataTypes

class Letter
        Byte c
        
        action on create
        end
        
        action on = ( Letter Source )
            c = Source . c
        end
end
