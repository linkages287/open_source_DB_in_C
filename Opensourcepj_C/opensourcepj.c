/*------------------------------------*/
/*file opensourcepj.c                 */
/*File di implementazione del database*/
/*------------------------------------*/

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <my_global.h>/* l'ordine di inclusione è importante*/
#include <my_sys.h> /* contiene portability macros */
#include <mysql.h> /* vengono definite le strutture dati principali di mysql */
#include <time.h> 

/*dichiarazione funzioni*/
void gestione_db ( char *, char *, char *, unsigned int, char *, char *, unsigned int);
void disconnessione_DB (MYSQL *);
int menu_opzioni(MYSQL *);
void crea_utente(MYSQL *);
void visualizza_elenco_utenti (MYSQL *); 
void visualizza_spj(MYSQL *);
void visualizza_stato_avanzamenti(MYSQL *);
void termina_con_errore (MYSQL *);
void inserisci_progetto(MYSQL *,int); 
/*TERMINE DICHIARAZIONE FUNZIONI*/

/*FUNZIONE PRINCIPALE DI UTILIZZO DEL DB, 
 * VIENE RICHIAMATO IL MENU DAL QUALE E'
 * POSSIBILE LA SCELTA DI QUERY*/
void gestione_db ( char *host_name, char *user_name, char *password , unsigned int port_num , char *socket_name , char *db_name , unsigned int flags )

{


    MYSQL *conn;
    conn = mysql_init (NULL);// inizializza il gestore della connessione
    int scelta=0;
   

    if (conn == NULL)
    { fprintf (stderr, "Errore: inizializzazione fallita, impossibile stabilire una connessione con il server\n");}

    if (mysql_real_connect (conn, host_name, user_name, password, db_name, port_num, socket_name, flags) == NULL)
    { termina_con_errore(conn); }
    
    else printf (" Connessione al DB %s avvenuta con successo\n", db_name);
		
	while(scelta!=6) scelta=menu_opzioni(conn);/* menu a scelta finoa a quando non viene premuto il tasto di 							      uscita*/
}

/*FUNZIONE DI SELEZIONE MENU ED ESECUZIONE QUERY*/
int menu_opzioni(MYSQL *conn)

{ 
  int id_creatore=0;
  int scelta;
  printf("\n 1:REGISTRARE UN NUOVO UTENTE\n");
  printf("\n 2:INSERISCI UN NUOVO PROGETTO\n");
  printf("\n 3:VISUALIZZARE L'ELENCO DEGLI UTENTI REGISTRATI\n");
  printf("\n 4:VISUALIZZARE GLI UTENTI CHE POSSIEDONO LE COMPETENZE RICHIESTE DAL PROGETTO\n");
  printf("\n 5:VISUALIZZARE LO STATO DI AVANZAMENTO DEI SOTTO PROGETTI\n");
  printf("\n 6:USCITA GESTIONE DATA BASE\n");
  printf("\n Effettuare una scelta tra quelle indicate:");
  scanf("%d",&scelta);

  switch(scelta)
  { 
    case 1:
      crea_utente (conn); 
      return 1;
    
   case 2:
      printf ("\nInserire simulazione utente id_creatore da passare alla funzione: ");
      scanf ("%d",&id_creatore);
      inserisci_progetto(conn, id_creatore); 
      return 2;
            
    case 3:
      visualizza_elenco_utenti(conn); 
      return 3;
      
    case 4:
      visualizza_spj(conn); 
      return 4;
   
    case 5:
      visualizza_stato_avanzamenti (conn); 
      return 5;
   
    case 6:
      printf("\nUscita dal programma e disconnessione DB\n");
      disconnessione_DB (conn);
      return 6;  
  }
  return 0;
  
}


/*FUNZIONE DI INSERIMENTO DATI UTENTE DEL DB*/

void crea_utente(MYSQL *conn) 
{ 
  /* dichiarazione variabili */ 
  char nome_utente[20];
  char password[20];
  char nome[20];
  char cognome[20];
  char sesso[2];
  char data_di_nascita[20];
  /*MYSQL_TIME data_ins; sruttura DATA di mysql */
  char professione[20];
  char cittadinanza[20];
  char lingua[20];
  char insert_buffer [1024];/* strings supposto inserimento valori*/
  /*termine dichiarazione variabili*/
  
  
  /*INSERIMENTO VALORI UTENTE */
  printf("\nInserisci i dati utente: ");
  
  printf ("\n- nome_utente desiderato (nick_name): ");
  scanf ("%s",nome_utente);
 
  printf ("\n- password: ");
  scanf ("%s",password);
 
  printf ("\n- nome: " );
  scanf ("%s",nome);
  
  printf("\n- cognome: "); 
  scanf ("%s",cognome);

  printf("\n- sesso: "); 
  scanf ("%s",sesso);

  printf("\n- inserisci data di nascita (YYYY-MM-DD): \n");
  scanf ("%s",data_di_nascita);

  printf("\n- professione: "); 
  scanf ("%s",professione);
 
  printf("\n- cittadinanza: "); 
  scanf ("%s",cittadinanza);
 
  printf("\n- lingua: "); 
  scanf ("%s",lingua);
  /* TERMINE INSERIMENTO VALORI*/
  
  
  sprintf (insert_buffer,"INSERT INTO utente_registrato VALUES (' ','%s','%s','%s','%s','%s','%s','%s','%s','%s')",nome_utente,password,nome,cognome,sesso,data_di_nascita,professione,cittadinanza,lingua);
   
  if (mysql_query(conn, insert_buffer)) {termina_con_errore(conn);}

}

