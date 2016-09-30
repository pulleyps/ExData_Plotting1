# plot1.R
# Course 4, Week 1, Project 1

# download and unzip zipfile
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileUrl, "./powerconsumption.zip", method = "curl", mode = "wb")
unzip("./powerconsumption.zip")

# read in 2/1/2007 and 2/2/2007 dates and create data frame; Include 12:00 AM Sat to get "Sat"
data1 <- read.table("./household_power_consumption.txt", sep = ";", header = TRUE, skip = 66636, nrows = 2881, stringsAsFactors = FALSE)
header1 <- read.table("./household_power_consumption.txt", sep = ";", nrows = 1, stringsAsFactors = FALSE)
colnames(data1) <- header1
# searched for "?" (missing values) and found none in this dataset nor in full .txt file.

# Add new variable called datetime that concatenates Date and Time.  
library(dplyr)

data1 <- mutate(data1, datetime = paste(Date,Time))
data1$datetime = strptime(data1$datetime, "%d/%m/%Y %H:%M:%S")

# create plot1.png
plot.new()
png(filename = "plot1.png", width = 480, height = 480)
hist(data1$Global_active_power, col = "red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)")
dev.off()