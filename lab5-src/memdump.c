#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#define PRINT_LEN 16

void memdump(char * p , int len) {
  do {

    printf("0x%x: ", p);
    char *ascii = malloc(sizeof(char) * (PRINT_LEN + 1));

    // print the hex value and store the (potential) ascii value
    int i = PRINT_LEN;
    for (; i > 0 && len > 0; --i, ++p, --len) {
      printf("%02x ", *p);
      if (*p >= 32 && *p <= 127)
	ascii[PRINT_LEN - i] = *p;
      else
	ascii[PRINT_LEN - i] = '.';
    }

    // null-treminate the ascii string
    ascii[PRINT_LEN - i] = '\0';

    printf("\t%s\n", ascii);
    free(ascii); ascii = NULL;
    
  } while (len > 0);
    
}

struct X{
  char a;
  int i;
  char b;
  int *p;
};

struct List {
  char * str;
  struct List * next;
};

main() {
  char str[20];
  int a = 5;
  int b = -5;
  double y = 12;
  struct X x;
  struct List * head;

  x.a = 'A';
  x.i = 9;
  x.b = '0';
  x.p = &x.i;
  strcpy(str, "Hello world\n");
  printf("&x=0x%x\n", &x.a);
  printf("&y=0x%x\n", &y);

  memdump((char *) &x.a, 64);
  head = (struct List *) malloc(sizeof(struct List));
  head->str=strdup("Welcome ");
  head->next = (struct List *) malloc(sizeof(struct List));
  head->next->str = strdup("to ");
  head->next->next = (struct List *) malloc(sizeof(struct List));
  head->next->next->str = strdup("cs250");
  head->next->next->next = NULL;
  printf("head=0x%x\n", head);
  memdump((char*) head, 128);
}
