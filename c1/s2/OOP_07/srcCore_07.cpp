#include "myMatrix.h"
double X(unsigned i, matrix* pA, doublevec* pC, unsigned m, int s, double p, double b)
{
	double prod=1;
	for(unsigned k=0; k<m; ++k)
	{
		int a=(*pA)[i][k];
		if(!a)
		{
			a=1;
		cout << "A[" << i+1 << "][" << k+1 << "]=" << a;
		cout << " was replaced by '1'\n";  
		}

		double c=(*pC)[k];
		/*cout << "A[" << i+1 << "][" << k+1 << "]=" << a << endl; 
		cout << "C[" << i+1 << "]=" << c << endl;
		cout << "a*c=" << a*c << endl;
		cout << "b+k+1=" << b+k+1 << endl;*/
		prod*=((a*c)/(b+k+1));
		//cout << "prod=" << prod << endl;
	}
	//cout << "p=" << p << endl; 
	return (prod*s)/p;
}
int main()
{
	matrix A;
	matrix* pA=&A;
	cout << "enter NON-INTEGER value B: ";
	double b;
	do
		cin >> b;
	while(!(b-(int)b));
	cout << "enter positive value m: ";
	unsigned m;
	cin >> m;
	arrFill(pA, m, m);
	cout << "array A:\n";
	arrPrintRaw(pA);
	cout << "for counting array C enter value C1...";
	double c1;
	cin >> c1;
	cout << "...and increment R:";
	double r;
	cin >> r;
	doublevec C;
	doublevec* pC=&C;
	int s=0;
	for(unsigned i=0; i<m; ++i)
	{
		C.push_back(c1+r*i);
		if(!C[i])
			C[i]=1;
		s+=A[i][i];
	}
	cout << "every zero element of array C was replaced by '1'\n";
	cout << "so array C consist of next elements:\n";
	vecPrint(pC);
	cout << "value S equals to " << s << "\n\n";
	cout << "begin counting\n";
	cout << "-----------------\n";
	double p=1;
	for (unsigned i=0; i<m ; ++i)
	{
		p=X(i, pA, pC, m, s, p, b);
		cout << "X[" << i+1 << "]=" << setprecision(4) << p << endl; 
		cout << "-----------------\n";
	}
	return 0;
}