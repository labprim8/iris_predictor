library(shiny)
library(caret)
library(ggplot2)
library(e1071)

data(iris)
set.seed(1979)

model.knn <- train(Species ~ Petal.Length + Petal.Width + Sepal.Length + Sepal.Width, data=iris,trControl = trainControl(method="cv", number=10), method = 'knn')
predict <- predict(model.knn, iris[,-5])

shinyServer(function(input, output) {
  
  output$plot1 <- renderPlot({
    predict.df <- data.frame(Petal.Length=input$petalLength, Petal.Width=input$petalWidth)
    g <- ggplot(iris, aes(x=Petal.Length, y=Petal.Width, colour=Species))
    g + geom_point() + geom_point(data = predict.df, aes(x=Petal.Length, y=Petal.Width), colour='black', size=4)
  })
  
  output$plot2 <- renderPlot({
    predict.df <- data.frame(Sepal.Length=input$sepalLength, Sepal.Width=input$sepalWidth)
    g <- ggplot(iris, aes(x=Sepal.Length, y=Sepal.Width, colour=Species))
    g + geom_point() + geom_point(data = predict.df, aes(x=Sepal.Length, y=Sepal.Width), colour='black', size=4)
  })
  
  output$text1 <- renderText({
    predict.df <- data.frame(Petal.Length=input$petalLength, Petal.Width=input$petalWidth, Sepal.Length=input$sepalLength, Sepal.Width=input$sepalWidth)
    iris.prediction <- predict(model.knn, predict.df)
    paste('The predicted species of iris is: ',as.character(iris.prediction))
  })
  
  output$table1 <- renderTable({
    confusionMatrix(predict, iris$Species)$table
  })
  
  output$table2 <- renderTable({
    data.frame(Ratio=confusionMatrix(predict, iris$Species)$overall[1:6])
  })
})