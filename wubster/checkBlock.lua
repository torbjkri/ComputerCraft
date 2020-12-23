function checkBlock(cameFrom)
    -- check left
    turtle.turnLeft()
    if isUseless == false then
        turtle.dig()
        turtle.forward()
        checkBlock("back")
    end
    -- check middle
    turtle.turnRight()
    if isUseless == false then
        turtle.dig()
        turtle.forward()
        checkBlock("back")
    end
    -- check right
    turtle.turnRight()
    if isUseless() == false then
        turtle.dig()
        turtle.forward()
        checkBlock("back")
    end    
    --check back
    if cameFrom ~= "back" then
        turtle.turnRight
        if isUseless == false then
            turtle.dig()
            turtle.forward()
            checkBlock("back")
            turtle.turnLeft()
        end
    end
    -- reset position
    turtle.turnLeft()

    -- check top
    if cameFrom ~= "top"
        if isTopUseless == false then
            turtle.digUp()
            turtle.up()
            checkBlock("bot")
        end
    end

    -- check bottom
    if cameFrom ~= "bot"
        if isTopUseless == false then
            turtle.digDown()
            turtle.down()
            checkBlock("top")
        end
    end

    if cameFrom == "back" then
        turtle.turnLeft()
        turtle.turnLeft()
        turtle.forward()
        turtle.turnLeft()
        turtle.turnLeft()
    else if cameFrom == "top" then
        turtle.up()
    else if cameFrom == "bot" then
        turtle.down()
    else
        print("cameFrom value not valid: " ..cameFrom..)
    end
end