/*visualizza l'elenco di tutti gli utenti*/
void visualizza_elenco_utenti (MYSQL *conn)
{
    MYSQL_RES *risultati;
    int num_campi = 0;
    MYSQL_ROW row;
    int i=0;
  
 printf ("\n ELENCO DEGLI UTENTI DISPONIBILI DEL DB:\n\n");
  if (mysql_query(conn, "SELECT * from utente_registrato")) {termina_con_errore(conn);}
  
   risultati=mysql_store_result(conn);
   num_campi= mysql_num_fields(risultati);
  while((row = mysql_fetch_row(risultati)))
  {
    for( i=0; i < num_campi; i++) /* stampa i risultati a schermo*/
      { 
          printf("%16s|", row[i] ? row[i] : "NULL"); 
      } 
          printf("\n");    
   }  
   mysql_free_result(risultati);/* libera i risultati trovati*/
}

/* Trovare quali utenti possiedono le competenze richieste dal progetto
 * definito dall'utente. La tabella deve contenere il nome_utente , 
 * la competenza posseduta dall'utente  richiesta da almeno uno dei sotto 
 * progetti definiti per il progetto richiesto*/

void visualizza_spj(MYSQL *conn)
{ 
   MYSQL_RES *risultati;
   int num_campi = 0;
   MYSQL_ROW row;
   int i=0;
   char insert_buffer[1024];/* stringa temporanea*/
   int numero_progetto=0;
  
  printf("\nSCEGLIERE id_PROGETTO:");
  scanf ("%d",&numero_progetto);
  
  printf ("\n ELENCO DEGLI UTENTI CHE POSSIEDONO LE COMPETENZE SPECIFICHE PER IL PROGETTO ID_%d:\n\n", numero_progetto); 
  
/*RIASSEMBLO LA STRINGA DA PASSARE AL DB*/
sprintf (insert_buffer,"SELECT  nome_utente 'Username', competenze.nome_c 'Competenza richiesta posseduta' FROM utente_registrato,possesso_c,competenze WHERE (competenze.id_comp=possesso_c.id_competenza) AND( utente_registrato.id_utente=possesso_c.id_utente) AND possesso_c.id_competenza IN (SELECT id_comp from uso_competenza WHERE id_sotto_pj IN (SELECT id_sotto_pj from composizione_pj WHERE id_progetto=%d))",numero_progetto);

if (mysql_query(conn, insert_buffer)) {termina_con_errore(conn);}
  
  /*formattazione dei risultati trovati*/
   risultati=mysql_store_result(conn);
   num_campi= mysql_num_fields(risultati);
 
   while((row = mysql_fetch_row(risultati)))
  {
    for( i=0; i < num_campi; i++) /* stampa i risultati a schermo*/
      { 
          printf("%19s|", row[i] ? row[i] : "NULL"); 
      } 
          printf("\n");    
   }
   
   mysql_free_result(risultati);/* libera i risultati trovati*/
}

/*visualizza lo stato di avanzamento dei progetti come
 * media dello stato di ogni sotto progetto che gli appartiene*/

void visualizza_stato_avanzamenti(MYSQL *conn)
{
  MYSQL_RES *risultati;
   int num_campi = 0;
   MYSQL_ROW row;
   int i=0;

   printf ("\n STATO DI AVANZAMENTO DEI SOTTO PROGETTI DB:\n");


if (mysql_query(conn, "SELECT nome_progetto , AVG(sotto_progetto.stato_avanzamento_spj) 'stato % avanzamento del progetto'FROM progetto , composizione_pj, sotto_progetto WHERE (progetto.id_project = composizione_pj.id_progetto AND sotto_progetto.id_sotto_progetto= id_sotto_pj) GROUP BY (nome_progetto)")) 

{termina_con_errore(conn);}/* TERMINA LA CONNESSIONE RIPORTANDO L'ERRORE*/

  /*formattazione dei risultati trovati*/
   risultati=mysql_store_result(conn);
   num_campi= mysql_num_fields(risultati);
  
   while((row = mysql_fetch_row(risultati)))
  {
    for( i=0; i < num_campi; i++) /* stampa i risultati a schermo*/
      { 
          printf("%19s|", row[i] ? row[i] : "NULL"); 
      } 
          printf("\n");    
  }
   
   mysql_free_result(risultati);/* libera i risultati trovati*/ 
}

