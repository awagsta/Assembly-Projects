TARGET	= OddLoop
ASRCS	= oddloop.asm
OBJS	= $(ASRCS:.asm=.o)

# DETECT OS AND CPU
include  os_cpu.mak

.PHONY:
all:	$(TARGET)

$(TARGET):	$(OBJS)
	gcc -o $(TARGET) $(OBJS)

%.o:	%.asm
	nasm $(NFLAGS) $< -o $@

.PHONY:
asm:	hello.c
	gcc -S hello.c -o hello.asm



.PHONY:
info:
	@echo OS:  $(OSTYPE)
	@echo CPU: $(CPUTYPE)	
	@echo NFLAGS: $(NFLAGS)
