# Server

titanic_data <- as.data.frame(Titanic)

# Aim is to see if changing from the different classes on the Titanic has an impact on survivability.

plot(titanic_data$Class, titanic_data$Freq)

titanic_data2 <- as.data.frame(Titanic)
titanic_data2$Prob <- titanic_data2$Freq / sum(titanic_data2$Freq)
# Converted the probability into percentage and rounded off to two decimals
titanic_data2$Percentage <- titanic_data2$Prob * 100
titanic_data2$Percentage <- round(titanic_data2$Percentage, 2)

# Need to remove data with frequency of 0 from the data table
titanic_data2[titanic_data2$Freq == 0,] <- NA

titanic_data2 <- titanic_data2[complete.cases(titanic_data2), ]

# Created a subset for data from only the survivors
titanic_live <- titanic_data2[titanic_data2$Survived == "Yes",]


server <- (function(input, output){
        
        datasetInput <- reactive({
                switch(input$var,
                       "1st" = titanic_live[titanic_live == "1st",],
                       "2nd" = titanic_live[titanic_live == "2nd",],
                       "3rd" = titanic_live[titanic_live == "3rd",],
                       "Crew" = titanic_live[titanic_live == "Crew",])
        })
        
        output$sum <- renderTable({
                head(datasetInput())
        })
        
        
        
        output$theplot <- renderPlot({
                ggplot(data=titanic_live, aes(x = Class, y=Percentage)) + geom_bar(stat = "identity", fill = "blue") + 
                        labs(x = "Cabin Class of Passenger", y = "Percent Probability", title = "The Percentage Probability of you surviving on the Titanic based on Cabin Class")
        })
})

