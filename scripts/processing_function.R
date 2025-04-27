library(tuneR)
library(dplyr)

#Function to process .wav files from bird species and extract MFCCs
process_wav <- function(audio_list, 
                        nbands = 20, #Basically resolution
                        wintime = 0.025, #Each column is 25 milliseconds bc birds talk fast
                        hoptime = 0.01, #Seconds between windows/steps. Overlap to reduce data loss and account for sounds that occur near boundaries of each window, allowing for more continuous transition between steps
                        numcep = 13) {#First column is coefficient describing "energy" of the sound in that 0.025sec window.
  
  #Loop through each species in library
  mfcc_list <- lapply(names(audio_list), function(species) {
    
    #Loop through each clip for each species
    clips <- audio_list[[species]]
    clip_mfccs <- lapply(clips, function(clip) {
            mfcc <- melfcc(clip,
                     nbands = nbands,
                     wintime = wintime,
                     hoptime = hoptime,
                     numcep = numcep)
            df <- as.data.frame(mfcc)
      df$species <- species
      return(df)
    })
    
    #Bind all clips for a species together
    bind_rows(clip_mfccs)
  })
  
  mfcc_data <- bind_rows(mfcc_list)
  colnames(mfcc_data)[1:numcep] <- paste0("MFCC_", 1:numcep) #Rename cols
  return(mfcc_data)
}
