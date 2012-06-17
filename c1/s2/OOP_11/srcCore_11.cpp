#include "myMatrix.h"

unsigned zerocount(matrix* Crr, size_t Rows, size_t Cols)
{
	unsigned counter=0;
	for(size_t i=0; i!=Rows; ++i)
	{
		for(size_t j=0; j!=Cols; ++j)
		{
			if(!(*Crr)[i][j])
			{
				cout << i << '|' << j << '=' << (*Crr)[i][j] << endl;
				++counter;
			}
		}
	}
	return counter;
}

int main()
{
	//
	matrix Arr;
	matrix Brr;
	//
	srand((unsigned)time(NULL));
	/*for(size_t i=0; i!=3; ++i)
	{
	for(size_t j=0; j!=6; ++j)
	{
	Arr[i][j]=rand()/0xFFF;
	}
	for(size_t k=0; k!=3; ++k)
	{
	Brr[i][k]=rand()/0xFFF;
	}
	}*/
	arrFill(&Arr,3,6);
	arrFill(&Brr,3,3);
	//
	/*for(size_t i=0; i!=3; ++i)
	{
	for(size_t j=0; j!=6; ++j)
	{
	cout << Arr[i][j] << ' ';
	}
	cout << end;
	}*/
	arrPrintRaw(&Arr);
	cout << endl; 
	arrPrintRaw(&Brr);
	cout << endl;
	/*for(size_t i=0; i!=3; ++i)
	{
	for(size_t j=0; j!=3; ++j)
	{
	cout << Brr[i][j] << ' ';
	}
	cout << endl;
	}*/
	cout << "A:\n";
	unsigned zcA=zerocount(&Arr,3,6);
	cout << "zero count of A: " << zcA << endl;
	cout << "B:\n";
	unsigned zcB=zerocount(&Brr,3,6);
	cout << "zero count of B: " << zcB << endl;
	if(zcA<zcB)
	{
		cout << "Array A has less zero elements\n";
	}
	else
	{
		cout << "Array A has greater or equal number of zero elements\n";
	}
	return 0;
}