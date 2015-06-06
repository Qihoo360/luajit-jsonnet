local jso = require "jsonnet"
jsonnet = jso:new()
jsonnet:make()
res,err = jsonnet:evaluate_file("t.jsonnet")
jsonnet:destroy()
print(res)
print(err)