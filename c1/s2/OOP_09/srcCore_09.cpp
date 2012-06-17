#include <iostream>
#include <iomanip>
#include <cmath>

using namespace std;

double f(double a, double b, double c)
{
cout << "| 1+" << c << "+" << a << "*" << b << "+1/" << a << "+1/" << b << " |";
double t=abs(1+c+a*b+1.0/a+1.0/b);
cout << "=" << t << endl;
return t;
}
void main()
{
double t;
cout << "Start of values' entering" << endl;
double a,b,c,x,y,p;
cout << "A=";
cin >> a;
cout << endl << "B=";
cin >> b;
cout << endl << "C=";
cin >> c;
cout << endl << "X=";
cin >> x;
cout << endl << "Y=";
cin >> y;
cout << endl << "P=";
cin >> p;

double t1,t2,t3;
cout << "T1=";
t1=f(p,pow(y,2),c);
cout << endl << "T2=";
t2=f(x,y,c);
cout << endl << "T3=";
t3=f(a,b,c);
cout << endl;

t=t1-t2/pow(t3,3);
cout << endl << "T=" << fixed << t << endl;
}