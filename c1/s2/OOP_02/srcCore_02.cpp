#include <cstdio>
#include <cmath>
//#include <windows.h>
//#include "ConvOem.h"

int main()
{
	//CConvOem szBuf(100);
	printf("Enter nmbr of cylinders: \n");
	int nmb;
	scanf("%i",&nmb);
	printf("Enter height of cylinders (it equals for each):\n");
	int h;
	scanf("%i",&h);
	printf("Enter inner radius of 1st cylinder: \n");
	int r;
	scanf("%i",&r);
	const double thick=0.2;
	const int dens=5000;
	printf("Cylinder wall thickness equals %3.1f\n",thick);
	printf("Metal density equals %i\n",dens);
	double volCur, volSum=0.0;
	const double pi=3.14159;
	for (int i=1;i<=nmb;++i)
	{
		double rc;
		rc=r*sqrt((double)i);
		double extrad=rc+thick;
		volCur=(pow(extrad,2)-pow(rc,2))*pi*h;
		printf("Volume of cylinder #%i: %12.2lf\n",i,volCur);
		volSum+=volCur;
	}
	double mass=volSum*dens;
	printf("Summary volume of cylinders' walls: %12.2f\n",volSum);
	printf("Summary mass of cylinders: %12.2f\n",mass);

	return 0;
}