//#include <stdio.h>
int result[3][3];
//int t;
int main()
{
	/* code */
	int a[3][3];
	int b[3][3];
        int i;
        int j;
	for ( i = 0; i < 3; i++)
	{
		for (j = 0; j < 3; j++)
		{
			a[i][j]=i+j;
			b[i][j]=j+1;
			result[i][j] = a[i][j] + b[i][j];
                        //printf("%d ",result[i][j]);
		}
                //printf("\n");
	} 
	return 0;
}
