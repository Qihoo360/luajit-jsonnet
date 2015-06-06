local jso = require "jsonnet"
jsonnet = jso:new()
jsonnet:make()
print("------- Normal test data --------")
local snippet = '{ person1: { name: "Alice", welcome: "Hello " + self.name + "!", }, person2: self.person1 { name: "Bob" },}'
res,err = jsonnet:evaluate_snippet(snippet)
if err == nil then
	print(res)
else
	print(err)
end

print("------- Abnormal test data --------")
local snippet = '!@##$@%$%^%&{ person1: { name: "Alice", welcome: "Hello " + self.name + "!", }, person2: self.person1 { name: "Bob" },}'
res,err = jsonnet:evaluate_snippet(snippet)
if err == nil then
	print(res)
else
	print(err)
end
jsonnet:destroy()