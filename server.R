library(shiny)
library(ggplot2)
library(datasets)

# Set below variable as factor
mtcars$cyl <- as.factor(mtcars$cyl)
mtcars$vs <- as.factor(mtcars$vs)
mtcars$am <- factor(mtcars$am, labels = c('Automatic','Manual'))
mtcars$gear <- as.factor(mtcars$gear)
mtcars$carb <- as.factor(mtcars$carb)

str(mtcars)

# Linear Regression
fit <- lm(mpg ~ am + wt + hp, data = mtcars)
summary(fit)
summary(fit)$coef


# Define server logic for random distribution application
shinyServer(function(input, output) {
  
  # Reactive expression to generate the requested ggplot 
  plotOutput <- reactive({
    g <- ggplot(data = mtcars, aes_string(x = input$variable, y = "mpg", colour = "am"))
    g <- g +  facet_grid(.~am) + geom_point(size = 4)
    g <- g + xlab(input$variable) + ylab("mpg")
    g
  })
  
  # Generate plot of the data. 
  output$plot <- renderPlot({
    plotOutput()
  })
  
  # Generate summary of the data.
  output$summary <- renderPrint({
    summary(mtcars)
  })
  
  # Generate an HTML table view of the data
  output$predict <- renderTable({
    data.frame(x=summary(fit)$coef)
    summary(fit)$coef
  })
  
  
  # Generate prediction based on linear regression model
  output$h <- reactive(input$hp)    
  output$t <- reactive(input$trans)
  output$w <- renderText(input$wt * 1000)
  
  output$mpg <- renderText({
    predict(fit, newdata = list(am=input$trans, hp=input$hp, wt=input$wt))} )
  
  output$coef <- renderPrint({summary(fit)$coef})
  
  
  
})