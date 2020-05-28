--Author :
--+-+-+-+-+-+-+-+-+-+
--|I|A|m|T|e|r|r|o|r|
--+-+-+-+-+-+-+-+-+-+

-- Inspired by : www.gamecodeur.fr --- https://www.gamecodeur.fr/liste-ateliers/atelier-geometrie-analytique/

-- Purpose : This program calculates the "infinite distance" between two objects, in this case a moving hero (with the mouse) and a fixed object. If it is equal to zero, the collision is detected (the fixed object changes color). Integration of the following specifics distance cases : Manhattan distance (distance K with k = 1), euclidean distance (distance K with k = 2), distance K (with k > 2)


-- CONFIG --------------------------------------------------------------------------------------------------------------

-- This line is used to display traces in the console during the execution
io.stdout:setvbuf('no')

-- This line is used to debug step by step in ZeroBrane Studio
if arg[#arg] == "-debug" then require("mobdebug").start() end

-- Prevents photoshop from filtering outlines of images when they are resized
-- Pixel art effect
love.graphics.setDefaultFilter("nearest")


-- VARIABLES ----------------------------------------------------------------------------------------------------------

k = 0

ball = {}
ball.x = 400
ball.y = 300
ball.radius = 40
ball.color1 = {1, 0, 0.4}
ball.color2 = {0, 1, 0.6}
ball.color = ball.color1

hero = {}
hero.x = nil
hero.y = nil
hero.radius = 50
hero.color = {1, 1, 1}


-- FUNCTIONS ----------------------------------------------------------------------------------------------------------

-- distance k
function distanceK(xA, yA, xB, yB, pk)
  return (math.abs(xB - xA)^pk + math.abs(yB - yA)^pk)^(1/pk)
end

-- infinite distance
function infiniteDistance(xA, yA, xB, yB)
  return math.max(math.max(xB - xA), math.max(yB - yA))
end

-- generalized distance function
-- pk = 0 : call infiniteDistance()
function distance(xA, yA, xB, yB, pk)
  if pk > 0 then
    return distanceK(xA, yA, xB, yB, pk)
  else
    return infiniteDistance(xA, yA, xB, yB)
  end  
end

function draw(sprite)
  love.graphics.setColor(sprite.color)
  for i = sprite.x - sprite.radius, sprite.x + sprite.radius do
    for j = sprite.y - sprite.radius, sprite.y + sprite.radius do
      if distance(sprite.x, sprite.y, i, j, k) <= sprite.radius then
        love.graphics.line(sprite.x, sprite.y, i, j)
      end
    end
  end
end


-- LÖVE ---------------------------------------------------------------------------------------------------------------

function love.load()
  love.window.setMode(800, 600)
  love.window.setTitle("distances_6")
  width = love.graphics.getWidth()
  height = love.graphics.getHeight()
end

function love.update(dt)
  hero.x = love.mouse.getX()
  hero.y = love.mouse.getY()
  
  if distance(hero.x, hero.y, ball.x, ball.y ,k) < ball.radius + hero.radius then
    ball.color = ball.color1
  else
    ball.color = ball.color2
  end
end

function love.draw()
  love.graphics.print("COEFFICIENTS : ", 10, 10)
  if k == 0 then
    love.graphics.print("k = "..k.." (infinite distance --- square sprites)", 10, 30)
  elseif k == 1 then
    love.graphics.print("k = "..k.." (Manhattan distance --- diamond sprites)", 10, 30)
  elseif k == 2 then
    love.graphics.print("k = "..k.." (euclidean distance --- circle sprites)", 10, 30)
  else
    love.graphics.print("k = "..k.." (distance K)", 10, 30)
  end
  
  love.graphics.print("CONTROLS : ", 10, height - 60)
  love.graphics.print("UP key : increase the value of k", 10, height - 40)
  love.graphics.print("DOWN key : decrease the value of k", 10, height - 20)
  
  draw(ball)
  draw(hero)
end


-- CONTROLS -----------------------------------------------------------------------------------------------------------

function love.keypressed(key)
  if key == "up" then
    k = k + 1
  end
  if key == "down" and k > 0 then
    k = k - 1
  end
end