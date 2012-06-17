#include <iostream>
#include <iomanip>
#include <cmath>
using namespace std;

int main()
{
	/*string strIn;
	cout << "Enter a sequence of digits. (Length of sequence is irrelevant):" << endl;
	while()read( strIn;
	int* arrMain[strIn];
	for(int i=0; i<=strIn.length; ++i)
	{
	arrMain[i]=atoi(strIn[i]);
	cout << arrMain[i];
	}*/

	int nmb;
	cout << "Enter nmb of array elements: " << endl;
	cin >> nmb;
	--nmb;
	int A[100];
	for (int i=0; i<=nmb; ++i)
	{
		int b, j;
		j=i+1;
		cout << "Entering Value #" << j << ": ";
		cin >> b;
		A[i]=b;
		//cout << endl;
	}

	cout << endl << "Entered array:";
	cout << "{ " ;
	for (int i=0; i<=nmb; ++i)
	{
		cout << A[i] ;
		if (i<nmb)
			cout << " ; ";
	}
	cout << " }" << endl;

	int c=1;
	for (int i=1; i<=(nmb+1); i+=3)
	{
		cout << "#"<< i << endl;
		c=c*A[i-1];
		cout << c << endl;
	}

	cout << "Result: " << c << endl;

	cin >> c;
	return 0;
}