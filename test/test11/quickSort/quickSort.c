//#include<stdio.h>

int a[10];

void quickSort(int* a,int left,int right)
{
    if(left>=right) return;
    int i=left;
    int j=right+1;
    int target=a[left];
    while(i<j)
    {

        do
        {
            i++;
        }while(a[i]<target && i<right);
        do
        {
            j--;
        }while(a[j]>target && j>left);
        if(i<j)
        {
        int temp=a[i];
        a[i]=a[j];
        a[j]=temp;
        }

    }
    a[left]=a[j];
    a[j]=target;


    quickSort(a,left,j-1);
    quickSort(a,j+1,right);


}


int main()
{

    int i=0;
    for(i=0;i<10;i++)
    {

        a[i]=9-i;
    }

    quickSort(a,0,9);


    return 0;
}
