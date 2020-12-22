-- Basic API for control of turtle while keeping track of position etc

-- Meta Class

turtle = require "TurtleMock"
	
local headingDirection = {0 = {0,1},
						  1 = {1,0},
						  2 = {0,-1},
						  3 = {-1,0}}

TurtleControl = {position = {0,0,0}
				, heading = 0}

-- Class constructor

function TurtleControl:new (o)
	o = o or {}
	setmetatable(o, self)
	self.__index = self
	return o
end

function TurtleControl:forward()
	turtle.forward()

	self.position[1] = self.position[1] + headingDirection[self.heading][1]
	self.position[2] = self.position[2] + headingDirection[self.heading][2]
end

function TurtleControl:turnLeft()
	turtle.turnLeft()
	self.heading = (self.heading - 1) % 4
end

function TurtleControl:turnRight()
	turtle.turnRight()
	self.heading = (self.heading + 1) % 4
end

function TurtleControl:up()
	if turtle.detectUp() then
		turtle.digUp()
	end
	turtle.up()
	self.position[3] = self.position[3] + 1
end

function TurtleControl:down()
	if turtle.detectDown() then
		turtle.digDown()
	end
	turtle.down()
	self.position[3] = self.position[3] - 1
end

function TurtleControl:goToStart()
	-- Walk to {0,0} in easiest manner
	while self.heading[1] ~= -1 do
		self:turnLeft()
	end
	while self.position[1] > 0 do
		self:forward()
	end
	while self.heading[2] ~= -1 do
		self:turnLeft()
	end
	while self.position[2] > 0 do
		self:forward()
	end

	-- Park for end of program
	while self.heading[2] ~= 1 do
		self:turnRight()
	end

end

function TurtleControl:goHome()
	self:goToStart()
	-- Go pack to starting height
	while self.position[3] > 0 do
		self:down()
	end
	while self.position[3] < 0 do
		self:up()
	end
end

function TurtleControl:goToPositionHeading(pos,heading)
	while self.position[3] < pos[3] do
		self:up()
	end
	while self.position[3] > pos[3] do
		self:down()
	end

	if self.position[1] > pos[1] then
		while self.heading[1] ~= -1 do
			self:turnLeft()
		end
		while self.position[1] > pos[1] do
			self:forward()
		end
	else
		while self.heading[1] ~= 1 do
			self:turnLeft()
		end
		while self.position[1] < pos[1] do
			self:forward()
		end
	end

	if self.position[2] > pos[2] then
		while self.heading[2] ~= -1 do
			self:turnLeft()
		end
		while self.position[2] > pos[2] do
			self:forward()
		end
	else
		while self.heading[2] ~= 1 do
			self:turnLeft()
		end
		while self.position[2] < pos[2] do
			self:forward()
		end
	end

	while self.heading[1] ~= heading[1] do
		self:turnLeft()
	end
end