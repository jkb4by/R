library(dplyr)
library(tidyverse)
library(tidyr)
library(ggplot2)
library(corrplot)
exercise <- iris
# Inspect dataset
glimpse(exercise)
summary(exercise) #there are NA's
# Transform datatype of Species to factor
exercise$Species <- as.factor(exercise$Species)
# Replace NA’s by median for columns with numerical values
exercise$Sepal.Length[which(is.na(exercise$Sepal.Length))] <- median(exercise$Sepal.Length, na.rm = TRUE)
exercise$Sepal.Width[which(is.na(exercise$Sepal.Width))] <- median(exercise$Sepal.Width, na.rm = TRUE)
exercise$Petal.Length[which(is.na(exercise$Petal.Length))] <- median(exercise$Petal.Length, na.rm = TRUE)
exercise$Petal.Width[which(is.na(exercise$Petal.Width))] <- median(exercise$Petal.Width, na.rm = TRUE)
# Remove row if there is NA in Species
exercise_complete <- na.omit(exercise)
summary(exercise_complete)
# Remove outliers
exercise_no_outliers <- exercise_complete %>% 
  select(Sepal.Length, Sepal.Width, Petal.Length, Petal.Width, Species) %>% 
  filter(Sepal.Length <100 & Sepal.Width <100 & Petal.Length <100 & Petal.Width <100)
boxplot(exercise_no_outliers[,1:4])
# Rename columns Species for Plants
exercise_renamed <- exercise_no_outliers %>% 
  rename(Plants = Species)
# Create extra column: Petal.Area
exercise_extra <- exercise_renamed %>% 
  mutate(Petal.Area = Petal.Length * Petal.Width)
# Glimpse dataset
glimpse(exercise_extra)
# Correlation matrix
corrData <- cor(exercise_extra[,1:4])
corrplot(corrData, method="color", order="original", addCoef.col = "gray")
my_cols <- c("#00AFBB", "#E7B800", "#FC4E07")  
pairs(exercise_extra[,1:4], pch = 19,  col = my_cols[exercise_extra$Plants])
