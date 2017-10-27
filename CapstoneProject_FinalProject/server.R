suppressWarnings(library(tm))

suppressWarnings(library(stringr))

suppressWarnings(library(shiny))



# Load Quadgram,Trigram & Bigram Data frame files



GFgram4 <- readRDS("./Data/GFgram4.rds");

GFgram3 <- readRDS("./Data/GFgram3.rds");

GFgram2 <- readRDS("./Data/GFgram2.rds");

#mesg <- ""



# Cleaning of user input before predicting the next word



Wordpredict <- function(x) {
        
        cleaninput <- removeNumbers(removePunctuation(tolower(x)))
        
        cleaninput <- removePunctuation(cleaninput)
        
        cleaninput <- stripWhitespace(cleaninput)
        
        cleaninput <- unlist(strsplit(cleaninput, " "))#[[1]]
        
        len <- length(cleaninput)
        
        
        if (len<=1) 
                
        {      
        
               return(GFgram2$word1[1:3])
                
        }
                if (length(GFgram2$word1)>0) 
                        
                {
                        
                      
                if (len>=3)
                        
                {
                        
                        
                        pred <- which(GFgram4$word3==cleaninput[len] & GFgram4$word2==cleaninput[len-1] & GFgram4$word1==cleaninput[len-2])
                        
                        if (length(pred)>0) 
                                
                        {
                                
                                return(GFgram4$word4[pred[1:3]])
                                
                        }
                        
                }
                
                if (len>=2)
                        
                {
                        
                        pred <- which(GFgram3$word2==cleaninput[len] & GFgram3$word1==cleaninput[len-1])
                        
                        if (length(pred)>0) 
                                
                        {
                                
                               return(GFgram3$word3[pred[1:3]])
                                
                        }
                        
                }
                
                index <- which(GFgram2$word1==cleaninput[len])
                
                if (length(index)>0) 
                        
                {
                        
                        return(GFgram2$word2[pred[1:3]])     
                        
                }
                
        }
        

}





shinyServer(function(input, output) {
        
   #input$inputString
                
                react1 <- eventReactive(input$go,{Wordpredict(input$inputString)})
                
                output$text2 <- renderText({react1()})
                
                react2 <- eventReactive(input$go,{input$inputString})
        
                output$text1 <- renderText({react2()})
        
}

)

