-- Quarry miner

os.loadAPI("TurtleControlOOP")

Quarry = TurtleControl:new(nil)

function Quarry:new(o)
	o = o or TurtleControl:new(o)
	setmetatable(o,self)
	self._index = self
	return o
end

function Quarry:digColumn(length)
	for int i= 1,length do
		if turtle.detectUp() then
			turtle.digUp()
		end
		if turtle.detectDown() then
			turtle.digDown()
		end
		if turtle.detect() then
			turtle.dig()
		end
		self.forward()
		if turtle.detectUp() then
			turtle.digUp()
		end
		if turtle.detectDown() then
			turtle.digDown()
		end
	end
end

function Quarry:goToNextColumn()
	if self.heading[2] == -1 then
		self.turnLeft()
		self.digColumn(1)
		self.turnLeft()
	else
		self.turnRight()
		self.digColumn(1)
		self.turnRight()
	end
end

function Quarry:digSquare(squareSize)
	for i = 1,squareSize do
		self.digColumn(squareSize-1)
		self.goToNextColumn()
	end
end

