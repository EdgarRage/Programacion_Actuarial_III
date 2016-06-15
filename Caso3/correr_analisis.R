setwd("~/GitHub/Programacion_Actuarial_III/Caso3/UCI HAR Dataset")    

Xtrain <- read.table("./train/X_train.txt")
Ytrain <- read.table("./train/y_train.txt")
Strain <- read.table("./train/subject_train.txt")

Xtest <- read.table("./test/X_test.txt")
Ytest <- read.table("./test/y_test.txt") 
Stest <- read.table("./test/subject_test.txt")

FusX <- rbind(Xtrain, Xtest)
FusY <- rbind(Ytrain, Ytest)
FusS <- rbind(Strain, Stest)

rm(Xtrain) 
rm(Ytrain) 
rm(Strain) 
rm(Xtest) 
rm(Ytest)
rm(Stest) 

feats <- read.table("./features.txt")

promStdIndex <- grep("mean\\(\\)|std\\(\\)", feats[, 2])

FusX <- FusX[, promStdIndex]

names(FusX) <- gsub("\\(\\)", "", feats[promStdIndex, 2]) 
names(FusX) <- gsub("mean", "Mean", names(FusX)) 
names(FusX) <- gsub("std", "Std", names(FusX)) 
names(FusX) <- gsub("-", "", names(FusX)) 

rm(feats)
rm(promStdIndex)


activity <- read.table("./activity_labels.txt")
activity[, 2] <- tolower(gsub("_", "", activity[, 2])) 
substr(activity[2, 2], 8, 8) <- toupper(substr(activity[2, 2], 8, 8)) 
substr(activity[3, 2], 8, 8) <- toupper(substr(activity[3, 2], 8, 8)) 
FusY[, 1] <- activity[FusY[, 1], 2]
names(FusY) <- "actividad"


names(FusS) <- "sujeto"
datoslimpiados <- cbind(FusS, FusY, FusX)
rm(FusX)
rm(FusY)


SLen <- length(table(FusS)) 
activityLen <- dim(activity)[1]
colLen <- dim(datoslimpiados)[2]
resultad <- as.data.frame(matrix(NA, nrow=SLen*activityLen, ncol=colLen))
colnames(resultad) <- colnames(datoslimpiados)
j <- 1
for(i in 1:SLen) {
  for(k in 1:activityLen) {
    resultad[j, 1] <- sort(unique(FusS)[, 1])[i]
    resultad[j, 2] <- activity[k, 2]
    blno1 <- i == datoslimpiados$sujeto
    blno2 <- activity[k, 2] == datoslimpiados$actividad
    resultad[j, 3:colLen] <- colMeans(datoslimpiados[blno1&blno2, 3:colLen])
    j <- j + 1
  }
}

rm(activity)
rm(FusS)
rm(SLen)
rm(activityLen)
rm(blno1) 
rm(blno2)
rm(colLen)
rm(i)
rm(k)

write.table(resultad, "BaseCompleta.txt", row.name=FALSE)
