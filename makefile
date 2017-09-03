exec = exec
platform = linux
srcs = $(wildcard src/*.c)
objs = $(patsubst %.c,out/$(platform)/%.o,$(srcs))

CC = gcc
RM = rm 

all:out $(objs)
	$(CC) -o $(exec) $(objs) 
out/$(platform)/%.o:%.c
	$(CC) -o $@ -c $<
out:
	mkdir -p out/$(platform)/src

clean:
	$(RM) $(objs) out -rf

