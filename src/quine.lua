local blob="?"
local code=""

-- make code string
for i = 1, #blob do
    ch=blob:sub(i,i)
    if ch==string.char(63) then
        -- add blob string
        local sub = blob
        sub = sub:gsub("\\","\\\\")
        sub = sub:gsub("\n","\\n")
        sub = sub:gsub("\"","\\\"")
        code=code..sub
    else
        code=code..ch
    end
end

print(code)
