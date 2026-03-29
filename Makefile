TARGET = liblog.c.a
SOURCES = src/log.c

CC ?= gcc
AR ?= ar
CFLAGS ?= -Ofast -DNDEBUG
OBJ_DIR ?= obj
BIN_DIR ?= bin
LIB_DIR ?= lib
ARFLAGS ?= rcs

###

OBJECTS=$(SOURCES:%.c=$(OBJ_DIR)/%.o)
DEPS=$(OBJECTS:.o=.d)
DEPFLAGS=-MMD -MP

.PHONY: all target run test clean cleanall

all: target

target: $(BIN_DIR)/$(TARGET)

clean:
	rm -rf $(OBJ_DIR)

cleanall: clean
	rm -rf $(BIN_DIR)

$(OBJ_DIR)/%.o: %.c
	@mkdir -p $(dir $@)
	$(CC) -MMD -MP $(CFLAGS) -c $< -o $@

$(BIN_DIR)/lib%.a: $(OBJECTS)
	@mkdir -p $(dir $@)
	$(AR) $(ARFLAGS) $@ $^

$(BIN_DIR)/%: $(OBJECTS)
	@mkdir -p $(dir $@)
	$(CC) $(LDFLAGS) $^ -o $@ $(LDLIBS)

-include $(DEPS)