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
png(file="plot4.png",width=400,height=350,res=72)

## Set the parameters
par(mar = c(5,5,2,2), mfrow = c(2,2))

## Create the first graph
plot(data$Datetime, data$Global_active_power[!data$Global_active_power == "?"], 
     type = "l", xlab = "", ylab = "Global Active Power (kilowatts)")

## Create the second graph
plot(data$Datetime, data$Voltage[!data$Voltage == "?"], 
     type = "l", xlab = "datetime", ylab = "Voltage")

## Create the third graph
plot(data$Datetime, data$Sub_metering_1[!data$Sub_metering_1 == "?"], 
     type = "l", xlab = "", ylab = "Energy sub metering")
lines(data$Datetime, data$Sub_metering_2[!data$Sub_metering_2 == "?"], 
      type = "l", col = "red")
lines(data$Datetime, data$Sub_metering_3[!data$Sub_metering_3 == "?"], 
      type = "l", col = "blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       lwd = 1,
       bty = "n",
       col = c("black", "red", "blue"),
       cex = 0.75)

## Create the fourth graph
plot(data$Datetime, data$Global_reactive_power[!data$Global_reactive_power == "?"], 
     type = "l", xlab = "datetime", ylab = "Global reactive power")

## Turn off the device
dev.off()