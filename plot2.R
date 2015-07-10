#############################################################################################
##
## Exploratory Data Analysis 
## Project 1 - Plot #2
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

# convert active power values to numeric values so we can plot them
tidyData$Global_active_power <- as.numeric(tidyData$Global_active_power)

# add column that contains a date and time so that we can plot against datetime
tidyData$DateTime <- paste( as.character(tidyData$Date), tidyData$Time, sep=" ") 
tidyData$DateTime<- as.POSIXct(tidyData$DateTime)

# Open PNG device so that we can create 'plot1.png' in working directory
png(file = "plot2.png", width=480, height=480 )  

# adjust inner and outer margins so that we can make axis and labels display better
par(oma=c(4,2,0,0) )
par(mar=c(4,4.5,2,1))

# create the plot
plot( tidyData$DateTime, tidyData$Global_active_power, type="l", xlab="", ylab="Global Active Power (kilowatts)" )

dev.off()