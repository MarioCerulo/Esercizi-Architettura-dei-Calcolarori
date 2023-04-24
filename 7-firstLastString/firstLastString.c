#include <stdio.h>
#include <string.h>

int str_cmp(char *, char *);

char *first_string(char *);
char *last_string(char *);

int main(){
	char string[100];
	char first[25];
	char last[25];

	printf("Inserisci la prima stringa: ");
	scanf("%25s", string);

	printf("Inserisci la seconda stringa: ");
	scanf("%25s", string + 25);

	printf("Inserisci la terza stringa: ");
	scanf("%25s", string + 50);

	printf("Inserisci la quarta stringa: ");
	scanf("%25s", string + 75);

	strcpy(first, string);

	printf("La prima stringa è: %s\n", first_string(string));
	printf("L'ultima stringa è: %s\n", last_string(string));

	return 0;
}

char *first_string(char *string){
	char *first = string;

	for(int i = 25; i <= 75; i = i + 25){
		if((str_cmp(first, string + i)) > 0)
			first = string + i;
	}

	return first;
}

char *last_string(char *string){
	char *last = string;

	for(int i = 25; i <= 75; i = i + 25){
		if((str_cmp(last, string + i)) < 0)
			last = string + i;
	}

	return last;
}

int str_cmp(char *s1, char *s2){

	while(*s1 == *s2){
		if(!*s1)
			return 0;
		s1++;
		s2++;
	}

	if(*s1 < *s2)
		return -1;

	return 1;

}