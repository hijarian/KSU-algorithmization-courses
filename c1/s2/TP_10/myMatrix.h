#include <iostream>
#include <iomanip>
#include <cstdlib>
#include <ctime>
#include <vector>

using namespace std;

typedef vector <int> intvec;
typedef vector < intvec > matrix;
const int intL=3;

void vecPrint(intvec* vec);
intvec* vecFill(intvec* work, int Elems, int rSeed);
matrix* arrFill(matrix* arrMain, int Rows, int Cols);
void arrPrintRaw(matrix* arrMain);