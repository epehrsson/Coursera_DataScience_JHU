pollutantmean = function(directory, pollutant, id = 1:332){
  id_files = list.files(path=directory,pattern=".csv",full.names = TRUE)
  select_files = id_files[id]
  read_files = lapply(select_files,function(x) read.csv(x,header=TRUE))
  read_files = ldply(read_files)
  output = mean(na.omit(read_files[[pollutant]]))
  return(output)
}