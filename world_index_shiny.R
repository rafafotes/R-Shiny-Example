library(shiny)
data <- read.csv2("World_Indexes.csv",
                  header = TRUE,
                  sep=",",
                  dec=".")
data$Id <- NULL

#Os selectInput devem listar os nomes das variáveis do arquivo World_Indexes.csv no momento da inicialização.
variaveis <- names(data)

ui <- fluidPage(
  # Um selectInput para selecionar a 1a variável
  selectInput("var1", 
              label = "Escolha a variavel do eixo X",
              choices = variaveis),
  # Um selectInput para selecionar a 2a veriável
  selectInput("var2", 
              label = "Escolha a variavel do eixo Y",
              choices = variaveis),
  # Um actionButton para disparar o processamento
  actionButton("action", "Plotar"),
  # Um plotOutput onde deverá ser exibido o gráfico de dispersão da 1a variável (x) pela 2a variável (y)
  plotOutput("hist")
)

server <- function(input, output) {
  # Ao inicializar a aplicação a área do gráfico deve estar em branco, 
  # e a simples mudança de seleção nos selectInput  não deve disparar a renderização do gráfico, 
  # que deve ocorrer somente ao clicar no actionButton.
  x <- eventReactive(input$action, {(get(input$var1, data)) })
  y <- eventReactive(input$action, {(get(input$var2, data)) })
  xlabel <- eventReactive( input$action, {
    input$var1
  })
  ylabel <- eventReactive( input$action, {
    input$var2
  })
  output$hist <- renderPlot({
    plot(x=x(), y=y(), xlab = xlabel(), ylab=ylabel() )
  })
}


shinyApp(ui = ui, server = server)
