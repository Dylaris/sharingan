local Button = require("button")
local Sharingan = require("sharingan")

local btn_img = love.graphics.newImage("assets/button.png")
local btn_hover_img = love.graphics.newImage("assets/button_hover.png")
local sharingans = {
    Sharingan.new(love.graphics.newImage("assets/sharingan/1.png")),
    Sharingan.new(love.graphics.newImage("assets/sharingan/2.png")),
    Sharingan.new(love.graphics.newImage("assets/sharingan/3.png")),
    Sharingan.new(love.graphics.newImage("assets/sharingan/4.png"))
}
local current_index = 1

local function next_sharingan()
    current_index = current_index + 1
    if current_index > #sharingans then current_index = 1 end
end

local function prev_sharingan()
    current_index = current_index - 1
    if current_index < 1 then current_index = #sharingans end
end

local next_button = Button.new(
    btn_img, btn_hover_img,
    love.graphics.getWidth()/2 + btn_img:getWidth()/2 + 40,
    love.graphics.getHeight() - btn_img:getHeight() - 20,
    0,
    next_sharingan
)

local prev_button = Button.new(
    btn_img, btn_hover_img,
    love.graphics.getWidth()/2 - btn_img:getWidth()/2 - 40,
    love.graphics.getHeight() - btn_img:getHeight() - 20,
    180,
    prev_sharingan
)

function love.load()
    love.graphics.setBackgroundColor({0, 0, 0})
end

function love.mousepressed()
    next_button:onclick()
    prev_button:onclick()
end

function love.keypressed(key)
end

function love.update(dt)
    local current_sharingan = sharingans[current_index]
    current_sharingan:update(dt)
end

function love.draw()
    love.graphics.setColor(1, 1, 1)
    local current_sharingan = sharingans[current_index]
    current_sharingan:draw()

    love.graphics.setColor(1, 1, 1, 0.7)
    love.graphics.rectangle(
        "fill",
        0, love.graphics.getHeight() - 85,
        love.graphics.getWidth(), 85
    )

    love.graphics.setColor(1, 1, 1)
    next_button:draw()
    prev_button:draw()
end
