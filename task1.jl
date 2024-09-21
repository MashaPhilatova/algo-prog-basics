using HorizonSideRobots

function kross!(robot)
    for side in (Nord,Ost,Sud,West)
        num_steps = mark_direct!(robot, side)
        side = inverse(side)
        move!(robot, side, num_steps) #как цикл 
    end
end


function HorizonSideRobots.move!(robot, side, num_steps::Integer)
    for _ in 1:num_steps
        move!(robot, side)
    end
end

inverse(side::HorizonSide)=HorizonSide((Int(side)+2)%4) #в противоположное направление 

function mark_direct!(robot, side)
    n::Int=0 #после :: тип данных 
    while ! isborder(robot, side)
        move!(robot,side)
        putmarker!(robot)
        n+=1
    end
    return n
end

#Как запустить программу?
#1) написать всё в файле и в консоле написать julia>include("название файла.jl") 
#2) создать робота в консоле r = Robot(animate = true) и вызываем функции чтобы его передвинуть 