local blob="local blob=\"?\"\nlocal code=\"\"\n\n-- make code string\nfor i = 1, #blob do\n    ch=blob:sub(i,i)\n    if ch==\"\\63\" then\n        -- add blob string\n        local sub = blob\n        sub = sub:gsub(\"\\\\\",\"\\\\\\\\\")\n        sub = sub:gsub(\"\\n\",\"\\\\n\")\n        sub = sub:gsub(\"\\\"\",\"\\\\\\\"\")\n        code=code..sub\n    else\n        code=code..ch\n    end\nend\n\nprint(code)\n"
local code=""

-- make code string
for i = 1, #blob do
    ch=blob:sub(i,i)
    if ch=="\63" then
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

