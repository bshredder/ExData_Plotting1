#############################################################################################
##
## Exploratory Data Analysis 
## Project 1 - Plot #4
##
## Bill Schroeder
##
#############################################################################################

# set working directory
# setwd("C:/Code/Data Science/Exploratory DA")

#read the test data
data <- read.table("household_power_consumption.txt", stringsAsFactors=FALSE,header=TRUE, sep=";", dec=".", na.strings= "?")

# subset dataset to use only data from (Feb) 2007-02-01 and 2007-02-02.
data$Date <- as.Date(data$Date,format='%d/%m/%Y')
tidyData <- subset( data, data$Date == as.Date("2007-02-01") | data$Date == as.Date("2007-02-02")  )

# add column that contains a date and time so that we can plot against datetime
tidyData$DateTime <- paste( as.character(tidyData$Date), tidyData$Time, sep=" ") 
tidyData$DateTime<- as.POSIXct(tidyData$DateTime)

# convert active power values to numeric values so we can plot them
tidyData$Global_active_power <- as.numeric(tidyData$Global_active_power)

# Open PNG device so that we can create 'plot1.png' in working directory
png(file = "plot4.png", width=480, height=480 )  

# layout and draw four (4) plots
par(mfrow = c(2, 2), mar = c(5, 4, 2, 1))

# plot #1 - upper left - globalActivePlot
plot( tidyData$DateTime, tidyData$Global_active_power, type="l", xlab="", ylab="Global Active Power" )

# plot #2 - upper right - voltage 
plot( tidyData$DateTime, tidyData$Voltage, type="l", xlab="datetime", ylab="Voltage" )

# plot #3 - bottom left - energy sub metering
energySubmeterPlot() 

# plot #4 - bottom right - reactive power
plot( tidyData$DateTime, tidyData$Global_reactive_power, type="s", xlab="datetime", ylab="Global_reactive_power" )


dev.off()


reactivePowerPlot <- function(){
	plot( tidyData$DateTime, tidyData$Global_reactive_power, type="l", xlab="datetime", ylab="Global_reactive_power" )
}

voltagePlot <- function(){

	plot( tidyData$DateTime, tidyData$Voltage, type="l", xlab="datetime", ylab="Voltage" )
}

globalActivePlot <- function(){

	# convert active power values to numeric values so we can plot them
	tidyData$Global_active_power <- as.numeric(tidyData$Global_active_power)

	# create the plot
	plot( tidyData$DateTime, tidyData$Global_active_power, type="l", xlab="", ylab="Global Active Power (kilowatts)" )
}

energySubmeterPlot <- function(){
	# create the plot lines
	plot( tidyData$DateTime, tidyData$Sub_metering_1, type="l", xlab="", ylab="Energy sub metering", col="black" )
	lines(tidyData$DateTime,tidyData$Sub_metering_2,col="red")
	lines(tidyData$DateTime,tidyData$Sub_metering_3,col="blue")
	legend("topright", lty=1, col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3") )
}