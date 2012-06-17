#include <iostream>
#include <iomanip>

using namespace std;
// 1.4.3 var 9
int main()
{
	int nmb;
	do
	{
	cout << "Enter EVEN number of elements: ";
	cin >> nmb;
	//--nmb;
	}while(nmb%2);
	int A[50];
	for (int i=0; i<nmb; ++i)
	{
		int b, j;
		j=i+1;
		cout << "Entering Value #" << j << ": ";
		cin >> b;
		A[i]=b;
	}
	cout << endl << "Entered array:";
	cout << "{ " ;
	for (int i=0; i<nmb; ++i)
	{
		cout << A[i] ;
		if (i<(nmb-1))
			cout << " ; ";
	}
	cout << " }" << endl;

	///
	int min=abs(A[0])-abs(A[nmb-1]);
	int minI=0;
	cout << "Started counting.";
	cout << "  Current minimum difference equals " << min << endl;
	for(int i=1; i<nmb ; ++i)
	{
		int b=abs(A[i])-abs(A[nmb-i-1]);
		if(b<min)
		{
			min=b;
			minI=i;
			cout << "On step#" << i << " minI was changed.\n";
			cout << "  Current minimum difference equals " << min << endl;
		}
	}
	cout << "Counting ended." << endl;
	cout << "Results: minimal difference equals " << min << endl;
	cout << "It's diference between these elements: A[" << minI << "]-A[" << (nmb-1) << "-" << minI << ']';

	char u;
	cin >> u;
	return 0;
}