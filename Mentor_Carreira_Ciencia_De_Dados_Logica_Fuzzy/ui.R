library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(

    # Application title
    titlePanel("Aderência de Perfil para a Carreira de Cientista de Dados"),
    helpText('Selecione valores utilizando os sliders de acordo com as suas características pessoais e clique em processar.'),
    
    fluidRow(
        column(4,
               sliderInput("sexatas", 
                           "Gosto por Exatas", 
                           min = 5, 
                           max = 90, 
                           sep=10, 
                           value = 40)),
        column(4,
               sliderInput("sinter", 
                           "Relacionamento Interpessoal", 
                           min = 30, 
                           max = 85, 
                           sep=5, 
                           value = 50)),
        column(4,
               sliderInput("scodigo", 
                           "Gosto por Escrever Código", 
                           min = 10, 
                           max = 95, 
                           sep=5, 
                           value = 40))
    ),
    fluidRow(
        column(4,
               sliderInput("slider", 
                           "Perfil de Liderança", 
                           min = 30, 
                           max = 95, 
                           sep=5, 
                           value = 50)),
        column(4, 
               sliderInput("sestudar", 
                           "Gosta de Estudar", 
                           min = 20, 
                           max = 90, 
                           sep=10, 
                           value = 40)
               ),
        column(4,
               sliderInput("scomunica", 
                           "Habilidade de Comunicação", 
                           min = 40, 
                           max = 75, 
                           sep=5, 
                           value = 50))
    ),
    fluidRow(
        column(6,
               h1("Sistema: "),
               plotOutput("GrafSistema")),
        column(6,
               actionButton("Processar", "Processar"),
               helpText("A linha vermelha mostra a sua aderência a profissão de Cientista de Dados"),
               plotOutput("GrafResultado"))
    )
    
))
