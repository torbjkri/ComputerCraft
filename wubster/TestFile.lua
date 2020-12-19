Test = {position = {1,0,0}
				, heading = {0,1}}

-- Class constructor

function Test:new (o)
	o = o or {}
	setmetatable(o, self)
    self.__index = self
	return o
end

function Test:printValue(index)
    print(self.position[index])
end

myTest = Test:new(nil)

myTest.printValue(1)