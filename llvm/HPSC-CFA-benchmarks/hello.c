#include <stdio.h>

void greet(const char *message) {
    printf("%s\n", message);
}

int main() {
    int condition = 1;

    if (condition) {
        greet("Hello, World!");
    } else {
        greet("Goodbye, World!");
    }

    return 0;
}
