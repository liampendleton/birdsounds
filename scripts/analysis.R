library(tuneR)
library(dplyr)

source(here("Scripts", "processing_function.R"))
source(here("Scripts", "data_prep.R"))

# Now you can call your function
mfcc_data <- process_wav(segments)

# Check it out
head(mfcc_data)
