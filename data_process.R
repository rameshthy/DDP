# Read data
data <- fread("Consumer_complaints.csv") 

# Exploratory data analysis
# sum(is.na(data)) 0
# table(data$Year)  2011   2012   2013   2014   2015   2016
#                   2540  72403 108226 153088 168598 182399
# length(table(data$Category)) # 12
# length(table(data$Company)) # 4000

## Helper functions

#' Aggregate dataset 
#' @param dt data.table
#' @param minYear
#' @param maxYear
#' @param categories
#' @return data.table
groupByYearAll <- function(dt, minYear, maxYear, categories) {
  result <- dt %>% filter(Year >= minYear, Year <= maxYear, Category %in% categories) 
  # result

  return(result)
}

# Aggregate complaints by year
#' @param dt data.table
#' @param minYear
#' @param maxYear
#' @param categories
#' @return data.table
aggregate_by_year <- function(dt, minYear, maxYear, categories){
  result <- dt %>% filter(Year >= minYear, Year <= maxYear, Category %in% categories) %>% 
    group_by(Year) %>% count(Year) %>% arrange(Year)
  return(result)
}


#' Plot number of complaints by year
#' @param dt data.table
#' @param minYear
#' @param maxYear
#' @param categories
#' @param dom
#' @param yAxisLabel
#' @return plot
plotShowComplaintsByYear <- function(dt, dom = "showcomplaintsByYear", yAxisLabel = "Number of Complaints") {
  plot_showcomplaintsByYear <- ggplot(dt, aes(factor(Year), n)) + 
    geom_bar(stat="identity",  colour = "blue") +
    xlab("Years") +
    ylab("Number of Complaints")
  plot_showcomplaintsByYear
}


# Aggregate complaints by categories by year
#' @param dt data.table
#' @param minYear
#' @param maxYear
#' @param categories
#' @return data.table
aggregate_by_category  <- function(dt, minYear, maxYear, categories){
    result <- dt %>% filter(Year >= minYear, Year <= maxYear, Category %in% categories) %>% 
      group_by(Year,Category) %>% count(Year, Category) %>% 
      arrange(Year)
  return(result)
}


#' Plot number of complaints by category by year
#' @param dt data.table
#' @return plot
plotShowComplaintsByCategoryByYear <- function(dt) {
  plot_showComplaintsByCategoryByYear <- ggplot(dt, aes(factor(Year), n, fill = Category)) + 
    geom_bar(stat="identity", position = "dodge") +
    xlab("Years") +
    ylab("Number of Complaints")
#  +    scale_fill_brewer(palette = "Set2")
  plot_showComplaintsByCategoryByYear
}







