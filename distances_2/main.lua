--Author :
--+-+-+-+-+-+-+-+-+-+
--|I|A|m|T|e|r|r|o|r|
--+-+-+-+-+-+-+-+-+-+

-- Inspired by : www.gamecodeur.fr --- https://www.gamecodeur.fr/liste-ateliers/atelier-geometrie-analytique/

-- Purpose : This program calculates the Euclidean distance between two objects, in this case a moving hero (with the mouse) and a fixed object (a circle). If it is equal to zero, the collision is detected (the circle changes color).


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
ball.currentColor = ball.color1

hero = {}
hero.x = nil
hero.y = nil
hero.radius = 50
hero.color = {1, 1, 1}


-- FUNCTIONS ----------------------------------------------------------------------------------------------------------

-- Euclidean distance
function distance(xA, yA, xB, yB)
  return math.sqrt((xB - xA)^2 + (yB - yA)^2)
end

function ball.draw()
  love.graphics.setColor(ball.currentColor)
  love.graphics.circle("fill", ball.x, ball.y, ball.radius)
end

function hero.draw()
  love.graphics.setColor(hero.color)
  love.graphics.circle("fill", hero.x, hero.y, hero.radius)
end


-- LÖVE ---------------------------------------------------------------------------------------------------------------

function love.load()
  love.window.setMode(800, 600)
  love.window.setTitle("distances_2")
  WIDTH = love.graphics.getWidth()
  HEIGHT = love.graphics.getHeight()
end

function love.update(dt)
  hero.x = love.mouse.getX()
  hero.y = love.mouse.getY()
  
  if distance(hero.x, hero.y, ball.x, ball.y) < ball.radius + hero.radius then
    ball.currentColor = ball.color1
  else
    ball.currentColor = ball.color2
  end
end

function love.draw()
  ball.draw()
  hero.draw()
end


-- CONTROLS -----------------------------------------------------------------------------------------------------------

function love.keypressed(key)
  print(key)
end