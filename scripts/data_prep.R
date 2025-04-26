library(here)
library(tuneR)
library(seewave)

#Read in bird .wav files
pawr <- readWave(here("audio", "pacific_wren.wav"))
amro <- readWave(here("audio", "american_robin.wav"))
nofl <- readWave(here("audio", "northern_flicker.wav"))
sosp <- readWave(here("audio", "song_sparrow.wav"))

#Visualize via spectrogram
spectro(nofl, flim = c(1, 10)) #We can see where there is general background noise and also where the call *probably* is
listen(nofl) #Listen and monitor for where the bird call actually begins... just after the 8-second mark.

#Isolate 5-second clips from each file that feature decent example of call
pawr_seg <- cutw(pawr, from = 18, to = 23, output = "Wave")
amro_seg <- cutw(amro, from = 1, to = 6, output = "Wave")
nofl_seg <- cutw(nofl, from = 8, to = 13, output = "Wave")
sosp_seg <- cutw(sosp, from = 4, to = 9, output = "Wave")

#Throw those into a list
segments <- list(
  PAWR = pawr_seg,
  AMRO = amro_seg,
  NOFL = nofl_seg,
  SOSP = sosp_seg
)

spectro(segments$PAWR, flim = c(1, 10)) #Visualize segments. All except for PAWR call freq around 6kHz, with background noise being up to 2kHz.
listen(pawr_seg) #Note this difference is likely due to loud footsteps in PAWR recording, while others are cleaner. I wonder if later we will find it useful to omit frequencies greater than ~10kHz?



