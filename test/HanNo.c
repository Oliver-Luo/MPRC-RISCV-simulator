int i;
int result[100];

void push(int a)
{
   result[i]=a;
   i++;
}

void hanoi(int n,int a,int b,int c)
 {
     if(n>=1)
     {
         hanoi(n-1,a,c,b);
         //printf("%d-->%d\n",a,c);
         push(a);
         push(c);
         hanoi(n-1,b,a,c);
     }
 }


void main()
{
   int n=4;
   i=0;
   //int j;
   //printf("Input the number of disks:\n");
   //scanf("%d",&n);
   hanoi(n, 1, 2, 3);
  // for(j=0;j<30;j++)
  //   printf("%d ",result[j]);
}
