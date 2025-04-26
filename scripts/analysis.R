library(tuneR)
library(dplyr)

source(here("Scripts", "processing_function.R"))
source(here("Scripts", "data_prep.R"))

mfcc_data <- process_wav(segments)

head(mfcc_data)
