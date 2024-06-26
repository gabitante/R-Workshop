# Getting Started in R!

###########################
# 0. R is a Phenomenal Tool
###########################

# You can use R to do many types of data management and statistical analyses

# R allows you to independently investigate research questions

# R is fantastic for improving research reproducibility

# R can be really fun!

#####################
# 1. Creating Objects 
#####################

# We can create objects, which are saved in the R environment
x = 1

# You will see x appear as a value in the global environment (right)
# And in your console (below)

# Once an object is saved, we can act on that object 
x = x + 1

# And it is updated in the global environment

# Creating objects is how we work with anything (datasets, lists, vectors, values)

############################################
# 2. Installing Packages and Using Functions
############################################

# R is like a library - it can hold books (packages) that can be checked out (library())

# First, you need to install the package
# With syntax
install.packages("ggplot2")

# Or by clicking Install in the Packages tab

# When a package is installed, it will appear in the list of Packages

# However, it's not available for use yet in the current R session!

# Second, you need to use the library() function to use it (check out the book!)
library(ggplot2)

# When a package is loaded, you will see a check mark in the Packages tab next to it

########################
# 3. Reading in Datasets
########################

# You can read datasets into R in several ways

# Load needed packages to read in specific file types
library(readxl)

# We can create an object (Data) and assign our dataset to it!
Data <- read_excel("~/Desktop/R Practice Dataset.xlsx")

# Or you can use the manual import by clicking in the global environment


# You can also read other types of files - SPSS, STATA, SAS

##########################
# 4. Working with Datasets
##########################

# You can use the view function
View(Data)

# Or click on the object in your global environment

# We can obtain summary information about variables using the summary() function
summary(Data)

# We can also use calculations that only assess a single variable
summary(Data$Age)

# We can calculate the standard deviation for variables too
sd(Data$CDRSR)
sd(Data$GAD7)

# But when there is missing data, we have to adjust
sd(na.omit(Data$GAD7))

# Object can have different types
class(Data)
class(Data$Gender)

# Sometimes, we want to change variable types depending on our analyses
Data$ID <- as.character(Data$ID)
round(cor(Data), digits = 2)

# Let's switch back to numeric
Data$ID <- as.numeric(Data$ID)
round(cor(Data), digits = 2)

# We can use na.omit again to see the correlations...
round(cor(na.omit(Data)), digits = 2)

# But watch out for consequences of na.omit!
Data_omit <- na.omit(Data)

# We can create new variables in several ways
Data$NewVAR <- 1

library(dplyr)
Data <- Data %>% mutate(NewVAR2 = 1)

# Dplyr is a fantastic tool for managing datasets

#################################
# 5. Visualizing & Analyzing Data
#################################

# We can create histograms quickly
hist(Data$Age)

# But we can do more with ggplot2
# ggplot works in layers 
ggplot(data = Data, aes(x = Age, y = CDRSR)) 

ggplot(data = Data, aes(x = Age, y = CDRSR)) + geom_point() 

ggplot(data = Data, aes(x = Age, y = CDRSR)) + geom_point() + geom_smooth()

# We can also plot by group
Data$Sex <- as.factor(Data$Sex)
ggplot(data = Data, aes(x = Age, y = CDRSR, color = Sex, group = Sex)) + geom_point()

ggplot(data = Data, aes(x = Age, y = CDRSR, color = Sex, group = Sex)) + geom_point() + geom_smooth()

###################
# 6. Test Yourself!
###################

# 1
# Create a visualization for variables you're interested in
# ggplot has lots of options (barplot, boxplot, scatterplot) to try!

# 2
# Calculate mean CDRSR and GAD7 for each age
# Include number of observations for each mean (extra tricky!)

# 3
# Create a new categorical (factor) variable, "Risk", where:
# values of 0 are given for participants more than 1 SD below the mean for CDRSR and GAD7,
# values of 1 are given for participants within 1 SD of the mean for CDRSR and GAD7,
# values of 2 are given for participants more than 1 SD above the mean for CDRSR and GAD7