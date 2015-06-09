local jso = require "jsonnet"
jsonnet = jso:new()
jsonnet:make()
if arg[1] ~= nil then
	filename = arg[1]
else
	filename = "t.jsonnet"
end
res,err = jsonnet:evaluate_file(filename)
jsonnet:destroy()
if err == nil then
	print(res)
else
	print(err)
end 