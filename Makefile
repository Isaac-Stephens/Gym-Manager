# === Compiler and Flags ===
CXX := g++
CXXFLAGS := -std=c++17 -g -Wall -Wformat
CXXFLAGS += -Isrc -Isrc/ui `wx-config --cxxflags`
LDFLAGS := `wx-config --libs` -lGL -lmysqlcppconn

# === Directories ===
SRC_DIR := src
TARGET_DIR := target
BIN := gymman

# === Source Files ===
SRC_FILES := \
    $(SRC_DIR)/main.cpp \
    $(wildcard $(SRC_DIR)/ui/*.cpp)

# === Object Files ===
OBJ_FILES := $(patsubst %.cpp,$(TARGET_DIR)/%.o,$(SRC_FILES))

# === Default Target ===
all: $(BIN)

# === Linking ===
$(BIN): $(OBJ_FILES)
	@echo "Linking $@..."
	$(CXX) $(OBJ_FILES) -o $@ $(LDFLAGS)

# === Compilation ===
$(TARGET_DIR)/%.o: %.cpp
	@mkdir -p $(dir $@)
	@echo "Compiling $<..."
	$(CXX) $(CXXFLAGS) -c $< -o $@

# === Clean ===
clean:
	rm -rf $(TARGET_DIR) $(BIN)

# === Run ===
run: $(BIN)
	./$(BIN)
