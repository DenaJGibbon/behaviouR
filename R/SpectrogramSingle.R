#' Title
#'
#' @param sound.file
#' @param min.freq
#' @param max.freq
#' @param Colors
#' @param downsample
#'
#' @return
#' @export
#'
#' @examples

SpectrogramSingle <- function(sound.file, min.freq = 500,max.freq=8000,
                              Colors='BW',downsample=TRUE) {

  short.wav <- readWave(sound.file)
  if(downsample==TRUE){
  if(short.wav@samp.rate > 20000){
    short.wav <- downsample(short.wav,16000)
  }}
  Name <- str_split_fixed(sound.file,pattern = '.wav',n=2)[,1]
  Name <- str_split_fixed(Name,pattern = '/',n=2)[,2]


    temp.spec <- signal::specgram(short.wav@left, Fs = short.wav@samp.rate,
                                  n = 1024, overlap = 95)
    if(Colors=='BW'){
    print(plot(temp.spec, xlab = "Time (s)", ylab = "Frequency (Hz)",
               ylim = c(min.freq, max.freq), rev(gray(0:255 / 255)),
               axes=T,useRaster = TRUE, main=Name))
      }

    if(Colors=='Colors'){
      print(plot(temp.spec, xlab = "Time (s)", ylab = "Frequency (Hz)",
                 ylim = c(min.freq, max.freq), (matlab::jet.colors(256)),
                 axes=T,useRaster = TRUE, main=Name))
      }
  }

