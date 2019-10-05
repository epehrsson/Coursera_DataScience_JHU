best <- function(state, outcome) {
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
    outcome_matrix_filtered = outcome_matrix[which(outcome_matrix$State == state),]
  }
  
  ## Return hospital name in that state with lowest 30-day death rate
  return(outcome_matrix_filtered[which.max(outcome_matrix_filtered[,outcomes[outcome]]),]$Hospital.Name)
}