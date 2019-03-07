#include <iostream>
#include <stdlib.h>
#include <pthread.h>
using namespace std;

int var = 100;
void* chaild_fn(void* arg) { var++; return NULL; }

int main()
{
	cout << "Please 100 \n";
	char* p = (char*)malloc(555);
//	free(p);
// This Code for Thread Race 
	
	pthread_t c;
	pthread_create(&c,NULL,chaild_fn,NULL);
	var++;
	pthread_join(c,NULL);

return 0;
}
