
#include <stdio.h>

int get_byte_by_addr(int *, int i);

int get_byte_by_order(int x, int i) {
    //int lowest_byte = x & 0xff;
    //int byte1 = x & 0xff00;
    //int byte1 = ((x & 0xff00) >> 8) &0xff;
    int byte = (x >> 8*i) &0xff;
    return byte;
    // end of Part 2.
}

int x = 0x01234567;
unsigned int y = 0xffffffd6;

void main () {
    // complete this in Part 1.
    printf("x = %#.08x\n", x);
    printf("x = %d\n", x);
    printf("y = %#.08x\n", y);
    printf("y = %u\n", y);
    // end of Part 1

    int i;

    printf("x = ");
    for (i = 0; i < 4; i++) {
        printf("%02x", get_byte_by_order(x, i));
    }
    putchar('\n');

    printf("x = ");
    for (i = 0; i < 4; i++) {
        printf("%02x", get_byte_by_addr(&x, i));
    }
    putchar('\n');

    printf("y = ");
    for (i = 0; i < 4; i++) {
        printf("%02x", get_byte_by_order(y, i));
    }
    putchar('\n');

    printf("y = ");
    for (i = 0; i < 4; i++) {
        printf("%02x", get_byte_by_addr(&y, i));
    }
    putchar('\n');

    return;
}

