---
title: "CodeBook"
author: "Edgar Ram�rez"
date: "15 de junio de 2016"
output: html_document
---

# Facultad de Ciencias F�sico Matem�ticas BUAP

## Licenciatura en Actuaria

## Programaci�n Actuarial III

### CodeBook :Reconocimiento de Actividad Humana con Celulares

#### Edgar Ram�rez Gonz�lez


## Informaci�n de la base de datos.

Los experimentos fueron realizados con un grupo de 30 voluntarios dentro de una edad entre los 19 y 48 a�os.
Cada persona realiz� 6 actividades:
(WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING).
Cargando un smartphone (Samsung Galaxy S II) en la cintura.

Haciendo uso de su aceler�metro incorporado y giroscopio, se ha capturado la aceleraci�n lineal 3-axial y velocidad angular 3-axial a una velocidad constante de 50 Hz.
Los experimentos han sido grabados en v�deo para etiquetar los datos de forma manual. 
El conjunto de datos obtenidos se ha dividido aleatoriamente en dos grupos, en los que se seleccion� el 70% de los voluntarios para la generaci�n de los datos de entrenamiento y 30% de los datos de prueba.

Las se�ales del sensor (aceler�metro y giroscopio) fueron pre-procesados mediante la aplicaci�n de filtros de ruido y luego se muestrean en deslizamiento de ancho fijo ventanas de 2,56 seg y 50% de solapamiento (128 lecturas / ventana). 
La se�al de aceleraci�n del sensor, que tiene componentes gravitacionales y el movimiento del cuerpo, se separ� usando un filtro de paso bajo Butterworth en aceleraci�n cuerpo y la gravedad.
La fuerza de la gravedad se supone que tiene s�lo componentes de baja frecuencia, por lo tanto, se utiliz� un filtro con 0,3 Hz frecuencia de corte.
A partir de cada ventana, un vector de caracter�sticas se obtuvo mediante el c�lculo de las variables de tiempo y el dominio de la frecuencia.

## Para cada registro se proporcion�:
======================================

- Triaxial acceleration del acelerometro (total acceleration) y el estimado de la aceleraci�n corporal.
- Triaxial Angular velocity del giroscopio
- Un vector de 561 variables de tiempo y el dominio de la frecuencia. 
- Sus etiquetas de actividades.
- Un identificador del voluntario que particip� en el experimento.

## El dataset incluye:
=========================================

- 'README.txt'

- 'features_info.txt': Muestra informaci�n de los vectores usados..

- 'features.txt': Una lista de todas las caracter�sticas.

- 'activity_labels.txt': V�ncula las etiquetas con sus actividades.

- 'train/X_train.txt': Conjunto del Training.

- 'train/y_train.txt': Etiquetas del Training.

- 'test/X_test.txt': Conjunto del Test.

- 'test/y_test.txt': Etiquetas del Test.

Las se�ales fueron utilizadas para estimar variables del vector para cada patr�n:
'-XYZ' es utilizado para denotar se�ales de 3 ejes en direcciones X, Y y Z.

-tBodyAcc-XYZ  
-tGravityAcc-XYZ  
-tBodyAccJerk-XYZ  
-tBodyGyro-XYZ  
-tBodyGyroJerk-XYZ  
-tBodyAccMag  
-tGravityAccMag  
-tBodyAccJerkMag  
-tBodyGyroMag  
-tBodyGyroJerkMag  
-fBodyAcc-XYZ  
-fBodyAccJerk-XYZ  
-fBodyGyro-XYZ  
-fBodyAccMag  
-fBodyAccJerkMag  
-fBodyGyroMag  
-fBodyGyroJerkMag  

El conjunto de variables que se estimaron a partir de estas se�ales son:

mean(): Mean value  
std(): Standard deviation  
mad(): Median absolute deviation   
max(): Largest value in array  
min(): Smallest value in array  
sma(): Signal magnitude area  
energy(): Energy measure. Sum of the squares divided by the number of values.   
maxInds(): index of the frequency component with largest magnitude  
meanFreq(): Weighted average of the frequency components to obtain a mean frequency  
skewness(): skewness of the frequency domain signal   
iqr(): Interquartile range   
entropy(): Signal entropy  
arCoeff(): Autorregresion coefficients with Burg order equal to 4  
correlation(): correlation coefficient between two signals  
kurtosis(): kurtosis of the frequency domain signal   
bandsEnergy(): Energy of a frequency interval within the 64 bins of the FFT of each window. 
angle(): Angle between to vectors.  

Vectores adicionales obtenidos mediante las se�ales en una muestra de ventana de se???al. Son utilizados en la variable angle():

gravityMean  
tBodyAccMean  
tBodyAccJerkMean  
tBodyGyroMean  
tBodyGyroJerkMean  

## Transformaciones.

Se modific� la base de datos original en orden de llevar a acabo el an�lisis requerido, las siguientes son las transformaciones hechas:

1) Los datos de test y los de training se juntaron. En la versi???n original se encuentran divididos en dos archivos.

2) Un conjunto de datos con las medidas de media y desviaci�n est�ndar. Lo cual significa que de los 561 datos en el vector, se redujeron a 66.

3)Se agregaron a la base de datos los voluntarios y las actividades. El voluntario es un entero entre 1 - 30 y la actividad es el vector que describe 6 actividades:

 1. WALKING   
 2. WALKING_UPSTAIRS  
 3. WALKING_DOWNSTAIRS  
 4. SITTING  
 5. STANDING  
 6. LAYING  

4) Las columnas se volvieron a etiquetar para nuestro analisis.

#### Nombre original: `tBodyGyroJerk-mean()-X`
#### Nuevo nombre: `MeanOfTimeBodyGyroJearkMeanX`

5) Todos los nuevos valores son promedios, agregados 30 voluntarios y 6 actividades, por lo tanto, el conjunto de datos resultante es de 68 columnas y 180 filas.