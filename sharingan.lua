local Sharingan = {}
Sharingan.__index = Sharingan

function Sharingan.new(img)
    local obj = {}
    setmetatable(obj, Sharingan)
    obj.img = img
    obj.rotation = 0
    obj.width = img:getWidth()
    obj.height = img:getHeight()
    obj.rotate_speed = 1
    return obj
end

function Sharingan:update(dt)
    self.time = (self.time or 0) + dt

    local speed_factor = math.sin(self.time * 0.5)
    local min_speed = 1
    local max_speed = 3

    self.rotate_speed = min_speed + (max_speed-min_speed)*((speed_factor+1)/2)

    self.rotation = self.rotation + self.rotate_speed*dt
    if self.rotation > 2 * math.pi then
        self.rotation = self.rotation - 2 * math.pi
    end
end

function Sharingan:draw()
    love.graphics.push()
    love.graphics.translate(love.graphics.getWidth()/2, love.graphics.getHeight()/2-40)
    -- love.graphics.scale(1, 1)

    love.graphics.rotate(self.rotation)
    love.graphics.draw(self.img, -self.width/2, -self.height/2)
    love.graphics.pop()
end

return Sharingan