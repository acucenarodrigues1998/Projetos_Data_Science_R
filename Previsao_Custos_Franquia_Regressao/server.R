library(shiny)

dados = read.csv("slr12.csv", sep = ";")
modelo = lm(CusInic ~ FrqAnual, data = dados)

shinyServer(function(input, output) {

    output$Graf = renderPlot({
        plot(CusInic ~ FrqAnual, data = dados)
        abline(modelo)
    })
    
    output$Dados = renderTable({
        head(dados, 10)
    })
    
    observeEvent(input$Processar, {
        valr =  input$NovoValor 
        prev =  predict(modelo,data.frame(FrqAnual = eval(parse(text = valr))))
        prev = paste0("Previsão de Custo Inicial R$: ",round(prev,2))
        output$Resultado = renderText({prev})
    })

})
