# plot3.R
# Course 4, Week 1, Project 1

# download and unzip zipfile
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileUrl, "./powerconsumption.zip", method = "curl", mode = "wb")
unzip("./powerconsumption.zip")

# read in 2/1/2007 and 2/2/2007 dates and create data frame; Include 12:00 AM Sat to get "Sat"
data3 <- read.table("./household_power_consumption.txt", sep = ";", header = TRUE, skip = 66636, nrows = 2881, stringsAsFactors = FALSE)
header3 <- read.table("./household_power_consumption.txt", sep = ";", nrows = 1, stringsAsFactors = FALSE)
colnames(data3) <- header3
# searched for "?" (missing values) and found none in this dataset nor in full .txt file.

# Add new variable called datetime that concatenates Date and Time.  
library(dplyr)
data3 <- mutate(data3, datetime = paste(Date,Time))
data3$datetime = strptime(data3$datetime, "%d/%m/%Y %H:%M:%S")

# create plot3.png
plot.new()
png(filename = "plot3.png", width = 480, height = 480)
with(data3, plot(datetime, Sub_metering_1, type = "n", xlab = "", ylab = "Energy sub metering"))
with(data3, points(datetime, Sub_metering_1, type = "l", col = "black"))
with(data3, points(datetime, Sub_metering_2, type = "l", col = "red"))
with(data3, points(datetime, Sub_metering_3, type = "l", col = "blue"))
legend("topright", lty = c(1,1,1), col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
dev.off()