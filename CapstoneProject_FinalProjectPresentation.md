Capstone ProjectFinal Project Presentation
========================================================
author: GaryFH
date: 10/27/2017
autosize: true

#First Slide
#========================================================


Introduction

========================================================

<small>

- The purpose of this application is to allow a user to input a phrase and it would predict the next word that they “most likely” want to type.

_ The n-grams that support the application come from blogs,  twits and news.


- One possible use could be for texting



- Milestone Report Link : [Milestone Report](https://rpubs.com/GaryFH/320044)



- Application link : [Shiny App - Next Word Prediction](https://ritheshkumar95.shinyapps.io/NextWordPrediction)



- Github Link : [Codes](https://github.com/ritheshkumar95/Capstone-Project)



</small>



Text Prediction Algorithm

========================================================

<small>



1. Preprocessing the text (e.g. filter non-English words, symbols)

2. Tokenization

3. Prepare unigram, bigram and trigram from the data

4. Count the occurrences of each unique unigram, bigram, trigram and quadgram

5. Calculate probabilties for each N-Gram using **Maximum Likelihood Estimate** And **Simlple Linear Interpolation**

6. Get the text phrase from the user

7. Extract the last three tokens (e.g. prev1, prev2) from the phrase. If the phrase is not long enough, extract the last two tokens or last token.

8. Return the top 3 matches with high proabability.

</small>



Shiny App - Next Word Prediction

========================================================

- Screenshot Of The App







```
Error in library(png) : there is no package called 'png'
```
