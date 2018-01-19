#
# PROYECTO ** SIMULACION Y TEORIA DE COLAS **
#
# TEMA:
#     Generador de numeros aleatorios con
#     pruebas de uniformidad (Test de Kolmogorov) 
#     e independencia (Prueba de Corridas)
#
# AUTORES: D4N13L
#
# VERSION:  1.0   -   15/01/2018
# 

# Funci?n que realiza el test de corridas (Por arriba y por abajo del promedia es decir + > 0.5 y - <= 0.5)
#   Zcal: Valor de z para hipotesis nula calculado
#   Ztab: Valor z de la tbla obtenido mediante la funcion QNORN() de R
#   aplha2: Valor de alpha a dos colas para obtener Ztab
#   np: Corridas positivas 
#   nn: Corridas negativas
#   nc: Numero de corridas
# La formulas que sigue es: 
#         media = ((2*np*nn)/(np+nn))+(1)
#         var= ((2*np*nn)*(2*np*nn-(np+nn)))/(((np+nn)^2)*((np+nn)-1))
#         Zcalc= (nc-media)/sqrt(var)


testCorridas<-function(aleatorios,alpha){
  media <- NULL ## Variable para la media
  var <- NULL ## Variable para la varianza
  alpha2 <- NULL ## Variable para el alpha/2
  Zcal <- NULL ## Variable para el z calculado
  Ztab <- NULL ## Variable para el z de la tabla
  mensaje <- ""
  np <- 0 ## Numero de repeticiones positivas (mayores que 0.5)
  nn <- 0 ## Numero de repeticiones Negaticas (menores que 0.5)
  nc <- 1 ## Numero de corridas
  bandera <- 1 # Bandera para estado de la corridas
  corridas <- NULL ## Arreglo para guardar las corridas (1 y 0)
  frecuencia <- NULL
  
  tc <- NULL  #Para trabajar con el vector de aleatorios
  tc$dato <- aleatorios #Asignamos el vector
  
  ## Bucle para determinr el numero de corridas y contar cuantas son + y -
  for(i in 1:length(tc$dato)){
    if(tc$dato[i]>0.5){ ## Determina si son mayores que 0.5 (POSITIVAS)
      np<-np+1  ## Incrementa en 1 el contador de positivas
      corridas$data[i]<-1  ## Guarda en un arreglo el valor obtenido (POSITIVA = 1)
    }else{ ##Determina si son manores que 0.5 (NEGATIVAS)
      nn<-nn+1  ## Incrementa en 1 el contador de negativas
      corridas$data[i]<-0  ## Guarda en un arreglo el valor obtenido (NEGATIVAS = 0)
    }
    {if(corridas$data[i]!=bandera){ ## Verifica el estado de la corrida 1 o 0 para determinar las corridas
      nc=nc+1  ## Incrementa en 1 el numero de corridas 
      bandera<- corridas$data[i] ## Cambia el estado de la bandera
    }}
  }
  
  media <- ((2*np*nn)/(np+nn))+(1); ## Calculamos el valor de la media
  var <- ((2*np*nn)*(2*np*nn-(np+nn)))/(((np+nn)^2)*((np+nn)-1)); ## Calculamos la varianza
  Zcal <- (nc-media)/sqrt(var); ## Obtenemos el valor de Z calculado
  
  alpha2 <- alpha/2 # Calculamos alpha/2
  Ztab <- abs(qnorm(alpha2)) ## Calculamos el Z de la tabla a dos colas las probabilidades de la tabla
  
  ## Verifica las hipotesis para determinar si son aleatorios
  if(Zcal<Ztab && Zcal>-Ztab){
    mensaje <- "Son independientes, por tanto ?SON ALEATORIOS!"
  }else{
    mensaje <-"No son independientes por tanto ?NO SON ALEATORIOS!"}
  
  ## GENERA VALORES DE FRECUENCAS CADA 10 CORRIDAS (NO RELEVANTE)
  frecuencia <- matrix(corridas$data, ncol=10, byrow = TRUE)
  Nfrec <- NULL ##Vector de frecuencias
  s<-1
  for(i in 1:length(frecuencia[,1])){
    for(j in 1:(length(frecuencia[1,])-1)){
      if(frecuencia[i,j]!=frecuencia[i,j+1]){
        s<-s+1  ## Contador de frecuencias
      }
    }
    Nfrec$f[i]<-s # Guardamos la suma
    s<-1 # Reiniciamos contador
  }
  
  ## Retornamos los valores necesarios
  return(list(frecuencia=frecuencia, Zcal=Zcal, Ztab = Ztab,media = media, var=var,np=np, nn=nn, nc=nc, mensaje= mensaje))
}