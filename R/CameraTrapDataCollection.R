#' Function to print each photograph and collect data on the time the photo was taken.
#'
#' @param inputfile the dataframe output by the CameraTrapDataAccess function
#' @param rowstart if data collection was interrupted using the command 'break' which row to use to resume
#' @param dataframe.cont logical; change to 'TRUE' if data collection was interrupted
#' @param dataframe.cont logical; change to 'TRUE' if data collection was interrupted
#'
#' @importFrom magick image_ggplot
#' @importFrom magick image_read
#'
#' @return
#' @export
#'
#' @examples
CameraTrapDataCollection <- function(inputfile=CombinedAnimalDF,rowstart=1,
                                     dataframe.cont=FALSE,option='Viewer'){

if(dataframe.cont==TRUE){
  validation.df <-  CombinedAnimalDF_TimeAdded
} else{
  validation.df <- data.frame()
}

for(a in rowstart:nrow(inputfile)){
  if(option=='Viewer'){

  temp.detection.df <- inputfile[a,]
  print(image_read(as.character(temp.detection.df$filename)))
  }

  if(option=='Plot'){
    temp.detection.df <- inputfile[a,]
    temp.image <- (magick::image_read(as.character(temp.detection.df$filename)))
    print(magick::image_ggplot(temp.image))
  }

  Time <- readline(prompt = "Time taken? ")
  if(Time== 'break'){
    print('End loop')
    print(a)
    break

  }

  if(Time!= 'NA'){
  new.temp.df <-  cbind.data.frame(temp.detection.df,Time)
  validation.df <- rbind.data.frame(validation.df,new.temp.df)
  }

}
return(validation.df)
}
