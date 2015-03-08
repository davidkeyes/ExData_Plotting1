## Install and load the sqldf package for importing a subset of the large data file
install.packages("sqldf")
library(sqldf)

## Import the data
data <- read.csv.sql("household_power_consumption.txt", 
                     sql = "select * from file where (Date = '2/2/2007' or Date = '1/2/2007') ",
                     header = TRUE,
                     sep = ";")

## Activate the png device
png(file="plot1.png",width=400,height=350,res=72)

## Create the graph
par(mar = c(5,5,2,2))
hist(data$Global_active_power, main = "Global Active Power",
     xlab = "Global Active Power (kilowatts)", 
     ylab = "Frequency", col ="red")

## Turn off the device
dev.off()