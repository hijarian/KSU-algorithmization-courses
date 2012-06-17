#include <string>
#include <fstream>
using namespace std;
typedef string TKey;
typedef string TVal;

struct TNode {
	TKey name;
	TVal number;
	TNode* link;
};
typedef TNode* ptNode;

ptNode listConstruct(size_t);
void listDestroy(ptNode);
int listAddNode(ptNode, size_t, TKey, TVal);
ptNode listAdd1st(ptNode, TKey, TVal);
ptNode listRemove1st(ptNode);
int listRemoveNode(ptNode, size_t);
ptNode listInverse(ptNode);
size_t listGetSize(ptNode);
ptNode listGetElem(ptNode, size_t);
int listSave(ptNode, const char*);
ptNode listLoad(const char*);