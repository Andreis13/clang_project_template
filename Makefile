SOURCES := $(shell find src -type f -name '*.c')
OBJECTS := $(SOURCES:src/%.c=obj/%.o)
EXECUTABLES := app
NON_MAIN_OBJECTS := $(filter-out $(EXECUTABLES:%=obj/%.o),$(OBJECTS))

CC := gcc
CFLAGS := -Wall
INCLUDE := -Isrc

all: $(EXECUTABLES:%=bin/%)

clean:
	rm bin/*
	rm -r obj/*

# link the main object file with all non-main object files to obtain an executable
bin/%: obj/%.o $(NON_MAIN_OBJECTS)
	$(CC) $(CFLAGS) $(INCLUDE) $^ -o $@

# compile all source files into object files
# NOTE: the compiler doesn't know how to create subdirectories if they don't exist
# so we have to create them ourselves
obj/%.o: src/%.c
	@mkdir -p $(@D)
	$(CC) $(CFLAGS) $(INCLUDE) -c $< -o $@


.PHONY: all clean
.PRECIOUS: $(OBJECTS)
