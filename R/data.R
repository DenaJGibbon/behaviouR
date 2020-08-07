#' A simulated data set indicating male red deer roars per minute as a function of mating season or harem-holding status.
#'
#' This dataset contains two variables: MaleCategory and RoarsPerMinute
#'
#' @format A data frame with 20 rows and 2 variables:
#' \describe{
#'   \item{MaleCategory}{MaleCategory, PreMatingSeason, HaremHolders, NotHaremHolders or PostMatingSeason"}
#'   \item{RoarsPerMinute}{Mean number of roars per minute}
#'   ...
#' }
#' @source Clutton-Brock, T. H., & Albon, S. D. (1979). The roaring of red deer and the evolution of honest advertisement. Behaviour, 69(3-4), 145-170.
"MaleDeerRoarDF"

#' A toy dataset of red deer, sika deer and red x sika hybrid vocalizations.
#'
#' This dataset contains four vocalizations per individual and three aspects of the vocalizations: the duration, the minimum frequency and the maximum frequency of the vocalization
#'
#' @format A data frame with 12 rows and 4 variables:
#' \describe{
#'   \item{Class}{RedDeer, Hybrids Sikas}
#'   \item{Duration}{Simulated duration of vocalizations}
#'   \item{MinFrequency}{Simulated minimum frequency of vocalizations}
#'   \item{MaxFrequency}{Simulated maximum frequency of vocalizations}
#'   ...
#' }
#' @source Long, A. M., N. P. Moore, and T. J. Hayden. “Vocalizations in red deer (Cervus elaphus), sika deer (Cervus nippon), and red× sika hybrids.” Journal of Zoology 244.1 (1998): 123-134.
"DeerSpeciesAcousticFeatures"

#' An example dataset from the Vigilance Behaviour in Barnacle Geese (1997) video produced for the Association for the Study of Animal Behaviour  .
#'
#' This dataset is based off data collected from this video: https://www.youtube.com/watch?v=oeJHW5n-PXY
#'
#' @format A data frame with 12 rows and 5 variables:
#' \describe{
#'   \item{Flock}{Index indicating which video the data were taken from}
#'   \item{FlockSize}{The number of animals in the flock}
#'   \item{TotalHeadsUp}{How many times the animal looked up}
#'   \item{TimeSecHeadUp}{The total duration (s) the animal was vigilant}
#'   \item{Partner}{Which partner collected the data}
#'   ...
#' }
#' @source https://www.asab.org/
"BarnacleGooseData"

#' A simulated dataset from two censuses conducted along a 500 m transect
#'
#' In this dataset students indicate all species that they detect along a 500-m transect.
#'
#' @format A data frame with 78 rows and 6 variables:
#' \describe{
#'   \item{Species}{Which species was detected}
#'   \item{DistanceAlongTransect}{How far along the transect line the animal was detected}
#'   \item{PerpendicularDistance}{Perpendicular distance from the transect line}
#'   \item{MethodDetection}{How the animal was detected}
#'   \item{Site}{A variable indicating which transect line}
#'   \item{Partner}{Which partner collected the data}
#'   ...
#' }
#' @source NA
"CensusData"

#' A dataframe containing camera trap data annotations from Snapshot serengeti of zebra and wildebeest
#'
#' This is an example of how the dataset will look after students collect data using both 'CameraTrapDataAccess' and 'CameraTrapDataCollection' functions
#'
#' @format A data frame with 296 rows and 5 variables:
#' \describe{
#'   \item{category_id}{A factor indicating which species was detected}
#'   \item{season}{A factor indicating the season the image was taken}
#'   \item{location}{The camera trap location}
#'   \item{filename}{The file path of the downloaded image}
#'   \item{Time }{The time (in hours on the 24-hour clock) that the image was taken}
#'   ...
#' }
#' @source Swanson AB, Kosmala M, Lintott CJ, Simpson RJ, Smith A, Packer C (2015) Snapshot Serengeti, high-frequency annotated camera trap images of 40 mammalian species in an African savanna. Scientific Data 2: 150026.
#' @source http://lila.science/datasets/snapshot-serengeti
"CombinedDFTimes"

#' A dataframe containing camera trap data annotations from Snapshot serengeti of leopards and cheetahs
#'
#' This is an example of how the dataset will look after students collect data using both 'CameraTrapDataAccess' and 'CameraTrapDataCollection' functions
#'
#' @format A data frame with 265 rows and 5 variables:
#' \describe{
#'   \item{category_id}{A factor indicating which species was detected}
#'   \item{season}{A factor indicating the season the image was taken}
#'   \item{location}{The camera trap location}
#'   \item{filename}{The file path of the downloaded image}
#'   \item{Time }{The time (in hours on the 24-hour clock) that the image was taken}
#'   ...
#' }
#' @source Swanson AB, Kosmala M, Lintott CJ, Simpson RJ, Smith A, Packer C (2015) Snapshot Serengeti, high-frequency annotated camera trap images of 40 mammalian species in an African savanna. Scientific Data 2: 150026.
#' @source http://lila.science/datasets/snapshot-serengeti
"CombinedPartnerDFTimes"
