#' Title
#'
#' @param input.dir.Focal
#' @param xmax
#' @param xmin
#' @param ymax
#' @param ymin
#'
#' @return
#' @export
#'
#' @examples
BiplotAddSpectrograms <- function(input.dir.Focal="FocalRecordings",
                                  xmax=15,xmin=-15,ymax=10,ymin=-10)
  {



Focal.exemplars <- list.files(input.dir.Focal, full.names = T,pattern = '.wav')
col.index <- unique(FeatureDataframe$Class)
color.vals <-c('black','red')

print('Completing Step 1 of 3')



pca.out <- prcomp(FeatureDataframe[,-c(1)], scale. = TRUE)
cluster.id.df <- cbind.data.frame(pca.out$x[,1:2],FeatureDataframe$Class)
colnames(cluster.id.df) <- c("Comp.1","Comp.2","Class")
cluster.id.df$Class <- as.factor(cluster.id.df$Class)

print('Completing Step 2 of 3')
my_plot <- ggplot(data=cluster.id.df, aes(x=Comp.1,y=Comp.2,colour=Class))+
  geom_point()+
  #geom_text(label=cluster.id.df$cluster.id)+
  scale_color_manual(values =color.vals)+
  theme_bw()+xlim(xmin,xmax)+ylim(ymin,ymax)

my_plot

print('Completing Step 3 of 3')
for(y in 1:length(Focal.exemplars)) {

  #print(y, 'out of', length(Focal.exemplars))
  figure1.png <- image_trim(magick::image_read(paste(input.dir.Focal,'/','Thumbnails/',y,'Focal.png',sep='')))
  figure1.png <- image_modulate(figure1.png,brightness = 150)

  figure1.png <- image_border(figure1.png,col=color.vals[cluster.id.df[y,]$Class==col.index])

  figure1.png <- as.raster(figure1.png)
  #exemplar.index <- Focal.cluster.results@idx[y]

  clust.df.subset <- cluster.id.df[y,]
  xmin= clust.df.subset$Comp.1-4
  xmax=clust.df.subset$Comp.1+4
  ymin=clust.df.subset$Comp.2 +2
  ymax=clust.df.subset$Comp.2 -2
  my_plot <-
    my_plot + annotation_raster(figure1.png, xmin,xmax,ymin,ymax)
}


print(my_plot+xlab("PCA 1")+ylab("PCA 2"))
}

