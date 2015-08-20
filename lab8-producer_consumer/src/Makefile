# Makefile for Producer-Consumer

TARGETS =   producer consumer

AFILES  =   producer.asm consumer.asm
CSRCS   =   read_int.c
COBJS   =   $(CSRCS:.c=.o)
OBJS    =   $(AFILES:.asm=.o) $(CSRCS:.c=.o)
LFLAGS  =   -lcosc2425

all:    $(TARGETS)

%:      %.o $(COBJS)
		gcc $< -o $@ $(LFLAGS)

%.o:    %.asm
		nasm -f elf64 -Fdwarf -g $< -o $@

%.o:	%.c
		gcc -c -o $@ $<
clean:
		rm -f $(OBJS) $(TARGETS)
