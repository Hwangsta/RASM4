PROG = rasm3
SRC = $(wildcard src/*.s)
OBJ = $(patsubst src/%.s, obj/%.o, $(SRC))
OBJ_EXT = $(wildcard obj_ext/*.o)
LD_FLAGS = -e main
LD_LIBS = /lib/aarch64-linux-gnu/libc.so.6 -dynamic-linker /lib/ld-linux-aarch64.so.1

$(PROG): $(OBJ)
        ld -o $(PROG) $(OBJ) $(OBJ_EXT) $(LD_LIBS) $(LD_FLAGS)

obj/%.o: src/%.s
        as -g $< -o $@

.PHONY: clean

clean:
        rm $(OBJ) $(PROG)
