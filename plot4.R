# plot4.R
# Course 4, Week 1, Project 1

# download and unzip zipfile
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileUrl, "./powerconsumption.zip", method = "curl", mode = "wb")
unzip("./powerconsumption.zip")

# read in 2/1/2007 and 2/2/2007 dates and create data frame; Include 12:00 AM Sat to get "Sat"
data4 <- read.table("./household_power_consumption.txt", sep = ";", header = TRUE, skip = 66636, nrows = 2881, stringsAsFactors = FALSE)
header4 <- read.table("./household_power_consumption.txt", sep = ";", nrows = 1, stringsAsFactors = FALSE)
colnames(data4) <- header4
# searched for "?" (missing values) and found none in this dataset nor in full .txt file.

# Add new variable called datetime that concatenates Date and Time.  
library(dplyr)
data4 <- mutate(data4, datetime = paste(Date,Time))
data4$datetime = strptime(data4$datetime, "%d/%m/%Y %H:%M:%S")


# create plot4.png
plot.new()
png(filename = "plot4.png", width = 480, height = 480)
par(mfcol=c(2,2))

# cell 1, plot2
with(data4, plot(datetime, Global_active_power, type = "l", xlab = "", ylab = "Global Active Power"))

# cell 2, plot3
with(data4, plot(datetime, Sub_metering_1, type = "n", xlab = "", ylab = "Energy sub metering"))
with(data4, points(datetime, Sub_metering_1, type = "l", col = "black"))
with(data4, points(datetime, Sub_metering_2, type = "l", col = "red"))
with(data4, points(datetime, Sub_metering_3, type = "l", col = "blue"))
legend("topright", lty = c(1,1,1), bty = "n", col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

# cell 3, plot4a
with(data4, plot(datetime, Voltage, type = "l"))

# cell 4, plot4b
with(data4, plot(datetime, Global_reactive_power, type = "l"))

dev.off()