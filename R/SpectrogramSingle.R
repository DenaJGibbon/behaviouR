#' Code to calculate a spectrogram for a single sound file
#'
#' @param sound.file The location of the .wav file
#' @param min.freq The minimum frequency (Hz) of the signal of interest
#' @param max.freq The maximum frequency (Hz) of the signal of interest
#' @param Colors Whether to return a black and white or color spectrogram
#' @param downsample If the sound file should be downsampled before creating the spectrogram
#' @param downsample.new <- The frequency (Hz) to downsample to
#' @importFrom stringr str_split_fixed
#' @importFrom tuneR readWave
#' @importFrom tuneR downsample
#' @importFrom signal specgram
#' @importFrom graphics plot
#' @importFrom grDevices gray
#' @return a spectrogram image
#' @export
#'
#' @examples
#' \donttest{SpectrogramSingle(sound.file ="FocalRecordings/FemaleGibbon_1.wav",
#' min.freq = 500,max.freq=2500,Colors = 'Colors')}

SpectrogramSingle <- function(sound.file, min.freq = 500,max.freq=8000,
                              Colors='BW',downsample=TRUE,downsample.new=16000) {

  short.wav <- readWave(sound.file)
  if(downsample==TRUE){
  if(short.wav@samp.rate > 20000){
    short.wav <- downsample(short.wav,downsample.new)
  }}
  Name <- stringr::str_split_fixed(sound.file,pattern = '.wav',n=2)[,1]
  Name <- stringr::str_split_fixed(Name,pattern = '/',n=2)[,2]

  short.wav <- tuneR::normalize(short.wav)
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

