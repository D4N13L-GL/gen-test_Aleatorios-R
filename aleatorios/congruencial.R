#
# PROYECTO ** SIMULACION Y TEORIA DE COLAS **
#
# TEMA:
#     Generador de numeros aleatorios con
#     pruebas de uniformidad (Test de Kolmogorov) 
#     e independencia (Prueba de Corridas)
#
# AUTORES:  D4N13L
#
# VERSION:  1.0   -   15/01/2018
# 

# Funcion que genera los numeros aleatorios:
#   a: Constante
#   m: modulo
#   xo: semilla
#   n: cantidad de aleatorios
# La formula que sigue es: Xn+1=(a*xo) mod m


congruencial<-function(a,m,xo,n){
  aleatorios <- NULL  ## Definimos nuestro vector de aleatorios
  for(i in 1:n){
    x<- (a*xo) %% m ## Calculamos el Xn+1 con la formula
    aleatorios[i] <- x/(m-1)  ## Generamos el aleatorio X/(mod-1)
    xo <- x ## Asignamos el nuevo valor de Xn+1 como semilla
  }
  return(aleatorios) ## Retorna el vector de aleatorios
}