function perimetr!(robot)
    count_down = count_steps(robot, Sud)
    count_right = count_steps(robot, Ost)
    for side in (West, Nord, Ost, Sud)
        movement!(robot,side)
    end
    back!(robot,count_down, count_right)

end

function count_steps(robot, side)
    n=0
    while isborder(robot,side) == false 
        move!(robot, side)
        n+=1
    end
    return n
end 

function movement!(robot, side)
    while isborder(robot, side) == false
        move!(robot, side)
        putmarker!(robot)
    end
end