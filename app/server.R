require(MASS)
require(caret)
require(randomForest)

lmfit <- lm(Employed ~ ., data = longley)

set.seed(1)
rffitscan = train(Employed ~ ., data = longley, tuneLength=5)



shinyServer(function(input, output, session) {
  
  output$pairplot <- renderPlot({
    
    pairs(longley, main = "longley data")
    
  })
  
  
  output$plot <- renderPlot({
    
    mbest=input$mtry
    ntree = input$ntree
    set.seed(1)
    rffit = randomForest(Employed ~ ., data = longley, mtry=mbest, ntree=ntree)
    
    if (input$plotType == "mse"){
      plot(rffit$mse, xlab="trees", ylab="MSE", type="l", lwd=3)
    } else if (input$plotType == "rsq"){
      plot(rffit$rsq, xlab="trees", ylab=expression("R"^{2}), type="l", lwd=3)      
    }
    
  })

  output$scanplot <- renderPlot({
    
    res = rffitscan$results

    if (input$plotScan == "rmse"){
      plot(res$mtry, res$RMSE, type="l", lwd=3, xlab="mtry",
           ylab="RMSE",col='#3182bd')
      points(res$mtry, res$RMSE, pch=16, cex=1.5, col='#3182bd')
      
    } else if (input$plotScan == "rsq"){
      plot(res$mtry, res$Rsquared, type="l", lwd=3, xlab="mtry",
           ylab=expression("R"^{2}),col='#3182bd')
      points(res$mtry, res$Rsquared, pch=16, cex=1.5, col='#3182bd')
      
    }
  
  })
  
  
  
  output$rfsum <- renderPrint({
    rffitscan$results
    
  })
  
  output$lmsum <- renderPrint({
    summary(lmfit)
 
  })
  

})
