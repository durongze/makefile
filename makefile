exec = exec
platform = linux
srcs = $(wildcard src/*.c*)
objs = $(patsubst %.c,out/$(platform)/%.o,$(srcs))

CC = gcc
RM = rm 
MKDIR = mkdir -p 

LIB_DIR_PREFIX=/opt
LIBS_NAME:= boost_1_69_0
LIBS_NAME+= gemo

#$(foreach <var>;,<list>;,<text>;)
INCS_DIR:=$(foreach LIB_N,$(LIBS_NAME),-I$(LIB_DIR_PREFIX)/$(LIB_N)/include)
LIBS_DIR:=$(foreach LIB_N,$(LIBS_NAME),-L$(LIB_DIR_PREFIX)/$(LIB_N)/lib)

LIBS+=-lpthread

#SHARED=ON

ifneq ($(SHARED),)
	CPPFLAGS+=-fPIC
	LDFLAGS+=-shared
else
	#sudo yum install libstdc++-static.x86_64
	LDFLAGS+=-static
endif

all:$(objs)
	$(CC) -o $(exec) $(objs) $(LIBS) $(INCS_DIR) $(LIBS_DIR)

run:
	export LD_LIBRARY_PATH=${LD_LIBRARY_PATH}:$(shell pwd) && \
	./$(exec)

out/$(platform)/%.o:%.c*
	$(MKDIR) $(dir $@)
	#$(MKDIR) $(shell dirname $@)
	$(CC) -o $@ -c $<

clean:
	$(RM) $(objs) out -rf

show:
	@echo "INCS_DIR = $(INCS_DIR)"
	@echo "LIBS_DIR = $(LIBS_DIR)"
	@echo "LIBS = $(LIBS)"
