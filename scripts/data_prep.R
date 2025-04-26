library(here)
library(tuneR)
library(seewave)

#Read in bird .wav files
pawr <- readWave(here("data", "training_audio", "pacific_wren.wav"))
amro <- readWave(here("data", "training_audio", "american_robin.wav"))
nofl <- readWave(here("data", "training_audio", "northern_flicker.wav"))
sosp1 <- readWave(here("data", "training_audio", "song_sparrow.wav"))
sosp2 <- readWave(here("data", "training_audio", "song_sparrow2.wav"))
sosp3 <- readWave(here("data", "training_audio", "song_sparrow3.wav"))
bewr <- readWave(here("data", "training_audio", "berwicks_wren.wav"))

#Visualize via spectrogram
# spectro(nofl, flim = c(1, 10)) #We can see where there is general background noise and also where the call *probably* is
# listen(nofl) #Listen and monitor for where the bird call actually begins... just after the 8-second mark.

#Isolate 5-second clips from each file that feature decent example of call
pawr_seg <- cutw(pawr, from = 18, to = 23, output = "Wave")
amro_seg <- cutw(amro, from = 1, to = 6, output = "Wave")
nofl_seg <- cutw(nofl, from = 8, to = 13, output = "Wave")
sosp_seg <- cutw(sosp1, from = 4, to = 9, output = "Wave")
sosp2_seg <- cutw(sosp2, from = 1, to = 4, output = "Wave")
sosp3_seg <- cutw(sosp3, from = 7.75, to = 11, output = "Wave")
bewr_seg <- cutw(bewr, from = 0.25, to = 2.25, output = "Wave")


#Throw those into a list
audio_list <- list(
  AMRO = list(amro_seg),
  SOSP = list(sosp_seg, sosp2_seg, sosp3_seg),
  NOFL = list(nofl_seg),
  PAWR = list(pawr_seg),
  BEWR = list(bewr_seg)
)

# spectro(segments$PAWR, flim = c(1, 10)) #Visualize segments. All except for PAWR call freq around 6kHz, with background noise being up to 2kHz.
# listen(pawr_seg) #Note this difference is likely due to loud footsteps in PAWR recording, while others are cleaner. I wonder if later we will find it useful to omit frequencies greater than ~10kHz?