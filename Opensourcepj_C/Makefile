#makefile 
CC = gcc
PARMAIN = -ansi -Wall -o
PAROGG  = -Wall -Werror -c 
LIBFILEC = opensourcepj.c
LIBFILEO = opensourcepj.o
OUT = main_ospj
INCLUDES = ${shell mysql_config --cflags}
LIBS = ${shell mysql_config --libs}

tutti: 
	@echo
	@echo Inizio compilazione files
	@echo 
	$(CC) $(PAROGG) $(OUT).c $(INCLUDES)
	$(CC) $(PAROGG) $(LIBFILEC)  $(INCLUDES)
	$(CC) $(PARMAIN) $(OUT) $(OUT).o $(LIBFILEO) $(LIBS)

rimuovi:
	@echo  
	@echo Pulizia file oggetto...
	@echo
	rm -f *.o

