library(here)
library(tuneR)
library(dplyr)
library(randomForest)

source(here("Scripts", "processing_function.R")) #Function to process data
birdid_model <- readRDS(here("data", "output", "birdid_model.rds")) #Trained model

#Read in model
bird_id <- function(wav_path) {
  bird_wav <- list("BIRD" = list(readWave(wav_path))) #Put input into list to prepare for function
  mfccs <- process_wav(bird_wav) #Use processing function
    print(head(mfccs,15))
    pred <- predict(birdid_model, newdata = mfccs) #Predict species based on library
  species_pred <- names(sort(table(pred), decreasing = TRUE))[1] # Show top prediction
  
  message("The model predicts this recording is: ", species_pred) #Fun message
  return(species_pred)
}

#Take it for a spin
bird_id(here("data", "testing_audio", "berwicks_wren2.wav")) #Switch out x.wav to file you want to identify



