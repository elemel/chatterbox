local Class = require("game.Class")

local M = Class.new()

function M:init(engine, config)
  self.engine = assert(engine)

  local x, y = unpack(config.position or {0, 0})
  self.body = love.physics.newBody(self.engine.world, x, y, "dynamic")

  local width, height = unpack(config.dimensions or {1, 1})
  local shape = love.physics.newRectangleShape(width, height)

  local density = config.density or 1
  self.fixture = love.physics.newFixture(self.body, shape, density)
end

return M
