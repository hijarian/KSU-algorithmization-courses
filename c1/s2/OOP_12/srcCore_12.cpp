#include <iostream>
#include <fstream>
#include <string>
#include <windows.h>
#include "ConvOem.h"

using namespace std;
int main()
{
	ifstream infile("in_file");
	//ofstream outfile("out_file");
	CConvOem sz(64);
	if ( ! infile)
	{
		cerr << "Opening error\n";
		return -1;
	}
	//if ( ! outfile)
	//{
	//cerr << "Opening error\n";
	//return -2;
	//}
	char t;
	cout << "Sym>";
	cin >> t;
	char toem=sz.fromOem(t);
	string word;
	while(infile >> word)
	{
		if(*(word.begin())==toem)
		{
			for(size_t i=0; i<word.size(); ++i)
			{
				cout << sz.toOem(word[i]);
			}
			cout << endl;
		}
	}

	return 0;
}