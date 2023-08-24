-- local function split(inputstr, sep)
--     sep=sep or '%s'
--     local t={}
--     for field,s in string.gmatch(inputstr, "([^"..sep.."]*)("..sep.."?)") do
--         table.insert(t,field)
--         if s=="" then
--             return t
--         end
--     end
-- end

local function split(string_to_split, separator)
    if separator == nil then separator = "%s" end
    local t = {}

    for str in string.gmatch(string_to_split, "([^".. separator .."]+)") do
        table.insert(t, str)
    end

    return t
end

local function trim(inputstr, str)
    str = str or "%s"

    return inputstr:gsub("^("..str.."+)", ""):gsub("("..str.."+)$", "")
end

return {
    split = split,
    trim = trim,
}
