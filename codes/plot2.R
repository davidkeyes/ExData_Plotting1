## Install and load the sqldf package for importing a subset of the large data file
install.packages("sqldf")
library(sqldf)

## Import the data
data <- read.csv.sql("household_power_consumption.txt", 
                     sql = "select * from file where (Date = '2/2/2007' or Date = '1/2/2007') ",
                     header = TRUE,
                     sep = ";")

## Join date and time data in single column
data$Datetime <- paste(data$Date, data$Time, sep = " ")

## Convert Datetime column to calendar object
data$Datetime <- strptime(data$Datetime, format = "%d/%m/%Y %H:%M:%S")

## Activate the png device
png(file="plot2.png",width=400,height=350,res=72)

## Create the graph
par(mar = c(5,5,2,2))
plot(data$Datetime, data$Global_active_power[!data$Global_active_power == "?"], 
     type = "l", xlab = "", ylab = "Global Active Power (kilowatts)")

## Turn off the device
dev.off()