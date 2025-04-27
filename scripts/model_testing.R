library(here)
library(tuneR)
library(dplyr)
library(randomForest)

source(here("Scripts", "processing_function.R"))

#Read in model
bird_id <- function(wav_path) {
  bird_wav <- readWave(wav_path) #Read in user input
    mfccs <- process_wav(list(bird_wav)) #Process data
  pred <- predict(bird_id, newdata = mfccs) #Predict based on library/trained model
  species_pred <- names(sort(table(pred), decreasing = TRUE))[1] #Show top prediction
  message("The model predicts this recording is: ", species_pred) #Fun message
  return(species_pred)
}

#Take it for a spin
result <- bird_id(here("data", "testing_audio", "song_sparrow4.wav")) #Switch out x.wav to file you want to identify

