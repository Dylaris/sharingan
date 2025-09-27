local Button = {}
Button.__index = Button

function Button.new(img, hover_img, x, y, rotation, action)
    local obj = {}
    setmetatable(obj, Button)
    obj.img = img
    obj.hover_img = hover_img
    obj.x = x
    obj.y = y
    obj.rotation = rotation
    obj.width = img:getWidth()
    obj.height = img:getHeight()
    obj.scale = 2
    obj.action = action
    return obj
end

local function inside_circle(x, y, circle)
    local distance = math.sqrt((x-circle.x)^2+(y-circle.y)^2)
    return distance <= circle.radius
end

local function inside_rectangle(x, y, rectangle)
    return x >= rectangle.x and x <= rectangle.x+rectangle.width and
           y >= rectangle.y and y <= rectangle.y+rectangle.height
end

function Button:onhover(iscircle)
    local mousex, mousey = love.mouse.getPosition()
    if iscircle then
        if inside_circle(mousex, mousey,
            {x = self.x, y = self.y, radius = self.width/2*self.scale}) then
            return true
        end
    else
        if inside_rectangle(mousex, mousey,
            {x = self.x, y = self.y, width = self.width*self.scale, height = self.height*self.scale}) then
            return true
        end
    end
    return false
end

function Button:draw()
    local centerx = self.width/2
    local centery = self.height/2
    -- (x, y) is the original point after rotation
    if self:onhover(true) then
        love.graphics.draw(self.hover_img, self.x, self.y,
            math.rad(self.rotation), self.scale, self.scale, centerx, centery)
    else
        love.graphics.draw(self.img, self.x, self.y,
            math.rad(self.rotation), self.scale, self.scale, centerx, centery)
    end
end

function Button:onclick()
    if self:onhover(true) then
        self.action()
    end
end

return Button
