#' Function to print each photograph and collect data on the time the photo was taken.
#'
#' @param inputfile the dataframe output by the CameraTrapDataAccess function
#' @param rowstart if data collection was interrupted using the command 'break' which row to use to resume
#' @param dataframe.cont logical; change to 'TRUE' if data collection was interrupted
#'
#' @return
#' @export
#'
#' @examples
CameraTrapDataCollection <- function(inputfile=CombinedAnimalDF,rowstart=1,
                                     dataframe.cont=FALSE){

if(dataframe.cont==TRUE){
  validation.df <-  CombinedAnimalDF_TimeAdded
} else{
  validation.df <- data.frame()
}

for(a in rowstart:nrow(inputfile)){
  temp.detection.df <- inputfile[a,]
  print(image_read(as.character(temp.detection.df$filename)))


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
