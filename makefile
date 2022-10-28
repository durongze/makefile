exec = exec
platform = linux
srcs = $(wildcard src/*.c*)
objs = $(patsubst %.c,out/$(platform)/%.o,$(srcs))

CC = gcc
RM = rm 
MKDIR = mkdir -p 

OS_STR=$(shell uname)

ifeq ($(OS_STR),MINGW32_NT-10.0)
    Platform=windows
else ifeq ($(OS_STR),MINGW32_NT-*)
    Platform=windows
else
    Platform=linux
endif

LIB_DIR_PREFIX=../linux/_/

#$(foreach <var>;,<list>;,<text>;)
LIBS_NAME=$(shell ls $(LIB_DIR_PREFIX))
INCS_DIR:=$(foreach LIB_N,$(LIBS_NAME),-I$(LIB_DIR_PREFIX)/$(LIB_N)/include -I$(LIB_DIR_PREFIX)/$(LIB_N)/)
LIBS_DIR:=$(foreach LIB_N,$(LIBS_NAME),-L$(LIB_DIR_PREFIX)/$(LIB_N)/lib -L$(LIB_DIR_PREFIX)/$(LIB_N)/)
INCS_DIR+=-I./


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
	${RM} $(foreach n_dir, $(dir $(foreach n, $(OBJS), $(n))), $(n_dir)/*.o)
	$(RM) $(objs) out -rf

show:
	@echo "INCS_DIR = $(INCS_DIR)"
	@echo "LIBS_DIR = $(LIBS_DIR)"
	@echo "LIBS = $(LIBS)"
