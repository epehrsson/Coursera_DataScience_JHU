corr = function(directory, threshold=0){
  cases = complete(directory)
  cases_complete = cases[which(cases$V1 > threshold),]$.id 
  correlation = vector(mode="numeric", length=0)
  for (file in cases_complete){
    read_file = read.csv(file,header=TRUE)
    correlation[file] = cor(read_file$sulfate,read_file$nitrate,use="complete.obs")
  }
  return(correlation)
}