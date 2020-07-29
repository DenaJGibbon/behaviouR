#' Title
#'
#' @param input.dir
#' @param min.freq
#' @param max.freq
#'
#' @return
#' @export
#'
#' @examples

SpectrogramFunctionSite <- function(input.dir, min.freq = 500,max.freq=2500) {

  call.timing.list <- list.files(input.dir,full.names = T,pattern='.wav')
  call.timing.list.short <- list.files(input.dir,full.names = F,pattern='.wav')
  Class <- str_split_fixed(call.timing.list.short,pattern = '.wav',n=2)[,1]

  subsamps <- lapply(1:length(call.timing.list),
                     function(i) readWave(call.timing.list[[i]]))

  for(j in 1:length(subsamps)) {
    short.wav <-subsamps[[j]]

    temp.spec <- signal::specgram(short.wav@left, Fs = short.wav@samp.rate,
                                  n = 512, overlap = 95)


    zcolors = colorRampPalette (c('dark blue','blue','cyan','light green','yellow',
                                  'orange','red', 'brown'))

    print(plot(temp.spec, xlab = "Time (s)", ylab = "Frequency (Hz)",
               ylim = c(min.freq, max.freq), zcolors(512),
               axes=T,useRaster = TRUE, main=Class[j]))

  }
}
