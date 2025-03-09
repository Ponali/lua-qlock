local code=string.rep("/",743);

local floor = math.floor
local width = 80;
local font = "!FNT"

local CSI = string.char(27,91)

local clock = os.clock
local function sleep(seconds)
    local t0 = clock()
    while clock() - t0 <= seconds do end
end

local function shiftbits(value,shift)
    return floor(value / 2 ^ shift)
end

local time = ""
local digitcount = 8
local function digit(i)
    local d = time:sub(i,i)
    if d==":" then
        return 10
    end
    return tonumber(d)
end

local function color(x,y)
    x=floor((x-1)/2)
    y=y-2
    local dx = floor(x/5)
    if dx<0 or dx>=digitcount or y>=6 or y<0 then
        return 0
    end
    local dig = digit(dx+1)
    local vx = x%5
    local vy = y+1+dig*6
    return (shiftbits(tonumber(font:sub(vy,vy),16),3-vx)%2)*255
end

local write = io.write

local function render()
    time = os.date("%H:%M:%S")
    for i = 1, #code do
        local x = (i-1)%width
        local y = floor((i-1)/width)
        if x==0 and i>1 then
            write("\n")
        end
        write(CSI.."48;5;"..color(x,y).."m"..code:sub(i,i)..CSI.."0m")
    end
    write("\n")
end

while true do
    render()
    sleep(0.1)
    write("\r"..CSI..math.ceil(#code/width).."A")
end
