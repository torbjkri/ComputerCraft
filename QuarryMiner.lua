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

function Quarry:nextLayer()
	self.up()
	self.up()
	self.up()
end

function Quarry:isInventoryFull()
	for i = 1,16 do
		if turtle.getItemCount(i) == 0 then
			return false
	end
	return true
end

function Quarry:isEnoughFuel(sizeOfQuarry)
	local distanceNextLevel = 2*(self.position[1] + self.position[2] + self.position[3]) + sizeOfQuarry
	if turtle.getFuelLevel() < distanceNextLevel then
		return false
	end
	return true
end

function Quarry:digLayers(numLayers, layerSize)
	for i = 1,numLayers
		if self.isInventoryFull() == true then
			print("Returning home due to full inventory\n")
			self.goHome()
			return
		end
		if self.isEnoughFuel(layerSize*layerSize) == false then
			print("Returning home due to insuffiction fuel\n")
			self.goHome()
			return
		end
		self.digSquare(layerSize)
		self.goToStart()
		if i < numLayers then
			self.nextLayer()
		end
	end
	self.goHome()
end


function main()
	myQuarry = Quarry:new(nil)
	myQuarry:digLayers(2,3)
end

main()

