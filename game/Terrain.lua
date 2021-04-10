local Class = require("game.Class")

local M = Class.new()

function M:init(engine, config)
  self.engine = assert(engine)

  local x, y = unpack(config.position or {0, 0})
  self.body = love.physics.newBody(self.engine.world, x, y)

  local points = {-10, 0, 10, 0}
  local shape = love.physics.newChainShape(false, points)

  self.fixture = love.physics.newFixture(self.body, shape)
end

return M
