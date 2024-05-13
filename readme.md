TP3
1-a- Con respecto al tiempo de ejecucion se puede notar a simple vista que el codigo conhilos tiene un tiempo de ejecucion muy menor comparado el codigo sinhilos. No es predecible el tiempo ya que cada vez que lo ejecutamos es diferente a el tiempo anterior.
b- Si lo comparo con mis compañeros los tiempos de ejecucion son muy parecidos pero no iguales, siempre son diferentes.
c- Lo que paso fue que al eliminar el # y descomentar las lineas el tiempo de ejecucion aumento en comparacion a cuando las lineas 11, 12, 19 y 20 estaban comentadas. Esto sucede porque la linea comentada lo que hace es ejecutar el acumulador 1000 veces, por eso cuando esta comentada el tiempo de ejecucion es menor, porque no se ejecuta el acumulador esas 1000 veces.

2-a A continuacion esta el codigo con las lineas faltantes:
#include <pthread.h>
#include <stdio.h>
#include <stdlib.h>

#define NUMBER_OF_THREADS 2
#define CANTIDAD_INICIAL_HAMBURGUESAS 20

int cantidad_restante_hamburguesas = CANTIDAD_INICIAL_HAMBURGUESAS;
int turno = 0; // Esta linea sirve para declarar la variable turno

void *comer_hamburguesa(void *tid)
{
    while (1 == 1)
    { 
        while(turno!=(int)tid); // Esta linea agreagada sirve para esperar hasta que sea el turno del hilo
        // INICIO DE LA ZONA CRÍTICA
        if (cantidad_restante_hamburguesas > 0)
        {
            printf("Hola! soy el hilo(comensal) %d , me voy a comer una hamburguesa ! ya que todavia queda/n %d \n", (int) tid, cantidad_restante_hamburguesas);
            cantidad_restante_hamburguesas--; // me como una hamburguesa
        }
        else
        {
            printf("SE TERMINARON LAS HAMBURGUESAS :( \n");
            pthread_exit(NULL); // forzar terminacion del hilo
        }
        // SALIDA DE LA ZONA CRÍTICA
        turno = (turno + 1) % NUMBER_OF_THREADS; // Esta linea que agregamos sirve para cambiar el turno
    }
}

int main(int argc, char *argv[])
{
    pthread_t threads[NUMBER_OF_THREADS];
    int status, i, ret;

    for (i = 0; i < NUMBER_OF_THREADS; i++)
    {
        printf("Hola!, soy el hilo principal. Estoy creando el hilo %d \n", i);
        status = pthread_create(&threads[i], NULL, comer_hamburguesa, (void *)i);
        if (status != 0)
        {
            printf("Algo salio mal, al crear el hilo recibi el codigo de error %d \n", status);
            exit(-1);
        }
    }

    for (i = 0; i < NUMBER_OF_THREADS; i++)
    {
        void *retval;
        ret = pthread_join(threads[i], &retval); // espero por la terminacion de los hilos que cree
    }
    pthread_exit(NULL); // como los hilos que cree ya terminaron de ejecutarse, termino yo tambien.
}
b-
