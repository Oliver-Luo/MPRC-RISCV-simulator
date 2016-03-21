void quicksort(int r[1001],int s,int e) 
{ 
   if(s>=e)return;//退出条件 

   int t = r[s];//哨兵，为开头的那个 
   int f = s+1; 
   int b = e;//f为前向指针，从s+1开始，b为反向指针，从e开始 
   int m = 0; 
    
   while(f<=b) 
   { 
       while(f<=b&&r[f]<=t) f++;//在前面找比哨兵大的元素 
       while(f<=b&&r[b]>=t) b--;//在后面找比哨兵小的元素 
       //交换这两个元素 
       if(f<b){ 
            m = r[f]; 
            r[f] = r[b]; 
            r[b] = m; 
            f++;    b--; 
       } 
   } 
   //交换哨兵和r[b],r[b]肯定要比哨兵小 
   r[s] = r[b]; 
   r[b] = t; 
   //排两边的 
   quicksort(r,s,b-1); 
   quicksort(r,b+1,e); 
} 

int a[10] = {34, 21, 43, 3, 43, 1, 5, 8, 9, 10};

int main ()
{
/*	int a[10];
	a[0] = 34;
	a[1] = 21;
	a[2] = 43;
	a[3] = 3;
	a[4] = 43;
	a[5] = 1;
	a[6] = 5;
	a[7] = 8;
	a[8] = 9;
	a[9] = 10;
*/
	quicksort(a, 0, 9);
}
