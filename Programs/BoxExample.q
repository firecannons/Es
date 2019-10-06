class Box<T>
    T myT

    action SetMyT(T InT)
    myT = InT
    end

    action SetToAr(Array<int> In)
        T = In
    end
end

Box<int> A // fails to compile
Box<Array<int>> B // compiles


Box<MyCls<A,B,C>> dumb