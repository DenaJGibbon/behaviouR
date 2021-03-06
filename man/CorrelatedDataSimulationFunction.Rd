% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/CorrelatedDataSimulationFunction.R
\name{CorrelatedDataSimulationFunction}
\alias{CorrelatedDataSimulationFunction}
\title{This function simulates a population of deer males where reproductive success is correlated with body size}
\usage{
CorrelatedDataSimulationFunction(
  N = 100,
  CorrelationCoefficient = 0.83,
  MaleMeanBodyWeight = 125,
  MaleReproductiveSuccess = 3
)
}
\arguments{
\item{N}{the number of individuals in the simulated population}

\item{CorrelationCoefficient}{the correlation value of the two variables}

\item{MaleMeanBodyWeight}{mean body weight of males in the population}

\item{MaleReproductiveSuccess}{mean male reproductice success}
}
\value{
a dataframe
}
\description{
This function simulates a population of deer males where reproductive success is correlated with body size
}
\examples{
CorrelatedDataSimulationFunction(N=5,CorrelationCoefficient= 0.45,
MaleMeanBodyWeight = 125,MaleReproductiveSuccess = 3)
}
