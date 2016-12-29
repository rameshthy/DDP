setwd("/Users/thyagarr/coursera/DDP/")
library(shiny)
require(markdown)
require(data.table)
library(dplyr)
library(DT)
library(rCharts)
library(ggplot2)

# Load data processing file
source("data_process.R")
categories <- sort(unique(data$Category))

# Shiny server
shinyServer(
  function(input, output) {

    # Initialize reactive values
    values <- reactiveValues()
    values$categories <- categories
    
    # Create event type checkbox
    output$categoriesControl <- renderUI({
      checkboxGroupInput('categories', 'Complaint Categories:', 
                         categories, selected = values$categories)
    })
    
    # Add observer on select-all button
    observe({
      if(input$selectAll == 0) return()
      values$categories <- categories
    })
    
    # Add observer on clear-all button
    observe({
      if(input$clearAll == 0) return()
      values$categories <- c() # empty list
    })
    
    # Prepare dataset
    dataTable <- reactive({
      groupByYearAll(data, input$timeline[1], input$timeline[2],  input$categories)
    })
   
    dtComplaintsByYearOutput <- reactive({
      aggregate_by_year(data, input$timeline[1], input$timeline[2], input$categories)
    })

    dtComplaintsByStateOutput <- reactive({
      aggregate_by_state(data, input$timeline[1], input$timeline[2], input$categories)
    })
    
    dtComplaintsByCategoryByYearOutput <- reactive ({
      aggregate_by_category(data, input$timeline[1], input$timeline[2], input$categories)
      
    })
    
        
    # Render data table
    output$dTable <- DT::renderDataTable(
      DT::datatable(dataTable(), options = list(searching = FALSE))
    )
    
    output$showcomplaintsByYear <- renderPlot({
      plotShowComplaintsByYear(dtComplaintsByYearOutput())
    })
    
  
    # Agg complaints by category by Year
    output$showcomplaintsByCategoryByYear <- renderPlot({
      plotShowComplaintsByCategoryByYear(dtComplaintsByCategoryByYearOutput())
    })
    
      
  } # end of function(input, output)
)