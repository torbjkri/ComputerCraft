Turtle = {fuel = 100}

function Turtle:new (o)
	o = o or {}
	setmetatable(o, self)
	self.__index = self
	return o
end

function Turtle:forward()
    self.fuel = self.fuel - 1
    return true
end

function Turtle:back()
    self.fuel = self.fuel - 1
    return true
end

function Turtle:up()
    self.fuel = self.fuel - 1
    return true
end

function Turtle:down()
    self.fuel = self.fuel - 1
    return true
end

function Turtle:turnLeft()
    return true
end

function Turtle:turnRight()
    return true
end

function Turtle:getItemCount(slotNum)
    return 0
end

function Turtle:dig()
    return true
end

function Turtle:digUp()
    return true
end

function Turtle:digDown()
    return true
end

function Turtle:detect()
    return true
end

function Turtle:detectUp()
    return true
end

function Turtle:detectDown()
    return true
end

function Turtle:getFuelLevel()
    return self.fuel
end

function Turtle:refuel(value)
    self.fuel = value
    return true
end

function Turtle:refuel()
    self.fuel = 3000
    return true
end

function Turtle:inspectUp()
    return {name = "minefract:coal"}
end

function Turtle:inspectDown()
    return {name = "minefract:coal"}
end

function Turtle:inspect()
    return {name = "minefract:coal"}
end


turtle = Turtle:new(nil)