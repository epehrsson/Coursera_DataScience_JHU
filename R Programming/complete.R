complete = function(directory, id = 1:332){
  id_files = list.files(path=directory,pattern=".csv",full.names = TRUE)
  select_files = id_files[id]
  read_files = lapply(select_files,function(x) read.csv(x,header=TRUE))
  names(read_files) = select_files
  
  complete_cases = ldply(read_files,function(x) sum(complete.cases(x)))
  return(complete_cases)
}