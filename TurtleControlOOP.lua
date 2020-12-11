-- Basic API for control of turtle while keeping track of position etc

-- Meta Class
TurtleControl = {position = {0,0,0}
				, heading = {0,1}}

-- Class constructor

function TurtleControl:new (o)
	o = o or {}
	setmetatable(0, self)
	self.__index = self
	return o
end

function TurtleControl:forward()
	turtle.forward()

	self.position[1] = self.position[1] + self.heading[1]
	self.position[2] = self.position[2] + self.heading[2]
end

function TurtleControl:turnLeft()
	turtle.turnLeft()
	if heading == 1 then
		self.heading[1] = 0
		self.heading[2] = 1
	elseif self.heading[1] == -1 then
		self.heading[1] = 0
		self.heading[2] = -1
	elseif self.heading[2] == 1 then
		self.heading[1] = -1
		self.heading[2] = 0
	else
		self.heading[1] = 1
		self.heading[2] = 0
	end
end

function TurtleControl:turnRight()
	turtle.turnLeft()
	if heading == 1 then
		self.heading[1] = 0
		self.heading[2] = -1
	elseif self.heading[1] == -1 then
		self.heading[1] = 0
		self.heading[2] = 1
	elseif self.heading[2] == 1 then
		self.heading[1] = 1
		self.heading[2] = 0
	else
		self.heading[1] = -1
		self.heading[2] = 0
	end
end

function TurtleControl:up()
	if turtle.detectUp()
		turtle.digUp()
	end
	turtle.up()
	self.position[3] = self.position[3] + 1
end

function TurtleControl:down()
	if turtle.detectDown()
		turtle.digDown()
	end
	turtle.down()
	self.position[3] = self.position[3] - 1
end

function TurtleControl:goHome()
	-- Go pack to starting height
	while self.position[3] > 0 do
		down()
	end
	while self.position[3] < 0 do
		up()
	end 

	-- Walk to {0,0} in easiest manner
	while self.heading[1] ~= -1 do
		turnLeft()
	end
	while self.position[1] > 0 do
		forward()
	end
	while self.heading[2] ~= -1 do
		turnLeft)()
	end
	while self.position[2] > 0 do
		forward()
	end

	-- Park for end of program
	park()
end