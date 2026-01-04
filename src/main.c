#include <stdio.h>
#include <sodium.h>
#include <stdint.h>
#include "bar.h"

int main(int argc, char ** argv)
{
    if (sodium_init() == -1) { return 1; }
    uint32_t arr[10];
    for (int i = 0; i < 10; i++)
    {
        arr[i] = randombytes_random();
        printf("%u\n", arr[i]);
    }
}