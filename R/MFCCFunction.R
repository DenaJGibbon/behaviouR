#' Function to calculate Mel-frequency cepstral coefficents over a list of focal recordings
#'
#' @param input.dir where the .wav files are stored
#' @param min.freq the minimum frequency (Hz) of the signal of interest
#' @param max.freq the maximum frequency (Hz) of the signal of interest
#' @param n.windows the number of time windows to divide the signal by
#' @param num.cep the number of cepstra to calculate for each time window
#' @importFrom tuneR readWave
#' @importFrom stringr str_split_fixed
#' @importFrom seewave duration
#' @importFrom tuneR melfcc
#' @return
#' @export
#'
#' @examples

MFCCFunction <-
  function(input.dir, min.freq = 200, max.freq = 2000,
           n.windows = 9, num.cep = 12) {

    call.timing.list <- list.files(input.dir,full.names = T,pattern='.wav')

    call.timing.list.short <- list.files(input.dir,full.names = F,pattern='.wav')
    subsamps <- lapply(1:length(call.timing.list),
                       function(i) readWave(call.timing.list[[i]]))


    mfcc.vector.list <- list()
    Class <- stringr::str_split_fixed(call.timing.list.short,pattern = '_',n=2)[,1]
    for(x in 1:length(subsamps)){
      print(paste("processing sound event", x, 'out of',length(subsamps) ))

      short.wav <- subsamps[[x]]
      wav.dur <- duration(short.wav)
      win.time <- wav.dur/n.windows

      # Calculate MFCCs
      melfcc.output <- tuneR::melfcc(short.wav, minfreq = min.freq,
                                     hoptime = win.time, maxfreq = max.freq,
                                     numcep = num.cep, wintime = win.time)

      # Calculate delta cepstral coefficients
      deltas.output <- tuneR::deltas(melfcc.output)

      # Ensure only same number of time windows are used for MFCC and delta coefficients Also append .wav duration
      mfcc.vector <- c(as.vector(t(melfcc.output[1:(n.windows - 1), 2:num.cep])), as.vector(t(deltas.output[1:(n.windows - 1), 2:num.cep])), wav.dur)
      mfcc.vector.list[[x]] <- mfcc.vector
    }

    mfcc.output <- mfcc.vector.list
    Class <- stringr::str_split_fixed(call.timing.list.short,pattern = '_',n=2)[,1]

    mfcc.output.df <- do.call(rbind.data.frame,mfcc.output)
    colnames(mfcc.output.df) <- seq(from=1, to=ncol(mfcc.output.df),by=1)

    mfcc.output.df <- cbind.data.frame(Class,mfcc.output.df)
    return(mfcc.output.df)


  }
