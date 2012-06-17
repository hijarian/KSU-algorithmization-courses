#include <iostream>
#include <iomanip>
#include <cstdlib>
#include <vector>
#include <ctime>

using namespace std;
//2.5.2 var 9

const unsigned arrL=8;
const unsigned iL=3;
//const unsigned iPrec=1;
void printline(int length)
{
	for (int i=1; i<=length; ++i)
		cout << char(-60);
}
int main()
{
	vector < int > arrRes;
	srand((unsigned)time(NULL));
	int arrMain[arrL][arrL];

	{
		cout << fixed << "   ";
		for(int i=0; i<arrL; ++i)
			cout << setw(iL) << i << ' ';
		cout << endl;
		cout << "  " << char(-38);
		printline(arrL*(iL+1));
		cout << char(-65) << endl;
	}
	for(int col=0; col<arrL; ++col)
	{
		cout << col << ' ' << char(-77);
		for(int row=0; row<arrL; ++row)
		{
			int val=rand()/10000;
			arrMain[col][row]=val;
			cout << setw(iL) /*<< setprecision(iPrec)*/ << arrMain[col][row] << ' ';
		}
		cout << char(-77) << endl;
	}

	{
		cout << "  " << char(-64);
		printline(arrL*(iL+1));
		cout << char(-39) << endl;
	}
	cout << "Working log started.\n";
	for (int col=0; col<arrL; ++col)
	{
		cout << " #" << col << ": ";
		int b=-1;
		for (int row=1; row<arrL-1; ++row)
		{
			int cur=arrMain[row][col];
			cout << cur << ' ';
			int next=arrMain[row+1][col];
			int prev=arrMain[row-1][col];
			if (cur==((next+prev)/2))
			{
				b=row;
				break;
			}
		}
		cout << "\n--column";
		if (b==-1)
		{
			arrRes.push_back(1);
			cout << " checked. X[" << col << "]=1\n";
		}
		else
		{
			arrRes.push_back(0);
			cout << " illegal. arrMain[" << b << "]=" << arrMain[b][col] << "=(" << arrMain[b-1][col];
			cout << '+' << arrMain[b+1][col] << ")/2=";
			cout << (arrMain[b-1][col]+arrMain[b+1][col])/2;
			cout << " .X[" << col << "]=0\n";
		}
		cout << endl;

	}
	cout << "X={ ";
	for (int i=0; i<arrL; ++i)
	{
		cout << arrRes[i];
		if (i!=(arrL-1))
			cout << ';';
		cout << ' ';
	}
	cout << '}' << endl;

	return 0;
}
