  x <- runif(1)
  x
  if(x>0 && x< 0.7) {
    y <- "Todo bien"
  } else if(x>0.7 && x<0.8){
    y <- "Todo regular"
  } else if(x>0.8 && x<1){
    y<-"Todo mal"
  }
  y