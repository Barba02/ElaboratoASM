MAIN=main
ITOA=itoa
ELAB=elab
STRCMP=strcmp
FIND_ID=find_id
TELEMETRY=telemetry
PRINT_INT=print_int
FIND_LEVEL=find_level
PRINT_LEVEL=print_level
STRCPY_TO_INT=strcpy_to_int
OBJS=obj/$(MAIN).o obj/$(ITOA).o obj/$(ELAB).o obj/$(STRCMP).o obj/$(FIND_ID).o obj/$(TELEMETRY).o obj/$(PRINT_INT).o obj/$(FIND_LEVEL).o obj/$(PRINT_LEVEL).o obj/$(STRCPY_TO_INT).o
BIN=bin/telemetry
AS_FLAGS=--32
GCC_FLAGS=-m32 -mtune=i386

all: directories $(BIN)
$(BIN): $(OBJS)
	gcc $(GCC_FLAGS) $(OBJS) -o $(BIN)
obj/$(MAIN).o: src/$(MAIN).c
	gcc $(GCC_FLAGS) -c src/$(MAIN).c -o obj/$(MAIN).o
obj/$(ITOA).o: src/$(ITOA).s
	as $(AS_FLAGS) src/$(ITOA).s -o obj/$(ITOA).o
obj/$(ELAB).o: src/$(ELAB).s
	as $(AS_FLAGS) src/$(ELAB).s -o obj/$(ELAB).o
obj/$(STRCMP).o: src/$(STRCMP).s
	as $(AS_FLAGS) src/$(STRCMP).s -o obj/$(STRCMP).o
obj/$(FIND_ID).o: src/$(FIND_ID).s
	as $(AS_FLAGS) src/$(FIND_ID).s -o obj/$(FIND_ID).o
obj/$(TELEMETRY).o: src/$(TELEMETRY).s
	as $(AS_FLAGS) src/$(TELEMETRY).s -o obj/$(TELEMETRY).o
obj/$(PRINT_INT).o: src/$(PRINT_INT).s
	as $(AS_FLAGS) src/$(PRINT_INT).s -o obj/$(PRINT_INT).o
obj/$(FIND_LEVEL).o: src/$(FIND_LEVEL).s
	as $(AS_FLAGS) src/$(FIND_LEVEL).s -o obj/$(FIND_LEVEL).o
obj/$(PRINT_LEVEL).o: src/$(PRINT_LEVEL).s
	as $(AS_FLAGS) src/$(PRINT_LEVEL).s -o obj/$(PRINT_LEVEL).o
obj/$(STRCPY_TO_INT).o: src/$(STRCPY_TO_INT).s
	as $(AS_FLAGS) src/$(STRCPY_TO_INT).s -o obj/$(STRCPY_TO_INT).o

directories:
	if [ ! -d "obj" ]; then mkdir obj; fi
	if [ ! -d "bin" ]; then mkdir bin; fi
clean:
	rm -rf obj bin
