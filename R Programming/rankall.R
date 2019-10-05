rankall <- function(outcome, num = "best") {
  library(plyr)
  
  ## Set outcome columns
  outcomes = c("Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack","Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure","Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia")
  names(outcomes) = c("heart attack","heart failure","pneumonia")
  
  ## Read outcome data
  outcome_matrix <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
  
  ## Check that state and outcome are valid
  if(!(outcome %in% names(outcomes))){
    stop("invalid outcome")
  } else {
    outcome_matrix_filtered = outcome_matrix[which(outcome_matrix[,outcomes[outcome]] != "Not Available"),]
    outcome_matrix_ordered = outcome_matrix_filtered[order(as.numeric(outcome_matrix_filtered[,outcomes[outcome]]),outcome_matrix_filtered$Hospital.Name),]
  }
  
  ## For each state, find the hospital of the given rank
  ## Return a data frame with the hospital names and the (abbreviated) state name
  if (num == "best"){
    return(ddply(outcome_matrix_ordered,.(State),function(x) head(x,n=1)$Hospital.Name))
  } else if (num == "worst"){
    return(ddply(outcome_matrix_ordered,.(State),function(x) tail(x,n=1)$Hospital.Name))
  } else {
    return(ddply(outcome_matrix_ordered,.(State),function(x) x$Hospital.Name[num]))
  }
}