
suppressWarnings(library(shiny))

suppressWarnings(library(markdown))
suppressWarnings(library(shinydashboard))
suppressWarnings(library(shinythemes))

                            
                            
 shinyUI(fluidPage(theme=shinytheme("superhero"),
  img(height=200,width=240,src="TheTick.png"),
  hr(),
         titlePanel("Capstone Project - Final Project GaryFH"),
  hr(),
                                              
                         fluidRow(
                                column(3,
                                     h2("Be a super hero - predict the next word")),
                                              
                                column(3,
                                     h3("Enter a phrase (from two to four words)")),
                                
                                column(3,
                                       h3("See up to three predicted next words)")),
                                
                                column(3,
                                     h3("Not all phrases work - if you see all N/A's try a different phrase")) 
                        ),
                                              
                                hr(),
                            
                            
                            
                            
                         fluidRow(
                                    
                                    column(12,
                                            
                                            textInput(inputId="inputString", label="  Enter a partial sentence here",value = ""),
                                            actionButton("go", " SUBMIT")),     
                                    
                                            br(),
                                            
                                            br(),
                                    br(),
                                    
                                    br(), 
                                    br(),
                                    
                                    br(), 
                                    br(),
                                    hr(),
                                      
                                            
                                    
                                    
                        fluidRow(
                                            
                                column(1,
                                       ("")),            
                                            
                                column(2,
                                        h4("Your Input:")),
                                            
                                column(9,
                                        h4((textOutput('text1')))
                                            
                                            
                                    ),

                                br(),
                                
                                br(), 
                                br(),
                                
                               
                                
                                br(), 
                                hr(),
                                           
                        fluidRow(
                                
                                column(1,
                                       ("")),  
                                            

                                            
                                column(4,        
                                           
                                        h4("Up to three potential words (if you get all N/A's try a different phrase)")),
                                
                                column(2,
                                       
                                       h2("Output:")), 
                                
                                column(5,            
                                          
                                        h1(textOutput('text2'))
                                            
                                    )),
                        hr()
                        ))))
                                    
                           
                            
                            
                            
                   
