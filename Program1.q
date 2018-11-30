using Libraries . Main

action hello ( Byte i1 , Letter l2 , Byte T3 )
  output ( "hello" )
end

action nothing ( Byte ed )
end


action Main
    hello ( 1 , "2" , "me" )

    nothing ( 4 + 2 )
end
