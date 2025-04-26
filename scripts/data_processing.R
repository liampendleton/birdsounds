install.packages("tuneR")
install.packages("seewave")
install.packages("fields")
library(here)
library(tuneR)
library(seewave)
library(fields)

#Read in Pacific Wren .wav file
pawr <- readWave(here("audio", "2024-05-09 10_45.wav")) #I recorded this using Merlin Bird ID; identified as Pacific Wren

#Visualize and listen
spectro(pawr, flim = c(1, 10)) #Create spectrogram

pawr_seg <- cutw(pawr, from = 18, to = 23, output = "Wave") #This section contains an ideal recording of PAWR call (secs 18-23)
spectro(pawr_seg, flim = c(1, 10)) #Visualize new frame
listen(pawr_seg) #duh

#Extract MFCCs from 5-second clip
pawr_mfcc <- melfcc(pawr_seg,
                    nbands = 20, #Basically resolution
                    wintime = 0.025, #Each column is going to be a visualization of 25 milliseconds
                    hoptime = 0.01, #Seconds between windows/steps. Overlap to reduce data loss and account for sounds that occur near boundaries of each window
                    numcep = 13) #First column is coefficient describing energy of the sound in that 0.025sec window. 
                                 #Remaining columns show formants/distinct frequency patterns
                                 #The brighter the color, the higher the amplitude

dim(pawr_mfcc)
head(pawr_mfcc)

#Visualize MFCCs
image.plot(t(pawr_mfcc),
           main = "MFCCs from Pacific Wren Call",
           xlab = "Time",
           ylab = "Mel-Frequency Cepstral Coefficient",
           col = viridis(100))