void termina_con_errore (MYSQL *conn) /* stampa l'errore riportato da mysql ed esce*/
{
  fprintf (stderr, "Errore %u (%s): %s\n", mysql_errno (conn), mysql_sqlstate(conn), mysql_error (conn));
  mysql_close(conn);
  exit(1);    
}

/*funzione di disconnessione senza errore*/
void disconnessione_DB (MYSQL *conn)
{
	/* disconnessione */
	mysql_close (conn);
	printf ("\n Disconnessione avvenuta\n");
}

/*funzione inserimento di un progetto: 
 * per lo sviluppo di questa funzione è necessario 
 * simulare l'id utente che richiede l'inserimento
 * inoltre l'utente che inserisce il progetto diviene 
 * automaticamente il PM iniziale del progetto,
 * e va pertanto inserito nelle tabelle previste
 * assegandogli l'incarico di PM*/

void inserisci_progetto(MYSQL *conn, int id_creatore)
{
   time_t tempo;
   struct tm time_struct;
   struct tm * time_struct_sup;
   char data_di_creazione[20];
   char dir_lavoro_radice [30];
   char specifiche_tecniche[4096];
   char nome_progetto[30];
   char insert_buffer[4200];
   char insert_buffer1[10];
    
   /*INSERIMENTO DEI DATI NEL DB*/
   time(&tempo); /* assegnazione del tempo attuale */
   
   time_struct_sup =localtime_r (&tempo,&time_struct);
   /*definizione della stringa DATA*/
   sprintf (data_di_creazione,"%d-%d-%d",(time_struct_sup->tm_year)+1900,((time_struct_sup->tm_mon)+1), time_struct_sup->tm_mday);
   
   /* inserimento del progetto con i dati */
   printf("\nInserisci il nome del progetto: ");
   while(getchar() != '\n');
   fgets (nome_progetto,29,stdin);
   nome_progetto[strlen(nome_progetto)-1]='\0';
   /*----------------------------------------*/
   
   /*la dir di lavoro viene creata in automatico grazie al nome del progetto*/
   /* non ci possono pertanto esere due nomi progetto identici*/
   sprintf (dir_lavoro_radice,"/home/progetti/%s",nome_progetto);
   /*-------------------------------------------*/
   
   /*inserimento specifiche tecniche*/
   printf("\nInserisci le specifiche tecniche del progetto [termina con INVIO]: ");
   fgets (specifiche_tecniche,4095,stdin);
   specifiche_tecniche[strlen(specifiche_tecniche)-1]='\0';
   /*----------------------------------*/
   
   /*inserisci dati in tabella progetto*/
   sprintf(insert_buffer,"INSERT INTO progetto VALUES (' ','%s', '%s','%d','%s','%s');",dir_lavoro_radice,nome_progetto,id_creatore,specifiche_tecniche,data_di_creazione);
   if (mysql_query(conn, insert_buffer)) termina_con_errore(conn);
   int ultimo_id_progetto = mysql_insert_id(conn);/* salvataggio dell'ultimo ID di progetto*/
   /*-------------------------------------*/
     
   /*inserisci i dati nella tabella incaricato*/
   printf("\nL'utente ideatore assume l'incarico di PM\n");
   sprintf(insert_buffer1,"INSERT INTO incaricato VALUES (' ','%d','1');",id_creatore); /* l'utente prende l'incarico di valore 1*/
   printf ("%s",insert_buffer1);
   if (mysql_query(conn, insert_buffer1)) termina_con_errore(conn);
   else printf ("\nAssunzione dell'incarico avvenuta con successo, record salvato in tabella\n");
    int ultimo_id_utente_incaricato = mysql_insert_id(conn);
   /*-------------------------------------------*/
  
   /*inserisci i dati nella tabella incarico_di_prgetto*/
   printf("\nL'utente incaricato PM viene inserito nell'elenco dei PM del progetto\n");
   sprintf(insert_buffer1,"INSERT INTO incarico_di_progetto VALUES (' ' ,'%d','%d')",ultimo_id_utente_incaricato,ultimo_id_progetto);
   printf ("%s",insert_buffer1);
   if (mysql_query(conn, insert_buffer1)) termina_con_errore(conn);
    /*--------------------------------------------------*/

  
}

