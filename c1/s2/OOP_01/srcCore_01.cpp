#include <cstdio>
#include <cmath>
#include <windows.h>
#include "ConvOem.h"
void main()
{
	double x=0.0;
	CConvOem szBuf(100); // создание объекта типа CConvOem длины 100
	while((x<0.1)||(x>0.6))
	{
		printf(szBuf.toOem("¬ведите x из отрезка [0,1..0,6]:"));
		scanf("%lf",&x);
	}
	const double pi=3.14159;
	x=(abs(sin(sqrt(10.5*x))))/(pow(x,(3.0/2.0))-0.143)+(2*pi*x);
	printf(szBuf.toOem("–езультат равен: %8.2f\n"),x);
}
