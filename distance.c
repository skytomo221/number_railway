#include <stdio.h>
#include <stdlib.h>

int distance_recursive(int start, int goal, int longest) {
    int shortest, divisor;
    if (start == goal) return 0;
    if (longest == 0) return -1;
    for (divisor = start; divisor > -start; divisor--) {
        if (divisor == 0 || start % divisor != 0) continue;
        if (start + divisor == goal) return 1;
        if (start + divisor > goal * 2) continue;
        shortest = distance_recursive(start + divisor, goal, longest - 1);
        if (shortest != -1) longest = shortest + 1;
    }
    return longest;
}

int distance(int start, int goal) {
    return distance_recursive(start, goal, goal - start);
}

int main(int argc, char *argv[]) {
    int start, goal;
    if (argc != 3) {
        printf("Usage: %s start goal\n", argv[0]);
        return 1;
    }
    start = atoi(argv[1]);
    goal = atoi(argv[2]);
    printf("%d\n", distance(start, goal));
    return 0;
}
