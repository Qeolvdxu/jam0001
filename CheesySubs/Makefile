CC=gcc
CCC=flex
CFLAGS=-Iinclude -lm -std=gnu99 -O0 -g
DEPS = 
OBJS = lex.yy.c
LEX = src/lex.l

all: mommy

%.o: %.c $(DEPS)
	$(CC) -c -o $@ $< $(CFLAGS) 


mommy: $(OBJS)
	$(CCC) $(LEX) 
	$(CC) -o $@ $^ $(CFLAGS)

clean:
	rm $(OBJS) fbanim


.PHONY: mommy
