library(shiny)

shinyUI(fluidPage(
  
  #application title
  titlePanel('Iris species predictor'),
  
  #side bar
  sidebarLayout(
    sidebarPanel(
      sliderInput('petalLength', 'Length of Petal:', min=1, max=10, value=4, step=0.1),
      sliderInput('petalWidth', 'Width of Petal:', min=0.1, max=3, value=1.5, step=0.1),
      sliderInput('sepalLength', 'Length of Sepal:', min=1, max=10, value=5, step=0.1),
      sliderInput('sepalWidth', 'Width of Sepal:', min=1, max=5, value=2.5, step=0.1)
    ),
    
    mainPanel(
      tabsetPanel(
        tabPanel("About", 
                 tags$p('This shiny app will allow you predict the species of iris using 4 measurements'),
                 tags$p('The prediction model uses a K nearest neighbour method on 150 known measurements'),
                 tags$h3('Instructions'),
                 tags$br(),
                 tags$li('Use the sliders on the left to input the size of the iris petal and sepal'),
                 tags$br(),
                 tags$li('This will then update the graphs with your measurement and predict the speices from the model.'),
                 tags$br(),
                 tags$li('The results can be seen in Plots'),
                 tags$br(),
                 tags$li('How well the model performs can be found under model Accuracy')),
        tabPanel("Plot",tags$h2(textOutput('text1')),plotOutput('plot1'),plotOutput('plot2')),
        tabPanel("Model Accuracy",tags$h2('Confusion matrix'),tableOutput('table1'),tags$h2('Accuracy'),tableOutput('table2'))
      )
    )
  )
)
)