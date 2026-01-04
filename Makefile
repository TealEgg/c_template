BUILD_DIR := build
SRC_DIR := src

EXEC := name.exe
CC := gcc
# flags for c preprocessor
CPPFLAGS := 
# flags for c compiler (note: put pkg-config --cflags here)
# NOTE: for a static build, add '--static' (e.g $(shell pkg-config ncursesw --cflags --static))
CFLAGS := -Wall # -static
# put -L flag here
LDFLAGS := 
# put -l flag here
LDLIBS := 

# lib sodium
CFLAGS += $(shell pkg-config --cflags libsodium)
LDFLAGS += $(shell pkg-config --libs-only-L libsodium)
LDLIBS += $(shell pkg-config --libs-only-l libsodium)

SRC := $(wildcard $(SRC_DIR)/*.c)
OBJECTS := $(SRC:$(SRC_DIR)/%.c=$(BUILD_DIR)/%.o)

$(BUILD_DIR)/$(EXEC): $(OBJECTS)
	$(CC) $^ $(CPPFLAGS) $(CFLAGS) $(LDFLAGS) $(LDLIBS) -o $@

$(BUILD_DIR)/%.o: $(SRC_DIR)/%.c
	$(CC) -c $(CPPFLAGS) $(CFLAGS) $(LDFLAGS) $(LDLIBS) $< -o $@

.PHONY: clean run

# windows requires paths to have \ instead of / in paths
clean:
	del $(patsubst %,$(BUILD_DIR)\\%,$(notdir $(OBJECTS))) $(BUILD_DIR)\$(EXEC)

run: $(BUILD_DIR)/$(EXEC)
	$(BUILD_DIR)/$(EXEC)