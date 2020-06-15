#include <stdio.h>

void hanoi(int n, int start, int finish, int extra)
{
  if(n != 0) {
    hanoi(n-1, start, extra, finish);
    printf("Move disk");
    printf(" %d ",n);
    printf("from peg");
    printf(" %d ",start);
    printf("to peg");
    printf(" %d ", finish);
    printf(".\n");
    hanoi(n-1, extra, finish, start);
   }
}

int main()
{
  int n;
  n = 3;
  hanoi(n, 1, 2, 3);
  return 0;
}

