#' Title
#'
#' @param N
#' @param CorrelationCoefficient
#' @param MaleMeanBodyWeight
#' @param MeanFemalesInHarem
#'
#' @return
#' @export
#'
#' @examples

CorrelatedDataSimulationFunction <- function(N=100,CorrelationCoefficient=0.83,
                                             MaleMeanBodyWeight = 125,
                                             MeanFemalesInHarem = 3){

# First we assign the number of observations we want to have in our dataset; I start with 100.
NObservations <- N

# Second we decide how correlated we want our two variables to be. A value of 0 means no correlation and a value of 1 means they are perfectly correlated.
CorrelationCoefficient <- CorrelationCoefficient

# Third we assign a mean body weight for males in our population (I got this value from Reby D, McComb K. Anatomical constraints generate honesty: acoustic cues to age and weight in the roars of red deer stags. Animal behaviour. 2003 Mar 1;65(3):519-30.)
MaleMeanBodyWeight <- MaleMeanBodyWeight


# Fourth we assign a mean number of females in a male's harem
MeanFemalesInHarem <- MeanFemalesInHarem

# Now, we use a fancy data simulator to simulate our correlated data
MaleRedDeerSimulatedData = mvrnorm(n=NObservations, mu=c(MaleMeanBodyWeight, MeanFemalesInHarem), Sigma=matrix(c(1, CorrelationCoefficient, CorrelationCoefficient, 1), nrow=2), empirical=TRUE)

# We isloate our new data
MaleBodyWeight = MaleRedDeerSimulatedData[, 1]
FemalesInHarem= MaleRedDeerSimulatedData[, 2]

# Check the correlation of the data to make sure it matches our specified correlation
cor(MaleBodyWeight,FemalesInHarem)

# We then combine our data into a new dataframe
MaleRedDeerDF <- cbind.data.frame(MaleBodyWeight,FemalesInHarem)
return(MaleRedDeerDF)
}
