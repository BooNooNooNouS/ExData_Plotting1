# Load the libraries that will be used
library(graphics)
library(lubridate)

# Verify the household_power_consumption file exists in the working directory 
if(!file.exists(".\\household_power_consumption.txt")){
  stop("Expected file household_power_consumption.txt doesn't exist in the current working directory.")
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

reducedData <- data[data$Date >= minDate & data$Date < maxDate, ]
remove(maxDate, minDate, data) # Clear out memory

# Plot and save to png
png("Plot4.png", width = 480, height = 480, bg = "transparent")
par(mfrow = c(2,2))

# Top left, Gloval Active power vs date
plot(reducedData$Date, reducedData$Global_active_power, pch=".", xlab = "", ylab = "Global Active Power")
lines(reducedData$Date, reducedData$Global_active_power, pch=".", xlab = "", ylab = "Global Active Power")

# Top right, Voltage VS date
plot(reducedData$Date, reducedData$Voltage, pch=".", xlab = "datetime", ylab = "Voltage")
lines(reducedData$Date, reducedData$Voltage, pch=".", xlab = "datetime", ylab = "Voltage")

# Bottom left, Energy Sub metering VS date
plot(reducedData$Date, reducedData$Sub_metering_1, pch=".", xlab = "", ylab = "Energy Sub Metering")
lines(reducedData$Date, reducedData$Sub_metering_1, col = "black")
lines(reducedData$Date, reducedData$Sub_metering_2, col = "red")
lines(reducedData$Date, reducedData$Sub_metering_3, col = "blue")
legend(
  "topright", 
  lwd=c(2.5,2.5),
  cex = 0.5,
  col=c("black", "red", "blue"), 
  legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

# Bottom right, Global reactive power VS date
plot(reducedData$Date, reducedData$Global_reactive_power, pch=".", xlab = "datetime", ylab = "Global_reactive_power")
lines(reducedData$Date, reducedData$Global_reactive_power, pch=".", xlab = "datetime", ylab = "Global_reactive_power")
dev.off()