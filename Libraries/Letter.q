using Libraries . DataTypes

class Letter
        Byte c
        
        action Constructor
        end
        
        action on = ( Letter Source )
            Me : c = Source : c
        end
end
