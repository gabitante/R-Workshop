# 2
# Calculate mean CDRSR and GAD7 for each age
# Include number of observations for each mean (extra tricky!)
Data %>% group_by(Age) %>% summarise(mean = mean(CDRSR), n = n())
Data %>% group_by(Age) %>% summarise(mean = mean(GAD7), n = n())

# 3
# Create a new categorical (factor) variable, "Risk", where:
# values of 0 are given for participants more than 1 SD below the mean for CDRSR and GAD7,
# values of 1 are given for participants within 1 SD of the mean for CDRSR and GAD7,
# values of 2 are given for participants more than 1 SD above the mean for CDRSR and GAD7
library(dplyr)
Data <- Data %>% mutate(Risk = case_when(
  is.na(GAD7) ~ NA_real_,
  is.na(CDRSR) ~ NA_real_,
  CDRSR < (mean(CDRSR) - sd(CDRSR)) & GAD7 < (mean(na.omit(GAD7)) - sd(na.omit(GAD7))) ~ 0,
  CDRSR > (mean(CDRSR) - sd(CDRSR)) & CDRSR < (mean(CDRSR) + sd(CDRSR)) |
    GAD7 > (mean(na.omit(GAD7)) - sd(na.omit(GAD7))) & GAD7 < (mean(na.omit(GAD7)) + sd(na.omit(GAD7))) ~ 1,
  CDRSR > (mean(CDRSR) + sd(CDRSR)) & GAD7 > (mean(na.omit(GAD7)) + sd(na.omit(GAD7))) ~ 2
))
Data$Risk <- as.factor(Data$Risk)
