-- Quarry miner

-- os.loadAPI("TurtleControlOOP")

-- turtle = require "TurtleMock"
require "TurtleControl"

Quarry = TurtleControl:new()

local uselessStuff = {"air",
					  "stone",
					  "grass",
					  "dirt",
					  "cobblestone",
					  "bedrocks",
					  "sand",
					  "gravel",
					  }

local function getNickName(name)
	return string.sub(name.name, string.find(name.name,":")+1)
end

local function isUseless(name)
	local nick = getNickName(name)
	for i = 1,#uselessStuff do
		if nick == uselessStuff[i] then
			return true
		end
	end
	return false
end

function Quarry:new(o)
	o = o or TurtleControl:new(o)
	setmetatable(o,self)
	self.__index = self
	return o
end

function Quarry:isUpUseless()
	local success, data = turtle.inspectUp()
	if success == true then
		return isUseless(data)
	end
	return true
end

function Quarry:isDownUseless()
	local success, data = turtle.inspectDown()
	if success == true then
		return isUseless(data)
	end
	return true
end



function Quarry:goToNextColumn()
	if self.heading[2] == -1 then
		self:turnLeft()
		self:digColumn(1)
		self:turnLeft()
	else
		self:turnRight()
		self:digColumn(1)
		self:turnRight()
	end
end



function Quarry:nextLayer()
	self:up()
	self:up()
	self:up()
end



function Quarry:isInventoryFull()
	for i = 1,16 do
		if turtle.getItemCount(i) == 0 then
			return false
		end
	end
	return true
end

function Quarry:dropUseless()
	for i =1,16 do
		local data = turtle.getItemDetail(i)
		if data ~= nil then
			turtle.select(i)
			if isUseless(data) then
				turtle.dropDown()
			end
		end
	end
end

function Quarry:dropAll()
	for i = 1,16 do
		local data = turtle.getItemDetail(i)
		if data ~= nil then
			turtle.select(i)
			turtle.dropDown()
		end
	end
end

function Quarry:needsDropOff()
	if self:isInventoryFull() then
		self:dropUseless()
	else
		return false
	end
	return self:isInventoryFull()
end

function Quarry:isEnoughFuel(sizeOfQuarry)
	local distanceNextLevel = 2* sizeOfQuarry + sizeOfQuarry*sizeOfQuarry
	if turtle.getFuelLevel() < distanceNextLevel then
		return false
	end
	return true
end

function Quarry:dropOff()
	local oldPos = self.position
	local oldHeading = self.heading
	self:goHome()
	while self.heading[2] ~= -1 do
		self:turnLeft()
	end
	self:dropAll()
	print("Dropped all items")
	if self:isEnoughFuel() then
		self:goToPositionHeading(oldPos, oldHeading)
	end
end

function Quarry:digColumn(length)
	for i = 1,length do
		if turtle.detectUp() then
			if self:isUpUseless() == false then
				turtle.digUp()
			end
		end
		if turtle.detectDown() then
			if self:isDownUseless() == false then
				turtle.digDown()
			end
		end
		if turtle.detect() then
			turtle.dig()
		end
		self:forward()
		if turtle.detectUp() then
			if self:isUpUseless() == false then
				turtle.digUp()
			end
		end
		if turtle.detectDown() then
			if self:isDownUseless() == false then
				turtle.digDown()
			end
		end
	end
end

function Quarry:digSquare(squareSize)
	for i = 1,squareSize do
		if self:needsDropOff() == true then
			self:dropOff()
			if self:isInventoryFull() == true then
				print("Returning home due to full inventory\n")
				self:goHome()
				return
			end
		end
		self:digColumn(squareSize-1)
		if i < squareSize then
			self:goToNextColumn()
		end
	end
end

function Quarry:digLayers(numLayers, layerSize)
	if turtle.getFuelLevel() < numLayers*(3 + layerSize*layerSize) then
		turtle.refuel()
	end

	for i = 1,numLayers do
		if self:needsDropOff() == true then
			self:dropOff()
			if self:isInventoryFull() == true then
				print("Returning home due to full inventory\n")
				self:goHome()
				return
			end
		end
		if self:isEnoughFuel(layerSize) == false then
			print("Returning home due to insuffiction fuel\n")
			self:goHome()
			return
		end

		self:digSquare(layerSize)
		self:goToStart()
		if i < numLayers then
			self:nextLayer()
		end
	end
	self:goHome()
	print("Program completed successfully\n")
end


local function main()
	local myQuarry = Quarry:new(nil)
	myQuarry:digLayers(10,16)
end

main()