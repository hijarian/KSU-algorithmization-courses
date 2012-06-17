#include "myMatrix.h"

const int arrRows=12;
const int arrCols=8;

intvec* vecNegDown(intvec* vec)
{
	//cout << "started counting\n";
	int down=(int)(*vec).size()-1;
	//cout << "var down = " << down << endl;
	int i=0;
	int b;
	while(i<down)
	{
		//cout << "iteration i=" << i << endl;
		if ((*vec)[i]<0)
		{
			//1st
			//cout << "element #" << i << " is negative; should be moved to last\n";
			if((*vec)[down]<0)
			{
				//cout << "element #" << down << " = " << (*vec)[down] << " - already negative\n";
				do
				{
					--down;
					//cout << "down=" << down << endl;;
					//cout << "vec[" << down << "]=" << (*vec)[down] << endl;
				}
				while(((*vec)[down]<0)&&(down!=i));
			}
			/*else
			{
			cout << "element #" << down << " = " << (*vec)[down] << " - positive\n";
			}*/
			//2nd
			if (i!=down)
			{
				b=(*vec)[i];
				//	cout << "b=" << b << endl;
				(*vec)[i]=(*vec)[down];
				//	cout << (*vec)[i] << "<--" << (*vec)[down] << endl; 
				(*vec)[down]=b;
				//	cout << (*vec)[down] << "<--" << b << endl; 
				--down;
				//	cout << "b=" << b << endl;
			}
			/*else
			{
			cout << "i=down: " << i << '=' << down << endl;
			}*/
		}
		/*else
		{
		cout << "element #" << i << " is positive\n";
		}*/
		++i;
		/*cout << "moving to i=" << i << endl;
		vecPrint(vec);
		cout << "-------------\n";*/
	}
	return vec;
}

void arrPrintTrans(matrix* arrMain)
{
	int j=0;
	size_t s=(*arrMain)[j].size();
	for(unsigned i=0; i<s; ++i)
	{
		for(unsigned k=0; k<(*arrMain).size(); ++k)
		{
			cout << setw(intL) << (*arrMain)[k][i] << ' ';
		}
		++j;
		cout << endl;
	}
}
int arrPrintPositives(matrix* arrMain)
{
	int j=0;
	size_t s=(*arrMain)[j].size();
	for(unsigned i=0; i<s; ++i)
	{
		for(unsigned k=0; k<(*arrMain).size(); ++k)
		{
			if( (*arrMain)[k][i] < 0 )
				return i;
		}
		for(unsigned k=0; k<(*arrMain).size(); ++k)
		{
			cout << setw(intL) << (*arrMain)[k][i] << ' ';
		}
		++j;
		cout << endl;
	}
	return -1;
}
matrix* arrNegDown(matrix* arrMain)
{
	matrix::iterator colIterator;
	for (colIterator=(*arrMain).begin(); colIterator!=(*arrMain).end(); ++colIterator)
	{
		colIterator=vecNegDown(&*colIterator);
	}
	return arrMain;
}



int main()
{
	matrix arrMain;
	srand((unsigned)time(NULL));
	matrix* pArrMain=&arrMain;
	pArrMain=arrFill(pArrMain, arrRows, arrCols);	
	cout << "Source matrix():\n";
	arrPrintTrans(pArrMain);
	cout << "\n\n";
	pArrMain=arrNegDown(pArrMain);
	cout << "Matrix with negative elements dropped down:\n";
	arrPrintTrans(pArrMain);
	cout << "\n\nMatrix printed until 1st negative element reached:\n";
	int a=arrPrintPositives(pArrMain);
	if (a>-1)
	{
		cout << "printing stopped at line " << a << " (which was not printed)\n";
	}
	else
		cout << "impressing! no negative values! =)\n";
	/*intvec buffer;
	intvec* pbuffer=&buffer;
	pbuffer=vecFill(pbuffer,12);
	vecPrint(pbuffer);
	pbuffer=vecNegDown(pbuffer);
	vecPrint(pbuffer);*/


	return 0;
}
