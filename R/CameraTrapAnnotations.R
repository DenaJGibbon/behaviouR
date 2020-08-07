#' Function to create a table of available camera trap annotations by season
#'
#' @param season which season to query; options are 1-4, 6-8,10,11
#'
#' @return
#' @export
#'
#' @examples
#' \donttest{CameraTrapAnnotations(season=4)}

CameraTrapAnnotations <- function( season= 4){

dataSet <- paste('season',season,'df','.rda',sep = '')

githubURL <- paste('https://github.com/DenaJGibbon/behaviouRdata/raw/master/data/',dataSet,sep='')
CameraTrapDf <- get(load(url(githubURL)))

return(table(CameraTrapDf$category_id))
}

