/* ============= *
 * GLFW INI TEST *
 * ============= */

// g++ test_glfw.cpp -o test_glfw `pkg-config --cflags --libs glfw3`
// ./test_glfw


#include <GLFW/glfw3.h>
#include <iostream>

int main() {
    if (!glfwInit()) {
        std::cerr << "glfwInit failed\n";
        return 1;
    }
    std::cout << "glfwInit OK\n";
    glfwTerminate();
    return 0;
}
