#include <stdio.h>
#include <string.h>
#include <stdlib.h>

char *reverse(char *);

int main(){
	char *string = (char *) calloc(sizeof(char), 51);

	printf("Inserisci una stringa: ");
	scanf("%s", string);

	char *reversed_string = reverse(string);

	printf("La stringa invertita è: %s\n", reversed_string);
}

char *reverse(char *s){

	int len = strlen(s);
	char *reversed_string = (char *) calloc(sizeof(char), len + 1);

	for(int i = 0, j = len - 1; i < len; i++, j--){
		reversed_string[j] = s[i];
	}

	reversed_string[len] = '\0';

	return reversed_string;

}