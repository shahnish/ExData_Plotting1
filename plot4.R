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

# Plot4 has four graphs
# First is Global Active Power / Date
# Second is Voltage / Date
# Third is three submeters / Date 
# Fourth is Global reacive power / Date 


# First plot on screen and make sure it looks like assignement
# set par for 2 row and 2 column
par(mfrow=c(2,2))
with (subsetData, {
    # plot 1
    plot(DateTime, Global_active_power, type="l", xlab="", ylab="Global Active Power")
    # plot 2
    plot(DateTime, Voltage, type="l", xlab="datetime", ylab="Voltage")
    # plot 3
    plot(DateTime, Sub_metering_1, type="l", xlab="", ylab="Energy sub metering")
    ## We need to add lines for meter 2 and meter 3 since its overlayed on first plot
    lines(DateTime, Sub_metering_2, col="red")
    lines(DateTime, Sub_metering_3, col="blue")
    #Now add legends
    legend("topright", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col=c("black", "red", "blue"), lty=1, bty="n")
    # plot 4
    plot(DateTime, Global_reactive_power, type="l", xlab="datetime", ylab="Global_reactive_power")
    
    
    
})

# we need to create png of the plot
# so copy to png file device 
dev.copy(device=png, filename="plot4.png", width=480, height=480)

#cleanup - one can open png file only after closing the device
dev.off()
rm(subsetData)
rm(data)
