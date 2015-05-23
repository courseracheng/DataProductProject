
shinyUI(navbarPage("Random Forest",
  tabPanel("About",
    h4("Introduction"),
    
    hr(),
    
    p("This application use random forest as machine learning algorithm 
      to study the highly linear data set Longley. In this shiny app, 
      firstly, the data set is discussed. Secondly, random forest parameter
      mtry is discussed. Lastly, parameters mtry and ntree are discussed."),
    
    hr(),
    
    p(strong("Please click the bar above to get details of topic below.")),
    
    hr(),
    
    h4("Data"),
    
    p("Data set (longley) is discussed with pairwise plot between variables.
      In addition, linear regression is also performanced to show high 
      collinearity of the data set."),
    
    hr(),
    h4("mtry"),
    
    p("One important parameter to build random forest model is mtry, nubmer 
      of variables to split at each node. In order to pick the best one, mtry
      will be scanned. "),
    
    hr(),
    h4("Plot"),
    
    p("Two parameters ntree and mtry can be changed to show the difference of 
      results in the plot.")
    

    ),
                   
                   
  tabPanel("Data",
    sidebarLayout(
      sidebarPanel(
       h3("Data Description")

         ),
      
        mainPanel(
          h3("Longley's Economic Regression Data"),
          
          p("A macroeconomic data set which provides a 
         well-known example for a highly collinear regression."),
          
          p("It is a data frame with 7 economical variables, observed
            yearly from 1947 to 1962 (n=16). The figure below shows the
            pairwise plot between variables and it is known to be", 
            strong("highly collinear"),"."),
          
          plotOutput("pairplot"),
          
          p("Linear regression by ",code("lm(Employed ~ ., data=longley)"), 
            "results below can also see the highly collinear of the data"),
          
          hr(),
          
          verbatimTextOutput("lmsum"),
          
          hr(),
          
          p(strong("For high collinear data set, Random Forest is good algorithm due 
            to random select subset of variables to build each tree.")),
          
          
          hr(),
          
          h3("Source"),
          
          p("J. W. Longley (1967) An appraisal of least-squares programs 
          from the point of view of the user. 
          Journal of the American Statistical Association 62, 819–841.
          "),
          
          h3("References"),
          
          p("Becker, R. A., Chambers, J. M. and Wilks, A. R. (1988) 
          The New S Language. Wadsworth & Brooks/Cole.")
          
      )
    )                 
  ),               

  tabPanel("mtry",
    sidebarLayout(
      sidebarPanel(
        h4("Metric for measuring performance of Random Forest"),
        
        hr(),
        radioButtons("plotScan", "Metric",
           c("RMSE"="rmse", "Rsquare"="rsq")
          )
      ),
      
     mainPanel(
       h3("mtry selelction"),
       
       hr(),
       p( strong("mtry: Number of variables randomly sampled as candidates at
         each split.")),
       
       hr(),
       p("Note that the default values are different 
         for classification (sqrt(p) where p is number of variables in x) 
         and regression (p/3)."),
       p("It can also be selected by evaluating  
         all possible mtry from 2 to number of variables in RMSE or Rsquare.",
          em("caret"), "package can be used for this purpose."),
       
       hr(),
       p("The figure below shows the performance of random forest on Longley data
         with different", strong("mtry"), "from 2 to 6."),
           
      plotOutput("scanplot")
      )
    )
  ),
  
  
  
  
  tabPanel("Plot",
    sidebarLayout(
      sidebarPanel(
        h4("Metric for measuring performance of Random Forest"),
        hr(),
        
        radioButtons("plotType", "Metric",
          c("MSE (mean square error)"="mse", "Rsquare"="rsq")
        ),
        
        hr(),
        hr(),
        hr(),
        
        h4("Two Parameters of Random Forest"),
  
        hr(),
        sliderInput("ntree",
                    "Number of trees:",
                    min = 100,  max = 5000, value = 3000),
        
        hr(),
        sliderInput("mtry",
                    "mtry:",
                    min = 2,  max = 6,  value = 4)
      ),
      mainPanel(
        
        h4("The random forest performance with two parameters ntree and mtry"),
        
        p("With ntree increasing, the performance of random forest will converage."),
        
        plotOutput("plot")
      )
    )
  )
  
))
