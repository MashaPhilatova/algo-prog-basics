using HorizonSideRobots

function count_partitions(r)
    state = 0
    cnt = 0
    side = Ost
    x::Int, y::Int = move_to_top_right(r)
    while !isborder(r, Nord)
        cnt = check_row_for_partitions(r, state, cnt, side)
        side = inverse(side)
    end
    move_to_start(r, x, y)
    println(cnt)
end

function check_row_for_partitions(r, state, cnt, side)
    while !isborder(r, side)
        move!(r, side)
        if state == 0
            (isborder(r,Nord) == true) && (state = 1; cnt += 1)
        elseif state == 1
            (isborder(r, Nord) == false) && (state = 0)
        end
    end
    move!(r, Nord)
    return cnt
end

inverse(side::HorizonSide) = HorizonSide((Int(side)+2)%4)

function move_to_top_right(r)
    x = 0
    y = 0
    while !isborder(r, West)
        move!(r, West)
        x += 1
    end
    while !isborder(r, Sud)
        move!(r, Sud)
        y += 1
    end
    return x, y
end

function move_to_start(r, x, y)
    move_to_top_right(r)
    while y != 0
        move!(r, Nord)
        y -= 1
    end
    while x != 0
        move!(r, Ost)
        x -= 1
    end
end