local minifylib = require("minify")

local open = io.open
local function read_file(path)
    local file = assert(open(path, "rb")) -- r read mode and b binary mode
    if not file then return nil end
    local content = file:read "*a" -- *a or *all reads the whole file
    file:close()
    return content
end

local function write_file(path,content)
    file = assert(io.open(path,"w"))
    file:write(content)
    file:close()
end

local function handle_quine_blob(code,subcode)
    local sub = subcode
    sub = sub:gsub("\\","\\\\")
    sub = sub:gsub("\n","\\n")
    sub = sub:gsub("\"","\\\"")
    return code:gsub("%?", function() return sub end)
end

local function minify(code)
    local ast = CreateLuaParser(code)
    local global_scope, root_scope = AddVariableInfo(ast)
    MinifyVariables(global_scope, root_scope)
	StripAst(ast)
	local tmpfilename = "minifytmp.lua"
	local tmpfile = io.open(tmpfilename, "w")
	io.output(tmpfile)
	PrintAst(ast)
	io.output(io.stdout)
	tmpfile:close()
	local newcode = read_file(tmpfilename)
	os.remove(tmpfilename)
	return newcode
end

local function make_font_string(path)
    print("Making font string from "..path)
    local fns = ""
    for line in io.lines(path) do
        if #line~=0 then
            local bin = line:gsub("%.","0"):gsub("@","1")
            local ch = string.format('%x',tonumber(bin,2))
            fns=fns..ch
        end
    end
    return fns
end

local function make_quine(input_file,output_file)
    print("Generating "..input_file.." -> "..output_file)
    local code = read_file(input_file)
    code = minify(code)
    code = handle_quine_blob(code,code)
    write_file(output_file,code)
end

local function make_clock(input_file,output_file,font)
    print("Generating "..input_file.." -> "..output_file)
    local code = read_file(input_file)
    code = code:gsub("!FNT",font)
    code = minify(code)
    write_file(output_file,code)
end

local function make_qlock(input_file,output_file,font)
    print("Generating "..input_file.." -> "..output_file)
    local code = read_file(input_file)
    code = minify(code)
    code = handle_quine_blob(code:gsub("!FNT",font),code:gsub("!FNT","!"))
    write_file(output_file,code)
end

local font = make_font_string("font.txt")
make_quine("src/quine.lua","build/quine.lua")
make_clock("src/clock.lua","build/clock.lua",font)
make_qlock("src/qlock.lua","build/qlock.lua",font)
