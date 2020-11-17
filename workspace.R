library(bnshiny)
library(bnutil)
library(dplyr)
library(pooledsd)

getdata = function() {
  load("./inst/extdata/aCubeDump.RData")
  data
}

setResult = function(annotatedResult){
  result = annotatedResult$data
}

bnMessageHandler = bnshiny::BNMessageHandler$new()
bnMessageHandler$getDataHandler = getdata
bnMessageHandler$setResultHandler = setResult


bnshiny::startBNTestShiny('pooledsd', sessionType='run', bnMessageHandler=bnMessageHandler)
