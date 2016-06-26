corr <- function(directorio, horizonte=0) {
  
  direccion <- completos(directorio)
  aidis <- direccion[direccion["nobs"] > horizonte, ]$id
  direccion1 <- numeric()
  for (i in aidis) {
    
    rel <-read.csv(paste(directorio, "/", formatC(i, width = 3, flag = "0"), ".csv", sep = ""))
    reel <- rel[complete.cases(rel), ]
    direccion1 <- c(direccion1, cor(reel$sulfate, reel$nitrate))
  }
  return(direccion1)
}