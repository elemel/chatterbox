local M = {}

function M.debugDrawFixtures(world)
  for _, body in ipairs(world:getBodies()) do
    local angle = body:getAngle()

    for _, fixture in ipairs(body:getFixtures()) do
      local shape = fixture:getShape()
      local shapeType = shape:getType()

      if shapeType == "chain" then
        love.graphics.line(body:getWorldPoints(shape:getPoints()))

        if shape:getPreviousVertex() then
          local previousX, previousY = body:getWorldPoint(
            shape:getPreviousVertex())

          local firstX, firstY = body:getWorldPoint(shape:getPoint(1))
          love.graphics.line(previousX, previousY, firstX, firstY)
        end

        if shape:getNextVertex() then
          local lastX, lastY = body:getWorldPoint(
            shape:getPoint(shape:getVertexCount()))

          local nextX, nextY = body:getWorldPoint(shape:getNextVertex())
          love.graphics.line(lastX, lastY, nextX, nextY)
        end
      elseif shapeType == "circle" then
        local x, y = body:getWorldPoint(shape:getPoint())
        local radius = shape:getRadius()
        love.graphics.circle("line", x, y, radius)
        local directionX, directionY = body:getWorldVector(1, 0)

        love.graphics.line(
          x, y, x + directionX * radius, y + directionY * radius)
      elseif shapeType == "edge" then
        local x1, y1, x2, y2 = shape:getPoints()
        love.graphics.line(body:getWorldPoints(x1, y1, x2, y2))
      elseif shapeType == "polygon" then
        love.graphics.polygon("line", body:getWorldPoints(shape:getPoints()))
      end
    end
  end
end

function M.debugDrawJoints(world, radius)
  if not radius then
    radius = love.graphics.getLineWidth() * 4
  end

  for _, joint in ipairs(world:getJoints()) do
    local x1, y1, x2, y2 = joint:getAnchors()
    love.graphics.line(x1, y1, x2, y2)

    love.graphics.circle("fill", x1, y1, radius)
    love.graphics.circle("fill", x2, y2, radius)
  end
end

function M.debugDrawContacts(world, radius)
  if not radius then
    radius = love.graphics.getLineWidth() * 4
  end

  for _, contact in ipairs(world:getContacts()) do
    local x1, y1, x2, y2 = contact:getPositions()

    if x1 then
      if x2 then
        love.graphics.line(x1, y1, x2, y2)

        love.graphics.circle("fill", x1, y1, radius)
        love.graphics.circle("fill", x2, y2, radius)
      else
        love.graphics.circle("fill", x1, y1, radius)
      end
    end
  end
end

return M
