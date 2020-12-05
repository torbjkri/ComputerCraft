-- API for controlling the turtle
-- asumes the turtle starts in (0,0,0) with heading (0,1,0)


globalPosition = {0,0,0}
globalHeading = {0,1,0}


function forward()
	if turtle.detect()
		turtle.dig()
	end
	turtle.forward()

	if turtle.detectUp()
		turtle.digUp()
	end
	if turtle.detectDown()
		turtle.digDown()
	end
	globalPosition[1] = globalPosition[1] + globalFacing[1]
	globalPosition[2] = globalPosition[2] + globalFacing[2]
end

function turnLeft()
	turtle.turnLeft()
	if facing == 1 then
		globalFacing[1] = 0
		globalFacing[2] = 1
	elseif globalFacing[1] == -1 then
		globalFacing[1] = 0
		globalFacing[2] = -1
	elseif globalFacing[2] == 1 then
		globalFacing[1] = -1
		globalFacing[2] = 0
	else
		globalFacing[1] = 1
		globalFacing[2] = 0
	end
end

function turnRight()
	turtle.turnLeft()
	if facing == 1 then
		globalFacing[1] = 0
		globalFacing[2] = -1
	elseif globalFacing[1] == -1 then
		globalFacing[1] = 0
		globalFacing[2] = 1
	elseif globalFacing[2] == 1 then
		globalFacing[1] = 1
		globalFacing[2] = 0
	else
		globalFacing[1] = -1
		globalFacing[2] = 0
	end
end

function goStart()
	turtle.forward()
end

function park()
	while globalFacing[2] ~= -1 do
		turnLeft()
	end
	turtle.forward()
	turnLeft()
	turnLeft()
end

function goHome()
	while globalFacing[1] ~= -1 do
		turnLeft()
	end
	while globalPosition[1] > 0 do
		forward()
	end
	while globalFacing[2] ~= -1 do
		turnLeft)()
	end
	while globalPosition[2] > 0 do
		forward()
	end
	park()
end

function digColumn(length)
	for i = 1,length do
		forward()
	end
end

function goToNextColumn()
	if globalFacing[2] == -1 then
		turnLeft()
		forward()
		turnLeft()
	else
		turnRight()
		forward()
		turnRight()
	end
end

function digSquare(squareSize)
	for i = 1,squareSize do
		digColumn(squareSize-1)
		goToNextColumn()
	end
end