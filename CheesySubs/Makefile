CC=gcc
CFLAGS=-Iinclude -llua5.1 -lm -std=gnu99 -O0 -g
DEPS = 
OBJS = src/main.c

all: mommy

%.o: %.c $(DEPS)
	$(CC) -c -o $@ $< $(CFLAGS) 

mommy: $(OBJS)
	$(CC) -o $@ $^ $(CFLAGS)

clean:
	rm $(OBJS) fbanim


.PHONY: mommy
