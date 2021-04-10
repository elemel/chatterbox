local GameScreen = require("game.GameScreen")

function love.load()
  love.physics.setMeter(1)
  screen = GameScreen.new()
end

function love.draw()
  screen:draw()
end

function love.resize(w, h)
  screen:resize(w, h)
end

function love.update(dt)
  screen:update(dt)
end
