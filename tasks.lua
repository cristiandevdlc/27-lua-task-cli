local file = "tasks.db"
local function load() local list = {}; local f = io.open(file, "r"); if f then for line in f:lines() do local id, done, text = line:match("^(%d)|(%d)|(.*)$"); if id then table.insert(list, {id=tonumber(id), done=done == "1", text=text}) end end; f:close() end; return list end
local function save(list) local f = assert(io.open(file, "w")); for _, task in ipairs(list) do f:write(task.id, "|", task.done and "1" or "0", "|", task.text, "\n") end; f:close() end
local tasks, command = load(), arg[1]
if command == "add" then local text = table.concat(arg, " ", 2); local max = 0; for _, task in ipairs(tasks) do max = math.max(max, task.id) end; table.insert(tasks, {id=max+1, done=false, text=text}); save(tasks); print("Tarea guardada")
elseif command == "done" then for _, task in ipairs(tasks) do if task.id == tonumber(arg[2]) then task.done = true end end; save(tasks)
elseif command == "list" then for _, task in ipairs(tasks) do print(string.format("[%s] %d %s", task.done and "x" or " ", task.id, task.text)) end
else print("Uso: add texto | list | done ID") end
