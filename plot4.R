###### Plot 4
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
####### Plot 4
### save future file to the png plotting device
png(filename = "plot4.png")
par(mfrow = c(2,2)) ##set the 2-by-2 layout
with(new_data, plot(DateTime, Global_active_power, pch =".", ylab = "Global Active Power (kilowatts)", xlab = ""))
lines(new_data$DateTime, new_data$Global_active_power)

with(new_data, plot(DateTime, Voltage, pch = ".", ylab = "Voltage", xlab = "datetime"))
lines(new_data$DateTime, new_data$Voltage)

with(new_data, plot(DateTime, Sub_metering_1, pch = ".", ylab ="Energy sub metering", xlab = ""))
lines(new_data$DateTime, new_data$Sub_metering_1)
points(new_data$DateTime, new_data$Sub_metering_2, pch = ".", col ="red")
lines(new_data$DateTime, new_data$Sub_metering_2, col ="red")
points(new_data$DateTime, new_data$Sub_metering_3, pch = ".", col = "blue")
lines(new_data$DateTime, new_data$Sub_metering_3, col ="blue")
legend("topright", pch = ".", lty = 1, col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2","Sub_metering_3"), cex = 0.75)

with(new_data, plot(DateTime, Global_reactive_power, pch = ".", ylab = "Global_reactive_power", xlab = "datetime"))
lines(new_data$DateTime, new_data$Global_reactive_power)
dev.off()
