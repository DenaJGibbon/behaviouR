#' Function to create a principal components biplot and add spectrograms
#'
#' @param input.dir.Focal
#' @importFrom stringr str_split_fixed
#' @importFrom tuneR readWave
#' @importFrom tuneR downsample
#' @importFrom signal specgram
#' @importFrom magick image_trim
#' @importFrom magick image_read
#' @importFrom magick image_modulate
#' @export

BiplotAddSpectrograms <-
  function(input.dir.Focal= "FocalRecordings") {

Focal.exemplars <- list.files(input.dir.Focal, full.names = T,pattern = '.wav')

print('Completing Step 1 of 3')
shadesOfGrey <- colorRampPalette(c("grey0", "grey100"))

for(a in 1:length(Focal.exemplars)){
short.temp.wav <-tuneR::readWave(Focal.exemplars[a])
Fs <- short.temp.wav@samp.rate
step <- trunc(5*Fs/1000)             # one spectral slice every 5 ms
window <- trunc(20*Fs/1000)          # 40 ms data window
fftn <- 2^ceiling(log2(abs(window))) # next highest power of 2
spg <- signal::specgram(x=short.temp.wav@left, n=fftn, Fs=Fs, window=window, overlap = 95)
S <- abs(spg$S[2:(fftn*4000/Fs),])   # magnitude in range 0<f<=4000 Hz.
S <- S/max(S)         # normalize magnitude so that max is 0 dB.
S[S < 10^(-40/10)] <- 10^(-40/10)    # clip below -40 dB.
S[S > 10^(-3/10)] <- 10^(-3/10)      # clip above -3 dB.

png(file=paste(input.dir.Focal,'/','Thumbnails/',a,'Focal.png',sep=''), width = 8, height = 4, units = 'in', res = 300)
image(t(20*log10(S)),
      col = rev(shadesOfGrey(512)),axes=F,ylim=c(0,0.5))
graphics.off()
}

FeatureDataframe <- MFCCFunction(input.dir = "FocalRecordings")

pca.out <- prcomp(FeatureDataframe[,-c(1)], scale. = TRUE)
cluster.id.df <- cbind.data.frame(pca.out$x[,1:2],FeatureDataframe$Class)
colnames(cluster.id.df) <- c("Comp.1","Comp.2","Class")
cluster.id.df$Class <- as.factor(cluster.id.df$Class)

print('Completing Step 2 of 3')
my_plot <- ggplot(data=cluster.id.df, aes(x=Comp.1,y=Comp.2,colour=Class))+
  geom_point()+
  theme_bw()

print('Completing Step 3 of 3')
for(y in 1:length(Focal.exemplars)) {

  figure1.png <- magick::image_trim(magick::image_read(paste(input.dir.Focal,'/','Thumbnails/',y,'Focal.png',sep='')))
  figure1.png <- magick::image_modulate(figure1.png,brightness = 150)


  figure1.png <- as.raster(figure1.png)

  clust.df.subset <- cluster.id.df[y,]
  xmin= clust.df.subset$Comp.1-2
  xmax=clust.df.subset$Comp.1+2
  ymin=clust.df.subset$Comp.2 +0.5
  ymax=clust.df.subset$Comp.2 -0.5
  my_plot <-
    my_plot + annotation_raster(figure1.png, xmin,xmax,ymin,ymax)
}

print(my_plot+xlab("PCA 1")+ylab("PCA 2"))
}

