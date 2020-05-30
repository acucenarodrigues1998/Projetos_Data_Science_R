library(shiny)
library(sets)

sets_options("universe", seq(1,100, 1))

variaveis <- set(
    Gosta_exatas = fuzzy_partition(varnames = c(gemin = 5, gemen = 15, gemed = 50, gemaior = 75, gemax = 90), sd = 10),
    Rel_interpess = fuzzy_partition(varnames = c(rimin = 30, rimen = 35, rimed = 55, rimaior = 75, rimax = 85), sd = 10),
    Escre_codigo = fuzzy_partition(varnames = c(ecmin = 10, ecmen = 25, ecmed = 50, ecmaior = 75, ecmax = 95),  sd = 10),
    Perfil_lider = fuzzy_partition(varnames = c(plmin = 30, plmen = 50, plmed = 70, plmaior = 90, plmax = 95), sd = 10),
    Gosta_Estudar = fuzzy_partition(varnames = c(gsmin = 20, gsmen = 40, gsmed = 60, gsmaior = 80, gsmax = 90), sd = 10),
    Habilidade_comunica = fuzzy_partition(varnames = c(hcmin = 40, hcmen = 50, hcmed = 60, hcmaior = 70, hcmax = 75), sd = 10),
    Classificacao = fuzzy_partition(varnames = c(baixa = 10, media = 50, alta = 75, altissima = 95), sd = 10)
)

regras <-
    set(
        fuzzy_rule( Gosta_exatas %is%	gemax	&& Rel_interpess %is%	rimin	&& Escre_codigo %is%	ecmax	&& Perfil_lider %is%	plmin	&& Gosta_Estudar %is%	gsmax	&& Habilidade_comunica %is%	hcmin	, Classificacao %is%	altissima	),
        fuzzy_rule( Gosta_exatas %is%	gemax	&& Rel_interpess %is%	rimen	&& Escre_codigo %is%	ecmaior	&& Perfil_lider %is%	plmin	&& Gosta_Estudar %is%	gsmax	&& Habilidade_comunica %is%	hcmen	, Classificacao %is%	altissima	),
        fuzzy_rule( Gosta_exatas %is%	gemaior	&& Rel_interpess %is%	rimen	&& Escre_codigo %is%	ecmaior	&& Perfil_lider %is%	plmin	&& Gosta_Estudar %is%	gsmax	&& Habilidade_comunica %is%	hcmed	, Classificacao %is%	altissima	),
        fuzzy_rule( Gosta_exatas %is%	gemaior	&& Rel_interpess %is%	rimen	&& Escre_codigo %is%	ecmaior	&& Perfil_lider %is%	plmen	&& Gosta_Estudar %is%	gsmaior	&& Habilidade_comunica %is%	hcmed	, Classificacao %is%	alta	),
        fuzzy_rule( Gosta_exatas %is%	gemaior	&& Rel_interpess %is%	 rimed	&& Escre_codigo %is%	ecmed	&& Perfil_lider %is%	plmed	&& Gosta_Estudar %is%	gsmaior	&& Habilidade_comunica %is%	hcmaior	, Classificacao %is%	alta	),
        fuzzy_rule( Gosta_exatas %is%	gemaior	&& Rel_interpess %is%	 rimed	&& Escre_codigo %is%	ecmed	&& Perfil_lider %is%	plmaior	&& Gosta_Estudar %is%	gsmaior	&& Habilidade_comunica %is%	hcmaior	, Classificacao %is%	alta	),
        fuzzy_rule( Gosta_exatas %is%	gemed	&& Rel_interpess %is%	rimaior	&& Escre_codigo %is%	ecmen	&& Perfil_lider %is%	plmaior	&& Gosta_Estudar %is%	gsmed	&& Habilidade_comunica %is%	hcmaior	, Classificacao %is%	media	),
        fuzzy_rule( Gosta_exatas %is%	gemed	&& Rel_interpess %is%	rimaior	&& Escre_codigo %is%	ecmen	&& Perfil_lider %is%	plmaior	&& Gosta_Estudar %is%	gsmed	&& Habilidade_comunica %is%	hcmax	, Classificacao %is%	media	),
        fuzzy_rule( Gosta_exatas %is%	gemen	&& Rel_interpess %is%	rimax	&& Escre_codigo %is%	ecmin	&& Perfil_lider %is%	plmax	&& Gosta_Estudar %is%	gsmed	&& Habilidade_comunica %is%	hcmax	, Classificacao %is%	media	),
        fuzzy_rule( Gosta_exatas %is%	gemen	&& Rel_interpess %is%	rimax	&& Escre_codigo %is%	ecmin	&& Perfil_lider %is%	plmax	&& Gosta_Estudar %is%	gsmen	&& Habilidade_comunica %is%	hcmax	, Classificacao %is%	baixa	),
        fuzzy_rule( Gosta_exatas %is%	gemin	&& Rel_interpess %is%	rimax	&& Escre_codigo %is%	ecmin	&& Perfil_lider %is%	plmax	&& Gosta_Estudar %is%	gsmen	&& Habilidade_comunica %is%	hcmax	, Classificacao %is%	baixa	),
        fuzzy_rule( Gosta_exatas %is%	gemin	&& Rel_interpess %is%	rimax	&& Escre_codigo %is%	ecmin	&& Perfil_lider %is%	plmax	&& Gosta_Estudar %is%	gsmin	&& Habilidade_comunica %is%	hcmax	, Classificacao %is%	baixa	)
    )

sistema <- fuzzy_system(variaveis, regras)


shinyServer(function(input, output) {
    output$GrafSistema = renderPlot({
        plot(sistema)
    })
    
    observeEvent(input$Processar, {
        inferencia = fuzzy_inference(sistema, 
                                     list(
                                         Gosta_exatas = input$sexatas,
                                         Rel_interpess = input$sinter,
                                         Escre_codigo = input$scodigo,
                                         Perfil_lider = input$slider,
                                         Gosta_Estudar = input$sestudar,
                                         Habilidade_comunica = input$scomunica
                                     ))
        
        output$GrafResultado = renderPlot({
            plot(sistema$variables$Classificacao)
            lines(inferencia, col="red", lwd=4)
        })
    })
})
