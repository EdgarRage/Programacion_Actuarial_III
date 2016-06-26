completos <- function(directorio, id=1:332){
  
  funcom <- function(i) {
    
    datos = read.csv(paste(directorio, "/", formatC(i, width = 3, flag = "0"), ".csv", sep = ""))
    sum(complete.cases(datos))
  }
  
  nobs = sapply(id, funcom)
  return(data.frame(id, nobs))
}