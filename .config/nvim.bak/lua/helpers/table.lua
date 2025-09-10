local function copy_table(t)
  local newT = {}
  for k,v in pairs(t) do
    newT[k] = v
  end
  return newT
end

return {
  copy_table = copy_table
}
