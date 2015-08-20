# Project Makefile for COSC2425

TARGET	= lab6
ASRCS	= driver.asm menu.asm enterNum.asm printloop.asm

CSRCS   = get_kb.c read_int.c
OBJS	= $(ASRCS:.asm=.o) $(CSRCS:.c=.o)

# DETECT OS AND CPU
include  os_cpu.mak

.PHONY:
all:	$(TARGET)

$(TARGET):	$(OBJS)
	gcc -o $(TARGET) $(OBJS)

%.o:	%.asm
	nasm $(NFLAGS) $< -o $@

%.o:    %.c
	gcc -c -o $@ $<


.PHONY:
clean:
	rm $(TARGET) $(OBJS)

.PHONY:
info:
	@echo OS:  $(OSTYPE)
	@echo CPU: $(CPUTYPE)	
	@echo NFLAGS: $(NFLAGS)
