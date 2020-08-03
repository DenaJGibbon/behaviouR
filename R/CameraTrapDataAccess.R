#' Function to access Snapshot Serengeti camera trap photos on the Labeled Information Library of Alexandria: Biology and Conservation http://lila.science/datasets/snapshot-serengeti
#'
#' @param urlpath location of Snapshot Serengeti database
#' @param season which season to query; options are 1-4, 6-8,10,11
#' @param AnimalID which animal photos to download
#' @param NumPhotos the number of photos to download
#' @param create.dir logical; create a new directory (TRUE) or save to current working directory (FALSE)
#'
#' @return
#' @export
#'
#' @examples

CameraTrapDataAccess <- function(
  urlpath= 'https://lilablobssc.blob.core.windows.net/snapshotserengeti-unzipped/',
  season= list(1,2), AnimalID='leopard', NumPhotos= 5,create.dir=TRUE){


if(create.dir==TRUE){
dir.create(file.path(paste('CameraTrapPhotos',AnimalID,sep='')), showWarnings = FALSE)
FilePathPhotos <- paste('CameraTrapPhotos',AnimalID, '/',sep='')
}else{
  FilePathPhotos <- getwd()
}

UpdatedCameraTrapDF <- data.frame()
for(a in 1:length(season)){

  dataSet <- paste('season',season[a],'df','.rda',sep = '')

  githubURL <- paste('https://github.com/DenaJGibbon/behaviouRdata/raw/master/data/',dataSet,sep='')
  CameraTrapDf <- get(load(url(githubURL)))
  CameraTrapDf

  # Loop to download camera trap photos for the first animal
file.index <- which(CameraTrapDf$category_id==AnimalID)

if(length(file.index) > NumPhotos){
  file.index <-  sample(file.index, NumPhotos, replace = FALSE)
}


for(b in 1:length(file.index)){ tryCatch({
  filepath <- paste(CameraTrapDf$image_id[file.index[[b]]],'.JPG',sep='')
  whichseason <- CameraTrapDf$season[file.index[[b]]]
  location <- CameraTrapDf$location[file.index[[b]]]
  filename <- paste(FilePathPhotos,AnimalID,'_',whichseason,'_',location,'.JPG',sep='')
  download.file(url=paste(urlpath,filepath,sep=''),destfile = filename)
  TempRow <- cbind.data.frame(CameraTrapDf[file.index[[b]],],filename)
  UpdatedCameraTrapDF <- rbind.data.frame(UpdatedCameraTrapDF,TempRow)
}, error=function(e){cat("ERROR :",conditionMessage(e), "\n")})
}
}

return(UpdatedCameraTrapDF)
}
