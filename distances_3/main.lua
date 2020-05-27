--Author :
--+-+-+-+-+-+-+-+-+-+
--|I|A|m|T|e|r|r|o|r|
--+-+-+-+-+-+-+-+-+-+

-- Inspired by : www.gamecodeur.fr --- https://www.gamecodeur.fr/liste-ateliers/atelier-geometrie-analytique/

-- Purpose : 

-- CONFIG --------------------------------------------------------------------------------------------------------------

-- This line is used to display traces in the console during the execution
io.stdout:setvbuf('no')

-- This line is used to debug step by step in ZeroBrane Studio
if arg[#arg] == "-debug" then require("mobdebug").start() end

-- Prevents photoshop from filtering outlines of images when they are resized
-- Pixel art effect
love.graphics.setDefaultFilter("nearest")


-- VARIABLES ----------------------------------------------------------------------------------------------------------

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

-- Manhattan distance
function distance(xA, yA, xB, yB)
  return math.abs(xB - xA) + math.abs(yB - yA)
end

function draw(sprite)
  love.graphics.setColor(sprite.color)
  for i = sprite.x - sprite.radius, sprite.x + sprite.radius do
    for j = sprite.y - sprite.radius, sprite.y + sprite.radius do
      if distance(sprite.x, sprite.y, i, j) <= sprite.radius then
        love.graphics.line(sprite.x, sprite.y, i, j)
      end
    end
  end
end


-- LÖVE ---------------------------------------------------------------------------------------------------------------

function love.load()
  love.window.setMode(800, 600)
  love.window.setTitle("distances_3")
  WIDTH = love.graphics.getWidth()
  HEIGHT = love.graphics.getHeight()
end

function love.update(dt)
  hero.x = love.mouse.getX()
  hero.y = love.mouse.getY()
  
  if distance(hero.x, hero.y, ball.x, ball.y) < ball.radius + hero.radius then
    ball.color = ball.color1
  else
    ball.color = ball.color2
  end
end

function love.draw()
  draw(ball)
  draw(hero)
end


-- CONTROLS -----------------------------------------------------------------------------------------------------------

function love.keypressed(key)
  print(key)
end