#include <stdio.h>

int isLittleEndian() {
  int temp = 1; // random variable and value we're using for test
  // pointer to FIRST BYTE, or smallest memory location,  of the 4 byte integer
  char *p = &temp;

  // printf("%d\n", sizeof(int));

  // Because the value oftemp is 1, if the machine is little endian, the 1
  // value will be stored in the lowest memory location, which is pointed to
  // by *p. Therefore, if (*p) posseses a non-zero value, the machine is 
  // Little Endian. Otherwise, it's Big Endian.
  if (*p)
    return 1;
  else
    return 0;
}

main()
{
  if (isLittleEndian()) {
    printf("Machine is Little Endian\n");
  }
  else {
    printf("Machine is Big Endian\n");
  }
}
