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

mommy: makeflex makebison $(OBJS)
	$(CC) -o $@ $^ lex.yy.c parser.tab.c $(CFLAGS)

makeflex:
	$(CCC) $(LEX)

makebison:
	$(CCCC) -d $(BISON)

clean:
	rm -f $(OBJS) mommy lex.yy.c parser.tab.*


.PHONY: mommy
