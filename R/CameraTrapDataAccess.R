#' Function to access Snapshot Serengeti camera trap photos on the Labeled Information Library of Alexandria: Biology and Conservation http://lila.science/datasets/snapshot-serengeti
#'
#' @param urlpath
#' @param season
#' @param AnimalID
#' @param NumPhotos
#' @param create.dir
#'
#' @return
#' @export
#'
#' @examples

CameraTrapDataAccess <- function(
  urlpath= 'https://lilablobssc.blob.core.windows.net/snapshotserengeti-unzipped/',
  season= 11, AnimalID='leopard', NumPhotos= 5,create.dir=TRUE){


dataSet <- paste('season',season,'df','.rda',sep = '')


githubURL <- paste('https://github.com/DenaJGibbon/behaviouRdata/raw/master/data/',dataSet,sep='')

CameraTrapDf <- get(load(url(githubURL)))
CameraTrapDf

# Indicate the two animals that you will be focusing on here


if(create.dir==TRUE){
dir.create(file.path(paste('CameraTrapPhotos',AnimalID,sep='')), showWarnings = FALSE)
FilePathPhotos <- paste('CameraTrapPhotos',AnimalID, '/',sep='')
}else{
  FilePathPhotos <- getwd()
}

# Loop to download camera trap photos for the first animal
file.index <- which(CameraTrapDf$category_id==AnimalID)

if(length(file.index) > NumPhotos){
  file.index <-  sample(file.index, NumPhotos, replace = FALSE)
}

UpdatedCameraTrapDF <- data.frame()
for(b in 1:length(file.index)){ tryCatch({
  filepath <- paste(CameraTrapDf$image_id[file.index[[b]]],'.JPG',sep='')
  filename <- paste(FilePathPhotos,AnimalID,b,'.JPG',sep='')
  download.file(url=paste(urlpath,filepath,sep=''),destfile = filename)
  TempRow <- cbind.data.frame(CameraTrapDf[file.index[[b]],],filename)
  UpdatedCameraTrapDF <- rbind.data.frame(UpdatedCameraTrapDF,TempRow)
}, error=function(e){cat("ERROR :",conditionMessage(e), "\n")})
}

return(UpdatedCameraTrapDF)
}
