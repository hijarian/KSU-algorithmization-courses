#include <iostream>
#include <iomanip>
#include <cstdlib>
#include <ctime>
#include <vector>

using namespace std;

typedef vector <int> intvec;
typedef vector < intvec > matrix;
const int intL=3;
void vecPrint(intvec* vec)
{
	intvec::iterator It=(*vec).begin();
	for(It; It!=(*vec).end(); ++It)
	{
		cout << setw(intL) << *It << ' ';
	}
	cout << endl;
}
intvec* vecFill(intvec* work, int Elems, int rSeed)
{
	srand(rSeed);
	for(int j=0; j<Elems; ++j)
	{
		(*work).push_back((int)(rand()/1000.-rand()/1000.));
	}
	return work;
}

matrix* arrFill(matrix* arrMain, int Rows, int Cols)
{

	//for(colIterator=arrMain.begin(); colIterator!=arrMain.end(); ++colIterator)
	for(int i=0; i<Cols; ++i)
	{

		intvec buffer;
		(*arrMain).push_back(buffer);
		(*arrMain)[i]=*vecFill(&(*arrMain)[i], Rows, rand());
		/*for(int j=0; j<Rows; ++j)
		{

		buffer.push_back((int)(rand()/1000.-rand()/1000.));
		}
		(*arrMain).push_back(buffer);*/
	}
	return arrMain;
}
void arrPrintRaw(matrix* arrMain)
{
	matrix::iterator colIterator;
	intvec::iterator rowIterator;
	unsigned i=0;
	//for(int i=0; i<arrCols; ++i)
	for(colIterator=(*arrMain).begin(); colIterator!=(*arrMain).end(); ++colIterator)
	{
		//for(int j=0; j<arrRows; ++j)
		for(rowIterator=(*arrMain)[i].begin(); rowIterator!=(*arrMain)[i].end(); ++rowIterator)
		{
			//cout << ((*arrMain)[i])[j] << ' ';
			cout << setw(intL) << *rowIterator << ' ';
		}
		++i;
		cout << endl;
	}
}
