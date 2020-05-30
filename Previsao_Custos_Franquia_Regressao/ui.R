#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(

    # Application title
    titlePanel("Previsão de Custo Inicial para Montar uma Franquia"),
    fluidRow(
        column(4,
               h2("Dados"),
               tableOutput("Dados")
        ),
        column(8,
               plotOutput('Graf')
        )
    ),
    fluidRow(
        column(6,
               h3("Valor Anual da Franquia"),
               numericInput("NovoValor", "Insira Novo Valor", 1500, min = 1, max = 99999999999999),
               actionButton("Processar", "Processar")
        ),
        column(6,
               h1(textOutput("Resultado"))
        )
    )
))
