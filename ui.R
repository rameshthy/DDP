# This is the user-interface definition of a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(DT)
library(shiny)

shinyUI(
  navbarPage("Consumer Financial Protection DataSet Visualizer", 
             # multi-page user-interface that includes a navigation bar.
             tabPanel("Explore the Data",
                      sidebarPanel(
                        sliderInput("timeline", 
                                    "Timeline:",  
                                    min = 2011,
                                    max = 2016,
                                    value = c(2011, 2016),
                                    sep = ""),
                        uiOutput("categoriesControl"), # the id
                        actionButton(inputId = "clearAll", 
                                     label = "Clear selection", 
                                     icon = icon("square-o")),
                        actionButton(inputId = "selectAll", 
                                     label = "Select all", 
                                     icon = icon("check-square-o"))
                        
                      ),

                      mainPanel(
                        tabsetPanel(
                          # Data 
                          tabPanel(p(icon("table"), "Dataset"), DT::dataTableOutput("dTable")
                          ), # end of "Dataset" tab panel
                          
                          tabPanel(p(icon("line-chart"), "Visualize the Data"),
                                   h4('Number of Complaints by Year', align = "center"),
                                   plotOutput("showcomplaintsByYear" ),
                                   h4('Number of Complaints by Categories by year', align = "center"),
                                   plotOutput("showcomplaintsByCategoryByYear")
                                  )
                                )
                              )
                    ),  # end of "Explore Dataset" tab panel
 
             tabPanel("About", (includeMarkdown("about.md")
                      )
             ) # end of "About" tab panel
             
             
    )
)