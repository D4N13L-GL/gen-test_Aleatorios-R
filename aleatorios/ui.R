#
# PROYECTO ** SIMULACION Y TEORIA DE COLAS **
#
# TEMA:
#     Generador de numeros aleatorios con
#     pruebas de uniformidad (Test de Kolmogorov) 
#     e independencia (Prueba de Corridas)
#
# AUTORES:  D4N1EL
#
# VERSION:  1.0   -   15/01/2018
# 

library(shiny)
library(DT)

# Define UI for application
shinyUI(fluidPage(
  
  # Titulo de la Aplicacion
  titlePanel("Generador de Numeros Aleatorios"),
  
  #Para crear los tabs.
  tabsetPanel(
    ## Tab en la que se genera los aleatorios
    tabPanel("Numeros Aleatorios",
             sidebarLayout(
               sidebarPanel(
                 ## Barra para seleccionar el numero de aleatorios deseados
                 sliderInput("na",
                             "Cantidad de Aleatorios:",
                             min = 0,
                             max = 1000000,
                             value = 100,
                             step =10),
                 
                 ## Campo para ingresar el valor del modulo
                 numericInput("mod",label = "Modulo:",value = "2147483647"),
                 
                 ## Campo para ingresar el valor de la constante A
                 numericInput("a",label = "Constante A:",value = "16807"),
                 
                 ## Campo para ingresar el valor de la semilla
                 numericInput("xo",label = "Semilla:",value = "94837"),
                 
                 ##Boton para generar los numeros numeros aleatorios
                 actionButton("aleatorios",label = "Generar Aleatorios"),
                 
                 ##PROBANDOOOOO KS *************
                 helpText("PARAMETROS PARA EL TEST DE KOLMOGOROV"),
                 ## Barra para seleccionar el nivel de significancia
                 sliderInput("alphaKS",
                             "Nivel de Significancia Kolmogorov:",
                             min = 0,
                             max = 1,
                             value = 0.1,
                             step = 0.0001),
                 
                 helpText("PARAMETROS PARA EL TEST DE CORRIDAS"),
                 ##PROBANDOOOOO TC *************
                 sliderInput("alphaTC",
                             "Nivel de Significancia Corridas:",
                             min = 0,
                             max = 1,
                             value = 0.1,
                             step = 0.0001)
                 
               ),
               
               
               
               # Show a plot of the generated distribution
               mainPanel(
                 fluidRow(
                   column(plotOutput("distPlot")
                          ,width = 6),
                   column(DT::dataTableOutput("listAleatorios") 
                          ,width = 6)
                 ),
                 
                 ##PROBANDO FUNCIONAMIENTOOO KS***********
                 fluidRow(
                   column(
                     helpText("RESULTADOS DEL TEST"),
                     textOutput("Dmax")
                     ,width = 4),
                   column(DT::dataTableOutput("frecuencias") 
                          ,width = 8)
                 ),
                 ##PROBANDO FUNCIONAMIENTOOO KS***********
                 fluidRow(
                   column(
                     helpText("RESULTADOS DEL TEST"),
                     #verbatimTextOutput("ValTC"),
                     textOutput("ValTC")
                     ,width = 4),
                   column(DT::dataTableOutput("corridas") 
                          ,width = 8)
                 )
               )
             )),
    
    ## Tab en la que se realiza el test de Uniformidad
    tabPanel("Prueba de Uniformidad",
             #             sidebarLayout(
             #               sidebarPanel(
             #                 ## Barra para seleccionar el nivel de significancia
             #                 sliderInput("alphaKS",
             #                             "Nivel de Significancia:",
             #                             min = 1,
             #                             max = 100,
             #                             value = 95,
             #                             step = 0.0001),
             #                 
             #                 ##Boton para realizar el tes de Kolmogorv Smirnov
             #                 actionButton("testKS",label = "Realizar Test")
             #               ),
             #               
             #               
             #               # Show a plot of the generated distribution
             #               mainPanel(
             #                 fluidRow(
             #                   column(plotOutput("ksPlot")
             #                          ,width = 6),
             #                   column(DT::dataTableOutput("frecuencias") 
             #                          ,width = 6)
             #                 )
             #               )
             #             #)
             "Content" ),
    
    ## Tab en la que se realiza el test de Independencia
    tabPanel("Prueba de Independencia","contents")
  )
))
