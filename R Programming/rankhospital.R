rankhospital <- function(state, outcome, num = "best") {
  ## Set outcome columns
  outcomes = c("Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack","Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure","Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia")
  names(outcomes) = c("heart attack","heart failure","pneumonia")
  
  ## Read outcome data
  outcome_matrix <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
  
  ## Check that state and outcome are valid
  if(!(outcome %in% names(outcomes))){
    stop("invalid outcome")
  } else if (!(state %in% unique(outcome_matrix$State))) {
    stop("invalid state")
  } else {
    outcome_matrix_filtered = outcome_matrix[which(outcome_matrix$State == state & outcome_matrix[,outcomes[outcome]] != "Not Available"),]
  }
  
  ## Return hospital name in that state with the given rank 30-day death rate
  outcome_matrix_ordered = outcome_matrix_filtered[order(as.numeric(outcome_matrix_filtered[,outcomes[outcome]]),outcome_matrix_filtered$Hospital.Name),]
  num_hospital = dim(outcome_matrix_ordered)[1]

  if(num == "best"){
    return(head(outcome_matrix_ordered,n=1)$Hospital.Name)
  } else if (num == "worst"){
    return(tail(outcome_matrix_ordered,n=1)$Hospital.Name)
  } else if (num > 0 & num <= num_hospital){
    return(outcome_matrix_ordered$Hospital.Name[num])
  } else {
    return("NA")
  }
}