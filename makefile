exec = exec
platform = linux
srcs = $(wildcard src/*.c*)
objs = $(patsubst %.c,out/$(platform)/%.o,$(srcs))

CC = gcc
RM = rm 
MKDIR = mkdir -p 

all:$(objs)
	$(CC) -o $(exec) $(objs) 

out/$(platform)/%.o:%.c*
	$(MKDIR) $(dir $@)
	#$(MKDIR) $(shell dirname $@)
	$(CC) -o $@ -c $<

clean:
	$(RM) $(objs) out -rf

