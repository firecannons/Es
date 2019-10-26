using Libraries.DataTypes

class AClass < T >
    action Set (Integer Ar)
    end
end

class AnotherClass
    action Set (AClass<Integer, Integer> I)
    end
end

action Main
end
