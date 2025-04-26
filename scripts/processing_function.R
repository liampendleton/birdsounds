library(tuneR)
library(dplyr)

#Function to process .wav files from bird species and extract MFCCs
process_wav <- function(audio_list, 
                        nbands = 20, #Basically resolution
                        wintime = 0.025, #Each column is 25 milliseconds bc birds talk fast
                        hoptime = 0.01, #Seconds between windows/steps. Overlap to reduce data loss and account for sounds that occur near boundaries of each window, allowing for more continuous transition between steps
                        numcep = 13) {#First column is coefficient describing "energy" of the sound in that 0.025sec window.
  
  #Loop through each segment using values that generally seem to work and return MFCCs for each
  mfcc_list <- lapply(names(audio_list), function(species) {
    mfcc <- melfcc(audio_list[[species]],
                   nbands = nbands,
                   wintime = wintime,
                   hoptime = hoptime,
                   numcep = numcep)
    
    df <- as.data.frame(mfcc)
    df$species <- species
    return(df)
  })
  
  #Combine data frames into one
  mfcc_data <- bind_rows(mfcc_list)
  
  #Rename cols for clarity
  colnames(mfcc_data)[1:numcep] <- paste0("MFCC_", 1:numcep)
  
  return(mfcc_data)
}