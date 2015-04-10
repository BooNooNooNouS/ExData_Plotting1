# Load the libraries that will be used
library(graphics)
library(lubridate)

# Verify the household_power_consumption file exists in the working directory 
if(!file.exists(".\\household_power_consumption.txt")){
  warning("Expected file household_power_consumption.txt doesn't exist in the current working directory.")
}

# Load the file into memory
data <- read.table("household_power_consumption.txt", 
                   header = TRUE, 
                   sep = ";", 
                   colClasses = c(rep("character", 2), rep("numeric", 5)),
                   na.strings = "?")

# Convert the Date column to a lubridate object by concatenating the Date and Time columns
data$Date <- dmy_hms(sprintf('%s %s', data$Date, data$Time))

minDate <- ymd("2007-02-01")
maxDate <- ymd("2007-02-03")

reducedData <- data[data$Date >= minDate & data$Date < maxDate, c("Date", "Global_active_power")]
remove(maxDate, minDate, data) # Clear out memory

# 2nd plot: Day of the week VS Global Active Power in KW
plot(reducedData$Date, reducedData$Global_active_power, pch=".", xlab = "", ylab = "Global Active Power (kilowatts)")
lines(reducedData$Date, reducedData$Global_active_power)