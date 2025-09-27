local Button = require("button")

-- Pastel rainbow for softer look
local pastel_rainbow = {
    {1.00, 0.70, 0.70},   -- Pastel Red
    {1.00, 0.85, 0.70},   -- Pastel Orange
    {1.00, 1.00, 0.70},   -- Pastel Yellow
    {0.70, 1.00, 0.70},   -- Pastel Green
    {0.70, 0.70, 1.00},   -- Pastel Blue
    {0.80, 0.70, 1.00},   -- Pastel Indigo
    {0.90, 0.70, 1.00}    -- Pastel Violet
}

local current_rainbow = pastel_rainbow
local current_index = math.random(1, #current_rainbow)
local btn_img = love.graphics.newImage("assets/button.png")
local btn_hover_img = love.graphics.newImage("assets/button_hover.png")

local function next_color()
    current_index = current_index + 1
    if current_index > #current_rainbow then current_index = 1 end
end

local function prev_color()
    current_index = current_index - 1
    if current_index < 1 then current_index = #current_rainbow end
end

local next_button = Button.new(
    btn_img, btn_hover_img,
    love.graphics.getWidth()/2 + btn_img:getWidth()/2 + 40,
    love.graphics.getHeight() - btn_img:getHeight() - 20,
    0,
    next_color
)

local prev_button = Button.new(
    btn_img, btn_hover_img,
    love.graphics.getWidth()/2 - btn_img:getWidth()/2 - 40,
    love.graphics.getHeight() - btn_img:getHeight() - 20,
    180,
    prev_color
)

function love.load()
    love.graphics.setBackgroundColor({1, 1, 1})
end

function love.mousepressed()
    next_button:onclick()
    prev_button:onclick()
end

function love.keypressed(key)
    if key == "left" then prev_color() end
    if key == "right" then next_color() end
end

function love.update()
end

function love.draw()
    love.graphics.setBackgroundColor(current_rainbow[current_index])
    next_button:draw()
    prev_button:draw()
end
