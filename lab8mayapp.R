#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

data(mtcars)



ui <- fluidPage(
    
    # Application title
    titlePanel("Motor Trend Car Road Tests"),
    
    # Sidebar with a slider input for number of bins 
    sidebarLayout(
        sidebarPanel(
            selectInput("colors",
                        "Select a color:",
                        c("red","blue","yellow","black")),
            
            tags$h3("Click on the button above to select a color")
                    
            
        ),
      
    
    
    
        
        # Show a plot of the generated distribution
        mainPanel(
            plotOutput("mtcarsPlot")
        )
        
    )
)


server <- function(input, output) {
    output$mtcarsPlot <- renderPlot({
        library(ggplot2)
        data2graph <- ggplot(data=mtcars, aes(x = mtcars$hp, y=mtcars$mpg, color=mtcars$mpg)) + 
            #geom_line(linetype = "dashed")+ #This is a line graph, but we have too many points for that currently. 
            geom_point()+ #This adds the initial points
            theme(axis.text.x=element_text(angle=45,hjust=1,vjust=0.5))+
            scale_color_gradient(low=input$colors, high="red")+ #Create a color scale to show high wind speed
            theme(legend.position='bottom')+ #Put the legend on the bottom
            ylab("Gross Horsepower")+ #Change the y-label
            xlab("Miles Per Galoon")+
            ggtitle("Gross Horsepower effect on Miles Per Galoon")+ #Add a title
            theme(plot.title = element_text(lineheight=.8, face="bold")) #Modify the title
        data2graph
    })
}
# Run the application 
shinyApp(ui = ui, server = server)
