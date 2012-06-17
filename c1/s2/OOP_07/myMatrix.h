#include <iostream>
#include <iomanip>
#include <cstdlib>
#include <ctime>
#include <vector>

using namespace std;

typedef vector <int> intvec;
typedef vector <double> doublevec;
typedef vector < intvec > matrix;

void vecPrint(intvec* vec);
void vecPrint(doublevec* vec, int precision=2);
intvec* vecFill(intvec* work, int Elems, int rSeed);
doublevec* vecFill(doublevec* work, int Elems, int rSeed);
matrix* arrFill(matrix* arrMain, int Rows, int Cols);
void arrPrintRaw(matrix* arrMain);