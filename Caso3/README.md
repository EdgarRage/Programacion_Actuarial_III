---
title: "README"
author: "Edgar Ramírez"
date: "15 de junio de 2016"
output: html_document
---


# Facultad de Ciencias Físico Matemáticas BUAP

## Licenciatura en Actuaria

## Programación Actuarial III

### Caso: Reconocimiento de Actividad Humana con Celulares

#### Edgar Ramírez González

Una de las áreas más populares del análisis de datos proviene de las computadoras de vestimenta. 

Compañías como Fitbit, Nike y Jawbone Up compiten para desarrollar los algoritmos más avanzados para atraer a nuevos usuarios. Los datos de este caso provienen de los acelerómetros ubicados en celulares Samsung Galaxy S.  

Una mayor descripción de la base de datos y su recopilación puede ser hallada en la siguiente liga: 
> http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

Los datos pueden ser descargados de la siguiente liga: 
> https://www.dropbox.com/s/j26ksrw1jzqz2a1/getdata-projectfilesUCI%20HAR%20Dataset.zip?dl=0 

El propósito de este proyecto es demostrar habilidad para recolectar, trabajar y limpiar base de datos. El objetivo es preparar un conjunto ordenado de información que pueda ser trabajado en análisis posteriores. 

El proyecto contiene:

**BaseCompleta.txt**: Base de datos ordenada.

**CodeBook.md**: Donde aparecen las variables, la base de datos y las transformaciones que se realizaron a la misma.

**README.md**: Explica el funcionamiento de los scripts y su conexión.

**correr_analisis.R**: Es el código para hacer el análisis.

**Repositorio en GitHub**: > https://github.com/EdgarRage/Programacion_Actuarial_III


##### El análisis hace lo siguiente:

1) Une los datos de test con los de training, para crear un solo conjunto de datos.

2) Extrae únicamente las medidas de media y desviación estándar de cada medición. 

3) Usa nombres de actividad para describir los nombres de las actividades en la base de datos. 

4) Coloca etiquetas apropiadas en la base de datos con nombres de variables que las describan. 

5) Con los datos del paso 4, crea una segunda base de datos independiente con el promedio de cada variable para cada actividad y cada sujeto.

#### El código funciona así:

Une los datos de los archivos test con los de los archivos training, para crear un solo conjunto de datos. 

Primero entramos a la dirección que utilizaremos para trabajar:

setwd("~/GitHub/Programacion_Actuarial_III/Caso3/UCI HAR Dataset")    
   

Luego abrimos cada archivo necesario de test y train:

'Xtrain <- read.table("./train/X_train.txt")
'Ytrain <- read.table("./train/y_train.txt")
'Strain <- read.table("./train/subject_train.txt")

'Xtest <- read.table("./test/X_test.txt")
'Ytest <- read.table("./test/y_test.txt") 
'Stest <- read.table("./test/subject_test.txt")

Después combinamos los archivos apropiadamente y removemos lo que no utilizaremos más:

'FusX <- rbind(Xtrain, Xtest)
'FusY <- rbind(Ytrain, Ytest)
'FusS <- rbind(Strain, Stest)

'rm(Xtrain) 
'rm(Ytrain) 
'rm(Strain) 
'rm(Xtest) 
'rm(Ytest)
'rm(Stest) 

Extraemos las medidas de medición **features.txt** quitando lo innecesario de cada dato:

'feats <- read.table("./features.txt")

'promStdIndex <- grep("mean\\(\\)|std\\(\\)", feats[, 2])

Mantenemos sólo la media o la stdev:

'FusX <- FusX[, promStdIndex]

Corregimos los encabezados:

'names(FusX) <- gsub("\\(\\)", "", feats[promStdIndex, 2]) # remove "()"
'names(FusX) <- gsub("mean", "Mean", names(FusX)) # m to UpperCase
'names(FusX) <- gsub("std", "Std", names(FusX)) # s to UpperCase
'names(FusX) <- gsub("-", "", names(FusX)) # remove "-" in column names 

Borramos las variables que no usaremos en el futuro:

'rm(feats)
'rm(promStdIndex)

Usamos ahora el nombre de la actividad para llamar las actividades en la nueva base de datos, utilizando el archivo 'activity_labels.txt:

'activity <- read.table("./activity_labels.txt")
'activity[, 2] <- tolower(gsub("_", "", activity[, 2])) 
'substr(activity[2, 2], 8, 8) <- toupper(substr(activity[2, 2], 8, 8)) 
'substr(activity[3, 2], 8, 8) <- toupper(substr(activity[3, 2], 8, 8)) 
'FusY[, 1] <- activity[FusY[, 1], 2]
'names(FusY) <- "actividad"

Nombramos apropiadamente a cada variable y su actividad y removemos las que ya no usemos:

'names(FusS) <- "sujeto"
'datoslimpiados <- cbind(FusS, FusY, FusX)
'rm(FusX)
'rm(FusY)

Creamos una nueva base de datos a partir de la anterior pero con el promedio de cada medición para reducir datos:

'SLen <- length(table(FusS)) 
'activityLen <- dim(activity)[1]
'colLen <- dim(datoslimpiados)[2]
'resultad <- as.data.frame(matrix(NA, nrow=SLen*activityLen, ncol=colLen))
'colnames(resultad) <- colnames(datoslimpiados)
'j <- 1
'for(i in 1:SLen) {
  'for(k in 1:activityLen) {
    'resultad[j, 1] <- sort(unique(FusS)[, 1])[i]
    'resultad[j, 2] <- activity[k, 2]
   ' blno1 <- i == datoslimpiados$sujeto
  '  blno2 <- activity[k, 2] == datoslimpiados$actividad
 '   resultad[j, 3:colLen] <- colMeans(datoslimpiados[blno1&blno2, 3:colLen])
'    j <- j + 1
'  }
'}

Ahora borramos las variables que ya no usaremos:

'rm(activity)
'rm(FusS)
'rm(SLen)
'rm(activityLen)
'rm(blno1) 
'rm(blno2)
'rm(colLen)
'rm(i)
'rm(k)

Se crea la base de datos requerida y deseada:

'write.table(resultad, "BaseCompleta.txt", row.name=FALSE)
