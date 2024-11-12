using HorizonSideRobots
robot = Robot(animate=true)

function search_for_marker!(robot)
    search!(robot, 1, West)
end

turn(side::HorizonSide)=HorizonSide( ( Int(side)+3) % 4 )

function search!(robot, step, side_movement)
    for _ in 0:step
        move!(robot, side_movement)
        if ismarker(robot)
            return nothing
        end
    end
    return Int(side_movement)%2 == 0 ? search!(robot, step+1, turn(side_movement)) : search!(robot, step, turn(side_movement)) 
end 