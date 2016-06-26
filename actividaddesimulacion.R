n <- 100
mensajes <- vector("character",n)
for(i in 1:n){
  y <- runif(1)
  if (y <= 0.20){
    mensajes[i] <- "Mensaje 20%"
  } else if (y <= .40){
    mensajes [i] <- "Mensaje 40%"
  } else if (y <= .60){
    mensajes[i] <- "Mensaje 60%"
  } else if (y <= .80){
    mensajes[i] <- "Mensaje 80%"
  } else{
    mensajes[i] <- "Mensaje 10%"
  }
}
plot(table(mensajes))

