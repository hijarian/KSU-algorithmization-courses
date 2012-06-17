#include <iostream>
#include <iomanip>
#include <cmath>

using namespace std;
double f(double x, double z)
{
	return (abs(x-z)*exp(z/3.))/(1/3.+cos(x/z));
}
void printline(size_t length)
{
	for (size_t i=1; i<=length; ++i)
		cout << char(-60);
}
void printcellspacer(int count, size_t width, int spacer_idx, int ender_idx)
{
	cout << char(spacer_idx);
	printline(width);
	for(int i=1; i<count; ++i)
	{
		cout << char(spacer_idx);
		printline(width);
	}
	cout << char(ender_idx);
	cout << endl;
}
const size_t cellw = 5;
const size_t prec = 3;
int main()
{
	double ZX[5][5];
	cout << char(-38) ;
	printline(cellw);
	printcellspacer(5, cellw, -62,-65);
	cout << char(-77) << " z\\x ";
	for (int i=1; i<6; ++i)
	{
		cout  << char(-77) << setw(cellw) << setprecision(prec) << i; 
	}
	cout << char(-77) << endl;
	for (int z=0; z<5; ++z)
	{
		double z1=1+(z+2)/10.;
		cout << char(-61);
		printline(cellw);
		printcellspacer(5, cellw, -59, -76);
		cout  << char(-77) << setw(cellw) << setprecision(prec) << z1 << char(-77);
		for (int x=0; x<5; ++x)
		{
			int x1=x+1;
			ZX[z][x]=f(x1,z1);
			cout << setw(cellw) << setprecision(prec) << ZX[z][x] << char(-77);
		}
		cout << endl;
	}
	cout << char(-64);
	printline(cellw);
	printcellspacer(5, cellw, -63, -39);
	return 0;
}