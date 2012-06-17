#include <iostream>
#include <iomanip>
#include <cmath>
#include <vector>

using namespace std;
// 1.7 var 9

double f(double x)
{
	return (log(1+x)+10.0/3.0*exp(0.01*x))/(2*sqrt(x))-x;
}

double* root(double a, double b, double e, double* x)
{
	cout << "\nProccessing\n";
	while((b-a)>e)
	{
		*x=a+((b-a)/2.0);
		cout << fixed;
		cout << "Current segment: [" << a << ";" << b << "] and it's middle point is " << *x << endl;
		int sign_a=(f(a)>=0)?(1):(0);
		int sign_b=(f(b)>=0)?(1):(0);
		int sign_x=(f(*x)>=0)?(1):(0);
		if (sign_a!=sign_x)
			b=*x;
		else 
		{
			if (sign_x!=sign_b)
				a=*x;
			else 
			{
				cout << "Cannot be completed\n";
				return NULL;
			}
		}
	}
	return x;
}

int main()
{
	cout << "Next function will be processed: \n";
	cout << "f(x)=(log(1+x)+10.0/3.0*exp(0.01*x))/(2*sqrt(x))-x\n";
	cout << "So, negative values not allowed\n";
	double a;
	cout << "Enter POSITIVE lower edge of segment: ";
	cin >> a;
	double b;
	cout << "Enter POSITIVE upper edge of segment: ";
	cin >> b;
	if(a>b)
	{
		cout << "Lower edge greater than upper - swapped\n";
		double c=a;
		a=b;
		b=c;
	}
	vector <double> e;
	cout << "Enter set of accuracy factors (0 - end of sequence): \n";
	unsigned i=0;
	do
	{
		double t;
		cout << "e#" << i+1 << ":\n";	
		cin >> t;
		e.push_back(t);
		++i;
	}
	while(e.back());
	cout << e.back() << endl;
	e.pop_back();
	cout << e.back() << endl;
	double x;
	for(unsigned j=0; j<(i-1); ++j)
	{
		root(a,b,e[j], &x);
		cout << "Accuracy limit #" << j+1 << " reached. Root found: " << x << endl;
		cout << "f(" << x << ")=" << f(x) << endl;
	}
	return 0;
}