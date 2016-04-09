library(shiny)

shinyUI(
  navbarPage("Motor Trend Data Analysis",
             tabPanel("Analysis",
                      fluidPage(
                        titlePanel("The Effect of Automatic or Manual Transmission on Miles Per Gallon"),
                        sidebarLayout(
                          sidebarPanel(
                            selectInput("variable", "Variable:",
                                        c("Number of cylinders" = "cyl",
                                          "Displacement (cu.in.)" = "disp",
                                          "Gross horsepower" = "hp",
                                          "Rear axle ratio" = "drat",
                                          "Weight (lb/1000)" = "wt",
                                          "1/4 mile time" = "qsec",
                                          "V/S" = "vs",
                                          "Number of forward gears" = "gear",
                                          "Number of carburetors" = "carb"
                                        )),
                            br(),
                            p("INSTRUCTION: The application plot the relationship between variables and miles per gallon (MPG)")
                          ),
                          
                          mainPanel(
                            tabPanel("Plot", plotOutput("plot")),
                            br(),
                            h3("Summary"),
                            tabPanel("Summary", verbatimTextOutput("summary"))
                          )
                        )
                      )
             ),
             
             tabPanel("Prediction",
                      fluidPage(
                        titlePanel("Miles Per Gallon prediction based on MTCARS data"),
                        sidebarLayout(
                          sidebarPanel(
                            radioButtons("trans", "Transmission Type:", 
                                         list("Automatic" = "Automatic", "Manual" = "Manual")),
                            #sliderInput("hp", "Vehicle horsepower:", 50, 200, mean(mtcars$hp), step=10),
                            numericInput("hp", "Vehicle horsepower:", mean(mtcars$hp), min=50, max=300),
                            numericInput("wt", "Vehicle weight (in 1000 lbs):", mean(mtcars$wt), min=1, max=100),
                            br(),
                            p("INSTRUCTION: The application use linear regression shown in the formula to predict the auto MPG, enter 3 parameters"),
                            p("Transmission type, car horsepower and weight in x1000lb."),
                            p("Predicted result is shown in main panel under Predicted MPG.")
                          ),
                          
                          mainPanel(
                            h3('Regression model formula:'),
                            h2(withMathJax('$$MPG = \\beta_0 + \\beta_{1}AM + \\beta_{2}HP + \\beta_{3}WT + \\epsilon$$')),
                            
                            h4("Predicted MPG:"), verbatimTextOutput("mpg"), 
                            
                            h4("Horsepower:"), verbatimTextOutput("h"), 
                            h4("Transmission:"), verbatimTextOutput("t"), 
                            h4("Weight (lb):"), verbatimTextOutput("w"), 
                            h4("Regression model Coefficient:"), verbatimTextOutput("coef")
                          )
                        )
                      )
             ),
             
             tabPanel("SourceCode",
                      p("Developing_Data_Products: Shiny Assignment"),
                      a("https://github.com/jcbeck/Developing_Data_Products")
             )               
  )
)