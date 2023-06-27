ma <- as.matrix(iris[, 1:4]) # convert to matrix
disMatarix <- dist(ma)
plot(hclust(disMatarix))
heatmap(ma,
        scale = "column",
        RowSideColors = rainbow(3)[iris$Species]
)
install.packages("pheatmap")
library(pheatmap)
ma <- as.matrix(iris[, 1:4]) # convert to matrix
row.names(ma) <- row.names(iris) # assign row names in the matrix
pheatmap(ma,
         scale = "column",
         clustering_method = "average", # average linkage
         annotation_row = iris[, 5, drop = FALSE], # the 5th column as color bar
         show_rownames = FALSE
)
pca <- prcomp(iris[, 1:4], scale = TRUE)
pca # Have a look at the results.
plot(pca) # plot the amount of variance each principal components captures.
str(pca) # this shows the structure of the object, listing all parts.
head(pca$x) # the new coordinate values for each of the 150 samples
pcaData <- as.data.frame(pca$x[, 1:2]) # extract first two columns and convert to data frame
pcaData <- cbind(pcaData, iris$Species) # bind by columns
colnames(pcaData) <- c("PC1", "PC2", "Species") # change column names

library(ggplot2)
ggplot(pcaData) +
  aes(PC1, PC2, color = Species, shape = Species) + # define plot area
  geom_point(size = 2) # adding data points
percentVar <- round(100 * summary(pca)$importance[2, 1:2], 0) # compute % variances
ggplot(pcaData, aes(PC1, PC2, color = Species, shape = Species)) + # starting ggplot2
  geom_point(size = 2) + # add data points
  xlab(paste0("PC1: ", percentVar[1], "% variance")) + # x label
  ylab(paste0("PC2: ", percentVar[2], "% variance")) + # y label
  ggtitle("Principal component analysis (PCA)") + # title
  theme(aspect.ratio = 1) # width and height ratio
