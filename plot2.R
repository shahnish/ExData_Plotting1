## Exploratory Data Analysis - Course Project 1
## Assumption - data file "household_power_consumption.txt" and R files are in same directory and that directory is working directory


## Reading
## First read entire data file
data <- read.csv("./household_power_consumption.txt", header = TRUE, na.strings = "?", sep=";")

# Create DateTime variable which will hold POSIXct object representing date and time in local time zone. 
data$DateTime <- paste(data$Date, data$Time)
data$DateTime <- as.POSIXct(data$DateTime, format="%d/%m/%Y %H:%M:%S")

# Since we want data till end of day 2007-02-02 we will use < 2007-02-03
subsetData <- subset(data, DateTime >= "2007-02-01" & DateTime < "2007-02-03")

## We get 2880 records
# nrow(subsetData)


## Plotting

# Plot2 is line plot of Global Active Power usage during the two days.
# First plot on screen and make sure it looks like assignement
plot(subsetData$DateTime, subsetData$Global_active_power, type="l", xlab="", ylab="Global Active Power (killowatts)")

# we need to create png of the plot
# so copy to png file device 
dev.copy(device=png, filename="plot2.png", width=480, height=480)

#cleanup - one can open png file only after closing the device
dev.off()
rm(subsetData)
rm(data)
