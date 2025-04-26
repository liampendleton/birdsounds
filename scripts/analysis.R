library(here)
library(tuneR)
library(dplyr)

source(here("Scripts", "processing_function.R"))
source(here("Scripts", "data_prep.R"))

mfcc_data <- process_wav(audio_list)

write.csv(mfcc_data, here("data", "output", "mfcc_data.csv"), row.names = FALSE)
