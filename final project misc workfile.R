#work file for final project - misc stuff

suppressWarnings(library(tm))
library(stringi)
library(wordcloud)
library(ggplot2)
library(dplyr)
library(RColorBrewer)
library(knitr)
library(RWeka)
library(futile.logger)
library(SnowballC)
library(doParallel)
library(textcat)
library(stringr)

options(digits = 2)




blog <- readLines(file("en_US.blogs.txt"), skipNul = TRUE)
twit <- readLines(file("en_US.twitter.txt"), skipNul = TRUE)
news <- readLines(file("en_US.news.txt"), skipNul = TRUE)
badwords<-readLines(file( "https://raw.githubusercontent.com/shutterstock/List-of-Dirty-Naughty-Obscene-and-Otherwise-Bad-Words/master/en"),skipNul = TRUE)
totaldata<-c(blog,twit,news)


set.seed(132)
GFtotal<-sample(totaldata,40000)


GFtextcleaner<-function(x) {
        
        GFtext <- Corpus(VectorSource((x)))
        GFtext <- tm_map(GFtext, PlainTextDocument)
        GFtext <- tm_map(GFtext, stripWhitespace)
        GFtext<- tm_map(GFtext, content_transformer(tolower))
        GFtext <- tm_map(GFtext, removePunctuation)
        GFtext <- tm_map(GFtext, removeNumbers)
        GFtext <- tm_map(GFtext, removeWords, badwords)
        GFtext <- tm_map(GFtext, stripWhitespace)
        
        #      GFtext <- tm_map(GFtext, removeWords, c("a","and","the","an"))
        #      GFtext <- tm_map(GFtext,removeWords,stopwords(kind="en"))
        
        data.frame(sapply(GFtext,as.character),stringsAsFactors = FALSE) 
        
}





GFcorpuscreate<-function (x,y){
        arrange(tbl_df(data.frame(table(NGramTokenizer(x,Weka_control(min=y, max=y))))),desc(Freq))
}


GFgrammaker<-function(x,y) {
        GFcorpuscreate(GFtextcleaner(x),y)
        
}


#writeLines(SampleAll, "./sampleall/SampleAll.txt")
GFgram2<-GFgrammaker(GFtotal,2)
rowname2<-c(1:nrow(GFgram2))
GFgram2$word1 <-word(GFgram2$Var1,1)
GFgram2$word2 <-word(GFgram2$Var1,2)
saveRDS(GFgram2, file="GFgram2.rds")

GFgram3<-GFgrammaker(GFtotal,3)
rowname3<-c(1:nrow(GFgram3))
GFgram3$word1 <-word(GFgram3$Var1,1)
GFgram3$word2 <-word(GFgram3$Var1,2)
GFgram3$word3 <-word(GFgram3$Var1,3)
saveRDS(GFgram3, file="GFgram3.rds")

GFgram4<-GFgrammaker(GFtotal,4)
GFgram4$word1 <-word(GFgram4$Var1,1)
GFgram4$word2 <-word(GFgram4$Var1,2)
GFgram4$word3 <-word(GFgram4$Var1,3)
GFgram4$word4 <-word(GFgram4$Var1,4)
saveRDS(GFgram4, file="GFgram4.rds")


#GFgram5<-GFgrammaker(GFtrain,5)

#head(GFgram1)
head(GFgram2)
head(GFgram3)
head(GFgram4)

removecores<- detectCores() - 1
GFcluster <- makeCluster(removecores)
clusterExport(cl=GFcluster, varlist=c("GFgram2","GFgram3","GFtest3"))

GFtest3$pred1 <- parLapply(cl=GFcluster, X = 1:nrow(GFtest3), fun = function(x) GFgram2$word2[GFgram2$word1==GFtest3$word2[x]][1]) 

GFtest3$pred2 <- parLapply(cl=GFcluster, X = 1:nrow(GFtest3), fun = function(x) GFgram3$word3[GFgram3$word1==GFtest3$word1[x] & GFgram3$word2==GFtest3$word2[x]][1])
stopCluster(GFcluster)

GFtest3$correct1 <- ifelse(GFtest3$word3==GFtest3$pred1,1,0)
GFtest3$correct2 <- ifelse(GFtest3$word3==GFtest3$pred2,1,0)
head(GFtest3)





# Back Off Algorithm

# Predict the next term of the user input sentence
# 1. For prediction of the next word, Quadgram is first used (first three words of Quadgram are the last three words of the user provided sentence).
# 2. If no Quadgram is found, back off to Trigram (first two words of Trigram are the last two words of the sentence).
# 3. If no Trigram is found, back off to Bigram (first word of Bigram is the last word of the sentence)
# 4. If no Bigram is found, back off to the most common word with highest frequency 'the' is returned.
#x<-"like pizza and"
#xclean <- removeNumbers(removePunctuation(tolower(x)))
#cleaninput <- strsplit(xclean, " ")[[1]]
#index <- which(GFgram4$word3 ==cleaninput[3] & GFgram4$word2==cleaninput[2] & GFgram4$word1==cleaninput[1])
#aab<-GFgram4$word4 [pred[1:3]]
#aab



GFgram4 <- readRDS("GFgram4.rds")

GFgram3 <- readRDS("GFgram3.rds")

GFgram2 <- readRDS("GFgram2.rds")





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


