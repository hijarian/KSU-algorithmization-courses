#include <iostream>
#include <iomanip>
#include <cstdlib>
#include <vector>
#include <ctime>

using namespace std;
//2.6 var 9

const unsigned arrL=10;
const unsigned iL=3;
const unsigned iPrec=1;
int main()
{
	cout << fixed; 
	srand((unsigned)time(NULL));
	double arrMain[arrL][2];
	int factor=rand()/3000;
	cout << "factor=" << factor << endl;
	for(int i=0; i<arrL; ++i)
	{
		arrMain[i][0]=50-i*4+0+rand()/10000.;
		arrMain[i][1]=50-i*4+2+rand()/10000.;
		if (factor==i) 
			arrMain[i][1]+=rand()/8000.;
		cout << setw(iL) << setprecision(iPrec) << arrMain[i][0] << ' ' << arrMain[i][1] << endl;
	}

	for(int i=0; i<arrL; ++i)
	{
		if ((i+1)<arrL) //если следующее кольцо есть, то
			if(arrMain[i][0]<arrMain[i+1][1])// пробуем вложить, и, если следующее кольцо уже, то
			{
				cout << "Ring #" << i+1 << " doesn't fit: " << arrMain[i][0] << '<' << arrMain[i+1][1] << endl;
				break;
			}
			else
			{
				cout << "Ring #" << i+1 << " inserted\n"; 
			}
	}
	return 0;
}