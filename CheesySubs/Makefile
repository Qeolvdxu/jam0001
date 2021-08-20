CC=gcc
CCC=flex
CCCC=bison
OBJS = src/main.o 
LEX = src/lex.l
BISON = src/parser.y
CFLAGS = -Isrc -I. -lm -lfl -std=gnu99 -O0 -g

all: mommy

%.o: %.c $(DEPS)
	$(CC) -c -o $@ $< $(CFLAGS) 

mommy: $(OBJS)
	$(CCCC) -d $(BISON)
	$(CCC) $(LEX)
	$(CC) -o $@ $^ lex.yy.c parser.tab.c $(CFLAGS)

clean:
	rm $(OBJS) mommy


.PHONY: mommy
