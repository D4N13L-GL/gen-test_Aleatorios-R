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

# Funci?n que realiza el test de kolmogorv y devuelve estadistico de prueba Dmax 
#   n: Numero de aleatorios
#   i: Sub indice (iterador)
#   fi: Distribucion acumulada de elemento i
#   Xi: Numero aleatorio de posicion i
#   Dx: Valor absuluto de la diferencia de de fi-xi
#   Dmax : Estdistico de prueba es decir el Max(Dx)
#   
# La formulas del algoritmo son: 
#   : fi = i/n frecuencia acumulada
#   : Dx = abs(Xi-fi)
#   : DMax = Max(Dx)


testKs<-function(aleatorios,alpha){
  mensaje<-""
  Dmax1<-0
  Dmax2<-0
  Pvalor<-0
  ks = NULL
  ks$dato <- aleatorios
  ks$dato <- sort(ks$dato) ## Ordena el arreglo con el metodo SORT
  ks$fi<-NULL
  ks$Dx<-NULL
  
  ## Realiza el test construyendo la tabla
  for(i in 1:length(ks$dato)){
    ks$fi[i] <- i/length(ks$dato)  ## Calculamos el F(Xi) de cada Xi
    ks$Dx[i] <- abs(ks$dato[i]-ks$fi[i]) ##Calculamos la diferencia y el valor absoluto entre |Xi-F(Xi)|
    ## Determina el maxio de los valores de |Xi-F(Xi)|
    if(Dmax1<ks$Dx[i]){
      Dmax1=ks$Dx[i]
    }
  }
  KSp <- ks.test(ks$dato,punif,alpha) ## Realiza el test con alpha definido
  KSp1 <- ks.test(ks$dato,"punif") ## Realiza el test sin un alpha
  Dmax2<-KSp1$statistic ## Devuelve el valor del estadistico con la funcion ks.test
  Pvalor<- KSp$p.value  ## Devuelve el p valor con la funcion ks.test
  
  ## Verifica las hipotesis para determinar si son aleatorios
  if(Dmax1<Pvalor){
    mensaje <- "Se distribuyen uniformemente, por tanto ?SON ALEATORIOS!"
  }else{
    mensaje <-"No se distribuyen uniformemente, por tanto ?NO SON ALEATORIOS!"}
  
  ## Retorna los parametros necesarios
  return(list(data=ks, Dmax1=Dmax1, Dmax2=Dmax2, Pvalor=Pvalor, resultado=mensaje))
}