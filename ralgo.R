m<-1000
n<-100

ralgo <- function(n,distribucion){
  
  promedio <- sapply(lapply(rep(m,n),runif),mean)
  hist(promedio)
}
ralgo(1000,runif)
