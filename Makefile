LIB = /usr/lib64/
exist = $(shell if [ -f $(LIB) ]; then echo "true"; else echo "false"; fi;)
ifeq (exist, "false")
	LIB = /usr/lib/
endif
install:  
	cd libjsonnet && make libjsonnet.so && cp libjsonnet.so  $(LIB) && cd ../ &&  cp jsonnet.lua /usr/local/share/luajit-*/


