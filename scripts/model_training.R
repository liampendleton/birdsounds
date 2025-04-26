library(here)
library(tuneR)
library(dplyr)
library(ggplot2)
library(randomForest)

source(here("Scripts", "processing_function.R"))
source(here("Scripts", "data_prep.R"))

mfcc_data <- process_wav(audio_list)

# write.csv(mfcc_data, here("data", "output", "mfcc_data.csv"), row.names = FALSE)

mfcc_data$species <- as.factor(mfcc_data$species) #randomForest requires outcome variables be factors


#Get ready to train model
set.seed(123)

#Use 80% of data from each species recording to train
train_data <- mfcc_data %>%
  group_by(species) %>%
  slice_sample(prop = 0.8) %>%
  ungroup()

#Use remaining 20% to test
test_data <- anti_join(mfcc_data, train_data, by = c("MFCC_1", "MFCC_2", "MFCC_3", "MFCC_4", "MFCC_5", 
                                                     "MFCC_6", "MFCC_7", "MFCC_8", "MFCC_9", "MFCC_10",
                                                     "MFCC_11", "MFCC_12", "MFCC_13", "species"))

#Begin training model. Species is a function of all MFCCs (species is a function of distinct sound features)
birdsound_model <- randomForest(species ~ MFCC_1 + MFCC_2 + MFCC_3 + MFCC_4 + MFCC_5 + 
                           MFCC_6 + MFCC_7 + MFCC_8 + MFCC_9 + MFCC_10 + 
                           MFCC_11 + MFCC_12 + MFCC_13, 
                         data = train_data, 
                         importance = TRUE)

print(birdsound_model) #Note that rows in the confusion matrix are true, while columns are model predictions
saveRDS(birdsound_model, file = here("data", "output", "birdsound_model.rds"))



                                                     