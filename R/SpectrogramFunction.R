#' Title
#'
#' @param input.dir
#' @param min.freq
#' @param max.freq
#' @param Colors
#'
#' @return
#' @export
#'
#' @examples

SpectrogramFunction <- function(input.dir, min.freq = 500,max.freq=2500,
                                Colors='BW') {

  call.timing.list <- list.files(input.dir,full.names = T,pattern='.wav')
  call.timing.list.short <- list.files(input.dir,full.names = F,pattern='.wav')
  Class <- str_split_fixed(call.timing.list.short,pattern = '.wav',n=2)[,1]

  subsamps <- lapply(1:length(call.timing.list),
                     function(i) readWave(call.timing.list[[i]]))

  for(j in 1:length(subsamps)) {
    short.wav <-subsamps[[j]]
    if(short.wav@samp.rate > 20000){
      short.wav <- downsample(short.wav,16000)
    }
    temp.spec <- signal::specgram(short.wav@left, Fs = short.wav@samp.rate,
                                  n = 512, overlap = 95)


    if(Colors=='BW'){
      print(plot(temp.spec, xlab = "Time (s)", ylab = "Frequency (Hz)",
                 ylim = c(min.freq, max.freq), rev(gray(0:255 / 255)),
                 axes=T,useRaster = TRUE, main=Class[j]))
    }

    if(Colors=='Colors'){
      print(plot(temp.spec, xlab = "Time (s)", ylab = "Frequency (Hz)",
                 ylim = c(min.freq, max.freq), matlab::jet.colors(256),
                 axes=T,useRaster = TRUE, main=Class[j]))
    }

  }
}
