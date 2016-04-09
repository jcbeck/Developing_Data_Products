library(shiny)

shinyUI(
  navbarPage("Motor Trend Analysis",
             tabPanel("Analysis",
                      fluidPage(
                        titlePanel("Comparison of Automatic vs. Manual Transmission on Auto Miles Per Gallon"),
                        sidebarLayout(
                          sidebarPanel(
                            selectInput("variable", "Variable:",
                                        c("Number of cylinders" = "cyl",
                                          "Displacement (cu.in.)" = "disp",
                                          "Gross Horsepower" = "hp",
                                          "Rear Axle Ratio" = "drat",
                                          "Weight (lb/1000)" = "wt",
                                          "1/4 Mile Time" = "qsec",
                                          "V/S" = "vs",
                                          "# of Forward Gears" = "gear",
                                          "# of Carburetors" = "carb"
                                        )),
                            br(),
                            p("INSTRUCTION: The application plots the relationship between variables and miles per gallon (MPG).")
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
                        titlePanel("MPG Prediction Based on MTCARS Data"),
                        sidebarLayout(
                          sidebarPanel(
                            radioButtons("trans", "Transmission Type:", 
                                         list("Automatic" = "Automatic", "Manual" = "Manual")),
                            #sliderInput("hp", "Vehicle Horsepower:", 50, 200, mean(mtcars$hp), step=10),
                            numericInput("hp", "Vehicle Horsepower:", mean(mtcars$hp), min=50, max=300),
                            numericInput("wt", "Vehicle Weight (in 1000 lbs):", mean(mtcars$wt), min=1, max=100),
                            br(),
                            p("INSTRUCTION: The application uses linear regression shown in the formula to predict the MPG."),
                            p("3 parameters are used: transmission type, car horsepower and weight in x1000lb."),
                            p("Predicted result is shown in main panel under 'Predicted MPG'.")
                          ),
                          
                          mainPanel(
                            h3('Regression Model Formula:'),
                            h2(withMathJax('$$MPG = \\beta_0 + \\beta_{1}AM + \\beta_{2}HP + \\beta_{3}WT + \\epsilon$$')),
                            
                            h4("Predicted MPG:"), verbatimTextOutput("mpg"), 
                            
                            h4("Horsepower:"), verbatimTextOutput("h"), 
                            h4("Transmission:"), verbatimTextOutput("t"), 
                            h4("Weight (lbs):"), verbatimTextOutput("w"), 
                            h4("Regression Model Coefficient:"), verbatimTextOutput("coef")
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