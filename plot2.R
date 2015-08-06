###### Plot 2
#### Data manipulation
library(dplyr)
library(lubridate)
## Download data
download.file(url = "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", destfile = "data1.zip", method = "curl")
## Unzip data into the new directory "Course Project"
unzip("data1.zip", exdir = "./CourseProject1")
## Read a smaller dataset, which skips approximately to Feb 1 2007 and then reads around 2 days worth of data
subset_of_data<- read.table("./CourseProject1/household_power_consumption.txt", skip = 46*24*60, nrows = 55*60, sep = ";", na.strings = "?")
## Separately read in that variable names 
variable_names <- read.table("./CourseProject1/household_power_consumption.txt", header = FALSE, nrows =1, sep =";")
## Turn variable names into a vector
variable_names2 <- unlist(variable_names[1,])
## Assign a vector containing variable names to the names attribute of the subset dataset
names(subset_of_data) <- variable_names2
## Create a new column which contains full info about date and time
set<- mutate(subset_of_data, DateTime = paste(Date, "/", Time))
## Using lubridate, reformat the data contained in DateTime
set$DateTime <- dmy_hms(set$DateTime)
## Obtain the clean dataset with only relevant dates by subsetting
new_data <- subset(set, mday(DateTime) == 1|mday(DateTime) == 2)
####### Plot 2
### save future file to the png plotting device
png(filename = "plot2.png")
with(new_data, plot(DateTime, Global_active_power, pch =".", ylab = "Global Active Power (kilowatts)", xlab = ""))
lines(new_data$DateTime, new_data$Global_active_power)
dev.off()