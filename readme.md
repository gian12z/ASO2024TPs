TP3
1-a- Con respecto al tiempo de ejecucion se puede notar a simple vista que el codigo conhilos tiene un tiempo de ejecucion muy menor comparado el codigo sinhilos. No es predecible el tiempo ya que cada vez que lo ejecutamos es diferente a el tiempo anterior.
b- Si lo comparo con mis compañeros los tiempos de ejecucion son muy parecidos pero no iguales, siempre son diferentes.
c- Ejecucion del archivo suma_resta.py
Observaciones
Codigo original: En la primera versión del código, los dos hilos trabajan con la variable "acumulador" sin coordinarse. Esto puede causar un problema llamado "carrera crítica", donde los hilos compiten por acceder y cambiar "acumulador", lo que lleva a resultados impredecibles.
Codigo modificado: Al eliminar los comentarios, las acciones de sumar y restar en los hilos continúan sin coordinarse, lo que empeora el problema.
2-a A continuacion esta el codigo corregido:


#include <pthread.h>
#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>

#define NUMBER_OF_THREADS 2
#define CANTIDAD_INICIAL_HAMBURGUESAS 8
int cantidad_restante_hamburguesas = CANTIDAD_INICIAL_HAMBURGUESAS;

int turno = 0;

void *comer_hamburguesa(void *tid)
{
    intptr_t id = (intptr_t) tid;
    while (1 == 1)
    {
        while (turno != id);

        if (cantidad_restante_hamburguesas > 0)
        {
            printf("Hola! soy el hilo(comensal) %ld , me voy a comer una hamburguesa ! ya que todavia queda/n %d \n", id, cantidad_restante_hamburguesas);
            cantidad_restante_hamburguesas--;
        }
        else
        {
            printf("SE TERMINARON LAS HAMBURGUESAS :( \n");
            turno = (turno + 1) % NUMBER_OF_THREADS;
            pthread_exit(NULL);
        }

        turno = (turno + 1) % NUMBER_OF_THREADS;
    }
}

int main(int argc, char *argv[])
{
    pthread_t threads[NUMBER_OF_THREADS];
    int status, i, ret;
    for (i = 0; i < NUMBER_OF_THREADS; i++)
    {
        printf("Hola!, soy el hilo principal. Estoy creando el hilo %d \n", i);
        status = pthread_create(&threads[i], NULL, comer_hamburguesa, (void *)(intptr_t)i);
        if (status != 0)
        {
            printf("Algo salio mal, al crear el hilo recibi el codigo de error %d \n", status);
            exit(-1);
        }
    }

    for (i = 0; i < NUMBER_OF_THREADS; i++)
    {
        void *retval;
        ret = pthread_join(threads[i], &retval);
    }
    pthread_exit(NULL);
}
b-
[diagrama_de_flujo.pdf](https://github.com/user-attachments/files/15794089/diagrama_de_flujo.pdf)




