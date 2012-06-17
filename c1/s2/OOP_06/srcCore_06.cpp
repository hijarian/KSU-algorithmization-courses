#include <iostream>
#include <iomanip>
#include <cstdlib>
#include <ctime>

using namespace std;

int main()
{
	srand((unsigned)time(NULL));
	int arr[6][3];
	for (int i=0; i<6; ++i)
		for (int j=0; j<3; ++j)
			arr[i][j]=rand()/0x2FFF-rand()/0x2FFF;
	cout << "Full array:\n\n";
	for (int i=0; i<6; ++i)
	{
		for (int j=0; j<3; ++j)
			cout << setw(3) << (int) arr[i][j] << ' ';
		cout << endl;
	}
	cout << endl;
	int lcount=0;
	int counter;
	for (int i=0; i<6; ++i)
	{
		counter=0;
		for (int j=0; j<3; ++j)
		{
			if(arr[i][j]==0x0)
			{
				++counter;
			}
		}
		if (counter>1)
		{
			cout << "line " << i << " has " << counter << " '0' elements\n";
			++lcount;
		}
	}
	if (lcount >0)
	{
		cout << "array has " << lcount << " matched lines\n";
	}
	else
	{
		cout << "array does't have matched lines\n";
	}

	return 0;
}
