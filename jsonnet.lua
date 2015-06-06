local ffi = require "ffi"
local ffi_new = ffi.new
local ffi_str = ffi.string
local C = ffi.C
local setmetatable = setmetatable
local error = error
local libjsonnet = ffi.load(ffi.os == "Windows" and "libjsonnet" or "libjsonnet")
local _M = { _VERSION = '0.01' }
local mt = { __index = _M  }
ffi.cdef[[   
	const char *jsonnet_version(void); 
	typedef struct JsonnetVm {struct JsonnetVm *vm;char* out; const char *version;} JsonnetVm_t;
	struct JsonnetVm *jsonnet_make(void);
	void jsonnet_max_stack(struct JsonnetVm *vm, unsigned v);
	void jsonnet_gc_min_objects(struct JsonnetVm *vm, unsigned v);
	void jsonnet_gc_growth_trigger(struct JsonnetVm *vm, double v);
	void jsonnet_string_output(struct JsonnetVm *vm, int v);
	typedef char *JsonnetImportCallback(void *ctx, const char *base, const char *rel, int *success);
	char *jsonnet_realloc(struct JsonnetVm *vm, char *buf, size_t sz);
	void jsonnet_import_callback(struct JsonnetVm *vm, JsonnetImportCallback *cb, void *ctx);
	void jsonnet_ext_var(struct JsonnetVm *vm, const char *key, const char *val);
	void jsonnet_debug_ast(struct JsonnetVm *vm, int v);
	char *jsonnet_evaluate_file(struct JsonnetVm *vm,const char *filename,int *error);
	char *jsonnet_evaluate_snippet(struct JsonnetVm *vm,const char *filename,const char *snippet,int *error);
	char *jsonnet_evaluate_file_multi(struct JsonnetVm *vm, const char *filename,int *error);
	char *jsonnet_evaluate_snippet_multi(struct JsonnetVm *vm,const char *filename, const char *snippet,int *error);
	void jsonnet_destroy(struct JsonnetVm *vm);
]]
local int_ptr = ffi.typeof("int[1]")
local JsonnetVm = ffi.new("JsonnetVm_t") 
local _vm;
local _err_jsonnet_make_init = "jsonnet_make not initialized"
local function _return( err,res ,out )
	libjsonnet.jsonnet_realloc(_vm, out,0)
	if  tonumber(err[0]) == 1  then
		return nil,res
	else
		return res,nil
	end 
end

function _M.new(self)
    return setmetatable({ }, mt)
end

function _M.make(self)
	_vm = libjsonnet.jsonnet_make()  
end

function _M.version(self)
	JsonnetVm.version = libjsonnet.jsonnet_version();
	return ffi.string(JsonnetVm.version) 
end

function _M.evaluate_file( self , filename )
	local err = int_ptr()
	if _vm  == nil then
		return nil ,_err_jsonnet_make_init
	end
	JsonnetVm.out = libjsonnet.jsonnet_evaluate_file(_vm,filename,err)
	local res = ffi.string(JsonnetVm.out)
	err,res = _return(err,res,JsonnetVm.out)
	return err,res 
end

function _M.evaluate_snippet( self ,snippet  )
	local err = int_ptr()
	if _vm  == nil then
		return nil ,_err_jsonnet_make_init
	end
	JsonnetVm.out = libjsonnet.jsonnet_evaluate_snippet(_vm,"snippet",snippet,err)
	local res = ffi.string(JsonnetVm.out)
	err,res = _return(err,res,JsonnetVm.out)
	return err,res
end

function _M.evaluate_file_multi( self , filename )
	local err = int_ptr()
	if _vm  == nil then
		return nil ,_err_jsonnet_make_init
	end
	JsonnetVm.out = libjsonnet.jsonnet_evaluate_file_multi(_vm,filename,err)
	local res = ffi.string(JsonnetVm.out)
	err,res = _return(err,res,JsonnetVm.out)
	return err,res
end

function _M.evaluate_snippet_multi( self ,snippet )
	local err = int_ptr()
	if _vm  == nil then
		return nil ,_err_jsonnet_make_init
	end
	JsonnetVm.out = libjsonnet.jsonnet_evaluate_snippet_multi(_vm,"snippet",snippet,err)
	local res = ffi.string(JsonnetVm.out)
	err,res = _return(err,res,JsonnetVm.out)
	return err,res
end
 
function _M.destroy( self )
	if _vm  == nil then
		return nil ,_err_jsonnet_make_init
	end
	libjsonnet.jsonnet_destroy(_vm)
	_vm = nil
end

return _M