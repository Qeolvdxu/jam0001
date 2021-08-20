CC=gcc
CCC=flex
OBJS = src/main.o src/lex.yy.o
LEX = src/lex.l

all: mommy

%.o: %.c $(DEPS)
	$(CC) -c -o $@ $< $(CFLAGS) 


mommy: $(OBJS)
	$(CCC) $(LEX) -o $^
	$(CC) -o $@ $^ $(CFLAGS)

clean:
	rm $(OBJS) mommy


.PHONY: mommy
