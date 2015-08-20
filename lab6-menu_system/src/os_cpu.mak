# detect OS/CPU and set variables
OSTYPE 	= UNK
NFLAGS 	= -f bin
CPUTYPE = UNK

# Check for Windows
ifeq ($(OS), Windows_NT)
	OSTYPE = WIN32
	ifeq ($(PROCESSOR_ARCHITECTURE), AMD64)
 		CPUTYPE = AMD64
 		NFLAGS = -f win64
 	endif
 	ifeq ($(PROCESSOR_ARCHITECTURE),x86)
 		CPUTYPE = IA32
 		NFLAGS = -f win32
 	endif
else
	# ask the OS what we are on and what processor we have
	UNAME_S := $(shell uname -s)
 	UNAME_P := $(shell uname -p)
	# check for Linux
	ifeq ($(UNAME_S), Linux)
		OSTYPE = LINUX
 		ifeq ($(UNAME_P), x86_64)
			CPUTYPE = AMD64
			NFLAGS = -f elf64
		else
			CPUTYPE = IA32
			NFLAGS = -f elf32
		endif
	endif
	# check for Mac
	ifeq ($(UNAME_S), Darwin)
		OSTYPE = OSX
		UNAME_A  := $(shell uname -a)
		ifneq ($(filter %x86_64, $(UNAME_A)),)
			CPUTYPE = AMD64
			NFLAGS  = -f macho64 --prefix _
		endif
		ifneq ($(filter %i386, $(UNAME_A)),)
			CPUTYPE = IA32
			NFLAGS = -f macho32 --prefix _
		endif
	endif	
endif
