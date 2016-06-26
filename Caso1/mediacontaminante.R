meanpollution  <- function(directorio, contaminante, id = 1:332) {
  
  datos = lapply(id, function(i) read.csv(paste(directorio, "/", formatC(i,width = 3, flag = "0"), ".csv", sep = ""))[[contaminante]])
  
  return(mean(unlist(datos), na.rm = TRUE))
}
