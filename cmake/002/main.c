
#include "config.h"
#ifdef USE_MYMATH
#include "math.h"
#else
#include <stdio.h> 
#endif
int main(int argc, char *argv[])
{
#ifdef USE_MYMATH
    return add(1, 2);
#else
    printf("no surported. \n");
    return 0;
#endif
}


