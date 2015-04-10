###############
#
# Local testing
# setwd("C:\\Users\\Karla\\OneDrive\\Documentos\\Courses\\DSc13_ExploratoryDataAnalysis\\ExData_Plotting1\\ExData_Plotting1")
#
################

# Data loading

# Verify the household_power_consumption file exists in the working directory 
if(!file.exists(".\\household_power_consumption.txt")){
  warning("Expected file household_power_consumption.txt doesn't exist in the current working directory.")
}

# Load the file into memory.  We only need data from 2007/02/01 to 2007/02/02
# TODO: Optimize by using dplyr
data <- read.table("household_power_consumption.txt", 
                   header = TRUE, 
                   sep = ";", 
                   colClasses = c(rep("character", 2), rep("numeric", 5)),
                   na.strings = "?")

# Convert the Date column to Date class and extract only the rows where the Date column is withing
# the min and max boundaries.  One thing to keep in mind is consistent date formatting, as the 
# default for the Date class is "%Y-%m-%d"
data$Date <- as.Date(data$Date, format = "%d/%m/%Y") 

minDate <- as.Date("2007-02-01")
maxDate <- as.Date("2007-02-02")

reducedData <- data[data$Date >= minDate & data$Date <= maxDate, ]
remove(maxDate, minDate, data) # Clear out memory



# Load the libraries that will be used

library(graphics)

# 1st plot: Global Active Power in KW vs Frequency
png("Plot1.png", width = 480, height = 480, bg = "transparent")
hist(reducedData$Global_active_power, 
       col = "Red", 
       main = "Global Active Power", 
       xlab = "Global Active Power (kilowatts)")
dev.off()