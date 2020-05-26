--Author :
--+-+-+-+-+-+-+-+-+-+
--|I|A|m|T|e|r|r|o|r|
--+-+-+-+-+-+-+-+-+-+

-- Inspired by : www.gamecodeur.fr --- https://www.gamecodeur.fr/liste-ateliers/atelier-geometrie-analytique/

-- Purpose : this program illustrates the notion of distance in mathematics using spheres whose distance is calculated dynamically.


-- CONFIG --------------------------------------------------------------------------------------------------------------

-- This line is used to display traces in the console during the execution
io.stdout:setvbuf('no')

-- This line is used to debug step by step in ZeroBrane Studio
if arg[#arg] == "-debug" then require("mobdebug").start() end

-- Prevents photoshop from filtering outlines of images when they are resized
-- Pixel art effect
love.graphics.setDefaultFilter("nearest")


-- VARIABLES ----------------------------------------------------------------------------------------------------------

fixedBall = {}
fixedBall.x = 400
fixedBall.y = 300
fixedBall.radius = 30
fixedBall.color = {1,0,0.5}

movingBall = {}
movingBall.x = nil
movingBall.y = nil
movingBall.radius = 30
movingBall.color = {1,1,1}

middleBall = {}
middleBall.x = nil
middleBall.y = nil
middleBall.radius = 20
middleBall.color = {0,1,1}

quarterBall = {}
quarterBall.x = nil
quarterBall.y = nil
quarterBall.radius = 10
quarterBall.color = {0.5,0.95,0.75}


-- FUNCTIONS ----------------------------------------------------------------------------------------------------------

function middle(xA, yA, xB, yB)
  local xI = (xA + xB) / 2
  local yI = (yA + yB) / 2
  return xI, yI
end


-- LÖVE ---------------------------------------------------------------------------------------------------------------

function love.load()
  love.window.setMode(800,600)
  love.window.setTitle("distances_1")
  WIDTH = love.graphics.getWidth()
  HEIGHT = love.graphics.getHeight()
end

function love.update(dt)
  movingBall.x, movingBall.y = love.mouse.getPosition()
  middleBall.x, middleBall.y = middle(fixedBall.x, fixedBall.y, movingBall.x, movingBall.y)
  quarterBall.x, quarterBall.y = middle(fixedBall.x, fixedBall.y, middleBall.x, middleBall.y)
end

function love.draw()
  
  love.graphics.setColor(1,1,1)
  love.graphics.print("Ratio middleBall / movingBall (expected : 0.5) : "..(middleBall.x - fixedBall.x) / (movingBall.x - fixedBall.x), 10, 10)
  love.graphics.print("Ratio quarterBall / middleBall (expected : 0.5) : "..(middleBall.x - fixedBall.x) / (movingBall.x - fixedBall.x), 10, 30)
  love.graphics.print("Ratio quarterBall / movingBall (expected : 0.25) : "..(quarterBall.x - fixedBall.x) / (movingBall.x - fixedBall.x), 10, 50)

  
  love.graphics.setColor(fixedBall.color)
  love.graphics.circle("fill", fixedBall.x, fixedBall.y, fixedBall.radius)
  
  love.graphics.setColor(movingBall.color)
  love.graphics.circle("fill", movingBall.x, movingBall.y, movingBall.radius)
  
  love.graphics.setColor(middleBall.color)
  love.graphics.circle("fill", middleBall.x, middleBall.y, middleBall.radius)
  
  love.graphics.setColor(quarterBall.color)
  love.graphics.circle("fill", quarterBall.x, quarterBall.y, quarterBall.radius)
  
end


-- CONTROLS -----------------------------------------------------------------------------------------------------------

function love.keypressed(key)
  print(key)
end