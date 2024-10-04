using HorizonSideRobots

function pole(r)
    putmarker!(r)
    n::Integer = 0
    for side1 in (Nord, Sud)
        for side2 in (West, Ost)
            while !isborder(r, side1) && !isborder(r, side2)
                move!(r, side1)
                move!(r, side
                2)
                n += 1
                putmarker!(r)
            end
            move2!(r, n, side1, side2)
            n = 0
        end
    end
end

function move2!(r, n, side1, side2)
    while n != 0
        move!(r, inverse(side1))
        move!(r, inverse(side2))
        n -= 1
    end
end

inverse(side::HorizonSide) = HorizonSide((Int(side)+2)%4)
    