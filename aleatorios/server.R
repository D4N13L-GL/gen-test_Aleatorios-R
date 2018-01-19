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

## Carga librerias necesaras
library(shiny)

## Carga metodos creados
source("congruencial.R", local=TRUE)
source("testKS.R", local=TRUE)
source("testCorridas.R", local=TRUE)

# Define server logic para la logica de la aplicacion
shinyServer(function(input, output) {
  
  x <- reactiveValues(data = NULL)
  #x <- reactiveValues(ksdata=NULL)
  
  ## Determina la accion a ejecutar en el evento del boton
  observeEvent(input$aleatorios, {
    x$data <- congruencial(a = as.numeric(input$a), m = input$mod,xo = as.numeric(input$xo),n = input$na)
    ##ksval <- testKs(aleatorios = x$data,alpha=as.numeric(input$alphaKS))
  })
  observeEvent(input$testKS,{
    #if (!is.null(x$data)){
    #}
  })
  
  # Renderiza el area donde se va a dibujar el histograma
  output$distPlot <- renderPlot({
    # Dibuja el histograma de los numeros aleatorios
    if (is.null(x$data)) return()
    hist(x$data, col = 'darkgray', border = 'white')
    
  })
  
  #Renderiza el datatable para cargar los datos
  output$listAleatorios <- DT::renderDataTable({
    DT::datatable({
      data.frame(x$data) #Visualiza los numeros aleatorios en un dataTable 
    })
  })
  
  # Renderiza el los resultados de kolmogorov
  output$Dmax <- renderText({
    if (is.null(x$data)) return()
    # Dibuja el histograma de los numeros aleatorios
    ##if (is.null(ksval$data$dato)) return()
    ksval <- testKs(aleatorios = x$data,alpha=as.numeric(input$alphaKS))
    res<-paste("VAlor de D observado: ",as.character(ksval$Dmax1),
               "Valor de D Tabla: ", as.character(ksval$Pvalor),
               "Resultado del Estadistico: ", as.character(ksval$resultado))
    
    print(as.character(ksval$resultado))
    
    
  })
  
  #Renderiza el datatable de la tabla de kolmogorov
  output$frecuencias <- DT::renderDataTable({
    if (is.null(x$data)) return()
    ksval <- testKs(aleatorios = x$data,alpha=as.numeric(input$alphaKS))
    DT::datatable({
      data.frame(ksval$data) #Visualiza los numeros aleatorios en un dataTable 
    })
  })
  
  # Renderiza el los resultados de Corridas
  output$ValTC <- renderPrint({
    if (is.null(x$data)) return()
    # Dibuja el histograma de los numeros aleatorios
    ##if (is.null(ksval$data$dato)) return()
    ctval <- testCorridas(aleatorios = x$data,alpha=as.numeric(input$alphaTC))
    print(as.character(ctval$Zcal))
    print(as.character(ctval$Ztab))
    print(as.character(ctval$mensaje))
    
  })
  
  #Renderiza el datatable de la tabla de Corridas
  output$corridas <- DT::renderDataTable({
    if (is.null(x$data)) return()
    ctval <- testCorridas(aleatorios = x$data,alpha=as.numeric(input$alphaTC))
    DT::datatable({
      data.frame(ctval$frecuencia) #Visualiza los numeros aleatorios en un dataTable 
    })
  })
  
  
})
