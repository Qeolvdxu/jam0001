CC=gcc
CFLAGS=-Iinclude -lfl -lm -std=gnu99 -O0 -g
DEPS = 
OBJS = src/main.o src/lex.yy.o

all: mommy

%.o: %.c $(DEPS)
	$(CC) -c -o $@ $< $(CFLAGS) 

mommy: $(OBJS)
	$(CC) -o $@ $^ $(CFLAGS)

clean:
	rm $(OBJS) mommy


.PHONY: mommy
