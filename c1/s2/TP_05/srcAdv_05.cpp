#include <iostream>
#include <iomanip>
#include <cmath>

using namespace std;

//1.9.4 var 9
int main()
{
	cout << "Field is defined by next equation system:\n";
	cout << "pow(x,2)+pow(y,2)<=2\n";
	cout << "AND\n";
	cout << "abs(x)+abs(y)>=1\n";
	{
		for(int i=1;i<11;++i) cout << '-';
		cout << endl;
	}
	double x[50];
	double y[50];
	int nmb;
	cout << "Enter number of points to be checked: ";
	cin >> nmb;
	int nmbR=0;
	double x1, y1;
	for (int i=1; i<=nmb; ++i)
	{
		cout << "Entering point " << i << endl;
		cout << "x: ";
		cin >> x1;
		cout << "y: ";
		cin >> y1;
		if((pow(x1,2)+pow(y1,2)<=2)&&(abs(x1)+abs(y1)>=1))
		{
			cout << "Point belongs to field\n";
			cout << "Recorded as element #" << nmbR << endl;
			x[nmbR]=x1;
			y[nmbR]=y1;
			++nmbR;
		}
		else
		{
			cout << "Doesn't belong to field\n";
		}
	}
	{
		for(int i=1;i<11;++i) cout << '-';
		cout << endl;
	}
	cout << "End of checking. Next " << nmbR << " points was recorded:\n";
	for(int i=0;i<nmbR;++i)
	{
		cout << '(' << x[i] << ';' << y[i] << ")\n"; 
	};

	return 0;
}