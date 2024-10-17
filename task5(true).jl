using HorizonSideRobots

function pole(r)
    d::Int = 0
    l::Int = 0
    k::Int = 0
    d, l = left_ugol(r, West)
    for side in (Ost, Nord, West, Sud)
        while !isborder(r, side)
            putmarker!(r)
            move!(r, side)
        end
    end
    side1 = West
    f::Int = 0
    while f != 1
        for side in (Ost, West)
            if f == 1
                break
            end
            n::Int = 1
            while !isborder(r, side)
                move!(r, side)
                n += 1
            end
            if n == 12
                move!(r, Nord)
            else
                f = 1
                side1 = side
            end
        end
    end
    if side1 == West
        k = 1
    end
    perimetr!(r, side1)
    vosvr(r,d,l)
end

function left_ugol(r, side1)
    d::Int = 0
    l::Int = 0
    while !isborder(r, side1) || !isborder(r, Sud)
        for side in (Sud, side1)
            while !isborder(r, side)
                move!(r, side)
                if side == Sud
                    d += 1
                else
                    l += 1
                end
            end
        end
    end
    return d, l
end

function perimetr!(r, side1)
    for side in (Nord, side1, Sud, inverse(side1))
        if side == Nord
            side2 = side1
        elseif side == side1
            side2 = Sud
        elseif side == Sud
            side2 = inverse(side1)
        elseif side == inverse(side1)
            side2 = Nord
        end
        while isborder(r, side2)
            putmarker!(r)
            move!(r, side)
        end
        putmarker!(r)
        move!(r,side2)
    end
    while !ismarker(r)
        putmarker!(r)
        move!(r, Nord)
    end
end

inverse(side::HorizonSide) = HorizonSide((Int(side)+2)%4)

function vosvr(r, d, l)
    d1::Int = d
    l1::Int = 11 - l
    left_ugol(r, West)
    while d != 0
        move!(r, Nord)
        d -= 1
    end
    while l != 0
        if isborder(r, Ost)
            left_ugol(r, Ost)
            while d1 != 0 
                move!(r, Nord)
                d1 -= 1
            end
            while l1 != 0
                move!(r, West)
                l1 -=1
            end
            break
        end
        move!(r, Ost)
        l -= 1
    end
end