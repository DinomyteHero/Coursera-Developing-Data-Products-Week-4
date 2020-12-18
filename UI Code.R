#UI

ui <- fluidPage(
        
        titlePanel("Welcome to my Shiny application on the survivability rates for the Titanic"),
        
        sidebarLayout(
                
                sidebarPanel(
                        
                        selectInput( "var",
                                     label = "Cabin Class",
                                     c("1st", "2nd", "3rd", "Crew"))
                        
                ),
                mainPanel(
                        h2("Summary of the variable"),
                        tableOutput("sum"),
                        plotOutput("theplot")
                )))
