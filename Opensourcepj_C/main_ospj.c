
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include  "opensourcepj.h"

int main (int argc, char *argv[])
{


 char host_name[20]="localhost";
 char user_name[20];
 char password[20];
  unsigned int port_num = 0;
 char *socket_name = NULL; /* uso del default*/
 char db_name[20];


   printf("\nInformazioni accesso al DB\n");

   printf ("- indirizzo_host (localhost per server locale): ");/*nome host*/
   scanf ("%19s",host_name);


    printf ("- nome_utente: ");
     scanf ("%19s",user_name);


    printf ("- password: ");
   
    
  scanf ("%19s",password);
  
    printf("- nome del DB da impiegare: ");
     scanf ("%19s",db_name);


    gestione_db ( host_name, user_name, password , port_num , socket_name , db_name , 0 );
  
    /* applicazione della funzione modulo di utilizzo del DB*/

    return 0; /*ritorno main */

}
