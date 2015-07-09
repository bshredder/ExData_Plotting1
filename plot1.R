

# set working directory
# setwd("C:/Code/Data Science/Exploratory DA")


#read the test data
data <- read.table("household_power_consumption.txt", stringsAsFactors=FALSE,header=TRUE, sep=";", dec=".", na.strings= "?")

# convert data and time strings to objects
data$Date <- as.Date(data$Date,format='%d/%m/%Y')
data$Time <- strptime(data$Time,"%H:%M:%S")

# subset dataset to use only data from (Feb) 2007-02-01 and 2007-02-02.
tidyData <- subset( data, data$Date == as.Date("2007-02-01") | data$Date == as.Date("2007-02-02")  )
tidyData$Global_active_power <- as.numeric(tidyData$Global_active_power)

# Open PNG device; create 'plot1.png' in my working directory
png(file = "plot1.png", width=480, height=480 )  

# creat histogram
hist( tidyData$Global_active_power, col="red", xlab="Global Active Power (kilowatts)", main="Global Active Power")  

dev.off()