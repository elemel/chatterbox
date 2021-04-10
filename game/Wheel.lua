local Class = require("game.Class")

local M = Class.new()

function M:init(engine, config)
  self.engine = assert(engine)

  local x, y = unpack(config.position or {0, 0})
  self.body = love.physics.newBody(self.engine.world, x, y, "dynamic")

  local radius = config.radius or 0.5
  local shape = love.physics.newCircleShape(radius)

  local density = config.density or 1
  self.fixture = love.physics.newFixture(self.body, shape, density)

  self.springFrequency = config.springFrequency or 2
  self.springDampingRatio = config.springDampingRatio or 0.7
end

function M:setParent(parent)
  if self.joint then
    self.joint:destroy()
    self.joint = nil
  end

  self.parent = parent

  if self.parent then
    local x, y = self.body:getPosition()
    local axisX, axisY = self.parent.body:getWorldVector(0, -1)
    self.joint = love.physics.newWheelJoint(self.parent.body, self.body, x, y, axisX, axisY)
    self.joint:setSpringFrequency(self.springFrequency)
    self.joint:setSpringDampingRatio(self.springDampingRatio)
  end
end

return M
