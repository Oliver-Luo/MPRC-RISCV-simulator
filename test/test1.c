void do_no_thing(){}

int main (){
	int v0 = 0;
	int a0 = 5;
	int a1 = 10;

	do_no_thing();

	do {
		v0 += a0;
		a1--;
	} while (a1 >=0);

	return 0;
}
