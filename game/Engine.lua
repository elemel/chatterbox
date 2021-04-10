local Class = require("game.Class")
local physics = require("game.physics")

local M = Class.new()

function M:init()
  self.world = love.physics.newWorld()
  self.body = love.physics.newBody(self.world)
  local shape = love.physics.newCircleShape(0.5)
  self.fixture = love.physics.newFixture(self.body, shape)
end

function M:draw()
  local width, height = love.graphics.getDimensions()
  love.graphics.translate(0.5 * width, 0.5 * height)
  local scale = 0.5 * height
  love.graphics.scale(scale)
  love.graphics.setLineWidth(1 / scale)
  physics.debugDrawFixtures(self.world)
end

function M:resize(w, h)
end

function M:update(dt)
end

return M
