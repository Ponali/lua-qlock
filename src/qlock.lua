-- quine

font = "!FNT"
blob="?"
code=""

-- make code string
fontreplace = true
for i = 1, #blob do
    ch=blob:sub(i,i)
    if ch=="!" and fontreplace then
        code=code..font
        fontreplace = false
    elseif ch==string.char(63) then
        -- add blob string
        code=code..blob:gsub("\\","\\\\"):gsub("\n","\\n"):gsub("\"","\\\"")
    else
        code=code..ch
    end
end

-- clock

floor = math.floor
width = 80;
decimal = tonumber

CSI = string.char(27,91)

function color(x,y)
    x=floor(x/2-.5)
    dx = floor(x/5)+1
    if dx<1 or dx>8 or y>=8 or y<2 then
        return 0
    end
    d = time:sub(dx,dx)
    vy = y-1+(d==":" and 10 or decimal(d))*6
    return floor(decimal(font:sub(vy,vy),16)/2^(3-(x%5)))%2
end

write = io.write

function ANSI(code)
    write(CSI..decimal(code).."m")
end

function render()
    time = os.date("%H:%M:%S")
    for i = 1, #code do
        x = (i-1)%width
        y = floor((i-1)/width)
        if x==0 and i>1 then
            write("\n")
        end
        c = color(x,y)*7
        ANSI(40+c)
        ANSI(37-c)
        write(code:sub(i,i))
        ANSI(0)
    end
    ANSI(40)
    ANSI(90)
    write(string.rep("-",width-x-1).."\n")
end

while true do
    render()
    clock = os.clock
    t0 = clock()
    while clock() - t0 <= 1 do end
    write("\r"..CSI..math.ceil(#code/width).."A")
end
