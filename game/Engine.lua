local Class = require("game.Class")
local physics = require("game.physics")
local VehicleFrame = require("game.VehicleFrame")
local Terrain = require("game.Terrain")
local Wheel = require("game.Wheel")

local M = Class.new()

function M:init(config)
  local gravityX = config.gravityX or 0
  local gravityY = config.gravityY or 10

  self.fixedDt = config.fixedDt or 1 / 60
  self.accumulatedDt = 0

  self.world = love.physics.newWorld(gravityX, gravityY)
  self.terrain = Terrain.new(self, {})

  local vehicleFrame = VehicleFrame.new(self, {
    position = {0, -1},
    dimensions = {2, 1},
  })

  local rearWheel = Wheel.new(self, {
    position = {-1, -0.5},
    springFrequency = 10,
  })

  rearWheel:setParent(vehicleFrame)

  local frontWheel = Wheel.new(self, {
    position = {1, -0.5},
    springFrequency = 10,
  })

  frontWheel:setParent(vehicleFrame)
end

function M:fixedUpdate(dt)
  self.world:update(dt)
end

function M:draw()
  local width, height = love.graphics.getDimensions()
  love.graphics.translate(0.5 * width, 0.5 * height)
  local scale = 0.05 * height
  love.graphics.scale(scale)
  love.graphics.setLineWidth(1 / scale)
  physics.debugDrawFixtures(self.world)
end

function M:resize(w, h)
end

function M:update(dt)
  self.accumulatedDt = self.accumulatedDt + dt

  while self.accumulatedDt >= self.fixedDt do
    self.accumulatedDt = self.accumulatedDt - self.fixedDt
    self:fixedUpdate(self.fixedDt)
  end
end

return M
